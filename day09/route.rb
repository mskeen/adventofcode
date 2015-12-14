class CityRoute
  attr_accessor :name, :distances

  def initialize(name)
    @name = name
    @distances = {}
  end

  def add_distance(name, distance)
    @distances[name] = distance
  end
end

class DistanceMapper
  def initialize
    @cities = []
  end

  def add_route(start_city, end_city, distance)
    find_city(start_city).add_distance(end_city, distance)
    find_city(end_city).add_distance(start_city, distance)
  end

  def populate
    File.read('./distances.txt').split("\n").map(&:strip).each do |line|
      m = line.match(/(?<from>.+) to (?<to>.+) = (?<distance>\d+)/)
      add_route(m["from"], m["to"], m["distance"].to_i)
    end
    self
  end

  def best_route(visited_cities, distance, best_distance, &best_calc)
    available = @cities.map(&:name) - visited_cities
    return best_calc.call([distance, best_distance]) if available.size == 0
    available.each do |next_city|
      leg_distance = visited_cities.size > 0 ? find_city(visited_cities.last).distances[next_city] : distance
      best_distance = best_route(visited_cities + [next_city], distance + leg_distance, best_distance, &best_calc)
    end
    best_distance
  end

  protected

  def find_city(name)
    @cities.each { |city| return city if city.name == name }
    city = CityRoute.new(name)
    @cities << city
    city
  end
end

begin
  dm = DistanceMapper.new.populate
  puts "Shortest route: #{dm.best_route([], 0, 10000, &:min)}"
  puts "Longest route:  #{dm.best_route([], 0, 0, &:max)}"
end

class Reindeer
  attr_accessor :name, :speed, :duration, :wait_duration, :score

  def initialize(name, speed, duration, wait_duration)
    @name = name
    @speed = speed
    @duration = duration
    @wait_duration = wait_duration
    @score = 0
  end

  def distance_after_time(seconds)
    full_cycles = seconds / cycle_length
    remaining_seconds = seconds % cycle_length
    full_cycles * (@speed * @duration) + [remaining_seconds, @duration].min * @speed
  end

  protected

  def cycle_length
    @duration + @wait_duration
  end

end

begin
  reindeer_list = []
  File.read("./input.txt").split("\n").each do |input|
    if m = input.match(/(?<name>.+) can fly (?<speed>\d+) km\/s for (?<duration>\d+) seconds, but then must rest for (?<wait_duration>\d+)/)
      reindeer_list << Reindeer.new(m["name"], m["speed"].to_i, m["duration"].to_i, m["wait_duration"].to_i)
    end
  end
  # Part A
  puts reindeer_list.map { |r| r.distance_after_time(2503) }.max

  # Part B
  (1..2503).each do |i|
    best_distance = reindeer_list.map { |r| r.distance_after_time(i) }.max
    reindeer_list.each { |r| r.score += 1 if r.distance_after_time(i) == best_distance }
  end
  puts reindeer_list.map { |r| r.score }.max
end
class SeatingOptimizer
  attr_accessor :preferences

  def initialize
    @preferences = Hash.new{|hash, key| hash[key] = Hash.new}
  end

  def add_preferences(preferences_list)
    preferences_list.each do |desc|
      parsed = desc.gsub(/(would |gain |\.)/, "").gsub("lose ", "-")
        .gsub("happiness units by sitting next to ", "")
      source, magnitude, dest = parsed.split(" ")
      @preferences[source][dest] = magnitude.to_i
    end
  end

  def add_me
    @preferences.keys.each do |key|
      @preferences["Mike"][key] = 0
      @preferences[key]["Mike"] = 0
    end
  end

  def best_path(current_path, happiness = 0, best_happiness = 0)
    available_keys = @preferences.keys - current_path
    happiness += score_for(current_path[-2], current_path.last) if current_path.size > 1
    if available_keys.empty?
      happiness += score_for(current_path.last, current_path.first)
      return [happiness, best_happiness].max
    end
    available_keys.each do |key|
      best_happiness = best_path(current_path + [key], happiness, best_happiness)
    end
    best_happiness
  end

  def optimal
    best_path([])
  end

  protected

  def score_for(source, dest)
    @preferences[source][dest] + @preferences[dest][source]
  end

end

begin
  so = SeatingOptimizer.new()
  so.add_preferences(File.read('./input.txt').split("\n"))
  so.add_me
  puts so.preferences
  puts so.optimal
end
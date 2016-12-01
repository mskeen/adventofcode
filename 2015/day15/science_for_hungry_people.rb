class ScienceForHungryPeople
  def initialize
    @ingredients = {}
  end

  def parse_input(file)
    File.read(file).split("\n").each do |ingredient|
      parsed = ingredient.match(/(?<name>.+): capacity (?<capacity>[-\d]+), durability (?<durability>[-\d]+), flavor (?<flavor>[-\d]+), texture (?<texture>[-\d]+), calories (?<calories>[-\d]+)/)
      @ingredients[parsed["name"]] = {
        capacity: parsed["capacity"].to_i,
        durability: parsed["durability"].to_i,
        flavor: parsed["flavor"].to_i,
        texture: parsed["texture"].to_i,
        calories: parsed["calories"].to_i
      }
    end
  end

  def combine(mix = {}, best_score = 0, calorie_match = 0)
    unused_ingredients = @ingredients.keys - mix.keys
    return [best_score, score(mix, calorie_match)].max if unused_ingredients.empty?
    unused_teaspoons = 100 - (mix.values.inject { |sum, i| sum + i } || 0)
    if unused_ingredients.size == 1
      best_score = combine(mix.merge(unused_ingredients.first => unused_teaspoons), best_score, calorie_match)
    else
      (0..unused_teaspoons).each do |unused|
        best_score = combine(mix.merge(unused_ingredients.first => unused), best_score, calorie_match)
      end
    end
    best_score
  end

  protected

  def score(mix, calorie_match)
    capacity = durability = flavor = texture = calories = 0
    mix.keys.each do |k|
      capacity += @ingredients[k][:capacity] * mix[k]
      durability += @ingredients[k][:durability] * mix[k]
      flavor += @ingredients[k][:flavor] * mix[k]
      texture += @ingredients[k][:texture] * mix[k]
      calories += @ingredients[k][:calories] * mix[k]
    end
    return 0 unless calorie_match == 0 || calories == calorie_match
    [capacity, 0].max * [durability, 0].max * [flavor, 0].max * [texture, 0].max
  end
end

begin
  s = ScienceForHungryPeople.new
  s.parse_input("./input.txt")

  # A
  puts s.combine

  # B
  puts s.combine({}, 0, 500)
end

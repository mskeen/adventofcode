class Character
  attr_accessor :name, :hp, :damage, :armor, :equipment

  def initialize(name, hp = 0, damage = 0, armor = 0)
    @name, @base_hp, @base_damage, @base_armor = name, hp, damage, armor
    reset
  end

  def attacked_by(opponent)
    attack_damage = [opponent.damage - @armor, 1].max
    @hp -= attack_damage
    puts "#{@name} loses #{attack_damage} to #{@hp}"
  end

  def dead?
    @hp <= 0
  end

  def battle(opponent, equipment, best_win, worst_loss)
    reset
    opponent.reset
    equipment.each { |item| add_equipment(item) }
    loop do
      opponent.attacked_by(self)
      return [[best_win || 1000, equipment_cost].min, worst_loss] if opponent.dead?
      self.attacked_by(opponent)
      return [best_win, [worst_loss, equipment_cost].max] if self.dead?
    end
  end

  def reset
    @hp, @damage, @armor = @base_hp, @base_damage, @base_armor
    @equipment = []
  end

  def equipment_cost
    @equipment.inject(0) { |sum, item| sum + item.cost }
  end

  private

  def add_equipment(item)
    @equipment << item
    @damage += item.damage
    @armor += item.armor
  end
end

class Equipment
  attr_accessor :name, :cost, :damage, :armor

  def initialize(name, cost, damage, armor)
    @name, @cost, @damage, @armor = name, cost, damage, armor
  end
end

# must use 1 weapon
weapons = [
  Equipment.new("Dagger", 8, 4, 0),
  Equipment.new("Shortsword", 10, 5, 0),
  Equipment.new("Warhammer", 25, 6, 0),
  Equipment.new("Longsword", 40, 7, 0),
  Equipment.new("Greataxe", 74, 8, 0)
]

# may use 0 or 1 armor
armors = [
  Equipment.new("Leather", 13, 0, 1),
  Equipment.new("Chainmail", 31, 0, 2),
  Equipment.new("Splintmail", 53, 0, 3),
  Equipment.new("Bandedmail", 75, 0, 4),
  Equipment.new("Platemail", 102, 0, 5)
]

# may use 0 to 2 rings
rings = [
  Equipment.new("Damage +1", 25, 1, 0),
  Equipment.new("Damage +2", 50, 2, 0),
  Equipment.new("Damage +3", 100, 3, 0),
  Equipment.new("Defense +1", 20, 0, 1),
  Equipment.new("Defense +2", 40, 0, 2),
  Equipment.new("Defense +3", 80, 0, 3)
]

begin
  boss = Character.new("Boss", 103, 9, 2)
  player = Character.new("Player", 100, 0, 0)

  best_win = nil
  worst_loss = 0
  weapons.each do |weapon|
    # no armor, no rings
    best_win, worst_loss = player.battle(boss, [weapon], best_win, worst_loss)

    # try each armor
    armors.each do |armor|
      # no rings
      best_win, worst_loss = player.battle(boss, [weapon, armor], best_win, worst_loss)

      # try 1 ring
      rings.each do |ring|
        best_win, worst_loss = player.battle(boss, [weapon, armor, ring], best_win, worst_loss)

        #try with a 2nd ring
        rings.each do |ring2|
          if ring != ring2
            best_win, worst_loss = player.battle(boss, [weapon, armor, ring, ring2], best_win, worst_loss)
          end
        end
      end
    end
  end

  puts best_win
  puts worst_loss
end

class Battle
  attr_accessor :hp, :mana, :boss_hp, :boss_damage, :effects, :mana_spent,
                :status, :history, :hard_mode

  SPELLS = {
    magic_missile: { cost: 53, operation: -> (battle) {} },
    drain: { cost: 73, operation: -> (battle) {} },
    shield: { cost: 113, operation: -> (battle) {} },
    poison: { cost: 173, operation: -> (battle) {} },
    recharge: { cost: 229, operation: -> (battle) {} }
  }

  def initialize(hp, mana, boss_hp, boss_damage, effects, mana_spent, history = [], hard_mode = false)
    @hp, @mana, @effects, @mana_spent = hp, mana, effects, mana_spent
    @boss_hp, @boss_damage = boss_hp, boss_damage
    @history = history
    @hard_mode = hard_mode
  end

  def stats
    debug ""
    debug "Player: #{@hp} hp, #{@mana} mana, #{@effects} effects"
    debug "  Boss: #{@boss_hp} hp, #{@boss_damage} damage"
  end

  def execute(spell)
    @status = execute_turn(spell)
  end

  def execute_turn(spell)
    stats
    @hp -= 1 if @hard_mode
    return :loss if @hp <= 0

    cast(spell)
    history << spell
    return :win if @boss_hp <= 0

    stats
    apply_effects
    return :win if @boss_hp <= 0
    boss_attack
    return :loss if @hp <= 0

    # set up next turn
    apply_effects
    return :loss if @mana < 53

    :in_progress
  end

  def cast(spell)
    debug "Cast spell: #{spell}.  Mana cost: #{SPELLS[spell][:cost]}"
    @mana -= SPELLS[spell][:cost]
    @mana_spent += SPELLS[spell][:cost]
    case spell
    when :magic_missile
      debug "  4 damage to Boss"
      @boss_hp -= 4
    when :drain
      debug "  2 damage to Boss, +2 health for Player"
      @boss_hp -= 2
      @hp += 2
    when :shield
      6.times { effects << spell }
    when :poison
      6.times { effects << spell }
    when :recharge
      5.times { effects << spell }
    else
      debug "Unkown spell: #{spell}"
    end
  end

  def apply_effects
    effects.uniq.each do |effect|
      case effect
      when :shield
        debug "Shield Effect sets armor to 7."
      when :poison
        debug "Poison Effect causes 3 damage to Boss."
        @boss_hp -= 3
      when :recharge
        debug "Recharge Effect adds 101 mana to Player."
        @mana += 101
      else
        debug "Unknown Effect: #{effect}"
      end
      effects.delete_at(effects.index(effect))
    end
  end

  def boss_attack
    armor = effects.include?(:shield) ? 7 : 0
    damage = [@boss_damage - armor, 1].max
    @hp -= damage
    debug "Boss dealt #{damage} to Player"
  end

  def available_spells
    SPELLS.keys.reject do |k|
      effects.count(k) > 1 || @mana < SPELLS[k][:cost]
    end
  end

  def debug(output)
    # puts output
  end
end

def try_all(b, best_mana_used)
  b.available_spells.each do |spell|
    new_battle = Battle.new(b.hp, b.mana, b.boss_hp, b.boss_damage, b.effects.dup, b.mana_spent, b.history.dup, b.hard_mode)
    new_battle.execute(spell)
    if new_battle.mana_spent < best_mana_used
      case new_battle.status
      when :win
        best_mana_used = [new_battle.mana_spent, best_mana_used].min
      when :in_progress
        best_mana_used = try_all(new_battle, best_mana_used)
      end
    end
  end
  best_mana_used
end

begin
  # best_mana_used = try_all(Battle.new(50, 500, 55, 8, [], 0, [], false), 9999)
  # puts "BEST for easy mode: #{best_mana_used}"

  best_mana_used = try_all(Battle.new(50, 500, 55, 8, [], 0, [], true), 9999)
  puts "BEST for hard mode: #{best_mana_used}"
end
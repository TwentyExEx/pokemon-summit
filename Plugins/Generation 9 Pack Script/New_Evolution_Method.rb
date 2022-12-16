#===============================================================================
# New Evolution methods
#===============================================================================
GameData::Evolution.register({
  :id            => :LevelUseMoveCount,
  :parameter     => :Move,
  :minimum_level        => 1,   # Needs any level up
  :level_up_proc        => proc { |pkmn, parameter|
    next pkmn.get_move_count(parameter) >= 20
  },
})
GameData::Evolution.register({
  :id            => :LevelWithPartner,
  :parameter     => Integer,
  :level_up_proc        => proc { |pkmn, parameter|
    next pkmn.level >= parameter && $PokemonGlobal.partner
  },
})
GameData::Evolution.register({
  :id            => :Walk,
  :parameter     => Integer,
  :minimum_level        => 1,   # Needs any level up
  :level_up_proc        => proc { |pkmn, parameter|
    next pkmn.step_count >= parameter
  },
})
GameData::Evolution.register({
  :id            => :CollectItems,
  :parameter     => :Item,
  :minimum_level => 1,   # Needs any level up
  :level_up_proc => proc { |pkmn, parameter|
    next $bag.quantity(parameter) >= 999
  }
})
GameData::Evolution.register({
  :id            => :LevelDefeatItsKindWithItem,
  :parameter     => :Item,
  :minimum_level        => 1,   # Needs any level up
  :level_up_proc        => proc { |pkmn, parameter|
    next pkmn.defeated_species && pkmn.defeated_species(pkmn.species) >= 3
  },
})
GameData::Evolution.register({
  :id            => :LevelRecoilDamage,
  :parameter     => Integer,
  :minimum_level        => 1,   # Needs any level up
  :level_up_proc        => proc { |pkmn, parameter|
    next pkmn.recoil_dmg_taken && pkmn.recoil_dmg_taken >= parameter
  },
})
#===============================================================================
# Multiple forms and Regional forms Handler
#===============================================================================
MultipleForms.register(:TAUROS, {
  "getFormOnEggCreation" => proc { |pkmn|
    if $game_map
      map_pos = $game_map.metadata&.town_map_position
      if map_pos && map_pos[0] == 1
        # for now tauros rare breed only able to encountered 10%
        if rand(100) < 10
          next rand(2)+2
        else
          next 1
        end
      end
    end
    next 0
  }
})

MultipleForms.copy(:RATTATA,:WOOPER,:QUILAVA,:DEWOTT,:PETILIL,:RUFFLET,:GOOMY,:BERGMITE,:DARTRIX)

MultipleForms.register(:LECHONK, {
  "getFormOnCreation" => proc { |pkmn|
    next pkmn.gender
  }
})

MultipleForms.copy(:LECHONK,:OINKOLOGNE)

MultipleForms.register(:BASCULEGION, {
  "getForm" => proc { |pkmn|
    next pkmn.gender
  },

  "getFormOnCreation" => proc { |pkmn|
    next pkmn.gender
  }
})

MultipleForms.register(:TANDEMAUS, {
  "getFormOnCreation" => proc { |pkmn|
    next (pkmn.personalID % 100 == 0) ? 1 : 0
  }
})
MultipleForms.copy(:TANDEMAUS,:MAUSHOLD,:DUNSPARCE,:DUDUNSPARCE)

MultipleForms.register(:SQWARKABILLY, {
  "getFormOnCreation" => proc { |pkmn|
    next rand(4)
  }
})
#===============================================================================
# Pokemon Attribute
#===============================================================================
class Pokemon
  attr_reader :used_move_count, :step_count, :defeated_species, :recoil_dmg_taken, :size
  def use_move(move,qty=1)
    @used_move_count = {} if !@used_move_count
    @used_move_count[move] = 0 if !@used_move_count[move]
    @used_move_count[move] += qty
  end
  def get_move_count(move)
    @used_move_count = {} if !@used_move_count
    @used_move_count[move] = 0 if !@used_move_count[move]
    return @used_move_count[move]
  end
  def add_step(i=1)
    @step_count = 0 if !@step_count
    @step_count += i
  end
  def add_defeated_species(species,qty=1)
    @defeated_species = {} if !@defeated_species
    @defeated_species[species] = 0 if !@defeated_species[species]
    @defeated_species[species] += qty
  end
  def defeated_species(species)
    @defeated_species = {} if !@defeated_species
    @defeated_species[species] = 0 if !@defeated_species[species]
    return @defeated_species[species]
  end
  def add_recoil_dmg_taken(qty=1)
    @recoil_dmg_taken = 0 if !@recoil_dmg_taken
    @recoil_dmg_taken += qty
  end
end

# Defeated species method for bisharp
class Battle
  alias bisharp_pbSetDefeated pbSetDefeated
  def pbSetDefeated(battler)
    return if !battler || !@internalBattle
    # echoln [@lastMoveUser,battler.lastAttacker,battler.lastFoeAttacker,battler.lastHPLostFromFoe]
    attacker = @battlers[battler.lastAttacker[0]]
    evo = GameData::Species.get_species_form(attacker.species,attacker.form).get_evolutions
    evo.each{|e|
      case e[1]
      when :LevelDefeatItsKindWithItem
        next if battler.item != e[2]
        next if battler.species != attacker.species
      end
      attacker.pokemon.add_defeated_species(battler.species)
    }
    bisharp_pbSetDefeated(battler)
  end
end

# Walk method for pawmo, rellor, and bramblin
EventHandlers.add(:on_player_step_taken, :gain_steps,
  proc {
    $player.able_party.each_with_index do |pkmn,i|
      pkmn.add_step
      break
    end
  }
)
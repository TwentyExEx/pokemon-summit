#===============================================================================
# Held Items
#===============================================================================
Battle::ItemEffects::DamageCalcFromUser.copy(:GRISEOUSORB, :GRISEOUSCORE)
Battle::ItemEffects::DamageCalcFromUser.copy(:ADAMANTORB, :ADAMANTCRYSTAL)
Battle::ItemEffects::DamageCalcFromUser.copy(:LUSTROUSORB, :LUSTROUSGLOBE)
Battle::ItemEffects::DamageCalcFromUser.copy(:SILKSCARF, :BLANKPLATE)
#===============================================================================
# Poke Ball Items
#===============================================================================
Battle::PokeBallEffects::ModifyCatchRate.add(:HISUIANPOKEBALL, proc { |ball, catchRate, battle, battler|
  next catchRate * 0.75
})

Battle::PokeBallEffects::ModifyCatchRate.add(:HISUIANGREATBALL, proc { |ball, catchRate, battle, battler|
  next catchRate * 1.5
})

Battle::PokeBallEffects::ModifyCatchRate.add(:HISUIANULTRABALL, proc { |ball, catchRate, battle, battler|
  next catchRate * 2.25
})

Battle::PokeBallEffects::ModifyCatchRate.add(:FEATHERBALL, proc { |ball, catchRate, battle, battler|
  # catchRate *= multiplier if battler.pbHasType?(:BUG) || battler.pbHasType?(:WATER)
  next catchRate
})

Battle::PokeBallEffects::ModifyCatchRate.add(:WINGBALL, proc { |ball, catchRate, battle, battler|
  next catchRate * 1.5
})

Battle::PokeBallEffects::ModifyCatchRate.add(:JETBALL, proc { |ball, catchRate, battle, battler|
  next catchRate * 2
})

Battle::PokeBallEffects::ModifyCatchRate.add(:HISUIANHEAVYBALL, proc { |ball, catchRate, battle, battler|
  next catchRate * 1
})

Battle::PokeBallEffects::ModifyCatchRate.add(:LEADENBALL, proc { |ball, catchRate, battle, battler|
  next catchRate * 1.75
})

Battle::PokeBallEffects::ModifyCatchRate.add(:GIGATONBALL, proc { |ball, catchRate, battle, battler|
  next catchRate * 2.5
})

Battle::PokeBallEffects::ModifyCatchRate.add(:STRANGEBALL, proc { |ball, catchRate, battle, battler|
  next catchRate * 0.75
})
#===============================================================================
# Multiple Form
#===============================================================================
MultipleForms.register(:GIRATINA, {
  "getForm" => proc { |pkmn|
    next 1 if pkmn.hasItem?(:GRISEOUSORB) || pkmn.hasItem?(:GRISEOUSCORE)
    if $game_map &&
       GameData::MapMetadata.get($game_map.map_id)&.has_flag?("DistortionWorld")
      next 1
    end
    next 0
  }
})
MultipleForms.register(:DIALGA, {
  "getForm" => proc { |pkmn|
    next 1 if pkmn.hasItem?(:ADAMANTCRYSTAL)
    next 0
  }
})
MultipleForms.register(:PALKIA, {
  "getForm" => proc { |pkmn|
    next 1 if pkmn.hasItem?(:LUSTROUSGLOBE)
    next 0
  }
})

#===============================================================================
# Evolution Items
#===============================================================================
GameData::Evolution.register({
  :id            => :TradeSpecies,
  :parameter     => :Species,
  :on_trade_proc => proc { |pkmn, parameter, other_pkmn|
    next false if other_pkmn.nil?
    next pkmn.species == parameter && !other_pkmn.hasItem?(:EVERSTONE)
  }
})

class Pokemon
  def check_evolution_on_use_item(item_used)
    return check_evolution_internal { |pkmn, new_species, method, parameter|
      if item_used == :LINKINGCORD
        success = GameData::Evolution.get(method).call_on_trade(pkmn, parameter, nil)
      else
        success = GameData::Evolution.get(method).call_use_item(pkmn, parameter, item_used)
      end
      next (success) ? new_species : nil
    }
  end
end
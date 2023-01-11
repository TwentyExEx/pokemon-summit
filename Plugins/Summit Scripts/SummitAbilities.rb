#===============================================================================
# Modernize
#===============================================================================
Battle::AbilityEffects::ModifyMoveBaseType.add(:MODERNIZE,
  proc { |ability, user, move, type|
    next if type != :NORMAL || !GameData::Type.exists?(:FIGHTING) || !GameData::Type.exists?(:FAIRY)
    move.powerBoost = true
    next :FIGHTING if move.physicalMove?
    next :FAIRY if move.specialMove?
  }
)

#===============================================================================
# Demonize
#===============================================================================
Battle::AbilityEffects::ModifyMoveBaseType.add(:DEMONIZE,
  proc { |ability, user, move, type|
    next if type != :NORMAL || !GameData::Type.exists?(:DARK)
    move.powerBoost = true
    next :DARK
  }
)

#===============================================================================
# Parasitic Vine
#===============================================================================
Battle::AbilityEffects::OnDealingHit.add(:PARASITICVINE,
  proc { |ability, user, target, move, battle|
  next false if !move.damagingMove?
  next false if move.type != :GRASS
  next false if move.id == :ABSORB || move.id == :MEGADRAIN || move.id == :GIGADRAIN
    changehp=(target.damageState.hpLost / 2.0).round
    changehp*=1.3 if user.hasActiveItem?(:BIGROOT)
    if target.hasActiveAbility?(:LIQUIDOOZE) && target.abilityActive?(true)
      battle.pbShowAbilitySplash(user)
      battle.pbShowAbilitySplash(target)
      user.pbReduceHP(changehp,true)
      if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("{1} sucked up the liquid ooze!",user.pbThis))
      end
      battle.pbHideAbilitySplash(user)
      battle.pbHideAbilitySplash(target)
      user.pbFaint if user.fainted?
      next
    else
      if user.canHeal?
        battle.pbShowAbilitySplash(user)
        user.pbRecoverHP(changehp,true)
        battle.pbDisplay(_INTL("{1} drained HP with {2}!",user.pbThis,user.abilityName))
        battle.pbHideAbilitySplash(user)
      end
    end
  }
)

#===============================================================================
# Clear Mind
#===============================================================================
Battle::AbilityEffects::DamageCalcFromUser.add(:CLEARMIND,
  proc { |ability, user, target, move, mults, baseDmg, type|
    mults[:base_damage_multiplier] *= 1.5 if move.type == :PSYCHIC
  }
)

Battle::AbilityEffects::PriorityChange.add(:CLEARMIND,
  proc { |ability, battler, move, pri|
    next pri + 1 if move.type == :PSYCHIC
  }
)

#===============================================================================
# Draining Touch
#===============================================================================
Battle::AbilityEffects::OnDealingHit.add(:DRAININGTOUCH,
  proc { |ability, user, target, move, battle|
  next false if !move.contactMove?
    changehp=(user.totalhp / 16)
    if target.hasActiveAbility?(:LIQUIDOOZE) && target.abilityActive?(true)
      battle.pbShowAbilitySplash(user)
      battle.pbShowAbilitySplash(target)
      user.pbReduceHP(changehp,true)
      if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("{1} sucked up the liquid ooze!",user.pbThis))
      end
      battle.pbHideAbilitySplash(user)
      battle.pbHideAbilitySplash(target)
      user.pbFaint if user.fainted?
      next
    else
      if user.canHeal?
        battle.pbShowAbilitySplash(user)
        user.pbRecoverHP(changehp,true)
        battle.pbDisplay(_INTL("{1} drained HP with {2}!",user.pbThis,user.abilityName))
        battle.pbHideAbilitySplash(user)
      end
    end
  }
)

#===============================================================================
# Thunder Legs
#===============================================================================
Battle::AbilityEffects::DamageCalcFromUser.add(:THUNDERLEGS,
  proc { |ability, user, target, move, mults, baseDmg, type|
    mults[:base_damage_multiplier] *= 1.3 if move.kickMove?
  }
)

#===============================================================================
# Deep Puddle
#===============================================================================
Battle::AbilityEffects::TrappingByTarget.add(:DEEPPUDDLE,
  proc { |ability, switcher, bearer, battle|
    next true if switcher.pbHasType?(:WATER)
  }
)

#===============================================================================
# War Coat
#===============================================================================
Battle::AbilityEffects::OnBeingHit.add(:STAMINA,
  proc { |ability, user, target, move, battle|
  next if !move.specialMove?
    target.pbRaiseStatStageByAbility(:ATTACK, 1, target)
  }
)

#===============================================================================
# Deluge Power
#===============================================================================
Battle::AbilityEffects::DamageCalcFromUser.add(:DELUGEPOWER,
  proc { |ability, user, target, move, mults, baseDmg, type|
    if move.specialMove? && [:Rain, :HeavyRain].include?(user.effectiveWeather)
      mults[:attack_multiplier] *= 1.5
    end
  }
)

Battle::AbilityEffects::EndOfRoundWeather.add(:DELUGEPOWER,
  proc { |ability, weather, battler, battle|
    next unless [:Rain, :HeavyRain].include?(weather)
    battle.pbShowAbilitySplash(battler)
    battle.scene.pbDamageAnimation(battler)
    battler.pbReduceHP(battler.totalhp / 8, false)
    battle.pbDisplay(_INTL("{1} was hurt by the rainfall!", battler.pbThis))
    battle.pbHideAbilitySplash(battler)
    battler.pbItemHPHealCheck
  }
)

#===============================================================================
# Grass Fury
#===============================================================================
Battle::AbilityEffects::DamageCalcFromUser.add(:GRASSFURY,
  proc { |ability, user, target, move, mults, baseDmg, type|
    if move.specialMove? && battler.battle.field.terrain == :Grassy
      mults[:attack_multiplier] *= 2
    end
  }
)

#===============================================================================
# Volt Striker
#===============================================================================
Battle::AbilityEffects::DamageCalcFromUser.add(:VOLTSTRIKER,
  proc { |ability, user, target, move, mults, baseDmg, type|
    if move.physicalMove? && battler.battle.field.terrain == :Electric
      mults[:attack_multiplier] *= 1.5
    end
  }
)

Battle::AbilityEffects::EndOfRoundHealing.add(:VOLTSTRIKER,
  proc { |ability, weather, battler, battle|
    next if !battler.battle.field.terrain == :Electric
    battle.pbShowAbilitySplash(battler)
    battle.scene.pbDamageAnimation(battler)
    battler.pbReduceHP(battler.totalhp / 8, false)
    battle.pbDisplay(_INTL("{1} was hurt by the terrain!", battler.pbThis))
    battle.pbHideAbilitySplash(battler)
    battler.pbItemHPHealCheck
  }
)

#===============================================================================
# Insectivorous
#===============================================================================
Battle::AbilityEffects::MoveImmunity.add(:INSECTIVOROUS,
  proc { |ability, user, target, move, type, battle, show_message|
    next target.pbMoveImmunityStatRaisingAbility(user, move, type,
       :BUG, :ATTACK, 1, show_message)
  }
)

#===============================================================================
# Heat Sink
#===============================================================================
Battle::AbilityEffects::MoveImmunity.add(:HEATSINK,
  proc { |ability, user, target, move, type, battle, show_message|
    next target.pbMoveImmunityStatRaisingAbility(user, move, type,
       :FIRE, :ATTACK, 1, show_message)
  }
)

Battle::AbilityEffects::AccuracyCalcFromTarget.add(:HEATSINK,
  proc { |ability, mods, user, target, move, type|
    mods[:base_accuracy] = 0 if type == :FIRE
  }
)

#===============================================================================
# Unrelenting Flame
#===============================================================================

Battle::AbilityEffects::CriticalCalcFromUser.add(:UNRELENTINGFLAME,
  proc { |ability, user, target, c|
    next 99 if target.burned?
  }
)

#===============================================================================
# Kilkenny Cat
#===============================================================================
Battle::AbilityEffects::MoveImmunity.add(:KILKENNYCAT,
  proc { |ability, user, target, move, type, battle, show_message|
    next target.pbMoveImmunityStatRaisingAbility(user, move, type,
       :FIGHTING, :ATTACK, 1, show_message)
  }
)

Battle::AbilityEffects::AccuracyCalcFromTarget.add(:KILKENNYCAT,
  proc { |ability, mods, user, target, move, type|
    mods[:base_accuracy] = 0 if type == :FIGHTING
  }
)

#===============================================================================
# Hail Hurl
#===============================================================================

Battle::AbilityEffects::OnBeingHit.add(:HAILHURL,
  proc { |ability, user, target, move, battle|
    battle.pbStartWeatherAbility(:Hail, target)
  }
)

Battle::AbilityEffects::DamageCalcFromTarget.add(:HAILHURL,
  proc { |ability, user, target, move, mults, baseDmg, type|
    mults[:final_damage_multiplier] /= 2 if type == :ICE
  }
)

#===============================================================================
# Sunny Sputum
#===============================================================================

Battle::AbilityEffects::OnBeingHit.add(:SUNNYSPUTUM,
  proc { |ability, user, target, move, battle|
    battle.pbStartWeatherAbility(:Sun, target)
  }
)

Battle::AbilityEffects::DamageCalcFromTarget.add(:SUNNYSPUTUM,
  proc { |ability, user, target, move, mults, baseDmg, type|
    mults[:final_damage_multiplier] /= 2 if type == :FIRE
  }
)

#===============================================================================
# Drizzle Dribble
#===============================================================================

Battle::AbilityEffects::OnBeingHit.add(:DRIZZLEDRIBBLE,
  proc { |ability, user, target, move, battle|
    battle.pbStartWeatherAbility(:Rain, target)
  }
)

Battle::AbilityEffects::DamageCalcFromTarget.add(:DRIZZLEDRIBBLE,
  proc { |ability, user, target, move, mults, baseDmg, type|
    mults[:final_damage_multiplier] /= 2 if type == :WATER
  }
)

#===============================================================================
# Spark Starter
#===============================================================================

Battle::AbilityEffects::OnBeingHit.add(:SPARKSTARTER,
  proc { |ability, user, target, move, battle|
    next if !move.damagingMove?
    next if battle.field.terrain == :Electric
    battle.pbShowAbilitySplash(target)
    battle.pbDisplay(_INTL("An electric current runs across the battlefield!"))
    battle.pbStartTerrain(target, :Electric)
  }
)

Battle::AbilityEffects::DamageCalcFromTarget.add(:SPARKSTARTER,
  proc { |ability, user, target, move, mults, baseDmg, type|
    mults[:final_damage_multiplier] /= 2 if type == :ELECTRIC
  }
)

#===============================================================================
# Steam Sprinkler
#===============================================================================

Battle::AbilityEffects::OnBeingHit.add(:STEAMSPRINKLER,
  proc { |ability, user, target, move, battle|
    next if !move.damagingMove?
    next if battle.field.terrain == :Misty
    battle.pbShowAbilitySplash(target)
    battle.pbDisplay(_INTL("Mist swirled about the battlefield!"))
    battle.pbStartTerrain(target, :Misty)
  }
)

Battle::AbilityEffects::DamageCalcFromTarget.add(:STEAMSPRINKLER,
  proc { |ability, user, target, move, mults, baseDmg, type|
    mults[:final_damage_multiplier] /= 2 if type == :FAIRY
  }
)

#===============================================================================
# Psyche Spreader
#===============================================================================

Battle::AbilityEffects::OnBeingHit.add(:PSYCHESPREADER,
  proc { |ability, user, target, move, battle|
    next if !move.damagingMove?
    next if battle.field.terrain == :Psychic
    battle.pbShowAbilitySplash(target)
    battle.pbDisplay(_INTL("The battlefield got weird!"))
    battle.pbStartTerrain(target, :Psychic)
  }
)

Battle::AbilityEffects::DamageCalcFromTarget.add(:PSYCHESPREADER,
  proc { |ability, user, target, move, mults, baseDmg, type|
    mults[:final_damage_multiplier] /= 2 if type == :PSYCHIC
  }
)


#===============================================================================
# Additions to Seed Sower
#===============================================================================

Battle::AbilityEffects::DamageCalcFromTarget.add(:SEEDSOWER,
  proc { |ability, user, target, move, mults, baseDmg, type|
    mults[:final_damage_multiplier] /= 2 if type == :GRASS
  }
)

#===============================================================================
# Additions to Sand Spit
#===============================================================================

Battle::AbilityEffects::DamageCalcFromTarget.add(:SANDSPIT,
  proc { |ability, user, target, move, mults, baseDmg, type|
    mults[:final_damage_multiplier] /= 2 if type == :GROUND
  }
)

#===============================================================================
# Sharpshooter
#===============================================================================

Battle::AbilityEffects::DamageCalcFromUser.add(:SHARPSHOOTER,
  proc { |ability, user, target, move, mults, baseDmg, type|
    mults[:base_damage_multiplier] *= 1.3 if move.bombMove?
  }
)
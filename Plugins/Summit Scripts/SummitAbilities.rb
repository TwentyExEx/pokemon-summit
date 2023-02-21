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

#===============================================================================
# Hail to the King
#===============================================================================
Battle::AbilityEffects::DamageCalcFromUser.add(:HAILTOTHEKING,
  proc { |ability, user, target, move, mults, baseDmg, type|
    user.effects[PBEffects::HailToTheKing] = 0 if user.effects[PBEffects::HailToTheKing].nil?
    next if user.effects[PBEffects::HailToTheKing] <= 0
    mult = 1
    mult += 0.1 * user.effects[PBEffects::HailToTheKing]
    mults[:attack_multiplier] *= mult if move.physicalMove?
  }
)

Battle::AbilityEffects::OnSwitchIn.add(:HAILTOTHEKING,
  proc { |ability, battler, battle, switch_in|
  poisonList = []
  numPsn = 0
  tempParty = $Trainer.party.clone
  tempParty.delete_at(0) # Ignore user
  for pkmn in tempParty
    next if !pkmn.able? || pkmn.status != :NONE || !pkmn.types.include?(:POISON)
    numPsn += 1
  end
  numPsn = 5 if numPsn > 5
  next if numPsn <= 0
  battle.pbShowAbilitySplash(battler)
  battle.pbDisplay(_INTL("{1}'s physical power was boosted by its royalty!", battler.pbThis))
  battler.effects[PBEffects::HailToTheKing] = numPsn
  battle.pbHideAbilitySplash(battler)
  }
)

#===============================================================================
# Hail to the Queen
#===============================================================================
Battle::AbilityEffects::DamageCalcFromUser.add(:HAILTOTHEQUEEN,
  proc { |ability, user, target, move, mults, baseDmg, type|
    user.effects[PBEffects::HailToTheQueen] = 0 if user.effects[PBEffects::HailToTheQueen].nil?
    next if user.effects[PBEffects::HailToTheQueen] <= 0
    mult = 1
    mult += 0.1 * user.effects[PBEffects::HailToTheQueen]
    mults[:defense_multiplier] *= mult
  }
)

Battle::AbilityEffects::OnSwitchIn.add(:HAILTOTHEQUEEN,
  proc { |ability, battler, battle, switch_in|
  poisonList = []
  numPsn = 0
  tempParty = $Trainer.party.clone
  tempParty.delete_at(0) # Ignore user
  for pkmn in tempParty
    next if !pkmn.able? || pkmn.status != :NONE || !pkmn.types.include?(:POISON)
    numPsn += 1
  end
  numPsn = 5 if numPsn > 5
  next if numPsn <= 0
  battle.pbShowAbilitySplash(battler)
  battle.pbDisplay(_INTL("{1}'s physical defense was boosted by its royalty!", battler.pbThis))
  battler.effects[PBEffects::HailToTheQueen] = numPsn
  battle.pbHideAbilitySplash(battler)
  }
)

#===============================================================================
# War Forged
#===============================================================================

Battle::AbilityEffects::OnBeingHit.add(:WARFORGED,
  proc { |ability, user, target, move, battle|
    next if !move.physicalMove?
    next if !target.pbCanLowerStatStage?(:DEFENSE, target) &&
            !target.pbCanRaiseStatStage?(:ATTACK, target)
    battle.pbShowAbilitySplash(target)
    target.pbLowerStatStageByAbility(:DEFENSE, 1, target, false)
    target.pbRaiseStatStageByAbility(:ATTACK, 1, target, false)
    battle.pbHideAbilitySplash(target)
  }
)

#===============================================================================
# Flutter Wing
#===============================================================================

Battle::AbilityEffects::PriorityChange.add(:FLUTTERWING,
  proc { |ability, battler, move, pri|
    next pri + 1 if (Settings::MECHANICS_GENERATION <= 6 || battler.hp == battler.totalhp) &&
                    move.type == :BUG
  }
)

#===============================================================================
# Imbalance
#===============================================================================

Battle::AbilityEffects::OnBeingHit.add(:IMBALANCE,
  proc { |ability, user, target, move, battle|
    next if !move.pbContactMove?(user)
    next if battle.pbRandom(100) >= 30
    battle.pbShowAbilitySplash(target)
    if user.pbCanConfuse?(target, Battle::Scene::USE_ABILITY_SPLASH) &&
       user.affectedByContactEffect?(Battle::Scene::USE_ABILITY_SPLASH)
      msg = nil
      if Battle::Scene::USE_ABILITY_SPLASH
        msg = _INTL("{1}'s {2} put {3} off balance! It may hit itself in confusion!",
           target.pbThis, target.abilityName, user.pbThis(true))
      end
      user.pbConfuse(msg)
    end
    battle.pbHideAbilitySplash(target)
  }
)

#===============================================================================
# Cacaphony
#===============================================================================

Battle::AbilityEffects::DamageCalcFromUser.add(:CACAPHONY,
  proc { |ability, user, target, move, mults, baseDmg, type|
    user.effects[PBEffects::Cacaphony] = 0 if user.effects[PBEffects::Cacaphony].nil?
    if move.soundMove?
      chain = 1 + (0.1 * [user.effects[PBEffects::Cacaphony], 5].min)
      mults[:final_damage_multiplier] *= chain
    end
  }
)

Battle::AbilityEffects::OnEndOfUsingMove.add(:CACAPHONY,
  proc { |ability, user, target, move, battle|
    if !move.soundMove? && user.effects[PBEffects::Cacaphony] > 0
      battle.pbShowAbilitySplash(user)
      battle.pbDisplay(_INTL("{1}'s {2} dissipates.", user.pbThis, user.abilityName))
      user.effects[PBEffects::Cacaphony] = 0
      battle.pbHideAbilitySplash(user)
    else
      battle.pbShowAbilitySplash(user)
      battle.pbDisplay(_INTL("{1}'s {2} gets louder!", user.pbThis, user.abilityName))
      user.effects[PBEffects::Cacaphony] += 1
      battle.pbHideAbilitySplash(user)
    end
  }
)

#===============================================================================
# Honey Honcho
#===============================================================================
Battle::AbilityEffects::DamageCalcFromUser.add(:HONEYHONCHO,
  proc { |ability, user, target, move, mults, baseDmg, type|
    user.effects[PBEffects::HoneyHoncho] = 0 if user.effects[PBEffects::HoneyHoncho].nil?
    next if user.effects[PBEffects::HoneyHoncho] <= 0
    mult = 1
    mult += 0.1 * user.effects[PBEffects::HoneyHoncho]
    mults[:attack_multiplier] *= mult if move.physicalMove?
  }
)

Battle::AbilityEffects::OnSwitchIn.add(:HONEYHONCHO,
  proc { |ability, battler, battle, switch_in|
  poisonList = []
  numPsn = 0
  tempParty = $Trainer.party.clone
  tempParty.delete_at(0) # Ignore user
  for pkmn in tempParty
    next if !pkmn.able? || pkmn.status != :NONE || !pkmn.types.include?(:BUG)
    numPsn += 1
  end
  numPsn = 5 if numPsn > 5
  next if numPsn <= 0
  battle.pbShowAbilitySplash(battler)
  battle.pbDisplay(_INTL("{1}'s physical power was boosted by its royalty!", battler.pbThis))
  battler.effects[PBEffects::HoneyHoncho] = numPsn
  battle.pbHideAbilitySplash(battler)
  }
)

#===============================================================================
# Snaring Entrance
#===============================================================================

Battle::AbilityEffects::TrappingByTarget.add(:SNARINGENTRANCE,
  proc { |ability, switcher, bearer, battle|
    next true if bearer.effects[PBEffects::SnaringEntrance] == true
  }
)

Battle::AbilityEffects::OnSwitchIn.add(:SNARINGENTRANCE,
  proc { |ability, battler, battle, switch_in|
    next if @deactivate == true
    if Battle::Scene::USE_ABILITY_SPLASH
      battle.pbShowAbilitySplash(battler)
      msg = _INTL("{1} is ensnared by {2}!", battler.pbOpposingTeam, battler.pbThis)
      battler.effects[PBEffects::SnaringEntrance] = true
      @displayed = true
      battle.pbDisplay(msg)
      battle.pbHideAbilitySplash(battler)
    end
  }
)

Battle::AbilityEffects::OnBattlerFainting.add(:SNARINGENTRANCE,
  proc { |ability, battler, fainted, battle|
    battler.effects[PBEffects::SnaringEntrance] = false
    @deactivate = true
    battle.pbDisplay(_INTL("{1}'s ensnarement disappeared.", battler.pbThis))
    battle.pbHideAbilitySplash(battler)
  }
)

#===============================================================================
# Soul Snatcher
#===============================================================================

Battle::AbilityEffects::OnEndOfUsingMove.add(:SOULSNATCHER,
  proc { |ability, user, targets, move, battle|
    next if battle.pbAllFainted?(user.idxOpposingSide)
    numFainted = 0
    targets.each { |b| numFainted += 1 if b.damageState.fainted }
    next if numFainted == 0
    battle.pbShowAbilitySplash(user)
    user.pbRecoverHP(user.totalhp / 4)
    battle.pbDisplay(_INTL("{1} restored health from from the fallen's soul!", user.pbThis))
    battle.pbHideAbilitySplash(user)
  }
)

#===============================================================================
# Head First
#===============================================================================

Battle::AbilityEffects::DamageCalcFromUser.add(:HEADFIRST,
  proc { |ability, user, target, move, mults, baseDmg, type, battle|
    if user.turnCount <= 1
      mults[:base_damage_multiplier] *= 1.5
    end
  }
)

#===============================================================================
# Kingpin
#===============================================================================

Battle::AbilityEffects::AfterMoveUseFromTarget.add(:KINGPIN,
  proc { |ability, target, user, move, switched_battlers, battle|
    next if !move.damagingMove?
    next if !target.droppedBelowHalfHP
    next if !target.pbCanRaiseStatStage?(:SPEED, target)
    target.pbRaiseStatStageByAbility(:SPEED, 1, target)
  }
)

Battle::AbilityEffects::DamageCalcFromAlly.add(:KINGPIN,
  proc { |ability, user, target, move, mults, baseDmg, type|
    next if !move.physicalMove?
    mults[:final_damage_multiplier] *= 1.3
  }
)

#===============================================================================
# Solidify
#===============================================================================

Battle::AbilityEffects::ModifyMoveBaseType.add(:SOLIDIFY,
  proc { |ability, user, move, type|
    next if type != :WATER || !GameData::Type.exists?(:ICE)
    move.powerBoost = true
    next :ICE
  }
)

#===============================================================================
# Iron Age
#===============================================================================

Battle::AbilityEffects::ModifyMoveBaseType.add(:IRONAGE,
  proc { |ability, user, move, type|
    next if type != :ROCK || !GameData::Type.exists?(:STEEL)
    move.powerBoost = true
    next :STEEL
  }
)

#===============================================================================
# Light Sink
#===============================================================================

Battle::AbilityEffects::DamageCalcFromTarget.add(:LIGHTSINK,
  proc { |ability, user, target, move, mults, baseDmg, type|
    mults[:final_damage_multiplier] /= 2 if move.lightMove?
  }
)

Battle::AbilityEffects::OnBeingHit.add(:LIGHTSINK,
  proc { |ability, user, target, move, battle|
    next if !move.lightMove?
    next if !target.canHeal?
      battle.pbShowAbilitySplash(target)
      target.pbRecoverHP(target.totalhp / 4)
      if Battle::Scene::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("{1}'s HP was restored.", target.pbThis))
      else
        battle.pbDisplay(_INTL("{1}'s {2} restored its HP.", target.pbThis, target.abilityName))
      end
      battle.pbHideAbilitySplash(target)
  }
)

#===============================================================================
# Amplifier
#===============================================================================

Battle::AbilityEffects::MoveImmunity.add(:AMPLIFIER,
  proc { |ability, user, target, move, type, battle, show_message|
    next false if !move.soundMove?
    next false if Settings::MECHANICS_GENERATION >= 8 && user.index == target.index
    if show_message
      battle.pbShowAbilitySplash(target)
      if Battle::Scene::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("It doesn't affect {1}...", target.pbThis(true)))
      else
        battle.pbDisplay(_INTL("{1}'s {2} blocks {3}!", target.pbThis, target.abilityName, move.name))
      end
      target.pbRaiseStatStageByAbility(:SPECIAL_ATTACK, 1, target)
      battle.pbHideAbilitySplash(target)
    end
    next true
  }
)

#===============================================================================
# Automaton
#===============================================================================

#===============================================================================
# Castle Walls
#===============================================================================

Battle::AbilityEffects::OnSwitchIn.add(:CASTLEWALLS,
  proc { |ability, battler, battle|
    battle.pbShowAbilitySplash(battler)
    battle.pbDisplay(_INTL("{1}'s {2} set up Wide Guard!",battler.pbThis,battler.abilityName))
    battler.pbOwnSide.effects[PBEffects::WideGuard] = true
    battle.pbHideAbilitySplash(battler)
  }
)

#===============================================================================
# Flatline
#===============================================================================

Battle::AbilityEffects::MoveImmunity.add(:FLATLINE,
  proc { |ability, user, target, move, type, battle, show_message|
    next false if !move.pulseMove? || !move.flatlineMove?
    next false if Settings::MECHANICS_GENERATION >= 8 && user.index == target.index
    if show_message
      battle.pbShowAbilitySplash(target)
      if Battle::Scene::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("It doesn't affect {1}...", target.pbThis(true)))
      else
        battle.pbDisplay(_INTL("{1}'s {2} blocks {3}!", target.pbThis, target.abilityName, move.name))
      end
      battle.pbHideAbilitySplash(target)
    end
    next true
  }
)
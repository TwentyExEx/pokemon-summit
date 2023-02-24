#===============================================================================
# Wind Turbine
#===============================================================================

Battle::ItemEffects::AfterMoveUseFromUser.add(:WINDTURBINE,
  proc { |item, user, targets, move, numHits, battle|
    next if battle.pbAllFainted?(user.idxOwnSide) ||
            battle.pbAllFainted?(user.idxOpposingSide)
    next if !move.windMove? || numHits == 0
    next if !user.pbCanRaiseStatStage?(:SPECIAL_ATTACK, user)
    battle.pbCommonAnimation("UseItem", user)
    user.pbRaiseStatStage(:SPECIAL_ATTACK, 1, user)
    user.pbConsumeItem
  }
)

#===============================================================================
# Crash Gear - In Move_BaseEffects
#===============================================================================

#===============================================================================
# Suppressor Vest
#===============================================================================

Battle::ItemEffects::DamageCalcFromTarget.add(:SUPPRESSORVEST,
  proc { |item, user, target, move, mults, baseDmg, type|
    mults[:defense_multiplier] *= 1.5 if move.physicalMove? && user.effects[PBEffects::SuppressorVest] = true
  }
)

Battle::ItemEffects::OnSwitchIn.add(:SUPPRESSORVEST,
  proc { |item, battler, battle|
    # This adds the effect onto the Pokemon, which works, but doesn't turn off when the item is removed.
    battler.effects[PBEffects::SuppressorVest] = true
  }
)

Battle::ItemEffects::EndOfRoundEffect.add(:SUPPRESSORVEST,
  proc { |item, battler, battle|
    next if !battler.effects[PBEffects::SuppressorVest] = true
   battler.effects[PBEffects::SuppressorVest] = true
  }
)

#===============================================================================
# Magnifying Glass
#===============================================================================

Battle::ItemEffects::AccuracyCalcFromUser.add(:MAGNIFYINGGLASS,
  proc { |item, mods, user, target, move, type|
    mods[:base_accuracy] = 0
  }
)

#===============================================================================
# Karate Band
#===============================================================================

Battle::ItemEffects::DamageCalcFromUser.add(:KARATEBAND,
  proc { |item, user, target, move, mults, baseDmg, type|
    mults[:base_damage_multiplier] *= 1.3 if move.physicalMove?
  }
)

Battle::ItemEffects::DamageCalcFromTarget.add(:KARATEBAND,
  proc { |item, user, target, move, mults, baseDmg, type|
    mults[:defense_multiplier] *= 0.7 if move.physicalMove?
  }
)

#===============================================================================
# Homing Blaster
#===============================================================================

Battle::ItemEffects::DamageCalcFromUser.add(:HOMINGBLASTER,
  proc { |item, user, target, move, mults, baseDmg, type|
    mults[:base_damage_multiplier] *= 1.3 if move.specialMove?
  }
)

Battle::ItemEffects::DamageCalcFromTarget.add(:HOMINGBLASTER,
  proc { |item, user, target, move, mults, baseDmg, type|
    mults[:defense_multiplier] *= 0.7 if move.specialMove?
  }
)

#===============================================================================
# Pink Herb - oh hell no, Ctrl + F this one please
#===============================================================================

#===============================================================================
# Pixie Dust
#===============================================================================

Battle::ItemEffects::DamageCalcFromUser.add(:PIXIEDUST,
  proc { |item, user, target, move, mults, baseDmg, type|
    mults[:base_damage_multiplier] *= 1.2 if type == :FAIRY
  }
)

#===============================================================================
# Heart Scale
#===============================================================================

Battle::ItemEffects::DamageCalcFromUser.add(:HEARTSCALE,
  proc { |item, user, target, move, mults, baseDmg, type|
    if user.isSpecies?(:LUVDISC) && move.specialMove?
      mults[:base_damage_multiplier] *= 1.5 
    end
  }
)

#===============================================================================
# Knife Sharpener
#===============================================================================

Battle::ItemEffects::AfterMoveUseFromUser.add(:KNIFESHARPENER,
  proc { |item, user, targets, move, numHits, battle|
  targets.each do |b|
    next if battle.pbAllFainted?(user.idxOwnSide) ||
            battle.pbAllFainted?(user.idxOpposingSide)
    next if !(move.slicingMove? && b.damageState.critical) || numHits == 0
    next if !user.pbCanRaiseStatStage?(:ATTACK, user)
    battle.pbCommonAnimation("UseItem", user)
    user.pbRaiseStatStage(:ATTACK, 2, user)
	end
  }
)

#===============================================================================
# Extended Booking - In MoveEffects_SwitchingActing, MoveEffects_BattlerStats, MoveEffects_Items
#===============================================================================

#===============================================================================
# Iron Denture - In Misc
#===============================================================================

Battle::ItemEffects::DamageCalcFromUser.add(:IRONDENTURE,
  proc { |item, user, target, move, mults, baseDmg, type|
    mults[:base_damage_multiplier] *= 1.1 if move.bitingMove?
  }
)
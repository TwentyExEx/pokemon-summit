#===============================================================================
# If there is a terrain active, +1 priority and end terrain (Brutal Swing)
#===============================================================================
class Battle::Move::PriorityWhenTerrainActiveEndsTerrain < Battle::Move
  def pbPriority(user)
    ret = super
    ret += 1 if @battle.field.terrain != :None
    return ret
  end


  def pbEffectGeneral(user)
    case @battle.field.terrain
    when :Electric
      @battle.pbDisplay(_INTL("The electricity disappeared from the battlefield."))
    when :Grassy
      @battle.pbDisplay(_INTL("The grass disappeared from the battlefield."))
    when :Misty
      @battle.pbDisplay(_INTL("The mist disappeared from the battlefield."))
    when :Psychic
      @battle.pbDisplay(_INTL("The weirdness disappeared from the battlefield."))
    end
    @battle.field.terrain = :None
  end
end

#===============================================================================
# For 5 rounds, lowers power of attacks against the user's side. Fails if
# terrain is not Grassy. (Fungus Veil)
#===============================================================================
class Battle::Move::StartWeakenDamageAgainstUserSideIfGrassyTerrain < Battle::Move
  def canSnatch?; return true; end

  def pbMoveFailed?(user, targets)
    if @battle.field.terrain != :Grassy
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    if user.pbOwnSide.effects[PBEffects::FungusVeil] > 0
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end

  def pbEffectGeneral(user)
    user.pbOwnSide.effects[PBEffects::FungusVeil] = 5
    user.pbOwnSide.effects[PBEffects::FungusVeil] = 8 if user.hasActiveItem?(:LIGHTCLAY)
    @battle.pbDisplay(_INTL("{1} made {2} stronger against physical and special moves!",
                            @name, user.pbTeam(true)))
  end
end

#===============================================================================
# Target's Special Defense is used instead of its Defense for this move's
# calculations. (Enzuigiri Kick)
#===============================================================================
class Battle::Move::UseTargetSpDefInsteadOfTargetDef < Battle::Move
  def pbGetDefenseStats(user, target)
    return target.spdef, target.stages[:SPECIAL_DEFENSE] + 6
  end
end

#===============================================================================
# Randomly poisons, paralyzes or sleeps the target and its allies. (Befuddle)
#===============================================================================
class Battle::Move::PoisonParalyzeOrSleepAllFoes < Battle::Move
  def pbAdditionalEffect(user, target)
    return if target.damageState.substitute
    case @battle.pbRandom(3)
    when 0 then target.pbPoison(user) if target.pbCanPoison?(user, false, self)
    when 1 then target.pbParalyze(user) if target.pbCanParalyze?(user, false, self)
    when 2 then target.pbSleep if target.pbCanSleep?(user, false, self)
    end
  end
end

#===============================================================================
# Effectiveness against Dragon-type is 2x. (Arcane Trunk)
#===============================================================================
class Battle::Move::SuperEffectiveAgainstDragonTypes < Battle::Move
  def pbCalcTypeModSingle(moveType, defType, user, target)
    return Effectiveness::SUPER_EFFECTIVE_ONE if defType == :DRAGON
    return super
  end
end

#===============================================================================
# This move's type depends on the user's form. Fails if the user is not
# Squawkabilly (works if transformed into Squawkabilly). (Plume Boom)
#===============================================================================
class Battle::Move::TypeDependsOnSquawkabillyForm < Battle::Move
  def pbMoveFailed?(user, targets)
    if !user.isSpecies?(:SQUAWKABILLY) && user.effects[PBEffects::TransformSpecies] != :SQUAWKABILLY
      @battle.pbDisplay(_INTL("But {1} can't use the move!", user.pbThis))
      return true
    end
    return false
  end

  def pbBaseType(user)
    return :FIGHTING if user.form == 1 && GameData::Type.exists?(:FIGHTING)
	return :DARK if user.form == 2 && GameData::Type.exists?(:DARK)
	return :STEEL if user.form == 3 && GameData::Type.exists?(:STEEL)
    return @type
  end
end

#===============================================================================
# This move's type depends on the user's form. Fails if the user is not
# Sawsbuck (works if transformed into Sawsbuck). (Seasonal Charge)
#===============================================================================
class Battle::Move::TypeDependsOnSawsbuckForm < Battle::Move
  def pbMoveFailed?(user, targets)
    if !user.isSpecies?(:SAWSBUCK) && user.effects[PBEffects::TransformSpecies] != :SAWSBUCK
      @battle.pbDisplay(_INTL("But {1} can't use the move!", user.pbThis))
      return true
    end
    return false
  end

  def pbBaseType(user)
    return :FIRE if user.form == 1 && GameData::Type.exists?(:FIRE)
	return :GROUND if user.form == 2 && GameData::Type.exists?(:GROUND)
	return :ICE if user.form == 3 && GameData::Type.exists?(:ICE)
    return @type
  end
end

#===============================================================================
# This move becomes physical or special, whichever will deal
# more damage (only considers stats, stat stages and Wonder Room). Makes contact
# if it is a physical move. Has a different animation depending on the move's
# category. (Fossil Fury)
#===============================================================================
class Battle::Move::CategoryDependsOnHigherDamage < Battle::Move
  def initialize(battle, move)
    super
    @calcCategory = 1
  end

  def physicalMove?(thisType = nil); return (@calcCategory == 0); end
  def specialMove?(thisType = nil);  return (@calcCategory == 1); end
  def contactMove?;                  return physicalMove?;        end

  def pbOnStartUse(user, targets)
    target = targets[0]
    stageMul = [2, 2, 2, 2, 2, 2, 2, 3, 4, 5, 6, 7, 8]
    stageDiv = [8, 7, 6, 5, 4, 3, 2, 2, 2, 2, 2, 2, 2]
    # Calculate user's effective attacking values
    attack_stage         = user.stages[:ATTACK] + 6
    real_attack          = (user.attack.to_f * stageMul[attack_stage] / stageDiv[attack_stage]).floor
    special_attack_stage = user.stages[:SPECIAL_ATTACK] + 6
    real_special_attack  = (user.spatk.to_f * stageMul[special_attack_stage] / stageDiv[special_attack_stage]).floor
    # Calculate target's effective defending values
    defense_stage         = target.stages[:DEFENSE] + 6
    real_defense          = (target.defense.to_f * stageMul[defense_stage] / stageDiv[defense_stage]).floor
    special_defense_stage = target.stages[:SPECIAL_DEFENSE] + 6
    real_special_defense  = (target.spdef.to_f * stageMul[special_defense_stage] / stageDiv[special_defense_stage]).floor
    # Perform simple damage calculation
    physical_damage = real_attack.to_f / real_defense
    special_damage = real_special_attack.to_f / real_special_defense
    # Determine move's category
    if physical_damage == special_damage
      @calcCategry = @battle.pbRandom(2)
    else
      @calcCategory = (physical_damage > special_damage) ? 0 : 1
    end
  end

  def pbShowAnimation(id, user, targets, hitNum = 0, showAnimation = true)
    hitNum = 1 if physicalMove?
    super
  end
end
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
  def initialize(battle, move)
    super
    @statuses = {
      :opponents => [:POISON, :PARALYSIS, :SLEEP]
    }
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

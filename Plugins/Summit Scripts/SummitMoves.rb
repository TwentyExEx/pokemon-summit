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
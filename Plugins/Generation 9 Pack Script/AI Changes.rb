class Battle::AI
  #=============================================================================
  # Immunity to a move because of the target's ability, item or other effects
  #=============================================================================
  # Adding Wind Rider and Earth Eater
  def pbCheckMoveImmunity(score, move, user, target, skill)
    type = pbRoughType(move, user, skill)
    typeMod = pbCalcTypeMod(type, user, target)
    # Type effectiveness
    return true if (move.damagingMove? && Effectiveness.ineffective?(typeMod)) || score <= 0
    # Immunity due to ability/item/other effects
    if skill >= PBTrainerAI.mediumSkill
      case type
      when :GROUND
        return true if target.airborne? && !move.hitsFlyingTargets?
        return true if target.hasActiveAbility?(:EARTHEATER)
      when :FIRE
        return true if target.hasActiveAbility?([:FLASHFIRE,:WELLBAKEDBODY])
      when :WATER
        return true if target.hasActiveAbility?([:DRYSKIN, :STORMDRAIN, :WATERABSORB])
      when :GRASS
        return true if target.hasActiveAbility?(:SAPSIPPER)
      when :ELECTRIC
        return true if target.hasActiveAbility?([:LIGHTNINGROD, :MOTORDRIVE, :VOLTABSORB])
      end
      return true if move.damagingMove? && Effectiveness.not_very_effective?(typeMod) &&
                     target.hasActiveAbility?(:WONDERGUARD)
      return true if move.damagingMove? && user.index != target.index && !target.opposes?(user) &&
                     target.hasActiveAbility?(:TELEPATHY)
      return true if move.statusMove? && move.canMagicCoat? && target.hasActiveAbility?(:MAGICBOUNCE) &&
                     target.opposes?(user)
      return true if move.soundMove? && target.hasActiveAbility?(:SOUNDPROOF)
      return true if move.bombMove? && target.hasActiveAbility?(:BULLETPROOF)
      if move.powderMove?
        return true if target.pbHasType?(:GRASS)
        return true if target.hasActiveAbility?(:OVERCOAT)
        return true if target.hasActiveItem?(:SAFETYGOGGLES)
      end
      return true if move.statusMove? && target.effects[PBEffects::Substitute] > 0 &&
                     !move.ignoresSubstitute?(user) && user.index != target.index
      return true if move.statusMove? && Settings::MECHANICS_GENERATION >= 7 &&
                     user.hasActiveAbility?(:PRANKSTER) && target.pbHasType?(:DARK) &&
                     target.opposes?(user)
      return true if move.priority > 0 && @battle.field.terrain == :Psychic &&
                     target.affectedByTerrain? && target.opposes?(user)
      return true if move.windMove? && target.hasActiveAbility?(:WINDRIDER)
      return true if move.statusMove? && target.hasActiveAbility?(:GOODASGOLD) && !user.hasActiveAbility?(:MYCELIUMMIGHT)
      return true if target.effects[PBEffects::CommanderTatsugiri]
    end
    return false
  end
  #=============================================================================
  # Damage calculation
  #=============================================================================
  def pbRoughDamage(move, user, target, skill, baseDmg)
    # Fixed damage moves
    return baseDmg if move.is_a?(Battle::Move::FixedDamageMove)
    # Get the move's type
    type = pbRoughType(move, user, skill)
    ##### Calculate user's attack stat #####
    atk = pbRoughStat(user, :ATTACK, skill)
    if move.function == "UseTargetAttackInsteadOfUserAttack"   # Foul Play
      atk = pbRoughStat(target, :ATTACK, skill)
    elsif move.function == "UseUserBaseDefenseInsteadOfUserBaseAttack"   # Body Press
      atk = pbRoughStat(user, :DEFENSE, skill)
    elsif move.specialMove?(type)
      if move.function == "UseTargetAttackInsteadOfUserAttack"   # Foul Play
        atk = pbRoughStat(target, :SPECIAL_ATTACK, skill)
      else
        atk = pbRoughStat(user, :SPECIAL_ATTACK, skill)
      end
    end
    ##### Calculate target's defense stat #####
    defense = pbRoughStat(target, :DEFENSE, skill)
    if move.specialMove?(type) && move.function != "UseTargetDefenseInsteadOfTargetSpDef"   # Psyshock
      defense = pbRoughStat(target, :SPECIAL_DEFENSE, skill)
    end
    ##### Calculate all multiplier effects #####
    multipliers = {
      :base_damage_multiplier  => 1.0,
      :attack_multiplier       => 1.0,
      :defense_multiplier      => 1.0,
      :final_damage_multiplier => 1.0
    }
    # Ability effects that alter damage
    moldBreaker = false
    if skill >= PBTrainerAI.highSkill && target.hasMoldBreaker?
      moldBreaker = true
    end
    if skill >= PBTrainerAI.mediumSkill && user.abilityActive?
      # NOTE: These abilities aren't suitable for checking at the start of the
      #       round.
      abilityBlacklist = [:ANALYTIC, :SNIPER, :TINTEDLENS, :AERILATE, :PIXILATE, :REFRIGERATE]
      canCheck = true
      abilityBlacklist.each do |m|
        next if move.id != m
        canCheck = false
        break
      end
      if canCheck
        Battle::AbilityEffects.triggerDamageCalcFromUser(
          user.ability, user, target, move, multipliers, baseDmg, type
        )
      end
    end
    if skill >= PBTrainerAI.mediumSkill && !moldBreaker
      user.allAllies.each do |b|
        next if !b.abilityActive?
        Battle::AbilityEffects.triggerDamageCalcFromAlly(
          b.ability, user, target, move, multipliers, baseDmg, type
        )
      end
    end
    if skill >= PBTrainerAI.bestSkill && !moldBreaker && target.abilityActive?
      # NOTE: These abilities aren't suitable for checking at the start of the
      #       round.
      abilityBlacklist = [:FILTER, :SOLIDROCK]
      canCheck = true
      abilityBlacklist.each do |m|
        next if move.id != m
        canCheck = false
        break
      end
      if canCheck
        Battle::AbilityEffects.triggerDamageCalcFromTarget(
          target.ability, user, target, move, multipliers, baseDmg, type
        )
      end
    end
    if skill >= PBTrainerAI.bestSkill && !moldBreaker
      target.allAllies.each do |b|
        next if !b.abilityActive?
        Battle::AbilityEffects.triggerDamageCalcFromTargetAlly(
          b.ability, user, target, move, multipliers, baseDmg, type
        )
      end
    end
    # Item effects that alter damage
    # NOTE: Type-boosting gems aren't suitable for checking at the start of the
    #       round.
    if skill >= PBTrainerAI.mediumSkill && user.itemActive?
      # NOTE: These items aren't suitable for checking at the start of the
      #       round.
      itemBlacklist = [:EXPERTBELT, :LIFEORB]
      if !itemBlacklist.include?(user.item_id)
        Battle::ItemEffects.triggerDamageCalcFromUser(
          user.item, user, target, move, multipliers, baseDmg, type
        )
        user.effects[PBEffects::GemConsumed] = nil   # Untrigger consuming of Gems
      end
    end
    if skill >= PBTrainerAI.bestSkill &&
       target.itemActive? && target.item && !target.item.is_berry?
      Battle::ItemEffects.triggerDamageCalcFromTarget(
        target.item, user, target, move, multipliers, baseDmg, type
      )
    end
    # Global abilities
    if skill >= PBTrainerAI.mediumSkill &&
       ((@battle.pbCheckGlobalAbility(:DARKAURA) && type == :DARK) ||
        (@battle.pbCheckGlobalAbility(:FAIRYAURA) && type == :FAIRY))
      if @battle.pbCheckGlobalAbility(:AURABREAK)
        multipliers[:base_damage_multiplier] *= 2 / 3.0
      else
        multipliers[:base_damage_multiplier] *= 4 / 3.0
      end
    end
    # Parental Bond
    if skill >= PBTrainerAI.mediumSkill && user.hasActiveAbility?(:PARENTALBOND)
      multipliers[:base_damage_multiplier] *= 1.25
    end
    # Me First
    # TODO
    # Helping Hand - n/a
    # Charge
    if skill >= PBTrainerAI.mediumSkill &&
       user.effects[PBEffects::Charge] > 0 && type == :ELECTRIC
      multipliers[:base_damage_multiplier] *= 2
    end
    # Mud Sport and Water Sport
    if skill >= PBTrainerAI.mediumSkill
      if type == :ELECTRIC
        if @battle.allBattlers.any? { |b| b.effects[PBEffects::MudSport] }
          multipliers[:base_damage_multiplier] /= 3
        end
        if @battle.field.effects[PBEffects::MudSportField] > 0
          multipliers[:base_damage_multiplier] /= 3
        end
      end
      if type == :FIRE
        if @battle.allBattlers.any? { |b| b.effects[PBEffects::WaterSport] }
          multipliers[:base_damage_multiplier] /= 3
        end
        if @battle.field.effects[PBEffects::WaterSportField] > 0
          multipliers[:base_damage_multiplier] /= 3
        end
      end
    end
    # Terrain moves
    if skill >= PBTrainerAI.mediumSkill
      case @battle.field.terrain
      when :Electric
        multipliers[:base_damage_multiplier] *= 1.5 if type == :ELECTRIC && user.affectedByTerrain?
      when :Grassy
        multipliers[:base_damage_multiplier] *= 1.5 if type == :GRASS && user.affectedByTerrain?
      when :Psychic
        multipliers[:base_damage_multiplier] *= 1.5 if type == :PSYCHIC && user.affectedByTerrain?
      when :Misty
        multipliers[:base_damage_multiplier] /= 2 if type == :DRAGON && target.affectedByTerrain?
      end
    end
    # Badge multipliers
    if skill >= PBTrainerAI.highSkill && @battle.internalBattle && target.pbOwnedByPlayer?
      if move.physicalMove?(type) && @battle.pbPlayer.badge_count >= Settings::NUM_BADGES_BOOST_DEFENSE
        multipliers[:defense_multiplier] *= 1.1
      elsif move.specialMove?(type) && @battle.pbPlayer.badge_count >= Settings::NUM_BADGES_BOOST_SPDEF
        multipliers[:defense_multiplier] *= 1.1
      end
    end
    # Multi-targeting attacks
    if skill >= PBTrainerAI.highSkill && pbTargetsMultiple?(move, user)
      multipliers[:final_damage_multiplier] *= 0.75
    end
    # Weather
    if skill >= PBTrainerAI.mediumSkill
      case user.effectiveWeather
      when :Sun, :HarshSun
        case type
        when :FIRE
          multipliers[:final_damage_multiplier] *= 1.5
        when :WATER
          multipliers[:final_damage_multiplier] /= 2
        end
      when :Rain, :HeavyRain
        case type
        when :FIRE
          multipliers[:final_damage_multiplier] /= 2
        when :WATER
          multipliers[:final_damage_multiplier] *= 1.5
        end
      when :Sandstorm
        if target.pbHasType?(:ROCK) && move.specialMove?(type) &&
           move.function != "UseTargetDefenseInsteadOfTargetSpDef"   # Psyshock
          multipliers[:defense_multiplier] *= 1.5
        end
      end
    end
    # Critical hits - n/a
    # Random variance - n/a
    # STAB
    if skill >= PBTrainerAI.mediumSkill && type && user.pbHasType?(type)
      if user.hasActiveAbility?(:ADAPTABILITY)
        multipliers[:final_damage_multiplier] *= 2
      else
        multipliers[:final_damage_multiplier] *= 1.5
      end
    end
    # Type effectiveness
    if skill >= PBTrainerAI.mediumSkill
      typemod = pbCalcTypeMod(type, user, target)
      multipliers[:final_damage_multiplier] *= typemod.to_f / Effectiveness::NORMAL_EFFECTIVE
    end
    # Burn
    if skill >= PBTrainerAI.highSkill && move.physicalMove?(type) &&
       user.status == :BURN && !user.hasActiveAbility?(:GUTS) &&
       !(Settings::MECHANICS_GENERATION >= 6 &&
         move.function == "DoublePowerIfUserPoisonedBurnedParalyzed")   # Facade
      multipliers[:final_damage_multiplier] /= 2
    end
    # Aurora Veil, Reflect, Light Screen
    if skill >= PBTrainerAI.highSkill && !move.ignoresReflect? && !user.hasActiveAbility?(:INFILTRATOR)
      if target.pbOwnSide.effects[PBEffects::AuroraVeil] > 0
        if @battle.pbSideBattlerCount(target) > 1
          multipliers[:final_damage_multiplier] *= 2 / 3.0
        else
          multipliers[:final_damage_multiplier] /= 2
        end
      elsif target.pbOwnSide.effects[PBEffects::Reflect] > 0 && move.physicalMove?(type)
        if @battle.pbSideBattlerCount(target) > 1
          multipliers[:final_damage_multiplier] *= 2 / 3.0
        else
          multipliers[:final_damage_multiplier] /= 2
        end
      elsif target.pbOwnSide.effects[PBEffects::LightScreen] > 0 && move.specialMove?(type)
        if @battle.pbSideBattlerCount(target) > 1
          multipliers[:final_damage_multiplier] *= 2 / 3.0
        else
          multipliers[:final_damage_multiplier] /= 2
        end
      end
    end
    # Minimize
    if skill >= PBTrainerAI.highSkill && target.effects[PBEffects::Minimize] && move.tramplesMinimize?
      multipliers[:final_damage_multiplier] *= 2
    end
    # Move-specific base damage modifiers
    # TODO
    # Move-specific final damage modifiers
    # TODO
    ##### Main damage calculation #####
    baseDmg = [(baseDmg * multipliers[:base_damage_multiplier]).round, 1].max
    atk     = [(atk     * multipliers[:attack_multiplier]).round, 1].max
    defense = [(defense * multipliers[:defense_multiplier]).round, 1].max
    damage  = ((((2.0 * user.level / 5) + 2).floor * baseDmg * atk / defense).floor / 50).floor + 2
    damage  = [(damage * multipliers[:final_damage_multiplier]).round, 1].max
    # "AI-specific calculations below"
    # Increased critical hit rates
    if skill >= PBTrainerAI.mediumSkill
      c = 0
      # Ability effects that alter critical hit rate
      if c >= 0 && user.abilityActive?
        c = Battle::AbilityEffects.triggerCriticalCalcFromUser(user.ability, user, target, c)
      end
      if skill >= PBTrainerAI.bestSkill && c >= 0 && !moldBreaker && target.abilityActive?
        c = Battle::AbilityEffects.triggerCriticalCalcFromTarget(target.ability, user, target, c)
      end
      # Item effects that alter critical hit rate
      if c >= 0 && user.itemActive?
        c = Battle::ItemEffects.triggerCriticalCalcFromUser(user.item, user, target, c)
      end
      if skill >= PBTrainerAI.bestSkill && c >= 0 && target.itemActive?
        c = Battle::ItemEffects.triggerCriticalCalcFromTarget(target.item, user, target, c)
      end
      # Other efffects
      c = -1 if target.pbOwnSide.effects[PBEffects::LuckyChant] > 0
      if c >= 0
        c += 1 if move.highCriticalRate?
        c += user.effects[PBEffects::FocusEnergy]
        c += 1 if user.inHyperMode? && move.type == :SHADOW
      end
      if c >= 0
        c = 4 if c > 4
        damage += damage * 0.1 * c
      end
    end
    return damage.floor
  end
end
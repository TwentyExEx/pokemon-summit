
# Boosts Sp. Atk when the holder users a wind-based move. (Wind Turbine) #
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
#-------------------------------------------------------------------------------
# Placeholder file path for custom battle button.
#-------------------------------------------------------------------------------
module Settings
  CUSTOM_MECH_BUTTON_PATH = "Graphics/Pictures/Battle/cursor_tera"
end

#-------------------------------------------------------------------------------
# Placeholder Battle code.
#-------------------------------------------------------------------------------
class Battle

  def pbCanCustom?(idxBattler)
	return pbCanTerastallize?(idxBattler)
  end
  
  # def pbCustomMechanic(idxBattler)
  
  # end
  
  def pbRegisterCustom(idxBattler)
	self.pbRegisterTerastallize(idxBattler) 
  end

  def pbUnregisterCustom(idxBattler)
	pbUnregisterTerastallize(idxBattler)
  end
  
  def pbToggleRegisteredCustom(idxBattler)
	pbToggleRegisteredTerastallize(idxBattler)
  end
  
  def pbRegisteredCustom?(idxBattler)
	return self.pbRegisteredTerastallize?(idxBattler)
  end

  def pbAttackPhaseCustom
	pbAttackPhaseTerastallize
  end

end

#-------------------------------------------------------------------------------
# Placeholder Battle AI code.
#-------------------------------------------------------------------------------
class Battle::AI

  def pbEnemyShouldCustom?(idxBattler)
	pbEnemyShouldTerastallize?(idxBattler)
  end
  
end

#-------------------------------------------------------------------------------
# Placeholder Databox icon display.
#-------------------------------------------------------------------------------
class Battle::Scene::PokemonDataBox < SpriteWrapper

  def draw_custom_icon
	draw_tera_icon
  end
  
end
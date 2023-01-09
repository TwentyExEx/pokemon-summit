=begin
def getTeraColor(teraType)
	red = 0
	green = 0
	blue = 0
	opa = 128
	case teraType
	when :NORMAL
		red = 215
		green = 215
		blue = 215
	when :FIGHTING
		red = 158
		green = 6
		blue = 33
	when :FLYING
		red = 75
		green = 188
		blue = 223
	when :POISON
		red = 202
		green = 17
		blue = 226
	when :GROUND
		red = 199
		green = 98
		blue = 15
	when :ROCK
		red = 165
		green = 99
		blue = 17
	when :BUG
		red = 151
		green = 206
		blue = 93
	when :GHOST
		red = 113
		green = 43
		blue = 143
	when :STEEL
		red = 150
		green = 147
		blue = 182
	when :FIRE
		red = 255
		green = 88
		blue = 0
	when :WATER
		red = 10
		green = 93
		blue = 239
	when :GRASS
		red = 49
		green = 203
		blue = 34
	when :ELECTRIC
		red = 228
		green = 213
		blue = 23
	when :PSYCHIC
		red = 244
		green = 0
		blue = 171
	when :ICE
		red = 62
		green = 226
		blue = 232
	when :DRAGON
		red = 26
		green = 26
		blue = 163
	when :DARK
		red = 11
		green = 3
		blue = 22
	when :FAIRY
		red = 255
		green = 82
		blue = 246
	end
	return Color.new(red, green, blue, opa)
end

def teraColorizeSprite(sprite,teraType)
	sprite.applyTera(teraType)
end

class Battle

	alias txwRecall pbRecallAndReplace
	def pbRecallAndReplace(idxBattler, idxParty, randomReplacement = false, batonPass = false)
		txwRecall(idxBattler,idxParty,randomReplacement,batonPass)
		if @battlers[idxBattler].tera_active
			teraColorizeSprite(@scene.sprites["pokemon_#{idxBattler}"],@battlers[idxBattler].pokemon.tera_type[0])
		end

	end
end

#===============================================================================
# SpriteWrapper additions for Tera sprites.
#===============================================================================

class Sprite
  def applyTera(teraType)
    if true
      tera_color = getTeraColor(teraType)
      self.color = tera_color
    end
  end
  
  def unTera
    #if self.color == TERA_COLOR
      self.color = Color.new(0, 0, 0, 0)
    #end
  end
end


#===============================================================================
# BattlerSprite additions for Tera sprites.
#===============================================================================
class Battle::Scene::BattlerSprite < RPG::Sprite
  def applyTera(teraType)
    if true
      tera_color = getTeraColor(teraType)
      self.color = tera_color
    end
  end
  
  def unTera
    #if self.color == TERA_COLOR
      self.color = Color.new(0, 0, 0, 0)
    #end
  end
end

class Battle::Scene
  alias tdwAnicore pbAnimationCore
  def pbAnimationCore(animation, user, target, oppMove = false)
    return if !animation
    userSprite   = (user) ? @sprites["pokemon_#{user.index}"] : nil
    targetSprite = (target) ? @sprites["pokemon_#{target.index}"] : nil
	if userSprite && user.tera_active then userTeraType = (user) ? user.pokemon.tera_type[0] : nil; end
	if targetSprite && target.tera_active then targetTeraType = (target) ? target.pokemon.tera_type[0] : nil; end


    if TDWSettings::SHOW_TERA_COLOR
      prevusercolor  = (user) ? userSprite.color : nil
      prevtargetcolor  = (target) ? targetSprite.color : nil
      olddcolor  = Color.new(0,0,0,0)
      # Colors user's sprite.
      if userSprite && user.tera_active
        olddUserColor = prevusercolor
      else
        olddUserColor = olddcolor
      end
      # Colors target's sprite.
      if targetSprite && target.tera_active
        olddTargetColor = prevtargetcolor
      else
        olddTargetColor = olddcolor
      end
    end
    #---------------------------------------------------------------------------
	
	tdwAnicore(animation, user, target, oppMove)
	
	if TDWSettings::SHOW_TERA_COLOR
      # Colors user's sprite.
      if userSprite && user.tera_active
        userSprite.color = getTeraColor(userTeraType)
      else
        userSprite.color = olddcolor
      end
      # Colors target's sprite.
      if targetSprite && target.tera_active
        targetSprite.color = getTeraColor(targetTeraType)
      else
        targetSprite.color = olddcolor
      end
	end
	pbUpdate
	
  end

end
=end

def teraColorizeSprite(sprite,teraType)
	sprite.applyTera(teraType)
end

#===============================================================================
# SpriteWrapper additions for Tera sprites.
#===============================================================================
#https://github.com/mkxp-z/mkxp-z/wiki/Extensions-(RGSS,-Classes)#sprite-pattern-overlays
class Sprite
  def applyTera(teraType=nil)
      #tera_color = getTeraColor(teraType)
	  self.pattern= Bitmap.new("Graphics/Pictures/teraCrystal")
	  self.pattern_opacity = 185
	  rand1 = rand(5)-2
	  rand2 = rand(5)-2
	  rand3 = rand(5)-2
	  self.pattern_scroll_x += rand1*5
	  self.pattern_scroll_y += rand2*5
  end
  
  def unTera
    #if self.color == TERA_COLOR
      self.pattern= nil
    #end
  end
end
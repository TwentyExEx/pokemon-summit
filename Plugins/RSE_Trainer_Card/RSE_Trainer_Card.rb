#===============================================================================
#
#===============================================================================
# Game Variable for the Trainer Card Level / Stars
CARDLEVELVARIABLE = 99
# 0 - Normal
# 1 - Copper
# 2 - Bronze
# 3 - Silver
# 4 - Gold

class PokemonTrainerCard_Scene
    def pbUpdate
      pbUpdateSpriteHash(@sprites)
    end
  
    def pbStartScene
      @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
      @viewport.z = 99999
      @sprites = {}
      background = pbResolveBitmap(sprintf("Graphics/Pictures/Trainer Card/bg_f"))
      if $player.female? && background
        addBackgroundPlane(@sprites,"bg","Trainer Card/bg_f",@viewport)
      else
        addBackgroundPlane(@sprites,"bg","Trainer Card/bg",@viewport)
      end
      @sprites["card"] = IconSprite.new(0,0,@viewport)
      @sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card_#{pbGet(CARDLEVELVARIABLE)}")
      @sprites["overlay"] = BitmapSprite.new(Graphics.width,Graphics.height,@viewport)
      pbSetSystemFont(@sprites["overlay"].bitmap)
      # @sprites["trainer"] = IconSprite.new(336 - 16,106,@viewport)
      # @sprites["trainer"].setBitmap(GameData::TrainerType.player_front_sprite_filename($player.trainer_type))
      # @sprites["trainer"].x -= (@sprites["trainer"].bitmap.width-128)/2
      # @sprites["trainer"].y -= (@sprites["trainer"].bitmap.height-128)
      # @sprites["trainer"].z = 2
      pbDrawTrainerCardFront
      pbFadeInAndShow(@sprites) { pbUpdate }
    end
  
    def pbDrawTrainerCardFront
      overlay = @sprites["overlay"].bitmap
      overlay.clear
      baseColor   = Color.new(99, 99, 99)
      shadowColor = Color.new(214, 214, 206)
      totalsec = Graphics.frame_count / Graphics.frame_rate
      hour = totalsec / 60 / 60
      min = totalsec / 60 % 60
      time = (hour>0) ? _INTL("{1}h {2}m",hour,min) : _INTL("{1}m",min)
      $PokemonGlobal.startTime = pbGetTimeNow if !$PokemonGlobal.startTime
      starttime = _INTL("{1} {2}, {3}",
         pbGetAbbrevMonthName($PokemonGlobal.startTime.mon),
         $PokemonGlobal.startTime.day,
         $PokemonGlobal.startTime.year)
      textPositions = [
         [_INTL("Name:"),48,104,0,baseColor,shadowColor],
         [$player.name,108,104,0,baseColor,shadowColor],
         [_INTL("ID No."),328,40,0,baseColor,shadowColor],
         [sprintf("%05d",$player.public_ID),448,40,1,baseColor,shadowColor],
         [_INTL("Money"),48,152,0,baseColor,shadowColor],
         [_INTL("${1}",$player.money.to_s_formatted),288,152,1,baseColor,shadowColor],
         [_INTL("Pok??dex"),48,184,0,baseColor,shadowColor],
         [sprintf("%d/%d",$player.pokedex.owned_count,$player.pokedex.seen_count),288,184,1,baseColor,shadowColor],
         [_INTL("Play Time"),48,216,0,baseColor,shadowColor],
         [time,288,216,1,baseColor,shadowColor],
         [_INTL("Started"),48,248,0,baseColor,shadowColor],
         [starttime,288,248,1,baseColor,shadowColor]
      ]
      pbDrawTextPositions(overlay,textPositions)
      x = 72
      region = pbGetCurrentRegion(0) # Get the current region
      imagePositions = []
      for i in 0...8
        if $player.badges[i+region*8]
          imagePositions.push(["Graphics/Pictures/Trainer Card/icon_badges",x,310,i*32,region*32,32,32])
        end
        x += 48
      end
      pbDrawImagePositions(overlay,imagePositions)
    end
  
    def pbTrainerCard
      pbSEPlay("GUI trainer card open")
      loop do
        Graphics.update
        Input.update
        pbUpdate
        if Input.trigger?(Input::BACK)
          pbPlayCloseMenuSE
          break
        end
      end
    end
  
    def pbEndScene
      pbFadeOutAndHide(@sprites) { pbUpdate }
      pbDisposeSpriteHash(@sprites)
      @viewport.dispose
    end
  end
  
  #===============================================================================
  #
  #===============================================================================
  class PokemonTrainerCardScreen
    def initialize(scene)
      @scene = scene
    end
  
    def pbStartScreen
      @scene.pbStartScene
      @scene.pbTrainerCard
      @scene.pbEndScene
    end
  end
  
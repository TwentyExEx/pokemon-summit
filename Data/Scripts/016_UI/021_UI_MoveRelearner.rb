#===============================================================================
# Scene class for handling appearance of the screen
#===============================================================================
class MoveRelearner_Scene
  VISIBLEMOVES = 4

  def pbDisplay(msg, brief = false)
    UIHelper.pbDisplay(@sprites["msgwindow"], msg, brief) { pbUpdate }
  end

  def pbConfirm(msg)
    UIHelper.pbConfirm(@sprites["msgwindow"], msg) { pbUpdate }
  end

  def pbUpdate
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartScene(pokemon, moves)
    @pokemon = pokemon
    @moves = moves
    moveCommands = []
    moves.each { |m| moveCommands.push(GameData::Move.get(m).name) }
    # Create sprite hash
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    addBackgroundPlane(@sprites, "bg", "reminderbg", @viewport)
    @sprites["pokeicon"] = PokemonIconSprite.new(@pokemon, @viewport)
    @sprites["pokeicon"].setOffset(PictureOrigin::CENTER)
    @sprites["pokeicon"].x = 320
    @sprites["pokeicon"].y = 84
    @sprites["background"] = IconSprite.new(0, 0, @viewport)
    @sprites["background"].setBitmap("Graphics/Pictures/reminderSel")
    @sprites["background"].y = 78
    @sprites["background"].src_rect = Rect.new(0, 72, 258, 72)
    @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    pbSetNarrowFont(@sprites["overlay"].bitmap)
    @sprites["commands"] = Window_CommandPokemon.new(moveCommands, 32)
    @sprites["commands"].height = 32 * (VISIBLEMOVES + 1)
    @sprites["commands"].visible = false
    @sprites["msgwindow"] = Window_AdvancedTextPokemon.new("")
    @sprites["msgwindow"].visible = false
    @sprites["msgwindow"].viewport = @viewport
    @typebitmap = AnimatedBitmap.new(_INTL("Graphics/Pictures/types"))
    pbDrawMoveList
    pbDeactivateWindows(@sprites)
    # Fade in all sprites
    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def pbDrawMoveList
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    @pokemon.types.each_with_index do |type, i|
      type_number = GameData::Type.get(type).icon_position
      type_rect = Rect.new(0, type_number * 28, 64, 28)
      type_x = (@pokemon.types.length == 1) ? 400 : 366 + (70 * i)
      overlay.blt(type_x, 70, @typebitmap.bitmap, type_rect)
    end
    textpos = [
      [_INTL("Teach which move?"), 4, 4, 0, Color.new(248, 248, 248), Color.new(96, 96, 96)]
    ]
    imagepos = []
    yPos = 88
    VISIBLEMOVES.times do |i|
      moveobject = @moves[@sprites["commands"].top_item + i]
      if moveobject
        moveData = GameData::Move.get(moveobject)
        type_number = GameData::Type.get(moveData.display_type(@pokemon)).icon_position
        imagepos.push(["Graphics/Pictures/types", 12, yPos - 2, 0, type_number * 28, 64, 28])
        textpos.push([moveData.name, 80, yPos, 0, Color.new(72, 72, 72), Color.new(184, 184, 184)])
        if moveData.total_pp>0
          textpos.push([_INTL("PP"),30,yPos+32,0,Color.new(64,64,64),Color.new(176,176,176)])
          textpos.push([_INTL("{1}/{1}",moveData.total_pp),130,yPos+32,1,
             Color.new(64,64,64),Color.new(176,176,176)])
        else
          textpos.push(["-",80,yPos,0,Color.new(64,64,64),Color.new(176,176,176)])
          textpos.push(["--",228,yPos+32,1,Color.new(64,64,64),Color.new(176,176,176)])
        end
        # =================== UNCOMMENT THIS SECTION IN MAIN GAME =================================
        # if $game_variables[37].include?(GameData::Move.get(moveobject).name)
        #   textpos.push([_INTL("Free"), 228, yPos + 32, 1,
        #                 Color.new(72, 72, 72), Color.new(184, 184, 184)])
        #   $game_variables[5] = 0
        # else
        #   textpos.push([_INTL("$500"), 228, yPos + 32, 1, Color.new(72, 72, 72), Color.new(184, 184, 184)])
        #   $game_variables[5] = 500
        # end
        # =================== UNCOMMENT THIS SECTION IN MAIN GAME =================================
      end
      yPos += 64
    end
    imagepos.push(["Graphics/Pictures/reminderSel",
                   0, 78 + ((@sprites["commands"].index - @sprites["commands"].top_item) * 64),
                   0, 0, 258, 72])
    selMoveData = GameData::Move.get(@moves[@sprites["commands"].index])
    basedamage = selMoveData.display_damage(@pokemon)
    category = selMoveData.display_category(@pokemon)
    accuracy = selMoveData.display_accuracy(@pokemon)
    textpos.push([_INTL("CATEGORY"), 272, 120, 0, Color.new(248, 248, 248), Color.new(96, 96, 96)])
    textpos.push([_INTL("POWER"), 272, 152, 0, Color.new(248, 248, 248), Color.new(96, 96, 96)])
    textpos.push([basedamage <= 1 ? basedamage == 1 ? "???" : "---" : sprintf("%d", basedamage),
                  464, 152, 2, Color.new(72, 72, 72), Color.new(184, 184, 184)]) # edit here, original 468, 152, 2
    textpos.push([_INTL("ACCURACY"), 272, 184, 0, Color.new(248, 248, 248), Color.new(96, 96, 96)])
    textpos.push([accuracy == 0 ? "---" : "#{accuracy}%",
                  464, 184, 2, Color.new(72, 72, 72), Color.new(184, 184, 184)])
    pbDrawTextPositions(overlay, textpos)
    imagepos.push(["Graphics/Pictures/category", 436, 118, 0, category * 22, 66, 22]) # edit here, original 436, 116, 0
    if @sprites["commands"].index < @moves.length - 1
      imagepos.push(["Graphics/Pictures/reminderButtons", 48, 350, 0, 0, 76, 32])
    end
    if @sprites["commands"].index > 0
      imagepos.push(["Graphics/Pictures/reminderButtons", 134, 350, 76, 0, 76, 32])
    end
    pbDrawImagePositions(overlay, imagepos)
    drawTextEx(overlay, 272, 218, 230, 5, selMoveData.description,
               Color.new(72, 72, 72), Color.new(184, 184, 184))
  end

  # Processes the scene
  def pbChooseMove
    oldcmd = -1
    pbActivateWindow(@sprites, "commands") {
      loop do
        oldcmd = @sprites["commands"].index
        Graphics.update
        Input.update
        pbUpdate
        if @sprites["commands"].index != oldcmd
          @sprites["background"].x = 0
          @sprites["background"].y = 78 + ((@sprites["commands"].index - @sprites["commands"].top_item) * 64)
          pbDrawMoveList
        end
        if Input.trigger?(Input::BACK)
          return nil
        elsif Input.trigger?(Input::USE)
          return @moves[@sprites["commands"].index]
        end
      end
    }
  end

  # End the scene here
  def pbEndScene
    pbFadeOutAndHide(@sprites) { pbUpdate }
    pbDisposeSpriteHash(@sprites)
    @typebitmap.dispose
    @viewport.dispose
  end
end

#===============================================================================
# Screen class for handling game logic
#===============================================================================
class MoveRelearnerScreen
  def initialize(scene)
    @scene = scene
  end

  def pbGetRelearnableMoves(pkmn)
    return [] if !pkmn || pkmn.egg? || pkmn.shadowPokemon?
    moves = []
    pkmn.getMoveList.each do |m|
      next if m[0] > pkmn.level || pkmn.hasMove?(m[1])
      moves.push(m[1]) if !moves.include?(m[1])
    end
    if Settings::MOVE_RELEARNER_CAN_TEACH_MORE_MOVES && pkmn.first_moves
      tmoves = []
      pkmn.first_moves.each do |i|
        tmoves.push(i) if !moves.include?(i) && !pkmn.hasMove?(i)
      end
      moves = tmoves + moves   # List first moves before level-up moves
    end
    return moves | []   # remove duplicates
  end

  def pbStartScreen(pkmn)
    moves = pbGetRelearnableMoves(pkmn)
    @scene.pbStartScene(pkmn, moves)
    loop do
      move = @scene.pbChooseMove
      if move
        if @scene.pbConfirm(_INTL("Teach {1}?", GameData::Move.get(move).name))
          if pbLearnMove(pkmn, move)
            $stats.moves_taught_by_reminder += 1 
              # edit here
              if !$game_variables[37].include?(GameData::Move.get(move).name)
                $game_variables[37].push(GameData::Move.get(move).name)
                $game_variables[5] = 500 
              else
                $game_variables[5] = 0 
              end
            @scene.pbEndScene
            return true
          end
        end
      elsif @scene.pbConfirm(_INTL("Give up trying to teach a new move to {1}?", pkmn.name))
        @scene.pbEndScene
        return false
      end
    end
  end
end

#===============================================================================
#
#===============================================================================
def pbRelearnMoveScreen(pkmn)
  retval = true
  pbFadeOutIn {
    scene = MoveRelearner_Scene.new
    screen = MoveRelearnerScreen.new(scene)
    retval = screen.pbStartScreen(pkmn)
  }
  return retval
end

def pbSetMoveScreen(pkmn)
  retval = true
  scene = MoveRelearner_Scene.new
  screen = MoveRelearnerScreen.new(scene)
  retval = screen.pbStartScreen(pkmn)
  return retval
end


#===============================================================================
# Battle send out.
#===============================================================================
# Adds memento animation as part of the general send out animation in battle.
#-------------------------------------------------------------------------------
class Battle::Scene
  def pbSendOutBattlers(sendOuts, startBattle = false)
    return if sendOuts.length == 0
    while inPartyAnimation?
      pbUpdate
    end
    @briefMessage = false
    if @battle.opposes?(sendOuts[0][0])
      fadeAnim = Animation::TrainerFade.new(@sprites, @viewport, startBattle)
    else
      fadeAnim = Animation::PlayerFade.new(@sprites, @viewport, startBattle)
    end
    sendOutAnims = []
    sendOuts.each_with_index do |b, i|
      pkmn = @battle.battlers[b[0]].effects[PBEffects::Illusion] || b[1]
      pbChangePokemon(b[0], pkmn)
      pbRefresh
      if @battle.opposes?(b[0])
        sendOutAnim = Animation::PokeballTrainerSendOut.new(
          @sprites, @viewport, @battle.pbGetOwnerIndexFromBattlerIndex(b[0]) + 1,
          @battle.battlers[b[0]], startBattle, i
        )
      else
        sendOutAnim = Animation::PokeballPlayerSendOut.new(
          @sprites, @viewport, @battle.pbGetOwnerIndexFromBattlerIndex(b[0]) + 1,
          @battle.battlers[b[0]], startBattle, i
        )
      end
      dataBoxAnim = Animation::DataBoxAppear.new(@sprites, @viewport, b[0])
      mementoAnim = Animation::BattlerMemento.new(@sprites, @viewport, @battle, b[0])
      sendOutAnims.push([sendOutAnim, mementoAnim, dataBoxAnim, false])
    end
    loop do
      fadeAnim.update
      sendOutAnims.each do |a|
        next if a[3]
        a[0].update
        a[1].update if a[0].animDone?
        a[2].update if a[1].animDone?
        a[3] = true if a[2].animDone?
      end
      pbUpdate
      if !inPartyAnimation? && sendOutAnims.none? { |a| !a[3] }
        break
      end
    end
    fadeAnim.dispose
    sendOutAnims.each do |a|
      a[0].dispose
      a[1].dispose
      a[2].dispose
    end
    sendOuts.each do |b|
      next if !@battle.showAnims || !@battle.battlers[b[0]].shiny?
      if Settings::SUPER_SHINY && @battle.battlers[b[0]].super_shiny?
        pbCommonAnimation("SuperShiny", @battle.battlers[b[0]])
      else
        pbCommonAnimation("Shiny", @battle.battlers[b[0]])
      end
    end
  end
end


#===============================================================================
# Memento animation.
#===============================================================================
# Displays a battler's memento when being sent out in battle.
#-------------------------------------------------------------------------------
class Battle::Scene::Animation::BattlerMemento < Battle::Scene::Animation
  def initialize(sprites, viewport, battle, idxBattler)
    @battle = battle
    @idxBattler = idxBattler
    super(sprites, viewport)
  end

  def createProcesses
    batSprite = @sprites["pokemon_#{@idxBattler}"]
    return if !batSprite
    memento = GameData::Ribbon.try_get(batSprite.pkmn.memento)
    return if !memento
    delay = 0
    coords = Battle::Scene.pbBattlerPosition(@idxBattler, batSprite.sideSize)
    pictureSPRITE = addMementoSprite(memento.icon_position)
    pictureSPRITE.setXY(0, coords[0], coords[1])
    pictureSPRITE.setZ(0, batSprite.z + 1)
    pictureSPRITE.setOpacity(0, 0)
    pictureSPRITE.moveXY(0, 16, coords[0], coords[1] - batSprite.height)
    pictureSPRITE.moveOpacity(0, 4, 255)
    pictureSPRITE.moveOpacity(8, 8, 0)
  end
  
  def addMementoSprite(icon)
    file_path = "Graphics/Plugins/Improved Mementos/mementos"
    picMemento = addNewSprite(Graphics.width, Graphics.height, file_path, PictureOrigin::CENTER)
    mementoSprite = @pictureSprites.last
    mementoSprite.src_rect.x = 78 * (icon % 8)
    mementoSprite.src_rect.y = 78 * (icon / 8).floor
    mementoSprite.src_rect.width = 78
    mementoSprite.src_rect.height = 78
    picMemento.setSrc(0, mementoSprite.src_rect.x, mementoSprite.src_rect.y)
    picMemento.setSrcSize(0, mementoSprite.src_rect.width, mementoSprite.src_rect.height)
    return picMemento
  end
end
module TDWSettings

#The ID of the item you want to be the Tera Item needed to Terastallize
TERA_ITEM_ID 				= :TERAITEM

#The ID of the items you want to use to manipulate a Pokemon's Tera Type
TERA_SWAP_ITEM_ID 				= :TERASWAPITEM
TERA_RANDOM_ITEM_ID 			= :TERARANDOMITEM
TERA_CHOOSE_ITEM_ID 			= :TERACHOOSEITEM

#If true, then you need 100 Tera Energy in order to Terastallize
#If false, then you can always Terastallize if you have the item
TERA_ITEM_GENERATE			= true

#The ID of the Switch that needs to be TRUE in order to Terastallize
TERA_ITEM_ENABLED_SWITCH 	= 64

#If true, then any Pokemon that doesn't have TeraTypes definied in pokemon.txt will be assigned a random TeraType
#If false, then any Pokemon that doesn't have TeraTypes defined will have their first original Type be their TeraType
UNDEFINED_MEANS_RANDOM		= true

#If true, and UNDEFINED_MEANS_RANDOM = true, a Pokemon's TeraType will have a WEIGHT_PERCENT chance of being one of it's original Types instead of a different type.
#If false, and UNDEFINED_MEANS_RANDOM = true, a Pokemon's TeraType will have an even chance of being any Type
WEIGHT_RANDOM_TO_ORIGINAL	= true
WEIGHT_PERCENT				= 50 #integer out of 100; Default 50

#If true, a Pokemon's Tera Type will be shown in Summary
#If false, a Pokemon's Tera Type will not be shown in Summary
SHOW_TERA_TYPE_IN_SUMMARY	= true

#If true, a Pokemon's sprite will get a diamond overlay when Terastallized
#If false, a Pokemon's sprite will not change
SHOW_TERA_OVERLAY				= false #EXPERIMENTAL

end
#=========================
#=========================
#=========================

def pbGainTeraEnergy(amount=0)
	if amount > 100 then amount = 100 end
	$player.gainTeraEnergy(amount)
end

def pbFillTeraEnergy
	$player.gainTeraEnergy(100)
end

def pbLoseTeraEnergy(amount=0)
	if amount > 100 then amount = 100 end
	$player.gainTeraEnergy(-amount)
end

def pbCurrentTeraEnergy
	if !$player.tera_energy then $player.gainTeraEnergy(0) end
	return $player.tera_energy
end

#=========================

class Player < Trainer

  attr_reader   :tera_energy
	
  def tera_energy
    return @tera_energy
  end
  
  def gainTeraEnergy(amt)
    if !@tera_energy then @tera_energy = 0 end
	curTera = @tera_energy
	@tera_energy = [[curTera + amt,0].max, 100].min
  end

  alias tdwplayerinit initialize
  def initialize(name, trainer_type)
	tdwplayerinit(name, trainer_type)
	@tera_energy = 0
  end

end

#=========================

class Battle::Battler

  def tera_active
	return @pokemon&.tera_active
  end

  def unTerastallize
	@pokemon&.unTerastallize
  end 
  
  alias tdwpbhastype pbHasType?
  def pbHasType?(type,checkNonTera=false)
    return false if !type
    if @pokemon.tera_active
		if !checkNonTera
			teraType = @pokemon.tera_type
			return teraType.include?(GameData::Type.get(type).id)
		else
			return @pokemon.types(true).include?(GameData::Type.get(type).id)
		end
	else
		return tdwpbhastype(type)
	end	
  end

end

#=========================

class Battle::Move
  
  alias tdwdammult pbCalcDamageMultipliers
  def pbCalcDamageMultipliers(user, target, numTargets, type, baseDmg, multipliers)
	
	#Tera STAB
	if type && user.pokemon.tera_active && user.pbHasType?(type) && user.pbHasType?(type, true)
      if user.hasActiveAbility?(:ADAPTABILITY)
        multipliers[:final_damage_multiplier] *= 2
      else
        multipliers[:final_damage_multiplier] *= 1.5
      end
    end
	tdwdammult(user, target, numTargets, type, baseDmg, multipliers)
  end
end

#=========================

class Pokemon

  attr_accessor :tera_types_available
  attr_accessor :tera_type
  attr_accessor :tera_active
  
  def generateTeraType
	teraTypeArr = []
	if !@tera_types_available && TDWSettings::UNDEFINED_MEANS_RANDOM
		if TDWSettings::WEIGHT_RANDOM_TO_ORIGINAL && rand(100)<TDWSettings::WEIGHT_PERCENT
			teraTypeArr.push(species_data.types.clone[rand(species_data.types.length)])
			return teraTypeArr
		else
			types = []
			  GameData::Type.each do |t|
			  if t.pseudo_type || [:SHADOW].include?(t.id) then next end
				types[t.icon_position] ||= []
				types[t.icon_position].push(t.id) if !t.pseudo_type && ![:SHADOW].include?(t.id)
			  end
			return types[rand(types.length)]
		end
	elsif !@tera_types_available
		teraTypeArr.push(species_data.types.clone[0])
		return teraTypeArr
	else 
		teraTypeArr.push @tera_types_available[rand(@tera_types_available.length)]
		return teraTypeArr
	end
  end
  
  def tera_type
    return @tera_type
  end

  # @return [Array<Symbol>] an array of this Pokémon's types
  
  alias tdwtypes types #unless method_defined?(:tdwtypes)
  def types(origtypes=false)
    if @tera_active && !origtypes
		@tera_type=generateTeraType if !@tera_type
		return @tera_type
	else
		return tdwtypes #species_data.types.clone
	end
  end

  # @param type [Symbol, String, GameData::Type] type to check
  # @return [Boolean] whether this Pokémon has the specified type
  alias tdwhasType? hasType?   
  def hasType?(type)
    type = GameData::Type.get(type).id
    if @tera_active then return self.tera_type.include?(type) end
	return self.types.include?(type)
  end

  # Creates a copy of this Pokémon and returns it.
  # @return [Pokemon] a copy of this Pokémon
  alias tdwclone clone
  def clone
    ret = tdwclone
    ret.tera_type   = @tera_type.clone
    return ret
  end
  
  # Creates a new Pokémon object.
  # @param species [Symbol, String, GameData::Species] Pokémon species
  # @param level [Integer] Pokémon level
  # @param owner [Owner, Player, NPCTrainer] Pokémon owner (the player by default)
  # @param withMoves [Boolean] whether the Pokémon should have moves
  # @param recheck_form [Boolean] whether to auto-check the form
  alias tdwinitialize initialize
  def initialize(species, level, owner = $player, withMoves = true, recheck_form = true)
	tdwinitialize(species, level, owner, withMoves, recheck_form)
	species_data = GameData::Species.get(species)
	@tera_types_available = species_data.tera_types_available
	@tera_type = generateTeraType
  end

#====================== 
 
  def canTerastallize?
	return false if (!$bag.has?(TDWSettings::TERA_ITEM_ID) || !$game_switches[TDWSettings::TERA_ITEM_ENABLED_SWITCH])
	return true
  end
  
  def terastallize
	@tera_active = true
  end
  
  def unTerastallize
	@tera_active = false
  end  
end

class PokemonSummary_Scene

	alias tdwpageOne drawPageOne
	def drawPageOne
		tdwpageOne
		if TDWSettings::SHOW_TERA_TYPE_IN_SUMMARY && $bag.has?(TDWSettings::TERA_ITEM_ID)
		  @pokemon.tera_type=@pokemon.generateTeraType if !@pokemon.tera_type
		  type_number = GameData::Type.get(@pokemon.tera_type[0]).icon_position
		  if type_number>=0
			  overlay = @sprites["overlay"].bitmap
			  tera_rect = Rect.new(0, type_number * 32, 32, 32)
			  @terabitmap    = AnimatedBitmap.new(_INTL("Graphics/Pictures/Battle/icon_teraTypes"))
			  overlay.blt(330, 143, @terabitmap.bitmap, tera_rect)
		  end
		elsif @pokemon.tera_active
		  overlay = @sprites["overlay"].bitmap
		  tera_rect = Rect.new(0, 0, 64, 64)
		  @terabitmap    = AnimatedBitmap.new(_INTL("Graphics/Pictures/tera"))
		  overlay.blt(336, 149, @terabitmap.bitmap, tera_rect)
		end
	end

	# def drawPageOne
		# tdwpageOne
		# if @pokemon.tera_active
		  # overlay = @sprites["overlay"].bitmap
		  # tera_rect = Rect.new(0, 0, 64, 64)
		  # @terabitmap    = AnimatedBitmap.new(_INTL("Graphics/Pictures/tera"))
		  # overlay.blt(336, 149, @terabitmap.bitmap, tera_rect)
		# end
	# end
	
	alias tdwendScene pbEndScene
	def pbEndScene
		tdwendScene
		@terabitmap&.dispose
	end
end
#=========================

class Battle
  attr_accessor :terastallize    # Battle index of each trainer's Pokémon to Terastallize

  alias tdwbattleinitialize initialize
  def initialize(scene, p1, p2, player, opponent)
    @terastallize     = [
      [-1] * (@player ? @player.length : 1),
      [-1] * (@opponent ? @opponent.length : 1)
    ]
	tdwbattleinitialize(scene, p1, p2, player, opponent)
  end

  def pbCanTerastallize?(idxBattler)
	ownedByPlayer = pbOwnedByPlayer?(idxBattler)
    return false if !$game_switches[TDWSettings::TERA_ITEM_ENABLED_SWITCH]
    return false if @battlers[idxBattler].wild?
    return false if pbCanMegaEvolve?(idxBattler) && ownedByPlayer
    if PluginManager.installed?("ZUD Mechanics") && ownedByPlayer
      return false if pbCanZMove?(idxBattler)
      return false if pbCanUltraBurst?(idxBattler)
      return false if pbCanDynamax?(idxBattler)
      return false if @battlers[idxBattler].dynamax?
    end
    if PluginManager.installed?("PLA Battle Styles") && ownedByPlayer
      return false if pbCanUseStyle?(idxBattler)
    end
    if PluginManager.installed?("Pokémon Birthsigns") && ownedByPlayer
      return false if pbCanZodiacPower?(idxBattler)
    end
    if PluginManager.installed?("Focus Meter System") && ownedByPlayer
      return false if pbCanUseFocus?(idxBattler)
    end
    return true if $DEBUG && Input.press?(Input::CTRL)
    return false if pbOwnedByPlayer?(idxBattler) && !$bag.has?(TDWSettings::TERA_ITEM_ID)
	return false if TDWSettings::TERA_ITEM_GENERATE && pbOwnedByPlayer?(idxBattler) && pbCurrentTeraEnergy < 100 
    side  = @battlers[idxBattler].idxOwnSide
    owner = pbGetOwnerIndexFromBattlerIndex(idxBattler)
    return @terastallize[side][owner] == -1
  end
  
  def pbRegisterTerastallize(idxBattler)
    side  = @battlers[idxBattler].idxOwnSide
    owner = pbGetOwnerIndexFromBattlerIndex(idxBattler)
    @terastallize[side][owner] = idxBattler
  end

  def pbUnregisterTerastallize(idxBattler)
    side  = @battlers[idxBattler].idxOwnSide
    owner = pbGetOwnerIndexFromBattlerIndex(idxBattler)
    @terastallize[side][owner] = -1 if @terastallize[side][owner] == idxBattler
  end
  
  def pbToggleRegisteredTerastallize(idxBattler)
    side  = @battlers[idxBattler].idxOwnSide
    owner = pbGetOwnerIndexFromBattlerIndex(idxBattler)
    if @terastallize[side][owner] == idxBattler
      @terastallize[side][owner] = -1
    else
      @terastallize[side][owner] = idxBattler
    end
  end

  def pbRegisteredTerastallize?(idxBattler)
    side  = @battlers[idxBattler].idxOwnSide
    owner = pbGetOwnerIndexFromBattlerIndex(idxBattler)
    return @terastallize[side][owner] == idxBattler
  end
 
  def pbTerastallize(idxBattler)
    battler = @battlers[idxBattler]
    return if !battler || !battler.pokemon
    return if battler.tera_active
    #$stats.mega_evolution_count += 1 if battler.pbOwnedByPlayer?
    trainerName = pbGetOwnerName(idxBattler)
    #old_ability = battler.ability_id

    pbDisplay(_INTL("{1} is reacting to the {2}!",
                      battler.pbThis, GameData::Item.get(TDWSettings::TERA_ITEM_ID).real_name))

    pbCommonAnimation("MegaEvolution", battler)
    battler.pokemon.terastallize
    #battler.form = battler.pokemon.form
    battler.pbUpdate(true)
    @scene.pbChangePokemon(battler, battler.pokemon)
    @scene.pbRefreshOne(idxBattler)
	teraColorizeSprite(@scene.sprites["pokemon_#{idxBattler}"],battler.pokemon.tera_type[0]) if TDWSettings::SHOW_TERA_OVERLAY #&& PluginManager.installed?("ZUD Mechanics")
    pbCommonAnimation("MegaEvolution2", battler)
    pbDisplay(_INTL("{1} Terastallized! Their Tera Type is {2}!", battler.pbThis, battler.pokemon.tera_type[0].name))
    side  = battler.idxOwnSide
    owner = pbGetOwnerIndexFromBattlerIndex(idxBattler)
    @terastallize[side][owner] = -2
	$player.gainTeraEnergy(-100) if pbOwnedByPlayer?(idxBattler)
  end

#----------Block to not run if using ZUD 
if !PluginManager.installed?("Essentials Deluxe")
  def pbFightMenu(idxBattler)
    # Auto-use Encored move or no moves choosable, so auto-use Struggle
    return pbAutoChooseMove(idxBattler) if !pbCanShowFightMenu?(idxBattler)
    # Battle Palace only
    return true if pbAutoFightMenu(idxBattler)
    # Regular move selection
    ret = false
    @scene.pbFightMenu(idxBattler, pbCanMegaEvolve?(idxBattler), pbCanTerastallize?(idxBattler)) { |cmd|
      case cmd
      when -1   # Cancel
      when -2   # Toggle Mega Evolution
        pbToggleRegisteredMegaEvolution(idxBattler)
        next false
      when -3   # Toggle Terastallize
        pbToggleRegisteredTerastallize(idxBattler)
        next false
      when -4   # Shift
        pbUnregisterMegaEvolution(idxBattler)
		pbUnregisterTerastallize
        pbRegisterShift(idxBattler)
        ret = true
      else      # Chose a move to use
        next false if cmd < 0 || !@battlers[idxBattler].moves[cmd] ||
                      !@battlers[idxBattler].moves[cmd].id
        next false if !pbRegisterMove(idxBattler, cmd)
        next false if !singleBattle? &&
                      !pbChooseTarget(@battlers[idxBattler], @battlers[idxBattler].moves[cmd])
        ret = true
      end
      next true
    }
    return ret
  end
  
  def pbCommandPhase
    @scene.pbBeginCommandPhase
    # Reset choices if commands can be shown
    @battlers.each_with_index do |b, i|
      next if !b
      pbClearChoice(i) if pbCanShowCommands?(i)
    end
    # Reset choices to perform Mega Evolution if it wasn't done somehow
    2.times do |side|
      @megaEvolution[side].each_with_index do |megaEvo, i|
        @megaEvolution[side][i] = -1 if megaEvo >= 0
      end
    end
    2.times do |side|
      @terastallize[side].each_with_index do |tera, i|
        @terastallize[side][i] = -1 if tera >= 0
      end
    end
    # Choose actions for the round (player first, then AI)
    pbCommandPhaseLoop(true)    # Player chooses their actions
    return if @decision != 0   # Battle ended, stop choosing actions
    pbCommandPhaseLoop(false)   # AI chooses their actions
  end  

  def pbAttackPhase
    @scene.pbBeginAttackPhase
    # Reset certain effects
    @battlers.each_with_index do |b, i|
      next if !b
      b.turnCount += 1 if !b.fainted?
      @successStates[i].clear
      if @choices[i][0] != :UseMove && @choices[i][0] != :Shift && @choices[i][0] != :SwitchOut
        b.effects[PBEffects::DestinyBond] = false
        b.effects[PBEffects::Grudge]      = false
      end
      b.effects[PBEffects::Rage] = false if !pbChoseMoveFunctionCode?(i, "StartRaiseUserAtk1WhenDamaged")
    end
    PBDebug.log("")
    # Calculate move order for this round
    pbCalculatePriority(true)
    # Perform actions
    pbAttackPhasePriorityChangeMessages
    pbAttackPhaseCall
    pbAttackPhaseSwitch
    return if @decision > 0
    pbAttackPhaseItems
    return if @decision > 0
    pbAttackPhaseMegaEvolution
	pbAttackPhaseTerastallize
    pbAttackPhaseMoves
  end
 
  alias tdwCancelChoice pbCancelChoice
  def pbCancelChoice(idxBattler)
    tdwCancelChoice(idxBattler)
	pbUnregisterTerastallize(idxBattler)
  end
end #----------End of block to not run if using ZUD 
  
  def pbAttackPhaseTerastallize
    pbPriority.each do |b|
      next if b.wild?
      next unless @choices[b.index][0] == :UseMove && !b.fainted?
      owner = pbGetOwnerIndexFromBattlerIndex(b.index)
      next if @terastallize[b.idxOwnSide][owner] != b.index
      pbTerastallize(b.index)
    end
  end

  alias tdwEndOfBattle pbEndOfBattle
  def pbEndOfBattle
    @battlers.each do |b|
      next if !b || !b.tera_active
      b.unTerastallize
    end
    tdwEndOfBattle
  end

  def pbGetOwnerTeraIndex(idxBattler)
    idxTrainer = pbGetOwnerIndexFromBattlerIndex(idxBattler)
    return @opponent[idxTrainer].teraIndex if opposes?(idxBattler)   # Opponent
    return @player[idxTrainer].teraIndex if idxTrainer > 0   # Ally trainer
    return @player[idxTrainer].teraIndex   # Player
  end
  
  def pbGetOwner(idxBattler)
    idxTrainer = pbGetOwnerIndexFromBattlerIndex(idxBattler)
    return @opponent[idxTrainer] if opposes?(idxBattler)   # Opponent
    return @player[idxTrainer] if idxTrainer > 0   # Ally trainer
    return @player[idxTrainer]   # Player
  end
  
end

#=========================

class Battle::Scene
  alias tdwFaintBattler pbFaintBattler
  def pbFaintBattler(battler)
    if @battle.battlers[battler.index].tera_active
      @battle.battlers[battler.index].unTerastallize
	  self.sprites["pokemon_#{battler.index}"].unTera if TDWSettings::SHOW_TERA_OVERLAY
    end
    tdwFaintBattler(battler)
  end
  
  alias tdwRecall pbRecall
  def pbRecall(idxBattler)
	tdwRecall(idxBattler)
	self.sprites["pokemon_#{idxBattler}"].unTera if TDWSettings::SHOW_TERA_OVERLAY
  end
  
  alias tdwSendOutBattlers pbSendOutBattlers
  def pbSendOutBattlers(sendOuts, startBattle = false)
    return if sendOuts.length == 0
	if TDWSettings::SHOW_TERA_OVERLAY
		sendOuts.each do |array|
			if @battle.battlers[array[0]].tera_active
				self.sprites["pokemon_#{array[0]}"].applyTera
			end
		end
	end
	tdwSendOutBattlers(sendOuts, startBattle)
  end  
  
end

#=========================

#----------Block to not run if using ZUD 
if !PluginManager.installed?("Essentials Deluxe")
class Battle::Scene::FightMenu < Battle::Scene::MenuBase

  def initialize(viewport, z)
    super(viewport)
    self.x = 0
    self.y = Graphics.height - 96
    @battler   = nil
    @shiftMode = 0
    # NOTE: @mode is for the display of the Mega Evolution button.
    #       0=don't show, 1=show unpressed, 2=show pressed
    if USE_GRAPHICS
      # Create bitmaps
      @buttonBitmap  = AnimatedBitmap.new(_INTL("Graphics/Pictures/Battle/cursor_fight"))
      @typeBitmap    = AnimatedBitmap.new(_INTL("Graphics/Pictures/types"))
      @megaEvoBitmap = AnimatedBitmap.new(_INTL("Graphics/Pictures/Battle/cursor_mega"))
      @terastallizeBitmap = AnimatedBitmap.new(_INTL("Graphics/Pictures/Battle/cursor_tera"))
      @shiftBitmap   = AnimatedBitmap.new(_INTL("Graphics/Pictures/Battle/cursor_shift"))
	  @button_mode = 0
      # Create background graphic
      background = IconSprite.new(0, Graphics.height - 96, viewport)
      background.setBitmap("Graphics/Pictures/Battle/overlay_fight")
      addSprite("background", background)
      # Create move buttons
      @buttons = Array.new(Pokemon::MAX_MOVES) do |i|
        button = Sprite.new(viewport)
        button.bitmap = @buttonBitmap.bitmap
        button.x = self.x + 4
        button.x += (i.even? ? 0 : (@buttonBitmap.width / 2) - 4)
        button.y = self.y + 6
        button.y += (((i / 2) == 0) ? 0 : BUTTON_HEIGHT - 4)
        button.src_rect.width  = @buttonBitmap.width / 2
        button.src_rect.height = BUTTON_HEIGHT
        addSprite("button_#{i}", button)
        next button
      end
      # Create overlay for buttons (shows move names)
      @overlay = BitmapSprite.new(Graphics.width, Graphics.height - self.y, viewport)
      @overlay.x = self.x
      @overlay.y = self.y
      pbSetNarrowFont(@overlay.bitmap)
      addSprite("overlay", @overlay)
      # Create overlay for selected move's info (shows move's PP)
      @infoOverlay = BitmapSprite.new(Graphics.width, Graphics.height - self.y, viewport)
      @infoOverlay.x = self.x
      @infoOverlay.y = self.y
      pbSetNarrowFont(@infoOverlay.bitmap)
      addSprite("infoOverlay", @infoOverlay)
      # Create type icon
      @typeIcon = Sprite.new(viewport)
      @typeIcon.bitmap = @typeBitmap.bitmap
      @typeIcon.x      = self.x + 416
      @typeIcon.y      = self.y + 20
      @typeIcon.src_rect.height = TYPE_ICON_HEIGHT
      addSprite("typeIcon", @typeIcon)
      # Create Mega Evolution button
      @megaButton = Sprite.new(viewport)
      @megaButton.bitmap = @megaEvoBitmap.bitmap
      @megaButton.x      = self.x + 120
      @megaButton.y      = self.y - (@megaEvoBitmap.height / 2)
      @megaButton.src_rect.height = @megaEvoBitmap.height / 2
      addSprite("megaButton", @megaButton)
      # Create Terastallize button
      @teraButton = Sprite.new(viewport)
      @teraButton.bitmap = @terastallizeBitmap.bitmap
      @teraButton.x      = self.x + 120
      @teraButton.y      = self.y - (@terastallizeBitmap.height / 2)
      @teraButton.src_rect.height = @terastallizeBitmap.height / 2
      addSprite("teraButton", @teraButton)
      # Create Shift button
      @shiftButton = Sprite.new(viewport)
      @shiftButton.bitmap = @shiftBitmap.bitmap
      @shiftButton.x      = self.x + 4
      @shiftButton.y      = self.y - @shiftBitmap.height
      addSprite("shiftButton", @shiftButton)
    else
      # Create message box (shows type and PP of selected move)
      @msgBox = Window_AdvancedTextPokemon.newWithSize(
        "", self.x + 320, self.y, Graphics.width - 320, Graphics.height - self.y, viewport
      )
      @msgBox.baseColor   = TEXT_BASE_COLOR
      @msgBox.shadowColor = TEXT_SHADOW_COLOR
      pbSetNarrowFont(@msgBox.contents)
      addSprite("msgBox", @msgBox)
      # Create command window (shows moves)
      @cmdWindow = Window_CommandPokemon.newWithSize(
        [], self.x, self.y, 320, Graphics.height - self.y, viewport
      )
      @cmdWindow.columns       = 2
      @cmdWindow.columnSpacing = 4
      @cmdWindow.ignore_input  = true
      pbSetNarrowFont(@cmdWindow.contents)
      addSprite("cmdWindow", @cmdWindow)
    end
    self.z = z
  end

  def dispose
    super
    @buttonBitmap&.dispose
    @typeBitmap&.dispose
    @megaEvoBitmap&.dispose
    @terastallizeBitmap&.dispose
    @shiftBitmap&.dispose
  end

  def refreshTerastallizeButton
    return if !USE_GRAPHICS
    @teraButton.src_rect.y    = (@mode - 1) * @terastallizeBitmap.height / 2
    @teraButton.x             = self.x + ((@shiftMode > 0) ? 204 : 120)
    @teraButton.z             = self.z - 1
    @visibility["teraButton"] = (@mode > 0) && (@button_mode > 1)
	if @visibility["teraButton"] then @visibility["megaButton"] = false end
  end
  
  def button_mode=(value)
	oldValue = @button_mode
	@button_mode = value
	refresh if @button_mode!=oldValue
  end
  
  def refresh
    return if !@battler
    refreshSelection
    refreshMegaEvolutionButton
	refreshTerastallizeButton
    refreshShiftButton
  end
end

#=========================

class Battle::Scene

  def pbFightMenu(idxBattler, megaEvoPossible = false, teraPossible = false)
    battler = @battle.battlers[idxBattler]
    cw = @sprites["fightWindow"]
    cw.battler = battler
    #cw.battle = @battle
    moveIndex = 0
	cw.button_mode = 0
    if battler.moves[@lastMove[idxBattler]]&.id
      moveIndex = @lastMove[idxBattler]
    end
    cw.shiftMode = (@battle.pbCanShift?(idxBattler)) ? 1 : 0
	specialMechanic = false
	if megaEvoPossible || teraPossible then specialMechanic=true end
    #cw.setIndexAndMode(moveIndex, (megaEvoPossible) ? 1 : 0)
	cw.setIndexAndMode(moveIndex, (specialMechanic) ? 1 : 0)
	if specialMechanic
		if megaEvoPossible
			cw.button_mode = 1
		elsif teraPossible
			cw.button_mode = 2
		end
	end
    needFullRefresh = true
    needRefresh = false
    loop do
      # Refresh view if necessary
      if needFullRefresh
        pbShowWindow(FIGHT_BOX)
        pbSelectBattler(idxBattler)
        needFullRefresh = false
      end
      if needRefresh
        if megaEvoPossible
          newMode = (@battle.pbRegisteredMegaEvolution?(idxBattler)) ? 2 : 1
          cw.mode = newMode if newMode != cw.mode
		elsif teraPossible
          newMode = (@battle.pbRegisteredTerastallize?(idxBattler)) ? 2 : 1
          cw.mode = newMode if newMode != cw.mode
        end
        needRefresh = false
      end
      oldIndex = cw.index
      # General update
      pbUpdate(cw)
      # Update selected command
      if Input.trigger?(Input::LEFT)
        cw.index -= 1 if (cw.index & 1) == 1
      elsif Input.trigger?(Input::RIGHT)
        if battler.moves[cw.index + 1]&.id && (cw.index & 1) == 0
          cw.index += 1
        end
      elsif Input.trigger?(Input::UP)
        cw.index -= 2 if (cw.index & 2) == 2
      elsif Input.trigger?(Input::DOWN)
        if battler.moves[cw.index + 2]&.id && (cw.index & 2) == 0
          cw.index += 2
        end
      end
      pbPlayCursorSE if cw.index != oldIndex
      # Actions
      if Input.trigger?(Input::USE)      # Confirm choice
        pbPlayDecisionSE
        break if yield cw.index
        needFullRefresh = true
        needRefresh = true
      elsif Input.trigger?(Input::BACK)   # Cancel fight menu
        pbPlayCancelSE
        break if yield -1
        needRefresh = true
      elsif Input.trigger?(Input::ACTION)   # Toggle Mega Evolution
        if megaEvoPossible
          pbPlayDecisionSE
          break if yield -2
          needRefresh = true
        end
        if teraPossible
          pbPlayDecisionSE
          break if yield -3
          needRefresh = true
        end
      elsif Input.trigger?(Input::SPECIAL)   # Shift
        if cw.shiftMode > 0
          pbPlayDecisionSE
          break if yield -4
          needRefresh = true
        end
      end
    end
    @lastMove[idxBattler] = cw.index
  end

end
end #----------End of block to not run if using ZUD 

#=========================

class Battle::AI

  def pbEnemyShouldTerastallize?(idxBattler)
    battler = @battle.battlers[idxBattler]
    if @battle.pbCanTerastallize?(idxBattler)   # Simple "always should if possible"
      teraIndex = @battle.pbGetOwnerTeraIndex(idxBattler)
	  #battlerIndex = @battle.pbGetOwner(idxBattler).party.find_index(battler.pokemon)
	  party = @battle.pbGetOwner(idxBattler).party
	  return false if teraIndex < -1
	  return false if teraIndex > party.length
	  if battler.pokemon == party[teraIndex]
		  PBDebug.log("[AI] #{battler.pbThis} (#{idxBattler}) will Terastallize")
		  return true
	  end
    end
    return false
  end
  
  if !PluginManager.installed?("Essentials Deluxe")
  def pbDefaultChooseEnemyCommand(idxBattler)
	return if pbEnemyShouldUseItem?(idxBattler)
    return if pbEnemyShouldWithdraw?(idxBattler)
    return if @battle.pbAutoFightMenu(idxBattler)
    if pbEnemyShouldMegaEvolve?(idxBattler)
		@battle.pbRegisterMegaEvolution(idxBattler)
	elsif pbEnemyShouldTerastallize?(idxBattler)
		@battle.pbRegisterTerastallize(idxBattler)
	end
    pbChooseMoves(idxBattler)
  end
  end #----------End of block to not run if using ZUD 
  
end


#=========================

class Battle::Scene::PokemonDataBox < Sprite

  def draw_tera_icon
	return if !defined?(@battler.tera_active)
	return if !@battler.tera_active
      extraX = (@battler.opposes?) ? 208 : -28   # Foe's/player's
	  type_number = GameData::Type.get(@battler.pokemon.tera_type[0]).icon_position
	  if type_number<0 then pbDrawImagePositions(self.bitmap, [["Graphics/Pictures/Battle/icon_tera", @spriteBaseX + extraX, 4]]) end
	  pbDrawImagePositions(self.bitmap,[["Graphics/Pictures/Battle/icon_teraTypes",@spriteBaseX + extraX, 4,
		0, type_number * 32, 32,32]])
  end

  alias tdwbattlerefresh refresh
  def refresh
	tdwbattlerefresh
	draw_tera_icon
  end
  
end

#=========================

MenuHandlers.add(:pokemon_debug_menu, :tera_menu, {
  "name"        => _INTL("Tera Options"),
  "parent"      => :main
})


MenuHandlers.add(:pokemon_debug_menu, :toggle_tera, {
  "name"   => _INTL("Toggle Tera"),
  "parent" => :tera_menu,
  "effect" => proc { |pkmn, pkmnid, heldpoke, settingUpBattle, screen|
    if pkmn.tera_active
       pkmn.tera_active = false
	   screen.pbDisplay(_INTL("{1} returned to normal.", pkmn.name))
    else
		pkmn.tera_active = true
	   screen.pbDisplay(_INTL("{1} terastallized!", pkmn.name))
    end
    next
  }
})

MenuHandlers.add(:pokemon_debug_menu, :tera_type, {
  "name"   => _INTL("Set Tera Type"),
  "parent" => :tera_menu,
  "effect" => proc { |pkmn, pkmnid, heldpoke, settingUpBattle, screen|
	pkmn.tera_type=pkmn.generateTeraType if !pkmn.tera_type
	screen.pbDisplay(_INTL("Tera type is {1}.", pkmn.tera_type[0].name))
	oldType = pkmn.tera_type
	default = GameData::Type.get(pkmn.tera_type[0]).icon_position
	newType = pbChooseTypeList(default < 10 ? default+1 : default)
	pkmn.tera_type = newType ? [newType] : oldType 
    next
  }
})


ItemHandlers::UseFromBag.add(TDWSettings::TERA_ITEM_ID, proc { |item|
  amt = $player.tera_energy ? $player.tera_energy : 0
  pbMessage(_INTL("The {1} is {2}% charged.", GameData::Item.get(item).name, amt))
  next 0
})

ItemHandlers::UseOnPokemon.add(TDWSettings::TERA_SWAP_ITEM_ID, proc { |item, qty, pkmn, scene|
  pkmnTypes = pkmn.types
  if pkmnTypes.length>1
	if pkmn.tera_type[0] == pkmnTypes[0]
		pkmn.tera_type=[pkmnTypes[1]]
		scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
		next true
	elsif pkmn.tera_type[0] == pkmnTypes[1]
		pkmn.tera_type=[pkmnTypes[0]]
		scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
		next true
	else
		pkmn.tera_type=[pkmnTypes[0]]
		scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
		next true
	end
  elsif pkmnTypes.length == 0 && pkmnTypes[0] != pkmn.tera_type[0]
	pkmn.tera_type=[pkmnTypes[0]]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
  else
	scene.pbDisplay(_INTL("It won't have any effect as {1} only has one type.", pkmn.name))
	next false
  end
  scene.pbDisplay(_INTL("It won't have any effect."))
  next false
})

ItemHandlers::UseOnPokemon.add(TDWSettings::TERA_RANDOM_ITEM_ID, proc { |item, qty, pkmn, scene|
	types = []
	game_data_module = GameData.const_get(:Type.to_sym)
	game_data_module.each do |data|
		# name = data.name
		# name = yield(data) if block_given?
		# next if !name
		next if data.id == :QMARKS
		types.push(data.id)
	end
	pkmn.tera_type=[types[rand(types.length)]]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(TDWSettings::TERA_CHOOSE_ITEM_ID, proc { |item, qty, pkmn, scene|
	pkmn.tera_type=pkmn.generateTeraType if !pkmn.tera_type
		scene.pbDisplay(_INTL("{1}'s current Tera type is {2}.\nChoose a new Tera type.", pkmn.name, pkmn.tera_type[0].name))
		oldType = pkmn.tera_type
		default = GameData::Type.get(pkmn.tera_type[0]).icon_position
		newType = pbChooseTypeListSimple(default < 10 ? default+1 : default)
		pkmn.tera_type = newType ? [newType] : oldType 
		
	if !newType
		scene.pbDisplay(_INTL("{1}'s Tera type didn't change.", pkmn.name))
		next false
	end
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})


def pbChooseTypeListSimple(default = nil)
  return pbChooseFromGameDataListSimple(:Type, default) { |data|
    next (data.pseudo_type) ? nil : data.real_name
  }
end

def pbChooseFromGameDataListSimple(game_data, default = nil)
  if !GameData.const_defined?(game_data.to_sym)
    raise _INTL("Couldn't find class {1} in module GameData.", game_data.to_s)
  end
  game_data_module = GameData.const_get(game_data.to_sym)
  commands = []
  game_data_module.each do |data|
    name = data.real_name
    name = yield(data) if block_given?
    next if !name
    commands.push([commands.length + 1, name, data.id])
  end
  return pbChooseList(commands, default, nil, 1)
end

#===============================================================================
# This move is physical if user's Attack is higher than its Special Attack
# (after applying stat stages), and special otherwise. 
# Changes type to Tera Type and does more damage if Terastallized (Tera Blast)
#===============================================================================
class Battle::Move::CategoryDependsOnHigherDamageTera < Battle::Move
  def initialize(battle, move)
    super
    @calcCategory = 1
  end

  def physicalMove?(thisType = nil); return (@calcCategory == 0); end
  def specialMove?(thisType = nil);  return (@calcCategory == 1); end
  
  # def pbBaseDamage(baseDmg, user, target)
    # baseDmg *= 2 if user.tera_active
    # return baseDmg
  # end  
  
  def pbBaseType(user)
    ret = :NORMAL
	if user.tera_active
		ret = user.pokemon.tera_type[0]
	end
	return ret
  end

  def pbOnStartUse(user, targets)
    # Calculate user's effective attacking value
    stageMul = [2, 2, 2, 2, 2, 2, 2, 3, 4, 5, 6, 7, 8]
    stageDiv = [8, 7, 6, 5, 4, 3, 2, 2, 2, 2, 2, 2, 2]
    atk        = user.attack
    atkStage   = user.stages[:ATTACK] + 6
    realAtk    = (atk.to_f * stageMul[atkStage] / stageDiv[atkStage]).floor
    spAtk      = user.spatk
    spAtkStage = user.stages[:SPECIAL_ATTACK] + 6
    realSpAtk  = (spAtk.to_f * stageMul[spAtkStage] / stageDiv[spAtkStage]).floor
    # Determine move's category
    @calcCategory = (realAtk > realSpAtk) ? 0 : 1
  end
end
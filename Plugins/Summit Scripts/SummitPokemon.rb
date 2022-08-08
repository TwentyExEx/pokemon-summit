$allstats = [:HP, :ATTACK, :DEFENSE, :SPECIAL_ATTACK, :SPECIAL_DEFENSE, :SPEED]

def pbSummitSelectPokemon
  allpkmn = SummitPokeInfo.allspecies
  num = rand(0...(allpkmn.length))
  pkmn = allpkmn[num]
  pbSummitMakePokemon(pkmn)
  return pkmn
end

def pbSummitMakePokemon(specform)
  pkmn = SummitPokeInfo.const_get(specform)
  specformformatted = pkmn[:species].clone.to_s
  if pkmn[:form] != 0
    specformformatted << "_" << pkmn[:form].to_s
  end
  @givepkmn = Pokemon.new(specformformatted, 50)
  for stat in $allstats
    @givepkmn.iv[stat] = 31
  end
  @givepkmn.happiness = 255
  @givepkmn.cannot_release = true

  for move in pkmn[:moves]
    @givepkmn.learn_move(move)
  end
  @givepkmn.ability_index = pkmn[:ability_index]
  return @givepkmn
end

def pbSummitGivePokemon(specform)
  pbSummitMakePokemon(specform)
  naturelist = []
  for i in GameData::Nature::DATA.keys
    if GameData::Nature.try_get(i).stat_changes.empty?
      naturelist.push(i.name)
    end
  end
  $game_variables[42].push(specform)
  @givepkmn.nature = naturelist[rand(0...naturelist.length)]
  @givepkmn.obtain_map = 2
  @givepkmn.obtain_text = "Summit Lobby"
  pbAddPokemonSilent(@givepkmn)
end

def pbSummitStorePokemon(pkmn)
  # Store the Pokémon
  cmds = [_INTL("Add to your party"),
          _INTL("Send to a Box"),
          _INTL("See {1}'s summary", pkmn.name),
          _INTL("Check party")]
  loop do
    cmd = pbMessage(_INTL("Where do you want to send {1} to?", pkmn.name), cmds, 99)
    cmd = 1 if cmd == 99   # Cancelling = send to a Box
    case cmd
    when 0   # Add to your party
      pbMessage(_INTL("Choose a Pokémon in your party to send to your Boxes."))
      pbChoosePokemon(1,3)
      choice = pbGet(3)
      next if choice == ""   # Cancelled
      party_index = pbGet(1)
      send_pkmn = pbGetPokemon(1)
      party_size = $player.party.length
      stored_box = $PokemonStorage.pbStoreCaught(send_pkmn)
      $player.party[party_index] = pkmn
      box_name  = $PokemonStorage[stored_box].name
      pbMessage(_INTL("{1} has been sent to Box \"{2}\".", send_pkmn.name, box_name))
      break
    when 1   # Send to a Box
      stored_box = $PokemonStorage.pbStoreCaught(pkmn)
      box_name   = $PokemonStorage[stored_box].name
      pbMessage(_INTL("{1} has been sent to Box \"{2}\"!", pkmn.name, box_name))
    when 2   # See X's summary
      pbFadeOutIn {
        summary_scene = PokemonSummary_Scene.new
        summary_screen = PokemonSummaryScreen.new(summary_scene, true)
        summary_screen.pbStartScreen([pkmn], 0)
      }
    when 3   # Check party
      pbFadeOutIn {
        sscene = PokemonParty_Scene.new
        sscreen = PokemonPartyScreen.new(sscene, $player.party)
        sscreen.pbPokemonScreen
      }
    end
  end
  # Messages saying the Pokémon was stored in a PC box
end

def pbSummitVendingPokemon
  if (SummitPokeInfo.allspecies.clone.uniq-$game_variables[42].clone.uniq).empty?
    return false
  end
  loop do
    pkmn = pbSummitSelectPokemon
    if !$game_variables[42].include?(pkmn) # not obtained
      pbShowPokemonSprite(pkmn)
      pbSummitGivePokemon(pkmn)
      return true
    end
  end
end

def pbSummitRocketInventory
  @pokesale = []
  3.times do
    pkmn = pbSummitSelectPokemon
    @pokemon=SummitPokeInfo.const_get(pkmn.to_s)[:species].to_s
    @form=SummitPokeInfo.const_get(pkmn.to_s)[:form].to_s
    case @form
     when "0"
       if GameData::Species.get(@pokemon).form_name
         @dispform = GameData::Species.get(@pokemon).form_name
       else
         @dispform=""
       end
       @specform = @pokemon
     else
       @dispform="_"
       @dispform << @form
       @specform = @pokemon.clone << @dispform
     end
    case @dispform
      when ""
        dispname = GameData::Species.get(@pokemon.to_sym).real_name
      else
        dispname = GameData::Species.get(@specform).form_name.clone
        dispname << " "<< GameData::Species.get(@specform).real_name
    end
    @pokesale.push(dispname)
  end
  @pokesale.push("Cancel")
end

def pbSummitRocketPokemon
  if $game_switches[44] == false
    pbMessage("\\rWe're all out o' stock, actually. Come back another time.")
    return false
  else
    $game_switches[44] = true
  end
  if $game_switches[43] == true
    pbSummitRocketInventory
    $game_switches[43] = false
  end
  cmd = pbMessage("\\rWhich of these Pokémon would you like to purchase?",@pokesale,3)
  if cmd < 0 || cmd == 3
    pbMessage("\\rYour loss.")
    return false
  else
    pbMessage("\\rOne #{@pokesale[cmd]}... That'll be $1,000. Sound good to you?",["Yes","No"],2)
    if cmd == 2
      pbMessage("\\rYour loss.")
      return false
    else
      pkmn = @pokesale[cmd].upcase.to_sym
      pbShowPokemonSprite(pkmn)
      pbSummitGivePokemon(pkmn)
      pbMessage("\\G\\rI'll take that cash now.")
      pbSEPlay("Slots coin")
      $Trainer.money -= 1000
      pbMessage("\\rYour brand new #{@pokesale[cmd]} has been put into your PC.")
      pbMessage("\\rAnd remember, no refunds!")
      $game_switches[44] = false
      return true
    end
  end
end

def pbSummitMonkey
    pbSummitGivePokemon(:SIMISAGE)
    pbSummitGivePokemon(:SIMISEAR)
    pbSummitGivePokemon(:SIMIPOUR)
end

def pbSummitChooseRegion # Unused
  regionlist = ["Kanto","Johto","Hoenn","Sinnoh","Unova","Kalos","Alola","Galar"]
  cmd = pbMessage("\\rWhat Pokémon starter set would you like to claim?",regionlist)
  pbSummitGetStarterSet(regionlist[cmd])
end

def pbSummitGetStarterSet(region) # Unused
  case region.downcase
    when "kanto"
      pbSummitGivePokemon(:VENUSAUR)
      pbSummitGivePokemon(:CHARIZARD)
      pbSummitGivePokemon(:BLASTOISE)
      pbSummitGivePokemon(:RAICHU)
      pbSummitGivePokemon(:PIDGEOT)
      pbSummitGivePokemon(:HITMONLEE)
    when "johto"
      pbSummitGivePokemon(:MEGANIUM)
      pbSummitGivePokemon(:TYPHLOSION)
      pbSummitGivePokemon(:FERALIGATR)
      pbSummitGivePokemon(:AMPHAROS)
      pbSummitGivePokemon(:NOCTOWL)
      pbSummitGivePokemon(:HITMONTOP)
    when "hoenn"
      pbSummitGivePokemon(:SCEPTILE)
      pbSummitGivePokemon(:BLAZIKEN)
      pbSummitGivePokemon(:SWAMPERT)
      pbSummitGivePokemon(:MANECTRIC)
      pbSummitGivePokemon(:SWELLOW)
      pbSummitGivePokemon(:HARIYAMA)
    when "sinnoh"
      pbSummitGivePokemon(:TORTERRA)
      pbSummitGivePokemon(:INFERNAPE)
      pbSummitGivePokemon(:EMPOLEON)
      pbSummitGivePokemon(:LUXRAY)
      pbSummitGivePokemon(:STARAPTOR)
      pbSummitGivePokemon(:LUCARIO)
    when "unova"
      pbSummitGivePokemon(:SERPERIOR)
      pbSummitGivePokemon(:EMBOAR)
      pbSummitGivePokemon(:SAMUROTT)
      pbSummitGivePokemon(:ZEBSTRIKA)
      pbSummitGivePokemon(:UNFEZANT)
      pbSummitGivePokemon(:CONKELDURR)
    when "kalos"
      pbSummitGivePokemon(:CHESNAUGHT)
      pbSummitGivePokemon(:DELPHOX)
      pbSummitGivePokemon(:GRENINJA)
      pbSummitGivePokemon(:HELIOLISK)
      pbSummitGivePokemon(:TALONFLAME)
      pbSummitGivePokemon(:PANGORO)
    when "alola"
      pbSummitGivePokemon(:DECIDUEYE)
      pbSummitGivePokemon(:INCINEROAR)
      pbSummitGivePokemon(:PRIMARINA)
      pbSummitGivePokemon(:VIKAVOLT)
      pbSummitGivePokemon(:TOUCANNON)
      pbSummitGivePokemon(:CRABOMINABLE)
    when "galar"
      pbSummitGivePokemon(:RILLABOOM)
      pbSummitGivePokemon(:CINDERACE)
      pbSummitGivePokemon(:INTELEON)
      pbSummitGivePokemon(:TOXTRICITY)
      pbSummitGivePokemon(:CORVIKNIGHT)
      pbSummitGivePokemon(:GRAPPLOCT)
  end
end

def pbSummitGiveGiftPokemon
  for i in $game_variables[44]
    possiblegift = SummitGifts.const_get(i[0].to_s)[:species]
    allgifts = []
    for pkmn in possiblegift
      allgifts.push(pkmn)
    end
    if (allgifts.uniq-$game_variables[44].clone.uniq).empty?
      return false
    end
  end
  loop do
    alltrainers = []
    for trainer in $game_variables[44]
      if !trainer.is_a?(Array)
        name = trainer.clone
        name.gsub!(/(\w+)_/) {|word| ""}
          alltrainers.push([trainer, name, 0])
      else 
        alltrainers.push(trainer)
      end
    end
    size = alltrainers.size
    num = rand(0..size)
    trainer = alltrainers[num]
    @gift = SummitGifts.const_get(trainer[0].to_s)
    pkmn = @gift[:species]
    if $game_variables[42].include?(pkmn) # obtained
      return false
      break
    else
      pbMessage("\\rHello, \\PN!")
      pbMessage("\\r#{@gift[:name]} left this for you.")
      pbShowPokemonSprite(@gift[:species])
      pbSummitMakePokemon(@gift[:species])
      @givepkmn.owner = Pokemon::Owner.new_foreign(trainer[1].to_s, GameData::TrainerType.get(trainer[0]).gender)
      naturelist = []
      for i in GameData::Nature::DATA.keys
        if GameData::Nature.try_get(i).stat_changes.empty?
          naturelist.push(i.name)
        end
      end
      @givepkmn.nature = naturelist[rand(0...naturelist.length)]
      pbAddPokemonSilent(@givepkmn)
      pbMessage("\\rTake good care of that #{$dispname}!")
      $game_variables[42].push(@gift[:species])
      return true
    end
    break
  end
end

def pbSummitCallGift
  if $game_switches[40] == true
    return true
  end
  if $game_switches[39] == true
    num = rand(1..100)
    if ($game_variables[35] == "challenge" && $game_variables[32] == 1) && num > 75
      return true
    elsif num > 90
      return true
    else
      return false
    end
  end
end
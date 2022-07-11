def pbSummitMakePokemon(species, move1, move2, move3, move4)
  @pkmn = Pokemon.new(species, 50)
  pokeStats = [:HP, :ATTACK, :DEFENSE, :SPECIAL_ATTACK, :SPECIAL_DEFENSE, :SPEED]
  for stat in pokeStats
    @pkmn.iv[stat] = 31
  end
  @pkmn.happiness = 255
  @pkmn.cannot_release = true
  pokeMoves = [move1, move2, move3, move4]
  for move in pokeMoves
    @pkmn.learn_move(move)
  end
  return @pkmn
end

def pbSummitGivePokemon(species, move1, move2, move3, move4)
  pbSummitMakePokemon(species, move1, move2, move3, move4)
  pbAddPokemonSilent(@pkmn)
end

def pbSummitGauntletSelection(gauntlet)
  trainerSelection = []

  case gauntlet.downcase
    when "kanto"
      trainerlist = [
        ["LEADER_Brock","Brock",0],
        ["LEADER_Misty","Misty",0],
        ["LEADER_Surge","Lt. Surge",0],
        ["LEADER_Erika","Erika",0],
        ["LEADER_Janine","Janine",0],
        ["LEADER_Sabrina","Sabrina",0],
        ["LEADER_Blaine","Blaine",0],
        ["LEADER_Giovanni","Giovanni",0]
      ]
  end
  (1..4).each {
    num = rand(0...(trainerlist.length))
    trainer = trainerlist[num]
    if !trainerSelection.include?(trainer)
      trainerSelection.push(trainer)
      break
    end
  }
  $game_variables[29] = trainerSelection
end

def pbSummitPrepGauntletTrainer
  trainers = $game_variables[29]
  order = $game_variables[31]
  trainer = trainers[order]
  $game_variables[30] = trainer[0]
end

def pbSummitGauntletTrainer
    pbSummitPrepBattle
  TrainerBattle.start(trainer)
  if $game_variables[1] = 1
    $game_variables[31] += 1
  end
end

def pbSummitPrepBattle
  setBattleRule("canLose")
  setBattleRule("cannotRun")
  setBattleRule("noExp")
  setBattleRule("noMoney")
  setBattleRule("disablePokeBalls")
  setBattleRule("setStyle")
  tempParty = []
  for i in $Trainer.party
    clonepoke = i.clone
    # clonepoke.ev = i.ev.clone
    clonepoke.iv = i.iv.clone
    for j in 0...$Trainer.party.length
      # clonepoke.ev[j] = i.ev[j]
      clonepoke.iv[j] = i.iv[j]
    end
    clonepoke.level = 50 # Set this to whatever preset level you want
    clonepoke.calc_stats
    clonepoke.item = nil
    clonepoke.mail = nil
    tempParty.push(clonepoke)
  end
    $game_variables[27] = $Trainer.party
    $Trainer.party = tempParty
    $game_variables[28] = tempParty
    $game_switches[36] = true
end

def pbSummitPartyRefresh
  $Trainer.party = $game_variables[35]
end

def pbSummitEndBattle(trainertype, name)
  pbSummitDeleteTrainer(trainertype, name)
  $Trainer.party = $game_variables[27]
  $game_switches[36] = false
end

def pbSummitArcadeTrainer(party_size)
  if party_size
    allTypes = [:YOUNGSTER, :SCHOOL_KID, :LASS, :BUG_CATCHER]
    
    namesFem = ["Emma","Sophia","Olivia","Isabella","Ava","Mia","Abigail","Emily","Madison","Charlotte","Elizabeth","Amelia","Chloe","Ella","Evelyn","Avery","Sofia","Harper","Grace","Addison","Victoria","Natalie","Lily","Aubrey","Lillian","Zoey","Hannah","Layla","Brooklyn","Samantha","Zoe","Leah","Scarlett","Riley","Camila","Savannah","Anna","Audrey","Allison","Aria","Gabriella","Hailey","Claire","Sarah","Aaliyah","Kaylee","Nevaeh","Penelope","Alexa","Arianna","Stella","Alexis","Bella","Nora","Ellie","Ariana","Lucy","Mila","Peyton","Genesis","Alyssa","Taylor","Violet","Maya","Caroline","Madelyn","Skylar","Serenity","Ashley","Brianna","Kennedy","Autumn","Eleanor","Kylie","Sadie","Paisley","Julia","Mackenzie","Sophie","Naomi","Eva","Khloe","Katherine","Gianna","Melanie","Aubree","Piper","Ruby","Lydia","Faith","Madeline","Alexandra","Kayla","Hazel","Lauren","Annabelle","Jasmine","Aurora","Alice","Makayla","Sydney","Bailey","Luna","Maria","Reagan","Morgan","Isabelle","Rylee","Kimberly","Andrea","London","Elena","Jocelyn","Natalia","Trinity","Eliana","Vivian","Cora","Quinn","Liliana","Molly","Jade","Clara","Valentina","Mary","Brielle","Hadley","Kinsley","Willow","Brooke","Lilly","Delilah","Payton","Mariah","Paige","Jordyn","Nicole","Mya","Josephine","Isabel","Lyla","Adeline","Destiny","Ivy","Emilia","Rachel","Angelina","Valeria","Kendall","Sara","Ximena","Isla","Aliyah","Reese","Vanessa","Juliana","Mckenzie","Amy","Laila","Adalynn","Emery","Margaret","Eden","Gabrielle","Kaitlyn","Ariel","Gracie","Brooklynn","Melody","Jessica","Valerie","Adalyn","Adriana","Elise","Michelle","Rebecca","Daisy","Everly","Katelyn","Ryleigh","Catherine","Norah","Alaina","Athena","Leilani","Londyn","Eliza","Jayla","Summer","Lila","Makenzie","Izabella","Daniela","Stephanie","Julianna","Rose","Alana","Harmony","Jennifer","Maximus","Hayden"]
    namesMale = ["Noah","Liam","Jacob","Mason","William","Ethan","Michael","Alexander","James","Elijah","Daniel","Benjamin","Aiden","Jayden","Logan","Matthew","David","Joseph","Lucas","Jackson","Anthony","Joshua","Samuel","Andrew","Gabriel","Christopher","John","Dylan","Carter","Isaac","Ryan","Luke","Oliver","Nathan","Henry","Owen","Caleb","Wyatt","Christian","Sebastian","Jack","Jonathan","Landon","Julian","Isaiah","Hunter","Levi","Aaron","Eli","Charles","Thomas","Connor","Brayden","Nicholas","Jaxon","Jeremiah","Cameron","Evan","Adrian","Jordan","Gavin","Grayson","Angel","Robert","Tyler","Josiah","Austin","Colton","Brandon","Jose","Dominic","Kevin","Zachary","Ian","Chase","Jason","Adam","Ayden","Parker","Hudson","Cooper","Nolan","Lincoln","Xavier","Carson","Jace","Justin","Easton","Mateo","Asher","Bentley","Blake","Nathaniel","Jaxson","Leo","Kayden","Tristan","Luis","Elias","Brody","Bryson","Juan","Vincent","Cole","Micah","Ryder","Theodore","Carlos","Ezra","Damian","Miles","Santiago","Max","Jesus","Leonardo","Sawyer","Diego","Alex","Roman","Maxwell","Eric","Greyson","Hayden","Giovanni","Wesley","Axel","Camden","Braxton","Ivan","Ashton","Declan","Bryce","Timothy","Antonio","Silas","Kaiden","Ezekiel","Jonah","Weston","George","Harrison","Steven","Miguel","Richard","Bryan","Kaleb","Victor","Aidan","Jameson","Joel","Patrick","Jaden","Colin","Everett","Preston","Maddox","Edward","Alejandro","Kaden","Jesse","Emmanuel","Kyle","Brian","Emmett","Jude","Marcus","Kingston","Kai","Alan","Malachi","Grant","Jeremy","Riley","Jayce","Bennett","Abel","Ryker","Caden","Brantley","Luca","Brady","Calvin","Sean","Oscar","Jake","Maverick","Abraham","Mark","Tucker","Nicolas","Bradley","Kenneth","Avery","Cayden","King","Paul","Amir","Gael","Graham"]

    trainertype = allTypes[rand(allTypes.length)]

    if GameData::TrainerType.get(trainertype).gender == 1
      name = namesFem[rand(namesFem.length)]
    else
      name = namesMale[rand(namesMale.length)]
    end
    pbNewSummitTrainer(party_size, trainertype, name)
    GameData::TrainerType.get(trainertype).id
    pbSummitPrepBattle
    TrainerBattle.start(trainertype, name)
    pbSummitEndBattle(trainertype, name)
  else
    pbMessage(_INTL("A team must have at least 1 Pokémon!"))
  end
end

def pbSummitChoosePokemon(tr_type, party_size)
  type = tr_type.to_s.downcase
  num = nil
  party = []
  pkmnlist = []

  case type
  when "youngster", "school_kid"
    pkmnlist = [
      ["RATICATE","QUICKATTACK","CRUNCH","SWORDSDANCE","DIG",0],
      ["ARBOK","CRUNCH","GUNKSHOT","ICEFANG","GLARE",0],
      ["FEAROW","DRILLRUN","AERIALACE","UTURN","STEELWING",0],
      ["PIDGEOT","AIRSLASH","ROOST","AERIALACE","QUICKATTACK",0],
      ["SANDSLASH","EARTHQUAKE","ROLLOUT","SWORDSDANCE","SLASH",0],
      ["NIDOKING","POISONJAB","EARTHQUAKE","MEGAHORN","TOXIC",0],
      ["NIDOQUEEN","TOXICSPIKES","CRUNCH","EARTHPOWER","SUPERPOWER",0],
      ["GOLEM","EARTHQUAKE","STONEEDGE","HEAVYSLAM","SANDSTORM",0],
      ["PRIMEAPE","OUTRAGE","STOMPINGTANTRUM","CLOSECOMBAT","SWAGGER",0],
      ["DUGTRIO","SANDTOMB","NIGHTSLASH","EARTHQUAKE","SANDSTORM",0],
      ["FURRET","SLAM","FACADE","IRONTAIL","REST",0],
      ["NOCTOWL","AIRSLASH","HYPNOSIS","DREAMEATER","MOONBLAST",0],
      ["QUAGSIRE","EARTHQUAKE","AQUATAIL","BRICKBREAK","ROCKTOMB",0],
      ["MIGHTYENA","FIREFANG","THUNDERFANG","ICEFANG","CRUNCH",0],
      ["SWELLOW","BRAVEBIRD","AERIALACE","QUICKATTACK","UTURN",0],
      ["SHIFTRY","LEAFBLADE","FOULPLAY","LOWSWEEP","PROTECT",0],
      ["LUDICOLO","GIGADRAIN","HYDROPUMP","ICEBEAM","RAINDANCE",0],
      ["MANECTRIC","THUNDERBOLT","VOLTSWITCH","ELECTRICTERRAIN","FLAMETHROWER",0],
      ["SWALOT","SLUDGEBOMB","TOXIC","SHADOWBALL","EARTHQUAKE",0],
      ["STARAPTOR","AERIALACE","CLOSECOMBAT","STEELWING","DOUBLETEAM",0],
      ["KRICKETUNE","XSCISSOR","NIGHTSLASH","STICKYWEB","AERIALACE",0],
      ["LUXRAY","WILDCHARGE","THUNDERFANG","PSYCHICFANGS","ROAR",0],
      ["SKUNTANK","FLAMETHROWER","THIEF","SHADOWCLAW","POISONJAB",0],
      ["BIBAREL","WATERFALL","BULLDOZE","THUNDERWAVE","YAWN",0],
      ["GASTRODON","MUDDYWATER","WATERPULSE","ANCIENTPOWER","EARTHPOWER",0],
      ["WATCHOG","HYPERFANG","HYPNOSIS","NASTYPLOT","BATONPASS",0],
      ["STOUTLAND","PLAYROUGH","DIG","IRONHEAD","CRUNCH",0],
      ["SEISMITOAD","DRAINPUNCH","LIQUIDATION","ROCKSLIDE","SUPERSONIC",0],
      ["SCOLIPEDE","MEGAHORN","TOXIC","CROSSPOISON","XSCISSOR",0],
      ["CONKELDURR","HAMMERARM","STONEEDGE","STOMPINGTANTRUM","BRUTALSWING",0],
      ["UNFEZANT","SKYATTACK","GIGAIMPACT","BRAVEBIRD","REST",0],
      ["SAWSBUCK","MEGAHORN","HORNLEECH","JUMPKICK","LEECHSEED",0],
      ["GALVANTULA","BUGBUZZ","ELECTROBALL","DISCHARGE","STICKYWEB",0],
      ["TALONFLAME","AERIALACE","FLAMECHARGE","ACROBATICS","FLAREBLITZ",0],
      ["DIGGERSBY","EARTHQUAKE","HAMMERARM","SWORDSDANCE","BOUNCE",0],
      ["PYROAR","FLAMETHROWER","HYPERVOICE","DARKPULSE","WILLOWISP",0],
      ["GUMSHOOS","HYPERFANG","CRUNCH","BULLDOZE","SUBSTITUTE",0],
      ["VIKAVOLT","ZAPCANNON","THUNDERBOLT","BUGBUZZ","FLASHCANNON",0],
      ["RATICATE","CRUNCH","SUCKERPUNCH","DOUBLEEDGE","SCARYFACE",1],
      ["MUK","GUNKSHOT","KNOCKOFF","TOXIC","VENOMDRENCH",1],
      ["LYCANROC","ACCELEROCK","STONEEDGE","CRUNCH","THUNDERFANG",0],
      ["ORBEETLE","PSYCHIC","BUGBUZZ","REFLECT","LIGHTSCREEN",0],
      ["THIEVUL","NIGHTSLASH","FOULPLAY","PLAYROUGH","DIG",0],
      ["GREEDENT","STUFFCHEEKS","STOCKPILE","SPITUP","BELCH",0],
      ["ELDEGOSS","LEAFSTORM","LEAFTORNADO","POLLENPUFF","SING",0]
    ]
    when "lass"
      pkmnlist = [
        ["RATICATE","QUICKATTACK","CRUNCH","SWORDSDANCE","DIG",0],
        ["ARBOK","CRUNCH","GUNKSHOT","ICEFANG","GLARE",0],
        ["FEAROW","DRILLRUN","AERIALACE","UTURN","STEELWING",0],
        ["PIDGEOT","AIRSLASH","ROOST","AERIALACE","QUICKATTACK",0],
        ["SANDSLASH","EARTHQUAKE","ROLLOUT","SWORDSDANCE","SLASH",0],
        ["NIDOKING","POISONJAB","EARTHQUAKE","MEGAHORN","TOXIC",0],
        ["NIDOQUEEN","TOXICSPIKES","CRUNCH","EARTHPOWER","SUPERPOWER",0],
        ["WIGGLYTUFF","PLAYROUGH","PSYCHIC","THUNDERBOLT","MIMIC",0],
        ["CLEFABLE","MOONBLAST","METRONOME","PSYCHIC","FLAMETHROWER",0],
        ["VILEPLUME","GIGADRAIN","PETALDANCE","SLUDGEWAVE","DAZZLINGGLEAM",0],
        ["BELLOSSOM","MOONBLAST","SOLARBEAM","GIGADRAIN","MOONLIGHT",0],
        ["RAICHU","THUNDER","RAINDANCE","THUNDERBOLT","SURF",0],
        ["PERSIAN","ASSURANCE","SLASH","PLAYROUGH","DIG",0],
        ["FURRET","SLAM","FACADE","IRONTAIL","REST",0],
        ["QUAGSIRE","EARTHQUAKE","AQUATAIL","BRICKBREAK","ROCKTOMB",0],
        ["AZUMARILL","AQUATAIL","PLAYROUGH","BULLDOZE","BOUNCE",0],
        ["AMPHAROS","DRAGONPULSE","POWERGEM","DISCHARGE","LIGHTSCREEN",0],
        ["GOLDUCK","HYDROPUMP","SURF","PSYCHIC","CALMMIND",0],
        ["GRANBULL","PLAYROUGH","OUTRAGE","CRUNCH","TAUNT",0],
        ["SHIFTRY","LEAFBLADE","FOULPLAY","LOWSWEEP","PROTECT",0],
        ["LUDICOLO","GIGADRAIN","HYDROPUMP","ICEBEAM","RAINDANCE",0],
        ["BRELOOM","DRAINPUNCH","SEEDBOMB","MACHPUNCH","STONEEDGE",0],
        ["DELCATTY","PLAYROUGH","FAKEOUT","STRENGTH","FACADE",0],
        ["SWELLOW","BRAVEBIRD","AERIALACE","QUICKATTACK","UTURN",0],
        ["BIBAREL","WATERFALL","BULLDOZE","THUNDERWAVE","YAWN",0],
        ["PACHIRISU","SPARK","THUNDERWAVE","SUPERFANG","LASTRESORT",0],
        ["LOPUNNY","CLOSECOMBAT","BOUNCE","PLAYROUGH","DRAINPUNCH",0],
        ["ROSERADE","GIGADRAIN","TOXICSPIKES","LEECHSEED","GRASSYTERRAIN",0],
        ["STARAPTOR","AERIALACE","CLOSECOMBAT","STEELWING","DOUBLETEAM",0],
        ["WHIMSICOTT","MOONBLAST","SUNNYDAY","SOLARBEAM","ENERGYBALL",0],
        ["LILLIGANT","ENERGYBALL","SYNTHESIS","PETALDANCE","QUIVERDANCE",0],
        ["LIEPARD","NIGHTSLASH","SUCKERPUNCH","PLAYROUGH","SHADOWCLAW",0],
        ["SWOOBAT","PSYCHIC","AIRSLASH","FUTURESIGHT","HEATWAVE",0],
        ["TOGEKISS","ANCIENTPOWER","AIRSLASH","DAZZLINGGLEAM","AURASPHERE",0],
        ["SWANNA","AERIALACE","HURRICANE","WATERPULSE","ICEBEAM",0],
        ["FLORGES","MISTYTERRAIN","MOONBLAST","GRASSKNOT","HIDDENPOWER",0],
        ["DEDENNE","THUNDER","PARABOLICCHARGE","DAZZLINGGLEAM","ELECTROWEB",0],
        ["DIGGERSBY","EARTHQUAKE","HAMMERARM","SWORDSDANCE","BOUNCE",0],
        ["KOMALA","WOODHAMMER","THRASH","ROLLOUT","RAPIDSPIN",0],
        ["LYCANROC","STONEEDGE","STEALTHROCK","ROCKSLIDE","CRUNCH",2],
        ["TOUCANNON","BEAKBLAST","ROCKBLAST","BULLETSEED","PLUCK",0],
        ["TSAREENA","TROPKICK","POWERWHIP","HIGHJUMPKICK","UURN",0],
        ["ARAQUANID","LEECHLIFE","LIQUIDATION","CRUNCH","RAINDANCE",0],
        ["HATTERENE","PSYCHIC","DAZZLINGGLEAM","CALMMIND","SHADOWBALL",0],
        ["GRIMMSNARL","PLAYROUGH","FOULPLAY","SPIRITBREAK","FALSESURRENDER",0],
        ["DREDNAW","LIQUIDATION","RAZORSHELL","HEADSMASH","CRUNCH",0],
        ["ALCREMIE","DAZZLINGGLEAM","ENERGYBALL","MYSTICALFIRE","LIGHTSCREEN",0]
      ]
    when "bug_catcher"
      pkmnlist = [
        ["BUTTERFREE","BUGBUZZ","PSYCHIC","POISONPOWDER","AIRSLASH",0],
        ["BEEDRILL","POISONJAB","BUGBITE","ENDEAVOR","ASSURANCE",0],
        ["VENOMOTH","BUGBUZZ","ENERGYBALL","SLUDGEBOMB","PROTECT",0],
        ["PINSIR","SUPERPOWER","XSCISSOR","SWORDSDANCE","SUBMISSION",0],
        ["PARASECT","CROSSPOISON","XSCISSOR","STUNSPORE","POISONPOWDER",0],
        ["SCIZOR","BULLETPUNCH","IRONHEAD","XSCISSOR","SWORDSDANCE",0],
        ["LEDIAN","BUGBUZZ","AIRSLASH","REFLECT","LIGHTSCREEN",0],
        ["ARIADOS","LEECHLIFE","POISONJAB","CROSSPOISON","SHADOWSNEAK",0],
        ["FORRETRESS","HEAVYSLAM","GYROBALL","SPIKES","TOXICSPIKES",0],
        ["HERACROSS","FACADE","THROATCHOP","MEGAHORN","CLOSECOMBAT",0],
        ["BEAUTIFLY","GIGADRAIN","PROTECT","QUIVERDANCE","BUGBUZZ",0],
        ["DUSTOX","TOXIC","VENOSHOCK","LEECHLIFE","PROTECT",0],
        ["MASQUERAIN","STICKYWEB","BUGBUZZ","AIRSLASH","SCALD",0],
        ["NINJASK","XSCISSOR","METALCLAW","AERIALACE","PROTECT",0],
        ["SHEDINJA","SHADOWCLAW","DIG","PHANTOMFORCE","SPITE",0],
        ["WORMADAM","PSYCHIC","BUGBUZZ","PROTECT","ENERGYBALL",0],
        ["WORMADAM","PSYCHIC","BUGBUZZ","PROTECT","EARTHPOWER",1],
        ["WORMADAM","PSYCHIC","BUGBUZZ","PROTECT","IRONHEAD",2],
        ["MOTHIM","PSYCHIC","BUGBUZZ","PROTECT","AIRSLASH",0],
        ["VESPIQUEN","ATTACKORDER","DEFENDORDER","POWERGEM","AIRSLASH",0],
        ["SCOLIPEDE","MEGAHORN","TOXIC","CROSSPOISON","XSCISSOR",0],
        ["CRUSTLE","XSCISSOR","STEALTHROCK","SHELLSMASH","ROCKSLIDE",0],
        ["ESCAVALIER","IRONHEAD","SWORDSDANCE","XSCISSOR","BRUTALSWING",0],
        ["GALVANTULA","BUGBUZZ","ELECTROBALL","DISCHARGE","STICKYWEB",0],
        ["VIVILLON","DRAININGKISS","LIGHTSCREEN","SUPERSONIC","BUGBUZZ",0],
        ["VIKAVOLT","ZAPCANNON","THUNDERBOLT","BUGBUZZ","FLASHCANNON",0],
        ["RIBOMBEE","POLLENPUFF","DAZZLINGGLEAM","QUIVERDANCE","CALMMIND",0],
        ["GOLISOPOD","LIQUIDATION","FIRSTIMPRESSION","SUCKERPUNCH","XSCISSOR",0],
        ["ORBEETLE","PSYCHIC","BUGBUZZ","REFLECT","LIGHTSCREEN",0],
        ["ARMALDO","METALCLAW","XSCISSOR","STONEEDGE","PROTECT",0],
        ["ARAQUANID","LEECHLIFE","LIQUIDATION","CRUNCH","RAINDANCE",0],
        ["CENTISKORCH","FIRELASH","LUNGE","CRUNCH","POWERWHIP",0],
        ["FROSMOTH","ICEBEAM","BUGBUZZ","STUNSPORE","TAILWIND",0],
        ["KRICKETUNE","XSCISSOR","NIGHTSLASH","STICKYWEB","AERIALACE",0],
        ["ACCELGOR","BUGBUZZ","TOXIC","WATERSHURIKEN","GIGADRAIN",0]
      ]
  end
  for i in 0...party_size
    loop do
      num = rand(0...(pkmnlist.length))
      pkmn = pkmnlist[num]
      if !party.include?(pkmn)
        party.push(pkmn)
        break
      end
    end
  end
  return party
end

def pbNewSummitTrainer(party_size, tr_type, tr_name, tr_version = 0, save_changes = true)
  party = pbSummitChoosePokemon(tr_type, party_size)
  for i in 0...party_size
    loop do
      if party
        pkmn = party[i]
        if pkmn[5] == nil
          pkmn[5] = 0
        end
        break
      else
        pbMessage(_INTL("This trainer must have at least 1 Pokémon!"))
        break
      end
    end
  end
  trainer = [tr_type, tr_name, [], party, tr_version]
  pokeStats = [:HP, :ATTACK, :DEFENSE, :SPECIAL_ATTACK, :SPECIAL_DEFENSE, :SPEED]
  if save_changes
    @trainer_hash = {
      :trainer_type => tr_type,
      :name         => tr_name,
      :version      => tr_version,
      :pokemon      => []
    }
    party.each do |pkmn|
      @trainer_hash[:pokemon].push(
        {
          :species => pkmn[0],
          :level   => 50,
          :moves   => [pkmn[1], pkmn[2], pkmn[3], pkmn[4]],
          :iv      => {:HP => 31, :ATTACK => 31, :DEFENSE => 31, :SPECIAL_ATTACK => 31, :SPECIAL_DEFENSE => 31, :SPEED => 31},
          :form    => pkmn[5],
          :item    => pkmn[6]
        }
      )
    end
    # Add trainer's data to records
    @trainer_hash[:id] = [@trainer_hash[:trainer_type], @trainer_hash[:name], @trainer_hash[:version]]
    GameData::Trainer.register(@trainer_hash)
    GameData::Trainer.save
    pbConvertTrainerData
  end
  return trainer
end

def pbSummitDeleteTrainer(tr_type, name, tr_version = 0)
  # Remove trainer's data from records
  trainer_id = [tr_type, name, tr_version]
  tr_data = GameData::Trainer::DATA[trainer_id]
  GameData::Trainer::DATA.delete(trainer_id)
  GameData::Trainer.save
  pbConvertTrainerData
end

def pbSummitMakerKanto
  pbSummitGivePokemon(:VENUSAUR, :SEEDBOMB, :LEECHSEED, :TAKEDOWN, :SYNTHESIS)
  pbSummitGivePokemon(:CHARIZARD, :AIRSLASH, :FLAMETHROWER, :DRAGONCLAW, :SLASH)
  pbSummitGivePokemon(:BLASTOISE, :WATERPULSE, :PROTECT, :FLASHCANNON, :AQUATAIL)
  pbSummitGivePokemon(:RAICHU, :THUNDERPUNCH, :THUNDERWAVE, :QUICKATTACK, :THUNDERBOLT)
  pbSummitGivePokemon(:PIDGEOT, :AERIALACE, :AGILITY, :TWISTER, :WHIRLWIND)
  pbSummitGivePokemon(:HITMONLEE, :BRICKBREAK, :ENDURE, :REVENGE, :FOCUSENERGY)
end

def pbSummitMakerJohto
  pbSummitGivePokemon(:MEGANIUM,  :PETALBLIZZARD, :BODYSLAM, :SOLARBEAM, :REFLECT)
  pbSummitGivePokemon(:TYPHLOSION, :FLAMEWHEEL, :FLAMETHROWER, :ROLLOUT, :SMOKESCREEN)
  pbSummitGivePokemon(:FERALIGATR, :AQUATAIL, :ICEFANG, :BITE, :SCARYFACE)
  pbSummitGivePokemon(:AMPHAROS, :DISCHARGE, :LIGHTSCREEN, :DRAGONPULSE, :COTTONGUARD)
  pbSummitGivePokemon(:NOCTOWL, :AIRSLASH, :ROOST, :MOONBLAST, :REFLECT)
  pbSummitGivePokemon(:HITMONTOP, :DIG, :TRIPLEKICK, :CLOSECOMBAT, :FOCUSENERGY)
end

def pbSummitMakerHoenn
  pbSummitGivePokemon(:SCEPTILE, :DUALCHOP, :LEAFBLADE, :XSCISSOR, :SCREECH)
  pbSummitGivePokemon(:BLAZIKEN, :BLAZEKICK, :AERIALACE, :CLOSECOMBAT, :FEATHERDANCE)
  pbSummitGivePokemon(:SWAMPERT, :MUDDYWATER, :EARTHQUAKE, :WATERPULSE, :AMNESIA)
  pbSummitGivePokemon(:MANECTRIC, :DISCHARGE, :SHOCKWAVE, :BITE, :ELECTRICTERRAIN)
  pbSummitGivePokemon(:SWELLOW, :BRAVEBIRD, :AERIALACE, :REVERSAL, :DOUBLETEAM)
  pbSummitGivePokemon(:HARIYAMA, :HEAVYSLAM, :VITALTHROW, :BELLYDRUM, :SANDATTACK)
end

def pbSummitMakerSinnoh
  pbSummitGivePokemon(:TORTERRA, :CRUNCH, :WOODHAMMER, :EARTHQUAKE, :GROWTH)
  pbSummitGivePokemon(:INFERNAPE, :POWERUPPUNCH, :CLOSECOMBAT, :FLAMETHROWER, :CALMMIND)
  pbSummitGivePokemon(:EMPOLEON, :METALCLAW, :BRINE, :DRILLPECK, :SWORDSDANCE)
  pbSummitGivePokemon(:LUXRAY, :CRUNCH, :WILDCHARGE, :SPARK, :ELECTRICTERRAIN)
  pbSummitGivePokemon(:STARAPTOR, :BRAVEBIRD, :AERIALACE, :ENDEAVOR, :WHIRLWIND)
  pbSummitGivePokemon(:LUCARIO, :AURASPHERE, :METALCLAW, :BONERUSH, :SCREECH)
end

def pbSummitMakerUnova
  pbSummitGivePokemon(:SERPERIOR, :LEAFBLADE, :GIGADRAIN, :SLAM, :COIL)
  pbSummitGivePokemon(:EMBOAR, :HAMMERARM, :HEADSMASH, :FLAREBLITZ, :ROAR)
  pbSummitGivePokemon(:SAMUROTT, :SLASH, :RAZORSHELL, :MEGAHORN, :FOCUSENERGY)
  pbSummitGivePokemon(:ZEBSTRIKA, :FLAMECHARGE, :PURSUIT, :SPARK, :CHARGE)
  pbSummitGivePokemon(:UNFEZANT, :SKYATTACK, :FACADE, :AIRSLASH, :ROOST)
  pbSummitGivePokemon(:CONKELDURR, :STONEEDGE, :SUPERPOWER, :CHIPAWAY, :BULKUP)
end

def pbSummitMakerKalos
  pbSummitGivePokemon(:CHESNAUGHT, :WOODHAMMER, :SEEDBOMB, :ROLLOUT, :SPIKYSHIELD)
  pbSummitGivePokemon(:DELPHOX, :PSYCHIC, :FLAMETHROWER, :SHADOWBALL, :LIGHTSCREEN)
  pbSummitGivePokemon(:GRENINJA, :WATERPULSE, :NIGHTSLASH, :SHADOWSNEAK, :DOUBLETEAM)
  pbSummitGivePokemon(:HELIOLISK, :PARABOLICCHARGE, :BULLDOZE, :THUNDERBOLT, :THUNDERWAVE)
  pbSummitGivePokemon(:TALONFLAME, :FLY, :FLAMECHARGE, :ACROBATICS, :ROOST)
  pbSummitGivePokemon(:PANGORO, :NIGHTSLASH, :HAMMERARM, :BODYSLAM, :WORKUP)
end

def pbSummitMakerKalos
  pbSummitGivePokemon(:CHESNAUGHT, :WOODHAMMER, :SEEDBOMB, :ROLLOUT, :SPIKYSHIELD)
  pbSummitGivePokemon(:DELPHOX, :PSYCHIC, :FLAMETHROWER, :SHADOWBALL, :LIGHTSCREEN)
  pbSummitGivePokemon(:GRENINJA, :WATERPULSE, :NIGHTSLASH, :SHADOWSNEAK, :DOUBLETEAM)
  pbSummitGivePokemon(:HELIOLISK, :PARABOLICCHARGE, :BULLDOZE, :THUNDERBOLT, :THUNDERWAVE)
  pbSummitGivePokemon(:TALONFLAME, :FLY, :FLAMECHARGE, :ACROBATICS, :ROOST)
  pbSummitGivePokemon(:PANGORO, :NIGHTSLASH, :HAMMERARM, :BODYSLAM, :WORKUP)
end

def pbSummitMakerAlola
  pbSummitGivePokemon(:DECIDUEYE, :SPIRITSHACKLE, :LEAFBLADE, :PLUCK, :SYNTHESIS)
  pbSummitGivePokemon(:INCINEROAR, :DARKESTLARIAT, :FIREFANG, :BITE, :SWAGGER)
  pbSummitGivePokemon(:PRIMARINA, :SPARKLINGARIA, :MOONBLAST, :ICYWIND, :MISTYTERRAIN)
  pbSummitGivePokemon(:VIKAVOLT, :THUNDERBOLT, :BUGBUZZ, :ZAPCANNON, :STICKYWEB)
  pbSummitGivePokemon(:TOUCANNON, :BEAKBLAST, :ROCKBLAST, :DRILLPECK, :SUPERSONIC)
  pbSummitGivePokemon(:CRABOMINABLE, :ICEPUNCH, :HAMMERARM, :DIZZYPUNCH, :IRONDEFENSE)
end

def pbSummitMakerGalar
  pbSummitGivePokemon(:RILLABOOM, :DRUMBEATING, :KNOCKOFF, :SLAM, :GRASSYTERRAIN)
  pbSummitGivePokemon(:CINDERACE, :PYROBALL, :BOUNCE, :HEADBUTT, :AGILITY)
  pbSummitGivePokemon(:INTELEON, :SNIPESHOT, :WATERPULSE, :UTURN, :RAINDANCE)
  pbSummitGivePokemon(:TOXTRICITY, :OVERDRIVE, :VENOSHOCK, :DISCHARGE, :SCREECH)
  pbSummitGivePokemon(:CORVIKNIGHT, :STEELWING, :PLUCK, :DRILLPECK, :IRONDEFENSE)
  pbSummitGivePokemon(:GRAPPLOCT, :OCTAZOOKA, :SUBMISSION, :BRICKBREAK, :OCTOLOCK)
end
$bracketnames = ["Kanto Leaders", "Johto Leaders", "Hoenn Leaders", "Sinnoh Leaders", "Unova Leaders", "Kalos Leaders", "Alola Captains", "Galar Leaders"]

def pbSummitBracketSelection(group)
  trainerSelection = []
  case group
    when 0 # Kanto Leaders
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
    when 1 # Johto Leaders
          trainerlist = [
            ["LEADER_Falkner","Falkner",0],
            ["LEADER_Bugsy","Bugsy",0],
            ["LEADER_Morty","Morty",0],
            ["LEADER_Whitney","Whitney",0],
            ["LEADER_Chuck","Chuck",0],
            ["LEADER_Jasmine","Jasmine",0],
            ["LEADER_Pryce","Pryce",0],
            ["LEADER_Clair","Clair",0]
          ]
    when 2 # Hoenn Leaders
          trainerlist = [
            ["LEADER_Roxanne","Roxanne",0],
            ["LEADER_Brawly","Brawly",0],
            ["LEADER_Wattson","Wattson",0],
            ["LEADER_Flannery","Flannery",0],
            ["LEADER_Norman","Norman",0],
            ["LEADER_Winona","Winona",0],
            ["LEADER_Tate","Tate",0],
            ["LEADER_Liza","Liza",0],
            ["LEADER_Juan","Juan",0]
          ]
        
    when 3 # Sinnoh Leaders
          trainerlist = [
            ["LEADER_Roark","Roark",0],
            ["LEADER_Gardenia","Gardenia",0],
            ["LEADER_Maylene","Maylene",0],
            ["LEADER_Wake","Crasher Wake",0],
            ["LEADER_Fantina","Fantina",0],
            ["LEADER_Byron","Byron",0],
            ["LEADER_Candice","Candice",0],
            ["LEADER_Volkner","Volkner",0]
          ]
        
    when 4 # Unova Leaders
          trainerlist = [
            ["LEADER_Cilan","Cilan",0],
            ["LEADER_Chili","Chili",0],
            ["LEADER_Cress","Cress",0],
            ["LEADER_Lenora","Lenora",0],
            ["LEADER_Burgh","Burgh",0],
            ["LEADER_Elesa","Elesa",0],
            ["LEADER_Clay","Clay",0],
            ["LEADER_Skyla","Skyla",0],
            ["LEADER_Drayden","Drayden",0],
            ["LEADER_Cheren","Cheren",0],
            ["LEADER_Roxie","Roxie",0],
            ["LEADER_Marlon","Marlon",0],
            ["LEADER_Brycen","Brycen",0]
          ]
        
    when 5 # Kalos Leaders
          trainerlist = [
            ["LEADER_Viola","Viola",0],
            ["LEADER_Grant","Grant",0],
            ["LEADER_Korrina","Korrina",0],
            ["LEADER_Ramos","Ramos",0],
            ["LEADER_Clemont","Clemont",0],
            ["LEADER_Valerie","Valerie",0],
            ["LEADER_Olympia","Olympia",0],
            ["LEADER_Wulfric","Wulfric",0]
          ]
        
    when 6 # Alola Captains
          trainerlist = [
            ["CAPTAIN_Ilima","Ilima",0],
            ["CAPTAIN_Mallow","Mallow",0],
            ["CAPTAIN_Lana","Lana",0],
            ["CAPTAIN_Kiawe","Kiawe",0],
            ["CAPTAIN_Sophocles","Sophocles",0],
            ["CAPTAIN_Acerola","Acerola",0],
            ["CAPTAIN_Mina","Mina",0]
          ]
        
    when 7 # Galar Leaders
          trainerlist = [
            ["LEADER_Milo","Milo",0],
            ["LEADER_Nessa","Nessa",0],
            ["LEADER_Kabu","Kabu",0],
            ["LEADER_Bea","Bea",0],
            ["LEADER_Allister","Allister",0],
            ["LEADER_Opal","Opal",0],
            ["LEADER_Gordie","Gordie",0],
            ["LEADER_Melony","Melony",0],
            ["LEADER_Piers","Piers",0],
            ["LEADER_Raihan","Raihan",0]
          ]
  end

  for i in 0..4
    loop do
      num = rand(0...(trainerlist.length))
      trainer = trainerlist[num]
      if !trainerSelection.include?(trainer)
        if group == 4
          if trainer[0] == ("LEADER_Lenora")
            trainerSelection.push(trainer) if !trainerSelection.include?("LEADER_Cheren")
          elsif trainer[0] == ("LEADER_Cheren")
            trainerSelection.push(trainer) if !trainerSelection.include?("LEADER_Lenora")
          elsif trainer[0] == ("LEADER_Cress")
            trainerSelection.push(trainer) if !trainerSelection.include?("LEADER_Marlon")
          elsif trainer[0] == ("LEADER_Marlon")
            trainerSelection.push(trainer) if !trainerSelection.include?("LEADER_Cress")
          end
        else
          trainerSelection.push(trainer)
        end
        break
      end
    end
  end
  $game_variables[29] = trainerSelection
end

def pbSummitBracketAnnounce
  bracket = $bracketnames[$game_variables[31]]
  pbMessage(_INTL("\\rYou will be facing the {1} bracket.",bracket))
end

def pbSummitPrepMainTrainer(bracket)
  trainers = $game_variables[29]
  if $game_variables[35] == 1
    fightnum = $game_variables[33]
    opponent = trainers[fightnum]
  else
    opponent = trainers.sample
  end
  $game_variables[30] = opponent
  case bracket
  when 0, 1 # Kanto and Johto Leaders
    $game_map.events[1].character_name = "trainer_Sheet2"
    case opponent[0].downcase
    when "leader_brock"
      $game_map.events[1].direction = 2
      $game_map.events[1].pattern = 0
    when "leader_misty"
      $game_map.events[1].direction = 2
      $game_map.events[1].pattern = 1
    when "leader_surge"
      $game_map.events[1].direction = 2
      $game_map.events[1].pattern = 2
    when "leader_erika"
      $game_map.events[1].direction = 2
      $game_map.events[1].pattern = 3
    when "leader_janine"
      $game_map.events[1].direction = 4
      $game_map.events[1].pattern = 0
    when "leader_sabrina"
      $game_map.events[1].direction = 4
      $game_map.events[1].pattern = 1
    when "leader_blaine"
      $game_map.events[1].direction = 4
      $game_map.events[1].pattern = 2
    when "leader_giovanni"
      $game_map.events[1].direction = 4
      $game_map.events[1].pattern = 3
    when "leader_falkner"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 0
    when "leader_bugsy"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 1
    when "leader_whitney"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 2
    when "leader_morty"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 3
    when "leader_chuck"
      $game_map.events[1].direction = 8
      $game_map.events[1].pattern = 0
    when "leader_jasmine"
      $game_map.events[1].direction = 8
      $game_map.events[1].pattern = 1
    when "leader_pryce"
      $game_map.events[1].direction = 8
      $game_map.events[1].pattern = 2
    when "leader_clair"
      $game_map.events[1].direction = 8
      $game_map.events[1].pattern = 3
    end
  when 2 # Hoenn Leaders, add || num for Elite Hoenn
    $game_map.events[1].character_name = "trainer_Sheet3"
    case opponent[0].downcase
    when "leader_roxanne"
      $game_map.events[1].direction = 2
      $game_map.events[1].pattern = 0
    when "leader_brawly"
      $game_map.events[1].direction = 2
      $game_map.events[1].pattern = 1
    when "leader_wattson"
      $game_map.events[1].direction = 2
      $game_map.events[1].pattern = 2
    when "leader_flannery"
      $game_map.events[1].direction = 2
      $game_map.events[1].pattern = 3
    when "leader_norman"
      $game_map.events[1].direction = 4
      $game_map.events[1].pattern = 0
    when "leader_winona"
      $game_map.events[1].direction = 4
      $game_map.events[1].pattern = 1
    when "leader_tate"
      $game_map.events[1].direction = 4
      $game_map.events[1].pattern = 2
    when "leader_liza"
      $game_map.events[1].direction = 4
      $game_map.events[1].pattern = 3
    when "leader_juan"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 0
    end
  when 3 # Sinnoh Leaders, add || for Team Leaders
    $game_map.events[1].character_name = "trainer_Sheet4"
    case opponent[0].downcase
    when "leader_roark"
      $game_map.events[1].direction = 2
      $game_map.events[1].pattern = 0
    when "leader_gardenia"
      $game_map.events[1].direction = 2
      $game_map.events[1].pattern = 1
    when "leader_maylene"
      $game_map.events[1].character_name = "trainer_LEADER_Maylene"
      $game_map.events[1].direction = 2
    when "leader_wake"
      $game_map.events[1].direction = 2
      $game_map.events[1].pattern = 3
    when "leader_fantina"
      $game_map.events[1].direction = 4
      $game_map.events[1].pattern = 0
    when "leader_byron"
      $game_map.events[1].direction = 4
      $game_map.events[1].pattern = 1
    when "leader_candice"
      $game_map.events[1].direction = 4
      $game_map.events[1].pattern = 2
    when "leader_volkner"
      $game_map.events[1].direction = 4
      $game_map.events[1].pattern = 3
    end
  when 4 # Unova Leaders
      $game_map.events[1].character_name = "trainer_Sheet5"
      case opponent[0].downcase
      when "leader_cilan"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 0
      when "leader_chili"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 1
      when "leader_cress"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 2
      when "leader_lenora"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 3
      when "leader_burgh"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 0
      when "leader_elesa"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 1
      when "leader_clay"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 2
      when "leader_skyla"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 3
      when "leader_brycen"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 0
      when "leader_drayden"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 1
      when "leader_cheren"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 2
      when "leader_roxie"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 3
      when "leader_marlon"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 0
      end
  when 5 # Kalos Leaders and Kalos Elite
      $game_map.events[1].character_name = "trainer_Sheet6"
      case opponent[0].downcase
      when "leader_viola"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 0
      when "leader_grant"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 1
      when "leader_korrina"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 2
      when "leader_ramos"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 3
      when "leader_clemont"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 0
      when "leader_valerie"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 1
      when "leader_olympia"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 2
      when "leader_wulfric"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 3
      when "elite_malva"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 0
      when "elite_siebold"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 1
      when "elite_wikstrom"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 2
      when "elite_drasna"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 3
      when "elite_sycamore"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 0
    when "elite_looker"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 1
    when "elite_trevor"
      $game_map.events[1].direction = 8
      $game_map.events[1].pattern = 2
    end
   when 6 # Alola Captains and Alola Elites
      $game_map.events[1].character_name = "trainer_Sheet7"
      case opponent[0].downcase
      when "captain_ilima"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 0
      when "captain_lana"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 1
      when "captain_kiawe"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 2
      when "captain_mallow"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 3
      when "captain_sophocles"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 0
      when "captain_acerola"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 1
      when "captain_mina"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 2
      when "elite_hala"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 3
      when "elite_olivia"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 0
      when "elite_nanu"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 1
      when "elite_hapu"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 2
      when "elite_molayne"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 3
      when "elite_kahili"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 0
      when "elite_gladion"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 1
      when "elite_lusamine"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 2
      end
   when 7 # Galar Leaders
      $game_map.events[1].character_name = "trainer_Sheet10"
      case opponent[0].downcase
      when "leader_milo"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 0
      when "leader_nessa"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 1
      when "leader_kabu"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 2
      when "leader_bea"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 3
      when "leader_allister"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 0
      when "leader_opal"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 1
      when "leader_geordie"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 2
      when "leader_melony"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 3
      when "leader_piers"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 0
      when "leader_raihan"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 1
      end
  end
end

def pbSummitMainTrainer
  pbSummitPrepBattle
  type = $game_variables[30][0]
  name = $game_variables[30][1]
  version = $game_variables[15]
  $DiscordRPC.details = "VS #{GameData::TrainerType.get($game_variables[30][0]).name} #{$game_variables[30][1]}"
  $DiscordRPC.large_image = $game_variables[30][0].downcase
  if $game_variables[35] == 1
    $DiscordRPC.state = "#{$bracketnames[$game_variables[31]]} (#{$game_variables[33].to_int+1} of 4)"
  else
    $DiscordRPC.state = "Arcade (#{$game_variables[33].to_int+1} of 10)"
  end
  $DiscordRPC.update
  TrainerBattle.start(type, name, version)

  $Trainer.party = $game_variables[27]
  if $game_variables[32] == 1
    $game_variables[33] += 1
  end
  if $game_variables[33] == 4 # when cleared bracket
    $game_variables[31] += 1 # next bracket
  end
end

def pbSummitLobby
  $DiscordRPC.details = "In the Lobby"
  $DiscordRPC.large_image = "lobby"
  $DiscordRPC.state = "Preparing for Battle"
  $DiscordRPC.update
end

def pbSummitBracketUnlock
  bracketwon = $bracketnames[$game_variables[31]-1]
  bracketunlocked = $bracketnames[$game_variables[31]]
  if $game_variables[41] == nil || 0
    $game_variables[41] = []
  end
  $game_variables[41].push($game_variables[31])

  pbMessage(_INTL("\\rCongratulations on defeating the {1}!",bracketwon))
  pbSEPlay("Slots coin")
  $Trainer.money += 700
  pbMessage("\\G\\rYou have earned $700 for your performance.")
  pbMessage(_INTL("\\rYou have also successfully unlocked the {1}!",bracketunlocked))
end

def pbSummitPrepBattle
  setBattleRule("canLose")
  setBattleRule("cannotRun")
  setBattleRule("noExp")
  setBattleRule("noMoney")
  setBattleRule("disablePokeBalls")
  setBattleRule("setStyle")
  setBattleRule("outcomeVar", 32)
  tempParty = []
  for poke in $Trainer.party
    clonepoke = poke.clone
    clonepoke.ev = poke.ev.clone
    clonepoke.iv = poke.iv.clone
    clonepoke.item = poke.item.clone
    clonepoke.ability = poke.ability.clone
    clonepoke.nature = poke.nature.clone
    clonepoke.gender = poke.gender.clone
    for j in 0...6
      clonepoke.ev[j] = poke.ev[j]
      clonepoke.iv[j] = poke.iv[j]
    end
    clonepoke.level = 50 # Set this to whatever preset level you want
    clonepoke.calc_stats
    clonepoke.mail = nil
    tempParty.push(clonepoke)
  end
    $game_variables[27] = $Trainer.party
    $Trainer.party = tempParty
    $game_variables[28] = tempParty
    $game_switches[36] = true
end

def pbSummitEndBattle(trainertype, name)
  pbSummitDeleteTrainer(trainertype, name)
  $Trainer.party = $game_variables[27]
  $game_switches[36] = false
end

def pbSummitPrepArcadeTrainer
  allTypes = [:YOUNGSTER,:GENTLEMAN,:LASS,:LADY,:BUGCATCHER,:CAMPER,:PICNICKER,:GAMBLER,:SCHOOLKID,:TUBER_F,:TUBER_M,:SWIMMER_F,:SWIMMER_M,:SAILOR,:BLACKBELT,:CRUSHGIRL,:HIKER,:RUINMANIAC,:SCIENTIST,:SUPERNERD,:PSYCHIC_F,:PSYCHIC_M,:JUGGLER,:CHANELLER,:HEXMANIAC,:KIMONOGIRL,:BEAUTY,:AROMALADY,:KINDLER,:BOARDER,:ROCKER,:ENGINEER,:BIKER,:CUEBALL,:BURGLAR,:TEAMROCKET_M,:TEAMROCKET_F,:BIRDKEEPER,:FISHERMAN,:POKEMANIAC,:TAMER,:POKEMONBREEDER,:COOLTRAINER_M,:COOLTRAINER_F,:POKEMONRANGER_M,:POKEMONRANGER_F,:DRAGONTAMER,:FAIRYTALEGIRL]
    
  namesFem = ["Emma","Sophia","Olivia","Isabella","Ava","Mia","Abigail","Emily","Madison","Charlotte","Elizabeth","Amelia","Chloe","Ella","Evelyn","Avery","Sofia","Harper","Grace","Addison","Victoria","Natalie","Lily","Aubrey","Lillian","Zoey","Hannah","Layla","Brooklyn","Samantha","Zoe","Leah","Scarlett","Riley","Camila","Savannah","Anna","Audrey","Allison","Aria","Gabriella","Hailey","Claire","Sarah","Aaliyah","Kaylee","Nevaeh","Penelope","Alexa","Arianna","Stella","Alexis","Bella","Nora","Ellie","Ariana","Lucy","Mila","Peyton","Genesis","Alyssa","Taylor","Violet","Maya","Caroline","Madelyn","Skylar","Serenity","Ashley","Brianna","Kennedy","Autumn","Eleanor","Kylie","Sadie","Paisley","Julia","Mackenzie","Sophie","Naomi","Eva","Khloe","Katherine","Gianna","Melanie","Aubree","Piper","Ruby","Lydia","Faith","Madeline","Alexandra","Kayla","Hazel","Lauren","Annabelle","Jasmine","Aurora","Alice","Makayla","Sydney","Bailey","Luna","Maria","Reagan","Morgan","Isabelle","Rylee","Kimberly","Andrea","London","Elena","Jocelyn","Natalia","Trinity","Eliana","Vivian","Cora","Quinn","Liliana","Molly","Jade","Clara","Valentina","Mary","Brielle","Hadley","Kinsley","Willow","Brooke","Lilly","Delilah","Payton","Mariah","Paige","Jordyn","Nicole","Mya","Josephine","Isabel","Lyla","Adeline","Destiny","Ivy","Emilia","Rachel","Angelina","Valeria","Kendall","Sara","Ximena","Isla","Aliyah","Reese","Vanessa","Juliana","Mckenzie","Amy","Laila","Adalynn","Emery","Margaret","Eden","Gabrielle","Kaitlyn","Ariel","Gracie","Brooklynn","Melody","Jessica","Valerie","Adalyn","Adriana","Elise","Michelle","Rebecca","Daisy","Everly","Katelyn","Ryleigh","Catherine","Norah","Alaina","Athena","Leilani","Londyn","Eliza","Jayla","Summer","Lila","Makenzie","Izabella","Daniela","Stephanie","Julianna","Rose","Alana","Harmony","Jennifer","Maximus","Hayden"]
  namesMale = ["Noah","Liam","Jacob","Mason","William","Ethan","Michael","Alexander","James","Elijah","Daniel","Benjamin","Aiden","Jayden","Logan","Matthew","David","Joseph","Lucas","Jackson","Anthony","Joshua","Samuel","Andrew","Gabriel","Christopher","John","Dylan","Carter","Isaac","Ryan","Luke","Oliver","Nathan","Henry","Owen","Caleb","Wyatt","Christian","Sebastian","Jack","Jonathan","Landon","Julian","Isaiah","Hunter","Levi","Aaron","Eli","Charles","Thomas","Connor","Brayden","Nicholas","Jaxon","Jeremiah","Cameron","Evan","Adrian","Jordan","Gavin","Grayson","Angel","Robert","Tyler","Josiah","Austin","Colton","Brandon","Jose","Dominic","Kevin","Zachary","Ian","Chase","Jason","Adam","Ayden","Parker","Hudson","Cooper","Nolan","Lincoln","Xavier","Carson","Jace","Justin","Easton","Mateo","Asher","Bentley","Blake","Nathaniel","Jaxson","Leo","Kayden","Tristan","Luis","Elias","Brody","Bryson","Juan","Vincent","Cole","Micah","Ryder","Theodore","Carlos","Ezra","Damian","Miles","Santiago","Max","Jesus","Leonardo","Sawyer","Diego","Alex","Roman","Maxwell","Eric","Greyson","Hayden","Giovanni","Wesley","Axel","Camden","Braxton","Ivan","Ashton","Declan","Bryce","Timothy","Antonio","Silas","Kaiden","Ezekiel","Jonah","Weston","George","Harrison","Steven","Miguel","Richard","Bryan","Kaleb","Victor","Aidan","Jameson","Joel","Patrick","Jaden","Colin","Everett","Preston","Maddox","Edward","Alejandro","Kaden","Jesse","Emmanuel","Kyle","Brian","Emmett","Jude","Marcus","Kingston","Kai","Alan","Malachi","Grant","Jeremy","Riley","Jayce","Bennett","Abel","Ryker","Caden","Brantley","Luca","Brady","Calvin","Sean","Oscar","Jake","Maverick","Abraham","Mark","Tucker","Nicolas","Bradley","Kenneth","Avery","Cayden","King","Paul","Amir","Gael","Graham"]

  trainertype = allTypes[rand(allTypes.length)]

  if GameData::TrainerType.get(trainertype).gender == 1
    name = namesFem[rand(namesFem.length)]
  else
    name = namesMale[rand(namesMale.length)]
  end
  @arcadetype = trainertype
  @arcadename = name
  charname = "trainer_"
  charname.concat(trainertype.to_s.upcase)
  $game_variables[34] = charname
end

def pbSummitArcadeTrainer
  pbNewSummitTrainer(@arcadetype, @arcadename)
  GameData::TrainerType.get(@arcadetype).id
  pbSummitPrepBattle
  $DiscordRPC.details = "VS Arcade Trainer"
  $DiscordRPC.large_image = "arcade_trainer"
  $DiscordRPC.state = "Arcade (#{$game_variables[33].to_int+1} of 10)"
  $DiscordRPC.update
  TrainerBattle.start(@arcadetype, @arcadename)
  pbSummitEndBattle(@arcadetype, @arcadename)
end

def pbSummitChoosePokemon(tr_type, party_size = 3)
  type = tr_type.to_s.downcase
  num = nil
  party = []
  trainerpkmn = []

  case type
    when "youngster","gentleman"
    trainerpkmn = [
        [:RATICATE,0],
        [:ARBOK,0],
        [:FEAROW,0],
        [:PIDGEOT,0],
        [:SANDSLASH,0],
        [:NIDOKING,0],
        [:NIDOQUEEN,0],
        [:GOLEM,0],
        [:PRIMEAPE,0],
        [:DUGTRIO,0],
        [:FURRET,0],
        [:NOCTOWL,0],
        [:QUAGSIRE,0],
        [:MIGHTYENA,0],
        [:SWELLOW,0],
        [:SHIFTRY,0],
        [:LUDICOLO,0],
        [:MANECTRIC,0],
        [:SWALOT,0],
        [:STARAPTOR,0],
        [:KRICKETUNE,0],
        [:LUXRAY,0],
        [:SKUNTANK,0],
        [:BIBAREL,0],
        [:GASTRODON,0],
        [:WATCHOG,0],
        [:STOUTLAND,0],
        [:SEISMITOAD,0],
        [:SCOLIPEDE,0],
        [:CONKELDURR,0],
        [:UNFEZANT,0],
        [:SAWSBUCK,0],
        [:GALVANTULA,0],
        [:TALONFLAME,0],
        [:DIGGERSBY,0],
        [:PYROAR,0],
        [:GUMSHOOS,0],
        [:VIKAVOLT,0],
        [:RATICATE,1],
        [:MUK,1],
        [:LYCANROC,0],
        [:ORBEETLE,0],
        [:THIEVUL,0],
        [:GREEDENT,0],
        [:ELDEGOSS,0]
      ]

    when "lass", "lady"
    trainerpkmn = [
        [:RATICATE,0],
        [:ARBOK,0],
        [:FEAROW,0],
        [:PIDGEOT,0],
        [:SANDSLASH,0],
        [:NIDOKING,0],
        [:NIDOQUEEN,0],
        [:WIGGLYTUFF,0],
        [:CLEFABLE,0],
        [:VILEPLUME,0],
        [:BELLOSSOM,0],
        [:RAICHU,0],
        [:PERSIAN,0],
        [:FURRET,0],
        [:QUAGSIRE,0],
        [:AZUMARILL,0],
        [:AMPHAROS,0],
        [:GOLDUCK,0],
        [:GRANBULL,0],
        [:SHIFTRY,0],
        [:LUDICOLO,0],
        [:BRELOOM,0],
        [:DELCATTY,0],
        [:SWELLOW,0],
        [:BIBAREL,0],
        [:PACHIRISU,0],
        [:LOPUNNY,0],
        [:ROSERADE,0],
        [:STARAPTOR,0],
        [:WHIMSICOTT,0],
        [:LILLIGANT,0],
        [:LIEPARD,0],
        [:SWOOBAT,0],
        [:TOGEKISS,0],
        [:SWANNA,0],
        [:FLORGES,0],
        [:DEDENNE,0],
        [:DIGGERSBY,0],
        [:KOMALA,0],
        [:LYCANROC,2],
        [:TOUCANNON,0],
        [:TSAREENA,0],
        [:ARAQUANID,0],
        [:HATTERENE,0],
        [:GRIMMSNARL,0],
        [:DREDNAW,0],
        [:ALCREMIE,0]
        ]

      when "bugcatcher"
      trainerpkmn = [
        [:BUTTERFREE,0],
        [:BEEDRILL,0],
        [:VENOMOTH,0],
        [:PINSIR,0],
        [:PARASECT,0],
        [:SCIZOR,0],
        [:LEDIAN,0],
        [:ARIADOS,0],
        [:FORRETRESS,0],
        [:HERACROSS,0],
        [:BEAUTIFLY,0],
        [:DUSTOX,0],
        [:MASQUERAIN,0],
        [:NINJASK,0],
        [:SHEDINJA,0],
        [:WORMADAM,0],
        [:WORMADAM,1],
        [:WORMADAM,2],
        [:MOTHIM,0],
        [:VESPIQUEN,0],
        [:SCOLIPEDE,0],
        [:CRUSTLE,0],
        [:ESCAVALIER,0],
        [:GALVANTULA,0],
        [:VOLCARONA,0],
        [:VIVILLON,0],
        [:VIKAVOLT,0],
        [:RIBOMBEE,0],
        [:GOLISOPOD,0],
        [:ORBEETLE,0],
        [:ARMALDO,0],
        [:ARAQUANID,0],
        [:CENTISKORCH,0],
        [:FROSMOTH,0],
        [:KRICKETUNE,0],
        [:ACCELGOR,0]
      ]

    when "camper", "picnicker", "gambler"
      trainerpkmn = [
        [:DUGTRIO,0],
        [:DUGTRIO,1],
        [:SANDSLASH,0],
        [:SANDSLASH,1],
        [:PRIMEAPE,0],
        [:ARBOK,0],
        [:RATICATE,1],
        [:FEAROW,0],
        [:ARCANINE,0],
        [:NIDOKING,0],
        [:NIDOQUEEN,0],
        [:MAGCARGO,0],
        [:URSARING,0],
        [:GOLEM,0],
        [:GOLEM,1],
        [:ESPEON,0],
        [:UMBREON,0],
        [:WOBBUFFET,0],
        [:SUDOWOODO,0],
        [:CLAYDOL,0],
        [:XATU,0],
        [:SWALOT,0],
        [:CROBAT,0],
        [:PELIPPER,0],
        [:CACTURNE,0],
        [:SEVIPER,0],
        [:ZANGOOSE,0],
        [:PROBOPASS,0],
        [:HARIYAMA,0],
        [:LUXRAY,0],
        [:SNORLAX,0],
        [:MAGMORTAR,0],
        [:ELECTIVIRE,0],
        [:DRIFBLIM,0],
        [:GASTRODON,0],
        [:TANGROWTH,0],
        [:CINCCINO,0],
        [:DARMANITAN,0],
        [:PANGORO,0],
        [:GOGOAT,0],
        [:PALOSSAND,0],
        [:COPPERAJAH,0],
        [:PERRSERKER,0],
        [:OBSTAGOON,0]
      ]

    when "schoolkid"
      trainerpkmn = [
        [:RAICHU,0],
        [:RAICHU,1],
        [:CLEFABLE,0],
        [:WIGGLYTUFF,0],
        [:TOGEKISS,0],
        [:HITMONLEE,0],
        [:HITMONCHAN,0],
        [:HITMONTOP,0],
        [:JYNX,0],
        [:ELECTIVIRE,0],
        [:MAGMORTAR,0],
        [:AZUMARILL,0],
        [:WOBBUFFET,0],
        [:ROSERADE,0],
        [:CHIMECHO,0],
        [:SUDOWOODO,0],
        [:MRMIME,0],
        [:MRRIME,0],
        [:BLISSEY,0],
        [:SNORLAX,0],
        [:LUCARIO,0],
        [:MANTINE,0],
        [:TOXTRICITY,0]
        ]

    when "tuber_f","tuber_m"
      trainerpkmn = [
        [:GOLDUCK,0],
        [:SLOWBRO,0],
        [:SLOWBRO,1],
        [:KINGLER,0],
        [:EXEGGUTOR,0],
        [:EXEGGUTOR,1],
        [:SLOWKING,0],
        [:SLOWKING,1],
        [:AZUMARILL,0],
        [:PELIPPER,0],
        [:GASTRODON,0],
        [:MALAMAR,0],
        [:BARBARACLE,0],
        [:TOXAPEX,0],
        [:GOLISOPOD,0],
        [:PALOSSAND,0],
        [:PYUKUMUKU,0],
        [:CRAMORANT,0],
        [:GRAPPLOCT,0],
        [:PERRSERKER,0],
        [:PINCURCHIN,0],
        [:SWAMPERT,0],
        [:SAMUROTT,0],
        [:PRIMARINA,0]
      ]

    when "swimmer_f","swimmer_m","sailor"
      trainerpkmn = [
        [:GOLDUCK,0],
        [:SEAKING,0],
        [:GYARADOS,0],
        [:AZUMARILL,0],
        [:QUAGSIRE,0],
        [:WHISCASH,0],
        [:CRAWDAUNT,0],
        [:MILOTIC,0],
        [:FLOATZEL,0],
        [:SHARPEDO,0],
        [:EELEKTROSS,0],
        [:ARAQUANID,0],
        [:BARRASKEWDA,0],
        [:DREDNAW,0],
        [:TENTACRUEL,0],
        [:CLOYSTER,0],
        [:KINGDRA,0],
        [:LAPRAS,0],
        [:STARMIE,0],
        [:GOREBYSS,0],
        [:GASTRODON,0],
        [:JELLICENT,0],
        [:CLAWITZER,0],
        [:BRUXISH,0],
        [:WISHIWASHI,0],
        [:LANTURN,0],
        [:DRAGALGE,0],
        [:DHELMISE,0],
        [:CRAMORANT,0],
        [:BLASTOISE,0],
        [:FERALIGATR,0],
        [:EMPOLEON,0]
        ]

    when "blackbelt","crushgirl"
      trainerpkmn = [
        [:PRIMEAPE,0],
        [:MACHAMP,0],
        [:HITMONLEE,0],
        [:HITMONCHAN,0],
        [:HITMONTOP,0],
        [:HARIYAMA,0],
        [:LUCARIO,0],
        [:CONKELDURR,0],
        [:THROH,0],
        [:SAWK,0],
        [:MIENSHAO,0],
        [:PASSIMIAN,0],
        [:GRAPPLOCT,0],
        [:SIRFETCHD,0],
        [:FALINKS,0],
        [:MEDICHAM,0],
        [:PANGORO,0],
        [:HAWLUCHA,0],
        [:CRABOMINABLE,0],
        [:POLIWRATH,0],
        [:HERACROSS,0],
        [:BLAZIKEN,0],
        [:BRELOOM,0],
        [:INFERNAPE,0],
        [:TOXICROAK,0],
        [:GALLADE,0],
        [:EMBOAR,0],
        [:SCRAFTY,0],
        [:CHESNAUGHT,0],
        [:BEWEAR,0],
        [:KOMMOO,0]
        ]

    when "hiker","ruinmaniac"
      trainerpkmn = [
        [:GOLEM,0],
        [:GOLEM,1],
        [:STEELIX,0],
        [:MACHAMP,0],
        [:DUGTRIO,0],
        [:DUGTRIO,1],
        [:SANDSLASH,0],
        [:MAMOSWINE,0],
        [:PROBOPASS,0],
        [:CAMERUPT,0],
        [:CLAYDOL,0],
        [:SUDOWOODO,0],
        [:BRONZONG,0],
        [:RHYPERIOR,0],
        [:DONPHAN,0],
        [:GIGALITH,0],
        [:EXCADRILL,0],
        [:CONKELDURR,0],
        [:AGGRON,0],
        [:HIPPOWDON,0],
        [:CRUSTLE,0],
        [:GLISCOR,0],
        [:MAWILE,0],
        [:GOLURK,0],
        [:MAROWAK,0],
        [:DIGGERSBY,0],
        [:CARBINK,0],
        [:TYRANTRUM,0],
        [:FLYGON,0],
        [:LYCANROC,1],
        [:MUDSDALE,0],
        [:COALOSSAL,0],
        [:SLAKING,0],
        [:OBSTAGOON,0],
        [:SEVIPER,0],
        [:WATCHOG,0],
        [:LIEPARD,0],
        [:DARMANITAN,0],
        [:KROOKODILE,0]
        ]

    when "scientist","supernerd"
      trainerpkmn = [
        [:KLINKLANG,0],
        [:PERRSERKER,0],
        [:COPPERAJAH,0],
        [:SKARMORY,0],
        [:MAWILE,0],
        [:AGGRON,0],
        [:METAGROSS,0],
        [:BRONZONG,0],
        [:AEGISLASH,0],
        [:KLEFKI,0],
        [:DURALUDON,0],
        [:MAGNEZONE,0],
        [:TOGEDEMARU,0],
        [:ELECTRODE,0],
        [:ELECTIVIRE,0],
        [:JOLTEON,0],
        [:AMPHAROS,0],
        [:MANECTRIC,0],
        [:LUXRAY,0],
        [:ZEBSTRIKA,0],
        [:BOLTUND,0],
        [:ROTOM,0],
        [:EMOLGA,0],
        [:HELIOLISK,0],
        [:ORICORIO,1],
        [:TOXTRICITY,0],
        [:VIKAVOLT,0],
        [:MUK,0],
        [:MUK,1],
        [:WEEZING,0],
        [:WEEZING,1],
        [:SWALOT,0],
        [:GARBODOR,0]
        ]

    when "psychic_f","psychic_m","juggler"
      trainerpkmn = [
        [:ALAKAZAM,0],
        [:HYPNO,0],
        [:ESPEON,0],
        [:WOBBUFFET,0],
        [:GRUMPIG,0],
        [:CHIMECHO,0],
        [:MUSHARNA,0],
        [:GOTHITELLE,0],
        [:REUNICLUS,0],
        [:BEHEEYEM,0],
        [:MEOWSTIC,0],
        [:RAPIDASH,0],
        [:XATU,0],
        [:GARDEVOIR,0],
        [:GALLADE,0],
        [:SWOOBAT,0],
        [:SIGILYPH,0],
        [:ORICORIO,2],
        [:HATTERENE,0],
        [:INDEEDEE,0],
        [:RAICHU,1],
        [:SLOWBRO,0],
        [:SLOWBRO,1],
        [:EXEGGUTOR,0],
        [:SLOWKING,0],
        [:SLOWKING,1],
        [:MEDICHAM,0],
        [:MRMIME,0],
        [:MRRIME,0],
        [:ORBEETLE,0],
        [:MALAMAR,0],
        [:DELPHOX,0],
        [:BRONZONG,0],
        [:METAGROSS,0],
        [:CLAYDOL,0]
        ]

    when "chaneller","hexmaniac"
      trainerpkmn = [
        [:GENGAR,0],
        [:DRIFBLIM,0],
        [:CHANDELURE,0],
        [:MISMAGIUS,0],
        [:DUSKNOIR,0],
        [:COFAGRIGUS,0],
        [:POLTEAGEIST,0],
        [:TREVENANT,0],
        [:GOURGEIST,0],
        [:ORICORIO,3],
        [:PALOSSAND,0],
        [:MIMIKYU,0],
        [:DHELMISE,0],
        [:MAROWAK,1],
        [:SABLEYE,0],
        [:FROSLASS,0],
        [:JELLICENT,0],
        [:GOLURK,0],
        [:AEGISLASH,0],
        [:DECIDUEYE,0],
        [:RUNERIGUS,0],
        [:DRAGAPULT,0],
        [:BANETTE,0]
        ]

    when "kimono_girl"
      trainerpkmn = [
        [:FLAREON,0],
        [:VAPOREON,0],
        [:JOLTEON,0],
        [:ESPEON,0],
        [:UMBREON,0],
        [:LEAFEON,0],
        [:GLACEON,0],
        [:SYLVEON,0]
        ]

    when "beauty","aromalady"
      trainerpkmn = [
        [:VENUSAUR,0],
        [:VICTREEBEL,0],
        [:VILEPLUME,0],
        [:BELLOSSOM,0],
        [:MEGANIUM,0],
        [:SUNFLORA,0],
        [:CHERRIM,0],
        [:LEAFEON,0],
        [:LILLIGANT,0],
        [:LURANTIS,0],
        [:TSAREENA,0],
        [:ELDEGOSS,0],
        [:JUMPLUFF,0],
        [:ROSERADE,0],
        [:WHIMSICOTT,0],
        [:LEAVANNY,0],
        [:SAWSBUCK,0],
        [:CLEFABLE,0],
        [:FLORGES,0],
        [:AROMATISSE,0],
        [:SLURPUFF,0],
        [:SYLVEON,0],
        [:COMFEY,0],
        [:ALCREMIE,0],
        [:TOGEKISS,0],
        [:NINETALES,1],
        [:RAPIDASH,1],
        [:GARDEVOIR,0],
        [:MAWILE,0],
        [:PRIMARINA,0],
        ]

    when "kindler"
      trainerpkmn = [
        [:CHARIZARD,0],
        [:NINETALES,0],
        [:ARCANINE,0],
        [:RAPIDASH,0],
        [:FLAREON,0],
        [:TYPHLOSION,0],
        [:TORKOAL,0],
        [:MAGMORTAR,0],
        [:SIMISEAR,0],
        [:DARMANITAN,0],
        [:HEATMOR,0],
        [:CINDERACE,0],
        [:MAROWAK,1],
        [:MAGCARGO,0],
        [:BLAZIKEN,0],
        [:CAMERUPT,0],
        [:INFERNAPE,0],
        [:EMBOAR,0],
        [:TALONFLAME,0],
        [:PYROAR,0],
        [:INCINEROAR,0],
        [:ORICORIO,0],
        [:TURTONATOR,0],
        [:CENTISKORCH,0],
        [:HOUNDOOM,0],
        [:ROTOM,1],
        [:CHANDELURE,0],
        [:SALAZZLE,0],
        [:COALOSSAL,0]
        ]

    when "boarder"
      trainerpkmn = [
        [:GLALIE,0],
        [:GLACEON,0],
        [:DARMANITAN,1],
        [:VANILLUXE,0],
        [:BEARTIC,0],
        [:CRYOGONAL,0],
        [:AVALUGG,0],
        [:EISCUE,0],
        [:SANDSLASH,1],
        [:NINETALES,1],
        [:JYNX,0],
        [:WALREIN,0],
        [:MAMOSWINE,0],
        [:FROSLASS,0],
        [:MRRIME,0],
        [:FROSMOTH,0],
        [:DEWGONG,0],
        [:CLOYSTER,0],
        [:LAPRAS,0],
        [:ABOMASNOW,0],
        [:WEAVILE,0],
        [:ROTOM,3],
        [:AURORUS,0],
        [:CRABOMINABLE,0],
        [:ARCTOZOLT,0],
        [:ARCTOVISH,0]
        ]

    when "rocker","engineer"
      trainerpkmn = [
        [:RAICHU,1],
        [:RAICHU,0],
        [:ELECTRODE,0],
        [:JOLTEON,0],
        [:AMPHAROS,0],
        [:MANECTRIC,0],
        [:LUXRAY,0],
        [:ELECTIVIRE,0],
        [:ZEBSTRIKA,0],
        [:EELEKTROSS,0],
        [:BOLTUND,0],
        [:PINCURCHIN,0],
        [:MAGNEZONE,0],
        [:ROTOM,0],
        [:ROTOM,2],
        [:ROTOM,1],
        [:ROTOM,3],
        [:ROTOM,4],
        [:ROTOM,5],
        [:EMOLGA,0],
        [:HELIOLISK,0],
        [:DEDENNE,0],
        [:ORICORIO,1],
        [:TOGEDEMARU,0],
        [:TOXTRICITY,0],
        [:MORPEKO,0],
        [:DRACOZOLT,0],
        [:ARCTOZOLT,0],
        [:GOLEM,1],
        [:LANTURN,0],
        [:GALVANTULA,0],
        [:STUNFISK,0],
        [:VIKAVOLT,0]
    ]

    when "biker","cueball","burglar","teamrocket_m","teamrocket_f"
      trainerpkmn = [
        [:MUK,0],
        [:WEEZING,0],
        [:KROOKODILE,0],
        [:MAGMORTAR,0],
        [:PERSIAN,1],
        [:ARBOK,0],
        [:MUK,1],
        [:UMBREON,0],
        [:DRAPION,0],
        [:GRANBULL,0],
        [:HOUNDOOM,0],
        [:TYRANITAR,0],
        [:MIGHTYENA,0],
        [:TOXICROAK,0],
        [:EXPLOUD,0],
        [:SHARPEDO,0],
        [:CACTURNE,0],
        [:SCRAFTY,0],
        [:CRAWDAUNT,0],
        [:BISHARP,0],
        [:ABSOL,0],
        [:HONCHKROW,0],
        [:LIEPARD,0],
        [:ZOROARK,0],
        [:THIEVUL,0],
        [:OBSTAGOON,0],
        [:MANDIBUZZ,0],
        [:MALAMAR,0],
        [:PANGORO,0],
        [:GRIMMSNARL,0],
        [:LYCANROC,1],
        [:SHIFTRY,0],
        [:SKUNTANK,0],
        [:HYDREIGON,0],
        [:RATICATE,1],
        [:GOLISOPOD,0],
        [:DREDNAW,0],
        [:PERRSERKER,0]
        ]

    when "birdkeeper"
      trainerpkmn = [
        [:PIDGEOT,0],
        [:FEAROW,0],
        [:CROBAT,0],
        [:DODRIO,0],
        [:AERODACTYL,0],
        [:NOCTOWL,0],
        [:XATU,0],
        [:HONCHKROW,0],
        [:SKARMORY,0],
        [:SWELLOW,0],
        [:STARAPTOR,0],
        [:UNFEZANT,0],
        [:SIGILYPH,0],
        [:BRAVIARY,0],
        [:MANDIBUZZ,0],
        [:TALONFLAME,0],
        [:DECIDUEYE,0],
        [:TOUCANNON,0],
        [:ORICORIO,3],
        [:ORICORIO,2],
        [:ORICORIO,1],
        [:ORICORIO,0],
        [:CORVIKNIGHT,0],
        [:SIRFETCHD,0],
        [:PELIPPER,0],
        [:ALTARIA,0],
        [:TOGEKISS,0],
        [:SWOOBAT,0],
        [:ARCHEOPS,0],
        [:SWANNA,0],
        [:HAWLUCHA,0],
        [:NOIVERN,0],
        [:CRAMORANT,0],
        ]

    when "fisherman"
      trainerpkmn = [
        [:SEAKING,0],
        [:LANTURN,0],
        [:SHARPEDO,0],
        [:WHISCASH,0],
        [:LUMINEON,0],
        [:WISHIWASHI,0],
        [:BRUXISH,0],
        [:BARRASKEWDA,0],
        [:GYARADOS,0],
        [:OCTILLERY,0],
        [:WAILORD,0],
        [:RELICANTH,0],
        [:MALAMAR,0],
        [:ALOMOMOLA,0],
        [:TENTACRUEL,0],
        [:CLOYSTER,0],
        [:KINGLER,0],
        [:CRAWDAUNT,0],
        [:CARRACOSTA,0],
        [:CLAWITZER,0],
        [:GOLISOPOD,0],
        [:POLIWRATH,0],
        [:POLITOED,0],
        [:HUNTAIL,0],
        [:GOREBYSS,0],
        [:GRENINJA,0],
        [:TOXAPEX,0],
        [:PYUKUMUKU,0],
        [:SLOWBRO,0],
        [:SLOWBRO,1],
        [:SLOWKING,0],
        [:SLOWKING,1],
        [:KINGDRA,0],
        [:SWAMPERT,0],
        [:DREDNAW,0]
        ]

    when "pokemaniac","tamer"
      trainerpkmn = [
        [:MAROWAK,1],
        [:MAROWAK,0],
        [:KANGASKHAN,0],
        [:SNORLAX,0],
        [:TYRANITAR,0],
        [:AGGRON,0],
        [:RAMPARDOS,0],
        [:BASTIODON,0],
        [:LICKILICKY,0],
        [:AURORUS,0],
        [:NIDOKING,0],
        [:SLOWBRO,0],
        [:SLOWBRO,1],
        [:SLOWKING,0],
        [:SLOWKING,1],
        [:SWAMPERT,0],
        [:SCEPTILE,0],
        [:EXPLOUD,0],
        [:TORTERRA,0],
        [:GARCHOMP,0],
        [:ABOMASNOW,0],
        [:RHYPERIOR,0],
        [:HAXORUS,0],
        [:DRUDDIGON,0],
        [:HELIOLISK,0],
        [:TYRANTRUM,0],
        [:AVALUGG,0],
        [:SALAZZLE,0],
        [:TURTONATOR,0],
        [:DRAMPA,0],
        [:DREDNAW,0]
        ]

    when "pokemonbreeder"
      trainerpkmn = [
        [:RAICHU,0],
        [:RAICHU,1],
        [:CLEFABLE,0],
        [:WIGGLYTUFF,0],
        [:TOGEKISS,0],
        [:HITMONLEE,0],
        [:HITMONCHAN,0],
        [:HITMONTOP,0],
        [:JYNX,0],
        [:ELECTIVIRE,0],
        [:MAGMORTAR,0],
        [:WOBBUFFET,0],
        [:AZUMARILL,0],
        [:ROSERADE,0],
        [:CHIMECHO,0],
        [:SUDOWOODO,0],
        [:MRMIME,0],
        [:MRRIME,0],
        [:SNORLAX,0],
        [:LUCARIO,0],
        [:MANTINE,0],
        [:TOXTRICITY,0],
        [:VENUSAUR,0],
        [:CHARIZARD,0],
        [:BLASTOISE,0],
        [:MEGANIUM,0],
        [:TYPHLOSION,0],
        [:FERALIGATR,0],
        [:SCEPTILE,0],
        [:BLAZIKEN,0],
        [:SWAMPERT,0],
        [:TORTERRA,0],
        [:INFERNAPE,0],
        [:EMPOLEON,0],
        [:SERPERIOR,0],
        [:EMBOAR,0],
        [:SAMUROTT,0],
        [:CHESNAUGHT,0],
        [:DELPHOX,0],
        [:GRENINJA,0],
        [:DECIDUEYE,0],
        [:INCINEROAR,0],
        [:PRIMARINA,0],
        [:RILLABOOM,0],
        [:CINDERACE,0],
        [:INTELEON,0]
        ]

    when "cooltrainer_m","cooltrainer_f","pokemonranger_m","pokemonranger_f"
      trainerpkmn = [
        [:TYRANITAR,0],
        [:SALAMENCE,0],
        [:METAGROSS,0],
        [:GARCHOMP,0],
        [:SLAKING,0],
        [:GYARADOS,0],
        [:VENUSAUR,0],
        [:CHARIZARD,0],
        [:BLASTOISE,0],
        [:MEGANIUM,0],
        [:TYPHLOSION,0],
        [:FERALIGATR,0],
        [:SCEPTILE,0],
        [:BLAZIKEN,0],
        [:SWAMPERT,0],
        [:TORTERRA,0],
        [:INFERNAPE,0],
        [:EMPOLEON,0],
        [:SERPERIOR,0],
        [:EMBOAR,0],
        [:SAMUROTT,0],
        [:CHESNAUGHT,0],
        [:DELPHOX,0],
        [:GRENINJA,0],
        [:DECIDUEYE,0],
        [:INCINEROAR,0],
        [:PRIMARINA,0],
        [:RILLABOOM,0],
        [:CINDERACE,0],
        [:INTELEON,0],
        [:AGGRON,0],
        [:LUCARIO,0],
        [:GARDEVOIR,0],
        [:GALLADE,0],
        [:AERODACTYL,0],
        [:AMPHAROS,0],
        [:ALAKAZAM,0],
        [:GENGAR,0],
        [:PINSIR,0],
        [:DRAGONITE,0],
        [:SCIZOR,0],
        [:HERACROSS,0],
        [:HOUNDOOM,0],
        [:HYDREIGON,0],
        [:GOODRA,0],
        [:KOMMOO,0],
        [:DRAGAPULT,0],
        [:ABOMASNOW,0],
        [:SLOWBRO,0],
        [:SLOWBRO,1],
        [:SLOWKING,0],
        [:SLOWKING,1],
        [:KANGASKHAN,0],
        [:ALTARIA,0],
        [:GLALIE,0],
        [:FROSLASS,0],
        [:LOPUNNY,0],
        [:ARCANINE,0],
        [:ABSOL,0],
        [:FLORGES,0],
        [:VOLCARONA,0],
        [:SHARPEDO,0],
        [:TOGEKISS,0],
        [:BLISSEY,0],
        [:KINGDRA,0],
        [:ELECTIVIRE,0],
        [:MAGMORTAR,0],
        [:MILOTIC,0],
        [:DARMANITAN,0],
        [:CROBAT,0],
        [:LAPRAS,0],
        [:VANILLUXE,0],
        [:DURALUDON,0],
        [:GOGOAT,0],
        [:EXEGGUTOR,0],
        [:EXEGGUTOR,1],
        [:MAMOSWINE,0],
        [:MEDICHAM,0],
        [:AMBIPOM,0],
        [:FLAREON,0],
        [:VAPOREON,0],
        [:JOLTEON,0],
        [:ESPEON,0],
        [:UMBREON,0],
        [:LEAFEON,0],
        [:GLACEON,0],
        [:SYLVEON,0],
        [:GOREBYSS,0],
        [:HUNTAIL,0],
        [:LURANTIS,0],
        [:LILLIGANT,0],
        [:MAWILE,0],
        [:SABLEYE,0],
        [:MISMAGIUS,0],
        [:SANDSLASH,1],
        [:SANDSLASH,0]
        ]

    when "dragontamer"
      trainerpkmn = [
        [:SALAMENCE,0],
        [:HYDREIGON,0],
        [:GOODRA,0],
        [:KOMMOO,0],
        [:CHARIZARD,0],
        [:KINGDRA,0],
        [:GYARADOS,0],
        [:DRAGONITE,0],
        [:FLYGON,0],
        [:ALTARIA,0],
        [:GARCHOMP,0],
        [:HAXORUS,0],
        [:DRUDDIGON,0],
        [:DRAGALGE,0],
        [:TYRANTRUM,0],
        [:NOIVERN,0],
        [:TURTONATOR,0],
        [:DRAMPA,0],
        [:FLAPPLE,0],
        [:APPLETUN,0],
        [:DURALUDON,0],
        [:DRAGAPULT,0],
        [:EXEGGUTOR,1],
        [:DRACOZOLT,0],
        [:DRACOVISH,0]
        ]
    when "fairytalegirl"
      trainerpkmn = [
        [:CLEFABLE,0],
        [:GRANBULL,0],
        [:FLORGES,0],
        [:AROMATISSE,0],
        [:SLURPUFF,0],
        [:SYLVEON,0],
        [:COMFEY,0],
        [:ALCREMIE,0],
        [:TOGEKISS,0],
        [:NINETALES,1],
        [:RAPIDASH,1],
        [:WEEZING,1],
        [:MRMIME,0],
        [:AZUMARILL,0],
        [:GARDEVOIR,0],
        [:MAWILE,0],
        [:WHIMSICOTT,0],
        [:DEDENNE,0],
        [:CARBINK,0],
        [:KLEFKI,0],
        [:PRIMARINA,0],
        [:RIBOMBEE,0],
        [:SHIINOTIC,0],
        [:MIMIKYU,0],
        [:HATTERENE,0],
        [:GRIMMSNARL,0]
        ]
  end
  for i in 0...party_size
    loop do
      num = rand(0...(trainerpkmn.length))
      pkmn = trainerpkmn[num]
      for n in $allpkmn
        if [n[0], n[5]] == pkmn
          pkmninfo = n
          break
        end
      end
      if !party.include?(pkmninfo)
        party.push(pkmninfo)
        break
      end
    end
  end
  return party
end

def pbNewSummitTrainer(tr_type, tr_name, tr_version = 0, save_changes = true, party_size = 3)
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

  case $game_variables[15]
    when 0 # Easy
      ivval = 10
    when 1 # Standard
      ivval = 20
    when 2, 3 # Hard, Extreme
      ivval = 31
  end

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
          :species       => pkmn[0],
          :level         => 50,
          :moves         => [pkmn[1], pkmn[2], pkmn[3], pkmn[4]],
          :iv            => {:HP => ivval, :ATTACK => ivval, :DEFENSE => ivval, :SPECIAL_ATTACK => ivval, :SPECIAL_DEFENSE => ivval, :SPEED => ivval},
          :form          => pkmn[5],
          :ability_index => pkmn[6]
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
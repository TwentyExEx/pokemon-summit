def pbSummitArcadeTest
  p "prep"
  pbSummitPrepTestTrainer
  p "test"
  pbTestSummitTrainer(@arcadetype, @arcadename)
  GameData::TrainerType.get(@arcadetype).id
  pbSummitPrepBattle
  TrainerBattle.start(@arcadetype, @arcadename)
  pbSummitEndBattle(@arcadetype, @arcadename)
end

def pbSummitPrepTestTrainer
  allTypes = [:YOUNGSTER,:GENTLEMAN,:LASS,:LADY,:BUGCATCHER]

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
end

def pbSummitTestPokemon(tr_type, party_size = 3)
  type = tr_type.to_s.downcase
  num = nil
  party = []
  trainerpkmn = []

  case type
    when "youngster","gentleman"
    trainerpkmn = [:SLOWBRO_GALAR]
    when "lass", "lady"
    trainerpkmn = [:SLOWBRO_GALAR]
    when "bugcatcher"
      trainerpkmn = [:SLOWBRO_GALAR]
  end

  party_size.times do
    num = rand(0...(trainerpkmn.length))
    select = trainerpkmn[num]
    pkmn = SummitPokeInfo.const_get(select)
    party.push(pkmn)
  end
  return party
end


def pbTestSummitTrainer(tr_type, tr_name, tr_version = 0, save_changes = true, party_size = 3)
  party = pbSummitTestPokemon(tr_type, party_size)
  for i in 0...party_size
    loop do
      if party
        pkmn = party[i]
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
          :species       => pkmn[:species],
          :level         => 50,
          :moves         => pkmn[:moves],
          :iv            => {:HP => ivval, :ATTACK => ivval, :DEFENSE => ivval, :SPECIAL_ATTACK => ivval, :SPECIAL_DEFENSE => ivval, :SPEED => ivval},
          :form          => pkmn[:form],
          :ability_index => pkmn[:ability_index]
        }
      )
    end
    # Add trainer's data to records
    @trainer_hash[:id] = [@trainer_hash[:trainer_type], @trainer_hash[:name], @trainer_hash[:version]]
    GameData::Trainer.register(@trainer_hash)
    GameData::Trainer.save
  end
  return trainer
end
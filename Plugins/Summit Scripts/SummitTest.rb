def pbSummitTest
  for species in SummitPokeTest.allspecies
    pkmn = SummitPokeTest.const_get(species)
    specformformatted = pkmn[:species].clone.to_s
    if pkmn[:form] != 0
      specformformatted << "_" << pkmn[:form].to_s
    end
    @givepkmn = Pokemon.new(specformformatted, 50)
    num = 0
    for stat in $allstats
      @givepkmn.iv[stat] = 31
      @givepkmn.ev[stat] = pkmn[:evs][num]
      num += 1
    end
    @givepkmn.happiness = 255
    @givepkmn.cannot_release = true
    for move in pkmn[:moves]
      @givepkmn.learn_move(move)
    end
    @givepkmn.ability_index = pkmn[:ability_index]
    @givepkmn.nature = pkmn[:nature]
    @givepkmn.item = pkmn[:item]
    teratype = []
    teratype.push(pkmn[:tera_type])
    @givepkmn.tera_type = teratype
    pbAddPokemonSilent(@givepkmn)
  end
end

def pbSummitCourtyardTest
  # trainerlist = []
  # trainerlist.push($game_variables[44].uniq)
  trainerlist = [:LEADER_Brock,:LEADER_Misty,:LEADER_Erika,:LEADER_Janine,:LEADER_Sabrina,:LEADER_Blaine]
  trainersonmap = []

  until trainersonmap.length == 3 do
    trainer = trainerlist[rand(trainerlist.length)]
    next if trainersonmap.include?(trainer)
    trainersonmap.push(trainer)
    $game_map.events[trainersonmap.length].character_name = trainer.to_s
  end
end

def pbSummitCourtyardTalkTest
  this_event = pbMapInterpreter.get_self
  trainer = this_event.character_name.to_sym
  case trainer
    when :LEADER_Brock
      messages = [["Other than being a Gym Leader in Kanto, I also help on fossil excavations.","I become more familiar with all sorts of regions by digging in the earth and mountains.","I wonder what kind of Pokémon there were a long time ago.","What kind of geography was it?","Whenever I think about ages that we don't know about, I can't help but get really excited."],["If you ever come to Pewter City in Kanto, come visit my Gym.","I'll show you around the Gym and the museum we have nearby, too!","If you have any interest in old Pokémon fossils, I can't recommend it enough."],["You need a strong will for battles.","Wanting to win, wanting to not lose, that willpower will lead you to victory.","So believe in yourself. Believe that you're an amazing Trainer.","Believing in yourself with a rock-hard will... that is the secret to winning!"]]
    when :LEADER_Misty
      messages = [["If you want to be better friends with your Pokémon, my advice to you is to train in an environment that it likes!","I use Water-type Pokémon, so I end up at the beach more often than not.","For us, swimming, surfing, and spending time together there is really important."],["My Gym is in Cerulean City—famous for its pristine water!","I've got a huge pool in my Gym. It's the perfect environment for Water-type Pokémon to show off what they can do in battle!","You should come visit me sometime, #{$player.name}!"],["For a long time, it was my dream to go off on a journey and battle against tough Trainers...","That dream came true, but now I have a new one: to defeat you, #{$player.name}!","I'm so glad we were able to meet here!"]]
    when :LEADER_Surge
      messages = [[],["You battle like a true soldier, kid!","battles are fun, but don't forget to show love to your pokemon!", "pokemon aren't just war machines, they're some of the most loyal partners you'll ever have!"],["Want to hear a story from me? Well, I used to have a Voltorb that was actually quite a coward. Disappointing, right?","You'd be surprised, though. Just because it was easily scared didn't make it weak.","My cowardly Voltorb would always notice even little dangers and hazards!","In fact, that's how I got my reputation as a super-cautious electric soldier!"]]
    when :LEADER_Erika
      messages = [["I have all sorts of beautiful Grass-type Pokémon back in my hometown.","Every one of them is full of life and energy. We spend most of our days free and easy at the Pokémon Gym.","I wonder what my dear Tangela and Victreebel are up to right now..."],["Whenever I leave my Gym, I can't help constantly worrying about the Pokémon I left behind.","What if my Pokémon turn the inside of the Gym into a wild jungle while I'm gone?","Dear... That would be so adorable of them...I would probably just leave it that way!"],["To battle is to weave various elements together, ultimately leading to victory or defeat. No two Pokémon battles are exactly alike.","I find a sort of beauty in that, which I'm conscious of even in battle.","One could say that I'm enjoying the art of battling, so to speak."]]
    when :LEADER_Janine
      messages = [["My father is Koga, of the Elite Four! I want to become more like him. That's why I have to train even harder!","Father is very strong and strict. He is also cool with how skilled of a Pokémon Trainer he is!","But more importantly, he's kind! Isn't he awesome?","But I won't lose in the World Summit! I'm still a Pokémon Trainer first and foremost and a daughter second!"],["Everybody in the Fuchsia City Gym disguises themselves to look like me! You can imagine how hard it is to find me!","It's really fun, and a lot of the challengers have good things to say about it, but...","nobody realizes it's me if I ever dress up."],["My ninja uniform is specially tailored! It's made from Ariados silk!","It's really durable! And even better, it's warm in the winter and really cool in the summer!","But the best part is that it makes me feel as if Ariados is always protecting me."]]
    when :LEADER_Sabrina
      messages = [["A lot of people think my psychic powers are just part of my everyday life.","But it's not that simple.","Honestly, it's very difficult to control my powers. I can lose the sense for it quite easily if I don't train every day.","I guess it's similar to Pokémon battles. Both require daily training."],["The future is constantly changing.","So even if you have the gift of precognition, that doesn't mean you can win every Pokémon battle.","That's what makes them so interesting, though."],["A long time ago, I battled the Fighting Dojo to make mine the official Gym of Saffron City.","I ultimately won, but they were very strong opponents.","I even saw a glimpse of a future where I would lose."]]
    when :LEADER_Blaine
      messages = [["There is a facility called the Pokémon Research Lab on Cinnabar Island.","They research very interesting things, such as Pokémon Evolution and legends.","Rearranging genes is a practical way to explore the infinite possibilities of Pokémon.","That's some difficult stuff, but the researchers at the lab all believe that they're doing the right thing."],["Whenever I'm thinking up quizzes, I take off my sunglasses so that I can concentrate.","Good ideas just come to me when I do so.","Maybe you could think some up, too. It's surprisingly easy to get hooked!"],["Hm. I thought of a good quiz!","Are Infernape sharp thinkers or poor?","They're sharp! They are INFERnape, after all!"]]
    end
    option = messages[rand(messages.length)]
    if option.length != 1
      for line in option
        pbMessage(line)
      end
    end
end

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
case $bg.to_s.downcase
  when "normal"
    typemessages = [
        ["Their Pokémon may be Normal, but #{opp} is nothing but extraordinary!","Challenger #{$player.name} really has a tough fight ahead..."],
        ["Don't turn off your TV sets folks, Normal-types can surprise you.","You can count on #{opp} and Challenger #{$player.name} putting on a show!"],
        ["#{opp}, master of Normal-type Pokémon, is here to brawl!","They are tough, but Challenger #{$player.name} has a Fighting chance."]
  ] 
  when "fighting"
    typemessages = [
        ["Straight from the dojo, #{opp} is here to show us the ropes!","Challenger #{$player.name} better bring their best."],
        ["With Pokémon that can chop right through concrete, #{opp} enters the ring.","Will this force prove too strong for Challenger #{$player.name}?"],
        ["#{opp} has a whole team of intense Fighting-type Pokémon.","Challenger #{$player.name} would need to be a Psychic to break down this trainer!"]
  ]
  when "flying"
    typemessages = [
        ["Watch out above Challenger #{$player.name}!","#{opp} swoops into the arena!"],
        ["#{opp} takes to the skies to fight Challenger #{$player.name} with their Flying Pokémon!","The cameramen will need a break after this one..."],
        ["With all of their Flying-type Pokémon, it'll be hard to catch #{opp} off guard.","Will Challenger #{$player.name} find a way to Rock their foundations?"]
  ]
  when "poison"
    typemessages = [
        ["Toxic fumes are poised to fill the arena as #{opp} takes the stage.","Challenger #{$player.name}, don't get poisoned!"],
        ["#{opp} has a whole team of venomous Pokémon to counter Challenger #{$player.name}.","Stay glued to your seats audience!"],
        ["The Poison-type Pokémon of #{opp} are terrifying to behold...","Challenger #{$player.name} will have no choice but to hit the Ground running!"]
  ]
  when "ground"
    typemessages = [
        ["With the power of the earth behind them, #{opp} seems unstoppable.","Will Challenger #{$player.name} make it through?"],
        ["The ground rumbles with anticipation for #{opp} and their earth-shattering Pokémon","Challenger #{$player.name} had better hold on to something."],
        ["#{opp} weilds a team of expert Ground-type Pokémon.","Challenger #{$player.name} will have to Water down their expectations of a easy fight!"]
  ]
  when "rock"
    typemessages = [
        ["Challenger #{$player.name} is preparing for a mountainous battle against #{opp}.","Can #{$player.name} get through this rock-hard defense?"],
        ["How will Challenger #{$player.name} face #{opp} and their will of pure stone?","Stay tuned to find out!"],
        ["#{opp} and their Rock-type Pokémon seem impossible to shatter...","Let's hope that Challenger #{$player.name} is Fighting through that fear!"]
  ]
  
  when "bug"
    typemessages = [
        ["Oh my... so many Bug Pokémon...","I'm sorry Challenger #{$player.name} and #{opp}, I just can't watch this one."],
        ["#{opp} has a whole team of creepy-crawly Bug Pokémon!","I don't know how Challenger #{$player.name} can be in the same room..."],
        ["I try not to be bias, but the Bug-type Pokémon of #{opp} give me no choice.","Send 'em Flying, Challenger #{$player.name}."]
    ]
  when "ghost"
    typemessages = [
        ["Quiet whispers fill the room as the haunting battle between Challenger #{$player.name} and #{opp} begins!"],
        ["Challenger #{$player.name} has entered the arena, looking confident and ready to fight.","However, #{opp} has a whole lot of spirit!"],
        ["#{opp} is here to terrify with their horde of Ghost-type Pokémon.","Times ahead certainly look Dark for Challenger #{$player.name}!"]
    ]
  when "steel"
    typemessages = [
        ["Shining of brilliant silver, #{opp} and their Steel-type Pokémon are here to put pressure on Challenger #{$player.name} and their team!"],
        ["Challenger #{$player.name} vs #{opp} live on your screens in a moment.","This battle will be metal!"],
        ["With their sturdy Steel-type Pokémon, #{opp} has come to shake things up.","But Challenger #{$player.name} is here to stoke the Fire of battle"],
    ]
  when "fire"
    typemessages = [
        ["With a flaming fury, #{opp} bursts onto our screens!","Can Challenger #{$player.name} find a way to control the flames?"],
        ["Challenger #{$player.name} vs #{opp} will surely make sparks fly.","Things are really heating up around here!"],
        ["#{opp} makes training Fire-type Pokémon look easy.","Challenger #{$player.name} is in troubled Water in this matchup!"],
    ]
  when "water"
    typemessages = [
        ["The smell of fresh rain fills the arena alongside #{opp}.","Time to go for a swim, Challenger #{$player.name}!"],
        ["#{opp} and their elegant H2O-lovers certainly know how to make a splash!","Challenger #{$player.name} needs to evaporate their momentum!"],
        ["A team of fresh Water-type Pokémon from #{opp} stare down Challenger #{$player.name}.","The energy in here is just Electric!"],
    ]
  when "grass"
    typemessages = [
        ["Are you ready to take on the full power of nature, Challenger #{$player.name}?","Here comes #{opp}!"],
        ["#{opp} stands before us, planted in place, ready to battle...","Find a way to uproot them, Challenger #{$player.name}!"],
        ["#{opp} is one of the best Grass-type trainers in the world and is looking extremely confident.","Challenger #{$player.name} needs to put out that Fire of ambition!"],
    ]
  when "electric"
    typemessages = [
        ["Bzzzt... Bzzzt...ZAP! Did you guys like my impression of electricity? No?!","Fine... It's battle time between Challenger #{$player.name} and #{opp}!"],
        ["Challenger #{$player.name}! is about to be shocked by the Electric-type power of #{opp}!"],
        ["With their battery of Electric-type Pokémon, #{opp} is ready to fry the competition.","Challenger #{$player.name}, make sure to Ground yourself!"],
    ]
  when "psychic"
    typemessages = [
        ["Can #{opp} read my mind? I don't think I'm ready for that...","Challenger #{$player.name}! Distract them!"],
        ["#{opp} and their team of Psychic-type Pokémon"],
        ["#{opp} and their team of Psychic-type Pokémon prove that the mind is mightier than muscle.","Challenger #{$player.name}! Show off your Dark side..."],
    ]
end
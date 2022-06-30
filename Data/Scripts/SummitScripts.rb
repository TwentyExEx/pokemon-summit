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

def pbSummitPrepBattle
  setBattleRule("canLose")
  setBattleRule("cannotRun")
  setBattleRule("noExp")
  setBattleRule("noMoney")
  setBattleRule("disablePokeBalls")
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
    allTypes = [:LASS, :SCHOOL_KID, :PICNICKER, :YOUNGSTER, :POKE_KID, :BUG_CATCHER, :CAMPER]
    namesFem = ["Melody", "Kuromi", "Kitty"]
    namesMale = ["Keroppi", "Cinnamoroll", "Pochacco"]

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
      ["RATICATE","QUICKATTACK","CRUNCH","SWORDSDANCE","DIG"],
      ["ARBOK","CRUNCH","GUNKSHOT","ICEFANG","GLARE"],
      ["FEAROW","DRILLRUN","AERIALACE","UTURN","STEELWING"],
      ["PIDGEOT","AIRSLASH","ROOST","AERIALACE","QUICKATTACK"],
      ["SANDSLASH","EARTHQUAKE","ROLLOUT","SWORDSDANCE","SLASH"],
      ["NIDOKING","POISONJAB","EARTHQUAKE","MEGAHORN","TOXIC"],
      ["NIDOQUEEN","TOXICSPIKES","CRUNCH","EARTHPOWER","SUPERPOWER"]
    ]
    when "lass", "poke_kid"
    pkmnlist = [
      ["RATICATE","QUICKATTACK","CRUNCH","SWORDSDANCE","DIG"],
      ["ARBOK","CRUNCH","GUNKSHOT","ICEFANG","GLARE"],
      ["FEAROW","DRILLRUN","AERIALACE","UTURN","STEELWING"],
      ["PIDGEOT","AIRSLASH","ROOST","AERIALACE","QUICKATTACK"],
      ["SANDSLASH","EARTHQUAKE","ROLLOUT","SWORDSDANCE","SLASH"],
      ["NIDOKING","POISONJAB","EARTHQUAKE","MEGAHORN","TOXIC"],
      ["NIDOQUEEN","TOXICSPIKES","CRUNCH","EARTHPOWER","SUPERPOWER"]
    ]
    when "bug_catcher" 
    pkmnlist = [
      ["BUTTERFREE","BUGBUZZ","PSYCHIC","POISONPOWDER","AIRSLASH"],
      ["BEEDRILL","POISONJAB","BUGBITE","ENDEAVOR","ASSURANCE"],
      ["VENOMOTH","BUGBUZZ","ENERGYBALL","SLUDGEBOMB","PROTECT"],
      ["PINSIR","SUPERPOWER","XSCISSOR","SWORDSDANCE","SUBMISSION"],
      ["PARASECT","CROSSPOISON","XSCISSOR","STUNSPORE","POISONPOWDER"],
      ["SCIZOR","BULLETPUNCH","IRONHEAD","XSCISSOR","SANDTOMB"]
    ]
    when "camper", "picnicker" 
    pkmnlist = [
      ["DUGTRIO","SANDTOMB","NIGHTSLASH","EARTHQUAKE","SANDSTORM"],
      ["DUGTRIO","IRONHEAD","DIG","EARTHQUAKE","SUCKERPUNCH",1],
      ["SANDSLASH","EARTHQUAKE","ROLLOUT","SWORDSDANCE","SLASH"],
      ["SANDSLASH","IRONHEAD","ICICLECRASH","ICICLESPEAR","IRONDEFENSE",1],
      ["PRIMEAPE","OUTRAGE","STOMPINGTANTRUM","CLOSECOMBAT","SWAGGER"],
      ["ARBOK","CRUNCH","GUNKSHOT","ICEFANG","GLARE"],
      ["RATICATE","CRUNCH","SUCKERPUNCH","SUPERFANG","HYPERFANG",1],
      ["FEAROW","DRILLRUN","AERIALACE","UTURN","STEELWING"],
      ["ARCANINE","FLAMETHROWER","FLAREBLITZ","EXTREMESPEED","PLAYROUGH"]
    ]
  end
  for i in 0...party_size
    loop do
      num = rand(0...(pkmnlist.length-1))
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
          :form    => pkmn[5]
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
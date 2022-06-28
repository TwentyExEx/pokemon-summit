def pbSummitMakePokemon(species, move1, move2, move3, move4)
  pkmn = Pokemon.new(species, 50)
  pokeStats = [:HP, :ATTACK, :DEFENSE, :SPECIAL_ATTACK, :SPECIAL_DEFENSE, :SPEED]
  for stat in pokeStats
    pkmn.iv[stat] = 31
  end
  pkmn.happiness = 255
  pkmn.cannot_release = true
  pokeMoves = [move1, move2, move3, move4]
  for move in pokeMoves
    pkmn.learn_move(move)
  end
  return pkmn
end

def pbSummitGivePokemon(species, move1, move2, move3, move4)
  pbSummitMakePokemon(species, move1, move2, move3, move4)
  pbAddPokemonSilent(pkmn)
end

def pbSummitMakeTrainer(party_size)
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
  else
    pbMessage(_INTL("A team must have at least 1 Pokémon!"))
  end
end

def pbSummitChoosePokemon(tr_type)
  type = tr_type.to_s.downcase
  pkmnlist = []
  case type
    when "youngster", "school_kid"
    pkmnlist = [
      [:RATICATE,:QUICKATTACK,:CRUNCH,:SWORDSDANCE,:DIG],
      [:ARBOK,:CRUNCH,:GUNKSHOT,:ICEFANG,:GLARE],
      [:FEAROW,:DRILLRUN,:AERIALACE,:UTURN,:STEELWING],
      [:PIDGEOT,:AIRSLASH,:ROOST,:AERIALACE,:QUICKATTACK],
      [:SANDSLASH,:EARTHQUAKE,:ROLLOUT,:SWORDSDANCE,:SLASH],
      [:NIDOKING,:POISONJAB,:EARTHQUAKE,:MEGAHORN,:TOXIC],
      [:NIDOQUEEN,:TOXICSPIKES,:CRUNCH,:EARTHPOWER,:SUPERPOWER]
    ]
    when "lass", "poke_kid"
    pkmnlist = [
      [:RATICATE,:QUICKATTACK,:CRUNCH,:SWORDSDANCE,:DIG],
      [:ARBOK,:CRUNCH,:GUNKSHOT,:ICEFANG,:GLARE],
      [:FEAROW,:DRILLRUN,:AERIALACE,:UTURN,:STEELWING],
      [:PIDGEOT,:AIRSLASH,:ROOST,:AERIALACE,:QUICKATTACK],
      [:SANDSLASH,:EARTHQUAKE,:ROLLOUT,:SWORDSDANCE,:SLASH],
      [:NIDOKING,:POISONJAB,:EARTHQUAKE,:MEGAHORN,:TOXIC],
      [:NIDOQUEEN,:TOXICSPIKES,:CRUNCH,:EARTHPOWER,:SUPERPOWER]
    ]
    when "bug_catcher" 
    pkmnlist = [
      [:BUTTERFREE,:BUGBUZZ,:PSYCHIC,:POISONPOWDER,:AIRSLASH],
      [:BEEDRILL,:POISONJAB,:BUGBITE,:ENDEAVOR,:ASSURANCE],
      [:VENOMOTH,:BUGBUZZ,:ENERGYBALL,:SLUDGEBOMB,:PROTECT],
      [:PINSIR,:SUPERPOWER,:XSCISSOR,:SWORDSDANCE,:SUBMISSION],
      [:PARASECT,:CROSSPOISON,:XSCISSOR,:STUNSPORE,:POISONPOWDER],
      [:SCIZOR,:BULLETPUNCH,:IRONHEAD,:XSCISSOR,:SANDTOMB]
    ]
    when "camper", "picnicker" 
    pkmnlist = [
      [:DUGTRIO,:SANDTOMB,:NIGHTSLASH,:EARTHQUAKE,:SANDSTORM],
      [:DUGTRIO_1,:IRONHEAD,:DIG,:EARTHQUAKE,:SUCKERPUNCH],
      [:SANDSLASH,:EARTHQUAKE,:ROLLOUT,:SWORDSDANCE,:SLASH],
      [:SANDSLASH_1,:IRONHEAD,:ICICLECRASH,:ICICLESPEAR,:IRONDEFENSE],
      [:PRIMEAPE,:OUTRAGE,:STOMPINGTANTRUM,:CLOSECOMBAT,:SWAGGER],
      [:ARBOK,:CRUNCH,:GUNKSHOT,:ICEFANG,:GLARE],
      [:RATICATE_1,:CRUNCH,:SUCKERPUNCH,:SUPERFANG,:HYPERFANG],
      [:FEAROW,:DRILLRUN,:AERIALACE,:UTURN,:STEELWING],
      [:ARCANINE,:FLAMETHROWER,:FLAREBLITZ,:EXTREMESPEED,:PLAYROUGH]
    ]
  end
  return pkmnlist[rand(tr_type.length)]
end


def pbNewSummitTrainer(party_size, tr_type, tr_name)
  moves = []

  trainer = NPCTrainer.new(tr_name, tr_type)
  for i in 0...party_size
    loop do
      pkmn = pbSummitChoosePokemon(tr_type)
      if pkmn
        species = pkmn[0]
        moves.push(pkmn[1], pkmn[2], pkmn[3], pkmn[4])
        trainer.party.push([species, moves[0], moves[1], moves[2], moves[3]])
        break
      else
        break if i > 0
        pbMessage(_INTL("This trainer must have at least 1 Pokémon!"))
      end
    end
  end
  trainer.party.each do |pkmn|
    pbSummitMakePokemon(pkmn[0], pkmn[1], pkmn[2], pkmn[3], pkmn[4])
    p "end"
  end
  p trainer
  $game_variables[1] = trainer
  return trainer
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
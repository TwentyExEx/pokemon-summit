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
  specformformatted = pkmn[:species].clone
  if pkmn[:form] != 0
    specformformatted >> "_" >> pkmn[:form]
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
  pbAddPokemonSilent(@givepkmn)
end

def pbSummitVendingPokemon
  loop do
    pkmn = pbSummitSelectPokemon
    if $game_variables[42].include?(pkmn) # obtained
      return false
      break
    else
      pbShowPokemonSprite(@givepkmn)
      pbSummitGivePokemon(pkmn)
      return true
    end
    break
  end
end

def pbSummitMonkey
    pbSummitGivePokemon(:SIMISAGE)
    pbSummitGivePokemon(:SIMISEAR)
    pbSummitGivePokemon(:SIMIPOUR)
    $game_variables[42].push(:SIMISAGE)
    $game_variables[42].push(:SIMISEAR)
    $game_variables[42].push(:SIMIPOUR)
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

def pbSummitGiftPokemon
  size = $game_variables[44].length
  trainer = $game_variables[44][rand(0...size)]
  gift = SummitGifts.const_get(trainer.to_s)
  pkmn = pbSummitMakePokemon(gift[:species], gift[:form])
  pbShowPokemonSprite(@givepkmn)
  pbSummitGivePokemon(pkmn)
end
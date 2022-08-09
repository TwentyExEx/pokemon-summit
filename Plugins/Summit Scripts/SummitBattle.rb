$bracketnames = ["Kanto Leaders", "Johto Leaders", "Hoenn Leaders", "Sinnoh Leaders", "Unova Leaders", "Kalos Leaders", "Alola Captains", "Galar Leaders", "Team Bosses","Kanto Elite","Johto Elite","Hoenn Elite","Sinnoh Elite","Unova Elite","Kalos Elite","Alola Elite","Galar Elite","Champions"]
$poketypes = ["normal", "fighting", "flying", "poison", "ground", "rock", "bug", "ghost", "steel", "fire", "water", "grass", "electric", "psychic", "ice", "dragon", "dark", "fairy"]
$trbytype = [
  normal = [
    :CAPTAIN_Ilima,
    :ELITE_Birch,
    :ELITE_Elm,
    :ELITE_Juniper,
    :ELITE_N,
    :ELITE_Oak,
    :ELITE_Sonia,
    :ELITE_Sycamore,
    :ELITE_Trevor,
    :LEADER_Cheren,
    :LEADER_Lenora,
    :LEADER_Norman,
    :LEADER_Whitney],       
  fighting = [
    :ELITE_Bruno,
    :ELITE_Bruno2,
    :ELITE_Hala,
    :ELITE_Marshal,
    :LEADER_Brawly,
    :LEADER_Chuck,
    :LEADER_Maylene,
    :LEADER_Bea,
    :ELITE_Mustard,
    :LEADER_Korrina],      
  flying = [
    :LEADER_Falkner,
    :LEADER_Winona,
    :LEADER_Skyla,
    :ELITE_Kahili],
  poison = [
    :LEADER_Janine,
    :LEADER_Roxie,
    :ELITE_Koga,
    :ELITE_Klara],
  ground = [
    :LEADER_Giovanni,
    :LEADER_Clay,
    :ELITE_Bertha],
  rock = [
    :LEADER_Brock,
    :LEADER_Roxanne,
    :LEADER_Roark,
    :LEADER_Grant,
    :ELITE_Olivia], 
  bug = [
      :LEADER_Bugsy,
      :LEADER_Burgh,
      :LEADER_Viola,
      :ELITE_Aaron],
  ghost = [
      :LEADER_Morty,
      :LEADER_Fantina,
      :CAPTAIN_Acerola,
      :ELITE_Agatha,
      :ELITE_Phoebe,
      :ELITE_Shauntal,
      :LEADER_Allister],
  steel = [
      :LEADER_Jasmine,
      :LEADER_Byron,
      :ELITE_Wikstrom,
	    :ELITE_Peony,
      :ELITE_Molayne],
  fire = [
      :LEADER_Blaine,
      :LEADER_Flannery,
      :LEADER_Chili,
      :CAPTAIN_Kiawe,
      :ELITE_Flint,
      :ELITE_Malva,
      :LEADER_Kabu],
  water = [
      :LEADER_Misty,
      :LEADER_Juan,
      :LEADER_Wake,
      :LEADER_Cress,
      :LEADER_Marlon,
      :CAPTAIN_Lana,
      :ELITE_Siebold,
      :LEADER_Nessa],
  grass = [
      :LEADER_Erika,
      :LEADER_Gardenia,
      :LEADER_Cilan,
      :LEADER_Ramos,
      :CAPTAIN_Mallow,
      :LEADER_Milo],
  electric = [
      :LEADER_Surge,
      :LEADER_Wattson,
      :LEADER_Volkner,
      :LEADER_Elesa,
      :LEADER_Clemont,
      :CAPTAIN_Sophocles],
  psychic = [
      :LEADER_Sabrina,
      :LEADER_Tate,
      :LEADER_Liza,
      :LEADER_Olympia,
      :ELITE_Will,
      :ELITE_Lucian,
      :ELITE_Caitlin,
      :ELITE_Avery],
  ice = [
      :LEADER_Pryce,
      :LEADER_Candice,
      :LEADER_Brycen,
      :LEADER_Wulfric,
      :ELITE_Lorelei,
      :LEADER_Melony,
      :ELITE_Glacia],
  dragon = [
      :LEADER_Clair,
      :LEADER_Drayden,
      :LEADER_Raihan,
      :ELITE_Lance,
      :ELITE_Drake,
      :ELITE_Drasna],
  dark = [
      :ELITE_Karen,
      :ELITE_Sidney,
      :LEADER_Piers,
      :ELITE_Grimsley],
  fairy = [
      :LEADER_Valerie,
      :CAPTAIN_Mina,
      :LEADER_Opal]
]

def pbSummitBracketSelection(group)
  trainerSelection = []
  case group
    when 0 # Kanto Leaders
      trainerlist = [
        ["LEADER_Brock","Brock"],
        ["LEADER_Misty","Misty"],
        ["LEADER_Surge","Lt. Surge"],
        ["LEADER_Erika","Erika"],
        ["LEADER_Janine","Janine"],
        ["LEADER_Sabrina","Sabrina"],
        ["LEADER_Blaine","Blaine"],
        ["LEADER_Giovanni","Giovanni"]
      ]
    when 1 # Johto Leaders
        trainerlist = [
          ["LEADER_Falkner","Falkner"],
          ["LEADER_Bugsy","Bugsy"],
          ["LEADER_Morty","Morty"],
          ["LEADER_Whitney","Whitney"],
          ["LEADER_Chuck","Chuck"],
          ["LEADER_Jasmine","Jasmine"],
          ["LEADER_Pryce","Pryce"],
          ["LEADER_Clair","Clair"]
        ]
    when 2 # Hoenn Leaders
          trainerlist = [
          ["LEADER_Roxanne","Roxanne"],
          ["LEADER_Brawly","Brawly"],
          ["LEADER_Wattson","Wattson"],
          ["LEADER_Flannery","Flannery"],
          ["LEADER_Norman","Norman"],
          ["LEADER_Winona","Winona"],
          ["LEADER_Tate","Tate"],
          ["LEADER_Liza","Liza"],
          ["LEADER_Juan","Juan"]
        ]
    when 3 # Sinnoh Leaders
      trainerlist = [
        ["LEADER_Roark","Roark"],
        ["LEADER_Gardenia","Gardenia"],
        ["LEADER_Maylene","Maylene"],
        ["LEADER_Wake","Crasher Wake"],
        ["LEADER_Fantina","Fantina"],
        ["LEADER_Byron","Byron"],
        ["LEADER_Candice","Candice"],
        ["LEADER_Volkner","Volkner"]
      ]   
    when 4 # Unova Leaders
      trainerlist = [
        ["LEADER_Cilan","Cilan"],
        ["LEADER_Chili","Chili"],
        ["LEADER_Cress","Cress"],
        ["LEADER_Lenora","Lenora"],
        ["LEADER_Burgh","Burgh"],
        ["LEADER_Elesa","Elesa"],
        ["LEADER_Clay","Clay"],
        ["LEADER_Skyla","Skyla"],
        ["LEADER_Drayden","Drayden"],
        ["LEADER_Cheren","Cheren"],
        ["LEADER_Roxie","Roxie"],
        ["LEADER_Marlon","Marlon"],
        ["LEADER_Brycen","Brycen"]
      ]
    when 5 # Kalos Leaders
      trainerlist = [
        ["LEADER_Viola","Viola"],
        ["LEADER_Grant","Grant"],
        ["LEADER_Korrina","Korrina"],
        ["LEADER_Ramos","Ramos"],
        ["LEADER_Clemont","Clemont"],
        ["LEADER_Valerie","Valerie"],
        ["LEADER_Olympia","Olympia"],
        ["LEADER_Wulfric","Wulfric"]
      ]
    when 6 # Alola Captains
      trainerlist = [
        ["CAPTAIN_Ilima","Ilima"],
        ["CAPTAIN_Mallow","Mallow"],
        ["CAPTAIN_Lana","Lana"],
        ["CAPTAIN_Kiawe","Kiawe"],
        ["CAPTAIN_Sophocles","Sophocles"],
        ["CAPTAIN_Acerola","Acerola"],
        ["CAPTAIN_Mina","Mina"]
      ]
    when 7 # Galar Leaders
      trainerlist = [
        ["LEADER_Milo","Milo"],
        ["LEADER_Nessa","Nessa"],
        ["LEADER_Kabu","Kabu"],
        ["LEADER_Bea","Bea"],
        ["LEADER_Allister","Allister"],
        ["LEADER_Opal","Opal"],
        ["LEADER_Gordie","Gordie"],
        ["LEADER_Melony","Melony"],
        ["LEADER_Piers","Piers"],
        ["LEADER_Raihan","Raihan"]
      ]
    when 8 # Team Bosses
      trainerlist = [
        ["BOSS_Rose","Rose"],
        ["BOSS_Guzma","Guzma"],
        ["BOSS_Lysandre","Lysandre"],
        ["BOSS_Ghetsis","Ghetsis"],
        ["BOSS_Cyrus","Cyrus"],
        ["BOSS_Archie","Archie"],
        ["BOSS_Maxie","Maxie"],
        ["BOSS_Giovanni","Giovanni"]
      ]
    when 9 # Kanto E4
      trainerlist = [
        ["ELITE_Lorelei","Lorelei"],
        ["ELITE_Bruno","Bruno"],
        ["ELITE_Agatha","Agatha"],
        ["ELITE_Lance","Lance"],
        ["CHAMPION_Blue","Blue"]
      ]
    when 10 # Johto E4
      trainerlist = [
        ["ELITE_Will","Will"],
        ["ELITE_Koga","Koga"],
        ["ELITE_Bruno2","Bruno"],
        ["ELITE_Karen","Karen"],
        ["CHAMPION_Lance","Lance"]
      ]
    when 11 # Sinnoh E4
      trainerlist = [
        ["ELITE_Sidney","Sidney"],
        ["ELITE_Phoebe","Phoebe"],
        ["ELITE_Glacia","Glacia"],
        ["ELITE_Drake","Drake"],
        ["CHAMPION_Steven","Steven"]
      ]
    when 12 # Sinnoh E4
      trainerlist = [
        ["ELITE_Aaron","Aaron"],
        ["ELITE_Bertha","Bertha"],
        ["ELITE_Flint","Flint"],
        ["ELITE_Lucian","Lucian"],
        ["CHAMPION_Cynthia","Cynthia"]
      ]
    when 13 # Unova E4
      trainerlist = [
        ["ELITE_Shauntal","Shauntal"],
        ["ELITE_Marshal","Marshal"],
        ["ELITE_Grimsley","Grimsley"],
        ["ELITE_Caitlin","Caitlin"],
        ["CHAMPION_Iris","Iris"]
      ]
    when 14 # Kalos E4
      trainerlist = [
        ["ELITE_Malva","Malva"],
        ["ELITE_Siebold","Siebold"],
        ["ELITE_Wikstrom","Wikstrom"],
        ["ELITE_Drasna","Drasna"],
        ["CHAMPION_Diantha","Diantha"]
      ]
    when 15 # Alola E4
      trainerlist = [
        ["ELITE_Hala","Hala"],
        ["ELITE_Molayne","Molayne"],
        ["ELITE_Olivia","Olivia"],
        ["ELITE_Kahili","Kahili"],
        ["CHAMPION_Kukui","Kukui"]
      ]
    when 16 # Galar E4
      trainerlist = [
        ["ELITE_Klara","Klara"],
        ["ELITE_Avery","Avery"],
        ["ELITE_Mustard","Mustard"],
        ["ELITE_Peony","Peony"],
        ["CHAMPION_Leon","Leon"]
      ]
    when 17 # Champions
        trainerlist = [
          ["CHAMPION_Leon","Leon"],
          ["CHAMPION_Hau","Hau"],
          ["CHAMPION_Kukui","Kukui"],
          ["CHAMPION_Diantha","Diantha"],
          ["CHAMPION_Iris","Iris"],
          ["CHAMPION_Alder","Alder"],
          ["CHAMPION_Cynthia","Cynthia"],
          ["CHAMPION_Wallace","Wallace"],
          ["CHAMPION_Steven","Steven"],
          ["CHAMPION_Lance","Lance"],
          ["CHAMPION_Blue","Blue"],
          ["CHAMPION_Red","Red"]
        ]
  end
  case
    when group < 8
      until trainerSelection.length == 4 do
        num = rand(0...(trainerlist.length))
        trainer = trainerlist[num]
        if !trainerSelection.include?(trainer)
          if group == 2 && trainer[0] == ("LEADER_Tate")
            if !trainerSelection.include?(["LEADER_Liza","Liza"])
              trainerSelection.push(trainer)
            else
              break
            end
          elsif group == 2 && trainer[0] == ("LEADER_Liza")
            if !trainerSelection.include?(["LEADER_Tate","Tate"])
              trainerSelection.push(trainer)
            else
              break
            end
          elsif group == 4 && trainer[0] == ("LEADER_Cheren")
            if !trainerSelection.include?(["LEADER_Lenora","Lenora"])
              trainerSelection.push(trainer)
            else
              break
            end
          elsif group == 4 && trainer[0] == ("LEADER_Lenora")
            if !trainerSelection.include?(["LEADER_Cheren","Cheren"])
              trainerSelection.push(trainer)
            else
              break
            end
          elsif group == 4 && trainer[0] == ("LEADER_Cress")
            if !trainerSelection.include?(["LEADER_Marlon","Marlon"])
              trainerSelection.push(trainer)
            else
              break
            end
          elsif group == 4 && trainer[0] == ("LEADER_Marlon")
            if !trainerSelection.include?(["LEADER_Cress","Cress"])
              trainerSelection.push(trainer)
            else
              break
            end      
          else
            trainerSelection.push(trainer)
          end
        end
      end
    when group >= 8
      trainerSelection = trainerlist
  end
  $game_variables[29] = trainerSelection
end

def pbSummitBracketAnnounce
  bracket = $bracketnames[$game_variables[31]]
  pbMessage(_INTL("\\rYou will be facing the {1} bracket.",bracket))
end

def pbSummitPartyCheck
  if $game_variables[31] < 9
    if $player.pokemon_count == 3
      return true
    else
      $game_variables[5] = "three"
      return false
    end
  elsif $game_variables[31] >= 9
    if $player.pokemon_count == 6
      return true
    else
      $game_variables[5] = "six"
      return false
    end
  end
end

def pbSummitPrepMainTrainer(bracket)
  if $game_variables[35] == "challenge" || "bosses"
    trainers = $game_variables[29]
    fightnum = $game_variables[33]
    opponent = trainers[fightnum]
  else
    trainers = $game_variables[44]
    fightnum = rand(0...trainers.length)
    opponent = trainers[fightnum][0]
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
  when 2, 11 # Hoenn Leaders and Hoenn E4
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
    when "elite_sidney"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 1
    when "elite_phoebe"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 2
    when "elite_glacia"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 3
    when "elite_drake"
      $game_map.events[1].direction = 8
      $game_map.events[1].pattern = 0
    when "champion_steven"
      $game_map.events[1].character_name = "trainer_Sheet13"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 2
    end
  when 3, 8 # Sinnoh Leaders, Team Bosses
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
      $game_map.events[1].pattern = 0
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
    when "boss_giovanni"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 0
    when "boss_archie"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 1
    when "boss_maxie"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 2
    when "boss_cyrus"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 3
    when "boss_ghetsis"
      $game_map.events[1].direction = 8
      $game_map.events[1].pattern = 0
    when "boss_lysandre"
      $game_map.events[1].direction = 8
      $game_map.events[1].pattern = 1
    when "boss_guzma"
      $game_map.events[1].direction = 8
      $game_map.events[1].pattern = 2
    when "boss_rose"
      $game_map.events[1].direction = 8
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
      when "leader_gordie"
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
   when 9 # Kanto E4
      $game_map.events[1].character_name = "trainer_Sheet1"
      case opponent[0].downcase
      when "elite_lorelei"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 1
      when "elite_bruno"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 2
      when "elite_agatha"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 3
      when "elite_lance"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 1
      when "champion_blue"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 0
      end
   when 10 # Johto E4
      case opponent[0].downcase
      when "elite_will"
        $game_map.events[1].character_name = "trainer_Sheet8"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 0
      when "elite_koga"
        $game_map.events[1].character_name = "trainer_Sheet1"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 0
      when "elite_bruno2"
        $game_map.events[1].character_name = "trainer_Sheet1"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 2
      when "elite_karen"
        $game_map.events[1].character_name = "trainer_Sheet8"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 1
      when "champion_lance"
        $game_map.events[1].character_name = "trainer_Sheet1"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 1
      end
    when 12 # Sinnoh E4
       $game_map.events[1].character_name = "trainer_Sheet8"
       case opponent[0].downcase
       when "elite_aaron"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 1
       when "elite_bertha"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 2
       when "elite_flint"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 3
       when "elite_lucian"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 0
       when "champion_cynthia"
        $game_map.events[1].character_name = "trainer_Sheet13"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 0
       end
   when 13 # Unova E4
      $game_map.events[1].character_name = "trainer_Sheet9"
      case opponent[0].downcase
      when "elite_shauntal"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 0
      when "elite_marshal"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 1
      when "elite_grimsley"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 2
      when "elite_caitlin"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 3
      when "champion_iris"
        $game_map.events[1].character_name = "trainer_Sheet13"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 2
      end
   when 14 # Kalos E4
      $game_map.events[1].character_name = "trainer_Sheet6"
      case opponent[0].downcase
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
      when "champion_diantha"
        $game_map.events[1].character_name = "trainer_Sheet13"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 1
      end
   when 15 # Alola E4
      $game_map.events[1].character_name = "trainer_Sheet7"
      case opponent[0].downcase
      when "elite_hala"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 3
      when "elite_molayne"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 3
      when "elite_olivia"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 0
      when "elite_kahili"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 0
      when "champion_kukui"
        $game_map.events[1].character_name = "trainer_Sheet13"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 0
      end
   when 16 # Galar E4
      $game_map.events[1].character_name = "trainer_Sheet9"
      case opponent[0].downcase
      when "elite_klara"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 3
      when "elite_avery"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 0
      when "elite_mustard"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 1
      when "elite_peony"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 1
      when "champion_leon"
        $game_map.events[1].character_name = "trainer_Sheet13"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 0
      end
   when 17 # Champions
      $game_map.events[1].character_name = "trainer_Sheet13"
      case opponent[0].downcase
      when "champion_leon"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 0
      when "champion_hau"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 3
      when "champion_kukui"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 0
      when "champion_diantha"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 1
      when "champion_iris"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 2
      when "champion_alder"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 3
      when "champion_cynthia"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 0
      when "champion_wallace"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 1
      when "champion_steven"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 2
      when "champion_lance"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 3
      when "champion_blue"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 0
      when "champion_red"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 1
      end
  end
  
  for i in 0...$trbytype.size
    if $trbytype[i].include?(opponent[0].to_sym)
      $bg = $poketypes[i]
      break
    end
  end
end

def pbSummitTestIntro # Debug
    testgroup = [
    ["BOSS_Lysandre","Lysandre"],
    ["CHAMPION_Steven","Steven"],
    ["CHAMPION_Cynthia","Cynthia"],
    ["ELITE_Shauntal","Shauntal"],
    ["ELITE_Marshal","Marshal"],
    ["ELITE_Caitlin","Caitlin"],
    ["ELITE_Wikstrom","Wikstrom"]
  ]
  for trainer in testgroup
    for i in 0...$trbytype.size
      if $trbytype[i].include?(trainer[0].to_sym)
        $bg = $poketypes[i]
        break
      end
    end
  $game_variables[30] = trainer
  # pbSummitAnnounceMainTrainer
  pbSummitMainTrainerSpeech
  end
end

def pbSummitAnnounceMainTrainer
  opp = GameData::TrainerType.get($game_variables[30][0]).name.clone << " " << $game_variables[30][1]
  if $game_switches[45] == true
    case $game_variables[30][1]
      when "Leon"
        messages = ["All the way from Galar, their league's very own Chairman and Champion comes to grace our arena.","Give it up for Champion Leon!"]
      when "Kukui"
        messages = ["Is that The Masked Royal? Surely not...","Wait, even better--it's Professor Kukui!"]
      when "Hau"
        messages = ["From humble beginnings, rising up to become a well renowned Trainer...","Next up, we have Champion Hau!"]
      when "Diantha"
        messages = ["The famed Grand Duchess graces our presence, bringing both beauty and power!","Everybody put your hands together for Champion Diantha!"]
      when "Iris"
        messages = ["She may look unassuming to the unaware, but don't dare underestimate her.","Hailing from the Village of Dragons, here comes Champion Iris!"]
      when "Alder"
        messages = ["One of Unova's most acclaimed trainers, Champion Alder stands strong against all foes.","Certainly a intense wall to overcome!"]
      when "Cynthia"
        messages = ["Terrifyingly powerful and a force to be reckoned with, Champion Cynthia is here to crush the competition.","Did you know she is a archeologist too?"]
      when "Wallace"
        messages = ["Contest Master and beauty king with some of the most gorgeous Pokémon.","On top of that, Champion Wallace is an ace Water-type trainer."]
      when "Steven"
        messages = ["President of a massive company and a ruthless Steel-type user.","Champion Steven is a far more successful Chairman Rose!"]
      when "Lance"
        messages = ["From Kanto Elite, to Johto Champion...","Johto's favorite Champion Lance has come to fight again!"]
      when "Blue"
        messages = ["Not many trainers can claim as many titles as Champion Blue has in his time.","This is sure to be a immense battle!"]
      when "Red"
        messages = ["This is it. The final fight.","No need for words anymore, just like Champion Red."]
    end
    for i in messages
      pbMessage("\\xn[Announcer]\\ml[ANNOUNCER]\\p<outln2>#{i}</outln2>")
    end
  else  
    messages = [
      ["Now, I've been looking forward to this matchup.","Challenger #{$player.name} and #{opp} in the same room, let alone battling for us!?"],
      ["Audience, strap in, this round is going to be incredible.","Challenger #{$player.name} vs #{opp}, starting in just a moment!"],
      ["#{opp} is looking ready for a intense fight!","Here comes Challenger #{$player.name} to give them what they want!"],
      ["Don't turn off your television sets, dear viewers at home.","Challenger #{$player.name} is about to face the legendary #{opp}!"],
      ["I can't believe my eyes, is #{opp} really in the building?","Sorry, Challenger #{$player.name}, you're cool too."],
      ["Challenger #{$player.name} vs #{opp}?","This is going to get ugly..."],
      ["The energy in the arena grows evermore intense as Challenger #{$player.name} and #{opp} prepare their Pokémon."],
      ["What kind of battle can we expect from Challenger #{$player.name} and #{opp} today?"],
      ["The potential battle of the century quietly begins today between Challenger #{$player.name} and #{opp}."],
      ["Everyone, please welcome Challenger #{$player.name} and #{opp}!","There's no doubt that this is an important battle for both trainers."],
      ["The once peaceful air is now turning thick with tension at the appearance of #{$player.name} and #{opp}!"],
      ["We got a special one today, folks.","Challenger #{$player.name}, up against the incredible #{opp}!"]
    ]
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
          ["With Pokémon that can chop right through concrete, #{opp} enters the ring!","Will this force prove too strong for Challenger #{$player.name}?"],
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
          ["The ground rumbles with anticipation for #{opp} and their earth-shattering Pokémon...","Challenger #{$player.name} had better hold on to something."],
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
          ["I try not to be biased, but the Bug-type Pokémon of #{opp} give me no choice.","Send 'em Flying, Challenger #{$player.name}."]
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
          ["With their sturdy Steel-type Pokémon, #{opp} has come to shake things up.","But Challenger #{$player.name} is here to stoke the Fire of battle!"],
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
          ["A team of fresh Water-type Pokémon from #{opp} stare down Challenger #{$player.name}.","The energy in here is Electric!"],
      ]
    when "grass"
      typemessages = [
          ["Are you ready to take on the full power of nature, Challenger #{$player.name}?","Here comes #{opp}!"],
          ["#{opp} stands before us, planted in place, ready to battle...","Find a way to uproot them, Challenger #{$player.name}!"],
          ["#{opp} is one of the best Grass-type trainers in the world and is looking extremely confident.","Challenger #{$player.name} needs to put out that Fire of ambition!"],
      ]
    when "electric"
      typemessages = [
          ["Bzzzt... Bzzzt... ZAP! Did you guys like my impression of electricity? No?!","Fine... It's battle time between Challenger #{$player.name} and #{opp}!"],
          ["Challenger #{$player.name}! is about to be shocked by the Electric-type power of #{opp}!"],
          ["With their battery of Electric-type Pokémon, #{opp} is ready to fry the competition.","Challenger #{$player.name}, make sure to Ground yourself!"],
      ]
    when "psychic"
      typemessages = [
          ["Can #{opp} read my mind? I don't think I'm ready for that...","Challenger #{$player.name}! Distract them!"],
          ["A magical battle is about to unfold between the enchanting #{opp} and Challenger #{$player.name}!"],
          ["#{opp} and their team of Psychic-type Pokémon prove that the mind is mightier than muscle.","Challenger #{$player.name}! Show off your Dark side..."],
      ]
    when "ice"
      typemessages = [
          ["Pour yourself a piping hot cup of joe, viewers, the chilling battle is about to begin!","Here comes #{opp} and Challenger #{$player.name}!"],
          ["This one is going to be one cool match... It's funny because #{opp} is using Ice-type Pokémon...","sigh... Take it from here Challenger #{$player.name}!"],
          ["#{opp} and their freezing Ice-type Pokémon look comfortable and confident.","But here comes Challenger #{$player.name} to Rock the boat!"],
      ]
    when "dragon"
      typemessages = [
          ["An ancient and powerful tension fills the arena...","A tension that can only be made by Challenger #{$player.name} and #{opp} in the same room!"],
          ["#{opp} demands respect with the power of their Dragon-type Pokémon...","Can Challenger #{$player.name} come out on top against their fierce team?"],
          ["#{opp} approaches with their team of powerful Dragon-type Pokémon...","Will Challenger #{$player.name} be able to find a <i>Fair</i>-y and N-<i>Ice</i> way to win this fight?","<i>Okay, that one was a stretch...</i>"],
      ]
    when "dark"
      typemessages = [
          ["Did someone turn out the lights? No, it's just some Dark-type Pokémon!","Let's get a spotlight on the arena and watch this fight unfold against #{opp} and Challenger #{$player.name}!"],
          ["Look closely, folks! #{opp} has snuck into the arena.","This calculating trainer and their equally cunning Pokémon are sure to give Challenger #{$player.name} a tough fight!"],
          ["#{opp} and their Dark-type Pokémon seem to have a crystal clear focus...","Maybe if Challenger #{$player.name} Bugs them enough, they'll distract them enough to win this!"],
      ]
    when "fairy"
      typemessages = [
          ["Oh. My. Goodness. Look at the adorable Fairy-type Pokémon alongside #{opp}!","Challenger #{$player.name}, don't you hurt them! I mean--give it all you've got!"],
          ["#{opp} turns fantasy into reality with their magical Fairy-type Pokémon!","Can Challenger #{$player.name} make a little magic of their own?"],
          ["#{opp} and their Fairy-type Pokémon are prepared to cast a spell on us!","Challenger #{$player.name} will have to have nerves of Steel to close this out!"],
      ]
    end
    num = rand(100)
    if num < 50
      set = "standard"
      chosen = messages
    else
      if typemessages.is_a?(Array)
        set = "type"
        chosen = typemessages
      else
        set = "standard"
        chosen = messages
      end
    end
  loop do
    @msgnum = rand(0...chosen.length)
    newmessage = [set, @msgnum]
    break if newmessage != $game_variables[45]
  end
  for i in chosen[@msgnum]
    pbMessage("\\xn[Announcer]\\ml[ANNOUNCER]\\p<outln2>#{i}</outln2>")
  end
  $game_variables[45] = [set, @msgnum]
  end
end

def pbSummitMainTrainerSpeech
  trainer = $game_variables[30][0].to_s
  if !$game_variables[44].include?($game_variables[30])
    ver = :meeting
  else
    ver = :rematch
  end
  text = TrainerIntros.const_get(trainer)[ver]
  namepic = "\\xnr[#{$game_variables[30][1]}]\\mr[#{$game_variables[30][0].to_s}]"
  pbMessage("#{namepic}#{text}")
end

def pbSummitMainTrainer
  pbSummitPrepBattle
  type = $game_variables[30][0]
  name = $game_variables[30][1]
  version = $game_variables[15]
  if $game_variables[31] > 8
    version += 4
  end

  $DiscordRPC.details = "VS #{GameData::TrainerType.get($game_variables[30][0]).name} #{$game_variables[30][1]}"
  $DiscordRPC.large_image = $game_variables[30][0].downcase
  if $game_variables[35] == "challenge" || $game_variables[35] == "bosses" || $game_variables[35] == "gauntlet"
    $DiscordRPC.state = "#{$bracketnames[$game_variables[31]]} (#{$game_variables[33].to_int+1} of #{$game_variables[29].length})"
  elsif $game_variables[35] == "arcade"
    $DiscordRPC.state = "Arcade (Win Streak: #{$game_variables[43].to_int})"
  end
  $DiscordRPC.update

  if $game_variables[35] == "challenge" || $game_variables[35] == "gauntlet"
    
    if $game_switches[45] == true
      back = $game_variables[30][1].to_s.downcase
      base = $game_variables[30][1].to_s.downcase
      setBattleRule("backdrop", back)
      setBattleRule("base", base)
    else
      setBattleRule("backdrop", $bg.to_s)
      setBattleRule("base", $bg.to_s)
    end
  elsif $game_variables[35] == "bosses"
    setBattleRule("backdrop", "dark")
    setBattleRule("base", "dark")
  end
  
  TrainerBattle.start(type, name, version)

  $Trainer.party = $game_variables[27]
  if $game_variables[35] == "challenge" || $game_variables[35] == "bosses" || $game_variables[35] == "gauntlet" # Main mode
    if $game_variables[32] == 1
      $game_variables[33] += 1
      $game_variables[46] += 1
    end
    if $game_variables[35] == "challenge" && $game_variables[33] == 4 # when cleared bracket
      $game_variables[31] += 1 # next bracket
    elsif $game_variables[35] == "bosses"
      if $game_variables[33] == 8
        $game_variables[31] += 1 # next bracket
      end
      if $game_variables[33] == 4
        $game_switches[42] = true # break
      end
    elsif $game_variables[35] == "gauntlet"
      breakrounds = [3,6,9]
      if $game_variables[31] <= 16 && $game_variables[33] == 5 # when cleared bracket
        $game_variables[31] += 1 # next bracket
      elsif $game_switches[45] == true && breakrounds.include?($game_variables[33])
        $game_switches[42] = true # break
      elsif $game_switches[45] == true && $game_variables[33] == 11
        $game_switches[50] = true # red battle
      elsif $game_switches[45] == true && $game_variables[33] == 12
        $game_variables[31] += 1 # next bracket
      end
    end
  end
end

def pbSummitLobby
  $DiscordRPC.details = "In the Lobby"
  $DiscordRPC.large_image = "lobby"
  $DiscordRPC.state = "Preparing for Battle"
  $DiscordRPC.update
end

def pbSummitBracketUnlock(announce = true)
  bracketwon = $bracketnames[$game_variables[31]-1]
  bracketunlocked = $bracketnames[$game_variables[31]]
  $game_variables[41] = $game_variables[31] # Change var to last completed bracket
  for trainer in $game_variables[29]
    for pkmn in $Trainer.party
      pkmn.giveRibbon(trainer[0].to_sym)
    end
    $game_variables[44].push(trainer) # Add trainers defeated to array
  end
  if announce == true
    pbMessage(_INTL("\\rCongratulations on defeating the {1}!",bracketwon))
    pbSEPlay("Slots coin")
    $Trainer.money += 700
    pbMessage("\\G\\rYou have earned $700 for your performance.")
    pbMessage(_INTL("\\rYou have also successfully unlocked the {1}!",bracketunlocked))
  end
  $game_variables[29] = [] # Clear previous bracket selection
  if $game_variables[31] == 4 # Sinnoh beat
    $game_switches[39] = true
    $game_switches[40] = true
  elsif $game_variables[31] == 8 # Galar beat
    $game_switches[41] = true
  elsif $game_variables[31] == 17 # Galar beat
    $game_switches[45] = true
  end
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
  allTypes = [:YOUNGSTER,:GENTLEMAN,:LASS,:LADY,:BUGCATCHER,:CAMPER,:PICNICKER,:GAMBLER,:SCHOOLKID,:TUBER_F,:TUBER_M,:SWIMMER_F,:SWIMMER_M,:SAILOR,:BLACKBELT,:CRUSHGIRL,:HIKER,:RUINMANIAC,:SCIENTIST,:SUPERNERD,:PSYCHIC_F,:PSYCHIC_M,:JUGGLER,:CHANELLER,:HEXMANIAC,:KIMONOGIRL,:BEAUTY,:AROMALADY,:KINDLER,:BOARDER,:ROCKER,:ENGINEER,:BIKER,:CUEBALL,:BURGLAR,:BIRDKEEPER,:FISHERMAN,:POKEMANIAC,:TAMER,:POKEMONBREEDER,:COOLTRAINER_M,:COOLTRAINER_F,:POKEMONRANGER_M,:POKEMONRANGER_F,:DRAGONTAMER,:FAIRYTALEGIRL]
  gruntTypes = [:TEAMROCKET_M,:TEAMROCKET_F,:AQUA_M,:AQUA_F,:MAGMA_M,:MAGMA_F,:GALACTIC_M,:GALACTIC_F,:FLARE_M,:FLARE_F]
  if $game_variables[31] > 9 # Bosses beat
    allTypes << gruntTypes
  end

  namesFem = ["Emma","Sophia","Olivia","Isabella","Ava","Mia","Abigail","Emily","Madison","Charlotte","Elizabeth","Amelia","Chloe","Ella","Evelyn","Avery","Sofia","Harper","Grace","Addison","Victoria","Natalie","Lily","Aubrey","Lillian","Zoey","Hannah","Layla","Brooklyn","Samantha","Zoe","Leah","Scarlett","Riley","Camila","Savannah","Anna","Audrey","Allison","Aria","Gabriella","Hailey","Claire","Sarah","Aaliyah","Kaylee","Nevaeh","Penelope","Alexa","Arianna","Stella","Alexis","Bella","Nora","Ellie","Ariana","Lucy","Mila","Peyton","Genesis","Alyssa","Taylor","Violet","Maya","Caroline","Madelyn","Skylar","Serenity","Ashley","Brianna","Kennedy","Autumn","Eleanor","Kylie","Sadie","Paisley","Julia","Mackenzie","Sophie","Naomi","Eva","Khloe","Katherine","Gianna","Melanie","Aubree","Piper","Ruby","Lydia","Faith","Madeline","Alexandra","Kayla","Hazel","Lauren","Annabelle","Jasmine","Aurora","Alice","Makayla","Sydney","Bailey","Luna","Maria","Reagan","Morgan","Isabelle","Rylee","Kimberly","Andrea","London","Elena","Jocelyn","Natalia","Trinity","Eliana","Vivian","Cora","Quinn","Liliana","Molly","Jade","Clara","Valentina","Mary","Brielle","Hadley","Kinsley","Willow","Brooke","Lilly","Delilah","Payton","Mariah","Paige","Jordyn","Nicole","Mya","Josephine","Isabel","Lyla","Adeline","Destiny","Ivy","Emilia","Rachel","Angelina","Valeria","Kendall","Sara","Ximena","Isla","Aliyah","Reese","Vanessa","Juliana","Mckenzie","Amy","Laila","Adalynn","Emery","Margaret","Eden","Gabrielle","Kaitlyn","Ariel","Gracie","Brooklynn","Melody","Jessica","Valerie","Adalyn","Adriana","Elise","Michelle","Rebecca","Daisy","Everly","Katelyn","Ryleigh","Catherine","Norah","Alaina","Athena","Leilani","Londyn","Eliza","Jayla","Summer","Lila","Makenzie","Izabella","Daniela","Stephanie","Julianna","Rose","Alana","Harmony","Jennifer","Maximus","Hayden"]
  namesMale = ["Noah","Liam","Jacob","Mason","William","Ethan","Michael","Alexander","James","Elijah","Daniel","Benjamin","Aiden","Jayden","Logan","Matthew","David","Joseph","Lucas","Jackson","Anthony","Joshua","Samuel","Andrew","Gabriel","Christopher","John","Dylan","Carter","Isaac","Ryan","Luke","Oliver","Nathan","Henry","Owen","Caleb","Wyatt","Christian","Sebastian","Jack","Jonathan","Landon","Julian","Isaiah","Hunter","Levi","Aaron","Eli","Charles","Thomas","Connor","Brayden","Nicholas","Jaxon","Jeremiah","Cameron","Evan","Adrian","Jordan","Gavin","Grayson","Angel","Robert","Tyler","Josiah","Austin","Colton","Brandon","Jose","Dominic","Kevin","Zachary","Ian","Chase","Jason","Adam","Ayden","Parker","Hudson","Cooper","Nolan","Lincoln","Xavier","Carson","Jace","Justin","Easton","Mateo","Asher","Bentley","Blake","Nathaniel","Jaxson","Leo","Kayden","Tristan","Luis","Elias","Brody","Bryson","Juan","Vincent","Cole","Micah","Ryder","Theodore","Carlos","Ezra","Damian","Miles","Santiago","Max","Jesus","Leonardo","Sawyer","Diego","Alex","Roman","Maxwell","Eric","Greyson","Hayden","Giovanni","Wesley","Axel","Camden","Braxton","Ivan","Ashton","Declan","Bryce","Timothy","Antonio","Silas","Kaiden","Ezekiel","Jonah","Weston","George","Harrison","Steven","Miguel","Richard","Bryan","Kaleb","Victor","Aidan","Jameson","Joel","Patrick","Jaden","Colin","Everett","Preston","Maddox","Edward","Alejandro","Kaden","Jesse","Emmanuel","Kyle","Brian","Emmett","Jude","Marcus","Kingston","Kai","Alan","Malachi","Grant","Jeremy","Riley","Jayce","Bennett","Abel","Ryker","Caden","Brantley","Luca","Brady","Calvin","Sean","Oscar","Jake","Maverick","Abraham","Mark","Tucker","Nicolas","Bradley","Kenneth","Avery","Cayden","King","Paul","Amir","Gael","Graham"]

  if $game_variables[35] == "arcade"
    trainertype = allTypes[rand(allTypes.length)]
  elsif $game_variables[35] == "grunts"
    trainertype = gruntTypes[rand(allTypes.length)]
  end

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

def pbSummitArcadeTrainer(party_size = 3)
  pbNewSummitTrainer(@arcadetype, @arcadename,0,true,party_size)
  GameData::TrainerType.get(@arcadetype).id
  pbSummitPrepBattle
  $DiscordRPC.details = "VS Arcade Trainer"
  $DiscordRPC.large_image = "arcade_trainer"
  $DiscordRPC.state = "Arcade (Win Streak: #{$game_variables[43].to_int})"
  $DiscordRPC.update
  TrainerBattle.start(@arcadetype, @arcadename)
  pbSummitEndBattle(@arcadetype, @arcadename)
  if $game_variables[32] == 1
    $game_variables[46] += 1
  end
end

def pbSummitChoosePokemon(tr_type, party_size = 3)
  type = tr_type.to_s.downcase
  num = nil
  party = []
  trainerpkmn = []

  case type
    when "youngster","gentleman"
    trainerpkmn = [:RATICATE,:ARBOK,:FEAROW,:PIDGEOT,:SANDSLASH,:NIDOKING,:NIDOQUEEN,:GOLEM,:PRIMEAPE,:DUGTRIO,:FURRET,:NOCTOWL,:QUAGSIRE,:MIGHTYENA,:SWELLOW,:SHIFTRY,:LUDICOLO,:MANECTRIC,:SWALOT,:STARAPTOR,:KRICKETUNE,:LUXRAY,:SKUNTANK,:BIBAREL,:GASTRODON,:WATCHOG,:STOUTLAND,:SEISMITOAD,:SCOLIPEDE,:CONKELDURR,:UNFEZANT,:SAWSBUCK,:GALVANTULA,:TALONFLAME,:DIGGERSBY,:PYROAR,:GUMSHOOS,:VIKAVOLT,:RATICATE_ALOLA,:MUK_ALOLA,:LYCANROC_MIDDAY,:ORBEETLE,:THIEVUL,:GREEDENT,:ELDEGOSS]
    when "lass", "lady"
    trainerpkmn = [:RATICATE,:ARBOK,:FEAROW,:PIDGEOT,:SANDSLASH,:NIDOKING,:NIDOQUEEN,:WIGGLYTUFF,:CLEFABLE,:VILEPLUME,:BELLOSSOM,:RAICHU,:PERSIAN,:FURRET,:QUAGSIRE,:AZUMARILL,:AMPHAROS,:GOLDUCK,:GRANBULL,:SHIFTRY,:LUDICOLO,:BRELOOM,:DELCATTY,:SWELLOW,:BIBAREL,:PACHIRISU,:LOPUNNY,:ROSERADE,:STARAPTOR,:WHIMSICOTT,:LILLIGANT,:LIEPARD,:SWOOBAT,:TOGEKISS,:SWANNA,:FLORGES,:DEDENNE,:DIGGERSBY,:KOMALA,:LYCANROC_DUSK,:TOUCANNON,:TSAREENA,:ARAQUANID,:HATTERENE,:GRIMMSNARL,:DREDNAW,:ALCREMIE]
    when "bugcatcher"
      trainerpkmn = [:BUTTERFREE,:BEEDRILL,:VENOMOTH,:PINSIR,:PARASECT,:SCIZOR,:LEDIAN,:ARIADOS,:FORRETRESS,:HERACROSS,:BEAUTIFLY,:DUSTOX,:MASQUERAIN,:NINJASK,:SHEDINJA,:WORMADAM_PLANTCLOAK,:WORMADAM_SANDYCLOAK,:WORMADAM_TRASHCLOAK,:MOTHIM,:VESPIQUEN,:SCOLIPEDE,:CRUSTLE,:ESCAVALIER,:GALVANTULA,:VOLCARONA,:VIVILLON,:VIKAVOLT,:RIBOMBEE,:GOLISOPOD,:ORBEETLE,:ARMALDO,:ARAQUANID,:CENTISKORCH,:FROSMOTH,:KRICKETUNE,:ACCELGOR]
    when "camper", "picnicker", "gambler"
      trainerpkmn = [:DUGTRIO,:DUGTRIO_ALOLA,:SANDSLASH,:SANDSLASH_ALOLA,:PRIMEAPE,:ARBOK,:RATICATE_ALOLA,:FEAROW,:ARCANINE,:NIDOKING,:NIDOQUEEN,:MAGCARGO,:URSARING,:GOLEM,:GOLEM_ALOLA,:ESPEON,:UMBREON,:WOBBUFFET,:SUDOWOODO,:CLAYDOL,:XATU,:SWALOT,:CROBAT,:PELIPPER,:CACTURNE,:SEVIPER,:ZANGOOSE,:PROBOPASS,:HARIYAMA,:LUXRAY,:SNORLAX,:MAGMORTAR,:ELECTIVIRE,:DRIFBLIM,:GASTRODON,:TANGROWTH,:CINCCINO,:DARMANITAN,:PANGORO,:GOGOAT,:PALOSSAND,:COPPERAJAH,:PERRSERKER,:OBSTAGOON]
    when "schoolkid"
      trainerpkmn = [:RAICHU,:RAICHU_ALOLA,:CLEFABLE,:WIGGLYTUFF,:TOGEKISS,:HITMONLEE,:HITMONCHAN,:HITMONTOP,:JYNX,:ELECTIVIRE,:MAGMORTAR,:AZUMARILL,:WOBBUFFET,:ROSERADE,:CHIMECHO,:SUDOWOODO,:MRMIME,:MRRIME,:BLISSEY,:SNORLAX,:LUCARIO,:MANTINE,:TOXTRICITY]
    when "tuber_f","tuber_m"
      trainerpkmn = [:GOLDUCK,:SLOWBRO,:SLOWBRO_GALAR,:KINGLER,:EXEGGUTOR,:EXEGGUTOR_ALOLA,:SLOWKING,:SLOWKING_GALAR,:AZUMARILL,:PELIPPER,:GASTRODON,:MALAMAR,:BARBARACLE,:TOXAPEX,:GOLISOPOD,:PALOSSAND,:PYUKUMUKU,:CRAMORANT,:GRAPPLOCT,:PERRSERKER,:PINCURCHIN,:SWAMPERT,:SAMUROTT,:PRIMARINA]
    when "swimmer_f","swimmer_m","sailor", "aqua_m", "aqua_f"
      trainerpkmn = [:GOLDUCK,:SEAKING,:GYARADOS,:AZUMARILL,:QUAGSIRE,:WHISCASH,:CRAWDAUNT,:MILOTIC,:FLOATZEL,:SHARPEDO,:EELEKTROSS,:ARAQUANID,:BARRASKEWDA,:DREDNAW,:TENTACRUEL,:CLOYSTER,:KINGDRA,:LAPRAS,:STARMIE,:GOREBYSS,:GASTRODON,:JELLICENT,:CLAWITZER,:BRUXISH,:WISHIWASHI,:LANTURN,:DRAGALGE,:DHELMISE,:CRAMORANT,:BLASTOISE,:FERALIGATR,:EMPOLEON]
    when "blackbelt","crushgirl"
      trainerpkmn = [:PRIMEAPE,:MACHAMP,:HITMONLEE,:HITMONCHAN,:HITMONTOP,:HARIYAMA,:LUCARIO,:CONKELDURR,:THROH,:SAWK,:MIENSHAO,:PASSIMIAN,:GRAPPLOCT,:SIRFETCHD,:FALINKS,:MEDICHAM,:PANGORO,:HAWLUCHA,:CRABOMINABLE,:POLIWRATH,:HERACROSS,:BLAZIKEN,:BRELOOM,:INFERNAPE,:TOXICROAK,:GALLADE,:EMBOAR,:SCRAFTY,:CHESNAUGHT,:BEWEAR,:KOMMOO]
    when "hiker","ruinmaniac"
      trainerpkmn = [:GOLEM,:GOLEM_ALOLA,:STEELIX,:MACHAMP,:DUGTRIO,:DUGTRIO_ALOLA,:SANDSLASH,:MAMOSWINE,:PROBOPASS,:CAMERUPT,:CLAYDOL,:SUDOWOODO,:BRONZONG,:RHYPERIOR,:DONPHAN,:GIGALITH,:EXCADRILL,:CONKELDURR,:AGGRON,:HIPPOWDON,:CRUSTLE,:GLISCOR,:MAWILE,:GOLURK,:MAROWAK,:DIGGERSBY,:CARBINK,:TYRANTRUM,:FLYGON,:LYCANROC_MIDNIGHT,:MUDSDALE,:COALOSSAL,:SLAKING,:OBSTAGOON,:SEVIPER,:WATCHOG,:LIEPARD,:DARMANITAN,:KROOKODILE]
    when "scientist","supernerd"
      trainerpkmn = [:KLINKLANG,:PERRSERKER,:COPPERAJAH,:SKARMORY,:MAWILE,:AGGRON,:METAGROSS,:BRONZONG,:AEGISLASH,:KLEFKI,:DURALUDON,:MAGNEZONE,:TOGEDEMARU,:ELECTRODE,:ELECTIVIRE,:JOLTEON,:AMPHAROS,:MANECTRIC,:LUXRAY,:ZEBSTRIKA,:BOLTUND,:ROTOM,:EMOLGA,:HELIOLISK,:ORICORIO_POMPOM,:TOXTRICITY,:VIKAVOLT,:MUK,:MUK_ALOLA,:WEEZING,:WEEZING_GALAR,:SWALOT,:GARBODOR]
    when "psychic_f","psychic_m","juggler"
      trainerpkmn = [:ALAKAZAM,:HYPNO,:ESPEON,:WOBBUFFET,:GRUMPIG,:CHIMECHO,:MUSHARNA,:GOTHITELLE,:REUNICLUS,:BEHEEYEM,:MEOWSTIC,:RAPIDASH_GALAR,:XATU,:GARDEVOIR,:GALLADE,:SWOOBAT,:SIGILYPH,:ORICORIO_PAU,:HATTERENE,:INDEEDEE,:RAICHU_ALOLA,:SLOWBRO,:SLOWBRO_GALAR,:EXEGGUTOR,:SLOWKING,:SLOWKING_GALAR,:MEDICHAM,:MRMIME,:MRRIME,:ORBEETLE,:MALAMAR,:DELPHOX,:BRONZONG,:METAGROSS,:CLAYDOL]
    when "chaneller","hexmaniac"
      trainerpkmn = [:GENGAR,:DRIFBLIM,:CHANDELURE,:MISMAGIUS,:DUSKNOIR,:COFAGRIGUS,:POLTEAGEIST,:TREVENANT,:GOURGEIST,:ORICORIO_SENSU,:PALOSSAND,:MIMIKYU,:DHELMISE,:MAROWAK_ALOLA,:SABLEYE,:FROSLASS,:JELLICENT,:GOLURK,:AEGISLASH,:DECIDUEYE,:RUNERIGUS,:DRAGAPULT,:BANETTE]
    when "kimonogirl"
      trainerpkmn = [:FLAREON,:VAPOREON,:JOLTEON,:ESPEON,:UMBREON,:LEAFEON,:GLACEON,:SYLVEON]
    when "beauty","aromalady"
      trainerpkmn = [:VENUSAUR,:VICTREEBEL,:VILEPLUME,:BELLOSSOM,:MEGANIUM,:SUNFLORA,:CHERRIM,:LEAFEON,:LILLIGANT,:LURANTIS,:TSAREENA,:ELDEGOSS,:JUMPLUFF,:ROSERADE,:WHIMSICOTT,:LEAVANNY,:SAWSBUCK,:CLEFABLE,:FLORGES,:AROMATISSE,:SLURPUFF,:SYLVEON,:COMFEY,:ALCREMIE,:TOGEKISS,:NINETALES_ALOLA,:RAPIDASH_GALAR,:GARDEVOIR,:MAWILE,:PRIMARINA]
    when "kindler", "magma_m", "magma_f"
      trainerpkmn = [:CHARIZARD,:NINETALES,:ARCANINE,:RAPIDASH,:FLAREON,:TYPHLOSION,:TORKOAL,:MAGMORTAR,:SIMISEAR,:DARMANITAN,:HEATMOR,:CINDERACE,:MAROWAK_ALOLA,:MAGCARGO,:BLAZIKEN,:CAMERUPT,:INFERNAPE,:EMBOAR,:TALONFLAME,:PYROAR,:INCINEROAR,:ORICORIO_BAILE,:TURTONATOR,:CENTISKORCH,:HOUNDOOM,:ROTOM_HEAT,:CHANDELURE,:SALAZZLE,:COALOSSAL]
    when "boarder"
      trainerpkmn = [:GLALIE,:GLACEON,:DARMANITAN_GALAR,:VANILLUXE,:BEARTIC,:CRYOGONAL,:AVALUGG,:EISCUE,:SANDSLASH_ALOLA,:NINETALES_ALOLA,:JYNX,:WALREIN,:MAMOSWINE,:FROSLASS,:MRRIME,:FROSMOTH,:DEWGONG,:CLOYSTER,:LAPRAS,:ABOMASNOW,:WEAVILE,:ROTOM_FROST,:AURORUS,:CRABOMINABLE,:ARCTOZOLT,:ARCTOVISH]
    when "rocker","engineer"
      trainerpkmn = [:RAICHU_ALOLA,:RAICHU,:ELECTRODE,:JOLTEON,:AMPHAROS,:MANECTRIC,:LUXRAY,:ELECTIVIRE,:ZEBSTRIKA,:EELEKTROSS,:BOLTUND,:PINCURCHIN,:MAGNEZONE,:ROTOM,:ROTOM_HEAT,:ROTOM_WASH,:ROTOM_FROST,:ROTOM_FAN,:ROTOM_MOW,:EMOLGA,:HELIOLISK,:DEDENNE,:ORICORIO_POMPOM,:TOGEDEMARU,:TOXTRICITY,:MORPEKO,:DRACOZOLT,:ARCTOZOLT,:GOLEM_ALOLA,:LANTURN,:GALVANTULA,:STUNFISK,:VIKAVOLT]
    when "biker","cueball","burglar","teamrocket_m","teamrocket_f","galactic_m","galactic_f","flare_m","flare_f"
      trainerpkmn = [:MUK,:WEEZING,:KROOKODILE,:MAGMORTAR,:PERSIAN_ALOLA,:ARBOK,:MUK_ALOLA,:UMBREON,:DRAPION,:GRANBULL,:HOUNDOOM,:TYRANITAR,:MIGHTYENA,:TOXICROAK,:EXPLOUD,:SHARPEDO,:CACTURNE,:SCRAFTY,:CRAWDAUNT,:BISHARP,:ABSOL,:HONCHKROW,:LIEPARD,:ZOROARK,:THIEVUL,:OBSTAGOON,:MANDIBUZZ,:MALAMAR,:PANGORO,:GRIMMSNARL,:LYCANROC_MIDDAY,:SHIFTRY,:SKUNTANK,:HYDREIGON,:RATICATE_ALOLA,:GOLISOPOD,:DREDNAW,:PERRSERKER]
    when "birdkeeper"
      trainerpkmn = [:PIDGEOT,:FEAROW,:CROBAT,:DODRIO,:AERODACTYL,:NOCTOWL,:XATU,:HONCHKROW,:SKARMORY,:SWELLOW,:STARAPTOR,:UNFEZANT,:SIGILYPH,:BRAVIARY,:MANDIBUZZ,:TALONFLAME,:DECIDUEYE,:TOUCANNON,:ORICORIO_BAILE,:ORICORIO_POMPOM,:ORICORIO_PAU,:ORICORIO_SENSU,:CORVIKNIGHT,:SIRFETCHD,:PELIPPER,:ALTARIA,:TOGEKISS,:SWOOBAT,:ARCHEOPS,:SWANNA,:HAWLUCHA,:NOIVERN,:CRAMORANT]
    when "fisherman"
      trainerpkmn = [:SEAKING,:LANTURN,:SHARPEDO,:WHISCASH,:LUMINEON,:WISHIWASHI,:BRUXISH,:BARRASKEWDA,:GYARADOS,:OCTILLERY,:WAILORD,:RELICANTH,:MALAMAR,:ALOMOMOLA,:TENTACRUEL,:CLOYSTER,:KINGLER,:CRAWDAUNT,:CARRACOSTA,:CLAWITZER,:GOLISOPOD,:POLIWRATH,:POLITOED,:HUNTAIL,:GOREBYSS,:GRENINJA,:TOXAPEX,:PYUKUMUKU,:SLOWBRO,:SLOWBRO_GALAR,:SLOWKING,:SLOWKING_GALAR,:KINGDRA,:SWAMPERT,:DREDNAW]
    when "pokemaniac","tamer"
      trainerpkmn = [:MAROWAK_ALOLA,:MAROWAK,:KANGASKHAN,:SNORLAX,:TYRANITAR,:AGGRON,:RAMPARDOS,:BASTIODON,:LICKILICKY,:AURORUS,:NIDOKING,:SLOWBRO,:SLOWBRO_GALAR,:SLOWKING,:SLOWKING_GALAR,:SWAMPERT,:SCEPTILE,:EXPLOUD,:TORTERRA,:GARCHOMP,:ABOMASNOW,:RHYPERIOR,:HAXORUS,:DRUDDIGON,:HELIOLISK,:TYRANTRUM,:AVALUGG,:SALAZZLE,:TURTONATOR,:DRAMPA,:DREDNAW]
    when "pokemonbreeder"
      trainerpkmn = [:RAICHU,:RAICHU_ALOLA,:CLEFABLE,:WIGGLYTUFF,:TOGEKISS,:HITMONLEE,:HITMONCHAN,:HITMONTOP,:JYNX,:ELECTIVIRE,:MAGMORTAR,:WOBBUFFET,:AZUMARILL,:ROSERADE,:CHIMECHO,:SUDOWOODO,:MRMIME,:MRRIME,:SNORLAX,:LUCARIO,:MANTINE,:TOXTRICITY,:VENUSAUR,:CHARIZARD,:BLASTOISE,:MEGANIUM,:TYPHLOSION,:FERALIGATR,:SCEPTILE,:BLAZIKEN,:SWAMPERT,:TORTERRA,:INFERNAPE,:EMPOLEON,:SERPERIOR,:EMBOAR,:SAMUROTT,:CHESNAUGHT,:DELPHOX,:GRENINJA,:DECIDUEYE,:INCINEROAR,:PRIMARINA,:RILLABOOM,:CINDERACE,:INTELEON]
    when "cooltrainer_m","cooltrainer_f","pokemonranger_m","pokemonranger_f"
      trainerpkmn = [:TYRANITAR,:SALAMENCE,:METAGROSS,:GARCHOMP,:SLAKING,:GYARADOS,:VENUSAUR,:CHARIZARD,:BLASTOISE,:MEGANIUM,:TYPHLOSION,:FERALIGATR,:SCEPTILE,:BLAZIKEN,:SWAMPERT,:TORTERRA,:INFERNAPE,:EMPOLEON,:SERPERIOR,:EMBOAR,:SAMUROTT,:CHESNAUGHT,:DELPHOX,:GRENINJA,:DECIDUEYE,:INCINEROAR,:PRIMARINA,:RILLABOOM,:CINDERACE,:INTELEON,:AGGRON,:LUCARIO,:GARDEVOIR,:GALLADE,:AERODACTYL,:AMPHAROS,:ALAKAZAM,:GENGAR,:PINSIR,:DRAGONITE,:SCIZOR,:HERACROSS,:HOUNDOOM,:HYDREIGON,:GOODRA,:KOMMOO,:DRAGAPULT,:ABOMASNOW,:SLOWBRO,:SLOWBRO_GALAR,:SLOWKING,:SLOWKING_GALAR,:KANGASKHAN,:ALTARIA,:GLALIE,:FROSLASS,:LOPUNNY,:ARCANINE,:ABSOL,:FLORGES,:VOLCARONA,:SHARPEDO,:TOGEKISS,:BLISSEY,:KINGDRA,:ELECTIVIRE,:MAGMORTAR,:MILOTIC,:DARMANITAN,:CROBAT,:LAPRAS,:VANILLUXE,:DURALUDON,:GOGOAT,:EXEGGUTOR,:EXEGGUTOR_ALOLA,:MAMOSWINE,:MEDICHAM,:AMBIPOM,:FLAREON,:VAPOREON,:JOLTEON,:ESPEON,:UMBREON,:LEAFEON,:GLACEON,:SYLVEON,:GOREBYSS,:HUNTAIL,:LURANTIS,:LILLIGANT,:MAWILE,:SABLEYE,:MISMAGIUS,:SANDSLASH_ALOLA,:SANDSLASH]
    when "dragontamer"
      trainerpkmn = [:SALAMENCE,:HYDREIGON,:GOODRA,:KOMMOO,:CHARIZARD,:KINGDRA,:GYARADOS,:DRAGONITE,:FLYGON,:ALTARIA,:GARCHOMP,:HAXORUS,:DRUDDIGON,:DRAGALGE,:TYRANTRUM,:NOIVERN,:TURTONATOR,:DRAMPA,:FLAPPLE,:APPLETUN,:DURALUDON,:DRAGAPULT,:EXEGGUTOR_ALOLA,:DRACOZOLT,:DRACOVISH]
    when "fairytalegirl"
      trainerpkmn = [:CLEFABLE,:GRANBULL,:FLORGES,:AROMATISSE,:SLURPUFF,:SYLVEON,:COMFEY,:ALCREMIE,:TOGEKISS,:NINETALES_ALOLA,:RAPIDASH_GALAR,:WEEZING_GALAR,:MRMIME,:AZUMARILL,:GARDEVOIR,:MAWILE,:WHIMSICOTT,:DEDENNE,:CARBINK,:KLEFKI,:PRIMARINA,:RIBOMBEE,:SHIINOTIC,:MIMIKYU,:HATTERENE,:GRIMMSNARL]
  end
  for i in 0...party_size
    loop do
      num = rand(0...(trainerpkmn.length))
      select = trainerpkmn[num]
      if !party.include?(select)
        pkmn = SummitPokeInfo.const_get(select)
        party.push(pkmn)
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

def pbSummitDeleteTrainer(tr_type, name, tr_version = 0)
  # Remove trainer's data from records
  trainer_id = [tr_type, name, tr_version]
  tr_data = GameData::Trainer::DATA[trainer_id]
  GameData::Trainer::DATA.delete(trainer_id)
  GameData::Trainer.save
end

def pbSummitArcadeStreakReward
  pbMessage("\\rCongratulations on finishing #{pbGet(43)} consecutive trainers in a row!")
  prize = 1000*($game_variables[43]/10.floor)
  pbSEPlay("Slots coin")
  $Trainer.money += prize
  pbMessage("\\r\GYou have earned #{prize.to_s_formatted} for your performance.")
end

$difficulties = ["Easy","Standard","Hard","Extreme","Cancel"]

def pbSummitDifficultySet
  cmd = pbMessage("\\rWhich difficulty would you like to select?",$difficulties,5)
  $game_variables[15] = cmd
  choice = $difficulties[cmd]
  if cmd != 4
    pbMessage("\\rYour difficulty has been set to #{choice}.")
    return true
  else
    return false
  end
end

def pbSummitDifficultyInfo
  cmd = pbMessage("\\rWhich difficulty would you like information on?",$difficulties,5)
  difficulty = $difficulties[cmd].downcase
  case difficulty
  when "easy"
    info = ["\\rOn Easy Mode, opponent Pokémon have lowered stats (15 IV) compared to later difficulties.",
    "\\rThey are also not Super Trained and their Natures are all neutral.",
    "\\rMovesets are also not defined, only using their level-up moves at Level 50."]
  when "standard"
    info = ["\\rOn Normal Mode, opponent Pokémon have decent stats (25 IV) compared to later difficulties.",
    "\\rThey are not Super Trained, but have beneficiary natures to their moveset."]
  when "hard"
    info = ["\\rOn Hard Mode, opponent Pokémon have perfect stats (31 IV).",
    "\\rThey are not Super Trained, but have beneficiary natures to their moveset, along with held items." ]
  when "extreme"
    info = ["\\rOn Extreme mode, opponent Pokémon have perfect stats (31 IV).",
    "\\rThey are Super Trained and have beneficiary natures to their moveset, along with held items."]
  end
  if cmd != 4
    for i in info
      pbMessage("#{i}")
    end
  end
end

def pbSummitRainbowRocket
  pbMessage("\\rCongratulations on defeating the Galar Leaders!")
  pbSEPlay("Slots coin")
  $Trainer.money += 700
  pbMessage("\\G\\rYou have earned $700 for your performance.")
  pbMessage("\\rYou have also successfully unlocked--")
  pbSEPlay("Mining collapse")
  $game_screen.start_shake(5, 5, 5 * Graphics.frame_rate / 20)
  $game_map.fog_name = "lobbyoff"
  $game_map.fog_zoom = 100
  $game_map.fog_blend_type = 2
  $game_map.fog_opacity = 0
  $game_map.start_fog_opacity_change(200, 6 * Graphics.frame_rate / 20)
  pbWait(14 * Graphics.frame_rate / 20)
  pbMessage("\\rOh no! What's happening?")
  pbSEPlay("Mining collapse")
  $game_screen.start_shake(5, 5, 5 * Graphics.frame_rate / 20)
  pbWait(14 * Graphics.frame_rate / 20)
  pbBGMFade(1)
  pbBGMPlay("bossspeaker")
  pbMessage("\\xnr[Giovanni]\\mr[LEADER_Giovanni]\\b<outln2>Attention all World Summit employees and participants!</outln2>")
  pbMessage("\\xnr[Giovanni]\\mr[LEADER_Giovanni]\\b<outln2>This building is now under the control of Team Rainbow Rocket.</outln2>")
  pbMessage("\\xnr[Giovanni]\\mr[LEADER_Giovanni]\\b<outln2>We are about to make our way down to the lobby to collect all of your resources.</outln2>")
  pbMessage("\\xnr[Giovanni]\\mr[LEADER_Giovanni]\\b<outln2>Stay out of our way or experience a world of pain.</outln2>")
  pbBGMFade(2)
  pbWait(80)
  pbBGMPlay("bosslobby")
  pbMessage("\\rThis is awful! Somebody needs to stop them!")
  pbMessage("\\rYou're a strong trainer... Please, you have to do something!")
  pbMessage("\\rTalk to me when you're prepared... I can take you to the floor they're on.")
end
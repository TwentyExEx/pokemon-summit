$bracketnames = ["Kanto Leaders", "Johto Leaders", "Hoenn Leaders", "Sinnoh Leaders", "Unova Leaders", "Kalos Leaders", "Alola Captains", "Galar Leaders", "Team Bosses","Kanto Elite Four","Johto Elite Four","Hoenn Elite Four","Sinnoh Elite Four","Unova Elite Four","Kalos Elite Four","Alola Elite Four","Galar Elite Four","Champions"]
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
    :CHAMPION_Kukui,
    :ELITE_Bruno,
    :ELITE_Bruno2,
    :ELITE_Hala,
    :ELITE_Marshal,
    :LEADER_Brawly,
    :LEADER_Chuck,
    :LEADER_Maylene,
    :LEADER_Bea,
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
    when 8 # Team Bosses
      trainerlist = [
        ["BOSS_Rose","Rose",0],
        ["BOSS_Guzma","Guzma",0],
        ["BOSS_Lysandre","Lysandre",0],
        ["BOSS_Ghetsis","Ghetsis",0],
        ["BOSS_Cyrus","Cyrus",0],
        ["BOSS_Archie","Archie",0],
        ["BOSS_Maxie","Maxie",0],
        ["BOSS_Giovanni","Giovanni",0]
      ]
    when 9 # Kanto E4
      trainerlist = [
        ["ELITE_Lorelei","Lorelei",0],
        ["ELITE_Bruno","Bruno",0],
        ["ELITE_Agatha","Agatha",0],
        ["ELITE_Lance","Lance",0],
        ["CHAMPION_Blue","Blue",0]
      ]
    when 10 # Johto E4
      trainerlist = [
        ["ELITE_Will","Will",0],
        ["ELITE_Koga","Koga",0],
        ["ELITE_Bruno2","Bruno",0],
        ["ELITE_Karen","Karen",0],
        ["CHAMPION_Lance","Lance",0]
      ]
    when 11 # Sinnoh E4
      trainerlist = [
        ["ELITE_Sidney","Sidney",0],
        ["ELITE_Phoebe","Phoebe",0],
        ["ELITE_Glacia","Glacia",0],
        ["ELITE_Drake","Drake",0],
        ["CHAMPION_Steven","Steven",0]
      ]
    when 12 # Sinnoh E4
      trainerlist = [
        ["ELITE_Aaron","Aaron",0],
        ["ELITE_Bertha","Bertha",0],
        ["ELITE_Flint","Flint",0],
        ["ELITE_Lucian","Lucian",0],
        ["CHAMPION_Cynthia","Cynthia",0]
      ]
    when 13 # Unova E4
      trainerlist = [
        ["ELITE_Shauntal","Shauntal",0],
        ["ELITE_Marshal","Marshal",0],
        ["ELITE_Grimsley","Grimsley",0],
        ["ELITE_Caitlin","Caitlin",0],
        ["CHAMPION_Iris","Iris",0]
      ]
    when 14 # Kalos E4
      trainerlist = [
        ["ELITE_Malva","Malva",0],
        ["ELITE_Siebold","Siebold",0],
        ["ELITE_Wikstrom","Wikstrom",0],
        ["ELITE_Drasna","Drasna",0],
        ["CHAMPION_Diantha","Diantha",0]
      ]
    when 15 # Alola E4
      trainerlist = [
        ["ELITE_Hala","Hala",0],
        ["ELITE_Molayne","Molayne",0],
        ["ELITE_Olivia","Olivia",0],
        ["ELITE_Kahili","Kahili",0],
        ["CHAMPION_Kukui","Kukui",0]
      ]
    when 16 # Galar E4
      trainerlist = [
        ["ELITE_Klara","Klara",0],
        ["ELITE_Avery","Avery",0],
        ["ELITE_Mustard","Mustard",0],
        ["ELITE_Peony","Peony",0],
        ["CHAMPION_Leon","Leon",0]
      ]
  end
  case
    when group < 8
      until trainerSelection.length == 5 do
        num = rand(0...(trainerlist.length))
        trainer = trainerlist[num]
        if !trainerSelection.include?(trainer)
          if group == 2 && trainer[0] == ("LEADER_Tate")
            if !trainerSelection.include?(["LEADER_Liza","Liza",0])
              trainerSelection.push(trainer)
            else
              break
            end
          elsif group == 2 && trainer[0] == ("LEADER_Liza")
            if !trainerSelection.include?(["LEADER_Tate","Tate",0])
              trainerSelection.push(trainer)
            else
              break
            end
          elsif group == 4 && trainer[0] == ("LEADER_Cheren")
            if !trainerSelection.include?(["LEADER_Cheren","Cheren",0])
              trainerSelection.push(trainer)
            else
              break
            end
          elsif group == 4 && trainer[0] == ("LEADER_Lenora")
            if !trainerSelection.include?(["LEADER_Lenora","Lenora",0])
              trainerSelection.push(trainer)
            else
              break
            end
          elsif group == 4 && trainer[0] == ("LEADER_Cress")
            if !trainerSelection.include?(["LEADER_Cress","Cress",0])
              trainerSelection.push(trainer)
            else
              break
            end
          elsif group == 4 && trainer[0] == ("LEADER_Marlon")
            if !trainerSelection.include?(["LEADER_Marlon","Marlon",0])
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
  when 2, 11
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
    when "elite_sidney"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 3
    when "elite_glacia"
      $game_map.events[1].direction = 6
      $game_map.events[1].pattern = 4
    when "elite_drake"
      $game_map.events[1].direction = 8
      $game_map.events[1].pattern = 0
    when "champion_steven"
      $game_map.events[1].direction = 8
      $game_map.events[1].pattern = 3
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
        $game_map.events[1].pattern = 2
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
         $game_map.events[1].direction = 2
         $game_map.events[1].pattern = 1
       when "elite_bertha"
         $game_map.events[1].direction = 2
         $game_map.events[1].pattern = 2
       when "elite_flint"
         $game_map.events[1].direction = 2
         $game_map.events[1].pattern = 3
       when "elite_lucian"
         $game_map.events[1].direction = 4
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
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 3
      end
   when 14 # Kalos E4
      $game_map.events[1].character_name = "trainer_Sheet6"
      case opponent[0].downcase
      when "elite_malva"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 0
      when "elite_siebold"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 1
      when "elite_wikstrom"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 2
      when "elite_drasna"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 3
      when "champion_diantha"
         $game_map.events[1].character_name = "trainer_Sheet13"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 2
      end
   when 15 # Alola E4
      $game_map.events[1].character_name = "trainer_Sheet7"
      case opponent[0].downcase
      when "elite_hala"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 4
      when "elite_molayne"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 4
      when "elite_olivia"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 1
      when "elite_kahili"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 1
      when "champion_kukui"
         $game_map.events[1].character_name = "trainer_Sheet13"
        $game_map.events[1].direction = 4
        $game_map.events[1].pattern = 1
      end
   when 16 # Galar E4
      $game_map.events[1].character_name = "trainer_Sheet9"
      case opponent[0].downcase
      when "elite_klara"
        $game_map.events[1].direction = 2
        $game_map.events[1].pattern = 4
      when "elite_avery"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 1
      when "elite_mustard"
        $game_map.events[1].direction = 6
        $game_map.events[1].pattern = 2
      when "elite_peony"
        $game_map.events[1].direction = 8
        $game_map.events[1].pattern = 2
      when "champion_leon"
         $game_map.events[1].character_name = "trainer_Sheet13"
        $game_map.events[1].direction = 2
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
    ["LEADER_Wake","Crasher Wake",0],
    ["LEADER_Roxie","Roxie",0],
    ["LEADER_Olympia","Olympia",0],
    ["LEADER_Clemont","Clemont",0],
    ["LEADER_Wulfric","Wulfric",0]
  ]
  for trainer in testgroup
    for i in 0...$trbytype.size
      if $trbytype[i].include?(trainer[0].to_sym)
        $bg = $poketypes[i]
        break
      end
    end
  $game_variables[30] = trainer
  pbSummitAnnounceMainTrainer
  pbSummitMainTrainerSpeech
  end
end

def pbSummitAnnounceMainTrainer
  opp = GameData::TrainerType.get($game_variables[30][0]).name.clone << " " << $game_variables[30][1]
  messages = [
    ["Now, I've been looking forward to this matchup.","Challenger #{$player.name} and #{opp} in the same room, let alone battling for us!?"],
    ["Audience, strap in, this round is going to be incredible.","Challenger #{$player.name} vs #{opp}, starting in just a moment!"],
    ["#{opp} is looking ready for a intense fight!","Here comes Challenger #{$player.name} to give them what they want!"],
    ["Don't turn off your television sets, dear viewers at home.","Challenger #{$player.name} is about to face the legendary #{opp}!"],
    ["I can't believe my eyes, is #{opp} really in the building?","Sorry Challenger #{$player.name}, you are cool too."],
    ["Challenger #{$player.name} vs #{opp}?","This is going to get ugly..."],
    ["The energy in the arena grows evermore intense as Challenger #{$player.name} and #{opp} prepare their Pokémon."],
    ["What kind of battle can we expect from Challenger #{$player.name} and #{opp} today?"],
    ["The potential battle of the century quietly begins today between Challenger #{$player.name} and #{opp}."],
    ["Everyone please welcome Challenger #{$player.name} and #{opp}!","There's no doubt that this is an important battle for both trainers."],
    ["The once peaceful air is now turning thick with tension at the appearance of #{$player.name} and #{opp}."],
    ["We got a special one today, folks.","Challenger #{$player.name}, up against the incredible #{opp}!"]
  ]
  
  case $bg.to_s.downcase
    when "normal"
      typemessages = [
          ["Their Pokémon may be Normal, but #{opp} is nothing but extraordinary!","Challenger #{$player.name} really has a tough fight ahead!"],
          ["Don't turn off your TV sets folks, Normal-Types can surprise you!","You can count on #{opp} and Challenger #{$player.name} putting on a show! "],
          ["#{opp}, master of Normal-Type Pokémon, is here to fight!","They are tough, but Challenger #{$player.name} has a Fighting chance!"]
    ] 
    when "fighting"
      typemessages = [
          ["Straight from the dojo, #{opp} is here to show us the ropes!","Challenger #{$player.name} better bring their best!"],
          ["With Pokémon that can chop right through concrete, #{opp} enters the ring!","Will this force prove too strong for Challenger #{$player.name}?"],
          ["#{opp} has a whole team of intense Fighting-Type Pokémon","Challenger #{$player.name} would need to be a Psychic to break down this trainer!"]
    ]
    when "flying"
      typemessages = [
          ["Watch out above Challenger #{$player.name}!","#{opp} swoops into the arena!"],
          ["#{opp} takes to the skies to fight Challenger #{$player.name} with their Flying Pokémon!","The cameramen will need a break after this one!"],
          ["With all of their Flying-Type Pokémon, it'll be hard to catch #{opp} off guard!","Will Challenger #{$player.name} find a way to Rock their foundations?"]
    ]
    when "bug"
      typemessages = [
          ["Oh my... so many Bug Pokémon...","I'm sorry Challenger #{$player.name} and #{opp}, I just can't watch this one"],
          ["#{opp} has a whole team of creepy-crawly Bug Pokémon!","I don't know how Challenger #{$player.name} can be in the same room..."],
          ["I try not to be bias, but the Bug-Type Pokémon of #{opp} give me no choice.","Send 'em Flying, Challenger #{$player.name}"]
      ]
    when "ghost"
      typemessages = [
          ["Quiet whispers fill the room as the haunting battle between Challenger #{$player.name} and #{opp} begins!"],
          ["Challenger #{$player.name} has entered the arena, looking confident and ready to fight!","However, #{opp} has a whole lot of spirit!"],
          ["#{opp} is here to terrify with their horde of Ghost-Type Pokémon!","Times ahead certainly look Dark for Challenger #{$player.name}!"]
      ]
    when "steel"
      typemessages = [
          ["Shining of brilliant silver, #{opp} and their Steel-Type Pokémon are here to put pressure on Challenger #{$player.name} and their team!"],
          ["Challenger #{$player.name} vs #{opp} live on your screens in a moment.","This battle will be metal!"],
          ["With their sturdy Steel-Type Pokémon, #{opp} has come to shake things up.","Challenger #{$player.name} will have no choice but to hit the Ground running!"],
      ]
    when "fire"
      typemessages = [
          ["With a flaming fury, #{opp} bursts onto our screens!","Can Challenger #{$player.name} find a way to control the flames?"],
          ["Challenger #{$player.name} vs #{opp} will surely make sparks fly.","Things are really heating up around here!"],
          ["#{opp} makes training Fire-Type Pokémon look easy.","Challenger #{$player.name} is in troubled Water in this matchup!"],
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

  $DiscordRPC.details = "VS #{GameData::TrainerType.get($game_variables[30][0]).name} #{$game_variables[30][1]}"
  $DiscordRPC.large_image = $game_variables[30][0].downcase
  if $game_variables[35] == "challenge" || "bosses" || "gauntlet"
    $DiscordRPC.state = "#{$bracketnames[$game_variables[31]]} (#{$game_variables[33].to_int+1} of 4)"
  elsif $game_variables[35] == "arcade"
    $DiscordRPC.state = "Arcade (Win Streak: #{$game_variables[43].to_int})"
  end
  $DiscordRPC.update

  if $game_variables[35] == ("challenge" || "gauntlet")
    setBattleRule("backdrop", $bg.to_s)
    setBattleRule("base", $bg.to_s)
  elsif $game_variables[35] == "bosses"
    setBattleRule("backdrop", "dark")
    setBattleRule("base", "dark")
  end
  
  TrainerBattle.start(type, name, version)

  $Trainer.party = $game_variables[27]
  if $game_variables[35] == "challenge" || "bosses" || "gauntlet" # Main mode
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
    elsif $game_variables[35] == "gauntlet" && $game_variables[33] == 4
      $game_switches[42] = true # break
    end
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
  $game_variables[41] = $game_variables[31] # Change var to last completed bracket
  for trainer in $game_variables[29]
    for pkmn in $Trainer.party
      pkmn.giveRibbon(trainer[0].to_sym)
    end
    $game_variables[44].push(trainer) # Add trainers defeated to array
  end

  pbMessage(_INTL("\\rCongratulations on defeating the {1}!",bracketwon))
  pbSEPlay("Slots coin")
  $Trainer.money += 700
  pbMessage("\\G\\rYou have earned $700 for your performance.")
  pbMessage(_INTL("\\rYou have also successfully unlocked the {1}!",bracketunlocked))
  $game_variables[29] = [] # Clear previous bracket selection
  if $game_variables[31] == 4 # Sinnoh beat
    $game_switches[39] = true
    $game_switches[40] = true
  end
  if $game_variables[31] == 8 # Galar beat
    $game_switches[41] = true
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

def pbSummitArcadeTrainer
  pbNewSummitTrainer(@arcadetype, @arcadename)
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
      trainerpkmn = [:ALAKAZAM,:HYPNO,:ESPEON,:WOBBUFFET,:GRUMPIG,:CHIMECHO,:MUSHARNA,:GOTHITELLE,:REUNICLUS,:BEHEEYEM,:MEOWSTIC,:RAPIDASH,:XATU,:GARDEVOIR,:GALLADE,:SWOOBAT,:SIGILYPH,:ORORICORIO_PAU,:HATTERENE,:INDEEDEE,:RAICHU_ALOLA,:SLOWBRO,:SLOWBRO_GALAR,:EXEGGUTOR,:SLOWKING,:SLOWKING_GALAR,:MEDICHAM,:MRMIME,:MRRIME,:ORBEETLE,:MALAMAR,:DELPHOX,:BRONZONG,:METAGROSS,:CLAYDOL]
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
  pbBGMFade(1)
  pbBGMPlay("bosslobby")
  pbMessage("\\rThis is awful! Somebody needs to stop them!")
  pbMessage("\\rYou're a strong trainer... Please, you have to do something!")
  pbMessage("\\rTalk to me when you're prepared... I can take you to the floor they're on.")
end
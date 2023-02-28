def pbSummitShopUnlock
  if $game_variables[35] == "challenge" || $game_variables[35] == "gauntlet"
    @textcolor = "\\r"
  elsif $game_variables[35] == "arcade" || $game_variables[35] == "grunts"
    @textcolor = "\\b"
  else
    @textcolor = ""
  end
  unlocks = []
  checkswitches = [46,47,48,49]
  msgs = Hash.new
  msgs[49] = "You have proven yourself as a strong trainer! The Super Trainer can now help you strengthen your Pokémon further."
  msgs[48] = "The Pokémon Lover sees your potential and will let you use her services to enhance your Pokémon."
  msgs[47] = "Due to your multiple successes in battle, the Move Teacher is now open to share his knowledge with you."
  msgs[46] = "Since you have won a few battles, you have unlocked the Item Collector's shop."
  announce = []
  dispannounce = []
  recap = false

  if $game_variables[46] >= 15 # Super Training
    latest = [49]
  elsif $game_variables[46] >= 10 # Pokémon Lover
    latest = [48]
  elsif $game_variables[46] >= 7 # Move Teacher
    latest = [47]
  elsif $game_variables[46] >= 5 # Item Collector
    latest = [46]
  else
    return false
  end
  checkswitches = checkswitches-latest # remove highest/most recent unlock from list
  @newswitches = checkswitches.clone # make separate list of all shops
  for i in checkswitches # for each shop
    if i > latest[0] # if shop is later unlock than latest
      remove = []
      remove.push(i)
      @newswitches=@newswitches-remove # remove it from announcements
    end
  end
  for i in @newswitches # for all lower unlocks
    if latest[0] > @newswitches[0] && $game_switches[i] == false # if it hasnt been switched on yet
      recap = true
      announce.push(msgs[i]) # add the unlock message to the list of announcements
    end
  end
  num = latest[0]
  if $game_switches[num] == false
    announce.push(msgs[num]) # add the most recent unlock message
  else
    return false
  end
  if recap == true
    for msg in announce # for all announcements
      colorannounce = @textcolor.clone << msg
      dispannounce.push(colorannounce) # add color
    end
  else # no lower
    colorannounce = @textcolor.clone << msgs[num]
    dispannounce.push(colorannounce)
  end
  for msg in dispannounce
    pbMessage(msg)
  end
  for i in @newswitches
    $game_switches[i] = true # turn the switch on
  end
  $game_switches[num] = true
end

def pbSummitEVTrain(pkmn)
  loop do
    totalev = 0
    evcommands = []
    ev_id = []
    GameData::Stat.each_main do |s|
      evcommands.push(s.name + " (#{pkmn.ev[s.id]})")
      ev_id.push(s.id)
      totalev += @pkmn.ev[s.id]
    end
    cmd2 = pbMessage(_INTL("Change which EV?\nTotal: {1}/{2} ({3}%)",
                                       totalev, Pokemon::EV_LIMIT,
                                       100 * totalev / Pokemon::EV_LIMIT), evcommands, -1)
    if cmd2 != -1
      params = ChooseNumberParams.new
      upperLimit = 0
      GameData::Stat.each_main { |s| upperLimit += pkmn.ev[s.id] if s.id != ev_id[cmd2] }
      upperLimit = Pokemon::EV_LIMIT - upperLimit
      upperLimit = [upperLimit, Pokemon::EV_STAT_LIMIT].min
      thisValue = [pkmn.ev[ev_id[cmd2]], upperLimit].min
      params.setRange(0, upperLimit)
      params.setDefaultValue(thisValue)
      params.setCancelValue(thisValue)
      f = pbMessageChooseNumber(_INTL("Set the EV for {1} (max. {2}).",
                                      GameData::Stat.get(ev_id[cmd2]).name, upperLimit), params)
      if f != pkmn.ev[ev_id[cmd2]]
        pkmn.ev[ev_id[cmd2]] = f
        pkmn.calc_stats
      end
    elsif cmd2 == -1
      if totalev != Pokemon::EV_LIMIT
        cmd = pbConfirmMessage(_INTL("You have not allocated all possible EVs.\\1 Allocate remaining EVs?"))
        if cmd == false
          cmd = pbConfirmMessage(_INTL("Confirm Pokémon with unallocated EVs?"))
          if cmd == true
            return true
            break 
          end
        else
          return false
        end
      else
        cmd = pbConfirmMessage(_INTL("Confirm EV allocation?"))
        if cmd == true
          return true
          break
        end
      end
    end
  end
end

def pbSummitSuperTrain
  @evstats = ["HP","Attack","Defense","Special Attack","Special Defense","Speed"]
  @selection = @evstats.clone
  loop do
    pbMessage("\\bWhich Pokémon would you like to super train?")
    pkmn = pbChoosePokemon(1, 3)
    if $game_variables[1] < 0
      cmd = pbMessage("Cancel super training?",["Yes", "No"],1)
      if cmd <= 0
        return false
        break
      end
    else
      pbMessage("\\bWhich stats would you like this Pokémon to specialize in?")
      loop do
        cmd = pbMessage("\\bSelect a stat to specialize in.",@evstats,-1)
        if cmd == -1
          break
        else
          @stat1 = @evstats[cmd]
          @selection.delete_at(cmd)
        end
        loop do
          cmd = pbMessage("\\bSelect another stat to specialize in.",@selection,-1)
          if cmd >= 0
            cmd2 = @selection[cmd]
              for stat in @evstats
                if stat.equal?(cmd2)
                  @stat2 = stat
                end
              end
            @chosenstats = [@stat1, @stat2]
            pkmn = pbGetPokemon(1)
            loop do
              cmd = pbMessage(_INTL("\\bDo you want us to train your #{pbGetPokemon(1).species.downcase.capitalize} in {1} and {2}?",@chosenstats[0],@chosenstats[1]),["Yes","No"],-1)
              if cmd == -1
                break
              elsif cmd == 1
                cmd2 = pbMessage("Cancel super training?",["Yes", "No"],1)
                if cmd2 == 0
                  return false
                  break
                end
              else
                for i in $allstats
                  pkmn.ev[i] = 0
                end
                for statname in @chosenstats
                  statnameint = statname.clone
                  if statname.include?(" ")
                    statnameint.gsub!(/\s/, "_")
                  end
                  pkmn.ev[statnameint.upcase.to_sym] = 252
                end
                pbMessage(_INTL("\\G\\bYour #{pbGetPokemon(1).species.downcase.capitalize} now specializes in {1} and {2}.",@chosenstats[0],@chosenstats[1]))
                return true
                break
                break
                break
                break
                break
              end
            end
          else
            @selection = @evstats.clone
            break
          end
        end
      end
    end
  end
end

def pbSummitBetaChangeNature
  loop do
    pbMessage("\\rWhich Pokémon would you like to change the nature of?")
    pbChoosePokemon(1, 3)
    if $game_variables[1] < 0
      cmd = pbMessage("Cancel nature change?",["Yes", "No"],1)
      if cmd <= 0
        return false
        break
      end
    else
      pkmn = pbGetPokemon(1)
      commands = []
      ids = []
      GameData::Nature.each do |nature|
        if nature.stat_changes.length == 0
          commands.push(_INTL("{1} (---)", nature.real_name))
        else
          plus_text = ""
          minus_text = ""
          nature.stat_changes.each do |change|
            if change[1] > 0
              plus_text += "/" if !plus_text.empty?
              plus_text += GameData::Stat.get(change[0]).name_brief
            elsif change[1] < 0
              minus_text += "/" if !minus_text.empty?
              minus_text += GameData::Stat.get(change[0]).name_brief
            end
          end
          commands.push(_INTL("{1} (+{2}, -{3})", nature.real_name, plus_text, minus_text))
        end
        ids.push(nature.id)
      end
      cmd = pbMessage("Set Pokémon's nature.", commands)
      if cmd >= 0
        pkmn.nature = ids[cmd]
        return true
        break
      end
    end
  end
end

def pbSummitChangeNature
  loop do
    pbMessage("\\rWhich Pokémon would you like to change the nature of?")
    pkmn = pbChoosePokemon(1, 3)
    if $game_variables[1] < 0
      cmd = pbMessage("Cancel nature change?",["Yes", "No"],1)
      if cmd <= 0
        return false
        break
      end
    else
      stats = []
      for stat in $allstats
        if stat != :HP
          statname = stat.clone
          statname = statname.to_s.downcase
          statname.gsub!(/_/, " ")
          statname.gsub!(/(\w+)/) {|word| word.capitalize}
          stats.push(statname)
        end
      end
      stats << "None"
      loop do
        cmd = pbMessage(_INTL("\\rWhich stat should this nature raise?"),stats,-1)
        naturelist = []
        if cmd == -1
          break
        elsif cmd == 6 # None
          for i in GameData::Nature::DATA.keys
            naturename = i.to_s.downcase
            if GameData::Nature.try_get(i).stat_changes.empty?
              naturelist.push(naturename.capitalize)
            end
          end
        else
          for i in GameData::Nature::DATA.keys
            naturename = i.to_s.downcase
            if !GameData::Nature.try_get(i).stat_changes.empty?
              statraise = GameData::Nature.get(i).stat_changes[0][0]
              if statraise == $allstats[cmd+1]
                name = naturename.capitalize
                info = name.clone
                info << " (-"
                statdrop = GameData::Nature.get(i).stat_changes[1][0].clone
                statdrop = statdrop.to_s.downcase
                statdrop.gsub!(/_/, " ")
                statdrop.gsub!(/special/, "sp.")
                statdrop.gsub!(/attack/, "atk")
                statdrop.gsub!(/defense/, "def")
                statdrop.gsub!(/(\w+)/) {|word| word.capitalize}
                info << statdrop << ")"
                naturelist.push(info)
              end
            end
          end
        end
        loop do
          cmd = pbMessage(_INTL("\\rWhat nature would you like to give your #{pbGetPokemon(1).species.downcase.capitalize}?"),naturelist,-1)
          if cmd >= 0
            @chosennature = naturelist[cmd].split[0]
            pkmn = pbGetPokemon(1)
            loop do
              cmd = pbMessage(_INTL("\\rDo you want us to give your #{pbGetPokemon(1).species.downcase.capitalize} a {1} nature?",@chosennature),["Yes","No"],-1)
              if cmd == -1
                break
              elsif cmd == 1
                cmd2 = pbMessage("Cancel nature change?",["Yes", "No"],1)
                if cmd2 == 0
                  return false
                  break
                end
              else
                for i in GameData::Nature::DATA.keys
                  if @chosennature == GameData::Nature.get(i).real_name
                    pkmn.nature = GameData::Nature.get(i)
                    pbMessage(_INTL("\\G\\rYour #{pbGetPokemon(1).species.downcase.capitalize}'s nature is now {1}.",@chosennature.to_s))
                    return true
                    break
                    break
                    break
                    break
                    break
                  end
                end
              end
            end
          else
            break
          end
        end
      end
    end
  end
end

def pbSummitBetaChangeAbility
  loop do
    pbMessage("\\rWhich Pokémon would you like to change the ability of?")
    pkmn = pbChoosePokemon(1, 3)
    if $game_variables[1] < 0
      cmd = pbMessage("\\rCancel ability change?",["Yes", "No"],1)
      if cmd <= 0
        return false
        break
      end
    else
      loop do
        pkmn = pbGetPokemon(1)
        abils = pkmn.getAbilityList
        ability_commands = []
        abil_cmd = 0
        abils.each do |i|
          ability_commands.push(((i[1] < 2) ? "" : "(H) ") + GameData::Ability.get(i[0]).name)
          abil_cmd = ability_commands.length - 1 if pkmn.ability_id == i[0]
        end
        abil_cmd = pbMessage(_INTL("\\rChoose an ability."), ability_commands, abil_cmd)
        next if abil_cmd < 0
        pkmn.ability_index = abils[abil_cmd][1]
        pkmn.ability = nil
        return true
      end
    end
  end
end

def pbSummitChangeAbility
  loop do
    pbMessage("\\rWhich Pokémon would you like to change the ability of?")
    pkmn = pbChoosePokemon(1, 3)
    if $game_variables[1] < 0
      cmd = pbMessage("Cancel ability change?",["Yes", "No"],1)
      if cmd <= 0
        return false
        break
      end
    else
      loop do
        pkmn = pbGetPokemon(1)
        abilitylist = []
        abilities = []
        for ability in pkmn.species_data.abilities
          i = ability.to_s
          abilityname = GameData::Ability.get(i).real_name
          abilities.push(abilityname)
          listing = abilityname.clone
          price = 2000
          listprice = price.to_s.clone
          listprice.insert(1, ",")
          listing << " - $" << listprice
          abilitylist.push(listing)
        end
        for ability in pkmn.species_data.hidden_abilities
          i = ability.to_s
          abilityname = GameData::Ability.get(i).real_name
          abilities.push(abilityname)
          listing = abilityname.clone
          price = 3000
          listprice = price.to_s.clone
          listprice.insert(1, ",")
          listing << " - $" << listprice
          abilitylist.push(listing)
        end
        cmd = pbMessage("\\G\\rWhich ability would you like this Pokémon to have?",abilitylist,-1)
        if cmd == -1
          break
        else
          @chosenability = abilities[cmd]
          if pkmn.species_data.abilities.include?(@chosenability.upcase.to_sym)
            price = 2000
          else
            price = 3000
          end
          listprice = price.to_s.clone
          listprice.insert(1, ",")
          if $Trainer.money < price
            pbMessage("\\rSorry, you don't have enough money.")
            return false
            break
          end
          loop do
            cmd = pbMessage(_INTL("\\rChange your #{pbGetPokemon(1).species.downcase.capitalize}'s ability to in {1}? It'll cost \\G$#{listprice}.",@chosenability),["Yes","No"],-1)
            if cmd == -1
              break
            elsif cmd == 1
              cmd2 = pbMessage("Cancel ability change?",["Yes", "No"],1)
              if cmd2 == 0
                return false
                break
              end
            else
              for i in GameData::Ability::DATA.keys
                if @chosenability == GameData::Ability.get(i).real_name
                  pkmn.ability = GameData::Ability.get(i)
                  break
                end
              end
              pbMessage(_INTL("\\G\\rYour #{pbGetPokemon(1).species.downcase.capitalize}'s ability is now {1}.",@chosenability))
              $Trainer.money -= price
              return true
              break
            end
          end
          break
        end
      end
    end
  end
end

def pbSummitInitShopItems
  typeitems = [:BLACKBELT, :BLACKGLASSES, :CHARCOAL, :DRAGONFANG, :HARDSTONE, :MAGNET, :METALCOAT, :MIRACLESEED, :MYSTICWATER, :NEVERMELTICE, :PIXIEDUST, :POISONBARB, :SHARPBEAK, :SILKSCARF, :SILVERPOWDER, :SOFTSAND, :SPELLTAG, :TWISTEDSPOON]
    $game_variables[38] = typeitems
  utilitems = [:ABILITYSHIELD, :AIRBALLOON, :ASSAULTVEST, :BIGROOT, :BINDINGBAND, :BLUNDERPOLICY, :BRIGHTPOWDER, :CHOICEBAND, :CHOICESCARF, :CHOICESPECS, :CLEARAMULET, :COVERTCLOAK, :CRASHGEAR, :DAMPROCK, :DESTINYKNOT, :EJECTBUTTON, :EJECTPACK, :EXPERTBELT, :EXTENDEDBOOKING, :FLAMEORB, :FLOATSTONE, :FOCUSBAND, :FOCUSSASH, :GRIPCLAW, :HEARTSCALE, :HEATROCK, :HEAVYDUTYBOOTS, :HOMINGBLASTER, :ICYROCK, :IRONBALL, :IRONDENTURE, :KARATEBAND, :KINGSROCK, :KNIFESHARPENER, :LAGGINGTAIL, :LEEK, :LEFTOVERS, :LIFEORB, :LIGHTCLAY, :LOADEDDICE, :LUCKINCENSE, :MAGNIFYINGGLASS, :MENTALHERB, :METRONOME, :MIRRORHERB, :MUSCLEBAND, :POWERHERB, :PROTECTIVEPADS, :PUNCHINGGLOVE, :QUICKCLAW, :RAZORCLAW, :RAZORFANG, :REDCARD, :RINGTARGET, :ROCKYHELMET, :ROOMSERVICE, :SAFETYGOGGLES, :SCOPELENS, :SHEDSHELL, :SMOKEBALL, :SMOOTHROCK, :STICKYBARB, :SUPPRESSORVEST, :TERRAINEXTENDER, :THICKCLUB, :THROATSPRAY, :TOXICORB, :UTILITYUMBRELLA, :WEAKNESSPOLICY, :WHITEHERB, :WIDELENS, :WINDTURBINE, :WISEGLASSES, :ZOOMLENS]
    $game_variables[39] = utilitems
  berries = [:CHERIBERRY, :CHESTOBERRY, :PECHABERRY, 
    :RAWSTBERRY, :ASPEARBERRY, :PERSIMBERRY, 
    :SITRUSBERRY, :OCCABERRY, :PASSHOBERRY, 
    :WACANBERRY, :RINDOBERRY, :YACHEBERRY, :CHOPLEBERRY, 
    :KEBIABERRY, :SHUCABERRY, :COBABERRY, :PAYAPABERRY, 
    :TANGABERRY, :CHARTIBERRY, :KASIBBERRY, :HABANBERRY, 
    :COLBURBERRY, :BABIRIBERRY, :CHILANBERRY, :ROSELIBERRY]
    $game_variables[40] = berries
end

def pbSummitGetShopItems(section)
  items = []
  case section
    when "plates"
      items = $game_variables[38]
    when "utility"
      items = $game_variables[39]
    when "berries"
      items = $game_variables[40]
  end
  return items
end

def pbBuyScreen
  @scene.pbStartBuyScene(@stock,@adapter)
  item=nil
  loop do
    item=@scene.pbChooseBuyItem
    break if !item
    quantity=0
    itemname=@adapter.getDisplayName(item)
    price=@adapter.getPrice(item)
    if @adapter.getMoney<price
      pbDisplayPaused(_INTL("You don't have enough money."))
      next
    end
    if !pbConfirm(_INTL("Certainly. You want {1}. That will be ${2}. OK?",
       itemname,price.to_s_formatted))
      next
    end
    quantity=1
    if @adapter.getMoney<price
      pbDisplayPaused(_INTL("You don't have enough money."))
      next
    end
    added=0
    quantity.times do
      break if !@adapter.addItem(item)
      added+=1
    end
    if added!=quantity
      added.times do
        if !@adapter.removeItem(item)
          raise _INTL("Failed to delete stored items")
        end
      end
      pbDisplayPaused(_INTL("You have no more room in the Bag."))
    else
      @adapter.setMoney(@adapter.getMoney-price)
      for i in 0...@stock.length
          @stock[i]=nil
      end
      @stock.compact!
      pbDisplayPaused(_INTL("Here you are! Thank you!")) { pbSEPlay("Mart buy item") }
    end
  end
  @scene.pbEndBuyScene
end
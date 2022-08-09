def pbSummitShopUnlock
  # if $game_variables[35] == "challenge" || $game_variables[35] == "gauntlet"
  #   @textcolor = "\\r"
  # elsif $game_variables[35] == "arcade" || $game_variables[35] == "grunts"
  #   @textcolor = "\\b"
  # end
  # if $game_variables[46] >= 15 # Super Training
  #   $game_switches[49] = true
  #   msg = @textcolor.clone << "You have proven yourself as a strong trainer! The Super Trainer can now help you strengthen your Pokémon further."
  #   unlocks.push(msg)
  # elsif $game_variables[46] >= 10 # Pokémon Lover
  #   $game_switches[48] = true
  #   msg = @textcolor.clone << "The Pokémon Lover sees your potential and will let you use her services to enhance your Pokémon."
  #   unlocks.push(msg)
  # elsif $game_variables[46] >= 7 # Move Teacher
  #   $game_switches[47] = true
  #   msg = @textcolor.clone << "Due to your multiple successes in battle, the Move Teacher is now open to share his knowledge with you."
  #   unlocks.push(msg)
  # elsif $game_variables[46] >= 5 # Item Collector
  #   $game_switches[46] = true
  #   msg = @textcolor.clone << "Since you have won a few battles, you have unlocked the Item Collector's shop."
  #   unlocks.push("item")
  # else
  #   return false
  # end

  

  # $game_variables[48].times do
  #   unlocks.push(msg)

  # case $game_variables[48]
  # for msg in unlocks
  #   pbMessage(msg)
  #   return true
  # end
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
  utilitems = [:AIRBALLOON, :ASSAULTVEST, :BIGROOT, :BINDINGBAND, :BLUNDERPOLICY, :BRIGHTPOWDER, :CHOICEBAND, 
    :CHOICESCARF, :CHOICESPECS, :DAMPROCK, :DESTINYKNOT, :EJECTBUTTON, :EJECTPACK, :EXPERTBELT, :FLAMEORB, 
    :FLOATSTONE, :FOCUSBAND, :FOCUSSASH, :GRIPCLAW, :HEATROCK, :HEAVYDUTYBOOTS, :ICYROCK, :IRONBALL, 
    :KINGSROCK, :LAGGINGTAIL, :LEEK, :LEFTOVERS, :LIFEORB, :LIGHTCLAY, :LUCKINCENSE, :MENTALHERB, :METRONOME, 
    :MUSCLEBAND, :POWERHERB, :PROTECTIVEPADS, :QUICKCLAW, :RAZORCLAW, :RAZORFANG, :REDCARD, :RINGTARGET, 
    :ROCKYHELMET, :ROOMSERVICE, :SAFETYGOGGLES, :SCOPELENS, :SHEDSHELL, :SMOKEBALL, :SMOOTHROCK, :STICKYBARB,
    :TERRAINEXTENDER, :THICKCLUB, :THROATSPRAY, :TOXICORB, :UTILITYUMBRELLA, :WEAKNESSPOLICY, :WHITEHERB, :WIDELENS, :WISEGLASSES, :ZOOMLENS]
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
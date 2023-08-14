#===============================================================================
# Debug.
#===============================================================================
# Rewrites Ribbon debug code to include the ability to set titles.
#-------------------------------------------------------------------------------
MenuHandlers.add(:pokemon_debug_menu, :mementos_menu, {
  "name"   => _INTL("Mementos..."),
  "parent" => :cosmetic
})

MenuHandlers.add(:pokemon_debug_menu, :set_ribbons, {
  "name"   => _INTL("Set Ribbons/Marks"),
  "parent" => :mementos_menu,
  "effect" => proc { |pkmn, pkmnid, heldpoke, settingUpBattle, screen|
    cmd = 0
    loop do
      cmds = []
      ids = []
      GameData::Ribbon.each do |memento_data|
        cmds.push(_INTL("{1} {2}", (pkmn.hasMemento?(memento_data.id)) ? "[Y]" : "[  ]", memento_data.name))
        ids.push(memento_data.id)
      end
      cmds.push(_INTL("Give all"))
      cmds.push(_INTL("Clear all"))
      cmd = screen.pbShowCommands(_INTL("Mementos:\n{1}", pkmn.numMementos), cmds, cmd)
      break if cmd < 0
      if cmd >= 0 && cmd < ids.length
        (pkmn.hasMemento?(ids[cmd])) ? pkmn.takeMemento(ids[cmd]) : pkmn.giveMemento(ids[cmd])
      elsif cmd == cmds.length - 2
        GameData::Ribbon.each { |memento_data| pkmn.giveMemento(memento_data.id) }
      elsif cmd == cmds.length - 1
        pkmn.clearAllMementos
      end
    end
    next false
  }
})

MenuHandlers.add(:pokemon_debug_menu, :set_memento, {
  "name"   => _INTL("Set Memento/Title"),
  "parent" => :mementos_menu,
  "effect" => proc { |pkmn, pkmnid, heldpoke, settingUpBattle, screen|
    cmds = []
    ids = []
    pkmn.ribbons.each do |memento|
      memento_data = GameData::Ribbon.get(memento)
      next if !memento_data.title
      cmds.push(_INTL("{1}", memento_data.name))
      ids.push(memento_data.id)
    end
    if ids.empty?
      screen.pbDisplay(_INTL("{1} doesn't have any mementos that may grant it a title.", pkmn.name))
    else
      cmd = 0
      cmds.push(_INTL("[Random]"))
      cmds.push(_INTL("[Remove]"))
      loop do
        memento = (pkmn.memento) ? GameData::Ribbon.get(pkmn.memento).name : "None"
        cmd = screen.pbShowCommands(_INTL("Memento:\n{1}.", memento), cmds, cmd)
        break if cmd < 0
        if cmd >= 0 && cmd < ids.length
          if pkmn.memento == ids[cmd]
            screen.pbDisplay(_INTL("{1} already has the title granted by that memento.", pkmn.name))
          else
            pkmn.memento = ids[cmd]
          end
        elsif cmd == cmds.length - 2
          pkmn.memento = ids.sample
        elsif cmd == cmds.length - 1
          pkmn.memento = nil
          screen.pbDisplay(_INTL("Cleared {1}'s memento and title.", pkmn.name))
        end
        if pkmn.memento
          memento = GameData::Ribbon.get(pkmn.memento)
          screen.pbDisplay(_INTL("{1} will now be known as\n{2}.", pkmn.name, pkmn.name_title))
        end
        screen.pbRefreshSingle(pkmnid)
      end
    end
    next false
  }
})
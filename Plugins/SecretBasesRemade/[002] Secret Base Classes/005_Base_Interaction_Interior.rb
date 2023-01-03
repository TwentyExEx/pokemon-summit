module SecretBaseMethods
  def self.registered_bases_count
    return $PokemonGlobal.secret_base_list.count {|base| base.registry_status == SecretBase::REGISTERED }
  end
  def self.get_registration_validity(base_id)
    if get_base_from_id(base_id).registry_status == SecretBase::REGISTERED
      return 1
    elsif registered_bases_count>=SecretBaseSettings::SECRET_BASE_MAX_REGISTERED_BASES
      return 2
    end
    return 0
  end
  def self.check_base_battle_teams(player_party, owner_party, battle_rule)
    case battle_rule
    when "triple"
      size=[3,3]
    when "double"
      size=[2,2]
    else
      size=[1,1]
    end
    if player_party.length<size[0]
      return 1
    elsif owner_party.length<size[1]
      return 2
    end
    return 0
  end
end

def pbSecretBasePC
  pbSEPlay("PC open")
  this_event = pbMapInterpreter.get_self
  this_event.turn_down
  pbWait(4)
  this_event.turn_left
  pbWait(4)
  this_event.turn_down
  pbWait(4)
  this_event.turn_left
  pbWait(4)
  this_event.turn_down
  pbWait(4)
  this_event.turn_left
  if SecretBaseMethods.is_player_base?($PokemonMap.current_base_id)
    pbSecretBasePCMenu
  else
    pbSecretBasePCRegisterMenu
  end
  if $PokemonMap.current_base_id
    pbSEPlay("PC close")
    # Has to be done this way when if you decorated.
    $game_map.events[2].turn_down
  end
end

def pbSecretBasePCMenu
  pbMessage(_INTL("{1} booted up the PC.", $player.name))
  # Get all commands
  command_list = []
  commands = []
  MenuHandlers.each_available(:secret_base_pc_menu) do |option, hash, name|
    command_list.push(name)
    commands.push(hash)
  end
  # Main loop
  command = 0
  loop do
    choice = pbMessage(_INTL("What do you want to do?"), command_list, -1, nil, command)
    if choice < 0
      pbPlayCloseMenuSE
      break
    end
    break if commands[choice]["effect"].call
  end
end

MenuHandlers.add(:secret_base_pc_menu, :decoration, {
  "name"      => _INTL("Decoration"),
  "order"     => 10,
  "effect"    => proc { |menu|
    pbDecorationMenu
    next false
  }
})

MenuHandlers.add(:secret_base_pc_menu, :pack_up, {
  "name"      => _INTL("Pack Up"),
  "order"     => 20,
  "effect"    => proc { |menu|
    player_base = $PokemonGlobal.secret_base_list[0]
    base_data = GameData::SecretBase.get(player_base.id)
    pbMessage(_INTL("All decorations and furniture in your Secret Base will be returned to your PC.\\1"))
    if pbConfirmMessage(_INTL("Is that okay?"))
      # Pack up the base.
      pbFadeOutIn(99999) {
        player_base.remove_decorations((0...SecretBaseSettings::SECRET_BASE_MAX_DECORATIONS).to_a)
        $secret_bag.unplace_all
        player_base.id = nil
        $stats.moved_secret_base_count+=1
        $game_temp.player_transferring   = true
        $game_temp.transition_processing = true
        $game_temp.player_new_map_id    = base_data.location[0]
        $game_temp.player_new_x         = base_data.location[1]
        $game_temp.player_new_y         = base_data.location[2]+1
        $game_temp.player_new_direction = 2
        $scene.transfer_player
      }
      next true
    end
    next false
  }
})

MenuHandlers.add(:secret_base_pc_menu, :registry, {
  "name"      => _INTL("Registry"),
  "condition" => proc { next $PokemonGlobal.secret_base_registry },
  "order"     => 30,
  "effect"    => proc { |menu|
    pbRegistry
    next false
  }
})

MenuHandlers.add(:secret_base_pc_menu, :exit, {
  "name"      => _INTL("Exit"),
  "order"     => 50,
  "effect"    => proc { |menu| next true }
})

def pbSecretBasePCRegisterMenu
  pbMessage(_INTL("{1} booted up the PC.", $player.name))
  # Get all commands
  command_list = []
  commands = []
  MenuHandlers.each_available(:secret_base_pc_register_menu) do |option, hash, name|
    command_list.push(name)
    commands.push(hash)
  end
  # Main loop
  command = 0
  loop do
    choice = pbMessage(_INTL("What do you want to do?"), command_list, -1, nil, command)
    if choice < 0
      pbPlayCloseMenuSE
      break
    end
    break if commands[choice]["effect"].call
  end
end

MenuHandlers.add(:secret_base_pc_register_menu, :register, {
  "name"      => _INTL("Register"),
  "order"     => 10,
  "effect"    => proc { |menu|
    base = SecretBaseMethods.get_base_from_id($PokemonMap.current_base_id)
    validity = SecretBaseMethods.get_registration_validity(base.id)
    case validity
    when 2
      pbMessage(_INTL("Up to 10 locations can be registered."))
      pbMessage(_INTL("Delete a location if you want to\nregister another location."))
      next false
    when 1
      msg = _INTL("This data is already registered.\nWould you like to delete it?")
    when 0
      msg = _INTL("Do you want to register\n{1}'s Secret Base?",base.owner.name)
    end
    if pbConfirmMessage(msg)
      base.registry_status^=1
      $PokemonGlobal.secret_base_registry = true
      if validity == 1
        pbMessage(_INTL("Data has been unregistered."))
      else
        pbMessage(_INTL("Registration completed."))
      end
    end
    next false
  }
})

MenuHandlers.add(:secret_base_pc_register_menu, :registry, {
  "name"      => _INTL("Registry"),
  "order"     => 20,
  "effect"    => proc { |menu|
    pbRegistry
    next false
  }
})

MenuHandlers.add(:secret_base_pc_register_menu, :information, {
  "name"      => _INTL("Information"),
  "order"     => 30,
  "effect"    => proc { |menu|
    pbMessage(_INTL("Once registered, a Secret Base will not\ndisappear unless the other Trainer\\nmoves it to a different location.\\1"))
    pbMessage(_INTL("If a Secret Base is deleted from the\nregistered list, another one may take its place.\\1"))
    pbMessage(_INTL("Up to ten Secret Base locations\nmay be registered."))
    next false
  }
})

MenuHandlers.add(:secret_base_pc_register_menu, :exit, {
  "name"      => _INTL("Exit"),
  "order"     => 40,
  "effect"    => proc { |menu| next true }
})

def pbRegistry
  cmd = 0
  commands = []
  base_indices = []
  $PokemonGlobal.secret_base_list.each_with_index do |base, i|
    next if base.registry_status == SecretBase::UNREGISTERED
    commands.push(_INTL("{1}'s Base", base.owner.name))
    base_indices.push(i)
  end
  if base_indices.length==0
    pbMessage(_INTL("There is no Registry."))
    return
  end
  commands.push(_INTL("Cancel"))
  loop do
    cmd = pbShowCommands(nil,commands,-1,cmd)
    if cmd >= 0 && cmd < base_indices.length
      base_index = base_indices[cmd]
      base = $PokemonGlobal.secret_base_list[base_index]
      commandBase = pbMessage(
        _INTL("What do you want to do with {1}'s Base?", base.owner.name),
        [_INTL("Check Location"),
         _INTL("Unregister"),
         _INTL("Cancel")], -1
      )
      case commandBase
      when 0   # Check Location
        map_name = pbGetMapNameFromId(GameData::SecretBase.get(base.id).location[0])
        pbMessage(_INTL("{1}'s Base is near {2}.",base.owner.name, map_name))
      when 1   # Unregister
        if pbConfirmMessage(_INTL("Is it okay to delete {1}\nfrom the Registry?",base.owner.name))
          base.registry_status = SecretBase::UNREGISTERED
          cmd = 0
          commands = []
          base_indices = []
          $PokemonGlobal.secret_base_list.each_with_index do |base, i|
            next if base.registry_status == SecretBase::UNREGISTERED
            commands.push(_INTL("{1}'s Base", base.owner.name))
            base_indices.push(i)
          end
          commands.push(_INTL("Cancel"))
        end
      end
    else
      break
    end
  end
end

def pbSecretBaseOwner
  return if SecretBaseMethods.is_player_base?($PokemonMap.current_base_id)
  base = SecretBaseMethods.get_base_from_id($PokemonMap.current_base_id)
  base_owner = base.owner
  case base_owner.language
  when 3 # French
    msg = _INTL("Bonjour! I’m {1}!",base_owner.name)
  when 4 # Italian
    msg = _INTL("Ciao! I’m {1}!",base_owner.name)
  when 5 # German
    msg = _INTL("Hallo! I’m {1}!",base_owner.name)
  when 7 # Spanish
    msg = _INTL("¡Hola! I’m {1}!",base_owner.name)
  else # Default to English. Japanese (1) or Korean (8) is not in the font
    msg = _INTL("Hello! I’m {1}!",base_owner.name)
  end
  pbMessage(msg)
  commands = [_INTL("Let's battle!"),
              _INTL("Show me a special skill!"),
              _INTL("I want to move here!"),
              _INTL("Nothing really.")]
  moved_out = false
  loop do
    if base.daily_refresh?
      base.daily_timer = Time.now.to_i
      base.battle_status = :ready
      base.skills_count = 0
    end
    cmd = pbMessage(_INTL("{1}: Do you need something?",base_owner.name),commands,commands.length)
    case cmd
    when 0 # Battle
      case base.battle_status
      when :new_base
        pbMessage(_INTL("{1}: Hmm...\\1\nI don’t know what it is, but I don’t\nreally feel like battling today.\\1",base_owner.name))
        pbMessage(_INTL("Can we do it some other time?"))
      when :battled_today
        pbMessage(_INTL("{1}: We had a good battle today.\nCome back tomorrow!",base_owner.name))
      else
        single_battle_override = false
        case SecretBaseMethods.check_base_battle_teams($player.able_party,base.party,base.battle_rule)
        when 1 # Player doesn't have enough
          pbMessage(_INTL("{1}: No, no, this is no good!\nYou don’t have enough Pokémon to battle!",base_owner.name))
          next
        when 2 # Trainer doesn't have enough for their own base
          single_battle_override = true
        end
        # if we get this far then we can do the battle.
        if single_battle_override
          pbMessage(_INTL("{1}: The Pokémon battles here are supposed\nto be {2} battles.\\1But I don’t have enough Pokémon on my team right now.\\1"))
          msg = _INTL("{1}: What would you say to a Single Battle?",base_owner.name)
        else
          msg = _INTL("{1}: In my Secret Base, we do {2} battles! Are you ready for this?",base_owner.name,base.battle_rule)
        end
        if pbConfirmMessage(msg)
          base.battle_status = :battled_today
          rule = single_battle_override ? "single" : base.battle_rule
          setBattleRule(rule)
          setBattleRule("canLose")
          old_money_loss = $game_switches[Settings::NO_MONEY_LOSS]
          $game_switches[Settings::NO_MONEY_LOSS] = true
          foe = NPCTrainer.new(base_owner.name, base_owner.trainer_type)
          foe.id = base_owner.id
          foe.lose_text = _INTL("I hate to admit it, but you’re pretty strong!")
          foe.party = base.party
          foe.heal_party # Just in case
          TrainerBattle.start(foe)
          $game_switches[Settings::NO_MONEY_LOSS] = old_money_loss
          pbMessage(_INTL("{1}: Good battle!\nCome play again sometime!",base_owner.name))
        end
      end
    when 1 # Skill
      skill_cap = ($PokemonGlobal.secret_base_rank>=4) ? 2 : 1
      skills = SecretBaseSettings::SECRET_SKILLS_TRAINER_TYPE[base_owner.trainer_type]
      if !skills || skills.length==0
        pbMessage(_INTL("{1}: Oh, I don't know any special skills...",base_owner.name))
      elsif base.skills_count>=skill_cap
        pbMessage(_INTL("{1}: I want to practice a bit more,\nso come back again tomorrow!",base_owner.name))
      else
        skill_commands = []
        skills.each_with_index do |s,i|
          break if i>$PokemonGlobal.secret_base_rank
          skill_commands.push(GameData::SecretBaseSkill.get(s).name)
        end
        skill_commands.push(_INTL("Never mind"))
        skill_cmd = pbMessage(_INTL("{1}: What do you want to see me do?",base_owner.name),skill_commands,-1)
        if skill_cmd >= 0 && skill_cmd < skill_commands.length-1
          ret = GameData::SecretBaseSkill.get(skills[skill_cmd]).call_usage(base_owner)
          base.skills_count+=1 if ret
        end
      end
    when 2 # Remove Base
      if pbConfirmMessage(_INTL("{1}: Oh, don’t tell me...\nYou like this place, don’t you?", base_owner.name))
        # Extra confirmation for registered bases
        if base.registry_status==SecretBase::REGISTERED
          if !pbConfirmMessageSerious(_INTL("{1}: Are you really sure you want me to move out?", base_owner.name))
            next
          end
        end
        moved_out = true
        pbMessage(_INTL("{1}: Hmm... Well... OK!\nI guess I’ll go and try to find a new spot!\\1",base_owner.name))
        new_base_id = SecretBaseMethods.get_all_inactive_base_ids.sample
        if new_base_id
          map_name = pbGetMapNameFromId(GameData::SecretBase.get(new_base_id).location[0])
          pbMessage(_INTL("{1}: I once found a good spot around {2}, but someone else had taken it.\\1",base_owner.name,map_name))
          pbMessage(_INTL("{1}: I gave up on it at the time, but maybe it’s open now...",base_owner.name))   
        else
          excluded_ids = [$PokemonGlobal.secret_base_list[0].id,base.id]
          new_active_base = SecretBaseMethods.get_all_active_bases(excluded_ids).sample
          if new_active_base
            map_name = pbGetMapNameFromId(GameData::SecretBase.get(new_active_base.id).location[0])
            pbMessage(_INTL("{1}: I once found a good spot around {2}...\nbut {3} had gotten to it first!",base_owner.name,map_name,new_active_base.owner.name))
          end
          # Just don't do a follow up comment if for some reason, we straight up don't find a free base or an active one for this trainer to comment on.
        end
        break
      end
    else
      break
    end
  end
  if moved_out
    pbFadeOutIn(99999) {
      base_index = SecretBaseMethods.get_base_index_from_id(base.id)
      location = GameData::SecretBase.get(base.id).location
      $PokemonGlobal.secret_base_list[base_index] = nil
      $PokemonGlobal.secret_base_list.compact!
      $game_temp.player_transferring   = true
      $game_temp.transition_processing = true
      $game_temp.player_new_map_id    = location[0]
      $game_temp.player_new_x         = location[1]
      $game_temp.player_new_y         = location[2]+1
      $game_temp.player_new_direction = 2
      $scene.transfer_player
    }
  end
end
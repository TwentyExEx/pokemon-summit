def pbChangeOnlineTrainerType
  old_trainer_type = $player.online_trainer_type
  if $player.online_trainer_type==$player.trainer_type
    pbMessage(_INTL("\\bYou look like a strong trainer!"))
    pbMessage(_INTL("\\bTell me..."))
  else
    trainername=GameData::TrainerType.get($player.online_trainer_type).name
    if ['a','e','i','o','u'].include?(trainername[0,1].downcase)
      msg=_INTL("\\bYou seem like an {1}!\\1",trainername)
    else
      msg=_INTL("\\bYou seem like a {1}!\\1",trainername)
    end
    pbMessage(msg)
    pbMessage(_INTL("\\bBut I think you could also be a different kind of trainer.\\1"))
    pbMessage(_INTL("\\bTell me..."))
  end
  commands=[]
  trainer_types=[]
  CableClub::ONLINE_TRAINER_TYPE_LIST.each do |type|
    t=type
    t=type[$player.gender] if type.is_a?(Array)
    commands.push(GameData::TrainerType.get(t).name)
    trainer_types.push(t)
  end
  commands.push(_INTL("Cancel"))
  loop do
    cmd=pbMessage(_INTL("\\bWhat kind of trainer would you like to be?"),commands,-1)
    if cmd>=0 && cmd<commands.length-1
      trainername=commands[cmd]
      if ['a','e','i','o','u'].include?(trainername[0,1].downcase)
        msg=_INTL("\\bYou want to be an {1}?",trainername)
      else
        msg=_INTL("\\bYou want to be a {1}?",trainername)
      end
      if pbConfirmMessage(msg)
        if ['a','e','i','o','u'].include?(trainername[0,1].downcase)
          msg=_INTL("\\bI see! So you'd like to be an {1}.\\1",trainername)
        else
          msg=_INTL("\\bI see! So you'd like to be a {1}.\\1",trainername)
        end
        pbMessage(msg)
        pbMessage(_INTL("\\bIf that's how you feel about yourself, others will surely see you that way too!\\1"))
        $player.online_trainer_type=trainer_types[cmd]
        break
      end
    else
      break
    end
  end
  pbMessage(_INTL("\\bOK, talk to you later!"))
  if old_trainer_type != $player.online_trainer_type
    EventHandlers.trigger(:cable_club_trainer_type_updated,$player.online_trainer_type)
  end
end

# Returns false if an error occurred.
def pbCableClub
  if $player.party_count == 0
    pbMessage(_INTL("I'm sorry, you must have a Pokémon to enter the Cable Club."))
    return
  end
  msgwindow = pbCreateMessageWindow()
  begin
    pbMessageDisplay(msgwindow, _ISPRINTF("What's the ID of the trainer you're searching for? (Your ID: {1:05d})\\^",$player.public_ID($player.id)))
    partner_trainer_id = ""
    loop do
      partner_trainer_id = pbFreeText(msgwindow, partner_trainer_id, false, 5)
      return if partner_trainer_id.empty?
      break if partner_trainer_id =~ /^[0-9]{5}$/
      pbMessageDisplay(msgwindow, _INTL("I'm sorry, {1} is not a trainer ID.", partner_trainer_id))
    end
    CableClub::connect_to(msgwindow, partner_trainer_id)
    raise Connection::Disconnected.new("disconnected")
  rescue Connection::Disconnected => e
    case e.message
    when "disconnected"
      pbMessageDisplay(msgwindow, _INTL("Thank you for using the Cable Club. We hope to see you again soon."))
      return true
    when "invalid version"
      pbMessageDisplay(msgwindow, _INTL("I'm sorry, your game version is out of date compared to the Cable Club."))
      return false
    when "invalid party"
      pbMessageDisplay(msgwindow, _INTL("I'm sorry, your party contains Pokémon not allowed in the Cable Club."))
      return false
    when "peer disconnected"
      pbMessageDisplay(msgwindow, _INTL("I'm sorry, the other trainer has disconnected."))
      return true
    else
      pbMessageDisplay(msgwindow, _INTL("I'm sorry, the Cable Club server has malfunctioned!"))
      return false
    end
  rescue Errno::ECONNREFUSED
    pbMessageDisplay(msgwindow, _INTL("I'm sorry, the Cable Club server is down at the moment."))
    return false
  rescue
    pbPrintException($!)
    pbMessageDisplay(msgwindow, _INTL("I'm sorry, the Cable Club has malfunctioned!"))
    return false
  ensure
    pbDisposeMessageWindow(msgwindow)
  end
end
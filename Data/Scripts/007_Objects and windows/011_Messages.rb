#This is an adaptation of Mr.Gela's Portrait and Namebox Scripts combined
# for 18.1
#Please give credit to Mr.Gela, Golisopod User and mej71 if used!
#=========================================
#The script supports full portrait functionality
#but basic Namebox functionality.
#This script is meant to replace the MESSAGES script, so if you
#have already made any changes of your own, please make sure
#you copy them over.
#Portait Y position seemed to be off by a couple of pixels,
#I have adjusted the lines responsible, but you may edit as you see fit.
#Sections with Gela's additions have been marked, as well as
#anything that has been manually changed.
#===========GELANAME0===========
# SHIFT NAMEWINDOW IN X AXIS (except when specifying a particular X location)
OFFSET_NAMEWINDOW_X=0 
# SHIFT NAMEWINDOW IN Y AXIS (except when specifying a particular Y location)
OFFSET_NAMEWINDOW_Y=0
# WHETHER THE TEXT SHOULD BE CENTERED (0=right, 1=center, 2=right)
DEFAULT_ALIGNMENT=1   
# ENSURES A MIN. WIDTH OF THE WINDOW
MIN_WIDTH=200       
# DEFAULT FONT
DEFAULT_FONT="Power Green Narrow" # "Power Clear", etc.
# DEFAULT FONT SIZE
DEFAULT_FONT_SIZE=24
# DEFAULT WINDOWSKIN (nil = based on the currently displayed message windowskin)
# (File inside Graphics/Windowskins/)
DEFAULT_WINDOWSKIN="nmbx"
# Name of namebox file is nmbx. Simply add Gela's Namebox Graphic from his original resource into your #windowskins folder, and name it "nmbx".
#===========GELANAME0===========		
										 
#===============================================================================
# Message variables
#===============================================================================
class Game_Temp
  attr_accessor :background
  attr_writer :message_window_showing
  attr_writer :player_transferring
  attr_writer :transition_processing

  def message_window_showing
    return @message_window_showing || false
  end

  def player_transferring
    return @player_transferring || false
  end

  def transition_processing
    return @transition_processing || false
  end
end



class Game_Message
  attr_writer :background
  attr_writer :visible

  def visible
    return @visible || false
  end

  def background
    return @background || 0
  end
end



class Game_System
  attr_writer :message_position

  def message_position
    return @message_position || 2
  end
end



#===============================================================================
#
#===============================================================================
class Scene_Map
  def updatemini
    oldmws=$game_temp.message_window_showing
    oldvis=$game_message ? $game_message.visible : false
    $game_temp.message_window_showing=true
    $game_message.visible=true if $game_message
    loop do
      $game_map.update
      $game_player.update
      $game_system.update
      if $game_screen
        $game_screen.update
      else
        $game_map.screen.update
      end
      break unless $game_temp.player_transferring
      transfer_player
      break if $game_temp.transition_processing
    end
    $game_temp.message_window_showing=oldmws
    $game_message.visible=oldvis if $game_message
    @spriteset.update if @spriteset
    @message_window.update if @message_window
  end
end



class Scene_Battle
  def updatemini
    if self.respond_to?("update_basic")
      update_basic(true)
      update_info_viewport                  # Update information viewport
      if $game_message && $game_message.visible
        @info_viewport.visible = false
        @message_window.visible = true
      end
    else
      oldmws=$game_temp.message_window_showing
      $game_temp.message_window_showing=true
      # Update system (timer) and screen
      $game_system.update
      if $game_screen
        $game_screen.update
      else
        $game_map.screen.update
      end
      # If timer has reached 0
      if $game_system.timer_working and $game_system.timer == 0
        # Abort battle
        $game_temp.battle_abort = true
      end
      # Update windows
      @help_window.update if @help_window
      @party_command_window.update if @party_command_window
      @actor_command_window.update if @actor_command_window
      @status_window.update if @status_window
      $game_temp.message_window_showing=oldmws
      @message_window.update if @message_window
      # Update sprite set
      @spriteset.update if @spriteset
    end
  end
end



def pbMapInterpreter
  if $game_map.respond_to?("interpreter")
    return $game_map.interpreter
  elsif $game_system
    return $game_system.map_interpreter
  end
  return nil
end

def pbMapInterpreterRunning?
  interp = pbMapInterpreter
  return interp && interp.running?
end

def pbRefreshSceneMap
  if $scene && $scene.is_a?(Scene_Map)
    if $scene.respond_to?("miniupdate")
      $scene.miniupdate
    else
      $scene.updatemini
    end
  elsif $scene && $scene.is_a?(Scene_Battle)
    $scene.updatemini
  end
end

def pbUpdateSceneMap
  if $scene && $scene.is_a?(Scene_Map) && !pbIsFaded?
    if $scene.respond_to?("miniupdate")
      $scene.miniupdate
    else
      $scene.updatemini
    end
  elsif $scene && $scene.is_a?(Scene_Battle)
    $scene.updatemini
  end
end



#===============================================================================
#
#===============================================================================
def pbEventCommentInput(*args)
  parameters = []
  list = *args[0].list   # Event or event page
  elements = *args[1]    # Number of elements
  trigger = *args[2]     # Trigger
  return nil if list == nil
  return nil unless list.is_a?(Array)
  for item in list
    next unless item.code == 108 || item.code == 408
    if item.parameters[0] == trigger
      start = list.index(item) + 1
      finish = start + elements
      for id in start...finish
        next if !list[id]
        parameters.push(list[id].parameters[0])
      end
      return parameters
    end
  end
  return nil
end

def pbCurrentEventCommentInput(elements,trigger)
  return nil if !pbMapInterpreterRunning?
  event = pbMapInterpreter.get_character(0)
  return nil if !event
  return pbEventCommentInput(event,elements,trigger)
end

def pbButtonInputProcessing(variableNumber=0,timeoutFrames=0)
  ret=0
  timeoutFrames = timeoutFrames*Graphics.frame_rate/20
  loop do
    Graphics.update
    Input.update
    pbUpdateSceneMap
    for i in 1..18
      ret=i if Input.trigger?(i)
    end
    break if ret!=0
    if timeoutFrames>0
      i+=1
      break if i>=timeoutFrames
    end
  end
  Input.update
  if variableNumber && variableNumber>0
    $game_variables[variableNumber]=ret
    $game_map.need_refresh = true if $game_map
  end
  return ret
end



#===============================================================================
# Interpreter functions for displaying messages
#===============================================================================
module InterpreterMixin
  # Freezes all events on the map (for use at the beginning of common events)
  def pbGlobalLock
    for event in $game_map.events.values
      event.minilock
    end
  end

  # Unfreezes all events on the map (for use at the end of common events)
  def pbGlobalUnlock
    for event in $game_map.events.values
      event.unlock
    end
  end

  def pbRepeatAbove(index)
    index=@list[index].indent
    loop do
      index-=1
      return index+1 if @list[index].indent==indent
    end
  end

  def pbBreakLoop(index)
    indent = @list[index].indent
    temp_index=index
    # Copy index to temporary variables
    loop do
      # Advance index
      temp_index += 1
      # If a fitting loop was not found
      return index+1 if temp_index >= @list.size-1
      return temp_index+1 if @list[temp_index].code == 413 and
                             @list[temp_index].indent < indent
    end
  end

  def pbJumpToLabel(index,label_name)
    temp_index = 0
    loop do
      return index+1 if temp_index >= @list.size-1
      return temp_index+1 if @list[temp_index].code == 118 and
                             @list[temp_index].parameters[0] == label_name
      temp_index += 1
    end
  end

  # Gets the next index in the interpreter, ignoring
  # certain events between messages
  def pbNextIndex(index)
    return -1 if !@list || @list.length==0
    i=index+1
    loop do
      return i if i>=@list.length-1
      case @list[i].code
      when 118, 108, 408   # Label, Comment
        i+=1
      when 413             # Repeat Above
        i=pbRepeatAbove(i)
      when 113             # Break Loop
        i=pbBreakLoop(i)
      when 119             # Jump to Label
        newI=pbJumpToLabel(i,@list[i].parameters[0])
        i = (newI>i) ? newI : i+1
      else
        return i
      end
    end
  end

  # Helper function that shows a picture in a script.  To be used in
  # a script event command.
  def pbShowPicture(number,name,origin,x,y,zoomX=100,zoomY=100,opacity=255,blendType=0)
    number = number + ($game_temp.in_battle ? 50 : 0)
    $game_screen.pictures[number].show(name,origin,
       x, y, zoomX,zoomY,opacity,blendType)
  end

  # Erases an event and adds it to the list of erased events so that
  # it can stay erased when the game is saved then loaded again.  To be used in
  # a script event command.
  def pbEraseThisEvent
    if $game_map.events[@event_id]
      $game_map.events[@event_id].erase
      $PokemonMap.addErasedEvent(@event_id) if $PokemonMap
    end
    @index+=1
    return true
  end

  # Runs a common event.  To be used in a script event command.
  def pbCommonEvent(id)
    common_event = $data_common_events[id]
    if $game_temp.in_battle
      if common_event != nil
        interp = Interpreter.new
        interp.setup(common_event.list,0)
        loop do
          Graphics.update
          Input.update
          interp.update
          pbUpdateSceneMap
          break if !interp.running?
        end
      end
    else
      $game_system.battle_interpreter.setup(common_event.list, 0)
    end
  end

  # Sets another event's self switch (eg. pbSetSelfSwitch(20,"A",true) ).
  # To be used in a script event command.
  def pbSetSelfSwitch(event,swtch,value,mapid=-1)
    mapid = @map_id if mapid<0
    oldValue = $game_self_switches[[mapid,event,swtch]]
    $game_self_switches[[mapid,event,swtch]] = value
    if value!=oldValue && $MapFactory.hasMap?(mapid)
      $MapFactory.getMap(mapid,false).need_refresh = true
    end
  end

  # Must use this approach to share the methods because the methods already
  # defined in a class override those defined in an included module
  CustomEventCommands=<<_END_

  def command_242
    pbBGMFade(pbParams[0])
    return true
  end

  def command_246
    pbBGSFade(pbParams[0])
    return true
  end

  def command_251
    pbSEStop
    return true
  end

  def command_241
    pbBGMPlay(pbParams[0])
    return true
  end

  def command_245
    pbBGSPlay(pbParams[0])
    return true
  end

  def command_249
    pbMEPlay(pbParams[0])
    return true
  end

  def command_250
    pbSEPlay(pbParams[0])
    return true
  end
_END_
end



class Game_Interpreter   # Used by RMVX
  include InterpreterMixin
  eval(InterpreterMixin::CustomEventCommands)
  @@immediateDisplayAfterWait=false
  @buttonInput=false

  def pbParams
    return @params
  end

  def command_105
    return false if @buttonInput
    @buttonInput=true
    pbButtonInputProcessing(@list[@index].parameters[0])
    @buttonInput=false
    @index+=1
    return true
  end

  def command_101
    if $game_temp.message_window_showing
      return false
    end
    $game_message=Game_Message.new if !$game_message
    message=""
    commands=nil
    numInputVar=nil
    numInputDigitsMax=nil
    text=""
    facename=@list[@index].parameters[0]
    faceindex=@list[@index].parameters[1]
    if facename && facename!=""
      text+="\\ff[#{facename},#{faceindex}]"
    end
    if $game_message
      $game_message.background=@list[@index].parameters[2]
    end
    $game_system.message_position=@list[@index].parameters[3]
    message+=text
    messageend=""
    loop do
      nextIndex=pbNextIndex(@index)
      code=@list[nextIndex].code
      if code == 401
        text=@list[nextIndex].parameters[0]
        text+=" " if text!="" && text[text.length-1,1]!=" "
        message+=text
        @index=nextIndex
      else
        if code == 102
          commands=@list[nextIndex].parameters
          @index=nextIndex
        elsif code == 106 && @@immediateDisplayAfterWait
          params=@list[nextIndex].parameters
          if params[0]<=10
            nextcode=@list[nextIndex+1].code
            if nextcode==101||nextcode==102||nextcode==103
              @index=nextIndex
            else
              break
            end
          else
            break
          end
        elsif code == 103
          numInputVar=@list[nextIndex].parameters[0]
          numInputDigitsMax=@list[nextIndex].parameters[1]
          @index=nextIndex
        elsif code == 101
          messageend="\1"
        end
        break
      end
    end
    message=_MAPINTL($game_map.map_id,message)
    @message_waiting=true
    if commands
      cmdlist=[]
      for cmd in commands[0]
        cmdlist.push(_MAPINTL($game_map.map_id,cmd))
      end
      command=pbMessage(message+messageend,cmdlist,commands[1])
      @branch[@list[@index].indent] = command
    elsif numInputVar
      params=ChooseNumberParams.new
      params.setMaxDigits(numInputDigitsMax)
      params.setDefaultValue($game_variables[numInputVar])
      $game_variables[numInputVar]=pbMessageChooseNumber(message+messageend,params)
      $game_map.need_refresh = true if $game_map
    else
      pbMessage(message+messageend)
    end
    @message_waiting=false
    return true
  end

  def command_102
    @message_waiting=true
    command=pbShowCommands(nil,@list[@index].parameters[0],@list[@index].parameters[1])
    @message_waiting=false
    @branch[@list[@index].indent] = command
    Input.update # Must call Input.update again to avoid extra triggers
    return true
  end

  def command_103
    varnumber=@list[@index].parameters[0]
    @message_waiting=true
    params=ChooseNumberParams.new
    params.setMaxDigits(@list[@index].parameters[1])
    params.setDefaultValue($game_variables[varnumber])
    $game_variables[varnumber]=pbChooseNumber(nil,params)
    $game_map.need_refresh = true if $game_map
    @message_waiting=false
    return true
  end
end



class Interpreter   # Used by RMXP
  include InterpreterMixin
  eval(InterpreterMixin::CustomEventCommands)
  @@immediateDisplayAfterWait=false
  @buttonInput=false

  def pbParams
    return @parameters
  end

  def command_105
    return false if @buttonInput
    @buttonInput=true
    pbButtonInputProcessing(@list[@index].parameters[0])
    @buttonInput=false
    @index+=1
    return true
  end

  def command_101
    if $game_temp.message_window_showing
      return false
    end
    message=""
    commands=nil
    numInputVar=nil
    numInputDigitsMax=nil
    text=""
    firstText=nil
    if @list[@index].parameters.length==1
      text+=@list[@index].parameters[0]
      firstText=@list[@index].parameters[0]
      text+=" " if text[text.length-1,1]!=" "
      message+=text
    else
      facename=@list[@index].parameters[0]
      faceindex=@list[@index].parameters[1]
      if facename && facename!=""
        text+="\\ff[#{facename},#{faceindex}]"
        message+=text
      end
    end
    messageend=""
    loop do
      nextIndex=pbNextIndex(@index)
      code=@list[nextIndex].code
      if code == 401
        text=@list[nextIndex].parameters[0]
        text+=" " if text[text.length-1,1]!=" "
        message+=text
        @index=nextIndex
      else
        if code == 102
          commands=@list[nextIndex].parameters
          @index=nextIndex
        elsif code == 106 && @@immediateDisplayAfterWait
          params=@list[nextIndex].parameters
          if params[0]<=10
            nextcode=@list[nextIndex+1].code
            if nextcode==101 || nextcode==102 || nextcode==103
              @index=nextIndex
            else
              break
            end
          else
            break
          end
        elsif code == 103
          numInputVar=@list[nextIndex].parameters[0]
          numInputDigitsMax=@list[nextIndex].parameters[1]
          @index=nextIndex
        elsif code == 101
          if @list[@index].parameters.length==1
            text=@list[@index].parameters[0]
            if text[/\A\\ignr/] && text==firstText
              text+=" " if text[text.length-1,1]!=" "
              message+=text
              @index=nextIndex
              continue
            end
          end
          messageend="\1"
        end
        break
      end
    end
    @message_waiting=true # needed to allow parallel process events to work while
                          # a message is displayed
    message=_MAPINTL($game_map.map_id,message)
    if commands
      cmdlist=[]
      for cmd in commands[0]
        cmdlist.push(_MAPINTL($game_map.map_id,cmd))
      end
      command=pbMessage(message+messageend,cmdlist,commands[1])
      @branch[@list[@index].indent] = command
    elsif numInputVar
      params=ChooseNumberParams.new
      params.setMaxDigits(numInputDigitsMax)
      params.setDefaultValue($game_variables[numInputVar])
      $game_variables[numInputVar]=pbMessageChooseNumber(message+messageend,params)
      $game_map.need_refresh = true if $game_map
    else
      pbMessage(message+messageend,nil)
    end
    @message_waiting=false
    return true
  end

  def command_102
    @message_waiting=true
    command=pbShowCommands(nil,@list[@index].parameters[0],@list[@index].parameters[1])
    @message_waiting=false
    @branch[@list[@index].indent] = command
    Input.update # Must call Input.update again to avoid extra triggers
    return true
  end

  def command_103
    varnumber=@list[@index].parameters[0]
    @message_waiting=true
    params=ChooseNumberParams.new
    params.setMaxDigits(@list[@index].parameters[1])
    params.setDefaultValue($game_variables[varnumber])
    $game_variables[varnumber]=pbChooseNumber(nil,params)
    $game_map.need_refresh = true if $game_map
    @message_waiting=false
    return true
  end
end



#===============================================================================
#
#===============================================================================
class ChooseNumberParams
  def initialize
    @maxDigits=0
    @minNumber=0
    @maxNumber=0
    @skin=nil
    @messageSkin=nil
    @negativesAllowed=false
    @initialNumber=0
    @cancelNumber=nil
  end

  def setMessageSkin(value)
    @messageSkin=value
  end

  def messageSkin   # Set the full path for the message's window skin
    @messageSkin
  end

  def setSkin(value)
    @skin=value
  end

  def skin
    @skin
  end

  def setNegativesAllowed(value)
    @negativeAllowed=value
  end

  def negativesAllowed
    @negativeAllowed ? true : false
  end

  def setRange(minNumber,maxNumber)
    maxNumber=minNumber if minNumber>maxNumber
    @maxDigits=0
    @minNumber=minNumber
    @maxNumber=maxNumber
  end

  def setDefaultValue(number)
    @initialNumber=number
    @cancelNumber=nil
  end

  def setInitialValue(number)
    @initialNumber=number
  end

  def setCancelValue(number)
    @cancelNumber=number
  end

  def initialNumber
    return clamp(@initialNumber,self.minNumber,self.maxNumber)
  end

  def cancelNumber
    return @cancelNumber || self.initialNumber
  end

  def minNumber
    ret=0
    if @maxDigits>0
      ret=-((10**@maxDigits)-1)
    else
      ret=@minNumber
    end
    ret=0 if !@negativeAllowed && ret<0
    return ret
  end

  def maxNumber
    ret=0
    if @maxDigits>0
      ret=((10**@maxDigits)-1)
    else
      ret=@maxNumber
    end
    ret=0 if !@negativeAllowed && ret<0
    return ret
  end

  def setMaxDigits(value)
    @maxDigits=[1,value].max
  end

  def maxDigits
    if @maxDigits>0
      return @maxDigits
    else
      return [numDigits(self.minNumber),numDigits(self.maxNumber)].max
    end
  end

  private

  def clamp(v,mn,mx)
    return v<mn ? mn : (v>mx ? mx : v)
  end

  def numDigits(number)
    ans = 1
    number=number.abs
    while number >= 10
      ans+=1
      number/=10
    end
    return ans
  end
end



def pbChooseNumber(msgwindow,params)
  return 0 if !params
  ret=0
  maximum=params.maxNumber
  minimum=params.minNumber
  defaultNumber=params.initialNumber
  cancelNumber=params.cancelNumber
  cmdwindow=Window_InputNumberPokemon.new(params.maxDigits)
  cmdwindow.z=99999
  cmdwindow.visible=true
  cmdwindow.setSkin(params.skin) if params.skin
  cmdwindow.sign=params.negativesAllowed # must be set before number
  cmdwindow.number=defaultNumber
  pbPositionNearMsgWindow(cmdwindow,msgwindow,:right)
  loop do
    Graphics.update
    Input.update
    pbUpdateSceneMap
    cmdwindow.update
    msgwindow.update if msgwindow
    yield if block_given?
    if Input.trigger?(Input::C)
      ret=cmdwindow.number
      if ret>maximum
        pbPlayBuzzerSE()
      elsif ret<minimum
        pbPlayBuzzerSE()
      else
        pbPlayDecisionSE()
        break
      end
    elsif Input.trigger?(Input::B)
      pbPlayCancelSE()
      ret=cancelNumber
      break
    end
  end
  cmdwindow.dispose
  Input.update
  return ret
end

#===================GELA FACE1=======================================                             
    class FaceWindowVXNew < SpriteWindow_Base
  def initialize(face)
    super(0,0,192,192)
    self.windowskin=nil
    faceinfo=face.split(",")
    facefile=pbResolveBitmap("Graphics/Faces/"+faceinfo[0])
    facefile=pbResolveBitmap("Graphics/Faces/none") if !facefile
    self.contents.dispose if self.contents
    @faceIndex=faceinfo[1].to_i
    @facebitmaptmp=AnimatedBitmap.new(facefile)
    @facebitmap=BitmapWrapper.new(160,160)
    @facebitmap.blt(0,0,@facebitmaptmp.bitmap,Rect.new(
       (@faceIndex % 4) * 160,
       (@faceIndex / 4) * 160, 160, 160
    ))
    self.contents=@facebitmap
  end

  def update
    super
    if @facebitmaptmp.totalFrames>77 #This should be 1. Adjust accordingly
      @facebitmaptmp.update
      @facebitmap.blt(0,0,@facebitmaptmp.bitmap,Rect.new(
         (@faceIndex % 4) * 160,
         (@faceIndex / 4) * 160, 160, 160
      ))
    end
  end

  def dispose
    @facebitmaptmp.dispose
    @facebitmap.dispose if @facebitmap
    super
	
  end
end         
#==========================GELA FACE1==============================



#===============================================================================
#
#===============================================================================
def pbGetBasicMapNameFromId(id)
  begin
    map = pbLoadRxData("Data/MapInfos")
    return "" if !map
    return map[id].name
  rescue
    return ""
  end
end

def pbGetMapNameFromId(id)
  map=pbGetBasicMapNameFromId(id)
  map.gsub!(/\\PN/,$Trainer.name) if $Trainer
  return map
end

def pbCsvField!(str)
  ret=""
  str.sub!(/\A\s*/,"")
  if str[0,1]=="\""
    str[0,1]=""
    escaped=false
    fieldbytes=0
    str.scan(/./) do |s|
      fieldbytes+=s.length
      break if s=="\"" && !escaped
      if s=="\\" && !escaped
        escaped=true
      else
        ret+=s
        escaped=false
      end
    end
    str[0,fieldbytes]=""
    if !str[/\A\s*,/] && !str[/\A\s*$/]
      raise _INTL("Invalid quoted field (in: {1})",ret)
    end
    str[0,str.length]=$~.post_match
  else
    if str[/,/]
      str[0,str.length]=$~.post_match
      ret=$~.pre_match
    else
      ret=str.clone
      str[0,str.length]=""
    end
    ret.gsub!(/\s+$/,"")
  end
  return ret
end

def pbCsvPosInt!(str)
  ret=pbCsvField!(str)
  if !ret[/\A\d+$/]
    raise _INTL("Field {1} is not a positive integer",ret)
  end
  return ret.to_i
end



#===============================================================================
# Money and coins windows
#===============================================================================
def pbGetGoldString
  moneyString=""
  begin
    moneyString=_INTL("${1}",$Trainer.money.to_s_formatted)
  rescue
    if $data_system.respond_to?("words")
      moneyString=_INTL("{1} {2}",$game_party.gold,$data_system.words.gold)
    else
      moneyString=_INTL("{1} {2}",$game_party.gold,Vocab.gold)
    end
  end
  return moneyString
end

def pbDisplayGoldWindow(msgwindow)
  moneyString=pbGetGoldString()
  goldwindow=Window_AdvancedTextPokemon.new(_INTL("Money:\n<ar>{1}</ar>",moneyString))
  goldwindow.setSkin("Graphics/Windowskins/goldskin")
  goldwindow.resizeToFit(goldwindow.text,Graphics.width)
  goldwindow.width=160 if goldwindow.width<=160
  if msgwindow.y==0
    goldwindow.y=Graphics.height-goldwindow.height
  else
    goldwindow.y=0
  end
  goldwindow.viewport=msgwindow.viewport
  goldwindow.z=msgwindow.z
  return goldwindow
end

def pbDisplayCoinsWindow(msgwindow,goldwindow)
  coinString=($PokemonGlobal) ? $PokemonGlobal.coins.to_s_formatted : "0"
  coinwindow=Window_AdvancedTextPokemon.new(_INTL("Coins:\n<ar>{1}</ar>",coinString))
  coinwindow.setSkin("Graphics/Windowskins/goldskin")
  coinwindow.resizeToFit(coinwindow.text,Graphics.width)
  coinwindow.width=160 if coinwindow.width<=160
  if msgwindow.y==0
    coinwindow.y=(goldwindow) ? goldwindow.y-coinwindow.height : Graphics.height-coinwindow.height
  else
    coinwindow.y=(goldwindow) ? goldwindow.height : 0
  end
  coinwindow.viewport=msgwindow.viewport
  coinwindow.z=msgwindow.z
  return coinwindow
end
#=======GELANAME1==============

# NEW
def pbDisplayNameWindow(msgwindow,dark,param)
  namewindow=Window_AdvancedTextPokemon.new(_INTL("<ar>{1}</ar>",param))
  if dark==true
    namewindow.setSkin("Graphics/Windowskins/"+MessageConfig::TextSkinName+"xndark")
    colortag=getSkinColor(msgwindow.windowskin,0,true)
    namewindow.text=colortag+namewindow.text
	 else
    namewindow.setSkin("Graphics/Windowskins/nmbx")				
  end

  namewindow.resizeToFit(namewindow.text,Graphics.width)
  namewindow.width=242 if namewindow.width<=140
  namewindow.width = namewindow.width
  namewindow.y=msgwindow.y-namewindow.height
  namewindow.y+=OFFSET_NAMEWINDOW_Y
  namewindow.x=-18
  namewindow.viewport=msgwindow.viewport
  namewindow.z=msgwindow.z
  return namewindow
end						

# NEW
def pbDisplayNameWindowRight(msgwindow,dark,param)
  namewindow=Window_AdvancedTextPokemon.new(_INTL("  {1}",param))
  if dark==true
    namewindow.setSkin("Graphics/Windowskins/"+MessageConfig::TextSkinName+"xndark")
    colortag=getSkinColor(msgwindow.windowskin,0,true)
    namewindow.text=colortag+namewindow.text
	 else
    namewindow.setSkin("Graphics/Windowskins/nmbx")				
  end

  namewindow.resizeToFit(namewindow.text,Graphics.width)
  if namewindow.width>=180
    namewindow.width=254 
  elsif namewindow.width>=130
    namewindow.width=214 
  elsif namewindow.width>=110
    namewindow.width=200 
  else
    namewindow.width=192
  end
  case $game_variables[30][1]
    when "Roxie"
      namewindow.width=204
    when "Clemont"
      namewindow.width=214
    when "Olympia"
      namewindow.width=230
    when "Wulfric"
      namewindow.width=218
    when "Lysandre"
      namewindow.width=224
    when "Steven"
      namewindow.width=210
    when "Cynthia"
      namewindow.width=208
    when "Shauntal"
      namewindow.width=220
    when "Marshal"
      namewindow.width=212
    when "Caitlin"
      namewindow.width=226
    when "Wikstrom"
      namewindow.width=222
  end
  namewindow.width = namewindow.width
  namewindow.y=msgwindow.y-namewindow.height
  namewindow.y+=OFFSET_NAMEWINDOW_Y
  namewindow.x=Graphics.width-namewindow.width+18
  namewindow.viewport=msgwindow.viewport
  namewindow.z=msgwindow.z
  return namewindow
end	

#=======GELANAME1==============						  


#===============================================================================
#
#===============================================================================
def pbCreateStatusWindow(viewport=nil)
  msgwindow=Window_AdvancedTextPokemon.new("")
  if !viewport
    msgwindow.z=99999
  else
    msgwindow.viewport=viewport
  end
  msgwindow.visible=false
  msgwindow.letterbyletter=false
  pbBottomLeftLines(msgwindow,2)
  skinfile=MessageConfig.pbGetSpeechFrame()
  msgwindow.setSkin(skinfile)
  return msgwindow
end

def pbCreateMessageWindow(viewport=nil,skin=nil)
  msgwindow=Window_AdvancedTextPokemon.new("")
  if !viewport
    msgwindow.z=99999
  else
    msgwindow.viewport=viewport
  end
  msgwindow.visible=true
  msgwindow.letterbyletter=true
  # msgwindow.back_opacity=MessageConfig::WindowOpacity
  pbBottomLeftLines(msgwindow,2)
  $game_temp.message_window_showing=true if $game_temp
  $game_message.visible=true if $game_message
  skin=MessageConfig.pbGetSpeechFrame() if !skin
  msgwindow.setSkin(skin)
  return msgwindow
end

def pbDisposeMessageWindow(msgwindow)
  $game_temp.message_window_showing=false if $game_temp
  $game_message.visible=false if $game_message
  msgwindow.dispose
end



#===============================================================================
# Main message-displaying function
#===============================================================================
def pbMessageDisplay(msgwindow,message,letterbyletter=true,commandProc=nil)
  return if !msgwindow
  oldletterbyletter=msgwindow.letterbyletter
  msgwindow.letterbyletter=(letterbyletter) ? true : false
  ret=nil
  
  #=======GELANAME2=======
	  count=0
  #=======GELANAME2=======	
  
  commands=nil
  facewindow=nil
  
  #======GELA FACE2=================
  facewindowL=nil
  facewindowR=nil
  #=====GELA FACE2==================
  
  goldwindow=nil
  coinwindow=nil
  
  #=======GELANAME3=======
	   namewindow=nil
  #=======GELANAME3=======	
  
  cmdvariable=0
  cmdIfCancel=0
  msgwindow.waitcount=0
  autoresume=false
  text=message.clone
  msgback=nil
  linecount=(Graphics.height>400) ? 3 : 2
  ### Text replacement
  text.gsub!(/\\sign\[([^\]]*)\]/i) {   # \sign[something] gets turned into
    next "\\op\\cl\\ts[]\\w["+$1+"]"    # \op\cl\ts[]\w[something]
  }
  text.gsub!(/\\\\/,"\5")
  text.gsub!(/\\1/,"\1")
  if $game_actors
    text.gsub!(/\\n\[([1-8])\]/i) {
      m = $1.to_i
      next $game_actors[m].name
    }
  end
  text.gsub!(/\\pn/i,$Trainer.name) if $Trainer
  text.gsub!(/\\pm/i,_INTL("${1}",$Trainer.money.to_s_formatted)) if $Trainer
  text.gsub!(/\\n/i,"\n")
  text.gsub!(/\\\[([0-9a-f]{8,8})\]/i) { "<c2="+$1+">" }
  text.gsub!(/\\pg/i,"\\b") if $Trainer && $Trainer.male?
  text.gsub!(/\\pg/i,"\\r") if $Trainer && $Trainer.female?
  text.gsub!(/\\pg/i,"\\p") if $Trainer && $Trainer.nonbinary? # edit here
  text.gsub!(/\\pog/i,"\\r") if $Trainer && $Trainer.male?
  text.gsub!(/\\pog/i,"\\b") if $Trainer && $Trainer.female?
  text.gsub!(/\\pog/i,"\\p") if $Trainer && $Trainer.nonbinary? # edit here
  text.gsub!(/\\pg/i,"")
  text.gsub!(/\\pog/i,"")
  text.gsub!(/\\b/i,"<c3=3050C8,D0D0C8>")
  text.gsub!(/\\r/i,"<c3=E00808,D0D0C8>")
  text.gsub!(/\\p/i,"<c3=9040E8,D0D0C8>")
  isDarkSkin = isDarkWindowskin(msgwindow.windowskin)
  text.gsub!(/\\[Cc]\[([0-9]+)\]/) {
    m = $1.to_i
    next getSkinColor(msgwindow.windowskin,m,isDarkSkin)
  }
  loop do
    last_text = text.clone
    text.gsub!(/\\v\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    break if text == last_text
  end
  loop do
    last_text = text.clone
    text.gsub!(/\\l\[([0-9]+)\]/i) {
      linecount = [1,$1.to_i].max
      next ""
    }
    break if text == last_text
  end
  colortag = ""
  if ($game_message && $game_message.background>0) ||
     ($game_system && $game_system.respond_to?("message_frame") &&
      $game_system.message_frame != 0)
    colortag = getSkinColor(msgwindow.windowskin,0,true)
  else
    colortag = getSkinColor(msgwindow.windowskin,0,isDarkSkin)
  end
  text = colortag+text
  ### Controls
  textchunks=[]
  controls=[]
  #==========GELA FACE, ADDING PORTRAIT CATCH, BASICALLY MR, ML ETC===========
  while text[/(?:\\(w|f|ff|ts|xn|xnr|cl|me|ml|mr|se|wt|wtnp|ch)\[([^\]]*)\]|\\(g|cn|wd|wm|op|cl|wu|\.|\||\!|\^))/i]
    textchunks.push($~.pre_match)
  #==========GELA FACE, ADDING PORTRAIT CODES===========
    if $~[1]
      controls.push([$~[1].downcase,$~[2],-1])
    else
      controls.push([$~[3].downcase,"",-1])
    end
    text=$~.post_match
  end
  textchunks.push(text)
  for chunk in textchunks
    chunk.gsub!(/\005/,"\\")
  end
  textlen = 0
  for i in 0...controls.length
    control = controls[i][0]
    case control
    when "wt", "wtnp", ".", "|"
      textchunks[i] += "\2"
    when "!"
      textchunks[i] += "\1"
    end
    textlen += toUnformattedText(textchunks[i]).scan(/./m).length
    controls[i][2] = textlen
  end
  text = textchunks.join("")
  unformattedText = toUnformattedText(text)
  signWaitCount = 0
  signWaitTime = Graphics.frame_rate/2
  haveSpecialClose = false
  specialCloseSE = ""
  for i in 0...controls.length
    control = controls[i][0]
    param = controls[i][1]
    case control
    when "op"
      signWaitCount = signWaitTime+1
    when "cl"
      text = text.sub(/\001\z/,"")   # fix: '$' can match end of line as well
      haveSpecialClose = true
      specialCloseSE = param
  #  when "f"
    #  facewindow.dispose if facewindow
    #  facewindow = PictureWindow.new("Graphics/Pictures/#{param}")
    when "ch"
      cmds = param.clone
      cmdvariable = pbCsvPosInt!(cmds)
      cmdIfCancel = pbCsvField!(cmds).to_i
      commands = []
      while cmds.length>0
        commands.push(pbCsvField!(cmds))
      end
    when "wtnp", "^"
      text = text.sub(/\001\z/,"")   # fix: '$' can match end of line as well
    when "se"
      if controls[i][2]==0
        startSE = param
        controls[i] = nil
      end
    end
  end
  if startSE!=nil
    pbSEPlay(pbStringToAudioFile(startSE))
  elsif signWaitCount==0 && letterbyletter
    pbPlayDecisionSE()
  end
  ########## Position message window  ##############
  pbRepositionMessageWindow(msgwindow,linecount)
  if $game_message && $game_message.background==1
    msgback = IconSprite.new(0,msgwindow.y,msgwindow.viewport)
    msgback.z = msgwindow.z-1
    msgback.setBitmap("Graphics/System/MessageBack")
  end
  
  
  #==============GELA FACE3=========================================================
if facewindowL
    facewindowL.viewport=msgwindow.viewport
    facewindowL.z=msgwindow.z
  end
  if facewindowR
    facewindowR.viewport=msgwindow.viewport
    facewindowR.z=msgwindow.z
    end
  #===============GELA FACE3========================================================
  
  
  #if facewindow
  #  pbPositionNearMsgWindow(facewindow,msgwindow,:left)
  #  facewindow.viewport = msgwindow.viewport
  #  facewindow.z        = msgwindow.z
  #end
  atTop = (msgwindow.y==0)
  ########## Show text #############################
  msgwindow.text = text
  # ===============change this to the framerate your game is using ??
  Graphics.frame_reset if Graphics.frame_rate>60
 # ===============change this to the framerate your game is using ??
  loop do
    if signWaitCount>0
      signWaitCount -= 1
      if atTop
        msgwindow.y = -msgwindow.height*signWaitCount/signWaitTime
      else
        msgwindow.y = Graphics.height-msgwindow.height*(signWaitTime-signWaitCount)/signWaitTime
      end
    end
    for i in 0...controls.length
      next if !controls[i]
      next if controls[i][2]>msgwindow.position || msgwindow.waitcount!=0
      control = controls[i][0]
      param = controls[i][1]
      case control
#===========GELANAME4=========
	  # NEW
        when "xn"
          # Show name box, based on #{param}
          namewindow.dispose if namewindow
          namewindow=pbDisplayNameWindow(msgwindow,dark=false,param)
        when "xnr"
          # Show name box, based on #{param}
          namewindow.dispose if namewindow
          namewindow=pbDisplayNameWindowRight(msgwindow,dark=false,param)
        when "dxn"
          # Show name box, based on #{param}
          namewindow.dispose if namewindow
          namewindow=pbDisplayNameWindow(msgwindow,dark=true,param)
#===========GELANAME4=========															
      when "f"
        facewindow.dispose if facewindow
        facewindow = PictureWindow.new("Graphics/Pictures/#{param}")
        pbPositionNearMsgWindow(facewindow,msgwindow,:left)
        facewindow.viewport = msgwindow.viewport
        facewindow.z        = msgwindow.z
		
		
#====================GELA FACE4==================================
        when "ml" # Mug Shot (Left)
          facewindowL.dispose if facewindowL
          facewindowL=FaceWindowVXNew.new(param)
          facewindowL.windowskin=nil
          facewindowL.x=-16
          facewindowL.y=148-32  #changes in Y position. Adjust accordingly
          facewindowL.viewport=msgwindow.viewport
          facewindowL.z=msgwindow.z
        when "mr" # Mug Shot (Right)
          facewindowR.dispose if facewindowR
          facewindowR=FaceWindowVXNew.new(param)
          facewindowR.windowskin=nil
          facewindowR.x=336 # original 320
          facewindowR.y=148-32  #changes in Y position. Adjust accordingly
          facewindowR.viewport=msgwindow.viewport
          facewindowR.z=msgwindow.z
        when "ff"
          facewindow.dispose if facewindow
          facewindow = FaceWindowVX.new(param)
          facewindow.x=320
          facewindow.y=148-32  #changes in Y position. Adjust accordingly
#==================GELA FACE4=======================


        pbPositionNearMsgWindow(facewindow,msgwindow,:left)
        facewindow.viewport = msgwindow.viewport
        facewindow.z        = msgwindow.z
		
      when "g"      # Display gold window
        goldwindow.dispose if goldwindow
        goldwindow = pbDisplayGoldWindow(msgwindow)
      when "cn"     # Display coins window
        coinwindow.dispose if coinwindow
        coinwindow = pbDisplayCoinsWindow(msgwindow,goldwindow)
      when "wu"
        msgwindow.y = 0
        atTop = true
        msgback.y = msgwindow.y if msgback
        pbPositionNearMsgWindow(facewindow,msgwindow,:left)
        msgwindow.y = -msgwindow.height*signWaitCount/signWaitTime
      when "wm"
        atTop = false
        msgwindow.y = (Graphics.height-msgwindow.height)/2
        msgback.y = msgwindow.y if msgback
        pbPositionNearMsgWindow(facewindow,msgwindow,:left)
      when "wd"
        atTop = false
        msgwindow.y = Graphics.height-msgwindow.height
        msgback.y = msgwindow.y if msgback
        pbPositionNearMsgWindow(facewindow,msgwindow,:left)
        msgwindow.y = Graphics.height-msgwindow.height*(signWaitTime-signWaitCount)/signWaitTime
      when "w"      # Change windowskin
        if param==""
          msgwindow.windowskin = nil
        else
          msgwindow.setSkin("Graphics/Windowskins/#{param}",false)
        end
      when "ts"     # Change text speed
        msgwindow.textspeed = (param=="") ? -999 : param.to_i
      when "."      # Wait 0.25 seconds
        msgwindow.waitcount += Graphics.frame_rate/4
      when "|"      # Wait 1 second
        msgwindow.waitcount += Graphics.frame_rate
      when "wt"     # Wait X/20 seconds
        param = param.sub(/\A\s+/,"").sub(/\s+\z/,"")
        msgwindow.waitcount += param.to_i*Graphics.frame_rate/20
      when "wtnp"   # Wait X/20 seconds, no pause
        param = param.sub(/\A\s+/,"").sub(/\s+\z/,"")
        msgwindow.waitcount = param.to_i*Graphics.frame_rate/20
        autoresume = true
      when "^"      # Wait, no pause
        autoresume = true
      when "se"     # Play SE
        pbSEPlay(pbStringToAudioFile(param))
      when "me"     # Play ME
        pbMEPlay(pbStringToAudioFile(param))
      end
      controls[i] = nil
    end
    break if !letterbyletter
    Graphics.update
    Input.update
    facewindow.update if facewindow
	#===================GELA FACE5===============================
        facewindowL.update if facewindowL
        facewindowR.update if facewindowR
#===================GELA FACE5===============================
    if $DEBUG && Input.trigger?(Input::F6)
      pbRecord(unformattedText)
    end
    if autoresume && msgwindow.waitcount==0
      msgwindow.resume if msgwindow.busy?
      break if !msgwindow.busy?
    end
    #======================HOLD A TO SKIP=============
       if Input.press?(Input::A)
      msgwindow.textspeed=-999
      msgwindow.update
      if msgwindow.busy?
        pbPlayDecisionSE() if msgwindow.pausing?
        msgwindow.resume
      else
        break if signWaitCount==0
      end
    end
    #======================HOLD A TO SKIP=============
    if Input.trigger?(Input::C) || Input.trigger?(Input::A)
      if msgwindow.busy?
        pbPlayDecisionSE if msgwindow.pausing?
        msgwindow.resume
      else
        break if signWaitCount==0
      end
    end
    pbUpdateSceneMap
    msgwindow.update
    yield if block_given?
    break if (!letterbyletter || commandProc || commands) && !msgwindow.busy?
  end
  Input.update   # Must call Input.update again to avoid extra triggers
  msgwindow.letterbyletter=oldletterbyletter
  if commands
    $game_variables[cmdvariable]=pbShowCommands(msgwindow,commands,cmdIfCancel)
    $game_map.need_refresh = true if $game_map
  end
  if commandProc
    ret=commandProc.call(msgwindow)
  end
  msgback.dispose if msgback
 #======GELANAME5==========
  # NEW
  namewindow.dispose if namewindow	 
 #======GELANAME5==========
  
  goldwindow.dispose if goldwindow
  #==========GELA FACE6===================================
    facewindowL.dispose if facewindowL
    facewindowR.dispose if facewindowR
  #============GELA FACE6=================================
  coinwindow.dispose if coinwindow
  facewindow.dispose if facewindow
  if haveSpecialClose
    pbSEPlay(pbStringToAudioFile(specialCloseSE))
    atTop = (msgwindow.y==0)
    for i in 0..signWaitTime
      if atTop
        msgwindow.y = -msgwindow.height*i/signWaitTime
      else
        msgwindow.y = Graphics.height-msgwindow.height*(signWaitTime-i)/signWaitTime
      end
      Graphics.update
      Input.update
      pbUpdateSceneMap
      msgwindow.update
    end
  end
  return ret
end



#===============================================================================
# Message-displaying functions
#===============================================================================
def pbMessage(message,commands=nil,cmdIfCancel=0,skin=nil,defaultCmd=0,&block)
  ret = 0
  msgwindow = pbCreateMessageWindow(nil,skin)
  if commands
    ret = pbMessageDisplay(msgwindow,message,true,
       proc { |msgwindow|
         next Kernel.pbShowCommands(msgwindow,commands,cmdIfCancel,defaultCmd,&block)
       },&block)
  else
    pbMessageDisplay(msgwindow,message,&block)
  end
  pbDisposeMessageWindow(msgwindow)
  Input.update
  return ret
end

def pbConfirmMessage(message,&block)
  return (pbMessage(message,[_INTL("Yes"),_INTL("No")],2,&block)==0)
end

def pbConfirmMessageSerious(message,&block)
  return (pbMessage(message,[_INTL("No"),_INTL("Yes")],1,&block)==1)
end

def pbMessageChooseNumber(message,params,&block)
  msgwindow = pbCreateMessageWindow(nil,params.messageSkin)
  ret = pbMessageDisplay(msgwindow,message,true,
     proc { |msgwindow|
       next pbChooseNumber(msgwindow,params,&block)
     },&block)
  pbDisposeMessageWindow(msgwindow)
  return ret
end

def pbShowCommands(msgwindow,commands=nil,cmdIfCancel=0,defaultCmd=0)
  return 0 if !commands
  cmdwindow=Window_CommandPokemonEx.new(commands)
  cmdwindow.z=99999
  cmdwindow.visible=true
  cmdwindow.resizeToFit(cmdwindow.commands)
  pbPositionNearMsgWindow(cmdwindow,msgwindow,:right)
  cmdwindow.index=defaultCmd
  command=0
  loop do
    Graphics.update
    Input.update
    cmdwindow.update
    msgwindow.update if msgwindow
    yield if block_given?
    if Input.trigger?(Input::B)
      if cmdIfCancel>0
        command=cmdIfCancel-1
        break
      elsif cmdIfCancel<0
        command=cmdIfCancel
        break
      end
    end
    if Input.trigger?(Input::C)
      command=cmdwindow.index
      break
    end
    pbUpdateSceneMap
  end
  ret=command
  cmdwindow.dispose
  Input.update
  return ret
end

def pbShowCommandsWithHelp(msgwindow,commands,help,cmdIfCancel=0,defaultCmd=0)
  msgwin=msgwindow
  msgwin=pbCreateMessageWindow(nil) if !msgwindow
  oldlbl=msgwin.letterbyletter
  msgwin.letterbyletter=false
  if commands
    cmdwindow=Window_CommandPokemonEx.new(commands)
    cmdwindow.z=99999
    cmdwindow.visible=true
    cmdwindow.resizeToFit(cmdwindow.commands)
    cmdwindow.height=msgwin.y if cmdwindow.height>msgwin.y
    cmdwindow.index=defaultCmd
    command=0
    msgwin.text=help[cmdwindow.index]
    msgwin.width=msgwin.width   # Necessary evil to make it use the proper margins
    loop do
      Graphics.update
      Input.update
      oldindex=cmdwindow.index
      cmdwindow.update
      if oldindex!=cmdwindow.index
        msgwin.text=help[cmdwindow.index]
      end
      msgwin.update
      yield if block_given?
      if Input.trigger?(Input::B)
        if cmdIfCancel>0
          command=cmdIfCancel-1
          break
        elsif cmdIfCancel<0
          command=cmdIfCancel
          break
        end
      end
      if Input.trigger?(Input::C)
        command=cmdwindow.index
        break
      end
      pbUpdateSceneMap
    end
    ret=command
    cmdwindow.dispose
    Input.update
  end
  msgwin.letterbyletter=oldlbl
  msgwin.dispose if !msgwindow
  return ret
end

# frames is the number of 1/20 seconds to wait for
def pbMessageWaitForInput(msgwindow,frames,showPause=false)
  return if !frames || frames<=0
  msgwindow.startPause if msgwindow && showPause
  frames = frames*Graphics.frame_rate/20
  frames.times do
    Graphics.update
    Input.update
    msgwindow.update if msgwindow
    pbUpdateSceneMap
    if Input.trigger?(Input::C) || Input.trigger?(Input::B)
      break
    end
    yield if block_given?
  end
  msgwindow.stopPause if msgwindow && showPause
end

def pbFreeText(msgwindow,currenttext,passwordbox,maxlength,width=240)
  window=Window_TextEntry_Keyboard.new(currenttext,0,0,width,64)
  ret=""
  window.maxlength=maxlength
  window.visible=true
  window.z=99999
  pbPositionNearMsgWindow(window,msgwindow,:right)
  window.text=currenttext
  window.passwordChar="*" if passwordbox
  Input.text_input = true
  loop do
    Graphics.update
    Input.update
    if Input.triggerex?(:ESCAPE)
      ret=currenttext
      break
    elsif Input.triggerex?(:RETURN)
      ret=window.text
      break
    end
    window.update
    msgwindow.update if msgwindow
    yield if block_given?
  end
  Input.text_input = false
  window.dispose
  Input.update
  return ret
end

def pbMessageFreeText(message,currenttext,passwordbox,maxlength,width=240,&block)
  msgwindow=pbCreateMessageWindow
  retval=pbMessageDisplay(msgwindow,message,true,
     proc { |msgwindow|
       next pbFreeText(msgwindow,currenttext,passwordbox,maxlength,width,&block)
     },&block)
  pbDisposeMessageWindow(msgwindow)
  return retval
end
DLL = "DiscordAPI_XP"
ID = 1002011440045113404 # YOUR APPLICATION ID GOES HERE, !!DO NOT PUT IT IN "", IT IS AN INTEGER NOW!!

class DiscordAPI
  def initialize
    # API references
    @func_discord_initialize = MiniFFI.new(DLL, "Discord_Init", 'l', 'i')
    @func_discord_shutdown = MiniFFI.new(DLL, "Discord_Shutdown", 'v', 'v')
    @func_discord_update = MiniFFI.new(DLL, "Discord_Update", 'v', 'v')
    @func_discord_activities_update = MiniFFI.new(DLL, "DiscordActivities_Update", 'ppppppllii', 'v')
    
    # Presence variables
    @state = ""
    @details = ""
    @timestamp_start = 0
    @timestamp_end = 0
    @large_image = ""
    @small_image = ""
    @large_image_text = ""
    @small_image_text = ""
    @party_size = 0
    @party_max = 0
    
    @discord_api_status = 0;
  end
  
  # API calls
  def init(id)
    @discord_api_status = @func_discord_initialize.call(id)
  end
  
  def shutdown
    @func_discord_shutdown.call if @discord_api_status == 0
  end
  
  def run_callbacks
    @func_discord_update.call if @discord_api_status == 0
  end
  
  def update
    @func_discord_activities_update.call(@state,@details,@large_image,@small_image,@large_image_text,@small_image_text, @timestamp_start, @timestamp_end, @party_size, @party_max) if @discord_api_status == 0
  end
  
  # Variable modifier methods
  def state=(val)
    return if val.class != String
    @state = val
  end
  
  def details=(val)
    return if val.class != String
    @details = val
  end
  
  def timestamp_start=(val)
    return if val.class != Integer
    @timestamp_start = val
  end
  
  def timestamp_end=(val)
    return if val.class != Integer
    @timestamp_end = val
  end
  
  def large_image=(val)
    return if val.class != String
    @large_image = val
  end
  
  def small_image=(val)
    return if val.class != String
    @small_image = val
  end
  
  def large_image_text=(val)
    return if val.class != String
    @large_image_text = val
  end
  
  def small_image_text=(val)
    return if val.class != String
    @small_image_text = val
  end
  
  def party_size=(val)
    return if val.class != Integer
    @party_size = val
  end
  
  def party_max=(val)
    return if val.class != Integer
    @party_max = val
  end
end

module Graphics
  class << self
    alias oldUpdate update
  end
  
  def Graphics.update
    Graphics.oldUpdate
    $DiscordRPC.run_callbacks
  end
end

$DiscordRPC = DiscordAPI.new
$DiscordRPC.init(ID)
#===============================================================================
# Settings
#===============================================================================
module Settings
  #-----------------------------------------------------------------------------
  # You may set the text color of Pokemon titles to make them pop more when
  # displayed. 0 = Default color, 1 = Red, 2 = Blue, 3 = Green.
  #-----------------------------------------------------------------------------
  TITLE_COLORATION = 1
  
  #-----------------------------------------------------------------------------
  # When true, whenever a Pokemon gains a new memento, it will automatically
  # attach that memento to itself to gain its title. This will only occur if the
  # Pokemon doesn't already have a title set.
  #-----------------------------------------------------------------------------
  AUTO_SET_TITLES = true
  
  #-----------------------------------------------------------------------------
  # The base odds used to calculate the chance of a mark being generated on a
  # Pokemon. This number is used as a ratio, such as 1/50 chance. This number 
  # will scale based on the intended rarity of the mark.
  #-----------------------------------------------------------------------------
  BASE_MARK_GENERATION_RATIO = 50
  
  #-----------------------------------------------------------------------------
  # When true, the Mini/Jumbo Marks will always appear on wild Pokemon encountered
  # that match the size requirements of those respective marks. Note that this is 
  # not how these marks are obtained in the real games.
  #-----------------------------------------------------------------------------
  GUARANTEED_WILD_SIZE_MARKS = true
  
  #-----------------------------------------------------------------------------
  # When true, sets the default display of mementos viewed in the Summary to 
  # collapse lower-ranked mementos into their higher ranked versions, so that 
  # only the highest rank obtained will be visible. Set to false to show all 
  # mementos of all ranks by default.
  #-----------------------------------------------------------------------------
  COLLAPSE_RANKED_MEMENTOS = true
  
  #-----------------------------------------------------------------------------
  # The base X and Y coordinates used for displaying memento info on the Ribbons 
  # page in the Summary screen (page 5). The coordinates change based on whether
  # the BW Summary Screen plugin is present or not. Set these coordinates to your 
  # liking if you're using a custom Summary UI. (Default: [218, 74])
  #-----------------------------------------------------------------------------
  SUMMARY_MEMENTO_COORDS = (PluginManager.installed?("BW Summary Screen")) ? [-4, 70] : [218, 74]
end
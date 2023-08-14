#===============================================================================
# Selection sprite.
#===============================================================================
# Tweaks the selection sprite used for highlighting mementos in the Summary.
#-------------------------------------------------------------------------------
class RibbonSelectionSprite < MoveSelectionSprite
  def initialize(viewport = nil)
    super(viewport)
    if PluginManager.installed?("BW Summary Screen")
      @movesel = AnimatedBitmap.new("Graphics/Plugins/Improved Mementos/BW Summary/cursor")
    else
      @movesel = AnimatedBitmap.new("Graphics/Plugins/Improved Mementos/Summary/cursor")
    end
    @frame = 0
    @index = 0
    @preselected = false
    @updating = false
    @spriteVisible = true
    refresh
  end

  def visible=(value)
    super
    @spriteVisible = value if !@updating
  end

  def refresh
    w = @movesel.width
    h = @movesel.height / 2
    self.x = 12 + ((self.index % 6) * 82)
    self.y = 50 + ((self.index / 6).floor * 82)
    self.bitmap = @movesel.bitmap
    if self.preselected
      self.src_rect.set(0, h, w, h)
    else
      self.src_rect.set(0, 0, w, h)
    end
  end

  def update
    @updating = true
    super
    self.visible = @spriteVisible && @index >= 0 && @index < 12
    @movesel.update
    @updating = false
    refresh
  end
end
	

#===============================================================================
# Memento sprite.
#===============================================================================
# Used to draw the entire page of memento icons at once.
#-------------------------------------------------------------------------------
class MementoSprite < Sprite
  COLUMN_SIZE = 2
  ROW_SIZE    = 6
  PAGE_SIZE   = 12

  def initialize(mementos, offset, viewport = nil, active = nil)
    super(viewport)
    @active = mementos.length
    @memento_sprites = []
    path = "Graphics/Plugins/Improved Mementos/"
    (offset * ROW_SIZE...(offset * ROW_SIZE) + 12).each_with_index do |m, i|
      break if !mementos[m]
      data = GameData::Ribbon.get(mementos[m])
      icon = data.icon_position
      iconX = 12 + (82 * (i % ROW_SIZE))
      iconY = 46 + (82 * (i / ROW_SIZE).floor)
      if active == mementos[m]
        j = mementos.length
        @memento_sprites[j] = nil
        @memento_sprites[j] = IconSprite.new(0, 0, @viewport)
        if PluginManager.installed?("BW Summary Screen")
          @memento_sprites[j].setBitmap(path + "BW Summary/cursor_active")
        else
          @memento_sprites[j].setBitmap(path + "Summary/cursor_active")
        end
        @memento_sprites[j].x = iconX
        @memento_sprites[j].y = iconY + 4
        @memento_sprites[j].viewport = self.viewport
      end
      @memento_sprites[i] = nil
      @memento_sprites[i] = IconSprite.new(0, 0, @viewport)
      @memento_sprites[i].setBitmap(path + "mementos")
      @memento_sprites[i].x = iconX
      @memento_sprites[i].y = iconY
      @memento_sprites[i].src_rect.x = 78 * (icon % 8)
      @memento_sprites[i].src_rect.y = 78 * (icon / 8).floor
      @memento_sprites[i].src_rect.width = 78
      @memento_sprites[i].src_rect.height = 78
      @memento_sprites[i].viewport = self.viewport
    end
    @contents = BitmapWrapper.new(324, 296)
    self.bitmap = @contents
  end
  
  def dispose
    if !disposed?
      @memento_sprites.each do |s|
        s.dispose if s
        s = nil
      end
      @contents.dispose
      super
    end
  end
  
  def visible=(value)
    super
    @memento_sprites.each do |s|
      if s && !s.disposed?
        s.visible = value
      end
    end
  end
  
  def showActive=(value)
    sprite = @memento_sprites[@active]
    return if !sprite || sprite.disposed?
    sprite.visible = value
  end
  
  def getMemento(index)
    return @memento_sprites[index]
  end
  
  def update
    @memento_sprites.each { |s| s.update if s }
  end
end


#===============================================================================
# Summary UI.
#===============================================================================
# Tweaks visual display of mementos on Page 5 of the Summary.
#-------------------------------------------------------------------------------
class PokemonSummary_Scene
  alias memento_pbStartScene pbStartScene
  def pbStartScene(party, partyindex, inbattle = false)
    memento_pbStartScene(party, partyindex, inbattle)
    @sprites["uparrow"].x = (Graphics.width / 2) - 14
    @sprites["uparrow"].y = 30
    @sprites["downarrow"].x = (Graphics.width / 2) - 14
    @sprites["downarrow"].y = 184
  end

  def drawPageFive
    overlay = @sprites["overlay"].bitmap
    blkBase   = Color.new(64, 64, 64)
    blkShadow = Color.new(176, 176, 176)
    whtBase   = Color.new(248, 248, 248)
    whtShadow = Color.new(104, 104, 104)
    @sprites["uparrow"].visible   = false
    @sprites["downarrow"].visible = false
    path  = "Graphics/Plugins/Improved Mementos/"
    idnum = type = name = title = "---"
    memento_data = GameData::Ribbon.try_get(@pokemon.memento)
    xpos = Settings::SUMMARY_MEMENTO_COORDS[0]
    ypos = Settings::SUMMARY_MEMENTO_COORDS[1]
    folder = (PluginManager.installed?("BW Summary Screen")) ? "BW Summary/" : "Summary/"
    imagepos = [ [path + folder + "summary_bg", xpos, ypos] ]
    if memento_data
      icon  = memento_data.icon_position
      idnum = (icon + 1).to_s
      rank  = @pokemon.getMementoRank(@pokemon.memento)
      name  = memento_data.name
      title = "'#{memento_data.title_upcase}'"
      type  = (memento_data.is_ribbon?) ? "Ribbon" : "Mark"
      typeX = (memento_data.is_ribbon?) ? 184 : 194
      imagepos.push([path + "mementos", xpos + 12, ypos + 14, 78 * (icon % 8), 78 * (icon / 8).floor, 78, 78],
                    [path + "memento_icon", xpos + typeX, ypos + 7, (memento_data.is_ribbon?) ? 0 : 28, 0, 28, 28])
      if rank < 5
        rank.times do |i| 
          offset = (rank == 1) ? 44 : (rank == 2) ? 35 : (rank == 3) ? 26 : 17
          imagepos.push([path + "memento_rank", xpos + 182 + offset + (18 * i), ypos + 77])
        end
      else
        imagepos.push([path + "memento_rank", xpos + 246, ypos + 77])
      end
    end
    pbDrawImagePositions(overlay, imagepos)
    textpos = [
      [_INTL("Type:"),            xpos + 104, ypos + 12,  0, whtBase, whtShadow],
      [_INTL("ID No.:"),          xpos + 104, ypos + 44,  0, whtBase, whtShadow],
      [_INTL("#{idnum}"),         xpos + 234, ypos + 44,  2, blkBase, blkShadow],
      [_INTL("Rank:"),            xpos + 104, ypos + 76,  0, whtBase, whtShadow],
      [_INTL("Name:"),            xpos + 145, ypos + 116, 2, whtBase, whtShadow],
      [_INTL("#{name}"),          xpos + 145, ypos + 148, 2, blkBase, blkShadow],
      [_INTL("Title Conferred:"), xpos + 145, ypos + 190, 2, whtBase, whtShadow],
      [_INTL("#{title}"),         xpos + 145, ypos + 222, 2, blkBase, blkShadow],
      [_INTL("Change memento:"),  xpos + 212, ypos + 268, 1, whtBase, whtShadow]
    ]
    if memento_data
      typeX = (memento_data.is_ribbon?) ? 213 : 228
      textpos.push([_INTL("#{type}"), xpos + typeX, ypos + 12, 0, blkBase, blkShadow])
      textpos.push([_INTL("#{rank}"), xpos + 240, ypos + 76, 1, blkBase, blkShadow]) if rank > 4
    else
      textpos.push([_INTL("#{type}"), xpos + 232, ypos + 12, 2, blkBase, blkShadow])
    end
    pbDrawTextPositions(overlay, textpos)
  end
  
  def drawSelectedRibbon(ribbonid, filter, index)
    overlay = @sprites["overlay"].bitmap
    base   = Color.new(64, 64, 64)
    shadow = Color.new(176, 176, 176)
    nameBase   = Color.new(248, 248, 248)
    nameShadow = Color.new(104, 104, 104)
    path = "Graphics/Plugins/Improved Mementos/"
    memento_data = GameData::Ribbon.try_get(ribbonid)
    rank  = @pokemon.getMementoRank(ribbonid)
    name  = (memento_data) ? memento_data.name : "---"
    desc  = (memento_data) ? memento_data.description : ""
    count = (memento_data) ? "#{index + 1}/#{filter.length}" : ""
    title = (memento_data && memento_data.title) ? "'#{memento_data.title_upcase}'" : "---"
    imagepos = []
    if PluginManager.installed?("BW Summary Screen")
      imagepos.push([path + "BW Summary/overlay", 0, 0])
    else
      imagepos.push([path + "Summary/overlay", 0, 0])
    end
    imagepos.push([path + "memento_active", 36, 226]) if !ribbonid.nil? && ribbonid == @pokemon.memento
    imagepos.push([path + "memento_icon", 8, 8, (memento_data.is_ribbon?) ? 0 : 28, 0, 28, 28]) if memento_data
    if rank < 5
      rank.times do |i| 
        offset = (rank == 1) ? 44 : (rank == 2) ? 35 : (rank == 3) ? 26 : 17
        imagepos.push([path + "memento_rank", 416 + offset + (18 * i), 226])
      end
    else
      imagepos.push([path + "memento_rank", 480, 226])
    end
    pbDrawImagePositions(overlay, imagepos)
    @sprites["mementos"].dispose if @sprites["mementos"]
    @sprites["mementos"] = MementoSprite.new(filter, @ribbonOffset, @viewport, @pokemon.memento)
    textpos = [
      [_INTL("#{count}"), 210, 12, 1, nameBase, nameShadow],
      [name, Graphics.width / 2, 224, 2, nameBase, nameShadow],
      [_INTL("Title Conferred:"), 10, 260, 0, base, shadow],
      [title, 346, 260, 2, base, shadow]
    ]
    if memento_data
      case @mementoFilter
      when :ribbon   then header = "Ribbon"
      when :mark     then header = "Mark"
      when :contest  then header = "Contest"
      when :league   then header = "League"
      when :frontier then header = "Frontier"
      when :memorial then header = "Memorial"
      when :gift     then header = "Special"
      else                header = "Memento"
      end
      textpos.push([_INTL("#{header}"), 40, 12, 0, nameBase, nameShadow])
      textpos.push([_INTL("#{rank}"), 476, 224, 1, nameBase, nameShadow]) if rank > 4
    end
    pbDrawTextPositions(overlay, textpos)
    drawTextEx(overlay, 10, 292, 494, 3, desc, base, shadow)
  end
  
  def pbFilteredMementos
    filter = []
    case @mementoFilter
    when :rank     then return @pokemon.collapsed_mementos                                                          # Shows only collapsed mementos
    when :ribbon   then @pokemon.ribbons.each { |m| filter.push(m) if GameData::Ribbon.get(m).is_ribbon? }          # Shows only Ribbons
    when :mark     then @pokemon.ribbons.each { |m| filter.push(m) if GameData::Ribbon.get(m).is_mark? }            # Shows only Marks
    when :contest  then @pokemon.ribbons.each { |m| filter.push(m) if GameData::Ribbon.get(m).is_contest_ribbon? }  # Shows only Contest Ribbons
    when :league   then @pokemon.ribbons.each { |m| filter.push(m) if GameData::Ribbon.get(m).is_league_ribbon? }   # Shows only League Ribbons
    when :frontier then @pokemon.ribbons.each { |m| filter.push(m) if GameData::Ribbon.get(m).is_frontier_ribbon? } # Shows only Frontier Ribbons
    when :memorial then @pokemon.ribbons.each { |m| filter.push(m) if GameData::Ribbon.get(m).is_memorial_ribbon? } # Shows only Memorial Ribbons
    when :gift     then @pokemon.ribbons.each { |m| filter.push(m) if GameData::Ribbon.get(m).is_gift_ribbon? }     # Shows only Special Ribbons
    else           return @pokemon.ribbons                                                                          # Shows all mementos
    end
    return filter
  end
  
  def pbConferTitle(memento)
    memento_data = GameData::Ribbon.get(memento)
    if memento_data.title
      if @mementoFilter == :rank
        allRanks = memento_data.prev_ranks.clone
        allRanks.push(memento)
        last_title = nil
        allRanks.each_with_index do |r, i|
          title = GameData::Ribbon.get(r).title
          allRanks[i] = nil if !title || title == last_title
          last_title = title
        end
        allRanks.compact!
      end
      if @mementoFilter == :rank && allRanks.length > 1
        pbMessage(_INTL("This memento has multiple ranks.\nWhich title should be conferred?"))
        cmd = 0
        commands = []
        allRanks = allRanks.reverse
        allRanks.each { |r| commands.push(_INTL("{1}", GameData::Ribbon.get(r).title_upcase)) }
        commands.push(_INTL("Cancel"))
        loop do
          cmd = pbShowCommands(commands, 0)
          break if cmd < 0 || cmd >= commands.length - 1
          case @pokemon.memento
          when allRanks[cmd]
            pbMessage(_INTL("{1} has already been conferred with this title...", @pokemon.name))
            if pbConfirmMessage(_INTL("Would you like to remove this attached memento from {1}?", @pokemon.name))
              @pokemon.memento = nil
              pbMessage(_INTL("{1}'s memento and any associated titles were removed.", @pokemon.name))
              return true
            end
          else
            @pokemon.memento = allRanks[cmd]
            pbMessage(_INTL("{1} will now be known as\n{2}!", @pokemon.name, @pokemon.name_title))
            return true
          end
        end
      else
        case @pokemon.memento
        when memento
          pbMessage(_INTL("{1} has already been conferred with this title...", @pokemon.name))
          if pbConfirmMessage(_INTL("Would you like to remove this attached memento from {1}?", @pokemon.name))
            @pokemon.memento = nil
            pbMessage(_INTL("{1}'s memento and any associated titles were removed.", @pokemon.name)) 
            return true
          end
        else
          if pbConfirmMessage(_INTL("Would you like to attach this memento and confer its title to {1}?", @pokemon.name))
            @pokemon.memento = memento
            pbMessage(_INTL("{1} will now be known as\n{2}!", @pokemon.name, @pokemon.name_title)) 
            return true
          end
        end
      end
    else
      pbMessage(_INTL("This memento doesn't have any associated title to confer...")) 
    end
    return false
  end
  
  def pbRibbonSelection
    switching = false
    endscreen = false
    @sprites["ribbonsel"].visible = true
    @sprites["ribbonsel"].index   = 0
    @mementoFilter = (Settings::COLLAPSE_RANKED_MEMENTOS) ? :rank : nil
    filter = pbFilteredMementos
    numMementos = filter.length
    numRows    = [((numMementos + 5) / 6).floor, 2].max
    if filter.include?(@pokemon.memento)
      selribbon = filter.index(@pokemon.memento)
      oldselribbon = selribbon
      @ribbonOffset = (selribbon / 6).floor if selribbon < @ribbonOffset * 6
      @ribbonOffset = (selribbon / 6).floor - 1 if selribbon >= (@ribbonOffset + 1) * 6
      @ribbonOffset = 0 if @ribbonOffset < 0
      @ribbonOffset = numRows - 2 if @ribbonOffset > numRows - 2
      @sprites["ribbonsel"].index    = selribbon - (@ribbonOffset * 6)
      @sprites["ribbonpresel"].index = oldselribbon - (@ribbonOffset * 6)
    else
      @ribbonOffset = 0
      selribbon = @ribbonOffset * 6
      oldselribbon = selribbon
    end
    drawSelectedRibbon(filter[selribbon], filter, selribbon)
    @sprites["uparrow"].z = @sprites["mementos"].z + 1
    @sprites["downarrow"].z = @sprites["mementos"].z + 1
    loop do
      @sprites["uparrow"].visible   = (@ribbonOffset > 0)
      @sprites["downarrow"].visible = (@ribbonOffset < numRows - 2)
      Graphics.update
      Input.update
      pbUpdate
      if filter[selribbon] == @pokemon.memento
        @sprites["mementos"].showActive = false
      else
        @sprites["mementos"].showActive = true
      end
      if @sprites["ribbonpresel"].index == @sprites["ribbonsel"].index
        @sprites["ribbonpresel"].z = @sprites["ribbonsel"].z + 1
      else
        @sprites["ribbonpresel"].z = @sprites["ribbonsel"].z
      end
      hasMovedCursor = false
      if Input.trigger?(Input::BACK)
        (switching) ? pbPlayCancelSE : pbPlayCloseMenuSE
        break if !switching
        @sprites["ribbonpresel"].visible = false
        switching = false
      elsif Input.trigger?(Input::USE)
        if switching
          pbPlayDecisionSE
          tmpribbon                      = @pokemon.ribbons[oldselribbon]
          @pokemon.ribbons[oldselribbon] = @pokemon.ribbons[selribbon]
          @pokemon.ribbons[selribbon]    = tmpribbon
          if @pokemon.ribbons[oldselribbon] || @pokemon.ribbons[selribbon]
            @pokemon.ribbons.compact!
            if selribbon >= numMementos
              selribbon = numMementos - 1
              hasMovedCursor = true
            end
          end
          @sprites["ribbonpresel"].visible = false
          switching = false
          drawSelectedRibbon(filter[selribbon], filter, selribbon)
        else
          pbPlayDecisionSE
          commands = []
          commands.push(_INTL("Move")) if !@mementoFilter && filter[selribbon]
          commands.push(_INTL("Confer title")) if !@inbattle && filter[selribbon] && !@pokemon.shadowPokemon?
          commands.push(_INTL("Remove title")) if !@inbattle && @pokemon.memento
          commands.push(_INTL("Sort mementos"), _INTL("Cancel"))
          loop do
            cmd = pbShowCommands(commands, 0)
            break if cmd < 0 || cmd >= commands.length - 1
            case commands[cmd]
            when _INTL("Move")
              @sprites["ribbonpresel"].index = selribbon - (@ribbonOffset * 6)
              oldselribbon = selribbon
              @sprites["ribbonpresel"].visible = true
              switching = true
              break
            when _INTL("Confer title")
              if pbConferTitle(filter[selribbon])
                endscreen = true
                break 
              end
            when _INTL("Remove title")
              if pbConfirmMessage(_INTL("Would you like to remove {1}'s attached memento and conferred title?", @pokemon.name))
                @pokemon.memento = nil
                pbMessage(_INTL("{1}'s memento and any associated titles were removed.", @pokemon.name))
                endscreen = true
                break
              end
            when _INTL("Sort mementos")
              sorted = []
              sort_commands = []
              [:rank, :ribbon, :mark, :contest, :league, :frontier, :memorial, :gift].each do |check|
                next if !@pokemon.hasMementoType?(check)
                sorted.push(check)
                case check
                when :rank     then sort_commands.push(_INTL("Only highest rank"))
                when :ribbon   then sort_commands.push(_INTL("Only ribbons"))
                when :mark     then sort_commands.push(_INTL("Only marks"))
                when :contest  then sort_commands.push(_INTL("Only contest ribbons"))
                when :league   then sort_commands.push(_INTL("Only league ribbons"))
                when :frontier then sort_commands.push(_INTL("Only frontier ribbons"))
                when :memorial then sort_commands.push(_INTL("Only memorial ribbons"))
                when :gift     then sort_commands.push(_INTL("Only special ribbons"))
                end
              end
              sort_commands.push(_INTL("All mementos"), _INTL("Cancel"))
              sort_cmd = pbShowCommands(sort_commands, 0)
              if sort_cmd >= 0 && sort_cmd < sort_commands.length - 1 && sorted[sort_cmd] != @mementoFilter
                @sprites["ribbonsel"].index = 0
                selribbon = @ribbonOffset = 0
                oldselribbon = selribbon
                @mementoFilter = sorted[sort_cmd]
                filter = pbFilteredMementos
                numMementos = filter.length
                numRows = [((numMementos + 5) / 6).floor, 2].max
                drawSelectedRibbon(filter[selribbon], filter, selribbon)
                break
              end
            end
          end
        end
      elsif Input.repeat?(Input::UP)
        selribbon -= 6
        selribbon += numRows * 6 if selribbon < 0
        hasMovedCursor = true
        pbPlayCursorSE
      elsif Input.repeat?(Input::DOWN)
        selribbon += 6
        selribbon -= numRows * 6 if selribbon >= numRows * 6
        hasMovedCursor = true
        pbPlayCursorSE
      elsif Input.repeat?(Input::LEFT)
        selribbon -= 1
        selribbon += 6 if selribbon % 6 == 5
        hasMovedCursor = true
        pbPlayCursorSE
      elsif Input.repeat?(Input::RIGHT)
        selribbon += 1
        selribbon -= 6 if selribbon % 6 == 0
        hasMovedCursor = true
        pbPlayCursorSE
      elsif Input.trigger?(Input::JUMPUP) && selribbon != 0
        selribbon = 0
        hasMovedCursor = true
        pbPlayCursorSE
      elsif Input.trigger?(Input::JUMPDOWN) && selribbon != filter.length - 1
        selribbon = filter.length - 1
        hasMovedCursor = true
        pbPlayCursorSE
      elsif Input.trigger?(Input::ACTION) && filter.include?(@pokemon.memento)
        if selribbon != filter.index(@pokemon.memento)
          selribbon = filter.index(@pokemon.memento)
          hasMovedCursor = true
          pbPlayCursorSE
        end
      end
      break if endscreen
      next if !hasMovedCursor
      @ribbonOffset = (selribbon / 6).floor if selribbon < @ribbonOffset * 6
      @ribbonOffset = (selribbon / 6).floor - 1 if selribbon >= (@ribbonOffset + 1) * 6
      @ribbonOffset = 0 if @ribbonOffset < 0
      @ribbonOffset = numRows - 2 if @ribbonOffset > numRows - 2
      @sprites["ribbonsel"].index    = selribbon - (@ribbonOffset * 6)
      @sprites["ribbonpresel"].index = oldselribbon - (@ribbonOffset * 6)
      drawSelectedRibbon(filter[selribbon], filter, selribbon)
    end
    @sprites["ribbonsel"].visible = false
    @sprites["mementos"].dispose if @sprites["mementos"]
  end
end
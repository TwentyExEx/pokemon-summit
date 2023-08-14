#===============================================================================
# Memento data.
#===============================================================================
# Edits GameData::Ribbon to include data for Marks, Titles, and related flags.
#-------------------------------------------------------------------------------
module GameData
  class Ribbon
    attr_reader :title, :prev_ranks
	
    SCHEMA["Title"]         = [:title, "s"]
    SCHEMA["PreviousRanks"] = [:prev_ranks, "*e", :Ribbon]
    SCHEMA["IsMark"]        = [:mark,  "b"]
	
    extend ClassMethodsSymbols
    include InstanceMethods
	
    alias dx_initialize initialize
    def initialize(hash)
      dx_initialize(hash)
      @title      = hash[:title]
      @prev_ranks = hash[:prev_ranks] || []
      @mark       = hash[:mark]
    end
	
    def title
      return if !@title
      return pbGetMessageFromHash(MessageTypes::MementoTitles, @title)
    end
	
    def title_upcase
      return if !@title
      title = pbGetMessageFromHash(MessageTypes::MementoTitles, @title)
      return _INTL("#{title.first.upcase + title[1..title.length]}")
    end
    
    def max_rank
      return 1 + @prev_ranks.length
    end
	  
    #---------------------------------------------------------------------------
    # Flag checks.
    #---------------------------------------------------------------------------
    def is_ribbon?;           return !@mark; end
    def is_contest_ribbon?;   return has_flag?("ContestRibbon");   end
    def is_league_ribbon?;    return has_flag?("LeagueRibbon");    end
    def is_frontier_ribbon?;  return has_flag?("FrontierRibbon");  end
    def is_memorial_ribbon?;  return has_flag?("MemorialRibbon");  end
    def is_gift_ribbon?;      return has_flag?("GiftRibbon");      end
    
    def is_mark?;             return @mark; end
    def is_rarity_mark?;      return has_flag?("RarityMark");      end
    def is_encounter_mark?;   return has_flag?("EncounterMark");   end
    def is_time_mark?;        return has_flag?("TimeMark");        end
    def is_weather_mark?;     return has_flag?("WeatherMark");     end
    def is_personality_mark?; return has_flag?("PersonalityMark"); end
    def is_size_mark?;        return has_flag?("SizeMark");        end
    def is_party_mark?;       return has_flag?("PartyMark");       end
    def is_boss_mark?;        return has_flag?("BossMark");        end
  end
end


#===============================================================================
# Pokemon data.
#===============================================================================
# Adds data for titles on individual Pokemon, and improves ribbon code.
#-------------------------------------------------------------------------------
class Pokemon
  attr_accessor :memento
  
  #-----------------------------------------------------------------------------
  # Returns the Pokemon's name & title as a colorized string.
  #-----------------------------------------------------------------------------
  def name_title
    name = self.name
    if @memento && !shadowPokemon?
      memento = GameData::Ribbon.get(@memento)
      title = (memento.title) ? " #{memento.title}" : ""
      return name if !title
      case Settings::TITLE_COLORATION
      when 1 then name = "<c2=043c3aff>#{name + title}</c2>"
      when 2 then name = "<c2=06644bd2>#{name + title}</c2>"
      when 3 then name = "<c2=65467b14>#{name + title}</c2>"
      else        name = "'#{name + title}'"
      end
    end
    return name
  end
  
  #-----------------------------------------------------------------------------
  # Attaches a memento on a Pokemon to confer its title.
  #-----------------------------------------------------------------------------
  def memento=(value)
    return if shadowPokemon?
    memento = GameData::Ribbon.try_get(value)
    @memento = value if value.nil? || (memento && memento.title)
    giveMemento(value) if !@ribbons.include?(value) && @memento == value
  end
  
  #-----------------------------------------------------------------------------
  # Gets a collapsed array of the Pokemon's mementos.
  #-----------------------------------------------------------------------------
  def collapsed_mementos
    mementos = @ribbons.clone
    @ribbons.each_with_index do |r, i|
      prev_ranks = GameData::Ribbon.get(r).prev_ranks
      next if prev_ranks.empty?
      prev_ranks.each { |p| mementos.delete(p) if mementos.include?(p)}
    end
    return mementos
  end
  
  #-----------------------------------------------------------------------------
  # Checks if the Pokemon has any memento of a given type or ID.
  #-----------------------------------------------------------------------------
  def hasMementoType?(filter = nil)
    @ribbons.each do |m|
      memento = GameData::Ribbon.get(m)
      case filter
      when :rank        then return true if memento.max_rank > 1
      when :ribbon      then return true if memento.is_ribbon?
      when :contest     then return true if memento.is_contest_ribbon?
      when :league      then return true if memento.is_league_ribbon?
      when :frontier    then return true if memento.is_frontier_ribbon?
      when :memorial    then return true if memento.is_memorial_ribbon?
      when :gift        then return true if memento.is_gift_ribbon?
      when :mark        then return true if memento.is_mark?
      when :rarity      then return true if memento.is_rarity_mark?
      when :size        then return true if memento.is_size_mark?
      when :time        then return true if memento.is_time_mark?
      when :weather     then return true if memento.is_weather_mark?
      when :personality then return true if memento.is_personality_mark?
      when :boss        then return true if memento.is_boss_mark?
      when Symbol       then return true if memento.id == m
      else              return false
      end
    end
    return false
  end
  
  #-----------------------------------------------------------------------------
  # Gets the current rank of a given memento.
  #-----------------------------------------------------------------------------
  def getMementoRank(memento)
    memento_data = GameData::Ribbon.try_get(memento)
    return 0 if !memento_data
    rank = 1
    memento_data.prev_ranks.each { |p| rank += 1 if @ribbons.include?(p) }
    return [rank, memento_data.max_rank].min
  end
  
  #-----------------------------------------------------------------------------
  # Used for properly giving the Contest Memory and Battle Memory Ribbons.
  #-----------------------------------------------------------------------------
  def giveMemoryRibbon(memento)
    return if !memento
    if memento.is_contest_ribbon?
      if !@ribbons.include?(:CONTESTMEMORYGOLD)
        ranks = GameData::Ribbon.get(:CONTESTMEMORYGOLD).prev_ranks
        if ranks.include?(memento.id)
          max_rank = GameData::Ribbon.get(:CONTESTMEMORYGOLD).max_rank
          if getMementoRank(:CONTESTMEMORYGOLD) >= max_rank
            index = @ribbons.index(:CONTESTMEMORY) || @ribbons.length
            @ribbons[index] = :CONTESTMEMORYGOLD
          else
            index = @ribbons.index(memento.id)
            @ribbons.insert(index, :CONTESTMEMORY) if !@ribbons.include?(:CONTESTMEMORY)
          end
        end
      end
    elsif memento.is_frontier_ribbon?
      if !@ribbons.include?(:BATTLEMEMORYGOLD)
        ranks = GameData::Ribbon.get(:BATTLEMEMORYGOLD).prev_ranks
        if ranks.include?(memento.id)
          max_rank = GameData::Ribbon.get(:BATTLEMEMORYGOLD).max_rank
          if getMementoRank(:BATTLEMEMORYGOLD) >= max_rank
            index = @ribbons.index(:BATTLEMEMORY) || @ribbons.length
            @ribbons[index] = :BATTLEMEMORYGOLD
          else
            index = @ribbons.index(memento.id)
            @ribbons.insert(index, :BATTLEMEMORY) if !@ribbons.include?(:BATTLEMEMORY)
          end
        end
      end
    end
  end
  
  #-----------------------------------------------------------------------------
  # Aliases & edits of existing Ribbon code.
  #-----------------------------------------------------------------------------
  alias numMementos numRibbons
  alias hasMemento? hasRibbon?
  alias upgradeMemento upgradeRibbon
  
  def giveRibbon(ribbon)
    case ribbon
    when :CONTESTMEMORY then return if @ribbons.include?(:CONTESTMEMORYGOLD)
    when :BATTLEMEMORY  then return if @ribbons.include?(:BATTLEMEMORYGOLD)
    end
    ribbon_data = GameData::Ribbon.try_get(ribbon)
    return if !ribbon_data || @ribbons.include?(ribbon_data.id)
    @ribbons.push(ribbon_data.id)
    giveMemoryRibbon(ribbon_data)
    if Settings::AUTO_SET_TITLES && !@memento && ribbon_data.title
      @memento = ribbon 
    end
  end
  alias giveMemento giveRibbon
  
  def takeRibbon(ribbon)
    ribbon_data = GameData::Ribbon.try_get(ribbon)
    return if !ribbon_data
    @ribbons.delete_at(@ribbons.index(ribbon_data.id))
    @memento = nil if @memento == ribbon
  end
  alias takeMemento takeRibbon
  
  def clearAllRibbons
    @ribbons.clear
    @memento = nil
  end
  alias clearAllMementos clearAllRibbons
end

#-------------------------------------------------------------------------------
# Returns a battler's colorized name & title. Takes Illusion into account.
#-------------------------------------------------------------------------------
class Battle::Battler
  def name_title
    return displayPokemon.name_title
  end
end
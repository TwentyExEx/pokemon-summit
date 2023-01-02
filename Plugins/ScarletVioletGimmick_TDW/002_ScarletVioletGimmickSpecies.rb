module GameData
  class Species

    attr_reader :tera_types_available 

    DATA = {}
    DATA_FILENAME = "species.dat"

    extend ClassMethodsSymbols
    include InstanceMethods

    # @param species [Symbol, self, String]
    # @param form [Integer]
    # @return [self, nil]
    def self.get_species_form(species, form)
      return nil if !species || !form
      validate species => [Symbol, self, String]
      validate form => Integer
      species = species.species if species.is_a?(self)
      species = species.to_sym if species.is_a?(String)
      trial = sprintf("%s_%d", species, form).to_sym
      species_form = (DATA[trial].nil?) ? species : trial
      return (DATA.has_key?(species_form)) ? DATA[species_form] : nil
    end

    def self.each_species
      DATA.each_value { |species| yield species if species.form == 0 }
    end

    def self.species_count
      ret = 0
      self.each_species { |species| ret += 1 }
      return ret
    end

    def self.schema(compiling_forms = false)
      ret = {
        "FormName"          => [0, "q"],
        "Category"          => [0, "s"],
        "Pokedex"           => [0, "q"],
        "Types"             => [0, "eE", :Type, :Type],
        "TeraTypes"         => [0, "*e", :Type], #TDW Tera
        "BaseStats"         => [0, "vvvvvv"],
        "EVs"               => [0, "*ev", :Stat],
        "BaseExp"           => [0, "v"],
        "CatchRate"         => [0, "u"],
        "Happiness"         => [0, "u"],
        "Moves"             => [0, "*ue", nil, :Move],
        "TutorMoves"        => [0, "*e", :Move],
        "EggMoves"          => [0, "*e", :Move],
        "Abilities"         => [0, "*e", :Ability],
        "HiddenAbilities"   => [0, "*e", :Ability],
        "WildItemCommon"    => [0, "*e", :Item],
        "WildItemUncommon"  => [0, "*e", :Item],
        "WildItemRare"      => [0, "*e", :Item],
        "EggGroups"         => [0, "*e", :EggGroup],
        "HatchSteps"        => [0, "v"],
        "Height"            => [0, "f"],
        "Weight"            => [0, "f"],
        "Color"             => [0, "e", :BodyColor],
        "Shape"             => [0, "e", :BodyShape],
        "Habitat"           => [0, "e", :Habitat],
        "Generation"        => [0, "i"],
        "Flags"             => [0, "*s"],
        "BattlerPlayerX"    => [0, "i"],
        "BattlerPlayerY"    => [0, "i"],
        "BattlerEnemyX"     => [0, "i"],
        "BattlerEnemyY"     => [0, "i"],
        "BattlerAltitude"   => [0, "i"],
        "BattlerShadowX"    => [0, "i"],
        "BattlerShadowSize" => [0, "u"]
      }
      if compiling_forms
        ret["PokedexForm"]  = [0, "u"]
        ret["Offspring"]    = [0, "*e", :Species]
        ret["Evolutions"]   = [0, "*ees", :Species, :Evolution, nil]
        ret["MegaStone"]    = [0, "e", :Item]
        ret["MegaMove"]     = [0, "e", :Move]
        ret["UnmegaForm"]   = [0, "u"]
        ret["MegaMessage"]  = [0, "u"]
      else
        ret["InternalName"] = [0, "n"]
        ret["Name"]         = [0, "s"]
        ret["GrowthRate"]   = [0, "e", :GrowthRate]
        ret["GenderRatio"]  = [0, "e", :GenderRatio]
        ret["Incense"]      = [0, "e", :Item]
        ret["Offspring"]    = [0, "*s"]
        ret["Evolutions"]   = [0, "*ses", nil, :Evolution, nil]
      end
      return ret
    end

    def initialize(hash)
      @id                 = hash[:id]
      @species            = hash[:species]            || @id
      @form               = hash[:form]               || 0
      @real_name          = hash[:name]               || "Unnamed"
      @real_form_name     = hash[:form_name]
      @real_category      = hash[:category]           || "???"
      @real_pokedex_entry = hash[:pokedex_entry]      || "???"
      @pokedex_form       = hash[:pokedex_form]       || @form
      @types              = hash[:types]              || [:NORMAL]
	  @tera_types_available = hash[:tera_types_available] || nil #TDW added
      @base_stats         = hash[:base_stats]         || {}
      @evs                = hash[:evs]                || {}
      GameData::Stat.each_main do |s|
        @base_stats[s.id] = 1 if !@base_stats[s.id] || @base_stats[s.id] <= 0
        @evs[s.id]        = 0 if !@evs[s.id] || @evs[s.id] < 0
      end
      @base_exp           = hash[:base_exp]           || 100
      @growth_rate        = hash[:growth_rate]        || :Medium
      @gender_ratio       = hash[:gender_ratio]       || :Female50Percent
      @catch_rate         = hash[:catch_rate]         || 255
      @happiness          = hash[:happiness]          || 70
      @moves              = hash[:moves]              || []
      @tutor_moves        = hash[:tutor_moves]        || []
      @egg_moves          = hash[:egg_moves]          || []
      @abilities          = hash[:abilities]          || []
      @hidden_abilities   = hash[:hidden_abilities]   || []
      @wild_item_common   = hash[:wild_item_common]   || []
      @wild_item_uncommon = hash[:wild_item_uncommon] || []
      @wild_item_rare     = hash[:wild_item_rare]     || []
      @egg_groups         = hash[:egg_groups]         || [:Undiscovered]
      @hatch_steps        = hash[:hatch_steps]        || 1
      @incense            = hash[:incense]
      @offspring          = hash[:offspring]          || []
      @evolutions         = hash[:evolutions]         || []
      @height             = hash[:height]             || 1
      @weight             = hash[:weight]             || 1
      @color              = hash[:color]              || :Red
      @shape              = hash[:shape]              || :Head
      @habitat            = hash[:habitat]            || :None
      @generation         = hash[:generation]         || 0
      @flags              = hash[:flags]              || []
      @mega_stone         = hash[:mega_stone]
      @mega_move          = hash[:mega_move]
      @unmega_form        = hash[:unmega_form]        || 0
      @mega_message       = hash[:mega_message]       || 0
    end
  end
end


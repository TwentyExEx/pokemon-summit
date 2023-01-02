module Compiler  
module_function
  def compile_pokemon(path = "PBS/pokemon.txt")
    compile_pbs_file_message_start(path)
    GameData::Species::DATA.clear
    species_names           = []
    species_form_names      = []
    species_categories      = []
    species_pokedex_entries = []
    # Read from PBS file
    File.open(path, "rb") { |f|
      FileLineData.file = path   # For error reporting
      # Read a whole section's lines at once, then run through this code.
      # contents is a hash containing all the XXX=YYY lines in that section, where
      # the keys are the XXX and the values are the YYY (as unprocessed strings).
      schema = GameData::Species.schema
      idx = 0
      pbEachFileSection(f) { |contents, species_id|
        echo "." if idx % 50 == 0
        idx += 1
        Graphics.update if idx % 250 == 0
        FileLineData.setSection(species_id, "header", nil)   # For error reporting
        contents["InternalName"] = species_id if !species_id[/^\d+/]
        # Ensure all required properties have been defined, and raise an error
        # if not
        schema.each_key do |key|
          next if !nil_or_empty?(contents[key])
          if ["Name", "InternalName"].include?(key)
            raise _INTL("The entry {1} is required in {2} section {3}.", key, path, species_id)
          end
          contents[key] = nil
        end
        # Raise an error if a species ID is used twice
        if GameData::Species::DATA[contents["InternalName"].to_sym]
          raise _INTL("Species ID '{1}' is used twice.\r\n{2}", contents["InternalName"], FileLineData.linereport)
        end
        # Go through schema hash of compilable data and compile this section
        schema.each_key do |key|
          next if nil_or_empty?(contents[key])
          FileLineData.setSection(species_id, key, contents[key])   # For error reporting
          # Compile value for key
          if ["EVs", "EffortPoints"].include?(key) && contents[key].split(",")[0].numeric?
            value = pbGetCsvRecord(contents[key], key, [0, "uuuuuu"])   # Old format
          else
            value = pbGetCsvRecord(contents[key], key, schema[key])
          end
          value = nil if value.is_a?(Array) && value.empty?
          contents[key] = value
          # Sanitise data
          case key
          when "BaseStats"
            value_hash = {}
            GameData::Stat.each_main do |s|
              value_hash[s.id] = value[s.pbs_order] if s.pbs_order >= 0
            end
            contents[key] = value_hash
          when "EVs", "EffortPoints"
            if value[0].is_a?(Array)   # New format
              value_hash = {}
              value.each { |val| value_hash[val[0]] = val[1] }
              GameData::Stat.each_main { |s| value_hash[s.id] ||= 0 }
              contents[key] = value_hash
            else   # Old format
              value_hash = {}
              GameData::Stat.each_main do |s|
                value_hash[s.id] = value[s.pbs_order] if s.pbs_order >= 0
              end
              contents[key] = value_hash
            end
          when "Height", "Weight"
            # Convert height/weight to 1 decimal place and multiply by 10
            value = (value * 10).round
            if value <= 0
              raise _INTL("Value for '{1}' can't be less than or close to 0 (section {2}, {3})", key, species_id, path)
            end
            contents[key] = value
          when "Evolutions"
            contents[key].each { |evo| evo[3] = false }
          end
        end
        # Construct species hash
        types = contents["Types"] || [contents["Type1"], contents["Type2"]]
        types = [types] if !types.is_a?(Array)
        types = types.uniq.compact
        species_hash = {
          :id                 => contents["InternalName"].to_sym,
          :name               => contents["Name"],
          :form_name          => contents["FormName"],
          :category           => contents["Category"] || contents["Kind"],
          :pokedex_entry      => contents["Pokedex"],
          :types              => types,
		  :tera_types_available => contents["TeraTypes"], #TDW added
          :base_stats         => contents["BaseStats"],
          :evs                => contents["EVs"] || contents["EffortPoints"],
          :base_exp           => contents["BaseExp"] || contents["BaseEXP"],
          :growth_rate        => contents["GrowthRate"],
          :gender_ratio       => contents["GenderRatio"] || contents["GenderRate"],
          :catch_rate         => contents["CatchRate"] || contents["Rareness"],
          :happiness          => contents["Happiness"],
          :moves              => contents["Moves"],
          :tutor_moves        => contents["TutorMoves"],
          :egg_moves          => contents["EggMoves"],
          :abilities          => contents["Abilities"],
          :hidden_abilities   => contents["HiddenAbilities"] || contents["HiddenAbility"],
          :wild_item_common   => contents["WildItemCommon"],
          :wild_item_uncommon => contents["WildItemUncommon"],
          :wild_item_rare     => contents["WildItemRare"],
          :egg_groups         => contents["EggGroups"] || contents["Compatibility"],
          :hatch_steps        => contents["HatchSteps"] || contents["StepsToHatch"],
          :incense            => contents["Incense"],
          :offspring          => contents["Offspring"],
          :evolutions         => contents["Evolutions"],
          :height             => contents["Height"],
          :weight             => contents["Weight"],
          :color              => contents["Color"],
          :shape              => contents["Shape"],
          :habitat            => contents["Habitat"],
          :generation         => contents["Generation"],
          :tera_types_available => contents["TeraTypes"]&.uniq&.compact, #TDW Tera
          :flags              => contents["Flags"]
        }
        # Add species' data to records
        GameData::Species.register(species_hash)
        species_names.push(species_hash[:name])
        species_form_names.push(species_hash[:form_name])
        species_categories.push(species_hash[:category])
        species_pokedex_entries.push(species_hash[:pokedex_entry])
        # Save metrics data if defined (backwards compatibility)
        if contents["BattlerPlayerX"] || contents["BattlerPlayerY"] ||
           contents["BattlerEnemyX"] || contents["BattlerEnemyY"] ||
           contents["BattlerAltitude"] || contents["BattlerShadowX"] ||
           contents["BattlerShadowSize"]
          metrics_hash = {
            :id                    => contents["InternalName"].to_sym,
            :back_sprite           => [contents["BattlerPlayerX"] || 0, contents["BattlerPlayerY"] || 0],
            :front_sprite          => [contents["BattlerEnemyX"] || 0, contents["BattlerEnemyY"] || 0],
            :front_sprite_altitude => contents["BattlerAltitude"] || 0,
            :shadow_x              => contents["BattlerShadowX"] || 0,
            :shadow_size           => contents["BattlerShadowSize"] || 2
          }
          GameData::SpeciesMetrics.register(metrics_hash)
        end
      }
    }
    # Enumerate all offspring species (this couldn't be done earlier)
    GameData::Species.each do |species|
      FileLineData.setSection(species.id.to_s, "Offspring", nil)   # For error reporting
      offspring = species.offspring
      offspring.each_with_index do |sp, i|
        offspring[i] = csvEnumField!(sp, :Species, "Offspring", species.id)
      end
    end
    # Enumerate all evolution species and parameters (this couldn't be done earlier)
    GameData::Species.each do |species|
      FileLineData.setSection(species.id.to_s, "Evolutions", nil)   # For error reporting
      species.evolutions.each do |evo|
        evo[0] = csvEnumField!(evo[0], :Species, "Evolutions", species.id)
        param_type = GameData::Evolution.get(evo[1]).parameter
        if param_type.nil?
          evo[2] = nil
        elsif param_type == Integer
          evo[2] = csvPosInt!(evo[2])
        elsif param_type != String
          evo[2] = csvEnumField!(evo[2], param_type, "Evolutions", species.id)
        end
      end
    end
    # Add prevolution "evolution" entry for all evolved species
    all_evos = {}
    GameData::Species.each do |species|   # Build a hash of prevolutions for each species
      species.evolutions.each do |evo|
        all_evos[evo[0]] = [species.species, evo[1], evo[2], true] if !all_evos[evo[0]]
      end
    end
    GameData::Species.each do |species|   # Distribute prevolutions
      species.evolutions.push(all_evos[species.species].clone) if all_evos[species.species]
    end
    # Save all data
    GameData::Species.save
    GameData::SpeciesMetrics.save
    MessageTypes.setMessagesAsHash(MessageTypes::Species, species_names)
    MessageTypes.setMessagesAsHash(MessageTypes::FormNames, species_form_names)
    MessageTypes.setMessagesAsHash(MessageTypes::Kinds, species_categories)
    MessageTypes.setMessagesAsHash(MessageTypes::Entries, species_pokedex_entries)
    process_pbs_file_message_end
  end
   
end

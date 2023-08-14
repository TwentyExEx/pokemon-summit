#===============================================================================
# Compiler.
#===============================================================================
# Rewrites Ribbon compiler code to include new data.
#-------------------------------------------------------------------------------
module Compiler
  module_function
  
  PLUGIN_FILES += ["Improved Mementos"]
  
  def compile_ribbons(path = "PBS/ribbons.txt")
    compile_pbs_file_message_start(path)
    GameData::Ribbon::DATA.clear
    schema = GameData::Ribbon::SCHEMA
    ribbon_names        = []
    ribbon_descriptions = []
    ribbon_titles       = []
    ribbon_hash         = nil
    pbCompilerEachPreppedLine(path) { |line, line_no|
      if line[/^\s*\[\s*(.+)\s*\]\s*$/]
        GameData::Ribbon.register(ribbon_hash) if ribbon_hash
        ribbon_id = $~[1].to_sym
        if GameData::Ribbon.exists?(ribbon_id)
          raise _INTL("Ribbon ID '{1}' is used twice.\r\n{2}", ribbon_id, FileLineData.linereport)
        end
        ribbon_hash = {
          :id => ribbon_id
        }
      elsif line[/^\s*(\w+)\s*=\s*(.*)\s*$/]
        if !ribbon_hash
          raise _INTL("Expected a section at the beginning of the file.\r\n{1}", FileLineData.linereport)
        end
        property_name = $~[1]
        line_schema = schema[property_name]
        next if !line_schema
        case property_name
        when "PreviousRanks"
          ribbon_hash[line_schema[0]] = $~[2].split(",")		  
        else
          property_value = pbGetCsvRecord($~[2], line_no, line_schema)
          ribbon_hash[line_schema[0]] = property_value
          case property_name
          when "Name"
            ribbon_names.push(ribbon_hash[:name])
          when "Description"
            ribbon_descriptions.push(ribbon_hash[:description])
          when "Title"
            ribbon_titles.push(ribbon_hash[:title])
          end
        end
      end
    }
    GameData::Ribbon.register(ribbon_hash) if ribbon_hash
    GameData::Ribbon.each do |memento|
      if memento.max_rank > 1
        prev_ranks = memento.prev_ranks
        prev_ranks.each_with_index do |rank, i|
          prev_ranks[i] = csvEnumField!(rank, :Ribbon, "PreviousRanks", memento.id)
        end
      end
    end
    GameData::Ribbon.save
    MessageTypes.setMessagesAsHash(MessageTypes::RibbonNames, ribbon_names)
    MessageTypes.setMessagesAsHash(MessageTypes::RibbonDescriptions, ribbon_descriptions)
    MessageTypes.setMessagesAsHash(MessageTypes::MementoTitles, ribbon_titles)
    process_pbs_file_message_end
  end
  
  def write_ribbons(path = "PBS/ribbons.txt")
    write_pbs_file_message_start(path)
    File.open(path, "wb") { |f|
      add_PBS_header_to_file(f)
      GameData::Ribbon.each do |memento|
        f.write("\#-------------------------------\r\n")
        f.write("[#{memento.id}]\r\n")
        f.write("Name = #{memento.real_name}\r\n")
        f.write("IconPosition = #{memento.icon_position}\r\n")
        f.write("Description = #{memento.real_description}\r\n")
        f.write("Title = #{memento.title}\r\n") if !nil_or_empty?(memento.title)
        f.write(sprintf("PreviousRanks = %s\r\n", memento.prev_ranks.join(","))) if memento.prev_ranks.length > 0
        f.write("IsMark = true\r\n") if memento.is_mark?
        f.write(sprintf("Flags = %s\r\n", memento.flags.join(","))) if memento.flags.length > 0
      end
    }
    process_pbs_file_message_end
  end
end


#-------------------------------------------------------------------------------
# Adds mementos/titles to trainer Pokemon.
#-------------------------------------------------------------------------------
module GameData
  class Trainer
    SCHEMA["Memento"] = [:memento, "e", :Ribbon]
  end
end
module SecretBaseMethods
  def self.clear_duplicate_base(base)
    old_base_index = get_base_index_with_owner(base.owner)
    if old_base_index
      # don't overwrite the player's base
      return :no_save if old_base_index == 0
      # get that base
      old_base = $PokemonGlobal.secret_base_list[old_base_index]
      # This is a newer base than the old one
      if base.bases_received_count>old_base.bases_received_count
        # If it was registered, remember that
        base.registry_status = old_base.registry_status
        base.battle_status = old_base.battle_status
        base.skills_count = old_base.skills_count
        base.daily_timer = base.daily_timer
        $PokemonGlobal.secret_base_list[old_base_index] = nil
        return :replace
      end
    end
    dup_base_index = get_base_index_from_id(base.id)
    if dup_base_index
      # don't overwrite the player's base
      return :no_save if dup_base_index == 0
      if dup_base.registry_status == SecretBase::UNREGISTERED
        $PokemonGlobal.secret_base_list[dup_base_index] = nil
        return :overwrite
      else
        return :no_save
      end
    end
    return :free_space
  end
  
  def self.write_base(writer,base)
    if base.id
      writer.sym(base.id)
      writer.int(base.owner.id)
      writer.str(base.owner.name)
      writer.sym(base.owner.trainer_type)
      writer.int(base.owner.language)
      write_decorations(writer,base.decorations)
      CableClub.write_party(writer)
      writer.int(base.bases_received_count)
      writer.str(base.battle_rule)
    else
      # send a singular nil, to say this player does not have a base. Save us the trouble, you know.
      writer.str("")
    end
  end
  
  def self.parse_base(record)
    base_id = record.nil_or(:sym)
    return nil if base_id.nil?
    base = SecretBase.new(base_id,$player)
    base.owner.id = record.int
    base.owner.name = record.str
    base.owner.trainer_type = record.sym
    base.owner.language = record.int
    base.decorations = SecretBaseMethods.parse_decorations(record)
    base.party = CableClub.parse_party(record)
    base.bases_received_count = record.int
    base.battle_rule = record.str
    return base
  end
  def self.write_decorations(writer, decorations)
    SecretBaseSettings::SECRET_BASE_MAX_DECORATIONS.times do |i|
      decor = decorations[i]
      if decor
        writer.sym(decor[0])
        writer.int(decor[1])
        writer.int(decor[2])
      else
        # send 3 nils to keep the alignment
        writer.str("")
        writer.str("")
        writer.str("")
      end
    end
  end
  def self.parse_decorations(record)
    decorations=[]
    SecretBaseSettings::SECRET_BASE_MAX_DECORATIONS.times do |i|
      id = record.nil_or(:sym)
      x = record.nil_or(:int)
      y = record.nil_or(:int)
      if id
        decorations[i] = [id,x,y]
      else
        decorations[i] = nil
      end
    end
    return decorations
  end
end
if defined?(RecordMixer)
  RecordMixer.register(:secret_base,{
    "name" => proc { _INTL("Secret Base")},
    "writeData" => proc {|writer|
      writer.int($PokemonGlobal.secret_base_list.length)
      $PokemonGlobal.secret_base_list.each do |base|
        SecretBaseMethods.write_base(writer, base)
      end
    },
    "parseData" => proc {|record|
      bases_to_add = []
      record.int.times do
        base = SecretBaseMethods.parse_base(record)
        bases_to_add.push(base) if base
      end
      bases_to_add.each do |base|
        ret = SecretBaseMethods.clear_duplicate_base(base)
        case ret
        when :no_save
          next
        when :overwrite,:replace
          $PokemonGlobal.secret_base_list.compact!
        end
        if SecretBaseSettings::SECRET_BASE_MAX_SAVED_BASES<0 ||
            $PokemonGlobal.secret_base_list.length<=SecretBaseSettings::SECRET_BASE_MAX_SAVED_BASES
          if ret == :overwrite || ret == :free_space
            base.battle_status = :new_base
            base.skills_count = 2
            base.daily_timer = Time.now.to_i
          end
          $PokemonGlobal.secret_base_list.push(base)
        end
      end
    },
    "finalizeData" => proc {
      player_base = $PokemonGlobal.secret_base_list[0]
      if player_base.id
        player_base.bases_received_count+=1
      end
    }
  })
end
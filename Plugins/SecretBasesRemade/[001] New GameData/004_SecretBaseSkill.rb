module GameData
  class SecretBaseSkill
    attr_reader :id
    attr_reader :real_name
    attr_reader :usage_proc

    DATA = {}

    extend ClassMethodsSymbols
    include InstanceMethods

    def self.load; end
    def self.save; end

    def initialize(hash)
      @id              = hash[:id]
      @real_name       = hash[:name]        || "Unnamed"
      @usage_proc      = hash[:usage_proc]
    end
    
    # @return [String] the translated name of this egg group
    def name
      return _INTL(@real_name)
    end
    
    def call_usage(*args)
      return (@usage_proc) ? @usage_proc.call(*args) : false
    end
  end
end

GameData::SecretBaseSkill.register({
  :id         => :EV_Training,
  :name       => _INTL("Do some exercise"),
  :usage_proc => proc {|owner|
    pbMessage(_INTL("{1}: Which Pokémon should I do some exercising with?",owner.name))
    chosen = 0
    pbFadeOutIn {
      scene = PokemonParty_Scene.new
      screen = PokemonPartyScreen.new(scene, $player.party)
      screen.pbStartScene(_INTL("Choose a Pokémon."), false)
      chosen = screen.pbChoosePokemon
      screen.pbEndScene
    }
    next false if chosen<0
    pkmn = $player.party[chosen]
    evTotal = 0
    GameData::Stat.each_main { |s| evTotal += pkmn.ev[s.id] }
    if evTotal>=Pokemon::EV_LIMIT
      pbMessage(_INTL("{1}: {2} doesn’t look like it needs any exercise.",owner.name,pkmn.name))
      next false
    elsif pkmn.egg?
      pbMessage(_INTL("{1}: How does an Egg exercise?",owner.name))
      next false
    end
    commands=[_INTL("HP exercises"),
              _INTL("Attack exercises"),
              _INTL("Defense exercises"),
              _INTL("Sp. Atk exercises"),
              _INTL("Sp. Def exercises"),
              _INTL("Speed exercises"),
              _INTL("Never mind")]
    stats = [:HP, :ATTACK, :DEFENSE, :SPECIAL_ATTACK, :SPECIAL_DEFENSE, :SPEED]
    cmd = pbMessage(_INTL("{1}: What kind of exercise should I do?",owner.name),commands,-1)
    if cmd >= 0 && cmd < stats.length
      stat = stats[cmd]
      if pkmn.ev[stat]>=Pokemon::EV_STAT_LIMIT
        pbMessage(_INTL("{1}: {2} doesn’t look like it needs any exercise.",owner.name,pkmn.name))
        next false
      else
        pbMessage(_INTL("{1}: Come on, let’s do this together!\nHere we go...\\1",owner.name))
        pbFadeOutIn {
          pbMessage(_INTL("{1}: And one and two... And one and two...\\1",owner.name))
          pbMessage(_INTL("{1}: {2}!\nAnd one more set!\\1",owner.name,pkmn.name))
        }
        pbMessage(_INTL("{1}: Phew...\nWe worked up a good sweat!\\1",owner.name))
        pbJustRaiseEffortValues(pkmn, stat, 30)
        pbMessage(_INTL("{1}'s base {2} stat went up!",pkmn.name,GameData::Stat.get(stat).name))
      end
    else
      next false
    end
    next true
  }
})

GameData::SecretBaseSkill.register({
  :id         => :Level_Training,
  :name       => _INTL("Do some training"),
  :usage_proc => proc {|owner|
    pbMessage(_INTL("{1}: Which Pokémon should I train?\\1",owner.name))
    chosen = 0
    pbFadeOutIn {
      scene = PokemonParty_Scene.new
      screen = PokemonPartyScreen.new(scene, $player.party)
      screen.pbStartScene(_INTL("Choose a Pokémon."), false)
      chosen = screen.pbChoosePokemon
      screen.pbEndScene
    }
    next false if chosen<0
    pkmn = $player.party[chosen]
    if pkmn.level >= GameData::GrowthRate.max_level
      pbMessage(_INTL("{1}: It doesn’t look like {2} needs any training from me.\\1",owner.name,pkmn.name))
      next false
    elsif pkmn.egg?
      pbMessage(_INTL("{1}: And...that’s an Egg.",owner.name))
      next false
    end
    pbMessage(_INTL("{1}: Looks like this one could use some training! OK! Here I go...\\1",owner.name))
    pbFadeOutIn {
      pbMessage(_INTL("{1}: {2}!\nKeep going! You've got it!\\1",owner.name,pkmn.name))
      pbMessage(_INTL("{1}: {2}!\nThat's it, exactly!\\1",owner.name,pkmn.name))
    }
    pbMessage(_INTL("{1}: That was a great training session!\\1",owner.name))
    pbChangeLevel(pkmn, pkmn.level + 1, nil)
    next true
  }
})

GameData::SecretBaseSkill.register({
  :id         => :Give_Berry,
  :name       => _INTL("Gather Berries"),
  :usage_proc => proc {|owner|
    rare_berry = (rand(3)==0)
    if rare_berry
      berry = [:LIECHIBERRY,:GANLONBERRY,:SALACBERRY,:PETAYABERRY,:APICOTBERRY,:KEEBERRY,:MARANGABERRY].sample
    else
      berry = [:CHERIBERRY,:CHESTOBERRY,:PECHABERRY,:RAWSTBERRY,:ASPEARBERRY,:LEPPABERRY,:PERSIMBERRY,:LUMBERRY,:SITRUSBERRY].sample
    end
    pbMessage(_INTL("{1}: Come out, come out, wherever you are!\nOK! Here I go...\\1",owner.name))
    pbFadeOutIn {
      pbMessage(_INTL("{1}:  We’re going on a Berry hunt,\nwe’re going to find a big one...\\1",owner.name))
      pbMessage(_INTL("{1}: What a beautiful day! We’re not...\nHmm? This scent... Could it be?!\\1",owner.name))
    }
    pbMessage(_INTL("{1}: Oooooh, I found a Berry!\\1",owner.name))
    pbReceiveItem(berry)
    next true
  }
})

GameData::SecretBaseSkill.register({
  :id         => :Give_Decoration,
  :name       => _INTL("Make some goods"),
  :usage_proc => proc {|owner|
    decoration=[# Desks
                :SMALLDESK,:POKEMONDESK,:HEAVYDESK,:RAGGEDDESK,
                :COMFORTDESK,:BRICKDESK,:CAMPDESK,:HARDDESK,
                # Chairs
                :SMALLCHAIR,:POKEMONCHAIR,:HEAVYCHAIR,:RAGGEDCHAIR,
                :COMFORTCHAIR,:BRICKCHAIR,:CAMPCHAIR,:HARDCHAIR,
                # Plants
                :REDPLANT,:TROPICALPLANT,:PRETTYFLOWERS,:COLORFULPLANT,
                :BIGPLANT,:GORGEOUSPLANT,
                # Ornaments
                :REDBRICK,:YELLOWBRICK,:BLUEBRICK,:SANDORNAMENT,
                :FENCELENGTH,:FENCEWITDH,
                :SOLIDBOARDVERTICAL,:SOLIDBOARDHORIZONTAL,:SOLIDBOARDSQUARE,
                :REDBALLOON,:YELLOWBALLOON,:BLUEBALLOON,:MUDBALL,
                # Mats
                :SURFMAT,:THUNDERMAT,:FIREBLASTMAT,:POWDERSNOWMAT,
                :ATTRACTMAT,:FISSUREMAT,:GLITTERMAT,:JUMPMAT,:SPINMAT,
                # Posters
                :BALLPOSTER,:GREENPOSTER,:REDPOSTER,:BLUEPOSTER,
                :CUTEPOSTER,:PIKAPOSTER,:LONGPOSTER,:SEAPOSTER,:SKYPOSTER,
                # Dolls
                :PICHUDOLL,:PIKACHUDOLL,:MARILLDOLL,:JIGGLYPUFFDOLL,
                :DUSKULLDOLL,:WYNAUTDOLL,:BALTOYDOLL,:KECLEONDOLL,
                :AZURILLDOLL,:SKITTYDOLL,:SWABLUDOLL,:GULPINDOLL,
                # Cushions
                :BALLCUSHION,:PIKACUSHION,:ROUNDCUSHION,:KISSCUSHION,
                :ZIGZAGCUSHION,:SPINCUSHION,:DIAMONDCUSHION,
                :GRASSCUSHION,:FIRECUSHION,:WATERCUSHION
                ].sample
    pbMessage(_INTL("{1}: OK! I'm itching to start! Here I go.\\1",owner.name))
    pbFadeOutIn {
      pbMessage(_INTL("{1}: Mm-hmm. Yes, I see.\nThen I’ll need to start with this...\\1",owner.name))
      pbMessage(_INTL("{1}: Mm-hmm. Right, right.\nAnd this goes here, and...\\1",owner.name))
    }
    pbMessage(_INTL("{1}: Mm-hmm!\nThis looks pretty good, right?\\1",owner.name))
    pbReceiveDecoration(decoration)
    next true
  }
})

GameData::SecretBaseSkill.register({
  :id         => :Massage_Pokemon,
  :name       => _INTL("Massage a Pokémon"),
  :usage_proc => proc {|owner|
    pbMessage(_INTL("{1}:  Which Pokémon would you like me to massage for you?\\1",owner.name))
    chosen = 0
    pbFadeOutIn {
      scene = PokemonParty_Scene.new
      screen = PokemonPartyScreen.new(scene, $player.party)
      screen.pbStartScene(_INTL("Choose a Pokémon."), false)
      chosen = screen.pbChoosePokemon
      screen.pbEndScene
    }
    next false if chosen<0
    pkmn = $player.party[chosen]
    if pkmn.happiness >= (Settings::APPLY_HAPPINESS_SOFT_CAP ? 160 : 220)
      pbMessage(_INTL("{1}: It doesn’t look like {2} needs any massaging.\\1",owner.name,pkmn.name))
      next false
    elsif pkmn.egg?
      pbMessage(_INTL("{1}: Yeah, that’s an Egg.",owner.name))
      next false
    end
    pbMessage(_INTL("{1}: Oh, so clenched! Feel these knots?\nOK! Here I go...\\1",owner.name))
    pbFadeOutIn {
      pbMessage(_INTL("{1}:  Knead...knead...\nThump, thump, thump!\\1",owner.name,pkmn.name))
      pbMessage(_INTL("{1}:  Knead, knead...\nThump, thump, thump!\\1",owner.name,pkmn.name))
    }
    pbMessage(_INTL("{1}: It looks like {2}\nreally appreciates the extra care.",owner.name,pkmn.name))
    gain = 30
    gain += 1 if pkmn.poke_ball == :LUXURYBALL
    gain = (gain * 1.5).floor if pkmn.hasItem?(:SOOTHEBELL)
    if Settings::APPLY_HAPPINESS_SOFT_CAP
      gain = gain.clamp(0, 179 - pkmn.happiness)
    end
    pkmn.happiness = (pkmn.happiness + gain).clamp(0, 255)
    next true
  }
})

GameData::SecretBaseSkill.register({
  :id         => :Give_Item,
  :name       => _INTL("Pick something up"),
  :usage_proc => proc {|owner|
    rare_item = (rand(3)==0)
    if rare_item
      item = [:MASTERBALL,:PPMAX,:MAXREVIVE].sample
    else
      if rand(2)==0
        item =[:ESCAPEROPE,:ESCAPEROPE,:ULTRABALL].sample
      else
        item = [:ELIXIR,:FULLRESTORE,:HEARTSCALE,:PPUP,:RARECANDY,:REVIVE].sample
      end
    end
    pbMessage(_INTL("{1}: I sure hope there’s something here.\nOK! Here I go...\\1",owner.name))
    pbFadeOutIn {
      pbMessage(_INTL("{1}: From a corner here to a corner there,\nI’m searching for treasure everywhere!\\1",owner.name))
      pbMessage(_INTL("{1}: I’m searching for-\nWhoops, could this be...\\1",owner.name))
    }
    pbMessage(_INTL("{1}: I think I actually found something!\\1",owner.name))
    pbReceiveItem(item)
    next true
  }
})

GameData::SecretBaseSkill.register({
  :id         => :Give_Stone,
  :name       => _INTL("Pick up stones"),
  :usage_proc => proc {|owner|
    if rand(2)==0
      item = :EVERSTONE
    else
      rare_item = (rand(3)==0)
      if rare_item
        item = [:DAWNSTONE,:DUSKSTONE,:MOONSTONE,:SHINYSTONE,:SUNSTONE].sample
      else
        item = [:FIRESTONE,:LEAFSTONE,:THUNDERSTONE,:WATERSTONE].sample
      end
    end
    pbMessage(_INTL("{1}: I bet I know where they will be today.\nOK! Here I go...\\1",owner.name))
    pbFadeOutIn {
      pbMessage(_INTL("{1}: Millions of stones, stones for me...\nSparkle-ee sparkle, sparkly sparkle...\\1",owner.name))
      pbMessage(_INTL("{1}: Hmm? Isn’t this... No way?!\\1",owner.name))
    }
    pbMessage(_INTL("{1}: This is... Uh, what kind of stone is it?\\1",owner.name))
    pbReceiveItem(item)
    next true
  }
})

GameData::SecretBaseSkill.register({
  :id         => :Give_Treasure,
  :name       => _INTL("Search for treasure"),
  :usage_proc => proc {|owner|
    if rand(10)<3
      item = :FLOATSTONE
    else
      item = [:BIGNUGGET,:BIGPEARL,:COMETSHARD,:NUGGET,:PEARL,:PEARLSTRING,:RAREBONE].sample
    end
    pbMessage(_INTL("{1}: Just leave it up to me!\nOK! Here I go...\\1",owner.name))
    pbFadeOutIn {
      pbMessage(_INTL("{1}: Treasure, treasure here,\ntreasure, treasure there...\\1",owner.name))
      pbMessage(_INTL("{1}: Here a treasure, there a-\nWha—? Isn’t this... No way!\\1",owner.name))
    }
    pbMessage(_INTL("{1}: I found some fantastic treasure!\\1",owner.name))
    pbReceiveItem(item)
    next true
  }
})

GameData::SecretBaseSkill.register({
  :id         => :Egg_Care,
  :name       => _INTL("Take care of an Egg"),
  :usage_proc => proc {|owner|
    if !($player.party.any?{|pkmn| pkmn.egg? })
      pbMessage(_INTL("{1}: I’d love to help, if you’d bring an Egg...\\1",owner.name))
      next false
    end
    pbMessage(_INTL("{1}: Got it! Which Egg should I stroke?\\1",owner.name))
    chosen = 0
    pbFadeOutIn {
      scene = PokemonParty_Scene.new
      screen = PokemonPartyScreen.new(scene, $player.party)
      screen.pbStartScene(_INTL("Choose an Egg."), false)
      chosen = screen.pbChoosePokemon
      screen.pbEndScene
    }
    next false if chosen<0
    pkmn = $player.party[chosen]
    if !pkmn.egg?
      pbMessage(_INTL("{1}: I’m pretty sure that’s not an Egg.",owner.name))
      next false
    end
    pbMessage(_INTL("{1}: That’s one finely shaped Egg.\nOK! Here I go...\\1",owner.name))
    pbFadeOutIn {
      pbMessage(_INTL("{1}: There, there...\nGood Egg... That’s a good little Egg...\\1",owner.name))
      pbMessage(_INTL("{1}: Yes, you are. Yes, you are a good little Egg!\\1",owner.name))
    }
    pbMessage(_INTL("{1}: Here's your egg back. I hope it hatches soon.\\1",owner.name))
    # This is a close enough approximation of the description on bulbapedia
    pkmn.steps_to_hatch -= pkmn.species_data.hatch_steps/2
    next true
  }
})
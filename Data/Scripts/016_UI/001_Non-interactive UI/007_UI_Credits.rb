#==============================================================================
# * Scene_Credits
#------------------------------------------------------------------------------
# Scrolls the credits you make below. Original Author unknown.
#
## Edited by MiDas Mike so it doesn't play over the Title, but runs by calling
# the following:
#    $scene = Scene_Credits.new
#
## New Edit 3/6/2007 11:14 PM by AvatarMonkeyKirby.
# Ok, what I've done is changed the part of the script that was supposed to make
# the credits automatically end so that way they actually end! Yes, they will
# actually end when the credits are finished! So, that will make the people you
# should give credit to now is: Unknown, MiDas Mike, and AvatarMonkeyKirby.
#                                             -sincerly yours,
#                                               Your Beloved
# Oh yea, and I also added a line of code that fades out the BGM so it fades
# sooner and smoother.
#
## New Edit 24/1/2012 by Maruno.
# Added the ability to split a line into two halves with <s>, with each half
# aligned towards the centre. Please also credit me if used.
#
## New Edit 22/2/2012 by Maruno.
# Credits now scroll properly when played with a zoom factor of 0.5. Music can
# now be defined. Credits can't be skipped during their first play.
#
## New Edit 25/3/2020 by Maruno.
# Scroll speed is now independent of frame rate. Now supports non-integer values
# for SCROLL_SPEED.
#
## New Edit 21/8/2020 by Marin.
# Now automatically inserts the credits from the plugins that have been
# registered through the PluginManager module.
#==============================================================================
class Scene_Credits
  # Backgrounds to show in credits. Found in Graphics/Titles/ folder
  BACKGROUNDS_LIST       = ["credits1", "credits2", "credits3", "credits4", "credits5","credits6", "credits7", "credits8", "credits9", "credits10","credits11", "credits12", "credits13", "credits14", "credits15", "credits16", "credits17", "credits18", "credits19", "credits20", "credits21", "credits22", "credits23", "credits24", "credits25", "credits26", "credits27", "credits28"]
  BGM                    = "credits"
  SCROLL_SPEED           = 40   # Pixels per second
  SECONDS_PER_BACKGROUND = 10
  TEXT_OUTLINE_COLOR     = Color.new(0, 0, 128, 255)
  TEXT_BASE_COLOR        = Color.new(255, 255, 255, 255)
  TEXT_SHADOW_COLOR      = Color.new(0, 0, 0, 100)

  # This next piece of code is the credits.
  # Start Editing
  CREDIT = <<_END_

~~ Graphics ~~ 

~Overworlds for the following:~

Barry, Bianca, Pryce, Clair, Drake, 
Professor Birch, Archie, Volkner, 
Professor Sycamore, Professor Elm, 
Bertha, Flint, Cheryl, Mira, Professor Rowan, 
Benga, Hilbert, Lyra, Dawn, Serena, 
Professor Kukui, Boarder, Rocker, Super Nerd, 
Tamer, Hex Maniac, 
Team Galactic Grunt - Aveontrainer

Silver - Skeizerr and Aveontrainer

Wally, Whitney, Morty, Chuck, Jasmine, 
Roxanne, Wattson, Tate, Liza, Sidney, 
Phoebe, Ghetsis, Crasher Wake, Fantina, 
Byron, Drayden, Cheren, Aaron, Lucian, 
Marley, Caitlin, Professor Juniper, 
Lucas, Wallace, Steven, 
Team Aqua Grunts - Starsparkless and Aveontrainer

Hau, Shauna, Trevor, Lana, Marnie, Bea,
Hau, Mina - Zender1752 and Aveontrainer

Falkner - BurstXShadowsX and Aveontrainer

Bugsy, Winona, Cyrus, 
Brycen  - PurpleZaffre, Starsparkless and Aveontrainer

Wulfric, Eusine, Avery, Nate, Rosa, 
Team Plasma Grunts,  - PurpleZaffre and Aveontrainer

Glacia - Starsparkless, KalerioDion and Aveontrainer

Nanu, Kahili - Silentninja, TSR, 
Furs the Fox, ShiningStar5022

Roark, Gardenia, Maylene, Will, 
Karen, N, Gold - PurpleZaffre

Candice, Roxie, Fairy Tale Girl - UlithiumDragon

Burgh, Clay, Skyla, Marlon, Viola, Grant, Korrina, 
Ramos, Valerie. Olympia, Shauntal, Grimsley, Malva, 
Siebold, Wikstrom, Drasna, Hop, Janine, Cilan, Chili, 
Cress, Marshal, Milo, Nessa, Kabu, Opal, Gordie, 
Melony, Piers, Raihan, Selene, Gloria, Elio, Victor, 
Mustard, Bede, Sonia, Peony, President Rose, Buck, 
Lisia, Green, Looker, Lysandre, Guzma, Lenora, Elesa, 
Ilima, Kiawe, Sophocles, Olivia, Hala, Hapu, Acerola, 
Lusamine, Iris, Maxie, Molayne, Gladion - Miguel_Horo

Clemont - pokemonrater

Whitney - Starsparkless

Hugh - SylveonGives

Mallow - Droid779 and Aveontrainer

Riley - Etique and Aveontrainer

Klara, Allister - hekigaHoge and Aveontrainer

Calem  - spritestealer and Aveontrainer

Hilda - Starsparkless, kisirokitsune and Aveontrainer

Leon - JappaWakka and PurpleZaffre

Diantha - Lolw3e932

Alder - KalerioDion and Aveontrainer

Cynthia - Wobb and Aveontrainer

Kindler - Spherical Ice and Aveontrainer

Dragon Tamer, Burglar, Engineer, 
Breeder, Lady - kalerie and Aveontrainer

Painter, PokeManiac, 
Pokemon Rangers - MrDollSteak and Aveontrainer

Female Swimmer - Teraneck

Brawly, Norman, Juan - Poffin_Case

Schoolkid - Young-Dante

Team Flare Grunts - PurpleZaffre, 
izzyviscious and Aveontrainer

~Trainer Sprites~ 

Milo, Nessa, Kabu, Bea, Allister, Opal, 
Gordie, Melony, Piers, Raihan, President Rose, 
Green, Lisia, Klara, Avery, Mustard, Marnie, 
Bede, Sonia, Peony, Gloria, 
Leon - Brumirage, Altthiel, Pujolly and Irpachuza.

Ilima, Lana, Kiawe, Mallow, Sophocles, 
Acerola, Mina, Hau, Guzma, Elio, Selene, 
Kukui, Hala, Nanu, Hapu, Kahili, Molayne, 
Lusamine, Gladion - Beliot419

Viola, Korrina, Ramos, Clemont, Valerie, 
Olympia, Wulfric, Sidney, Malva, Siebold, 
Wikstrom, Drasna - Gnomowladny

Grant, Glacia - MechanicalApe464

Wally, Maxie, Archie, Leaf, Red, 
Brandan, May, Victor, Steven - hyo-oppa

Shauna - Krokotips

Lysandre, Brock, Misty, Surge, Erika, 
Koga, Sabrina, Blaine, Lorelei, 
Bruno, Agatha, Lance - Drawnamu

Professor Elm - VictorV111

Kris - Kimba616, InvaderDebz 
and pruighfyurgfgbvf

Phoebe - UltimaxLugia2020

Drake - Segesi

Zinnia - Jart4115

Professor Juniper - art-56

Professor Sycamore - Wynruelle

Trevor - Aveontrainer

Calem, Serena - TintjeMadelintje101

Looker, Diantha, Fairy Tale Girl, 
Hex Maniac, Lord (Announcer) - KyleDove

Standard Trainer Classes, Oak - kensuyjin33, 
Flamejow, AutumnSpire and duncapham

Roxanne, Brawly, Wattson, Flannery, Norman, 
Winona, Tate, Liza, 
Wallace - ChromusSama and Shir0n

Team Aqua Grunts, Team Magma Grunts - IceJkai

~Other Sprites~

Player Sprite - WolfHeretic (via Advanced Character Customization)

Gym Badges - VictorV111

Z Crystals - Pixel3r

~~Pokemon Emerald UI Pack~~

Voltseon (For Bag, Relearn, Party, Summary)

Shashu-Greninja, Gazza teh Fox, ENLS (For Trainer Card UI)

Pokémon Splice Team (For Battle UI)

~~ Pokemon Generation 8 Project for v20.1 ~~


~Battler Sprites:~


Gen 1-5 Pokemon Sprites - veekun

Gen 6 Pokemon Sprites - All Contributors 
To Smogon X/Y Sprite Project

Gen 7 Pokemon Sprites - All Contributors To 
Smogon Sun/Moon Sprite Project

Gen 8 Pokemon Sprites - All Contributors To 
Smogon Sword/Shield Sprite Project


~Overworld Sprites~


Gen 6+ Berry Tree Overworlds - Anarlaurendil

Gen 6 Pokemon Overworlds - princess-pheonix, LunarDusk, 
Wolfang62, TintjeMadelintje101, piphybuilder88

Gen 7 Pokemon Overworlds - Larry Turbo, princess-pheonix

Gen 8 Pokemon Overworlds - SageDeoxys, Wolfang62, 
LarryTurbo, tammyclaydon

Gen 1-5 Pokemon Overworlds - MissingLukey, help-14, 
Kymoyonian, cSc-A7X, 2and2makes5, Pokegirl4ever, 
Fernandojl, Silver-Skies, TyranitarDark, Getsuei-H, 
Kid1513, Milomilotic11, Kyt666, kdiamo11, Chocosrawlooid, 
Syledude, Gallanty, Gizamimi-Pichu, 2and2makes5, 
Zyon17,LarryTurbo, spritesstealer, LarryTurbo


~Icon Sprites~


Gen 1-6 Pokemon Icon Sprites - Alaguesia

Gen 7 Pokemon Icon Sprites - Marin, MapleBranchWing, 
Contributors to the DS Styled Gen 7+ Repository

Gen 8 Icon Sprites - Larry Turbo, Leparagon


~Cry Credits~

Gen 1-6 Pokemon Cries - Rhyden
Gen 7 Pokemon Cries - Marin, Rhyden
Gen 8 Pokemon Cries - Zeak6464

~Script Credits~

Golisopod User, Luka S.J.

~Compilation of Resources~

Golisopod User, UberDunsparce

~~Music~~

Pokemon Masters EX

~~Animations~~ 

Pokemon Reborn

Gen 8 move animation project by StCooler, DarryBD99, 
WolfPP, ardicoozer, riddlemeree.

Sound Effects - BellBlitzKing 

{INSERTS_PLUGIN_CREDITS_DO_NOT_REMOVE}

"Pokémon Essentials" was created by:
Flameguru
Poccil (Peter O.)
Maruno

With contributions from:
AvatarMonkeyKirby<s>Marin
Boushy<s>MiDas Mike
Brother1440<s>Near Fantastica
FL.<s>PinkMan
Genzai Kawakami<s>Popper
Golisopod User<s>Rataime
help-14<s>Savordez
IceGod64<s>SoundSpawn
Jacob O. Wobbrock<s>the__end
KitsuneKouta<s>Venom12
Lisa Anthony<s>Wachunga
Luka S.J.<s>
and everyone else who helped out

"mkxp-z" by:
Roza
Based on "mkxp" by Ancurio et al.

"RPG Maker XP" by:
Enterbrain

Pokémon is owned by:
The Pokémon Company
Nintendo
Affiliated with Game Freak



This is a non-profit fan-made game.
No copyright infringements intended.
Please support the official games!

_END_
# Stop Editing

  def main
    #-------------------------------
    # Animated Background Setup
    #-------------------------------
    @counter = 0.0   # Counts time elapsed since the background image changed
    @bg_index = 0
    @bitmap_height = Graphics.height   # For a single credits text bitmap
    @trim = Graphics.height / 10
    # Number of game frames per background frame
    @realOY = -(Graphics.height - @trim)
    #-------------------------------
    # Credits text Setup
    #-------------------------------
    plugin_credits = ""
    PluginManager.plugins.each do |plugin|
      pcred = PluginManager.credits(plugin)
      plugin_credits << "\"#{plugin}\" v.#{PluginManager.version(plugin)} by:\n"
      if pcred.size >= 5
        plugin_credits << (pcred[0] + "\n")
        i = 1
        until i >= pcred.size
          plugin_credits << (pcred[i] + "<s>" + (pcred[i + 1] || "") + "\n")
          i += 2
        end
      else
        pcred.each { |name| plugin_credits << (name + "\n") }
      end
      plugin_credits << "\n"
    end
    CREDIT.gsub!(/\{INSERTS_PLUGIN_CREDITS_DO_NOT_REMOVE\}/, plugin_credits)
    credit_lines = CREDIT.split(/\n/)
    #-------------------------------
    # Make background and text sprites
    #-------------------------------
    viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    viewport.z = 99999
    text_viewport = Viewport.new(0, @trim, Graphics.width, Graphics.height - (@trim * 2))
    text_viewport.z = 99999
    @background_sprite = IconSprite.new(0, 0)
    @background_sprite.setBitmap("Graphics/Titles/" + BACKGROUNDS_LIST[0])
    @credit_sprites = []
    @total_height = credit_lines.size * 32
    lines_per_bitmap = @bitmap_height / 32
    num_bitmaps = (credit_lines.size.to_f / lines_per_bitmap).ceil
    num_bitmaps.times do |i|
      credit_bitmap = Bitmap.new(Graphics.width, @bitmap_height + 16)
      pbSetSystemFont(credit_bitmap)
      lines_per_bitmap.times do |j|
        line = credit_lines[(i * lines_per_bitmap) + j]
        next if !line
        line = line.split("<s>")
        xpos = 0
        align = 1   # Centre align
        linewidth = Graphics.width
        line.length.times do |k|
          if line.length > 1
            xpos = (k == 0) ? 0 : 20 + (Graphics.width / 2)
            align = (k == 0) ? 2 : 0   # Right align : left align
            linewidth = (Graphics.width / 2) - 20
          end
          credit_bitmap.font.color = TEXT_SHADOW_COLOR
          credit_bitmap.draw_text(xpos, (j * 32) + 12, linewidth, 32, line[k], align)
          credit_bitmap.font.color = TEXT_OUTLINE_COLOR
          credit_bitmap.draw_text(xpos + 2, (j * 32) + 2, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos,     (j * 32) + 2, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos - 2, (j * 32) + 2, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos + 2, (j * 32) + 4, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos - 2, (j * 32) + 4, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos + 2, (j * 32) + 6, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos,     (j * 32) + 6, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos - 2, (j * 32) + 6, linewidth, 32, line[k], align)
          credit_bitmap.font.color = TEXT_BASE_COLOR
          credit_bitmap.draw_text(xpos, (j * 32) + 4, linewidth, 32, line[k], align)
        end
      end
      credit_sprite = Sprite.new(text_viewport)
      credit_sprite.bitmap = credit_bitmap
      credit_sprite.z      = 9998
      credit_sprite.oy     = @realOY - (@bitmap_height * i)
      @credit_sprites[i] = credit_sprite
    end
    #-------------------------------
    # Setup
    #-------------------------------
    # Stops all audio but background music
    previousBGM = $game_system.getPlayingBGM
    pbMEStop
    pbBGSStop
    pbSEStop
    pbBGMFade(2.0)
    pbBGMPlay(BGM)
    Graphics.transition
    loop do
      Graphics.update
      Input.update
      update
      break if $scene != self
    end
    pbBGMFade(2.0)
    $game_temp.background_bitmap = Graphics.snap_to_bitmap
    Graphics.freeze
    viewport.color = Color.new(0, 0, 0, 255)   # Ensure screen is black
    Graphics.transition(8, "fadetoblack")
    $game_temp.background_bitmap.dispose
    @background_sprite.dispose
    @credit_sprites.each { |s| s&.dispose }
    text_viewport.dispose
    viewport.dispose
    $PokemonGlobal.creditsPlayed = true
    pbBGMPlay(previousBGM)
    $game_switches[37] = true
    $game_switches[61] = true
    Game.save
    $game_temp.title_screen_calling = true
  end

  # Check if the credits should be cancelled
  def cancel?
    if Input.trigger?(Input::USE) && $PokemonGlobal.creditsPlayed
      $scene = Scene_Map.new
      pbBGMFade(1.0)
      return true
    end
    return false
  end

  # Checks if credits bitmap has reached its ending point
  def last?
    if @realOY > @total_height + @trim
      $scene = ($game_map) ? Scene_Map.new : nil
      pbBGMFade(2.0)
      return true
    end
    return false
  end

  def update
    delta = Graphics.delta_s
    @counter += delta
    # Go to next slide
    if @counter >= SECONDS_PER_BACKGROUND
      @counter -= SECONDS_PER_BACKGROUND
      @bg_index += 1
      @bg_index = 0 if @bg_index >= BACKGROUNDS_LIST.length
      @background_sprite.setBitmap("Graphics/Titles/" + BACKGROUNDS_LIST[@bg_index])
    end
    return if cancel?
    return if last?
    @realOY += SCROLL_SPEED * delta
    @credit_sprites.each_with_index { |s, i| s.oy = @realOY - (@bitmap_height * i) }
  end
end

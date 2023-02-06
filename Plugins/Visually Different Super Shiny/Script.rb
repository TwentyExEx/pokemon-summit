#====================================================================
# Visually Different Super Shiny for Pokemon Essentials
#====================================================================
# This script implements having different sprites for super shiny
# Pokemon.
#
# This utilizes some tweaked functions based on the Essentials Deluxe
# plugin made by Lucidious89, and is dependant on that plugin.
#====================================================================


#====================================================================
#== Loose script changes                                           ==
#====================================================================

alias VDSS_species_sprite_params species_sprite_params
def species_sprite_params(*params)
  data = VDSS_species_sprite_params(*params)
  data[:supershiny] = params[10] || false
  return data
end

alias VDSS_species_sprite_params2 species_sprite_params2
def species_sprite_params2(*params)
  data = VDSS_species_sprite_params2(*params)
  data[:supershiny] = params[10] || false
  return data
end

alias VDSS_species_icon_params species_icon_params
def species_icon_params(*params)
  data = VDSS_species_icon_params(*params)
  data[:supershiny] = params[9] || false
  return data
end

alias VDSS_species_overworld_params species_overworld_params
def species_overworld_params(*params)
  data = VDSS_species_overworld_params(*params)
  data[:supershiny] = params[6] || false
  return data
end

alias VDSS_species_cry_params species_cry_params
def species_cry_params(*params)
  data = VDSS_species_cry_params(*params)
  data[:supershiny] = params[8] || false
  return data
end

#====================================================================
#== Species script changes                                         ==
#====================================================================

module GameData
	class Species
		def self.check_graphic_file(path, params, subfolder = "", dmax_folder = "")
			species   = params[:species]
			form      = params[:form]
			gender    = params[:gender]
			shiny     = params[:shiny]
			shadow    = params[:shadow]
			dmax      = params[:dmax]
			gmax      = params[:gmax]
			celestial = params[:celestial]
			supershiny= params[:supershiny]
			try_dmax_folder = ""
			try_subfolder = sprintf("%s/", subfolder)
			try_species = species
			try_form    = (form > 0)    ? sprintf("_%d", form) : ""
			try_gender  = (gender == 1) ? "_female"    : ""
			try_shadow  = (shadow)      ? "_shadow"    : ""
			try_dmax    = (dmax)        ? "_dmax"      : ""
			try_gmax    = (gmax)        ? "_gmax"      : ""
			try_celest  = (celestial)   ? "_celestial" : ""
			factors = []
			factors.push([9, sprintf("%s", dmax_folder), try_dmax_folder]) if dmax || gmax
			factors.push([8, sprintf("%s shiny/", subfolder), try_subfolder]) if shiny# and not supershiny
			factors.push([7, sprintf("%s super shiny/", subfolder), try_subfolder]) if supershiny
			factors.push([6, try_celest, ""]) if celestial
			factors.push([5, try_gmax,   ""]) if gmax
			factors.push([4, try_dmax,   ""]) if dmax
			factors.push([3, try_shadow, ""]) if shadow
			factors.push([2, try_gender, ""]) if gender == 1
			factors.push([1, try_form,   ""]) if form > 0
			factors.push([0, try_species, "000"])
			(2**factors.length).times do |i|
				factors.each_with_index do |factor, index|
					value = ((i / (2**index)).even?) ? factor[1] : factor[2]
					case factor[0]
					when 0 then try_species     = value
					when 1 then try_form        = value
					when 2 then try_gender      = value
					when 3 then try_shadow      = value
					when 4 then try_dmax        = value
					when 5 then try_gmax        = value
					when 6 then try_celest      = value
					when 7 then try_subfolder   = value
					when 8 then try_subfolder   = value
					when 9 then try_dmax_folder = value
					end
				end
				try_species_text = try_species
				ret = pbResolveBitmap(sprintf("%s%s%s%s%s%s%s%s%s%s", path, try_subfolder, try_dmax_folder,
								  try_species_text, try_form, try_gender, try_shadow, 
								  try_dmax, try_gmax, try_celest))
				return ret if ret
			end
			return nil
		end
	
		def self.sprite_bitmap_from_pokemon(*params)
			pkmn    = params[0]
			back    = params[1]
			species = params[2]
			target  = params[3]
			species = pkmn.species if !species
			species = GameData::Species.get(species).species
			return self.egg_sprite_bitmap(species, pkmn.form) if pkmn.egg?
			gmax   = (target) ? (target.gmax_factor? && target.dynamax? && pkmn.dynamax?) : pkmn.gmax?
			sprite = [species, pkmn.form, pkmn.gender, pkmn.shiny?, pkmn.shadowPokemon?, back, pkmn.egg?, pkmn.dynamax?, gmax, pkmn.celestial?, pkmn.super_shiny?]
			ret    = (back) ? self.back_sprite_bitmap(*sprite) : self.front_sprite_bitmap(*sprite)
			if PluginManager.installed?("Generation 8 Pack Scripts")
				alter_bitmap_function = (ret && ret.total_frames == 1) ? MultipleForms.getFunction(species, "alterBitmap") : nil
				if ret && alter_bitmap_function
					ret.prepare_strip
					for i in 0...ret.total_frames
						alter_bitmap_function.call(pkmn, ret.alter_bitmap(i))
					end
					ret.compile_strip
				end
			else
				alter_bitmap_function = MultipleForms.getFunction(species, "alterBitmap")
				if ret && alter_bitmap_function
					new_ret = ret.copy
					ret.dispose
					new_ret.each { |bitmap| alter_bitmap_function.call(pkmn, bitmap) }
					ret = new_ret
				end
			end
			return ret
		end
		
		def self.icon_filename_from_pokemon(pkmn)
		  return self.icon_filename(pkmn.species, pkmn.form, pkmn.gender, pkmn.shiny?, pkmn.shadowPokemon?, pkmn.egg?, 
									pkmn.dynamax?, pkmn.gmax?, pkmn.celestial?, pkmn.super_shiny?)
		end
		
		def self.cry_filename_from_pokemon(pkmn, suffix = "")
			params = [pkmn.species, pkmn.form, suffix, pkmn.shiny?, pkmn.shadowPokemon?, pkmn.dynamax?, pkmn.gmax?, pkmn.celestial?, pkmn.super_shiny?]
			return self.check_cry_file(*params)
		end
		
		def self.check_cry_file(*params)
			params = species_cry_params(*params)
			species_data = self.get_species_form(params[:species], params[:form])
			return nil if species_data.nil?
			base_file = "#{species_data.species}" + params[:suffix]
			form_file = "#{species_data.species}" + "_#{params[:form]}" + params[:suffix]
			file = (params[:form] > 0) ? form_file : base_file
			base_folder = "Cries/"
			#-------------------------------------------------------------------------
			# Plays Gigantamax cry if one exists.
			#-------------------------------------------------------------------------
			if params[:gmax]
				folder = base_folder + "Gigantamax/"
				cry = folder + file
				backup = folder + base_file
				return cry if pbResolveAudioSE(cry)
				return backup if pbResolveAudioSE(backup)
			end
			#-------------------------------------------------------------------------
			# Plays Dynamax cry if one exists.
			#-------------------------------------------------------------------------
			if params[:dmax]
				folder = base_folder + "Dynamax/"
				cry = folder + file
				backup = folder + base_file
				return cry if pbResolveAudioSE(cry)
				return backup if pbResolveAudioSE(backup)
			end
			#-------------------------------------------------------------------------
			# Plays Celestial cry if one exists.
			#-------------------------------------------------------------------------
			if params[:celestial]
				folder = base_folder + "Celestial/"
				cry = folder + file
				backup = folder + base_file
				return cry if pbResolveAudioSE(cry)
				return backup if pbResolveAudioSE(backup)
			end
			#-------------------------------------------------------------------------
			# Plays Shadow cry if one exists.
			#-------------------------------------------------------------------------
			if params[:shadow]
				folder = base_folder + "Shadow/"
				cry = folder + file
				backup = folder + base_file
				return cry if pbResolveAudioSE(cry)
				return backup if pbResolveAudioSE(backup)
			end
			#-------------------------------------------------------------------------
			# Plays Supershiny cry if one exists.
			#-------------------------------------------------------------------------
			if params[:supershiny]
				folder = base_folder + "Super shiny/"
				cry = folder + file
				backup = folder + base_file
				return cry if pbResolveAudioSE(cry)
				return backup if pbResolveAudioSE(backup)
			end
			#-------------------------------------------------------------------------
			# Plays Shiny cry if one exists.
			#-------------------------------------------------------------------------
			if params[:shiny]
				folder = base_folder + "Shiny/"
				cry = folder + file
				backup = folder + base_file
				return cry if pbResolveAudioSE(cry)
				return backup if pbResolveAudioSE(backup)
			end
			#-------------------------------------------------------------------------
			# Plays base cry.
			#-------------------------------------------------------------------------
			cry = base_folder + file
			backup = base_folder + base_file
			return cry if pbResolveAudioSE(cry)
			return (pbResolveAudioSE(backup)) ? backup : nil
		end
	end
end

#====================================================================
#== Pokemon Data Box script changes                                ==
#====================================================================

class Battle::Scene::PokemonDataBox < Sprite
	def draw_shiny_icon
		return if !@battler.shiny?
		if @battler.effects[PBEffects::MaxRaidBoss]
			pbDrawImagePositions(self.bitmap, [["Graphics/Plugins/ZUD/Battle/shiny", 0, 30]])
		else
			shiny_x = (@battler.opposes?(0)) ? 206 : -6
			shiny_filename = (@battler.super_shiny?) ? "Graphics/Plugins/Visually Different Super Shiny/super shiny" : "Graphics/Pictures/shiny"
			pbDrawImagePositions(self.bitmap, [[shiny_filename, @spriteBaseX + shiny_x, 36]])
		end
	end
end

#====================================================================
#== Pokemon Party Panel script changes                             ==
#====================================================================

class PokemonPartyPanel < Sprite
	def draw_shiny_icon
		return if @pokemon.egg? || !@pokemon.shiny?
		shiny_filename = (@pokemon.super_shiny?) ? "Graphics/Plugins/Visually Different Super Shiny/super shiny" : "Graphics/Pictures/shiny"
		pbDrawImagePositions(@overlaysprite.bitmap, [[shiny_filename, 80, 48, 0, 0, 16, 16]])
	end
end

#====================================================================
#== Pokemon Storage Scene script changes                           ==
#====================================================================

class PokemonStorageScene
	def pbUpdateOverlay(selection, party = nil)
		overlay = @sprites["overlay"].bitmap
		overlay.clear
		if !@sprites["plugin_overlay"]
			@sprites["plugin_overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @boxsidesviewport)
			pbSetSystemFont(@sprites["plugin_overlay"].bitmap)
		end
		plugin_overlay = @sprites["plugin_overlay"].bitmap
		plugin_overlay.clear
		buttonbase = Color.new(248, 248, 248)
		buttonshadow = Color.new(80, 80, 80)
		pbDrawTextPositions(
			overlay,
			[[_INTL("Party: {1}", (@storage.party.length rescue 0)), 270, 334, 2, buttonbase, buttonshadow, 1],
			[_INTL("Exit"), 446, 334, 2, buttonbase, buttonshadow, 1]]
		)
		pokemon = nil
		if @screen.pbHeldPokemon
			pokemon = @screen.pbHeldPokemon
		elsif selection >= 0
			pokemon = (party) ? party[selection] : @storage[@storage.currentBox, selection]
		end
		if !pokemon
			@sprites["pokemon"].visible = false
			return
		end
		@sprites["pokemon"].visible = true
		base   = Color.new(88, 88, 80)
		shadow = Color.new(168, 184, 184)
		nonbase   = Color.new(208, 208, 208)
		nonshadow = Color.new(224, 224, 224)
		pokename = pokemon.name
		textstrings = [
			[pokename, 10, 14, false, base, shadow]
		]
		if !pokemon.egg?
			imagepos = []
			if pokemon.male?
				textstrings.push([_INTL("♂"), 148, 14, false, Color.new(24, 112, 216), Color.new(136, 168, 208)])
			elsif pokemon.female?
				textstrings.push([_INTL("♀"), 148, 14, false, Color.new(248, 56, 32), Color.new(224, 152, 144)])
			end
			imagepos.push(["Graphics/Pictures/Storage/overlay_lv", 6, 246])
			textstrings.push([pokemon.level.to_s, 28, 240, false, base, shadow])
			if pokemon.ability
				textstrings.push([pokemon.ability.name, 86, 312, 2, base, shadow])
			else
				textstrings.push([_INTL("No ability"), 86, 312, 2, nonbase, nonshadow])
			end
			if pokemon.item
				textstrings.push([pokemon.item.name, 86, 348, 2, base, shadow])
			else
				textstrings.push([_INTL("No item"), 86, 348, 2, nonbase, nonshadow])
			end
			if pokemon.shiny?
				shiny_filename = (pokemon.super_shiny?) ? "Graphics/Plugins/Visually Different Super Shiny/super shiny" : "Graphics/Pictures/shiny"
				pbDrawImagePositions(plugin_overlay, [[shiny_filename, 134, 16]])
			end
			if PluginManager.installed?("ZUD Mechanics")
				pbDisplayGmaxFactor(pokemon, plugin_overlay, 8, 52)
			end
			if PluginManager.installed?("Pokémon Birthsigns")
				pbDisplayToken(pokemon, plugin_overlay, 149, 167, true)
			end
			if PluginManager.installed?("Enhanced UI")
				pbDisplayShinyLeaf(pokemon, plugin_overlay, 158, 50)      if Settings::STORAGE_SHINY_LEAF
				pbDisplayIVRatings(pokemon, plugin_overlay, 8, 198, true) if Settings::STORAGE_IV_RATINGS
			end
			typebitmap = AnimatedBitmap.new(_INTL("Graphics/Pictures/types"))
			pokemon.types.each_with_index do |type, i|
			type_number = GameData::Type.get(type).icon_position
			type_rect = Rect.new(0, type_number * 28, 64, 28)
			type_x = (pokemon.types.length == 1) ? 52 : 18 + (70 * i)
			overlay.blt(type_x, 272, typebitmap.bitmap, type_rect)
			end
			drawMarkings(overlay, 70, 240, 128, 20, pokemon.markings)
			pbDrawImagePositions(overlay, imagepos)
		end
		pbDrawTextPositions(overlay, textstrings)
		@sprites["pokemon"].setPokemonBitmap(pokemon)
	end
end

#====================================================================
#== Pokemon Summary Scene script changes                           ==
#====================================================================

class PokemonSummary_Scene
	def drawPage(page)
		if @pokemon.egg?
			drawPageOneEgg
			return
		end
		@sprites["itemicon"].item = @pokemon.item_id
		overlay = @sprites["overlay"].bitmap
		overlay.clear
		base   = Color.new(248, 248, 248)
		shadow = Color.new(104, 104, 104)
		# Set background image
		@sprites["background"].setBitmap("Graphics/Pictures/Summary/bg_#{page}")
		imagepos = []
		# Show the Poké Ball containing the Pokémon
		ballimage = sprintf("Graphics/Pictures/Summary/icon_ball_%s", @pokemon.poke_ball)
		imagepos.push([ballimage, 14, 60])
		# Show status/fainted/Pokérus infected icon
		status = -1
		if @pokemon.fainted?
			status = GameData::Status.count - 1
		elsif @pokemon.status != :NONE
			status = GameData::Status.get(@pokemon.status).icon_position
		elsif @pokemon.pokerusStage == 1
			status = GameData::Status.count
		end
		if status >= 0
			imagepos.push(["Graphics/Pictures/statuses", 124, 100, 0, 16 * status, 44, 16])
		end
		# Show Pokérus cured icon
		if @pokemon.pokerusStage == 2
			imagepos.push([sprintf("Graphics/Pictures/Summary/icon_pokerus"), 176, 100])
		end
		# Show shininess star
		if @pokemon.shiny?
			shiny_filename = (@pokemon.super_shiny?) ? "Graphics/Plugins/Visually Different Super Shiny/super shiny" : "Graphics/Pictures/shiny"
			imagepos.push([sprintf(shiny_filename), 2, 134])
		end
		# Draw all images
		pbDrawImagePositions(overlay, imagepos)
		# Write various bits of text
		pagename = [_INTL("INFO"),
			_INTL("TRAINER MEMO"),
			_INTL("SKILLS"),
			_INTL("MOVES"),
			_INTL("RIBBONS")][page - 1]
		textpos = [
			[pagename, 26, 22, 0, base, shadow],
			[@pokemon.name, 46, 68, 0, base, shadow],
			[@pokemon.level.to_s, 46, 98, 0, Color.new(64, 64, 64), Color.new(176, 176, 176)],
			[_INTL("Item"), 66, 324, 0, base, shadow]
		]
		# Write the held item's name
		if @pokemon.hasItem?
			textpos.push([@pokemon.item.name, 16, 358, 0, Color.new(64, 64, 64), Color.new(176, 176, 176)])
		else
			textpos.push([_INTL("None"), 16, 358, 0, Color.new(192, 200, 208), Color.new(208, 216, 224)])
		end
		# Write the gender symbol
		if @pokemon.male?
			textpos.push([_INTL("♂"), 178, 68, 0, Color.new(24, 112, 216), Color.new(136, 168, 208)])
		elsif @pokemon.female?
			textpos.push([_INTL("♀"), 178, 68, 0, Color.new(248, 56, 32), Color.new(224, 152, 144)])
		end
		# Draw all text
		pbDrawTextPositions(overlay, textpos)
		# Draw the Pokémon's markings
		drawMarkings(overlay, 84, 292)
		# Draw page-specific information
		case page
		when 1 then drawPageOne
		when 2 then drawPageTwo
		when 3 then drawPageThree
		when 4 then drawPageFour
		when 5 then drawPageFive
		end
	end
	
	if (PluginManager.installed?("ZUD Mechanics")) then
		alias zud_drawPage drawPage
		def drawPage(page)
			@sprites["pokemon"].unDynamax
		if !@sprites["zud_overlay"]
			@sprites["zud_overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
		else
			@sprites["zud_overlay"].bitmap.clear
		end
			overlay = @sprites["zud_overlay"].bitmap
			coords = (PluginManager.installed?("BW Summary Screen")) ? [454, 82] : [88, 95]
			pbDisplayGmaxFactor(@pokemon, overlay, coords[0], coords[1])
			zud_drawPage(page)
		end
	end
end
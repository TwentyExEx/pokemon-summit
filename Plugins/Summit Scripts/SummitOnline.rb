def pbOnlineValidityCheck
  if $player.party_count == 0
    pbMessage(_INTL("\\bI'm sorry, you must have a Pokémon to enter the Cable Club."))
    return false
  end
  teamspecies = []
  for pkmn in $player.party
    specform = pkmn.species.to_s << "_" << pkmn.form.to_s
    if !teamspecies.include?(specform)
    	teamspecies.push(specform)
    else
    	pbMessage(_INTL("\\bI'm sorry, you must not have more than one Pokémon of the same species and form to enter the Cable Club."))
    	return false
    end
  end
  return true
end

def pbOnlineMusicChanger
	cmd = pbConfirmMessage(_INTL("\\bWould you like to change the online music?"))
    if cmd == true
    	regionlist = ["Kanto","Johto","Hoenn","Sinnoh","Unova","Kalos","Alola","Galar","Hisui","Paldea","Other","Cancel"]
    	chooseregion = pbMessage(_INTL("\\bPlease choose a region."),regionlist,regionlist.length)
    	region = regionlist[chooseregion]
    	case region
		when "Kanto"
	    	soundtypelist = ["Masters EX","RBY","FRLG","Cancel"]
	    	choosetype = pbMessage(_INTL("\\bPlease choose a sound type."),soundtypelist,soundtypelist.length)
			soundtype = soundtypelist[choosetype]
			case soundtype
			when "Masters EX"
				tracklist = 
				["kanto_ex_agatha.ogg",
				"kanto_ex_ash.ogg",
				"kanto_ex_blue.ogg",
				"kanto_ex_bruno.ogg",
				"kanto_ex_giovanni.ogg",
				"kanto_ex_lance.ogg",
				"kanto_ex_leader.ogg",
				"kanto_ex_lorelei.ogg",
				"kanto_ex_red.ogg",
				"kanto_ex_red2.ogg",
		    "kanto_ex_wild.ogg"]
				tracknames = ["Agatha","Ash","Blue","Bruno","Giovanni","Lance","Gym Leader","Legendary","Lorelei","Red","Red (Alt)","Wild","Cancel"]
			when "RBY"
				tracklist = 
				["kanto_rby_blue.ogg",
		        "kanto_rby_leader.ogg",
		        "kanto_rby_trainer.ogg",
		        "kanto_rby_wild.ogg"]
		        tracknames = ["Blue","Gym Leader","Trainer","Wild","Cancel"]
		   when "FRLG"
				tracklist = 
		    	["kanto_frlg_blue.ogg",
				"kanto_frlg_leader.ogg",
				"kanto_frlg_legend.ogg",
				"kanto_frlg_mewtwo.ogg",
				"kanto_frlg_trainer.ogg",
				"kanto_frlg_wild.ogg"]
				tracknames = ["Blue","Gym Leader","Legendary","Mewtwo","Trainer","Wild","Cancel"]
			when "Cancel"
				pbMessage(_INTL("\\bBattle music selection cancelled."))
		    return
			end
		when "Johto"
    	soundtypelist = ["Masters EX","GSC","HGSS","Cancel"]
    	choosetype = pbMessage(_INTL("\\bPlease choose a sound type."),soundtypelist,soundtypelist.length)
			soundtype = soundtypelist[choosetype]
			case soundtype
			when "Masters EX"
				tracklist =
				["johto_ex_bruno.ogg",
		        "johto_ex_karen.ogg",
		        "johto_ex_koga.ogg",
		        "johto_ex_lance.ogg",
		        "johto_ex_leader.ogg",
		        "johto_ex_rocketexecutive.ogg",
		        "johto_ex_silver.ogg",
		        "johto_ex_trainer.ogg",
		        "johto_ex_wild.ogg",
		        "johto_ex_will.ogg"]
				tracknames = ["Bruno","Karen","Koga","Lance","Gym Leader","Rocket Executive","Silver","Trainer","Wild","Will","Cancel"]
			when "GSC"
				tracklist =
				["johto_gsc_lance.ogg",
		        "johto_gsc_rocket.ogg",
		        "johto_gsc_silver.ogg",
		        "johto_gsc_trainer.ogg",
		        "johto_gsc_wild.ogg"]
				tracknames = ["Lance/Red","Team Rocket","Silver","Trainer","Wild","Cancel"]
			when "HGSS"
				tracklist =
				["johto_hgss_entei.ogg",
		        "johto_hgss_hooh.ogg",
		        "johto_hgss_lance.ogg",
		        "johto_hgss_leader.ogg",
		        "johto_hgss_lugia.ogg",
		        "johto_hgss_raikou.ogg",
		        "johto_hgss_rocket.ogg",
		        "johto_hgss_silver.ogg",
		        "johto_hgss_suicune.ogg",
		        "johto_hgss_trainer.ogg",
		        "johto_hgss_wild.ogg"]
				tracknames = ["Entei","Ho-Oh","Lance/Red","Gym Leader","Lugia","Raikou","Team Rocket","Silver","Suicune","Trainer","Wild","Cancel"]
			when "Cancel"
				pbMessage(_INTL("\\bBattle music selection cancelled."))
		    return
		    end
		when "Hoenn"
	    	soundtypelist = ["Masters EX","RSE","ORAS","Cancel"]
	    	choosetype = pbMessage(_INTL("\\bPlease choose a sound type."),soundtypelist,soundtypelist.length)
			soundtype = soundtypelist[choosetype]
			case soundtype
			when "Masters EX"
				tracklist =
				["hoenn_ex_archie.ogg",
				"hoenn_ex_drake.ogg",
				"hoenn_ex_frontier.ogg",
				"hoenn_ex_glacia.ogg",
				"hoenn_ex_leader.ogg",
				"hoenn_ex_lisia.ogg",
				"hoenn_ex_magmaaquaadmin.ogg",
				"hoenn_ex_maxie.ogg",
				"hoenn_ex_phoebe.ogg",
				"hoenn_ex_protag.ogg",
				"hoenn_ex_sidney.ogg",
				"hoenn_ex_steven.ogg",
				"hoenn_ex_wallace.ogg",
				"hoenn_ex_wally.ogg",
				"hoenn_ex_wild.ogg",
				"hoenn_ex_zinnia.ogg"]
				tracknames = ["Archie","Drake","Frontier Brain","Glacia","Gym Leader","Lisia","Team Magma/Aqua Admin","Maxie","Phoebe","Brendan/May","Sidney","Steven","Wallace","Wally","Wild","Zinnia","Cancel"]
			when "RSE"
				tracklist =
				["hoenn_rse_archiemaxie.ogg",
				"hoenn_rse_champion.ogg",
				"hoenn_rse_elitefour.ogg",
				"hoenn_rse_frontier.ogg",
				"hoenn_rse_leader.ogg",
				"hoenn_rse_legendary.ogg",
				"hoenn_rse_magmaaqua.ogg",
				"hoenn_rse_rival.ogg",
				"hoenn_rse_titan.ogg",
				"hoenn_rse_trainer.ogg",
				"hoenn_rse_wild.ogg"]
				tracknames = ["Archie/Maxie","Champion","Elite Four","Frontier Brain","Gym Leader","Super-Ancient","Team Magma/Aqua","Brendan/May","Titans","Trainer","Wild","Cancel"]
			when "ORAS"
				tracklist =
				["hoenn_oras_archiemaxie.ogg",
				"hoenn_oras_branmay.ogg",
				"hoenn_oras_champion.ogg",
				"hoenn_oras_deoxys.ogg",
				"hoenn_oras_elitefour.ogg",
				"hoenn_oras_frontier.ogg",
				"hoenn_oras_leader.ogg",
				"hoenn_oras_magmaaqua.ogg",
				"hoenn_oras_rayquaza.ogg",
				"hoenn_oras_superancient.ogg",
				"hoenn_oras_titan.ogg",
				"hoenn_oras_trainer.ogg",
				"hoenn_oras_wally.ogg",
				"hoenn_oras_wild.ogg",
				"hoenn_oras_worldchamp.ogg",
				"hoenn_oras_zinnia.ogg"]
				tracknames = ["Archie/Maxie","Brendan/May","Champion","Deoxys","Elite Four","Frontier Brain","Gym Leader","Team Magma/Aqua","Rayquaza","Groudon/Kyogre","Titans","Trainer","Wally","Wild","World Champion","Zinnia","Cancel"]
			when "Cancel"
				pbMessage(_INTL("\\bBattle music selection cancelled."))
		    return
		  end
		when "Sinnoh"
	    	soundtypelist = ["Masters EX","DPPT","Cancel"]
	    	choosetype = pbMessage(_INTL("\\bPlease choose a sound type."),soundtypelist,soundtypelist.length)
			soundtype = soundtypelist[choosetype]
			case soundtype
			when "Masters EX"
				tracklist =
				["sinnoh_ex_aaron.ogg",
				"sinnoh_ex_barry.ogg",
				"sinnoh_ex_bertha.ogg",
				"sinnoh_ex_cynthia.ogg",
				"sinnoh_ex_cyrus.ogg",
				"sinnoh_ex_flint.ogg",
				"sinnoh_ex_frontier.ogg",
				"sinnoh_ex_galacticcommander.ogg",
				"sinnoh_ex_leader.ogg",
				"sinnoh_ex_lucian.ogg",
				"sinnoh_ex_trainer.ogg",
				"sinnoh_ex_wild.ogg"]
				tracknames = ["Aaron","Barry","Bertha","Cynthia","Cyrus","Flint","Frontier Brain","Team Galactic Commander","Gym Leader","Lucian","Trainer","Wild","Cancel"]
			when "DPPT"
				tracklist =
				["sinnoh_dppt_arceus.ogg",
				"sinnoh_dppt_cynthia.ogg",
				"sinnoh_dppt_cyrus.ogg",
				"sinnoh_dppt_diaglapalkia.ogg",
				"sinnoh_dppt_elitefour.ogg",
				"sinnoh_dppt_frontier.ogg",
				"sinnoh_dppt_galacticcommander.ogg",
				"sinnoh_dppt_galacticgrunt.ogg",
				"sinnoh_dppt_giratina.ogg",
				"sinnoh_dppt_lake.ogg",
				"sinnoh_dppt_leader.ogg",
				"sinnoh_dppt_legendary.ogg",
				"sinnoh_dppt_barry.ogg",
				"sinnoh_dppt_trainer.ogg",
				"sinnoh_dppt_wild.ogg"]
				tracknames = ["Arceus","Cynthia","Cyrus","Dialga/Palkia","Elite Four","Frontier Brain","Team Galactic Commander","Team Galactic Grunt","Giratina","Lake Trio","Gym Leader","Legendary","Barry","Trainer","Wild","Cancel"]
		    when "Cancel"
		    	pbMessage(_INTL("\\bBattle music selection cancelled."))
		    	return
		    end			
		when "Unova"
	    	soundtypelist = ["Masters EX","BWBW2","Cancel"]
	    	choosetype = pbMessage(_INTL("\\bPlease choose a sound type."),soundtypelist,soundtypelist.length)
			soundtype = soundtypelist[choosetype]
			case soundtype
			when "Masters EX"
				tracklist =
				["unova_ex_alder.ogg",
				"unova_ex_bianca.ogg",
				"unova_ex_caitlin.ogg",
				"unova_ex_colress.ogg",
				"unova_ex_ghetsis.ogg",
				"unova_ex_grimsley.ogg",
				"unova_ex_hugh.ogg",
				"unova_ex_iris.ogg",
				"unova_ex_leader.ogg",
				"unova_ex_marshal.ogg",
				"unova_ex_n.ogg",
				"unova_ex_plasma.ogg",
				"unova_ex_shauntal.ogg",
				"unova_ex_subway.ogg",
				"unova_ex_trainer.ogg",
				"unova_ex_wild.ogg"]
				tracknames = ["Alder","Bianca","Caitlin","Colress","Ghetsis","Grimsley","Hugh","Iris","Gym Leader","Marshal","N","Team Plasma","Shauntal","Subway Boss","Trainer","Wild","Cancel"]
			when "BWBW2"
				tracklist =
				["unova_bw_alder.ogg",
				"unova_bw_bianca.ogg",
				"unova_bw_bwkyurem.ogg",
				"unova_bw_colress.ogg",
				"unova_bw_elitefour.ogg",
				"unova_bw_ghetsis.ogg",
				"unova_bw_ghetsis2.ogg",
				"unova_bw_hugh.ogg",
				"unova_bw_iris.ogg",
				"unova_bw_kyurem.ogg",
				"unova_bw_leader.ogg",
				"unova_bw_legendary.ogg",
				"unova_bw_n.ogg",
				"unova_bw_plasma.ogg",
				"unova_bw_reshiram.ogg",
				"unova_bw_trainer.ogg",
				"unova_bw_wild.ogg",
				"unova_bw_wild2.ogg",
				"unova_bw_worldchampion.ogg",
				"unova_bw_zekrom.ogg"]
				tracknames = ["Alder","Bianca","Black/White Kyurem","Colress","Elite Four","Ghetsis","Ghetsis 2","Hugh","Iris","Kyurem","Gym Leader","Legendary","N","Team Plasma","Reshiram","Trainer","Wild","Wild 2","World Champion","Zekrom","Cancel"]
		    when "Cancel"
		    	pbMessage(_INTL("\\bBattle music selection cancelled."))
		    	return
		    end			
		when "Kalos"
	    	soundtypelist = ["Masters EX","XY","Cancel"]
	    	choosetype = pbMessage(_INTL("\\bPlease choose a sound type."),soundtypelist,soundtypelist.length)
			soundtype = soundtypelist[choosetype]
			case soundtype
			when "Masters EX"
				tracklist =
				["kalos_ex_diantha.ogg",
				"kalos_ex_elitefour.ogg",
				"kalos_ex_emma.ogg",
				"kalos_ex_friends.ogg",
				"kalos_ex_leader.ogg",
				"kalos_ex_looker.ogg",
				"kalos_ex_lysandre.ogg",
				"kalos_ex_protag.ogg",
				"kalos_ex_sycamore.ogg",
				"kalos_ex_trainer.ogg"]
				tracknames = ["Diantha","Elite Four","Emma","Friends","Gym Leader","Looker","Lysandre","Calem/Serena","Sycamore","Trainer","Cancel"]
			when "XY"
				tracklist =
				["kalos_xy_diantha.ogg",
				"kalos_xy_elitefour.ogg",
				"kalos_xy_flare.ogg",
				"kalos_xy_friend.ogg",
				"kalos_xy_leader.ogg",
				"kalos_xy_lysandre.ogg",
				"kalos_xy_trainer.ogg",
				"kalos_xy_wild.ogg",
				"kalos_xy_xernyvel.ogg"]
				tracknames = ["Diantha","Elite Four","Team Flare","Friends","Gym Leader","Lysandre","Trainer","Wild","Xerneas/Yveltal","Cancel"]
		    when "Cancel"
		    	pbMessage(_INTL("\\bBattle music selection cancelled."))
		    	return
		    end			
		when "Alola"
	    	soundtypelist = ["Masters EX","SMUSUM","Cancel"]
	    	choosetype = pbMessage(_INTL("\\bPlease choose a sound type."),soundtypelist,soundtypelist.length)
			soundtype = soundtypelist[choosetype]
			case soundtype
			when "Masters EX"
				tracklist =
				["alola_ex_championhau.ogg",
				"alola_ex_gladion.ogg",
				"alola_ex_guzma.ogg",
				"alola_ex_hala.ogg",
				"alola_ex_hau.ogg",
				"alola_ex_kahili.ogg",
				"alola_ex_kahuna.ogg",
				"alola_ex_kukui.ogg",
				"alola_ex_lillie.ogg",
				"alola_ex_lusamine.ogg",
				"alola_ex_molayne.ogg",
				"alola_ex_olivia.ogg",
				"alola_ex_plumeria.ogg",
				"alola_ex_trainer.ogg"]
				tracknames = ["Champion Hau","Gladion","Guzma","Hala","Hau","Kahili","Kahuna","Kukui","Lillie","Lusamine","Molayne","Olivia","Plumeria","Trainer","Cancel"]
			when "SMUSUM"
				tracklist =
				["alola_sm_aether.ogg",
				"alola_sm_battletree.ogg",
				"alola_sm_champhau.ogg",
				"alola_sm_elitefour.ogg",
				"alola_sm_gladion.ogg",
				"alola_sm_guzma.ogg",
				"alola_sm_hau.ogg",
				"alola_sm_kahuna.ogg",
				"alola_sm_kukui.ogg",
				"alola_sm_necrozma.ogg",
				"alola_sm_skull.ogg",
				"alola_sm_skulladmin.ogg",
				"alola_sm_solaluna.ogg",
				"alola_sm_tapu.ogg",
				"alola_sm_trainer.ogg",
				"alola_sm_ub.ogg",
				"alola_sm_unecrozma.ogg",
				"alola_sm_ursquad.ogg",
				"alola_sm_utrainer.ogg",
				"alola_sm_wild.ogg"]
				tracknames = ["Aether Foundation","Battle Tree","Champion Hau","Elite Four","Gladion","Guzma","Hau","Kahuna","Kukui","Necrozma","Team Skull","Team Skull Admin","Solgaleo/Lunala","Tapu","Trainer","Ultra Beast","Ultra Necrozma","Ultra Recon Squad","Trainer Ultra","Wild","Cancel"]
		    when "Cancel"
		    	pbMessage(_INTL("\\bBattle music selection cancelled."))
		    	return
		    end			
		when "Galar"
	    	soundtypelist = ["Masters EX","SWSH","Cancel"]
	    	choosetype = pbMessage(_INTL("\\bPlease choose a sound type."),soundtypelist,soundtypelist.length)
			soundtype = soundtypelist[choosetype]
			case soundtype
			when "Masters EX"
				tracklist =
				["galar_ex_bede.ogg",
				"galar_ex_hop.ogg",
				"galar_ex_leader.ogg",
				"galar_ex_leon.ogg",
				"galar_ex_marnie.ogg",
				"galar_ex_piers.ogg",
				"galar_ex_sonia.ogg",
				"galar_ex_trainer.ogg"]
				tracknames = ["Bede","Hop","Gym Leader","Marnie","Piers","Sonia","Trainer","Cancel"]
			when "SWSH"
				tracklist =
				["galar_swsh_avery.ogg",
				"galar_swsh_bede.ogg",
				"galar_swsh_birds.ogg",
				"galar_swsh_championmustard.ogg",
				"galar_swsh_eternatus.ogg",
				"galar_swsh_hop.ogg",
				"galar_swsh_klara.ogg",
				"galar_swsh_leader.ogg",
				"galar_swsh_leon.ogg",
				"galar_swsh_marnie.ogg",
				"galar_swsh_mounts.ogg",
				"galar_swsh_mustard.ogg",
				"galar_swsh_peony.ogg",
				"galar_swsh_rose.ogg",
				"galar_swsh_trainer.ogg",
				"galar_swsh_wild.ogg",
				"galar_swsh_yell.ogg",
				"galar_swsh_zaza.ogg"]
				tracknames = ["Avery","Bede","Galarian Kanto Birds","Mustard (Final)","Eternatus","Hop","Klara","Gym Leader","Leon","Marnie","Glastrier/Spectrier","Mustard","Peony","President Rose","Trainer","Wild","Team Yell","Zacian/Zamazenta","Cancel"]
		    when "Cancel"
		    	pbMessage(_INTL("\\bBattle music selection cancelled."))
		    	return
		    end					
		when "Hisui"
			tracklist =
			["hisui_pla_alpha.ogg",
			"hisui_pla_volo.ogg",
			"hisui_pla_warden.ogg",
			"hisui_pla_wild.ogg"]
			tracknames = ["Alpha Encounter","Volo","Warden","Wild","Cancel"]		
		when "Paldea"
			tracklist =
			["paldea_sv_arven.ogg",
			"paldea_sv_cassiopeia.ogg",
			"paldea_sv_clavell.ogg",
			"paldea_sv_elitefour.ogg",
			"paldea_sv_geeta.ogg",
			"paldea_sv_jacq.ogg",
			"paldea_sv_koraimirai.ogg",
			"paldea_sv_leader.ogg",
			"paldea_sv_leadertera.ogg",
			"paldea_sv_legendary.ogg",
			"paldea_sv_nemona.ogg",
			"paldea_sv_nemonachamp.ogg",
			"paldea_sv_paradox.ogg",
			"paldea_sv_penny.ogg",
			"paldea_sv_sadaturo.ogg",
			"paldea_sv_staradmin.ogg",
			"paldea_sv_teraraid.ogg",
			"paldea_sv_titan.ogg",
			"paldea_sv_trainer.ogg",
			"paldea_sv_wildaz.ogg",
			"paldea_sv_wildeast.ogg",
			"paldea_sv_wildnorth.ogg",
			"paldea_sv_wildpocopath.ogg",
			"paldea_sv_wildsouth.ogg",
			"paldea_sv_wildwest.ogg"]
			tracknames = ["Arven","Cassiopeia","Clavell","Elite Four","Geeta","Jacq","Koraidon/Miraidon","Gym Leader","Gym Leader (Tera)","Legendary","Nemona","Nemona (Final)","Paradox","Penny","Sada/Turo","Team Star Admin","Tera Raid","Titans","Trainer","Wild (Area Zero)","Wild (East)","Wild (North)","Wild (Poco Path)","Wild (South)","Wild (West)","Cancel"]		
		when "Other"
    	soundtypelist = ["Battle Revolution","Mystery Dungeon","Cancel"]
    	choosetype = pbMessage(_INTL("\\bPlease choose a sound type."),soundtypelist,soundtypelist.length)
			soundtype = soundtypelist[choosetype]
			case soundtype
			when "Battle Revolution"
				tracklist =
				["bonus_pbr_courtyard.ogg",
				"bonus_pbr_crystal.ogg",
				"bonus_pbr_gateway.ogg",
				"bonus_pbr_magma.ogg",
				"bonus_pbr_mainstreet.ogg",
				"bonus_pbr_minorboss.ogg",
				"bonus_pbr_neon.ogg",
				"bonus_pbr_stargazer.ogg",
				"bonus_pbr_sunnypark.ogg",
				"bonus_pbr_sunset.ogg",
				"bonus_pbr_waterfall.ogg"]
				tracknames = ["Courtyard","Crystal","Gateway","Magma","Main Street","Minor Boss","Neon","Stargazer","Sunny Park","Sunset","Waterfall","Cancel"]
			when "Mystery Dungeon"
				tracklist =
				["bonus_pmd_boss.ogg",
				"bonus_pmd_dialga.ogg"]
				tracknames = ["Boss","Dialga's FttF","Cancel"]
		  when "Cancel"
		    pbMessage(_INTL("\\bBattle music selection cancelled."))
		  	return
		  end
	  when "Cancel"
	  	pbMessage(_INTL("\\bBattle music selection cancelled."))
	  	return			
		end	
		tracknum = pbMessage(_INTL("\\bPlease choose a track."),tracknames,tracknames.length)
		if tracknames[tracknum] != "Cancel"
			$game_variables[48] = tracklist[tracknum]
			trackdisp = region + " - " << tracknames[tracknum]
			trackdisp += " (" << soundtypelist[choosetype] + ")" if soundtypelist
			pbMessage(_INTL("\\bBattle music has been set to {1}.",trackdisp))
		else
			pbMessage(_INTL("\\bTrack selection cancelled."))
		end
	end
end

def pbOnlineAppearanceChanger
	cmd = pbConfirmMessage(_INTL("\\bWould you like to change your online appearance?"))
    if cmd == true
		varlist = ["Ace Trainer","Aether Employee","Team Aqua Grunt","Aroma Lady","Artist","Backpacker","Baker","Battle Girl","Beauty","Bellhop",
		"Biker","Bird Keeper","Black Belt","Boarder","Bug Catcher","Bug Maniac","Burglar","Butler","Cabbie","Café Master","Camera Man",
		"Camper","Channeler","Clerk","Clown","Collector","Cook","Cyclist","Dancer","Diver","Doctor","Dragon Tamer","Expert","Fairy Tale Girl",
		"Fire Breather","Fire Fighter","Fisher","Team Flare Grunt","Furisode Girl","Team Galactic Grunt","Gambler","Gardener","Gentleman",
		"Golfer","Harlequin","Hex Maniac","Hiker","Hoopster","Idol","Infielder","Janitor","Jogger","Juggler","Kimono Girl","Kindler","Lady",
		"Lass","League Staff","Linebacker","Madame","Team Magma Grunt","Maid","Medium","Model","Musician",
		"Ninja Boy","Nurse","Nursery Aide","Officer","Parasol Lady","Pilot","Team Plasma Grunt","Poké Fan","Poké Kid",
		"Poké Maniac","Pokémon Breeder","Pokémon Ranger","Postman","Preschooler","Psychic","Punk Girl","Punk Guy","Rail Staff",
		"Rancher","Reporter","Rich Boy","Rising Star","Rocker","Team Rocket Grunt","Roller Skater","Roughneck","Ruin Maniac",
		"Sage","Sailor","School Kid","Scientist","Skier","Team Skull Grunt","Sky Trainer","Smasher","Team Star Grunt",
		"Street Thug","Striker","Suit Actor","Super Nerd","Surfer","Swimmer","Teacher","Tourist","Trial Guide",
		"Triathlete","Tuber","Veteran","Waiter","Waitress","Worker","Team Yell Grunt","Youngster","Cancel"]
    	choosevar = pbMessage(_INTL("\\bPlease choose a trainer type to appear as."),varlist,varlist.length)
    	var = varlist[choosevar]
    	case var
		when "Ace Trainer"
	    	varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
			varlist = ["Alola","Hoenn","Johto","Kalos","Kanto","Sinnoh","Sinnoh (Winter)","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_ACETRAINER_ALOLA_M"
				when "Hoenn"
					ttype = "TRAINER_ACETRAINER_HOENN_M"
				when "Johto"
					ttype = "TRAINER_ACETRAINER_JOHTO_M"
				when "Kalos"
					ttype = "TRAINER_ACETRAINER_KALOS_M"
				when "Kanto"
					ttype = "TRAINER_ACETRAINER_KANTO_M"
				when "Sinnoh"
					ttype = "TRAINER_ACETRAINER_SINNOH_M"
				when "Sinnoh (Winter)"
					ttype = "TRAINER_ACETRAINER_SINNOH_WINTER_M"
				when "Unova"
					ttype = "TRAINER_ACETRAINER_UNOVA_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			when "Female"
			varlist = ["Alola","Hoenn","Johto","Kalos","Kanto","Sinnoh","Sinnoh (Winter)","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_ACETRAINER_ALOLA_F"
				when "Hoenn"
					ttype = "TRAINER_ACETRAINER_HOENN_F"
				when "Johto"
					ttype = "TRAINER_ACETRAINER_JOHTO_F"
				when "Kalos"
					ttype = "TRAINER_ACETRAINER_KALOS_F"
				when "Kanto"
					ttype = "TRAINER_ACETRAINER_KANTO_F"
				when "Sinnoh"
					ttype = "TRAINER_ACETRAINER_SINNOH_F"
				when "Sinnoh (Winter)"
					ttype = "TRAINER_ACETRAINER_SINNOH_WINTER_F"
				when "Unova"
					ttype = "TRAINER_ACETRAINER_UNOVA_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			end
		when "Aether Employee"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case gender
			when "Male"
				ttype = "TRAINER_AETHER_M"
			when "Female"
				ttype = "TRAINER_AETHER_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Team Aqua Grunt"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_AQUA_M"
			when "Female"
				ttype = "TRAINER_AQUA_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Aroma Lady"
			varlist = ["Hoenn","Kanto","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_AROMALADY_HOENN"
			when "Kanto"
				ttype = "TRAINER_AROMALADY_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_AROMALADY_SINNOH"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Artist"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Galar","Kalos","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Galar"
					ttype = "TRAINER_ARTIST_GALAR"
				when "Kalos"
					ttype = "TRAINER_ARTIST_KALOS_M"
				when "Sinnoh"
					ttype = "TRAINER_ARTIST_SINNOH"
				when "Unova"
					ttype = "TRAINER_ARTIST_UNOVA"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			when "Female"
				varlist = ["Kalos","Kanto","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Kalos"
					ttype = "TRAINER_ARTIST_KALOS_F"
				when "Kanto"
					ttype = "TRAINER_ARTIST_KANTO"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			end
		when "Backpacker"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Galar","Kalos","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Galar"
					ttype = "TRAINER_BACKPACKER_GALAR"
				when "Kalos"
					ttype = "TRAINER_BACKPACKER_KALOS"
				when "Unova"
					ttype = "TRAINER_BACKPACKER_UNOVA_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			when "Female"
				ttype = "TRAINER_BACKPACKER_UNOVA_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Baker"
			ttype = "TRAINER_BAKER"
		when "Battle Girl"
			varlist = ["Hoenn","Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_BATTLEGIRL_HOENN"
			when "Kalos"
				ttype = "TRAINER_BATTLEGIRL_KALOS"
			when "Kanto"
				ttype = "TRAINER_BATTLEGIRL_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_BATTLEGIRL_SINNOH"
			when "Unova"
				ttype = "TRAINER_BATTLEGIRL_UNOVA"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Beauty"
			varlist = ["Alola","Galar","Hoenn","Johto","Kalos","Kanto","Paldea","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Alola"
				ttype = "TRAINER_BEAUTY_ALOLA"
			when "Galar"
				ttype = "TRAINER_BEAUTY_GALAR"
			when "Hoenn"
				ttype = "TRAINER_BEAUTY_HOENN"
			when "Johto"
				ttype = "TRAINER_BEAUTY_JOHTO"
			when "Kalos"
				ttype = "TRAINER_BEAUTY_KALOS"
			when "Kanto"
				ttype = "TRAINER_BEAUTY_KANTO"
			when "Paldea"
				ttype = "TRAINER_BEAUTY_PALDEA"
			when "Sinnoh"
				ttype = "TRAINER_BEAUTY_SINNOH"
			when "Unova"
				ttype = "TRAINER_BEAUTY_UNOVA"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Bellhop"
			ttype = "TRAINER_BELLHOP"
		when "Biker"
			varlist = ["Johto","Kanto","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Johto"
				ttype = "TRAINER_BIKER_JOHTO"
			when "Kanto"
				ttype = "TRAINER_BIKER_KANTO"
			when "Unova"
				ttype = "TRAINER_BIKER_UNOVA"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Bird Keeper"
			varlist = ["Hoenn","Johto","Kanto","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_BIRDKEEPER_HOENN"
			when "Johto"
				ttype = "TRAINER_BIRDKEEPER_JOHTO"
			when "Kanto"
				ttype = "TRAINER_BIRDKEEPER_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_BIRDKEEPER_SINNOH"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Black Belt"
			varlist = ["Alola","Galar","Johto","Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Alola"
				ttype = "TRAINER_BLACKBELT_ALOLA"
			when "Galar"
				ttype = "TRAINER_BLACKBELT_GALAR"
			when "Johto"
				ttype = "TRAINER_BLACKBELT_JOHTO"
			when "Kalos"
				ttype = "TRAINER_BLACKBELT_KALOS"
			when "Kanto"
				ttype = "TRAINER_BLACKBELT_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_BLACKBELT_SINNOH"
			when "Unova"
				ttype = "TRAINER_BLACKBELT_UNOVA"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Boarder"
			ttype = "TRAINER_BOARDER"
		when "Bug Catcher"
			varlist = ["Hoenn","Johto","Kanto","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_BUGCATCHER_HOENN"
			when "Johto"
				ttype = "TRAINER_BUGCATCHER_JOHTO"
			when "Kanto"
				ttype = "TRAINER_BUGCATCHER_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_BUGCATCHER_SINNOH"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Burglar"
			varlist = ["Johto","Kanto","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Johto"
				ttype = "TRAINER_BURGLAR_JOHTO"
			when "Kanto"
				ttype = "TRAINER_BURGLAR_KANTO"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Butler"
			ttype = "TRAINER_BUTLER"
		when "Cabbie"
			ttype = "TRAINER_CABBIE"
		when "Café Master"
			ttype = "TRAINER_CAFEMASTER"
		when "Camera Man"
			varlist = ["Galar","Hoenn","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Galar"
				ttype = "TRAINER_CAMERAMAN_GALAR"
			when "Hoenn"
				ttype = "TRAINER_CAMERAMAN_HOENN"
			when "Sinnoh"
				ttype = "TRAINER_CAMERAMAN_SINNOH"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Camper"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Hoenn","Kanto","Sinnoh","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Hoenn"
					ttype = "TRAINER_CAMPER_HOENN_M"
				when "Kanto"
					ttype = "TRAINER_CAMPER_KANTO_M"
				when "Sinnoh"
					ttype = "TRAINER_CAMPER_SINNOH_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			when "Female"
				case var
				when "Hoenn"
					ttype = "TRAINER_CAMPER_HOENN_F"
				when "Kanto"
					ttype = "TRAINER_CAMPER_KANTO_F"
				when "Sinnoh"
					ttype = "TRAINER_CAMPER_SINNOH_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Channeler"
			ttype = "TRAINER_CHANNELER"
		when "Clerk"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Alola","Galar","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_CLERK_ALOLA_M"
				when "Galar"
					ttype = "TRAINER_CLERK_GALAR_M"
				when "Unova"
					ttype = "TRAINER_CLERK_UNOVA_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			when "Female"
				varlist = ["Alola","Galar","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_CLERK_ALOLA_M"
				when "Galar"
					ttype = "TRAINER_CLERK_GALAR_M"
				when "Unova"
					ttype = "TRAINER_CLERK_UNOVA_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Clown"
			ttype = "TRAINER_CLOWN"
		when "Collector"
			varlist = ["Alola","Hoenn","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Alola"
				ttype = "TRAINER_COLLECTOR_ALOLA"
			when "Hoenn"
				ttype = "TRAINER_COLLECTOR_HOENN"
			when "Sinnoh"
				ttype = "TRAINER_COLLECTOR_SINNOH"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Cook"
			varlist = ["Alola","Galar","Kalos","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Alola"
				ttype = "TRAINER_COOK_ALOLA"
			when "Galar"
				ttype = "TRAINER_COOK_GALAR"
			when "Kalos"
				ttype = "TRAINER_COOK_KALOS"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end		
		when "Cyclist"
	    	varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
			varlist = ["Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
				case var
				when "Sinnoh"
					ttype = "TRAINER_CYCLIST_SINNOH_M"
				when "Unova"
					ttype = "TRAINER_CYCLIST_UNOVA_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			when "Female"
			varlist = ["Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
				case var
				when "Sinnoh"
					ttype = "TRAINER_CYCLIST_SINNOH_F"
				when "Unova"
					ttype = "TRAINER_CYCLIST_UNOVA_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			end
		when "Dancer"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_DANCER_UNOVA"
			when "Female"
				varlist = ["Alola","Galar","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_DANCER_ALOLA"
				when "Galar"
					ttype = "TRAINER_DANCER_GALAR"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))			
			end
		when "Diver"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_DIVER_M"
			when "Female"
				ttype = "TRAINER_DIVER_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Doctor"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Galar","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Galar"
					ttype = "TRAINER_DOCTOR_GALAR_M"
				when "Unova"
					ttype = "TRAINER_DOCTOR_UNOVA"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				ttype = "TRAINER_DANCER_UNOVA"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Dragon Tamer"
			varlist = ["Hoenn","Kanto","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_DRAGONTAMER_HOENN"
			when "Kanto"
				ttype = "TRAINER_DRAGONTAMER_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_DRAGONTAMER_SINNOH"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end		
		when "Expert"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_EXPERT_M"
			when "Female"
				ttype = "TRAINER_EXPERT_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Fairy Tale Girl"
			ttype = "TRAINER_FAIRYTALEGIRL"
		when "Fire Breather"
			ttype = "TRAINER_FIREBREATHER"
		when "Fire Fighter"
			ttype = "TRAINER_FIREFIGHTER"
		when "Fisher"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Alola","Hoenn","Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_FISHER_ALOLA"
				when "Hoenn"
					ttype = "TRAINER_FISHER_HOENN"
				when "Kalos"
					ttype = "TRAINER_FISHER_KALOS"
				when "Kanto"
					ttype = "TRAINER_FISHER_KANTO"
				when "Sinnoh"
					ttype = "TRAINER_FISHER_SINNOH"
				when "Unova"
					ttype = "TRAINER_FISHER_UNOVA"					
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				ttype = "TRAINER_FISHER_GALAR"		
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))			
			end
		when "Team Flare Grunt"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_FLARE_M"
			when "Female"
				ttype = "TRAINER_FLARE_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Furisode Girl"
			varlist = ["Black Robed","Blue Robed","Purple Robed","White Robed","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a style variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Black Robed"
				ttype = "TRAINER_FURISODEGIRL_BLACK"
			when "Blue Robed"
				ttype = "TRAINER_FURISODEGIRL_BLUE"
			when "Purple Robed"
				ttype = "TRAINER_FURISODEGIRL_PURPLE"
			when "White Robed"
				ttype = "TRAINER_FURISODEGIRL_WHITE"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Team Galactic Grunt"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_GALACTIC_M"
			when "Female"
				ttype = "TRAINER_GALACTIC_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Gambler"
			varlist = ["Kanto","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Kanto"
				ttype = "TRAINER_GAMBLER_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_GAMBLER_SINNOH"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end		
		when "Gardener"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_GARDENER_M"
			when "Female"
				ttype = "TRAINER_GARDENER_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Gentleman"
			varlist = ["Alola","Galar","Hoenn","Johto","Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Alola"
				ttype = "TRAINER_GENTLEMAN_ALOLA"
			when "Galar"
				ttype = "TRAINER_GENTLEMAN_GALAR"
			when "Hoenn"
				ttype = "TRAINER_GENTLEMAN_HOENN"
			when "Johto"
				ttype = "TRAINER_GENTLEMAN_JOHTO"
			when "Kalos"
				ttype = "TRAINER_GENTLEMAN_KALOS"
			when "Kanto"
				ttype = "TRAINER_GENTLEMAN_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_GENTLEMAN_SINNOH"
			when "Unova"
				ttype = "TRAINER_GENTLEMAN_UNOVA"				
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end		
		when "Golfer"
			ttype = "TRAINER_GOLFER"
		when "Harlequin"
			ttype = "TRAINER_HARLEQUIN"		
		when "Hex Maniac"
			ttype = "TRAINER_HEXMANIAC"	
		when "Hiker"
			varlist = ["Alola","Galar","Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Alola"
				ttype = "TRAINER_HIKER_ALOLA"
			when "Galar"
				ttype = "TRAINER_HIKER_GALAR"
			when "Kalos"
				ttype = "TRAINER_HIKER_KALOS"
			when "Kanto"
				ttype = "TRAINER_HIKER_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_HIKER_SINNOH"
			when "Unova"
				ttype = "TRAINER_HIKER_UNOVA"				
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end		
		when "Hoopster"
			ttype = "TRAINER_HOOPSTER"	
		when "Idol"
			ttype = "TRAINER_IDOL"		
		when "Infielder"
			ttype = "TRAINER_INFIELDER"
		when "Janitor"
			varlist = ["Alola","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Alola"
				ttype = "TRAINER_JANITOR_ALOLA"
			when "Unova"
				ttype = "TRAINER_JANITOR_UNOVA"				
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end				
		when "Jogger"
			ttype = "TRAINER_JOGGER"		
		when "Juggler"
			ttype = "TRAINER_JUGGLER"	
		when "Kimono Girl"
			ttype = "TRAINER_KIMONOGIRL"	
		when "Kindler"
			ttype = "TRAINER_KINDLER"
		when "Lady"
			varlist = ["Hoenn","Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_LADY_HOENN"
			when "Kalos"
				ttype = "TRAINER_LADY_KALOS"
			when "Kanto"
				ttype = "TRAINER_LADY_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_LADY_SINNOH"
			when "Unova"
				ttype = "TRAINER_LADY_UNOVA"			
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Lass"
			varlist = ["Alola","Galar","Hoenn","Johto","Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Alola"
				ttype = "TRAINER_LASS_ALOLA"
			when "Galar"
				ttype = "TRAINER_LASS_GALAR"
			when "Hoenn"
				ttype = "TRAINER_LASS_HOENN"
			when "Johto"
				ttype = "TRAINER_LASS_JOHTO"
			when "Kalos"
				ttype = "TRAINER_LASS_KALOS"
			when "Kanto"
				ttype = "TRAINER_LASS_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_LASS_SINNOH"
			when "Unova"
				ttype = "TRAINER_LASS_UNOVA"				
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "League Staff"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_LEAGUESTAFF_M"
			when "Female"
				ttype = "TRAINER_LEAGUESTAFF_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Linebacker"
			ttype = "TRAINER_LINEBACKER"
		when "Madame"
			varlist = ["Alola","Galar","Kalos","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Alola"
				ttype = "TRAINER_MADAME_ALOLA"
			when "Galar"
				ttype = "TRAINER_MADAME_GALAR"
			when "Kalos"
				ttype = "TRAINER_MADAME_KALOS"
			when "Sinnoh"
				ttype = "TRAINER_MADAME_SINNOH"
			when "Unova"
				ttype = "TRAINER_MADAME_UNOVA"			
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Team Magma Grunt"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_MAGMA_M"
			when "Female"
				ttype = "TRAINER_MAGMA_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Maid"
			varlist = ["Kalos","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Kalos"
				ttype = "TRAINER_MAID_KALOS"
			when "Sinnoh"
				ttype = "TRAINER_MAID_SINNOH"
			when "Unova"
				ttype = "TRAINER_MAID_UNOVA"			
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end			
		when "Medium"
			ttype = "TRAINER_MEDIUM"
		when "Model"
			ttype = "TRAINER_MODEL"
		when "Musician"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Galar","Hoenn","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Galar"
					ttype = "TRAINER_MUSICIAN_GALAR"
				when "Hoenn"
					ttype = "TRAINER_MUSICIAN_HOENN"
				when "Sinnoh"
					ttype = "TRAINER_MUSICIAN_SINNOH"
				when "Unova"
					ttype = "TRAINER_MUSICIAN_UNOVA_M"					
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				ttype = "TRAINER_MUSICIAN_UNOVA_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Ninja Boy"
			varlist = ["Hoenn","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_NINJABOY_HOENN"
			when "Sinnoh"
				ttype = "TRAINER_NINJABOY_SINNOH"		
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Nurse"
			varlist = ["Alola","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_NURSE_ALOLA"
			when "Sinnoh"
				ttype = "TRAINER_NURSE_SINNOH"	
			when "Unova"
				ttype = "TRAINER_NURSE_UNOVA"	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Nursery Aide"
			ttype = "TRAINER_NURSERYAIDE"
		when "Officer"
			varlist = ["Alola","Galar","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_OFFICER_ALOLA"
			when "Galar"
				ttype = "TRAINER_OFFICER_GALAR"	
			when "Sinnoh"
				ttype = "TRAINER_OFFICER_SINNOH"	
			when "Unova"
				ttype = "TRAINER_OFFICER_UNOVA"	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Parasol Lady"
			varlist = ["Hoenn","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_PARASOLLADY_HOENN"
			when "Sinnoh"
				ttype = "TRAINER_PARASOLLADY_SINNOH"	
			when "Unova"
				ttype = "TRAINER_PARASOLLADY_UNOVA"	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Pilot"
			ttype = "TRAINER_PILOT"
		when "Musician"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Plasma Standard","Plasma Neo","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Plasma Standard"
					ttype = "TRAINER_PLASMA_M"
				when "Plasma Neo"
					ttype = "TRAINER_PLASMANEO_M"			
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				varlist = ["Plasma Standard","Plasma Neo","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Plasma Standard"
					ttype = "TRAINER_PLASMA_F"
				when "Plasma Neo"
					ttype = "TRAINER_PLASMANEO_F"			
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Poké Fan"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Hoenn","Kalos","Sinnoh","Unova","Galar","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Hoenn"
					ttype = "TRAINER_POKEFAN_HOENN_M"
				when "Kalos"
					ttype = "TRAINER_POKEFAN_KALOS_M"
				when "Sinnoh"
					ttype = "TRAINER_POKEFAN_SINNOH_M"
				when "Unova"
					ttype = "TRAINER_POKEFAN_UNOVA_M"			
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				varlist = ["Hoenn","Kalos","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Hoenn"
					ttype = "TRAINER_POKEFAN_HOENN_F"
				when "Kalos"
					ttype = "TRAINER_POKEFAN_KALOS_F"
				when "Sinnoh"
					ttype = "TRAINER_POKEFAN_SINNOH_F"
				when "Unova"
					ttype = "TRAINER_POKEFAN_UNOVA_F"			
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Poké Kid"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Galar","Sinnoh","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Galar"
					ttype = "TRAINER_POKEKID_GALAR_M"
				when "Sinnoh"
					ttype = "TRAINER_POKEKID_SINNOH"			
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				ttype = "TRAINER_POKEKID_GALAR_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Poké Maniac"
			varlist = ["Hoenn","Johto","Kanto","Paldea","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_POKEMANIAC_HOENN"
			when "Johto"
				ttype = "TRAINER_POKEMANIAC_JOHTO"	
			when "Kanto"
				ttype = "TRAINER_POKEMANIAC_KANTO"	
			when "Paldea"
				ttype = "TRAINER_POKEMANIAC_PALDEA"	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Pokémon Breeder"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Galar","Hoenn","Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Galar"
					ttype = "TRAINER_POKEMONBREEDER_GALAR_M"
				when "Hoenn"
					ttype = "TRAINER_POKEMONBREEDER_HOENN_M"	
				when "Kalos"
					ttype = "TRAINER_POKEMONBREEDER_KALOS_M"
				when "Kanto"
					ttype = "TRAINER_POKEMONBREEDER_KANTO"	
				when "Sinnoh"
					ttype = "TRAINER_POKEMONBREEDER_SINNOH_M"	
				when "Unova"
					ttype = "TRAINER_POKEMONBREEDER_UNOVA_M"	
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				varlist = ["Galar","Hoenn","Kalos","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Galar"
					ttype = "TRAINER_POKEMONBREEDER_GALAR_F"
				when "Hoenn"
					ttype = "TRAINER_POKEMONBREEDER_HOENN_F"	
				when "Kalos"
					ttype = "TRAINER_POKEMONBREEDER_KALOS_F"
				when "Sinnoh"
					ttype = "TRAINER_POKEMONBREEDER_SINNOH_F"	
				when "Unova"
					ttype = "TRAINER_POKEMONBREEDER_UNOVA_F"	
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Pokémon Ranger"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Hoenn","Kalos","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Hoenn"
					ttype = "TRAINER_POKEMONRANGER_HOENN_M"
				when "Kalos"
					ttype = "TRAINER_POKEMONRANGER_KALOS_M"	
				when "Sinnoh"
					ttype = "TRAINER_POKEMONRANGER_SINNOH_M"
				when "Unova"
					ttype = "TRAINER_POKEMONRANGER_UNOVA_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				varlist = ["Hoenn","Kalos","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Hoenn"
					ttype = "TRAINER_POKEMONRANGER_HOENN_F"
				when "Kalos"
					ttype = "TRAINER_POKEMONRANGER_KALOS_F"	
				when "Sinnoh"
					ttype = "TRAINER_POKEMONRANGER_SINNOH_F"
				when "Unova"
					ttype = "TRAINER_POKEMONRANGER_UNOVA_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Postman"
			ttype = "TRAINER_POSTMAN"
		when "Preschooler"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Alola","Kalos","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_PRESCHOOLER_ALOLA_M"
				when "Kalos"
					ttype = "TRAINER_PRESCHOOLER_KALOS_M"
				when "Unova"
					ttype = "TRAINER_PRESCHOOLER_UNOVA_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				varlist = ["Alola","Kalos","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_PRESCHOOLER_ALOLA_F"
				when "Kalos"
					ttype = "TRAINER_PRESCHOOLER_KALOS_F"
				when "Unova"
					ttype = "TRAINER_PRESCHOOLER_UNOVA_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Psychic"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Kalos"
					ttype = "TRAINER_PSYCHIC_KALOS"
				when "Kanto"
					ttype = "TRAINER_PSYCHIC_KANTO"
				when "Sinnoh"
					ttype = "TRAINER_PSYCHIC_SINNOH_M"
				when "Unova"
					ttype = "TRAINER_PSYCHIC_UNOVA_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				varlist = ["Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Sinnoh"
					ttype = "TRAINER_PSYCHIC_SINNOH_F"
				when "Unova"
					ttype = "TRAINER_PSYCHIC_UNOVA_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Punk Girl"
			varlist = ["Alola","Kalos","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Alola"
				ttype = "TRAINER_PUNKGIRL_ALOLA"
			when "Kalos"
				ttype = "TRAINER_PUNKGIRL_KALOS"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Punk Guy"
			varlist = ["Alola","Kalos","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Alola"
				ttype = "TRAINER_PUNKGUY_ALOLA"
			when "Kalos"
				ttype = "TRAINER_PUNKGUY_KALOS"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Rail Staff"
			ttype = "TRAINER_RAILSTAFF"
		when "Rancher"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_RANCHER_M"
			when "Female"
				ttype = "TRAINER_RANCHER_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Reporter"
			varlist = ["Galar","Hoenn","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Galar"
				ttype = "TRAINER_REPORTER_GALAR"
			when "Hoenn"
				ttype = "TRAINER_REPORTER_HOENN"
			when "Sinnoh"
				ttype = "TRAINER_REPORTER_SINNOH"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Rich Boy"
			varlist = ["Hoenn","Kalos","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_RICHBOY_HOENN"
			when "Kalos"
				ttype = "TRAINER_RICHBOY_KALOS"
			when "Sinnoh"
				ttype = "TRAINER_RICHBOY_SINNOH"
			when "Unova"
				ttype = "TRAINER_RICHBOY_UNOVA"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Rising Star"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Alola","Kalos","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_RISINGSTAR_ALOLA_M"
				when "Kalos"
					ttype = "TRAINER_RISINGSTAR_KALOS_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				varlist = ["Alola","Kalos","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_RISINGSTAR_ALOLA_F"
				when "Kalos"
					ttype = "TRAINER_RISINGSTAR_KALOS_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Rocker"
			ttype = "TRAINER_ROCKER"
		when "Team Rocket Grunt"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_ROCKET_M"
			when "Female"
				ttype = "TRAINER_ROCKET_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Roller Skater"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_ROLLERSKATER_M"
			when "Female"
				ttype = "TRAINER_ROLLERSKATER_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Roughneck"
			varlist = ["Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Sinnoh"
				ttype = "TRAINER_ROUGHNECK_SINNOH"
			when "Unova"
				ttype = "TRAINER_ROUGHNECK_UNOVA"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Ruin Maniac"
			varlist = ["Hoenn","Kanto","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_RUINMANIAC_HOENN"
			when "Kanto"
				ttype = "TRAINER_RUINMANIAC_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_RUINMANIAC_SINNOH"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Sage"
			ttype = "TRAINER_SAGE"
		when "Sailor"
			varlist = ["Hoenn","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_SAILOR_HOENN"
			when "Sinnoh"
				ttype = "TRAINER_SAILOR_SINNOH"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "School Kid"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Galar","Hoenn","Johto","Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Galar"
					ttype = "TRAINER_SCHOOLKID_GALAR_M"
				when "Hoenn"
					ttype = "TRAINER_SCHOOLKID_HOENN_M"
				when "Johto"
					ttype = "TRAINER_SCHOOLKID_JOHTO"
				when "Kalos"
					ttype = "TRAINER_SCHOOLKID_KALOS_M"
				when "Kanto"
					ttype = "TRAINER_SCHOOLKID_KANTO"
				when "Sinnoh"
					ttype = "TRAINER_SCHOOLKID_SINNOH_M"
				when "Unova"
					ttype = "TRAINER_SCHOOLKID_UNOVA_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				varlist = ["Galar","Hoenn","Kalos","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Galar"
					ttype = "TRAINER_SCHOOLKID_GALAR_F"
				when "Hoenn"
					ttype = "TRAINER_SCHOOLKID_HOENN_F"
				when "Kalos"
					ttype = "TRAINER_SCHOOLKID_KALOS_F"
				when "Sinnoh"
					ttype = "TRAINER_SCHOOLKID_SINNOH_F"
				when "Unova"
					ttype = "TRAINER_SCHOOLKID_UNOVA_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Scientist"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Alola","Johto","Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_SCIENTIST_ALOLA"
				when "Johto"
					ttype = "TRAINER_SCIENTIST_JOHTO"
				when "Kalos"
					ttype = "TRAINER_SCIENTIST_KALOS_M"
				when "Kanto"
					ttype = "TRAINER_SCIENTIST_KANTO"
				when "Sinnoh"
					ttype = "TRAINER_SCIENTIST_SINNOH"
				when "Unova"
					ttype = "TRAINER_SCIENTIST_UNOVA_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				varlist = ["Kalos","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Kalos"
					ttype = "TRAINER_SCIENTIST_KALOS_F"
				when "Unova"
					ttype = "TRAINER_SCIENTIST_UNOVA_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Skier"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Johto","Sinnoh","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Johto"
					ttype = "TRAINER_SKIER_JOHTO"
				when "Sinnoh"
					ttype = "TRAINER_SKIER_SINNOH_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				ttype = "TRAINER_SKIER_SINNOH_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Team Skull Grunt"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_SKULL_M"
			when "Female"
				ttype = "TRAINER_SKULL_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Sky Trainer"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_SKYTRAINER_M"
			when "Female"
				ttype = "TRAINER_SKYTRAINER_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Smasher"
			ttype = "TRAINER_SMASHER"
		when "Team Star Grunt"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Scarlet","Violet","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a version variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Scarlet"
					ttype = "TRAINER_STAR_SCARLET_M"
				when "Violet"
					ttype = "TRAINER_STAR_VIOLET_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				varlist = ["Scarlet","Violet","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a version variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Scarlet"
					ttype = "TRAINER_STAR_SCARLET_F"
				when "Violet"
					ttype = "TRAINER_STAR_VIOLET_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Street Thug"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_STREETTHUG_M"
			when "Female"
				ttype = "TRAINER_STREETTHUG_M"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Striker"
			ttype = "TRAINER_STRIKER"
		when "Suit Actor"
			ttype = "TRAINER_SUITACTOR"
		when "Super Nerd"
			varlist = ["Johto","Kanto","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Johto"
				ttype = "TRAINER_SUPERNERD_JOHTO"
			when "Kanto"
				ttype = "TRAINER_SUPERNERD_KANTO"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Surfer"
			ttype = "TRAINER_SURFER"
		when "Swimmer"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Alola","Galar","Hoenn","Johto","Kalos","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_SWIMMER_ALOLA_M"
				when "Galar"
					ttype = "TRAINER_SWIMMER_GALAR_M"
				when "Hoenn"
					ttype = "TRAINER_TOURIST_HOENN"
				when "Johto"
					ttype = "TRAINER_SWIMMER_JOHTO_M"
				when "Kalos"
					ttype = "TRAINER_SWIMMER_KALOS_M"
				when "Sinnoh"
					ttype = "TRAINER_SWIMMER_SINNOH_M"
				when "Unova"
					ttype = "TRAINER_SWIMMER_UNOVA_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				varlist = ["Alola","Galar","Johto","Kalos","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_SWIMMER_ALOLA_F"
				when "Galar"
					ttype = "TRAINER_SWIMMER_GALAR_F"
				when "Johto"
					ttype = "TRAINER_SWIMMER_JOHTO_F"
				when "Kalos"
					ttype = "TRAINER_SWIMMER_KALOS_F"
				when "Sinnoh"
					ttype = "TRAINER_SWIMMER_SINNOH_F"
				when "Unova"
					ttype = "TRAINER_SWIMMER_UNOVA_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Teacher"
			ttype = "TRAINER_TEACHER"
		when "Tourist"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Alola","Hoenn","Kalos","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_TOURIST_ALOLA_M"
				when "Hoenn"
					ttype = "TRAINER_TOURIST_HOENN"
				when "Kalos"
					ttype = "TRAINER_TOURIST_KALOS_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Female"
				varlist = ["Alola","Kalos","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_TOURIST_ALOLA_F"
				when "Kalos"
					ttype = "TRAINER_TOURIST_KALOS_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end	
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))					
			end
		when "Trial Guide"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_TRIALGUIDE_M"
			when "Female"
				ttype = "TRAINER_TRIALGUIDE_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Triathlete"
			varlist = ["Cyclist","Runner","Swim","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a outfit variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Cyclist"
				ttype = "TRAINER_TRIATHLETE_CYCLIST"
			when "Runner"
				ttype = "TRAINER_TRIATHLETE_RUNNER"
			when "Swim"
				ttype = "TRAINER_TRIATHLETE_SWIM"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Tuber"
	    	varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
			varlist = ["Hoenn","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
				case var
				when "Hoenn"
					ttype = "TRAINER_TUBER_HOENN_M"
				when "Sinnoh"
					ttype = "TRAINER_TUBER_SINNOH_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			when "Female"
			varlist = ["Hoenn","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
				case var
				when "Hoenn"
					ttype = "TRAINER_TUBER_HOENN_F"
				when "Sinnoh"
					ttype = "TRAINER_TUBER_SINNOH_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			end	
		when "Veteran"
	    	varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
			varlist = ["Alola","Kalos","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_VETERAN_ALOLA_M"
				when "Kalos"
					ttype = "TRAINER_VETERAN_KALOS_M"
				when "Unova"
					ttype = "TRAINER_VETERAN_UNOVA_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			when "Female"
			varlist = ["Alola","Kalos","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_VETERAN_ALOLA_F"
				when "Kalos"
					ttype = "TRAINER_VETERAN_KALOS_F"
				when "Unova"
					ttype = "TRAINER_VETERAN_UNOVA_F"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			end
		when "Waiter"
			varlist = ["Kalos","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Kalos"
				ttype = "TRAINER_WAITER_KALOS"
			when "Sinnoh"
				ttype = "TRAINER_WAITER_SINNOH"
			when "Unova"
				ttype = "TRAINER_WAITER_UNOVA"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Waitress"
			varlist = ["Kalos","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Kalos"
				ttype = "TRAINER_WAITRESS_KALOS"
			when "Sinnoh"
				ttype = "TRAINER_WAITRESS_SINNOH"
			when "Unova"
				ttype = "TRAINER_WAITRESS_UNOVA"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		when "Worker"
	    	varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
			varlist = ["Alola","Galar","Kalos","Kanto","Sinnoh","Unova","Unova (Winter)","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_ACETRAINER_ALOLA_M"
				when "Galar"
					ttype = "TRAINER_ACETRAINER_HOENN_M"
				when "Kalos"
					ttype = "TRAINER_ACETRAINER_JOHTO_M"
				when "Kanto"
					ttype = "TRAINER_ACETRAINER_KALOS_M"
				when "Sinnoh"
					ttype = "TRAINER_ACETRAINER_KANTO_M"
				when "Unova"
					ttype = "TRAINER_ACETRAINER_SINNOH_M"
				when "Unova (Winter)"
					ttype = "TRAINER_ACETRAINER_SINNOH_WINTER_M"
				when "Cancel"
					pbMessage(_INTL("\\bTrainer type selection cancelled."))
				end
			when "Female"
				ttype = "TRAINER_WORKER_GALAR_F"
			end
		when "Team Yell Grunt"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_YELL_M"
			when "Female"
				ttype = "TRAINER_YELL_F"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end
		when "Youngster"
			varlist = ["Alola","Galar","Hoenn","Johto","Kalos","Kanto","Paldea","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length)
			var = varlist[choosevar]
			case var
			when "Alola"
				ttype = "TRAINER_YOUNGSTER_ALOLA"
			when "Galar"
				ttype = "TRAINER_YOUNGSTER_GALAR"
			when "Hoenn"
				ttype = "TRAINER_YOUNGSTER_HOENN"
			when "Johto"
				ttype = "TRAINER_YOUNGSTER_JOHTO"
			when "Kalos"
				ttype = "TRAINER_YOUNGSTER_KALOS"
			when "Kanto"
				ttype = "TRAINER_YOUNGSTER_KANTO"
			when "Paldea"
				ttype = "TRAINER_YOUNGSTER_PALDEA"
			when "Sinnoh"
				ttype = "TRAINER_YOUNGSTER_SINNOH"
			when "Unova"
				ttype = "TRAINER_YOUNGSTER_UNOVA"
			when "Cancel"
				pbMessage(_INTL("\\bTrainer type selection cancelled."))
			end	
		end # end of all trainers
		if var != "Cancel"
			$player.online_trainer_type = ttype
			pbMessage(_INTL("\\bYour online trainer type appearance has been set."))
		else
			pbMessage(_INTL("\\bTrainer type selection cancelled."))
		end
	end
end
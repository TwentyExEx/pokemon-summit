def pbOnlineMusicChanger
	cmd = pbConfirmMessage(_INTL("\\bWould you like to change the online music?"))
    if cmd == true
    	regionlist = ["Kanto","Johto","Hoenn","Sinnoh","Unova","Kalos","Alola","Galar","Hisui","Paldea","Cancel"]
    	chooseregion = pbMessage(_INTL("\\bPlease choose a region."),regionlist,regionlist.length-1)
    	region = regionlist[chooseregion]
    	case region
		when "Kanto"
	    	soundtypelist = ["Masters EX","RBY","FRLG","Cancel"]
	    	choosetype = pbMessage(_INTL("\\bPlease choose a sound type."),soundtypelist,soundtypelist.length-1)
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
			end
		when "Johto"
	    	soundtypelist = ["Masters EX","GSC","HGSS","Cancel"]
	    	choosetype = pbMessage(_INTL("\\bPlease choose a sound type."),soundtypelist,soundtypelist.length-1)
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
			when "GSC"
				tracklist =
				["johto_gsc_lance.ogg",
		        "johto_gsc_rocket.ogg",
		        "johto_gsc_silver.ogg",
		        "johto_gsc_trainer.ogg",
		        "johto_gsc_wild.ogg"]
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
		    end
		end
		tracknum = pbMessage(_INTL("\\bPlease choose a track."),tracknames,tracknames.length-1)
		if tracknum != tracknames.length-1
			$PokemonGlobal.nextBattleBGM = tracklist[tracknum]
			trackdisp = region + " - " << tracknames[tracknum] + " (" << soundtypelist[choosetype] + ")"
			pbMessage(_INTL("\\bBattle music has been set to {1}.",trackdisp))
		else
			pbMessage(_INTL("\\bTrack selection cancelled."))
		end
	end
end

def pbOnlineAppearanceChanger
	cmd = pbConfirmMessage(_INTL("\\bWould you like to change your online appearance?"))
    if cmd == true
		trainerlist = ["Ace Trainer","Aether Employee","Team Aqua Grunt","Aroma Lady","Artist","Backpacker","Baker","Battle Girl","Beauty","Bellhop",
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
		"Triathlete","Tuber","Veteran","Waiter","Waitress","Worker","Team Yell Grunt","Youngster"]
    	choosetype = pbMessage(_INTL("\\bPlease choose a trainer type to appear as."),trainerlist,trainerlist.length-1)
    	type = trainerlist[choosetype]
    	case type
		when "Ace Trainer"
	    	varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length-1)
			var = varlist[choosevar]
			case var
			when "Male"
			varlist = ["Alola","Hoenn","Johto","Kalos","Kanto","Sinnoh","Sinnoh (Winter)","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
			var = varlist[chooseregion]
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
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
			var = varlist[chooseregion]
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
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length-1)
			var = varlist[choosevar]
			case gender
			when "Male"
				ttype = "TRAINER_AETHER_M"
			when "Female"
				ttype = "TRAINER_AETHER_F"
			end
		when "Team Aqua Grunt"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length-1)
			var = varlist[choosevar]
			case var
			when "Male"
				ttype = "TRAINER_AQUA_M"
			when "Female"
				ttype = "TRAINER_AQUA_F"
			end
		when "Aroma Lady"
			varlist = ["Hoenn","Kanto","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
			var = varlist[choosevar]
			case var
			when "Hoenn"
				ttype = "TRAINER_AROMALADY_HOENN"
			when "Kanto"
				ttype = "TRAINER_AROMALADY_KANTO"
			when "Sinnoh"
				ttype = "TRAINER_AROMALADY_SINNOH"
			end
		when "Artist"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length-1)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Galar","Kalos","Sinnoh","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
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
				end
			when "Female"
				varlist = ["Kalos","Kanto","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
				var = varlist[choosevar]
				case var
				when "Kalos"
					ttype = "TRAINER_ARTIST_KALOS_F"
				when "Kanto"
					ttype = "TRAINER_ARTIST_KANTO"
				end
			end
		when "Backpacker"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length-1)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Galar","Kalos","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
				var = varlist[choosevar]
				case var
				when "Galar"
					ttype = "TRAINER_BACKPACKER_GALAR"
				when "Kalos"
					ttype = "TRAINER_BACKPACKER_KALOS"
				when "Unova"
					ttype = "TRAINER_BACKPACKER_UNOVA_M"
				end
			when "Female"
				ttype = "TRAINER_BACKPACKER_UNOVA_F"
			end
		when "Baker"
			ttype = "TRAINER_BAKER"
		when "Battle Girl"
			varlist = ["Hoenn","Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
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
			end
		when "Beauty"
			varlist = ["Alola","Galar","Hoenn","Johto","Kalos","Kanto","Paldea","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
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
			end
		when "Bellhop"
			ttype = "TRAINER_BELLHOP"
		when "Biker"
			varlist = ["Johto","Kanto","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
			var = varlist[choosevar]
			case var
			when "Johto"
				ttype = "TRAINER_BIKER_JOHTO"
			when "Kanto"
				ttype = "TRAINER_BIKER_KANTO"
			when "Unova"
				ttype = "TRAINER_BIKER_UNOVA"
			end
		when "Bird Keeper"
			varlist = ["Hoenn","Johto","Kanto","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
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
			end
		when "Black Belt"
			varlist = ["Alola","Galar","Johto","Kalos","Kanto","Sinnoh","Unova","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
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
			end
		when "Boarder"
			ttype = "TRAINER_BOARDER"
		when "Bug Catcher"
			varlist = ["Hoenn","Johto","Kanto","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
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
			end
		when "Burglar"
			varlist = ["Johto","Kanto","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
			var = varlist[choosevar]
			case var
			when "Johto"
				ttype = "TRAINER_BURGLAR_JOHTO"
			when "Kanto"
				ttype = "TRAINER_BURGLAR_KANTO"
			end
		when "Butler"
			ttype = "TRAINER_BUTLER"
		when "Cabbie"
			ttype = "TRAINER_CABBIE"
		when "Café Master"
			ttype = "TRAINER_CAFEMASTER"
		when "Camera Man"
			varlist = ["Galar","Hoenn","Sinnoh","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
			var = varlist[choosevar]
			case var
			when "Galar"
				ttype = "TRAINER_CAMERAMAN_GALAR"
			when "Hoenn"
				ttype = "TRAINER_CAMERAMAN_HOENN"
			when "Sinnoh"
				ttype = "TRAINER_CAMERAMAN_SINNOH"
			end
		when "Camper"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length-1)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Hoenn","Kanto","Sinnoh","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
				var = varlist[choosevar]
				case var
				when "Hoenn"
					ttype = "TRAINER_CAMPER_HOENN_M"
				when "Kanto"
					ttype = "TRAINER_CAMPER_KANTO_M"
				when "Sinnoh"
					ttype = "TRAINER_CAMPER_SINNOH_M"
				end
			when "Female"
				case var
				when "Hoenn"
					ttype = "TRAINER_CAMPER_HOENN_F"
				when "Kanto"
					ttype = "TRAINER_CAMPER_KANTO_F"
				when "Sinnoh"
					ttype = "TRAINER_CAMPER_SINNOH_F"
			end
		when "Channeler"
			ttype = "TRAINER_CHANNELER"
		when "Clerk"
			varlist = ["Male","Female","Cancel"]
	    	choosevar = pbMessage(_INTL("\\bChoose a gender variation."),varlist,varlist.length-1)
			var = varlist[choosevar]
			case var
			when "Male"
				varlist = ["Alola","Galar","Unova","Cancel"]
	    		choosevar = pbMessage(_INTL("\\bChoose a region variation."),varlist,varlist.length-1)
				var = varlist[choosevar]
				case var
				when "Alola"
					ttype = "TRAINER_CLERK_ALOLA_M"
				when "Galar"
					ttype = "TRAINER_CLERK_GALAR_M"
				when "Unova"
					ttype = "TRAINER_CLERK_UNOVA_M"
				end
			when "Female"
				when "Alola"
					ttype = "TRAINER_CLERK_ALOLA_M"
				when "Galar"
					ttype = "TRAINER_CLERK_GALAR_M"
				when "Unova"
					ttype = "TRAINER_CLERK_UNOVA_M"
			end
		when "Clown"
			ttype = "TRAINER_CLOWN"

		end # end of all trainers
		if var != "Cancel"
			$player.online_trainer_type = ttype
			pbMessage(_INTL("\\bYour online trainer type appearance has been set."))
		else
			pbMessage(_INTL("\\bTrainer type selection cancelled."))
		end
	end
end
def pbOnlineMusicChanger
cmd = pbConfirmMessage(_INTL("Would you like to change the online music?"))
    if cmd == true
        region = pbMessage(_INTL("Please choose a region."),["Kanto","Johto","Hoenn","Sinnoh","Unova","Kalos","Alola","Galar","Hisui","Paldea","Cancel"],10) # 10 is Cancel
        case region
            when "Kanto"
				soundtype = pbMessage(_INTL("Please choose a Sound Type."),["EX Remix","Retro","Cancel"],2) # 2 is Cancel
				case soundtype
					when "EX Remix"
					    track = pbMessage(_INTL("Please choose a track."),["Gym Leader","Lorelei","Bruno","Agatha","Lance","Blue","Giovanni","Red","Red Alt","Leaf","Ash","Wild Battle","Cancel"],12) # 12 is Cancel
						case track
							when "Gym Leader"
								$game_variables[48] = "kanto_ex_leader"
							when "Lorelei"
								$game_variables[48] = "kanto_ex_lorelei"
							when "Bruno"
								$game_variables[48] = "kanto_ex_bruno"
							when "Agatha"
								$game_variables[48] = "kanto_ex_agatha"
							when "Lance"
								$game_variables[48] = "kanto_ex_lance"
							when "Blue"
								$game_variables[48] = "kanto_ex_blue"
							when "Giovanni"
								$game_variables[48] = "kanto_ex_giovanni"
							when "Red"
								$game_variables[48] = "kanto_ex_red"
							when "Red Alt"
								$game_variables[48] = "kanto_ex_red2"
							when "Leaf"
								$game_variables[48] = "kanto_ex_leaf"	
							when "Ash"
								$game_variables[48] = "kanto_ex_ash"	
							when "Wild Battle"
								$game_variables[48] = "kanto_ex_oak"									
					when "Retro"
					    track = pbMessage(_INTL("Please choose a track."),["Gym Leader","Blue","Trainer","Wild","Legendary","Mewtwo","Cancel"],6) # 6 is Cancel
						case track
							when "Gym Leader"
								$game_variables[48] = "kanto_og_leader"
							when "Blue"
								$game_variables[48] = "kanto_og_rival"
							when "Trainer"
								$game_variables[48] = "kanto_og_trainer"
							when "Wild"
								$game_variables[48] = "kanto_og_wild"
							when "Legendary"
								$game_variables[48] = "kanto_og_legend"
							when "Mewtwo"
								$game_variables[48] = "kanto_og_mewtwo"
					end
				end
			end
		end
    end
end
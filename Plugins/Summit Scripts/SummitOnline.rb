def pbOnlineMusicChanger
	cmd = pbConfirmMessage(_INTL("Would you like to change the online music?"))
    if cmd == true
    	regionlist = ["Kanto","Johto","Hoenn","Sinnoh","Unova","Kalos","Alola","Galar","Hisui","Paldea","Cancel"]
    	chooseregion = pbMessage(_INTL("Please choose a region."),regionlist,regionlist.length)
    	@region = regionlist[chooseregion].downcase
    	soundtypelist = ["EX Remix","Retro","Cancel"]
    	choosetype = pbMessage(_INTL("Please choose a sound type."),soundtypelist,soundtypelist.length)
		case soundtypelist[choosetype]
			when "EX Remix"
				@soundtype = "ex"
			when "Retro"
				@soundtype = "og"
		end
		tracklist = ["Gym Leader","Lorelei","Bruno","Agatha","Lance","Blue","Giovanni","Red","Red Alt","Leaf","Ash","Wild Battle","Cancel"]
	    choosename = pbMessage(_INTL("Please choose a track."),tracklist,tracklist.length)
		case tracklist[choosename]
			when "Gym Leader"
				@name = "leader"
			when "Lorelei"
				@name = "lorelei"
			when "Bruno"
				@name = "bruno"
			when "Agatha"
				@name = "agatha"
			when "Lance"
				@name = "lance"
			when "Blue"
				@name = "blue"
			when "Giovanni"
				@name = "giovanni"
			when "Red"
				@name = "red"
			when "Red Alt"
				@name = "red2"
			when "Leaf"
				@name = "leaf"	
			when "Ash"
				@name = "ash"	
			when "Wild Battle"
				@name = "oak"
		end
		trackname = @region<<"_"+@soundtype<<"_"+@name
		$game_variables[48] = trackname
	end
end
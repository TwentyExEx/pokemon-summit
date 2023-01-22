module SummitPokeTest
	# Array of all species listed
	@allspecies = [:KABUTOPS,:AERODACTYL,:GOLEM]

	def self.allspecies
		return @allspecies
	end

	KABUTOPS = {
		:species => :KABUTOPS,
		:moves => [:RAZORSHELL,:STONEAXE,:AQUAJET,:XSCISSOR],
		:form => 0,
		:ability_index => 1,
		:item => :LIFEORB,
		:nature => :JOLLY,
		:evs => [0,252,0,252,0,4]
	}
	AERODACTYL = {
		:species => :AERODACTYL,
		:moves => [:DRAGONDANCE,:DUALWINGBEAT,:THUNDERFANG,:ROCKSLIDE],
		:form => 0,
		:ability_index => 1,
		:item => :FOCUSSASH,
		:nature => :ADAMANT,
		:evs => [0,252,0,252,0,4]
	}
	GOLEM = {
		:species => :GOLEM,
		:moves => [:STONEEDGE,:BODYPRESS,:EARTHQUAKE,:FIREPUNCH],
		:form => 0,
		:ability_index => 1,
		:item => :FOCUSSASH,
		:nature => :ADAMANT,
		:evs => [252,252,0,0,0,4]
	}

end
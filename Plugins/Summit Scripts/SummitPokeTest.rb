module SummitPokeTest
	# Array of all species listed
	@allspecies = [:PKMN1] # ,:PKMN2,:PKMN3,:PKMN4,:PKMN5,:PKMN6]

	def self.allspecies
		return @allspecies
	end

	PKMN1 = {
		:species => :WOBBUFFET,
		:tera_type => :NORMAL,
		:moves => [:ENCORE,:COUNTER,:MIRRORCOAT,:DESTINYBOND],
		:form => 0,
		:ability_index => 1,
		# :item => :LIFEORB,
		:nature => :JOLLY,
		:evs => [0,252,0,252,0,4]
	}
	# PKMN2 = {
	# 	:species => :AERODACTYL,
	# 	:tera_type => :ELECTRIC,
	# 	:moves => [:DRAGONDANCE,:DUALWINGBEAT,:THUNDERFANG,:ROCKSLIDE],
	# 	:form => 0,
	# 	:ability_index => 1,
	# 	:item => :FOCUSSASH,
	# 	:nature => :ADAMANT,
	# 	:evs => [0,252,0,252,0,4]
	# }
	# PKMN3 = {
	# 	:species => :GOLEM,
	# 	:tera_type => :ELECTRIC,
	# 	:moves => [:STONEEDGE,:BODYPRESS,:EARTHQUAKE,:FIREPUNCH],
	# 	:form => 0,
	# 	:ability_index => 1,
	# 	:item => :FOCUSSASH,
	# 	:nature => :ADAMANT,
	# 	:evs => [252,252,0,0,0,4]
	# }
	# PKMN4 = {
	# 	:species => :GOLEM,
	# 	:tera_type => :ELECTRIC,
	# 	:moves => [:STONEEDGE,:BODYPRESS,:EARTHQUAKE,:FIREPUNCH],
	# 	:form => 0,
	# 	:ability_index => 1,
	# 	:item => :FOCUSSASH,
	# 	:nature => :ADAMANT,
	# 	:evs => [252,252,0,0,0,4]
	# }
	# PKMN5 = {
	# 	:species => :GOLEM,
	# 	:tera_type => :ELECTRIC,
	# 	:moves => [:STONEEDGE,:BODYPRESS,:EARTHQUAKE,:FIREPUNCH],
	# 	:form => 0,
	# 	:ability_index => 1,
	# 	:item => :FOCUSSASH,
	# 	:nature => :ADAMANT,
	# 	:evs => [252,252,0,0,0,4]
	# }
	# PKMN6 = {
	# 	:species => :GOLEM,
	# 	:tera_type => :ELECTRIC,
	# 	:moves => [:STONEEDGE,:BODYPRESS,:EARTHQUAKE,:FIREPUNCH],
	# 	:form => 0,
	# 	:ability_index => 1,
	# 	:item => :FOCUSSASH,
	# 	:nature => :ADAMANT,
	# 	:evs => [252,252,0,0,0,4]
	# }
end
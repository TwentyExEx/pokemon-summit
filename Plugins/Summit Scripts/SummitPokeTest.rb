module SummitPokeTest
	# Array of all species listed
	@allspecies = [:PKMN1,:PKMN2,:PKMN3]

	def self.allspecies
		return @allspecies
	end

	PKMN1 = {
		:species => :CLEFABLE,
		:tera_type => :FAIRY,
		:moves => [:STEALTHROCK,:MOONBLAST,:SOFTBOILED,:KNOCKOFF],
		:form => 0,
		:ability_index => 1,
		:item => :LEFTOVERS,
		:nature => :CALM,
		:evs => [252,0,200,0,0,56]
	}
	PKMN2 = {
		:species => :LOPUNNY,
		:tera_type => :FIGHTING,
		:moves => [:CLOSECOMBAT,:UTURN,:LASHOUT,:RETURN],
		:form => 0,
		:ability_index => 2,
		:item => :CHOICEBAND,
		:nature => :JOLLY,
		:evs => [0,252,0,252,0,4]
	}
	PKMN3 = {
		:species => :WOBBUFFET,
		:tera_type => :GHOST,
		:moves => [:ENCORE,:COUNTER,:MIRRORCOAT,:DESTINYBOND],
		:form => 0,
		:ability_index => 1,
		:item => :AGUAVBERRY,
		:nature => :CALM,
		:evs => [252,0,4,0,0,252]
	}
end
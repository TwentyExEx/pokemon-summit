ItemHandlers::UseOnPokemon.add(:TERASETNORMAL, proc { |item, qty, pkmn, scene|
	type = :NORMAL
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETFIRE, proc { |item, qty, pkmn, scene|
	type = :FIRE
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETWATER, proc { |item, qty, pkmn, scene|
	type = :WATER
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETGRASS, proc { |item, qty, pkmn, scene|
	type = :GRASS
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETELECTRIC, proc { |item, qty, pkmn, scene|
	type = :ELECTRIC
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETICE, proc { |item, qty, pkmn, scene|
	type = :ICE
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETFIGHTING, proc { |item, qty, pkmn, scene|
	type = :FIGHTING
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETPOISON, proc { |item, qty, pkmn, scene|
	type = :POISON
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETGROUND, proc { |item, qty, pkmn, scene|
	type = :GROUND
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETFLYING, proc { |item, qty, pkmn, scene|
	type = :FLYING
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETPSYCHIC, proc { |item, qty, pkmn, scene|
	type = :PSYCHIC
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETBUG, proc { |item, qty, pkmn, scene|
	type = :BUG
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETROCK, proc { |item, qty, pkmn, scene|
	type = :ROCK
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETGHOST, proc { |item, qty, pkmn, scene|
	type = :GHOST
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETDARK, proc { |item, qty, pkmn, scene|
	type = :DARK
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETDRAGON, proc { |item, qty, pkmn, scene|
	type = :DRAGON
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETSTEEL, proc { |item, qty, pkmn, scene|
	type = :STEEL
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})

ItemHandlers::UseOnPokemon.add(:TERASETFAIRY, proc { |item, qty, pkmn, scene|
	type = :FAIRY
	if pkmn.tera_type[0] == type
		scene.pbDisplay(_INTL("{1}'s Tera type is already {2}.", pkmn.name, type.name))
		next false
	end
	pkmn.tera_type=[type]
	scene.pbDisplay(_INTL("{1}'s Tera type is now {2}.", pkmn.name, pkmn.tera_type[0].name))
	next true
})
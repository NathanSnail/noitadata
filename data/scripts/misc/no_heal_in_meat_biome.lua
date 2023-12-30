function biome_entered( new_biome_name, old_biome_name )
	-- print( "new_biome_name: " .. new_biome_name )
	local e = GetUpdatedEntityID()

	if( new_biome_name == "$biome_meat" ) and ( GlobalsGetValue( "BOSS_MEAT_DEAD", "0" ) == "1" ) then
		EntitySetComponentsWithTagEnabled( e, "effect_no_heal_in_meat_biome", true )
	else
		EntitySetComponentsWithTagEnabled( e, "effect_no_heal_in_meat_biome", false )
	end
end
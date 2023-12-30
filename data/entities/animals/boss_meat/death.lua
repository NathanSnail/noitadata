dofile( "data/scripts/lib/utilities.lua" )

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	AddFlagPersistent( "miniboss_meat" )
	GlobalsSetValue( "BOSS_MEAT_DEAD", "1" )
	EntityLoad( "data/entities/items/wands/experimental/experimental_wand_4.xml", pos_x, pos_y - 12 )
	
	local e = EntityGetWithTag( "no_heal_in_meat_biome" )
	if ( #e > 0 ) then
		for i,v in ipairs( e ) do
			EntitySetComponentsWithTagEnabled( v, "effect_no_heal_in_meat_biome", false )
		end
		
		GamePrintImportant( "$log_boss_meat_death", "$logdesc_boss_meat_death" )
	end
end
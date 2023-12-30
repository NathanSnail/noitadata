dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local anger = tonumber( GlobalsGetValue( "HELPLESS_KILLS", "1" ) ) or 1
	anger = anger + 1
	GlobalsSetValue( "HELPLESS_KILLS", tostring(anger) )
	
	if ( GlobalsGetValue( "BOSS_SPIRIT_DEAD", "0" ) == "1" ) then
		local entity_id = GetUpdatedEntityID()
		local x, y = EntityGetTransform( entity_id )
		
		EntityLoad( "data/entities/projectiles/explosion.xml", x, y )
	end
end
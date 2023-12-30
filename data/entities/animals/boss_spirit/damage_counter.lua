dofile_once("data/scripts/lib/utilities.lua")

function damage_received( damage, msg, source )
	local entity_id = GetUpdatedEntityID()
	
	local anger = tonumber( GlobalsGetValue( "HELPLESS_KILLS", "1" ) ) or 1
	local dmg = damage * anger * 0.1
	
	local player = EntityGetWithTag( "player_unit" )
	
	for i,v in ipairs( player ) do
		EntityInflictDamage( v, dmg, "DAMAGE_CURSE", "$animal_islandspirit", "DISINTEGRATED", 0, 0, entity_id )
	end
end
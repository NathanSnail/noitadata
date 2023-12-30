dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( GetUpdatedEntityID() )

local anger = tonumber( GlobalsGetValue( "HELPLESS_KILLS", "1" ) ) or 1
print( "DEAD HELPLESS ANIMALS: " .. tostring( anger ) )

local p = EntityGetInRadiusWithTag( x, y, 200, "player_unit" )

if ( #p > 0 ) and ( anger >= 30 ) and ( GlobalsGetValue( "ISLANDSPIRIT_SPAWNED", "0" ) == "0" ) then
	GlobalsSetValue( "ISLANDSPIRIT_SPAWNED", "1" )
	
	EntityLoad( "data/entities/animals/boss_spirit/spawn_portal.xml", x, y )
	EntityKill( entity_id )
end
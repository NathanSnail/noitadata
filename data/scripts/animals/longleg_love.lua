dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local comp = GameGetGameEffect( entity_id, "CHARM" )
if ( comp ~= nil ) and ( comp ~= NULL_ENTITY ) then
	EntitySetComponentsWithTagEnabled( entity_id, "longleg_love", true )
else
	EntitySetComponentsWithTagEnabled( entity_id, "longleg_love", false )
end
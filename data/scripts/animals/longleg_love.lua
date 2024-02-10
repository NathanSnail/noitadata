dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local comp = GameGetGameEffect( entity_id, "CHARM" )
if ( comp ~= nil ) and ( comp ~= NULL_ENTITY ) then
	EntitySetComponentsWithTagEnabled( entity_id, "enabled_if_charmed", true )
else
	EntitySetComponentsWithTagEnabled( entity_id, "enabled_if_charmed", false )
end
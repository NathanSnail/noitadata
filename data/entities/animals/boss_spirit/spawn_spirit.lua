dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( GetUpdatedEntityID() )

EntityLoad( "data/entities/animals/boss_spirit/islandspirit.xml", x, y )
EntityKill( entity_id )
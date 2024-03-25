dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

EntityConvertToMaterial( entity_id, "glowstone_altar_hdr", false, true )
EntityKill( entity_id )
dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )

local angle = ProceduralRandom(x, y) * 3.1415926535 * 2
EntitySetTransform( entity_id, x, y, angle )
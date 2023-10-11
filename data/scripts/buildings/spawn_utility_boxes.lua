dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

EntityLoad( "data/entities/items/pickup/utility_box.xml", pos_x + Random( -360, 360 ), pos_y - 300 )

GameScreenshake( 30 )

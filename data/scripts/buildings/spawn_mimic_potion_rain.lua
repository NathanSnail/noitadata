dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
EntityLoad( "data/entities/animals/mimic_potion.xml", pos_x + Random( -70, 70 ), pos_y + Random( -400, 300 ) )
GameScreenshake( 30 )

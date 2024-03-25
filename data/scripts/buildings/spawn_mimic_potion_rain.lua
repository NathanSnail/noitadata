dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

local count = Random(6,12)

for i=1,count do
	EntityLoad( "data/entities/animals/mimic_potion.xml", pos_x + Random( -360, 360 ), pos_y + Random( -400, 300 ) )
end

GameScreenshake( 30 )

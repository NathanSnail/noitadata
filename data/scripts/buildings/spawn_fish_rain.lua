dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

local count = Random(4,8)
local types = { "fish_01", "fish_02" }

for i=1,count do
	local rnd = Random( 1, #types )
	local ragdoll_name = types[rnd]
	
	if ( ragdoll_name ~= nil ) then
		-- entity_id = EntityLoad( "data/entities/animals/" .. entity .. ".xml", pos_x + Random( -360, 360 ), pos_y - 300 )
		local scale_x = 1
		if( Random( 1, 100 ) <= 50 ) then scale_x = -1 end

		LoadRagdoll( "data/ragdolls/" .. ragdoll_name .. "/filenames.txt", pos_x + Random( -360, 360 ), pos_y - 300, "meat_helpless", scale_x, Random( -5, 5 ), Random( -5, 5 ) )
	end
end

GameScreenshake( 30 )

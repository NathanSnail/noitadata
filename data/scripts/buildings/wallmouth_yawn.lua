dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( pos_x + GameGetFrameNum(), pos_y - 32523 )

local rnd = Random( 0, 10 )

edit_component( entity_id, "VelocityComponent", function(comp,vars)
	ComponentSetValueVector2( comp, "mVelocity", 0, 0 )
end)

edit_component( entity_id, "CharacterDataComponent", function(comp,vars)
	ComponentSetValueVector2( comp, "mVelocity", 0, 0 )
end)

if ( rnd == 5 ) then
	local sprite = EntityGetFirstComponent( entity_id, "SpriteComponent" )
	if ( sprite ~= nil ) then
		GamePlayAnimation( entity_id, "yawn", 0, "stand", 0 )
	end
end
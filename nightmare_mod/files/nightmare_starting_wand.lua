dofile_once("data/scripts/lib/utilities.lua")

function item_pickup( entity_id )
	local wands = EntityGetWithTag( "nightmare_starting_wand" )
	
	if ( wands ~= nil ) then
		for i,v in ipairs( wands ) do
			local p = EntityGetRootEntity( v )
			local in_world = false
			local components = EntityGetComponent( v, "VelocityComponent" )
			
			if( components ~= nil ) then
				in_world = true
			end
			
			if ( p == v ) and ( v ~= entity_id ) and in_world then
				local x, y = EntityGetTransform( v )
				EntityLoad( "data/entities/particles/poof_pink.xml", x, y )
				EntityKill( v )
			end
		end
	end
end
dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

if( Random(0,100) < 75 ) then
	local spawn_distance = 200
	local e_id = EntityGetClosestWithTag( pos_x, pos_y, "player_unit")
	
	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
	
	if( e_id ~= 0 ) then
		local x, y = EntityGetTransform( e_id )
		local distance_sqrt = (x-pos_x)*(x-pos_x)+(y-pos_y)*(y-pos_y)
		if( distance_sqrt < spawn_distance * spawn_distance ) then
			local spawned_entities = GetValueInteger("spawned", 0)
			
			if (spawned_entities < 15) then
				-- spawn enemy
				pos_x = pos_x + Random(-4,4)
				pos_y = pos_y + Random(-4,4)
				
				local new_entity = EntityLoad( "data/entities/animals/fly.xml", pos_x - 3, pos_y - 4 )
				edit_component( new_entity, "LuaComponent", function(comp,vars)
					vars.script_death = ""
				end)
				
				spawned_entities = spawned_entities + 1
				
				SetValueInteger("spawned", spawned_entities)
			end
		end
	end
end


dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 220

local targets = EntityGetInRadiusWithTag( x, y, r, "homing_target" )
local targets2 = EntityGetInRadiusWithTag( x, y, r, "player_unit" )
local done = {}

for i,v in ipairs(targets2) do
	table.insert(targets, v)
end

for i,v in ipairs( targets ) do
	if ( v ~= entity_id ) then
		local c = EntityGetAllChildren( v )
		local root_id = EntityGetRootEntity( v )
		local valid = true
		
		if ( done[root_id] == nil ) then
			if ( c ~= nil ) then
				for a,b in ipairs( c ) do
					local comps = EntityGetComponent( b, "GameEffectComponent", "spirit_slime" )
					
					if ( comps ~= nil ) then
						valid = false
						break
					end
				end
			end
			
			if valid then
				local eid = EntityLoad( "data/entities/misc/effect_spirit_slime.xml", x, y )
				EntityAddChild( v, eid )
				
				done[v] = 1
			end
		end
	end
end
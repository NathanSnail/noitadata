dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )

local entities = EntityGetInRadiusWithTag( x, y, 40, "hittable" )

for i,v in ipairs( entities ) do
	local comp = EntityGetFirstComponent( v, "DamageModelComponent" )
	
	if ( comp ~= nil ) and ( EntityHasTag( v, "islandspirit" ) == false ) then
		local hp = ComponentGetValue2( comp, "hp" )
		if ( hp > 0.04 ) then
			hp = hp * 0.5
		end
		ComponentSetValue2( comp, "hp", hp )
	end
	
	local ex,ey = EntityGetTransform( v )
	EntityLoad( "data/entities/particles/blue_glow.xml", ex, ey )
end
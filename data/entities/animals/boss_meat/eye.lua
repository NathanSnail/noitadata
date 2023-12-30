dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )

local sprite = EntityGetFirstComponent( entity_id, "SpriteComponent" )
if ( sprite ~= nil ) then
	local statuscomp = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "status" )
	local status = ComponentGetValue2( statuscomp, "value_int" )
	
	if ( status == 1 ) then
		GamePlayAnimation( entity_id, "open", 0, "opened", 0 )
		
		local hitcomp = EntityGetFirstComponent( entity_id, "HitboxComponent" )
		ComponentSetValue2( hitcomp, "damage_multiplier", 1.0 )
		EntitySetComponentsWithTagEnabled( entity_id, "vacuum", true )
		EntitySetComponentsWithTagEnabled( entity_id, "vacuum_NOT", false )
	elseif ( status == 3 ) then
		GamePlayAnimation( entity_id, "close", 0, "stand", 0 )
		local hitcomp = EntityGetFirstComponent( entity_id, "HitboxComponent" )
		ComponentSetValue2( hitcomp, "damage_multiplier", 0 )
		EntitySetComponentsWithTagEnabled( entity_id, "vacuum", false )
		EntitySetComponentsWithTagEnabled( entity_id, "vacuum_NOT", true )
		
		shoot_projectile( entity_id, "data/entities/animals/boss_meat/orb_big.xml", x, y, 0, 0)
	end
	
	status = ( status + 1 ) % 4
	ComponentSetValue2( statuscomp, "value_int", status )
end
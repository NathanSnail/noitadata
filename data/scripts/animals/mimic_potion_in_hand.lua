-- make random noises in hand
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
SetRandomSeed( x, y )

if ( Random(1,4) == 1) then
	if ( Random(1,4) == 1) then
		GameEntityPlaySound( entity_id, "jump" )
	else
		GameEntityPlaySound( entity_id, "damage/projectile" )
	end
end
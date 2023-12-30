dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local enemies = EntityGetInRadiusWithTag( x, y, 200, "hittable" )

if ( #enemies > 0 ) then
	for _,enemy_id in ipairs(enemies) do
		local ex, ey = EntityGetTransform( enemy_id )
		
		local dist = math.abs( x - ex ) + math.abs( y - ey )
		
		if ( dist < 300 ) and ( EntityHasTag( enemy_id, "boss" ) == false ) and ( EntityHasTag( enemy_id, "this_is_sampo" ) == false ) and ( EntityHasTag( enemy_id, "polymorphable_NOT" ) == false ) then
			LoadGameEffectEntityTo( enemy_id, "data/entities/misc/effect_polymorph.xml" )
		end
	end
end

GameScreenshake( 100 )
EntityKill( entity_id )
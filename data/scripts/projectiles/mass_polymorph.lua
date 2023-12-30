dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local enemies = EntityGetInRadiusWithTag( x, y, 200, "homing_target" )
local targets2 = EntityGetInRadiusWithTag( x, y, 200, "player_unit" )

for i,v in ipairs(targets2) do
	table.insert(enemies, v)
end

if ( #enemies > 0 ) then
	for _,enemy_id in ipairs(enemies) do
		local ex, ey = EntityGetTransform( enemy_id )
		
		local dist = math.abs( x - ex ) + math.abs( y - ey )
		local root_id = EntityGetRootEntity( enemy_id )
		
		if ( root_id == enemy_id ) and ( dist < 300 ) and ( EntityHasTag( enemy_id, "boss" ) == false ) and ( EntityHasTag( enemy_id, "this_is_sampo" ) == false ) and ( EntityHasTag( enemy_id, "polymorphable_NOT" ) == false ) then
			LoadGameEffectEntityTo( enemy_id, "data/entities/misc/effect_polymorph.xml" )
		end
	end
end

GameScreenshake( 100 )
EntityKill( entity_id )

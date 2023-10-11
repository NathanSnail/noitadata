local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local endpoint_mountain = EntityGetWithTag( "ending_sampo_spot_mountain" )
if( #endpoint_mountain > 0 ) then
	x, y = EntityGetTransform( endpoint_mountain[1] )
end

EntityLoad("data/entities/items/wand_leukaluu.xml", x, y)
EntityLoad("data/entities/particles/image_emitters/magical_symbol.xml", x, y)
GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y)

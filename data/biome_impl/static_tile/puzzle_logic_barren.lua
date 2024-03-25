dofile_once("data/scripts/lib/utilities.lua")

function material_area_checker_success( pos_x, pos_y )
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform(entity_id)

	--EntityLoad( "data/biome_impl/static_tile/chest_darkness.xml", x, y )
	local sx = x+5
	EntityLoad( "data/entities/particles/image_emitters/magical_symbol.xml", sx, y )
	GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", sx, y )
	GamePlaySound( "data/audio/Desktop/event_cues.snd", "event_cues/barren_puzzle_completed/create", sx, y )
	CreateItemActionEntity( "CESSATION", sx, y )
	AddFlagPersistent( "card_unlocked_cessation" )

	local mat_from = CellFactory_GetType( "templeslab_static" )
	local mat_to = CellFactory_GetType( "grass_holy" )
	local xmin, xmax = 330, 300
	ConvertMaterialOnAreaInstantly( x-xmin, y, xmin+xmax, 52, mat_from, mat_to, true, false )
end

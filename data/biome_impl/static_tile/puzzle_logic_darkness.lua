dofile_once("data/scripts/lib/utilities.lua")

function material_area_checker_success( pos_x, pos_y )
  local entity_id = GetUpdatedEntityID()
  local x,y = EntityGetTransform(entity_id)
  
  EntityLoad( "data/entities/particles/image_emitters/magical_symbol.xml", x, y )
  GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", x, y )
  EntityLoad( "data/biome_impl/static_tile/chest_darkness.xml", x, y )
  EntityLoad( "data/entities/misc/music_energy_100.xml", x, y )
end

-- 2024/2/2 - made biome map loading work through this file to make it easier for mods to modify it
dofile_once("data/scripts/lib/utilities.lua")
BiomeMapSetSize( 70, 48 )
BiomeMapLoadImage( 0, 0, "data/biome_impl/biome_map.png" )

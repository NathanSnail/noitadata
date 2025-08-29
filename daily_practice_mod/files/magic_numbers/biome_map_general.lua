-- constants (color format is ARGB)
dofile_once("data/scripts/lib/utilities.lua")

-------------------------------------------------

local w = 70
local h = 48

BiomeMapSetSize( w, h )
BiomeMapLoadImage( 0, 0, "data/biome_impl/biome_map.png" )

function parse_until_height( height )
	local holym_min_x = 0
	local holym_max_x = w-1 
	local holym_min_y = 0
	local holym_max_y = height
	
	-- local test_color = 
	-- local test_color = -11678829  -- 0xFF93CB4D has to be converted to -> -11678829
	-- local test_color = BiomeMapConvertPixelFromUintToInt( 0xFF93CB4D )
	-- print( test_color )
	local biome_temple_left = BiomeMapConvertPixelFromUintToInt( 0xFF93CB4D )
	local biome_temple_right = BiomeMapConvertPixelFromUintToInt( 0xFF93CB4E )
	local biome_temple_right_snowcave = BiomeMapConvertPixelFromUintToInt( 0xFF93CB4F )
	local biome_temple_right_snowcastle = BiomeMapConvertPixelFromUintToInt( 0xFF93CB5A )

	for y=holym_min_y,holym_max_y+1 do
		for x=holym_min_x,holym_max_x do
			local c = BiomeMapGetPixel( x, y )
			if( c == biome_temple_left ) then
				-- print( "found one at: " .. x .. "," .. y ) 
				BiomeMapSetPixel( x+0, y, 0xFF99CB4D )
				BiomeMapSetPixel( x+1, y, 0xFF99CB4C )
				-- BiomeMapSetPixel( x+2, y, 0xFF99CB4E )
			end

			-- there's separate temple_altar_right biomes for snowcave and snowcastle
			if( c == biome_temple_right ) then BiomeMapSetPixel( x, y, 0xFF99CB4E ) end
			if( c == biome_temple_right_snowcave ) then BiomeMapSetPixel( x, y, 0xFF99CB4F ) end
			if( c == biome_temple_right_snowcastle ) then BiomeMapSetPixel( x, y, 0xFF99CB5A ) end
		end
	end

end

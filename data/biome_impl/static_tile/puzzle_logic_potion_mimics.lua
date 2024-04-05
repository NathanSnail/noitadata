dofile_once("data/scripts/lib/utilities.lua")
function RegisterSpawnFunction( x, y ) end -- redefine the function so we can load temples_common here
dofile_once("data/biome_impl/static_tile/temples_common.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local indicator_positions = { 
	{ x = 7, y = 39 },
	{ x = 16, y = 39 },
	{ x = 25, y = 39 },
	{ x = 34, y = 39 },
	{ x = 12, y = 28 },
	{ x = 21, y = 28 },
	{ x = 30, y = 28 },
	{ x = 16, y = 17 },
	{ x = 25, y = 17 },
	{ x = 21, y = 6 },
}

-- display puzzle progress on bg, load reward
px = x - 19
py = y - 21

local awoken_needed = 10

local awoken = tonumber( GlobalsGetValue( "potion_mimics_awoken", "0" ) )
local indicator_count = tonumber( GlobalsGetValue( "potion_mimics_indicators", "0" ) )
local reward_spawned = GlobalsGetValue( "potion_mimics_reward_spawned", "0" )

while indicator_count < awoken and indicator_count < awoken_needed do
	local p = indicator_positions[ 1 + indicator_count ]

	indicator_count = indicator_count + 1 
	GlobalsSetValue( "potion_mimics_indicators", tostring(indicator_count) )

	EntityLoad( "data/biome_impl/static_tile/potion_mimic_indicator.xml", p.x + px, p.y + py )
	if awoken > 5 then
		EntityAddTag( entity_id, "music_energy_100_near" )
	end
end


local players = get_players()
if #players > 0 and awoken >= awoken_needed and reward_spawned ~= "1" then
	local playerx,playery = EntityGetTransform(players[1])

	if vec_length( vec_sub( playerx, playery, x, y ) ) < 200 then
		local sx = x + 1
		local sy = y - 30

		EntityLoad( "data/entities/particles/image_emitters/magical_symbol.xml", sx, sy)
		GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", sx, sy )
		CreateItemActionEntity( "SEA_MIMIC", sx, sy )
		AddFlagPersistent( "card_unlocked_sea_mimic" )
		GlobalsSetValue( "potion_mimics_reward_spawned", "1" )
	end
end
-- all functions below are optional and can be left out

--[[

function OnModPreInit()
	print("Mod - OnModPreInit()") -- First this is called for all mods
end

function OnModInit()
	print("Mod - OnModInit()") -- After that this is called for all mods
end

function OnModPostInit()
	print("Mod - OnModPostInit()") -- Then this is called for all mods
end



function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
	GamePrint( "OnWorldInitialized() " .. tostring(GameGetFrameNum()) )
end

function OnWorldPreUpdate() -- This is called every time the game is about to start updating the world
	GamePrint( "Pre-update hook " .. tostring(GameGetFrameNum()) )
end

function OnWorldPostUpdate() -- This is called every time the game has finished updating the world
	GamePrint( "Post-update hook " .. tostring(GameGetFrameNum()) )
end

]]--

function set_biome_to_nightmare( biome_name, hp_scale, attack_speed )
	local biome_filename = "data/biome/" .. biome_name .. ".xml"
	BiomeSetValue( biome_filename, "game_enemy_hp_scale", hp_scale )
	BiomeSetValue( biome_filename, "game_enemy_attack_speed", attack_speed )

end

-- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
function OnWorldInitialized() 
	-- GamePrint( "OnWorldInitialized() " .. tostring(GameGetFrameNum()) )
	-- const char* lua_func_name = "LoadPixelScene( string materials_filename, string colors_filename, x, y, string background_file, skip_biome_checks = false, skip_edge_textures = false, color_to_material_table = {} )";
	
	-- biome data is not saved, so we do these every time

	set_biome_to_nightmare( "clouds", 15, 0.5 )
	set_biome_to_nightmare( "coalmine", 3, 0.5 )
	set_biome_to_nightmare( "coalmine_alt", 3, 0.5 )
	set_biome_to_nightmare( "crypt", 15, 0.3 )
	set_biome_to_nightmare( "desert", 15, 0.5 )
	set_biome_to_nightmare( "excavationsite", 2, 0.5 )
	set_biome_to_nightmare( "forest", 15, 0.5 )
	set_biome_to_nightmare( "fungicave", 7, 0.5 )
	set_biome_to_nightmare( "pyramid", 7, 0.4 )
	set_biome_to_nightmare( "rainforest", 9, 0.5 )
	set_biome_to_nightmare( "rainforest_open", 9, 0.5 )
	set_biome_to_nightmare( "sandcave", 10, 0.4 )
	set_biome_to_nightmare( "snowcastle", 3.5, 0.5 )
	set_biome_to_nightmare( "snowcave", 2, 0.5 )
	set_biome_to_nightmare( "snowcave_tunnel", 7.5, 0.5 )
	set_biome_to_nightmare( "the_end", 50, 0.1 )
	set_biome_to_nightmare( "the_sky", 50, 0.1 )
	set_biome_to_nightmare( "vault", 12.5, 0.5 )
	set_biome_to_nightmare( "vault_frozen", 16, 0.25 )
	set_biome_to_nightmare( "wandcave", 16, 0.5 )
	

	local key = "NIGHTMARE_MOD_TRYING_TO_LOAD_PIXELS_SCENES_ONLY_ONCE"
	local is_initialized = GlobalsGetValue( key )
	if( is_initialized == "yes" ) then
		return
	end
	GlobalsSetValue( key, "yes" )

	LoadPixelScene( "data/biome_impl/clean_entrance.png", "", 128, 1535, "", true, true )
	LoadPixelScene( "data/biome_impl/clean_entrance.png", "", 128, 4095, "", true, true )
	LoadPixelScene( "data/biome_impl/clean_entrance.png", "", 128, 6655, "", true, true )
	LoadPixelScene( "data/biome_impl/clean_entrance.png", "", 128, 10751, "", true, true )

	GameAddFlagRun( "run_nightmare" )
end

function OnPlayerSpawned( player_entity ) 

	local key = "NIGHTMARE_MOD_TRYING_TO_MODIFY_PLAYER_DATA_ONLY_ONCE"
	local is_initialized = GlobalsGetValue( key ) 
	if( is_initialized == "yes" ) then
		return
	end
	GlobalsSetValue( key, "yes" )

	local damagemodels = EntityGetComponent( player_entity, "DamageModelComponent" )
	if( damagemodels ~= nil ) then
		for i,damagemodel in ipairs(damagemodels) do
			
			local melee = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "melee" ) )
			local projectile = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "projectile" ) )
			local explosion = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "explosion" ) )
			local electricity = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "electricity" ) )
			local fire = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "fire" ) )
			local drill = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "drill" ) )
			local slice = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "slice" ) )
			local ice = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "ice" ) )
			local healing = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "healing" ) )
			local physics_hit = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "physics_hit" ) )
			local radioactive = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "radioactive" ) )
			local poison = tonumber(ComponentObjectGetValue( damagemodel, "damage_multipliers", "poison" ) )

			melee = melee * 3
			projectile = projectile * 2
			explosion = explosion * 2
			electricity = electricity * 2
			fire = fire * 2
			drill = drill * 2
			slice = slice * 2
			ice = ice * 2
			radioactive = radioactive * 2
			poison = poison * 3

			ComponentObjectSetValue( damagemodel, "damage_multipliers", "melee", tostring(melee) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "projectile", tostring(projectile) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "explosion", tostring(explosion) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "electricity", tostring(electricity) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "fire", tostring(fire) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "drill", tostring(drill) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "slice", tostring(slice) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "ice", tostring(ice) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "healing", tostring(healing) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "physics_hit", tostring(physics_hit) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "radioactive", tostring(radioactive) )
			ComponentObjectSetValue( damagemodel, "damage_multipliers", "poison", tostring(poison) )

		end
	end

	-- GamePrint( "OnPlayerSpawned() - done" )
end

-- This code runs when all mods' filesystems are registered

-- Will override some magic numbers using the specified file
ModMagicNumbersFileAdd( "mods/nightmare/files/magic_numbers.xml" ) 

ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nightmare/files/perk_list_appends.lua")
ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/nightmare/files/potion_appends.lua")
ModLuaFileAppend( "data/scripts/director_helpers.lua", "mods/nightmare/files/director_helpers_appends.lua")

dofile_once( "data/scripts/lib/utilities.lua" )
dofile_once( "data/scripts/perks/perk_list.lua" )
dofile_once( "data/scripts/perks/perk.lua" )
dofile_once( "data/scripts/lib/utilities.lua" )
dofile_once( "data/scripts/director_helpers.lua" )

local function shuffleTable( t )
	assert( t, "shuffleTable() expected a table, got nil" )
	local iterations = #t
	local j
	
	for i = iterations, 2, -1 do
		j = Random(1,i)
		t[i], t[j] = t[j], t[i]
	end
end

run_depth = 1

run_setups = 
{
	{
		perks = { "GLOBAL_GORE","VAMPIRISM" },
		cards = { "CHAINSAW" },

		variation = {
			perks = { "VAMPIRISM","ATTACK_FOOT" },
			cards = { "CHAINSAW" },
		}
	},
	{
		perks = { "REPELLING_CAPE","STAINLESS_ARMOUR" },
	},
	{
		perks = { "STAINLESS_ARMOUR","FREEZE_FIELD" },
	},
	{
		perks = { "WAND_EXPERIMENTER","GLASS_CANNON" },
	},
	{
		perks = { "INVISIBILITY","REPELLING_CAPE" },
	},
	{
		perks = { "FREEZE_FIELD","INVISIBILITY" },
	},
	{
		perks = { "ELECTRICITY","BREATH_UNDERWATER","UNLIMITED_SPELLS" },
		cards = { "SEA_WATER" },

		variation = {
			perks = { "BREATH_UNDERWATER","SPEED_DIVER","UNLIMITED_SPELLS" },
			cards = { "SEA_WATER" }
		}
	},
	{
		perks = { "WORM_ATTRACTOR","PROTECTION_MELEE" },
	},
	{
		perks = { "LEVITATION_TRAIL","PROJECTILE_HOMING", "GLASS_CANNON" },
	},
	{
		perks = { "NO_WAND_EDITING","GLASS_CANNON","MOVEMENT_FASTER" },
	},
	{
		perks = { "GLASS_CANNON","LOW_HP_DAMAGE_BOOST" },
	},
	{
		perks = { "BLEED_OIL" },
		cards = { "HITFX_CRITICAL_OIL,ARROW" }
	},
	{
		perks = { "TRICK_BLOOD_MONEY","EXTRA_MONEY_TRICK_KILL","EXTRA_MONEY" },
	},
	{
		perks = { "NO_WAND_EDITING","GLASS_CANNON" },
	},
	{
		perks = { "STRONG_KICK","GLASS_CANNON","INVISIBILITY" },
		num_of_wands = 0,
	},
	{
		perks = { "PROTECTION_FIRE" },
		cards = { "FIRE_TRAIL,HITFX_BURNING_CRITICAL_HIT,DAMAGE,LIGHT_BULLET" },
	},
	{
		perks = { "PROTECTION_EXPLOSION" },
		cards = { "LIGHT_BULLET_TRIGGER,EXPLOSION" }
	},
	{
		perks = { "PROTECTION_EXPLOSION", "PROTECTION_FIRE", "UNLIMITED_SPELLS" },
		cards = { "NUKE" }
	},
	{
		perks = { "PROJECTILE_HOMING" },
		cards = { "DISC_BULLET" },
		
		variation = { 
			perks = { "PROJECTILE_HOMING" },
			cards = { "DISC_BULLET_BIG" }, 
		}
	},
}

local table_of_random_items = 
{
	total_prob = 0,
	{
		prob = 10,
		item = "data/entities/items/pickup/potion.xml"
	},
	{
		prob = 0.6,
		item = "data/entities/items/pickup/moon.xml"
	},
	{
		prob = 0.4,
		item = "data/entities/items/pickup/brimstone.xml"
	},
	{
		prob = 0.4,
		item = "data/entities/items/pickup/thunderstone.xml"
	},
	{
		prob = 0.4,
		item = "data/entities/items/pickup/broken_wand.xml",
	},
	{
		prob = 0.1,
		item = "data/entities/items/pickup/egg_fire.xml",
	},
	{
		prob = 0.1,
		item = "data/entities/items/pickup/egg_hollow.xml",
	},
	{
		prob = 0.1,
		item = "data/entities/items/pickup/egg_monster.xml",
	},
	{
		prob = 0.1,
		item = "data/entities/items/pickup/egg_purple.xml",
	},
	{
		prob = 0.1,
		item = "data/entities/items/pickup/egg_red.xml",
	},
	{
		prob = 0.1,
		item = "data/entities/items/pickup/egg_slime.xml",
	},
	{
		prob = 0.1,
		item = "data/entities/items/pickup/egg_spiders.xml",
	},
	{
		prob = 0.1,
		item = "data/entities/items/pickup/egg_worm.xml",
	}
}

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


-- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
function OnWorldInitialized() 
	-- GamePrint( "OnWorldInitialized() " .. tostring(GameGetFrameNum()) )
	-- const char* lua_func_name = "LoadPixelScene( string materials_filename, string colors_filename, x, y, string background_file, skip_biome_checks = false, skip_edge_textures = false, color_to_material_table = {} )";

	

	--[[local key = "DAILY_RUN_MOD_TRYING_TO_LOAD_PIXELS_SCENES_ONLY_ONCE"
	local is_initialized = GlobalsGetValue( key )
	if( is_initialized == "yes" ) then
		return
	end
	GlobalsSetValue( key, "yes" )

	LoadPixelScene( "data/biome_impl/clean_entrance.png", "", 128, 1535, "", true, true )
	LoadPixelScene( "data/biome_impl/clean_entrance.png", "", 128, 4095, "", true, true )
	LoadPixelScene( "data/biome_impl/clean_entrance.png", "", 128, 6655, "", true, true )
	LoadPixelScene( "data/biome_impl/clean_entrance.png", "", 128, 10751, "", true, true )
	]]--

	-- MagicNumbers
	-- Set Player Position
end

function OnMagicNumbersAndWorldSeedInitialized()
	print("OnMagicNumbersAndWorldSeedInitialized")
end

function OnPlayerSpawned( player_entity ) 

	local key = "DAILY_RUN_TRYING_TO_MODIFY_PLAYER_DATA_ONLY_ONCE"
	local is_initialized = GlobalsGetValue( key ) 
	if( is_initialized == "yes" ) then
		print("DAILY_RUN_TRYING_TO_MODIFY_PLAYER_DATA_ONLY_ONCE! exit!")
		return
	end
	GlobalsSetValue( key, "yes" )

	local pos_x, pos_y = EntityGetTransform( player_entity )
	local extra_random_seed = GetDailyPracticeRunSeed() / 100
	SetRandomSeed( pos_x + extra_random_seed, pos_y - extra_random_seed )

	local rs = run_setups[ Random( 1, #run_setups ) ]
	if( rs.variation ~= nil ) then
		if( Random( 1, 100 ) <= 50 ) then
			rs = rs.variation
		end
	end

	-- [x] give player x perks
	--   [ ] make sure player gets enough and not too many perks
	-- [x] adjust HP
	-- [x] gold
	--	[ ] make better rng for them
	-- [ ] wands
	-- [ ] items
	-- [ ] ORBS?
	-- [ ] used versions of previous biomes
	-- [ ] used versions of holy mountain

	-- todo - depts how many perks...?


	-- gold
	local gold = Random( 50 * run_depth, 300 * run_depth )
	edit_component( player_entity, "WalletComponent", function(comp,vars)
		vars.money = gold
	end)

	-- hp
	local hp = 100 + 10 * run_depth + 25 * Random( 0, 4 * run_depth )

	hp = hp / 25
	local damagemodels = EntityGetComponent( player_entity, "DamageModelComponent" )
	if( damagemodels ~= nil ) then
		for i,damagemodel in ipairs(damagemodels) do
			ComponentSetValue2( damagemodel, "hp", hp )
			ComponentSetValue2( damagemodel, "max_hp", hp )
		end
	end

	-- items
	local inventory = nil

	-- find the quick inventory, player cape and arm
	local player_child_entities = EntityGetAllChildren( player_entity )
	if ( player_child_entities ~= nil ) then
		for i,child_entity in ipairs( player_child_entities ) do
			local child_entity_name = EntityGetName( child_entity )
			
			if ( child_entity_name == "inventory_quick" ) then
				inventory = child_entity
			end
		end
	end

	-- set inventory contents
	if ( inventory ~= nil ) then
		local inventory_items = EntityGetAllChildren( inventory )
		
		-- remove default items
		if inventory_items ~= nil then
			for i,item_entity in ipairs( inventory_items ) do
				GameKillInventoryItem( player_entity, item_entity )
			end
		end

		local num_of_wands = 4
		if( rs.num_of_wands ~= nil ) then
			num_of_wands = rs.num_of_wands
		end

		local wand_depth = run_depth
		

		if( num_of_wands > 0 ) then
			for i=1,num_of_wands do
				item = "data/entities/items/wand_daily_0" .. wand_depth .. ".xml"

				if( rs.cards ~= nil and rs.cards[i] ~= nil ) then
					GlobalsSetValue( "DAILY_WAND_CARDS_NEEDED", rs.cards[i] )
				end
				
				local item_entity = EntityLoad( item, i * 997, i * 853 )
				GamePickUpInventoryItem( player_entity, item_entity, false )
				-- EntityAddChild( inventory, item_entity )
				if( Random(0,100) < 45 and wand_depth > 1 ) then
					wand_depth = wand_depth - 1
				end
			end
		end

		-- items
		local num_of_items = 3
		if( num_of_items > 0 ) then

			for i=1,num_of_items do
				local item = "data/entities/items/pickup/potion.xml"	
				local item_data = random_from_table( table_of_random_items, i * 157, i * 229 )
				item = item_data.item

				local item_entity = EntityLoad( item, i * 331, i * 251 )
				
				-- has_been_picked_by_player
				local item_comp = EntityGetFirstComponentIncludingDisabled( item_entity, "ItemComponent" )
				ComponentSetValue( item_comp, "has_been_picked_by_player", "1" )

				GamePickUpInventoryItem( player_entity, item_entity, false )
			end
			
		end

		--[[
		-- add loadout items
		local loadout_items = loadout_choice.items
		for item_id,loadout_item in ipairs( loadout_items ) do
			if ( tostring( type( loadout_item ) ) ~= "table" ) then
				local item_entity = EntityLoad( loadout_item )
				EntityAddChild( inventory, item_entity )
			else
				local amount = loadout_item.amount or 1
				
				for i=1,amount do
					local item_option = ""
					
					if ( loadout_item.options ~= nil ) then
						local item_options = loadout_item.options
						local item_options_rnd = Random( 1, #item_options )
						
						item_option = item_options[item_options_rnd]
					else
						item_option = loadout_item[1]
					end
					
					local item_entity = EntityLoad( item_option )
					if item_entity then
						EntityAddChild( inventory, item_entity )
					end
				end
			end
		end]]--
	end

	-- perks
	-- run_depth
	if( rs.perks ~= nil ) then

		local all_perks = {}

		-- rs.perks = { "TRICK_BLOOD_MONEY","SAVING_GRACE","LOW_HP_DAMAGE_BOOST" }

		for i,perk_data in ipairs(perk_list) do
			if ( perk_data.not_in_default_perk_pool == nil or perk_data.not_in_default_perk_pool == false ) then
				table.insert( all_perks, perk_data.id )
			end
		end

		local number_of_perks = run_depth

		-- if more perks than run_depth, try to fix by giving player PERKS_LOTTERY		
		if( #rs.perks > number_of_perks ) then
			give_perk_to_player( "PERKS_LOTTERY", player_entity )
			remove_perk( "PERKS_LOTTERY", all_perks )

			local max_number_of_perks = 2 + (run_depth - 1)*3

			if( #rs.perks > max_number_of_perks ) then
				
				if(  #rs.perks <= 1 + (run_depth - 1)*4 ) then
					give_perk_to_player( "EXTRA_PERK", player_entity )
					remove_perk( "EXTRA_PERK", all_perks )
					max_number_of_perks = 1 + (run_depth - 1)*4
					if( #rs.perks > max_number_of_perks ) then
						number_of_perks = Random( run_depth - 2, max_number_of_perks )
					else
						number_of_perks = #rs.perks
					end
				else
					number_of_perks = max_number_of_perks
				end
			else
				number_of_perks = #rs.perks
			end
		end



		shuffleTable( rs.perks )
		
		-- give the perks
		for i=1,number_of_perks do
			local perk_id = nil 
			if( i <= #rs.perks ) then 
				perk_id = rs.perks[i] 
			else
				-- get random perk
				perk_id = all_perks[ Random(1, #all_perks) ]
			end

			give_perk_to_player( perk_id, player_entity )
			remove_perk( perk_id, all_perks )
		end

	else
		print( "rs.perks == nil" )
	end

end

-----------------------------------------------------

function remove_perk( perk_name, extra_perk_list )
	local key_to_perk = nil
	for key,perk in pairs(perk_list) do
		if( perk.id == perk_name) then
			key_to_perk = key
		end
	end

	if( key_to_perk ~= nil ) then
		table.remove(perk_list, key_to_perk)
	end

	key_to_perk = nil
	for key,perk in pairs(extra_perk_list) do
		if( perk == perk_name) then
			key_to_perk = key
		end
	end

	if( key_to_perk ~= nil ) then
		table.remove(extra_perk_list, key_to_perk)
	end
end

function give_perk_to_player( perk_id, entity_who_picked )

	print( "giving perk: " .. perk_id )
	-- picks a perk. entity_item should be created by spawn_perk
	-- function perk_pickup( entity_item, entity_who_picked, item_name, do_cosmetic_fx, kill_other_perks )
	-- fetch perk info ---------------------------------------------------

	local perk_name = "PERK_NAME_NOT_DEFINED"
	local perk_desc = "PERK_DESCRIPTION_NOT_DEFINED"

	-- find these from somewhere
	--[[	
	edit_component( entity_item, "ItemComponent", function(comp,vars)
		perk_name = ComponentGetValue( comp, "item_name")
		perk_desc = ComponentGetValue( comp, "ui_description")
	end)
	]]

	local perk_data = get_perk_with_id( perk_list, perk_id )
	if perk_data == nil then
		return
	end

	-- load perk for entity_who_picked -----------------------------------
	-- Do we give progress flags?
	local flag_name = get_perk_picked_flag_name( perk_id )
	local flag_name_persistent = string.lower( flag_name )
	if ( HasFlagPersistent( flag_name_persistent ) == false ) then
		GameAddFlagRun( "new_" .. flag_name_persistent )
	end
	GameAddFlagRun( flag_name )
	AddFlagPersistent( flag_name_persistent )

	-- add game effect
	if perk_data.game_effect ~= nil then
		local game_effect_comp = GetGameEffectLoadTo( entity_who_picked, perk_data.game_effect, true )
		if game_effect_comp ~= nil then
			ComponentSetValue( game_effect_comp, "frames", "-1" )
		end
	end

	if perk_data.func ~= nil then
		item_name = ""
		perk_data.func( 0, entity_who_picked, item_name )
	end

	-- add ui icon etc
	local entity_ui = EntityCreateNew( "" )
	EntityAddComponent( entity_ui, "UIIconComponent", 
	{ 
		name = perk_data.ui_name,
		description = perk_data.ui_description,
		icon_sprite_file = perk_data.ui_icon
	})
	EntityAddChild( entity_who_picked, entity_ui )


	-- done
end

-- This code runs when all mods' filesystems are registered

-- Will override some magic numbers using the specified file


print( "GetDailyPracticeRunSeed(): " .. GetDailyPracticeRunSeed() )

SetWorldSeed( GetDailyPracticeRunSeed() )
SetRandomSeed( GetDailyPracticeRunSeed(), GetDailyPracticeRunSeed() / 31 )
run_depth = 1
temp_r = Randomf()
if( temp_r <= 0.32 ) then run_depth = 1
elseif( temp_r <= 0.70 ) then run_depth = 2 
elseif( temp_r <= 0.93 ) then run_depth = 3 
elseif( temp_r <= 0.983562 ) then run_depth = 4 
elseif( temp_r <= 0.99726063 ) then run_depth = 5 
else run_depth = 6 end

local allow_wand_editing = false
temp_r = Randomf()
-- if( temp_r <= 0.5 ) then allow_wand_editing = true end
if( run_depth > 1 and temp_r <= 0.59 ) then allow_wand_editing = true end

local magic_numbers_file =  "mods/daily_practice/files/magic_numbers/magic_numbers_0" .. run_depth
if( allow_wand_editing ) then
	magic_numbers_file = magic_numbers_file .. "l"
	run_depth = run_depth - 1
end
magic_numbers_file = magic_numbers_file .. ".xml"

ModMagicNumbersFileAdd( magic_numbers_file ) 


-- ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/nightmare/files/perk_list_appends.lua")
-- ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/nightmare/files/potion_appends.lua")

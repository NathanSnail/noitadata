dofile( "data/scripts/game_helpers.lua" )
dofile_once("data/scripts/lib/utilities.lua")
dofile_once( "data/scripts/perks/perk_list.lua" )

function give_perk_to_enemy( perk_data, entity_who_picked, entity_item, num_perks, perk_idx, pickup_num )
	-- fetch perk info ---------------------------------------------------

	local pos_x, pos_y = EntityGetTransform( entity_who_picked )

	local perk_id = perk_data.id
	local do_not_remove = perk_data.do_not_remove or false
	
	-- add game effect
	if perk_data.game_effect ~= nil then
		local game_effect_comp, game_effect_entity = GetGameEffectLoadTo( entity_who_picked, perk_data.game_effect, true )
		if game_effect_comp ~= nil then
			ComponentSetValue( game_effect_comp, "frames", "-1" )
		end
		
		if ( do_not_remove == false ) then
			ComponentAddTag( game_effect_comp, "perk_component" )
			EntityAddTag( game_effect_entity, "perk_entity" )
		end
	end
	
	if perk_data.game_effect2 ~= nil then
		local game_effect_comp, game_effect_entity = GetGameEffectLoadTo( entity_who_picked, perk_data.game_effect2, true )
		if game_effect_comp ~= nil then
			ComponentSetValue( game_effect_comp, "frames", "-1" )
		end
			
		if ( do_not_remove == false ) then
			ComponentAddTag( game_effect_comp, "perk_component" )
			EntityAddTag( game_effect_entity, "perk_entity" )
		end
	end
	
	if perk_data.particle_effect ~= nil then
		local particle_id = EntityLoad( "data/entities/particles/perks/" .. perk_data.particle_effect .. ".xml" )
		
		if ( do_not_remove == false ) then
			EntityAddTag( particle_id, "perk_entity" )
		end
		
		EntityAddChild( entity_who_picked, particle_id )
	end
	
	
	if perk_data.func_enemy ~= nil then
		perk_data.func_enemy( entity_item, entity_who_picked, nil, 1 )
	elseif perk_data.func ~= nil then
		perk_data.func( entity_item, entity_who_picked, nil, 1 )
	end

	-- add ui icon etc
	local entity_icon = EntityLoad( "data/entities/misc/perks/enemy_icon.xml", pos_x, pos_y )
	edit_component( entity_icon, "SpriteComponent", function(comp,vars)
		ComponentSetValue( comp, "image_file", perk_data.ui_icon )
	end)
	EntityAddChild( entity_who_picked, entity_icon )
end

function enemy_perks( target )
	if ( target ~= nil ) and ( target ~= NULL_ENTITY ) then
		local x, y = EntityGetTransform( target )
		SetRandomSeed( x, y )

		local worm = EntityGetComponent( target, "WormAIComponent" )
		local dragon = EntityGetComponent( target, "BossDragonComponent" )
		local ghost = EntityGetComponent( target, "GhostComponent" )
		local lukki = EntityGetComponent( target, "LimbBossComponent" )
		
		if ( worm == nil ) and ( dragon == nil ) and ( ghost == nil ) and ( lukki == nil ) then
			local valid_perks = {}
			
			local comps = EntityGetComponent( target, "CameraBoundComponent" )
			if( comps ~= nil ) then
				for i,camerabound in ipairs(comps) do
					EntitySetComponentIsEnabled( target, camerabound, false )	
				end
			end
			
			for i,perk_data in ipairs( perk_list ) do
				if ( perk_data.usable_by_enemies ~= nil ) and perk_data.usable_by_enemies then
					table.insert( valid_perks, i )
				end
			end
			
			if ( #valid_perks > 0 ) then
				local rnd = Random( 1, #valid_perks )
				local result = valid_perks[rnd]
				
				local perk_data = perk_list[result]
				
				give_perk_to_enemy( perk_data, target, 0 )
			end
		end
	end
end

function enemy_give_wand( target )
	if ( target ~= nil ) and ( target ~= NULL_ENTITY ) then
		local x, y = EntityGetTransform( target )
		SetRandomSeed( x, y )

		local worm = EntityGetComponent( target, "WormAIComponent" )
		local dragon = EntityGetComponent( target, "BossDragonComponent" )
		local ghost = EntityGetComponent( target, "GhostComponent" )
		local lukki = EntityGetComponent( target, "LimbBossComponent" )
		
		if ( worm == nil ) and ( dragon == nil ) and ( ghost == nil ) and ( lukki == nil ) then
			local valid_perks = {}
			
			local comps = EntityGetComponent( target, "CameraBoundComponent" )
			if( comps ~= nil ) then
				for i,camerabound in ipairs(comps) do
					EntitySetComponentIsEnabled( target, camerabound, false )	
				end
			end
			
			-- figure out what level wand to give?
			local wand_level = math.floor( y / ( 512 * 4 ) )
			if( wand_level < 2 ) then wand_level = 2 end
			if( wand_level > 6 and wand_level < 8 ) then wand_level = 6 end
			if( wand_level > 6 ) then wand_level = 10 end

			local wand_level_str = "0" .. tostring( wand_level )
			if( wand_level >= 10 ) then wand_level_str = "10" end
			local wand_file = "data/entities/items/"
			if( Random( 1, 100 ) < 50 ) then 
				wand_file = wand_file .. "wand_level_" .. wand_level_str .. ".xml"
			else
				wand_file = wand_file .. "wand_unshuffle_" .. wand_level_str .. ".xml"
			end
			EntityLoad( wand_file, x, y)
		end
	end
end

function is_valid_enemy( file )
	local test = "data/entities/animals/"
	
	if ( string.sub( file, 1, #test ) == test ) then
		return true
	end
	
	return false
end

function entity_load_camera_bound(entity_data, x, y, rand_x, rand_y)
	-- if true then return nil end  -- enable 2 disable spawns
	if rand_x == nil then rand_x = 4 end
	if rand_y == nil then rand_y = 4 end
	
	SetRandomSeed( x, y )
	local giveperk = false
	local givewand = false
	local giveperk_rnd = Random( 1, 15 )
	if ( giveperk_rnd == 1 ) then
		giveperk = true
	end
	-- give wand
	giveperk_rnd = Random( 1, 20 )
	if ( giveperk_rnd <= 1 ) then
		givewand = true
	end

	-- load groups
	if( entity_data.entities ~= nil ) then
		for j,ev in ipairs(entity_data.entities) do
			if( type( ev ) == 'table' ) then
				local count = 1
				if( ev.min_count ~= nil ) then
					count = ev.min_count
					if( ev.max_count ~= nil ) then
						count = ProceduralRandom( x+j, y, ev.min_count, ev.max_count )
					end
				end

				for i = 1,count do
					local pos_x = x + ProceduralRandom(x+j, y+i, -rand_x, rand_x)
					local pos_y = y + ProceduralRandom(x+j, y+i, -rand_y, rand_y)
					if( ev.offset_y ~= nil ) then pos_y = pos_y + ev.offset_y end
					if( ev.offset_x ~= nil ) then pos_x = pos_x + ev.offset_x end
					
					if giveperk and is_valid_enemy( ev.entity ) then
						local eid = EntityLoad( ev.entity, pos_x, pos_y )
						enemy_perks( eid )
						
						local comps = EntityGetComponent( eid, "CameraBoundComponent" )
						if ( comps ~= nil ) then
							for a,b in ipairs( comps ) do
								EntityRemoveComponent( eid, b )
							end
						end
					else
						EntityLoadCameraBound( ev.entity, pos_x, pos_y )
					end
				end
			else
				if( ev ~= nil ) then
					local pos_x = x + ProceduralRandom(x+j, y, -rand_x, rand_x)
					local pos_y = y + ProceduralRandom(x+j, y, -rand_y, rand_y)
					if( ev.offset_y ~= nil ) then pos_y = pos_y + ev.offset_y end
					if( ev.offset_x ~= nil ) then pos_x = pos_x + ev.offset_x end
					
					if giveperk and is_valid_enemy( ev ) then
						local eid = EntityLoad( ev, pos_x, pos_y )
						enemy_perks( eid )
						
						local comps = EntityGetComponent( eid, "CameraBoundComponent" )
						if ( comps ~= nil ) then
							for a,b in ipairs( comps ) do
								EntityRemoveComponent( eid, b )
							end
						end
					else
						EntityLoadCameraBound( ev, pos_x, pos_y )
					end
				end
			end
		end
	end

	if( entity_data.entity == nil or  entity_data.entity == '' ) then
		return 0
	end

	local how_many = ProceduralRandom(x,y,entity_data.min_count,entity_data.max_count)
	if( how_many <= 0 ) then
		return 0
	end
	
	local pos_x = x
	local pos_y = y

	-- only giving wands here
	for i = 1,how_many do
		pos_x = x + ProceduralRandom(x+i,y,-rand_x, rand_x)
		pos_y = y + ProceduralRandom(x+i,y,-rand_y, rand_y)
		if( entity_data.offset_y ~= nil ) then pos_y = pos_y + entity_data.offset_y end
		if( entity_data.offset_x ~= nil ) then pos_x = pos_x + entity_data.offset_x end

		if ( givewand or giveperk ) and is_valid_enemy( entity_data.entity ) then
			local eid = EntityLoad( entity_data.entity, pos_x, pos_y )
			
			if( giveperk ) then
				enemy_perks( eid )
			end

			if( givewand ) then
				enemy_give_wand( eid )
			end
			
			local comps = EntityGetComponent( eid, "CameraBoundComponent" )
			if ( comps ~= nil ) then
				for a,b in ipairs( comps ) do
					EntityRemoveComponent( eid, b )
				end
			end
		else
			EntityLoadCameraBound( entity_data.entity, pos_x, pos_y )
		end
	end

	return 1
end
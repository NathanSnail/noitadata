dofile_once("data/scripts/lib/utilities.lua")
dofile( "data/scripts/perks/perk.lua" )


function permapolymorph_entity( entity_id )
	local comp_poly = GameGetGameEffect( entity_id, "POLYMORPH" )
	if( comp_poly == 0 or comp_poly == nil ) then comp_poly = GameGetGameEffect( entity_id, "POLYMORPH_RANDOM" ) end
	if( comp_poly == 0 or comp_poly == nil ) then comp_poly = GameGetGameEffect( entity_id, "POLYMORPH_UNSTABLE" ) end
	
	-- forever polymorph!
	if( comp_poly ) then ComponentSetValue2( comp_poly, "frames", -1 ) end
end

-- this gets called if player tries to duplicate perks by polymorphing
function nullroom_polymorph_violation( entity_id )

	local pos_x, pos_y = EntityGetTransform( entity_id )
	SetRandomSeed( entity_id, GameGetFrameNum() )

	-- print( "god are angry!" )

	-- deal with poly violations
	local message = "$logdesc_gods_are_angry"
	local steve_file = "data/entities/animals/necromancer_super.xml"

	local in_parallel_worlds = true
	local par_x, par_y = GetParallelWorldPosition( pos_x, pos_y )
	if( par_x == 0 and par_y == 0 ) then in_parallel_worlds = false end

	-- 50% chance of perma polymorph in parallel worlds
	if( in_parallel_worlds ) then

		local par_poly_violations = tonumber(GlobalsGetValue("PARALLEL_POLYMORPH_VIOLATIONS", "0"))
		SetRandomSeed( 64687, par_poly_violations )
		-- 50% chance of perma polymorph
		if( Random( 1, 100 ) <= 50 ) then
			permapolymorph_entity( entity_id )
			message = "$logdesc_gods_are_very_angry"
			steve_file = "data/entities/animals/sheep.xml"
		end

		par_poly_violations = par_poly_violations + 1
		GlobalsSetValue( "PARALLEL_POLYMORPH_VIOLATIONS", tostring( par_poly_violations ) )
	end

	-- if too many violations, punish harder! 
	--[[
	local poly_violations = tonumber(GlobalsGetValue("POLYMORPH_VIOLATIONS", 0))
	if poly_violations >= 1 then
		SetRandomSeed( 64687, poly_violations )
		-- 50% chance of perma polymorph
		if( Random( 1, 100 ) <= 50 ) then
			permapolymorph_entity( entity_id )
			message = "$logdesc_gods_are_very_angry"
			steve_file = "data/entities/animals/sheep.xml"
		end
	end
	]]--

	-- NOTE( Petri ): This is used to keep track of total violations
	local poly_violations = tonumber(GlobalsGetValue("POLYMORPH_VIOLATIONS", 0))
	poly_violations = poly_violations + 1
	GlobalsSetValue( "POLYMORPH_VIOLATIONS", tostring( poly_violations ) )

	GamePrintImportant( message, "" )

	-- randomize the position of steve spawn
	local entity_polyban = EntityGetClosestWithTag(pos_x, pos_y, "no_polymorphing_allowed")
	local px = pos_x
	local py = pos_y
	if( entity_polyban ~= 0 ) then
		px, py = EntityGetTransform( entity_polyban )
	end

	if( Random( 1, 100 ) <= 50 ) then
		px = pos_x
		py = pos_y - 30
	end
	px = px + Random( -40, 40 )
	py = py + Random( -40, 40 )

	-- load extra angry steve
	EntityLoad("data/entities/particles/necromancer_twirl_only.xml", px, py )
	local steve = EntityLoad(steve_file, px, py)
	local game_effect_comp = GetGameEffectLoadTo( steve, "BERSERK", true )
	if game_effect_comp ~= nil then
		ComponentSetValue( game_effect_comp, "frames", "-1" )
	end

end

-- removes all the perks from player, but also deals with polymorphed player
function nullroom_remove_all_perks()
	local players = get_players()
	local player_id = players[1]
	
	if ( player_id ~= nil ) then
		IMPL_remove_all_perks( player_id )
	else
		-- print( "player not found, trying to avoid perking it!" )
		players = EntityGetWithTag( "polymorphed_player" )
		player_id = players[1]
		if( player_id ~= nil ) then
			nullroom_polymorph_violation( player_id )
		else
			-- remove all perks on screen?
		end
	end
end

----------------------------

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)

local altars = EntityGetWithTag( "null_room_check" )

if ( #altars >= 3 ) then
	GameTriggerMusicEvent( "music/oneshot/heaven_02_no_drs", true, x, y )
	AddFlagPersistent( "secret_null" )
	
	EntityLoad( "data/entities/particles/supernova.xml", x, y )
	create_all_player_perks( x, y - 32 )
	-- remove_all_perks()
	nullroom_remove_all_perks()
	
	GamePrintImportant( "$log_curse_secret", "" )
	
	for i,v in ipairs( altars ) do
		EntityKill( v )
	end
end

function DEBUG_REMOVE_ALL_PERKS()
	GameTriggerMusicEvent( "music/oneshot/heaven_02_no_drs", true, x, y )
	AddFlagPersistent( "secret_null" )
	
	local x, y = GameGetCameraPos()
	EntityLoad( "data/entities/particles/supernova.xml", x, y )
	create_all_player_perks( x, y - 32 )
	-- remove_all_perks()
	nullroom_remove_all_perks()
	
	GamePrintImportant( "$log_curse_secret", "" )
	
	for i,v in ipairs( altars ) do
		EntityKill( v )
	end
end
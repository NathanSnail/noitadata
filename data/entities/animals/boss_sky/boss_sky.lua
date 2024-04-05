dofile_once("data/scripts/lib/utilities.lua")

local x, y = EntityGetTransform( GetUpdatedEntityID() )
local var = EntityGetFirstComponent( GetUpdatedEntityID(), "VariableStorageComponent" )

function init( entity_id )
	local players = get_players()
	if #players > 0 then
		component_read( EntityGetFirstComponent( players[1], "DamageModelComponent" ), { max_hp = 0, hp = 0 }, function(comp)
			local damagemodel = EntityGetFirstComponent( entity_id, "DamageModelComponent" )
			if  damagemodel ~= nil then
				ComponentSetValue2( damagemodel, "max_hp", comp.max_hp )
				ComponentSetValue2( damagemodel, "hp", comp.max_hp )
			end
		end)
	end

	if var ~= nil then
		local ystart = ComponentGetValue2( var, "value_float" )
		if ystart == 0.0 then 
			ComponentSetValue2( var, "value_float", y )
		end
	end
end

function damage_received( damage )
	local entity_id = GetUpdatedEntityID()

	-- reflect all damage to player
	local hp_percentage = 0
	component_read( EntityGetFirstComponent( entity_id, "DamageModelComponent" ), { max_hp = 0, hp = 0 }, function(comp)		
		hp_percentage = (comp.hp - damage) / comp.max_hp
	end)
	
	local entity_dmg = EntityLoad( "data/entities/animals/boss_sky/boss_sky_damage.xml", x, y )
	local var2 = EntityGetFirstComponent( entity_dmg, "VariableStorageComponent" )
	if var2 ~= nil then
		ComponentSetValue2( var2, "value_float", hp_percentage )
	end

	EntityAddTag( entity_id, "music_energy_100_near" )
end

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local locations = EntityGetWithTag("boss_phase2_marker")
	if #locations > 0 then
		for i,it in ipairs( locations ) do
			x, y = EntityGetTransform( it )
			EntityLoad( "data/entities/animals/boss_sky/apparition_spawn_fx.xml", x, y )
		end
	end

	AddFlagPersistent( "miniboss_sky" )
	StatsLogPlayerKill( GetUpdatedEntityID() )
end


-- main
if EntityHasTag( GetUpdatedEntityID(), "boss" ) then
	local players = get_players()
	if #players > 0 then
		local player_id = players[1]
		EntityRemoveStainStatusEffect( player_id, "PROTECTION_ALL", 5 )
		EntityAddRandomStains( player_id, CellFactory_GetType( "water" ), 1 ) -- not so stainless armour 
	end

	VerletApplyCircularForce( x, y, 80, 0.14 )


	if var ~= nil then
		local ystart = ComponentGetValue2( var, "value_float" )
		if y > ystart + 500 then
			local body_id = PhysicsBodyIDGetFromEntity( GetUpdatedEntityID() )[1]
			local bx, by = GamePosToPhysicsPos( x, ystart )
			PhysicsBodyIDSetTransform( body_id, bx, by, 0, 0, 0, 0 )
			EntityLoad( "data/entities/particles/teleportation_source.xml", x, y )
			EntityLoad( "data/entities/particles/teleportation_target.xml", x, ystart )
			GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/teleport/tick", x, ystart )
		end
	end
else
	-- hax - used by apparition_spawn_fx.xml
	local spawn_state, apparition = SpawnApparition( x, y, 0, true )

	local players = get_players()
	if #players > 0 then
		component_read( EntityGetFirstComponent( players[1], "DamageModelComponent" ), { max_hp = 0, hp = 0 }, function(comp)
			local damagemodel = EntityGetFirstComponent( apparition, "DamageModelComponent" )
			if  damagemodel ~= nil then
				ComponentSetValue2( damagemodel, "max_hp", comp.max_hp )
				ComponentSetValue2( damagemodel, "hp", comp.max_hp )
			end
		end)
	end

	local comp = EntityAddComponent( apparition, "HealthBarComponent", { gui_max_distance_visible = 350 } )
	EntityAddTag( apparition, "miniboss" )
	EntityAddTag( apparition, "music_energy_000_near" )
	local musicenergy = EntityGetFirstComponent( apparition, "MusicEnergyAffectorComponent" )
	EntityRemoveComponent( apparition, musicenergy )
end

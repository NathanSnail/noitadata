dofile_once( "data/scripts/lib/utilities.lua" )
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local speed = 3

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local player = EntityGetInRadiusWithTag(pos_x, pos_y, 300, "player_unit")[1]
if player == nil then return end

-- update lap time display
local stopwatch_id = EntityGetClosestWithTag(pos_x, pos_y, "stopwatch_lap")
if stopwatch_id ~= nil then
	local lcomp = get_variable_storage_component( entity_id, "lap_start_time" )
	local scomp = get_variable_storage_component( stopwatch_id, "time" )
	
	if ( scomp ~= nil ) and ( lcomp ~= nil ) then
		component_read(get_variable_storage_component(entity_id, "lap_start_time"), { value_int = 0 }, function(comp)
			local lap_time = GameGetFrameNum() - comp.value_int
			ComponentSetValue2(get_variable_storage_component(stopwatch_id, "time"), "value_int", lap_time)
		end)
	end
end

local wand_id = find_the_wand_held(player)
if wand_id == nil or wand_id == NULL_ENTITY then return end

-- see if stuck in a wall and try to release
if RaytracePlatforms(pos_x, pos_y, pos_x + 0.1, pos_y) then
	local vx = 2
	local vy = 0
	for i=1,8 do
		local x = vx + pos_x
		local y = vy + pos_y
		if not RaytracePlatforms(x, y, x + 0.1, y) then
			EntitySetTransform(entity_id, x, y)
			return
		end
		vx,vy = vec_rotate(vx, vy, math.pi / 4)
	end
end

local _,_,dir = EntityGetTransform( wand_id )
EntitySetTransform(entity_id, pos_x, pos_y, dir)

-- move
edit_component( entity_id, "VelocityComponent", function(comp,vars)
	-- thrust
	local vx = 0
	local vy = 0
	local controls_comp = EntityGetFirstComponent(player, "ControlsComponent")
	local is_thrusting = controls_comp ~= nil and ComponentGetValue2( controls_comp, "mButtonDownFly")
	if is_thrusting then
		vx = speed
		vx, vy = vec_rotate(vx, vy, dir)
	end
	vx, vy = vec_add(vx, vy, ComponentGetValueVector2(comp, "mVelocity"))
	ComponentSetValueVector2( comp, "mVelocity", vx, vy)

	-- jetpack
	EntitySetComponentsWithTagEnabled(entity_id, "jetpack", is_thrusting)
	
	-- sprite animation and orientation
	local anim = "float"
	if is_thrusting then anim = "fly" end
	local scale_y = 1
	if dir < -math.pi * 0.5 or dir > math.pi * 0.5 then scale_y = -1 end
	local sprite_comp = EntityGetFirstComponent(entity_id, "SpriteComponent" )
	component_write(sprite_comp, { 
		rect_animation = anim,
		special_scale_y = scale_y
	})
end)


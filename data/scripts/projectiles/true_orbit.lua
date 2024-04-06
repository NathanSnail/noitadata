dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local owner_id = 0

local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent" )
if ( comp ~= nil ) then
	owner_id = ComponentGetValue2( comp, "mWhoShot" )
end

if ( owner_id ~= nil ) and ( owner_id ~= NULL_ENTITY ) then
	local orbitdist = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "true_orbit_dist" )
	local orbitdir = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "true_orbit_dir" )
	local px, py, pr, psx, psy = EntityGetTransform( owner_id )
	local vel_x,vel_y = 0,0
	
	if ( orbitdist ~= nil ) and ( orbitdir ~= nil ) and ( px ~= nil ) and ( py ~= nil ) then
		edit_component( entity_id, "VelocityComponent", function(comp2,vars)
			vel_x,vel_y = ComponentGetValueVector2( comp2, "mVelocity")
		end)
		
		local dist = ComponentGetValue2( orbitdist, "value_float" )
		local dirmult = ComponentGetValue2( orbitdir, "value_float" )
		
		if ( dist < 16 ) then
			dist = math.sqrt( ( vel_y ) ^ 2 + ( vel_x ) ^ 2 ) * 0.05
			dist = math.max( 16, dist )
			dirmult = psx
			
			ComponentSetValue2( orbitdist, "value_float", dist )
			ComponentSetValue2( orbitdir, "value_float", psx )
			
			edit_component( entity_id, "ProjectileComponent", function(comp2,vars)
				vars.collide_with_world = 0
				vars.die_on_low_velocity = 0
			end)
		end
		
		local dir = get_direction( px, py, x, y )
		local dir_ = dir + 0.33 * dirmult
		
		local oldx = px + math.cos( dir ) * dist
		local oldy = py - math.sin( dir ) * dist
		local newx = px - math.cos( dir_ ) * dist
		local newy = py + math.sin( dir_ ) * dist
		
		EntitySetTransform( entity_id, newx, newy )
		local diffx = newx - oldx
		local diffy = newy - oldy
	
		edit_component( entity_id, "VelocityComponent", function(comp2,vars)
			vel_x = diffx
			vel_y = diffy

			ComponentSetValueVector2( comp2, "mVelocity", vel_x, vel_y)
		end)
	end
end
dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

if( EntityGetFirstComponent( entity_id, "NullDamageComponent" ) == nil ) then EntityAddComponent( entity_id, "NullDamageComponent" )  end
entity_id = EntityGetRootEntity( entity_id )

if ( entity_id ~= NULL_ENTITY ) then
	if( EntityGetFirstComponent( entity_id, "NullDamageComponent" ) == nil ) then EntityAddComponent( entity_id, "NullDamageComponent" )  end

	edit_component( entity_id, "ProjectileComponent", function(comp,vars)
		ComponentSetValue( comp, "on_death_explode", "0" )
		ComponentSetValue( comp, "on_lifetime_out_explode", "0" )
		ComponentSetValue( comp, "damage", "0" )
	end)
	
	local comps = EntityGetComponent( entity_id, "ExplosionComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			EntitySetComponentIsEnabled( entity_id, v, false )
		end
	end
	
	comps = EntityGetComponent( entity_id, "ExplodeOnDamageComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			EntitySetComponentIsEnabled( entity_id, v, false )
		end
	end
	
	comps = EntityGetComponent( entity_id, "ProjectileComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			ComponentObjectSetValue2( v, "damage_by_type", "projectile", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "electricity", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "explosion", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "fire", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "melee", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "drill", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "slice", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "ice", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "healing", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "physics_hit", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "radioactive", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "poison", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "overeating", 0 )
			ComponentObjectSetValue2( v, "damage_by_type", "curse", 0 )
		end
	end

	-- area damage
	local area_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "AreaDamageComponent" )
	while( area_comp ~= nil ) do
		EntityRemoveComponent( entity_id, area_comp )
		area_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "AreaDamageComponent" )
	end
	
	
	comps = EntityGetComponent( entity_id, "LightningComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			EntitySetComponentIsEnabled( entity_id, v, false )
		end
	end
end

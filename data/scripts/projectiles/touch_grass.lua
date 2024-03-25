-- convert entities only if not touching grass

local safe_sky_min = 0.2

function init( entity_id )
	local safe = GlobalsGetValue( "TOUCHING_GRASS" ) == "1"
	if safe then
		local comp = EntityGetFirstComponent( entity_id, "MagicConvertMaterialComponent" )
		if comp ~= NULL_ENTITY then
			EntitySetComponentIsEnabled( entity_id, comp, false )
		end
	end
end


-- main, this is called by the custom card entity
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local sky = 0
sky = math.max( sky, GameGetSkyVisibility( x, 		y ) )
sky = math.max( sky, GameGetSkyVisibility( x, 		y-16 ) )
sky = math.max( sky, GameGetSkyVisibility( x-16, 	y ) )
sky = math.max( sky, GameGetSkyVisibility( x+16, 	y ) )

local comp = EntityGetFirstComponent( entity_id, "ParticleEmitterComponent" )
if comp ~= NULL_ENTITY then
	local safe = sky > safe_sky_min
	local in_hand = EntityGetFirstComponent( entity_id, "VariableStorageComponent" ) -- hack, the component is enabled only in hand

	ComponentSetValue2( comp, "is_emitting", safe )

	if in_hand then
		if safe then
			GlobalsSetValue( "TOUCHING_GRASS", "1" )
		else
			GlobalsSetValue( "TOUCHING_GRASS", "0" )
		end
	end
end
dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y )

	-- see if filled (alive)
	local mat_mimic = CellFactory_GetType( "mimic_liquid")
	local mat = GetMaterialInventoryMainMaterial( entity_id )
	local alive = (mat == mat_mimic)
	local awoken_count = tonumber( GlobalsGetValue( "potion_mimics_awoken", "0" ) )

	if alive and HasFlagPersistent( "card_unlocked_sea_mimic" ) and (not EntityHasTag( entity, "mimic_potion_sky" )) and Random( 1, 5 ) == 1 then
		CreateItemActionEntity( "SEA_MIMIC", x, y )
	end
end

-- this is needed because item component enable/disable logic doesn't enable the legs for some reason
function enabled_changed( entity_id, is_enabled )
	if is_enabled == false then
		return 
	end

	local c = EntityGetAllChildren( entity_id )
	if ( c ~= nil ) then
		for a,b in ipairs( c ) do
			EntitySetComponentsWithTagEnabled( b, "enabled_in_world", true )
		end
	end
end


-- main update
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
SetRandomSeed( x, y )

-- make pickable if charmed
local comp = GameGetGameEffect( entity_id, "CHARM" )
if ( comp ~= nil ) and ( comp ~= NULL_ENTITY ) then
	EntitySetComponentsWithTagEnabled( entity_id, "enabled_if_charmed", true )
else
	EntitySetComponentsWithTagEnabled( entity_id, "enabled_if_charmed", false )
end

-- see if filled (alive)
local mat_mimic = CellFactory_GetType( "mimic_liquid")
local mat = GetMaterialInventoryMainMaterial( entity_id )
local alive = (mat == mat_mimic)

-- make unconscious if empty
local parent = EntityGetParent( entity_id )
if parent == NULL_ENTITY then
	EntitySetComponentsWithTagEnabled( entity_id, "alive", alive )
end

component_write( EntityGetFirstComponent( entity_id, "IKLimbsAnimatorComponent" ), { is_limp = (alive == false) } )

-- make random noises
if alive and ( Random(1,8) == 1) then
	if ( Random(1,4) == 1) then
		GameEntityPlaySound( entity_id, "jump" )
	else
		GameEntityPlaySound( entity_id, "damage/projectile" )
	end
end


if alive then
	local var = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent", "potion_mimic_awoken" )
	if var ~= nil then
		local awoken = ComponentGetValue2( var, "value_bool" )
		if not awoken then 
			ComponentSetValue2( var, "value_bool", true )

			local count = tonumber( GlobalsGetValue( "potion_mimics_awoken", "0" ) )
			GlobalsSetValue( "potion_mimics_awoken", tostring(count + 1) )
		end
	end
end
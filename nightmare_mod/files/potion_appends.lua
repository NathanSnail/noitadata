materials_magic = 
{
	{
		material="magic_liquid_teleportation",
		cost=500,
	},
	{
		material="magic_liquid_polymorph",
		cost=500,
	},
	{
		material="magic_liquid_random_polymorph",
		cost=500,
	},
	{
		material="magic_liquid_berserk",
		cost=500,
	},
	{
		material="magic_liquid_charm",
		cost=800,
	},
	{
		material="material_confusion",
		cost=800,
	},
	{
		material="magic_liquid_movement_faster",
		cost=800,
	},
	{
		material="magic_liquid_worm_attractor",
		cost=800,
	},
}

function init( entity_id )
	print("nightmare potion")

	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y ) -- so that all the potions will be the same in every position with the same seed

	local potion_material = "water"

	if( Random( 0, 100 ) <= 50 ) then
		-- 0.05% chance of magic_liquid_
		potion_material = random_from_array( materials_magic )
		potion_material = potion_material.material
	else
		potion_material = random_from_array( materials_standard )
		potion_material = potion_material.material
	end
	
	local components = EntityGetComponent( entity_id, "VariableStorageComponent" )

	if( components ~= nil ) then
		for key,comp_id in pairs(components) do 
			local var_name = ComponentGetValue( comp_id, "name" )
			if( var_name == "potion_material") then
				potion_material = ComponentGetValue( comp_id, "value_string" )
			end
		end
	end

	AddMaterialInventoryMaterial( entity_id, potion_material, 1000 )
end
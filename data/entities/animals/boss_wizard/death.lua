dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	
	-- StatsLogPlayerKill( GetUpdatedEntityID() )
	
	local pw = check_parallel_pos( x )
	SetRandomSeed( pw, 30 )
	
	local opts = { "ADD_TRIGGER", "ADD_TIMER", "ADD_DEATH_TRIGGER", "RESET", "DUPLICATE" }
	
	for i=1,5 do
		CreateItemActionEntity( opts[i], x - 8 * 4 + (i-1) * 16, y )
	end
	
	EntityLoad( "data/entities/items/books/book_mestari.xml",  x - 16, y )
	EntityLoad( "data/entities/items/pickup/wandstone.xml",  x + 16, y )
	
	AddFlagPersistent( "card_unlocked_mestari" )
	AddFlagPersistent( "miniboss_wizard" )

	local material_str = ""
	local damage_comp = EntityGetFirstComponent( entity_id, "DamageModelComponent")
	if( damage_comp ~= nil ) then
		local material = ComponentGetValue( damage_comp, "mLiquidMaterialWeAreIn" )
		if( material ~= -1 ) then 
			material_str = CellFactory_GetName( material )
		end
	end

	if( damage_message == "$damage_drowning" and material_str == "swamp" ) then
		CreateItemActionEntity( "HOMING_WAND", x + 32, y )
		AddFlagPersistent( "card_unlocked_homing_wand" )
	end

end
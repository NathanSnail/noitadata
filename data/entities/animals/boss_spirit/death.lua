dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	
	CreateItemActionEntity( "MASS_POLYMORPH", x, y )
	
	AddFlagPersistent( "card_unlocked_polymorph" )
	AddFlagPersistent( "miniboss_islandspirit" )
	
	GlobalsSetValue( "BOSS_SPIRIT_DEAD", "1" )
	
	local anger = tonumber( GlobalsGetValue( "HELPLESS_KILLS", "1" ) ) or 1
	if ( anger >= 300 ) then
		AddFlagPersistent( "miniboss_threelk" )
	end
end
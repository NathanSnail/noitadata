dofile_once("data/scripts/lib/utilities.lua")

function interacting(entity_who_interacted, entity_interacted, interactable_name)
	local x, y = EntityGetTransform( entity_interacted )
	
	edit_component( entity_interacted, "VelocityComponent", function(comp,vars)
		ComponentSetValueVector2( comp, "mVelocity", 0, 0 )
	end)

	edit_component( entity_interacted, "CharacterDataComponent", function(comp,vars)
		ComponentSetValueVector2( comp, "mVelocity", 0, 0 )
	end)
	
	edit_component( entity_who_interacted, "VelocityComponent", function(comp,vars)
		ComponentSetValueVector2( comp, "mVelocity", 0, 0 )
	end)

	edit_component( entity_who_interacted, "CharacterDataComponent", function(comp,vars)
		ComponentSetValueVector2( comp, "mVelocity", 0, 0 )
	end)
	
	SetRandomSeed( x + entity_interacted, y + GameGetFrameNum() )
	local rnd = Random( 1, 20 )
	
	if ( rnd ~= 13 ) then
		GamePlayAnimation( entity_interacted, "pet", 99, "stand", 0 )
		EntitySetComponentsWithTagEnabled( entity_interacted, "enabled_if_charmed", false )
		
		GamePrint( "$ui_longleg_love_msg1" )
	else
		EntityLoad( "data/entities/projectiles/explosion.xml", x, y )
		
		GamePrint( "$ui_longleg_love_msg2" )
	end

	GameEntityPlaySound( entity_who_interacted, "pet" )
end

-- Hi Noita community! Here's a little nod to you. Thanks for the support!
dofile_once("data/scripts/lib/utilities.lua")

function material_area_checker_failed( pos_x, pos_y )
	if HasFlagPersistent( "card_unlocked_piss" ) then
		SetRandomSeed( x, y ) 
		if Random( 0, 2 ) == 1 then
			EntityLoad( "data/entities/items/pickup/goldnugget_200.xml", pos_x, pos_y )
		else
			local count = Random( 5, 19 )
			for i=0,count do
				EntityLoad( "data/entities/items/pickup/goldnugget_10.xml", pos_x, pos_y )
			end
		end
	else
		CreateItemActionEntity( "TOUCH_PISS", pos_x, pos_y )
		AddFlagPersistent( "card_unlocked_piss" )
	end

	GameTriggerMusicFadeOutAndDequeueAll( 10.0 )
	GameTriggerMusicEvent( "music/oneshot/huussi", false, x, y )
end

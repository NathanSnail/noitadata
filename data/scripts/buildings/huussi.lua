dofile_once("data/scripts/lib/utilities.lua")

function material_area_checker_failed( pos_x, pos_y )
	CreateItemActionEntity( "TOUCH_PISS", pos_x, pos_y )
	GameTriggerMusicFadeOutAndDequeueAll( 5.0 )
	GameTriggerMusicEvent( "music/oneshot/huussi", false, x, y )
end

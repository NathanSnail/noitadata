function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	GameTriggerMusicFadeOutAndDequeueAll( 5.0 )
	GameTriggerMusicEvent( "music/oneshot/sax_dramatic", true, pos_x, pos_y )
end
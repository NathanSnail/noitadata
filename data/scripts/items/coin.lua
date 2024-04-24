dofile( "data/scripts/game_helpers.lua" )

function item_pickup( entity_item, entity_who_picked, name )
	print( "COIN" ) 

	-- NOTE( Petri ): 24.4.2024 - this is legacy file? 
	
	local wallet = EntityGetComponent( entity_who_picked, "WalletComponent" )

	if( wallet ~= nil ) then
		for i,v in ipairs(wallet) do
			money = tonumber( ComponentGetValue2( v, "money" ) )
			money = money + 1
			GamePrint( money )
			ComponentSetValue2( v, "money", money)
		end
	end

	-- remove the item from the game
	EntityKill( entity_item )
end

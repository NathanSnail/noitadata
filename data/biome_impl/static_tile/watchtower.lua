dofile_once("data/biome_impl/static_tile/temples_common.lua")


-- HACK: for some some reason the default registrations for these don't work here
RegisterSpawnFunction( 0xffaaff00, "spawn_small_enemies2" )
RegisterSpawnFunction( 0xffffaa00, "spawn_big_enemies2" )

-- copypasted from snowcastle

g_small_enemies =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 0.2,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add skullflys after this step
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 2,    
		entities 	= {
			"data/entities/animals/scavenger_grenade.xml",
			"data/entities/animals/scavenger_smg.xml",
		}
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 2,    
		entities 	= {
			{
				min_count	= 1,
				max_count	= 2,
				entity	= "data/entities/animals/scavenger_grenade.xml",
			},
			{
				min_count	= 0,
				max_count	= 2,
				entity	= "data/entities/animals/scavenger_smg.xml",
			},
		}
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/sniper.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/miner.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/shotgunner.xml"
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/tank.xml"
	},
	{
		prob   		= 0.01,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/tank_rocket.xml"
	},
	{
		prob   		= 0.002,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/tank_super.xml"
	},
	{
		prob   		= 0.04,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/scavenger_heal.xml"
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/tank_super.xml",
		ngpluslevel = 1,
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/scavenger_leader.xml",
		ngpluslevel = 2,
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entities 	= {
			{
				min_count	= 0,
				max_count	= 1,
				entity	= "data/entities/animals/scavenger_grenade.xml",
			},
			{
				min_count	= 1,
				max_count	= 2,
				entity	= "data/entities/animals/scavenger_smg.xml",
			},
			{
				min_count	= 0,
				max_count	= 1,
				entity	= "data/entities/animals/coward.xml",
			},
		}
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/shotgunner_hell.xml",
		ngpluslevel = 1,
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/sniper_hell.xml",
		ngpluslevel = 2,
	},

	-- jussi
	{
		prob   		= 1.1,
		min_count	= 1,
		max_count	= 2,    
		entities 	= {
			"data/entities/animals/drunk/scavenger_grenade.xml",
			"data/entities/animals/drunk/scavenger_smg.xml",
		},
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 1.1,
		min_count	= 1,
		max_count	= 2,    
		entities 	= {
			{
				min_count	= 1,
				max_count	= 2,
				entity	= "data/entities/animals/drunk/scavenger_grenade.xml",
			},
			{
				min_count	= 0,
				max_count	= 2,
				entity	= "data/entities/animals/drunk/scavenger_smg.xml",
			},
		},
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 1.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/drunk/sniper.xml",
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 1.1,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/drunk/miner.xml",
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 1.1,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/animals/drunk/shotgunner.xml",
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 1.05,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/items/easter/beer_bottle.xml",
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 1.01,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/items/easter/beer_bottle.xml",
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 1.002,
		min_count	= 1,
		max_count	= 2,    
		entity 	= "data/entities/items/easter/beer_bottle.xml",
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 1.04,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/drunk/scavenger_heal.xml",
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 1.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/items/easter/beer_bottle.xml",
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 1.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/items/easter/beer_bottle.xml",
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 1.1,
		min_count	= 1,
		max_count	= 1,    
		entities 	= {
			{
				min_count	= 0,
				max_count	= 1,
				entity	= "data/entities/animals/drunk/scavenger_grenade.xml",
			},
			{
				min_count	= 1,
				max_count	= 2,
				entity	= "data/entities/animals/drunk/scavenger_smg.xml",
			},
		},
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
}

------------ BIG ENEMIES ------------------------------------------------------

g_big_enemies =
{
	total_prob = 0,
	-- this is air, so nothing spawns at 0.6
	{
		prob   		= 0.3,
		min_count	= 0,
		max_count	= 0,    
		entity 	= ""
	},
	-- add skullflys after this step
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entities 	=  {
			"data/entities/animals/scavenger_leader.xml",
			{
				min_count	= 1,
				max_count 	= 3,
				entity = "data/entities/animals/scavenger_grenade.xml",
			},
			{
				min_count	= 1,
				max_count 	= 3,
				entity = "data/entities/animals/scavenger_smg.xml",
			},
		}
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,
		ngpluslevel	= 1,
		entities 	=  {
			"data/entities/animals/scavenger_leader.xml",
			{
				min_count	= 1,
				max_count 	= 2,
				entity = "data/entities/animals/scavenger_grenade.xml",
			},
			{
				min_count	= 1,
				max_count 	= 2,
				entity = "data/entities/animals/scavenger_smg.xml",
			},
			{
				min_count	= 1,
				max_count 	= 2,
				entity = "data/entities/animals/coward.xml",
			},
		}
	},
	{
		prob   		= 0.1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/tank.xml"
	},
	{
		prob   		= 0.03,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/tank_rocket.xml"
	},
	{
		prob   		= 0.04,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/scavenger_heal.xml"
	},
	{
		prob   		= 0.005,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/tank_super.xml"
	},
	{
		prob   		= 0.02,
		min_count	= 1,
		max_count	= 1,    
		entities 	=  {
			"data/entities/animals/scavenger_clusterbomb.xml",
			{
				min_count	= 1,
				max_count 	= 3,
				entity = "data/entities/animals/scavenger_grenade.xml",
			},
			{
				min_count	= 1,
				max_count 	= 3,
				entity = "data/entities/animals/scavenger_smg.xml",
			},
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "data/entities/animals/scavenger_heal.xml",
			},
		}
	},
	{
		prob   		= 0.04,
		min_count	= 1,
		max_count	= 1,    
		entities 	=  {
			"data/entities/animals/coward.xml",
			{
				min_count	= 1,
				max_count 	= 2,
				entity = "data/entities/animals/scavenger_grenade.xml",
			},
			{
				min_count	= 1,
				max_count 	= 2,
				entity = "data/entities/animals/scavenger_smg.xml",
			},
		}
	},
	{
		prob   		= 0.05,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/buildings/hpcrystal.xml",
		ngpluslevel = 1,
	},
	{
		prob   		= 0.075,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/necrobot.xml",
		ngpluslevel = 2,
	},
	{
		prob   		= 0.04,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/necrobot_super.xml",
		ngpluslevel = 3,
	},
	-- jussi
	{
		prob   		= 2.1,
		min_count	= 1,
		max_count	= 1,    
		entities 	=  {
			"data/entities/animals/drunk/scavenger_leader.xml",
			{
				min_count	= 1,
				max_count 	= 3,
				entity = "data/entities/animals/drunk/scavenger_grenade.xml",
			},
			{
				min_count	= 1,
				max_count 	= 3,
				entity = "data/entities/animals/drunk/scavenger_smg.xml",
			},
		},
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 2.1,
		min_count	= 1,
		max_count	= 1,
		ngpluslevel	= 1,
		entities 	=  {
			"data/entities/animals/drunk/scavenger_leader.xml",
			{
				min_count	= 1,
				max_count 	= 2,
				entity = "data/entities/animals/drunk/scavenger_grenade.xml",
			},
			{
				min_count	= 1,
				max_count 	= 2,
				entity = "data/entities/animals/drunk/scavenger_smg.xml",
			},
		},
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 2.04,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/animals/drunk/scavenger_heal.xml",
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
	{
		prob   		= 2.02,
		min_count	= 1,
		max_count	= 1,    
		entities 	=  {
			"data/entities/animals/drunk/scavenger_clusterbomb.xml",
			{
				min_count	= 1,
				max_count 	= 3,
				entity = "data/entities/animals/drunk/scavenger_grenade.xml",
			},
			{
				min_count	= 1,
				max_count 	= 3,
				entity = "data/entities/animals/drunk/scavenger_smg.xml",
			},
			{
				min_count	= 1,
				max_count 	= 1,
				entity = "data/entities/animals/drunk/scavenger_heal.xml",
			},
		},
		spawn_check = function()
			local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
			return jussi
		end,
	},
}


function spawn_small_enemies2(x, y)
	--if safe( x, y ) then
		spawn(g_small_enemies,x,y)
	--end
end

function spawn_big_enemies2(x, y)
	--if safe( x, y ) then
		spawn(g_big_enemies,x,y)
	--end
end

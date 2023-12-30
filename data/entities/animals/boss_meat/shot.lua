dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )

SetRandomSeed( x + GameGetFrameNum(), y )
local rnd = Random( 0, 99 ) * 0.01
local angle = 3.1415926535 * 2 * rnd

local vx = math.cos( angle ) * 90
local vy = 0 - math.sin( angle ) * 90

shoot_projectile( entity_id, "data/entities/animals/boss_meat/acidshot_slow.xml", x, y, vx, vy)
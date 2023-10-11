dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local angle = math.pi * 2 * ProceduralRandom( pos_x + 326, pos_y + GameGetFrameNum() )
local shot_vel_x = math.cos(angle) * 1000
local shot_vel_y = 0 - math.sin(angle) * 1000
shoot_projectile_from_projectile( entity_id, "data/entities/projectiles/deck/bounce_lightning.xml", pos_x + shot_vel_x * 0.05, pos_y + shot_vel_y * 0.05, shot_vel_x, shot_vel_y, false )

EntityKill( entity_id )
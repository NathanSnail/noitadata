dofile("data/scripts/lib/utilities.lua")
dofile("data/scripts/gun/procedural/gun_action_utils.lua")

local entity_id = GetUpdatedEntityID()

-- add always cast
local comp = get_variable_storage_component( entity_id, "extra_spell" )
if not comp then return end
AddGunAction( entity_id, ComponentGetValue(comp, "value_string") )

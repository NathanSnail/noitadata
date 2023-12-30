dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( GetUpdatedEntityID() )

local anger = tonumber( GlobalsGetValue( "HELPLESS_KILLS", "1" ) ) or 1
local boss_hp = math.min(20.0 + anger * 4, 2000)
local comp = EntityGetFirstComponent( entity_id, "DamageModelComponent" )

print("KILLED ANIMALS: " .. tostring( anger ) )

if( comp ~= nil ) then
	ComponentSetValue( comp, "max_hp", tostring(boss_hp) )
	ComponentSetValue( comp, "hp", tostring(boss_hp) )
end

local wispnum = math.min( math.ceil( anger / 10 ), 20 )
if ( wispnum > 0 ) then
	for i=1,wispnum do
		local r = ProceduralRandomf(entity_id + i, 0, -1, 1)
		local offset = r * 24
		local wid = EntityLoad( "data/entities/animals/boss_spirit/wisp.xml", x, y + offset )
		EntityAddChild( entity_id, wid )
	end
end
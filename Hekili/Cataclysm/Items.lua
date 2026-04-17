-- Cataclysm/Items.lua

local addon, ns = ...
local Hekili = _G[ addon ]

-- Safety check: ensure Hekili.Class is a table, not a string
if type(Hekili.Class) ~= "table" then
    return -- Exit if Class isn't properly initialized yet
end

local class, state = Hekili.Class, Hekili.State

-- Ensure specs table exists
if not Hekili.Class.specs then Hekili.Class.specs = {} end
if not Hekili.Class.specs[0] then return end

local all = Hekili.Class.specs[ 0 ]

all:RegisterAbility( "skardyns_grace", {
    cast = 0,
    cooldown = 120,
    gcd = "off",

    item = 133282,
    toggle = "cooldowns",

    handler = function ()
        applyBuff( "speed_of_thought" )
    end,

    auras = {
        speed_of_thought = {
            id = 92099,
            duration = 35,
            max_stack = 1
        }
    }
} )

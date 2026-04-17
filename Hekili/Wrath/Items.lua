-- Wrath/Items.lua

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

all:RegisterAbility( "wrathstone", {
    cast = 0,
    cooldown = 120,
    gcd = "off",    item = function ()
        -- Short-circuit the most likely match first.
        if state.equipped and state.equipped[156000] then return 156000 end
        return 45263
    end,
    items = { 45263, 156000 },
    toggle = "cooldowns",

    handler = function ()
        applyBuff( "wrathstone" )
    end,

    auras = {
        wrathstone = {
            id = 64800,
            duration = 20,
            max_stack = 1
        }
    }
} )

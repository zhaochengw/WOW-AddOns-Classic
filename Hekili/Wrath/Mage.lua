if UnitClassBase( 'player' ) ~= 'MAGE' then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State

local strformat = string.format

local spec = Hekili:NewSpecialization( 8 )

spec:RegisterResource( Enum.PowerType.Mana )

-- Talents
spec:RegisterTalents( {
    arcane_barrage         = {  1847, 1, 44425 },
    arcane_concentration   = {    75, 1, 11213, 12574, 12575, 12576, 12577 },
    arcane_empowerment     = {  1727, 1, 31579, 31582, 31583 },
    arcane_flows           = {  1843, 1, 44378, 44379 },
    arcane_focus           = {    76, 1, 11222, 12839, 12840 },
    arcane_fortitude       = {    85, 1, 28574, 54658, 54659 },
    arcane_instability     = {   421, 1, 15058, 15059, 15060 },
    arcane_meditation      = {  1142, 1, 18462, 18463, 18464 },
    arcane_mind            = {    77, 1, 11232, 12500, 12501, 12502, 12503 },
    arcane_potency         = {  1725, 1, 31571, 31572 },
    arcane_power           = {    87, 1, 12042 },
    arcane_shielding       = {    83, 1, 11252, 12605 },
    arcane_stability       = {    80, 1, 11237, 12463, 12464, 16769, 16770 },
    arcane_subtlety        = {    74, 1, 11210, 12592 },
    arctic_reach           = {   741, 1, 16757, 16758 },
    arctic_winds           = {  1738, 1, 31674, 31675, 31676, 31677, 31678 },
    blast_wave             = {    32, 1, 11113 },
    blazing_speed          = {  1731, 1, 31641, 31642 },
    brain_freeze           = {  1854, 1, 44546, 44548, 44549 },
    burning_determination  = {  2212, 1, 54747, 54749 },
    burning_soul           = {    23, 1, 11083, 12351 },
    burnout                = {  1851, 1, 44449, 44469, 44470, 44471, 44472 },
    chilled_to_the_bone    = {  1856, 1, 44566, 44567, 44568, 44570, 44571 },
    cold_as_ice            = {  1737, 1, 55091, 55092 },
    cold_snap              = {    72, 1, 11958 },
    combustion             = {    36, 1, 11129 },
    critical_mass          = {    33, 1, 11115, 11367, 11368 },
    deep_freeze            = {  1857, 1, 44572 },
    dragons_breath         = {  1735, 1, 31661 },
    empowered_fire         = {  1734, 1, 31656, 31657, 31658 },
    empowered_frostbolt    = {  1740, 1, 31682, 31683 },
    enduring_winter        = {  1855, 1, 44557, 44560, 44561 },
    fiery_payback          = {  1848, 1, 64353, 64357 },
    fingers_of_frost       = {  1853, 1, 44543, 44545 },
    fire_power             = {    35, 1, 11124, 12378, 12398, 12399, 12400 },
    firestarter            = {  1849, 1, 44442, 44443 },
    flame_throwing         = {    28, 1, 11100, 12353 },
    focus_magic            = {  2211, 1, 54646 },
    frost_channeling       = {    66, 1, 11160, 12518, 12519 },
    frost_warding          = {    70, 1, 11189, 28332 },
    frostbite              = {    38, 1, 11071, 12496, 12497 },
    frozen_core            = {  1736, 1, 31667, 31668, 31669 },
    hot_streak             = {  1850, 1, 44445, 44446, 44448 },
    ice_barrier            = {    71, 1, 11426 },
    ice_floes              = {    62, 1, 31670, 31672, 55094 },
    ice_shards             = {    73, 1, 11207, 12672, 15047 },
    icy_veins              = {    69, 1, 12472 },
    ignite                 = {    34, 1, 11119, 11120, 12846, 12847, 12848 },
    impact                 = {    30, 1, 11103, 12357, 12358 },
    improved_blink         = {  1724, 1, 31569, 31570 },
    improved_blizzard      = {    63, 1, 11185, 12487, 12488 },
    improved_cone_of_cold  = {    64, 1, 11190, 12489, 12490 },
    improved_counterspell  = {    88, 1, 11255, 12598 },
    improved_fire_blast    = {    27, 1, 11078, 11080 },
    improved_fireball      = {    26, 1, 11069, 12338, 12339, 12340, 12341 },
    improved_frostbolt     = {    37, 1, 11070, 12473, 16763, 16765, 16766 },
    improved_scorch        = {    25, 1, 11095, 12872, 12873 },
    incanters_absorption   = {  1844, 1, 44394, 44395, 44396 },
    incineration           = {  1141, 1, 18459, 18460, 54734 },
    living_bomb            = {  1852, 1, 44457 },
    magic_absorption       = {  1650, 1, 29441, 29444 },
    magic_attunement       = {    82, 1, 11247, 12606 },
    master_of_elements     = {  1639, 1, 29074, 29075, 29076 },
    mind_mastery           = {  1728, 1, 31584, 31585, 31586, 31587, 31588 },
    missile_barrage        = {  2209, 1, 44404, 54486, 54488, 54489, 54490 },
    molten_fury            = {  1732, 1, 31679, 31680 },
    molten_shields         = {    24, 1, 11094, 13043 },
    netherwind_presence    = {  1846, 1, 44400, 44402, 44403 },
    permafrost             = {    65, 1, 11175, 12569, 12571 },
    piercing_ice           = {    61, 1, 11151, 12952, 12953 },
    playing_with_fire      = {  1730, 1, 31638, 31639, 31640 },
    precision              = {  1649, 1, 29438, 29439, 29440 },
    presence_of_mind       = {    86, 1, 12043 },
    prismatic_cloak        = {  1726, 1, 31574, 31575, 54354 },
    pyroblast              = {    29, 1, 11366 },
    pyromaniac             = {  1733, 1, 34293, 34295, 34296 },
    shatter                = {    67, 1, 11170, 12982, 12983 },
    shattered_barrier      = {  2214, 1, 44745, 54787 },
    slow                   = {  1729, 1, 31589 },
    spell_impact           = {    81, 1, 11242, 12467, 12469 },
    spell_power            = {  1826, 1, 35578, 35581 },
    student_of_the_mind    = {  1845, 1, 44397, 44398, 44399 },
    summon_water_elemental = {  1741, 1, 31687 },
    torment_the_weak       = {  2222, 1, 29447, 55339, 55340 },
    winters_chill          = {    68, 1, 11180, 28592, 28593 },
    world_in_flames        = {    31, 1, 11108, 12349, 12350 },
} )

spec:RegisterAuras( {
-- Increases magic damage taken by up to $s1 and healing by up to $s2.
    amplify_magic = {
        id = 43017,
        duration = 600,
        max_stack = 1,
        copy = { 1008, 8455, 10169, 10170, 27130, 33946, 43017 },
    },
    -- Arcane spell damage increased by $s1% and mana cost of Arcane Blast increased by $s2%.
    arcane_blast = {
        id = 36032,
        duration = 6,
        max_stack = 4,
        copy = { 30451, 42894, 42896, 42897 },
    },
    -- Increases Intellect by $s1.
    arcane_brilliance = {
        id = 43002,
        duration = 3600,
        max_stack = 1,
        shared = "player",
        dot = "buff",
        copy = { 23028, 27127, 43002 },
    },
    -- Increases Intellect by $s1.
    arcane_intellect = {
        id = 42995,
        duration = 1800,
        max_stack = 1,
        shared = "player",
        dot = "buff",
        copy = { 1459, 1460, 1461, 10156, 10157, 27126, 42995 },
    },
    -- Increased damage and mana cost for your spells.
    arcane_power = {
        id = 12042,
        duration = function() return talent.arcane_power.enabled and 18 or 15 end,
        max_stack = 1,
    },
    -- Dazed.
    blast_wave = {
        id = 42945,
        duration = 6,
        max_stack = 1,
        copy = { 11113, 13018, 13019, 13020, 13021, 27133, 33933, 42944, 42945 },
    },
    -- Movement speed increased by $s1%.
    blazing_speed = {
        id = 31643,
        duration = 8,
        max_stack = 1,
    },
    -- Blinking.
    blink = {
        id = 1953,
        duration = 1,
        max_stack = 1,
    },
    -- $42938s1 Frost damage every $42938t1 $lsecond:seconds;.
    blizzard = {
        id = 42940,
        duration = 8,
        max_stack = 1,
        copy = { 42208, 42209, 42210, 42211, 42212, 42213, 42198, 42939, 42940 },
    },
    -- Immune to Interrupt and Silence mechanics.
    burning_determination = {
        id = 54748,
        duration = 20,
        max_stack = 1,
    },
    -- Movement slowed by $s1% and time between attacks increased by $s2%.
    chilled = {
        id = 6136,
        duration = function() return 5 + talent.permafrost.rank end,
        max_stack = 1,
        copy = { 6136, 7321, 12484, 12485, 12486, 15850, 18101, 31257 },
        shared = "target",
    },
    -- Your next damage spell has its mana cost reduced by $/10;s1%.
    clearcasting = {
        id = 12536,
        duration = 15,
        max_stack = 1,
    },
    -- Increases critical strike chance from Fire damage spells by $28682s1%.
    combustion = {
        id = 28682,
        duration = 3600,
        max_stack = 10,
    },
    -- Movement slowed by $s1%.
    cone_of_cold = {
        id = 42931,
        duration = function() return 8 + talent.permafrost.rank end,
        max_stack = 1,
        copy = { 120, 8492, 10159, 10160, 10161, 27087, 42930, 42931 },
    },
    -- Immune to all Curse effects.
    curse_immunity = {
        id = 60803,
        duration = 4,
        max_stack = 1,
        shared = "player",
        dot = "buff",

        -- Effects:
        -- [60803] #0 -- APPLY_AURA, DISPEL_IMMUNITY, points: 100, value: 2, schools: ['holy'], target: TARGET_UNIT_TARGET_ALLY
    },
    -- Increases Intellect by $s1.
    dalaran_brilliance = {
        id = 61316,
        duration = 3600,
        max_stack = 1,
        shared = "player",
        dot = "buff",
    },
    -- Increases Intellect by $s1.
    dalaran_intellect = {
        id = 61024,
        duration = 1800,
        max_stack = 1,
        shared = "player",
        dot = "buff",
    },
    -- Reduces magic damage taken by up to $s1 and healing by up to $s2.
    dampen_magic = {
        id = 43015,
        duration = 600,
        max_stack = 1,
        copy = { 604, 8450, 8451, 10173, 10174, 33944, 43015 },
    },
    -- Stunned and Frozen.
    deep_freeze = {
        id = 44572,
        duration = 5,
        max_stack = 1,
    },
    -- Increased spell power by $w1.
    demonic_pact = {
        id = 48090,
        duration = 45,
        max_stack = 1,
        shared = "player",
        dot = "buff",
    },
    -- Disoriented.
    dragons_breath = {
        id = 42950,
        duration = 5,
        max_stack = 1,
        copy = { 31661, 33041, 33042, 33043, 42949, 42950 },
    },
    -- Gain $s1% of total mana every $t1 sec.
    evocation = {
        id = 12051,
        duration = 8,
        max_stack = 1,
    },
    -- Disarmed!
    fiery_payback = {
        id = 64346,
        duration = 6,
        max_stack = 1,
    },
    -- Your next $s1 spells treat the target as if it were Frozen.
    fingers_of_frost = {
        id = 74396,
        duration = 15,
        max_stack = 2,
    },
    -- Absorbs Fire damage.
    fire_ward = {
        id = 43010,
        duration = 30,
        max_stack = 1,
        copy = { 543, 8457, 8458, 10223, 10225, 27128, 43010 },
    },
    -- $s2 Fire damage every $t2 seconds.
    fireball = {
        id = 42833,
        duration = 8,
        tick_time = 2,
        max_stack = 1,
        copy = { 133, 143, 145, 3140, 8400, 8401, 8402, 10148, 10149, 10150, 10151, 25306, 27070, 38692, 42832, 42833 },
    },
    -- Your next Fireball or Frostfire Bolt spell is instant and costs no mana.
    fireball_proc = {
        id = 57761,
        duration = 15,
        max_stack = 1,
        copy = "brain_freeze",
    },
    -- Your next Flamestrike spell is instant cast and costs no mana.
    firestarter = {
        id = 54741,
        duration = 10,
        max_stack = 1,
    },
    -- $s2 Fire damage every $t2.
    flamestrike = {
        id = 42926,
        duration = 8,
        tick_time = 2,
        max_stack = 1,
        copy = { 2120, 2121, 8422, 8423, 10215, 10216, 27086, 42925, 42926 },
    },
    -- Increases chance to critically hit with spells by $s1%.
    focus_magic = {
        id = 54646,
        duration = 1800,
        max_stack = 1,
    },
    focus_magic_proc = {
        id = 54648,
        duration = 10,
        max_stack = 1,
    },
    -- Increases Armor by $s1 and may slow attackers.
    frost_armor = {
        id = 7301,
        duration = function() return glyph.frost_armor.enabled and 3600 or 1800 end,
        max_stack = 1,
        copy = { 168, 7300, 7301 },
    },
    -- Frozen in place.
    frost_nova = {
        id = 42917,
        duration = 8,
        max_stack = 1,
        copy = { 122, 865, 6131, 10230, 27088, 42917 },
    },
    -- Absorbs Frost damage.
    frost_ward = {
        id = 43012,
        duration = 30,
        max_stack = 1,
        copy = { 6143, 8461, 8462, 10177, 28609, 32796, 43012 },
    },
    -- Frozen.
    frostbite = {
        id = 12494,
        duration = 5,
        max_stack = 1,

        -- Effects:
        -- [12494] #0 -- APPLY_AURA, MOD_ROOT, points: 0, target: TARGET_UNIT_TARGET_ANY
    },
    -- Movement slowed by $s1%.
    frostbolt = {
        id = 42842,
        duration = function() return 9 + talent.permafrost.rank end,
        max_stack = 1,
        copy = { 116, 205, 837, 7322, 8406, 8407, 8408, 10179, 10180, 10181, 25304, 27071, 27072, 38697, 42841, 42842 },
    },
    -- Movement slowed by $s1%.  $s3 Fire damage every $t3 sec.
    frostfire_bolt = {
        id = 47610,
        duration = function() return 9 + talent.permafrost.rank end,
        tick_time = 3,
        max_stack = 1,
        copy = { 44614, 47610 },
    },
    heating_up = {
        duration = 3600, -- Heating up is a pseudo buff that has no duration
        max_stack = 1,
    },
    -- Your next Pyroblast spell is instant cast.
    hot_streak = {
        id = 48108,
        duration = 10,
        max_stack = 1,
    },
    -- Cannot be made invulnerable by Ice Block.
    hypothermia = {
        id = 41425,
        duration = 30,
        max_stack = 1,
    },
    -- Increases armor by $s1, Frost resistance by $s3 and may slow attackers.
    ice_armor = {
        id = 43008,
        duration = function() return glyph.frost_armor.enabled and 3600 or 1800 end,
        tick_time = 6,
        max_stack = 1,
        copy = { 7302, 7320, 10219, 10220, 27124, 43008 },
    },
    -- Absorbs damage.
    ice_barrier = {
        id = 43039,
        duration = 60,
        max_stack = 1,
        copy = { 11426, 13031, 13032, 13033, 27134, 33405, 43038, 43039 },
    },
    -- Immune to all attacks and spells.  Cannot attack, move or use spells.
    ice_block = {
        id = 45438,
        duration = 10,
        max_stack = 1,
    },
    -- Casting speed of all spells increased by $s1% and reduces pushback suffered by damaging attacks while casting by $s2%.
    icy_veins = {
        id = 12472,
        duration = 20,
        max_stack = 1,
    },
    -- Deals Fire damage every $t1 sec.
    ignite = {
        id = 413841,
        duration = 4,
        tick_time = 2,
        max_stack = 1,
    },
    -- Next Fire Blast stuns the target for $12355d.
    impact = {
        id = 64343,
        duration = 10,
        max_stack = 1,
        copy = { 12355 },

        -- Effects:
        -- Rank 1 #0 -- APPLY_AURA, MOD_STUN, points: 0, target: TARGET_UNIT_TARGET_ENEMY
    },
    -- Chance to be hit by all attacks and spells reduced by $s1%.
    improved_blink = {
        id = 46989,
        duration = 4,
        max_stack = 1,
    },
    -- Spells have a $s1% additional chance to critically hit.
    improved_scorch = {
        id = 22959,
        duration = 30,
        max_stack = 1,
    },
    -- Spell power increased.
    incanters_absorption = {
        id = 44413,
        duration = 10,
        max_stack = 1,
    },
    -- Invisible.
    invisibility = {
        id = 32612,
        duration = 20,
        max_stack = 1,
    },
    -- Fading.
    invisibility_fading = {
        id = 66,
        duration = function() return 3 - talent.prismatic_cloak.rank end,
        tick_time = 1,
        max_stack = 1,
    },
    -- Causes $s1 Fire damage every $t1 sec.  After $d or when the spell is dispelled, the target explodes causing $55362s1 Fire damage to all enemies within $55362a1 yards.
    living_bomb = {
        id = 55360,
        duration = 12,
        tick_time = 3,
        max_stack = 1,
        copy = { 44461, 55361, 55362 },
    },
    -- Resistance to all magic schools increased by $s1 and allows $s2% of your mana regeneration to continue while casting.  Duration of all harmful Magic effects reduced by $s3%.
    mage_armor = {
        id = 43024,
        duration = 1800,
        tick_time = 6,
        max_stack = 1,
        copy = { 6117, 22782, 22783, 27125, 43023, 43024 },
    },
    -- Absorbs damage, draining mana instead.
    mana_shield = {
        id = 43020,
        duration = 60,
        max_stack = 1,
        copy = { 1463, 8494, 8495, 10191, 10192, 10193, 27131, 43019, 43020 },
    },
    -- Copies of the caster that attack on their own.
    mirror_image = {
        id = 55342,
        duration = 30,
        tick_time = 1,
        max_stack = 1,
    },
    -- Reduces the channeled duration of your next Arcane Missiles spell by $/1000;S1 secs, reduces the mana cost by $s3%, and the missiles fire every .5 secs.
    missile_barrage = {
        id = 44401,
        duration = 15,
        max_stack = 1,
    },
    -- Causes $43044s1 Fire damage to attackers.  Chance to receive a critical hit reduced by $s2%.  Critical strike rating increased by $s3% of Spirit.
    molten_armor = {
        id = 43046,
        duration = 1800,
        tick_time = 6,
        max_stack = 1,
        copy = { 34913, 43045, 43046 },
    },
    -- Cannot attack or cast spells.  Increased regeneration.
    polymorph = {
        id = 61780,
        duration = 50,
        max_stack = 1,
        copy = { 118, 12824, 12825, 12826, 28271, 28272, 61025, 61305, 61721, 61780 },
    },
    -- Your next Mage spell with a casting time less than 10 sec will be an instant cast spell.
    presence_of_mind = {
        id = 12043,
        duration = 3600,
        max_stack = 1,
    },
    -- $s2 Fire damage every $t2 seconds.
    pyroblast = {
        id = 42891,
        duration = 12,
        tick_time = 3,
        max_stack = 1,
        copy = { 11366, 12505, 12522, 12523, 12524, 12525, 12526, 18809, 27132, 33938, 42890, 42891 },
    },
    -- Replenishes $s1% of maximum mana per 5 sec.
    replenishment = {
        id = 57669,
        duration = 15,
        max_stack = 1,
        shared = "player",
        dot = "buff",
    },
    -- Frozen in place.
    shattered_barrier = {
        id = 55080,
        duration = 8,
        max_stack = 1,
    },
    -- Silenced.
    silenced_improved_counterspell = {
        id = 55021,
        duration = function() return 2 * talent.improved_counterspell.rank end,
        max_stack = 1,
        copy = { 18469, 55021 },
    },
    -- Movement speed reduced by $s1%.  Time between ranged attacks increased by $s2%.  Casting time increased by $s3%.
    slow = {
        id = 31589,
        duration = 15,
        max_stack = 1,
    },
    -- Slows falling speed.
    slow_fall = {
        id = 130,
        duration = 30,
        max_stack = 1,
    },
    water_elemental = {
        duration = function()
            if glyph.eternal_water.enabled then return 3600 end
            return 45 + ( 5 * talent.enduring_winter.rank )
        end,
        max_stack = 1,
    },
    -- Spells have a $s1% additional chance to critically hit.
    winters_chill = {
        id = 12579,
        duration = 15,
        max_stack = 5,
    },

    -- Aliases
    unique_armor = {
        alias = { "frost_armor", "molten_armor", "mage_armor", "ice_armor" },
        aliasMode = "first",
        aliasType = "buff",
        duration = 3600,
    },
    frozen = {
        alias = { "deep_freeze", "frost_nova", "frostbite", "shattered_barrier" },
        aliasMode = "first",
        aliasType = "debuff",
    }
} )


-- Glyphs
spec:RegisterGlyphs( {
    [63092] = "arcane_barrage",
    [62210] = "arcane_blast",
    [56360] = "arcane_explosion",
    [57924] = "arcane_intellect",
    [56363] = "arcane_missiles",
    [56381] = "arcane_power",
    [62126] = "blast_wave",
    [56365] = "blink",
    [63090] = "deep_freeze",
    [58070] = "drain_soul",
    [70937] = "eternal_water",
    [56380] = "evocation",
    [56369] = "fire_blast",
    [57926] = "fire_ward",
    [56368] = "fireball",
    [57928] = "frost_armor",
    [56376] = "frost_nova",
    [57927] = "frost_ward",
    [56370] = "frostbolt",
    [61205] = "frostfire",
    [56384] = "ice_armor",
    [63095] = "ice_barrier",
    [56372] = "ice_block",
    [56377] = "ice_lance",
    [56374] = "icy_veins",
    [56366] = "invisibility",
    [63091] = "living_bomb",
    [56383] = "mage_armor",
    [56367] = "mana_gem",
    [63093] = "mirror_image",
    [56382] = "molten_armor",
    [56375] = "polymorph",
    [56364] = "remove_curse",
    [56371] = "scorch",
    [57925] = "slow_fall",
    [56373] = "water_elemental",
} )


-- Events that will provoke a 
local AURA_EVENTS = {
    SPELL_AURA_APPLIED      = 1,
    SPELL_AURA_APPLIED_DOSE = 1,
    SPELL_AURA_REFRESH      = 1,
    SPELL_AURA_REMOVED      = 1,
    SPELL_AURA_REMOVED_DOSE = 1,
}

local AURA_REMOVED = {
    SPELL_AURA_REFRESH      = 1,
    SPELL_AURA_REMOVED      = 1,
    SPELL_AURA_REMOVED_DOSE = 1,
}

local FORCED_RESETS = {}

for _, aura in pairs( { "arcane_power", "clearcasting", "fingers_of_frost", "fireball_proc", "firestarter", "hot_streak", "missile_barrage", "presence_of_mind", "deep_freeze", "frost_nova", "frostbite", "shattered_barrier" } ) do
    FORCED_RESETS[ spec.auras[ aura ].id ] = 1
end

local lastFingersConsumed = 0
local lastFrostboltCast = 0

local heating_spells = {
    [42833] = 1,
    [42873] = 1,
    [42859] = 1,
    [55362] = 1,
    [47610] = 1
}
local heatingUp = false

spec:RegisterCombatLogEvent( function( _, subtype, _, sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName, _, ...)
    if not ( sourceGUID == state.GUID or destGUID == state.GUID ) then
        return
    end

	if (sourceGUID == state.GUID) then
        if subtype == 'SPELL_DAMAGE' then
            if state.talent.hot_streak.enabled and heating_spells[spellID] == 1 then
                local critical = select(7, ...)
                if critical then
                    heatingUp = true
                else
                    heatingUp = false
                end
            end
        elseif subtype == 'SPELL_AURA_APPLIED' then
            if state.talent.hot_streak.enabled and spellID == spec.auras.hot_streak.id then
                heatingUp = false
            end
        end
    end

    if AURA_REMOVED[ subtype ] and spellID == spec.auras.fingers_of_frost.id then
        lastFingersConsumed = GetTime()
    end

    if sourceGUID == state.GUID and subtype == "SPELL_CAST_SUCCESS" and spec.abilities[ spellID ] and spec.abilities[ spellID ].key == "frostbolt" then
        lastFrostboltCast = GetTime()
    end
    
    if AURA_EVENTS[ subtype ] and FORCED_RESETS[ spellID ] then
        Hekili:ForceUpdate( "MAGE_AURA_CHANGED", true )
    end
end, false )


local mana_gem_values = {
    [5514] = 390,
    [5513] = 585,
    [8007] = 829,
    [8008] = 1073,
    [22044] = 2340,
    [33312] = 3330
}

spec:RegisterStateExpr( "mana_gem_charges", function() return 0 end )
spec:RegisterStateExpr( "mana_gem_id", function() return 33312 end )

spec:RegisterStateExpr( "frozen", function()
    return buff.fingers_of_frost.up or debuff.frozen.up
end )

spec:RegisterHook( "reset_precast", function()
    mana_gem_charges = nil
    mana_gem_id = nil

    for item in pairs( mana_gem_values ) do
---@diagnostic disable-next-line: deprecated
        count = GetItemCount( item, nil, true )
        if count > 0 then
            mana_gem_charges = count
            mana_gem_id = item
            break
        end
    end

    -- When Frostbolt consumes FoF, we can still make use of that FoF until the Frostbolt impact.

    local frostbolt_remains = action.frostbolt.in_flight_remains
    if frostbolt_remains == 0 and query_time - lastFrostboltCast < 0.2 then
        frostbolt_remains = max( 0, lastFrostboltCast + ( target.distance / action.frostbolt.velocity ) - query_time )
    end

    if lastFingersConsumed == lastFrostboltCast and frostbolt_remains > 0 and frostbolt_remains < cooldown.deep_freeze.remains then
        if buff.fingers_of_frost.up then 
            addStack( "fingers_of_frost" )
        else
            addStack( "fingers_of_frost", frostbolt_remains )
        end
    end

    if heatingUp then
        applyBuff("heating_up")
    end
end )


-- Abilities
spec:RegisterAbilities( {
    -- Amplifies magic used against the targeted party member, increasing damage taken from spells by up to $s1 and healing spells by up to $s2.  Lasts $d.
    amplify_magic = {
        id = 43017,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return 0.270 * ( 1 - 0.01 * talent.precision.rank ) end,
        spendType = "mana",

        startsCombat = false,

        handler = function()
            active_dot.amplify_magic = active_dot.amplify_magic + 1
        end,
        copy = { 1008, 8455, 10169, 10170, 27130, 33946, 43017 },
    },

    -- Launches several missiles at the enemy target, causing $s1 Arcane damage.
    arcane_barrage = {
        id = 44781,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return 0.180 * ( 1 - 0.01 * ( talent.precision.rank + talent.arcane_focus.rank ) ) * ( talent.arcane_barrage.enabled and 0.8 or 1 ) end,
        spendType = "mana",

        startsCombat = true,
        velocity = 24,

        handler = function()
            removeDebuff( "player", "arcane_blast" )
        end,

        impact = function()
        end,
        copy = { 44425, 44780, 44781 },
    },

    -- Blasts the target with energy, dealing $s1 Arcane damage.  Each time you cast Arcane Blast, the damage of all Arcane spells is increased by $36032s1% and mana cost of Arcane Blast is increased by $36032s2%.  Effect stacks up to $36032u times and lasts $36032d or until any Arcane damage spell except Arcane Blast is cast.
    arcane_blast = {
        id = 42897,
        cast = function() return ( buff.presence_of_mind.up or buff.clearcasting.up ) and 0 or 2.5 * haste end,
        cooldown = 0,
        gcd = "spell",

        spend = function() return 0.070 * ( 1 - 0.01 * ( talent.precision.rank + talent.arcane_focus.rank ) ) * ( 1 + ( debuff.arcane_blast.stack * 1.75 ) ) * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,

        handler = function()
            if buff.presence_of_mind.up then removeBuff( "presence_of_mind" )
            elseif buff.clearcasting.up then removeBuff( "clearcasting" ) end

            applyDebuff( "player", "arcane_blast", nil, min( 4, debuff.arcane_blast.stack + 1 ) )
        end,
        copy = { 30451, 42894, 42896, 42897 },
    },

    -- Infuses all party and raid members with brilliance, increasing their Intellect by $s1 for $d.
    arcane_brilliance = {
        id = 43002,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return 0.810 * ( 1 - 0.01 * ( talent.precision.rank + talent.arcane_focus.rank ) ) * ( glyph.arcane_intellect.enabled and 0.5 or 1 ) end,
        spendType = "mana",

        startsCombat = false,
        bagItem = 17020,

        nobuff = "arcane_brilliance",
        handler = function()
            applyBuff( "arcane_brilliance" )
            active_dot.arcane_brilliance = group_members
        end,
        copy = { 23028, 27127, 43002, 61316, "dalaran_brilliance" },
    },

    -- Causes an explosion of arcane magic around the caster, causing $s1 Arcane damage to all targets within $a1 yards.
    arcane_explosion = {
        id = 42921,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return buff.clearcasting.up and 0 or 0.220 * ( 1 - 0.01 * ( talent.precision.rank + talent.arcane_focus.rank ) ) * ( glyph.arcane_explosion.enabled and 0.9 or 1 ) end,
        spendType = "mana",

        startsCombat = true,

        handler = function()
            removeDebuff( "player", "arcane_blast" )
        end,
        copy = { 1449, 8437, 8438, 8439, 10201, 10202, 27080, 27082, 42920, 42921 },
    },

    -- Increases the target's Intellect by $s1 for $d.
    arcane_intellect = {
        id = 42995,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return 0.310 * ( 1 - 0.01 * ( talent.precision.rank + talent.arcane_focus.rank ) ) * ( glyph.arcane_intellect.enabled and 0.5 or 1 ) end,
        spendType = "mana",

        startsCombat = false,

        handler = function()
            applyBuff( "arcane_intellect" )
        end,
        copy = { 1459, 1460, 1461, 10156, 10157, 27126, 42995, 61024, "dalaran_intellect" },
    },

    -- Launches Arcane Missiles at the enemy, causing $7268s1 Arcane damage every $5143t2 sec for $5143d.
    arcane_missiles = {
        id = 42846,
        cast = function()
            local base = level < 16 and 3 or level < 24 and 4 or 5
            return ( buff.missile_barrage.up and 2.5 or base ) * haste
        end,
        channeled = true,
        cooldown = 0,
        gcd = "spell",

        spend = function() return ( buff.clearcasting.up or buff.missile_barrage.up ) and 0 or 0.310 * ( 1 - 0.01 * ( talent.precision.rank + talent.arcane_focus.rank ) ) * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,

        start = function()
            removeDebuff( "player", "arcane_blast" )

            if buff.missile_barrage.up then removeBuff( "missile_barrage" )
            elseif buff.clearcasting.up then removeBuff( "clearcasting" ) end
        end,
        copy = { 5143, 7269, 7270, 8419, 8418, 10273, 10274, 25346, 27076, 38700, 38704, 42844, 42846 },
    },

    -- When activated, your spells deal $s1% more damage while costing $s2% more mana to cast.  This effect lasts $D.
    arcane_power = {
        id = 12042,
        cast = 0,
        cooldown = function() return 120 - ( 15 * talent.arcane_flows.rank ) end,
        gcd = "off",

        toggle = "cooldowns",
        startsCombat = false,

        handler = function()
            applyBuff( "arcane_power" )
        end,
    },

    -- A wave of flame radiates outward from the caster, damaging all enemies caught within the blast for $s1 Fire damage, knocking them back and dazing them for $d.
    blast_wave = {
        id = 42945,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return buff.clearcasting.up and 0 or 0.070 * ( 1 - 0.01 * ( talent.precision.rank + talent.arcane_focus.rank ) ) * ( buff.arcane_power.up and 1.2 or 1 ) * ( glyph.blast_wave.enabled and 0.85 or 1 ) end,
        spendType = "mana",

        startsCombat = true,

        handler = function()
            if target.within10 then
                applyDebuff( "target", "blast_wave" )
            end
        end,
        copy = { 11113, 13018, 13019, 13020, 13021, 27133, 33933, 42944, 42945 },
    },

    -- Teleports the caster $a1 yards forward, unless something is in the way.  Also frees the caster from stuns and bonds.
    blink = {
        id = 1953,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return 0.210 * ( 1 - 0.01 * ( talent.precision.rank + talent.arcane_focus.rank ) ) * ( 1 - 0.25 * talent.improved_blink.rank ) end,
        spendType = "mana",

        startsCombat = false,

        handler = function()
            applyBuff( "blink" )
            setDistance( max( 5, target.distance - ( glyph.blink.enabled and 25 or 20 ) ) )

            if talent.improved_blink.enabled then applyBuff( "improved_blink" ) end
        end,
    },

    -- Ice shards pelt the target area doing ${$42208m1*8*$<mult>} Frost damage over $10d.
    blizzard = {
        id = 42940,
        cast = 8,
        channeled = true,
        cooldown = 0,
        gcd = "spell",

        spend = function() return buff.clearcasting.up and 0 or 0.740 * ( 1 - 0.01 * ( talent.precision.rank + talent.arcane_focus.rank ) ) * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,

        handler = function()
        end,
        copy = { 42208, 42209, 42210, 42211, 42212, 42213, 42198, 42939, 42940 },
    },

    -- When activated, this spell finishes the cooldown on all Frost spells you recently cast.
    cold_snap = {
        id = 11958,
        cast = 0,
        cooldown = function() return 480 * ( 1 - ( 0.1 * talent.cold_as_ice.rank ) ) end,
        gcd = "off",

        startsCombat = false,
        toggle = "cooldowns",

        handler = function()
            setCooldown( "ice_block", 0 )
            setCooldown( "icy_veins", 0 )
            setCooldown( "summon_water_elemental", 0 )
        end,
    },

    -- When activated, this spell increases your critical strike damage bonus with Fire damage spells by $s1%, and causes each of your Fire damage spell hits to increase your critical strike chance with Fire damage spells by $28682s1%.  This effect lasts until you have caused $11129n non-periodic critical strikes with Fire spells.
    combustion = {
        id = 11129,
        cast = 0,
        cooldown = 120,
        gcd = "off",

        startsCombat = false,
        toggle = "cooldowns",

        handler = function()
            applyBuff( "combustion" )
            stat.crit = stat.crit + 10
        end,
    },

    -- Targets in a cone in front of the caster take ${$m2*$<mult>} to ${$M2*$<mult>} Frost damage and are slowed by $s1% for $d.
    cone_of_cold = {
        id = 42931,
        cast = 0,
        cooldown = function() return 10 * ( 1 - min( 0.2, 0.07 * talent.ice_floes.rank ) ) end,
        gcd = "spell",

        spend = function() return buff.clearcasting.up and 0 or 0.250 * ( 1 - 0.01 * ( talent.precision.rank + talent.arcane_focus.rank ) ) * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,

        handler = function()
            if target[ "within" .. ( 10 * ( 1 + 0.1 * talent.arctic_reach.rank ) ) ] then
                applyDebuff( "target", "cone_of_cold" )
            end
        end,
        copy = { 120, 8492, 10159, 10160, 10161, 27087, 42930, 42931 },
    },

    -- Conjures $s1 $lmuffin:muffins;, providing the mage and $ghis:her; allies with something to eat.; Conjured items disappear if logged out for more than 15 minutes.
    conjure_food = {
        id = 33717,
        cast = function() return buff.presence_of_mind.up and 0 or 3 * haste end,
        cooldown = 0,
        gcd = "spell",

        spend = 0.400,
        spendType = "mana",

        startsCombat = false,

        handler = function()
        end,
        copy = { 587, 597, 990, 6129, 10144, 10145, 28612, 33717 },
    },

    -- Conjures a mana agate that can be used to instantly restore $5405s1 mana.
    conjure_mana_gem = {
        id = 42985,
        cast = function() return buff.presence_of_mind.up and 0 or 3 * haste end,
        cooldown = 0,
        gcd = "spell",

        spend = 0.750,
        spendType = "mana",

        startsCombat = false,

        usable = function() return mana_gem_charges < 3, "mana gem is fully charged" end,
        handler = function()
            if level > 77 then mana_gem_id = 33312
            elseif level > 67 then mana_gem_id = 22044
            elseif level > 57 then mana_gem_id = 8008
            elseif level > 47 then mana_gem_id = 8007
            elseif level > 37 then mana_gem_id = 5513
            else mana_gem_id = 5514 end

            mana_gem_charges = 3
        end,
        copy = { 759, 3552, 10053, 10054, 27101, 42985 },
    },

    -- Conjures $s1 Mana Pies providing the mage and $ghis:her; allies with something to eat.; Conjured items disappear if logged out for more than 15 minutes.
    conjure_refreshment = {
        id = 42956,
        cast = function() return buff.presence_of_mind.up and 0 or 3 * haste end,
        cooldown = 0,
        gcd = "spell",

        spend = 0.400,
        spendType = "mana",

        startsCombat = false,

        handler = function()
        end,
        copy = { 42955, 42956 },
    },

    -- Conjures $s1 $lbottle:bottles; of water, providing the mage and $ghis:her; allies with something to drink.; Conjured items disappear if logged out for more than 15 minutes.
    conjure_water = {
        id = 27090,
        cast = function() return buff.presence_of_mind.up and 0 or 3 * haste end,
        cooldown = 0,
        gcd = "spell",

        spend = 0.400,
        spendType = "mana",

        startsCombat = false,

        handler = function()
        end,
        copy = { 5504, 5505, 5506, 6127, 10138, 10139, 10140, 37420, 27090 },
    },

    -- Counters the enemy's spellcast, preventing any spell from that school of magic from being cast for $d.  Generates a high amount of threat.
    counterspell = {
        id = 2139,
        cast = 0,
        cooldown = 24,
        gcd = "none",

        spend = 0.090,
        spendType = "mana",

        startsCombat = true,
        toggle = "interrupts",

        readyTime = state.timeToInterrupt,
        debuff = "casting",

        handler = function()
            interrupt()

            if talent.improved_counterspell.enabled then applyDebuff( "target", "silenced_improved_counterspell" ) end
        end,
    },

    -- Dampens magic used against the targeted party member, decreasing damage taken from spells by up to $s1 and healing spells by up to $s2.  Lasts $d.
    dampen_magic = {
        id = 43015,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.270,
        spendType = "mana",

        startsCombat = false,

        handler = function()
            active_dot.dampen_magic = min( group_members, active_dot.dampen_magic + 1 )
        end,
        copy = { 604, 8450, 8451, 10173, 10174, 33944, 43015 },
    },

    -- Stuns the target for $d.  Only usable on Frozen targets.  Deals ${$71757m1*$<mult>} to ${$71757M1*$<mult>} damage to targets permanently immune to stuns.
    deep_freeze = {
        id = 44572,
        cast = 0,
        cooldown = 30,
        gcd = "spell",

        spend = 0.090,
        spendType = "mana",

        startsCombat = true,

        debuff = function() return buff.fingers_of_frost.down and "frozen" or nil end,
        handler = function()
            removeStack( "fingers_of_frost" )
            applyDebuff( "target", "deep_freeze" )
        end,
    },

    -- Targets in a cone in front of the caster take $s1 Fire damage and are Disoriented and Snared for $d.  Any direct damaging attack will revive targets.  Turns off your attack when used.
    dragons_breath = {
        id = 42950,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return buff.clearcasting.up and 0 or 0.070 * ( 1 - 0.01 * talent.precision.rank ) * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,

        handler = function()
            if target.within10 then
                applyDebuff( "target", "dragons_breath" )
            end
        end,
        copy = { 31661, 33041, 33042, 33043, 42949, 42950 },
    },

    -- While channeling this spell, you gain $o1% of your total mana over $d.
    evocation = {
        id = 12051,
        cast = function() return 8 * haste end,
        channeled = true,
        cooldown = function() return 240 - 60 * talent.arcane_flows.rank end,
        gcd = "spell",

        startsCombat = false,

        start = function()
            applyBuff( "evocation" )
        end,

        tick = function()
            gain( 0.15 * power.max, "mana" )
        end,

        finish = function()
            removeBuff( "evocation" )
        end,

        onBreakChannel = function()
            removeBuff( "evocation" )
        end,
    },

    -- Blasts the enemy for $s1 Fire damage.
    fire_blast = {
        id = 42873,
        cast = 0,
        cooldown = function() return 8 - talent.improved_fire_blast.rank end,
        gcd = "spell",

        spend = function() return buff.clearcasting.up and 0 or 0.210 * ( 1 - 0.01 * talent.precision.rank ) * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,

        handler = function()
        end,
        copy = { 2136, 2137, 2138, 8412, 8413, 10197, 10199, 27078, 27079, 42872, 42873 },
    },

    -- Absorbs $s1 Fire damage.  Lasts $d.
    fire_ward = {
        id = 43010,
        cast = 0,
        cooldown = 30,
        gcd = "spell",

        spend = function() return 0.160 * ( 1 - 0.01 * talent.precision.rank ) end,
        spendType = "mana",

        startsCombat = false,

        handler = function()
            applyBuff( "fire_ward" )
        end,
        copy = { 543, 8457, 8458, 10223, 10225, 27128, 43010 },
    },

    -- Hurls a fiery ball that causes $s1 Fire damage and an additional $o2 Fire damage over $d.
    fireball = {
        id = 42833,
        cast = function()
            if buff.fireball_proc.up or buff.presence_of_mind.up then return 0 end
            local base = level > 23 and 3.5 or level > 17 and 3 or level > 11 and 2.5 or level > 5 and 2 or 1.5
            return ( base - ( glyph.fireball.enabled and 0.15 or 0 ) - 0.1 * talent.improved_fireball.rank ) * haste
        end,
        cooldown = 0,
        gcd = "spell",

        spend = function() return ( buff.clearcasting.up or buff.fireball_proc.up ) and 0 or 0.19 * ( 1 - 0.01 * talent.precision.rank ) * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,
        velocity = 24,

        handler = function()
            if buff.fireball_proc.up then removeBuff( "fireball_proc" )
            elseif buff.clearcasting.up then removeBuff( "clearcasting" )
            elseif buff.presence_of_mind then removeBuff( "presence_of_mind" ) end
        end,

        impact = function()
            if not glyph.fireball.enabled then applyDebuff( "target", "fireball" ) end
        end,
        copy = { 133, 143, 145, 3140, 8400, 8401, 8402, 10148, 10149, 10150, 10151, 25306, 27070, 38692, 42832, 42833 },
    },

    -- Calls down a pillar of fire, burning all enemies within the area for $s1 Fire damage and an additional $o2 Fire damage over $d.
    flamestrike = {
        id = 42926,
        cast = function() return ( buff.firestarter.up or buff.presence_of_mind.up ) and 0 or 2 * haste end,
        cooldown = 0,
        gcd = "spell",

        spend = function() return ( buff.firestarter.up or buff.clearcasting.up ) and 0 or 0.300 * ( 1 - 0.01 * talent.precision.rank ) * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,

        handler = function()
            if buff.firestarter.up then
                removeBuff( "firestarter" )
            else
                if buff.clearcasting.up then removeBuff( "clearcasting" ) end
                if buff.presence_of_mind.up then removeBuff( "presence_of_mind" ) end
            end
        end,
        copy = { 2120, 2121, 8422, 8423, 10215, 10216, 27086, 42925, 42926 },
    },

    -- Increases the target's chance to critically hit with spells by $s1%.  When the target critically hits the caster's chance to critically hit with spells is increased by $54648s1% for $54648d.  Cannot be cast on self.
    focus_magic = {
        id = 54646,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.060,
        spendType = "mana",

        startsCombat = false,

        usable = function() return group, "cannot cast on self" end,
        handler = function()
            active_dot.focus_magic = active_dot.focus_magic + 1
        end,
    },

    -- Increases Armor by $s1.  If an enemy strikes the caster, they may have their movement slowed by $6136s1% and the time between their attacks increased by $6136s2% for $6136d.  Only one type of Armor spell can be active on the Mage at any time.  Lasts $d.
    frost_armor = {
        id = 7301,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return 0.240 * ( 1 - ( 0.01 * talent.precision.rank ) ) * ( 1 - ( talent.frost_channeling.enabled and ( 1 + talent.frost_channeling.rank * 0.03 ) or 0 ) ) end,
        spendType = "mana",

        startsCombat = false,
        essential = true,
        nobuff = "frost_armor",

        handler = function()
            removeBuff( "unique_armor" )
            applyBuff( "frost_armor" )
        end,
        copy = { 168, 7300, 7301 },
    },

    -- Blasts enemies near the caster for ${$m1*$<mult>} to ${$M1*$<mult>} Frost damage and freezes them in place for up to $d.  Damage caused may interrupt the effect.
    frost_nova = {
        id = 42917,
        cast = 0,
        cooldown = function() return 25 * ( 1 - ( min( 0.2, 0.07 * talent.ice_floes.rank ) ) ) end,
        gcd = "spell",

        spend = function() return buff.clearcasting.up and 0 or 0.070 * ( 1 - 0.01 * buff.precision.rank ) * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,

        handler = function()
            if target[ "within" .. ( 10 + target.arctic_reach.rank ) ] then
                applyDebuff( "target", "frost_nova" )
            end
        end,
        copy = { 122, 865, 6131, 10230, 27088, 42917 },
    },

    -- Absorbs $s1 Frost damage.  Lasts $d.
    frost_ward = {
        id = 43012,
        cast = 0,
        cooldown = 30,
        gcd = "spell",

        spend = function() return 0.140 * ( 1 - 0.01 * talent.precision.rank ) end,
        spendType = "mana",

        startsCombat = false,

        handler = function()
            applyBuff( "frost_ward" )
        end,
        copy = { 6143, 8461, 8462, 10177, 28609, 32796, 43012 },
    },

    -- Launches a bolt of frost at the enemy, causing ${$m2*$<mult>} to ${$M2*$<mult>} Frost damage and slowing movement speed by $s1% for $d.
    frostbolt = {
        id = 42842,
        cast = function() return buff.presence_of_mind.up and 0 or 1.5 - ( 0.1 * ( talent.improved_frostbolt.rank + talent.empowered_frostbolt.rank ) ) end,
        cooldown = 0,
        gcd = "spell",

        spend = function() return buff.clearcasting.up and 0 or 0.110 * ( 1 - 0.01 * talent.precision.rank ) * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,
        velocity = 28,

        handler = function()
            if buff.clearcasting.up then removeBuff( "clearcasting" ) end
            if buff.presence_of_mind.up then removeBuff( "presence_of_mind" ) end
        end,

        impact = function()
            if buff.fingers_of_frost.up then removeStack( "fingers_of_frost" ) end
            applyDebuff( "target", "frostbolt" )
        end,
        copy = { 116, 205, 837, 7322, 8406, 8407, 8408, 10179, 10180, 10181, 25304, 27071, 27072, 38697, 42841, 42842 },
    },

    -- Launches a bolt of frostfire at the enemy, causing ${$m2*$<mult>} to ${$M2*$<mult>} Frostfire damage, slowing movement speed by $s1% and causing an additional $o3 Frostfire damage over $d. This spell will be checked against the lower of the target's Frost and Fire resists.
    frostfire_bolt = {
        id = 47610,
        cast = function() return ( buff.fireball_proc.up or buff.presence_of_mind.up ) and 0 or 3 * haste end,
        cooldown = 0,
        gcd = "spell",

        spend = function() return buff.fireball_proc.up and 0 or 0.140 * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,
        velocity = 28,

        handler = function()
            if buff.fireball_proc.up then removeBuff( "fireball_proc" )
            elseif buff.presence_of_mind.up then removeBuff( "presence_of_mind" ) end
            if buff.fingers_of_frost.up then removeStack( "fingers_of_frost" ) end
        end,

        impact = function()
            applyDebuff( "frostfire_bolt" )
        end,
        copy = { 44614, 47610 },
    },

    -- Increases Armor by $s1 and Frost resistance by $s3.   If an enemy strikes the caster, they may have their movement slowed by $7321s1% and the time between their attacks increased by $7321s2% for $7321d.  Only one type of Armor spell can be active on the Mage at any time.  Lasts $d.
    ice_armor = {
        id = 43008,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return 0.240 * ( 1 - 0.01 * talent.precision.rank ) * ( talent.frost_channeling.enabled and ( 0.99 - 0.03 * talent.frost_channeling.rank ) or 1 ) end,
        spendType = "mana",

        startsCombat = false,
        essential = true,
        nobuff = "ice_armor",

        handler = function()
            removeBuff( "unique_armor" )
            applyBuff( "ice_armor" )
        end,
        copy = { 7302, 7320, 10219, 10220, 27124, 43008 },
    },

    -- Instantly shields you, absorbing $s1 damage.  Lasts $d.  While the shield holds, spellcasting will not be delayed by damage.
    ice_barrier = {
        id = 43039,
        cast = 0,
        cooldown = function() return 30 * ( 1 - 0.01 * talent.precision.rank ) * ( 1 - 0.1 * talent.cold_as_ice.rank ) * ( talent.frost_channeling.enabled and ( 0.99 - 0.03 * talent.frost_channeling.rank ) or 1 ) end,
        gcd = "spell",

        spend = 0.210,
        spendType = "mana",

        startsCombat = false,

        handler = function()
            applyBuff( "ice_barrier" )
        end,
        copy = { 11426, 13031, 13032, 13033, 27134, 33405, 43038, 43039 },
    },

    -- You become encased in a block of ice, protecting you from all physical attacks and spells for $d, but during that time you cannot attack, move or cast spells.  Also causes Hypothermia, preventing you from recasting Ice Block for $41425d.
    ice_block = {
        id = 45438,
        cast = 0,
        cooldown = function() return 300 * ( talent.ice_floes.enabled and ( 1 - min( 0.2, 0.07 * talent.ice_floes.rank ) ) or 1 ) end,
        gcd = "spell",

        spend = 15,
        spendType = "mana",

        startsCombat = false,

        nodebuff = "hypothermia",
        handler = function()
            applyBuff( "ice_block" )
            removeDebuff( "player", "hypothermia" )
        end,
    },

    -- Deals ${$m1*$<mult>} to ${$M1*$<mult>} Frost damage to an enemy target.  Causes triple damage against Frozen targets.
    ice_lance = {
        id = 42914,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return buff.clearcasting.up and 0 or 0.060 * ( 1 - 0.01 * talent.precision.rank ) * ( buff.arcane_power.up and 1.2 or 1 ) * ( talent.frost_channeling.enabled and ( 0.99 - 0.03 * talent.frost_channeling.rank ) or 1 ) end,
        spendType = "mana",

        startsCombat = true,
        velocity = 38,

        handler = function()
        end,

        impact = function()
            if buff.fingers_of_frost.up then removeBuff( "fingers_of_frost" )
            elseif debuff.frost_nova.up then removeDebuff( "target", "frost_nova" )
            elseif debuff.frostbite.up then removeDebuff( "target", "frostbite" ) end
        end,
        copy = { 30455, 42913, 42914 },
    },

    -- Hastens your spellcasting, increasing spell casting speed by $s1% and reduces the pushback suffered from damaging attacks while casting by $s2%.  Lasts $d.
    icy_veins = {
        id = 12472,
        cast = 0,
        cooldown = function() return 180 * ( talent.ice_floes.enabled and ( 1 - min( 0.2, 0.07 * talent.ice_floes.rank ) ) or 1 ) end,
        gcd = "off",

        spend = 0.030,
        spendType = "mana",

        startsCombat = false,
        toggle = "cooldowns",

        handler = function()
            applyBuff( "icy_veins" )
            stat.haste = stat.haste + 20
        end,
    },

    -- $?s54354[Instantly makes the caster invisible, reducing all threat.][Fades the caster to invisibility over $66d, reducing threat each second.]  The effect is cancelled if you perform any actions.  While invisible, you can only see other invisible targets and those who can see invisible.  Lasts $32612d.
    invisibility = {
        id = 66,
        cast = 0,
        cooldown = function() return 180 * ( 1 - 0.15 * talent.arcane_flows.rank ) end,
        gcd = "spell",

        spend = 0.160,
        spendType = "mana",

        startsCombat = false,
        toggle = "defensives",

        handler = function()
            if talent.prismatic_cloak.rank == 3 then
                applyBuff( "invisibility" )
            else
                applyBuff( "invisibility_fading" )
                applyBuff( "invisibility" )
                buff.invisibility.applied = buff.invisibility_fading.expires
            end
        end,
    },

    -- The target becomes a Living Bomb, taking $o1 Fire damage over $d.  After $d or when the spell is dispelled, the target explodes dealing $44461s1 Fire damage to all enemies within $44461a1 yards.
    living_bomb = {
        id = 55362,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.220,
        spendType = "mana",

        startsCombat = true,

        handler = function()
            applyDebuff( "target", "living_bomb" )
        end,
        copy = { 44461, 55361, 55362 },
    },

    -- Increases your resistance to all magic by $s1 and allows $s2% of your mana regeneration to continue while casting.  Only one type of Armor spell can be active on the Mage at any time.  Lasts $d.
    mage_armor = {
        id = 43024,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.260,
        spendType = "mana",

        startsCombat = false,

        nobuff = "mage_armor",
        handler = function()
            removeBuff( "unique_armor" )
            applyBuff( "mage_armor" )
        end,
        copy = { 6117, 22782, 22783, 27125, 43023, 43024 },
    },

    -- Absorbs $s1 damage, draining mana instead.  Drains $e mana per damage absorbed.  Lasts $d.
    mana_shield = {
        id = 43020,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.070,
        spendType = "mana",

        startsCombat = false,

        handler = function()
            applyBuff( "mana_shield" )
        end,
        copy = { 1463, 8494, 8495, 10191, 10192, 10193, 27131, 43019, 43020 },
    },

    -- Creates $<images> copies of the caster nearby, which cast spells and attack the mage's enemies.  Lasts $55342d.
    mirror_image = {
        id = 55342,
        cast = 0,
        cooldown = 180,
        gcd = "spell",

        spend = 0.100,
        spendType = "mana",

        startsCombat = false,
        toggle = "cooldowns",

        handler = function()
            applyBuff( "mirror_image" )
        end,
    },

    -- Causes $34913s1 Fire damage when hit, increases your critical strike rating by $30482s3% of your Spirit, and reduces the chance you are critically hit by $30482s2%.  Only one type of Armor spell can be active on the Mage at any time.  Lasts $30482d.
    molten_armor = {
        id = 43046,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return 0.280 * ( 1 - 0.01 * talent.precision.rank ) end,
        spendType = "mana",

        startsCombat = false,
        essential = true,
        nobuff = "molten_armor",

        handler = function()
            removeBuff( "unique_armor" )
            applyBuff( "molten_armor" )
        end,
        copy = { 34913, 43045, 43046 },
    },

    -- Transforms the enemy into a sheep, forcing it to wander around for up to $d.  While wandering, the sheep cannot attack or cast spells but will regenerate very quickly.  Any damage will transform the target back into its normal form.  Only one target can be polymorphed at a time.  Only works on Beasts, Humanoids and Critters.
    polymorph = {
        id = 12826,
        cast = function() return buff.presence_of_mind.up and 0 or 1.5 * haste end,
        cooldown = 0,
        gcd = "spell",

        spend = function() return 0.070 * ( 1 - 0.01 * talent.arcane_focus.rank ) end,
        spendType = "mana",

        startsCombat = true,

        handler = function()
            if buff.presence_of_mind.up then removeBuff( "presence_of_mind" ) end

            active_dot.polymorph = 0
            applyDebuff( "target", "polymorph" )
        end,
        copy = { 118, 12824, 12825, 12826, 28271, 28272, 61025, 61305, 61721, 61780 },
    },

    -- When activated, your next Mage spell with a casting time less than 10 sec becomes an instant cast spell.
    presence_of_mind = {
        id = 12043,
        cast = 0,
        cooldown = function() return 120 - ( 1 - 0.15 * talent.arcane_flows.rank ) end,
        gcd = "off",

        startsCombat = false,
        toggle = "cooldowns",

        handler = function()
            applyBuff( "presence_of_mind" )
        end,
    },

    -- Hurls an immense fiery boulder that causes $s1 Fire damage and an additional $o2 Fire damage over $d.
    pyroblast = {
        id = 42891,
        cast = function() return buff.presence_of_mind.up and 0 or 5 - ( talent.fiery_payback.enabled and health.pct < 35 and ( 1.75 * buff.fiery_payback.rank ) or 0 ) end,
        cooldown = function() return ( talent.fiery_payback.enabled and health.pct < 35 and ( 2.5 * buff.fiery_payback.rank ) or 0 ) end,
        gcd = "spell",

        spend = function() return ( buff.clearcasting.up or buff.hot_streak.up ) and 0 or 0.220 * ( 1 - 0.01 * talent.precision.rank ) * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,
        velocity = 24,

        handler = function()
            if buff.clearcasting.up then removeBuff( "clearcasting" )
            elseif buff.hot_streak.up then removeBuff( "hot_streak" ) end
            if buff.presence_of_mind.up then removeBuff( "presence_of_mind" ) end
        end,

        impact = function()
            applyDebuff( "target", "pyroblast" )
        end,
        copy = { 11366, 12505, 12522, 12523, 12524, 12525, 12526, 18809, 27132, 33938, 42890, 42891 },
    },

    -- Removes $m1 Curse from a friendly target.
    remove_curse = {
        id = 475,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function() return 0.080 * ( 1 - 0.01 * talent.arcane_focus.rank ) end,
        spendType = "mana",

        startsCombat = false,

        buff = "dispellable_curse",
        handler = function()
            removeBuff( "dispellable_curse" )
        end,
    },

    -- TODO: Replace with Use Mana Gem.
    -- Restores $s1 mana.
    replenish_mana = {
        id = 42987,
        name = "|cff00ccff[Mana Gem]|r",
        link = "|cff00ccff[Mana Gem]|r",
        known = function()
            return state.mana_gem_charges > 0
        end,
        cast = 0,
        cooldown = 120,
        gcd = "off",

        startsCombat = false,

        item = function() return state.mana_gem_id or 36799 end,
        bagItem = true,
---@diagnostic disable-next-line: deprecated
        texture = function() return GetItemIcon( state.mana_gem_id or 36799 ) end,

        usable = function ()
            return mana_gem_charges > 0, "requires mana_gem in bags"
        end,

        readyTime = function ()
---@diagnostic disable-next-line: deprecated
            local start, duration = GetItemCooldown( state.mana_gem_id )
            return max( 0, start + duration - query_time )
        end,

        handler = function()
            gain( mana_gem_values[ state.mana_gem_id ] * ( glyph.mana_gem.enabled and 1.4 or 1 ), "mana" )
            mana_gem_charges = mana_gem_charges - 1
        end,
        copy = { 5405, 10052, 10057, 10058, 27103, 42987, "mana_gem", "use_mana_gem" },
    },

    -- Scorch the enemy for $s1 Fire damage.
    scorch = {
        id = 42859,
        cast = function() return buff.presence_of_mind.up and 0 or 1.5 * haste end,
        cooldown = 0,
        gcd = "spell",

        spend = function() return buff.clearcasting.up and 0 or 0.080 * ( 1 - 0.01 * talent.precision.rank ) * ( buff.arcane_power.up and 1.2 or 1 ) end,
        spendType = "mana",

        startsCombat = true,

        handler = function()
            if talent.improved_scorch.rank == 3 then
                applyDebuff( "target", "improved_scorch" )
            end
        end,
        copy = { 2948, 8444, 8445, 8446, 10205, 10206, 10207, 27073, 27074, 42858, 42859 },
    },

    -- Reduces target's movement speed by $s1%, increases the time between ranged attacks by $s2% and increases casting time by $s3%.  Lasts $d.  Slow can only affect one target at a time.
    slow = {
        id = 31589,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.120,
        spendType = "mana",

        startsCombat = true,

        handler = function()
            applyDebuff( "target", "slow" )
        end,
    },

    -- Slows friendly party or raid target's falling speed for $d.
    slow_fall = {
        id = 130,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.060,
        spendType = "mana",

        startsCombat = false,
        bagItem = function()
            if glyph.slow_fall.enabled then return end
            return 17056
        end,

        handler = function()
            applyBuff( "slow_fall" )
        end,
    },

    -- Steals a beneficial magic effect from the target.  This effect lasts a maximum of 2 min.
    spellsteal = {
        id = 30449,
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = 0.200,
        spendType = "mana",

        startsCombat = true,

        debuff = "stealable_magic",
        handler = function()
            removeDebuff( "target", "stealable_magic" )
        end,
    },

    -- Summon a Water Elemental to fight for the caster$?(s70937)[][ for $70907d].
    summon_water_elemental = {
        id = 31687,
        cast = 0,
        cooldown = function() return ( glyph.water_elemental.enabled and 150 or 180 ) * ( 1 - 0.1 * talent.cold_as_ice.rank ) end,
        gcd = "spell",

        spend = function() return 0.160 * ( talent.frost_channeling.enabled and ( 0.99 - 0.03 * talent.frost_channeling.rank ) or 1 ) end,
        spendType = "mana",

        startsCombat = false,

        handler = function()
            summonPet( "water_elemental", spec.auras.water_elemental.duration )
            applyBuff( "water_elemental" )
        end,
    }
} )


spec:RegisterOptions( {
    enabled = true,

    aoe = 3,

    gcd = 1459,

    nameplates = true,
    nameplateRange = 8,

    damage = false,
    damageExpiration = 6,

    potion = "speed",
} )

spec:RegisterSetting( "spellsteal_cooldown", 0, {
    type = "range",
    name = strformat( CAPACITANCE_SHIPMENT_COOLDOWN, Hekili:GetSpellLinkWithTexture( spec.abilities.spellsteal.id ) ),
    desc = strformat( "如果设置大于0，%s 的推荐频率将不会超过指定的时间范围（以秒为单位）。\n\n"
        .. "此设置可在敌人拥有叠加 BUFF 或多个 BUFF 时防止 %s 总是成为第一推荐。",
        Hekili:GetSpellLinkWithTexture( spec.abilities.spellsteal.id ), spec.abilities.spellsteal.name ),
    width = "full",
    min = 0,
    max = 15,
    step = 0.1
} )

spec:RegisterStateExpr( "spellsteal_cooldown", function()
    return settings.spellsteal_cooldown or 0
end )


spec:RegisterSetting( "living_bomb_cap", 3, {
    type = "range",
    name = strformat( SPELL_MAX_CHARGES:gsub( "%%d", "%%s"), Hekili:GetSpellLinkWithTexture( spec.abilities.living_bomb.id ) ),
    desc = strformat( "启用目标切换后，可在指定数量的目标上推荐 %s。\n\n"
        .. "该设置有助于平衡法力消耗与多目标伤害。",
        Hekili:GetSpellLinkWithTexture( spec.abilities.living_bomb.id ) ),
    width = "full",
    min = 1,
    max = 10,
    step = 1
} )

spec:RegisterStateExpr( "living_bomb_cap", function()
    return settings.living_bomb_cap or 3
end )


spec:RegisterSetting( "use_cold_snap", false, {
    type = "toggle",
    name = strformat( "%s %s", USE, Hekili:GetSpellLinkWithTexture( spec.abilities.cold_snap.id ) ),
    desc = strformat( "如果启用，默认冰霜优先级 %s 可能会建议重置 %s 的冷却时间。",
        Hekili:GetSpellLinkWithTexture( spec.abilities.cold_snap.id ),
        Hekili:GetSpellLinkWithTexture( spec.abilities.icy_veins.id ) ),
} )

spec:RegisterStateExpr( "use_cold_snap", function()
    return settings.use_cold_snap
end )


spec:RegisterPackSelector( "arcane", "Arcane Wowhead", "|T135932:0|t 奥术",
    "如果你在|T135932:0|t奥术天赋中投入的点数多于其他天赋，将会为你自动选择该优先级。",
    function( tab1, tab2, tab3 )
        return tab1 > max( tab2, tab3 )
    end )

spec:RegisterPackSelector( "fire", "Fire Wowhead", "|T135810:0|t 火焰",
    "如果你在|T135810:0|t火焰天赋中投入的点数多于其他天赋，将会为你自动选择该优先级。",
    function( tab1, tab2, tab3 )
        return tab2 > max( tab1, tab3 )
    end )

spec:RegisterPackSelector( "frost", "Frost Wowhead", "|T135846:0|t 冰霜",
    "如果你在|T135846:0|t冰霜天赋中投入的点数多于其他天赋，将会为你自动选择该优先级。",
    function( tab1, tab2, tab3 )
        return tab3 > max( tab1, tab2 )
    end )

spec:RegisterPack( "奥术 Wowhead", 20230924, [[Hekili:9EvBVTTnq4FlffWjfRw2X5TLIMc01bSLGTGH5o09jjrjF2MiuKAKu2nfb63(UJ6Lqjl7g0c0Vyjt(W7nE39Ck8KWpgoFbZcH3nB6StNE1SZdMoD6StonCU9HCiCEol9E2k8fjld)996uMekJ)KA7AGTG2)bHcFbLJrvOtrmRT2CZBMmz72TbBRWfKQYMSvzf3pzvbFbmjvWmgWmjdL9eMtOtwKBgRvwMLRKJtvkXc1wPzmlHl4woygNVbLEsbxyVrgMmSHplCoRWUwPdN)7W94jr7HVybuDaWKgoNoW4PxnE2zVPm(gjkBMOm2QzsJWP8Y4LAvwRtgeoxWnwd5JmfGpUZf3ajlralc)LW5PAUf0Cgg1y6vGnyl3UMlpzkEIusK4tNtgbFoxOm0kw00DISgqUgmGmfIulJY4Yf(kaXEQp2eb)lFHP7J5mFmlf4nMXQ53dDHzPaXswHW26knNjvvirhXKdcrpz3XwDamwG1hvhRudzQnquAH2adzP7jakaPnGlXWfzkrSeJsNtsmO(aLXJkJtkwUCyuuAJdsLDeSsOsyIi7AqNHpnS8CqhLUMUPc04f8dEbnUgI2srw0ip)hHr6G0Q2GI8NmMdz4K9DrN0hv1ZoH5l9ruNbMR2c6E4(zFC80hI2aCPPhOR8bLX1ALoIN5Ao0bhM13nUrLDAEE1b)hd2(GjFGQ44Y7bRbFBnZIlQb5r4tf5WB5eomplLVKdunyJMlmqeEpKzC6A)vIeEm7dKqg28Om(DLXZ8Y0zcru1FIOQ7QA8OQUCuvoj8z7v4la39wDinb7MzdmwSxzz81LXN5UzpU(YnJBmCbIIP1y0cVIlJF8XYySGFt0Q0fbx0roLXVAN7SAru5YN(DzvdAsTzJyblxUAh9xJZP(ZgiNYPQ(Pb7V8jJjzb5POR(2Y4lN63XihlS4M1reeNuU45jf)wTWgvQRrEvZomoJ0pjm7qDU77iAUqWzsIhRtA7CihZ5sanMfH8h(2HMX9Q23rqUGBBh0b9Kxug)CeYo7ZX2kcbKAR0rFNPD7D6mtvTrmDMs3NAaJxBWwveQgMv0zXwtsmVa7i8P3)33DZD)gYCwg)X1yjkplxPX7GLkm0CunXYrOdb)xb2vdDkJkJk5lSQmKWgxa7GjxbMGYB)donmbXd)bLe1RB7JQ7U(VOuSkV)30Afx)4t(8RAp)5FZNV82BCMpDStBimkJD0942uUJAjwOeo)LLX)jg0qnvpc0T4k(t6GDnh76A(0SoJDt5WtRhWzmf1htt5GdYCWjDCcVxghzSVex(VAYMlVTYCnbTj4)01t2jZ518LxtjxJouI1HevBwejPx81e1O9NFoSwEkvSXd)1QCOw4ii)5s8x)P5q8x1FUJkr(HMySpSwsxYXoaJ(OdZIp6zpMHVYpe6Vt7zNjk81B1yc(R4pwG)6TJb4VOpTVll9BKo3xMTe6DUX7Xp)AIz(AKyMcoDP2F3SbCNggtc(EPfV(SrhVhk6hFCp0ZVAaLvFSVMU2l17OkA3HKSBIGo52(mKKgBObF7Lt9b2sc2bZjtPQSM6qmC(KQA)YKQ0VoFgt)J0)Bv6VFZ3N0F9oFtcLnqJEsKoH))]] )
spec:RegisterPack( "火焰 Wowhead", 20230925, [[Hekili:DAvxVTTnu0FlffW5HflBR20LuahG9b2wc2cgIBrFtsuuuweMIuLKkAUpOF77EPSKPKTZkgcqSn5LhE)4CVhgTk6trBYiww0tHldF3Y7cVjy5T3egUkAJDFflAtfHUJSf(IKuc))34AwBYxunfmsgU7EHc(cGIrvRPGffwBL5Jlw000e00zxavvUOrzf7wSTMNXwqfeJHzwuciVihGCrwLzUwzjwUsoNQuImvJ0mNKYfClNzMx9cGDAnxyFqgLEwNE1DGxuXOrpDl4g8SmwNLmdnAdA58L3np8Mp2M8GeaLiAtSAI0iC3ABsUwvoeBbrBeCJ1GHgrXGpEYLSyssQGLf9ZrBOAULP5eivr0Bz2GgUTGlxTeobfHeCyiqTXneW5TG3obGERYfqU1y18DmFutRZZdWSJbWhwlOUcDkjlMcP(BreF33PlfE8YY0KTkPjovZi2ceK37IXbpM)TVr0z(WAH)G0yoPwyhse9hGQQLWDcjEHy8HUy86S1yzeHx8CCX4(6)qe2FWsUwR0X8shJC0D9(X(uzATP77JS6gFR409XVW4sZeJ(GVrUAtmLunXOF03Ok1zURBNe9ipuZR6S8ZgOnIi3JuqUChZAGVvqSWIAM8k4tLTGPB4ODiPMNZziPS)kRnSyOwxAWR6UlKOf8x4YTXPq6ask7PcwChVWGfXnLK)jE8Q(NOlOpHrz5q(WQIZ4GNDFBYQW2KzTjzmhD178bUs44W(z22Abr3M88HED07HgMlXIXa5fwmtYkHHaU7ZJktjcrC3pIXM1Uw24Ujvytlc(L7ADoCHYgdTEmYUa4FuRxrDVw56FDWmLlFeMsfgYEmgOJn(4bVCl6wX(QIayQJXINjO3OJi1VfKpfDOnIMJBLsM22bHqLMHTae75gB1FAIMsGEVunxi4ejo7EuTAdRc4xPmOAHdp99CnHN5Q6Uu4jaf038E5K2BAt(Ea5K95WSgHGrThyxtcMHTF9HJoeRL8VwZIj6sLEcALq6Mj72Ay4Y5RHAvDLZlpqvZu2GCfT2eddP402K1TjEccEB5kvqX6fy4jU3Gyw0MgIwcCkOF8l)0Zp9Wt)oOz1M8PcOJJxwP0W4HCfuxU6Wq5RGSj7R1aDaYOgvjoBP2QkbnsybAbrULzcAF8pHHTTjFaq7ZstDfIeAqNZbWnmS7kW42hFOS3I3D0iNQiSnet12ci)S5py7avAK1PY5cGg922K)cMqdxJ75cpc)2)vbWC35U5UhFxWC3lc4u3JbMJJ3NJViae9F1xf4GEcpfD83cl)399aTp256MGH2IFy9It4BxZZxJuYzVgD81GAG7Hi9M)lOMDzw95VfFojEdNNdF(Z6X6WJ6iTZopHD9Y(e4V2XTgqeWXxR3F9JA3xFqpF9zKZ7G9x6lJ(a4lSp(c7fY9xDq42FXbUR)IDcZoAY)tfxF0g0CDaEIwMVPE6GxpsID9QRpr2D9evxSgDQA79RcNDbv2rPSjIIxJYHRb1qe1X6P3hokx1R3nWUMQnokDpOYHM3PboA)rAxow35L7MckkOHuWEEm45WohFiTxYP)92tn2790d8XBhIQXVOE6zh)84tVSWt9SdpyghMh9V]] )
spec:RegisterPack( "冰霜 Wowhead", 20230930, [[Hekili:fJ1FpsTnq0plOkT3Du2S)4G7a0DivkQTGApv1qf9VsI3Kj76Eo2bBNBzpDkF27yNnjoztwOuHQqcYAp(nppEM5ztWIG3h4Nq0qWnlNV885V485ElE6Y5p95b(6D5qGFoj(wYA8dojd)7Fsku6YOpi2UbijMP3Xe4himkrHmgnzJwNRE5SzB3U1BBLDEXISzBfA2TZwxqtGzXmIsbQzzi0Zsnyoljxnvk0envWNgleSeXwUAkzfLr1uqnn)oe8vfuM(T8Gvdt7lrAKdXb3G8FdnjbQSeuXb()g6RxwgvTdENllPX7MEhq5QwEo1YqACf5MA45uddrsCuww(oFixdzRazzKHByisksPmK7FxzuxoGd8nJgi29ys57WrXH)DjG4VIGeGeBaq5Lxp03F9mImMWHWvskJrj8y4j00RLeAYKvfPPEhmTNX1hfkkxdmgeRni9OphuDMRzPhXlXc(FxiHWmcNeUgYmEP(7W4ne5AqD1YHxBMGPbEirMjKM1z9DbN(XcOAWJ4xvrwMGhUftdLHadYaUMWS7XCq7zwYDWK1SD5B8a0goHvzShWjRyqYWWMkIlu4Mznn2G1APOiFsfyHjcTNZ8xpFyiY3jfRWehBaFLqPQp6FdKskyTh82OxbgJLyvdJ5oUDaLgWDeJINeXjx3ouyDkxfS)yDcOlazuPuidPMC2oapEy7ljwHiG1jH26e3b3NWKl2I57oJNYW(wHXKC3bZfMVEsHccfPPHRXn3IUbfwsOItYn0YyvZavzNnmOkJToA4mUeYi4)(QlMBlf)tfugr47kJ0sk)wqRWV2GLGrejWpb)xHEdi3sn2z6GrtPqINlNm0GI1ZQwaFda5MMjaCp(lTOmcRfW4l(JDyZ4YitoaAaLVgpHrFKw36jQQUa9fndtiWiNOqXq6TLQ3GKAVDRWYdCzY9)mLkXL8ACWomlbPryQLfM41PjGniHTSUh4Ef5p8q1VRObgXdTDZ8uAuB56fNn50kS8sRDsOXXEuEykJUEJ(HhCnO7CN15WUE(MA5dCkwmHPByoNNdTBpbDgS(m8QymkgQPzWJpY(4aA0SpA4YkS1hVfC0E3fTIrV)EImXy((YDGdzyZ8xTCYJYe3HUTBok3K9AtnhCnAZjS2ZCIs5lMp5qi2xZaFkNjuMcIVoyQ2P19BQMV7YwoVZofW4PTd9NRo0mrtB9owv3K3lpwF1LDGhUteBfg7yZ5ZhmrjW)o8SehT9Meb(BjsoUhub(F4h(JBE7n)mkzxg9(nyYpnlxiXAIutrXjjv9tpPmscFSaddjyfLWu)rk0ImSbwITudtyuyjZVInslJwS8LMwMC0X25pzF(4FDsvnCZVR79HJF6IpDMNPl(BT(3SSLOtS7hSmNQ0g8d8r3Urid8)f4w8Mab(2zS3XRIP4N3yVZx1sd8DB)h4V3HbVoqJXdJDTJ0SKwzad(wPb3bB0gmyCURVCve65RN2ZxXsSvNKsc8Fuz0rKfCy1GYkgSFMlhA6q3Jax4AKRwsp7U01UgTLEg9CJroPRMyEZIQY57TIxm6(VJ6tz0KYObuGSJpUkuz0RkJUyU7P(Ean(EX8Eo3CDzjnVY0VsLRwF1OBz91IrsQC67oeb(FuPZ9W40YO(IBLrp8W(ZKregIUgR5lJoZEiDADv7OIDvaoUGhIKns2V8SLLJj8zjWHIFnxXQts0acHLrxHgulgwg94JUVDktAA2A495hN3hks2dOMqMfTXBC0viZwcS0UfXokvAuTaxR9AH8z)7HSNgPDS((WvV26Nl(24N(I6wFD5O(AVC(bOV0PDrRaVfSJ2ERV4EVgDlgVtxTuTnn7sh3lHCmNLQ2yX9axBKQ63cBeup3b1MRjybOJOOZTdCjV28w(9VYQriDGEzh8U2ED0o4)HGw2AECCBt(HFG8qAZD0l)sa5G57(s7d2mnt3OQpA029D32O(YofbDER(X1(h(14oxOW517nk9JfvAFtUDV)F8sfJx8AFWU1f7lJ79ODREGBXv7unxWy4Ob(qENRru)g)G2)e8pd]] )
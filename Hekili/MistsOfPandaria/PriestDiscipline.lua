-- PriestDiscipline.lua
-- Updated May 28, 2025 - Modern Structure
-- Mists of Pandaria module for Priest: Discipline spec

-- MoP: Use UnitClass instead of UnitClassBase
local _, playerClass = UnitClass('player')
if playerClass ~= 'PRIEST' then return end

local addon, ns = ...
local Hekili = _G[ "Hekili" ]
local class = Hekili.Class
local state = Hekili.State

local function getReferences()
    -- Legacy function for compatibility
    return class, state
end

local spec = Hekili:NewSpecialization( 256 ) -- Discipline spec ID for MoP

local strformat = string.format
local FindUnitBuffByID, FindUnitDebuffByID = ns.FindUnitBuffByID, ns.FindUnitDebuffByID

-- Enhanced helper functions for Discipline Priest
local function UA_GetPlayerAuraBySpellID(spellID)
    return FindUnitBuffByID("player", spellID)
end

local function GetTargetDebuffByID(spellID)
    return FindUnitDebuffByID("target", spellID, "PLAYER")
end

-- Discipline-specific combat log event tracking
local discCombatLogFrame = CreateFrame("Frame")
local discCombatLogEvents = {}

local function RegisterDISCCombatLogEvent(event, handler)
    if not discCombatLogEvents[event] then
        discCombatLogEvents[event] = {}
    end
    table.insert(discCombatLogEvents[event], handler)
end

discCombatLogFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo()
        
        if sourceGUID == UnitGUID("player") then
            local handlers = discCombatLogEvents[subevent]
            if handlers then
                for _, handler in ipairs(handlers) do
                    handler(timestamp, subevent, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, select(12, CombatLogGetCurrentEventInfo()))
                end
            end
        end
    end
end)

discCombatLogFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- Power Word: Shield absorption tracking for Rapture
RegisterDISCCombatLogEvent("SPELL_ABSORBED", function(timestamp, subevent, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, amount)
    if spellID == 17 then -- Power Word: Shield absorption
        -- Track shield absorption for Rapture mana return
    end
end)

-- Evangelism stack tracking from damage spells
RegisterDISCCombatLogEvent("SPELL_DAMAGE", function(timestamp, subevent, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool)
    if spellID == 585 or spellID == 14914 or spellID == 47540 then -- Smite, Holy Fire, Penance
        -- Track damage for Evangelism stack building
    end
end)

-- Grace stack tracking from direct heals
RegisterDISCCombatLogEvent("SPELL_HEAL", function(timestamp, subevent, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool)
    if spellID == 2050 or spellID == 2061 or spellID == 2060 then -- Heal, Flash Heal, Greater Heal
        -- Track healing for Grace stack application
    end
end)

-- Atonement healing tracking from damage
RegisterDISCCombatLogEvent("SPELL_HEAL", function(timestamp, subevent, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool)
    if spellID == 94472 then -- Atonement healing
        -- Track Atonement healing efficiency
    end
end)

-- Divine Insight proc tracking (if talented)
RegisterDISCCombatLogEvent("SPELL_AURA_APPLIED", function(timestamp, subevent, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool)
    if spellID == 109175 then -- Divine Insight
        -- Track Divine Insight procs for free Prayer of Healing
    end
end)

-- Enhanced Mana resource system for Discipline Priest
spec:RegisterResource( 0, { -- Mana = 0 in MoP
    -- Meditation (Spirit-based mana regeneration)
    meditation = {
        last = function ()
            local app = state.combat and state.combat or 0
            local t = state.query_time
            return app + floor( ( t - app ) / 2 ) * 2
        end,
        interval = 2,
        value = function ()
            local spirit = GetSpellBonusHealing() * 0.5 -- Approximate spirit from spell power
            local base_regen = spirit * 0.016 -- 1.6% of spirit per tick
            local meditation_bonus = 0.5 -- 50% regen in combat from Meditation
            return base_regen * (state.combat and meditation_bonus or 1)
        end,
    },
    
    -- Rapture (mana return from shield absorption)
    rapture = {
        aura = "rapture_ready",
        last = function ()
            local app = state.buff.rapture_ready.applied
            local t = state.query_time
            return app
        end,        interval = 12, -- Rapture internal cooldown
        value = function ()
            local max_mana = UnitPowerMax("player", 0) -- Mana = 0 in MoP
            return max_mana * 0.07 -- 7% of maximum mana
        end,
    },
    
    -- Mindbender mana return (if talented)
    mindbender = {
        aura = "mindbender",
        last = function ()
            local app = state.buff.mindbender.applied
            local t = state.query_time
            return app + floor( ( t - app ) / 1.5 ) * 1.5
        end,
        interval = 1.5,        value = function ()
            if state.talent.mindbender.enabled then
                local max_mana = UnitPowerMax("player", 0) -- Mana = 0 in MoP
                return max_mana * 0.04 -- 4% of maximum mana per hit
            end
            return 0
        end,
    },
    
    -- Shadowfiend mana return (baseline)
    shadowfiend = {
        aura = "shadowfiend",
        last = function ()
            local app = state.buff.shadowfiend.applied
            local t = state.query_time
            return app + floor( ( t - app ) / 1.5 ) * 1.5
        end,
        interval = 1.5,        value = function ()
            local max_mana = UnitPowerMax("player", 0) -- Mana = 0 in MoP
            return max_mana * 0.03 -- 3% of maximum mana per hit
        end,
    },
    
    -- Archangel mana efficiency (when talented and active)
    archangel_efficiency = {
        aura = "archangel",
        last = function () return state.buff.archangel.applied end,
        interval = 1,
        value = function ()
            if state.buff.archangel.up then
                local stacks = state.buff.archangel.stack
                return stacks * 0.5 -- 0.5% mana efficiency per stack
            end
            return 0
        end,
    },
}, {
    -- Base mana regeneration with Inner Fire and other modifiers
    base_regen = function ()
        local base = 1
        if state.buff.inner_fire.up then base = base * 1.1 end -- 10% bonus from Inner Fire
        return base
    end,
} )

-- Comprehensive Tier Set Registration
-- ========================================

-- Tier 14 (Heart of Fear/Terrace of Endless Spring) - Vestments of the Shared Light
spec:RegisterGear( "tier14", 85316, 85317, 85318, 85319, 85320 ) -- Normal
spec:RegisterGear( "tier14_lfr", 86672, 86673, 86674, 86675, 86676 ) -- LFR
spec:RegisterGear( "tier14_heroic", 87159, 87160, 87161, 87162, 87163 ) -- Heroic

-- Tier 15 (Throne of Thunder) - Rainment of the Exorcist
spec:RegisterGear( "tier15", 95298, 95299, 95300, 95301, 95302 ) -- Normal
spec:RegisterGear( "tier15_lfr", 96631, 96632, 96633, 96634, 96635 ) -- LFR  
spec:RegisterGear( "tier15_heroic", 96378, 96379, 96380, 96381, 96382 ) -- Heroic
spec:RegisterGear( "tier15_thunderforged", 97015, 97016, 97017, 97018, 97019 ) -- Thunderforged

-- Tier 16 (Siege of Orgrimmar) - Vestments of the Eternal Blossom
spec:RegisterGear( "tier16", 99363, 99364, 99365, 99366, 99367 ) -- Flexible/Normal
spec:RegisterGear( "tier16_lfr", 99740, 99741, 99742, 99743, 99744 ) -- LFR
spec:RegisterGear( "tier16_heroic", 99832, 99833, 99834, 99835, 99836 ) -- Heroic
spec:RegisterGear( "tier16_mythic", 100023, 100024, 100025, 100026, 100027 ) -- Mythic

-- Legendary Items
spec:RegisterGear( "legendary_cloak_healer", 102249 ) -- Qian-Le, Courage of Niuzao (Healer)
spec:RegisterGear( "legendary_cloak_caster", 102248 ) -- Qian-Ying, Fortitude of Niuzao (Caster)

-- Notable Trinkets and Items
spec:RegisterGear( "vial_of_living_corruption", 102291 ) -- Vial of Living Corruption (Int/Spirit)
spec:RegisterGear( "purified_bindings_of_immerseus", 102281 ) -- Purified Bindings of Immerseus
spec:RegisterGear( "thoks_tail_tip", 102302 ) -- Thok's Tail Tip
spec:RegisterGear( "prismatic_prison_of_pride", 102292 ) -- Prismatic Prison of Pride
spec:RegisterGear( "dysmorphic_samophlange_of_discontinuity", 102298 ) -- Dysmorphic Samophlange

-- Meta Gems
spec:RegisterGear( "burning_primal_diamond", 76884 ) -- +216 Int and 3% increased crit effect
spec:RegisterGear( "bracing_primal_diamond", 76885 ) -- +216 Int and 5% chance to restore mana
spec:RegisterGear( "revitalizing_primal_diamond", 76890 ) -- +216 Int and 3% increased healing

-- PvP Sets
spec:RegisterGear( "gladiators_satin", 100187, 100188, 100189, 100190, 100191 ) -- Season 14 Gladiator
spec:RegisterGear( "grievous_gladiators_satin", 100340, 100341, 100342, 100343, 100344 ) -- Season 15 Grievous

-- Challenge Mode Sets
spec:RegisterGear( "challenge_mode_priest", 90146, 90147, 90148, 90149, 90150 ) -- Challenge Mode Transmog

-- Tier Set Aura Associations
spec:RegisterAura( "item_bonus_33076", { -- T14 2pc: Prayer of Mending bounces 1 additional time
    id = 105832,
} )
spec:RegisterAura( "item_bonus_585", { -- T14 4pc: Smite reduces enemy damage by 10%
    id = 105833,
} )
spec:RegisterAura( "item_bonus_47540", { -- T15 2pc: Penance increases healing by 40% for 6 sec
    id = 138157,
} )
spec:RegisterAura( "item_bonus_81700", { -- T15 4pc: Archangel reduces cooldowns by 2 sec per stack
    id = 138159,
} )
spec:RegisterAura( "item_bonus_17", { -- T16 2pc: Power Word: Shield absorbs 40% more
    id = 144583,
} )
spec:RegisterAura( "item_bonus_2061", { -- T16 4pc: Flash Heal increases healing by 30% for 8 sec  
    id = 144584,
} )

-- Talents (MoP 6-tier talent system)
spec:RegisterTalents( {
    -- Tier 1 (Level 15) - Healing/Utility
    void_tendrils             = { 1, 1, 108920 }, -- Shadowy tendrils immobilize all enemies for 8 sec
    psyfiend                  = { 1, 2, 108921 }, -- Pet that fears target every 4 sec for 20 sec
    dominate_mind             = { 1, 3, 108968 }, -- Controls enemy for 8 sec

    -- Tier 2 (Level 30) - Movement
    body_and_soul             = { 2, 1, 64129  }, -- Power Word: Shield increases movement speed by 60%
    angelic_feather           = { 2, 2, 121536 }, -- Places feather that grants 80% movement speed
    phantasm                  = { 2, 3, 108942 }, -- Fade grants immunity to movement impairing effects

    -- Tier 3 (Level 45) - Survivability
    from_darkness_comes_light = { 3, 1, 109186 }, -- Damage spells have chance to reset Flash Heal
    mindbender                = { 3, 2, 123040 }, -- Shadowfiend that returns 4% mana per hit
    archangel                 = { 3, 3, 81700  }, -- Consumes Evangelism for healing/damage increase

    -- Tier 4 (Level 60) - Control
    desperate_prayer          = { 4, 1, 19236  }, -- Instantly heals for 30% of max health
    spectral_guise            = { 4, 2, 112833 }, -- Instantly become invisible for 6 sec
    angelic_bulwark           = { 4, 3, 108945 }, -- Shield absorbs when health drops below 30%

    -- Tier 5 (Level 75) - Healing Enhancement
    twist_of_fate             = { 5, 1, 109142 }, -- +20% damage/healing to targets below 35% health
    power_infusion            = { 5, 2, 10060  }, -- +40% spell haste for 15 sec
    serenity                  = { 5, 3, 14914  }, -- Reduces all spell cooldowns by 4 sec

    -- Tier 6 (Level 90) - Ultimate
    cascade                   = { 6, 1, 121135 }, -- Healing/damaging bolt that bounces to targets
    divine_star               = { 6, 2, 110744 }, -- Projectile travels forward and back, healing/damaging
    halo                      = { 6, 3, 120517 }  -- Ring of light expands outward, healing/damaging
} )

-- Comprehensive Glyph System (MoP)
-- ====================================
spec:RegisterGlyphs( {
    -- Major Glyphs (Discipline-focused)
    [55672] = "circle_of_healing", -- Reduces mana cost of Circle of Healing by 20%
    [55680] = "dispel_magic", -- Increases range of Dispel Magic by 10 yards
    [42408] = "fade", -- Fade removes all movement impairing effects
    [55677] = "fear_ward", -- Fear Ward can absorb 1 additional fear effect
    [120581] = "focused_mending", -- Prayer of Mending bounces instantly to injured targets
    [55684] = "fortitude", -- Power Word: Fortitude also increases maximum mana by 10%
    [56161] = "guardian_spirit", -- Guardian Spirit lasts 50% longer
    [55675] = "holy_nova", -- Holy Nova range increased by 50%
    [63248] = "hymn_of_hope", -- Hymn of Hope affects 2 additional targets
    [55678] = "inner_fire", -- Inner Fire increases spell power by additional 45
    [42414] = "levitate", -- Levitate speed increased by 60%
    [55682] = "mass_dispel", -- Mass Dispel affects 2 additional targets
    [42415] = "mind_control", -- Mind Control lasts 3 seconds longer
    [55679] = "mind_spike", -- Mind Spike damage increased by 30%
    [42409] = "power_word_barrier", -- Power Word: Barrier absorbs 40% more damage
    [55685] = "power_word_shield", -- Power Word: Shield also heals for 20% of absorption
    [42417] = "prayer_of_healing", -- Prayer of Healing heals 2 additional targets
    [42410] = "prayer_of_mending", -- Prayer of Mending heals 60% more but bounces 1 fewer time
    [55674] = "psychic_horror", -- Psychic Horror disarms target for 8 seconds
    [55681] = "psychic_scream", -- Psychic Scream causes targets to tremble in place
    [42412] = "renew", -- Renew heals instantly for 25% of total healing
    [42411] = "scourge_imprisonment", -- Shackle Undead lasts 50% longer
    [42413] = "shadow_word_death", -- Shadow Word: Death deals 100% more damage to targets below 25%
    [55676] = "shadow_word_pain", -- Shadow Word: Pain periodic damage increased by 40%
    [42416] = "spirit_of_redemption", -- Spirit of Redemption lasts 50% longer
    [55673] = "weakened_soul", -- Weakened Soul duration reduced by 2 seconds
    [159616] = "penance", -- Penance fires 1 additional bolt
    [120587] = "borrowed_time", -- Borrowed Time increases haste by additional 14%
    [159618] = "evangelism", -- Evangelism stacks grant additional 2% per stack
    [159620] = "grace", -- Grace increases healing by additional 4% per stack
    [159622] = "rapture", -- Rapture cooldown reduced by 3 seconds
    [159624] = "atonement", -- Atonement healing increased by 25%
    [159626] = "divine_accuracy", -- Divine Accuracy increases spell hit by 6%
    [159628] = "strength_of_soul", -- Strength of Soul removes Weakened Soul on critical heals
    [159630] = "improved_power_word_shield", -- Power Word: Shield absorbs 15% more per Mastery
    [159632] = "soul_warding", -- Soul Warding increases shield effectiveness by 30%
    [159634] = "blessed_recovery", -- Blessed Recovery increases healing received by 25%
    [159636] = "divine_providence", -- Divine Providence reduces mana costs by 15%
    [159638] = "improved_healing", -- Improved Healing increases all healing by 10%
    [159640] = "mental_agility", -- Mental Agility reduces all cooldowns by 15%

    -- Minor Glyphs (Utility and Visual)
    [58228] = "fading", -- Fade removes targeting but reduces speed by 50%
    [58680] = "fortitude", -- Power Word: Fortitude applies to entire raid
    [58681] = "levitate", -- Levitate lasts 50% longer
    [58682] = "shackle_undead", -- Shackle Undead glowing effect
    [58683] = "shadow_protection", -- Shadow Protection applies to entire raid
    [58684] = "shadowfiend", -- Shadowfiend is translucent
    [126135] = "confession", -- Confession visual effect when Mind Control breaks
    [126136] = "holy_resurrection", -- Resurrection creates light effect
    [126137] = "borrowed_time", -- Borrowed Time creates swirling lights
    [126138] = "dark_archangel", -- Archangel creates dark wings effect
} )

-- Advanced Aura System with Generate Functions
-- =============================================
spec:RegisterAuras( {
    -- Core Discipline Mechanics
    -- =========================
    
    -- Power Word: Shield with advanced tracking
    power_word_shield = {
        id = 17,
        duration = 15,
        max_stack = 1,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = UA_GetPlayerAuraBySpellID( 17 )
            
            if name then
                t.name = name
                t.count = count > 0 and count or 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Weakened Soul debuff tracking
    weakened_soul = {
        id = 6788,
        duration = 15,
        max_stack = 1,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = GetTargetDebuffByID( 6788 )
            
            if name then
                t.name = name
                t.count = count > 0 and count or 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Grace stacks with smart tracking
    grace = {
        id = 77613,
        duration = 8,
        max_stack = 3,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = GetTargetDebuffByID( 77613 )
            
            if name then
                t.name = name
                t.count = count > 0 and count or 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Evangelism stacks for Archangel
    evangelism = {
        id = 81661,
        duration = 20,
        max_stack = 5,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = UA_GetPlayerAuraBySpellID( 81661 )
            
            if name then
                t.name = name
                t.count = count > 0 and count or 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Archangel buff tracking
    archangel = {
        id = 81700,
        duration = 18,
        max_stack = 5,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = UA_GetPlayerAuraBySpellID( 81700 )
            
            if name then
                t.name = name
                t.count = count > 0 and count or 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Advanced Discipline Systems
    -- ===========================
    
    -- Borrowed Time haste buff
    borrowed_time = {
        id = 59889,
        duration = 6,
        max_stack = 1,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = UA_GetPlayerAuraBySpellID( 59889 )
            
            if name then
                t.name = name
                t.count = 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Atonement for damage-to-healing conversion
    atonement = {
        id = 81749,
        duration = 3600,
        max_stack = 1,
        generate = function( t )
            -- Atonement is always active for Discipline priests at level 38+
            if state.level >= 38 then
                t.name = "Atonement"
                t.count = 1
                t.expires = state.query_time + 3600
                t.applied = state.query_time
                t.caster = "player"
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Core Buffs and Effects
    -- ======================
    
    -- Inner Fire spell power buff
    inner_fire = {
        id = 588,
        duration = 1800,
        max_stack = 1,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = UA_GetPlayerAuraBySpellID( 588 )
            
            if name then
                t.name = name
                t.count = 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Prayer of Mending charge tracking
    prayer_of_mending = {
        id = 33076,
        duration = 30,
        max_stack = 5,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = UA_GetPlayerAuraBySpellID( 33076 )
            
            if name then
                t.name = name
                t.count = count > 0 and count or 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Talent and Ultimate Effects
    -- ===========================
    
    -- Divine Insight proc (MoP talent)
    divine_insight = {
        id = 109175,
        duration = 10,
        max_stack = 1,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = UA_GetPlayerAuraBySpellID( 109175 )
            
            if name then
                t.name = name
                t.count = 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Power Infusion talent buff
    power_infusion = {
        id = 10060,
        duration = 15,
        max_stack = 1,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = UA_GetPlayerAuraBySpellID( 10060 )
            
            if name then
                t.name = name
                t.count = 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Defensive Cooldowns
    -- ===================
    
    -- Guardian Spirit ultimate save
    guardian_spirit = {
        id = 47788,
        duration = 10,
        max_stack = 1,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = GetTargetDebuffByID( 47788 )
            
            if name then
                t.name = name
                t.count = 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Pain Suppression damage reduction
    pain_suppression = {
        id = 33206,
        duration = 8,
        max_stack = 1,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = GetTargetDebuffByID( 33206 )
            
            if name then
                t.name = name
                t.count = 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Resource and Pet Management
    -- ===========================
    
    -- Shadowfiend pet active
    shadowfiend = {
        id = 34433,
        duration = 15,
        max_stack = 1,
        generate = function( t )
            if UnitExists("pet") and UnitCreatureFamily("pet") == "Shadowfiend" then
                t.name = "Shadowfiend"
                t.count = 1
                t.expires = state.query_time + 15 -- Approximate remaining duration
                t.applied = state.query_time
                t.caster = "player"
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Mindbender pet active (talent)
    mindbender = {
        id = 123040,
        duration = 15,
        max_stack = 1,
        generate = function( t )
            if state.talent.mindbender.enabled and UnitExists("pet") and UnitCreatureFamily("pet") == "Mindbender" then
                t.name = "Mindbender"
                t.count = 1
                t.expires = state.query_time + 15 -- Approximate remaining duration
                t.applied = state.query_time
                t.caster = "player"
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Rapture readiness tracking
    rapture_ready = {
        id = 47755,
        duration = 12,
        max_stack = 1,
        generate = function( t )
            -- Custom logic for Rapture internal cooldown
            local last_rapture = state.last_rapture_proc or 0
            local time_since = state.query_time - last_rapture
            
            if time_since >= 12 then
                t.name = "Rapture Ready"
                t.count = 1
                t.expires = state.query_time + 3600
                t.applied = state.query_time
                t.caster = "player"
                return
            end
            
            t.count = 0
            t.expires = last_rapture + 12
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- DoT Effects
    -- ===========
    
    -- Renew HoT tracking
    renew = {
        id = 139,
        duration = 15,
        max_stack = 1,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = GetTargetDebuffByID( 139 )
            
            if name then
                t.name = name
                t.count = 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Holy Fire DoT effect
    holy_fire = {
        id = 14914,
        duration = 7,
        max_stack = 1,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = GetTargetDebuffByID( 14914 )
            
            if name then
                t.name = name
                t.count = 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- Tier Set Bonuses
    -- ================
    
    -- T14 2pc: Prayer of Mending bonus bounce
    t14_2pc_bonus = {
        id = 105832,
        duration = 3600,
        max_stack = 1,
        generate = function( t )
            if state.set_bonus.tier14_2pc > 0 then
                t.name = "T14 2pc Bonus"
                t.count = 1
                t.expires = state.query_time + 3600
                t.applied = state.query_time
                t.caster = "player"
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- T15 2pc: Penance healing enhancement
    t15_2pc_healing = {
        id = 138157,
        duration = 6,
        max_stack = 1,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = UA_GetPlayerAuraBySpellID( 138157 )
            
            if name and state.set_bonus.tier15_2pc > 0 then
                t.name = name
                t.count = 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
            
            t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
    
    -- T16 4pc: Flash Heal enhancement
    t16_4pc_healing = {
        id = 144584,
        duration = 8,
        max_stack = 1,
        generate = function( t )
            local name, icon, count, debuffType, duration, expirationTime, caster = UA_GetPlayerAuraBySpellID( 144584 )
            
            if name and state.set_bonus.tier16_4pc > 0 then
                t.name = name
                t.count = 1
                t.expires = expirationTime
                t.applied = expirationTime - duration
                t.caster = caster
                return
            end
              t.count = 0
            t.expires = 0
            t.applied = 0
            t.caster = "nobody"
        end
    },
} )

-- Abilities
spec:RegisterAbilities( {
    -- Power Word: Shield
    power_word_shield = {
        id = 17,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        
        spend = 0.23,
        spendType = "mana",
        
        handler = function ()
            applyBuff( "power_word_shield" )
            applyDebuff( "target", "weakened_soul" )
            applyBuff( "borrowed_time" )
        end,
    },
    
    -- Greater Heal
    greater_heal = {
        id = 2060,
        cast = 2.5,
        cooldown = 0,
        gcd = "spell",
        
        spend = 0.32,
        spendType = "mana",
        
        handler = function ()
            if debuff.grace.up then
                applyDebuff( "target", "grace", nil, min( 3, debuff.grace.stack + 1 ) )
            else
                applyDebuff( "target", "grace" )
            end
        end,
    },
    
    -- Flash Heal
    flash_heal = {
        id = 2061,
        cast = 1.5,
        cooldown = 0,
        gcd = "spell",
        
        spend = 0.30,
        spendType = "mana",
        
        handler = function ()
            if debuff.grace.up then
                applyDebuff( "target", "grace", nil, min( 3, debuff.grace.stack + 1 ) )
            else
                applyDebuff( "target", "grace" )
            end
        end,
    },
    
    -- Heal
    heal = {
        id = 2050,
        cast = 3.0,
        cooldown = 0,
        gcd = "spell",
        
        spend = 0.25,
        spendType = "mana",
        
        handler = function ()
            if debuff.grace.up then
                applyDebuff( "target", "grace", nil, min( 3, debuff.grace.stack + 1 ) )
            else
                applyDebuff( "target", "grace" )
            end
        end,
    },
    
    -- Prayer of Healing
    prayer_of_healing = {
        id = 596,
        cast = 3.0,
        cooldown = 0,
        gcd = "spell",
        
        spend = 0.48,
        spendType = "mana",
    },
    
    -- Prayer of Mending
    prayer_of_mending = {
        id = 33076,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        
        spend = 0.24,
        spendType = "mana",
        
        handler = function ()
            applyBuff( "prayer_of_mending" )
        end,
    },
    
    -- Renew
    renew = {
        id = 139,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        
        spend = 0.17,
        spendType = "mana",
        
        handler = function ()
            applyDebuff( "target", "renew" )
        end,
    },
    
    -- Penance
    penance = {
        id = 47540,
        cast = 2.0,
        cooldown = 10,
        gcd = "spell",
        
        spend = 0.16,
        spendType = "mana",
        
        handler = function ()
            if buff.evangelism.up then
                applyBuff( "evangelism", nil, min( 5, buff.evangelism.stack + 1 ) )
            else
                applyBuff( "evangelism" )
            end
        end,
    },
    
    -- Smite
    smite = {
        id = 585,
        cast = 2.5,
        cooldown = 0,
        gcd = "spell",
        
        spend = 0.16,
        spendType = "mana",
        
        handler = function ()
            if buff.evangelism.up then
                applyBuff( "evangelism", nil, min( 5, buff.evangelism.stack + 1 ) )
            else
                applyBuff( "evangelism" )
            end
        end,
    },
    
    -- Holy Fire
    holy_fire = {
        id = 14914,
        cast = 2.5,
        cooldown = 10,
        gcd = "spell",
        
        spend = 0.11,
        spendType = "mana",
        
        handler = function ()
            if buff.evangelism.up then
                applyBuff( "evangelism", nil, min( 5, buff.evangelism.stack + 1 ) )
            else
                applyBuff( "evangelism" )
            end
            applyDebuff( "target", "holy_fire" )
        end,
    },
    
    -- Archangel
    archangel = {
        id = 81700,
        cast = 0,
        cooldown = 60,
        gcd = "spell",
        
        talent = "archangel",
        
        usable = function () return buff.evangelism.stack > 0 end,
        
        handler = function ()
            local stacks = buff.evangelism.stack
            removeBuff( "evangelism" )
            applyBuff( "archangel", nil, stacks )
        end,
    },
    
    -- Inner Fire
    inner_fire = {
        id = 588,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        
        spend = 0.13,
        spendType = "mana",
        
        handler = function ()
            applyBuff( "inner_fire" )
        end,
    },
    
    -- Power Word: Barrier
    power_word_barrier = {
        id = 62618,
        cast = 0,
        cooldown = 180,
        gcd = "spell",
        
        spend = 0.44,
        spendType = "mana",
    },
    
    -- Pain Suppression
    pain_suppression = {
        id = 33206,
        cast = 0,
        cooldown = 180,
        gcd = "spell",
    },
    
    -- Guardian Spirit
    guardian_spirit = {
        id = 47788,
        cast = 0,
        cooldown = 180,
        gcd = "spell",
    },
} )

-- Register default pack for MoP Discipline Priest
spec:RegisterPack( "Discipline", 20250528, [[Hekili:T1PBVTTn04FlXjHj0Ofnr0i4Lvv9n0KxkzPORkyzyV1ikA2mzZ(fQ1Hm8kkjjjjlvQKKQKYfan1Y0YPpNvFupNLJLhum9DbDps9yVDJnLHrdlRJsrkzpNISnPnkTkUk(qNGYXnENRNpnS2)YBFm(nEF5(wB5OxZ)m45MyiytnisgMPzJfW2vZYwbpzw0aD6w)aW]] )

-- Register pack selector for Discipline

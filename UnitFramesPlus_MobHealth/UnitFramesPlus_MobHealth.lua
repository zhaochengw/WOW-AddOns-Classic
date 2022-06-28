--Based on LibClassicMobHealth-1.0
--TODO: realm name support
local match = string.match;
local floor = math.floor;
local tonumber = tonumber;
local tostring = tostring;
local strsplit = strsplit;
local ipairs = ipairs;
local pairs = pairs;
local next = next;
local UnitGUID = UnitGUID;
local UnitName = UnitName;
local UnitLevel = UnitLevel;
local UnitHealth = UnitHealth;
local UnitHealthMax = UnitHealthMax;
local UnitCanAttack = UnitCanAttack;
local UnitIsFriend = UnitIsFriend;
local UnitIsPlayer = UnitIsPlayer;
local UnitIsDead = UnitIsDead;
local UnitPlayerControlled = UnitPlayerControlled;

local ADDONNAME = ...;
local MAJOR_VERSION = 1;
local MINOR_VERSION = 3;

local levelmax = 63;--in classic, maxlevel=63, like Kel'Thuzad, C'Thun, Nefarian, Ragnaros, Onyxia

local accumulatedHP = {}; -- Keeps Damage-taken data for mobs that we've actually poked during this session
local accumulatedPercent = {}; -- Keeps Percentage-taken data for mobs that we've actually poked during this session
local calculationUnneeded = {}; -- Keeps a list of things that don't need calculation (e.g. Beast Lore'd mobs)

local currentAccumulatedHP = nil;
local currentAccumulatedPercent = nil;
local currentName = nil;
local currentLevel = nil;
local recentDamage = nil;
local lastPercent = nil;

--Lookup of mob unit types from GUID
local MobUnitTypes = {
    Creature = true,--    Mob/NPC
    Vignette = true,--    Rares
}

--Extracts CreatureID from GUID (Mobs only)
local function GetCreatureIDFromGUID(guid)
    if not guid then return end
    local utype, creatureid = match(guid, "^(.-)%-0%-%d+%-%d+%-%d+%-(%d+)%-%x+$");
    --Return CreatureID if mob
    return (utype and MobUnitTypes[utype]) and (creatureid and tonumber(creatureid));
end

--Generates CreatureKey from CreatureID
local function GetUnitCreatureKey(unit)
    local creatureid = GetCreatureIDFromGUID(UnitGUID(unit));
    --Unit not mob
    if not creatureid then return end

    return tostring(creatureid);
end

function UnitFramesPlus_PruneData()
    if not UnitFramesPlusMobHealthOpt["save"] or UnitFramesPlusMobHealthOpt["save"] ~= true then
        UnitFramesPlusMobHealthDB = nil;
        return;
    end

    -- let's get rid of low-level players
    local playerLevel = UnitLevel("player");
    local maxLevel;
    if playerLevel == 60 then
        maxLevel = 60;
    else
        maxLevel = playerLevel*3/4;
        if maxLevel > playerLevel - 5 then
            maxLevel = playerLevel - 5;
        end
    end
    for _, kind in ipairs({ "pet", "pc" }) do
        for guidlevel in pairs(UnitFramesPlusMobHealthDB[kind]) do
            local guid, level = strsplit(",", guidlevel);
            if level then
                if tonumber(level) < maxLevel then
                    UnitFramesPlusMobHealthDB[kind][guidlevel] = nil;
                end
            else
                UnitFramesPlusMobHealthDB[kind][guidlevel] = nil;
            end
        end
    end

    if not UnitFramesPlusMobHealthOpt["prune"] or UnitFramesPlusMobHealthOpt["prune"] ~= 1 then
        return;
    end

    -- let's try to only have one mob-level, don't have duplicates for each level, since they can be estimated, and for players/pets, this will get rid of old data
    local mobs = {};
    for _, kind in ipairs({ "npc", "pc", "pet" }) do
        if next(UnitFramesPlusMobHealthDB[kind]) then
            for guidlevel, health in pairs(UnitFramesPlusMobHealthDB[kind]) do
                local guid, level = strsplit(",", guidlevel);
                if level then
                    if mobs[guid] then
                        if tonumber(level) > tonumber(mobs[guid]) then
                            UnitFramesPlusMobHealthDB[kind][guid..","..mobs[guid]] = nil;
                            mobs[guid] = level;
                        else
                            UnitFramesPlusMobHealthDB[kind][guidlevel] = nil;
                        end
                    else
                        mobs[guid] = level;
                    end
                else
                    UnitFramesPlusMobHealthDB[kind][guidlevel] = nil;
                end
            end
        end
    end
    mobs = nil;

    -- still too much data, let's get rid of low-level non-bosses
    maxLevel = playerLevel*3/4;
    if maxLevel > playerLevel - 5 then
        maxLevel = playerLevel - 5;
    end
    for _, kind in ipairs({ "npc" }) do
        for guidlevel in pairs(UnitFramesPlusMobHealthDB[kind]) do
            local guid, level = strsplit(",", guidlevel);
            if level then
                if tonumber(level) < maxLevel then
                    UnitFramesPlusMobHealthDB[kind][guidlevel] = nil;
                end
            else
                UnitFramesPlusMobHealthDB[kind][guidlevel] = nil;
            end
        end
    end
end

local function UnitFramesPlus_UNIT_COMBAT(unit, damage)
    if unit ~= "target" or not currentAccumulatedHP then
        return;
    end
    recentDamage = recentDamage + damage;
end

local function UnitFramesPlus_PLAYER_UNIT_CHANGED(unit)
    if not UnitCanAttack("player", unit) or UnitIsDead(unit) or UnitIsFriend("player", unit) then
        -- don't store data on friends and dead men tell no tales
        currentAccumulatedHP = nil;
        currentAccumulatedPercent = nil;
        return;
    end

    local isPlayer = UnitIsPlayer(unit);
    -- some owners name their pets the same name as other people, because they're think they're funny. They're not.
    local isPet = UnitPlayerControlled(unit) and not isPlayer;
    local level = UnitLevel(unit);
    currentLevel = level;

    recentDamage = 0;
    lastPercent = UnitHealth(unit);

    if not isPlayer and not isPet then
        local tag = GetUnitCreatureKey(unit)..","..tostring(level);

        currentAccumulatedHP = accumulatedHP[tag];
        currentAccumulatedPercent = accumulatedPercent[tag];

        -- Mob
        if not currentAccumulatedHP then
            local saved = UnitFramesPlusMobHealthDB["npc"][tag];
            if saved then
                -- We claim that the saved value is worth 100%
                accumulatedHP[tag] = saved;
                accumulatedPercent[tag] = 100;
            else
                -- Nothing previously known. Start fresh.
                accumulatedHP[tag] = 0;
                accumulatedPercent[tag] = 0;
            end
            currentAccumulatedHP = accumulatedHP[tag];
            currentAccumulatedPercent = accumulatedPercent[tag];
        end
        
        if currentAccumulatedPercent > 200 then
            -- keep accumulated percentage below 200% in case we hit mobs with different hp
            currentAccumulatedHP = currentAccumulatedHP / currentAccumulatedPercent * 100;
            currentAccumulatedPercent = 100;
        end
    else
        --in classic, server always return nil
        -- local name, server = UnitName(unit);
        -- if server and server ~= "" then
        --     name = name .. "," .. server;
        -- end
        local name = UnitName(unit);
        local tag = name..","..tostring(level);

        currentAccumulatedHP = accumulatedHP[tag];
        currentAccumulatedPercent = accumulatedPercent[tag];

        -- Player health can change a lot. Different gear, buffs, etc.. we only assume that we've seen 10% knocked off players previously
        if not currentAccumulatedHP then
            local saved = UnitFramesPlusMobHealthDB[isPet and "pet" or "pc"][tag];
            if saved then
                -- We claim that the saved value is worth 10%
                accumulatedHP[tag] = saved/10;
                accumulatedPercent[tag] = 10;
            else
                accumulatedHP[tag] = 0;
                accumulatedPercent[tag] = 0;
            end
            currentAccumulatedHP = accumulatedHP[tag];
            currentAccumulatedPercent = accumulatedPercent[tag];
        end

        if currentAccumulatedPercent > 10 then
            currentAccumulatedHP = currentAccumulatedHP / currentAccumulatedPercent * 10;
            currentAccumulatedPercent = 10;
        end
    end
end

local function UnitFramesPlus_PLAYER_TARGET_CHANGED()
    UnitFramesPlus_PLAYER_UNIT_CHANGED("target");
end

local function UnitFramesPlus_UNIT_HEALTH(unit)
    if unit ~= "target" or not currentAccumulatedHP then
        return;
    end

    --in classic, server always return nil
    -- local name, server = UnitName(unit);
    -- if server and server ~= "" then
    --     name = name .. "," .. server;
    -- end
    local name = UnitName(unit);
    local guid = name;
    local current = UnitHealth(unit);
    local max = UnitHealthMax(unit);
    local level = currentLevel;
    local kind;
    local tag;
    if UnitIsPlayer(unit) then
        kind = "pc";
        tag = name..","..level;
    elseif UnitPlayerControlled(unit) then
        kind = "pet";
        tag = name..","..level;
    else
        kind = "npc";
        tag = GetUnitCreatureKey(unit)..","..level;
    end

    if calculationUnneeded[tag] then
        return;
    elseif current == 0 then
        -- possibly targetting a dead person
    elseif max ~= 100 then
        -- -- beast lore, don't need to calculate.
        if kind == "npc" then
            UnitFramesPlusMobHealthDB.npc[tag] = max;
        else
            UnitFramesPlusMobHealthDB[kind][tag] = max;
        end
        calculationUnneeded[tag] = true;
    elseif current > lastPercent or lastPercent > 100 then
        -- it healed, so let's reset our ephemeral calculations
        lastPercent = current;
        recentDamage = 0;
    elseif recentDamage > 0 then
        if current ~= lastPercent then
            currentAccumulatedHP = currentAccumulatedHP + recentDamage;
            currentAccumulatedPercent = currentAccumulatedPercent + (lastPercent - current);
            recentDamage = 0;
            lastPercent = current;
            
            if currentAccumulatedPercent >= 10 then
                local num = currentAccumulatedHP / currentAccumulatedPercent * 100;
                if kind == "npc" then
                    UnitFramesPlusMobHealthDB.npc[tag] = num;
                else
                    UnitFramesPlusMobHealthDB[kind][tag] = num;
                end
            end
        end
    end
end

local function guessAtMaxHealth(guid, level, kind, known)
    -- if we have data on a mob of the same name but a different level, check within two levels and guess from there.
    if not kind then
        return guessAtMaxHealth(guid, level, "npc") or guessAtMaxHealth(guid, level, "pc") or guessAtMaxHealth(guid, level, "pet");
    end

    --try to match level for skull
    if kind == "npc" and level == -1 then
        local lvl = levelmax;
        while lvl > 0 do
            if UnitFramesPlusMobHealthDB["npc"][guid..","..lvl] then
                level = lvl;
                break;
            end
            lvl = lvl - 1;
        end
    end

    if kind == "npc" then
        local value = UnitFramesPlusMobHealthDB[kind][guid..","..level];
        if value then
            return value;
        end
        if level > 1 then
            value = UnitFramesPlusMobHealthDB[kind][guid..","..level-1];
            if value then
                return value * level/(level - 1);
            end
        end
        value = UnitFramesPlusMobHealthDB[kind][guid..","..level+1];
        if value then
            return value * level/(level + 1);
        end
        if level > 2 then
            value = UnitFramesPlusMobHealthDB[kind][guid..","..level-2];
            if value then
                return value * level/(level - 2);
            end
        end
        value = UnitFramesPlusMobHealthDB[kind][guid..","..level+2];
        if value then
            return value * level/(level + 2);
        end
    else
        local value = UnitFramesPlusMobHealthDB[kind][guid..","..level];
        if value then
            return value;
        end
        if level > 1 then
            value = UnitFramesPlusMobHealthDB[kind][guid..","..level-1];
            if value then
                return value * level/(level - 1);
            end
        end
        if level > 2 then
            value = UnitFramesPlusMobHealthDB[kind][guid..","..level-2];
            if value then
                return value * level/(level - 2);
            end
        end
    end
end

function UnitFramesPlus_GetUnitMaxHP(unit)
    local max = UnitHealthMax(unit);
    if max ~= 100 then
        return max, true;
    end

    --in classic, server always return nil
    -- local name, server = UnitName(unit);
    -- if server and server ~= "" then
    --     name = name .. "," .. server;
    -- end
    local name = UnitName(unit);
    local level = UnitLevel(unit);
    
    local kind, guid;
    if UnitIsPlayer(unit) then
        kind = "pc";
        guid = name;
    elseif UnitPlayerControlled(unit) then
        kind = "pet";
        guid = name;
    else
        kind = "npc";
        guid = GetUnitCreatureKey(unit);
    end

    if guid then
        local value = guessAtMaxHealth(guid, level, kind);
        if value then
            return floor(value + 0.5), true;
        else
            return max, false;
        end
    else
        return max, false;
    end
end

function UnitFramesPlus_GetUnitCurrentHP(unit)
    local current, max = UnitHealth(unit), UnitHealthMax(unit);
    if max ~= 100 then
        return current, true;
    end

    --in classic, server always return nil
    -- local name, server = UnitName(unit);
    -- if server and server ~= "" then
    --     name = name .. "," .. server;
    -- end
    local name = UnitName(unit);
    local level = UnitLevel(unit);

    local kind, guid;
    if UnitIsPlayer(unit) then
        kind = "pc"
        guid = name;
    elseif UnitPlayerControlled(unit) then
        kind = "pet"
        guid = name;
    else
        kind = "npc"
        guid = GetUnitCreatureKey(unit);
    end

    if guid then
        local value = guessAtMaxHealth(guid, level, kind);
        if value then
            return floor(current/max * value + 0.5), true;
        else
            return current, false;
        end
    else
        return current, false;
    end
end

function UnitFramesPlus_GetUnitHealth(unit)
    local current, max = UnitHealth(unit), UnitHealthMax(unit);
    if max ~= 100 then
        return current, max, true;
    end

    --in classic, server always return nil
    -- local name, server = UnitName(unit);
    -- if server and server ~= "" then
    --     name = name .. "," .. server;
    -- end
    local name = UnitName(unit);
    local level = UnitLevel(unit);

    local kind, guid;
    if UnitIsPlayer(unit) then
        kind = "pc"
        guid = name;
    elseif UnitPlayerControlled(unit) then
        kind = "pet"
        guid = name;
    else
        kind = "npc"
        guid = GetUnitCreatureKey(unit);
    end

    if guid then
        local value = guessAtMaxHealth(guid, level, kind);
        if value then
            return floor(current/max * value + 0.5), floor(value + 0.5), true;
        else
            return current, max, false;
        end
    else
        return current, max, false;
    end
end

local function UnitFramesPlus_MobHealth_Init()
    if not UnitFramesPlusMobHealthDB or UnitFramesPlusMobHealthDB["ver"] ~= MAJOR_VERSION.."."..MINOR_VERSION then
        UnitFramesPlusMobHealthDB = {
            ["npc"] = {},
            ["pc"]  = {},
            ["pet"] = {},
            ["ver"] = MAJOR_VERSION.."."..MINOR_VERSION,
        }
    end

    if not UnitFramesPlusMobHealthOpt then
        UnitFramesPlusMobHealthOpt = {
            ["prune"] = 0,
            ["save"]  = true,
        }
    end
end

local ufpmh = CreateFrame("Frame");
ufpmh:RegisterEvent("ADDON_LOADED");
ufpmh:RegisterEvent("PLAYER_LOGOUT")
ufpmh:RegisterEvent("PLAYER_TARGET_CHANGED");
ufpmh:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "target");
ufpmh:RegisterUnitEvent("UNIT_COMBAT", "target");
ufpmh:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...;
        if name == ADDONNAME then
            UnitFramesPlus_MobHealth_Init();
            ufpmh:UnregisterEvent("ADDON_LOADED");
        end
    elseif event == "PLAYER_LOGOUT" then
        UnitFramesPlus_PruneData();
    elseif event == "PLAYER_TARGET_CHANGED" then
        UnitFramesPlus_PLAYER_TARGET_CHANGED();
    elseif event == "UNIT_HEALTH_FREQUENT" then
        UnitFramesPlus_UNIT_HEALTH("target");
    elseif event == "UNIT_COMBAT" then
        local _, _, _, damage = ...;
        UnitFramesPlus_UNIT_COMBAT("target", damage);
    end
end)

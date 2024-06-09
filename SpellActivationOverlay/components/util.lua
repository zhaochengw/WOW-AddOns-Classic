local AddonName, SAO = ...

-- This script file is not a 'component' per se, but its functions are used across components

-- Optimize frequent calls
local GetActionInfo = GetActionInfo
local GetNumTalents = GetNumTalents
local GetNumTalentTabs = GetNumTalentTabs
local GetSpellBookItemName = GetSpellBookItemName
local GetSpellInfo = GetSpellInfo
local GetSpellTabInfo = GetSpellTabInfo
local GetTalentInfo = GetTalentInfo
local UnitAura = UnitAura

function SAO.Debug(self, msg, ...)
    if SpellActivationOverlayDB.debug then
        print("[SAO@"..GetTime().."] "..msg, ...);
    end
end

-- Utility function to assume times are identical or almost identical
function SAO.IsTimeAlmostEqual(self, t1, t2, delta)
	return t1-delta < t2 and t2 < t1+delta;
end

-- Factorize API calls to get player buff or debuff or whatever
local function PlayerAura(index, filter)
    return UnitAura("player", index, filter);
end

-- Aura parsing function that includes both buffs and debuffs
-- If the condition is true on more than one aura, refer to this priority list:
-- - buffs are always favored before debuffs
-- - early indexes are favored
local function FindPlayerAuraBy(condition)
    for _, filter in ipairs({"HELPFUL", "HARMFUL"}) do
        local i = 1
        local name, _, _, _, _, _, _, _, _, spellId = PlayerAura(i, filter);
        while name do
            if condition(spellId, name) then
                return i, filter;
            end
            i = i+1
            name, _, _, _, _, _, _, _, _, spellId = PlayerAura(i, filter);
        end
    end
end

-- Utility aura function, one of the many that Blizzard could've done better years ago...
function SAO.FindPlayerAuraByID(self, id)
    local index, filter = FindPlayerAuraBy(function(_id, _name) return _id == id end);
    if index then
        return PlayerAura(index, filter);
    end
end

-- Utility aura function, similar to AuraUtil.FindAuraByName
function SAO.FindPlayerAuraByName(self, name)
    local index, filter = FindPlayerAuraBy(function(_id, _name) return _name == name end);
    if index then
        return PlayerAura(index, filter);
    end
end

--[[
    Utility function to know how many talent points the player has spent on a specific talent

    If the talent is found, returns:
    - the number of points spent for this talent
    - the total number of points possible for this talent
    - the tabulation in which the talent was found
    - the index in which the talent was found
    Tabulation and index can be re-used in GetTalentInfo to avoid re-parsing all talents

    Returns nil if no talent is found with this name e.g., in the wrong expansion
]]
function SAO.GetTalentByName(self, talentName)
    for tab = 1, GetNumTalentTabs() do
        for index = 1, GetNumTalents(tab) do
            local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(tab, index);
            if (name == talentName) then
                return rank, maxRank, tab, index;
            end
        end
    end
end

-- Utility function to get the spell ID associated to an action
function SAO.GetSpellIDByActionSlot(self, actionSlot)
    local actionType, id, subType = GetActionInfo(actionSlot);
    if (actionType == "spell") then
        return id;
    elseif (actionType == "macro") then
        return GetMacroSpell(id);
    end
end

-- Utility function to return the list spellIDs for spells in the spellbook matching the same of a given spell
-- Spells are searched into the *current* spellbook, not through all available spells ever
-- This means the returned list will be obsolete if e.g. new spells are learned afterwards or if the player re-specs
-- @param spell Either the spell name (as string) or the spell ID (as number)
function SAO.GetHomonymSpellIDs(self, spell)
    local spellName;
    if (type(spell) == "string") then
        spellName = spell;
    elseif (type(spell) == "number") then
        spellName = GetSpellInfo(spell);
    end
    if (not spellName) then
        return {};
    end

    local homonyms = {};

    for tab = 1, GetNumSpellTabs() do
        local offset, numSlots = select(3, GetSpellTabInfo(tab));
        for index = offset+1, offset+numSlots do
            local name, _, id = GetSpellBookItemName(index, BOOKTYPE_SPELL);
            if (name == spellName) then
                table.insert(homonyms, id);
            end
        end
    end

    return homonyms;
end

--[[
    GlowInterface generalizes how to invoke custom glowing buttons

    Inheritance is done by the bind function, then init must be called e.g.
        MyHandler = { var = 42 }
        GlowInterface:bind(MyHandler);
        MyHandler:init(spellID, spellName);

    Once this is done, the glow() and unglow() methods can be called
        MyHandler:glow();
        MyHandler:unglow();
]]
SAO.GlowInterface = {
    bind = function(self, obj)
        self.__index = nil;
        setmetatable(obj, self);
        self.__index = self;
    end,

    initVars = function(self, id, name, separateAuraID, maxDuration, variantValues, optionTestFunc)
        -- IDs
        self.spellID = id;
        self.spellName = name;
        local shiftID = separateAuraID and 1000000 or 0; -- 1M ought to be enough for anybody
        if type(separateAuraID) == 'number' then
            shiftID = shiftID * separateAuraID;
        end
        self.auraID = id + shiftID;
        self.optionID = id;

        -- Glowing state
        self.glowing = false;

        -- Timers
        self.vanishTime = nil;
        self.maxDuration = maxDuration;

        -- Variants
        self.variants = variantValues and SAO:CreateStringVariants("glow", self.optionID, self.spellID, variantValues) or nil;
        self.optionTestFunc = self.variants and optionTestFunc or nil;
    end,

    -- Make the button glow if the glowing button is enabled in options
    -- When the button glows, start or restart the timer, unless either condtion is true
    -- - the glowing button was not initialized with a duration
    -- - the skipTimer argument is true
    glow = function(self, skipTimer)
        if type(self.optionTestFunc) ~= 'function' or self.optionTestFunc(self.variants.getOption()) then
            -- Let it glow
            SAO:AddGlow(self.auraID, { self.spellName });
            self.glowing = true;

            -- Start timer if needed
            if self.maxDuration and not skipTimer then
                local tolerance = 0.2;
                self.vanishTime = GetTime() + self.maxDuration - tolerance;
                C_Timer.After(self.maxDuration, function()
                    self:timeout();
                end)
            end
        end
    end,

    -- Make the button unglow
    -- The button unglows even if it was disabled in options; better unglow too much than not enough
    -- The vanish timer, if any, is reset unless skipTimer is true
    unglow = function(self, skipTimer)
        SAO:RemoveGlow(self.auraID);
        self.glowing = false;
        if not skipTimer then
            self.vanishTime = nil;
        end
    end,

    timeout = function(self)
        if self.vanishTime and GetTime() > self.vanishTime then
            self:unglow();
            if type(self.onTimeout) == 'function' then
                self:onTimeout()
            end
        end
    end,
}

local AddonName, SAO = ...

-- Optimize frequent calls
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local GetSpellInfo = GetSpellInfo
local GetTalentInfo = GetTalentInfo
local UnitCanAttack = UnitCanAttack
local UnitExists = UnitExists
local UnitHealth = UnitHealth

local clearcastingVariants; -- Lazy init in lazyCreateClearcastingVariants()

local hotStreakSpellID = 48108;
local heatingUpSpellID = 48107; -- Does not exist in Wrath Classic
local hotStreakHeatingUpSpellID = hotStreakSpellID+heatingUpSpellID; -- Made up entirely, does not even exist in Retail

-- Because the Heating Up buff does not exist in Wrath of the Lich King
-- We try to guess when the mage should virtually get this buff
local HotStreakHandler = {}

-- Initialize constants
HotStreakHandler.init = function(self, spellName)
    local fire_blast = { 2136, 2137, 2138, 8412, 8413, 10197, 10199, 27078, 27079, 42872, 42873 }
    local fireball = { 133, 143, 145, 3140, 8400, 8401, 8402, 10148, 10149, 10150, 10151, 25306, 27070, 38692, 42832, 42833 }
    local frostfire_bolt = { 44614, 47610 };
    -- local living_bomb = { 44457, 55359, 55360 } this is the DOT effect, which we do NOT want
    local living_bomb = { 44461, 55361, 55362 }
    local scorch = { 2948, 8444, 8445, 8446, 10205, 10206, 10207, 27073, 27074, 42858, 42859 }

    self.spells = {}
    local function addSpellPack(spellPack)
        for _, spellID in pairs(spellPack) do
            self.spells[spellID] = true;
        end
    end
    addSpellPack(fire_blast);
    addSpellPack(fireball);
    addSpellPack(frostfire_bolt);
    addSpellPack(living_bomb);
    addSpellPack(scorch);

    local _, _, tab, index = SAO:GetTalentByName(spellName);
    if (tab and index) then
        self.talent = { tab, index }
    end

    -- There are 4 states possible: cold, heating_up, hot_streak and hot_streak_heating_up
    -- The state always starts as cold
    self.state = 'cold';
    -- There is a known issue when the player disconnects with the virtual "Heating Up" buff, then reconnects
    -- Ideally, we'd keep track of the virtual buff, but it's really hard to do, and sometimes not even possible
    -- It's best not to over-design something to try to fix fringe cases, so we simply accept this limitation

    -- Hot Streak can be banked or not
    -- Banking means there was a Heating Up proc on a previous spec, then the mage changed spec and lost the talent
    -- When the mage gets back the Hot Streak talent, the state comes back immediately to heating_up if it was banked
    -- Always start as not banked, for the same reason the state always starts as cold
    self.banked = false;
end

HotStreakHandler.isSpellTracked = function(self, spellID)
    return self.spells[spellID];
end

HotStreakHandler.hasHotStreakTalent = function(self)
    -- Talent information could not be retrieved for Hot Streak
    if (not self.talent) then
        return false;
    end

    -- Talent information must include at least one point in Hot Streak
    -- This may not be accurate, but it's almost impossible to do better
    -- Not to mention, almost no one will play with only 1 or 2 points
    local rank = select(5, GetTalentInfo(self.talent[1], self.talent[2]));
    return rank > 0;
end

local function activateHeatingUp(self, spellID)
    -- Heating Up uses the Hot Streak texture, but scaled at 50%
    self:ActivateOverlay(0, spellID, self.TexName["hot_streak"], "Left + Right (Flipped)", 0.5, 255, 255, 255, false);
end

local function deactivateHeatingUp(self, spellID)
    self:DeactivateOverlay(spellID);
end

local function hotStreakCLEU(self, ...)
    local timestamp, event, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo() -- For all events

    -- Special case: if player dies, we assumed the "Heating Up" virtual buff was lost
    -- However, data suggest that Heating Up is *not* lost on death, invalidating the code below
    -- The code is kept commented instead of removed, because Blizzard may change this behaviour
    --if (event == "UNIT_DIED" and destGUID == UnitGUID("player")) then
    --    if (HotStreakHandler.state == 'heating_up') then
    --        deactivateHeatingUp(self, heatingUpSpellID);
    --    elseif (HotStreakHandler.state == 'hot_streak_heating_up') then
    --        deactivateHeatingUp(self, hotStreakHeatingUpSpellID);
    --    end
    --    HotStreakHandler.state = 'cold';
    --    HotStreakHandler.banked = false;
    --
    --    return;
    --end

    -- Accept only certain events, and only when done by the player
    if (event ~= "SPELL_DAMAGE"
    and event ~= "SPELL_AURA_APPLIED"
    and event ~= "SPELL_AURA_REFRESH"
    and event ~= "SPELL_AURA_REMOVED") then return end
    if (sourceGUID ~= UnitGUID("player")) then return end

    local spellID, spellName, spellSchool = select(12, CombatLogGetCurrentEventInfo()) -- For SPELL_*

    -- If Hot Streak buff was acquired or lost, we have our immediate answer
    -- We assume there is no third charge i.e., if a crit occurs under Hot Streak buff, there is no hidden Heating Up
    if (event == "SPELL_AURA_APPLIED") then
        if (spellID == hotStreakSpellID) then
            deactivateHeatingUp(self, heatingUpSpellID);
            HotStreakHandler.state = 'hot_streak';
        end
        return;
    elseif (event == "SPELL_AURA_REFRESH") then
        if (spellID == hotStreakSpellID) then
            deactivateHeatingUp(self, hotStreakHeatingUpSpellID);
            HotStreakHandler.state = 'hot_streak';
        end
        return;
    elseif (event == "SPELL_AURA_REMOVED") then
        if (spellID == hotStreakSpellID) then
            if (HotStreakHandler.state == 'hot_streak_heating_up') then
                deactivateHeatingUp(self, hotStreakHeatingUpSpellID);
                activateHeatingUp(self, heatingUpSpellID);
                HotStreakHandler.state = 'heating_up';
            else
                HotStreakHandler.state = 'cold';
            end
        end
        return;
    end

    -- The rest of the code is dedicated to try to catch the Heating Up buff, or if the buff is lost.

    -- Must have the Hot Streak talent to go on
    if (not HotStreakHandler:hasHotStreakTalent()) then return end

    -- Spell must be match a known spell ID that can proc Hot Streak
    if (not HotStreakHandler:isSpellTracked(spellID)) then return end

    local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand = select(15, CombatLogGetCurrentEventInfo()); -- For SPELL_DAMAGE*

    if (HotStreakHandler.state == 'cold') then
        if (critical) then
            -- A crit while cold => Heating Up!
            HotStreakHandler.state = 'heating_up';
            activateHeatingUp(self, heatingUpSpellID);
        end
    elseif (HotStreakHandler.state == 'heating_up') then
        if (not critical) then
            -- No crit while Heating Up => cooling down
            HotStreakHandler.state = 'cold';
            deactivateHeatingUp(self, heatingUpSpellID);
        -- else
            -- We could put the state to 'hot_streak' here, but the truth is, we don't know for sure if it's accurate
            -- Either way, if the Hot Streak buff is deserved, we'll know soon enough with a "SPELL_AURA_APPLIED"
        end
    elseif (HotStreakHandler.state == 'hot_streak') then
        if (critical) then
            -- If crit during a Hot Streak, store this 'charge' to eventually restore it when Pyroblast is cast
            -- This is called "hot streaking heating up", which means Hot Streak has a pending Heating Up effect
            HotStreakHandler.state = 'hot_streak_heating_up';
            activateHeatingUp(self, hotStreakHeatingUpSpellID);
            -- Please note this works only because we are fairly certain that SPELL_AURA_APPLIED of a Hot Streak
            -- always occur *after* the critical effect of the spell which triggered it.
            -- Should it be the other way around (SPELL_AURA_APPLIED before SPELL_DAMAGE, or worse, random order)
            -- we would be in big trouble to know whether the crit is piling up before or after a Hot Streak.
        end
    elseif (HotStreakHandler.state == 'hot_streak_heating_up') then
        if (not critical) then
            -- If Hot Streak had a pending Heating Up effect but a spell did not crit afterwards, the pending Heating Up is lost
            HotStreakHandler.state = 'hot_streak';
            deactivateHeatingUp(self, hotStreakHeatingUpSpellID);
        end
    else
        print("Unknown HotStreakHandler state");
    end
end

local function recheckTalents(self)
    local hasHotStreakTalent = HotStreakHandler:hasHotStreakTalent();
    if not hasHotStreakTalent and HotStreakHandler.state == 'heating_up' then
        -- Just lost the Hot Streak talent, and a Heating Up proc is there: bank it
        HotStreakHandler.state = 'cold';
        HotStreakHandler.banked = true;
        deactivateHeatingUp(self, heatingUpSpellID);
    elseif not hasHotStreakTalent and HotStreakHandler.state == 'hot_streak_heating_up' then
        -- Just lost the Hot Streak talent, and a the double Heating Up + Hot Streak proc is there: bank Heating Up
        HotStreakHandler.state = 'hot_streak';
        HotStreakHandler.banked = true;
        deactivateHeatingUp(self, hotStreakHeatingUpSpellID);
    elseif hasHotStreakTalent and HotStreakHandler.banked then
        -- Just gained the Hot Streak talent, and a Heating Up proc was banked: 'unbank' it
        -- Note: we don't ever go back to hot_streak_heating_up because we assume the mage cannot swap specs twice before Hot Streak fades
        HotStreakHandler.state = 'heating_up';
        HotStreakHandler.banked = false;
        activateHeatingUp(self, heatingUpSpellID);
    end
end


-- Detect if the target is Frozen
local FrozenHandler = {
    -- Constants
    frostbite = { 12494 },
    frost_nova = { 122, 865, 6131, 10230, 27088, 42917 },
    freezing_trap = { 3355, 14308, 14309 }, -- from hunters
    freeze = { 33395 }, -- from Frost Elemental
    shattered_barrier = { 55080 },
    ice_lance = { 30455, 42913, 42914 },
    ice_lance_sod = { 400640 }, -- Season of Discovery
    deep_freeze = { 44572 }, -- Deep Freeze is both a debuff for 'Frozen' Spell Alert and its own Glowing Button

    freezeID = 5276, -- Not really a 'Frozen' spell ID, but the name should help players identify the intent
    freezeTalent = 5276,
    fakeSpellID = 5276+1000000, -- For option testing

    saoTexture = "frozen_fingers",
    saoScaleFactor = (SAO.IsEra() or SAO.IsTBC()) and 1 or 0.75, -- Scaling down on Wrath because of conflict

    -- Constants that will be initialized at init()
    allSpellIDs = {},
    allSpellNames = {},

    -- Variables
    initialized = false,

    freezable = false,
    frozen = false,

    saoActive = nil,
    gabIceLinceActive = nil,
    gabDeepFreezeActive = nil,

    -- Methods
    init = function(self)
        self:addSpellIDCandidates(self.frostbite);
        self:addSpellIDCandidates(self.frost_nova);
        self:addSpellIDCandidates(self.freezing_trap);
        self:addSpellIDCandidates(self.freeze);
        self:addSpellIDCandidates(self.shattered_barrier);
        self:addSpellIDCandidates(self.deep_freeze);

        self.freezable = self:isTargetFreezable();
        if (self.freezable and self:isTargetFrozen()) then
            self.frozen = true;
            self:activate();
        end

        self.initialized = true;
    end,

    addSpellIDCandidates = function(self, ids)
        for _, id in pairs(ids) do
            local name = GetSpellInfo(id);
            if name then
                self.allSpellIDs[id] = true;
                self.allSpellNames[name] = true;
            end
        end
    end,

    cleu = function(self)
        local _, event, _, _, _, _, _, destGUID = CombatLogGetCurrentEventInfo()

        -- Event must relate to the player's target
        if (not destGUID) or (destGUID ~= UnitGUID("target")) then return end

        -- Event must be about spell auras
        if (event:sub(0,11) ~= "SPELL_AURA_") then return end

        if not self:isTargetFreezable() then
            self.freezable = false;
            self:setFrozen(false);
            return;
        end

        local spellID, spellName = select(12, CombatLogGetCurrentEventInfo());

        if (self.allSpellIDs[spellID]) then
            -- The current event info is related to a spell that can trigger the Frozen effect
            if (event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REFRESH") then
                self.freezable = true;
                self:setFrozen(true);
            elseif (event == "SPELL_AURA_REMOVED") then
                self.freezable = true;
                self:setFrozen(self:isTargetFrozen()); -- Must call isTargetFrozen() in case another spell is freezing
            end
        elseif (spellID == 0 and spellName and self.allSpellNames[spellName]) then
            -- Special case for Classic Era: check spell name instead of spell ID (regression since HC patch)
            self.freezable = true;
            self:setFrozen(self:isTargetFrozen()); -- Must call isTargetFrozen() to make sure spell *ID* is correct
        end
    end,

    isTargetFreezable = function(self)
        return UnitExists("target") and UnitCanAttack("player", "target") and UnitHealth("target") ~= 0;
    end,

    isTargetFrozen = function(self)
        -- Test debuffs on target with following code
        -- /run for i=1,40 do a,_,_,_,_,_,_,_,_,b=UnitDebuff("target",i) if a then print(i,a,b) end end
        for i = 1,200 do -- 200 is a security to prevent infinite loops
            local name, _, _, _, _, _, _, _, _, id = UnitDebuff("target", i);
            if not name then
                return false;
            end
            if self.allSpellIDs[id] then
                return true;
            end
        end
    end,

    longestFrozenTime = function(self)
        local longestTime, durationOfLongestTime = 0, 0;
        for i = 1,200 do -- 200 is a security to prevent infinite loops
            local name, _, _, _, duration, expirationTime, _, _, _, id = UnitDebuff("target", i);
            if not name then
                break;
            end
            if self.allSpellIDs[id] and expirationTime > longestTime then
                longestTime = expirationTime;
                durationOfLongestTime = duration;
            end
        end
        local startTime, endTime = longestTime-durationOfLongestTime, longestTime;
        return startTime, endTime;
    end,

    getEndTime = function(self)
        if not SAO.Frame.useTimer then
            return; -- Return nil if there is no timer effect, to save CPU
        end

        local startTime, endTime = self:longestFrozenTime();
        return { startTime = startTime, endTime = endTime }
    end,

    retarget = function(self, ...)
        if (self.freezable ~= self:isTargetFreezable()) then
            self.freezable = not self.freezable;
        end
        self:setFrozen(self.freezable and self:isTargetFrozen());
    end,

    checkTargetHealth = function(self)
        if (self.freezable ~= self:isTargetFreezable()) then
            self.freezable = not self.freezable;
            -- Check isTargetFrozen() only when 'freezable' changes, to avoid unnecessary computations
            self:setFrozen(self.freezable and self:isTargetFrozen());
        end
    end,

    setFrozen = function(self, frozen)
        if frozen and not self.frozen then
            self.frozen = true;
            self:activate();
        elseif not frozen and self.frozen then
            self.frozen = false;
            self:deactivate();
        elseif frozen and self.frozen then
            self:reactivate();
        end
    end,

    activate = function(self)
        -- SAO
        local saoOption = SAO:GetOverlayOptions(self.freezeID);
        local hasSAO = not saoOption or type(saoOption[0]) == "nil" or saoOption[0];
        if (hasSAO) then
            local endTime = self:getEndTime();
            SAO:ActivateOverlay(0, self.freezeID, SAO.TexName[self.saoTexture], "Top (CW)", self.saoScaleFactor, 255, 255, 255, false, nil, endTime);
        end

        -- GABs
        local gabOption = SAO:GetGlowingOptions(self.freezeID);
        local iceLance = self.ice_lance[1];
        local hasIceLanceGAB = not gabOption or type(gabOption[iceLance]) == "nil" or gabOption[iceLance];
        if (hasIceLanceGAB) then
            SAO:AddGlow(iceLance, self.ice_lance); -- First arg is option ID, second arg is spell ID list
        end
        local iceLanceSoD = self.ice_lance_sod[1];
        local hasIceLanceSoDGAB = not gabOption or type(gabOption[iceLanceSoD]) == "nil" or gabOption[iceLanceSoD];
        if (hasIceLanceSoDGAB) then
            SAO:AddGlow(iceLanceSoD, self.ice_lance_sod); -- First arg is option ID, second arg is spell ID list
        end
        local deepFreeze = self.deep_freeze[1];
        local hasDeepFreezeGAB = not gabOption or type(gabOption[deepFreeze]) == "nil" or gabOption[deepFreeze];
        if (hasDeepFreezeGAB) then
            SAO:AddGlow(deepFreeze, self.deep_freeze); -- First arg is option ID, second arg is spell ID list
        end
    end,

    deactivate = function(self)
        -- SAO
        SAO:DeactivateOverlay(self.freezeID);

        -- GAB
        SAO:RemoveGlow(self.ice_lance[1]);
        SAO:RemoveGlow(self.ice_lance_sod[1]);
        SAO:RemoveGlow(self.deep_freeze[1]);
    end,

    reactivate = function(self)
        -- SAO
        local saoOption = SAO:GetOverlayOptions(self.freezeID);
        local hasSAO = not saoOption or type(saoOption[0]) == "nil" or saoOption[0];
        if (hasSAO) then
            local endTime = self:getEndTime();
            SAO:RefreshOverlayTimer(self.freezeID, endTime);
        end
    end,
}

local function customLogin(self, ...)
    -- Must initialize class on PLAYER_LOGIN instead of registerClass
    -- Because we need the talent tree, which is not always available right off the bat
    local hotStreakSpellName = GetSpellInfo(hotStreakSpellID);
    if (hotStreakSpellName) then
        HotStreakHandler:init(hotStreakSpellName);
    end

    if (not FrozenHandler.initialized) then
        FrozenHandler:init();
    end
end

local function customCLEU(self, ...)
    hotStreakCLEU(self, ...);
    if FrozenHandler.initialized then
        FrozenHandler:cleu();
    end
end

local function retarget(self, ...)
    if FrozenHandler.initialized then
        FrozenHandler:retarget(...);
    end
end

local function unitHealth(self, unitID)
    if FrozenHandler.initialized and unitID == "target" then
        FrozenHandler:checkTargetHealth();
    end
end

local function lazyCreateClearcastingVariants(self)
    if (clearcastingVariants) then
        return;
    end

    local spellID = 12536;

    local textureVariant1 = "genericarc_05";
    local textureVariant2 = "genericarc_02";

    self:MarkTexture(textureVariant1);
    self:MarkTexture(textureVariant2);

    local weakText = PET_BATTLE_COMBAT_LOG_DAMAGE_WEAK:gsub("[ ()]","");
    local strongText = PET_BATTLE_COMBAT_LOG_DAMAGE_STRONG:gsub("[ ()]","");

    clearcastingVariants = self:CreateTextureVariants(spellID, 0, {
        self:TextureVariantValue(textureVariant1, false, weakText),
        self:TextureVariantValue(textureVariant2, false, strongText),
    });
end

local function registerClass(self)
    -- Fire Procs
    self:RegisterAura("impact", 0, 64343, "lock_and_load", "Top", 1, 255, 255, 255, true, { (GetSpellInfo(2136)) });
    self:RegisterAura("firestarter", 0, 54741, "impact", "Top", 0.8, 255, 255, 255, true, { (GetSpellInfo(2120)) }); -- May conflict with Impact location
    self:RegisterAura("hot_streak_full", 0, hotStreakSpellID, "hot_streak", "Left + Right (Flipped)", 1, 255, 255, 255, true, { (GetSpellInfo(11366)) });
    self:RegisterAura("hot_streak_half", 0, heatingUpSpellID, "hot_streak", "Left + Right (Flipped)", 0.5, 255, 255, 255, false); -- Does not exist, but define it for option testing
    self:RegisterAura("hot_streak_duo", 0, hotStreakHeatingUpSpellID, "hot_streak", "Left + Right (Flipped)", 0.5, 255, 255, 255, false); -- Does not exist, but define it for option testing
    self:RegisterAura("hot_streak_duo", 0, hotStreakHeatingUpSpellID, "hot_streak", "Left + Right (Flipped)", 1, 255, 255, 255, true); -- Does not exist, but define it for option testing
    -- Heating Up (spellID == 48107) doesn't exist in Wrath Classic, so we can't use the above aura
    -- Instead, we track Fire Blast, Fireball, Living Bomb and Scorch non-periodic critical strikes
    -- Please look at HotStreakHandler and customCLEU for more information

    -- Frost Procs
    if self.IsWrath() then
        local iceLanceAndDeepFreeze = { (GetSpellInfo(FrozenHandler.ice_lance[1])), (GetSpellInfo(FrozenHandler.deep_freeze[1])) };
        self:RegisterAura("fingers_of_frost_1", 1, 74396, "frozen_fingers", "Left", 1, 255, 255, 255, true, iceLanceAndDeepFreeze);
        self:RegisterAura("fingers_of_frost_2", 2, 74396, "frozen_fingers", "Left + Right (Flipped)", 1, 255, 255, 255, true, iceLanceAndDeepFreeze);
    elseif self.IsSoD() then
        local iceLanceSoD = { (GetSpellInfo(FrozenHandler.ice_lance_sod[1])) };
        self:RegisterAura("fingers_of_frost_1_sod", 1, 400670, "frozen_fingers", "Left", 1, 255, 255, 255, true, iceLanceSoD);
        self:RegisterAura("fingers_of_frost_2_sod", 2, 400670, "frozen_fingers", "Left + Right (Flipped)", 1, 255, 255, 255, true, iceLanceSoD);
    end
    self:RegisterAura("freeze", 0, FrozenHandler.fakeSpellID, FrozenHandler.saoTexture, "Top (CW)", FrozenHandler.saoScaleFactor, 255, 255, 255, false);
    self:RegisterAura("brain_freeze", 0, 57761, "brain_freeze", "Top", 1, 255, 255, 255, true, { (GetSpellInfo(133)), (GetSpellInfo(44614)) });

    -- Arcane Procs
    self:RegisterAura("missile_barrage", 0, 44401, "arcane_missiles", "Left + Right (Flipped)", 1, 255, 255, 255, true, { (GetSpellInfo(5143)) });

    lazyCreateClearcastingVariants(self);
    self:RegisterAura("clearcasting", 0, 12536, clearcastingVariants.textureFunc, "Left + Right (Flipped)", 1.5, 192, 192, 192, false);

    if self.IsSoD() then
        local arcaneBlastSoDBuff = 400573;
        local arcaneMissiles = 5143;
        local arcaneExplosion = 1449;
        -- local arcaneHealingSpellTBD = ...; -- @todo add healing spell that resets stacks, which might exist, according to the in-game tooltip
        local resettingSpells = { (GetSpellInfo(arcaneMissiles)), (GetSpellInfo(arcaneExplosion)) };
        for nbStacks=1,4 do
            local scale = nbStacks == 4 and 1.2 or 0.6; -- 60%, 60%, 60%, 120%
            local pulse = nbStacks == 4;
            local glowIDs = nbStacks == 4 and resettingSpells or nil;
            local texture = ({ "arcane_missiles_1", "arcane_missiles_2", "arcane_missiles_3", "arcane_missiles" })[nbStacks];
            self:RegisterAura("serendipity_sod", nbStacks, arcaneBlastSoDBuff, texture, "Left + Right (Flipped)", scale, 255, 255, 255, pulse, glowIDs);
        end
    end
end

local function loadOptions(self)
--    local clearcastingTalent = 11213; -- Real talent
    local clearcastingTalent = 12536; -- Use buff instead of talent because everyone knows the buff name
    local clearcastingBuff = 12536;

    local missileBarrageBuff = 44401;
    local missileBarrageTalent = 44404;

    local heatingUpBuff = heatingUpSpellID; -- Not really a buff
    local hotStreakBuff = hotStreakSpellID;
    local hotStreakHeatingUpBuff = hotStreakHeatingUpSpellID; -- Made up
    local hotStreakTalent = 44445;

    local firestarterBuff = 54741;
    local firestarterTalent = 44442;

    local impactBuff = 64343;
    local impactTalent = 11103;

    local brainFreezeBuff = 57761;
    local brainFreezeTalent = 44546;

    local fingersOfFrostBuff = 74396;
    local fingersOfFrostTalent = 44543;
    local fingersOfFrostSoDBuff = 400670;
    local fingersOfFrostSoDTalent = fingersOfFrostSoDBuff; -- Not really a talent

    local arcaneBlastSoDBuff = 400573;

    local arcaneMissiles = 5143;
    local arcaneExplosion = 1449;
    local pyroblast = 11366;
    local flamestrike = 2120;
    local fireBlast = 2136;
    local fireball = 133;
    local frostfireBolt = 44614;
    local iceLance = FrozenHandler.ice_lance[1];
    local iceLanceSoD = FrozenHandler.ice_lance_sod[1];
    local deepFreeze = FrozenHandler.deep_freeze[1];

    local heatingUpDetails;
    local locale = GetLocale();
    if (locale == "deDE") then
        heatingUpDetails = "Aufwärmen";
    elseif (locale == "frFR") then
        heatingUpDetails = "Réchauffement";
    elseif (locale == "esES" or locale == "esMX") then
        heatingUpDetails = "Calentamiento"; -- Always use esES because esMX isn't on Wowhead
    elseif (locale == "ruRU") then
        heatingUpDetails = "Разогрев";
    elseif (locale == "itIT") then
        heatingUpDetails = "Riscaldamento";
    elseif (locale == "ptBR") then
        heatingUpDetails = "Aquecendo";
    elseif (locale == "koKR") then
        heatingUpDetails = "열기";
    elseif (locale == "zhCN" or locale == "zhTW") then
        heatingUpDetails = "热力迸发"; -- Always use zhCN because zhTW isn't on Wowhead
    else
        heatingUpDetails = "Heating Up";
    end

    -- local spellName, _, spellIcon = GetSpellInfo(pyroblast);
    -- local hotStreakDetails = string.format(LFG_READY_CHECK_PLAYER_IS_READY, "|T"..spellIcon..":0|t "..spellName):gsub("%.", "");
    local hotStreakDetails = GetSpellInfo(hotStreakBuff);

    -- local hotStreakHeatingUpDetails = string.format("%s+%s", heatingUpDetails, hotStreakDetails);
    local hotStreakHeatingUpDetails = string.format("%s %s", STATUS_TEXT_BOTH, ACTION_SPELL_AURA_APPLIED_DOSE);

    local oneToThreeStacks = string.format(CALENDAR_TOOLTIP_DATE_RANGE, "1", string.format(STACKS, 3));
    local fourStacks = string.format(STACKS, 4);

    -- Clearcasting variants
    lazyCreateClearcastingVariants(self);

    self:AddOverlayOption(clearcastingTalent, clearcastingBuff, 0, nil, clearcastingVariants);
    self:AddOverlayOption(missileBarrageTalent, missileBarrageBuff);
    if self.IsSoD() then
        self:AddOverlayOption(arcaneBlastSoDBuff, arcaneBlastSoDBuff, 0, oneToThreeStacks, nil, 3); -- setup any stacks, test with 3 stacks
        self:AddOverlayOption(arcaneBlastSoDBuff, arcaneBlastSoDBuff, 4); -- setup 4 stacks
    end
    self:AddOverlayOption(hotStreakTalent, heatingUpBuff, 0, heatingUpDetails);
    self:AddOverlayOption(hotStreakTalent, hotStreakBuff, 0, hotStreakDetails);
    self:AddOverlayOption(hotStreakTalent, hotStreakHeatingUpBuff, 0, hotStreakHeatingUpDetails);
    self:AddOverlayOption(firestarterTalent, firestarterBuff);
    self:AddOverlayOption(impactTalent, impactBuff);
    if self.IsWrath() then
        self:AddOverlayOption(fingersOfFrostTalent, fingersOfFrostBuff, 0, nil, nil, 2); -- setup any stacks, test with 2 stacks
    elseif self.IsSoD() then
        self:AddOverlayOption(fingersOfFrostSoDTalent, fingersOfFrostSoDBuff, 0, nil, nil, 2); -- setup any stacks, test with 2 stacks
    end
    self:AddOverlayOption(FrozenHandler.freezeTalent, FrozenHandler.freezeID, 0, nil, nil, nil, FrozenHandler.fakeSpellID);
    self:AddOverlayOption(brainFreezeTalent, brainFreezeBuff);

    self:AddGlowingOption(missileBarrageTalent, missileBarrageBuff, arcaneMissiles);
    if self.IsSoD() then
        self:AddGlowingOption(arcaneBlastSoDBuff, arcaneBlastSoDBuff, arcaneMissiles, fourStacks);
        self:AddGlowingOption(arcaneBlastSoDBuff, arcaneBlastSoDBuff, arcaneExplosion, fourStacks);
    end
    self:AddGlowingOption(hotStreakTalent, hotStreakBuff, pyroblast);
    self:AddGlowingOption(firestarterTalent, firestarterBuff, flamestrike);
    if not self.IsEra() then -- Must exclude this option specifically for Classic Era, because the talent exists in Era but the proc is passive
        self:AddGlowingOption(impactTalent, impactBuff, fireBlast);
    end
    self:AddGlowingOption(brainFreezeTalent, brainFreezeBuff, fireball);
    self:AddGlowingOption(brainFreezeTalent, brainFreezeBuff, frostfireBolt);
    if self.IsWrath() then
        self:AddGlowingOption(fingersOfFrostTalent, fingersOfFrostBuff, iceLance);
        self:AddGlowingOption(fingersOfFrostTalent, fingersOfFrostBuff, deepFreeze);
        -- self:AddGlowingOption(fingersOfFrostTalent, fingersOfFrostBuff, ...); -- Maybe add more spell options for Fingers of Frost
        self:AddGlowingOption(FrozenHandler.freezeTalent, FrozenHandler.freezeID, iceLance);
        self:AddGlowingOption(FrozenHandler.freezeTalent, FrozenHandler.freezeID, deepFreeze);
    elseif self.IsSoD() then
        self:AddGlowingOption(fingersOfFrostSoDTalent, fingersOfFrostSoDBuff, iceLanceSoD);
        self:AddGlowingOption(FrozenHandler.freezeTalent, FrozenHandler.freezeID, iceLanceSoD);
    end
end

SAO.Class["MAGE"] = {
    ["Register"] = registerClass,
    ["LoadOptions"] = loadOptions,
    ["COMBAT_LOG_EVENT_UNFILTERED"] = customCLEU,
    ["PLAYER_LOGIN"] = customLogin,
    ["CHARACTER_POINTS_CHANGED"] = recheckTalents,
    ["PLAYER_TARGET_CHANGED"] = retarget,
    ["UNIT_HEALTH"] = unitHealth,
    [SAO.IsWrath() and "PLAYER_TALENT_UPDATE" or "CHARACTER_POINTS_CHANGED"] = recheckTalents, -- Event changed in Wrath
}

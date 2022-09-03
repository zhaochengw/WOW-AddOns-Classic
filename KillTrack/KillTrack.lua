--[[
    * Copyright (c) 2011-2020 by Adam Hellberg.
    *
    * This file is part of KillTrack.
    *
    * KillTrack is free software: you can redistribute it and/or modify
    * it under the terms of the GNU General Public License as published by
    * the Free Software Foundation, either version 3 of the License, or
    * (at your option) any later version.
    *
    * KillTrack is distributed in the hope that it will be useful,
    * but WITHOUT ANY WARRANTY; without even the implied warranty of
    * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    * GNU General Public License for more details.
    *
    * You should have received a copy of the GNU General Public License
    * along with KillTrack. If not, see <http://www.gnu.org/licenses/>.
--]]

local NAME, KT = ...

_G[NAME] = KT

-- Upvalue some functions used in CLEU
local UnitGUID = UnitGUID
local UnitIsTapDenied = UnitIsTapDenied
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local GetServerTime = GetServerTime

local NO_NAME = "<No Name>"

KT.Name = NAME
KT.Version = GetAddOnMetadata(NAME, "Version")
KT.Events = {}
KT.Global = {}
KT.CharGlobal = {}
KT.Temp = {}
KT.Sort = {
    Desc = 0,
    Asc = 1,
    CharDesc = 2,
    CharAsc = 3,
    AlphaD = 4,
    AlphaA = 5,
    IdDesc = 6,
    IdAsc = 7
}
KT.Session = {
    Count = 0,
    Kills = {}
}
KT.Messages = {
    Announce = "[KillTrack] Session Length: %s. Session Kills: %d. Kills Per Minute: %.2f."
}

KT.Defaults = {
    DateTimeFormat = "%Y-%m-%d %H:%M:%S"
}

local ET

local KTT = KT.Tools

local FirstDamage = {} -- Tracks first damage to a mob registered by CLEU
local LastDamage = {} -- Tracks whoever did the most recent damage to a mob
local DamageValid = {} -- Determines if mob is tapped by player/group

local Units = {
    "target",
    "targetpet",
    "focus",
    "focuspet",
    "pet",
    "mouseover",
    "mouseoverpet",
}

local combat_log_damage_events = {}
do
    local prefixes = { "SWING", "RANGE", "SPELL", "SPELL_PERIODIC", "SPELL_BUILDING" }
    local suffixes = { "DAMAGE", "DRAIN", "LEECH", "INSTAKILL" }
    for _, prefix in pairs(prefixes) do
        for _, suffix in pairs(suffixes) do
            combat_log_damage_events[prefix .. "_" .. suffix] = true
        end
    end
end

for i = 1, 40 do
    if i <= 4 then
        Units[#Units + 1] = "party" .. i
        Units[#Units + 1] = "partypet" .. i
    end
    Units[#Units + 1] = "raid" .. i
    Units[#Units + 1] = "raidpet" .. i
end

for i = 1, #Units * 2 do
    Units[#Units + 1] = Units[i] .. "target"
end

if KT.Version == "@" .. "project-version" .. "@" then
    KT.Version = "Development"
    KT.Debug = true
end

local function FindUnitByGUID(guid)
    for i = 1, #Units do
        if UnitGUID(Units[i]) == guid then return Units[i] end
    end
    return nil
end

function KT:OnEvent(_, event, ...)
    if self.Events[event] then
        self.Events[event](self, ...)
    end
end

function KT.Events.ADDON_LOADED(self, ...)
    local name = (select(1, ...))
    if name ~= NAME then return end
    ET = KT.ExpTracker
    if type(_G["KILLTRACK"]) ~= "table" then
        _G["KILLTRACK"] = {}
    end
    self.Global = _G["KILLTRACK"]
    if type(self.Global.LOAD_MESSAGE) ~= "boolean" then
        self.Global.LOAD_MESSAGE = false
    end
    if type(self.Global.PRINTKILLS) ~= "boolean" then
        self.Global.PRINTKILLS = false
    end
    if type(self.Global.PRINTNEW) ~= "boolean" then
        self.Global.PRINTNEW = false
    end
    if type(self.Global.ACHIEV_THRESHOLD) ~= "number" then
        self.Global.ACHIEV_THRESHOLD = 1000
    end
    if type(self.Global.COUNT_GROUP) ~= "boolean" then
        self.Global.COUNT_GROUP = false
    end
    if type(self.Global.SHOW_EXP) ~= "boolean" then
        self.Global.SHOW_EXP = false
    end
    if type(self.Global.MOBS) ~= "table" then
        self.Global.MOBS = {}
    end
    if type(self.Global.IMMEDIATE) ~= "table" then
        self.Global.IMMEDIATE = {}
    end
    if type(self.Global.IMMEDIATE.POSITION) ~= "table" then
        self.Global.IMMEDIATE.POSITION = {}
    end
    if type(self.Global.IMMEDIATE.THRESHOLD) ~= "number" then
        self.Global.IMMEDIATE.THRESHOLD = 0
    end
    if type(self.Global.BROKER) ~= "table" then
        self.Global.BROKER = {}
    end
    if type(self.Global.BROKER.SHORT_TEXT) ~= "boolean" then
        self.Global.BROKER.SHORT_TEXT = false
    end
    if type(self.Global.BROKER.MINIMAP) ~= "table" then
        self.Global.BROKER.MINIMAP = {}
    end
    if type(self.Global.DISABLE_DUNGEONS) ~= "boolean" then
        self.Global.DISABLE_DUNGEONS = false
    end
    if type(self.Global.DISABLE_RAIDS) ~= "boolean" then
        self.Global.DISABLE_RAIDS = false
    end
    if type(self.Global.TOOLTIP) ~= "boolean" then
        self.Global.TOOLTIP = true
    end
    if type(self.Global.DATETIME_FORMAT) ~= "string" then
        self.Global.DATETIME_FORMAT = self.Defaults.DateTimeFormat
    end
    if type(_G["KILLTRACK_CHAR"]) ~= "table" then
        _G["KILLTRACK_CHAR"] = {}
    end
    self.CharGlobal = _G["KILLTRACK_CHAR"]
    if type(self.CharGlobal.MOBS) ~= "table" then
        self.CharGlobal.MOBS = {}
    end
    self.PlayerName = UnitName("player")

    if self.Global.LOAD_MESSAGE then
        self:Msg("AddOn Loaded!")
    end

    self.Session.Start = time()
    self.Broker:OnLoad()
end

function KT.Events.COMBAT_LOG_EVENT_UNFILTERED(self)
    local _, event, _, _, s_name, _, _, d_guid, d_name, _, _ = CombatLogGetCurrentEventInfo()
    if combat_log_damage_events[event] then
        if FirstDamage[d_guid] == nil then
            -- s_name is (probably) the player who first damaged this mob and probably has the tag
            FirstDamage[d_guid] = s_name
        end

        LastDamage[d_guid] = s_name

        if not DamageValid[d_guid] then
            -- if DamageValid returns true for a GUID, we can tell with 100% certainty that it's valid
            -- But this relies on one of the valid unit names currently being the damaged mob

            local d_unit = FindUnitByGUID(d_guid)

            if not d_unit then return end

            DamageValid[d_guid] = not UnitIsTapDenied(d_unit)
        end

        return
    end

    if event ~= "UNIT_DIED" then return end

    -- Perform solo/group checks
    local d_id = KTT:GUIDToID(d_guid)
    local firstDamage = FirstDamage[d_guid] or "<No One>"
    local lastDamage = LastDamage[d_guid] or "<No One>"
    local firstByPlayer = firstDamage == self.PlayerName or firstDamage == UnitName("pet")
    local firstByGroup = self:IsInGroup(firstDamage)
    local lastByPlayer = lastDamage == self.PlayerName or lastDamage == UnitName("pet")
    local pass

    -- All checks after DamageValid should be safe to remove
    -- The checks after DamageValid are also not 100% failsafe
    -- Scenario: You deal the killing blow to an already tapped mob <- Would count as kill with current code

    -- if DamageValid[guid] is set, it can be used to decide if the kill was valid with 100% certainty
    if DamageValid[d_guid] ~= nil then
        pass = DamageValid[d_guid]
    else
        -- The one who dealt the very first bit of damage was probably the one who got the tag on the mob
        -- This should apply in most (if not all) situations and is probably a safe fallback when we couldn't
        -- retrieve tapped status from GUID->Unit
        pass = firstByPlayer or firstByGroup
    end

    if not self.Global.COUNT_GROUP and pass and not lastByPlayer then
        pass = false -- Player or player's pet did not deal the killing blow and addon only tracks player kills
    end

    if not pass or d_id == nil or d_id == 0 then return end
    FirstDamage[d_guid] = nil
    DamageValid[d_guid] = nil
    self:AddKill(d_id, d_name)
    if self.Timer:IsRunning() then
        self.Timer:SetData("Kills", self.Timer:GetData("Kills", true) + 1)
    end
end

function KT.Events.CHAT_MSG_COMBAT_XP_GAIN(self, message)
    ET:CheckMessage(message)
end

function KT.Events.ENCOUNTER_START(self, _, _, _, size)
    if (self.Global.DISABLE_DUNGEONS and size == 5) or (self.Global.DISABLE_RAIDS and size > 5) then
        self.Frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self.Frame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
        self.Frame:UnregisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
    end
end

function KT.Events.ENCOUNTER_END(self, _, _, _, size)
    if (self.Global.DISABLE_DUNGEONS and size == 5) or (self.Global.DISABLE_RAIDS and size > 5) then
        self.Frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        self.Frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
        self.Frame:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
    end
end

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
    if not KT.Global.TOOLTIP then return end
    local _, unit = self:GetUnit()
    if not unit then return end
    if UnitIsPlayer(unit) then return end
    local id = KTT:GUIDToID(UnitGUID(unit))
    if not id then return end
    if UnitCanAttack("player", unit) then
        local mob, charMob = KT:InitMob(id, UnitName(unit))
        local gKills, cKills = mob.Kills, charMob.Kills --self:GetKills(id)
        local exp = mob.Exp
        self:AddLine(("Killed %d (%d) times."):format(cKills, gKills), 1, 1, 1)
        if KT.Global.SHOW_EXP and exp then
            local toLevel = exp > 0 and math.ceil((UnitXPMax("player") - UnitXP("player")) / exp) or "N/A"
            self:AddLine(("EXP: %d (%s kills to level)"):format(exp, toLevel), 1, 1, 1)
        end
    end
    if KT.Debug then
        self:AddLine(("ID = %d"):format(id))
    end
    self:Show()
end)

function KT:ToggleLoadMessage()
    self.Global.LOAD_MESSAGE = not self.Global.LOAD_MESSAGE
    if self.Global.LOAD_MESSAGE then
        KT:Msg("Now showing message on AddOn load")
    else
        KT:Msg("No longer showing message on AddOn load")
    end
end

function KT:ToggleExp()
    self.Global.SHOW_EXP = not self.Global.SHOW_EXP
    if self.Global.SHOW_EXP then
        KT:Msg("Now showing EXP on tooltips!")
    else
        KT:Msg("No longer showing EXP on tooltips.")
    end
end

function KT:ToggleDebug()
    self.Debug = not self.Debug
    if self.Debug then
        KT:Msg("Debug enabled!")
    else
        KT:Msg("Debug disabled!")
    end
end

function KT:IsInGroup(unit)
    if unit == self.PlayerName then return true end
    if UnitInParty(unit) then return true end
    if UnitInRaid(unit) then return true end
    return false
end

function KT:SetThreshold(threshold)
    if type(threshold) ~= "number" then
        error("KillTrack.SetThreshold: Argument #1 (threshold) must be of type 'number'")
    end
    self.Global.ACHIEV_THRESHOLD = threshold
    if threshold > 0 then
        self:ResetAchievCount()
        KT:Msg(("New kill notice (achievement) threshold set to %d."):format(threshold))
    else
        KT:Msg("Kill notices have been disabled (set threshold to a value greater than 0 to re-enable).")
    end
end

function KT:SetImmediateThreshold(threshold)
    if type(threshold) ~= "number" then
        error("KillTrack.SetImmediateThreshold: Argument #1 (threshold) must be of type 'number'")
    end
    self.Global.IMMEDIATE.THRESHOLD = threshold
    if threshold > 0 then
        KT:Msg(("New immediate threshold set to %d."):format(threshold))
    else
        KT:Msg("Immediate threshold disabled.")
    end
end

function KT:SetImmediateFilter(filter)
    if type(filter) ~= "string" then
        error("KillTrack.SetImmediateFilter: Argument #1 (filter) must be of type 'string'")
    end
    self.Global.IMMEDIATE.FILTER = filter
    KT:Msg("New immediate filter set to: " .. filter)
end

function KT:ClearImmediateFilter()
    self.Global.IMMEDIATE.FILTER = nil
    KT:Msg("Immediate filter cleared!")
end

function KT:ToggleCountMode()
    self.Global.COUNT_GROUP = not self.Global.COUNT_GROUP
    if self.Global.COUNT_GROUP then
        KT:Msg("Now counting kills for every player in the group (party/raid)!")
    else
        KT:Msg("Now counting your own killing blows ONLY.")
    end
end

function KT:InitMob(id, name)
    name = name or NO_NAME

    if type(self.Global.MOBS[id]) ~= "table" then
        self.Global.MOBS[id] = { Name = name, Kills = 0, AchievCount = 0 }
        if self.Global.PRINTNEW then
            self:Msg(("Created new entry for %q"):format(name))
        end
    elseif self.Global.MOBS[id].Name ~= name then
        self.Global.MOBS[id].Name = name
    end

    if type(self.CharGlobal.MOBS[id]) ~= "table" then
        self.CharGlobal.MOBS[id] =  { Name = name, Kills = 0 }
        if self.Global.PRINTNEW then
            self:Msg(("Created new entry for %q on this character."):format(name))
        end
    elseif self.CharGlobal.MOBS[id].Name ~= name then
        self.CharGlobal.MOBS[id].Name = name
    end

    return self.Global.MOBS[id], self.CharGlobal.MOBS[id]
end

function KT:AddKill(id, name)
    name = name or NO_NAME
    local current_time = GetServerTime()
    self:InitMob(id, name)
    local globalMob = self.Global.MOBS[id]
    local charMob = self.CharGlobal.MOBS[id]
    globalMob.Kills = self.Global.MOBS[id].Kills + 1
    globalMob.LastKillAt = current_time
    charMob.Kills = self.CharGlobal.MOBS[id].Kills + 1
    charMob.LastKillAt = current_time
    if self.Global.PRINTKILLS then
        local kills = self.Global.MOBS[id].Kills
        local cKills = self.CharGlobal.MOBS[id].Kills
        self:Msg(("Updated %q, new kill count: %d. Kill count on this character: %d"):format(name, kills, cKills))
    end
    self:AddSessionKill(name)
    if self.Immediate.Active then
        local filter = self.Global.IMMEDIATE.FILTER
        local filterPass = not filter or name:match(filter)
        if filterPass then
            self.Immediate:AddKill()
            if self.Global.IMMEDIATE.THRESHOLD > 0 and self.Immediate.Kills % self.Global.IMMEDIATE.THRESHOLD == 0 then
                PlaySound(SOUNDKIT.RAID_WARNING)
                PlaySound(SOUNDKIT.PVP_THROUGH_QUEUE)
                RaidNotice_AddMessage(
                    RaidWarningFrame,
                    ("%d KILLS!"):format(self.Immediate.Kills),
                    ChatTypeInfo.SYSTEM)
            end
        end
    end
    if self.Global.ACHIEV_THRESHOLD <= 0 then return end
    if type(self.Global.MOBS[id].AchievCount) ~= "number" then
        self.Global.MOBS[id].AchievCount = floor(self.Global.MOBS[id].Kills / self.Global.ACHIEV_THRESHOLD)
        if self.Global.MOBS[id].AchievCount >= 1 then
            self:KillAlert(self.Global.MOBS[id])
        end
    else
        local achievCount = self.Global.MOBS[id].AchievCount
        self.Global.MOBS[id].AchievCount = floor(self.Global.MOBS[id].Kills / self.Global.ACHIEV_THRESHOLD)
        if self.Global.MOBS[id].AchievCount > achievCount then
            self:KillAlert(self.Global.MOBS[id])
        end
    end
end

function KT:SetKills(id, name, globalCount, charCount)
    if type(id) ~= "number" then
        error("'id' argument must be a number")
    end

    if type(globalCount) ~= "number" then
        error("'globalCount' argument must be a number")
    end

    if type(charCount) ~= "number" then
        error("'charCount' argument must be a number")
    end

    name = name or NO_NAME

    self:InitMob(id, name)
    self.Global.MOBS[id].Kills = globalCount
    self.CharGlobal.MOBS[id].Kills = charCount

    self:Msg(("Updated %q to %d global and %d character kills"):format(name, globalCount, charCount))
end

function KT:AddSessionKill(name)
    if self.Session.Kills[name] then
        self.Session.Kills[name] = self.Session.Kills[name] + 1
    else
        self.Session.Kills[name] = 1
    end
    self.Session.Count = self.Session.Count + 1
end

function KT:SetExp(name, exp)
    for _, mob in pairs(self.Global.MOBS) do
        if mob.Name == name then mob.Exp = tonumber(exp) end
    end
end

function KT:GetSortedSessionKills(max)
    max = tonumber(max) or 3
    local t = {}
    for k,v in pairs(self.Session.Kills) do
        t[#t + 1] = {Name = k, Kills = v}
    end
    table.sort(t, function(a, b) return a.Kills > b.Kills end)
    -- Trim table to only contain 3 entries
    local trimmed = {}
    local c = 0
    for i,v in ipairs(t) do
        trimmed[i] = v
        c = c + 1
        if c >= max then break end
    end
    return trimmed
end

function KT:ResetSession()
    wipe(self.Session.Kills)
    self.Session.Count = 0
    self.Session.Start = time()
end

function KT:GetKills(id)
    local gKills, cKills = 0, 0
    local mob = self.Global.MOBS[id]
    if type(mob) == "table" then
        gKills = mob.Kills
        local cMob = self.CharGlobal.MOBS[id]
        if type(cMob) == "table" then
            cKills = cMob.Kills
        end
    end
    return gKills, cKills
end

function KT:GetTotalKills()
    local count = 0
    for _, mob in pairs(self.Global.MOBS) do
        count = count + mob.Kills
    end
    return count
end

function KT:GetSessionStats()
    if not self.Session.Start then return 0, 0, 0 end
    local now = time()
    local session = now - self.Session.Start
    local kps = session == 0 and 0 or self.Session.Count / session
    local kpm = kps * 60
    local kph = kpm * 60
    return kps, kpm, kph, session
end

function KT:PrintKills(identifier)
    local found = false
    local name = NO_NAME
    local gKills = 0
    local cKills = 0
    local lastKillAt = nil
    if type(identifier) ~= "string" and type(identifier) ~= "number" then identifier = NO_NAME end
    for k,v in pairs(self.Global.MOBS) do
        if type(v) == "table" and (tostring(k) == tostring(identifier) or v.Name == identifier) then
            name = v.Name
            gKills = v.Kills
            if type(v.LastKillAt) == "number" then
                lastKillAt = KTT:FormatDateTime(v.LastKillAt)
            end
            if self.CharGlobal.MOBS[k] then
                cKills = self.CharGlobal.MOBS[k].Kills
            end
            found = true
        end
    end
    if found then
        self:Msg(("You have killed %q %d times in total, %d times on this character"):format(name, gKills, cKills))
        if lastKillAt then
            self:Msg(("Last killed at %s"):format(lastKillAt))
        end
    else
        if UnitExists("target") and not UnitIsPlayer("target") then
            identifier = UnitName("target")
        end
        self:Msg(("Unable to find %q in mob database."):format(tostring(identifier)))
    end
end

function KT:Announce(target)
    if target == "GROUP" then
        target = ((IsInRaid() and "RAID") or (IsInGroup() and "PARTY")) or "SAY"
    end
    local _, kpm, _, length = self:GetSessionStats()
    local msg = self.Messages.Announce:format(KTT:FormatSeconds(length), self.Session.Count, kpm)
    SendChatMessage(msg, target)
end

function KT:Msg(msg)
    DEFAULT_CHAT_FRAME:AddMessage("\124cff00FF00[KillTrack]\124r " .. msg)
end

function KT:KillAlert(mob)
    local data = {
        Text = ("%d kills on %s!"):format(mob.Kills, mob.Name),
        Title = "Kill Record!",
        bTitle = "Congratulations!",
        Icon = "Interface\\Icons\\ABILITY_Deathwing_Bloodcorruption_Death",
        FrameStyle = "GuildAchievement"
    }
    if IsAddOnLoaded("Glamour") then
        if not _G.GlamourShowAlert then
            KT:Msg("ERROR: GlamourShowAlert == nil! Notify AddOn developer.")
            return
        end
        _G.GlamourShowAlert(500, data)
    else
        RaidNotice_AddMessage(RaidBossEmoteFrame, data.Text, ChatTypeInfo.SYSTEM)
        RaidNotice_AddMessage(RaidBossEmoteFrame, data.Text, ChatTypeInfo.SYSTEM)
    end
    self:Msg(data.Text)
end

function KT:GetMob(id)
    for k,v in pairs(self.Global.MOBS) do
        if type(v) == "table" and (tostring(k) == tostring(id) or v.Name == id) then
            return v, self.CharGlobal.MOBS[k]
        end
    end
    return false, nil
end

function KT:GetSortedMobTable(mode, filter, caseSensitive)
    if not tonumber(mode) then mode = self.Sort.Desc end
    if mode < 0 or mode > 7 then mode = self.Sort.Desc end
    if filter and filter == "" then filter = nil end
    local t = {}
    for k,v in pairs(self.Global.MOBS) do
        assert(type(v) == "table", "Unexpected mob entry type in db: " .. type(v) .. ". Expected table")
        local matches = nil
        if filter then
            local name = caseSensitive and v.Name or v.Name:lower()
            filter = caseSensitive and filter or filter:lower()
            local status, result = pcall(string.match, name, filter)
            matches = status and result
        end
        if matches or not filter then
            local cKills = 0
            if self.CharGlobal.MOBS[k] and type(self.CharGlobal.MOBS[k]) == "table" then
                cKills = self.CharGlobal.MOBS[k].Kills
            end
            local entry = {Id = k, Name = v.Name, gKills = v.Kills, cKills = cKills}
            table.insert(t, entry)
        end
    end
    local function compare(a, b)
        if mode == self.Sort.Asc then
            return a.gKills < b.gKills
        elseif mode == self.Sort.CharDesc then
            return a.cKills > b.cKills
        elseif mode == self.Sort.CharAsc then
            return a.cKills < b.cKills
        elseif mode == self.Sort.AlphaD then
            return a.Name > b.Name
        elseif mode == self.Sort.AlphaA then
            return a.Name < b.Name
        elseif mode == self.Sort.IdDesc then
            return a.Id > b.Id
        elseif mode == self.Sort.IdAsc then
            return a.Id < b.Id
        else
            return a.gKills > b.gKills -- Descending
        end
    end
    table.sort(t, compare)
    return t
end

function KT:Delete(id, charOnly)
    id = tonumber(id)
    if not id then error(("Expected 'id' param to be number, got %s."):format(type(id))) end
    local found = false
    local name
    if self.Global.MOBS[id] then
        name = self.Global.MOBS[id].Name
        if not charOnly then self.Global.MOBS[id] = nil end
        if self.CharGlobal.MOBS[id] then
            self.CharGlobal.MOBS[id] = nil
        end
        found = true
    end
    if found then
        self:Msg(("Deleted %q (%d) from database."):format(name, id))
        StaticPopup_Show("KILLTRACK_FINISH", 1)
    else
        self:Msg(("ID: %d was not found in the database."):format(id))
    end
end

function KT:Purge(threshold)
    local count = 0
    for k,v in pairs(KT.Global.MOBS) do
        if type(v) == "table" and v.Kills < threshold then
            self.Global.MOBS[k] = nil
            count = count + 1
        end
    end
    for k,v in pairs(KT.CharGlobal.MOBS) do
        if type(v) == "table" and v.Kills < threshold then
            self.CharGlobal.MOBS[k] = nil
            count = count + 1
        end
    end
    self:Msg(("Purged %d entries with a kill count below %d"):format(count, threshold))
    self.Temp.Threshold = nil
    StaticPopup_Show("KILLTRACK_FINISH", tostring(count))
end

function KT:Reset()
    local count = #KT.Global.MOBS + #KT.CharGlobal.MOBS
    wipe(self.Global.MOBS)
    wipe(self.CharGlobal.MOBS)
    KT:Msg(("%d mob entries have been removed!"):format(count))
    StaticPopup_Show("KILLTRACK_FINISH", tostring(count))
end

function KT:ResetAchievCount()
    for _,v in pairs(self.Global.MOBS) do
        v.AchievCount = floor(v.Kills / self.Global.ACHIEV_THRESHOLD)
    end
end

KT.Frame = CreateFrame("Frame")

for k,_ in pairs(KT.Events) do
    KT.Frame:RegisterEvent(k)
end

KT.Frame:SetScript("OnEvent", function(_, event, ...) KT:OnEvent(_, event, ...) end)

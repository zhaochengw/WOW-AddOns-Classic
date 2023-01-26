--- Kaliel's Tracker
--- Copyright (c) 2012-2023, Marouan Sabbagh <mar.sabbagh@gmail.com>
--- All Rights Reserved.
---
--- This file is part of addon Kaliel's Tracker.

local addonName, KT = ...

-- Lua API
local floor = math.floor
local fmod = math.fmod
local format = string.format
local next = next
local pairs = pairs
local strfind = string.find
local strlen = string.len
local strsub = string.sub
local tonumber = tonumber

-- Version
function KT.IsHigherVersion(newVersion, oldVersion)
    local result = false
    local _, _, nV1, nV2, nV3 = strfind(newVersion, "(%d+)%.(%d+)%.(%d+)")
    local _, _, oV1, oV2, oV3 = strfind(oldVersion, "(%d+)%.(%d+)%.(%d+)")
    nV1, nV2, nV3 = tonumber(nV1), tonumber(nV2), tonumber(nV3)
    oV1, oV2, oV3 = tonumber(oV1), tonumber(oV2), tonumber(oV3)
    if nV1 == oV1 then
        if nV2 == oV2 then
            if nV3 > oV3 then
                result = true
            end
        else
            if nV2 > oV2 then
                result = true
            end
        end
    else
        if nV1 > oV1 then
            result = true
        end
    end
    return result
end

-- Debug
function KT.Debug(text)
    return "\n|cffff6060"..KT.title.." "..KT.db.global.version.." - DEBUG:|r\n|cff00ff00Please copy this error and report it on CurseForge addon page!|r\n"..text
end

-- Table
function KT.IsTableEmpty(table)
    return (next(table) == nil)
end

function KT.IsInTable(table, item)
    local result = false
    for _, v in pairs(table) do
        if v == item then
            result = true
            break
        end
    end
    return result
end

function KT.PrintTable(tbl, indent)
    if not indent then indent = 0 end
    local toprint = "{\n"
    indent = indent + 2
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent)
        if (type(k) == "number") then
            toprint = toprint .. "[" .. k .. "] = "
        elseif (type(k) == "string") then
            toprint = toprint  .. k ..  " = "
        end
        if (type(v) == "number") then
            toprint = toprint .. v .. ",\n"
        elseif (type(v) == "string") then
            toprint = toprint .. "\"" .. v .. "\",\n"
        elseif (type(v) == "table") then
            toprint = toprint .. KT.PrintTable(v, indent) .. ",\n"
        else
            toprint = toprint .. tostring(v) .. ",\n"
        end
    end
    toprint = toprint .. string.rep(" ", indent - 2) .. "}"
    return toprint
end

-- Quest
function KT.GetIDByQuestLogIndex(questLogIndex)
    return select(8, GetQuestLogTitle(questLogIndex))
end

function KT.QuestUtils_GetQuestName(questID)
    local questIndex = GetQuestLogIndexByID(questID)
    local questName
    if questIndex and questIndex > 0 then
        questName = GetQuestLogTitle(questIndex)
    else
        questName = C_QuestLog.GetQuestInfo(questID)
    end
    return questName or ""
end

function KT.QuestUtils_GetQuestZone(id)
    local numEntries, _ = GetNumQuestLogEntries()
    local headerName
    for i=1, numEntries do
        local title, _, _, isHeader, _, _, _, questID = GetQuestLogTitle(i)
        if isHeader then
            headerName = title
        else
            if id == questID then
                return headerName
            end
        end
    end
    return nil
end

function KT_GetQuestWatchInfo(questLogIndex)
    local title, level, _, _, _, isComplete, _, questID, startEvent, _, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden = GetQuestLogTitle(questLogIndex)
    local numObjectives = GetNumQuestLeaderBoards(questLogIndex)
    local requiredMoney = GetQuestLogRequiredMoney(questLogIndex)
    local isAutoComplete = nil
    local failureTime = nil
    local timeElapsed = nil
    local questType = nil
    return questID, level, title, questLogIndex, numObjectives, requiredMoney, isComplete, startEvent, isAutoComplete, failureTime, timeElapsed, questType, isTask, isBounty, isStory, isOnMap, hasLocalPOI, isHidden
end

-- Map
function KT.GetMapContinents()
    return C_Map.GetMapChildrenInfo(946, Enum.UIMapType.Continent, true)
end

function KT.GetCurrentMapAreaID()
    return C_Map.GetBestMapForUnit("player")
end

function KT.GetCurrentMapContinent()
    local mapID = C_Map.GetBestMapForUnit("player")
    return MapUtil.GetMapParentInfo(mapID, Enum.UIMapType.Continent, true) or {}
end

function KT.GetMapContinent(mapID)
    return MapUtil.GetMapParentInfo(mapID, Enum.UIMapType.Continent, true) or {}
end

function KT.GetMapNameByID(mapID)
    local mapInfo = C_Map.GetMapInfo(mapID) or {}
    return mapInfo.name or ""
end

function KT.SetMapToCurrentZone()
    local mapID = C_Map.GetBestMapForUnit("player")
    WorldMapFrame:SetMapID(mapID)
end

function KT.SetMapByID(mapID)
    WorldMapFrame:SetMapID(mapID)
end

-- RGB to Hex
local function DecToHex(num)
    local b, k, hex, d = 16, "0123456789abcdef", "", 0
    while num > 0 do
        d = fmod(num, b) + 1
        hex = strsub(k, d, d)..hex
        num = floor(num/b)
    end
    hex = (hex == "") and "0" or hex
    return hex
end

function KT.RgbToHex(color)
    local r, g, b = DecToHex(color.r*255), DecToHex(color.g*255), DecToHex(color.b*255)
    r = (strlen(r) < 2) and "0"..r or r
    g = (strlen(g) < 2) and "0"..g or g
    b = (strlen(b) < 2) and "0"..b or b
    return r..g..b
end

-- GameTooltip
local colorNotUsable = { r = 1, g = 0, b = 0 }
function KT.GameTooltip_AddQuestRewardsToTooltip(tooltip, questID, isBonus)
    local bckQuestLogSelection = GetQuestLogSelection()  -- backup Quest Log selection
    local questLogIndex = GetQuestLogIndexByID(questID)
    SelectQuestLogEntry(questLogIndex)	-- for num Choices

    local xp = GetQuestLogRewardXP(questID)
    local money = GetQuestLogRewardMoney(questID)
    local artifactXP = 0  -- GetQuestLogRewardArtifactXP(questID)
    local numQuestCurrencies = GetNumQuestLogRewardCurrencies(questID)
    local numQuestRewards = GetNumQuestLogRewards(questID)
    local numQuestSpellRewards = GetNumQuestLogRewardSpells(questID)
    local numQuestChoices = GetNumQuestLogChoices()
    local honor = GetQuestLogRewardHonor(questID)
    local playerTitle = GetQuestLogRewardTitle()
    if xp > 0 or
            money > 0 or
            artifactXP > 0 or
            numQuestCurrencies > 0 or
            numQuestRewards > 0 or
            numQuestSpellRewards > 0 or
            numQuestChoices > 0 or
            honor > 0 or
            playerTitle then
        tooltip:AddLine(" ")
        tooltip:AddLine(REWARDS..":")
        if not isBonus then
            -- choices
            for i = 1, numQuestChoices do
                local name, texture, numItems, quality, isUsable = GetQuestLogChoiceInfo(i)
                local text
                if numItems > 1 then
                    text = format(BONUS_OBJECTIVE_REWARD_WITH_COUNT_FORMAT, texture, HIGHLIGHT_FONT_COLOR:WrapTextInColorCode(numItems), name)
                elseif texture and name then
                    text = format(BONUS_OBJECTIVE_REWARD_FORMAT, texture, name)
                end
                if text then
                    local color = isUsable and ITEM_QUALITY_COLORS[quality] or colorNotUsable
                    tooltip:AddLine(text, color.r, color.g, color.b)
                end
            end
        end
        -- spells
        for i = 1, numQuestSpellRewards do
            local texture, name = GetQuestLogRewardSpell(i, questID)
            if name and texture then
                tooltip:AddLine(format(BONUS_OBJECTIVE_REWARD_FORMAT, texture, name), 1, 1, 1)
            end
        end
        -- items
        for i = 1, numQuestRewards do
            local name, texture, numItems, quality, isUsable = GetQuestLogRewardInfo(i, questID)
            local text
            if numItems > 1 then
                text = format(BONUS_OBJECTIVE_REWARD_WITH_COUNT_FORMAT, texture, HIGHLIGHT_FONT_COLOR:WrapTextInColorCode(numItems), name)
            elseif texture and name then
                text = format(BONUS_OBJECTIVE_REWARD_FORMAT, texture, name)
            end
            if text then
                local color = isUsable and ITEM_QUALITY_COLORS[quality] or colorNotUsable
                tooltip:AddLine(text, color.r, color.g, color.b)
            end
        end
        -- xp
        if xp > 0 then
            tooltip:AddLine(format(BONUS_OBJECTIVE_EXPERIENCE_FORMAT, FormatLargeNumber(xp).."|c0000ff00"), 1, 1, 1)
        end
        -- money
        if money > 0 then
            tooltip:AddLine(GetCoinTextureString(money, 12), 1, 1, 1)
        end
        -- artifact power
        if artifactXP > 0 then
            tooltip:AddLine(format(BONUS_OBJECTIVE_ARTIFACT_XP_FORMAT, FormatLargeNumber(artifactXP)), 1, 1, 1)
        end
        -- currencies
        for i = 1, numQuestCurrencies do
            local name, texture, numItems, _, quality = GetQuestLogRewardCurrencyInfo(i, questID)
            if name and texture and numItems and quality then
                local color = ITEM_QUALITY_COLORS[quality]
                tooltip:AddLine(format(BONUS_OBJECTIVE_REWARD_WITH_COUNT_FORMAT, texture, numItems, name), color.r, color.g, color.b)
            end
        end
        -- honor
        if honor > 0 then
            tooltip:AddLine(format("|T%1$s:16:16:0:0:64:64:3:39:1:37|t %2$s %3$s", "Interface\\TargetingFrame\\UI-PVP-"..KT.playerFaction, honor, HONOR), 1, 1, 1)
        end
        -- title
        if playerTitle then
            tooltip:AddLine(HONOR_REWARD_TITLE_TOOLTIP..": |cffe6cc80"..playerTitle.."|r", 1, 1, 1)
        end
    end

    SelectQuestLogEntry(bckQuestLogSelection)  -- restore Quest Log selection
end

-- Icons
function KT.CreateQuestTagIcon(tagName, width, height, xOffset, yOffset, left, right, top, bottom)
    if left then
        return CreateTextureMarkup(QUEST_ICONS_FILE, QUEST_ICONS_FILE_WIDTH, QUEST_ICONS_FILE_HEIGHT, width, height, left, right, top, bottom, xOffset, yOffset)
    else
        return CreateAtlasMarkup(tagName, height, width, xOffset, yOffset)
    end
end

-- UI
function KT.ConvertPixelsToUI(pixels, frameScale)
    local physicalScreenHeight = select(2, GetPhysicalScreenSize());
    return (pixels * 768.0)/(physicalScreenHeight * frameScale);
end

-- Classic - removed functions -----------------------------------------------------------------------------------------

if not GetQuestLogSpecialItemInfo then
    GetQuestLogSpecialItemInfo = function(questLogIndex)
        return nil
    end
end

if not IsQuestLogSpecialItemInRange then
    IsQuestLogSpecialItemInRange = function(questLogIndex)
        return nil
    end
end

if not GetQuestLogSpecialItemCooldown then
    GetQuestLogSpecialItemCooldown = GetActionCooldown
end

if not QuestMapQuestOptions_AbandonQuest then
    QuestMapQuestOptions_AbandonQuest = function(questID)
        local bckQuestLogSelection = GetQuestLogSelection()  -- backup Quest Log selection
        local questLogIndex = GetQuestLogIndexByID(questID)
        SelectQuestLogEntry(questLogIndex)
        SetAbandonQuest()

        local items = GetAbandonQuestItems()
        local title = GetAbandonQuestName()
        if items then
            StaticPopup_Hide("ABANDON_QUEST")
            StaticPopup_Show("ABANDON_QUEST_WITH_ITEMS", title, items)
        else
            StaticPopup_Hide("ABANDON_QUEST_WITH_ITEMS")
            StaticPopup_Show("ABANDON_QUEST", title)
        end

        SelectQuestLogEntry(bckQuestLogSelection)  -- restore Quest Log selection
    end
end

if not OpenAchievementFrameToAchievement then
    function OpenAchievementFrameToAchievement(achievementID)
        WatchFrame_OpenAchievementFrame(_, achievementID)
    end
end
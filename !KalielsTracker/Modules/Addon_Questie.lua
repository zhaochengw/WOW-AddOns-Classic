--- Kaliel's Tracker
--- Copyright (c) 2012-2023, Marouan Sabbagh <mar.sabbagh@gmail.com>
--- All Rights Reserved.
---
--- This file is part of addon Kaliel's Tracker.

local addonName, KT = ...
local M = KT:NewModule(addonName.."_AddonQuestie")
KT.AddonQuestie = M

local _DBG = function(...) if _DBG then _DBG("KT", ...) end end

-- Lua API
local ipairs = ipairs
local pairs = pairs
local tinsert = table.insert

-- WoW API
local _G = _G

local db

local QuestieDB, ZoneDB, QuestieMap, TrackerUtils
local isQuestieDBLoaded = false
local initTicker

--------------
-- Internal --
--------------

local function GetQuestieData()
    if QuestieLoader then
        QuestieDB = QuestieLoader:ImportModule("QuestieDB")
        ZoneDB = QuestieLoader:ImportModule("ZoneDB")
        QuestieMap = QuestieLoader:ImportModule("QuestieMap")
        TrackerUtils = QuestieLoader:ImportModule("TrackerUtils")

        Questie.db.global.trackerEnabled = false

        initTicker = C_Timer.NewTicker(0.1, function()
            if Questie.started then
                isQuestieDBLoaded = true
                ObjectiveTracker_Update(OBJECTIVE_TRACKER_UPDATE_MODULE_QUEST)
                KT.Filters:Init()
                initTicker:Cancel()
                initTicker = nil
            end
        end)
    end
end

local function SetHooks()
    -- Blizzard
    GetQuestLogSpecialItemInfo = function(questLogIndex)
        local link, item, charges, showItemWhenComplete
        if isQuestieDBLoaded then
            local questID = KT.GetIDByQuestLogIndex(questLogIndex)
            local quest = QuestieDB:GetQuest(questID)

            if quest and quest.sourceItemId then
                for bag = 0, NUM_BAG_SLOTS do
                    for slot = 1, C_Container.GetContainerNumSlots(bag) do
                        local itemInfo = C_Container.GetContainerItemInfo(bag, slot)
                        if itemInfo and quest.sourceItemId == itemInfo.itemID then
                            link = itemInfo.hyperlink
                            item = itemInfo.iconFileID
                            charges = itemInfo.stackCount
                            showItemWhenComplete = false
                            break
                        end
                    end
                    if link then break end
                end
            end
        end
        return link, item, charges, showItemWhenComplete
    end

    IsQuestLogSpecialItemInRange = function(questLogIndex)
        local result
        if isQuestieDBLoaded then
            local questID = KT.GetIDByQuestLogIndex(questLogIndex)
            local quest = QuestieDB:GetQuest(questID)

            if quest and quest.sourceItemId then
                local itemName = GetItemInfo(quest.sourceItemId)
                result = IsItemInRange(itemName, "target")
                if result == true then
                    result = 1
                elseif result == false then
                    result = 0
                end
            end
        end
        return result
    end
end

-- Based on modified copy of Questie code :(
local function FlashAllQuestObjectives(quest)
    local toFlash = {}
    -- ugly code
    for _, framelist in pairs(QuestieMap.questIdFrames) do
        for _, frameName in pairs(framelist) do
            local icon = _G[frameName];
            if not icon.miniMapIcon then
                -- todo: move into frame.session
                if icon:IsShown() then
                    icon._hidden_by_flash = true
                    icon:Hide()
                end
            end
        end
    end

    for _, objective in pairs(quest.Objectives) do
        if objective.AlreadySpawned then
            for _, spawn in pairs(objective.AlreadySpawned) do
                if spawn.mapRefs then
                    for _, frame in pairs(spawn.mapRefs) do
                        tinsert(toFlash, frame)
                        if frame._hidden_by_flash then
                            frame:Show()
                        end
                        -- todo: move into frame.session
                        frame._hidden_by_flash = nil
                        frame._size = frame:GetWidth()
                    end
                end
            end
        end
    end

    local flashW = 1
    local flashB = true
    local flashDone = 0
    objectiveFlashTicker = C_Timer.NewTicker(0.1, function()
        for _, frame in pairs(toFlash) do
            frame:SetWidth(frame._size + flashW)
            frame:SetHeight(frame._size + flashW)
        end
        if flashB then
            if flashW < 10 then
                flashW = flashW + (16 - flashW) / 2 + 0.06
                if flashW >= 9.5 then
                    flashB = false
                end
            end
        else
            if flashW > 0 then
                flashW = flashW - 2
                --flashW = (flashW + (-flashW) / 3) - 0.06
                if flashW < 1 then
                    --flashW = 0
                    flashB = true
                    -- ugly code
                    if flashDone > 0 then
                        C_Timer.After(0.1, function()
                            objectiveFlashTicker:Cancel()
                            for _, frame in pairs(toFlash) do
                                frame:SetWidth(frame._size)
                                frame:SetHeight(frame._size)
                                frame._size = nil
                            end
                        end)
                        C_Timer.After(0.5, function()
                            for _, framelist in pairs(QuestieMap.questIdFrames) do
                                for _, frameName in pairs(framelist) do
                                    local icon = _G[frameName];
                                    if icon._hidden_by_flash then
                                        icon._hidden_by_flash = nil
                                        icon:Show()
                                    end
                                end
                            end
                        end)
                    end
                    flashDone = flashDone + 1
                end
            end
        end
    end)
end

local function HasMapData(quest)
    local result = false
    if not quest then return result end
    if quest:IsComplete() == 1 then
        if quest.Finisher then
            result = true
        end
    else
        if quest.Objectives then
            for _, objective in pairs(quest.Objectives) do
                if not objective.Completed then
                    if objective.spawnList then
                        for _, spawnData in pairs(objective.spawnList) do
                            for zone, _ in pairs(spawnData.Spawns) do
                                if ZoneDB:GetUiMapIdByAreaId(zone) then
                                    result = true
                                    break
                                end
                            end
                            if result then break end
                        end
                        if result then break end
                    end
                end
            end
        end
    end
    return result
end

local function ShowQuestOnMap(quest)
    local bestSpawn
    local bestZone
    local bestDistance = 999999999
    for _, objective in pairs(quest.Objectives) do
        local spawn, zone, _, _, _, distance = QuestieMap:GetNearestSpawn(objective)
        if spawn then
            if distance < bestDistance then
                bestSpawn = spawn
                bestZone = zone
                bestDistance = distance
            end
        end
    end
    if bestSpawn then
        WorldMapFrame:Show()
        WorldMapFrame:SetMapID(ZoneDB:GetUiMapIdByAreaId(bestZone))
        FlashAllQuestObjectives(quest)
    end
end

local function GetQuestZones(questID)
    local zones = {}
    local quest = QuestieDB:GetQuest(questID)
    if not quest then return zones end
    if quest:IsComplete() == 0 then
        if quest.Objectives then
            for _, objective in pairs(quest.Objectives) do
                if objective.spawnList then
                    for _, spawnData in pairs(objective.spawnList) do
                        for zone, _ in pairs(spawnData.Spawns) do
                            if not KT.IsInTable(zones, ZoneDB:GetUiMapIdByAreaId(zone)) then
                                tinsert(zones, ZoneDB:GetUiMapIdByAreaId(zone))
                            end
                        end
                    end
                end
            end
        end
    elseif quest:IsComplete() == 1 then
        if quest.Finisher then
            local finisher
            if quest.Finisher.Type == "monster" then
                finisher = QuestieDB:GetNPC(quest.Finisher.Id)
            elseif quest.Finisher.Type == "object" then
                finisher = QuestieDB:GetObject(quest.Finisher.Id)
            end
            if finisher and finisher.spawns then
                for zone, _ in pairs(finisher.spawns) do
                    tinsert(zones, ZoneDB:GetUiMapIdByAreaId(zone))
                end
            end
        end
    elseif quest:IsComplete() == -1 then
        if quest.Starts then
            local starter
            if quest.Starts.NPC then
                starter = QuestieDB:GetNPC(quest.Starts.NPC[1])
            elseif quest.Starts.GameObject then
                starter = QuestieDB:GetObject(quest.Starts.GameObject[1])
            end
            if starter and starter.spawns then
                for zone, _ in pairs(starter.spawns) do
                    tinsert(zones, ZoneDB:GetUiMapIdByAreaId(zone))
                end
            end
        end
    end
    return zones
end

--------------
-- External --
--------------

function M:OnInitialize()
    _DBG("|cffffff00Init|r - "..self:GetName(), true)
    db = KT.db.profile
    self.isLoaded = (KT:CheckAddOn("Questie", "7.4.10") and db.addonQuestie)
end

function M:OnEnable()
    _DBG("|cff00ff00Enable|r - "..self:GetName(), true)
    GetQuestieData()
    SetHooks()
end

function M:CreateMenu(info, questID)
    if not self.isLoaded or not isQuestieDBLoaded then return end
    local quest = QuestieDB:GetQuest(questID)

    MSA_DropDownMenu_AddSeparator(info)

    info = MSA_DropDownMenu_CreateInfo()
    info.notCheckable = true
    info.disabled = not HasMapData(quest)

    info.text = "Show on Map"
    info.func = function()
        if quest:IsComplete() == 1 then
            TrackerUtils:ShowFinisherOnMap(quest)
        else
            ShowQuestOnMap(quest)
        end
    end
    MSA_DropDownMenu_AddButton(info, MSA_DROPDOWN_MENU_LEVEL)

    if IsAddOnLoaded("TomTom") then
        info.text = "Set |cff33ff99TomTom|r Waypoint"
        info.func = function()
            local spawn, zone, name = QuestieMap:GetNearestQuestSpawn(quest)
            if spawn then
                TrackerUtils:SetTomTomTarget(name, zone, spawn[1], spawn[2])
            end
        end
        MSA_DropDownMenu_AddButton(info, MSA_DROPDOWN_MENU_LEVEL)
    end
end

function M:GetQuestZones(questID)
    if not self.isLoaded or not isQuestieDBLoaded then return {} end
    return GetQuestZones(questID)
end
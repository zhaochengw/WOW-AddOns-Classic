--- Kaliel's Tracker
--- Copyright (c) 2012-2023, Marouan Sabbagh <mar.sabbagh@gmail.com>
--- All Rights Reserved.
---
--- This file is part of addon Kaliel's Tracker.

local addonName, KT = ...
local M = KT:NewModule(addonName.."_AddonOthers")
KT.AddonOthers = M

local _DBG = function(...) if _DBG then _DBG("KT", ...) end end

-- WoW API
local _G = _G

local db
local OTF = ObjectiveTrackerFrame

local KTwarning = "  |cff00ffffAddon "..KT.title.." is active.  "

StaticPopupDialogs[addonName.."_ReloadUI"] = {
    text = KTwarning,
    button1 = "Reload UI",
    OnAccept = function()
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    preferredIndex = 3,
}

--------------
-- Internal --
--------------

-- ElvUI
local function ElvUI_SetSupport()
    if KT:CheckAddOn("ElvUI", "13.21", true) then
        KT.frame:SetScale(1)
        KT.frame.Buttons:SetScale(1)
        local E = unpack(_G.ElvUI)
        local B = E:GetModule("Blizzard")
        B.QuestWatch_MoveFrames = function() end
        B.QuestWatch_AddQuestClick = function() end
    end
end

-- Tukui
local function Tukui_SetSupport()
    if KT:CheckAddOn("Tukui", "20.37", true) then
        KT.frame:SetScale(1)
        KT.frame.Buttons:SetScale(1)
        local T = unpack(_G.Tukui)
        T.Miscellaneous.ObjectiveTracker.Enable = function() end
    end
end

-- QuestGuru / Classic Quest Log
local function QuestGuru_ClassicQuestLog_SetSupport()
    local ql, prefix
    if IsAddOnLoaded("QuestGuru") then
        ql = QuestGuru
        prefix = "QuestGuru"
    elseif IsAddOnLoaded("Classic Quest Log") then
        ql = ClassicQuestLog
        prefix = "ClassicQuestLog"
    end

    if ql then
        QuestLogFrame = ql
        QuestLog_Update = ql.UpdateLog  -- R

        -- Addon
        ql.scrollFrame.expandAll:Hide()
        ql:ExpandAllOnClick()
        ql.ExpandAllOnClick = function() end

        local bck_ListEntryOnClick = ql.ListEntryOnClick
        function ql:ListEntryOnClick()
            if not self.isHeader then
                bck_ListEntryOnClick(self)
            end
        end

        function ql:ToggleWatch(index)  -- R
            if not db.filterAuto[1] then
                if not index then
                    index = GetQuestLogSelection()
                end
                _QuestLog_ToggleQuestWatch(index)
                QuestLog_Update()
            end
        end

        hooksecurefunc(ql, "UpdateControlButtons", function(self)
            if db.filterAuto[1] then
                self.track:Disable()
            else
                self.track:Enable()
            end
        end)

        -- Kaliel's Tracker
        local getHeightFunc = function(index)
            return QUESTLOG_QUEST_HEIGHT
        end

        function QuestObjectiveTracker_OpenQuestDetails(dropDownButton, questID)  -- R
            local scrollFrame = ql.scrollFrame
            local questLogIndex = GetQuestLogIndexByID(questID)
            ql:ShowWindow()
            QuestLog_Update()
            MSA_HybridScrollFrame_ScrollToIndex(scrollFrame, questLogIndex, getHeightFunc)
            QuestLog_Update()
            local offset = HybridScrollFrame_GetOffset(scrollFrame)
            local button = _G[prefix.."ScrollFrameButton"..(questLogIndex - offset)]
            ql.ListEntryOnClick(button)
        end

        -- HybridScrollFrame
        function MSA_HybridScrollFrame_ScrollToIndex(self, index, getHeightFunc)
            local totalHeight = 0;
            local scrollFrameHeight = self:GetHeight();
            for i = 1, index do
                local entryHeight = getHeightFunc(entry, i);
                if i == index then
                    local offset = 0;
                    -- we don't need to do anything if the entry is fully displayed with the scroll all the way up
                    if ( totalHeight + entryHeight > scrollFrameHeight ) then
                        if ( entryHeight > scrollFrameHeight ) then
                            -- this entry is larger than the entire scrollframe, put it at the top
                            offset = totalHeight;
                        else
                            -- otherwise place it in the center
                            local diff = scrollFrameHeight - entryHeight;
                            offset = totalHeight - diff / 2;
                        end
                        -- because of valuestep our positioning might change
                        -- we'll do the adjustment ourselves to make sure the entry ends up above the center rather than below
                        local valueStep = self.scrollBar:GetValueStep();
                        offset = offset + valueStep - mod(offset, valueStep);
                        -- but if we ended up moving the entry so high up that its top is not visible, move it back down
                        if ( offset > totalHeight ) then
                            offset = offset - valueStep;
                        end
                    end
                    self.scrollBar:SetValue(offset);
                    break;
                end
                totalHeight = totalHeight + entryHeight;
            end
        end
    end
end

--------------
-- External --
--------------

function M:OnInitialize()
    _DBG("|cffffff00Init|r - "..self:GetName(), true)
    db = KT.db.profile
end

function M:OnEnable()
    _DBG("|cff00ff00Enable|r - "..self:GetName(), true)
    ElvUI_SetSupport()
    Tukui_SetSupport()
    QuestGuru_ClassicQuestLog_SetSupport()
end
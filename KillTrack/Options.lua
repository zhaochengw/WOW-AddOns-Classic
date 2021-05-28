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

local _, KT = ...
local KTT = KT.Tools

KT.Options = {
    Panel = CreateFrame("Frame")
}

local Opt = KT.Options

local panel = Opt.Panel

panel.name = "KillTrack"
panel:Hide()

-- Dirty hack to give a name to option checkboxes
local checkCounter = 0

local function checkbox(label, description, onclick)
    local check = CreateFrame(
        "CheckButton",
        "KillTrackOptCheck" .. checkCounter,
        panel,
        "InterfaceOptionsCheckButtonTemplate")
    check:SetScript("OnClick", function(self)
        local checked = self:GetChecked()
        PlaySound(checked and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
        onclick(self, checked and true or false)
    end)
    check.label = _G[check:GetName() .. "Text"]
    check.label:SetText(label)
    check.tooltipText = label
    check.tooltipRequirement = description
    checkCounter = checkCounter + 1
    return check
end

local function button(text, tooltip, onclick)
    local btn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    btn:SetText(text)
    btn.tooltipText = tooltip
    btn:SetScript("OnClick", function(self) onclick(self) end)
    btn:SetHeight(24)
    return btn
end

local function HideBlizzOptions()
    HideUIPanel(InterfaceOptionsFrame)
    HideUIPanel(GameMenuFrame)
end

function Opt:Open()
    InterfaceOptionsFrame_OpenToCategory(panel)
    InterfaceOptionsFrame_OpenToCategory(panel)
end

function Opt:Show()
    local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("KillTrack")

    local printKills = checkbox("Print kill updates to chat",
        "With this enabled, every kill you make is going to be announced locally in the chatbox",
        function(_, checked) KT.Global.PRINT = checked end)
    printKills:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -16)

    local tooltipControl = checkbox("Show mob data in tooltip",
        "With this enabled, KillTrack will print data about mobs in the tooltip",
        function(_, checked) KT.Global.TOOLTIP = checked end)
    tooltipControl:SetPoint("LEFT", printKills, "RIGHT", 180, 0)

    local printNew = checkbox("Print new mob entries to chat",
        "With this enabled, new mobs added to the database will be announced locally in the chat",
        function(_, checked) KT.Global.PRINTNEW = checked end)
    printNew:SetPoint("TOPLEFT", printKills, "BOTTOMLEFT", 0, -8)

    local countGroup = checkbox("Count group kills",
        "With this disabled, only killing blows made by yourself will count",
        function(_, checked) KT.Global.COUNT_GROUP = checked end)
    countGroup:SetPoint("TOPLEFT", printNew, "BOTTOMLEFT", 0, -8)

    local thresholdDesc = self:CreateFontString(nil, "ARTWORK", "ChatFontNormal")
    thresholdDesc:SetPoint("TOPLEFT", countGroup, "BOTTOMLEFT", 0, -8)
    thresholdDesc:SetText("Threshold for displaying kill achievements (press enter to apply)")

    local threshold = CreateFrame("EditBox", "KillTrackOptThreshold", panel, "InputBoxTemplate")
    threshold:SetHeight(22)
    threshold:SetWidth(150)
    threshold:SetPoint("LEFT", thresholdDesc, "RIGHT", 8, 0)
    threshold:SetAutoFocus(false)
    threshold:EnableMouse(true)
    threshold:SetScript("OnEditFocusGained", function(box)
        box:SetTextColor(0, 1, 0)
        box:HighlightText()
    end)
    local function setThreshold(box, enter)
        box:SetTextColor(1, 1, 1)
        local value = tonumber(box:GetNumber())
        if value and value > 0 then
            KT.Global.ACHIEV_THRESHOLD = value
            if not enter then
                KT:Msg("Updated threshold value!")
            end
            box:ClearFocus()
            box:SetText(KT.Global.ACHIEV_THRESHOLD)
        else
            box:SetText(KT.Global.ACHIEV_THRESHOLD)
            box:HighlightText()
        end
    end
    threshold:SetScript("OnEditFocusLost", function(box) setThreshold(box) end)
    threshold:SetScript("OnEnterPressed", function(box) setThreshold(box, true) end)

    local showTarget = button("Target", "Show information about the currently selected target",
        function()
            if not UnitExists("target") or UnitIsPlayer("target") then return end
            local id = KTT:GUIDToID(UnitGUID("target"))
            KT:PrintKills(id)
        end)
    showTarget:SetWidth(150)
    showTarget:SetPoint("TOPLEFT", thresholdDesc, "BOTTOMLEFT", 0, -8)

    local list = button("List", "Open the mob database",
        function()
            HideBlizzOptions()
            KT.MobList:Show()
        end)
    list:SetWidth(150)
    list:SetPoint("TOPLEFT", showTarget, "TOPRIGHT", 8, 0)

    local purge = button("Purge", "Purge mob entries with a kill count below a specified number",
        function() KT:ShowPurge() end)
    purge:SetWidth(150)
    purge:SetPoint("TOPLEFT", showTarget, "BOTTOMLEFT", 0, -8)

    local reset = button("Reset", "Clear the database of ALL mob entries",
        function() KT:ShowReset() end)
    reset:SetWidth(150)
    reset:SetPoint("TOPLEFT", purge, "TOPRIGHT", 8, 0)

    local minimap = checkbox("Show minimap icon", "Adds the KillTrack broker to your minimap",
        function(_, checked) KT.Broker:SetMinimap(checked) end)
    minimap:SetPoint("TOPLEFT", purge, "BOTTOMLEFT", 0, -8)

    local disableDungeons = checkbox("Disable in dungeons (save CPU)",
        "When this is checked, mob kills in dungeons won't be counted.",
        function(_, checked) KT.Global.DISABLE_DUNGEONS = checked end)
    disableDungeons:SetPoint("TOPLEFT", minimap, "BOTTOMLEFT", 0, -8)

    local disableRaids = checkbox("Disable in raids (save CPU)",
        "When this is checked, mob kills in raids won't be counted.",
        function(_, checked) KT.Global.DISABLE_RAIDS = checked end)
    disableRaids:SetPoint("TOPLEFT", disableDungeons, "BOTTOMLEFT", 0, -8)

    local function init()
        printKills:SetChecked(KT.Global.PRINT)
        tooltipControl:SetChecked(KT.Global.TOOLTIP)
        printNew:SetChecked(KT.Global.PRINTNEW)
        countGroup:SetChecked(KT.Global.COUNT_GROUP)
        threshold:SetText(KT.Global.ACHIEV_THRESHOLD)
        minimap:SetChecked(not KT.Global.BROKER.MINIMAP.hide)
        disableDungeons:SetChecked(KT.Global.DISABLE_DUNGEONS)
        disableRaids:SetChecked(KT.Global.DISABLE_RAIDS)
    end

    init()

    self:SetScript("OnShow", init)
end

panel:SetScript("OnShow", function(self) Opt.Show(self) end)

InterfaceOptions_AddCategory(panel)

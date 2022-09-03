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

KT.Broker = {
    Text = {
        Short = "KPM: %.2f",
        Long = "Kills Per Minute: %.2f"
    }
}

local KTT = KT.Tools
local KTB = KT.Broker

local UPDATE = 1
local t = 0

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local icon = LibStub:GetLibrary("LibDBIcon-1.0")

local frame = CreateFrame("Frame")

local tooltipVisible = false

local data = {
    type = "data source",
    label = KT.Name,
    icon = "Interface\\AddOns\\KillTrack\\icon.tga",
    tocname = KT.Name
}

local clickFunctions = {
    none = {
        LeftButton = function() KT.MobList:Toggle() end,
        MiddleButton = function() KTB:ToggleTextMode() end,
        RightButton = function() KT:ResetSession() end
    },
    ctrl = {
        LeftButton = function() KT:Announce("GROUP") end, -- Announce to group/say
        MiddleButton = function() KT.Immediate:Toggle() end, -- Show the immediate frame
        RightButton = function() KT:Announce("GUILD") end -- Announce to guild
    },
    shift = {
        LeftButton = function() KT.Options:Open() end
    }
}

local obj = ldb:NewDataObject("Broker_KillTrack", data)

function obj:OnTooltipShow()
    self:AddLine(("%s |cff00FF00(%s)|r"):format(KT.Name, KT.Version), 1, 1, 1)
    self:AddLine(" ")
    local _, kpm, kph, length = KT:GetSessionStats()
    self:AddDoubleLine("Session Length", ("|cffFFFFFF%s|r"):format(KTT:FormatSeconds(length)))
    self:AddDoubleLine("Kills Per Minute", ("|cffFFFFFF%.2f|r"):format(kpm))
    self:AddDoubleLine("Kills Per Hour", ("|cffFFFFFF%.2f|r"):format(kph))
    self:AddLine(" ")
    self:AddDoubleLine("Kills this session", ("|cffFFFFFF%d|r"):format(KT.Session.Count), 1, 1, 0)
    local added = 0
    for _, v in pairs(KT:GetSortedSessionKills()) do
        self:AddDoubleLine(v.Name, ("|cffFFFFFF%d|r"):format(v.Kills))
        added = added + 1
    end
    if added <= 0 then
        self:AddLine("No kills this session", 1, 0, 0)
    end
    self:AddLine(" ")
    self:AddDoubleLine("Kills in total", ("|cffFFFFFF%d|r"):format(KT:GetTotalKills()), 1, 1, 0)
    added = 0
    for _, v in pairs(KT:GetSortedMobTable()) do
        self:AddDoubleLine(v.Name, ("|cffFFFFFF%d (%d)|r"):format(v.cKills, v.gKills))
        added = added + 1
        if added >= 3 then break end
    end
    if added <= 0 then
        self:AddLine("No kills recorded yet", 1, 0, 0)
    end
    self:AddLine(" ")
    self:AddDoubleLine("Left Click", "Open mob database", 0, 1, 0, 0, 1, 0)
    self:AddDoubleLine("Middle Click", "Toggle short/long text", 0, 1, 0, 0, 1, 0)
    self:AddDoubleLine("Right Click", "Reset session statistics", 0, 1, 0, 0, 1, 0)
    self:AddDoubleLine("Ctrl + Left Click", "Announce to group/say", 0, 1, 0, 0, 1, 0)
    self:AddDoubleLine("Ctrl + Middle Click", "Toggle immediate frame", 0, 1, 0, 0, 1, 0)
    self:AddDoubleLine("Ctrl + Right Click", "Announce to guild", 0, 1, 0, 0, 1, 0)
    self:AddDoubleLine("Shift + Left Click", "Open options panel", 0, 1, 0, 0, 1, 0)
end

function obj:OnClick(button)
    local mod = ((IsControlKeyDown() and "ctrl") or (IsShiftKeyDown() and "shift")) or "none"
    if not clickFunctions[mod] then return end
    local func = clickFunctions[mod][button]
    if func then func() end
end

function obj:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_NONE")
    GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
    KTB:UpdateTooltip()
    tooltipVisible = true
end

function obj:OnLeave()
    tooltipVisible = false
    GameTooltip:Hide()
end

function KTB:UpdateText()
    local text = KT.Global.BROKER.SHORT_TEXT and self.Text.Short or self.Text.Long
    obj.text = text:format(select(2, KT:GetSessionStats()))
end

function KTB:UpdateTooltip()
    GameTooltip:ClearLines()
    obj.OnTooltipShow(GameTooltip)
    GameTooltip:Show()
end

function KTB:OnUpdate(_, elapsed)
    t = t + elapsed
    if t >= UPDATE then
        self:UpdateText()
        if tooltipVisible then self:UpdateTooltip() end
        t = 0
    end
end

function KTB:ToggleTextMode()
    KT.Global.BROKER.SHORT_TEXT = not KT.Global.BROKER.SHORT_TEXT
    self:UpdateText()
end

function KTB:OnLoad()
    if type(KT.Global.BROKER.MINIMAP.hide) ~= "boolean" then
        KT.Global.BROKER.MINIMAP.hide = true
    end
    icon:Register(KT.Name, obj, KT.Global.BROKER.MINIMAP)
    frame:SetScript("OnUpdate", function(f, elapsed) KTB:OnUpdate(f, elapsed) end)
    self:UpdateText()
end

function KTB:SetMinimap(enabled)
    KT.Global.BROKER.MINIMAP.hide = not enabled
    if enabled then
        icon:Show(KT.Name)
    else
        icon:Hide(KT.Name)
    end
end

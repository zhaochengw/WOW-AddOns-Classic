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

KT.TimerFrame = {
    Running = false
}

local TF = KT.TimerFrame
local T = KT.Timer

local function Enabled(object, enabled)
    if not object.Enable or not object.Disable then return end
    if enabled then
        object:Enable()
    else
        object:Disable()
    end
end

local frame

local function SetupFrame()
    if frame then return end
    frame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
    frame:Hide()
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:SetWidth(200)
    frame:SetHeight(93)

    frame:SetPoint("CENTER")

    local bd = {
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        edgeSize = 16,
        tileSize = 32,
        insets = {
            left = 2.5,
            right = 2.5,
            top = 2.5,
            bottom = 2.5
        }
    }

    frame:SetBackdrop(bd)

    frame:SetScript("OnMouseDown", function(f) f:StartMoving() end)
    frame:SetScript("OnMouseUp", function(f) f:StopMovingOrSizing() end)

    frame.currentLabel = frame:CreateFontString(nil, "OVERLAY", nil)
    frame.currentLabel:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
    frame.currentLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, -6)
    frame.currentLabel:SetText("Number of kills:")

    frame.currentCount = frame:CreateFontString(nil, "OVERLAY", nil)
    frame.currentCount:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
    frame.currentCount:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -6, -6)
    frame.currentCount:SetText("0")

    frame.timeLabel = frame:CreateFontString(nil, "OVERLAY", nil)
    frame.timeLabel:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
    frame.timeLabel:SetPoint("TOPLEFT", frame.currentLabel, "BOTTOMLEFT", 0, -2)
    frame.timeLabel:SetText("Time left:")

    frame.timeCount = frame:CreateFontString(nil, "OVERLAY", nil)
    frame.timeCount:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
    frame.timeCount:SetPoint("TOPRIGHT", frame.currentCount, "BOTTOMRIGHT", 0, -2)
    frame.timeCount:SetText("00:00:00")

    frame.killsPerMinuteLabel = frame:CreateFontString(nil, "OVERLAY", nil)
    frame.killsPerMinuteLabel:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
    frame.killsPerMinuteLabel:SetPoint("TOPLEFT", frame.timeLabel, "BOTTOMLEFT", 0, -2)
    frame.killsPerMinuteLabel:SetText("Kills Per Minute:")

    frame.killsPerMinuteCount = frame:CreateFontString(nil, "OVERLAY", nil)
    frame.killsPerMinuteCount:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
    frame.killsPerMinuteCount:SetPoint("TOPRIGHT", frame.timeCount, "BOTTOMRIGHT", 0, -2)
    frame.killsPerMinuteCount:SetText("0")

    frame.killsPerSecondLabel = frame:CreateFontString(nil, "OVERLAY", nil)
    frame.killsPerSecondLabel:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
    frame.killsPerSecondLabel:SetPoint("TOPLEFT", frame.killsPerMinuteLabel, "BOTTOMLEFT", 0, -2)
    frame.killsPerSecondLabel:SetText("Kills Per Second:")

    frame.killsPerSecondCount = frame:CreateFontString(nil, "OVERLAY", nil)
    frame.killsPerSecondCount:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
    frame.killsPerSecondCount:SetPoint("TOPRIGHT", frame.killsPerMinuteCount, "BOTTOMRIGHT", 0, -2)
    frame.killsPerSecondCount:SetText("Kills Per Minute:")

    frame.cancelButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.cancelButton:SetSize(60, 16)
    frame.cancelButton:SetPoint("BOTTOM", frame, "BOTTOM", -40, 7)
    frame.cancelButton:SetScript("OnLoad", function(self) self:Disable() end)
    frame.cancelButton:SetScript("OnClick", function() TF:Cancel() end)
    frame.cancelButton:SetText("Stop")

    frame.closeButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.closeButton:SetSize(60, 16)
    frame.closeButton:SetPoint("BOTTOM", frame, "BOTTOM", 40, 7)
    frame.closeButton:SetScript("OnLoad", function(self) self:Disable() end)
    frame.closeButton:SetScript("OnClick", function() TF:Close() end)
    frame.closeButton:SetText("Close")

    frame.progressBar = CreateFrame("StatusBar", nil, frame)
    frame.progressBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]], "ARTWORK")
    frame.progressBar:SetStatusBarColor(0, 1, 0)
    frame.progressBar:SetMinMaxValues(0, 1)
    frame.progressBar:SetValue(0)
    frame.progressBar:SetPoint("TOPLEFT", frame.killsPerSecondLabel, "BOTTOMLEFT", -1, -2)
    frame.progressBar:SetPoint("RIGHT", frame.killsPerSecondCount, "RIGHT", 0, 0)
    frame.progressBar:SetPoint("BOTTOM", frame.cancelButton, "TOP", 0, 2)

    frame.progressLabel = frame.progressBar:CreateFontString(nil, "OVERLAY", nil)
    frame.progressLabel:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
    frame.progressLabel:SetAllPoints(frame.progressBar)
    frame.progressLabel:SetText("0%")
end

function TF:InitializeControls()
    frame.currentCount:SetText("0")
    frame.timeCount:SetText("00:00:00")
    frame.progressLabel:SetText("0%")
    frame.progressBar:SetValue(0)
    self:UpdateControls()
end

function TF:UpdateControls()
    Enabled(frame.cancelButton, self.Running)
    Enabled(frame.closeButton, not self.Running)
end

function TF:UpdateData(data, state)
    if state == T.State.START then
        self:InitializeControls()
    else
        local kills = T:GetData("Kills", true)
        local kpm, kps
        if data.Current <= 0 then
            kpm, kps = 0, 0
        else
            kpm = kills / (data.Current / 60)
            kps = kills / data.Current
        end
        frame.currentCount:SetText(kills)
        frame.timeCount:SetText(data.LeftFormat)
        frame.progressLabel:SetText(floor(data.Progress*100) .. "%")
        frame.progressBar:SetMinMaxValues(0, data.Total)
        frame.progressBar:SetValue(data.Current)
        frame.killsPerMinuteCount:SetText(("%.2f"):format(kpm))
        frame.killsPerSecondCount:SetText(("%.2f"):format(kps))
        if state == T.State.STOP then self:Stop() end
    end
    self:UpdateControls()
end

function TF:Start(s, m, h)
    if self.Running then return end
    self.Running = true
    SetupFrame()
    self:InitializeControls()
    frame:Show()
    if not T:Start(s, m, h, function(d, u) TF:UpdateData(d, u) end, nil) then
        self:Stop()
        frame:Hide()
    end
end

function TF:Stop()
    if not self.Running then return end
    self.Running = false
end

function TF:Cancel()
    T:Stop()
end

function TF:Close()
    if not frame then return end
    self:InitializeControls()
    frame:Hide()
end

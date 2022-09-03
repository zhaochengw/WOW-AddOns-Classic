--[[
    * Copyright (c) 2013 by Adam Hellberg.
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

KT.Immediate = {
    Active = false,
    Kills = 0
}

local I = KT.Immediate

local frame

local function SetupFrame()
    if frame then return end
    local G = KT.Global.IMMEDIATE
    frame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
    frame:Hide()
    frame:EnableMouse(true)
    frame:SetMovable(true)
    if G.POSITION.POINT then
        frame:SetPoint(G.POSITION.POINT, UIParent, G.POSITION.RELATIVE, G.POSITION.X, G.POSITION.Y)
    else
        frame:SetPoint("CENTER")
    end
    frame:SetWidth(240)
    frame:SetHeight(30)

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
    frame:SetScript("OnMouseUp", function(f)
        f:StopMovingOrSizing()
        local point, _, relative, x, y = f:GetPoint()
        G.POSITION.POINT = point
        G.POSITION.RELATIVE = relative
        G.POSITION.X = x
        G.POSITION.Y = y
    end)

    frame.killLabel = frame:CreateFontString(nil, "OVERLAY", nil)
    frame.killLabel:SetFont("Fonts\\FRIZQT__.TTF", 16, nil)
    frame.killLabel:SetWidth(100)
    --frame.killLabel:SetHeight(24)
    frame.killLabel:SetPoint("LEFT", frame, "LEFT", 2, 0)
    frame.killLabel:SetText("Kills so far:")

    frame.killCount = frame:CreateFontString(nil, "OVERLAY", nil)
    frame.killCount:SetFont("Fonts\\FRIZQT__.TTF", 16, nil)
    frame.killCount:SetWidth(100)
    --frame.killCount:SetHeight(24)
    frame.killCount:SetPoint("RIGHT", frame, "RIGHT", -68, 0)
    frame.killCount:SetJustifyH("RIGHT")
    frame.killCount:SetText("0")

    frame.closeButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.closeButton:SetWidth(60)
    frame.closeButton:SetHeight(24)
    frame.closeButton:SetPoint("RIGHT", frame, "RIGHT", -3, 0)
    frame.closeButton:SetText("Close")
    frame.closeButton:SetScript("OnClick", function() I:Hide() end)
end

function I:Show()
    if not frame then SetupFrame() end
    self.Kills = 0
    frame.killCount:SetText(self.Kills)
    frame:Show()
    self.Active = true
end

function I:Hide()
    frame:Hide()
    self.Kills = 0
    frame.killCount:SetText(self.Kills)
    self.Active = false
end

function I:Toggle()
    if frame and frame:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end

function I:AddKill()
    self.Kills = self.Kills + 1
    frame.killCount:SetText(tostring(self.Kills))
end

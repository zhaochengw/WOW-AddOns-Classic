--[[
    Appreciate what others people do. (c) Usoltsev

    Copyright (c) <2016-2020>, Usoltsev.

    Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
    Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    Neither the name of the <EasyFrames> nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
    THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
    INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
    OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]

local EasyFrames = LibStub("AceAddon-3.0"):GetAddon("EasyFrames")
local L = LibStub("AceLocale-3.0"):GetLocale("EasyFrames")
local Media = LibStub("LibSharedMedia-3.0")

local MODULE_NAME = "Core"
local Core = EasyFrames:NewModule(MODULE_NAME, "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")

local db
local PartyIterator = EasyFrames.Helpers.Iterator(EasyFrames.Utils.GetPartyFrames())
local BossIterator = EasyFrames.Helpers.Iterator(EasyFrames.Utils.GetBossFrames())

local OnSetPointHookScript = function(point, relativeTo, relativePoint, xOffset, yOffset)
    return function(frame, _, _, _, _, _, flag)
        if flag ~= "EasyFramesHookSetPoint" then
--            if InCombatLockdown() then
--                return
--            end

            frame:ClearAllPoints()
            frame:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset, "EasyFramesHookSetPoint")
        end
    end
end

function Core:OnInitialize()
    self.db = EasyFrames.db
    db = self.db.profile
end

function Core:OnEnable()
    self:RegisterEvent("GROUP_ROSTER_UPDATE", "EventHandler")
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "EventHandler")
    self:RegisterEvent("PLAYER_FOCUS_CHANGED", "EventHandler")
    self:RegisterEvent("UNIT_FACTION", "EventHandler")

    self:SecureHook("TargetFrame_CheckClassification", "CheckClassification")

    self:MoveFramesNames()
    self:MoveToTFrames()
    self:MovePlayerFrameBars()
    self:MoveTargetFrameBars()
    self:MoveFocusFrameBars()
    self:MovePetFrameBars()
    self:MovePartyFrameBars()
    self:MoveBossFrameBars()

    self:MovePlayerFramesBarsTextString()
    self:MoveTargetFramesBarsTextString()
    self:MoveFocusFramesBarsTextString()

    --self:MoveLevelText()

    if (db.general.showWelcomeMessage) then
        print("|cff0cbd0cEasy Frames|cffffffff " .. L["loaded. Options:"] .. " |cff0cbd0c/ef")
    end
end


function Core:EventHandler()
    TargetFrameNameBackground:SetVertexColor(0, 0, 0, 0.0)
    TargetFrameNameBackground:SetHeight(18)

    FocusFrameNameBackground:SetVertexColor(0, 0, 0, 0.0)
    FocusFrameNameBackground:SetHeight(18)
end


function Core:CheckClassification(frame, forceNormalTexture)
    local classification = UnitClassification(frame.unit);

    frame.Background:SetHeight(41)
    frame.nameBackground:SetVertexColor(0, 0, 0, 0.0)

    --[[
    frame.nameBackground:Show();
    frame.manabar:Show();
    frame.manabar.TextString:Show();
    frame.threatIndicator:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
	]] --
    if (forceNormalTexture) then
        frame.borderTexture:SetTexture(Media:Fetch("frames", "default"));
    elseif (classification == "minus") then
        frame.borderTexture:SetTexture(Media:Fetch("frames", "minus"));
        frame.nameBackground:Hide();
        frame.Background:SetHeight(31)
        frame.manabar:Hide();
        frame.manabar.TextString:Hide();
        forceNormalTexture = true;
    elseif (classification == "worldboss" or classification == "elite") then
        frame.borderTexture:SetTexture(Media:Fetch("frames", "elite"));
    elseif (classification == "rareelite") then
        frame.borderTexture:SetTexture(Media:Fetch("frames", "rareelite"));
    elseif (classification == "rare") then
        frame.borderTexture:SetTexture(Media:Fetch("frames", "rare"));
    else
        frame.borderTexture:SetTexture(Media:Fetch("frames", "default"));
        forceNormalTexture = true;
    end
end

function Core:MoveRegion(frame, point, relativeTo, relativePoint, xOffset, yOffset)
    frame:ClearAllPoints()
    frame:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset, "EasyFramesHookSetPoint")

    if (not frame.EasyFramesHookSetPoint) then
        hooksecurefunc(frame, "SetPoint", OnSetPointHookScript(point, relativeTo, relativePoint, xOffset, yOffset))
        frame.EasyFramesHookSetPoint = true
    end
end

function Core:MovePlayerFrameName(point, relativeTo, relativePoint, xOffset, yOffset)
    self:MoveRegion(PlayerName, point or "CENTER", relativeTo or PlayerFrame, relativePoint or "CENTER", xOffset or 52, yOffset or 35)
end

function Core:MoveTargetFrameName(point, relativeTo, relativePoint, xOffset, yOffset)
    self:MoveRegion(TargetFrame.name, point or "CENTER", relativeTo or TargetFrame, relativePoint or "CENTER", xOffset or -51, yOffset or 35)
end

function Core:MoveFocusFrameName(point, relativeTo, relativePoint, xOffset, yOffset)
    self:MoveRegion(FocusFrame.name, point or "CENTER", relativeTo or FocusFrame, relativePoint or "CENTER", xOffset or -51, yOffset or 35)
end

function Core:MoveFramesNames()
    -- Names
    -- Player's frame will set in Player module (with option "Show player name inside the frame")
    self:MoveTargetFrameName()
    self:MoveFocusFrameName()

    self:MoveRegion(PetFrame.name, "CENTER", PetFrame, "CENTER", 15, 17)

    PartyIterator(function(frame)
        local point, relativeTo, relativePoint, xOffset, yOffset = frame.name:GetPoint()

        Core:MoveRegion(frame.name, point, relativeTo, relativePoint, xOffset, yOffset - 3)
    end)

    BossIterator(function(frame)
        local point, relativeTo, relativePoint, xOffset, yOffset = frame.name:GetPoint()

        Core:MoveRegion(frame.name, point, relativeTo, relativePoint, xOffset, yOffset + 20)
    end)
end

function Core:MoveToTFrames()
    -- ToT move
    TargetFrameToT:ClearAllPoints()
    TargetFrameToT:SetPoint("CENTER", TargetFrame, "CENTER", 60, -45)

    FocusFrameToT:ClearAllPoints()
    FocusFrameToT:SetPoint("CENTER", FocusFrame, "CENTER", 60, -45)
end

function Core:MovePlayerFrameBars()
    -- Player bars
    PlayerFrameHealthBar:SetHeight(27)
    PlayerStatusTexture:SetHeight(69)

    self:MoveRegion(PlayerFrameHealthBar, "CENTER", PlayerFrame, "CENTER", 50, 14)
    self:MoveRegion(PlayerFrameManaBar, "CENTER", PlayerFrame, "CENTER", 51, -7)
    --self:MoveRegion(PlayerFrameAlternateManaBarText, "CENTER", PlayerFrameAlternateManaBar, "CENTER", 0, -1)

    PlayerFrameGroupIndicator:ClearAllPoints()
    PlayerFrameGroupIndicator:SetPoint("TOPLEFT", 34, 15)

    PlayerFrameGroupIndicatorLeft:SetAlpha(0)
    PlayerFrameGroupIndicatorRight:SetAlpha(0)
    PlayerFrameGroupIndicatorMiddle:SetAlpha(0)
end

function Core:MoveTargetFrameBars()
    -- Target bars
    TargetFrameHealthBar:SetHeight(27)
    --TargetFrameNumericalThreat:SetScale(0.9)

    self:MoveRegion(TargetFrameHealthBar, "CENTER", TargetFrame, "CENTER", -50, 14)
    self:MoveRegion(TargetFrameTextureFrameDeadText, "CENTER", TargetFrame, "CENTER", -50, 12)
    self:MoveRegion(TargetFrameManaBar, "CENTER", TargetFrame, "CENTER", -51, -7)
    --self:MoveRegion(TargetFrameNumericalThreat, "CENTER", TargetFrame, "CENTER", 44, 48)
end

function Core:MoveFocusFrameBars()
    -- Focus bars
    FocusFrameHealthBar:SetHeight(27)
    --FocusFrameNumericalThreat:SetScale(0.9)

    self:MoveRegion(FocusFrameHealthBar, "CENTER", FocusFrame, "CENTER", -50, 14)
    self:MoveRegion(FocusFrameTextureFrameDeadText, "CENTER", FocusFrame, "CENTER", -50, 12)
    self:MoveRegion(FocusFrameManaBar, "CENTER", FocusFrame, "CENTER", -51, -7)
    --self:MoveRegion(FocusFrameNumericalThreat, "CENTER", FocusFrame, "CENTER", 44, 48)
end

function Core:MovePetFrameBars()
    PetFrameHealthBar:SetHeight(13)

    self:MoveRegion(PetFrameHealthBar, "CENTER", PetFrame, "CENTER", 16, 4)
    self:MoveRegion(PetFrameManaBar, "CENTER", PetFrame, "CENTER", 16, -8)

    self:MoveRegion(PetFrameHealthBar.RightText, "RIGHT", PetFrame, "TOPLEFT", 113, -23)
    self:MoveRegion(PetFrameHealthBar.LeftText, "LEFT", PetFrame, "TOPLEFT", 46, -23)
    self:MoveRegion(PetFrameHealthBar.TextString, "CENTER", PetFrameHealthBar, "CENTER", 0, 0)

    self:MoveRegion(PetFrameManaBar.TextString, "CENTER", PetFrameManaBar, "CENTER", 0, 0)
end

function Core:MovePlayerFramesBarsTextString()
    self:MoveRegion(PlayerFrameHealthBar.RightText, "RIGHT", PlayerFrame, "RIGHT", -8, 12)
    self:MoveRegion(PlayerFrameHealthBar.LeftText, "LEFT", PlayerFrame, "LEFT", 110, 12)
    self:MoveRegion(PlayerFrameHealthBar.TextString, "CENTER", PlayerFrame, "CENTER", 52, 12)

    self:MoveRegion(PlayerFrameManaBar.TextString, "CENTER", PlayerFrame, "CENTER", 52, -8)
end

function Core:MoveTargetFramesBarsTextString()
    self:MoveRegion(TargetFrameHealthBar.RightText, "RIGHT", TargetFrame, "RIGHT", -110, 12)
    self:MoveRegion(TargetFrameHealthBar.LeftText, "LEFT", TargetFrame, "LEFT", 8, 12)
    self:MoveRegion(TargetFrameHealthBar.TextString, "CENTER", TargetFrame, "CENTER", -51, 12)

    self:MoveRegion(TargetFrameManaBar.TextString, "CENTER", TargetFrame, "CENTER", -51, -8)
end

function Core:MoveFocusFramesBarsTextString()
    self:MoveRegion(FocusFrameHealthBar.RightText, "RIGHT", FocusFrame, "RIGHT", -110, 12)
    self:MoveRegion(FocusFrameHealthBar.LeftText, "LEFT", FocusFrame, "LEFT", 8, 12)
    self:MoveRegion(FocusFrameHealthBar.TextString, "CENTER", FocusFrame, "CENTER", -51, 12)

    self:MoveRegion(FocusFrameManaBar.TextString, "CENTER", FocusFrame, "CENTER", -51, -8)
end

function Core:MovePartyFrameBars()
    PartyIterator(function(frame)
        _G[frame:GetName() .. "Background"]:SetVertexColor(0, 0, 0, 0)

        local healthBar = _G[frame:GetName() .. "HealthBar"]
        local manaBar = _G[frame:GetName() .. "ManaBar"]

        healthBar:SetHeight(13)

        Core:MoveRegion(healthBar, "CENTER", frame, "CENTER", 16, 4)
        --Core:MoveRegion(healthBar.TextString, "CENTER", healthBar, "CENTER", 0, 0)
        --Core:MoveRegion(healthBar.RightText, "RIGHT", frame, "RIGHT", -12, 4)
        --Core:MoveRegion(healthBar.LeftText, "LEFT", frame, "LEFT", 46, 4)

        Core:MoveRegion(manaBar, "CENTER", frame, "CENTER", 16, -8)
        --Core:MoveRegion(manaBar.TextString, "CENTER", manaBar, "CENTER", 0, 0)
        --Core:MoveRegion(manaBar.RightText, "RIGHT", frame, "RIGHT", -12, -8)
        --Core:MoveRegion(manaBar.LeftText, "LEFT", frame, "LEFT", 46, -8)
    end)
end

function Core:MoveBossFrameBars()
    BossIterator(function(frame)
        frame.nameBackground:Hide()

        local healthBar = _G[frame:GetName() .. "HealthBar"]

        healthBar:SetHeight(27)

        Core:MoveRegion(healthBar, "TOPRIGHT", frame, "TOPRIGHT", -106, -25)
        --Core:MoveRegion(healthBar.TextString, "CENTER", frame, "CENTER", -50, 12)
        --Core:MoveRegion(healthBar.RightText, "RIGHT", frame, "RIGHT", -110, 12)
        --Core:MoveRegion(healthBar.LeftText, "LEFT", frame, "LEFT", 8, 12)
    end)
end

--function Core:MoveLevelText()
--    Core:MoveRegion(PlayerLevelText, "CENTER", -63, -17)
--    Core:MoveRegion(TargetFrame.levelText, "CENTER", 63, -17)
--end

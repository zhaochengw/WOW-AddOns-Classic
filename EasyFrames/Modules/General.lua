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

local MODULE_NAME = "General"
local General = EasyFrames:NewModule(MODULE_NAME, "AceHook-3.0", "AceEvent-3.0")

local db

local GetFramesHealthBar = EasyFrames.Utils.GetFramesHealthBar
local GetFramesManaBar = EasyFrames.Utils.GetFramesManaBar
local GetAllFrames = EasyFrames.Utils.GetAllFrames

local AllFramesIterator = EasyFrames.Helpers.Iterator(GetAllFrames())
local PartyIterator = EasyFrames.Helpers.Iterator(EasyFrames.Utils.GetPartyFrames())
local BossIterator = EasyFrames.Helpers.Iterator(EasyFrames.Utils.GetBossFrames())

local DEFAULT_BUFF_SIZE = 17

local registeredCombatEvent = false


local function ClassColored(statusbar, unit)
    if (db.general.colorBasedOnCurrentHealth) then
        local value = UnitHealth(unit)
        local min, max = statusbar:GetMinMaxValues()

        local r, g

        if ((value < min) or (value > max)) then
            return
        end

        if ((max - min) > 0) then
            value = (value - min) / (max - min)
        else
            value = 0
        end

        if (value > 0.5) then
            r = (1.0 - value) * 2
            g = 1.0
        else
            r = 1.0
            g = value * 2
        end

        statusbar:SetStatusBarColor(r, g, 0.0)

        return
    end

    if (UnitIsPlayer(unit) and UnitClass(unit)) then
        -- player
        if (db.general.classColored) then
            local _, class, classColor

            _, class = UnitClass(unit)
            classColor = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]

            statusbar:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
        else
            local colors

            if (UnitIsFriend("player", unit)) then
                colors = db.general.friendlyFrameDefaultColors
            else
                colors = db.general.enemyFrameDefaultColors
            end

            statusbar:SetStatusBarColor(colors[1], colors[2], colors[3])
        end
    else
        -- non player

        local colors

        local red, green, _ = UnitSelectionColor(unit)

        if (red == 0) then
            colors = db.general.friendlyFrameDefaultColors
        elseif (green == 0) then
            colors = db.general.enemyFrameDefaultColors
        else
            colors = db.general.neutralFrameDefaultColors
        end

        if (not UnitPlayerControlled(unit) and UnitIsTapDenied(unit)) then
            colors = {0.5, 0.5, 0.5}
        end

        statusbar:SetStatusBarColor(colors[1], colors[2], colors[3])
    end
end


function General:OnInitialize()
    self.db = EasyFrames.db
    db = self.db.profile
end

function General:OnEnable()
    self:SetLightTexture(db.general.lightTexture)

    self:SecureHook("UnitFrameHealthBar_Update", "MakeFramesColored")
    self:SecureHook("HealthBar_OnValueChanged", function(statusbar)
        self:MakeFramesColored(statusbar, statusbar.unit)
    end)

    self:SecureHook("TargetFrame_UpdateAuraPositions", "MakeCustomBuffSize")
    self:SecureHook("TargetFrame_UpdateAuras", "TargetFrame_UpdateAuras")

    if (db.general.barTexture ~= "Blizzard") then
        self:SetFrameBarTexture(db.general.barTexture)
    end

    if (db.general.hideOutOfCombat) then
        self:HideFramesOutOfCombat()

        registeredCombatEvent = true
    end

    self:SetBrightFramesBorder(db.general.brightFrameBorder)

    self:SetMaxBuffCount(db.general.maxBuffCount)
    self:SetMaxDebuffCount(db.general.maxDebuffCount)
end

function General:OnProfileChanged(newDB)
    self.db = newDB
    db = self.db.profile

    self:SetLightTexture(db.general.lightTexture)

    self:SetFramesColored()

    if (db.general.barTexture ~= "Blizzard") then
        self:SetFrameBarTexture(db.general.barTexture)
    end

    self:HideFramesOutOfCombat()

    self:SetBrightFramesBorder(db.general.brightFrameBorder)

    self:SetCustomBuffSize(db.general.customBuffSize)

    self:SetMaxBuffCount(db.general.maxBuffCount)
    self:SetMaxDebuffCount(db.general.maxDebuffCount)
end


function General:ResetFriendlyFrameDefaultColors()
    EasyFrames.db.profile.general.friendlyFrameDefaultColors = {0, 1, 0}
end

function General:ResetEnemyFrameDefaultColors()
    EasyFrames.db.profile.general.enemyFrameDefaultColors = {1, 0, 0}
end

function General:ResetNeutralFrameDefaultColors()
    EasyFrames.db.profile.general.neutralFrameDefaultColors = {1, 1, 0}
end



function General:SetFramesColored()
    local healthBars = GetFramesHealthBar()

    for _, statusbar in pairs(healthBars) do
        if (UnitIsConnected(statusbar.unit)) then
            ClassColored(statusbar, statusbar.unit)
        end
    end
end

function General:MakeFramesColored(statusbar, unit)
    if (unit) then
        if (UnitIsConnected(unit) and unit == statusbar.unit) then
            ClassColored(statusbar, unit)
        end
    end
end

function General:CombatStatusEvent(event)
    if (event == 'PLAYER_REGEN_DISABLED') then
        -- combat
        self:HideFramesOutOfCombat(true)
    else
        -- out of combat
        self:HideFramesOutOfCombat()
    end
end

function General:HideFramesOutOfCombat(forceShow)
    local hide = db.general.hideOutOfCombat
    local opacity = db.general.hideOutOfCombatOpacity

    AllFramesIterator(function(frame)
        if (hide and not forceShow) then
            frame:SetAlpha(opacity)

            if (opacity == 0) then
                if (frame:IsShown()) then
                    frame:Hide()
                    frame.__hiddenByAddon__ = true
                end
            else
                if (frame.__hiddenByAddon__) then
                    frame:Show()
                end
            end
        else
            frame:SetAlpha(1)

            if (frame.__hiddenByAddon__) then
                frame:Show()
            end
        end
    end)

    if (hide and not registeredCombatEvent) then
        self:RegisterEvent("PLAYER_REGEN_DISABLED", "CombatStatusEvent")
        self:RegisterEvent("PLAYER_REGEN_ENABLED", "CombatStatusEvent")
    end
end


function General:SetFrameBarTexture(value)
    local texture = Media:Fetch("statusbar", value)

    local healthBars = GetFramesHealthBar()
    local manaBars = GetFramesManaBar()

    for _, healthbar in pairs(healthBars) do
        healthbar:SetStatusBarTexture(texture)
    end

    --PlayerFrameHealthBar.AnimatedLossBar:SetStatusBarTexture(texture) -- fix for blinking red texture

    for _, manabar in pairs(manaBars) do
        manabar:SetStatusBarTexture(texture)
    end

    if (db.general.forceManaBarTexture) then
        local function manaBarTextureSetter(manaBar)
            if (db.general.forceManaBarTexture) then
                manaBar:SetStatusBarTexture(PlayerFrameManaBar.EasyFramesTexture)
            end
        end

        PlayerFrameManaBar.EasyFramesTexture = texture

        if(not PlayerFrameManaBar.EasyFramesHookUpdateType) then
            hooksecurefunc("UnitFrameManaBar_UpdateType", manaBarTextureSetter)

            PlayerFrameManaBar.EasyFramesHookUpdateType = true
        end
    end
end


function General:SetBrightFramesBorder(value)
    for _, t in pairs({
        PlayerFrameTexture, PlayerFrameAlternateManaBarBorder, PlayerFrameAlternateManaBarRightBorder, PlayerFrameAlternateManaBarLeftBorder,
        TargetFrameTextureFrameTexture, TargetFrameToTTextureFrameTexture,
        PetFrameTexture, FocusFrameTextureFrameTexture, FocusFrameToTTextureFrameTexture,
        PartyMemberFrame1Texture, PartyMemberFrame2Texture, PartyMemberFrame3Texture, PartyMemberFrame4Texture,
        PartyMemberFrame1PetFrameTexture, PartyMemberFrame2PetFrameTexture, PartyMemberFrame3PetFrameTexture, PartyMemberFrame4PetFrameTexture,
        Boss1TargetFrameTextureFrameTexture, Boss2TargetFrameTextureFrameTexture, Boss3TargetFrameTextureFrameTexture, Boss4TargetFrameTextureFrameTexture, Boss5TargetFrameTextureFrameTexture
    }) do
        t:SetVertexColor(value, value, value)
    end
end

function General:SetTexture()
    -- Player
    PlayerFrameTexture:SetTexture(Media:Fetch("frames", "default"))
    PlayerStatusTexture:SetTexture(Media:Fetch("misc", "player-status"))

    -- Target, Focus
    local targetFrames = {
        TargetFrame,
        FocusFrame,
    }

    for _, frame in pairs(targetFrames) do
        EasyFrames:GetModule("Core"):CheckClassification(frame)
    end

    -- Pet
    if (UnitPowerMax("pet") == 0) then
        PetFrameTexture:SetTexture(Media:Fetch("frames", "nomana"))
        --PetFrameFlash:SetTexture(Media:Fetch("frames", "nomana"))
    else
        PetFrameTexture:SetTexture(Media:Fetch("frames", "smalltarget"))
        PetFrameFlash:SetTexture(Media:Fetch("misc", "pet-frame-flash"))
    end

    -- Party
    PartyIterator(function(frame)
        _G[frame:GetName() .. "Texture"]:SetTexture(Media:Fetch("frames", "smalltarget"))

--        _G[frame:GetName() .. "PetFrameTexture"]:SetTexture(Media:Fetch("frames", "smalltarget"))
    end)

    -- Boss
    BossIterator(function(frame)
        frame.borderTexture:SetTexture(Media:Fetch("frames", "boss"))
    end)
end

function General:SetLightTexture(value)
    for key, data in pairs(Media:HashTable("frames")) do
        if (value) then
            Media:HashTable("frames")[key] = data .. "-Light"
        else
            if (string.find(data, "-Light", -7)) then
                Media:HashTable("frames")[key] = string.sub(data, 0, -7)
            end
        end
    end

    self:SetTexture()
end

function General:SetCustomBuffSize(value)

    local frames = {
        TargetFrame,
        FocusFrame
    }

    for _, frame in pairs(frames) do
        local LARGE_AURA_SIZE = db.general.selfBuffSize
        local SMALL_AURA_SIZE = db.general.buffSize

        local buffSize = DEFAULT_BUFF_SIZE
        local frameName
        local icon
        local caster
        local _
        local selfName = frame:GetName()

        for i = 1, MAX_TARGET_BUFFS do
            _, icon, _, _, _, _, caster = UnitBuff(frame.unit, i)
            frameName = selfName .. 'Buff' .. i

            if (icon and (not frame.maxBuffs or i <= frame.maxBuffs)) then
                if (value) then
                    if (caster == 'player') then
                        buffSize = LARGE_AURA_SIZE
                    else
                        buffSize = SMALL_AURA_SIZE
                    end
                end

                _G[frameName]:SetHeight(buffSize)
                _G[frameName]:SetWidth(buffSize)
            end
        end
    end
end

function General:MakeCustomBuffSize(frame, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
    if (db.general.customBuffSize) then
        local AURA_OFFSET = 3
        local LARGE_AURA_SIZE = db.general.selfBuffSize
        local SMALL_AURA_SIZE = db.general.buffSize
        local size
        local offsetY = AURA_OFFSET
        local offsetX = AURA_OFFSET
        local rowWidth = 0
        local firstBuffOnRow = 1

        for i = 1, numAuras do
            if (largeAuraList[i]) then
                size = LARGE_AURA_SIZE
                offsetY = AURA_OFFSET
                offsetX = AURA_OFFSET
            else
                size = SMALL_AURA_SIZE
            end

            if (i == 1) then
                rowWidth = size
--                frame.auraRows = frame.auraRows + 1
            else
                rowWidth = rowWidth + size + offsetX
            end

            if (rowWidth > 121) then
                updateFunc(frame, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY, mirrorAurasVertically)
                rowWidth = size
--                frame.auraRows = frame.auraRows + 1
                firstBuffOnRow = i
                offsetY = AURA_OFFSET
            else
                updateFunc(frame, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY, mirrorAurasVertically)
            end
        end
    end
end

function General:SetHighlightDispelledBuff()
    if (db.general.highlightDispelledBuff) then
        self:TargetFrame_UpdateAuras(TargetFrame)
    else
        self:TargetFrame_UpdateAuras(TargetFrame, true)
    end
end

function General:TargetFrame_UpdateAuras(frame, forceHide)
    local buffFrame, frameStealable, icon, debuffType, isStealable, _
    local selfName = frame:GetName()
    local isEnemy = UnitIsEnemy(PlayerFrame.unit, frame.unit)

    -- Debuffs on top
    if (frame.maxDebuffs > 0 and frame.buffsOnTop) then
        local _, fisrtDebuffIcon = UnitDebuff(frame.unit, 1)
        local _, fisrtBuffIcon = UnitBuff(frame.unit, 1)

        if (fisrtDebuffIcon and not fisrtBuffIcon) then
            local firstDebuffFrame = _G[selfName .. 'Debuff1']
            local point, relativeTo, relativePoint, xOffset, yOffset = firstDebuffFrame:GetPoint()

            firstDebuffFrame:ClearAllPoints()
            firstDebuffFrame:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset + 8)
        end
    end

    for i = 1, MAX_TARGET_BUFFS do
        _, icon, _, debuffType, _, _, _, isStealable = UnitBuff(frame.unit, i)

        if (icon and (not frame.maxBuffs or i <= frame.maxBuffs)) then
            local frameName = selfName .. 'Buff' .. i

            buffFrame = _G[frameName]

            -- Buffs on top
            if (i == 1 and frame.buffsOnTop) then
                local point, relativeTo, relativePoint, xOffset, yOffset = buffFrame:GetPoint()

                buffFrame:ClearAllPoints()
                buffFrame:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset + 8)
            end

            -- Stealable buffs
            if (db.general.highlightDispelledBuff or forceHide) then
                frameStealable = _G[frameName .. 'Stealable']

                local allCanSteal = true
                if (db.general.ifPlayerCanDispelBuff) then
                    allCanSteal = isStealable
                end

                if (isEnemy and debuffType == 'Magic' and allCanSteal and not forceHide) then
                    local buffSize

                    if (db.general.customBuffSize) then
                        buffSize = db.general.buffSize * db.general.dispelledBuffScale
                    else
                        buffSize = DEFAULT_BUFF_SIZE * db.general.dispelledBuffScale
                    end

                    buffFrame:SetHeight(buffSize)
                    buffFrame:SetWidth(buffSize)

                    frameStealable:Show()
                    frameStealable:SetHeight(buffSize * 1.4)
                    frameStealable:SetWidth(buffSize * 1.4)
                elseif (forceHide) then
                    frameStealable:Hide()
                end
            end
        end
    end
end

function General:SetMaxBuffCount(value)
    TargetFrame.maxBuffs = value
    FocusFrame.maxBuffs = value
end

function General:SetMaxDebuffCount(value)
    TargetFrame.maxDebuffs = value
    FocusFrame.maxDebuffs = value
end

function General:SaveFramesPoints()
    db.general.framesPoints = {
        player = {PlayerFrame:GetPoint()},
        target = {TargetFrame:GetPoint()},
        focus = {FocusFrame:GetPoint()},
    }
end

function General:RestoreFramesPoints()
    if (db.general.framesPoints) then
        for _, frame in pairs({
            PlayerFrame,
            TargetFrame,
            FocusFrame
        }) do
            frame:ClearAllPoints()
            frame:SetPoint(unpack(db.general.framesPoints[frame.unit]))
            frame:SetUserPlaced(true)
        end
    end
end

function General:SetFramePoints(frame, x, y)
    local point, relativeTo, relativePoint = frame:GetPoint()

    frame:ClearAllPoints()
    frame:SetPoint(point, relativeTo, relativePoint, x, y)
    frame:SetUserPlaced(true)
end

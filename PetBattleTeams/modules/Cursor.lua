--[[
Callback events

BATTLE_PET_CURSOR_CHANGED
args: operation , petID, teamIndex, petIndex
Operation: "COPY", "SWAP", "MOVE TEAM"

]]

local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local Cursor = PetBattleTeams:NewModule("Cursor")
local teamManager = PetBattleTeams:GetModule("TeamManager")
local MAX_DISTANCE = 400
local TIMEOUT = 15
local PETS_PER_TEAM = 3
local TIMER_WIDTH = 150
local TIMER_HEIGHT = 16
local EMPTY_PET = "0x0000000000000000"

-- luacheck: globals UISpecialFrames

local function OnEvent(self,event,...)
    if event == "BATTLE_PET_CURSOR_CLEAR" then
        Cursor:Clear()
    end
end

local function OnUpdate(self,elapsed)
    self.elapsed = self.elapsed + elapsed
    if self.elapsed > TIMEOUT then
        self.x  = nil
        Cursor:Clear()
        return
    end

    local timerPrecent = 1 - self.elapsed / TIMEOUT
    self.statusbar:SetWidth(timerPrecent * self.statusbar.maxWidth)

    local scale = UIParent:GetEffectiveScale()
    local x, y = GetCursorPosition();
    x = x/scale
    y = y/scale

    if not self.x then
        self.x = x
    end

    self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT",x+20,y+40)
end

function Cursor:Clear()
    self.teamIndex =nil
    self.petIndex = nil
    self.petID = nil
    self.operation = nil
    if self.teamFrame then self.teamFrame:Hide() end
    self.callbacks:Fire("BATTLE_PET_CURSOR_CHANGED")
end

function Cursor:Initialize()
    self.callbacks = LibStub("CallbackHandler-1.0"):New(self)
    self.teamIndex =nil
    self.petIndex = nil
    self.petID = nil
    self.operation = nil
    self.eventFrame = CreateFrame("frame")
    self.eventFrame:SetScript("OnEvent",OnEvent)
    self.eventFrame:RegisterEvent("BATTLE_PET_CURSOR_CLEAR")
    hooksecurefunc(C_PetJournal,"PickupPet",Cursor.PickupPetHook)
    hooksecurefunc("ClearCursor",Cursor.ClearCursorHook)
end

function Cursor:PickupTeam(teamIndex)
    assert(type(teamIndex) == "number")
    if not self.teamFrame then
        local teamFrame = PetBattleTeams.PetBattleTeamsFrame:New()
        self.teamFrame = teamFrame
        _G["CursorTeamFrame"] = teamFrame
        tinsert(UISpecialFrames, "CursorTeamFrame")
        teamFrame:SetParent(UIParent)
        teamFrame:SetScript("OnUpdate",OnUpdate)
        teamFrame:SetFrameStrata("DIALOG")
        teamFrame:SetScript("OnHide",function() self:Clear() end)

        local statusbar = CreateFrame("StatusBar", nil, teamFrame)
        teamFrame.statusbar = statusbar
        statusbar:SetPoint("TOPLEFT", teamFrame.logicalLeft, "BOTTOMLEFT")
        statusbar:SetWidth(teamFrame.logicalLeft:GetWidth()*3)
        statusbar.maxWidth = statusbar:GetWidth()
        statusbar:SetHeight(12)
        statusbar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
        statusbar:GetStatusBarTexture():SetHorizTile(false)
        statusbar:GetStatusBarTexture():SetVertTile(false)
        statusbar:SetStatusBarColor(0, 1, 0)

        statusbar.bg = statusbar:CreateTexture(nil, "BACKGROUND")
        statusbar.bg:SetTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
        statusbar.bg:SetPoint("TOPLEFT", teamFrame.logicalLeft, "BOTTOMLEFT")
        statusbar.bg:SetWidth(statusbar.maxWidth)
        statusbar.bg:SetHeight(12)
        statusbar.bg:SetVertexColor(0, 0.35, 0)
    end

    self.teamFrame.elapsed = 0
    self.teamFrame:SetTeam(teamIndex)
    self.teamFrame:Show()
    self.operation = "MOVE TEAM"
    self.teamIndex = teamIndex
    self.petID = nil
    self.petIndex =nil

    self.callbacks:Fire("BATTLE_PET_CURSOR_CHANGED",self.operation,nil,teamIndex,nil)
end

function Cursor:PickupPet(teamIndex,petIndex)
    assert(type(teamIndex) == "number")
    assert(type(petIndex) == "number" and petIndex <= PETS_PER_TEAM and petIndex > 0)
    if IsControlKeyDown() and not teamManager:GetSortTeams() then
        Cursor:PickupTeam(teamIndex)
        return
    end

    local petID = teamManager:GetPetInfo(teamIndex,petIndex)

    if self.teamFrame then self.teamFrame:Hide() end

    if petID and petID ~= EMPTY_PET then
        C_PetJournal.PickupPet(petID)
        self.operation = "SWAP"
        if IsShiftKeyDown() or teamManager:IsTeamLockedByUser(teamIndex) then
            self.operation = "COPY"
        end

        self.teamIndex =teamIndex
        self.petIndex = petIndex
        self.petID = petID
        self.callbacks:Fire("BATTLE_PET_CURSOR_CHANGED",self.operation,self.petID,teamIndex,petIndex)
    end
end

function Cursor:GetCursorInfo()
    return self.operation, self.petID, self.teamIndex, self.petIndex
end

function Cursor.PickupPetHook(petID,isWild)
    assert(type(petID) == "string")
    if petID == EMPTY_PET then return end
    if Cursor.teamFrame then Cursor.teamFrame:Hide() end
    Cursor.operation = "COPY"
    Cursor.teamIndex =nil
    Cursor.petIndex = nil
    Cursor.petID = petID
    Cursor.callbacks:Fire("BATTLE_PET_CURSOR_CHANGED",Cursor.operation,petID)
end

function Cursor.ClearCursorHook()
    Cursor:Clear()
end

Cursor:Initialize()

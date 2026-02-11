local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local GUI = PetBattleTeams:GetModule("GUI")
local TeamManager =  PetBattleTeams:GetModule("TeamManager")
local ROW_HEIGHT = 55
local Cursor = PetBattleTeams:GetModule("Cursor")
local PetBattleTeamsFrame = PetBattleTeams.PetBattleTeamsFrame

local _, addon = ...
local L = addon.L
-- luacheck: globals PetJournal

local function OnDragStart(self)
    if self:IsMovable() then
        self:StartMoving()
    end
end

local function OnDragStop(self)
    self:StopMovingOrSizing()
    GUI:SetPosition(self:GetLeft(), -1*(GetScreenHeight() - self:GetTop()), self:GetHeight())
end

local function SELECTED_TEAM_CHANGED(self,event,teamIndex)
    self.selectedTeam:SetTeam(teamIndex)
end

local function OnEvent(self,event)
    if not GUI:GetAttached() and GUI:GetHideInCombat() then
        if event == "PLAYER_REGEN_DISABLED" or event == "PET_BATTLE_OPENING_START" then
            self.bandageButton:Hide()
            self.reviveButton:Hide()
            self.bandageButton:SetParent(nil)
            self.reviveButton:SetParent(nil)
            self.bandageButton:ClearAllPoints()
            self.reviveButton:ClearAllPoints()
            UIFrameFadeOut(self, 1, 1, 0)
            self.fadeInfo.finishedFunc = function() self:Hide() end
        elseif event == "PLAYER_REGEN_ENABLED" or event == "PET_BATTLE_CLOSE"  then
            self.bandageButton:SetParent(self)
            self.reviveButton:SetParent(self)
            self.bandageButton:SetPoint("TOPLEFT", self.reviveButton, "TOPRIGHT", 1, 0)
            self.reviveButton:SetPoint("TOPLEFT", self.addTeamButton, "TOPRIGHT", 1, 0)
            self.bandageButton:SetSize(38, 38)
            self.reviveButton:SetSize(38, 38)

            local _, showControls = GUI:GetComponentPoints()
            if showControls then
                self.bandageButton:Show()
                self.reviveButton:Show()
            end

            UIFrameFadeIn(self,1,0,1)
        end
    end
    if event == "PLAYER_REGEN_ENABLED" or event == "PET_BATTLE_CLOSE" then
        self:SetAttached(GUI:GetAttached())
    end
end

local function SetLocked(self,enabled)
    assert(type(enabled) == "boolean")
    self:SetMovable(not enabled)
    self.resizer:SetShown(not enabled)
end

local function SetComponentPoints(self, showSelectedTeam, showControls, showRoster)
    self.selectedTeamText:SetShown(showSelectedTeam)
    self.selectedTeam:SetShown(showSelectedTeam)
    self.rosterFrame:SetShown(showRoster)
    self.addTeamButton:SetShown(showControls)
    self.reviveButton:SetShown(showControls)
    self.bandageButton:SetShown(showControls)

    local minSize = (showSelectedTeam and 70 or 0) + (showControls and 45 or 0) + (showRoster and ROW_HEIGHT*2 + 30 or 0)
    minSize = (minSize == 0) and 50 or (minSize + self.resizer:GetHeight())
    -- self:SetMinResize(self:GetWidth(), minSize)
    self:SetResizeBounds(self:GetWidth(), minSize)
    if self:GetHeight() < minSize then
        self:SetHeight(minSize)
    end

    if showRoster then
        if showSelectedTeam then
            self.rosterFrame:SetPoint("TOPLEFT", self.selectedTeam, "BOTTOMLEFT", 0, 0)
        else
            self.rosterFrame:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -15)
        end

        if showControls then
            self.rosterFrame:SetPoint("BOTTOM", self.addTeamButton, "TOP", 0, 0)
        else
            self.rosterFrame:SetPoint("BOTTOM", self, "BOTTOM", 0, 15)
        end
    end
end

--/run GUI:SetAttached(true)
local function SetAttached(self,enabled)
    if InCombatLockdown() then return end
    self.resizer:SetShown(not enabled)
    self:ClearAllPoints()
    local showSelectedTeam, showControls, showRoster = GUI:GetComponentPoints()
    if enabled then
        self:SetPoint("TOPLEFT", PetJournal, "TOPRIGHT", -3, 0)
        self:SetParent(PetJournal)
        self:SetSize(165,606)
        SetLocked(self,true)
        SetComponentPoints(self, showSelectedTeam, showControls, true)
    else
        local x, y, h = GUI:GetPosition()
        self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
        self:SetParent(UIParent)
        self:SetMovable(true)
        self:SetHeight(h)
        SetComponentPoints(self, showSelectedTeam, showControls, showRoster)
    end
    self.resizer:SetShown(not enabled)
    return self:GetParent()
end

local function SetPosition(self)
    if not GUI:GetAttached() then
        local x, y, h = GUI:GetPosition()
        self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)
        self:SetHeight(h)
    end
end

local function OnMouseWheel(self,delta)
    if GUI:GetSelectedTeamScrolling() then
        local currentTeam = TeamManager:GetSelected()
        local futureTeam = TeamManager:GetSelected() - delta
        if futureTeam > 0 and futureTeam <= TeamManager:GetNumTeams() then
            TeamManager:SetSelected(futureTeam)
        end
    end
end

function GUI:CreateMainFrame()
    local widget = CreateFrame("frame", "PetBattleTeamFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")

    widget:SetClampedToScreen(true)
    widget:SetFrameStrata("MEDIUM")
    widget:SetToplevel(true)
    widget:RegisterForDrag("LeftButton")
    widget:SetSize(165, ROW_HEIGHT * 8 + 166)
    -- widget:SetMaxResize(widget:GetWidth(), ROW_HEIGHT * 11 + 150)
    -- widget:SetMinResize(widget:GetWidth(), ROW_HEIGHT * 2 + 150)
    widget:SetResizeBounds(widget:GetWidth(), ROW_HEIGHT * 2 + 150, widget:GetWidth(), ROW_HEIGHT * 11 + 150)
    widget:SetMovable(true)
    widget:EnableMouse(true)

    widget:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\LFGFRAME\\LFGBorder",
        tile = 1,
        tileSize = 16,
        edgeSize = 16,
        insets = {
            left = 5,
            right = 5,
            top = 5,
            bottom = 5
        }
    })

    local selectedTeamText = widget:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    widget.selectedTeamText = selectedTeamText
    selectedTeamText:SetText(L["Selected Team"])
    selectedTeamText:SetPoint("TOP", widget, "TOP", -5, -10)
    selectedTeamText:SetJustifyH("CENTER")
    selectedTeamText:Show()

    local selectedTeam = PetBattleTeamsFrame:New()
    local h = selectedTeamText:GetHeight()
    selectedTeam:SetPoint("TOPLEFT", widget, "TOPLEFT", 0, -h-10)

    local SelectedTeamScrollFrame = CreateFrame("frame")
    SelectedTeamScrollFrame:SetParent(selectedTeam)
    SelectedTeamScrollFrame:SetAllPoints()
    SelectedTeamScrollFrame:EnableMouse(true)
    SelectedTeamScrollFrame:SetScript("OnMouseWheel", OnMouseWheel)
    widget.SelectedTeamScrollFrame = SelectedTeamScrollFrame

    selectedTeam:SetParent(widget)
    selectedTeam:SetTeam(TeamManager:GetSelected())
    Cursor.UnregisterCallback(selectedTeam, "BATTLE_PET_CURSOR_CHANGED")
    widget.selectedTeam = selectedTeam

    widget.SELECTED_TEAM_CHANGED = SELECTED_TEAM_CHANGED
    widget.SetAttached = SetAttached
    TeamManager.RegisterCallback(widget, "SELECTED_TEAM_CHANGED")

    local addTeamButton = self:CreateAddTeamButton("AddTeamButton", widget)
    widget.addTeamButton = addTeamButton
    addTeamButton:SetPoint("BOTTOMLEFT", widget, "BOTTOMLEFT", 13, 10)

    local reviveButton = self:CreateReviveButton("ReviveTeamButton", widget)
    widget.reviveButton = reviveButton
    reviveButton:SetPoint("TOPLEFT", addTeamButton, "TOPRIGHT", 2, 0)
    reviveButton:SetParent(widget)

    local bandageButton = self:CreateBandageButton("BandageTeamButton", widget)
    widget.bandageButton = bandageButton
    bandageButton:SetPoint("TOPLEFT", reviveButton, "TOPRIGHT", 2, 0)
    bandageButton:SetParent(widget)

    local rosterFrame = self:CreateScrollBar(widget)
    rosterFrame:SetParent(widget)
    rosterFrame:SetPoint("TOPLEFT", selectedTeam, "BOTTOMLEFT", 0, 0)
    rosterFrame:SetPoint("BOTTOM", addTeamButton, "TOP", 0, 0)
    widget.rosterFrame = rosterFrame

    local resizer = self:CreateResizer(widget)
    widget.resizer = resizer
    resizer:SetPoint("BOTTOMRIGHT", widget, "BOTTOMRIGHT", -5, 5)

    widget:SetScript("OnDragStart", OnDragStart)
    widget:SetScript("OnDragStop", OnDragStop)
    widget:SetScript("OnEvent", OnEvent)
    widget:RegisterEvent("PLAYER_REGEN_DISABLED")
    widget:RegisterEvent("PLAYER_REGEN_ENABLED")
    widget:RegisterEvent("PET_BATTLE_OPENING_START")
    widget:RegisterEvent("PET_BATTLE_CLOSE")
    widget:RegisterEvent("PLAYER_LEAVING_WORLD")

    widget.SetAttached = SetAttached
    widget.SetLocked = SetLocked
    widget.SetPosition = SetPosition
    widget.SetComponentPoints = SetComponentPoints

    return widget
end

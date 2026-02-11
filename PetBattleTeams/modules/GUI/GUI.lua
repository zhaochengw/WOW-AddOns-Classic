--[[
Callback events

OPTIONS_UPDATE
args:  nil

Fired when ever the GUI options are changed

]]

local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local GUI = PetBattleTeams:NewModule("GUI")
local TeamManager = PetBattleTeams:GetModule("TeamManager")
local LibPetJournal = LibStub("LibPetJournal-2.0")
local eventFrame = CreateFrame("frame")

-- luacheck: globals PetJournal

local function OnEvent(self,event,...)
    if event == "ADDON_LOADED" then
        local name = ...
        if (C_AddOns.IsAddOnLoaded("Blizzard_Collections") or name == "Blizzard_Collections") and not GUI.delayedInit then
            GUI:InitializeGUI()
            self:UnregisterEvent("ADDON_LOADED")
        end

    end

    if event == "PLAYER_REGEN_ENABLED" or event == "PET_BATTLE_CLOSE"  then
        if GUI.delayedInit and C_AddOns.IsAddOnLoaded("Blizzard_Collections")  then
            GUI:InitializeGUI()
            self:UnregisterEvent("PLAYER_REGEN_ENABLED")
            self:UnregisterEvent("PET_BATTLE_CLOSE")
        end
    end

    if event == "PLAYER_TARGET_CHANGED" then
        if not GUI.delayedInit then
            TeamManager:DetectTarget()
        end
    end
end

eventFrame:SetScript("OnEvent",OnEvent)
eventFrame:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("PET_BATTLE_CLOSE")
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
eventFrame:RegisterEvent("ADDON_LOADED")

function GUI:OnInitialize()
    self.callbacks = LibStub("CallbackHandler-1.0"):New(self)

    local db = LibStub("AceDB-3.0"):New("PetBattleTeamsDB", {} , true)
    local name = self:GetName()

    local defaults = {
        global = {
            attached = true,
            locked = false,
            hideInCombat = true,
            x = 0,
            y = 0,
            h = 606,
            showSelectedTeam =true,
            showControls = true,
            showRoster = true,
            minimized = false,
            SelectedTeamScrolling = false,
        }
    }

    self.db = db:RegisterNamespace(name, defaults)

    if UnitAffectingCombat("player") then
        self.delayedInit = true
    end

    if C_AddOns.IsAddOnLoaded("Blizzard_Collections") then
        eventFrame:UnregisterEvent("ADDON_LOADED")
        if not GUI.delayedInit then
            GUI:InitializeGUI()
        end
    end
end

function GUI:PetJournalReady()
    if C_AddOns.IsAddOnLoaded("Blizzard_Collections") then
        eventFrame:UnregisterEvent("ADDON_LOADED")
        LibPetJournal.UnregisterCallback(self,"PostPetListUpdated", "PetJournalReady")
    end
end

function GUI:InitializeGUI()
    if not self.mainFrame then
        self.mainFrame =  GUI:CreateMainFrame()

        local menuButton = GUI:CreateMenuButton()
        self.menuButton =  menuButton

        self:ToggleMinimize(self:GetIsMinimized())

        self.mainFrame:SetLocked(self:GetLocked())
        self.mainFrame:Hide()

        if not UnitAffectingCombat("player") then
            self.mainFrame:SetAttached(self:GetAttached())
            self.mainFrame:SetComponentPoints(GUI:GetComponentPoints())
            self.mainFrame:Show()
        end

        GUI:ToggleMinimize(GUI:GetIsMinimized())
    end
end

function GUI:SetAttached(enabled)
    if UnitAffectingCombat("player") then print("PetBattleTeams: Can't change attachment during combat") return end
    self.db.global.attached = enabled
    if self.mainFrame then
        self.mainFrame:SetAttached(enabled)
		if enabled then
			GUI:ToggleMinimize(false);
		end
    end
end

function GUI:SetHideInCombat(enabled )
    self.db.global.hideInCombat = enabled
end

function GUI:GetSelectedTeamScrolling()
    return self.db.global.SelectedTeamScrolling
end

function GUI:SetSelectedTeamScrolling(enabled)
    self.db.global.SelectedTeamScrolling = enabled
end

function GUI:SetLocked(enabled)
    self.db.global.locked = enabled
    if self.mainFrame then
        self.mainFrame:SetLocked(enabled)
    end
    self.callbacks:Fire("OPTIONS_UPDATE")
end

function GUI:GetAttached()
    return self.db.global.attached
end

function GUI:GetLocked()
    return self.db.global.locked
end

function GUI:GetHideInCombat()
    return self.db.global.hideInCombat
end

function GUI:GetPosition()
    local db = self.db.global
    return db.x,db.y,db.h
end

function GUI:SetPosition(x,y,h)
    local db = self.db.global
    db.x,db.y,db.h = x,y,h
end

function GUI:ResetUI()
    self:SetLocked(false)
    self:SetAttached(true)
    self:SetHideInCombat(true)
end

function GUI:ResetScrollBar()
    if self.mainFrame then
        self.mainFrame.rosterFrame:ResetScrollBar()
    end
end

function GUI:SetComponentPoints(showSelectedTeam,showControls,showRoster)
    if showSelectedTeam ~= nil then self.db.global.showSelectedTeam = showSelectedTeam end
    if showControls ~= nil then self.db.global.showControls = showControls end
    if showRoster ~= nil then self.db.global.showRoster = showRoster end
    if self.mainFrame then
        self.mainFrame:SetComponentPoints(GUI:GetComponentPoints())
        self:ResetScrollBar()
    end
end

function GUI:GetComponentPoints()
    return self.db.global.showSelectedTeam,self.db.global.showControls,self.db.global.showRoster
end


function GUI:ToggleMinimize(enabled)
    if enabled then
        self.menuButton:SetPoint("CENTER",PetJournal,"TOPRIGHT",-40,-10)
        self.menuButton:SetParent(PetJournal)
		self.menuButton:SetFrameStrata("DIALOG")
    else
        self.menuButton:SetPoint("CENTER",self.mainFrame,"TOPRIGHT",-10,-10)
        self.menuButton:SetParent(self.mainFrame)
    end
    self.mainFrame:SetShown(not enabled)
    self.db.global.minimized = enabled
end

function GUI:GetIsMinimized()
    return self.db.global.minimized
end

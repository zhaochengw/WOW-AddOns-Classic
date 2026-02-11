local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local Config = PetBattleTeams:NewModule("Config","AceConsole-3.0")
local TeamManager = PetBattleTeams:GetModule("TeamManager")
local GUI = PetBattleTeams:GetModule("GUI")
local Tooltip = PetBattleTeams:GetModule("Tooltip")
local ACD = LibStub("AceConfigDialog-3.0")


local _, addon = ...
local L = addon.L
local devVer = "";


Config.options = {
    name = L["PetBattle Teams"]..devVer,
    type = 'group',
    args = {
        TeamFrameHeading = {
            order = 1,
            name = L["Teams and Pets"],
            width = "full",
            type = "header",
        },
        showXpInLevel = {
            order = 2,
            name = L["Display pets xp as part of the pets level"],
            width = "full",
            type = "toggle",
            set = function(info,val)
                TeamManager:SetShowXpInLevel(val)
            end,
            get = function(info) return TeamManager:GetShowXpInLevel() end
        },
        showXpInHealth = {
            order = 3,
            name = L["Display pets xp instead of the health bar"],
            type = "toggle",
            width = "full",
            set = function(info,val)
                TeamManager:SetShowXpInHealthBar(val)
            end,
            get = function(info) return TeamManager:GetShowXpInHealthBar() end
        },
        ShowTeamName = {
            order = 4,
            name = L["Display team name above the team"],
            type = "toggle",
            width = "full",
            set = function(info,val)
                TeamManager:SetShowTeamName(val)
            end,
            get = function(info) return TeamManager:GetShowTeamName()  end
        },
        ShowBattleNote = {
            order = 6,
            name = L["Show team note during pet battles"],
            type = "toggle",
            width = "full",
            set = function(info,val)
                TeamManager:SetShowBattleNote(val)
            end,
            get = function(info) return TeamManager:GetShowBattleNote()  end
        },
        SelectedTeamScrolling = {
            order = 7,
            name = L["Enable mouse wheel scrolling for the selected team"],
            type = "toggle",
            width = "full",
            desc = L["When enabled allows you to change the selected team by using the mouse wheel on the selected team (above the roster)"],
            set = function(info,val)
                GUI:SetSelectedTeamScrolling(val)
            end,
            get = function(info) return GUI:GetSelectedTeamScrolling()  end
        },
        MainFrameHeading = {
            order = 50,
            name = L["Main"],
            width = "full",
            type = "header",
        },
        AttachToPetJournal = {
            order = 51,
            name = L["Attach PetBattle Teams to Pet Journal"],
            desc = L["When attached, PetBattle Teams will only be usable from the Pet Journal."],
            type = "toggle",
            width = "full",
            set = function(info,val)
                GUI:SetAttached(val)
            end,
            get = function(info) return GUI:GetAttached() end
        },
        HideInCombat = {
            order = 52,
            name = L["Hide PetBattle Teams while in combat or in a Pet Battle"],
            desc = L["Hides PetBattle Teams while in combat or in a Pet Battle."],
            type = "toggle",
            width = "full",
            set = function(info,val)
                GUI:SetHideInCombat(val)
            end,
            get = function(info) return GUI:GetHideInCombat() end
        },
        LockPosition = {
            order = 53,
            name = L["Lock PetBattle Teams Position"],
            type = "toggle",
            width = "full",
            desc = L["When the team frame is not attached to the Pet Journal then if the frame is locked it cannot be moved."],
            set = function(info,val)
                GUI:SetLocked(val)
            end,
            get = function(info) return GUI:GetLocked() end
        },
        showSelectedTeam = {
            order = 60,
            name = L["Show the selected team indicator"],
            type = "toggle",
            width = "full",
            desc = "",
            set = function(info,val)
                GUI:SetComponentPoints(val,nil,nil)
            end,
            get = function(info) return select(1,GUI:GetComponentPoints()) end
        },
        showControls = {
            order = 61,
            name = L["Show control buttons"],
            type = "toggle",
            width = "full",
            desc = "",
            set = function(info,val)
                GUI:SetComponentPoints(nil,val,nil)
            end,
            get = function(info) return select(2,GUI:GetComponentPoints()) end
        },
        showRoster = {
            order = 62,
            name = L["Show the team roster"],
            type = "toggle",
            width = "full",
            desc = "",
            set = function(info,val)
                GUI:SetComponentPoints(nil,nil,val)
            end,
            get = function(info) return select(3,GUI:GetComponentPoints()) end
        },
        TooltipHeading = {
            order = 75,
            name = L["Tooltip"],
            width = "full",
            type = "header",
        },
        ShowHelperText = {
            order = 80,
            name = L["Show keybinding helper text in tooltip"],
            type = "toggle",
            width = "full",
            set = function(info,val)
                Tooltip:SetShowHelpText(val)
            end,
            get = function(info) return Tooltip:GetShowHelpText() end
        },
        ShowStrongWeakHints = {
            order = 81,
            name = L["Show strong/weak hints in tooltip"],
            type = "toggle",
            width = "double",
            set = function(info,val)
                Tooltip:SetShowStrongWeakHints(val)
            end,
            get = function(info) return Tooltip:GetShowStrongWeakHints() end
        },
        ShowBreedInfo = {
            order = 82,
            name = L["Show breed information in tooltip"],
            type = "toggle",
            width = "full",
            set = function(info,val)
                Tooltip:SetShowBreedInfo(val)
            end,
            get = function(info) return Tooltip:GetShowBreedInfo() end
        },
        TeamFunctionsHeading = {
            order = 97,
            name = L["Team Management"],
            width = "full",
            type = "header",
        },
        AutoSwitchOnTarget = {
            order = 98,
            name = L["Autoswitch team feature"],
            desc = L["When enabled, you can associate teams with NPC IDs, and your team will automatically switch when you target them."],
            type = "toggle",
            width = "full",
            set = function(_,val)
                TeamManager:SetAutoSwitchOnTarget(val)
            end,
            get = function(_) return TeamManager:GetAutoSwitchOnTarget() end
        },
        SortTeams = {
            order = 99,
            name = L["Automatically Sort Teams Alphabetically"],
            desc = L["When enabled, teams will be sorted alphabetically by name."],
            type = "toggle",
            width = "full",
            set = function(info,val)
                TeamManager:SetSortTeams(val)
            end,
            get = function(info) return TeamManager:GetSortTeams() end
        },
        SaveTeams = {
            order = 100,
            name = L["Automatically Save Teams"],
            desc = L["When enabled:|nThe currently selected team will have its pets updated to match the pet journal at all times unless the selected team is locked.|n|nNewly created teams will be created using the currently selected pets."],
            type = "toggle",
            width = "full",
            set = function(info,val)
                TeamManager:SetAutomaticallySaveTeams(val)
            end,
            get = function(info) return TeamManager:GetAutomaticallySaveTeams() end
        },
        DismissPet = {
            order = 101,
            name = L["Automatically Dismiss pet after team changes"],
            desc = L["When enabled, Your active pet will be dismissed when switching teams"],
            type = "toggle",
            width = "full",
            set = function(info,val)
                TeamManager:SetDismissPet(val)
            end,
            get = function(info) return TeamManager:GetDismissPet() end
        },
        ImportTeams = {
            order = 102,
            name = L["Reconstruct teams"],
            width = "double",
            type = "execute",
            desc = L["Attempts to reconstuct teams with invalid pets"],
            func = function()
                TeamManager:ReconstructTeams()
            end,
        },
        UnlockTeams = {
            order = 103,
            name = L["Unlock all existing teams"],
            width = "double",
            type = "execute",
            desc = L["This does not prevent you from locking individual teams."],
            func = function()
                TeamManager:SetLockStateAllTeams(false)
                print("PetBattle Teams: Teams Unlocked")
            end,
        },
        LockAllTeams = {
            order = 103,
            name = L["Lock all existing teams"],
            width = "double",
            type = "execute",
            desc = L["This does not lock newly created teams or prevent you from unlocking individual teams."],
            func = function()
                TeamManager:SetLockStateAllTeams(true)
                print("PetBattle Teams: Teams locked")
            end,
        },
        ResetTeams = {
            order = 110,
            name = L["Delete all teams"],
            type = "execute",
            width = "double",
            desc= L["Permanently deletes all teams."],
            func = function()
                TeamManager:ResetTeams()
                GUI:ResetScrollBar()
                print("PetBattle Teams: Teams Reset")
            end,
        },
        ResetUI = {
            order = 120,
            name = L["Reset UI"],
            type = "execute",
            width = "double",
            desc= L["Resets the UI to its default settings. There is no confirmation for this action."],
            func = function()
                GUI:ResetUI()
                TeamManager:ResetUI()
                print("PetBattle Teams: UI Reset")
            end,
        },
    },
}

function Config:OnInitialize()
    LibStub("AceConfig-3.0"):RegisterOptionsTable("PetBattleTeams", Config.options, {"pbt"} )
	ACD:SetDefaultSize("PetBattleTeams", 640, 600)
    ACD:AddToBlizOptions("PetBattleTeams","PetBattle Teams"..devVer)
	self:RegisterChatCommand("pbto", self.OpenConfig)
end

function Config:OpenConfig()
	ACD:Open("PetBattleTeams")
end

function Config:GetEasyMenu()
    --bad bubble sort hack
    local function GetNextOptions(options,lastOrder)
        if not lastOrder or not options then return end
        local option
        local minOrder = 10000
        for k,v in pairs(options) do
            if v.order > lastOrder and v.order < minOrder then
                option = k
                minOrder = v.order
            end
        end
        return option,minOrder
    end

    local menu = {}
    local v
    local i = 0
    while(true) do
        v, i = GetNextOptions(self.options.args, i)
        if not v then break end
        v = self.options.args[v]
        local option = {}
        if v.type == "toggle" then
            option.text = v.name
            option.notCheckable = false
            option.isNotRadio = true
            option.keepShownOnClick = true
            local func = v.set
            option.func =  function(self, arg1, arg2, checked) func(nil,checked) end
            option.checked = v.get
        end
        if v.type == "header" then
            option.isTitle = true
            option.text = v.name
            option.notCheckable = true
            option.isNotRadio = true
            option.keepShownOnClick = true
        end
        table.insert(menu,option)
    end

    return menu
end

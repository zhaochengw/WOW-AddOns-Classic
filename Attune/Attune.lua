-------------------------------------------------------------------------
--
--	Copyright (c) 2019-2021 by Antoine Desmarets.
--	Cixi/Gaya of Remulos Oceanic / WoW Classic Horde
--
--	Attune is distributed in the hope that it will be useful/entertaining
--	but WITHOUT ANY WARRANTY
--
-------------------------------------------------------------------------

-- Done in 311
--  ToC update for Phase 2
--  Updated Ace Libraries		
--  fix to an AceGUI widget (label)		- Thanks RoadBlock!
--  Added a DK icon >.<


-------------------------------------------------------------------------
-- ADDON VARIABLES
-------------------------------------------------------------------------

local addonName, addon = ...

Attune = LibStub("AceAddon-3.0"):NewAddon("Attune", "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0")
Attune_Data = {};							-- Attunements / steps / tooltips

Lang = LibStub("AceLocale-3.0"):GetLocale("Attune")

local AceGUI = LibStub("AceGUI-3.0")
local _G = getfenv(0)

local attunelocal_ldb = LibStub("LibDataBroker-1.1")
local Attune_Broker = nil
local attunelocal_minimapicon = LibStub("LibDBIcon-1.0")
local attunelocal_brokervalue = nil
local attunelocal_brokerlabel = nil

local attunelocal_version = tostring(GetAddOnMetadata(addonName, "Version"))
local attunelocal_prefix = "Attune_Channel"			-- used for addon chat communications
local attunelocal_versionprefix = "Attune_Version"	-- used for addon version check
local attunelocal_syncprefix = "Attune_Sync"		-- used for addon version check
local attunelocal_detectedNewer = false;			-- flag to only warn about new version once per session

-- Defaults for Node size
local attunelocal_Node_Width = 170
local attunelocal_Node_Height = 48
local attunelocal_Node_HGap = 10
local attunelocal_Node_VGap = 30
local attunelocal_Icon_Size = 32
local attunelocal_Line_Thickness = 6

local attunelocal_MiniNode_Width = 32
local attunelocal_MiniNode_Height = 32
local attunelocal_MiniNode_HGap = 10
local attunelocal_MiniNode_VGap = 6
local attunelocal_MiniIcon_Size = 20
local attunelocal_MiniLine_Thickness = 2

-- Frame variables
local attunelocal_frame						-- main frame
local attunelocal_tree = {}					-- tree data (nodes and leaves)
local attunelocal_treeframe					-- Ace TreeGroup object for attune tab
local attunelocal_guildframe				-- Ace SimpleGroup object for result tab
local attunelocal_treeIsShown = false		-- indicates whether we're on the tree view or result view
local attunelocal_right						-- right panel of the TreeGroup object
local attunelocal_scroll					-- scroller inside of the TreeGroup right panel
local attunelocal_gscroll					-- scroller inside the SimpleGroup of the result tab
local attunelocal_glist						-- individual rows of data inside the result tab
local attunelocal_export_frame				-- export submenu frame
local attunelocal_survey_frame				-- survey submenu frame
local attunelocal_resultselection = 1 		-- indicates whether to show last survey results(0) or guild results(1) or all(2)
local attunelocal_exportselection = 0 		-- indicates what dataset to export 0:me, 1:last survey, 2:guild, 3:all, 4:all my alts
local attunelocal_gflabel					-- table header (used to update the number of characters in list)
local attunelocal_showResultAttunes = true 	-- indicates whether to show toon profiles or attunes

--local attunelocal_repWidget					-- Reputation Widget frame
--local attunelocal_repWidget_frames = {} 	-- list of non-Ace frames for the rep widget (to reuse them later)

local attunelocal_syncProgressWidget		-- Sync Progress Widget
local attunelocal_syncProgressStatusBar		-- actual progress bar
local attunelocal_syncProgress_frames = {} 	-- list of non-Ace frames for the sync progess widget (to reuse them later)
local attunelocal_syncStartTime = nil		-- to calculate sync duration
local attunelocal_syncAmountToReceive = 0	-- Total amount we're due to receive
local attunelocal_syncAmountReceived = 0	-- amount we've received so far
local attunelocal_syncAmountToSend = 0		-- Total amount we're due to send
local attunelocal_syncAmountSent = 0		-- amount we've sent so far
local attunelocal_syncChunksSent = 0		-- chunks sent so far

local attunelocal_frames = {} 				-- list of non-Ace frames (to reuse them later)
local attunelocal_initial = true			-- first run

local attunelocal_myguild = ""				-- Guild of the current character
local attunelocal_realm = GetRealmName()	-- Realm of the current character

local guildToonMap = {}						-- matching guild to toon

local attunelocal_data = {}					-- data being exported to website
local attunelocal_count = 0					-- count of toons being exported

local attunelocal_charKey = UnitName("player") .. "-" .. attunelocal_realm			-- Character unique name
local attunelocal_statusText = Lang["Version"]:gsub("##VERSION##", attunelocal_version)		-- Default status text

local attunelocal_refreshDone = false		-- flag to indicate when the UI refresh has been done, to avoid doing it too many times and freezing UI)

local attunelocal_syncTarget = nil
local attunelocal_syncStatus = -1

local attunelocal_raidframe						-- main frame
local attunelocal_raidtree = {}					-- tree data (nodes and leaves)
local attunelocal_raidtreeframe					-- Ace TreeGroup object for attune tab
local attunelocal_raidscroll					-- scroller inside of the raid
local attunelocal_raidroster					-- scroller inside the raid SimpleGroup of the result tab
--local attunelocal_raidtoonIcon = {}				-- Icon object of the toon list
local attunelocal_raidspotIcon = {}				-- Icon object of the raid spots
local attunelocal_faction = ""
local attunelocal_raidname = ""					-- selected Raid name
local attunelocal_raidsize = 0					-- selected Raid size
local attunelocal_raidcount = 1  				-- selected raid, number of raid groups to show

local attunelocal_inactivity = 60*60*24*30		-- number of seconds to account for inactivity

local attunelocal_achieveDelayDone = false		-- Wait a few seconds to avoid the barrage of achieves when one first logs in

local patch = 0

-- This is to work around the fact that xpcall is quite costly and drops framerate when spammed for lots of little events
-- Thanks @RoadBlock for this 
local cleu_parser = CreateFrame("Frame")
cleu_parser.OnEvent = function(frame, event, ...)
    Attune.COMBAT_LOG_EVENT_UNFILTERED(Attune,event,...)
end
cleu_parser:SetScript("OnEvent", cleu_parser.OnEvent)
-- End of xpcall workaround


local IsQuestFlaggedCompleted = _G.IsQuestFlaggedCompleted or C_QuestLog.IsQuestFlaggedCompleted  -- This is to handle the changes in TBC (C_QuestLog)


local attune_options = {
    name = "Attune",
    handler = Attune,
    type = "group",
	childGroups = "tab",
    args = {
        tab1 = {
            type = "group",
            name = Lang["Settings"],
			width = "full",
			order = 1,
			args = {

				spacer1 = {
					type = "description",
					name = " ",
					width = "full",
					order = 2,
				},
				showMinimapButton = {
					type = "toggle",
					name = Lang["MinimapButton_TEXT"],
					desc = Lang["MinimapButton_DESC"],
					get = function(info) return not Attune_DB.minimapbuttonpos.hide end,
					set = function(info, val)
							if val then attunelocal_minimapicon:Show("Attune_Broker") else attunelocal_minimapicon:Hide("Attune_Broker") end
							Attune_DB.minimapbuttonpos.hide = not val
						end,
					width = 2.5,
					order = 5,
				},
				autosurvey = {
					type = "toggle",
					name = Lang["AutoSurvey_TEXT"],
					desc = Lang["AutoSurvey_DESC"],
					get = function(info) return Attune_DB.autosurvey end,
					set = function(info, val) Attune_DB.autosurvey = val end,
					width = 2.5,
					order = 6,
				},
				showSurveyed = {
					type = "toggle",
					name = Lang["ShowSurveyed_TEXT"],
					desc = Lang["ShowSurveyed_DESC"],
					get = function(info) return Attune_DB.showSurveyed end,
					set = function(info, val) Attune_DB.showSurveyed = val end,
					width = 1.65,
					order = 15,
				},
				showResponses = {
					type = "toggle",
					name = Lang["ShowResponses_TEXT"],
					desc = Lang["ShowResponses_DESC"],
					get = function(info) return Attune_DB.showResponses end,
					set = function(info, val) Attune_DB.showResponses = val end,
					width = 1.65,
					order = 16,
				},
				showStepReached = {
					type = "toggle",
					name = Lang["ShowSetMessages_TEXT"],
					desc = Lang["ShowSetMessages_DESC"],
					get = function(info) return Attune_DB.showStepReached end,
					set = function(info, val) Attune_DB.showStepReached = val end,
					width = 1.65,
					order = 17,
				},
				announceAttuneCompleted = {
					type = "toggle",
					name = Lang["AnnounceToGuild_TEXT"],
					desc = Lang["AnnounceToGuild_DESC"],
					get = function(info) return Attune_DB.announceAttuneCompleted end,
					set = function(info, val) Attune_DB.announceAttuneCompleted = val end,
					width = 1.65,
					order = 18,
				},
				showOtherChat = {
					type = "toggle",
					name = Lang["ShowOther_TEXT"],
					desc = Lang["ShowOther_DESC"],
					get = function(info) return Attune_DB.showOtherChat end,
					set = function(info, val) Attune_DB.showOtherChat = val end,
					width = 1.65,
					order = 19,
				},
				announceAchieveCompleted = {
					type = "toggle",
					name = Lang["AnnounceAchieve_TEXT"],
					desc = Lang["AnnounceAchieve_DESC"],
					get = function(info) return Attune_DB.toons[attunelocal_charKey].announceAchieveCompleted end,
					set = function(info, val) Attune_DB.toons[attunelocal_charKey].announceAchieveCompleted = val end,
					width = 2.6,
					order = 20,
				},				
				achieveMinPoints = {
					type = "select",
					name = "",
					desc = "",
					values = {	
						[10] = "10 Points", 
						[20] = "20 Points",
						[25] = "25 Points",
						[30] = "30 Points",
						[40] = "40 Points",
						[50] = "50 Points",
						[60] = "60 Points",
						[70] = "70 Points",
						[80] = "80 Points",
						[90] = "90 Points",
						[100] = "100 Points",
					},
					get = function(info) return Attune_DB.toons[attunelocal_charKey].achieveMinPoints end,
					set = function(info, val) Attune_DB.toons[attunelocal_charKey].achieveMinPoints = val end,
					width = 0.7,
					order = 21,
				},

				showList = {
					type = "toggle",
					name = Lang["ShowGuildies_TEXT"],
					desc = Lang["ShowGuildies_DESC"],
					get = function(info) return Attune_DB.showList end,
					set = function(info, val) Attune_DB.showList = val end,
					width = 2.8,
					order = 23,
				},
				maxListSize = {
					type = "input",
					name = "",
					desc = "",
					get = function(info) return Attune_DB.maxListSize end,
					set = function(info, val) Attune_DB.maxListSize = val end,
					width = 0.5,
					order = 24,
				},
				showListAlt = {
					type = "toggle",
					name = Lang["ShowAltsInstead_TEXT"],
					desc = Lang["ShowAltsInstead_DESC"],
					get = function(info) return Attune_DB.showListAlt end,
					set = function(info, val) Attune_DB.showListAlt = val end,
					width = 2.5,
					order = 26,
				},
				showDeprecatedAttunes = {
					type = "toggle",
					name = Lang["showDeprecatedAttunes_TEXT"],
					desc = Lang["showDeprecatedAttunes_DESC"],
					get = function(info) return Attune_DB.showDeprecatedAttunes end,
					set = function(info, val) Attune_DB.showDeprecatedAttunes = val; 	Attune_LoadTree(); 	Attune_ForceAttuneTabRefresh() end,
					width = 2.5,
					order = 27,
				},
				websiteUrl = {
					type = "input",
					name = "Database Website URL",
					desc = "URL of a World of Warcraft database website",
					get = function(info) return Attune_DB.websiteUrl end,
					set = function(info, val) Attune_DB.websiteUrl = val end,
					width = "full",
					order = 28,
				},
				spacer3 = {
					type = "description",
					name = " ",
					width = "full",
					order = 30,
				},
				spacer4 = {
					type = "description",
					name = " ",
					width = "full",
					order = 40,
				},
				deleteAll = {
					type = "execute",
					name = Lang["ClearAll_TEXT"],
					desc = Lang["ClearAll_DESC"],
					confirm = true,
					confirmText = Lang["ClearAll_CONF"],
					func = function(info, val)
						for kt, t in pairs(Attune_DB.toons) do
							if kt ~= attunelocal_charKey then
								Attune_DB.toons[kt] = nil
							end
						end
						if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["ClearAll_TEXT"]) end
					end,
					width = 1.6,
					order = 32,
				},
				deleteGuild = {
					type = "execute",
					name = Lang["DelNonGuildies_TEXT"],
					desc = Lang["DelNonGuildies_DESC"],
					confirm = true,
					confirmText = Lang["DelNonGuildies_CONF"],
					func = function(info, val)
						for kt, t in pairs(Attune_DB.toons) do
							if kt ~= attunelocal_charKey then
								if t.guild ~= nil then
									if t.guild ~= attunelocal_myguild then
										Attune_DB.toons[kt] = nil
									end
								end
							end
						end
						if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["DelNonGuildies_DONE"]) end
					end,
					width = 1.6,
					order = 33,
				},
				delete60 = {
					type = "execute",
					name = Lang["DelUnder60_TEXT"],
					desc = Lang["DelUnder60_DESC"],
					confirm = true,
					confirmText = Lang["DelUnder60_CONF"],
					func = function(info, val)
						for kt, t in pairs(Attune_DB.toons) do
							if kt ~= attunelocal_charKey then
								if t.level ~= nil then
									if tonumber(t.level) < 60 then
										Attune_DB.toons[kt] = nil
									end
								end
							end
						end
						if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["DelUnder60_DONE"]) end
					end,
					width = 1.6,
					order = 34,
				},
				delete70 = {
					type = "execute",
					name = Lang["DelUnder70_TEXT"],
					desc = Lang["DelUnder70_DESC"],
					confirm = true,
					confirmText = Lang["DelUnder70_CONF"],
					func = function(info, val)
						for kt, t in pairs(Attune_DB.toons) do
							if kt ~= attunelocal_charKey then
								if t.level ~= nil then
									if tonumber(t.level) < 70 then
										Attune_DB.toons[kt] = nil
									end
								end
							end
						end
						if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["DelUnder70_DONE"]) end
					end,
					width = 1.6,
					order = 35,
				},
				deleteAlts= {
					type = "execute",
					name = Lang["DelAlts_TEXT"],
					desc = Lang["DelAlts_DESC"],
					confirm = true,
					confirmText = Lang["DelAlts_CONF"],
					func = function(info, val)
						for kt, t in pairs(Attune_DB.toons) do
							if kt ~= attunelocal_charKey then
								if t.status ~= nil then
									if t.status == "Alt" then
										Attune_DB.toons[kt] = nil
									end
								end
							end
						end
						if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["DelAlts_DONE"]) end
					end,
					width = 1.6,
					order = 36,
				},
				deleteUnspecified = {
					type = "execute",
					name = Lang["DelUnspecified_TEXT"],
					desc = Lang["DelUnspecified_DESC"],
					confirm = true,
					confirmText = Lang["DelUnspecified_CONF"],
					func = function(info, val)
						for kt, t in pairs(Attune_DB.toons) do
							if kt ~= attunelocal_charKey then
								if t.status == nil or t.status == "None" then
									Attune_DB.toons[kt] = nil
								end
							end
						end
						if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["DelUnspecified_DONE"]) end
					end,
					width = 1.6,
					order = 37,
				},
				deleteInactive= {
					type = "execute",
					name = Lang["DelInactive_TEXT"],
					desc = Lang["DelInactive_DESC"],
					confirm = true,
					confirmText = Lang["DelInactive_CONF"],
					func = function(info, val)
						for kt, t in pairs(Attune_DB.toons) do
							if kt ~= attunelocal_charKey then
								if t.status ~= nil then
									if t.survey < time() - attunelocal_inactivity then
										Attune_DB.toons[kt] = nil
									end
								end
							end
						end
						if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["DelInactive_DONE"]) end
					end,
					width = 1.6,
					order = 38,
				},


	--[[
				spacer5 = {
					type = "description",
					name = " ",
					width = "full",
					order = 40,
				},
	]]

				credits = {
					type = "description",
					name = Lang["Credits"],
					width = "full",
					fontSize = "medium",
					order = 45,
				},
  --[[				showWidget = {
					type = "toggle",
					name = "Show Reputation Widget",
					desc = "Displays a reputation tracking window, allowing you to check your attunement reputation gains and progress.",
					get = function(info) return Attune_DB.repWidget.showWidget end,
					set = function(info, val) Attune_DB.repWidget.showWidget = val;
						if attunelocal_repWidget ~= nil then
							if val then attunelocal_repWidget:Show()
							else attunelocal_repWidget:Hide()
							end
						end
					end,
					width = 1.7,
					order = 41,
				},
				lockWidget = {
					type = "toggle",
					name = "Lock Reputation Widget",
					desc = "Lock the reputation widget in place, preventing its movement and hiding usage information.",
					get = function(info) return Attune_DB.repWidget.lockWidget end,
					set = function(info, val) Attune_DB.repWidget.lockWidget = val
						if attunelocal_repWidget ~= nil then
							print("in")
							if val then
								attunelocal_repWidget:SetMovable(false)
								print("NOT movable")
							else
								attunelocal_repWidget:SetMovable(true)
								print("movable")
							end
						end
					end,
					width = 1.7,
					order = 42,
				},
  ]]
			},
		},

        tab2 = {
            type = "group",
            name = Lang["Survey Log"],
			width = "full",
			order = 100,
			args = {
				logs = {
					type = "description",
					name = "",
					width = "full",
					order = 110,
				},
			},
		},
	},
}

-------------------------------------------------------------------------
-- EVENT: Addon is Initialized
-------------------------------------------------------------------------

function Attune:OnInitialize()
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Attune", attune_options, nil)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Attune"):SetParent(InterfaceOptionsFramePanelContainer)

end

-------------------------------------------------------------------------
-- EVENT: Addon is enabled
-------------------------------------------------------------------------

function Attune:OnEnable()
	-- Called when the addon is enabled
	C_ChatInfo.RegisterAddonMessagePrefix(attunelocal_prefix)
	C_ChatInfo.RegisterAddonMessagePrefix(attunelocal_versionprefix)
    --	C_ChatInfo.RegisterAddonMessagePrefix(attunelocal_syncprefix)


	Attune:RegisterComm(attunelocal_syncprefix)

	self:RegisterEvent("CHAT_MSG_ADDON")
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("QUEST_ACCEPTED")
	self:RegisterEvent("QUEST_TURNED_IN")
	self:RegisterEvent("UPDATE_FACTION")
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("QUEST_DETAIL")
	self:RegisterEvent("ACHIEVEMENT_EARNED")
	
	--self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	cleu_parser:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		
	_, _, _, patch	 = GetBuildInfo()
	
	if Attune_DB == nil then Attune_DB = {} end
	if Attune_DB.width == nil then Attune_DB.width = 980 end
	if Attune_DB.height == nil then Attune_DB.height = 550 end
	if Attune_DB.mini == nil then Attune_DB.mini = false end	-- allows to show tiny icons instead of the normal steps, and therefore see more of the attune
	if Attune_DB.toons == nil then Attune_DB.toons = {} end
	if Attune_DB.toons[attunelocal_charKey] == nil then Attune_DB.toons[attunelocal_charKey] = {} end
	if Attune_DB.survey == nil then Attune_DB.survey = {} end
	if Attune_DB.sortresult == nil then Attune_DB.sortresult = { 0, true } end -- sort order for the result tab (attune, asc/desc)  (0 for name)
	if Attune_DB.showList == nil then Attune_DB.showList = true end
	if Attune_DB.showListAlt == nil then Attune_DB.showListAlt = false end
	if Attune_DB.showSurveyed == nil then Attune_DB.showSurveyed = false end
	if Attune_DB.showResponses == nil then Attune_DB.showResponses = true end
	if Attune_DB.showStepReached == nil then Attune_DB.showStepReached = true end
	if Attune_DB.announceAttuneCompleted == nil then Attune_DB.announceAttuneCompleted = true end
	if Attune_DB.showDeprecatedAttunes == nil then Attune_DB.showDeprecatedAttunes = true end
		
	
	--convert global setting to a per toon setting
	local oldAnnounceAchieveCompleted = true
	if Attune_DB.announceAchieveCompleted ~= nil then oldAnnounceAchieveCompleted = Attune_DB.announceAchieveCompleted;  end --get previous setting
	if Attune_DB.toons[attunelocal_charKey].announceAchieveCompleted == nil then Attune_DB.toons[attunelocal_charKey].announceAchieveCompleted = oldAnnounceAchieveCompleted end

	local oldAchieveMinPoints = 20
	if Attune_DB.achieveMinPoints ~= nil then oldAchieveMinPoints = Attune_DB.achieveMinPoints  end  --get previous setting
	if Attune_DB.toons[attunelocal_charKey].achieveMinPoints == nil then Attune_DB.toons[attunelocal_charKey].achieveMinPoints = oldAchieveMinPoints end

	local oldAnnounceAchieveSurvey = false
	if Attune_DB.announceAchieveSurvey ~= nil then oldAnnounceAchieveSurvey = Attune_DB.announceAchieveSurvey  end  --get previous setting
	if Attune_DB.toons[attunelocal_charKey].announceAchieveSurvey == nil then Attune_DB.toons[attunelocal_charKey].announceAchieveSurvey = oldAnnounceAchieveSurvey end

	
	if Attune_DB.showOtherChat == nil then Attune_DB.showOtherChat = true end
	if Attune_DB.maxListSize == nil then Attune_DB.maxListSize = "20" end
	if Attune_DB.logs == nil then Attune_DB.logs = {} end
	if Attune_DB.minimapbuttonpos == nil then Attune_DB.minimapbuttonpos = {} end
	if Attune_DB.minimapbuttonpos.hide == nil then Attune_DB.minimapbuttonpos.hide = false end
	if Attune_DB.autosurvey == nil then Attune_DB.autosurvey = false end
	if Attune_DB.websiteUrl == nil then Attune_DB.websiteUrl = "https://wowhead.com/wotlk" end
	if TreeExpandStatus == nil then TreeExpandStatus = {} end
	
	

	--raid planner
	if Attune_DB.raidShowMains == nil then Attune_DB.raidShowMains = true end
	if Attune_DB.raidShowAlts == nil then Attune_DB.raidShowAlts = false end
	if Attune_DB.raidShowUnattuned == nil then Attune_DB.raidShowUnattuned = false end
	if Attune_DB.raidShowUnspecified == nil then Attune_DB.raidShowUnspecified = false end
	if Attune_DB.raidGuildOnly == nil then Attune_DB.raidGuildOnly = true end
	
	if Attune_DB.raidPlans == nil then Attune_DB.raidPlans = {} end
	if Attune_DB.raidNames == nil then Attune_DB.raidNames = {} end
	attunelocal_faction = UnitFactionGroup("player")
	if Attune_DB.raidPlans[attunelocal_faction] == nil then Attune_DB.raidPlans[attunelocal_faction] = {} end
	if Attune_DB.raidNames[attunelocal_faction] == nil then Attune_DB.raidNames[attunelocal_faction] = {} end
	if Attune_DB.raidSelection == nil then Attune_DB.raidSelection = {} end
	if Attune_DB.raidSelection[attunelocal_faction] == nil then Attune_DB.raidSelection[attunelocal_faction] = 115 end
	--[[	local gameLocale = GetLocale()
		if gameLocale == "enGB" then
			gameLocale = "enUS"
		end
		if Attune_DB.preferredLocale == nil then Attune_DB.preferredLocale = gameLocale end
	
	if (Attune_DB.repWidget == nil) then Attune_DB.repWidget = {}; end
	if (Attune_DB.repWidget.showWidget == nil) then Attune_DB.repWidget.showWidget = false; end
	if (Attune_DB.repWidget.lockWidget == nil) then Attune_DB.repWidget.lockWidget = false; end
	if (Attune_DB.repWidget.showInRaid == nil) then Attune_DB.repWidget.showInRaid = true; end
	if (Attune_DB.repWidget.showInDungeon == nil) then Attune_DB.repWidget.showInDungeon = true; end
	if (Attune_DB.repWidget.showInWorld == nil) then Attune_DB.repWidget.showInWorld = true; end
	if (Attune_DB.repWidget.showInBg == nil) then Attune_DB.repWidget.showInBg = true; end
	if (Attune_DB.repWidget.point == nil) then Attune_DB.repWidget.point = nil; end
]]

	if Attune_DB.showOtherChat then DEFAULT_CHAT_FRAME:AddMessage("|cffff00ff[Attune]|r "..Lang["Splash"]:gsub("##VERSION##", attunelocal_version)) end


	-- add new fields to toons data
	for kt, t in pairs(Attune_DB.toons) do
		if t.status == nil then t.status = "None" end
		if t.role == nil then t.role = "None" end
		if t.survey == nil then t.survey = 0 end
		if t.guild == nil then t.guild = "" end
		if t.class == nil then t.class = "UNKNOWN" end
		if t.attuned == nil then t.attuned = {} end
		if t.done == nil then t.done = {} end
		for i, a in pairs(Attune_Data.noattunes) do
			--mark as automatically attuned for those raids that do not require attunement
			if t.attuned[a.ID] == nil then t.attuned[a.ID] = 100 end
		end
		for i, a in pairs(Attune_Data.attunes) do
			if t.attuned[a.ID] == nil then t.attuned[a.ID] = 0 end
		end


--[[	-- NOW REMOVED as it was clearing alt status

		-- tentative fix for SSC
		-- attune was granted on error (picking up quest instead of turning in)
		t.attuned["120"] = 0		-- removing completion status
		t.done["120-60"] = nil		-- removing kill and item
		t.done["120-70"] = nil		-- removing kill and item
		t.done["120-80"] = nil		-- removing kill and item
		t.done["120-90"] = nil		-- removing kill and item
		t.done["120-110"] = nil		-- removing 'end' step
		t.done["120-100"] = nil		-- removing bad step (mark of vashj)
		t.done["120-95"] = nil		-- removing quest turn in step  --  this should re-complete itself automatically if the player has done it
]]
	end 

	Attune_UpdateLogs()
	
	--this is per character as it could cause problems with alliance vs horde last viewed (ex if last viewed is Honor Hold)
	if AttuneLastViewed == nil then AttuneLastViewed = Attune_Data.attunes[1].EXPAC.."\001".. Attune_Data.attunes[1].GROUP.."\001"..Attune_Data.attunes[1].ID end --select first in the list by default (should be MC, same alliance/horde)

	Attune_CheckProgress() -- get your own standing
	Attune:BAG_UPDATE(nil)


	-- calculate how many steps this toon has done on the attune
	local attuneDone = {}
	local t = Attune_DB.toons[attunelocal_charKey]
	local attuneSteps = {}
	for i, s in pairs(Attune_Data.steps) do
		if showPatchStep(s) then
			if s.TYPE ~= "Spacer" then
				if attuneSteps[s.ID_ATTUNE] == nil then attuneSteps[s.ID_ATTUNE] = 0 end
				attuneSteps[s.ID_ATTUNE] = attuneSteps[s.ID_ATTUNE] +1
			end
		end
	end
	for i, d in pairs(t.done) do
		local Ids = Attune_split(i, "-")
		if attuneDone[Ids[1]] == nil then attuneDone[Ids[1]] = 0 end
		attuneDone[Ids[1]] = attuneDone[Ids[1]] +1
	end
	if t.attuned == nil then t.attuned = {} end
	for i, a in pairs(Attune_Data.attunes) do
		if attuneDone[a.ID] == nil then attuneDone[a.ID] = 0 end
		t.attuned[a.ID] = math.floor(100*(attuneDone[a.ID]/attuneSteps[a.ID]))

	end



	-- sending a couple version checks to make sure people update to the latest version
	guildName, guildRankName, guildRankIndex = GetGuildInfo("player");
	if guildName ~= nil then
		C_Timer.After(11, function()
			if attunelocal_myguild ~= "" then Attune:SendCommMessage(attunelocal_versionprefix, attunelocal_version, "GUILD", ""); end
		end)
	end

	C_Timer.After(11, function()
		Attune:SendCommMessage(attunelocal_versionprefix, attunelocal_version, "YELL", "");
	end)

	C_Timer.After(15, function()
		attunelocal_achieveDelayDone = true -- after 10s the spam should have been done
	end)

	-- sending a couple version checks to make sure people update to the latest version

	if Attune_DB.autosurvey then
		C_Timer.After(13, function()
			if attunelocal_myguild ~= "" then 
				if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["StartAutoGuildSurvey"]) end
				Attune:SendCommMessage(attunelocal_prefix, "SILENTSURVEY", "GUILD", ""); 
			end
		end)
	end



	Attune_Broker = attunelocal_ldb:NewDataObject("Attune_Broker", {
		type = "data source",
		label = "Attune",
		text = "Click me!",
		icon = "Interface\\Icons\\inv_scroll_03",
		OnClick = function(self, button)
			if button=="LeftButton" then
				Attune_SlashCommandHandler("")
			elseif button=="RightButton" then
				InterfaceOptionsFrame_Show()
				InterfaceOptionsFrame_OpenToCategory("Attune")
			end
		end,
		OnTooltipShow = function(tooltip)
			tooltip:AddLine("|cFFffffffAttune v"..attunelocal_version.."|r")

			if 	attunelocal_brokerlabel ~= nil then
				tooltip:AddLine(" ")
				tooltip:AddLine("|cffffd100"..attunelocal_brokerlabel..":|r |cFFffffff"..attunelocal_brokervalue.."|r")
			end

			tooltip:AddLine(" ")
			tooltip:AddLine("|cffffd100"..Lang["LeftClick"].."|r"..Lang["OpenAttune"].."\n|cffffd100"..Lang["RightClick"].."|r"..Lang["OpenSettings"], 0.2, 1, 0.2)
		end,
	})





	local aid = nil
	-- Find the last selected attunement
	local st, le = string.find(AttuneLastViewed, "\001")

	if st ~= nil then -- not top level
		--get actual attune (remove expac/group)
		expac, group, sel = strsplit("\001", AttuneLastViewed);
		if sel ~= "" and sel ~= nil then
			aid = sel
		end
	end

	if aid ~= nil then
		for k, a in pairs(Attune_Data.attunes) do
			if a.ID == aid then
				attunelocal_brokerlabel = a.NAME
			end
		end
		if Attune_DB.toons[attunelocal_charKey].attuned[aid] ~= nil then
			attunelocal_brokervalue = Attune_DB.toons[attunelocal_charKey].attuned[aid].."%"
		else
			attunelocal_brokervalue = "0%"
		end
		Attune_Broker.text = attunelocal_brokervalue
	end


	attunelocal_minimapicon:Register("Attune_Broker", Attune_Broker, Attune_DB.minimapbuttonpos)
	if Attune_DB.minimapbuttonpos.hide then attunelocal_minimapicon:Hide("Attune_Broker"); attunelocal_minimapicon:Hide("Attune_Broker") else attunelocal_minimapicon:Show("Attune_Broker");attunelocal_minimapicon:Show("Attune_Broker") end



	C_Timer.After(10, function()
		if not Attune_DB.toons[attunelocal_charKey].announceAchieveSurvey then
			StaticPopupDialogs["ACHIEVEANNOUNCE_CONFIRM"] = {
				text = Lang["\n"..Lang["AchieveSurvey"]:gsub("##WHO##", UnitName("player")).."\n\n"],
				button1 = Lang["Yes"],
				button2 = Lang["No"],
				timeout = 0,
				hasEditBox = false,
				whileDead = true,
				hideOnEscape = true,
				preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
				OnAccept = function()
					Attune_DB.toons[attunelocal_charKey].announceAchieveSurvey = true
					Attune_DB.toons[attunelocal_charKey].announceAchieveCompleted = true
				end,
				OnCancel = function (_,reason)
					Attune_DB.toons[attunelocal_charKey].announceAchieveSurvey = true
					Attune_DB.toons[attunelocal_charKey].announceAchieveCompleted = false
				end,
			}
			StaticPopup_Show ("ACHIEVEANNOUNCE_CONFIRM")
		end
	end)


	--Attune_CreateRepWidget()



	-- Remedy can be time consuming because of the recursive loop.
	-- Only perform when a new version of the addon is found
	local ind = 0
	if Attune_DB.version == nil or Attune_DB.version < attunelocal_version then 
		-- remedy IsNext
		for it, tt in pairs(Attune_DB.toons) do
			if tt.next ~= nil then 

				C_Timer.After(0.200*ind, function() --stagger those to not freeze
					--print("Checking "..it)
					for i, n in Attune_spairs(tt.next, function(t,a,b) 
							local aa = Attune_split(a, "-")
							local bb = Attune_split(b, "-")
							local aaa = aa[1]*1000 + aa[2]
							local bbb = bb[1]*1000 + bb[2]
							return (bbb < aaa) 
						end) do
						for is, ts in pairs(Attune_Data.steps) do
							if showPatchStep(ts) then
								if ts.ID_ATTUNE .. "-" .. ts.ID == i then 
									if ts.FOLLOWS ~= "0" then 

										--this is where the remediation needs to happen
										Attune_remedyIsNext(it, ts.ID_ATTUNE, ts.FOLLOWS)
										
									end
									break
								end
							end
						end
					end
				end)
				ind = ind + 1
			end
		end
		Attune_DB.version = attunelocal_version
	end

end

-------------------------------------------------------------------------
-- Remedy IsNext (some interact / kill steps remain as IsNext)
-------------------------------------------------------------------------

function Attune_remedyIsNext(who, aID, follows)

	-- there can be multi-follows (for example FOLLOW=160|170)
	-- We need to recurse both paths
	local fIDs = Attune_split(follows, "&")
	if string.find(follows, "|") then fIDs = Attune_split(follows, "|") end

	for fi, f in pairs(fIDs) do
		for i, s in pairs(Attune_Data.steps) do
			if showPatchStep(s) then
				if s.ID_ATTUNE == aID and s.ID == f then
					if string.find(follows, "|") == nil then -- don't recurse OR, as we don't know which parent was actually done
						if Attune_DB.toons[who].next[s.ID_ATTUNE .. "-" .. s.ID] == 1 then
	--						print(who..": Removed "..s.ID_ATTUNE .. "-" .. s.ID)
							Attune_DB.toons[who].next[s.ID_ATTUNE .. "-" .. s.ID] = nil
						end
						if follows ~= 0 then -- no need to recurse first level
							Attune_remedyIsNext(who, s.ID_ATTUNE, s.FOLLOWS)
						end
					end
				end
			end
		end
	end

end


-------------------------------------------------------------------------
-- EVENT: Addon is disabled
-------------------------------------------------------------------------

function Attune:OnDisable()
	-- Called when the addon is disabled
	self:Print("|cffff00ff[Attune]|r "..Lang["Addon disabled"])
end


-------------------------------------------------------------------------
-- EVENT: Fired when an achievement is gained
-------------------------------------------------------------------------

function Attune:ACHIEVEMENT_EARNED(event, id)
	local FEAT_OF_STRENGTH_CATEGID = 81

	--send a guild message when an achievement is earned 
	local guildName, guildRankName, guildRankIndex = GetGuildInfo("player");
	if guildName ~= nil then attunelocal_myguild = guildName end

	local achieveId, achieveName, achievePoints = GetAchievementInfo(id)
	local categId = GetAchievementCategory(id)
	
	if 	(achievePoints >= Attune_DB.toons[attunelocal_charKey].achieveMinPoints or categId == FEAT_OF_STRENGTH_CATEGID)
		and Attune_DB.toons[attunelocal_charKey].announceAchieveCompleted
		and attunelocal_myguild ~= ""
		and attunelocal_achieveDelayDone then 

			local msg = "[Attune] "..Lang["AchieveCompleteGuild"]:gsub("##LINK##", GetAchievementLink(id))
			if categId ~= FEAT_OF_STRENGTH_CATEGID then -- don't show points for FoS
				msg = msg .. " "..Lang["AchieveCompletePoints"]:gsub("##POINTS##", GetTotalAchievementPoints())
			end
			SendChatMessage(msg , "GUILD")
	end
end

-------------------------------------------------------------------------
-- EVENT: Addon Chat message is received
-------------------------------------------------------------------------

function Attune:CHAT_MSG_ADDON(event, arg1, arg2, arg3, arg4)

	--attune data channel
	if arg1 == attunelocal_prefix then
		if arg2 == 'SURVEY' or arg2 == 'SILENTSURVEY' then
			attunelocal_count = 0
			attunelocal_data = {}
			attunelocal_data['_faction'] = ""
			attunelocal_data['_realm'] = ""
			attunelocal_data['_guild'] = ""

			if arg2 == 'SURVEY' and arg4 ~= UnitName("player").."-"..GetRealmName() then
				if Attune_DB.showSurveyed then print("|cffff00ff[Attune]|r "..Lang["SendingDataTo"]:gsub("##NAME##", Attune_split(arg4, "-")[1]))  end
			end

			-- log all surveys (silent or not) unless they were sent by us
			if arg4 ~= UnitName("player").."-"..GetRealmName() then
				Attune_DB.logs[time()] = Lang["ReceivedRequestFrom"]:gsub("##FROM##", arg4)
				Attune_UpdateLogs()
			end

			Attune_SendRequestResults(arg4)
		else
			Attune_HandleRequestResults(arg2)
		end
	end

	--version check channel
	if arg1 == attunelocal_versionprefix then
		if arg2 > attunelocal_version and not attunelocal_detectedNewer then
			attunelocal_detectedNewer = true
			if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["NewVersionAvailable"].." (v"..arg2..")") end -- 	ved check with a newer version, warn the user
		end
	end


end

-------------------------------------------------------------------------
-- EVENT: Detect a mob has been killed
-------------------------------------------------------------------------

function Attune:COMBAT_LOG_EVENT_UNFILTERED(event, arg1, arg2, arg3, arg4)
	local param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16 = CombatLogGetCurrentEventInfo()
	local refreshNeeded = false

	--party kill is the better option as it knows your group did the kill (your tag), but doesn't work in raid.
	--for raids, use UNIT_DIED, as since it's a raid mob your group obviously had the tag
	if (param2 == "PARTY_KILL" and not IsInRaid()) or (param2 == "UNIT_DIED" and IsInRaid()) then

		for i, s in pairs(Attune_Data.steps) do
			if showPatchStep(s) then
				if s.TYPE == "Kill" then
					local npc_id = -1
					if param8 ~= nil then
						_, _, _, _, _, npc_id = strsplit("-", param8);
						if npc_id == nil then npc_id = -1 end
					else 
						npc_id = -1
					end
					--print(npc_id)
		
					if ""..s.ID_WOWHEAD == ""..npc_id then
						-- checking that predecessors are done (meaning this step is ISNext)
						local isNext = true
						local followOR = false
						if s.FOLLOWS ~= "0" then
							local fIDs = Attune_split(s.FOLLOWS, "&")
							if string.find(s.FOLLOWS, "|") then fIDs = Attune_split(s.FOLLOWS, "|"); followOR = true end
							if followOR then
								isNext = false
								for fi, f in pairs(fIDs) do
									if Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. f] then isNext = true end
								end
							else
								isNext = true
								for fi, f in pairs(fIDs) do
									if Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. f] == nil then isNext = false end
								end
							end
						end
						
						if isNext then
							if Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] == nil then
								for k, a in pairs(Attune_Data.attunes) do
									if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
										if a.ID == s.ID_ATTUNE then
											local faction = UnitFactionGroup("player")
											if a.FACTION == faction or a.FACTION == 'Both' then
												--mark step as done
												Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] = 1
												refreshNeeded = true
												PlaySound(1210) --putdownring
												-- need to refresh attune in window
												-- fetch attune name for chat message
												if Attune_DB.showStepReached then print("|cffff00ff[Attune]|r "..Lang["CompletedStep"]:gsub("##TYPE##", Lang[s.TYPE]):gsub("##STEP##", Lang["N1_"..s.ID_WOWHEAD]):gsub("##NAME##", a.NAME)) end
												Attune_SendPushInfo("TOON")
												Attune_SendPushInfo(s.ID_ATTUNE .. "-" .. s.ID)
												Attune_CheckComplete(false)
												if Attune_DB.toons[attunelocal_charKey].attuned[a.ID] >= 100 then
													PlaySound(5275) -- AuctionWindowClose
													if Attune_DB.showStepReached then print("|cffff00ff[Attune]|r "..Lang["AttuneComplete"]:gsub("##NAME##", a.NAME)) end
													if Attune_DB.announceAttuneCompleted and attunelocal_myguild ~= "" then SendChatMessage("[Attune] "..Lang["AttuneCompleteGuild"]:gsub("##NAME##", a.NAME), "GUILD") end
												end
												Attune_SendPushInfo("OVER")
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end

		if refreshNeeded then Attune_ForceAttuneTabRefresh() end -- refresh view if needed

	end
end

-------------------------------------------------------------------------
-- EVENT: Detect a level up
-------------------------------------------------------------------------

function Attune:PLAYER_LEVEL_UP(event, arg1)

	local refreshNeeded = false

	for i, s in pairs(Attune_Data.steps) do
		if showPatchStep(s) then
			if s.TYPE == "Level" then
				if arg1 >= tonumber(s.ID_WOWHEAD) then

					if Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] == nil then

						local faction = UnitFactionGroup("player")
						-- check attune warning is for the right faction
						for k, a in pairs(Attune_Data.attunes) do
							if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
								if a.ID == s.ID_ATTUNE then
									if a.FACTION == faction or a.FACTION == 'Both' then
										--mark step as done
										Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] = 1
										refreshNeeded = true
										PlaySound(1210) --putdownring
										-- fetch attune name for chat message
										if Attune_DB.showStepReached then print("|cffff00ff[Attune]|r "..Lang["CompletedStep"]:gsub("##TYPE##", s.TYPE):gsub("##STEP##", s.STEP):gsub("##NAME##", a.NAME)) end
										Attune_SendPushInfo("TOON")
										Attune_SendPushInfo(s.ID_ATTUNE .. "-" .. s.ID)
										Attune_SendPushInfo("OVER")
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if refreshNeeded then Attune_ForceAttuneTabRefresh() end -- refresh view if needed

end


-------------------------------------------------------------------------
-- EVENT: Quest accepted
-------------------------------------------------------------------------

function Attune:QUEST_ACCEPTED(event)

	local refreshNeeded = false

	for i, s in pairs(Attune_Data.steps) do
		if showPatchStep(s) then
			if s.TYPE == "Pick Up" then

				local qIDs = Attune_split(s.ID_WOWHEAD, "|")
				for i=1, #qIDs do 
					if C_QuestLog.IsOnQuest(qIDs[i]) then
					
						if Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] == nil then

							local faction = UnitFactionGroup("player")
							-- check attune warning is for the right faction
							for k, a in pairs(Attune_Data.attunes) do
								if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
									if a.ID == s.ID_ATTUNE then
										if a.FACTION == faction or a.FACTION == 'Both' then
											--mark step as done
											Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] = 1
											refreshNeeded = true
											PlaySound(1210) --putdownring
											-- fetch attune name for chat message
											if Attune_DB.showStepReached then print("|cffff00ff[Attune]|r "..Lang["CompletedStep"]:gsub("##TYPE##", s.TYPE):gsub("##STEP##", Lang["Q1_"..s.ID_WOWHEAD]):gsub("##NAME##", a.NAME)) end
											Attune_SendPushInfo("TOON")
											Attune_SendPushInfo(s.ID_ATTUNE .. "-" .. s.ID)
											Attune_SendPushInfo("OVER")
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if refreshNeeded then Attune_ForceAttuneTabRefresh() end -- refresh view if needed

end

-------------------------------------------------------------------------
-- EVENT: Quest turned in
-------------------------------------------------------------------------

function Attune:QUEST_TURNED_IN(event, arg1)

	local refreshNeeded = false

	for i, s in pairs(Attune_Data.steps) do
		if showPatchStep(s) then
			if s.TYPE == "Quest" or s.TYPE == "Turn In" then

				local qIDs = Attune_split(s.ID_WOWHEAD, "|")
				for i=1, #qIDs do 

					if tonumber(qIDs[i]) == arg1 then

						if Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] == nil then

							local faction = UnitFactionGroup("player")
							-- check attune warning is for the right faction
							for k, a in pairs(Attune_Data.attunes) do
								if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
									if a.ID == s.ID_ATTUNE then
										if a.FACTION == faction or a.FACTION == 'Both' then
											--mark step as done
											Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] = 1
											refreshNeeded = true
											PlaySound(1210) --putdownring
											-- fetch attune name for chat message
											if Attune_DB.showStepReached then print("|cffff00ff[Attune]|r "..Lang["CompletedStep"]:gsub("##TYPE##", s.TYPE):gsub("##STEP##", Lang["Q1_"..s.ID_WOWHEAD]):gsub("##NAME##", a.NAME)) end
											Attune_SendPushInfo("TOON")
											Attune_SendPushInfo(s.ID_ATTUNE .. "-" .. s.ID)
											Attune_CheckComplete(false)
											if Attune_DB.toons[attunelocal_charKey].attuned[a.ID] >= 100 then
												PlaySound(5275) -- AuctionWindowClose
												if Attune_DB.showStepReached then print("|cffff00ff[Attune]|r "..Lang["AttuneComplete"]:gsub("##NAME##", a.NAME)) end
												if Attune_DB.announceAttuneCompleted and attunelocal_myguild ~= "" then SendChatMessage("[Attune] "..Lang["AttuneCompleteGuild"]:gsub("##NAME##", a.NAME), "GUILD") end
											end
											Attune_SendPushInfo("OVER")
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if refreshNeeded then Attune_ForceAttuneTabRefresh() end -- refresh view if needed

end

-------------------------------------------------------------------------
-- EVENT: Interact with NPC
-------------------------------------------------------------------------
function Attune:QUEST_DETAIL(event)
	--print("QUEST_DETAIL")
	Attune:GOSSIP_SHOW(event)
end
-------------------------------------------------------------------------
function Attune:GOSSIP_SHOW(event)
	--print("GOSSIP")
	--print(UnitGUID("target"))
	local npc_id = -1
	if UnitGUID("target") ~= nil then
		 _, _, _, _, _, npc_id = strsplit("-", UnitGUID("target") );
		 if npc_id == nil then npc_id = -1 end
	else 
		npc_id = -1
	end
	--print(npc_id)
	
	local refreshNeeded = false

	for i, s in pairs(Attune_Data.steps) do
		if showPatchStep(s) then
			if s.TYPE == "Interact" then

				if s.ID_WOWHEAD == npc_id then
					if Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] == nil then

						-- checking that predecessors are done (meaning this step is ISNext)
						local isNext = true
						local followOR = false
						if s.FOLLOWS ~= "0" then
							local fIDs = Attune_split(s.FOLLOWS, "&")
							if string.find(s.FOLLOWS, "|") then fIDs = Attune_split(s.FOLLOWS, "|"); followOR = true end
							if followOR then
								isNext = false
								for fi, f in pairs(fIDs) do
									if Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. f] then isNext = true end
								end
							else
								isNext = true
								for fi, f in pairs(fIDs) do
									if Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. f] == nil then isNext = false end
								end
							end
						end
						
						if isNext then

							local faction = UnitFactionGroup("player")
							-- check attune warning is for the right faction
							for k, a in pairs(Attune_Data.attunes) do
								if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
									if a.ID == s.ID_ATTUNE then
										if a.FACTION == faction or a.FACTION == 'Both' then
											--mark step as done
											Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] = 1
											refreshNeeded = true
											PlaySound(1210) --putdownring
											-- fetch attune name for chat message
											if Attune_DB.showStepReached then print("|cffff00ff[Attune]|r "..Lang["CompletedStep"]:gsub("##TYPE##", s.TYPE):gsub("##STEP##", Lang["N1_"..s.ID_WOWHEAD]):gsub("##NAME##", a.NAME)) end
											Attune_SendPushInfo("TOON")
											Attune_SendPushInfo(s.ID_ATTUNE .. "-" .. s.ID)
											Attune_CheckComplete(false)
											if Attune_DB.toons[attunelocal_charKey].attuned[a.ID] >= 100 then
												PlaySound(5275) -- AuctionWindowClose
												if Attune_DB.showStepReached then print("|cffff00ff[Attune]|r "..Lang["AttuneComplete"]:gsub("##NAME##", a.NAME)) end
												if Attune_DB.announceAttuneCompleted and attunelocal_myguild ~= "" then SendChatMessage("[Attune] "..Lang["AttuneCompleteGuild"]:gsub("##NAME##", a.NAME), "GUILD") end
											end
											Attune_SendPushInfo("OVER")
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if refreshNeeded then Attune_ForceAttuneTabRefresh() end -- refresh view if needed

end

-------------------------------------------------------------------------
-- EVENT: Looted stuff
-------------------------------------------------------------------------

function Attune:BAG_UPDATE(event)

	local refreshNeeded = false

	for i, s in pairs(Attune_Data.steps) do
		if showPatchStep(s) then
			if s.TYPE == "Item" then

				local countNeeded = 1
				if s.COUNT ~= nil then countNeeded = s.COUNT end

				Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] = GetItemCount(s.ID_WOWHEAD, 1)

				-- Bandaid to fix the honored/revered key issue
				if s.ID_WOWHEAD == "185686" and Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] == 0 then Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] = GetItemCount("30637", 1) end -- Thrallmar
				if s.ID_WOWHEAD == "185687" and Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] == 0 then Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] = GetItemCount("30622", 1) end -- Honor Hold
				if s.ID_WOWHEAD == "185690" and Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] == 0 then Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] = GetItemCount("30623", 1) end -- Cenarion
				if s.ID_WOWHEAD == "185691" and Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] == 0 then Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] = GetItemCount("30633", 1) end -- Lower City
				if s.ID_WOWHEAD == "185692" and Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] == 0 then Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] = GetItemCount("30634", 1) end -- Shatar
				if s.ID_WOWHEAD == "185693" and Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] == 0 then Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] = GetItemCount("30635", 1) end -- KoT
				
				if Attune_DB.toons[attunelocal_charKey].items[s.ID_WOWHEAD] >= countNeeded then   --check bags and bank

					if Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] == nil then
						local faction = UnitFactionGroup("player")
						-- check attune warning is for the right faction
						for k, a in pairs(Attune_Data.attunes) do
							if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
								if a.ID == s.ID_ATTUNE then
									if a.FACTION == faction or a.FACTION == 'Both' then
										--mark step as done
										Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] = 1
										refreshNeeded = true
										PlaySound(1210) --putdownring
										-- fetch attune name for chat message
										if Attune_DB.showStepReached then print("|cffff00ff[Attune]|r "..Lang["CompletedStep"]:gsub("##TYPE##", s.TYPE):gsub("##STEP##", Lang["I_"..s.ID_WOWHEAD]):gsub("##NAME##", a.NAME)) end
										Attune_SendPushInfo("TOON")
										Attune_SendPushInfo(s.ID_ATTUNE .. "-" .. s.ID)
										Attune_CheckComplete(false)
										if Attune_DB.toons[attunelocal_charKey].attuned[a.ID] >= 100 then
											PlaySound(5275) -- AuctionWindowClose
											if Attune_DB.showStepReached then print("|cffff00ff[Attune]|r "..Lang["AttuneComplete"]:gsub("##NAME##", a.NAME)) end
											if Attune_DB.announceAttuneCompleted and attunelocal_myguild ~= "" then SendChatMessage("[Attune] "..Lang["AttuneCompleteGuild"]:gsub("##NAME##", a.NAME), "GUILD") end
										end
										Attune_SendPushInfo("OVER")
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if refreshNeeded then Attune_ForceAttuneTabRefresh() end -- refresh view if needed

end

-------------------------------------------------------------------------
-- EVENT: Rep changed
-------------------------------------------------------------------------

function Attune:UPDATE_FACTION(event)

	local refreshNeeded = false

	for i, s in pairs(Attune_Data.steps) do
		if showPatchStep(s) then
			if s.TYPE == "Rep" then

				--loop on the all the character's factions
				local factionIndex = 1

				local name, _, _, _, _, earnedValue = GetFactionInfoByID(s.LOCATION)
				Attune_DB.toons[attunelocal_charKey].reps[s.LOCATION] = {}
				Attune_DB.toons[attunelocal_charKey].reps[s.LOCATION].earned = earnedValue
				Attune_DB.toons[attunelocal_charKey].reps[s.LOCATION].name = name or Lang["Unknown Reputation"]
				--repeat
				--	local name, _, _, _, _, earnedValue = GetFactionInfo(factionIndex)
				--	if (name == s.LOCATION) then
				--		Attune_DB.toons[attunelocal_charKey].reps[s.LOCATION] = earnedValue
				--		break
				--	end
				--	factionIndex = factionIndex + 1
				--until factionIndex > 200

				if Attune_DB.toons[attunelocal_charKey].reps[s.LOCATION].earned >= tonumber(s.ID_WOWHEAD) then

					if Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] == nil then
						local faction = UnitFactionGroup("player")
						-- check attune warning is for the right faction
						for k, a in pairs(Attune_Data.attunes) do
							if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
								if a.ID == s.ID_ATTUNE then
									if a.FACTION == faction or a.FACTION == 'Both' then
										--mark step as done
										Attune_DB.toons[attunelocal_charKey].done[s.ID_ATTUNE .. "-" .. s.ID] = 1
										refreshNeeded = true
										PlaySound(1210) --putdownring
										-- fetch attune name for chat message
										if Attune_DB.showStepReached then print("|cffff00ff[Attune]|r "..Lang["CompletedStep"]:gsub("##TYPE##", s.TYPE):gsub("##STEP##", s.STEP):gsub("##NAME##", a.NAME)) end
										Attune_SendPushInfo("TOON")
										Attune_SendPushInfo(s.ID_ATTUNE .. "-" .. s.ID)
										Attune_CheckComplete(false)
										if Attune_DB.toons[attunelocal_charKey].attuned[a.ID] >= 100 then
											PlaySound(5275) -- AuctionWindowClose
											if Attune_DB.showStepReached then print("|cffff00ff[Attune]|r "..Lang["AttuneComplete"]:gsub("##NAME##", a.NAME)) end
											if Attune_DB.announceAttuneCompleted and attunelocal_myguild ~= "" then SendChatMessage("[Attune] "..Lang["AttuneCompleteGuild"]:gsub("##NAME##", a.NAME), "GUILD") end
										end
										Attune_SendPushInfo("OVER")
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if refreshNeeded then Attune_ForceAttuneTabRefresh() end -- refresh view if needed

end



-------------------------------------------------------------------------
function Attune_UpdateLogs()

	local slogs = ""
	local cnt = 0
	for i, l in Attune_spairs(Attune_DB.logs, function(t,a,b) return b < a end) do
		if cnt < 40 then -- only about 40 lines fit in that area
			slogs = slogs .. date("%d %b %Y - %H:%M", i) .. " - " .. l .. "\n"
		else
			Attune_DB.logs[i] = nil
		end
		cnt = cnt + 1
	end

	if slogs == "" then
		attune_options.args.tab2.args.logs.name = "None yet..."
	else
		attune_options.args.tab2.args.logs.name = slogs
	end

end

-------------------------------------------------------------------------
-- Perform the attunement checks
-------------------------------------------------------------------------

function Attune_CheckProgress()

	local att = Attune_DB.toons[attunelocal_charKey]

	if att.reps == nil then att.reps = {} end
	--if att.quests == nil then att.quests = {} end
	if att.items == nil then att.items = {} end
	if att.done == nil then att.done = {} end
	if att.attuned == nil then att.attuned = {} end
	if att.next == nil then att.next = {} end

	local faction = UnitFactionGroup("player")
	-- looping through all applicable attunes
	for i, a in pairs(Attune_Data.attunes) do

		if a.FACTION == faction or a.FACTION == 'Both' and (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 

			--looping through all steps
			for i, s in pairs(Attune_Data.steps) do

				if showPatchStep(s) then
					if s.ID_ATTUNE == a.ID then

						--get REPUTATION progression
						if s.TYPE == "Rep" then

							--loop on the all the character's factions
							local factionIndex = 1
							local name, _, _, _, _, earnedValue = GetFactionInfoByID(s.LOCATION)
							att.reps[s.LOCATION] = {}
							att.reps[s.LOCATION].earned = earnedValue
							att.reps[s.LOCATION].name = name or Lang["Unknown Reputation"]
							--repeat
							--	local name, _, _, _, _, earnedValue = GetFactionInfo(factionIndex)
							--	if (name == s.LOCATION) then
							--		att.reps[s.LOCATION] = earnedValue
							--		break
							--	end
							--	factionIndex = factionIndex + 1
							--until factionIndex > 200

							if att.reps[s.LOCATION].earned >= tonumber(s.ID_WOWHEAD) then
								text = "|TInterface\\AddOns\\Attune\\Images\\success:16|t"
								att.done[a.ID .. "-" .. s.ID] = 1
							end
						end

						--get QUEST accepts
						if s.TYPE == "Pick Up" then
							local eitherOnQuest = false
							local qIDs = Attune_split(s.ID_WOWHEAD, "|")
							for i=1, #qIDs do 
								if C_QuestLog.IsOnQuest(qIDs[i]) then
									eitherOnQuest = true
								end
							end
							if eitherOnQuest then
								att.done[a.ID .. "-" .. s.ID] = 1
							end
						end

						--get QUEST completion
						if s.TYPE == "Quest" or s.TYPE == "Turn In" then
							local eitherCompleted = false
							local qIDs = Attune_split(s.ID_WOWHEAD, "|")
							for i=1, #qIDs do 
								if IsQuestFlaggedCompleted(qIDs[i]) then
									eitherCompleted = true
								end
							end
							if eitherCompleted then
								att.done[a.ID .. "-" .. s.ID] = 1
							end
						end

						--get ITEM possession
						if s.TYPE == "Item" then
							local countNeeded = 1
							if s.COUNT ~= nil then countNeeded = s.COUNT end
							if GetItemCount(s.ID_WOWHEAD, 1) >= countNeeded then   --check bags and bank
								att.items[s.ID_WOWHEAD] = GetItemCount(s.ID_WOWHEAD, 1);
								att.done[a.ID .. "-" .. s.ID] = 1
							end
						end

						--get LEVEL progression
						if s.TYPE == "Level" then
							if UnitLevel('player') >= tonumber(s.ID_WOWHEAD) then
								att.done[a.ID .. "-" .. s.ID] = 1
							end
						end
					end
				end
			end
		end
	end

	-- some specific steps mean the whole achievement is complete. Close off the whole tree if those are done
	-- including a second pass to mark as done all non-trackable steps (interact/kill/past items) that belong to earlier (completed) quests
	Attune_SendPushInfo("TOON")
	Attune_CheckComplete(true)
	Attune_SendPushInfo("OVER")

	-- a third pass to mark as done all attunements used in further attunements
	for i, s in pairs(Attune_Data.steps) do
		--print(s.ID_ATTUNE.."-"..s.ID)
		if showPatchStep(s) then
			if s.TYPE == 'Attune' and att.attuned[s.ID_WOWHEAD] >= 100 then
				att.done[s.ID_ATTUNE.."-"..s.ID] = 1
			end
		end	
	end

end

-------------------------------------------------------------------------
-- Check full Attune completion
-------------------------------------------------------------------------

function Attune_CheckComplete(newComplete)
	local att = Attune_DB.toons[attunelocal_charKey]

	-- test
--	if att.done["0-40"] and att.attuned["0"] ~= 100 	then att.done["0-50"] = 1; 	Attune_SendPushInfo("0-50");	att.attuned["0"] = 100; Attune_UpdateTreeGroup("0"); newComplete = true; end	-- Debug
--	if att.done["1-55"] and att.attuned["1"] ~= 100 	then att.done["1-65"] = 1; 	Attune_SendPushInfo("1-65"); 	att.attuned["1"] = 100; Attune_UpdateTreeGroup("1"); newComplete = true;  end	-- Debug multi

	-- WoW
	if att.done["2-45"] and att.attuned["2"] ~= 100 	then att.done["2-50"] = 1; 	Attune_SendPushInfo("2-50"); 	att.attuned["2"] = 100; Attune_UpdateTreeGroup("2"); newComplete = true;  end	-- MC
	if att.done["3-268"] and att.attuned["3"] ~= 100	then att.done["3-270"] = 1; Attune_SendPushInfo("3-270"); 	att.attuned["3"] = 100; Attune_UpdateTreeGroup("3"); newComplete = true;  end	-- Ony Horde
	if att.done["4-265"] and att.attuned["4"] ~= 100	then att.done["4-270"] = 1; Attune_SendPushInfo("4-270"); 	att.attuned["4"] = 100; Attune_UpdateTreeGroup("4"); newComplete = true;  end	-- Ony Alliance
	if att.done["5-65"] and att.attuned["5"] ~= 100 	then att.done["5-70"] = 1; 	Attune_SendPushInfo("5-70"); 	att.attuned["5"] = 100; Attune_UpdateTreeGroup("5"); newComplete = true;  end	-- BWL
	if att.done["6-40"] and att.attuned["6"] ~= 100 	then att.done["6-90"] = 1; 	Attune_SendPushInfo("6-90"); 	att.attuned["6"] = 100; Attune_UpdateTreeGroup("6"); newComplete = true;  end	-- Naxx
	if att.done["6-50"] and att.attuned["6"] ~= 100 	then att.done["6-90"] = 1; 	Attune_SendPushInfo("6-90"); 	att.attuned["6"] = 100; Attune_UpdateTreeGroup("6"); newComplete = true;  end	-- Naxx
	if att.done["6-60"] and att.attuned["6"] ~= 100 	then att.done["6-90"] = 1; 	Attune_SendPushInfo("6-90"); 	att.attuned["6"] = 100; Attune_UpdateTreeGroup("6"); newComplete = true;  end	-- Naxx
	if att.done["8-200"] and att.attuned["8"] ~= 100 	then att.done["8-210"] = 1; Attune_SendPushInfo("8-210"); 	att.attuned["8"] = 100;	 Attune_UpdateTreeGroup("8"); newComplete = true;  end	-- MC Quintessence
	if att.done["10-960"] and att.attuned["10"] ~= 100 	then att.done["10-970"] = 1;Attune_SendPushInfo("10-970"); 	att.attuned["10"] = 100; Attune_UpdateTreeGroup("10"); newComplete = true;  end	-- scarab

	if att.done["12-65"] and att.attuned["12"] ~= 100 	then att.done["12-70"] = 1; Attune_SendPushInfo("12-70"); 	att.attuned["12"] = 100; Attune_UpdateTreeGroup("12"); newComplete = true;  end	-- brd key
	if att.done["14-130"] and att.attuned["14"] ~= 100 	then att.done["14-140"] = 1; Attune_SendPushInfo("14-140"); 	att.attuned["14"] = 100; Attune_UpdateTreeGroup("14"); newComplete = true;  end	-- scholo Horde
	if att.done["15-130"] and att.attuned["15"] ~= 100 	then att.done["15-140"] = 1; Attune_SendPushInfo("15-140"); 	att.attuned["15"] = 100; Attune_UpdateTreeGroup("15"); newComplete = true;  end	-- scholo Alliance


	-- TBC
	if att.done["20-85"] and att.attuned["20"] ~= 100 	then att.done["20-90"] = 1; 	Attune_SendPushInfo("20-90"); 	att.attuned["20"] = 100; Attune_UpdateTreeGroup("20"); newComplete = true;  end		-- SH Horde
	if att.done["21-85"] and att.attuned["21"] ~= 100 	then att.done["21-90"] = 1; 	Attune_SendPushInfo("21-90"); 	att.attuned["21"] = 100; Attune_UpdateTreeGroup("21"); newComplete = true;  end		-- SH Alliance
	if att.done["30-20"] and att.attuned["30"] ~= 100 	then att.done["30-30"] = 1; 	Attune_SendPushInfo("30-30"); 	att.attuned["30"] = 100; Attune_UpdateTreeGroup("30"); newComplete = true;  end		-- Shadow Lab
	if att.done["40-90"] and att.attuned["40"] ~= 100 	then att.done["40-100"] = 1; 	Attune_SendPushInfo("40-100"); 	att.attuned["40"] = 100; Attune_UpdateTreeGroup("40"); newComplete = true;  end		-- Black Morass
	if att.done["80-160"] and att.attuned["80"] ~= 100 	then att.done["80-180"] = 1; 	Attune_SendPushInfo("80-180"); 	att.attuned["80"] = 100; Attune_UpdateTreeGroup("80"); newComplete = true;  end		-- Arcatraz

	if att.done["104-20"] and att.attuned["104"] ~= 100 	then att.done["104-30"] = 1; 	Attune_SendPushInfo("104-30"); 	att.attuned["104"] = 100; Attune_UpdateTreeGroup("104"); newComplete = true;  end	-- Thrallmar
	if att.done["105-20"] and att.attuned["105"] ~= 100 	then att.done["105-30"] = 1; 	Attune_SendPushInfo("105-30"); 	att.attuned["105"] = 100; Attune_UpdateTreeGroup("105"); newComplete = true;  end	-- HH
	if att.done["106-20"] and att.attuned["106"] ~= 100 	then att.done["106-30"] = 1; 	Attune_SendPushInfo("106-30"); 	att.attuned["106"] = 100; Attune_UpdateTreeGroup("106"); newComplete = true;  end	-- CE
	if att.done["107-20"] and att.attuned["107"] ~= 100 	then att.done["107-30"] = 1; 	Attune_SendPushInfo("107-30"); 	att.attuned["107"] = 100; Attune_UpdateTreeGroup("107"); newComplete = true;  end	-- Lower City
	if att.done["108-20"] and att.attuned["108"] ~= 100 	then att.done["108-30"] = 1; 	Attune_SendPushInfo("108-30"); 	att.attuned["108"] = 100; Attune_UpdateTreeGroup("108"); newComplete = true;  end	-- Shatar
	if att.done["109-20"] and att.attuned["109"] ~= 100 	then att.done["109-30"] = 1; 	Attune_SendPushInfo("109-30"); 	att.attuned["109"] = 100; Attune_UpdateTreeGroup("109"); newComplete = true;  end	-- CoT
	if att.done["110-60"] and att.attuned["110"] ~= 100 	then att.done["110-70"] = 1; 	Attune_SendPushInfo("110-70"); 	att.attuned["110"] = 100; Attune_UpdateTreeGroup("110"); newComplete = true;  end	-- MgT

	if att.done["115-185"] and att.attuned["115"] ~= 100 	then att.done["115-190"] = 1; 	Attune_SendPushInfo("115-190"); 	att.attuned["115"] = 100; Attune_UpdateTreeGroup("115"); newComplete = true;  end	-- Kara
	if att.done["116-230"] and att.attuned["116"] ~= 100 	then att.done["116-240"] = 1; att.done["116-235"] = 1;	Attune_SendPushInfo("116-240"); 	att.attuned["116"] = 100; Attune_UpdateTreeGroup("116"); newComplete = true;  end	-- Nightbane Horde
	if att.done["118-230"] and att.attuned["118"] ~= 100 	then att.done["118-240"] = 1; att.done["118-235"] = 1; 	Attune_SendPushInfo("118-240"); 	att.attuned["118"] = 100; Attune_UpdateTreeGroup("118"); newComplete = true;  end	-- Nightbane Alliance
	if att.done["120-95"] and att.attuned["120"] ~= 100 	then att.done["120-110"] = 1; 	Attune_SendPushInfo("120-110"); 	att.attuned["120"] = 100; Attune_UpdateTreeGroup("120"); newComplete = true;  end	-- SSC
	if att.done["140-460"] and att.attuned["140"] ~= 100 	then att.done["140-480"] = 1; 	Attune_SendPushInfo("140-480"); 	att.attuned["140"] = 100; Attune_UpdateTreeGroup("140"); newComplete = true;  end	-- The Eye Horde
	if att.done["160-460"] and att.attuned["160"] ~= 100 	then att.done["160-480"] = 1; 	Attune_SendPushInfo("160-480"); 	att.attuned["160"] = 100; Attune_UpdateTreeGroup("160"); newComplete = true;  end	-- The Eye Alliance
	if att.done["170-80"] and att.attuned["170"] ~= 100 	then att.done["170-90"] = 1; 	Attune_SendPushInfo("170-90"); 		att.attuned["170"] = 100; Attune_UpdateTreeGroup("170"); newComplete = true;  end	-- Hyjal Alliance
	if att.done["180-80"] and att.attuned["180"] ~= 100 	then att.done["180-90"] = 1; 	Attune_SendPushInfo("180-90"); 		att.attuned["180"] = 100; Attune_UpdateTreeGroup("180"); newComplete = true;  end	-- Hyjal Horde
	if att.done["190-260"] and att.attuned["190"] ~= 100 	then att.done["190-280"] = 1; 	Attune_SendPushInfo("190-280"); 	att.attuned["190"] = 100; Attune_UpdateTreeGroup("190"); newComplete = true;  end	-- BT Horde
	if att.done["200-260"] and att.attuned["200"] ~= 100 	then att.done["200-280"] = 1; 	Attune_SendPushInfo("200-280"); 	att.attuned["200"] = 100; Attune_UpdateTreeGroup("200"); newComplete = true;  end	-- BT Alliance

	if att.done["250-110"] and att.attuned["250"] ~= 100 	then att.done["250-120"] = 1; 	Attune_SendPushInfo("250-120"); 	att.attuned["250"] = 100; Attune_UpdateTreeGroup("250"); newComplete = true;  end	-- Ogrila
	if att.done["260-110"] and att.attuned["260"] ~= 100 	then att.done["260-120"] = 1; 	Attune_SendPushInfo("260-120"); 	att.attuned["260"] = 100; Attune_UpdateTreeGroup("260"); newComplete = true;  end	-- Netherwing


	if att.done["300-290"] and att.attuned["300"] ~= 100 	then att.done["300-300"] = 1; 	Attune_SendPushInfo("300-300"); 	att.attuned["300"] = 100; Attune_UpdateTreeGroup("300"); newComplete = true;  end	-- Wrathgate Horde
	if att.done["310-400"] and att.attuned["310"] ~= 100 	then att.done["310-410"] = 1; 	Attune_SendPushInfo("310-410"); 	att.attuned["310"] = 100; Attune_UpdateTreeGroup("310"); newComplete = true;  end	-- Wrathgate Alliance
	if att.done["330-380"] and att.attuned["330"] ~= 100 	then att.done["330-390"] = 1; 	Attune_SendPushInfo("330-390"); 	att.attuned["330"] = 100; Attune_UpdateTreeGroup("330"); newComplete = true;  end	-- Sons of Hodir
	if att.done["340-140"] and att.attuned["340"] ~= 100 	then att.done["340-150"] = 1; 	Attune_SendPushInfo("340-150"); 	att.attuned["340"] = 100; Attune_UpdateTreeGroup("340"); newComplete = true;  end	-- Ebon Blade Horde
	if att.done["350-140"] and att.attuned["350"] ~= 100 	then att.done["350-150"] = 1; 	Attune_SendPushInfo("350-150"); 	att.attuned["350"] = 100; Attune_UpdateTreeGroup("350"); newComplete = true;  end	-- Ebon Blade Alliance
	if att.done["370-50"] and att.attuned["370"] ~= 100 	then att.done["370-60"] = 1; 	Attune_SendPushInfo("370-60"); 		att.attuned["370"] = 100; Attune_UpdateTreeGroup("370"); att.done["360-55"] = 1; newComplete = true;  end	-- Malygos 25 -- this also pushes the sub attunement in Maly 10
	if att.done["360-55"] 									then att.done["360-50"] = 1; 	Attune_SendPushInfo("360-50"); 		newComplete = true;  end	-- Malygos 10 (granted via Malygos 25)
	if att.done["360-50"] and att.attuned["360"] ~= 100 	then att.done["360-60"] = 1; 	Attune_SendPushInfo("360-60"); 		att.attuned["360"] = 100; Attune_UpdateTreeGroup("360"); newComplete = true;  end	-- Malygos 10 (granted via quest)

	if newComplete then 
		for i, s in Attune_spairs(Attune_Data.steps, function(t,a,b) 	return tonumber(t[b].ID) > tonumber(t[a].ID) end) do
			if showPatchStep(s) then
				if att.done[s.ID_ATTUNE .. "-" .. s.ID] then
					-- recurse into earlier steps to mark them as done too
					C_Timer.After(0.01, function() Attune_recursePreviousSteps(attunelocal_charKey, s.ID_ATTUNE, s.FOLLOWS) end)
				end
			end
		end
	end
	Attune_CheckIsNext(attunelocal_charKey)
end

-------------------------------------------------------------------------
-- Check which step is next
-------------------------------------------------------------------------

function Attune_CheckIsNext(who)
	local att = Attune_DB.toons[who]
	--print("Checking "..who)
	-- blank the array
	att.next = {}

	for i, step in pairs(Attune_Data.steps) do
		if showPatchStep(step) then

			if (step.ID_ATTUNE == "190" and step.ID == "120") then debug = true else debug=false end

			local next = false
			if  att.done[step.ID_ATTUNE .. "-" .. step.ID] ~= nil then
				-- if done, then not isnext
				next = false
			else

				local followOR = false
				local fIDs = Attune_split(step.FOLLOWS, "&")
				if string.find(step.FOLLOWS, "|") then fIDs = Attune_split(step.FOLLOWS, "|"); followOR = true end

				if followOR then
					next = false
					for fi, flw in pairs(fIDs) do
						if  att.done[step.ID_ATTUNE .. "-" .. flw] then next = true end
					end

				else
					next = true
					for fi, flw in pairs(fIDs) do
						if  att.done[step.ID_ATTUNE .. "-" .. flw] == nil or att.done[step.ID_ATTUNE .. "-" .. flw] == false then next = false end
					end
		
				end
				if step.FOLLOWS == "0" then next = true end
			end

			if next then
				att.next[step.ID_ATTUNE .. "-" .. step.ID] = 1
			else
				att.next[step.ID_ATTUNE .. "-" .. step.ID] = nil
			end
		end
	end
end

-------------------------------------------------------------------------
-- Update the treeview to show completed attunes
-------------------------------------------------------------------------

function Attune_UpdateTreeGroup(aid)

	for i, a in pairs(Attune_Data.attunes) do
		if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
			if a.ID == aid then

				-- parse expacs
				for iE, aE in pairs(attunelocal_tree) do
					if aE.value == a.EXPAC then

						-- parse groups
						for iG, aG in pairs(aE.children) do
							if aG.value == a.GROUP then

								local groupAllDone = true
								for iA, aA in pairs(aG.children) do
									if aA.value == a.ID then
										aA.text = "|cff00ff00"..aA.text.."|r"
										aA.icon = "Interface\\AddOns\\Attune\\Images\\success"
									end
									if aA.icon ~= "Interface\\AddOns\\Attune\\Images\\success" then 
										groupAllDone = false
									end
								end
								if groupAllDone then 
									aG.text = "|cff00ff00"..aG.text.."|r"
								end
							end
						end
					end
				end
			end
		end
	end

end

-------------------------------------------------------------------------
-- Recurse through previous steps (following the FOLLOWS path)
-------------------------------------------------------------------------

function Attune_recursePreviousSteps(who, aID, follows)

	if (Attune_DB.toons[who] ~= nil) then
		if (Attune_DB.toons[who].done ~= nil) then

			-- there can be multi-follows (for example FOLLOW=160|170)
			-- We need to recurse both paths
			local fIDs = Attune_split(follows, "&")
			if string.find(follows, "|") then fIDs = Attune_split(follows, "|") end

			for fi, f in pairs(fIDs) do
				for i, s in pairs(Attune_Data.steps) do
					if showPatchStep(s) then
						if s.ID_ATTUNE == aID and s.ID == f then
							if string.find(follows, "|") == nil then -- don't recurse OR, as we don't know which parent was actually done
								if Attune_DB.toons[who].done[s.ID_ATTUNE .. "-" .. s.ID] ~= 1 then
									Attune_DB.toons[who].done[s.ID_ATTUNE .. "-" .. s.ID] = 1
									if (who == attunelocal_charKey) then Attune_SendPushInfo(s.ID_ATTUNE .. "-" .. s.ID) end
								end
								if follows ~= 0 then -- no need to recurse first level
									Attune_recursePreviousSteps(who, s.ID_ATTUNE, s.FOLLOWS)
								end
							end
						end
					end
				end
			end
		end
	end
end

-------------------------------------------------------------------------
-- Load the data into the TreeGroup object (nodes/leaves)
-------------------------------------------------------------------------

function Attune_LoadTree()
	attunelocal_tree = {}
	local expac = ""
	local group = ""
	local expacNode = {}
	local groupNode = {}
	local groupAllDone = true

	for i, a in pairs(Attune_Data.attunes) do
		if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 

			--Group Level
			if group ~= a.GROUP or expac ~= a.EXPAC then 

				if group ~= "" then
					if groupAllDone then groupNode.text = "|cff00ff00"..groupNode.text.."|r"; end
					table.insert(expacNode.children, groupNode)
				end

				--Top level
				if expac ~= a.EXPAC then

					if expac ~= "" then
						table.insert(attunelocal_tree, expacNode)
					end

					-- new expac array
					expacNode = {
						value = a.EXPAC,
						text =  a.EXPAC,
						children = {}
					}
					expac = a.EXPAC
				end

				-- new group array
				groupNode = {
					value = a.GROUP,
					text =  "|cffA0A0A0"..a.GROUP.."|r",
					children = {}
				}
				group = a.GROUP
				groupAllDone = true
			end

			if a.FACTION == UnitFactionGroup("player") or a.FACTION == 'Both' then

				local text = a.NAME
				local icon = a.ICON
				if Attune_DB.toons[attunelocal_charKey].attuned ~= nil then
					if Attune_DB.toons[attunelocal_charKey].attuned[a.ID] >= 100 then
						text = "|cff00ff00"..text.."|r"
						icon = "Interface\\AddOns\\Attune\\Images\\success"
					else 
						groupAllDone = false
					end
				end


				local attuneNode = {
					value = a.ID,
					text = text,
					icon = icon

				}
				-- "Interface\\Icons\\" ..
				--icon = "Interface\\AddOns\\Attune\\Images\\" .. a.ICON
					table.insert(groupNode.children, attuneNode)
			end
		end
	end
	--table.insert(groupNode.children, attuneNode)
	table.insert(expacNode.children, groupNode)
	table.insert(attunelocal_tree, expacNode)

end


-------------------------------------------------------------------------

function Attune_SaveTreeExpandStatus()
	if attunelocal_treeframe ~= nil then 
		for lineId, expanded in pairs(attunelocal_treeframe.localstatus.groups) do
			if expanded then TreeExpandStatus[lineId] = 1 else TreeExpandStatus[lineId] = 0 end
		end
	end
end


-------------------------------------------------------------------------
-- Create the Main UI Frame
-------------------------------------------------------------------------

function Attune_Frame()

	guildName, guildRankName, guildRankIndex = GetGuildInfo("player");
	if guildName ~= nil then attunelocal_myguild = guildName end


	attunelocal_frame = AceGUI:Create("Frame", "AttuneFrame")
	attunelocal_frame:SetTitle("  Attune")
	attunelocal_frame:SetStatusText(attunelocal_statusText)

	--print(attunelocal_frame.frame:GetAlpha())
	--attunelocal_raidspotIcon[found].frame:SetAlpha(0.25)
	attunelocal_frame:SetStatusText(attunelocal_statusText)

	attunelocal_frame:SetHeight(Attune_DB.height)
	attunelocal_frame:SetWidth(Attune_DB.width)

	attunelocal_frame.frame:SetScript("OnSizeChanged", function(self)
		local hh = self:GetHeight()
		local ww = self:GetWidth()
		if hh > self:GetParent():GetHeight() - 50 	then hh = self:GetParent():GetHeight() - 50; self:SetHeight(hh) end
		if ww > self:GetParent():GetWidth() - 50 	then ww = self:GetParent():GetWidth() - 50; self:SetWidth(ww) end
		Attune_DB.height = hh
		Attune_DB.width = ww
	end)


	--attunelocal_frame.frame:SetHeight(Attune_DB.height)
	--attunelocal_frame.frame:SetWidth(Attune_DB.width)

	if attunelocal_frame.frame.SetResizeBounds then
		attunelocal_frame.frame:SetResizeBounds(1010, 550)
	else
		attunelocal_frame.frame:SetMinResize(1010, 550)
	end
	attunelocal_frame.frame:SetFrameStrata("HIGH")


	-- Hacking into the Ace3 frame to reduce the size of the statusbox, to allow us room for other buttons
	local closebutton, statusbg, _, _, _, _, _ = attunelocal_frame.content.obj.frame:GetChildren()
	statusbg:ClearAllPoints()
	statusbg:SetPoint("BOTTOMLEFT", 15, 15)     -- taken from AceGUIContainer-Frame.lua
	statusbg:SetPoint("BOTTOMRIGHT", -360, 15)  -- taken from AceGUIContainer-Frame.lua, modified from -132

	closebutton:SetWidth(80)
	closebutton:SetScript("OnClick", function()
		attunelocal_export_frame.frame:Hide() -- close other submenu
		attunelocal_survey_frame.frame:Hide() -- close other submenu
		attunelocal_frame:Hide()
		Attune_SaveTreeExpandStatus()
		Attune_Release()
	end)


	-- SURVEY BUTTON
	local surveybutton = CreateFrame("Button", nil, attunelocal_frame.content.obj.frame, "UIPanelButtonTemplate")
	surveybutton:SetPoint("BOTTOMRIGHT", -276, 17)
	surveybutton:SetFrameStrata("DIALOG")
	surveybutton:SetHeight(20)
	surveybutton:SetWidth(80)
	surveybutton:SetText(Lang["Survey"])
	--if attunelocal_myguild == "" then surveybutton:Disable() end
	surveybutton:SetScript("OnEnter", function() attunelocal_frame:SetStatusText(Lang["Survey_DESC"]) end)
	surveybutton:SetScript("OnLeave", function() attunelocal_frame:SetStatusText(attunelocal_statusText) end)
	surveybutton:SetScript("OnClick", function()
		if attunelocal_survey_frame.frame:IsShown() then
			attunelocal_survey_frame.frame:Hide()
		else
			attunelocal_export_frame.frame:Hide() -- close other submenu
			attunelocal_survey_frame.frame:Show()
		end
	end)

	-- SURVEY SUB MENU
		attunelocal_survey_frame = AceGUI:Create("InlineGroup")
		attunelocal_survey_frame:SetLayout("Flow")
		attunelocal_survey_frame:SetWidth(160)
		attunelocal_survey_frame:SetPoint("TOPLEFT", surveybutton,"BOTTOMLEFT", 0, 10)
		attunelocal_survey_frame.frame:Hide()

		local surveyTarget = AceGUI:Create("Button")
		surveyTarget:SetText(Lang["Target"])
		surveyTarget:SetCallback("OnClick", function()
			attunelocal_survey_frame.frame:Hide()
			Attune_SendRequest("Target|" .. UnitName("target"))
		end)
		attunelocal_survey_frame:AddChild(surveyTarget)

		local surveyGuild = AceGUI:Create("Button")
		surveyGuild:SetText(Lang["Guild"])
		surveyGuild:SetCallback("OnClick", function()
			attunelocal_survey_frame.frame:Hide()
			Attune_SendRequest("Guild")
		end)
		attunelocal_survey_frame:AddChild(surveyGuild)

		local surveyParty = AceGUI:Create("Button")
		surveyParty:SetText(Lang["Party"])
		surveyParty:SetCallback("OnClick", function()
			attunelocal_survey_frame.frame:Hide()
			Attune_SendRequest("Party")
		end)
		attunelocal_survey_frame:AddChild(surveyParty)

		local surveyRaid = AceGUI:Create("Button")
		surveyRaid:SetText(Lang["Raid"])
		surveyRaid:SetCallback("OnClick", function()
			attunelocal_survey_frame.frame:Hide()
			Attune_SendRequest("Raid")
		end)
		attunelocal_survey_frame:AddChild(surveyRaid)

		local surveyClose = AceGUI:Create("Button")
		surveyClose:SetText(Lang["Close"])
		surveyClose:SetCallback("OnClick", function(slid)	attunelocal_survey_frame.frame:Hide()	end)
		attunelocal_survey_frame:AddChild(surveyClose)

	-- EXPORT BUTTON
	local exportbutton = CreateFrame("Button", nil, attunelocal_frame.content.obj.frame, "UIPanelButtonTemplate")
	exportbutton:SetPoint("BOTTOMRIGHT", -193, 17)
	exportbutton:SetFrameStrata("DIALOG")
	exportbutton:SetHeight(20)
	exportbutton:SetWidth(80)
	exportbutton:SetText(Lang["Export"])
	exportbutton:SetScript("OnEnter", function() attunelocal_frame:SetStatusText(Lang["Export_DESC"]) end)
	exportbutton:SetScript("OnLeave", function() attunelocal_frame:SetStatusText(attunelocal_statusText) end)
	exportbutton:SetScript("OnClick", function()

		if attunelocal_export_frame.frame:IsShown() then
			attunelocal_export_frame.frame:Hide()
		else
			attunelocal_survey_frame.frame:Hide() -- close other submenu
			attunelocal_export_frame.frame:Show()
		end
	end)

	-- EXPORT SUB MENU
		attunelocal_export_frame = AceGUI:Create("InlineGroup")
		attunelocal_export_frame:SetLayout("Flow")
		attunelocal_export_frame:SetWidth(160)
		attunelocal_export_frame:SetPoint("TOPLEFT", exportbutton,"BOTTOMLEFT", 0, 10)
		attunelocal_export_frame.frame:Hide()

		local exportThisToon = AceGUI:Create("Button")
		exportThisToon:SetText(Lang["This Toon"])
		exportThisToon:SetCallback("OnClick", function()
			attunelocal_export_frame.frame:Hide()
			attunelocal_exportselection = 0
			Attune_ExportToWebsite()
		end)
		attunelocal_export_frame:AddChild(exportThisToon)

		local exportMyData = AceGUI:Create("Button")
		exportMyData:SetText(Lang["My Data"])
		exportMyData:SetCallback("OnClick", function()
			attunelocal_export_frame.frame:Hide()
			attunelocal_exportselection = 4
			Attune_ExportToWebsite()
		end)
		attunelocal_export_frame:AddChild(exportMyData)

		local exportLastSurvey = AceGUI:Create("Button")
		exportLastSurvey:SetText(Lang["Last Survey"])
		exportLastSurvey:SetCallback("OnClick", function()
			attunelocal_export_frame.frame:Hide()
			attunelocal_exportselection = 1
			Attune_ExportToWebsite()
		end)
		attunelocal_export_frame:AddChild(exportLastSurvey)

		local exportGuildData = AceGUI:Create("Button")
		exportGuildData:SetText(Lang["Guild Data"])
		exportGuildData:SetCallback("OnClick", function()
			attunelocal_export_frame.frame:Hide()
			attunelocal_exportselection = 2
			Attune_ExportToWebsite()
		end)
		attunelocal_export_frame:AddChild(exportGuildData)

		local exportAll = AceGUI:Create("Button")
		exportAll:SetText(Lang["All Data"])
		exportAll:SetCallback("OnClick", function()
			attunelocal_export_frame.frame:Hide()
			attunelocal_exportselection = 3
			Attune_ExportToWebsite()
		end)
		attunelocal_export_frame:AddChild(exportAll)

		local exportClose = AceGUI:Create("Button")
		exportClose:SetText(Lang["Close"])
		exportClose:SetCallback("OnClick", function()	attunelocal_export_frame.frame:Hide()	end)
		attunelocal_export_frame:AddChild(exportClose)

	-- GUILD BUTTON
	local guildbutton = CreateFrame("Button", "GuildButton", attunelocal_frame.content.obj.frame, "UIPanelButtonTemplate")
	guildbutton:SetPoint("BOTTOMRIGHT", -110, 17)
	guildbutton:SetFrameStrata("DIALOG")
	guildbutton:SetHeight(20)
	guildbutton:SetWidth(80)
	guildbutton:SetText(Lang["Results"])
	--if attunelocal_myguild == "" then guildbutton:Disable() end
	guildbutton:SetScript("OnEnter", function() attunelocal_frame:SetStatusText(Lang["Toggle_DESC"]) end)
	guildbutton:SetScript("OnLeave", function() attunelocal_frame:SetStatusText(attunelocal_statusText) end)
	guildbutton:SetScript("OnClick", function()
		attunelocal_export_frame.frame:Hide() -- close other submenu
		attunelocal_survey_frame.frame:Hide() -- close other submenu
		Attune_ToggleView()

	end)

    -- Register the global variable `Attune_MainFrame` as a "special frame"
    -- so that it is closed when the escape key is pressed.
	_G["Attune_MainFrame"] = attunelocal_frame.frame
    tinsert(UISpecialFrames, "Attune_MainFrame")
	_G["Attune_ExportMenuFrame"] = attunelocal_export_frame.frame
    tinsert(UISpecialFrames, "Attune_ExportMenuFrame")
	_G["Attune_SurveyMenuFrame"] = attunelocal_survey_frame.frame
    tinsert(UISpecialFrames, "Attune_SurveyMenuFrame")

	Attune_ToggleView()

end

-------------------------------------------------------------------------
-- Display the attune after it being selected in tree
-------------------------------------------------------------------------

function Attune_Select(attuneId)
	PlaySound(856)  --igMainMenuOptionCheckBoxOn
	local scrollframe = attunelocal_scroll.content.obj.content

	attunelocal_scroll:ReleaseChildren()

	local att = Attune_DB.toons[attunelocal_charKey]

	-- Display Title
	for i, a in pairs(Attune_Data.attunes) do
		if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
			if (a.ID == attuneId) then

				attunelocal_brokerlabel = a.NAME
				if Attune_DB.toons[attunelocal_charKey].attuned[attuneId] ~= nil then
					attunelocal_brokervalue = Attune_DB.toons[attunelocal_charKey].attuned[attuneId].."%"
				else
					attunelocal_brokervalue = "0%"
				end
				Attune_Broker.text = attunelocal_brokervalue

				local titlebutton = AceGUI:Create("SimpleGroup")
				titlebutton:SetLayout("Flow")
				titlebutton:SetFullWidth(true)

					local label = AceGUI:Create("Label")
					label:SetText(a.NAME)
					label:SetImage(a.ICON)
					label:SetFont(GameFontNormal:GetFont(), 24)
					label:SetImageSize(32,32)
					label:SetRelativeWidth(0.9)
					titlebutton:AddChild(label)

					local mini = AceGUI:Create("Button")
					mini:SetText(Attune_DB.mini and Lang["Maxi"] or Lang["Mini"])
					mini:SetWidth(70)
					mini:SetCallback("OnClick", function()
						Attune_DB.mini = not Attune_DB.mini
						Attune_ForceAttuneTabRefresh()
					end)
					titlebutton:AddChild(mini)


				attunelocal_scroll:AddChild(titlebutton)

				-- spacer
				local label = AceGUI:Create("Label")
				label:SetText(" ")
				label:SetFullWidth(true)
				label:SetFont(GameFontHighlight:GetFont(), 20)
				attunelocal_scroll:AddChild(label)

				-- desc
				local label = AceGUI:Create("Label")
				label:SetText(a.DESC)
				label:SetFullWidth(true)
				label:SetFont(GameFontNormal:GetFont(), 12)
				attunelocal_scroll:AddChild(label)
			end
		end
	end

	-- spacer
	local label = AceGUI:Create("Label")
	label:SetText(" ")
	label:SetFullWidth(true)
	label:SetFont(GameFontHighlight:GetFont(), 20)
	attunelocal_scroll:AddChild(label)

	-- Hiding all non-Ace frames (all attune steps basically)
	for i, f in pairs(attunelocal_frames) do	_G[f]:Hide()	end


	-- Count the number of steps at each stage, to know how to center the frames
	local stageSteps = {} -- steps per stage
	for i, s in pairs(Attune_Data.steps) do
		if s.ID_ATTUNE == attuneId then
			if showPatchStep(s) then
				stageSteps[s.STAGE] = (stageSteps[s.STAGE] or 0) + 1
			end
		end
	end



	-- Create/position each step frame
	local yy = (Attune_DB.mini and 40 or 0)  -- allow a top margin when in mini mode
	local curStage = 0
	local nbStep = 0
	for i, s in Attune_spairs(Attune_Data.steps, function(t,a,b) 	return tonumber(t[b].STAGE)*10000 + tonumber(t[b].ID) > tonumber(t[a].STAGE)*10000 + tonumber(t[a].ID) end) do
		if s.ID_ATTUNE == attuneId then
			
			if showPatchStep(s) then 

				if s.STAGE ~= curStage then
					nbStep = 1
					curStage = s.STAGE
					yy = yy + (Attune_DB.mini and (attunelocal_MiniNode_VGap + attunelocal_MiniNode_Height) or (attunelocal_Node_VGap + attunelocal_Node_Height))
				end
				local xx = (stageSteps[s.STAGE] * (Attune_DB.mini and (attunelocal_MiniNode_Width + attunelocal_MiniNode_HGap) or (attunelocal_Node_Width + attunelocal_Node_HGap))) - (nbStep * (Attune_DB.mini and (attunelocal_MiniNode_Width + attunelocal_MiniNode_HGap) or (attunelocal_Node_Width + attunelocal_Node_HGap))) - (stageSteps[s.STAGE]-1) * ((Attune_DB.mini and (attunelocal_MiniNode_Width + attunelocal_MiniNode_HGap) or (attunelocal_Node_Width + attunelocal_Node_HGap))/2)
	
				Attune_CreateNode(s, scrollframe, xx, yy)
				nbStep = nbStep + 1
			end
		end
	end

	-- Ace 'mask' needed to trick the scroller into the right size, as it doesn't detect the custom frames.
	local mask = AceGUI:Create("SimpleGroup")
	mask:SetAutoAdjustHeight(false)
	mask:SetHeight(yy+50)
	mask:SetFullWidth(true)
	mask.frame:SetScript("OnEnter", function() end)
	mask.frame:SetScript("OnLeave", function() attunelocal_frame:SetStatusText(attunelocal_statusText)  end)
	attunelocal_scroll:AddChild(mask)



	-- This script needed to allow the scrollframe resize whenever content changes or vertical size is moved
	attunelocal_scroll.frame:SetScript("OnUpdate", function()
		attunelocal_scroll:SetHeight(yy+50)
	end)



end

-------------------------------------------------------------------------

function showPatchStep(s)
	local showStep = false
	if (s.VALIDFROM == nil and s.VALIDTO == nil) then 
		showStep = true
	else
		if (s.VALIDFROM ~= nil and patch >= s.VALIDFROM) then showStep = true end
		if (s.VALIDTO ~= nil and patch < s.VALIDTO) then showStep = true end
	end
	return showStep
end



-------------------------------------------------------------------------
-- Create the frame for a single attune step (node)
-------------------------------------------------------------------------

function Attune_CreateNode(step, parent, posX, posY)
	-- Generic look and feel for the node
	local PaneBackdrop  = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	}

	local countSameStep = 0
	local countCompleted = 0
	local listSameStep = ""
	local listCompleted = ""
	local dots1 = false
	local dots2 = false
	--calculate guildmembers on this stage
	for kt, t in Attune_spairs(Attune_DB.toons, function(t,a,b) return b > a end) do

		local filter = false

		if  Attune_DB.showListAlt then
			--show alts
			if t.owner == 1 then filter = true end
		else
			--show guildies
			if t.guild == attunelocal_myguild then filter = true end
		end

		if filter then
			-- calculate how many other toon has this step marked as IsNext
			if kt ~= attunelocal_charKey then
				if t.next ~= nil then
					if t.next[step.ID_ATTUNE .. "-" .. step.ID] ~= nil then
						countSameStep = countSameStep + 1
						if countSameStep <= tonumber(Attune_DB.maxListSize) then
							listSameStep = listSameStep .. "\n" .. Attune_split(kt, "-")[1]
						else
							if dots1 == false then
								listSameStep = listSameStep .. "\n..."
								dots1 = true
							end
						end

					end
				end
			end
			-- calculate how many toons have completed this attune
			if step.TYPE == "End" then
				if t.attuned ~= nil then
					if t.attuned[step.ID_ATTUNE] ~= nil then 
						if t.attuned[step.ID_ATTUNE] >= 100 then
							countCompleted = countCompleted + 1
							if countCompleted <= tonumber(Attune_DB.maxListSize) then
								listCompleted = listCompleted .. "\n" .. Attune_split(kt, "-")[1]
							else
								if dots2 == false then
									listCompleted = listCompleted .. "\n..."
									dots2 = true
								end
							end
						end
					end
				end
			end
		end
	end

	if  Attune_DB.showListAlt then
		if listSameStep ~= "" then
			listSameStep = "\n\n|cff00ff00"..Lang["Alts on this step"]..":|r" .. listSameStep
		end
		if listCompleted ~= "" then
			listCompleted = "\n\n|cff00ff00"..Lang["Attuned alts"]..":|r" .. listCompleted
		end
	else
		if listSameStep ~= "" then
			listSameStep = "\n\n|cff00ff00"..Lang["Guild members on this step"]..":|r" .. listSameStep
		end
		if listCompleted ~= "" then
			listCompleted = "\n\n|cff00ff00"..Lang["Attuned guild members"]..":|r" .. listCompleted
		end
	end



	-- check whether the step has been done
	if Attune_DB.toons[attunelocal_charKey].done == nil then Attune_DB.toons[attunelocal_charKey].done = {}  end
	local done = Attune_DB.toons[attunelocal_charKey].done[step.ID_ATTUNE .. "-" .. step.ID]

	local countNeeded = 1
	if step.COUNT ~= nil then countNeeded = step.COUNT end

	-- main node frame, reuse if possible
	local fnode
	local exist = false
	for _, f in ipairs(attunelocal_frames) do if f == "Attune_Node_"..step.ID then exist = true end end
	if exist then 	fnode = _G["Attune_Node_"..step.ID] -- reusing
	else			fnode = CreateFrame("Button", "Attune_Node_"..step.ID, parent, BackdropTemplateMixin and "BackdropTemplate" or nil)
					table.insert(attunelocal_frames, "Attune_Node_"..step.ID) -- recording, to reuse
	end
	fnode:SetParent(parent)
	fnode:SetWidth(Attune_DB.mini and attunelocal_MiniNode_Width or attunelocal_Node_Width)
	fnode:SetHeight(Attune_DB.mini and attunelocal_MiniNode_Height or attunelocal_Node_Height)
	fnode:SetPoint("TOP", posX, -posY)
	fnode:SetScript("OnMouseUp", function(self, button) end)
	fnode:SetScript("OnEnter", function()

		-- put full step info in status bar
		--if step.TYPE ~= "Spacer" then attunelocal_frame:SetStatusText(step.STEP) end

		-- display Item link or quest tooltip on hover
		if step.TYPE == "Item" then
			if countNeeded == 1 then
				attunelocal_frame:SetStatusText(Lang["I_"..step.ID_WOWHEAD])
			else
				attunelocal_frame:SetStatusText(Lang["I_"..step.ID_WOWHEAD] .. " (" .. Attune_DB.toons[attunelocal_charKey].items[step.ID_WOWHEAD] .. "/" .. countNeeded .. ")")
			end
			GameTooltip:SetOwner(fnode,"ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", fnode,"TOPRIGHT", 10, 0)
			GameTooltip:SetHyperlink("item:"..step.ID_WOWHEAD)

			fnode:SetScript("OnMouseUp", function(self, button)
				if button == "RightButton" then Attune_ShowWebsiteURL("item=" .. step.ID_WOWHEAD)	end
			end)

		elseif step.TYPE == "End" then
			GameTooltip:SetOwner(fnode,"ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", fnode,"TOPRIGHT", 10, 0)
			GameTooltip:SetText(Lang["AttuneColors"])
			if listCompleted ~= "" and Attune_DB.showList then GameTooltip:AddLine(listCompleted, 1, 1, 1, 1) end

		elseif step.TYPE == "Level" then
			GameTooltip:SetOwner(fnode,"ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", fnode,"TOPRIGHT", 10, 0)
			GameTooltip:SetText(Lang["Minimum Level"])

		elseif step.TYPE == "Rep" then
			GameTooltip:SetOwner(fnode,"ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", fnode,"TOPRIGHT", 10, 0)
			local tempRep = Attune_DB.toons[attunelocal_charKey].reps[step.LOCATION].earned
			local tempGoal = step.ID_WOWHEAD
			if tonumber(tempRep) > tonumber(step.ID_WOWHEAD) then tempRep = step.ID_WOWHEAD end

			attunelocal_frame:SetStatusText("" .. Attune_DB.toons[attunelocal_charKey].reps[step.LOCATION].name)
			GameTooltip:SetText("" .. Attune_DB.toons[attunelocal_charKey].reps[step.LOCATION].name)
			GameTooltip:AddLine(Lang["Current progress"]..": ".. tempRep .. "/" ..step.ID_WOWHEAD, 0.5, 0.5, 0.5, 1)
			if step.OFFSET ~= nil then
				tempGoal = step.ID_WOWHEAD + step.OFFSET
				tempRep = tempRep + step.OFFSET
			end
			GameTooltip:AddLine(Lang["Completion"]..": " .. math.floor(100*tonumber(tempRep)/tonumber(tempGoal)).."%", 0.5, 0.5, 0.5, 1)

			fnode:SetScript("OnMouseUp", function(self, button)
				if button == "RightButton" then Attune_ShowWebsiteURL("faction=" .. step.LOCATION)	end
			end)

		elseif step.TYPE == "Quest" or step.TYPE == "Pick Up" or step.TYPE == "Turn In" then
			attunelocal_frame:SetStatusText(Lang["Q1_"..step.ID_WOWHEAD])
			GameTooltip:SetOwner(fnode,"ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", fnode,"TOPRIGHT", 10, 0)

			local quest = Attune_Data.quests[tonumber(step.ID_WOWHEAD)]
			if string.find(step.ID_WOWHEAD, "|") then 
				quest = Attune_Data.quests[tonumber(Attune_split(step.ID_WOWHEAD, "|")[1])]
			end
			if quest == nil then
				-- error message if quest is not in AttuneData.lua
				GameTooltip:SetText(Lang["Quest information not found"].." (ID "..step.ID_WOWHEAD..")", 1, 0.5, 0.5, 1)
			else
				-- build tooltip
				GameTooltip:SetText(Lang["Q1_"..step.ID_WOWHEAD])
				GameTooltip:AddLine(Lang["Requires level"].." "..quest[1].."\n\n", 0.5, 0.5, 0.5, 1)
				if quest[2] == 1 then
					GameTooltip:AddLine(Lang["Solo quest"].."\n\n", 0.373, 0.729, 0.275, 1)
				elseif quest[2] <= 5 then
					GameTooltip:AddLine(Lang["Party quest"]:gsub("##NB##", quest[2]).."\n\n", 0.851, 0.608, 0.0, 1)
				else
					GameTooltip:AddLine(Lang["Raid quest"]:gsub("##NB##", quest[2]).."\n\n", 0.857, 0.055, 0.075, 1)
				end
				if Lang["Q2_"..step.ID_WOWHEAD] ~= nil then GameTooltip:AddLine(Lang["Q2_"..step.ID_WOWHEAD], 1, 1, 1, 1, true) end

				fnode:SetScript("OnMouseUp", function(self, button)
					if button == "RightButton" then Attune_ShowWebsiteURL("quest=" .. step.ID_WOWHEAD)	end
				end)
			end

		elseif step.TYPE == "Kill" or step.TYPE == "Interact" then
			attunelocal_frame:SetStatusText(Lang["N1_"..step.ID_WOWHEAD])
			GameTooltip:SetOwner(fnode,"ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", fnode,"TOPRIGHT", 10, 0)
			local npc = Attune_Data.npcs[tonumber(step.ID_WOWHEAD)]
			if npc == nil then
				-- error message if quest is not in AttuneData.lua
				GameTooltip:SetText(Lang["NPC Not Found"].." (ID "..step.ID_WOWHEAD..")", 1, 0.5, 0.5, 1)
			else
				-- build tooltip
				GameTooltip:SetText(Lang["N1_"..step.ID_WOWHEAD])
				GameTooltip:AddLine(Lang["Level"].." "..npc[1].." "..npc[2].." "..npc[3].."\n", 0.851, 0.608, 0.0, 1)
				if Lang["N2_"..step.ID_WOWHEAD] ~= "" then
					GameTooltip:AddLine("\n"..Lang["N2_"..step.ID_WOWHEAD], 1, 1, 1, 1, true)
				end

				fnode:SetScript("OnMouseUp", function(self, button)
					if button == "RightButton" then Attune_ShowWebsiteURL("npc=" .. step.ID_WOWHEAD)	end
				end)
			end

		elseif step.TYPE == "Click" then
			GameTooltip:SetOwner(fnode,"ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", fnode,"TOPRIGHT", 10, 0)
			local other = Lang["O_"..step.ID_WOWHEAD]
			if other == nil then
				-- error message if quest is not in AttuneData.lua
				GameTooltip:SetText(Lang["Information not found"].." (ID "..step.ID_WOWHEAD..")", 1, 0.5, 0.5, 1)
			else
				-- build tooltip
				attunelocal_frame:SetStatusText(Lang[step.STEP])
				GameTooltip:SetText((Attune_DB.mini and step.STEP.."\n" or "") .. other)
			end



		-- change transparency if clickable sub-attune
		elseif step.TYPE == "Attune" then
			GameTooltip:SetOwner(fnode,"ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", fnode,"TOPRIGHT", 10, 0)
			GameTooltip:SetText(Lang["Click to navigate to that attunement"])

			if done then
				fnode:SetBackdropColor(0.055, 0.306, 0.576, 0.7 * 1.25) -- blue, attune
			else
				fnode:SetBackdropColor(0.557, 0.055, 0.075, 0.7 * 1.25)
			end
		end

		if listSameStep ~= "" and Attune_DB.showList then GameTooltip:AddLine(listSameStep, 1, 1, 1, 1) end
		GameTooltip:Show()

	end)
	fnode:SetScript("OnLeave", function()
		-- restore status text to default
		attunelocal_frame:SetStatusText(attunelocal_statusText)
		GameTooltip:Hide()
		-- restore  transparency for clickable sub-attunes
		if step.TYPE == "Attune" then
			if done then
				fnode:SetBackdropColor(0.055, 0.306, 0.576, 0.7) -- blue, attune
			else
				fnode:SetBackdropColor(0.557, 0.055, 0.075, 0.7) -- red
			end
		end
	end)
	fnode:SetScript("OnClick", function()

		-- shif-clicking items in chat
		if step.TYPE == "Item" then
			local _, link = GetItemInfo(tonumber(step.ID_WOWHEAD));
			if link then
				HandleModifiedItemClick(link);
			end
		-- shift clicking quests not working in Classic. Keep for TBC maybe it will work there
	--		elseif step.TYPE == "Quest" then
	--			local quest = Attune_Data.quests[tonumber(step.ID_WOWHEAD)]
	--			if quest and IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() then
	--				ChatEdit_InsertLink(format("|cffffff00|Hquest:%d:%d|h[%s]|h|r", tonumber(step.ID_WOWHEAD), 60, quest[1]));
	--			end

		-- navigate to sub-attunement
		elseif step.TYPE == "Attune" then
			--call sub attune
			for i, a in pairs(Attune_Data.attunes) do
				if (a.ID == step.ID_ATTUNE) then
					attunelocal_treeframe:SelectByPath(a.EXPAC.."\001".. a.GROUP.."\001"..step.ID_WOWHEAD)
					break
				end
			end
		end

	end)


	local next = false
	if step.TYPE ~= "Spacer" then

		-- format node color
		fnode:SetBackdrop(PaneBackdrop)
		if done then
			if step.TYPE == "Attune" or step.TYPE == "End" then
				fnode:SetBackdropColor(0.055, 0.306, 0.576, 0.7) -- blue, attune
				fnode:SetBackdropBorderColor(1, 1, 1)

			else
				fnode:SetBackdropColor(0.373, 0.729, 0.275, 0.3) -- green, to match website colors
				fnode:SetBackdropBorderColor(0.373, 0.729, 0.275)
			end

		else
			-- check if all predecessor are done, and mark as Next if it is the case

			local followOR = false
			local fIDs = Attune_split(step.FOLLOWS, "&")
			if string.find(step.FOLLOWS, "|") then fIDs = Attune_split(step.FOLLOWS, "|"); followOR = true end

			if followOR then
				next = false
				for fi, flw in pairs(fIDs) do
					if  Attune_DB.toons[attunelocal_charKey].done[step.ID_ATTUNE .. "-" .. flw] then next = true end
				end
			else
				next = true
				for fi, flw in pairs(fIDs) do
					if  Attune_DB.toons[attunelocal_charKey].done[step.ID_ATTUNE .. "-" .. flw] == nil or Attune_DB.toons[attunelocal_charKey].done[step.ID_ATTUNE .. "-" .. flw] == false then next = false end
				end
			end

			if step.FOLLOWS == "0" then next = true end

			if next then
				fnode:SetBackdropColor(0.851, 0.608, 0.0, 0.3) -- yellow
				fnode:SetBackdropBorderColor(0.851, 0.608, 0.0, 1)
			else
				fnode:SetBackdropColor(0.1, 0.1, 0.1, 0.5) -- gray
				fnode:SetBackdropBorderColor(0.4, 0.4, 0.4)
			end

			if step.TYPE == "Attune" or step.TYPE == "End" then
				fnode:SetBackdropColor(0.557, 0.055, 0.075, 0.7	) -- red, attune
				fnode:SetBackdropBorderColor(1, 1, 1)
			end
		end


		--icon, reuse object when possible
		local exist = false
		for _, f in ipairs(attunelocal_frames) do if f == "Attune_Icon_"..step.ID then exist = true end end
		local icon
		if exist then 	icon = _G["Attune_Icon_"..step.ID] -- reuse
		else			icon = CreateFrame("Button", "Attune_Icon_"..step.ID)
						table.insert(attunelocal_frames, "Attune_Icon_"..step.ID) -- recording, to reuse
		end
		icon:SetPoint("TOPLEFT", fnode, "TOPLEFT", Attune_DB.mini and 6 or 8, Attune_DB.mini and -6 or -8)
		icon:SetParent(fnode)
		icon:SetWidth(Attune_DB.mini and attunelocal_MiniIcon_Size or attunelocal_Icon_Size)
		icon:SetHeight(Attune_DB.mini and attunelocal_MiniIcon_Size or attunelocal_Icon_Size)
		icon:SetNormalTexture(step.ICON)
		icon:SetHighlightTexture(step.ICON)
		icon:SetToplevel(true)
		icon:EnableMouse(false)
		icon:Disable()
		icon:Show()


		if not Attune_DB.mini then
			-- step information, reuse when possible
			local exist = false
			for _, f in ipairs(attunelocal_frames) do if f == "Attune_Title_"..step.ID then exist = true end end
			local ftitle
			if exist then 	ftitle = _G["Attune_Title_"..step.ID] -- reuse
			else			ftitle = fnode:CreateFontString("Attune_Title_"..step.ID)
							table.insert(attunelocal_frames, "Attune_Title_"..step.ID) -- recording, to reuse
			end
			ftitle:SetWidth(attunelocal_Node_Width - 50)
			ftitle:SetHeight(16)
			ftitle:SetJustifyH("LEFT")
			-- End node gets a bigger font
			if step.TYPE == 'End' then
				ftitle:SetPoint("TOPLEFT", 44, -16)
				ftitle:SetFont(GameFontNormal:GetFont(), 12)
				if Attune_DB.toons[attunelocal_charKey].attuned[step.ID_ATTUNE] >= 100 then
					ftitle:SetText(Lang["Attuned"])
				else
					ftitle:SetText(Lang["Not attuned"])
				end
			else
				ftitle:SetPoint("TOPLEFT", 44, -8)
				ftitle:SetFont(GameFontNormal:GetFont(), 11)

				if step.TYPE == "Item" then
					if countNeeded == 1 then
						--ftitle:SetText(step.STEP)
						ftitle:SetText(Lang["I_"..step.ID_WOWHEAD])
					else
						ftitle:SetText(Lang["I_"..step.ID_WOWHEAD] .. " (" .. Attune_DB.toons[attunelocal_charKey].items[step.ID_WOWHEAD] .. "/" .. countNeeded .. ")")
					end
				elseif step.TYPE == "Kill" or step.TYPE == "Interact" then
					ftitle:SetText(Lang["N1_"..step.ID_WOWHEAD])

				elseif step.TYPE == "Quest" or step.TYPE == "Pick Up" or step.TYPE == "Turn In" then
					ftitle:SetText(Lang["Q1_"..step.ID_WOWHEAD])
				else
					ftitle:SetText(step.STEP)
				end
			end
			ftitle:Show()


			-- type and icon (level, interact, quest, kill...), reuse when possible
			if step.TYPE ~= 'End' then

				-- format depending on type
				local type = "|cffffd100"..Lang[step.TYPE].."|r"
				if step.TYPE == "Level" then type = "|cffffd100"..Lang["Required level"].."|r"
				elseif step.TYPE == "Attune" then type = "|c60808080"..Lang["Attunement or key"].."|r"
				elseif step.TYPE == "Rep" then type = "|cffffd100"..Lang["Reputation"].."|r"
				elseif step.LOCATION ~= "" then type = type .. "|c60808080 ".. Lang["in"].." "..Lang[step.LOCATION].."|r"
				end

				local exist = false
				for _, f in ipairs(attunelocal_frames) do if f == "Attune_Type_"..step.ID then exist = true end end
				local ftype
				if exist then 	ftype = _G["Attune_Type_"..step.ID] --reuse
				else			ftype = fnode:CreateFontString("Attune_Type_"..step.ID)
								table.insert(attunelocal_frames, "Attune_Type_"..step.ID) -- recording, to reuse
				end
				ftype:SetPoint("TOPLEFT", 44, -24)
				ftype:SetWidth(attunelocal_Node_Width - 50)
				ftype:SetHeight(16)
				ftype:SetJustifyH("LEFT")
				ftype:SetFont(GameFontNormal:GetFont(), 9)
				ftype:SetText(type)
				ftype:Show()
			end


			if countSameStep > 0 or countCompleted > 0 then

				--notification text
				local exist = false
				for _, f in ipairs(attunelocal_frames) do if f == "Attune_NotifText_"..step.ID then exist = true end end
				local notiftext
				if exist then 	notiftext = _G["Attune_NotifText_"..step.ID] -- reuse
				else			notiftext = fnode:CreateFontString("Attune_NotifText_"..step.ID)
								table.insert(attunelocal_frames, "Attune_NotifText_"..step.ID) -- recording, to reuse
				end
				notiftext:SetParent(fnode)
				notiftext:SetWidth(32)
				notiftext:SetFont(GameFontNormal:GetFont(), 10)
				notiftext:SetText(""..((countSameStep > 0) and countSameStep or countCompleted))
				notiftext:Show()



				--notification icon
				local exist = false
				for _, f in ipairs(attunelocal_frames) do if f == "Attune_Notif_"..step.ID then exist = true end end
				local notif
				if exist then 	notif = _G["Attune_Notif_"..step.ID] -- reuse
				else			notif = CreateFrame("Button", "Attune_Notif_"..step.ID)
								table.insert(attunelocal_frames, "Attune_Notif_"..step.ID) -- recording, to reuse
				end
				notif:SetPoint("TOPRIGHT", fnode, "TOPRIGHT", Attune_DB.mini and 6 or 8, Attune_DB.mini and -6 or 5)
				notif:SetParent(fnode)
				notif:SetWidth(32)
				notif:SetHeight(16)
				notif:SetFontString(notiftext)
				notif:SetNormalTexture("Interface\\AddOns\\Attune\\Images\\" .. ((countSameStep > 0) and "notification" or "completion"))
				notif:SetHighlightTexture("Interface\\AddOns\\Attune\\Images\\" .. ((countSameStep > 0) and "notification" or "completion"))
				notif:SetToplevel(true)
				notif:EnableMouse(false)
				notif:Disable()
				notif:Show()
			end

		end
	else
		--make spacer transparent
		fnode:SetBackdropColor(0, 0, 0, 0)
		fnode:SetBackdropBorderColor(1, 1, 1, 0)
	end

	fnode:Show()

	-- Create lines between nodes
	-- 3 lines for each connection. No diagonals are used, only horizontal or vertical, to make it easier to look at
	if step.FOLLOWS ~= "0" then
		local followOR = false;
		local fIDs = Attune_split(step.FOLLOWS, "&")
		if string.find(step.FOLLOWS, "|") then fIDs = Attune_split(step.FOLLOWS, "|"); followOR = true end
		for fi, flw in pairs(fIDs) do

			local linedone = Attune_DB.toons[attunelocal_charKey].done[step.ID_ATTUNE .. "-" .. flw]


			-- VERTICAL Line from prev to just under prev
			local exist = false
			for _, f in ipairs(attunelocal_frames) do if f == "Attune_Line1_"..step.ID.."_"..flw then exist = true end end

			local cur, _, _, curX, curY  = _G["Attune_Node_"..step.ID]:GetPoint()
			local prev, _, _, prevX, prevY = _G["Attune_Node_"..flw]:GetPoint()
			local offset = ((Attune_DB.mini and attunelocal_MiniLine_Thickness or attunelocal_Line_Thickness)/2)

			local line
			if exist then 	line = _G["Attune_Line1_"..step.ID.."_"..flw] --reuse
			else			line = fnode:CreateLine("Attune_Line1_"..step.ID.."_"..flw)
							table.insert(attunelocal_frames, "Attune_Line1_"..step.ID.."_"..flw) -- recording, to reuse
			end
			if done then
				if linedone then
					line:SetColorTexture(0.388, 0.686, 0.388, 1) -- green
					line:SetDrawLayer("ARTWORK",2)
				else
					line:SetColorTexture(0.2, 0.2, 0.2, 1)
					line:SetDrawLayer("ARTWORK",0)
				end
			else
				if linedone then
					line:SetColorTexture(0.851, 0.608, 0.0, 1) -- yellow
					line:SetDrawLayer("ARTWORK",1)
				else
					line:SetColorTexture(0.2, 0.2, 0.2, 1)
					line:SetDrawLayer("ARTWORK",0)
				end
			end
			line:SetThickness(Attune_DB.mini and attunelocal_MiniLine_Thickness or attunelocal_Line_Thickness)
			line:SetStartPoint("TOP", prevX - curX, prevY - curY - (Attune_DB.mini and attunelocal_MiniNode_Height or attunelocal_Node_Height))
			line:SetEndPoint("TOP", prevX - curX, prevY - curY - (Attune_DB.mini and (attunelocal_MiniNode_Height + (attunelocal_MiniNode_VGap/2)) or (attunelocal_Node_Height + (attunelocal_Node_VGap/2))) - offset)
			line:Show()


			-- VERTICAL Line to go all the way down to cur
			local exist = false
			for _, f in ipairs(attunelocal_frames) do if f == "Attune_Line3_"..step.ID.."_"..flw then exist = true end end

			local line
			if exist then 	line = _G["Attune_Line3_"..step.ID.."_"..flw]
			else			line = fnode:CreateLine("Attune_Line3_"..step.ID.."_"..flw)
							table.insert(attunelocal_frames, "Attune_Line3_"..step.ID.."_"..flw) -- recording, to reuse
			end
			if done then
				if linedone then
					line:SetColorTexture(0.388, 0.686, 0.388, 1) -- green
					line:SetDrawLayer("ARTWORK",2)
				else
					line:SetColorTexture(0.2, 0.2, 0.2, 1)
					line:SetDrawLayer("ARTWORK",0)
				end
			else
				if linedone then
					line:SetColorTexture(0.851, 0.608, 0.0, 1) -- yellow
					line:SetDrawLayer("ARTWORK",1)
				else
					line:SetColorTexture(0.2, 0.2, 0.2, 1)
					line:SetDrawLayer("ARTWORK",0)
				end
			end
			line:SetThickness(Attune_DB.mini and attunelocal_MiniLine_Thickness or attunelocal_Line_Thickness)
			line:SetStartPoint("TOP", 0, prevY - curY - (Attune_DB.mini and (attunelocal_MiniNode_Height + (attunelocal_MiniNode_VGap/2)) or (attunelocal_Node_Height + (attunelocal_Node_VGap/2))) + offset)
			line:SetEndPoint("TOP", 0, -2)
			line:Show()



			-- HORIZONTAL Line to center on curX
			local exist = false
			for _, f in ipairs(attunelocal_frames) do if f == "Attune_Line2_"..step.ID.."_"..flw then exist = true end end

			local line
			if exist then 	line = _G["Attune_Line2_"..step.ID.."_"..flw]
			else			line = fnode:CreateLine("Attune_Line2_"..step.ID.."_"..flw)
							table.insert(attunelocal_frames, "Attune_Line2_"..step.ID.."_"..flw) -- recording, to reuse
			end
			if done then
				if linedone then
					line:SetColorTexture(0.388, 0.686, 0.388, 1) -- green
					line:SetDrawLayer("ARTWORK",2)
				else
					line:SetColorTexture(0.2, 0.2, 0.2, 1)
					line:SetDrawLayer("ARTWORK",0)
				end
			else
				if linedone then
					line:SetColorTexture(0.851, 0.608, 0.0, 1) -- yellow
					line:SetDrawLayer("ARTWORK",1)
				else
					line:SetColorTexture(0.2, 0.2, 0.2, 1)
					line:SetDrawLayer("ARTWORK",0)
				end
			end
			line:SetThickness(Attune_DB.mini and attunelocal_MiniLine_Thickness or attunelocal_Line_Thickness)

			if prevX < 0 or curX < 0 then offset = -offset 	end -- need for the line thickness in corners
			line:SetStartPoint("TOP", offset, prevY - curY - (Attune_DB.mini and (attunelocal_MiniNode_Height + (attunelocal_MiniNode_VGap/2)) or (attunelocal_Node_Height + (attunelocal_Node_VGap/2))))
			line:SetEndPoint("TOP", prevX - curX + offset, prevY - curY - (Attune_DB.mini and (attunelocal_MiniNode_Height + (attunelocal_MiniNode_VGap/2)) or (attunelocal_Node_Height + (attunelocal_Node_VGap/2))))
			line:Show()


		end
	end
end


-------------------------------------------------------------------------
-- Trigger a redraw of the Attune tab
-------------------------------------------------------------------------

function Attune_ForceAttuneTabRefresh()
	if not attunelocal_initial then
		attunelocal_treeIsShown = not attunelocal_treeIsShown
		Attune_ToggleView()
	end
end


-------------------------------------------------------------------------
-- Toggle between the Attune tab and the result summary tab
-------------------------------------------------------------------------

function Attune_ToggleView(noToggle)

	Attune_SaveTreeExpandStatus()

	if noToggle == nil then noToggle = false end

	attunelocal_frame:ReleaseChildren()
	--Hiding all frames
	for i, f in pairs(attunelocal_frames) do _G[f]:Hide() end

	if attunelocal_treeIsShown or noToggle then

		_G["GuildButton"]:SetText(Lang["Attunes"])

		-- SHOW RESULT FRAME
		PlaySound(856)  --igMainMenuOptionCheckBoxOn
		attunelocal_treeIsShown = false

		attunelocal_guildframe = AceGUI:Create("SimpleGroup")
		attunelocal_guildframe:SetLayout("Flow")
		attunelocal_guildframe:SetFullWidth(true)
		attunelocal_guildframe:SetFullHeight(true)
		attunelocal_guildframe:SetAutoAdjustHeight(false)
		attunelocal_frame:AddChild(attunelocal_guildframe)




		--Display guild name and sort message
		local titleGroup = AceGUI:Create("SimpleGroup")
		titleGroup:SetRelativeWidth(0.45)

			local label = AceGUI:Create("Label")
			label:SetText(attunelocal_myguild)
			if UnitFactionGroup("player") == 'Horde' then
				label:SetImage("Interface\\Icons\\inv_bannerpvp_01")
			else
				label:SetImage("Interface\\Icons\\inv_bannerpvp_02")
			end
			label:SetFont(GameFontHighlight:GetFont(), 24)
			label:SetImageSize(32,32)
			label:SetFullWidth(true)
			titleGroup:AddChild(label)


			local spacer = AceGUI:Create("Label")
			spacer:SetText(" \n ")
			spacer:SetFullWidth(true)
			titleGroup:AddChild(spacer)
--[[
			local spacer = AceGUI:Create("Label")
			spacer:SetText(" \n ")
			spacer:SetFullWidth(true)
			titleGroup:AddChild(spacer)
]]
			
			local raid = AceGUI:Create("Button")
			raid:SetText(Lang["Open Raid Planner"])
			raid:SetCallback("OnClick", function()
				if attunelocal_initial == false and attunelocal_frame:IsShown() then 
					attunelocal_frame:Hide()
					Attune_Release()
				end
				Attune_RaidPlannerFrame()
				end)
			titleGroup:AddChild(raid)
			--raid:SetDisabled(true)
			raid.frame:Hide()


			local prof = AceGUI:Create("Button")
			if attunelocal_showResultAttunes then
				 prof:SetText(Lang["Show Profiles"])
				 --raid:SetDisabled(true)
				 raid.frame:Hide()
			else 
				prof:SetText(Lang["Show Progress"])
				--raid:SetDisabled(false)
				raid.frame:Show() -- only show when looking at profiles
			end
			prof:SetCallback("OnClick", function()
				attunelocal_showResultAttunes = not attunelocal_showResultAttunes

				if attunelocal_showResultAttunes then prof:SetText(Lang["Show Profiles"])
				else prof:SetText(Lang["Show Progress"])
				end
				Attune_ToggleView(true)
			end)
			titleGroup:AddChild(prof)


		attunelocal_guildframe:AddChild(titleGroup)


		--CheckBox
		local radioGroup = AceGUI:Create("SimpleGroup")
		radioGroup:SetRelativeWidth(0.25)

		local radio1 = AceGUI:Create("CheckBox")
		radio1:SetType("radio")
		radio1:SetLabel(Lang["Last survey results"])
		radio1:SetValue(attunelocal_resultselection == 0)
		radioGroup:AddChild(radio1)

		local radio2 = AceGUI:Create("CheckBox")
		radio2:SetType("radio")
		radio2:SetLabel(Lang["Guild members"])
		radio2:SetValue(attunelocal_resultselection == 1)
		radioGroup:AddChild(radio2)

		local radio3 = AceGUI:Create("CheckBox")
		radio3:SetType("radio")
		radio3:SetLabel(Lang["My Toons"])
		radio3:SetValue(attunelocal_resultselection == 2)
		radioGroup:AddChild(radio3)

		local radio4 = AceGUI:Create("CheckBox")
		radio4:SetType("radio")
		radio4:SetLabel(Lang["All results"])
		radio4:SetValue(attunelocal_resultselection == 3)
		radioGroup:AddChild(radio4)

		radio1:SetCallback("OnValueChanged", function(obj, evt, val)
			attunelocal_resultselection = 0
			radio1:SetValue(true)
			radio2:SetValue(false)
			radio3:SetValue(false)
			radio4:SetValue(false)
			if attunelocal_showResultAttunes then Attune_ShowResultList(label)
			else Attune_ShowProfileList(label)	end
		end)
		radio2:SetCallback("OnValueChanged", function(obj, evt, val)
			attunelocal_resultselection = 1
			radio1:SetValue(false)
			radio2:SetValue(true)
			radio3:SetValue(false)
			radio4:SetValue(false)
			if attunelocal_showResultAttunes then Attune_ShowResultList(label)
			else Attune_ShowProfileList(label)	end
		end)
		radio3:SetCallback("OnValueChanged", function(obj, evt, val)
			attunelocal_resultselection = 2
			radio1:SetValue(false)
			radio2:SetValue(false)
			radio3:SetValue(true)
			radio4:SetValue(false)
			if attunelocal_showResultAttunes then Attune_ShowResultList(label)
			else Attune_ShowProfileList(label)	end
		end)
		radio4:SetCallback("OnValueChanged", function(obj, evt, val)
			attunelocal_resultselection = 3
			radio1:SetValue(false)
			radio2:SetValue(false)
			radio3:SetValue(false)
			radio4:SetValue(true)
			if attunelocal_showResultAttunes then Attune_ShowResultList(label)
			else Attune_ShowProfileList(label)	end
		end)
		attunelocal_guildframe:AddChild(radioGroup)


		local syncGroup = AceGUI:Create("SimpleGroup")
		syncGroup:SetRelativeWidth(0.25)

			--Slider
			local slider = AceGUI:Create("Slider")
			slider:SetValue(Attune_DB.minFilterValue or 1)
			slider:SetSliderValues(1, 70, 1)
			slider:SetLabel(Lang["Minimum level"])
			slider:SetCallback("OnValueChanged", function(slid)
				Attune_DB.minFilterValue = slid:GetValue()
			end)
			slider:SetCallback("OnMouseUp", function(slid)
				if attunelocal_showResultAttunes then Attune_ShowResultList(label)
				else Attune_ShowProfileList(label)	end
			end)
			syncGroup:AddChild(slider)

			local spacer = AceGUI:Create("Label")
			spacer:SetText(" \n ")
			spacer:SetFullWidth(true)
			syncGroup:AddChild(spacer)

			local sync = AceGUI:Create("Button")
			sync:SetText(Lang["Sync with target"])
			sync:SetCallback("OnClick", function()
				Attune_SendSyncRequest()
			end)
			syncGroup:AddChild(sync)

		attunelocal_guildframe:AddChild(syncGroup)




		-- show attunes or profiles
		if attunelocal_showResultAttunes then 
			--show attunes

			--Header row
			local gftitle = AceGUI:Create("InlineGroup")
			gftitle:SetLayout("Flow")
			gftitle:SetAutoAdjustHeight(true)
			gftitle:SetFullWidth(true)

			attunelocal_gflabel = AceGUI:Create("InteractiveLabel")
			attunelocal_gflabel:SetText(Lang["Character"])
			attunelocal_gflabel:SetWidth(165)
			attunelocal_gflabel:SetFont(GameFontHighlight:GetFont(), 16)
			attunelocal_gflabel:SetCallback("OnClick", function()
				if Attune_DB.sortresult[1] == 0 then
					--same sort, just change order
					Attune_DB.sortresult[2] = not Attune_DB.sortresult[2]
				else
					Attune_DB.sortresult[1] = 0
					Attune_DB.sortresult[2] = true
				end
				if attunelocal_showResultAttunes then Attune_ShowResultList(label)
				else Attune_ShowProfileList(label)	end
			end)
			gftitle:AddChild(attunelocal_gflabel)


			local expac = ""
			for i, a in pairs(Attune_Data.attunes) do
				if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 

					if (TreeExpandStatus[a.EXPAC] == nil 
					or TreeExpandStatus[a.EXPAC] == 1) 
					and (TreeExpandStatus[a.EXPAC.."\001"..a.GROUP] == nil 
					or TreeExpandStatus[a.EXPAC.."\001"..a.GROUP] == 1) then 


						if expac ~= a.EXPAC.."-"..a.GROUP then
							local gfspacer = AceGUI:Create("Label")
							gfspacer:SetText(" ")
							gfspacer:SetWidth(10)
							gftitle:AddChild(gfspacer)
							expac = a.EXPAC.."-"..a.GROUP
						end

						if a.FACTION == UnitFactionGroup("player") or a.FACTION == 'Both' then
							local gficon = AceGUI:Create("Icon")
							gficon:SetImage(a.ICON)
							gficon:SetWidth(30)
							gficon:SetImageSize(24, 24)
							gficon.frame:SetScript("OnClick", function()
								if Attune_DB.sortresult[1] == a.ID then
									--same sort, just change order
									Attune_DB.sortresult[2] = not Attune_DB.sortresult[2]
								else
									Attune_DB.sortresult[1] = a.ID
									Attune_DB.sortresult[2] = true --desc better for attunes, but we're reversing % further down.
								end
								if attunelocal_showResultAttunes then Attune_ShowResultList(label)
								else Attune_ShowProfileList(label)	end
				
							end)
							gficon.frame:SetScript("OnEnter", function() attunelocal_frame:SetStatusText(a.NAME.." - "..a.EXPAC)  end)
							gficon.frame:SetScript("OnLeave", function() attunelocal_frame:SetStatusText(attunelocal_statusText)  end)
							gftitle:AddChild(gficon)
						end
					end
				end
			end

			attunelocal_guildframe:AddChild(gftitle)



			attunelocal_gscroll = AceGUI:Create("ScrollFrame")
			attunelocal_gscroll:SetLayout("Flow")
			attunelocal_gscroll:SetFullWidth(true)
			
	
			-- This script needed to allow the scrollframe resize whenever content changes or vertical size is moved
			attunelocal_gscroll.frame:SetScript("OnUpdate", function()
				attunelocal_gscroll:SetHeight(attunelocal_frame.frame:GetHeight() - 255)
			end)
	
	

			attunelocal_glist = AceGUI:Create("SimpleGroup")
			attunelocal_glist:SetLayout("Flow")
			attunelocal_glist:SetAutoAdjustHeight(true)
			attunelocal_glist:SetFullWidth(true)

			if attunelocal_showResultAttunes then Attune_ShowResultList(label)
			else Attune_ShowProfileList(label)	end

			attunelocal_gscroll:AddChild(attunelocal_glist)

			attunelocal_guildframe:AddChild(attunelocal_gscroll)

		else

			--show profiles

			--Header row
			local gftitle = AceGUI:Create("InlineGroup")
			gftitle:SetLayout("Flow")
			gftitle:SetAutoAdjustHeight(true)
			gftitle:SetFullWidth(true)


			attunelocal_gflabel = AceGUI:Create("InteractiveLabel")
			attunelocal_gflabel:SetText(Lang["Character"])
			attunelocal_gflabel:SetWidth(200)
			attunelocal_gflabel:SetFont(GameFontHighlight:GetFont(), 16)
			attunelocal_gflabel:SetCallback("OnClick", function()
				if Attune_DB.sortresult[1] == 0 then
					--same sort, just change order
					Attune_DB.sortresult[2] = not Attune_DB.sortresult[2]
				else
					Attune_DB.sortresult[1] = 0
					Attune_DB.sortresult[2] = true
				end
				if attunelocal_showResultAttunes then Attune_ShowResultList(label)
				else Attune_ShowProfileList(label)	end
			end)
			gftitle:AddChild(attunelocal_gflabel)

			attunelocal_gflabel2 = AceGUI:Create("InteractiveLabel")
			attunelocal_gflabel2:SetText(Lang["Guild"])
			attunelocal_gflabel2:SetWidth(240)
			attunelocal_gflabel2:SetFont(GameFontHighlight:GetFont(), 16)
			attunelocal_gflabel2:SetCallback("OnClick", function()
				if Attune_DB.sortresult[1] == -1 then
					--same sort, just change order
					Attune_DB.sortresult[2] = not Attune_DB.sortresult[2]
				else
					Attune_DB.sortresult[1] = -1
					Attune_DB.sortresult[2] = true
				end
				if attunelocal_showResultAttunes then Attune_ShowResultList(label)
				else Attune_ShowProfileList(label)	end
			end)
			gftitle:AddChild(attunelocal_gflabel2)

			attunelocal_gflabel3 = AceGUI:Create("InteractiveLabel")
			attunelocal_gflabel3:SetText(Lang["Status"])
			attunelocal_gflabel3:SetWidth(100)
			attunelocal_gflabel3:SetFont(GameFontHighlight:GetFont(), 16)
			attunelocal_gflabel3:SetCallback("OnClick", function()
				if Attune_DB.sortresult[1] == -2 then
					--same sort, just change order
					Attune_DB.sortresult[2] = not Attune_DB.sortresult[2]
				else
					Attune_DB.sortresult[1] = -2
					Attune_DB.sortresult[2] = false
				end
				if attunelocal_showResultAttunes then Attune_ShowResultList(label)
				else Attune_ShowProfileList(label)	end
			end)
			gftitle:AddChild(attunelocal_gflabel3)

			attunelocal_gflabel4 = AceGUI:Create("InteractiveLabel")
			attunelocal_gflabel4:SetText(Lang["Role"])
			attunelocal_gflabel4:SetWidth(100)
			attunelocal_gflabel4:SetFont(GameFontHighlight:GetFont(), 16)
			attunelocal_gflabel4:SetCallback("OnClick", function()
				if Attune_DB.sortresult[1] == -3 then
					--same sort, just change order
					Attune_DB.sortresult[2] = not Attune_DB.sortresult[2]
				else
					Attune_DB.sortresult[1] = -3
					Attune_DB.sortresult[2] = false
				end
				if attunelocal_showResultAttunes then Attune_ShowResultList(label)
				else Attune_ShowProfileList(label)	end
			end)
			gftitle:AddChild(attunelocal_gflabel4)

			attunelocal_gflabel5 = AceGUI:Create("InteractiveLabel")
			attunelocal_gflabel5:SetText("    "..Lang["Last Surveyed"])
			attunelocal_gflabel5:SetWidth(150)
			attunelocal_gflabel5:SetFont(GameFontHighlight:GetFont(), 16)
			attunelocal_gflabel5:SetCallback("OnClick", function()
				if Attune_DB.sortresult[1] == -4 then
					--same sort, just change order
					Attune_DB.sortresult[2] = not Attune_DB.sortresult[2]
				else
					Attune_DB.sortresult[1] = -4
					Attune_DB.sortresult[2] = true
				end
				if attunelocal_showResultAttunes then Attune_ShowResultList(label)
				else Attune_ShowProfileList(label)	end
			end)
			gftitle:AddChild(attunelocal_gflabel5)

			local gficon = AceGUI:Create("Icon")
			gficon:SetImage("Interface\\AddOns\\Attune\\Images\\empty")
			gficon:SetWidth(30)
			gficon:SetImageSize(24, 24)
			gftitle:AddChild(gficon)

			attunelocal_guildframe:AddChild(gftitle)


			attunelocal_gscroll = AceGUI:Create("ScrollFrame")
			attunelocal_gscroll:SetLayout("Flow")
			attunelocal_gscroll:SetFullWidth(true)
			
	
			-- This script needed to allow the scrollframe resize whenever content changes or vertical size is moved
			attunelocal_gscroll.frame:SetScript("OnUpdate", function()
				attunelocal_gscroll:SetHeight(attunelocal_frame.frame:GetHeight() - 255)
			end)

			attunelocal_glist = AceGUI:Create("SimpleGroup")
			attunelocal_glist:SetLayout("Flow")
			attunelocal_glist:SetAutoAdjustHeight(true)
			attunelocal_glist:SetFullWidth(true)

			if attunelocal_showResultAttunes then Attune_ShowResultList(label)
			else Attune_ShowProfileList(label)	end

			attunelocal_gscroll:AddChild(attunelocal_glist)

			attunelocal_guildframe:AddChild(attunelocal_gscroll)

		end

	else

		_G["GuildButton"]:SetText(Lang["Results"])

		-- SHOW TREE FRAME
		attunelocal_treeIsShown = true

		-- create the tree
		attunelocal_treeframe = AceGUI:Create("TreeGroup")
		attunelocal_treeframe:SetTree(attunelocal_tree)
		attunelocal_treeframe:SetLayout("Fill")
		attunelocal_treeframe:SetFullWidth(true)
		attunelocal_treeframe:SetFullHeight(true)
		attunelocal_treeframe:SetAutoAdjustHeight(false)
		attunelocal_frame:AddChild(attunelocal_treeframe)

		for i, a in pairs(Attune_Data.attunes) do
			if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
				if TreeExpandStatus[a.EXPAC] == nil then TreeExpandStatus[a.EXPAC] = 1 end
				if TreeExpandStatus[a.EXPAC] == 1 then attunelocal_treeframe:SelectByPath(a.EXPAC) end

				if TreeExpandStatus[a.EXPAC.."\001"..a.GROUP] == nil then TreeExpandStatus[a.EXPAC.."\001"..a.GROUP] = 1 end
				if TreeExpandStatus[a.EXPAC.."\001"..a.GROUP] == 1 then attunelocal_treeframe:SelectByPath(a.EXPAC.."\001"..a.GROUP) end
			end
		end
		attunelocal_treeframe:SetCallback("OnGroupSelected", function(container, event, selection)
			--check if it's a top level expac
			local st, le = string.find(selection, "\001")
			if st ~= nil then -- not top level
				--get actual attune (remove expac/group)
				expac, group, sel = strsplit("\001", selection);
				if sel ~= "" and sel ~= nil then
					AttuneLastViewed = selection
					Attune_Select(sel)
				end
			end
		end)

		attunelocal_treeframe:SetCallback("OnTreeResize", function(container, event, group)
			--force the size to 175
			container.treeframe:SetWidth(175)
		end)

		attunelocal_right = AceGUI:Create("SimpleGroup")
		attunelocal_right:SetLayout("Fill")
		attunelocal_right:SetFullWidth(true)
		attunelocal_right:SetFullHeight(true)
		attunelocal_right:SetAutoAdjustHeight(false)
		attunelocal_treeframe:AddChild(attunelocal_right)

		attunelocal_scroll = AceGUI:Create("ScrollFrame")
		attunelocal_scroll:SetLayout("List")
		attunelocal_scroll:SetFullWidth(true)
		attunelocal_scroll:SetFullHeight(true)
		attunelocal_scroll:SetAutoAdjustHeight(false)
		attunelocal_right:AddChild(attunelocal_scroll)


		--select default attune (or last viewed)
		attunelocal_treeframe:SelectByPath(AttuneLastViewed)

	end

end

-------------------------------------------------------------------------
-- Create the Attune list shown in the Result tab
-------------------------------------------------------------------------

function Attune_ShowResultList(title)

	local count = 0 -- number of rows displayed in table

	-- number of steps per attune - this is to calculate % completion
	local attuneSteps = {}
	for i, s in pairs(Attune_Data.steps) do
		if showPatchStep(s) then
			if s.TYPE ~= "Spacer" then
				if attuneSteps[s.ID_ATTUNE] == nil then attuneSteps[s.ID_ATTUNE] = 0 end
				attuneSteps[s.ID_ATTUNE] = attuneSteps[s.ID_ATTUNE] +1
			end
		end
	end

	-- adjust the title according to the selection
	if title ~= nil then
		local gg = attunelocal_myguild
		if gg == "" then gg = Lang['Not in a guild'] end

		if attunelocal_resultselection == 0 then
			title:SetText(Lang["Last survey results"])
		elseif attunelocal_resultselection == 1 then
			title:SetText(gg)
		elseif attunelocal_resultselection == 2 then
			title:SetText(Lang["My Toons"])
		else
			local fact, factLoc = UnitFactionGroup("player")
			title:SetText(Lang["All FACTION results"]:gsub("##FACTION##", factLoc ))
		end

	end

	attunelocal_glist:ReleaseChildren()


	-- parse all recorded toons and get their progress
	for kt, t in pairs(Attune_DB.toons) do
		-- calculate how many steps this toon has done on the attune
		local attuneDone = {}
		if t.done ~= nil then 
			for i, d in pairs(t.done) do
				local Ids = Attune_split(i, "-")
				if attuneDone[Ids[1]] == nil then attuneDone[Ids[1]] = 0 end
				attuneDone[Ids[1]] = attuneDone[Ids[1]] +1
			end

			if t.attuned == nil then t.attuned = {} end
			for i, a in pairs(Attune_Data.attunes) do
				if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
					if attuneDone[a.ID] == nil then attuneDone[a.ID] = 0 end
					t.attuned[a.ID] = math.floor(100*(attuneDone[a.ID]/attuneSteps[a.ID]))
				end
			end
		end
	end


	-- display the list according to the sort order
	--for kt, t in Attune_spairs(Attune_DB.toons, function(t,a,b) 	return b > a end) do
	for kt, t in Attune_spairs(Attune_DB.toons, function(t,a,b)
		if Attune_DB.sortresult[1] == 0 then
			if Attune_DB.sortresult[2] then
				return b > a
			else
				return a > b
			end
		elseif Attune_DB.sortresult[1] == -1 then
			if Attune_DB.sortresult[2] then
				return t[b].guild > t[a].guild
			else
				return t[a].guild > t[b].guild
			end
		elseif Attune_DB.sortresult[1] == -2 then
			if Attune_DB.sortresult[2] then
				return Attune_StatusRole(t[b].status) > Attune_StatusRole(t[a].status)
			else
				return Attune_StatusRole(t[a].status) > Attune_StatusRole(t[b].status)
			end
		elseif Attune_DB.sortresult[1] == -3 then
			if Attune_DB.sortresult[2] then
				return Attune_StatusRole(t[b].role) > Attune_StatusRole(t[a].role)
			else
				return Attune_StatusRole(t[a].role) > Attune_StatusRole(t[b].role)
			end
		elseif Attune_DB.sortresult[1] == -4 then
			if Attune_DB.sortresult[2] then
				return t[b].survey > t[a].survey
			else
				return t[a].survey > t[b].survey
			end
		else 
			--sort by attune % AND name. reversing the % with "100-" to be able to sort names alpha
			if Attune_DB.sortresult[2] then
				return string.format("%03i", 100-t[b].attuned[Attune_DB.sortresult[1]]) .. b > string.format("%03i", 100-t[a].attuned[Attune_DB.sortresult[1]]) .. a
			else
				return string.format("%03i", 100-t[a].attuned[Attune_DB.sortresult[1]]) .. a > string.format("%03i", 100-t[b].attuned[Attune_DB.sortresult[1]]) .. b
			end
		end
	 end) do

		-- only look at current faction (and current realm)
		if t.faction == UnitFactionGroup("player") and (kt == t.name.."-"..attunelocal_realm) then

			-- look for:
			-- 		if attunelocal_resultselection == 0, players in the same guild, or if unguilded just this player
			-- 		if attunelocal_resultselection == 1, players that have been put in the survey list
			--		if attunelocal_resultselection == 2, all players recorded
			if (attunelocal_resultselection == 0 and Attune_DB.survey[kt])
			or (attunelocal_resultselection == 1 and ((attunelocal_myguild ~= "" and t.guild == attunelocal_myguild) or t.name == UnitName("player")))
			or (attunelocal_resultselection == 2 and t.owner == 1) 
			or (attunelocal_resultselection == 3) then

				if tonumber(t.level) >= (Attune_DB.minFilterValue or 1) then

					count = count + 1

					C_Timer.After(0.01*count, function()
						local lev = t.level
						if tonumber(lev) < 10 then lev = "  "..lev end -- align numbers when under 10

						local ggg = t.guild
						if ggg == '' then ggg = "(Not in a guild)" else ggg = "<"..ggg..">" end

						local vvv = t.version
						if vvv == nil then vvv = "- Very old addon version" else vvv = " - v"..vvv.."" end

						local sss = t.survey
						if sss == nil then sss = "- No survey date recorded" else sss = "- Last surveyed on "..date("%d %b %Y", sss).."" end
						
						local activeName = t.name
						local inactive = false
						if t.survey == nil or t.survey == 0 then 
						else
							if t.survey < time() - attunelocal_inactivity then 
								-- old inactive toon
								inactive = true
								activeName = "|c80606060"..activeName.."|r"
								sss = sss .. " (inactive)"
							end 
						end
						-- container for the whole row
						local gframe = AceGUI:Create("SimpleGroup")
						gframe:SetLayout("Flow")
						gframe:SetAutoAdjustHeight(true)
						gframe:SetFullWidth(true)
						gframe.frame:SetScript("OnEnter", function() attunelocal_frame:SetStatusText(t.name.." "..ggg.." "..vvv.." "..sss)  end)
						gframe.frame:SetScript("OnLeave", function() attunelocal_frame:SetStatusText(attunelocal_statusText)  end)

						-- add toon part
							local glabel = AceGUI:Create("Label")
							glabel:SetText("    |c80606060"..lev.."|r  |T"..Attune_Icons(string.upper(t.class), nil)..":16|t  "..activeName)
							glabel:SetWidth(180)
							glabel:SetFont(GameFontNormal:GetFont(), 12)
							gframe:AddChild(glabel)


						-- Go through each Attune and create the corresponding % label for this toon
						local expac = ""
						for i, a in pairs(Attune_Data.attunes) do
							if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 

								if (TreeExpandStatus[a.EXPAC] == nil 
									or TreeExpandStatus[a.EXPAC] == 1) 
									and (TreeExpandStatus[a.EXPAC.."\001"..a.GROUP] == nil 
									or TreeExpandStatus[a.EXPAC.."\001"..a.GROUP] == 1) then 
					
									-- This spacer to separate Wow classic from TBC attunes
									if expac ~= a.EXPAC.."-"..a.GROUP then
										local gfspacer = AceGUI:Create("Label")
										gfspacer:SetText(" ")
										gfspacer:SetWidth(10)
										gframe:AddChild(gfspacer)
										expac = a.EXPAC.."-"..a.GROUP
									end

									-- Only look at attunes for this toon's faction
									if a.FACTION == UnitFactionGroup("player") or a.FACTION == 'Both' then

										local gflabel = AceGUI:Create("Label")
										if t.attuned[a.ID] >= 100 then
											if inactive then 
												gflabel:SetText("|TInterface\\AddOns\\Attune\\Images\\successinactive:16|t")
											else 
												gflabel:SetText("|TInterface\\AddOns\\Attune\\Images\\success:16|t")
											end
										else
											if inactive then 
												gflabel:SetText("|c80606060"..t.attuned[a.ID].."%|r")
											else 
												gflabel:SetText(t.attuned[a.ID].."%")
											end
										end
										gflabel:SetWidth(30)
										gframe:AddChild(gflabel)

									end
								end
							end
						end


						if attunelocal_charKey ~= kt then
							-- add a delete button, to allow removing players from our data (for example if they changed guilds)
							local gdel = AceGUI:Create("Button")
							gdel:SetText("X")
							gdel:SetWidth(50)
							gdel:SetCallback("OnClick", function()
								Attune_DB.toons[kt] = nil
								if attunelocal_showResultAttunes then Attune_ShowResultList(label)
								else Attune_ShowProfileList(label)	end
					
							end)
							gframe:AddChild(gdel)
						end

						-- add the row to the list
						attunelocal_glist:AddChild(gframe)
						attunelocal_gscroll.content.obj.content:SetHeight(attunelocal_frame.frame:GetHeight() - 80)
					end) -- end of timer function
				end
			end
		end
	end

	attunelocal_gflabel:SetText(Lang["Characters"].." ("..count..")")
	attunelocal_gscroll.content.obj.content:SetHeight(attunelocal_frame.frame:GetHeight() - 80)

end

-------------------------------------------------------------------------
-- Create the Profile list shown in the Result tab
-------------------------------------------------------------------------

function Attune_ShowProfileList(title)

	local count = 0 -- number of rows displayed in table
	local att = Attune_DB.toons[attunelocal_charKey]

	-- adjust the title according to the selection
	if title ~= nil then
		local gg = attunelocal_myguild
		if gg == "" then gg = Lang['Not in a guild'] end

		if attunelocal_resultselection == 0 then
			title:SetText(Lang["Last survey results"])
		elseif attunelocal_resultselection == 1 then
			title:SetText(gg)
		elseif attunelocal_resultselection == 2 then
			title:SetText(Lang["My Toons"])
		else
			local fact, factLoc = UnitFactionGroup("player")
			title:SetText(Lang["All FACTION results"]:gsub("##FACTION##", factLoc ))
		end

	end

	attunelocal_glist:ReleaseChildren()


	-- display the list according to the sort order
	--for kt, t in Attune_spairs(Attune_DB.toons, function(t,a,b) 	return b > a end) do
	for kt, t in Attune_spairs(Attune_DB.toons, function(t,a,b)
		if Attune_DB.sortresult[1] == 0 then
			if Attune_DB.sortresult[2] then
				return b > a
			else
				return a > b
			end
		elseif Attune_DB.sortresult[1] == -1 then
			if Attune_DB.sortresult[2] then
				return t[b].guild > t[a].guild
			else
				return t[a].guild > t[b].guild
			end
		elseif Attune_DB.sortresult[1] == -2 then
			if Attune_DB.sortresult[2] then
				return Attune_StatusRole(t[b].status) > Attune_StatusRole(t[a].status)
			else
				return Attune_StatusRole(t[a].status) > Attune_StatusRole(t[b].status)
			end
		elseif Attune_DB.sortresult[1] == -3 then
			if Attune_DB.sortresult[2] then
				return Attune_StatusRole(t[b].role) > Attune_StatusRole(t[a].role)
			else
				return Attune_StatusRole(t[a].role) > Attune_StatusRole(t[b].role)
			end
		elseif Attune_DB.sortresult[1] == -4 then
			if Attune_DB.sortresult[2] then
				return t[b].survey > t[a].survey
			else
				return t[a].survey > t[b].survey
			end
		else 
			--sort by attune % AND name. reversing the % with "100-" to be able to sort names alpha
			if Attune_DB.sortresult[2] then
				return string.format("%03i", 100-Attune_IfNilZero(t[b].attuned[Attune_DB.sortresult[1] ])) .. b > string.format("%03i", 100-Attune_IfNilZero(t[a].attuned[Attune_DB.sortresult[1] ])) .. a
			else
				return string.format("%03i", 100-Attune_IfNilZero(t[a].attuned[Attune_DB.sortresult[1] ])) .. a > string.format("%03i", 100-Attune_IfNilZero(t[b].attuned[Attune_DB.sortresult[1] ])) .. b
			end
		end
	 end) do

		-- only look at current faction (and current realm)
		if t.faction == UnitFactionGroup("player") and (kt == t.name.."-"..attunelocal_realm) then

			-- look for:
			-- 		if attunelocal_resultselection == 0, players in the same guild, or if unguilded just this player
			-- 		if attunelocal_resultselection == 1, players that have been put in the survey list
			--		if attunelocal_resultselection == 2, all players recorded
			if (attunelocal_resultselection == 0 and Attune_DB.survey[kt])
			or (attunelocal_resultselection == 1 and ((attunelocal_myguild ~= "" and t.guild == attunelocal_myguild) or t.name == UnitName("player")))
			or (attunelocal_resultselection == 2 and t.owner == 1) 
			or (attunelocal_resultselection == 3) then

				if tonumber(t.level) >= (Attune_DB.minFilterValue or 1) then

					count = count + 1

					C_Timer.After(0.01*count, function()
						local lev = t.level
						if tonumber(lev) < 10 then lev = "  "..lev end -- align numbers when under 10

						local ggg = t.guild
						if ggg == '' then ggg = "(Not in a guild)" else ggg = "<"..ggg..">" end

						local vvv = t.version
						if vvv == nil then vvv = "- Very old addon version" else vvv = "- v"..vvv.."" end

						local sss = t.survey
						if sss == nil then sss = "- No survey date recorded" else sss = "- Last surveyed on "..date("%d %b %Y", sss).."" end
						
						local activeName = t.name
						local inactive = false
						if t.survey == nil or t.survey == 0 then 
						else
							if t.survey < time() - attunelocal_inactivity then 
								-- old inactive toon
								inactive = true
								activeName = "|c80606060"..activeName.."|r"
								sss = sss .. " (inactive)"
							end 
						end

						-- container for the whole row
						local gframe = AceGUI:Create("SimpleGroup")
						gframe:SetLayout("Flow")
						gframe:SetAutoAdjustHeight(true)
						gframe:SetFullWidth(true)
						gframe.frame:SetScript("OnEnter", function() attunelocal_frame:SetStatusText(t.name.."  "..ggg.." "..sss)  end)
						gframe.frame:SetScript("OnLeave", function() attunelocal_frame:SetStatusText(attunelocal_statusText)  end)

						-- add toon part
							local glabel = AceGUI:Create("Label")
							glabel:SetText("    |c80606060"..lev.."|r  |T"..Attune_Icons(string.upper(t.class), nil)..":16|t  "..activeName)
							glabel:SetWidth(210)
							glabel:SetFont(GameFontNormal:GetFont(), 12)
							gframe:AddChild(glabel)

							local gguild = AceGUI:Create("Label")
							if inactive then gguild:SetText("|c80606060"..t.guild.."|r") else gguild:SetText(t.guild) end
							gguild:SetWidth(240)
							gguild:SetFont(GameFontNormal:GetFont(), 12)
							gframe:AddChild(gguild)

							if t.owner == 1 or (t.guild == att.guild and att.officer == "1") then 
								local gstatus = AceGUI:Create("Dropdown")
								gstatus:SetWidth(100)
								gstatus:SetList({
--									["None"] = "-",
									["Main"] = Attune_StatusRole("Main"),
									["Alt"] = Attune_StatusRole("Alt"),
									["Bank"] = Attune_StatusRole("Bank"),								
								}, {"Main", "Alt", "Bank"})
								if t.status == nil then t.status = "None" end
								gstatus:SetValue(t.status)
								gstatus:SetCallback("OnValueChanged", function(choice) 
									t.status = choice:GetValue() 
									if attunelocal_myguild ~= "" then Attune:SendCommMessage(attunelocal_prefix, t.name .. "|TOONSTATUS|" .. t.status, "GUILD") end 
								end )
								gframe:AddChild(gstatus)

								
								local grole = AceGUI:Create("Dropdown")
								grole:SetWidth(100)
								grole:SetList({
--									["None"] = "-",
									["Tank"] = Attune_StatusRole("Tank"),
									["Healer"] = Attune_StatusRole("Healer"),
									["Melee"] = Attune_StatusRole("Melee"),
									["Ranged"] = Attune_StatusRole("Ranged"),
								}, {"Tank", "Healer", "Melee", "Ranged"})
								if t.role == nil then t.role = "None" end
								grole:SetValue(t.role)
								grole:SetCallback("OnValueChanged", function(choice) 
									t.role = choice:GetValue() 
									if attunelocal_myguild ~= "" then Attune:SendCommMessage(attunelocal_prefix, t.name .. "|TOONROLE|" .. t.role, "GUILD") end 
								end )
								gframe:AddChild(grole)

							else
								local gstatus = AceGUI:Create("Label")
								if t.status == nil then t.status = "None" end
								if inactive then gstatus:SetText("|c80606060"..Attune_StatusRole(t.status).."|r") else gstatus:SetText(Attune_StatusRole(t.status)) end
								gstatus:SetWidth(100)
								gstatus:SetFont(GameFontNormal:GetFont(), 12)
								gframe:AddChild(gstatus)

								local grole = AceGUI:Create("Label")
								if t.role == nil then t.role = "None" end
								if inactive then grole:SetText("|c80606060"..Attune_StatusRole(t.role).."|r") else grole:SetText(Attune_StatusRole(t.role)) end
								grole:SetWidth(100)
								grole:SetFont(GameFontNormal:GetFont(), 12)
								gframe:AddChild(grole)

							end

							local glast = AceGUI:Create("Label")
							if t.survey == nil or t.survey == 0 then 
								glast:SetText("    -")
								if inactive then glast:SetText("|c80606060    -|r") else glast:SetText("    -") end
							else 
								--glast:SetText("    "..Lang['Seconds ago']:gsub("##DURATION##", Attune_formatTime(time() - t.survey)) )
								glast:SetText("    "..date("%d %b %Y at %H:%M", t.survey) )
								if inactive then glast:SetText("|c80606060    "..date("%d %b %Y at %H:%M", t.survey).."|r") else glast:SetText("    "..date("%d %b %Y at %H:%M", t.survey) ) end
							end
							glast:SetWidth(190)
							glast:SetFont(GameFontNormal:GetFont(), 12)
							gframe:AddChild(glast)


						if attunelocal_charKey ~= kt then
							-- add a delete button, to allow removing players from our data (for example if they changed guilds)
							local gdel = AceGUI:Create("Button")
							gdel:SetText("X")
							gdel:SetWidth(50)
							gdel:SetCallback("OnClick", function()
								Attune_DB.toons[kt] = nil
								if attunelocal_showResultAttunes then Attune_ShowResultList(label)
								else Attune_ShowProfileList(label)	end

							end)
							gframe:AddChild(gdel)
						end

						-- add the row to the list
						attunelocal_glist:AddChild(gframe)
						attunelocal_gscroll.content.obj.content:SetHeight(attunelocal_frame.frame:GetHeight() - 80)
					end) -- end of timer function
				end
			end
		end
	end

	attunelocal_gflabel:SetText(Lang["Characters"].." ("..count..")")
	attunelocal_gscroll.content.obj.content:SetHeight(attunelocal_frame.frame:GetHeight() - 80)

end

-------------------------------------------------------------------------

function Attune_StatusRole(keyword)

	if keyword == "None" then return "-" end

	if keyword == "Main" then return Lang["Main"] end
	if keyword == "Alt" then return Lang["Alt"] end

	if keyword == "Tank" then return Lang["Tank"] end
	if keyword == "Healer" then return Lang["Healer"] end
	if keyword == "Melee" then return Lang["Melee DPS"] end
	if keyword == "Ranged" then return Lang["Ranged DPS"] end

	if keyword == "Bank" then return Lang["Bank"] end
end

-------------------------------------------------------------------------

function Attune_IfNilZero(val)
	if val == nil then return 0
	else return val end
end


function Attune_count(tab)
	local attunelocal_count = 0
	for Index, Value in pairs(tab) do
		attunelocal_count = attunelocal_count + 1
	end
	return attunelocal_count

end


-------------------------------------------------------------------------
-- Send the Addon request (surve) to the selected channel
-------------------------------------------------------------------------

function Attune_SendRequest(what)

	local IsTarget = Attune_split(what, "|")

	Attune_DB.survey = {}
	if IsTarget[1] == "Target" then 
		local tar = IsTarget[2] .. "-" .. attunelocal_realm
		if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["SendingSurveyTo"]:gsub("##TO##", tar)) end
		Attune:SendCommMessage(attunelocal_prefix, "SILENTSURVEY", "WHISPER", tar);
	else
		if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["SendingSurveyWhat"]:gsub("##WHAT##", Lang[what])) end
		Attune:SendCommMessage(attunelocal_prefix, "SURVEY", string.upper(what), "");
	end

end

-------------------------------------------------------------------------
-- This is the same as SendRequest('Guild') except the surveyed players
-- won't see a message saying they replied.
-- Useful for debug purposes, to not annoy players with repeated messages
-------------------------------------------------------------------------

function Attune_SendSilentGuildRequest()
	Attune_DB.survey = {}
	if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["SendingGuildSilentSurvey"]) end
	if attunelocal_myguild ~= "" then Attune:SendCommMessage(attunelocal_prefix, "SILENTSURVEY", "GUILD", ""); end

end

-------------------------------------------------------------------------
-- Same as SendRequest, but in the YELL range
-- Quirk to see who around has the addon, silently
-------------------------------------------------------------------------

function Attune_SendSilentYellRequest()
	Attune_DB.survey = {}
	if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["SendingYellSilentSurvey"]) end
	Attune:SendCommMessage(attunelocal_prefix, "SILENTSURVEY", "YELL", "");

end

-------------------------------------------------------------------------
-- Send my attune information (request results)
-- Information is sent back via addon whisper to the surveyRequestor
-- This defines what is sent back (1. toon meta, 2. steps done, 3. end)
-------------------------------------------------------------------------

function Attune_SendRequestResults(surveyRequestor)

	local meta = {}
	meta.l = UnitLevel("player")
	local attunelocal_faction = UnitFactionGroup("player")
	_, classFile = UnitClass("player")
	_, raceFile = UnitRace("player")

	local g = UnitSex("player")
	meta.g = 'male'
	if g == 3 then meta.g = 'female' end
	meta.c = classFile
	meta.r = raceFile   --Scourge, Troll, etc
	--meta.owner = 1

	local guildName, guildRankName, guildRank = GetGuildInfo("player");
	if guildName == nil then
		meta.o = 0 --not officer
		guildName = ""
	else
		if guildRank == 0 or CanGuildRemove() then
			meta.o = 1 --officer
		else
			meta.o = 0 --not officer
		end
	end
	attunelocal_myguild = guildName

	local att = Attune_DB.toons[attunelocal_charKey]
	if att.status == nil then att.status = "None" end
	if att.role == nil then 
		if meta.c == "MAGE" or meta.c == "WARLOCK"  or meta.c == "HUNTER" then att.role = "Ranged"
		elseif meta.c == "ROGUE" then att.role = "Melee"
		else att.role = "None" end
	end

	-- Send a first response with the player metadata
	Attune:SendCommMessage(attunelocal_prefix, UnitName("player") .. "|TOON|" .. meta.g  .. "|" .. meta.c .. "|" .. meta.r .. "|" .. meta.l .. "|" .. meta.o .. "|".. guildName.."|"..attunelocal_version.."|"..att.status.."|"..att.role, "WHISPER", surveyRequestor)  --the last pipe is in case the guildname is empty. still need it as blank, not nil


	-- then send a bunch of followup whispers with the completed steps
	for key, status in pairs(att.done) do
		if status then --step done
			Attune:SendCommMessage(attunelocal_prefix, UnitName("player") .. "|DONE|" .. key, "WHISPER", surveyRequestor)
		end
	end

	-- Send a closing message after a bit (to make sure it arrives last)
	C_Timer.After(0.250, function()
		Attune:SendCommMessage(attunelocal_prefix, UnitName("player") .. "|OVER", "WHISPER", surveyRequestor)
	end)

end



-------------------------------------------------------------------------
-- Send my attune information (automatic push on completion)
-- Information is sent via addon guild spam
-- This defines what is sent back (1. toon meta, 2. steps done, 3. end)
-------------------------------------------------------------------------

function Attune_SendPushInfo(step)

	if step == "TOON" then 
		local meta = {}
		meta.l = UnitLevel("player")
		local attunelocal_faction = UnitFactionGroup("player")
		_, classFile = UnitClass("player")
		_, raceFile = UnitRace("player")

		local g = UnitSex("player")
		meta.g = 'male'
		if g == 3 then meta.g = 'female' end
		meta.c = classFile
		meta.r = raceFile   --Scourge, Troll, etc
		--meta.owner = 1

		local guildName, guildRankName, guildRank = GetGuildInfo("player");
		if guildName == nil then
			meta.o = 0 --not officer
			guildName = ""
		else
			if guildRank == 0 or CanGuildRemove() then
				meta.o = 1 --officer
			else
				meta.o = 0 --not officer
			end
		end
		attunelocal_myguild = guildName

		local att = Attune_DB.toons[attunelocal_charKey]
		if att.status == nil then att.status = "None" end
		if att.role == nil then 
			if meta.c == "MAGE" or meta.c == "WARLOCK"  or meta.c == "HUNTER" then att.role = "Ranged"
			elseif meta.c == "ROGUE" then att.role = "Melee"
			else att.role = "None" end
		end

		-- Send a first response with the player metadata
		if attunelocal_myguild ~= "" then Attune:SendCommMessage(attunelocal_prefix, UnitName("player") .. "|TOON|" .. meta.g  .. "|" .. meta.c .. "|" .. meta.r .. "|" .. meta.l .. "|" .. meta.o .. "|".. guildName.."|"..attunelocal_version.."|"..att.status.."|"..att.role, "GUILD") end --the last pipe is in case the guildname is empty. still need it as blank, not nil

	elseif step == "OVER" then 
		-- Send a closing message after a bit (to make sure it arrives last)
		C_Timer.After(0.250, function()
			if attunelocal_myguild ~= "" then Attune:SendCommMessage(attunelocal_prefix, UnitName("player") .. "|SILENTOVER", "GUILD") end
		end)

	else
		-- then send the data for that newly completed steps
		if attunelocal_myguild ~= "" then Attune:SendCommMessage(attunelocal_prefix, UnitName("player") .. "|SILENTDONE|" .. step, "GUILD") end
	end

end


-------------------------------------------------------------------------
-- Handle the replies from the survey
-- Typically comes as 1 'meta' whisper, many 'step' whispers and 1 'over'
--    META contains: name|TOON|gender|class|race|level|officer|guild
--    STEP contains: name|DONE|attune-step
--    OVER contains: name|OVER|
-------------------------------------------------------------------------

function Attune_HandleRequestResults(response)

	--consolidate responses
	local data = Attune_split(response, "|")
	local name = data[1].."-"..attunelocal_realm
	local tag = data[2]


	Attune_DB.survey[name] = 1

	-- initialize the record for this player
	--	if attunelocal_data[name] == nil then attunelocal_data[name] = {} end
	--	local player = attunelocal_data[name]
	if Attune_DB.toons[name] == nil then Attune_DB.toons[name] = {} end
	local player = Attune_DB.toons[name]


	-- META reply
	if tag == 'TOON' then
		attunelocal_refreshDone = false
		attunelocal_count = attunelocal_count + 1
		player.name = data[1] -- short name
		player.gender = data[3]	--gender
		player.class = data[4]	--class
		player.race = data[5]	--race
		player.level = data[6]	--level
		player.officer = data[7]	--officer in their guild
		player.guild = data[8]	--guild
		player.version = data[9]	--version
		player.faction = UnitFactionGroup("player")
		player.survey = time()	--time of last survey
		if (data[10] ~= nil and data[10] ~= "None" and data[10] ~= "-") then player.status = data[10];	end --status
		if (data[11] ~= nil and data[11] ~= "None" and data[11] ~= "-") then player.role = data[11]; end	--role
		

		if player.status == nil then player.status = "None" end
		if player.role == nil then player.role = "None" end
		--print(""..player.name .." NORM "..player.status .. " / " .. player.role)

		if player.role == "None" then 
			if player.class == "MAGE" or player.class == "WARLOCK"  or player.class == "HUNTER" then player.role = "Ranged"
			elseif player.class == "ROGUE" then player.role = "Melee"
			end
		end

		if player.attuned == nil then player.attuned = {} end
		for i, a in pairs(Attune_Data.noattunes) do
			--mark as automatically attuned for those raids that do not require attunement
			if player.attuned[a.ID] == nil then player.attuned[a.ID] = 100 end
		end
			

		-- check if this is the requester or someone else
		if player.name == UnitName("player") then player.owner = 1 else player.owner = 0 end

		-- initialize the STEP container
		if player.done == nil then	player.done = {}	end

		if player.version ~= nil then
			if player.version > attunelocal_version and not attunelocal_detectedNewer then
				attunelocal_detectedNewer = true
				if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["NewVersionAvailable"].." (v"..player.version..")") end-- detected someone with a newer version, warn the user
			end
		end

	elseif tag == 'TOONROLE' then
		if player.name ~= nil and data[3] ~= "None" then player.role = data[3] end   --don't add new members like this (not enough metadata)
--		print("received from "..player.name .." TOON role "..player.role)
	
	elseif tag == 'TOONSTATUS' then
		if player.name ~= nil and data[3] ~= "None" then player.status = data[3] end   --don't add new members like this (not enough metadata)
--		print("received from "..player.name .." TOON status "..player.status)


	-- STEP replies
	elseif tag == 'DONE' or tag == 'SILENTDONE' then
		--print("DONE " .. player.name .. ": " ..data[3])
		attunelocal_refreshDone = false
		player.done[data[3]] = 1 -- step
		if tag == 'SILENTDONE' then 
			--print("Received ".. data[3] .. " from " .. player.name)
			for i, s in Attune_spairs(Attune_Data.steps, function(t,a,b) 	return tonumber(t[b].ID) > tonumber(t[a].ID) end) do
				if showPatchStep(s) then
					if data[3] == (s.ID_ATTUNE .. "-" .. s.ID) then
						-- recurse into earlier steps to mark them as done too
						C_Timer.After(0.01, function() Attune_recursePreviousSteps(name, s.ID_ATTUNE, s.FOLLOWS) end)
					end
				end
			end
		end


	-- OVER reply
	elseif tag == 'OVER' or tag == 'SILENTOVER' then
		--print(tag.." " .. player.name)
		attunelocal_refreshDone = false

		if player.name ~= UnitName("player") then
			if tag == 'OVER' and Attune_DB.showResponses then print("|cffff00ff[Attune]|r "..Lang["ReceivedDataFromName"]:gsub("##NAME##",  player.name)) end -- received data from someone else, might as well announce it in chat
			Attune_CheckIsNext(name)
		end

		-- Wait a few seconds before refreshing the result tab, to avoid refreshing it multiple times
		C_Timer.After(5, function()
			if attunelocal_frame ~= nil then
				if not attunelocal_treeIsShown then
					if not attunelocal_refreshDone then 
						attunelocal_refreshDone = true
						if attunelocal_showResultAttunes then Attune_ShowResultList()	-- update result tab if already shown
						else Attune_ShowProfileList()	end
					end
-- Disabling the auto-swap to results as it's confusing					
--				else
--					if not attunelocal_initial then
--						attunelocal_resultselection = 0
--						Attune_ToggleView()
--					end
				end
				attunelocal_initial = false -- disable the 'no announce on first load'
			end
		end)
	end

end

-------------------------------------------------------------------------
-- encode data and show popup to copy it
-------------------------------------------------------------------------

function Attune_ExportToWebsite()

	attunelocal_data = {}
	attunelocal_data['_realm'] = attunelocal_realm
	attunelocal_data['_faction'] = UnitFactionGroup("player")

	local count = 0

	-- parse all recorded toons
	for kt, t in pairs(Attune_DB.toons) do

		-- only look at current faction and realm
		if t.faction == UnitFactionGroup("player") and (kt == t.name.."-"..attunelocal_realm) then

			-- export data:
			-- 		if attunelocal_exportselection == 0, only this player
			-- 		if attunelocal_exportselection == 1, players that have been put in the survey list
			--		if attunelocal_exportselection == 2, all players in the same guild
			--		if attunelocal_exportselection == 3, all players recorded
			-- 		if attunelocal_exportselection == 4, all this player's data (main and alts)
			if (attunelocal_exportselection == 0 and kt == (UnitName("player").."-"..attunelocal_realm))
			or (attunelocal_exportselection == 4 and t.owner == 1)
			or (attunelocal_exportselection == 1 and Attune_DB.survey[kt])
			or (attunelocal_exportselection == 2 and ((attunelocal_myguild ~= "" and t.guild == attunelocal_myguild) or t.name == UnitName("player")))
			or (attunelocal_exportselection == 3) then

				count = count + 1
				attunelocal_data[t.name] = {}
				attunelocal_data[t.name].g = t.gender
				attunelocal_data[t.name].c = t.class
				attunelocal_data[t.name].r = t.race
				attunelocal_data[t.name].l = t.level
				attunelocal_data[t.name].o = t.officer
				attunelocal_data[t.name].G = t.guild
				--attunelocal_data[t.name].f = t.faction
				attunelocal_data[t.name].owner = t.owner
				attunelocal_data[t.name].done = "-1"
				attunelocal_data[t.name].ro = t.role
				attunelocal_data[t.name].st = t.status
				attunelocal_data[t.name].s = t.survey

				for i, d in pairs(t.done) do
					attunelocal_data[t.name].done = attunelocal_data[t.name].done .. "|" .. i
				end
			end
		end
	end


	if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["ExportingData"]:gsub("##COUNT##", count)) end

	local serattunelocal_data = Attune_serialize(attunelocal_data)
	local ser = attunelocal_version .. "##" .. serattunelocal_data

	local encoded = Attune_enc(ser)

	StaticPopupDialogs["EXPORT_ATTUNE_GUILD"] = {
		text = Lang["Copy the text below, then upload it to"].."\n\nhttps://warcraftratings.com/attune/upload",
		button1 = Lang["Close"],
		OnShow = function (self, data)
			self.editBox:SetText(""..encoded)
			self.editBox:HighlightText()
			self.editBox:SetScript("OnEscapePressed", function(self) StaticPopup_Hide ("EXPORT_ATTUNE_GUILD") end)

		end,
		timeout = 0,
		hasEditBox = true,
		editBoxWidth = 350,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show ("EXPORT_ATTUNE_GUILD")

end



-------------------------------------------------------------------------
-- send a request for a full Sync
-------------------------------------------------------------------------

function Attune_SendSyncRequest()
	if not UnitExists("target") then 
		if attunelocal_frame ~= nil then
			attunelocal_frame:SetStatusText(Lang["No Target"])
			C_Timer.After(3, function()
				attunelocal_frame:SetStatusText(attunelocal_statusText)
			end)
		end
	else

		if attunelocal_syncStatus ~= -1 then 
			if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["Cannot sync while another sync is in progress"]) end
		else 
			attunelocal_syncTarget = UnitName("target") -- .. "-" .. GetRealmName()

			StaticPopupDialogs["SYNC_CONFIRM"] = {
				text = Lang["Sending Sync Request"]:gsub("##PLAYER##", attunelocal_syncTarget) .. "\n\n" .. Lang["Could be slow"],
				button1 = Lang["Accept"],
				button2 = Lang["Reject"],
				timeout = 0,
				hasEditBox = false,
				whileDead = true,
				hideOnEscape = true,
				preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
				OnAccept = function()
					Attune_SentActualSyncRequest()
				end,
				OnCancel = function (_,reason)
					attunelocal_syncTarget = nil
				end,
			}
			StaticPopup_Show ("SYNC_CONFIRM")
		end
	end
end 

-------------------------------------------------------------------------

function Attune_SentActualSyncRequest()
	
	if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["Sending Sync Request"]:gsub("##PLAYER##", attunelocal_syncTarget)) end
	attunelocal_syncStatus = 1
	--Attune:SendCommMessage(attunelocal_syncprefix, "SYNCREQ", "WHISPER", attunelocal_syncTarget)

	local ser = Attune_serialize(Attune_DB.toons):gsub(" = ", "="):gsub("   ", ""):gsub(" }", "}")
	--print("about to send:" ..#ser)
	Attune:SendCommMessage(attunelocal_syncprefix, "SYNCREQ|"..#ser, "WHISPER", attunelocal_syncTarget)
	
	-- Close request after 10s if no response
	C_Timer.After(10, function() 
		if attunelocal_syncStatus == 1 then
			--if attunelocal_frame ~= nil then
			--	attunelocal_frame:SetStatusText(Lang["No Response From"]:gsub("##PLAYER##", attunelocal_syncTarget))
			--else 
				if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["No Response From"]:gsub("##PLAYER##", attunelocal_syncTarget)) end
			--end
			attunelocal_syncStatus = -1
			attunelocal_syncTarget = nil
			C_Timer.After(3, function()
				if attunelocal_frame ~= nil then
					 attunelocal_frame:SetStatusText(attunelocal_statusText) 
				end
			end)
		end
	end)
end

-------------------------------------------------------------------------

function Attune_StartSync()

	attunelocal_syncStatus = 2
	if attunelocal_syncStartTime == nil then attunelocal_syncStartTime = GetTime() end
	if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["Request accepted, sending data to "]:gsub("##PLAYER##", attunelocal_syncTarget)) end

	--reuse object when possible
	local exist = false
	for _, f in ipairs(attunelocal_syncProgress_frames) do if f == "Attune_SyncProgress_Frame" then exist = true end end
	if exist then 	attunelocal_syncProgressWidget = _G["Attune_SyncProgress_Frame"] -- reuse
	else			attunelocal_syncProgressWidget = CreateFrame("Frame", "Attune_SyncProgress_Frame", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
					table.insert(attunelocal_syncProgress_frames, "Attune_SyncProgress_Frame") -- recording, to reuse
	end


	attunelocal_syncProgressWidget:SetWidth(270)
	attunelocal_syncProgressWidget:SetHeight(50)
	attunelocal_syncProgressWidget:SetPoint("BOTTOM",UIParent, 0, 150)
	attunelocal_syncProgressWidget:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 32, edgeSize = 8, insets = { left = 2, right = 2, top = 2, bottom = 2 }	})
	attunelocal_syncProgressWidget:SetBackdropColor(0,0,0,1)
	attunelocal_syncProgressWidget:EnableMouse(true)
	attunelocal_syncProgressWidget:SetMovable(true)
	attunelocal_syncProgressWidget:SetFrameStrata("FULLSCREEN_DIALOG")
	attunelocal_syncProgressWidget:RegisterForDrag("LeftButton","RightButton");
	attunelocal_syncProgressWidget:SetClampedToScreen(true)
	attunelocal_syncProgressWidget:SetScript("OnDragStart", function()	attunelocal_syncProgressWidget:StartMoving()	end)
	attunelocal_syncProgressWidget:SetScript("OnDragStop", function()	attunelocal_syncProgressWidget:StopMovingOrSizing();	end)
	attunelocal_syncProgressWidget:Show()


	local attunelocal_syncProgressLabel = nil
	local exist = false
	for _, f in ipairs(attunelocal_syncProgress_frames) do if f == "Attune_SyncProgress_Label" then exist = true end end
	if exist then 	attunelocal_syncProgressLabel = _G["Attune_SyncProgress_Label"] -- reuse
	else			attunelocal_syncProgressLabel = attunelocal_syncProgressWidget:CreateFontString("Attune_SyncProgress_Label")
					table.insert(attunelocal_syncProgress_frames, "Attune_SyncProgress_Label") -- recording, to reuse
	end
	attunelocal_syncProgressLabel:SetPoint("TOPLEFT",attunelocal_syncProgressWidget, 10, -10)
	attunelocal_syncProgressLabel:SetFont(GameFontNormal:GetFont(), 12)
	attunelocal_syncProgressLabel:SetText(Lang["Syncing Attune data with"]:gsub("##PLAYER##", attunelocal_syncTarget))
	

	attunelocal_syncProgressStatusBar = nil
	local exist = false
	for _, f in ipairs(attunelocal_syncProgress_frames) do if f == "Attune_SyncProgress_StatusBar" then exist = true end end
	if exist then 	attunelocal_syncProgressStatusBar = _G["Attune_SyncProgress_StatusBar"] -- reuse
	else			attunelocal_syncProgressStatusBar = CreateFrame("StatusBar", "Attune_SyncProgress_StatusBar", attunelocal_syncProgressWidget, BackdropTemplateMixin and "BackdropTemplate" or nil)
					table.insert(attunelocal_syncProgress_frames, "Attune_SyncProgress_StatusBar") -- recording, to reuse
	end
	attunelocal_syncProgressStatusBar:SetPoint("TOPLEFT",attunelocal_syncProgressWidget, 10, -26)
	attunelocal_syncProgressStatusBar:SetWidth(250)
	attunelocal_syncProgressStatusBar:SetHeight(10)
	attunelocal_syncProgressStatusBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	attunelocal_syncProgressStatusBar:GetStatusBarTexture():SetHorizTile(false)
	attunelocal_syncProgressStatusBar:SetStatusBarColor(1,0,0) 
	attunelocal_syncProgressStatusBar:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 32, edgeSize = 8, insets = { left = 2, right = 2, top = 2, bottom = 2 }	})
	attunelocal_syncProgressStatusBar:SetBackdropColor(0,0,0,1)
	attunelocal_syncProgressStatusBar:SetMinMaxValues(1, 100)
	attunelocal_syncProgressStatusBar:SetValue(0)
	attunelocal_syncProgressStatusBar:Show()


	--reduce string size
	local ser = Attune_serialize(Attune_DB.toons):gsub(" = ", "="):gsub("   ", ""):gsub(" }", "}")
	Attune:SendCommMessage(attunelocal_syncprefix, ser, "WHISPER", attunelocal_syncTarget, "BULK", Attune_OnChunkSent)

end

-------------------------------------------------------------------------

function Attune_OnChunkSent(arg, done, total)

	attunelocal_syncChunksSent = attunelocal_syncChunksSent + 1
	
	attunelocal_syncAmountToSend = total
	attunelocal_syncAmountSent = done
	attunelocal_syncProgressStatusBar:SetMinMaxValues(1, attunelocal_syncAmountToSend + attunelocal_syncAmountToReceive)
	attunelocal_syncProgressStatusBar:SetValue(attunelocal_syncAmountSent + attunelocal_syncAmountReceived)

	-- this is for the receiver to also show some progress (otherwise it will be stuck until this send is completely done)
	if attunelocal_syncChunksSent >= 10 then 
		Attune:SendCommMessage(attunelocal_syncprefix, "SYNCDONE|"..attunelocal_syncAmountSent, "WHISPER", attunelocal_syncTarget)
		attunelocal_syncChunksSent = 0
	end

	if (attunelocal_syncAmountSent + attunelocal_syncAmountReceived) >= (attunelocal_syncAmountToSend + attunelocal_syncAmountToReceive) then
		attunelocal_syncStatus = -1
		if attunelocal_syncStartTime ~= nil then
			if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["Sync over"]:gsub("##DURATION##", Attune_formatTime(Attune_Round(GetTime() - attunelocal_syncStartTime, 0)))) end
		end
		attunelocal_syncProgressWidget:Hide()
		attunelocal_syncStartTime = nil
	end

end


-------------------------------------------------------------------------


function Attune:OnCommReceived(prefix, message, distribution, sender)

	--Sync channel
	if prefix == attunelocal_syncprefix then
		local amount = 0 
		if string.find(message, "|") then 
			local amess = Attune_split(message, "|")
			message = amess[1]
			amount = tonumber(amess[2])
		end

		if message == 'SYNCREQ' then
			if attunelocal_syncStatus ~= -1 then 
				Attune:SendCommMessage(attunelocal_syncprefix, "SYNCBUSY", "WHISPER", sender)
			else
				--print("about to receive:" ..amount)
				attunelocal_syncTarget = sender
				attunelocal_syncAmountToReceive = amount
				attunelocal_syncAmountReceived = 0
	
				if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["Received request from"]:gsub("##PLAYER##", attunelocal_syncTarget)) end
				PlaySound(6675) -- BellTollTribal
				StaticPopupDialogs["SYNC_ATTUNE"] = {
					text = Lang["Sync Request From"]:gsub("##PLAYER##", attunelocal_syncTarget).."\n\n"..Lang["Could be slow"],
					button1 = Lang["Accept"],
					button2 = Lang["Reject"],
					timeout = 9,
					hasEditBox = false,
					whileDead = true,
					hideOnEscape = true,
					preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
					OnAccept = function()
						attunelocal_syncStatus = 2
						local ser = Attune_serialize(Attune_DB.toons):gsub(" = ", "="):gsub("   ", ""):gsub(" }", "}")
						--print("about to send:" ..#ser)
						Attune:SendCommMessage(attunelocal_syncprefix, "SYNCOK|"..#ser, "WHISPER", attunelocal_syncTarget)
						Attune_StartSync()
					end,
					OnCancel = function (_,reason)
						attunelocal_syncStatus = -1
						Attune:SendCommMessage(attunelocal_syncprefix, "SYNCNOK", "WHISPER", attunelocal_syncTarget)
						if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["Request rejected"]) end
					end,
				}
				StaticPopup_Show ("SYNC_ATTUNE")
			end

		elseif message == 'SYNCOK' then
			--print("about to receive:" ..amount)
			attunelocal_syncAmountToReceive = amount
			Attune_StartSync()

		elseif message == 'SYNCNOK' then
			attunelocal_syncStatus = -1
			if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["Request rejected"]) end

		elseif message == 'SYNCBUSY' then
			attunelocal_syncStatus = -1
			if Attune_DB.showOtherChat then print("|cffff00ff[Attune]|r "..Lang["Busy right now"]:gsub("##PLAYER##", sender)) end

		elseif message == 'SYNCDONE' then
			attunelocal_syncAmountReceived = amount
			--print("Processed so far " .. (attunelocal_syncAmountReceived + attunelocal_syncAmountSent) .. " / " .. (attunelocal_syncAmountToReceive + attunelocal_syncAmountToSend))
			Attune_OnChunkSent(arg, attunelocal_syncAmountSent, attunelocal_syncAmountToSend)

		else

			local SyncedToons = Attune_deserialize(message)
			for kt, t in pairs(SyncedToons) do
				t.owner = 0 -- force imports to be marked as not own
				
				if Attune_DB.toons[kt] == nil then
					--new toon
					Attune_DB.toons[kt] = t
				else 
					if Attune_DB.toons[kt].owner == 0 then -- do not update my own toons

						-- Check which data set has the latest survey
						if t.survey ~= nil and Attune_DB.toons[kt].survey ~= nil then 
							if t.survey > Attune_DB.toons[kt].survey then 
								-- Already have it, but this one is newer
								Attune_DB.toons[kt] = t
							end
						else 
							if t.survey ~= nil then 
								-- Already have it, but this one is newer (as the other doesn't have a date)
								Attune_DB.toons[kt] = t
							end
						end
					end
				end
			end
			C_Timer.After(1, function()
				if attunelocal_frame ~= nil then
					if not attunelocal_treeIsShown then
						if attunelocal_showResultAttunes then Attune_ShowResultList()	-- update result tab if already shown
						else Attune_ShowProfileList()	end
					else
						if not attunelocal_initial then
							attunelocal_resultselection = 0
							Attune_ToggleView()
						end
					end
					attunelocal_initial = false -- disable the 'no announce on first load'
				end
			end)
			
			attunelocal_syncAmountReceived = attunelocal_syncAmountToReceive
			Attune_OnChunkSent(arg, attunelocal_syncAmountSent, attunelocal_syncAmountToSend)
		end
	end
end 


-------------------------------------------------------------------------

function Attune_spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[Attune_count(keys)+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-------------------------------------------------------------------------

function Attune_serialize (o)
	local res = ""
	if type(o) == "number" then
	  res = res .. o
	elseif type(o) == "string" then
		res = res .. string.format("%q", o)
	elseif type(o) == "table" then
		res = res .. "{ "
	  for k,v in pairs(o) do
		if type(k) == "number" then
			res = res .. "  [" .. k .. "] = "
		elseif type(k) == "string" then
			 res = res .. "  [\"" .. k .. "\"] = "
		end
		res = res .. Attune_serialize(v)
		res = res .. ", "
	  end
	  res = res ..  "}"
	elseif type(o) == "boolean" then
		if o then res = res .. "true"
		else res = res .. "false" end
	else
	  error("cannot serialize a " .. type(o))
	end
	return res
end

-------------------------------------------------------------------------
 
function Attune_deserialize(input)
	if type(input) == 'string' then
	   	local data = input
	   	local pos = 0
	   	function input(undo)
			if undo then
				pos = pos - 1
		  	else
				pos = pos + 1
				return string.sub(data, pos, pos)
		  	end
	   	end
	end

	local c
	repeat
		c = input()
	until c ~= ' ' and c ~= ','

	if c == '"' then
		--string value
	   	local s = ''
	   	repeat
		  	c = input()
		  	if c == '"' then
				--print("s = "..s)
				return s
		  	end
		  	s = s..c
	   	until c == ''

	elseif c == '-' or Attune_is_digit(c) then
		-- number value
	   	local s = c
	   	repeat
			c = input()
			local d = Attune_is_digit(c)
			if d then
				s = s..c
		  	end
	   	until not d
	   	input(true)
		--print("n = "..s)
	   return tonumber(s)

	elseif c == '[' then
		--print("[]")
		--Associative
	   	local o = ''
	   	repeat
		  c = input()
		  if c == ']' then
			 break
		  end
		  o = o..c
	   	until c == ''
		o = o:gsub('"', "") -- removing extra ""
	   	repeat
			c = input()
		until c == '='
		--print("o = "..o)

		local subarr = {}
		elem = Attune_deserialize(input)
		
		table.insert(subarr, "assoc")
		table.insert(subarr, o)
		table.insert(subarr, elem)
		return subarr

	elseif c == '{' then
		--array
		--print("{}")
	   	local arr = {}
	   	local elem
	   	repeat
		  	elem = Attune_deserialize(input)
			--print(type(elem))
		  	if type(elem) == 'table' then
				if elem[1] == "assoc" then 
					arr[elem[2]] = elem[3]
				else 
					table.insert(arr, elem)
				end
		  	else 
		  		table.insert(arr, elem)
			end
	   	until not elem
	   	return arr
	end
 end

------------------------------------------------------------------------- 

function Attune_is_digit(c)
	return c >= '0' and c <= '9'
end

-------------------------------------------------------------------------

local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' -- You will need this for encoding/decoding
-- encoding
function Attune_enc(data)
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

-------------------------------------------------------------------------
-- decoding
function Attune_dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end

-------------------------------------------------------------------------

function Attune_formatTime(sec)
	local str = ""

	if sec ~= nil then
		local minutes, hours
		if (sec<60) then
			str = ""..sec.."sec"
		else
			minutes = math.floor(sec/60)
			sec = sec - (minutes*60)
			if (minutes<60) then
				str =  ""..minutes.."min"
			else
				hours = math.floor(minutes/60)
				minutes = minutes - (hours*60)
				str = ""..hours.."h"
				if (minutes > 0) then str = str .. " "..minutes.."min" end
			end
			if (sec > 0) then str = str .. " "..sec.."sec" end
		end
	else
		str = ""
	end
	return str
end

-------------------------------------------------------------------------

function Attune_split(str, sep)
	local t = {}
	local ind = string.find(str, sep)
	while (ind ~= nil) do
		table.insert(t, string.sub(str, 1, ind-1))
		str = string.sub(str, ind+1)
		ind = string.find(str, sep, 1, true)
	end
	if (str ~="") then table.insert(t, str) end
	return t
end

-------------------------------------------------------------------------
-- find if key exists in table
function Attune_locate(table, value)
    for i = 1, #table do
        if table[i] == value then return true end
    end
    return false
end

-------------------------------------------------------------------------

function Attune_Round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

-------------------------------------------------------------------------

function Attune_Icons(what, gender)
	local icon = "Interface/Icons/inv_misc_questionmark"
	if (what == "DRUID") 	then icon = "Interface\\Icons\\inv_misc_monsterclaw_04" end
	if (what == "HUNTER") 	then icon = "Interface\\Icons\\inv_weapon_bow_07" end
	if (what == "MAGE") 	then icon = "Interface\\Icons\\inv_staff_13" end
	if (what == "PALADIN") then icon = "Interface\\AddOns\\Attune\\Images\\class_paladin" end
	if (what == "PRIEST") 	then icon = "Interface\\AddOns\\Attune\\Images\\class_priest" 	end
	if (what == "ROGUE") 	then icon = "Interface\\AddOns\\Attune\\Images\\class_rogue" end
	if (what == "SHAMAN") 	then icon = "Interface\\Icons\\spell_nature_bloodlust" end
	if (what == "WARLOCK") then icon = "Interface\\Icons\\spell_nature_drowsy" end
	if (what == "WARRIOR") then icon = "Interface\\Icons\\inv_sword_27" end
	if (what == "DEATHKNIGHT") then icon = "Interface\\Icons\\Spell_deathknight_classicon" end
	if (what == "UNKNOWN") then icon = "Interface\\Icons\\Inv_misc_questionmark" end
	
	local g = 'male'
	if gender == 3 then g = 'female' end
	if (what == "Dwarf") then icon = "Interface\\AddOns\\Attune\\Images\\achievement_character_dwarf_"..g end
	if (what == "Gnome") then icon = "Interface\\AddOns\\Attune\\Images\\achievement_character_gnome_"..g end
	if (what == "Human") then icon = "Interface\\AddOns\\Attune\\Images\\achievement_character_human_"..g end
	if (what == "NightElf") then icon = "Interface\\AddOns\\Attune\\Images\\achievement_character_nightelf_"..g end
	if (what == "Orc") then icon = "Interface\\AddOns\\Attune\\Images\\achievement_character_orc_"..g end
	if (what == "Tauren") then icon = "Interface\\AddOns\\Attune\\Images\\achievement_character_tauren_"..g end
	if (what == "Troll") then icon = "Interface\\AddOns\\Attune\\Images\\achievement_character_troll_"..g end
	if (what == "Scourge") then icon = "Interface\\AddOns\\Attune\\Images\\achievement_character_undead_"..g end
	return icon
end

-------------------------------------------------------------------------

function Attune_SlashCommandHandler( msg )

	if (msg == 'help' or msg == '?') then

		print("|cffff00ff[Attune]|r "..Lang["Help1"])
		print("|cffff00ff[Attune]|r "..Lang["Help2"])
		print("|cffff00ff[Attune]|r ")
		print("|cffff00ff[Attune]|r "..Lang["Help3"])
		print("|cffff00ff[Attune]|r "..Lang["Help4"])
		print("|cffff00ff[Attune]|r "..Lang["Help5"])
		print("|cffff00ff[Attune]|r ")
		print("|cffff00ff[Attune]|r "..Lang["Help6"])

	elseif (msg == 'survey') then
		Attune_SendRequest("Guild");

	elseif (msg == 'silentsurvey') then
		Attune_SendSilentGuildRequest();	-- Guild check, without triggering the response message on remote toons. Mostly for debugging without annoying players

	elseif (msg == 'yell') then
		Attune_SendSilentYellRequest();		-- Check who's got the addon around you

	elseif (msg == 'sync') then
		Attune_SendSyncRequest()

	elseif (msg == 'raid') or (msg == 'raidplanner') or (msg == 'planner')  then
		if attunelocal_raidframe ~= nil then
			if attunelocal_raidframe:IsShown() then 
				attunelocal_raidframe:Hide() 
			else
				Attune_RaidPlannerFrame()
			end
		else 
			Attune_RaidPlannerFrame()
		end

	elseif (msg ~= '') then 
		Attune_SendRequest("Target|"..msg);

	elseif attunelocal_initial == false and attunelocal_frame:IsShown() then
		attunelocal_frame:Hide()
		Attune_SaveTreeExpandStatus()
		Attune_Release()
	else
		if attunelocal_initial then
			attunelocal_initial = false
			Attune_LoadTree()
			Attune_Frame()
			Attune_DB.survey = {}
			Attune_SendRequestResults(UnitName("player"));  -- Send a request to myself
		end
		attunelocal_frame:Show()

	end

end


-------------------------------------------------------------------------

function Attune_Release()
	--[[
	if attunelocal_glist ~= nil then attunelocal_glist:ReleaseChildren() end
	if attunelocal_scroll ~= nil then attunelocal_scroll:ReleaseChildren() end
	if attunelocal_raidroster ~= nil then attunelocal_raidroster:ReleaseChildren() end
	if attunelocal_frame ~= nil then attunelocal_frame:ReleaseChildren() end
]]
end

-------------------------------------------------------------------------

function Attune_LoadRaidTree()
	attunelocal_raidtree = {}


	local tankNode = {
		value = "Tank",
		text =  Attune_StatusRole("Tank"),
		children = {}
	}
	local healerNode = {
		value = "Healer",
		text =  Attune_StatusRole("Healer"),
		children = {}
	}
	local meleeNode = {
		value = "Melee",
		text =  Attune_StatusRole("Melee"),
		children = {}
	}
	local rangedNode = {
		value = "Ranged",
		text =  Attune_StatusRole("Ranged"),
		children = {}
	}
	local unspecNode = {
		value = "Unspec",
		text =  Lang["Unspecified"],
		children = {}
	}
	
	for kt, t in Attune_spairs(Attune_DB.toons, function(t,a,b) return t[b].class > t[a].class end) do
		
		--only look at current faction and realm
		if t.faction == UnitFactionGroup("player") and (kt == t.name.."-"..attunelocal_realm) then
			--check they are attuned
			if Attune_DB.raidShowUnattuned or t.attuned[""..Attune_DB.raidSelection[attunelocal_faction]] >= 100 then
				
				if ((Attune_DB.raidShowMains and t.status == "Main") 
				or (Attune_DB.raidShowAlts and t.status == "Alt")
				or (Attune_DB.raidShowUnspecified and t.status == "None"))
				and (not Attune_DB.raidGuildOnly or t.guild == attunelocal_myguild)   then

					local tt = t.name
					if Attune_IsRaidSelected(t.name) ~= "" then tt = "|cff606060"..t.name.."|r" end

					local toonNode = {
						value = t.name,
						text = tt,
						icon = Attune_Icons(t.class),
					}
					
					if t.role == "Tank" then table.insert(tankNode.children, toonNode)
					elseif t.role == "Healer" then table.insert(healerNode.children, toonNode)
					elseif t.role == "Melee" then table.insert(meleeNode.children, toonNode)
					elseif t.role == "Ranged" then table.insert(rangedNode.children, toonNode)
					else table.insert(unspecNode.children, toonNode)
					end

					
				end
			end
		end
	end
	
	table.insert(attunelocal_raidtree, tankNode)
	table.insert(attunelocal_raidtree, healerNode)
	table.insert(attunelocal_raidtree, meleeNode)
	table.insert(attunelocal_raidtree, rangedNode)
	table.insert(attunelocal_raidtree, unspecNode)

end

-------------------------------------------------------------------------
-- Create the RAID PLANNER UI Frame
-------------------------------------------------------------------------

function Attune_RaidPlannerFrame()

	guildName, guildRankName, guildRankIndex = GetGuildInfo("player");
	if guildName ~= nil then attunelocal_myguild = guildName end

	if Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]] == nil then Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]] = {} end
	if Attune_DB.raidNames[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]] == nil then Attune_DB.raidNames[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]] = {} end

	attunelocal_raidframe = AceGUI:Create("Frame")
	attunelocal_raidframe:SetTitle("  Attune Raid Planner")
	attunelocal_raidframe:SetStatusText(Lang["Select a raid and click on players to add them in"])
	attunelocal_raidframe:SetHeight(620)
	attunelocal_raidframe:SetWidth(1020)
	attunelocal_raidframe:SetLayout("Flow")
	
	if attunelocal_raidframe.frame.SetResizeBounds then
		attunelocal_raidframe.frame:SetResizeBounds(620, 620)
	else
		attunelocal_raidframe.frame:SetMinResize(620, 620)
	end
	attunelocal_raidframe.frame:SetFrameStrata("HIGH")

	
    -- Register the global variable as a "special frame"
    -- so that it is closed when the escape key is pressed.
	
	_G["Attune_MainRaidFrame"] = attunelocal_raidframe.frame
    tinsert(UISpecialFrames, "Attune_MainRaidFrame")

	local options = AceGUI:Create("SimpleGroup")
	options:SetLayout("Flow")
	options:SetFullWidth(true)

		local dropd = AceGUI:Create("SimpleGroup")
		dropd:SetLayout("Flow")
		dropd:SetWidth(200)

			local raidList = {}
			for i, a in pairs(Attune_Data.attunes) do
				if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
					if a.SHOWRAIDPLANNER ~= nil and (a.FACTION == UnitFactionGroup("player") or a.FACTION == 'Both') then 
						--actual raid (not just attunement) for this faction
						raidList[tonumber(a.ID)] = a.NAME
					end
				end
			end
			for i, a in pairs(Attune_Data.noattunes) do
				--raids that require no attunement
				raidList[tonumber(a.ID)] = a.NAME
			end

			
			local raidselection = AceGUI:Create("Dropdown")
			raidselection:SetWidth(150)
			raidselection:SetList(raidList)
			raidselection:SetValue(Attune_DB.raidSelection[attunelocal_faction])
			raidselection:SetCallback("OnValueChanged", function(choice) 
				Attune_DB.raidSelection[attunelocal_faction] = choice:GetValue(); 	
				if Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]] == nil then Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]] = {} end
				if Attune_DB.raidNames[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]] == nil then Attune_DB.raidNames[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]] = {} end
				Attune_LoadRaidTree(); 	
				attunelocal_raidtreeframe:SetTree(attunelocal_raidtree);	
				Attune_RaidPlannerRoster() end)

			dropd:AddChild(raidselection)
			options:AddChild(dropd)

		

		local checkboxes = AceGUI:Create("SimpleGroup")
		checkboxes:SetLayout("Flow")
		checkboxes:SetWidth(460)

			local cb = AceGUI:Create("CheckBox")
			cb:SetType("checkbox")
			cb:SetLabel(Lang["Show Mains"])
			cb:SetValue(Attune_DB.raidShowMains)
			cb:SetWidth(150)
			cb:SetCallback("OnValueChanged", function(obj, evt, val)	Attune_DB.raidShowMains = val; 	Attune_LoadRaidTree(); 	attunelocal_raidtreeframe:SetTree(attunelocal_raidtree);	Attune_RaidPlannerRoster() 	end)
			checkboxes:AddChild(cb)

			local cb = AceGUI:Create("CheckBox")
			cb:SetType("checkbox")
			cb:SetLabel(Lang["Show Unspecified"])
			cb:SetValue(Attune_DB.raidShowUnspecified)
			cb:SetWidth(150)
			cb:SetCallback("OnValueChanged", function(obj, evt, val)	Attune_DB.raidShowUnspecified = val; 	Attune_LoadRaidTree(); 	attunelocal_raidtreeframe:SetTree(attunelocal_raidtree);	Attune_RaidPlannerRoster() 	end)
			checkboxes:AddChild(cb)

			local cb = AceGUI:Create("CheckBox")
			cb:SetType("checkbox")
			cb:SetLabel(Lang["Guildies only"])
			cb:SetValue(Attune_DB.raidGuildOnly)
			cb:SetWidth(150)
			cb:SetCallback("OnValueChanged", function(obj, evt, val)	Attune_DB.raidGuildOnly = val; 	Attune_LoadRaidTree(); 	attunelocal_raidtreeframe:SetTree(attunelocal_raidtree);	Attune_RaidPlannerRoster() 	end)
			checkboxes:AddChild(cb)

			local cb = AceGUI:Create("CheckBox")
			cb:SetType("checkbox")
			cb:SetLabel(Lang["Show Alts"])
			cb:SetValue(Attune_DB.raidShowAlts)
			cb:SetWidth(150)
			cb:SetCallback("OnValueChanged", function(obj, evt, val)	Attune_DB.raidShowAlts = val; 	Attune_LoadRaidTree(); 	attunelocal_raidtreeframe:SetTree(attunelocal_raidtree);	Attune_RaidPlannerRoster() 	end)
			checkboxes:AddChild(cb)

			local cb = AceGUI:Create("CheckBox")
			cb:SetType("checkbox")
			cb:SetLabel(Lang["Show Unattuned"])
			cb:SetValue(Attune_DB.raidShowUnattuned)
			cb:SetWidth(150)
			cb:SetCallback("OnValueChanged", function(obj, evt, val)	Attune_DB.raidShowUnattuned = val; 	Attune_LoadRaidTree(); 	attunelocal_raidtreeframe:SetTree(attunelocal_raidtree);	Attune_RaidPlannerRoster() 	end)
			checkboxes:AddChild(cb)

			options:AddChild(checkboxes)

		local label = AceGUI:Create("Label")
		label:SetText(" ")
		label:SetFullWidth(true)
		label:SetFont(GameFontNormal:GetFont(), 12)
		options:AddChild(label)

	attunelocal_raidframe:AddChild(options)

	
	Attune_LoadRaidTree()

	attunelocal_raidtreeframe = AceGUI:Create("TreeGroup")
	attunelocal_raidtreeframe:SetTree(attunelocal_raidtree)
	attunelocal_raidtreeframe:SetLayout("Fill")
	attunelocal_raidtreeframe:SetFullWidth(true)
	attunelocal_raidtreeframe:SetFullHeight(true)
	attunelocal_raidtreeframe:SetAutoAdjustHeight(false)
	attunelocal_raidtreeframe:EnableButtonTooltips(false)
	attunelocal_raidframe:AddChild(attunelocal_raidtreeframe)


	attunelocal_raidtreeframe:SelectByPath("Unspec")
	attunelocal_raidtreeframe:SelectByPath("Healer")
	attunelocal_raidtreeframe:SelectByPath("Melee")
	attunelocal_raidtreeframe:SelectByPath("Ranged")
	attunelocal_raidtreeframe:SelectByPath("Tank")
		
	attunelocal_raidtreeframe:SetCallback("OnGroupSelected", function(container, event, group)
		local st, le = string.find(group, "\001")
		if st ~= nil then -- not a group
			local toon = string.sub(group, st+1)
			if toon ~= "" then
				local t = Attune_DB.toons[toon.."-"..GetRealmName()]
				local found = Attune_IsRaidSelected(t.name)
				
				if found ~= "" then 
					-- already in planner -> remove
					Attune_UpdateRaidTreeGroup(t.name, false)
					Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][found] = nil
					attunelocal_raidspotIcon[found]:SetText("|TInterface\\AddOns\\Attune\\Images\\raidslot:16|t  Empty")
					attunelocal_raidspotIcon[found].frame:SetAlpha(0.25)
					attunelocal_raidspotIcon[found]:SetCallback("OnEnter", function() end)
		
				else
					-- not in planner -> add to raid. Find a spot
					local placed = Attune_FindNextRaidSpot(attunelocal_raidsize, t, 0)
					if placed then 
						Attune_UpdateRaidTreeGroup(t.name, true)
					else
					end
				end
				attunelocal_raidtreeframe:SelectByPath(t.role)
			end
		end
	end)
 
	attunelocal_raidroster = AceGUI:Create("SimpleGroup")
	attunelocal_raidroster:SetLayout("Flow")
	attunelocal_raidroster:SetFullWidth(true)
	attunelocal_raidroster:SetFullHeight(true)
	attunelocal_raidtreeframe:AddChild(attunelocal_raidroster)

	Attune_RaidPlannerRoster()
end



-------------------------------------------------------------------------
-- Update the Raid treeview to show used or unused toons
-------------------------------------------------------------------------

function Attune_UpdateRaidTreeGroup(name, selected)
	for i, a in pairs(attunelocal_raidtree) do
		if a.children ~= nil then 
			for i2, a2 in pairs(a.children) do
				if a2.value == name then
					if selected then
						a2.text = "|cff606060"..name.."|r"
					else 
						a2.text = name
					end
				end
			end
		end
	end
end
-------------------------------------------------------------------------


function Attune_RaidPlannerRoster()

	attunelocal_raidroster:ReleaseChildren()

	for i, a in pairs(Attune_Data.attunes) do
		if (a.DEPRECATED == nil or Attune_DB.showDeprecatedAttunes) then 
			if tonumber(a.ID) == Attune_DB.raidSelection[attunelocal_faction] then 
				attunelocal_raidname = a.NAME
				attunelocal_raidsize = a.GROUPSIZE
				attunelocal_raidcount = a.SHOWRAIDPLANNER
			end
		end
	end
	for i, a in pairs(Attune_Data.noattunes) do
		if tonumber(a.ID) == Attune_DB.raidSelection[attunelocal_faction] then 
			attunelocal_raidname = a.NAME
			attunelocal_raidsize = a.GROUPSIZE
			attunelocal_raidcount = a.SHOWRAIDPLANNER
		end
	end
	attunelocal_raidspotIcon = {}	

	local raidgroup = AceGUI:Create("SimpleGroup")
	raidgroup:SetLayout("Fill")
	raidgroup:SetFullHeight(true)
	--raidgroup:SetWidth(770)
	raidgroup:SetFullWidth(true)

	local raidscroll = AceGUI:Create("ScrollFrame")
	raidscroll:SetLayout("Flow")
	raidscroll:SetFullHeight(true)


	for i=1, attunelocal_raidcount, 1	do 	

		
		local rgroup = AceGUI:Create("SimpleGroup")
		rgroup:SetLayout("Flow")
		rgroup:SetWidth((attunelocal_raidsize/5)*145+50)


		local inv = AceGUI:Create("Button")
		inv:SetText(Lang["Invite"])
		inv:SetWidth(70)
		inv:SetCallback("OnClick", function() 
			StaticPopupDialogs["INVITE_ATTUNE_RAID"] = {
				text = Lang["Send raid invites to all listed players?"],
				button1 = Lang["Accept"],
				button2 = Lang["Reject"],
				timeout = 0,
				hasEditBox = false,
				whileDead = true,
				hideOnEscape = true,
				preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
				OnAccept = function()
					Attune_SentRaidInvites(i)
				end,
				OnCancel = function (_,reason)
				end,
			}
			StaticPopup_Show ("INVITE_ATTUNE_RAID")
		end)
		rgroup:AddChild(inv)




		local sGroup = ""
		if attunelocal_raidcount > 1 then sGroup = " - " .. Lang["Group Number"]:gsub("##NUMBER##", i) end
		
		if Attune_DB.raidNames[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][i] == nil then 
			Attune_DB.raidNames[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][i] = attunelocal_raidname .. " - " .. Lang["Raid spots"]:gsub("##SIZE##", attunelocal_raidsize) .. sGroup
		end
		local label = AceGUI:Create("InteractiveLabel")
		label:SetText(" "..Attune_DB.raidNames[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][i])
		label:SetWidth((attunelocal_raidsize/5)*145+50-80)
		label.frame:SetAlpha(1)
		label:SetFont(GameFontNormal:GetFont(), 14)
		label:SetCallback("OnEnter", function() 
			GameTooltip:SetOwner(label.frame,"ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", label.frame,"BOTTOMLEFT", 10, 0)
			GameTooltip:SetText("Click to edit")
		end)				
		label:SetCallback("OnLeave", function() GameTooltip:Hide() end)
		label:SetCallback("OnClick", function() 
			StaticPopupDialogs["RENAME_ATTUNE_RAID"] = {
				text = Lang["Enter a new name for this raid group"],
				hasEditBox = true,
				button1 = Lang["Save"],
				button2 = Lang["Close"],
				timeout = 0,
				whileDead = true,
				hideOnEscape = true,
				editBoxWidth = 350,
				preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
				OnShow = function (self, data)
					self.editBox:SetText(""..Attune_DB.raidNames[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][i])
					--self.editBox:HighlightText()
					self.editBox:SetScript("OnEscapePressed", function(self) StaticPopup_Hide ("RENAME_ATTUNE_RAID") end)
		
				end,
				OnAccept = function(self)
					Attune_DB.raidNames[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][i] = self.editBox:GetText()
					Attune_RaidPlannerRoster()
				end,
				OnCancel = function (_,reason)
					--
				end,
				preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
				
			}
			StaticPopup_Show ("RENAME_ATTUNE_RAID")
		end)
		rgroup:AddChild(label)


		for r=1, (attunelocal_raidsize/5), 1	do 	

			local party = AceGUI:Create("InlineGroup")
			party:SetLayout("Flow")
			party:SetWidth(145)
	
			for s=1,5,1	do 	
				local spot = ((i-1)*attunelocal_raidsize) + ((r-1)*5) + s

				local icon = AceGUI:Create("InteractiveLabel")
				icon:SetCallback("OnEnter", function() 
					Attune_SetToolTip(icon.frame, nil)
				end)				

				if Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot] == nil then 
					icon:SetText("|TInterface\\AddOns\\Attune\\Images\\raidslot:16|t  Empty")
					icon.frame:SetAlpha(0.25)
					Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot] = nil
				else
					local t = Attune_DB.toons[Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot].."-"..GetRealmName()]
					if t ~= nil then 
						-- all good, toon is still in our data
						icon:SetText("|T"..Attune_Icons(t.class)..":16|t  "..t.name)
						icon.frame:SetAlpha(1)
						icon:SetCallback("OnEnter", function() 
							local gg = "<"..t.guild..">"
							if t.guild == "" then gg = Lang["Not in a guild"] end

							Attune_SetToolTip(icon.frame, nil, 2)
							Attune_SetToolTip(icon.frame, t.name .. " (" .. t.level.." "..t.class:sub(1,1):upper()..t.class:sub(2):lower()..")\n|cffffffff"..gg.."|r")
						end)
					else
						-- issue. Toon has been deleted from data, empty slot
						icon:SetText("|TInterface\\AddOns\\Attune\\Images\\raidslot:16|t  Empty")
						icon.frame:SetAlpha(0.25)
						Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot] = nil
					end
				end

				icon:SetFont(GameFontNormal:GetFont(), 12)
				icon:SetWidth(140)
				icon:SetImageSize(32, 32)
				party:AddChild(icon)

				icon:SetCallback("OnLeave", function() GameTooltip:Hide() end)
				icon:SetCallback("OnClick", function(obj, ev, but) 
					
					if Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot] == nil then 
						-- clicking an empty tile
						-- does nothing
					else
						-- clicking a toon
						if but == "LeftButton" then 
							-- Move to the next group
							local jumpTo = spot + (5 - (spot % 5))
							if spot % 5  == 0 then jumpTo = spot end
							local placed = Attune_FindNextRaidSpot(attunelocal_raidsize, Attune_DB.toons[Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot].."-"..GetRealmName()], jumpTo )
							if placed then 
								Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot] = nil
								attunelocal_raidspotIcon[spot]:SetText("|TInterface\\AddOns\\Attune\\Images\\raidslot:16|t  Empty")
								attunelocal_raidspotIcon[spot].frame:SetAlpha(0.25)
								attunelocal_raidspotIcon[spot]:SetCallback("OnEnter", function() end)
							end
						elseif but == "RightButton" then
							-- Remove
							
							Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot] = nil
							attunelocal_raidspotIcon[spot]:SetText("|TInterface\\AddOns\\Attune\\Images\\raidslot:16|t  Empty")
							attunelocal_raidspotIcon[spot].frame:SetAlpha(0.25)
							attunelocal_raidspotIcon[spot]:SetCallback("OnEnter", function() end)
							Attune_UpdateRaidTreeGroup(Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot], false)
							Attune_LoadRaidTree(); 	
							attunelocal_raidtreeframe:SetTree(attunelocal_raidtree);	
							Attune_RaidPlannerRoster()
						end
					end
				end)
				
				attunelocal_raidspotIcon[spot] = icon   -- isUsed / icon object
				
			end
			rgroup:AddChild(party)
		end

		
		local label = AceGUI:Create("Label")
		label:SetText("\n")
		label:SetFullWidth(true)
		label:SetFont(GameFontNormal:GetFont(), 18)
		rgroup:AddChild(label)

		raidscroll:AddChild(rgroup)

	end
	
	raidgroup:AddChild(raidscroll)
	attunelocal_raidroster:AddChild(raidgroup)

end


-------------------------------------------------------------------------

function Attune_SentRaidInvites(raidId)
	
	local nbInv = 0
	for spot=(raidId-1)*attunelocal_raidsize+1, raidId*attunelocal_raidsize, 1	do 	

		if Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot] ~= nil then 
			nbInv = nbInv + 1
			InviteUnit(Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot])
		end 
	end
	if nbInv > 0 then 	Attune_checkRaidGroup(0) end
end


-------------------------------------------------------------------------
--check the group until someone has joined, then convert to raid

function Attune_checkRaidGroup(iter) 

	-- 50 * 0.2s = 10s
	-- this checks for 10s after the first raid invite has been sent
	local iter = iter + 1
	if iter < 50 then 
		if GetNumGroupMembers() >= 2 then 
			ConvertToRaid()
			iter = iter + 999
		else
			C_Timer.After(0.2, function() Attune_checkRaidGroup(iter) end)
		end
	end
end

-------------------------------------------------------------------------

function Attune_SetToolTip(obj, text)

	GameTooltip:SetOwner(obj,"ANCHOR_NONE")
	GameTooltip:SetPoint("TOPLEFT", obj,"TOPRIGHT", 10, 0)

	if text == nil then 
		--GameTooltip:SetText(Lang["Empty"])
	else
		GameTooltip:SetText(text)
		GameTooltip:AddLine("\n|cffA0A0A0"..Lang["LeftClick"].." "..Lang["Move to next group"].."\n"..Lang["RightClick"].." "..Lang["Remove from raid"].."|r")
	end

end

-------------------------------------------------------------------------

function Attune_FindNextRaidSpot(raidsize, t, minspot)
	-- minspot used to only select spot coming after this minspot
	local placed = false
	for i=1, (50/raidsize), 1	do 	
		for r=1, (raidsize/5), 1	do 	
			for s=1,5,1	do 	
				local spot = ((i-1)*raidsize) + ((r-1)*5) + s
				if spot > minspot then
					if Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot] == nil and not placed then
--						if attunelocal_raidtoonIcon[t.name] ~= nil then attunelocal_raidtoonIcon[t.name].frame:SetAlpha(0.25) end
						Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]][spot] = t.name
						attunelocal_raidspotIcon[spot]:SetText("|T"..Attune_Icons(t.class)..":16|t  "..t.name)
						attunelocal_raidspotIcon[spot].frame:SetAlpha(1)
						attunelocal_raidspotIcon[spot]:SetCallback("OnEnter", function() 
							local gg = "<"..t.guild..">"
							if t.guild == "" then gg = Lang["Not in a guild"] end
							Attune_SetToolTip(attunelocal_raidspotIcon[spot].frame, t.name .. " (" .. t.level.." "..t.class:sub(1,1):upper()..t.class:sub(2):lower()..")\n|cffffffff"..gg.."|r")
						end)
						placed = true
						break				
					end
				end
			end
		end
	end
	return placed
end

-------------------------------------------------------------------------

function Attune_IsRaidSelected(name)
	-- check if already selected.
	for kr, r in pairs(Attune_DB.raidPlans[attunelocal_faction][Attune_DB.raidSelection[attunelocal_faction]]) do
		if r == name then return kr end
	end
	return ""
end

-------------------------------------------------------------------------

function Attune_ShowWebsiteURL(qstring)


--	if Dialog:ActiveDialog("AttuneWowheadUrlCopyDialog") then
--		Dialog:Dismiss("AttuneWowheadUrlCopyDialog")
--	end

	StaticPopupDialogs["ATTUNE_SHOW_URL"] = {
		text = Lang["External link"],
		button1 = Lang["Close"],
		OnShow = function (self, data)
			self.editBox:SetText("".. Attune_DB.websiteUrl .. "/" .. qstring)
			self.editBox:HighlightText()
			self.editBox:SetScript("OnEscapePressed", function(self) StaticPopup_Hide ("ATTUNE_SHOW_URL") end)

		end,
		timeout = 0,
		hasEditBox = true,
		editBoxWidth = 350,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show ("ATTUNE_SHOW_URL")

end

-------------------------------------------------------------------------

SlashCmdList["Attune"] = Attune_SlashCommandHandler
SLASH_Attune1 = "/attune"

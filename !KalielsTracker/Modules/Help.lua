--- Kaliel's Tracker
--- Copyright (c) 2012-2023, Marouan Sabbagh <mar.sabbagh@gmail.com>
--- All Rights Reserved.
---
--- This file is part of addon Kaliel's Tracker.

local addonName, KT = ...
local M = KT:NewModule(addonName.."_Help")
KT.Help = M

local T = LibStub("MSA-Tutorials-1.0")
local _DBG = function(...) if _DBG then _DBG("KT", ...) end end

local db, dbChar
local mediaPath = "Interface\\AddOns\\"..addonName.."\\Media\\"
local helpPath = mediaPath.."Help\\"
local helpName = "help"
local helpNumPages = 9
local supportersName = "supporters"
local supportersNumPages = 1
local cTitle = "|cffffd200"
local cBold = "|cff00ffe3"
local cWarning = "|cffff7f00"
local cDots = "|cff808080"
local offs = "\n|T:1:8|t"
local ebSpace = "|T:22:1|t"
local beta = "|cffff7fff[Beta]|r"
local new = "|cffff7fff[NEW]|r"

local KTF = KT.frame

--------------
-- Internal --
--------------

local function AddonInfo(name)
	local info = "Addon "..name
	if IsAddOnLoaded(name) then
		info = info.." |cff00ff00is installed|r."
	else
		info = info.." |cffff0000is not installed|r."
	end
	info = info.." Support you can enable / disable in Options."
	return info
end

local function SetFormatedPatronName(tier, name, realm, note)
	if realm then
		realm = " @"..realm
	else
		realm = ""
	end
	if note then
		note = " ... "..note
	else
		note = ""
	end
	return format("- |cff%s%s|r|cff7f7f7f%s%s|r\n", KT.QUALITY_COLORS[tier], name, realm, note)
end

local function SetFormatedPlayerName(name, realm, note)
	if realm then
		realm = " @"..realm
	else
		realm = ""
	end
	if note then
		note = " ... "..note
	else
		note = ""
	end
	return format("- %s|cff7f7f7f%s%s|r\n", name, realm, note)
end

local function SetupTutorials()
	T.RegisterTutorial(helpName, {
		savedvariable = KT.db.global,
		key = "helpTutorial",
		title = KT.title.." |cffffffff"..KT.version.."|r",
		icon = helpPath.."KT_logo",
		font = "Fonts\\FRIZQT__.TTF",
		width = 552,
		imageHeight = 256,
		{	-- 1
			image = helpPath.."help_kaliels-tracker",
			text = cTitle..KT.title.." (Classic)|r replaces default tracker and adds some features from WoW Retail to WoW WotLK Classic.\n\n"..
					"Some features:\n"..
					"- Tracking Quests and Achievements\n"..
					"- Change tracker position\n"..
					"- Expand / Collapse tracker relative to selected position (direction)\n"..
					"- Auto set trackers height by content with max. height limit\n"..
					"- Scrolling when content is greater than max. height\n"..
					"- Remember collapsed tracker after logout / exit game\n\n"..
					"... and many other enhancements (see next pages).",
			shine = KTF,
			shineTop = 5,
			shineBottom = -5,
			shineLeft = -6,
			shineRight = 6,
		},
		{	-- 2
			image = helpPath.."help_header-buttons",
			imageHeight = 128,
			text = cTitle.."Header buttons|r\n\n"..
					"Minimize button:                                Other buttons:\n"..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:-1:2:32:64:0:14:0:14:209:170:0|t "..cDots.."...|r Expand Tracker                          "..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:3:2:32:64:16:30:0:14:209:170:0|t  "..cDots.."...|r Open Quest Log\n"..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:-1:2:32:64:0:14:16:30:209:170:0|t "..cDots.."...|r Collapse Tracker                        "..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:3:2:32:64:16:30:16:30:209:170:0|t  "..cDots.."...|r Open Achievements\n"..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:-1:2:32:64:0:14:32:46:209:170:0|t "..cDots.."...|r when is tracker empty               "..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:3:2:32:64:16:30:32:46:209:170:0|t  "..cDots.."...|r Open Filters menu\n\n"..
					"Buttons |T"..mediaPath.."UI-KT-HeaderButtons:14:14:0:2:32:64:16:30:0:14:209:170:0|t and "..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:0:2:32:64:16:30:16:30:209:170:0|t you can disable in Options.\n\n"..
					"You can set "..cBold.."[key bind]|r for Minimize button.\n"..
					cBold.."Alt+Click|r on Minimize button opens "..KT.title.." Options.",
			textY = 16,
			shine = KTF.MinimizeButton,
			shineTop = 13,
			shineBottom = -14,
			shineRight = 16,
		},
		{	-- 3
			image = helpPath.."help_quest-title-tags",
			imageHeight = 128,
			text = cTitle.."Quest title tags|r\n\n"..
					"Quest level |cffff8000[42]|r is at the beginning of the quest title.\n"..
					"Quest type tags are at the end of quest title.\n\n"..
					KT.CreateQuestTagIcon(nil, 7, 14, 2, 0, 0.34, 0.425, 0, 0.28125).." "..cDots.."........|r Daily quest|T:14:121|t"..
						KT.CreateQuestTagIcon(nil, 16, 16, 0, 0, unpack(QUEST_TAG_TCOORDS[Enum.QuestTag.Heroic])).." "..cDots.."......|r Heroic quest\n"..
					KT.CreateQuestTagIcon(nil, 7, 14, 2, 0, 0.34, 0.425, 0, 0.28125)..KT.CreateQuestTagIcon(nil, 7, 14, 0, 0, 0.34, 0.425, 0, 0.28125).." "..cDots.."......|r Weekly quest|T:14:107|t"..
						KT.CreateQuestTagIcon(nil, 16, 16, 0, 0, unpack(QUEST_TAG_TCOORDS[Enum.QuestTag.PvP])).." "..cDots.."......|r PvP quest\n"..
					KT.CreateQuestTagIcon(nil, 16, 16, 0, 0, unpack(QUEST_TAG_TCOORDS[Enum.QuestTag.Group])).." "..cDots.."......|r Group quest|T:14:114|t"..
						"|cffd900b8S|r "..cDots.."........|r Scenario quest\n"..
					KT.CreateQuestTagIcon(nil, 16, 16, 0, 0, unpack(QUEST_TAG_TCOORDS[Enum.QuestTag.Dungeon])).." "..cDots.."......|r Dungeon quest|T:14:95|t"..
						KT.CreateQuestTagIcon(nil, 16, 16, 0, 0, unpack(QUEST_TAG_TCOORDS[Enum.QuestTag.Account])).." "..cDots.."......|r Account quest\n"..
					KT.CreateQuestTagIcon(nil, 17, 17, -1, 0, unpack(QUEST_TAG_TCOORDS[Enum.QuestTag.Raid])).." "..cDots.."......|r Raid quest|T:14:125|t"..
						KT.CreateQuestTagIcon(nil, 7, 14, 2, 0, 0.055, 0.134, 0.28125, 0.5625).." "..cDots.."........|r Legendary quest\n\n"..
					cWarning.."Note:|r Not all of these tags are used in Classic.",
			shineTop = 10,
			shineBottom = -9,
			shineLeft = -12,
			shineRight = 10,
		},
		{	-- 4
			image = helpPath.."help_tracker-filters",
			text = cTitle.."Tracker Filters|r\n\n"..
					"For open Filters menu "..cBold.."Click|r on the button |T"..mediaPath.."UI-KT-HeaderButtons:14:14:-2:1:32:64:16:30:32:46:209:170:0|t.\n\n"..
					"There are two types of filters:\n"..
					cTitle.."Static filter|r - adds quests/achievements to tracker by criterion (e.g. \"Daily\") and then you can add / remove items by hand.\n"..
					cTitle.."Dynamic filter|r - automatically adding quests/achievements to tracker by criterion (e.g. \"|cff00ff00Auto|r Zone\") "..
					"and continuously changing them. This type doesn't allow add / remove items by hand."..
					"When is some Dynamic filter active, header button is green |T"..mediaPath.."UI-KT-HeaderButtons:14:14:-2:1:32:64:16:30:32:46:0:255:0|t.\n\n"..
					"For Achievements can change searched categories, it will affect the outcome of the filter.\n\n"..
					"This menu displays other options affecting the content of the tracker.",
			textY = 16,
			shine = KTF.FilterButton,
			shineTop = 10,
			shineBottom = -11,
			shineLeft = -10,
			shineRight = 11,
		},
		{	-- 5
			image = helpPath.."help_quest-item-buttons",
			text = cTitle.."Quest Item buttons|r\n\n"..
					"For support Quest Items you need Questie addon (see page 8). Buttons are out of the tracker, because Blizzard doesn't allow to work with the action buttons inside addons.\n\n"..
					"|T"..helpPath.."help_quest-item-buttons_2:32:32:1:0:64:32:0:32:0:32|t "..cDots.."...|r  This tag indicates quest item in quest. The number inside is for\n"..
					"              identification moved quest item button.\n\n"..
					"|T"..helpPath.."help_quest-item-buttons_2:32:32:0:3:64:32:32:64:0:32|t "..cDots.."...|r  Real quest item button is moved out of the tracker to the left/right\n"..
					"              side (by selected anchor point). The number is the same as for the tag.\n\n"..
					cWarning.."Warning:|r\n"..
					"In some situation during combat, actions around the quest item buttons paused and carried it up after a player is out of combat.",
			shineTop = 3,
			shineBottom = -2,
			shineLeft = -4,
			shineRight = 3,
		},
		{	-- 6
			image = helpPath.."help_tracker-modules",
			text = cTitle.."Order of Modules|r\n\n"..
					"Allows to change the order of modules inside the tracker. Supports all modules including external (e.g. PetTracker).",
			shine = KTF,
			shineTop = 5,
			shineBottom = -5,
			shineLeft = -6,
			shineRight = 6,
		},
		{	-- 7
			image = helpPath.."help_quest-log",
			text = cTitle.."Quest Log|r\n\n"..
					cWarning.."Note:|r In Blizzard's Quest Log and supported Quest Log addons is disabled click on Quest Log "..
					"headers (for collapse / expand). This is because collapsed sections hide contained quests for "..KT.title..".\n\n"..

					cTitle.."Supported addons|r\n"..
					"- Classic Quest Log\n"..ebSpace.."\n"..
					"- QuestGuru\n"..ebSpace,
			editbox = {
				{
					text = "https://www.wowinterface.com/downloads/info24937-ClassicQuestLogforClassic.html",
					width = 485,
					left = 9,
					bottom = 37,
				},
				{
					text = "https://www.curseforge.com/wow/addons/questguru_classic",
					width = 485,
					left = 9,
					bottom = 3,
				}
			},
			shine = KTF,
			shineTop = 5,
			shineBottom = -5,
			shineLeft = -6,
			shineRight = 6,
		},
		{	-- 8
			image = helpPath.."help_addon-questie",
			text = cTitle.."Support addon Questie|r\n\n"..
					"Questie support adds some features that use this addon's quest database.\n\n"..
					cTitle.."Zone filtering improvements|r\n"..
					"Improved zone filtering now shows relevant quests in all quest-related zones (start, progress and end locations).\n\n"..
					cTitle.."Quest Item buttons|r\n"..
					"For quests with usable items, shows these items as a buttons next to the tracker (see page 5).\n\n"..
					cTitle.."Quest dropdown menu options|r\n"..
					"- "..cBold.."Show on Map|r - displays a map with closest quest objectives.\n"..
					"- "..cBold.."Set TomTom Waypoint|r - sets TomTom arrow for closest quest objective. This"..
					offs.."option is shown, if addon TomTom is installed.\n\n"..
					"Options "..cBold.."Show on Map|r and "..cBold.."Set TomTom Waypoint|r are disabled, if no map data exists.\n\n"..
					AddonInfo("Questie").."\n"..ebSpace,
			editbox = {
				{
					text = "https://www.curseforge.com/wow/addons/questie",
					width = 450,
					bottom = 3,
				}
			},
			shine = KTF,
			shineTop = 5,
			shineBottom = -5,
			shineLeft = -6,
			shineRight = 6,
		},
		{	-- 9
			text = cTitle.."         What's NEW|r\n\n"..
					cTitle.."Version 3.3.0|r\n"..
					"- ADDED - Support for WoW 3.4.1\n"..
					"- FIXED - Error when displaying Notification messages\n"..
					"- UPDATED - Addon support - Questie 7.4.10\n"..
					"- UPDATED - Addon support - ElvUI 13.21, Tukui 20.37\n"..
					"- UPDATED - Help - Supporters (Patreon)\n\n"..

					cTitle.."WoW 3.4.1 - Known issues w/o solution|r\n"..
					"- Clicking on tracked quests or achievements has no response during combat.\n"..
					"- Header buttons Q and A don't work during combat.\n\n"..

					cTitle.."Issue reporting|r\n"..
					"For reporting please use "..cBold.."Tickets|r instead of Comments on CurseForge.\n"..ebSpace.."\n\n"..

					cWarning.."Before reporting of errors, please deactivate other addons and make sure the bug is not caused "..
					"by a collision with another addon.|r",
			textY = -20,
			editbox = {
				{
					text = "https://www.curseforge.com/wow/addons/kaliels-tracker-classic/issues",
					width = 450,
					bottom = 38,
				}
			},
			shine = KTF,
			shineTop = 5,
			shineBottom = -5,
			shineLeft = -6,
			shineRight = 6,
		},
		onShow = function(self, i)
			if dbChar.collapsed then
				ObjectiveTracker_MinimizeButton_OnClick()
			end
			if i == 2 then
				if KTF.FilterButton then
					self[i].shineLeft = db.headerOtherButtons and -75 or -35
				else
					self[i].shineLeft = db.headerOtherButtons and -55 or -15
				end
			elseif i == 3 then
				local questInfo = KT_GetQuestListInfo(1)
				if questInfo then
					local block = QUEST_TRACKER_MODULE.usedBlocks[questInfo.id]
					if block then
						self[i].shine = block
					end
				end
			elseif i == 5 then
				self[i].shine = KTF.Buttons
			end
		end,
		onHide = function()
			T.TriggerTutorial("supporters", 1)
		end
	})

	T.RegisterTutorial("supporters", {
		savedvariable = KT.db.global,
		key = "supportersTutorial",
		title = KT.title.." |cffffffff"..KT.version.."|r",
		icon = helpPath.."KT_logo",
		font = "Fonts\\FRIZQT__.TTF",
		width = 552,
		imageHeight = 256,
		{	-- 1
			text = cTitle.."         Become a Patron|r\n\n"..
					"If you like "..KT.title..", support me on |cfff34a54Patreon|r.\n\n"..
					"Click on button  |T"..helpPath.."help_patreon:20:154:1:0:256:32:0:156:0:20|t  on CurseForge addon page.\n\n"..
					"After 10 years of working on an addon, I started Patreon. It's created as\na compensation for the amount "..
					"of time that addon development requires.\n\n"..
					"                                    Many thanks to all supporters  |T"..helpPath.."help_patreon:16:16:0:0:256:32:157:173:0:16|t\n\n"..
					cTitle.."Patrons|r\n"..
					SetFormatedPatronName("Legendary", "Zayah", "Vek'nilash")..
					SetFormatedPatronName("Epic", "Squishses", "Area 52")..
					SetFormatedPatronName("Uncommon", "Charles Howarth")..
					SetFormatedPatronName("Uncommon", "Flex (drantor)")..
					SetFormatedPatronName("Uncommon", "Kyle Fuller")..
					SetFormatedPatronName("Uncommon", "Pablo Sebastián Molina Silva")..
					SetFormatedPatronName("Uncommon", "Semy", "Ravencrest")..
					SetFormatedPatronName("Uncommon", "Torresman", "Drak'thul")..
					SetFormatedPatronName("Uncommon", "Xeelee", "Razorfen")..
					SetFormatedPatronName("Common", "Darren Divecha")..
					"\n"..
					cTitle.."Testers|r\n"..
					SetFormatedPlayerName("Asimeria", "Drak'thul")..
					SetFormatedPlayerName("Torresman", "Drak'thul"),
			textY = -20,
		},
	})
end

--------------
-- External --
--------------

function M:OnInitialize()
	_DBG("|cffffff00Init|r - "..self:GetName(), true)
	db = KT.db.profile
	dbChar = KT.db.char
end

function M:OnEnable()
	_DBG("|cff00ff00Enable|r - "..self:GetName(), true)
	SetupTutorials()
	local last = false
	if KT.version ~= KT.db.global.version then
		local data = T.GetTutorial(helpName)
		local index = data.savedvariable[data.key]
		if index then
			last = index < helpNumPages and index or true
			T.ResetTutorial(helpName)
		end
	end
	T.TriggerTutorial(helpName, helpNumPages, last)
end

function M:ShowHelp(index)
	InterfaceOptionsFrame:Hide()
	T.ResetTutorial(helpName)
	T.TriggerTutorial(helpName, helpNumPages, index or false)
end

function M:ShowSupporters()
	InterfaceOptionsFrame:Hide()
	T.ResetTutorial(supportersName)
	T.TriggerTutorial(supportersName, supportersNumPages)
end
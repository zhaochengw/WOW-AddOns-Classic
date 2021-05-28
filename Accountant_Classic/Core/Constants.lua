-- $Id: Constants.lua 10 2017-04-12 09:58:16Z arith $
-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local GetBuildInfo = _G.GetBuildInfo

-- Libraries

-- Determine WoW TOC Version
local WoWClassic, WoWRetail
local wowtocversion  = select(4, GetBuildInfo())
if wowtocversion < 30000 then
	WoWClassic = true
else
	WoWRetail = true
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
private.addon_name = "Accountant_Classic"

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

local constants = {}
private.constants = constants

local playerFaction = UnitFactionGroup("player")
local _, playerClass = UnitClass("player")

constants.defaults = {
	profile = {
		minimap = {
			hide = false,
			show = true,
			minimapPos = 153,
		},
		showbutton = true, 
		showmoneyinfo = true, 
		showintrotip = true,
		showmoneyonbutton = true,
		showsessiononbutton = true,
		cross_server = true,
		show_allFactions = true,
		trackzone = true,
		tracksubzone = true,
		breakupnumbers = true,
		weekstart = 1,
		ldbDisplayType = 2,
		dateformat = 1,
		scale = 1,
		alpha = 1,
		infoscale = 1,
		infoalpha = 1,
		faction = playerFaction,
		class = playerClass,
		AcFramePoint = { "TOPLEFT", "UIParent", "TOPLEFT", 0, -104 },
		MnyFramePoint = { "TOPLEFT", "UIParent", "TOPLEFT", 10, -80 },
		profileCopied = false,
		rememberSelectedCharacter = true,
	},
}

constants.logmodes = {"Session", "Day", "PrvDay", "Week", "PrvWeek", "Month", "PrvMonth", "Year", "PrvYear", "Total" }

if WoWClassic then 
	constants.events = {
		-- Talent
		"CONFIRM_TALENT_WIPE",
		-- Merchant
		"MERCHANT_SHOW",
		"MERCHANT_CLOSED",
		"MERCHANT_UPDATE",
		-- Quest
		"QUEST_COMPLETE",
		"QUEST_FINISHED",
		"QUEST_TURNED_IN",
		-- Loot
		"LOOT_OPENED",
		"LOOT_CLOSED",
		-- Taxi
		"TAXIMAP_OPENED",
		"TAXIMAP_CLOSED",
		-- Trade
		"TRADE_SHOW",
		"TRADE_CLOSED",
		-- Mail
		"MAIL_INBOX_UPDATE",
		"MAIL_SHOW",
		"MAIL_CLOSED",
		-- Trainer
		"TRAINER_SHOW",
		"TRAINER_CLOSED",
		-- AH
		"AUCTION_HOUSE_SHOW",
		"AUCTION_HOUSE_CLOSED",
		-- Others
		"CHAT_MSG_MONEY",
		"PLAYER_MONEY",
	}
	constants.logtypes = {
		"TRAIN", "TAXI", "TRADE", "AH", "MERCH", "REPAIRS", "MAIL", "QUEST", "LOOT", "OTHER" 
	}
	constants.onlineData = {
		["TRAIN"] = 	{ Title = L["Training Costs"]};
		["TAXI"] = 	{ Title = L["Taxi Fares"]};
		["TRADE"] = 	{ Title = L["Trade Window"]};
		["AH"] = 	{ Title = AUCTIONS};
		["MERCH"] = 	{ Title = L["Merchants"]};
		["REPAIRS"] = 	{ Title = L["Repair Costs"]};
		["MAIL"] = 	{ Title = L["Mail"]};
		["QUEST"] = 	{ Title = QUESTS_LABEL};
		["LOOT"] = 	{ Title = LOOT};
		["OTHER"] = 	{ Title = L["Unknown"]};
	}
else
	constants.events = {
		-- Garrison
		"GARRISON_MISSION_FINISHED",
		"GARRISON_ARCHITECT_OPENED",
		"GARRISON_ARCHITECT_CLOSED",
		"GARRISON_MISSION_NPC_OPENED",
		"GARRISON_MISSION_NPC_CLOSED",
		"GARRISON_SHIPYARD_NPC_OPENED",
		"GARRISON_SHIPYARD_NPC_CLOSED",
		"GARRISON_UPDATE",
		-- Barber shop
		"BARBER_SHOP_APPEARANCE_APPLIED",
		"BARBER_SHOP_OPEN",
		"BARBER_SHOP_CLOSE",
		"BARBER_SHOP_RESULT",
		"BARBER_SHOP_FORCE_CUSTOMIZATIONS_UPDATE",
		"BARBER_SHOP_COST_UPDATE",
		-- LFG
		"LFG_COMPLETION_REWARD",
		-- VOID
		"VOID_STORAGE_OPEN",
		"VOID_STORAGE_CLOSE",
		-- Transform
		"TRANSMOGRIFY_OPEN",
		"TRANSMOGRIFY_CLOSE",
		-- Guild
		"GUILDBANKFRAME_OPENED",
		"GUILDBANKFRAME_CLOSED",
		"GUILDBANK_UPDATE_MONEY",
		"GUILDBANK_UPDATE_WITHDRAWMONEY",
		-- Talent
		"CONFIRM_TALENT_WIPE",
		-- Merchant
		"MERCHANT_SHOW",
		"MERCHANT_CLOSED",
		"MERCHANT_UPDATE",
		-- Quest
		"QUEST_COMPLETE",
		"QUEST_FINISHED",
		"QUEST_TURNED_IN",
		-- Loot
		"LOOT_OPENED",
		"LOOT_CLOSED",
		-- Taxi
		"TAXIMAP_OPENED",
		"TAXIMAP_CLOSED",
		-- Trade
		"TRADE_SHOW",
		"TRADE_CLOSED",
		-- Mail
		"MAIL_INBOX_UPDATE",
		"MAIL_SHOW",
		"MAIL_CLOSED",
		-- Trainer
		"TRAINER_SHOW",
		"TRAINER_CLOSED",
		-- AH
		"AUCTION_HOUSE_SHOW",
		"AUCTION_HOUSE_CLOSED",
		-- Others
		"CHAT_MSG_MONEY",
		"PLAYER_MONEY",
	}
	constants.logtypes = {
		"VOID", "TRANSMO", "GARRISON", "LFG", "BARBER", "GUILD",
		"TRAIN", "TAXI", "TRADE", "AH", "MERCH", "REPAIRS", "MAIL", "QUEST", "LOOT", "OTHER" 
	}
	constants.onlineData = {
		["VOID"] =  	{ Title = VOID_STORAGE};
		["TRANSMO"] =	{ Title = TRANSMOGRIFY};
		["GARRISON"] =	{ Title = GARRISON_LOCATION_TOOLTIP.." / "..ORDER_HALL_MISSIONS };
		["LFG"] =	{ Title = L["LFD, LFR and Scen."]};
		["BARBER"] =	{ Title = BARBERSHOP};
		["GUILD"] =	{ Title = GUILD};

		["TRAIN"] = 	{ Title = L["Training Costs"]};
		["TAXI"] = 	{ Title = L["Taxi Fares"]};
		["TRADE"] = 	{ Title = L["Trade Window"]};
		["AH"] = 	{ Title = AUCTIONS};
		["MERCH"] = 	{ Title = L["Merchants"]};
		["REPAIRS"] = 	{ Title = L["Repair Costs"]};
		["MAIL"] = 	{ Title = L["Mail"]};
		["QUEST"] = 	{ Title = QUESTS_LABEL};
		["LOOT"] = 	{ Title = LOOT};
		["OTHER"] = 	{ Title = L["Unknown"]};
	}
end


constants.currTab = 1

constants.ldbDisplayTypes = { "Total", "Session", "Day", "Week", "Month" }

constants.dateformats = { "mm/dd/yy", "dd/mm/yy", "yy/mm/dd", }


constants.tabText = {
	L["This Session"],
	L["Today"],
	L["Prv. Day"],
	L["This Week"],
	L["Prv. Week"],
	L["This Month"],
	L["Prv. Month"],
	L["This Year"],
	L["Prv. Year"],
	L["Total"],
	L["All Chars"],
}



-- Maximum lines for characters to be displayed. 
-- We have 18 lines of space but we are using the 18th line to present the total. 
constants.maxCharLines = 17

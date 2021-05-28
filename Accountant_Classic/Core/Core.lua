--[[
$Id: Core.lua 364 2021-05-19 13:18:52Z arithmandar $
]]
--[[
 Accountant
    v2.1 - 2.3:
    By Sabaki (sabaki@gmail.com)
        Updated by: Shadow
        new codes by Shadow and Rophy

	Tracks you incoming / outgoing cash

        Thanks To:
	2006/6/18 Rophy: v2.2 Added gold shared by party

	Thanks To:
	Losimagic, Shrill, Fillet for testing
	Atlas by Razark for the minimap icon code I lifted
	Everyone who commented and voted for the mod on curse-gaming.com
  Thiou for the French loc, Snj & JokerGermany for the German loc
  ---------------------------------------------------------------------
  v2.4 - v2.12:
     Updated by: Arith
     Tntdruid for adding Garrison, Barber shop, Void, and Transform logging in v2.5.22
]]
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local pairs, select, unpack, type = _G.pairs, _G.select, _G.unpack, _G.type
local tonumber = _G.tonumber
local table = _G.table
local tinsert, tsort = table.insert, table.sort
local string = _G.string
local format, gsub, strfind, strsub = string.format, string.gsub, string.find, string.sub
local math = _G.math
local floor, fmod = math.floor, math.fmod
-- WoW
local PanelTemplates_TabResize, PanelTemplates_SetNumTabs, PanelTemplates_SetTab, PanelTemplates_UpdateTabs = PanelTemplates_TabResize, PanelTemplates_SetNumTabs, PanelTemplates_SetTab, PanelTemplates_UpdateTabs
local GetAddOnInfo, GetAddOnMetadata, GetRealmName, UnitName, UnitFactionGroup, UnitClass, GetBuildInfo = GetAddOnInfo, GetAddOnMetadata, GetRealmName, UnitName, UnitFactionGroup, UnitClass, GetBuildInfo
local GetBackpackCurrencyInfo = GetBackpackCurrencyInfo or nil
local GetCurrencyInfo = GetCurrencyInfo or nil

-- Determine WoW TOC Version
local WoWClassic, WoWRetail
local wowtocversion  = select(4, GetBuildInfo())
if wowtocversion < 30000 then
	WoWClassic = true
else
	WoWRetail = true
	GetBackpackCurrencyInfo = C_CurrencyInfo.GetBackpackCurrencyInfo
	GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub

local addon = LibStub("AceAddon-3.0"):NewAddon(private.addon_name, "AceConsole-3.0", "AceHook-3.0")
addon.constants = private.constants
addon.constants.addon_name = private.addon_name
addon.Name = FOLDER_NAME
addon.LocName = select(2, GetAddOnInfo(addon.Name))
addon.Notes = select(3, GetAddOnInfo(addon.Name))
_G.Accountant_Classic = addon

-- UIDropDownMenu
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

local MoneyFrame

local LibDialog = LibStub("LibDialog-1.0");
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name);
local ACbutton = LibStub("LibDBIcon-1.0")
local AceDB = LibStub("AceDB-3.0")
-- Minimap button with LibDBIcon-1.0
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject(private.addon_name);
if ( TitanPanelButton_UpdateButton ) then
	TitanPanelButton_UpdateButton(private.addon_name);
end

local AccountantClassic_Version = GetAddOnMetadata(private.addon_name, "Version");
--AccountantClassic_Disabled = false;
-- NewDB
local AC_NewDB = fales
local AC_LOGTYPE = ""
local AC_CURRMONEY = 0
local AC_LASTSESSMONEY = 0
local AC_LASTMONEY = 0
local AC_CURRTAB = private.constants.currTab
--local AC_MONTHS = { CalendarGetMonthNames() }
local AC_MONTHS = { MONTH_JANUARY, MONTH_FEBRUARY, MONTH_MARCH, MONTH_APRIL, MONTH_MAY, MONTH_JUNE, MONTH_JULY, MONTH_AUGUST, MONTH_SEPTEMBER, MONTH_OCTOBER, MONTH_NOVEMBER, MONTH_DECEMBER }

-- Number of Accountant Classic tabs; also the tab number of "All Character"
local AC_TABS = #private.constants.logmodes + 1
local AC_CHARSCROLL_LIST = {}
local AC_CURR_LINES = 0
local AC_CHAR_LINES = private.constants.maxCharLines -- Maximum lines for characters to be displayed. We have 18 lines of space but we are using the 18th line to present the total. 
local AC_SELECTED_CHAR_NUM
local AC_SELECTED_SERVER
local AC_SELECTED_FACTION
local AccountantClassic_Verbose = nil;
--local AccountantClassic_GotName = false;

local AC_SERVER = GetRealmName()
local AC_PLAYER = UnitName("player")
local AC_FACTION = UnitFactionGroup("player")
local AC_CLASS = select(2, UnitClass("player"))
local AC_SHOWALLCHARS = false

local AC_DATA = private.constants.onlineData

local cdate = date("%d/%m/%y")
local cmonth = date("%m")
local cyear = date("%Y")

local profile
local AC_FIRSTLOADED = false

local AccountantClassicDefaultOptions = {
	version = AccountantClassic_Version, 
	date = cdate, -- to be used as "today"
	lastsessiondate = cdate,
	-- prvday, 
	weekdate = "", 
	-- prvdateweek, 
	month = cmonth,
	-- prvmonth,
	weekstart = 1, 
	curryear = cyear,
	-- prvyear,
	totalcash = 0,
	faction = AC_FACTION,
	class = AC_CLASS,
};

local function TableIndex(t,val)
	for k,v in ipairs(t) do 
		if v == val then return k end
	end
end

local function orderednext(t, n)
	local key = t[t.__next]
	
	if not key then return end
	t.__next = t.__next + 1
	return key, t.__source[key]
end

local function orderedpairs(t, f)
	local keys, kn = {__source = t, __next = 1}, 1
	
	for k in pairs(t) do
		keys[kn], kn = k, kn + 1
	end
	tsort(keys, f)
	return orderednext, keys
end

-- Code by Grayhoof (SCT)
local function AccountantClassic_CloneTable(tablein)	-- Return a copy of the table tablein
	local new_table = {};			-- Create a new table
	local ka, va = next(tablein, nil);	-- The ka is an index of tablein; va = tablein[ka]
	while ka do
		if type(va) == "table" then 
			va = AccountantClassic_CloneTable(va);
		end 
		new_table[ka] = va;
		ka, va = next(tablein, ka);	-- Get next index
	end
	return new_table;
end

-- function to check if user has all the options parameter, 
-- if not (due to some might be newly added), then add it with default value
local function AccountantClassic_UpdateOptions(player_options)
	for k, v in pairs(AccountantClassicDefaultOptions) do
		if (player_options[k] == nil) then
			player_options[k] = v;
		end
	end
end

local function AccountantClassic_InitZoneDB()
	if (Accountant_ClassicZoneDB == nil) then
		Accountant_ClassicZoneDB = { }
	end
	if (Accountant_ClassicZoneDB[AC_SERVER] == nil) then
		Accountant_ClassicZoneDB[AC_SERVER] = { }
	end
	if (Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER] == nil) then
		AC_FIRSTLOADED = true
		Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER] = { 
			data = { }
		}
	end
	for k_logmode, v_logmode in pairs(private.constants.logmodes) do
		if (Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"][v_logmode] == nil) then
			Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"][v_logmode] = { }
			for k_logtype, v_logtype in pairs(private.constants.logtypes) do
				Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"][v_logmode][v_logtype] = { }
			end
		end
	end
end

local function initOptions()
	local cdate = date("%d/%m/%y");
	local cmonth = date("%m");
	local cyear = date("%Y");

	if (Accountant_ClassicSaveData == nil) then
		Accountant_ClassicSaveData = {};
	end
	if (Accountant_ClassicSaveData[AC_SERVER] == nil) then
		Accountant_ClassicSaveData[AC_SERVER] = {};
	end
	if (Accountant_ClassicSaveData[AC_SERVER][AC_PLAYER] == nil ) then
		Accountant_ClassicSaveData[AC_SERVER][AC_PLAYER] = {
			options = AccountantClassicDefaultOptions,
			data = { },
		};
		--ACC_Print(format(L["ACCLOC_NEWPROFILE"], AC_PLAYER));
	else
		--ACC_Print(format(L["ACCLOC_LOADPROFILE"], AC_PLAYER));
	end
	if (AC_NewDB) then
		if (Accountant_Classic_NewDB == nil) then
			Accountant_Classic_NewDB = {};
		end
		if (Accountant_Classic_NewDB[AC_SERVER] == nil) then
			Accountant_Classic_NewDB[AC_SERVER] = {};
		end
		if (Accountant_Classic_NewDB[AC_SERVER][AC_PLAYER] == nil ) then
			Accountant_Classic_NewDB[AC_SERVER][AC_PLAYER] = {
				data = { },
			};
		end
		if (Accountant_Classic_NewDB[AC_SERVER][AC_PLAYER][cdate] == nil ) then
			Accountant_Classic_NewDB[AC_SERVER][AC_PLAYER]["data"][cdate] = { };
		end
	end

	AccountantClassic_Profile = Accountant_ClassicSaveData[AC_SERVER][AC_PLAYER];

	AccountantClassic_UpdateOptions(AccountantClassic_Profile["options"]);

	AccountantClassic_InitZoneDB();
end

local function copyOptions()
	local oprofile = Accountant_ClassicSaveData[AC_SERVER][AC_PLAYER]["options"]
	local db = addon.db.profile
	
	if (db.oprofileCopied) then return end
	db.showbutton = oprofile.showbutton
	db.showmoneyinfo = oprofile.showmoneyinfo
	db.showintrotip = oprofile.showintrotip
	db.showmoneyonbutton = oprofile.showmoneyonbutton
	db.showsessiononbutton = oprofile.showsessiononbutton
	db.cross_server = oprofile.cross_server
	db.trackzone = oprofile.trackzone
	db.tracksubzone = oprofile.tracksubzone
	db.breakupnumbers = oprofile.breakupnumbers
	db.weekstart = profile.weekstart
	db.dateformat = profile.dateformat
	db.scale = profile.scale
	db.alpha = profile.alpha
	db.infoscale = profile.infoscale
	db.infoalpha = profile.infoalpha

	db.oprofileCopied = true
end

local function arrangeAccountantClassicFrame()
	local f = _G["AccountantClassicFrame"]
	if not f then return end
	f:SetScale(profile.scale)
	f:SetAlpha(profile.alpha)
	local point, relativeTo, relativePoint, ofsx, ofsy = unpack(profile.AcFramePoint)
	f:ClearAllPoints()
	f:SetParent("UIParent")
	f:SetPoint(point or "TOPLEFT", nil, relativePoint or "TOPLEFT", ofsx or 0, ofsy or -104)
end

function AccountantClassic_RegisterEvents(self)
        for key, value in pairs( private.constants.events ) do
            self:RegisterEvent( value );
        end
	--self:RegisterForDrag("LeftButton");
end

local function createACFrames()
	local parentName = "AccountantClassicFrame"
	local f = _G[parentName]
	
	f.ServerDropDown = _G[parentName.."ServerDropDown"] 
	if not f.ServerDropDown then 
		f.ServerDropDown = LibDD:Create_UIDropDownMenu(parentName.."ServerDropDown", f)
		f.ServerDropDown:Hide()
		f.ServerDropDown:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -38)
		f.ServerDropDown.Label = f.ServerDropDown:CreateFontString(parentName.."ServerDropDownLabel", "BACKGROUND", "GameFontNormalSmall")
		f.ServerDropDown.Label:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, 0)
		f.ServerDropDown:SetScript("OnShow", function(self)
			AccountantClassicFrameServerDropDown_Setup()
		end)
	end
	
	f.FactionDropDown = _G[parentName.."FactionDropDown"]
	if not f.FactionDropDown then 
		f.FactionDropDown = LibDD:Create_UIDropDownMenu(parentName.."FactionDropDown", f)
		f.FactionDropDown:Hide()
		f.FactionDropDown:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -62)
		f.FactionDropDown.Label = f.ServerDropDown:CreateFontString(parentName.."FactionDropDownLabel", "BACKGROUND", "GameFontNormalSmall")
		f.FactionDropDown.Label:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, 0)
		f.FactionDropDown:SetScript("OnShow", function(self)
			AccountantClassicFrameFactionDropDown_Setup()
		end)
	end

	f.CharacterDropDown = _G[parentName.."CharacterDropDown"]
	if not f.CharacterDropDown then
		f.CharacterDropDown = LibDD:Create_UIDropDownMenu(parentName.."CharacterDropDown", f)
		f.CharacterDropDown:Hide()
		f.CharacterDropDown:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -62)
		f.CharacterDropDown.Label = f.ServerDropDown:CreateFontString(parentName.."CharacterDropDownLabel", "BACKGROUND", "GameFontNormalSmall")
		f.CharacterDropDown.Label:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, 0)
		f.CharacterDropDown:SetScript("OnShow", function(self)
			AccountantClassicFrameCharacterDropDown_Setup()
		end)
	end
	--[[
	-- Rows
	for i = 1, 18, 1 do
		local name = parentName.."Row"..i
		local sf = _G[name]
		if (not sf) then 
			sf = CreateFrame("Frame", name, f, AccountantClassicRowTemplate) 
		end
		if i == 1 then
			sf:SetPoint("TOPLEFT", f, "TOPLEFT", 21, -113)
		else
			local j = i-1
			sf:SetPoint("TOPLEFT", _G[name.."Row"..j], "TOPLEFT", 0, -1)
		end
		f[name] = sf
	end]]
end

local function setLabels()
	local f = _G["AccountantClassicFrame"]
	-- if current tab is All Chars tab
	if (AC_CURRTAB == AC_TABS) then
		AccountantClassicFrameResetButton:Hide()

		f.Source:SetText(L["Character"])
		f.In:SetText(L["Money"])
		f.Out:SetText(L["Updated"])
		f.TotalIn:SetText(L["Total Incomings"]..":")
		f.TotalOut:SetText(L["Total Outgoings"]..":")
		f.TotalFlow:SetText(L["Sum Total"]..":")
		f.TotalInValue:SetText("")
		f.TotalOutValue:SetText("")
		f.TotalFlowValue:SetText("")
		for i = 1, 18, 1 do
			_G["AccountantClassicFrameRow"..i.."Title".."_Text"]:SetText("")
			_G["AccountantClassicFrameRow"..i.."In".."_Text"]:SetText("")
			_G["AccountantClassicFrameRow"..i.."Out".."_Text"]:SetText("")
			_G["AccountantClassicFrameRow"..i.."Title"].logType = ""
			_G["AccountantClassicFrameRow"..i.."In"].logType = ""
			_G["AccountantClassicFrameRow"..i.."Out"].logType = ""
		end
		return
	else
		AccountantClassicFrameResetButton:Show()

		f.Source:SetText(L["Source"])
		f.In:SetText(L["Incomings"])
		f.Out:SetText(L["Outgoings"])
		f.TotalIn:SetText(L["Total Incomings"]..":")
		f.TotalOut:SetText(L["Total Outgoings"]..":")
		f.TotalFlow:SetText(L["Net Profit / Loss"]..":")

		-- Row Labels (auto generate)
		local InPos = 1
		for key,value in pairs(AC_DATA) do
			local name = "AccountantClassicFrameRow"..InPos
			AC_DATA[key].InPos = InPos
			_G["AccountantClassicFrameRow"..InPos.."Title".."_Text"]:SetText(AC_DATA[key].Title)
			--f[name]Title.Text:SetText(AC_DATA[key].Title)
			InPos = InPos + 1
		end

		-- Set the header
		local name = f:GetName()
		local header = _G[name.."TitleText"]
		if ( header ) then
			header:SetText(L["Accountant Classic"])
		end
	end
end

local function settleTabText()
	local TabText = private.constants.tabText
	for i = 1, AC_TABS do
		_G["AccountantClassicFrameTab"..i]:SetText(TabText[i]);
		PanelTemplates_TabResize(_G["AccountantClassicFrameTab"..i], 25);
	end

	PanelTemplates_SetNumTabs(AccountantClassicFrame, AC_TABS);
	PanelTemplates_SetTab(AccountantClassicFrame, AccountantClassicFrameTab1);
	PanelTemplates_UpdateTabs(AccountantClassicFrame);
end

function addon:PopulateCharacterList(server, faction)
	local i = 1
	local serverkey, servervalue, charkey, charvalue

	-- Clean up AC_CHARSCROLL_LIST
	if (#AC_CHARSCROLL_LIST > 0) then
		AC_CHARSCROLL_LIST = {}
	end
	if (not server or server == "All") then
		for serverkey, servervalue in orderedpairs(Accountant_ClassicSaveData) do
			for charkey, charvalue in orderedpairs(Accountant_ClassicSaveData[serverkey]) do
				if (not faction or faction == "All") then
					AC_CHARSCROLL_LIST[i] = { serverkey, charkey }
					i = i + 1
				else
					if (charvalue.options.faction == faction) then
						AC_CHARSCROLL_LIST[i] = { serverkey, charkey }
						i = i + 1
					end
				end
			end
		end
	else
		serverkey = server or AC_SERVER
		for charkey, charvalue in orderedpairs(Accountant_ClassicSaveData[serverkey]) do
			if (not faction or faction == "All") then
				AC_CHARSCROLL_LIST[i] = { serverkey, charkey }
				i = i + 1
			else
				if (charvalue.options.faction == faction) then
					AC_CHARSCROLL_LIST[i] = { serverkey, charkey }
					i = i + 1
				end
			end
		end
	end
	AC_CURR_LINES = i - 1

	-- Create and align any new entry buttons that we need
	for i = 1, AC_CURR_LINES do
		if (not _G["AccountantClassicCharacterEntry"..i]) then
			local f = CreateFrame("Frame", "AccountantClassicCharacterEntry"..i, AccountantClassicFrame, "AccountantClassicRowTemplate")
			if i == 1 then
				f:SetPoint("TOPLEFT", "AccountantClassicScrollBar", "TOPLEFT", 0, 0)
			else
				f:SetPoint("TOPLEFT", "AccountantClassicCharacterEntry"..(i - 1), "BOTTOMLEFT", 0, -1)
			end
		end
	end
end


local function AccountantClassicFrameServerDropDown_OnClick(self)
	LibDD:UIDropDownMenu_SetSelectedValue(AccountantClassicFrameServerDropDown, self.value)
	AC_SELECTED_SERVER = self.value
	addon:PopulateCharacterList(AC_SELECTED_SERVER, AC_SELECTED_FACTION)
	AccountantClassic_OnShow()
end

local function AccountantClassicFrameServerDropDown_Init()
	local info
	local i = 1
	for k, v in orderedpairs(Accountant_ClassicSaveData) do
		info = LibDD:UIDropDownMenu_CreateInfo()
		info.text = k
		info.value = k
		info.func = AccountantClassicFrameServerDropDown_OnClick
		LibDD:UIDropDownMenu_AddButton(info)
		i = i + 1
	end
	
	-- Added All Chars to dropdown
	info = LibDD:UIDropDownMenu_CreateInfo()
	info.text = L["All Servers"]
	info.value = "All"
	info.tooltipTitle = L["Show all realms' characters info"]
	info.tooltipOnButton = true
	info.func = AccountantClassicFrameServerDropDown_OnClick
	LibDD:UIDropDownMenu_AddButton(info)
end

function AccountantClassicFrameServerDropDown_Setup()
	LibDD:UIDropDownMenu_Initialize(AccountantClassicFrameServerDropDown, AccountantClassicFrameServerDropDown_Init)
	
	if (profile.cross_server and not AC_SELECTED_SERVER) then
		AC_SELECTED_SERVER = "All"
		LibDD:UIDropDownMenu_SetSelectedValue(AccountantClassicFrameServerDropDown, "All")
	else
		LibDD:UIDropDownMenu_SetSelectedValue(AccountantClassicFrameServerDropDown, AC_SELECTED_SERVER or AC_SERVER)
	end
	LibDD:UIDropDownMenu_SetWidth(AccountantClassicFrameServerDropDown, 200)
end


local function AccountantClassicFrameFactionDropDown_OnClick(self)
	LibDD:UIDropDownMenu_SetSelectedValue(AccountantClassicFrameFactionDropDown, self.value)
	AC_SELECTED_FACTION = self.value
	addon:PopulateCharacterList(AC_SELECTED_SERVER, AC_SELECTED_FACTION)
	AccountantClassic_OnShow()
end

local function AccountantClassicFrameFactionDropDown_Init()
	local info
	info = LibDD:UIDropDownMenu_CreateInfo()
	info.icon = "Interface\\PVPFrame\\PVP-Currency-Alliance"
	info.text = FACTION_ALLIANCE
	info.colorCode = "|cff7babe0"
	info.value = "Alliance"
	info.arg1 = "Alliance"
	info.func = AccountantClassicFrameFactionDropDown_OnClick
	LibDD:UIDropDownMenu_AddButton(info)

	info = LibDD:UIDropDownMenu_CreateInfo()
	info.icon = "Interface\\PVPFrame\\PVP-Currency-Horde"
	info.text = FACTION_HORDE
	info.colorCode = "|cffda6955"
	info.value = "Horde"
	info.arg1 = "Horde"
	info.func = AccountantClassicFrameFactionDropDown_OnClick
	LibDD:UIDropDownMenu_AddButton(info)
	
	-- Added All Factions to dropdown
	info = LibDD:UIDropDownMenu_CreateInfo()
	info.text = L["All Factions"]
	info.value = "All"
	info.func = AccountantClassicFrameFactionDropDown_OnClick
	LibDD:UIDropDownMenu_AddButton(info)
end

function AccountantClassicFrameFactionDropDown_Setup()
	LibDD:UIDropDownMenu_Initialize(AccountantClassicFrameFactionDropDown, AccountantClassicFrameFactionDropDown_Init)
	if (profile.show_allFactions and not AC_SELECTED_FACTION) then
		AC_SELECTED_FACTION = "All"
		LibDD:UIDropDownMenu_SetSelectedValue(AccountantClassicFrameFactionDropDown, "All")
	else
		LibDD:UIDropDownMenu_SetSelectedValue(AccountantClassicFrameFactionDropDown, AC_SELECTED_FACTION or AC_FACTION)
	end
	LibDD:UIDropDownMenu_SetWidth(AccountantClassicFrameFactionDropDown, 200)
end


local function AccountantClassicFrameCharacterDropDown_OnClick(self)
	LibDD:UIDropDownMenu_SetSelectedID(AccountantClassicFrameCharacterDropDown, self:GetID())
	AC_SELECTED_CHAR_NUM = self.value
	profile.selectedCharacter = AC_SELECTED_CHAR_NUM
	AccountantClassic_OnShow()
end

local function AccountantClassicFrameCharacterDropDown_Init()
	local info
	for i = 1, #AC_CHARSCROLL_LIST do
		local serverkey = AC_CHARSCROLL_LIST[i][1]
		local charkey = AC_CHARSCROLL_LIST[i][2]
		info = LibDD:UIDropDownMenu_CreateInfo()
		local factionstr = Accountant_ClassicSaveData[serverkey][charkey]["options"].faction or nil
		info.icon = factionstr and "Interface\\PVPFrame\\PVP-Currency-"..factionstr or nil

		local class = Accountant_ClassicSaveData[serverkey][charkey]["options"].class
		info.colorCode = class and "|c"..RAID_CLASS_COLORS[class]["colorStr"] or nil

		info.text = serverkey.." - "..charkey
		info.value = i
		info.arg1 = serverkey
		info.arg2 = charkey
		info.func = AccountantClassicFrameCharacterDropDown_OnClick
		LibDD:UIDropDownMenu_AddButton(info)
	end
	
	-- Added All Chars to dropdown
	info = LibDD:UIDropDownMenu_CreateInfo()
	info.text = L["All Chars"]
	info.value = #AC_CHARSCROLL_LIST + 1
	info.tooltipTitle = L["Show all characters' incoming and outgoing data."]
	info.tooltipOnButton = true
	info.func = AccountantClassicFrameCharacterDropDown_OnClick
	LibDD:UIDropDownMenu_AddButton(info)
end

function AccountantClassicFrameCharacterDropDown_Setup()
	LibDD:UIDropDownMenu_Initialize(AccountantClassicFrameCharacterDropDown, AccountantClassicFrameCharacterDropDown_Init)
	if not profile.rememberSelectedCharacter or not AC_SELECTED_CHAR_NUM then
		for i = 1, #AC_CHARSCROLL_LIST do
			if (AC_SERVER == AC_CHARSCROLL_LIST[i][1] and AC_PLAYER == AC_CHARSCROLL_LIST[i][2]) then
				AC_SELECTED_CHAR_NUM = i;
			end
		end
	end
	if (profile.rememberSelectedCharacter) then
		LibDD:UIDropDownMenu_SetSelectedValue(AccountantClassicFrameCharacterDropDown, profile.selectedCharacter or AC_SELECTED_CHAR_NUM or 1)
	else
		LibDD:UIDropDownMenu_SetSelectedValue(AccountantClassicFrameCharacterDropDown, AC_SELECTED_CHAR_NUM or 1)
	end
	LibDD:UIDropDownMenu_SetWidth(AccountantClassicFrameCharacterDropDown, 200)
end


local function AccountantClassic_LogsShifting()
	-- Since we now (2016/12/17) supported to show specifc character or all characters' incoming / 
	--   outgoing data in each logmode, we have to deal with the date / week / month's shifting for all
	--   characters, not just the current one.
	-- This should be check while addon loaded, and while logs updating, 
	--   or while Accountant Classic frame is opened
	local cdate = date("%d/%m/%y");
	local cmonth = date("%m");
	local cyear = date("%Y");
	local serverkey, servervalue, charkey, charvalue;
	for serverkey, servervalue in pairs(Accountant_ClassicSaveData) do
		for charkey, charvalue in pairs(Accountant_ClassicSaveData[serverkey]) do
			-- we need lastsessiondate, codes should not be necessary once every player's all characters have this option value being set
			if (Accountant_ClassicSaveData[serverkey][charkey]["options"].lastsessiondate == nil) then
				Accountant_ClassicSaveData[serverkey][charkey]["options"].lastsessiondate = Accountant_ClassicSaveData[serverkey][charkey]["options"]["date"];
			end
			-- Check to see if the day has rolled over
			if (Accountant_ClassicSaveData[serverkey][charkey]["options"]["date"] ~= cdate) then
				-- It's a new day! clear out the day tab
				Accountant_ClassicSaveData[serverkey][charkey]["options"]["prvday"] = Accountant_ClassicSaveData[serverkey][charkey]["options"]["date"];
				for mode, value in pairs(Accountant_ClassicSaveData[serverkey][charkey]["data"]) do
					if (not Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvDay"]) then
						Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvDay"] = { In = 0, Out = 0 };
					end
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvDay"].In = Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Day"].In;
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvDay"].Out = Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Day"].Out;
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Day"].In = 0;
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Day"].Out = 0;
				end
				if (serverkey == AC_SERVER and charkey == AC_PLAYER) then
					for mode, value in pairs(AC_DATA) do
						AC_DATA[mode]["PrvDay"].In = AC_DATA[mode]["Day"].In;
						AC_DATA[mode]["PrvDay"].Out = AC_DATA[mode]["Day"].Out;
						AC_DATA[mode]["Day"].In = 0;
						AC_DATA[mode]["Day"].Out = 0;
					end
				end
				-- ZoneDB handling
				-- drop out old PrvDay's data and reset it
				if (Accountant_ClassicZoneDB[serverkey] and Accountant_ClassicZoneDB[serverkey][charkey] and Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Day"]) then
					Accountant_ClassicZoneDB[serverkey][charkey]["data"]["PrvDay"] = { };
					for kt, vt in pairs(Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Day"]) do
						Accountant_ClassicZoneDB[serverkey][charkey]["data"]["PrvDay"][kt] = vt;
					end
					-- then we need a fresh "Day"
					Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Day"] = { };
					for k_logtype, v_logtype in pairs(private.constants.logtypes) do
						Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Day"][v_logtype] = { };
					end
				end

				Accountant_ClassicSaveData[serverkey][charkey]["options"]["date"] = cdate;
			end

			-- Check to see if the week has rolled over
			if (Accountant_ClassicSaveData[serverkey][charkey]["options"]["dateweek"] ~= addon:WeekStart()) then
				-- It's a new week! clear out the week tab
				Accountant_ClassicSaveData[serverkey][charkey]["options"]["prvdateweek"] = Accountant_ClassicSaveData[serverkey][charkey]["options"]["dateweek"];
				for mode, value in pairs(Accountant_ClassicSaveData[serverkey][charkey]["data"]) do
					if (not Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Week"]) then
						Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Week"] = { In = 0, Out = 0 };
					end
					if (not Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvWeek"]) then
						Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvWeek"] = { In = 0, Out = 0 };
					end
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvWeek"].In = Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Week"].In;
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvWeek"].Out = Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Week"].Out;
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Week"].In = 0;
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Week"].Out = 0;
				end
				if (serverkey == AC_SERVER and charkey == AC_PLAYER) then
					for mode, value in pairs(AC_DATA) do
						AC_DATA[mode]["PrvWeek"].In = AC_DATA[mode]["Week"].In;
						AC_DATA[mode]["PrvWeek"].Out = AC_DATA[mode]["Week"].Out;
						AC_DATA[mode]["Week"].In = 0;
						AC_DATA[mode]["Week"].Out = 0;
					end
				end
				-- ZoneDB handling
				-- drop out old PrvDay's data and reset it
				if (Accountant_ClassicZoneDB[serverkey] and Accountant_ClassicZoneDB[serverkey][charkey] and Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Week"]) then
					Accountant_ClassicZoneDB[serverkey][charkey]["data"]["PrvWeek"] = { };
					for kt, vt in pairs(Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Week"]) do
						Accountant_ClassicZoneDB[serverkey][charkey]["data"]["PrvWeek"][kt] = vt;
					end
					-- then we need a fresh "Week"
					Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Week"] = { };
					for k_logtype, v_logtype in pairs(private.constants.logtypes) do
						Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Week"][v_logtype] = { };
					end
				end

				Accountant_ClassicSaveData[serverkey][charkey]["options"]["dateweek"] = addon:WeekStart();
			end

			-- Check to see if the month has rolled over
			if (Accountant_ClassicSaveData[serverkey][charkey]["options"]["month"] ~= cmonth) then
				-- It's a new month! clear out the month tab
				Accountant_ClassicSaveData[serverkey][charkey]["options"]["prvmonth"] = Accountant_ClassicSaveData[serverkey][charkey]["options"]["month"];
				for mode, value in pairs(Accountant_ClassicSaveData[serverkey][charkey]["data"]) do
					if (not Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Month"]) then 
						Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Month"] = { In = 0, Out = 0};
					end
					if (not Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvMonth"]) then 
						Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvMonth"] = { In = 0, Out = 0};
					end
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvMonth"].In = Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Month"].In;
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvMonth"].Out = Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Month"].Out;
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Month"].In = 0;
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Month"].Out = 0;
				end
				if (serverkey == AC_SERVER and charkey == AC_PLAYER) then
					for mode, value in pairs(AC_DATA) do
						AC_DATA[mode]["PrvMonth"].In = AC_DATA[mode]["Month"].In;
						AC_DATA[mode]["PrvMonth"].Out = AC_DATA[mode]["Month"].Out;
						AC_DATA[mode]["Month"].In = 0;
						AC_DATA[mode]["Month"].Out = 0;
					end
				end
				if (Accountant_ClassicZoneDB[serverkey] and Accountant_ClassicZoneDB[serverkey][charkey] and Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Month"]) then
					-- ZoneDB handling
					-- drop out old PrvDay's data and reset it
					Accountant_ClassicZoneDB[serverkey][charkey]["data"]["PrvMonth"] = { };
					for kt, vt in pairs(Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Month"]) do
						Accountant_ClassicZoneDB[serverkey][charkey]["data"]["PrvMonth"][kt] = vt;
					end
					-- then we need a fresh "Month"
					Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Month"] = { };
					for k_logtype, v_logtype in pairs(private.constants.logtypes) do
						Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Month"][v_logtype] = { };
					end
				end

				Accountant_ClassicSaveData[serverkey][charkey]["options"]["month"] = cmonth;
			end

			-- Check to see if the year has rolled over
			if (Accountant_ClassicSaveData[serverkey][charkey]["options"]["curryear"] ~= cyear) then
				-- It's a new year! clear out the year tab
				Accountant_ClassicSaveData[serverkey][charkey]["options"]["prvyear"] = Accountant_ClassicSaveData[serverkey][charkey]["options"]["curryear"];
				for mode, value in pairs(Accountant_ClassicSaveData[serverkey][charkey]["data"]) do
					if (not Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Year"]) then 
						Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Year"] = { In = 0, Out = 0};
					end
					if (not Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvYear"]) then 
						Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvYear"] = { In = 0, Out = 0};
					end
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvYear"].In = Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Year"].In;
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["PrvYear"].Out = Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Year"].Out;
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Year"].In = 0;
					Accountant_ClassicSaveData[serverkey][charkey]["data"][mode]["Year"].Out = 0;
				end
				if (serverkey == AC_SERVER and charkey == AC_PLAYER) then
					for mode, value in pairs(AC_DATA) do
						AC_DATA[mode]["PrvYear"].In = AC_DATA[mode]["Year"].In;
						AC_DATA[mode]["PrvYear"].Out = AC_DATA[mode]["Year"].Out;
						AC_DATA[mode]["Year"].In = 0;
						AC_DATA[mode]["Year"].Out = 0;
					end
				end
				if (Accountant_ClassicZoneDB[serverkey] and Accountant_ClassicZoneDB[serverkey][charkey] and Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Year"]) then
					-- ZoneDB handling
					-- drop out old PrvDay's data and reset it
					Accountant_ClassicZoneDB[serverkey][charkey]["data"]["PrvYear"] = { };
					for kt, vt in pairs(Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Year"]) do
						Accountant_ClassicZoneDB[serverkey][charkey]["data"]["PrvYear"][kt] = vt;
					end
					-- then we need a fresh "Year"
					Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Year"] = { };
					for k_logtype, v_logtype in pairs(private.constants.logtypes) do
						Accountant_ClassicZoneDB[serverkey][charkey]["data"]["Year"][v_logtype] = { };
					end
				end

				Accountant_ClassicSaveData[serverkey][charkey]["options"]["curryear"] = cyear;
			end
		end
	end
end

local function loadData()
	local cdate = date("%d/%m/%y");
	for key, value in pairs(AC_DATA) do
		for modekey,mode in pairs(private.constants.logmodes) do
			AC_DATA[key][mode] = {In=0,Out=0};
		end
	end

	order = 1;
	for key, value in pairs(AC_DATA) do
		if (AccountantClassic_Profile["data"][key] == nil) then
			AccountantClassic_Profile["data"][key] = { };
		end
		if (AC_NewDB) then
			if (Accountant_Classic_NewDB[AC_SERVER][AC_PLAYER]["data"][cdate][key] == nil) then
				Accountant_Classic_NewDB[AC_SERVER][AC_PLAYER]["data"][cdate][key] = {
					In = 0;
					Out = 0;
				};
			end
		end
		for modekey,mode in pairs(private.constants.logmodes) do
			if (AccountantClassic_Profile["data"][key][mode] == nil or mode == "Session") then
				AccountantClassic_Profile["data"][key][mode] = {In=0, Out=0};
			end
			AC_DATA[key][mode].In  = AccountantClassic_Profile["data"][key][mode].In;
			AC_DATA[key][mode].Out = AccountantClassic_Profile["data"][key][mode].Out;
		end
		-- Here we reset session data
		-- AC_DATA[key]["Session"].In = 0;
		-- AC_DATA[key]["Session"].Out = 0;

--[[
		-- Old Version Conversion
		if (AccountantClassic_Profile["data"][key].TotalIn ~= nil) then
			AccountantClassic_Profile["data"][key]["Total"].In = AccountantClassic_Profile["data"][key].TotalIn;
			AC_DATA[key]["Total"].In = AccountantClassic_Profile["data"][key].TotalIn;
			AccountantClassic_Profile["data"][key].TotalIn = nil;
		end
		if (AccountantClassic_Profile["data"][key].TotalOut ~= nil) then
			AccountantClassic_Profile["data"][key]["Total"].Out = AccountantClassic_Profile["data"][key].TotalOut;
			AC_DATA[key]["Total"].Out = AccountantClassic_Profile["data"][key].TotalOut;
			AccountantClassic_Profile["data"][key].TotalOut = nil;
		end
		if (Accountant_SaveData[key] ~= nil) then
			Accountant_SaveData[key] = nil;
		end
		-- End OVC
]]
		AC_DATA[key].order = order;
		order = order + 1;
	end
	
	-- ZoneDB handling
	-- Reset session DB
	Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"]["Session"] = { };
	for k_logtype, v_logtype in pairs(private.constants.logtypes) do
		Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"]["Session"][v_logtype] = { };
	end
	
	AccountantClassic_Profile["options"].version = AccountantClassic_Version;
	-- Here we retrieve the last session money before we set the option-value to the current one
	AC_LASTSESSMONEY = AccountantClassic_Profile["options"].totalcash;
	AccountantClassic_Profile["options"].totalcash = GetMoney();

	AccountantClassic_LogsShifting();
	
	AccountantClassic_Profile["options"].lastsessiondate = cdate;
end

local function updateLog()
	-- if it's first time loaded this addon, then we don't need to update logs.
	if AC_FIRSTLOADED then
		return
	end

	local cdate = date("%d/%m/%y");
	--local cmonth = date("%m");
	--local cyear = date("%Y");

	AccountantClassic_LogsShifting();

	local zoneText = GetZoneText();
	if ( not IsInInstance() ) then -- For the case when player is in dungeon or raid, track on subzone make less sense
		if (profile.tracksubzone == true and GetSubZoneText() ~= "" ) then
			zoneText = format("%s - %s", GetZoneText(), GetSubZoneText());
		end
	end
	
	-- calculating diff money
	AC_CURRMONEY = GetMoney()
	AccountantClassic_Profile["options"].totalcash = AC_CURRMONEY
	diff = AC_CURRMONEY - AC_LASTMONEY
	AC_LASTMONEY = AC_CURRMONEY
	if (diff == 0 or diff == nil) then
		return
	end

	local logtype = AC_LOGTYPE;
	if (logtype == "") then logtype = "OTHER"; end
	if (diff >0) then
		for key,logmode in pairs(private.constants.logmodes) do
			if (logmode == "PrvWeek" or logmode == "PrvMonth" or logmode == "PrvDay" or logmode == "PrvYear") then
				-- do nothing. data in previous time period should not be touched
			else
				AC_DATA[logtype][logmode].In = AC_DATA[logtype][logmode].In + diff
				AccountantClassic_Profile["data"][logtype][logmode].In = AC_DATA[logtype][logmode].In;
				if (AC_NewDB) then
					if (logmode == "Day") then
						Accountant_Classic_NewDB[AC_SERVER][AC_PLAYER]["data"][cdate][logtype].In = AC_DATA[logtype][logmode].In;
					end
				end
				-- ZoneDB
				if (profile.trackzone == true) then
					if (Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"][logmode][logtype][zoneText] == nil) then
						Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"][logmode][logtype][zoneText] = { In = 0, Out = 0 };
					end
					Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"][logmode][logtype][zoneText].In = Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"][logmode][logtype][zoneText].In + diff;
				end
			end
		end
		if AccountantClassic_Verbose then ACC_Print("Gained "..AccountantClassic_NiceCash(diff).." from "..logtype); end
	elseif (diff < 0) then
		diff = diff * -1;
		for key,logmode in pairs(private.constants.logmodes) do
			if (logmode == "PrvWeek" or logmode == "PrvMonth" or logmode == "PrvDay" or logmode == "PrvYear") then
				-- do nothing
			else
				AC_DATA[logtype][logmode].Out = AC_DATA[logtype][logmode].Out + diff
				AccountantClassic_Profile["data"][logtype][logmode].Out = AC_DATA[logtype][logmode].Out;
				if (AC_NewDB) then
					if (logmode == "Day") then
						Accountant_Classic_NewDB[AC_SERVER][AC_PLAYER]["data"][cdate][logtype].Out = AC_DATA[logtype][logmode].Out;
					end
				end
				-- ZoneDB
				if (profile.trackzone == true) then
					if (Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"][logmode][logtype][zoneText] == nil) then
						Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"][logmode][logtype][zoneText] = { In = 0, Out = 0 };
					end
					Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"][logmode][logtype][zoneText].Out = Accountant_ClassicZoneDB[AC_SERVER][AC_PLAYER]["data"][logmode][logtype][zoneText].Out + diff;
				end
			end
		end
		if AccountantClassic_Verbose then ACC_Print("Lost "..AccountantClassic_NiceCash(diff).." from "..logtype); end
	end

	-- special case mode resets
	if AC_LOGTYPE == "REPAIRS" then
		AC_LOGTYPE = "MERCH";
	end

	if AccountantClassicFrame:IsVisible() then
		AccountantClassic_OnShow();
	end
end

function Accountant_Slash(msg)
	if msg == nil or msg == "" then
		msg = "log"
	end
	local args = {n=0}
	local function helper(word) tinsert(args, word) end
	gsub(msg, "[_%w]+", helper)
	if args[1] == 'log'  then
		ShowUIPanel(AccountantClassicFrame)
	elseif args[1] == 'verbose' then
		if AccountantClassic_Verbose == nil then
			AccountantClassic_Verbose = 1
			ACC_Print("Verbose Mode On")
		else
			AccountantClassic_Verbose = nil;
			ACC_Print("Verbose Mode Off")
		end
	elseif args[1] == 'week' then
		ACC_Print(addon:WeekStart())
	else
		ACC_Print("/accountant log\n")
	end
end

-- codes by Tntdruid
local function AccountantClassic_DetectAhMail()
	local numItems, totalItems = GetInboxNumItems();
	for x = 1, totalItems do    
		-- invoiceType, itemName, playerName, bid, buyout, deposit, consignment = GetInboxInvoiceInfo(index);
		--    invoiceType : String - type of invoice ("buyer", "seller", or "seller_temp_invoice").
		local invoiceType = GetInboxInvoiceInfo(x);
		if (invoiceType == "seller") then
			return true;
		end
	end
end

local function AccountantClassic_OnShareMoney(arg1)
	local oldType = AC_LOGTYPE;
	if (oldType == "LOOT") then
		return;
	end

	local gold, silver, copper, money;

	-- Parse the message for money gained.
	_, _, gold = strfind(arg1, L["(%d+) Gold"])
	_, _, silver = strfind(arg1, L["(%d+) Silver"])
	_, _, copper = strfind(arg1, L["(%d+) Copper"])
	if (gold) then
		gold = tonumber(gold);
	else
		gold = 0;
	end
	if (silver) then
		silver = tonumber(silver);
	else
		silver = 0;
	end
	if (copper) then
		copper = tonumber(copper);
	else
		copper = 0;
	end

	money = copper + silver * 100 + gold * 10000

	if (not AC_LASTMONEY) then
		AC_LASTMONEY = 0;
	end

-- This will force a money update with calculated amount.
	AC_LASTMONEY = AC_LASTMONEY - money;
	AC_LOGTYPE = "LOOT";
	updateLog();
	AC_LOGTYPE = oldType;

-- This will suppress the incoming PLAYER_MONEY event.
	AC_LASTMONEY = AC_LASTMONEY + money;

end

local function AccountantClassic_NiceCash(amount)
	local agold = 10000;
	local asilver = 100;
	local outstr = "";
	local gold = 0;
	local silver = 0;
	local cent = 0;

	if amount >= agold then
		gold = floor(amount / agold);
		outstr = "|cFFFFFF00" .. gold .. L["g "];
	end
	amount = amount - (gold * agold);
	if amount >= asilver then
		silver = floor(amount / asilver);
		if silver < 10 then
			silver = " "..silver;
		end
		outstr = outstr .. "|cFFDDDDDD" .. silver .. L["s "];
	end
	amount = amount - (silver * asilver);
	if amount > 0 then
		cent = amount;
		if cent < 10 then
			cent = " "..cent;
		end
		outstr = outstr .. "|cFFFF6600" .. cent .. L["c"];
	end
	outstr = outstr.."|r";
	return outstr;
end

-- code adopted from SellTrash and MoneyFrame.lua
function addon:GetFormattedValue(amount)
	local gold = floor(amount / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local goldDisplay = profile.breakupnumbers and BreakUpLargeNumbers(gold) or gold;
	local silver = floor((amount - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = fmod(amount, COPPER_PER_SILVER);
	
	local TMP_GOLD_AMOUNT_TEXTURE = "%s|TInterface\\MoneyFrame\\UI-GoldIcon:%d:%d:2:0|t";
	local TMP_SILVER_AMOUNT_TEXTURE = "%02d|TInterface\\MoneyFrame\\UI-SilverIcon:%d:%d:2:0|t";
	local TMP_COPPER_AMOUNT_TEXTURE = "%02d|TInterface\\MoneyFrame\\UI-CopperIcon:%d:%d:2:0|t";
	if (gold >0) then
		return format(TMP_GOLD_AMOUNT_TEXTURE.." "..TMP_SILVER_AMOUNT_TEXTURE.." "..TMP_COPPER_AMOUNT_TEXTURE, goldDisplay, 0, 0, silver, 0, 0, copper, 0, 0);
	elseif (silver >0) then 
		return format(SILVER_AMOUNT_TEXTURE.." "..TMP_COPPER_AMOUNT_TEXTURE, silver, 0, 0, copper, 0, 0);
	elseif (copper >0) then
		return format(COPPER_AMOUNT_TEXTURE, copper, 0, 0);
	else
		return "";
	end
end

local function AccountantClassic_GetFormattedCurrency(currencyID)
	local name, amount, icon
	if WoWClassic then
		name, amount, icon = GetCurrencyInfo(currencyID)
	else
		local info = GetCurrencyInfo(currencyID)
		name = info.name
		amount = info.quantity
		icon = info.iconFileID
	end
	
	if (amount >0) then
		local CURRENCY_TEXTURE = "%s|T"..icon..":%d:%d:2:0|t";
		amount = profile.breakupnumbers and BreakUpLargeNumbers(amount) or amount;
		return format(CURRENCY_TEXTURE.." ", amount, 0, 0);
	else
		return "";
	end
end

function addon:WeekStart()
	local oneday = 86400;
	local ct = time();
	local dt = date("*t",ct);
	local thisDay = dt["wday"];
	--while thisDay ~= AccountantClassic_Profile["options"].weekstart do
	while thisDay ~= addon.db.profile.weekstart do
		ct = ct - oneday;
		dt = date("*t",ct);
		thisDay = dt["wday"];
	end
	local wdate = date("%m/%d/%y",ct);
	return strsub(wdate,0,8);
end

local function parseDateStrings(s, typ)
	local mm, dd, yy;
	local sdate = s;
	
	if (typ == 1) then -- mm/dd/yy, currently used in dateweek (WeekStart)
		mm = strsub(sdate, 1, 2);
		dd = strsub(sdate, 4, 5);
	else
		dd = strsub(sdate, 1, 2);
		mm = strsub(sdate, 4, 5);
	end
	yy = strsub(sdate, 7, 8);

--[[ /////////////////////////
	[1] = "mm/dd/yy";
	[2] = "dd/mm/yy";
	[3] = "yy/mm/dd";
]]
	if (profile.dateformat == 1) then
		sdate = mm.."/"..dd.."/"..yy;
	elseif (profile.dateformat == 2) then
		sdate = dd.."/"..mm.."/"..yy;
	else
		sdate = yy.."/"..mm.."/"..dd;
	end
	
	return sdate;
end

function AccountantClassicScrollBar_Update()
	local lineplusoffset
	FauxScrollFrame_Update(AccountantClassicScrollBar, AC_CURR_LINES, AC_CHAR_LINES, 19)
	for i = 1, AC_CHAR_LINES do
		local f = _G["AccountantClassicCharacterEntry"..i]
		lineplusoffset = i + FauxScrollFrame_GetOffset(AccountantClassicScrollBar)
		if (lineplusoffset <= AC_CURR_LINES) then
			local player_text, factionstr, faction_icon, classToken, class_color
			local serverkey = AC_CHARSCROLL_LIST[lineplusoffset][1]
			local charkey = AC_CHARSCROLL_LIST[lineplusoffset][2]

			factionstr = Accountant_ClassicSaveData[serverkey][charkey]["options"].faction or nil
			faction_icon = factionstr and "|TInterface\\PVPFrame\\PVP-Currency-"..factionstr..":0:0|t%s - %s" or "%s - %s"

			classToken = Accountant_ClassicSaveData[serverkey][charkey]["options"].class or nil
			class_color = classToken and "|c"..RAID_CLASS_COLORS[classToken]["colorStr"] or ""

			if(classToken) then 
				f.Title.Text:SetText(format(class_color..faction_icon.."|r", serverkey, charkey))
			else
				f.Title.Text:SetText(format(faction_icon, serverkey, charkey))
			end

			if Accountant_ClassicSaveData[serverkey][charkey]["options"]["totalcash"] ~= nil then
				f.In.Text:SetText("|cFFFFFFFF"..addon:GetFormattedValue(Accountant_ClassicSaveData[serverkey][charkey]["options"]["totalcash"]))
				f.Out.Text:SetText(parseDateStrings(Accountant_ClassicSaveData[serverkey][charkey]["options"]["lastsessiondate"], 2))
			else
				f.In.Text:SetText("Unknown")
			end
			f:Show()
		elseif (f) then
			f:Hide()
		end
	end
end

function AccountantClassic_OnEvent(self, event, ...)
	local arg1, arg2 = ...;
	local oldType = AC_LOGTYPE;

	if ( 
	event == "GARRISON_MISSION_FINISHED" or 
	event == "GARRISON_UPDATE" or
	event == "GARRISON_ARCHITECT_OPENED" or
	event == "GARRISON_MISSION_NPC_OPENED" or
	event == "GARRISON_SHIPYARD_NPC_OPENED"
	) then
		AC_LOGTYPE = "GARRISON";
	elseif ( 
	event == "GARRISON_ARCHITECT_CLOSED" or
	event == "GARRISON_MISSION_NPC_CLOSED" or
	event == "GARRISON_SHIPYARD_NPC_CLOSED" or
	event == "BARBER_SHOP_APPEARANCE_APPLIED" or
	event == "BARBER_SHOP_CLOSE" or
	event == "TRANSMOGRIFY_CLOSE" or
	event == "VOID_STORAGE_CLOSE" or
	event == "MERCHANT_CLOSED" or
	event == "TRADE_CLOSED" or
	event == "TRAINER_CLOSED" or
	event == "AUCTION_HOUSE_CLOSED"
	) then
		AC_LOGTYPE = "";
	elseif (
	event == "GUILDBANKFRAME_OPENED" or 
	event == "GUILDBANK_UPDATE_MONEY" or 
	event == "GUILDBANK_UPDATE_WITHDRAWMONEY"
	) then
		AC_LOGTYPE = "GUILD";
	elseif event == "GUILDBANKFRAME_CLOSED" then
		AC_LOGTYPE = "";
	elseif event == "LFG_COMPLETION_REWARD" then
		AC_LOGTYPE = "LFG";
	elseif (
	event == "BARBER_SHOP_OPEN" or 
	event == "BARBER_SHOP_SUCCESS" or
	event == "BARBER_SHOP_RESULT" or 
	event == "BARBER_SHOP_FORCE_CUSTOMIZATIONS_UPDATE" or 
	event == "BARBER_SHOP_COST_UPDATE"
	) then
		AC_LOGTYPE = "BARBER";
	elseif event == "TRANSMOGRIFY_OPEN" then
		AC_LOGTYPE = "TRANSMO";
	elseif event == "VOID_STORAGE_OPEN" then
		AC_LOGTYPE = "VOID";
	elseif event == "MERCHANT_SHOW" then
		AC_LOGTYPE = "MERCH";
	elseif event == "MERCHANT_UPDATE" then
		if (InRepairMode() == true) then
			AC_LOGTYPE = "REPAIRS";
		end
	elseif event == "TAXIMAP_OPENED" then
		AC_LOGTYPE = "TAXI";
	elseif event == "TAXIMAP_CLOSED" then
		-- Commented out due to taximap closing before money transaction
		-- AC_LOGTYPE = "";
	elseif event == "LOOT_OPENED" then
		AC_LOGTYPE = "LOOT";
	elseif event == "LOOT_CLOSED" then
		-- Commented out due to loot window closing before money transaction
		-- AC_LOGTYPE = "";
	elseif event == "TRADE_SHOW" then
		AC_LOGTYPE = "TRADE";
	elseif event == "QUEST_COMPLETE" then
		AC_LOGTYPE = "QUEST";
	elseif event == "QUEST_TURNED_IN" then
		AC_LOGTYPE = "QUEST";
	elseif event == "QUEST_FINISHED" then
		-- Commented out due to quest window closing before money transaction
		-- AC_LOGTYPE = "";	
	elseif event == "MAIL_INBOX_UPDATE" then
		if AccountantClassic_DetectAhMail() then
			AC_LOGTYPE = "AH"
		else
			AC_LOGTYPE = "MAIL"
		end
	elseif event == "CONFIRM_TALENT_WIPE" then
		AC_LOGTYPE = "TRAIN";
	elseif event == "TRAINER_SHOW" then
		AC_LOGTYPE = "TRAIN";
	elseif event == "AUCTION_HOUSE_SHOW" then
		AC_LOGTYPE = "AH";
	-- This event is supposed to be fired before PLAYER_MONEY.
	elseif event == "CHAT_MSG_MONEY" then
		AccountantClassic_OnShareMoney(arg1);
	elseif event == "PLAYER_MONEY" then
		updateLog();
	end

	if AccountantClassic_Verbose and AC_LOGTYPE ~= oldType then ACC_Print("Accountant mode changed to '"..AC_LOGTYPE.."'"); end
	
	if (Accountant_ClassicSaveData) then
		LDB.text = addon:ShowNetMoney(private.constants.ldbDisplayTypes[profile.ldbDisplayType])
	end
end

function AccountantClassic_OnShow(self)
	createACFrames()
	local cdate = date("%d/%m/%y")
	local cmonth = date("%m")
	local cyear = date("%Y")
	local fs = _G["AccountantClassicFrameExtra"]
	local fsv = _G["AccountantClassicFrameExtraValue"]
	local prvday, prvdateweek, prvmonth
	
	AccountantClassic_LogsShifting()
	setLabels()
	if ( AC_CURRTAB ~= AC_TABS ) then
		-- for all the tabs except for character tab
		addon:PopulateCharacterList()
		AccountantClassicFrameServerDropDown:Hide()
		AccountantClassicFrameFactionDropDown:Hide()
		AccountantClassicScrollBar:Hide()
		for i = 1, AC_CURR_LINES do
			if (_G["AccountantClassicCharacterEntry"..i]) then
				_G["AccountantClassicCharacterEntry"..i]:Hide()
			end
		end
		if (AC_CURRTAB == TableIndex(private.constants.logmodes, "Session")) then
			AccountantClassicFrameCharacterDropDown:Hide()
		else
			AccountantClassicFrameCharacterDropDown:Show()
		end

		local TotalIn = 0
		local TotalOut = 0
		local mode = private.constants.logmodes[AC_CURRTAB]
		local colIn, colOut
		for key, value in pairs(AC_DATA) do
			colIn = _G["AccountantClassicFrameRow"..AC_DATA[key].InPos.."In"]
			colOut = _G["AccountantClassicFrameRow"..AC_DATA[key].InPos.."Out"]
			
			colIn.logType = key
			colOut.logType = key
			colIn.cashflow = "In"
			colOut.cashflow = "Out"

			local mIn = 0
			local mOut = 0
			if (AC_CURRTAB == TableIndex(private.constants.logmodes, "Session")) then
				mIn = AC_DATA[key][mode].In
				mOut = AC_DATA[key][mode].Out
			else
				if (AC_SELECTED_CHAR_NUM <= #AC_CHARSCROLL_LIST) then
					local j = AC_SELECTED_CHAR_NUM
					local serverkey = AC_CHARSCROLL_LIST[j][1]
					local charkey = AC_CHARSCROLL_LIST[j][2]
					prvdateweek = Accountant_ClassicSaveData[serverkey][charkey]["options"].prvdateweek or nil
					prvday = Accountant_ClassicSaveData[serverkey][charkey]["options"].prvday or nil
					prvmonth = Accountant_ClassicSaveData[serverkey][charkey]["options"].prvmonth or nil
					
					if (Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode] and Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode]["In"]) then
						mIn = Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode]["In"]
					end
					if (Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode] and Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode]["Out"]) then
						mOut = Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode]["Out"]
					end
				elseif (AC_SELECTED_CHAR_NUM == #AC_CHARSCROLL_LIST + 1) then
					local serverkey, servervalue, charkey, charvalue
					if (profile.cross_server) then
						for serverkey, servervalue in pairs(Accountant_ClassicSaveData) do
							for charkey, charvalue in pairs(Accountant_ClassicSaveData[serverkey]) do
								if (Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode] and Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode]["In"]) then
									mIn = mIn + Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode]["In"]
								end
								if (Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode] and Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode]["Out"]) then
									mOut = mOut + Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode]["Out"]
								end
							end
						end
					else
						serverkey = AC_SERVER
						for charkey, charvalue in pairs(Accountant_ClassicSaveData[serverkey]) do
							if (Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode] and Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode]["In"]) then
								mIn = mIn + Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode]["In"]
							end
							if (Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode] and Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode]["Out"]) then
								mOut = mOut + Accountant_ClassicSaveData[serverkey][charkey]["data"][key][mode]["Out"]
							end
						end
					end
				end
			end

			TotalIn = TotalIn + mIn
			TotalOut = TotalOut + mOut

			colIn.Text:SetText(addon:GetFormattedValue(mIn))
			colOut.Text:SetText(addon:GetFormattedValue(mOut))
		end
		AccountantClassicFrame.TotalInValue:SetText("|cFFFFFFFF"..addon:GetFormattedValue(TotalIn))
		AccountantClassicFrame.TotalOutValue:SetText("|cFFFFFFFF"..addon:GetFormattedValue(TotalOut))
		if (TotalOut > TotalIn) then
			diff = TotalOut - TotalIn
			AccountantClassicFrame.TotalFlow:SetText("|cFFFF3333"..L["Net Loss"]..":")
			AccountantClassicFrame.TotalFlowValue:SetText("|cFFFF3333"..addon:GetFormattedValue(diff))
		else
			if (TotalOut ~= TotalIn) then
				diff = TotalIn - TotalOut
				AccountantClassicFrame.TotalFlow:SetText("|cFF00FF00"..L["Net Profit"]..":")
				AccountantClassicFrame.TotalFlowValue:SetText("|cFF00FF00"..addon:GetFormattedValue(diff))
			else
				AccountantClassicFrame.TotalFlow:SetText(L["Net Profit / Loss"]..":")
				AccountantClassicFrame.TotalFlowValue:SetText("")
			end
		end
		-- Set row 18 to be empty so that the total row from all characters will be clean out
		_G["AccountantClassicFrameRow18Title"].Text:SetText("")
		_G["AccountantClassicFrameRow18In"].Text:SetText("")

		-- Extra info
		if (AC_CURRTAB == TableIndex(private.constants.logmodes, "Week")) then
			fs:SetText(L["Week Start"]..":")
			fsv:SetText(parseDateStrings(AccountantClassic_Profile["options"]["dateweek"], 1))
		elseif (AC_CURRTAB == TableIndex(private.constants.logmodes, "PrvWeek")) then
			if (prvdateweek) then
				fs:SetText(L["Week Start"]..":")
				fsv:SetText(parseDateStrings(AccountantClassic_Profile["options"]["prvdateweek"], 1))
			else
				fs:SetText("")
				fsv:SetText("")
			end
		elseif (AC_CURRTAB == TableIndex(private.constants.logmodes, "Month")) then
			local m = tonumber(AccountantClassic_Profile["options"]["month"])
			fs:SetText("")
			fsv:SetText(AC_MONTHS[m])
		elseif (AC_CURRTAB == TableIndex(private.constants.logmodes, "PrvMonth")) then
			if (prvmonth) then
				local m = tonumber(prvmonth)
				fs:SetText("")
				fsv:SetText(AC_MONTHS[m])
			else
				fs:SetText("")
				fsv:SetText("")
			end
		elseif (AC_CURRTAB == TableIndex(private.constants.logmodes, "Day")) then
			fs:SetText("")
			fsv:SetText(parseDateStrings(cdate, 2))
		elseif (AC_CURRTAB == TableIndex(private.constants.logmodes, "PrvDay")) then
			if (prvday) then
				fs:SetText("")
				fsv:SetText(parseDateStrings(prvday, 2))
			else
				fs:SetText("")
				fsv:SetText("")
			end
		elseif (AC_CURRTAB == TableIndex(private.constants.logmodes, "Year")) then
			fs:SetText("")
			fsv:SetText(AccountantClassic_Profile["options"]["curryear"])
		elseif (AC_CURRTAB == TableIndex(private.constants.logmodes, "PrvYear")) then
			fs:SetText("")
			if (AccountantClassic_Profile["options"]["prvyear"]) then
				fsv:SetText(AccountantClassic_Profile["options"]["prvyear"])
			else
				fsv:SetText("")
			end
		else
			fs:SetText("")
			fsv:SetText("")
		end
		
	else
		-- all characters' tab
		-- AccountantClassicFrame.ShowAll:Hide();
		addon:PopulateCharacterList(AC_SELECTED_SERVER, AC_SELECTED_FACTION)
		AccountantClassicFrameCharacterDropDown:Hide();
		AccountantClassicFrameServerDropDown:Show()
		AccountantClassicFrameFactionDropDown:Show()
		
		local alltotal = 0
		local allin = 0
		local allout = 0
		local i = 1
		local serverkey, servervalue, charkey, charvalue

		i = 1
		if (AC_SELECTED_SERVER == "All") then
			for serverkey, servervalue in pairs(Accountant_ClassicSaveData) do
				for charkey, charvalue in pairs(Accountant_ClassicSaveData[serverkey]) do
					if (AC_SELECTED_FACTION == "All") then
						if Accountant_ClassicSaveData[serverkey][charkey]["options"]["totalcash"] ~= nil then
							alltotal = alltotal + Accountant_ClassicSaveData[serverkey][charkey]["options"]["totalcash"]
						end

						for key, value in pairs(Accountant_ClassicSaveData[serverkey][charkey]["data"]) do
							allin = allin + Accountant_ClassicSaveData[serverkey][charkey]["data"][key]["Total"]["In"]
							allout = allout + Accountant_ClassicSaveData[serverkey][charkey]["data"][key]["Total"]["Out"]
						end
						i = i + 1
					else
						local faction = AC_SELECTED_FACTION or AC_FACTION
						if (Accountant_ClassicSaveData[serverkey][charkey]["options"]["faction"] == faction) then
							if Accountant_ClassicSaveData[serverkey][charkey]["options"]["totalcash"] ~= nil then
								alltotal = alltotal + Accountant_ClassicSaveData[serverkey][charkey]["options"]["totalcash"]
							end

							for key, value in pairs(Accountant_ClassicSaveData[serverkey][charkey]["data"]) do
								allin = allin + Accountant_ClassicSaveData[serverkey][charkey]["data"][key]["Total"]["In"]
								allout = allout + Accountant_ClassicSaveData[serverkey][charkey]["data"][key]["Total"]["Out"]
							end
							i = i + 1
						end
					end
				end
			end
		else
			serverkey = AC_SELECTED_SERVER or AC_SERVER
			for charkey, charvalue in pairs(Accountant_ClassicSaveData[serverkey]) do
				if (AC_SELECTED_FACTION == "All") then
					if Accountant_ClassicSaveData[serverkey][charkey]["options"]["totalcash"] ~= nil then
						alltotal = alltotal + Accountant_ClassicSaveData[serverkey][charkey]["options"]["totalcash"]
					end

					for key, value in pairs(Accountant_ClassicSaveData[serverkey][charkey]["data"]) do
						allin = allin + Accountant_ClassicSaveData[serverkey][charkey]["data"][key]["Total"]["In"]
						allout = allout + Accountant_ClassicSaveData[serverkey][charkey]["data"][key]["Total"]["Out"]
					end
					i = i + 1
				else
					local faction = AC_SELECTED_FACTION or AC_FACTION
					if (Accountant_ClassicSaveData[serverkey][charkey]["options"]["faction"] == faction) then
						if Accountant_ClassicSaveData[serverkey][charkey]["options"]["totalcash"] ~= nil then
							alltotal = alltotal + Accountant_ClassicSaveData[serverkey][charkey]["options"]["totalcash"]
						end

						for key, value in pairs(Accountant_ClassicSaveData[serverkey][charkey]["data"]) do
							allin = allin + Accountant_ClassicSaveData[serverkey][charkey]["data"][key]["Total"]["In"]
							allout = allout + Accountant_ClassicSaveData[serverkey][charkey]["data"][key]["Total"]["Out"]
						end
						i = i + 1
					end
				end
			end
		end
		AccountantClassicScrollBar_Update()

		AccountantClassicFrame.TotalInValue:SetText("|cFFFFFFFF"..addon:GetFormattedValue(allin))
		AccountantClassicFrame.TotalOutValue:SetText("|cFFFFFFFF"..addon:GetFormattedValue(allout))
		if (allout > allin) then
			diff = allout - allin
			AccountantClassicFrame.TotalFlow:SetText("|cFFFF3333"..L["Net Loss"]..":")
			AccountantClassicFrame.TotalFlowValue:SetText("|cFFFF3333"..addon:GetFormattedValue(diff))
		else
			if allout ~= allin then
				diff = allin - allout
				AccountantClassicFrame.TotalFlow:SetText("|cFF00FF00"..L["Net Profit"]..":")
				AccountantClassicFrame.TotalFlowValue:SetText("|cFF00FF00"..addon:GetFormattedValue(diff))
			else
				AccountantClassicFrame.TotalFlow:SetText(L["Net Profit / Loss"]..":")
				AccountantClassicFrame.TotalFlowValue:SetText("")
			end
		end
		_G["AccountantClassicFrameRow18Title"].Text:SetText(L["Sum Total"])
		_G["AccountantClassicFrameRow18In"].Text:SetText("|cFFFFFFFF"..addon:GetFormattedValue(alltotal))
		
		fs:SetText("")
		fsv:SetText("")
	end
	SetPortraitTexture(AccountantClassicFramePortrait, "player")
	PanelTemplates_SetTab(AccountantClassicFrame, AC_CURRTAB)
end

function AccountantClassic_OnMouseDown(self, button)
	-- Handle left button clicks
	if (button == "LeftButton") then
		self:StartMoving()
	end
end

function AccountantClassic_OnMouseUp(self, button)
	self:StopMovingOrSizing();
	local a, b, c, d, e = self:GetPoint()
	profile.AcFramePoint = { a, b, c, d, e }
end

function ACC_Print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

local function AccountantClassic_ResetConfirmed()
	local mode = private.constants.logmodes[AC_CURRTAB];
	for key,value in pairs(AC_DATA) do
		AC_DATA[key][mode].In = 0;
		AC_DATA[key][mode].Out = 0;
		AccountantClassic_Profile["data"][key][mode].In = 0;
		AccountantClassic_Profile["data"][key][mode].Out = 0;
	end
	if AccountantClassicFrame:IsVisible() then
		AccountantClassic_OnShow();
	end
end

function AccountantClassic_ResetData()
	local logmode = private.constants.logmodes[AC_CURRTAB];
	if logmode == "Total" then
		logmode = L["Total"];
	elseif logmode == "Session" then
		logmode = L["This Session"];
	elseif logmode == "Day" then
		logmode = L["Today"];
	elseif logmode == "PrvDay" then
		logmode = L["Prv. Day"];
	elseif logmode == "Week" then
		logmode = L["This Week"];
	elseif logmode == "PrvWeek" then
		logmode = L["Prv. Week"];
	elseif logmode == "Month" then
		logmode = L["This Month"];
	elseif logmode == "PrvMonth" then
		logmode = L["Prv. Month"];
	elseif logmode == "Year" then
		logmode = L["This Year"];
	else

	end

	-- Confirm box
	LibDialog:Register("ACCOUNTANT_RESET", {
		text = format(L["Are you sure you want to reset the \"%s\" data?"], logmode),
		buttons = {
			{
				text = OKAY,
				on_click = function() AccountantClassic_ResetConfirmed(); end,
			},
			{
				text = CANCEL,
				on_click = function(self, mouseButton, down) LibDialog:Dismiss("ACCOUNTANT_RESET"); end,
			},
		},
		show_while_dead = true,
		hide_on_escape = true,
		is_exclusive = true,
		hide_on_escape = true,
		show_during_cinematic = false,
		
	});
	LibDialog:Spawn("ACCOUNTANT_RESET");
	
end

function addon:CharacterRemovalProceed(server, character)
	local faction_icon, class_color
	for ka, va in pairs(Accountant_ClassicSaveData) do
		if (ka == server) then
			for kb, vb in pairs(Accountant_ClassicSaveData[ka]) do
				if (kb == character) then
					local factionstr = Accountant_ClassicSaveData[ka][kb]["options"].faction or nil
					faction_icon = factionstr and "|TInterface\\PVPFrame\\PVP-Currency-"..factionstr..":0:0|t" or ""

					local classToken = Accountant_ClassicSaveData[ka][kb]["options"].class  or nil
					class_color = classToken and "|c"..RAID_CLASS_COLORS[classToken]["colorStr"] or ""

					Accountant_ClassicSaveData[ka][kb] = nil
					ACC_Print(format(L["|cffffffff\"%s - %s|cffffffff\" character's Accountant Classic data has been removed."], faction_icon..class_color..server, character))
					addon:PopulateCharacterList()
					if AccountantClassicFrame:IsVisible() then
						AccountantClassic_OnShow()
					end
					return
				end
			end
		end
	end
end

function AccountantClassicTab_OnClick(self)
	LibDD:CloseDropDownMenus()
	PanelTemplates_SetTab(AccountantClassicFrame, self:GetID());
	AC_CURRTAB = self:GetID();
	PlaySound(841);
	AccountantClassic_OnShow();
end

function addon:RepairAllItems(guildBankRepair)
	if (not guildBankRepair) then
		AC_LOGTYPE = "REPAIRS";
	end
end

function addon:CursorHasItem()
	if InRepairMode() then
		AC_LOGTYPE = "REPAIRS";
	end
end

function addon:BackpackTokenFrame_Update()
	if WoWClassic then
		-- do nothing
	else
		local name, count, icon, currencyID
		local tokenstr = ""
		for i=1, MAX_WATCHED_TOKENS do
			local info
			info = GetBackpackCurrencyInfo(i)
			-- Update watched tokens
			if ( info ) then
				name =  info.name
				count =  info.quantity
				icon = info.iconFileID
				currencyID = info.currencyTypesID

				tokenstr = tokenstr..AccountantClassic_GetFormattedCurrency(currencyID).." "
			end
		end
		return tokenstr
	end
end

function addon:ShowNetMoney(logmode)
	if (not logmode) then return end

	local amoney_str = "";

	local TotalIn = 0;
	local TotalOut = 0;
	local diff = 0;
	if (logmode ~= "Total" and AC_DATA["REPAIRS"][logmode]) then
		for key,value in pairs(AC_DATA) do
			TotalIn = TotalIn + AC_DATA[key][logmode].In;
			TotalOut = TotalOut + AC_DATA[key][logmode].Out;
		end
		if (TotalOut > TotalIn) then
			diff = TotalOut-TotalIn;
			amoney_str = amoney_str.."|cFFFF3333"..L["Net Loss"]..": ";
			amoney_str = amoney_str..addon:GetFormattedValue(diff);
		else
			diff = TotalIn-TotalOut;
			if (diff == 0) then
				amoney_str = addon:GetFormattedValue(GetMoney());
			else
				amoney_str = amoney_str.."|cFF00FF00"..L["Net Profit"]..": ";
				amoney_str = amoney_str..addon:GetFormattedValue(diff);
			end
		end
	else
		amoney_str = addon:GetFormattedValue(GetMoney());
	end
	
	if (amoney_str) then
		return amoney_str;
	end
end

function addon:ShowSessionToolTip()
	local amoney_str = "";

	local TotalIn = 0;
	local TotalOut = 0;
	for key,value in pairs(AC_DATA) do
		TotalIn = TotalIn + AC_DATA[key]["Session"].In;
		TotalOut = TotalOut + AC_DATA[key]["Session"].Out;
	end
	amoney_str = "|cFFFFFFFF"..L["Total Incomings"]..": "..addon:GetFormattedValue(TotalIn).."\n";
	amoney_str = amoney_str.."|cFFFFFFFF"..L["Total Outgoings"]..": "..addon:GetFormattedValue(TotalOut).."\n";
	if TotalOut > TotalIn then
		diff = TotalOut-TotalIn;
		amoney_str = amoney_str.."|cFFFF3333"..L["Net Loss"]..": ";
		amoney_str = amoney_str..addon:GetFormattedValue(diff);
	else
		if TotalOut ~= TotalIn then
			diff = TotalIn-TotalOut;
			amoney_str = amoney_str.."|cFF00FF00"..L["Net Profit"]..": ";
			amoney_str = amoney_str..addon:GetFormattedValue(diff);
		else
			-- do nothing
		end
	end
	
	if (amoney_str) then
		return amoney_str;
	end
end

local AC_MAXTOOLTIPLINES = 50;
function AccountantClassic_LogTypeOnShow(self)
	if (not private.constants.logmodes[AC_CURRTAB]) then
		return;
	end
	if (profile.trackzone == true and self.logType and self.cashflow) then
		local logmode = private.constants.logmodes[AC_CURRTAB];
		local logType = self.logType;
		local cashflow = self.cashflow;
		local tooltipText;
		local mIn = 0;
		local mOut = 0;

		if (logmode == "Session") then
			tooltipText = "";
			local serverkey = AC_SERVER;
			local charkey = AC_PLAYER;

			if (Accountant_ClassicZoneDB[serverkey] and Accountant_ClassicZoneDB[serverkey][charkey]) then
				for k_zone, v_zone in orderedpairs(Accountant_ClassicZoneDB[serverkey][charkey]["data"][logmode][logType]) do
					mIn = Accountant_ClassicZoneDB[serverkey][charkey]["data"][logmode][logType][k_zone]["In"];
					mOut = Accountant_ClassicZoneDB[serverkey][charkey]["data"][logmode][logType][k_zone]["Out"];
					if (cashflow == "In" and mIn > 0) then
						tooltipText = tooltipText..k_zone..": ";
						tooltipText = tooltipText..AccountantClassic_NiceCash(mIn).."\n";
					end
					if (cashflow == "Out" and mOut > 0) then
						tooltipText = tooltipText..k_zone..": ";
						tooltipText = tooltipText..AccountantClassic_NiceCash(mOut).."\n";
					end
				end
			end
		else
			if (AC_SELECTED_CHAR_NUM <= #AC_CHARSCROLL_LIST) then
				tooltipText = "";
				local charindex = AC_SELECTED_CHAR_NUM;
				local serverkey = AC_CHARSCROLL_LIST[charindex][1];
				local charkey = AC_CHARSCROLL_LIST[charindex][2];

				if (Accountant_ClassicZoneDB[serverkey] and Accountant_ClassicZoneDB[serverkey][charkey]) then
					local i, j = 1, 1;
					for k_zone, v_zone in orderedpairs(Accountant_ClassicZoneDB[serverkey][charkey]["data"][logmode][logType]) do
						mIn = Accountant_ClassicZoneDB[serverkey][charkey]["data"][logmode][logType][k_zone]["In"];
						mOut = Accountant_ClassicZoneDB[serverkey][charkey]["data"][logmode][logType][k_zone]["Out"];
						if (cashflow == "In" and mIn > 0) then
							tooltipText = tooltipText..k_zone..": ";
							tooltipText = tooltipText..AccountantClassic_NiceCash(mIn).."\n";
							i = i + 1;
							if (i == AC_MAXTOOLTIPLINES) then 
								tooltipText = tooltipText.."...";
								break; 
							end
						end
						if (cashflow == "Out" and mOut > 0) then
							tooltipText = tooltipText..k_zone..": ";
							tooltipText = tooltipText..AccountantClassic_NiceCash(mOut).."\n";
							j = j + 1;
							if (j == AC_MAXTOOLTIPLINES) then 
								tooltipText = tooltipText.."...";
								break; 
							end
						end
					end
				end
			elseif (AC_SELECTED_CHAR_NUM == #AC_CHARSCROLL_LIST + 1) then
			-- currently not supported to show all characters
	--[[			local serverkey, servervalue, charkey, charvalue;
				for serverkey, servervalue in pairs(Accountant_ClassicZoneDB) do
					for charkey, charvalue in pairs(Accountant_ClassicZoneDB[serverkey]) do
						for k_zone, v_zone in pairs(Accountant_ClassicZoneDB[serverkey][charkey]["data"][logmode][logType]) do
							tooltipText = tooltipText..k_zone..": ";
							mIn = mIn + Accountant_ClassicZoneDB[serverkey][charkey]["data"][logmode][logType][k_zone]["In"];
							mOut = mOut + Accountant_ClassicZoneDB[serverkey][charkey]["data"][logmode][logType][k_zone]["Out"];
							tooltipText = tooltipText..L["ACCLOC_IN"]..addon:GetFormattedValue(mIn)..", "..L["ACCLOC_OUT"]..addon:GetFormattedValue(mOut).."\n";
						end
					end
				end
	]]
			end
		end
		if (tooltipText) then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
			GameTooltip:AddLine(tooltipText, nil, nil, nil, false);
			GameTooltip:Show();
		end
	end
end


function addon:OnInitialize()
	self.db = AceDB:New("Accountant_ClassicDB", private.constants.defaults, true);
	profile = self.db.profile
	if not self.db then
		self:Print("Error: Database not loaded correctly.  Please exit out of WoW and delete the Accountant Classic database file Accountant_Classic.lua) found in: \\World of Warcraft\\WTF\\Account\\<Account Name>>\\SavedVariables\\")
		return
	end
	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")

	LDB.type = "data source";
	LDB.text = L["Accountant Classic"];
	LDB.label = L["Accountant Classic"];
	LDB.icon = "Interface\\AddOns\\Accountant_Classic\\Images\\AccountantClassicButton-Up";
	LDB.OnClick = (function(self, button)
		if button == "LeftButton" then
			AccountantClassic_ButtonOnClick();
		elseif button == "RightButton" then
			addon:OpenOptions();
		end
	end);
	LDB.OnTooltipShow = (function(tooltip)
		if not tooltip or not tooltip.AddLine then return end
		local title = "|cffffffff"..L["Accountant Classic"];
		if (profile.showmoneyonbutton) then
			title = title.." - "..addon:GetFormattedValue(GetMoney());
		end
		tooltip:AddLine(title);
		if (profile.showsessiononbutton == true) then
			tooltip:AddLine(addon:ShowSessionToolTip());
		end
		if (profile.showintrotip == true) then
			tooltip:AddLine(L["Left-Click to open Accountant Classic.\nRight-Click for Accountant Classic options.\nLeft-click and drag to move this button."]);
		end
	end);

	ACbutton:Register(private.addon_name, LDB, profile.minimap);
	self:RegisterChatCommand("accountantbutton", AccountantClassic_ButtonToggle);
	self:RegisterChatCommand("accountant", Accountant_Slash);
	self:RegisterChatCommand("acc", Accountant_Slash);
	initOptions()
	addon:SetupOptions()
	
	MoneyFrame = addon:GetModule("MoneyFrame", true)
	createACFrames()
end

function addon:OnEnable()
	copyOptions()

	self:SecureHook("RepairAllItems")
	self:SecureHook("CursorHasItem")
	
	loadData()
	setLabels()

	if (profile.cross_server and not AC_SELECTED_SERVER) then 
		AC_SELECTED_SERVER = "All" 
	elseif (not profile.cross_server and not AC_SELECTED_SERVER) then 
		AC_SELECTED_SERVER = AC_SERVER
	end
	if (profile.show_allFactions and not AC_SELECTED_FACTION) then 
		AC_SELECTED_FACTION = "All" 
	elseif (not profile.show_allFactions and not AC_SELECTED_FACTION) then 
		AC_SELECTED_FACTION = AC_FACTION
	end
	
	-- Cash
	AC_CURRMONEY = GetMoney()
	-- Check if there is any un-recorded money in or out
	if (AC_LASTSESSMONEY ~= AC_CURRMONEY) then
		AC_LOGTYPE = "OTHER"
		AC_LASTMONEY = AC_LASTSESSMONEY
		updateLog()
	end
	AC_LASTMONEY = AC_CURRMONEY
	
	settleTabText()
	addon:PopulateCharacterList()
	
	self:Refresh()
	LDB.text = addon:ShowNetMoney(private.constants.ldbDisplayTypes[profile.ldbDisplayType])
end

function addon:Toggle()
	self.db.profile.minimap.hide = not self.db.profile.minimap.hide
	if self.db.profile.minimap.hide then
		ACbutton:Hide(private.addon_name)
	else
		ACbutton:Show(private.addon_name)
	end
end

function addon:Refresh()
	profile = self.db.profile

	if (profile.showmoneyinfo) then
		AccountantClassicMoneyInfoFrame:Show()
		MoneyFrame:ArrangeMoneyInfoFrame()
	else
		AccountantClassicMoneyInfoFrame:Hide()
	end
	AccountantClassic_OnShow()
	arrangeAccountantClassicFrame()
	
	LDB.text = addon:ShowNetMoney(private.constants.ldbDisplayTypes[profile.ldbDisplayType])
end

function AccountantClassic_ButtonToggle()
	addon:Toggle()
end

function AccountantClassic_ButtonOnClick()
	if AccountantClassicFrame:IsVisible() then
		AccountantClassicFrame:Hide();
	else
		AccountantClassicFrame:Show();
	end
end


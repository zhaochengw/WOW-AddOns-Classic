--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert at gmail dot com>
	Copyright 2010 - Lothaer <lothayer at gmail dot com>, Atlas Team
	Copyright 2011 ~ 2023 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

-- Determine WoW TOC Version
local WoWClassicEra, WoWClassic, WoWRetail
local wowversion = select(4, GetBuildInfo())
if wowversion < 40000 then
	WoWClassicEra = true
elseif wowversion > 40000 and wowversion < 90000 then
	WoWClassic = true
elseif wowversion > 90000 then
	WoWRetail = true
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local addon = LibStub("AceAddon-3.0"):NewAddon(private.addon_name, "AceConsole-3.0", "AceEvent-3.0")

addon.constants = private.constants
addon.Templates = private.Templates
addon.constants.addon_name = private.addon_name
addon.Name = FOLDER_NAME
addon.LocName = select(2, C_AddOns.GetAddOnInfo(addon.Name))
addon.Notes = select(3, C_AddOns.GetAddOnInfo(addon.Name))
_G.Atlas = addon

local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local AceDB = LibStub("AceDB-3.0")

local profile

-- Minimap button with LibDBIcon-1.0
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Atlas", {
	type = "launcher",
	text = L["ATLAS_TITLE"],
	icon = "Interface\\WorldMap\\WorldMap-Icon",
	OnClick = function(_, button)
		if button == "LeftButton" then
			Atlas_Toggle()
		elseif button == "RightButton" then
			addon:OpenOptions()
		end
	end,
	OnTooltipShow = function(tooltip)
		if not tooltip or not tooltip.AddLine then return end
		tooltip:AddLine("|cffffffff"..ATLAS_TITLE)
		tooltip:AddLine(ATLAS_LDB_HINT)
	end
})

local minimapButton = LibStub("LibDBIcon-1.0")

function Atlas_ButtonToggle2()
	profile.minimap.hide = not profile.minimap.hide
	Atlas_ButtonToggle()
end

function Atlas_ButtonToggle()
	if profile.minimap.hide then
		minimapButton:Hide("Atlas")
	else
		minimapButton:Show("Atlas")
	end
end

local function debug(info)
	if (ATLAS_DEBUGMODE) then
		DEFAULT_CHAT_FRAME:AddMessage(L["ATLAS_TITLE"]..L["Colon"]..info)
	end
end

local function round(num, idp)
	local mult = 10 ^ (idp or 0)
	return floor(num * mult + 0.5) / mult
end

-- get creature's name from server
local cache_tooltip = _G["cacheToolTip"] or CreateFrame("GameTooltip", "cacheToolTip", UIParent, "GameTooltipTemplate")
local creature_cache
local function getCreatureNamebyID(id)
	if not id then return end

	cache_tooltip:SetOwner(UIParent, "ANCHOR_NONE")
	cache_tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
	creature_cache = _G["cacheToolTipTextLeft1"]:GetText()
end

function addon:GetCreatureName(creatureName, id)
	if (not creatureName) and (not id) then return end

	getCreatureNamebyID(id)
	creatureName = creature_cache or creatureName
	creature_cache = nil

	return creatureName
end

-- Below to temporarily create a table to store the core map's data
-- in order to identify the dropdown's zoneID is belonging to the
-- core Atlas or plugins
local Atlas_CoreMapsKey = {}
local Atlas_CoreMapsKey_Index = 0

function addon:RegisterPlugin(name, myCategory, myData, myNPCData)
	ATLAS_PLUGINS[name] = {}
	local i = #Atlas_MapTypes + 1
	Atlas_MapTypes[i] = ATLAS_PLUGINS_COLOR..myCategory -- Plugin category name to be added with green color, and then added to array

	for k, v in pairs(myData) do
		tinsert(ATLAS_PLUGINS[name], k)
		AtlasMaps[k] = v
	end

	tinsert(ATLAS_PLUGIN_DATA, myData)
	ATLAS_PLUGIN_MENUS = ATLAS_PLUGIN_MENUS + 1

	if (myNPCData) then
		for k, v in pairs(myNPCData) do
			AtlasMaps_NPC_DB[k] = v
		end
	end

	if (ATLAS_OLD_TYPE and ATLAS_OLD_TYPE <= ATLAS_MODULE_MENUS + #Atlas_MapTypes) then
		profile.options.dropdowns.module = ATLAS_OLD_TYPE
		profile.options.dropdowns.zone = ATLAS_OLD_ZONE
	end

	addon:PopulateDropdowns()
	Atlas_Refresh()
end

local function registerModule(moduleKey)
	local module = addon:GetModule(moduleKey)
	if not module and not module.db then return end
	-- register module map tables
	if (module.db.AtlasMaps) then
		for k, v in pairs(module.db.AtlasMaps) do
			AtlasMaps[k] = v
			Atlas_CoreMapsKey[Atlas_CoreMapsKey_Index] = k
			Atlas_CoreMapsKey_Index = Atlas_CoreMapsKey_Index + 1
		end
	end
	-- register module maps' coords
	if (module.db.AtlasMaps_NPC_DB) then
		for k, v in pairs(module.db.AtlasMaps_NPC_DB) do
			AtlasMaps_NPC_DB[k] = v
		end
	end
	-- register module maps' dropdowns order
	if (module.db.DropDownLayouts_Order) then
		for k_cat, v_cat in pairs(module.db.DropDownLayouts_Order) do
			if (not addon.dropdowns.DropDownLayouts_Order[k_cat]) then
				addon.dropdowns.DropDownLayouts_Order[k_cat] = v_cat
			else
				for i = 1, #module.db.DropDownLayouts_Order[k_cat] do
					local v = module.db.DropDownLayouts_Order[k_cat][i]
					if (not tContains(addon.dropdowns.DropDownLayouts_Order[k_cat], v)) then
						tinsert(addon.dropdowns.DropDownLayouts_Order[k_cat], v)
					end
				end
			end
		end
	end
	-- register module maps' dropdowns menus
	if (module.db.DropDownLayouts) then
		for k_cat, v_cat in pairs(module.db.DropDownLayouts) do
			if (not addon.dropdowns.DropDownLayouts[k_cat]) then
				addon.dropdowns.DropDownLayouts[k_cat] = v_cat
			else
				for k_scat, v_scat in pairs(module.db.DropDownLayouts[k_cat]) do
					if (not addon.dropdowns.DropDownLayouts[k_cat][k_scat]) then
						addon.dropdowns.DropDownLayouts[k_cat][k_scat] = v_scat
					else
						for i = 1, #module.db.DropDownLayouts[k_cat][k_scat] do
							local v = module.db.DropDownLayouts[k_cat][k_scat][i]
							if (not tContains(addon.dropdowns.DropDownLayouts[k_cat][k_scat], v)) then
								tinsert(addon.dropdowns.DropDownLayouts[k_cat][k_scat], v)
							end
						end
					end
				end
			end
		end
	end
	-- register module maps' associations
	for k_table, v_table in pairs(addon.assocs) do
		if (module.db[k_table]) then
			for ka, va in pairs(module.db[k_table]) do
				if (addon.assocs[k_table][ka]) then
					if (type(addon.assocs[k_table][ka]) == "table") then
						for i = 1, #addon.assocs[k_table][ka] do
							local v = module.db[k_table][ka][i]
							if (not tContains(addon.assocs[k_table][ka], v)) then
								tinsert(addon.assocs[k_table][ka], v)
							end
						end
					end
				else
					addon.assocs[k_table][ka] = va
				end
			end
		end
	end
	ATLAS_MODULE_MENUS = ATLAS_MODULE_MENUS + 1
	addon:PopulateDropdowns()
	Atlas_Refresh()
end

local function bossButtonCleanUp(button)
	button:SetID(0)
	button.encounterID = nil
	button.instanceID = nil
	button.overviewDescription = nil
	button.roleOverview = nil
	button.achievementID = nil
	button.tooltiptitle = nil
	button.tooltiptext = nil
	button.link = nil
	button.displayInfo = nil
	button.name = nil
	button.id = nil
	button.description = nil
	button.uiModelSceneID = nil
	if (button.bgImage) then button.bgImage:SetTexture(nil) end
	if (button.TaxiImage) then button.TaxiImage:SetTexture(nil) end
end

local function bossButtonUpdate(button, encounterID, instanceID, b_iconImage, moduleData)
	if (WoWClassicEra) then return end

	button:SetID(encounterID)
	button.encounterID = encounterID
	if (instanceID and instanceID ~= 0) then
		button.instanceID = instanceID
	end
	button.AtlasModule = moduleData or nil

	local ejbossname, description, _, _, link = EJ_GetEncounterInfo(encounterID)
	if (ejbossname) then
		button.tooltiptitle = ejbossname
		button.tooltiptext = description
		button.link = link

		if (b_iconImage) then
			local id, name, description, displayInfo, iconImage, uiModelSceneID = EJ_GetCreatureInfo(1, encounterID)
			button.name = name
			button.id = id
			button.displayInfo = displayInfo
			button.description = description
			button.uiModelSceneID = uiModelSceneID
			if (iconImage) then
				SetPortraitTextureFromCreatureDisplayID(button.bgImage, displayInfo)
			end
			if button.DefeatedOverlay then
				local complete = C_EncounterJournal.IsEncounterComplete(encounterID);
				button.DefeatedOpacity:SetShown(complete);
				button.DefeatedOverlay:SetShown(complete);
				button.bgImage:SetDesaturation(complete and 0.7 or 0);
			end
		end
	end
end

local function searchText(text)
	local zoneID = ATLAS_DROPDOWNS[profile.options.dropdowns.module][profile.options.dropdowns.zone] or ATLAS_DROPDOWNS[1][1]
	local mapdata = AtlasMaps
	local base = mapdata[zoneID]

	local data = nil

	if (ATLAS_SEARCH_METHOD == nil) then
		data = ATLAS_DATA
	else
		data = ATLAS_SEARCH_METHOD(ATLAS_DATA, text)
	end

	-- Populate the scroll frame entries list, the update func will do the rest
	wipe(ATLAS_SCROLL_LIST)
	local i = 1
	while (data[i] ~= nil) do
		if (data[i][3] and data[i][3] ~= "") then
			ATLAS_SCROLL_LIST[i] = {
				type = "Item",
				data = {
					text = data[i][1],
					itemID = data[i][2],
					fallbackName = data[i][4],
				}
			}
		elseif (type(data[i][2]) == "number" and data[i][2] < 10000 and select(4, GetBuildInfo()) > 40000) then
			ATLAS_SCROLL_LIST[i] = {
				type = "Boss",
				data = {
					text = data[i][1],
					encounterID = data[i][2],
					instanceID = base.JournalInstanceID or 0,
					module = base.Module or base.ALModule or nil
				}
			}
		elseif (type(data[i][2]) == "string") then
			local achievementID = strmatch(data[i][2], "ac=(%d+)")
			ATLAS_SCROLL_LIST[i] = {
				type = "Achievement",
				data = { achievementID = tonumber(achievementID) }
			}
		else
			ATLAS_SCROLL_LIST[i] = {
				type = "String",
				data = { text = data[i][1] }
			}
		end
		i = i + 1
	end
end

function addon:SearchAndRefresh(text)
	searchText(text)
	Atlas_ScrollBar_Update()
end

function addon:SearchLFG()
	-- LFG tool isn't available until level 10
	if (UnitLevel("player") < 10) then return end

	-- Open LFG to the group browser
	ShowLFGParentFrame(2);

	-- Set Category
	UIDropDownMenu_SetSelectedValue(LFGBrowseFrame.CategoryDropDown, AtlasFrameLFGButton.ActivityID[1]);
	UIDropDownMenu_Initialize(LFGBrowseFrame.CategoryDropDown, LFGBrowseCategoryDropDown_Initialize);

	-- Set Activity
	LFGBrowseActivityDropDown_ValueReset(LFGBrowseFrame.ActivityDropDown);
	UIDropDownMenu_ClearAll(LFGBrowseFrame.ActivityDropDown);
	UIDropDownMenu_Initialize(LFGBrowseFrame.ActivityDropDown, LFGBrowseActivityDropDown_Initialize);
	LFGBrowseActivityDropDown_ValueSetSelected(LFGBrowseFrame.ActivityDropDown, AtlasFrameLFGButton.ActivityID[2], true);

	-- Start search
	LFGBrowse_DoSearch();
end

function addon:SearchLFG_Enter(button)
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
	if (UnitLevel("player") < 10) then
		GameTooltip:SetText(L["Find group for this instance"].."\n"..RED_FONT_COLOR_CODE..L["LFG is unavailable until level 10"]);
	else
		GameTooltip:SetText(L["Find group for this instance"]);
	end
end

function Atlas_ScrollBar_Update()
	if (AtlasFrameBottomInset.ScrollBox) then
		local DataProvider = CreateDataProvider(ATLAS_SCROLL_LIST)
		local ScrollView = AtlasFrameBottomInset.ScrollBox:GetView()
		ScrollView:SetDataProvider(DataProvider)
	end

	GameTooltip:Hide()
end

local function simpleSearch(data, text)
	if (strtrim(text or "") == "") then
		return data
	end
	local new = {}; -- Create a new table
	local i, v, n
	local search_text = strlower(text)
	search_text = search_text:gsub("([%^%$%(%)%%%.%[%]%+%-%?])", "%%%1")
	search_text = search_text:gsub("%*", ".*")
	local fmatch

	i, v = next(data, nil); -- The i is an index of data, v = data[i]
	n = i
	while i do
		if (type(i) == "number") then
			fmatch = gmatch(strlower(data[i][1]), search_text)()
			if (fmatch) then
				new[n] = data[i]
				n = n + 1
			end
		end
		i, v = next(data, i); -- Get next index
	end
	return new
end

-- Removal of articles in map names (for proper alphabetic sorting)
-- For example: "The Deadmines" will become "Deadmines"
-- Thus it will be sorted under D and not under T
local function sanitizeName(text)
	text = strlower(text)
	if (AtlasSortIgnore) then
		for _, v in pairs(AtlasSortIgnore) do
			local fmatch = gmatch(text, v)()
			if (fmatch) and ((strlen(text) - strlen(fmatch)) <= 4) then
				return fmatch
			end
		end
	end
	return text
end

-- Comparator function for alphabetic sorting of maps
-- Yey, one function for everything
local function sortZonesAlpha(a, b)
	local aa = sanitizeName(AtlasMaps[a].ZoneName[1])
	local bb = sanitizeName(AtlasMaps[b].ZoneName[1])
	return aa < bb
end

function addon:PopulateDropdowns()
	local i = 1
	local catName = addon.dropdowns.DropDownLayouts_Order[profile.options.dropdowns.menuType]
	local subcatOrder = addon.dropdowns.DropDownLayouts_Order[catName]
	if (subcatOrder and type(subcatOrder) == "table") then
		sort(subcatOrder)
		for n = 1, #subcatOrder, 1 do
			local subcatItems = addon.dropdowns.DropDownLayouts[catName][subcatOrder[n]]
			sort(subcatItems, sortZonesAlpha)

			local q = (#subcatItems - (#subcatItems % ATLAS_MAX_MENUITEMS)) / ATLAS_MAX_MENUITEMS or 0
			for p = 0, q do
				ATLAS_DROPDOWNS[i + p] = {}
			end

			for k, v in pairs(subcatItems) do
				local q1 = (k - (k % ATLAS_MAX_MENUITEMS)) / ATLAS_MAX_MENUITEMS
				if v then tinsert(ATLAS_DROPDOWNS[i + q1], v) end
			end

			i = i + q + 1
		end
	end

	if (ATLAS_PLUGIN_DATA) then
		for ka, va in pairs(ATLAS_PLUGIN_DATA) do
			ATLAS_DROPDOWNS[i] = {}

			for kb, vb in pairs(va) do
				if (type(vb) == "table") then
					tinsert(ATLAS_DROPDOWNS[i], kb)
				end
			end

			sort(ATLAS_DROPDOWNS[i], sortZonesAlpha)

			i = i + 1
		end
	end
end

local function process_Deprecated()
	-- Check to see if a module that is now bundled with Atlas is enabled and if so, recommend disabling it
	local includedModulePresent = false;
	local includedModules = {
		"Atlas_ClassicWoW",
		"Atlas_BurningCrusade",
		"Atlas_WrathoftheLichKing",
		"Atlas_Cataclysm",
		"Atlas_MistsofPandaria",
		"Atlas_WarlordsofDraenor",
		"Atlas_Legion",
		"Atlas_BattleforAzeroth"
	};
	for _, module in ipairs(includedModules) do
		if (C_AddOns.GetAddOnEnableState(module) ~= 0) then
			includedModulePresent = true;
		end
	end
	if (includedModulePresent == true) then
		DEFAULT_CHAT_FRAME:AddMessage(L["ATLAS_INCLUDED_MODULES"]);
	end

	local Deprecated_List = addon.constants.deprecatedList
	-- Check for outdated modules, build a list of them, then disable them and tell the player
	local OldList = {}
	for k, v in pairs(Deprecated_List) do
		if (addon:CheckAddonStatus(C_AddOns.GetAddOnInfo(v[1]))) then
			local outdated = false
			local compatibleVer
			local currVer = C_AddOns.GetAddOnMetadata(v[1], "Version")
			if (v[3] and (strsub(currVer, 1, 1) == "r")) then
				compatibleVer = tonumber(string.sub(v[3], 2))
				currVer = tonumber(string.sub(currVer, 2))
				if (currVer < compatibleVer) then
					outdated = true
				end
			elseif (v[2] and (strsub(currVer, 1, 1) ~= "r") and (strsub(currVer, 1, 1) ~= "@") and currVer < v[2]) then
				outdated = true
			end
			if (outdated) then
				tinsert(OldList, v[1])
			end
		end
	end

	if #OldList > 0 then
		local textList = ""
		for k, v in pairs(OldList) do
			textList = textList.."\n"..v..", "..C_AddOns.GetAddOnMetadata(v, "Version")
		end
		DEFAULT_CHAT_FRAME:AddMessage(L["ATLAS_DEP_MSG1"].."\n"..L["ATLAS_DEP_MSG3"].."\n|cff6666ff"..textList.."|r\n\n"..L["ATLAS_DEP_MSG4"]);
	end
end

-- Called when the Atlas frame is first loaded
-- We CANNOT assume that data in other files is available yet!
function Atlas_OnLoad(self)
	process_Deprecated()

	-- Register the Atlas frame for the following events
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("ADDON_LOADED")

	-- Allows Atlas to be closed with the Escape key
	tinsert(UISpecialFrames, "AtlasFrame")
	tinsert(UISpecialFrames, "AtlasFrameSmall")

	-- Dragging involves some special registration
	self:RegisterForDrag("LeftButton")
end

--Called whenever the Atlas frame is displayed
function Atlas_OnShow()
	if (profile.options.autoSelect) then
		Atlas_AutoSelect()
	end

	AtlasFrameDropDownType_OnShow()
	AtlasFrameDropDown_OnShow()
end

-- Simple function to toggle the visibility of the Atlas frame
function Atlas_Toggle()
	if (ATLAS_SMALLFRAME_SELECTED) then
		if (AtlasFrameSmall:IsVisible()) then
			AtlasFrameSmall:Hide();
		else
			AtlasFrameSmall:Show();
		end
	else
		if (AtlasFrame:IsVisible()) then
			AtlasFrame:Hide();
		else
			AtlasFrame:Show();
		end
	end
end

function addon:Toggle()
	Atlas_Toggle()
end

local function checkInstanceHasGearLevel()
	if not GetLFGDungeonInfo then
		return false
	end
	local zoneID = ATLAS_DROPDOWNS[profile.options.dropdowns.module][profile.options.dropdowns.zone]
	if (not zoneID) then
		return false
	end
	local data = AtlasMaps
	local base = data[zoneID]

	local minGearLevel, minGearLevelH, minGearLevelM

	if (base.DungeonID) then
		_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, minGearLevel = GetLFGDungeonInfo(base.DungeonID)
	end
	if (base.DungeonHeroicID) then
		_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, minGearLevelH = GetLFGDungeonInfo(base.DungeonHeroicID)
	end
	if (base.DungeonMythicID) then
		_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, minGearLevelM = GetLFGDungeonInfo(base.DungeonMythicID)
	end

	local iLFGhasGearInfo = false
	if ((minGearLevel and minGearLevel ~= 0) or (minGearLevelH and minGearLevelH ~= 0) or (minGearLevelM and minGearLevelM ~= 0)) then
		iLFGhasGearInfo = true
	else
		iLFGhasGearInfo = false
	end

	return iLFGhasGearInfo
end

function addon:FormatColor(color_array)
	if (not color_array or type(color_array) ~= "table") then return; end
	if (not (color_array.r and color_array.g and color_array.b)) then return; end

	local colortag = format("|cff%02x%02x%02x", color_array.r * 255, color_array.g * 255, color_array.b * 255)
	return colortag
end

-- Calculate the dungeon difficulty based on the dungeon's level and player's level
-- Codes adopted from FastQuest_Classic
function addon:GetDungeonDifficultyColor(minRecLevel)
	local color = { r = 1.00, g = 1.00, b = 1.00 }
	if (not minRecLevel) then
		return color
	end

	local greenLevel
	if (WoWClassicEra or WoWClassic) then
		greenLevel = GetQuestGreenRange()
	else
		greenLevel = UnitQuestTrivialLevelRange('player')
	end

	local lDiff = minRecLevel - UnitLevel("player")
	if (lDiff >= 0) then
		for i = 1.00, 0.10, -0.10 do
			color = { r = 1.00, g = i, b = 0.00 }
			if ((i / 0.10) == (10 - lDiff)) then return color; end
		end
	elseif (-lDiff < greenLevel) then
		for i = 0.90, 0.10, -0.10 do
			color = { r = i, g = 1.00, b = 0.00 }
			if ((9 - i / 0.10) == (-1 * lDiff)) then return color; end
		end
	elseif (-lDiff == greenLevel) then
		color = { r = 0.50, g = 1.00, b = 0.50 }
	else
		color = { r = 1.00, g = 1.00, b = 1.00 }
	end
	return color
end

local function getGearItemLevelDiffColor(minGearLevel)
	local color = { r = 1.00, g = 1.00, b = 1.00 }
	if (minGearLevel == nil) then return color end
	local lDiff = minGearLevel
	lDiff = tonumber(lDiff)
	if (GetAverageItemLevel) then
		lDiff = minGearLevel - GetAverageItemLevel()
	end

	if (lDiff >= 0) then
		for i = 1.00, 0.10, -0.10 do
			color = { r = 1.00, g = i, b = 0.00 }
			if ((i / 0.10) == round(((100 - lDiff) / 10), 0)) then return color; end
		end
	elseif (-lDiff < 100) then
		for i = 0.90, 0.10, -0.10 do
			color = { r = i, g = 1.00, b = 0.00 }
			if ((9 - i / 0.10) == round(((-1 * lDiff) / 10), 0)) then return color; end
		end
	elseif (-lDiff == 100) then
		color = { r = 0.50, g = 1.00, b = 0.50 }
	else
		color = { r = 1.00, g = 1.00, b = 1.00 }
	end

	return color
end

-- Add boss / NPC button here so that we can add GameTooltip
function addon:MapAddNPCButton()
	local zoneID = ATLAS_DROPDOWNS[profile.options.dropdowns.module][profile.options.dropdowns.zone]
	local t = AtlasMaps_NPC_DB[zoneID]
	local data = AtlasMaps
	local base = data[zoneID]
	local i = 1
	local bossindex = 1
	local buttonindex = 1
	local bossindexS = 1
	local buttonindexS = 1
	local bossbutton, button, bossbuttonS, buttonS

	if (t) then
		while (t[i]) do
			local info_mark     = t[i][1]
			local info_id       = t[i][2]
			local info_x        = t[i][3]
			local info_y        = t[i][4]
			local info_colortag = t[i][7]

			if (info_x == nil) then info_x = -18; end
			if (info_y == nil) then info_y = -18; end

			if ((WoWRetail or WoWClassic) and info_id < 10000 and profile.options.frames.showBossPotrait) then
				bossbutton = _G["AtlasMapBossButton"..bossindex]
				local template = WoWRetail and "AtlasFrameBossButtonTemplate" or "AtlasFrameBossButtonTemplateClassic"
				if (not bossbutton) then
					bossbutton = CreateFrame("Button", "AtlasMapBossButton"..bossindex, AtlasFrame, template)
				end
				bossButtonCleanUp(bossbutton)
				bossButtonUpdate(bossbutton, info_id, base.JournalInstanceID, true)

				bossbuttonS = _G["AtlasMapBossButtonS"..bossindexS]
				if (not bossbuttonS) then
					bossbuttonS = CreateFrame("Button", "AtlasMapBossButtonS"..bossindexS, AtlasFrameSmall, template)
				end
				bossButtonCleanUp(bossbuttonS)
				bossButtonUpdate(bossbuttonS, info_id, base.JournalInstanceID, true)

				bossbutton:ClearAllPoints()
				bossbutton:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", info_x + 4 - 15, -info_y - 76 + 15)
				bossbutton:Show()

				bossbuttonS:ClearAllPoints()
				bossbuttonS:SetPoint("TOPLEFT", "AtlasFrameSmall", "TOPLEFT", info_x + 4 - 15, -info_y - 76 + 15)
				bossbuttonS:Show()

				bossindex = bossindex + 1
				bossindexS = bossindexS + 1
			else
				button = _G["AtlasMapNPCButton"..buttonindex]
				if (not button) then
					button = CreateFrame("Button", "AtlasMapNPCButton"..buttonindex, AtlasFrame, "AtlasMapNPCButtonTemplate")
				end
				buttonS = _G["AtlasMapNPCButtonS"..buttonindexS]
				if (not buttonS) then
					buttonS = CreateFrame("Button", "AtlasMapNPCButtonS"..buttonindexS, AtlasFrameSmall, "AtlasMapNPCButtonTemplate")
				end

				local tip_title
				for k, v in pairs(AtlasMaps[zoneID]) do
					if (type(v[2]) == "number") then
						if (v[2] == info_id) then
							tip_title = v[1]
							if (v[3] and v[3] == "item") then
								local itemName = C_Item.GetItemInfo(v[2])
								itemName = itemName or C_Item.GetItemInfo(v[2])

								button.tooltiptitle = itemName or nil
								buttonS.tooltiptitle = itemName or nil
							else
								local _, endpos = strfind(tip_title, ") ")
								if (endpos) then
									button.tooltiptitle = strsub(tip_title, endpos + 1)
									buttonS.tooltiptitle = strsub(tip_title, endpos + 1)
								end
							end
							break
						end
					end
				end
				button:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", info_x + 4, -info_y - 76)
				button:SetID(info_id)
				-- TODO: This will set a letter texture on non-encounter buttons but it should be formatted text because there are some things that are not just letters
				--       The other problem is just restricting it to new maps
				--[[ if (info_id > 10000) then
					button.LetterImage:SetTexture("Interface\\AddOns\\Atlas\\Images\\Atlas_Marks_Letters1");
					if (ATLAS_LETTER_MARKS_TCOORDS["Atlas_Letter_Blue_"..info_mark]) then
						local temp = ATLAS_LETTER_MARKS_TCOORDS["Atlas_Letter_Blue_"..info_mark];
						button.LetterImage:SetTexCoord(temp[1], temp[2], temp[3], temp[4]);
					end
				end ]]
				button:Show()
				buttonS:SetPoint("TOPLEFT", "AtlasFrameSmall", "TOPLEFT", info_x + 4, -info_y - 76)
				buttonS:SetID(info_id)
				buttonS:Show()

				buttonindex = buttonindex + 1
				buttonindexS = buttonindexS + 1
			end

			i = i + 1
		end
	end

	bossbutton = _G["AtlasMapBossButton"..bossindex]
	while bossbutton do
		bossbutton.bgImage:SetTexture(nil)
		bossbutton:Hide()
		bossindex = bossindex + 1
		bossbutton = _G["AtlasMapBossButton"..bossindex]
	end

	bossbuttonS = _G["AtlasMapBossButtonS"..bossindexS]
	while bossbuttonS do
		bossbuttonS.bgImage:SetTexture(nil)
		bossbuttonS:Hide()
		bossindexS = bossindexS + 1
		bossbuttonS = _G["AtlasMapBossButtonS"..bossindexS]
	end

	button = _G["AtlasMapNPCButton"..buttonindex]
	while button do
		button.bgImage:SetTexture(nil)
		button:Hide()
		buttonindex = buttonindex + 1
		button = _G["AtlasMapNPCButton"..buttonindex]
	end

	buttonS = _G["AtlasMapNPCButtonS"..buttonindexS]
	while buttonS do
		buttonS.bgImage:SetTexture(nil)
		buttonS:Hide()
		buttonindexS = buttonindexS + 1
		buttonS = _G["AtlasMapNPCButtonS"..buttonindexS]
	end
end

local function getPlayerText(maxPlayers, maxPlayersH, maxPlayersM, icontext_instance, players)
	local WHIT            = "|cffffffff"
	local playerText      = L["ATLAS_STRING_PLAYERLIMIT"]..L["Colon"]..WHIT
	local icontext_heroic = " |TInterface\\EncounterJournal\\UI-EJ-HeroicTextIcon:0:0|t"
	local icontext_mythic = " |TInterface\\AddOns\\Atlas\\Images\\UI-EJ-MythicTextIcon:0:0|t"

	if ((maxPlayers and maxPlayers ~= 0) or (maxPlayersH and maxPlayersH ~= 0) or (maxPlayersM and maxPlayersM ~= 0)) then
		if (maxPlayers and maxPlayers ~= 0) then
			playerText = playerText..maxPlayers..icontext_instance
		end
		if (maxPlayersH and maxPlayersH ~= 0) then
			local slash = maxPlayers and L["Slash"] or ""
			playerText = playerText..slash..maxPlayersH..icontext_heroic
		end
		if (maxPlayersM and maxPlayersM ~= 0) then
			local slash = maxPlayersH and L["Slash"] or ""
			playerText = playerText..slash..maxPlayersM..icontext_mythic
		end
	else
		if not players or type(players) ~= "table" then return end

		if #players == 1 then
			playerText = format("%s%d", playerText, players[1])
		elseif #players > 1 then
			local text
			for i = 1, #players do
				if i == 1 then
					text = format("%d", players[i])
				else
					text = format("%s%s%d", text, L["Slash"], players[i])
				end
			end
			playerText = playerText..text
		else
			return
		end
	end

	return playerText
end

function Atlas_MapRefresh(mapID)
	local zoneID = mapID or ATLAS_DROPDOWNS[profile.options.dropdowns.module][profile.options.dropdowns.zone]
	if (not zoneID) then
		return
	end
	local data = AtlasMaps
	local base = data[zoneID]
	if (not base) then
		return
	end

	local _
	local typeID, subtypeID, minLevel, maxLevel, minRecLevel, maxRecLevel, maxPlayers, minGearLevel
	local typeIDH, subtypeIDH, minLevelH, maxLevelH, minRecLevelH, maxRecLevelH, maxPlayersH, minGearLevelH
	local typeIDM, subtypeIDM, minLevelM, maxLevelM, minRecLevelM, maxRecLevelM, maxPlayersM, minGearLevelM
	local _RED             = "|cffcc3333"
	local WHIT             = "|cffffffff"
	local colortag, dungeon_difficulty
	local icontext_heroic  = " |TInterface\\EncounterJournal\\UI-EJ-HeroicTextIcon:0:0|t"
	local icontext_mythic  = " |TInterface\\AddOns\\Atlas\\Images\\UI-EJ-MythicTextIcon:0:0|t"
	local icontext_dungeon = "|TInterface\\MINIMAP\\Dungeon:0:0|t"
	local icontext_raid    = "|TInterface\\MINIMAP\\Raid:0:0|t"
	local icontext_instance

	if (base.DungeonID) then
		if (GetLFGDungeonInfo) then
			_, typeID, subtypeID, minLevel, maxLevel, _, minRecLevel, maxRecLevel, _, _, _, _, maxPlayers, _, _, _, _, _, _, minGearLevel = GetLFGDungeonInfo(base.DungeonID)
		end

		-- For some unknown reason, some of the dungeons do not have recommended level range
		if (minRecLevel == 0) then
			minRecLevel = minLevel
		end
		if (maxRecLevel == 0) then
			maxRecLevel = maxLevel
		end
	end
	if (base.DungeonHeroicID) then
		if (GetLFGDungeonInfo) then
			_, typeIDH, subtypeIDH, minLevelH, maxLevelH, _, minRecLevelH, maxRecLevelH, _, _, _, _, maxPlayersH, _, _, _, _, _, _, minGearLevelH = GetLFGDungeonInfo(base.DungeonHeroicID)
		end

		if (minRecLevelH == 0) then
			minRecLevelH = minRecLevel
		end
		if (maxRecLevelH == 0) then
			maxRecLevelH = maxRecLevel
		end
	end
	if (base.DungeonMythicID) then
		if (GetLFGDungeonInfo) then
			_, typeIDM, subtypeIDM, minLevelM, maxLevelM, _, minRecLevelM, maxRecLevelM, _, _, _, _, maxPlayersM, _, _, _, _, _, _, minGearLevelM = GetLFGDungeonInfo(base.DungeonMythicID)
		end

		if (minRecLevelM == 0) then
			minRecLevelM = minRecLevel
		end
		if (maxRecLevelM == 0) then
			maxRecLevelM = maxRecLevel
		end
	end

	if ((typeID and typeID == 2) or (typeIDH and typeIDH == 2) or (typeIDM and typeIDM == 2)) then
		icontext_instance = icontext_raid
	elseif ((typeID and typeID == 1 and subtypeID == 3) or (typeIDH and typeIDH == 1 and subtypeIDH == 3) or (typeIDM and typeIDM == 1 and subtypeIDM == 3)) then
		icontext_instance = icontext_raid
	else
		icontext_instance = icontext_dungeon
	end

	-- Zone Name and Acronym
	local tName = base.ZoneName[1]
	AtlasFrameSmall.ZoneName.Text:SetText(tName)
	AtlasFrame.ZoneName.Text:SetText(tName)
	if (profile.options.frames.showAcronyms and base.Acronym ~= nil) then
		tName = tName.._RED.." ["..base.Acronym.."]"
	end
	AtlasText_ZoneName_Text:SetText(tName)

	-- Map Location
	local tLoc = ""
	if (base.Location) then
		tLoc = L["ATLAS_STRING_LOCATION"]..L["Colon"]..WHIT..base.Location[1]
	end
	AtlasText_Location_Text:SetText(tLoc)

	-- Map's Level Range
	local tLR = ""
	if (minLevel or minLevelH or minLevelM) then
		local tmp_LR = L["ATLAS_STRING_LEVELRANGE"]..L["Colon"]
		if (minLevel) then
			dungeon_difficulty = addon:GetDungeonDifficultyColor(minLevel)
			colortag = addon:FormatColor(dungeon_difficulty)
			if (minLevel ~= maxLevel) then
				tmp_LR = tmp_LR..colortag..minLevel.."-"..maxLevel..icontext_instance
			else
				tmp_LR = tmp_LR..colortag..minLevel..icontext_instance
			end
		end
		if (minLevelH) then
			dungeon_difficulty = addon:GetDungeonDifficultyColor(minLevelH)
			colortag = addon:FormatColor(dungeon_difficulty)
			local slash
			if (minLevel) then
				slash = L["Slash"]
			else
				slash = ""
			end
			if (minLevelH ~= maxLevelH) then
				tmp_LR = tmp_LR..slash..colortag..minLevelH.."-"..maxLevelH..icontext_heroic
			else
				tmp_LR = tmp_LR..slash..colortag..minLevelH..icontext_heroic
			end
		end
		if (minLevelM) then
			dungeon_difficulty = addon:GetDungeonDifficultyColor(minLevelM)
			colortag = addon:FormatColor(dungeon_difficulty)
			local slash
			if (minLevelH) then
				slash = L["Slash"]
			else
				slash = ""
			end
			if (minLevelM ~= maxLevelM) then
				tmp_LR = tmp_LR..slash..colortag..minLevelM.."-"..maxLevelM..icontext_mythic
			else
				tmp_LR = tmp_LR..slash..colortag..minLevelM..icontext_mythic
			end
		end
		tLR = tmp_LR
	elseif (base.LevelRange) then
		tLR = L["ATLAS_STRING_LEVELRANGE"]..L["Colon"]..WHIT..base.LevelRange
	end
	AtlasText_LevelRange_Text:SetText(tLR)

	-- Map's Recommended Level Range
	if (WoWRetail or WoWClassic) then
		local tRLR = ""
		if (minRecLevel or minRecLevelH or minRecLevelM) then
			local tmp_RLR = L["ATLAS_STRING_RECLEVELRANGE"]..L["Colon"]
			if (minRecLevel) then
				dungeon_difficulty = addon:GetDungeonDifficultyColor(minRecLevel)
				colortag = addon:FormatColor(dungeon_difficulty)
				if (minRecLevel ~= maxRecLevel) then
					tmp_RLR = tmp_RLR..colortag..minRecLevel.."-"..maxRecLevel..icontext_instance
				else
					tmp_RLR = tmp_RLR..colortag..minRecLevel..icontext_instance
				end
			end
			if (minRecLevelH) then
				dungeon_difficulty = addon:GetDungeonDifficultyColor(minRecLevelH)
				colortag = addon:FormatColor(dungeon_difficulty)
				local slash
				if (minRecLevel) then
					slash = L["Slash"]
				else
					slash = ""
				end
				if (minRecLevelH ~= maxRecLevelH) then
					tmp_RLR = tmp_RLR..slash..colortag..minRecLevelH.."-"..maxRecLevelH..icontext_heroic
				else
					tmp_RLR = tmp_RLR..slash..colortag..minRecLevelH..icontext_heroic
				end
			end
			if (minRecLevelM) then
				dungeon_difficulty = addon:GetDungeonDifficultyColor(minRecLevelM)
				colortag = addon:FormatColor(dungeon_difficulty)
				local slash
				if (minRecLevelH) then
					slash = L["Slash"]
				else
					slash = ""
				end
				if (minRecLevelM ~= maxRecLevelM) then
					tmp_RLR = tmp_RLR..slash..colortag..minRecLevelM.."-"..maxRecLevelM..icontext_mythic
				else
					tmp_RLR = tmp_RLR..slash..colortag..minRecLevelM..icontext_mythic
				end
			end
			tRLR = tmp_RLR
		elseif (base.LevelRange) then
			tRLR = L["ATLAS_STRING_RECLEVELRANGE"]..L["Colon"]..WHIT..base.LevelRange
		end
		AtlasText_RecommendedRange_Text:SetText(tRLR)
	end

	-- Map's Minimum Level
	local tML = ""
	if (minLevel or minLevelH or minLevelM) then
		tML = L["ATLAS_STRING_MINLEVEL"]..L["Colon"]
		if (minLevel) then
			dungeon_difficulty = addon:GetDungeonDifficultyColor(minLevel)
			colortag = addon:FormatColor(dungeon_difficulty)
			tML = tML..colortag..minLevel..icontext_instance
		end
		if (minLevelH) then
			dungeon_difficulty = addon:GetDungeonDifficultyColor(minLevelH)
			colortag = addon:FormatColor(dungeon_difficulty)
			local slash
			if (minLevel) then
				slash = L["Slash"]
			else
				slash = ""
			end
			tML = tML..slash..colortag..minLevelH..icontext_heroic
		end
		if (minLevelM) then
			dungeon_difficulty = addon:GetDungeonDifficultyColor(minLevelM)
			colortag = addon:FormatColor(dungeon_difficulty)
			local slash
			if (minLevelH) then
				slash = L["Slash"]
			else
				slash = ""
			end
			tML = tML..slash..colortag..minLevelM..icontext_mythic
		end
	elseif (base.MinLevel) then
		tML = L["ATLAS_STRING_MINLEVEL"]..L["Colon"]..WHIT..base.MinLevel
	end
	AtlasText_MinLevel_Text:SetText(tML)

	-- Player Limit
	local tPL = getPlayerText(maxPlayers, maxPlayersH, maxPlayersM, icontext_instance, base.PlayerLimit) or ""

	AtlasText_PlayerLimit_Text:SetText(tPL)

	-- Map's Minimum Gear Level for player
	local tMGL = ""
	local iLFGhasGearInfo = checkInstanceHasGearLevel()

	if (iLFGhasGearInfo) then
		tMGL = L["ATLAS_STRING_MINGEARLEVEL"]..L["Colon"]
		if (minGearLevel and minGearLevel ~= 0) then
			local itemDiff, gearcolortag

			itemDiff = getGearItemLevelDiffColor(minGearLevel)
			gearcolortag = addon:FormatColor(itemDiff)
			tMGL = tMGL..gearcolortag..minGearLevel..icontext_instance
		end
		if (minGearLevelH and minGearLevelH ~= 0) then
			local itemDiff, gearcolortag, slash

			itemDiff = getGearItemLevelDiffColor(minGearLevelH)
			gearcolortag = addon:FormatColor(itemDiff)
			if (base.DungeonID and minGearLevel ~= 0) then
				slash = L["Slash"]
			else
				slash = ""
			end
			tMGL = tMGL..WHIT..slash..gearcolortag..minGearLevelH..icontext_heroic
		end
		if (minGearLevelM and minGearLevelM ~= 0) then
			local itemDiff, gearcolortag, slash

			itemDiff = getGearItemLevelDiffColor(minGearLevelM)
			gearcolortag = addon:FormatColor(itemDiff)
			if ((base.DungeonID and minGearLevel ~= 0) or (base.DungeonHeroicID and minGearLevelH ~= 0)) then
				slash = L["Slash"]
			else
				slash = ""
			end
			tMGL = tMGL..WHIT..slash..gearcolortag..minGearLevelM..icontext_mythic
		end
	else
		if (base.MinGearLevel) then
			local itemDiff, gearcolortag

			itemDiff = getGearItemLevelDiffColor(base.MinGearLevel)
			gearcolortag = addon:FormatColor(itemDiff)
			tMGL = L["ATLAS_STRING_MINGEARLEVEL"]..L["Colon"]..gearcolortag..base.MinGearLevel
		end
	end
	AtlasText_MinGearLevel_Text:SetText(tMGL)

	-- AtlasLoot supports
	addon:EnableAtlasLootButton(base, zoneID)

	-- Check if Journal Encounter Instance is available
	if (base.JournalInstanceID) then
		AtlasFrame.AdventureJournal.instanceID = base.JournalInstanceID
		AtlasFrameSmall.AdventureJournal.instanceID = base.JournalInstanceID
		if (WoWClassic or WoWRetail) then
			AtlasFrameAdventureJournalButton:Show()
			AtlasFrameSmallAdventureJournalButton:Show()
			Atlas_SetEJBackground(base.JournalInstanceID)
		else
			AtlasFrameAdventureJournalButton:Hide()
			AtlasFrameSmallAdventureJournalButton:Hide()
			Atlas_SetEJBackground()
		end
	else
		AtlasFrameAdventureJournalButton:Hide()
		AtlasFrameSmallAdventureJournalButton:Hide()
		Atlas_SetEJBackground()
	end

	-- Check if WorldMap ID is available, if so, show the map button
	if (base.WorldMapID) then
		AtlasFrame.AdventureJournalMap.mapID = base.WorldMapID
		AtlasFrameSmall.AdventureJournalMap.mapID = base.WorldMapID
		if (WoWClassic or WoWRetail) then
			AtlasFrameAdventureJournalMapButton:Show()
			AtlasFrameSmallAdventureJournalMapButton:Show()
		end
	else
		AtlasFrameAdventureJournalMapButton:Hide()
		AtlasFrameSmallAdventureJournalMapButton:Hide()
	end

	-- Check if DungeonLevel ID is available
	if (base.DungeonLevel) then
		AtlasFrame.AdventureJournalMap.dungeonLevel = base.DungeonLevel
		AtlasFrameSmall.AdventureJournalMap.dungeonLevel = base.DungeonLevel
	end

	-- Searching for the map path from Atlas or from plugins
	local AtlasMapPath
	for k, v in pairs(Atlas_CoreMapsKey) do
		-- If selected map is Atlas' core map
		if (zoneID == v) then
			if (base.Module) then
				-- if the map belong to a module, set the path to module
				AtlasMapPath = "Interface\\AddOns\\Atlas\\Images\\"..base.Module.."\\"
				break
			end
		end
	end
	-- Check if selected map is from plugin
	if (not AtlasMapPath) then
		-- Searching for plugins
		for ka, va in pairs(ATLAS_PLUGINS) do
			-- Searching for plugin's maps
			for kb, vb in pairs(ATLAS_PLUGINS[ka]) do
				if (zoneID == vb) then
					AtlasMapPath = "Interface\\AddOns\\"..ka.."\\Images\\"
					break
				end
			end
			if (AtlasMapPath) then break; end
		end
	end

	if (AtlasMapPath) then
		AtlasMap:SetTexture(AtlasMapPath..zoneID)
		AtlasMapSmall:SetTexture(AtlasMapPath..zoneID)
	end

	-- Check if the map image is available, if not replace with black and Map Not Found text
	if (not GetFileIDFromPath(AtlasMapPath..zoneID)) then
		AtlasMap:SetColorTexture(0, 0, 0);
		AtlasMap_Text:SetText(L["MapNotYetAvailable"])
		AtlasMapSmall:SetColorTexture(0, 0, 0);
		AtlasMapS_Text:SetText(L["MapNotYetAvailable"])
		AtlasMap_Text:Show()
		AtlasMapS_Text:Show()
	else
		AtlasMap_Text:Hide()
		AtlasMapS_Text:Hide()
	end

	-- The boss description to be added here
	addon:MapAddNPCButton()

	-- LFG Button
	if (WoWClassicEra and C_LFGList.IsPremadeGroupFinderEnabled() and (base.ActivityID or base.ActivityIDSoD)) then
		AtlasFrameLFGButton:Show();

		if (C_Seasons.GetActiveSeason() == 2 and base.ActivityIDSoD) then
			AtlasFrameLFGButton.ActivityID = base.ActivityIDSoD;
		elseif (base.ActivityID) then
			AtlasFrameLFGButton.ActivityID = base.ActivityID;
		end
	else
		AtlasFrameLFGButton:Hide();
	end
end

-- Refreshes the Atlas frame, usually because a new map needs to be displayed
-- The zoneID variable represents the internal name used for each map, ex: "BlackfathomDeeps"
-- Also responsible for updating all the text when a map is changed
function Atlas_Refresh(mapID)
	if (ATLAS_MODULE_MENUS == 0 and ATLAS_PLUGIN_MENUS == 0) then return end
	local zoneID
	local cat = profile.options.dropdowns.module
	local zone = profile.options.dropdowns.zone
	if (mapID) then
		zoneID = mapID
	elseif (ATLAS_DROPDOWNS[cat] and ATLAS_DROPDOWNS[cat][zone]) then
		zoneID = ATLAS_DROPDOWNS[cat][zone]
	end
	if (not zoneID) then
		return
	end
	local data = AtlasMaps
	local base = data[zoneID]
	if (not base) then
		return
	end

	if WoWRetail then
		if (AtlasEJLootFrame:IsShown()) then
			AtlasEJLootFrame:Hide()
		end
	end
	Atlas_MapRefresh()

	ATLAS_DATA = base
	ATLAS_SEARCH_METHOD = data.Search and data.Search or simpleSearch

	-- Populate the scroll frame entries list, the update func will do the rest
	searchText("")
	AtlasSearchEditBox:SetText("")
	AtlasSearchEditBox:ClearFocus()

	Atlas_ScrollBar_Update()

	-- Deal with the switch to entrance/instance button here
	-- Only display if appropriate
	-- See if we should display the button or not, and decide what it should say
	local matches = {}
	local defaultText

	if addon.assocs.EntToInstMatches[zoneID] then
		matches = addon.assocs.EntToInstMatches[zoneID]
		defaultText = ATLAS_INSTANCE_BUTTON
	elseif addon.assocs.InstToEntMatches[zoneID] then
		matches = addon.assocs.InstToEntMatches[zoneID]
		defaultText = ATLAS_ENTRANCE_BUTTON
	end

	sort(matches, sortZonesAlpha)

	if (#matches > 1) then
		local function GeneratorFunction(dropdown, rootDescription)
			for key, match in ipairs(matches) do
				rootDescription:CreateButton(AtlasMaps[match].ZoneName[1], AtlasSwitch_OnSet, match)
			end
		end

		AtlasFrameSwitchDropdown:SetDefaultText(defaultText);
		AtlasFrameSwitchDropdown:SetupMenu(GeneratorFunction);
		AtlasFrameSwitchDropdown:Show();
		AtlasFrameSwitchButton:Hide();
		AtlasFrameSmallSwitchDropdown:SetDefaultText(defaultText);
		AtlasFrameSmallSwitchDropdown:SetupMenu(GeneratorFunction);
		AtlasFrameSmallSwitchDropdown:Show();
		AtlasFrameSmallSwitchButton:Hide();
	end

	if (#matches == 1) then
		AtlasFrameSwitchButton:SetText(defaultText)
		AtlasFrameSwitchButton:SetScript("OnClick", function() AtlasSwitch_OnSet(matches[1]) end)
		AtlasFrameSwitchButton:Show();
		AtlasFrameSwitchDropdown:Hide();
		AtlasFrameSmallSwitchButton:SetText(defaultText)
		AtlasFrameSmallSwitchButton:SetScript("OnClick", function() AtlasSwitch_OnSet(matches[1]) end)
		AtlasFrameSmallSwitchButton:Show();
		AtlasFrameSmallSwitchDropdown:Hide();
	end

	if (#matches == 0) then
		AtlasFrameSwitchButton:Hide();
		AtlasFrameSwitchDropdown:Hide();
		AtlasFrameSmallSwitchButton:Hide();
		AtlasFrameSmallSwitchDropdown:Hide();
	end

	-- Below try to add the series maps into switch button's map list
	--[[ if addon.assocs.MapSeries[zoneID] then
		local function IsSelected(index) return index == ATLAS_DROPDOWNS[addon.db.profile.options.dropdowns.module][addon.db.profile.options.dropdowns.zone]; end
		local function SetSelection(index)
			AtlasSwitch_OnSet(index);
		end

		local function GeneratorFunction(dropdown, rootDescription)
			for key, match in ipairs(addon.assocs.MapSeries[zoneID]) do
				rootDescription:CreateRadio(AtlasMaps[match].ZoneName[1], IsSelected, SetSelection, match)
			end
		end

		AtlasPrevNextDropdown:SetupMenu(GeneratorFunction);
	end ]]

	-- Handle the Prev / Next Map buttons' showing or hiding
	if (base.NextMap or base.PrevMap) then
		AtlasFramePrevNextContainer:Show()
		AtlasFrameSmallPrevNextContainer:Show()
	else
		AtlasFramePrevNextContainer:Hide()
		AtlasFrameSmallPrevNextContainer:Hide()
	end

	if (base.NextMap) then
		AtlasFramePrevNextContainer.NextMap:Enable()
		AtlasFramePrevNextContainer.NextMap.mapID = base.NextMap
		AtlasFrameSmallPrevNextContainer.NextMap:Enable()
		AtlasFrameSmallPrevNextContainer.NextMap.mapID = base.NextMap
	else
		AtlasFramePrevNextContainer.NextMap:Disable()
		AtlasFrameSmallPrevNextContainer.NextMap:Disable()
	end

	if (base.PrevMap) then
		AtlasFramePrevNextContainer.PrevMap:Enable()
		AtlasFramePrevNextContainer.PrevMap.mapID = base.PrevMap
		AtlasFrameSmallPrevNextContainer.PrevMap:Enable()
		AtlasFrameSmallPrevNextContainer.PrevMap.mapID = base.PrevMap
	else
		AtlasFramePrevNextContainer.PrevMap:Disable()
		AtlasFrameSmallPrevNextContainer.PrevMap:Disable()
	end
end

-- Modifies the value of GetRealZoneText to account for some naming conventions
-- Always use this function instead of GetRealZoneText within Atlas
local function getFixedZoneText()
	local currentZone = GetRealZoneText()
	if (AtlasZoneSubstitutions[currentZone]) then
		return AtlasZoneSubstitutions[currentZone]
	end
	return currentZone
end

-- Checks the player's current location against all Atlas maps
-- If a match is found display that map right away
-- update for Outland zones contributed by Drahcir
-- 3/23/08 now takes SubZones into account as well
function Atlas_AutoSelect()
	local currentZone = getFixedZoneText()
	local currentSubZone = GetSubZoneText()
	local zoneID = ATLAS_DROPDOWNS[profile.options.dropdowns.module] and ATLAS_DROPDOWNS[profile.options.dropdowns.module][profile.options.dropdowns.zone] or ATLAS_DROPDOWNS[1][1]
	debug("Using auto-select to open the best map.")

	-- Check if the current zone is defined in AssocDefaults table
	-- If yes, means there could be multiple maps for this zone
	-- And we will choose a proper one to be the default one.
	debug("currentZone: "..currentZone..", currentSubZone: "..currentSubZone)
	if (addon.assocs.AssocDefaults[currentZone]) then
		debug("currentZone: "..currentZone.." matched the one defined in AssocDefaults{}.")
		local selected_map
		if (addon.assocs.SubZoneData[currentZone]) then
			for k_instance_map, v_instance_map in pairs(addon.assocs.SubZoneData[currentZone]) do
				for k_subzone, v_subzone in pairs(addon.assocs.SubZoneData[currentZone][k_instance_map]) do
					if (v_subzone == currentSubZone) then
						selected_map = k_instance_map
						debug("currentSubZone: "..currentSubZone.." matched found, now we will use map: \""..selected_map.."\" for instance: "..currentZone)
						break
					end
				end
				if (selected_map) then break; end
			end
		end
		if (not selected_map) then
			debug("No subzone matched, now checking if we should specify a default map.")
			if (zoneID and currentZone == addon.assocs.SubZoneAssoc[zoneID]) then
				debug("You're in the same instance as the former map. Doing nothing.")
				return
			else
				selected_map = addon.assocs.AssocDefaults[currentZone]
				debug("We will use the map: "..selected_map.." for the current zone: "..currentZone..".")
			end
		end
		debug("Selecting the map...")
		for k_DropDownType, v_DropDownType in pairs(ATLAS_DROPDOWNS) do
			for k_DropDownZone, v_DropDownZone in pairs(v_DropDownType) do
				if (selected_map == v_DropDownZone) then
					profile.options.dropdowns.module = k_DropDownType
					profile.options.dropdowns.zone = k_DropDownZone
					Atlas_Refresh()
					zoneID = ATLAS_DROPDOWNS[profile.options.dropdowns.module][profile.options.dropdowns.zone]
					debug("Map selected! Type: "..k_DropDownType..", Zone: "..k_DropDownZone..", "..zoneID)
					return
				end
			end
		end
	else
		debug("SubZone data isn't relevant here. Checking if it's outdoor zone.")
		if (addon.assocs.OutdoorZoneToAtlas[currentZone]) then
			debug("This world zone "..currentZone.." is associated with a map.")
			local targetZone = addon.assocs.OutdoorZoneToAtlas[currentZone]
			for k_DropDownType, v_DropDownType in pairs(ATLAS_DROPDOWNS) do
				for k_DropDownZone, v_DropDownZone in pairs(v_DropDownType) do
					if (targetZone == v_DropDownZone) then
						profile.options.dropdowns.module = k_DropDownType
						profile.options.dropdowns.zone = k_DropDownZone
						Atlas_Refresh()
						zoneID = ATLAS_DROPDOWNS[profile.options.dropdowns.module][profile.options.dropdowns.zone]
						debug("Map changed to the associated map: "..zoneID)
						return
					end
				end
			end
			debug("Checking if instance/entrance pair can be found.")
		elseif (zoneID and addon.assocs.InstToEntMatches[zoneID]) then
			for ka, va in pairs(addon.assocs.InstToEntMatches[zoneID]) do
				if (currentZone == AtlasMaps[va].ZoneName[1]) then
					debug("Instance/entrance pair found. Doing nothing.")
					return
				end
			end
		elseif (zoneID and addon.assocs.EntToInstMatches[zoneID]) then
			for ka, va in pairs(addon.assocs.EntToInstMatches[zoneID]) do
				if (currentZone == AtlasMaps[va].ZoneName[1]) then
					debug("Instance/entrance pair found. Doing nothing.")
					return
				end
			end
		end
		debug("Searching through all maps for a ZoneName match.")
		for k_DropDownType, v_DropDownType in pairs(ATLAS_DROPDOWNS) do
			for k_DropDownZone, v_DropDownZone in pairs(v_DropDownType) do
				-- Compare the currentZone to the new substr of ZoneName
				if (AtlasMaps[v_DropDownZone] and AtlasMaps[v_DropDownZone].ZoneName[1] and
						(currentZone == strsub(AtlasMaps[v_DropDownZone].ZoneName[1], strlen(AtlasMaps[v_DropDownZone].ZoneName[1]) - strlen(currentZone) + 1))
					) then
					profile.options.dropdowns.module = k_DropDownType
					profile.options.dropdowns.zone = k_DropDownZone
					Atlas_Refresh()
					debug("Found a match. Map has been changed.")
					return
				end
			end
		end
	end
	debug("Nothing changed because no match was found.")
end

function addon:DungeonMinGearLevelToolTip(self)
	if (WoWClassicEra or WoWClassic) then return end
	local currGearLevel = GetAverageItemLevel()
	local str = format(ITEM_LEVEL, currGearLevel)

	local zoneID = ATLAS_DROPDOWNS[profile.options.dropdowns.module][profile.options.dropdowns.zone]
	if (not zoneID) then
		return
	end
	local data = AtlasMaps
	local base = data[zoneID]

	if (checkInstanceHasGearLevel() or base.MinGearLevel) then
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:SetText(str, 1, 1, 1, nil, 1)
		GameTooltip:AddLine(STAT_AVERAGE_ITEM_LEVEL_TOOLTIP)
		GameTooltip:Show()
	end
end

-- In Development, this could be fun
function Atlas_SetEJBackground(instanceID)
	--[[	local f = _G["AtlasEJBackground"]
	if (not f) then
		f = CreateFrame("Frame", "AtlasEJBackground", AtlasFrame)
	end
	f:ClearAllPoints()
	f:SetWidth(625)
	f:SetHeight(471)
	f:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 530, -85)
	--f:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 550, -220)
	if (instanceID) then
		local t = f:CreateTexture(nil,"BACKGROUND")
		local name, description, bgImage, buttonImage, loreImage, dungeonAreaMapID, link = EJ_GetInstanceInfo(instanceID)
		t:SetTexture(bgImage)
		t:SetTexCoord(0.1, 0.7, 0.1, 0.7)
		t:SetAllPoints()
		f.Texture = t
		f:Show()
	else
		local t = f:CreateTexture(nil,"BACKGROUND")
		t:SetTexture(nil)
		t:SetAllPoints()
		f.Texture = t
		--f:Hide()
		t:SetColorTexture(0.5, 0.5, 0.5, 0.5)
	end
]]
end

function addon:CheckAddonStatus(addonName)
	if not addonName then return nil end
	local loadable = select(4, C_AddOns.GetAddOnInfo(addonName))
	local enabled = C_AddOns.GetAddOnEnableState(addonName, UnitName("player"))
	if (enabled > 0 and loadable) then
		return true
	else
		return false
	end
end

-- ///////////////////////////////////////////////////////
function addon:OnInitialize()
	self.db = AceDB:New("AtlasDB", addon.constants.defaults, true)

	profile = self.db.profile

	minimapButton:Register("Atlas", LDB, self.db.profile.minimap)
	self:RegisterChatCommand("atlasbutton", Atlas_ButtonToggle2)
	self:RegisterChatCommand("atlas", Atlas_Toggle)

	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")

	-- Make the Atlas window go all the way to the edge of the screen, exactly
	AtlasFrame:SetClampRectInsets(12, 0, -12, 0)
	AtlasFrameSmall:SetClampRectInsets(12, 0, -12, 0)

	ATLAS_MAX_MENUITEMS = profile.options.dropdowns.maxItems or ATLAS_MAX_MENUITEMS

	-- Populate the dropdown lists...yeeeah this is so much nicer!
	addon:PopulateDropdowns()

	if (not ATLAS_DROPDOWNS[profile.options.dropdowns.module]) then
		ATLAS_OLD_TYPE = profile.options.dropdowns.module
		ATLAS_OLD_ZONE = profile.options.dropdowns.zone
	end

	-- Now that saved variables have been loaded, update everything accordingly
	addon:UpdateLock()
	addon:UpdateAlpha()
	addon:UpdateSmallAlpha()
	addon:UpdateScale()
	addon:UpdateSmallScale()
	AtlasFrame:SetClampedToScreen(profile.options.frames.clamp)
	AtlasFrameSmall:SetClampedToScreen(profile.options.frames.clamp)

	if (profile.options.worldMapButton) then
		addon.WorldMap.Button:Show()
	else
		addon.WorldMap.Button:Hide()
	end

	self:SetupOptions()
end

function addon:OnEnable()
	for k, v in pairs(self.modules) do
		registerModule(k)
	end

	-- Register for events
	self:RegisterEvent("BOSS_KILL");

	AtlasFrame:SetPortraitToAsset("Interface\\WorldMap\\WorldMap-Icon");
	AtlasFrame:SetTitle(ATLAS_TITLE_VERSION);
	AtlasFrameSmall:SetPortraitToAsset("Interface\\WorldMap\\WorldMap-Icon");
	AtlasFrameSmall:SetTitle(ATLAS_TITLE_VERSION);
	AtlasFrameSmallCloseButton:SetPropagateMouseMotion(true)

	-- On retail, adjust the position of the lock button
	if (WoWRetail) then
		AtlasFrameLockButton:SetPoint("RIGHT", "AtlasFrameCloseButton", "LEFT", 6, 0)
		AtlasFrameSmallLockButton:SetPoint("RIGHT", "AtlasFrameSmallCloseButton", "LEFT", 6, 0)
	end

	-- Create scroll frame
	local ScrollBox = CreateFrame("Frame", nil, AtlasFrameBottomInset, "WowScrollBoxList")
	ScrollBox:SetPoint("TOPLEFT", 15, -5)
	ScrollBox:SetSize(456, 389)

	local ScrollBar
	if WoWRetail then
		ScrollBar = CreateFrame("EventFrame", nil, AtlasFrameBottomInset, "MinimalScrollBar")
		ScrollBar:SetPoint("TOPLEFT", ScrollBox, "TOPRIGHT")
		ScrollBar:SetPoint("BOTTOMLEFT", ScrollBox, "BOTTOMRIGHT")
	else
		ScrollBar = CreateFrame("EventFrame", nil, AtlasFrameBottomInset, "WowClassicScrollBar")
		ScrollBar:SetPoint("TOPLEFT", ScrollBox, "TOPRIGHT", -3, 6)
		ScrollBar:SetPoint("BOTTOMLEFT", ScrollBox, "BOTTOMRIGHT", -3, -7)
	end

	local ScrollView = CreateScrollBoxListLinearView()

	ScrollUtil.InitScrollBoxListWithScrollBar(ScrollBox, ScrollBar, ScrollView)

	local function Initializer(frame, data)
		frame.data = data.data
		frame:Init(data.data)
	end

	local function CustomFactory(factory, data)
		local template = "Atlas"..data.type.."EntryTemplate"
		factory(template, Initializer)
	end

	ScrollView:SetElementFactory(CustomFactory)

	ScrollBar:SetHideIfUnscrollable(true)

	local DataProvider = CreateDataProvider()
	ScrollView:SetDataProvider(DataProvider)

	AtlasFrameBottomInset.ScrollBox = ScrollBox

	-- Initial data fetch
	Atlas_Refresh()
end

function addon:Refresh()
	profile = self.db.profile

	ATLAS_MAX_MENUITEMS = profile.options.dropdowns.maxItems or ATLAS_MAX_MENUITEMS
	addon:PopulateDropdowns()
	Atlas_Refresh()
	AtlasFrameDropDownType_OnShow()
	AtlasFrameDropDown_OnShow()
	addon:UpdateLock()
	addon:UpdateAlpha()
	addon:UpdateSmallAlpha()
	addon:UpdateScale()
	addon:UpdateSmallScale()
	AtlasFrame:SetClampedToScreen(profile.options.frames.clamp)
	AtlasFrameSmall:SetClampedToScreen(profile.options.frames.clamp)
	if (profile.options.worldMapButton) then
		addon.WorldMap.Button:Show()
	else
		addon.WorldMap.Button:Hide()
	end
end

function addon:BOSS_KILL(_, encounterID)
	local zoneID = ATLAS_DROPDOWNS[profile.options.dropdowns.module][profile.options.dropdowns.zone]
	local t = AtlasMaps_NPC_DB[zoneID]
	local i = 1
	if (t) then
		while (t[i]) do
			local button = _G["AtlasMapBossButton"..i]
			if button and button.DefeatedOpacity then
				local complete = C_EncounterJournal.IsEncounterComplete(button.encounterID);
				button.DefeatedOpacity:SetShown(complete);
				button.DefeatedOverlay:SetShown(complete);
				button.bgImage:SetDesaturation(complete and 0.7 or 0);
			end

			button = _G["AtlasMapBossButtonS"..i]
			if button and button.DefeatedOpacity then
				local complete = C_EncounterJournal.IsEncounterComplete(button.encounterID);
				button.DefeatedOpacity:SetShown(complete);
				button.DefeatedOverlay:SetShown(complete);
				button.bgImage:SetDesaturation(complete and 0.7 or 0);
			end

			i = i + 1
		end
	end

	-- TODO: replace boss image in list with an X when defeated
end

-- $Id: Core.lua 154 2022-11-12 11:59:17Z arithmandar $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local select = _G.select
local pairs = _G.pairs
local math = _G.math
local ceil = math.ceil
-- Libraries
local GetProfessions = _G.GetProfessions
local GameTooltip, GetAddOnInfo, GetAddOnEnableState, UnitName, PlaySound, GetCVarBool, SetCVar = _G.GameTooltip, _G.GetAddOnInfo, _G.GetAddOnEnableState, _G.UnitName, _G.PlaySound, _G.GetCVarBool, _G.SetCVar
local WorldMapTrackingOptionsDropDown_OnClick
local GetBuildInfo = _G.GetBuildInfo


-- Determine WoW TOC Version
local WoWClassicEra, WoWClassicTBC, WoWWOTLKC, WoWRetail
local wowversion  = select(4, GetBuildInfo())
if wowversion < 20000 then
	WoWClassicEra = true
elseif wowversion < 30000 then 
	WoWClassicTBC = true
elseif wowversion < 40000 then 
	WoWWOTLKC = true
elseif wowversion > 90000 then
	WoWRetail = true
else
	-- n/a
end

if (WoWClassicEra or WoWClassicTBC or WoWWOTLKC) then
	-- do nothing
else
	WorldMapTrackingOptionsDropDown_OnClick = _G.WorldMapTrackingOptionsDropDown_OnClick
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
local AceDB = LibStub("AceDB-3.0")
-- UIDropDownMenu
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

local addon = LibStub("AceAddon-3.0"):NewAddon(private.addon_name, "AceEvent-3.0")
addon.constants = private.constants
addon.constants.addon_name = private.addon_name
addon.Name = FOLDER_NAME
local _
_, addon.LocName, addon.Notes = GetAddOnInfo(addon.Name)
addon.LocName = L["WorldMapTrackingEnhanced"]
-- ToC Metadata
addon.Version 		= GetAddOnMetadata(addon.Name, "Version")
addon.UpdateDate 	= GetAddOnMetadata(addon.Name, "X-Date")
addon.Author 		= GetAddOnMetadata(addon.Name, "Author")
--addon.LocName = select(2, GetAddOnInfo(addon.Name))
--addon.Notes = select(3, GetAddOnInfo(addon.Name))

addon.plugins = {}
_G.WorldMapTrackingEnhanced = addon
local profile
local FilterButton -- WorldMapFrame.overlayFrames[2]
local iMaxMenu = 20 -- Maximum number of dropdown menu item

local function checkAddonStatus(addonName)
	if not addonName then return nil end
	local loadable = select(4, GetAddOnInfo(addonName))
	local enabled = GetAddOnEnableState(UnitName("player"), addonName)
	if (enabled > 0 and loadable) then
		return true
	else
		return false
	end
end

WMTEButtonMixin = {}

function WMTEButtonMixin:OnLoad()
	local function InitializeDropDown(self, level)
		self:GetParent():InitializeDropDown(self.DropDown, level);
	end
	local name = addon.Name.."Button"
	self.DropDown = LibDD:Create_UIDropDownMenu(name.."DropDown", self)
	self.DropDown:SetClampedToScreen(true)
	
	if (WoWRetail) then
		self:SetFrameStrata("HIGH")
	else
		self:SetFrameStrata("TOOLTIP")
	end
	
	LibDD:UIDropDownMenu_SetInitializeFunction(self.DropDown, InitializeDropDown);
	LibDD:UIDropDownMenu_SetDisplayMode(self.DropDown, "MENU");
end

function WMTEButtonMixin:OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
	GameTooltip:SetText(TRACKING, 1, 1, 1)
	GameTooltip:AddLine(MINIMAP_TRACKING_TOOLTIP_NONE, nil, nil, nil, true)
	GameTooltip:Show()
end

function WMTEButtonMixin:OnLeave()
	GameTooltip:Hide()
end

function WMTEButtonMixin:OnClick()
	local parent = self:GetParent()
	local mapID = WorldMapFrame:GetMapID()
	if not mapID then
		return
	end
	self.DropDown.mapID = mapID or 0
	LibDD:ToggleDropDownMenu(1, nil, self.DropDown, self, 0, -5)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end

function WMTEButtonMixin:OnMouseDown(button)
	self.Icon:SetPoint("TOPLEFT", 8, -8)
	self.IconOverlay:Show()
end

function WMTEButtonMixin:OnMouseUp()
	self.Icon:SetPoint("TOPLEFT", 6, -6)
	self.IconOverlay:Hide()
end

function WMTEButtonMixin:IsTrackingFilter(filter)
	return not C_Minimap.IsFilteredOut(filter);
end

function WMTEButtonMixin:SetTrackingFilter(filter, on)
	local count = C_Minimap.GetNumTrackingTypes();
	for id=1, count do
		local filterInfo = C_Minimap.GetTrackingFilter(id);
		if filterInfo and filterInfo.filterID == filter then
			C_Minimap.SetTracking(id, on);
			return;
		end
	end
end

function WMTEButtonMixin:OnSelection(value, checked)
	if (WoWClassicEra or WoWClassicTBC or WoWWOTLKC) then
		-- do nothing
	else
		if (checked) then
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		else
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
		end

		if (value == "quests") then
			SetCVar("questPOI", checked and "1" or "0");
		elseif (value == "dungeon entrances") then
			SetCVar("showDungeonEntrancesOnMap", checked and "1" or "0");
		elseif (value == "digsites") then
			SetCVar("digSites", checked and "1" or "0");
			self:SetTrackingFilter(Enum.MinimapTrackingFilter.Digsites, checked);
		elseif (value == "tamers") then
			SetCVar("showTamers", checked and "1" or "0");
		elseif (value == "primaryProfessionsFilter" or value == "secondaryProfessionsFilter") then
			SetCVar(value, checked and "1" or "0")
		elseif (value == "worldQuestFilterResources" or value == "worldQuestFilterArtifactPower" or
				value == "worldQuestFilterProfessionMaterials" or value == "worldQuestFilterGold" or
				value == "worldQuestFilterEquipment" or value == "worldQuestFilterReputation" or
				value == "worldQuestFilterAnima") then
			-- World quest reward filter cvars
			SetCVar(value, checked and "1" or "0")
		elseif (value == "trivialQuests") then
			self:SetTrackingFilter(Enum.MinimapTrackingFilter.TrivialQuests, checked);
		end
		FilterButton:GetParent():RefreshAllDataProviders()
	end
end

-- //////////////////////////////////////////////////////////////////////////
-- Main function to replace World Map Tracking Option's dropdown menu
-- //////////////////////////////////////////////////////////////////////////
function WMTEButtonMixin:InitializeDropDown(frame, level)
	local function OnSelection(button)
		self:OnSelection(button.value, button.checked)
	end
	
	local function AddSeparator()
		if (profile.useSeparator) then
			LibDD:UIDropDownMenu_AddSeparator(1)
		end
	end

	if not level then level = 1 end
	local info = LibDD:UIDropDownMenu_CreateInfo()

	if (level == 1) then
		info.isTitle = true
		info.notCheckable = true
		info.text = WORLD_MAP_FILTER_TITLE -- which is "Show:"
		LibDD:UIDropDownMenu_AddButton(info)

		info.isTitle = nil
		info.disabled = nil
		info.notCheckable = nil
		info.isNotRadio = true
		info.keepShownOnClick = true
		info.func = OnSelection

		info.text = SHOW_QUEST_OBJECTIVES_ON_MAP_TEXT
		info.value = "quests"
		info.checked = GetCVarBool("questPOI")
		LibDD:UIDropDownMenu_AddButton(info)

		-- currently it looks like below three features are only available in Retail server
		if (WoWRetail) then
			info.text = SHOW_DUNGEON_ENTRACES_ON_MAP_TEXT
			info.value = "dungeon entrances"
			info.checked = GetCVarBool("showDungeonEntrancesOnMap")
			LibDD:UIDropDownMenu_AddButton(info)

			local _, _, arch = GetProfessions()
			if arch then
				info.text = ARCHAEOLOGY_SHOW_DIG_SITES -- "Show Digsites"
				info.value = "digsites"
				info.checked = GetCVarBool("digSites") and self:IsTrackingFilter(Enum.MinimapTrackingFilter.Digsites);
				LibDD:UIDropDownMenu_AddButton(info)
			end

			-- BZ's Pet Battle
			if C_Minimap.CanTrackBattlePets() then
				info.text = SHOW_PET_BATTLES_ON_MAP_TEXT
				info.value = "tamers"
				info.checked = GetCVarBool("showTamers")
				LibDD:UIDropDownMenu_AddButton(info)
			end

			info.text = MINIMAP_TRACKING_TRIVIAL_QUESTS;
			info.value = "trivialQuests";
			info.checked = self:IsTrackingFilter(Enum.MinimapTrackingFilter.TrivialQuests);
			LibDD:UIDropDownMenu_AddButton(info);
		end
		-- If we aren't on a map with world quests don't show the world quest reward filter options.
		local mapID = WorldMapFrame:GetMapID()
		if mapID and MapUtil.MapHasEmissaries(mapID) then
			-- Adding World Quest Tracker menus;
--[[			if (checkAddonStatus("WorldQuestTracker") and profile.enable_WorldQuestTracker) then
				AddSeparator()
				local WQT = addon:GetModule("WorldQuestTracker", true)
				local menu = WQT:DropDownMenus()

				if (profile.worldQuestTracker_contextMenu) then
					LibDD:UIDropDownMenu_AddButton(menu[1])
				else
					for i = 1, #menu do
						LibDD:UIDropDownMenu_AddButton(menu[i])
					end
				end
			-- With World Quest Tracker enabled, actually the WoW built-in World Quest menu filters will not work. 
			else]]
				-- Clear out the info from the separator wholesale.
				info = LibDD:UIDropDownMenu_CreateInfo()

				info.isTitle = nil
				info.disabled = nil
				info.notCheckable = nil
				info.isNotRadio = true
				info.keepShownOnClick = true
				info.func = WorldMapTrackingOptionsDropDown_OnClick

				local prof1, prof2, _, fish, cook, firstAid = GetProfessions()
				if prof1 or prof2 then
					info.text = SHOW_PRIMARY_PROFESSION_ON_MAP_TEXT
					info.value = "primaryProfessionsFilter"
					info.checked = GetCVarBool("primaryProfessionsFilter")
					info.func = OnSelection
					LibDD:UIDropDownMenu_AddButton(info)
				end

				if fish or cook or firstAid then
					info.text = SHOW_SECONDARY_PROFESSION_ON_MAP_TEXT
					info.value = "secondaryProfessionsFilter"
					info.checked = GetCVarBool("secondaryProfessionsFilter")
					info.func = OnSelection
					LibDD:UIDropDownMenu_AddButton(info)
				end
				
				AddSeparator()

				-- Clear out the info from the separator wholesale.
				info = LibDD:UIDropDownMenu_CreateInfo()

				info.isTitle = true
				info.notCheckable = true
				info.text = WORLD_QUEST_REWARD_FILTERS_TITLE
				LibDD:UIDropDownMenu_AddButton(info)
				info.text = nil

				info.isTitle = nil
				info.disabled = nil
				info.notCheckable = nil
				info.isNotRadio = true
				info.keepShownOnClick = true
				info.func = OnSelection

				if MapUtil.IsShadowlandsZoneMap(mapID) then
					info.text = WORLD_QUEST_REWARD_FILTERS_ANIMA
					info.value = "worldQuestFilterAnima"
					info.checked = GetCVarBool("worldQuestFilterAnima")
					LibDD:UIDropDownMenu_AddButton(info)
				else
					info.text = WORLD_QUEST_REWARD_FILTERS_RESOURCES
					info.value = "worldQuestFilterResources"
					info.checked = GetCVarBool("worldQuestFilterResources")
					LibDD:UIDropDownMenu_AddButton(info)

					info.text = WORLD_QUEST_REWARD_FILTERS_ARTIFACT_POWER
					info.value = "worldQuestFilterArtifactPower"
					info.checked = GetCVarBool("worldQuestFilterArtifactPower")
					LibDD:UIDropDownMenu_AddButton(info)
				end

				info.text = WORLD_QUEST_REWARD_FILTERS_PROFESSION_MATERIALS
				info.value = "worldQuestFilterProfessionMaterials"
				info.checked = GetCVarBool("worldQuestFilterProfessionMaterials")
				LibDD:UIDropDownMenu_AddButton(info)

				info.text = WORLD_QUEST_REWARD_FILTERS_GOLD
				info.value = "worldQuestFilterGold"
				info.checked = GetCVarBool("worldQuestFilterGold")
				LibDD:UIDropDownMenu_AddButton(info)
				
				info.text = WORLD_QUEST_REWARD_FILTERS_EQUIPMENT
				info.value = "worldQuestFilterEquipment"
				info.checked = GetCVarBool("worldQuestFilterEquipment")
				LibDD:UIDropDownMenu_AddButton(info)
				
				info.text = WORLD_QUEST_REWARD_FILTERS_REPUTATION
				info.value = "worldQuestFilterReputation"
				info.checked = GetCVarBool("worldQuestFilterReputation")
				LibDD:UIDropDownMenu_AddButton(info)
			--end
		end
		for k, v in pairs(addon.plugins) do
			if (v and profile.enableModules[k]) then
				if (k == "WorldQuestTracker") then
					-- do nothing
				else
					local Module = addon:GetModule(k, true)
					local menu = Module:DropDownMenus()
					
					AddSeparator()
					for i = 1, #menu do
						LibDD:UIDropDownMenu_AddButton(menu[i])
					end
				end
			end
		end
		-- Adding WorldMapTrackingEnhanced's Config link
		AddSeparator()
		info = LibDD:UIDropDownMenu_CreateInfo()
		info.isNotRadio = true
		info.notCheckable = true
		info.text = L["World Map Tracking Enhanced Config"]
		info.colorCode = "|cFFB5E61D"
		info.tooltipTitle = addon.LocName
		info.tooltipText = L["Click to open World Map Tracking Enhanced's config panel"]
		info.tooltipOnButton = true
		info.func = (function(self)
			ToggleFrame(WorldMapFrame)
			InterfaceOptionsFrame_OpenToCategory(addon.LocName)
			InterfaceOptionsFrame_OpenToCategory(addon.LocName)
		end)
		LibDD:UIDropDownMenu_AddButton(info)
	-- Handling level 2 menus
	elseif (level == 2) then
		for k, v in pairs(addon.plugins) do
			if (v and profile.enableModules[k] and L_UIDROPDOWNMENU_MENU_VALUE == k) then
				local Module = addon:GetModule(k, true)
				local _, menu2 = Module:DropDownMenus()
				
				if (menu2) then
					for i = 1, #menu2 do
						LibDD:UIDropDownMenu_AddButton(menu2[i], 2)
					end
				end
			end
		end
	elseif (level == 3) then
		for k, v in pairs(addon.plugins) do
			if (v and profile.enableModules[k]) then
				local Module = addon:GetModule(k, true)
				local _, menu2 = Module:DropDownMenus()
				
				if (menu2) then
					for i = 1, #menu2 do
						if (L_UIDROPDOWNMENU_MENU_VALUE == k..i) then
							local t = menu2[i].menuTable
							if (t) then
								for j = 1, #t do
									LibDD:UIDropDownMenu_AddButton(t[j], 3)
								end
							end
						end
					end
				end
			end
		end
	end
end

function WMTEButtonMixin:Refresh()

end

local function createTrackingButton()
	if (profile.independantButton) then
		local KButtons = LibStub("Krowi_WorldMapButtons-1.4")
		addon.button = KButtons:Add("WMTEButtonTemplate", "BUTTON")
		
		return
	else
		local parent
		
		local name = addon.Name.."Button"
		local f = _G[name]
		if (WoWClassicEra or WoWClassicTBC or WoWWOTLKC) then
			parent = WorldMapFrame
			parent.BlackoutFrame:Hide()
			parent:SetFrameStrata("HIGH")
			parent.BorderFrame:SetFrameStrata("LOW")

			if not f then f = CreateFrame("Button", name, parent, "WMTEButtonTemplate") end
			f:SetFrameLevel(20)
			f:SetToplevel(true)
			f:ClearAllPoints()
			if (profile.showOnLeft) then
				f:SetPoint("TOPLEFT", parent, "TOPLEFT", 12, -100) -- 更改放大鏡按鈕的位置
			else
				f:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -12, -100) -- 更改放大鏡按鈕的位置
			end
		else
			parent = FilterButton:GetParent()
			
			if not f then f = CreateFrame("Button", name, WorldMapFrame.ScrollContainer, "WMTEButtonTemplate") end
			if (profile.showOnLeft) then
				f:SetPoint("TOPLEFT", WorldMapFrame.ScrollContainer, 0, 0, "TOPLEFT")
			else
				f:SetPoint("TOPRIGHT", parent:GetCanvasContainer(), -4, -2, "TOPRIGHT")
			end
		end
		
		addon.button = f
	end
end

function addon:OnInitialize()
	self.db = AceDB:New(addon.Name.."DB", addon.constants.defaults, true)
	profile = self.db.profile

	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")

	self:SetupOptions()
	if (WoWClassicEra or WoWClassicTBC or WoWWOTLKC) then
		-- do nothing
	else
		FilterButton = WorldMapFrame.overlayFrames[2]
	end
end

local function rearrangeFilterButtonTexture()
	if (WoWClassicEra or WoWClassicTBC or WoWWOTLKC) then return end
	if (profile.showOnLeft or profile.independantButton) then
		return
	end
	FilterButton.Background:SetTexture(nil)
	FilterButton.Icon:SetTexture(nil)
	FilterButton.IconOverlay:SetTexture(nil)
	FilterButton.Border:SetTexture(nil)
	--FilterButton:SetHighlightTexture(nil)
end

function addon:OnEnable()
	for key, value in pairs( addon.constants.events ) do
		self:RegisterEvent( value )
	end
	createTrackingButton()
	rearrangeFilterButtonTexture()
--	FilterButton:Hide()
end

function addon:Refresh()
	profile = self.db.profile

	for k,v in self:IterateModules() do
		if self:GetModuleEnabled(k) and not v:IsEnabled() then
			self:EnableModule(k)
		elseif not self:GetModuleEnabled(k) and v:IsEnabled() then
			self:DisableModule(k)
		end
		if (v.Refresh) and (type(v.Refresh) == "function") then
			v:Refresh()
		end
	end
end

function addon:GetModuleEnabled(module)
	return profile.enableModules[module]
end

function addon:SetModuleEnabled(module, value)
	local old = profile.enableModules[module]
	profile.enableModules[module] = value
	if old ~= value then
		if value then
			self:EnableModule(module)
		else
			self:DisableModule(module)
		end
	end
end

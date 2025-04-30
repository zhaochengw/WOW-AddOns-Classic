-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- RareScanner libraries
local RSConstants = private.ImportLib("RareScannerConstants")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSNpcDB = private.ImportLib("RareScannerNpcDB")

-- RareScanner service libraries
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSUtils = private.ImportLib("RareScannerUtils")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- Thirdparty
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

-- Constants
local SHOW_RARE_NPC_ICONS = "rsHideRareNpcs"
local SHOW_NOT_DISCOVERED_RARE_NPC_ICONS = "rsHideNotDiscoveredRareNpcs"
local SHOW_CUSTOM_GROUP_NPC_ICONS = "rsHideCustomGroup"
local SHOW_ACHIEVEMENT_NPC_ICONS = "rsHideAchievementRareNpcs"
local SHOW_OTHER_NPC_ICONS = "rsHideOtherRareNpcs"
local DISABLE_LAST_SEEN_FILTER = "rsDisableLastSeenFilter"

local SHOW_CONTAINER_ICONS = "rsHideContainers"
local SHOW_NOT_DISCOVERED_CONTAINER_ICONS = "rsHideNotDiscoveredContainers"
local SHOW_ACHIEVEMENT_CONTAINER_ICONS = "rsHideAchievementContainers"
local SHOW_OTHER_CONTAINER_ICONS = "rsHideOtherContainers"
local DISABLE_LAST_SEEN_CONTAINER_FILTER = "rsDisableLastSeenContainerFilter"


RSWorldMapButtonMixin = { }

local rareNPCsID = 1
local containersID = 2

local function WorldMapButtonDropDownMenu_Initialize(dropDown, mapID)
	local groups = RSNpcDB.GetCustomGroupsByMapID(mapID)
	local OnSelection = function(self, value)
	
		-- Rare NPCs (general)
		if (value == SHOW_RARE_NPC_ICONS) then
			if (RSConfigDB.IsShowingNpcs()) then
				RSConfigDB.SetShowingNpcs(false)
			else
				RSConfigDB.SetShowingNpcs(true)
			end
			LibDD:UIDropDownMenu_Initialize(dropDown)
		elseif (value == DISABLE_LAST_SEEN_FILTER) then
			if (RSConfigDB.IsMaxSeenTimeFilterEnabled()) then
				RSConfigDB.DisableMaxSeenTimeFilter()
			else
				RSConfigDB.EnableMaxSeenTimeFilter()
			end
		elseif (value == SHOW_NOT_DISCOVERED_RARE_NPC_ICONS) then
			if (RSConfigDB.IsShowingNotDiscoveredNpcs()) then
				RSConfigDB.SetShowingNotDiscoveredNpcs(false)
			else
				RSConfigDB.SetShowingNotDiscoveredNpcs(true)
			end
		
		-- Rare NPCs (types)
		elseif (value == SHOW_ACHIEVEMENT_NPC_ICONS) then
			if (RSConfigDB.IsShowingAchievementRareNPCs()) then
				RSConfigDB.SetShowingAchievementRareNPCs(false)
			else
				RSConfigDB.SetShowingAchievementRareNPCs(true)
			end
		elseif (value == SHOW_OTHER_NPC_ICONS) then
			if (RSConfigDB.IsShowingOtherRareNPCs()) then
				RSConfigDB.SetShowingOtherRareNPCs(false)
			else
				RSConfigDB.SetShowingOtherRareNPCs(true)
			end
			
		-- Containers (general)
		elseif (value == SHOW_CONTAINER_ICONS) then
			if (RSConfigDB.IsShowingContainers()) then
				RSConfigDB.SetShowingContainers(false)
			else
				RSConfigDB.SetShowingContainers(true)
			end
			LibDD:UIDropDownMenu_Initialize(dropDown)
		elseif (value == DISABLE_LAST_SEEN_CONTAINER_FILTER) then
			if (RSConfigDB.IsMaxSeenTimeContainerFilterEnabled()) then
				RSConfigDB.DisableMaxSeenContainerTimeFilter()
			else
				RSConfigDB.EnableMaxSeenContainerTimeFilter()
			end
		elseif (value == SHOW_NOT_DISCOVERED_CONTAINER_ICONS) then
			if (RSConfigDB.IsShowingNotDiscoveredContainers()) then
				RSConfigDB.SetShowingNotDiscoveredContainers(false)
			else
				RSConfigDB.SetShowingNotDiscoveredContainers(true)
			end
			
		-- Containers (types)
		elseif (value == SHOW_ACHIEVEMENT_CONTAINER_ICONS) then
			if (RSConfigDB.IsShowingAchievementContainers()) then
				RSConfigDB.SetShowingAchievementContainers(false)
			else
				RSConfigDB.SetShowingAchievementContainers(true)
			end
		elseif (value == SHOW_OTHER_CONTAINER_ICONS) then
			if (RSConfigDB.IsShowingOtherContainers()) then
				RSConfigDB.SetShowingOtherContainers(false)
			else
				RSConfigDB.SetShowingOtherContainers(true)
			end
		end

		-- Custom NPCs
		if (RSUtils.GetTableLength(groups) > 0) then
			for _, group in ipairs(groups) do
				if (value == SHOW_CUSTOM_GROUP_NPC_ICONS .. group) then
					if (RSConfigDB.IsCustomNpcGroupFiltered(group)) then
						RSConfigDB.SetCustomNpcGroupFiltered(group, false)
					else
						RSConfigDB.SetCustomNpcGroupFiltered(group, true)
					end
				end
			end
		end
		
		RSMinimap.RefreshAllData(true)
		WorldMapFrame:RefreshAllDataProviders();
	end
		
	LibDD:UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
		if ((level or 1) == 1) then
  			local info = LibDD:UIDropDownMenu_CreateInfo()
  			info.text = "|TInterface\\AddOns\\RareScanner\\Media\\Icons\\OriginalSkull:18:18:::::0:32:0:32|t "..AL["MAP_MENU_RARE_NPCS"]
  			info.menuList = rareNPCsID
  			info.hasArrow = true
  			info.notCheckable = true
  			LibDD:UIDropDownMenu_AddButton(info)
  			
  			info = LibDD:UIDropDownMenu_CreateInfo()
  			info.text = "|TInterface\\AddOns\\RareScanner\\Media\\Icons\\OriginalChest:18:18:::::0:32:0:32|t "..AL["MAP_MENU_CONTAINERS"]
  			info.menuList = containersID
  			info.hasArrow = true
  			info.notCheckable = true
  			LibDD:UIDropDownMenu_AddButton(info)
			
			local info = LibDD:UIDropDownMenu_CreateInfo();
			info.isNotRadio = true;
			info.keepShownOnClick = true;
			info.func = OnSelection;
		
			info.text = AL["MAP_MENU_SHOW_NOT_DISCOVERED_OLD"];
			info.arg1 = SHOW_NOT_DISCOVERED_ICONS_OLD;
			info.checked = RSConfigDB.IsShowingOldNotDiscoveredMapIcons()
			LibDD:UIDropDownMenu_AddButton(info, level);
		else
			local info = LibDD:UIDropDownMenu_CreateInfo();
			info.isNotRadio = true;
			info.keepShownOnClick = true;
			info.func = OnSelection;
				
			if (menuList == rareNPCsID) then
				info.text = AL["MAP_MENU_SHOW_RARE_NPCS"];
				info.arg1 = SHOW_RARE_NPC_ICONS;
				info.checked = RSConfigDB.IsShowingNpcs()
				LibDD:UIDropDownMenu_AddButton(info, level);
			
				info.text = AL["MAP_MENU_DISABLE_LAST_SEEN_FILTER"];
				info.arg1 = DISABLE_LAST_SEEN_FILTER;
				info.checked = not RSConfigDB.IsMaxSeenTimeFilterEnabled()
				info.disabled = not RSConfigDB.IsShowingNpcs()
				LibDD:UIDropDownMenu_AddButton(info, level);
				
				info.text = "|T"..RSConstants.RED_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_SHOW_NOT_DISCOVERED_RARE_NPCS"]
				info.arg1 = SHOW_NOT_DISCOVERED_RARE_NPC_ICONS;
				info.checked = RSConfigDB.IsShowingNotDiscoveredNpcs()
				info.disabled = not RSConfigDB.IsShowingNpcs()
				LibDD:UIDropDownMenu_AddButton(info, level);
  			
				-- Custom NPCs
				if (RSUtils.GetTableLength(groups) > 0) then
					for _, group in ipairs(groups) do
						info.text = "|T"..RSConstants.PURPLE_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..string.format(AL["MAP_MENU_SHOW_CUSTOM_NPC_GROUP"], RSNpcDB.GetCustomNpcGroupByKey(group))
						info.arg1 = SHOW_CUSTOM_GROUP_NPC_ICONS .. group;
						info.checked = not RSConfigDB.IsCustomNpcGroupFiltered(group)
						info.disabled = not RSConfigDB.IsShowingNpcs()
						LibDD:UIDropDownMenu_AddButton(info, level);
					end
				end
				
				LibDD:UIDropDownMenu_AddSeparator(level)
			
				info.text = "|A:"..RSConstants.ACHIEVEMENT_ICON_ATLAS..":18:18::::|a "..AL["MAP_MENU_SHOW_ACHIEVEMENT_RARE_NPCS"];
				info.arg1 = SHOW_ACHIEVEMENT_NPC_ICONS;
				info.checked = RSConfigDB.IsShowingAchievementRareNPCs()
				info.disabled = not RSConfigDB.IsShowingNpcs()
				LibDD:UIDropDownMenu_AddButton(info, level);
			
				info.text = AL["MAP_MENU_SHOW_OTHER_RARE_NPCS"];
				info.arg1 = SHOW_OTHER_NPC_ICONS;
				info.checked = RSConfigDB.IsShowingOtherRareNPCs()
				info.disabled = not RSConfigDB.IsShowingNpcs()
				LibDD:UIDropDownMenu_AddButton(info, level);
			elseif (menuList == containersID) then
				info.text = AL["MAP_MENU_SHOW_CONTAINERS"];
				info.arg1 = SHOW_CONTAINER_ICONS;
				info.checked = RSConfigDB.IsShowingContainers()
				LibDD:UIDropDownMenu_AddButton(info, level);
			
				info.text = AL["MAP_MENU_DISABLE_LAST_SEEN_CONTAINER_FILTER"];
				info.arg1 = DISABLE_LAST_SEEN_CONTAINER_FILTER;
				info.checked = not RSConfigDB.IsMaxSeenTimeContainerFilterEnabled()
				info.disabled = not RSConfigDB.IsShowingContainers()
				LibDD:UIDropDownMenu_AddButton(info, level);
				
				info.text = "|T"..RSConstants.RED_CONTAINER_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_SHOW_NOT_DISCOVERED_CONTAINERS"];
				info.arg1 = SHOW_NOT_DISCOVERED_CONTAINER_ICONS;
				info.checked = RSConfigDB.IsShowingNotDiscoveredContainers()
				info.disabled = not RSConfigDB.IsShowingContainers()
				LibDD:UIDropDownMenu_AddButton(info, level);
				
				LibDD:UIDropDownMenu_AddSeparator(level)
			
				info.text = "|A:"..RSConstants.ACHIEVEMENT_ICON_ATLAS..":18:18::::|a "..AL["MAP_MENU_SHOW_ACHIEVEMENT_CONTAINERS"];
				info.arg1 = SHOW_ACHIEVEMENT_CONTAINER_ICONS;
				info.checked = RSConfigDB.IsShowingAchievementContainers()
				info.disabled = not RSConfigDB.IsShowingNpcs()
				LibDD:UIDropDownMenu_AddButton(info, level);
			
				info.text = AL["MAP_MENU_SHOW_OTHER_CONTAINERS"];
				info.arg1 = SHOW_OTHER_CONTAINER_ICONS;
				info.checked = RSConfigDB.IsShowingOtherContainers()
				info.disabled = not RSConfigDB.IsShowingContainers()
				LibDD:UIDropDownMenu_AddButton(info, level);
			end
		end
	end)
end

function RSWorldMapButtonMixin:OnLoad()
	self.DropDown = LibDD:Create_UIDropDownMenu("WorldMapButtonDropDownMenu", self)
	self.DropDown:SetClampedToScreen(true)
	WorldMapButtonDropDownMenu_Initialize(self.DropDown)
end

function RSWorldMapButtonMixin:OnMouseDown(button)
    self.Icon:SetPoint('TOPLEFT', self, "TOPLEFT", 7, -6)
    local xOffset = WorldMapFrame.isMaximized and 30 or 0
    self.DropDown.point = WorldMapFrame.isMaximized and 'TOPRIGHT' or 'TOPLEFT'
    LibDD:ToggleDropDownMenu(1, nil, self.DropDown, self, xOffset, -5)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end

function RSWorldMapButtonMixin:OnMouseUp()
	self.Icon:SetPoint('TOPLEFT', 7.2, -6)
end

function RSWorldMapButtonMixin:OnEnter()
    GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
    GameTooltip_SetTitle(GameTooltip, "RareScanner")
    GameTooltip:Show()
end

function RSWorldMapButtonMixin:Refresh()	
	if (not self.mapID or self.mapID ~= WorldMapFrame:GetMapID()) then
		self.mapID = WorldMapFrame:GetMapID()
		WorldMapButtonDropDownMenu_Initialize(self.DropDown, self.mapID)
	end
end
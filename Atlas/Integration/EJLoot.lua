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

local ATLAS_EJ_DIFFICULTIES =
{
	{ size = "5",                            prefix = PLAYER_DIFFICULTY1,           difficultyID = 1 },
	{ size = "5",                            prefix = PLAYER_DIFFICULTY2,           difficultyID = 2 },
	{ size = "5",                            prefix = PLAYER_DIFFICULTY6,           difficultyID = 23 },
	{ size = "5",                            prefix = PLAYER_DIFFICULTY_TIMEWALKER, difficultyID = 24 },
	{ size = "25",                           prefix = PLAYER_DIFFICULTY3,           difficultyID = 7 },
	{ size = "10",                           prefix = PLAYER_DIFFICULTY1,           difficultyID = 3 },
	{ size = "10",                           prefix = PLAYER_DIFFICULTY2,           difficultyID = 5 },
	{ size = "25",                           prefix = PLAYER_DIFFICULTY1,           difficultyID = 4 },
	{ size = "25",                           prefix = PLAYER_DIFFICULTY2,           difficultyID = 6 },
	{ prefix = PLAYER_DIFFICULTY3,           difficultyID = 17 },
	{ prefix = PLAYER_DIFFICULTY1,           difficultyID = 14 },
	{ prefix = PLAYER_DIFFICULTY2,           difficultyID = 15 },
	{ prefix = PLAYER_DIFFICULTY6,           difficultyID = 16 },
	{ prefix = PLAYER_DIFFICULTY_TIMEWALKER, difficultyID = 33 },
}

local SlotFilterToSlotName = {}
if (select(4, GetBuildInfo()) > 40000) then
	SlotFilterToSlotName = {
		[Enum.ItemSlotFilterType.Head] = INVTYPE_HEAD,
		[Enum.ItemSlotFilterType.Neck] = INVTYPE_NECK,
		[Enum.ItemSlotFilterType.Shoulder] = INVTYPE_SHOULDER,
		[Enum.ItemSlotFilterType.Cloak] = INVTYPE_CLOAK,
		[Enum.ItemSlotFilterType.Chest] = INVTYPE_CHEST,
		[Enum.ItemSlotFilterType.Wrist] = INVTYPE_WRIST,
		[Enum.ItemSlotFilterType.Hand] = INVTYPE_HAND,
		[Enum.ItemSlotFilterType.Waist] = INVTYPE_WAIST,
		[Enum.ItemSlotFilterType.Legs] = INVTYPE_LEGS,
		[Enum.ItemSlotFilterType.Feet] = INVTYPE_FEET,
		[Enum.ItemSlotFilterType.MainHand] = INVTYPE_WEAPONMAINHAND,
		[Enum.ItemSlotFilterType.OffHand] = INVTYPE_WEAPONOFFHAND,
		[Enum.ItemSlotFilterType.Finger] = INVTYPE_FINGER,
		[Enum.ItemSlotFilterType.Trinket] = INVTYPE_TRINKET,
		[Enum.ItemSlotFilterType.Other] = EJ_LOOT_SLOT_FILTER_OTHER,
	}
end

local BOSS_LOOT_BUTTON_HEIGHT = 45
local INSTANCE_LOOT_BUTTON_HEIGHT = 64

function Atlas_EJ_ResetLootFilter()
	EJ_ResetLootFilter()
end

function Atlas_EncounterJournal_DisplayLoot(instanceID, encounterId)
	AtlasEJLootFrame.instanceID = instanceID
	AtlasEJLootFrame.encounterID = encounterId
	AtlasEJLootFrame:Show()
end

function Atlas_EncounterJournal_OnLoad(self)
	if (select(4, GetBuildInfo()) < 40000) then return end
	self:RegisterEvent("EJ_DIFFICULTY_UPDATE");
	self:RegisterEvent("EJ_LOOT_DATA_RECIEVED");

	-- On retail, the close button is too big, make it smaller
	if (select(4, GetBuildInfo()) > 90000) then
		AtlasEJLootFrameCloseButton:SetSize(24, 24);
	end

	local view = CreateScrollBoxListLinearView();
	view:SetElementExtentCalculator(function(dataIndex, elementData)
		if elementData.header then
			return BOSS_LOOT_BUTTON_HEIGHT;
		elseif EncounterJournal.encounterID then
			return BOSS_LOOT_BUTTON_HEIGHT;
		else
			return INSTANCE_LOOT_BUTTON_HEIGHT;
		end
	end);
	view:SetElementFactory(function(factory, elementData)
		if elementData.header then
			factory("EncounterItemDividerTemplate", function(button, elementData)
				button:Init(elementData);
			end);
		else
			factory("AtlasEncounterItemTemplate", function(button, elementData)
				button:Init(elementData);
			end);
		end
	end);

	local scrollBox = AtlasEJLootFrame.lootScroll.ScrollBox;
	local scrollBar = AtlasEJLootFrame.lootScroll.ScrollBar;
	ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, view);
end

function Atlas_EncounterJournal_HasChangedContext(instanceID, instanceType, difficultyID)
	if (instanceType == "none") then
		-- we've gone from a dungeon to the open world
		return EncounterJournal.lastInstance ~= nil;
	elseif (instanceID ~= 0 and (instanceID ~= EncounterJournal.lastInstance or EncounterJournal.lastDifficulty ~= difficultyID)) then
		-- dungeon or difficulty has changed
		return true;
	end
	return false;
end

function Atlas_EncounterJournal_ResetDisplay(instanceID, instanceType, difficultyID)
	if (instanceType == "none") then
		EncounterJournal.lastInstance = nil;
		EncounterJournal.lastDifficulty = nil;
		MonthlyActivitiesFrame_OpenFrame();
	else
		EJ_ContentTab_SelectAppropriateInstanceTab(instanceID);

		EncounterJournal_DisplayInstance(instanceID);
		EncounterJournal.lastInstance = instanceID;
		-- try to set difficulty to current instance difficulty
		if (EJ_IsValidInstanceDifficulty(difficultyID)) then
			EJ_SetDifficulty(difficultyID);
		end
		EncounterJournal.lastDifficulty = difficultyID;
	end
end

function Atlas_EncounterJournal_OnShow(self)
	if (tonumber(GetCVar("advJournalLastOpened")) == 0) then
		SetCVar("advJournalLastOpened", GetServerTime());
	end
	MainMenuMicroButton_HideAlert(EJMicroButton);
	MicroButtonPulseStop(EJMicroButton);

	UpdateMicroButtons();
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
	Atlas_EncounterJournal_LootUpdate();

	--automatically navigate to the current dungeon if you are in one;
	local currentMapID = select(8, GetInstanceInfo());
	local instanceID = currentMapID and C_EncounterJournal.GetInstanceForGameMap(currentMapID) or nil;
	local _, instanceType, difficultyID = GetInstanceInfo()
	if (Atlas_EncounterJournal_HasChangedContext(instanceID, instanceType, difficultyID)) then
		Atlas_EncounterJournal_ResetDisplay(instanceID, instanceType, difficultyID);
	end

	Atlas_EncounterJournal_InitLootFilter();
	Atlas_EncounterJournal_InitLootSlotFilter();
	Atlas_EncounterJournal_DifficultyInit();
end

function Atlas_EncounterJournal_OnEvent(self, event, ...)
	if event == "EJ_LOOT_DATA_RECIEVED" then
		local itemID = ...
		if itemID and not EJ_IsLootListOutOfDate() then
			Atlas_EncounterJournal_LootCallback(itemID);
		else
			Atlas_EncounterJournal_LootUpdate();
		end
	elseif event == "EJ_DIFFICULTY_UPDATE" then
		--fix the difficulty buttons
		Atlas_EncounterJournal_UpdateDifficulty(...);
	end
end

function Atlas_EncounterJournal_UpdateDifficulty(newDifficultyID)
	if tContains(ATLAS_EJ_DIFFICULTIES, newDifficultyID) then
		Atlas_EncounterJournal_DifficultyInit();
		Atlas_EncounterJournal_Refresh();
	end
end

function Atlas_EncounterJournal_LootCallback(itemID)
	local scrollBox = AtlasEJLootFrame.lootScroll.ScrollBox;
	local button = scrollBox:FindFrameByPredicate(function(button, elementData)
		return button.itemID == itemID;
	end);
	if button then
		button:Init(button:GetElementData());
	end
end

function Atlas_EncounterJournal_LootUpdate()
	Atlas_EncounterJournal_UpdateFilterString();

	local scrollBox = AtlasEJLootFrame.lootScroll.ScrollBox;

	local dataProvider = CreateDataProvider();
	local loot = {};
	local perPlayerLoot = {};
	local veryRareLoot = {};
	local extremelyRareLoot = {};
	local seasonalLoot = {};
	local currentSeason = C_SeasonInfo and C_SeasonInfo.GetCurrentDisplaySeasonID() or 0;
	local currentSeasonExpansion = C_SeasonInfo and C_SeasonInfo.GetCurrentDisplaySeasonExpansion() or 0;

	for i = 1, EJ_GetNumLoot() do
		local itemInfo = C_EncounterJournal.GetLootInfoByIndex(i);
		if itemInfo.displaySeasonID then
			-- The loot is flagged to be for a specific season, see if it matches the current one.
			if itemInfo.displaySeasonID == currentSeason then
				tinsert(seasonalLoot, i);
			end
		elseif itemInfo.displayAsPerPlayerLoot then
			tinsert(perPlayerLoot, i);
		elseif itemInfo.displayAsExtremelyRare then
			tinsert(extremelyRareLoot, i);
		elseif itemInfo.displayAsVeryRare then
			tinsert(veryRareLoot, i);
		else
			tinsert(loot, i);
		end
	end

	for _, val in ipairs(loot) do
		dataProvider:Insert({ index = val });
	end

	local seasonalHeaderTitle;
	local uiSeason = PVPUtil and PVPUtil.GetCurrentSeasonNumber() or 0;
	if #seasonalLoot > 0 and currentSeason and currentSeasonExpansion then
		seasonalHeaderTitle = EXPANSION_SEASON_NAME:format(GetExpansionName(currentSeasonExpansion), uiSeason);
	end

	local lootCategories = {
		{ loot = veryRareLoot,      headerTitle = EJ_ITEM_CATEGORY_VERY_RARE },
		{ loot = extremelyRareLoot, headerTitle = EJ_ITEM_CATEGORY_EXTREMELY_RARE },
		{ loot = perPlayerLoot,     headerTitle = BONUS_LOOT_TOOLTIP_TITLE,       helpText = BONUS_LOOT_TOOLTIP_BODY },
		{ loot = seasonalLoot,      headerTitle = seasonalHeaderTitle },
	};

	for _, category in ipairs(lootCategories) do
		if #category.loot > 0 then
			dataProvider:Insert({ header = true, text = category.headerTitle, helpText = category.helpText });
			for _, val in ipairs(category.loot) do
				dataProvider:Insert({ index = val });
			end
		end
	end

	scrollBox:SetDataProvider(dataProvider);
end

function Atlas_EncounterJournal_Loot_OnUpdate(self)
	if GameTooltip:IsOwned(self) then
		if IsModifiedClick("DRESSUP") then
			ShowInspectCursor();
		else
			ResetCursor();
		end
	end
end

function Atlas_EncounterJournal_SetTooltip(link, itemID)
	if (not link) then
		return;
	end

	if (GameTooltip.ProcessInfo) then
		local classID, specID = EJ_GetLootFilter();

		if (specID == 0) then
			local spec = C_SpecializationInfo.GetSpecialization();
			if (spec and classID == select(3, UnitClass("player"))) then
				specID = C_SpecializationInfo.GetSpecializationInfo(spec, nil, nil, nil, UnitSex("player"));
			else
				specID = -1;
			end
		end

		local tooltipInfo = CreateBaseTooltipInfo("GetHyperlink", link, classID, specID);
		tooltipInfo.compareItem = true;
		GameTooltip:ProcessInfo(tooltipInfo);
	else
		GameTooltip:SetItemByID(itemID);
		GameTooltip_ShowCompareItem(GameTooltip)
	end
end

function Atlas_EncounterJournal_Refresh()
	Atlas_EncounterJournal_LootUpdate();
end

function Atlas_EncounterJournal_OnFilterChanged()
	Atlas_EncounterJournal_LootUpdate();
end

function Atlas_EncounterJournal_UpdateFilterString()
	local name, _;
	local classID, specID = EJ_GetLootFilter();

	if (specID > 0) then
		_, name = GetSpecializationInfoByID(specID, UnitSex("player"))
	elseif (classID > 0) then
		local classInfo = C_CreatureInfo.GetClassInfo(classID);
		if classInfo then
			name = classInfo.className;
		end
	end

	if name then
		AtlasEJLootFrame.lootScroll.classClearFilter.text:SetText(format(EJ_CLASS_FILTER, name));
		AtlasEJLootFrame.lootScroll.classClearFilter:Show();
		AtlasEJLootFrame.lootScroll.ScrollBox:SetHeight(318);
	else
		AtlasEJLootFrame.lootScroll.classClearFilter:Hide();
		AtlasEJLootFrame.lootScroll.ScrollBox:SetHeight(340);
	end
end

function Atlas_EncounterJournal_InitLootFilter(self, level)
	local dropdown = AtlasEJLootFrame.lootScroll.filter;

	local function GetClassFilter()
		local filterClassID, _ = EJ_GetLootFilter();
		return filterClassID;
	end
	local function GetSpecFilter()
		local _, filterSpecID = EJ_GetLootFilter();
		return filterSpecID;
	end
	local function Atlas_EncounterJournal_SetClassAndSpecFilter(classID, specID)
		EJ_SetLootFilter(classID, specID);
		Atlas_EncounterJournal_OnFilterChanged();
	end

	dropdown:SetWidth(160);
	ClassMenu.InitClassSpecDropdown(dropdown, GetClassFilter, GetSpecFilter, Atlas_EncounterJournal_SetClassAndSpecFilter)
end

local function GetLootSlotsPresent()
	local slotFilter = C_EncounterJournal.GetSlotFilter();
	C_EncounterJournal.ResetSlotFilter();

	local isLootSlotPresent = {};
	for index = 1, EJ_GetNumLoot() do
		local itemInfo = C_EncounterJournal.GetLootInfoByIndex(index);
		local filterType = itemInfo and itemInfo.filterType;
		if filterType then
			isLootSlotPresent[filterType] = true;
		end
	end
	C_EncounterJournal.SetSlotFilter(slotFilter);
	return isLootSlotPresent;
end

function Atlas_EncounterJournal_InitLootSlotFilter(self, level)
	local slotFilter = C_EncounterJournal.GetSlotFilter();
	local dropdown = AtlasEJLootFrame.lootScroll.slotFilter;

	local function IsSelected(filter)
		return C_EncounterJournal.GetSlotFilter() == filter;
	end

	local function SetSelected(filter)
		C_EncounterJournal.SetSlotFilter(filter);
		Atlas_EncounterJournal_OnFilterChanged();
	end

	dropdown:SetWidth(100);
	dropdown:SetupMenu(function(dropdown, rootDescription)
		rootDescription:CreateRadio(ALL_INVENTORY_SLOTS, IsSelected, SetSelected, Enum.ItemSlotFilterType.NoFilter);

		local isLootSlotPresent = GetLootSlotsPresent();
		for filter, name in pairs(SlotFilterToSlotName) do
			if isLootSlotPresent[filter] or filter == slotFilter then
				rootDescription:CreateRadio(name, IsSelected, SetSelected, filter);
			end
		end
	end);
end

function Atlas_EncounterJournal_DifficultyInit()
	local dropdown = AtlasEJLootFrame.lootScroll.difficulty;

	local function IsSelected(difficultyID)
		return EJ_GetDifficulty() == difficultyID;
	end

	local function SetSelected(difficultyID)
		EJ_SetDifficulty(difficultyID);
		Atlas_EncounterJournal_OnFilterChanged();
	end

	dropdown:SetWidth(140);
	dropdown:SetupMenu(function(dropdown, rootDescription)
		for index, difficulty in ipairs(ATLAS_EJ_DIFFICULTIES) do
			if EJ_IsValidInstanceDifficulty(difficulty.difficultyID) then
				local text;
				if (difficulty.size) then
					text = format(ENCOUNTER_JOURNAL_DIFF_TEXT, difficulty.size, difficulty.prefix);
				else
					text = difficulty.prefix;
				end
				rootDescription:CreateRadio(text, IsSelected, SetSelected, difficulty.difficultyID);
			end
		end
	end);
end

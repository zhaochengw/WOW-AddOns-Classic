local _, L = ...;

----------------------------------------------------------------------------------
--------------------------------- CORE FUNCTIONS ---------------------------------
----------------------------------------------------------------------------------

local talentFrameSetUp = false;

-- Runs when player just entered world (after loading screen)
function MCF_OnEvent(self, event, ...)
    local arg1, arg2 = ...;

    if ( event == "PLAYER_ENTERING_WORLD" and (arg1 or arg2) ) then
        if MCF_SETTINGS == nil then
            MCF_SETTINGS = MCF_DEFAULT_SETTINGS;
        end

        SetUIPanelAttribute(CharacterFrame, "pushable", 7);

		-- Creating service frame
		MCF_ScanTooltip = CreateFrame("GameTooltip", "MCF_ScanTooltip");

		-- Creating options frame
		MCF_CreateOptionsFrame();

        -- Cleaning frame from unnecessary elements and textures
        MCF_CleanDefaultFrame();
        MCF_DeleteFrameTextures(PaperDollFrame);

        -- Creating new textures and frames (insets)
        MCF_CreateNewFrameTextures(PaperDollFrame);
        MCF_CreateNewCharacterFrameElements(CharacterFrame);
        MCF_CreateSidebarTabsPanel(PaperDollFrame);
        MCF_CreateStatsFrame(CharacterFrame);
        MCF_CreateTitlesPane(PaperDollFrame);
        MCF_CreateEquipmentManagerPane(PaperDollFrame);

        -- Reskinning tab buttons
        CharacterFrameTab1:SetPoint("CENTER", CharacterFrame, "BOTTOMLEFT", 60, 60);
        MCF_ReskinTabButtons(CharacterFrameTab1);
        MCF_ReskinTabButtons(CharacterFrameTab2);
        MCF_ReskinTabButtons(CharacterFrameTab3);
        MCF_ReskinTabButtons(CharacterFrameTab4);
        MCF_ReskinTabButtons(CharacterFrameTab5);

        -- Adjusting CharacterFrameInset position
        CharacterFrameInset:SetPoint("BOTTOMRIGHT", CharacterFrame, "BOTTOMLEFT", PANEL_DEFAULT_WIDTH + PANEL_INSET_RIGHT_OFFSET + 16, PANEL_INSET_BOTTOM_OFFSET + 76);

        -- Setting up CharacterModelFrame
        MCF_SetUpCharacterModelFrame(CharacterModelFrame);

        -- Adjusting item slots positions a bit
        CharacterHeadSlot:SetPoint("TOPLEFT", CharacterFrameInset, "TOPLEFT", 3, -2);
        CharacterHandsSlot:SetPoint("TOPLEFT", CharacterFrameInset, "TOPRIGHT", -43, -2);
        CharacterMainHandSlot:SetPoint("TOPLEFT", PaperDollItemsFrame, "BOTTOMLEFT", 120, 129);

		-- Dealing with default GearManagerDialog
		GearManagerDialog:SetFrameStrata("TOOLTIP");
		GearManagerDialog:EnableMouse(false);
		GearManagerDialog:SetScript("OnLoad", nil);
		GearManagerDialog:SetScript("OnShow", nil);
		GearManagerDialog:SetScript("OnHide", nil);
		GearManagerDialog:SetSize(0, 0);
		GearManagerDialog:SetPoint("TOPLEFT", CharacterFrame, "TOPLEFT", 10, -12);

        -- Registering events on CharacterFrame
        CharacterFrame:RegisterEvent("PLAYER_PVP_RANK_CHANGED");
        CharacterFrame:RegisterEvent("PREVIEW_TALENT_POINTS_CHANGED");
        CharacterFrame:RegisterEvent("PLAYER_TALENT_UPDATE");
        CharacterFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
        CharacterFrame:UnregisterEvent("UNIT_PORTRAIT_UPDATE");
        -- Imitating frame loading to register events
        MCF_PaperDollFrame_OnLoad(PaperDollFrame);
        
        -- Assigning new scripts
        CharacterFrame:SetScript("OnEvent", function(self, event, ...) MCF_CharacterFrame_OnEvent(self, event, ...); end);
        CharacterFrame:SetScript("OnShow", function(self) MCF_CharacterFrame_OnShow(self); end);
        PaperDollFrame:SetScript("OnLoad", function(self) MCF_PaperDollFrame_OnLoad(self); end);
        PaperDollFrame:SetScript("OnEvent", function(self, event, ...) MCF_PaperDollFrame_OnEvent(self, event, ...); end);
        PaperDollFrame:SetScript("OnShow", function(self) MCF_PaperDollFrame_OnShow(self); end);
        PaperDollFrame:SetScript("OnHide", function(self) MCF_PaperDollFrame_OnHide(self); end);
    elseif ( event == "ADDON_LOADED" and arg1 == "Blizzard_TalentUI" and (not InCombatLockdown()) ) then
        SetUIPanelAttribute(PlayerTalentFrame, "width", 383);
        talentFrameSetUp = true;
        MCF:UnregisterEvent(event);
        MCF:UnregisterEvent("PLAYER_REGEN_ENABLED");
    elseif ( IsAddOnLoaded("Blizzard_TalentUI") and (not talentFrameSetUp) and (event == "PLAYER_REGEN_ENABLED") ) then
        SetUIPanelAttribute(PlayerTalentFrame, "width", 383);
        talentFrameSetUp = true;
        MCF:UnregisterEvent("ADDON_LOADED");
        MCF:UnregisterEvent(event);
    end
end

-- CharacterFrame scripts
function MCF_CharacterFrame_OnEvent(self, event, ...)
    if ( not self:IsShown() ) then
		return;
	end

	local arg1 = ...;
	if ( event == "UNIT_NAME_UPDATE" ) then
		if ( arg1 == "player" and not PetPaperDollFrame:IsShown()) then
			CharacterNameText:SetText(UnitPVPName("player"));
		end
		return;
	elseif ( event == "PLAYER_PVP_RANK_CHANGED" ) then
		if (not PetPaperDollFrame:IsShown()) then
			CharacterNameText:SetText(UnitPVPName("player"));
		end
	elseif (	event == "PREVIEW_TALENT_POINTS_CHANGED"
				or event == "PLAYER_TALENT_UPDATE"
				or event == "ACTIVE_TALENT_GROUP_CHANGED") then
		MCF_CharacterFrame_UpdatePortrait();
	end
end
function MCF_CharacterFrame_OnShow(self)
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
    MCF_CleanDefaultFrame();
	MCF_CharacterFrame_UpdatePortrait();
    MCF_PaperDollFrame_SetLevel();
	if (not PaperDollFrame:IsShown()) then
		MCF_CharacterFrame_Collapse();
		CharacterFrameExpandButton:Hide();
	end
    CharacterNameText:SetText(UnitPVPName("player"));
	UpdateMicroButtons();
	PlayerFrameHealthBar.showNumeric = true;
	PlayerFrameManaBar.showNumeric = true;
	PlayerFrameAlternateManaBar.showNumeric = true;
	--[[ MainMenuExpBar.showNumeric = true; ]]
	PetFrameHealthBar.showNumeric = true;
	PetFrameManaBar.showNumeric = true;
	ShowTextStatusBarText(PlayerFrameHealthBar);
	ShowTextStatusBarText(PlayerFrameManaBar);
	ShowTextStatusBarText(PlayerFrameAlternateManaBar);
	--[[ ShowTextStatusBarText(MainMenuExpBar); ]]
	ShowTextStatusBarText(PetFrameHealthBar);
	ShowTextStatusBarText(PetFrameManaBar);

    if ( UnitLevel("player") == GetMaxPlayerLevel() ) then
		ShowWatchBarText(ReputationWatchBar);
	end

	MicroButtonPulseStop(CharacterMicroButton);	--Stop the button pulse
    -- Show Currency tab?
	if (GetCurrencyListSize() > 0) then
		CharacterFrameTab5:Show();
	else
		CharacterFrameTab5:Hide();
	end
end

-- PaperDollFrame scripts
function MCF_PaperDollFrame_OnLoad(self)
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("CHARACTER_POINTS_CHANGED");
	self:RegisterEvent("UNIT_MODEL_CHANGED");
	self:RegisterEvent("UNIT_LEVEL");
	self:RegisterEvent("UNIT_RESISTANCES");
	self:RegisterEvent("UNIT_STATS");
	self:RegisterEvent("UNIT_DAMAGE");
	self:RegisterEvent("UNIT_RANGEDDAMAGE");
	self:RegisterEvent("UNIT_ATTACK_SPEED");
	self:RegisterEvent("UNIT_ATTACK_POWER");
	self:RegisterEvent("UNIT_RANGED_ATTACK_POWER");
	self:RegisterEvent("UNIT_ATTACK");
	self:RegisterEvent("UNIT_SPELL_HASTE");
	self:RegisterEvent("PLAYER_GUILD_UPDATE");
	self:RegisterEvent("SKILL_LINES_CHANGED");
	self:RegisterEvent("COMBAT_RATING_UPDATE");
	--self:RegisterEvent("MASTERY_UPDATE");
	--self:RegisterEvent("KNOWN_TITLES_UPDATE");
	self:RegisterEvent("UNIT_NAME_UPDATE");
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("BAG_UPDATE");
	self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
	--self:RegisterEvent("PLAYER_BANKSLOTS_CHANGED");
	self:RegisterEvent("PLAYER_AVG_ITEM_LEVEL_UPDATE");
	self:RegisterEvent("PLAYER_DAMAGE_DONE_MODS");
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
	self:RegisterEvent("UNIT_MAXHEALTH");
	self:RegisterEvent("UNIT_AURA"); -- MCF TEST check if it reduces performance
	self:RegisterEvent("UPDATE_INVENTORY_DURABILITY");
	self:RegisterEvent("MERCHANT_SHOW");
	-- flyout settings
	--[[ PaperDollItemsFrame.flyoutSettings = {
		onClickFunc = PaperDollFrameItemFlyoutButton_OnClick,
		getItemsFunc = PaperDollFrameItemFlyout_GetItems,
		postGetItemsFunc = PaperDollFrameItemFlyout_PostGetItems, 
		hasPopouts = true,
		parent = PaperDollFrame,
		anchorX = 0,
		anchorY = -3,
		verticalAnchorX = 0,
		verticalAnchorY = 0,
	}; ]]
end
function MCF_PaperDollFrame_OnEvent(self, event, ...)
	local unit = ...;
	if ( event == "PLAYER_ENTERING_WORLD" or
		event == "UNIT_MODEL_CHANGED" and unit == "player" ) then
		CharacterModelFrame:SetUnit("player");
		return;
	elseif ( --[[ event == "KNOWN_TITLES_UPDATE" or ( ]]event == "UNIT_NAME_UPDATE" and unit == "player"--[[ ) ]]) then
		if (PaperDollTitlesPane:IsShown()) then
			MCF_PaperDollTitlesPane_Update();
		end
	end
	
	if (self.initItemsColoring and event == "PLAYER_EQUIPMENT_CHANGED") then
		local itemSlotID, isEmpty = ...;
		if (not isEmpty) then
			MCF_SetItemQuality(itemSlotID);
		else
			MCF_ClearItemQuality(itemSlotID);
		end
	end

	if ( not self:IsVisible() ) then
		return;
	end
	
	if ( unit == "player" ) then
		if ( event == "UNIT_LEVEL" ) then
			MCF_PaperDollFrame_SetLevel();
		elseif ( event == "UNIT_DAMAGE" or event == "UNIT_ATTACK_SPEED" or event == "UNIT_RANGEDDAMAGE" or event == "UNIT_ATTACK" or event == "UNIT_STATS" or event == "UNIT_RANGED_ATTACK_POWER" or event == "UNIT_RESISTANCES" or event == "UNIT_SPELL_HASTE" or event == "UNIT_MAXHEALTH" ) then
			self:SetScript("OnUpdate", MCF_PaperDollFrame_QueuedUpdate);
		-- Hack: update stats if Mana regen values changed
		elseif (event == "UNIT_AURA" and UnitHasMana(unit)) then
			MCF_PaperDollFrame_UpdateManaRegen(self);
		end
	end
	
	if ( event == "COMBAT_RATING_UPDATE" or event=="MASTERY_UPDATE" or event == "BAG_UPDATE" or event == "PLAYER_EQUIPMENT_CHANGED" or event == "PLAYER_BANKSLOTS_CHANGED" or event == "PLAYER_AVG_ITEM_LEVEL_UPDATE" or event == "PLAYER_DAMAGE_DONE_MODS" or event == "UPDATE_INVENTORY_DURABILITY" or event == "MERCHANT_SHOW") then
		self:SetScript("OnUpdate", MCF_PaperDollFrame_QueuedUpdate);
	elseif (event == "VARIABLES_LOADED") then
		if (MCF_GetSettings("characterFrameCollapsed") ~= "0") then
			MCF_CharacterFrame_Collapse();
		else
			MCF_CharacterFrame_Expand();
		end
		
		local activeSpec = GetActiveTalentGroup();
		if (activeSpec == 1) then
			MCF_PaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder", "statCategoriesCollapsed", "player");
		else
			MCF_PaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder_2", "statCategoriesCollapsed_2", "player");
		end
	elseif (event == "PLAYER_TALENT_UPDATE") then
		MCF_PaperDollFrame_SetLevel();
		self:SetScript("OnUpdate", MCF_PaperDollFrame_QueuedUpdate);
	elseif (event == "ACTIVE_TALENT_GROUP_CHANGED") then
		local activeSpec = GetActiveTalentGroup();
		if (activeSpec == 1) then
			MCF_PaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder", "statCategoriesCollapsed", "player");
		else
			MCF_PaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder_2", "statCategoriesCollapsed_2", "player");
		end
	end
end
function MCF_PaperDollFrame_OnShow(self)
    CharacterFrameInset:Show();
    MCF_PaperDollFrame_SetLevel();
    MCF_PaperDollFrame_UpdateStats();

	local _, class = UnitClass("player");
	if ( not ((class == "HUNTER") or (class == "ROGUE") or (class == "WARRIOR")) ) then
		CharacterAmmoSlot:Hide();
	end

	CharacterStatsPane.initialOffsetY = 0;
    CharacterNameText:SetText(UnitPVPName("player"));

	local activeSpec = GetActiveTalentGroup();
	if (activeSpec == 1) then
		MCF_PaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder", "statCategoriesCollapsed", "player");
	else
		MCF_PaperDoll_InitStatCategories(MCF_PAPERDOLL_STATCATEGORY_DEFAULTORDER, "statCategoryOrder_2", "statCategoriesCollapsed_2", "player");
	end

	if (MCF_GetSettings("characterFrameCollapsed") ~= "0") then
		MCF_CharacterFrame_Collapse();
	else
		MCF_CharacterFrame_Expand();
	end
	CharacterFrameExpandButton:Show();
	CharacterFrameExpandButton.collapseTooltip = L["MCF_STATS_COLLAPSE_TOOLTIP"];
	CharacterFrameExpandButton.expandTooltip = L["MCF_STATS_EXPAND_TOOLTIP"];
	
	MCF_SetPaperDollBackground(CharacterModelFrame, "player");
	MCF_PaperDollBgDesaturate(1);
	PaperDollSidebarTabs:Show();

	if (not self.initItemsColoring) then
		for id,_ in pairs(MCF_ItemSlotNames) do
			MCF_SetItemQuality(id);
		end
		self.initItemsColoring = true;
	end
end
function MCF_PaperDollFrame_OnHide(self)
    CharacterFrameInset:Hide();
	CharacterStatsPane.initialOffsetY = 0;
	MCF_CharacterFrame_Collapse();
	CharacterFrameExpandButton:Hide();
	if (MOVING_STAT_CATEGORY) then
		MCF_PaperDollStatCategory_OnDragStop(MOVING_STAT_CATEGORY);
	end
	PaperDollSidebarTabs:Hide();
end

-- This makes sure the update only happens once at the end of the frame
function MCF_PaperDollFrame_QueuedUpdate(self)
	MCF_PaperDollFrame_UpdateStats();
	self:SetScript("OnUpdate", nil);
end

function MCF_PaperDollFrame_UpdateSidebarTabs()
	for i = 1, #MCF_PAPERDOLL_SIDEBARS do
		local tab = _G["PaperDollSidebarTab"..i];
		if (tab) then
			if (_G[MCF_PAPERDOLL_SIDEBARS[i].frame]:IsShown()) then
				tab.Hider:Hide();
				tab.Highlight:Hide();
				tab.TabBg:SetTexCoord(0.01562500, 0.79687500, 0.78906250, 0.95703125);
			else
				tab.Hider:Show();
				tab.Highlight:Show();
				tab.TabBg:SetTexCoord(0.01562500, 0.79687500, 0.61328125, 0.78125000);
			end
		end
	end
end

function MCF_PaperDollFrame_SetSidebar(self, index)
	if (not _G[MCF_PAPERDOLL_SIDEBARS[index].frame]:IsShown()) then
		for i = 1, #MCF_PAPERDOLL_SIDEBARS do
			_G[MCF_PAPERDOLL_SIDEBARS[i].frame]:Hide();
		end
		_G[MCF_PAPERDOLL_SIDEBARS[index].frame]:Show();
		PaperDollFrame.currentSideBar = _G[MCF_PAPERDOLL_SIDEBARS[index].frame];
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
		MCF_PaperDollFrame_UpdateSidebarTabs();
	end
end

function MCF_CharacterFrame_Collapse()
	--[[ CharacterFrame:SetWidth(PANEL_DEFAULT_WIDTH + 46); ]]
    -- Setting default texture coordinates
    PaperDollFrameBg:SetPoint("BOTTOMRIGHT", CharacterFrame, "BOTTOMRIGHT", -36, 78);
    PaperDollFrameTitleBg:SetPoint("TOPRIGHT", CharacterFrame, "TOPRIGHT", -35, -17);
    PaperDollFrameTopRightCorner:SetPoint("TOPRIGHT", CharacterFrame, "TOPRIGHT", -32, -13);
    PaperDollFrameTopTileStreaks:SetPoint("TOPRIGHT", CharacterFrame, "TOPRIGHT", -34, -35);
    PaperDollFrameBotRightCorner:SetPoint("BOTTOMRIGHT", CharacterFrame, "BOTTOMRIGHT", -32, 70);
    -- Moving CharacterFrameCloseButton
    CharacterFrameCloseButton:SetPoint("TOPRIGHT", CharacterFrame, "TOPRIGHT", -28, -9);
    -- Fixing CharacterNameFrame coordinates
    CharacterNameFrame:ClearAllPoints();
    CharacterNameFrame:SetPoint("TOP", CharacterModelFrame, "TOP", 4, 59);
	CharacterNameText:SetSize(218, 12);
    -- Fixing CharacterLevelText coordinates
    CharacterLevelText:SetPoint("TOP", CharacterNameText, "TOP", 0, -31);

	CharacterFrame.Expanded = false;
	CharacterFrameExpandButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
	CharacterFrameExpandButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down");
	CharacterFrameExpandButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
	
	for i = 1, #MCF_PAPERDOLL_SIDEBARS do
		_G[MCF_PAPERDOLL_SIDEBARS[i].frame]:Hide();
	end
	
	CharacterFrameInsetRight:Hide();
	UpdateUIPanelPositions(CharacterFrame);
	MCF_PaperDollFrame_SetLevel();
end

function MCF_CharacterFrame_Expand()
	--[[ CharacterFrame:SetWidth(MCF_CHARACTERFRAME_EXPANDED_WIDTH); ]]
    -- Setting texture coordinates in frame's expanded state
    PaperDollFrameBg:SetPoint("BOTTOMRIGHT", CharacterFrame, "BOTTOMRIGHT", -36 + 202, 78);
    PaperDollFrameTitleBg:SetPoint("TOPRIGHT", CharacterFrame, "TOPRIGHT", -35 + 202, -17);
    PaperDollFrameTopRightCorner:SetPoint("TOPRIGHT", CharacterFrame, "TOPRIGHT", -32 + 202, -13);
    PaperDollFrameTopTileStreaks:SetPoint("TOPRIGHT", CharacterFrame, "TOPRIGHT", -34 + 202, -35);
    PaperDollFrameBotRightCorner:SetPoint("BOTTOMRIGHT", CharacterFrame, "BOTTOMRIGHT", -32 + 202, 70);
    -- Moving CharacterFrameCloseButton
    CharacterFrameCloseButton:SetPoint("TOPRIGHT", CharacterFrame, "TOPRIGHT", -28 + 202, -9);
    -- Fixing CharacterNameFrame coordinates
    CharacterNameFrame:ClearAllPoints();
    CharacterNameFrame:SetPoint("TOP", CharacterModelFrame, "TOP", 2 + 101, 59);
	CharacterNameText:SetSize(420, 12);
    -- Fixing CharacterLevelText coordinates
    CharacterLevelText:SetPoint("TOP", CharacterNameText, "TOP", 0, -31);

	CharacterFrame.Expanded = true;
	CharacterFrameExpandButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
	CharacterFrameExpandButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down");
	CharacterFrameExpandButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled");
	if (PaperDollFrame:IsShown() and PaperDollFrame.currentSideBar) then
		PaperDollFrame.currentSideBar:Show();
	else
		CharacterStatsPane:Show();
	end
	MCF_PaperDollFrame_UpdateSidebarTabs();
	CharacterFrameInsetRight:Show();
	UpdateUIPanelPositions(CharacterFrame);
	MCF_PaperDollFrame_SetLevel();
end

function MCF_GetPrimaryTalentTree(tab)
	local cache = {};
	if (tab) then
		TalentFrame_UpdateSpecInfoCache(cache, false, false, tab);
	else
		TalentFrame_UpdateSpecInfoCache(cache, false, false, GetActiveTalentGroup());
	end
	return cache.primaryTabIndex;
end

function MCF_PaperDollFrame_SetLevel()
	local primaryTalentTree = MCF_GetPrimaryTalentTree();
	local classDisplayName, class = UnitClass("player"); 
	local classColor = RAID_CLASS_COLORS[class];
	local classColorString = format("ff%.2x%.2x%.2x", classColor.r * 255, classColor.g * 255, classColor.b * 255);
	local specName, _;
	
	if (primaryTalentTree) then
		specName = GetTalentTabInfo(primaryTalentTree);
	end
	
	if (specName and specName ~= "") then
		CharacterLevelText:SetFormattedText(L["MCF_PLAYER_LEVEL"], UnitLevel("player"), classColorString, specName, classDisplayName);
	else
		CharacterLevelText:SetFormattedText(L["MCF_PLAYER_LEVEL_NO_SPEC"], UnitLevel("player"), classColorString, classDisplayName);
	end
	
	-- Hack: if the string is very long, move it a bit so that it has more room (although it will no longer be centered)
	if (CharacterLevelText:GetWidth() > 210) then
		if (CharacterFrameInsetRight:IsVisible()) then
			--[[ CharacterLevelText:SetPoint("TOP", -10, -36); ]]
			CharacterLevelText:AdjustPointsOffset(-10, 0);
		else
			--[[ CharacterLevelText:SetPoint("TOP", 10, -36); ]]
			CharacterLevelText:AdjustPointsOffset(10, 0);
		end
	else
		--[[ CharacterLevelText:SetPoint("TOP", 0, -36); ]]
		CharacterLevelText:AdjustPointsOffset(0, 0);
	end
end

function MCF_CharacterFrame_UpdatePortrait()
	local masteryIndex = MCF_GetPrimaryTalentTree();
	if (masteryIndex == 0) then
		local _, class = UnitClass("player");
		CharacterFramePortrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
		CharacterFramePortrait:SetTexCoord(unpack(CLASS_ICON_TCOORDS[class]));
	else
		local _, icon, _, iconName = GetTalentTabInfo(masteryIndex);

		CharacterFramePortrait:SetTexCoord(0, 1, 0, 1);
		SetPortraitToTexture(CharacterFramePortrait, icon);
	end
end
-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local RareScanner = LibStub("AceAddon-3.0"):NewAddon("RareScanner", "AceConsole-3.0")

local ADDON_NAME, private = ...

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- LibAbout frames
local LibAboutPanel = LibStub:GetLibrary("LibAboutPanel-2.0RS", true)

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSEventDB = private.ImportLib("RareScannerEventDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSMapDB = private.ImportLib("RareScannerMapDB")
local RSCollectionsDB = private.ImportLib("RareScannerCollectionsDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSQuestTracker = private.ImportLib("RareScannerQuestTracker")
local RSRoutines = private.ImportLib("RareScannerRoutines")
local RSProvider = private.ImportLib("RareScannerProvider")
local RSHyperlinks = private.ImportLib("RareScannerHyperlinks")

-- RareScanner services
local RSButtonHandler = private.ImportLib("RareScannerButtonHandler")
local RSRespawnTracker = private.ImportLib("RareScannerRespawnTracker")
local RSMap = private.ImportLib("RareScannerMap")
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSLoot = private.ImportLib("RareScannerLoot")
local RSAudioAlerts = private.ImportLib("RareScannerAudioAlerts")
local RSEventHandler = private.ImportLib("RareScannerEventHandler")
local RSEntityStateHandler = private.ImportLib("RareScannerEntityStateHandler")
local RSCommandLine = private.ImportLib("RareScannerCommandLine")
local RSRecentlySeenTracker = private.ImportLib("RareScannerRecentlySeenTracker")

-- RareScanner other addons integration services
local RSTomtom = private.ImportLib("RareScannerTomtom")

-- Main button
local scanner_button = CreateFrame("Button", RSConstants.RS_BUTTON_NAME, UIParent, "SecureActionButtonTemplate, BackdropTemplate")
scanner_button:Hide();
scanner_button:SetIgnoreParentScale(true)
scanner_button:SetFrameStrata("MEDIUM")
scanner_button:SetFrameLevel(200)
scanner_button:SetSize(200, 50)
scanner_button:SetScale(0.8)
scanner_button:RegisterForClicks("RightButtonUp", "LeftButtonUp")
scanner_button:SetAttribute("type1", "macro")
scanner_button:SetAttribute("type2", "closebutton")
scanner_button:SetScript("PostClick", function(self, button)
	if (button == "RightButton") then
		return
	end
	
	-- Just in case they click too fast and the OnHide event is also triggered
	if (not self.entityID) then
		return
	end
	
	-- Set animation on npcs
	if (RSConstants.IsNpcAtlas(self.atlasName) and RSConfigDB.IsShowingAnimationForNpcs() and RSConfigDB.GetAnimationForNpcs() ~= RSConstants.MAP_ANIMATIONS_ON_FOUND) then
		RSRecentlySeenTracker.AddPendingAnimation(tonumber(self.entityID), self.mapID, self.x, self.y, true)
	-- Set animation on containers
	elseif (RSConstants.IsContainerAtlas(self.atlasName) and RSConfigDB.IsShowingAnimationForContainers() and RSConfigDB.GetAnimationForContainers() ~= RSConstants.MAP_ANIMATIONS_ON_FOUND) then
		RSRecentlySeenTracker.AddPendingAnimation(tonumber(self.entityID), self.mapID, self.x, self.y, true)
	-- Set animation on events
	elseif (RSConstants.IsEventAtlas(self.atlasName) and RSConfigDB.IsShowingAnimationForEvents() and RSConfigDB.GetAnimationForEvents() ~= RSConstants.MAP_ANIMATIONS_ON_FOUND) then
		RSRecentlySeenTracker.AddPendingAnimation(tonumber(self.entityID), self.mapID, self.x, self.y, true)
	end
	
	-- Add waypoints
	if (RSConfigDB.IsTomtomSupportEnabled() and not RSConfigDB.IsAddingTomtomWaypointsAutomatically()) then
		RSTomtom.AddTomtomWaypoint(self.mapID, self.x, self.y, self.name)
	end
end)
scanner_button.closebutton = function(self)
	if (not InCombatLockdown()) then
		self.CloseButton:Click()
	end
end
scanner_button:SetNormalTexture([[Interface\AchievementFrame\UI-Achievement-Parchment-Horizontal-Desaturated]])
scanner_button:SetBackdrop({ tile = true, edgeSize = 16, edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]] })
scanner_button:SetBackdropBorderColor(0, 0, 0)
scanner_button:SetPoint("BOTTOM", UIParent, 0, 128)
scanner_button:SetMovable(true)
scanner_button:SetUserPlaced(true)
scanner_button:SetClampedToScreen(true)
scanner_button:RegisterForDrag("LeftButton")

scanner_button:SetScript("OnDragStart", function(self)
	if (not RSConfigDB.IsLockingPosition()) then
		self:StartMoving()
	end
end)
scanner_button:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	RSGeneralDB.SetButtonPositionCoordinates(self:GetLeft(), self:GetBottom())
end)
scanner_button:SetScript("OnEnter", function(self)
	self:SetBackdropBorderColor(0.9, 0.9, 0.9)
end)
scanner_button:SetScript("OnLeave", function(self)
	self:SetBackdropBorderColor(0, 0, 0)
end)
scanner_button:SetScript("OnHide", function(self)
	self.entityID = nil
	self.name = nil
	self.NextButton:Reset()
	self.PreviousButton:Reset()
end)

-- Model view
scanner_button.ModelView = CreateFrame("PlayerModel", "mxpplayermodel", scanner_button)
scanner_button.ModelView:ClearAllPoints()
scanner_button.ModelView:SetPoint("TOP", 0 , 122) -- bottom left corner 2px separation from scanner_button's top left corner
scanner_button.ModelView:SetSize(120, 120)
scanner_button.ModelView:SetScale(1.25)

local Background = scanner_button:GetNormalTexture()
Background:SetDrawLayer("BACKGROUND")
Background:ClearAllPoints()
Background:SetPoint("BOTTOMLEFT", 3, 3)
Background:SetPoint("TOPRIGHT", -3, -3)
Background:SetTexCoord(0, 1, 0, 0.25)

-- Title
local TitleBackground = scanner_button:CreateTexture(nil, "BORDER")
TitleBackground:SetTexture([[Interface\AchievementFrame\UI-Achievement-RecentHeader]])
TitleBackground:SetPoint("TOPRIGHT", -5, -7)
TitleBackground:SetPoint("LEFT", 5, 0)
TitleBackground:SetSize(180, 10)
TitleBackground:SetTexCoord(0, 1, 0, 1)
TitleBackground:SetAlpha(0.8)

scanner_button.Title = scanner_button:CreateFontString(nil, "OVERLAY", "GameFontNormal", 1)
scanner_button.Title:SetNonSpaceWrap(true)
scanner_button.Title:SetPoint("TOPLEFT", TitleBackground, 0, 0)
scanner_button.Title:SetPoint("RIGHT", TitleBackground)
scanner_button.Title:SetTextColor(1, 1, 1, 1)
scanner_button:SetFontString(scanner_button.Title)

local Description = scanner_button:CreateFontString(nil, "OVERLAY", "SystemFont_Tiny")
Description:SetPoint("BOTTOMLEFT", TitleBackground, 0, -12)
Description:SetPoint("RIGHT", -8, 0)
Description:SetTextHeight(6)
Description:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)

scanner_button.Description_text = scanner_button:CreateFontString(nil, "OVERLAY", "GameFontWhiteTiny")
scanner_button.Description_text:SetPoint("TOPLEFT", Description, "BOTTOMLEFT", 0, -4)
scanner_button.Description_text:SetPoint("RIGHT", Description)

-- Close button
scanner_button.CloseButton = CreateFrame("Button", "CloseButton", scanner_button, "UIPanelCloseButton")
scanner_button.CloseButton:SetPoint("BOTTOMRIGHT", 0, 1)
scanner_button.CloseButton:SetSize(22, 22)
scanner_button.CloseButton:HookScript("OnClick", function(self)
	RSTomtom.RemoveCurrentTomtomWaypoint();
end)

-- Filtering buttons
scanner_button.FilterEntityButton = CreateFrame("Button", "FilterEntityButton", scanner_button, "UIPanelCloseButtonNoScripts")
scanner_button.FilterEntityButton:SetPoint("BOTTOMLEFT", 5, 5)
scanner_button.FilterEntityButton:SetSize(16, 16)
scanner_button.UnFilterEntityButton = CreateFrame("Button", "FilterEntityButton", scanner_button, "UIPanelCloseButtonNoScripts")
scanner_button.UnFilterEntityButton:SetPoint("BOTTOMLEFT", 5, 5)
scanner_button.UnFilterEntityButton:SetSize(16, 16)

local StopTexture = scanner_button.FilterEntityButton:CreateTexture()
StopTexture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\stop_icons.blp")
StopTexture:SetSize(16, 16)
StopTexture:SetTexCoord(0, 0.3, 0, 0.3)
StopTexture:SetPoint("CENTER")
scanner_button.FilterEntityButton:SetNormalTexture(StopTexture)

StopTexture = scanner_button.FilterEntityButton:CreateTexture()
StopTexture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\stop_icons.blp")
StopTexture:SetSize(16, 16)
StopTexture:SetTexCoord(0, 0.3, 0.65, 0.95)
StopTexture:SetPoint("CENTER")
scanner_button.FilterEntityButton:SetPushedTexture(StopTexture)

local GoTexture = scanner_button.UnFilterEntityButton:CreateTexture()
GoTexture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\stop_icons.blp")
GoTexture:SetSize(16, 16)
GoTexture:SetTexCoord(0.36, 0.65, 0, 0.3)
GoTexture:SetPoint("CENTER")
scanner_button.UnFilterEntityButton:SetNormalTexture(GoTexture)

GoTexture = scanner_button.UnFilterEntityButton:CreateTexture()
GoTexture:SetTexture("Interface\\AddOns\\RareScanner\\Media\\Textures\\stop_icons.blp")
GoTexture:SetSize(16, 16)
GoTexture:SetTexCoord(0.36, 0.65, 0.65, 0.95)
GoTexture:SetPoint("CENTER")
scanner_button.UnFilterEntityButton:SetPushedTexture(GoTexture)

scanner_button.FilterEntityButton:SetScript("OnClick", function(self)
	local entityID = self:GetParent().entityID
	if (entityID) then
		if (RSConstants.IsNpcAtlas(self:GetParent().atlasName)) then
			if (RSConfigDB.GetDefaultNpcFilter() == RSConstants.ENTITY_FILTER_WORLDMAP) then
				RSConfigDB.SetNpcFiltered(entityID, RSConstants.ENTITY_FILTER_ALL)
			else
				RSConfigDB.SetNpcFiltered(entityID)
			end
		elseif (RSConstants.IsContainerAtlas(self:GetParent().atlasName)) then
			-- Filter every container with the same name
			local containerName = RSContainerDB.GetContainerName(entityID)
			if (containerName) then
				for containerID, _ in pairs(RSContainerDB.GetAllInternalContainerInfo()) do
					local name = RSContainerDB.GetContainerName(containerID)
					if (name and name == containerName) then
						if (RSConfigDB.GetDefaultContainerFilter() == RSConstants.ENTITY_FILTER_WORLDMAP) then
							RSConfigDB.SetContainerFiltered(containerID, RSConstants.ENTITY_FILTER_ALL)
						else
							RSConfigDB.SetContainerFiltered(containerID)
						end
					end
				end
			-- Filter only this container
			else			
				if (RSConfigDB.GetDefaultContainerFilter() == RSConstants.ENTITY_FILTER_WORLDMAP) then
					RSConfigDB.SetContainerFiltered(entityID, RSConstants.ENTITY_FILTER_ALL)
				else
					RSConfigDB.SetContainerFiltered(entityID)
				end
			end
		else
			-- Filter every event with the same name
			local eventName = RSEventDB.GetEventName(entityID)
			if (eventName) then
				for eventID, name in pairs(RSEventDB.GetAllEventNames()) do
					if (name == eventName) then
						if (RSConfigDB.GetDefaultEventFilter() == RSConstants.ENTITY_FILTER_WORLDMAP) then
							RSConfigDB.SetEventFiltered(eventID, RSConstants.ENTITY_FILTER_ALL)
						else
							RSConfigDB.SetEventFiltered(eventID)
						end
					end
				end
			end
		end
		
		RSLogger:PrintMessage(string.format(AL["ENTITY_FILTERED"], self:GetParent().Title:GetText()))
		scanner_button.UnFilterEntityButton:Show()
		scanner_button.FilterEntityButton:Hide()
	end
end)
scanner_button.FilterEntityButton:SetScript("OnEnter", function(self)
	if (not self.tooltip) then
		self.tooltip = CreateFrame("GameTooltip", "StopTooltip", scanner_button, "GameTooltipTemplate");
		self.tooltip:SetMinimumWidth(150)
		self.tooltip:SetScale(0.8)
	end

	self.tooltip:SetOwner(scanner_button, "ANCHOR_LEFT")
	self.tooltip:SetText(AL["DISABLE_SEARCHING_TOOLTIP"])
	self.tooltip:AddLine(AL["DISABLE_SEARCHING_TOOLTIP_DESC"], 1, 1, 1, true)
	self.tooltip:Show()
end)
scanner_button.FilterEntityButton:SetScript("OnLeave", function(self)
	self.tooltip:Hide()
end)

scanner_button.UnFilterEntityButton:SetScript("OnClick", function(self)
	local entityID = self:GetParent().entityID
	if (entityID) then
		if (RSConstants.IsNpcAtlas(self:GetParent().atlasName)) then
			RSConfigDB.DeleteNpcFiltered(entityID)
		elseif (RSConstants.IsContainerAtlas(self:GetParent().atlasName)) then
			RSConfigDB.DeleteContainerFiltered(entityID)
		elseif (RSConstants.IsEventAtlas(self:GetParent().atlasName)) then
			RSConfigDB.DeleteEventFiltered(entityID)
		end
		
		scanner_button.UnFilterEntityButton:Hide()
		scanner_button.FilterEntityButton:Show()
	end
end)
scanner_button.UnFilterEntityButton:SetScript("OnEnter", function(self)
	if (not self.tooltip) then
		self.tooltip = CreateFrame("GameTooltip", "GoTooltip", scanner_button, "GameTooltipTemplate");
		self.tooltip:SetMinimumWidth(150)
		self.tooltip:SetScale(0.8)
	end

	self.tooltip:SetOwner(scanner_button, "ANCHOR_LEFT")
	self.tooltip:SetText(AL["ENABLE_SEARCHING_TOOLTIP"])
	self.tooltip:AddLine(AL["ENABLE_SEARCHING_TOOLTIP_DESC"], 1, 1, 1, true)
	self.tooltip:Show()
end)
scanner_button.UnFilterEntityButton:SetScript("OnLeave", function(self)
	self.tooltip:Hide()
end)

-- Loot bar
scanner_button.LootBar = CreateFrame("Frame", "LootBar", scanner_button)
scanner_button.LootBar.itemFramesPool = CreateFramePool("FRAME", scanner_button.LootBar, "RSLootTemplate");
scanner_button.LootBar.itemFramesPool.InitItemList = function(self, atlasName, entityID)
	self:ReleaseAll()
	
	-- Cancels previous requests
	scanner_button.LootBar:SetScript("OnUpdate", nil)
	
	if (not atlasName or not entityID) then
		return
	end
	
	local parent = self
	parent.items = {}
	parent.totalLoaded = 0

	-- Extract entity loot
	local updateCacheItemRoutine = RSRoutines.LoopRoutineNew()
	if (RSConstants.IsNpcAtlas(atlasName) and RSNpcDB.GetNpcLoot(entityID)) then
		if (RSConfigDB.IsFilteringByExplorerResults()) then
			local items = RSCollectionsDB.GetEntityCollectionsLoot(entityID, RSConstants.ITEM_SOURCE.NPC)
			updateCacheItemRoutine:Init(function() return items end, 3, nil, nil, entityID)
			parent.totalItems = RSUtils.GetTableLength(items)
		else
			updateCacheItemRoutine:Init(RSNpcDB.GetNpcLoot, 3, nil, nil, entityID)
			parent.totalItems = RSUtils.GetTableLength(RSNpcDB.GetNpcLoot(entityID))
		end
	elseif (RSConstants.IsContainerAtlas(atlasName) and RSContainerDB.GetContainerLoot(entityID)) then
		if (RSConfigDB.IsFilteringByExplorerResults()) then
			local items = RSCollectionsDB.GetEntityCollectionsLoot(entityID, RSConstants.ITEM_SOURCE.CONTAINER)
			updateCacheItemRoutine:Init(function() return items end, 3, nil, nil, entityID)
			parent.totalItems = RSUtils.GetTableLength(items)
		else
			updateCacheItemRoutine:Init(RSContainerDB.GetContainerLoot, 3, nil, nil, entityID)
			parent.totalItems = RSUtils.GetTableLength(RSContainerDB.GetContainerLoot(entityID))
		end
	else
		return
	end
	
	scanner_button.LootBar:SetScript("OnUpdate", function()
		local finished = updateCacheItemRoutine:Run(function(context, _, itemID)
			if (C_Item.DoesItemExistByID(itemID)) then
				parent:UpdateCacheItem(itemID, entityID)
			else
				parent.totalItems = self.totalItems - 1
				RSLogger:PrintDebugMessage(string.format("Detectado ITEM [%s] para la entidad [%s] que no existe!.", itemID, entityID))
			end
		end)
		if (finished) then
			scanner_button.LootBar:SetScript("OnUpdate", nil)
		end
	end)
end
scanner_button.LootBar.itemFramesPool.UpdateCacheItem = function(self, itemID, entityID)
	if (not itemID or not self.items) then
		return
	end
	
	-- If enough items to show ignore the rest
	if (self.totalLoaded >= RSConfigDB.GetMaxNumItemsToShow()) then
		return
	end
	
	-- Otherwise try to add the item
	self.items[itemID] = {}
	self.items[itemID].loaded = false
	
	local item = Item:CreateFromItemID(itemID)
	if (not item) then
		return
	end
	
	local success, err = pcall(function()
		item:ContinueOnItemLoad(function()
			if (not item:GetItemID()) then
				return
			end
			
			local itemIDr, _, _, itemEquipLoc, _, itemClassID, itemSubClassID = C_Item.GetItemInfoInstant(item:GetItemID())
			if (not itemIDr) then
				return
			end
			
			if (RSLoot.IsFiltered(entityID, itemID, item:GetItemLink(), item:GetItemQuality(), itemEquipLoc, itemClassID, itemSubClassID)) then
				self.items[item:GetItemID()] = nil
				self.totalItems = self.totalItems - 1
			elseif (self.items[item:GetItemID()]) then
				self.items[item:GetItemID()].loaded = true
				self.totalLoaded = self.totalLoaded + 1
			end
			
			if (self.totalLoaded >= RSConfigDB.GetMaxNumItemsToShow() and self:GetNumActive() == 0) then
				self:ShowIfReady()
			elseif (self.totalItems == self.totalLoaded) then
				self:ShowIfReady()
			end
		end)
	end)
	
	if (not success) then
	    --print(string.format("Error al ejecutar ContinueOnItemLoad[%s]:",itemID), err)
		self.items[itemID] = nil
	    self.totalItems = self.totalItems - 1
	    
	    if (self.totalLoaded >= RSConfigDB.GetMaxNumItemsToShow() and self:GetNumActive() == 0) then
			self:ShowIfReady()
		elseif (self.totalItems == self.totalLoaded) then
			self:ShowIfReady()
		end
	end
end
scanner_button.LootBar.itemFramesPool.ShowIfReady = function(self)
	if (not self.items) then
		return
	end
	
	local currentIndex = 1
	for itemID, _ in pairs (self.items) do
		if (self.items[itemID].loaded) then
			if (currentIndex <= RSConfigDB.GetMaxNumItemsToShow()) then
				local itemFrame = self:Acquire()
				itemFrame:AddItem(itemID, self:GetNumActive())
				currentIndex = currentIndex + 1
			else
				break
			end
		end
	end
end
scanner_button.LootBar.LootBarToolTip = CreateFrame("GameTooltip", "LootBarToolTip", scanner_button, "GameTooltipTemplate")
scanner_button.LootBar.LootBarToolTip:SetScale(0.9)
scanner_button.LootBar.LootBarToolTipComp1 = CreateFrame("GameTooltip", "LootBarToolTipComp1", nil, "GameTooltipTemplate")
scanner_button.LootBar.LootBarToolTipComp1:SetScale(0.7)
scanner_button.LootBar.LootBarToolTipComp2 = CreateFrame("GameTooltip", "LootBarToolTipComp2", nil, "GameTooltipTemplate")
scanner_button.LootBar.LootBarToolTipComp2:SetScale(0.7)
scanner_button.LootBar.LootBarToolTip.shoppingTooltips = { scanner_button.LootBar.LootBarToolTipComp1, scanner_button.LootBar.LootBarToolTipComp2 }

-- Show navigation buttons
scanner_button.NextButton = CreateFrame("Frame", "NextButton", scanner_button, "RSRightNavTemplate")
scanner_button.NextButton:Hide()
scanner_button.PreviousButton = CreateFrame("Frame", "PreviousButton", scanner_button, "RSLeftNavTemplate")
scanner_button.PreviousButton:Hide()

-- Register events
RSEventHandler.RegisterEvents(scanner_button, RareScanner)

function scanner_button:SimulateRareFound(npcID, objectGUID, name, x, y, atlasName, trackingSystem, isNavigating)
	local vignetteInfo = {}
	vignetteInfo.atlasName = atlasName
	vignetteInfo.id = npcID
	vignetteInfo.name = name
	vignetteInfo.objectGUID = objectGUID or string.format("a-a-a-a-a-%s-%s", npcID, time())
	vignetteInfo.x = x
	vignetteInfo.y = y
	vignetteInfo.simulated = true
	vignetteInfo.trackingSystem = trackingSystem
	RSButtonHandler.AddAlert(self, vignetteInfo, isNavigating)
end

function scanner_button:DisplayMessages(entityID, name)
	if (name) then
		if (RSConfigDB.IsDisplayingRaidWarning()) then
			RaidNotice_AddMessage(RaidWarningFrame, string.format(AL["ALARM_MESSAGE"], name), ChatTypeInfo["RAID_WARNING"], RSConstants.RAID_WARNING_SHOWING_TIME)
		end

		-- Print message in chat if user wants
		if (RSConfigDB.IsDisplayingChatMessages()) then
			local hyperlink = RSHyperlinks.GetEntityHyperLink(entityID, name)
			RSLogger:PrintMessage(string.format(AL["ALARM_MESSAGE"], hyperlink and hyperlink or name))
		end
	end
end

-- Hide action
function scanner_button:HideButton()
	if (not InCombatLockdown()) then
		GameTooltip:Hide()
		scanner_button.ModelView:ClearModel()
		scanner_button.ModelView:Hide()
		scanner_button:Hide()
	else
		scanner_button.pendingToHide = true
	end
end

-- Show action
function scanner_button:ShowButton()
	if (not self.entityID) then
		return
	end

	-- Resizes the button
	self:SetScale(RSConfigDB.GetButtonScale())

	-- Sets the name
	self.Title:SetText(self.preEvent and string.format(AL["PRE_EVENT"], self.name) or self.name)

	-- show loot bar
	if (RSConfigDB.IsDisplayingLootBar()) then
		self.LootBar.itemFramesPool:InitItemList(self.atlasName, self.entityID)
	else
		self.LootBar.itemFramesPool:ReleaseAll()
	end

	-- show navigation arrows
	if (RSConfigDB.IsDisplayingNavigationArrows()) then
		if (self.NextButton:EnableNextButton()) then
			self.NextButton:Show()
		else
			self.NextButton:Hide()
		end

		if (self.PreviousButton:EnablePreviousButton()) then
			self.PreviousButton:Show()
		else
			self.PreviousButton:Hide()
		end
	end

	-- Show button, model and loot panel
	if (RSConstants.IsNpcAtlas(self.atlasName)) then
		self.Description_text:SetText(AL["CLICK_TARGET"])

		-- show model
		if (self.displayID and RSConfigDB.IsDisplayingModel()) then
			self.ModelView:SetDisplayInfo(self.displayID)
			self.ModelView:Show()
		else
			self.ModelView:Hide()
		end
	else
		self.Description_text:SetText(AL["NOT_TARGETEABLE"])

		-- hide model if displayed
		self.ModelView:ClearModel()
		self.ModelView:Hide()
	end
		
	-- Config the macro
	local macrotext = "/cleartarget\n/targetexact "..self.name
	if (RSConfigDB.IsDisplayingMarkerOnTarget()) then
		macrotext = string.format("%s\n/tm %s", macrotext, RSConfigDB.GetMarkerOnTarget())
	end
	
	self:SetAttribute("macrotext", macrotext);
		
	-- Toggle filter buttons
	if ((RSConstants.IsNpcAtlas(self.atlasName) and (RSConfigDB.GetNpcFiltered(self.entityID) == nil or RSConfigDB.GetNpcFiltered(self.entityID) == RSConstants.ENTITY_FILTER_WORLDMAP))
		or (RSConstants.IsContainerAtlas(self.atlasName) and (RSConfigDB.GetContainerFiltered(self.entityID) == nil or RSConfigDB.GetContainerFiltered(self.entityID) == RSConstants.ENTITY_FILTER_WORLDMAP))
		or (RSConstants.IsEventAtlas(self.atlasName) and (RSConfigDB.GetEventFiltered(self.entityID) == nil or RSConfigDB.GetEventFiltered(self.entityID) == RSConstants.ENTITY_FILTER_WORLDMAP))) then
		self.FilterEntityButton:Show()
		self.UnFilterEntityButton:Hide()
	else
		self.UnFilterEntityButton:Show()
		self.FilterEntityButton:Hide()
	end
	
	-- show button
	self:Show()

	-- set the time to auto hide
	self:StartHideTimer()
end

local AUTOHIDING_TIMER
function scanner_button:StartHideTimer()
	if (RSConfigDB.GetAutoHideButtonTime() > 0) then
		if (AUTOHIDING_TIMER) then
			AUTOHIDING_TIMER:Cancel()
		end
		AUTOHIDING_TIMER = C_Timer.NewTimer(RSConfigDB.GetAutoHideButtonTime(), function()
			scanner_button:HideButton()
		end)
	end
end

----------------------------------------------
-- Testing
----------------------------------------------
function RareScanner:Test()
	local npcTestName = "Time-Lost Proto-Drake"
	local npcTestID = 32491
	local npcTestDisplayID = 26711

	scanner_button.entityID = npcTestID
	scanner_button.name = npcTestName
	scanner_button.displayID = npcTestDisplayID
	scanner_button.mapID = 120
	scanner_button.x = 2800
	scanner_button.y = 6540
	scanner_button.atlasName = RSConstants.NPC_VIGNETTE
	scanner_button.Title:SetText(npcTestName)
	scanner_button:DisplayMessages(npcTestName)
	RSAudioAlerts.PlaySoundAlert(RSConstants.NPC_VIGNETTE)
	scanner_button.Description_text:SetText(AL["CLICK_TARGET"])

	if (not InCombatLockdown()) then
		scanner_button:ShowButton()
		scanner_button.FilterEntityButton:Hide()
	end

	RSLogger:PrintMessage("test launched")
end

function RareScanner:ResetPosition()
	scanner_button:ClearAllPoints()
	scanner_button:SetPoint("BOTTOM", UIParent, 0, 128)
	RSGeneralDB.SetButtonPositionCoordinates(scanner_button:GetLeft(), scanner_button:GetBottom())
end

----------------------------------------------
-- Loading addon methods
----------------------------------------------
function RareScanner:OnInitialize()
	-- Init database
	self:InitializeDataBase()
	
	-- Store providers for refreshing
	private.mapProviders = {}
	
	-- Adds about panel to wow options
	if (LibAboutPanel) then
		self.optionsFrame = LibAboutPanel:CreateAboutPanel("RareScanner")
	end

	-- Initialize setup panels
	self:SetupOptions()

	-- Initialize not discovered lists
	RSMap.InitializeNotDiscoveredLists()

	-- Setup our map provider
	local provider = CreateFromMixins(RareScannerDataProviderMixin)
	WorldMapFrame:AddDataProvider(provider);
	RSProvider.AddDataProvider(provider)

	-- Add search inputbox
	local searchFrame = CreateFrame("FRAME", nil, WorldMapFrame, "WorldMapRSSearchTemplate");
	searchFrame:SetPoint("CENTER", WorldMapFrame:GetCanvasContainer(), "TOP", 0, 0);
	searchFrame.relativeFrame = WorldMapFrame:GetCanvasContainer()

	-- Add options button to the world map
	RSMap.LoadWorldMapButton()
	
	-- Add minimap icon
	RSMinimap.LoadMinimapButton()

	-- Load completed quests
	RSQuestTracker.CacheAllCompletedQuestIDs()

	-- Initialize special events
	self:InitializeSpecialEvents()
	
	-- Hook hyperlink
	RSHyperlinks.HookHyperLinks()

	-- Refresh minimap
	C_Timer.NewTicker(2, function()
		RSMinimap.RefreshAllData()
	end)
	
	-- Initialize command line
	RSCommandLine.Initialize(self)

	RSLogger:PrintDebugMessage("Cargado")
end

function RareScanner:InitializeSpecialEvents()
	RareScanner:ShadowlandsPrePatch_Initialize()
end

local function RefreshDatabaseData(previousDbVersion)
	RareScanner.db:RegisterDefaults(RSConstants.PROFILE_DEFAULTS)
		
	-- Creates a chain of routines to execute in order
	local routines = {}
		
	-- Checks again if the rare names DB is totally updated
	local currentDbVersion = RSGeneralDB.GetDbVersion()
	if (not currentDbVersion.sync) then
		local recheckRareNamesRoutine = RSRoutines.LoopRoutineNew()
		recheckRareNamesRoutine:Init(RSNpcDB.GetAllInternalNpcInfo, 1000, 
			function(context, npcID, _)
				if (not RSNpcDB.GetNpcName(npcID)) then
					RSLogger:PrintDebugMessage(string.format("NPC [%s]. Sin nombre, reintentando obtenerlo.", npcID))
				end
				if (not RSNpcDB.GetNpcName(npcID)) then
					context.sync = false
				end
			end, 
			function(context)			
				RSLogger:PrintDebugMessage(string.format("Version sincronizada: [%s]", (context.sync == nil and 'true' or 'false')))
				currentDbVersion.sync = context.sync
			end
		)
		table.insert(routines, recheckRareNamesRoutine)
	end
	
	-- Sync loot found with internal database and remove duplicates
	local lootDbVersion = RSGeneralDB.GetLootDbVersion()
	if (not lootDbVersion or lootDbVersion < RSConstants.CURRENT_LOOT_DB_VERSION) then
		RSGeneralDB.SetLootDbVersion(RSConstants.CURRENT_LOOT_DB_VERSION)
		
		local syncLocalNpcLootRoutine = RSRoutines.LoopRoutineNew()
		syncLocalNpcLootRoutine:Init(RSNpcDB.GetAllNpcsLootFound, 200, 
			function(context, npcID, npcLootFound)
				local cleanItemsList = RSUtils.FilterRepeated(npcLootFound, RSNpcDB.GetInteralNpcLoot(npcID))
				if (cleanItemsList) then
					RSNpcDB.SetNpcLootFound(npcID, cleanItemsList)
				else
					RSNpcDB.RemoveNpcLootFound(npcID)
				end
			end, 
			function(context)			
				RSLogger:PrintDebugMessage("Sincronizado loot de NPCs local con interno")
			end
		)
		table.insert(routines, syncLocalNpcLootRoutine)
		
		local syncLocalContainercLootRoutine = RSRoutines.LoopRoutineNew()
		syncLocalContainercLootRoutine:Init(RSContainerDB.GetAllContainersLootFound, 200, 
			function(context, containerID, containerLootFound)
				local cleanItemsList = RSUtils.FilterRepeated(containerLootFound, RSNpcDB.GetInteralNpcLoot(containerID))
				if (cleanItemsList) then
					RSContainerDB.SetContainerLootFound(containerID, cleanItemsList)
				else
					RSContainerDB.RemoveContainerLootFound(containerID)
				end
			end, 
			function(context)			
				RSLogger:PrintDebugMessage("Sincronizado loot de Contenedores local con interno")
			end
		)
		table.insert(routines, syncLocalContainercLootRoutine)
	end

	-- Set already killed NPCs checking questID
	-- Set alive if reset flag
	local setKilledNpcsByQuestIdRoutine = RSRoutines.LoopRoutineNew()
	setKilledNpcsByQuestIdRoutine:Init(RSNpcDB.GetAllInternalNpcInfo, 200, 
		function(context, npcID, npcInfo)
			if (npcInfo.questID) then
				for _, questID in ipairs(npcInfo.questID) do
					if (C_QuestLog.IsQuestFlaggedCompleted(questID) and not RSNpcDB.IsNpcKilled(npcID)) then
						RSLogger:PrintDebugMessage(string.format("RefreshDatabaseData. El NPC[%s] no esta marcado como muerto, pero su mision esta completada", npcID))
						-- The NPC will be tagged as dead as usual, it won't be until the next world quest reset
						-- when the RespawnTracker will decide if this NPC died forever
						RSEntityStateHandler.SetDeadNpc(npcID, true)
						break
					end
				end
			elseif (npcInfo.reset and RSNpcDB.IsNpcKilled(npcID)) then
				RSNpcDB.DeleteNpcKilled(npcID)
			end
		end, 
		function(context)			
			RSLogger:PrintDebugMessage("Identificados NPCs muertos por questID (local)")
		end
	)
	table.insert(routines, setKilledNpcsByQuestIdRoutine)

	-- Set already completed events checking questID
	local setCompletedEventsByQuestIdRoutine = RSRoutines.LoopRoutineNew()
	setCompletedEventsByQuestIdRoutine:Init(RSEventDB.GetAllInternalEventInfo, 200, 
		function(context, eventID, eventInfo)
			if (eventInfo.questID) then
				for _, questID in ipairs(eventInfo.questID) do
					if (C_QuestLog.IsQuestFlaggedCompleted(questID) and not RSEventDB.IsEventCompleted(eventID)) then
						RSLogger:PrintDebugMessage(string.format("RefreshDatabaseData. El Evento[%s] no esta marcado como completado, pero su mision esta completada", eventID))
						-- The Event will be tagged as completed as usual, it won't be until the next world quest reset
						-- when the RespawnTracker will decide if this event is completed forever
						RSEntityStateHandler.SetEventCompleted(eventID, true)
						break
					end
				end
			end
		end, 
		function(context)			
			RSLogger:PrintDebugMessage("Identificados eventos completados por questID (local)")
		end
	)
	table.insert(routines, setCompletedEventsByQuestIdRoutine)

	-- Set already completed container checking questID
	-- Set open if reset flag
	local setContainersOpenedByQuestIdRoutine = RSRoutines.LoopRoutineNew()
	setContainersOpenedByQuestIdRoutine:Init(RSContainerDB.GetAllInternalContainerInfo, 200,
		function(context, containerID, containerInfo)
			if (containerInfo.questID) then
				for _, questID in ipairs(containerInfo.questID) do
					if (C_QuestLog.IsQuestFlaggedCompleted(questID) and not RSContainerDB.IsContainerOpened(containerID)) then
						RSLogger:PrintDebugMessage(string.format("RefreshDatabaseData. El Contenedor[%s] no esta marcado como cerrado, pero su mision esta completada", containerID))
						-- The Container will be tagged as opened as usual, it won't be until the next world quest reset
						-- when the RespawnTracker will decide if this container is opened forever
						RSEntityStateHandler.SetContainerOpen(containerID, true)
						break
					end
				end
			elseif (containerInfo.reset and RSContainerDB.IsContainerOpened(containerID)) then
				RSContainerDB.DeleteContainerOpened(containerID)
			end
		end, 
		function(context)			
			RSLogger:PrintDebugMessage("Identificados contenedores abiertos por questID (local)")
		end
	)
	table.insert(routines, setContainersOpenedByQuestIdRoutine)
	
	-- Clean already killed/collected/completed entities that arent in the database
	if (not RSGeneralDB.GetLastCleanDb()) then
		local cleanKilledNpcs = RSRoutines.LoopRoutineNew()
		cleanKilledNpcs:Init(RSNpcDB.GetAllNpcsKilledRespawnTimes, 100,
			function(context, npcID, respawnTimer)
				if (not RSNpcDB.GetInternalNpcInfo(npcID) and not RSGeneralDB.GetAlreadyFoundEntity(npcID)) then
					RSNpcDB.DeleteNpcKilled(npcID)
				end
			end, 
			function(context)			
				RSLogger:PrintDebugMessage("Limpiada la base de datos de NPCs matados")
			end
		)
		table.insert(routines, cleanKilledNpcs)
		
		local cleanOpenedContainers = RSRoutines.LoopRoutineNew()
		cleanOpenedContainers:Init(RSContainerDB.GetAllContainersOpenedRespawnTimes, 100,
			function(context, containerID, respawnTimer)
				if (not RSContainerDB.GetInternalContainerInfo(containerID) and not RSGeneralDB.GetAlreadyFoundEntity(containerID)) then
					RSContainerDB.DeleteContainerOpened(containerID)
				end
			end, 
			function(context)			
				RSLogger:PrintDebugMessage("Limpiada la base de datos de contenedores abiertos")
			end
		)
		table.insert(routines, cleanOpenedContainers)
		
		local cleanCompletedEvents = RSRoutines.LoopRoutineNew()
		cleanCompletedEvents:Init(RSEventDB.GetAllEventsCompletedRespawnTimes, 100,
			function(context, eventID, respawnTimer)
				if (not RSEventDB.GetInternalEventInfo(eventID) and not RSGeneralDB.GetAlreadyFoundEntity(eventID)) then
					RSEventDB.DeleteEventCompleted(eventID)
				end
			end, 
			function(context)			
				RSLogger:PrintDebugMessage("Limpiada la base de datos de eventos completos")
			end
		)
		table.insert(routines, cleanCompletedEvents)
		RSGeneralDB.SetLastCleanDb()
	end

	-- Update entities state that are part of an achievement with criteria
	local achievementCriteriaRoutine = RSRoutines.LoopRoutineNew()
	achievementCriteriaRoutine:Init(function() return private.ACHIEVEMENT_WITH_CRITERIA end, 10,
		function(context, _, achievementID)
			for i=1, GetAchievementNumCriteria(achievementID) do
				local _, _, completed = GetAchievementCriteriaInfo(achievementID, i)
			   	if (completed) then
					for _, entityID in ipairs(private.ACHIEVEMENT_TARGET_IDS[achievementID]) do
						local containerInfo = RSContainerDB.GetInternalContainerInfo(entityID)
						if (containerInfo) then
							if (containerInfo.criteria == i and not RSContainerDB.IsContainerOpened(entityID)) then
								RSContainerDB.SetContainerOpened(entityID)
							end
						else
							local npcInfo = RSNpcDB.GetInternalNpcInfo(entityID)
							if (npcInfo) then
								if (npcInfo.criteria == i and not RSNpcDB.IsNpcKilled(entityID)) then
									RSNpcDB.SetNpcKilled(entityID)
								end
							end
						end
					end
				end
			end
		end, 
		function(context)			
			RSLogger:PrintDebugMessage("Actualizado el estado de entidades que son parte de un logro con criteria")
		end
	)
	table.insert(routines, achievementCriteriaRoutine)
		
	-- Launch all the routines in order
	local chainRoutines = RSRoutines.ChainLoopRoutineNew()
	chainRoutines:Init(routines)
	chainRoutines:Run(function(context)
		-- Initialize respawning tracker and scan the first time
		RSRespawnTracker.Init()
		
		-- Set default filters
		if (not previousDbVersion or previousDbVersion < RSConstants.DEFAULT_FILTERED_ENTITIES.version) then
			for _, containerID in ipairs(RSConstants.DEFAULT_FILTERED_ENTITIES.containers) do
				RSConfigDB.SetContainerFiltered(containerID, RSConstants.ENTITY_FILTER_ALL)
			end
			RSLogger:PrintDebugMessage("Filtradas entidades predeterminadas")
		end
		
		-- Refresh minimap
		RSMinimap.RefreshAllData(true)
	end)
	
	-- Clear previous overlay if active when closed the game
	RSGeneralDB.RemoveAllOverlayActive()
end

local function UpdateRareNamesDB(currentDbVersion)
	RSGeneralDB.AddDbVersion(RSConstants.CURRENT_DB_VERSION)

	local npcNameScannerRoutine = RSRoutines.LoopRoutineNew()
	npcNameScannerRoutine:Init(RSNpcDB.GetAllInternalNpcInfo, 100)
	
	-- Reset current database this is important when scanning tooltips the old way because they don't cache until requested twice
	RSNpcDB.InitNpcNamesDB(true)
	
	C_Timer.NewTicker(0.5, function(self)
		local finished = npcNameScannerRoutine:Run(function(context, npcID, _)
			RSNpcDB.GetNpcName(npcID, true);
		end)
	
		if (finished) then
			npcNameScannerRoutine:Reset()
			self:Cancel()			
		
			-- Sets already found NPCs as NPCs if they were found as events
			for _, npcID in ipairs (RSConstants.NPCS_WITH_EVENT_VIGNETTE) do
				local npcInfo = RSGeneralDB.GetAlreadyFoundEntity(npcID)
				if (npcInfo and npcInfo.atlasName ~= RSConstants.NPC_VIGNETTE) then
					npcInfo.atlasName =	RSConstants.NPC_VIGNETTE
					RSLogger:PrintDebugMessage(string.format("NPC [%s]. Estaba marcado como un evento, Corregido!.", npcID))
				end
			end
			
			-- Sets already found Events as Events if they were found as NPCs
			for _, eventID in ipairs (RSConstants.EVENTS_WITH_NPC_VIGNETTE) do
				local eventInfo = RSGeneralDB.GetAlreadyFoundEntity(eventID)
				if (eventInfo and eventInfo.atlasName ~= RSConstants.EVENT_VIGNETTE) then
					eventInfo.atlasName = RSConstants.EVENT_VIGNETTE
					RSLogger:PrintDebugMessage(string.format("Evento [%s]. Estaba marcado como un rare, Corregido!.", eventID))
				end
				
				-- Also clean the names database just in case it was saved as a rare NPC
				if (private.dbglobal.rare_names[GetLocale()][eventID]) then
					RSNpcDB.SetNpcName(eventID, nil)
				end
			end
			
			-- Sets already found Containers as Containers if they were found as NPCs
			for _, containerID in ipairs (RSConstants.CONTAINER_WITH_NPC_VIGNETTE) do
				local containerInfo = RSGeneralDB.GetAlreadyFoundEntity(containerID)
				if (containerInfo and containerInfo.atlasName ~= RSConstants.CONTAINER_VIGNETTE) then
					containerInfo.atlasName = RSConstants.CONTAINER_VIGNETTE
					RSLogger:PrintDebugMessage(string.format("Contenedor [%s]. Estaba marcado como un rare, Corregido!.", containerID))
				end
			end
			
			-- Remove already found entities that might be a pre event
			for preEntityID, _ in pairs (RSConstants.NPCS_WITH_PRE_EVENT) do
				RSGeneralDB.RemoveAlreadyFoundEntity(preEntityID)
			end
			for preEntityID, _ in pairs (RSConstants.CONTAINERS_WITH_PRE_EVENT) do
				RSGeneralDB.RemoveAlreadyFoundEntity(preEntityID)
			end
			
			-- Remove ignored entities
			for _, entityID in ipairs (RSConstants.IGNORED_VIGNETTES) do
				RSGeneralDB.RemoveAlreadyFoundEntity(entityID)
			end
			
			-- Clean database after update 11.0.2
			private.dbchar.not_colleted_appearances_item_ids = nil
			
			-- Reset current collections database because it isn't compatible anymore
			if (private.dbglobal.lastCollectionsScanVersion and private.dbglobal.entity_collections_loot) then
				if (type(private.dbglobal.lastCollectionsScanVersion) == "table") then
					private.dbglobal.entity_collections_loot = {}
				end
			end			
			
			-- Reset cached questIDs
			RSGeneralDB.ResetCompletedQuestDB()
			RSEventDB.ResetEventQuestIdFoundDB()
			RSNpcDB.ResetNpcQuestIdFoundDB()
			RSContainerDB.ResetContainerQuestIdFoundDB()
			
			-- Continue refreshing the rest of the database
			RefreshDatabaseData(currentDbVersion)
		end
	end);
end

function RareScanner:InitializeDataBase()
	--============================================
	-- Initialize default profiles
	--============================================

	-- Initialize loot filter list
	for categoryID, subcategories in pairs(private.ITEM_CLASSES) do
		table.foreach(subcategories, function(index, subcategoryID)
			if (not RSConstants.PROFILE_DEFAULTS.profile.loot.filteredLootCategories[categoryID]) then
				RSConstants.PROFILE_DEFAULTS.profile.loot.filteredLootCategories[categoryID] = {}
			end

			RSConstants.PROFILE_DEFAULTS.profile.loot.filteredLootCategories[categoryID][subcategoryID] = true
		end)
	end

	--============================================
	-- Initialize database
	--============================================

	self.db = LibStub("AceDB-3.0"):New("RareScannerDB", RSConstants.PROFILE_DEFAULTS, true)
	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshOptions")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshOptions")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshOptions")
	private.dbm = self.db
	private.db = self.db.profile
	private.dbchar = self.db.char
	private.dbglobal = self.db.global

	-- Initialize char database
	RSGeneralDB.InitCompletedQuestDB()
	RSNpcDB.InitNpcKilledDB()
	RSContainerDB.InitContainerOpenedDB()
	RSEventDB.InitEventCompletedDB()

	-- Initialize global database
	RSGeneralDB.InitItemInfoDB()
	RSGeneralDB.InitAlreadyFoundEntitiesDB()
	RSGeneralDB.InitRecentlySeenDB()
	RSGeneralDB.InitDbVersionDB()
	RSNpcDB.InitNpcNamesDB()
	RSNpcDB.InitNpcLootFoundDB()
	RSNpcDB.InitNpcQuestIdFoundDB()
	RSNpcDB.InitCustomNpcDB()
	RSContainerDB.InitContainerNamesDB()
	RSContainerDB.InitContainerLootFoundDB()
	RSContainerDB.InitContainerQuestIdFoundDB()
	RSContainerDB.InitReseteableContainersDB()
	RSEventDB.InitEventNamesDB()
	RSEventDB.InitEventQuestIdFoundDB()

	-- Check if rare NPC names database is updated
	local currentDbVersion = RSGeneralDB.GetDbVersion()
	local version = nil
	local databaseUpdated = false
	if (currentDbVersion) then
		version = currentDbVersion.version
		databaseUpdated = currentDbVersion.version == RSConstants.CURRENT_DB_VERSION
	end
	if (not databaseUpdated) then
		UpdateRareNamesDB(version); -- Internally calls to RefreshDatabaseData once its done
	else
		RefreshDatabaseData(version)
	end
end

function RareScanner:GetOptionsTable()
	return LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db, RSConstants.PROFILE_DEFAULTS)
end
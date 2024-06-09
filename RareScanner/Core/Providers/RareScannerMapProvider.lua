-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSGuideDB = private.ImportLib("RareScannerGuideDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSNpcDB = private.ImportLib("RareScannerNpcDB")

-- RareScanner general libraries
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSConstants = private.ImportLib("RareScannerConstants")

-- RareScanner services libraries
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSMap = private.ImportLib("RareScannerMap")
local RSTooltip = private.ImportLib("RareScannerTooltip")
local RSGuidePOI = private.ImportLib("RareScannerGuidePOI")
local RSTomtom = private.ImportLib("RareScannerTomtom")
local RSRecentlySeenTracker = private.ImportLib("RareScannerRecentlySeenTracker")

RareScannerDataProviderMixin = CreateFromMixins(MapCanvasDataProviderMixin);

function RareScannerDataProviderMixin:OnAdded(mapCanvas)
	MapCanvasDataProviderMixin.OnAdded(self, mapCanvas);
	self:GetMap():RegisterCallback("SetBounty", self.SetBounty, self);
end

function RareScannerDataProviderMixin:OnRemoved(mapCanvas)
	self:GetMap():UnregisterCallback("SetBounty", self.SetBounty, self);
	MapCanvasDataProviderMixin.OnRemoved(self, mapCanvas);
end

local function pingAnimation(pin, animation, entityID, mapID, x, y)
	if (not animation or not entityID) then
		return
	end
	
	animation:Stop()
	animation:SetScript("OnLoop", function(self, loopState)
		if (self.loops) then
			self.loops = self.loops + 1
			
			if (self.loops == 3) then
				RSRecentlySeenTracker.DeletePendingAnimation(entityID, mapID, x, y)
				self:Stop()
				self:SetLooping("NONE")
			end
		end
	end)
		
	if (RSRecentlySeenTracker.ShouldPlayAnimation(entityID, mapID, x, y)) then
		animation.loops = 0
		animation:SetLooping("BOUNCE")
		animation:Play()
	end
end

function RareScannerDataProviderMixin:ShowAnimations()	
	-- Show recently seen animations
	if (RSConfigDB.IsShowingAnimationForNpcs() or RSConfigDB.IsShowingAnimationForContainers() or RSConfigDB.IsShowingAnimationForEvents()) then
		for pin in self:GetMap():EnumeratePinsByTemplate("RSEntityPinTemplate") do
			if ((RSConfigDB.IsShowingAnimationForNpcs() and pin.POI.isNpc) or (RSConfigDB.IsShowingAnimationForContainers() and pin.POI.isContainer) or (RSConfigDB.IsShowingAnimationForEvents() and pin.POI.isEvent)) then
				pingAnimation(pin, pin.ShowPingAnim, pin.POI.entityID, pin.POI.mapID, pin.POI.x, pin.POI.y)
			end
		end
		for pin in self:GetMap():EnumeratePinsByTemplate("RSGroupPinTemplate") do
			for _, childPOI in ipairs (pin.POI.POIs) do
				if ((RSConfigDB.IsShowingAnimationForNpcs() and childPOI.isNpc) or (RSConfigDB.IsShowingAnimationForContainers() and childPOI.isContainer) or (RSConfigDB.IsShowingAnimationForEvents() and childPOI.isEvent)) then
					pingAnimation(pin, pin.ShowPingAnim, childPOI.entityID, childPOI.mapID, childPOI.x, childPOI.y)
				end
			end
		end
	end
end

function RareScannerDataProviderMixin:SetBounty(bountyQuestID, bountyFactionID, bountyFrameType)
	local changed = self.bountyQuestID ~= bountyQuestID;
	if (changed) then
		self.bountyQuestID = bountyQuestID;
		self.bountyFactionID = bountyFactionID;
		self.bountyFrameType = bountyFrameType;
		if (self:GetMap()) then
			self:RefreshAllData();
		end
	end
end

function RareScannerDataProviderMixin:GetBountyInfo()
	return self.bountyQuestID, self.bountyFactionID, self.bountyFrameType;
end

function RareScannerDataProviderMixin:OnMapChanged()
	self:RefreshAllData();
end

function RareScannerDataProviderMixin:OnHide()
	self:RemoveAllData()
end

function RareScannerDataProviderMixin:OnShow()
	self:ShowAnimations()
end

function RareScannerDataProviderMixin:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate("RSEntityPinTemplate");
	self:GetMap():RemoveAllPinsByTemplate("RSOverlayTemplate");
	self:GetMap():RemoveAllPinsByTemplate("RSGuideTemplate");
	self:GetMap():RemoveAllPinsByTemplate("RSGroupPinTemplate");
end

function RareScannerDataProviderMixin:ShowGuideLayer(entityID, mapID)
	-- Gets the information of the entity
	local guide = nil
	local isNpc = false
	local isContainer = false
	local isEvent = false
	if (RSNpcDB.GetInternalNpcInfo(entityID)) then
		guide = RSGuideDB.GetNpcGuide(entityID, mapID)
		isNpc = true
	elseif (RSContainerDB.GetInternalContainerInfo(entityID)) then
		guide = RSGuideDB.GetContainerGuide(entityID, mapID)
		isContainer = true
	else 
		guide = RSGuideDB.GetEventGuide(entityID, mapID)
		isEvent = true
	end

	if (guide) then
		for pinType, info in pairs (guide) do
			local POI = RSGuidePOI.GetGuidePOI(entityID, pinType, info)
			if (not info.questID or not C_QuestLog.IsQuestFlaggedCompleted(info.questID)) then
				local guidePin = self:GetMap():AcquirePin("RSGuideTemplate", POI);
				if ((isNpc and not RSNpcDB.IsInternalNpcInMap(entityID, mapID)) or (isContainer and not RSContainerDB.IsInternalContainerInMap(entityID, mapID)) or (isEvent and not RSEventDB.IsInternalEventInMap(entityID, mapID))) then
					guidePin.ShowPingAnim:SetLooping("REPEAT")
					guidePin.ShowPingAnim:Play()
				else
					guidePin.ShowPingAnim:SetLooping("NONE")
					guidePin.ShowPingAnim:Play()
				end
			end
		end
	end
end

function RareScannerDataProviderMixin:RefreshAllData(fromOnShow)
	self:RemoveAllData()

	local mapID = self:GetMap():GetMapID();
	RSLogger:PrintDebugMessage(string.format("MAPID [%s], ARTID [%s]", mapID, C_Map.GetMapArtID(mapID)))

	-- Loads new pins
	local POIs = RSMap.GetMapPOIs(mapID, true, false)
	if (not POIs) then
		return
	end

	-- Adds all the POIs to the WorldMap
	local currentGuideActive = nil
	for _, POI in ipairs (POIs) do
		local filtered = false

		-- If the entity is only available when shown in the world map, there is no need to fill the map with useless icons
		if (POI.worldmap) then
			filtered = true
		elseif (POI.isGroup) then
			for _, subPOI in ipairs(POI.POIs) do
				if (subPOI.isContainer and subPOI.worldmap) then
					filtered = true
					break
				end
			end
		end

		if (not filtered) then
			local pin
			if (POI.isGroup) then
				pin = self:GetMap():AcquirePin("RSGroupPinTemplate", POI, self);

				-- Adds children overlay/guide
				for _, childPOI in ipairs (POI.POIs) do
					-- Adds overlay if active
					-- Avoids adding multiple spots if the entity spawns in multiple places at the same time
					if (RSGeneralDB.HasOverlayActive(childPOI.entityID) and (not currentGuideActive or currentGuideActive ~= childPOI.entityID)) then
						pin:ShowOverlay(childPOI)
						currentGuideActive = childPOI.entityID
					end
				end
			else
				RSLogger:PrintDebugMessageEntityID(POI.entityID, string.format("Mostrando Entidad [%s].", POI.entityID))
				pin = self:GetMap():AcquirePin("RSEntityPinTemplate", POI, self);

				-- Adds overlay if active
				-- Avoids adding multiple spots if the entity spawns in multiple places at the same time
				if (RSGeneralDB.HasOverlayActive(POI.entityID) and (not currentGuideActive or currentGuideActive ~= POI.entityID)) then
					RSLogger:PrintDebugMessageEntityID(POI.entityID, string.format("Mostrando Overlay [%s].", POI.entityID))
					pin:ShowOverlay()
					currentGuideActive = POI.entityID
				end
			end
		end
	end
	
	-- Adds guidance icons to the WorldMap
	if (RSGeneralDB.GetGuideActive()) then
		self:ShowGuideLayer(RSGeneralDB.GetGuideActive(), mapID)
	end
	
	-- Show animations
	if (self:GetMap():IsShown()) then
		self:ShowAnimations()
	end
end

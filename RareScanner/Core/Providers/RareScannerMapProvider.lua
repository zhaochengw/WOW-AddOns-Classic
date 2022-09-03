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

RareScannerDataProviderMixin = CreateFromMixins(MapCanvasDataProviderMixin);

function RareScannerDataProviderMixin:OnMapChanged()
	self:RefreshAllData();
end

function RareScannerDataProviderMixin:OnHide()
	self:RemoveAllData()
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
				if ((isNpc and not RSNpcDB.IsInternalNpcInMap(entityID, mapID)) or (isContainer and not RSContainerDB.IsInternalContainerInMap(entityID, mapID))) then
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
				pin = self:GetMap():AcquirePin("RSGroupPinTemplate", POI);

				-- Animates the ping in case the filter is on
				if (RSGeneralDB.GetWorldMapTextFilter()) then
					pin.ShowPingAnim:Play();
				end

				-- Adds children overlay/guide
				for _, childPOI in ipairs (POI.POIs) do
					-- Adds overlay if active
					if (RSGeneralDB.HasOverlayActive(childPOI.entityID)) then
						pin:ShowOverlay(childPOI)
					end
				end
			else
				RSLogger:PrintDebugMessageEntityID(POI.entityID, string.format("Mostrando Entidad [%s].", POI.entityID))
				pin = self:GetMap():AcquirePin("RSEntityPinTemplate", POI);

				-- Animates the ping in case the filter is on
				if (RSGeneralDB.GetWorldMapTextFilter()) then
					pin.ShowPingAnim:Play();
				end

				-- Adds overlay if active
				if (RSGeneralDB.HasOverlayActive(POI.entityID)) then
					RSLogger:PrintDebugMessageEntityID(POI.entityID, string.format("Mostrando Overlay [%s].", POI.entityID))
					pin:ShowOverlay()
				end
			end
		end
	end
	
	-- Adds guidance icons to the WorldMap
	if (RSGeneralDB.GetGuideActive()) then
		self:ShowGuideLayer(RSGeneralDB.GetGuideActive(), mapID)
	end
end

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

local function ShowInGameVignetteGuide(pin, POI)
	-- Guide
	local guide = nil
	if (POI.isNpc) then
		guide = RSGuideDB.GetNpcGuide(POI.entityID)
	elseif (POI.isContainer) then
		guide = RSGuideDB.GetContainerGuide(POI.entityID)
	else
		guide = RSGuideDB.GetEventGuide(POI.entityID)
	end

	if (guide) then
		for pinType, info in pairs (guide) do
			local POI = RSGuidePOI.GetGuidePOI(POI.entityID, pinType, info)
			if (not info.questID or not C_QuestLog.IsQuestFlaggedCompleted(info.questID)) then
				local guidePin = pin:GetMap():AcquirePin("RSGuideTemplate", POI);
				guidePin.ShowPingAnim:Play()
			end
		end
		RSGeneralDB.SetGuideActive(POI.entityID)
	else
		pin:GetMap():RemoveAllPinsByTemplate("RSGuideTemplate");
		RSGeneralDB.RemoveGuideActive()
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
		-- Skip if an ingame vignette is already showing this entity (on AreaPOIPinTemplate)
		-- Only vignettes on WorldMap are actually shown in this layer
		-- If its a group it doesn't matter, because there are several entities inside
		local filtered = false
		if (POI.isNpc) then
			for pin in self:GetMap():EnumeratePinsByTemplate("AreaPOIPinTemplate") do
				if (pin.name == POI.name) then
					RSLogger:PrintDebugMessageEntityID(POI.entityID, string.format("Saltado NPC [%s]: Hay un vignette del juego mostrándolo (AreaPOI).", POI.entityID))
					filtered = true
				end
			end
		end

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

					-- Adds guide if active
					if (RSGeneralDB.HasGuideActive(childPOI.entityID)) then
						pin:ShowGuide(childPOI)
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

				-- Adds guide if active
				if (RSGeneralDB.HasGuideActive(POI.entityID)) then
					pin:ShowGuide()
				end
			end
		end
	end
end

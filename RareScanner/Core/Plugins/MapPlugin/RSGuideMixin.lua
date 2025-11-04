-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

-- RareScanner libraries
local RSConstants = private.ImportLib("RareScannerConstants")

-- RareScanner database libraries
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner service libraries
local RSUtils = private.ImportLib("RareScannerUtils")
local RSMinimap = private.ImportLib("RareScannerMinimap")

RSGuideMixin = CreateFromMixins(MapCanvasPinMixin);

RSGuideMixin.SetPassThroughButtons = function() end

function RSGuideMixin:OnLoad()
	self:SetScalingLimits(1, 0.75, 1.0);
end

function RSGuideMixin:OnAcquired(POI, pin)
	self:UseFrameLevelType("PIN_FRAME_LEVEL_DIG_SITE", self:GetMap():GetNumActivePinsByTemplate("RSGuideTemplate"));

	-- Set attributes
	self.POI = POI
	self.pin = pin
	self.Texture:SetTexture(POI.texture)
	self.Texture:SetScale(RSConfigDB.GetIconsWorldMapScale())
	self:SetPosition(POI.x, POI.y);
end

function RSGuideMixin:OnMouseEnter()
	if (self.ShowPingAnim:IsPlaying()) then
		self.ShowPingAnim:Stop()
	end
	if (self.pin and self.pin.ShowPingAnim and not self.pin.ShowPingAnim:IsPlaying()) then
		self.pin.ShowPingAnim:Play();
	end
	
	if (self.POI.tooltip) then
		GameTooltip:SetOwner(self, "ANCHOR_CURSOR")

		if (self.POI.tooltip.title) then
			GameTooltip_SetTitle(GameTooltip, self.POI.tooltip.title);
		end

		if (self.POI.tooltip.comment) then
			GameTooltip_AddNormalLine(GameTooltip, self.POI.tooltip.comment);
		end

		GameTooltip:Show()
	end
end

function RSGuideMixin:OnMouseLeave()
	if (self.POI.tooltip) then
		GameTooltip:Hide()
	end
	if (self.pin and self.pin.ShowPingAnim and self.pin.ShowPingAnim:IsPlaying()) then
		self.pin.ShowPingAnim:Stop();
	end
end

function RSGuideMixin:OnMouseDown(button)
	if (button == "RightButton") then
		self:GetMap():RemoveAllPinsByTemplate("RSGuideTemplate");
		RSGeneralDB.RemoveGuideActive()

		-- Refresh minimap
		RSMinimap.RefreshAllData(true)
	end
end

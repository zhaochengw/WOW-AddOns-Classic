-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- RareScanner libraries
local RSTooltip = private.ImportLib("RareScannerTooltip")

RSMinimapPinMixin = {}

function RSMinimapPinMixin:OnEnter()
	RSTooltip.Tooltip:SetOwner(self, "ANCHOR_CURSOR")
	if (self.POI.name) then
		RSTooltip.Tooltip:SetText(self.POI.name)
	elseif (self.POI.tooltip) then
		if (self.POI.tooltip.title) then
			GameTooltip_SetTitle(RSTooltip.Tooltip, self.POI.tooltip.title);
		end

		if (self.POI.tooltip.comment) then
			GameTooltip_AddNormalLine(RSTooltip.Tooltip, self.POI.tooltip.comment);
		end
	end
	RSTooltip.Tooltip:Show()
end

function RSMinimapPinMixin:OnLeave()
	RSTooltip.Tooltip:Hide()
end
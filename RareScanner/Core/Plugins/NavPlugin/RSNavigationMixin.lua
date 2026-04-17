-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner other addons integration services
local RSWaypoints = private.ImportLib("RareScannerWaypoints")
local RSButtonHandler = private.ImportLib("RareScannerButtonHandler")
local RSTooltip = private.ImportLib("RareScannerTooltip")

-- Navigation cache
local navigationCache = {}
local currentIndex = 1

RSNavigationMixin = { };

function RSNavigationMixin:OnLoad()
-- Nothing to do
end

function RSNavigationMixin:OnNextEnter()
	self.ShowAnim:Play();
	RSTooltip.Tooltip:SetOwner(self, "ANCHOR_CURSOR")
	RSTooltip.Tooltip:SetText(AL["NAVIGATION_SHOW_NEXT"])
	RSTooltip.Tooltip:Show()
end

function RSNavigationMixin:OnNextLeave()
	self.ShowAnim:Stop();
	RSTooltip.Tooltip:Hide()
end

function RSNavigationMixin:OnPreviousEnter()
	self.ShowAnim:Play();
	RSTooltip.Tooltip:SetOwner(self, "ANCHOR_CURSOR")
	RSTooltip.Tooltip:SetText(AL["NAVIGATION_SHOW_PREVIOUS"])
	RSTooltip.Tooltip:Show()
end

function RSNavigationMixin:OnPreviousLeave()
	self.ShowAnim:Stop();
	RSTooltip.Tooltip:Hide()
end

function RSNavigationMixin:EnableNextButton()
	if (table.getn(navigationCache) > currentIndex) then
		return true
	end

	return false
end

function RSNavigationMixin:EnablePreviousButton()
	if (currentIndex > 1) then
		return true
	end

	return false
end

function RSNavigationMixin:AddNext(mapID, x, y, name, atlasName, objectGUID)
	-- Skip if already in the pool in the last position
	local lastVignetteInfo = navigationCache[#navigationCache]
	
	local vignetteInfo = {}
	vignetteInfo.mapID = mapID
	vignetteInfo.x = x
	vignetteInfo.y = y
	vignetteInfo.name = name
	vignetteInfo.atlasName = atlasName
	vignetteInfo.objectGUID = objectGUID
	
	if (not lastVignetteInfo or lastVignetteInfo.objectGUID ~= objectGUID) then
		table.insert(navigationCache, vignetteInfo)
	end
	
	self.ShowAnim:Play();

	-- If its not locking then we have to keep moving the index to the last position
	if (not private.db.display.navigationLockEntity) then
		currentIndex = table.getn(navigationCache)

		-- Refresh waypoint
		RSWaypoints.AddAutomaticWaypoint(mapID, x, y, name)
	-- If the navigation cache only contains one item, adds waypoint
	elseif (table.getn(navigationCache) == 1) then
		RSWaypoints.AddAutomaticWaypoint(mapID, x, y, name)
	end
end

function RSNavigationMixin:OnNextMouseDown(button)
	if (not InCombatLockdown()) then
		currentIndex = currentIndex + 1
		self:Navigate(self)
	end
end

function RSNavigationMixin:OnPreviousMouseDown(button)
	if (not InCombatLockdown()) then
		currentIndex = currentIndex - 1
		self:Navigate(self)
	end
end

function RSNavigationMixin:Navigate()
	local vignetteInfo = navigationCache[currentIndex];
	if (not vignetteInfo) then
		return
	end

	-- Refresh button
	RSButtonHandler.AddAlert(self:GetParent(), vignetteInfo, true)

	-- Adds waypoint
	RSWaypoints.AddAutomaticWaypoint(vignetteInfo.mapID, vignetteInfo.x, vignetteInfo.y, vignetteInfo.name)
end

function RSNavigationMixin:Reset()
	navigationCache = {}
	currentIndex = 1
	self:Hide()
end

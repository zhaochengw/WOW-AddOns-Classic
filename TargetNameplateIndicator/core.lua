------------------------------------------------------
-- Configuration variables have moved to config.lua --
--        Do not change anything in this file       --
------------------------------------------------------

local addon, TNI = ...

local LNR = LibStub("LibNameplateRegistry-1.0")

LibStub("AceAddon-3.0"):NewAddon(TNI, addon, "AceConsole-3.0")


--[==[@debug@
local DEBUG = false

local function debugprint(...)
	if DEBUG then
		print("TNI DEBUG:", ...)
	end
end
--@end-debug@]==]


-----
-- Error callbacks
-----
local print, format = print, string.format

local function errorPrint(fatal, formatString, ...)
	local message = "|cffFF0000LibNameplateRegistry has encountered a" .. (fatal and " fatal" or "n") .. " error:|r"
	print("TargetNameplateIndicator:", message, format(formatString, ...))
end

function TNI:OnError_FatalIncompatibility(callback, incompatibilityType)
	local detailedMessage
	if incompatibilityType == "TRACKING: OnHide" or incompatibilityType == "TRACKING: OnShow" then
		detailedMessage = "LibNameplateRegistry missed several nameplate show and hide events."
	elseif incompatibilityType == "TRACKING: OnShow missed" then
		detailedMessage = "A nameplate was hidden but never shown."
	else
		detailedMessage = "Something has gone terribly wrong!"
	end

	errorPrint(true, "(Error Code: %s) %s", incompatibilityType, detailedMessage)
end


------
-- Initialisation
------

local defaults

do
	local function CreateUnitReactionTypeDefaults()
		return {
			enable = true,
			texture = "Interface\\AddOns\\TargetNameplateIndicator\\Textures\\Reticule",
			height = 50,
			width = 50,
			opacity = 1,
			texturePoint = "BOTTOM",
			anchorPoint = "TOP",
			xOffset = 0,
			yOffset = 5,
		}
	end

	local function CreateUnitDefaults()
		return {
			enable = true,
			self = CreateUnitReactionTypeDefaults(),
			friendly = CreateUnitReactionTypeDefaults(),
			hostile = CreateUnitReactionTypeDefaults(),
		}
	end

	defaults = {
		profile = {
			target = CreateUnitDefaults(),
			mouseover = CreateUnitDefaults(),
			focus = CreateUnitDefaults(),
			targettarget = CreateUnitDefaults(),
		}
	}
end

function TNI:OnInitialize()
	LNR:Embed(self)
	self.db = LibStub("AceDB-3.0"):New("TargetNameplateIndicatorDB", defaults, true)
	self:RegisterOptions() -- Defined in options.lua

	self:LNR_RegisterCallback("LNR_ERROR_FATAL_INCOMPATIBILITY", "OnError_FatalIncompatibility")

	--[==[@debug@
	if DEBUG then
		TNI:LNR_RegisterCallback("LNR_DEBUG", debugprint)
	end
	--@end-debug@]==]
end

function TNI:OnEnable()
	for unit, indicator in pairs(self.Indicators) do
		indicator:Show()
	end
end

function TNI:OnDisable()
	for unit, indicator in pairs(self.Indicators) do
		indicator:Hide()
	end
end

function TNI:RefreshIndicator(unit)
	local indicator = self.Indicators[unit]

	if not indicator then
		error("Invalid unit \"" + unit + "\"")
	end

	indicator:Refresh()
end


------
-- Indicator functions
------

--- @type table<string, Indicator>
TNI.Indicators = {}

--- @class Indicator : Frame
--- @field Texture Texture
--- @field enabled boolean
--- @field unit string
--- @field priority number
--- @field LNR_RegisterCallback fun(string, string)
--- @field GetPlateByGUID fun(string):Frame,table
local Indicator = {}

function Indicator:Update(nameplate)
	self.currentNameplate = nameplate
	self.Texture:ClearAllPoints()

	local unitConfig = TNI.db.profile[self.unit]
	local config = UnitIsUnit("player", self.unit) and unitConfig.self or UnitIsFriend("player", self.unit) and unitConfig.friendly or unitConfig.hostile

	self:SetShown(unitConfig.enable)
	self.enabled = unitConfig.enable;

	if nameplate and config.enable then
		local texture = config.texture
		if texture == "custom" then
			texture = config.textureCustom
		end

		self.Texture:Show()
		self.Texture:SetTexture(texture)
		self.Texture:SetSize(config.width, config.height)
		self.Texture:SetAlpha(config.opacity)
		self.Texture:SetPoint(config.texturePoint, nameplate, config.anchorPoint, config.xOffset, config.yOffset)
	else
		self.Texture:Hide()
	end
end

function Indicator:Refresh()
	self:Update(self.currentNameplate)
end

function Indicator:OnRecyclePlate(callback, nameplate, plateData)
	--[==[@debug@
	debugprint("Callback fired (recycle)", self.unit, nameplate == self.currentNameplate)
	--@end-debug@]==]

	if nameplate == self.currentNameplate then
		self:Update()
	end
end

-- Checks if other indicators are already displaying on this indicator's unit, hides lower priority indicators and returns true when this indicator should be shown.
--
-- - If no other indicator is displaying, this returns true.
-- - If a lower priority indicator is displaying, it is hidden and this returns true.
-- - If an equal or higher priority indicator is displaying, this returns false.
function Indicator:CheckAndHideLowerPriorityIndicators()
	for unit, indicator in pairs(TNI.Indicators) do
		if indicator.enabled and self.unit ~= indicator.unit and UnitIsUnit(self.unit, unit) then -- If the indicator is for a different unit token but it's the same unit,
			if self.priority > indicator.priority then -- If this indicator is a higher priority, hide the other indicator and return true
				indicator:Update()
				return true
			else -- If this indicator is a lower or equal priority, return false
				return false
			end
		end
	end

	-- No other indicator is displaying, return true
	return true
end

-- Verfies that the current nameplate (if there is one) has a unit token and disables the indicator and throws an error if it doesn't.
-- Returns true if there's no issue.
function Indicator:VerifyNameplateUnitToken()
	if self.currentNameplate and not self.currentNameplate.namePlateUnitToken then
		TNI.db.profile[self.unit].enable = false
		self:Hide()

		error((
			"TargetNameplateIndicator: %s indicator found a nameplate without a unit token and as such is unable to function." ..
			" This is usually caused by AddOns that replace the default nameplates (e.g. EKPlates)." ..
			" This indicator will now be disabled until it's re-enabled in the options menu."
		):format(self.unit))
	end

	return true
end

local function CreateIndicator(unit, priority)
	--- @type Indicator
	local indicator = CreateFrame("Frame", "TargetNameplateIndicator_" .. unit)
	indicator:SetFrameStrata("BACKGROUND")
	indicator.Texture = indicator:CreateTexture("$parentTexture", "OVERLAY")

	indicator.unit = unit
	indicator.priority = priority

	LNR:Embed(indicator)
	Mixin(indicator, Indicator)

	indicator:LNR_RegisterCallback("LNR_ON_RECYCLE_PLATE", "OnRecyclePlate")

	indicator:SetScript("OnEvent", function(self, event, ...)
		self[event](self, ...)
	end)

	TNI.Indicators[unit] = indicator

	return indicator
end


------
-- Non-target Indicator functions
------

--- @class NonTargetIndicator:Indicator
local NonTargetIndicator = {}

function NonTargetIndicator:OnUpdate()
	-- If there's a current nameplate and it's still this indicator's unit, do nothing
	if self.currentNameplate and self:VerifyNameplateUnitToken() and UnitIsUnit(self.unit, self.currentNameplate.namePlateUnitToken) then
		return
	end

	-- If there isn't a current nameplate and this indicator's unit doesn't exist, do nothing
	if not self.currentNameplate and not UnitExists(self.unit) then
		return
	end

	local nameplate, plateData = self:GetPlateByGUID(UnitGUID(self.unit))

	local shouldDisplay = self:CheckAndHideLowerPriorityIndicators()

	--[==[@debug@
	debugprint(self.unit, "changed", nameplate, "shouldDisplay?", shouldDisplay)
	--@end-debug@]==]

	-- If the nameplate for this indicator's unit doesn't already have a higher priority indicator displaying on it, update the indicator; otherwise hide it.
	if shouldDisplay then
		self:Update(nameplate)
	else
		self:Update(nil)
	end
end

local function CreateNonTargetIndicator(unit, priority)
	--- @type NonTargetIndicator
	local indicator = CreateIndicator(unit, priority)

	Mixin(indicator, NonTargetIndicator)

	indicator:SetScript("OnUpdate", indicator.OnUpdate)

	return indicator
end


------
-- Target Indicator
------

local TargetIndicator = CreateIndicator("target", 100)

function TargetIndicator:PLAYER_TARGET_CHANGED()
	local nameplate, plateData = self:GetPlateByGUID(UnitGUID("target"))

	--[==[@debug@
	debugprint("Player target changed", nameplate)
	--@end-debug@]==]

	if not nameplate then
		self:Update()
	end
end

function TargetIndicator:OnTargetPlateOnScreen(callback, nameplate, plateData)
	--[==[@debug@
	debugprint("Callback fired (target found)")
	--@end-debug@]==]

	local shouldDisplay = self:CheckAndHideLowerPriorityIndicators()

	if shouldDisplay then
		self:Update(nameplate)
	else
		self:Update()
	end
end

TargetIndicator:RegisterEvent("PLAYER_TARGET_CHANGED")
TargetIndicator:LNR_RegisterCallback("LNR_ON_TARGET_PLATE_ON_SCREEN", "OnTargetPlateOnScreen")


------
-- Mouseover Indicator
------

---@diagnostic disable-next-line: unused-local
local MouseoverIndicator = CreateNonTargetIndicator("mouseover", 10)


------
-- Focus Indicator
------

---@diagnostic disable-next-line: unused-local
local FocusIndicator = CreateNonTargetIndicator("focus", 90)

------
-- Target of Target Indicator
------

---@diagnostic disable-next-line: unused-local
local TargetOfTargetIndicator = CreateNonTargetIndicator("targettarget", 50)

--[[
$Id: MoneyFrame.lua 364 2021-05-19 13:18:52Z arithmandar $
]]-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local GameTooltip = _G.GameTooltip
local unpack = _G.unpack
local GetBuildInfo = _G.GetBuildInfo

-- Determine WoW TOC Version
local WoWClassic, WoWRetail
local wowtocversion  = select(4, GetBuildInfo())
if wowtocversion < 30000 then
	WoWClassic = true
else
	WoWRetail = true
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local MoneyFrame = addon:NewModule("MoneyFrame", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

local profile
local isInLockdown = false
local AC_MNYSTR = nil

local function frame_OnUpdate(self)
	local frametxt = "|cFFFFFFFF"..addon:GetFormattedValue(GetMoney())
	if (frametxt ~= AC_MNYSTR) then
		self.Text:SetText(frametxt)
		AC_MNYSTR = frametxt
		local width = self.Text:GetStringWidth()
		self:SetWidth(width)
	end
end

local function frame_OnMouseDown(self, button)    
	-- Prevent activation when in combat
	if (isInLockdown) then
		return
	end
	-- Handle left button clicks
	if (button == "LeftButton") then
		self:StartMoving()
		GameTooltip:Hide()
	elseif (button == "RightButton") then
		AccountantClassic_ButtonOnClick()
		GameTooltip:Hide()
	end
end

local function frame_OnMouseUp(self, button)
	self:StopMovingOrSizing()
	local a, b, c, d, e = self:GetPoint()
	addon.db.profile.MnyFramePoint = { a, b, c, d, e }
end

local function frame_OnEnter(self)
	if (isInLockdown) then
		return
	end

	local tooltip
	if (WoWClassic) then
		tooltip = GameTooltip
	else -- Shadowlands
		tooltip = GetAppropriateTooltip()
	end

	if (not tooltip:IsShown()) then
		local amoney_str = addon:ShowSessionToolTip()

		tooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", -10, 0)
		GameTooltip_SetTitle(tooltip, "|cFFFFFFFF"..L["Accountant Classic"].." - "..L["This Session"])
		GameTooltip_AddNormalLine(tooltip, amoney_str, true)
		local tokenstr = addon:BackpackTokenFrame_Update()
		if (tokenstr) then
			GameTooltip_AddNormalLine(tooltip, tokenstr, true)
		end
		if (profile.showintrotip == true) then
			GameTooltip_AddColoredLine(tooltip, "("..L["Left-click and drag to move this button.\nRight-Click to open Accountant Classic."]..")", GRAY_FONT_COLOR, true)
		end
		tooltip:Show()
	else
		tooltip:Hide()
	end
end

local function frame_OnLeave(self)
	GameTooltip_Hide()
end

local function createMoneyFrame()
	local f
	if not f then f = CreateFrame("Frame", "AccountantClassicMoneyInfoFrame", UIParent) end
	
	f:SetWidth(160)
	f:SetHeight(21)
	local point, relativeTo, relativePoint, ofsx, ofsy = unpack(addon.db.profile.MnyFramePoint)
	f:SetPoint(point or "TOPLEFT", UIParent, relativePoint or "TOPLEFT", ofsx or 10, ofsy or -80)
	f:SetClampedToScreen(true)
	f:SetMovable(true)
	f:EnableMouse(true)
	f:RegisterForDrag("LeftButton")
	f.Text = f:CreateFontString("AccountantClassicMoneyInfoText", "OVERLAY", "GameFontNormal")
	f.Text:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
	f.Text:SetText(L["Accountant Classic"])
	f:SetScript("OnUpdate", 	frame_OnUpdate)
	f:SetScript("OnMouseDown", 	frame_OnMouseDown)
	f:SetScript("OnMouseUp", 	frame_OnMouseUp)
	f:SetScript("OnEnter", 		frame_OnEnter)
	f:SetScript("OnLeave", 		frame_OnLeave)
	f:Show()
	return f
end

function MoneyFrame:OnInitialize()
	profile = addon.db.profile
	
	MoneyFrame.frame = createMoneyFrame()
end

function MoneyFrame:OnEnable()
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	if (profile.showmoneyinfo == true) then
		self.frame:Show()
		self:ArrangeMoneyInfoFrame()
	else
		self.frame:Hide()
	end
end

function MoneyFrame:OnDisable()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	self.frame:Hide()
end

function MoneyFrame:ArrangeMoneyInfoFrame()
	self.frame:SetScale(profile.infoscale or 1)
	self.frame:SetAlpha(profile.infoalpha or 1)
	local point, relativeTo, relativePoint, ofsx, ofsy = unpack(profile.MnyFramePoint)
	self.frame:ClearAllPoints()
	self.frame:SetParent(UIParent)
	self.frame:SetPoint(point or "TOPLEFT", nil, relativePoint or "TOPLEFT", ofsx or 10, ofsy or -80)
end

function MoneyFrame:PLAYER_REGEN_DISABLED()
	isInLockdown = true
end

function MoneyFrame:PLAYER_REGEN_ENABLED()
	isInLockdown = false
end

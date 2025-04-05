local NAME = ...

local function routine(ui, event, unit, kind)
	if event == "UNIT_POWER_UPDATE" then
		if kind ~= "MANA" then
			return
		end
		local mana = UnitPower(unit, 0) -- 0 is Enum.PowerType.Mana
		ui:SetValue(mana / UnitPowerMax(unit, 0))
		ui.text:SetText(mana)
	elseif event == "UNIT_DISPLAYPOWER" then
		local t = UnitPowerType(unit)
		if t ~= 0 then
			ui:Show()
		else
			ui:Hide()
		end
	end
end

local function init(frame, ...)
	frame:UnregisterEvent("PLAYER_LOGIN")
	frame:SetScript("OnEvent", nil)

	local ui = CreateFrame("StatusBar", nil, PlayerFrame)
	ui:SetSize(PlayerFrameManaBar:GetSize())
	ui:SetPoint("TOPLEFT", PlayerFrameManaBar, "BOTTOMLEFT")
	ui:SetStatusBarTexture("Interface/TargetingFrame/UI-StatusBar")
	ui:SetStatusBarColor(0, 0, 1)
	ui:SetMinMaxValues(0, 1.0)
	PlayerFrame[NAME] = ui

	-- backdrop
	local bg = ui:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetColorTexture(0, 0, 0, .5)
	-- border
	local border = ui:CreateTexture(nil, "OVERLAY")
	border:SetTexture("Interface/TargetingFrame/UI-TargetingFrame")
	border:SetTexCoord(0.587890625, 0.1044921875, 0.41015625, 0.51171875)
	border:SetPoint("TOPLEFT", -1, 0)
	border:SetPoint("BOTTOMRIGHT", 4.16, 0)
	-- text
	local text = ui:CreateFontString(nil, "OVERLAY", "TextStatusBarText")
	text:SetPoint("TOPLEFT")
	text:SetPoint("BOTTOMRIGHT", -1, 0)
	text:SetJustifyH("RIGHT")

	-- Lable Justify, (Main Menu -> Interface -> Display -> Status Text Display)
	local style = GetCVar("statusTextDisplay")
	if style ~= "BOTH" then
		if style == "NONE" then
			text:Hide()
		else
			text:SetJustifyH("CENTER")
		end
	end
	ui.text = text

	-- Events
	local unit = "player"
	ui:RegisterUnitEvent("UNIT_POWER_UPDATE", unit)
	ui:RegisterUnitEvent("UNIT_DISPLAYPOWER", unit)
	ui:SetScript("OnEvent", routine)
	-- Initialize
	routine(ui, "UNIT_DISPLAYPOWER", unit)
	routine(ui, "UNIT_POWER_UPDATE", unit, "MANA")

	-- Hide built-in druid manabar
	local alt = PlayerFrameAlternateManaBar
	if alt then
		alt:SetScript("OnEvent", nil)
		alt:UnregisterAllEvents()
		alt:Hide()
		alt:SetParent(nil)
	end
end

local function main()
	local _, uc = UnitClass("player")
	if uc ~= "DRUID" then
		return
	end
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("PLAYER_LOGIN")
	frame:SetScript("OnEvent", init)
end

local _ = main()

local _, Addon = ...

local L = Addon.L
local MinimapIcon = Addon.MinimapIcon
local Output = Addon.Output

local IsButtonDown = false

if LibStub and LibStub:GetLibrary("LibDataBroker-1.1", true) and LibStub:GetLibrary("LibDBIcon-1.0", true) then
	Addon.LDB = LibStub("LibDataBroker-1.1")
	Addon.LDBIcon = LibStub("LibDBIcon-1.0")
else
	Addon.LDB = nil
	Addon.LDBIcon = nil
end

local LDB = Addon.LDB
local LDBIcon = Addon.LDBIcon

if LDB and LDBIcon then
	-- LDB Minimap button 
	function MinimapIcon:InitBroker()
		local texture = "Interface\\MINIMAP\\TRACKING\\Mailbox"
		MinimapIcon.Broker = LDB:NewDataObject("MailLogger", {
			type = "launcher",
			text = "MailLogger",
			icon = texture,
			OnClick = MinimapIcon.MinimapOnClick,
			OnTooltipShow = MinimapIcon.MinimapOnEnter,
		})
		MinimapIcon.minimap = MinimapIcon.minimap or {hide = false}
		LDBIcon:Register("MailLogger", MinimapIcon.Broker, MinimapIcon.minimap)
		MinimapIcon:ShowMinimap()
	end

	function MinimapIcon:ShowMinimap()
		if Addon.Config.ShowMinimapIcon then
			LDBIcon:Show("MailLogger")
		else
			LDBIcon:Hide("MailLogger")
		end
	end

	function MinimapIcon:MinimapOnClick(button)
		if IsShiftKeyDown() then
			if button == "LeftButton" then
				Output.background:ClearAllPoints()
				Output.background:SetPoint("RIGHT", nil, "RIGHT", -20, 0)
			end
		else
			if button == "LeftButton" then
				if Output.background:IsShown() and Output.export:GetParent():IsShown() then
					Output.export:GetParent():Hide()
					Output.background:Hide()
					Addon.Calendar.background:Hide()
				else
					Output.dropdowntitle:Show()
					Output.dropdownlist:Show()
					Output.dropdownbutton:Show()
					Addon:PrintTradeLog("ALL", nil)
					if Addon.Config.EnableCalendar then
						Addon:GetAvailableDate()
						Addon.Calendar.background:Show()
						Addon:RefreshCalendar()
					end
				end
			elseif button == "RightButton" then
				InterfaceOptionsFrame_OpenToCategory("MailLogger")
				InterfaceOptionsFrame_OpenToCategory("MailLogger")
			end
		end
	end
	function MinimapIcon:MinimapOnEnter()
		GameTooltip:AddLine("MailLogger:")
		GameTooltip:AddLine(L["|cFF00FF00Left Click|r to Open Log Frame"])
		GameTooltip:AddLine(L["|cFF00FF00Right Click|r to Open Config Frame"])
		GameTooltip:AddLine(L["|cFF00FF00Shift+Left|r to Restore Log Frame Position"])
		GameTooltip:AddLine(L["|cFF00FF00Shift+Right|r to Restore Minimap Icon Position"])
		GameTooltip:Show()
	end	
	-- LDB END ]]--
end

-- 環形移動小地圖按鈕
function Addon:UpdatePosition(pos)
	local angle = math.rad(pos or 345)
	local x, y = math.cos(angle), math.sin(angle)
	local MinimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
	local w = (Minimap:GetWidth() / 2) + 5
	local h = (Minimap:GetHeight() / 2) + 5
	if MinimapShape == "ROUND" then
		x, y = x * w, y * h
	else
		local diagRadiusW = math.sqrt(2 * (w) ^ 2) - 10
		local diagRadiusH = math.sqrt(2 * (h) ^ 2) - 10
		x = math.max(-w, math.min(x * diagRadiusW, w))
		y = math.max(-h, math.min(y * diagRadiusH, h))
	end
	MinimapIcon.Minimap:ClearAllPoints()
	MinimapIcon.Minimap:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

local function UpdateMapBtn()
	local mx, my = Minimap:GetCenter()
	local px, py = GetCursorPosition()
	local scale = Minimap:GetEffectiveScale()
	px, py = px / scale, py / scale
	local pos = math.deg(math.atan2(py - my, px - mx)) % 360
	Addon.Config.MinimapIconAngle = pos
	Addon:UpdatePosition(pos)
end

-- 小地圖按鈕初始化
function MinimapIcon:Initialize()
	local b = CreateFrame("Button", "MailLoggerMinimapIcon", Minimap)

	b:SetFrameStrata("HIGH")
	b:SetToplevel(true)
	if b.SetFixedFrameStrata then -- Classic support
		b:SetFixedFrameStrata(true)
	end
	b:SetFrameLevel(8)
	if b.SetFixedFrameLevel then -- Classic support
		b:SetFixedFrameLevel(true)
	end
	b:SetSize(31, 31)
	b:SetHighlightTexture(136477) --"Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight"
	b.overlay = b:CreateTexture(nil, "OVERLAY")
	b.overlay:SetSize(53, 53)
	b.overlay:SetTexture(136430) --"Interface\\Minimap\\MiniMap-TrackingBorder"
	b.overlay:SetPoint("TOPLEFT")
	b.background = b:CreateTexture(nil, "BACKGROUND")
	b.background:SetSize(20, 20)
	b.background:SetTexture(136467) --"Interface\\Minimap\\UI-Minimap-Background"
	b.background:SetPoint("TOPLEFT", 7, -5)
	b.icon = b:CreateTexture(nil, "ARTWORK")
	b.icon:SetSize(17, 17)
	b.icon:SetTexture("Interface\\MINIMAP\\TRACKING\\Mailbox")
	b.icon:SetPoint("TOPLEFT", 7, -6)


	b:EnableMouse(true)
	b:SetMovable(true)

	b:RegisterForDrag("LeftButton")
	b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	b:SetScript("OnDragStart", function()
		b:StartMoving()
		IsButtonDown = true
		b:SetScript("OnUpdate", UpdateMapBtn)
	end)
	b:SetScript("OnDragStop", function()
		b:StopMovingOrSizing()
		IsButtonDown = false
		b:SetScript("OnUpdate", nil)
		UpdateMapBtn()
	end)
	b:SetScript("OnMouseDown", function(self)
		b.background:SetTexCoord(0.075, 0.925, 0.075, 0.925)
		IsButtonDown = true
	end)
	b:SetScript("OnMouseUp", function(self)
		b.background:SetTexCoord(0, 1, 0, 1)
	end)
	b:SetScript("OnEnter", function(self)
		if not IsButtonDown then
			if b:GetLeft() and b:GetLeft()<400 then
				GameTooltip:SetOwner(b,"ANCHOR_RIGHT")
			else
				GameTooltip:SetOwner(b,"ANCHOR_LEFT")
			end
			GameTooltip:AddLine("MailLogger:")
			GameTooltip:AddLine(L["|cFF00FF00Left Click|r to Open Log Frame"])
			GameTooltip:AddLine(L["|cFF00FF00Right Click|r to Open Config Frame"])
			GameTooltip:AddLine(L["|cFF00FF00Shift+Left|r to Restore Log Frame Position"])
			GameTooltip:AddLine(L["|cFF00FF00Shift+Right|r to Restore Minimap Icon Position"])
			GameTooltip:Show()
		end
	end)
	b:SetScript("OnLeave", function(self)
		IsButtonDown = false
		GameTooltip:Hide()
	end)
	b:SetScript("OnClick", function(self, button)
		if IsShiftKeyDown() then
			if button == "LeftButton" then
				Output.background:ClearAllPoints()
				Output.background:SetPoint("RIGHT", nil, "RIGHT", -20, 0)
			elseif button == "RightButton" then
				Addon.Config.MinimapIconAngle = 345
				Addon:UpdatePosition(Addon.Config.MinimapIconAngle)
			end
		else
			if button == "LeftButton" then
				if Output.background:IsShown() and Output.export:GetParent():IsShown() then
					Output.export:GetParent():Hide()
					Output.background:Hide()
					Addon.Calendar.background:Hide()
				else
					Output.dropdowntitle:Show()
					Output.dropdownlist:Show()
					Output.dropdownbutton:Show()
					Addon:PrintTradeLog("ALL", nil)
					if Addon.Config.EnableCalendar then
						Addon:GetAvailableDate()
						Addon.Calendar.background:Show()
						Addon:RefreshCalendar()
					end
				end
			elseif button == "RightButton" then
				InterfaceOptionsFrame_OpenToCategory("MailLogger")
				InterfaceOptionsFrame_OpenToCategory("MailLogger")
			end
		end
	end)
	self.Minimap = b
end
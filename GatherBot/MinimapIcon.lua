local _, Addon = ...

local L = Addon.L
local MinimapIcon = Addon.MinimapIcon

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
		local texture = 133939 -- Herb Icon
		MinimapIcon.Broker = LDB:NewDataObject("GatherBot", {
			type = "launcher",
			text = "GatherBot",
			icon = texture,
			OnClick = MinimapIcon.MinimapOnClick,
			OnTooltipShow = MinimapIcon.MinimapOnEnter,
		})
		MinimapIcon.minimap = MinimapIcon.minimap or {hide = false}
		MinimapIcon.minimap.minimapPos = Addon.Config.MinimapIconAngle or 355
		LDBIcon:Register("GatherBot", MinimapIcon.Broker, MinimapIcon.minimap)
		MinimapIcon:ShowMinimap()
	end

	function MinimapIcon:ShowMinimap()
		if Addon.Config.ShowMinimapIcon then
			LDBIcon:Show("GatherBot")
		else
			LDBIcon:Hide("GatherBot")
		end
	end

	function MinimapIcon:MinimapOnClick(button)
		if IsShiftKeyDown() then
			if button == "LeftButton" then
				Addon.SetWindow.background:ClearAllPoints()
				Addon.SetWindow.background:SetPoint("CENTER", 400, 0)
			elseif button == "RightButton" then
				LDB:Hide("GatherBot")
				MinimapIcon.minimap.minimapPos = 355
				Addon.Config.MinimapIconAngle = 355
				LDB:Show("GatherBot")
			end
		else
			if button == "LeftButton" then
				Addon:GetCurrentSpells()
				if Addon.TrackingSpellsNum >= 2 then
					PlaySound(8959)
					if Addon.Config.Enabled then
						Addon.Config.Enabled = false
						Addon.Config.CurrentStatus = false
						UIErrorsFrame:AddMessage(L["<|cFFBA55D3GB|r>Truned the Tracking Auto Switch to OFF."])
						if Addon.Frame:IsShown() then
							Addon.Frame:Hide()
						end
					else
						Addon.Config.Enabled = true
						Addon.Config.CurrentStatus = true
						PlaySound(8959)
						UIErrorsFrame:AddMessage(L["<|cFFBA55D3GB|r>Truned the Tracking Auto Switch to ON."])
						if not Addon.Frame:IsShown() then
							Addon.Frame:Show()
						end
					end
				end
				if Addon.SetWindow.background:IsShown() then
					Addon.SetWindow.background:Hide()
					Addon.SetWindow.background:Show()
				end
		elseif button == "RightButton" then
				if Addon.SetWindow.background:IsShown() then
					Addon.SetWindow.background:Hide()
				else
					Addon:ShowSpellInfo()
					Addon.SetWindow.background:Show()
				end
			end
		end
	end
	function MinimapIcon:MinimapOnEnter()
		GameTooltip:AddLine("GatherBot:")
		GameTooltip:AddLine(L["|cFF00FF00Left Click|r to Enable/Disable Auto Switch"])
		GameTooltip:AddLine(L["|cFF00FF00Right Click|r to Open Config Frame"])
		GameTooltip:Show()
	end
	-- LDB END ]]--
else
	-- 環形移動小地圖按鈕
	function Addon:UpdatePosition(pos)
		local angle = math.rad(pos or 355)
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
		local b = CreateFrame("Button", "GatherBotMinimapButton", Minimap)

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
		b.icon:SetTexture(133939) --Icon Herb
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
				GameTooltip:AddLine("GatherBot:")
				GameTooltip:AddLine(L["|cFF00FF00Left Click|r to Enable/Disable Auto Switch"])
				GameTooltip:AddLine(L["|cFF00FF00Right Click|r to Open Config Frame"])
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
					Addon.SetWindow.background:ClearAllPoints()
					Addon.SetWindow.background:SetPoint("CENTER", 400, 0)
				elseif button == "RightButton" then
					Addon.Config.MinimapIconAngle = 355
					Addon:UpdatePosition(Addon.Config.MinimapIconAngle)
				end
			else
				if button == "RightButton" then
					if Addon.SetWindow.background:IsShown() then
						Addon.SetWindow.background:Hide()
					else
						Addon:ShowSpellInfo()
						Addon.SetWindow.background:Show()
					end
				elseif button == "LeftButton" then
					Addon:GetCurrentSpells()
					if Addon.TrackingSpellsNum >= 2 then
						PlaySound(8959)
						if Addon.Config.Enabled then
							Addon.Config.Enabled = false
							Addon.Config.CurrentStatus = false
							UIErrorsFrame:AddMessage(L["<|cFFBA55D3GB|r>Truned the Tracking Auto Switch to OFF."])
							if Addon.Frame:IsShown() then
								Addon.Frame:Hide()
							end
						else
							Addon.Config.Enabled = true
							Addon.Config.CurrentStatus = true
							PlaySound(8959)
							UIErrorsFrame:AddMessage(L["<|cFFBA55D3GB|r>Truned the Tracking Auto Switch to ON."])
							if not Addon.Frame:IsShown() then
								Addon.Frame:Show()
							end
						end
					end
					if Addon.SetWindow.background:IsShown() then
						Addon.SetWindow.background:Hide()
						Addon.SetWindow.background:Show()
					end
				end
			end
		end)
		self.Minimap = b
	end
end
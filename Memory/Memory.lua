-- MiniMap CoordText
MiniMapWorldMapButton:Hide()
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, y)
	if y > 0 then
		Minimap_ZoomIn()
	else
		Minimap_ZoomOut()
	end
end)


-- Performance
if not IsAddOnLoaded("Blizzard_TimeManager") then LoadAddOn("Blizzard_TimeManager") end

local function getNetColor()
	local _, _, lagHome, lagWorld = GetNetStats()
	local lag = lagHome > lagWorld and lagHome or lagWorld
	local r, g, b
	if lag > 600 then
		r = 1; g = 0; b = 0;
	elseif lag > 300 then
		r = 1; g = 1; b = 0;
	else
		r = 0; g = 1; b = 0;
	end
	return r, g, b, lag
end

hooksecurefunc("TimeManagerClockButton_Update", function()
	local r, g, b = getNetColor()
	TimeManagerClockTicker:SetVertexColor(r, g, b)
end)

TimeManagerClockButton:SetScript("OnClick", function(self, button)
	if self.alarmFiring then
		PlaySound(SOUNDKIT.IG_MAINMENU_QUIT)
		TimeManager_TurnOffAlarm()
	else
		if button == "LeftButton" then
			DEFAULT_CHAT_FRAME:AddMessage("内存已回收", 0, 0.6, 1)
			collectgarbage("collect")
		else
			TimeManager_Toggle()
		end
	end
end)

local function formats(value)
	if value > 999 then
		return format("|cffffff00%.2f MB|r", value/1024)
	else
		return format("|cff00ff00%.1f KB|r", value)
	end
end

local maxShown = 30
local numAddons = min(GetNumAddOns(), maxShown)
local addons = {}
for i = 1, numAddons do	addons[i] = {value = 0, name = ""} end

local iTimer_Start = GetTime()

function TimeManagerClockButton_UpdateTooltip()
	local iTimer_Now = GetTime()
	local iTimer_Past = iTimer_Now - iTimer_Start
	if iTimer_Past >= 0.5 then
		GameTooltip:ClearLines()
		if TimeManagerClockButton.alarmFiring then
			if ( gsub(Settings.alarmMessage, "%s", "") ~= "" ) then
				GameTooltip:AddLine(Settings.alarmMessage, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, 1)
			end
			GameTooltip:AddLine(TIMEMANAGER_ALARM_TOOLTIP_TURN_OFF)
		else
			GameTime_UpdateTooltip()
			GameTooltip:AddLine("右键"..GAMETIME_TOOLTIP_TOGGLE_CLOCK)
			GameTooltip:AddLine("左键点击这里回收内存。")
		end
		GameTooltip:AddLine(" ")

		local r, g, b, lag = getNetColor()
		GameTooltip:AddLine("----------------- 性能 -----------------")
		GameTooltip:AddDoubleLine("延迟：", format("%d ms", lag), 1, 0.82, 0, r, g, b)
		GameTooltip:AddDoubleLine("帧数：", format("%.0f fps", GetFramerate()))

		for i = 1, numAddons do
			if not addons[i] then
				addons[i] = { value = 0, name = "" }
			end
			addons[i].value = 0
		end
		UpdateAddOnMemoryUsage()

		local totalMem = 0
		for i = 1, GetNumAddOns() do
			local mem = GetAddOnMemoryUsage(i)
			totalMem = totalMem + mem
			for j = 1, numAddons do
				if mem > addons[j].value then
					for k = numAddons, 1, -1 do
						if k == j then
							addons[k].value = mem
							addons[k].name = GetAddOnInfo(i)
							break
						elseif k ~= 1 then
							addons[k].value = addons[k-1].value
							addons[k].name = addons[k-1].name
						end
					end
					break
				end
			end
		end
		if totalMem > 0 then
			GameTooltip:AddDoubleLine("插件内存：", formats(totalMem))
			for i = 1, numAddons do
				if addons[i].value == 0 then break end
				GameTooltip:AddDoubleLine(addons[i].name, formats(addons[i].value))
			end
		end
		GameTooltip:Show()
		iTimer_Start = iTimer_Now
	end
end


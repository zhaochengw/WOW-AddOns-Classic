local lib, oldminor = LibStub:NewLibrary("tekKonfig-Slider", 3)
if not lib then return end
oldminor = oldminor or 0


local GameTooltip = GameTooltip
local function HideTooltip() GameTooltip:Hide() end
local function ShowTooltip(self)
	if self.tiptext then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.tiptext, nil, nil, nil, nil, true)
	end
end


if oldminor < 2 then
	-- Create a slider.
	-- All args optional, parent recommended
	-- If lowvalue and highvalue are strings it is assumed they are % values
	-- and the % is parsed and set as decimal values for min/max
	function lib.new(parent, label, lowvalue, highvalue, ...)
		local container = CreateFrame("Frame", nil, parent)
		container:SetWidth(144)
		container:SetHeight(17+12+10)
		if select(1, ...) then container:SetPoint(...) end

		-- 为滑块生成唯一的名字
		local sliderName = "tekKonfigSlider" .. GetTime() .. math.random(1000)
		
		-- 使用Blizzard内置的OptionsSliderTemplate模板创建滑块
		local slider = CreateFrame("Slider", sliderName, container, "OptionsSliderTemplate")
		slider:SetPoint("LEFT")
		slider:SetPoint("RIGHT")
		slider:SetHeight(17)
		slider:SetHitRectInsets(0, 0, -10, -10)
		slider:SetOrientation("HORIZONTAL")
		
		-- 设置滑块的文本
		_G[sliderName .. "Low"]:SetText(lowvalue)
		_G[sliderName .. "High"]:SetText(highvalue)
		_G[sliderName .. "Text"]:SetText("")

		-- 创建滑块上方的标签
		local text = slider:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		text:SetPoint("BOTTOM", slider, "TOP")
		text:SetText(label)

		-- 保存原始的low和high文本对象，以便外部代码可以修改
		local low = _G[sliderName .. "Low"]
		local high = _G[sliderName .. "High"]

		-- 设置滑块的最小值和最大值
		if type(lowvalue) == "string" then slider:SetMinMaxValues(tonumber((lowvalue:gsub("%%", "")))/100, tonumber((highvalue:gsub("%%", "")))/100)
		else slider:SetMinMaxValues(lowvalue, highvalue) end

		-- Tooltip bits
		slider:SetScript("OnEnter", ShowTooltip)
		slider:SetScript("OnLeave", HideTooltip)

		return slider, text, container, low, high
	end
end


-- Create a slider without labels.
-- All args optional, parent recommended
function lib.newbare(parent, ...)
	-- 为滑块生成唯一的名字
	local sliderName = "tekKonfigBareSlider" .. GetTime() .. math.random(1000)
	
	-- 使用Blizzard内置的OptionsSliderTemplate模板创建滑块
	local slider = CreateFrame("Slider", sliderName, parent, "OptionsSliderTemplate")
	slider:SetHeight(17)
	slider:SetWidth(144)
	if select(1, ...) then slider:SetPoint(...) end
	slider:SetOrientation("HORIZONTAL")
	
	-- 隐藏默认的文本标签
	_G[sliderName .. "Low"]:SetText("")
	_G[sliderName .. "High"]:SetText("")
	_G[sliderName .. "Text"]:SetText("")

	-- 设置默认的最小值和最大值，确保滑块可用
	slider:SetMinMaxValues(0, 1) -- 临时默认值，会被后续的SetMinMaxValues覆盖
	slider:SetValue(0.5) -- 临时默认值，会被后续的SetValue覆盖

	-- Tooltip bits
	slider:SetScript("OnEnter", ShowTooltip)
	slider:SetScript("OnLeave", HideTooltip)

	return slider
end
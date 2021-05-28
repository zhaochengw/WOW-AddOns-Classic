local _G = getfenv(0)

CreateFrame("Frame", "zBarConfig", UIParent)
zBar3:AddPlugin(zBarConfig)

--[[ functional ]]
function zBarConfig:Load()
	self:SetWidth(350); self:SetHeight(415);
	self:SetPoint("CENTER")
	self:SetMovable(true)
	self:SetToplevel(true)
	self:SetFrameStrata("DIALOG")
	self:SetClampedToScreen(true)
end

function zBarConfig:Openfor(bar)
	if InCombatLockdown() then
		UIErrorsFrame:AddMessage(zBar3.loc.Msg.DontSetupInCombat,1.0,0.1,0.1,1.0)
		return
	end
	self:CheckReady()
	self:Select(bar)
	self:LoadOptions()
	self:Show()
end

function zBarConfig:GetSelected()
	if not self.bar then zBar3:print("Nothing selected") end
	return self.bar
end

--[[ Privates ]]
function zBarConfig:CheckReady()
	-- run once
	if self.ready then return true end
	self.ready = true

	--[[ Create at first time ]]

	-- background
	self:SetBackdrop( {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	});
	self:SetBackdropColor(0,0,0)
	self:SetBackdropBorderColor(0.5,0.5,0.5)

	-- drag
	self:EnableMouse(true)
	self:RegisterForDrag("LeftButton")
	self:SetScript("OnDragStart",function(this) this:StartMoving() end)
	self:SetScript("OnDragStop",function(this) this:StopMovingOrSizing() end)

	-- label texts
	local name, args, label
	for name, args in pairs(self.labels) do
		label = self:CreateFontString(self:GetName()..name,"ARTWORK",args[1])
		label:SetTextColor(args[2],args[3],args[4])
		label:SetPoint(args[5],args[6],args[7])
		label:SetText(zBar3.loc.Option[name])
	end

	-- close button
	CreateFrame("Button","zBarConfigCloseButton",self,"UIPanelCloseButton"):SetPoint("TOPRIGHT")

	-- choose bar
	local id, bar, button
	for id, name in ipairs(self.bars) do
		bar = _G[name]

		button = CreateFrame("CheckButton", "zBarConfigBar"..name,self,"zBarConfigRadioButtonTemplate")
		button.bar = bar

		if not bar or not bar.Reset then
			button:Disable()
			button:SetTextColor(0.5,0.5,0.5)
		end

		button:SetText(zBar3.loc.Labels[name])
		button:SaveTextColor()

		if id == 1 then
			button:SetPoint("TOPLEFT",zBarConfigSelectBar,"BOTTOMLEFT",0,-5)
		elseif mod(id, 4) == 1 then
			button:SetPoint("TOP","zBarConfigBar"..self.bars[id-4],"BOTTOM")
		else
			button:SetPoint("LEFT","zBarConfigBar"..self.bars[id-1],"RIGHT",62,0)
		end

		button:SetScript("OnClick", function(this)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			zBarConfig:Openfor(this.bar)
		end)
	end

	-- reset button
	button = CreateFrame("Button","zBarConfigResetButton",self,"UIPanelButtonTemplate")
	button:SetWidth(110); button:SetHeight(20);
	button:SetPoint("TOPRIGHT","zBarConfig","TOPRIGHT",-20,-140)
	button:SetText(zBar3.loc.Option.Reset)
	button:SetScript("OnClick", function() zBarConfig.bar:Reset(true) zBarConfig:LoadOptions() end)

	-- check buttons
	for id, value in ipairs(self.buttons) do
		local template
		if value.radio then
			template = "zBarConfigRadioButtonTemplate"
		else
			template = "zBarConfigCheckButtonTemplate"
		end
		button = CreateFrame("CheckButton","zBarConfig"..value.name,zBarConfig, template)
		button:SetPoint(value.pos[1],value.pos[2],value.pos[3],value.pos[4],value.pos[5])

		if value.notReady or (value.IsEnabled and not value.IsEnabled()) then
			button:Disable()
			button:SetTextColor(0.5,0.5,0.5)
		end

		button:SetText(zBar3.loc.Option[value.name])
		button:SaveTextColor()
		button.tooltipText = zBar3.loc.Tips[value.name]
		button:SetID(id)

		button:SetScript("OnClick",function(this)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			local value = zBarConfig.buttons[this:GetID()]
			local checked = this:GetChecked()
			-- save the option value
			if value.common then
				zBar3Data[value.var] = checked
			elseif value.var then
				if value.value and checked then
					checked = value.value
				end
				zBar3Data[zBarConfig.bar:GetName()][value.var] = checked
			end
			if checked then
				value.OnChecked()
			else
				value.UnChecked()
			end
		end)

	end

	-- sliders
	local slider, value
	for id, value in ipairs(zBarConfig.sliders) do
		slider = CreateFrame("Slider", "zBarConfigSlider"..id, zBarConfig, "OptionsSliderTemplate")
		slider:SetPoint(value.pos[1],value.pos[2],value.pos[3],value.pos[4],value.pos[5])
		slider:SetMinMaxValues(value.min,value.max)
		slider:SetValueStep(value.step)
		slider:SetScript("OnValueChanged", value.setFunc)

		slider.text = _G["zBarConfigSlider"..id.."Text"]
		slider.text:SetText(zBar3.loc.Option[value.name])
		slider.tooltipText = zBar3.loc.Tips[value.name]

		if value.factor then
			_G["zBarConfigSlider"..id.."Low"]:SetText(value.min * value.factor .. "%")
			_G["zBarConfigSlider"..id.."High"]:SetText(value.max * value.factor .. "%")
		else
			_G["zBarConfigSlider"..id.."Low"]:SetText(value.min)
			_G["zBarConfigSlider"..id.."High"]:SetText(value.max)
		end
	end
	-- edit box for scale input
	CreateFrame("EditBox","zBarConfigSlider3EditBox",zBarConfigSlider3,"InputBoxTemplate")
	zBarConfigSlider3EditBox:SetWidth(30) zBarConfigSlider3EditBox:SetHeight(20)
	zBarConfigSlider3EditBox:SetAutoFocus(true)
	zBarConfigSlider3EditBox:SetNumeric(true)
	zBarConfigSlider3EditBox:SetMaxLetters(3)
	zBarConfigSlider3EditBox:SetFocus(true)
	zBarConfigSlider3EditBox:SetPoint("LEFT",zBarConfigSlider3Text,"RIGHT",6,0)
	
	zBarConfigSlider3EditBox:SetScript("OnEnterPressed", function(this)
		zBarConfigSlider3:SetValue(this:GetNumber()*0.01)
	end)
	zBarConfigSlider3EditBox:SetScript("OnEscapePressed", function(this)
		zBarConfig:Hide()
	end)

	zBarConfigSlider3EditBox:CreateFontString("zBarConfigSlider3EditBoxText","ARTWORK","GameFontNormalSmall")
	zBarConfigSlider3EditBoxText:SetText('%')
	zBarConfigSlider3EditBoxText:SetPoint("LEFT",zBarConfigSlider3EditBox,"RIGHT")
end

function zBarConfig:LoadOptions()
	self.loading = 1
	local id, value, obj
	-- read check buttons value
	for id, value in ipairs(zBarConfig.buttons) do
		obj = _G["zBarConfig"..value.name]
		if value.IsChecked then -- system attributes
			obj:SetChecked(value.IsChecked())
		elseif value.var then
			if value.common then -- common attributes
				obj:SetChecked(zBar3Data[value.var])
			elseif value.value then
				obj:SetChecked(zBar3Data[zBarConfig.bar:GetName()][value.var] == value.value)
			else -- bar attributes
				obj:SetChecked(zBar3Data[zBarConfig.bar:GetName()][value.var])
			end
		end
	end
	-- read sliders value
	local min = 1
	local max = zBar3Data[self.bar:GetName()].max or 12
	local num = zBar3Data[zBarConfig.bar:GetName()].num or 1
	local linenum = zBar3Data[zBarConfig.bar:GetName()].linenum or 1
	if max == 0 then min = 0 end
	zBarConfigSlider1:SetMinMaxValues(min,max)
	zBarConfigSlider1:SetValue(num)
	zBarConfigSlider1High:SetText(max)
	zBarConfigSlider2:SetMinMaxValues(min,max)
	zBarConfigSlider2:SetValue(linenum)
	zBarConfigSlider2High:SetText(max)
	for id, value in ipairs(zBarConfig.sliders) do
		obj = _G["zBarConfigSlider"..id]
		obj:SetValue(zBar3Data[zBarConfig.bar:GetName()][value.var] or 1)
	end
	self.loading = nil
end

function zBarConfig:Select(bar)
	local id, name, button
	for id, name in pairs(self.bars) do
		button = _G["zBarConfigBar"..name]
		if button:GetChecked() then
			button:SetChecked(false)
			button:SetTextColor(1.0, 0.82, 0)
			button:SaveTextColor()
		end
	end
	button = _G["zBarConfigBar"..bar:GetName()]
	button:SetChecked(true)
	button:SetTextColor(0.1, 1.0, 0.1)
	button:SaveTextColor()

	self.bar = bar
end

--[[ utilities ]]

function zBarConfig:Befor_ShowGrid()
 	if InCombatLockdown() then return end
	for name,bar in pairs(zBar3.bars) do
		if bar:GetID() >= 5 and bar:GetID() <= 8 then
			for i=1,12 do
				local button = _G[zBar3.buttons[name..i]]
				button:SetAttribute("showgrid", button:GetAttribute("showgrid") + 1)
			end
		end
	end
end

function zBarConfig:Befor_HideGrid()
 	if InCombatLockdown() then return end
	for name,bar in pairs(zBar3.bars) do
		if bar:GetID() >= 5 and bar:GetID() <= 8 then
			for i=1,12 do
				local button = _G[zBar3.buttons[name..i]]
				local showgrid = button:GetAttribute("showgrid")
				if showgrid > 0 then
					button:SetAttribute("showgrid", showgrid - 1)
				end
			end
		end
	end
end

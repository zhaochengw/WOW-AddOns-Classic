local eCB_FMT_Orig_BeginFlight;
local eCB_FMT_Orig_EndFlight;
local f = CreateFrame("Button", "eCBTestButton", UIParent, "TabButtonTemplate")
f:SetText(CASTINGBAR_CASTING_TAB..CASTINGBAR_MIRROR_TAB..CASTINGBAR_PROFILE_TAB)
eCB_Tab_Padding = ((530 - f:GetTextWidth())/5)-24

function eCastingBarOptions_OnLoad()
	tinsert(UISpecialFrames, "eCB_OptionFrame");
end

function eCastingBarOptions_OnEvent(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		eCB_FMT_Orig_BeginFlight = FlightMapTimes_BeginFlight;
		eCB_FMT_Orig_EndFlight = FlightMapTimes_EndFlight;
		FlightMapTimes_BeginFlight = eCB_FMT_BeginFlight;
		FlightMapTimes_EndFlight = eCB_FMT_EndFlight;
		if not eCastingBar_Saved  or eCastingBar_Saved == 1 then
			eCastingBar_Saved = {}
			ECB_addChat( CASTINGBAR_BROKENSAVE )
			eCastingBar_ResetSettings()
		end
		eCastingBar_CheckSettings()
		eCastingBar_LoadVariables()
	end
end

function eCB_FMT_BeginFlight(duration, destination)
	if eCastingBar_Saved.MirrorUseFlightTimer == 0 then
  	eCB_FMT_Orig_BeginFlight(duration, destination)
  else
    if not FlightMap.Opts.useTimer then return; end
    local endTime = 0;
    if (duration) then 
    	endTime = (duration * 1000);
    end
    eCastingBarMirror_Show("FLIGHT", endTime, endTime, -1, 0, destination)
	end
end

function eCB_FMT_EndFlight(self)
	self.started = false;
	for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
		local frame = _G["eCastingBarMirror"..index];
		if ( frame.timer == "FLIGHT") then
			_G[frame:GetName().."Flash"]:SetAlpha( 0.0 )
			_G[frame:GetName().."Flash"]:Show()
			frame.flash = 1
			frame.fadeOut = 1
		end
	end
end
function eCastingBar_Defaults()
  eCastingBar_ResetSettings()
  eCastingBar_LoadVariables()
end

function eCastingBarConfig_OnShow()
  eCB_OptionFrame_CastingTab_Click();
end

function eCastingBar_CloseConfig()
	HideUIPanel(eCB_OptionFrame);
	_G["eCastingBarSettings_Setting"]:SetText("")
end

function eCastingBar_ColorPicker_OnClick(self)
	if (ColorPickerFrame:IsShown()) then
		eCastingBar_ColorPicker_Cancelled(ColorPickerFrame.previousValues)
		ColorPickerFrame:Hide()
  else
		local Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[self.objindex])
		ColorPickerFrame.previousValues = {Red, Green, Blue, Alpha}
		ColorPickerFrame.cancelFunc = eCastingBar_ColorPicker_Cancelled
		ColorPickerFrame.opacityFunc = eCastingBar_ColorPicker_OpacityChanged
		ColorPickerFrame.func = eCastingBar_ColorPicker_ColorChanged
		ColorPickerFrame.index = self:GetName().."Texture"
		ColorPickerFrame.objindex = self.objindex
		ColorPickerFrame.whenindex = self.whenindex
		ColorPickerFrame.hasOpacity = true
		ColorPickerFrame.opacity = Alpha
		ColorPickerFrame:SetColorRGB(Red, Green, Blue)
		ColorPickerFrame:ClearAllPoints()
		local x = eCB_OptionFrame:GetCenter()
		if (x < UIParent:GetWidth() / 2) then
			ColorPickerFrame:SetPoint("LEFT", "eCB_OptionFrame", "RIGHT", 0, 0)
		else
			ColorPickerFrame:SetPoint("RIGHT", "eCB_OptionFrame", "LEFT", 0, 0)
		end
    ColorPickerFrame:Show()
  end
end

function eCastingBar_ColorPicker_Cancelled(color)
	eCastingBar_Saved[ColorPickerFrame.objindex] = color
  _G[ColorPickerFrame.index]:SetVertexColor(unpack(color))
  if (ColorPickerFrame.objindex == "FlashBorderColor" 
  or ColorPickerFrame.objindex == "MirrorFlashBorderColor") then
    eCastingBar_checkFlashBorderColors()
  end
end

function eCastingBar_ColorPicker_OpacityChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local a = OpacitySliderFrame:GetValue()
	_G[ColorPickerFrame.index]:SetVertexColor(r, g, b, a)
end

function eCastingBar_ColorPicker_ColorChanged()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local a = OpacitySliderFrame:GetValue()
	_G[ColorPickerFrame.index]:SetVertexColor(r,g,b,a)
	if (not ColorPickerFrame:IsShown()) then
		eCastingBar_Saved[ColorPickerFrame.objindex] = {r,g,b,a}
    if (ColorPickerFrame.objindex == "FlashBorderColor" or ColorPickerFrame.objindex == "TargetBarFlashBorderColor" or ColorPickerFrame.objindex == "MirrorFlashBorderColor") then
      eCastingBar_checkFlashBorderColors()
    elseif (ColorPickerFrame.objindex == "TimeColor" or ColorPickerFrame.objindex == "TargetBarTimeColor" or ColorPickerFrame.objindex == "MirrorTimeColor") then
    	eCastingBar_checkTimeColors()
    elseif (ColorPickerFrame.objindex == "LagColor" or ColorPickerFrame.objindex == "TargetBarDelayColor") then
    	eCastingBar_setLagColor()
    elseif (ColorPickerFrame.objindex == "SpellColor" 
    	or ColorPickerFrame.objindex == "ChannelColor" 
    	or ColorPickerFrame.objindex == "FeignDeathColor"
    	or ColorPickerFrame.objindex == "BreathColor"
    	or ColorPickerFrame.objindex == "ExhaustionColor"
    	or ColorPickerFrame.objindex == "FlightColor")
    	then
    	eCastingBar_setColor(ColorPickerFrame.objindex);
    end
	end
end

------- [1] Tab Menu Control (by Bitz) -----------------------------------------
function eCB_OptionFrame_CastingTab_Click()
	PanelTemplates_SelectTab(eCB_OptionFrameCastingTab);
	PanelTemplates_DeselectTab(eCB_OptionFrameMirrorTab);
	PanelTemplates_DeselectTab(eCB_OptionFrameProfileTab);
	eCB_OptionFrameTabbedCasting:Show();
	eCB_OptionFrameTabbedMirror:Hide();
	eCB_OptionFrameTabbedProfile:Hide();
	eCastingBar_DropMenu:Hide();
	eCastingBar_checkTextures();
end

function eCB_OptionFrame_MirrorTab_Click()
	PanelTemplates_SelectTab(eCB_OptionFrameMirrorTab);
	PanelTemplates_DeselectTab(eCB_OptionFrameCastingTab);
	PanelTemplates_DeselectTab(eCB_OptionFrameProfileTab);
	eCB_OptionFrameTabbedCasting:Hide();
	eCB_OptionFrameTabbedMirror:Show();
	eCB_OptionFrameTabbedProfile:Hide();
	eCastingBar_DropMenu:Hide();
	eCastingBar_checkTextures();
end

function eCB_OptionFrame_ProfileTab_Click()
	PanelTemplates_SelectTab(eCB_OptionFrameProfileTab);
	PanelTemplates_DeselectTab(eCB_OptionFrameCastingTab);
	PanelTemplates_DeselectTab(eCB_OptionFrameMirrorTab);
	eCB_OptionFrameTabbedCasting:Hide();
	eCB_OptionFrameTabbedMirror:Hide();
	eCB_OptionFrameTabbedProfile:Show();
	eCastingBar_DropMenu:Hide();
end
------- End of [1] -------------------------------------------------------------

function eCastingBar_CheckButton_OnClick(self)
  eCastingBar_Saved[self.index] = convertBooleanToInt(self:GetChecked())
  if (string.find(self.index, "Locked")) then
    eCastingBar_checkLocked()
  elseif (string.find(self.index, "Enabled")) then
    if (string.find(self.index, "Mirror")) then
      if (convertBooleanToInt(self:GetChecked()) == 0) then
        showAllBlizzardMirrorFrames()
      else
        hideAllBlizzardMirrorFrames()
      end
    end
    eCastingBar_checkEnabled()
  elseif (string.find(self.index, "HideBorder")) then
    eCastingBar_checkBorders()
  end

	testMode()
    testModeMirror()      
end

function convertBooleanToInt(val)
	if (val) then
		return 1
  else
    return 0
	end
end

function eCastingBarSlider_OnValueChanged(self)
  eCastingBar_Saved[self.index] = self:GetValue()
  if (_G["eCastingBar"..self.index.."EditBox"]) then
    _G["eCastingBar"..self.index.."EditBox"]:SetNumber(self:GetValue())
  end
  -- set the tool tip text
	if (self:GetValue() == floor(self:GetValue())) then
		GameTooltip:SetText(format("%d", self:GetValue()))
	else
		GameTooltip:SetText(format("%.2f", self:GetValue()))
	end
  eCastingBar_SetSize()
end

function eCastingBarSlider_OnEnter(self)
  -- put the tool tip in the default position
	GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
  -- set the tool tip text
	if (self:GetValue() == floor(self:GetValue())) then
		GameTooltip:SetText(format("%d", self:GetValue()))
	else
		GameTooltip:SetText(format("%.2f", self:GetValue()))
	end
	GameTooltip:Show()
end

function eCastingBarSlider_OnLeave()
	GameTooltip:Hide()
end

function eCastingBar_setAnchor(self, subframe, xoffset, yoffset)
	xoffset = _G[self:GetName().."_Label"]:GetWidth() + xoffset + 5
	self:SetPoint("TOPLEFT", self:GetParent():GetName()..subframe, "BOTTOMLEFT", xoffset, yoffset)
end

function eCastingBar_Menu_TimeOut(self, elapsed)
	if (self.elapsed) then
		self.elapsed = self.elapsed - elapsed
		if (self.elapsed > 0) then
			self.elapsed = 0.125
			self:Hide()
		end
	end
end

function eCastingBar_Menu_Show(menu, index, controlbox)
	if (not menu) then return end
	if (eCastingBar_DropMenu:IsVisible()) then
		eCastingBar_DropMenu:Hide()
		return
	end
  
  if (menu == "SavedSettings") then
		menu = eCastingBar_MENU_SAVEDSETTINGS
	end
  
	eCastingBar_DropMenu.index = index
	eCastingBar_DropMenu.controlbox = controlbox
  
	local width = 0
	local count = 1
	local textwidth
  local frame
  
	for _,v in pairs(menu) do
    frame = _G["eCastingBar_DropMenu_Option"..count]
    frame:SetFrameLevel(_G[controlbox]:GetFrameLevel())
		frame:Show()
		_G["eCastingBar_DropMenu_Option"..count.."_Text"]:SetText(v.text)
		frame.value =v.value
		textwidth = _G["eCastingBar_DropMenu_Option"..count.."_Text"]:GetWidth()
		if (textwidth > width) then
			width = textwidth
		end
		count = count + 1
	end
	for i=1, 40 do
		if (i < count) then
			_G["eCastingBar_DropMenu_Option"..i]:SetWidth(width)
		else
			_G["eCastingBar_DropMenu_Option"..i]:Hide()
		end
	end
	count = count - 1
	eCastingBar_DropMenu:SetWidth(width + 20)
	eCastingBar_DropMenu:SetHeight(count * 15 + 20)
	eCastingBar_DropMenu:ClearAllPoints()
	eCastingBar_DropMenu:SetPoint("TOPRIGHT", controlbox, "BOTTOMRIGHT", 0, 0)
	if (eCastingBar_DropMenu:GetBottom() < UIParent:GetBottom()) then
		local yoffset = UIParent:GetBottom() - eCastingBar_DropMenu:GetBottom()
		eCastingBar_DropMenu:ClearAllPoints()
		eCastingBar_DropMenu:SetPoint("TOPRIGHT", controlbox, "BOTTOMRIGHT", 0, yoffset)
	end
	eCastingBar_DropMenu:Show()
end

function eCastingBar_Menu_OnClick(self)
	self:GetParent():Hide()
	_G[eCastingBar_DropMenu.controlbox.."_Setting"]:SetText(_G[self:GetName().."_Text"]:GetText())
	if (eCastingBar_DropMenu.index == "SavedSettings") then
		eCastingBar_SETTINGS_INDEX = self.value
		eCastingBarLoadSettingsButton:Enable(); -- added by Bitz
		eCastingBarDeleteSettingsButton:Enable();
    return
  	elseif (eCastingBar_DropMenu.index == "SelectTexture") then
		eCastingBar_Saved.Texture = self.value;
		eCastingBar_checkTextures();
	elseif (eCastingBar_DropMenu.index == "MirrorSelectTexture") then
		eCastingBar_Saved.MirrorTexture = self.value
		eCastingBar_checkTextures();
	elseif (eCastingBar_DropMenu.index == "IconPosition") then
		eCastingBar_Saved.IconPosition = self.value
		eCastingBar_setIcons();
	end
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	testMode()
	testModeMirror()
end

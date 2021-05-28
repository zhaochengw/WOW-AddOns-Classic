
local function SetSliderData(key, minValue, maxValue, valueStep)
	local data = DEXOptionsFrameSliders[key]
	if data then
		data.minValue, data.maxValue, data.valueStep = minValue, maxValue, valueStep or 1
	end
end

SetSliderData("DEX_Font", 1, 4)
SetSliderData("DEX_FontSize", 12, 42)
SetSliderData("DEX_OutLine", 1, 5)
SetSliderData("DEX_Speed", 30, 300, 5)
SetSliderData("DEX_LOGLINE", 5, 20)
SetSliderData("DEX_LOGTIME", 5, 60)

DEXOptionsColorPickerEx["DEX_ColorNormalSe"] = {}
DEXOptionsColorPickerEx["DEX_ColorSkillSe"] = {}
DEXOptionsColorPickerEx["DEX_ColorPeriodicSe"] = {}
DEXOptionsColorPickerEx["DEX_ColorHealthSe"] = {}
DEXOptionsColorPickerEx["DEX_ColorSpecSe"] = {}
DEXOptionsColorPickerEx["DEX_ColorManaSe"] = {}


--Set color functions
local DEXOptionsFrame_SetColorFunc = {
	["DEX_ColorNormal"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorNormal") end,
	["DEX_ColorSkill"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorSkill") end,
	["DEX_ColorPeriodic"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorPeriodic") end,
	["DEX_ColorHealth"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorHealth") end,
	["DEX_ColorPet"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorPet") end,
	["DEX_ColorSpec"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorSpec") end,
	["DEX_ColorMana"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorMana") end,

	["DEX_ColorNormalSe"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorNormalSe") end,
	["DEX_ColorSkillSe"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorSkillSe") end,
	["DEX_ColorPeriodicSe"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorPeriodicSe") end,
	["DEX_ColorHealthSe"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorHealthSe") end,
	["DEX_ColorSpecSe"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorSpecSe") end,
	["DEX_ColorManaSe"] = function(x) DEXOptionsFrame_SetColor("DEX_ColorManaSe") end,
};

local DEXOptionsFrame_CancelColorFunc = {
	["DEX_ColorNormal"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorNormal",x) end,
	["DEX_ColorSkill"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorSkill",x) end,
	["DEX_ColorPeriodic"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorPeriodic",x) end,
	["DEX_ColorHealth"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorHealth",x) end,
	["DEX_ColorPet"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorPet",x) end,
	["DEX_ColorSpec"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorSpec",x) end,
	["DEX_ColorMana"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorMana",x) end,

	["DEX_ColorNormalSe"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorNormalSe",x) end,
	["DEX_ColorSkillSe"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorSkillSe",x) end,
	["DEX_ColorPeriodicSe"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorPeriodicSe",x) end,
	["DEX_ColorHealthSe"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorHealthSe",x) end,
	["DEX_ColorSpecSe"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorSpecSe",x) end,
	["DEX_ColorManaSe"] = function(x) DEXOptionsFrame_CancelColor("DEX_ColorManaSe",x) end,
};


function DEX_RefreshCheckButton(name)
	local button = getglobal(name);
	local str = getglobal(name.."Text");
	local checked = button:GetChecked();
	--button.disabled = nil;
	if ( DEX_Get(name) == 1 ) then
		checked = true;
	else
		checked = false;
	end
	OptionsFrame_EnableCheckBox(button);
	button:SetChecked(checked);
	str:SetText(DEXOptionsFrameCheckButtons[name].title);
	button.tooltipText = DEXOptionsFrameCheckButtons[name].tooltipText;
	DEX_CheckButtonLink(name);
end

function DEX_CheckButtonLink(name)
	if name == "DEX_ShowSpellName" then
		if DEX_Get(name) == 1 then
			OptionsFrame_EnableCheckBox(getglobal("DEX_ShowNameOnCrit"));
			DEX_RefreshCheckButton("DEX_ShowNameOnCrit");
			OptionsFrame_EnableCheckBox(getglobal("DEX_ShowNameOnMiss"));
			DEX_RefreshCheckButton("DEX_ShowNameOnMiss");
			OptionsFrame_EnableCheckBox(getglobal("DEX_ShowSpellIcon"));
			DEX_RefreshCheckButton("DEX_ShowSpellIcon");						
		else
			OptionsFrame_DisableCheckBox(getglobal("DEX_ShowNameOnCrit"));
			OptionsFrame_DisableCheckBox(getglobal("DEX_ShowNameOnMiss"));
			OptionsFrame_DisableCheckBox(getglobal("DEX_ShowSpellIcon"));			
		end
	end
	if name == "DEX_ShowWithMess" then
		if DEX_Get(name) == 1 then
			OptionsFrame_EnableSlider(getglobal("DEX_LOGLINE"));
			DEX_RefreshFrameSliders("DEX_LOGLINE");
			OptionsFrame_EnableSlider(getglobal("DEX_LOGTIME"));
			DEX_RefreshFrameSliders("DEX_LOGLINE");
			OptionsFrame_DisableSlider(getglobal("DEX_Speed"));
		else
			OptionsFrame_DisableSlider(getglobal("DEX_LOGLINE"));
			OptionsFrame_DisableSlider(getglobal("DEX_LOGTIME"));
			OptionsFrame_EnableSlider(getglobal("DEX_Speed"));
			DEX_RefreshFrameSliders("DEX_Speed");
		end
	end		
	if name == "DEX_ShowInterrupt" then
		if DEX_Get(name) == 1 then
			OptionsFrame_EnableCheckBox(getglobal("DEX_ShowInterruptCrit"));
			DEX_RefreshCheckButton("DEX_ShowInterruptCrit");				
		else
			OptionsFrame_DisableCheckBox(getglobal("DEX_ShowInterruptCrit"));	
		end
	end
end

function DEX_ConfigColorPicker(name)
	local frame,swatch,sRed,sGreen,sBlue,sColor;

	frame = getglobal(name);
	swatch = getglobal(name.."_ColorSwatchNormalTexture");

	sColor = DEX_Get(name);
	sRed = sColor[1];
	sGreen = sColor[2];
	sBlue = sColor[3];

	frame.r = sRed;
	frame.g = sGreen;
	frame.b = sBlue;
	frame.swatchFunc = DEXOptionsFrame_SetColorFunc[name];
	frame.cancelFunc = DEXOptionsFrame_CancelColorFunc[name];
	swatch:SetVertexColor(sRed,sGreen,sBlue);
end
function DEX_RefreshColorPickerEx(name)
	local str = getglobal(name.."_Text");
	str:SetText(DEXOptionsColorPickerEx[name].title);
	DEX_ConfigColorPicker(name);
end

function DEX_RefreshFrameSliders(name)
	local slider = getglobal(name);
	local str = getglobal(name.."Text");
	local low = getglobal(name.."Low");
	local high = getglobal(name.."High");

	local value = DEXOptionsFrameSliders[name];
	OptionsFrame_EnableSlider(slider);
	slider:SetMinMaxValues(value.minValue, value.maxValue);
	slider:SetValueStep(value.valueStep);
	slider:SetValue( DEX_Get(name) );
	str:SetText(value.title);
	low:SetText(value.minText);
	high:SetText(value.maxText);
	slider.tooltipText = value.tooltipText;

	DEX_OptionsSliderRefreshTitle(name);
end

----------------------
--Called when option page loads
function DEXOptionsFrame_OnShow(self)

	for key, value in pairs(DEXOptionsFrameCheckButtons) do
		DEX_RefreshCheckButton(key);
	end

	for key, value in pairs(DEXOptionsFrameSliders) do
		DEX_RefreshFrameSliders(key);
	end

	for key, value in pairs(DEXOptionsColorPickerEx) do
		DEX_RefreshColorPickerEx(key);
	end
end

----------------------
--Sets the colors of the config from a color swatch
function DEXOptionsFrame_SetColor(name)
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local swatch,frame;
	swatch = getglobal(name.."_ColorSwatchNormalTexture");
	frame = getglobal(name);
	swatch:SetVertexColor(r,g,b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
	--update back to config
	DEX_Set(name, {r, g, b})
end

----------------------
-- Cancels the color selection
function DEXOptionsFrame_CancelColor(name, prev)
	local r = prev.r;
	local g = prev.g;
	local b = prev.b;
	local swatch, frame;
	swatch = getglobal(name.."_ColorSwatchNormalTexture");
	frame = getglobal(name);
	swatch:SetVertexColor(r, g, b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
	-- Update back to config
	DEX_Set(name, {r, g, b})
end

----------------------

function DEX_OptionsSliderRefreshTitle(name)
	local slider = getglobal(name);
	local valStep = slider:GetValueStep()
	local str = getglobal(name.."Text");
	local txt;
	local val = slider:GetValue();
	if name == "LOWHP" or name == "LOWMANA" or name == "ALPHA" or name == "MESSAGEALPHA" then
		if val < 1 then
			txt = format("%d",val * 100);
		else
			txt = 100;
		end
	elseif name == "ANIMATIONSPEED" then
		txt = format("0.0%d",val * 1000);
	else
		txt = floor(val/valStep)*valStep;
	end
	str:SetText(DEXOptionsFrameSliders[name].title..": "..txt);
end
--Sets the silder values in the config
function DEX_OptionsSliderOnValueChanged(self, name)
	local slider = getglobal(name);
	local valStep = slider:GetValueStep()
   local value = slider:GetValue()
   local svalue = floor(value/valStep)*valStep
--   slider:SetValue(svalue)
   DEX_Set(name,svalue);
--http://bbs.ngacn.cc/read.php?&tid=6548794&pid=119427727&to=1
--	DEX_Set(name,slider:GetValue());

	DEX_OptionsSliderRefreshTitle(name);
end

----------------------
--Sets the checkbox values in the config
function DEX_OptionsCheckButtonOnClick(self, name)
	local button = getglobal(name);
	local val;
	if button:GetChecked() then val = 1;else val = 0;end

	DEX_Set(name,val);
	DEX_CheckButtonLink(name);
end

----------------------
--Open the color selector using show/hide
function DEX_OpenColorPicker(self, button)
	CloseMenus();
	if ( not button ) then
		button = self;
	end
	ColorPickerFrame.func = button.swatchFunc;
	ColorPickerFrame:SetColorRGB(button.r, button.g, button.b);
	ColorPickerFrame.previousValues = {r = button.r, g = button.g, b = button.b, opacity = button.opacity};
	ColorPickerFrame.cancelFunc = button.cancelFunc;
	ColorPickerFrame:Show();
end

function DEX_preSavePosition(self)
	local x,y = self:GetCenter();
	x = x - GetScreenWidth() / 2;
	y = y - GetScreenHeight() / 2;
	DEX_Set("DEX_PosX",x);
	DEX_Set("DEX_PosY",y);
end

function DEX_showMenu()
	PlaySound(850);
	ShowUIPanel(DEXOptions);
	local pre = getglobal("DEX_PreBox");
	pre:ClearAllPoints();
	pre:SetPoint("CENTER", "UIParent", "CENTER", DEX_Get("DEX_PosX",x), DEX_Get("DEX_PosY",y));
	pre:Show();
	DEX_CheckButtonLink("DEX_ShowSpellName");
	DEX_CheckButtonLink("DEX_ShowWithMess");
end

--Hide the Option Menu
function DEX_hideMenu()
	PlaySound(851);
	HideUIPanel(DEXOptions);
	local pre = getglobal("DEX_PreBox");
	pre:Hide();
	-- myAddOns support
	if(MYADDONS_ACTIVE_OPTIONSFRAME == DEXOptions) then
		ShowUIPanel(myAddOnsFrame);
	end
	DEX_aniInit();
	DEX_staticInit();
end

function DEXOptionsFrameDropDownCats_Initialize()
	local i;
	for i = 1, 3 do
		info = {
			text = DEXOptionsDropDown[i];
			func = DEXOptionsFrameDropDownCats_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end


function DEXOptionsFrameDropDownCats_OnShow()
	UIDropDownMenu_Initialize(DEXOptionsDropDownCats, DEXOptionsFrameDropDownCats_Initialize)
	UIDropDownMenu_SetSelectedID(DEXOptionsDropDownCats, DEX_Get("DEX_ColorMode"))
	UIDropDownMenu_SetWidth(DEXOptionsDropDownCats,100)
end


function DEXOptionsFrameDropDownCats_OnClick(self)
	local thisID = self:GetID()
	UIDropDownMenu_SetSelectedID(DEXOptionsDropDownCats, thisID)
	DEX_Set("DEX_ColorMode",thisID)
end

function DEX_CloseOptions()
	PlaySound(798);
	if ( ColorPickerFrame:IsVisible() ) then
		ColorPickerFrame:Hide();
	end
	DEX_hideMenu();
end

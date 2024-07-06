--[[
Functions to Save and Load settings are in here
]]--

function  eCastingBar_SetSavedSettingsMenu()
  if (eCastingBar_Settings == nil) then
  	eCastingBar_Settings = {}
  end
  
  local i = 1
  
  eCastingBar_MENU_SAVEDSETTINGS = {}
  
  if (eCastingBar_Settings ~= nil) then
  	for index in pairs(eCastingBar_Settings) do
		  eCastingBar_MENU_SAVEDSETTINGS[i] = { text = index, value = index }
      i = i + 1
    end
  end
end


function eCastingBar_SaveSetting()
  local name = eCastingBarSaveNameEditBox:GetText()
  if (name == nil or name == "") then return;end
  -- save the current settings under this name
  eCastingBar_Settings[name] = {}  
	eCastingBar_Copy_Table(eCastingBar_Saved, eCastingBar_Settings[name]);
  
  eCastingBar_SetSavedSettingsMenu()
  
  eCastingBarSaveNameEditBox:SetText("")
  ECB_addChat("["..strYellow..name..strWhite.."] "..CASTINGBAR_PROFILE_SAVED)
end

function eCastingBar_LoadSetting()
  if (not eCastingBar_SETTINGS_INDEX or eCastingBar_SETTINGS_INDEX=="") then return;  end
  
  eCastingBar_Saved = {};
	eCastingBar_Copy_Table(eCastingBar_Settings[eCastingBar_SETTINGS_INDEX], eCastingBar_Saved);
  eCastingBar_CheckSettings()
  setup()
  setupConfigFrame()
  setupDefaultConfigFrame()
  setupColorsConfigFrame()
  
  _G["eCastingBarSettings_Setting"]:SetText("")
  eCastingBarLoadSettingsButton:Disable(); -- added by Bitz
  eCastingBarDeleteSettingsButton:Disable();
  ECB_addChat("["..strYellow..eCastingBar_SETTINGS_INDEX..strWhite.."] "..CASTINGBAR_PROFILE_LOADED)
end

function eCastingBar_DeleteSetting()
  if (not eCastingBar_SETTINGS_INDEX or eCastingBar_SETTINGS_INDEX == "") then return;  end
  
  eCastingBar_Settings[eCastingBar_SETTINGS_INDEX] = nil
  eCastingBar_SetSavedSettingsMenu()
  
	_G["eCastingBarSettings_Setting"]:SetText("")
	eCastingBarLoadSettingsButton:Disable(); -- added by Bitz
  eCastingBarDeleteSettingsButton:Disable();
  ECB_addChat("["..strYellow..eCastingBar_SETTINGS_INDEX..strWhite.."] "..CASTINGBAR_PROFILE_DELETED)
  eCastingBar_SETTINGS_INDEX = "";
end

function eCastingBar_GetSettingName(index)
  local i = 1;
  ECB_addChat("index "..index)
  for name in pairs(eCastingBar_Settings) do
  ECB_addChat("i "..i)
  ECB_addChat("name "..name)
  	if (index == i) then
  		return name;
  	end
  end
end

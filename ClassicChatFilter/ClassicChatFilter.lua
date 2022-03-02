defaultProfile =
{
	["show_player_messages"] = true,
	["show_player_mentions"] = true,
	["channels"] = {},
	["banned"] = {},
	["dungeons"] = {},
	["dungeons_roles"] = {},
	["dungeons_types"] = {},
	["raids"] = {},
	["raids_roles"] = {},
	["other"] = {},
}

exampleProfie =
{
	["show_player_messages"] = true,
	["show_player_mentions"] = true,
	["channels"] = {
		"综合", -- [1]
		"寻求组队", -- [2]
	},
	["banned"] = {
		"求组", -- [1]
		"宝宝", -- [2]
		"附魔", -- [3]
	},
	["dungeons"] = {
		"AA队", -- [1]
		"来宝宝", -- [2]
	},
	["dungeons_roles"] = {
		"张三", -- [1]
	},
	["dungeons_types"] = {
		"KLZ", -- [1]
		"STSM", -- [2]
	},
	["raids"] = {
		"MC", -- [1]
		"黑暗神殿", -- [2]
		"卡拉赞", -- [3]
	},
	["raids_roles"] = {
		"坦克", -- [1]
		"DPS", -- [2]
	},
	["other"] = {
		"R点", -- [1]
		"珠宝加工", -- [2]
	},
}

globalSettingsDefault =
{
	["profiles"] = {
		["Default"] = defaultProfile,
		["演示配置"] = exampleProfie,
	},
}

CharSettingsDefault =
{
	["enabled"] = true,
	["profile"] = "Default"
}

local version = "1.1.0"
local addonStr = "|cff009674ClassicChatFilter|cffffffff"

local LibDropDown = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

local ccf = CreateFrame("Frame", addonName);
local pname, pserver = UnitName("player");

local totalelapsed = 0

ccf:RegisterEvent("VARIABLES_LOADED");
ccf:RegisterEvent("ADDON_LOADED");

ccf:SetScript("OnEvent", function(self, event, arg1) self[event](self, arg1) end);

function SlashHandler(arg)
	if(arg == "help") then
		print(addonStr.." available commands :")
		print("/ccf or /classicchatfilter to open the configuration panel.")
		print("/ccf disable to temporarily disable the addon.")
		print("/ccf enable to re-enable the addon.")
		print("/ccf toggle to toggle between enable and disable (useful for macros).")
	elseif(arg == "enable") then
		CharSettings.enabled = true
		RefreshValues()
		print(addonStr.." has been re-enabled.")
	elseif(arg == "disable") then
		CharSettings.enabled = true
		RefreshValues()
		print(addonStr.." has been temporarily disabled.")
	elseif(arg == "toggle") then
		CharSettings.enabled = not CharSettings.enabled
		RefreshValues()
		print(addonStr.." has been toggled "..((CharSettings.enabled and "ON") or "OFF"))
	else
		InterfaceOptionsFrame_OpenToCategory("ClassicChatFilter")
		InterfaceOptionsFrame_OpenToCategory("ClassicChatFilter")
		InterfaceOptionsFrame_OpenToCategory("ClassicChatFilter")
	end
end

function ccf:VARIABLES_LOADED()
	--RefreshValues()
end

function ccf:ADDON_LOADED(addon)
    if(addon == "ClassicChatFilter") then
		SlashCmdList["CLASSICCHATFILTER"] = SlashHandler;
		SLASH_CLASSICCHATFILTER1 = "/classicchatfilter";
		SLASH_CLASSICCHATFILTER2 = "/ccf";
		InitGlobalSettings()
		InitCharSettings()
		CheckDefault()
		CheckProfile()
		RenderOptions()
		print("|cff009674ClassicChatFilter v"..version.." loaded. |cffffffffType /ccf to configure.")
    end
end

function CheckProfile()
	if(not GlobalSettings["profiles"][CharSettings["profile"]]) then
		CharSettings["profile"] = "Default"
	end
end

function CheckDefault()
	if(not GlobalSettings["profiles"]["Default"]) then
		GlobalSettings["profiles"]["Default"] = DeepCopy(defaultProfile)
	end
end

function InitGlobalSettings()
    if(not GlobalSettings) then
        GlobalSettings = DeepCopy(globalSettingsDefault)
    else
	    -- copy defaults to conf if key not exists
	    for k, v in pairs(globalSettingsDefault) do
	        if(GlobalSettings[k] == nil) then
	            GlobalSettings[k] = DeepCopy(globalSettingsDefault[k]);
	        end
	    end

	    -- remove keys not in defaults anymore
	    for k, v in pairs(GlobalSettings) do
	        if(globalSettingsDefault[k] == nil) then
	            GlobalSettings[k] = nil;
	        end
	    end
    end
end

function InitCharSettings()
    if (not CharSettings) then
        CharSettings = DeepCopy(CharSettingsDefault)
    else
	    -- copy defaults to conf if key not exists
	    for k, v in pairs(CharSettingsDefault) do
	        if (CharSettings[k] == nil) then
	            CharSettings[k] = DeepCopy(CharSettingsDefault[k]);
	        end
	    end

	    -- remove keys not in defaults anymore
	    for k, v in pairs(CharSettings) do
	        if (CharSettingsDefault[k] == nill) then
	            CharSettings[k] = nil;
	        end
	    end
	end
end

StaticPopupDialogs["CCF_PROFILE_RENAME"] = {
	text = "重命名配置文件",
	button1 = OKAY,
	button2 = CANCEL,
	OnShow = function(self)
		self.editBox:SetScript("OnEnterPressed", function()
			RenameProfile(self.editBox:GetText())
			StaticPopup_Hide("CCF_PROFILE_RENAME")
		end)
		self.editBox:SetScript("OnEscapePressed", function()
			StaticPopup_Hide("CCF_PROFILE_RENAME")
		end)
	end,
	OnAccept = function(self)
		RenameProfile(self.editBox:GetText())
		StaticPopup_Hide("CCF_PROFILE_RENAME")
	end,
	hasEditBox = true,
	timeout = 0,
	exclusive = 0,
	showAlert = 1,
	whileDead = 1,
	hideOnEscape = 1
}

StaticPopupDialogs["CCF_PROFILE_COPY"] = {
	text = "复制新的配置文件",
	button1 = OKAY,
	button2 = CANCEL,
	OnShow = function(self)
		self.editBox:SetScript("OnEnterPressed", function()
			CopyProfile(self.editBox:GetText())
			StaticPopup_Hide("CCF_PROFILE_COPY")
		end)
		self.editBox:SetScript("OnEscapePressed", function()
			StaticPopup_Hide("CCF_PROFILE_COPY")
		end)
	end,
	OnAccept = function(self)
		CopyProfile(self.editBox:GetText())
		StaticPopup_Hide("CCF_PROFILE_COPY")
	end,
	hasEditBox = true,
	timeout = 0,
	exclusive = 0,
	showAlert = 1,
	whileDead = 1,
	hideOnEscape = 1
}

StaticPopupDialogs["CCF_PROFILE_ADD"] = {
	text = "新建配置文件",
	button1 = OKAY,
	button2 = CANCEL,
	OnShow = function(self)
		self.editBox:SetScript("OnEnterPressed", function()
			CreateProfile(self.editBox:GetText())
			StaticPopup_Hide("CCF_PROFILE_ADD")
		end)
		self.editBox:SetScript("OnEscapePressed", function()
			StaticPopup_Hide("CCF_PROFILE_ADD")
		end)
	end,
	OnAccept = function(self)
		CreateProfile(self.editBox:GetText())
		StaticPopup_Hide("CCF_PROFILE_ADD")
	end,
	hasEditBox = true,
	timeout = 0,
	exclusive = 0,
	showAlert = 1,
	whileDead = 1,
	hideOnEscape = 1
}

StaticPopupDialogs["CCF_PROFILE_DELETE"] = {
	text = "删除配置文件？",
	button1 = DELETE,
	button2 = CANCEL,
	OnAccept = function(self)
		DeleteCurrentProfile()
		StaticPopup_Hide("CCF_PROFILE_DELETE")
	end,
	timeout = 0,
	exclusive = 0,
	showAlert = 1,
	whileDead = 1,
	hideOnEscape = 1
}

function RenderOptions()
	local leftMargin = 20
	local topMargin = -20

	local options = CreateFrame("FRAME","ccf_options");
	options.name = "ClassicChatFilter";
	InterfaceOptions_AddCategory(options);

	local header = options:CreateFontString(nil, "ARTWORK","GameFontNormalLarge");
	header:SetPoint("TOPLEFT", leftMargin, topMargin);
	header:SetText("ClassicChatFilter");
	local ver=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	ver:SetPoint("BOTTOMLEFT",header,"BOTTOMRIGHT",1,0);
	ver:SetTextColor(0.7,0.7,0.7);
	ver:SetText("v"..version);

	enabledButton = CreateFrame("CheckButton", "ccf_enabledButton", options, "ChatConfigCheckButtonTemplate");
	enabledButton:SetPoint("LEFT", ver, "RIGHT", 5, 0)
	enabledButton.tooltip = "Enable the ClassicChatFilter addon.";
	_G[enabledButton:GetName().."Text"]:SetText("启用");
	enabledButton:SetScript("OnClick", function(self)
		CharSettings.enabled = self:GetChecked();
	end)

	local welcomeText=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	welcomeText:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, -5);
	welcomeText:SetTextColor(0.7,0.7,0.7);
	welcomeText:SetJustifyH("LEFT");
	welcomeText:SetWidth(590);
	welcomeText:SetText("|cffb3b3b3欢迎来到ClassicChatFilter汉化版!\n|cff00f521本插件由小I插件汉化完成!下载请至NGA论坛搜索|r|cff0055FF小I插件|r"
						.."\n\n您可以设置白名单和黑名单关键字, 用|cffec2100英文逗号|r(|cffec2100,|r)分隔."
						.."\n黑名单为屏蔽所有包含关键字符内容，白名单为仅显示关键字符相关内容."
						.."\n\n字符不区分大小写，可以包含空格 (或其他特殊字符)."
						.."\n|cffec2100注意！！所有内容必须优先设置生效的过滤频道否则黑白名单无效.所有白名单输入框内字符均同时生效."
						.."\n\n|cfffff700通过选择配置文件可以获得预设的设置.")

	local profilesDropDownText = options:CreateFontString(nil, "ARTWORK","GameFontNormal");
	profilesDropDownText:SetPoint("TOPLEFT", welcomeText, "BOTTOMLEFT", 0, -20);
	profilesDropDownText:SetText("选择配置文件");
	profilesDropDown = LibDropDown:Create_UIDropDownMenu("ccf_profilesDropdown", options);
	profilesDropDown:SetPoint("LEFT", profilesDropDownText, "RIGHT", 5, -4)
	LibDropDown:UIDropDownMenu_SetWidth(profilesDropDown, 150);
	LibDropDown:UIDropDownMenu_SetButtonWidth(profilesDropDown, 124);
	LibDropDown:UIDropDownMenu_JustifyText(profilesDropDown, "LEFT");
	profilesDropDownText.tooltip = "Select the profile to use on this character."

	renameProfileButton = CreateFrame("Button", "ccf_renameProfileButton", options, "OptionsButtonTemplate");
	renameProfileButton:SetWidth(25)
	renameProfileButton:SetPoint("LEFT", profilesDropDown, "RIGHT", 0, 2);
	renameProfileButton.tooltipText = "Rename this profile.";
	renameProfileButton:SetScript("OnClick", function(self)
		StaticPopup_Show("CCF_PROFILE_RENAME")
	end);
	_G[renameProfileButton:GetName().."Text"]:SetText("R");
	renameProfileButton.alwaysShowTooltip = true
	renameProfileButton.tooltipText = "重命名此配置文件"
	renameProfileButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(renameProfileButton, "ANCHOR_TOPLEFT")
		GameTooltip:ClearLines()
		GameTooltip:AddLine(self.tooltipText)
		GameTooltip:Show()
	end);

	copyProfileButton = CreateFrame("Button", "ccf_copyProfileButton", options, "OptionsButtonTemplate");
	copyProfileButton:SetWidth(25)
	copyProfileButton:SetPoint("LEFT", renameProfileButton, "RIGHT", 2, 0);
	copyProfileButton.tooltipText = "Rename this profile.";
	copyProfileButton:SetScript("OnClick", function(self)
		StaticPopup_Show("CCF_PROFILE_COPY")
	end);
	_G[copyProfileButton:GetName().."Text"]:SetText("C");
	copyProfileButton.alwaysShowTooltip = true
	copyProfileButton.tooltipText = "将此配置文件复制到新配置文件"
	copyProfileButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(copyProfileButton, "ANCHOR_TOPLEFT")
		GameTooltip:ClearLines()
		GameTooltip:AddLine(self.tooltipText)
		GameTooltip:Show()
	end);

	newProfileButton = CreateFrame("Button", "ccf_newProfileButton", options, "OptionsButtonTemplate");
	newProfileButton:SetWidth(25)
	newProfileButton:SetPoint("LEFT", copyProfileButton, "RIGHT", 2, 0);
	newProfileButton:SetScript("OnClick", function(self)
		StaticPopup_Show("CCF_PROFILE_ADD")
	end);
	_G[newProfileButton:GetName().."Text"]:SetText("+");
	newProfileButton.alwaysShowTooltip = true
	newProfileButton.tooltipText = "创建新配置文件"
	newProfileButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(newProfileButton, "ANCHOR_TOPLEFT")
		GameTooltip:ClearLines()
		GameTooltip:AddLine(self.tooltipText)
		GameTooltip:Show()
	end);
	
	deleteProfileButton = CreateFrame("Button", "ccf_deleteProfileButton", options, "OptionsButtonTemplate");
	deleteProfileButton:SetWidth(25)
	deleteProfileButton:SetPoint("LEFT", newProfileButton, "RIGHT", 2, 0);
	deleteProfileButton:SetScript("OnClick", function(self)
		StaticPopup_Show("CCF_PROFILE_DELETE")
	end);
	_G[deleteProfileButton:GetName().."Text"]:SetText("-");
	deleteProfileButton.tooltipText = "删除此配置文件"
	deleteProfileButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(deleteProfileButton, "ANCHOR_TOPLEFT")
		GameTooltip:ClearLines()
		GameTooltip:AddLine(self.tooltipText)
		GameTooltip:Show()
	end);

	pmessagesButton = CreateFrame("CheckButton", "ccf_pmessagesButton", options, "ChatConfigCheckButtonTemplate");
	pmessagesButton:SetPoint("TOPLEFT", profilesDropDownText, "BOTTOMLEFT", 0, -20)
	pmessagesButton.tooltip = "始终显示当前玩家的消息";
	_G[pmessagesButton:GetName().."Text"]:SetText("始终显示自己的信息");
	pmessagesButton:SetScript("OnClick", function(self)
		SetCurrentValue("show_player_messages", self:GetChecked());
	end)

	pmentionsButton = CreateFrame("CheckButton", "ccf_pmentionsButton", options, "ChatConfigCheckButtonTemplate");
	pmentionsButton:SetPoint("TOPLEFT", pmessagesButton, "BOTTOMLEFT", 0, 0)
	pmentionsButton.tooltip = "始终显示包含角色名称的消息";
	_G[pmentionsButton:GetName().."Text"]:SetText("总是显示玩家提到的关键词");
	pmentionsButton:SetScript("OnClick", function(self)
		SetCurrentValue("show_player_mentions", self:GetChecked());
	end)

	local channelsBoxText = options:CreateFontString(nil, "ARTWORK","GameFontWhite");
	channelsBoxText:SetPoint("TOPLEFT", pmentionsButton, "BOTTOMLEFT", 0, -10);
	channelsBoxText:SetText("过滤频道 :");
	channelsCount=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	channelsCount:SetPoint("BOTTOMLEFT", channelsBoxText,"BOTTOMRIGHT", 4, 0);
	channelsCount:SetTextColor(0.7,1,0.7)
	channelsBox = CreateFrame("editbox", "ccf_channelsBox", options, "InputBoxTemplate")
	channelsBox:SetPoint("TOPLEFT", channelsBoxText, "BOTTOMLEFT", 0, 0);
	channelsBox:SetPoint("RIGHT", options, "RIGHT", -10, 0)
	channelsBox:SetHeight(25)
	channelsBox:SetAutoFocus(false)
	channelsBox:ClearFocus()
	channelsBox:SetScript("OnEscapePressed", function(self)
		SetCurrentValue("channels", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	channelsBox:SetScript("OnEnterPressed", function(self)
		SetCurrentValue("channels", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	channelsBox:SetScript("OnEditFocusLost", function(self)
		SetCurrentValue("channels", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	channelsBox:SetScript("OnEditFocusGained", function(self)
		self:SetAutoFocus(true)
	end)
	local channelsHelp=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	channelsHelp:SetPoint("BOTTOMRIGHT", channelsBox,"TOPRIGHT",0,0);
	channelsHelp:SetTextColor(0.7,0.7,0.7);
	channelsHelp:SetText("受过滤器影响的频道");
	local channelsTip=options:CreateFontString(nil,"ARTWORK","GameFontNormal");
	channelsTip:SetPoint("LEFT", channelsBox,"LEFT",0,0);
	channelsTip:SetTextColor(1,1,1);

	local bannedBoxText = options:CreateFontString(nil, "ARTWORK","GameFontWhite");
	bannedBoxText:SetPoint("TOPLEFT", channelsBox, "BOTTOMLEFT", 0, -5);
	bannedBoxText:SetText("黑名单关键词 :");
	bannedCount=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	bannedCount:SetPoint("BOTTOMLEFT", bannedBoxText,"BOTTOMRIGHT", 4, 0);
	bannedCount:SetTextColor(0.7,1,0.7)
	bannedBox = CreateFrame("editbox", "ccf_bannedBox", options, "InputBoxTemplate")
	bannedBox:SetPoint("TOPLEFT", bannedBoxText, "BOTTOMLEFT", 0, 0);
	bannedBox:SetPoint("RIGHT", options, "RIGHT", -10, 0)
	bannedBox:SetHeight(25)
	bannedBox:SetAutoFocus(false)
	bannedBox:ClearFocus()
	bannedBox:SetScript("OnEscapePressed", function(self)
		SetCurrentValue("banned", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	bannedBox:SetScript("OnEnterPressed", function(self)
		SetCurrentValue("banned", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	bannedBox:SetScript("OnEditFocusLost", function(self)
		SetCurrentValue("banned", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	bannedBox:SetScript("OnEditFocusGained", function(self)
		self:SetAutoFocus(true)
	end)
	local bannedHelp=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	bannedHelp:SetPoint("BOTTOMRIGHT", bannedBox,"TOPRIGHT",0,0);
	bannedHelp:SetTextColor(0.7,0.7,0.7);
	bannedHelp:SetText("带有黑名单关键字的信息将被隐藏");
	local bannedTip=options:CreateFontString(nil,"ARTWORK","GameFontNormal");
	bannedTip:SetPoint("LEFT", bannedBox,"LEFT",0,0);
	bannedTip:SetTextColor(1,1,1);

	local dungeonsBoxText = options:CreateFontString(nil, "ARTWORK","GameFontWhite");
	dungeonsBoxText:SetPoint("TOPLEFT", bannedBox, "BOTTOMLEFT", 0, -5);
	dungeonsBoxText:SetText("白名单聊天内容 :");
	dungeonsCount=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	dungeonsCount:SetPoint("BOTTOMLEFT", dungeonsBoxText,"BOTTOMRIGHT", 4, 0);
	dungeonsCount:SetTextColor(0.7,1,0.7)
	dungeonsBox = CreateFrame("editbox", "ccf_dungeonsBox", options, "InputBoxTemplate")
	dungeonsBox:SetPoint("TOPLEFT", dungeonsBoxText, "BOTTOMLEFT", 0, 0);
	dungeonsBox:SetHeight(25)
	dungeonsBox:SetWidth(200)
	dungeonsBox:SetAutoFocus(false)
	dungeonsBox:ClearFocus()
	dungeonsBox:SetScript("OnEscapePressed", function(self)
		SetCurrentValue("dungeons", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	dungeonsBox:SetScript("OnEnterPressed", function(self)
		SetCurrentValue("dungeons", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	dungeonsBox:SetScript("OnEditFocusLost", function(self)
		SetCurrentValue("dungeons", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	dungeonsBox:SetScript("OnEditFocusGained", function(self)
		self:SetAutoFocus(true)
	end)
	local dungeonsHelp=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	dungeonsHelp:SetPoint("BOTTOMRIGHT", dungeonsBox,"TOPRIGHT",0,0);
	dungeonsHelp:SetTextColor(0.7,0.7,0.7);
	dungeonsHelp:SetText("");
	local dungeonsTip=options:CreateFontString(nil,"ARTWORK","GameFontNormal");
	dungeonsTip:SetPoint("LEFT", dungeonsBox,"LEFT",0,0);
	dungeonsTip:SetTextColor(1,1,1);

	local dungeonsAnd=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	dungeonsAnd:SetPoint("LEFT", dungeonsBox,"RIGHT", 2, 0);
	dungeonsAnd:SetTextColor(0.7,0.7,0.7);
	dungeonsAnd:SetText("|cffff9393和|cff939393");

	local dungeonsRolesBoxText = options:CreateFontString(nil, "ARTWORK","GameFontWhite");
	dungeonsRolesBoxText:SetPoint("BOTTOMLEFT", dungeonsBox, "TOPRIGHT", 30, 0);
	dungeonsRolesBoxText:SetText("白名单角色 :");
	dungeonsRolesCount=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	dungeonsRolesCount:SetPoint("BOTTOMLEFT", dungeonsRolesBoxText,"BOTTOMRIGHT", 4, 0);
	dungeonsRolesCount:SetTextColor(0.7,1,0.7)
	dungeonsRolesBox = CreateFrame("editbox", "ccf_dungeonsRolesBox", options, "InputBoxTemplate")
	dungeonsRolesBox:SetPoint("TOPLEFT", dungeonsRolesBoxText, "BOTTOMLEFT", 0, 0);
	--dungeonsRolesBox:SetPoint("RIGHT", options, "RIGHT", -10, 0)
	dungeonsRolesBox:SetHeight(25)
	dungeonsRolesBox:SetWidth(200)
	dungeonsRolesBox:SetAutoFocus(false)
	dungeonsRolesBox:ClearFocus()
	dungeonsRolesBox:SetScript("OnEscapePressed", function(self)
		SetCurrentValue("dungeons_roles", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	dungeonsRolesBox:SetScript("OnEnterPressed", function(self)
		SetCurrentValue("dungeons_roles", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	dungeonsRolesBox:SetScript("OnEditFocusLost", function(self)
		SetCurrentValue("dungeons_roles", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	dungeonsRolesBox:SetScript("OnEditFocusGained", function(self)
		self:SetAutoFocus(true)
	end)
	local dungeonsRolesHelp=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	dungeonsRolesHelp:SetPoint("BOTTOMRIGHT", dungeonsRolesBox,"TOPRIGHT",0,0);
	dungeonsRolesHelp:SetTextColor(0.7,0.7,0.7);
	dungeonsRolesHelp:SetText("");
	local dungeonsRolesTip=options:CreateFontString(nil,"ARTWORK","GameFontNormal");
	dungeonsRolesTip:SetPoint("LEFT", dungeonsRolesBox,"LEFT",0,0);
	dungeonsRolesTip:SetTextColor(1,1,1);

	local dungeonsRolesAnd=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	dungeonsRolesAnd:SetPoint("LEFT", dungeonsRolesBox,"RIGHT", 2, 0);
	dungeonsRolesAnd:SetTextColor(0.7,0.7,0.7);
	dungeonsRolesAnd:SetText("|cffff9393和|cff939393");


	local dungeonsTypesBoxText = options:CreateFontString(nil, "ARTWORK","GameFontWhite");
	dungeonsTypesBoxText:SetPoint("BOTTOMLEFT", dungeonsRolesBox, "TOPRIGHT", 30, 0);
	dungeonsTypesBoxText:SetText("白名单副本 :");
	dungeonsTypesCount=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	dungeonsTypesCount:SetPoint("BOTTOMLEFT", dungeonsTypesBoxText,"BOTTOMRIGHT", 4, 0);
	dungeonsTypesCount:SetTextColor(0.7,1,0.7)
	dungeonsTypesBox = CreateFrame("editbox", "ccf_dungeonsTypeBox", options, "InputBoxTemplate")
	dungeonsTypesBox:SetPoint("TOPLEFT", dungeonsTypesBoxText, "BOTTOMLEFT", 0, 0);
	dungeonsTypesBox:SetHeight(25)
	dungeonsTypesBox:SetPoint("RIGHT", options, "RIGHT", -10, 0)
	dungeonsTypesBox:SetAutoFocus(false)
	dungeonsTypesBox:ClearFocus()
	dungeonsTypesBox:SetScript("OnEscapePressed", function(self)
		SetCurrentValue("dungeons_types", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	dungeonsTypesBox:SetScript("OnEnterPressed", function(self)
		SetCurrentValue("dungeons_types", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	dungeonsTypesBox:SetScript("OnEditFocusLost", function(self)
		SetCurrentValue("dungeons_types", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	dungeonsTypesBox:SetScript("OnEditFocusGained", function(self)
		self:SetAutoFocus(true)
	end)
	local dungeonsTypesHelp=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	dungeonsTypesHelp:SetPoint("BOTTOMRIGHT", dungeonsTypesBox,"TOPRIGHT",0,0);
	dungeonsTypesHelp:SetTextColor(0.7,0.7,0.7);
	dungeonsTypesHelp:SetText("");
	local dungeonsTypesTip=options:CreateFontString(nil,"ARTWORK","GameFontNormal");
	dungeonsTypesTip:SetPoint("LEFT", dungeonsTypesBox,"LEFT",0,0);
	dungeonsTypesTip:SetTextColor(1,1,1);

	local raidsBoxText = options:CreateFontString(nil, "ARTWORK","GameFontWhite");
	raidsBoxText:SetPoint("TOPLEFT", dungeonsBox, "BOTTOMLEFT", 0, -5);
	raidsBoxText:SetText("白名单团队副本 :");
	raidsCount=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	raidsCount:SetPoint("BOTTOMLEFT", raidsBoxText,"BOTTOMRIGHT", 4, 0);
	raidsCount:SetTextColor(0.7,1,0.7)
	raidsBox = CreateFrame("editbox", "ccf_raidsBox", options, "InputBoxTemplate")
	raidsBox:SetPoint("TOPLEFT", raidsBoxText, "BOTTOMLEFT", 0, 0);
	raidsBox:SetHeight(25)
	raidsBox:SetWidth(250)
	raidsBox:SetAutoFocus(false)
	raidsBox:ClearFocus()
	raidsBox:SetScript("OnEscapePressed", function(self)
		SetCurrentValue("raids", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	raidsBox:SetScript("OnEnterPressed", function(self)
		SetCurrentValue("raids", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	raidsBox:SetScript("OnEditFocusLost", function(self)
		SetCurrentValue("raids", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	raidsBox:SetScript("OnEditFocusGained", function(self)
		self:SetAutoFocus(true)
	end)
	local raidsHelp=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	raidsHelp:SetPoint("BOTTOMRIGHT", raidsBox,"TOPRIGHT",0,0);
	raidsHelp:SetTextColor(0.7,0.7,0.7);
	raidsHelp:SetText("");
	local raidsTip=options:CreateFontString(nil,"ARTWORK","GameFontNormal");
	raidsTip:SetPoint("LEFT", raidsBox,"LEFT",0,0);
	raidsTip:SetTextColor(1,1,1);

	local raidsAnd=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	raidsAnd:SetPoint("LEFT", raidsBox,"RIGHT", 2, 0);
	raidsAnd:SetTextColor(0.7,0.7,0.7);
	raidsAnd:SetText("|cffff9393和|cff939393");

	local raidsRolesBoxText = options:CreateFontString(nil, "ARTWORK","GameFontWhite");
	raidsRolesBoxText:SetPoint("BOTTOMLEFT", raidsBox, "TOPRIGHT", 30, 0);
	raidsRolesBoxText:SetText("白名单副本职业 :");
	raidsRolesCount=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	raidsRolesCount:SetPoint("BOTTOMLEFT", raidsRolesBoxText,"BOTTOMRIGHT", 4, 0);
	raidsRolesCount:SetTextColor(0.7,1,0.7)
	raidsRolesBox = CreateFrame("editbox", "ccf_raidsRolesBox", options, "InputBoxTemplate")
	raidsRolesBox:SetPoint("TOPLEFT", raidsRolesBoxText, "BOTTOMLEFT", 0, 0);
	raidsRolesBox:SetPoint("RIGHT", options, "RIGHT", -10, 0)
	raidsRolesBox:SetHeight(25)
	raidsRolesBox:SetAutoFocus(false)
	raidsRolesBox:ClearFocus()
	raidsRolesBox:SetScript("OnEscapePressed", function(self)
		SetCurrentValue("raids_roles", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	raidsRolesBox:SetScript("OnEnterPressed", function(self)
		SetCurrentValue("raids_roles", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	raidsRolesBox:SetScript("OnEditFocusLost", function(self)
		SetCurrentValue("raids_roles", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	raidsRolesBox:SetScript("OnEditFocusGained", function(self)
		self:SetAutoFocus(true)
	end)
	local raidsRolesHelp=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	raidsRolesHelp:SetPoint("BOTTOMRIGHT", raidsRolesBox,"TOPRIGHT",0,0);
	raidsRolesHelp:SetTextColor(0.7,0.7,0.7);
	raidsRolesHelp:SetText("");
	local raidsRolesTip=options:CreateFontString(nil,"ARTWORK","GameFontNormal");
	raidsRolesTip:SetPoint("LEFT", raidsRolesBox,"LEFT",0,0);
	raidsRolesTip:SetTextColor(1,1,1);

	local otherBoxText = options:CreateFontString(nil, "ARTWORK","GameFontWhite");
	otherBoxText:SetPoint("TOPLEFT", raidsBox, "BOTTOMLEFT", 0, -5);
	otherBoxText:SetText("白名单其他关键字 :");
	otherCount=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	otherCount:SetPoint("BOTTOMLEFT", otherBoxText,"BOTTOMRIGHT", 4, 0);
	otherCount:SetTextColor(0.7,1,0.7)
	otherBox = CreateFrame("editbox", "ccf_otherBox", options, "InputBoxTemplate")
	otherBox:SetPoint("TOPLEFT", otherBoxText, "BOTTOMLEFT", 0, 0);
	otherBox:SetPoint("RIGHT", options, "RIGHT", -10, 0)
	otherBox:SetHeight(25)
	otherBox:SetAutoFocus(false)
	otherBox:ClearFocus()
	otherBox:SetScript("OnEscapePressed", function(self)
		SetCurrentValue("other", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	otherBox:SetScript("OnEnterPressed", function(self)
		SetCurrentValue("other", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	otherBox:SetScript("OnEditFocusLost", function(self)
		SetCurrentValue("other", StringToTable(self:GetText()))
		self:SetAutoFocus(false)
		self:ClearFocus()
	end)
	otherBox:SetScript("OnEditFocusGained", function(self)
		self:SetAutoFocus(true)
	end)
	local otherHelp=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	otherHelp:SetPoint("BOTTOMRIGHT", otherBox,"TOPRIGHT",0,0);
	otherHelp:SetTextColor(0.7,0.7,0.7);
	otherHelp:SetText("仅显示带有白名单关键字的消息");
	local otherTip=options:CreateFontString(nil,"ARTWORK","GameFontNormal");
	otherTip:SetPoint("LEFT", otherBox,"LEFT",0,0);
	otherTip:SetTextColor(1,1,1);

	local bottomText=options:CreateFontString(nil,"ARTWORK","GameFontNormalSmall");
	bottomText:SetPoint("BOTTOMLEFT", options,"BOTTOMLEFT", leftMargin , 20);
	bottomText:SetTextColor(0.7,0.7,0.7);
	bottomText:SetJustifyH("LEFT");
	bottomText:SetWidth(590);
	bottomText:SetText("ClassicChatFilter未来将更新以支持高级自定义筛选器.")
	
	options:SetScript("OnShow", function(self)
		RefreshValues()
	end);

	channelsBox:SetScript("OnTabPressed", function(self)
		self:SetAutoFocus(false)
		self:ClearFocus()
		if(IsShiftKeyDown()) then
			otherBox:SetAutoFocus(true)
		else
			bannedBox:SetAutoFocus(true)
		end
	end)
	channelsBox:SetScript("OnTextChanged", function(self)
		channelsCount:SetText(#StringToTable(self:GetText()))
		if(self:GetText() == "") then
			channelsTip:SetText("无启用频道")
		else
			channelsTip:SetText("")
		end
	end)
	bannedBox:SetScript("OnTabPressed", function(self)
		self:SetAutoFocus(false)
		self:ClearFocus()
		if(IsShiftKeyDown()) then
			channelsBox:SetAutoFocus(true)
		else
			dungeonsBox:SetAutoFocus(true)
		end
	end)
	bannedBox:SetScript("OnTextChanged", function(self)
		bannedCount:SetText(#StringToTable(self:GetText()))
		if(self:GetText() == "") then
			bannedTip:SetText("无黑名单")
		else
			bannedTip:SetText("")
		end
	end)
	dungeonsBox:SetScript("OnTabPressed", function(self)
		self:SetAutoFocus(false)
		self:ClearFocus()
		if(IsShiftKeyDown()) then
			bannedBox:SetAutoFocus(true)
		else
			dungeonsRolesBox:SetAutoFocus(true)
		end
	end)
	dungeonsBox:SetScript("OnTextChanged", function(self)
		dungeonsCount:SetText(#StringToTable(self:GetText()))
		if(self:GetText() == "" and dungeonsRolesBox:GetText() == "") then
			dungeonsTip:SetText("空")
			dungeonsRolesTip:SetText("空")
			dungeonsTypesTip:SetText("空")
		elseif(self:GetText() == "") then
			dungeonsTip:SetText("any")
		else
			dungeonsTip:SetText("")
			if(dungeonsRolesBox:GetText() == "") then
				dungeonsRolesTip:SetText("any")
			end
			if(dungeonsTypesBox:GetText() == "") then
				dungeonsTypesTip:SetText("any")
			end
		end
	end)
	dungeonsRolesBox:SetScript("OnTabPressed", function(self)
		self:SetAutoFocus(false)
		self:ClearFocus()
		if(IsShiftKeyDown()) then
			dungeonsBox:SetAutoFocus(true)
		else
			dungeonsTypesBox:SetAutoFocus(true)
		end
	end)
	dungeonsRolesBox:SetScript("OnTextChanged", function(self)
		dungeonsRolesCount:SetText(#StringToTable(self:GetText()))
		if(self:GetText() == "" and dungeonsBox:GetText() == "") then
			dungeonsTip:SetText("disabled")
			dungeonsRolesTip:SetText("disabled")
			dungeonsTypesTip:SetText("disabled")
		elseif(self:GetText() == "") then
			dungeonsRolesTip:SetText("any")
		else
			dungeonsRolesTip:SetText("")
			if(dungeonsBox:GetText() == "") then
				dungeonsTip:SetText("any")
			end
			if(dungeonsTypesBox:GetText() == "") then
				dungeonsTypesTip:SetText("any")
			end
		end
	end)
	dungeonsTypesBox:SetScript("OnTabPressed", function(self)
		self:SetAutoFocus(false)
		self:ClearFocus()
		if(IsShiftKeyDown()) then
			dungeonsRolesBox:SetAutoFocus(true)
		else
			raidsBox:SetAutoFocus(true)
		end
	end)
	dungeonsTypesBox:SetScript("OnTextChanged", function(self)
		dungeonsTypesCount:SetText(#StringToTable(self:GetText()))
		if(self:GetText() == "" and dungeonsBox:GetText() == "") then
			dungeonsTip:SetText("disabled")
			dungeonsRolesTip:SetText("disabled")
			dungeonsTypesTip:SetText("disabled")
		elseif(self:GetText() == "") then
			dungeonsTypesTip:SetText("any")
		else
			dungeonsTypesTip:SetText("")
			if(dungeonsBox:GetText() == "") then
				dungeonsTip:SetText("any")
			end
			if(dungeonsRolesBox:GetText() == "") then
				dungeonsRolesTip:SetText("any")
			end
		end
	end)
	raidsBox:SetScript("OnTabPressed", function(self)
		self:SetAutoFocus(false)
		self:ClearFocus()
		if(IsShiftKeyDown()) then
			dungeonsRolesBox:SetAutoFocus(true)
		else
			raidsRolesBox:SetAutoFocus(true)
		end
	end)
	raidsBox:SetScript("OnTextChanged", function(self)
		raidsCount:SetText(#StringToTable(self:GetText()))
		if(self:GetText() == "" and raidsRolesBox:GetText() == "") then
			raidsTip:SetText("空")
			raidsRolesTip:SetText("空")
		elseif(self:GetText() == "") then
			raidsTip:SetText("any")
		else
			raidsTip:SetText("")
			if(raidsRolesBox:GetText() == "") then
				raidsRolesTip:SetText("any")
			end
		end
	end)
	raidsRolesBox:SetScript("OnTabPressed", function(self)
		self:SetAutoFocus(false)
		self:ClearFocus()
		if(IsShiftKeyDown()) then
			raidsBox:SetAutoFocus(true)
		else
			otherBox:SetAutoFocus(true)
		end
	end)
	raidsRolesBox:SetScript("OnTextChanged", function(self)
		raidsRolesCount:SetText(#StringToTable(self:GetText()))
		if(self:GetText() == "" and raidsBox:GetText() == "") then
			raidsTip:SetText("disabled")
			raidsRolesTip:SetText("disabled")
		elseif(self:GetText() == "") then
			raidsRolesTip:SetText("any")
		else
			raidsRolesTip:SetText("")
			if(raidsBox:GetText() == "") then
				raidsTip:SetText("any")
			end
		end
	end)
	otherBox:SetScript("OnTabPressed", function(self)
		self:SetAutoFocus(false)
		self:ClearFocus()
		if(IsShiftKeyDown()) then
			raidsRolesBox:SetAutoFocus(true)
		else
			channelsBox:SetAutoFocus(true)
		end
	end)
	otherBox:SetScript("OnTextChanged", function(self)
		otherCount:SetText(#StringToTable(self:GetText()))
		if(self:GetText() == "") then
			otherTip:SetText("空")
		else
			otherTip:SetText("")
		end
	end)

	SetProfile(CharSettings["profile"])
	options:Hide()
end

function RenameProfile(val)
	if(#val > 0 and not GlobalSettings["profiles"][val]) then
		GlobalSettings["profiles"][val] = DeepCopy(GlobalSettings["profiles"][CharSettings["profile"]])
		GlobalSettings["profiles"][CharSettings["profile"]] = nil
		SetProfile(val)
		RefreshValues()
	else
		print(addonStr.." : couldn't rename profile")
	end
end

function CopyProfile(val)
	if(#val > 0 and not GlobalSettings["profiles"][val]) then
		GlobalSettings["profiles"][val] = DeepCopy(GlobalSettings["profiles"][CharSettings["profile"]])
		SetProfile(val)
		RefreshValues()
	else
		print(addonStr.." : couldn't copy profile")
	end
end

function CreateProfile(val)
	if(#val > 0 and not GlobalSettings["profiles"][val]) then
		GlobalSettings["profiles"][val] = DeepCopy(defaultProfile)
		SetProfile(val)
		RefreshValues()
	else
		print(addonStr.." : couldn't create profile")
	end
end

function DeleteCurrentProfile()
	GlobalSettings["profiles"][CharSettings["profile"]] = nil
	SetProfile("Default")
	RefreshValues()
end

function SetProfile(val,noinit)
	if(not noinit) then 
		LibDropDown:UIDropDownMenu_Initialize(profilesDropDown, profilesDropdownInit);
	end
	CharSettings["profile"] = val;
	LibDropDown:UIDropDownMenu_SetSelectedValue(profilesDropDown, val);
	if(val == "Default") then
		renameProfileButton:Disable()
		deleteProfileButton:Disable()
	else
		renameProfileButton:Enable()
		deleteProfileButton:Enable()
	end
end

function RefreshValues()
	enabledButton:SetChecked(CharSettings.enabled);
	pmessagesButton:SetChecked(GetCurrentValue("show_player_messages"));
	pmentionsButton:SetChecked(GetCurrentValue("show_player_mentions"));
	channelsBox:SetText(TableToString(GetCurrentValue("channels")));
	bannedBox:SetText(TableToString(GetCurrentValue("banned")));
	dungeonsBox:SetText(TableToString(GetCurrentValue("dungeons")));
	dungeonsRolesBox:SetText(TableToString(GetCurrentValue("dungeons_roles")));
	dungeonsTypesBox:SetText(TableToString(GetCurrentValue("dungeons_types")));
	raidsBox:SetText(TableToString(GetCurrentValue("raids")));
	raidsRolesBox:SetText(TableToString(GetCurrentValue("raids_roles")));
	otherBox:SetText(TableToString(GetCurrentValue("other")));
end

function profilesDropdownInit(self, level)
	for key, value in pairs(GlobalSettings["profiles"]) do
		local info;
		info = LibDropDown:UIDropDownMenu_CreateInfo();
		info.text = key;
		info.value = key;
		info.arg1 = key;
		info.func = function(self, arg1, arg2, checked) 
			SetProfile(self.value, true)
			RefreshValues()
		end
		LibDropDown:UIDropDownMenu_AddButton(info, level);
	end
end

function Filter(self,event,msg,author,arg1,arg2,arg3,arg4,arg5,arg6,channel,...)
	if(CharSettings["enabled"]) then
		if(CheckChannel(channel)) then
			if(CheckPlayerAuthor(author) or CheckPlayerMention(msg)) then
				return false
			elseif(CheckBanned(msg)) then
				return true
			elseif(AtLeastOneFilter() and (CheckDungeons(msg) or CheckRaids(msg) or CheckOther(msg))) then
				return false
			else
				return true
			end
		end
	end
	return false
end

function GetCurrentValue(key)
	local val = GlobalSettings["profiles"][CharSettings["profile"]][key]
	return val == nil and {} or val
end

function SetCurrentValue(key,val)
	GlobalSettings["profiles"][CharSettings["profile"]][key] = val
end

function HasValues(key)
	return #GetCurrentValue(key) ~= 0
end

function CheckPlayerAuthor(author)
	return GetCurrentValue("show_player_messages") and CheckAuthor(author,pname)
end

function CheckPlayerMention(msg)
	return GetCurrentValue("show_player_mentions") and MatchStr(msg, pname)
end

function CheckAuthor(author,check)
	ind = string.find(author, "-")
	if(ind) then
		author = string.sub(author, 1, ind-1)
	end
	return author == check
end

function AtLeastOneFilter()
	return HasValues("raids") or HasValues("raids_roles") or HasValues("dungeons") or HasValues("dungeons_roles") or HasValues("dungeons_types") or HasValues("other")
end

function CheckChannel(channel)
	return HasValues("channels") and MatchAny(channel, GetCurrentValue("channels"))
end

function CheckBanned(msg)
	return HasValues("banned") and MatchAny(msg, GetCurrentValue("banned"))
end

function CheckDungeons(msg)
	return (HasValues("dungeons") or HasValues("dungeons_roles") or HasValues("dungeons_types")) and
			(
				(not HasValues("dungeons") or MatchAny(msg, GetCurrentValue("dungeons")))
				and (not HasValues("dungeons_roles") or MatchAny(msg, GetCurrentValue("dungeons_roles")))
				and (not HasValues("dungeons_types") or MatchAny(msg, GetCurrentValue("dungeons_types")))
			)
end

function CheckRaids(msg)
	return (HasValues("raids_roles") or HasValues("raids")) and
			((not HasValues("raids_roles") or MatchAny(msg, GetCurrentValue("raids_roles")))
			and (not HasValues("raids") or MatchAny(msg, GetCurrentValue("raids"))))
end

function CheckOther(msg)
	return HasValues("other") and MatchAny(msg, GetCurrentValue("other"))
end

function MatchAny(source,testlist)
	for _,test in pairs(testlist) do
		if(MatchStr(source,test)) then
			return true
		end
	end
	return false
end

function MatchStr(source,test)
	return string.lower(source):find(string.lower(test))
end

function DeepCopy(orig)
	local copy
    if(type(orig) == "table") then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[DeepCopy(orig_key)] = DeepCopy(orig_value)
        end
        setmetatable(copy, DeepCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function TableToString(val,sep)
	return table.concat(val, sep or ",")
end

function StringToTable(val,sep)
   local sep, fields = sep or ",", {}
   local pattern = string.format("([^%s]+)", sep)
   string.gsub(val, pattern, function(c) fields[#fields+1] = c end)
   return fields
end

for type in next,getmetatable(ChatTypeInfo).__index do
	ChatFrame_AddMessageEventFilter("CHAT_MSG_"..type,Filter);
end
--[[--
	by ALA @ 163UI【ALA@网易有爱】
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local core = Mixin(NS.WA, {
	LOCALE = GetLocale();
	LOCALE_CLASS = Mixin({  }, LOCALIZED_CLASS_NAMES_FEMALE, LOCALIZED_CLASS_NAMES_MALE);
	LOCALE_COLORED_CLASS = {  };
	initialized = false,
	playerClass = select(2, UnitClass('player')),
	playerGUID = UnitGUID('player'),
	playerName = UnitName('player'),
	realm = GetRealmName(),
	playerFullName = UnitName('player') .. "-" .. GetRealmName();
});
for k, v in next, core.LOCALE_CLASS do
	local color = RAID_CLASS_COLORS[k];
	if color then
		core.LOCALE_COLORED_CLASS[k] = format("\124cff%.2x%.2x%.2x%s\124r", color.r * 255, color.g * 255, color.b * 255, v);
	end
end
_G.__ala_meta__.wa = core;

local _G = _G;
do
	NS.__fenv = NS.__fenv or {  };
	setfenv(1,
		setmetatable(NS.__fenv,
			{
				__index = _G,
				__newindex = function(t, key, value)
					rawset(t, key, value);
					print("ala assign global", key, value);
					return value;
				end,
			}
		)
	);
end

----------------------------------------------------------------------------------------------------upvalue
	----------------------------------------------------------------------------------------------------LUA
	local math, table, string, bit = math, table, string, bit;
	local type, tonumber, tostring = type, tonumber, tostring;
	local getfenv, setfenv, pcall, xpcall, assert, error, loadstring = getfenv, setfenv, pcall, xpcall, assert, error, loadstring;
	local abs, ceil, floor, max, min, random, sqrt = abs, ceil, floor, max, min, random, sqrt;
	local format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat =
			format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat;
	local getmetatable, setmetatable, rawget, rawset = getmetatable, setmetatable, rawget, rawset;
	local next, ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack = next, ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack;
	local tConcat = table.concat;
	local select = select;
	local date, time = date, time;
	----------------------------------------------------------------------------------------------------GAME
	local print = print;
	local GetTime = GetTime;
	local CreateFrame = CreateFrame;
	local GetCursorPosition = GetCursorPosition;
	local InCombatLockdown = InCombatLockdown;

	local UnitName = UnitName;
	local UnitClass = UnitClass;
	local UnitLevel = UnitLevel;
	local GetRealmName = GetRealmName;
	local GameTooltip = GameTooltip;
	--------------------------------------------------
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------local
	local _ = nil;
	local NAME = "ala_meta";
	local ADDON_PREFIX = "ala_meta";
	local ARTWORK_PATH = ARTWORK_PATH or "";
	local ARTWORK_WA_PATH = ARTWORK_WA_PATH or "";
	--------------------------------------------------
	--------------------------------------------------
	local ui_style =
	{
		mainFrameBackdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 2,
			edgeSize = 2,
			insets = { left = 0, right = 0, top = 0, bottom = 0, }
		},
		mainFrameBackdropColor = { 0.25, 0.25, 0.25, 1.0, },
		mainFrameBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, },

		-- scrollButtonBackdrop = {
		-- 	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		-- 	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		-- 	tile = true,
		-- 	tileSize = 2,
		-- 	edgeSize = 2,
		-- 	insets = { left = 0, right = 0, top = 0, bottom = 0 }
		-- };
		-- scrollButtonBackdropColor = { 0.25, 0.25, 0.25, 0.75, };
		-- scrollButtonBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, };

		frameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		frameFontSize = 13,
		frameFontOutline = "NORMAL",

		scrollToBorderX = 6,
		scrollToBorderYHeader = 32,
		scrollToBorderYFooter = 4,

		cellSizeX = 360,
		cellSizeY = 180,

		numSize = 3,
	};
	ui_style.mainFrameSizeX = ui_style.cellSizeX + ui_style.scrollToBorderX * 2;
	ui_style.mainFrameSizeY = ui_style.cellSizeY * ui_style.numSize + ui_style.scrollToBorderYHeader + ui_style.scrollToBorderYFooter;
	local TEXTURE_SET =
	{
	};
	--------------------------------------------------
	local function _log_(...)
		-- print(date('\124cff00ff00%H:%M:%S\124r'), ...);
	end
	local function _error_(...)
		print(date('\124cffff0000%H:%M:%S\124r'), ...);
	end
	local function _noop_()
	end
	--------------------------------------------------
	--------------------------------------------------
	local DATA = core.DATA;
	local L = core.L;
	--------------------------------------------------
	local MAX_CONFLICTED_INFO_LINES = 16;
	local BIG_NUMBER = 4294967295;
	--------------------------------------------------
----------------------------------------------------------------------------------------------------
local config = 
{
	minimap = false,
};

local extern = { export = {  }, import = {  }, addon = {  }, };

local _EventVehicle = CreateFrame("Frame", nil, UIParent);
_EventVehicle:SetScript("OnEvent", function(self, event, ...)
	return core[event](...);
end);


do	--	WeakAuras
	--	WeakAurasSaved.displays
	function core.checkUID(uid, detailed)
		for n, v in next, WeakAurasSaved.displays do
			if v.uid == uid then
				if detailed then
					local p = v;
					local ret = n;
					while p do
						if p.parent then
							ret = ret .. " \124cff00ff00>>\124r " .. p.parent;
							p = WeakAurasSaved.displays[p.parent];
						else
							break;
						end
					end
					return true, ret;
				else
					return true;
				end
			end
		end
		return false;
	end
	do
		local backup = nil;		--	WeakAuras.ShowOptions
		local backup2 = nil;	--	WeakAuras.CloseImportExport
		local function ticker()
			if WeakAuras.IsImporting() then
				C_Timer.After(0.2, ticker);
			else
				WeakAuras.ShowOptions = backup;
				backup = nil;
				WeakAuras.CloseImportExport = backup2;
				backup2 = nil;
			end
		end
		function core.ticker_restore_WeakAuras_ShowOptions()
			if type(backup) == 'function' then
				C_Timer.After(0.2, ticker);
			end
		end
		function core.backup_WeakAuras_ShowOptions()
			if WeakAuras.ShowOptions then
				backup = backup or WeakAuras.ShowOptions;
				WeakAuras.ShowOptions = _noop_;
				backup2 = backup2 or WeakAuras.CloseImportExport;
				WeakAuras.CloseImportExport = _noop_;
				core.ticker_restore_WeakAuras_ShowOptions();
			end
		end
	end
	function core.import(code, hide_opt)
		if WeakAurasOptions == nil or not WeakAurasOptions:IsShown() then
			WeakAuras.OpenOptions();
		end
		if WeakAuras.Import(code) ~= nil then
			if hide_opt then
				-- if not WeakAurasOptions then
				-- 	if WeakAuras.LoadOptions() then
				-- 		WeakAuras.ShowOptions();
				-- 		WeakAuras.HideOptions();
				-- 	else
				-- 		_error_(L["WeakAuraOptions_LOAD_FAILED"]);
				-- 		return;
				-- 	end
				-- end
				core.backup_WeakAuras_ShowOptions();
			end
			WeakAurasTooltipImportButton:Click();
		end
	end
end


do	--	UI
	local function import(_, code, need_show_opt)
		return core.import(code, not need_show_opt);
	end
	local drop_menu_nonconflicted = {
		handler = _noop_,
		elements = {
			{
				handler = import,
				para = {  },
				text = L["DROP_IMPORT"],
			},
		},
	};
	local drop_menu_conflicted = {
		handler = _noop_,
		elements = {
			{
				handler = import,
				para = {  },
				text = L["DROP_FORCE_IMPORT"],
			},
		},
	};
	local function search_update(mainFrame, text)
		local list = mainFrame.list;
		wipe(list);
		local min_pos, max_pos = BIG_NUMBER, -BIG_NUMBER;
		for index = 1, #DATA do
			local pos = DATA[index].pos;
			min_pos = min(min_pos, pos);
			max_pos = max(max_pos, pos);
		end
		for pos = max_pos, min_pos, -1 do
			if text == nil or text == "" then
				for index = 1, #DATA do
					local data = DATA[index];
					if not data.hide and data.pos == pos then
						tinsert(list, index);
					end
				end
			else
				text = strlower(text);
				for index = 1, #DATA do
					local data = DATA[index];
					if not data.hide and data.pos == pos then
						if (data.id and strfind(strlower(data.id), text)) or (data.author and strfind(strlower(data.author), text)) then
							tinsert(list, index);
						elseif data.desc then
							for _, d in next, data.desc do
								if strfind(strlower(d), text) then
									tinsert(list, index);
									break;
								end
							end
						end
					end
				end
			end
		end
		mainFrame.scroll:SetNumValue(#list);
	end
	local function OnDragStart(self)
		if self:IsMovable() then
			self:StartMoving();
		end
	end
	local function OnDragStop(self)
		self:StopMovingOrSizing();
	end
	local function Button_OnEnter(self)
		local index = self:GetDataIndex();
		local data = DATA[self.list[index]];
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:AddLine(data.id, 1.0, 1.0, 1.0);
		if data.author then
			GameTooltip:AddLine(L["Author: "] .. data.author, 1.0, 1.0, 1.0);
		end
		if type(data.class) == 'string' then
			local x1, x2, y1, y2 = unpack(CLASS_ICON_TCOORDS[strupper(data.class)]);
			GameTooltip:AddLine(format("|TInterface\\TargetingFrame\\UI-Classes-Circles:14:14:0:0:256:256:%d:%d:%d:%d|t", x1 * 256, x2 * 256, y1 * 256, y2 * 256) .. core.LOCALE_COLORED_CLASS[data.class], 1.0, 1.0, 1.0);
		elseif type(data.class) == 'table' then
			local line = "";
			for _, class in next, data.class do
				local x1, x2, y1, y2 = unpack(CLASS_ICON_TCOORDS[strupper(class)]);
				line = line .. format("|TInterface\\TargetingFrame\\UI-Classes-Circles:14:14:0:0:256:256:%d:%d:%d:%d|t", x1 * 256, x2 * 256, y1 * 256, y2 * 256) .. core.LOCALE_COLORED_CLASS[class];
			end
			GameTooltip:AddLine(line, 1.0, 1.0, 1.0);
		end
		if data.desc then
			if data.desc[core.LOCALE] then
				GameTooltip:AddLine(data.desc[core.LOCALE], 1.0, 1.0, 1.0);
			elseif data.desc.default then
				GameTooltip:AddLine(data.desc.default, 1.0, 1.0, 1.0);
			end
		end
		local num_conflicted = 0;
		local all_exist = true;
		for i, v in next, data.uid do
			local conflicted, err = core.checkUID(v[1], true);
			if conflicted then
				if i == 1 then
					GameTooltip:AddDoubleLine(v[2] or 'uid', v[1], 1.0, 0.0, 0.0, 1.0, 1.0, 1.0);
				else
					if num_conflicted <= MAX_CONFLICTED_INFO_LINES then
						GameTooltip:AddDoubleLine(v[2] or '', err, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0);
					end
				end
				num_conflicted = num_conflicted + 1;
			else
				if i == 1 then
					GameTooltip:AddDoubleLine(v[2] or 'uid', v[1], 0.0, 1.0, 0.0, 1.0, 1.0, 1.0);
				end
				all_exist = false;
			end
		end
		if num_conflicted > 0 then
			if num_conflicted > MAX_CONFLICTED_INFO_LINES then
				GameTooltip:AddLine("\124cffff0000...\124r");
			end
			GameTooltip:AddLine(L["CONFLICTED: "] .. num_conflicted);
		end
		if all_exist then
			GameTooltip:AddLine(L["ALL_EXIST"]);
		end
		GameTooltip:Show();
	end
	local function Button_OnLeave(self)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide();
		end
	end
	local function Button_OnClick(self)
		local index = self:GetDataIndex();
		local data = DATA[self.list[index]];
		local conflicted = false;
		for i, v in next, data.uid do
			if core.checkUID(v[1], false) then
				conflicted = true;
				break;
			end
		end
		if conflicted then
			drop_menu_conflicted.elements[1].para[1] = data.code;
			drop_menu_conflicted.elements[1].para[2] = data.need_show_opt;
			ALADROP(self, "BOTTOMLEFT", drop_menu_conflicted);
		else
			drop_menu_nonconflicted.elements[1].para[1] = data.code;
			drop_menu_nonconflicted.elements[1].para[2] = data.need_show_opt;
			ALADROP(self, "BOTTOMLEFT", drop_menu_nonconflicted);
		end
	end
	local function funcToCreateButton(parent, index, buttonHeight)
		local button = CreateFrame("Button", nil, parent);
		button:SetHeight(buttonHeight);
		-- button:SetBackdrop(ui_style.scrollButtonBackdrop);
		-- button:SetBackdropColor(unpack(ui_style.scrollButtonBackdropColor));
		-- button:SetBackdropBorderColor(unpack(ui_style.scrollButtonBackdropBorderColor));
		button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
		button:EnableMouse(true);
		button:RegisterForClicks("AnyUp");
		button:Show();

		local pic = button:CreateTexture(nil, "BACKGROUND");
		pic:SetTexture("Interface\\Icons\\inv_misc_questionmark");
		pic:SetPoint("CENTER");
		pic:SetAllPoints();
		button.pic = pic;

		local title = button:CreateFontString(nil, "OVERLAY");
		title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
		title:SetPoint("TOP", button, "TOP", 0, -2);
		button.title = title;

		local title_bg = button:CreateTexture(nil, "ARTWORK");
		title_bg:SetPoint("TOPLEFT", title);
		title_bg:SetPoint("BOTTOMRIGHT", title);
		-- title_bg:SetTexture(ui_style.mainFrameBackdrop.bgFile);
		-- title_bg:SetVertexColor(unpack(ui_style.mainFrameBackdropColor));
		title_bg:SetColorTexture(0.05, 0.05, 0.05, 1.0);
		button.title_bg = title_bg;

		button:SetScript("OnEnter", Button_OnEnter);
		button:SetScript("OnLeave", Button_OnLeave);
		button:SetScript("OnClick", Button_OnClick);

		button.list = parent:GetParent():GetParent().list;
		-- button.searchEdit = parent:GetParent():GetParent().searchEdit;

		return button;
	end
	local function functToSetButton(button, data_index)
		local list = button.list;
		if data_index <= #list then
			local data = DATA[list[data_index]];
			if data.pic then
				if data.pic == true then
					button.pic:SetTexture(ARTWORK_WA_PATH .. data.id);
				else
					button.pic:SetTexture(data.pic);
				end
			else
				button.pic:SetTexture(ARTWORK_WA_PATH .. "___NO_PREVIEW");
			end
			button.title:SetText(data.id);
			button:Show();
			if GetMouseFocus() == button then
				Button_OnEnter(button);
			end
		else
			button:Hide();
		end
	end
	function core.InitUI()
		if core.ui then
			return;
		end
		local mainFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate");
		mainFrame:SetPoint("CENTER");
		mainFrame:SetSize(ui_style.mainFrameSizeX, ui_style.mainFrameSizeY);
		mainFrame:SetFrameStrata("HIGH");
		mainFrame:SetBackdrop(ui_style.mainFrameBackdrop);
		mainFrame:SetBackdropColor(ui_style.mainFrameBackdropColor[1], ui_style.mainFrameBackdropColor[2], ui_style.mainFrameBackdropColor[3], ui_style.mainFrameBackdropColor[4]);
		mainFrame:SetBackdropBorderColor(ui_style.mainFrameBackdropBorderColor[1], ui_style.mainFrameBackdropBorderColor[2], ui_style.mainFrameBackdropBorderColor[3], ui_style.mainFrameBackdropBorderColor[4]);
		mainFrame:EnableMouse(true);
		mainFrame:SetMovable(true);
		mainFrame:SetFrameStrata("DIALOG");
		mainFrame:SetFrameLevel(127);
		mainFrame:RegisterForDrag("LeftButton");
		mainFrame:SetScript("OnDragStart", OnDragStart);
		mainFrame:SetScript("OnDragStop", OnDragStop);
		mainFrame:Hide();
		core.ui = mainFrame;
		mainFrame.list = {  };
		mainFrame:SetScript("OnShow", function(self)
			self.scroll:SetNumValue(#self.list);
		end);

		local scroll = ALASCR(mainFrame, ui_style.cellSizeX, nil, ui_style.cellSizeY, funcToCreateButton, functToSetButton);
		scroll:SetPoint("TOPRIGHT", - ui_style.scrollToBorderX, - ui_style.scrollToBorderYHeader);
		scroll:SetPoint("BOTTOMLEFT", ui_style.scrollToBorderX, ui_style.scrollToBorderYFooter);
		mainFrame.scroll = scroll;

		local close = CreateFrame("Button", nil, mainFrame);
		close:SetSize(24, 24);
		close:SetNormalTexture("interface\\common\\indicator-red");
		close:SetHighlightTexture("interface\\buttons\\ui-panel-minimizebutton-highlight");
		close:SetPoint("TOPRIGHT", -2, -4);
		close:SetScript("OnClick", function(self)
			self:GetParent():Hide();
		end);
		mainFrame.close = close;

		local wa = CreateFrame("Button", nil, mainFrame);
		wa:SetSize(24, 24);
		wa:SetNormalTexture(ARTWORK_PATH .. "wa");
		wa:GetNormalTexture():SetVertexColor(1.0, 0.0, 1.0, 1.0);
		wa:SetHighlightTexture("interface\\buttons\\ui-panel-minimizebutton-highlight");
		wa:SetPoint("TOPRIGHT", -32, -4);
		wa:SetScript("OnClick", function()
			-- if WeakAuras.LoadOptions() then
			-- 	WeakAuras.ToggleOptions();
			-- end
			WeakAuras.OpenOptions();
		end);
		mainFrame.wa = wa;

		do	--	Search
			local searchEdit = CreateFrame("EditBox", nil, mainFrame);
			searchEdit:SetSize(160, 20);
			searchEdit:SetFont(GameFontHighlight:GetFont(), 10, "OUTLINE");
			searchEdit:SetAutoFocus(false);
			searchEdit:SetJustifyH("LEFT");
			searchEdit:Show();
			searchEdit:EnableMouse(true);
			searchEdit:SetPoint("TOPLEFT", mainFrame, 12, - 6);
			local searchEditTexture = searchEdit:CreateTexture(nil, "ARTWORK");
			searchEditTexture:SetPoint("TOPLEFT");
			searchEditTexture:SetPoint("BOTTOMRIGHT");
			searchEditTexture:SetTexture("Interface\\Buttons\\greyscaleramp64");
			searchEditTexture:SetTexCoord(0.0, 0.25, 0.0, 0.25);
			searchEditTexture:SetAlpha(0.75);
			searchEditTexture:SetBlendMode("ADD");
			searchEditTexture:SetVertexColor(0.25, 0.25, 0.25);
			local searchEditNote = searchEdit:CreateFontString(nil, "OVERLAY");
			searchEditNote:SetFont(GameFontNormal:GetFont(), 12);
			searchEditNote:SetTextColor(1.0, 1.0, 1.0, 0.5);
			searchEditNote:SetPoint("LEFT", 4, 0);
			searchEditNote:SetText(L["Search"]);
			searchEditNote:Show();
			local searchCancel = CreateFrame("Button", nil, searchEdit);
			searchCancel:SetSize(16, 16);
			searchCancel:SetPoint("RIGHT", searchEdit);
			searchCancel:SetScript("OnClick", function(self) searchEdit:SetText(""); searchEdit:ClearFocus(); end);
			searchCancel:Hide();
			searchCancel:SetNormalTexture("interface\\petbattles\\deadpeticon")
			local searchEditOK = CreateFrame("Button", nil, mainFrame);
			searchEditOK:SetSize(32, 20);
			searchEditOK:SetPoint("LEFT", searchEdit, "RIGHT", 4, 0);
			searchEditOK:SetScript("OnClick", function(self) searchEdit:ClearFocus(); end);
			searchEditOK:Disable();
			local searchEditOKTexture = searchEditOK:CreateTexture(nil, "ARTWORK");
			searchEditOKTexture:SetPoint("TOPLEFT");
			searchEditOKTexture:SetPoint("BOTTOMRIGHT");
			searchEditOKTexture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
			searchEditOKTexture:SetAlpha(0.75);
			searchEditOKTexture:SetBlendMode("ADD");
			local searchEditOKText = searchEditOK:CreateFontString(nil, "OVERLAY");
			searchEditOKText:SetFont(GameFontHighlight:GetFont(), 12);
			searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5);
			searchEditOKText:SetPoint("CENTER");
			searchEditOKText:SetText(L["OK"]);
			searchEditOK:SetFontString(searchEditOKText);
			searchEditOK:SetPushedTextOffset(1, - 1);
			searchEditOK:SetScript("OnEnable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 1.0); end);
			searchEditOK:SetScript("OnDisable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5); end);
			searchEdit:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
			searchEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
			searchEdit:SetScript("OnTextChanged", function(self, isUserInput)
				search_update(mainFrame, self:GetText());
				if not searchEdit:HasFocus() and searchEdit:GetText() == "" then
					searchEditNote:Show();
				end
				if searchEdit:GetText() == "" then
					searchCancel:Hide();
				else
					searchCancel:Show();
				end
			end);
			searchEdit:SetScript("OnEditFocusGained", function(self)
				searchEditNote:Hide();
				searchEditOK:Enable();
			end);
			searchEdit:SetScript("OnEditFocusLost", function(self)
				if searchEdit:GetText() == "" then searchEditNote:Show(); end
				searchEditOK:Disable();
			end);
			searchEdit:ClearFocus();
		end

		search_update(mainFrame, nil);
	end
	function core.ShowUI()
		if core.ui and not core.ui:IsShown() then
			core.ui:Show();
			if WeakAurasOptions and WeakAurasOptions:IsShown() then
				local w = UIParent:GetWidth();
				local l = WeakAurasOptions:GetLeft();
				local r = WeakAurasOptions:GetRight();
				if l > w - r then
					core.ui:ClearAllPoints();
					core.ui:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", l, WeakAurasOptions:GetTop());
				else
					core.ui:ClearAllPoints();
					core.ui:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", r, WeakAurasOptions:GetTop());
				end
			end
		end
	end
	function core.HideUI()
		if core.ui then
			core.ui:Hide();
		end
	end
	StaticPopupDialogs["alaMiscWA_LoadWA"] = {
		text = L["Are you sure to load WA ?"],
		button1 = L["OK"],
		button2 = L["Cancel"],
		OnShow = function(self) end,
		OnAccept = function(self)
			if __core_namespace ~= nil then
				__core_namespace.__core._F_addonLoad("WeakAuras");
				if LoadAddOn("WeakAuras") then
					core.ShowUI();
				end
			else
				EnableAddOn("WeakAuras");
				EnableAddOn("WeakAurasArchive");
				EnableAddOn("WeakAurasModelPaths");
				EnableAddOn("WeakAurasOptions");
				EnableAddOn("WeakAurasTemplates");
				if LoadAddOn("WeakAuras") then
					LoadAddOn("WeakAurasArchive");
					LoadAddOn("WeakAurasModelPaths");
					LoadAddOn("WeakAurasOptions");
					LoadAddOn("WeakAurasTemplates");
					local f = WeakAuras.frames["Addon Initialization Handler"];
					if f then
						local s = f:GetScript("OnEvent");
						if s then
							s(f, "PLAYER_LOGIN");
							s(f, "PLAYER_ENTERING_WORLD");
						end
					end
					core.ShowUI();
				end
			end
		end,
		OnHide = function(self)
			self.which = nil;
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 1,
	};
	function core.toggleUI()
		if IsAddOnLoaded("WeakAuras") then
			if core.ui then
				if core.ui:IsShown() then
					core.HideUI();
				else
					core.ShowUI();
				end
			end
		else
			StaticPopup_Show("alaMiscWA_LoadWA");
		end
	end
	function core.CreateEntry()
		if not core.entry and WeakAurasOptions then
			local entry = CreateFrame("Button", nil, WeakAurasOptions);
			entry:SetSize(28, 28);
			-- entry:SetBackdrop(ui_style.mainFrameBackdrop);
			entry:SetNormalTexture(ARTWORK_PATH .. "wa");
			entry:SetHighlightTexture("interface\\buttons\\ui-panel-minimizebutton-highlight");
			entry:GetNormalTexture():SetVertexColor(0.0, 1.0, 1.0, 1.0);
			entry:SetPoint("TOPRIGHT", WeakAurasOptions, "TOPRIGHT", -120, 6);
			entry:SetScript("OnClick", core.toggleUI);
			core.entry = entry;
		end
	end
end


do	--	EVENTS
	function core.ADDON_LOADED(addon)
		if addon == ADDON then
			if select(2, GetAddOnInfo('\33\33\33\49\54\51\85\73\33\33\33')) then
				-- _EventVehicle:RegisterEvent("ADDON_LOADED");
				if IsAddOnLoaded("WeakAuras") then
					core.InitUI();
					C_Timer.After(1.0, core.ALATEST);
				end
			else
				_EventVehicle:UnregisterEvent("ADDON_LOADED");
			end
		elseif addon == "WeakAuras" then
			core.InitUI();
			C_Timer.After(1.0, core.ALATEST);
		elseif addon == "WeakAurasOptions" then
			if WeakAuras.ShowOptions then
				hooksecurefunc(WeakAuras, "ShowOptions", core.CreateEntry);
			end
		end
	end
	_EventVehicle:RegisterEvent("ADDON_LOADED");
end


do	--	API
	function core.WA_Re()
		if core.ui and core.ui.wa then
			core.ui.wa:SetNormalTexture(ARTWORK_PATH .. "wa");
		end
		if core.entry then
			core.entry:SetNormalTexture(ARTWORK_PATH .. "wa");
		end;
	end
	function core.WA_SetArtworkPath(path)
		ARTWORK_PATH = path;
		ARTWORK_WA_PATH = ARTWORK_PATH .. "shot\\";
		core.WA_Re();
	end
	function core.WA_WrapSetSubPath(path)
		path = gsub(gsub(path, "^[\\]+", ""), "[\\]+$", "");
		ARTWORK_PATH = "Interface\\Addons\\" .. path .. "\\WA\\ARTWORK\\";
		ARTWORK_WA_PATH = ARTWORK_PATH .. "shot\\";
		core.WA_Re();
	end
end


do	--	dev
	--	WeakAuras/Transmission.lua
	local tinsert = table.insert
	local tostring, string_char, strsplit = tostring, string.char, strsplit
	local pairs, type, unpack = pairs, type, unpack
	local error = error
	local bit_band, bit_lshift, bit_rshift = bit.band, bit.lshift, bit.rshift
	local coroutine = coroutine

	local Compresser = LibStub and LibStub:GetLibrary("LibCompress", true)
	local LibDeflate = LibStub and LibStub:GetLibrary("LibDeflate", true)
	local Serializer = LibStub and LibStub:GetLibrary("AceSerializer-3.0", true);
	local B64tobyte = {
		a =  0,  b =  1,  c =  2,  d =  3,  e =  4,  f =  5,  g =  6,  h =  7,
		i =  8,  j =  9,  k = 10,  l = 11,  m = 12,  n = 13,  o = 14,  p = 15,
		q = 16,  r = 17,  s = 18,  t = 19,  u = 20,  v = 21,  w = 22,  x = 23,
		y = 24,  z = 25,  A = 26,  B = 27,  C = 28,  D = 29,  E = 30,  F = 31,
		G = 32,  H = 33,  I = 34,  J = 35,  K = 36,  L = 37,  M = 38,  N = 39,
		O = 40,  P = 41,  Q = 42,  R = 43,  S = 44,  T = 45,  U = 46,  V = 47,
		W = 48,  X = 49,  Y = 50,  Z = 51,  ["0"]=52,["1"]=53,["2"]=54,["3"]=55,
		["4"]=56,["5"]=57,["6"]=58,["7"]=59,["8"]=60,["9"]=61,["("]=62,[")"]=63,
	  };
	local decodeB64Table = {};

	local function decodeB64(str)
		local bit8 = decodeB64Table;
		local decoded_size = 0;
		local ch;
		local i = 1;
		local bitfield_len = 0;
		local bitfield = 0;
		local l = #str;
		while true do
			if bitfield_len >= 8 then
				decoded_size = decoded_size + 1;
				bit8[decoded_size] = string_char(bit_band(bitfield, 255));
				bitfield = bit_rshift(bitfield, 8);
				bitfield_len = bitfield_len - 8;
			end
			ch = B64tobyte[str:sub(i, i)];
			bitfield = bitfield + bit_lshift(ch or 0, bitfield_len);
			bitfield_len = bitfield_len + 6;
			if i > l then
				break;
			end
			i = i + 1;
		end
		return table.concat(bit8, "", 1, decoded_size)
	end
	function core.ALATEST()do return end
		alaMiscSV.WA.dev = alaMiscSV.WA.dev or {  };
		if WeakAuras and WeakAuras.Import then
			for i, v in next, DATA do
				if not v.hide and (v.uid == nil or v.uid[1] == nil) and alaMiscSV.WA.dev[i] == nil then
					local inString = v.code;
					Compresser = Compresser or LibStub:GetLibrary("LibCompress", true);
					LibDeflate = LibDeflate or LibStub:GetLibrary("LibDeflate", true);
					Serializer = Serializer or LibStub:GetLibrary("AceSerializer-3.0", true);
					if not (Compresser and LibDeflate and Serializer) then
						_log_("LIB");
						break;
					end
					local encoded, usesDeflate = inString:gsub("^%!", "");
					local decoded = nil;
					if usesDeflate == 1 then
						decoded = LibDeflate:DecodeForPrint(encoded);
					else
						decoded = decodeB64(encoded);
					end
					local decompressed, errorMsg = nil, "unknown compression method";
					if usesDeflate == 1 then
						decompressed = LibDeflate:DecompressDeflate(decoded);
					else
						decompressed, errorMsg = Compresser:Decompress(decoded);
					end
					if not(decompressed) then
						_log_(i, v.id, "Error decompressing: ", errorMsg);
						break;
					end

					local success, deserialized = Serializer:Deserialize(decompressed);
					if not(success) then
						_log_(i, v.id, "Error deserializing ", deserialized);
						break;
					end

					--------------------------------
					local uid = deserialized.d.uid;
					local id = deserialized.d.id;
					if WeakAurasSaved.displays[id] then
						local u = {  };
						local c = WeakAurasSaved.displays[id].controlledChildren;
						u[1] = { WeakAurasSaved.displays[id].uid, WeakAurasSaved.displays[id].id, };
						for _, n in next, c do
							if WeakAurasSaved.displays[n] then
								tinsert(u, { WeakAurasSaved.displays[n].uid, n, });
							else
								u = nil;
								break;
							end
						end
						if u then
							alaMiscSV.WA.dev[i] = u;
						end
					end
				end
			end
		end
	end
	--	/run __ala_meta__.wa.DEV()
	function core.DEV()
		if WeakAurasSaved ~= nil and WeakAurasSaved.displays ~= nil then
			local dev = {  };
			local displays = WeakAurasSaved.displays;
			for name, info in next, displays do
				if info.controlledChildren ~= nil then
					local d = { { info.uid or "_NIL", } };
					dev[name] = d;
					for _, child in next, info.controlledChildren do
						local cinfo = displays[child];
						if cinfo then
							d[#d + 1] = { cinfo.uid or "_NIL", child, };
						end
					end
				end
			end
			alaMiscSV.WA.dev = alaMiscSV.WA.dev or {  };
			alaMiscSV.WA.dev.output = dev;
		end
	end
end


----------------------------------------------------------------------------------------------------
do	-- SLASH
	_G.SLASH_ALAWA1 = "/awa";
	_G.SLASH_ALAWA2 = "/alawa";
	SlashCmdList["ALAWA"] = function(msg)
		-- if msg == "" or strfind(msg, "^[ ]*show") then
			-- core.ShowUI();
		-- end
		core.toggleUI();
	end
end
----------------------------------------------------------------------------------------------------


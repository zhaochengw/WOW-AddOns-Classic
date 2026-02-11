--[[--
	by ALA
	--
	--	@name			'string'
	--	@GetDefault		default = GetDefault(module, key)
	--	@GetConfig		config = GetConfig(module, key)
	--	@SetConfig		SetConfig(module, key, val, loading)
	--	@LookupText		text = LookupText(type, module, key, extra)
	--	@return SettingUI
	SettingUI = __settingfactory:CreateSetting(name, GetDefault, GetConfig, SetConfig, LookupText, ...)
	--
	--	@category		'string'
	--	@meta = {
			1 module	'string'
			2 key		'string'
			3 type		'string'	['button', 'boolean', 'number', 'editor', 'color', 'list' / 'input-list', 'raido'],
			4 extra		--	number : range{ min, max, step, }	--	editor : 4th param of LookupText 	--	list, radio : list{} or list()
			5 callback	function(val)
			6 modfunc	nil/'number'/'function'
			7 display	function(val)
			[8 get]		'function'
			[9 label]	'string'
		}
	--	@indent			'number'
	--	@col			'number'
	--	@icon			'table'{ path, coord, color } or 'number' or 'string'
	SettingUI:AddSetting(category, meta, indent, col, icon)
--]]--

local __version = 250425.0;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;

-->			versioncheck
	local __settingfactory = __ala_meta__.__settingfactory;
	if __settingfactory ~= nil and __settingfactory.__minor >= __version then
		return;
	elseif __settingfactory == nil then
		__settingfactory = CreateFrame('FRAME');
		__ala_meta__.__settingfactory = __settingfactory;
		__ala_meta__.__onstream = {  };
	else
		if __settingfactory.Halt ~= nil then
			__settingfactory:Halt();
		end
		__ala_meta__.__onstream = __ala_meta__.__onstream or {  };
	end
	__settingfactory.__minor = __version;

-->

local uireimp = __ala_meta__.uireimp;
local menulib = __ala_meta__.__menulib;

local pcall, xpcall, geterrorhandler = pcall, xpcall, geterrorhandler;
local setmetatable = setmetatable;
local type = type;
local next, unpack = next, unpack;
local strupper, gsub = string.upper, string.gsub;
local tinsert = table.insert;
local min, max = math.min, math.max, math;
local CreateFrame = CreateFrame;
local UIParent = UIParent;
local _G = _G;
local Settings = Settings;
local InterfaceOptions_AddCategory = _G.InterfaceOptions_AddCategory;
if InterfaceOptions_AddCategory == nil then
	function InterfaceOptions_AddCategory(frame, addOn, position)
		-- cancel is no longer a default option. May add menu extension for this.
		frame.OnCommit = frame.okay;
		frame.OnDefault = frame.default;
		frame.OnRefresh = frame.refresh;

		if frame.parent then
			local category = Settings.GetCategory(frame.parent);
			local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, frame, frame.name, frame.name);
			subcategory.ID = frame.name;
			return subcategory, category;
		else
			local category, layout = Settings.RegisterCanvasLayoutCategory(frame, frame.name, frame.name);
			category.ID = frame.name;
			Settings.RegisterAddOnCategory(category);
			return category;
		end
	end
end
local InterfaceOptionsFrame_OpenToCategory = _G.InterfaceOptionsFrame_OpenToCategory;
if InterfaceOptionsFrame_OpenToCategory == nil then
	function InterfaceOptionsFrame_OpenToCategory(categoryIDOrFrame)
		if type(categoryIDOrFrame) == "table" then
			local categoryID = categoryIDOrFrame.name;
			return Settings.OpenToCategory(categoryID);
		else
			return Settings.OpenToCategory(categoryIDOrFrame);
		end
	end
end


local TEXTURE_PATH = strmatch(debugstack(), [[(Interface[^:"|]+[/\])[^/\:"|]+%.lua]]) .. [[Media\Texture\]];
local SettingUIColWidth = 200;
local SettingUILineHeight = 24;
local SettingUIFont = SystemFont_Shadow_Med1:GetFont();
local SettingUIFontSize = min(select(2, SystemFont_Shadow_Med1:GetFont()) + 1, 15);
local SettingUIFontFlag = "";


local TSettingUIMixin = {  };
local TWidgetMethod = {  };

-->
	function TWidgetMethod.SetButtonColorTexture(Button)
		local NT = Button:CreateTexture(nil, "ARTWORK");
		local PT = Button:CreateTexture(nil, "ARTWORK");
		local HT = Button:CreateTexture(nil, "HIGHLIGHT");
		NT:SetAllPoints();
		PT:SetAllPoints();
		HT:SetAllPoints();
		Button:SetNormalTexture(NT);
		Button:SetPushedTexture(PT);
		Button:SetHighlightTexture(HT);
		NT:SetColorTexture(0.25, 0.25, 0.25, 0.75);
		PT:SetColorTexture(0.25, 0.5, 0.75, 0.75);
		HT:SetColorTexture(0.0, 0.25, 0.5, 0.5);
		HT:SetBlendMode("ADD");
	end
	function TWidgetMethod.SetCheckButtonTexture(Check)
		Check:SetNormalTexture(TEXTURE_PATH .. [[CheckButtonBorder]]);
		Check:SetPushedTexture(TEXTURE_PATH .. [[CheckButtonCenter]]);
		Check:SetHighlightTexture(TEXTURE_PATH .. [[CheckButtonBorder]]);
		Check:SetCheckedTexture(TEXTURE_PATH .. [[CheckButtonCenter]]);
		Check:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 0.5);
		Check:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 0.25);
		Check:GetHighlightTexture():SetVertexColor(1.0, 1.0, 1.0, 0.5);
		Check:GetCheckedTexture():SetVertexColor(0.0, 0.5, 1.0, 0.75);
	end
-->	AddSetting	<--
	local round_func_table = setmetatable({  }, {
		__index = function(t, key)
			if type(key) == 'number' and key % 1 == 0 then
				local dec = 0.1 ^ key;
				local func = function(val)
					val = val + dec * 0.5;
					return val - val % dec;
				end;
				t[key] = func;
				return func;
			end
		end,
	});
	local boolean_func = function(val)
		if val == false or val == "false" or val == 0 or val == "0" or val == nil or val == "off" or val == "disabled" then
			return false;
		else
			return true;
		end
	end
	function TSettingUIMixin.AddSetting(SettingUI, category, meta, indent, col, icon)
		category = category or "GENERAL";
		meta.category = category;
		local module = meta.module or meta[1];
		local key = meta.key or meta[2];
		local Type = meta.type or meta[3];
		local _SettingList = SettingUI._SettingList;
		_SettingList[module] = _SettingList[module] or {  };
		_SettingList[module][key] = meta;
		if Type == 'number' then
			local modfunc = meta.modfunc or meta[6];
			meta.modfunc = type(modfunc) == 'function' and modfunc or (type(modfunc) == 'number' and round_func_table[modfunc]) or nil;
		elseif Type == 'boolean' then
			meta.modfunc = meta.modfunc or boolean_func;
		end
		local CategoryTable = SettingUI._CategoryList[category] or SettingUI:CreateCategory(category);
		CategoryTable.Setting[#CategoryTable.Setting + 1] = meta;
		SettingUI:CreateSetting(CategoryTable.Panel, module, key, Type, meta.extra or meta[4], meta.display or meta[7], indent, col, icon, meta.get or meta[8], meta.label or meta[9]);
	end
-->	Tab	<--
	function TWidgetMethod.Tab_OnClick(Tab)
		local SettingUI = Tab.__SettingUI;
		local SelectedTab = SettingUI.SelectedTab;
		if SelectedTab ~= Tab then
			if SelectedTab ~= nil then
				SelectedTab.Sel:Hide();
				SelectedTab.Panel:Hide();
			end
			Tab.Sel:Show();
			Tab.Panel:Show();
			SettingUI.SelectedTab = Tab;
			SettingUI.__Editor:Hide();
		end
	end
	function TSettingUIMixin.CreateCategory(SettingUI, category)
		local _CategoryList = SettingUI._CategoryList;
		local Tab = CreateFrame('BUTTON', nil, SettingUI);
		TWidgetMethod.SetButtonColorTexture(Tab);
		Tab:SetSize(72, 24);
		-- Tab:SetPoint("TOPLEFT", SettingUI, "TOPLEFT", 4 + 76 * #_CategoryList, -4);
		Tab:SetPoint("TOPLEFT", SettingUI.CategoryParent, "TOPLEFT", 4 + 76 * #_CategoryList, 0);
		Tab.__SettingUI = SettingUI;
		Tab:SetScript("OnClick", TWidgetMethod.Tab_OnClick);
		Tab.Text = Tab:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		Tab.Text:SetPoint("CENTER");
		Tab.Text:SetText(SettingUI.LookupText('category', category) or category);
		Tab.Sel = Tab:CreateTexture(nil, "OVERLAY");
		Tab.Sel:SetAllPoints();
		Tab.Sel:SetBlendMode("ADD");
		Tab.Sel:SetColorTexture(0.25, 0.5, 0.5, 0.5);
		Tab.Sel:Hide();
		--
		local Panel = CreateFrame('FRAME', nil, SettingUI);
		Panel:SetPoint("BOTTOMLEFT", 6, 6);
		Panel:SetPoint("TOPRIGHT", -6, -32);
		Panel:Hide();
		Tab.Panel = Panel;
		--
		if #_CategoryList == 0 then
			SettingUI.PanelOffset = 4;
			Tab:Hide();
			Panel:SetPoint("TOPRIGHT", -6, -4);
		elseif #_CategoryList == 1 then
			SettingUI.PanelOffset = 32;
			local CategoryTable1 = _CategoryList[_CategoryList[1]];
			CategoryTable1.Tab:Show();
			CategoryTable1.Panel:SetPoint("TOPRIGHT", -6, -32);
		end
		_CategoryList[#_CategoryList + 1] = category;
		local CategoryTable = { Tab = Tab, Panel = Panel, Setting = {  }, };
		_CategoryList[category] = CategoryTable;
		SettingUI.CategoryParent:SetWidth(4 + 76 * #_CategoryList);
		SettingUI:SetWidth(min(max(SettingUI:GetWidth(), SettingUI._MinW, 4 + 76 * #_CategoryList), 1024));
		--
		Panel.pos = { 0, 0, 0, 0, 0, 0, 0, 0, };
		--
		if SettingUI.SelectedTab == nil then
			TWidgetMethod.Tab_OnClick(Tab);
		end
		--
		return CategoryTable;
	end
-->	Setting Node	<--
	-->	node method
		--	button
		function TWidgetMethod.Button_OnClick(self)
			self.__SettingUI:SetConfigInner(self.module, self.key, nil, false);
		end
		--	number
		function TWidgetMethod.Slider_OnValueChanged(self, val, userInput)
			if userInput then
				val = self.__SettingUI:SetConfigInner(self.module, self.key, val, false);
				self:SetStr(val);
			end
		end
		--	boolean
		function TWidgetMethod.Check_OnClick(self, button)
			self.__SettingUI:SetConfigInner(self.module, self.key, self:GetChecked(), false);
		end
		--	editor
		function TWidgetMethod.EditorCallOutButton_OnClick(self)
			local SettingUI = self.__SettingUI;
			local Editor = SettingUI.__Editor;
			Editor.To = self;
			Editor:Show();
			Editor.EditBox:SetText(self.get and self.get() or SettingUI.GetConfig(self.module, self.key));
			Editor.Information:SetText(self.extra);
		end
		--	color
		function TWidgetMethod.ColorCallOutButton_OnClick(self)
			if ColorPickerFrame:IsShown() then
				ColorPickerFrame:Hide();
			else
				local SettingUI = self.__SettingUI;
				local module = self.module;
				local key = self.key;
				local orig = self.get and self.get() or SettingUI.GetConfig(module, key);
				ColorPickerFrame.func = nil;
				ColorPickerFrame.cancelFunc = nil;
				ColorPickerFrame:SetColorRGB(unpack(orig));
				ColorPickerFrame.func = function()
					SettingUI:SetConfigInner(module, key, { ColorPickerFrame:GetColorRGB() }, false);
				end
				ColorPickerFrame.cancelFunc = function()
					SettingUI:SetConfigInner(module, key, orig, false);
				end
				ColorPickerFrame.opacityFunc = nil;
				ColorPickerFrame:ClearAllPoints();
				ColorPickerFrame:SetPoint("BOTTOMLEFT", self, "TOPRIGHT", 12, 12);
				ColorPickerFrame:Show();
			end
		end
		--	list
		function TWidgetMethod.ListButton_Handler(self, SettingUI, param)
			local module, key, val, Drop, EditBox = param[1], param[2], param[3], param[4], param[5];
			SettingUI:SetConfigInner(module, key, val, false);
			Drop:SetVal(val);
		end
		function TWidgetMethod.ListDrop_OnClick(self)
			if self.__list == nil then
				menulib.ShowMenu(self, "BOTTOMLEFT", self.menudef, self.__SettingUI, false);
			else
				local menudef = self.menudef;
				local __list, __buttononshow, __buttononhide = self.__list();
				local __param = self.__param;
				local index = 0;
				for name, val in next, __list do
					index = index + 1;
					menudef[index] = {
						text = name,
						param = { __param[1], __param[2], val, __param[4], __param[5], };
					};
				end
				menudef.num = index;
				menudef.__buttononshow = __buttononshow;
				menudef.__buttononhide = __buttononhide;
				menulib.ShowMenu(self, "BOTTOMLEFT", menudef, self.__SettingUI, false);
			end
		end
		function TWidgetMethod.InputListEditBox_OnEnterPressed(self)
			local value = self:GetText();
			local valid, err = pcall(date, value);
			if valid then
				local SettingUI = self.__SettingUI;
				SettingUI:SetConfigInner(self.module, self.key, value, false);
				self.parent:SetVal(self.get and self.get() or SettingUI.GetConfig(self.module, self.key));
				self:ClearFocus();
				self.Okay:Hide();
				self.Discard:Hide();
			else
				self.Err:SetText(err);
				self.Err:SetVertexColor(1.0, 0.0, 0.0, 1.0);
			end
		end
		function TWidgetMethod.InputListEditBox_OnEscapePressed(self)
			local SettingUI = self.__SettingUI;
			self:ClearFocus();
			self.Okay:Hide();
			self.Discard:Hide();
			self.parent:SetVal(self.get and self.get() or SettingUI.GetConfig(self.module, self.key));
		end
		function TWidgetMethod.InputListEditBox_OnTextChanged(self, userInput)
			if userInput then
				self.Okay:Show();
				self.Discard:Show();
				self.Err:SetText("");
			end
		end
		function TWidgetMethod.InputListEditBoxOkay_OnClick(self)
			TWidgetMethod.InputListEditBox_OnEnterPressed(self.EditBox);
		end
		function TWidgetMethod.InputListEditBoxDiscard_OnClick(self)
			TWidgetMethod.InputListEditBox_OnEscapePressed(self.EditBox);
		end
		--	radio
		function TWidgetMethod.ListCheck_OnClick(self, button)
			if self:GetChecked() then
				self.__SettingUI:SetConfigInner(self.module, self.key, self.val, false);
				self.list:SetVal(self.val);
			else
				self:SetChecked(true);
			end
		end
	-->
	function TSettingUIMixin.CreateSetting(SettingUI, Panel, module, key, Type, extra, display, indent, col, icon, get, label)
		indent = indent or 0;
		col = col or 1;
		local LookupText = SettingUI.LookupText;
		local _SettingNodes = SettingUI._SettingNodes;
		_SettingNodes[module] = _SettingNodes[module] or {  };
		local Anchor = nil;
		Panel.pos[col] = Panel.pos[col] or 0;
		if Type == 'button' then
			local Head = Panel:CreateTexture(nil, "ARTWORK");
			Head:SetSize(16, 10);
			Head:SetTexture(TEXTURE_PATH .. [[ArrowRight]]);
			Head:SetVertexColor(0.5, 0.75, 1.0, 0.5);
			local Button = CreateFrame('BUTTON', nil, Panel);
			Button:SetSize(128, 16);
			Button:SetPoint("LEFT", Head, "CENTER", 16, 0);
			TWidgetMethod.SetButtonColorTexture(Button);
			Button.__SettingUI = SettingUI;
			Button.Head = Head;
			Button.module = module;
			Button.key = key;
			Button.get = get;
			Button:SetScript("OnClick", TWidgetMethod.Button_OnClick);
			local ButtonStr = Button:CreateFontString(nil, "ARTWORK");
			ButtonStr:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
			ButtonStr:SetPoint("CENTER");
			ButtonStr:SetText(label or LookupText('node', module, key) or key);
			Button._SetPoint = Button.SetPoint;
			function Button:SetPoint(...)
				self.Head:SetPoint(...);
			end
			function Button:SetVal(val)
			end
			_SettingNodes[module][key] = Button;
			Head:SetPoint("CENTER", Panel, "TOPLEFT", 32 + indent * SettingUILineHeight + (col - 1) * SettingUIColWidth, -22 - Panel.pos[col] * SettingUILineHeight);
			Panel.pos[col] = Panel.pos[col] + 1;
			Anchor = Head;
		elseif Type == 'number' then
			local Head = Panel:CreateTexture(nil, "ARTWORK");
			Head:SetSize(16, 10);
			Head:SetTexture(TEXTURE_PATH .. [[ArrowRight]]);
			Head:SetVertexColor(0.5, 0.75, 1.0, 0.5);
			local Label = Panel:CreateFontString(nil, "ARTWORK");
			Label:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
			Label:SetText(label or LookupText('node', module, key) or key);
			Label:SetPoint("LEFT", Head, "CENTER", 16, 0);
			local Slider = CreateFrame('SLIDER', nil, Panel);
			Slider:SetWidth(128);
			Slider:SetHeight(15);
			Slider:SetOrientation("HORIZONTAL");
			Slider:SetMinMaxValues(extra[1], extra[2]);
			Slider:SetValueStep(extra[3]);
			Slider:SetObeyStepOnDrag(true);
			Slider:SetPoint("LEFT", Head, "CENTER", 16, -SettingUILineHeight * 0.75);
			Slider:SetThumbTexture([[Interface\Buttons\UI-ScrollBar-Knob]]);
			Slider.Thumb = Slider:GetThumbTexture();
			Slider.Thumb:Show();
			Slider.Thumb:SetSize(2, 7);
			Slider.Thumb:SetColorTexture(1.0, 1.0, 1.0, 1.0);
			Slider.Track = Slider:CreateTexture(nil, "BACKGROUND");
			Slider.Track:SetHeight(1);
			Slider.Track:SetPoint("LEFT");
			Slider.Track:SetPoint("RIGHT");
			Slider.Track:SetColorTexture(1.0, 1.0, 1.0, 0.25);
			Slider.Text = Slider:CreateFontString(nil, "ARTWORK");
			Slider.Text:SetFont(SettingUIFont, SettingUIFontSize - 1, SettingUIFontFlag);
			Slider.Text:ClearAllPoints();
			Slider.Text:SetPoint("TOP", Slider, "BOTTOM", 0, 6);
			Slider.Text:SetAlpha(0.75);
			Slider.Low = Slider:CreateFontString(nil, "ARTWORK");
			Slider.Low:SetFont(SettingUIFont, SettingUIFontSize - 1, SettingUIFontFlag);
			Slider.Low:ClearAllPoints();
			Slider.Low:SetPoint("TOP", Slider, "BOTTOMLEFT", 4, 6);
			Slider.Low:SetVertexColor(0.5, 1.0, 0.5);
			Slider.Low:SetAlpha(0.75);
			Slider.Low:SetText(extra[1]);
			Slider.High = Slider:CreateFontString(nil, "ARTWORK");
			Slider.High:SetFont(SettingUIFont, SettingUIFontSize - 1, SettingUIFontFlag);
			Slider.High:ClearAllPoints();
			Slider.High:SetPoint("TOP", Slider, "BOTTOMRIGHT", -4, 6);
			Slider.High:SetVertexColor(1.0, 0.5, 0.5);
			Slider.High:SetAlpha(0.75);
			Slider.High:SetText(extra[2]);
			Slider.__SettingUI = SettingUI;
			Slider.Head = Head;
			Slider.module = module;
			Slider.key = key;
			Slider.get = get;
			Slider:SetScript("OnValueChanged", TWidgetMethod.Slider_OnValueChanged);
			function Slider:SetVal(val)
				self:SetValue(val);
				self:SetStr(val);
			end
			local def = SettingUI.GetDefault(module, key);
			function Slider:SetStr(val)
				self.Text:SetText(val);
				local diff = val - def;
				if diff > 0.0000001 then
					self.Text:SetVertexColor(1.0, 0.25, 0.25);
				elseif diff < -0.0000001 then
					self.Text:SetVertexColor(0.25, 1.0, 0.25);
				else
					self.Text:SetVertexColor(1.0, 1.0, 1.0);
				end
			end
			Slider._SetPoint = Slider.SetPoint;
			function Slider:SetPoint(...)
				self.Head:SetPoint(...);
			end
			_SettingNodes[module][key] = Slider;
			Head:SetPoint("CENTER", Panel, "TOPLEFT", 32 + indent * SettingUILineHeight + (col - 1) * SettingUIColWidth, -22 - Panel.pos[col] * SettingUILineHeight);
			Panel.pos[col] = Panel.pos[col] + 2;
			Anchor = Head;
		elseif Type == 'boolean' then
			local Check = CreateFrame('CHECKBUTTON', nil, Panel);
			Check:SetSize(16, 16);
			Check:SetHitRectInsets(0, 0, 0, 0);
			Check:Show();
			TWidgetMethod.SetCheckButtonTexture(Check);
			Check.__SettingUI = SettingUI;
			Check.Head = Head;
			Check.module = module;
			Check.key = key;
			Check.get = get;
			Check:SetScript("OnClick", TWidgetMethod.Check_OnClick);
			function Check:SetVal(val)
				self:SetChecked(val);
			end
			local Label = Panel:CreateFontString(nil, "ARTWORK");
			Label:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
			Label:SetText(label or LookupText('node', module, key) or key);
			Label:SetPoint("LEFT", Check, "CENTER", 16, 0);
			_SettingNodes[module][key] = Check;
			Check:SetPoint("CENTER", Panel, "TOPLEFT", 32 + indent * SettingUILineHeight + (col - 1) * SettingUIColWidth, -22 - Panel.pos[col] * SettingUILineHeight);
			Panel.pos[col] = Panel.pos[col] + 1;
			Anchor = Check;
		elseif Type == 'editor' then
			local Head = Panel:CreateTexture(nil, "ARTWORK");
			Head:SetSize(16, 10);
			Head:SetTexture(TEXTURE_PATH .. [[ArrowRight]]);
			Head:SetVertexColor(0.5, 0.75, 1.0, 0.5);
			local Button = CreateFrame('BUTTON', nil, Panel);
			Button:SetSize(128, 16);
			Button:SetPoint("LEFT", Head, "CENTER", 16, 0);
			TWidgetMethod.SetButtonColorTexture(Button);
			Button.__SettingUI = SettingUI;
			Button.Head = Head;
			Button.module = module;
			Button.key = key;
			Button.get = get;
			Button.extra = LookupText('value', module, key, extra) or extra;
			Button:SetScript("OnClick", TWidgetMethod.EditorCallOutButton_OnClick);
			local ButtonStr = Button:CreateFontString(nil, "ARTWORK");
			ButtonStr:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
			ButtonStr:SetPoint("CENTER");
			ButtonStr:SetText(label or LookupText('node', module, key) or key);
			Button._SetPoint = Button.SetPoint;
			function Button:SetPoint(...)
				self.Head:SetPoint(...);
			end
			Button.__indirect = true;
			_SettingNodes[module][key] = Button;
			Head:SetPoint("CENTER", Panel, "TOPLEFT", 32 + indent * SettingUILineHeight + (col - 1) * SettingUIColWidth, -22 - Panel.pos[col] * SettingUILineHeight);
			Panel.pos[col] = Panel.pos[col] + 1;
			Anchor = Head;
		elseif Type == 'color' then
			local Head = Panel:CreateTexture(nil, "ARTWORK");
			Head:SetSize(16, 10);
			Head:SetTexture(TEXTURE_PATH .. [[ArrowRight]]);
			Head:SetVertexColor(0.5, 0.75, 1.0, 0.5);
			local Button = CreateFrame('BUTTON', nil, Panel);
			Button:SetSize(128, 16);
			Button:SetPoint("LEFT", Head, "CENTER", 16, 0);
			TWidgetMethod.SetButtonColorTexture(Button);
			Button.__SettingUI = SettingUI;
			Button.Head = Head;
			Button.module = module;
			Button.key = key;
			Button.get = get;
			Button:SetScript("OnClick", TWidgetMethod.ColorCallOutButton_OnClick);
			local ButtonStr = Button:CreateFontString(nil, "ARTWORK");
			ButtonStr:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
			ButtonStr:SetPoint("CENTER");
			ButtonStr:SetText(label or LookupText('node', module, key) or key);
			Button._SetPoint = Button.SetPoint;
			function Button:SetPoint(...)
				self.Head:SetPoint(...);
			end
			Button.__indirect = true;
			_SettingNodes[module][key] = Button;
			Head:SetPoint("CENTER", Panel, "TOPLEFT", 32 + indent * SettingUILineHeight + (col - 1) * SettingUIColWidth, -22 - Panel.pos[col] * SettingUILineHeight);
			Panel.pos[col] = Panel.pos[col] + 1;
			Anchor = Head;
		elseif Type == 'list' or Type == 'input-list' then
			local Head = Panel:CreateTexture(nil, "ARTWORK");
			Head:SetSize(16, 10);
			Head:SetTexture(TEXTURE_PATH .. [[ArrowRight]]);
			Head:SetVertexColor(0.5, 0.75, 1.0, 0.5);
			local Label = Panel:CreateFontString(nil, "ARTWORK");
			Label:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
			Label:SetText(label or LookupText('node', module, key) or key);
			Label:SetPoint("LEFT", Head, "CENTER", 16, 0);
			local Drop = CreateFrame('BUTTON', nil, Panel);
			Drop:SetSize(12, 12);
			Drop:SetPoint("LEFT", Head, "CENTER", 16, -SettingUILineHeight);
			Drop:SetNormalTexture(TEXTURE_PATH .. "ArrowDown");
			Drop:SetPushedTexture(TEXTURE_PATH .. "ArrowDown");
			Drop:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
			Drop:SetHighlightTexture(TEXTURE_PATH .. "ArrowDown");
			Drop:GetHighlightTexture():SetVertexColor(0.0, 0.5, 1.0, 0.25);
			Drop.__SettingUI = SettingUI;
			Drop.Head = Head;
			Drop.get = get;
			local menudef = {
				handler = TWidgetMethod.ListButton_Handler,
			};
			if type(extra) == 'table' then
				for index = 1, #extra do
					menudef[index] = {
						text = LookupText('value', module, key, extra[index]) or extra[index];
						param = { module, key, extra[index], Drop, };
					};
				end
				menudef.num = #extra;
			elseif type(extra) == 'function' then
				Drop.__list = extra;
				Drop.__param = { module, key, nil, Drop, };
				extra();
			end
			Drop.menudef = menudef;
			Drop:SetScript("OnClick", TWidgetMethod.ListDrop_OnClick);
			local EditBox = CreateFrame('EDITBOX', nil, Panel);
			EditBox:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
			EditBox:SetPoint("LEFT", Drop, "RIGHT", 2, 0);
			EditBox:SetAutoFocus(false);
			EditBox:SetTextInsets(10, 0, 0, 0);
			EditBox.parent = Drop;
			if Type == 'input-list' then
				EditBox:SetSize(240, 18);
				EditBox.__SettingUI = SettingUI;
				EditBox.module = module;
				EditBox.key = key;
				EditBox.get = get;
				EditBox:SetScript("OnEnterPressed", TWidgetMethod.InputListEditBox_OnEnterPressed);
				EditBox:SetScript("OnEscapePressed", TWidgetMethod.InputListEditBox_OnEscapePressed);
				EditBox:SetScript("OnTextChanged", TWidgetMethod.InputListEditBox_OnTextChanged);
				if display ~= nil then
					function Drop:SetVal(val)
						EditBox:SetText(val);
						EditBox.Err:SetText(LookupText('value', module, key, val) or display(val) or val);
						EditBox.Err:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					end
				else
					function Drop:SetVal(val)
						EditBox:SetText(val);
						EditBox.Err:SetText(LookupText('value', module, key, val) or val);
						EditBox.Err:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					end
				end
				uireimp._SetSimpleBackdrop(EditBox, 0, 1, 0.25, 0.25, 0.25, 1.0, 1.0, 1.0, 1.0, 0.125);
				-- menudef[#menudef + 1] = {
				-- 	text = "",
				-- 	param = { module, key, nil, Drop, EditBox, },
				-- };
				-- menudef.num = #menudef;
				local Okay = CreateFrame('BUTTON', nil, EditBox);
				Okay:SetSize(16, 16);
				Okay:SetPoint("LEFT", EditBox, "RIGHT", 2, 0);
				Okay:SetNormalTexture(TEXTURE_PATH .. [[opt-okay]]);
				Okay:GetNormalTexture():SetVertexColor(0.75, 0.75, 0.75, 1.0);
				Okay:SetPushedTexture(TEXTURE_PATH .. [[opt-okay]]);
				Okay:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
				Okay:SetHighlightTexture(TEXTURE_PATH .. [[opt-okay]]);
				Okay:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
				Okay:Hide();
				Okay:SetScript("OnClick", TWidgetMethod.InputListEditBoxOkay_OnClick);
				EditBox.Okay = Okay;
				Okay.EditBox = EditBox;
				local Discard = CreateFrame('BUTTON', nil, EditBox);
				Discard:SetSize(16, 16);
				Discard:SetPoint("LEFT", Okay, "RIGHT", 2, 0);
				Discard:SetNormalTexture(TEXTURE_PATH .. [[opt-discard]]);
				Discard:GetNormalTexture():SetVertexColor(0.75, 0.75, 0.75, 1.0);
				Discard:SetPushedTexture(TEXTURE_PATH .. [[opt-discard]]);
				Discard:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
				Discard:SetHighlightTexture(TEXTURE_PATH .. [[opt-discard]]);
				Discard:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
				Discard:Hide();
				Discard:SetScript("OnClick", TWidgetMethod.InputListEditBoxDiscard_OnClick);
				EditBox.Discard = Discard;
				Discard.EditBox = EditBox;
				local Err = EditBox:CreateFontString(nil, "ARTWORK");
				Err:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
				Err:SetPoint("LEFT", EditBox, "BOTTOMLEFT", 0, -SettingUILineHeight * 0.5);
				Err:Show();
				EditBox.Err = Err;
			else
				EditBox:SetSize(128, 16);
				if display ~= nil then
					function Drop:SetVal(val)
						EditBox:SetText(LookupText('value', module, key, val) or display(val) or val);
					end
				else
					function Drop:SetVal(val)
						EditBox:SetText(LookupText('value', module, key, val) or val);
					end
				end
				uireimp._SetSimpleBackdrop(EditBox, 0, 1, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.25);
				EditBox:Disable();
			end
			Drop._SetPoint = Drop.SetPoint;
			function Drop:SetPoint(...)
				self.Head:SetPoint(...);
			end
			_SettingNodes[module][key] = Drop;
			Head:SetPoint("CENTER", Panel, "TOPLEFT", 32 + indent * SettingUILineHeight + (col - 1) * SettingUIColWidth, -22 - Panel.pos[col] * SettingUILineHeight);
			Panel.pos[col] = Panel.pos[col] + (Type == 'input-list' and 3 or 2);
			Anchor = Head;
		elseif Type == 'radio' then
			local Head = Panel:CreateTexture(nil, "ARTWORK");
			Head:SetSize(16, 10);
			Head:SetTexture(TEXTURE_PATH .. [[ArrowRight]]);
			Head:SetVertexColor(0.5, 0.75, 1.0, 0.5);
			local Label = Panel:CreateFontString(nil, "ARTWORK");
			Label:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
			Label:SetText(label or LookupText('node', module, key) or key);
			Label:SetPoint("LEFT", Head, "CENTER", 16, 0);
			local list = {  };
			local x = 0;
			local y = 1;
			for index, val in next, extra do
				if x >= 2 then
					x = 0;
					y = y + 1;
				end
				local Check = CreateFrame('CHECKBUTTON', nil, Panel);
				Check:SetSize(16, 16);
				Check:SetPoint("TOPLEFT", Head, "CENTER", 18 + x * 80, -SettingUILineHeight * (y - 0.5));
				Check:SetHitRectInsets(0, 0, 0, 0);
				Check:Show();
				TWidgetMethod.SetCheckButtonTexture(Check);
				Check.__SettingUI = SettingUI;
				Check.Head = Head;
				Check.module = module;
				Check.key = key;
				Check.get = get;
				Check:SetScript("OnClick", TWidgetMethod.ListCheck_OnClick);
				Check.list = list;
				Check.index = index;
				Check.val = val;
				list[index] = Check;
				local Text = Panel:CreateFontString(nil, "ARTWORK");
				Text:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
				Text:SetText(LookupText('value', module, key, val) or val);
				Text:SetPoint("LEFT", Check, "RIGHT", 2, 0);
				Check.Text = Text;
				x = x + 1;
			end
			function list:SetVal(val)
				for index, v in next, extra do
					list[index]:SetChecked(v == val);
				end
			end
			list._SetPoint = list.SetPoint;
			function list:SetPoint(...)
				self.Head:SetPoint(...);
			end
			list.__indirect = false;
			_SettingNodes[module][key] = list;
			Head:SetPoint("CENTER", Panel, "TOPLEFT", 32 + indent * SettingUILineHeight + (col - 1) * SettingUIColWidth, -22 - Panel.pos[col] * SettingUILineHeight);
			Panel.pos[col] = Panel.pos[col] + y + 1;
			Anchor = Head;
		else
			return;
		end
		SettingUI:SetWidth(min(max(SettingUI:GetWidth(), SettingUI._MinW, 32 + SettingUIColWidth * col + 32), 1024));
		SettingUI:SetHeight(min(max(SettingUI:GetHeight(), SettingUI._MinH, SettingUI.PanelOffset + 12 + Panel.pos[col] * SettingUILineHeight + 12 + 6), 1024));
		if icon ~= nil then
			local i = Panel:CreateTexture(nil, "ARTWORK");
			i:SetSize(20, 20);
			i:SetPoint("RIGHT", Anchor, "CENTER", -12, 0);
			if type(icon) == 'table' then
				if icon[1] ~= nil then
					i:SetTexture(icon[1]);
					if icon[2] ~= nil then
						i:SetTexCoord(unpack(icon[2]));
					end
					if icon[3] ~= nil then
						i:SetVertexColor(unpack(icon[3]));
					end
				elseif icon[3] ~= nil then
					i:SetColorTexture(unpack(icon[3]));
				end
			else
				i:SetTexture(icon);
			end
		end
	end
	function TSettingUIMixin.AlignSetting(SettingUI, category, ofs)
		local CategoryTable = SettingUI._CategoryList[category];
		if CategoryTable ~= nil then
			local pos = CategoryTable.Panel.pos;
			local val = 0;
			for index = 1, 8 do
				local v = pos[index];
				if v > val then
					val = v;
				end
			end
			val = val + (ofs or 0);
			for index = 1, 8 do
				pos[index] = val;
			end
		end
	end
-->	SettingUI	<--
	function TWidgetMethod.SettingUIOnShow(SettingUI)
		for module, nodes in next, SettingUI._SettingNodes do
			for key, node in next, nodes do
				if node.__indirect ~= true then
					node:SetVal(node.get and node.get() or SettingUI.GetConfig(module, key));
				end
			end
		end
	end
	function TWidgetMethod.EditorOnShow(self)
		self.ScrollBar:SetValue(0);
	end
	function TWidgetMethod.EditorScrollFrameOnSizeChanged(self)
		local Editor = self.__Editor;
		Editor.EditBox:SetWidth(Editor:GetWidth() - 24);
	end
	function TWidgetMethod.EditorScrollFrameOnScrollRangeChanged(self, xrange, yrange)
		local Editor = self.__Editor;
		Editor.ScrollBar:SetMinMaxValues(0, yrange);
		if yrange + 0.5 < Editor.__val then
			Editor.ScrollBar:SetValue(yrange);
		end
	end
	function TWidgetMethod.EditorScrollFrameOnMouseDown(self)
		local Editor = self.__Editor;
		Editor.EditBox:SetFocus();
	end
	function TWidgetMethod.EditorScrollFrameOnMouseWheel(self, delta)
		local Editor = self.__Editor;
		local _min, _max = Editor.ScrollBar:GetMinMaxValues();
		local _val = self.__Editor.__val - delta * Editor.__stepSize;
		if _val > _max then
			_val = _max;
		elseif _val < _min then
			_val = _min;
		end
		Editor.ScrollBar:SetValue(_val);
	end
	function TWidgetMethod.EditorScrollBarOnValueChanged(self, value)
		local Editor = self.__Editor;
		Editor.ScrollFrame:SetVerticalScroll(value);
		Editor.__val = value;
	end
	function TWidgetMethod.EditorScrollBarOnMouseWheel(self, delta)
		local Editor = self.__Editor;
		local _min, _max = self:GetMinMaxValues();
		local _val = Editor.__val - delta * Editor.__stepSize;
		if _val > _max then
			_val = _max;
		elseif _val < _min then
			_val = _min;
		end
		self:SetValue(_val);
	end
	function TWidgetMethod.EditorEditBoxOnCursorChanged(self, x, y, w, h)
		local Editor = self.__Editor;
		local _min, _max = Editor.ScrollBar:GetMinMaxValues();
		if _max > 0 then
			local _Height = Editor.ScrollFrame:GetHeight();
			local _minPos = -y - _Height;
			if _Height > h then
				local _maxPos = _minPos + h;
				local _minRange = Editor.__val - _Height;
				local _maxRange = Editor.__val;
				--
				if _minPos < _minRange then
					Editor.ScrollBar:SetValue(_minRange);
				elseif _maxPos > _maxRange then
					Editor.ScrollBar:SetValue(_maxPos);
				end
			else
				Editor.ScrollBar:SetValue(_minPos);
			end
		end
	end
	function TWidgetMethod.EditorSaveValueOnClick(self)
		local Editor = self.__Editor;
		local To = Editor.To;
		Editor.__SettingUI:SetConfigInner(To.module, To.key, Editor.EditBox:GetText(), false);
		Editor:Hide();
	end
	function TWidgetMethod.EditorCancelOnClick(self)
		self.__Editor:Hide();
	end
	function TWidgetMethod.SettingUIFreeContainerOnShow(self)
		local SettingUI = self.__SettingUI;
		SettingUI.InterfaceOptionsFrameContainer:Hide();
		self:SetSize(SettingUI:GetWidth(), SettingUI:GetHeight() + 24);
		SettingUI:Show();
		SettingUI:ClearAllPoints();
		SettingUI:SetPoint("BOTTOM", self, "BOTTOM");
		SettingUI.Container = self;
	end
	function TWidgetMethod.SettingUIFreeContainerOnHide(self)
		local SettingUI = self.__SettingUI;
		if not SettingUI.InterfaceOptionsFrameContainer:IsShown() then
			SettingUI:Hide();
			SettingUI:ClearAllPoints();
		end
	end
	function TWidgetMethod.SettingUIInterfaceOptionsFrameContainerOnShow(self)
		local SettingUI = self.__SettingUI;
		SettingUI.FreeContainer:Hide();
		SettingUI:Show();
		SettingUI:ClearAllPoints();
		SettingUI:SetPoint("TOPLEFT", self, "TOPLEFT", 4, 0);
		SettingUI.Container = self;
	end
	function TWidgetMethod.SettingUIInterfaceOptionsFrameContainerOnHide(self)
		local SettingUI = self.__SettingUI;
		if not SettingUI.FreeContainer:IsShown() then
			SettingUI:Hide();
			SettingUI:ClearAllPoints();
		end
	end
	local function CreateFreeContainer(SettingUI)
		local FreeContainerName = SettingUI.name .. "_SETTINGUI_FREE_CONTAINER";
		local FreeContainer = CreateFrame('FRAME', FreeContainerName, UIParent);
		FreeContainer:Hide();
		FreeContainer:SetFrameStrata("DIALOG");
		FreeContainer:SetPoint("CENTER");
		FreeContainer:EnableMouse(true);
		FreeContainer:SetMovable(true);
		FreeContainer:RegisterForDrag("LeftButton");
		FreeContainer.__SettingUI = SettingUI;
		FreeContainer:SetScript("OnDragStart", FreeContainer.StartMoving);
		FreeContainer:SetScript("OnDragStop", FreeContainer.StopMovingOrSizing);
		FreeContainer:SetScript("OnShow", TWidgetMethod.SettingUIFreeContainerOnShow);
		FreeContainer:SetScript("OnHide", TWidgetMethod.SettingUIFreeContainerOnHide);
		FreeContainer.Title = FreeContainer:CreateFontString(nil, "ARTWORK");
		FreeContainer.Title:SetPoint("CENTER", FreeContainer, "TOP", 0, -12);
		FreeContainer.Title:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
		FreeContainer.Title:SetText(SettingUI.name);
		tinsert(UISpecialFrames, FreeContainerName);
		local Close = CreateFrame('BUTTON', nil, FreeContainer);
		Close:SetSize(16, 16);
		Close:SetNormalTexture(TEXTURE_PATH .. [[Close]]);
		Close:SetPushedTexture(TEXTURE_PATH .. [[Close]]);
		Close:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
		Close:SetHighlightTexture(TEXTURE_PATH .. [[Close]]);
		Close:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
		Close:SetPoint("TOPRIGHT", FreeContainer, "TOPRIGHT", -4, -4);
		Close:SetScript("OnClick", function(self)
			FreeContainer:Hide();
		end);
		FreeContainer.Close = Close;
		FreeContainer.Background = FreeContainer:CreateTexture(nil, "BACKGROUND");
		FreeContainer.Background:SetAllPoints();
		FreeContainer.Background:SetColorTexture(0.0, 0.0, 0.0, 0.9);
		--
		return FreeContainer;
	end
	local function CreateInterfaceOptionsFrameContainer(SettingUI)
		local InterfaceOptionsFrameContainer = CreateFrame('FRAME');
		InterfaceOptionsFrameContainer:Hide();
		InterfaceOptionsFrameContainer:SetSize(1, 1);
		InterfaceOptionsFrameContainer.__SettingUI = SettingUI;
		InterfaceOptionsFrameContainer.name = SettingUI.name;
		InterfaceOptionsFrameContainer:SetScript("OnShow", TWidgetMethod.SettingUIInterfaceOptionsFrameContainerOnShow);
		InterfaceOptionsFrameContainer:SetScript("OnHide", TWidgetMethod.SettingUIInterfaceOptionsFrameContainerOnHide);
		InterfaceOptions_AddCategory(InterfaceOptionsFrameContainer);
		--
		return InterfaceOptionsFrameContainer;
	end
	local function CreateEditor(SettingUI)
		local Editor = CreateFrame('FRAME', nil, SettingUI);
		Editor:SetFrameLevel(SettingUI:GetFrameLevel() + 63);
		Editor:SetPoint("BOTTOMLEFT", 0, 0);
		Editor:SetPoint("TOPRIGHT", 0, -32);
		Editor.Background = Editor:CreateTexture(nil, "BACKGROUND");
		Editor.Background:SetAllPoints();
		Editor.Background:SetColorTexture(0.0, 0.0, 0.0, 1.0);
		Editor.__SettingUI = SettingUI;
		Editor.__val = 0;
		Editor.__stepSize = 20;
		Editor:SetScript("OnShow", TWidgetMethod.EditorOnShow);
		--
		local EditorScrollFrame = CreateFrame('SCROLLFRAME', nil, Editor);
		EditorScrollFrame:SetPoint("BOTTOMLEFT", 0, 32);
		EditorScrollFrame:SetPoint("TOPRIGHT", -20, -72);
		EditorScrollFrame.Background = EditorScrollFrame:CreateTexture(nil, "BACKGROUND");
		EditorScrollFrame.Background:SetAllPoints();
		EditorScrollFrame.Background:SetColorTexture(0.25, 0.25, 0.25, 0.5);
		EditorScrollFrame.__Editor = Editor;
		EditorScrollFrame:SetScript("OnSizeChanged", TWidgetMethod.EditorScrollFrameOnSizeChanged);
		EditorScrollFrame:SetScript("OnScrollRangeChanged", TWidgetMethod.EditorScrollFrameOnScrollRangeChanged);
		EditorScrollFrame:SetScript("OnMouseDown", TWidgetMethod.EditorScrollFrameOnMouseDown);
		EditorScrollFrame:SetScript("OnMouseWheel", TWidgetMethod.EditorScrollFrameOnMouseWheel);
		--
		local EditorScrollBar = CreateFrame('SLIDER', nil, Editor);
		EditorScrollBar:SetWidth(12);
		EditorScrollBar:SetPoint("BOTTOMRIGHT", -4, 46);
		EditorScrollBar:SetPoint("TOPRIGHT", -4, -78);
		EditorScrollBar:SetOrientation("VERTICAL");
		EditorScrollBar:EnableMouse(true);
		EditorScrollBar:SetThumbTexture([[Interface\Buttons\UI-ScrollBar-Knob]]);
			local Thumb = EditorScrollBar:GetThumbTexture();
			Thumb:Show();
			Thumb:SetColorTexture(0.0, 1.0, 0.0, 1.0);
			local TrackSmallerValue = EditorScrollBar:CreateTexture(nil, "ARTWORK");
			TrackSmallerValue:Show();
			TrackSmallerValue:SetColorTexture(0.0, 1.0, 0.0, 1.0);
			EditorScrollBar.TrackSmallerValue = TrackSmallerValue;
			local TrackLargerValue = EditorScrollBar:CreateTexture(nil, "ARTWORK");
			TrackLargerValue:Show();
			TrackLargerValue:SetColorTexture(1.0, 1.0, 1.0, 1.0);
			EditorScrollBar.TrackLargerValue = TrackLargerValue;
			Thumb:SetSize(2, 1);
			TrackSmallerValue:SetWidth(2);
			TrackSmallerValue:ClearAllPoints();
			TrackSmallerValue:SetPoint("TOP");
			TrackSmallerValue:SetPoint("BOTTOM", Thumb, "TOP");
			TrackLargerValue:SetWidth(2);
			TrackLargerValue:ClearAllPoints();
			TrackLargerValue:SetPoint("BOTTOM");
			TrackLargerValue:SetPoint("TOP", Thumb, "BOTTOM");
		EditorScrollBar:SetMinMaxValues(0, 0);
		EditorScrollBar.__Editor = Editor;
		EditorScrollBar:SetScript("OnValueChanged", TWidgetMethod.EditorScrollBarOnValueChanged);
		EditorScrollBar:SetScript("OnMouseWheel", TWidgetMethod.EditorScrollBarOnMouseWheel);
		--
		local EditorEditBox = CreateFrame('EDITBOX', nil, EditorScrollFrame);
		EditorEditBox:SetPoint("LEFT", 0, 0);
		-- EditorEditBox:SetPoint("RIGHT", 0, 0);
		EditorEditBox:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
		EditorEditBox:SetJustifyH("LEFT");
		EditorEditBox:SetTextColor(1.0, 1.0, 1.0, 1.0);
		EditorEditBox:SetMultiLine(true);
		EditorEditBox:SetAutoFocus(false);
		EditorEditBox:SetTextInsets(5, 5, 5, 5);
		EditorEditBox.__Editor = Editor;
		-- EditorEditBox:SetScript("OnTextChanged", nil);
		EditorEditBox:SetScript("OnEscapePressed", EditorEditBox.ClearFocus);
		EditorEditBox:SetScript("OnCursorChanged", TWidgetMethod.EditorEditBoxOnCursorChanged);
		--
		EditorScrollFrame:SetScrollChild(EditorEditBox);
		--
		local EditorSaveValue = CreateFrame('BUTTON', nil, Editor);
		EditorSaveValue:SetSize(48, 20);
		TWidgetMethod.SetButtonColorTexture(EditorSaveValue);
		EditorSaveValue:SetPoint("CENTER", Editor, "BOTTOM", -48, 16);
		EditorSaveValue.__Editor = Editor;
		EditorSaveValue:SetScript("OnClick", TWidgetMethod.EditorSaveValueOnClick);
		--
		local EditorSaveValueStr = EditorSaveValue:CreateFontString(nil, "ARTWORK");
		EditorSaveValueStr:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
		EditorSaveValueStr:SetPoint("CENTER");
		-- EditorSaveValueStr:SetTextColor(0.5, 1.0, 0.5);
		EditorSaveValueStr:SetText(OKAY or "OKAY");
		--
		local EditorCancel = CreateFrame('BUTTON', nil, Editor);
		EditorCancel:SetSize(48, 20);
		TWidgetMethod.SetButtonColorTexture(EditorCancel);
		EditorCancel:SetPoint("CENTER", Editor, "BOTTOM", 48, 16);
		EditorCancel.__Editor = Editor;
		EditorCancel:SetScript("OnClick", TWidgetMethod.EditorCancelOnClick);
		--
		local EditorCancelStr = EditorCancel:CreateFontString(nil, "ARTWORK");
		EditorCancelStr:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
		EditorCancelStr:SetPoint("CENTER");
		-- EditorCancelStr:SetTextColor(1.0, 0.5, 0.5);
		EditorCancelStr:SetText(CANCEL or "CANCEL");
		--
		local Information = Editor:CreateFontString(nil, "ARTWORK");
		Information:SetFont(SettingUIFont, SettingUIFontSize, SettingUIFontFlag);
		Information:SetPoint("LEFT", Editor, "TOPLEFT", 4, -36);
		Information:SetPoint("RIGHT", Editor, "TOPRIGHT", -4, -36);
		--
		Editor.Information = Information;
		Editor.SaveValue = EditorSaveValue;
		Editor.Cancel = EditorCancel;
		Editor.ScrollFrame = EditorScrollFrame;
		Editor.ScrollBar = EditorScrollBar;
		Editor.EditBox = EditorEditBox;
		Editor:Hide();
		--
		return Editor;
	end
-->
function TSettingUIMixin.OpenSettingTo(SettingUI, module, key)
	local node = SettingUI._SettingNodes[module][key];
	local meta = SettingUI._SettingList[module][key];
	local CategoryTable = SettingUI._CategoryList[meta.category];
	if not SettingUI.InterfaceOptionsFrameContainer:IsShown() then
		SettingUI.FreeContainer:Show();
	end
	CategoryTable.Tab:Click();
	if node.__indirect == true and node.Click then
		node:Click();
	end
end
function TSettingUIMixin.Open(SettingUI)
	if (SettingsPanel or InterfaceOptionsFrame):IsShown() then
		InterfaceOptionsFrame_OpenToCategory(SettingUI.name);
	else
		SettingUI.FreeContainer:SetShown(not SettingUI.FreeContainer:IsShown());
	end
end
function TSettingUIMixin.SetMinSize(SettingUI, MinW, MinH)
	if MinW > 0 then
		SettingUI._MinW = MinW;
		if SettingUI:GetWidth() < MinW then
			SettingUI:SetWidth(MinW);
		end
	end
	if MinH > 0 then
		SettingUI._MinH = MinH;
		if SettingUI:GetHeight() < MinH then
			SettingUI:SetHeight(MinH);
		end
	end
end
function TSettingUIMixin.RefreshNode(SettingUI, module, key, val, loading)
	local node = SettingUI._SettingNodes[module][key];
	if node ~= nil and node.__indirect ~= true then
		node:SetVal(val);
	end
end
function TSettingUIMixin.SetConfigInner(SettingUI, module, key, val, loading)
	local meta = SettingUI._SettingList[module][key];
	if meta ~= nil then
		local modfunc = meta.modfunc or meta[6];
		if modfunc ~= nil then
			val = modfunc(val);
		end
		local callback = meta.callback or meta[5];
		if callback ~= nil then
			callback(val);
		else
			SettingUI.SetConfig(module, key, val, loading);
		end
		return val;
	end
end

function __settingfactory:CreateSettingUI(name, GetDefault, GetConfig, SetConfig, LookupText)
	local SettingUI = CreateFrame('FRAME', nil, UIParent);
	SettingUI:SetFrameStrata("DIALOG");
	SettingUI:SetScript("OnShow", TWidgetMethod.SettingUIOnShow);
	SettingUI:Hide();
	for key, val in next, TSettingUIMixin do
		SettingUI[key] = val;
	end
	SettingUI.name = name;
	SettingUI.GetDefault = GetDefault;
	SettingUI.GetConfig = GetConfig;
	SettingUI.SetConfig = SetConfig;
	SettingUI.LookupText = LookupText or {  };
	SettingUI.__Editor = CreateEditor(SettingUI);
	--
	SettingUI.FreeContainer = CreateFreeContainer(SettingUI);
	SettingUI.InterfaceOptionsFrameContainer = CreateInterfaceOptionsFrameContainer(SettingUI);
	--
	SettingUI._CategoryList = {  };
	SettingUI._SettingNodes = {  };
	SettingUI._SettingList = {  };
	SettingUI._MinW = 0;
	SettingUI._MinH = 0;
	--
	SettingUI.CategoryParent = CreateFrame('FRAME', nil, SettingUI);
	SettingUI.CategoryParent:SetSize(1, 1);
	SettingUI.CategoryParent:SetPoint("TOP", SettingUI, "TOP", 0, -4);
	--
	return SettingUI;
end
function __settingfactory:CreateSetting(name, GetDefault, GetConfig, SetConfig, LookupText, ...)
	local SettingUI = __settingfactory:CreateSettingUI(name, GetDefault, GetConfig, SetConfig, LookupText);
	local t = { ... };
	local n = #t;
	if n > 0 then
		n = 0;
		local NAME = strupper(name);
		local pref = "SLASH_" .. NAME;
		for i = 1, #t do
			local v = t[i];
			if t[v] == nil and type(v) == 'string' then
				n = n + 1;
				_G[pref .. n] = v;
				t[v] = i;
			end
		end
		if n > 0 then
			SlashCmdList[NAME] = function()
				SettingUI:Open();
			end
		end
	end
	return SettingUI;
end

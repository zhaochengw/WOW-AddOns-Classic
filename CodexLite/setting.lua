--[[--
	by ALA @ 163UI/网易有爱, http://wowui.w.163.com/163ui/
	CREDIT shagu/pfQuest(MIT LICENSE) @ https://github.com/shagu
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __ns = ...;

local _G = _G;
local _ = nil;
----------------------------------------------------------------------------------------------------
--[=[dev]=]	if __ns.__is_dev then __ns._F_devDebugProfileStart('module.setting'); end

-->		variables
	local setmetatable = setmetatable;
	local type = type;
	local select = select;
	local next = next;
	local tinsert = table.insert;
	local strlower, strfind, gsub = string.lower, string.find, string.gsub;
	local min, max = math.min, math.max;
	local tonumber = tonumber;
	local CreateFrame = CreateFrame;
	local GameTooltip = GameTooltip;
	local UIParent = UIParent;
	local UISpecialFrames = UISpecialFrames;
	local SlashCmdList = SlashCmdList;

	local __db = __ns.db;
	local __db_quest = __db.quest;
	local __loc = __ns.L;
	local __loc_quest = __loc.quest;
	local __UILOC = __ns.UILOC;

	local __core = __ns.core;
	local _F_SafeCall = __core._F_SafeCall;
	local __eventHandler = __core.__eventHandler;
	local IMG_LIST = __core.IMG_LIST;
	local GetQuestStartTexture = __core.GetQuestStartTexture;

	local _log_ = __ns._log_;

	local IMG_CLOSE = __core.IMG_PATH .. "close";
	local _font, _fontsize = SystemFont_Shadow_Med1:GetFont(), min(select(2, SystemFont_Shadow_Med1:GetFont()) + 1, 15);

	local SET = nil;
-->
if __ns.__is_dev then
	__ns:BuildEnv("setting");
end
-->		MAIN
	local SettingUI = CreateFrame('FRAME', "CODEX_LITE_SETTING_UI", UIParent);
	__ns.__ui_setting = SettingUI;
	local tab_entries = { };
	local set_entries = { };
	SettingUI.tab_number = 0;
	SettingUI.tab_entries = tab_entries;
	SettingUI.set_entries = set_entries;
	local LineHeight = 16;
	local function RefreshSettingWidget(key)
		if SettingUI:IsShown() then
			local widget = set_entries[key];
			if widget ~= nil then
				widget:SetVal(SET[key]);
			end
		end
	end
	-->		methods
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
		--	[key] = { type, func, range, mod, tab, }
		local setting_metas = {
			--	tab.general
				show_db_icon = {
					'boolean',
					function(val)
						SET['show_db_icon'] = val;
						if val then
							LibStub("LibDBIcon-1.0", true):Show(__addon);
						else
							LibStub("LibDBIcon-1.0", true):Hide(__addon);
						end
						RefreshSettingWidget('show_db_icon');
					end,
					nil,
					boolean_func,
					'tab.general',
				},
				show_buttons_in_log = {
					'boolean',
					function(val)
						SET['show_buttons_in_log'] = val;
						__ns.SetQuestLogFrameButtonShown(val);
						RefreshSettingWidget('show_buttons_in_log');
					end,
					nil,
					boolean_func,
					'tab.general',
				},
				show_id_in_tooltip = {
					'boolean',
					function(val)
						SET['show_id_in_tooltip'] = val;
						RefreshSettingWidget('show_id_in_tooltip');
					end,
					nil,
					boolean_func,
					'tab.general',
				},
			--	tab.map
				show_in_continent = {
					'boolean',
					function(val)
						SET['show_in_continent'] = val;
						__ns.SetShowPinInContinent();
						RefreshSettingWidget('show_in_continent');
						return true;
					end,
					nil,
					boolean_func,
					'tab.map',
				},
				show_quest_starter = {
					'boolean',
					function(val)
						SET['show_quest_starter'] = val;
						__ns.SetQuestStarterShown();
						RefreshSettingWidget('show_quest_starter');
						return true;
					end,
					nil,
					boolean_func,
					'tab.map',
				},
				show_quest_ender = {
					'boolean',
					function(val)
						SET['show_quest_ender'] = val;
						__ns.SetQuestEnderShown();
						RefreshSettingWidget('show_quest_ender');
						return true;
					end,
					nil,
					boolean_func,
					'tab.map',
				},
				worldmap_alpha = {
					'number',
					function(val)
						val = tonumber(val);
						if val ~= nil then
							SET['worldmap_alpha'] = val;
							__ns.SetWorldmapAlpha();
							RefreshSettingWidget('worldmap_alpha');
							return true;
						end
					end,
					{ 0.0, 1.0, 0.05, },
					round_func_table[2],
					'tab.map',
				},
				minimap_alpha = {
					'number',
					function(val)
						val = tonumber(val);
						if val ~= nil then
							SET['minimap_alpha'] = val;
							__ns.SetMinimapAlpha();
							RefreshSettingWidget('minimap_alpha');
							return true;
						end
					end,
					{ 0.0, 1.0, 0.05, },
					round_func_table[2],
					'tab.map',
				},
				pin_size = {
					'number',
					function(val)
						val = tonumber(val);
						if val ~= nil then
							SET['pin_size'] = val;
							__ns.SetCommonPinSize();
							RefreshSettingWidget('pin_size');
							return true;
						end
					end,
					{ 8, 32, 1, },
					round_func_table[0],
					'tab.map',
				},
				large_size = {
					'number',
					function(val)
						val = tonumber(val);
						if val ~= nil then
							SET['large_size'] = val;
							__ns.SetLargePinSize();
							RefreshSettingWidget('large_size');
							return true;
						end
					end,
					{ 8, 64, 1, },
					round_func_table[0],
					'tab.map',
				},
				varied_size = {
					'number',
					function(val)
						val = tonumber(val);
						if val ~= nil then
							SET['varied_size'] = val;
							__ns.SetVariedPinSize();
							RefreshSettingWidget('varied_size');
							return true;
						end
					end,
					{ 8, 32, 1, },
					round_func_table[0],
					'tab.map',
				},
				pin_scale_max = {
					'number',
					function(val)
						val = tonumber(val);
						if val ~= nil then
							SET['pin_scale_max'] = val;
							RefreshSettingWidget('pin_scale_max');
							return true;
						end
					end,
					{ 1.0, 2.0, 0.05, },
					round_func_table[2],
					'tab.map',
				},
				quest_lvl_lowest_ofs = {
					'number',
					function(val)
						val = tonumber(val);
						if val ~= nil then
							SET['quest_lvl_lowest_ofs'] = val;
							__ns.UpdateQuestGivers();
							RefreshSettingWidget('quest_lvl_lowest_ofs');
							return true;
						end
					end,
					{ -__ns.__maxLevel - 10, 0, 1, },
					round_func_table[0],
					'tab.map',
				},
				quest_lvl_highest_ofs = {
					'number',
					function(val)
						val = tonumber(val);
						if val ~= nil then
							SET['quest_lvl_highest_ofs'] = val;
							__ns.UpdateQuestGivers();
							RefreshSettingWidget('quest_lvl_highest_ofs');
							return true;
						end
					end,
					{ 0, __ns.__maxLevel + 10, 1, },
					round_func_table[0],
					'tab.map',
				},
				hide_node_modifier = {
					'list',
					function(val)
						SET['hide_node_modifier'] = val;
						__ns.SetHideNodeModifier();
						RefreshSettingWidget('hide_node_modifier');
					end,
					{ "SHIFT", "CTRL", "ALT", },
					nil,
					'tab.map',
				},
				minimap_node_inset = {
					'boolean',
					function(val)
						SET['minimap_node_inset'] = val;
						__ns.SetMinimapNodeInset();
						return true;
					end,
					nil,
					boolean_func,
					'tab.map',
				},
				minimap_player_arrow_on_top = {
					'boolean',
					function(val)
						SET['minimap_player_arrow_on_top'] = val;
						__ns.SetMinimapPlayerArrowOnTop();
						return true;
					end,
					nil,
					boolean_func,
					'tab.map',
				},
				limit_item_starter_drop = {
					'boolean',
					function(val)
						SET['limit_item_starter_drop'] = val;
						__ns.SetLimitItemStarter();
						return true;
					end,
					nil,
					boolean_func,
					'tab.map',
				},
			--	tab.interact
				auto_accept = {
					'boolean',
					function(val)
						SET['auto_accept'] = val;
						RefreshSettingWidget('auto_accept');
					end,
					nil,
					boolean_func,
					'tab.interact',
				},
				auto_complete = {
					'boolean',
					function(val)
						SET['auto_complete'] = val;
						RefreshSettingWidget('auto_complete');
					end,
					nil,
					boolean_func,
					'tab.interact',
				},
				quest_auto_inverse_modifier = {
					'list',
					function(val)
						SET['quest_auto_inverse_modifier'] = val;
						__ns.SetQuestAutoInverseModifier(val);
						RefreshSettingWidget('quest_auto_inverse_modifier');
					end,
					{ "SHIFT", "CTRL", "ALT", },
					nil,
					'tab.interact',
				},
				objective_tooltip_info = {
					'boolean',
					function(val)
						SET['objective_tooltip_info'] = val;
						RefreshSettingWidget('objective_tooltip_info');
					end,
					nil,
					boolean_func,
					'tab.interact',
				},
			--	tab.misc
		};
		local function ResetAll()
			__ns.core_reset();
			__ns.map_reset();
			__ns.UpdateQuests();
			__ns.UpdateQuestGivers();
			__ns.MapHideNodes();
		end
		function __ns.Setting(key, val)
			if key == 'reset' then
				ResetAll();
			else
				local meta = setting_metas[key];
				if meta ~= nil then
					if meta[1] == 'number' then
						local bound = meta[3];
						if val < bound[1] then
							val = bound[1];
						elseif val > bound[2] then
							val = bound[2];
						end
						if meta[4] ~= nil then
							val = meta[4](val);
						end
						if meta[2](val) then
							print("SET", key, val);
							local widget = set_entries[key];
							if widget ~= nil then
								widget:SetVal(val);
							end
						end
					elseif meta[1] == 'boolean' then
						if meta[4] ~= nil then
							val = meta[4](val);
						end
						if meta[2](val) then
							print("SET", key, val);
						end
					end
				end
			end
		end
	-->		extern method
		_G.CodexLiteSetting = __ns.Setting;
		--	/run CodexLiteSetting('quest_lvl_lowest_ofs', -20)
		--	/run CodexLiteSetting('reset')
	-->		events and hooks
	-->
	local def = {
		--	general
			show_db_icon = true,
			show_buttons_in_log = true,
			show_id_in_tooltip = true,
		--	map
			show_in_continent = false,
			show_quest_starter = true,
			show_quest_ender = true,
			min_rate = 1.0,
			worldmap_alpha = 1.0,
			minimap_alpha = 1.0,
			pin_size = 15,
			large_size = 24,
			varied_size = 20,
			pin_scale_max = 1.25,
			quest_lvl_lowest_ofs = -6,		--	>=
			quest_lvl_highest_ofs = 1,		--	<=
			hide_node_modifier = "SHIFT",
			minimap_node_inset = true,
			minimap_player_arrow_on_top = true,
			limit_item_starter_drop = true,
		--	interact
			auto_accept = false,
			auto_complete = false,
			quest_auto_inverse_modifier = "SHIFT",
			objective_tooltip_info = true,
		--	misc
			show_minimappin = true,
			show_worldmappin = true,
	};
	local setting_keys = {
		--	general
			"show_db_icon",
			"show_buttons_in_log",
			"show_id_in_tooltip",
		--	map
			"show_in_continent",
			"show_quest_starter",
			"show_quest_ender",
			-- "min_rate",
			"worldmap_alpha",
			"minimap_alpha",
			"pin_size",
			"large_size",
			"varied_size",
			"pin_scale_max",
			"quest_lvl_lowest_ofs",
			"quest_lvl_highest_ofs",
			"hide_node_modifier",
			"minimap_node_inset",
			"minimap_player_arrow_on_top",
			"limit_item_starter_drop",
		--	interact
			"auto_accept",
			"auto_complete",
			"quest_auto_inverse_modifier",
			"objective_tooltip_info",
		--	misc
	};
	-->
		local function Slider_OnValueChanged(self, val, userInput)
			if userInput and self.func then
				if self.mod ~= nil then
					val = self.mod(val);
				end
				self.func(val);
				self:SetStr(val);
			end
		end
		local function Check_OnClick(self, button)
			local val = self:GetChecked();
			if self.mod ~= nil then
				val = self.mod(val);
			end
			self.func(val);
		end
		local function ListCheck_OnClick(self, button)
			local val = self.val;
			if self.mod ~= nil then
				val = self.mod(val);
			end
			self.func(val);
		end
		local function Tab_OnClick(Tab)
			local SelectedTab = SettingUI.SelectedTab;
			if SelectedTab ~= Tab then
				if SelectedTab ~= nil then
					SelectedTab.Sel:Hide();
					SelectedTab.Panel:Hide();
				end
				Tab.Sel:Show();
				Tab.Panel:Show();
				SettingUI.SelectedTab = Tab;
			end
		end
		local function AddTab(tab)
			tab = tab or 'tab.general';
			local Tab = tab_entries[tab];
			if Tab == nil then
				Tab = CreateFrame('BUTTON', nil, SettingUI);
				tab_entries[tab] = Tab;
				local Panel = CreateFrame('FRAME', nil, SettingUI);
				Panel:SetPoint("BOTTOMLEFT", 6, 6);
				Panel:SetPoint("TOPRIGHT", -6, -64);
				Panel:Hide();
				Tab.Panel = Panel;
				Tab:SetSize(64, 24);
				local Text = Tab:CreateFontString(nil, "OVERLAY", "GameFontNormal");
				Text:SetPoint("CENTER");
				Tab.Text = Text;
				local Sel = Tab:CreateTexture(nil, "OVERLAY");
				Sel:SetAllPoints();
				Sel:SetBlendMode("ADD");
				Sel:SetColorTexture(0.25, 0.5, 0.5, 0.5);
				Sel:Hide();
				Tab.Sel = Sel;
				local NTex = Tab:CreateTexture(nil, "ARTWORK");
				Tab:SetNormalTexture(NTex);
				NTex:SetAllPoints();
				NTex:SetColorTexture(0.25, 0.25, 0.25, 0.5);
				local PTex = Tab:CreateTexture(nil, "ARTWORK");
				Tab:SetPushedTexture(PTex);
				PTex:SetAllPoints();
				PTex:SetColorTexture(0.15, 0.25, 0.25, 0.5);
				local HTex = Tab:CreateTexture(nil, "ARTWORK");
				Tab:SetHighlightTexture(HTex);
				HTex:SetAllPoints();
				HTex:SetColorTexture(0.25, 0.25, 0.25, 1.0);
				Tab:SetPoint("TOPLEFT", SettingUI, "TOPLEFT", 4 + 68 * SettingUI.tab_number, -32);
				SettingUI.tab_number = SettingUI.tab_number + 1;
				SettingUI:SetWidth(min(max(SettingUI:GetWidth(), 4 + 68 * SettingUI.tab_number), 1024));
				--
				Tab:SetScript("OnClick", Tab_OnClick);
				Panel.pos = 0;
				Tab.Text:SetText(__UILOC[tab] or tab);
			end
			return Tab, Tab.Panel;
		end
		local function AddSetting(key)
			local meta = setting_metas[key];
			local Tab, Panel = AddTab(meta[5]);
			if meta[1] == 'number' then
				local bound = meta[3];
				local head = Panel:CreateTexture(nil, "ARTWORK");
				head:SetSize(24, 24);
				local label = Panel:CreateFontString(nil, "ARTWORK");
				label:SetFont(_font, _fontsize, "NORMAL");
				label:SetText(gsub(__UILOC[key], "%%[a-z]", ""));
				label:SetPoint("LEFT", head, "RIGHT", 2, 0);
				local slider = CreateFrame('SLIDER', nil, Panel, "OptionsSliderTemplate");
				slider:SetWidth(240);
				slider:SetHeight(15);
				slider:SetMinMaxValues(bound[1], bound[2])
				slider:SetValueStep(bound[3]);
				slider:SetObeyStepOnDrag(true);
				slider:SetPoint("LEFT", head, "CENTER", 10, -LineHeight - 2);
				slider.Text:ClearAllPoints();
				slider.Text:SetPoint("TOP", slider, "BOTTOM", 0, 3);
				slider.Low:ClearAllPoints();
				slider.Low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 4, 3);
				slider.Low:SetVertexColor(0.5, 1.0, 0.5);
				slider.Low:SetText(bound[1]);
				slider.High:ClearAllPoints();
				slider.High:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -4, 3);
				slider.High:SetVertexColor(1.0, 0.5, 0.5);
				slider.High:SetText(bound[2]);
				slider.key = key;
				slider.head = head;
				slider.label = label;
				slider.func = meta[2];
				slider.mod = meta[4];
				slider:HookScript("OnValueChanged", Slider_OnValueChanged);
				function slider:SetVal(val)
					self:SetValue(val);
					self:SetStr(val);
				end
				function slider:SetStr(val)
					self.Text:SetText(val);
					local diff = val - def[key];
					if diff > 0.0000001 then
						self.Text:SetVertexColor(1.0, 0.25, 0.25);
					elseif diff < -0.0000001 then
						self.Text:SetVertexColor(0.25, 1.0, 0.25);
					else
						self.Text:SetVertexColor(1.0, 1.0, 1.0);
					end
				end
				slider._SetPoint = slider.SetPoint;
				function slider:SetPoint(...)
					self.head:SetPoint(...);
				end
				set_entries[key] = slider;
				head:SetPoint("CENTER", Panel, "TOPLEFT", 32, -10 - Panel.pos * LineHeight);
				Panel.pos = Panel.pos + 3;
			elseif meta[1] == 'boolean' then
				local check = CreateFrame('CHECKBUTTON', nil, Panel, "OptionsBaseCheckButtonTemplate");
				check:SetSize(24, 24);
				check:SetHitRectInsets(0, 0, 0, 0);
				check:Show();
				check.func = meta[2];
				check.mod = meta[4];
				check:SetScript("OnClick", Check_OnClick);
				function check:SetVal(val)
					self:SetChecked(val);
				end
				local label = Panel:CreateFontString(nil, "ARTWORK");
				label:SetFont(_font, _fontsize, "NORMAL");
				label:SetText(gsub(__UILOC[key], "%%[a-z]", ""));
				label:SetPoint("LEFT", check, "RIGHT", 2, 0);
				set_entries[key] = check;
				check:SetPoint("CENTER", Panel, "TOPLEFT", 32, -10 - Panel.pos * LineHeight);
				Panel.pos = Panel.pos + 1.5;
			elseif meta[1] == 'list' then
				local head = Panel:CreateTexture(nil, "ARTWORK");
				head:SetSize(24, 24);
				local label = Panel:CreateFontString(nil, "ARTWORK");
				label:SetFont(_font, _fontsize, "NORMAL");
				label:SetText(gsub(__UILOC[key], "%%[a-z]", ""));
				label:SetPoint("LEFT", head, "RIGHT", 2, 0);
				local list = {  };
				local vals = meta[3];
				for index, val in next, vals do
					local check = CreateFrame('CHECKBUTTON', nil, Panel, "OptionsBaseCheckButtonTemplate");
					check:SetSize(24, 24);
					check:SetPoint("LEFT", head, "CENTER", 18 + (index - 1) * 80, -LineHeight * 1.5);
					check:SetHitRectInsets(0, 0, 0, 0);
					check:Show();
					check.func = meta[2];
					check.mod = meta[4];
					check:SetScript("OnClick", ListCheck_OnClick);
					check.list = list;
					check.index = index;
					check.val = val;
					list[index] = check;
					local text = Panel:CreateFontString(nil, "ARTWORK");
					text:SetFont(_font, _fontsize, "NORMAL");
					text:SetText(val);
					text:SetPoint("LEFT", check, "RIGHT", 2, 0);
					check.text = text;
				end
				function list:SetVal(val)
					for index, v in next, vals do
						list[index]:SetChecked(v == val);
					end
				end
				list._SetPoint = list.SetPoint;
				function list:SetPoint(...)
					self.head:SetPoint(...);
				end
				set_entries[key] = list;
				head:SetPoint("CENTER", Panel, "TOPLEFT", 32, -10 - Panel.pos * LineHeight);
				Panel.pos = Panel.pos + 3;
			end
			SettingUI:SetHeight(min(max(SettingUI:GetHeight(), 10 + Panel.pos * LineHeight + 10 + 64), 1024));
		end
		local function ButtonDeleteOnClick(Delete)
			local quest = __ns.__quest_permanently_bl_list[Delete:GetParent().__data_index];
			if quest ~= nil then
				__ns.MapPermanentlyShowQuestNodes(quest);
				SettingUI.BlockedList:SetNumValue(#__ns.__quest_permanently_bl_list);
			end
		end
		local function funcToCreateButton(parent, index, height)
			local Button = CreateFrame('BUTTON', nil, parent);
			Button:SetHeight(height);
			local Delete = CreateFrame('BUTTON', nil, Button);
			Delete:SetNormalTexture(IMG_CLOSE);
			Delete:SetPushedTexture(IMG_CLOSE);
			Delete:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
			Delete:SetHighlightTexture(IMG_CLOSE);
			Delete:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
			Delete:SetSize(height - 4, height - 4);
			Delete:SetPoint("LEFT", 4, 0);
			Delete:SetScript("OnClick", ButtonDeleteOnClick);
			Button.Delete = Delete;
			Button.Text = Button:CreateFontString(nil, "ARTWORK", "GameFontNormal");
			Button.Text:SetPoint("LEFT", Delete, "RIGHT", 4, 0);
			return Button;
		end
		local function functToSetButton(Button, data_index)
			Button.__data_index = data_index;
			local quest = __ns.__quest_permanently_bl_list[data_index];
			if quest ~= nil then
				Button.Text:SetText(__ns.GetQuestTitle(quest, true));
				Button:Show();
			else
				Button:Hide();
			end
		end
		function __ns.RefreshBlockedList()
			if SettingUI:IsShown() then
				SettingUI.BlockedList:SetNumValue(#__ns.__quest_permanently_bl_list);
			end
		end
		function __ns.InitSettingUI()
			tinsert(UISpecialFrames, "CODEX_LITE_SETTING_UI");
			SettingUI:SetSize(320, 360);
			SettingUI:SetFrameStrata("DIALOG");
			SettingUI:SetPoint("CENTER");
			SettingUI:EnableMouse(true);
			SettingUI:SetMovable(true);
			SettingUI:RegisterForDrag("LeftButton");
			SettingUI:SetScript("OnDragStart", function(self)
				self:StartMoving();
			end);
			SettingUI:SetScript("OnDragStop", function(self)
				self:StopMovingOrSizing();
			end);
			SettingUI:Hide();
			--
			local BG = SettingUI:CreateTexture(nil, "BACKGROUND");
			BG:SetAllPoints();
			BG:SetColorTexture(0.0, 0.0, 0.0, 0.9);
			SettingUI.BG = BG;
			--
			local Title = SettingUI:CreateFontString(nil, "ARTWORK", "GameFontNormal");
			Title:SetPoint("CENTER", SettingUI, "TOP", 0, -16);
			Title:SetText(__UILOC.TAG_SETTING or __addon);
			--
			local close = CreateFrame('BUTTON', nil, SettingUI);
			close:SetSize(16, 16);
			close:SetNormalTexture(IMG_CLOSE);
			-- close:GetNormalTexture():SetTexCoord(4 / 32, 28 / 32, 4 / 32, 28 / 32);
			close:SetPushedTexture(IMG_CLOSE);
			-- close:GetPushedTexture():SetTexCoord(4 / 32, 28 / 32, 4 / 32, 28 / 32);
			close:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
			close:SetHighlightTexture(IMG_CLOSE);
			-- close:GetHighlightTexture():SetTexCoord(4 / 32, 28 / 32, 4 / 32, 28 / 32);
			close:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.5, 0.5);
			close:SetPoint("TOPRIGHT", SettingUI, "TOPRIGHT", -4, -4);
			close:SetScript("OnClick", function(self)
				self.SettingUI:Hide();
			end);
			close.SettingUI = SettingUI;
			SettingUI.close = close;
			--
			for _, key in next, setting_keys do
				AddSetting(key);
			end
			local Tab, Panel = AddTab('tab.blocked');
			Panel.Scr = ALASCR(Panel, Panel:GetWidth(), Panel:GetHeight(), LineHeight, funcToCreateButton, functToSetButton);
			Panel.Scr:SetPoint("CENTER");
			Panel.Scr:SetMouseClickEnabled(false);
			SettingUI.BlockedList = Panel.Scr;
			--
			SettingUI:SetScript("OnShow", function()
				for key, widget in next, set_entries do
					widget:SetVal(SET[key]);
				end
				SettingUI.BlockedList:SetNumValue(#__ns.__quest_permanently_bl_list);
			end);
			Tab_OnClick(tab_entries['tab.general'] or select(2, next(tab_entries)));
		end
	-->
	function __ns.setting_setup()
		local GUID = __core._PLAYER_GUID;
		local SV = _G.CodexLiteSV;
		if SV == nil or SV.__version == nil or SV.__version < 20210529.0 then
			SV = {
				setting = def,
				minimap = {
					minimapPos = 0.0,
				},
				quest_temporarily_blocked = {
					[GUID] = {  },
				},
				quest_permanently_blocked = {
					[GUID] = {  },
				},
				quest_permanently_bl_list = {
					[GUID] = {  },
				},
				__version = 20210612.0,
			};
			_G.CodexLiteSV = SV;
			SET = SV.setting;
		else
			if SV.__version < 20210610.0 then
				SV.__version = 20210610.0;
				SV.quest_temporarily_blocked = SV.mapquestblocked;
				SV.mapquestblocked = nil;
			end
			if SV.__version < 20210612.0 then
				SV.__version = 20210612.0;
				SV.quest_permanently_blocked = {  };
				SV.quest_permanently_bl_list = {  };
				SV.setting.objective_tooltip_info = SV.setting.tip_info;
			end
			SET = SV.setting;
			for key, val in next, def do
				if SET[key] == nil then
					SET[key] = val;
				end
			end
			SV.quest_temporarily_blocked[GUID] = SV.quest_temporarily_blocked[GUID] or {  };
			SV.quest_permanently_blocked[GUID] = SV.quest_permanently_blocked[GUID] or {  };
			SV.quest_permanently_bl_list[GUID] = SV.quest_permanently_bl_list[GUID] or {  };
		end
		if SV.__overridedev == false then
			__ns.__is_dev = false;
		end
		SET.quest_lvl_green = -1;
		SET.quest_lvl_yellow = -1;
		SET.quest_lvl_orange = -1;
		SET.quest_lvl_red = -1;
		__ns.__svar = SV;
		__ns.__setting = SET;
		__ns.__quest_temporarily_blocked = SV.quest_temporarily_blocked[GUID];
		__ns.__quest_permanently_blocked = SV.quest_permanently_blocked[GUID];
		__ns.__quest_permanently_bl_list = SV.quest_permanently_bl_list[GUID];
		__ns.InitSettingUI();
	end
-->

-->		SLASH
	local strfind, strlower = strfind, strlower;
	_G.SLASH_ALAQUEST1 = "/alaquest";
	_G.SLASH_ALAQUEST2 = "/alaq";
	_G.SLASH_ALAQUEST3 = "/codexlite";
	_G.SLASH_ALAQUEST4 = "/cdxl";
	local SEPARATOR = "[ %`%~%!%@%#%$%%%^%&%*%(%)%-%_%=%+%[%{%]%}%\\%|%;%:%\'%\"%,%<%.%>%/%?]*";
	local SET_PATTERN = "^" .. SEPARATOR .. "set" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$";
	local UI_PATTERN = "^" .. SEPARATOR .. "ui" .. SEPARATOR .. "(.+)" .. SEPARATOR .. "$";
	SlashCmdList["ALAQUEST"] = function(msg)
		msg = strlower(msg);
		--	set
		local _, pattern;
		_, _, pattern = strfind(msg, SET_PATTERN);
		if pattern then
			return;
		end
		_, _, pattern = strfind(msg, UI_PATTERN);
		if pattern then
			return;
		end
		--	default
		if strfind(msg, "[A-Za-z0-9]+" ) then
		else
		end
		__ns.__ui_setting:Show();
	end
-->


--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.setting'); end

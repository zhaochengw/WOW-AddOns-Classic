--[[--
	by ALA
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

-->		upvalue
	local next = next;
	local select = select;
	local strsplit, strlower, strsub, strmatch = string.split, string.lower, string.sub, string.match;
	local setmetatable = setmetatable;
	local _G = _G;
	local SlashCmdList = SlashCmdList;

-->
	local l10n = CT.l10n;

-->		constant
	CT.DefaultSetting = {
		resizable_border = false,
		singleFrame = true,
		style = 1,
		talents_in_tip = true,
		talents_in_tip_icon = true,
		itemlevel_in_tip = true,
		inspectButtonOnUnitFrame = false,
		show_equipment = true,
		max_recv_msg = 16,
		minimap = true,
		minimapPos = 185,
		autoShowEquipmentFrame = true,
	};
-->
MT.BuildEnv('SETTING');
-->		predef
-->		SETTING
	function MT.SetConfig(key, value)
		VT.SET[key] = value;
		local func = MT.CALLBACK[key];
		if func ~= nil then
			func(value);
		end
	end
	function MT.GetConfig(key)
		return VT.SET[key];
	end
	function MT.OpenSetting()
		if VT.SettingUI == nil then
			local GetDefault = function(module, key)
				return CT.DefaultSetting[key];
			end
			local GetConfig = function(module, key)
				return VT.SET[key];
			end
			local SetConfig = function(module, key, val, loading)
				VT.SET[key] = val;
				if key == "minimap" then
					MT.CALLBACK["minimap"](val);
				elseif key == "singleFrame" then
					if val then
						local last = Frame or MT.UI.GetLastFrame();
						MT.UI.ReleaseAllFramesButOne(last and last.id or nil);
					end
				elseif key == "style" then
					if val == 1 then
						for i = 1, VT.Frames.used do
							MT.UI.FrameSetStyle(VT.Frames[i], 1);
						end
					else
						for i = 1, VT.Frames.used do
							MT.UI.FrameSetStyle(VT.Frames[i], 2);
						end
					end
				end
			end
			local LookupText = function(module, key, extra)
				if key == "style" then
					if extra == nil then
						return "Style";
					elseif extra == 1 then
						return l10n.Setting_TripleTrees;
					elseif extra == 2 then
						return l10n.Setting_SingleTree;
					end
				end
				return "|cffff0000" .. (key or "@key") .. "-" .. (extra or "@extra") .. "|r";
			end
			VT.SettingUI = VT.__dep.__settingfactory:CreateSettingUI(__addon, GetDefault, GetConfig, SetConfig, LookupText);
			local settings = {
				-- { "module", "key", 'boolean', nil, nil, nil, nil, "label", },
				{ "module", "autoShowEquipmentFrame", 'boolean', nil, nil, nil, nil, l10n.Setting_AutoShowEquipmentFrame, },
				{ "module", "minimap", 'boolean', nil, nil, nil, nil, l10n.Setting_IconOnMinimap, },
				{ "module", "resizable_border", 'boolean', nil, nil, nil, nil, l10n.Setting_ResizableBorder, },
				{ "module", "singleFrame", 'boolean', nil, nil, nil, nil, l10n.Setting_SingleFrame, },
				{ "module", "style", 'radio', { 1, 2, }, nil, nil, nil, },
				{ "module", "talents_in_tip", 'boolean', nil, nil, nil, nil, l10n.Setting_TalentsInTip, },
				{ "module", "talents_in_tip_icon", 'boolean', nil, nil, nil, nil, l10n.Setting_TalentsInTipIcon, },
				{ "module", "itemlevel_in_tip", 'boolean', nil, nil, nil, nil, l10n.Setting_ItemLevelInTip, },
			};
			for _, setting in next, settings do
				VT.SettingUI:AddSetting("GENERAL", setting);
			end
			VT.SettingUI:SetMinSize(320, 0);
		end
		VT.SettingUI:Open();
	end

	_G.SLASH_ALATALENTEMU1 = "/TalentEmu";
	_G.SLASH_ALATALENTEMU2 = "/emu";
	local acceptedCommandSeq = { "\ ", "\,", "\;", "\:", "\-", "\+", "\_", "\=", "\/", "\\", "\"", "\'", "\|", "\，", "\。", "\；", "\：", "\、", "\’", "\“", };
	SlashCmdList["ALATALENTEMU"] = function(msg)
		if strlower(strsub(msg, 1, 3)) == "set" then
			for _, seq in next, acceptedCommandSeq do
				if strmatch(msg, seq) then
					MT.SetConfig(select(2, strsplit(seq, msg)));
					return;
				end
			end
			return;
		end
		for _, seq in next, acceptedCommandSeq do
			if strmatch(msg, seq) then
				MT.CreateEmulator(nil, strsplit(seq, msg));
				return;
			end
		end
		MT.CreateEmulator(nil, msg);
	end

	local function DBIcon_OnClick(self, button)
		if button == "LeftButton" then
			MT.CreateEmulator();
		elseif button == "RightButton" then
			MT.ToggleRaidToolUI();
		end
	end
	MT.RegisterOnInit('SETTING', function(LoggedIn)
		local DB = _G.TalentEmuSV;
		if DB == nil or DB._version < 200615.0 then
			DB = {
				set = {  },
				var = { savedTalent = {  }, },
			};
			_G.TalentEmuSV = DB;
		elseif DB._version < 220801.0 then
			local SET = DB.set;
			local VAR = DB.var;
			VAR.savedTalent = VAR.savedTalent or {  };
			DB = {
				set = SET or {  },
				var = VAR or { savedTalent = {  }, },
			};
			_G.TalentEmuSV = DB;
		end
		DB._version = 220811.0;
		VT.DB = DB;
		VT.SET = setmetatable(DB.set, { __index = CT.DefaultSetting, });
		VT.VAR = DB.var;
		if CT.TOCVERSION >= 30000 then
			DB.map = DB.map or {  };
			DB.map[CT.BUILD] = DB.map[CT.BUILD] or {  };
			VT.MAP = DB.map[CT.BUILD];
		else
			DB.map = nil;
		end
		VT.LOOT = DB.loot;
		MT.MergeGlobal(DB);
	end);
	MT.RegisterOnLogin('SETTING', function(LoggedIn)
		local LibStub = _G.LibStub;
		if LibStub ~= nil then
			--	DBICON
				local LDI = LibStub("LibDBIcon-1.0", true);
				if LDI ~= nil then
					LDI:Register("TalentEmu",
					{
						icon = CT.TEXTUREICON,
						OnClick = DBIcon_OnClick,
						text = l10n.DBIcon_Text,
						OnTooltipShow = function(tt)
								tt:AddLine("TalentEmu");
								tt:AddLine(" ");
								for _, text in next, l10n.TooltipLines do
									tt:AddLine(text);
								end
							end
					},
					{
						minimapPos = VT.SET.minimapPos,
					}
					);
					local mb = LDI:GetMinimapButton("TalentEmu");
					mb:RegisterEvent("PLAYER_LOGOUT");
					mb:HookScript("OnEvent", function(self)
						VT.SET.minimapPos = self.minimapPos or self.db.minimapPos;
					end);
					mb:HookScript("OnDragStop", function(self)
						VT.SET.minimapPos = self.minimapPos or self.db.minimapPos;
					end);
					if VT.SET.minimap then
						LDI:Show("TalentEmu");
					else
						LDI:Hide("TalentEmu");
					end
					MT.CALLBACK["minimap"] = function(on)
						if on then
							LDI:Show("TalentEmu");
						else
							LDI:Hide("TalentEmu");
						end
					end
				end
			--	LDB
				local LDB = LibStub:GetLibrary("LibDataBroker-1.1");
				if LDB ~= nil then
					local obj = LDB:NewDataObject("TalentEmu", {
						type = "launcher",
						icon = CT.TEXTUREICON,
						OnClick = DBIcon_OnClick,
						OnTooltipShow = function(tt)
							tt:AddLine("TalentEmu");
							tt:AddLine(" ");
							tt:AddLine(l10n.DBIcon_Text);
							-- for _, text in next, l10n.TooltipLines do
							-- 	tt:AddLine(text);
							-- end
							tt:Show();
						end,
					});
				end
		end
	end);

-->

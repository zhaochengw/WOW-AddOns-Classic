--[[--
	by ALA
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

--		upvalue
	local next = next;
	local select = select;
	local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
	local GetTalentInfo = GetTalentInfo;
	local GetAddOnInfo, IsAddOnLoaded = GetAddOnInfo, IsAddOnLoaded;
	local IsShiftKeyDown = IsShiftKeyDown;
	local CreateFrame = CreateFrame;
	local _G = _G;
	local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend;
	local PanelTemplates_GetSelectedTab = PanelTemplates_GetSelectedTab;
	local UIParent = UIParent;

-->
	local l10n = CT.l10n;

-->		constant
-->
MT.BuildEnv('MISC');
-->		predef
-->		MISC
	--
	--	popup

		VT.__dep.__poplib:AddMethod("QUERY_TALENT", {
			GetText = function() return l10n.PopupQuery; end,
			IsShown = function() return true; end,
			OnClick = function(def, which, context)
				MT.SendQueryRequest(context.name, context.server, true, true);
			end,
		});
		VT.__dep.__poplib:AddEntry("SELF", "QUERY_TALENT");
		VT.__dep.__poplib:AddEntry("_BRFF_SELF", "QUERY_TALENT");
		VT.__dep.__poplib:AddEntry("PLAYER", "QUERY_TALENT");
		VT.__dep.__poplib:AddEntry("FRIEND", "QUERY_TALENT");
		VT.__dep.__poplib:AddEntry("FRIEND_OFFLINE", "QUERY_TALENT");
		VT.__dep.__poplib:AddEntry("PARTY", "QUERY_TALENT");
		VT.__dep.__poplib:AddEntry("_BRFF_PARTY", "QUERY_TALENT");
		VT.__dep.__poplib:AddEntry("RAID", "QUERY_TALENT");
		VT.__dep.__poplib:AddEntry("RAID_PLAYER", "QUERY_TALENT");
		VT.__dep.__poplib:AddEntry("_BRFF_RAID_PLAYER", "QUERY_TALENT");
		VT.__dep.__poplib:AddEntry("CHAT_ROSTER", "QUERY_TALENT");
		VT.__dep.__poplib:AddEntry("GUILD", "QUERY_TALENT");

	--
	--	TalentFrameCall
		local _TalentFrame = nil;
		local Orig_TalentFrameTalent_OnClick = nil;
		local function _TalentFrameTalent_OnClick(self, mouseButton)
			if IsShiftKeyDown() then
				local Map = VT.__dep.__emulib.GetTalentMap(CT.SELFCLASS);
				if Map ~= nil then
					local TreeIndex, TalentIndex = PanelTemplates_GetSelectedTab(_TalentFrame), self:GetID();
					local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(TreeIndex, TalentIndex);
					local SpellID = MT.QueryTalentSpellID(CT.SELFCLASS, TreeIndex, Map.RMap[TreeIndex][TalentIndex], rank);
					local link = VT._comptb._GetSpellLink(SpellID, name);
					if link ~= nil then
						local editBox = ChatEdit_ChooseBoxForSend();
						editBox:Show();
						editBox:SetFocus();
						editBox:Insert(link);
					end
					return;
				end
			end
			return Orig_TalentFrameTalent_OnClick(self, mouseButton);
		end
		local TalentFrameTalents = {  };
		local function HookTalentFrame(self, event, addon)
			if addon == "Blizzard_TalentUI" then
				if self ~= nil then
					self:UnregisterEvent("ADDON_LOADED");
					self:SetScript("OnEvent", nil);
				end

				_TalentFrame = _G.TalentFrame or _G.PlayerTalentFrame;
				Orig_TalentFrameTalent_OnClick = _G.TalentFrameTalent_OnClick or _G.PlayerTalentFrameTalent_OnClick;
				if _G.TalentFrame ~= nil then
					for i = 1, 999 do
						local b = _G["TalentFrameTalent" .. i];
						if b then
							b:SetScript("OnClick", _TalentFrameTalent_OnClick);
							TalentFrameTalents[i] = b;
						else
							break;
						end
					end

					local button = CreateFrame('BUTTON', nil, _TalentFrame, "UIPanelButtonTemplate");
					button:SetSize(80, 20);
					button:SetPoint("RIGHT", _G.TalentFrameCloseButton, "LEFT", -2, 0);
					button:SetText(l10n.TalentFrameCallButtonString);
					button:SetScript("OnClick", function() MT.CreateEmulator(); end);
					button:SetScript("OnEnter", MT.GeneralOnEnter);
					button:SetScript("OnLeave", MT.GeneralOnLeave);
					button.information = l10n.TalentFrameCallButton;
					_TalentFrame.__TalentEmuCall = button;
				elseif _G.PlayerTalentFrame ~= nil then
					for i = 1, 999 do
						local b = _G["PlayerTalentFrameTalent" .. i];
						if b then
							b:SetScript("OnClick", _TalentFrameTalent_OnClick);
							TalentFrameTalents[i] = b;
						else
							break;
						end
					end

					local button = CreateFrame('BUTTON', nil, _TalentFrame, "UIPanelButtonTemplate");
					button:SetSize(80, 20);
					button:SetPoint("RIGHT", _G.PlayerTalentFrameCloseButton, "LEFT", -2, 0);
					button:SetText(l10n.TalentFrameCallButtonString);
					button:SetScript("OnClick", function() MT.CreateEmulator(); end);
					button:SetScript("OnEnter", MT.GeneralOnEnter);
					button:SetScript("OnLeave", MT.GeneralOnLeave);
					button.information = l10n.TalentFrameCallButton;
					_TalentFrame.__TalentEmuCall = button;
					VT.__dep.autostyle:AddReskinObject(button);
				end
			end
		end

		if IsAddOnLoaded("Blizzard_TalentUI") then
			HookTalentFrame(nil, nil, "Blizzard_TalentUI");
		else
			local Agent = CreateFrame('FRAME');
			Agent:RegisterEvent("ADDON_LOADED");
			Agent:SetScript("OnEvent", HookTalentFrame);
			Agent = nil;
		end
	--

	local trytimes = 0;
	local function _PerdiocGenerateTitle()
		local halt = true;
		for index = 1, VT.SaveButtonMenuAltDefinition.num do
			local Def = VT.SaveButtonMenuAltDefinition[index];
			if Def.text == nil then
				local lClass, class, lRace, race, sex, name, realm = GetPlayerInfoByGUID(Def.param[1]);
				if class ~= nil and name ~= nil then
					Def.text = "|c" .. CT.RAID_CLASS_COLORS[class].colorStr .. name .. "|r";
					Def.param[3] = name;
				else
					halt = false;
				end
			end
		end
		trytimes = trytimes + 1;
		if halt or trytimes > 10 then
			MT._TimerHalt(_PerdiocGenerateTitle);
		end
	end
	local function _StorePlayerData()
		if VT.__support_glyph then
			VT.VAR[CT.SELFGUID] = VT.__dep.__emulib.EncodePlayerTalentDataV2() .. VT.__dep.__emulib.EncodePlayerGlyphDataV2() .. VT.__dep.__emulib.EncodePlayerEquipmentDataV2();
		elseif VT.__support_engraving then
			VT.VAR[CT.SELFGUID] = VT.__dep.__emulib.EncodePlayerTalentDataV2() .. VT.__dep.__emulib.EncodePlayerEquipmentDataV2() .. VT.__dep.__emulib.EncodePlayerEngravingDataV2();
		else
			VT.VAR[CT.SELFGUID] = VT.__dep.__emulib.EncodePlayerTalentDataV2() .. VT.__dep.__emulib.EncodePlayerEquipmentDataV2();
		end
		for index = 1, VT.SaveButtonMenuAltDefinition.num do
			if VT.SaveButtonMenuAltDefinition[index].param[1] == CT.SELFGUID then
				VT.SaveButtonMenuAltDefinition[index].param[2] = VT.VAR[CT.SELFGUID];
			end
		end
		MT.Debug("StorePlayerData");
	end
	MT.RegisterOnInit('MISC', function(LoggedIn)
	end);
	MT.RegisterOnLogin('MISC', function(LoggedIn)
		if CT.TOCVERSION >= 30000 then
			local Map = VT.__dep.__emulib.GetTalentMap(CT.SELFCLASS);
			VT.MAP[CT.SELFCLASS] = { VMap = Map.VMap, RMap = Map.RMap, };
		end
		--
		for GUID, code in next, VT.VAR do
			if GUID ~= "savedTalent" then
				VT.SaveButtonMenuAltDefinition.num = VT.SaveButtonMenuAltDefinition.num + 1;
				VT.SaveButtonMenuAltDefinition[VT.SaveButtonMenuAltDefinition.num] = {
					param = { GUID, code, },
				};
			end
		end
		MT._TimerStart(_PerdiocGenerateTitle, 0.5);
		--
		local Driver = CreateFrame('FRAME', nil, UIParent);
		Driver:RegisterEvent("CONFIRM_TALENT_WIPE");
		--	Fires when the user selects the "Yes, I do." confirmation prompt after speaking to a class trainer and choosing to unlearn their talents.
		--	Payload	number:cost	number:respecType
		--	inexistent	Driver:RegisterEvent("PLAYER_TALENT_UPDATE");
		--	inexistent	Driver:RegisterEvent("PLAYER_LEARN_TALENT_FAILED");
		--	inexistent	Driver:RegisterEvent("TALENTS_INVOLUNTARILY_RESET");
		--	inexistent	Driver:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");
		Driver:RegisterEvent("CHARACTER_POINTS_CHANGED");
		--	Fired when the player's available talent points change.
		--	Payload	number:change	-1 indicates one used (learning a talent)	1 indicates one gained (leveling)
		--	SPELLS_CHANGED
		--	Fires when spells in the spellbook change in any way. Can be trivial (e.g.: icon changes only), or substantial (e.g.: learning or unlearning spells/skills).
		--	Payload	none
		Driver:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
		Driver:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", 'player');
		-- Driver:RegisterEvent("PLAYER_LOGOUT");
		if VT.__support_glyph then
			Driver:RegisterEvent("GLYPH_ADDED");
			Driver:RegisterEvent("GLYPH_REMOVED");
			Driver:RegisterEvent("GLYPH_UPDATED");
		end
		if VT.__support_engraving then
			Driver:RegisterEvent("RUNE_UPDATED");
		end
		Driver:SetScript("OnEvent", function(Driver, event)
			MT._TimerStart(_StorePlayerData, 0.1, 1);
		end);
		--
		_StorePlayerData();
	end);

-->

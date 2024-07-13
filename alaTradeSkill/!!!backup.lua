--[[--
	by ALA 
--]]--

local __addon, __private = ...;
local DataAgent = DT.DataAgent;
local l10n = CT.l10n;

local T_uiFrames = __private.T_uiFrames;


-->		****
MT.BuildEnv("external");
-->		****

do	--	supreme craft
	--[==[
		UPDATE_TRADESKILL_RECAST
		UNIT_SPELLCAST_SENT: unit, target, castGUID, spellID
		UNIT_SPELLCAST_START: unitTarget, castGUID, spellID
		--
		UNIT_SPELLCAST_SUCCEEDED: unitTarget, castGUID, spellID
		UNIT_SPELLCAST_STOP: unitTarget, castGUID, spellID
		--
		UNIT_SPELLCAST_INTERRUPTED: unitTarget, castGUID, spellID
		UNIT_SPELLCAST_STOP: unitTarget, castGUID, spellID
		UNIT_SPELLCAST_INTERRUPTED: unitTarget, castGUID, spellID
		UNIT_SPELLCAST_INTERRUPTED: unitTarget, castGUID, spellID
		UNIT_SPELLCAST_INTERRUPTED: unitTarget, castGUID, spellID
	]==]
		function __private.ui_supremeListButton_OnEnter(self)
			local frame = self.frame;
			local sid = self.list[self:GetDataIndex()];
			if type(sid) == 'table' then
				sid = sid[1];
			end
			-- local pid = DataAgent.get_pid_by_pname(frame.pname());
			local pid = self.flag or DataAgent.get_pid_by_sid(sid);
			if pid then
				local set = VT.SET[pid];
				mouse_focus_sid = sid;
				mouse_focus_phase = set.phase;
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				local info = DataAgent.get_info_by_sid(sid);
				if info then
					if set.showItemInsteadOfSpell and info[index_cid] then
						GameTooltip:SetItemByID(info[index_cid]);
					else
						GameTooltip:SetSpellByID(sid);
					end
					local phase = info[index_phase];
					if phase > DataAgent.CURPHASE then
						GameTooltip:AddLine("|cffff0000" .. l10n["AVAILABLE_IN_PHASE_"] .. phase .. "|r");
					end
					GameTooltip:Show();
				else
					GameTooltip:SetSpellByID(sid);
				end
				local text = DataAgent.get_difficulty_rank_list_text_by_sid(sid, true);
				if text then
					GameTooltip:AddDoubleLine(l10n["LABEL_RANK_LEVEL"], text);
					GameTooltip:Show();
				end
				local data = frame.hash[sid];
				if pid == 'explorer' then
					local hash = explorer_hash[sid];
					if hash then
						local str = l10n["RECIPE_LEARNED"] .. ": ";
						local index = 0;
						for GUID, _ in next, hash do
							if index ~= 0 and index % 3 == 0 then
								str = str .. "\n        ";
							end
							local lClass, class, lRace, race, sex, name = GetPlayerInfoByGUID(GUID);
							if name and class then
								local classColorTable = RAID_CLASS_COLORS[strupper(class)];
								name = format("|cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. name .. "|r";
								str = str .. " " .. name;
							else
								str = str .. " " .. GUID;
							end
							index = index + 1;
						end
						GameTooltip:AddLine(str);
						GameTooltip:Show();
					else
					end
					data = data and data[PLAYER_GUID];
				end
				if not data then
					__private.ui_set_tooltip_mtsl(sid);
				end
			end
		end
		function __private.ui_supremeListButton_OnLeave(self)
			mouse_focus_sid = nil;
			button_info_OnLeave(self);
		end
		function __private.ui_supremeListButton_OnClick(self, button)
			local frame = self.frame;
			local sid = self.list[self:GetDataIndex()];
			if type(sid) == 'table' then
				sid = sid[1];
			end
			local data = frame.hash[sid];
			if button == "LeftButton" then
				if IsShiftKeyDown() then
					MT.HandleShiftClick(self.flag or DataAgent.get_pid_by_sid(sid), sid);
				elseif IsAltKeyDown() then
					local text1 = nil;
					local text2 = nil;
					if data then
						local n = frame.reagent_num(data);
						if n and n > 0 then
							local m1, m2 = frame.recipe_num_made(data);
							if m1 == m2 then
								text1 = frame.recipe_link(data) .. "x" .. m1 .. l10n["PRINT_MATERIALS: "];
							else
								text1 = frame.recipe_link(data) .. "x" .. m1 .. "-" .. m2 .. l10n["PRINT_MATERIALS: "];
							end
							text2 = "";
							if n > 4 then
								for i = 1, n do
									text2 = text2 .. frame.reagent_info(data, i) .. "x" .. select(3, frame.reagent_info(data, i));
								end
							else
								for i = 1, n do
									text2 = text2 .. frame.reagent_link(data, i) .. "x" .. select(3, frame.reagent_info(data, i));
								end
							end
						end
					else
						local info = DataAgent.get_info_by_sid(sid);
						local cid = info[index_cid];
						if info then
							if cid then
								text1 = DataAgent.item_link_s(cid) .. "x" .. (info[index_num_made_min] == info[index_num_made_max] and info[index_num_made_min] or (info[index_num_made_min] .. "-" .. info[index_num_made_max])) .. l10n["PRINT_MATERIALS: "];
							else
								text1 = DataAgent.spell_name_s(sid) .. l10n["PRINT_MATERIALS: "];
							end
							text2 = "";
							local rinfo = info[index_reagents_id];
							if #rinfo > 4 then
								for i = 1, #rinfo do
									text2 = text2 .. DataAgent.item_name_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
								end
							else
								for i = 1, #rinfo do
									text2 = text2 .. DataAgent.item_link_s(rinfo[i]) .. "x" .. info[index_reagents_count][i];
								end
							end
						end
					end
					if text1 and text2 then
						local editBox = ChatEdit_ChooseBoxForSend();
						editBox:Show();
						editBox:SetFocus();
						editBox:Insert(text1 .. " " .. text2);
						-- ChatEdit_InsertLink(text1 .. " " .. text2, false);
					end
				elseif IsControlKeyDown() then
					local cid = DataAgent.get_cid_by_sid(sid);
					if cid then
						local link = DataAgent.item_link(cid);
						if link then
							DressUpItemLink(link);
						end
					end
				else
					if data and type(data) == 'number' then
						frame.select_func(data);
						frame.hooked_frame.numAvailable = select(3, frame.recipe_info(data));
						frame.selected_sid = sid;
						frame.F_Update();
						frame.searchEdit:ClearFocus();
						local scroll = frame.hooked_scrollBar;
						local num = frame.recipe_num();
						local minVal, maxVal = scroll:GetMinMaxValues();
						local step = scroll:GetValueStep();
						local cur = scroll:GetValue() + step;
						local value = step * (data - 1);
						if value < cur or value > (cur + num * step - maxVal) then
							scroll:SetValue(min(maxVal, value));
						end
						frame.scroll:Update();
						if frame.profitFrame:IsShown() then
							frame.profitScroll:Update();
						end
					end
				end
			elseif button == "RightButton" then
				frame.searchEdit:ClearFocus();
				local pid = DataAgent.get_pid_by_sid(sid);
				if VT.FAV[sid] then
					list_drop_sub_fav.para[1] = frame;
					list_drop_sub_fav.para[2] = pid;
					list_drop_sub_fav.para[3] = sid;
					list_drop_meta.elements[1] = list_drop_sub_fav;
				else
					list_drop_add_fav.para[1] = frame;
					list_drop_add_fav.para[2] = pid;
					list_drop_add_fav.para[3] = sid;
					list_drop_meta.elements[1] = list_drop_add_fav;
				end
				list_drop_query_who_can_craft_it.para[1] = frame;
				list_drop_query_who_can_craft_it.para[2] = pid;
				list_drop_query_who_can_craft_it.para[3] = sid;
				ALADROP(self, "BOTTOMLEFT", list_drop_meta);
			end
		end
		function __private.ui_CreateSupremeListButton(parent, index, buttonHeight)
			local frame = parent:GetParent():GetParent();

			local button = CreateFrame("BUTTON", nil, parent);
			button:SetHeight(buttonHeight);
			button:SetBackdrop(ui_style.listButtonBackdrop);
			button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
			button:SetBackdropBorderColor(unpack(ui_style.listButtonBackdropBorderColor));
			button:SetHighlightTexture(ui_style.texture_white);
			button:GetHighlightTexture():SetVertexColor(unpack(ui_style.listButtonHighlightColor));
			button:EnableMouse(true);
			button:Show();

			local del = CreateFrame("BUTTON", nil, button);
			del:SetSize(buttonHeight / 2, buttonHeight / 2);
			del:SetPoint("LEFT", 4, 0);
			__private.ui_ModernButton(del, nil, ui_style.texture_modern_button_close);
			del:SetScript("OnClick", frame.del);
			button.del = del;

			local icon = button:CreateTexture(nil, "BORDER");
			icon:SetTexture(ui_style.texture_unk);
			icon:SetSize(buttonHeight - 8, buttonHeight - 8);
			icon:SetPoint("LEFT", del, "RIGHT", 8, 0);
			button.icon = icon;

			local title = button:CreateFontString(nil, "OVERLAY");
			title:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
			title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
			-- title:SetWidth(160);
			title:SetMaxLines(1);
			title:SetJustifyH("LEFT");
			title:SetPoint("LEFT", icon, "RIGHT", 8, 0);
			button.title = title;

			local num = CreateFrame("EDITBOX", nil, button);
			num:SetHeight(16);
			num:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
			num:SetAutoFocus(false);
			num:SetJustifyH("LEFT");
			num:Show();
			num:EnableMouse(true);
			num:ClearFocus();
			num:SetPoint("LEFT", title, "RIGHT", 48, 0);
			local numBG = num:CreateTexture(nil, "ARTWORK");
			numBG:SetPoint("TOPLEFT");
			numBG:SetPoint("BOTTOMRIGHT");
			numBG:SetTexture("Interface\\Buttons\\greyscaleramp64");
			numBG:SetTexCoord(0.0, 0.25, 0.0, 0.25);
			numBG:SetAlpha(0.75);
			numBG:SetBlendMode("ADD");
			numBG:SetVertexColor(0.25, 0.25, 0.25);
			num.BG = numBG;
			num:SetScript("OnEditFocusGained", function(self) self.BG:Show(); end);
			num:SetScript("OnEditFocusLost", function(self) self.BG:Hide(); end);
			num:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
			num:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
			button.num = num;
			
			local up = CreateFrame("BUTTON", nil, button);
			up:SetSize(buttonHeight / 2 - 3, buttonHeight / 2 - 3);
			up:SetPoint("TOPRIGHT", -4, -2);
			__private.ui_ModernButton(up, nil, ui_style.texture_modern_arrow_up);
			up:SetScript("OnClick", frame.change_order_up);
			button.up = up;

			local down = CreateFrame("BUTTON", nil, button);
			down:SetSize(buttonHeight / 2 - 3, buttonHeight / 2 - 3);
			down:SetPoint("BOTTOMRIGHT", -4, 2);
			__private.ui_ModernButton(down, nil, ui_style.texture_modern_arrow_down);
			down:SetScript("OnClick", frame.change_order_down);
			button.down = down;

			local quality_glow = button:CreateTexture(nil, "ARTWORK");
			quality_glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
			quality_glow:SetBlendMode("ADD");
			quality_glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
			quality_glow:SetSize(buttonHeight - 2, buttonHeight - 2);
			quality_glow:SetPoint("CENTER", icon);
			-- quality_glow:SetAlpha(0.75);
			quality_glow:Show();
			button.quality_glow = quality_glow;

			button:SetScript("OnEnter", __private.ui_supremeListButton_OnEnter);
			button:SetScript("OnLeave", __private.ui_supremeListButton_OnLeave);
			button:RegisterForClicks("AnyUp");
			button:SetScript("OnClick", __private.ui_supremeListButton_OnClick);
			button:RegisterForDrag("LeftButton");
			button:SetScript("OnHide", ALADROP);

			button.frame = frame;

			return button;
		end
		function __private.ui_SetSupremeListButton(button, data_index)
			local frame = button.frame;
			local list = frame.list;
			local hash = frame.hash;
			if data_index <= #list then
				local pid = DataAgent.get_pid_by_pname(frame.pname());
				if pid then
					local set = VT.SET[pid];
					local sid = list[data_index];
					local cid = DataAgent.get_cid_by_sid(sid);
					local data = hash[sid];
					if data then
						local name, rank, num = frame.recipe_info(data);
						if name and rank ~= 'header' then
							button:Show();
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
							local quality = cid and DataAgent.item_rarity(cid);
							button.icon:SetTexture(frame.recipe_icon(data));
							button.icon:SetVertexColor(1.0, 1.0, 1.0, 1.0);
							if num > 0 then
								button.title:SetText(name .. " [" .. num .. "]");
							else
								button.title:SetText(name);
							end
							button.title:SetTextColor(unpack(rank_color[rank_index[rank]] or ui_style.color_white));
							if set.showRank then
								button.note:SetText(DataAgent.get_difficulty_rank_list_text_by_sid(sid, false));
							else
								button.note:SetText("");
							end
							if quality then
								local r, g, b, code = GetItemQualityColor(quality);
								button.quality_glow:SetVertexColor(r, g, b);
								button.quality_glow:Show();
							else
								button.quality_glow:Hide();
							end
							if VT.FAV[sid] then
								button.star:Show();
							else
								button.star:Hide();
							end
							if sid == frame.selected_sid then
								button:Select();
							else
								button:Deselect();
							end
						else
							button:Hide();
						end
					else
						button:Show();
						if VT.SET.colored_rank_for_unknown then
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Disabled));
						else
							button:SetBackdropColor(unpack(ui_style.listButtonBackdropColor_Enabled));
						end
						local _, quality, icon;
						if cid then
							_, _, quality, _, icon = DataAgent.item_info(cid);
						else
							quality = nil;
							icon = ICON_FOR_NO_CID;
						end
						button.icon:SetTexture(icon);
						button.icon:SetVertexColor(1.0, 0.0, 0.0, 1.0);
						button.title:SetText(DataAgent.spell_name_s(sid));
						if VT.SET.colored_rank_for_unknown then
							local var = rawget(VT.VAR, pid);
							button.title:SetTextColor(unpack(rank_color[DataAgent.get_difficulty_rank_by_sid(sid, var and var.cur_rank or 0)] or ui_style.color_white));
						else
							button.title:SetTextColor(1.0, 0.0, 0.0, 1.0);
						end
						if set.showRank then
							button.note:SetText(DataAgent.get_difficulty_rank_list_text_by_sid(sid, false));
						else
							button.note:SetText("");
						end
						if quality then
							local r, g, b, code = GetItemQualityColor(quality);
							button.quality_glow:SetVertexColor(r, g, b);
							button.quality_glow:Show();
						else
							button.quality_glow:Hide();
						end
						if VT.FAV[sid] then
							button.star:Show();
						else
							button.star:Hide();
						end
						button:Deselect();
					end
					if GetMouseFocus() == button then
						__private.ui_skillListButton_OnEnter(button);
					end
					if button.prev_sid ~= sid then
						ALADROP(button);
						button.prev_sid = sid;
					end
				else
					ALADROP(button);
					button:Hide();
				end
			else
				ALADROP(button);
				button:Hide();
			end
		end
	local function LF_CreateSupreme(hooked_frame)
		local supreme = CreateFrame("FRAME", nil, hooked_frame);
		--	supreme
			supreme:SetFrameStrata("HIGH");
			supreme:EnableMouse(true);
			supreme:SetSize(256, 256);
			function supreme.F_Update()
				supreme.scroll:SetNumValue(#list);
				supreme.scroll:Update();
			end
			function supreme.del(button)
				local index = button:GetDataIndex();
			end
			function supreme.set_num(edit)
				local index = edit:GetParent():GetDataIndex();
			end
			function supreme.change_order_up(button)
				local index = button:GetDataIndex();
			end
			function supreme.change_order_down(button)
				local index = button:GetDataIndex();
			end
			supreme:SetScript("OnShow", function(self)
			end);
			supreme:SetScript("OnHide", function(self)
			end);
			supreme.list = VT.SET.supreme_list;
			supreme.hooked_frame = hooked_frame;
			supreme.frame = hooked_frame.frame;
			hooked_frame.supreme = supreme;

			local scroll = ALASCR(supreme, nil, nil, ui_style.supremeListButtonHeight, __private.ui_CreateSupremeListButton, __private.ui_SetSupremeListButton);
			scroll:SetPoint("BOTTOMLEFT", 4, 0);
			scroll:SetPoint("TOPRIGHT", - 4, - 28);
			__private.ui_ModifyALAScrollFrame(scroll);
			supreme.scroll = scroll;

			local call = CreateFrame("BUTTON", nil, hooked_frame, "UIPanelButtonTemplate");
			call:SetSize(18, 18);
			call:SetPoint("LEFT", hooked_frame, "RIGHT", - 2, 0);
			call:SetFrameLevel(127);
			call:SetScript("OnClick", function(self)
				if supreme:IsShown() then
					supreme:Hide();
					call:SetText(l10n["OVERRIDE_OPEN"]);
					VT.SET.show_supreme = false;
				else
					supreme:Show();
					call:SetText(l10n["OVERRIDE_CLOSE"]);
					VT.SET.show_supreme = true;
					supreme.F_Update();
				end
			end);
			-- call:SetScript("OnEnter", Info_OnEnter);
			-- call:SetScript("OnLeave", Info_OnLeave);
			supreme.call = call;
		--
		return supreme;
	end
end



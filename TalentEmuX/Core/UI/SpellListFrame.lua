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
	local strsplit = string.split;
	local format = string.format;
	local GetSpellInfo = GetSpellInfo;
	local FindSpellBookSlotBySpellID, PickupSpell = FindSpellBookSlotBySpellID, PickupSpell;
	local IsShiftKeyDown = IsShiftKeyDown;
	local CreateFrame = CreateFrame;
	local GetMouseFocus = VT._comptb.GetMouseFocus;
	local SetPortraitToTexture = SetPortraitToTexture;
	local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend;
	local GameTooltip = GameTooltip;

-->
	local l10n = CT.l10n;

-->
MT.BuildEnv('UI-SpellListFrame');
-->		predef
-->		SpellListFrame
	MT._SpellListFrameFunc = {  };
	function MT._SpellListFrameFunc.Node_OnEnter(Node)
		local index = Node:GetDataIndex();
		GameTooltip:SetOwner(Node, "ANCHOR_LEFT");
		local data = Node.list[index];
		GameTooltip:SetSpellByID(data[2]);
		GameTooltip:Show();
		MT.After(0.1, function()
			if select(2, GameTooltip:GetSpell()) ~= data[2] then
				return;
			end
			if data[5] and data[1] > 0 then
				GameTooltip:AddDoubleLine(l10n.SpellList_GTTSpellLevel .. data[5], l10n.SpellList_GTTReqLevel .. data[1], 1.0, 0.75, 0.5, 1.0, 0.75, 0.5);
			elseif data[5] then
				GameTooltip:AddLine(l10n.SpellList_GTTSpellLevel .. data[5], 1.0, 0.75, 0.5);
			elseif data[1] > 0 then
				GameTooltip:AddLine(l10n.SpellList_GTTReqLevel .. data[1], 1.0, 0.75, 0.5);
			end
			if CT.SELFCLASS == Node.list.class then
				if not data[6] then
					if FindSpellBookSlotBySpellID(data[2]) then
						GameTooltip:AddLine(l10n.SpellList_GTTAvailable);
					else
						GameTooltip:AddLine(l10n.SpellList_GTTUnavailable);
					end
				end
			end
			if data[3] > 0 then
				local str;
				if data[3] >= 10000 then
					local c = data[3] % 100;
					local s = (data[3] % 10000 - c) / 100;
					local g = (data[3] - s) / 10000;
					str = format("|cffffbf00%d|r|TInterface\\MoneyFrame\\UI-GoldIcon:12:12:0:0|t|cffffffff%02d|r|TInterface\\MoneyFrame\\UI-SilverIcon:12:12:0:0|t|cffffaf7f%02d|r|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0|t", g, s, c);
				elseif data[3] >= 100 then
					local c = data[3] % 100;
					local s = (data[3] % 10000 - c) / 100;
					str = format("|cffffffff%d|r|TInterface\\MoneyFrame\\UI-SilverIcon:12:12:0:0|t|cffffaf7f%02d|r|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0|t", s, c);
				else
					str = format("|cffffaf7f%d|r|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0|t", data[3]);
				end
				GameTooltip:AddDoubleLine(l10n.SpellList_GTTTrainCost, str, 1, 1, 1, 1, 1, 1);
			end
			if data.race then
				local str = nil;
				for _, v in next, { strsplit("|", data.race) } do
					str = str == nil and (l10n.RACE[v] or v) or (str .. ", " .. (l10n.RACE[v] or v));
				end
				GameTooltip:AddLine(l10n.RACE.RACE .. ": " .. str, 1.0, 0.5, 0.25);
			end
			GameTooltip:Show();
		end);
	end
	function MT._SpellListFrameFunc.Node_OnLeave(Node)
		if GameTooltip:IsOwned(Node) then
			GameTooltip:Hide();
		end
	end
	function MT._SpellListFrameFunc.Node_OnClick(Node)
		if IsShiftKeyDown() then
			local index = Node:GetDataIndex();
			local data = Node.list[index];
			local link = VT._comptb._GetSpellLink(data[2]);
			if link then
				local editBox = ChatEdit_ChooseBoxForSend();
				editBox:Show();
				editBox:SetFocus();
				editBox:Insert(link);
			end
		end
		Node.SearchEdit:ClearFocus();
	end
	function MT._SpellListFrameFunc.Node_OnDragStart(Node)
		Node:StopMovingOrSizing();
		local index = Node:GetDataIndex();
		local data = Node.list[index];
		if not data[6] and FindSpellBookSlotBySpellID(data[2]) then
			PickupSpell(data[2]);
		end
	end
	function MT._SpellListFrameFunc.CreateNode(Parent, index, buttonHeight)
		local Node = CreateFrame('BUTTON', nil, Parent);
		Node:SetHeight(buttonHeight);
		VT.__dep.uireimp._SetSimpleBackdrop(Node, 0, 1, 0.0, 0.0, 0.0, 0.25, 0.5, 0.5, 0.5, 0.25);
		Node:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
		Node:EnableMouse(true);
		Node:Show();

		local Icon = Node:CreateTexture(nil, "OVERLAY");
		Icon:SetTexture("Interface\\Icons\\inv_misc_questionmark");
		Icon:SetTexCoord(CT.TUISTYLE.SpellListNodeIconTexCoord[1], CT.TUISTYLE.SpellListNodeIconTexCoord[2], CT.TUISTYLE.SpellListNodeIconTexCoord[3], CT.TUISTYLE.SpellListNodeIconTexCoord[4]);
		Icon:SetSize(buttonHeight - 4, buttonHeight - 4);
		Icon:SetPoint("LEFT", 4, 0);
		Node.Icon = Icon;

		local Title = Node:CreateFontString(nil, "OVERLAY");
		Title:SetFont(CT.TUISTYLE.SpellListFrameFont, CT.TUISTYLE.SpellListFrameFontSize, CT.TUISTYLE.SpellListFrameFontOutline);
		Title:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
		Node.Title = Title;

		Node:SetScript("OnEnter", MT._SpellListFrameFunc.Node_OnEnter);
		Node:SetScript("OnLeave", MT._SpellListFrameFunc.Node_OnLeave);
		Node:SetScript("OnClick", MT._SpellListFrameFunc.Node_OnClick);
		Node:RegisterForDrag("LeftButton");
		Node:SetScript("OnDragStart", MT._SpellListFrameFunc.Node_OnDragStart);

		local SpellListFrame = Parent:GetParent():GetParent();
		Node.SpellListFrame = SpellListFrame;
		Node.list = SpellListFrame.list;
		Node.SearchEdit = SpellListFrame.SearchEdit;

		return Node;
	end
	function MT._SpellListFrameFunc.SetNode(Node, data_index)
		local list = Node.list;
		if data_index <= #list then
			local name, _, texture = GetSpellInfo(list[data_index][2]);
			SetPortraitToTexture(Node.Icon, texture);
			-- Node.Icon:SetTexture(texture);
			Node.Title:SetText(name);
			Node:Show();
			if GetMouseFocus() == Node then
				MT._SpellListFrameFunc.Node_OnEnter(Node);
			end
		else
			Node:Hide();
		end
	end
	function MT._SpellListFrameFunc.SearchEditCancel_OnClick(SearchEditCancel)
		SearchEditCancel.Edit:SetText("");
		SearchEditCancel.Edit:ClearFocus();
	end
	function MT._SpellListFrameFunc.SearchEditOKay_OnClick(SearchEditOKay)
		SearchEditOKay.Edit:ClearFocus();
	end
	function MT._SpellListFrameFunc.SearchEditOKay_OnEnable(SearchEditOKay)
		SearchEditOKay.Text:SetTextColor(1.0, 1.0, 1.0, 1.0);
	end
	function MT._SpellListFrameFunc.SearchEditOKay_OnDisable(SearchEditOKay)
		SearchEditOKay.Text:SetTextColor(1.0, 1.0, 1.0, 0.5);
	end
	function MT._SpellListFrameFunc.SearchEdit_OnEnterPressed(SearchEdit)
		SearchEdit:ClearFocus();
	end
	function MT._SpellListFrameFunc.SearchEdit_OnEscapePressed(SearchEdit)
		SearchEdit:ClearFocus();
	end
	function MT._SpellListFrameFunc.SearchEdit_OnTextChanged(SearchEdit, isUserInput)
		MT.UI.SpellListFrameUpdate(SearchEdit.SpellListFrame, SearchEdit.SpellListFrame.Frame.class, MT.GetPointsReqLevel(SearchEdit.SpellListFrame.Frame.class, SearchEdit.SpellListFrame.Frame.TotalUsedPoints));
		if not SearchEdit:HasFocus() and SearchEdit:GetText() == "" then
			SearchEdit.Note:Show();
		end
		if SearchEdit:GetText() == "" then
			SearchEdit.Cancel:Hide();
		else
			SearchEdit.Cancel:Show();
		end
	end
	function MT._SpellListFrameFunc.SearchEdit_OnEditFocusGained(SearchEdit)
		SearchEdit.Note:Hide();
		SearchEdit.OKay:Enable();
	end
	function MT._SpellListFrameFunc.SearchEdit_OnEditFocusLost(SearchEdit)
		if SearchEdit:GetText() == "" then SearchEdit.Note:Show(); end
		SearchEdit.OKay:Disable();
	end
	function MT._SpellListFrameFunc.ShowAllSpell_OnClick(ShowAllSpell)
		MT.UI.SpellListFrameUpdate(ShowAllSpell.SpellListFrame, ShowAllSpell.SpellListFrame.Frame.class, MT.GetPointsReqLevel(ShowAllSpell.SpellListFrame.Frame.class, ShowAllSpell.SpellListFrame.Frame.TotalUsedPoints));
	end
	function MT._SpellListFrameFunc.Close_OnClick(Close)
		MT.UI.SpellListFrameToggle(Close.SpellListFrame.Frame);
	end
	function MT.UI.CreateSpellListFrame(Frame)
		local SpellListFrameContainer = CreateFrame('FRAME', nil, Frame);
		SpellListFrameContainer:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 0, 0);
		SpellListFrameContainer:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 0, 0);
		SpellListFrameContainer:SetWidth(CT.TUISTYLE.SpellListFrameXSize);
		VT.__dep.uireimp._SetSimpleBackdrop(SpellListFrameContainer, 0, 1, 0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 1.0);
		SpellListFrameContainer:Hide();
		local SpellListFrame = CreateFrame('FRAME', nil, SpellListFrameContainer);	--	Frame:GetName() .. "SpellListFrame"
		SpellListFrame:SetPoint("CENTER", SpellListFrameContainer);
		SpellListFrame:SetWidth(CT.TUISTYLE.SpellListFrameXSize);
		SpellListFrame:Show();
		SpellListFrame.list = {  };
		local ScrollList = VT.__dep.__scrolllib.CreateScrollFrame(SpellListFrame, nil, nil, CT.TUISTYLE.SpellListNodeHeight, MT._SpellListFrameFunc.CreateNode, MT._SpellListFrameFunc.SetNode);
		ScrollList:SetPoint("BOTTOMLEFT", CT.TUISTYLE.SpellListFrameXToBorder, CT.TUISTYLE.SpellListFrameYToBottom);
		ScrollList:SetPoint("TOPRIGHT", -CT.TUISTYLE.SpellListFrameXToBorder, -CT.TUISTYLE.SpellListFrameYToTop);
		SpellListFrame.ScrollList = ScrollList;

		local SearchEdit = CreateFrame('EDITBOX', nil, SpellListFrame);
		SearchEdit:SetSize(CT.TUISTYLE.SpellListFrameXSize - 2 * CT.TUISTYLE.SpellListFrameXToBorder - 2 - CT.TUISTYLE.SpellListSearchEditOkayXSize, CT.TUISTYLE.SpellListSearchEditYSize);
		SearchEdit:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeSmall, CT.TUISTYLE.FrameFontOutline);
		SearchEdit:SetAutoFocus(false);
		SearchEdit:SetJustifyH("LEFT");
		SearchEdit:Show();
		SearchEdit:EnableMouse(true);
		SearchEdit:SetPoint("TOPLEFT", SpellListFrame, CT.TUISTYLE.SpellListFrameXToBorder, -2);
		local SearchEditTexture = SearchEdit:CreateTexture(nil, "ARTWORK");
		SearchEditTexture:SetPoint("TOPLEFT");
		SearchEditTexture:SetPoint("BOTTOMRIGHT");
		SearchEditTexture:SetTexture("Interface\\Buttons\\greyscaleramp64");
		SearchEditTexture:SetTexCoord(0.0, 0.25, 0.0, 0.25);
		SearchEditTexture:SetAlpha(0.75);
		SearchEditTexture:SetBlendMode("ADD");
		SearchEditTexture:SetVertexColor(0.25, 0.25, 0.25);
		SearchEdit.Texture = SearchEditTexture;
		local SearchEditNote = SearchEdit:CreateFontString(nil, "OVERLAY");
		SearchEditNote:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeMedium, CT.TUISTYLE.FrameFontOutline);
		SearchEditNote:SetTextColor(1.0, 1.0, 1.0, 0.5);
		SearchEditNote:SetPoint("LEFT", 4, 0);
		SearchEditNote:SetText(l10n.SpellList_Search);
		SearchEditNote:Show();
		SearchEdit.Note = SearchEditNote;
		local SearchEditCancel = CreateFrame('BUTTON', nil, SearchEdit);
		SearchEditCancel:SetSize(CT.TUISTYLE.SpellListSearchEditYSize, CT.TUISTYLE.SpellListSearchEditYSize);
		SearchEditCancel:SetPoint("RIGHT", SearchEdit);
		SearchEditCancel:SetScript("OnClick", MT._SpellListFrameFunc.SearchEditCancel_OnClick);
		SearchEditCancel:Hide();
		SearchEditCancel:SetNormalTexture("interface\\petbattles\\deadpeticon");
		SearchEditCancel.Edit = SearchEdit;
		SearchEdit.Cancel = SearchEditCancel;
		local SearchEditOKay = CreateFrame('BUTTON', nil, SpellListFrame);
		SearchEditOKay:SetSize(CT.TUISTYLE.SpellListSearchEditOkayXSize, CT.TUISTYLE.SpellListSearchEditYSize);
		SearchEditOKay:SetPoint("LEFT", SearchEdit, "RIGHT", 4, 0);
		SearchEditOKay:SetScript("OnClick", MT._SpellListFrameFunc.SearchEditOKay_OnClick);
		SearchEditOKay:Disable();
		SearchEditOKay.Edit = SearchEdit;
		SearchEdit.OKay = SearchEditOKay;
		local SearchEditOKayTexture = SearchEditOKay:CreateTexture(nil, "ARTWORK");
		SearchEditOKayTexture:SetPoint("TOPLEFT");
		SearchEditOKayTexture:SetPoint("BOTTOMRIGHT");
		SearchEditOKayTexture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
		SearchEditOKayTexture:SetAlpha(0.75);
		SearchEditOKayTexture:SetBlendMode("ADD");
		SearchEditOKay.Texture = SearchEditOKayTexture;
		local SearchEditOKayText = SearchEditOKay:CreateFontString(nil, "OVERLAY");
		SearchEditOKayText:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeMedium, CT.TUISTYLE.FrameFontOutline);
		SearchEditOKayText:SetTextColor(1.0, 1.0, 1.0, 0.5);
		SearchEditOKayText:SetPoint("CENTER");
		SearchEditOKayText:SetText(l10n.SpellList_SearchOKay);
		SearchEditOKay.Text = SearchEditOKayText;
		SearchEditOKay:SetFontString(SearchEditOKayText);
		SearchEditOKay:SetPushedTextOffset(1, -1);
		SearchEditOKay:SetScript("OnEnable", MT._SpellListFrameFunc.SearchEditOKay_OnEnable);
		SearchEditOKay:SetScript("OnDisable", MT._SpellListFrameFunc.SearchEditOKay_OnDisable);
		SearchEdit:SetScript("OnEnterPressed", MT._SpellListFrameFunc.SearchEdit_OnEnterPressed);
		SearchEdit:SetScript("OnEscapePressed", MT._SpellListFrameFunc.SearchEdit_OnEscapePressed);
		SearchEdit:SetScript("OnTextChanged", MT._SpellListFrameFunc.SearchEdit_OnTextChanged);
		SearchEdit:SetScript("OnEditFocusGained", MT._SpellListFrameFunc.SearchEdit_OnEditFocusGained);
		SearchEdit:SetScript("OnEditFocusLost", MT._SpellListFrameFunc.SearchEdit_OnEditFocusLost);
		SearchEdit:ClearFocus();
		SearchEdit.SpellListFrame = SpellListFrame;
		SpellListFrame.SearchEdit = SearchEdit;
		SpellListFrame.SearchEditOKay = SearchEditOKay;

		local ShowAllSpell = CreateFrame('CHECKBUTTON', nil, SpellListFrame);
		MT._TextureFunc.SetNormalTexture(ShowAllSpell, CT.TTEXTURESET.CHECK.Normal, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		MT._TextureFunc.SetPushedTexture(ShowAllSpell, CT.TTEXTURESET.CHECK.Pushed, nil, nil, CT.TTEXTURESET.CONTROL.PUSHED_COLOR);
		MT._TextureFunc.SetHighlightTexture(ShowAllSpell, CT.TTEXTURESET.CHECK.Highlight, nil, nil, CT.TTEXTURESET.CONTROL.HIGHLIGHT_COLOR);
		MT._TextureFunc.SetCheckedTexture(ShowAllSpell, CT.TTEXTURESET.CHECK.Checked, nil, nil, CT.TTEXTURESET.CONTROL.NORMAL_COLOR);
		ShowAllSpell:SetSize(12, 12);
		ShowAllSpell:SetHitRectInsets(0, 0, 0, 0);
		ShowAllSpell:ClearAllPoints();
		ShowAllSpell:Show();
		ShowAllSpell:SetChecked(false);
		ShowAllSpell:SetPoint("BOTTOMRIGHT", -CT.TUISTYLE.SpellListFrameXToBorder, 6);
		ShowAllSpell:SetScript("OnClick", MT._SpellListFrameFunc.ShowAllSpell_OnClick);
		ShowAllSpell.SpellListFrame = SpellListFrame;
		SpellListFrame.ShowAllSpell = ShowAllSpell;

		local ShowAllSpellLabel = SpellListFrame:CreateFontString(nil, "ARTWORK");
		ShowAllSpellLabel:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeSmall, CT.TUISTYLE.FrameFontOutline);
		ShowAllSpellLabel:SetText(l10n.SpellList_ShowAllSpell);
		ShowAllSpell.Name = ShowAllSpellLabel;
		ShowAllSpellLabel:SetPoint("RIGHT", ShowAllSpell, "LEFT", -2, 0);

		local Close = CreateFrame('BUTTON', nil, SpellListFrame);
		Close:SetSize(32, 16);
		Close:SetPoint("BOTTOMLEFT", 4, 6);
		Close:SetScript("OnClick", MT._SpellListFrameFunc.Close_OnClick);
		local CloseTexture = Close:CreateTexture(nil, "ARTWORK");
		CloseTexture:SetPoint("TOPLEFT");
		CloseTexture:SetPoint("BOTTOMRIGHT");
		CloseTexture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
		CloseTexture:SetAlpha(0.75);
		CloseTexture:SetBlendMode("ADD");
		local CloseLabel = Close:CreateFontString(nil, "OVERLAY");
		CloseLabel:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeMedium, CT.TUISTYLE.FrameFontOutline);
		CloseLabel:SetTextColor(1.0, 1.0, 1.0, 0.5);
		CloseLabel:SetPoint("CENTER");
		CloseLabel:SetText(l10n.SpellList_Hide);
		Close:SetFontString(CloseLabel);
		Close:SetPushedTextOffset(1, -1);
		Close.SpellListFrame = SpellListFrame;
		SpellListFrame.Close = Close;

		SpellListFrame.Frame = Frame;
		SpellListFrameContainer.Frame = Frame;
		return SpellListFrame, SpellListFrameContainer;
	end

-->

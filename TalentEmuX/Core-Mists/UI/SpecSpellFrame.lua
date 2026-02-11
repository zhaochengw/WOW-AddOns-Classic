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
	local GetSpellInfo = GetSpellInfo;
	local GetSpellLevelLearned = C_Spell.GetSpellLevelLearned;
	local IsShiftKeyDown = IsShiftKeyDown;
	local CreateFrame = CreateFrame;
	local SetPortraitToTexture = SetPortraitToTexture;
	local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend;

-->
	local l10n = CT.l10n;

-->
MT.BuildEnv('UI-SpecSpellFrame');
-->		predef
-->		SpecSpellFrame
	MT._SpecSpellFunc = {  };
	function MT._SpecSpellFunc.Node_OnEnter(Node)
		MT.UI.SetTooltip(Node);
	end
	function MT._SpecSpellFunc.Node_OnLeave(Node)
		MT.UI.HideTooltip(Node);
	end
	function MT._SpecSpellFunc.OnDragStart(SpecSpellFrame, button)
		local Frame = SpecSpellFrame.Frame;
		if not Frame.isMoving and not Frame.isResizing and Frame:IsMovable() then
			Frame:StartMoving();
		end
	end
	function MT._SpecSpellFunc.OnDragStop(SpecSpellFrame, button)
		SpecSpellFrame.Frame:StopMovingOrSizing();
	end
	function MT._SpecSpellFunc.Node_OnClick(Node, button)
		if IsShiftKeyDown() then
			local link = VT._comptb._GetSpellLink(Node.SpellID);
			if link then
				local editBox = ChatEdit_ChooseBoxForSend();
				editBox:Show();
				editBox:SetFocus();
				editBox:Insert(link);
			end
		end
	end
	function MT._SpecSpellFunc.CreateNode(SpecSpellFrame)
		local Node = CreateFrame('BUTTON', nil, SpecSpellFrame);	--	SpecSpellFrame:GetName() .. "Node" .. id
		Node:SetSize(CT.TUISTYLE.SpecSpellNodeXSize, CT.TUISTYLE.SpecSpellNodeYSize);

		Node:Show();
		Node:EnableMouse(true);
		Node:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		Node:SetScript("OnClick", MT._SpecSpellFunc.Node_OnClick);
		Node:SetScript("OnEnter", MT._SpecSpellFunc.Node_OnEnter);
		Node:SetScript("OnLeave", MT._SpecSpellFunc.Node_OnLeave);

		Node:SetNormalTexture(CT.TTEXTURESET.UNK);
		Node:SetPushedTexture(CT.TTEXTURESET.UNK);
		if CT.TUISTYLE.SpecSpellNodeXSize ~= CT.TUISTYLE.SpecSpellNodeYSize then
			local s = CT.TUISTYLE.SpecSpellNodeXSize / CT.TUISTYLE.SpecSpellNodeYSize;
			if s > 1 then
				s = 1 / s;
				Node:GetNormalTexture():SetTexCoord(0.05, 0.95, 0.5 - 0.45 * s, 0.5 + 0.45 * s);
				Node:GetPushedTexture():SetTexCoord(0.05, 0.95, 0.5 - 0.45 * s, 0.5 + 0.45 * s);
			else
				Node:GetNormalTexture():SetTexCoord(0.5 - 0.45 * s, 0.5 + 0.45 * s, 0.05, 0.95);
				Node:GetPushedTexture():SetTexCoord(0.5 - 0.45 * s, 0.5 + 0.45 * s, 0.05, 0.95);
			end
		end
		MT._TextureFunc.SetHighlightTexture(Node, nil, nil, nil, { 0.25, 0.5, 0.5, 1.0, }, "ADD");
		Node:GetNormalTexture():SetVertexColor(CT.TTEXTURESET.ICON_UNLIGHT_COLOR[1], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[2], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[3], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[4]);
		Node:GetPushedTexture():SetVertexColor(CT.TTEXTURESET.ICON_UNLIGHT_COLOR[1], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[2], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[3], CT.TTEXTURESET.ICON_UNLIGHT_COLOR[4]);

		Node.Border = MT._TextureFunc.CreateFlatBorder(Node, 3);

		local Overlay = Node:CreateTexture(nil, "OVERLAY");
		Overlay:SetAllPoints();
		Overlay:SetBlendMode("ADD");
		Node.Overlay = Overlay;

		local Name = Node:CreateFontString(nil, "ARTWORK");
		Name:SetPoint("CENTER", Node, "CENTER", 0, 0);
		Name:SetFont(CT.TUISTYLE.SpecSpellNodeNameFont, CT.TUISTYLE.SpecSpellNodeNameFontSize, CT.TUISTYLE.SpecSpellNodeNameFontOutline);
		Name:SetTextColor(0.9, 0.9, 0.5, 1.0);
		Node.Name = Name;

		Node.Parent = SpecSpellFrame;

		return Node;
	end
	function MT._SpecSpellFunc.GetNode(SpecSpellFrame, id)
		if not SpecSpellFrame.SpecSpellNodes[id] then
			SpecSpellFrame.SpecSpellNodes[id] = MT._SpecSpellFunc.CreateNode(SpecSpellFrame);
		end
		return SpecSpellFrame.SpecSpellNodes[id];
	end
	function MT._SpecSpellFunc.SetSpellList(SpecSpellFrame, List)
		local id = 1;
		local x = DT.MAX_NUM_COL + 1;
		local y = 0;
		for i = 1, #List, 2 do
			if x >= DT.MAX_NUM_COL then
				x = 0;
				y = y + 1;
			end
			local SpellID = List[i];
			local Node = MT._SpecSpellFunc.GetNode(SpecSpellFrame, id);
			Node:SetPoint("TOP", SpecSpellFrame, "TOP", (CT.TUISTYLE.SpecSpellNodeXSize + CT.TUISTYLE.SpecSpellNodeXGap) * (x - DT.MAX_NUM_COL * 0.5 + 0.5), -CT.TUISTYLE.SpecSpellFrameHeaderYSize - CT.TUISTYLE.SpecSpellNodeYToTop - (CT.TUISTYLE.SpecSpellNodeYSize + CT.TUISTYLE.SpecSpellNodeYGap) * (y - 1));
			Node:Show();
			Node.SpellID = SpellID;
			local name, _, texture = GetSpellInfo(SpellID);
			local level = GetSpellLevelLearned(SpellID);
			if name ~= nil then
				Node.Name:SetText(name);
			else
				Node.Name:SetText("");
			end
			if texture ~= nil then
				Node:SetNormalTexture(texture);
				Node:SetPushedTexture(texture);
				-- SetPortraitToTexture(Node:GetNormalTexture(), texture);
				-- SetPortraitToTexture(Node:GetPushedTexture(), texture);
			elseif TalentDef[9] ~= nil then
				Node:SetNormalTexture(TalentDef[9]);
				Node:SetPushedTexture(TalentDef[9]);
				-- SetPortraitToTexture(Node:GetNormalTexture(), TalentDef[9]);
				-- SetPortraitToTexture(Node:GetPushedTexture(), TalentDef[9]);
			else
				Node:SetNormalTexture(CT.TTEXTURESET.UNK);
				Node:SetPushedTexture(CT.TTEXTURESET.UNK);
				-- SetPortraitToTexture(Node:GetNormalTexture(), CT.TTEXTURESET.UNK);
				-- SetPortraitToTexture(Node:GetPushedTexture(), CT.TTEXTURESET.UNK);
			end
			id = id + 1;
			x = x + 1;
		end
		if id == 1 then
			SpecSpellFrame.Note:Show();
		else
			SpecSpellFrame.Note:Hide();
		end
		while SpecSpellFrame.SpecSpellNodes[id] do
			SpecSpellFrame.SpecSpellNodes[id]:Hide();
			id = id + 1;
		end
		if y == 0 then
			y = 2;
		end
		local Height = CT.TUISTYLE.SpecSpellFrameHeaderYSize + CT.TUISTYLE.SpecSpellNodeYToTop + CT.TUISTYLE.SpecSpellNodeYSize * y + CT.TUISTYLE.SpecSpellNodeYGap * (y - 1) + CT.TUISTYLE.SpecSpellNodeYToBottom + CT.TUISTYLE.SpecSpellFrameFooterYSize;
		SpecSpellFrame:SetHeight(Height);
		SpecSpellFrame.Frame:SetHeight(CT.TUISTYLE.FrameYSizeDefault_Style2 + Height + CT.TUISTYLE.SpecSpellFrameYToBorder * 2);
	end
	function MT.UI.CreateSpecSpellFrame(Frame)
		local SpecSpellFrame = CreateFrame('FRAME', nil, Frame);
		SpecSpellFrame:SetSize(CT.TUISTYLE.SpecSpellFrameXSizeSingle, 0);

		SpecSpellFrame:Show();
		SpecSpellFrame:SetMouseClickEnabled(false);
		SpecSpellFrame:SetPoint("BOTTOM", Frame, "BOTTOM", 0, CT.TUISTYLE.SpecSpellFrameYToBorder + CT.TUISTYLE.TreeButtonsBarYSize + CT.TUISTYLE.FrameFooterYSize);

		local Background = SpecSpellFrame:CreateTexture(nil, "BORDER");
		Background:SetAllPoints();
		Background:SetColorTexture(0.0, 0.0, 0.0, 0.5);
		SpecSpellFrame.Background = Background;

		local HSeq = SpecSpellFrame:CreateTexture(nil, "ARTWORK");
		HSeq:SetHeight(CT.TUISTYLE.SpecSpellFrameSeqWidth);
		HSeq:SetPoint("LEFT", SpecSpellFrame, "TOPLEFT", 0, 0);
		HSeq:SetPoint("RIGHT", SpecSpellFrame, "TOPRIGHT", 0, 0);
		MT._TextureFunc.SetTexture(HSeq, CT.TTEXTURESET.SEP_HORIZONTAL);
		SpecSpellFrame.HSeq = HSeq;

		local Note = SpecSpellFrame:CreateFontString(nil, "ARTWORK");
		Note:SetPoint("CENTER");
		Note:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeLarge, CT.TUISTYLE.FrameFontOutline);
		Note:SetText(l10n.DisplaySpecSpell);
		Note:Show();
		SpecSpellFrame.Note = Note;

		SpecSpellFrame.SpecSpellNodes = {  };

		SpecSpellFrame.Frame = Frame;

		return SpecSpellFrame;
	end

-->

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
	local IsShiftKeyDown = IsShiftKeyDown;
	local CreateFrame = CreateFrame;
	local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend;

-->
	local l10n = CT.l10n;

-->
MT.BuildEnv('UI-TreeFrame');
-->		predef
-->		TreeFrame
	MT._TreeFunc = {  };
	function MT._TreeFunc.Node_OnEnter(Node)
		MT.UI.SetTooltip(Node);
	end
	function MT._TreeFunc.Node_OnLeave(Node)
		MT.UI.HideTooltip(Node);
	end
	function MT._TreeFunc.Node_OnClick(Node, button)
		if IsShiftKeyDown() then
			local TreeFrame = Node.Parent;
			local Frame = TreeFrame.Frame;
			local TreeTDB = TreeFrame.TreeTDB;
			local TalentSet = TreeFrame.TalentSet;
			local TalentSeq = Node.TalentSeq;
			local link = VT._comptb._GetSpellLink(TreeTDB[TalentSeq][8][TalentSet[TalentSeq] == 0 and 1 or TalentSet[TalentSeq]]);
			if link then
				local editBox = ChatEdit_ChooseBoxForSend();
				editBox:Show();
				editBox:SetFocus();
				editBox:Insert(link);
			end
		else
			if not Node.active then
				return;
			end
			if button == "LeftButton" then
				MT.UI.TreeNodeChangePoint(Node, 1);
			elseif button == "RightButton" then
				MT.UI.TreeNodeChangePoint(Node, -1);
			end
		end
	end
	function MT._TreeFunc.CreateNode(TreeFrame, id)
		local Node = CreateFrame('BUTTON', nil, TreeFrame);	--	TreeFrame:GetName() .. "TreeNode" .. id
		Node:SetSize(CT.TUISTYLE.TreeNodeXSize, CT.TUISTYLE.TreeNodeYSize);

		Node:Hide();
		Node:EnableMouse(true);
		Node:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		Node:SetScript("OnClick", MT._TreeFunc.Node_OnClick);
		Node:SetScript("OnEnter", MT._TreeFunc.Node_OnEnter);
		Node:SetScript("OnLeave", MT._TreeFunc.Node_OnLeave);

		Node:SetNormalTexture(CT.TTEXTURESET.UNK);
		Node:SetPushedTexture(CT.TTEXTURESET.UNK);
		if CT.TUISTYLE.TreeNodeXSize ~= CT.TUISTYLE.TreeNodeYSize then
			local s = CT.TUISTYLE.TreeNodeXSize / CT.TUISTYLE.TreeNodeYSize;
			if s > 1 then
				s = 1 / s;
				Node:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.5 - 0.5 * s, 0.5 + 0.5 * s);
				Node:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.5 - 0.5 * s, 0.5 + 0.5 * s);
			else
				Node:GetNormalTexture():SetTexCoord(0.5 - 0.5 * s, 0.5 + 0.5 * s, 0.0, 1.0);
				Node:GetPushedTexture():SetTexCoord(0.5 - 0.5 * s, 0.5 + 0.5 * s, 0.0, 1.0);
			end
		end
		MT._TextureFunc.SetHighlightTexture(Node, CT.TTEXTURESET.ICON_HIGHLIGHT, CT.TTEXTURESET.SQUARE_HIGHLIGHT);

		Node.Border = MT._TextureFunc.CreateFlatBorder(Node, 3);

		local Split = Node:CreateFontString(nil, "OVERLAY", nil, 1);
		Split:SetFont(CT.TUISTYLE.TreeNodeNumberFont, CT.TUISTYLE.TreeNodeNumberFontSize, CT.TUISTYLE.TreeNodeNumberFontOutline)
		Split:SetText("/");
		Split:SetPoint("CENTER", Node, "BOTTOMRIGHT", 0, 0);
		Node.Split = Split;
		local MaxVal = Node:CreateFontString(nil, "OVERLAY", nil, 1);
		MaxVal:SetFont(CT.TUISTYLE.TreeNodeNumberFont, CT.TUISTYLE.TreeNodeNumberFontSize, CT.TUISTYLE.TreeNodeNumberFontOutline)
		MaxVal:SetText("1");
		MaxVal:SetPoint("LEFT", Split, "RIGHT", 0, 0);
		Node.MaxVal = MaxVal;
		local CurVal = Node:CreateFontString(nil, "OVERLAY", nil, 1);
		CurVal:SetFont(CT.TUISTYLE.TreeNodeNumberFont, CT.TUISTYLE.TreeNodeNumberFontSize, CT.TUISTYLE.TreeNodeNumberFontOutline)
		CurVal:SetText("");
		CurVal:SetPoint("RIGHT", Split, "LEFT", 0, 0);
		Node.CurVal = CurVal;

		local Overlay = Node:CreateTexture(nil, "OVERLAY");
		Overlay:SetAllPoints();
		Overlay:SetBlendMode("ADD");
		Node.Overlay = Overlay;

		Node.Parent = TreeFrame;
		Node.id = id;
		Node.active = true;

		return Node;
	end
	function MT._TreeFunc.CreateNodes(TreeFrame)
		local TreeNodes = {  };
		local posX = 0;
		local posY = 0;
		for id = 1, DT.MAX_NUM_TALENTS do
			local Node = MT._TreeFunc.CreateNode(TreeFrame, id);
			Node:SetPoint("TOP", TreeFrame, "TOP", (CT.TUISTYLE.TreeNodeXSize + CT.TUISTYLE.TreeNodeXGap) * (posX - DT.MAX_NUM_COL * 0.5 + 0.5), -CT.TUISTYLE.TreeFrameHeaderYSize - CT.TUISTYLE.TreeNodeYToTop - (CT.TUISTYLE.TreeNodeYSize + CT.TUISTYLE.TreeNodeYGap) * posY);
			Node:Hide();
			TreeNodes[id] = Node;

			posX = posX + 1;
			if posX >= DT.MAX_NUM_COL then
				posX = 0;
				posY = posY + 1;
			end
		end

		return TreeNodes;
	end
	function MT._TreeFunc.ResetTreeButton_OnClick(ResetTreeButton)
		local TreeFrame = ResetTreeButton.Parent;
		MT.UI.TreeFrameResetTalents(TreeFrame);
	end
	function MT._TreeFunc.OnDragStart(TreeFrame, button)
		local Frame = TreeFrame.Frame;
		if not Frame.isMoving and not Frame.isResizing and Frame:IsMovable() then
			Frame:StartMoving();
		end
	end
	function MT._TreeFunc.OnDragStop(TreeFrame, button)
		TreeFrame.Frame:StopMovingOrSizing();
	end
	function MT.UI.CreateTreeFrames(Frame)
		local TreeFrames = {  };

		for TreeIndex = 1, 3 do
			local TreeFrame = CreateFrame('FRAME', nil, Frame);	--	Frame:GetName() .. "TreeFrame" .. TreeIndex
			TreeFrame:SetSize(CT.TUISTYLE.TreeFrameXSizeSingle, CT.TUISTYLE.TreeFrameYSize);

			TreeFrame:Show();
			TreeFrame:SetMouseClickEnabled(false);
			-- TreeFrame:EnableMouse(true);
			-- TreeFrame:SetMovable(true);
			-- TreeFrame:RegisterForDrag("LeftButton");
			-- TreeFrame:SetScript("OnShow", TreeFrame_OnShow);
			-- TreeFrame:SetScript("OnHide", TreeFrame_OnHide);
			-- TreeFrame:SetScript("OnDragStart", MT._TreeFunc.OnDragStart);
			-- TreeFrame:SetScript("OnDragStop", MT._TreeFunc.OnDragStop);

			local HSeq = {  };
			HSeq[1] = TreeFrame:CreateTexture(nil, "ARTWORK");
			HSeq[1]:SetHeight(CT.TUISTYLE.TreeFrameSeqWidth);
			HSeq[1]:SetPoint("LEFT", TreeFrame, "TOPLEFT", 0, 0);
			HSeq[1]:SetPoint("RIGHT", TreeFrame, "TOPRIGHT", 0, 0);
			MT._TextureFunc.SetTexture(HSeq[1], CT.TTEXTURESET.SEP_HORIZONTAL);
			HSeq[2] = TreeFrame:CreateTexture(nil, "ARTWORK");
			HSeq[2]:SetHeight(CT.TUISTYLE.TreeFrameSeqWidth);
			HSeq[2]:SetPoint("LEFT", TreeFrame, "BOTTOMLEFT", 0, 0);
			HSeq[2]:SetPoint("RIGHT", TreeFrame, "BOTTOMRIGHT", 0, 0);
			MT._TextureFunc.SetTexture(HSeq[2], CT.TTEXTURESET.SEP_HORIZONTAL);
			HSeq[3] = TreeFrame:CreateTexture(nil, "ARTWORK");
			HSeq[3]:SetHeight(CT.TUISTYLE.TreeFrameSeqWidth);
			HSeq[3]:SetPoint("LEFT", TreeFrame, "BOTTOMLEFT", 0, CT.TUISTYLE.TreeButtonsBarYSize);
			HSeq[3]:SetPoint("RIGHT", TreeFrame, "BOTTOMRIGHT", 0, CT.TUISTYLE.TreeButtonsBarYSize);
			MT._TextureFunc.SetTexture(HSeq[3], CT.TTEXTURESET.SEP_HORIZONTAL);
			TreeFrame.HSeq = HSeq;

			local VSep = {  };
			VSep[1] = TreeFrame:CreateTexture(nil, "ARTWORK");
			VSep[1]:SetWidth(CT.TUISTYLE.TreeFrameSeqWidth);
			VSep[1]:SetPoint("TOP", TreeFrame, "TOPLEFT", 0, 0);
			VSep[1]:SetPoint("BOTTOM", TreeFrame, "BOTTOMLEFT", 0, 0);
			MT._TextureFunc.SetTexture(VSep[1], CT.TTEXTURESET.SEP_VERTICAL);
			VSep[2] = TreeFrame:CreateTexture(nil, "ARTWORK");
			VSep[2]:SetWidth(CT.TUISTYLE.TreeFrameSeqWidth);
			VSep[2]:SetPoint("TOP", TreeFrame, "TOPRIGHT", 0, 0);
			VSep[2]:SetPoint("BOTTOM", TreeFrame, "BOTTOMRIGHT", 0, 0);
			MT._TextureFunc.SetTexture(VSep[2], CT.TTEXTURESET.SEP_VERTICAL);
			TreeFrame.VSep = VSep;

			local Background = TreeFrame:CreateTexture(nil, "BORDER");
			Background:SetAllPoints();
			Background:SetAlpha(0.6);
			local ratio = CT.TUISTYLE.TreeFrameXSizeSingle / CT.TUISTYLE.TreeFrameYSize;
			if ratio > 1.0 then
				Background:SetTexCoord(0.0, 1.0, (1.0 - ratio) * 0.5, (1.0 + ratio) * 0.5);
			elseif ratio < 1.0 then
				Background:SetTexCoord((1.0 - ratio) * 0.5, (1.0 + ratio) * 0.5, 0.0, 1.0);
			end
			TreeFrame.Background = Background;

			TreeFrame.TreeNodes = MT._TreeFunc.CreateNodes(TreeFrame);

			local ResetTreeButtonBackgroud = TreeFrame:CreateTexture(nil, "ARTWORK");
			ResetTreeButtonBackgroud:SetSize(CT.TUISTYLE.TreeNodeXSize, CT.TUISTYLE.TreeNodeXSize);
			ResetTreeButtonBackgroud:SetPoint("CENTER", TreeFrame.TreeNodes[DT.MAX_NUM_TALENTS]);
			MT._TextureFunc.SetTexture(ResetTreeButtonBackgroud, CT.TTEXTURESET.RESETTREE.Backgroud);
			TreeFrame.ResetTreeButtonBackgroud = ResetTreeButtonBackgroud;

			local ResetTreeButton = CreateFrame('BUTTON', nil, TreeFrame);
			ResetTreeButton:SetSize(CT.TUISTYLE.ControlButtonSize, CT.TUISTYLE.ControlButtonSize);
			ResetTreeButton:SetPoint("CENTER", ResetTreeButtonBackgroud);
			MT._TextureFunc.SetHighlightTexture(ResetTreeButton, CT.TTEXTURESET.RESETTREE.Highlight);
			ResetTreeButton:GetHighlightTexture():ClearAllPoints();
			ResetTreeButton:GetHighlightTexture():SetPoint("CENTER");
			ResetTreeButton:GetHighlightTexture():SetSize(CT.TUISTYLE.TreeNodeXSize, CT.TUISTYLE.TreeNodeXSize);
			ResetTreeButton:SetScript("OnClick", MT._TreeFunc.ResetTreeButton_OnClick);
			ResetTreeButton:SetScript("OnEnter", MT.GeneralOnEnter);
			ResetTreeButton:SetScript("OnLeave", MT.GeneralOnLeave);
			ResetTreeButton.information = l10n.ResetTreeButton;
			TreeFrame.ResetTreeButton = ResetTreeButton;
			ResetTreeButton.Parent = TreeFrame;

			local TreePoints = TreeFrame:CreateFontString(nil, "ARTWORK");
			TreePoints:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeLarge, CT.TUISTYLE.FrameFontOutline);
			TreePoints:SetPoint("CENTER", ResetTreeButton);
			TreePoints:SetTextColor(0.0, 1.0, 0.0, 1.0);
			TreePoints:SetText("0");
			TreeFrame.TreePoints = TreePoints;

			local TreeLabel = TreeFrame:CreateFontString(nil, "ARTWORK");
			TreeLabel:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSize, CT.TUISTYLE.FrameFontOutline);
			TreeLabel:SetPoint("CENTER", TreeFrame, "BOTTOM", 0, CT.TUISTYLE.TreeButtonsBarYSize * 0.5);
			TreeLabel:SetTextColor(0.9, 0.9, 0.9, 1.0);
			TreeFrame.TreeLabel = TreeLabel;
			local TreeLabelBackground = TreeFrame:CreateTexture(nil, "ARTWORK");
			TreeLabelBackground:SetSize(CT.TUISTYLE.TreeButtonsBarYSize, CT.TUISTYLE.TreeButtonsBarYSize);
			-- TreeLabelBackground:SetPoint("BOTTOMLEFT", TreeFrame, "BOTTOMLEFT", 0, 0);
			-- TreeLabelBackground:SetPoint("TOPRIGHT", TreeFrame, "BOTTOMRIGHT", 0, CT.TUISTYLE.TreeButtonsBarYSize);
			TreeLabelBackground:SetPoint("RIGHT", TreeLabel, "LEFT", -4, 0);
			TreeLabelBackground:SetTexCoord(CT.TUISTYLE.TreeFrameLabelBackgroundTexCoord[1], CT.TUISTYLE.TreeFrameLabelBackgroundTexCoord[2], CT.TUISTYLE.TreeFrameLabelBackgroundTexCoord[3], CT.TUISTYLE.TreeFrameLabelBackgroundTexCoord[4]);
			TreeFrame.TreeLabelBackground = TreeLabelBackground;

			TreeFrame.Frame = Frame;
			TreeFrame.id = TreeIndex;
			TreeFrame.TalentSet = { CountByTier = {  }, Total = 0, TopAvailableTier = 0, TopCheckedTier = 0, };
			for i = 1, DT.MAX_NUM_TALENTS do
				TreeFrame.TalentSet[i] = 0;
			end
			for i = 0, DT.MAX_NUM_TIER do
				TreeFrame.TalentSet.CountByTier[i] = 0;
			end
			TreeFrame.TalentChanged = {  };
			TreeFrame.DependArrows = { used = 0, };
			TreeFrame.NodeDependArrows = {  };
			for i = 1, DT.MAX_NUM_TALENTS do
				TreeFrame.NodeDependArrows[i] = {  };
			end

			TreeFrames[TreeIndex] = TreeFrame;
		end

		return TreeFrames;
	end

-->

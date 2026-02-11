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
	function MT._TreeFunc.OnDragStart(TreeFrame, button)
		local Frame = TreeFrame.Frame;
		if not Frame.isMoving and not Frame.isResizing and Frame:IsMovable() then
			Frame:StartMoving();
		end
	end
	function MT._TreeFunc.OnDragStop(TreeFrame, button)
		TreeFrame.Frame:StopMovingOrSizing();
	end
	function MT._TreeFunc.Node_OnClick(Node, button)
		local TreeFrame = Node.Parent;
		if IsShiftKeyDown() then
			local Frame = TreeFrame.Frame;
			local ClassTDB = DT.TalentDB[Frame.class];
			if ClassTDB then
				local link = VT._comptb._GetSpellLink(ClassTDB[Node.TalentSeq][8]);
				if link then
					local editBox = ChatEdit_ChooseBoxForSend();
					editBox:Show();
					editBox:SetFocus();
					editBox:Insert(link);
				end
			end
		else
			if button == "LeftButton" then
				MT.UI.TreeNodeChangePoint(TreeFrame, Node.tier, Node.value);
			elseif button == "RightButton" then
				MT.UI.TreeNodeChangePoint(TreeFrame, Node.tier, 0);
			end
		end
	end
	function MT._TreeFunc.CreateNode(TreeFrame, tier, value, id)
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
				Node:GetNormalTexture():SetTexCoord(0.05, 0.95, 0.5 - 0.45 * s, 0.5 + 0.45 * s);
				Node:GetPushedTexture():SetTexCoord(0.05, 0.95, 0.5 - 0.45 * s, 0.5 + 0.45 * s);
			else
				Node:GetNormalTexture():SetTexCoord(0.5 - 0.45 * s, 0.5 + 0.45 * s, 0.05, 0.95);
				Node:GetPushedTexture():SetTexCoord(0.5 - 0.45 * s, 0.5 + 0.45 * s, 0.05, 0.95);
			end
		end
		MT._TextureFunc.SetHighlightTexture(Node, nil, nil, nil, { 0.25, 0.5, 0.5, 1.0, }, "ADD");

		Node.Border = MT._TextureFunc.CreateFlatBorder(Node, 3);

		local Overlay = Node:CreateTexture(nil, "OVERLAY");
		Overlay:SetAllPoints();
		Overlay:SetBlendMode("ADD");
		Node.Overlay = Overlay;

		local Name = Node:CreateFontString(nil, "ARTWORK");
		Name:SetPoint("CENTER", Node, "CENTER", 0, 0);
		Name:SetFont(CT.TUISTYLE.TreeNodeNameFont, CT.TUISTYLE.TreeNodeNameFontSize, CT.TUISTYLE.TreeNodeNameFontOutline);
		Name:SetTextColor(1.0, 1.0, 1.0, 1.0);
		Node.Name = Name;

		Node.Parent = TreeFrame;
		Node.tier = tier;
		Node.value = value;
		Node.id = id;

		return Node;
	end
	function MT._TreeFunc.CreateNodes(TreeFrame)
		local TreeNodes = {  };
		local posX = 0;
		local posY = 0;
		for tier = 0, DT.MAX_NUM_TIER - 1 do
			for value = 1, DT.MAX_NUM_COL do
				local id = tier * DT.MAX_NUM_COL + value;
				local Node = MT._TreeFunc.CreateNode(TreeFrame, tier, value);
				Node:SetPoint("TOP", TreeFrame, "TOP", (CT.TUISTYLE.TreeNodeXSize + CT.TUISTYLE.TreeNodeXGap) * (posX - DT.MAX_NUM_COL * 0.5 + 0.5), -CT.TUISTYLE.TreeFrameHeaderYSize - CT.TUISTYLE.TreeNodeYToTop - (CT.TUISTYLE.TreeNodeYSize + CT.TUISTYLE.TreeNodeYGap) * posY);
				Node:Hide();
				TreeNodes[id] = Node;

				posX = posX + 1;
			end
			posX = 0;
			posY = posY + 1;
		end

		return TreeNodes;
	end
	function MT.UI.CreateTreeFrames(Frame)
		local TreeFrames = {  };

		local TreeFrame = CreateFrame('FRAME', nil, Frame);
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

		TreeFrame:SetPoint("TOP", Frame, "TOP", 0, -CT.TUISTYLE.TreeFrameYToBorder - CT.TUISTYLE.FrameHeaderYSize);

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

		TreeFrame.Frame = Frame;
		TreeFrame.TalentSet = {  };
		for tier = 0, DT.MAX_NUM_TALENTS - 1 do
			TreeFrame.TalentSet[tier + 1] = 0;
		end

		TreeFrames[1] = TreeFrame;

		return TreeFrames;
	end

-->

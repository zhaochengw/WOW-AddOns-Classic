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
	local floor = math.floor;
	local sin360 = sin;
	local cos360 = cos;
	local IsControlKeyDown = IsControlKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;
	local CreateFrame = CreateFrame;
	local DressUpItemLink = DressUpItemLink;
	local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend;
	local GameTooltip = GameTooltip;

-->
	local l10n = CT.l10n;

-->
MT.BuildEnv('UI-EquipmentContainer');
-->		predef
-->		EquipmentContainer & GlyphContainer
	MT._LeftFunc = {  };
	function MT._LeftFunc.Node_OnEnter(Node)
		if Node.link ~= nil then
			GameTooltip:SetOwner(Node, "ANCHOR_LEFT");
			GameTooltip:SetHyperlink(Node.link);
			MT.ColorItemSet(Node, GameTooltip);
			MT.ColorMetaGem(Node, GameTooltip);
		end
	end
	function MT._LeftFunc.Node_OnLeave(Node, motion)
		if GameTooltip:IsOwned(Node) then
			GameTooltip:Hide();
		end
	end
	function MT._LeftFunc.Node_OnClick(Node)
		if IsShiftKeyDown() then
			if Node.link ~= nil then
				local editBox = ChatEdit_ChooseBoxForSend();
				editBox:Show();
				editBox:SetFocus();
				editBox:Insert(Node.link);
			end
		elseif IsControlKeyDown() then
			if Node.link ~= nil then
				DressUpItemLink(Node.link);
			end
		end
	end
	function MT._LeftFunc.Container_OnShow(EquipmentFrameContainer)
		local Frame = EquipmentFrameContainer.Frame;
		if Frame.name ~= nil then
			MT.UI.EquipmentContainerUpdate(Frame.EquipmentContainer, VT.TQueryCache[Frame.name]);
			MT.UI.EngravingContainerUpdate(Frame.EquipmentContainer, VT.TQueryCache[Frame.name]);
			if VT.__support_glyph then
				MT.UI.GlyphContainerUpdate(Frame.GlyphContainer, VT.TQueryCache[Frame.name].GlyData);
			end
		end
	end
	function MT._LeftFunc.GlyphNode_OnEnter(Node)
		local SpellID = Node.SpellID;
		if SpellID ~= nil then
			GameTooltip:SetOwner(Node, "ANCHOR_RIGHT");
			GameTooltip:SetSpellByID(SpellID);
			GameTooltip:AddLine(Node.TypeText, 0.75, 0.75, 1.0);
			GameTooltip:Show();
		end
	end
	function MT._LeftFunc.GlyphNode_OnLeave(Node)
		GameTooltip:Hide();
	end
	function MT._LeftFunc.EngravingNode_OnEnter(Node)
		if Node.id ~= nil then
			GameTooltip:SetOwner(Node, "ANCHOR_LEFT");
			GameTooltip:SetSpellByID(Node.id);
		end
	end
	function MT._LeftFunc.EngravingNode_OnLeave(Node, motion)
		if GameTooltip:IsOwned(Node) then
			GameTooltip:Hide();
		end
	end
	function MT._LeftFunc.EngravingNode_OnClick(Node)
		-- if IsShiftKeyDown() then
		-- 	if Node.link ~= nil then
		-- 		local editBox = ChatEdit_ChooseBoxForSend();
		-- 		editBox:Show();
		-- 		editBox:SetFocus();
		-- 		editBox:Insert(Node.link);
		-- 	end
		-- elseif IsControlKeyDown() then
		-- 	if Node.link ~= nil then
		-- 		DressUpItemLink(Node.link);
		-- 	end
		-- end
	end
	function MT.UI.CreateEquipmentFrame(Frame)
		local EquipmentFrameContainer = CreateFrame('FRAME', nil, Frame);
		EquipmentFrameContainer:SetPoint("TOPRIGHT", Frame, "TOPLEFT", 0, 0);
		EquipmentFrameContainer:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMLEFT", 0, 0);
		EquipmentFrameContainer:SetWidth(CT.TUISTYLE.EquipmentFrameXSize);
		VT.__dep.uireimp._SetSimpleBackdrop(EquipmentFrameContainer, 0, 1, 0.0, 0.0, 0.0, 0.95, 0.0, 0.0, 0.0, 1.0);
		EquipmentFrameContainer:Hide();
		EquipmentFrameContainer:SetScript("OnShow", MT._LeftFunc.Container_OnShow);
		EquipmentFrameContainer.Frame = Frame;
		--
		local EquipmentContainer = CreateFrame('FRAME', nil, EquipmentFrameContainer);
		EquipmentContainer:SetSize(CT.TUISTYLE.EquipmentFrameXSize, CT.TUISTYLE.EquipmentContainerYSize);
		if VT.__support_glyph then
			EquipmentContainer:SetPoint("TOP", EquipmentFrameContainer);
		else
			EquipmentContainer:SetPoint("BOTTOM", EquipmentFrameContainer);
		end
		EquipmentContainer:Show();

		local AverageItemLevelLabel = EquipmentContainer:CreateFontString(nil, "ARTWORK");
		AverageItemLevelLabel:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSize, CT.TUISTYLE.FrameFontOutline);
		AverageItemLevelLabel:SetPoint("BOTTOMRIGHT", EquipmentContainer, "TOP", -1, 2);
		AverageItemLevelLabel:SetText(l10n.EquipmentList_AverageItemLevel);
		local AverageItemLevel = EquipmentContainer:CreateFontString(nil, "ARTWORK");
		AverageItemLevel:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSize, CT.TUISTYLE.FrameFontOutline);
		AverageItemLevel:SetPoint("BOTTOMLEFT", EquipmentContainer, "TOP", 1, 2);
		EquipmentContainer.AverageItemLevel = AverageItemLevel;

		local EquipmentNodes = {  };
		local EngravingNodes = {  };
		for slot = 0, 19 do
			local Node = CreateFrame('BUTTON', nil, EquipmentContainer);
			Node:SetSize(CT.TUISTYLE.EquipmentNodeSize, CT.TUISTYLE.EquipmentNodeSize);
			Node:Show();

			Node:EnableMouse(true);
			Node:SetScript("OnEnter", MT._LeftFunc.Node_OnEnter);
			Node:SetScript("OnLeave", MT._LeftFunc.Node_OnLeave);
			Node:SetScript("OnClick", MT._LeftFunc.Node_OnClick);

			Node:SetNormalTexture(CT.TTEXTURESET.UNK);
			MT._TextureFunc.SetHighlightTexture(Node, CT.TTEXTURESET.EQUIPMENT.Highlight);

			Node.Border = MT._TextureFunc.CreateFlatBorder(Node, 3);

			local Glow = Node:CreateTexture(nil, "OVERLAY");
			Glow:SetAllPoints();
			Glow:SetBlendMode("ADD");
			MT._TextureFunc.SetTexture(Glow, CT.TTEXTURESET.EQUIPMENT.Glow);
			Glow:Show();
			Node.Glow = Glow;

			local ILvl = Node:CreateFontString(nil, "OVERLAY");
			ILvl:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeMedium, CT.TUISTYLE.FrameFontOutline);
			ILvl:SetPoint("BOTTOMRIGHT", Node, "BOTTOMRIGHT", 0, 2);
			Node.ILvl = ILvl;

			local Name = Node:CreateFontString(nil, "OVERLAY");
			Name:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeMedium, CT.TUISTYLE.FrameFontOutline);
			Node.Name = Name;

			local Ench = Node:CreateFontString(nil, "OVERLAY");
			Ench:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeMedium, CT.TUISTYLE.FrameFontOutline);
			Node.Ench = Ench;

			local Gem = Node:CreateFontString(nil, "OVERLAY");
			Gem:SetFont(CT.TUISTYLE.FrameFont, CT.TUISTYLE.FrameFontSizeMedium, CT.TUISTYLE.FrameFontOutline);
			Node.Gem = Gem;

			Node.EquipmentContainer = EquipmentContainer;
			Node.slot = slot;
			EquipmentNodes[slot] = Node;

			local Engr = CreateFrame('BUTTON', nil, Node);
			Engr:SetSize(CT.TUISTYLE.EngravingNodeSize, CT.TUISTYLE.EngravingNodeSize);
			Engr:Hide();

			Engr:EnableMouse(true);
			Engr:SetScript("OnEnter", MT._LeftFunc.EngravingNode_OnEnter);
			Engr:SetScript("OnLeave", MT._LeftFunc.EngravingNode_OnLeave);
			Engr:SetScript("OnClick", MT._LeftFunc.EngravingNode_OnClick);

			MT._TextureFunc.SetNormalTexture(Engr, CT.TTEXTURESET.ENGRAVING.Normal);
			MT._TextureFunc.SetHighlightTexture(Engr, CT.TTEXTURESET.ENGRAVING.Highlight);

			Engr.EquipmentContainer = EquipmentContainer;
			Engr.slot = slot;
			EngravingNodes[slot] = Engr;
		end
		local L, R, B, H = CT.TUISTYLE.EquipmentNodeLayout.L, CT.TUISTYLE.EquipmentNodeLayout.R, CT.TUISTYLE.EquipmentNodeLayout.B, CT.TUISTYLE.EquipmentNodeLayout.H;
		for index, slot in next, L do
			local Node = EquipmentNodes[slot];
			Node:SetPoint("TOPLEFT", CT.TUISTYLE.EquipmentNodeXToBorder, -CT.TUISTYLE.EquipmentNodeYToBorder - (CT.TUISTYLE.EquipmentNodeSize + CT.TUISTYLE.EquipmentNodeGap) * (index - 1));
			Node.Name:SetPoint("TOPLEFT", Node, "TOPRIGHT", CT.TUISTYLE.EquipmentNodeTextGap, 0);
			Node.Ench:SetPoint("LEFT", Node, "RIGHT", CT.TUISTYLE.EquipmentNodeTextGap, 0);
			Node.Gem:SetPoint("BOTTOMLEFT", Node, "BOTTOMRIGHT", CT.TUISTYLE.EquipmentNodeTextGap, 0);
			local Engr = EngravingNodes[slot];
			Engr:SetPoint("TOPLEFT", -2, 2);
		end
		for index, slot in next, R do
			local Node = EquipmentNodes[slot];
			Node:SetPoint("TOPRIGHT", -CT.TUISTYLE.EquipmentNodeXToBorder, -CT.TUISTYLE.EquipmentNodeYToBorder - (CT.TUISTYLE.EquipmentNodeSize + CT.TUISTYLE.EquipmentNodeGap) * (index - 1));
			Node.Name:SetPoint("BOTTOMRIGHT", Node, "BOTTOMLEFT", -CT.TUISTYLE.EquipmentNodeTextGap, 0);
			Node.Ench:SetPoint("RIGHT", Node, "LEFT", -CT.TUISTYLE.EquipmentNodeTextGap, 0);
			Node.Gem:SetPoint("TOPRIGHT", Node, "TOPLEFT", -CT.TUISTYLE.EquipmentNodeTextGap, 0);
			local Engr = EngravingNodes[slot];
			Engr:SetPoint("TOPRIGHT", 2, 2);
		end
		local top = ceil(#B * 0.5) - 1;
		for index, slot in next, B do
			local Node = EquipmentNodes[slot];
			Node:SetPoint("BOTTOM",
				((index - 1) % 2 - 0.5) * (CT.TUISTYLE.EquipmentNodeSize + CT.TUISTYLE.EquipmentNodeGap),
				(top - floor((index - 1) / 2)) * (CT.TUISTYLE.EquipmentNodeSize + CT.TUISTYLE.EquipmentNodeGap) + CT.TUISTYLE.EquipmentNodeYToBorder);
			if (index - 1) % 2 == 0 then
				Node.Name:SetPoint("TOPRIGHT", Node, "TOPLEFT", -CT.TUISTYLE.EquipmentNodeTextGap, 0);
				Node.Ench:SetPoint("RIGHT", Node, "LEFT", -CT.TUISTYLE.EquipmentNodeTextGap, 0);
				Node.Gem:SetPoint("BOTTOMRIGHT", Node, "BOTTOMLEFT", -CT.TUISTYLE.EquipmentNodeTextGap, 0);
				local Engr = EngravingNodes[slot];
				Engr:SetPoint("TOPLEFT", -2, 2);
			else
				Node.Name:SetPoint("TOPLEFT", Node, "TOPRIGHT", CT.TUISTYLE.EquipmentNodeTextGap, 0);
				Node.Ench:SetPoint("LEFT", Node, "RIGHT", CT.TUISTYLE.EquipmentNodeTextGap, 0);
				Node.Gem:SetPoint("BOTTOMLEFT", Node, "BOTTOMRIGHT", CT.TUISTYLE.EquipmentNodeTextGap, 0);
				local Engr = EngravingNodes[slot];
				Engr:SetPoint("TOPRIGHT", -2, 2);
			end
		end
		if H then
			for index, slot in next, H do
				local Node = EquipmentNodes[slot];
				Node:Hide();
			end
		end
		EquipmentContainer.Frame = Frame;
		EquipmentContainer.EquipmentFrameContainer = EquipmentFrameContainer;
		EquipmentContainer.EquipmentNodes = EquipmentNodes;
		EquipmentContainer.EngravingNodes = EngravingNodes;
		EquipmentFrameContainer.EquipmentContainer = EquipmentContainer;
		--
		local GlyphContainer = nil;
		if VT.__support_glyph then
			GlyphContainer = CreateFrame('FRAME', nil, EquipmentFrameContainer);
			if CT.BUILD == "WRATH" then
				GlyphContainer:SetPoint("BOTTOM", EquipmentFrameContainer);
			else
				GlyphContainer:SetPoint("TOP", EquipmentFrameContainer, "BOTTOM");
			end
			GlyphContainer:SetSize(CT.TUISTYLE.GlyphFrameSize, CT.TUISTYLE.GlyphFrameSize);
			GlyphContainer:Show();
			local GlyphNodes = {  };
			--[[	wlk
						1
					3		5
					6		4
						2
			--]]
			--[[	cata
						7
					4	2	1
						3   5
					8	6	9
					--
					146 Major = 1
					235	Minor = 2
					789	PRIME = 3
			--]]
			local SIZELOOKUP = {
				[1] = CT.TUISTYLE.MajorGlyphNodeSize,
				[2] = CT.TUISTYLE.MinorGlyphNodeSize,
				[3] = CT.TUISTYLE.PrimeGlyphNodeSize,
			};
			--local R = CT.TUISTYLE.GlyphFrameSize * 0.5 - size * 0.5 - 2;
			local RADIUSLOOKUP = {
				[1] = CT.TUISTYLE.MinorGlyphNodeSize * 0.5 + CT.TUISTYLE.MajorGlyphNodeSize * 0.5,
				[2] = CT.TUISTYLE.MinorGlyphNodeSize * 0.5,
				[3] = CT.TUISTYLE.MinorGlyphNodeSize * 0.75 + CT.TUISTYLE.PrimeGlyphNodeSize * 0.5,
			};
			local NodesDef, RingCoord, HighlightCoord;
			if CT.BUILD == "WRATH" then
				NodesDef = {
					--	 type angle (         rgba        ) (                 coords                 )
					[0] = { 0,   0, 0.00, 0.00, 0.00, 1.00, 0.78125    , 0.91015625 , 0.69921875, 0.828125, },
					[1] = { 1,   0, 1.00, 0.25, 0.00, 1.00, 0.0        , 0.12890625 , 0.87109375, 1.0, },
					[2] = { 2, 180, 0.00, 0.25, 1.00, 1.00, 0.130859375, 0.259765625, 0.87109375, 1.0, },
					[3] = { 2, 300, 0.00, 0.25, 1.00, 1.00, 0.392578125, 0.521484375, 0.87109375, 1.0, },
					[4] = { 1, 120, 1.00, 0.25, 0.00, 1.00, 0.5234375  , 0.65234375 , 0.87109375, 1.0, },
					[5] = { 2,  60, 0.00, 0.25, 1.00, 1.00, 0.26171875 , 0.390625   , 0.87109375, 1.0, },
					[6] = { 1, 240, 1.00, 0.25, 0.00, 1.00, 0.654296875, 0.783203125, 0.87109375, 1.0, },
				};
				RingCoord = {
					[1] = { 0.787109375, 0.908203125, 0.033203125, 0.154296875, },
					[2] = { 0.787109375, 0.908203125, 0.033203125, 0.154296875, },
				};
				HighlightCoord = {
					[1] = { 0.765625, 0.927734375, 0.15625, 0.31640625, },
					[2] = { 0.765625, 0.927734375, 0.15625, 0.31640625, },
				};
			elseif CT.BUILD == "MISTS" then
				SIZELOOKUP = {
					[1] = CT.TUISTYLE.PrimeGlyphNodeSize,
					[2] = CT.TUISTYLE.MajorGlyphNodeSize,
				};
				--local R = CT.TUISTYLE.GlyphFrameSize * 0.5 - size * 0.5 - 2;
				RADIUSLOOKUP = {
					[1] = CT.TUISTYLE.MinorGlyphNodeSize * 0.75 + CT.TUISTYLE.PrimeGlyphNodeSize * 0.5,
					[2] = CT.TUISTYLE.MinorGlyphNodeSize * 0.5 + CT.TUISTYLE.MajorGlyphNodeSize * 0.5,
				};
				NodesDef = {
					[0] = { 0,   0, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[1] = { 2,  60, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[2] = { 1,   0, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[3] = { 2, 300, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[4] = { 1, 240, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[5] = { 2, 180, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[6] = { 1, 120, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
				};
				RingCoord = {
					[1] = { 0.85839844, 0.93847656, 0.22265625, 0.30273438, },
					[2] = { 0.85839844, 0.92285156, 0.00097656, 0.06542969, },
				};
				HighlightCoord = {
					[1] = { 0.85839844, 0.95214844, 0.30468750, 0.39843750, },
					[2] = { 0.85839844, 0.93652344, 0.06738281, 0.14550781, },
				};
			else
				NodesDef = {
					[0] = { 0,   0, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[1] = { 1,  60, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[2] = { 2,   0, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[3] = { 2, 240, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[4] = { 1, 300, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[5] = { 2, 120, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[6] = { 1, 180, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[7] = { 3,   0, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[8] = { 3, 240, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					[9] = { 3, 120, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
				};
				RingCoord = {
					[1] = { 0.85839844, 0.92285156, 0.00097656, 0.06542969, },
					[2] = { 0.92480469, 0.98437500, 0.00097656, 0.06054688, },
					[3] = { 0.85839844, 0.93847656, 0.22265625, 0.30273438, },
				};
				HighlightCoord = {
					[1] = { 0.85839844, 0.93652344, 0.06738281, 0.14550781, },
					[2] = { 0.85839844, 0.93164063, 0.14746094, 0.22070313, },
					[3] = { 0.85839844, 0.95214844, 0.30468750, 0.39843750, },
				};
			end
			for index = 1, #NodesDef do
				local def = NodesDef[index];
				local size = SIZELOOKUP[def[1]];
				local R = RADIUSLOOKUP[def[1]];
				local Node = CreateFrame('BUTTON', nil, GlyphContainer);
				Node:SetSize(size, size);
				Node:SetPoint("CENTER", GlyphContainer, "CENTER", R * sin360(def[2]), R * cos360(def[2]) + CT.TUISTYLE.EquipmentNodeXToBorder);
				Node:SetScript("OnEnter", MT._LeftFunc.GlyphNode_OnEnter);
				Node:SetScript("OnLeave", MT._LeftFunc.GlyphNode_OnLeave);
				if CT.BUILD == "WRATH" then
					local Setting = Node:CreateTexture(nil, "ARTWORK");
					Setting:SetSize(size * 1.2, size * 1.2);
					Setting:SetPoint("CENTER", 0, 0);
					Setting:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
					Setting:SetTexCoord(0.765625, 0.927734375, 0.15625, 0.31640625);
					local Background = Node:CreateTexture(nil, "BORDER");
					Background:SetSize(size * 1.2, size * 1.2);
					Background:SetPoint("CENTER", 0, 0);
					Background:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
					Background:SetTexCoord(0.78125, 0.91015625, 0.69921875, 0.828125);
					Node.Setting = Setting;
					Node.Background = Background;
				end
				local Highlight = Node:CreateTexture(nil, "BORDER");
				if CT.BUILD == "WRATH" then
					Highlight:SetSize(size * 1.2, size * 1.2);
				else
					Highlight:SetSize(size, size);
				end
				Highlight:SetPoint("CENTER", 0, 0);
				Highlight:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
				local hc = HighlightCoord[def[1]];
				Highlight:SetTexCoord(hc[1], hc[2], hc[3], hc[4]);
				Highlight:SetVertexColor(1.0, 1.0, 1.0, 0.25);
				Highlight:SetBlendMode("ADD");
				Highlight:Hide();
				Node:SetHighlightTexture(Highlight);
				local Glyph = Node:CreateTexture(nil, "ARTWORK");
				Glyph:SetSize(size * 0.75, size * 0.75);
				Glyph:SetPoint("CENTER", 0, 0);
				Glyph:SetTexture([[Interface\Spellbook\UI-Glyph-Rune1]]);
				Glyph:SetVertexColor(def[3], def[4], def[5], def[6]);
				Glyph:SetBlendMode("BLEND");
				Glyph:Hide();
				local Ring = Node:CreateTexture(nil, "OVERLAY");
				Ring:SetSize(size * 0.86, size * 0.86);
				Ring:SetPoint("CENTER", 0, 1);
				Ring:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
				local rc = RingCoord[def[1]];
				Ring:SetTexCoord(rc[1], rc[2], rc[3], rc[4]);
				if CT.BUILD == "WRATH" then
					local Shine = Node:CreateTexture(nil, "OVERLAY");
					Shine:SetSize(size / 6, size / 6);
					Shine:SetPoint("CENTER", -size / 8, size / 6);
					Shine:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
					Shine:SetTexCoord(0.9609375, 1.0, 0.921875, 0.9609375);
					Node.Shine = Shine;
				end
				Node.Type = def[1];
				if Node.Type == 1 then
					Node.TypeText = l10n.MAJOR_GLYPH;
				elseif Node.Type == 2 then
					Node.TypeText = l10n.MINOR_GLYPH;
				else
					Node.TypeText = l10n.PRIME_GLYPH;
				end
				Node.ID = index;
				Node.Highlight = Highlight;
				Node.Glyph = Glyph;
				Node.Ring = Ring;
				Node.def = def;
				Node.d0 = NodesDef[0];
				GlyphNodes[index] = Node;
			end
			GlyphContainer.Frame = Frame;
			GlyphContainer.EquipmentFrameContainer = EquipmentFrameContainer;
			GlyphContainer.GlyphNodes = GlyphNodes;
			EquipmentFrameContainer.GlyphContainer = GlyphContainer;
		end
		--
		return EquipmentFrameContainer, EquipmentContainer, GlyphContainer;
	end

-->

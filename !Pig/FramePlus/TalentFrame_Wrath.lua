local _, addonTable = ...;
local fuFrame=List_R_F_1_5
local ADD_Checkbutton=addonTable.ADD_Checkbutton
----------------
local gundongWW,gundongHH,ScrollPY,ScaleZhi = 290, 636, -90, 0.76
local allwww = 920
--
local jianjuzhi = 53
local function SetBranchTexture_pig(TalentFrame) --重新设置系统目录位置
	local name, icon, pointsSpent, background, previewPointsSpent = GetTalentTabInfo(1, TalentFrame.inspect, TalentFrame.pet, TalentFrame.talentGroup);
	local displayPointsSpent = pointsSpent + previewPointsSpent;
	PlayerTalentFrameScrollFrame.Tianfu:SetText(name..":");
	PlayerTalentFrameScrollFrame.TianfuV:SetText(displayPointsSpent);
	local node;
	local xOffset, yOffset;
	local ignoreUp;
	local tempNode;
	TalentFrame_ResetBranchTextureCount(TalentFrame);
	TalentFrame_ResetArrowTextureCount(TalentFrame);
	for i=1, MAX_NUM_TALENT_TIERS do
		for j=1, NUM_TALENT_COLUMNS do
			node = TalentFrame.TALENT_BRANCH_ARRAY[i][j];
			xOffset = ((j - 1) * 63) + INITIAL_TALENT_OFFSET_X + 2;
			yOffset = -((i - 1) * jianjuzhi) - INITIAL_TALENT_OFFSET_Y - 2;
			if ( node.id ) then
				if ( node.up ~= 0 ) then
					if ( not ignoreUp ) then
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["up"][node.up], xOffset, yOffset + TALENT_BUTTON_SIZE, TalentFrame);
					else
						ignoreUp = nil;
					end
				end
				if ( node.down ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset, yOffset - TALENT_BUTTON_SIZE + 1, TalentFrame);
				end
				if ( node.left ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["left"][node.left], xOffset - TALENT_BUTTON_SIZE, yOffset, TalentFrame);
				end
				if ( node.right ~= 0 ) then
					tempNode = TalentFrame.TALENT_BRANCH_ARRAY[i][j+1];	
					if ( tempNode.left ~= 0 and tempNode.down < 0 ) then
						TalentFrame_SetBranchTexture(i, j-1, TALENT_BRANCH_TEXTURECOORDS["right"][tempNode.down], xOffset + TALENT_BUTTON_SIZE, yOffset, TalentFrame);
					else
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["right"][node.right], xOffset + TALENT_BUTTON_SIZE + 1, yOffset, TalentFrame);
					end
				end
				if ( node.rightArrow ~= 0 ) then
					TalentFrame_SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS["right"][node.rightArrow], xOffset + TALENT_BUTTON_SIZE/2 + 5, yOffset, TalentFrame);
				end
				if ( node.leftArrow ~= 0 ) then
					TalentFrame_SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS["left"][node.leftArrow], xOffset - TALENT_BUTTON_SIZE/2 - 5, yOffset, TalentFrame);
				end
				if ( node.topArrow ~= 0 ) then
					TalentFrame_SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS["top"][node.topArrow], xOffset, yOffset + TALENT_BUTTON_SIZE/2 + 5, TalentFrame);
				end
			else
				if ( node.up ~= 0 and node.left ~= 0 and node.right ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["tup"][node.up], xOffset , yOffset, TalentFrame);
				elseif ( node.down ~= 0 and node.left ~= 0 and node.right ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["tdown"][node.down], xOffset , yOffset, TalentFrame);
				elseif ( node.left ~= 0 and node.down ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["topright"][node.left], xOffset , yOffset, TalentFrame);
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32, TalentFrame);
				elseif ( node.left ~= 0 and node.up ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["bottomright"][node.left], xOffset , yOffset, TalentFrame);
				elseif ( node.left ~= 0 and node.right ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["right"][node.right], xOffset + TALENT_BUTTON_SIZE, yOffset, TalentFrame);
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["left"][node.left], xOffset + 1, yOffset, TalentFrame);
				elseif ( node.right ~= 0 and node.down ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["topleft"][node.right], xOffset , yOffset, TalentFrame);
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32, TalentFrame);
				elseif ( node.right ~= 0 and node.up ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["bottomleft"][node.right], xOffset , yOffset, TalentFrame);
				elseif ( node.up ~= 0 and node.down ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["up"][node.up], xOffset , yOffset, TalentFrame);
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32, TalentFrame);
					ignoreUp = 1;
				end
			end
		end
	end
end
local function TalentFrame_Update_Pig(TFID)
	local TalentFrame =PlayerTalentFrame
	local talentFrameName = "PlayerTalentFrame"..TFID;
	local fujik = _G["PlayerTalentFrame"..TFID]
	local selectedTab = TFID
	local preview = GetCVarBool("previewTalents");

	local isActiveTalentGroup;
	if ( TalentFrame.inspect ) then
		isActiveTalentGroup = true;
	else
		isActiveTalentGroup = TalentFrame.talentGroup == GetActiveTalentGroup(TalentFrame.inspect, TalentFrame.pet);
	end
	local base;
	local name, icon, pointsSpent, background, previewPointsSpent = GetTalentTabInfo(selectedTab, TalentFrame.inspect, TalentFrame.pet, TalentFrame.talentGroup);
	PlayerTalentFrame.pointsSpent = pointsSpent;
	PlayerTalentFrame.previewPointsSpent = previewPointsSpent;
	local displayPointsSpent = pointsSpent + previewPointsSpent;
	if TalentFrame.pet then
		PlayerTalentFrameScrollFrame:SetSize(gundongWW*4-24,gundongHH);
		PlayerTalentFrameScrollChildFrame:ClearAllPoints();
		PlayerTalentFrameScrollChildFrame:SetPoint("TOP");
		_G["PlayerTalentFrame"..TFID.."ScrollFrame"]:Hide()
		PlayerTalentFrame_HideGlyphFrame()
	else
		PlayerTalentFrameScrollFrame:SetSize(gundongWW,gundongHH);
		PlayerTalentFrameScrollChildFrame:ClearAllPoints();
		PlayerTalentFrameScrollChildFrame:SetPoint("TOPLEFT");
		_G["PlayerTalentFrame"..TFID.."ScrollFrame"]:Show()
		_G["PlayerTalentFrame"..TFID.."ScrollFrame"].Tianfu:SetText(name..":");
		_G["PlayerTalentFrame"..TFID.."ScrollFrame"].TianfuV:SetText(displayPointsSpent);
	end

	if ( name ) then
		base = "Interface\\TalentFrame\\"..background.."-";
	else
		base = "Interface\\TalentFrame\\MageFire-";
	end
	local backgroundPiece = _G[talentFrameName.."BackgroundTopLeft"];
	backgroundPiece:SetTexture(base.."TopLeft");
	SetDesaturation(backgroundPiece, not isActiveTalentGroup);
	backgroundPiece = _G[talentFrameName.."BackgroundTopRight"];
	backgroundPiece:SetTexture(base.."TopRight");
	SetDesaturation(backgroundPiece, not isActiveTalentGroup);
	backgroundPiece = _G[talentFrameName.."BackgroundBottomLeft"];
	backgroundPiece:SetTexture(base.."BottomLeft");
	SetDesaturation(backgroundPiece, not isActiveTalentGroup);
	backgroundPiece = _G[talentFrameName.."BackgroundBottomRight"];
	backgroundPiece:SetTexture(base.."BottomRight");
	SetDesaturation(backgroundPiece, not isActiveTalentGroup);

	local numTalents = GetNumTalents(selectedTab, TalentFrame.inspect, TalentFrame.pet);

	local unspentPoints = TalentFrame_UpdateTalentPoints(TalentFrame);
	local tabPointsSpent;
	if ( TalentFrame.pointsSpent and TalentFrame.previewPointsSpent ) then
		tabPointsSpent = TalentFrame.pointsSpent + TalentFrame.previewPointsSpent;
	else
		tabPointsSpent = 0;
	end
	TalentFrame_ResetBranches(TalentFrame);

	local talentFrameTalentName = talentFrameName.."Talent";
	local forceDesaturated, tierUnlocked;
	for i=1, MAX_NUM_TALENTS do
		local buttonName = talentFrameTalentName..i;
		local button = _G[buttonName];
		if ( i <= numTalents ) then
			local name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq, previewRank, meetsPreviewPrereq =
				GetTalentInfo(selectedTab, i, TalentFrame.inspect, TalentFrame.pet, TalentFrame.talentGroup);
			if ( name ) then
				local displayRank;
				if ( preview ) then
					displayRank = previewRank;
				else
					displayRank = rank;
				end

				_G[buttonName.."Rank"]:SetText(displayRank);
				SetTalentButtonLocation(button, tier, column);
				TalentFrame.TALENT_BRANCH_ARRAY[tier][column].id = button:GetID();

				if ( (unspentPoints <= 0 or not isActiveTalentGroup) and displayRank == 0 ) then
				forceDesaturated = 1;
			else
				forceDesaturated = nil;
			end

			if ( ((tier - 1) * (TalentFrame.pet and PET_TALENTS_PER_TIER or PLAYER_TALENTS_PER_TIER) <= tabPointsSpent) ) then
				tierUnlocked = 1;
			else
				tierUnlocked = nil;
			end

			SetItemButtonTexture(button, iconTexture);
	
			local prereqsSet =
				TalentFrame_SetPrereqs(TalentFrame, tier, column, forceDesaturated, tierUnlocked, preview,
				GetTalentPrereqs(selectedTab, i, TalentFrame.inspect, TalentFrame.pet, TalentFrame.talentGroup));
			if ( prereqsSet and ((preview and meetsPreviewPrereq) or (not preview and meetsPrereq)) ) then
				SetItemButtonDesaturated(button, nil);

				if ( displayRank < maxRank ) then
					_G[buttonName.."Slot"]:SetVertexColor(0.1, 1.0, 0.1);
					_G[buttonName.."Rank"]:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
				else
					_G[buttonName.."Slot"]:SetVertexColor(1.0, 0.82, 0);
					_G[buttonName.."Rank"]:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
				end
				_G[buttonName.."RankBorder"]:Show();
				_G[buttonName.."Rank"]:Show();
			else
				SetItemButtonDesaturated(button, 1, 0.65, 0.65, 0.65);
				_G[buttonName.."Slot"]:SetVertexColor(0.5, 0.5, 0.5);
				if ( rank == 0 ) then
						_G[buttonName.."RankBorder"]:Hide();
						_G[buttonName.."Rank"]:Hide();
				else
						_G[buttonName.."RankBorder"]:SetVertexColor(0.5, 0.5, 0.5);
						_G[buttonName.."Rank"]:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
				end
			end
			button:Show();
			else
				button:Hide();
			end
		else	
			button:Hide();
		end
	end

	local node;
	local xOffset, yOffset;
	local ignoreUp;
	local tempNode;
	
	TalentFrame_ResetBranchTextureCount(fujik);
	TalentFrame_ResetArrowTextureCount(fujik);
	for i=1, MAX_NUM_TALENT_TIERS do
		for j=1, NUM_TALENT_COLUMNS do
			node = TalentFrame.TALENT_BRANCH_ARRAY[i][j];
			xOffset = ((j - 1) * 63) + INITIAL_TALENT_OFFSET_X + 2;
			yOffset = -((i - 1) * jianjuzhi) - INITIAL_TALENT_OFFSET_Y - 2;
		
			if ( node.id ) then
				if ( node.up ~= 0 ) then
					if ( not ignoreUp ) then
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["up"][node.up], xOffset, yOffset + TALENT_BUTTON_SIZE, fujik);
					else
						ignoreUp = nil;
					end
				end
				if ( node.down ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset, yOffset - TALENT_BUTTON_SIZE + 1, fujik);
				end
				if ( node.left ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["left"][node.left], xOffset - TALENT_BUTTON_SIZE, yOffset, fujik);
				end
				if ( node.right ~= 0 ) then
					tempNode = TalentFrame.TALENT_BRANCH_ARRAY[i][j+1];	
					if ( tempNode.left ~= 0 and tempNode.down < 0 ) then
						TalentFrame_SetBranchTexture(i, j-1, TALENT_BRANCH_TEXTURECOORDS["right"][tempNode.down], xOffset + TALENT_BUTTON_SIZE, yOffset, fujik);
					else
						TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["right"][node.right], xOffset + TALENT_BUTTON_SIZE + 1, yOffset, fujik);
					end
					
				end
				if ( node.rightArrow ~= 0 ) then
					TalentFrame_SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS["right"][node.rightArrow], xOffset + TALENT_BUTTON_SIZE/2 + 5, yOffset, fujik);
				end
				if ( node.leftArrow ~= 0 ) then
					TalentFrame_SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS["left"][node.leftArrow], xOffset - TALENT_BUTTON_SIZE/2 - 5, yOffset, fujik);
				end
				if ( node.topArrow ~= 0 ) then
					TalentFrame_SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS["top"][node.topArrow], xOffset, yOffset + TALENT_BUTTON_SIZE/2 + 5, fujik);
				end
			else
				if ( node.up ~= 0 and node.left ~= 0 and node.right ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["tup"][node.up], xOffset , yOffset, fujik);
				elseif ( node.down ~= 0 and node.left ~= 0 and node.right ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["tdown"][node.down], xOffset , yOffset, fujik);
				elseif ( node.left ~= 0 and node.down ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["topright"][node.left], xOffset , yOffset, fujik);
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32, fujik);
				elseif ( node.left ~= 0 and node.up ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["bottomright"][node.left], xOffset , yOffset, fujik);
				elseif ( node.left ~= 0 and node.right ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["right"][node.right], xOffset + TALENT_BUTTON_SIZE, yOffset, fujik);
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["left"][node.left], xOffset + 1, yOffset, fujik);
				elseif ( node.right ~= 0 and node.down ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["topleft"][node.right], xOffset , yOffset, fujik);
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32, fujik);
				elseif ( node.right ~= 0 and node.up ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["bottomleft"][node.right], xOffset , yOffset, fujik);
				elseif ( node.up ~= 0 and node.down ~= 0 ) then
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["up"][node.up], xOffset , yOffset, fujik);
					TalentFrame_SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32, fujik);
					ignoreUp = 1;
				end
			end
		end
	end
	for i=TalentFrame_GetBranchTextureCount(fujik), MAX_NUM_BRANCH_TEXTURES do
		_G[talentFrameName.."Branch"..i]:Hide();
	end
	for i=TalentFrame_GetArrowTextureCount(fujik), MAX_NUM_ARROW_TEXTURES do
		_G[talentFrameName.."Arrow"..i]:Hide();
	end
end

local function TalentFrame_ADD()
	UIPanelWindows["PlayerTalentFrame"].with=allwww
	local old_SetTalentButtonLocation=SetTalentButtonLocation
	SetTalentButtonLocation=function(button, tier, column)
		column = ((column - 1) * 63) + INITIAL_TALENT_OFFSET_X;
		tier = -((tier - 1) * jianjuzhi) - INITIAL_TALENT_OFFSET_Y;
		button:SetPoint("TOPLEFT", button:GetParent(), "TOPLEFT", column, tier);
	end
	hooksecurefunc("TalentFrame_UpdateTalentPoints", function(TalentFrame)
		local talentPoints = GetUnspentTalentPoints(TalentFrame.inspect, TalentFrame.pet, TalentFrame.talentGroup);
		local unspentPoints = talentPoints - GetGroupPreviewTalentPointsSpent(TalentFrame.pet, TalentFrame.talentGroup);
		PlayerTalentFrame.shengyuV:SetText(unspentPoints);
	end)
	
	hooksecurefunc("PlayerTalentFrame_ShowGlyphFrame", function()
		if not GlyphFrame.big then
			if ElvUI then
				GlyphFrame:HookScript('OnShow', function()
					PlayerTalentFrameTitleText:Show()
					PlayerTalentFrameScrollFrame:Show()
				end)
			end
			GlyphFrame:ClearAllPoints();
			GlyphFrame:SetPoint("TOPLEFT",PlayerTalentFrame3ScrollFrame,"TOPRIGHT",0,0);
			GlyphFrame:SetPoint("BOTTOMRIGHT",PlayerTalentFrame,"BOTTOMRIGHT",-33,0);
			GlyphFrameBackground:Hide()
			GlyphFrameTitleText:Hide()
			for i=1,6 do
				local GlyphBUT = _G["GlyphFrameGlyph"..i]
				GlyphBUT:SetScale(0.6)
				GlyphBUT:ClearAllPoints();
				GlyphBUT.name = GlyphBUT:CreateFontString();
				if i==2 or i==3 or i==5 then
					GlyphBUT.name:SetPoint("LEFT",GlyphBUT,"RIGHT",0,0);
				else
					GlyphBUT.name:SetPoint("LEFT",GlyphBUT,"RIGHT",6,0);
				end
				GlyphBUT.name:SetFont(ChatFontNormal:GetFont(), 23.4)
			end
			GlyphFrame.big = GlyphFrame:CreateFontString();
			GlyphFrame.big:SetPoint("TOPLEFT",GlyphFrame,"TOPLEFT",10,-10);
			GlyphFrame.big:SetFontObject(GameFontNormal)
			GlyphFrame.big:SetText("大雕文");
			GlyphFrameGlyph1:SetPoint("TOPLEFT",GlyphFrame.big,"BOTTOMLEFT",-4,-10);
			GlyphFrameGlyph4:SetPoint("TOPLEFT",GlyphFrameGlyph1,"BOTTOMLEFT",0,-40);
			GlyphFrameGlyph6:SetPoint("TOPLEFT",GlyphFrameGlyph4,"BOTTOMLEFT",0,-40);
			GlyphFrame.mini = GlyphFrame:CreateFontString();
			GlyphFrame.mini:SetPoint("TOPLEFT",GlyphFrameGlyph6,"BOTTOMLEFT",0,-40);
			GlyphFrame.mini:SetFontObject(GameFontNormal)
			GlyphFrame.mini:SetText("小雕文");
			GlyphFrameGlyph2:SetPoint("TOPLEFT",GlyphFrame.mini,"BOTTOMLEFT",-6,0);
			GlyphFrameGlyph3:SetPoint("TOPLEFT",GlyphFrameGlyph2,"BOTTOMLEFT",0,-8);
			GlyphFrameGlyph5:SetPoint("TOPLEFT",GlyphFrameGlyph3,"BOTTOMLEFT",0,-8);
		end
		for i=1,NUM_GLYPH_SLOTS do
			local link = GetGlyphLink(i, PlayerTalentFrame.talentGroup)
			if link=="" then
				_G["GlyphFrameGlyph"..i].name:SetText("空")
			else
				_G["GlyphFrameGlyph"..i].name:SetText(link)
			end
		end
	end)

	local old_TalentFrame_Update=TalentFrame_Update
	TalentFrame_Update=function(self)
		PlayerTalentFrame_ShowGlyphFrame();
		PanelTemplates_SetTab(self, 1);--pig
		old_TalentFrame_Update(self)
		SetBranchTexture_pig(self)--重写系统原始界面位置
		TalentFrame_Update_Pig(2)
		TalentFrame_Update_Pig(3)
		for i=1,MAX_TALENT_TABS+1 do
			_G["PlayerTalentFrameTab"..i]:Hide()
		end
		PlayerTalentFramePointsBar:Hide();
		PlayerTalentFramePreviewBarFiller:Hide();
		PlayerTalentFramePreviewBarButtonBorder:Hide();
		PlayerTalentFrameLearnButton:SetText("学习模拟结果");
		PlayerTalentFrameLearnButton:SetWidth(120)
		PlayerTalentFrameLearnButton:ClearAllPoints();
		PlayerTalentFrameLearnButton:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPLEFT",690,-40);
		PlayerTalentFrameResetButton:SetText("重置模拟");
		PlayerTalentFrameResetButton:ClearAllPoints();
		PlayerTalentFrameResetButton:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPLEFT",560,-40);
		PlayerTalentFrameCloseButton:SetPoint("CENTER",PlayerTalentFrame,"TOPRIGHT",-44,-25);
		PlayerTalentFrameStatusFrame:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPLEFT",73,-40);
		PlayerTalentFrameActivateButton:SetPoint("TOP",PlayerTalentFrame,"TOP",-273,-40);
		if ElvUI then
			PlayerTalentFrame.backdrop:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPLEFT",0,0);
			PlayerTalentFrame.backdrop:SetPoint("BOTTOMRIGHT",PlayerTalentFrame,"BOTTOMRIGHT",0,0);
			PlayerTalentFrameRoleButton:ClearAllPoints();
			PlayerTalentFrameRoleButton:SetPoint("TOPRIGHT",PlayerTalentFrame,"TOPRIGHT",-30,-34);
		end
	end

	PlayerTalentFrame:SetSize(allwww,gundongHH-76);
	PlayerTalentFrameScrollFrame:SetScale(ScaleZhi);
	PlayerTalentFrameScrollFrameScrollBar:Hide()
	PlayerTalentFrameScrollFrameBackgroundTop:Hide()
	PlayerTalentFrameScrollFrameBackgroundBottom:Hide()
	PlayerTalentFrameScrollFrame:ClearAllPoints();
	PlayerTalentFrameScrollFrame:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPLEFT",22,ScrollPY);
	PlayerTalentFrameScrollFrame:SetSize(gundongWW,gundongHH);

	local function ADD_BGtex(self,texname)
		self.Bg = self:CreateTexture(nil, "BACKGROUND");
		self.Bg:SetTexture("interface/framegeneral/ui-background-rock.blp");
		self.Bg:SetPoint("TOPLEFT", self, "TOPLEFT",14, -15);
		self.Bg:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -36, 5);
		self.Bg:SetDrawLayer("BACKGROUND", -1)
		self.topbg = self:CreateTexture(nil, "BACKGROUND");
		self.topbg:SetTexture(374157);
		self.topbg:SetPoint("TOPLEFT", self, "TOPLEFT",68, -15);
		self.topbg:SetPoint("TOPRIGHT", self, "TOPRIGHT",-57, -15);
		self.topbg:SetTexCoord(0,0.2890625,0,0.421875,1.359809994697571,0.2890625,1.359809994697571,0.421875);
		self.topbg:SetHeight(20);
		self.TOPLEFT = self:CreateTexture(nil, "BORDER");
		self.TOPLEFT:SetTexture("interface/framegeneral/ui-frame.blp");
		self.TOPLEFT:SetPoint("TOPLEFT", self, "TOPLEFT",0, -4);
		self.TOPLEFT:SetTexCoord(0.0078125,0.0078125,0.0078125,0.6171875,0.6171875,0.0078125,0.6171875,0.6171875);
		self.TOPLEFT:SetSize(78,78);
		self.TOPRIGHT = self:CreateTexture(nil, "BORDER");
		self.TOPRIGHT:SetTexture(374156);
		self.TOPRIGHT:SetPoint("TOPRIGHT", self, "TOPRIGHT",-33, -14);
		self.TOPRIGHT:SetTexCoord(0.6328125,0.0078125,0.6328125,0.265625,0.890625,0.0078125,0.890625,0.265625);
		self.TOPRIGHT:SetSize(33,33);
		self.TOP = self:CreateTexture(nil, "BORDER");
		self.TOP:SetTexCoord(0,0.4375,0,0.65625,1.08637285232544,0.4375,1.08637285232544,0.65625);
		self.TOP:SetTexture(374157);
		self.TOP:SetPoint("TOPLEFT", self.TOPLEFT, "TOPRIGHT",0, -10);
		self.TOP:SetPoint("BOTTOMRIGHT", self.TOPRIGHT, "BOTTOMLEFT", 0, 5);
		
		self.BOTTOMLEFT = self:CreateTexture(nil, "BORDER");
		self.BOTTOMLEFT:SetTexture(374156);
		self.BOTTOMLEFT:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT",8, 0);
		self.BOTTOMLEFT:SetTexCoord(0.0078125,0.6328125,0.0078125,0.7421875,0.1171875,0.6328125,0.1171875,0.7421875);
		self.BOTTOMLEFT:SetSize(14,14);

		self.BOTTOMRIGHT = self:CreateTexture(nil, "BORDER");
		self.BOTTOMRIGHT:SetTexture(374156);
		self.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT",-33, 0);
		self.BOTTOMRIGHT:SetTexCoord(0.1328125,0.8984375,0.1328125,0.984375,0.21875,0.8984375,0.21875,0.984375);
		self.BOTTOMRIGHT:SetSize(11,11);

		self.LEFT = self:CreateTexture(nil, "BORDER");
		self.LEFT:SetTexture(374153);
		self.LEFT:SetTexCoord(0.359375,0,0.359375,1.42187488079071,0.609375,0,0.609375,1.42187488079071);
		self.LEFT:SetPoint("TOPLEFT", self.TOPLEFT, "BOTTOMLEFT",8, 0);
		self.LEFT:SetPoint("BOTTOMLEFT", self.BOTTOMLEFT, "TOPLEFT", 0, 0);
		self.LEFT:SetWidth(16);

		self.RIGHT = self:CreateTexture(nil, "BORDER");
		self.RIGHT:SetTexture(374153);
		self.RIGHT:SetTexCoord(0.171875,0,0.171875,1.5703125,0.328125,0,0.328125,1.5703125);
		self.RIGHT:SetPoint("TOPRIGHT", self.TOPRIGHT, "BOTTOMRIGHT",0.8, 0);
		self.RIGHT:SetPoint("BOTTOMRIGHT", self.BOTTOMRIGHT, "TOPRIGHT", 0, 0);
		self.RIGHT:SetWidth(10);

		self.BOTTOM = self:CreateTexture(nil, "BORDER");
		self.BOTTOM:SetTexture(374157);
		self.BOTTOM:SetTexCoord(0,0.203125,0,0.2734375,1.425781607627869,0.203125,1.425781607627869,0.2734375);
		self.BOTTOM:SetPoint("BOTTOMLEFT", self.BOTTOMLEFT, "BOTTOMRIGHT",0, -0);
		self.BOTTOM:SetPoint("BOTTOMRIGHT", self.BOTTOMRIGHT, "BOTTOMLEFT", 0, 0);
		self.BOTTOM:SetHeight(9);
	end
	PlayerTalentFrame.PigBG =ADD_BGtex(PlayerTalentFrame,"TalentFramePigBG_")
	PlayerTalentFrameTopLeft:Hide()
	PlayerTalentFrameTopRight:Hide()
	PlayerTalentFrameBottomLeft:Hide()
	PlayerTalentFrameBottomRight:Hide()

	PlayerTalentFrame.shengyu = PlayerTalentFrame:CreateFontString();
	PlayerTalentFrame.shengyu:SetPoint("TOP",PlayerTalentFrame,"TOP",-80,-44);
	PlayerTalentFrame.shengyu:SetFontObject(GameFontNormal)
	PlayerTalentFrame.shengyu:SetText("剩余天赋点数:");
	PlayerTalentFrame.shengyuV = PlayerTalentFrame:CreateFontString();
	PlayerTalentFrame.shengyuV:SetPoint("LEFT",PlayerTalentFrame.shengyu,"RIGHT",4,0);
	PlayerTalentFrame.shengyuV:SetFont(ChatFontNormal:GetFont(), 15,"OUTLINE")
	PlayerTalentFrame.shengyuV:SetText("0");

	for tfID=2,3 do
		local TalentFrame = CreateFrame("Frame", "PlayerTalentFrame"..tfID, PlayerTalentFrame)
		TalentFrame:SetSize(gundongWW,gundongHH-ScrollPY);
		TalentFrame:SetScale(ScaleZhi);
		if tfID==2 then
			TalentFrame:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPLEFT",gundongWW+22,0);
		else
			TalentFrame:SetPoint("TOPLEFT",_G["PlayerTalentFrame"..(tfID-1)],"TOPRIGHT",0,0);
		end
		local TalentFrameScroll = CreateFrame("ScrollFrame","$parentScrollFrame",TalentFrame, "UIPanelScrollFrameTemplate");  
		TalentFrameScroll:SetPoint("TOPLEFT",TalentFrame,"TOPLEFT",0,ScrollPY);
		TalentFrameScroll:SetPoint("BOTTOMRIGHT",TalentFrame,"BOTTOMRIGHT",0,0);
		_G["PlayerTalentFrame"..tfID.."ScrollFrameScrollBar"]:Hide()

		local BGTopLeft = TalentFrameScroll:CreateTexture("PlayerTalentFrame"..tfID.."BackgroundTopLeft", "BORDER");
		BGTopLeft:SetTexCoord(0,1,0,1)
		BGTopLeft:SetSize(256,256);
		BGTopLeft:SetPoint("TOPLEFT",TalentFrameScroll,"TOPLEFT",0,0);
		BGTopLeft:SetPoint("RIGHT",TalentFrameScroll,"RIGHT",-40,0);
		BGTopLeft:SetPoint("BOTTOM",TalentFrameScroll,"BOTTOM",0,76);
		local BGTopRight = TalentFrameScroll:CreateTexture("PlayerTalentFrame"..tfID.."BackgroundTopRight", "BORDER");
		BGTopRight:SetSize(44,256);
		BGTopRight:SetTexCoord(0,0.6875,0,1)
		BGTopRight:SetPoint("TOPRIGHT",TalentFrameScroll,"TOPRIGHT",0,0);
		BGTopRight:SetPoint("BOTTOMLEFT",BGTopLeft,"BOTTOMRIGHT",0,0);
		local BGBottomLeft = TalentFrameScroll:CreateTexture("PlayerTalentFrame"..tfID.."BackgroundBottomLeft", "BORDER");
		BGBottomLeft:SetSize(256,75);
		BGBottomLeft:SetTexCoord(0,1,0,0.5859375)
		BGBottomLeft:SetPoint("BOTTOMLEFT",TalentFrameScroll,"BOTTOMLEFT",0,0);
		BGBottomLeft:SetPoint("TOPRIGHT",BGTopLeft,"BOTTOMRIGHT",0,0);
		local BGBottomRight = TalentFrameScroll:CreateTexture("PlayerTalentFrame"..tfID.."BackgroundBottomRight", "BORDER");
		BGBottomRight:SetSize(44,75);
		BGBottomRight:SetTexCoord(0,0.6875,0,0.5859375)
		BGBottomRight:SetPoint("BOTTOMRIGHT",TalentFrameScroll,"BOTTOMRIGHT",0,0);
		BGBottomRight:SetPoint("TOPLEFT",BGTopLeft,"BOTTOMRIGHT",0,0);

		local TalentFrameScrollChild = CreateFrame("Frame", "PlayerTalentFrame"..tfID.."ScrollChildFrame", TalentFrameScroll)
		TalentFrameScrollChild:SetWidth(TalentFrameScroll:GetWidth())
		TalentFrameScrollChild:SetHeight(50) 
		TalentFrameScroll:SetScrollChild(TalentFrameScrollChild)
		for i=1,30 do
			local Branch = TalentFrameScrollChild:CreateTexture("PlayerTalentFrame"..tfID.."Branch"..i, "BACKGROUND","TalentBranchTemplate");
		end
		for i=1,MAX_NUM_TALENTS do
			local TalentBut = CreateFrame("Button","PlayerTalentFrame"..tfID.."Talent"..i,TalentFrameScrollChild, "TalentButtonTemplate",i);
			TalentBut:RegisterForClicks("LeftButtonUp", "RightButtonUp");
			TalentBut:RegisterEvent("PREVIEW_TALENT_POINTS_CHANGED");
			TalentBut:RegisterEvent("PREVIEW_PET_TALENT_POINTS_CHANGED");
			TalentBut:RegisterEvent("PLAYER_TALENT_UPDATE");
			TalentBut:RegisterEvent("PET_TALENT_UPDATE");
			local function PlayerTalentFrameTalent_OnEvent_pig(self, event, ...)
				if ( GameTooltip:IsOwned(self) ) then
					GameTooltip:SetTalent(tfID, self:GetID(),
						PlayerTalentFrame.inspect, PlayerTalentFrame.pet, PlayerTalentFrame.talentGroup, GetCVarBool("previewTalents"));
				end
			end
			TalentBut:SetScript("OnEvent", PlayerTalentFrameTalent_OnEvent_pig);
			---
			local function PlayerTalentFrameTalent_OnClick_pig(self, button)
				if ( IsModifiedClick("CHATLINK") ) then
					local link = GetTalentLink(tfID, self:GetID(),
						PlayerTalentFrame.inspect, PlayerTalentFrame.pet, PlayerTalentFrame.talentGroup, GetCVarBool("previewTalents"));
					if ( link ) then
						ChatEdit_InsertLink(link);
					end
				--elseif ( selectedSpec and (activeSpec == selectedSpec or specs[selectedSpec].pet) ) then
				else
					if ( button == "LeftButton" ) then
						if ( GetCVarBool("previewTalents") ) then
							AddPreviewTalentPoints(tfID, self:GetID(), 1, PlayerTalentFrame.pet, PlayerTalentFrame.talentGroup);
						else
							LearnTalent(tfID, self:GetID(), PlayerTalentFrame.pet, PlayerTalentFrame.talentGroup);
						end
					elseif ( button == "RightButton" ) then
						if ( GetCVarBool("previewTalents") ) then
							AddPreviewTalentPoints(tfID, self:GetID(), -1, PlayerTalentFrame.pet, PlayerTalentFrame.talentGroup);
						end
					end
				end
			end
			TalentBut:SetScript("OnClick", PlayerTalentFrameTalent_OnClick_pig);
			local function PlayerTalentFrameTalent_OnEnter_pig(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:SetTalent(tfID, self:GetID(),
					PlayerTalentFrame.inspect, PlayerTalentFrame.pet, PlayerTalentFrame.talentGroup, GetCVarBool("previewTalents"));
				self.UpdateTooltip = PlayerTalentFrameTalent_OnEnter_pig;
			end
			TalentBut:SetScript("OnEnter", PlayerTalentFrameTalent_OnEnter_pig);
		end
		local ArrowFrame = CreateFrame("Frame", "PlayerTalentFrame"..tfID.."ArrowFrame", TalentFrameScrollChild);
		ArrowFrame:SetAllPoints(TalentFrameScrollChild)
		for i=1,30 do
			local Arrow = ArrowFrame:CreateTexture("PlayerTalentFrame"..tfID.."Arrow"..i, "OVERLAY","TalentArrowTemplate");
		end
	end
	--
	for i=1,3 do
		local fujik = PlayerTalentFrameScrollFrame
		if i>1 then fujik = _G["PlayerTalentFrame"..i.."ScrollFrame"] end
		fujik.Tianfu = fujik:CreateFontString();
		fujik.Tianfu:SetPoint("BOTTOM",fujik,"BOTTOM",-20,6);
		fujik.Tianfu:SetFontObject(GameFontNormal)
		fujik.Tianfu:SetScale(1/ScaleZhi);
		fujik.TianfuV = fujik:CreateFontString();
		fujik.TianfuV:SetPoint("LEFT",fujik.Tianfu,"RIGHT",4,0);
		fujik.TianfuV:SetFont(ChatFontNormal:GetFont(), 15,"OUTLINE")
		fujik.TianfuV:SetScale(1/ScaleZhi);
	end
	---
	if PlayerTalentFrame:IsShown() then
		HideUIPanel(PlayerTalentFrame);
	end
	---
	PlayerTalentFrame.yulanTF=ADD_Checkbutton(nil,PlayerTalentFrame,-40,"TOPLEFT",PlayerTalentFrame,"TOPLEFT",72,-14,"模拟模式","点击天赋时可先模拟，确定后再学习模拟结果")
    PlayerTalentFrame.yulanTF:SetSize(24,24);
    local yulankaiqi = GetCVar("previewTalents")
    if yulankaiqi=="1" then PlayerTalentFrame.yulanTF:SetChecked(true) end
    PlayerTalentFrame.yulanTF:SetScript("OnClick", function (self)
        if self:GetChecked() then
            SetCVar("previewTalents","1")
        else
            SetCVar("previewTalents","0")
        end
        InterfaceOptionsDisplayPanelPreviewTalentChanges_SetFunc()
    end);
end

local function TalentFrame_Open()
	if IsAddOnLoaded("Blizzard_TalentUI") then
		TalentFrame_ADD()
	else
		local tianfuFrame = CreateFrame("FRAME")
		tianfuFrame:RegisterEvent("ADDON_LOADED")
		tianfuFrame:SetScript("OnEvent", function(self, event, arg1)
		    if arg1 == "Blizzard_TalentUI" then
		        TalentFrame_ADD()
		        tianfuFrame:UnregisterEvent("ADDON_LOADED")
		    end
		end)
	end
end
addonTable.TalentFrame_Open=TalentFrame_Open
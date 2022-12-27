local _, addonTable = ...;
local fuFrame=List_R_F_1_5
local ADD_Checkbutton=addonTable.ADD_Checkbutton
----------------
local gundongWW,gundongHH,ScrollPY,ScaleZhi = 290, 480, -90, 0.76
local allwww = 714
--
local jianjuzhi = 53
local function PlayerTalentFrame_GetBranchTexture_Pig(TFID)
	local branchTexture = _G["PlayerTalentFrame"..TFID.."Branch".._G["PlayerTalentFrame"..TFID].textureIndex];
	_G["PlayerTalentFrame"..TFID].textureIndex = _G["PlayerTalentFrame"..TFID].textureIndex + 1;
	if ( not branchTexture ) then
		message("Not enough branch textures");
	else
		branchTexture:Show();
		return branchTexture;
	end
end
local function PlayerTalentFrame_SetBranchTexture_Pig(tier, column, texCoords, xOffset, yOffset,TFID)
	local branchTexture = PlayerTalentFrame_GetBranchTexture_Pig(TFID);
	branchTexture:SetTexCoord(texCoords[1], texCoords[2], texCoords[3], texCoords[4]);
	branchTexture:SetPoint("TOPLEFT", _G["PlayerTalentFrame"..TFID.."ScrollChildFrame"], "TOPLEFT", xOffset, yOffset);
end
local function PlayerTalentFrame_GetArrowTexture_Pig(TFID)
	local arrowTexture = _G["PlayerTalentFrame"..TFID.."Arrow".._G["PlayerTalentFrame"..TFID].arrowIndex];
	_G["PlayerTalentFrame"..TFID].arrowIndex = _G["PlayerTalentFrame"..TFID].arrowIndex + 1;
	if ( not arrowTexture ) then
		message("Not enough arrow textures");
	else
		arrowTexture:Show();
		return arrowTexture;
	end
end
local function PlayerTalentFrame_SetArrowTexture_Pig(tier, column, texCoords, xOffset, yOffset,TFID)
	local arrowTexture = PlayerTalentFrame_GetArrowTexture_Pig(TFID);
	arrowTexture:SetTexCoord(texCoords[1], texCoords[2], texCoords[3], texCoords[4]);
	arrowTexture:SetPoint("TOPLEFT", _G["PlayerTalentFrame"..TFID.."ArrowFrame"], "TOPLEFT", xOffset, yOffset);
end
local function PlayerTalentFrame_Update_Pig(TFID)
	local selectedTab = TFID
	local talentFrameName = "PlayerTalentFrame"..TFID;
	local talentTabName = GetTalentTabInfo(selectedTab);
	local base;
	local name, texture, points, fileName = GetTalentTabInfo(selectedTab);
	if ( talentTabName ) then
		base = "Interface\\TalentFrame\\"..fileName.."-";
	else
		base = "Interface\\TalentFrame\\MageFire-";
	end
	_G[talentFrameName.."BackgroundTopLeft"]:SetTexture(base.."TopLeft");
	_G[talentFrameName.."BackgroundTopRight"]:SetTexture(base.."TopRight");
	_G[talentFrameName.."BackgroundBottomLeft"]:SetTexture(base.."BottomLeft");
	_G[talentFrameName.."BackgroundBottomRight"]:SetTexture(base.."BottomRight");
	---
	local numTalents = GetNumTalents(selectedTab);

	PlayerTalentFrame_ResetBranches();
	local forceDesaturated, tierUnlocked;
	for i=1, MAX_NUM_TALENTS do
		button = _G[talentFrameName.."Talent"..i];
		if ( i <= numTalents ) then
			local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(selectedTab, i);
			_G[talentFrameName.."Talent"..i.."Rank"]:SetText(rank);
			SetTalentButtonLocation(button, tier, column);
			TALENT_BRANCH_ARRAY[tier][column].id = button:GetID();
			if ( (PlayerTalentFrame.talentPoints <= 0 and rank == 0)  ) then
				forceDesaturated = 1;
			else
				forceDesaturated = nil;
			end
			if ( ( (tier - 1) * 5 <= PlayerTalentFrame.pointsSpent ) ) then
				tierUnlocked = 1;
			else
				tierUnlocked = nil;
			end
			SetItemButtonTexture(button, iconTexture);
			if ( PlayerTalentFrame_SetPrereqs(tier, column, forceDesaturated, tierUnlocked, GetTalentPrereqs(selectedTab, i)) and available ) then
				SetItemButtonDesaturated(button, nil);	
				if ( rank < maxRank ) then
					_G[talentFrameName.."Talent"..i.."Slot"]:SetVertexColor(0.1, 1.0, 0.1);
					_G[talentFrameName.."Talent"..i.."Rank"]:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
				else
					_G[talentFrameName.."Talent"..i.."Slot"]:SetVertexColor(1.0, 0.82, 0);
					_G[talentFrameName.."Talent"..i.."Rank"]:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
				end
				_G[talentFrameName.."Talent"..i.."RankBorder"]:Show();
				_G[talentFrameName.."Talent"..i.."Rank"]:Show();
			else
				SetItemButtonDesaturated(button, 1, 0.65, 0.65, 0.65);
				_G[talentFrameName.."Talent"..i.."Slot"]:SetVertexColor(0.5, 0.5, 0.5);
				if ( rank == 0 ) then
					_G[talentFrameName.."Talent"..i.."RankBorder"]:Hide();
					_G[talentFrameName.."Talent"..i.."Rank"]:Hide();
				else
					_G[talentFrameName.."Talent"..i.."RankBorder"]:SetVertexColor(0.5, 0.5, 0.5);
					_G[talentFrameName.."Talent"..i.."Rank"]:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
				end
			end	
			button:Show();
		else	
			button:Hide();
		end
	end
	-----
	local node;
	local textureIndex = 1;
	local xOffset, yOffset;
	local texCoords;
	local ignoreUp;
	local tempNode;
	_G["PlayerTalentFrame"..TFID].textureIndex = 1;
	_G["PlayerTalentFrame"..TFID].arrowIndex = 1;
	for i=1, MAX_NUM_TALENT_TIERS do
		for j=1, NUM_TALENT_COLUMNS do
			node = TALENT_BRANCH_ARRAY[i][j];
			xOffset = ((j - 1) * 63) + INITIAL_TALENT_OFFSET_X + 2;
			yOffset = -((i - 1) * 63) - INITIAL_TALENT_OFFSET_Y - 2;
			if ( node.id ) then
				if ( node.up ~= 0 ) then
					if ( not ignoreUp ) then
						PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["up"][node.up], xOffset, yOffset + TALENT_BUTTON_SIZE,TFID);
					else
						ignoreUp = nil;
					end
				end
				if ( node.down ~= 0 ) then
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset, yOffset - TALENT_BUTTON_SIZE + 1,TFID);
				end
				if ( node.left ~= 0 ) then
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["left"][node.left], xOffset - TALENT_BUTTON_SIZE, yOffset,TFID);
				end
				if ( node.right ~= 0 ) then
					tempNode = TALENT_BRANCH_ARRAY[i][j+1];	
					if ( tempNode.left ~= 0 and tempNode.down < 0 ) then
						PlayerTalentFrame_SetBranchTexture_Pig(i, j-1, TALENT_BRANCH_TEXTURECOORDS["right"][tempNode.down], xOffset + TALENT_BUTTON_SIZE, yOffset,TFID);
					else
						PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["right"][node.right], xOffset + TALENT_BUTTON_SIZE + 1, yOffset,TFID);
					end
					
				end
				if ( node.rightArrow ~= 0 ) then
					PlayerTalentFrame_SetArrowTexture_Pig(i, j, TALENT_ARROW_TEXTURECOORDS["right"][node.rightArrow], xOffset + TALENT_BUTTON_SIZE/2 + 5, yOffset,TFID);
				end
				if ( node.leftArrow ~= 0 ) then
					PlayerTalentFrame_SetArrowTexture_Pig(i, j, TALENT_ARROW_TEXTURECOORDS["left"][node.leftArrow], xOffset - TALENT_BUTTON_SIZE/2 - 5, yOffset,TFID);
				end
				if ( node.topArrow ~= 0 ) then
					PlayerTalentFrame_SetArrowTexture_Pig(i, j, TALENT_ARROW_TEXTURECOORDS["top"][node.topArrow], xOffset, yOffset + TALENT_BUTTON_SIZE/2 + 5,TFID);
				end
			else
				if ( node.up ~= 0 and node.left ~= 0 and node.right ~= 0 ) then
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["tup"][node.up], xOffset , yOffset,TFID);
				elseif ( node.down ~= 0 and node.left ~= 0 and node.right ~= 0 ) then
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["tdown"][node.down], xOffset , yOffset,TFID);
				elseif ( node.left ~= 0 and node.down ~= 0 ) then
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["topright"][node.left], xOffset , yOffset,TFID);
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32,TFID);
				elseif ( node.left ~= 0 and node.up ~= 0 ) then
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["bottomright"][node.left], xOffset , yOffset,TFID);
				elseif ( node.left ~= 0 and node.right ~= 0 ) then
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["right"][node.right], xOffset + TALENT_BUTTON_SIZE, yOffset,TFID);
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["left"][node.left], xOffset + 1, yOffset,TFID);
				elseif ( node.right ~= 0 and node.down ~= 0 ) then
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["topleft"][node.right], xOffset , yOffset,TFID);
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32,TFID);
				elseif ( node.right ~= 0 and node.up ~= 0 ) then
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["bottomleft"][node.right], xOffset , yOffset,TFID);
				elseif ( node.up ~= 0 and node.down ~= 0 ) then
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["up"][node.up], xOffset , yOffset,TFID);
					PlayerTalentFrame_SetBranchTexture_Pig(i, j, TALENT_BRANCH_TEXTURECOORDS["down"][node.down], xOffset , yOffset - 32,TFID);
					ignoreUp = 1;
				end
			end
		end
		PlayerTalentFrameScrollFrame:UpdateScrollChildRect();
	end
	for i=_G["PlayerTalentFrame"..TFID].textureIndex, MAX_NUM_BRANCH_TEXTURES do
		_G[talentFrameName.."Branch"..i]:Hide();
	end
	for i=_G["PlayerTalentFrame"..TFID].arrowIndex, MAX_NUM_ARROW_TEXTURES do
		_G[talentFrameName.."Arrow"..i]:Hide();
	end
	local name, icon, pointsSpent = GetTalentTabInfo(TFID);
	_G["PlayerTalentFrame"..TFID.."ScrollFrame"].Tianfu:SetText(name..":");
	_G["PlayerTalentFrame"..TFID.."ScrollFrame"].TianfuV:SetText(pointsSpent);
end
local function TalentFrame_ADD()
	UIPanelWindows["PlayerTalentFrame"].with=allwww

	local old_PlayerTalentFrame_Update=PlayerTalentFrame_Update
	PlayerTalentFrame_Update=function()
		old_PlayerTalentFrame_Update()
		local name, icon, pointsSpent = GetTalentTabInfo(1);
		PlayerTalentFrameScrollFrame.Tianfu:SetText(name..":");
		PlayerTalentFrameScrollFrame.TianfuV:SetText(pointsSpent);
		PlayerTalentFrame_Update_Pig(2)
		PlayerTalentFrame_Update_Pig(3)
		for i=1,MAX_TALENT_TABS do
			_G["PlayerTalentFrameTab"..i]:Hide()
		end
	end

	PlayerTalentFrame:SetSize(allwww,gundongHH-39);
	local regions = {PlayerTalentFrame:GetRegions()}
	for i=1,#regions do
		local regionsname =regions[i]:GetName()
		if not regionsname then
			regions[i]:Hide()
		end
	end
	PlayerTalentFrameCancelButton:Hide()
	PlayerTalentFrameSpentPoints:Hide()
	PlayerTalentFramePointsLeft:Hide()
	PlayerTalentFramePointsMiddle:Hide()
	PlayerTalentFramePointsRight:Hide()
	PlayerTalentFrameTalentPoints:SetText("剩余天赋点数:");
	PlayerTalentFrameTalentPointsText:ClearAllPoints();
	PlayerTalentFrameTalentPointsText:SetPoint("TOP",PlayerTalentFrame,"TOP",0,-44);
	PlayerTalentFrameScrollFrame:SetScale(ScaleZhi);
	PlayerTalentFrameScrollFrameScrollBar:Hide()
	local regions = {PlayerTalentFrameScrollFrame:GetRegions()}
	for i=1,#regions do
		regions[i]:Hide()
	end
	PlayerTalentFrameScrollFrame:ClearAllPoints();
	PlayerTalentFrameScrollFrame:SetPoint("TOPLEFT",PlayerTalentFrame,"TOPLEFT",22,ScrollPY);
	PlayerTalentFrameScrollFrame:SetSize(gundongWW,gundongHH);
	PlayerTalentFrameBackgroundTopLeft:ClearAllPoints();
	PlayerTalentFrameBackgroundTopRight:ClearAllPoints();
	PlayerTalentFrameBackgroundBottomLeft:ClearAllPoints();
	PlayerTalentFrameBackgroundBottomRight:ClearAllPoints();
	PlayerTalentFrameBackgroundTopLeft:SetTexCoord(0,1,0,1)
	PlayerTalentFrameBackgroundTopLeft:SetPoint("TOPLEFT",PlayerTalentFrameScrollFrame,"TOPLEFT",0,0);
	PlayerTalentFrameBackgroundTopLeft:SetPoint("RIGHT",PlayerTalentFrameScrollFrame,"RIGHT",-40,0);
	PlayerTalentFrameBackgroundTopLeft:SetPoint("BOTTOM",PlayerTalentFrameScrollFrame,"BOTTOM",0,76);
	PlayerTalentFrameBackgroundTopRight:SetTexCoord(0,0.6875,0,1)
	PlayerTalentFrameBackgroundTopRight:SetPoint("TOPRIGHT",PlayerTalentFrameScrollFrame,"TOPRIGHT",0,0);
	PlayerTalentFrameBackgroundTopRight:SetPoint("BOTTOMLEFT",PlayerTalentFrameBackgroundTopLeft,"BOTTOMRIGHT",0,0);
	PlayerTalentFrameBackgroundBottomLeft:SetTexCoord(0,1,0,0.5859375)
	PlayerTalentFrameBackgroundBottomLeft:SetPoint("BOTTOMLEFT",PlayerTalentFrameScrollFrame,"BOTTOMLEFT",0,0);
	PlayerTalentFrameBackgroundBottomLeft:SetPoint("TOPRIGHT",PlayerTalentFrameBackgroundTopLeft,"BOTTOMRIGHT",0,0)
	PlayerTalentFrameBackgroundBottomRight:SetTexCoord(0,0.6875,0,0.5859375)
	PlayerTalentFrameBackgroundBottomRight:SetPoint("BOTTOMRIGHT",PlayerTalentFrameScrollFrame,"BOTTOMRIGHT",0,0);
	PlayerTalentFrameBackgroundBottomRight:SetPoint("TOPLEFT",PlayerTalentFrameBackgroundTopLeft,"BOTTOMRIGHT",0,0);
	-----
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
		self.TOPLEFT:SetPoint("TOPLEFT", self, "TOPLEFT",0, -3.6);
		self.TOPLEFT:SetTexCoord(0.0078125,0.0078125,0.0078125,0.6171875,0.6171875,0.0078125,0.6171875,0.6171875);
		self.TOPLEFT:SetSize(78,78);
		self.TOPRIGHT = self:CreateTexture(nil, "BORDER");
		self.TOPRIGHT:SetTexture(374156);
		self.TOPRIGHT:SetPoint("TOPRIGHT", self, "TOPRIGHT",-33, -13.6);
		self.TOPRIGHT:SetTexCoord(0.6328125,0.0078125,0.6328125,0.265625,0.890625,0.0078125,0.890625,0.265625);
		self.TOPRIGHT:SetSize(33,33);
		self.TOP = self:CreateTexture(nil, "BORDER");
		self.TOP:SetTexCoord(0,0.4375,0,0.65625,1.08637285232544,0.4375,1.08637285232544,0.65625);
		self.TOP:SetTexture(374157);
		self.TOP:SetPoint("TOPLEFT", self.TOPLEFT, "TOPRIGHT",0, -10);
		self.TOP:SetPoint("BOTTOMRIGHT", self.TOPRIGHT, "BOTTOMLEFT", 0, 5);
		
		self.BOTTOMLEFT = self:CreateTexture(nil, "BORDER");
		self.BOTTOMLEFT:SetTexture(374156);
		self.BOTTOMLEFT:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT",8.4, 0);
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
		self.LEFT:SetPoint("TOPLEFT", self.TOPLEFT, "BOTTOMLEFT",8.4, 0);
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
	---
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
			TalentBut:RegisterEvent("CHARACTER_POINTS_CHANGED");
			local function PlayerTalentFrameTalent_OnEvent_pig(self, event, ...)
				if ( GameTooltip:IsOwned(self) ) then
					GameTooltip:SetTalent(tfID, self:GetID());
				end
			end
			TalentBut:SetScript("OnEvent", PlayerTalentFrameTalent_OnEvent_pig);
			local function PlayerTalentFrameTalent_OnClick_pig(self, button)
				if ( button == "LeftButton" ) then
					LearnTalent(tfID, self:GetID());
				end
			end
			TalentBut:SetScript("OnClick", PlayerTalentFrameTalent_OnClick_pig);
			--
			local function PlayerTalentFrameTalent_OnEnter_pig(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:SetTalent(tfID, self:GetID());
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
	--
	if PlayerTalentFrame:IsShown() then
		HideUIPanel(PlayerTalentFrame);
	end
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
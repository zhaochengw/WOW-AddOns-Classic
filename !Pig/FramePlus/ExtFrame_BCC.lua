local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_5_UI
local _, _, _, tocversion = GetBuildInfo()
--任务界面扩展--------------------
local function RenwuFrame_Open()
	-- 显示任务等级
	if QUESTS_DISPLAYED==6 then 
		local function gengxinLVQR()
			local numEntries, numQuests = GetNumQuestLogEntries();
			if (numEntries == 0) then return end
			for i = 1, QUESTS_DISPLAYED, 1 do
				local questIndex = i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);		
				if (questIndex <= numEntries) then
					local questLogTitle = _G["QuestLogTitle"..i]
					local questCheck = _G["QuestLogTitle"..i.."Check"]
					local title, level, _, isHeader = GetQuestLogTitle(questIndex)
					if isHeader then
						questLogTitle:SetText(title)
						QuestLogDummyText:SetText(title)
					else
						questLogTitle:SetText(" ["..level.."]"..title)
						QuestLogDummyText:SetText(" ["..level.."]"..title)
					end
					questCheck:SetPoint("LEFT", questLogTitle, "LEFT", QuestLogDummyText:GetWidth()+24, 0);
				end  
			end
		end
		QuestLogListScrollFrame:HookScript("OnVerticalScroll", function(self, offset)
		    gengxinLVQR()
		end)
		QuestLogFrame:HookScript('OnShow', function()
			gengxinLVQR()
		end)
		UIPanelWindows["QuestLogFrame"] = {area = "override", pushable = 0, xoffset = -16, yoffset = 12, bottomClampOverride = 140 + 12, width = 714, height = 487, whileDead = 1}
		--任务界面扩展
		--缩放任务框架以匹配新纹理
		QuestLogFrame:SetWidth(714)
		QuestLogFrame:SetHeight(487)

		--任务日志标题移到中间
		QuestLogTitleText:ClearAllPoints();
		QuestLogTitleText:SetPoint("TOP", QuestLogFrame, "TOP", 0, -18);

		-- 任务详细说明移到右边，并增加高度
		QuestLogDetailScrollFrame:ClearAllPoints();
		QuestLogDetailScrollFrame:SetPoint("TOPLEFT", QuestLogListScrollFrame,"TOPRIGHT", 30, 0);
		QuestLogDetailScrollFrame:SetHeight(335);

		-- 任务目录增加高度
		QuestLogListScrollFrame:SetHeight(335);

		-- 增加可显示任务目录数
		local oldQuestsDisplayed = QUESTS_DISPLAYED;
		QUESTS_DISPLAYED = QUESTS_DISPLAYED + 16;
		for i = oldQuestsDisplayed + 1, QUESTS_DISPLAYED do
		    local button = CreateFrame("Button", "QuestLogTitle" .. i, QuestLogFrame, "QuestLogTitleButtonTemplate");
		    button:SetID(i);
		    button:Hide();
		    button:ClearAllPoints();
		    button:SetPoint("TOPLEFT", getglobal("QuestLogTitle" .. (i-1)), "BOTTOMLEFT", 0, 1);
		end
		for i = 1, QUESTS_DISPLAYED do
			_G["QuestLogTitle"..i]:HookScript("PostClick", function()
					local questIndex = i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);		
					local _, _, _, isHeader = GetQuestLogTitle(questIndex)
					if isHeader then
						C_Timer.After(0.001,gengxinLVQR)
					else
			    		gengxinLVQR()
			    	end
			end)
		end
		QuestLogFrame:HookScript("OnEvent", function(self,event, arg1)
			gengxinLVQR()
		end)

		--更换纹理
		local regions = { QuestLogFrame:GetRegions() }
		regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
		regions[3]:SetSize(512,512)

		regions[4]:ClearAllPoints()
		regions[4]:SetPoint("TOPLEFT", regions[3], "TOPRIGHT", 0, 0)
		regions[4]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
		regions[4]:SetSize(256,512)

		regions[5]:Hide()
		regions[6]:Hide()
		--调整放弃任务按钮大小位置
		QuestLogFrameAbandonButton:SetSize(110, 21)
		QuestLogFrameAbandonButton:SetText(ABANDON_QUEST_ABBREV)
		QuestLogFrameAbandonButton:ClearAllPoints()
		QuestLogFrameAbandonButton:SetPoint("BOTTOMLEFT", QuestLogFrame, "BOTTOMLEFT", 17, 54)
		--调整共享任务按钮大小
		QuestFramePushQuestButton:SetSize(100, 21)
		QuestFramePushQuestButton:SetText(SHARE_QUEST_ABBREV)
		QuestFramePushQuestButton:ClearAllPoints()
		QuestFramePushQuestButton:SetPoint("LEFT", QuestLogFrameAbandonButton, "RIGHT", -3, 0)
		-- 增加显示地图按钮
		local logMapButton = CreateFrame("Button", "logMapButton_UI", QuestLogFrame, "UIPanelButtonTemplate")
		logMapButton:SetText("显示地图")
		logMapButton:ClearAllPoints()
		logMapButton:SetPoint("LEFT", QuestFramePushQuestButton, "RIGHT", -3, 0)
		logMapButton:SetSize(100, 21)
		logMapButton:SetScript("OnClick", ToggleWorldMap)
		-- 调整没有任务文字提示位置
		QuestLogNoQuestsText:ClearAllPoints();
		QuestLogNoQuestsText:SetPoint("TOP", QuestLogListScrollFrame, 0, -90);
		--隐藏没有任务时纹理
		local txset = { EmptyQuestLogFrame:GetRegions();}
		txset[1]:Hide();
		txset[2]:Hide();
		txset[3]:Hide();
		txset[4]:Hide();
	end
end

---------------------
fuFrame.Renwu = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Renwu:SetSize(30,32);
fuFrame.Renwu:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-20);
fuFrame.Renwu.Text:SetText("任务界面扩展");
fuFrame.Renwu.tooltip = "扩展任务界面为两列；左边任务列表，右边任务详情！";
fuFrame.Renwu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['ExtFrame_Renwu']="ON";
		RenwuFrame_Open();
	else
		PIG['FramePlus']['ExtFrame_Renwu']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);

--========================================
--专业界面
local Width,Height = 32,32;
local Skill_List = {'烹饪', '急救', '裁缝', '熔炼', '工程学', '锻造', '附魔', '制皮', '炼金术',"珠宝加工"};
local Skill_List_1 = {'分解', '基础营火',"选矿"};
local function huoqu_Skill_ID()
	Skill_List_ON_T = {};
	Skill_List_ON_D = {};
	local _, _, tabOffset, numEntries = GetSpellTabInfo(1)
	for i=tabOffset + 1, tabOffset + numEntries do
		local spellName, _ = GetSpellBookItemName(i, BOOKTYPE_SPELL)
		for x=1, #Skill_List do
			if spellName==Skill_List[x] then
				local _, special = GetSpellBookItemInfo(i, BOOKTYPE_SPELL);	
				table.insert(Skill_List_ON_T,special)
			end
		end
		for x=1, #Skill_List_1 do
			if spellName==Skill_List_1[x] then
				local _, special = GetSpellBookItemInfo(i, BOOKTYPE_SPELL);	
				table.insert(Skill_List_ON_D,special)
			end
		end
	end
end
--专业界面扩展/////////////////////////////////////////////
local function TradeSkillFunc()
	if TRADE_SKILLS_DISPLAYED==8 then
		UIPanelWindows["TradeSkillFrame"] = {area = "override", pushable = 1, xoffset = -16, yoffset = 12, bottomClampOverride = 140 + 12, width = 714, height = 487, whileDead = 1}	
		TradeSkillFrame:SetWidth(713)
		TradeSkillFrame:SetHeight(487)
		
		local regions = {TradeSkillFrame:GetRegions()}
		regions[2]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
		regions[2]:SetSize(512, 512)

		regions[3]:ClearAllPoints()
		regions[3]:SetPoint("TOPLEFT", regions[2], "TOPRIGHT", 0, 0)
		regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
		regions[3]:SetSize(256, 512)
		if tocversion<20000 then
			regions[4]:Hide()
			regions[5]:Hide()
			regions[8]:Hide()
			regions[9]:Hide()
			regions[10]:Hide()
			--隐藏全部折叠附近纹理
			TradeSkillExpandTabLeft:Hide()
			TradeSkillExpandTabRight:Hide()
			TradeSkillSkillBorderLeft:Hide()
		elseif tocversion<30000 then
			regions[5]:Hide()
			regions[6]:Hide()
			regions[8]:Hide()
			--隐藏全部折叠附近纹理
			TradeSkillExpandTabLeft:Hide()
			TradeSkillHorizontalBarLeft:Hide()
		end
		-- 扩展配方列表到最高
		TradeSkillListScrollFrame:ClearAllPoints()
		TradeSkillListScrollFrame:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 25, -75)
		TradeSkillListScrollFrame:SetSize(295, 336)
		--调整配方列表底部纹理
		local RecipeInset = TradeSkillFrame:CreateTexture("RecipeInset_Tex", "ARTWORK")
		RecipeInset:SetSize(304, 361)
		RecipeInset:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 16, -72)
		RecipeInset:SetTexture("Interface\\RAIDFRAME\\UI-RaidFrame-GroupBg")
		--配方详情移到右边增加高度
		TradeSkillDetailScrollFrame:ClearAllPoints()
		TradeSkillDetailScrollFrame:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 352, -74)
		TradeSkillDetailScrollFrame:SetSize(298, 336)
		-- 调整配方详细页纹理
		local DetailsInset = _G["TradeSkillFrame"]:CreateTexture("DetailsInset_Tex", "ARTWORK")
		DetailsInset:SetSize(302, 339)
		DetailsInset:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 348, -72)
		DetailsInset:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated")
		-- 增加配方列表目录数
		local oldTradeSkillsDisplayed = TRADE_SKILLS_DISPLAYED
		for i = 1 + 1, TRADE_SKILLS_DISPLAYED do
			_G["TradeSkillSkill" .. i]:ClearAllPoints()
			_G["TradeSkillSkill" .. i]:SetPoint("TOPLEFT", _G["TradeSkillSkill" .. (i-1)], "BOTTOMLEFT", 0, 1)
		end
		_G.TRADE_SKILLS_DISPLAYED = _G.TRADE_SKILLS_DISPLAYED + 14
		for i = oldTradeSkillsDisplayed + 1, TRADE_SKILLS_DISPLAYED do
			local button = CreateFrame("Button", "TradeSkillSkill" .. i, TradeSkillFrame, "TradeSkillSkillButtonTemplate")
			button:SetID(i)
			button:Hide()
			button:ClearAllPoints()
			button:SetPoint("TOPLEFT", _G["TradeSkillSkill" .. (i-1)], "BOTTOMLEFT", 0, 1)
		end
		--选中高亮条宽度
		hooksecurefunc(_G["TradeSkillHighlightFrame"], "Show", function()
			_G["TradeSkillHighlightFrame"]:SetWidth(290)
		end)
		--技能点数条位置
		TradeSkillRankFrame:ClearAllPoints()
		TradeSkillRankFrame:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 84, -38)
		--调整关闭按钮位置
		TradeSkillCancelButton:SetSize(80, 22)
		TradeSkillCancelButton:ClearAllPoints()
		TradeSkillCancelButton:SetPoint("BOTTOMRIGHT", TradeSkillFrame, "BOTTOMRIGHT", -42, 54)
		--调整全部制造按钮位置
		TradeSkillCreateButton:ClearAllPoints()
		TradeSkillCreateButton:SetPoint("RIGHT", TradeSkillCancelButton, "LEFT", -1, 0)
		--分类下拉菜单位置
		TradeSkillInvSlotDropDown:ClearAllPoints()
		TradeSkillInvSlotDropDown:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 498, -40)
		---
		for F=1, 7 do
			TradeSkillFrame.But = CreateFrame("Button", "Skill_Button_"..F, TradeSkillFrame, "SecureActionButtonTemplate");
			TradeSkillFrame.But:SetHighlightTexture(130718);
			TradeSkillFrame.But:SetSize(Width,Height);
			if F<5 then
				if F==1 then
					TradeSkillFrame.But:SetPoint("TOPLEFT",TradeSkillFrame,"TOPRIGHT",-32,-46);
				else
					TradeSkillFrame.But:SetPoint("TOP", _G["Skill_Button_"..(F-1)], "BOTTOM", 0, -16);
				end
			else
				if F==5 then
					TradeSkillFrame.But:SetPoint("BOTTOMLEFT",TradeSkillFrame,"BOTTOMRIGHT",-32,64);
				else
					TradeSkillFrame.But:SetPoint("BOTTOM",_G["Skill_Button_"..(F-1)],"TOP",0,16);
				end
			end
			TradeSkillFrame.But:RegisterForClicks("AnyUp");
			TradeSkillFrame.But:SetAttribute("type", "spell");
			TradeSkillFrame.But:Hide();
			-----------
			TradeSkillFrame.But.Border = TradeSkillFrame.But:CreateTexture(nil, "BORDER");
			TradeSkillFrame.But.Border:SetTexture(136831);
			TradeSkillFrame.But.Border:SetSize(Width*1.9,Height*1.9);
			TradeSkillFrame.But.Border:SetPoint("LEFT",TradeSkillFrame.But,"LEFT",-2,-4);

			TradeSkillFrame.But.Down = TradeSkillFrame.But:CreateTexture(nil, "OVERLAY");
			TradeSkillFrame.But.Down:SetTexture(130839);
			TradeSkillFrame.But.Down:SetAllPoints(TradeSkillFrame.But)
			TradeSkillFrame.But.Down:Hide();
			TradeSkillFrame.But:SetScript("OnMouseDown", function (self)
				self.Down:Show();
			end);
			TradeSkillFrame.But:SetScript("OnMouseUp", function (self)
				self.Down:Hide();
			end);

			TradeSkillFrame.But.START = TradeSkillFrame.But:CreateTexture(nil, "OVERLAY");
			TradeSkillFrame.But.START:SetTexture(130724);
			TradeSkillFrame.But.START:SetBlendMode("ADD");
			TradeSkillFrame.But.START:SetAllPoints(TradeSkillFrame.But)
			TradeSkillFrame.But.START:Hide();
		end
		for F=1, #Skill_List_ON_T do
			local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(Skill_List_ON_T[F]);
			_G["Skill_Button_"..F]:SetNormalTexture(icon);
 			_G["Skill_Button_"..F]:SetAttribute("spell", Skill_List_ON_T[F]);
 			_G["Skill_Button_"..F]:Show();
		end
		for F=1, #Skill_List_ON_D do
			local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(Skill_List_ON_D[F]);
			local FF = F+4;
			_G["Skill_Button_"..FF]:SetNormalTexture(icon);
 			_G["Skill_Button_"..FF]:SetAttribute("spell", Skill_List_ON_D[F]);
 			_G["Skill_Button_"..FF]:Show();
		end

		TradeSkillFrame:RegisterEvent("UNIT_SPELLCAST_START","player");
		TradeSkillFrame:RegisterEvent("UNIT_SPELLCAST_STOP","player");
		TradeSkillFrame:HookScript("OnEvent", function(self,event,arg1,arg2,arg3)
			if event=="TRADE_SKILL_UPDATE" then
				local tradeskillName = GetTradeSkillLine()
				for i=1,#Skill_List_ON_T do
					local NEWname = GetSpellInfo(Skill_List_ON_T[i]);
					if tradeskillName==NEWname then
						_G["Skill_Button_"..i].START:Show()
					else
						_G["Skill_Button_"..i].START:Hide()
					end
				end
			end
			if event=="UNIT_SPELLCAST_START" then
				for i=1,#Skill_List_ON_D do
					if arg3==Skill_List_ON_D[i] then
						local ii = i+4;
						_G["Skill_Button_"..ii].START:Show()
					end
				end
			end
			if event=="UNIT_SPELLCAST_STOP" then
				for i=1,#Skill_List_ON_D do
					if arg3==Skill_List_ON_D[i] then
						local ii = i+4;
						_G["Skill_Button_"..ii].START:Hide()
					end
				end
			end
		end)
	end
end
--附魔框架扩展/////////////////////////////////////////////
local function CraftFunc()
	if CRAFTS_DISPLAYED==8 then  
		UIPanelWindows["CraftFrame"] = {area = "override", pushable = 1, xoffset = -16, yoffset = 12, bottomClampOverride = 140 + 12, width = 714, height = 487, whileDead = 1}
		--重新设置附魔框架大小
		CraftFrame:SetWidth(713)
		CraftFrame:SetHeight(487)
		--纹理调整替换
		local regions = {_G["CraftFrame"]:GetRegions()}
		regions[2]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
		regions[2]:SetSize(512, 512)
		regions[3]:ClearAllPoints()
		regions[3]:SetPoint("TOPLEFT", regions[2], "TOPRIGHT", 0, 0)
		regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
		regions[3]:SetSize(256, 512)
		regions[4]:Hide()
		regions[5]:Hide()
		regions[9]:Hide()
		regions[10]:Hide()
		CraftSkillBorderLeft:SetAlpha(0)
		CraftSkillBorderRight:SetAlpha(0)
		---
		if tocversion<20000 then

		elseif tocversion<30000 then
			CraftFrameAvailableFilterCheckButton:ClearAllPoints()
			CraftFrameAvailableFilterCheckButton:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 84, -42)
			CraftFrameFilterDropDown:ClearAllPoints()
			CraftFrameFilterDropDown:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 498, -40)
		end

		--技能点数条位置
		CraftRankFrame:ClearAllPoints()
		CraftRankFrame:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 184, -47)


		
		-- 附魔框架标题位置
		CraftFrameTitleText:ClearAllPoints()
		CraftFrameTitleText:SetPoint("TOP", CraftFrame, "TOP", 0, -18)

		-- 附魔列表增加高度
		CraftListScrollFrame:ClearAllPoints()
		CraftListScrollFrame:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 25, -75)
		CraftListScrollFrame:SetSize(295, 336)

		-- 增加附魔目录可显示数
		local oldCraftsDisplayed = CRAFTS_DISPLAYED
		Craft1Cost:ClearAllPoints()
		Craft1Cost:SetPoint("RIGHT", Craft1, "RIGHT", -30, 0)
		for i = 1 + 1, CRAFTS_DISPLAYED do
			_G["Craft" .. i]:ClearAllPoints()
			_G["Craft" .. i]:SetPoint("TOPLEFT", _G["Craft" .. (i-1)], "BOTTOMLEFT", 0, 1)
			_G["Craft" .. i .. "Cost"]:ClearAllPoints()
			_G["Craft" .. i .. "Cost"]:SetPoint("RIGHT", _G["Craft" .. i], "RIGHT", -30, 0)
		end
		_G.CRAFTS_DISPLAYED = _G.CRAFTS_DISPLAYED + 14
		for i = oldCraftsDisplayed + 1, CRAFTS_DISPLAYED do
			local button = CreateFrame("Button", "Craft" .. i, CraftFrame, "CraftButtonTemplate")
			button:SetID(i)
			button:Hide()
			button:ClearAllPoints()
			button:SetPoint("TOPLEFT", _G["Craft" .. (i-1)], "BOTTOMLEFT", 0, 1)
			_G["Craft" .. i .. "Cost"]:ClearAllPoints()
			_G["Craft" .. i .. "Cost"]:SetPoint("RIGHT", _G["Craft" .. i], "RIGHT", -30, 0)
		end
		
		-- 选中高亮条宽度
		hooksecurefunc(_G["CraftHighlightFrame"], "Show", function()
			_G["CraftHighlightFrame"]:SetWidth(290)
		end)
		-- 附魔材料细节移到右边增加高度
		CraftDetailScrollFrame:ClearAllPoints()
		CraftDetailScrollFrame:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 352, -74)
		CraftDetailScrollFrame:SetSize(298, 336)
		-- 细节滚动条隐藏
		CraftDetailScrollFrameTop:SetAlpha(0)
		CraftDetailScrollFrameBottom:SetAlpha(0)
		
		-- 替换左侧列表纹理
		local RecipeInset = CraftFrame:CreateTexture(nil, "ARTWORK")
		RecipeInset:SetSize(304, 361)
		RecipeInset:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 16, -72)
		RecipeInset:SetTexture("Interface\\RAIDFRAME\\UI-RaidFrame-GroupBg")
		-- 右侧底部纹理
		local DetailsInset = CraftFrame:CreateTexture(nil, "ARTWORK")
		DetailsInset:SetSize(302, 339)
		DetailsInset:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 348, -72)
		DetailsInset:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated")
		
		-- 关闭按钮位置
		CraftCancelButton:SetSize(80, 22)
		CraftCancelButton:SetText(CLOSE)
		CraftCancelButton:ClearAllPoints()
		CraftCancelButton:SetPoint("BOTTOMRIGHT", CraftFrame, "BOTTOMRIGHT", -42, 54)
		-- 附魔按钮
		CraftCreateButton:ClearAllPoints()
		CraftCreateButton:SetPoint("RIGHT", CraftCancelButton, "LEFT", -1, 0)
		
		-- 训练宠物
		CraftFramePointsLabel:ClearAllPoints()
		CraftFramePointsLabel:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 500, -46)
		CraftFramePointsText:ClearAllPoints()
		CraftFramePointsText:SetPoint("LEFT", CraftFramePointsLabel, "RIGHT", 3, 0)

		for F=1, 7 do
			CraftFrame.But = CreateFrame("Button", "Craft_Button_"..F, CraftFrame, "SecureActionButtonTemplate");
			CraftFrame.But:SetHighlightTexture(130718);
			CraftFrame.But:SetSize(Width,Height);
			if F<5 then
				if F==1 then
					CraftFrame.But:SetPoint("TOPLEFT",CraftFrame,"TOPRIGHT",-32,-46);
				else
					CraftFrame.But:SetPoint("TOP", _G["Craft_Button_"..(F-1)], "BOTTOM", 0, -16);
				end
			else
				if F==5 then
					CraftFrame.But:SetPoint("BOTTOMLEFT",CraftFrame,"BOTTOMRIGHT",-32,64);
				else
					CraftFrame.But:SetPoint("BOTTOM",_G["Craft_Button_"..(F-1)],"TOP",0,16);
				end
			end
			CraftFrame.But:RegisterForClicks("AnyUp");
			CraftFrame.But:SetAttribute("type", "spell");
			CraftFrame.But:Hide();
			-----------
			CraftFrame.But.Border = CraftFrame.But:CreateTexture(nil, "BORDER");
			CraftFrame.But.Border:SetTexture(136831);
			CraftFrame.But.Border:SetSize(Width*1.9,Height*1.9);
			CraftFrame.But.Border:SetPoint("LEFT",CraftFrame.But,"LEFT",-2,-4);

			CraftFrame.But.Down = CraftFrame.But:CreateTexture(nil, "OVERLAY");
			CraftFrame.But.Down:SetTexture(130839);
			CraftFrame.But.Down:SetAllPoints(CraftFrame.But)
			CraftFrame.But.Down:Hide();
			CraftFrame.But:SetScript("OnMouseDown", function (self)
				self.Down:Show();
			end);
			CraftFrame.But:SetScript("OnMouseUp", function (self)
				self.Down:Hide();
			end);

			CraftFrame.But.START = CraftFrame.But:CreateTexture(nil, "OVERLAY");
			CraftFrame.But.START:SetTexture(130724);
			CraftFrame.But.START:SetBlendMode("ADD");
			CraftFrame.But.START:SetAllPoints(CraftFrame.But)
			CraftFrame.But.START:Hide();
		end
		for F=1, #Skill_List_ON_T do
			local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(Skill_List_ON_T[F]);
			_G["Craft_Button_"..F]:SetNormalTexture(icon);
 			_G["Craft_Button_"..F]:SetAttribute("spell", Skill_List_ON_T[F]);
 			_G["Craft_Button_"..F]:Show();
		end
		for F=1, #Skill_List_ON_D do
			local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(Skill_List_ON_D[F]);
			local FF = F+4;
			_G["Craft_Button_"..FF]:SetNormalTexture(icon);
 			_G["Craft_Button_"..FF]:SetAttribute("spell", Skill_List_ON_D[F]);
 			_G["Craft_Button_"..FF]:Show();
		end

		CraftFrame:RegisterEvent("UNIT_SPELLCAST_START","player");
		CraftFrame:RegisterEvent("UNIT_SPELLCAST_STOP","player");
		CraftFrame:HookScript("OnEvent", function(self,event,arg1,arg2,arg3)
			if event=="CRAFT_UPDATE" then
				local craftName = GetCraftSkillLine(1)
				for i=1,#Skill_List_ON_T do
					local NEWname = GetSpellInfo(Skill_List_ON_T[i]);
					if craftName==NEWname then
						_G["Craft_Button_"..i].START:Show()
					else
						_G["Craft_Button_"..i].START:Hide()
					end
				end
			end
			if event=="UNIT_SPELLCAST_START" then
				for i=1,#Skill_List_ON_D do
					if arg3==Skill_List_ON_D[i] then
						local ii = i+4;
						if _G["Skill_Button_"..ii] then _G["Skill_Button_"..ii].START:Show() end
						if _G["Craft_Button_"..ii] then _G["Craft_Button_"..ii].START:Show() end
					end
				end
			end
			if event=="UNIT_SPELLCAST_STOP" then
				for i=1,#Skill_List_ON_D do
					if arg3==Skill_List_ON_D[i] then
						local ii = i+4;
						if _G["Skill_Button_"..ii] then _G["Skill_Button_"..ii].START:Hide() end
						if _G["Craft_Button_"..ii] then _G["Craft_Button_"..ii].START:Hide() end
					end
				end
			end
		end)
	end
end
-------
local function ZhuanyeFrame_Open()
	if IsAddOnLoaded("Blizzard_TradeSkillUI") then
		huoqu_Skill_ID()
		TradeSkillFunc()
	else
		local zhuanyeFrame = CreateFrame("FRAME")
		zhuanyeFrame:RegisterEvent("ADDON_LOADED")
		zhuanyeFrame:SetScript("OnEvent", function(self, event, arg1)
			if arg1 == "Blizzard_TradeSkillUI" then
				huoqu_Skill_ID()
				TradeSkillFunc()
				zhuanyeFrame:UnregisterEvent("ADDON_LOADED")
			end
		end)
	end
	if IsAddOnLoaded("Blizzard_CraftUI") then
		huoqu_Skill_ID()
		CraftFunc();
	else
		local fumoFrame = CreateFrame("FRAME")
		fumoFrame:RegisterEvent("ADDON_LOADED")
		fumoFrame:SetScript("OnEvent", function(self, event, arg1)
			if arg1 == "Blizzard_CraftUI" then
				huoqu_Skill_ID()
				CraftFunc();
				fumoFrame:UnregisterEvent("ADDON_LOADED")
			end
		end)
	end
end
-----------------------
fuFrame.Zhuanye = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Zhuanye:SetSize(30,32);
fuFrame.Zhuanye:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-20);
fuFrame.Zhuanye.Text:SetText("专业界面扩展");
fuFrame.Zhuanye.tooltip = "1、扩展专业技能界面为两列；左边配方列表，右边配方详情。\n2、并在专业界面右侧显示便捷切换专业按钮！";
fuFrame.Zhuanye:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['ExtFrame_Zhuanye']="ON";
		ZhuanyeFrame_Open();
	else
		PIG['FramePlus']['ExtFrame_Zhuanye']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);

--=====================================
addonTable.FramePlus_ExtFrame = function()
	if PIG['FramePlus']['ExtFrame_Renwu']=="ON" then
		fuFrame.Renwu:SetChecked(true);
		RenwuFrame_Open();
	end
	if PIG['FramePlus']['ExtFrame_Zhuanye']=="ON" then
		fuFrame.Zhuanye:SetChecked(true);
		ZhuanyeFrame_Open();
	end
end
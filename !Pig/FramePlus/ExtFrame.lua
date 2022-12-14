local _, addonTable = ...;
local fuFrame=List_R_F_1_5
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--任务界面扩展--------------------
local function RenwuFrame_Open()
	if tocversion<40000 then
		local function gengxinLVQR()--显示任务等级
			local numEntries, numQuests = GetNumQuestLogEntries();
			if (numEntries == 0) then return end
			for i = 1, QUESTS_DISPLAYED, 1 do
				local questIndex = i + FauxScrollFrame_GetOffset(QuestLogListScrollFrame);		
				if (questIndex <= numEntries) then
					local title, level, _, isHeader = GetQuestLogTitle(questIndex)
					if not isHeader then
						QuestLogDummyText:SetText(" ["..level.."]"..title)
						if tocversion<30000 then
							local questLogTitle = _G["QuestLogTitle"..i.."NormalText"]
							local questCheck = _G["QuestLogTitle"..i.."Check"]
							questLogTitle:SetText(" ["..level.."]"..title)
							questCheck:SetPoint("LEFT", questLogTitle, "LEFT", QuestLogDummyText:GetWidth()+2, 0);
						elseif tocversion<40000 then
							local questLogbut = _G["QuestLogListScrollFrameButton"..i]
							questLogbut.normalText:SetText(" ["..level.."]"..title)
							local TitleWWW =QuestLogDummyText:GetWidth()
							questLogbut.normalText:SetWidth(TitleWWW+16)
							questLogbut.check:SetPoint("LEFT", questLogbut.normalText, "RIGHT", -16, 0);	
						end		
					end
				end  
			end
		end
		QuestLogListScrollFrame:HookScript("OnMouseWheel", function()
		    gengxinLVQR()
		end)
		hooksecurefunc("QuestLog_Update", function()
			gengxinLVQR()
		end)
		if tocversion<30000 then
			if QUESTS_DISPLAYED==6 then 
				local xssdadas = 714
				UIPanelWindows["QuestLogFrame"].width = xssdadas
				--缩放任务框架以匹配新纹理
				QuestLogFrame:SetWidth(xssdadas)
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
				    button:SetPoint("TOPLEFT", _G["QuestLogTitle" .. (i-1)], "BOTTOMLEFT", 0, 1);
				end

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
	end
end
addonTable.RenwuFrame_Open=RenwuFrame_Open
--专业界面扩展/////////////////////////////////////////////
local function TradeSkillFunc()
	if TRADE_SKILLS_DISPLAYED==8 then	
			UIPanelWindows["TradeSkillFrame"].width = 714	
			TradeSkillFrame:SetWidth(713)
			TradeSkillFrame:SetHeight(487)

			-- 扩展配方列表到最高
			TradeSkillListScrollFrame:ClearAllPoints()
			TradeSkillListScrollFrame:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 25, -75)
			TradeSkillListScrollFrame:SetSize(295, 336)

			--配方详情移到右边增加高度
			TradeSkillDetailScrollFrame:ClearAllPoints()
			TradeSkillDetailScrollFrame:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 352, -74)
			TradeSkillDetailScrollFrame:SetSize(298, 336)
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
			TradeSkillRankFrame:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 84, -36)
			TradeSkillRankFrameSkillRank:ClearAllPoints()
			TradeSkillRankFrameSkillRank:SetPoint("CENTER", TradeSkillRankFrame, "CENTER", 0, 0)
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
			--材料齐备
			if TradeSkillFrameAvailableFilterCheckButton then
				TradeSkillFrameAvailableFilterCheckButton:ClearAllPoints()
				TradeSkillFrameAvailableFilterCheckButton:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 70, -50)
			end
			--搜索位置
			if TradeSkillFrameEditBox then
				TradeSkillFrameEditBox:ClearAllPoints()
				TradeSkillFrameEditBox:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 190, -50)
			end
			if TradeSearchInputBox then
				TradeSearchInputBox:ClearAllPoints()
				TradeSearchInputBox:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 200, -52)
			end
			--纹理更新			
			local regions = {TradeSkillFrame:GetRegions()}
			if tocversion<20000 then
				--隐藏全部折叠附近纹理
				TradeSkillExpandTabLeft:Hide()
				TradeSkillExpandTabRight:Hide()
				TradeSkillSkillBorderLeft:Hide()
				regions[2]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
				regions[2]:SetSize(512, 512)

				regions[3]:ClearAllPoints()
				regions[3]:SetPoint("TOPLEFT", regions[2], "TOPRIGHT", 0, 0)
				regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
				regions[3]:SetSize(256, 512)
				regions[4]:Hide()
				regions[5]:Hide()
				regions[8]:Hide()
				regions[9]:Hide()
				regions[10]:Hide()
			elseif tocversion<30000 then
				--隐藏全部折叠附近纹理
				TradeSkillExpandTabLeft:Hide()
				TradeSkillHorizontalBarLeft:Hide()
				regions[2]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
				regions[2]:SetSize(512, 512)

				regions[3]:ClearAllPoints()
				regions[3]:SetPoint("TOPLEFT", regions[2], "TOPRIGHT", 0, 0)
				regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
				regions[3]:SetSize(256, 512)
				regions[5]:Hide()
				regions[6]:Hide()
				regions[8]:Hide()
			elseif tocversion<40000 then
				--隐藏全部折叠附近纹理
				TradeSkillExpandTabLeft:Hide()
				TradeSkillExpandTabRight:Hide()
				TradeSkillHorizontalBarLeft:Hide()
				--regions[2]:Hide()
				regions[5]:Hide()
				regions[6]:Hide()
				--regions[7]:Hide()--标题
				--regions[8]:Hide()
				regions[9]:Hide()

				regions[3]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Left")
				regions[3]:SetSize(512, 512)

				regions[4]:ClearAllPoints()
				regions[4]:SetPoint("TOPLEFT", regions[3], "TOPRIGHT", 0, 0)
				regions[4]:SetTexture("Interface\\QUESTFRAME\\UI-QuestLogDualPane-Right")
				regions[4]:SetSize(256, 512)
			end		
			--调整配方列表底部纹理
			TradeSkillFrame.RecipeInset = TradeSkillFrame:CreateTexture(nil, "ARTWORK")
			TradeSkillFrame.RecipeInset:SetSize(304, 361)
			TradeSkillFrame.RecipeInset:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 16, -72)
			TradeSkillFrame.RecipeInset:SetTexture("Interface\\RAIDFRAME\\UI-RaidFrame-GroupBg")
			-- 调整配方详细页纹理
			TradeSkillFrame.DetailsInset = TradeSkillFrame:CreateTexture(nil, "ARTWORK")
			TradeSkillFrame.DetailsInset:SetSize(302, 339)
			TradeSkillFrame.DetailsInset:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 348, -72)
			TradeSkillFrame.DetailsInset:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated")
			TradeSkillFrame:HookScript("OnShow", function(self)
				if ElvUI then
					TradeSkillInvSlotDropDown:ClearAllPoints()
					TradeSkillInvSlotDropDown:SetPoint("TOPLEFT", TradeSkillFrame, "TOPLEFT", 498, -30)
					self.backdrop:SetPoint("TOPLEFT",self,"TOPLEFT",0,0);
					self.backdrop:SetPoint("BOTTOMRIGHT",self,"BOTTOMRIGHT",-32,42);
				end	
			end); 
	end
end
--附魔框架扩展/////////////////////////////////////////////
local function CraftFunc()
	if CRAFTS_DISPLAYED==8 then  
		UIPanelWindows["CraftFrame"].width = 714
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
	end
end
-------
local function ZhuanyeFrame_Open()
	if IsAddOnLoaded("Blizzard_TradeSkillUI") then
		TradeSkillFunc()
	else
		local zhuanyeFrame = CreateFrame("FRAME")
		zhuanyeFrame:RegisterEvent("ADDON_LOADED")
		zhuanyeFrame:SetScript("OnEvent", function(self, event, arg1)
			if arg1 == "Blizzard_TradeSkillUI" then
				TradeSkillFunc()
				zhuanyeFrame:UnregisterEvent("ADDON_LOADED")
			end
		end)
	end
	if IsAddOnLoaded("Blizzard_CraftUI") then
		CraftFunc();
	else
		local fumoFrame = CreateFrame("FRAME")
		fumoFrame:RegisterEvent("ADDON_LOADED")
		fumoFrame:SetScript("OnEvent", function(self, event, arg1)
			if arg1 == "Blizzard_CraftUI" then
				CraftFunc();
				fumoFrame:UnregisterEvent("ADDON_LOADED")
			end
		end)
	end
end
addonTable.ZhuanyeFrame_Open=ZhuanyeFrame_Open
-----------------------
local Width,Height = 32,32;
local Skill_List = {'烹饪', '急救', '裁缝', '熔炼', '采矿技能', '工程学', '锻造', '附魔', '制皮', '炼金术',"珠宝加工","铭文","符文熔铸"};
local Skill_List_1 = {'基础营火','烹饪用火','分解',"选矿"};
local Skill_jichuID={
	["急救"]=129,["锻造"]=164,["制皮"]=165,["炼金术"]=171,["草药学"]=182,
	["烹饪"]=185,["采矿"]=186,["采矿技能"]=186,["裁缝"]=197,["工程学"]=202,["附魔"]=333,
	["钓鱼"]=356,["剥皮"]=393,["珠宝加工"]=755,["铭文"]=773,["考古学"]=794,
}
local Skill_List_NEW = {{},{}};
local function huoqu_Skill_ID()
	if #Skill_List_NEW[1]>0 then return end
	if tocversion>90000 then
		for _, i in pairs{GetProfessions()} do
			local offset, numSlots = select(3, GetSpellTabInfo(i))
			for j = offset+1, offset+numSlots do
				local spellName, _ ,spellID=GetSpellBookItemName(j, BOOKTYPE_SPELL)
				---print(spellName,spellID)
				for x=1, #Skill_List do
					if spellName==Skill_List[x] then
						table.insert(Skill_List_NEW[1],{spellID,Skill_jichuID[spellName]})
					end
				end
				for x=1, #Skill_List_1 do
					if spellName==Skill_List_1[x] then
						table.insert(Skill_List_NEW[2],{spellID,Skill_jichuID[spellName]})
					end
				end
			end
		end
	else
		local _, _, tabOffset, numEntries = GetSpellTabInfo(1)
		for j=tabOffset + 1, tabOffset + numEntries do
			local spellName, _ ,spellID=GetSpellBookItemName(j, BOOKTYPE_SPELL)
			for x=1, #Skill_List do
				if spellName==Skill_List[x] then
					table.insert(Skill_List_NEW[1],{spellID,Skill_jichuID[spellName]})
				end
			end
			for x=1, #Skill_List_1 do
				if spellName==Skill_List_1[x] then
					table.insert(Skill_List_NEW[2],{spellID,Skill_jichuID[spellName]})
				end
			end
		end
	end
end

local function ADD_Skill_QK()
	if Skill_Button_1 then return end
	local Update_State=addonTable.Update_State
	for F=1, 7 do
		local But = CreateFrame("CheckButton", "Skill_Button_"..F, TradeSkillFrame, "SecureActionButtonTemplate,ActionButtonTemplate");
		But:SetSize(Width,Height);
		But.NormalTexture:SetAlpha(0);
		if F<5 then
			if F==1 then
				But:SetPoint("TOPLEFT",TradeSkillFrame,"TOPRIGHT",-33,-46);
			else
				But:SetPoint("TOP", _G["Skill_Button_"..(F-1)], "BOTTOM", 0, -16);
			end
		else
			if F==5 then
				But:SetPoint("BOTTOMLEFT",TradeSkillFrame,"BOTTOMRIGHT",-33,64);
			else
				But:SetPoint("BOTTOM",_G["Skill_Button_"..(F-1)],"TOP",0,16);
			end
		end
		But:RegisterForClicks("AnyUp");
		But:SetAttribute("type", "spell");
		But:Hide();
		-----------
		But.Border = But:CreateTexture(nil, "BACKGROUND");
		But.Border:SetTexture(136831);
		But.Border:SetSize(Width*1.9,Height*1.9);
		But.Border:SetPoint("LEFT",But,"LEFT",-2,-4);
		But.Border:SetDrawLayer("BACKGROUND", -8)
		But:RegisterEvent("TRADE_SKILL_CLOSE")
		But:RegisterEvent("CRAFT_CLOSE")
		But:RegisterEvent("ACTIONBAR_UPDATE_STATE");
		But:HookScript("OnEvent", function(self)
			Update_State(self)
		end)
	end
	for F=1, #Skill_List_NEW[1] do
		local fujiK = _G["Skill_Button_"..F]
		fujiK.Type="spell"
		fujiK.SimID=Skill_List_NEW[1][F][1]
		fujiK.icon:SetTexture(GetSpellTexture(Skill_List_NEW[1][F][1]));
		fujiK:SetAttribute("spell", Skill_List_NEW[1][F][1]);
		fujiK:Show();
	end
	for F=1, #Skill_List_NEW[2] do
		local FF = F+4;
		local fujiK = _G["Skill_Button_"..FF]
		fujiK.Type="spell"
		fujiK.SimID=Skill_List_NEW[2][F][1]
		fujiK.icon:SetTexture(GetSpellTexture(Skill_List_NEW[2][F][1]));
		fujiK:SetAttribute("spell", Skill_List_NEW[2][F][1]);
		fujiK:Show();
	end
	TradeSkillFrame:HookScript("OnShow", function(self)
		if ElvUI then
			for F=1, 7 do
				_G["Skill_Button_"..F].Border:Hide()
			end
			Skill_Button_5:SetPoint("BOTTOMLEFT",TradeSkillFrame,"BOTTOMRIGHT",-33,90);
		end	
	end);
end
---
local function ADD_Craft_QK()
	if Craft_Button_1 then return end
	local Update_State=addonTable.Update_State
	for F=1, 7 do
		local But = CreateFrame("CheckButton", "Craft_Button_"..F, CraftFrame, "SecureActionButtonTemplate,ActionButtonTemplate");
		But:SetSize(Width,Height);
		But.NormalTexture:SetAlpha(0);
		if F<5 then
			if F==1 then
				But:SetPoint("TOPLEFT",CraftFrame,"TOPRIGHT",-33,-46);
			else
				But:SetPoint("TOP", _G["Craft_Button_"..(F-1)], "BOTTOM", 0, -16);
			end
		else
			if F==5 then
				But:SetPoint("BOTTOMLEFT",CraftFrame,"BOTTOMRIGHT",-33,64);
			else
				But:SetPoint("BOTTOM",_G["Craft_Button_"..(F-1)],"TOP",0,16);
			end
		end
		But:RegisterForClicks("AnyUp");
		But:SetAttribute("type", "spell");
		But:Hide();
		-----------
		But.Border = But:CreateTexture(nil, "BACKGROUND");
		But.Border:SetTexture(136831);
		But.Border:SetSize(Width*1.9,Height*1.9);
		But.Border:SetPoint("LEFT",But,"LEFT",-2,-4);
		But.Border:SetDrawLayer("BACKGROUND", -8)
		But:RegisterEvent("TRADE_SKILL_CLOSE")
		But:RegisterEvent("CRAFT_CLOSE")
		But:RegisterEvent("ACTIONBAR_UPDATE_STATE");
		But:HookScript("OnEvent", function(self)
			Update_State(self)
		end)
	end
	for F=1, #Skill_List_NEW[1] do
		local fujiK = _G["Craft_Button_"..F]
		fujiK.Type="spell"
		fujiK.SimID=Skill_List_NEW[1][F][1]
		fujiK.icon:SetTexture(GetSpellTexture(Skill_List_NEW[1][F][1]));
		fujiK:SetAttribute("spell", Skill_List_NEW[1][F][1]);
		fujiK:Show();
	end
	for F=1, #Skill_List_NEW[2] do
		local FF = F+4;
		local fujiK = _G["Craft_Button_"..FF]
		fujiK.Type="spell"
		fujiK.SimID=Skill_List_NEW[2][F][1]
		fujiK.icon:SetTexture(GetSpellTexture(Skill_List_NEW[2][F][1]));
		fujiK:SetAttribute("spell", Skill_List_NEW[2][F][1]);
		fujiK:Show();
	end
	CraftFrame:HookScript("OnShow", function(self)
		if ElvUI then
			for F=1, 7 do
				_G["Craft_Button_"..F].Border:Hide()
			end
			Craft_Button_5:SetPoint("BOTTOMLEFT",CraftFrame,"BOTTOMRIGHT",-33,90);
		end	
	end);
end
local function ZhuanyeQKBUT_Open()
	if tocversion<100000 then
		if IsAddOnLoaded("Blizzard_TradeSkillUI") then
			huoqu_Skill_ID()
			ADD_Skill_QK()
		else
			local zhuanyeQuickQH = CreateFrame("FRAME")
			zhuanyeQuickQH:RegisterEvent("ADDON_LOADED")
			zhuanyeQuickQH:SetScript("OnEvent", function(self, event, arg1)
				if arg1 == "Blizzard_TradeSkillUI" then
					huoqu_Skill_ID()
					if InCombatLockdown() then
						zhuanyeQuickQH:RegisterEvent("PLAYER_REGEN_ENABLED")
					else
						ADD_Skill_QK()
					end
					zhuanyeQuickQH:UnregisterEvent("ADDON_LOADED")
				end
				if event=="PLAYER_REGEN_ENABLED" then
					ADD_Skill_QK()
					zhuanyeQuickQH:UnregisterEvent("PLAYER_REGEN_ENABLED")
				end
			end)
		end
		if IsAddOnLoaded("Blizzard_CraftUI") then
			huoqu_Skill_ID()
			ADD_Craft_QK()
		else
			local fumoQuickQH = CreateFrame("FRAME")
			fumoQuickQH:RegisterEvent("ADDON_LOADED")
			fumoQuickQH:SetScript("OnEvent", function(self, event, arg1)
				if arg1 == "Blizzard_CraftUI" then
					huoqu_Skill_ID()
					if InCombatLockdown() then
						fumoQuickQH:RegisterEvent("PLAYER_REGEN_ENABLED")
					else
						ADD_Craft_QK()
					end
					fumoQuickQH:UnregisterEvent("ADDON_LOADED")
				end
				if event=="PLAYER_REGEN_ENABLED" then
					ADD_Craft_QK()
					fumoQuickQH:UnregisterEvent("PLAYER_REGEN_ENABLED")
				end
			end)
		end
	else
		if Skill_Button_1 then return end
		local Update_State=addonTable.Update_State
		for F=1, 7 do
			local But = CreateFrame("CheckButton", "Skill_Button_"..F, ProfessionsFrame, "SecureActionButtonTemplate");
			But:SetSize(Width,Height);
			if F<5 then
				if F==1 then
					But:SetPoint("BOTTOMLEFT",ProfessionsFrame,"TOPLEFT",300,0);
				else
					But:SetPoint("LEFT", _G["Skill_Button_"..(F-1)], "RIGHT", 16, 0);
				end
			else
				if F==5 then
					But:SetPoint("BOTTOMRIGHT",ProfessionsFrame,"TOPRIGHT",-133,0);
				else
					But:SetPoint("RIGHT",_G["Skill_Button_"..(F-1)],"LEFT",-16,0);
				end
			end
			But:RegisterForClicks("AnyUp");
			But:SetAttribute("type", "spell");
			But:Hide();
			--
			But.Border = But:CreateTexture(nil, "BACKGROUND");
			But.Border:SetTexture(136831);
			PIGRotation(But.Border,90)
			But.Border:SetPoint("BOTTOMLEFT",But,"BOTTOMLEFT",-11,-2);
			But.Border:SetDrawLayer("BACKGROUND", -8)
			
			But.icon = But:CreateTexture(nil, "BORDER");
			But.icon:SetAllPoints(But)
			-----------
			But.CheckedTexture = But:CreateTexture(nil, "ARTWORK");
			But.CheckedTexture:SetAtlas("UI-HUD-ActionBar-IconFrame-Mouseover");
			But.CheckedTexture:SetSize(Width+4,Height+4);
			But.CheckedTexture:SetPoint("CENTER",But,"CENTER",0,0);
			But.CheckedTexture:Hide()

			But:RegisterEvent("TRADE_SKILL_CLOSE")
			But:RegisterEvent("ACTIONBAR_UPDATE_STATE");
			But:HookScript("OnEvent", function(self)
				if IsCurrentSpell(self.SimID) then
					self:SetChecked(true)
					self.CheckedTexture:Show()
					return
				end
				self.CheckedTexture:Hide()
				self:SetChecked(false)
			end)
		end
		huoqu_Skill_ID()
		for F=1, #Skill_List_NEW[1] do
			local fujiK = _G["Skill_Button_"..F]
			fujiK.Type="spell"
			fujiK.SimID=Skill_List_NEW[1][F][1]
			fujiK.icon:SetTexture(GetSpellTexture(Skill_List_NEW[1][F][1]));
			fujiK:SetAttribute("spell", Skill_List_NEW[1][F][1]);
			fujiK:Show();
		end
		for F=1, #Skill_List_NEW[2] do
			local FF = F+4;
			local fujiK = _G["Skill_Button_"..FF]
			fujiK.Type="spell"
			fujiK.SimID=Skill_List_NEW[2][F][1]
			fujiK.icon:SetTexture(GetSpellTexture(Skill_List_NEW[2][F][1]));
			fujiK:SetAttribute("spell", Skill_List_NEW[2][F][1]);
			fujiK:Show();
		end
		ProfessionsFrame:HookScript("OnShow", function(self)
			if ElvUI then
				for F=1, 7 do
					_G["Skill_Button_"..F].Border:Hide()
				end
			end	
		end); 
	end
end
addonTable.ZhuanyeQKBUT_Open=ZhuanyeQKBUT_Open
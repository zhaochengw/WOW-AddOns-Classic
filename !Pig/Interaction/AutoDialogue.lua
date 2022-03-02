local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_1_UI
--////自动对话
local function yanchizhixing()
	--交任务
	if PIG['Interaction']['AutoJiaorenwu']=="ON" then
		local activeQuestCount = GetNumActiveQuests();
		local gossipActiveQuestCount = GetNumGossipActiveQuests();
		local gossipActiveQuests = { GetGossipActiveQuests() };
		for i=1, activeQuestCount do
			local title, isComplete = GetActiveTitle(i);
			if (isComplete) then
				SelectActiveQuest(i);
			end
		end

		for i=1, gossipActiveQuestCount do
			local propertyOffset = 6 * (i - 1);
			local isComplete = gossipActiveQuests[4 + propertyOffset];
		
			if (isComplete) then
				SelectGossipActiveQuest(i);
			end
		end
	end

		--接任务
		if PIG['Interaction']['AutoJierenwu']=="ON" then
			local availableQuestCount = GetNumAvailableQuests();
			local gossipAvailableQuestCount = GetNumGossipAvailableQuests();
			local gossipAvailableQuests = { GetGossipAvailableQuests() };
			for i=1, availableQuestCount do
				local isTrivial = IsAvailableQuestTrivial(i);

				if (not isTrivial) then
					SelectAvailableQuest(i);
				end
			end

			for i=1, gossipAvailableQuestCount do
				local propertyOffset = 7 * (i - 1);
				local isTrivial = gossipAvailableQuests[3 + propertyOffset];

				if (not isTrivial) then
					SelectGossipAvailableQuest(i);
				end
			end
		end
end
local function zidongduihua(self,event)
	--接
	if event=="QUEST_DETAIL" then
		if PIG['Interaction']['AutoJierenwu']=="ON" then
			AcceptQuest()
		end
	end
	--交
	if event=="QUEST_PROGRESS" then
		if PIG['Interaction']['AutoJiaorenwu']=="ON" then
			if (IsQuestCompletable()) then
				CompleteQuest();
			end
		end
	end
	if event=="QUEST_COMPLETE" then
		if PIG['Interaction']['AutoJiaorenwu']=="ON" then
			if GetNumQuestChoices() <= 1 then
				GetQuestReward(1);
			end
		end
	end
	--多选项
	if event=="QUEST_GREETING" then
		yanchizhixing()
	end
	---对话
	if PIG['Interaction']['AutoDialogue']=="ON" then
		if event=="GOSSIP_SHOW" then
			local numOptions =GetNumGossipOptions() --NPC对话选项
			local kejierenwu = GetNumGossipAvailableQuests();--返回此 NPC 提供的任务（您尚未参与）的数量
			local jiaofurenwu = GetNumGossipActiveQuests();--返回你最终应该交给这个 NPC 的活动任务的数量。
			if (numOptions+kejierenwu+jiaofurenwu)==1 then
				SelectGossipOption(1) 
				if PIG['Interaction']['AutoJierenwu']=="ON" then
					yanchizhixing()
				end
			else
				yanchizhixing()
			end
		end
	end
end

local zidongduihuaFFF = CreateFrame("Frame")
zidongduihuaFFF:SetScript("OnEvent", zidongduihua)
--自动对话
fuFrame.AutoDialogue = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.AutoDialogue:SetSize(30,32);
fuFrame.AutoDialogue:SetHitRectInsets(0,-100,0,0);
fuFrame.AutoDialogue:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-60);
fuFrame.AutoDialogue.Text:SetText("自动对话");
fuFrame.AutoDialogue.tooltip = "当NPC只有一个对话选项时自动激活选项！";
fuFrame.AutoDialogue:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Interaction']['AutoDialogue']="ON";
		zidongduihuaFFF:RegisterEvent("GOSSIP_SHOW")		
	else
		PIG['Interaction']['AutoDialogue']="OFF";
	end
end);
--自动接任务
fuFrame.AutoJierenwu = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.AutoJierenwu:SetSize(30,32);
fuFrame.AutoJierenwu:SetHitRectInsets(0,-100,0,0);
fuFrame.AutoJierenwu:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-100);
fuFrame.AutoJierenwu.Text:SetText("自动接任务");
fuFrame.AutoJierenwu.tooltip = "和NPC对话时自动接任务！";
fuFrame.AutoJierenwu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Interaction']['AutoJierenwu']="ON";
		zidongduihuaFFF:RegisterEvent("GOSSIP_SHOW")
		zidongduihuaFFF:RegisterEvent("QUEST_DETAIL")--显示任务详情时
		zidongduihuaFFF:RegisterEvent("QUEST_FINISHED")--任务框架更改
		zidongduihuaFFF:RegisterEvent("QUEST_PROGRESS")--当玩家与 NPC 谈论任务状态并且尚未点击完成按钮时触发
		zidongduihuaFFF:RegisterEvent("QUEST_GREETING")-- 与提供或接受多个任务（即有多个活动或可用任务）的 NPC 交谈时触发
		zidongduihuaFFF:RegisterEvent("QUEST_COMPLETE") --任务对话框显示了奖励和完成按钮可用
	else
		PIG['Interaction']['AutoJierenwu']="OFF";
	end
end);
--自动交任务
fuFrame.AutoJiaorenwu = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.AutoJiaorenwu:SetSize(30,32);
fuFrame.AutoJiaorenwu:SetHitRectInsets(0,-100,0,0);
fuFrame.AutoJiaorenwu:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-100);
fuFrame.AutoJiaorenwu.Text:SetText("自动交任务");
fuFrame.AutoJiaorenwu.tooltip = "和NPC对话时自动交任务！";
fuFrame.AutoJiaorenwu:SetScript("OnClick", function ()
	if fuFrame.AutoJiaorenwu:GetChecked() then
		PIG['Interaction']['AutoJiaorenwu']="ON";
		zidongduihuaFFF:RegisterEvent("GOSSIP_SHOW")
		zidongduihuaFFF:RegisterEvent("QUEST_DETAIL")
		zidongduihuaFFF:RegisterEvent("QUEST_FINISHED")
		zidongduihuaFFF:RegisterEvent("QUEST_PROGRESS")
		zidongduihuaFFF:RegisterEvent("QUEST_GREETING")
		zidongduihuaFFF:RegisterEvent("QUEST_COMPLETE") 
	else
		PIG['Interaction']['AutoJiaorenwu']="OFF";
	end
end);
----自动接收组队邀请
local zidongjieshouzuduiyaoqingFFF = CreateFrame("FRAME")
-- zidongjieshouzuduiyaoqingFFF:RegisterEvent("CONFIRM_DISENCHANT_ROLL") 
-- zidongjieshouzuduiyaoqingFFF:RegisterEvent("CONFIRM_LOOT_ROLL")   
zidongjieshouzuduiyaoqingFFF:SetScript("OnEvent", function(self, event, arg1, arg2)
	if event=="PARTY_INVITE_REQUEST" then
		AcceptGroup()
		StaticPopup_Hide("PARTY_INVITE")
	end
	if event=="RESURRECT_REQUEST" then
		AcceptResurrect()
		StaticPopup_Hide("RESURRECT")
	end
	if event=="LOOT_BIND_CONFIRM" then
		-- for i = 1, STATICPOPUP_NUMDIALOGS do 
		-- 	local frame = _G["StaticPopup"..i] 
		-- 	if (frame.which == "CONFIRM_LOOT_ROLL" or frame.which == "LOOT_BIND" or frame.which == "LOOT_BIND_CONFIRM") and frame:IsVisible() then 
		-- 		StaticPopup_OnClick(frame, 1) 
		-- 	end
		-- end
		StaticPopup_OnClick(StaticPopup1, 1) 
		StaticPopup1:Hide()
	end
end)
fuFrame.zidongjieshouyaoqing = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.zidongjieshouyaoqing:SetSize(30,32);
fuFrame.zidongjieshouyaoqing:SetHitRectInsets(0,-100,0,0);
fuFrame.zidongjieshouyaoqing:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-140);
fuFrame.zidongjieshouyaoqing.Text:SetText("自动接受组队邀请");
fuFrame.zidongjieshouyaoqing.tooltip = "自动接受组队邀请！";
fuFrame.zidongjieshouyaoqing:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Interaction']['AutoJyaoqing']="ON";
		zidongjieshouzuduiyaoqingFFF:RegisterEvent("PARTY_INVITE_REQUEST")
	else
		PIG['Interaction']['AutoJyaoqing']="OFF";
		zidongjieshouzuduiyaoqingFFF:UnregisterEvent("PARTY_INVITE_REQUEST")
	end
end);
----自动接收组队邀请
fuFrame.zidongFuhuo = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.zidongFuhuo:SetSize(30,32);
fuFrame.zidongFuhuo:SetHitRectInsets(0,-100,0,0);
fuFrame.zidongFuhuo:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-140);
fuFrame.zidongFuhuo.Text:SetText("自动接受复活");
fuFrame.zidongFuhuo.tooltip = "自动接受复活！";
fuFrame.zidongFuhuo:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Interaction']['AutoFuhuo']="ON";
		zidongjieshouzuduiyaoqingFFF:RegisterEvent("RESURRECT_REQUEST")
	else
		PIG['Interaction']['AutoFuhuo']="OFF";
		zidongjieshouzuduiyaoqingFFF:UnregisterEvent("RESURRECT_REQUEST")
	end
end);
----自动确定拾取
fuFrame.zidongLOOTqueren = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.zidongLOOTqueren:SetSize(30,32);
fuFrame.zidongLOOTqueren:SetHitRectInsets(0,-100,0,0);
fuFrame.zidongLOOTqueren:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-180);
fuFrame.zidongLOOTqueren.Text:SetText("自动确认拾取绑定");
fuFrame.zidongLOOTqueren.tooltip = "自动确认拾取绑定！";
fuFrame.zidongLOOTqueren:Hide()
fuFrame.zidongLOOTqueren:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Interaction']['AutoLOOTqwueren']="ON";
		zidongjieshouzuduiyaoqingFFF:RegisterEvent("LOOT_BIND_CONFIRM")
	else
		PIG['Interaction']['AutoLOOTqwueren']="OFF";
		zidongjieshouzuduiyaoqingFFF:UnregisterEvent("LOOT_BIND_CONFIRM")
	end
end);
fuFrame:SetScript("OnShow", function ()
	if PIG["RaidRecord"]["Invite"]["jihuo"] then
		if PIG["RaidRecord"]["Invite"]["jihuo"][1]==true and PIG["RaidRecord"]["Invite"]["jihuo"][2]==true and PIG["RaidRecord"]["Invite"]["jihuo"][4]==true and PIG["RaidRecord"]["Invite"]["jihuo"][3]==true then		
			fuFrame.zidongLOOTqueren:Show()
		else
			fuFrame.zidongLOOTqueren:Hide()
		end
	end
end)
--------------------
addonTable.Interaction_AutoDialogue = function()
	PIG['Interaction']['AutoDialogue']=PIG['Interaction']['AutoDialogue'] or addonTable.Default['Interaction']['AutoDialogue']
	PIG['Interaction']['AutoJierenwu']=PIG['Interaction']['AutoJierenwu'] or addonTable.Default['Interaction']['AutoJierenwu']
	PIG['Interaction']['AutoJiaorenwu']=PIG['Interaction']['AutoJiaorenwu'] or addonTable.Default['Interaction']['AutoJiaorenwu']
	PIG['Interaction']['AutoJyaoqing']=PIG['Interaction']['AutoJyaoqing'] or addonTable.Default['Interaction']['AutoJyaoqing']
	PIG['Interaction']['AutoFuhuo']=PIG['Interaction']['AutoFuhuo'] or addonTable.Default['Interaction']['AutoFuhuo']
	PIG['Interaction']['AutoLOOTqwueren']=PIG['Interaction']['AutoLOOTqwueren'] or addonTable.Default['Interaction']['AutoLOOTqwueren']
	if PIG['Interaction']['AutoDialogue']=="ON" or PIG['Interaction']['AutoJierenwu']=="ON" or PIG['Interaction']['AutoJiaorenwu']=="ON" then
		zidongduihuaFFF:RegisterEvent("GOSSIP_SHOW")
		zidongduihuaFFF:RegisterEvent("QUEST_DETAIL")
		zidongduihuaFFF:RegisterEvent("QUEST_FINISHED")
		zidongduihuaFFF:RegisterEvent("QUEST_PROGRESS")
		zidongduihuaFFF:RegisterEvent("QUEST_GREETING")
		zidongduihuaFFF:RegisterEvent("QUEST_COMPLETE") 
	end
	if PIG['Interaction']['AutoDialogue']=="ON" then
		fuFrame.AutoDialogue:SetChecked(true);
	end
	if PIG['Interaction']['AutoJierenwu']=="ON" then
		fuFrame.AutoJierenwu:SetChecked(true);
	end
	if PIG['Interaction']['AutoJiaorenwu']=="ON" then
		fuFrame.AutoJiaorenwu:SetChecked(true);
	end
	if PIG['Interaction']['AutoJyaoqing']=="ON" then
		fuFrame.zidongjieshouyaoqing:SetChecked(true);
		zidongjieshouzuduiyaoqingFFF:RegisterEvent("PARTY_INVITE_REQUEST")
	end
	if PIG['Interaction']['AutoFuhuo']=="ON" then
		fuFrame.zidongFuhuo:SetChecked(true);
		zidongjieshouzuduiyaoqingFFF:RegisterEvent("RESURRECT_REQUEST")
	end
	if PIG['Interaction']['AutoLOOTqwueren']=="ON" then
		zidongjieshouzuduiyaoqingFFF:RegisterEvent("LOOT_BIND_CONFIRM")
		fuFrame.zidongLOOTqueren:SetChecked(true);
	end
end
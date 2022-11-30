local _, addonTable = ...;
local fuFrame=List_R_F_1_1
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--////自动对话
local function yanchizhixing()
	--交任务
	if PIG['Interaction']['AutoJiaorenwu']=="ON" then
		if tocversion<40000 then
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
		else
			local activeQuestCount =C_GossipInfo.GetNumActiveQuests()
			local gossipActiveQuests = { C_GossipInfo.GetActiveQuests() };
			for i=1,activeQuestCount do
				if gossipActiveQuests[i] then
					for _,vv in pairs(gossipActiveQuests[i]) do
						if (vv.isComplete) then
							C_GossipInfo.SelectActiveQuest(i)
						end
					end
				end
			end
		end
	end
	--接任务
	if PIG['Interaction']['AutoJierenwu']=="ON" then
		if tocversion<40000 then
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
		else
			local availableQuestCount  = C_GossipInfo.GetNumAvailableQuests();
			local gossipAvailableQuests = { C_GossipInfo.GetAvailableQuests() };
			for i=1,availableQuestCount do
				if gossipAvailableQuests[i] then
					for _,vv in pairs(gossipAvailableQuests[i]) do
						if (not vv.isTrivial) then
							C_GossipInfo.SelectAvailableQuest(i)
						end
					end
				end
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
			if tocversion<40000 then
				local numOptions = GetNumGossipOptions() --NPC对话选项
				local kejierenwu = GetNumGossipActiveQuests() --返回此 NPC 提供的任务（您尚未参与）的数量
				local jiaofurenwu = GetNumGossipAvailableQuests() --返回你最终应该交给这个 NPC 的活动任务的数量。
				local zongjirenwu=kejierenwu+jiaofurenwu	
				if zongjirenwu>0 then
					yanchizhixing()
				else
					if numOptions==1 then
						SelectGossipOption(1)
					end
				end
			else
				local options = C_GossipInfo.GetOptions() --NPC对话选项
				local numOptions = #options
				local kejierenwu = C_GossipInfo.GetNumActiveQuests() --返回此 NPC 提供的任务（您尚未参与）的数量
				local jiaofurenwu = C_GossipInfo.GetNumAvailableQuests() --返回你最终应该交给这个 NPC 的活动任务的数量。
				local zongjirenwu=kejierenwu+jiaofurenwu
				if zongjirenwu>0 then
					yanchizhixing()
				else
					if numOptions==1 then
						C_GossipInfo.SelectOption(options[1].gossipOptionID)
					end
				end
			end
		end
	end
end

local zidongduihuaFFF = CreateFrame("Frame")
zidongduihuaFFF:SetScript("OnEvent", zidongduihua)
--自动对话
fuFrame.AutoDialogue = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",300,-60,"自动对话","当NPC只有一个对话选项时自动激活选项")
fuFrame.AutoDialogue:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Interaction']['AutoDialogue']="ON";
		zidongduihuaFFF:RegisterEvent("GOSSIP_SHOW")		
	else
		PIG['Interaction']['AutoDialogue']="OFF";
	end
end);
--自动接任务
fuFrame.AutoJierenwu = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-100,"自动接任务","和NPC对话时自动接任务")
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
fuFrame.AutoJiaorenwu = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",300,-100,"自动交任务","和NPC对话时自动交任务")
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
zidongjieshouzuduiyaoqingFFF:SetScript("OnEvent", function(self, event, arg1, arg2)
	if event=="PARTY_INVITE_REQUEST" then
		AcceptGroup()
		StaticPopup_Hide("PARTY_INVITE")
	end
	if event=="RESURRECT_REQUEST" then
		AcceptResurrect()
		StaticPopup_Hide("RESURRECT")
	end
end)
fuFrame.zidongjieshouyaoqing = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-140,"自动接受组队邀请","自动接受组队邀请")
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
fuFrame.zidongFuhuo = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",300,-140,"自动接受复活","自动接受复活")
fuFrame.zidongFuhuo:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Interaction']['AutoFuhuo']="ON";
		zidongjieshouzuduiyaoqingFFF:RegisterEvent("RESURRECT_REQUEST")
	else
		PIG['Interaction']['AutoFuhuo']="OFF";
		zidongjieshouzuduiyaoqingFFF:UnregisterEvent("RESURRECT_REQUEST")
	end
end);
--------------------
addonTable.Interaction_AutoDialogue = function()
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
end
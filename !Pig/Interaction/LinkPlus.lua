local _, addonTable = ...;
local fuFrame=List_R_F_1_1
--------------------------------------------------
-- -----------------------------
-- fuFrame.QuestLink = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
-- fuFrame.QuestLink:SetSize(30,32);
-- fuFrame.QuestLink:SetHitRectInsets(0,-100,0,0);
-- fuFrame.QuestLink:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-200);
-- fuFrame.QuestLink.Text:SetText("发送任务链接");
-- fuFrame.QuestLink.tooltip = "点击任务书可发送任务链接到聊天栏";
-- fuFrame.QuestLink:SetScript("OnClick", function (self)
-- 	if self:GetChecked() then
-- 		PIG['Interaction']['QuestLink']="ON";	
-- 	else
-- 		PIG['Interaction']['QuestLink']="OFF";
-- 	end
-- end);
--------------------
addonTable.Interaction_LinkPlus = function()
	-- if PIG['Interaction']['SpellLink']=="ON" then
	-- 	fuFrame.SpellLink:SetChecked(true);
	-- end
	-- if PIG['Interaction']['QuestLink']=="ON" then
	-- 	fuFrame.QuestLink:SetChecked(true);
	-- end
end
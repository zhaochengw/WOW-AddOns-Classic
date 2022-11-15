local addonName, addonTable = ...;
local fuFrame = List_R_F_2_3
-----------
fuFrame.title = fuFrame:CreateFontString();
fuFrame.title:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-20);
fuFrame.title:SetFontObject(GameFontNormal);
fuFrame.title:SetText("提示：");
fuFrame.title1 = fuFrame:CreateFontString();
fuFrame.title1:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",40,-50);
fuFrame.title1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.title1:SetText("\124cff00ff001.正式服已原生支持额外三条动作条(6/7/8)\124r");
fuFrame.title2 = fuFrame:CreateFontString();
fuFrame.title2:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",40,-80);
fuFrame.title2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.title2:SetJustifyH("LEFT");
fuFrame.title2:SetText("\124cff00ff002.需要额外动作条请在系统选项内打开(6/7/8)动作条\124r");

-------------------------
addonTable.Pig_Action = function()

end
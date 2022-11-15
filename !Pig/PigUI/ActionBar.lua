local _, addonTable = ...;
local fuFrame=List_R_F_1_6
local _, _, _, tocversion = GetBuildInfo()
-------------------------------------------------
fuFrame.title = fuFrame:CreateFontString();
fuFrame.title:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-20);
fuFrame.title:SetFontObject(GameFontNormal);
fuFrame.title:SetText("提示：");
fuFrame.title1 = fuFrame:CreateFontString();
fuFrame.title1:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",40,-50);
fuFrame.title1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.title1:SetText("\124cff00ff001.正式服界面已原生支持编辑，请在ESC打开编辑模式调整UI位置\124r");

----------------------------------------------
addonTable.PigUI_ActionBar = function()

end
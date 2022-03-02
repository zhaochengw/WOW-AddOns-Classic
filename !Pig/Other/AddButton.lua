local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_9_UI
--=======================================
fuFrame.addonCMD = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate")
fuFrame.addonCMD:SetBackdrop( {
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12, 
	insets = { left = 2, right = 2, top = 2, bottom = 2 } 
});
fuFrame.addonCMD:SetBackdropColor(0, 0, 0, 0.8);
fuFrame.addonCMD:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
fuFrame.addonCMD:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 300, -138)
fuFrame.addonCMD:SetPoint("BOTTOMRIGHT", fuFrame, "BOTTOMRIGHT", -10, 10)
-----------
local qitachajian="\124cff00ff00此处功能为便于其他插件\n使用，未安装对应插件将不会生效\124r"
fuFrame.addonCMD.title = fuFrame.addonCMD:CreateFontString();
fuFrame.addonCMD.title:SetPoint("BOTTOMLEFT",fuFrame.addonCMD,"TOPLEFT",10,-0);
fuFrame.addonCMD.title:SetFontObject(GameFontNormal);
fuFrame.addonCMD.title:SetText(qitachajian);
--==================================================
----拍卖行AUX3
fuFrame.addonCMD.AUX = CreateFrame("Button",nil,fuFrame.addonCMD, "UIPanelButtonTemplate");  
fuFrame.addonCMD.AUX:SetSize(80,26);
fuFrame.addonCMD.AUX:SetPoint("TOPLEFT",fuFrame.addonCMD,"TOPLEFT",10,-10);
fuFrame.addonCMD.AUX:SetText("AUX指令");
fuFrame.addonCMD.AUX:SetScript("OnClick", function()	
	if auxtxtUI:IsShown() then
		auxtxtUI:Hide()
	else
		auxtxtUI:Show()
	end
end);
fuFrame.addonCMD.AUX.title = fuFrame.addonCMD.AUX:CreateFontString();
fuFrame.addonCMD.AUX.title:SetPoint("LEFT",fuFrame.addonCMD.AUX,"RIGHT",8,0);
fuFrame.addonCMD.AUX.title:SetFontObject(GameFontNormal);
fuFrame.addonCMD.AUX.title:SetText("拍卖行插件AUX的指令");

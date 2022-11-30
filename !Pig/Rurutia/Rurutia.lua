local _, addonTable = ...;
local fuFrame=List_R_F_1_11
------
local TOPHIGHT = 30
fuFrame.top = fuFrame:CreateFontString();
fuFrame.top:SetPoint("TOP",fuFrame,"TOP",0,-8);
fuFrame.top:SetFont(ChatFontNormal:GetFont(), 14);
fuFrame.top:SetTextColor(0, 1, 0, 1);
fuFrame.top:SetText("以下为露露缇娅提供功能，反馈请找露露缇娅！");
fuFrame.line = fuFrame:CreateLine()
fuFrame.line:SetColorTexture(1,1,1,0.3)
fuFrame.line:SetThickness(1);
fuFrame.line:SetStartPoint("TOPLEFT",3,-TOPHIGHT)
fuFrame.line:SetEndPoint("TOPRIGHT",-3,-TOPHIGHT)
fuFrame.F = CreateFrame("Frame", nil, fuFrame);
fuFrame.F:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",0,-TOPHIGHT);
fuFrame.F:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",0,0);
--进入游戏时加载
addonTable.Rurutia = function()
	addonTable.Rurutia_FastFocus()
	addonTable.Rurutia_QuestsEnd()
end
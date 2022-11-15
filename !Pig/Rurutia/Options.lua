local _, addonTable = ...;
local fuFrame=List_R_F_1_10
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local ADD_Button=addonTable.ADD_Button
------
local TOPHIGHT = 30
fuFrame.top = fuFrame:CreateFontString();
fuFrame.top:SetPoint("TOP",fuFrame,"TOP",0,-7);
fuFrame.top:SetFont(ChatFontNormal:GetFont(), 14);
fuFrame.top:SetTextColor(0, 1, 0, 1);
fuFrame.top:SetText("以下为露露缇娅提供功能，反馈请找露露缇娅！");
fuFrame.line = fuFrame:CreateLine()
fuFrame.line:SetColorTexture(1,1,1,0.3)
fuFrame.line:SetThickness(1);
fuFrame.line:SetStartPoint("TOPLEFT",3,-TOPHIGHT)
fuFrame.line:SetEndPoint("TOPRIGHT",-3,-TOPHIGHT)
--------
--开关显示区域
fuFrame.F = CreateFrame("Frame", nil, fuFrame);
fuFrame.F:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",0,-TOPHIGHT);
fuFrame.F:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",0,0);
--自动确定拾取
-- fuFrame.F:RegisterEvent("CONFIRM_DISENCHANT_ROLL")  --R点
-- fuFrame.F:RegisterEvent("CONFIRM_LOOT_ROLL")   
fuFrame.F:SetScript("OnEvent", function(self, event, arg1, arg2)
	if event=="LOOT_BIND_CONFIRM" then
		-- for i = 1, STATICPOPUP_NUMDIALOGS do --R点确认
		-- 	local frame = _G["StaticPopup"..i] 
		-- 	if (frame.which == "CONFIRM_LOOT_ROLL" or frame.which == "LOOT_BIND" or frame.which == "LOOT_BIND_CONFIRM") and frame:IsVisible() then 
		-- 		StaticPopup_OnClick(frame, 1) 
		-- 	end
		-- end
		StaticPopup_OnClick(StaticPopup1, 1) 
		StaticPopup1:Hide()
	end
end)
fuFrame.F.AutoLootY =ADD_Checkbutton(nil,fuFrame.F,-100,"TOPLEFT",fuFrame.F,"TOPLEFT",20,-20,"自动确认拾取绑定","勾选将开启自动确认拾取绑定")
fuFrame.F.AutoLootY:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["Rurutia"]["AutoLootY"]="Y";
		fuFrame.F:RegisterEvent("LOOT_BIND_CONFIRM")
	else
		PIG["Rurutia"]["AutoLootY"]="N";
		fuFrame.F:UnregisterEvent("LOOT_BIND_CONFIRM")
	end
end);

--打开选项页面时===============
fuFrame.F:SetScript("OnShow", function (self)
	if PIG["Rurutia"]["AutoLootY"]=="Y" then
		fuFrame.F.AutoLootY:SetChecked(true);
	end
end);
--进入有戏时加载
addonTable.Rurutia = function()
	PIG["Rurutia"]=PIG["Rurutia"] or {}
	if PIG["Rurutia"]["AutoLootY"]=="Y" then
		fuFrame.F:RegisterEvent("LOOT_BIND_CONFIRM")
	end
end
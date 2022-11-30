local _, addonTable = ...;
local fuFrame=List_R_F_1_10
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local ADD_Button=addonTable.ADD_Button
------
local TOPHIGHT = 50
fuFrame.top = fuFrame:CreateFontString();
fuFrame.top:SetPoint("TOP",fuFrame,"TOP",0,-18);
fuFrame.top:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
fuFrame.top:SetTextColor(1, 0, 0, 1);
fuFrame.top:SetText("警告：以下为测试性功能，使用造成一切后果自负！！！");
fuFrame.line = fuFrame:CreateLine()
fuFrame.line:SetColorTexture(1,1,1,0.3)
fuFrame.line:SetThickness(1);
fuFrame.line:SetStartPoint("TOPLEFT",3,-TOPHIGHT)
fuFrame.line:SetEndPoint("TOPRIGHT",-3,-TOPHIGHT)
fuFrame.unlock={nil,nil,nil,nil}
----------
local ADD_ButtonMima=addonTable.ADD_ButtonMima
local weizhiList = {
	{"TOPLEFT","TOPLEFT",3,-TOPHIGHT-2 },
	{"TOPRIGHT","TOPRIGHT",-3,-TOPHIGHT-2},
	{"BOTTOMLEFT","BOTTOMLEFT",3,3},
	{"BOTTOMRIGHT","BOTTOMRIGHT",-3,3},
}
local function CZzhuantai(num)
	for i=1,#num do
		fuFrame.unlock[num[i]]=nil
	end
end
local weizhiListxulie = {[1]={2,3,4},[2]={},[3]={2,4},[4]={2}}
for i=1,4 do
	local Pigbut = ADD_ButtonMima(nil,nil,fuFrame,14,14,weizhiList[i][1],fuFrame,weizhiList[i][2],weizhiList[i][3],weizhiList[i][4],i)
	Pigbut:SetScript("OnClick", function (self)
		if fuFrame.F.yijiesuo then return end
		local x = 1
		for but=1,#weizhiListxulie[self:GetID()] do
			if not fuFrame.unlock[weizhiListxulie[self:GetID()][but]] then
				CZzhuantai({1,2,3,4})
				return
			end
		end
		fuFrame.unlock[self:GetID()]=true
		
		for i=1,4 do
			if not fuFrame.unlock[i] then return end
		end
		fuFrame.F.yijiesuo=true
		fuFrame.F:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",0,-TOPHIGHT);
		fuFrame.F:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",0,0);
	end);
end
--------
fuFrame.F = CreateFrame("Frame", nil, fuFrame);
----自动确定拾取
-- fuFrame.F:RegisterEvent("CONFIRM_DISENCHANT_ROLL") 
-- fuFrame.F:RegisterEvent("CONFIRM_LOOT_ROLL")   
fuFrame.F:SetScript("OnEvent", function(self, event, arg1, arg2)
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
fuFrame.F.zidongLOOTqueren =ADD_Checkbutton(nil,fuFrame.F,-100,"TOPLEFT",fuFrame.F,"TOPLEFT",20,-20,"自动确认拾取绑定","自动确认拾取绑定")
fuFrame.F.zidongLOOTqueren:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["Sponsorship"]["AutoLOOTqwueren"]=true;
		fuFrame.F:RegisterEvent("LOOT_BIND_CONFIRM")
	else
		PIG["Sponsorship"]["AutoLOOTqwueren"]=false;
		fuFrame.F:UnregisterEvent("LOOT_BIND_CONFIRM")
	end
end);
-------
fuFrame.F:SetScript("OnShow", function (self)
	-- if PIG["Sponsorship"]["AutoLOOTqwueren"] then
	-- 	fuFrame.F.zidongLOOTqueren:SetChecked(true);
	-- end
end);
addonTable.Sponsorship = function()
	-- PIG["Sponsorship"]=PIG["Sponsorship"] or {}
	-- if PIG["Sponsorship"]["AutoLOOTqwueren"] then
	-- 	fuFrame.F:RegisterEvent("LOOT_BIND_CONFIRM")
	-- 	fuFrame.F.zidongLOOTqueren:SetChecked(true);
	-- end
end
local _, addonTable = ...;
local fuFrame=List_R_F_1_10
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local ADD_Button=addonTable.ADD_Button
------
local TOPHIGHT = 52
fuFrame.top = fuFrame:CreateFontString();
fuFrame.top:SetPoint("TOP",fuFrame,"TOP",0,-4);
fuFrame.top:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.top:SetText("|cffFFFF00警告：以下为测试性功能,具有不可预知危害后果\n|cffFFFF00可能导致包括但不限于物品、金币损失，某些功能易造成团队纠纷|r\n|cffFF0000请确定后使用,使用造成一切后果自负！！！|r");
fuFrame.line = fuFrame:CreateLine()
fuFrame.line:SetColorTexture(1,1,1,0.3)
fuFrame.line:SetThickness(1);
fuFrame.line:SetStartPoint("TOPLEFT",3,-TOPHIGHT)
fuFrame.line:SetEndPoint("TOPRIGHT",-3,-TOPHIGHT)
fuFrame.unlock={}
local weizhiListxulie = {[1]={2,3,4},[2]={},[3]={2,4},[4]={2},[6]={2,3,4,1},[8]={2,3,4,1,6}}
----------
for i=1,12 do
	local Mbut = CreateFrame("Button", "pigunlock"..i, fuFrame, "BackdropTemplate",i);
	Mbut:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square");
	Mbut:SetBackdrop({edgeFile = "Interface/Buttons/WHITE8X8", edgeSize = 2})
	Mbut:SetBackdropBorderColor(0.3, 0.3, 0.3, 0.6);
	Mbut:SetSize(26,28);
	if i==1 then
		Mbut:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",236,-130);
	elseif i==4 then
		Mbut:SetPoint("TOP",_G["pigunlock"..i-3],"BOTTOM",0,-30);
	elseif i==7 then
		Mbut:SetPoint("TOP",_G["pigunlock"..i-3],"BOTTOM",0,-30);
	elseif i==10 then
		Mbut:SetPoint("TOP",_G["pigunlock"..i-3],"BOTTOM",0,-30);
	else
		Mbut:SetPoint("LEFT",_G["pigunlock"..i-1],"RIGHT",30,0);
	end

	Mbut.num = Mbut:CreateFontString();
	Mbut.num:SetPoint("CENTER",0,0);
	Mbut.num:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
	if i==10 then
		Mbut.num:SetText("*");
		Mbut.num:SetPoint("CENTER",0,-2);
	elseif i==11 then
		Mbut.num:SetText(0);
	elseif i==12 then
		Mbut.num:SetText("#");
	else
		Mbut.num:SetText(i);
	end
	Mbut:SetScript("OnMouseDown", function(self)
		if i==10 then
			self.num:SetPoint("CENTER",1.5,-3.5);
		else
			self.num:SetPoint("CENTER",1.5,-1.5);
		end
	end);
	Mbut:SetScript("OnMouseUp", function(self)
		if i==10 then
			self.num:SetPoint("CENTER",0,-2);
		else
			self.num:SetPoint("CENTER",0,0);
		end
	end);
	Mbut:SetScript("OnClick", function (self)
		PlaySoundFile(567395, "Master")
		if not weizhiListxulie[self:GetID()] then fuFrame.unlock={} return end
		local qianzhisuo = weizhiListxulie[self:GetID()]
		for but=1,#qianzhisuo do
			if not fuFrame.unlock[qianzhisuo[but]] then
				fuFrame.unlock={}
				return
			end
		end
		if fuFrame.unlock[self:GetID()] then
			fuFrame.unlock={}
		else
			fuFrame.unlock[self:GetID()]=true
		end
		for k,v in pairs(weizhiListxulie) do
			if not fuFrame.unlock[k] then return end
		end
		for xx=1,12 do
			_G["pigunlock"..xx]:Hide()
		end
		PIG.Sponsorship.open=true
		PlaySoundFile(565431, "Master")	
		fuFrame.F:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",0,-TOPHIGHT);
		fuFrame.F:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",0,0);
	end);
end
--------
fuFrame.F = CreateFrame("Frame", nil, fuFrame);
local fuFrame = fuFrame.F
----自动确定拾取
-- fuFrame.F:RegisterEvent("CONFIRM_DISENCHANT_ROLL") 
-- fuFrame.F:RegisterEvent("CONFIRM_LOOT_ROLL")   
fuFrame:SetScript("OnEvent", function(self, event, arg1, arg2)
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
fuFrame.zidongLOOTqueren =ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"自动确认拾取绑定","自动确认拾取绑定")
fuFrame.zidongLOOTqueren:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["Sponsorship"]["AutoLOOTqwueren"]=true;
		fuFrame:RegisterEvent("LOOT_BIND_CONFIRM")
	else
		PIG["Sponsorship"]["AutoLOOTqwueren"]=false;
		fuFrame:UnregisterEvent("LOOT_BIND_CONFIRM")
	end
end);
--===============================
fuFrame:SetScript("OnShow", function (self)
	if PIG["Sponsorship"]["AutoLOOTqwueren"] then
		fuFrame.zidongLOOTqueren:SetChecked(true);
	end
end);
addonTable.Sponsorship = function()
	PIG["Sponsorship"]=PIG["Sponsorship"] or {}
	if PIG["Sponsorship"]["AutoLOOTqwueren"] then
		fuFrame:RegisterEvent("LOOT_BIND_CONFIRM")
		fuFrame.zidongLOOTqueren:SetChecked(true);
	end
end
local _, addonTable = ...;
local fuFrame=List_R_F_1_5
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--================================================
fuFrame.juesexinxikz1 = fuFrame:CreateLine()
fuFrame.juesexinxikz1:SetColorTexture(1,1,1,0.4)
fuFrame.juesexinxikz1:SetThickness(1);
fuFrame.juesexinxikz1:SetStartPoint("TOPLEFT",3,-290)
fuFrame.juesexinxikz1:SetEndPoint("TOPRIGHT",-330,-290)
fuFrame.juesexinxikz2 = fuFrame:CreateLine()
fuFrame.juesexinxikz2:SetColorTexture(1,1,1,0.4)
fuFrame.juesexinxikz2:SetThickness(1);
fuFrame.juesexinxikz2:SetStartPoint("TOPLEFT",330,-290)
fuFrame.juesexinxikz2:SetEndPoint("TOPRIGHT",-2,-290)
fuFrame.juesexinxikz3 = fuFrame:CreateFontString();
fuFrame.juesexinxikz3:SetPoint("LEFT", fuFrame.juesexinxikz1, "RIGHT", 0, 0);
fuFrame.juesexinxikz3:SetPoint("RIGHT", fuFrame.juesexinxikz2, "LEFT", 0, 0);
fuFrame.juesexinxikz3:SetFontObject(GameFontNormal);
fuFrame.juesexinxikz3:SetText("角色面板");
local function shuxingFrame_Open()
	--修理费用
	if PaperDollItemsFrame.xiuli then return end
	PaperDollItemsFrame.xiuli = CreateFrame("Frame",nil,PaperDollItemsFrame);  
	PaperDollItemsFrame.xiuli:SetSize(110,20);
	PaperDollItemsFrame.xiuli:SetPoint("BOTTOMLEFT", PaperDollItemsFrame, "BOTTOMLEFT", 10, 10);
	PaperDollItemsFrame.xiuli:SetFrameLevel(6)
	PaperDollItemsFrame.xiuli.ICON = PaperDollItemsFrame:CreateTexture(nil, "OVERLAY");
	PaperDollItemsFrame.xiuli.ICON:SetTexture("interface/minimap/tracking/repair.blp");
	PaperDollItemsFrame.xiuli.ICON:SetSize(20,20);
	PaperDollItemsFrame.xiuli.ICON:SetPoint("LEFT", PaperDollItemsFrame.xiuli, "LEFT", 0, 0);
	PaperDollItemsFrame.xiuli.G = PaperDollItemsFrame:CreateFontString();
	PaperDollItemsFrame.xiuli.G:SetPoint("LEFT", PaperDollItemsFrame.xiuli.ICON, "RIGHT", 0, 0);
	PaperDollItemsFrame.xiuli.G:SetFont(ChatFontNormal:GetFont(), 13);
	local PIGtooltip = CreateFrame("GameTooltip")
	PIGtooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
	local naijiubuweiID = {1,3,5,6,7,8,9,10,16,17,18}
	PaperDollItemsFrame:HookScript("OnShow",function (self,event)
		PaperDollItemsFrame.repaircost=0
		for id=1,#naijiubuweiID do
			--local hasItem,_,cost = PIGtooltip:C_TooltipInfo.SetInventoryItem("player", naijiubuweiID[id])
			-- local dataxxx = C_TooltipInfo.GetInventoryItem("player", naijiubuweiID[id])
			-- for k,v in pairs(dataxxx) do
			-- 	print(k,v)
			-- 	for kk,vv in pairs(v) do
			-- 		print(kk,vv)
			-- 		for kkk,vvv in pairs(vv) do
			-- 			print(kkk,vvv)
			-- 		end
			-- 	end
			-- end
			--PaperDollItemsFrame.repaircost=PaperDollItemsFrame.repaircost+cost
		end
		PaperDollItemsFrame.xiuli.G:SetText(GetCoinTextureString(PaperDollItemsFrame.repaircost))
	end)
end

------
fuFrame.Juese =ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",20,-20,"显示修理费","角色面板显示修理费用")
fuFrame.Juese:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['CharacterFrame_Juese']="ON";
		shuxingFrame_Open()
	else
		PIG['FramePlus']['CharacterFrame_Juese']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
---耐久=====================================================
local zhuangbeixilieID={
	{1,"Head",true},{2,"Neck",false},{3,"Shoulder",true},{4,"Shirt",false},{5,"Chest",true},
	{6,"Waist",true},{7,"Legs",true},{8,"Feet",true},{9,"Wrist",true},{10,"Hands",true},{11,"Finger0",false},
	{12,"Finger1",false},{13,"Trinket0",false},{14,"Trinket1",false},{15,"Back",false},{16,"MainHand",true},
	{17,"SecondaryHand",true},{19,"Tabard",false},
}
-----------------------
local function Update_naijiuV()
	for inv = 1, #zhuangbeixilieID do
		if zhuangbeixilieID[inv][3] then	
			local Frameu=_G["Character"..zhuangbeixilieID[inv][2].."Slot"].naijiuV
			Frameu:SetText();
			local current, maximum = GetInventoryItemDurability(zhuangbeixilieID[inv][1]);
			if maximum then
				local naijiubaifenbi=floor(current/maximum*100);
				Frameu:SetText(naijiubaifenbi.."%");
				if naijiubaifenbi>79 then
					Frameu:SetTextColor(0,1,0, 1);
				elseif  naijiubaifenbi>59 then
					Frameu:SetTextColor(1,215/255,0, 1);
				elseif  naijiubaifenbi>39 then
					Frameu:SetTextColor(1,140/255,0, 1);
				elseif  naijiubaifenbi>19 then
					Frameu:SetTextColor(1,69/255,0, 1);
				else
					Frameu:SetTextColor(1,0,0, 1);
				end			
			end
		end
	end
end
local function ADD_naijiuV()
	for inv = 1, #zhuangbeixilieID do
		local Frameu=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
		if Frameu.naijiuV then return end
		Frameu.naijiuV = Frameu:CreateFontString();
		Frameu.naijiuV:SetPoint("BOTTOMLEFT", Frameu, "BOTTOMLEFT", 1, 1);
		Frameu.naijiuV:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
		Frameu.naijiuV:SetDrawLayer("OVERLAY", 7)
	end
	Update_naijiuV()
	PaperDollItemsFrame:HookScript("OnShow",function (self,event)
		Update_naijiuV()
	end)
end
-----------------------
fuFrame.naijiuzhi = ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",300,-20,"显示装备耐久","角色面板显示装备耐久剩余值")
fuFrame.naijiuzhi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']["CharacterFrame_naijiu"]="ON";
		ADD_naijiuV()
	else
		PIG['FramePlus']["CharacterFrame_naijiu"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--显示装备等级========================================
local pingzhiColor = {
	[0]={157/255,157/255,157/255},
	[1]={1, 1, 1},
	[2]={30/255, 1, 0},
	[3]={0,112/255,221/255},
	[4]={163/255,53/255,238/255},
	[5]={1,128/255,0},
	[6]={230/255,204/255,128/255},
	[7]={0,204/255,1},
}
--自身装备LV---------------------
local function shuaxin_LV(framef,unit, ZBID)
	framef.ZLV:SetText("");
	local itemLink = GetInventoryItemLink(unit, ZBID)
	if itemLink then
		local quality = GetInventoryItemQuality(unit, ZBID)
		if quality then
			local effectiveILvl = GetDetailedItemLevelInfo(itemLink)
			framef.ZLV:SetText(effectiveILvl);
			framef.ZLV:SetTextColor(pingzhiColor[quality][1],pingzhiColor[quality][2],pingzhiColor[quality][3], 1);
		end
	end
end
local function Update_LV()
	for inv = 1, #zhuangbeixilieID do
		if zhuangbeixilieID[inv][1]~=0 and zhuangbeixilieID[inv][1]~=4 and zhuangbeixilieID[inv][1]~=19 then
			local framef=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
			shuaxin_LV(framef,"player", zhuangbeixilieID[inv][1])
		end
	end
end
local function ADD_LVT()
	for inv = 1, #zhuangbeixilieID do
		local framef=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
		if framef.ZLV then return end
		framef.ZLV = framef:CreateFontString();
		framef.ZLV:SetPoint("TOPRIGHT", framef, "TOPRIGHT", -1, -1);
		framef.ZLV:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
		framef.ZLV:SetDrawLayer("OVERLAY", 7)
	end
	Update_LV()
	PaperDollItemsFrame:HookScript("OnShow", function()
		Update_LV();
	end)
end

--观察对象装备LV
local function Inspect_LV()
	for inv = 1, #zhuangbeixilieID do
		if zhuangbeixilieID[inv][1]~=0 and zhuangbeixilieID[inv][1]~=4 and zhuangbeixilieID[inv][1]~=19 then
			local framef=_G["Inspect"..zhuangbeixilieID[inv][2].."Slot"]
			shuaxin_LV(framef,"target", zhuangbeixilieID[inv][1])
		end
	end
end
local function ADD_guancha()
	for inv = 1, #zhuangbeixilieID do
		local framef=_G["Inspect"..zhuangbeixilieID[inv][2].."Slot"]
		if framef.ZLV then return end
		framef.ZLV = framef:CreateFontString();
		framef.ZLV:SetPoint("TOPRIGHT", framef, "TOPRIGHT", -1, -1);
		framef.ZLV:SetFont(ChatFontNormal:GetFont(), 15, "OUTLINE");
		framef.ZLV:SetDrawLayer("OVERLAY", 7)
	end
	PaperDollFrame:UnregisterEvent("ADDON_LOADED");
	C_Timer.After(0.4,Inspect_LV)
end   

------------
fuFrame.zhuangbeiLV = ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",20,-60,"显示装等","显示装备等级，背包银行物品需要显示装等请在背包内设置")
fuFrame.zhuangbeiLV:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ShowPlus']['zhuangbeiLV']="ON";
		ADD_LVT()
		PaperDollFrame:RegisterEvent("INSPECT_READY");
		PaperDollFrame:RegisterEvent("ADDON_LOADED")
	else
		PIG['ShowPlus']['zhuangbeiLV']="OFF";
		PaperDollFrame:UnregisterEvent("INSPECT_READY");
		PaperDollFrame:UnregisterEvent("ADDON_LOADED");
		Pig_Options_RLtishi_UI:Show();
	end
end);
--根据品质染色=========================================
local XWidth, XHeight =CharacterHeadSlot:GetWidth(),CharacterHeadSlot:GetHeight()
local function shuaxin_ranse(framef,unit,ZBID)
	framef.ranse:Hide()
	local quality = GetInventoryItemQuality(unit, ZBID)
    if quality and quality>1 then
        local r, g, b = GetItemQualityColor(quality);
        framef.ranse:SetVertexColor(r, g, b);
		framef.ranse:Show()
	end
end
--自身染色
local function Update_ranseV()
	for inv = 1, #zhuangbeixilieID do
		local framef=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
		shuaxin_ranse(framef,"player",zhuangbeixilieID[inv][1])
	end
end
local function add_ranseUI()
	for inv = 1, #zhuangbeixilieID do
		local framef=_G["Character"..zhuangbeixilieID[inv][2].."Slot"]
		if framef.ranse then return end
	    framef.ranse = framef:CreateTexture(nil, 'OVERLAY');
	    framef.ranse:SetTexture("Interface/Buttons/UI-ActionButton-Border");
	    framef.ranse:SetBlendMode('ADD');
	    if zhuangbeixilieID[inv][1]==0 then
	    	framef.ranse:SetSize(XWidth*1.4, XHeight*1.4);
	    else
	    	framef.ranse:SetSize(XWidth*1.8, XHeight*1.8);
	    end
	    framef.ranse:SetPoint('CENTER', framef, 'CENTER', 0, 0);
	    framef.ranse:Hide()
	end
	Update_ranseV()
	PaperDollItemsFrame:HookScript("OnShow",function (self,event)
		Update_ranseV()
	end)
end
---观察染色
local function shuaxin_guancha()
	for inv = 1, #zhuangbeixilieID do
		local framef=_G["Inspect"..zhuangbeixilieID[inv][2].."Slot"]
		if framef then
			shuaxin_ranse(framef,"target",zhuangbeixilieID[inv][1])
		end
	end
end
local function ADD_guancha_ranse()
	for inv = 1, #zhuangbeixilieID do
		local framef=_G["Inspect"..zhuangbeixilieID[inv][2].."Slot"]
		if framef.ranse then return end
	    framef.ranse = framef:CreateTexture(nil, 'OVERLAY');
	    framef.ranse:SetTexture("Interface/Buttons/UI-ActionButton-Border");
	    framef.ranse:SetBlendMode('ADD');
	    framef.ranse:SetSize(XWidth*1.8, XHeight*1.8);
	    framef.ranse:SetPoint('CENTER', framef, 'CENTER', 0, 0);
	    framef.ranse:Hide()
	end
	PaperDollFrame:UnregisterEvent("ADDON_LOADED");
	C_Timer.After(0.4,shuaxin_guancha)
end 
------------------
fuFrame.pinzhiranse = ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",300,-60,"根据品质染色边框","根据品质染色边框")
fuFrame.pinzhiranse:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['CharacterFrame_ranse']="ON";
		add_ranseUI()
		PaperDollFrame:RegisterEvent("INSPECT_READY");
		PaperDollFrame:RegisterEvent("ADDON_LOADED")
	else
		PIG['FramePlus']['CharacterFrame_ranse']="OFF";
		PaperDollFrame:UnregisterEvent("INSPECT_READY");
		PaperDollFrame:UnregisterEvent("ADDON_LOADED");
		Pig_Options_RLtishi_UI:Show();
	end
end);
--------------------
PaperDollFrame:HookScript("OnEvent", function(self,event,arg1)
	if event=="PLAYER_ENTERING_WORLD" then
		if PIG['FramePlus']['CharacterFrame_Juese']=="ON" then
			shuxingFrame_Open()
		end
		if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then
			add_ranseUI()
		end
		if PIG['ShowPlus']['zhuangbeiLV']=="ON" then
			ADD_LVT()
		end
		if PIG['FramePlus']["CharacterFrame_naijiu"]=="ON" then
			ADD_naijiuV()
		end
	end
	if event=="ADDON_LOADED" and arg1=="Blizzard_InspectUI" then
		if PIG['ShowPlus']['zhuangbeiLV']=="ON" then ADD_guancha()  end
		if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then ADD_guancha_ranse() end
		PaperDollFrame:UnregisterEvent("ADDON_LOADED")
		PaperDollFrame:RegisterEvent("INSPECT_READY");
	end
	if event=="INSPECT_READY" then
		if PIG['ShowPlus']['zhuangbeiLV']=="ON" then 
			C_Timer.After(0.4,Inspect_LV)
		end
		if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then
			C_Timer.After(0.4,shuaxin_guancha)
		end
	end

	if event=="UNIT_MODEL_CHANGED" then
		if PaperDollItemsFrame:IsShown() then
			if PIG['FramePlus']["CharacterFrame_naijiu"]=="ON" then Update_naijiuV() end
			if PIG['ShowPlus']['zhuangbeiLV']=="ON" then Update_LV() end
			if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then Update_ranseV() end
		end
	end
end);
--=====================================
fuFrame:HookScript("OnShow", function(self,event,arg1)
	if PIG['FramePlus']['CharacterFrame_Juese']=="ON" then
		fuFrame.Juese:SetChecked(true);
	end
	if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then
		fuFrame.pinzhiranse:SetChecked(true);
	end
	if PIG['ShowPlus']['zhuangbeiLV']=="ON" then
		fuFrame.zhuangbeiLV:SetChecked(true);
	end
	if PIG['FramePlus']["CharacterFrame_naijiu"]=="ON" then
		fuFrame.naijiuzhi:SetChecked(true);
	end
end)
addonTable.FramePlus_CharacterFrame = function()
	if PIG['ShowPlus']['zhuangbeiLV']=="ON" or PIG['FramePlus']['CharacterFrame_ranse']=="ON" then
		PaperDollFrame:RegisterEvent("ADDON_LOADED")
	end
end
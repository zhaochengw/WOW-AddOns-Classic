﻿local _, addonTable = ...;
local fuFrame=List_R_F_1_4
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--角色和宠物血量数字透明度---------------
local function ZishenFrame_Open()
	if PlayerFrame.ICON then return end
	--角色耐久
	PlayerFrame.ICON = PlayerFrame:CreateTexture(nil, "OVERLAY");
	PlayerFrame.ICON:SetTexture("interface/minimap/tracking/repair.blp");
	PlayerFrame.ICON:SetSize(16,16);
	PlayerFrame.ICON:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 20, 4);
	PlayerFrame.naijiu = PlayerFrame:CreateFontString();
	PlayerFrame.naijiu:SetPoint("TOPLEFT", PlayerFrame.ICON, "TOPRIGHT", -1, -1);
	PlayerFrame.naijiu:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	PlayerFrame.naijiu:SetText('??%')
	--角色移速
	PlayerFrame.yisuF=CreateFrame("Frame",nil,PlayerFrame);
	PlayerFrame.yisuF:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 70, 5);
	PlayerFrame.yisuF:SetSize(49,18);
	PlayerFrame.yisuF.Tex = PlayerFrame.yisuF:CreateTexture("Frame_Texture_UI", "ARTWORK");
	PlayerFrame.yisuF.Tex:SetTexture("interface/icons/ability_rogue_sprint.blp");
	PlayerFrame.yisuF.Tex:SetSize(13,13);
	PlayerFrame.yisuF.Tex:SetPoint("LEFT", PlayerFrame.yisuF, "LEFT", 0, 0);
	PlayerFrame.yisuT = PlayerFrame.yisuF:CreateFontString();
	PlayerFrame.yisuT:SetPoint("LEFT", PlayerFrame.yisuF.Tex, "RIGHT", 0, 0);
	PlayerFrame.yisuT:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
	PlayerFrame.yisuF:SetScript("OnUpdate", function ()
		local currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed("player");
		PlayerFrame.yisuT:SetText(Round(((currentSpeed/7)*100))..'%')
	end)
	--人物血量蓝量信息
	PlayerFrame.ziji = CreateFrame("Frame", "zijiEFrameUI", PlayerFrame,"BackdropTemplate");
	PlayerFrame.ziji:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
						tile = true, tileSize = 0, edgeSize = 16, insets = { left = 3, right = 3, top = 3, bottom = 3 }});
	PlayerFrame.ziji:SetBackdropBorderColor(1, 1, 1, 0.8);
	PlayerFrame.ziji:SetWidth(70);
	PlayerFrame.ziji:SetPoint("TOPLEFT", PlayerFrame, "TOPRIGHT", -6, -19.6);
	PlayerFrame.ziji:SetPoint("BOTTOMLEFT", PlayerFrame, "BOTTOMRIGHT", -6, 32);
	if not PIG.UnitFrame.PlayerFrame.HPFF then
		PlayerFrame.ziji:Hide();
	end	
	---------------
	PlayerFrame.ziji.title1 = PlayerFrame.ziji:CreateFontString();--血量
	PlayerFrame.ziji.title1:SetPoint("CENTER", PlayerFrame.ziji, "CENTER", 0, 1);
	PlayerFrame.ziji.title1:SetFont(ChatFontNormal:GetFont(), 15,"OUTLINE")
	PlayerFrame.ziji.title1:SetTextColor(0,1,0,1);

	PlayerFrame.ziji.title2 = PlayerFrame.ziji:CreateFontString();--血量百分比
	PlayerFrame.ziji.title2:SetPoint("BOTTOM", PlayerFrame.ziji.title1, "TOP", 0, 0);
	PlayerFrame.ziji.title2:SetFont(ChatFontNormal:GetFont(), 13,"OUTLINE")
	PlayerFrame.ziji.title2:SetTextColor(1,0.82,0,1);

	PlayerFrame.ziji.title3 = PlayerFrame.ziji:CreateFontString();--魔法值
	PlayerFrame.ziji.title3:SetPoint("TOP", PlayerFrame.ziji.title1, "BOTTOM", 0, 0);
	PlayerFrame.ziji.title3:SetFont(ChatFontNormal:GetFont(), 13,"OUTLINE")
	-------------
	local function shuaxinxueliangziji(self)
		local HP = UnitHealth("player");	
		local HPmax = UnitHealthMax("player");
		self.title1:SetText(HP..'/'..HPmax);
		if HPmax>0 then
			self.title2:SetText(math.floor(((HP/HPmax)*100)).."%");
		end
		local MP = UnitPower("player");	
		local MPmax = UnitPowerMax("player");
		self.title3:SetText(MP..'/'..MPmax);
	end
	local function dongtaixuelaingW(self)
		if UnitHealthMax("player")>99999 or UnitPowerMax("player")>99999 then
			PlayerFrame.ziji:SetWidth(100);
		elseif UnitHealthMax("player")>9999 or UnitPowerMax("player")>9999 then
			PlayerFrame.ziji:SetWidth(90);
		elseif UnitHealthMax("player")>999 or UnitPowerMax("player")>999 then
			PlayerFrame.ziji:SetWidth(80);
		end
		local powerType = UnitPowerType("player")
		local info = PowerBarColor[powerType]
		if info.r==0 and info.g==0 and info.b==1 then
			PlayerFrame.ziji.title3:SetTextColor(info.r, 0.7, info.b ,1)
		else
			PlayerFrame.ziji.title3:SetTextColor(info.r, info.g, info.b ,1)
		end
	end
	-----
	local function naijiudushuaxin()
		local zhuangbeinaijiuhezhi={0,0};
		for id = 1, 19, 1 do
			local current, maximum = GetInventoryItemDurability(id);
			if current~=nil then
				zhuangbeinaijiuhezhi[1]=zhuangbeinaijiuhezhi[1]+current;
				zhuangbeinaijiuhezhi[2]=zhuangbeinaijiuhezhi[2]+maximum;
			end
		end
		local naijiubaifenbi=floor(zhuangbeinaijiuhezhi[1]/zhuangbeinaijiuhezhi[2]*100);
		PlayerFrame.naijiu:SetText(naijiubaifenbi.."%");
		if naijiubaifenbi>79 then
			PlayerFrame.naijiu:SetTextColor(0,1,0, 1);
		elseif  naijiubaifenbi>59 then
			PlayerFrame.naijiu:SetTextColor(1,215/255,0, 1);
		elseif  naijiubaifenbi>39 then
			PlayerFrame.naijiu:SetTextColor(1,140/255,0, 1);
		elseif  naijiubaifenbi>19 then
			PlayerFrame.naijiu:SetTextColor(1,69/255,0, 1);
		else
			PlayerFrame.naijiu:SetTextColor(1,0,0, 1);
		end
	end

	--拾取方式
	PlayerFrame.lootF = CreateFrame("Frame", nil, PlayerFrame);
	PlayerFrame.lootF:SetSize(24,60);
	PlayerFrame.lootF:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 19, -58);
	PlayerFrame.lootF.loot = PlayerFrame.lootF:CreateFontString();
	PlayerFrame.lootF.loot:SetPoint("TOPLEFT", PlayerFrame.lootF, "TOPLEFT", 0, 0);
	PlayerFrame.lootF.loot:SetPoint("BOTTOMRIGHT", PlayerFrame.lootF, "BOTTOMRIGHT", 0, 0);
	PlayerFrame.lootF.loot:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	PlayerFrame.lootF.loot:SetTextColor(0, 1, 0, 1);
	PlayerFrame.lootF.loot:SetJustifyV("TOP")--垂直对齐
	local function zhanlipinfenpei()
		local lootmethod, _, _ = GetLootMethod();
		if IsInGroup()==true then 
			local lootmethod, _, _ = GetLootMethod();
			if lootmethod=="freeforall" then 
				PlayerFrame.lootF.loot:SetText("自由");
			elseif lootmethod=="roundrobin" then 
				PlayerFrame.lootF.loot:SetText("轮流");	
			elseif lootmethod=="master" then 
				PlayerFrame.lootF.loot:SetText("队长");	
			elseif lootmethod=="group" then 
				PlayerFrame.lootF.loot:SetText("队伍");	
			elseif lootmethod=="needbeforegreed" then 
				PlayerFrame.lootF.loot:SetText("需求");
			elseif lootmethod=="personalloot" then
				PlayerFrame.lootF.loot:SetText("个人");
			end
		else
			PlayerFrame.lootF.loot:SetText("未组队");
		end
	end
	PlayerFrame.lootF:SetScript("OnMouseUp", function (self)
		local lootmethod, _, _ = GetLootMethod();
		if lootmethod=="freeforall" then
			SetLootMethod("master","player")
			return
		elseif lootmethod=="master" then
			SetLootMethod("freeforall")
			return
		end
		SetLootMethod("freeforall")
	end);
	------
	PlayerFrame:RegisterUnitEvent("UNIT_HEALTH","player");
	PlayerFrame:RegisterUnitEvent("UNIT_MAXHEALTH","player");
	PlayerFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT","player");
	PlayerFrame:RegisterUnitEvent("UNIT_MAXPOWER","player");

	PlayerFrame:RegisterEvent("UPDATE_INVENTORY_DURABILITY");--耐久变化
	PlayerFrame:RegisterEvent("CONFIRM_XP_LOSS");--虚弱复活
	PlayerFrame:RegisterEvent("UPDATE_INVENTORY_ALERTS");--耐久图标变化或其他

	PlayerFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
	PlayerFrame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");--战利品方法改变时触发
	PlayerFrame:HookScript("OnEvent", function (self,event)
		if event=="PLAYER_ENTERING_WORLD" then
			dongtaixuelaingW()
			shuaxinxueliangziji(self.ziji)
			naijiudushuaxin()
			zhanlipinfenpei()
		end
		if event=="UNIT_HEALTH" or event=="UNIT_POWER_FREQUENT" or event=="UNIT_MAXHEALTH" or event=="UNIT_MAXPOWER" then
			shuaxinxueliangziji(self.ziji)
		end
		if event=="UNIT_MAXHEALTH" or event=="UNIT_MAXPOWER" then
			dongtaixuelaingW()
		end
		if event=="UPDATE_INVENTORY_DURABILITY" or event=="CONFIRM_XP_LOSS" or event=="UPDATE_INVENTORY_ALERTS" then
			naijiudushuaxin()
		end
		if event=="GROUP_ROSTER_UPDATE" or event=="PARTY_LOOT_METHOD_CHANGED" then
			zhanlipinfenpei()
		end
	end)
end
local function HideHPMPTT()
	local function shuaxintoumingdu(toumingdu)
		PlayerFrameHealthBarText:SetAlpha(toumingdu);
		PlayerFrameManaBarText:SetAlpha(toumingdu);
		PetFrameHealthBarText:SetAlpha(toumingdu);
		PetFrameManaBarText:SetAlpha(toumingdu);
	end
	shuaxintoumingdu(0.1)
	local function xianHPMP() 
		shuaxintoumingdu(1)
	end
	local function yinHPMP()
		shuaxintoumingdu(0.1)
	end
	PlayerFrameHealthBar:HookScript("OnEnter",xianHPMP);
	PlayerFrameManaBar:HookScript("OnEnter", xianHPMP)
	PetFrameHealthBar:HookScript("OnEnter", xianHPMP) 
	PetFrameManaBar:HookScript("OnEnter", xianHPMP)
	PlayerFrameHealthBar:HookScript("OnLeave", yinHPMP)
	PlayerFrameManaBar:HookScript("OnLeave", yinHPMP)
	PetFrameHealthBar:HookScript("OnLeave", yinHPMP)
	PetFrameManaBar:HookScript("OnLeave", yinHPMP)
end
--------------------
fuFrame.Ziji=ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"自身头像增强","在系统默认头像上增加耐久/移速/拾取方式提示！")
fuFrame.Ziji:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.UnitFrame.PlayerFrame.Plus=true;
		fuFrame.HPFF:Enable();
		fuFrame.Mubiao_youyi:Enable();
		ZishenFrame_Open();
	else
		PIG.UnitFrame.PlayerFrame.Plus=false;
		fuFrame.HPFF:Disable();
		fuFrame.Mubiao_youyi:Disable();
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame.HPFF=ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame.Ziji,"TOPLEFT",30,-30,"额外血量框架","在自身头像右侧显示额外血量框架！")
fuFrame.HPFF:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.UnitFrame.PlayerFrame.HPFF=true;
		zijiEFrameUI:Show()
		HideHPMPTT()
	else
		PIG.UnitFrame.PlayerFrame.HPFF=false;
		zijiEFrameUI:Hide()
		PlayerFrameHealthBarText:SetAlpha(1);
		PlayerFrameManaBarText:SetAlpha(1);
		PetFrameHealthBarText:SetAlpha(1);
		PetFrameManaBarText:SetAlpha(1);
	end
end);
--//////////////////目标头像///////////////////////////////////////////////
----移动目标头像框架位置(防止遮挡玩家自己头像扩展栏)
-- local UFPosition = CreateFrame("Frame");
-- UFPosition:SetScript("OnEvent", function (event, arg1)
-- 	if event == "VARIABLES_LOADED" then
-- 		TargetFrame:ClearAllPoints();
-- 		if zijiEFrameUI then
-- 			TargetFrame:SetPoint("LEFT",PlayerFrame,"RIGHT",zijiEFrameUI:GetWidth()+50,0);
-- 		else
-- 			TargetFrame:SetPoint("LEFT",PlayerFrame,"RIGHT",150,0);
-- 		end
-- 		TargetFrame:SetUserPlaced(true);
-- 	elseif event == "PLAYER_LOGOUT" then
-- 		TargetFrame:SetUserPlaced(false);
-- 	end
-- end);
local function zhixingYidong()
	TargetFrame:ClearAllPoints();
	TargetFrame:SetPoint("TOPLEFT",UIParent,"TOPLEFT",330,-4);
	TargetFrame:SetUserPlaced(true);
end
local Mubiao_youyiFF = CreateFrame("Frame")
Mubiao_youyiFF:HookScript("OnEvent", function()
	zhixingYidong()
end);
-------
local Mubiao_youyi_tooltip = "开启自身头像增强后，额外血量框架可能会和目标头像框架重叠，开启此选项后将会向右移动目标头像，可避免遮挡。\n|cff00FF00如需手动设置目标头像位置，请勿选中|r"
fuFrame.Mubiao_youyi=ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame.HPFF,"TOPLEFT",30,-30,"防止重叠遮挡",Mubiao_youyi_tooltip)
fuFrame.Mubiao_youyi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.UnitFrame.PlayerFrame.youyi=true;
		Mubiao_youyiFF:RegisterEvent("PLAYER_ENTERING_WORLD");
	else
		PIG.UnitFrame.PlayerFrame.youyi=false;
		Mubiao_youyiFF:UnregisterEvent("PLAYER_ENTERING_WORLD");
		Pig_Options_RLtishi_UI:Show()
	end
end);
---
fuFrame:HookScript("OnShow", function (self)
	if PIG.UnitFrame.PlayerFrame.Plus then
		fuFrame.Ziji:SetChecked(true);
	end
	if PIG.UnitFrame.PlayerFrame.HPFF then
		fuFrame.HPFF:SetChecked(true);
	end
	if PIG.UnitFrame.PlayerFrame.youyi then
		fuFrame.Mubiao_youyi:SetChecked(true);
	end
end);
--=====================================
addonTable.UnitFrame_PlayerFrame = function()
	if PIG.UnitFrame.PlayerFrame.Plus then
		ZishenFrame_Open();
		if PIG.UnitFrame.PlayerFrame.HPFF then
			HideHPMPTT()
			if PIG.UnitFrame.PlayerFrame.youyi then
				Mubiao_youyiFF:RegisterEvent("PLAYER_ENTERING_WORLD");
			end
		end
	else
		fuFrame.HPFF:Disable();
		fuFrame.Mubiao_youyi:Disable();
	end
end
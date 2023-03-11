local _, addonTable = ...;
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
						tile = true, tileSize = 0, edgeSize = 8, insets = { left = 1, right = 1, top = 1, bottom = 1 }});
	PlayerFrame.ziji:SetBackdropBorderColor(0, 1, 1, 0.4);
	PlayerFrame.ziji:SetWidth(70);
	PlayerFrame.ziji:SetPoint("TOPLEFT", PlayerFrame, "TOPRIGHT", -20, -26);
	PlayerFrame.ziji:SetPoint("BOTTOMLEFT", PlayerFrame, "BOTTOMRIGHT", -20, 26);
	if not PIG.UnitFrame.PlayerFrame.HPFF then
		PlayerFrame.ziji:Hide();
	end	
	---------------
	PlayerFrame.ziji.title1 = PlayerFrame.ziji:CreateFontString();--血量
	PlayerFrame.ziji.title1:SetPoint("CENTER", PlayerFrame.ziji, "CENTER", 0, 0);
	PlayerFrame.ziji.title1:SetFont(ChatFontNormal:GetFont(), 16,"OUTLINE")
	PlayerFrame.ziji.title1:SetTextColor(0,1,0,1);

	PlayerFrame.ziji.title2 = PlayerFrame.ziji:CreateFontString();--血量百分比
	PlayerFrame.ziji.title2:SetPoint("BOTTOM", PlayerFrame.ziji.title1, "TOP", 0, 0);
	PlayerFrame.ziji.title2:SetFontObject(ChatFontNormal);--字体
	PlayerFrame.ziji.title2:SetTextColor(1,0.82,0,1);--字体颜色

	PlayerFrame.ziji.title3 = PlayerFrame.ziji:CreateFontString();--魔法值
	PlayerFrame.ziji.title3:SetPoint("TOP", PlayerFrame.ziji.title1, "BOTTOM", 0, 0);
	PlayerFrame.ziji.title3:SetFontObject(ChatFontNormal);--字体
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
			PlayerFrame.ziji:SetWidth(120);
		elseif UnitHealthMax("player")>9999 or UnitPowerMax("player")>9999 then
			PlayerFrame.ziji:SetWidth(100);
		elseif UnitHealthMax("player")>999 or UnitPowerMax("player")>999 then
			PlayerFrame.ziji:SetWidth(90);
		end
		local powerType = UnitPowerType("player")
		local info = PowerBarColor[powerType]
		if info.r==0 and info.g==0 and info.b==1 then
			PlayerFrame.ziji.title3:SetTextColor(info.r, 0.7, info.b ,1)
		else
			PlayerFrame.ziji.title3:SetTextColor(info.r, info.g, info.b ,1)
		end
	end
	-- ---
	local function naijiudushuaxin()
		local zhuangbeinaijiuhezhi={0,0};
		for id = 1, 19, 1 do
			local current, maximum = GetInventoryItemDurability(id);
			if current~=nil then
				zhuangbeinaijiuhezhi[1]=zhuangbeinaijiuhezhi[1]+current;
				zhuangbeinaijiuhezhi[2]=zhuangbeinaijiuhezhi[2]+maximum;
			end
		end
		if zhuangbeinaijiuhezhi[1]>0 and zhuangbeinaijiuhezhi[2]>0 then
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
		else
			PlayerFrame.naijiu:SetText("N/A");
		end
	end
	--拾取方式
	PlayerFrame.lootF = CreateFrame("Button", nil, PlayerFrame);
	PlayerFrame.lootF:SetSize(24,80);
	PlayerFrame.lootF:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 1, -20);
	PlayerFrame.lootF.loot = PlayerFrame.lootF:CreateFontString();
	PlayerFrame.lootF.loot:SetPoint("TOPLEFT", PlayerFrame.lootF, "TOPLEFT", 0, 0);
	PlayerFrame.lootF.loot:SetPoint("BOTTOMRIGHT", PlayerFrame.lootF, "BOTTOMRIGHT", 0, 0);
	PlayerFrame.lootF.loot:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	PlayerFrame.lootF.loot:SetTextColor(0, 1, 0, 1);
	PlayerFrame.lootF.loot:SetJustifyV("TOP")--垂直对齐
	local function zhanlipinfenpei()
		if tocversion<40000 then
			local lootmethod, _, _ = GetLootMethod();
			if IsInGroup() then 
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
		else
			local specID = GetLootSpecialization()--当前拾取专精
			if specID>0 then
				local _, name = GetSpecializationInfoByID(specID)
				PlayerFrame.lootF.loot:SetText(name);
			else
				local specIndex = GetSpecialization()--当前专精
				local _, name = GetSpecializationInfo(specIndex)
				PlayerFrame.lootF.loot:SetText(name.."\n*");
			end
		end
	end
	PlayerFrame.lootF.specIndex=1
	local numSpecializations = GetNumSpecializations()--总专精数
	PlayerFrame.lootF:SetScript("OnClick", function (self)
		local specID = GetLootSpecialization()
		if specID==0 then
			self.specIndex = 1
			local specID, name = GetSpecializationInfo(self.specIndex)
			SetLootSpecialization(specID)
		else
			self.specIndex = self.specIndex+1
			if self.specIndex>numSpecializations then
				SetLootSpecialization(0)
				self.specIndex = 0
			else
				local specID, name = GetSpecializationInfo(self.specIndex)
				SetLootSpecialization(specID)
			end	
		end
		zhanlipinfenpei()
	end);

	------
	PlayerFrame:RegisterUnitEvent("UNIT_HEALTH","player");
	PlayerFrame:RegisterUnitEvent("UNIT_MAXHEALTH","player");
	PlayerFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT","player");
	PlayerFrame:RegisterUnitEvent("UNIT_MAXPOWER","player");

	PlayerFrame:RegisterEvent("UPDATE_INVENTORY_DURABILITY");--耐久变化
	PlayerFrame:RegisterEvent("CONFIRM_XP_LOSS");--虚弱复活
	PlayerFrame:RegisterEvent("UPDATE_INVENTORY_ALERTS");--耐久图标变化或其他

	PlayerFrame:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED");

	PlayerFrame:HookScript("OnEvent", function (self,event)
		if event=="PLAYER_ENTERING_WORLD" then
			dongtaixuelaingW()
			shuaxinxueliangziji(self.ziji)
		end
		if event=="UNIT_HEALTH" or event=="UNIT_POWER_FREQUENT" or event=="UNIT_MAXHEALTH" or event=="UNIT_MAXPOWER" then
			shuaxinxueliangziji(self.ziji)
		end
		if event=="UNIT_MAXHEALTH" or event=="UNIT_MAXPOWER" then
			dongtaixuelaingW()
		end
		if event=="PLAYER_ENTERING_WORLD" or event=="UPDATE_INVENTORY_DURABILITY" or event=="CONFIRM_XP_LOSS" or event=="UPDATE_INVENTORY_ALERTS" then
			naijiudushuaxin()
		end
		if event=="PLAYER_ENTERING_WORLD" or event=="PLAYER_LOOT_SPEC_UPDATED" then
			zhanlipinfenpei()
		end
	end)
end
local function HideHPMPTT()
	local function shuaxintoumingdu(toumingdu)
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.HealthBarText:SetAlpha(toumingdu);
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.ManaBarText:SetAlpha(toumingdu);
		PetFrameHealthBar.TextString:SetAlpha(toumingdu);
		PetFrameManaBar.TextString:SetAlpha(toumingdu);
	end
	shuaxintoumingdu(0.1)
	local function xianHPMP() 
		shuaxintoumingdu(1)
	end
	local function yinHPMP()
		shuaxintoumingdu(0.1)
	end
	PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar:HookScript("OnEnter",xianHPMP);
	PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar:HookScript("OnLeave", yinHPMP)
	PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar:HookScript("OnEnter", xianHPMP)
	PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar:HookScript("OnLeave", yinHPMP)
	PetFrameHealthBar:HookScript("OnEnter", xianHPMP) 
	PetFrameHealthBar:HookScript("OnLeave", yinHPMP)
	PetFrameManaBar:HookScript("OnEnter", xianHPMP)
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
	TargetFrame:SetPoint("TOPLEFT",UIParent,"TOPLEFT",350,-4);
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
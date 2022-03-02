local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_4_UI
local _, _, _, tocversion = GetBuildInfo()
--角色和宠物血量数字透明度---------------
local function ZishenFrame_Open()
	if zijiEFrameUI==nil then
		--角色耐久
		PlayerFrame.ICON = PlayerFrame:CreateTexture(nil, "OVERLAY");
		PlayerFrame.ICON:SetTexture("interface/minimap/tracking/repair.blp");
		PlayerFrame.ICON:SetSize(16,16);
		PlayerFrame.ICON:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 20, 4);
		PlayerFrame.naijiu = PlayerFrame:CreateFontString();
		PlayerFrame.naijiu:SetPoint("TOPLEFT", PlayerFrame.ICON, "TOPRIGHT", -1, -1);
		PlayerFrame.naijiu:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
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
		--队伍拾取方式
		PlayerFrame.loot = PlayerFrame:CreateFontString();
		PlayerFrame.loot:SetSize(20,40);
		PlayerFrame.loot:SetPoint("LEFT", PlayerFrame, "LEFT", 19, -18);
		PlayerFrame.loot:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
		PlayerFrame.loot:SetTextColor(0, 1, 0, 1);
		--人物血量蓝量信息
		PlayerFrame.ziji = CreateFrame("Frame", "zijiEFrameUI", PlayerFrame,"BackdropTemplate");
		PlayerFrame.ziji:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
							tile = true, tileSize = 0, edgeSize = 16, insets = { left = 3, right = 3, top = 3, bottom = 3 }});
		PlayerFrame.ziji:SetBackdropBorderColor(1, 1, 1, 0.8);
		PlayerFrame.ziji:SetWidth(70);
		PlayerFrame.ziji:SetPoint("TOPLEFT", PlayerFrame, "TOPRIGHT", -6, -19.6);
		PlayerFrame.ziji:SetPoint("BOTTOMLEFT", PlayerFrame, "BOTTOMRIGHT", -6, 32);
		if PIG['FramePlus']['TouxiangFrame_HPFF']=="OFF" then
			PlayerFrame.ziji:Hide();
		end
		
		---------------
		PlayerFrame.ziji.title1 = PlayerFrame.ziji:CreateFontString();--血量
		PlayerFrame.ziji.title1:SetPoint("CENTER", PlayerFrame.ziji, "CENTER", 0, 0);
		PlayerFrame.ziji.title1:SetFontObject(ChatFontNormal);
		PlayerFrame.ziji.title1:SetTextColor(0,1,0,1);

		PlayerFrame.ziji.title2 = PlayerFrame.ziji:CreateFontString();--血量百分比
		PlayerFrame.ziji.title2:SetPoint("BOTTOM", PlayerFrame.ziji.title1, "TOP", 0, 0);
		PlayerFrame.ziji.title2:SetFontObject(ChatFontNormal);--字体
		PlayerFrame.ziji.title2:SetTextColor(1,0.82,0,1);--字体颜色

		PlayerFrame.ziji.title3 = PlayerFrame.ziji:CreateFontString();--魔法值
		PlayerFrame.ziji.title3:SetPoint("TOP", PlayerFrame.ziji.title1, "BOTTOM", 0, 0);
		PlayerFrame.ziji.title3:SetFontObject(ChatFontNormal);--字体
		local _, _, classId = UnitClass("player");
		if classId==1 then --战士
			PlayerFrame.ziji.title3:SetTextColor(1,0,0,1);
		elseif classId==4 then --盗贼
			PlayerFrame.ziji.title3:SetTextColor(1,1,0,1);
		else
			PlayerFrame.ziji.title3:SetTextColor(0,9,1,1);
		end
		PlayerFrame.ziji.title3:SetScale(0.9);
		-------------
		local function shuaxinxueliangziji(self,arg1)
			local HP = UnitHealth(arg1);	
			local HPmax = UnitHealthMax(arg1);
			self.title1:SetText(HP..'/'..HPmax);
			if HPmax>0 then
				self.title2:SetText(math.floor(((HP/HPmax)*100)).."%");
			end
			local MP = UnitPower(arg1);	
			local MPmax = UnitPowerMax(arg1);
			self.title3:SetText(MP..'/'..MPmax);
		end
		local function dongtaixuelaingW()
			if UnitHealthMax("player")>99999 or UnitPowerMax("player")>99999 then
				PlayerFrame.ziji:SetWidth(100);
			elseif UnitHealthMax("player")>9999 or UnitPowerMax("player")>9999 then
				PlayerFrame.ziji:SetWidth(90);
			elseif UnitHealthMax("player")>999 or UnitPowerMax("player")>999 then
				PlayerFrame.ziji:SetWidth(80);
			end
		end
		C_Timer.After(2,dongtaixuelaingW)
		PlayerFrame.ziji:RegisterUnitEvent("UNIT_HEALTH","player");
		PlayerFrame.ziji:RegisterUnitEvent("UNIT_MAXHEALTH","player");
		PlayerFrame.ziji:RegisterUnitEvent("UNIT_POWER_FREQUENT","player");
		PlayerFrame.ziji:RegisterUnitEvent("UNIT_MAXPOWER","player");
		PlayerFrame.ziji:HookScript("OnEvent", function (self,event,arg1)
			shuaxinxueliangziji(self,arg1)
			if event=="UNIT_MAXHEALTH" or event=="UNIT_MAXPOWER" then
				dongtaixuelaingW()
			end
		end)
		---
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
		naijiudushuaxin()
		----
		local function zhanlipinfenpei()
			if IsInGroup()==true then 
				local lootmethod, _, _ = GetLootMethod();
				if lootmethod=="freeforall" then 
					PlayerFrame.loot:SetText("自由");
				elseif lootmethod=="roundrobin" then 
					PlayerFrame.loot:SetText("轮流");	
				elseif lootmethod=="master" then 
					PlayerFrame.loot:SetText("队长");	
				elseif lootmethod=="group" then 
					PlayerFrame.loot:SetText("队伍");	
				elseif lootmethod=="needbeforegreed" then 
					PlayerFrame.loot:SetText("需求");	
				end
			else
				PlayerFrame.loot:SetText();
			end
		end
		zhanlipinfenpei()
		-----
		local zijieventFFF = CreateFrame("Frame");
		zijieventFFF:RegisterEvent("PLAYER_ENTERING_WORLD");
		zijieventFFF:RegisterEvent("GROUP_ROSTER_UPDATE");
		zijieventFFF:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");--战利品方法改变时触发
		zijieventFFF:RegisterEvent("UPDATE_INVENTORY_DURABILITY");--耐久变化
		zijieventFFF:RegisterEvent("CONFIRM_XP_LOSS");--虚弱复活
		zijieventFFF:RegisterEvent("UPDATE_INVENTORY_ALERTS");--耐久图标变化或其他
		zijieventFFF:SetScript("OnEvent", function (self,event)
			--血量
			if event=="PLAYER_ENTERING_WORLD" then
				shuaxinxueliangziji(PlayerFrame.ziji,"player")
			end
			--耐久
			if event=="UPDATE_INVENTORY_DURABILITY" or event=="CONFIRM_XP_LOSS" or event=="UPDATE_INVENTORY_ALERTS" then
				naijiudushuaxin()
			end
			--战利品分配
			if event=="PARTY_LOOT_METHOD_CHANGED" or "GROUP_ROSTER_UPDATE" then
				zhanlipinfenpei()
			end
		end);
	end
end
local function HideHPMPTT()
	PlayerFrameHealthBarText:SetAlpha(0.1);
	PlayerFrameManaBarText:SetAlpha(0.1);
	PetFrameHealthBarText:SetAlpha(0.1);
	PetFrameManaBarText:SetAlpha(0.1);
	local function xianHPMP() 
		PlayerFrameHealthBarText:SetAlpha(1);PlayerFrameManaBarText:SetAlpha(1);
		PetFrameHealthBarText:SetAlpha(1);PetFrameManaBarText:SetAlpha(1);
	end
	local function yinHPMP()
		PlayerFrameHealthBarText:SetAlpha(0.1);PlayerFrameManaBarText:SetAlpha(0.1);
		PetFrameHealthBarText:SetAlpha(0.1);PetFrameManaBarText:SetAlpha(0.1);
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
fuFrame.Ziji = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Ziji:SetSize(30,32);
fuFrame.Ziji:SetHitRectInsets(0,-100,0,0);
fuFrame.Ziji:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-20);
fuFrame.Ziji.Text:SetText("自身头像增强");
fuFrame.Ziji.tooltip = "在系统默认头像后增加额外血量资源显示状态！";
fuFrame.Ziji:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['TouxiangFrame_Zishen']="ON";
		ZishenFrame_Open();
	else
		PIG['FramePlus']['TouxiangFrame_Zishen']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame.HPFF = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.HPFF:SetSize(30,32);
fuFrame.HPFF:SetHitRectInsets(0,-100,0,0);
fuFrame.HPFF:SetPoint("TOPLEFT",fuFrame.Ziji,"BOTTOMLEFT",30,-1);
fuFrame.HPFF.Text:SetText("额外血量框架");
fuFrame.HPFF.tooltip = "在自身头像右侧显示额外血量框架！";
fuFrame.HPFF:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['TouxiangFrame_HPFF']="ON";
		zijiEFrameUI:Show()
		HideHPMPTT()
	else
		PIG['FramePlus']['TouxiangFrame_HPFF']="OFF";
		zijiEFrameUI:Hide()
		PlayerFrameHealthBarText:SetAlpha(1);
		PlayerFrameManaBarText:SetAlpha(1);
		PetFrameHealthBarText:SetAlpha(1);
		PetFrameManaBarText:SetAlpha(1);
	end
end);
--//////////////////目标头像///////////////////////////////////////////////
----移动目标头像框架位置(防止遮挡玩家自己头像扩展栏)
local UFPosition = CreateFrame("Frame", "UFPosition");
UFPosition:RegisterEvent("VARIABLES_LOADED");
UFPosition:RegisterEvent("PLAYER_LOGOUT");	 
function UFPosition:OnEvent(event, arg1)
	if PIG['FramePlus']['TouxiangFrame_Zishen']=="ON" and PIG['FramePlus']['TouxiangFrame_Mubiao_youyi']=="ON" then
		if event == "VARIABLES_LOADED" then
			TargetFrame:ClearAllPoints();
			if zijiEFrameUI then
				TargetFrame:SetPoint("LEFT",PlayerFrame,"RIGHT",zijiEFrameUI:GetWidth()+50,0);
			else
				TargetFrame:SetPoint("LEFT",PlayerFrame,"RIGHT",150,0);
			end
			TargetFrame:SetUserPlaced(true);
		elseif event == "PLAYER_LOGOUT" then
			TargetFrame:SetUserPlaced(false);
		end
	end
end	 
UFPosition:SetScript("OnEvent", UFPosition.OnEvent);

fuFrame.Mubiao_youyi = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Mubiao_youyi:SetSize(30,32);
fuFrame.Mubiao_youyi:SetHitRectInsets(0,-100,0,0);
fuFrame.Mubiao_youyi:SetPoint("TOPLEFT",fuFrame.HPFF,"BOTTOMLEFT",30,-1);
fuFrame.Mubiao_youyi.Text:SetText("防止重叠遮挡");
fuFrame.Mubiao_youyi.tooltip = "开启自身头像增强后，额外血量框架可能会和目标头像框架重叠，开启此选项后将会向右移动目标头像，可避免遮挡。如需手动设置目标头像位置，请勿选中。";
fuFrame.Mubiao_youyi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['TouxiangFrame_Mubiao_youyi']="ON";
		if tocversion>20000 and tocversion<40000 then
			TargetFrame:ClearAllPoints();
			TargetFrame:SetPoint("LEFT",PlayerFrame,"RIGHT",180,0);
			TargetFrame:SetUserPlaced(true);
		end
		Pig_Options_RLtishi_UI:Show()
	else
		PIG['FramePlus']['TouxiangFrame_Mubiao_youyi']="OFF";
		if tocversion>20000 and tocversion<40000 then
			TargetFrame:SetUserPlaced(false);
		end
		Pig_Options_RLtishi_UI:Show()
	end
end);
--=====================================
addonTable.UnitFrame_PlayerFrame = function()
	PIG['FramePlus']['TouxiangFrame_HPFF']=PIG['FramePlus']['TouxiangFrame_HPFF'] or addonTable.Default['FramePlus']['TouxiangFrame_HPFF']
	if PIG['FramePlus']['TouxiangFrame_Zishen']=="ON" then
		fuFrame.Ziji:SetChecked(true);
		
	end
	if PIG['FramePlus']['TouxiangFrame_HPFF']=="ON" then
		fuFrame.HPFF:SetChecked(true);
	end

	if PIG['FramePlus']['TouxiangFrame_Zishen']=="ON" then
		ZishenFrame_Open();
		if PIG['FramePlus']['TouxiangFrame_HPFF']=="ON" then
			zijiEFrameUI:Show()
			HideHPMPTT()
		end
	end
end
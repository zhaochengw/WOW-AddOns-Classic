local _, addonTable = ...;
local fuFrame=List_R_F_1_4
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
---------------------------------
local function MubiaoFrame_Open()
	if UFP_Targetzhiyetubiao then return end
	local SpentPoints = CreateFrame("Frame", "InspectTalentFrameSpentPoints", InspectTalentFrame);
	if tocversion<20000 then
		--目标血量
		hooksecurefunc("TargetFrame_CheckClassification",function(self,lock)--银鹰标志
			if not lock and UnitClassification(self.unit)=="rareelite" then
				self.borderTexture:SetTexture("Interface/TargetingFrame/UI-TargetingFrame-Rare-Elite");
			end
		end);
		local function SetupStatusBarText(bar,parent)
			local text=parent:CreateFontString(nil,"OVERLAY","TextStatusBarText")
			local left=parent:CreateFontString(nil,"OVERLAY","TextStatusBarText")
			local right=parent:CreateFontString(nil,"OVERLAY","TextStatusBarText");

			text:SetPoint("CENTER",bar,"CENTER");
			left:SetPoint("LEFT",bar,"LEFT",2,0);
			right:SetPoint("RIGHT",bar,"RIGHT",-2,0);
			bar.TextString,bar.LeftText,bar.RightText=text,left,right;
		end
		SetupStatusBarText(TargetFrameHealthBar,TargetFrameTextureFrame);
		SetupStatusBarText(TargetFrameManaBar,TargetFrameTextureFrame);
	elseif tocversion<30000 then
		TargetHealthDB = TargetHealthDB or { version=1, forcePercentages=false }
		TargetHealthDB.forcePercentages = true
		local function HealthBar_Update(statusbar, unit)
		    if ( not statusbar or statusbar.lockValues ) then
		        return;
		    end
		    if ( unit == statusbar.unit ) then
		        TargetHealthDB.maxValue = UnitHealthMax(unit);
		        statusbar.showPercentage = false;
		        statusbar.forceHideText = false;
		        if ( TargetHealthDB.maxValue == 0 ) then
		            TargetHealthDB.maxValue = 1;
		            statusbar.forceHideText = true;
		        elseif ( TargetHealthDB.maxValue == 100 and not ShouldKnowUnitHealth(unit) ) then
		            if TargetHealthDB.forcePercentages then
		                statusbar.showPercentage = true;
		            end
		        end
		    end
		    TextStatusBar_UpdateTextString(statusbar);
		end
		hooksecurefunc("UnitFrameHealthBar_Update", HealthBar_Update)
	end
	---目标职业图标
	TargetFrame.zhiyetubiao = CreateFrame("Button", "UFP_Targetzhiyetubiao", TargetFrame);
	TargetFrame.zhiyetubiao:SetSize(32,32);
	TargetFrame.zhiyetubiao:ClearAllPoints();
	TargetFrame.zhiyetubiao:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 119, 3);
	TargetFrame.zhiyetubiao:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");
	TargetFrame.zhiyetubiao:Hide()
	if tocversion>90000 then
		TargetFrame.zhiyetubiao:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 144, 4);
		TargetFrame.zhiyetubiao:SetFrameLevel(505)
	else
		TargetFrame.zhiyetubiao:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 119, 3);
	end

	TargetFrame.zhiyetubiao.Border = TargetFrame.zhiyetubiao:CreateTexture(nil, "OVERLAY");
	TargetFrame.zhiyetubiao.Border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder");
	TargetFrame.zhiyetubiao.Border:SetSize(54,54);
	TargetFrame.zhiyetubiao.Border:ClearAllPoints();
	TargetFrame.zhiyetubiao.Border:SetPoint("CENTER", 11, -12);

	TargetFrame.zhiyetubiao.Icon = TargetFrame.zhiyetubiao:CreateTexture(nil, "ARTWORK");
	TargetFrame.zhiyetubiao.Icon:SetSize(20,20);
	TargetFrame.zhiyetubiao.Icon:ClearAllPoints();
	TargetFrame.zhiyetubiao.Icon:SetPoint("CENTER");
	--点击功能：左交易/右观察
	TargetFrame.zhiyetubiao:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	TargetFrame.zhiyetubiao:HookScript("OnClick", function (self, event, button)
		if UnitIsConnected("target") and UnitIsFriend("player", "target") then--目标未离线/是友善
			local inRange1 = CheckInteractDistance("target", 1);				  
			if event=="LeftButton" and not UnitIsDead("target") then
				InspectUnit("target"); 
			elseif event=="RightButton" and inRange1 then	
				InitiateTrade("target");            
			end
		end
	end);
	--目标种族/生物类型
	TargetFrame.mubiaoLX = CreateFrame("Frame", nil, TargetFrame);
	TargetFrame.mubiaoLX:SetSize(68,18);
	if tocversion>90000 then
		TargetFrame.mubiaoLX:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 64, -3);
	else
		TargetFrame.mubiaoLX:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 52, -3);
	end
	TargetFrame.mubiaoLX.title = TargetFrame.mubiaoLX:CreateFontString();
	TargetFrame.mubiaoLX.title:SetPoint("RIGHT", TargetFrame.mubiaoLX, "RIGHT", 0, 0);
	TargetFrame.mubiaoLX.title:SetFont(GameFontNormal:GetFont(), 14.4, "OUTLINE");
	TargetFrame.mubiaoLX.title:SetTextColor(0,1,1,1);
	--
	TargetFrame:HookScript("OnEvent", function (self,event)
		if event=="PLAYER_TARGET_CHANGED" then
			--职业图标
			if UnitIsPlayer("target") then --判断是否为玩家
				local raceText = UnitRace("target");	
				TargetFrame.mubiaoLX.title:SetText(raceText);
				local IconCoord = CLASS_ICON_TCOORDS[select(2,UnitClass("target"))];
				if IconCoord then
					TargetFrame.zhiyetubiao.Icon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
					TargetFrame.zhiyetubiao.Icon:SetTexCoord(unpack(IconCoord));--切出子区域
				end
				TargetFrame.zhiyetubiao:Show()
			else
				local creatureType = UnitCreatureType("target")
				TargetFrame.mubiaoLX.title:SetText(creatureType);
				TargetFrame.zhiyetubiao:Hide()
			end;
		end
	end);
	--目标仇恨百分比
	if tocversion<40000 then
		TargetFrame.mubiaoCHbaifenbi=CreateFrame("Frame",nil,TargetFrame);
		TargetFrame.mubiaoCHbaifenbi:SetPoint("TOPLEFT",TargetFrame,"TOPLEFT",7,0);
		TargetFrame.mubiaoCHbaifenbi:SetSize(49,22);
		TargetFrame.mubiaoCHbaifenbi:Hide();
		TargetFrame.mubiaoCHbaifenbi.Background=TargetFrame.mubiaoCHbaifenbi:CreateTexture(nil,"BACKGROUND");
		TargetFrame.mubiaoCHbaifenbi.Background:SetTexture("Interface\\TargetingFrame\\UI-StatusBar");
		TargetFrame.mubiaoCHbaifenbi.Background:SetPoint("TOP",0,-3);
		TargetFrame.mubiaoCHbaifenbi.Background:SetSize(37,18);
		TargetFrame.mubiaoCHbaifenbi.border=TargetFrame.mubiaoCHbaifenbi:CreateTexture(nil,"ARTWORK");
		TargetFrame.mubiaoCHbaifenbi.border:SetTexture("Interface\\TargetingFrame\\NumericThreatBorder");
		TargetFrame.mubiaoCHbaifenbi.border:SetTexCoord(0,0.765625,0,0.5625);
		TargetFrame.mubiaoCHbaifenbi.border:SetAllPoints(TargetFrame.mubiaoCHbaifenbi);
		TargetFrame.mubiaoCHbaifenbi.title = TargetFrame.mubiaoCHbaifenbi:CreateFontString();
		TargetFrame.mubiaoCHbaifenbi.title:SetPoint("CENTER", TargetFrame.mubiaoCHbaifenbi, "CENTER", 1, -1.4);
		TargetFrame.mubiaoCHbaifenbi.title:SetFont(GameFontNormal:GetFont(), 13, "OUTLINE");
		TargetFrame.mubiaoCHbaifenbi.title:SetTextColor(1,1,1,1);
		--仇恨高亮背景
		TargetFrame.mubiaoCHbaifenbi_REDALL=TargetFrame:CreateTexture(nil,"BACKGROUND");
		TargetFrame.mubiaoCHbaifenbi_REDALL:SetTexture("interface/targetingframe/ui-targetingframe-flash.blp");
		if tocversion<20000 then
			TargetFrame.mubiaoCHbaifenbi_REDALL:SetTexCoord(0.09,1,0,0.194);
			TargetFrame.mubiaoCHbaifenbi_REDALL:SetPoint("TOPLEFT",TargetFrameTextureFrame,"TOPLEFT",0,0);
			TargetFrame.mubiaoCHbaifenbi_REDALL:SetPoint("BOTTOMRIGHT",TargetFrameTextureFrame,"BOTTOMRIGHT",0,0);
		elseif tocversion<30000 then
			TargetFrame.mubiaoCHbaifenbi_REDALL:SetPoint("TOPLEFT",TargetFrameTextureFrame,"TOPLEFT",-23,0);
		else
			TargetFrame.mubiaoCHbaifenbi_REDALL:SetTexCoord(0.09,1,0,0.194);
			TargetFrame.mubiaoCHbaifenbi_REDALL:SetPoint("TOPLEFT",TargetFrameTextureFrame,"TOPLEFT",0,0);
			TargetFrame.mubiaoCHbaifenbi_REDALL:SetPoint("BOTTOMRIGHT",TargetFrameTextureFrame,"BOTTOMRIGHT",0,0);
		end
		TargetFrame.mubiaoCHbaifenbi_REDALL:SetVertexColor(1,0,0);
		TargetFrame.mubiaoCHbaifenbi_REDALL:Hide();
		---
		local YuanshiW=TargetFrameNameBackground:GetWidth();
		TargetFrameNameBackground:ClearAllPoints();
		TargetFrameNameBackground:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 7, -22);
		--
		TargetFrame:RegisterUnitEvent("UNIT_THREAT_LIST_UPDATE","target");--怪物仇恨列表目录改变
		TargetFrame:HookScript("OnEvent", function (self,event,arg1)
			if event=="PLAYER_TARGET_CHANGED" or event=="UNIT_THREAT_LIST_UPDATE" then
				if not (UnitIsPlayer("target")) and UnitCanAttack("player", "target") then --不是玩家/可攻击
					local YuanshiC = TargetFrameNameBackground:GetVertexColor();
					local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target")
					if threatpct==nil then --进度条
						TargetFrameNameBackground:SetWidth(YuanshiW);
						TargetFrame.mubiaoCHbaifenbi.title:SetText('0%');
					else
						TargetFrameNameBackground:SetWidth(YuanshiW*(threatpct/100));
						if isTanking then
							TargetFrame.mubiaoCHbaifenbi.title:SetText('Tank');
						else
							TargetFrame.mubiaoCHbaifenbi.title:SetText(math.ceil(threatpct)..'%');
						end	
					end
					if status==0 then --进度条/百分比材质颜色
						TargetFrame.mubiaoCHbaifenbi_REDALL:Hide();
						TargetFrameNameBackground:SetVertexColor(0.69, 0.69, 0.69);
						TargetFrame.mubiaoCHbaifenbi:Show();
						TargetFrame.mubiaoCHbaifenbi.Background:SetVertexColor(0.69, 0.69, 0.69);
					elseif status==1 then
						TargetFrame.mubiaoCHbaifenbi_REDALL:Hide();
						TargetFrameNameBackground:SetVertexColor(1, 1, 0.47);
						TargetFrame.mubiaoCHbaifenbi:Show();
						TargetFrame.mubiaoCHbaifenbi.Background:SetVertexColor(1, 1, 0.47);
					elseif status==2 then
						TargetFrame.mubiaoCHbaifenbi_REDALL:Show();
						TargetFrameNameBackground:SetVertexColor(1, 0.6, 0);
						TargetFrame.mubiaoCHbaifenbi:Show();
						TargetFrame.mubiaoCHbaifenbi.Background:SetVertexColor(1, 0.6, 0);
						--PlaySoundFile("sound/item/weapons/sword1h/m1hswordhitmetalshieldcrit.ogg", "Master")
					elseif status==3 then
						TargetFrame.mubiaoCHbaifenbi_REDALL:Show();
						TargetFrameNameBackground:SetVertexColor(1, 0, 0);
						TargetFrame.mubiaoCHbaifenbi:Show();
						TargetFrame.mubiaoCHbaifenbi.Background:SetVertexColor(1, 0, 0);
						--PlaySoundFile("sound/item/weapons/sword1h/m1hswordhitmetalshieldcrit.ogg", "Master")		
					elseif status==nil then
						TargetFrame.mubiaoCHbaifenbi_REDALL:Hide();
						TargetFrameNameBackground:SetVertexColor(YuanshiC);
						TargetFrame.mubiaoCHbaifenbi:Hide();
					end
				else
					TargetFrameNameBackground:SetWidth(YuanshiW);
					TargetFrame.mubiaoCHbaifenbi_REDALL:Hide();
					TargetFrame.mubiaoCHbaifenbi:Hide();
				end
			end
		end)
	else
		TargetFrame:HookScript("OnEvent", function (self,event,arg1)
			if event=="PLAYER_TARGET_CHANGED" or event=="UNIT_THREAT_LIST_UPDATE" or event=="UNIT_THREAT_SITUATION_UPDATE" then
				TargetFrame.threatNumericIndicator:SetPoint("BOTTOM",TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor,"TOP",-42,0);
			end
		end)
	end
	--目标生命百分比
	TargetFrame.mubiaoHP=CreateFrame("Frame",nil,TargetFrame);
	if tocversion>90000 then
		TargetFrame.mubiaoHP:SetPoint("RIGHT",TargetFrame,"LEFT",24,-2);
	else
		TargetFrame.mubiaoHP:SetPoint("RIGHT",TargetFrame,"LEFT",5,-2);
	end
	TargetFrame.mubiaoHP:SetSize(49,22);
	TargetFrame.mubiaoHP.title = TargetFrame.mubiaoHP:CreateFontString();
	TargetFrame.mubiaoHP.title:SetPoint("TOPRIGHT", TargetFrame.mubiaoHP, "TOPRIGHT", 0, 0);
	TargetFrame.mubiaoHP.title:SetFont(GameFontNormal:GetFont(), 13, "OUTLINE");
	TargetFrame.mubiaoHP.title:SetTextColor(1, 1, 0.47,1);
	----------------------
	TargetFrame:HookScript("OnEvent", function (self,event,arg1)
		if event=="PLAYER_TARGET_CHANGED" or event=="UNIT_HEALTH" or event=="UNIT_AURA" then
			local mubiaoH = UnitHealth("target")
			local mubiaoHmax = UnitHealthMax("target")
			local mubiaobaifenbi = math.ceil((mubiaoH/mubiaoHmax)*100);--目标血量百分比
			if mubiaoHmax>0 then
				TargetFrame.mubiaoHP.title:SetText(mubiaobaifenbi..'%');
			else
				TargetFrame.mubiaoHP.title:SetText('??%');
			end
		end
	end)
end
---------------------------------------------------
fuFrame.MubiaoLINE = fuFrame:CreateLine()
fuFrame.MubiaoLINE:SetColorTexture(1,1,1,0.2)
fuFrame.MubiaoLINE:SetThickness(1);
fuFrame.MubiaoLINE:SetStartPoint("TOPLEFT",2,-150)
fuFrame.MubiaoLINE:SetEndPoint("TOPRIGHT",-2,-150)
---
local Mubiaotooltip = "增强目标头像，显示血量/血量百分比/仇恨值/仇恨高亮/目标职业/生物种类！\r|cff00FFFF小提示：|r\r目标职业图标可以点击，左击观察/右击交易"
fuFrame.Mubiao=ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame.MubiaoLINE,"TOPLEFT",20,-20,"目标头像增强",Mubiaotooltip)
fuFrame.Mubiao:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.UnitFrame.TargetFrame.Plus=true;
		MubiaoFrame_Open();
	else
		PIG.UnitFrame.TargetFrame.Plus=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
-----目标的目标的目标
local function ADD_TOTOT_Open()	
	if UFP_Target_Target_Target then return end
	local fuF=TargetFrameToT

	fuF.TTT = CreateFrame("Button", "UFP_Target_Target_Target", fuF, "SecureUnitButtonTemplate")
	fuF.TTT:SetSize(96,50);
	fuF.TTT:SetPoint("TOPLEFT", fuF, "BOTTOMLEFT", 40, 0);
	fuF.TTT:RegisterForClicks("AnyUp")
	fuF.TTT:RegisterForDrag("LeftButton")
	fuF.TTT:SetAttribute("*type1", "target")
	fuF.TTT:SetAttribute("unit", "targettargettarget")
	if InCombatLockdown() then
		fuF.TTT:RegisterEvent("PLAYER_REGEN_ENABLED");
	else
		--fuF:SetPoint("BOTTOMRIGHT", TargetFrame, "BOTTOMRIGHT", 6, -20);
		RegisterUnitWatch(fuF.TTT)
	end

	fuF.TTT.HP = CreateFrame("StatusBar", nil, fuF.TTT);
	fuF.TTT.HP:SetStatusBarTexture("interface/targetingframe/ui-statusbar.blp")
	fuF.TTT.HP:SetStatusBarColor(0, 1, 0 ,1);
	fuF.TTT.HP:SetSize(45,7);
	fuF.TTT.HP:SetPoint("TOPLEFT",fuF.TTT,"TOPLEFT",46,-15);
	fuF.TTT.HP:SetMinMaxValues(1, 100) 
	fuF.TTT.HP:SetValue(100);

	fuF.TTT.MP = CreateFrame("StatusBar", nil, fuF.TTT);
	fuF.TTT.MP:SetStatusBarTexture("interface/targetingframe/ui-statusbar.blp")
	fuF.TTT.MP:SetStatusBarColor(0, 0, 1 ,1);
	fuF.TTT.MP:SetSize(45,7);
	fuF.TTT.MP:SetPoint("TOPLEFT",fuF.TTT,"TOPLEFT",46,-23);
	fuF.TTT.MP:SetMinMaxValues(0, 100) 
	fuF.TTT.MP:SetValue(100);

	fuF.TTT.touxiang = fuF.TTT:CreateTexture(nil, "BORDER");
	fuF.TTT.touxiang:SetSize(40,40);
	fuF.TTT.touxiang:SetPoint("TOPLEFT",fuF.TTT,"TOPLEFT",4,-2);

	fuF.TTT.border = CreateFrame("Frame", nil, fuF.TTT);
	fuF.TTT.border:SetAllPoints(fuF.TTT)
	fuF.TTT.border:SetFrameLevel(510)
	fuF.TTT.border.TEX = fuF.TTT.border:CreateTexture(nil, "ARTWORK");
	fuF.TTT.border.TEX:SetTexture("interface/targetingframe/ui-targetoftargetframe.blp");
	fuF.TTT.border.TEX:SetPoint("TOPLEFT",fuF.TTT,"TOPLEFT",0,0);
	fuF.TTT.border.title = fuF.TTT.border:CreateFontString();
	fuF.TTT.border.title:SetPoint("TOPLEFT", fuF.TTT.border, "TOPLEFT", 42, -32);
	fuF.TTT.border.title:SetFontObject(GameFontNormal);

	local function gengxinjindu_HP()
		local mubiaoH = UnitHealth("targettargettarget")
		local mubiaoHmax = UnitHealthMax("targettargettarget")
		fuF.TTT.HP:SetMinMaxValues(0, mubiaoHmax) 
		fuF.TTT.HP:SetValue(mubiaoH);
	end
	local function gengxinjindu_MP()
		local MP = UnitPower("targettargettarget");	
		local MPmax = UnitPowerMax("targettargettarget");
		fuF.TTT.MP:SetMinMaxValues(0, MPmax) 
		fuF.TTT.MP:SetValue(MP);
		local powerType = UnitPowerType("targettargettarget")
		local info = PowerBarColor[powerType]
		fuF.TTT.MP:SetStatusBarColor(info.r, info.g, info.b ,1)
	end
	fuF.TTT:RegisterUnitEvent("UNIT_TARGET","target");
	fuF.TTT:RegisterUnitEvent("UNIT_TARGET","targettarget");
	fuF.TTT:RegisterUnitEvent("UNIT_TARGET","targettargettarget");
	fuF.TTT:RegisterUnitEvent("UNIT_PORTRAIT_UPDATE","targettargettarget");
	fuF.TTT:HookScript("OnEvent", function (self,event,arg1)
		SetPortraitTexture(fuF.TTT.touxiang, "targettargettarget")
		local TTTname = UnitName("targettargettarget")
		fuF.TTT.border.title:SetText(TTTname);
		gengxinjindu_HP()
		gengxinjindu_MP()
		if event=="PLAYER_REGEN_ENABLED" then
			self:UnregisterEvent("PLAYER_REGEN_ENABLED");
		end
	end)

	fuF.TTT.HP:RegisterUnitEvent("UNIT_HEALTH","targettargettarget");
	fuF.TTT.HP:RegisterUnitEvent("UNIT_MAXHEALTH","targettargettarget");
	fuF.TTT.HP:HookScript("OnEvent", function (self,event)
		gengxinjindu_HP()
	end)

	fuF.TTT.MP:RegisterUnitEvent("UNIT_POWER_FREQUENT","targettargettarget");
	fuF.TTT.MP:RegisterUnitEvent("UNIT_MAXPOWER","targettargettarget");
	fuF.TTT.MP:HookScript("OnEvent", function (self,event)
		gengxinjindu_MP()
	end)
end
------------
fuFrame.TOTOT=ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame.MubiaoLINE,"TOPLEFT",300,-20,"显示目标的目标的目标","显示目标的目标的目标（注意：请先打开系统的目标的目标）")
fuFrame.TOTOT:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.UnitFrame.TargetFrame.ToToToT=true;
		ADD_TOTOT_Open();
	else
		PIG.UnitFrame.TargetFrame.ToToToT=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
--------
local function ADD_yisu_Open()
	TargetFrame.yisuF=CreateFrame("Frame",nil,TargetFrame);
	TargetFrame.yisuF:SetSize(49,18);
	if tocversion>90000 then
		TargetFrame.yisuF:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 206, -38);
		TargetFrame.yisuF:SetFrameLevel(505)
	else
		TargetFrame.yisuF:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 192, -58);
	end
	TargetFrame.yisuF.Tex = TargetFrame.yisuF:CreateTexture("Frame_Texture_UI", "ARTWORK");
	TargetFrame.yisuF.Tex:SetTexture("interface/icons/ability_rogue_sprint.blp");
	TargetFrame.yisuF.Tex:SetSize(16,16);
	TargetFrame.yisuF.Tex:SetPoint("LEFT", TargetFrame.yisuF, "LEFT", 0, 0);
	TargetFrame.yisuT = TargetFrame.yisuF:CreateFontString();
	TargetFrame.yisuT:SetPoint("LEFT", TargetFrame.yisuF.Tex, "RIGHT", 0, 0);
	TargetFrame.yisuT:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
	TargetFrame.yisuF:HookScript("OnUpdate", function ()
		local currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed("target");
		TargetFrame.yisuT:SetText(Round(((currentSpeed/7)*100))..'%')
	end)
end
fuFrame.yisu=ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame.MubiaoLINE,"TOPLEFT",20,-80,"显示目标移动速度","显示目标移动速度")
fuFrame.yisu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.UnitFrame.TargetFrame.Yisu=true;
		ADD_yisu_Open();
	else
		PIG.UnitFrame.TargetFrame.Yisu=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
---
fuFrame:HookScript("OnShow", function (self)
	if PIG.UnitFrame.TargetFrame.Plus then
		fuFrame.Mubiao:SetChecked(true);
	end
	if PIG.UnitFrame.TargetFrame.ToToToT then
		fuFrame.TOTOT:SetChecked(true); 
	end
	if PIG.UnitFrame.TargetFrame.Yisu then
		fuFrame.yisu:SetChecked(true); 
	end
end);
--=====================================
addonTable.UnitFrame_TargetFrame = function()
	if PIG.UnitFrame.TargetFrame.Plus then
		MubiaoFrame_Open();
	end
	if PIG.UnitFrame.TargetFrame.ToToToT then
		ADD_TOTOT_Open();
	end
	if PIG.UnitFrame.TargetFrame.Yisu then
		ADD_yisu_Open();
	end
end
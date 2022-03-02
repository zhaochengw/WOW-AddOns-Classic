local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_4_UI
local _, _, _, tocversion = GetBuildInfo()
---------------------------------
local function MubiaoFrame_Open()
	if tocversion>=30000 then

	elseif tocversion>=20000 then
		TargetHealthDB = TargetHealthDB or { version=1, forcePercentages=false }
		TargetHealthDB.forcePercentages = true
		local function HealthBar_Update(statusbar, unit)
		    if ( not statusbar or statusbar.lockValues ) then
		        return;
		    end
		    if ( unit == statusbar.unit ) then
		        local maxValue = UnitHealthMax(unit);
		        statusbar.showPercentage = false;
		        statusbar.forceHideText = false;
		        if ( maxValue == 0 ) then
		            maxValue = 1;
		            statusbar.forceHideText = true;
		        elseif ( maxValue == 100 and not ShouldKnowUnitHealth(unit) ) then
		            if TargetHealthDB.forcePercentages then
		                statusbar.showPercentage = true;
		            end
		        end
		    end
		    TextStatusBar_UpdateTextString(statusbar);
		end
		hooksecurefunc("UnitFrameHealthBar_Update", HealthBar_Update)
	elseif tocversion<20000 then
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
	end
	if UFP_Targetzhiyetubiao==nil then
		----目标职业图标
		TargetFrame.zhiyetubiao = CreateFrame("Button", "UFP_Targetzhiyetubiao", TargetFrame);
		TargetFrame.zhiyetubiao:SetSize(32,32);
		TargetFrame.zhiyetubiao:ClearAllPoints();
		TargetFrame.zhiyetubiao:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 119, 3);
		TargetFrame.zhiyetubiao:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");
		TargetFrame.zhiyetubiao:Hide()

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
		TargetFrame.zhiyetubiao:SetScript("OnClick", function (self, event, button)
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
		TargetFrame.mubiaoLX:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 52, -3);
		TargetFrame.mubiaoLX.title = TargetFrame.mubiaoLX:CreateFontString();
		TargetFrame.mubiaoLX.title:SetPoint("RIGHT", TargetFrame.mubiaoLX, "RIGHT", 0, 0);
		TargetFrame.mubiaoLX.title:SetFont(GameFontNormal:GetFont(), 14.4, "OUTLINE");
		TargetFrame.mubiaoLX.title:SetTextColor(0,1,1,1);
		--目标仇恨
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
		--仇恨高亮
		TargetFrame.mubiaoCHbaifenbi_REDALL=TargetFrame:CreateTexture(nil,"BACKGROUND");
		TargetFrame.mubiaoCHbaifenbi_REDALL:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
		TargetFrame.mubiaoCHbaifenbi_REDALL:SetTexCoord(0.004,0.954,0,0.76);
		TargetFrame.mubiaoCHbaifenbi_REDALL:SetSize(242,97);
		TargetFrame.mubiaoCHbaifenbi_REDALL:ClearAllPoints();
		TargetFrame.mubiaoCHbaifenbi_REDALL:SetPoint("TOPLEFT",TargetFrame,"TOPLEFT",-22,0);
		TargetFrame.mubiaoCHbaifenbi_REDALL:SetVertexColor(1,0,0);
		TargetFrame.mubiaoCHbaifenbi_REDALL:Hide();
		---
		local YuanshiW=TargetFrameNameBackground:GetWidth();
		TargetFrameNameBackground:ClearAllPoints();
		TargetFrameNameBackground:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 7, -22);
		----
		local function shuaxinchouhezhi()
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
					--PlaySoundFile("sound\\interface\\ui_garrison_mission_threat_countered.ogg", "Master")
				elseif status==3 then
					TargetFrame.mubiaoCHbaifenbi_REDALL:Show();
					TargetFrameNameBackground:SetVertexColor(1, 0, 0);
					TargetFrame.mubiaoCHbaifenbi:Show();
					TargetFrame.mubiaoCHbaifenbi.Background:SetVertexColor(1, 0, 0);
					--PlaySoundFile("sound/item/weapons/mace1h/1hmacehitstonecrit.ogg", "Master")
					--PlaySoundFile("sound/interface/ui_garrison_mission_threat_countered.ogg")
					--sound/spells/cower.ogg			
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
		--TargetFrame.mubiaoCHbaifenbi:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE","target");
		TargetFrame.mubiaoCHbaifenbi:RegisterUnitEvent("UNIT_THREAT_LIST_UPDATE","target");--怪物仇恨列表目录改变
		TargetFrame.mubiaoCHbaifenbi:HookScript("OnEvent", function (self,event,arg1)
			shuaxinchouhezhi()
		end)
		--目标生命百分比
		TargetFrame.mubiaoHP=CreateFrame("Frame",nil,TargetFrame);
		TargetFrame.mubiaoHP:SetPoint("RIGHT",TargetFrame,"LEFT",5,-2);
		TargetFrame.mubiaoHP:SetSize(49,22);
		TargetFrame.mubiaoHP.title = TargetFrame.mubiaoHP:CreateFontString();
		TargetFrame.mubiaoHP.title:SetPoint("TOPRIGHT", TargetFrame.mubiaoHP, "TOPRIGHT", 0, 0);
		TargetFrame.mubiaoHP.title:SetFont(GameFontNormal:GetFont(), 13, "OUTLINE");
		TargetFrame.mubiaoHP.title:SetTextColor(1, 1, 0.47,1);
		----------------------
		local function mubiaoxueliang()
			local mubiaoH = UnitHealth("target")
			local mubiaoHmax = UnitHealthMax("target")
			local mubiaobaifenbi = math.ceil((mubiaoH/mubiaoHmax)*100);--目标血量百分比
			if mubiaoHmax>0 then
				TargetFrame.mubiaoHP.title:SetText(mubiaobaifenbi..'%');
			else
				TargetFrame.mubiaoHP.title:SetText('??%');
			end
		end
		TargetFrame.mubiaoHP:RegisterUnitEvent("UNIT_HEALTH","target");
		TargetFrame.mubiaoHP:RegisterUnitEvent("UNIT_MAXHEALTH","target");
		TargetFrame.mubiaoHP:RegisterUnitEvent("UNIT_HEALTH_FREQUENT","target");
		TargetFrame.mubiaoHP:HookScript("OnEvent", function (self,event,arg1)
			mubiaoxueliang()
		end)
		-----------------------
		local mubiaoshijianzhixingFFF=CreateFrame("Frame");
		mubiaoshijianzhixingFFF:RegisterEvent("PLAYER_TARGET_CHANGED");--转换目标时触发
		--mubiaoshijianzhixingFFF:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE");--玩家仇恨排名改变
		mubiaoshijianzhixingFFF:SetScript("OnEvent", function (self,event)
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
				--切换精英仇恨高亮边框
				local classification = UnitClassification("target");--怪物类型
				if classification=="worldboss" or classification=="rareelite" or classification=="elite" or classification=="rare" then
					TargetFrame.mubiaoCHbaifenbi_REDALL:SetTexture("interface/targetingframe/ui-focusframe-large-flash.blp")
					TargetFrame.mubiaoCHbaifenbi_REDALL:SetTexCoord(0.02,0.88,0.02,0.73);--精英
				else
					TargetFrame.mubiaoCHbaifenbi_REDALL:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
					TargetFrame.mubiaoCHbaifenbi_REDALL:SetTexCoord(0.004,0.954,0,0.76);
				end
				shuaxinchouhezhi()--仇恨
				mubiaoxueliang()
			end
		end);
	end
end
---------------------------------------------------
fuFrame.Mubiao = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Mubiao:SetSize(30,32);
fuFrame.Mubiao:SetHitRectInsets(0,-100,0,0);
fuFrame.Mubiao:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-200);
fuFrame.Mubiao.Text:SetText("目标头像增强");
fuFrame.Mubiao.tooltip = "增强目标头像，显示血量/血量百分比/仇恨，目标职业/生物种类，仇恨高亮等！\r|cff00FFFF小提示：|r\r目标职业图标可以点击，左击观察/右击交易。";
fuFrame.Mubiao:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['TouxiangFrame_Mubiao']="ON";
		MubiaoFrame_Open();
	else
		PIG['FramePlus']['TouxiangFrame_Mubiao']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
---------------------
local function ADD_TOTOT_Open()
	--目标的目标的目标
	if UFP_Target_Target_Target==nil then
		local fuF=TargetFrameToT
		fuF:ClearAllPoints();
		fuF:SetPoint("TOPLEFT", TargetFrame, "BOTTOMLEFT", 130, 26);

		fuF.TTT = CreateFrame("Button", "UFP_Target_Target_Target", fuF, "SecureUnitButtonTemplate")
		fuF.TTT:SetSize(96,50);
		fuF.TTT:SetPoint("TOPLEFT", fuF, "BOTTOMLEFT", 40, 0);
		fuF.TTT:RegisterForClicks("AnyUp")
		fuF.TTT:RegisterForDrag("LeftButton")
		fuF.TTT:SetAttribute("*type1", "target")
		fuF.TTT:SetAttribute("unit", "targettargettarget")
		RegisterUnitWatch(fuF.TTT)

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
		fuF.TTT.border:SetFrameLevel(6)
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
		end

		fuF.TTT:RegisterUnitEvent("UNIT_TARGET","target");
		fuF.TTT:RegisterUnitEvent("UNIT_TARGET","targettarget");
		fuF.TTT:RegisterUnitEvent("UNIT_TARGET","UNIT_PORTRAIT_UPDATE");
		fuF.TTT:SetScript("OnEvent", function (self,event,arg1)
			SetPortraitTexture(fuF.TTT.touxiang, "targettargettarget")
			local TTTname = UnitName("targettargettarget")
			fuF.TTT.border.title:SetText(TTTname);
			gengxinjindu_HP()
			gengxinjindu_MP()
		end)

		fuF.TTT.HP:RegisterUnitEvent("UNIT_HEALTH","targettargettarget");
		fuF.TTT.HP:RegisterUnitEvent("UNIT_MAXHEALTH","targettargettarget");
		fuF.TTT.HP:SetScript("OnEvent", function (self,event)
			gengxinjindu_HP()
		end)

		fuF.TTT.MP:RegisterUnitEvent("UNIT_POWER_FREQUENT","targettargettarget");
		fuF.TTT.MP:RegisterUnitEvent("UNIT_MAXPOWER","targettargettarget");
		fuF.TTT.MP:SetScript("OnEvent", function (self,event)
			gengxinjindu_MP()
		end)
	end
end
------------
fuFrame.TOTOT = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.TOTOT:SetSize(30,32);
fuFrame.TOTOT:SetHitRectInsets(0,-100,0,0);
fuFrame.TOTOT:SetPoint("TOPLEFT",fuFrame.Mubiao,"BOTTOMLEFT",30,-1);
fuFrame.TOTOT.Text:SetText("显示目标的目标的目标");
fuFrame.TOTOT.tooltip = "显示目标的目标的目标";
fuFrame.TOTOT:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['ToToToT']="ON";
		ADD_TOTOT_Open();
	else
		PIG['FramePlus']['ToToToT']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--------
local function ADD_yisu_Open()
	TargetFrame.yisuF=CreateFrame("Frame",nil,TargetFrame);
	TargetFrame.yisuF:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 192, -58);
	TargetFrame.yisuF:SetSize(49,18);
	TargetFrame.yisuF.Tex = TargetFrame.yisuF:CreateTexture("Frame_Texture_UI", "ARTWORK");
	TargetFrame.yisuF.Tex:SetTexture("interface/icons/ability_rogue_sprint.blp");
	TargetFrame.yisuF.Tex:SetSize(16,16);
	TargetFrame.yisuF.Tex:SetPoint("LEFT", TargetFrame.yisuF, "LEFT", 0, 0);
	TargetFrame.yisuT = TargetFrame.yisuF:CreateFontString();
	TargetFrame.yisuT:SetPoint("LEFT", TargetFrame.yisuF.Tex, "RIGHT", 0, 0);
	TargetFrame.yisuT:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
	TargetFrame.yisuF:SetScript("OnUpdate", function ()
		local currentSpeed, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed("target");
		TargetFrame.yisuT:SetText(Round(((currentSpeed/7)*100))..'%')
	end)
end
fuFrame.yisu = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.yisu:SetSize(30,32);
fuFrame.yisu:SetHitRectInsets(0,-100,0,0);
fuFrame.yisu:SetPoint("TOPLEFT",fuFrame.TOTOT,"BOTTOMLEFT",50,-1);
fuFrame.yisu.Text:SetText("显示目标移动速度");
fuFrame.yisu.tooltip = "显示目标移动速度";
fuFrame.yisu:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['yisu']="ON";
		ADD_yisu_Open();
	else
		PIG['FramePlus']['yisu']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);

--==============================================================================
local biaojiW=20;
local biaojiH=20;
local beijing = {bgFile = "Interface\\Tooltips\\UI-Tooltip-Background"}
local beijing_yidong = {
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 0, edgeSize = 6,insets = { left = 0, right = 0, top = 0, bottom = 0 }
}
local biaoji_icon = "interface\\targetingframe\\ui-raidtargetingicons"
local biaoji_iconID = {
	{0.75,1,0.25,0.5},{0.5,0.75,0.25,0.5},{0.25,0.5,0.25,0.5},
	{0,0.25,0.25,0.5},{0.75,1,0,0.25},{0.5,0.75,0,0.25},
	{0.25,0.5,0,0.25},{0,0.25,0,0.25}
}
----目标快速标记目标--------
local function Mubiaokuaisubiaoji_Open()
	if mubiaobiaoji_UI==nil then
		TargetFrame.mubiaobiaoji = CreateFrame("Frame", "mubiaobiaoji_UI", TargetFrame,"BackdropTemplate")
		TargetFrame.mubiaobiaoji:SetBackdrop(beijing)
		TargetFrame.mubiaobiaoji:SetBackdropColor(0.1,0.1,0.1,0.5)
		TargetFrame.mubiaobiaoji:SetSize((biaojiW+3)*8+3,biaojiH+2)
		TargetFrame.mubiaobiaoji:SetPoint("TOPLEFT", TargetFrame, "TOPRIGHT", -20, -10);
		TargetFrame.mubiaobiaoji:SetMovable(true)
		TargetFrame.mubiaobiaoji:SetClampedToScreen(true)
		TargetFrame.mubiaobiaoji.yidong = CreateFrame("Frame", nil, TargetFrame.mubiaobiaoji,"BackdropTemplate")
		TargetFrame.mubiaobiaoji.yidong:SetBackdrop(beijing_yidong)
		TargetFrame.mubiaobiaoji.yidong:SetBackdropColor(0.1,0.1,0.1,0.5)
		TargetFrame.mubiaobiaoji.yidong:SetSize(8,biaojiH+2)
		TargetFrame.mubiaobiaoji.yidong:SetPoint("RIGHT", TargetFrame.mubiaobiaoji, "LEFT", 0, 0);
		TargetFrame.mubiaobiaoji.yidong:EnableMouse(true)
		TargetFrame.mubiaobiaoji.yidong:RegisterForDrag("LeftButton")
		TargetFrame.mubiaobiaoji.yidong:SetScript("OnDragStart",function()
			TargetFrame.mubiaobiaoji:StartMoving()
		end)
		TargetFrame.mubiaobiaoji.yidong:SetScript("OnDragStop",function()
			TargetFrame.mubiaobiaoji:StopMovingOrSizing()
		end)
		for i=1,#biaoji_iconID do
			TargetFrame.mubiaobiaoji.list = CreateFrame("Button", "TargetFrame.mubiaobiaoji_list"..i, TargetFrame.mubiaobiaoji)
			TargetFrame.mubiaobiaoji.list:SetSize(biaojiW,biaojiH)
			if i==1 then
				TargetFrame.mubiaobiaoji.list:SetPoint("LEFT", TargetFrame.mubiaobiaoji, "LEFT",3,0)
			else
				TargetFrame.mubiaobiaoji.list:SetPoint("LEFT", _G["TargetFrame.mubiaobiaoji_list"..(i-1)], "RIGHT",3,0)
			end
			TargetFrame.mubiaobiaoji.list:SetNormalTexture(biaoji_icon)
			TargetFrame.mubiaobiaoji.list:GetNormalTexture():SetTexCoord(biaoji_iconID[i][1],biaoji_iconID[i][2],biaoji_iconID[i][3],biaoji_iconID[i][4])
			TargetFrame.mubiaobiaoji.list:EnableMouse(true)
			TargetFrame.mubiaobiaoji.list:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 9-i) end)
		end
	end
end
----------------------------
fuFrame.Biaoji = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Biaoji:SetSize(30,32);
fuFrame.Biaoji:SetHitRectInsets(0,-100,0,0);
fuFrame.Biaoji:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-200);
fuFrame.Biaoji.Text:SetText("目标快速标记");
fuFrame.Biaoji.tooltip = "在目标头像右侧显示快速标记按钮！";

fuFrame.BiaojiYD = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.BiaojiYD:SetSize(30,32);
fuFrame.BiaojiYD:SetHitRectInsets(0,-80,0,0);
fuFrame.BiaojiYD:SetPoint("TOPLEFT",fuFrame.Biaoji,"BOTTOMLEFT",30,-1);
fuFrame.BiaojiYD.Text:SetText("锁定位置");
fuFrame.BiaojiYD.tooltip = "锁定快速标记按钮位置，使其无法移动！";

fuFrame.AUTOSHOW= CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.AUTOSHOW:SetSize(30,32);
fuFrame.AUTOSHOW:SetHitRectInsets(0,-100,0,0);
fuFrame.AUTOSHOW:SetPoint("TOPLEFT",fuFrame.BiaojiYD,"BOTTOMLEFT",30,-1);
fuFrame.AUTOSHOW.Text:SetText("智能显示/隐藏");
fuFrame.AUTOSHOW.tooltip = "当你没有标记权限时隐藏快捷标记按钮";
fuFrame.BiaojiYD:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['TouxiangFrame_Mubiao_Biaoji_YD']="ON";
		TargetFrame.mubiaobiaoji.yidong:Hide()
	else
		PIG['FramePlus']['TouxiangFrame_Mubiao_Biaoji_YD']="OFF";
		TargetFrame.mubiaobiaoji.yidong:Show()
	end
end);
fuFrame.Biaoji:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['TouxiangFrame_Mubiao_Biaoji']="ON";
		fuFrame.BiaojiYD:Enable();
		fuFrame.AUTOSHOW:Enable();
		Mubiaokuaisubiaoji_Open();
	else
		PIG['FramePlus']['TouxiangFrame_Mubiao_Biaoji']="OFF";
		fuFrame.BiaojiYD:Disable();
		fuFrame.AUTOSHOW:Disable();
		Pig_Options_RLtishi_UI:Show()
	end
end);
local TargetFrame_mubiaobiaojidongtaiShow = CreateFrame("Frame");
TargetFrame_mubiaobiaojidongtaiShow:SetScript("OnEvent", function(self,event)
	if CanBeRaidTarget("target") then
		if IsInRaid("LE_PARTY_CATEGORY_HOME") then
			local isLeader = UnitIsGroupLeader("player", "LE_PARTY_CATEGORY_HOME");
			if isLeader or UnitIsGroupAssistant("player") then
				TargetFrame.mubiaobiaoji:Show()
			else
				TargetFrame.mubiaobiaoji:Hide()
			end
		else
			TargetFrame.mubiaobiaoji:Show()
		end
	end
end);
fuFrame.AUTOSHOW:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['TouxiangFrame_Mubiao_Biaoji_AUSW']="ON";
		TargetFrame_mubiaobiaojidongtaiShow:RegisterEvent("PLAYER_TARGET_CHANGED");
	else
		PIG['FramePlus']['TouxiangFrame_Mubiao_Biaoji_AUSW']="OFF";
		TargetFrame_mubiaobiaojidongtaiShow:UnregisterEvent("PLAYER_TARGET_CHANGED");
	end
end);

--=====================================
addonTable.UnitFrame_TargetFrame = function()
	if PIG['FramePlus']['TouxiangFrame_Mubiao']=="ON" then
		fuFrame.Mubiao:SetChecked(true);
		MubiaoFrame_Open();
	end
	if PIG['FramePlus']['TouxiangFrame_Mubiao_youyi']=="ON" then
		fuFrame.Mubiao_youyi:SetChecked(true);
	end
	if PIG['FramePlus']['TouxiangFrame_Mubiao_Biaoji']=="ON" then
		fuFrame.Biaoji:SetChecked(true);
		Mubiaokuaisubiaoji_Open();
		if PIG['FramePlus']['TouxiangFrame_Mubiao_Biaoji_YD']=="ON" then
			TargetFrame.mubiaobiaoji.yidong:Hide()
		end
		if PIG['FramePlus']['TouxiangFrame_Mubiao_Biaoji_AUSW']=="ON" then
			TargetFrame_mubiaobiaojidongtaiShow:RegisterEvent("PLAYER_TARGET_CHANGED");
		end
	else
		fuFrame.BiaojiYD:Disable();
		fuFrame.AUTOSHOW:Disable();
	end
	if PIG['FramePlus']['TouxiangFrame_Mubiao_Biaoji_YD']=="ON" then
		fuFrame.BiaojiYD:SetChecked(true);
	end
	if PIG['FramePlus']['TouxiangFrame_Mubiao_Biaoji_AUSW']=="ON" then
		fuFrame.AUTOSHOW:SetChecked(true); 
	end
	PIG['FramePlus']['ToToToT']=PIG['FramePlus']['ToToToT'] or addonTable.Default['FramePlus']['ToToToT'];
	if PIG['FramePlus']['ToToToT']=="ON" then
		fuFrame.TOTOT:SetChecked(true); 
		ADD_TOTOT_Open();
	end
	PIG['FramePlus']['yisu']=PIG['FramePlus']['yisu'] or addonTable.Default['FramePlus']['yisu'];
	if PIG['FramePlus']['yisu']=="ON" then
		fuFrame.yisu:SetChecked(true); 
		ADD_yisu_Open();
	end
end
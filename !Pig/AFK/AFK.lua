local _, addonTable = ...;
--------
local fuFrame=List_R_F_2_12
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local ADD_QuickButton=addonTable.ADD_QuickButton
--=======================================
local GnUI = "AFK_UI"
local function Pig_AFK()
	SetCVar("cameraYawMoveSpeed",180)
	PIG["AKF"]=PIG["AKF"] or addonTable.Default["AKF"]
	if PIG["AKF"]["Open"] then
		if AFKUI_UI then return end
		local WowWidth=GetScreenWidth();
		local WowHeight=GetScreenHeight();
		local AFKUI = CreateFrame("Frame","AFKUI_UI", WorldFrame,"BackdropTemplate");
		AFKUI:SetBackdrop({
			bgFile = "interface/characterframe/ui-party-background.blp",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 8,});
		AFKUI:SetBackdropColor(0, 0, 0, 0.5);
		AFKUI:SetBackdropBorderColor(0, 0, 0, 0.8);
		AFKUI:SetSize(WowWidth,100);
		AFKUI:SetPoint("BOTTOM",WorldFrame,"BOTTOM",0,0);
		AFKUI:Hide()
		AFKUI.info = AFKUI:CreateFontString();
		AFKUI.info:SetPoint("CENTER", AFKUI, "CENTER", 0, 0);
		AFKUI.info:SetFont(GameFontNormal:GetFont(), 28,"OUTLINE")
		AFKUI.info:SetTextColor(1, 1, 0, 1);
		local raceName, raceFile, raceID = UnitRace("player")
		local name, realm = UnitName("player")
		local zijirealm = GetRealmName()
		AFKUI.info:SetText("|cff00FFFF服务器:|r"..zijirealm.."   |cff00FFFF种族:|r"..raceName.."   |cff00FFFF玩家名:|r"..name);
		AFKUI.zhenying = AFKUI:CreateTexture()
		AFKUI.zhenying:SetTexture(131148);
		AFKUI.zhenying:SetSize(50,50);
		AFKUI.zhenying:SetPoint("RIGHT", AFKUI.info,"LEFT",-10, 0);
		local englishFaction, _ = UnitFactionGroup("player")
		if englishFaction=="Alliance" then
			AFKUI.zhenying:SetTexCoord(0,0.5,0,1);
		elseif englishFaction=="Horde" then
			AFKUI.zhenying:SetTexCoord(0.5,1,0,1);
		end
		----
		local WowWidth=800;
		local WowHeight=500;
		AFKUI.moxingjuli = -0.4
		AFKUI.downV = -0.5
		if raceID==7 then
			AFKUI.moxingjuli=-0.8
			AFKUI.downV = -0.3
		end
		AFKUI.ModelUI = CreateFrame("PlayerModel", "ModelUI_UI", AFKUI);
		AFKUI.ModelUI:SetSize(WowWidth,WowHeight);
		AFKUI.ModelUI:SetPoint("BOTTOMRIGHT",AFKUI,"TOPRIGHT",0,0);
		AFKUI.ModelUI:SetUnit("player")
		AFKUI.ModelUI:SetCamera(1)
		--AFKUI.ModelUI:SetScale(0.8);
		--AFKUI.ModelUI:ClearModel();--清空模型
		AFKUI.ModelUI:SetPortraitZoom(AFKUI.moxingjuli);--模型视角远近
		--AFKUI.ModelUI:SetPosition(0,0,0.9);--相对于左下角定位模型Z,X,Y
		--AFKUI.ModelUI:SetFacing(3.1415926)--模型角度
		--AFKUI.ModelUI:SetAnimation(69);
		--AFKUI.ModelUI:SetSequence(69);
		
		AFKUI.ModelUI:SetScript("OnAnimStarted", function(self)
			local hasAnimation = self:HasAnimation(69);--检查模型是否支持与给定动画
			if hasAnimation then
				AFKUI.ModelUI:SetAnimation(69);
			end
		end);
		AFKUI.ModelUI:SetScript("OnAnimFinished", function(self) 
			self:SetAnimation(69); 
		end);

		AFKUI.title = AFKUI:CreateFontString();
		AFKUI.title:SetPoint("TOP", WorldFrame, "TOP", 0, -100);
		AFKUI.title:SetFont(GameFontNormal:GetFont(), 50,"OUTLINE")
		AFKUI.title:SetTextColor(1, 1, 0, 1);
		AFKUI.title:SetText("临时离开，勿动!!!");

		UIParent:HookScript("OnShow", function(self)
			SetCVar("cameraYawMoveSpeed",180)
			AFKUI:Hide()
			MoveViewLeftStop()
		end)
		
		AFKUI.pxulie=1
		local function weizhibiandong()
			if AFKUI:IsShown() then
				if AFKUI.pxulie then
					if AFKUI.pxulie==1 then
						AFKUI.ModelUI:SetPosition(0,0,AFKUI.downV);	
						AFKUI.pxulie=2
					elseif AFKUI.pxulie==2 then
						AFKUI.ModelUI:SetPosition(0,-0.6,AFKUI.downV);
						AFKUI.pxulie=3
					elseif AFKUI.pxulie==3 then
						AFKUI.ModelUI:SetPosition(0,0.6,AFKUI.downV);
						AFKUI.pxulie=1
					end
				end
				C_Timer.After(10,weizhibiandong)
			end
		end
		local LIKAIMSG=string.format(MARKED_AFK_MESSAGE,DEFAULT_AFK_MESSAGE)
		AFKUI:RegisterEvent("CHAT_MSG_AFK");
		AFKUI:RegisterEvent("CHAT_MSG_SYSTEM");
		AFKUI:RegisterEvent("PLAYER_REGEN_DISABLED");
		AFKUI:SetScript("OnEvent", function(self,event,arg1)
			if event=="PLAYER_REGEN_DISABLED" then
				if not InCombatLockdown() then
					SetCVar("cameraYawMoveSpeed",180)--旋转速度
					AFKUI:Hide()
					UIParent:Show()
					MoveViewLeftStop()
				end
			end
			if not InCombatLockdown() then
				if arg1==LIKAIMSG then
					SetCVar("cameraYawMoveSpeed",6)
					UIParent:Hide()
					AFKUI:Show()
					MoveViewLeftStart()
					AFKUI.pxulie=1
					weizhibiandong()
				elseif arg1==CLEARED_AFK then
					SetCVar("cameraYawMoveSpeed",180)
					AFKUI:Hide()
					UIParent:Show()
					MoveViewLeftStop()
				end
			end
		end)
	end
end
addonTable.Pig_AFK = Pig_AFK
----
local function ADD_QuickButton_AFK()	
	if PIG["AKF"]["QuickButton"] then
		fuFrame.QuickButton_AFK:SetChecked(true);
	end
	if PIG["QuickButton"]["Open"] and PIG["AKF"]['Open'] then
		fuFrame.QuickButton_AFK:Enable()
	else
		fuFrame.QuickButton_AFK:Disable()
	end
	if PIG["QuickButton"]["Open"] and PIG["AKF"]['Open'] and PIG["AKF"]["QuickButton"] then
		local GnUI = "AFK_UI"
		if _G[GnUI] then return end
		local Icon=132802
		local Tooltip = "执行离开屏保"
		local AKF_pingbao=ADD_QuickButton(GnUI,Tooltip,Icon, "SecureActionButtonTemplate")
		AKF_pingbao:SetAttribute("type", "macro")
		AKF_pingbao:HookScript("PreClick",  function (self)
			if InCombatLockdown() then
				PIG_print("副本内或战斗中无法暂离")
			else
				local inInstance, instanceType = IsInInstance()
				if inInstance then
					PIG_print("副本内或战斗中无法暂离")
				else
					AKF_pingbao:SetAttribute("macrotext", [=[/AFK]=])
				end
			end
		end);
		AKF_pingbao:HookScript("PostClick",  function (self)
			if not InCombatLockdown() then
				AKF_pingbao:SetAttribute("macrotext", [=[/PIG_print("副本内或战斗中无法暂离")]=])
			end
		end);
	end
end
addonTable.ADD_QuickButton_AFK = ADD_QuickButton_AFK
---
fuFrame.AFK=ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"启用离开屏保","启用离开屏保后,离开自动进入屏保功能")
fuFrame.AFK:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["AKF"]["Open"]=true;
		Pig_AFK()
	else
		PIG["AKF"]["Open"]=false;
		Pig_Options_RLtishi_UI:Show()
	end
	ADD_QuickButton_AFK()
end);

fuFrame.QuickButton_AFK=ADD_Checkbutton(nil,fuFrame,-60,"TOPLEFT",fuFrame,"TOPLEFT",300,-20,"添加<离开屏保>到快捷按钮栏","在快捷按钮栏显示离开屏保按钮,并开启离开自动进入屏保功能")
fuFrame.QuickButton_AFK:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["AKF"]["QuickButton"]=true;
		ADD_QuickButton_AFK()
	else
		PIG["AKF"]["QuickButton"]=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);

---------
fuFrame:HookScript("OnShow", function(self)
	if PIG["AKF"]["Open"] then
		self.AFK:SetChecked(true);
		Pig_AFK()
	end
end)
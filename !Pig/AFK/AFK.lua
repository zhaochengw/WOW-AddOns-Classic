local _, addonTable = ...;
--------
local fuFrame=List_R_F_2_12
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local ADD_QuickButton=addonTable.ADD_QuickButton
--=======================================
local GnUI = "AFK_UI"
local function Pig_AFK()
	PIG["AKF"]=PIG["AKF"] or addonTable.Default["AKF"]
	if PIG["AKF"]["Open"] then
		if ModelUI_UI then return end
		local WowWidth=GetScreenWidth();
		local WowHeight=GetScreenHeight();
		local ModelUI = CreateFrame("PlayerModel", "ModelUI_UI", WorldFrame);
		ModelUI:SetSize(WowWidth-200,WowHeight-200);
		ModelUI:SetPoint("CENTER",WorldFrame,"CENTER",0,-50);
		ModelUI:SetUnit("player")
		ModelUI:SetCamera(1)
		--ModelUI:SetScale(0.8);
		--ModelUI:ClearModel();--清空模型
		ModelUI:SetPortraitZoom(-0.6);--模型视角远近
		--ModelUI:SetPosition(0,0,0);--相对于左下角定位模型Z,X,Y
		--ModelUI:SetFacing(3.141596)--模型角度
		--ModelUI:SetAnimation(69);
		--ModelUI:SetSequence(69);
		ModelUI:Hide()
		ModelUI:SetScript("OnAnimStarted", function()
			local hasAnimation = ModelUI:HasAnimation(69);--检查模型是否支持与给定动画
			if hasAnimation then
				ModelUI:SetAnimation(69);
			end
		end);
		ModelUI:SetScript("OnAnimFinished", function(self) 
			self:SetAnimation(69); 
		end);

		ModelUI.title = ModelUI:CreateFontString();
		ModelUI.title:SetPoint("BOTTOM", ModelUI, "TOP", 0, 0);
		ModelUI.title:SetFont(GameFontNormal:GetFont(), 50,"OUTLINE")
		ModelUI.title:SetTextColor(1, 1, 0, 1);
		ModelUI.title:SetText("临时离开，勿动!!!");

		UIParent:HookScript("OnShow", function(self)
			SetCVar("cameraYawMoveSpeed",180)
			ModelUI:Hide()
			MoveViewLeftStop()
		end)
		
		local downV = -0.50
		local function weizhibiandong()
			if ModelUI:IsShown() then
				if ModelUI.pxulie then
					if ModelUI.pxulie==1 then
						ModelUI:SetPosition(0,0,downV);	
						ModelUI.pxulie=2
					elseif ModelUI.pxulie==2 then
						ModelUI:SetPosition(0,-0.6,downV);
						ModelUI.pxulie=3
					elseif ModelUI.pxulie==3 then
						ModelUI:SetPosition(0,0.6,downV);
						ModelUI.pxulie=1
					end
				end
				C_Timer.After(10,weizhibiandong)
			end
		end
		local LIKAIMSG=string.format(MARKED_AFK_MESSAGE,DEFAULT_AFK_MESSAGE)
		ModelUI:RegisterEvent("CHAT_MSG_AFK");
		ModelUI:RegisterEvent("CHAT_MSG_SYSTEM");
		ModelUI:RegisterEvent("PLAYER_REGEN_DISABLED");
		ModelUI:SetScript("OnEvent", function(self,event,arg1)
			if event=="PLAYER_REGEN_DISABLED" then
				if not InCombatLockdown() then
					SetCVar("cameraYawMoveSpeed",180)--旋转速度
					ModelUI:Hide()
					UIParent:Show()
					MoveViewLeftStop()
				end
			end
			if not InCombatLockdown() then
				if arg1==LIKAIMSG then
					SetCVar("cameraYawMoveSpeed",6)
					UIParent:Hide()
					ModelUI:Show()
					MoveViewLeftStart()
					ModelUI.pxulie=1
					weizhibiandong()
				elseif arg1==CLEARED_AFK then
					SetCVar("cameraYawMoveSpeed",180)
					ModelUI:Hide()
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
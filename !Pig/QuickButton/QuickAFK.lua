local _, addonTable = ...;
--------
local fuFrame = List_R_F_1_7
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local ADD_QuickButton=addonTable.ADD_QuickButton
--=======================================
local function ADD_QuickButton_AFK()
	if PIG['QuickButton']['Open'] then
		fuFrame.AFK:Enable()
		if PIG['QuickButton']['AKF'] then
			local GnUI = "AFK_UI"
			if _G[GnUI] then return end
			local Icon=132802
			local Tooltip = "执行离开屏保"
			local AKF_pingbao=ADD_QuickButton(GnUI,Tooltip,Icon, "SecureActionButtonTemplate")
			local WowWidth=GetScreenWidth();
			local WowHeight=GetScreenHeight();
			local ModelUI = CreateFrame("PlayerModel", nil, WorldFrame);
			ModelUI:SetSize(WowWidth-200,WowHeight-200);
			ModelUI:SetPoint("CENTER",WorldFrame,"CENTER",0,-50);
			ModelUI:SetUnit("player")
			ModelUI:SetCamera(1)
			--ModelUI:SetScale(0.8);
			--ModelUI:ClearModel();--清空模型
			ModelUI:SetPortraitZoom(-0.3);--模型视角远近
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
			AKF_pingbao:SetAttribute("type", "macro")
			AKF_pingbao:SetAttribute("macrotext", "/AFK")
			UIParent:HookScript("OnShow", function(self)
				SetCVar("cameraYawMoveSpeed",180)
				ModelUI:Hide()
				MoveViewLeftStop()
			end)
			AKF_pingbao:RegisterEvent("CHAT_MSG_AFK");
			AKF_pingbao:RegisterEvent("CHAT_MSG_SYSTEM");
			local function weizhibiandong()
				if ModelUI:IsShown() then
					if ModelUI.pxulie then
						if ModelUI.pxulie==1 then
							ModelUI:SetPosition(0,0,-0.15);	
							ModelUI.pxulie=2
						elseif ModelUI.pxulie==2 then
							ModelUI:SetPosition(0,-0.6,-0.15);
							ModelUI.pxulie=3
						elseif ModelUI.pxulie==3 then
							ModelUI:SetPosition(0,0.6,-0.15);
							ModelUI.pxulie=1
						end
					end
					C_Timer.After(10,weizhibiandong)
				end
			end
			local LIKAIMSG=string.format(MARKED_AFK_MESSAGE,DEFAULT_AFK_MESSAGE)
			AKF_pingbao:SetScript("OnEvent", function(self,event,arg1)
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
			end)
		end
	end
end
addonTable.ADD_QuickButton_AFK = ADD_QuickButton_AFK
---
fuFrame.AFK=ADD_Checkbutton(nil,fuFrame.anniuF,-60,"TOPLEFT",fuFrame.anniuF,"TOPLEFT",20,-140,"添加<AKF屏保>到快捷按钮栏","在快捷按钮栏显示AKF屏保按钮,并开启离开自动进入屏保功能")
fuFrame.AFK:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['QuickButton']['AKF']=true;
		ADD_QuickButton_AFK()
	else
		PIG['QuickButton']['AKF']=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);

fuFrame:HookScript("OnShow", function(self)
	if PIG['QuickButton']['AKF'] then
		self.AFK:SetChecked(true);
		ADD_QuickButton_AFK()
	end
end)
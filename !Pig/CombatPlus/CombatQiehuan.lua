local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_3_UI
local gsub = _G.string.gsub 
local find = _G.string.find
local sub = _G.string.sub
--进入战斗时自动切换到1号动作栏
MainMenuBar:HookScript("OnEvent", function()
	ChangeActionBarPage(1);
end)
---------------------
fuFrame.AutoFanye = CreateFrame("CheckButton", "fuFrame.AutoFanye_UI", fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.AutoFanye:SetSize(30,32);
fuFrame.AutoFanye:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-80);
fuFrame.AutoFanye.Text:SetText("进战斗时自动切换动作栏");
fuFrame.AutoFanye.tooltip = "进入战斗后自动切换到1号动作栏！";
fuFrame.AutoFanye:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['CombatPlus']['ActionBar_AutoFanye']="ON";
		MainMenuBar:RegisterEvent("PLAYER_REGEN_DISABLED");
	else
		PIG['CombatPlus']['ActionBar_AutoFanye']="OFF";
		MainMenuBar:UnregisterEvent("PLAYER_REGEN_DISABLED");
	end
end);

--=====================================
addonTable.CombatPlus_ActionBar_AutoFanye = function()
	if PIG['CombatPlus']['ActionBar_AutoFanye']=="ON" then
		fuFrame.AutoFanye:SetChecked(true);
		MainMenuBar:RegisterEvent("PLAYER_REGEN_DISABLED");
	end
end

-----------------
local TIMEshi={} 
local WWW,HHH = 60,20
local caijie_B,caijie_R = {0,0.248,0.68,0.90},{0,0.248,0.40,0.63}
local function chongzhijishiiqi()
	TIMEshi.zongjishi = 0
	TIMEshi.dangqian = 0
	CombatTime_UI.T0:SetText("00:00");
	CombatTime_UI.T1:SetText("00:00");
end
local function shuaxinTIme(elapsed)
	TIMEshi.zongjishi  =  TIMEshi.zongjishi  +  elapsed
	local d, h, m, s = ChatFrame_TimeBreakDown(TIMEshi.zongjishi);
	TIMEshi.dangqian  =  TIMEshi.dangqian  +  elapsed
	local dd, dh, dm, ds = ChatFrame_TimeBreakDown(TIMEshi.dangqian);
	if TIMEshi.zongjishi>3600 then
		if CombatTime_UI.T0:IsShown() then
			CombatTime_UI:SetWidth((WWW+20)*2+10)
			CombatTime_UI.Texture:SetWidth((WWW+20)*2+30);
		else
			CombatTime_UI:SetWidth(WWW+24)
			CombatTime_UI.Texture:SetWidth(WWW+44);
		end
		CombatTime_UI.T0:SetFormattedText("%02d:%02d:%02d", h, m, s);
		CombatTime_UI.T1:SetFormattedText("%02d:%02d:%02d", dh, dm, ds);
	else
		if CombatTime_UI.T0:IsShown() then
			CombatTime_UI:SetWidth(WWW*2)
			CombatTime_UI.Texture:SetWidth((WWW+10)*2);
		else
			CombatTime_UI:SetWidth(WWW)
			CombatTime_UI.Texture:SetWidth(WWW+20);
		end
		CombatTime_UI.T0:SetFormattedText("%02d:%02d", m, s);
		CombatTime_UI.T1:SetFormattedText("%02d:%02d", dm, ds);
	end
end	
local function chongpaiweizhi()
	local name, instanceType = GetInstanceInfo()
	if instanceType=="none" then
		CombatTime_UI.line:Hide()
		CombatTime_UI.T0:Hide()
		CombatTime_UI.T1:ClearAllPoints();
		CombatTime_UI.T1:SetPoint("CENTER",CombatTime_UI,"CENTER",0,0);
	else
		CombatTime_UI.line:Show()
		CombatTime_UI.T0:Show()
		CombatTime_UI.T1:ClearAllPoints();
		CombatTime_UI.T1:SetPoint("LEFT",CombatTime_UI,"CENTER",8,0);
	end
	chongzhijishiiqi()
	shuaxinTIme(0)
end

local function ZhandoushijianTime_ADD()
	if CombatTime_UI==nil then
		local CombatTime = CreateFrame("Frame", "CombatTime_UI", UIParent,"BackdropTemplate");
		CombatTime:SetSize(WWW,HHH)
		CombatTime:SetPoint("TOP",UIParent,"TOP",0,-60);
		CombatTime:SetFrameStrata("LOW")
		CombatTime.Texture = CombatTime:CreateTexture(nil, "BORDER");
		CombatTime.Texture:SetTexture("interface/helpframe/cs_helptextures.blp");--	interface/helpframe/helpbuttons.blp
		CombatTime.Texture:SetTexCoord(caijie_B[1],caijie_B[2],caijie_B[3],caijie_B[4]);--blue
		CombatTime.Texture:SetSize(WWW+20,HHH+10);
		CombatTime.Texture:SetPoint("CENTER",CombatTime,"CENTER",0,0);
		CombatTime.Texture:SetAlpha(0.6);
		CombatTime.Texture:Hide()
		if PIG['CombatPlus']["Beijing"]==2 then
			CombatTime.Texture:Hide()
			CombatTime:SetBackdrop({
				bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
				edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
				tile = true, tileSize = 0, edgeSize = 4,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
			CombatTime:SetBackdropColor(0, 0, 0, 0.6);
			CombatTime:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
		elseif PIG['CombatPlus']["Beijing"]==3 then
			CombatTime.Texture:Show()
		end
		CombatTime.line = CombatTime:CreateLine()
		CombatTime.line:SetColorTexture(1,1,1,0.1)
		CombatTime.line:SetThickness(1);
		CombatTime.line:SetStartPoint("TOP",0,0)
		CombatTime.line:SetEndPoint("BOTTOM",0,0)
		CombatTime.line:Hide()
		CombatTime:SetMovable(true)
		CombatTime:SetClampedToScreen(true)
		CombatTime:EnableMouse(true);
		CombatTime:RegisterForDrag("LeftButton")
		CombatTime:SetScript("OnDragStart",function()
		    CombatTime:StartMoving();
		end)
		CombatTime:SetScript("OnDragStop",function()
		    CombatTime:StopMovingOrSizing()
		end)
		CombatTime.T0 = CombatTime:CreateFontString();
		CombatTime.T0:SetPoint("RIGHT",CombatTime,"CENTER",-8,0);
		CombatTime.T0:SetFont(TextStatusBarText:GetFont(), 16,PIG['CombatPlus']["Miaobian"])
		CombatTime.T0:SetTextColor(0, 1, 0, 0.8);
		CombatTime.T0:SetText("00:00");
		CombatTime.T0:Hide()
		CombatTime.T1 = CombatTime:CreateFontString();
		CombatTime.T1:SetPoint("CENTER",CombatTime,"CENTER",0,0);
		CombatTime.T1:SetFont(TextStatusBarText:GetFont(), 16,PIG['CombatPlus']["Miaobian"])
		CombatTime.T1:SetTextColor(0, 1, 0, 0.8);
		CombatTime.T1:SetText("00:00");
		CombatTime.XXXXX = CreateFrame("Frame")
		CombatTime.XXXXX:Hide()
		CombatTime.XXXXX:HookScript("OnUpdate", function (self,elapsed)
			shuaxinTIme(elapsed)
		end)
		CombatTime:SetScript("OnMouseUp", function(self,button)
			if button=="RightButton" then
				chongzhijishiiqi()
			end
		end)
		CombatTime:HookScript("OnEvent", function (self,event,arg1,arg2)
			if event=="PLAYER_REGEN_DISABLED" then
				CombatTime.XXXXX:Show()
				CombatTime.Texture:SetTexCoord(caijie_R[1],caijie_R[2],caijie_R[3],caijie_R[4]);--red
				CombatTime.T0:SetTextColor(1, 1, 0, 0.8);
				CombatTime.T1:SetTextColor(1, 1, 0, 0.8);
			end
			if event=="PLAYER_REGEN_ENABLED" then
				CombatTime.XXXXX:Hide()
				CombatTime.Texture:SetTexCoord(caijie_B[1],caijie_B[2],caijie_B[3],caijie_B[4]);--blue
				CombatTime.T0:SetTextColor(0, 1, 0, 0.8);
				CombatTime.T1:SetTextColor(0, 1, 0, 0.8);
				TIMEshi.dangqian = 0
			end
			if event=="PLAYER_ENTERING_WORLD" then
				CombatTime.XXXXX:Hide() 
				if arg1 or arg2 then

				else
					chongpaiweizhi()
				end
			end		
		end)
		---
		
	end
	--
	chongpaiweizhi()
	CombatTime_UI:RegisterEvent("PLAYER_REGEN_DISABLED")
	CombatTime_UI:RegisterEvent("PLAYER_REGEN_ENABLED")
	CombatTime_UI:RegisterEvent("PLAYER_ENTERING_WORLD")
	if InCombatLockdown() then CombatTime_UI.XXXXX:Show() CombatTime_UI.Texture:SetTexCoord(0,0.248,0.40,0.63);end
end
---------------
fuFrame.linec1 = fuFrame:CreateLine()
fuFrame.linec1:SetColorTexture(1,1,1,0.2)
fuFrame.linec1:SetThickness(1);
fuFrame.linec1:SetStartPoint("TOPLEFT",2,-190)
fuFrame.linec1:SetEndPoint("TOPRIGHT",-2,-190)
---
fuFrame.CombatTimeCK = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.CombatTimeCK:SetSize(30,30);
fuFrame.CombatTimeCK:SetPoint("TOPLEFT",fuFrame.linec1,"TOPLEFT",20,-10);
fuFrame.CombatTimeCK:SetHitRectInsets(0,-60,0,0);
fuFrame.CombatTimeCK.Text:SetText("战斗计时");
fuFrame.CombatTimeCK.tooltip = "在游戏界面启用一个显示战斗时间的框架\n|cff00FF00副本内：\n左边本次进本的战斗总用时，右边为本次战斗用时。|r\n|cff00FF00副本外：\n只显示本次战斗用时。|r";
fuFrame.CombatTimeCK:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['CombatPlus']["CombatTime"]=true
		fuFrame.CBTPoint:Show()
		ZhandoushijianTime_ADD()
	else
		PIG['CombatPlus']["CombatTime"]=false
		fuFrame.CBTPoint:Hide()
		CombatTime_UI:Hide()
		CombatTime_UI:UnregisterEvent("PLAYER_REGEN_DISABLED")
		CombatTime_UI:UnregisterEvent("PLAYER_REGEN_ENABLED")
		CombatTime_UI:UnregisterEvent("PLAYER_ENTERING_WORLD")
		Pig_Options_RLtishi_UI:Show()
	end
end);
---重置位置
fuFrame.CBTPoint = CreateFrame("Button",nil,fuFrame);
fuFrame.CBTPoint:SetSize(22,22);
fuFrame.CBTPoint:SetPoint("LEFT",fuFrame.CombatTimeCK.Text,"RIGHT",16,-1);
fuFrame.CBTPoint:Hide()
fuFrame.CBTPoint.highlight = fuFrame.CBTPoint:CreateTexture(nil, "HIGHLIGHT");
fuFrame.CBTPoint.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
fuFrame.CBTPoint.highlight:SetBlendMode("ADD")
fuFrame.CBTPoint.highlight:SetPoint("CENTER", fuFrame.CBTPoint, "CENTER", 0,0);
fuFrame.CBTPoint.highlight:SetSize(30,30);
fuFrame.CBTPoint.Normal = fuFrame.CBTPoint:CreateTexture(nil, "BORDER");
fuFrame.CBTPoint.Normal:SetTexture("interface/buttons/ui-refreshbutton.blp");
fuFrame.CBTPoint.Normal:SetBlendMode("ADD")
fuFrame.CBTPoint.Normal:SetPoint("CENTER", fuFrame.CBTPoint, "CENTER", 0,0);
fuFrame.CBTPoint.Normal:SetSize(18,18);
fuFrame.CBTPoint:HookScript("OnMouseDown", function (self)
	fuFrame.CBTPoint.Normal:SetPoint("CENTER", fuFrame.CBTPoint, "CENTER", -1.5,-1.5);
end);
fuFrame.CBTPoint:HookScript("OnMouseUp", function (self)
	fuFrame.CBTPoint.Normal:SetPoint("CENTER", fuFrame.CBTPoint, "CENTER", 0,0);
end);
fuFrame.CBTPoint:SetScript("OnEnter", function (self)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine("\124cff00ff00重置战斗计时的位置\124r")
	GameTooltip:Show();
end);
fuFrame.CBTPoint:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
fuFrame.CBTPoint:SetScript("OnClick", function ()
	CombatTime_UI:ClearAllPoints();
	CombatTime_UI:SetPoint("TOP",UIParent,"TOP",0,-60);
end)
----
fuFrame.zitimiaobian = fuFrame:CreateFontString();
fuFrame.zitimiaobian:SetPoint("LEFT",fuFrame.CBTPoint,"RIGHT",10,0);
fuFrame.zitimiaobian:SetFontObject(GameFontNormal);
fuFrame.zitimiaobian:SetText("字体描边");
local ChatFontList = {"无","OUTLINE","THICKOUTLINE","MONOCHROME"};
fuFrame.zitimiaobianD = CreateFrame("FRAME", nil, fuFrame, "UIDropDownMenuTemplate")
fuFrame.zitimiaobianD:SetPoint("LEFT",fuFrame.zitimiaobian,"RIGHT",-11,-3)
UIDropDownMenu_SetWidth(fuFrame.zitimiaobianD, 120)
local function jiazaixialaimude(self)
	local info = UIDropDownMenu_CreateInfo()
	info.func = self.SetValue
	for i=1,#ChatFontList,1 do
	    info.text, info.arg1, info.checked = ChatFontList[i], ChatFontList[i], ChatFontList[i] == PIG['CombatPlus']["Miaobian"];
		UIDropDownMenu_AddButton(info)
	end
end
function fuFrame.zitimiaobianD:SetValue(newValue)
	PIG['CombatPlus']["Miaobian"] = newValue;
	UIDropDownMenu_SetText(fuFrame.zitimiaobianD, newValue)
	CombatTime_UI.T0:SetFont(TextStatusBarText:GetFont(), 16,newValue)
	CombatTime_UI.T1:SetFont(TextStatusBarText:GetFont(), 16,newValue)
	CloseDropDownMenus()
end
----
fuFrame.BGcaizhi = fuFrame:CreateFontString();
fuFrame.BGcaizhi:SetPoint("LEFT",fuFrame.zitimiaobianD,"RIGHT",10,3);
fuFrame.BGcaizhi:SetFontObject(GameFontNormal);
fuFrame.BGcaizhi:SetText("背景材质");
local BGList={"无","材质1","材质2"}
fuFrame.BGcaizhiD = CreateFrame("FRAME", nil, fuFrame, "UIDropDownMenuTemplate")
fuFrame.BGcaizhiD:SetPoint("LEFT",fuFrame.BGcaizhi,"RIGHT",-11,-3)
UIDropDownMenu_SetWidth(fuFrame.BGcaizhiD, 80)
local function jiazaixialaimudeBG(self)
	local info = UIDropDownMenu_CreateInfo()
	info.func = self.SetValue
	for i=1,#BGList,1 do
	    info.text, info.arg1, info.checked = BGList[i], i, i == PIG['CombatPlus']["Beijing"];
		UIDropDownMenu_AddButton(info)
	end
end
function fuFrame.BGcaizhiD:SetValue(newValue)
	PIG['CombatPlus']["Beijing"] = newValue;
	UIDropDownMenu_SetText(fuFrame.BGcaizhiD, BGList[newValue])
	if newValue==1 then
		CombatTime_UI.Texture:Hide()
		CombatTime_UI:SetBackdrop(nil)
	elseif newValue==2 then
		CombatTime_UI.Texture:Hide()
		CombatTime_UI:SetBackdrop({
			bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
			tile = true, tileSize = 0, edgeSize = 4,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
		CombatTime_UI:SetBackdropColor(0, 0, 0, 0.6);
		CombatTime_UI:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.8);
	elseif newValue==3 then
		CombatTime_UI:SetBackdrop(nil)
		CombatTime_UI.Texture:Show()
	end
	CloseDropDownMenus()
end
-----------------
addonTable.CombatPlus_TimeOpen = function()
	PIG['CombatPlus']["Miaobian"]=PIG['CombatPlus']["Miaobian"] or addonTable.Default['CombatPlus']["Miaobian"]
	UIDropDownMenu_Initialize(fuFrame.zitimiaobianD, jiazaixialaimude)
	UIDropDownMenu_SetText(fuFrame.zitimiaobianD, PIG['CombatPlus']["Miaobian"])
	PIG['CombatPlus']["Beijing"]=PIG['CombatPlus']["Beijing"] or addonTable.Default['CombatPlus']["Beijing"]
	UIDropDownMenu_Initialize(fuFrame.BGcaizhiD, jiazaixialaimudeBG)
	UIDropDownMenu_SetText(fuFrame.BGcaizhiD, BGList[PIG['CombatPlus']["Beijing"]])
	if PIG['CombatPlus']["CombatTime"] then
		fuFrame.CombatTimeCK:SetChecked(true);
		fuFrame.CBTPoint:Show()
		ZhandoushijianTime_ADD()
	end
end
local _, addonTable = ...;
-----------------
local fuFrame = Pig_Options_RF_TAB_11_UI
------------------------------------------------
local CVarsName = {
	{"按下键时施法(正常抬起时施法)","ActionButtonUseKeyDown","1","0",},
	{"显示目标所有增减益效果","noBuffDebuffFilterOnTarget","1","0",},
	{"友方姓名板职业颜色","ShowClassColorInFriendlyNameplate","1","0",},
	{"敌方姓名板职业颜色","ShowClassColorInNameplate","1","0",},
	{"自动比较装备","alwaysCompareItems","1","0",},
	{"屏幕泛光","ffxGlow","1","0",},
	{"死亡特效","ffxDeath","1","0",},
	{"聊天栏职业颜色","chatClassColorOverride","0","1",},
	{"反河蟹","overrideArchive","0","1",},
	{"超远视距","cameraDistanceMaxZoomFactor","4","2"},
}
for i=1,#CVarsName do
	fuFrame.Button = CreateFrame("CheckButton","PigCVars_"..i, fuFrame, "ChatConfigCheckButtonTemplate");
	fuFrame.Button:SetSize(27,28);
	fuFrame.Button:SetHitRectInsets(0,-100,0,0);
	if i==1 then
		fuFrame.Button:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 20, -10);
	else
		fuFrame.Button:SetPoint("TOPLEFT", _G["PigCVars_"..(i-1)], "BOTTOMLEFT", 0, -7);
	end
	fuFrame.Button.Text:SetText(CVarsName[i][1]);
	fuFrame.Button.tooltip = "开启"..CVarsName[i][1];
	fuFrame.Button:SetScript("OnClick", function (self)
		if self:GetChecked() then
			SetCVar(CVarsName[i][2], CVarsName[i][3])
			if CVarsName[i][2]=="cameraDistanceMaxZoomFactor" then
				PIG['CVars']["cameraDistanceMaxZoomFactor"]="ON"
			end
		else
			SetCVar(CVarsName[i][2], CVarsName[i][4])
			if CVarsName[i][2]=="cameraDistanceMaxZoomFactor" then
				PIG['CVars']["cameraDistanceMaxZoomFactor"]="OFF"
			end
		end
		if CVarsName[i][1]=="友方姓名板职业颜色" or CVarsName[i][1]=="敌方姓名板职业颜色" then
			Pig_Options_RLtishi_UI:Show()
		end
	end);
	if CVarsName[i][1]=="友方姓名板职业颜色" or CVarsName[i][1]=="敌方姓名板职业颜色" or CVarsName[i][1]=="反河蟹" then
		fuFrame.Button.tishi = CreateFrame("Frame", nil, fuFrame.Button);
		fuFrame.Button.tishi:SetSize(28,28);
		fuFrame.Button.tishi:SetPoint("LEFT", fuFrame.Button.Text, "RIGHT", -2,0);
		fuFrame.Button.tishi.Texture = fuFrame.Button.tishi:CreateTexture(nil, "BORDER");
		fuFrame.Button.tishi.Texture:SetTexture("interface/common/help-i.blp");
		fuFrame.Button.tishi.Texture:SetAllPoints(fuFrame.Button.tishi)
		fuFrame.Button.tishi:SetScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
			GameTooltip:AddLine("提示：")
			if CVarsName[i][1]=="反河蟹" then
				GameTooltip:AddLine("\124cff00ff00此设置需退出战网和WOW客户端重新进入生效!\124r")
			else
				GameTooltip:AddLine("\124cff00ff00此设置需重载界面才能生效!\124r")
			end
			GameTooltip:Show();
		end);
		fuFrame.Button.tishi:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
	end
end
-------------------------------------------------
--天气效果
local tianqiLV = {"0","1","2","3"}
local tianqiName = {["0"]="小雨",["1"]="中雨",["2"]="大雨",["3"]="暴雨"}
fuFrame.tianqititle = fuFrame:CreateFontString();
fuFrame.tianqititle:SetPoint("TOPLEFT",Pig_Options_RF_TAB_7_UI,"TOPLEFT",306,-96);
fuFrame.tianqititle:SetFontObject(GameFontNormal);
fuFrame.tianqititle:SetText('天气效果');
fuFrame.tianqi = CreateFrame("FRAME", nil, fuFrame, "UIDropDownMenuTemplate")
fuFrame.tianqi:SetPoint("LEFT",fuFrame.tianqititle,"RIGHT",-14,-1)
UIDropDownMenu_SetWidth(fuFrame.tianqi, 80)
local function tianqixiala_UP(self)
	local tianqivalue= GetCVarInfo("weatherDensity")
	local info = UIDropDownMenu_CreateInfo()
	info.func = self.SetValue
	for i=1,#tianqiLV,1 do
	    info.text, info.arg1, info.checked = tianqiName[tianqiLV[i]], tianqiLV[i], tianqiLV[i] == tianqivalue;
		UIDropDownMenu_AddButton(info)
	end 
end
function fuFrame.tianqi:SetValue(newValue)
	UIDropDownMenu_SetText(fuFrame.tianqi, tianqiName[newValue])
	SetCVar("weatherDensity",newValue)
	CloseDropDownMenus()
end
----血液效果
local xueyeLV = {"0","1","2","3","4","5"}
local xueyeLVName = {["0"]="无",["1"]="略微",["2"]="有一点",["3"]="普通",["4"]="暴力",["5"]="很暴力"}
fuFrame.xueyetitle = fuFrame:CreateFontString();
fuFrame.xueyetitle:SetPoint("TOPLEFT",fuFrame.tianqititle,"BOTTOMLEFT",0,-20);
fuFrame.xueyetitle:SetFontObject(GameFontNormal);
fuFrame.xueyetitle:SetText('血液效果');
fuFrame.xueye = CreateFrame("FRAME", nil, fuFrame, "UIDropDownMenuTemplate")
fuFrame.xueye:SetPoint("LEFT",fuFrame.xueyetitle,"RIGHT",-14,-1)
UIDropDownMenu_SetWidth(fuFrame.xueye, 80)
local function xueyexiala_UP(self)
	local xueyevalue= GetCVarInfo("violenceLevel")
	local info = UIDropDownMenu_CreateInfo()
	info.func = self.SetValue
	for i=1,#xueyeLV,1 do
	    info.text, info.arg1, info.checked = xueyeLVName[xueyeLV[i]], xueyeLV[i], xueyeLV[i] == xueyevalue;
		UIDropDownMenu_AddButton(info)
	end 
end
function fuFrame.xueye:SetValue(newValue)
	UIDropDownMenu_SetText(fuFrame.xueye, xueyeLVName[newValue])
	SetCVar("violenceLevel",newValue)
	CloseDropDownMenus()
	Pig_Options_RLtishi_UI:Show()
end
fuFrame.xueyetishi = CreateFrame("Frame", nil, fuFrame);
fuFrame.xueyetishi:SetSize(28,28);
fuFrame.xueyetishi:SetPoint("LEFT", fuFrame.xueye, "RIGHT", -14,2);
fuFrame.xueyetishi.Texture = fuFrame.xueyetishi:CreateTexture(nil, "BORDER");
fuFrame.xueyetishi.Texture:SetTexture("interface/common/help-i.blp");
fuFrame.xueyetishi.Texture:SetAllPoints(fuFrame.xueyetishi)
fuFrame.xueyetishi:SetScript("OnEnter", function ()
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(fuFrame.xueyetishi, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine(
		"\124cff00ff00此设置需重载界面才能生效。\124r")
	GameTooltip:Show();
end);
fuFrame.xueyetishi:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
---------------------
--浮动信息
local fudongzihao = {"1.0","2.0","3.0"}
fuFrame.fudongzitititle = fuFrame:CreateFontString();
fuFrame.fudongzitititle:SetPoint("TOPLEFT",fuFrame.xueyetitle,"BOTTOMLEFT",0,-20);
fuFrame.fudongzitititle:SetFontObject(GameFontNormal);
fuFrame.fudongzitititle:SetText('浮动信息大小');
fuFrame.fudongziti = CreateFrame("FRAME", nil, fuFrame, "UIDropDownMenuTemplate")
fuFrame.fudongziti:SetPoint("LEFT",fuFrame.fudongzitititle,"RIGHT",-14,-1)
UIDropDownMenu_SetWidth(fuFrame.fudongziti, 80)
local function fudongxinxi_UP(self)
	local zitidaxiao= GetCVarInfo("WorldTextScale")
	local info = UIDropDownMenu_CreateInfo()
	info.func = self.SetValue
	for i=1,#fudongzihao,1 do
	    info.text, info.arg1, info.checked = fudongzihao[i], fudongzihao[i], fudongzihao[i] == zitidaxiao;
		UIDropDownMenu_AddButton(info)
	end 
end
function fuFrame.fudongziti:SetValue(newValue)
	UIDropDownMenu_SetText(fuFrame.fudongziti, newValue)
	SetCVar("WorldTextScale",newValue)
	CloseDropDownMenus()
end
---
---自身高亮
local gaoliangmoshiV = {"-1","0","1","2"}
local gaoliangmoshiName = {["-1"]="关闭",["0"]="圆环",["1"]="圆环/轮廓线",["2"]="轮廓线"}
fuFrame.gaoliangtitle = fuFrame:CreateFontString();
fuFrame.gaoliangtitle:SetPoint("TOPLEFT",fuFrame.fudongzitititle,"BOTTOMLEFT",0,-20);
fuFrame.gaoliangtitle:SetFontObject(GameFontNormal);
fuFrame.gaoliangtitle:SetText('自身高亮');
fuFrame.gaoliang = CreateFrame("FRAME", nil, fuFrame, "UIDropDownMenuTemplate")
fuFrame.gaoliang:SetPoint("LEFT",fuFrame.gaoliangtitle,"RIGHT",-14,-1)
UIDropDownMenu_SetWidth(fuFrame.gaoliang, 120)
local function gaoliang_UP(self)
	local value= GetCVarInfo("findYourselfMode")
	local info = UIDropDownMenu_CreateInfo()
	info.func = self.SetValue
	for i=1,#gaoliangmoshiV,1 do
	    info.text, info.arg1, info.checked = gaoliangmoshiName[gaoliangmoshiV[i]], gaoliangmoshiV[i], gaoliangmoshiV[i] == value;
		UIDropDownMenu_AddButton(info)
	end 
end
function fuFrame.gaoliang:SetValue(newValue)
	UIDropDownMenu_SetText(fuFrame.gaoliang, gaoliangmoshiName[newValue])
	SetCVar("findYourselfMode",newValue)
	CloseDropDownMenus()
end
--
-- local qingkuang = {"总是高亮","仅战斗中高亮","仅战场中高亮","仅战场战斗中高亮","仅团队中高亮","仅团队战斗中高亮"}
-- local qingkuangV = {"findYourselfAnywhere","findYourselfAnywhereOnlyInCombat","findYourselfInBG","findYourselfInBGOnlyInCombat","findYourselfInRaid","findYourselfInRaidOnlyInCombat"}
local qingkuang = {"总是高亮","仅战场中高亮","仅团队中高亮"}
local qingkuangV = {"findYourselfAnywhere","findYourselfInBG","findYourselfInRaid"}
for i=1,#qingkuang do
	fuFrame.GLBUT = CreateFrame("CheckButton","Gaoliang_But"..i, fuFrame, "ChatConfigCheckButtonTemplate");
	fuFrame.GLBUT:SetSize(28,28);
	fuFrame.GLBUT:SetHitRectInsets(0,-100,0,0);
	if i==1 then
		fuFrame.GLBUT:SetPoint("TOPLEFT", fuFrame.gaoliangtitle, "BOTTOMLEFT", 30, -9);
	else
		fuFrame.GLBUT:SetPoint("TOPLEFT", _G["Gaoliang_But"..(i-1)], "BOTTOMLEFT",30, -4);
	end
	fuFrame.GLBUT.Text:SetText(qingkuang[i]);
	fuFrame.GLBUT.tooltip = "勾选将开启"..qingkuang[i];
	fuFrame.GLBUT:SetScript("OnClick", function (self)
		if self:GetChecked() then
			SetCVar(qingkuangV[i], 1)
		else
			SetCVar(qingkuangV[i], 0)
		end
	end);
end
--===============================
fuFrame.line = fuFrame:CreateLine()
fuFrame.line:SetColorTexture(1,1,1,0.3)
fuFrame.line:SetThickness(1);
fuFrame.line:SetStartPoint("BOTTOMLEFT",2.4,36)
fuFrame.line:SetEndPoint("BOTTOMRIGHT",-2.4,36)
------禁止同步配置
local peizhilist = {"显示LUA错误","禁止同步键位","禁止同步宏","禁止同步CVar设置"}
local peizhilistV = {"scriptErrors","synchronizeBindings","synchronizeMacros","synchronizeConfig"}
local peizhilistYES = {"1","0","0","0"}
local peizhilistNO = {"0","1","1","1"}
for i=1,#peizhilist do
	fuFrame.tongbu = CreateFrame("CheckButton","Pigtongbu_But"..i, fuFrame, "ChatConfigCheckButtonTemplate");
	fuFrame.tongbu:SetSize(26,26);
	fuFrame.tongbu:SetHitRectInsets(0,-80,0,0);
	fuFrame.tongbu.Text:SetText(peizhilist[i]);	
	if peizhilist[i]=="显示LUA错误" then
		fuFrame.tongbu:SetPoint("BOTTOMLEFT", fuFrame, "BOTTOMLEFT", 8, 4);
		fuFrame.tongbu.tooltip = peizhilist[i].."，注意：对插件不了解请勿开启！！！";
		fuFrame.tongbu.Text:SetTextColor(1, 0, 0, 1);
	else
		fuFrame.tongbu.tooltip = peizhilist[i].."到服务器";
		if i==2 then
			fuFrame.tongbu:SetPoint("LEFT", _G["Pigtongbu_But"..(i-1)], "RIGHT", 130, 0);
		elseif i==3 then
			fuFrame.tongbu:SetPoint("LEFT", _G["Pigtongbu_But"..(i-1)], "RIGHT", 110, 0);
		else
			fuFrame.tongbu:SetPoint("LEFT", _G["Pigtongbu_But"..(i-1)], "RIGHT", 90, 0);
		end
	end
	
	fuFrame.tongbu:SetScript("OnClick", function (self)
		if self:GetChecked() then
			SetCVar(peizhilistV[i], peizhilistYES[i])
		else
			SetCVar(peizhilistV[i], peizhilistNO[i])
		end
	end);
end
-----
------------------------------------------------
local function Show_CVars()
	for i=1,#CVarsName do
		if GetCVarInfo(CVarsName[i][2])==CVarsName[i][3] then
			_G["PigCVars_"..i]:SetChecked(true);
		end
	end
	for i=1,#peizhilistV do
		local value= GetCVarInfo(peizhilistV[i])
		if value==peizhilistYES[i] then
			_G["Pigtongbu_But"..i]:SetChecked(true);
		end
	end
	--
	local tianqivalue= GetCVarInfo("weatherDensity")
	UIDropDownMenu_SetText(fuFrame.tianqi, tianqiName[tianqivalue])
	local xueyevalue= GetCVarInfo("violenceLevel")
	UIDropDownMenu_SetText(fuFrame.xueye, xueyeLVName[xueyevalue])
	local zitidaxiao= GetCVarInfo("WorldTextScale")
	UIDropDownMenu_SetText(fuFrame.fudongziti, zitidaxiao)
	local moshiV= GetCVarInfo("findYourselfMode")
	UIDropDownMenu_SetText(fuFrame.gaoliang, gaoliangmoshiName[moshiV])
	for i=1,#qingkuangV do
		local value= GetCVarInfo(qingkuangV[i])
		if value=="1" then
			_G["Gaoliang_But"..i]:SetChecked(true);
		end
	end
end
fuFrame:SetScript("OnShow", Show_CVars);
--==============================================
addonTable.PigCVars = function()
	PIG['CVars']=PIG['CVars'] or addonTable.Default['CVars']
	local function chaoyuanshijujihuo()
		for i=1,#CVarsName do	
			if CVarsName[i][2]=="cameraDistanceMaxZoomFactor" then
				SetCVar(CVarsName[i][2], CVarsName[i][3])
				_G["PigCVars_"..i]:SetChecked(true);
			end
		end
	end
	if PIG['CVars']["cameraDistanceMaxZoomFactor"]=="ON" then
		C_Timer.After(4, chaoyuanshijujihuo)
	end
	UIDropDownMenu_Initialize(fuFrame.tianqi, tianqixiala_UP)
	----
	UIDropDownMenu_Initialize(fuFrame.xueye, xueyexiala_UP)
	---
	UIDropDownMenu_Initialize(fuFrame.fudongziti, fudongxinxi_UP)
	--
	UIDropDownMenu_Initialize(fuFrame.gaoliang, gaoliang_UP)
end
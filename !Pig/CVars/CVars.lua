local _, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
-----------------
local fuFrame = List_R_F_1_9
local ADD_Checkbutton=addonTable.ADD_Checkbutton
------------------------------------------------
fuFrame.Scroll = CreateFrame("ScrollFrame",nil,fuFrame, "UIPanelScrollFrameTemplate");  
fuFrame.Scroll:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",6,-6);
fuFrame.Scroll:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",-26,5);
fuFrame.nr = CreateFrame("Frame", nil, fuFrame.scroll)
fuFrame.nr:SetWidth(fuFrame.Scroll:GetWidth())
fuFrame.nr:SetHeight(10) 
fuFrame.Scroll:SetScrollChild(fuFrame.nr)
-----------------------------
--创建提示
local function ADD_tishi(fujiF,CVarsV,pianyiX,pianyiY)
	fujiF.tishi = CreateFrame("Frame", nil, fujiF);
	fujiF.tishi:SetSize(28,28);
	fujiF.tishi:SetPoint("LEFT", fujiF.Text, "RIGHT", pianyiX,pianyiY);
	fujiF.tishi.Texture = fujiF.tishi:CreateTexture(nil, "BORDER");
	fujiF.tishi.Texture:SetTexture("interface/common/help-i.blp");
	fujiF.tishi.Texture:SetAllPoints(fujiF.tishi)
	fujiF.tishi:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("提示：")
		if CVarsV=="反河蟹" then
			GameTooltip:AddLine("\124cff00ff00此设置需退出战网和WOW客户端重新进入生效!\124r")
		else
			GameTooltip:AddLine("\124cff00ff00此设置需重载界面才能生效!\124r")
		end
		GameTooltip:Show();
	end);
	fujiF.tishi:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
end
----------
local chaoyuanshijuVVV = 4
if tocversion>80000 then
	chaoyuanshijuVVV = 2.6
end
local CVarsList = {
	{"自动比较装备","alwaysCompareItems","1","0","开启后在查看装备时会自动和身上装备对比",false},
	--{"聊天栏显示职业颜色","chatClassColorOverride","0","1","聊天框发言的玩家姓名会根据职业染色",false},
	{"显示目标所有增减益","noBuffDebuffFilterOnTarget","1","0","开启后目标所有增减益都会显示在目标头像，关闭则只显示自己施加的效果",false},
	{"显示姓名板","nameplateShowOnlyNames","0","1","显示姓名板，正式服需要显示战斗外姓名版需要打开-界面-名字-显示所有姓名版",true},
	{"选中姓名板锁定在屏幕内","clampTargetNameplateToScreen","1","0","姓名板锁定在屏幕内",false},
	{"友方姓名板职业颜色","ShowClassColorInFriendlyNameplate","1","0","根据友方职业颜色染色姓名板",true},
	{"敌方姓名板职业颜色","ShowClassColorInNameplate","1","0","根据敌方职业颜色染色姓名板",true},
	---
	{"按下按键时施法","ActionButtonUseKeyDown","1","0","开启后在你按下按键时候就会触发施法，正常是在抬起按键才触发，这样能略微增加你的施法速度",false},
	{"屏幕泛光","ffxGlow","1","0","开启后屏幕会微微泛光，觉得晃眼或者刺眼情况下你可能需要关闭此效果",false},
	{"死亡特效","ffxDeath","1","0","开启后死亡时屏幕是黑白，关闭后是彩色",false},
	{"超远视距","cameraDistanceMaxZoomFactor",chaoyuanshijuVVV,"2","开启后视野可以拉的更远",false},
	{"反河蟹","overrideArchive","0","1","恢复某些模型的和谐之前的样子，例如骷髅药水不再是长肉的骷髅",true},
	{"新版TAB","TargetNearestUseNew","1","0","使用7.2版后的TAB选取目标功能,战斗中不会Tab到战斗外目标,不会Tab到你的角色或镜头看不到的目标。\n关闭后将启用旧版的选取最近目标。",false},
	---
	{"禁止同步键位到服务器","synchronizeBindings","0","1","禁止同步键位到服务器",false},
	{"禁止同步宏到服务器","synchronizeMacros","0","1","禁止同步宏到服务器",false},
	{"禁止同步CVar设置到服务器","synchronizeConfig","0","1","禁止同步CVar设置到服务器",false},
	---
	{"显示你对目标伤害信息","floatingCombatTextCombatDamage","1","0","在目标人物显示你对目标伤害数字",false},
	{"旧版弹出方式","floatingCombatTextCombatDamageDirectionalScale","0","1","开启后伤害弹出数字将会从目标上方弹出，而不是发散样式",false},
	{"显示你对目标治疗信息","floatingCombatTextCombatHealing","1","0","在目标人物显示你对目标治疗数字",false},
	--
	{"自身高亮","findYourselfAnywhere","1","0","高亮显示自身角色，高亮模式请在下方设置",false},
	{"仅战斗中高亮","findYourselfAnywhereOnlyInCombat","1","0","仅在战斗中高亮显示自身角色，高亮模式请在下方设置",false},
	{"仅团队中高亮","findYourselfInRaid","1","0","仅在团队中高亮显示自身角色，高亮模式请在下方设置",false},
	{"仅团队战斗中高亮","findYourselfInRaidOnlyInCombat","1","0","仅在战场中高亮显示自身角色，高亮模式请在下方设置",false},
	{"仅战场中高亮","findYourselfInBG","1","0","仅在战场中高亮显示自身角色，高亮模式请在下方设置",false},
	{"仅战场战斗中高亮","findYourselfInBGOnlyInCombat","1","0","仅在战场中高亮显示自身角色，高亮模式请在下方设置",false},	
}
--print(GetCVarInfo("nameplateOtherTopInset"))
for i=1,#CVarsList do
	local miaodian = {_G["CVarsCB_"..(i-1)],0,-30}
	if i==1 then
		miaodian = {fuFrame.nr,10,-10}
	elseif CVarsList[i][1]=="按下按键时施法" then
		miaodian = {_G["CVarsCB_"..(i-1)],0,-150}
	elseif CVarsList[i][1]=="禁止同步键位到服务器" then
		miaodian = {_G["CVarsCB_"..(i-1)],0,-50}
	elseif CVarsList[i][1]=="显示你对目标伤害信息" then
		miaodian = {fuFrame.nr,300,-10}
	elseif CVarsList[i][1]=="旧版弹出方式" then
		miaodian = {_G["CVarsCB_"..(i-1)],30,-26}
	elseif CVarsList[i][1]=="显示你对目标治疗信息" then
		miaodian = {_G["CVarsCB_"..(i-1)],-30,-30}
	elseif CVarsList[i][1]=="自身高亮" then
		miaodian = {fuFrame.nr,300,-160}
	end
	local CVarsCB=ADD_Checkbutton("CVarsCB_"..i,fuFrame.nr,-80,"TOPLEFT",miaodian[1],"TOPLEFT",miaodian[2],miaodian[3],CVarsList[i][1],CVarsList[i][5])
	if CVarsList[i][6] then
		ADD_tishi(CVarsCB,CVarsList[i][1],-2,0)
	end
	if miaodian[4] then
		CVarsCB:Disable();
	end

	CVarsCB:SetScript("OnClick", function (self)
		if self:GetChecked() then
			SetCVar(CVarsList[i][2], CVarsList[i][3])
			if CVarsList[i][2]=="cameraDistanceMaxZoomFactor" then
				PIG['CVars']["cameraDistanceMaxZoomFactor"]="ON"
			end
		else
			SetCVar(CVarsList[i][2], CVarsList[i][4])
			if CVarsList[i][2]=="cameraDistanceMaxZoomFactor" then
				PIG['CVars']["cameraDistanceMaxZoomFactor"]="OFF"
			end
		end
		if CVarsList[i][6] then
			Pig_Options_RLtishi_UI:Show()
		end
	end);
end

local function ADD_Slider(GnName,UIName,fuFrame,Width,Height,PointZi,Point,PointFu,PointX,PointY,S_min,S_max,S_step)
	local Slider = CreateFrame("Slider", UIName, fuFrame, "OptionsSliderTemplate")
	Slider:SetSize(Width,Height);
	Slider:SetPoint(PointZi,Point,PointFu,PointX,PointY);
	Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整参数';
	Slider.Low:SetText(S_min);
	Slider.High:SetText(S_max);
	Slider:SetMinMaxValues(S_min, S_max);
	Slider:SetValueStep(S_step);
	Slider:SetObeyStepOnDrag(true);
	Slider:EnableMouseWheel(true);
	Slider:SetScript("OnMouseWheel", function(self, arg1)
		local sliderMin, sliderMax = self:GetMinMaxValues()
		local value = self:GetValue()
		local step = S_step * arg1
		if step > 0 then
			self:SetValue(min(value + step, sliderMax))
		else
			self:SetValue(max(value + step, sliderMin))
		end
	end)
	Slider.t = Slider:CreateFontString();
	Slider.t:SetPoint("RIGHT",Slider,"LEFT",-4,0);
	Slider.t:SetFontObject(GameFontNormal);
	Slider.t:SetText(GnName);
	return Slider
end
local function ShowmorenV(self,CVarName,text,textName,beishu)
	local beishu=beishu or 10
	local sishewuru = 5/beishu
	local shezhiVV= tonumber(GetCVar(CVarName))
	local shezhiVV= tostring(shezhiVV)
	self:SetValue(shezhiVV);
	if text and textName then
		self.Text:SetText(textName[shezhiVV]..text.."("..shezhiVV..")");
	elseif text then
		self.Text:SetText(shezhiVV..text);
	elseif textName then
		self.Text:SetText(textName[shezhiVV].."("..shezhiVV..")");
	else
		self.Text:SetText(shezhiVV);
	end
	self:HookScript('OnValueChanged', function(self)
		self.Valuepig=self:GetValue()
		if self:GetValueStep()<1 then
			self.Valuepig = self.Valuepig*beishu
			self.Valuepig = floor(self.Valuepig+sishewuru)/beishu
		else
			self.Valuepig = tostring(self.Valuepig)
		end
		if text and textName then
			self.Text:SetText(textName[self.Valuepig]..text.."("..self.Valuepig..")");
		elseif text then
			self.Text:SetText(self.Valuepig..text);
		elseif textName then
			self.Text:SetText(textName[self.Valuepig].."("..self.Valuepig..")");
		else
			self.Text:SetText(self.Valuepig);	
		end
		SetCVar(CVarName,self.Valuepig)
	end)
end
--
fuFrame.nr.nameShowjuli = fuFrame.nr:CreateFontString();
fuFrame.nr.nameShowjuli:SetPoint("TOPLEFT",fuFrame.nr,"TOPLEFT",10,-190);
fuFrame.nr.nameShowjuli:SetFontObject(GameFontNormal);
fuFrame.nr.nameShowjuli:SetText("姓名板锁定在屏幕内显示距离");

local nameplateTop = ADD_Slider("顶部距离",nil,fuFrame.nr,100,16,"TOPLEFT",fuFrame.nr.nameShowjuli,"BOTTOMLEFT",90,-16,0,0.2,0.01)
ShowmorenV(nameplateTop,"nameplateOtherTopInset","%屏幕尺寸",nil,100)
local nameplateBottom = ADD_Slider("底部距离",nil,fuFrame.nr,100,16,"TOPLEFT",fuFrame.nr.nameShowjuli,"BOTTOMLEFT",90,-66,0,0.2,0.01)
ShowmorenV(nameplateBottom,"nameplateOtherBottomInset","%屏幕尺寸",nil,100)
--
local fudonginfo = ADD_Slider("浮动信息大小",nil,fuFrame.nr,100,16,"TOPLEFT",fuFrame.nr,"TOPLEFT",410,-110,1,3,0.1)
ShowmorenV(fudonginfo,"WorldTextScale","倍")

--
local gaoliangmoshiName = {["-1"]="关闭",["0"]="圆环",["1"]="圆环/轮廓线",["2"]="轮廓线"}
local gaoliangMOD = ADD_Slider("高亮模式",nil,fuFrame.nr,100,16,"TOPLEFT",fuFrame.nr,"TOPLEFT",400,-350,-1,2,1)
ShowmorenV(gaoliangMOD,"findYourselfMode",nil,gaoliangmoshiName)

------
local tianqiName = {["0"]="小雨",["1"]="中雨",["2"]="大雨",["3"]="暴雨"}
local tianqixiaoguo = ADD_Slider("天气效果",nil,fuFrame.nr,100,16,"TOPLEFT",fuFrame.nr,"TOPLEFT",380,-400,0,3,1)
ShowmorenV(tianqixiaoguo,"weatherDensity",nil,tianqiName)

---
local xueyeLVName = {["0"]="无",["1"]="略微",["2"]="少量",["3"]="普通",["4"]="暴力",["5"]="很暴力"}
local xueyexiaoguo = ADD_Slider("血液效果",nil,fuFrame.nr,100,16,"TOPLEFT",fuFrame.nr,"TOPLEFT",380,-450,0,5,1)
ShowmorenV(xueyexiaoguo,"violenceLevel",nil,xueyeLVName)
ADD_tishi(xueyexiaoguo,nil,44,-15)
---信息浮动方式
-- local fudongMode = {"1","2","3"}
-- local fudongModeName = {["1"]="向上浮动",["2"]="向下浮动",["3"]="弧形散开"}
-- local ADD_DownMenu=addonTable.ADD_DownMenu
-- local xinxiMODE =ADD_DownMenu(fuFrame.nr,"信息浮动方式","floatingCombatTextFloatMode",100,fuFrame.nr,394,-490,fudongMode,fudongModeName)
-- xinxiMODE:Hide();
--===============================
fuFrame:SetScript("OnShow", function()
	for i=1,#CVarsList do
		if GetCVar(CVarsList[i][2])==CVarsList[i][3] then
			_G["CVarsCB_"..i]:SetChecked(true);
		end
	end
end);
--==============================================
addonTable.PigCVars = function()
	local function chaoyuanshijujihuo()
		for i=1,#CVarsList do	
			if CVarsList[i][2]=="cameraDistanceMaxZoomFactor" then
				SetCVar(CVarsList[i][2], CVarsList[i][3])
				_G["CVarsCB_"..i]:SetChecked(true);
			end
		end
	end
	if PIG['CVars']["cameraDistanceMaxZoomFactor"]=="ON" then
		C_Timer.After(3, chaoyuanshijujihuo)
	end
end
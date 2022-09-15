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
local function ADD_tishi(fujiF,CVarsV,pianyiV)
	fujiF.tishi = CreateFrame("Frame", nil, fujiF);
	fujiF.tishi:SetSize(28,28);
	fujiF.tishi:SetPoint("LEFT", fujiF.Text, "RIGHT", pianyiV,0);
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
--创建下拉
local function ADD_DownMenu(fujiF,biaoti,CVarsV,Width,Point,PointX,PointY,VVV,Vname)
	local frameX = CreateFrame("FRAME", nil, fujiF, "UIDropDownMenuTemplate")
	frameX:SetPoint("TOPLEFT",Point,"TOPLEFT",PointX,PointY)
	UIDropDownMenu_SetWidth(frameX, Width)
	UIDropDownMenu_Initialize(frameX, function(self)
		local info = UIDropDownMenu_CreateInfo()
		info.func = self.SetValue
		local NewVvv= tonumber(GetCVar(CVarsV))
		for i=1,#VVV,1 do
			local lisvv= tonumber(VVV[i])
		    info.text, info.arg1, info.checked = Vname[VVV[i]], VVV[i], tonumber(VVV[i]) == NewVvv;
			UIDropDownMenu_AddButton(info)
		end 
	end)
	local shezhiVV= tonumber(GetCVar(CVarsV))
	local shezhiVV= tostring(shezhiVV)
	UIDropDownMenu_SetText(frameX, Vname[shezhiVV])
	function frameX:SetValue(newValue)
		UIDropDownMenu_SetText(frameX, Vname[newValue])
		SetCVar(CVarsV,newValue)
		CloseDropDownMenus()
	end
	frameX.t = frameX:CreateFontString();
	frameX.t:SetPoint("RIGHT",frameX,"LEFT",10,2);
	frameX.t:SetFontObject(GameFontNormal);
	frameX.t:SetText(biaoti);
	return frameX
end
----------
local chaoyuanshijuVVV = 4
if tocversion>80000 then
	chaoyuanshijuVVV = 2.6
end
local CVarsList = {
	{"自动比较装备","alwaysCompareItems","1","0","开启后在查看装备时会自动和身上装备对比",false},
	{"聊天栏显示职业颜色","chatClassColorOverride","0","1","聊天框发言的玩家姓名会根据职业染色",false},
	{"显示目标所有增减益","noBuffDebuffFilterOnTarget","1","0","开启后目标所有增减益都会显示在目标头像，关闭则只显示自己施加的效果",false},
	{"显示姓名板","nameplateShowOnlyNames","0","1","显示姓名板，正式服需要显示战斗外姓名版需要打开-界面-名字-显示所有姓名版",true},
	{"友方姓名板职业颜色","ShowClassColorInFriendlyNameplate","1","0","根据友方职业颜色染色姓名板",true},
	{"敌方姓名板职业颜色","ShowClassColorInNameplate","1","0","根据敌方职业颜色染色姓名板",true},
	---
	{"按下按键时施法","ActionButtonUseKeyDown","1","0","开启后在你按下按键时候就会触发施法，正常是在抬起按键才触发，这样能略微增加你的施法速度",false},
	{"屏幕泛光","ffxGlow","1","0","开启后屏幕会微微泛光，觉得晃眼或者刺眼情况下你可能需要关闭此效果",false},
	{"死亡特效","ffxDeath","1","0","开启后死亡时屏幕是黑白，关闭后是彩色",false},
	{"超远视距","cameraDistanceMaxZoomFactor",chaoyuanshijuVVV,"2","开启后视野可以拉的更远",false},
	{"反河蟹","overrideArchive","0","1","恢复某些模型的和谐之前的样子，例如骷髅药水不再是长肉的骷髅",true},
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
	-- {"仅团队中高亮","findYourselfInRaid","1","0","仅在团队中高亮显示自身角色，高亮模式请在下方设置",false},
	-- {"仅战场中高亮","findYourselfInBG","1","0","仅在战场中高亮显示自身角色，高亮模式请在下方设置",false},
	--
	{"新版TAB","TargetNearestUseNew","1","0","使用7.2新的TAB选取目标功能",false},
}
--print(GetCVarInfo("WorldTextScale"))
for i=1,#CVarsList do
	local miaodian = {_G["CVarsCB_"..(i-1)],0,-30}
	if i==1 then
		miaodian = {fuFrame.nr,10,-10}
	elseif i==7 then
		miaodian = {_G["CVarsCB_"..(i-1)],0,-60}
	elseif i==12 then
		miaodian = {_G["CVarsCB_"..(i-1)],0,-70}
	elseif i==15 then
		miaodian = {fuFrame.nr,300,-10}
	elseif i==16 then
		miaodian = {_G["CVarsCB_"..(i-1)],30,-26}
	elseif i==17 then
		miaodian = {_G["CVarsCB_"..(i-1)],-30,-30}
	elseif CVarsList[i][1]=="自身高亮" then
		miaodian = {fuFrame.nr,300,-180}
	elseif CVarsList[i][1]=="新版TAB" then
		miaodian = {fuFrame.nr,300,-470,true}
	end
	local CVarsCB=ADD_Checkbutton("CVarsCB_"..i,fuFrame.nr,-80,"TOPLEFT",miaodian[1],"TOPLEFT",miaodian[2],miaodian[3],CVarsList[i][1],CVarsList[i][5])
	if CVarsList[i][6] then
		ADD_tishi(CVarsCB,CVarsList[i][1],-2)
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
--浮动信息大小---------
local fudongzihao = {"1.0","2.0","3.0"}
local tianqiName = {["1"]="默认",["2"]="2倍",["3"]="3倍",["1.0"]="默认",["2.0"]="2倍",["3.0"]="3倍"}
ADD_DownMenu(fuFrame.nr,"浮动信息大小","WorldTextScale",80,fuFrame.nr,394,-106,fudongzihao,tianqiName)
--高亮模式
local gaoliangmoshiV = {"-1","0","1","2"}
local gaoliangmoshiName = {["-1"]="关闭",["0"]="圆环",["1"]="圆环/轮廓线",["2"]="轮廓线"}
ADD_DownMenu(fuFrame.nr,"高亮模式","findYourselfMode",80,fuFrame.nr,384,-210,gaoliangmoshiV,gaoliangmoshiName)
--天气效果----------------------
local tianqiLV = {"0","1","2","3"}
local tianqiName = {["0"]="小雨",["1"]="中雨",["2"]="大雨",["3"]="暴雨"}
ADD_DownMenu(fuFrame.nr,"天气效果","weatherDensity",80,fuFrame.nr,364,-290,tianqiLV,tianqiName)
----血液效果
local xueyeLV = {"0","1","2","3","4","5"}
local xueyeLVName = {["0"]="无",["1"]="略微",["2"]="少量",["3"]="普通",["4"]="暴力",["5"]="很暴力"}
local xueyexiala =ADD_DownMenu(fuFrame.nr,"血液效果","violenceLevel",80,fuFrame.nr,364,-330,xueyeLV,xueyeLVName)
ADD_tishi(xueyexiala,nil,24)
---信息浮动方式
local fudongMode = {"1","2","3"}
local fudongModeName = {["1"]="向上浮动",["2"]="向下浮动",["3"]="弧形散开"}
local xinxiMODE =ADD_DownMenu(fuFrame.nr,"信息浮动方式","floatingCombatTextFloatMode",100,fuFrame.nr,394,-430,fudongMode,fudongModeName)
xinxiMODE:Hide();
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
	PIG['CVars']=PIG['CVars'] or addonTable.Default['CVars']
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
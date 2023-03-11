local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local fuFrame=List_R_F_1_12
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local Create=addonTable.Create
local PIGDownMenu=Create.PIGDownMenu
local PIGButton = Create.PIGButton
--///////////////////////////////////////////
fuFrame.NPCID = PIGButton("获取目标GUID",nil,fuFrame,{114,24},{"TOPLEFT",fuFrame,"TOPLEFT",20,-20})
fuFrame.NPCID:SetScript("OnClick", function (self)
	print(UnitGUID("target"))
end);
--==================================================
--启用CPU监控
SetCVar("scriptProfile", 0)--默认设置关闭
fuFrame.CPU_OPEN = PIGButton("开启CPU监控",nil,fuFrame,{110,24},{"TOPLEFT",fuFrame,"TOPLEFT",20,-80})
fuFrame.CPU_OPEN:SetScript("OnClick", function (self)
	if self:GetText()=="关闭CPU监控" then
		SetCVar("scriptProfile", 0)
		fuFrame.CPU_OPEN:SetText("开启CPU监控");
	else
		SetCVar("scriptProfile", 1)
		fuFrame.CPU_OPEN:SetText("关闭CPU监控");
	end
end);
fuFrame.CPU_OPEN.DAYIN = PIGButton("打印数据到聊天框",nil,fuFrame.CPU_OPEN,{150,24},{"TOPLEFT",fuFrame.CPU_OPEN,"TOPLEFT",160,0})
fuFrame.CPU_OPEN.DAYIN:SetScript("OnClick", function (self)
	if GetCVarInfo("scriptProfile")=="1" then
		UpdateAddOnMemoryUsage()
		UpdateAddOnCPUUsage()
		for i=1,GetNumAddOns() do
			local name=GetAddOnInfo(i)
			local CPUzhanyou=GetAddOnCPUUsage(i)
			local Neicunzhanyou=GetAddOnMemoryUsage(i)
			print(name.."----内存："..floor(Neicunzhanyou).."K ;----CPU："..CPUzhanyou)
		end
	else
		UpdateAddOnMemoryUsage()
		for i=1,GetNumAddOns() do
			local name=GetAddOnInfo(i)
			local namezhanyou=GetAddOnMemoryUsage(i)
			print(name.."----内存："..floor(namezhanyou).."K")
		end
	end
end);
fuFrame.CPU_OPEN.CZ = PIGButton("重置数据",nil,fuFrame.CPU_OPEN,{80,24},{"TOPLEFT",fuFrame.CPU_OPEN,"TOPLEFT",380,0})
fuFrame.CPU_OPEN.CZ:SetScript("OnClick", function (self)
	ResetCPUUsage()
end);

--------------------------------
fuFrame.errorUI = PIGButton("错误报告",nil,fuFrame,{120,24},{"TOPLEFT",fuFrame,"TOPLEFT",20,-180})
fuFrame.errorUI:SetScript("OnClick", function (self)
	Pig_OptionsUI:Hide()
	Bugcollect_UI:Show()
end);
--
fuFrame.tishi = fuFrame:CreateFontString();
fuFrame.tishi:SetPoint("LEFT", fuFrame.errorUI, "RIGHT", 10, 0);
fuFrame.tishi:SetFontObject(GameFontNormal);
fuFrame.tishi:SetTextColor(1, 1, 0, 1);
fuFrame.tishi:SetText('打开报告指令：/per');
--
fuFrame.tishiCK=ADD_Checkbutton(nil,fuFrame,-100,"LEFT",fuFrame.tishi,"RIGHT",10,0,"在小地图图标提示错误","发生错误时在小地图图标提示(显示一个红X)")
fuFrame.tishiCK:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["Error"]["ErrorTishi"] = true
	else
		PIG["Error"]["ErrorTishi"] = false
	end
end);
---------
local CVarsList = {
	{"打开系统LUA错误提示","scriptErrors","1","0","打开系统的LUA错误提示功能，非调试插件情况下请不要开启",false},
}
for i=1,#CVarsList do
	local miaodian = {fuFrame,20,-290}
	if i>1 then
		miaodian = {_G["ErrCB_"..(i-1)],0,-40}
	end
	local ErrCB=ADD_Checkbutton("ErrCB_"..i,fuFrame,-80,"TOPLEFT",miaodian[1],"TOPLEFT",miaodian[2],miaodian[3],CVarsList[i][1],CVarsList[i][5])
	ErrCB:SetScript("OnClick", function (self)
		if self:GetChecked() then
			SetCVar(CVarsList[i][2], CVarsList[i][3])
		else
			SetCVar(CVarsList[i][2], CVarsList[i][4])
		end
	end);
end
---
local taintlist = {"0","1","2","11"}
local taintlistmenu = {["0"]="不记录任何内容",["1"]="记录被阻止的操作",
	["2"]="记录被阻止的操作/全局变量",["11"]="记录被阻止的操作/全局变量/条目(PTR/Beta)",
}
fuFrame.taintLog=PIGDownMenu(nil,{350,24},fuFrame,{"BOTTOMLEFT",fuFrame,"BOTTOMLEFT",80,10})
fuFrame.taintLog.tishi = fuFrame.taintLog:CreateFontString();
fuFrame.taintLog.tishi:SetPoint("RIGHT", fuFrame.taintLog, "LEFT", 0, 0);
fuFrame.taintLog.tishi:SetFontObject(GameFontNormal);
fuFrame.taintLog.tishi:SetText("污染日志");
function fuFrame.taintLog:PIGDownMenu_Update_But(self)
	local info = {}
	info.func = self.PIGDownMenu_SetValue
	for i=1,#taintlist,1 do
	    info.text, info.arg1 = taintlistmenu[taintlist[i]], taintlist[i]
	    info.checked = taintlist[i]==GetCVar("taintLog")
		fuFrame.taintLog:PIGDownMenu_AddButton(info)
	end 
end
function fuFrame.taintLog:PIGDownMenu_SetValue(value,arg1,arg2)
	fuFrame.taintLog:PIGDownMenu_SetText(value)
	SetCVar("taintLog", arg1)
	PIGCloseDropDownMenus()
end
-----------------
fuFrame:SetScript("OnShow", function()
	for i=1,#CVarsList do
		if GetCVar(CVarsList[i][2])==CVarsList[i][3] then
			_G["ErrCB_"..i]:SetChecked(true);
		end
	end
	if PIG["Error"]["ErrorTishi"] then
		fuFrame.tishiCK:SetChecked(true)
	end
	fuFrame.taintLog:PIGDownMenu_SetText(taintlistmenu[GetCVar("taintLog")])
end);
---创建常用3宏
local hongNameList = {["RL"]={"/Reload",132096},["FST"]={"/fstack",132089},["EVE"]={"/eventtrace",132092}}
fuFrame.New_hong = PIGButton("创建FWR",nil,fuFrame,{100,24},{"LEFT",fuFrame.taintLog,"RIGHT",20,0})
fuFrame.New_hong:SetScript("OnClick", function ()
	for k,v in pairs(hongNameList) do
		local macroSlot = GetMacroIndexByName(k)
		if macroSlot>0 then
			EditMacro(macroSlot, nil, v[2], v[1])
		else
			local global, perChar = GetNumMacros()
			if global<120 then
				CreateMacro(k, v[2], v[1], nil)
			else
				print("|cff00FFFF!Pig:|r|cffFFFF00你的宏数量已达最大值120，请删除一些再尝试。|r");
			end
		end
	end
end)
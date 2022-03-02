local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local fuFrame=Pig_Options_RF_TAB_13_UI
--///////////////////////////////////////////
fuFrame.NPCID = CreateFrame("Button", nil, fuFrame, "UIPanelButtonTemplate");  
fuFrame.NPCID:SetSize(114,24);
fuFrame.NPCID:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-20);
fuFrame.NPCID:SetText("获取目标GUID");
fuFrame.NPCID:SetScript("OnClick", function (self)
	print(UnitGUID("target"))
end);
--==================================================
--启用CPU监控
fuFrame.CPU_OPEN = CreateFrame("Button", nil, fuFrame, "UIPanelButtonTemplate");  
fuFrame.CPU_OPEN:SetSize(110,24);
fuFrame.CPU_OPEN:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-80);
SetCVar("scriptProfile", 0)
fuFrame.CPU_OPEN:SetText("开启CPU监控");
fuFrame.CPU_OPEN:SetScript("OnClick", function (self)
	if self:GetText()=="关闭CPU监控" then
		SetCVar("scriptProfile", 0)
		fuFrame.CPU_OPEN:SetText("开启CPU监控");
	else
		SetCVar("scriptProfile", 1)
		fuFrame.CPU_OPEN:SetText("关闭CPU监控");
	end
end);
fuFrame.CPU_OPEN.CPU_qingling = CreateFrame("Button", nil, fuFrame.CPU_OPEN, "UIPanelButtonTemplate");  
fuFrame.CPU_OPEN.CPU_qingling:SetSize(110,24);
fuFrame.CPU_OPEN.CPU_qingling:SetPoint("LEFT",fuFrame.CPU_OPEN,"RIGHT",20,-0);
fuFrame.CPU_OPEN.CPU_qingling:SetText("清空占用率");
fuFrame.CPU_OPEN.CPU_qingling:SetScript("OnClick", function (self)
	ResetCPUUsage()
end);
fuFrame.CPU_OPEN.CPU_dayin = CreateFrame("Button", nil, fuFrame.CPU_OPEN, "UIPanelButtonTemplate");  
fuFrame.CPU_OPEN.CPU_dayin:SetSize(150,24);
fuFrame.CPU_OPEN.CPU_dayin:SetPoint("LEFT",fuFrame.CPU_OPEN.CPU_qingling,"RIGHT",20,-0);
fuFrame.CPU_OPEN.CPU_dayin:SetText("打印数据到聊天框");
fuFrame.CPU_OPEN.CPU_dayin:SetScript("OnClick", function (self)
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
--------------------------------
fuFrame.errorUI = CreateFrame("Button", nil, fuFrame, "UIPanelButtonTemplate");  
fuFrame.errorUI:SetSize(120,24);
fuFrame.errorUI:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-180);
fuFrame.errorUI:SetText("错误报告");
fuFrame.errorUI:SetScript("OnClick", function (self)
	Pig_OptionsUI:Hide()
	Bugshouji_UI:Show()
end);
--
fuFrame.tishi = fuFrame:CreateFontString();
fuFrame.tishi:SetPoint("LEFT", fuFrame.errorUI, "RIGHT", 6, 0);
fuFrame.tishi:SetFontObject(GameFontNormal);
fuFrame.tishi:SetTextColor(1, 1, 0, 1);
fuFrame.tishi:SetText('打开错误报告指令：/per');

fuFrame.tishiCK = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.tishiCK:SetSize(30,32);
fuFrame.tishiCK:SetHitRectInsets(0,-120,0,0);
fuFrame.tishiCK:SetPoint("LEFT",fuFrame.tishi,"RIGHT",10,-1);
fuFrame.tishiCK.Text:SetText("在小地图图标提示");
fuFrame.tishiCK.tooltip = "发生错误时在小地图图标提示（显示一个X）";
fuFrame.tishiCK:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG["Other"]["ErrorTishi"] = true
	else
		PIG["Other"]["ErrorTishi"] = false
	end
end);

addonTable.Delerror = function()
	if PIG["ErroR"] then
		if #PIG["ErroR"]>0 then
			for i=#PIG["ErroR"],1,-1 do
				if (GetServerTime()-PIG["ErroR"][i][2])>86400 then
					table.remove(PIG["ErroR"],i)
				end
			end
		end
	end
	if PIG["Other"]["ErrorTishi"] then
		fuFrame.tishiCK:SetChecked(true)
	end
end
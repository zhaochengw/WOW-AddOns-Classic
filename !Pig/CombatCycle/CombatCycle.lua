local _, addonTable = ...;
local fuFrame=List_R_F_2_5
local _, _, _, tocversion = GetBuildInfo()
----------------------------------
local CombatCycle=addonTable.CombatCycle
local spellNUM=CombatCycle.spellNUM
local Huoqu_Class_Update=CombatCycle.Huoqu_Class_Update
local ADD_Checkbutton=addonTable.ADD_Checkbutton
---
local function ADD_CombatCycle()
	if CombatCycle_UI then return end
	local CombatCycle = CreateFrame("Frame", "CombatCycle_UI", UIParent)
	CombatCycle.ccSize = PIG_Per.CombatCycle.Size
	CombatCycle.ccjiange = PIG_Per.CombatCycle.jiange
	CombatCycle:SetSize(10,CombatCycle.ccSize)
	local wzinfo = PIG_Per.CombatCycle.Point or {"CENTER","CENTER",-120,0}
	CombatCycle:SetPoint(wzinfo[1],UIParent,wzinfo[2],wzinfo[3], wzinfo[4]);
	CombatCycle:SetMovable(true)
	CombatCycle:SetClampedToScreen(true)	
	CombatCycle.yidong = CreateFrame("Frame", nil, CombatCycle,"BackdropTemplate")
	CombatCycle.yidong:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 6,})
	CombatCycle.yidong:SetBackdropBorderColor(0, 1, 1, 1);
	CombatCycle.yidong:SetAllPoints(CombatCycle)
	if PIG_Per.CombatCycle.suoding then
		CombatCycle.yidong:Hide();
	end
	CombatCycle.yidong:EnableMouse(true)
	CombatCycle.yidong:RegisterForDrag("LeftButton")
	CombatCycle.yidong:SetScript("OnDragStart",function()
		CombatCycle:StartMoving()
	end)
	CombatCycle.yidong:SetScript("OnDragStop",function()
		CombatCycle:StopMovingOrSizing()
		local point, relativeTo, relativePoint, xOfs, yOfs = CombatCycle:GetPoint()
		PIG_Per.CombatCycle.Point={point, relativePoint, xOfs, yOfs};
	end)
	for i=1,spellNUM do
		local CombatCycle_But = CreateFrame("Frame", "CombatCycle_But_"..i, CombatCycle);
		CombatCycle_But:SetSize(CombatCycle.ccSize,CombatCycle.ccSize);
		if i==1 then
			CombatCycle_But:SetPoint("RIGHT",CombatCycle,"LEFT",0,-0);
		else
			CombatCycle_But:SetPoint("RIGHT",_G["CombatCycle_But_"..(i-1)],"LEFT",-CombatCycle.ccjiange,0);
		end
		CombatCycle_But.Tex = CombatCycle_But:CreateTexture(nil, "BORDER");
		CombatCycle_But.Tex:SetAllPoints(CombatCycle_But)
	end

	CombatCycle:RegisterEvent("PLAYER_ENTERING_WORLD")
	CombatCycle:RegisterEvent("PLAYER_TARGET_CHANGED");
	--CombatCycle:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	CombatCycle:RegisterUnitEvent("UNIT_AURA","player")
	CombatCycle:RegisterUnitEvent("UNIT_DISPLAYPOWER", "player");
	CombatCycle:RegisterUnitEvent("UNIT_MAXHEALTH","player");
	if tocversion<40000 then
		CombatCycle:RegisterUnitEvent("UNIT_HEALTH_FREQUENT","player");
	end
	CombatCycle:RegisterUnitEvent("UNIT_MAXPOWER","player");
	CombatCycle:RegisterUnitEvent("UNIT_POWER_FREQUENT","player");

	CombatCycle:RegisterUnitEvent("UNIT_DISPLAYPOWER", "target");
	--CombatCycle:RegisterUnitEvent("UNIT_AURA","target")
	CombatCycle:RegisterUnitEvent("UNIT_MAXHEALTH","target");
	if tocversion<40000 then
		CombatCycle:RegisterUnitEvent("UNIT_HEALTH_FREQUENT","target");
	end
	CombatCycle:RegisterUnitEvent("UNIT_MAXPOWER","target");
	CombatCycle:RegisterUnitEvent("UNIT_POWER_FREQUENT","target");
	CombatCycle:RegisterEvent("PLAYER_TALENT_UPDATE");
	CombatCycle:SetScript("OnEvent",function(self, event)
		if event=="PLAYER_REGEN_DISABLED" then
			CombatCycle:Show()
		end
		if event=="PLAYER_REGEN_ENABLED" then
			CombatCycle:Hide()
		end
		if event=="PLAYER_TALENT_UPDATE" then
			Class_Update=Huoqu_Class_Update()
		end
	end)
	local Class_Update=Huoqu_Class_Update()
	local function CombatCycle_Update()
		if CombatCycle_UI:IsShown() then
			Class_Update()
		end
		C_Timer.After(0.1,CombatCycle_Update)
	end
	CombatCycle_Update()
end
------------
fuFrame.zhiyexunhuan = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"启用输出技能提示","在屏幕上显示职业输出技能提示")
fuFrame.zhiyexunhuan:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per.CombatCycle.Open=true;
		ADD_CombatCycle()
	else
		PIG_Per.CombatCycle.Open=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame.suoding = ADD_Checkbutton(nil,fuFrame,-60,"LEFT",fuFrame.zhiyexunhuan,"RIGHT",180,0,"锁定位置","开启后将锁定位置使其无法拖动")
fuFrame.suoding:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per.CombatCycle.suoding=true;
		CombatCycle_UI.yidong:Hide()
	else
		PIG_Per.CombatCycle.suoding=false;
		CombatCycle_UI.yidong:Show()
	end
end);
fuFrame.zhandouzhong = ADD_Checkbutton(nil,fuFrame,-80,"LEFT",fuFrame.suoding,"RIGHT",120,0,"只在战斗中提示","开启后将只在战斗中提示")
fuFrame.zhandouzhong:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per.CombatCycle.zhandouzhong=true;
		CombatCycle_UI:RegisterEvent("PLAYER_REGEN_DISABLED");
		CombatCycle_UI:RegisterEvent("PLAYER_REGEN_ENABLED");
		if not InCombatLockdown() then
			CombatCycle_UI:Hide()
		end
	else
		PIG_Per.CombatCycle.zhandouzhong=false;
		CombatCycle_UI:UnregisterEvent("PLAYER_REGEN_DISABLED");
		CombatCycle_UI:UnregisterEvent("PLAYER_REGEN_ENABLED");
		CombatCycle_UI:Show()
	end
end);
----
fuFrame.iconSizeT = fuFrame.zhiyexunhuan:CreateFontString();
fuFrame.iconSizeT:SetPoint("TOPLEFT",fuFrame.zhiyexunhuan,"BOTTOMLEFT",10,-20);
fuFrame.iconSizeT:SetFontObject(GameFontNormal);
fuFrame.iconSizeT:SetText('图标大小');
fuFrame.iconSize = CreateFrame("Slider", nil, fuFrame.zhiyexunhuan, "OptionsSliderTemplate")
fuFrame.iconSize.S_min,fuFrame.iconSize.S_max = 18,100
fuFrame.iconSize:SetSize(120,15);
fuFrame.iconSize:SetPoint("LEFT",fuFrame.iconSizeT,"RIGHT",10,0);
fuFrame.iconSize.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.iconSize.Low:SetText(fuFrame.iconSize.S_min);
fuFrame.iconSize.High:SetText(fuFrame.iconSize.S_max);
fuFrame.iconSize:SetMinMaxValues(fuFrame.iconSize.S_min, fuFrame.iconSize.S_max);
fuFrame.iconSize:SetValueStep(1);
fuFrame.iconSize:SetObeyStepOnDrag(true);
fuFrame.iconSize:EnableMouseWheel(true);
fuFrame.iconSize:SetScale(0.9);
fuFrame.iconSize:SetScript("OnMouseWheel", function(self, arg1)
	local sliderMin, sliderMax = self:GetMinMaxValues()
	local value = self:GetValue()
	if arg1 > 0 then
		self:SetValue(min(value + arg1, sliderMax))
	else
		self:SetValue(max(value + arg1, sliderMin))
	end
end)
fuFrame.iconSize:SetScript('OnValueChanged', function(self)
	local val = self:GetValue()
	PIG_Per.CombatCycle.Size=val
	fuFrame.iconSize.Text:SetText(val);
	if CombatCycle_UI then
		CombatCycle_UI.ccSize = val
		CombatCycle_UI:SetHeight(val)
		for i=1,spellNUM do
			_G["CombatCycle_But_"..i]:SetSize(val,val);
		end
	end
end)
--
fuFrame.iconJiangeT = fuFrame.zhiyexunhuan:CreateFontString();
fuFrame.iconJiangeT:SetPoint("LEFT",fuFrame.iconSizeT,"RIGHT",200,0);
fuFrame.iconJiangeT:SetFontObject(GameFontNormal);
fuFrame.iconJiangeT:SetText('图标间隔');
fuFrame.iconJiange = CreateFrame("Slider", nil, fuFrame.zhiyexunhuan, "OptionsSliderTemplate")
fuFrame.iconJiange.S_min,fuFrame.iconJiange.S_max = 0,60
fuFrame.iconJiange:SetSize(120,15);
fuFrame.iconJiange:SetPoint("LEFT",fuFrame.iconJiangeT,"RIGHT",10,0);
fuFrame.iconJiange.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.iconJiange.Low:SetText(fuFrame.iconJiange.S_min);
fuFrame.iconJiange.High:SetText(fuFrame.iconJiange.S_max);
fuFrame.iconJiange:SetMinMaxValues(fuFrame.iconJiange.S_min, fuFrame.iconJiange.S_max);
fuFrame.iconJiange:SetValueStep(1);
fuFrame.iconJiange:SetObeyStepOnDrag(true);
fuFrame.iconJiange:EnableMouseWheel(true);
fuFrame.iconJiange:SetScale(0.9);
fuFrame.iconJiange:SetScript("OnMouseWheel", function(self, arg1)
	local sliderMin, sliderMax = self:GetMinMaxValues()
	local value = self:GetValue()
	if arg1 > 0 then
		self:SetValue(min(value + arg1, sliderMax))
	else
		self:SetValue(max(value + arg1, sliderMin))
	end
end)
fuFrame.iconJiange:SetScript('OnValueChanged', function(self)
	local val = self:GetValue()
	PIG_Per.CombatCycle.jiange=val
	fuFrame.iconJiange.Text:SetText(val);
	if CombatCycle_UI then
		CombatCycle_UI.ccSize = val
		for i=2,spellNUM do
			_G["CombatCycle_But_"..i]:SetPoint("RIGHT",_G["CombatCycle_But_"..(i-1)],"LEFT",-val,0);
		end
	end
end)
---

local Class_ON_hh = 24
local Class_ON=CombatCycle.Class_ON
local xulieheji= Class_ON["id"]
local Class_NR= Class_ON["NR"]
for i=1,#xulieheji do
	local Class_NoOff = CreateFrame("Frame", "Class_NoOff_"..xulieheji[i], fuFrame.zhiyexunhuan)
	Class_NoOff:SetSize(100,Class_ON_hh)
	if i==1 then
		Class_NoOff:SetPoint("TOPLEFT",fuFrame.zhiyexunhuan,"BOTTOMLEFT",0,-70);
	else
		Class_NoOff:SetPoint("TOPLEFT",_G["Class_NoOff_"..(xulieheji[i-1])],"BOTTOMLEFT",0,-2);
	end
	local tianfulist = Class_NR[xulieheji[i]]
	for ii=1,#tianfulist do
		Class_NoOff.qiyong = Class_NoOff:CreateTexture("$parent_"..ii);
		Class_NoOff.qiyong:SetTexture("interface/common/indicator-gray.blp");
		Class_NoOff.qiyong:SetSize(Class_ON_hh,Class_ON_hh);
		Class_NoOff.qiyong:SetPoint("LEFT",Class_NoOff,"LEFT",(ii-1)*180,0);
		Class_NoOff.icon = Class_NoOff:CreateTexture();
		Class_NoOff.icon:SetTexture(tianfulist[ii][1]);
		Class_NoOff.icon:SetSize(Class_ON_hh,Class_ON_hh);
		Class_NoOff.icon:SetPoint("LEFT",Class_NoOff.qiyong,"RIGHT",0,0);
		Class_NoOff.name = Class_NoOff:CreateFontString();
		Class_NoOff.name:SetPoint("LEFT",Class_NoOff.icon,"RIGHT",0,0);
		Class_NoOff.name:SetFontObject(GameFontNormal);
		Class_NoOff.name:SetText(tianfulist[ii][2]);
		if tianfulist[ii][3]~="DAMAGER" then
			Class_NoOff.icon:SetDesaturated(true)
			Class_NoOff.name:SetTextColor(0.8, 0.8, 0.8, 1);
		end
	end
end
------------------
fuFrame:SetScript("OnShow", function (self)
	if tocversion>90000 then
		local xulieheji= Class_ON["id"]
		local Class_NR= Class_ON["NR"]
		for i=1,#xulieheji do	
			local tianfulist = Class_NR[xulieheji[i]]
			for ii=1,#tianfulist do
				local Class_ffff = _G["Class_NoOff_"..i.."_"..ii]
				if tianfulist[ii][4] then
					Class_ffff:SetTexture("interface/common/indicator-green.blp");
				else
					Class_ffff:SetTexture("interface/common/indicator-gray.blp");
				end
			end
		end	
	else       
		fuFrame.zhiyexunhuan:Disable();
	    fuFrame.zhiyexunhuan.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	    fuFrame.suoding:Disable();
	    fuFrame.suoding.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	    fuFrame.zhandouzhong:Disable();
	    fuFrame.zhandouzhong.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	    fuFrame.iconSize:Disable();
	    fuFrame.iconJiange:Disable();
	end
	if PIG_Per.CombatCycle.Open then
		fuFrame.zhiyexunhuan:SetChecked(true)
	end
	if PIG_Per.CombatCycle.suoding then
		fuFrame.suoding:SetChecked(true)
	end
	if PIG_Per.CombatCycle.zhandouzhong then
		fuFrame.zhandouzhong:SetChecked(true)
	end
	fuFrame.iconSize:SetValue(PIG_Per.CombatCycle.Size);
	fuFrame.iconJiange:SetValue(PIG_Per.CombatCycle.jiange);
end);
------------------------
addonTable.CombatCycle = function()
	if PIG_Per.CombatCycle.Open then
		if tocversion>90000 then
			ADD_CombatCycle()
		end
	end
end
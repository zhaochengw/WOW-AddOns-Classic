local _, addonTable = ...;
local fuFrame=List_R_F_2_5
local _, _, _, tocversion = GetBuildInfo()
----------------------------------
local spellNUM=10
local function panduandaxiao(yunsuanfu,biduiV1,biduiV2)
	if yunsuanfu==1 then
		if biduiV1 > biduiV2 then
			return true
		end
	elseif yunsuanfu==2 then
		if biduiV1 >= biduiV2 then
			return true
		end
	elseif yunsuanfu==3 then
		if biduiV1 < biduiV2 then
			return true
		end
	elseif yunsuanfu==4 then
		if biduiV1 <= biduiV2 then
			return true
		end
	elseif yunsuanfu==5 then
		local biduiV1=floor(biduiV1+0.5)
		if biduiV1 == biduiV2 then
			return true
		end
	elseif yunsuanfu==6 then
		local biduiV1=floor(biduiV1+0.5)
		if biduiV1 ~= biduiV2 then
			return true
		end
	end
	return false
end
local function Event_list_1(spid,tjVV)
	if not IsPlayerSpell(spid) then return false end
	if tjVV then
		local usable, noMana = IsUsableSpell(spid)--可用，是否没蓝
		local currentCharges= GetSpellCharges(spid)--充能次数
		if tjVV==1 then--可用时
			if usable and not noMana then
				if currentCharges then
					if currentCharges>0 then
						return true
					end
				else
					local _, GGDCD = GetSpellCooldown(61304)
					if GGDCD==0 then GGDCD=1.5 end
					local start, duration, enabled = GetSpellCooldown(spid)
					if enabled==1 and duration<=GGDCD then
						return true
					end
				end
			end
		elseif tjVV==2 then--不可用
			if usable and not noMana then
				if currentCharges then
					if currentCharges<1 then
						return true
					end
				else
					local _, GGDCD = GetSpellCooldown(61304)
					if GGDCD==0 then GGDCD=1.5 end
					local start, duration, enabled = GetSpellCooldown(spid)
					if enabled==0 or duration>GGDCD then
						return true
					end
				end
			else
				return true
			end
		end
	end
	return false
end
local function Event_list_2(tjVV1,tjVV2,tjVV3,tjVV4)
	if tjVV1 and tjVV2 and tjVV3 and tjVV4 then
		local power = UnitPower("player",tjVV1)
		if tjVV4==1 then
			local biduijieguo=panduandaxiao(tjVV2,power,tjVV3)
			if biduijieguo then return true end
		elseif tjVV4==2 then
			local maxPower = UnitPowerMax("player",tjVV1)
			local baifenbi = (power/maxPower)*100
			local biduijieguo=panduandaxiao(tjVV2,baifenbi,tjVV3)
			if biduijieguo then return true end
		end
	end
	return false
end
local function Event_list_3(tjVV1,tjVV2,tjVV3,tjVV4,tjVV5)
	if tjVV1 and tjVV2 then
		if tjVV3 then
			if GetSpellTexture(tjVV3) then
				local expirationTime=select(6,GetPlayerAuraBySpellID(tjVV3))
				if tjVV2==1 then
					if expirationTime then
						if not tjVV4 or tjVV4==1 then
							return true
						else
							local SYtime=expirationTime-GetTime()
							local biduijieguo=panduandaxiao((tjVV4-1),SYtime,tjVV5)
							if biduijieguo then return true end
						end
					end
				elseif tjVV2==2 then
					if not expirationTime then return true end
				end
			end
		end
	end
	return false
end
local function Event_list_4(tjVV1,tjVV2,tjVV3,tjVV4,tjVV5)
	if tjVV1 and tjVV2 then
		if tjVV3 then
			if GetSpellTexture(tjVV3) then
				local buffcunzai,expirationTimeVVV=nil,nil
				AuraUtil.ForEachAura("target", "HARMFUL", nil, function(name, _, _, _, _, expirationTime, _, _, _, spellId)
					if spellId == tjVV3 then
						buffcunzai=true
						expirationTimeVVV=expirationTime
					else
						buffcunzai=false
					end
				end)
				if tjVV2==2 then
					if not buffcunzai then
						return true
					end
				end
				if tjVV2==1 then
					if buffcunzai and tjVV4 then
						if tjVV4==1 then
							return true
						else
							local SYtime=expirationTimeVVV-GetTime()
							local biduijieguo=panduandaxiao((tjVV4-1),SYtime,tjVV5)
							if biduijieguo then
								return true 
							end
						end	
					end
				end
			end
		end
	end
	return false
end
local function CombatCycle_event()
	if not CombatCycle_UI:IsShown() then return end
	local ccSize = CombatCycle_UI.ccSize
	local shujuD = PIG_Per.CombatCycle.SpellList
	for i=1,spellNUM do
		local fujik = _G["CombatCycle_But_"..i]
		fujik:SetWidth(0.001);
		if shujuD[i] then
			local PIGSCTISHIShowIcon = nil
			local spid = shujuD[i][2]
			local chufainfo = PIG_Per.CombatCycle.SpellList[i][4]
			for ii=1,#chufainfo do
				if chufainfo[ii].Open then
					if ii==1 then
						PIGSCTISHIShowIcon = Event_list_1(spid,chufainfo[ii].tj[1])
						if PIGSCTISHIShowIcon==false then break end
					elseif ii==2 then
						PIGSCTISHIShowIcon = Event_list_2(chufainfo[ii].tj[1],chufainfo[ii].tj[2],chufainfo[ii].tj[3],chufainfo[ii].tj[4])
						if PIGSCTISHIShowIcon==false then break end
					elseif ii==3 then
						PIGSCTISHIShowIcon = Event_list_3(chufainfo[ii].tj[1],chufainfo[ii].tj[2],chufainfo[ii].tj[3],chufainfo[ii].tj[4],chufainfo[ii].tj[5])
						if PIGSCTISHIShowIcon==false then break end
					elseif ii==4 then
						PIGSCTISHIShowIcon = Event_list_4(chufainfo[ii].tj[1],chufainfo[ii].tj[2],chufainfo[ii].tj[3],chufainfo[ii].tj[4],chufainfo[ii].tj[5])
						--print(PIGSCTISHIShowIcon)
						if PIGSCTISHIShowIcon==false then break end
					end
				end
			end
			if PIGSCTISHIShowIcon then
				fujik:SetWidth(ccSize);
				fujik.Tex:SetTexture(GetSpellTexture(spid));
			end
		end
	end
end
addonTable.CombatCycle_event=CombatCycle_event
local function CombatCycle_event_Time()
	CombatCycle_event()
	C_Timer.After(0.1,CombatCycle_event_Time)
end

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

	CombatCycle_event_Time()

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
	CombatCycle:SetScript("OnEvent",function(self, event)
		if event=="PLAYER_REGEN_DISABLED" then
			CombatCycle:Show()
		end
		if event=="PLAYER_REGEN_ENABLED" then
			CombatCycle:Hide()
		end
		CombatCycle_event()
	end)
end
------------
fuFrame.zhiyexunhuan = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.zhiyexunhuan:SetSize(30,30);
fuFrame.zhiyexunhuan:SetHitRectInsets(0,-80,0,0);
fuFrame.zhiyexunhuan:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",10,-10);
fuFrame.zhiyexunhuan.Text:SetText("启用输出技能提示");
fuFrame.zhiyexunhuan.tooltip = "在屏幕上显示职业输出技能提示";
fuFrame.zhiyexunhuan:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per.CombatCycle.Open=true;
		ADD_CombatCycle()
	else
		PIG_Per.CombatCycle.Open=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame.suoding = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.suoding:SetSize(30,30);
fuFrame.suoding:SetHitRectInsets(0,-60,0,0);
fuFrame.suoding:SetPoint("LEFT",fuFrame.zhiyexunhuan.Text,"RIGHT",20,0);
fuFrame.suoding.Text:SetText("锁定位置");
fuFrame.suoding.tooltip = "开启后将锁定位置使其无法拖动";
fuFrame.suoding:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per.CombatCycle.suoding=true;
		CombatCycle_UI.yidong:Hide()
	else
		PIG_Per.CombatCycle.suoding=false;
		CombatCycle_UI.yidong:Show()
	end
end);
fuFrame.zhandouzhong = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.zhandouzhong:SetSize(30,30);
fuFrame.zhandouzhong:SetHitRectInsets(0,-80,0,0);
fuFrame.zhandouzhong:SetPoint("LEFT",fuFrame.suoding.Text,"RIGHT",20,0);
fuFrame.zhandouzhong.Text:SetText("只在战斗中提示");
fuFrame.zhandouzhong.tooltip = "开启后将只在战斗中提示";
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
---
fuFrame.CZinfoBUT = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");  
fuFrame.CZinfoBUT:SetSize(80,20);
fuFrame.CZinfoBUT:SetPoint("TOPRIGHT",fuFrame,"TOPRIGHT",-10,-10);
fuFrame.CZinfoBUT:SetText("重置配置");
fuFrame.CZinfoBUT:SetScript("OnClick", function ()
	StaticPopup_Show ("CZZHIYEXUNHUAN_INFO");
end);
StaticPopupDialogs["CZZHIYEXUNHUAN_INFO"] = {
	text = "此操作将\124cffff0000重置\124r战斗循环配置，需重载界面。\n确定重置?",
	button1 = "确定",
	button2 = "取消",
	OnAccept = function()
		PIG_Per.CombatCycle = addonTable.Default_Per.CombatCycle;
		PIG_Per.CombatCycle.Open = true;
		ReloadUI()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
----
local list_Width=180
local hang_Height=28
local function gengxinhang()
	for id=1,spellNUM do
		local fujik = _G["list_hang_"..id]
		fujik.spell.icon:Hide();
		fujik.spell.Link:SetText("")
		fujik.spell.set.title:SetText("+");
		fujik.spell.set.title:SetTextColor(0, 1, 0, 1);
		fujik.spell.set.title:SetPoint("CENTER", fujik.spell.set, "CENTER", 0, 2);
		local shujuD = PIG_Per.CombatCycle.SpellList
		if shujuD[id] then
			fujik.spell.icon:Show();
			fujik.spell.Link:Show();
			fujik.spell.icon:SetTexture(shujuD[id][1])
			fujik.spell.Link:SetText(shujuD[id][3])
			fujik.spell.set:SetID(id)
			fujik.spell.set.title:SetText("_");
			fujik.spell.set.title:SetTextColor(1, 1, 0, 1);
			fujik.spell.set.title:SetPoint("CENTER", fujik.spell.set, "CENTER", 2, 8);
		end
	end
	if CombatCycle_UI then CombatCycle_event() end
end
fuFrame.list = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate");
fuFrame.list:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12});
fuFrame.list:SetSize(list_Width,hang_Height*spellNUM+6);
fuFrame.list:SetBackdropBorderColor(0, 1, 1, 0.8);
fuFrame.list:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",14,-50);
fuFrame.list.tst = fuFrame.list:CreateFontString();
fuFrame.list.tst:SetPoint("BOTTOM", fuFrame.list, "TOP", 0,0);
fuFrame.list.tst:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
fuFrame.list.tst:SetTextColor(0, 1, 0, 1);
fuFrame.list.tst:SetText("点击技能设置激活条件")
local hangkuandu = fuFrame.list:GetWidth()-6
for id = 1, spellNUM do
	local hang = CreateFrame("Frame", "list_hang_"..id, fuFrame.list,"BackdropTemplate");
	hang:SetSize(hangkuandu, hang_Height);
	if id==1 then
		hang:SetPoint("TOP",fuFrame.list,"TOP",0,-2);
	else
		hang:SetPoint("TOP",_G["list_hang_"..(id-1)],"BOTTOM",0,-0);
	end
	hang.high = hang:CreateTexture(nil, "ARTWORK");
	hang.high:SetTexture(131128);
	hang.high:SetPoint("TOPLEFT",hang,"TOPLEFT",0,-2);
	hang.high:SetPoint("BOTTOMRIGHT",hang,"BOTTOMRIGHT",0,1);
	hang.high:Hide()
	if id~=spellNUM then
		hang.line = hang:CreateLine()
		hang.line:SetColorTexture(0,1,1,0.3)
		hang.line:SetThickness(1);
		hang.line:SetStartPoint("BOTTOMLEFT",0,0)
		hang.line:SetEndPoint("BOTTOMRIGHT",0,0)
	end
	local hangspell_Height = hang_Height-4
	hang.spell = CreateFrame("Frame",nil,hang);
	hang.spell:SetSize(hangkuandu,hangspell_Height);
	hang.spell:SetPoint("LEFT", hang, "LEFT", 2,0);
	hang.spell:SetScript("OnEnter", function (self)
		local shujuD = PIG_Per.CombatCycle.SpellList[id]
		if not shujuD then return end
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:SetSpellByID(shujuD[2]);
		GameTooltip:Show();
	end)
	hang.spell:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	hang.spell:SetScript("OnMouseUp", function (self,button)
		for id = 1, spellNUM do
			_G["list_hang_"..id].high:Hide()
		end
		hang.high:Show()
		fuFrame.trigger.chufaF.bianjiID=id
		fuFrame:Show_TiaoJian(id)
	end);
	hang.spell.icon = hang.spell:CreateTexture(nil, "BORDER");
	hang.spell.icon:SetSize(hangspell_Height,hangspell_Height);
	hang.spell.icon:SetPoint("LEFT",hang.spell,"LEFT",0,0);
	hang.spell.Link = hang.spell:CreateFontString();
	hang.spell.Link:SetPoint("LEFT", hang.spell.icon, "RIGHT", 2,0);
	hang.spell.Link:SetFontObject(GameFontNormal);
	hang.spell.set = CreateFrame("Button",nil,hang.spell);
	hang.spell.set:SetSize(hangspell_Height-4,hangspell_Height-4);
	hang.spell.set:SetPoint("RIGHT", hang.spell, "RIGHT", -4,0);
	hang.spell.set.title = hang.spell.set:CreateFontString();
	hang.spell.set.title:SetPoint("CENTER", hang.spell.set, "CENTER", 0, 2);
	hang.spell.set.title:SetFont(GameFontNormal:GetFont(), 18,"OUTLINE")
	hang.spell.set.title:SetTextColor(0, 1, 0, 1);
	hang.spell.set.title:SetText('+');
	hang.spell.set:SetScript("OnMouseDown", function (self)
		local vvv = self.title:GetText()
		if vvv=="+" then
			self.title:SetPoint("CENTER",-1,1);
		else
			self.title:SetPoint("CENTER",0.5,7);
		end
	end);
	hang.spell.set:SetScript("OnMouseUp", function (self)
		local vvv = self.title:GetText()
		if vvv=="+" then
			self.title:SetPoint("CENTER", 0, 2);
		else
			self.title:SetPoint("CENTER",2,8);
		end
	end);
	hang.spell.set:SetScript("OnClick", function (self)
		local vvv = self.title:GetText()
		fuFrame.trigger:Hide()
		for id = 1, spellNUM do
			_G["list_hang_"..id].high:Hide()
		end
		if vvv=="+" then
			fuFrame.list.ADD.dangqianID=id
			fuFrame.list.ADD:Show()
		else
			PIG_Per.CombatCycle.SpellList[self:GetID()]=nil
			fuFrame.list.ADD:Hide()
			gengxinhang()
		end
	end);
end
----
local S_min,S_max = 18,100
fuFrame.iconSizeT = fuFrame:CreateFontString();
fuFrame.iconSizeT:SetPoint("TOPLEFT",fuFrame.list,"BOTTOMLEFT",0,-12);
fuFrame.iconSizeT:SetFontObject(GameFontNormal);
fuFrame.iconSizeT:SetText('图标大小');
fuFrame.iconSize = CreateFrame("Slider", nil, fuFrame, "OptionsSliderTemplate")
fuFrame.iconSize:SetSize(120,15);
fuFrame.iconSize:SetPoint("LEFT",fuFrame.iconSizeT,"RIGHT",10,0);
fuFrame.iconSize.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.iconSize.Low:SetText(S_min);
fuFrame.iconSize.High:SetText(S_max);
fuFrame.iconSize:SetMinMaxValues(S_min, S_max);
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
		CombatCycle_event() 
		for i=1,spellNUM do
			_G["CombatCycle_But_"..i]:SetHeight(val);
		end
	end
end)
--------------
local triggerW,triggerH,triggerNum = fuFrame:GetWidth()-list_Width-30,fuFrame:GetHeight()-60,4
fuFrame.trigger = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate");
fuFrame.trigger:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12});
fuFrame.trigger:SetSize(triggerW,triggerH);
fuFrame.trigger:SetBackdropBorderColor(0, 1, 1, 0.8);
fuFrame.trigger:SetPoint("TOPRIGHT",fuFrame,"TOPRIGHT",-10,-50);
fuFrame.trigger:Hide()
fuFrame.trigger.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.trigger, "UIPanelScrollFrameTemplate");  
fuFrame.trigger.Scroll:SetPoint("TOPLEFT",fuFrame.trigger,"TOPLEFT",6,-6);
fuFrame.trigger.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.trigger,"BOTTOMRIGHT",-26,5);
fuFrame.trigger.chufaF = CreateFrame("Frame", nil, fuFrame.trigger.scroll)
fuFrame.trigger.chufaF:SetWidth(fuFrame.trigger.Scroll:GetWidth())
fuFrame.trigger.chufaF:SetHeight(10) 
fuFrame.trigger.Scroll:SetScrollChild(fuFrame.trigger.chufaF)
---触发条件
local tianjianF = fuFrame.trigger.chufaF
--条件1
local ADD_CheckBut = addonTable.ADD_CheckBut
local ADD_FontString=addonTable.ADD_FontString
local ADD_DropDownMenu = addonTable.ADD_DropDownMenu
local ADD_EditBox=addonTable.ADD_EditBox
local ADD_Button=addonTable.ADD_Button
local tjID_1 = 1
tianjianF.tj_1_Open =ADD_CheckBut(tianjianF,nil,4,4,tjID_1,CombatCycle_event)
local tjID_1_listDd1 = {"当技能可用时","当技能不可用时"};
tianjianF.tj_1_1 =ADD_DropDownMenu(tianjianF,160,nil,"TOPLEFT",tianjianF.tj_1_Open,"BOTTOMLEFT",20,2,tjID_1,1,tjID_1_listDd1)
--2
local tjID_2 = 2
tianjianF.tj_2_Open =ADD_CheckBut(tianjianF,nil,4,80,tjID_2)
tianjianF.tj_2_1=ADD_FontString(tianjianF,nil,nil,"TOPLEFT", tianjianF.tj_2_Open, "BOTTOMLEFT", 10,-8,tjID_2,14,'当')
--local ziyuuanV = Enum.PowerType--Value,Key
local tjID_2_list2 = {
	{"法力值","0","Mana"},{"怒气值","1","Rage"},{"集中值","2","Focus"},
	{"能量值","3","Energy"},{"连击点","4","ComboPoints"},{"符文","5","Runes"},
	{"符文能量","6","RunicPower"},{"灵魂碎片","7","SoulShards"},{"星界能量","8","LunarPower"},
	{"神圣能量","9","HolyPower"},{"漩涡能量","11","Maelstrom"},{"真气","12","Chi"},
	{"狂乱","13","Insanity"},{"奥术充能","16","ArcaneCharges"},{"恶魔之怒","17","Fury"},
	{"痛苦值","18","Pain"},
}
tianjianF.tj_2_2 =ADD_DropDownMenu(tianjianF,120,nil,"LEFT",tianjianF.tj_2_1,"RIGHT",0,0,tjID_2,1,tjID_2_list2)
--<>=
local tjID_2_list3 = {">",">=","<","<=","=","!="}
tianjianF.tj_2_3 =ADD_DropDownMenu(tianjianF,80,nil,"LEFT",tianjianF.tj_2_2,"RIGHT",0,0,tjID_2,2,tjID_2_list3)

tianjianF.tj_2_4 =ADD_EditBox(tianjianF,120,nil,"TOPLEFT",tianjianF.tj_2_2,"BOTTOMLEFT",8,-4,tjID_2,3,10)

local tjID_2_list5 = {"值","%"}
tianjianF.tj_2_5 =ADD_DropDownMenu(tianjianF,70,nil,"LEFT",tianjianF.tj_2_4,"RIGHT",2,0,tjID_2,4,tjID_2_list5)

--3
local tjID_3 = 3
tianjianF.tj_3_Open =ADD_CheckBut(tianjianF,nil,4,190,tjID_3)
tianjianF.tj_3_1=ADD_FontString(tianjianF,nil,nil,"TOPLEFT", tianjianF.tj_3_Open, "BOTTOMLEFT", 10,-8,tjID_3,14,'当下方|cffFFFF00自身|r')
local tjID_3_list2 = {"BUFF","DEBUFF"}
tianjianF.tj_3_2 =ADD_DropDownMenu(tianjianF,100,nil,"LEFT",tianjianF.tj_3_1,"RIGHT",0,0,tjID_3,1,tjID_3_list2)
local tjID_3_list3 = {"存在","不存在"}
tianjianF.tj_3_3 =ADD_DropDownMenu(tianjianF,90,nil,"LEFT",tianjianF.tj_3_2,"RIGHT",0,0,tjID_3,2,tjID_3_list3)

tianjianF.tj_3_4 =ADD_Button(tianjianF,20,20,"TOPLEFT",tianjianF.tj_3_1,"BOTTOMLEFT",54,-10)
tianjianF.tj_3_4.E =ADD_EditBox(tianjianF,150,nil,"LEFT",tianjianF.tj_3_4,"RIGHT",6,0,tjID_3,3,16,tianjianF.tj_3_4)
tianjianF.tj_3_5=ADD_FontString(tianjianF,nil,nil,"TOPLEFT", tianjianF.tj_3_1, "BOTTOMLEFT", 0,-40,tjID_3,14,'且剩余时间')
local tjID_3_list6 = {"无限制",">",">=","<","<=","=","!="}
tianjianF.tj_3_6 =ADD_DropDownMenu(tianjianF,100,nil,"LEFT",tianjianF.tj_3_5,"RIGHT",0,0,tjID_3,4,tjID_3_list6)
tianjianF.tj_3_7 =ADD_EditBox(tianjianF,70,nil,"LEFT",tianjianF.tj_3_6,"RIGHT",6,0,tjID_3,5,5)
tianjianF.tj_3_8=ADD_FontString(tianjianF,nil,nil,"LEFT", tianjianF.tj_3_7, "RIGHT", 0,0,tjID_3,14,'秒')

--4
local tjID_4 = 4
tianjianF.tj_4_Open =ADD_CheckBut(tianjianF,nil,4,330,tjID_4)
tianjianF.tj_4_1=ADD_FontString(tianjianF,nil,nil,"TOPLEFT", tianjianF.tj_4_Open, "BOTTOMLEFT", 10,-8,tjID_4,14,'当下方|cffFF0000目标|r')
local tjID_4_list2 = {"BUFF","DEBUFF"}
tianjianF.tj_4_2 =ADD_DropDownMenu(tianjianF,100,nil,"LEFT",tianjianF.tj_4_1,"RIGHT",0,0,tjID_4,1,tjID_4_list2)
local tjID_4_list3 = {"存在","不存在"}
tianjianF.tj_4_3 =ADD_DropDownMenu(tianjianF,90,nil,"LEFT",tianjianF.tj_4_2,"RIGHT",0,0,tjID_4,2,tjID_4_list3)

tianjianF.tj_4_4 =ADD_Button(tianjianF,20,20,"TOPLEFT",tianjianF.tj_4_1,"BOTTOMLEFT",54,-10)
tianjianF.tj_4_4.E =ADD_EditBox(tianjianF,150,nil,"LEFT",tianjianF.tj_4_4,"RIGHT",6,0,tjID_4,3,16,tianjianF.tj_4_4)
tianjianF.tj_4_5=ADD_FontString(tianjianF,nil,nil,"TOPLEFT", tianjianF.tj_4_1, "BOTTOMLEFT", 0,-40,tjID_4,14,'且剩余时间')
local tjID_4_list6 = {"无限制",">",">=","<","<=","=","!="}
tianjianF.tj_4_6 =ADD_DropDownMenu(tianjianF,100,nil,"LEFT",tianjianF.tj_4_5,"RIGHT",0,0,tjID_4,4,tjID_4_list6)
tianjianF.tj_4_7 =ADD_EditBox(tianjianF,70,nil,"LEFT",tianjianF.tj_4_6,"RIGHT",6,0,tjID_4,5,5)
tianjianF.tj_4_8=ADD_FontString(tianjianF,nil,nil,"LEFT", tianjianF.tj_4_7, "RIGHT", 0,0,tjID_4,14,'秒')

--9999
tianjianF.tj9999 = tianjianF:CreateFontString();
tianjianF.tj9999:SetPoint("TOPLEFT", tianjianF, "TOPLEFT", 4,-1300);
tianjianF.tj9999:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
tianjianF.tj9999:SetTextColor(1, 1, 0, 1);
tianjianF.tj9999:SetText('到底了！');
-----
function fuFrame:Show_TiaoJian(id)
	local Spellinfo = PIG_Per.CombatCycle.SpellList[id]
	if Spellinfo then
		local chufainfo = Spellinfo[4]
		--1-1
		chufainfo[1]=chufainfo[1] or {["Open"]=false,["tj"]={}}
		tianjianF.tj_1_Open:SetChecked(chufainfo[1]["Open"])
		UIDropDownMenu_Initialize(tianjianF.tj_1_1.DD,function(self)
			local info = UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			for i=1,#tjID_1_listDd1,1 do
			    info.text, info.arg1, info.arg2, info.checked = tjID_1_listDd1[i], i, tjID_1_listDd1[i], i == chufainfo[1]["tj"][1];
				UIDropDownMenu_AddButton(info)
			end 
		end)
		UIDropDownMenu_SetText(tianjianF.tj_1_1.DD, tjID_1_listDd1[chufainfo[1]["tj"][1]])
		--2-1
		local evID = 2
		chufainfo[evID]=chufainfo[evID] or {["Open"]=false,["tj"]={}}
		tianjianF.tj_2_Open:SetChecked(chufainfo[evID]["Open"])
		UIDropDownMenu_Initialize(tianjianF.tj_2_2.DD, function (self)
			local info = UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			for i=1,#tjID_2_list2 do
				info.text, info.arg1, info.arg2, info.checked = tjID_2_list2[i][1], tjID_2_list2[i][2],tjID_2_list2[i][1], tjID_2_list2[i][2] == chufainfo[evID]["tj"][1];
				UIDropDownMenu_AddButton(info)
			end 
		end)
		if chufainfo[evID]["tj"][1] then
			for i=1,#tjID_2_list2 do
				if tjID_2_list2[i][2]==chufainfo[evID]["tj"][1] then
					UIDropDownMenu_SetText(tianjianF.tj_2_2.DD, tjID_2_list2[i][1])
					break
				end
			end
		else
			UIDropDownMenu_SetText(tianjianF.tj_2_2.DD, "")
		end
		--2-2
		UIDropDownMenu_Initialize(tianjianF.tj_2_3.DD, function(self)
			local info = UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			for i=1,#tjID_2_list3 do
				info.text, info.arg1, info.arg2, info.checked = tjID_2_list3[i], i,tjID_2_list3[i], i == chufainfo[evID]["tj"][2];
				UIDropDownMenu_AddButton(info)
			end 
		end)
		UIDropDownMenu_SetText(tianjianF.tj_2_3.DD, tjID_2_list3[chufainfo[evID]["tj"][2]])
		--2-3
		local shubv23 = chufainfo[evID]["tj"][3] or ""
		tianjianF.tj_2_4:SetText(shubv23)
		--2-4
		UIDropDownMenu_Initialize(tianjianF.tj_2_5.DD, function(self)
			local info = UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			for i=1,#tjID_2_list5 do
				info.text, info.arg1, info.arg2, info.checked = tjID_2_list5[i], i,tjID_2_list5[i], i == chufainfo[evID]["tj"][4];
				UIDropDownMenu_AddButton(info)
			end 
		end)
		UIDropDownMenu_SetText(tianjianF.tj_2_5.DD, tjID_2_list5[chufainfo[evID]["tj"][4]])
		--3
		local evID3 = 3
		chufainfo[evID3]=chufainfo[evID3] or {["Open"]=false,["tj"]={}}
		tianjianF.tj_3_Open:SetChecked(chufainfo[evID3]["Open"])
		--3-1
		UIDropDownMenu_Initialize(tianjianF.tj_3_2.DD, function(self)
			local info = UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			for i=1,#tjID_3_list2 do
				 info.text, info.arg1,info.arg2,info.checked = tjID_3_list2[i], i,tjID_3_list2[i], i == chufainfo[evID3]["tj"][1];
				UIDropDownMenu_AddButton(info)
			end 
		end)
		UIDropDownMenu_SetText(tianjianF.tj_3_2.DD, tjID_3_list2[chufainfo[evID3]["tj"][1]])
		--3-2
		UIDropDownMenu_Initialize(tianjianF.tj_3_3.DD, function(self)
			local info = UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			for i=1,#tjID_3_list3 do
				 info.text, info.arg1,info.arg2,info.checked = tjID_3_list3[i], i,tjID_3_list3[i], i == chufainfo[evID3]["tj"][2];
				UIDropDownMenu_AddButton(info)
			end 
		end)
		UIDropDownMenu_SetText(tianjianF.tj_3_3.DD, tjID_3_list3[chufainfo[evID3]["tj"][2]])
		--3-3
		local function gengxinBUFFshow(frame1,buffid)
			local spellid = buffid or 0
			frame1:Hide()
			frame1.E:SetText("")
			if spellid>0 then
				frame1.E:SetText(spellid)
				local cunzai = GetSpellTexture(spellid)
				if cunzai then
					frame1:Show()
					frame1:SetNormalTexture(GetSpellTexture(spellid))
					frame1:SetID(spellid)
				end
			end
		end
		gengxinBUFFshow(tianjianF.tj_3_4,chufainfo[evID3]["tj"][3])
		--3-4
		UIDropDownMenu_Initialize(tianjianF.tj_3_6.DD, function(self)
			local info = UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			for i=1,#tjID_3_list6 do
				 info.text, info.arg1,info.arg2,info.checked = tjID_3_list6[i], i,tjID_3_list6[i], i == chufainfo[evID3]["tj"][4];
				UIDropDownMenu_AddButton(info)
			end 
		end)
		UIDropDownMenu_SetText(tianjianF.tj_3_6.DD, tjID_3_list6[chufainfo[evID3]["tj"][4]])
		--3-5
		local shubv35 = chufainfo[evID3]["tj"][5] or 0
		tianjianF.tj_3_7:SetText(shubv35)
		--4
		local evID4 = 4
		chufainfo[evID4]=chufainfo[evID4] or {["Open"]=false,["tj"]={}}
		tianjianF.tj_4_Open:SetChecked(chufainfo[evID4]["Open"])
		--4-1
		UIDropDownMenu_Initialize(tianjianF.tj_4_2.DD, function(self)
			local info = UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			for i=1,#tjID_4_list2 do
				 info.text, info.arg1,info.arg2,info.checked = tjID_4_list2[i], i,tjID_4_list2[i], i == chufainfo[evID4]["tj"][1];
				UIDropDownMenu_AddButton(info)
			end 
		end)
		UIDropDownMenu_SetText(tianjianF.tj_4_2.DD, tjID_4_list2[chufainfo[evID4]["tj"][1]])
		--4-2
		UIDropDownMenu_Initialize(tianjianF.tj_4_3.DD, function(self)
			local info = UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			for i=1,#tjID_4_list3 do
				 info.text, info.arg1,info.arg2,info.checked = tjID_4_list3[i], i,tjID_4_list3[i], i == chufainfo[evID4]["tj"][2];
				UIDropDownMenu_AddButton(info)
			end 
		end)
		UIDropDownMenu_SetText(tianjianF.tj_4_3.DD, tjID_4_list3[chufainfo[evID4]["tj"][2]])
		--4-3
		gengxinBUFFshow(tianjianF.tj_4_4,chufainfo[evID4]["tj"][3])
		--4-4
		UIDropDownMenu_Initialize(tianjianF.tj_4_6.DD, function(self)
			local info = UIDropDownMenu_CreateInfo()
			info.func = self.SetValue
			for i=1,#tjID_4_list6 do
				 info.text, info.arg1,info.arg2,info.checked = tjID_4_list6[i], i,tjID_4_list6[i], i == chufainfo[evID4]["tj"][4];
				UIDropDownMenu_AddButton(info)
			end 
		end)
		UIDropDownMenu_SetText(tianjianF.tj_4_6.DD, tjID_4_list6[chufainfo[evID4]["tj"][4]])
		--4-5
		local shubv45 = chufainfo[evID4]["tj"][5] or 0
		tianjianF.tj_4_7:SetText(shubv45)
		-------
		fuFrame.trigger:Show()
	else
		fuFrame.trigger:Hide()
	end
end
--------------
fuFrame.list.ADD = CreateFrame("Frame", nil, fuFrame.list,"BackdropTemplate");
local SPF = fuFrame.list.ADD
SPF:SetBackdrop({bgFile = "interface/characterframe/ui-party-background.blp",edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12});
SPF:SetSize(fuFrame:GetWidth()-list_Width-30,fuFrame:GetHeight()-58);
SPF:SetBackdropBorderColor(0, 1, 1, 0.8);
SPF:SetPoint("TOPLEFT",fuFrame.list,"TOPRIGHT",4,0);
SPF:SetFrameLevel(10)
SPF:Hide();
SPF.Close = CreateFrame("Button",nil,SPF, "UIPanelCloseButton");  
SPF.Close:SetSize(26,26);
SPF.Close:SetPoint("TOPRIGHT",SPF,"TOPRIGHT",2,1);
SPF.biaoti = SPF:CreateFontString();
SPF.biaoti:SetPoint("TOP",SPF,"TOP",0,-4);
SPF.biaoti:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
SPF.biaoti:SetTextColor(0, 1, 0, 1);
SPF.biaoti:SetText("请选择要提示的技能:");
SPF.F = CreateFrame("Frame", nil, SPF);
SPF.F:SetPoint("TOPLEFT",SPF,"TOPLEFT",4,-22);
SPF.F:SetPoint("BOTTOMRIGHT",SPF,"BOTTOMRIGHT",-4,4);
local xzSize,WWjiange,HHjiange,meihang,hangNum = 34,120,8,2,8
local xianshiNUM = meihang*hangNum
for i=1,xianshiNUM do
	local SPF_F_But = CreateFrame("Button", "SPF_F_But_"..i, SPF.F);
	SPF_F_But:SetSize(xzSize,xzSize);
	if i==1 then
		SPF_F_But:SetPoint("TOPLEFT",SPF.F,"TOPLEFT",8,-2);
	else
		local tmp1,tmp2 = math.modf(i/meihang)
		if tmp2>0 then
			SPF_F_But:SetPoint("TOPLEFT",_G["SPF_F_But_"..(i-meihang)],"BOTTOMLEFT",0,-HHjiange);	
		else
			SPF_F_But:SetPoint("LEFT",_G["SPF_F_But_"..(i-1)],"RIGHT",WWjiange,0);
		end
	end
	SPF_F_But.Down = SPF_F_But:CreateTexture(nil, "OVERLAY");
	SPF_F_But.Down:SetTexture(130839);
	SPF_F_But.Down:SetAllPoints(SPF_F_But)
	SPF_F_But.Down:Hide();
	SPF_F_But:SetScript("OnMouseDown", function (self)
		self.Down:Show();
	end);
	SPF_F_But:SetScript("OnMouseUp", function (self)
		self.Down:Hide();
	end);
	SPF_F_But:SetScript("OnClick", function (self)
		local dangqianID=fuFrame.list.ADD.dangqianID
		PIG_Per.CombatCycle.SpellList[dangqianID]={self.Bookicon,self.BookSpID,self.BookSpName,{}}
		fuFrame.list.ADD:Hide()
		gengxinhang()
	end);
	SPF_F_But.Tex = SPF_F_But:CreateTexture(nil, "BORDER");
	SPF_F_But.Tex:SetAllPoints(SPF_F_But)
	SPF_F_But.SPname = SPF_F_But:CreateFontString();
	SPF_F_But.SPname:SetPoint("LEFT",SPF_F_But,"RIGHT",2,0);
	SPF_F_But.SPname:SetFontObject(GameFontNormal);
end
SPF.F.prev = CreateFrame("Button",nil,SPF.F);
SPF.F.prev:SetNormalTexture("interface/buttons/ui-spellbookicon-prevpage-up.blp")
SPF.F.prev:SetPushedTexture("interface/buttons/ui-spellbookicon-prevpage-down.blp")
SPF.F.prev:SetDisabledTexture("interface/buttons/ui-spellbookicon-prevpage-disabled.blp")
SPF.F.prev:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
SPF.F.prev:SetSize(30,30);
SPF.F.prev:SetPoint("BOTTOM",SPF.F,"BOTTOM",-40,-2);

SPF.F.page = SPF:CreateFontString();
SPF.F.page:SetPoint("BOTTOM",SPF.F,"BOTTOM",0,5);
SPF.F.page:SetFontObject(GameFontNormal);
SPF.F.page:SetText("0/0");

SPF.F.next = CreateFrame("Button",nil,SPF.F);
SPF.F.next:SetNormalTexture("interface/buttons/ui-spellbookicon-nextpage-up.blp")
SPF.F.next:SetPushedTexture("interface/buttons/ui-spellbookicon-nextpage-down.blp")
SPF.F.next:SetDisabledTexture("interface/buttons/ui-spellbookicon-nextpage-disabled.blp")
SPF.F.next:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
SPF.F.next:SetSize(30,30);
SPF.F.next:SetPoint("BOTTOM",SPF.F,"BOTTOM",40,-2);
------
local function shauxin_Show(self,zengjia)
	local shujuD=self.yixueSpellList
	local yeshu=math.ceil(#shujuD/(xianshiNUM))
	if zengjia=="+" then
		self.idd=self.idd+1
		if self.idd>yeshu then self.idd=yeshu end
	elseif zengjia=="-" then
		self.idd=self.idd-1
		if self.idd<1 then self.idd=1 end
	end
	local idd=self.idd
	SPF.F.page:SetText(idd.."/"..yeshu);
	SPF.F.prev:Enable() SPF.F.next:Enable() 
	if idd==1 then
		SPF.F.prev:Disable()
	end
	if idd==yeshu then
		SPF.F.next:Disable()
	end
	for i=1,xianshiNUM do
		local fujiK = _G["SPF_F_But_"..i]
		fujiK.Tex:SetTexture()
		fujiK.SPname:SetText()
		local x = i+(idd-1)*xianshiNUM
		if shujuD[x] then
			fujiK.Bookicon=shujuD[x][1]
			fujiK.BookSpID=shujuD[x][2]
			fujiK.BookSpName=shujuD[x][3]
			fujiK.Tex:SetTexture(shujuD[x][1])
			fujiK.SPname:SetText(shujuD[x][3])
			fujiK:SetScript("OnEnter", function (self)
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",xzSize,0);
				GameTooltip:SetSpellByID(shujuD[x][2]);
				GameTooltip:Show();
			end)
			fujiK:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
		end
	end
end
--
local function huoquSpellInfo(self)
	self.yixueSpellList = {}
	if tocversion>40000 then
		local specID = GetSpecialization()
		local _, ZYname = GetSpecializationInfo(specID)
		local numTabs = GetNumSpellTabs()
		for i=1,numTabs do
			local name, texture, tabOffset, numEntries = GetSpellTabInfo(i)
			for ii=tabOffset + 1, tabOffset + numEntries do
				local spellType, spellID = GetSpellBookItemInfo(ii, BOOKTYPE_SPELL)
				if spellType=="SPELL" then
					local isPassive = IsPassiveSpell(ii, BOOKTYPE_SPELL)
					if not isPassive then
						local spellName, spellSubName = GetSpellBookItemName(ii, BOOKTYPE_SPELL)
						if spellSubName~="战斗宠物" and spellSubName~="公会福利" then
							--print(spellName,spellSubName)
							local icon = GetSpellBookItemTexture(ii, BOOKTYPE_SPELL)
							table.insert(self.yixueSpellList,{icon,spellID,spellName})
						end
					end
				end
			end
			if ZYname==name then return end
		end
	else
		local numTabs = GetNumSpellTabs()
		for i=1,numTabs do
			local name, texture, tabOffset, numEntries = GetSpellTabInfo(i)
			for ii=tabOffset + 1, tabOffset + numEntries do
				local spellName, spellSubName, spellID = GetSpellBookItemName(ii, BOOKTYPE_SPELL)
				if spellID and IsPlayerSpell(spellID) then
					local isPassive = IsPassiveSpell(ii, BOOKTYPE_SPELL)
					if not isPassive then
					   	if spellName~="分解" and spellName~="基础营火" and spellName~="寻找矿物" and spellName~="寻找草药" and spellName~="熔炼" then	
							if spellSubName~="战斗宠物" and spellSubName~="公会福利" and spellSubName~="初级" and spellSubName~="中级" and spellSubName~="高级" and spellSubName~="专家级" and spellSubName~="大师级" and spellSubName~="宗师级" then
								--print(spellName,spellSubName)
								local icon = GetSpellBookItemTexture(ii, BOOKTYPE_SPELL)
								table.insert(self.yixueSpellList,{icon,spellID,spellName})
							end
						end
					end
				end
			end
		end
	end
end
SPF.F.prev:SetScript("OnClick", function(self)
	local fuji = self:GetParent()
	shauxin_Show(fuji,"-")
end)
SPF.F.next:SetScript("OnClick", function(self)
	local fuji = self:GetParent()
	shauxin_Show(fuji,"+")
end)
SPF.F:SetScript("OnShow", function (self)
	if not self.idd then self.idd=1 end
	huoquSpellInfo(self)
	shauxin_Show(self)
end);
SPF.F:SetScript("OnHide", function (self)
	for id = 1, spellNUM do
		_G["list_hang_"..id].high:Hide()
	end
end);

------------------
fuFrame:SetScript("OnShow", function (self)
	if PIG_Per.CombatCycle.Open then
		fuFrame.zhiyexunhuan:SetChecked(true)
	end
	if PIG_Per.CombatCycle.suoding then
		fuFrame.suoding:SetChecked(true)
	end
	if PIG_Per.CombatCycle.zhandouzhong then
		fuFrame.zhandouzhong:SetChecked(true)
	end
	gengxinhang()
	fuFrame.iconSize:SetValue(PIG_Per.CombatCycle.Size);
end);
fuFrame:SetScript("OnHide", function (self)
	fuFrame.list.ADD:Hide()
end);
------------------------
addonTable.CombatCycle = function()
	PIG_Per.CombatCycle=PIG_Per.CombatCycle or addonTable.Default_Per.CombatCycle
	if PIG_Per.CombatCycle.Open then
		ADD_CombatCycle()
	end
end
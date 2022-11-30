local _, addonTable = ...;
local ADD_Checkbutton=addonTable.ADD_Checkbutton
---------.
local tabID = 1;
local tabName = _G["SpellJK.F_TAB_"..tabID].title:GetText();
local fuFrame=_G["SpellJK_F_TabFrame_"..tabID]

--======================================================================
local jiankongNUM=10
--监控事件
local function zishenBUFF_event()
	local shujuy=PIG_Per['SpellJK']["Spell_list"][tabID]
	for i=1,jiankongNUM do
		local fujik = _G["zishenBUFF_But_"..i]
		fujik:Hide();
		if shujuy[i] then
			fujik:Show();
			fujik.Tex:SetTexture(shujuy[i][3]);
			for ii=1,36 do
				local _,_,_,_,_,_,_,_,_,spellId = UnitBuff("player", ii)
				if not spellId then break end
				if shujuy[i][1]==spellId then
					fujik:Hide();
				end
			end
		end
	end
end
--监控UI
local function zishenBUFF_ADD()
	if PIG_Per['SpellJK']["Open"][tabID]=="ON" and zishenBUFF_UI==nil then
		local zishenBUFF = CreateFrame("Frame", "zishenBUFF_UI", UIParent)
		zishenBUFF:SetSize(16,PIG_Per['SpellJK']["WHF_list"][tabID]["H"])
		zishenBUFF:SetPoint("CENTER",UIParent,"CENTER",-100,-100);
		zishenBUFF:SetMovable(true)
		zishenBUFF:SetClampedToScreen(true)	
		zishenBUFF.yidong = CreateFrame("Frame", nil, zishenBUFF,"BackdropTemplate")
		zishenBUFF.yidong:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 6,})
		zishenBUFF.yidong:SetAllPoints(zishenBUFF)
		zishenBUFF.yidong:Hide();
		zishenBUFF.yidong:EnableMouse(true)
		zishenBUFF.yidong:RegisterForDrag("LeftButton")
		zishenBUFF.yidong.t = zishenBUFF.yidong:CreateFontString();
		zishenBUFF.yidong.t:SetPoint("LEFT", zishenBUFF.yidong, "LEFT", -8, 0);
		zishenBUFF.yidong.t:SetFontObject(GameFontNormal);
		zishenBUFF.yidong.t:SetTextColor(0.8, 0.8, 0.8, 0.6);
		zishenBUFF.yidong.t:SetText("自\n身");
		zishenBUFF.yidong:SetScript("OnDragStart",function()
			zishenBUFF:StartMoving()
		end)
		zishenBUFF.yidong:SetScript("OnDragStop",function()
			zishenBUFF:StopMovingOrSizing()
		end)
		for i=1,jiankongNUM do
			zishenBUFF.But = CreateFrame("Frame", "zishenBUFF_But_"..i, zishenBUFF);
			zishenBUFF.But:SetSize(PIG_Per['SpellJK']["WHF_list"][tabID]["W"],PIG_Per['SpellJK']["WHF_list"][tabID]["H"]);
			if i==1 then
				zishenBUFF.But:SetPoint("LEFT",zishenBUFF,"RIGHT",6,-0);
			else
				zishenBUFF.But:SetPoint("LEFT",_G["zishenBUFF_But_"..(i-1)],"RIGHT",6,0);
			end
			zishenBUFF.But.Tex = zishenBUFF.But:CreateTexture(nil, "BORDER");
			zishenBUFF.But.Tex:SetAllPoints(zishenBUFF.But)
		end
		zishenBUFF_event()
		zishenBUFF:RegisterEvent("PLAYER_ENTERING_WORLD")
		zishenBUFF:RegisterEvent("UNIT_AURA","player")
		zishenBUFF:SetScript("OnEvent",function(self, event)
			zishenBUFF_event()
		end)
	end
end
--======================================================================
--设置界面
local list_Width,list_Height=220,372
local hang_Height,hang_Num=28,13
local function gengxinhang(self)
	for id = 1, hang_Num do
	    _G["list_"..tabID.."_hang_"..id]:Hide();
	end
	local ItemsNum = #PIG_Per['SpellJK']["Spell_list"][tabID];
	if ItemsNum>0 then
	    FauxScrollFrame_Update(self, ItemsNum, hang_Num, hang_Height);
	    local offset = FauxScrollFrame_GetOffset(self);
	    for id = 1, hang_Num do
			local dangqian = id+offset;
			if PIG_Per['SpellJK']["Spell_list"][tabID][dangqian] then
				_G["list_"..tabID.."_hang_"..id]:Show();
				_G["list_"..tabID.."_hang_"..id].icon:SetTexture(PIG_Per['SpellJK']["Spell_list"][tabID][dangqian][3]);
				_G["list_"..tabID.."_hang_"..id].Link:SetText(PIG_Per['SpellJK']["Spell_list"][tabID][dangqian][4]);
				_G["list_"..tabID.."_hang_"..id].LinkF:SetScript("OnEnter", function (self)
					GameTooltip:ClearLines();
					GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",2,4);
					GameTooltip:SetHyperlink("spell:"..PIG_Per['SpellJK']["Spell_list"][tabID][dangqian][1])
					GameTooltip:Show();
				end);
				_G["list_"..tabID.."_hang_"..id].LinkF:SetScript("OnLeave", function ()
					GameTooltip:ClearLines();
					GameTooltip:Hide() 
				end);
				_G["list_"..tabID.."_hang_"..id].LinkF:SetScript("OnMouseUp", function (self)
					local aShiftKeyIsDown = IsShiftKeyDown();
					if aShiftKeyIsDown then
						local editBox = ChatEdit_ChooseBoxForSend();
						local hasText = editBox:GetText()..PIG_Per['SpellJK']["Spell_list"][tabID][dangqian][4]
						if editBox:HasFocus() then
							editBox:SetText(hasText);
						else
							ChatEdit_ActivateChat(editBox)
							editBox:SetText(hasText);
						end
					end
				end);
				_G["list_"..tabID.."_hang_"..id].del:SetID(dangqian)
			end
		end
	end
end
---------
fuFrame.list = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate");
fuFrame.list:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 14});
fuFrame.list:SetSize(list_Width,list_Height);
fuFrame.list:SetBackdropBorderColor(1, 1, 1, 0.8);
fuFrame.list:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-40);
fuFrame.list.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.list, "FauxScrollFrameTemplate");  
fuFrame.list.Scroll:SetPoint("TOPLEFT",fuFrame.list,"TOPLEFT",4,-4);
fuFrame.list.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.list,"BOTTOMRIGHT",-26,3);
fuFrame.list.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinhang)
end)
local hangkuandu = fuFrame.list:GetWidth()-28
for id = 1, hang_Num do
	fuFrame.list.hang = CreateFrame("Frame", "list_"..tabID.."_hang_"..id, fuFrame.list);
	fuFrame.list.hang:SetSize(hangkuandu, hang_Height);
	if id==1 then
		fuFrame.list.hang:SetPoint("TOP",fuFrame.list.Scroll,"TOP",0,0);
	else
		fuFrame.list.hang:SetPoint("TOP",_G["list_"..tabID.."_hang_"..(id-1)],"BOTTOM",0,-0);
	end
	if id~=hang_Num then
		fuFrame.list.hang.line = fuFrame.list.hang:CreateLine()
		fuFrame.list.hang.line:SetColorTexture(1,1,1,0.3)
		fuFrame.list.hang.line:SetThickness(1);
		fuFrame.list.hang.line:SetStartPoint("BOTTOMLEFT",0,0)
		fuFrame.list.hang.line:SetEndPoint("BOTTOMRIGHT",0,0)
	end
	fuFrame.list.hang.icon = fuFrame.list.hang:CreateTexture(nil, "BORDER");
	fuFrame.list.hang.icon:SetSize(hang_Height,hang_Height);
	fuFrame.list.hang.icon:SetPoint("LEFT",fuFrame.list.hang,"LEFT",0,0);
	fuFrame.list.hang.LinkF = CreateFrame("Frame",nil,fuFrame.list.hang);
	fuFrame.list.hang.LinkF:SetSize(hangkuandu-hang_Height*2,hang_Height);
	fuFrame.list.hang.LinkF:SetPoint("LEFT", fuFrame.list.hang.icon, "RIGHT", 2,0);
	fuFrame.list.hang.Link = fuFrame.list.hang.LinkF:CreateFontString();
	fuFrame.list.hang.Link:SetPoint("LEFT", fuFrame.list.hang.LinkF, "LEFT", 0,0);
	fuFrame.list.hang.Link:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	fuFrame.list.hang.del = CreateFrame("Button",nil,fuFrame.list.hang, "TruncatedButtonTemplate");
	fuFrame.list.hang.del:SetSize(hang_Height-4,hang_Height-4);
	fuFrame.list.hang.del:SetPoint("LEFT", fuFrame.list.hang.LinkF, "RIGHT", 0,0);
	fuFrame.list.hang.del.Texture = fuFrame.list.hang.del:CreateTexture(nil, "BORDER");
	fuFrame.list.hang.del.Texture:SetTexture("interface/common/voicechat-muted.blp");
	fuFrame.list.hang.del.Texture:SetPoint("CENTER");
	fuFrame.list.hang.del.Texture:SetSize(hang_Height-12,hang_Height-12)
	fuFrame.list.hang.del:SetScript("OnMouseDown", function (self)
		self.Texture:SetPoint("CENTER",1,-1);
	end);
	fuFrame.list.hang.del:SetScript("OnMouseUp", function (self)
		self.Texture:SetPoint("CENTER");
	end);
	fuFrame.list.hang.del:SetScript("OnClick", function (self)
		table.remove(PIG_Per['SpellJK']["Spell_list"][tabID],self:GetID());
		gengxinhang(fuFrame.list.Scroll)
		zishenBUFF_event()
	end);
end
---ADD
fuFrame.list.E = CreateFrame('EditBox', nil, fuFrame.list,"InputBoxInstructionsTemplate");
fuFrame.list.E:SetSize(90,30);
fuFrame.list.E:SetPoint("TOPLEFT",fuFrame.list,"BOTTOMLEFT",10,-0);
fuFrame.list.E:SetFontObject(ChatFontNormal);
fuFrame.list.E:SetMaxLetters(20)
fuFrame.list.E:SetNumeric()
fuFrame.list.E:SetAutoFocus(false);
-----
fuFrame.list.add = CreateFrame("Button",nil,fuFrame.list, "UIPanelButtonTemplate");  
fuFrame.list.add:SetSize(90,24);
fuFrame.list.add:SetPoint("LEFT",fuFrame.list.E,"RIGHT",6,-0);
fuFrame.list.add:SetText("添加技能ID");
fuFrame.list.add:Hide();
local function add_BUFF(shuruspID)
	local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(shuruspID)
	local cooldownMS, gcdMS = GetSpellBaseCooldown(shuruspID)
	if not icon or not cooldownMS then print("|cff00FFFF!Pig:|r|cffFFFF00不是有效的技能ID！|r") return end
	if #PIG_Per['SpellJK']["Spell_list"][tabID]>(jiankongNUM-1) then print("|cff00FFFF!Pig:|r|cffFFFF00最多设置10个提醒技能,请删除一些旧的！|r") return end
	for g=1,#PIG_Per['SpellJK']["Spell_list"][tabID] do
		if name==PIG_Per['SpellJK']["Spell_list"][tabID][g][2] then
			print("|cff00FFFF!Pig:|r|cffFFFF00已存在同名技能，请删除后再添加(建议添加技能的最高等级ID)！|r") 
			return
		end
	end
	-- local shuoming = GetSpellDescription(shuruspID)
	-- local _, _, _, chixuTime1 = shuoming:find("(持续(.+)秒)");
	-- local _, _, _, chixuTime2 = shuoming:find("(持续(.+)分钟)");	
	-- fuFrame.chixuTime=0
	-- if chixuTime1 then
	-- 	fuFrame.chixuTime=chixuTime1
	-- elseif chixuTime2 then
	-- 	fuFrame.chixuTime=chixuTime2*60
	-- end
	-- if fuFrame.chixuTime==0 then  print("|cff00FFFF!Pig:|r|cffFFFF00该技能没有持续时长，无需监控！|r") return end
	local link="\124cff71d5ff\124Hspell:"..spellId.."\124h["..name.."]\124h\124r";
	table.insert(PIG_Per['SpellJK']["Spell_list"][tabID], {spellId,name,icon,link,tonumber(fuFrame.chixuTime)});
	gengxinhang(fuFrame.list.Scroll)
	if PIG_Per['SpellJK']["Open"][tabID]=="ON" then
		zishenBUFF_event()
	end
end
fuFrame.list.add:SetScript("OnClick", function (self)
	local fujik=self:GetParent()
	local shuruspID=fujik.E:GetNumber()
	add_BUFF(shuruspID)
	fujik.E:ClearFocus()
	fujik.E:SetText("")
end);
fuFrame.list.E:SetScript("OnEnterPressed", function(self)
	local shuruspID=self:GetNumber()
	add_BUFF(shuruspID)
	self:ClearFocus()
	self:SetText("")
end);
fuFrame.list.E:SetScript("OnEscapePressed", function(self) 
	self:ClearFocus()
	self:SetText("")
	fuFrame.list.add:Hide();
end);
fuFrame.list.E:SetScript("OnEditFocusGained", function(self) 
	fuFrame.list.add:Show();
end);

--图标大小，长度1
local MINMAX_JK = {20,100,16,50,10,30}
-----------
fuFrame.JindutiaoW = fuFrame:CreateFontString();
fuFrame.JindutiaoW:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",260,-56);
fuFrame.JindutiaoW:SetFontObject(GameFontNormal);
fuFrame.JindutiaoW:SetText('提示图标大小:');
----------
fuFrame.JindutiaoW_Slider = CreateFrame("Slider", nil, fuFrame, "OptionsSliderTemplate")
fuFrame.JindutiaoW_Slider:SetWidth(100)
fuFrame.JindutiaoW_Slider:SetHeight(15)
fuFrame.JindutiaoW_Slider:SetPoint("LEFT",fuFrame.JindutiaoW,"RIGHT",10,0);
fuFrame.JindutiaoW_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.JindutiaoW_Slider:SetMinMaxValues(MINMAX_JK[1],MINMAX_JK[2]);
fuFrame.JindutiaoW_Slider:SetValueStep(1);
fuFrame.JindutiaoW_Slider:SetObeyStepOnDrag(true);
fuFrame.JindutiaoW_Slider.Low:SetText(MINMAX_JK[1]);
fuFrame.JindutiaoW_Slider.High:SetText(MINMAX_JK[2]);
fuFrame.JindutiaoW_Slider:EnableMouseWheel(true);
fuFrame.JindutiaoW_Slider:SetScript("OnMouseWheel", function(self, arg1)
	local step = 1 * arg1
	local value = self:GetValue()
	if step > 0 then
		self:SetValue(min(value + step, MINMAX_JK[2]))
	else
		self:SetValue(max(value + step, MINMAX_JK[1]))
	end
end)
fuFrame.JindutiaoW_Slider:SetScript('OnValueChanged', function(self)
	local Hval = self:GetValue()
	PIG_Per['SpellJK']["WHF_list"][tabID]["W"]=Hval;
	PIG_Per['SpellJK']["WHF_list"][tabID]["H"]=Hval;
	fuFrame.JindutiaoW_Slider.Text:SetText(Hval);
	if zishenBUFF_UI then
		zishenBUFF_UI:SetHeight(Hval)
		for i=1,10 do
			_G["zishenBUFF_But_"..i]:SetSize(Hval,Hval);
		end
	end
end)
fuFrame:SetScript("OnShow", function(self)
	gengxinhang(fuFrame.list.Scroll)
	self.JindutiaoW_Slider:SetValue(PIG_Per['SpellJK']["WHF_list"][tabID]["W"]);
	self.JindutiaoW_Slider.Text:SetText(PIG_Per['SpellJK']["WHF_list"][tabID]["W"]);
end)
fuFrame:SetScript("OnHide", function(self)
	self.list.add:Hide();
end)
--========================================================
fuFrame.Open = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",10,-4,"启用"..tabName.."监控","")
fuFrame.Open:SetSize(30,30);
fuFrame.Open:SetHitRectInsets(0,-80,0,0);
fuFrame.Open:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",10,-4);
fuFrame.Open.Text:SetText("启用"..tabName.."监控");
fuFrame.Open:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per['SpellJK']['Open'][tabID]="ON";
		zishenBUFF_ADD()
	else
		PIG_Per['SpellJK']['Open'][tabID]="OFF";
		StaticPopup_Show ("PIG_Reload_UI");
	end
end);
--=====================================
addonTable.zishenBUFF = function()
	if PIG_Per['SpellJK']['Open'][tabID]=="ON" then
		fuFrame.Open:SetChecked(true);
		zishenBUFF_ADD()
	end
end
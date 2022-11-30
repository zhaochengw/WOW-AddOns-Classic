local _, addonTable = ...;
local ADD_Checkbutton=addonTable.ADD_Checkbutton
---------.
local tabID = 4;
local tabName = _G["SpellJK.F_TAB_"..tabID].title:GetText();
local fuFrame=_G["SpellJK_F_TabFrame_"..tabID]
--======================================================================
local jiankongNUM=10
--监控事件
local function mubiaoBUFF_UP()
	for i=1,jiankongNUM do
		local fame = _G["mubiaoBUFF_But_"..i]
		fame:SetScript("OnUpdate", function(self, ssss)
			fame.linshi=fame.linshi-ssss
			local xxxxx = floor(fame.linshi)
			fame.CD:SetText(xxxxx)
		end);
	end
end
local function mubiaoBUFF_event()
	local shujuy=PIG_Per['SpellJK']["Spell_list"][tabID]
	
	for i=1,jiankongNUM do
		_G["mubiaoBUFF_But_"..i]:Hide();
	end

	fuFrame.xulieID=0
	for i=1,36 do
		local _,_,_,_,start, duration,_,_,_,spellId = UnitDebuff("target", i)
		if spellId then
			for ii=1,#shujuy do
				if shujuy[ii][1]==spellId then
					fuFrame.xulieID=fuFrame.xulieID+1
					local FAMEX=_G["mubiaoBUFF_But_"..fuFrame.xulieID]
					FAMEX:Show();
					FAMEX.Tex:SetTexture(shujuy[ii][3]);
					local start=GetServerTime()
					FAMEX.CD:SetText(shujuy[ii][5]);
					FAMEX.linshi=shujuy[ii][5]
				end
			end
		end
	end
end
--监控UI
local function mubiaoBUFF_ADD()
	if PIG_Per['SpellJK']["Open"][tabID]=="ON" and mubiaoBUFF_UI==nil then
		local jinduW=PIG_Per['SpellJK']["WHF_list"][tabID]["W"]
		local jinduH=PIG_Per['SpellJK']["WHF_list"][tabID]["H"]
		local fontWH=PIG_Per['SpellJK']["WHF_list"][tabID]["font"]
		local mubiaoBUFF = CreateFrame("Frame", "mubiaoBUFF_UI", TargetFrame)
		mubiaoBUFF:SetSize(16,PIG_Per['SpellJK']["WHF_list"][tabID]["H"])
		mubiaoBUFF:SetPoint("BOTTOMRIGHT",TargetFrame,"BOTTOMRIGHT",100,-100);
		mubiaoBUFF:SetMovable(true)
		mubiaoBUFF:SetClampedToScreen(true)	
		mubiaoBUFF.yidong = CreateFrame("Frame", nil, mubiaoBUFF,"BackdropTemplate")
		mubiaoBUFF.yidong:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 6,})
		mubiaoBUFF.yidong:SetAllPoints(mubiaoBUFF)
		mubiaoBUFF.yidong:Hide();
		mubiaoBUFF.yidong:EnableMouse(true)
		mubiaoBUFF.yidong:RegisterForDrag("LeftButton")
		mubiaoBUFF.yidong.t = mubiaoBUFF.yidong:CreateFontString();
		mubiaoBUFF.yidong.t:SetPoint("LEFT", mubiaoBUFF.yidong, "LEFT", -8, 0);
		mubiaoBUFF.yidong.t:SetFontObject(GameFontNormal);
		mubiaoBUFF.yidong.t:SetTextColor(0.8, 0.8, 0.8, 0.6);
		mubiaoBUFF.yidong.t:SetText("目\n标");
		mubiaoBUFF.yidong:SetScript("OnDragStart",function()
			mubiaoBUFF:StartMoving()
		end)
		mubiaoBUFF.yidong:SetScript("OnDragStop",function()
			mubiaoBUFF:StopMovingOrSizing()
		end)
		for i=1,jiankongNUM do
			mubiaoBUFF.But = CreateFrame("Frame", "mubiaoBUFF_But_"..i, mubiaoBUFF);
			mubiaoBUFF.But:SetSize(jinduW,jinduH);
			if i==1 then
				mubiaoBUFF.But:SetPoint("LEFT",mubiaoBUFF,"RIGHT",6,-0);
			else
				mubiaoBUFF.But:SetPoint("LEFT",_G["mubiaoBUFF_But_"..(i-1)],"RIGHT",6,0);
			end
			mubiaoBUFF.But:Hide()
			mubiaoBUFF.But.Tex = mubiaoBUFF.But:CreateTexture(nil, "BORDER");
			mubiaoBUFF.But.Tex:SetAllPoints(mubiaoBUFF.But)
			mubiaoBUFF.But.CD = mubiaoBUFF.But:CreateFontString();
			mubiaoBUFF.But.CD:SetPoint("BOTTOMRIGHT", mubiaoBUFF.But, "BOTTOMRIGHT", 0, 0);
			mubiaoBUFF.But.CD:SetTextColor(1, 1, 0, 1);	
			mubiaoBUFF.But.CD:SetFont(GameFontNormal:GetFont(), fontWH,"OUTLINE")
		end
		mubiaoBUFF_UP()
		mubiaoBUFF_event()
		mubiaoBUFF:RegisterEvent("PLAYER_ENTERING_WORLD")
		mubiaoBUFF:RegisterEvent("PLAYER_TARGET_CHANGED");
		mubiaoBUFF:RegisterEvent("UNIT_AURA","target")
		mubiaoBUFF:SetScript("OnEvent",function(self, event)
			mubiaoBUFF_event()
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
		mubiaoBUFF_event()
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
	local shuoming = GetSpellDescription(shuruspID)
	local _, _, _, chixuTime1 = shuoming:find("(持续(.+)秒)");
	local _, _, _, chixuTime2 = shuoming:find("(持续(.+)分钟)");	
	local _, _, _, chixuTime3 = shuoming:find("(在(.+)秒)");	
	fuFrame.chixuTime=0
	if chixuTime1 then
		fuFrame.chixuTime=chixuTime1
	elseif chixuTime2 then
		fuFrame.chixuTime=chixuTime2*60
	elseif chixuTime3 then
		fuFrame.chixuTime=chixuTime3
	end
	if fuFrame.chixuTime==0 then  print("|cff00FFFF!Pig:|r|cffFFFF00该技能没有持续时长，无需监控！|r") return end
	local link="\124cff71d5ff\124Hspell:"..spellId.."\124h["..name.."]\124h\124r";
	table.insert(PIG_Per['SpellJK']["Spell_list"][tabID], {spellId,name,icon,link,tonumber(fuFrame.chixuTime)});
	gengxinhang(fuFrame.list.Scroll)
	if PIG_Per['SpellJK']["Open"][tabID]=="ON" then
		mubiaoBUFF_event()
	end
end
fuFrame.list.add:SetScript("OnClick", function (self)
	local shuruspID=self:GetParent().E:GetNumber()
	add_BUFF(shuruspID)
	self:GetParent().E:ClearFocus()
end);
fuFrame.list.E:SetScript("OnEnterPressed", function(self)
	local shuruspID=self:GetNumber()
	add_BUFF(shuruspID)
	self:ClearFocus()
end);
fuFrame.list.E:SetScript("OnEscapePressed", function(self) 
	self:ClearFocus() 
end);
fuFrame.list.E:SetScript("OnEditFocusGained", function(self) 
	fuFrame.list.add:Show();
end);
fuFrame.list.E:SetScript("OnEditFocusLost", function(self) 
	fuFrame.list.add:Hide();
	self:SetText("")
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
	if mubiaoBUFF_UI then
		mubiaoBUFF_UI:SetHeight(Hval)
		for i=1,10 do
			_G["mubiaoBUFF_But_"..i]:SetSize(Hval,Hval);
		end
	end
end)
fuFrame:SetScript("OnShow", function()
	gengxinhang(fuFrame.list.Scroll)
	fuFrame.JindutiaoW_Slider:SetValue(PIG_Per['SpellJK']["WHF_list"][tabID]["W"]);
	fuFrame.JindutiaoW_Slider.Text:SetText(PIG_Per['SpellJK']["WHF_list"][tabID]["W"]);
end)
--========================================================
-- fuFrame.Open = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",10,-4,"启用"..tabName.."监控","")
-- fuFrame.Open:SetSize(30,30);
-- fuFrame.Open:SetHitRectInsets(0,-80,0,0);
-- fuFrame.Open:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",10,-4);
-- fuFrame.Open.Text:SetText("启用"..tabName.."监控");
-- fuFrame.Open:SetScript("OnClick", function (self)
-- 	if self:GetChecked() then
-- 		PIG_Per['SpellJK']['Open'][tabID]="ON";
-- 		mubiaoBUFF_ADD()
-- 	else
-- 		PIG_Per['SpellJK']['Open'][tabID]="OFF";
-- 		StaticPopup_Show ("PIG_Reload_UI");
-- 	end
-- end);
--=====================================
addonTable.mubiaoBUFF = function()
	-- if PIG_Per['SpellJK']['Open'][tabID]=="ON" then
	-- 	fuFrame.Open:SetChecked(true);
	-- 	mubiaoBUFF_ADD()
	-- end
end
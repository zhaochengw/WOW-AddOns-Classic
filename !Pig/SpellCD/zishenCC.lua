local _, addonTable = ...;
local gsub = _G.string.gsub
local sub = _G.string.sub
local find = _G.string.find
local ADD_Checkbutton=addonTable.ADD_Checkbutton
---------.
local tabID = 2;
local tabName = _G["SpellJK.F_TAB_"..tabID].title:GetText();
local fuFrame=_G["SpellJK_F_TabFrame_"..tabID]
--======================================================================
local zishengkongzhimulu={}
local jiankongSHU =10
--监控事件
local function zishenCC_event()
	local jinduW=PIG_Per['SpellJK']["WHF_list"][tabID]["W"]
	local jinduH=PIG_Per['SpellJK']["WHF_list"][tabID]["H"]
	local jinduWW=jinduW-jinduH
	for i=1,jiankongSHU do
		_G["zishenJiankong_list_"..i]:Hide()
	end
	if #zishengkongzhimulu>0 then
		for i=1,#zishengkongzhimulu do
				local Shengyushijian=(zishengkongzhimulu[i][6]+zishengkongzhimulu[i][7]-GetTime())
				if Shengyushijian then
					if Shengyushijian>0 then
						if _G["zishenJiankong_list_"..i] then
							_G["zishenJiankong_list_"..i]:Show()
							_G["zishenJiankong_list_"..i].icon:SetTexture(zishengkongzhimulu[i][1]);
							if Shengyushijian>5 then
								_G["zishenJiankong_list_"..i].jindutiao1:SetColorTexture(0.3, 0.7, 0, 1)
							else
								_G["zishenJiankong_list_"..i].jindutiao1:SetColorTexture(1, 69/255, 0, 1)
							end
							_G["zishenJiankong_list_"..i].jindutiao1:SetWidth(jinduWW*(Shengyushijian/zishengkongzhimulu[i][6]));
							_G["zishenJiankong_list_"..i].title:SetText(zishengkongzhimulu[i][4]);
							if Shengyushijian>60 then
								_G["zishenJiankong_list_"..i].titleCD:SetText(math.ceil((Shengyushijian/60)).."m");
							else
								_G["zishenJiankong_list_"..i].titleCD:SetText(math.ceil(Shengyushijian));
							end
						end
					else
						table.remove(zishengkongzhimulu,i);
					end
				else
					table.remove(zishengkongzhimulu,i);
				end
		end
		C_Timer.After(0.1,zishenCC_event)
	end
end
--监控UI
local function zishenCC_ADD()
	if PIG_Per['SpellJK']["Open"][tabID]=="ON" and zishenJiankong_UI==nil then
		local zishenJiankong = CreateFrame("Frame", "zishenJiankong_UI", UIParent);
		zishenJiankong:SetFrameStrata("LOW")
		zishenJiankong:SetSize(PIG_Per['SpellJK']["WHF_list"][tabID]["W"],16);
		zishenJiankong:SetPoint("CENTER", UIParent, "CENTER", -300, 0);
		zishenJiankong:SetMovable(true)
		zishenJiankong:SetClampedToScreen(true)
		zishenJiankong.yidong = CreateFrame("Frame", nil, zishenJiankong,"BackdropTemplate");
		zishenJiankong.yidong:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", tile = true, });
		zishenJiankong.yidong:SetAllPoints(zishenJiankong)
		zishenJiankong.yidong:EnableMouse(true)
		zishenJiankong.yidong:RegisterForDrag("LeftButton")
		zishenJiankong.yidong:Hide()
		zishenJiankong.yidong.T = zishenJiankong.yidong:CreateFontString();
		zishenJiankong.yidong.T:SetPoint("CENTER", zishenJiankong.yidong, "CENTER", 0,-0);
		zishenJiankong.yidong.T:SetFont(ChatFontNormal:GetFont(), 11, "OUTLINE");
		zishenJiankong.yidong.T:SetText("自身控制时长");
		zishenJiankong.yidong:SetScript("OnDragStart",function()
			zishenJiankong:StartMoving()
		end)
		zishenJiankong.yidong:SetScript("OnDragStop",function()
			zishenJiankong:StopMovingOrSizing()
		end)
		for i=1,jiankongSHU do
			zishenJiankong.list = CreateFrame("Frame", "zishenJiankong_list_"..i, zishenJiankong);
			zishenJiankong.list:SetHeight(PIG_Per['SpellJK']["WHF_list"][tabID]["H"]);
			if i==1 then
				zishenJiankong.list:SetPoint("TOPLEFT",zishenJiankong,"BOTTOMLEFT",0,0);
				zishenJiankong.list:SetPoint("TOPRIGHT",zishenJiankong,"BOTTOMRIGHT",0,0);
			else
				zishenJiankong.list:SetPoint("TOPLEFT",_G["zishenJiankong_list_"..(i-1)],"BOTTOMLEFT",0,-2);
				zishenJiankong.list:SetPoint("TOPRIGHT",_G["zishenJiankong_list_"..(i-1)],"BOTTOMRIGHT",0,-2);
			end
			zishenJiankong.list:Hide()
			zishenJiankong.list.icon = zishenJiankong.list:CreateTexture(nil, "BORDER");
			zishenJiankong.list.icon:SetSize(PIG_Per['SpellJK']["WHF_list"][tabID]["H"],PIG_Per['SpellJK']["WHF_list"][tabID]["H"]);
			zishenJiankong.list.icon:SetPoint("LEFT",zishenJiankong.list,"LEFT",0,0);
			zishenJiankong.list.jindutiao = zishenJiankong.list:CreateTexture(nil, "BORDER");
			zishenJiankong.list.jindutiao:SetTexture("Interface/DialogFrame/UI-DialogBox-Background");
			zishenJiankong.list.jindutiao:SetHeight(PIG_Per['SpellJK']["WHF_list"][tabID]["H"]-1);
			zishenJiankong.list.jindutiao:SetPoint("LEFT",zishenJiankong.list.icon,"RIGHT",0,-0);
			zishenJiankong.list.jindutiao:SetPoint("RIGHT",zishenJiankong.list,"RIGHT",0,-0);
			zishenJiankong.list.jindutiao1 = zishenJiankong.list:CreateTexture(nil, "ARTWORK");
			zishenJiankong.list.jindutiao1:SetTexture("interface/raidframe/raid-bar-hp-fill.blp");
			--zishenJiankong.list.jindutiao1:SetColorTexture(0.3, 0.7, 0.1, 1)
			zishenJiankong.list.jindutiao1:SetHeight(PIG_Per['SpellJK']["WHF_list"][tabID]["H"]-1);
			zishenJiankong.list.jindutiao1:GetWidth(PIG_Per['SpellJK']["WHF_list"][tabID]["W"]-PIG_Per['SpellJK']["WHF_list"][tabID]["H"])
			zishenJiankong.list.jindutiao1:SetPoint("LEFT",zishenJiankong.list.jindutiao,"LEFT",0,-0);
			zishenJiankong.list.title = zishenJiankong.list:CreateFontString();
			zishenJiankong.list.title:SetPoint("CENTER", zishenJiankong.list.jindutiao, "CENTER", -10, 0);
			zishenJiankong.list.title:SetFont(GameFontNormal:GetFont(), PIG_Per['SpellJK']["WHF_list"][tabID]["font"],"OUTLINE")
			zishenJiankong.list.title:SetTextColor(1, 1, 1, 1);
			zishenJiankong.list.titleCD = zishenJiankong.list:CreateFontString();
			zishenJiankong.list.titleCD:SetPoint("RIGHT", zishenJiankong.list.jindutiao, "RIGHT", -2, 0.6);
			zishenJiankong.list.titleCD:SetFont(GameFontNormal:GetFont(), PIG_Per['SpellJK']["WHF_list"][tabID]["font"],"OUTLINE")
			zishenJiankong.list.titleCD:SetTextColor(1, 1, 1, 1);
		end

		zishenJiankong:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		zishenJiankong:SetScript("OnEvent",function(self, event)
			local Combat1,Combat2,Combat3,Combat4,Combat5,Combat6,Combat7,Combat8,Combat9,Combat10,Combat11,Combat12,Combat13= CombatLogGetCurrentEventInfo();
			if Combat4 ~= UnitGUID("player") then return end
			--print(Combat1,Combat2,Combat3,Combat4,Combat5,Combat6,Combat7,Combat8,Combat9,Combat10,Combat11,Combat12,Combat13)

			if Combat2 == "SPELL_AURA_REFRESH" then
				for i=1,#zishengkongzhimulu do
					if zishengkongzhimulu[i][3]==Combat8 then
						zishengkongzhimulu[i][7]=GetTime()
						zishenCC_event()
					end
				end
			end

			if Combat2 == "SPELL_AURA_APPLIED" then
				local _, _, _, zhongleiXC = Combat8:find("((.-)%-)");
				if zhongleiXC=="Creature" then
					for i=1,#PIG_Per['SpellJK']["Spell_list"][tabID] do
						if PIG_Per['SpellJK']["Spell_list"][tabID][i][2]==Combat13 then
							for v=1,#zishengkongzhimulu do
								if Combat13==zishengkongzhimulu[v][5] then return end
							end															--1图标/2角色GUID/3目标GUID/4目标名/5技能名/6持续时间/7开始时间
								local kongzhiInfo={PIG_Per['SpellJK']["Spell_list"][tabID][i][3], Combat4, Combat8, Combat9, Combat13, PIG_Per['SpellJK']["Spell_list"][tabID][i][6], GetTime()}
								table.insert(zishengkongzhimulu, kongzhiInfo);
								zishenCC_event()
							
						end
					end
				elseif zhongleiXC=="player" then

				end
			end

			if Combat2 == "SPELL_AURA_REMOVED" then
				for i=#zishengkongzhimulu,1,-1 do
					if zishengkongzhimulu[i][3]==Combat8 and zishengkongzhimulu[i][5]==Combat13 then
						table.remove(zishengkongzhimulu,i);
					end
				end
			end
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
local function Add_SPELLCC(shuruspID)
	local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(shuruspID)
	local cooldownMS, gcdMS = GetSpellBaseCooldown(shuruspID)
	if not icon or not cooldownMS then print("|cff00FFFF!Pig:|r|cffFFFF00不是有效的技能ID！|r") return end
	for g=1,#PIG_Per['SpellJK']["Spell_list"][tabID] do
		if name==PIG_Per['SpellJK']["Spell_list"][tabID][g][2] then
			print("|cff00FFFF!Pig:|r|cffFFFF00已存在同名技能，请删除后再添加(建议添加技能的最高等级ID)！|r") 
			return
		end
	end
	local shuoming = GetSpellDescription(shuruspID)
	local _, _, _, chixuTime1 = shuoming:find("((.+)秒)");
	local _, _, _, chixuTime2 = shuoming:find("((.+)分钟)");	
	fuFrame.chixuTime=0
	if chixuTime1 then
		fuFrame.chixuTime=chixuTime1
	elseif chixuTime2 then
		fuFrame.chixuTime=chixuTime2*60
	end
	if fuFrame.chixuTime==0 then  print("|cff00FFFF!Pig:|r|cffFFFF00该技能没有控制时长，无需监控！|r") return end
	local link="\124cff71d5ff\124Hspell:"..spellId.."\124h["..name.."]\124h\124r";
	table.insert(PIG_Per['SpellJK']["Spell_list"][tabID], {spellId,name,icon,link,cooldownMS,tonumber(fuFrame.chixuTime)});
	gengxinhang(fuFrame.list.Scroll)
end
fuFrame.list.add:SetScript("OnClick", function (self)
	local shuruspID=self:GetParent().E:GetNumber()
	Add_SPELLCC(shuruspID)
	self:GetParent().E:ClearFocus()
end);
fuFrame.list.E:SetScript("OnEnterPressed", function(self)
	local shuruspID=self:GetNumber()
	Add_SPELLCC(shuruspID)
	self:ClearFocus()
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
local MINMAX_JK = {80,300,16,50,10,30}
-----------
fuFrame.JindutiaoW = fuFrame:CreateFontString();
fuFrame.JindutiaoW:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",260,-56);
fuFrame.JindutiaoW:SetFontObject(GameFontNormal);
fuFrame.JindutiaoW:SetText('进度条宽:');
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
	fuFrame.JindutiaoW_Slider.Text:SetText(Hval);
	if zishenJiankong_UI then
		zishenJiankong_UI:SetWidth(Hval)
	end
end)
-----------
--图标高度2
fuFrame.JindutiaoH = fuFrame:CreateFontString();
fuFrame.JindutiaoH:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",260,-110);
fuFrame.JindutiaoH:SetFontObject(GameFontNormal);
fuFrame.JindutiaoH:SetText('进度条高:');
-- --------
fuFrame.JindutiaoH_Slider = CreateFrame("Slider", nil, fuFrame, "OptionsSliderTemplate")
fuFrame.JindutiaoH_Slider:SetWidth(100)
fuFrame.JindutiaoH_Slider:SetHeight(15)
fuFrame.JindutiaoH_Slider:SetPoint("LEFT",fuFrame.JindutiaoH,"RIGHT",10,0);
fuFrame.JindutiaoH_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.JindutiaoH_Slider:SetMinMaxValues(MINMAX_JK[3],MINMAX_JK[4]);
fuFrame.JindutiaoH_Slider:SetValueStep(1);
fuFrame.JindutiaoH_Slider:SetObeyStepOnDrag(true);
fuFrame.JindutiaoH_Slider.Low:SetText(MINMAX_JK[3]);
fuFrame.JindutiaoH_Slider.High:SetText(MINMAX_JK[4]);
fuFrame.JindutiaoH_Slider:EnableMouseWheel(true);
fuFrame.JindutiaoH_Slider:SetScript("OnMouseWheel", function(self, arg1)
	local step = 1 * arg1
	local value = self:GetValue()
	if step > 0 then
		self:SetValue(min(value + step, MINMAX_JK[4]))
	else
		self:SetValue(max(value + step, MINMAX_JK[3]))
	end
end)
fuFrame.JindutiaoH_Slider:SetScript('OnValueChanged', function(self)
	local Hval = self:GetValue()
	PIG_Per['SpellJK']["WHF_list"][tabID]["H"]=Hval;
	fuFrame.JindutiaoH_Slider.Text:SetText(Hval)
	for i=1,jiankongSHU do
		if _G["zishenJiankong_list_"..i] then
			_G["zishenJiankong_list_"..i]:SetHeight(Hval);
			_G["zishenJiankong_list_"..i].icon:SetSize(Hval,Hval);
			_G["zishenJiankong_list_"..i].jindutiao:SetHeight(Hval);
			_G["zishenJiankong_list_"..i].jindutiao1:SetHeight(Hval);
		end
	end
end)
---字体大小
fuFrame.JindutiaoFont = fuFrame:CreateFontString();
fuFrame.JindutiaoFont:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",260,-160);
fuFrame.JindutiaoFont:SetFontObject(GameFontNormal);
fuFrame.JindutiaoFont:SetText('字体大小:');
-- --------
fuFrame.JindutiaoFont_Slider = CreateFrame("Slider", nil, fuFrame, "OptionsSliderTemplate")
fuFrame.JindutiaoFont_Slider:SetWidth(100)
fuFrame.JindutiaoFont_Slider:SetHeight(15)
fuFrame.JindutiaoFont_Slider:SetPoint("LEFT",fuFrame.JindutiaoFont,"RIGHT",10,0);
fuFrame.JindutiaoFont_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.JindutiaoFont_Slider:SetMinMaxValues(MINMAX_JK[5],MINMAX_JK[6]);
fuFrame.JindutiaoFont_Slider:SetValueStep(1);
fuFrame.JindutiaoFont_Slider:SetObeyStepOnDrag(true);
fuFrame.JindutiaoFont_Slider.Low:SetText(MINMAX_JK[5]);
fuFrame.JindutiaoFont_Slider.High:SetText(MINMAX_JK[6]);
fuFrame.JindutiaoFont_Slider:EnableMouseWheel(true);
fuFrame.JindutiaoFont_Slider:SetScript("OnMouseWheel", function(self, arg1)
	local step = 1 * arg1
	local value = self:GetValue()
	if step > 0 then
		self:SetValue(min(value + step, MINMAX_JK[6]))
	else
		self:SetValue(max(value + step, MINMAX_JK[5]))
	end
end)
fuFrame.JindutiaoFont_Slider:SetScript('OnValueChanged', function(self)
	local Hval = self:GetValue()
	PIG_Per['SpellJK']["WHF_list"][tabID]["font"]=Hval;
	fuFrame.JindutiaoFont_Slider.Text:SetText(Hval)
	for i=1,jiankongSHU do
		if _G["zishenJiankong_list_"..i] then
			_G["zishenJiankong_list_"..i].title:SetFont(GameFontNormal:GetFont(), Hval,"OUTLINE")
			_G["zishenJiankong_list_"..i].titleCD:SetFont(GameFontNormal:GetFont(), Hval,"OUTLINE")
		end
	end
end)
------------
fuFrame:SetScript("OnShow", function(self)
	gengxinhang(fuFrame.list.Scroll)
	self.JindutiaoW_Slider:SetValue(PIG_Per['SpellJK']["WHF_list"][tabID]["W"]);
	self.JindutiaoW_Slider.Text:SetText(PIG_Per['SpellJK']["WHF_list"][tabID]["W"]);
	self.JindutiaoH_Slider:SetValue(PIG_Per['SpellJK']["WHF_list"][tabID]["H"]);
	self.JindutiaoH_Slider.Text:SetText(PIG_Per['SpellJK']["WHF_list"][tabID]["H"]);
	self.JindutiaoFont_Slider:SetValue(PIG_Per['SpellJK']["WHF_list"][tabID]["font"]);
	self.JindutiaoFont_Slider.Text:SetText(PIG_Per['SpellJK']["WHF_list"][tabID]["font"]);
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
		zishenCC_ADD()
	else
		PIG_Per['SpellJK']['Open'][tabID]="OFF";
		StaticPopup_Show ("PIG_Reload_UI");
	end
end);
--=====================================
addonTable.zishenCC = function()
	if PIG_Per['SpellJK']['Open'][tabID]=="ON" then
		fuFrame.Open:SetChecked(true);
		zishenCC_ADD()
	end
end
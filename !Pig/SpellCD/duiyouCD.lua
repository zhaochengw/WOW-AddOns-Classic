local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local ADD_Checkbutton=addonTable.ADD_Checkbutton
---------.
local tabID = 3;
local tabName = _G["SpellJK.F_TAB_"..tabID].title:GetText();
local fuFrame=_G["SpellJK_F_TabFrame_"..tabID]
local _, _, _, tocversion = GetBuildInfo()
--======================================================================
local spellmululiebiao={}
local jiankongSHU =25
--监控事件
local function duiyouCD_event()
	local jinduW=PIG_Per['SpellJK']["WHF_list"][tabID]["W"]
	local jinduH=PIG_Per['SpellJK']["WHF_list"][tabID]["H"]
	local jinduWW=jinduW-jinduH
	for i=1,jiankongSHU do
		_G["duiyouJiankong_list_"..i]:Hide()
	end
	if #spellmululiebiao>0 then
		for i=#spellmululiebiao,1,-1 do
			if spellmululiebiao[i] then
				local Shengyushijian=(spellmululiebiao[i][3]/1000+spellmululiebiao[i][4]-GetTime())
				if Shengyushijian>0 then
					_G["duiyouJiankong_list_"..i]:Show()
					_G["duiyouJiankong_list_"..i].icon:SetTexture(spellmululiebiao[i][2]);
					_G["duiyouJiankong_list_"..i].jindutiao1:SetColorTexture(spellmululiebiao[i][6][1], spellmululiebiao[i][6][2], spellmululiebiao[i][6][3], 1)
					_G["duiyouJiankong_list_"..i].jindutiao1:SetWidth((jinduWW)*(Shengyushijian/(spellmululiebiao[i][3]/1000)));
					local _, _, _, wanjiaName = spellmululiebiao[i][5]:find("((.+)-)");
					if wanjiaName then
						_G["duiyouJiankong_list_"..i].title:SetText(wanjiaName.."(*)");
					else
						_G["duiyouJiankong_list_"..i].title:SetText(spellmululiebiao[i][5]);
					end
					if Shengyushijian>60 then
						_G["duiyouJiankong_list_"..i].titleCD:SetText(math.ceil((Shengyushijian/60)).."m");
					else
						_G["duiyouJiankong_list_"..i].titleCD:SetText(math.ceil(Shengyushijian));
					end
				else
					table.remove(spellmululiebiao,i);
				end
			end
		end
	end
	C_Timer.After(0.1,duiyouCD_event)
end
--监控UI
local function duiyouCD_ADD()
	if PIG_Per['SpellJK']["Open"][tabID]=="ON" and duiyouJiankong_UI==nil then
		local duiyouJiankong = CreateFrame("Frame", "duiyouJiankong_UI", UIParent);
		duiyouJiankong:SetFrameStrata("LOW")
		duiyouJiankong:SetSize(PIG_Per['SpellJK']["WHF_list"][tabID]["W"],16);
		duiyouJiankong:SetPoint("CENTER", UIParent, "CENTER", 500, 200);
		duiyouJiankong:SetMovable(true)
		duiyouJiankong:SetClampedToScreen(true)
		duiyouJiankong.yidong = CreateFrame("Frame", nil, duiyouJiankong,"BackdropTemplate");
		duiyouJiankong.yidong:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", tile = true, });
		duiyouJiankong.yidong:SetAllPoints(duiyouJiankong)
		duiyouJiankong.yidong:EnableMouse(true)
		duiyouJiankong.yidong:RegisterForDrag("LeftButton")
		duiyouJiankong.yidong:Hide()
		duiyouJiankong.yidong.T = duiyouJiankong.yidong:CreateFontString();
		duiyouJiankong.yidong.T:SetPoint("CENTER", duiyouJiankong.yidong, "CENTER", 0,-0);
		duiyouJiankong.yidong.T:SetFont(ChatFontNormal:GetFont(), 11, "OUTLINE");
		duiyouJiankong.yidong.T:SetText("队友控制冷却");
		duiyouJiankong.yidong:SetScript("OnDragStart",function()
			duiyouJiankong:StartMoving()
		end)
		duiyouJiankong.yidong:SetScript("OnDragStop",function()
			duiyouJiankong:StopMovingOrSizing()
		end)
		for i=1,jiankongSHU do
			duiyouJiankong.list = CreateFrame("Frame", "duiyouJiankong_list_"..i, duiyouJiankong);
			duiyouJiankong.list:SetHeight(PIG_Per['SpellJK']["WHF_list"][tabID]["H"]);
			if i==1 then
				duiyouJiankong.list:SetPoint("TOPLEFT",duiyouJiankong,"BOTTOMLEFT",0,0);
				duiyouJiankong.list:SetPoint("TOPRIGHT",duiyouJiankong,"BOTTOMRIGHT",0,0);
			else
				duiyouJiankong.list:SetPoint("TOPLEFT",_G["duiyouJiankong_list_"..(i-1)],"BOTTOMLEFT",0,-2);
				duiyouJiankong.list:SetPoint("TOPRIGHT",_G["duiyouJiankong_list_"..(i-1)],"BOTTOMRIGHT",0,-2);
			end
			duiyouJiankong.list:Hide()
			duiyouJiankong.list.icon = duiyouJiankong.list:CreateTexture(nil, "BORDER");
			duiyouJiankong.list.icon:SetSize(PIG_Per['SpellJK']["WHF_list"][tabID]["H"],PIG_Per['SpellJK']["WHF_list"][tabID]["H"]);
			duiyouJiankong.list.icon:SetPoint("LEFT",duiyouJiankong.list,"LEFT",0,0);
			duiyouJiankong.list.jindutiao = duiyouJiankong.list:CreateTexture(nil, "BORDER");
			duiyouJiankong.list.jindutiao:SetTexture("Interface/DialogFrame/UI-DialogBox-Background");
			duiyouJiankong.list.jindutiao:SetHeight(PIG_Per['SpellJK']["WHF_list"][tabID]["H"]-1);
			duiyouJiankong.list.jindutiao:SetPoint("LEFT",duiyouJiankong.list.icon,"RIGHT",0,-0);
			duiyouJiankong.list.jindutiao:SetPoint("RIGHT",duiyouJiankong.list,"RIGHT",0,-0);
			duiyouJiankong.list.jindutiao1 = duiyouJiankong.list:CreateTexture(nil, "ARTWORK");
			duiyouJiankong.list.jindutiao1:SetTexture("interface/raidframe/raid-bar-hp-fill.blp");
			--duiyouJiankong.list.jindutiao1:SetColorTexture(0.3, 0.7, 0.1, 1)
			duiyouJiankong.list.jindutiao1:SetHeight(PIG_Per['SpellJK']["WHF_list"][tabID]["H"]-1);
			duiyouJiankong.list.jindutiao1:GetWidth(PIG_Per['SpellJK']["WHF_list"][tabID]["W"]-PIG_Per['SpellJK']["WHF_list"][tabID]["H"])
			duiyouJiankong.list.jindutiao1:SetPoint("LEFT",duiyouJiankong.list.jindutiao,"LEFT",0,-0);
			duiyouJiankong.list.title = duiyouJiankong.list:CreateFontString();
			duiyouJiankong.list.title:SetPoint("CENTER", duiyouJiankong.list.jindutiao, "CENTER", -10, 0);
			duiyouJiankong.list.title:SetFont(GameFontNormal:GetFont(), PIG_Per['SpellJK']["WHF_list"][tabID]["font"],"OUTLINE")
			duiyouJiankong.list.title:SetTextColor(1, 1, 1, 1);
			duiyouJiankong.list.titleCD = duiyouJiankong.list:CreateFontString();
			duiyouJiankong.list.titleCD:SetPoint("RIGHT", duiyouJiankong.list.jindutiao, "RIGHT", -2, 0.6);
			duiyouJiankong.list.titleCD:SetFont(GameFontNormal:GetFont(), PIG_Per['SpellJK']["WHF_list"][tabID]["font"],"OUTLINE")
			duiyouJiankong.list.titleCD:SetTextColor(1, 1, 1, 1);
		end
		---
		duiyouCD_event()
		---
		duiyouJiankong:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		duiyouJiankong:SetScript("OnEvent",function(self, event)
			if not IsInGroup() then return end
			local _, eventType, _, srcGUID, srcName, srcFlags, _, dstGUID, _, dstFlags, _, _, spellName, _, missType = CombatLogGetCurrentEventInfo()
			local zijiName = GetUnitName("player", true)
			if zijiName==srcName then return end

			--print(eventType)print(srcGUID) print(srcName)
		    if eventType == "SPELL_CAST_SUCCESS" then
				if IsInRaid() then
						local numGroupMembers = GetNumGroupMembers()
						for p=1,numGroupMembers do
							local PlayerName = GetUnitName("raid"..p, true)
							if srcName==PlayerName then
								for i=1,#PIG_Per['SpellJK']["Spell_list"][tabID] do
									if PIG_Per['SpellJK']["Spell_list"][tabID][i][2]==spellName then
										local className, classFilename = UnitClass("raid"..p);
										local rPerc, gPerc, bPerc, argbHex = GetClassColor(classFilename);
										local jinengjiankongcharuweizhi = 1;
										for b=#spellmululiebiao,1,-1 do
											if spellmululiebiao[b] then
												if spellmululiebiao[b][1]==spellName then
													jinengjiankongcharuweizhi = b;
													break
												end
											end
										end
														--1技能名/2技能图标/3CD/4开始冷却时间/5施法者/6施法职业颜色
										local shifaxinxi={spellName, PIG_Per['SpellJK']["Spell_list"][tabID][i][3],PIG_Per['SpellJK']["Spell_list"][tabID][i][5],GetTime(),PlayerName,{rPerc, gPerc, bPerc}}		      					
										table.insert(spellmululiebiao,jinengjiankongcharuweizhi+1, shifaxinxi);
										return
									end
								end
							end
						end
				else
						local numSubgroupMembers = GetNumSubgroupMembers()
						for p=1,numSubgroupMembers do
							local PlayerName = GetUnitName("party"..p, true)
							if srcName==PlayerName then
								for i=1,#PIG_Per['SpellJK']["Spell_list"][tabID] do
									if PIG_Per['SpellJK']["Spell_list"][tabID][i][2]==spellName then
										local className, classFilename = UnitClass("party"..p);
										local rPerc, gPerc, bPerc, argbHex = GetClassColor(classFilename);
										local jinengjiankongcharuweizhi = 0;
										for b=#spellmululiebiao,1,-1 do
											if spellmululiebiao[b] then
												if spellmululiebiao[b][1]==spellName then
													jinengjiankongcharuweizhi = b;
													break
												end
											end
										end
										local shifaxinxi={spellName, PIG_Per['SpellJK']["Spell_list"][tabID][i][3],PIG_Per['SpellJK']["Spell_list"][tabID][i][5],GetTime(),PlayerName,{rPerc, gPerc, bPerc}}		      					
										table.insert(spellmululiebiao,jinengjiankongcharuweizhi+1, shifaxinxi);
										return
									end
								end
							end
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
local function addspellP(shuruspID)
	print(shuruspID)
	local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(shuruspID)
	local cooldownMS, gcdMS = GetSpellBaseCooldown(shuruspID)
	if not name or not cooldownMS then print("|cff00FFFF!Pig:|r|cffFFFF00不是有效的技能ID！|r") return end
	if cooldownMS==0 then print("|cff00FFFF!Pig:|r|cffFFFF00该技能没有CD，无需监控！|r") return end
	for g=1,#PIG_Per['SpellJK']["Spell_list"][tabID] do
		if name==PIG_Per['SpellJK']["Spell_list"][tabID][g][2] then
			print("|cff00FFFF!Pig:|r|cffFFFF00已存在同名技能，请删除后再添加(建议添加技能的最高等级ID)！|r") 
			return
		end
	end
	local link="\124cff71d5ff\124Hspell:"..spellId.."\124h["..name.."]\124h\124r";
	table.insert(PIG_Per['SpellJK']["Spell_list"][tabID], {spellId,name,icon,link,cooldownMS});
	gengxinhang(fuFrame.list.Scroll)
end
fuFrame.list.add:SetScript("OnClick", function (self)
	local fujiF=self:GetParent().E
	local shuruspID=fujiF:GetNumber()
	addspellP(shuruspID)
	fujiF:ClearFocus()
	fujiF:SetText("")
end);
fuFrame.list.E:SetScript("OnEnterPressed", function(self)
	local shuruspID=self:GetNumber()
	addspellP(shuruspID)
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
---载入默认
fuFrame.Spell_moren={}
if tocversion<40000 then
	fuFrame.Spell_moren={
		871,12975,1161,5209,29166,20748,17116,633,19752,5599,1044,20608,16188,6346,19801
	}
else
	fuFrame.Spell_moren={}
end
fuFrame.list.zairuMoren = CreateFrame("Button",nil,fuFrame.list, "UIPanelButtonTemplate");  
fuFrame.list.zairuMoren:SetSize(220,24);
fuFrame.list.zairuMoren:SetPoint("TOPLEFT",fuFrame.list.E,"BOTTOMLEFT",-8,1);
fuFrame.list.zairuMoren:SetText("清空现有并载入默认监控技能");
fuFrame.list.zairuMoren:SetScript("OnClick", function (self)
	PIG_Per['SpellJK']["Spell_list"][tabID]={}
	local shujuyaun = fuFrame.Spell_moren
	for i=1,#shujuyaun do
		local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(shujuyaun[i])
		if name then
			local cooldownMS, gcdMS = GetSpellBaseCooldown(shujuyaun[i])
			local link="\124cff71d5ff\124Hspell:"..shujuyaun[i].."\124h["..name.."]\124h\124r";
			table.insert(PIG_Per['SpellJK']["Spell_list"][tabID], {spellId,name,icon,link,cooldownMS});
		end
	end
	gengxinhang(fuFrame.list.Scroll)
end)
-------------
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
	if duiyouJiankong_UI then
		duiyouJiankong_UI:SetWidth(Hval)
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
		if _G["duiyouJiankong_list_"..i] then
			_G["duiyouJiankong_list_"..i]:SetHeight(Hval);
			_G["duiyouJiankong_list_"..i].icon:SetSize(Hval,Hval);
			_G["duiyouJiankong_list_"..i].jindutiao:SetHeight(Hval);
			_G["duiyouJiankong_list_"..i].jindutiao1:SetHeight(Hval);
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
		if _G["duiyouJiankong_list_"..i] then
			_G["duiyouJiankong_list_"..i].title:SetFont(GameFontNormal:GetFont(), Hval,"OUTLINE")
			_G["duiyouJiankong_list_"..i].titleCD:SetFont(GameFontNormal:GetFont(), Hval,"OUTLINE")
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
fuFrame.Open:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG_Per['SpellJK']['Open'][tabID]="ON";
		duiyouCD_ADD()
	else
		PIG_Per['SpellJK']['Open'][tabID]="OFF";
		StaticPopup_Show ("PIG_Reload_UI");
	end
end);
--=====================================
addonTable.duiyouCD = function()
	if PIG_Per['SpellJK']['Open'][tabID]=="ON" then
		fuFrame.Open:SetChecked(true);
		duiyouCD_ADD()
	end
end
local _, addonTable = ...;
--------------
local fuFrame = Pig_Options_RF_TAB_7_UI
--=======================================
local Skill_List = {'烹饪', '急救', '裁缝', '熔炼', '工程学', '锻造', '附魔', '制皮', '炼金术',"珠宝加工","铭文"};

local ActionW = ActionButton1:GetWidth()
local Width,Height=ActionW,ActionW;
--父框架
local function Classes_addUI()
	if Classes_UI then return end
	local Classes = CreateFrame("Frame", "Classes_UI", UIParent);
	Classes:SetSize(Width*10+12,Height);
	Classes:SetPoint("CENTER",UIParent,"CENTER",0,-200);
	Classes:SetMovable(true)
	Classes:SetClampedToScreen(true)
	Classes:Hide()
	if PIG['PigUI']['ActionBar_bili']=="ON" then
		Classes:SetScale(PIG['PigUI']['ActionBar_bili_value']);
	end
	Classes.yidong = CreateFrame("Frame", nil, Classes,"BackdropTemplate")
	Classes.yidong:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 6,})
	Classes.yidong:SetSize(10,ActionW)
	Classes.yidong:SetPoint("LEFT", Classes, "LEFT", 0, 0);
	Classes.yidong:EnableMouse(true)
	Classes.yidong:RegisterForDrag("LeftButton")
	Classes.yidong:SetScript("OnDragStart",function()
		Classes:StartMoving()
	end)
	Classes.yidong:SetScript("OnDragStop",function()
		Classes:StopMovingOrSizing()
	end)
	Classes.nr = CreateFrame("Frame", nil, Classes,"BackdropTemplate");
	Classes.nr:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 0, edgeSize = 6,insets = { left = 0, right = 0, top = 0, bottom = 0 }});
	Classes.nr:SetBackdropColor(0.4, 0.4, 0.4, 0.5);
	Classes.nr:SetBackdropBorderColor(0.4, 0.4, 0.4, 0.5);
	Classes.nr:SetSize(Width*10,Height+4);
	Classes.nr:SetPoint("LEFT",Classes,"LEFT",12,0);
end
----------
local function gengxinkuanduinfo()
	local Width = ActionButton1:GetWidth()
	local geshu = {Classes_UI.nr:GetChildren()};
	if #geshu<1 then
		Classes_UI:Hide();
	else
		Classes_UI:Show();
		local NewWidth = Width+2;
		local NewWidth = NewWidth*#geshu;
		Classes_UI.nr:SetWidth(NewWidth);
		Classes_UI:SetWidth(NewWidth+12);
	end
end
addonTable.Classes_gengxinkuanduinfo=gengxinkuanduinfo;
-----炉石专业按钮----------------------
local function Classes_Lushi()
	if General_UI==nil then
		local ziFuFrame = Classes_UI.nr
		local ActionWw = Classes_UI:GetHeight()
		local Width,Height=ActionWw,ActionWw;
		ziFuFrame.General = CreateFrame("Button", "General_UI", ziFuFrame, "SecureActionButtonTemplate",8690);
		ziFuFrame.General:SetNormalTexture(134414)
		ziFuFrame.General:SetHighlightTexture(130718);
		ziFuFrame.General:SetSize(Width-1,Height-1);
		local geshu = {ziFuFrame:GetChildren()};
		ziFuFrame.General:SetPoint("LEFT",ziFuFrame,"LEFT",(#geshu-1)*(Width+2),0);
		ziFuFrame.General:SetScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",2,4);
			GameTooltip:AddLine("左击-|cff00FFFF使用炉石\r|r右击-|cff00FFFF专业技能|r")
			GameTooltip:Show();
		end);
		ziFuFrame.General:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		ziFuFrame.General.Border = ziFuFrame.General:CreateTexture(nil, "BORDER");
		ziFuFrame.General.Border:SetTexture(130841);
		ziFuFrame.General.Border:ClearAllPoints();
		ziFuFrame.General.Border:SetPoint("TOPLEFT",ziFuFrame.General,"TOPLEFT",-Width*0.394,Height*0.394);
		ziFuFrame.General.Border:SetPoint("BOTTOMRIGHT",ziFuFrame.General,"BOTTOMRIGHT",Width*0.394,-Height*0.394);

		ziFuFrame.General.Down = ziFuFrame.General:CreateTexture(nil, "OVERLAY");
		ziFuFrame.General.Down:SetTexture(130839);
		ziFuFrame.General.Down:SetAllPoints(ziFuFrame.General)
		ziFuFrame.General.Down:Hide();
		ziFuFrame.General:SetScript("OnMouseDown", function (self)
			self.Down:Show();
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		ziFuFrame.General:SetScript("OnMouseUp", function (self)
			self.Down:Hide();
		end);

		ziFuFrame.General.Err = ziFuFrame.General:CreateTexture(nil, "OVERLAY");
		ziFuFrame.General.Err:SetTexture(130842);
		ziFuFrame.General.Err:SetBlendMode("ADD");
		ziFuFrame.General.Err:SetAllPoints(ziFuFrame.General)
		ziFuFrame.General.Err:Hide();

		ziFuFrame.General.Cooldown = CreateFrame("Frame", nil, ziFuFrame.General);
		ziFuFrame.General.Cooldown:SetAllPoints()
		ziFuFrame.General.Cooldown:SetScale(0.72);
		ziFuFrame.General.Cooldown.N = CreateFrame("Cooldown", nil, ziFuFrame.General.Cooldown, "CooldownFrameTemplate")
		ziFuFrame.General.Cooldown.N:SetAllPoints()

		ziFuFrame.General.START = ziFuFrame.General:CreateTexture(nil, "OVERLAY");
		ziFuFrame.General.START:SetTexture(130724);
		ziFuFrame.General.START:SetBlendMode("ADD");
		ziFuFrame.General.START:SetAllPoints(ziFuFrame.General)
		ziFuFrame.General.START:Hide();
		ziFuFrame.General:RegisterForClicks("AnyUp");
		ziFuFrame.General:SetAttribute("type1", "item");
		ziFuFrame.General:SetAttribute("item", "炉石");
		ziFuFrame.General:SetAttribute("type2", "spell");
		ziFuFrame.General:SetAttribute("spell", "烹饪");
		local function Skill_Button_Genxin()
			if InCombatLockdown() then return end
			local _, _, tabOffset, numEntries = GetSpellTabInfo(1)
			for ii=1, #Skill_List do
				local Skill_xxxx =false;
				for i=tabOffset + 1, tabOffset + numEntries do
					local spellName, _ = GetSpellBookItemName(i, BOOKTYPE_SPELL)
					if spellName==Skill_List[ii] then
						Skill_xxxx =true;
						ziFuFrame.General:SetAttribute("type2", "spell");
						ziFuFrame.General:SetAttribute("spell", spellName);
						break
					end
					if Skill_xxxx then break end
				end
				if Skill_xxxx then break end
			end
		end
		local function gengxinlushiCD()
	 		local start, duration = GetSpellCooldown(8690);
		 	ziFuFrame.General.Cooldown.N:SetCooldown(start, duration);
	 	end
		ziFuFrame.General:RegisterUnitEvent("UNIT_SPELLCAST_START","player");
		ziFuFrame.General:RegisterUnitEvent("UNIT_SPELLCAST_STOP","player");
		ziFuFrame.General:RegisterEvent("SPELL_UPDATE_COOLDOWN")
		ziFuFrame.General:SetScript("OnEvent", function(self,event,arg1,_,arg3)
			if arg3==8690 then 
				if event=="UNIT_SPELLCAST_START" then
			 		ziFuFrame.General.START:Show();
			 	end
			 	if event=="UNIT_SPELLCAST_STOP" then
			 		ziFuFrame.General.START:Hide();
				end	
		 	end
			if event=="SPELL_UPDATE_COOLDOWN" then
				C_Timer.After(1, gengxinlushiCD);
			end
		end)
		C_Timer.After(3, Skill_Button_Genxin);
		C_Timer.After(3, gengxinlushiCD);
	end
	gengxinkuanduinfo()
end

------------------
---职业技能+工程物品
local function Classes_Spell()
	if Zhushou_UI==nil then
		local ziFuFrame = Classes_UI.nr
		local ActionWw = Classes_UI:GetHeight()
		local Width,Height=ActionWw,ActionWw;
		ziFuFrame.Zhushou = CreateFrame("Button", "Zhushou_UI", ziFuFrame);
		ziFuFrame.Zhushou:SetNormalTexture(131146);
		local IconCoord = CLASS_ICON_TCOORDS[select(2,UnitClass("player"))];
		if IconCoord then
			local regions = { ziFuFrame.Zhushou:GetRegions() }
			regions[1]:SetTexCoord(unpack(IconCoord));
		end
		ziFuFrame.Zhushou:SetHighlightTexture(130718);
		ziFuFrame.Zhushou:SetSize(Width-1,Height-1);
		local geshu = {ziFuFrame:GetChildren()};
		ziFuFrame.Zhushou:SetPoint("LEFT",ziFuFrame,"LEFT",(#geshu-1)*(Width+2),0);
		ziFuFrame.Zhushou:RegisterForClicks("LeftButtonUp","RightButtonUp");
		ziFuFrame.Zhushou:SetScript("OnEnter", function ()
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(ziFuFrame.Zhushou, "ANCHOR_TOPLEFT",2,4);
			GameTooltip:AddLine("左击-|cff00FFFF便捷使用技能物品(需手动拖入技能或物品)|r\n右击-|cff00FFFF打开Recount/Details插件记录面板|r")
			GameTooltip:Show();
		end);
		ziFuFrame.Zhushou:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		ziFuFrame.Zhushou.Border = ziFuFrame.Zhushou:CreateTexture(nil, "BORDER");
		ziFuFrame.Zhushou.Border:SetTexture(130841);
		ziFuFrame.Zhushou.Border:ClearAllPoints();
		ziFuFrame.Zhushou.Border:SetPoint("TOPLEFT",ziFuFrame.Zhushou,"TOPLEFT",-Width*0.38,Height*0.39);
		ziFuFrame.Zhushou.Border:SetPoint("BOTTOMRIGHT",ziFuFrame.Zhushou,"BOTTOMRIGHT",Width*0.4,-Height*0.4);

		ziFuFrame.Zhushou.Down = ziFuFrame.Zhushou:CreateTexture(nil, "OVERLAY");
		ziFuFrame.Zhushou.Down:SetTexture(130839);
		ziFuFrame.Zhushou.Down:SetAllPoints(ziFuFrame.Zhushou)
		ziFuFrame.Zhushou.Down:Hide();
		ziFuFrame.Zhushou:SetScript("OnMouseDown", function (self)
			self.Down:Show();
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		ziFuFrame.Zhushou:SetScript("OnMouseUp", function (self)
			self.Down:Hide();
		end);

		ziFuFrame.Zhushou.Err = ziFuFrame.Zhushou:CreateTexture(nil, "OVERLAY");
		ziFuFrame.Zhushou.Err:SetTexture(130842);
		ziFuFrame.Zhushou.Err:SetBlendMode("ADD");
		ziFuFrame.Zhushou.Err:SetAllPoints(ziFuFrame.Zhushou)
		ziFuFrame.Zhushou.Err:Hide();

		--内容页----
		ziFuFrame.Zhushou.List = CreateFrame("Frame", "Zhushou_List_UI", ziFuFrame.Zhushou,"BackdropTemplate");
		ziFuFrame.Zhushou.List:SetBackdrop({edgeFile = "interface/friendsframe/ui-toast-border.blp", edgeSize = 6,})
		ziFuFrame.Zhushou.List:SetSize((Width+6)*2+14,(Height+6)*6+14);
		ziFuFrame.Zhushou.List:ClearAllPoints();
		ziFuFrame.Zhushou.List:SetPoint("BOTTOM", Zhushou, "TOP", 0, 4)
		tinsert(UISpecialFrames,"Zhushou_List_UI");
		ziFuFrame.Zhushou.List:Hide();
		if PIG['PigUI']['ActionBar_bili']=="ON" then
			ziFuFrame.Zhushou.List:SetScale(PIG['PigUI']['ActionBar_bili_value']);
		end
		ziFuFrame.Zhushou.List:RegisterEvent("PLAYER_REGEN_DISABLED");--进入战斗
		ziFuFrame.Zhushou.List:SetScript("OnEvent", function()
			if not InCombatLockdown() then Zhushou_List_UI:Hide(); end
		end);
		ziFuFrame.Zhushou:SetScript("OnClick", function (self, event)
			if not InCombatLockdown() then
				if event=="LeftButton" then
					if Zhushou_List_UI:IsShown() then	
						Zhushou_List_UI:Hide();
					else
						local offset = Zhushou_UI:GetTop()-200;
						local pingmuH=GetScreenHeight();
						if offset>(pingmuH/2) then
							ziFuFrame.Zhushou.List:ClearAllPoints();
							ziFuFrame.Zhushou.List:SetPoint("TOP", ziFuFrame.Zhushou, "BOTTOM", 0, -4)
						else
							ziFuFrame.Zhushou.List:ClearAllPoints();
							ziFuFrame.Zhushou.List:SetPoint("BOTTOM", ziFuFrame.Zhushou, "TOP", 0, 4)
						end
						Zhushou_List_UI:Show();
					end
				else
					if Recount then
						if Recount.MainWindow:IsShown() then
							Recount.MainWindow:Hide()
						else
							Recount.MainWindow:Show()
							Recount:RefreshMainWindow()
						end
					elseif DetailsBaseFrame1 then
						for i=1,10 do
							if not _G["DetailsBaseFrame"..i] then break end
							if _G["DetailsBaseFrame"..i]:IsShown() then
								_G["DetailsBaseFrame"..i]:Hide()
							else
								_G["DetailsBaseFrame"..i]:Show()
							end
						end
					else
						print("\124cff00FFFF!Pig：\124cffffFF00未安装Recount/Details！\124r");
					end
				end
			end
		end);
		--==============================================================================
		local anniugeshu,anniujiange=12,6;
		local Classes_MacroEventCount=0;
		local Classws_MacroDeleted = false;
		local Classes_MacroCount=0
		local function IncBetween(Val, Low, High)
			return Val >= Low and Val <= High;
		end
		-----------
		local function RefreshMacro(id)
			if (InCombatLockdown()) then  return  end
			local OldIndex = PIG_Per['Classes']['Spell_list'][id][2]
			local OldName = PIG_Per['Classes']['Spell_list'][id][3]
			local Oldbody = PIG_Per['Classes']['Spell_list'][id][5]
			local TrimBody = strtrim(Oldbody or '');--去除空格
			local AccMacros, CharMacros = GetNumMacros();
			local BodyIndex = 0;
			--未变
			local Name, Icon, Body = GetMacroInfo(OldIndex);
			if (TrimBody == strtrim(Body or '') and OldName == Name) then
				local Name, Icon, Body = GetMacroInfo(OldIndex);
				PIG_Per['Classes']['Spell_list'][id][4]=Icon
				_G["Zhushou_anniu_"..id].icon:SetTexture(Icon);
				return;	
			end
			--删除重新定位
			if (IncBetween(OldIndex - 1, 1, AccMacros) or IncBetween(OldIndex - 1, MAX_ACCOUNT_MACROS + 1, MAX_ACCOUNT_MACROS + CharMacros)) then
				local Name, Icon, Body = GetMacroInfo(OldIndex - 1);
				if (TrimBody == strtrim(Body or '') and OldName == Name) then
					PIG_Per['Classes']['Spell_list'][id][2]=OldIndex-1
					PIG_Per['Classes']['Spell_list'][id][4]=Icon
					_G["Zhushou_anniu_"..id].icon:SetTexture(Icon);	
					_G["Zhushou_anniu_"..id]:SetAttribute("macro", PIG_Per['Classes']['Spell_list'][id][2]);
					return;				
				end
			end
			--增加重新定位
			if (IncBetween(OldIndex + 1, 1, AccMacros) or IncBetween(OldIndex + 1, MAX_ACCOUNT_MACROS + 1, MAX_ACCOUNT_MACROS + CharMacros)) then
				local Name, Icon, Body = GetMacroInfo(OldIndex + 1);
				if (TrimBody == strtrim(Body or '') and OldName == Name) then
					PIG_Per['Classes']['Spell_list'][id][2]=OldIndex+1
					PIG_Per['Classes']['Spell_list'][id][4]=Icon
					_G["Zhushou_anniu_"..id].icon:SetTexture(Icon);	
					_G["Zhushou_anniu_"..id]:SetAttribute("macro", OldIndex+1);
					return;
				end
			end
			--其他宏改名后搜索相同宏位置
			for i = 1, AccMacros do
				local Name, Icon, Body = GetMacroInfo(i);
				local Body = strtrim(Body or '');
				if (TrimBody == Body and OldName == Name) then
					PIG_Per['Classes']['Spell_list'][id][2]=i
					PIG_Per['Classes']['Spell_list'][id][4]=Icon
					_G["Zhushou_anniu_"..id].icon:SetTexture(Icon);	
					BodyIndex = i;
					_G["Zhushou_anniu_"..id]:SetAttribute("macro", PIG_Per['Classes']['Spell_list'][id][2]);
					return;
				end
			
				if (TrimBody == Body and Body ~= nil and Body ~= "") then
					BodyIndex = i;
				end
			end
			--搜索角色宏
			for i = MAX_ACCOUNT_MACROS + 1, MAX_ACCOUNT_MACROS + CharMacros do
				local Name, Icon, Body = GetMacroInfo(i);
				local Body = strtrim(Body or '');
				if (TrimBody == Body and OldName == Name) then
					PIG_Per['Classes']['Spell_list'][id][2]=i
					PIG_Per['Classes']['Spell_list'][id][4]=Icon
					_G["Zhushou_anniu_"..id].icon:SetTexture(Icon);	
					_G["Zhushou_anniu_"..id]:SetAttribute("macro", PIG_Per['Classes']['Spell_list'][id][2]);
					return;
				end
				if (TrimBody == Body and Body ~= nil and Body ~= "") then
					BodyIndex = i;
				end
			end
			--无删除未找到名称和内容均相同的
			if Classws_MacroDeleted==false then
				--有相同body
				if (BodyIndex ~= 0) then 
					PIG_Per['Classes']['Spell_list'][id][2]=BodyIndex
					local Name, Icon, Body = GetMacroInfo(BodyIndex);
					PIG_Per['Classes']['Spell_list'][id][3]=Name
					PIG_Per['Classes']['Spell_list'][id][4]=Icon
					_G["Zhushou_anniu_"..id].icon:SetTexture(Icon);	
					_G["Zhushou_anniu_"..id].Name:SetText(Name);
					_G["Zhushou_anniu_"..id]:SetAttribute("macro", PIG_Per['Classes']['Spell_list'][id][2]);
					return;
				end
				--有相同Name
				local Name, Icon, Body = GetMacroInfo(OldIndex);
				if (OldName == Name) then
					PIG_Per['Classes']['Spell_list'][id][4]=Icon
					PIG_Per['Classes']['Spell_list'][id][5]=Body
					_G["Zhushou_anniu_"..id].icon:SetTexture(Icon);
					return;
				end
			end
			--有删除
			if Classws_MacroDeleted==true then
				PIG_Per['Classes']['Spell_list'][id]={}	
				_G["Zhushou_anniu_"..id].icon:SetTexture();
				_G["Zhushou_anniu_"..id].Count:SetText();
				_G["Zhushou_anniu_"..id].Name:SetText();
				_G["Zhushou_anniu_"..id.."Cooldown"]:Hide()
				_G["Zhushou_anniu_"..id]:SetAttribute("type",nil);
				local Showvalue = GetCVarInfo("alwaysShowActionBars")
				if Showvalue=="1" then
					_G["Zhushou_anniu_"..id]:Show();
				else
					_G["Zhushou_anniu_"..id]:Hide();
				end
				Classws_MacroDeleted = false;
				Classes_MacroCount = AccMacros + CharMacros;	
			end
		end
		----------
		local function Classes_ICON_Tooltip()
			if InCombatLockdown() then return end
			for id=1,anniugeshu do
				_G["Zhushou_anniu_"..id]:Hide();
				_G["Zhushou_anniu_"..id].icon:SetTexture();
				_G["Zhushou_anniu_"..id].Count:SetText();
				_G["Zhushou_anniu_"..id].Name:SetText();
			end
			for id=1,anniugeshu do
				if PIG_Per['Classes']['Spell_list'][id] and #PIG_Per['Classes']['Spell_list'][id]>0 then
					local leibie=PIG_Per['Classes']['Spell_list'][id][1]
					local spieID=PIG_Per['Classes']['Spell_list'][id][2]
					_G["Zhushou_anniu_"..id]:Show();
					if leibie=="item" then
						local itemIcon = GetItemIcon(spieID)
						_G["Zhushou_anniu_"..id].icon:SetTexture(itemIcon);
						local Ccount = GetItemCount(spieID)
						local _,dalei,xiaolei = GetItemInfoInstant(spieID)
						if dalei=="消耗品" and xiaolei=="消耗品" then
							if Ccount>0 then
								_G["Zhushou_anniu_"..id].icon:SetVertexColor(1, 1, 1);
								_G["Zhushou_anniu_"..id].Count:SetText(Ccount);
							else
								_G["Zhushou_anniu_"..id].icon:SetVertexColor(0.5, 0.5, 0.5);
								_G["Zhushou_anniu_"..id].Count:SetText("|cffff0000"..Ccount.."|r");
							end
						else
							if Ccount>0 then
								_G["Zhushou_anniu_"..id].icon:SetVertexColor(1, 1, 1);
							else
								_G["Zhushou_anniu_"..id].icon:SetVertexColor(0.5, 0.5, 0.5);
							end
						end
						local start, duration, enable = GetItemCooldown(spieID)
						_G["Zhushou_anniu_"..id.."Cooldown"]:SetCooldown(start, duration);
						_G["Zhushou_anniu_"..id]:SetScript("OnEnter", function (self)
							if #PIG_Per['Classes']['Spell_list'][id]>0 then
								local leibie=PIG_Per['Classes']['Spell_list'][id][1]
								local spieID=PIG_Per['Classes']['Spell_list'][id][2]
								GameTooltip:ClearLines();
								GameTooltip:SetOwner(_G["Zhushou_anniu_"..id], "ANCHOR_NONE");
								GameTooltip:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",-100,140);
								for Bagid=0,4,1 do
									local numberOfSlots = GetContainerNumSlots(Bagid);
									for caowei=1,numberOfSlots,1 do
										if GetContainerItemID(Bagid, caowei)==spieID then
											GameTooltip:SetBagItem(Bagid,caowei);
											GameTooltip:Show();
											return
										end
									end
								end
								GameTooltip:SetHyperlink(leibie..":"..spieID)
								GameTooltip:Show();
							end
						end);
						_G["Zhushou_anniu_"..id]:SetScript("OnLeave", function ()
							GameTooltip:ClearLines();
							GameTooltip:Hide() 
						end);
					elseif leibie=="spell" then
						local icon = GetSpellTexture(spieID)
						_G["Zhushou_anniu_"..id].icon:SetTexture(icon);
						local SPhuafei=IsConsumableSpell(spieID)
						if SPhuafei then
							local jiengncailiao = GetSpellCount(spieID)
							if jiengncailiao>0 then
					            _G["Zhushou_anniu_"..id].Count:SetText(jiengncailiao)
					        else
					        	_G["Zhushou_anniu_"..id].Count:SetText("|cffff0000"..jiengncailiao.."|r")
					        end
					    else
							_G["Zhushou_anniu_"..id].Count:SetText()
					    end
					    local start, duration = GetSpellCooldown(spieID);
						_G["Zhushou_anniu_"..id.."Cooldown"]:SetCooldown(start, duration);
						_G["Zhushou_anniu_"..id]:SetScript("OnEnter", function (self)
							if #PIG_Per['Classes']['Spell_list'][id]>0 then
								local leibie=PIG_Per['Classes']['Spell_list'][id][1]
								local spieID=PIG_Per['Classes']['Spell_list'][id][2]
								GameTooltip:ClearLines();
								GameTooltip:SetOwner(_G["Zhushou_anniu_"..id], "ANCHOR_NONE");
								GameTooltip:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",-100,140);
								if IsSpellKnown(spieID) then
									for i = 1, GetNumSpellTabs() do
										local _, _, offset, numSlots = GetSpellTabInfo(i)
										for j = offset+1, offset+numSlots do
											local _,bookspellID= GetSpellBookItemInfo(j, BOOKTYPE_SPELL)
											if spieID==bookspellID then
												local _,jibiex= GetSpellBookItemName(j, BOOKTYPE_SPELL)
												GameTooltipTextRight1:Show()
												GameTooltip:SetSpellBookItem(j, BOOKTYPE_SPELL);
												GameTooltipTextRight1:SetText(jibiex)
												GameTooltip:Show();
												return
											end
										end
									end
								else
									GameTooltip:SetHyperlink(leibie..":"..spieID)
									GameTooltip:Show();
								end	
							end
						end);
						_G["Zhushou_anniu_"..id]:SetScript("OnLeave", function ()
							GameTooltip:ClearLines();
							GameTooltip:Hide() 
						end);
					elseif leibie=="macro" then
						_G["Zhushou_anniu_"..id].icon:SetTexture(PIG_Per['Classes']['Spell_list'][id][4]);
						_G["Zhushou_anniu_"..id].Name:SetText(PIG_Per['Classes']['Spell_list'][id][3]);
						local hongleibie=PIG_Per['Classes']['Spell_list'][id][6]
						if hongleibie=="spell" then
							local SPhuafei=IsConsumableSpell(PIG_Per['Classes']['Spell_list'][id][7])
							if SPhuafei then
								_G["Zhushou_anniu_"..id].Name:SetText();
								local jiengncailiao = GetSpellCount(PIG_Per['Classes']['Spell_list'][id][7])
								if jiengncailiao>0 then
						            _G["Zhushou_anniu_"..id].Count:SetText(jiengncailiao)
						        else
						        	_G["Zhushou_anniu_"..id].Count:SetText("|cffff0000"..jiengncailiao.."|r")
						        end
						    else
								_G["Zhushou_anniu_"..id].Count:SetText()
						    end
			    			local start, duration = GetSpellCooldown(PIG_Per['Classes']['Spell_list'][id][7]);
							_G["Zhushou_anniu_"..id.."Cooldown"]:SetCooldown(start, duration);
						elseif hongleibie=="item" then
							local Ccount = GetItemCount(PIG_Per['Classes']['Spell_list'][id][7])
							local _,dalei,xiaolei = GetItemInfoInstant(PIG_Per['Classes']['Spell_list'][id][7])
							if dalei=="消耗品" and xiaolei=="消耗品" then
								_G["Zhushou_anniu_"..id].Name:SetText();
								if Ccount>0 then
									_G["Zhushou_anniu_"..id].icon:SetVertexColor(1, 1, 1);
									_G["Zhushou_anniu_"..id].Count:SetText(Ccount);
								else
									_G["Zhushou_anniu_"..id].icon:SetVertexColor(0.5, 0.5, 0.5);
									_G["Zhushou_anniu_"..id].Count:SetText("|cffff0000"..Ccount.."|r");
								end
							else
								_G["Zhushou_anniu_"..id].Name:SetText(PIG_Per['Classes']['Spell_list'][id][3]);
								if Ccount>0 then
									_G["Zhushou_anniu_"..id].icon:SetVertexColor(1, 1, 1);
								else
									_G["Zhushou_anniu_"..id].icon:SetVertexColor(0.5, 0.5, 0.5);
								end
							end
							local start, duration = GetItemCooldown(PIG_Per['Classes']['Spell_list'][id][7]);
							_G["Zhushou_anniu_"..id.."Cooldown"]:SetCooldown(start, duration);
						end
						_G["Zhushou_anniu_"..id]:SetScript("OnEnter", function (self)
							if #PIG_Per['Classes']['Spell_list'][id]>0 then
								local hongleibie=PIG_Per['Classes']['Spell_list'][id][6]
								GameTooltip:ClearLines();
								GameTooltip:SetOwner(_G["Zhushou_anniu_"..id], "ANCHOR_NONE");
								GameTooltip:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",-100,140);
								if hongleibie=="spell" then
									if IsSpellKnown(PIG_Per['Classes']['Spell_list'][id][7]) then
										for i = 1, GetNumSpellTabs() do
											local _, _, offset, numSlots = GetSpellTabInfo(i)
											for j = offset+1, offset+numSlots do
												local _,bookspellID= GetSpellBookItemInfo(j, BOOKTYPE_SPELL)
												if PIG_Per['Classes']['Spell_list'][id][7]==bookspellID then
													local _,jibiex= GetSpellBookItemName(j, BOOKTYPE_SPELL)
													GameTooltipTextRight1:Show()
													GameTooltip:SetSpellBookItem(j, BOOKTYPE_SPELL);
													GameTooltipTextRight1:SetText(jibiex)
													GameTooltip:Show();
													return
												end
											end
										end
									else
										GameTooltip:SetHyperlink("spell:"..PIG_Per['Classes']['Spell_list'][id][7])
										GameTooltip:Show();
									end
								elseif hongleibie=="item" then	
									for Bagid=0,4,1 do
										local numberOfSlots = GetContainerNumSlots(Bagid);
										for caowei=1,numberOfSlots,1 do
											if GetContainerItemID(Bagid, caowei)==PIG_Per['Classes']['Spell_list'][id][7] then
												GameTooltip:SetBagItem(Bagid,caowei);
												GameTooltip:Show();
												return
											end
										end
									end
									GameTooltip:SetHyperlink("item:"..PIG_Per['Classes']['Spell_list'][id][7])
									GameTooltip:Show();
								else
									GameTooltip:SetText(PIG_Per['Classes']['Spell_list'][id][3],1, 1, 1, 1)
									GameTooltip:Show();
								end
							end
						end);
						_G["Zhushou_anniu_"..id]:SetScript("OnLeave", function ()
							GameTooltip:ClearLines();
							GameTooltip:Hide() 
						end);
					end
					-------------
					_G["Zhushou_anniu_"..id]:SetScript("OnDragStart", function (self)
						local leibie=PIG_Per['Classes']['Spell_list'][id][1]
						local spieID=PIG_Per['Classes']['Spell_list'][id][2]
						local lockvalue = GetCVarInfo("lockActionBars")
						if lockvalue=="0" then
							if leibie=="item" then
								PickupItem(spieID)
								self.icon:SetTexture();
								self.Count:SetText();
								self.Name:SetText();
								_G[self:GetName().."Cooldown"]:Hide()
								self:SetAttribute("type", nil);
								self:SetAttribute("item", nil);
								PIG_Per['Classes']['Spell_list'][id]={}
							elseif leibie=="spell" then
								PickupSpell(spieID)
								self.icon:SetTexture();
								self.Count:SetText();
								self.Name:SetText();
								_G[self:GetName().."Cooldown"]:Hide()
								self:SetAttribute("type", nil);
								self:SetAttribute("spell", nil);
								PIG_Per['Classes']['Spell_list'][id]={}
							elseif leibie=="macro" then
								PickupMacro(spieID)
								self.icon:SetTexture();
								self.Count:SetText();
								self.Name:SetText();
								_G[self:GetName().."Cooldown"]:Hide()
								self:SetAttribute("type", nil);
								self:SetAttribute("macro", nil);
								PIG_Per['Classes']['Spell_list'][id]={}	
							end
						elseif lockvalue=="1" then
							local aShiftKeyIsDown = IsShiftKeyDown();
							if aShiftKeyIsDown then
								if leibie=="item" then
									PickupItem(spieID)
									self.icon:SetTexture();
									self.Count:SetText();
									self.Name:SetText();
									_G[self:GetName().."Cooldown"]:Hide()
									self:SetAttribute("type", nil);
									self:SetAttribute("item", nil);
									PIG_Per['Classes']['Spell_list'][id]={}
								elseif leibie=="spell" then
									PickupSpell(spieID)
									self.icon:SetTexture();
									self.Count:SetText();
									self.Name:SetText();
									_G[self:GetName().."Cooldown"]:Hide()
									self:SetAttribute("type", nil);
									self:SetAttribute("spell", nil);
									PIG_Per['Classes']['Spell_list'][id]={}
								elseif leibie=="macro" then
									PickupMacro(spieID)
									self.icon:SetTexture();
									self.Count:SetText();
									self.Name:SetText();
									_G[self:GetName().."Cooldown"]:Hide()
									self:SetAttribute("type", nil);
									self:SetAttribute("macro", nil);
									PIG_Per['Classes']['Spell_list'][id]={}	
								end
							end
						end	
					end);
					----
					_G["Zhushou_anniu_"..id]:HookScript("OnEvent", function(self,event,arg1,_,arg3)
						--print(event)
						if #PIG_Per['Classes']['Spell_list'][id]>0 then
							local leibie=PIG_Per['Classes']['Spell_list'][id][1]
							local spieID=PIG_Per['Classes']['Spell_list'][id][2]
							if event=="SPELL_UPDATE_COOLDOWN" then
								if leibie=="item" then
									local start, duration, enable = GetItemCooldown(spieID)
									_G["Zhushou_anniu_"..id.."Cooldown"]:SetCooldown(start, duration);
								elseif leibie=="spell" then
									local start, duration = GetSpellCooldown(spieID);
									_G["Zhushou_anniu_"..id.."Cooldown"]:SetCooldown(start, duration);
								elseif leibie=="macro" then
									if PIG_Per['Classes']['Spell_list'][id][6]=="spell" then
										local start, duration = GetSpellCooldown(PIG_Per['Classes']['Spell_list'][id][7]);
										_G["Zhushou_anniu_"..id.."Cooldown"]:SetCooldown(start, duration);
									elseif PIG_Per['Classes']['Spell_list'][id][6]=="item" then
										local start, duration = GetItemCooldown(PIG_Per['Classes']['Spell_list'][id][7]);
										_G["Zhushou_anniu_"..id.."Cooldown"]:SetCooldown(start, duration);
									end
								end
							end
							if event=="UNIT_SPELLCAST_START" then
								if leibie=="item" then
									local _,spellid=GetItemSpell(spieID)
									if arg3==spellid then 
							 			_G["Zhushou_anniu_"..id].START:Show();
							 		end
								elseif leibie=="spell" then
									if arg3==spieID then 
							 			_G["Zhushou_anniu_"..id].START:Show();
							 		end
								elseif leibie=="macro" then
									if PIG_Per['Classes']['Spell_list'][id][6]=="spell" then
										if arg3==PIG_Per['Classes']['Spell_list'][id][7] then 
								 			_G["Zhushou_anniu_"..id].START:Show();
								 		end
									elseif PIG_Per['Classes']['Spell_list'][id][6]=="item" then
										local _,spellid=GetItemSpell(PIG_Per['Classes']['Spell_list'][id][7])
										if arg3==spellid then 
								 			_G["Zhushou_anniu_"..id].START:Show();
								 		end
									end
								end
						 	end
						 	if event=="UNIT_SPELLCAST_STOP" then
								if leibie=="item" then
									local _,spellid=GetItemSpell(spieID)
									if arg3==spellid then 
							 			_G["Zhushou_anniu_"..id].START:Hide();
							 		end
								elseif leibie=="spell" then
									if arg3==spieID then 
							 			_G["Zhushou_anniu_"..id].START:Hide();
							 		end
								elseif leibie=="macro" then
									if PIG_Per['Classes']['Spell_list'][id][6]=="spell" then
										if arg3==PIG_Per['Classes']['Spell_list'][id][7] then 
								 			_G["Zhushou_anniu_"..id].START:Hide();
								 		end
									elseif PIG_Per['Classes']['Spell_list'][id][6]=="item" then
										local _,spellid=GetItemSpell(PIG_Per['Classes']['Spell_list'][id][7])
										if arg3==spellid then 
								 			_G["Zhushou_anniu_"..id].START:Hide();
								 		end
									end
								end
							end
							if event=="BAG_UPDATE" then
								if leibie=="item" then
									local Ccount = GetItemCount(spieID)
									local _,dalei,xiaolei = GetItemInfoInstant(spieID)
									if dalei=="消耗品" and xiaolei=="消耗品" then
										if Ccount>0 then
											_G["Zhushou_anniu_"..id].icon:SetVertexColor(1, 1, 1);
											_G["Zhushou_anniu_"..id].Count:SetText(Ccount);
										else
											_G["Zhushou_anniu_"..id].icon:SetVertexColor(0.5, 0.5, 0.5);
											_G["Zhushou_anniu_"..id].Count:SetText("|cffff0000"..Ccount.."|r");
										end
									else
										if Ccount>0 then
											_G["Zhushou_anniu_"..id].icon:SetVertexColor(1, 1, 1);
										else
											_G["Zhushou_anniu_"..id].icon:SetVertexColor(0.5, 0.5, 0.5);
										end
									end
								elseif leibie=="spell" then
								    local SPhuafei=IsConsumableSpell(spieID)
									if SPhuafei then
										local jiengncailiao = GetSpellCount(spieID)
										if jiengncailiao>0 then
								            _G["Zhushou_anniu_"..id].Count:SetText(jiengncailiao)
								        else
								        	_G["Zhushou_anniu_"..id].Count:SetText("|cffff0000"..jiengncailiao.."|r")
								        end
								    else
										_G["Zhushou_anniu_"..id].Count:SetText()
								    end
								elseif leibie=="macro" then
									if PIG_Per['Classes']['Spell_list'][id][6]=="spell" then
										local SPhuafei=IsConsumableSpell(PIG_Per['Classes']['Spell_list'][id][7])
										if SPhuafei then
											_G["Zhushou_anniu_"..id].Name:SetText();
											local jiengncailiao = GetSpellCount(PIG_Per['Classes']['Spell_list'][id][7])
											if jiengncailiao>0 then
									            _G["Zhushou_anniu_"..id].Count:SetText(jiengncailiao)
									        else
									        	_G["Zhushou_anniu_"..id].Count:SetText("|cffff0000"..jiengncailiao.."|r")
									        end
									    else
											_G["Zhushou_anniu_"..id].Count:SetText()
											_G["Zhushou_anniu_"..id].Name:SetText(PIG_Per['Classes']['Spell_list'][id][3]);
									    end
									elseif PIG_Per['Classes']['Spell_list'][id][6]=="item" then
										local Ccount = GetItemCount(PIG_Per['Classes']['Spell_list'][id][7])
										local _,dalei,xiaolei = GetItemInfoInstant(PIG_Per['Classes']['Spell_list'][id][7])
										if dalei=="消耗品" and xiaolei=="消耗品" then
											if Ccount>0 then
												_G["Zhushou_anniu_"..id].icon:SetVertexColor(1, 1, 1);
												_G["Zhushou_anniu_"..id].Count:SetText(Ccount);
											else
												_G["Zhushou_anniu_"..id].icon:SetVertexColor(0.5, 0.5, 0.5);
												_G["Zhushou_anniu_"..id].Count:SetText("|cffff0000"..Ccount.."|r");
											end
										else
											_G["Zhushou_anniu_"..id].Name:SetText(PIG_Per['Classes']['Spell_list'][id][3]);
											if Ccount>0 then
												_G["Zhushou_anniu_"..id].icon:SetVertexColor(1, 1, 1);
											else
												_G["Zhushou_anniu_"..id].icon:SetVertexColor(0.5, 0.5, 0.5);
											end
										end
									end
								end
							end
							if event=="UPDATE_MACROS" then
								local AccMacros, CharMacros = GetNumMacros();
								Classes_MacroEventCount=Classes_MacroEventCount+1;
								if leibie=="macro" then
									if Classes_MacroEventCount>5 then
										local AccMacros, CharMacros = GetNumMacros();
										if Classes_MacroCount==0 then
											Classes_MacroCount = AccMacros + CharMacros;
										elseif (Classes_MacroCount > (AccMacros + CharMacros)) then
											Classws_MacroDeleted = true;
										end
										RefreshMacro(id)
									end 
								end				
							end
							if event=="UNIT_SPELLCAST_SUCCEEDED" then
								if arg3==PIG_Per['Classes']['Spell_list'][id][2] then
									local Skill_List = {'烹饪', '急救', '裁缝', '熔炼', '工程学', '锻造', '制皮', '炼金术',"珠宝加工","铭文"};
									local Skill_List_FM = {'附魔', '训练宠物'};
									local Name = GetSpellInfo(arg3)
									for j=1,#Skill_List do
										if Name==Skill_List[j] then
											if TradeSkillFrame and TradeSkillFrame:IsShown() then
												_G["Zhushou_anniu_"..id].START:Show();
											else
												_G["Zhushou_anniu_"..id].START:Hide();
											end
										end
									end
									for j=1,#Skill_List_FM do
										if Name==Skill_List_FM[j] then
											if not CraftFrame then
												_G["Zhushou_anniu_"..id].START:Show();
											else
												if CraftFrame:IsShown() then
													_G["Zhushou_anniu_"..id].START:Hide();
												else
													_G["Zhushou_anniu_"..id].START:Show();
												end
											end
										end
									end
								end
							end
							if event=="TRADE_SKILL_CLOSE" or event=="CRAFT_CLOSE" then
								local function guanbigaoliang()
									_G["Zhushou_anniu_"..id].START:Hide();		
								end
								C_Timer.After(0.1,guanbigaoliang)
							end
						end
					end);
				else
					local Showvalue = GetCVarInfo("alwaysShowActionBars")
					if Showvalue=="1" then
						_G["Zhushou_anniu_"..id]:Show();
					end
				end
			end
		end	
		---------
		local function Classes_SPELL_ITEM()
			if (InCombatLockdown()) then  return  end
			for id=1,anniugeshu do
				if PIG_Per['Classes']['Spell_list'][id] then
					local leibie=PIG_Per['Classes']['Spell_list'][id][1]
					local spieID=PIG_Per['Classes']['Spell_list'][id][2]
					if leibie=="item" then
						local itemName = C_Item.GetItemNameByID(spieID)
						_G["Zhushou_anniu_"..id]:SetAttribute("type", leibie);
						_G["Zhushou_anniu_"..id]:SetAttribute(leibie, itemName);
					elseif leibie=="spell" then
						_G["Zhushou_anniu_"..id]:SetAttribute("type", leibie);
						_G["Zhushou_anniu_"..id]:SetAttribute(leibie, spieID);
					elseif leibie=="macro" then
						_G["Zhushou_anniu_"..id]:SetAttribute("type", leibie);
						_G["Zhushou_anniu_"..id]:SetAttribute("macro", spieID);
					end
				end
			end
		end
		---------
		for i=1,anniugeshu do
			local Zhushou_anniu = CreateFrame('Button', "Zhushou_anniu_"..i, ziFuFrame.Zhushou.List, "SecureActionButtonTemplate, ActionButtonTemplate")
			Zhushou_anniu:SetFrameLevel(5)
			Zhushou_anniu:SetSize(Width,Width);
			Zhushou_anniu.NormalTexture:SetAlpha(0.4);
			_G["Zhushou_anniu_"..i.."Cooldown"]:SetSwipeColor(0, 0, 0, 0.8);
			if i==1 then
				Zhushou_anniu:SetPoint("BOTTOMLEFT",ziFuFrame.Zhushou.List,"BOTTOMLEFT",10,10)
			elseif i==7 then
				Zhushou_anniu:SetPoint("LEFT",Zhushou_anniu_1,"RIGHT",anniujiange,0)
			else
				Zhushou_anniu:SetPoint("BOTTOM",_G["Zhushou_anniu_"..(i-1)],"TOP",0,anniujiange)
			end
			Zhushou_anniu:RegisterForDrag("LeftButton")
			Zhushou_anniu:RegisterEvent("SPELL_UPDATE_COOLDOWN","player");
			Zhushou_anniu:RegisterEvent("UNIT_SPELLCAST_START","player");
			Zhushou_anniu:RegisterEvent("UNIT_SPELLCAST_STOP","player");
			Zhushou_anniu:RegisterEvent("BAG_UPDATE");
			Zhushou_anniu:RegisterEvent("UPDATE_MACROS");
			Zhushou_anniu:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
			Zhushou_anniu:RegisterEvent("TRADE_SKILL_CLOSE")
			local version, build, date, tocversion = GetBuildInfo()
			if tocversion<30000 then
				Zhushou_anniu:RegisterEvent("CRAFT_CLOSE")
			end
			Zhushou_anniu.START = Zhushou_anniu:CreateTexture(nil, "OVERLAY");
			Zhushou_anniu.START:SetTexture(130724);
			Zhushou_anniu.START:SetBlendMode("ADD");
			Zhushou_anniu.START:SetAllPoints(Zhushou_anniu)
			Zhushou_anniu.START:Hide();
			Zhushou_anniu:SetScript("OnMouseDown", function (self)
				local leixing1,idhao = GetCursorInfo()
				if leixing1 then
					self:Disable()
				end
			end);
			Zhushou_anniu:SetScript("OnMouseUp", function (self)
				if InCombatLockdown() then return end
				self:Enable()
				if GetMouseFocus()==self then
					local leixing1,idhao,_,spelliD = GetCursorInfo()
					if leixing1 then
						if leixing1=="item" then
							PIG_Per['Classes']['Spell_list'][i]={leixing1,idhao}
							Classes_ICON_Tooltip(index)
							Classes_SPELL_ITEM(index)
							ClearCursor();	
						elseif leixing1=="spell" then
							PIG_Per['Classes']['Spell_list'][i]={leixing1,spelliD}
							Classes_ICON_Tooltip(index)
							Classes_SPELL_ITEM(index)
							ClearCursor();				
						elseif leixing1=="macro" then
							local hongxinxiInfo={}
							local name, icon, body, isLocal = GetMacroInfo(idhao)
							local hongSpellID = GetMacroSpell(idhao)
							if hongSpellID then
								hongxinxiInfo={leixing1,idhao,name,icon,body,"spell",hongSpellID}
							else
								local ItemName, ItemLink = GetMacroItem(idhao);
								if ItemName then
									local ItemID = GetItemInfoInstant(ItemName)
									hongxinxiInfo={leixing1,idhao,name,icon,body,"item",ItemID}
								else
									hongxinxiInfo={leixing1,idhao,name,icon,body,"",""}
								end
							end
							PIG_Per['Classes']['Spell_list'][i]=hongxinxiInfo
							Classes_ICON_Tooltip(index)
							Classes_SPELL_ITEM(index)
							ClearCursor();
						end
					end
				end
			end);
			Zhushou_anniu:SetScript("OnReceiveDrag",  function (self)
				if GetMouseFocus()==self then
					local leixing1,idhao,_,spelliD = GetCursorInfo()
					if leixing1 then
						if leixing1=="item" then
							PIG_Per['Classes']['Spell_list'][i]={leixing1,idhao}
							Classes_ICON_Tooltip(index)
							Classes_SPELL_ITEM(index)
							ClearCursor();	
						elseif leixing1=="spell" then
							PIG_Per['Classes']['Spell_list'][i]={leixing1,spelliD}
							Classes_ICON_Tooltip(index)
							Classes_SPELL_ITEM(index)
							ClearCursor();				
						elseif leixing1=="macro" then
							local hongxinxi={}
							local name, icon, body, isLocal = GetMacroInfo(idhao)
							local hongSpellID = GetMacroSpell(idhao)
							if hongSpellID then
								hongxinxi={leixing1,idhao,name,icon,body,"spell",hongSpellID}
							else
								local ItemName, ItemLink = GetMacroItem(idhao);
								if ItemName then
									local ItemID = GetItemInfoInstant(ItemName)
									hongxinxi={leixing1,idhao,name,icon,body,"item",ItemID}
								else
									hongxinxi={leixing1,idhao,name,icon,body,"",""}
								end
							end
							PIG_Per['Classes']['Spell_list'][i]=hongxinxi
							Classes_ICON_Tooltip(index)
							Classes_SPELL_ITEM(index)
							ClearCursor();
						end
					end
				end
			end);
		end
		-------------
		local function xianshishuangtai(carV)
			if (InCombatLockdown()) then  return  end
			if carV=="1" then
				for x=1,anniugeshu do
					_G["Zhushou_anniu_"..x]:Show();
				end
			else
				for x=1,anniugeshu do
					if not PIG_Per['Classes']['Spell_list'][x] or #PIG_Per['Classes']['Spell_list'][x]==0 then
						_G["Zhushou_anniu_"..x]:Hide();
					end
				end
			end			
		end
		------------
		local function Classes_SPELL_ITEM_AA() 
			Classes_ICON_Tooltip()
			Classes_SPELL_ITEM()
		end
		local zhushoudongzuotiaoshijian = CreateFrame("Frame"); 
		zhushoudongzuotiaoshijian:RegisterEvent("ACTIONBAR_SHOWGRID");
		zhushoudongzuotiaoshijian:RegisterEvent("ACTIONBAR_HIDEGRID");
		zhushoudongzuotiaoshijian:RegisterEvent("CVAR_UPDATE"); 
		zhushoudongzuotiaoshijian:RegisterEvent("PLAYER_REGEN_ENABLED");
		zhushoudongzuotiaoshijian:SetScript("OnEvent",function (self,event,arg1,arg2)
			if event=="ACTIONBAR_SHOWGRID" then
				if (InCombatLockdown()) then  return  end
				for x=1,anniugeshu do
					_G["Zhushou_anniu_"..x]:Show();
				end	
			end
			if event=="ACTIONBAR_HIDEGRID" then
				if (InCombatLockdown()) then  return  end
				local Showvalue = GetCVarInfo("alwaysShowActionBars")
				if Showvalue=="0" then
					for x=1,anniugeshu do
						if not PIG_Per['Classes']['Spell_list'][x] or #PIG_Per['Classes']['Spell_list'][x]==0 then
							_G["Zhushou_anniu_"..x]:Hide();
						end
					end	
				end
			end

			if event=="CVAR_UPDATE" then
				if arg1=="ALWAYS_SHOW_MULTIBARS_TEXT" then
					xianshishuangtai(arg2)
				end	
			end
			if event=="PLAYER_REGEN_ENABLED" then
				Classes_SPELL_ITEM_AA()
			end
		end);
		C_Timer.After(0.1,Classes_SPELL_ITEM_AA)
	end
	gengxinkuanduinfo()
end

--设置面板
---=========================
fuFrame.Classes = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Classes:SetSize(30,32);
fuFrame.Classes:SetHitRectInsets(0,-86,0,0);
fuFrame.Classes:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",10,-10);
fuFrame.Classes.Text:SetText("启用快捷按钮");
fuFrame.Classes.tooltip = "在屏幕上创建一排快捷按钮，以便快捷使用某些功能（例：快捷跟随/炉石专业面板/切换位面/各类助手）。";
fuFrame.Classes:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Classes']['Assistant']="ON";
	else
		Pig_Options_RLtishi_UI:Show()
		PIG['Classes']['Assistant']="OFF";
	end
	addonTable.Classes_Assistant()
end);
---重置位置
fuFrame.CZPoint = CreateFrame("Button",nil,fuFrame);
fuFrame.CZPoint:SetSize(22,22);
fuFrame.CZPoint:SetPoint("LEFT",fuFrame.Classes.Text,"RIGHT",10,-1);
fuFrame.CZPoint.highlight = fuFrame.CZPoint:CreateTexture(nil, "HIGHLIGHT");
fuFrame.CZPoint.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
fuFrame.CZPoint.highlight:SetBlendMode("ADD")
fuFrame.CZPoint.highlight:SetPoint("CENTER", fuFrame.CZPoint, "CENTER", 0,0);
fuFrame.CZPoint.highlight:SetSize(30,30);
fuFrame.CZPoint.Normal = fuFrame.CZPoint:CreateTexture(nil, "BORDER");
fuFrame.CZPoint.Normal:SetTexture("interface/buttons/ui-refreshbutton.blp");
fuFrame.CZPoint.Normal:SetBlendMode("ADD")
fuFrame.CZPoint.Normal:SetPoint("CENTER", fuFrame.CZPoint, "CENTER", 0,0);
fuFrame.CZPoint.Normal:SetSize(18,18);
fuFrame.CZPoint:HookScript("OnMouseDown", function (self)
	fuFrame.CZPoint.Normal:SetPoint("CENTER", fuFrame.CZPoint, "CENTER", -1.5,-1.5);
end);
fuFrame.CZPoint:HookScript("OnMouseUp", function (self)
	fuFrame.CZPoint.Normal:SetPoint("CENTER", fuFrame.CZPoint, "CENTER", 0,0);
end);
fuFrame.CZPoint:SetScript("OnEnter", function ()
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(fuFrame.CZPoint, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine("\124cff00ff00重置快捷按钮的位置\124r")
	GameTooltip:Show();
end);
fuFrame.CZPoint:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
fuFrame.CZPoint:SetScript("OnClick", function ()
	Classes_UI:ClearAllPoints();
	Classes_UI:SetPoint("CENTER",UIParent,"CENTER",0,-200);
end)
--===============================================
fuFrame.Lushi = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Lushi:SetSize(30,32);
fuFrame.Lushi:SetHitRectInsets(0,-100,0,0);
fuFrame.Lushi:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-50);
fuFrame.Lushi.Text:SetText("炉石/专业按钮");
fuFrame.Lushi.tooltip = "启动炉石/专业按钮。\n|cff00ff00左键使用炉石！|r\n|cff00ff00右键打开专业技能面板!|r";
fuFrame.Lushi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Classes']['Lushi']="ON";
		Classes_Lushi()
	else
		PIG['Classes']['Lushi']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--======================================================
fuFrame.Spell = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Spell:SetSize(30,32);
fuFrame.Spell:SetHitRectInsets(0,-100,0,0);
fuFrame.Spell:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-50);
fuFrame.Spell.Text:SetText("职业额外动作条");
fuFrame.Spell.tooltip = "启动职业额外动作条按钮。\n|cff00ff00左键展开额外动作条！|r\n|cff00ff00右键打开Recount/Details统计面板(需安装插件:Recount/Details)。|r";
fuFrame.Spell:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Classes']['Spell']="ON";
		Classes_Spell()
	else
		PIG['Classes']['Spell']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
fuFrame.tuozhuai = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.tuozhuai:SetSize(30,32);
fuFrame.tuozhuai:SetHitRectInsets(0,-80,0,0);
fuFrame.tuozhuai:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",200,-10);
fuFrame.tuozhuai.Text:SetText("锁定位置");
fuFrame.tuozhuai.tooltip = "锁定快捷按钮位置，并隐藏拖拽图标";
fuFrame.tuozhuai:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Classes']['suoding']="ON";
		Classes_UI.yidong:Hide()
	else
		PIG['Classes']['suoding']="OFF";
		Classes_UI.yidong:Show()
	end
end);
fuFrame.suofangdaxiao = fuFrame:CreateFontString();
fuFrame.suofangdaxiao:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",330,-18);
fuFrame.suofangdaxiao:SetFontObject(GameFontNormal);
fuFrame.suofangdaxiao:SetText('缩放比例:');
----------
fuFrame.suofangdaxiao_Slider = CreateFrame("Slider", nil, fuFrame, "OptionsSliderTemplate")
fuFrame.suofangdaxiao_Slider:SetWidth(100)
fuFrame.suofangdaxiao_Slider:SetHeight(15)
fuFrame.suofangdaxiao_Slider:SetPoint("LEFT",fuFrame.suofangdaxiao,"RIGHT",10,0);
fuFrame.suofangdaxiao_Slider.tooltipText = '拖动滑块或者用鼠标滚轮调整数值';
fuFrame.suofangdaxiao_Slider:SetMinMaxValues(0.6,1.4);
fuFrame.suofangdaxiao_Slider:SetValueStep(0.1);
fuFrame.suofangdaxiao_Slider:SetObeyStepOnDrag(true);
fuFrame.suofangdaxiao_Slider.Low:SetText(0.6);
fuFrame.suofangdaxiao_Slider.High:SetText(1.4);
fuFrame.suofangdaxiao_Slider:EnableMouseWheel(true);
fuFrame.suofangdaxiao_Slider:SetScript("OnMouseWheel", function(self, arg1)
	local step = 0.1 * arg1
	local value = self:GetValue()
	if step > 0 then
		self:SetValue(min(value + step, 1.4))
	else
		self:SetValue(max(value + step, 0.6))
	end
end)
fuFrame.suofangdaxiao_Slider:SetScript('OnValueChanged', function(self)
	local Hval = (floor(self:GetValue()*10))/10
	PIG['Classes']['bili']=Hval;
	fuFrame.suofangdaxiao_Slider.Text:SetText(Hval);
	if Classes_UI then
		Classes_UI:SetScale(Hval);
	end
end)
--==========================
addonTable.Classes_Assistant = function()
	PIG['Classes']['bili']=PIG['Classes']['bili'] or addonTable.Default['Classes']['bili']
	fuFrame.suofangdaxiao_Slider:SetValue(PIG['Classes']['bili']);
	fuFrame.suofangdaxiao_Slider.Text:SetText(PIG['Classes']['bili']);

	PIG_Per["Classes"]=PIG_Per["Classes"] or addonTable.Default_Per["Classes"]
	if PIG['Classes']['Assistant']=="ON" then
		fuFrame.Classes:SetChecked(true);
		fuFrame.Lushi:Enable();
		fuFrame.Spell:Enable();
	elseif PIG['Classes']['Assistant']=="OFF" then
		fuFrame.Lushi:Disable();
		fuFrame.Spell:Disable();
	end
	if PIG['Classes']['Lushi']=="ON" then
		fuFrame.Lushi:SetChecked(true);
	end
	if PIG['Classes']['Spell']=="ON" then
		fuFrame.Spell:SetChecked(true);
	end
	---
	if PIG['Classes']['Assistant']=="ON" then
		Classes_addUI()
		Classes_UI:SetScale(PIG['Classes']['bili']);
		if PIG['Classes']['suoding']=="ON" then
			fuFrame.tuozhuai:SetChecked(true);
			Classes_UI.yidong:Hide()
		elseif PIG['Classes']['suoding']=="OFF" then
			Classes_UI.yidong:Show()
		end
		addonTable.Classes_Gensui()
		if PIG['Classes']['Lushi']=="ON" then
			Classes_Lushi()
		end
		if PIG['Classes']['Spell']=="ON" then
			Classes_Spell()
		end
	end
	addonTable.ADD_PlaneInvite_but()
	addonTable.ADD_SkillFubenCD_but()
	addonTable.ADD_SpellCD_but()
	addonTable.ADD_AutoSellBuy_but()
	addonTable.ADD_FarmRecord_but()
	addonTable.ADD_RaidRecord_but()
end
local _, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
--------------
local fuFrame = List_R_F_1_7
local ADD_Frame=addonTable.ADD_Frame
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local ADD_QuickButton=addonTable.ADD_QuickButton
--=======================================
fuFrame.anniuF = CreateFrame("Frame", nil, fuFrame,"BackdropTemplate")
fuFrame.anniuF:SetBackdrop( {edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12 });
fuFrame.anniuF:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8);
fuFrame.anniuF:SetSize(fuFrame:GetWidth()-40, fuFrame:GetHeight()-80)
fuFrame.anniuF:SetPoint("TOP", fuFrame, "TOP", 0, -60)
------------------
local Skill_List = {'烹饪', '急救', '裁缝', '熔炼', '工程学', '锻造', '附魔', '制皮', '炼金术',"珠宝加工","铭文"};
-----炉石专业按钮----------------------
local function QuickButton_Lushi()
	if PIG['QuickButton']['Lushi'] then
		fuFrame.Lushi:SetChecked(true);
	end
	if PIG["QuickButton"]["Open"] then
		fuFrame.Lushi:Enable()
	else
		fuFrame.Lushi:Disable()
	end
	if PIG["QuickButton"]["Open"] and PIG['QuickButton']['Lushi'] then
		local GnUI = "General_UI"
		if _G[GnUI] then return end
		local Icon=134414
		local Tooltip = "左击-|cff00FFFF使用炉石\r|r右击-|cff00FFFF专业技能|r"
		local General=ADD_QuickButton(GnUI,Tooltip,Icon, "SecureActionButtonTemplate")
		General.Cooldown = CreateFrame("Frame", nil, General);
		General.Cooldown:SetAllPoints()
		General.Cooldown.N = CreateFrame("Cooldown", nil, General.Cooldown, "CooldownFrameTemplate")
		General.Cooldown.N:SetAllPoints()

		General.START = General:CreateTexture(nil, "OVERLAY");
		General.START:SetTexture(130724);
		General.START:SetBlendMode("ADD");
		General.START:SetAllPoints(General)
		General.START:Hide();
		local UseKeyDown =GetCVar("ActionButtonUseKeyDown")
		if UseKeyDown=="0" then
			General:RegisterForClicks("AnyUp");
		elseif UseKeyDown=="1" then
			General:RegisterForClicks("AnyDown")
		end
		General:SetAttribute("type1", "item");
		General:SetAttribute("item", "炉石");
		General:SetAttribute("type2", "spell");
		General:SetAttribute("spell", "烹饪");
		local function Skill_Button_Genxin()
			if InCombatLockdown() then return end
			local _, _, tabOffset, numEntries = GetSpellTabInfo(1)
			for x=1, #Skill_List do
				local Skill_xxxx =false;
				for i=tabOffset + 1, tabOffset + numEntries do
					local spellName, _ = GetSpellBookItemName(i, BOOKTYPE_SPELL)
					if spellName==Skill_List[x] then
						Skill_xxxx =true;
						General:SetAttribute("type2", "spell");
						General:SetAttribute("spell", spellName);
						break
					end
					if Skill_xxxx then break end
				end
				if Skill_xxxx then break end
			end
		end
		local function gengxinlushiCD()
	 		local start, duration = GetSpellCooldown(8690);
		 	General.Cooldown.N:SetCooldown(start, duration);
	 	end
		General:RegisterUnitEvent("UNIT_SPELLCAST_START","player");
		General:RegisterUnitEvent("UNIT_SPELLCAST_STOP","player");
		General:RegisterEvent("SPELL_UPDATE_COOLDOWN")
		General:SetScript("OnEvent", function(self,event,arg1,_,arg3)
			if arg3==8690 then 
				if event=="UNIT_SPELLCAST_START" then
			 		General.START:Show();
			 	end
			 	if event=="UNIT_SPELLCAST_STOP" then
			 		General.START:Hide();
				end	
		 	end
			if event=="SPELL_UPDATE_COOLDOWN" then
				gengxinlushiCD()
				C_Timer.After(0.2, gengxinlushiCD);
			end
		end)
		C_Timer.After(3, Skill_Button_Genxin);
		C_Timer.After(3, gengxinlushiCD);
	end
end
addonTable.ADD_QuickButton_Lushi=QuickButton_Lushi
----------
local Lushi_tooltip = "启动炉石/专业按钮。\n|cff00ff00左键使用炉石！|r\n|cff00ff00右键打开专业技能面板!|r";
fuFrame.Lushi=ADD_Checkbutton(nil,fuFrame.anniuF,-100,"TOPLEFT",fuFrame.anniuF,"TOPLEFT",20,-20,"添加<炉石/专业按钮>到快捷按钮栏",Lushi_tooltip)
fuFrame.Lushi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['QuickButton']['Lushi']=true;
		QuickButton_Lushi()
	else
		PIG['QuickButton']['Lushi']=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
--职业技能+工程物品==============
local PigMacroEventCount_QK =0;
local PigMacroDeleted_QK = false;
local PigMacroCount_QK=0
local function QuickButton_Spell()
	if PIG['QuickButton']['Spell'] then
		fuFrame.Spell:SetChecked(true);
	end
	if PIG["QuickButton"]["Open"] then
		fuFrame.Spell:Enable()
	else
		fuFrame.Spell:Disable()
	end
	if PIG["QuickButton"]["Open"] and PIG['QuickButton']['Spell'] then
		local GnUI = "Zhushou_UI"
		if _G[GnUI] then return end
		local loadingButInfo=addonTable.loadingButInfo
		local Update_PostClick=addonTable.Update_PostClick
		local Cursor_Fun=addonTable.Cursor_Fun
		local OnEnter_Item=addonTable.OnEnter_Item
		local OnEnter_Spell=addonTable.OnEnter_Spell
		local OnEnter_Companion=addonTable.OnEnter_Companion
		local Update_Icon=addonTable.Update_Icon
		local Update_Cooldown=addonTable.Update_Cooldown
		local Update_Count=addonTable.Update_Count
		local Update_State=addonTable.Update_State
		local Update_bukeyong=addonTable.Update_bukeyong
		local Update_Macro=addonTable.Update_Macro
		local Icon=131146
		local Tooltip = "左击-|cff00FFFF展开职业辅助技能栏|r\n右击-|cff00FFFF打开Recount/Details插件记录面板|r"
		local Zhushou=ADD_QuickButton(GnUI,Tooltip,Icon)
		local IconTEX=Zhushou:GetNormalTexture()
		local IconCoord = CLASS_ICON_TCOORDS[select(2,UnitClass("player"))];
		IconTEX:SetTexCoord(unpack(IconCoord));
		---内容页----
		local butW = QuickButtonUI.nr:GetHeight()
		local gaoNum,kuanNum = 10,2
		local Zhushou_List = CreateFrame("Frame", "Zhushou_List_UI", UIParent,"BackdropTemplate,SecureHandlerShowHideTemplate");
		Zhushou_List:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background",edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 10,})
		Zhushou_List:SetBackdropBorderColor(0, 1, 1, 0.8);
		Zhushou_List:SetSize((butW+6)*kuanNum+6,(butW+6)*gaoNum+6);
		Zhushou_List:SetScale(PIG['QuickButton']['bili']);
		Zhushou_List:Hide();
		Zhushou_List:SetFrameLevel(33)

		Zhushou_List.Close = CreateFrame("Button",nil,Zhushou_List, "UIPanelCloseButton");  
		Zhushou_List.Close:SetSize(38,38);

		local WowHeight=GetScreenHeight();
		local offset = Zhushou:GetBottom();
		if offset>(WowHeight*0.5) then
			Zhushou_List:SetPoint("TOP", Zhushou, "BOTTOM", 0, -4);
			Zhushou_List.Close:SetPoint("TOPRIGHT", Zhushou_List, "BOTTOMRIGHT", 2, 2);
		else
			Zhushou_List:SetPoint("BOTTOM", Zhushou, "TOP", 0, 4);
			Zhushou_List.Close:SetPoint("BOTTOMRIGHT", Zhushou_List, "TOPRIGHT", 2, -2);
		end
		Zhushou:HookScript("OnClick",function(self,button)
			if button == "RightButton" then
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
		end)
		Zhushou:SetAttribute("_onclick", [=[
			local ref = self:GetFrameRef("frame1");
			if button == "LeftButton" then
				if ref:IsShown() then	
					ref:Hide();
				else
					ref:Show();
				end
			end
		]=]); 
		Zhushou:RegisterForClicks("AnyUp");
		Zhushou:SetFrameRef("frame1", Zhushou_List_UI);
		---
		for i=1,gaoNum*kuanNum do
			local zhushoubut = CreateFrame("CheckButton", "Zhushou_List_"..i, Zhushou_List, "SecureActionButtonTemplate,ActionButtonTemplate,SecureHandlerDragTemplate,SecureHandlerMouseUpDownTemplate")
			zhushoubut:SetSize(butW, butW)
			zhushoubut.NormalTexture:SetAlpha(0.4);
			zhushoubut.cooldown:SetSwipeColor(0, 0, 0, 0.8);
			if i==1 then
				zhushoubut:SetPoint("BOTTOMLEFT",Zhushou_List,"BOTTOMLEFT",6,6);
			else
				local num1,num2=math.modf(i/2)
				if num2~=0 then
					zhushoubut:SetPoint("BOTTOMLEFT",_G["Zhushou_List_"..(i-2)],"TOPLEFT",0,6);
				else
					zhushoubut:SetPoint("LEFT",_G["Zhushou_List_"..(i-1)],"RIGHT",6,0);
				end
			end
	 		local ActionID = 400+i
	 		zhushoubut.action=ActionID
			zhushoubut:SetAttribute("action", ActionID)
			--
			zhushoubut:RegisterForDrag("LeftButton", "RightButton");
			zhushoubut:RegisterForClicks("AnyUp");
			--
			loadingButInfo(zhushoubut,"QuickButton")
			--
			zhushoubut:HookScript("PostClick", function(self)
				Update_PostClick(self)
			end);
			zhushoubut:HookScript("OnShow", function (self)
				Update_Icon(self)
				Update_Cooldown(self)
				Update_Count(self)
				Update_bukeyong(self)
			end)
			--
			zhushoubut:HookScript("OnMouseUp", function (self)
				Cursor_Fun(self,"OnMouseUp","QuickButton")
				Update_Icon(self)
				Update_Cooldown(self)
				Update_Count(self)
			end);
			----
			zhushoubut:SetAttribute("_ondragstart",[=[
				self:SetAttribute("type", nil)
			]=])
			zhushoubut:HookScript("OnDragStart", function (self)
				Cursor_Fun(self,"OnDragStart","QuickButton")
				Update_Icon(self)
				Update_Cooldown(self)
				Update_Count(self)
			end)
			----
			zhushoubut:SetAttribute("_onreceivedrag",[=[
				local leibie, spellID = ...
				if kind=="spell" then
					self:SetAttribute("type", kind)
					self:SetAttribute(kind, spellID)
				elseif kind=="item" then
					self:SetAttribute("type", kind)
					self:SetAttribute(kind, leibie)
				elseif kind=="macro" then
					self:SetAttribute("type", kind)
					self:SetAttribute(kind, value)
				end
			]=])
			zhushoubut:HookScript("OnReceiveDrag", function (self)
				Cursor_Fun(self,"OnReceiveDrag","QuickButton")
				Update_Icon(self)
				Update_Cooldown(self)
				Update_Count(self)
			end);
			----
			zhushoubut:SetScript("OnEnter", function (self)
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_NONE");
				GameTooltip:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",-100,140);
				local butInfo = PIG_Per['QuickButton']['ActionInfo'][self.action]
				if butInfo then
					local Type=self.Type
					if Type then
						local SimID=self.SimID
						if Type=="spell" then
							OnEnter_Spell(Type,SimID)
						elseif Type=="item" then
							OnEnter_Item(Type,SimID)
						elseif Type=="macro" then
							local hongSpellID = GetMacroSpell(SimID)
							if hongSpellID then
								OnEnter_Spell(Type,hongSpellID)
							else
								local ItemName, ItemLink = GetMacroItem(SimID);
								if ItemName then
									OnEnter_Item(Type,ItemLink)
								else
									local name, icon, body, isLocal = GetMacroInfo(SimID)
									GameTooltip:SetText(name,1, 1, 1, 1)
									GameTooltip:Show();
								end
							end
						elseif Type=="companion" then
							OnEnter_Companion(Type,SimID,butInfo[3])
						end
					end
				end
			end)
			zhushoubut:SetScript("OnLeave", function ()
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			--
			zhushoubut:RegisterEvent("TRADE_SKILL_CLOSE")
			if tocversion>90000 then
			else
				zhushoubut:RegisterEvent("CRAFT_CLOSE")
			end
			zhushoubut:RegisterEvent("CVAR_UPDATE");
			zhushoubut:RegisterEvent("UPDATE_MACROS");
			zhushoubut:RegisterEvent("EXECUTE_CHAT_LINE");
			zhushoubut:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
			zhushoubut:RegisterEvent("ACTIONBAR_UPDATE_STATE");
			zhushoubut:RegisterUnitEvent("UNIT_AURA","player");
			zhushoubut:RegisterEvent("BAG_UPDATE");
			zhushoubut:RegisterEvent("AREA_POIS_UPDATED");
			zhushoubut:HookScript("OnEvent", function(self,event,arg1,arg2,arg3)
				if Zhushou_List:IsShown() then
					if event=="PLAYER_REGEN_ENABLED" then
						PigMacroDeleted_QK,PigMacroCount_QK=Update_Macro(self,PigMacroDeleted_QK,PigMacroCount_QK,"QuickButton")
						self:UnregisterEvent("PLAYER_REGEN_ENABLED");
					end
					if event=="BAG_UPDATE" then
						Update_Count(self)
					end
					if event=="ACTIONBAR_UPDATE_COOLDOWN" then
						Update_Cooldown(self)
						Update_bukeyong(self)
					end
					if event=="ACTIONBAR_UPDATE_STATE" or event=="TRADE_SKILL_CLOSE" or event=="CRAFT_CLOSE" or event=="UNIT_AURA" or event=="EXECUTE_CHAT_LINE" then
						Update_State(self)
						Update_Icon(self)
					end
					if event=="UPDATE_MACROS" or event=="PLAYER_REGEN_ENABLED" then
						PigMacroEventCount_QK=PigMacroEventCount_QK+1;
						if self.Type=="macro" then
							if PigMacroEventCount_QK>5 then
								local AccMacros, CharMacros = GetNumMacros();
								if PigMacroCount_QK==0 then
									PigMacroCount_QK = AccMacros + CharMacros;
								elseif (PigMacroCount_QK > AccMacros + CharMacros) then
									PigMacroDeleted_QK = true;
								end
								PigMacroDeleted_QK,PigMacroCount_QK=Update_Macro(self,PigMacroDeleted_QK,PigMacroCount_QK,"QuickButton")
							end
						end
						Update_Icon(self)
						Update_Count(self)
					end
					if event=="AREA_POIS_UPDATED" then
						Update_bukeyong(self)
					end
				end
			end)
		end
	end
end
addonTable.ADD_QuickButton_Spell=QuickButton_Spell
--=================================
local Spell_tooltip = "启动职业辅助技能栏。\n|cff00ff00左键展开职业辅助技能栏！|r\n|cff00ff00右键打开Recount/Details统计面板(需安装插件:Recount/Details)。|r";
fuFrame.Spell=ADD_Checkbutton(nil,fuFrame.anniuF,-100,"TOPLEFT",fuFrame.anniuF,"TOPLEFT",20,-60,"添加<职业辅助技能栏>到快捷按钮栏",Spell_tooltip)
fuFrame.Spell:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['QuickButton']['Spell']=true;
		QuickButton_Spell()
	else
		PIG['QuickButton']['Spell']=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
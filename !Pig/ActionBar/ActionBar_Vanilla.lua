local addonName, addonTable = ...;
-------
local fuFrame = List_R_F_2_3
local _, _, _, tocversion = GetBuildInfo()
local PIGDownMenu=addonTable.PIGDownMenu
--=======================================
local anniugeshu,anniujiange=12,6;
local zongshu =4;
local barName ="Pigbar"
----------
local pailieName={"横向","竖向","6×2","2×6","4×3","3×4","取消"};
local pailieID={1,2,3,4,5,6};
local pailieweizhi={
	{
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
	},
	{
		{"TOP","BOTTOM",0,-anniujiange,1},
		{"TOP","BOTTOM",0,-anniujiange,1},
		{"TOP","BOTTOM",0,-anniujiange,1},
		{"TOP","BOTTOM",0,-anniujiange,1},
		{"TOP","BOTTOM",0,-anniujiange,1},
		{"TOP","BOTTOM",0,-anniujiange,1},
		{"TOP","BOTTOM",0,-anniujiange,1},
		{"TOP","BOTTOM",0,-anniujiange,1},
		{"TOP","BOTTOM",0,-anniujiange,1},
		{"TOP","BOTTOM",0,-anniujiange,1},
		{"TOP","BOTTOM",0,-anniujiange,1},
	},
	{
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"TOPLEFT","BOTTOMLEFT",0,-anniujiange,6},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
	},
	{
		{"LEFT","RIGHT",anniujiange,0,1},
		{"TOPLEFT","BOTTOMLEFT",0,-anniujiange,2},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"TOPLEFT","BOTTOMLEFT",0,-anniujiange,2},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"TOPLEFT","BOTTOMLEFT",0,-anniujiange,2},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"TOPLEFT","BOTTOMLEFT",0,-anniujiange,2},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"TOPLEFT","BOTTOMLEFT",0,-anniujiange,2},
		{"LEFT","RIGHT",anniujiange,0,1},
	},
	{
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"TOPLEFT","BOTTOMLEFT",0,-anniujiange,4},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"TOPLEFT","BOTTOMLEFT",0,-anniujiange,4},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
	},
	{
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"TOPLEFT","BOTTOMLEFT",0,-anniujiange,3},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"TOPLEFT","BOTTOMLEFT",0,-anniujiange,3},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"TOPLEFT","BOTTOMLEFT",0,-anniujiange,3},
		{"LEFT","RIGHT",anniujiange,0,1},
		{"LEFT","RIGHT",anniujiange,0,1},
	},
};
local function PailieFun(index,id)
	for x=1,#pailieID do
		if PIG_Per["PigAction"]["Pailie"][index] == pailieID[x] then
			_G[barName..index.."_But"..id]:ClearAllPoints();
			_G[barName..index.."_But"..id]:SetPoint(pailieweizhi[x][id-1][1],_G[barName..index.."_But"..(id-pailieweizhi[x][id-1][5])],pailieweizhi[x][id-1][2],pailieweizhi[x][id-1][3],pailieweizhi[x][id-1][4])
		end
	end
end
-----------
local PigMacroEventCount =0;
local PigMacroDeleted = false;
local PigMacroCount=0
local function ShowHideEvent(self,canshuV)
	if canshuV==1 then
		RegisterStateDriver(self, "combatYN", "[] show; hide");--一直显示
	elseif canshuV==2 then
		RegisterStateDriver(self, "combatYN", "[combat] show; hide");--脱战后隐藏
	elseif canshuV==3 then
		RegisterStateDriver(self, "combatYN", "[nocombat] show; hide");--进战斗隐藏
	elseif canshuV==4 then
		RegisterStateDriver(self, "combatYN", "[exists] show; hide");--无目标隐藏
	end
end
---add------------------
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
local Spell_bianxing = {768,783,5487,9634,24858,33947,40120,1066,13819,34767,34769,23214,5784,23161}
local Skill_zhuanye = {'烹饪', '急救', '裁缝', '熔炼', '工程学', '锻造', '制皮','剥皮', '炼金术',"珠宝加工","铭文"};
local function ADD_ActionBar(index)
	if _G[barName..index] then return end
	local ActionW = ActionButton1:GetWidth()
	local Pig_bar = CreateFrame("Frame", barName..index, UIParent)
	Pig_bar:SetSize(14,ActionW+4)
	Pig_bar:SetPoint("CENTER",UIParent,"CENTER",-200,-200+index*50);
	Pig_bar:SetMovable(true)
	Pig_bar:SetClampedToScreen(true)	
	-- Pig_bar:SetAttribute("type", "actionbar");
	-- Pig_bar:SetAttribute("actionbar", index+100);
	if PIG['PigUI']['ActionBar_bili']=="ON" then
		Pig_bar:SetScale(PIG['PigUI']['ActionBar_bili_value']);
	end
	Pig_bar.yidong = CreateFrame("Frame", nil, Pig_bar,"BackdropTemplate")
	Pig_bar.yidong:SetBackdrop({
		bgFile = "Interface/DialogFrame/UI-DialogBox-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, edgeSize = 6
	});
	Pig_bar.yidong:SetBackdropColor(0.4, 0.4, 0.4, 0.5);
	Pig_bar.yidong:SetAllPoints(Pig_bar)
	Pig_bar.yidong:EnableMouse(true)
	Pig_bar.yidong:RegisterForDrag("LeftButton")
	if PIG_Per["PigAction"]["Look"][index]=="ON" then Pig_bar.yidong:Hide() end
	Pig_bar.yidong.title = Pig_bar.yidong:CreateFontString();
	Pig_bar.yidong.title:SetAllPoints(Pig_bar.yidong)
	Pig_bar.yidong.title:SetFont(ChatFontNormal:GetFont(), 11)
	Pig_bar.yidong.title:SetTextColor(0.6, 0.6, 0.6, 1)
	Pig_bar.yidong.title:SetText("拖\n"..index.."\n动")

	Pig_bar.yidong:SetScript("OnDragStart",function()
		Pig_bar:StartMoving()
	end)
	Pig_bar.yidong:SetScript("OnDragStop",function()
		Pig_bar:StopMovingOrSizing()
	end)
	---------------
	Pig_bar.yidong.RightC = CreateFrame("Frame","Action_RightC"..index, Pig_bar.yidong,"BackdropTemplate");
	Pig_bar.yidong.RightC:SetBackdrop({
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background",edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 20,
	insets = {left = 3,right = 3,top = 3,bottom = 3}})
	Pig_bar.yidong.RightC:SetSize(90,210);
	Pig_bar.yidong.RightC:SetPoint("TOP",Pig_bar.yidong,"BOTTOM",0,-0);
	Pig_bar.yidong.RightC:Hide()
	Pig_bar.yidong.RightC:EnableMouse(true)
	Pig_bar.yidong.RightC:SetFrameLevel(10)
	local painum = #pailieName
	for b=1,painum do
		local RightC_C = CreateFrame("CheckButton", "RightC_"..index.."_"..b, Pig_bar.yidong.RightC,"UIRadioButtonTemplate",index);
		RightC_C:SetSize(20,20);
		RightC_C:SetHitRectInsets(0,-52,-2,-2);
		if b==1 then
			RightC_C:SetPoint("TOPLEFT",Pig_bar.yidong.RightC,"TOPLEFT",10,-8);
		else
			RightC_C:SetPoint("TOPLEFT",_G["RightC_"..index.."_"..(b-1)],"BOTTOMLEFT",0,-8);
		end
		_G["RightC_"..index.."_"..b.."Text"]:SetText(pailieName[b]);
		RightC_C:SetScript("OnClick", function (self)
			if b~=painum then
				for q=1,painum do
					_G["RightC_"..index.."_"..q]:SetChecked(false);
				end
				self:SetChecked(true);
				PIG_Per["PigAction"]["Pailie"][index]=pailieID[b]
				for id=2,anniugeshu do
					PailieFun(self:GetID(),id)
				end
			else
				self:SetChecked(false);
			end
			Pig_bar.yidong.RightC:Hide()
		end)
	end

	Pig_bar.yidong:SetScript("OnMouseUp", function (self,Button)
		if Button=="RightButton" then
			if self.RightC:IsShown() then
				self.RightC:Hide()
			else
				for f=1,zongshu do
					if _G["Action_RightC"..f] then _G["Action_RightC"..f]:Hide() end
				end
				self.RightC:Show()
				for l=1,#pailieID do
					if PIG_Per["PigAction"]["Pailie"][index] == pailieID[l] then
						_G["RightC_"..index.."_"..l]:SetChecked(true);
					end
				end
			end
		end
	end)
	--------
	for id=1,anniugeshu do
		--local piganniu = CreateFrame("CheckButton", "$parent_But"..id, Pig_bar, "ActionBarButtonTemplate",0)
		local piganniu = CreateFrame("CheckButton", "$parent_But"..id, Pig_bar, "SecureActionButtonTemplate,ActionButtonTemplate,SecureHandlerDragTemplate,SecureHandlerMouseUpDownTemplate,SecureHandlerStateTemplate")
		piganniu:SetSize(ActionW, ActionW)
		piganniu.NormalTexture:SetAlpha(0.4);
		piganniu.cooldown:SetSwipeColor(0, 0, 0, 0.8);
		if id==1 then
			piganniu:SetPoint("LEFT",Pig_bar,"RIGHT",2,0)
		else
			PailieFun(index,id)
		end
		piganniu.BGtex = piganniu:CreateTexture(nil, "BACKGROUND", nil, -1);
		piganniu.BGtex:SetTexture("Interface/Buttons/UI-Quickslot");
		piganniu.BGtex:SetAlpha(0.4);
		piganniu.BGtex:SetPoint("TOPLEFT", -15, 15);
		piganniu.BGtex:SetPoint("BOTTOMRIGHT", 15, -15);
		-------------
	 	-- piganniu:SetAttribute("checkfocuscast", true);--使用系统焦点施法按键
	 	-- piganniu:SetAttribute("checkselfcast", true);--可以使用自我施法按键
	 	-- piganniu.flashing = 0;
	 	-- piganniu.flashtime = 0;
	 	if index==1 then 
	 		local ActionID = 500+id
	 		piganniu.action=ActionID
			piganniu:SetAttribute("action", ActionID)
		else
			local ActionID = 500+(index-1)*12+id
			piganniu.action=ActionID
			piganniu:SetAttribute("action", ActionID)
		end
		---
		piganniu:RegisterForDrag("LeftButton", "RightButton");
		local UseKeyDown =GetCVar("ActionButtonUseKeyDown")
		if UseKeyDown=="0" then
			piganniu:RegisterForClicks("AnyUp");
		elseif UseKeyDown=="1" then
			SetBinding("CTRL-SHIFT-ALT-Q", "CLICK $parent_But"..id..":Button31")
			piganniu:RegisterForClicks("AnyUp", "Button31Down")
			piganniu:SetAttribute("type31", "")
			piganniu:WrapScript(piganniu, "OnClick", [=[
			    -- self, button, down
			    if (button == "Button31" and down) then
			        return "LeftButton"
			    end
			]=])
		end
	 	--
		loadingButInfo(piganniu,"PigAction")
		---
		piganniu:HookScript("PostClick", function(self)
			Update_PostClick(self)
		end);
		--
		piganniu:HookScript("OnMouseUp", function (self)
			Cursor_Fun(self,"OnMouseUp","PigAction")
			Update_Icon(self)
			Update_Cooldown(self)
			Update_Count(self)
		end);
		----
		piganniu:HookScript("OnDragStart", function (self)
			if InCombatLockdown() then return end
			local lockvalue = GetCVarInfo("lockActionBars")
			if lockvalue=="0" then
				self:SetAttribute("type", nil)
				Cursor_Fun(self,"OnDragStart","PigAction")
				Update_Icon(self)
				Update_Cooldown(self)
				Update_Count(self)
				Update_State(self)
			elseif lockvalue=="1" then
				if IsShiftKeyDown() then
					self:SetAttribute("type", nil)
					Cursor_Fun(self,"OnDragStart","PigAction")
					Update_Icon(self)
					Update_Cooldown(self)
					Update_Count(self)
					Update_State(self)
				end
			end
		end)
		----
		piganniu:SetAttribute("_onreceivedrag",[=[
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
		piganniu:HookScript("OnReceiveDrag", function (self)
			Cursor_Fun(self,"OnReceiveDrag","PigAction")
			Update_Icon(self)
			Update_Cooldown(self)
			Update_Count(self)
		end);
		----
		piganniu:SetScript("OnEnter", function (self)
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_NONE");
			GameTooltip:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",-100,140);
			local butInfo = PIG_Per['PigAction']['ActionInfo'][self.action]
			if butInfo then
				local Type=self.Type
				if Type then
					local SimID=self.SimID
					if Type=="spell" then
						OnEnter_Spell(Type,SimID)
					elseif Type=="item" then
						OnEnter_Item(Type,SimID)
					elseif Type=="companion" then
						OnEnter_Companion(Type,SimID,butInfo[3])
					elseif Type=="mount" then
						OnEnter_Companion(Type,SimID,butInfo[3])
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
					end
				end
			end
		end)
		piganniu:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		--------------------
		ShowHideEvent(piganniu,PIG_Per['PigAction']['ShowTJ'][index])
		piganniu:SetAttribute("_onstate-combatYN","if newstate == 'show' then self:Show(); else self:Hide(); end")

		-- piganniu:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
	 	-- piganniu:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
		piganniu:RegisterEvent("ACTIONBAR_SHOWGRID");
		piganniu:RegisterEvent("ACTIONBAR_HIDEGRID");
		piganniu:RegisterEvent("TRADE_SKILL_CLOSE")
		if tocversion>90000 then
		else
			piganniu:RegisterEvent("CRAFT_CLOSE")
		end
		piganniu:RegisterEvent("CVAR_UPDATE");
		piganniu:RegisterEvent("UPDATE_MACROS");
		piganniu:RegisterEvent("EXECUTE_CHAT_LINE");
		piganniu:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
		piganniu:RegisterEvent("ACTIONBAR_UPDATE_STATE");
		piganniu:RegisterUnitEvent("UNIT_AURA","player");
		piganniu:RegisterEvent("BAG_UPDATE");
		piganniu:RegisterEvent("AREA_POIS_UPDATED");
		piganniu:HookScript("OnEvent", function(self,event,arg1,arg2,arg3)
			if event=="ACTIONBAR_SHOWGRID" then
				if InCombatLockdown() then return end
				self:Show();
			end
			if event=="ACTIONBAR_HIDEGRID" then
				if InCombatLockdown() then
					self:RegisterEvent("PLAYER_REGEN_ENABLED");
					return 
				end
				local Showvalue = GetCVarInfo("alwaysShowActionBars")
				if Showvalue=="0" then
					if not self.Type then
						self:Hide();
					end
				end
			end
			if event=="CVAR_UPDATE" then
				if InCombatLockdown() then
					self:RegisterEvent("PLAYER_REGEN_ENABLED");
					return 
				end
				if arg1=="ALWAYS_SHOW_MULTIBARS_TEXT" then
					if arg2=="0" then
						if not self.Type then
							self:Hide();
						end
					elseif arg2=="1" then
						self:Show();
					end
				end	
			end
			if event=="PLAYER_REGEN_ENABLED" then
				local Showvalue = GetCVarInfo("alwaysShowActionBars")
				if Showvalue=="0" then
					if not self.Type then
						self:Hide();
					end
				elseif Showvalue=="1" then
					self:Show();
				end
				if self.Type=="macro" then
					PigMacroDeleted,PigMacroCount=Update_Macro(self,PigMacroDeleted,PigMacroCount,"PigAction")
				end
				self:UnregisterEvent("PLAYER_REGEN_ENABLED");
			end
			if event=="BAG_UPDATE" then
				Update_Count(self)
				Update_bukeyong(self)
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
				PigMacroEventCount=PigMacroEventCount+1;
				if self.Type=="macro" then
					if PigMacroEventCount>5 then
						local AccMacros, CharMacros = GetNumMacros();
						if PigMacroCount==0 then
							PigMacroCount = AccMacros + CharMacros;
						elseif (PigMacroCount > AccMacros + CharMacros) then
							PigMacroDeleted = true;
						end
						PigMacroDeleted,PigMacroCount=Update_Macro(self,PigMacroDeleted,PigMacroCount,"PigAction")
					end
				end
				Update_Icon(self)
				Update_Count(self)
				Update_State(self)
			end
			if event=="AREA_POIS_UPDATED" then
				Update_bukeyong(self)
			end
		end)
	end
end
--=====================================================
local Showtiaojian = {"一直显示","脱战后隐藏","进战斗隐藏","无目标隐藏",};
for index=1,zongshu do
	local kaiqiewaidongzuotiao = CreateFrame("CheckButton", "kaiqiewaidongzuotiao"..index, fuFrame, "ChatConfigCheckButtonTemplate");
	kaiqiewaidongzuotiao:SetSize(28,28);
	if index==1 then
		kaiqiewaidongzuotiao:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-20);
	else
		local zheng,yushu =math.modf(index/2)
		if yushu==0 then
			kaiqiewaidongzuotiao:SetPoint("LEFT",_G["kaiqiewaidongzuotiao"..(index-1)],"RIGHT",252,0);
		else
			kaiqiewaidongzuotiao:SetPoint("TOPLEFT",_G["kaiqiewaidongzuotiao"..(index-2)],"BOTTOMLEFT",0,-80);
		end
	end
	kaiqiewaidongzuotiao:SetHitRectInsets(0,-100,0,0);
	kaiqiewaidongzuotiao.Text:SetText("启用PIG动作条"..index);
	kaiqiewaidongzuotiao.tooltip = "启用"..index.."号额外动作条";
	kaiqiewaidongzuotiao:SetScript("OnClick", function ()
		if kaiqiewaidongzuotiao:GetChecked() then
			PIG_Per["PigAction"]["Open"][index]="ON"
			ADD_ActionBar(index)
		else
			PIG_Per["PigAction"]["Open"][index]="OFF"
			Pig_Options_RLtishi_UI:Show()
		end
	end);
	kaiqiewaidongzuotiao.lookdongzuotiao = CreateFrame("CheckButton", nil, kaiqiewaidongzuotiao, "ChatConfigCheckButtonTemplate");
	kaiqiewaidongzuotiao.lookdongzuotiao:SetSize(28,28);
	kaiqiewaidongzuotiao.lookdongzuotiao:SetPoint("TOPLEFT",kaiqiewaidongzuotiao,"BOTTOMLEFT",30,0);
	kaiqiewaidongzuotiao.lookdongzuotiao:SetHitRectInsets(0,-60,0,0);
	kaiqiewaidongzuotiao.lookdongzuotiao.Text:SetText("锁定位置");
	kaiqiewaidongzuotiao.lookdongzuotiao.tooltip = "锁定动作条位置，并隐藏拖拽按钮。";
	kaiqiewaidongzuotiao.lookdongzuotiao:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per["PigAction"]["Look"][index]="ON"
		else
			PIG_Per["PigAction"]["Look"][index]="OFF"
		end
		if _G[barName..index] then
			if PIG_Per["PigAction"]["Look"][index]=="ON" then
				_G[barName..index].yidong:Hide()
			elseif PIG_Per["PigAction"]["Look"][index]=="OFF" then
				_G[barName..index].yidong:Show()
			end
		end
	end);
	kaiqiewaidongzuotiao.ShowHide=PIGDownMenu(nil,{120,24},kaiqiewaidongzuotiao,{"TOPLEFT",kaiqiewaidongzuotiao.lookdongzuotiao,"BOTTOMLEFT",0,0})
	function kaiqiewaidongzuotiao.ShowHide:PIGDownMenu_Update_But(self)
		local info = {}
		info.func = self.PIGDownMenu_SetValue
		for i=1,#Showtiaojian,1 do
		    info.text, info.arg1 = Showtiaojian[i], i
		    info.checked = i==PIG_Per['PigAction']['ShowTJ'][index]
			kaiqiewaidongzuotiao.ShowHide:PIGDownMenu_AddButton(info)
		end 
	end
	function kaiqiewaidongzuotiao.ShowHide:PIGDownMenu_SetValue(value,arg1,arg2)
		if InCombatLockdown()  then 
			print("|cff00FFFF!Pig:|r|cffFFFF00请在脱战后改变隐藏条件。|r");
			return 
		end
		kaiqiewaidongzuotiao.ShowHide:PIGDownMenu_SetText(value)
		PIG_Per['PigAction']['ShowTJ'][index] = arg1;
		if PIG_Per["PigAction"]["Open"][index]=="ON" then
			for id=1,anniugeshu do
				ShowHideEvent(_G[barName..index.."_But"..id],arg1)
			end
		end
		PIGCloseDropDownMenus()
	end
end
-----------
fuFrame.dongzuotxian = fuFrame:CreateLine()
fuFrame.dongzuotxian:SetColorTexture(1,1,1,0.4)
fuFrame.dongzuotxian:SetThickness(1);
fuFrame.dongzuotxian:SetStartPoint("TOPLEFT",2,-250)
fuFrame.dongzuotxian:SetEndPoint("TOPRIGHT",-2,-250)
fuFrame.title = fuFrame:CreateFontString();
fuFrame.title:SetPoint("TOPLEFT",fuFrame.dongzuotxian,"TOPLEFT",20,-20);
fuFrame.title:SetFontObject(GameFontNormal);
fuFrame.title:SetText("提示：");
fuFrame.title1 = fuFrame:CreateFontString();
fuFrame.title1:SetPoint("TOPLEFT",fuFrame.dongzuotxian,"TOPLEFT",40,-50);
fuFrame.title1:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.title1:SetText("\124cff00ff001.可右击拖拽按钮变换动作条排列方式\124r");
fuFrame.title2 = fuFrame:CreateFontString();
fuFrame.title2:SetPoint("TOPLEFT",fuFrame.dongzuotxian,"TOPLEFT",40,-80);
fuFrame.title2:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.title2:SetJustifyH("LEFT");
fuFrame.title2:SetText("\124cff00ff002.此额外动作条非大脚那种调用系统预留给其他姿态(例如鸟德暗牧)的动作条，\n而是完全独立的动作条，不会占用角色其他形态的动作条按钮。\124r");

---重置配置
fuFrame.CZ = fuFrame:CreateFontString();
fuFrame.CZ:SetPoint("TOPLEFT",fuFrame.dongzuotxian,"TOPLEFT",40,-140);
fuFrame.CZ:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
fuFrame.CZ:SetText("\124cffFFff00出问题点：\124r");
fuFrame.CZBUT = CreateFrame("Button",nil,fuFrame, "UIPanelButtonTemplate");  
fuFrame.CZBUT:SetSize(76,20);
fuFrame.CZBUT:SetPoint("LEFT",fuFrame.CZ,"RIGHT",10,0);
fuFrame.CZBUT:SetText("重置配置");
fuFrame.CZBUT:SetScript("OnClick", function ()
	StaticPopup_Show ("CHONGZHI_EWAIDONGZUO");
end);
StaticPopupDialogs["CHONGZHI_EWAIDONGZUO"] = {
	text = "此操作将\124cffff0000重置\124r额外动作条配置。\n确定重置?",
	button1 = "确定",
	button2 = "取消",
	OnAccept = function()
		PIG_Per["PigAction"] = addonTable.Default["PigAction"];
		Pig_Options_RLtishi_UI:Show()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}
----
fuFrame:HookScript("OnShow", function (self)
	for index=1,zongshu do
		local ckfame=_G["kaiqiewaidongzuotiao"..index]
		if PIG_Per["PigAction"]["Open"][index]=="ON" then
			ckfame:SetChecked(true)
		end
		if PIG_Per["PigAction"]["Look"][index]=="ON" then
			ckfame.lookdongzuotiao:SetChecked(true)
		end
		ckfame.ShowHide:PIGDownMenu_SetText(Showtiaojian[PIG_Per['PigAction']['ShowTJ'][index]])
	end
end);
-------------------------
addonTable.Pig_Action = function()
	for index=1,zongshu do
		if PIG_Per["PigAction"]["Open"][index]=="ON" then
			ADD_ActionBar(index)
		end
	end
end
--处理绑定
-- local function shuaxinbangding()
-- 	for index=1,zongshu do
-- 		for id=1,anniugeshu do
-- 			if _G["piganniu_"..index.."_"..id] then
-- 				local key1, key2 = GetBindingKey("CLICK piganniu_"..index.."_"..id..":LeftButton")
-- 				if key1 then
-- 					_G["piganniu_"..index.."_"..id].HotKey:SetText(key1)
-- 				end
-- 			end
-- 		end
-- 	end
-- end
-- local dongzuotiaoshijian = CreateFrame("Frame"); 
-- dongzuotiaoshijian:RegisterEvent("UPDATE_BINDINGS");
-- dongzuotiaoshijian:HookScript("OnEvent",function (self,event)
-- 	shuaxinbangding()
-- end)
for index=1,zongshu do
	for id=1,anniugeshu do
		--_G["BINDING_NAME_CLICK piganniu_"..index.."_"..id] = "PIG<"..index..">动作条"..id.."号键"
		_G["BINDING_NAME_CLICK "..barName..index.."_But"..id..":LeftButton"]= "PIG动作条<"..index..">按钮"..id
	end
end
_G.BINDING_HEADER_PIG = addonName
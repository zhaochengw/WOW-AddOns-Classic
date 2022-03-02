local addonName, addonTable = ...;
-------
local fuFrame = Pig_Options_RF_TAB_8_UI
--=======================================
local anniugeshu,anniujiange=12,6;
local zongshu =4;
----------
local pailiefangshi={"横向","竖向","6×2","2×6","4×3","3×4","取消"};
local pailiexuhaoID={1,2,3,4,5,6};
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
local function All_pailie(index,ActionW)
	for x=1,#pailiexuhaoID do
		if PIG_Per["PigAction"]["Pailie"][index] == pailiexuhaoID[x] then
			for i=2,12 do
				_G["piganniu_"..index.."_"..i]:ClearAllPoints();
				_G["piganniu_"..index.."_"..i]:SetPoint(pailieweizhi[x][i-1][1],_G["piganniu_"..index.."_"..(i-pailieweizhi[x][i-1][5])],pailieweizhi[x][i-1][2],pailieweizhi[x][i-1][3],pailieweizhi[x][i-1][4])
			end
		end
	end
end
local function add_pailie(index,id)
	for x=1,#pailiexuhaoID do
		if PIG_Per["PigAction"]["Pailie"][index] == pailiexuhaoID[x] then
			_G["piganniu_"..index.."_"..id]:SetPoint(pailieweizhi[x][id-1][1],_G["piganniu_"..index.."_"..(id-pailieweizhi[x][id-1][5])],pailieweizhi[x][id-1][2],pailieweizhi[x][id-1][3],pailieweizhi[x][id-1][4])
		end
	end
end
-----------
local PigMacroEventCount =0;
local PigMacroDeleted = false;
local PigMacroCount=0
local function IncBetween(Val, Low, High)
	return Val >= Low and Val <= High;
end
local function RefreshMacro(self,index,id)
			if (InCombatLockdown()) then  return  end
			local OldIndex = PIG_Per['PigAction']['Spell_list'][index][id][2]
			local OldName = PIG_Per['PigAction']['Spell_list'][index][id][3]
			local Oldbody = PIG_Per['PigAction']['Spell_list'][index][id][5]
			local TrimBody = strtrim(Oldbody or '');--去除空格
			local AccMacros, CharMacros = GetNumMacros();
			local BodyIndex = 0;
			--未变
			local Name, Icon, Body = GetMacroInfo(OldIndex);
			if (TrimBody == strtrim(Body or '') and OldName == Name) then
				local Name, Icon, Body = GetMacroInfo(OldIndex);
				PIG_Per['PigAction']['Spell_list'][index][id][4]=Icon
				self.icon:SetTexture(Icon);
				return;	
			end
			--删除重新定位
			if (IncBetween(OldIndex - 1, 1, AccMacros) or IncBetween(OldIndex - 1, MAX_ACCOUNT_MACROS + 1, MAX_ACCOUNT_MACROS + CharMacros)) then
				local Name, Icon, Body = GetMacroInfo(OldIndex - 1);
				if (TrimBody == strtrim(Body or '') and OldName == Name) then
					PIG_Per['PigAction']['Spell_list'][index][id][2]=OldIndex-1
					PIG_Per['PigAction']['Spell_list'][index][id][4]=Icon
					self.icon:SetTexture(Icon);	
					self.Name:SetText(OldName);
					self:SetAttribute("macro", PIG_Per['PigAction']['Spell_list'][index][id][2]);
					return;				
				end
			end
			--增加重新定位
			if (IncBetween(OldIndex + 1, 1, AccMacros) or IncBetween(OldIndex + 1, MAX_ACCOUNT_MACROS + 1, MAX_ACCOUNT_MACROS + CharMacros)) then
				local Name, Icon, Body = GetMacroInfo(OldIndex + 1);
				if (TrimBody == strtrim(Body or '') and OldName == Name) then
					PIG_Per['PigAction']['Spell_list'][index][id][2]=OldIndex+1
					PIG_Per['PigAction']['Spell_list'][index][id][4]=Icon
					self.icon:SetTexture(Icon);
					self.Name:SetText(OldName);
					self:SetAttribute("macro", OldIndex+1);
					return;
				end
			end
			--其他宏改名后搜索相同宏位置
			for i = 1, AccMacros do
				local Name, Icon, Body = GetMacroInfo(i);
				local Body = strtrim(Body or '');
				if (TrimBody == Body and OldName == Name) then
					PIG_Per['PigAction']['Spell_list'][index][id][2]=i
					PIG_Per['PigAction']['Spell_list'][index][id][4]=Icon
					self.icon:SetTexture(Icon);	
					self.Name:SetText(Name);
					BodyIndex = i;
					self:SetAttribute("macro", PIG_Per['PigAction']['Spell_list'][index][id][2]);
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
					PIG_Per['PigAction']['Spell_list'][index][id][2]=i
					PIG_Per['PigAction']['Spell_list'][index][id][4]=Icon
					self.icon:SetTexture(Icon);	
					self.Name:SetText(Name);
					self:SetAttribute("macro", PIG_Per['PigAction']['Spell_list'][index][id][2]);
					return;
				end
				if (TrimBody == Body and Body ~= nil and Body ~= "") then
					BodyIndex = i;
				end
			end
			--无删除未找到名称和内容均相同的
			if PigMacroDeleted==false then
				--有相同body
				if (BodyIndex ~= 0) then 
					PIG_Per['PigAction']['Spell_list'][index][id][2]=BodyIndex
					local Name, Icon, Body = GetMacroInfo(BodyIndex);
					PIG_Per['PigAction']['Spell_list'][index][id][3]=Name
					PIG_Per['PigAction']['Spell_list'][index][id][4]=Icon
					self.icon:SetTexture(Icon);	
					self.Name:SetText(Name);
					self:SetAttribute("macro", PIG_Per['PigAction']['Spell_list'][index][id][2]);
					return;
				end
				--有相同Name
				local Name, Icon, Body = GetMacroInfo(OldIndex);
				if (OldName == Name) then
					PIG_Per['PigAction']['Spell_list'][index][id][4]=Icon
					PIG_Per['PigAction']['Spell_list'][index][id][5]=Body
					self.icon:SetTexture(Icon);
					return;
				end
			end
			--有删除
			if PigMacroDeleted==true then
				PIG_Per['PigAction']['Spell_list'][index][id]=nil
				self.icon:SetTexture();
				self.Count:SetText();
				self.Name:SetText();
				_G[self:GetName().."Cooldown"]:Hide()
				self:SetAttribute("type", nil);
				local Showvalue = GetCVarInfo("alwaysShowActionBars")
				if Showvalue=="1" then
					self:Show();
				else
					self:Hide();
				end
				PigMacroDeleted = false;
				PigMacroCount = AccMacros + CharMacros;	
			end
end
---锁定位置
local function suodingWeizhi(i)
	if _G["Pig_bar_"..i] then
		if PIG_Per["PigAction"]["Look"][i]=="ON" then
			_G["Pig_bar_"..i].yidong:Hide()
		elseif PIG_Per["PigAction"]["Look"][i]=="OFF" then
			_G["Pig_bar_"..i].yidong:Show()
		end
	end
end
---处理光标
local function chuliCursorInfo(index,id,self,infoType, canshu1, canshu2,canshu3)
	if infoType then
		ClearCursor();
		if not InCombatLockdown() then
			if PIG_Per['PigAction']['Spell_list'][index][id] then
				local OLD_leixing=PIG_Per['PigAction']['Spell_list'][index][id][1]
				local OLD_neirongID=PIG_Per['PigAction']['Spell_list'][index][id][2]
				if OLD_leixing=="spell" then
					PickupSpell(OLD_neirongID)
				elseif OLD_leixing=="item" then
					PickupItem(OLD_neirongID)
				elseif OLD_leixing=="macro" then
					PickupMacro(OLD_neirongID)
				end
			end
		end
		if infoType=="spell" then
			local icon = GetSpellTexture(canshu3)
			self.icon:SetTexture(icon);
			local start, duration = GetSpellCooldown(canshu3);
			_G[self:GetName().."Cooldown"]:SetCooldown(start, duration);
			local SPhuafei=IsConsumableSpell(canshu3)
			if SPhuafei then
				local jiengncailiao = GetSpellCount(canshu3)
				if jiengncailiao>0 then
		            self.Count:SetText(jiengncailiao)
		        else
		        	self.Count:SetText("|cffff0000"..jiengncailiao.."|r")
		        end
		    else
				self.Count:SetText()
		    end
		    PIG_Per['PigAction']['Spell_list'][index][id]={infoType,canshu3}
		elseif infoType=="item" then
			-- local _,dalei,xiaolei = GetItemInfoInstant(canshu1)
			-- print(dalei,xiaolei)
			-- if dalei=="商品" then return end
			local itemIcon = GetItemIcon(canshu1)
			self.icon:SetTexture(itemIcon);
			local start, duration = GetSpellCooldown(canshu1);
			_G[self:GetName().."Cooldown"]:SetCooldown(start, duration);
			local _,dalei,xiaolei = GetItemInfoInstant(canshu1)
			local Ccount = GetItemCount(canshu1, false, true) or GetItemCount(canshu1)
			if dalei=="消耗品" then
				if Ccount>0 then
					self.icon:SetVertexColor(1, 1, 1);
					self.Count:SetText(Ccount);
				else
					self.icon:SetVertexColor(0.5, 0.5, 0.5);
					self.Count:SetText("|cffff0000"..Ccount.."|r");
				end
			else
				if Ccount>0 then
					self.icon:SetVertexColor(1, 1, 1);
				else
					self.icon:SetVertexColor(0.5, 0.5, 0.5);
				end
			end
			PIG_Per['PigAction']['Spell_list'][index][id]={infoType,canshu1}			
		elseif infoType=="macro" then
			local hongxinxi={}
			local name, icon, body, isLocal = GetMacroInfo(canshu1)
			self.Name:SetText(name);
			self.icon:SetTexture(icon);
			local hongSpellID = GetMacroSpell(canshu1)
			if hongSpellID then
				local start, duration = GetSpellCooldown(hongSpellID);
				_G[self:GetName().."Cooldown"]:SetCooldown(start, duration);
				local SPhuafei=IsConsumableSpell(hongSpellID)
				if SPhuafei then
					self.Name:SetText();
					local jiengncailiao = GetSpellCount(hongSpellID)
					if jiengncailiao>0 then
			            self.Count:SetText(jiengncailiao)
			        else
			        	self.Count:SetText("|cffff0000"..jiengncailiao.."|r")
			        end
			    else
					self.Count:SetText()
			    end
				hongxinxi={infoType,canshu1,name,icon,body,"spell",hongSpellID}
			else
				local ItemName, ItemLink = GetMacroItem(canshu1);
				if ItemName then
					local ItemID = GetItemInfoInstant(ItemName)
					local start, duration = GetItemCooldown(ItemID);
					_G[self:GetName().."Cooldown"]:SetCooldown(start, duration);
					local Ccount = GetItemCount(ItemID, false, true) or GetItemCount(ItemID)
					local _,dalei,xiaolei = GetItemInfoInstant(ItemID)
					if dalei=="消耗品" then
						piganniu.Name:SetText();
						if Ccount>0 then
							piganniu.icon:SetVertexColor(1, 1, 1);
							piganniu.Count:SetText(Ccount);
						else
							piganniu.icon:SetVertexColor(0.5, 0.5, 0.5);
							piganniu.Count:SetText("|cffff0000"..Ccount.."|r");
						end
					else
						if Ccount>0 then
							piganniu.icon:SetVertexColor(1, 1, 1);
						else
							piganniu.icon:SetVertexColor(0.5, 0.5, 0.5);
						end
					end
					hongxinxi={infoType,canshu1,name,icon,body,"item",ItemID}
				else
					hongxinxi={infoType,canshu1,name,icon,body,"qita",""}
				end
			end
			PIG_Per['PigAction']['Spell_list'][index][id]=hongxinxi
		end
	end
end
---add------------------
local function ADD_ewaianniu(index,ActionW)
	if _G["Pig_bar_"..index] then return end
	local Pig_bar = CreateFrame("Frame", "Pig_bar_"..index, UIParent)
	Pig_bar:SetSize(10,ActionW)
	Pig_bar:SetPoint("CENTER",UIParent,"CENTER",-200,-200+index*50);
	Pig_bar:SetMovable(true)
	Pig_bar:SetClampedToScreen(true)	
	if PIG['PigUI']['ActionBar_bili']=="ON" then
		Pig_bar:SetScale(PIG['PigUI']['ActionBar_bili_value']);
	end
	Pig_bar.yidong = CreateFrame("Frame", nil, Pig_bar,"BackdropTemplate")
	Pig_bar.yidong:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 6,})
	Pig_bar.yidong:SetAllPoints(Pig_bar)
	Pig_bar.yidong:EnableMouse(true)
	Pig_bar.yidong:RegisterForDrag("LeftButton")
	Pig_bar.yidong.t = Pig_bar.yidong:CreateFontString();
	Pig_bar.yidong.t:SetPoint("LEFT", Pig_bar.yidong, "LEFT", 0.8, 0);
	Pig_bar.yidong.t:SetFontObject(GameFontNormal);
	Pig_bar.yidong.t:SetTextColor(0.8, 0.8, 0.8, 0.6);
	Pig_bar.yidong.t:SetText(index);
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

	for b=1,#pailiefangshi do
		local RightC_C = CreateFrame("CheckButton", "RightC_"..index.."_"..b, Pig_bar.yidong.RightC,"UIRadioButtonTemplate");
		RightC_C:SetSize(20,20);
		RightC_C:SetHitRectInsets(0,-52,-2,-2);
		if b==1 then
			RightC_C:SetPoint("TOPLEFT",Pig_bar.yidong.RightC,"TOPLEFT",10,-8);
		else
			RightC_C:SetPoint("TOPLEFT",_G["RightC_"..index.."_"..(b-1)],"BOTTOMLEFT",0,-8);
		end
		_G["RightC_"..index.."_"..b.."Text"]:SetText(pailiefangshi[b]);
		RightC_C:SetScript("OnClick", function (self)
			if b~=#pailiefangshi then
				for q=1,#pailiefangshi do
					_G["RightC_"..index.."_"..q]:SetChecked(false);
				end
				self:SetChecked(true);
				PIG_Per["PigAction"]["Pailie"][index]=pailiexuhaoID[b]
				All_pailie(index,ActionW)
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
				for l=1,#pailiexuhaoID do
					if PIG_Per["PigAction"]["Pailie"][index] == pailiexuhaoID[l] then
						_G["RightC_"..index.."_"..l]:SetChecked(true);
					end
				end
			end
		end
	end)
	--------
	for id=1,anniugeshu do
		local ActionID = index*1000+id
		--local piganniu = CreateFrame("CheckButton", "piganniu_"..index.."_"..id, Pig_bar, "ActionBarButtonTemplate")
		local piganniu = CreateFrame("CheckButton", "piganniu_"..index.."_"..id, Pig_bar, "SecureActionButtonTemplate,ActionButtonTemplate,SecureHandlerDragTemplate,SecureHandlerMouseUpDownTemplate")
		piganniu:SetSize(ActionW, ActionW)
		piganniu.NormalTexture:SetAlpha(0.4);
		if id==1 then
			piganniu:SetPoint("LEFT",Pig_bar,"RIGHT",2,0)
		else
			add_pailie(index,id)
		end
		piganniu:RegisterForClicks("AnyUp");
		--piganniu:RegisterForClicks("AnyDown");
		piganniu:RegisterForDrag("LeftButton","RightButton")
		--piganniu:SetAttribute("click", "LeftButton")
		-- piganniu:SetAttribute("checkselfcast", true);
		-- piganniu:SetAttribute("checkfocuscast", true);
		-- piganniu:SetAttribute("showgrid", 1);
		-- piganniu:SetAttribute('type', 'action')
		-- piganniu:SetAttribute("action", ActionID)
		_G["piganniu_"..index.."_"..id.."Cooldown"]:SetSwipeColor(0, 0, 0, 0.8);

		piganniu.FloatingBG = piganniu:CreateTexture(nil, "BACKGROUND", nil, -1);
		piganniu.FloatingBG:SetTexture("Interface\\Buttons\\UI-Quickslot");
		piganniu.FloatingBG:SetAlpha(0.4);
		piganniu.FloatingBG:SetPoint("TOPLEFT", -15, 15);
		piganniu.FloatingBG:SetPoint("BOTTOMRIGHT", 15, -15);
		--------------
		piganniu:HookScript("PostClick", function(self)
			self:SetChecked(false)
		end);

		piganniu:HookScript("OnMouseDown", function(self)
			if InCombatLockdown() then return end
			local leixing1= GetCursorInfo()
			if leixing1 then
				self:Disable()
			end
		end);
		---
		piganniu:SetAttribute("_OnMouseUp",[=[
			self:Enable()
		]=])
		piganniu:HookScript("OnMouseUp", function (self)
			if InCombatLockdown() then return end
			local infoType, canshu1, canshu2,canshu3= GetCursorInfo()
			if infoType then
				if infoType=="spell" then
					self:SetAttribute("type", infoType)
					self:SetAttribute(infoType, canshu3)
				elseif infoType=="item" then
					self:SetAttribute("type", infoType)
					self:SetAttribute(infoType, canshu2)
				elseif infoType=="macro" then
					self:SetAttribute("type", infoType)
					self:SetAttribute(infoType, canshu1)
				end
				chuliCursorInfo(index,id,self,infoType, canshu1, canshu2,canshu3)
			end
		end);
		---
		piganniu:HookScript("OnDragStart",  function (self)
			if InCombatLockdown() then return end
			if PIG_Per['PigAction']['Spell_list'][index][id] then
				local leibie=PIG_Per['PigAction']['Spell_list'][index][id][1]
				local spieID=PIG_Per['PigAction']['Spell_list'][index][id][2]
				local lockvalue = GetCVarInfo("lockActionBars")
				if lockvalue=="0" then
					self.icon:SetTexture();
					self.Count:SetText();
					self.Name:SetText();
					_G[self:GetName().."Cooldown"]:Hide()
					self:SetAttribute("type", nil);
					if leibie=="item" then
						PickupItem(spieID)
					elseif leibie=="spell" then
						PickupSpell(spieID)
					elseif leibie=="macro" then
						PickupMacro(spieID)
					end
				elseif lockvalue=="1" then
					local aShiftKeyIsDown = IsShiftKeyDown();
					if aShiftKeyIsDown then
						self.icon:SetTexture();
						self.Count:SetText();
						self.Name:SetText();
						self:SetAttribute("type", nil);
						_G[self:GetName().."Cooldown"]:Hide()
						if leibie=="item" then
							PickupItem(spieID)
						elseif leibie=="spell" then
							PickupSpell(spieID)
						elseif leibie=="macro" then
							PickupMacro(spieID)
						end
					end
				end
				PIG_Per['PigAction']['Spell_list'][index][id]=nil
			end
		end);
		--
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
		piganniu:HookScript("OnReceiveDrag",  function (self)
			local infoType, canshu1, canshu2,canshu3= GetCursorInfo()
			chuliCursorInfo(index,id,self,infoType, canshu1, canshu2,canshu3)
		end);
		piganniu:SetScript("OnEnter", function (self)
			if PIG_Per['PigAction']['Spell_list'][index][id] then
				local leibie1=PIG_Per['PigAction']['Spell_list'][index][id][1]
				local SIM_ID1=PIG_Per['PigAction']['Spell_list'][index][id][2]
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_NONE");
				GameTooltip:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",-100,140);
				if leibie1=="spell" then
					if IsSpellKnown(SIM_ID1) then
						for i = 1, GetNumSpellTabs() do
							local _, _, offset, numSlots = GetSpellTabInfo(i)
							for j = offset+1, offset+numSlots do
								local _,bookspellID= GetSpellBookItemInfo(j, BOOKTYPE_SPELL)
								if SIM_ID1==bookspellID then
									local _,jibiex= GetSpellBookItemName(j, BOOKTYPE_SPELL)
									GameTooltipTextRight1:Show()
									GameTooltip:SetSpellBookItem(j, BOOKTYPE_SPELL);
									GameTooltipTextRight1:SetText(jibiex)
									GameTooltipTextRight1:SetTextColor(0.5, 0.5, 0.5, 1);
									GameTooltip:Show();
									return
								end
							end
						end
					else
						GameTooltip:SetHyperlink(leibie1..":"..SIM_ID1)
						GameTooltip:Show();
					end	
				elseif leibie1=="item" then
					for Bagid=0,4,1 do
						local numberOfSlots = GetContainerNumSlots(Bagid);
						for caowei=1,numberOfSlots,1 do
							if GetContainerItemID(Bagid, caowei)==SIM_ID1 then
								GameTooltip:SetBagItem(Bagid,caowei);
								GameTooltip:Show();
								return
							end
						end
					end	
					GameTooltip:SetHyperlink(leibie1..":"..SIM_ID1)
					GameTooltip:Show();
				elseif leibie1=="macro" then
					local hongleibie=PIG_Per['PigAction']['Spell_list'][index][id][6]
					local hongSIM_ID=PIG_Per['PigAction']['Spell_list'][index][id][7]
					if hongleibie=="spell" then
						if IsSpellKnown(hongSIM_ID) then
							for i = 1, GetNumSpellTabs() do
								local _, _, offset, numSlots = GetSpellTabInfo(i)
								for j = offset+1, offset+numSlots do
									local _,bookspellID= GetSpellBookItemInfo(j, BOOKTYPE_SPELL)
									if hongSIM_ID==bookspellID then
										local _,jibiex= GetSpellBookItemName(j, BOOKTYPE_SPELL)
										GameTooltip:SetSpellBookItem(j, BOOKTYPE_SPELL);
										GameTooltipTextRight1:SetText(jibiex)
										GameTooltipTextRight1:SetTextColor(0.5, 0.5, 0.5, 1);
										GameTooltipTextRight1:Show()
										GameTooltip:Show();
										return
									end
								end
							end
						else
							GameTooltip:SetHyperlink(hongleibie..":"..hongSIM_ID)
							GameTooltip:Show();
						end
					elseif hongleibie=="item" then
						for Bagid=0,4,1 do
							local numberOfSlots = GetContainerNumSlots(Bagid);
							for caowei=1,numberOfSlots,1 do
								if GetContainerItemID(Bagid, caowei)==hongSIM_ID then
									GameTooltip:SetBagItem(Bagid,caowei);
									GameTooltip:Show();
									return
								end
							end
						end
						GameTooltip:SetHyperlink(hongleibie..":"..hongSIM_ID)
						GameTooltip:Show();
					elseif hongleibie=="qita" then
						local hongName=PIG_Per['PigAction']['Spell_list'][index][id][3]
						GameTooltip:SetText(hongName,1, 1, 1, 1)
						GameTooltip:Show();
					end
				end
			end
		end);
		piganniu:SetScript("OnLeave", function ()
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		--------------------
		if PIG_Per['PigAction']['Spell_list'][index][id] then
			local leibie=PIG_Per['PigAction']['Spell_list'][index][id][1]
			local SIM_ID=PIG_Per['PigAction']['Spell_list'][index][id][2]
			piganniu:SetAttribute("type", leibie)	
			if leibie=="spell" then
				piganniu:SetAttribute(leibie, SIM_ID)
				local icon = GetSpellTexture(SIM_ID)
				piganniu.icon:SetTexture(icon);
				local start, duration = GetSpellCooldown(SIM_ID);
				_G["piganniu_"..index.."_"..id.."Cooldown"]:SetCooldown(start, duration);
			elseif leibie=="item" then
				local itemName = C_Item.GetItemNameByID(SIM_ID)
				piganniu:SetAttribute(leibie, itemName)
				local icon = GetItemIcon(SIM_ID)
				piganniu.icon:SetTexture(icon);
				local start, duration, enable = GetItemCooldown(SIM_ID)
				_G["piganniu_"..index.."_"..id.."Cooldown"]:SetCooldown(start, duration);
			elseif leibie=="macro" then
				piganniu:SetAttribute(leibie, SIM_ID)
				local hongleibie=PIG_Per['PigAction']['Spell_list'][index][id][6]
				local hongSIM_ID=PIG_Per['PigAction']['Spell_list'][index][id][7]
				if hongleibie=="spell" then
				    local start, duration = GetSpellCooldown(hongSIM_ID);
					_G["piganniu_"..index.."_"..id.."Cooldown"]:SetCooldown(start, duration);
				elseif hongleibie=="item" then
					local start, duration = GetItemCooldown(hongSIM_ID);
					_G["piganniu_"..index.."_"..id.."Cooldown"]:SetCooldown(start, duration);
				end
			end
		end
		-------------
		--piganniu:RegisterEvent("BAG_UPDATE_COOLDOWN");
		--piganniu:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED","player");
		---
		piganniu:RegisterEvent("SPELL_UPDATE_COOLDOWN");
		piganniu:RegisterUnitEvent("UNIT_SPELLCAST_START","player");
		piganniu:RegisterUnitEvent("UNIT_SPELLCAST_STOP","player");
		piganniu:RegisterUnitEvent("UNIT_AURA","player");
		piganniu:RegisterEvent("BAG_UPDATE");
		piganniu:RegisterEvent("UPDATE_MACROS");
		piganniu:RegisterEvent("TRADE_SKILL_UPDATE")
		piganniu:RegisterEvent("TRADE_SKILL_CLOSE")
		piganniu:RegisterEvent("CRAFT_SHOW")
		piganniu:RegisterEvent("CRAFT_CLOSE")
		piganniu:RegisterEvent("ACTIONBAR_SHOWGRID");
		piganniu:RegisterEvent("ACTIONBAR_HIDEGRID");
		piganniu:RegisterEvent("CVAR_UPDATE");
		piganniu:RegisterEvent("PLAYER_REGEN_ENABLED");
		piganniu:HookScript("OnEvent", function(self,event,arg1,arg2,arg3)
			if event=="ACTIONBAR_SHOWGRID" then
				if InCombatLockdown() then return end
				self:Show();
			end
			if event=="ACTIONBAR_HIDEGRID" then
				if InCombatLockdown() then return end
				local Showvalue = GetCVarInfo("alwaysShowActionBars")
				if Showvalue=="0" then
					if not PIG_Per['PigAction']['Spell_list'][index][id] then
						self:Hide();
					end
				end
			end

			if event=="CVAR_UPDATE" then
				if InCombatLockdown() then return end
				if arg1=="ALWAYS_SHOW_MULTIBARS_TEXT" then
					if arg2=="0" then
						if not PIG_Per['PigAction']['Spell_list'][index][id] then
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
					if not PIG_Per['PigAction']['Spell_list'][index][id] then
						self:Hide();
					end
				elseif Showvalue=="1" then
					self:Show();
				end
			end
			if PIG_Per['PigAction']['Spell_list'][index][id] then
				local leibie=PIG_Per['PigAction']['Spell_list'][index][id][1]
				local SIM_ID=PIG_Per['PigAction']['Spell_list'][index][id][2]
				if event=="UNIT_AURA" then
					local bianxing = {768,783,5487,9634,24858,33947,40120,1066,13819,34767,34769,23214,5784,23161}
					for ff=1,#bianxing do
						if bianxing[ff]==PIG_Per['PigAction']['Spell_list'][index][id][2] then
									local BUFFcunzaijihuoICON = false
									for i=1,40 do  	
										local spellID = select(10, UnitBuff("player",i))
										if spellID then
											if spellID==PIG_Per['PigAction']['Spell_list'][index][id][2] then
												BUFFcunzaijihuoICON = true
												break
											end
										end
									end
									if BUFFcunzaijihuoICON then
										self:SetChecked(true)
										self.icon:SetTexture(136116);
									else
										self:SetChecked(false)
										local icon = GetSpellTexture(PIG_Per['PigAction']['Spell_list'][index][id][2])
										self.icon:SetTexture(icon);
									end
						end
					end
				end
				if event=="UNIT_SPELLCAST_START" then
						if arg3==PIG_Per['PigAction']['Spell_list'][index][id][2] then
							self:SetChecked(true)
						end
				end
				if event=="UNIT_SPELLCAST_STOP" then
						if arg3==PIG_Per['PigAction']['Spell_list'][index][id][2] then
							self:SetChecked(false)
						end
				end
				if event=="TRADE_SKILL_UPDATE" then
						local tradeskillName = GetTradeSkillLine()
						local NEWname = GetSpellInfo(PIG_Per['PigAction']['Spell_list'][index][id][2]);
						if tradeskillName==NEWname then
							self:SetChecked(true)
						end
				end
				if event=="TRADE_SKILL_CLOSE" then
						local Skill_List = {'烹饪', '急救', '裁缝', '熔炼', '工程学', '锻造', '制皮', '炼金术',"珠宝加工","铭文"};
						local NEWname = GetSpellInfo(PIG_Per['PigAction']['Spell_list'][index][id][2]);
						for k=1,#Skill_List do
							if Skill_List[k]==NEWname then
								self:SetChecked(false)
							end
						end
				end
				if event=="CRAFT_SHOW" then
						local Skill_List = {'附魔', '训练宠物'};
						local NEWname = GetSpellInfo(PIG_Per['PigAction']['Spell_list'][index][id][2]);
						for k=1,#Skill_List do
							if Skill_List[k]==NEWname then
								self:SetChecked(true)
							end
						end
				end
				if event=="CRAFT_CLOSE" then
						local Skill_List = {'附魔', '训练宠物'};
						local NEWname = GetSpellInfo(PIG_Per['PigAction']['Spell_list'][index][id][2]);
						for k=1,#Skill_List do
							if Skill_List[k]==NEWname then
								self:SetChecked(false)
							end
						end
				end
				if event=="UPDATE_MACROS" then
					if PIG_Per['PigAction']['Spell_list'][index][id][1]=="macro" then
						local name, icon = GetMacroInfo(PIG_Per['PigAction']['Spell_list'][index][id][2])
						self.icon:SetTexture(icon);
						self.Name:SetText(name);
					end
					PigMacroEventCount=PigMacroEventCount+1;
					if leibie=="macro" then
						if PigMacroEventCount>5 then
							local AccMacros, CharMacros = GetNumMacros();
							if PigMacroCount==0 then
								PigMacroCount = AccMacros + CharMacros;
							elseif (PigMacroCount > AccMacros + CharMacros) then
								PigMacroDeleted = true;
							end
							RefreshMacro(self,index,id)
						end 
					end				
				end
				if event=="SPELL_UPDATE_COOLDOWN" then
					if leibie=="spell" then
						local start, duration = GetSpellCooldown(SIM_ID);
						_G[self:GetName().."Cooldown"]:SetCooldown(start, duration);
					elseif leibie=="item" then
						local start, duration, enable = GetItemCooldown(SIM_ID)
						_G["piganniu_"..index.."_"..id.."Cooldown"]:SetCooldown(start, duration);
					elseif leibie=="macro" then
						local hongleibie=PIG_Per['PigAction']['Spell_list'][index][id][6]
						local hongSIM_ID=PIG_Per['PigAction']['Spell_list'][index][id][7]
						if hongleibie=="spell" then
				   			local start, duration = GetSpellCooldown(hongSIM_ID);
							_G["piganniu_"..index.."_"..id.."Cooldown"]:SetCooldown(start, duration);
						elseif hongleibie=="item" then
							local start, duration = GetItemCooldown(hongSIM_ID);
							_G["piganniu_"..index.."_"..id.."Cooldown"]:SetCooldown(start, duration);
						end
					end
				end
				if event=="BAG_UPDATE" then
					if leibie=="spell" then
						local SPhuafei=IsConsumableSpell(SIM_ID)
						if SPhuafei then
							local jiengncailiao = GetSpellCount(SIM_ID)
							if jiengncailiao>0 then
					            piganniu.Count:SetText(jiengncailiao)
					        else
					        	piganniu.Count:SetText("|cffff0000"..jiengncailiao.."|r")
					        end
					    else
							piganniu.Count:SetText()
					    end
					elseif leibie=="item" then
						local _,dalei,xiaolei = GetItemInfoInstant(SIM_ID)
						local Ccount = GetItemCount(SIM_ID, false, true) or GetItemCount(SIM_ID)
						if dalei=="消耗品" then
							if Ccount>0 then
								self.icon:SetVertexColor(1, 1, 1);
								self.Count:SetText(Ccount);
							else
								self.icon:SetVertexColor(0.5, 0.5, 0.5);
								self.Count:SetText("|cffff0000"..Ccount.."|r");
							end
						else
							if Ccount>0 then
								self.icon:SetVertexColor(1, 1, 1);
							else
								self.icon:SetVertexColor(0.5, 0.5, 0.5);
							end
						end
					elseif leibie=="macro" then
						local hongleibie=PIG_Per['PigAction']['Spell_list'][index][id][6]
						local hongSIM_ID=PIG_Per['PigAction']['Spell_list'][index][id][7]
						if hongleibie=="spell" then
							local SPhuafei=IsConsumableSpell(hongSIM_ID)
							if SPhuafei then
								piganniu.Name:SetText();
								local jiengncailiao = GetSpellCount(hongSIM_ID)
								if jiengncailiao>0 then
						            piganniu.Count:SetText(jiengncailiao)
						        else
						        	piganniu.Count:SetText("|cffff0000"..jiengncailiao.."|r")
						        end
						    else
								piganniu.Count:SetText()
						    end
						elseif hongleibie=="item" then
							local Ccount = GetItemCount(hongSIM_ID, false, true) or GetItemCount(hongSIM_ID)
							local _,dalei,xiaolei = GetItemInfoInstant(hongSIM_ID)
							if dalei=="消耗品" then
								piganniu.Name:SetText();
								if Ccount>0 then
									piganniu.icon:SetVertexColor(1, 1, 1);
									piganniu.Count:SetText(Ccount);
								else
									piganniu.icon:SetVertexColor(0.5, 0.5, 0.5);
									piganniu.Count:SetText("|cffff0000"..Ccount.."|r");
								end
							else
								if Ccount>0 then
									piganniu.icon:SetVertexColor(1, 1, 1);
								else
									piganniu.icon:SetVertexColor(0.5, 0.5, 0.5);
								end
							end
						end
					end
				end
			end
		end)
	end
end
--=====================================================
for i=1,zongshu do
	local kaiqiewaidongzuotiao = CreateFrame("CheckButton", "kaiqiewaidongzuotiao"..i, fuFrame, "ChatConfigCheckButtonTemplate");
	kaiqiewaidongzuotiao:SetSize(28,28);
	if i==1 then
		kaiqiewaidongzuotiao:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-20);
	else
		local zheng,yushu =math.modf(i/2)
		if yushu==0 then
			kaiqiewaidongzuotiao:SetPoint("LEFT",_G["kaiqiewaidongzuotiao"..(i-1)],"RIGHT",252,0);
		else
			kaiqiewaidongzuotiao:SetPoint("TOPLEFT",_G["kaiqiewaidongzuotiao"..(i-2)],"BOTTOMLEFT",0,-60);
		end
	end
	kaiqiewaidongzuotiao:SetHitRectInsets(0,-100,0,0);
	kaiqiewaidongzuotiao.Text:SetText("启用PIG动作条"..i);
	kaiqiewaidongzuotiao.tooltip = "启用"..i.."号额外动作条";
	kaiqiewaidongzuotiao:SetScript("OnClick", function ()
		if kaiqiewaidongzuotiao:GetChecked() then
			PIG_Per["PigAction"]["Open"][i]="ON"
			local ActionW = ActionButton1:GetWidth()
			ADD_ewaianniu(i,ActionW)
		else
			PIG_Per["PigAction"]["Open"][i]="OFF"
			Pig_Options_RLtishi_UI:Show()
		end
	end);
	kaiqiewaidongzuotiao.lookdongzuotiao = CreateFrame("CheckButton", nil, kaiqiewaidongzuotiao, "ChatConfigCheckButtonTemplate");
	kaiqiewaidongzuotiao.lookdongzuotiao:SetSize(28,28);
	kaiqiewaidongzuotiao.lookdongzuotiao:SetPoint("TOPLEFT",kaiqiewaidongzuotiao,"BOTTOMLEFT",30,-2);
	kaiqiewaidongzuotiao.lookdongzuotiao:SetHitRectInsets(0,-60,0,0);
	kaiqiewaidongzuotiao.lookdongzuotiao.Text:SetText("锁定动作条"..i.."位置");
	kaiqiewaidongzuotiao.lookdongzuotiao.tooltip = "锁定动作条位置，并隐藏拖拽按钮。";
	kaiqiewaidongzuotiao.lookdongzuotiao:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG_Per["PigAction"]["Look"][i]="ON"
		else
			PIG_Per["PigAction"]["Look"][i]="OFF"
		end
		suodingWeizhi(i)
	end);
end
-----------
fuFrame.dongzuotxian = fuFrame:CreateLine()
fuFrame.dongzuotxian:SetColorTexture(1,1,1,0.4)
fuFrame.dongzuotxian:SetThickness(1);
fuFrame.dongzuotxian:SetStartPoint("TOPLEFT",2,-190)
fuFrame.dongzuotxian:SetEndPoint("TOPRIGHT",-2,-190)
local TTTTT="\124cff00ff00拖动按钮右键点击变换动作条排列方式\124r"
fuFrame.title = fuFrame:CreateFontString();
fuFrame.title:SetPoint("TOPLEFT",fuFrame.dongzuotxian,"TOPLEFT",20,-20);
fuFrame.title:SetFont(ChatFontNormal:GetFont(), 16, "OUTLINE");
fuFrame.title:SetText(TTTTT);
---重置配置
fuFrame.CZ = fuFrame:CreateFontString();
fuFrame.CZ:SetPoint("BOTTOMLEFT",fuFrame,"BOTTOMLEFT",100,8);
fuFrame.CZ:SetFontObject(GameFontNormal);
fuFrame.CZ:SetText("\124cffFFff00出问题点\124r");
fuFrame.CZBUT = CreateFrame("Button","Default_Button_daibenzhushou_UI",fuFrame, "UIPanelButtonTemplate");  
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
-------------------------
local function yincangkongbai()
	for index=1,zongshu do
		if PIG_Per["PigAction"]["Open"][index]=="ON" then
			for id=1,anniugeshu do
				if not PIG_Per['PigAction']['Spell_list'][index][id] then
					if Showvalue=="0" then piganniu:Hide() end
				end
			end
		end
	end
end
local function shuaxinbangding()
	for i=1,zongshu do
		for id=1,anniugeshu do
			if _G["piganniu_"..i.."_"..id] then
				local key1, key2 = GetBindingKey("CLICK piganniu_"..i.."_"..id..":LeftButton")
				if key1 then
					_G["piganniu_"..i.."_"..id].HotKey:SetText(key1)
				end
			end
		end
	end
end
local dongzuotiaoshijian = CreateFrame("Frame"); 
dongzuotiaoshijian:RegisterEvent("UPDATE_BINDINGS");
dongzuotiaoshijian:HookScript("OnEvent",function (self,event)
	shuaxinbangding()
end)
addonTable.Pig_Action = function()
	PIG_Per["PigAction"]=PIG_Per["PigAction"] or addonTable.Default_Per["PigAction"]
	for i=1,zongshu do
		if PIG_Per["PigAction"]["Open"][i]=="ON" then
			_G["kaiqiewaidongzuotiao"..i]:SetChecked(true)
			local ActionW = ActionButton1:GetWidth()
			ADD_ewaianniu(i,ActionW)
			C_Timer.After(3,yincangkongbai)
		end
		suodingWeizhi(i)
	end
	for i=1,zongshu do
		for id=1,anniugeshu do
			--_G["BINDING_NAME_CLICK piganniu_"..i.."_"..id] = i.."号动作条"..id.."号键"
			setglobal("BINDING_NAME_CLICK piganniu_"..i.."_"..id..":LeftButton", i.."号动作条"..id.."号键")
		end
	end
	shuaxinbangding()
end
_G.BINDING_HEADER_PIG = addonName
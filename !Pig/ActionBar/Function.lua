local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
-------
local suijizuoqi = [=[/run C_MountJournal.SummonByID(0)]=]
local function Update_Attribute(self)
	local Type=self.Type
	if Type then
		self:SetAttribute("type", Type)	
		local SimID=self.SimID
		if Type=="spell" then
			self:SetAttribute(Type, SimID)
		elseif Type=="item" then
			self:SetAttribute(Type, SimID)
		elseif Type=="macro" then
			self:SetAttribute(Type, SimID)
		elseif Type=="companion" then
			self:SetAttribute("type", "spell")	
			self:SetAttribute("spell", SimID)
		elseif Type=="mount" then
			if SimID==268435455 then
				self:SetAttribute("type", "macro")
				self:SetAttribute("macrotext", suijizuoqi)
			else
				self:SetAttribute("type", "spell")	
				self:SetAttribute("spell", SimID)
			end
		end
		self.icon:Show();
	else
		self.icon:Hide();
	end
end
addonTable.Update_Attribute=Update_Attribute
--更新Icon状态
local function Update_spell_Icon(SimID)
	local isTrue = SpellIsSelfBuff(SimID)
	if isTrue then
		if tocversion>90000 then
			local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal,spellId= GetPlayerAuraBySpellID(SimID)
			if spellId then
				if duration==0 then
					return 136116
				end
			end
		else
			for x=1,BUFF_MAX_DISPLAY do--有此状态
				local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal,spellId=UnitBuff("player",x,"PLAYER")
				if spellId then
					if spellId==SimID then
						if duration==0 then
							return 136116
						end
					end
				else
					break
				end
			end
		end
	end
	local icon = GetSpellTexture(SimID)
	return icon
end
addonTable.Update_spell_Icon=Update_spell_Icon
local function Update_Icon(self)
	local Type=self.Type
	if Type then
		local SimID=self.SimID
		if Type=="spell" then
			self.icon:SetTexture(Update_spell_Icon(SimID))
		elseif Type=="item" then
			local icon = GetItemIcon(SimID)
			self.icon:SetTexture(icon);
		elseif Type=="macro" then
			local name, icon = GetMacroInfo(SimID)
			self.icon:SetTexture(icon)
		elseif Type=="companion" then
			local spellId=self.SimID_3
			self.icon:SetTexture(GetSpellTexture(spellId))
		elseif Type=="mount" then
			local spellId=self.SimID_3
			self.icon:SetTexture(GetSpellTexture(spellId))
		end
		self.icon:Show();
	else
		self.icon:Hide();
	end
end
addonTable.Update_Icon=Update_Icon
local function Update_Cooldown(self)
	local Type=self.Type
	if Type then
		local SimID=self.SimID
		if Type=="spell" then
			local start, duration, enabled = GetSpellCooldown(SimID);
			if enabled==0 then
			else
				self.cooldown:SetCooldown(start, duration);
			end
		elseif Type=="item" then
			local ItemID = GetItemInfoInstant(SimID)
			local start, duration, enabled = GetItemCooldown(ItemID)
			if enabled==0 then
			else
				self.cooldown:SetCooldown(start, duration);
			end
		elseif Type=="macro" then
			local hongSpellID = GetMacroSpell(SimID)
			if hongSpellID then
				local start, duration, enabled = GetSpellCooldown(hongSpellID);
				if enabled==0 then
				else
					self.cooldown:SetCooldown(start, duration);
				end
			else
				local ItemName, ItemLink = GetMacroItem(SimID);
				if ItemName then
					local ItemID = GetItemInfoInstant(ItemLink)
					local start, duration, enabled = GetItemCooldown(ItemID);
					if enabled==0 then
					else
						self.cooldown:SetCooldown(start, duration);
					end
				end
			end
		end
	end
end
addonTable.Update_Cooldown=Update_Cooldown
local function Update_Count(self)
	local Type=self.Type
	if Type then
		self.Name:SetText();
		local SimID=self.SimID
		if Type=="spell" then
			local SPhuafei=IsConsumableSpell(SimID)
			if SPhuafei then
				local jiengncailiao = GetSpellCount(SimID)
				if jiengncailiao>0 then
		            self.Count:SetText(jiengncailiao)
		        else
		        	self.Count:SetText("|cffff0000"..jiengncailiao.."|r")
		        end
		    else
				self.Count:SetText()
		    end
		elseif Type=="item" then
			local _,dalei,xiaolei = GetItemInfoInstant(SimID)
			local Ccount = GetItemCount(SimID, false, true) or GetItemCount(SimID)
			if dalei=="消耗品" then
				if Ccount>0 then
					self.Count:SetText(Ccount);
				else
					self.Count:SetText("|cffff0000"..Ccount.."|r");
				end
			end
		elseif Type=="macro" then
			local name, icon, body, isLocal = GetMacroInfo(SimID)
			self.Name:SetText(name);
			local hongSpellID = GetMacroSpell(SimID)
			if hongSpellID then
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
			else
				local ItemName, ItemLink = GetMacroItem(SimID);
				if ItemName then
					local ItemID = GetItemInfoInstant(ItemLink)
					local Ccount = GetItemCount(ItemID, false, true) or GetItemCount(ItemID)
					local _,dalei,xiaolei = GetItemInfoInstant(ItemID)
					if dalei=="消耗品" then
						self.Name:SetText();
						if Ccount>0 then
							self.Count:SetText(Ccount);
						else
							self.Count:SetText("|cffff0000"..Ccount.."|r");
						end
					end
				end
			end
		end
	end
end
addonTable.Update_Count=Update_Count
local function Update_bukeyong(self)
	local Type=self.Type
	if Type then
		local SimID=self.SimID
		if Type=="spell" then
			if not IsPlayerSpell(SimID) then
				self.icon:SetVertexColor(0.5, 0.5, 0.5) 
				return 
			end
			local usable, noMana = IsUsableSpell(SimID)	
			if not usable then
				self.icon:SetVertexColor(0.5, 0.5, 0.5) 
				return 
			end
		elseif Type=="item" then
			local usable, noMana = IsUsableItem(SimID)
			if not usable then 
				self.icon:SetVertexColor(0.5, 0.5, 0.5);
				return
			end
		elseif Type=="macro" then
			local Name, Icon, Body = GetMacroInfo(SimID);
			local TrimBody = strtrim(Body or '');
			if TrimBody=="" then
				self.icon:SetVertexColor(0.5, 0.5, 0.5);
				return
			end
			local hongSpellID = GetMacroSpell(SimID)
			if hongSpellID then
				local usable, noMana = IsUsableSpell(hongSpellID)	
				if not usable then
					self.icon:SetVertexColor(0.5, 0.5, 0.5) 
					return 
				end
			else
				local ItemName, ItemLink = GetMacroItem(SimID);
				if ItemName then
					local usable, noMana = IsUsableItem(ItemName)
					if not usable then 
						self.icon:SetVertexColor(0.5, 0.5, 0.5);
						return
					end
				end
			end
		elseif Type=="companion" then
			local usable, noMana = IsUsableSpell(SimID)
			if not usable then
				self.icon:SetVertexColor(0.5, 0.5, 0.5) 
				return 
			end
		elseif Type=="mount" then
			local spellID=self.SimID_3
			if SimID==268435455 then
				local usable, noMana = IsUsableSpell(spellID)
				if not usable then
					self.icon:SetVertexColor(0.5, 0.5, 0.5) 
					return 
				end
			else	
				local mountID = C_MountJournal.GetMountFromSpell(spellID)
				local isUsable, useError = C_MountJournal.GetMountUsabilityByID(mountID, true)
				if not isUsable then
					self.icon:SetVertexColor(0.5, 0.5, 0.5) 
					return 
				end
			end
		end
		self.icon:SetVertexColor(1, 1, 1);
	end
end
addonTable.Update_bukeyong=Update_bukeyong
--更新使用状态
local function Update_State(self)
	local Type=self.Type
	if Type then
		local SimID=self.SimID
		if Type=="spell" then
			if IsCurrentSpell(SimID) then--进入队列
				self:SetChecked(true)
				return
			end
			self:SetChecked(false)
		elseif Type=="item" then
			if IsCurrentItem(SimID) then
				self:SetChecked(true)
				return
			end	
			self:SetChecked(false)
		elseif Type=="macro" then
			local hongSpellID = GetMacroSpell(SimID)
			if hongSpellID then
				if IsCurrentSpell(hongSpellID) then--进入队列
					self:SetChecked(true)
					return
				end
			else
				local ItemName, ItemLink = GetMacroItem(SimID);
				if ItemName then
					local ItemID = GetItemInfoInstant(ItemLink)
					if IsCurrentItem(ItemID) then
						self:SetChecked(true)
						return
					end
				end
			end
			self:SetChecked(false)
		elseif Type=="companion" then
			if IsCurrentSpell(SimID) then
				self:SetChecked(true)
				return
			end
			self:SetChecked(false)
		elseif Type=="mount" then
			if SimID==268435455 then
				local numMounts = C_MountJournal.GetNumMounts()
				for i=1,numMounts do
					local name, spellID= C_MountJournal.GetDisplayedMountInfo(i)
					if IsCurrentSpell(spellID) then
						self:SetChecked(true)
						return
					end
				end
				self:SetChecked(false)
			else
				local spellID=self.SimID_3
				if IsCurrentSpell(spellID) then
					self:SetChecked(true)
					return
				end
				self:SetChecked(false)
			end
		end	
	end
	self:SetChecked(false)
end
addonTable.Update_State=Update_State
local function Update_PostClick(self)
	local Type=self.Type
	if Type then
		local SimID=self.SimID
		if Type=="spell" then
			if not IsPlayerSpell(SimID) then self:SetChecked(false) end
			local usable, noMana = IsUsableSpell(SimID)	
			if not usable then self:SetChecked(false) end
		elseif Type=="item" then
			local usable, noMana = IsUsableItem(SimID)
			if not usable then self:SetChecked(false) end
		elseif Type=="macro" then
			local Name, Icon, Body = GetMacroInfo(SimID);
			local TrimBody = strtrim(Body or '');
			if TrimBody=="" then
				self:SetChecked(false)
			end
		elseif Type=="companion" then
			local usable, noMana = IsUsableSpell(SimID)	
			if not usable then self:SetChecked(false) end
		elseif Type=="mount" then
			local spellID=self.SimID_3
			local usable, noMana = IsUsableSpell(spellID)	
			if not usable then self:SetChecked(false) end
		end
	else
		self:SetChecked(false)
	end
end
addonTable.Update_PostClick=Update_PostClick
--初始加载
local function loadingButInfo(self,dataY)
	local butInfo = PIG_Per[dataY]['ActionInfo'][self.action]
	if butInfo then
		self.Type=butInfo[1]
		self.SimID=butInfo[2]
		self.SimID_3=butInfo[3]
		Update_Attribute(self)
		Update_Icon(self)
		Update_Cooldown(self)
		Update_Count(self)
		Update_bukeyong(self)
		Update_State(self)
	else
		if dataY=="QuickButton" then return end
		local Showvalue = GetCVarInfo("alwaysShowActionBars")
		if Showvalue=="0" then
			self:Hide()
		end
	end
end
addonTable.loadingButInfo=loadingButInfo
--鼠标悬浮
local function OnEnter_Spell(Type,SimID)
	if IsSpellKnown(SimID) then
		for i = 1, GetNumSpellTabs() do
			local _, _, offset, numSlots = GetSpellTabInfo(i)
			for j = offset+1, offset+numSlots do
				local _,bookspellID= GetSpellBookItemInfo(j, BOOKTYPE_SPELL)
				if SimID==bookspellID then
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
		for _, i in pairs{GetProfessions()} do
			local offset, numSlots = select(3, GetSpellTabInfo(i))
			for j = offset+1, offset+numSlots do
				local _, _ ,spellID=GetSpellBookItemName(j, BOOKTYPE_SPELL)
				if SimID==spellID then
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
		if C_MountJournal then
			local numMounts = C_MountJournal.GetNumMounts()
			for i=1,numMounts do
				local name, spellID= C_MountJournal.GetDisplayedMountInfo(i)
				if SimID==spellID then
					GameTooltip:SetHyperlink("spell:"..spellID)
					GameTooltip:Show();
					return
				end
			end
		elseif GetCompanionInfo then
			local count = GetNumCompanions("MOUNT")
			for i=1,count do
				local creatureID, creatureName, creatureSpellID, icon, issummoned, mountType = GetCompanionInfo("MOUNT", i)
				if SimID==creatureSpellID then
					GameTooltip:SetHyperlink("spell:"..creatureSpellID)
					GameTooltip:Show();
					return
				end
			end
		end

		GameTooltip:SetHyperlink(Type..":"..SimID)
		GameTooltip:Show();
	end
end
addonTable.OnEnter_Spell=OnEnter_Spell
local function OnEnter_Item(Type,SimID)
	for Bagid=0,4,1 do
		local numberOfSlots = GetContainerNumSlots(Bagid);
		for caowei=1,numberOfSlots,1 do
			if GetContainerItemLink(Bagid, caowei)==SimID then
				GameTooltip:SetBagItem(Bagid,caowei);
				GameTooltip:Show();
				return
			end
		end
	end
	GameTooltip:SetHyperlink(Type..":"..SimID)
	GameTooltip:Show();
end
addonTable.OnEnter_Item=OnEnter_Item
local function OnEnter_Companion(Type,SimID,spellID)
	GameTooltip:SetHyperlink("spell:"..spellID)
	GameTooltip:Show();
end
addonTable.OnEnter_Companion=OnEnter_Companion

---处理光标
local function Cursor_Loot(self,oldType,dataY)
	self.Type=nil
	PIG_Per[dataY]['ActionInfo'][self.action]=nil
	--self.icon:SetTexture();
	self.Count:SetText()
	self.Name:SetText()
	self.cooldown:Hide()
	if not InCombatLockdown() then
		local oldSimID= self.SimID
		if oldType=="spell" then
			PickupSpell(oldSimID)
		elseif oldType=="item" then
			PickupItem(oldSimID)
		elseif oldType=="macro" then
			PickupMacro(oldSimID)
		elseif oldType=="companion" then
			local count = GetNumCompanions("MOUNT")
			for i=1,count do
				local creatureID, creatureName, creatureSpellID, icon, issummoned, mountType = GetCompanionInfo("MOUNT", i)
				if creatureName==oldSimID then
					PickupCompanion("MOUNT",i)
					break
				end
			end
		elseif oldType=="mount" then
			if oldSimID==268435455 then
				C_MountJournal.Pickup(0)
			else
				local numMounts = C_MountJournal.GetNumMounts()
				for i=1,numMounts do
					local name, spellID= C_MountJournal.GetDisplayedMountInfo(i)
					if name==oldSimID then
						C_MountJournal.Pickup(i)
						break
					end
				end
			end
		end
	end
end
local function Cursor_FZ(self,NewType,canshu1,canshu2,canshu3,dataY)
	self.Type=NewType
	if NewType=="spell" then
		self.SimID=canshu3
		PIG_Per[dataY]['ActionInfo'][self.action]={NewType,canshu3}
	elseif NewType=="item" then
		self.SimID=canshu2
		PIG_Per[dataY]['ActionInfo'][self.action]={NewType,canshu2}
	elseif NewType=="macro" then
		self.SimID=canshu1
		local name, icon, body = GetMacroInfo(canshu1)
		PIG_Per[dataY]['ActionInfo'][self.action]={NewType,canshu1,name,body}
	elseif NewType=="companion" then
		local creatureID, creatureName, creatureSpellID, icon, issummoned, mountType = GetCompanionInfo(canshu2, canshu1)
		self.SimID=creatureName
		self.SimID_3=creatureSpellID
		PIG_Per[dataY]['ActionInfo'][self.action]={NewType,creatureName,creatureSpellID}
	elseif NewType=="mount" then
		if canshu1==268435455 then
			self.SimID=268435455
	    	self.SimID_3=150544
			PIG_Per[dataY]['ActionInfo'][self.action]={NewType,268435455,150544}
		else
			local name, spellID, icon, isActive, isUsable, sourceType, isFavorite, isFactionSpecific, faction, shouldHideOnChar, isCollected, mountID= C_MountJournal.GetMountInfoByID(canshu1)
	    	self.SimID=name
	    	self.SimID_3=spellID
			PIG_Per[dataY]['ActionInfo'][self.action]={NewType,name,spellID}
		end
	end
	if InCombatLockdown() then return end
	self:Show()
end
local function Cursor_Fun(self,Script,dataY)
	local oldType= self.Type
	local NewType, canshu1, canshu2, canshu3= GetCursorInfo()
	--print(NewType, canshu1, canshu2, canshu3)
	ClearCursor();
	if Script=="OnDragStart" then
		if oldType then
			Cursor_Loot(self,oldType,dataY)
		end
	end
	if Script=="OnReceiveDrag" then
		if oldType then
			Cursor_Loot(self,oldType,dataY)
		end
		if NewType then
			if NewType=="companion" then
				local creatureID, creatureName = GetCompanionInfo(canshu2, canshu1)
				self:SetAttribute("type", "spell")
				self:SetAttribute("spell", creatureName)
			elseif NewType=="mount" then
				if canshu1==268435455 then
					self:SetAttribute("type", "macro")
					self:SetAttribute("macrotext", suijizuoqi)
				else
					local name= C_MountJournal.GetMountInfoByID(canshu1)
					self:SetAttribute("type", "spell")
					self:SetAttribute("spell", name)
				end
			end
			Cursor_FZ(self,NewType,canshu1,canshu2,canshu3,dataY)
		end
	end
	if Script=="OnMouseUp" then
		if NewType then
			if InCombatLockdown() then return end
			self:Disable()
			if oldType then
				Cursor_Loot(self,oldType,dataY)
			end
			if NewType=="spell" then
				self:SetAttribute("type", NewType)
				self:SetAttribute(NewType, canshu3)
			elseif NewType=="item" then
				self:SetAttribute("type", NewType)
				self:SetAttribute(NewType, canshu2)
			elseif NewType=="macro" then
				self:SetAttribute("type", NewType)
				self:SetAttribute(NewType, canshu1)
			elseif NewType=="companion" then
				local creatureID, creatureName = GetCompanionInfo(canshu2, canshu1)
				self:SetAttribute("type", "spell")
				self:SetAttribute("spell", creatureName)
			elseif NewType=="mount" then
				if canshu1==268435455 then
					self:SetAttribute("type", "macro")
					self:SetAttribute("macrotext", suijizuoqi)
				else
					local name= C_MountJournal.GetMountInfoByID(canshu1)
					self:SetAttribute("type", "spell")
					self:SetAttribute("spell", name)
				end
			end
			Cursor_FZ(self,NewType,canshu1,canshu2,canshu3,dataY)
			self:Enable()
		end
	end
end
addonTable.Cursor_Fun=Cursor_Fun
---
local function IncBetween(Val, Low, High)
	return Val >= Low and Val <= High;
end
local function Update_Macro(self,PigMacroDeleted,PigMacroCount,dataY)
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED");
	 	return PigMacroDeleted,PigMacroCount 
	end
	local OldInfo =PIG_Per[dataY]['ActionInfo'][self.action]
	local OldIndex =OldInfo[2]
	local OldName =OldInfo[3]
	local OldBody = OldInfo[4]

	local TrimBody = strtrim(OldBody or '');--去除空格
	local AccMacros, CharMacros = GetNumMacros();
	local BodyIndex = 0;
	--未变
	local Name, Icon, Body = GetMacroInfo(OldIndex);
	if (TrimBody == strtrim(Body or '') and OldName == Name) then
		self.icon:SetTexture(Icon);
		return PigMacroDeleted,PigMacroCount
	end
	--删除重新定位
	if (IncBetween(OldIndex - 1, 1, AccMacros) or IncBetween(OldIndex - 1, MAX_ACCOUNT_MACROS + 1, MAX_ACCOUNT_MACROS + CharMacros)) then
		local Name, Icon, Body = GetMacroInfo(OldIndex - 1);
		if (TrimBody == strtrim(Body or '') and OldName == Name) then
			PIG_Per[dataY]['ActionInfo'][self.action][1]="macro"
			PIG_Per[dataY]['ActionInfo'][self.action][2]=OldIndex-1
			self.Type="macro"
			self.SimID=OldIndex-1
			self.icon:SetTexture(Icon);
			self.Name:SetText(Name);
			self:SetAttribute("macro", OldIndex-1);
			return PigMacroDeleted,PigMacroCount				
		end
	end
	--增加重新定位
	if (IncBetween(OldIndex + 1, 1, AccMacros) or IncBetween(OldIndex + 1, MAX_ACCOUNT_MACROS + 1, MAX_ACCOUNT_MACROS + CharMacros)) then
		local Name, Icon, Body = GetMacroInfo(OldIndex + 1);
		if (TrimBody == strtrim(Body or '') and OldName == Name) then
			PIG_Per[dataY]['ActionInfo'][self.action][1]="macro"
			PIG_Per[dataY]['ActionInfo'][self.action][2]=OldIndex+1
			self.Type="macro"
			self.SimID=OldIndex+1
			self.icon:SetTexture(Icon);
			self.Name:SetText(Name);
			self:SetAttribute("macro", OldIndex+1);
			return PigMacroDeleted,PigMacroCount
		end
	end
	--其他宏改名后搜索相同宏位置
	for i = 1, AccMacros do
		local Name, Icon, Body = GetMacroInfo(i);
		local Body = strtrim(Body or '');
		if (TrimBody == Body and OldName == Name) then
			PIG_Per[dataY]['ActionInfo'][self.action][1]="macro"
			PIG_Per[dataY]['ActionInfo'][self.action][2]=i
			self.Type="macro"
			self.SimID=i
			self.icon:SetTexture(Icon);	
			self.Name:SetText(Name);
			BodyIndex = i;
			self:SetAttribute("macro", i);
			return PigMacroDeleted,PigMacroCount
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
			PIG_Per[dataY]['ActionInfo'][self.action][1]="macro"
			PIG_Per[dataY]['ActionInfo'][self.action][2]=i
			self.Type="macro"
			self.SimID=i
			self.icon:SetTexture(Icon);	
			self.Name:SetText(Name);
			self:SetAttribute("macro", i);
			return PigMacroDeleted,PigMacroCount
		end
		if (TrimBody == Body and Body ~= nil and Body ~= "") then
			BodyIndex = i;
		end
	end
	--无删除未找到名称和内容均相同的
	if PigMacroDeleted==false then
		--有相同body
		if (BodyIndex ~= 0) then 
			PIG_Per[dataY]['ActionInfo'][self.action][2]=BodyIndex
			self.Type="macro"
			self.SimID=BodyIndex
			local Name, Icon, Body = GetMacroInfo(BodyIndex);
			PIG_Per[dataY]['ActionInfo'][self.action][3]=Name
			self.icon:SetTexture(Icon);	
			self.Name:SetText(Name);
			self:SetAttribute("macro", BodyIndex);
			return PigMacroDeleted,PigMacroCount
		end
		--有相同Name
		local Name, Icon, Body = GetMacroInfo(OldIndex);
		if (OldName == Name) then
			PIG_Per[dataY]['ActionInfo'][self.action][4]=Body
			self.icon:SetTexture(Icon);
			return PigMacroDeleted,PigMacroCount
		end
	end
	--有删除
	if PigMacroDeleted==true then
		PIG_Per[dataY]['ActionInfo'][self.action]=nil
		self.Type=nil
		self.icon:SetTexture();
		self.Count:SetText();
		self.Name:SetText();
		self.cooldown:Hide()
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
	return PigMacroDeleted,PigMacroCount
end
addonTable.Update_Macro=Update_Macro
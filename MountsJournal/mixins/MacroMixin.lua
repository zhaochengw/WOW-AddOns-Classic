local type, pairs, rawget, GetItemCount, GetUnitSpeed, IsFalling, InCombatLockdown, GetTime, C_Item, GetInventoryItemID, GetInventoryItemLink, EquipItemByName, IsMounted, IsSubmerged = type, pairs, rawget, GetItemCount, GetUnitSpeed, IsFalling, InCombatLockdown, GetTime, C_Item, GetInventoryItemID, GetInventoryItemLink, EquipItemByName, IsMounted, IsSubmerged
local macroFrame = CreateFrame("FRAME")


macroFrame:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)
macroFrame:RegisterEvent("PLAYER_LOGIN")


function macroFrame:PLAYER_LOGIN()
	self.PLAYER_LOGIN = nil
	self.mounts = MountsJournal
	self.config = self.mounts.config
	self.sFlags = self.mounts.sFlags
	self.macrosConfig = self.config.macrosConfig
	self.charMacrosConfig = self.mounts.charDB.macrosConfig
	self.class = select(2, UnitClass("player"))
	self.broomID = 37011
	self.itemName = setmetatable({}, {__index = function(self, itemID)
		if C_Item.DoesItemExistByID(itemID) then
			local item = Item:CreateFromItemID(itemID)
			if item:IsItemDataCached() then
				self[itemID] = item:GetItemName()
			else
				item:ContinueOnItemLoad(function()
					self[itemID] = item:GetItemName()
				end)
			end
			return rawget(self, itemID)
		end
	end})

	local function loadFunc(name, funcStr)
		local loadedFunc, err = loadstring(funcStr)
		if err then
			geterrorhandler()(err)
		else
			self[name] = loadedFunc()
		end
	end

	local classOptionMacro = ""
	local defMacro = ""

	if self.class == "PALADIN" then
		classOptionMacro = classOptionMacro..[[
			local GetShapeshiftForm, GetShapeshiftFormInfo = GetShapeshiftForm, GetShapeshiftFormInfo

			local function getAuraSpellID()
				local shapeshiftIndex = GetShapeshiftForm()
				if shapeshiftIndex > 0 then
					local _,_,_, spellID = GetShapeshiftFormInfo(shapeshiftIndex)
					return spellID
				end
			end
		]]
		defMacro = defMacro..[[
			local GetShapeshiftForm, GetShapeshiftFormInfo = GetShapeshiftForm, GetShapeshiftFormInfo

			local function getAuraSpellID()
				local shapeshiftIndex = GetShapeshiftForm()
				if shapeshiftIndex > 0 then
					local _,_,_, spellID = GetShapeshiftFormInfo(shapeshiftIndex)
					return spellID
				end
			end
		]]
	elseif self.class == "PRIEST" or self.class == "MAGE" then
		classOptionMacro = classOptionMacro..[[
			local IsFalling, GetTime = IsFalling, GetTime
		]]
	elseif self.class == "DRUID" then
		classOptionMacro = classOptionMacro..[[
			local GetShapeshiftForm, GetShapeshiftFormInfo, GetTime = GetShapeshiftForm, GetShapeshiftFormInfo, GetTime

			local function getFormSpellID()
				local shapeshiftIndex = GetShapeshiftForm()
				if shapeshiftIndex > 0 then
					local _,_,_, spellID = GetShapeshiftFormInfo(shapeshiftIndex)
					return spellID
				end
			end
		]]
		defMacro = defMacro..[[
			local GetShapeshiftFormID = GetShapeshiftFormID
		]]
	end

	classOptionMacro = classOptionMacro..[[
		return function(self)
	]]
	defMacro = defMacro..[[
		return function(self)
			local macro = "/stand"
	]]

	if self.class == "PALADIN" then
		classOptionMacro = classOptionMacro..[[
			if self.classConfig.useCrusaderAura then
				local spellID = getAuraSpellID()

				if spellID and spellID ~= 32223 then
					self.charMacrosConfig.lastAuraSpellID = spellID
				elseif self.sFlags.isMounted and spellID == 32223 then

					if self.classConfig.returnLastAura and self.charMacrosConfig.lastAuraSpellID then
						return self:addLine(self:getDismountMacro(), "/cast !"..self:getSpellName(self.charMacrosConfig.lastAuraSpellID))
					end

					self.charMacrosConfig.lastAuraSpellID = nil
				end
			end
		]]
		defMacro = defMacro..[[
			if self.classConfig.useCrusaderAura and getAuraSpellID() ~= 32223 then
				macro = self:addLine(macro, "/cast !"..self:getSpellName(32223))
			end
		]]
	elseif self.class == "PRIEST" then
		classOptionMacro = classOptionMacro..[[
			-- 1706 - Levitation
			if self.classConfig.useLevitation and not self.magicBroom and IsFalling() then
				if GetTime() - (self.lastUseClassSpellTime or 0) < .5 then return "" end
				local i = 1
				repeat
					local _,_,_,_,_,_,_,_,_, spellID = UnitBuff("player", i)
					if spellID == 1706 then
						return "/cancelaura "..self:getSpellName(1706)
					end
					i = i + 1
				until not spellID
				self.lastUseClassSpellTime = GetTime()
				return "/cast [@player]"..self:getSpellName(1706)
			end
		]]
	elseif self.class == "DEATHKNIGHT" then
		defMacro = defMacro..[[
			if self.classConfig.usePathOfFrost
			and (not self.classConfig.useOnlyInWaterWalkLocation or self.sFlags.waterWalk)
			and not self.sFlags.swimming
			and not self.sFlags.fly
			then
				macro = self:addLine(macro, "/cast "..self:getSpellName(3714)) -- Path of Frost
			end
		]]
	elseif self.class == "SHAMAN" then
		defMacro = defMacro..[[
			if self.classConfig.useWaterWalking
			and (not self.classConfig.useOnlyInWaterWalkLocation or self.sFlags.waterWalk)
			and not self.sFlags.swimming
			and not self.sFlags.fly
			then
				macro = self:addLine(macro, "/cast [@player]"..self:getSpellName(546)) -- Water Walking
			end
		]]
	elseif self.class == "MAGE" then
		classOptionMacro = classOptionMacro..[[
			-- 130 - Slow Fall
			if self.classConfig.useSlowFall and not self.magicBroom and IsFalling() then
				if GetTime() - (self.lastUseClassSpellTime or 0) < .5 then return "" end
				local i = 1
				repeat
					local _,_,_,_,_,_,_,_,_, spellID = UnitBuff("player", i)
					if spellID == 130 then
						return "/cancelaura "..self:getSpellName(130)
					end
					i = i + 1
				until not spellID
				self.lastUseClassSpellTime = GetTime()
				return "/cast [@player]"..self:getSpellName(130)
			end
		]]
	elseif self.class == "DRUID" then
		classOptionMacro = classOptionMacro..[[
			-- DRUID LAST FORM
			-- 768 - cat form
			-- 1066 - aquatic form
			-- 783 - travel form
			-- 33943 - flight form
			-- 40120 - swift flight from
			-- 24858 - moonkin form
			if self.classConfig.useLastDruidForm then
				local spellID = getFormSpellID()

				if self.charMacrosConfig.lastDruidFormSpellID
				and spellID ~= 24858
				and (self.sFlags.isMounted
					  or self.sFlags.inVehicle
					  or spellID == 783
					  or spellID == 1066
					  or spellID == 33943
					  or spellID == 40120
					  or self.sFlags.isIndoors and spellID == 768)
				then
					return self:addLine(self:getDismountMacro(), "/cancelform\n/cast "..self:getSpellName(self.charMacrosConfig.lastDruidFormSpellID))
				end

				if spellID and spellID ~= 783 and spellID ~= 1066 and spellID ~= 33943 and spellID ~= 40120 then
					self.charMacrosConfig.lastDruidFormSpellID = spellID
					self.lastDruidFormTime = GetTime()
				elseif not spellID and GetTime() - (self.lastDruidFormTime or 0) > 1 then
					self.charMacrosConfig.lastDruidFormSpellID = nil
				end
			end

			if self.classConfig.useTravelIfCantFly
			and self.macro
			and not self.sFlags.canUseFlying
			and not self.sFlags.isIndoors
			and not self.sFlags.isSubmerged
			and not self.sFlags.isMounted
			and not self.sFlags.inVehicle
			and (self.classConfig.useMacroAlways and not self.classConfig.useMacroOnlyCanFly
			     or not self.magicBroom and (GetUnitSpeed("player") > 0
			                                 or IsFalling()))
			then
				local spellID = getFormSpellID()
				if spellID ~= 783 and spellID ~= 33943 and spellID ~= 40120 then
					return self:addLine(self:getDismountMacro(), "/cancelform\n/cast "..self:getSpellName(783))
				end
			end
		]]
		defMacro = defMacro..[[
			if GetShapeshiftFormID() then
				macro = self:addLine(macro, "/cancelform")
			end
		]]
	end

	classOptionMacro = classOptionMacro..[[
		end
	]]
	defMacro = defMacro..[[
			if self.magicBroom then
				macro = self:addLine(macro, "/use "..self.itemName[self.broomID]) -- MAGIC BROOM
				self.lastUseTime = GetTime()
			else
				macro = self:addLine(macro, "/mount doNotSetFlags")
			end
			return macro
		end
	]]

	loadFunc("getClassOptionMacro", classOptionMacro)
	loadFunc("getDefMacro", defMacro)

	self:RegisterEvent("LEARNED_SPELL_IN_TAB")

	self:refresh()
	self:getClassMacro(self.class, function() self:refresh() end)
end


function macroFrame:setMacro()
	self.macro = nil
	if self.classConfig.macroEnable then
		self.macro = self.classConfig.macro or self:getClassMacro()
	end
end


function macroFrame:setCombatMacro()
	self.combatMacro = nil
	if self.classConfig.combatMacroEnable then
		self.combatMacro = self.classConfig.combatMacro or self:getClassMacro()
	end
end


function macroFrame:refresh()
	self.classConfig = self.charMacrosConfig.enable and self.charMacrosConfig or self.macrosConfig[self.class]
	self:setMacro()
	self:setCombatMacro()
end
macroFrame.LEARNED_SPELL_IN_TAB = macroFrame.refresh


function macroFrame:addLine(text, line)
	if text ~= nil and #text > 0 then
		return text.."\n"..line
	else
		return line
	end
end


do
	local spellCache = {}
	function macroFrame:getSpellName(spellID, cb)
		if spellCache[spellID] then
			return spellCache[spellID]
		else
			local name = GetSpellInfo(spellID)
			if C_Spell.IsSpellDataCached(spellID) then
				local subText = GetSpellSubtext(spellID)
				if #subText > 0 then
					name = name.."("..subText..")"
				end
				spellCache[spellID] = name
			elseif cb then
				Spell:CreateFromSpellID(spellID):ContinueOnSpellLoad(cb)
			end
			return name
		end
	end
end


function macroFrame:getDismountMacro()
	return self:addLine("/leavevehicle [vehicleui]", "/dismount [mounted]")
end


do
	local function getClassDefFunc(spellID)
		return function(self, ...)
			local spellName = self:getSpellName(spellID, ...)
			if spellName then
				return "/cast "..spellName
			end
		end
	end


	local classFunc = {
		HUNTER = getClassDefFunc(5118), -- Aspect of the Cheetah
		ROGUE = function(self, ...)
			local sprint
			if IsSpellKnown(11305) then
				sprint = self:getSpellName(11305, ...)
			elseif IsSpellKnown(8696) then
				sprint = self:getSpellName(8696, ...)
			else
				sprint = self:getSpellName(2983, ...)
			end

			if sprint then
				return "/cast "..sprint
			end
		end,
		SHAMAN = getClassDefFunc(2645), -- Ghost Wolf
		MAGE = getClassDefFunc(1953), -- Blink
		DRUID = function(self, ...)
			local aquaticForm = self:getSpellName(1066, ...)
			local catForm = self:getSpellName(768, ...)
			local travelForm = self:getSpellName(783, ...)
			local flightFrom = IsSpellKnown(40120) and self:getSpellName(40120, ...)
			                or IsSpellKnown(33943) and self:getSpellName(33943, ...)

			if aquaticForm and catForm and travelForm then
				return ("/cast [swimming]%s;[indoors]%s;[flyable]%s;%s"):format(aquaticForm, catForm, flightFrom or travelForm, travelForm)
			end
		end,
	}


	function macroFrame:getClassMacro(class, ...)
		local macro = self:getDismountMacro()

		local classFunc = classFunc[class or self.class]
		if type(classFunc) == "function" then
			local text = classFunc(self, ...)
			if type(text) == "string" and #text > 0 then
				macro = self:addLine(macro, text)
			end
		end

		return macro
	end
end


function macroFrame:getMacro()
	self.mounts:setFlags()

	-- MAGIC BROOM IS USABLE
	self.magicBroom = self.config.useMagicBroom
	                  and not self.sFlags.targetMount
	                  and GetItemCount(self.broomID) > 0
	                  and not self.sFlags.isIndoors
	                  and not self.sFlags.swimming
	                  and self.itemName[self.broomID]

	-- CLASS OPTIONS
	local macro = self:getClassOptionMacro()
	if macro then return macro end

	-- EXIT VEHICLE
	if self.sFlags.inVehicle then
		macro = "/leavevehicle"
	-- DISMOUNT
	elseif self.sFlags.isMounted then
		if not self.lastUseTime or GetTime() - self.lastUseTime > .5 then
			macro = "/dismount"
		end
	-- CLASSMACRO
	elseif self.macro and (self.class == "DRUID" and self.classConfig.useMacroAlways and (not self.classConfig.useMacroOnlyCanFly
	                                                                                      or self.sFlags.canUseFlying)
	                       or not self.magicBroom and (self.sFlags.isIndoors
	                       	                           or GetUnitSpeed("player") > 0
	                       	                           or IsFalling()))
	then
		macro = self.macro
	-- MOUNT
	else
		macro = self:getDefMacro()
	end

	return macro or ""
end


function macroFrame:getCombatMacro()
	local macro

	if self.combatMacro then
		macro = self:addLine(macro, self.combatMacro)
	elseif self.macro and self.class == "DRUID" and self.classConfig.useMacroAlways then
		macro = self:addLine(macro, self.macro)
	else
		macro = self:addLine(macro, "/mount")
	end

	return macro
end


function MountsJournalUtil.getClassMacro(...)
	return macroFrame:getClassMacro(...)
end


function MountsJournalUtil.refreshMacro()
	macroFrame:refresh()
end


MJMacroMixin = {}


function MJMacroMixin:onEvent(event, ...)
	self[event](self, ...)
end


function MJMacroMixin:onLoad()
	self.mounts = MountsJournal
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
end


function MJMacroMixin:preClick()
	self.mounts.sFlags.forceModifier = self.forceModifier
	if InCombatLockdown() then return end
	self:SetAttribute("macrotext", macroFrame:getMacro())
end


function MJMacroMixin:PLAYER_REGEN_DISABLED()
	self:SetAttribute("macrotext", macroFrame:getCombatMacro())
end
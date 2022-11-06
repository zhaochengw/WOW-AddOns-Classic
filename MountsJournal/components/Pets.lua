local GetNumCompanions, GetCompanionInfo, CallCompanion, random, InCombatLockdown, IsFlying, IsMounted, UnitHasVehicleUI, UnitChannelInfo, IsStealthed, UnitIsGhost, GetSpellCooldown = GetNumCompanions, GetCompanionInfo, CallCompanion, random, InCombatLockdown, IsFlying, IsMounted, UnitHasVehicleUI, UnitChannelInfo, IsStealthed, UnitIsGhost, GetSpellCooldown
local mounts, util = MountsJournal, MountsJournalUtil
local pets = CreateFrame("FRAME")
mounts.pets = pets


function pets:summon(petID)
	local petIndex = mounts.indexPetBySpellID[petID]
	if not petIndex then return end

	local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo("CRITTER", petIndex)
	if not isSummoned then CallCompanion("CRITTER", petIndex) end
end


function pets:summonRandomPet(isFavorite)
	local petIndex

	if isFavorite then
		local favoriteslist = {}
		for petSpellID in next, mounts.charDB.petFavoritesList do
			favoriteslist[#favoriteslist + 1] = mounts.indexPetBySpellID[petSpellID]
		end

		local num = #favoriteslist
		if num == 0 then return end

		if num > 1 then
			local rNum = random(num)
			petIndex = favoriteslist[rNum]
			local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo("CRITTER", petIndex)
			if isSummoned then
				rNum = rNum + 1
				if rNum > num then rNum = 1 end
				petIndex = favoriteslist[rNum]
			end
		else
			local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo("CRITTER", favoriteslist[1])
			if not isSummoned then petIndex = favoriteslist[1] end
		end
	else
		local num = GetNumCompanions("CRITTER")
		if num == 0 then return end

		if num > 1 then
			petIndex = random(num)
			local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo("CRITTER", petIndex)
			if isSummoned then
				petIndex = petIndex + 1
				if petIndex > num then petIndex = 1 end
			end
		else
			local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo("CRITTER", 1)
			if not isSummoned then petIndex = 1 end
		end
	end

	if petIndex then CallCompanion("CRITTER", petIndex) end
end


do
	local aurasList = {
		[3680] = true, -- Lesser Invisibility
		[11392] = true, -- Invisibility Potion
		[32612] = true, -- Invisibility
	}

	local function isAuraApplied()
		for i = 1, 255 do
			local _,_,_,_,_,_,_,_,_, spellID = UnitBuff("player", i)
			if not spellID then return end
			if aurasList[spellID] then return true end
		end
	end

	function pets:summonByTimer()
		local groupType = util.getGroupType()
		if mounts.config.noPetInRaid and groupType == "raid"
		or mounts.config.noPetInGroup and groupType == "group"
		then return end

		if InCombatLockdown() then
			self:stopTicker()
			self:UnregisterEvent("PLAYER_STARTED_MOVING")
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
		elseif IsFlying()
			or IsMounted()
			or UnitHasVehicleUI("player")
			or UnitChannelInfo("player")
			or IsStealthed()
			or UnitIsGhost("player")
			or GetSpellCooldown(61304) ~= 0
			or isAuraApplied()
		then
			self:stopTicker()
			self:UnregisterEvent("PLAYER_STARTED_MOVING")
			self:RegisterEvent("PLAYER_STARTED_MOVING")
		else
			self:UnregisterEvent("PLAYER_STARTED_MOVING")
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")
			self:summonRandomPet(mounts.config.summonPetOnlyFavorites)
			if not self.ticker then self:setSummonEvery() end
		end
	end
	pets:SetScript("OnEvent", pets.summonByTimer)
end


function pets:stopTicker()
	if self.ticker and not self.ticker:IsCancelled() then
		self.ticker:Cancel()
		self.ticker = nil
	end
end


function pets:setSummonEvery()
	if mounts.config.summonPetEvery then
		local timer = 60 * (tonumber(mounts.config.summonPetEveryN) or 1)
		if self.timer == timer and self.ticker then return end
		self.timer = timer
		self:stopTicker()
		self.ticker = C_Timer.NewTicker(timer, function() self:summonByTimer() end)
	else
		self:stopTicker()
	end
end


SLASH_MOUNTSJOURNALRANDOMPET1 = "/randompet"
SlashCmdList["MOUNTSJOURNALRANDOMPET"] = function() pets:summonRandomPet() end


SLASH_MOUNTSJOURNALRANDOMFAVORITEPET1 = "/randomfavoritepet"
SlashCmdList["MOUNTSJOURNALRANDOMFAVORITEPET"] = function() pets:summonRandomPet(true) end
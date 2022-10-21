local addon, L = ...
local C_Map, MapUtil, next, wipe, random, C_PetJournal, IsSpellKnown, GetTime, IsFlyableArea, IsSubmerged, GetInstanceInfo, IsIndoors, UnitInVehicle, IsMounted, InCombatLockdown, GetSpellCooldown, UnitBuff, GetCompanionInfo, CallCompanion, GetSubZoneText = C_Map, MapUtil, next, wipe, random, C_PetJournal, IsSpellKnown, GetTime, IsFlyableArea, IsSubmerged, GetInstanceInfo, IsIndoors, UnitInVehicle, IsMounted, InCombatLockdown, GetSpellCooldown, UnitBuff, GetCompanionInfo, CallCompanion, GetSubZoneText
local util = MountsJournalUtil
local mounts = CreateFrame("Frame", "MountsJournal")
util.setEventsMixin(mounts)


mounts:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
mounts:RegisterEvent("ADDON_LOADED")
mounts:RegisterEvent("PLAYER_LOGIN")
mounts:RegisterEvent("UPDATE_INVENTORY_DURABILITY")


function mounts:ADDON_LOADED(addonName)
	if addonName == addon then
		self:UnregisterEvent("ADDON_LOADED")

		local mapInfo = MapUtil.GetMapParentInfo(C_Map.GetFallbackWorldMapID(), Enum.UIMapType.Cosmic, true)
		self.defMountsListID = mapInfo and mapInfo.mapID or 946 -- WORLD

		MountsJournalDB = MountsJournalDB or {}
		self.globalDB = MountsJournalDB
		self.globalDB.mountTags = self.globalDB.mountTags or {}
		self.globalDB.filters = self.globalDB.filters or {}
		self.globalDB.defFilters = self.globalDB.defFilters or {}
		self.globalDB.config = self.globalDB.config or {}
		self.globalDB.mountFavoritesList = self.globalDB.mountFavoritesList or {}
		self.globalDB.mountAnimations = self.globalDB.mountAnimations or {}
		self.globalDB.defProfile = self.globalDB.defProfile or {}
		self.globalDB.mountsProfiles = self.globalDB.mountsProfiles or {}

		self.defProfile = self.globalDB.defProfile
		self:checkProfile(self.defProfile)
		self.profiles = self.globalDB.mountsProfiles
		for name, profile in next, self.profiles do
			self:checkProfile(profile)
		end
		self.filters = self.globalDB.filters
		self.defFilters = self.globalDB.defFilters
		self.mountFavoritesList = self.globalDB.mountFavoritesList
		self.config = self.globalDB.config
		if self.config.mountDescriptionToggle == nil then
			self.config.mountDescriptionToggle = true
		end
		if self.config.arrowButtonsBrowse == nil then
			self.config.arrowButtonsBrowse = true
		end
		if self.config.openHyperlinks == nil then
			self.config.openHyperlinks = true
		end
		self.config.useRepairMountsDurability = self.config.useRepairMountsDurability or 41
		self.config.useRepairFlyableDurability = self.config.useRepairFlyableDurability or 31
		self.config.macrosConfig = self.config.macrosConfig or {}
		for i = 1, GetNumClasses() do
			local _, className = GetClassInfo(i)
			if className then
				self.config.macrosConfig[className] = self.config.macrosConfig[className] or {}
			end
		end
		self.config.omb = self.config.omb or {}
		self.config.camera = self.config.camera or {}
		self.cameraConfig = self.config.camera
		if self.cameraConfig.xAccelerationEnabled == nil then
			self.cameraConfig.xAccelerationEnabled = true
		end
		self.cameraConfig.xInitialAcceleration = self.cameraConfig.xInitialAcceleration or .5
		self.cameraConfig.xAcceleration = self.cameraConfig.xAcceleration or -1
		self.cameraConfig.xMinAcceleration = nil
		self.cameraConfig.xMinSpeed = self.cameraConfig.xMinSpeed or 0
		if self.cameraConfig.yAccelerationEnabled == nil then
			self.cameraConfig.yAccelerationEnabled = true
		end
		self.cameraConfig.yInitialAcceleration = self.cameraConfig.yInitialAcceleration or .5
		self.cameraConfig.yAcceleration = self.cameraConfig.yAcceleration or -1
		self.cameraConfig.yMinAcceleration = nil
		self.cameraConfig.yMinSpeed = self.cameraConfig.yMinSpeed or 0

		MountsJournalChar = MountsJournalChar or {}
		self.charDB = MountsJournalChar
		self.charDB.macrosConfig = self.charDB.macrosConfig or {}
		self.charDB.profileBySpecializationPVP = self.charDB.profileBySpecializationPVP or {}
		self.charDB.petFavoritesList = self.charDB.petFavoritesList or {}

		-- Списки
		self.indexBySpellID = {}
		self.indexPetBySpellID = {}
		self.sFlags = {}
		self.repairMounts = {
			61425,
			61447,
		}
		self.usableRepairMounts = {}

		-- MINIMAP BUTTON
		local ldb_icon = LibStub("LibDataBroker-1.1"):NewDataObject(addon, {
			type = "launcher",
			text = addon,
			icon = 303868,
			OnClick = function(_, button)
				if button == "LeftButton" then
					MountsJournalFrame:showToggle()
				elseif button == "RightButton" then
					MountsJournalConfig:openConfig()
				end
			end,
			OnTooltipShow = function(tooltip)
				tooltip:SetText(("%s (|cffff7f3f%s|r)"):format(addon, GetAddOnMetadata(addon, "Version")))
				tooltip:AddLine("\n")
				tooltip:AddLine(L["|cffff7f3fClick|r to open %s"]:format(addon), .5, .8, .5, false)
				tooltip:AddLine(L["|cffff7f3fRight-Click|r to open Settings"], .5, .8, .5, false)
			end,
		})
		LibStub("LibDBIcon-1.0"):Register(addon, ldb_icon, mounts.config.omb)

		-- Dalaran - Krasus' Landing
		local locale = GetLocale()
		if locale == "deDE" then
			self.krasusLanding = "Krasus' Landeplatz"
		elseif locale == "esES" then
			self.krasusLanding = "Alto de Krasus"
		elseif locale == "esMX" then
			self.krasusLanding = "Alto de Kraus"
		elseif locale == "frFR" then
			self.krasusLanding = "Aire de Krasus"
		elseif locale == "itIT" then
			self.krasusLanding = "Terrazza di Krasus"
		elseif locale == "koKR" then
			self.krasusLanding = "크라서스 착륙장"
		elseif locale == "ptBR" then
			self.krasusLanding = "Plataforma de Krasus"
		elseif locale == "ruRU" then
			self.krasusLanding = "Площадка Краса"
		elseif locale == "zhCN" then
			self.krasusLanding = "克拉苏斯平台"
		elseif locale == "zhTW" then
			self.krasusLanding = "卡薩斯平臺"
		else
			self.krasusLanding = "Krasus' Landing"
		end

		-- TEMP
		-- for i, t in ipairs(self.mountsDB) do
		-- 	local spellID, creatureID, mType, sourceType, mountFaction, expansion = unpack(t)
		-- 	local name, _, icon = GetSpellInfo(spellID)
		-- 	if expansion <= 3 and not name or expansion > 3 and name then
		-- 		fprint(spellID, expansion, GetSpellInfo(spellID))
		-- 	end
		-- end
		-- local minItemID
		-- for itemID, spellID in pairs(self.itemIDToSpellID) do
		-- 	if not GetSpellInfo(spellID) then
		-- 		self.itemIDToSpellID[itemID] = nil
		-- 		if not minItemID or minItemID > itemID then minItemID = itemID end
		-- 	end
		-- end
		-- fprint("min", minItemID)
		-- for itemID, spellID in pairs(self.itemIDToSpellID) do
		-- 	if minItemID and itemID > minItemID then fprint(itemID) end
		-- end
	end
end


function mounts:checkProfile(profile)
	profile.fly = profile.fly or {}
	profile.ground = profile.ground or {}
	profile.swimming = profile.swimming or {}
	profile.zoneMounts = profile.zoneMounts or {}
	profile.petForMount = profile.petForMount or {}
	profile.mountsWeight = profile.mountsWeight or {}
end


function mounts:PLAYER_LOGIN()
	-- INIT
	self:setModifier(self.config.modifier)
	self:updateIndexBySpellID()
	self:updateIndexPetBySpellID()
	self:setUsableRepairMounts()
	self:updateProfessionsRank()
	self:init()

	-- MAP CHANGED
	-- self:RegisterEvent("NEW_WMO_CHUNK")
	-- self:RegisterEvent("ZONE_CHANGED")
	-- self:RegisterEvent("ZONE_CHANGED_INDOORS")
	-- self:RegisterEvent("ZONE_CHANGED_NEW_AREA")

	-- INSTANCE INFO UPDATE
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	-- PROFESSION CHANGED
	self:RegisterEvent("SKILL_LINES_CHANGED")

	-- MOUNT ADDED
	self:RegisterEvent("COMPANION_UPDATE")
	self:RegisterEvent("COMPANION_LEARNED")
	-- self:RegisterEvent("COMPANION_UNLEARNED")
end


do
	local durabilitySlots = {
		INVSLOT_HEAD,
		INVSLOT_SHOULDER,
		INVSLOT_CHEST,
		INVSLOT_WRIST,
		INVSLOT_HAND,
		INVSLOT_WAIST,
		INVSLOT_LEGS,
		INVSLOT_FEET,
		INVSLOT_MAINHAND,
		INVSLOT_OFFHAND,
		INVSLOT_RANGED,
	}
	function mounts:UPDATE_INVENTORY_DURABILITY()
		local percent = (tonumber(self.config.useRepairMountsDurability) or 0) / 100
		local flyablePercent = (tonumber(self.config.useRepairFlyableDurability) or 0) / 100
		self.sFlags.repair = false
		self.sFlags.flyableRepair = false
		if self.config.useRepairMounts then
			for i = 1, #durabilitySlots do
				local durCur, durMax = GetInventoryItemDurability(durabilitySlots[i])
				if durCur and durMax then
					local itemPercent = durCur / durMax
					if itemPercent < percent then
						self.sFlags.repair = true
					end
					if itemPercent < flyablePercent then
						self.sFlags.flyableRepair = true
					end
				end
			end
			if not self.config.useRepairFlyable then
				self.sFlags.flyableRepair = self.sFlags.repair
			end
		end
	end
end


function mounts:setUsableRepairMounts()
	local playerFaction = UnitFactionGroup("Player")

	wipe(self.usableRepairMounts)
	for i = 1, #self.repairMounts do
		local spellID = self.repairMounts[i]
		local faction = util.getMountInfoBySpellID(spellID)

		if faction == 1 and playerFaction == "Horde"
		or faction == 2 and playerFaction == "Alliance" then
			mounts.config.repairSelectedMount = spellID
		end

		if self.indexBySpellID[spellID] then
			self.usableRepairMounts[spellID] = true
		end
	end
end


function mounts:PLAYER_ENTERING_WORLD()
	local _, instanceType, _,_,_,_,_, instanceID = GetInstanceInfo()
	self.instanceID = instanceID
	local pvp = instanceType == "arena" or instanceType == "pvp"
	if self.pvp ~= pvp then
		self.pvp = pvp
		self:setDB()
	end
end


function mounts:summonPet(spellID)
	local petID = self.petForMount[spellID]
	if petID == nil or InCombatLockdown() then return end

	local groupType = util.getGroupType()
	if self.config.noPetInRaid and groupType == "raid"
	or self.config.noPetInGroup and groupType == "group" then
		return
	end

	if type(petID) == "number" then
		local petIndex = mounts.indexPetBySpellID[petID]
		if not petIndex then return end

		local creatureID, creatureName, creatureSpellID, icon, isSummoned = GetCompanionInfo("CRITTER", petIndex)
		if not isSummoned then CallCompanion("CRITTER", petIndex) end
	elseif petID then
		local num = GetNumCompanions("CRITTER")
		if num == 0 then return end
		local petIndex

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

		if petIndex then CallCompanion("CRITTER", petIndex) end
	else
		local favoriteslist = {}
		for petSpellID in next, self.charDB.petFavoritesList do
			favoriteslist[#favoriteslist + 1] = self.indexPetBySpellID[petSpellID]
		end

		local num = #favoriteslist
		if num == 0 then return end
		local petIndex

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

		if petIndex then CallCompanion("CRITTER", petIndex) end
	end
end


function mounts:updateIndexBySpellID()
	wipe(self.indexBySpellID)
	for i = 1, GetNumCompanions("MOUNT") do
		local _,_, spellID = GetCompanionInfo("MOUNT", i)
		self.indexBySpellID[spellID] = i
	end
end


function mounts:updateIndexPetBySpellID()
	wipe(self.indexPetBySpellID)
	for i = 1, GetNumCompanions("CRITTER") do
		local _,_, spellID = GetCompanionInfo("CRITTER", i)
		self.indexPetBySpellID[spellID] = i
	end
end


function mounts:COMPANION_LEARNED(companionType)
	if not companionType then
		if GetNumCompanions("MOUNT") ~= #self.indexBySpellID then
			local t = util:copyTable(self.indexBySpellID)
			self:updateIndexBySpellID()
			for spellID in pairs(self.indexBySpellID) do
				if not t[spellID] then
					self:autoAddNewMount(spellID)
					return
				end
			end
			self:event("MOUNT_LEARNED")
		end
		if GetNumCompanions("CRITTER") ~= #self.indexPetBySpellID then
			self:updateIndexPetBySpellID()
			self:event("CRITTER_LEARNED")
		end
	end
end
mounts.COMPANION_UPDATE = mounts.COMPANION_LEARNED


function mounts:updateProfessionsRank()
	local engineeringName = GetSpellInfo(4036)
	local tailoringName = GetSpellInfo(3908)

	for i = 1, GetNumSkillLines() do
		local skillName, _,_, skillRank = GetSkillLineInfo(i)
		if skillName == engineeringName then
			self.engineeringRank = skillRank
		elseif skillName == tailoringName then
			self.tailoringRank = skillRank
		end
	end
end
mounts.SKILL_LINES_CHANGED = mounts.updateProfessionsRank


do
	local bcInstaces = {
		[530] = true, -- Outland
		-- DUNGEONS
		[269] = true, -- The Black Morass
		[540] = true, -- The Shattered Halls
		[542] = true, -- The Blood Furnace
		[543] = true, -- Hellfire Ramparts
		[545] = true, -- The Steamvault
		[546] = true, -- The Underbog
		[547] = true, -- The Slave Pens
		[552] = true, -- The Arcatraz
		[553] = true, -- The Botanica
		[554] = true, -- The Mechanar
		[555] = true, -- Shadow Labyrinth
		[556] = true, -- Sethekk Halls
		[557] = true, -- Mana-Tombs
		[558] = true, -- Auchenai Crypts
		[560] = true, -- Old Hillsbrad Foothills
		[585] = true, -- Magisters' Terrace
		-- RAIDS
		[532] = true, -- Karazhan
		[534] = true, -- Hyjal Summit
		[544] = true, -- Magtheridon's Lair
		[548] = true, -- Serpentshrine Cavern
		[550] = true, -- Tempest Keep
		[564] = true, -- Black Temple
		[565] = true, -- Gruul's Lair
		[580] = true, -- Sunwell Plateau
	}

	local wotlkInstances = {
		[571] = true, -- Northrend
		-- DUNGEONS
		[574] = true, --Utgarde Keep
		[575] = true, --Utgarde Pinnacle
		[576] = true, --The Nexus
		[578] = true, --The Oculus
		[595] = true, --The Culling of Stratholme
		[599] = true, --Halls of Stone
		[600] = true, --Drak'Tharon Keep
		[601] = true, --Azjol-Nerub
		[602] = true, --Halls of Lightning
		[604] = true, --Gundrak
		[608] = true, --The Violet Hold
		[619] = true, --Ahn'kahet: The Old Kingdom
		[632] = true, --The Forge of Souls
		[650] = true, --Trial of the Champion
		[658] = true, --Pit of Saron
		[668] = true, --Halls of Reflection
		-- RAIDS
		[249] = true, -- Onyxia's Lair
		[533] = true, -- Naxxramas
		[603] = true, -- Ulduar
		[615] = true, -- The Obsidian Sanctum
		[616] = true, -- The Eye of Eternity
		[624] = true, -- Vault of Archavon
		[631] = true, -- Icecrown Citadel
		[649] = true, -- Trial of the Crusader
		[724] = true, -- The Ruby Sanctum
	}

	function mounts:isCanUseFlying(mapID)
		if bcInstaces[self.instanceID] then return true end
		if wotlkInstances[self.instanceID] and IsSpellKnown(54197) then
			if not mapID then mapID = MapUtil.GetDisplayableMapForPlayer() end
			if mapID ~= 126
			and (mapID ~= 125 or GetSubZoneText() == self.krasusLanding)
			then
				return true
			end
		end
		return false
	end
end


do
	local canUseMounts = {
		[48025] = true,
		[71342] = true,
		[72286] = true,
		[75614] = true,
		[372677] = true,
	}

	local mountsRequiringProf = {
		[44151] = {"engineeringRank", 375},
		[44153] = {"engineeringRank", 300},
		[61309] = {"tailoringRank", 425},
		[61451] = {"tailoringRank", 300},
		[75596] = {"tailoringRank", 425},
	}

	function mounts:isUsable(spellID, canUseFlying)
		if not self.indexBySpellID[spellID] then return false end

		local prof = mountsRequiringProf[spellID]
		if prof and (self[prof[1]] or 0) < prof[2] then return false end

		local faction, creatureID, mountType = util.getMountInfoBySpellID(spellID)
		if mountType ~= 1 or canUseFlying or canUseMounts[spellID] then return true end
		return false
	end
end


function mounts:addMountToList(list, spellID)
	local faction, creatureID, mountType = util.getMountInfoBySpellID(spellID)

	if mountType == 1 then
		mountType = "fly"
	elseif mountType == 2 then
		mountType = "ground"
	else
		mountType = "swimming"
	end

	list[mountType][spellID] = true
end


function mounts:autoAddNewMount(spellID)
	if self.defProfile.autoAddNewMount then
		self:addMountToList(self.defProfile, spellID)
	end

	for _, profile in next, self.profiles do
		if profile.autoAddNewMount then
			self:addMountToList(profile, spellID)
		end
	end
end


function mounts:setModifier(modifier)
	if modifier == "NONE" then
		self.config.modifier = modifier
		self.modifier = function() return false end
	elseif modifier == "SHIFT" then
		self.config.modifier = modifier
		self.modifier = IsShiftKeyDown
	elseif modifier == "CTRL" then
		self.config.modifier = modifier
		self.modifier = IsControlKeyDown
	else
		self.config.modifier = "ALT"
		self.modifier = IsAltKeyDown
	end
end


function mounts:setMountsList()
	local mapInfo = self.mapInfo
	local zoneMounts = self.zoneMounts
	self.mapFlags = nil
	self.list = nil

	while mapInfo and mapInfo.mapID ~= self.defMountsListID do
		local list = zoneMounts[mapInfo.mapID]
		if list then
			if not self.mapFlags and list.flags.enableFlags then
				self.mapFlags = list.flags
			end
			if not self.list then
				while list and list.listFromID do
					if list.listFromID == self.defMountsListID then
						list = self.db
					else
						list = zoneMounts[list.listFromID]
					end
				end
				if list and (next(list.fly) or next(list.ground) or next(list.swimming)) then
					self.list = list
				end
			end
			if self.list and self.mapFlags then return end
		end
		mapInfo = C_Map.GetMapInfo(mapInfo.parentMapID)
	end
	if not self.list then
		self.list = self.db
	end
end
-- mounts.NEW_WMO_CHUNK = mounts.setMountsList
-- mounts.ZONE_CHANGED = mounts.setMountsList
-- mounts.ZONE_CHANGED_INDOORS = mounts.setMountsList
-- mounts.ZONE_CHANGED_NEW_AREA = mounts.setMountsList


function mounts:setDB()
	profileName = self.charDB.profileBySpecializationPVP[1]
	if profileName and not self.profiles[profileName] then
		self.charDB.profileBySpecializationPVP[1] = nil
	end

	if self.charDB.currentProfileName and not self.profiles[self.charDB.currentProfileName] then
		self.charDB.currentProfileName = nil
	end

	local currentProfileName
	if self.pvp and self.charDB.profileBySpecializationPVP.enable then
		currentProfileName = self.charDB.profileBySpecializationPVP[1]
	else
		currentProfileName = self.charDB.currentProfileName
	end

	self.db = currentProfileName and self.profiles[currentProfileName] or self.defProfile
	self.zoneMounts = self.db.zoneMountsFromProfile and self.defProfile.zoneMounts or self.db.zoneMounts
	self.petForMount = self.db.petListFromProfile and self.defProfile.petForMount or self.db.petForMount
	self.mountsWeight = self.db.mountsWeight

	-- self:setMountsList()
end
mounts.PLAYER_SPECIALIZATION_CHANGED = mounts.setDB


function mounts:summonTarget()
	if self.config.copyMountTarget then
		local i = 1
		repeat
			local _,_,_,_,_,_,_,_,_, spellID = UnitBuff("target", i)
			if spellID then
				local index = self.indexBySpellID[spellID]
				if index then
					if self:isUsable(spellID, self.sFlags.canUseFlying) then
						self:summonPet(spellID)
						CallCompanion("MOUNT", index)
						return true
					end
					break
				end
				i = i + 1
			end
		until not spellID
	end
end


do
	local usableIDs = {}
	function mounts:summon(ids)
		local weight, canUseFlying = 0, self.sFlags.canUseFlying
		for spellID in next, ids do
			if self:isUsable(spellID, canUseFlying) then
				weight = weight + (self.mountsWeight[spellID] or 100)
				usableIDs[weight] = spellID
			end
		end
		if weight > 0 then
			for i = random(weight), weight do
				if usableIDs[i] then
					local spellID = usableIDs[i]
					self:summonPet(spellID)
					CallCompanion("MOUNT", self.indexBySpellID[spellID])
					break
				end
			end
			wipe(usableIDs)
			return true
		else
			return false
		end
	end
end


function mounts:isWaterWalkLocation()
	return self.mapFlags and self.mapFlags.waterWalkOnly or false
end


function mounts:setFlags()
	self.mapInfo = C_Map.GetMapInfo(MapUtil.GetDisplayableMapForPlayer())
	local flags = self.sFlags
	local modifier = self.modifier() or flags.forceModifier
	local isFlyableLocation = IsFlyableArea()
	                          and not (self.mapFlags and self.mapFlags.groundOnly)

	flags.isSubmerged = IsSubmerged()
	flags.isIndoors = IsIndoors()
	flags.inVehicle = UnitInVehicle("player")
	flags.isMounted = IsMounted()
	flags.swimming = flags.isSubmerged
	                 and not modifier
	flags.canUseFlying = self:isCanUseFlying(self.mapInfo.mapID)
	flags.fly = isFlyableLocation
	            and flags.canUseFlying
	            and (not modifier or flags.isSubmerged)
	flags.waterWalk = not isFlyableLocation and modifier
	                  or self:isWaterWalkLocation()
end


function mounts:errorSummon()
	UIErrorsFrame:AddMessage(InCombatLockdown() and SPELL_FAILED_AFFECTING_COMBAT or ERR_MOUNT_NO_FAVORITES, 1, .1, .1, 1)
end


function mounts:init()
	SLASH_MOUNTSJOURNAL1 = "/mount"
	SlashCmdList["MOUNTSJOURNAL"] = function(msg)
		local flags = self.sFlags
		if msg ~= "doNotSetFlags" then
			flags.forceModifier = nil
			self:setFlags()
		end
		self:setMountsList()
		if flags.inVehicle then
			VehicleExit()
		elseif flags.isMounted then
			Dismount()
		-- repair mounts
		elseif not ((flags.repair and not flags.fly or flags.flyableRepair and flags.fly) and self:summon(self.usableRepairMounts))
		-- target's mount
		and not self:summonTarget()
		-- swimming
		and not (flags.swimming and self:summon(self.list.swimming))
		-- fly
		and not (flags.fly and self:summon(self.list.fly))
		-- ground
		and not self:summon(self.list.ground)
		and not self:summon(self.list.fly)
		then
			self:errorSummon()
		end
	end
end
--@curseforge-project-slug: libspecialization@
if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then return end

local LS, oldminor = LibStub:NewLibrary("LibSpecialization", 8)
if not LS then return end -- No upgrade needed

LS.callbackMap = LS.callbackMap or {}
LS.frame = LS.frame or CreateFrame("Frame")

-- Positions of roles
local positionTable = {
	-- Death Knight
	[250] = "MELEE", -- Blood (Tank)
	[251] = "MELEE", -- Frost (DPS)
	[252] = "MELEE", -- Unholy (DPS)
	-- Demon Hunter
	[577] = "MELEE", -- Havoc (DPS)
	[581] = "MELEE", -- Vengeance (Tank)
	-- Druid
	[102] = "RANGED", -- Balance (DPS Owl)
	[103] = "MELEE", -- Feral (DPS Cat)
	[104] = "MELEE", -- Guardian (Tank Bear)
	[105] = "RANGED", -- Restoration (Heal)
	-- Evoker
	[1467] = "RANGED", -- Devastation (DPS)
	[1468] = "RANGED", -- Preservation (Heal)
	[1473] = "RANGED", -- Augmentation (DPS)
	-- Hunter
	[253] = "RANGED", -- Beast Mastery
	[254] = "RANGED", -- Marksmanship
	[255] = "MELEE", -- Survival
	-- Mage
	[62] = "RANGED", -- Arcane
	[63] = "RANGED", -- Fire
	[64] = "RANGED", -- Frost
	-- Monk
	[268] = "MELEE", -- Brewmaster (Tank)
	[269] = "MELEE", -- Windwalker (DPS)
	[270] = "MELEE", -- Mistweaver (Heal)
	-- Paladin
	[65] = "MELEE", -- Holy (Heal)
	[66] = "MELEE", -- Protection (Tank)
	[70] = "MELEE", -- Retribution (DPS)
	-- Priest
	[256] = "RANGED", -- Discipline (Heal)
	[257] = "RANGED", -- Holy (Heal)
	[258] = "RANGED", -- Shadow (DPS)
	-- Rogue
	[259] = "MELEE", -- Assassination
	[260] = "MELEE", -- Outlaw
	[261] = "MELEE", -- Subtlety
	-- Shaman
	[262] = "RANGED", -- Elemental (DPS)
	[263] = "MELEE", -- Enhancement (DPS)
	[264] = "RANGED", -- Restoration (Heal)
	-- Warlock
	[265] = "RANGED", -- Affliction
	[266] = "RANGED", -- Demonology
	[267] = "RANGED", -- Destruction
	-- Warrior
	[71] = "MELEE", -- Arms (DPS)
	[72] = "MELEE", -- Fury (DPS)
	[73] = "MELEE", -- Protection (Tank)
}
-- Player roles
local roleTable = {
	-- Death Knight
	[250] = "TANK", -- Blood (Tank)
	[251] = "DAMAGER", -- Frost (DPS)
	[252] = "DAMAGER", -- Unholy (DPS)
	-- Demon Hunter
	[577] = "DAMAGER", -- Havoc (DPS)
	[581] = "TANK", -- Vengeance (Tank)
	-- Druid
	[102] = "DAMAGER", -- Balance (DPS Owl)
	[103] = "DAMAGER", -- Feral (DPS Cat)
	[104] = "TANK", -- Guardian (Tank Bear)
	[105] = "HEALER", -- Restoration (Heal)
	-- Evoker
	[1467] = "DAMAGER", -- Devastation (DPS)
	[1468] = "HEALER", -- Preservation (Heal)
	[1473] = "DAMAGER", -- Augmentation (DPS)
	-- Hunter
	[253] = "DAMAGER", -- Beast Mastery
	[254] = "DAMAGER", -- Marksmanship
	[255] = "DAMAGER", -- Survival
	-- Mage
	[62] = "DAMAGER", -- Arcane
	[63] = "DAMAGER", -- Fire
	[64] = "DAMAGER", -- Frost
	-- Monk
	[268] = "TANK", -- Brewmaster (Tank)
	[269] = "DAMAGER", -- Windwalker (DPS)
	[270] = "HEALER", -- Mistweaver (Heal)
	-- Paladin
	[65] = "HEALER", -- Holy (Heal)
	[66] = "TANK", -- Protection (Tank)
	[70] = "DAMAGER", -- Retribution (DPS)
	-- Priest
	[256] = "HEALER", -- Discipline (Heal)
	[257] = "HEALER", -- Holy (Heal)
	[258] = "DAMAGER", -- Shadow (DPS)
	-- Rogue
	[259] = "DAMAGER", -- Assassination
	[260] = "DAMAGER", -- Outlaw
	[261] = "DAMAGER", -- Subtlety
	-- Shaman
	[262] = "DAMAGER", -- Elemental (DPS)
	[263] = "DAMAGER", -- Enhancement (DPS)
	[264] = "HEALER", -- Restoration (Heal)
	-- Warlock
	[265] = "DAMAGER", -- Affliction
	[266] = "DAMAGER", -- Demonology
	[267] = "DAMAGER", -- Destruction
	-- Warrior
	[71] = "DAMAGER", -- Arms (DPS)
	[72] = "DAMAGER", -- Fury (DPS)
	[73] = "TANK", -- Protection (Tank)
}
-- Starter specs
local starterSpecs = {
	[1444] = true, -- Shaman
	[1446] = true, -- Warrior
	[1447] = true, -- Druid
	[1448] = true, -- Hunter
	[1449] = true, -- Mage
	[1450] = true, -- Monk
	[1451] = true, -- Paladin
	[1452] = true, -- Priest
	[1453] = true, -- Rogue
	[1454] = true, -- Warlock
	[1455] = true, -- Death Knight
	[1456] = true, -- Demon Hunter
	[1465] = true, -- Evoker
}

local callbackMap = LS.callbackMap
local frame = LS.frame

local next, type, error, tonumber, format, strsplit = next, type, error, tonumber, string.format, string.split
local Ambiguate, GetTime, IsInGroup = Ambiguate, GetTime, IsInGroup
local GetSpecialization, GetSpecializationInfo = GetSpecialization, GetSpecializationInfo
local C_ClassTalents_GetActiveConfigID, C_Traits_GenerateImportString = C_ClassTalents.GetActiveConfigID, C_Traits.GenerateImportString
local SendAddonMessage, CTimerAfter = C_ChatInfo.SendAddonMessage, C_Timer.After
local pName = UnitName("player")

if not C_ChatInfo.RegisterAddonMessagePrefix("LibSpec") then
	error("LibSpecialization: Failed to register the addon prefix.")
end

do
	local approved = {
		["RAID"] = true,
		["PARTY"] = true,
		["INSTANCE_CHAT"] = true,
	}
	local talentChangeThrottle, currentSpecId, currentTalentString = 0, 0, nil
	local timerInstance, timerGroup = false, false
	local function SendToInstance()
		timerInstance = false
		if IsInGroup(2) then
			SendAddonMessage("LibSpec", format("%d,%s", currentSpecId, currentTalentString), "INSTANCE_CHAT")
		end
	end
	local function SendToGroup()
		timerGroup = false
		if IsInGroup(1) then
			SendAddonMessage("LibSpec", format("%d,%s", currentSpecId, currentTalentString), "RAID") -- RAID auto downgrades to PARTY as needed
		end
	end
	frame:SetScript("OnEvent", function(_, event, prefix, msg, channel, sender)
		if event == "CHAT_MSG_ADDON" then
			if prefix == "LibSpec" and approved[channel] then -- Only approved channels
				if msg == "R" then
					if channel == "INSTANCE_CHAT" then
						local specId, _, _, talentString = LS:MySpecialization()
						if specId then
							currentSpecId = specId
							currentTalentString = talentString
							if not timerInstance then
								timerInstance = true
								CTimerAfter(3, SendToInstance)
							end
						end
					else -- RAID/PARTY
						local specId, _, _, talentString = LS:MySpecialization()
						if specId then
							currentSpecId = specId
							currentTalentString = talentString
							if not timerGroup then
								timerGroup = true
								CTimerAfter(3, SendToGroup)
							end
						end
					end
					return
				end

				if msg:find(",", nil, true) then
					local spec, talentString = strsplit(",", msg)
					local specId = tonumber(spec)
					local role, position = roleTable[specId], positionTable[specId]
					if role and position then
						for _,func in next, callbackMap do
							func(specId, role, position, Ambiguate(sender, "none"), #talentString > 1 and talentString)
						end
					end
				else
					local specId = tonumber(msg)
					local role, position = roleTable[specId], positionTable[specId]
					if role and position then
						for _,func in next, callbackMap do
							func(specId, role, position, Ambiguate(sender, "none"))
						end
					end
				end
			end
		elseif event == "GROUP_FORMED" then -- Join new group
			LS:RequestSpecialization()
		elseif event == "ACTIVE_COMBAT_CONFIG_CHANGED" or event == "TRAIT_CONFIG_UPDATED" then
			if prefix == C_ClassTalents_GetActiveConfigID() then
				local t = GetTime()
				if t - talentChangeThrottle > 2 then -- Safety throttle
					talentChangeThrottle = t
					local specId, role, position, talentString = LS:MySpecialization()
					if specId then
						currentSpecId = specId -- Update this just in case a timer is queued
						if IsInGroup() then
							if IsInGroup(2) then -- Instance group
								SendAddonMessage("LibSpec", format("%d,%s", specId, talentString), "INSTANCE_CHAT")
							end
							if IsInGroup(1) then -- Normal group
								SendAddonMessage("LibSpec", format("%d,%s", specId, talentString), "RAID")
							end
						else
							for _,func in next, callbackMap do
								func(specId, role, position, pName, talentString) -- This allows us to show our own spec info when not grouped
							end
						end
					end
				end
			end
		elseif event == "PLAYER_LOGIN" then
			LS:RequestSpecialization()
		end
	end)
	frame:RegisterEvent("CHAT_MSG_ADDON")
	frame:RegisterEvent("GROUP_FORMED")
	frame:RegisterEvent("ACTIVE_COMBAT_CONFIG_CHANGED")
	frame:RegisterEvent("TRAIT_CONFIG_UPDATED")
	frame:RegisterEvent("PLAYER_LOGIN")
end

-- Allow requesting only your specialization
function LS:MySpecialization()
	local spec = GetSpecialization()
	if type(spec) == "number" and spec > 0 then
		local specId, _, _, _, role = GetSpecializationInfo(spec)

		if specId and role then
			local position = positionTable[specId]
			if position then
				local activeConfigID = C_ClassTalents_GetActiveConfigID()
				if activeConfigID then
					local talentString = C_Traits_GenerateImportString(activeConfigID)
					return specId, role, position, talentString
				end
				return specId, role, position
			elseif not starterSpecs[specId] then
				error(format("LibSpecialization: Unknown specId %q", specId))
			end
		end
	end
end

do
	local prev = 0
	local timer = false
	function LS:RequestSpecialization()
		local specId, role, position, talentString = LS:MySpecialization()
		if specId then
			for _,func in next, callbackMap do
				func(specId, role, position, pName, talentString) -- This allows us to show our own spec info when not grouped
			end
		end

		if IsInGroup() then
			local t = GetTime()
			if t-prev > 3 then
				timer = false
				prev = t
				if IsInGroup(2) then
					SendAddonMessage("LibSpec", "R", "INSTANCE_CHAT")
				end
				if IsInGroup(1) then
					SendAddonMessage("LibSpec", "R", "RAID")
				end
			elseif not timer then
				timer = true
				CTimerAfter(3.1-(t-prev), LS.RequestSpecialization)
			end
		end
	end
end

if IsLoggedIn() and not oldminor then -- Player is logged in and library isn't upgrading
	LS:RequestSpecialization()
end

function LS:Register(addon, func)
	if not addon or addon == LS then
		error("LibSpecialization: You must pass your own addon name or object to :Register.")
	end

	local t = type(func)
	if t == "string" then
		callbackMap[addon] = function(...) addon[func](addon, ...) end
	elseif t == "function" then
		callbackMap[addon] = func
	else
		error("LibSpecialization: Incorrect function type for :Register.")
	end
end

function LS:Unregister(addon)
	if not addon or addon == LS then
		error("LibSpecialization: You must pass your own addon name or object to :Unregister.")
	end
	callbackMap[addon] = nil
end

PallyPower = LibStub("AceAddon-3.0"):NewAddon("PallyPower", "AceConsole-3.0", "AceEvent-3.0", "AceBucket-3.0", "AceTimer-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("PallyPower")
local LSM3 = LibStub("LibSharedMedia-3.0")
local AceGUI = LibStub("AceGUI-3.0")
local LUIDDM = LibStub("LibUIDropDownMenu-4.0")

PallyPower.isBCC = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC
local LCD = not PallyPower.isBCC  and LibStub("LibClassicDurations", true)

local tinsert = table.insert
local tremove = table.remove
local twipe = table.wipe
local tsort = table.sort
local strfind = string.find
local strsub = string.sub
local format = string.format

local WisdomPallys, MightPallys, KingsPallys, SalvPallys, LightPallys, SancPallys = {}, {}, {}, {}, {}, {}
local classlist, classes = {}, {}

PallyPower.player = UnitName("player")
PallyPower.realm = GetRealmName()

PallyPower_Assignments = {}
PallyPower_NormalAssignments = {}
PallyPower_AuraAssignments = {}

AllPallys = {}
SyncList = {}
PP_DebugEnabled = false

local initialized = false
local isPally = false

PP_Symbols = 0
PP_Leader = false
PP_LeaderSalv = false

-- unit tables
local party_units = {}
local raid_units = {}
local leaders = {}
local roster = {}
local raidmaintanks = {}
local classmaintanks = {}
local raidmainassists = {}

local lastMsg = ""
local prevBuffDuration

do
	table.insert(party_units, "player")
	table.insert(party_units, "pet")

	for i = 1, MAX_PARTY_MEMBERS do
		table.insert(party_units, ("party%d"):format(i))
		table.insert(party_units, ("partypet%d"):format(i))
	end

	for i = 1, MAX_RAID_MEMBERS do
		table.insert(raid_units, ("raid%d"):format(i))
		table.insert(raid_units, ("raidpet%d"):format(i))
	end
end

PallyPower.Credits1 = "PallyPower - by Aznamir (Lightbringer US)"
PallyPower.Credits2 = "Updated for Classic by Dyaxler and Es"

function PallyPower:Debug(string)
	if not string then
		string = "(nil)"
	end
	if (PP_DebugEnabled) then
		DEFAULT_CHAT_FRAME:AddMessage("[PP] " .. string, 1, 0, 0)
	end
end

-------------------------------------------------------------------
-- Ace Framework Events
-------------------------------------------------------------------
function PallyPower:OnInitialize()
	if select(2, UnitClass("player")) == "PALADIN" then
		self.db = LibStub("AceDB-3.0"):New("PallyPowerDB", PALLYPOWER_DEFAULT_VALUES, "Default")
	else
		self.db = LibStub("AceDB-3.0"):New("PallyPowerDB", PALLYPOWER_OTHER_VALUES, "Other")
		self.db:SetProfile("Other")
	end

	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")

	self.opt = self.db.profile
	self.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

	LibStub("AceConfig-3.0"):RegisterOptionsTable("PallyPower", self.options, {"pp", "pallypower"})
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PallyPower", "PallyPower")

	LSM3:Register("background", "None", "Interface\\Tooltips\\UI-Tooltip-Background")
	LSM3:Register("background", "Banto", "Interface\\AddOns\\PallyPower\\Skins\\Banto")
	LSM3:Register("background", "BantoBarReverse", "Interface\\AddOns\\PallyPower\\Skins\\BantoBarReverse")
	LSM3:Register("background", "Glaze", "Interface\\AddOns\\PallyPower\\Skins\\Glaze")
	LSM3:Register("background", "Gloss", "Interface\\AddOns\\PallyPower\\Skins\\Gloss")
	LSM3:Register("background", "Healbot", "Interface\\AddOns\\PallyPower\\Skins\\Healbot")
	LSM3:Register("background", "oCB", "Interface\\AddOns\\PallyPower\\Skins\\oCB")
	LSM3:Register("background", "Smooth", "Interface\\AddOns\\PallyPower\\Skins\\Smooth")

	self.zone = GetRealZoneText()

	self:ScanInventory()
	self:CreateLayout()

	if self.opt.skin then
		self:ApplySkin(self.opt.skin)
	end

	self.AutoBuffedList = {}
	self.PreviousAutoBuffedUnit = nil
	self.menuFrame = LUIDDM:Create_UIDropDownMenu("PallyPowerMenuFrame", UIParent)

	if not PallyPowerConfigFrame then
		local ConfigFrame = AceGUI:Create("Frame")
		ConfigFrame:EnableResize(false)
		LibStub("AceConfigDialog-3.0"):SetDefaultSize("PallyPower", 625, 580)
		LibStub("AceConfigDialog-3.0"):Open("PallyPower", ConfigFrame)
		ConfigFrame:Hide()
		_G["PallyPowerConfigFrame"] = ConfigFrame.frame
		table.insert(UISpecialFrames, "PallyPowerConfigFrame")
	end

	self.MinimapIcon = LibStub("LibDBIcon-1.0")
	self.LDB =
		LibStub("LibDataBroker-1.1"):NewDataObject(
		"PallyPower",
		{
			["type"] = "data source",
			["text"] = "PallyPower",
			["icon"] = "Interface\\AddOns\\PallyPower\\Icons\\SummonChampion",
			["OnTooltipShow"] = function(tooltip)
				if self.opt.ShowTooltips then
					tooltip:SetText(L["PP_NAME"] .. " (" .. string.trim(GetAddOnMetadata("PallyPower", "Version")) .. ")")
					tooltip:AddLine(L["MINIMAPICON"])
					tooltip:Show()
				end
			end,
			["OnClick"] = function(_, button)
				if (button == "LeftButton") then
					PallyPowerBlessings_Toggle()
				else
					self:OpenConfigWindow()
				end
			end
		}
	)
	self.MinimapIcon:Register("PallyPower", self.LDB, self.opt.minimap)
	C_Timer.After(
		2.0,
		function()
			PallyPowerMinimapIcon_Toggle()
		end
	)

	if not self.isBCC then
		LCD:Register("PallyPower")
	end
end

function PallyPower:OnEnable()
	isPally = select(2, UnitClass("player")) == "PALADIN"

	self.opt.enable = true
	self:ScanSpells()
	self:ScanCooldowns()
	self:RegisterEvent("CHAT_MSG_ADDON")
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("ZONE_CHANGED")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("GROUP_JOINED")
	self:RegisterEvent("GROUP_LEFT")
	self:RegisterEvent("PLAYER_ROLES_ASSIGNED")
	self:RegisterEvent("UPDATE_BINDINGS", "BindKeys")
	self:RegisterEvent("CHANNEL_UI_UPDATE", "ReportChannels")
	self:RegisterBucketEvent("SPELLS_CHANGED", 1, "SPELLS_CHANGED")
	self:RegisterBucketEvent("PLAYER_ENTERING_WORLD", 2, "PLAYER_ENTERING_WORLD")
	if isPally then
		self:ScheduleRepeatingTimer(self.ScanInventory, 60, self)
		self.ButtonsUpdate(self)
	end
	self:BindKeys()
	self:UpdateRoster()
end

function PallyPower:OnDisable()
	self.opt.enable = false
	for i = 1, PALLYPOWER_MAXCLASSES do
		classlist[i] = 0
		classes[i] = {}
	end
	self:UpdateRoster()
	self.auraButton:Hide()
	self.rfButton:Hide()
	self.autoButton:Hide()
	PallyPowerAnchor:Hide()
	self:UnbindKeys()
end

function PallyPower:OnProfileChanged()
	self.opt = self.db.profile
	self:UpdateLayout()
end

function PallyPower:BindKeys()
	local key1 = GetBindingKey("AUTOKEY1")
	local key2 = GetBindingKey("AUTOKEY2")
	if key1 then
		SetOverrideBindingClick(self.autoButton, false, key1, "PallyPowerAuto", "Hotkey1")
	end
	if key2 then
		SetOverrideBindingClick(self.autoButton, false, key2, "PallyPowerAuto", "Hotkey2")
	end
end

function PallyPower:UnbindKeys()
	ClearOverrideBindings(self.autoButton)
end

-------------------------------------------------------------------
-- Config Window Functionality
-------------------------------------------------------------------
function PallyPower:Purge()
	PallyPower_Assignments = nil
	PallyPower_NormalAssignments = nil
	PallyPower_AuraAssignments = nil
	PallyPower_Assignments = {}
	PallyPower_NormalAssignments = {}
	PallyPower_AuraAssignments = {}
end

function PallyPower:Reset()
	if InCombatLockdown() then return end

	local h = _G["PallyPowerFrame"]
	h:ClearAllPoints()
	h:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
	self.opt.buffscale = 0.9
	self.opt.border = "Blizzard Tooltip"
	self.opt.layout = "Layout 2"
	self.opt.skin = "Smooth"
	local c = _G["PallyPowerBlessingsFrame"]
	c:ClearAllPoints()
	c:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
	self.opt.configscale = 0.9
	self:ApplySkin()
	self:UpdateLayout()
end

function PallyPower:OpenConfigWindow()
	if PallyPowerBlessingsFrame:IsVisible() then
		PallyPowerBlessingsFrame:Hide()
		LUIDDM:CloseDropDownMenus()
	end
	if not PallyPowerConfigFrame:IsShown() then
		PallyPowerConfigFrame:Show()
		PlaySound(SOUNDKIT.IG_SPELLBOOK_OPEN)
	else
		PallyPowerConfigFrame:Hide()
		PlaySound(SOUNDKIT.IG_SPELLBOOK_CLOSE)
	end
end

function PallyPowerBlessings_Clear()
	if InCombatLockdown() then return end

	if GetNumGroupMembers() > 0 and PallyPower:CheckLeader(PallyPower.player) then
		PallyPower:ClearAssignments(PallyPower.player)
		PallyPower:SendMessage("CLEAR")
	elseif GetNumGroupMembers() > 0 and not PallyPower:CheckLeader(PallyPower.player) then
		for leadername in pairs(leaders) do
			if not IsGuildMember(leadername) or PP_Leader == false then
				PallyPower:ClearAssignments(PallyPower.player)
				PallyPower:SendSelf()
			end
		end
	else
		PallyPower:ClearAssignments(PallyPower.player)
	end
	PallyPower:UpdateLayout()
	PallyPower:UpdateRoster()
end

function PallyPowerBlessings_Refresh()
	PallyPower:Debug("PallyPowerBlessings_Refresh")
	PallyPower:ScanSpells()
	PallyPower:ScanCooldowns()
	PallyPower:ScanInventory()
	if GetNumGroupMembers() > 0 then
		PallyPower:SendSelf()
		PallyPower:SendMessage("REQ")
	end
	PallyPower:UpdateLayout()
	PallyPower:UpdateRoster()
end

function PallyPowerBlessings_Toggle()
	if PallyPower.configFrame and PallyPower.configFrame:IsShown() then
		PallyPower.configFrame:Hide()
	end
	if PallyPowerBlessingsFrame:IsVisible() then
		PallyPowerBlessingsFrame:Hide()
		LUIDDM:CloseDropDownMenus()
		PlaySound(SOUNDKIT.IG_SPELLBOOK_CLOSE)
	else
		local c = _G["PallyPowerBlessingsFrame"]
		c:ClearAllPoints()
		c:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
		PallyPower:ScanSpells()
		PallyPower:ScanCooldowns()
		PallyPower:ScanInventory()
		if GetNumGroupMembers() > 0 then
			PallyPower:SendSelf()
			PallyPower:SendMessage("REQ")
		end
		PallyPowerBlessingsFrame:Show()
		PlaySound(SOUNDKIT.IG_SPELLBOOK_OPEN)
		table.insert(UISpecialFrames, "PallyPowerBlessingsFrame")
	end
end

function PallyPowerMinimapIcon_Toggle()
	if (PallyPower.opt.minimap.show == false) then
		PallyPower.MinimapIcon:Hide("PallyPower")
	else
		PallyPower.MinimapIcon:Show("PallyPower")
	end
end

function PallyPowerBlessings_ShowCredits(self)
	if PallyPower.opt.ShowTooltips then
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:SetText(PallyPower.Credits1, 1, 1, 1)
		GameTooltip:AddLine(PallyPower.Credits2, 1, 1, 1)
		GameTooltip:Show()
	end
end

function GetNormalBlessings(pname, class, tname)
	if PallyPower_NormalAssignments[pname] and PallyPower_NormalAssignments[pname][class] then
		local blessing = PallyPower_NormalAssignments[pname][class][tname]
		if blessing then
			return tostring(blessing)
		else
			return "0"
		end
	end
end

function SetNormalBlessings(pname, class, tname, value)
	if not PallyPower_NormalAssignments[pname] then
		PallyPower_NormalAssignments[pname] = {}
	end
	if not PallyPower_NormalAssignments[pname][class] then
		PallyPower_NormalAssignments[pname][class] = {}
	end
	if value == 0 then
		value = nil
	end
	PallyPower_NormalAssignments[pname][class][tname] = value
	local msgQueue
	msgQueue =
		C_Timer.NewTimer(
		2.0,
		function()
			if PallyPower_NormalAssignments and PallyPower_NormalAssignments[pname] and PallyPower_NormalAssignments[pname][class] and PallyPower_NormalAssignments[pname][class][tname] then
				if PallyPower_NormalAssignments[pname][class][tname] == nil then
					value = 0
				else
					value = PallyPower_NormalAssignments[pname][class][tname]
				end
				PallyPower:SendMessage("NASSIGN " .. pname .. " " .. class .. " " .. tname .. " " .. value)
				PallyPower:UpdateLayout()
				msgQueue:Cancel()
			end
		end
	)
end

function PallyPowerGrid_NormalBlessingMenu(btn, mouseBtn, pname, class)
	if InCombatLockdown() then return end

	if (mouseBtn == "LeftButton") then

		local menu = {}

		local shortname = strsplit("%-", pname)

		tinsert(menu, {text = "|cffffffff" .. shortname .. "|r " .. L["ALTMENU_LINE1"], isTitle = true, isNotRadio = true, notCheckable = 1})
		tinsert(menu, {text = L["ALTMENU_LINE2"], isTitle = true, isNotRadio = true, notCheckable = 1})

		local pre, suf
		for pally in pairs(AllPallys) do
			local pallyMenu = {}
			local control = PallyPower:CanControl(pally)
			if not control then
				pre = "|cff999999"
				suf = "|r"
			else
				pre = ""
				suf = ""
			end

			tinsert(pallyMenu, {
				text = format("%s%s%s", pre, "(none)", suf),
				checked = function() if GetNormalBlessings(pally, class, pname) == "0" then return true end end,
				func = function() LUIDDM:CloseDropDownMenus(); SetNormalBlessings(pally, class, pname, 0) end
			})

			for index, blessing in ipairs(PallyPower.Spells) do
				if PallyPower:CanBuff(pally, index) then
					local unitID = PallyPower:GetUnitIdByName(pname)
					if PallyPower:CanBuffBlessing(index, 0, unitID) then
						tinsert(pallyMenu, {
							text = format("%s%s%s", pre, blessing, suf),
							checked = function() if GetNormalBlessings(pally, class, pname) == tostring(index) then return true end end,
							func = function() LUIDDM:CloseDropDownMenus(); if control then SetNormalBlessings(pally, class, pname, index + 0) end end
						})
					end
				end
			end

			local shortname = strsplit("%-", pally)

			tinsert(menu, {
				text = format("%s%s%s", pre, shortname, suf),
				hasArrow = true,
				menuList = pallyMenu,
				checked = function()
					if PallyPower_NormalAssignments[pally] and PallyPower_NormalAssignments[pally][class] and PallyPower_NormalAssignments[pally][class][pname] then
						return true
					else
						SetNormalBlessings(pally, class, pname, 0)
					end
				end
			})
		end

		tinsert(menu, {text = L["CANCEL"], func = function() end, isNotRadio = true, notCheckable = 1})

		LUIDDM:EasyMenu(menu, PallyPower.menuFrame, "cursor", 0 , 0, "MENU")

	elseif (mouseBtn == "RightButton") then
		for pally in pairs(AllPallys) do
			if PallyPower_NormalAssignments[pally] and PallyPower_NormalAssignments[pally][class] and PallyPower_NormalAssignments[pally][class][pname] then
				PallyPower_NormalAssignments[pally][class][pname] = nil
			end
			PallyPower:SendMessage("NASSIGN " .. pally .. " " .. class .. " " .. pname .. " 0")
			PallyPower:UpdateLayout()
		end
	end
end

function PallyPowerPlayerButton_OnClick(btn, mouseBtn)
	if InCombatLockdown() then return end

	local _, _, class, pnum = strfind(btn:GetName(), "PallyPowerBlessingsFrameClassGroup(.+)PlayerButton(.+)")
	class = tonumber(class)
	pnum = tonumber(pnum)
	local pname = classes[class][pnum].name

	PallyPowerGrid_NormalBlessingMenu(btn, mouseBtn, pname, class)
end

function PallyPowerPlayerButton_OnMouseWheel(btn, arg1)
	if InCombatLockdown() then return end

	local _, _, class, pnum = strfind(btn:GetName(), "PallyPowerBlessingsFrameClassGroup(.+)PlayerButton(.+)")
	class = tonumber(class)
	pnum = tonumber(pnum)
	local pname = classes[class][pnum].name
	PallyPower:PerformPlayerCycle(arg1, pname, class)
end

function PallyPowerGridButton_OnClick(btn, mouseBtn)
	if InCombatLockdown() then return end

	local _, _, pnum, class = strfind(btn:GetName(), "PallyPowerBlessingsFramePlayer(.+)Class(.+)")
	class = tonumber(class)
	pnum = tonumber(pnum)
	local pname = _G["PallyPowerBlessingsFramePlayer" .. pnum .. "Name"]:GetText()
	if not PallyPower:CanControl(pname) then
		return false
	end
	if (mouseBtn == "RightButton") then
		if PallyPower_Assignments and PallyPower_Assignments[pname] and PallyPower_Assignments[pname][class] then
			PallyPower_Assignments[pname][class] = 0
		end
		PallyPower:SendMessage("ASSIGN " .. pname .. " " .. class .. " 0")
		PallyPower:UpdateLayout()
	else
		PallyPower:PerformCycle(pname, class)
	end
end

function PallyPowerGridButton_OnMouseWheel(btn, arg1)
	if InCombatLockdown() then return end

	local _, _, pnum, class = strfind(btn:GetName(), "PallyPowerBlessingsFramePlayer(.+)Class(.+)")
	class = tonumber(class)
	pnum = tonumber(pnum)
	local pname = _G["PallyPowerBlessingsFramePlayer" .. pnum .. "Name"]:GetText()
	if not PallyPower:CanControl(pname) then
		return false
	end
	if (arg1 == -1) then --mouse wheel down
		PallyPower:PerformCycle(pname, class)
	else
		PallyPower:PerformCycleBackwards(pname, class)
	end
end

function PallyPowerBlessingsFrame_MouseUp()
	if (PallyPowerBlessingsFrame.isMoving) then
		PallyPowerBlessingsFrame:StopMovingOrSizing()
		PallyPowerBlessingsFrame.isMoving = false
	end
end

function PallyPowerBlessingsFrame_MouseDown(self, button)
	if (((not PallyPowerBlessingsFrame.isLocked) or (PallyPowerBlessingsFrame.isLocked == 0)) and (button == "LeftButton")) then
		PallyPowerBlessingsFrame:StartMoving()
		PallyPowerBlessingsFrame:SetClampedToScreen(true)
		PallyPowerBlessingsFrame.isMoving = true
	end
end

function PallyPowerBlessingsGrid_Update(self, elapsed)
	if not initialized then
		return
	end
	if PallyPowerBlessingsFrame:IsVisible() then
		local numPallys = 0
		local numMaxClass = 0
		for i = 1, PALLYPOWER_MAXCLASSES do
			local fname = "PallyPowerBlessingsFrameClassGroup" .. i
			_G[fname .. "ClassButtonIcon"]:SetTexture(PallyPower.ClassIcons[i])
			for j = 1, PALLYPOWER_MAXPERCLASS do
				local pbnt = fname .. "PlayerButton" .. j
				if classes[i] and classes[i][j] then
					local unit = classes[i][j]
					if unit.name then
						local shortname = Ambiguate(unit.name, "short")
						_G[pbnt .. "Text"]:SetText(shortname)
					end
					local normal, greater = PallyPower:GetSpellID(i, unit.name)
					if normal ~= greater then
						_G[pbnt .. "Icon"]:SetTexture(PallyPower.NormalBlessingIcons[normal])
					else
						_G[pbnt .. "Icon"]:SetTexture("")
					end
					_G[pbnt]:Show()
				else
					_G[pbnt]:Hide()
				end
			end
			if classlist[i] then
				numMaxClass = math.max(numMaxClass, classlist[i])
			end
		end
		PallyPowerBlessingsFrame:SetScale(PallyPower.opt.configscale)
		for i, name in pairs(SyncList) do
			local fname = "PallyPowerBlessingsFramePlayer" .. i
			local SkillInfo = AllPallys[name]
			local BuffInfo = PallyPower_Assignments[name]
			local NormalBuffInfo = PallyPower_NormalAssignments[name]
			_G[fname .. "Name"]:SetText(name)
			if PallyPower:CanControl(name) then
				_G[fname .. "Name"]:SetTextColor(1, 1, 1)
			else
				if PallyPower:CheckLeader(name) then
					_G[fname .. "Name"]:SetTextColor(0, 1, 0)
				else
					_G[fname .. "Name"]:SetTextColor(1, 0, 0)
				end
			end
			_G[fname .. "Symbols"]:SetText(SkillInfo.symbols)
			_G[fname .. "Symbols"]:SetTextColor(1, 1, 0.5)
			for id = 1, 6 do
				if SkillInfo[id] then
					_G[fname .. "Icon" .. id]:Show()
					_G[fname .. "Skill" .. id]:Show()
					local txt = SkillInfo[id].rank
					if SkillInfo[id].talent and (SkillInfo[id].talent + 0 > 0) then
						txt = txt .. "+" .. SkillInfo[id].talent
					end
					_G[fname .. "Skill" .. id]:SetText(txt)
				else
					_G[fname .. "Icon" .. id]:Hide()
					_G[fname .. "Skill" .. id]:Hide()
				end
			end
			if not AllPallys[name].AuraInfo then
				AllPallys[name].AuraInfo = {}
			end
			local AuraInfo = AllPallys[name].AuraInfo
			for id = 1, 3 do
				if AuraInfo[id] then
					_G[fname .. "AIcon" .. id]:Show()
					_G[fname .. "ASkill" .. id]:Show()
					local txt = AuraInfo[id].rank
					if AuraInfo[id].talent and (AuraInfo[id].talent + 0 > 0) then
						txt = txt .. "+" .. AuraInfo[id].talent
					end
					_G[fname .. "ASkill" .. id]:SetText(txt)
				else
					_G[fname .. "AIcon" .. id]:Hide()
					_G[fname .. "ASkill" .. id]:Hide()
				end
			end
			local aura = PallyPower_AuraAssignments[name]
			if (aura and aura > 0) then
				_G[fname .. "Aura1Icon"]:SetTexture(PallyPower.AuraIcons[aura])
			else
				_G[fname .. "Aura1Icon"]:SetTexture(nil)
			end
			if not AllPallys[name].CooldownInfo then
				AllPallys[name].CooldownInfo = {}
			end
			local CooldownInfo = AllPallys[name].CooldownInfo
			for id = 1, 2 do
				if CooldownInfo[id] then
					_G[fname .. "CIcon" .. id]:Show()
					_G[fname .. "CSkill" .. id]:Show()
					if CooldownInfo[id].start ~= 0 and CooldownInfo[id].duration ~= 0 then
						CooldownInfo[id].text = PallyPower:FormatTime(CooldownInfo[id].start + CooldownInfo[id].duration - GetTime())
						if CooldownInfo[id].start + CooldownInfo[id].duration - GetTime() < 1 then
							CooldownInfo[id].text = "|cff00ff00Ready|r"
						end
					else
						CooldownInfo[id].text = "|cff00ff00Ready|r"
					end
					if CooldownInfo[id].text then
						txt = CooldownInfo[id].text
					end
					_G[fname .. "CSkill" .. id]:SetText(txt)
				else
					_G[fname .. "CIcon" .. id]:Hide()
					_G[fname .. "CSkill" .. id]:Hide()
				end
			end
			for id = 1, PALLYPOWER_MAXCLASSES do
				if BuffInfo and BuffInfo[id] then
					_G[fname .. "Class" .. id .. "Icon"]:SetTexture(PallyPower.BlessingIcons[BuffInfo[id]])
				else
					_G[fname .. "Class" .. id .. "Icon"]:SetTexture(nil)
				end
				local found
			end
			i = i + 1
			numPallys = numPallys + 1
		end
		PallyPowerBlessingsFrame:SetHeight(14 + 24 + 56 + (numPallys * 100) + 22 + 13 * numMaxClass)
		_G["PallyPowerBlessingsFramePlayer1"]:SetPoint("TOPLEFT", 8, -80 - 13 * numMaxClass)
		for i = 1, PALLYPOWER_MAXCLASSES do
			_G["PallyPowerBlessingsFrameClassGroup" .. i .. "Line"]:SetHeight(56 + 13 * numMaxClass)
		end
		_G["PallyPowerBlessingsFrameAuraGroup1Line"]:SetHeight(56 + 13 * numMaxClass)
		for i = 1, PALLYPOWER_MAXPERCLASS do
			local fname = "PallyPowerBlessingsFramePlayer" .. i
			if i <= numPallys then
				_G[fname]:Show()
			else
				_G[fname]:Hide()
			end
		end
		PallyPowerBlessingsFrameFreeAssign:SetChecked(PallyPower.opt.freeassign)
	end
end

function PallyPower_StartScaling(self, button)
	if button == "RightButton" then
		PallyPower.opt.configscale = 0.9
		local c = _G["PallyPowerBlessingsFrame"]
		c:ClearAllPoints()
		c:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
		PallyPowerBlessingsFrame:Show()
	end
	if button == "LeftButton" then
		self:LockHighlight()
		PallyPower.FrameToScale = self:GetParent()
		PallyPower.ScalingWidth = self:GetParent():GetWidth() * PallyPower.FrameToScale:GetParent():GetEffectiveScale()
		PallyPower.ScalingHeight = self:GetParent():GetHeight() * PallyPower.FrameToScale:GetParent():GetEffectiveScale()
		PallyPowerScalingFrame:Show()
	end
end

function PallyPower_StopScaling(self, button)
	if button == "LeftButton" then
		PallyPowerScalingFrame:Hide()
		PallyPower.FrameToScale = nil
		self:UnlockHighlight()
	end
end

function PallyPower_ScaleFrame(scale)
	local frame = PallyPower.FrameToScale
	local oldscale = frame:GetScale() or 1
	local framex = (frame:GetLeft() or PallyPowerPerOptions.XPos) * oldscale
	local framey = (frame:GetTop() or PallyPowerPerOptions.YPos) * oldscale
	frame:SetScale(scale)
	if frame:GetName() == "PallyPowerBlessingsFrame" then
		frame:SetClampedToScreen(true)
		frame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", framex / scale, framey / scale)
		PallyPower.opt.configscale = scale
	end
end

function PallyPower_ScalingFrame_Update(self, elapsed)
	if not PallyPower.ScalingTime then
		PallyPower.ScalingTime = 0
	end
	PallyPower.ScalingTime = PallyPower.ScalingTime + elapsed
	if PallyPower.ScalingTime > 0.25 then
		PallyPower.ScalingTime = 0
		local frame = PallyPower.FrameToScale
		local oldscale = frame:GetEffectiveScale()
		local framex, framey, cursorx, cursory = frame:GetLeft() * oldscale, frame:GetTop() * oldscale, GetCursorPosition()
		if PallyPower.ScalingWidth > PallyPower.ScalingHeight then
			if (cursorx - framex) > 32 then
				local newscale = (cursorx - framex) / PallyPower.ScalingWidth
				if newscale < 0.5 then
					PallyPower_ScaleFrame(0.5)
				else
					PallyPower_ScaleFrame(newscale)
				end
			end
		else
			if (framey - cursory) > 32 then
				local newscale = (framey - cursory) / PallyPower.ScalingHeight
				if newscale < 0.5 then
					PallyPower_ScaleFrame(0.5)
				else
					PallyPower_ScaleFrame(newscale)
				end
			end
		end
	end
end

-------------------------------------------------------------------
-- Main Functionality
-------------------------------------------------------------------
function PallyPower:ReportChannels()
	local channels = {GetChannelList()}
	PallyPower_ChanNames = {}
	PallyPower_ChanNames[0] = "None"
	for i = 1, #channels / 3 do
		local chanName = channels[i * 3 - 1]
		if chanName ~= "LookingForGroup" and chanName ~= "General" and chanName ~= "Trade" and chanName ~= "LocalDefense" and chanName ~= "WorldDefense" and chanName ~= "GuildRecruitment" then
			PallyPower_ChanNames[i] = chanName
		end
	end
	return PallyPower_ChanNames
end

function PallyPower:Report(type, chanNum)
	if not type then
		if GetNumGroupMembers() > 0 then
			if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then
				type = "INSTANCE_CHAT"
			else
				if IsInRaid() then
					type = "RAID"
				elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
					type = "PARTY"
				end
			end
			if self:CheckLeader(self.player) and type ~= "INSTANCE_CHAT" then
				if #SyncList > 0 then
					SendChatMessage(PALLYPOWER_ASSIGNMENTS1, type)
					local list = {}
					for name in pairs(AllPallys) do
						local blessings
						for i = 1, 6 do
							list[i] = 0
						end
						for id = 1, PALLYPOWER_MAXCLASSES do
							local bid = PallyPower_Assignments[name][id]
							if bid and bid > 0 then
								list[bid] = list[bid] + 1
							end
						end
						for id = 1, 6 do
							if (list[id] > 0) then
								if (blessings) then
									blessings = blessings .. ", "
								else
									blessings = ""
								end
								local spell = self.Spells[id]
								blessings = blessings .. spell
							end
						end
						if not (blessings) then
							blessings = "Nothing"
						end
						SendChatMessage(name .. ": " .. blessings, type)
					end
					SendChatMessage(PALLYPOWER_ASSIGNMENTS2, type)
				end
			else
				if type == "INSTANCE_CHAT" then
					self:Print("Blessings Report is disabled in Battlegrounds.")
				elseif type == "RAID" then
					self:Print("You are not the raid leader or do not have raid assist.")
				else
					self:Print(ERR_NOT_LEADER)
				end
			end
		else
			if type == "RAID" then
				self:Print(ERR_NOT_IN_RAID)
			else
				self:Print(ERR_NOT_IN_GROUP)
			end
		end
	else
		if ((type and (type ~= "INSTANCE_CHAT" or type ~= "RAID" or type ~= "PARTY")) and chanNum and (IsInRaid() or IsInGroup())) then
			SendChatMessage(PALLYPOWER_ASSIGNMENTS1, type, nil, chanNum)
			local list = {}
			for name in pairs(AllPallys) do
				local blessings
				for i = 1, 6 do
					list[i] = 0
				end
				for id = 1, PALLYPOWER_MAXCLASSES do
					local bid = PallyPower_Assignments[name][id]
					if bid and bid > 0 then
						list[bid] = list[bid] + 1
					end
				end
				for id = 1, 6 do
					if (list[id] > 0) then
						if (blessings) then
							blessings = blessings .. ", "
						else
							blessings = ""
						end
						local spell = self.Spells[id]
						blessings = blessings .. spell
					end
				end
				if not (blessings) then
					blessings = "Nothing"
				end
				SendChatMessage(name .. ": " .. blessings, type, nil, chanNum)
			end
			SendChatMessage(PALLYPOWER_ASSIGNMENTS2, type, nil, chanNum)
		elseif not IsInGroup() then
			self:Print(ERR_NOT_IN_GROUP)
		elseif not IsInRaid() then
			self:Print(ERR_NOT_IN_RAID)
		end
	end
end

function PallyPower:PerformCycle(name, class, skipzero)
	local shift = (IsShiftKeyDown() and PallyPowerBlessingsFrame:IsMouseOver())
	local control = (IsControlKeyDown() and PallyPowerBlessingsFrame:IsMouseOver())
	local cur
	if shift then
		class = 5
	end
	if not PallyPower_Assignments[name] then
		PallyPower_Assignments[name] = {}
	end
	if not PallyPower_Assignments[name][class] then
		cur = 0
	else
		cur = PallyPower_Assignments[name][class]
	end
	PallyPower_Assignments[name][class] = 0
	for testB = cur + 1, 7 do
		cur = testB
		if self:CanBuff(name, testB) and (self:NeedsBuff(class, testB) or shift or control) then
			do
				break
			end
		end
	end
	if cur == 7 then
		if skipzero then
			if self:CanBuff(name, 1) then
				if self.opt.SmartBuffs and (class == 1 or class == 2) then
					cur = 2
				else
					cur = 1
				end
			elseif self:CanBuff(name, 2) then
				if self.opt.SmartBuffs and (class == 3 or (not self.isBCC and class == 6) or class == 7 or class == 8) then
					cur = 1
				else
					cur = 2
				end
			end
		else
			cur = 0
		end
	end
	if shift then
		for testC = 1, PALLYPOWER_MAXCLASSES do
			PallyPower_Assignments[name][testC] = cur
		end
		local msgQueue
		msgQueue =
			C_Timer.NewTimer(
			2.0,
			function()
				self:SendMessage("MASSIGN " .. name .. " " .. PallyPower_Assignments[name][class])
				self:UpdateLayout()
				msgQueue:Cancel()
			end
		)
	else
		PallyPower_Assignments[name][class] = cur
		local msgQueue
		msgQueue =
			C_Timer.NewTimer(
			2.0,
			function()
				self:SendMessage("ASSIGN " .. name .. " " .. class .. " " .. PallyPower_Assignments[name][class])
				self:UpdateLayout()
				msgQueue:Cancel()
			end
		)
	end
end

function PallyPower:PerformCycleBackwards(name, class, skipzero)
	local shift = (IsShiftKeyDown() and PallyPowerBlessingsFrame:IsMouseOver())
	local control = (IsControlKeyDown() and PallyPowerBlessingsFrame:IsMouseOver())
	local cur
	if shift then
		class = 5
	end
	if name and not PallyPower_Assignments[name] then
		PallyPower_Assignments[name] = {}
	end
	if not PallyPower_Assignments[name][class] then
		cur = 7
	else
		cur = PallyPower_Assignments[name][class]
		local testB
		if self:CanBuff(name, 1) then
			if self.opt.SmartBuffs and (class == 1 or class == 2) then
				testB = 2
			else
				testB = 1
			end
		elseif self:CanBuff(name, 2) then
			if self.opt.SmartBuffs and (class == 3 or (not self.isBCC and class == 6) or class == 7 or class == 8) then
				testB = 1
			else
				testB = 2
			end
		else
			testB = 0
		end
		if cur == 0 or skipzero and cur == testB then
			cur = 7
		end
	end
	PallyPower_Assignments[name][class] = 0
	for testC = cur - 1, 0, -1 do
		cur = testC
		if self:CanBuff(name, testC) and (self:NeedsBuff(class, testC) or shift or control) then
			do
				break
			end
		end
	end
	if shift then
		for testC = 1, PALLYPOWER_MAXCLASSES do
			PallyPower_Assignments[name][testC] = cur
		end
		local msgQueue
		msgQueue =
			C_Timer.NewTimer(
			2.0,
			function()
				self:SendMessage("MASSIGN " .. name .. " " .. PallyPower_Assignments[name][class])
				self:UpdateLayout()
				msgQueue:Cancel()
			end
		)
	else
		PallyPower_Assignments[name][class] = cur
		local msgQueue
		msgQueue =
			C_Timer.NewTimer(
			2.0,
			function()
				self:SendMessage("ASSIGN " .. name .. " " .. class .. " " .. PallyPower_Assignments[name][class])
				self:UpdateLayout()
				msgQueue:Cancel()
			end
		)
	end
end

function PallyPower:PerformPlayerCycle(delta, pname, class)
	local control = (IsControlKeyDown() and PallyPowerBlessingsFrame:IsMouseOver())
	local blessing = 0
	if not isPally then
		return
	end
	if PallyPower_NormalAssignments[self.player] and PallyPower_NormalAssignments[self.player][class] and PallyPower_NormalAssignments[self.player][class][pname] then
		blessing = PallyPower_NormalAssignments[self.player][class][pname]
	end
	local count
	-- Can't give Blessing of Sacrifice to yourself
	if pname == self.player then
		count = 7
	else
		count = 8
	end
	local test = (blessing - delta) % count
	while not (PallyPower:CanBuff(self.player, test) and PallyPower:NeedsBuff(class, test, pname) or control) and test > 0 do
		test = (test - delta) % count
		if test == blessing then
			test = 0
			break
		end
	end
	SetNormalBlessings(self.player, class, pname, test)
end

function PallyPower:AssignPlayerAsClass(pname, pclass, tclass)
	local greater, target, targetsorted, freepallies = {}, {}, {}, {}
	for pally, classes in pairs(PallyPower_Assignments) do
		if AllPallys[pally] and classes[tclass] and classes[tclass] > 0 then
			target[classes[tclass]] = pally
			tinsert(targetsorted, classes[tclass])
		end
	end
	tsort(
		targetsorted,
		function(a, b)
			return a == 2 or a == 1 and b ~= 2
		end
	)
	for pally, info in pairs(AllPallys) do
		if PallyPower_Assignments[pally] and PallyPower_Assignments[pally][pclass] then
			local blessing = PallyPower_Assignments[pally][pclass]
			greater[blessing] = pally
			if not target[blessing] then
				freepallies[pally] = info
			end
		else
			freepallies[pally] = info
		end
	end
	for _, blessing in pairs(targetsorted) do
		if greater[blessing] then
			local pally = greater[blessing]
			if PallyPower_NormalAssignments[pally] and PallyPower_NormalAssignments[pally][pclass] and PallyPower_NormalAssignments[pally][pclass][pname] then
				SetNormalBlessings(pally, pclass, pname, 0)
			end
		else
			local maxname, maxrank, maxtalent = nil, 0, 0
			local targetpally = target[blessing]
			for pally, blessinginfo in pairs(freepallies) do
				local blessinginfo = blessinginfo[blessing]
				local rank, talent = 0, 0
				if blessinginfo then
					rank, talent = blessinginfo.rank, blessinginfo.talent
				end
				if rank > maxrank or (rank == maxrank and talent > maxtalent) or pally == targetpally then
					maxname = pally
					maxrank = rank
					maxtalent = talent
				end
			end
			if maxname then
				freepallies[maxname] = nil
				SetNormalBlessings(maxname, pclass, pname, blessing)
			end
		end
	end
end

function PallyPower:CanBuff(name, test)
	if test == 9 then
		return true
	end
	if (not AllPallys[name][test]) or (AllPallys[name][test].rank == 0) then
		return false
	end
	return true
end

function PallyPower:CanBuffBlessing(spellId, gspellId, unitId)
	if unitId and spellId or gspellId then
		local normSpell, greatSpell
		if UnitLevel(unitId) >= 60 then
			if spellId > 0 then
				if spellId == 7 and GetUnitName(unitId, false) == self.player then
					normSpell = nil
				else
					normSpell = self.Spells[spellId]
				end
			else
				normSpell = nil
			end
			if gspellId > 0 then
				greatSpell = self.GSpells[gspellId]
			else
				greatSpell = nil
			end
			return normSpell, greatSpell
		end
		if spellId > 0 then
			for _, v in pairs(self.NormalBuffs[spellId]) do
				if IsSpellKnown(v[2]) then
					if UnitLevel(unitId) >= v[1] then
						local spellName = GetSpellInfo(v[2])
						local spellRank = GetSpellSubtext(v[2])
						if spellName and spellRank then
							if spellId == 3 or spellId == 4 then
								normSpell = spellName
							else
								normSpell = spellName .. "(" .. spellRank .. ")"
							end
						end
						if spellId == 7 and GetUnitName(unitId, false) == self.player then
							normSpell = nil
						end
						break
					else
						normSpell = nil
					end
				end
			end
		else
			normSpell = nil
		end
		if gspellId > 0 and UnitLevel(unitId) > 49 then
			for _, v in pairs(self.GreaterBuffs[gspellId]) do
				if IsSpellKnown(v[2]) then
					if UnitLevel(unitId) >= v[1] then
						local gspellName = GetSpellInfo(v[2])
						local gspellRank = GetSpellSubtext(v[2])
						if gspellName and gspellRank then
							if gspellId == 1 or gspellId == 2 or gspellId == 7 then
								greatSpell = gspellName .. "(" .. gspellRank .. ")"
							else
								greatSpell = gspellName
							end
						end
						break
					else
						greatSpell = nil
					end
				end
			end
		else
			greatSpell = nil
		end
		return normSpell, greatSpell
	end
end

function PallyPower:NeedsBuff(class, test, playerName)
	if test == 9 or test == 0 then
		return true
	end
	if self.opt.SmartBuffs then
		-- no wisdom for warriors and rogues
		if (class == 1 or class == 2) and test == 1 then
			return false
		end
		-- no might for casters (and hunters in Classic)
		if (class == 3 or (not self.isBCC and class == 6) or class == 7 or class == 8) and test == 2 then
			return false
		end
	end
	if playerName then
		for pname, classes in pairs(PallyPower_NormalAssignments) do
			if AllPallys[pname] and not pname == self.player then
				for _, tnames in pairs(classes) do
					for _, blessing_id in pairs(tnames) do
						if blessing_id == test then
							return false
						end
					end
				end
			end
		end
	end
	for name, skills in pairs(PallyPower_Assignments) do
		if (AllPallys[name]) and ((skills[class]) and (skills[class] == test)) then
			return false
		end
	end
	return true
end

function PallyPower:ScanSpells()
	--self:Debug("[ScanSpells]")
	if isPally then
		local RankInfo = {}
		for i = 1, #self.Spells do -- find max spell ranks
			local spellName = GetSpellInfo(self.Spells[i])
			local spellRank = GetSpellSubtext(GetSpellInfo(self.Spells[i]))
			if spellName then
				RankInfo[i] = {}
				if not spellRank or spellRank == "" then -- spells without ranks
					spellRank = "1" -- BoK and BoS
				end
				local talent = 0
				if i == 1 then
					talent = talent + select(5, GetTalentInfo(1, 10)) -- Improved Blessing of Wisdom
				elseif i == 2 then
					talent = talent + select(5, GetTalentInfo(3, 1)) -- Improved Blessing of Might
				elseif i == 3 then
					talent = talent + select(5, GetTalentInfo(2, 6)) -- Blessing of Kings
				elseif i == 6 then
					if self.isBCC then
						talent = talent + select(5, GetTalentInfo(2, 14)) -- Blessing of Sanctuary
					else
						talent = talent + select(5, GetTalentInfo(2, 12)) -- Blessing of Sanctuary
					end
				end
				RankInfo[i].talent = talent
				RankInfo[i].rank = tonumber(select(3, strfind(spellRank, "(%d+)")))
			end
		end
		self:SyncAdd(self.player)
		AllPallys[self.player] = RankInfo
		AllPallys[self.player].AuraInfo = {}
		for i = 1, PALLYPOWER_MAXAURAS do -- find max ranks/talents for auaras
			local spellName = GetSpellInfo(self.Auras[i])
			local spellRank = GetSpellSubtext(GetSpellInfo(self.Auras[i]))
			if spellName then
				AllPallys[self.player].AuraInfo[i] = {}
				if not spellRank or spellRank == "" then -- spells without ranks
					spellRank = "1" -- Concentration
				end
				local talent = 0
				if i == 1 then
					talent = talent + select(5, GetTalentInfo(2, 1)) -- Improved Devotion Aura
				elseif i == 2 then
					talent = talent + select(5, GetTalentInfo(3, 11)) -- Improved Retribution Aura
				elseif i == 3 then
					if self.isBCC then
						talent = talent + select(5, GetTalentInfo(2, 12)) -- Improved Concentration Aura
					else
						talent = talent + select(5, GetTalentInfo(2, 11)) -- Improved Concentration Aura
					end
				elseif i == 7 then
					if self.isBCC then
						talent = talent + select(5, GetTalentInfo(3, 14)) -- Sanctity Aura
					else
						talent = talent + select(5, GetTalentInfo(3, 13)) -- Sanctity Aura
					end
				end
				AllPallys[self.player].AuraInfo[i].talent = talent
				AllPallys[self.player].AuraInfo[i].rank = tonumber(select(3, strfind(spellRank, "(%d+)")))
			end
		end
		if not AllPallys[self.player].CooldownInfo then
			AllPallys[self.player].CooldownInfo = {}
		end
		local CooldownInfo = AllPallys[self.player].CooldownInfo
		for cd, spells in pairs(self.Cooldowns) do
			for _, spell in pairs(spells) do
				if IsSpellKnown(spell) then
					CooldownInfo[cd] = {}
				end
			end
		end
		isPally = true
		if not AllPallys[self.player].subgroup then
			AllPallys[self.player].subgroup = 1
		end
	end
	initialized = true
end

function PallyPower:ScanCooldowns()
	--self:Debug("[ScanCooldowns]")
	if not initialized or not isPally then
		return
	end
	local CooldownInfo = AllPallys[self.player].CooldownInfo
	for cd, spells in pairs(self.Cooldowns) do
		for _, spell in pairs(spells) do
			if not CooldownInfo[cd] then
				return
			end
			if GetSpellCooldown(spell) then
				CooldownInfo[cd].start = GetSpellCooldown(spell)
				CooldownInfo[cd].duration = select(2, GetSpellCooldown(spell))
				CooldownInfo[cd].remaining = CooldownInfo[cd].start + CooldownInfo[cd].duration - GetTime()
				if CooldownInfo[cd].remaining < 0 then
					CooldownInfo[cd].remaining = 0
				end
			end
		end
	end
end

function PallyPower:ScanInventory()
	if not initialized or not isPally then
		return
	end
	--self:Debug("[ScanInventory]")
	PP_Symbols = GetItemCount(21177)
	AllPallys[self.player].symbols = PP_Symbols
end

function PallyPower:SendSelf(sender)
	if not initialized or GetNumGroupMembers() == 0 then
		return
	else
		if PallyPower:CheckLeader(self.player) then
			self:SendMessage("PPLEADER " .. self.player)
		end
		if not isPally then
			return
		end
	end
	local leader = self:CheckLeader(sender)
	if sender and not leader then
		--self:Debug("[SendSelf] - WHISPER: " .. sender)
	else
		--self:Debug("[SendSelf] - GROUP")
	end
	local s = ""
	local SkillInfo = AllPallys[self.player]
	for i = 1, 6 do
		if not SkillInfo[i] then
			s = s .. "nn"
		else
			s = s .. SkillInfo[i].rank .. SkillInfo[i].talent
		end
	end
	s = s .. "@"
	if not PallyPower_Assignments[self.player] then
		PallyPower_Assignments[self.player] = {}
		for i = 1, PALLYPOWER_MAXCLASSES do
			PallyPower_Assignments[self.player][i] = 0
		end
	end
	local BuffInfo = PallyPower_Assignments[self.player]
	for i = 1, PALLYPOWER_MAXCLASSES do
		if not BuffInfo[i] or BuffInfo[i] == 0 then
			s = s .. "n"
		else
			s = s .. BuffInfo[i]
		end
	end
	if sender and not leader then
		self:SendMessage("SELF " .. s, "WHISPER", sender)
	else
		self:SendMessage("SELF " .. s)
	end
	s = ""
	local AuraInfo = AllPallys[self.player].AuraInfo
	for i = 1, PALLYPOWER_MAXAURAS do
		if not AuraInfo[i] then
			s = s .. "nn"
		else
			s = s .. format("%x%x", AuraInfo[i].rank, AuraInfo[i].talent)
		end
	end
	if not PallyPower_AuraAssignments[self.player] then
		PallyPower_AuraAssignments[self.player] = 0
	end
	s = s .. "@" .. PallyPower_AuraAssignments[self.player]
	if sender and not leader then
		self:SendMessage("ASELF " .. s, "WHISPER", sender)
	else
		self:SendMessage("ASELF " .. s)
	end
	local AssignList = {}
	if PallyPower_NormalAssignments[self.player] then
		for class_id, tnames in pairs(PallyPower_NormalAssignments[self.player]) do
			for tname, blessing_id in pairs(tnames) do
				tinsert(AssignList, format("%s %s %s %s", self.player, class_id, tname, blessing_id))
			end
		end
	end
	local count = table.getn(AssignList)
	if count > 0 then
		local offset = 1
		repeat
			if sender and not leader then
				self:SendMessage("NASSIGN " .. table.concat(AssignList, "@", offset, min(offset + 4, count)), "WHISPER", sender)
			else
				self:SendMessage("NASSIGN " .. table.concat(AssignList, "@", offset, min(offset + 4, count)))
			end
			offset = offset + 5
		until offset > count
	end
	if GetNumGroupMembers() > 0 then
		PP_Symbols = GetItemCount(21177)
		AllPallys[self.player].symbols = PP_Symbols
		AllPallys[self.player].freeassign = self.opt.freeassign
		local CooldownInfo, Cooldowns
		if #AllPallys[self.player].CooldownInfo > 0 then
			local s = ""
			CooldownInfo = AllPallys[self.player].CooldownInfo
			for i = 1, 2 do
				if CooldownInfo[i] then
					if not CooldownInfo[i].duration then
						s = s .. ":n"
					else
						s = s .. ":" .. CooldownInfo[i].duration
					end
					if not CooldownInfo[i].remaining then
						s = s .. ":n"
					else
						s = s .. ":" .. CooldownInfo[i].remaining
					end
				else
					s = s .. ":n:n"
				end
				Cooldowns = s
			end
		else
			Cooldowns = ":n:n:n:n"
		end

		if sender and not leader then
			--self:Debug("[SendFreeAssign] - WHISPER: " .. sender)
			if self.opt.freeassign then
				self:SendMessage("FREEASSIGN YES | SYMCOUNT " .. PP_Symbols .. " | COOLDOWNS" .. Cooldowns, "WHISPER", sender)
			else
				self:SendMessage("FREEASSIGN NO | SYMCOUNT " .. PP_Symbols .. " | COOLDOWNS" .. Cooldowns, "WHISPER", sender)
			end
		else
			--self:Debug("[SendFreeAssign] - GROUP")
			if self.opt.freeassign then
				self:SendMessage("FREEASSIGN YES | SYMCOUNT " .. PP_Symbols .. " | COOLDOWNS" .. Cooldowns)
			else
				self:SendMessage("FREEASSIGN NO | SYMCOUNT " .. PP_Symbols .. " | COOLDOWNS" .. Cooldowns)
			end
		end
	end
end

function PallyPower:SendMessage(msg, type, target)
	if GetNumGroupMembers() > 0 then
		if lastMsg ~= msg then
			lastMsg = msg
			local type
			if type == nil then
				if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then
					type = "INSTANCE_CHAT"
				else
					if IsInRaid() then
						type = "RAID"
					elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
						type = "PARTY"
					end
				end
			end
			if target then
				ChatThrottleLib:SendAddonMessage("NORMAL", self.commPrefix, msg, "WHISPER", target)
				--self:Debug("[Sent Message] prefix: " .. self.commPrefix .. " | msg: " .. msg .. " | type: WHISPER | target name: " .. target)
			else
				ChatThrottleLib:SendAddonMessage("NORMAL", self.commPrefix, msg, type)
				--self:Debug("[Sent Message] prefix: " .. self.commPrefix .. " | msg: " .. msg .. " | type: " .. type)
			end
		end
	end
end

function PallyPower:SPELLS_CHANGED()
	--self:Debug("EVENT: SPELLS_CHANGED")
	if not initialized then
		PallyPower:ScanSpells()
		return
	end
	PallyPower:ScanSpells()
	PallyPower:ScanCooldowns()
	PallyPower:SendSelf()
	PallyPower:UpdateLayout()
end

function PallyPower:PLAYER_ENTERING_WORLD()
	--self:Debug("EVENT: PLAYER_ENTERING_WORLD")
	self:RegisterBucketEvent({"GROUP_ROSTER_UPDATE", "PLAYER_REGEN_ENABLED", "UNIT_PET", "UNIT_AURA"}, 1, "UpdateRoster")
	self:UpdateLayout()
	self:UpdateRoster()
	self:ReportChannels()
	if UnitName("player") == "Dyaxler" or UnitName("player") == "Minidyax" then
		--PP_DebugEnabled = true
		--if not self.isBCC then
			--LCD:ToggleDebug()
		--end
	end
end

function PallyPower:ZONE_CHANGED()
	if IsInRaid() then
		self.zone = GetRealZoneText()
		self:UpdateLayout()
		self:UpdateRoster()
	end
end

function PallyPower:ZONE_CHANGED_NEW_AREA()
	if IsInRaid() then
		self.zone = GetRealZoneText()
		self:UpdateLayout()
		self:UpdateRoster()
	end
end

function PallyPower:CHAT_MSG_ADDON(event, prefix, message, distribution, source)
	local sender = Ambiguate(source, "none")
	if prefix == self.commPrefix then
	--self:Debug("[EVENT: CHAT_MSG_ADDON] prefix: "..prefix.." | message: "..message.." | distribution: "..distribution.." | sender: "..sender)
	end
	if prefix == self.commPrefix and (distribution == "PARTY" or distribution == "RAID" or distribution == "INSTANCE_CHAT" or distribution == "WHISPER") and sender then
		self:ParseMessage(sender, message)
	end
end

function PallyPower:GROUP_JOINED(event)
	--self:Debug("[Event] GROUP_JOINED")
	AllPallys = {}
	SyncList = {}
	PallyPower_NormalAssignments = {}
	self:ScanSpells()
	self:ScanCooldowns()
	self:ScanInventory()
	C_Timer.After(
		2.0,
		function()
			self:SendSelf()
			self:SendMessage("REQ")
			self:UpdateLayout()
			self:UpdateRoster()
		end
	)
	self.zone = GetRealZoneText()
end

function PallyPower:GROUP_LEFT(event)
	--self:Debug("[Event] GROUP_LEFT")
	AllPallys = {}
	SyncList = {}
	PallyPower_NormalAssignments = {}
	for pname in pairs(PallyPower_Assignments) do
		local match = false
		if pname == self.player then
			match = true
		end
		for i = 1, GetNumGuildMembers() do
			local name = Ambiguate(GetGuildRosterInfo(i), "short")
			if pname == name then
				match = true
				break
			end
		end
		if match == false then
			PallyPower_Assignments[pname] = nil
		end
	end
	self:ScanSpells()
	self:ScanCooldowns()
	self:ScanInventory()
	self:UpdateLayout()
	self:UpdateRoster()
end

function PallyPower:CHAT_MSG_SYSTEM(event, text)
	if not initialized then
		return
	end
	if text then
		if strfind(text, "leaves the party.") or strfind(text, "has left the raid group") or strfind(text, "has left the instance group.") then
			local _, _, pname = strfind(text, "(.+) leaves the party.")
			local _, _, rname = strfind(text, "(.+) has left the raid group")
			local _, _, bgname = strfind(text, "(.+) has left the instance group.")
			local playerName
			if pname then
				playerName = pname
			elseif rname then
				playerName = rname
			elseif bgname then
				playerName = bgname
			end
			for name in pairs(AllPallys) do
				if name == playerName then
					C_Timer.After(
						2.0,
						function()
							AllPallys = {}
							SyncList = {}
							self:ScanSpells()
							self:ScanCooldowns()
							self:ScanInventory()
							self:SendSelf()
							self:SendMessage("REQ")
							self:UpdateLayout()
							self:UpdateRoster()
						end
					)
				end
			end
		end
	end
end

function PallyPower:UNIT_AURA(event, unitTarget)
	local ShowPets = self.opt.ShowPets
	local isPet = unitTarget:find("pet")
	local pclass = select(2, UnitClass(unitTarget))
	if ShowPets then
		if isPet and (pclass == "MAGE" or pclass == "PALADIN") then --Warlock Imp or Succubus pet
			self:UpdateLayout()
			self:UpdateRoster()
			--self:Debug("EVENT: UNIT_AURA - [Warlock Imp Changed Phase]")
		end
	end
end

function PallyPower:UNIT_SPELLCAST_SUCCEEDED(event, unitTarget, castGUID, spellID)
	if select(2, UnitClass(unitTarget)) == "PALADIN" then
		for _, spells in pairs(self.Cooldowns) do
			for _, spell in pairs(spells) do
				if spellID == spell then
					C_Timer.After(
						2.0,
						function()
							PallyPower:ScanCooldowns()
							if GetNumGroupMembers() > 0 then
								PallyPower:SendSelf()
							end
						end
					)
				end
			end
		end
	end
end

function PallyPower:PLAYER_ROLES_ASSIGNED(event)
	--self:Debug("[Event] PLAYER_ROLES_ASSIGNED")
	C_Timer.After(
		2.0,
		function()
			for name in pairs(leaders) do
				PP_Leader = false
				if name == self.player then
					self:SendSelf()
				end
			end
		end
	)
end

function PallyPower:ParseMessage(sender, msg)
	sender = self:RemoveRealmName(sender)

	if strfind(msg, "^PPLEADER") then
		local _, _, name = strfind(msg, "^PPLEADER (.*)")
		name = self:RemoveRealmName(name)
		if self:CheckLeader(name) then
			PP_Leader = true
		end
	end

	if (sender == self.player or sender == nil) or not initialized then return end

	--self:Debug("[Parse Message] sender: " .. sender .. " | msg: " .. msg)

	local leader = self:CheckLeader(sender)

	if msg == "REQ" then
		if IsInRaid() and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then
			self:SendSelf()
		else
			self:SendSelf(sender)
		end
	end

	if strfind(msg, "^SELF") then
		PallyPower_NormalAssignments[sender] = {}
		PallyPower_Assignments[sender] = {}
		AllPallys[sender] = {}
		self:SyncAdd(sender)
		local _, _, numbers, assign = strfind(msg, "SELF ([0-9n]*)@([0-9n]*)")
		for i = 1, 6 do
			local rank = strsub(numbers, (i - 1) * 2 + 1, (i - 1) * 2 + 1)
			local talent = strsub(numbers, (i - 1) * 2 + 2, (i - 1) * 2 + 2)
			if rank ~= "n" then
				AllPallys[sender][i] = {}
				AllPallys[sender][i].rank = tonumber(rank)
				AllPallys[sender][i].talent = tonumber(talent)
			end
		end
		if assign then
			for i = 1, PALLYPOWER_MAXCLASSES do
				local tmp = strsub(assign, i, i)
				if tmp == "n" or tmp == "" then
					tmp = 0
				end
				PallyPower_Assignments[sender][i] = tmp + 0
			end
		end
	end

	if strfind(msg, "^ASSIGN") then
		local _, _, name, class, skill = strfind(msg, "^ASSIGN (.*) (.*) (.*)")
		name = self:RemoveRealmName(name)
		if name ~= sender and not (leader or self.opt.freeassign) then
			return false
		end
		if not PallyPower_Assignments[name] then
			PallyPower_Assignments[name] = {}
		end
		class = class + 0
		skill = skill + 0
		PallyPower_Assignments[name][class] = skill
	end

	if strfind(msg, "^PASSIGN") then
		local _, _, name, assign = strfind(msg, "^PASSIGN (.*)@([0-9n]*)")
		name = self:RemoveRealmName(name)
		if name ~= sender and not (leader or self.opt.freeassign) then
			return false
		end
		if not PallyPower_Assignments[name] then
			PallyPower_Assignments[name] = {}
		end
		if assign then
			for i = 1, PALLYPOWER_MAXCLASSES do
				local tmp = strsub(assign, i, i)
				if tmp == "n" or tmp == "" then
					tmp = 0
				end
				PallyPower_Assignments[name][i] = tmp + 0
			end
		end
	end

	if strfind(msg, "^NASSIGN") then
		for pname, class, tname, skill in string.gmatch(strsub(msg, 9), "([^@]*) ([^@]*) ([^@]*) ([^@]*)") do
			local name = self:RemoveRealmName(pname)
			if name ~= sender and not (leader or self.opt.freeassign) then
				return
			end
			if not PallyPower_NormalAssignments[name] then
				PallyPower_NormalAssignments[name] = {}
			end
			class = class + 0
			if not PallyPower_NormalAssignments[name][class] then
				PallyPower_NormalAssignments[name][class] = {}
			end
			skill = skill + 0
			if skill == 0 then
				skill = nil
			end
			PallyPower_NormalAssignments[name][class][tname] = skill
		end
	end

	if strfind(msg, "^MASSIGN") then
		local _, _, name, skill = strfind(msg, "^MASSIGN (.*) (.*)")
		name = self:RemoveRealmName(name)
		if name ~= sender and not (leader or self.opt.freeassign) then
			return false
		end
		if not PallyPower_Assignments[name] then
			PallyPower_Assignments[name] = {}
		end
		skill = skill + 0
		for i = 1, PALLYPOWER_MAXCLASSES do
			PallyPower_Assignments[name][i] = skill
		end
	end

	if strfind(msg, "SYMCOUNT") then
		local _, _, symcount = strfind(msg, "SYMCOUNT ([0-9]*)")
		if AllPallys[sender] then
			if symcount == nil or symcount == "0" then
				AllPallys[sender].symbols = 0
			else
				AllPallys[sender].symbols = symcount
			end
		end
	end

	if strfind(msg, "COOLDOWNS") then
		local _, duration1, remaining1, duration2, remaining2 = strsplit(":", msg)
		if AllPallys[sender] then
			if not AllPallys[sender].CooldownInfo then
				AllPallys[sender].CooldownInfo = {}
			end
			if not AllPallys[sender].CooldownInfo[1] and remaining1 ~= "n" then
				AllPallys[sender].CooldownInfo[1] = {}
				duration1 = tonumber(duration1)
				remaining1 = tonumber(remaining1)
				AllPallys[sender].CooldownInfo[1].start = GetTime() - (duration1 - remaining1)
				AllPallys[sender].CooldownInfo[1].duration = duration1
			end
			if not AllPallys[sender].CooldownInfo[2] and remaining2 ~= "n" then
				AllPallys[sender].CooldownInfo[2] = {}
				duration2 = tonumber(duration2)
				remaining2 = tonumber(remaining2)
				AllPallys[sender].CooldownInfo[2].start = GetTime() - (duration2 - remaining2)
				AllPallys[sender].CooldownInfo[2].duration = duration2
			end
		end
	end

	if strfind(msg, "^CLEAR") then
		if leader then
			self:ClearAssignments(sender)
		elseif self.opt.freeassign then
			self:ClearAssignments(self.player)
		end
	end

	if strfind(msg, "FREEASSIGN YES") and AllPallys[sender] then
		AllPallys[sender].freeassign = true
	end

	if strfind(msg, "FREEASSIGN NO") and AllPallys[sender] then
		AllPallys[sender].freeassign = false
	end

	if strfind(msg, "^ASELF") then
		PallyPower_AuraAssignments[sender] = 0
		if AllPallys[sender] then
			if not AllPallys[sender].AuraInfo then
				AllPallys[sender].AuraInfo = {}
			end
			local _, _, numbers, assign = strfind(msg, "ASELF ([0-9a-fn]*)@([0-9n]*)")
			for i = 1, PALLYPOWER_MAXAURAS do
				local rank = strsub(numbers, (i - 1) * 2 + 1, (i - 1) * 2 + 1)
				local talent = strsub(numbers, (i - 1) * 2 + 2, (i - 1) * 2 + 2)
				if rank ~= "n" then
					AllPallys[sender].AuraInfo[i] = {}
					AllPallys[sender].AuraInfo[i].rank = tonumber(rank, 16)
					AllPallys[sender].AuraInfo[i].talent = tonumber(talent, 16)
				end
			end
			if assign then
				if assign == "n" or assign == "" then
					assign = 0
				end
				PallyPower_AuraAssignments[sender] = assign + 0
			end
		end
	end

	if strfind(msg, "^AASSIGN") then
		local _, _, name, aura = strfind(msg, "^AASSIGN (.*) (.*)")
		name = self:RemoveRealmName(name)
		if name ~= sender and not (leader or self.opt.freeassign) then
			return false
		end
		if not PallyPower_AuraAssignments[name] then
			PallyPower_AuraAssignments[name] = {}
		end
		aura = aura + 0
		PallyPower_AuraAssignments[name] = aura
	end

	self:UpdateLayout()
end

function PallyPower:CanControl(name)
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then
		return (name == self.player) or (AllPallys[name] and (AllPallys[name].freeassign == true))
	else
		if UnitIsGroupLeader(self.player) or UnitIsGroupAssistant(self.player) then
			return true
		else
			return (name == self.player) or (AllPallys[name] and (AllPallys[name].freeassign == true))
		end
	end
end

function PallyPower:CheckLeader(nick)
	if leaders[nick] == true then
		return true
	else
		return false
	end
end

function PallyPower:CheckMainTanks(nick)
	return raidmaintanks[nick]
end

function PallyPower:CheckMainAssists(nick)
	return raidmainassists[nick]
end

function PallyPower:ClearAssignments(sender)
	local leader = self:CheckLeader(sender)
	for name in pairs(PallyPower_Assignments) do
		if leader or name == self.player then
			for i = 1, PALLYPOWER_MAXCLASSES do
				PallyPower_Assignments[name][i] = 0
			end
		end
	end
	for pname, classes in pairs(PallyPower_NormalAssignments) do
		if leader or pname == self.player then
			for _, tnames in pairs(classes) do
				for tname in pairs(tnames) do
					tnames[tname] = nil
				end
			end
		end
	end
	for name in pairs(PallyPower_AuraAssignments) do
		if leader or name == self.player then
			PallyPower_AuraAssignments[name] = 0
		end
	end
end

function PallyPower:SyncClear()
	SyncList = {}
end

function PallyPower:SyncAdd(name)
	local chk = 0
	for _, v in ipairs(SyncList) do
		if v == name then
			chk = 1
		end
	end
	if chk == 0 then
		tinsert(SyncList, name)
		tsort(
			SyncList,
			function(a, b)
				return a < b
			end
		)
	end
end

function PallyPower:FormatTime(time)
	if not time or time < 0 or time == 9999 then
		return ""
	end
	local mins = floor(time / 60)
	local secs = time - (mins * 60)
	return format("%d:%02d", mins, secs)
end

function PallyPower:AddRealmName(unitID)
	local name, realm = strsplit("%-", unitID)
	realm = realm or self.realm

	return name .. "-" .. realm
end

function PallyPower:RemoveRealmName(unitID)
	local name, realm = strsplit("%-", unitID)
	if realm and realm ~= self.realm then
		return unitID
	else
		return name
	end
end

function PallyPower:GetClassID(class)
	for id, name in pairs(self.ClassID) do
		if (name == class) then
			return id
		end
	end
	return -1
end

function PallyPower:UpdateRoster()
	--self:Debug("UpdateRoster()")
	local units, class, raidtank
	for i = 1, PALLYPOWER_MAXCLASSES do
		classlist[i] = 0
		classes[i] = {}
	end
	if IsInRaid() then
		units = raid_units
	else
		units = party_units
	end
	twipe(roster)
	twipe(leaders)
	for _, unitid in pairs(units) do
		if unitid and UnitExists(unitid) then
			local tmp = {}
			tmp.unitid = unitid
			tmp.name = GetUnitName(unitid, true)
			local ShowPets = self.opt.ShowPets
			local isPet = tmp.unitid:find("pet")
			local pclass = select(2, UnitClass(unitid))
			if ShowPets or (not isPet) then
				if isPet and pclass == "MAGE" then --Warlock Imp pet
					local i = 1
					local name, icon = UnitBuff(unitid, i)
					local isPhased = false
					while name do
						if icon == 136164 then
							--self:Debug("isPet [isPhased]: "..tmp.name)
							isPhased = true
							break
						end
						i = i + 1
						name, icon = UnitBuff(unitid, i)
					end
					if not isPhased then
						--self:Debug("isPet [notPhased]: "..tmp.name)
						tmp.class = "PET"
					end
				elseif isPet then -- All other pet's
					if (pclass == "PALADIN" and IsInRaid()) then
						-- Hide Succubus while in raids (they generally always get sacrificed)
						tmp.class = ""
					else
						--self:Debug("isPet: "..tmp.name)
						tmp.class = "PET"
					end
				else --Players
					--self:Debug("isPlayer: "..tmp.name)
					tmp.class = pclass
				end
			end
			if IsInRaid() and (not isPet) then
				local n = select(3, unitid:find("(%d+)"))
				tmp.name, tmp.rank, tmp.subgroup = GetRaidRosterInfo(n)
				tmp.zone = select(7, GetRaidRosterInfo(n))
				raidtank = select(10, GetRaidRosterInfo(n))
				class = self:GetClassID(pclass)
				-- Warriors
				if (class == 1) then
					if (raidmaintanks[tmp.name] == true) then
						if PallyPower_NormalAssignments[self.player] and PallyPower_NormalAssignments[self.player][class] and PallyPower_NormalAssignments[self.player][class][tmp.name] == self.opt.mainTankSpellsW then
							if PallyPower_Assignments[self.player] and PallyPower_Assignments[self.player][class] == self.opt.mainTankGSpellsW and (raidtank == "MAINTANK" and self.opt.mainTank) then
							else
								SetNormalBlessings(self.player, class, tmp.name, 0)
								raidmaintanks[tmp.name] = false
							end
						end
					end
					if (raidmainassists[tmp.name] == true) then
						if PallyPower_NormalAssignments[self.player] and PallyPower_NormalAssignments[self.player][class] and PallyPower_NormalAssignments[self.player][class][tmp.name] == self.opt.mainAssistSpellsW then
							if PallyPower_Assignments[self.player] and PallyPower_Assignments[self.player][class] == self.opt.mainAssistGSpellsW and (raidtank == "MAINASSIST" and self.opt.mainAssist) then
							else
								SetNormalBlessings(self.player, class, tmp.name, 0)
								raidmainassists[tmp.name] = false
							end
						end
					end
					if (raidtank == "MAINTANK" and self.opt.mainTank) then
						if (PallyPower_Assignments[self.player] and PallyPower_Assignments[self.player][class] == self.opt.mainTankGSpellsW and (raidmaintanks[tmp.name] == false or raidmaintanks[tmp.name] == nil)) or (PallyPower_NormalAssignments[self.player] and PallyPower_NormalAssignments[self.player][class] and PallyPower_NormalAssignments[self.player][class][tmp.name] ~= self.opt.mainTankSpellsW and raidmaintanks[tmp.name] == true) then
							SetNormalBlessings(self.player, class, tmp.name, self.opt.mainTankSpellsW)
							raidmaintanks[tmp.name] = true
						end
					end
					if (raidtank == "MAINASSIST" and self.opt.mainAssist) then
						if (PallyPower_Assignments[self.player] and PallyPower_Assignments[self.player][class] == self.opt.mainAssistGSpellsW and (raidmainassists[tmp.name] == false or raidmainassists[tmp.name] == nil)) or (PallyPower_NormalAssignments[self.player] and PallyPower_NormalAssignments[self.player][class] and PallyPower_NormalAssignments[self.player][class][tmp.name] ~= self.opt.mainAssistSpellsW and raidmainassists[tmp.name] == true) then
							SetNormalBlessings(self.player, class, tmp.name, self.opt.mainAssistSpellsW)
							raidmainassists[tmp.name] = true
						end
					end
				end
				-- Druids and Paladins
				if (class == 4 or class == 5) then
					if (raidmaintanks[tmp.name] == true) then
						if PallyPower_NormalAssignments[self.player] and PallyPower_NormalAssignments[self.player][class] and PallyPower_NormalAssignments[self.player][class][tmp.name] == self.opt.mainTankSpellsDP then
							if PallyPower_Assignments[self.player] and PallyPower_Assignments[self.player][class] == self.opt.mainTankGSpellsDP and (raidtank == "MAINTANK" and self.opt.mainTank) then
							else
								SetNormalBlessings(self.player, class, tmp.name, 0)
								raidmaintanks[tmp.name] = false
							end
						end
					end
					if (raidmainassists[tmp.name] == true) then
						if PallyPower_NormalAssignments[self.player] and PallyPower_NormalAssignments[self.player][class] and PallyPower_NormalAssignments[self.player][class][tmp.name] == self.opt.mainAssistSpellsDP then
							if PallyPower_Assignments[self.player] and PallyPower_Assignments[self.player][class] == self.opt.mainAssistGSpellsDP and (raidtank == "MAINASSIST" and self.opt.mainAssist) then
							else
								SetNormalBlessings(self.player, class, tmp.name, 0)
								raidmainassists[tmp.name] = false
							end
						end
					end
					if (raidtank == "MAINTANK" and self.opt.mainTank) then
						if (PallyPower_Assignments[self.player] and PallyPower_Assignments[self.player][class] == self.opt.mainTankGSpellsDP and (raidmaintanks[tmp.name] == false or raidmaintanks[tmp.name] == nil)) or (PallyPower_NormalAssignments[self.player] and PallyPower_NormalAssignments[self.player][class] and PallyPower_NormalAssignments[self.player][class][tmp.name] ~= self.opt.mainTankSpellsDP and raidmaintanks[tmp.name] == true) then
							if (self.player == tmp.name and self.opt.mainTankSpellsDP == 7) then
								SetNormalBlessings(self.player, class, tmp.name, 0)
							else
								SetNormalBlessings(self.player, class, tmp.name, self.opt.mainTankSpellsDP)
							end
							raidmaintanks[tmp.name] = true
						end
					end
					if (raidtank == "MAINASSIST" and self.opt.mainAssist) then
						if (PallyPower_Assignments[self.player] and PallyPower_Assignments[self.player][class] == self.opt.mainAssistGSpellsDP and (raidmainassists[tmp.name] == false or raidmainassists[tmp.name] == nil)) or (PallyPower_NormalAssignments[self.player] and PallyPower_NormalAssignments[self.player][class] and PallyPower_NormalAssignments[self.player][class][tmp.name] ~= self.opt.mainAssistSpellsDP and raidmainassists[tmp.name] == true) then
							if (self.player == tmp.name and self.opt.mainTankSpellsDP == 7) then
								SetNormalBlessings(self.player, class, tmp.name, 0)
							else
								SetNormalBlessings(self.player, class, tmp.name, self.opt.mainAssistSpellsDP)
							end
							raidmainassists[tmp.name] = true
						end
					end
				end

				if classmaintanks[unitid] == true then
					classmaintanks[unitid] = nil
					classmaintanks[class] = nil
				end

				if (raidtank == "MAINTANK" and (class == 1 or class == 4 or class == 5)) then
					classmaintanks[unitid] = true
					classmaintanks[class] = true
				end
			else
				tmp.rank = UnitIsGroupLeader(unitid) and 2 or 0
				tmp.subgroup = 1
			end
			if pclass == "PALADIN" and (not isPet) then
				if AllPallys[tmp.name] then
					AllPallys[tmp.name].subgroup = tmp.subgroup
				end
			end
			if tmp.name and (tmp.rank > 0) then
				if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then
				else
					leaders[tmp.name] = true
					if tmp.name == self.player and PP_Leader == false then
						PP_Leader = true
					end
				end
			end
			if tmp.subgroup then
				tinsert(roster, tmp)
				for i = 1, PALLYPOWER_MAXCLASSES do
					if tmp.class == self.ClassID[i] then
						tmp.visible = false
						tmp.hasbuff = false
						tmp.specialbuff = false
						tmp.dead = false
						classlist[i] = classlist[i] + 1
						tinsert(classes[i], tmp)
					end
				end
			end
		end
	end
	self:UpdateLayout()
end

function PallyPower:ScanClass(classID)
	local class = classes[classID]
	local hasBuffs = false
	for _, unit in pairs(class) do
		if unit.unitid then
			local spellID, gspellID = self:GetSpellID(classID, unit.name)
			local spell = self.Spells[spellID]
			local spell2 = self.GSpells[spellID]
			local gspell = self.GSpells[gspellID]
			if IsInRaid() then
				local n = select(3, unit.unitid:find("(%d+)"))
				if unit.zone then
					unit.zone = select(7, GetRaidRosterInfo(n))
				end
			end
			unit.inrange = IsSpellInRange(spell, unit.unitid) == 1
			unit.visible = UnitIsVisible(unit.unitid) and UnitIsConnected(unit.unitid)
			unit.dead = UnitIsDeadOrGhost(unit.unitid)
			unit.hasbuff = self:IsBuffActive(spell, spell2, unit.unitid)
			unit.specialbuff = spellID ~= gspellID
			if unit.hasbuff then
				hasBuffs = true
			end
		end
	end
	return hasBuffs
end

function PallyPower:CreateLayout()
	--self:Debug("CreateLayout()")
	self.Header = _G["PallyPowerFrame"]
	self.autoButton = CreateFrame("Button", "PallyPowerAuto", self.Header, "SecureHandlerShowHideTemplate, SecureHandlerEnterLeaveTemplate, SecureHandlerStateTemplate, SecureActionButtonTemplate, PallyPowerAutoButtonTemplate")
	self.autoButton:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	self.rfButton = CreateFrame("Button", "PallyPowerRF", self.Header, "PallyPowerRFButtonTemplate")
	self.rfButton:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	self.auraButton = CreateFrame("Button", "PallyPowerAura", self.Header, "PallyPowerAuraButtonTemplate")
	self.auraButton:RegisterForClicks("LeftButtonDown")
	self.classButtons = {}
	self.playerButtons = {}
	self.autoButton:Execute([[childs = table.new()]])
	for cbNum = 1, PALLYPOWER_MAXCLASSES do
		-- create class buttons
		local cButton = CreateFrame("Button", "PallyPowerC" .. cbNum, self.Header, "SecureHandlerShowHideTemplate, SecureHandlerEnterLeaveTemplate, SecureHandlerStateTemplate, SecureActionButtonTemplate, PallyPowerButtonTemplate")
		SecureHandlerSetFrameRef(self.autoButton, "child", cButton)
		SecureHandlerExecute(self.autoButton, [[
			local child = self:GetFrameRef("child")
			childs[#childs+1] = child;
		]])
		cButton:Execute([[others = table.new()]])
		cButton:Execute([[childs = table.new()]])
		cButton:SetAttribute("_onenter", [[
			for _, other in ipairs(others) do
					other:SetAttribute("state-inactive", self)
			end
			local leadChild;
			for _, child in ipairs(childs) do
					if child:GetAttribute("Display") == 1 then
							child:Show()
							if (leadChild) then
									leadChild:AddToAutoHide(child)
							else
									leadChild = child
									leadChild:RegisterAutoHide(2)
							end
					end
			end
			if (leadChild) then
					leadChild:AddToAutoHide(self)
			end
		]])
		cButton:SetAttribute("_onstate-inactive", [[
			childs[1]:Hide()
		]])
		cButton:RegisterForClicks("LeftButtonDown", "RightButtonDown")
		cButton:EnableMouseWheel(1)
		self.classButtons[cbNum] = cButton
		self.playerButtons[cbNum] = {}
		local pButtons = self.playerButtons[cbNum]
		local leadChild
		for pbNum = 1, PALLYPOWER_MAXPERCLASS do
			local pButton = CreateFrame("Button", "PallyPowerC" .. cbNum .. "P" .. pbNum, UIParent, "SecureHandlerShowHideTemplate, SecureHandlerEnterLeaveTemplate, SecureActionButtonTemplate, PallyPowerPopupTemplate")
			pButton:SetParent(cButton)
			SecureHandlerSetFrameRef(cButton, "child", pButton)
			SecureHandlerExecute(cButton, [[
				local child = self:GetFrameRef("child")
				childs[#childs+1] = child;
			]])
			if pbNum == 1 then
				pButton:Execute([[siblings = table.new()]])
				pButton:SetAttribute("_onhide", [[
					for _, sibling in ipairs(siblings) do
						sibling:Hide()
					end
				]])
				leadChild = pButton
			else
				SecureHandlerSetFrameRef(leadChild, "sibling", pButton)
				SecureHandlerExecute(leadChild, [[
					local sibling = self:GetFrameRef("sibling")
					siblings[#siblings+1] = sibling;
				]])
			end
			pButton:RegisterForClicks("LeftButtonDown", "RightButtonDown")
			pButton:EnableMouseWheel(1)
			pButton:Hide()
			pButtons[pbNum] = pButton
		end -- by pbNum
	end -- by classIndex
	for cbNum = 1, PALLYPOWER_MAXCLASSES do
		local cButton = self.classButtons[cbNum]
		for cbOther = 1, PALLYPOWER_MAXCLASSES do
			if (cbOther ~= cbNum) then
				local oButton = self.classButtons[cbOther]
				SecureHandlerSetFrameRef(cButton, "other", oButton)
				SecureHandlerExecute(cButton, [[
					local other = self:GetFrameRef("other")
					others[#others+1] = other;
				]])
			end
		end
	end
	self:UpdateLayout()
end

function PallyPower:CountClasses()
	local val = 0
	if not classes then
		return 0
	end
	for i = 1, PALLYPOWER_MAXCLASSES do
		if classlist[i] and classlist[i] > 0 then
			val = val + 1
		end
	end
	return val
end

function PallyPower:UpdateLayout()
	--self:Debug("UpdateLayout()")
	if InCombatLockdown() then return end

	PallyPowerFrame:SetScale(self.opt.buffscale)
	local x = self.opt.display.buttonWidth
	local y = self.opt.display.buttonHeight
	local point = "TOPLEFT"
	local pointOpposite = "BOTTOMLEFT"
	local layout = self.Layouts[self.opt.layout]
	for cbNum = 1, PALLYPOWER_MAXCLASSES do
		local cx = layout.c[cbNum].x
		local cy = layout.c[cbNum].y
		local cButton = self.classButtons[cbNum]
		self:SetButton("PallyPowerC" .. cbNum)
		cButton.x = cx * x
		cButton.y = cy * y
		cButton:ClearAllPoints()
		cButton:SetPoint(point, self.Header, "CENTER", cButton.x, cButton.y)
		local pButtons = self.playerButtons[cbNum]
		for pbNum = 1, PALLYPOWER_MAXPERCLASS do
			local px = layout.c[cbNum].p[pbNum].x
			local py = layout.c[cbNum].p[pbNum].y
			local pButton = pButtons[pbNum]
			self:SetPButton("PallyPowerC" .. cbNum .. "P" .. pbNum)
			pButton:ClearAllPoints()
			pButton:SetPoint(point, self.Header, "CENTER", cButton.x + px * x, cButton.y + py * y)
		end
	end
	local ox = layout.ab.x * x
	local oy = layout.ab.y * y
	local autob = self.autoButton
	autob:ClearAllPoints()
	autob:SetPoint(point, self.Header, "CENTER", ox, oy)
	autob:SetAttribute("type", "spell")
	if isPally and self.opt.enabled and self.opt.autobuff.autobutton and ((GetNumGroupMembers() == 0 and self.opt.ShowWhenSolo) or (GetNumGroupMembers() > 0 and self.opt.ShowInParty)) then
		autob:Show()
	else
		autob:Hide()
	end
	local rfb = self.rfButton
	if self.opt.autobuff.autobutton then
		ox = layout.rf.x * x
		oy = layout.rf.y * y
		rfb:ClearAllPoints()
		rfb:SetPoint(point, self.Header, "CENTER", ox, oy)
	else
		ox = layout.rfd.x * x
		oy = layout.rfd.y * y
		rfb:ClearAllPoints()
		rfb:SetPoint(point, self.Header, "CENTER", ox, oy)
	end
	rfb:SetAttribute("type1", "spell")
	rfb:SetAttribute("unit1", "player")
	self:RFAssign(self.opt.rf)
	rfb:SetAttribute("type2", "spell")
	rfb:SetAttribute("unit2", "player")
	self:SealAssign(self.opt.seal)
	if isPally and self.opt.enabled and self.opt.rfbuff and ((GetNumGroupMembers() == 0 and self.opt.ShowWhenSolo) or (GetNumGroupMembers() > 0 and self.opt.ShowInParty)) then
		rfb:Show()
	else
		rfb:Hide()
	end
	local auraBtn = self.auraButton
	if (not self.opt.autobuff.autobutton and self.opt.rfbuff) or (self.opt.autobuff.autobutton and not self.opt.rfbuff) then
		ox = layout.aud1.x * x
		oy = layout.aud1.y * y
		auraBtn:ClearAllPoints()
		auraBtn:SetPoint(point, self.Header, "CENTER", ox, oy)
	elseif not self.opt.autobuff.autobutton and not self.opt.rfbuff then
		ox = layout.aud2.x * x
		oy = layout.aud2.y * y
		auraBtn:ClearAllPoints()
		auraBtn:SetPoint(point, self.Header, "CENTER", ox, oy)
	else
		ox = layout.au.x * x
		oy = layout.au.y * y
		auraBtn:ClearAllPoints()
		auraBtn:SetPoint(point, self.Header, "CENTER", ox, oy)
	end
	auraBtn:SetAttribute("type1", "spell")
	auraBtn:SetAttribute("unit1", "player")
	if self.opt.auras then
		self:UpdateAuraButton(PallyPower_AuraAssignments[self.player])
	end
	if isPally and self.opt.enabled and self.opt.auras and AllPallys[self.player].AuraInfo[1] and ((GetNumGroupMembers() == 0 and self.opt.ShowWhenSolo) or (GetNumGroupMembers() > 0 and self.opt.ShowInParty)) then
		auraBtn:Show()
	else
		auraBtn:Hide()
	end
	local cbNum = 0
	for classIndex = 1, PALLYPOWER_MAXCLASSES do
		local _, gspellID = self:GetSpellID(classIndex)
		if (classlist[classIndex] and classlist[classIndex] ~= 0 and (gspellID ~= 0 or self:NormalBlessingCount(classIndex) > 0)) then
			cbNum = cbNum + 1
			local cButton = self.classButtons[cbNum]
			if isPally and self.opt.enabled and self.opt.display.showClassButtons and ((GetNumGroupMembers() == 0 and self.opt.ShowWhenSolo) or (GetNumGroupMembers() > 0 and self.opt.ShowInParty)) then
				cButton:Show()
			else
				cButton:Hide()
			end
			cButton:SetAttribute("Display", 1)
			cButton:SetAttribute("classID", classIndex)
			cButton:SetAttribute("type1", "macro")
			cButton:SetAttribute("type2", "macro")
			if (cButton:GetAttribute("macrotext1") == nil) then
				if IsInRaid() then
					PallyPower:ButtonPostClick(cButton, "LeftButton")
				else
					PallyPower:ButtonPreClick(cButton, "LeftButton")
				end
			end
			local pButtons = self.playerButtons[cbNum]
			for pbNum = 1, math.min(classlist[classIndex], PALLYPOWER_MAXPERCLASS) do
				local pButton = pButtons[pbNum]
				if self.opt.display.showPlayerButtons then
					pButton:SetAttribute("Display", 1)
				else
					pButton:SetAttribute("Display", 0)
				end
				pButton:SetAttribute("classID", classIndex)
				pButton:SetAttribute("playerID", pbNum)
				local unit = self:GetUnit(classIndex, pbNum)
				local spellID, gspellID = self:GetSpellID(classIndex, unit.name)
				local nSpell, gSpell = self:CanBuffBlessing(spellID, gspellID, unit.unitid)
				-- Greater Blessings (Left Mouse Button [1]) - disable Greater Blessing of Salvation globally. Enabled in PButtonPreClick().
				pButton:SetAttribute("type1", "spell")
				pButton:SetAttribute("unit1", unit.unitid)
				if IsInRaid() and gspellID == 4 and (classIndex == 1 or classIndex == 4 or classIndex == 5) and not self.opt.SalvInCombat then
					pButton:SetAttribute("spell1", nil)
				else
					pButton:SetAttribute("spell1", gSpell)
				end
				-- Set Maintank role in a raid
				if IsInRaid() then
					pButton:SetAttribute("ctrl-type1", "maintank")
					pButton:SetAttribute("ctrl-action1", "toggle")
					pButton:SetAttribute("ctrl-unit1", unit.unitid)
				end
				-- Normal Blessings (Right Mouse Button [2]) - disable Normal Blessing of Salvation globally. Enabled in PButtonPreClick().
				pButton:SetAttribute("type2", "spell")
				pButton:SetAttribute("unit2", unit.unitid)
				if IsInRaid() and spellID == 4 and (classIndex == 1 or classIndex == 4 or classIndex == 5) and not self.opt.SalvInCombat then
					pButton:SetAttribute("spell2", nil)
				else
					pButton:SetAttribute("spell2", nSpell)
				end
				-- Reset Alternate Blessings
				if unit and unit.name and classIndex then
					pButton:SetAttribute("ctrl-type2", "macro")
					pButton:SetAttribute("ctrl-macrotext2", "/run PallyPower_NormalAssignments['" .. self.player .. "'][" .. classIndex .. "]['" .. unit.name .. "'] = nil")
				end
			end
			for pbNum = classlist[classIndex] + 1, PALLYPOWER_MAXPERCLASS do
				local pButton = pButtons[pbNum]
				pButton:SetAttribute("Display", 0)
				pButton:SetAttribute("classID", 0)
				pButton:SetAttribute("playerID", 0)
			end
		end
	end
	cbNum = cbNum + 1
	for i = cbNum, PALLYPOWER_MAXCLASSES do
		local cButton = self.classButtons[i]
		cButton:SetAttribute("Display", 0)
		cButton:SetAttribute("classID", 0)
		cButton:Hide()
		local pButtons = self.playerButtons[cbNum]
		for pbNum = 1, PALLYPOWER_MAXPERCLASS do
			local pButton = pButtons[pbNum]
			pButton:SetAttribute("Display", 0)
			pButton:SetAttribute("classID", 0)
			pButton:SetAttribute("playerID", 0)
			pButton:Hide()
		end
	end
	self:ButtonsUpdate()
	self:UpdateAnchor(displayedButtons)
end

function PallyPower:SetButton(baseName)
	local time = _G[baseName .. "Time"]
	local text = _G[baseName .. "Text"]
	if (self.opt.display.HideCountText) then
		text:Hide()
	else
		text:Show()
	end
	if (self.opt.display.HideTimerText) then
		time:Hide()
	else
		time:Show()
	end
end

function PallyPower:SetPButton(baseName)
	local rng = _G[baseName .. "Rng"]
	local dead = _G[baseName .. "Dead"]
	local name = _G[baseName .. "Name"]
	if (self.opt.display.HideRngText) then
		rng:Hide()
	else
		rng:Show()
	end
	if (self.opt.display.HideDeadText) then
		dead:Hide()
	else
		dead:Show()
	end
	if (self.opt.display.HideNameText) then
		name:Hide()
	else
		name:Show()
	end
end

function PallyPower:UpdateButtonOnPostClick(button, mousebutton)
	local classID = button:GetAttribute("classID")
	if classID and classID > 0 then
		local _, _, cbNum = strfind(button:GetName(), "PallyPowerC(.+)")
		self:UpdateButton(button, "PallyPowerC" .. cbNum, classID)
		self:ButtonsUpdate()
		C_Timer.After(
		1.0,
		function()
			self:UpdateButton(button, "PallyPowerC" .. cbNum, classID)
			self:ButtonsUpdate()
		end
		)
	end
end

function PallyPower:UpdateButton(button, baseName, classID)
	local button = _G[baseName]
	local classIcon = _G[baseName .. "ClassIcon"]
	local buffIcon = _G[baseName .. "BuffIcon"]
	local time = _G[baseName .. "Time"]
	local time2 = _G[baseName .. "Time2"]
	local text = _G[baseName .. "Text"]
	local nneed = 0
	local nspecial = 0
	local nhave = 0
	local ndead = 0
	for _, unit in pairs(classes[classID]) do
		if unit.visible then
			if not unit.hasbuff then
				if unit.specialbuff then
					nspecial = nspecial + 1
				else
					nneed = nneed + 1
				end
			else
				nhave = nhave + 1
			end
		elseif UnitIsConnected(unit.unitid) then
			if unit.hasbuff then
				nhave = nhave + 1
			else
				nneed = nneed + 1
			end
		end
		if unit.dead then
			ndead = ndead + 1
		end
		local isPet = unit.unitid:find("pet")
		if IsInRaid() and (not isPet) then
			local n = select(3, unit.unitid:find("(%d+)"))
			local raidtank
			if n then
				raidtank = select(10, GetRaidRosterInfo(n))
			end
			local spellID, gspellID = self:GetSpellID(classID, unit.name)
			local spell = self.Spells[spellID]
			local spell2 = self.GSpells[spellID]
			local gspell = self.GSpells[gspellID]
			if raidtank == "MAINTANK" then
				local _, _, buffName = self:IsBuffActive(spell, spell2, unit.unitid)
				if (buffName == self.GSpells[4] or buffName == self.Spells[4]) then
					nneed = nneed + 1
					nhave = nhave - 1
					if InCombatLockdown() and (buffName ~= self.Spells[7]) then
						nspecial = nspecial - 1
					end
				elseif (buffName ~= self.GSpells[4] and gspellID == 4) or (buffName ~= self.Spells[4] and spellID == 4) then
					nhave = nhave + 1
					nneed = nneed - 1
				end
				if (buffName ~= self.Spells[7]) and spellID == 7 then
					nneed = nneed + 1
					nspecial = nspecial - 1
				end
			end
			if self.zone ~= unit.zone then
				if unit.hasbuff then
					nhave = nhave + 1
				else
					nneed = nneed - 1
				end
			end
		end
	end
	classIcon:SetTexture(self.ClassIcons[classID])
	classIcon:SetVertexColor(1, 1, 1)
	local _, gspellID = self:GetSpellID(classID)
	buffIcon:SetTexture(self.BlessingIcons[gspellID])
	local classExpire, classDuration, specialExpire, specialDuration = self:GetBuffExpiration(classID)
	time:SetText(self:FormatTime(classExpire))
	time:SetTextColor(self:GetSeverityColor(classExpire and classDuration and classDuration > 0 and (classExpire / classDuration) or 0))
	time2:SetText(self:FormatTime(specialExpire))
	time2:SetTextColor(self:GetSeverityColor(specialExpire and specialDuration and specialDuration > 0 and (specialExpire / specialDuration) or 0))
	if (nneed + nspecial > 0) then
		text:SetText(nneed + nspecial)
	else
		text:SetText("")
	end
	if (nhave == 0) then
		self:ApplyBackdrop(button, self.opt.cBuffNeedAll)
	elseif (nneed > 0) then
		self:ApplyBackdrop(button, self.opt.cBuffNeedSome)
	elseif (nspecial > 0) then
		self:ApplyBackdrop(button, self.opt.cBuffNeedSpecial)
	else
		self:ApplyBackdrop(button, self.opt.cBuffGood)
	end
	if gspellID == 0 then
		if (nspecial > 0) then
			self:ApplyBackdrop(button, self.opt.cBuffNeedSpecial)
		else
			self:ApplyBackdrop(button, self.opt.cBuffGood)
		end
	end
	return classExpire, classDuration, specialExpire, specialDuration, nhave, nneed, nspecial
end

function PallyPower:GetSeverityColor(percent)
	if (percent >= 0.5) then
		return (1.0 - percent) * 2, 1.0, 0.0
	else
		return 1.0, percent * 2, 0.0
	end
end

function PallyPower:GetBuffExpiration(classID)
	local class = classes[classID]
	local classExpire, classDuration, specialExpire, specialDuration = 9999, 9999, 9999, 9999
	for _, unit in pairs(class) do
		if unit.unitid then
			local j = 1
			local spellID, gspellID = self:GetSpellID(classID, unit.name)
			local spell = self.Spells[spellID]
			local gspell = self.GSpells[gspellID]
			local buffName = UnitBuff(unit.unitid, j)
			while buffName do
				if (buffName == gspell) then
					local _, buffDuration, buffExpire
					if self.isBCC then
						_, _, _, _, buffDuration, buffExpire = UnitAura(unit.unitid, j, "HELPFUL")
					else
						_, _, _, _, buffDuration, buffExpire = LCD.UnitAuraWrapper(unit.unitid, j, "HELPFUL")
					end
					if buffExpire then
						if buffExpire == 0 then
							buffExpire = 0
						else
							buffExpire = buffExpire - GetTime()
						end
						classExpire = min(classExpire, buffExpire)
						classDuration = min(classDuration, buffDuration)
						--self:Debug("[GetBuffExpiration] buffName: "..buffName.." | classExpire: "..classExpire.." | classDuration: "..classDuration)
						break
					end
				elseif (buffName == spell) then
					local _, buffDuration, buffExpire
					if self.isBCC then
						_, _, _, _, buffDuration, buffExpire = UnitAura(unit.unitid, j, "HELPFUL")
					else
						_, _, _, _, buffDuration, buffExpire = LCD.UnitAuraWrapper(unit.unitid, j, "HELPFUL")
					end
					if buffExpire then
						if buffExpire == 0 then
							buffExpire = 0
						else
							buffExpire = buffExpire - GetTime()
						end
						specialExpire = min(specialExpire, buffExpire)
						specialDuration = min(specialDuration, buffDuration)
						--self:Debug("[GetBuffExpiration] buffName: "..buffName.." | specialExpire: "..classExpire.." | specialDuration: "..classDuration)
						break
					end
				end
				j = j + 1
				buffName = UnitBuff(unit.unitid, j)
			end
		end
	end
	return classExpire, classDuration, specialExpire, specialDuration
end

function PallyPower:GetRFExpiration()
	local spell = self.RFSpell
	local j = 1
	local rfExpire, rfDuration = 9999, 30 * 60
	local buffName, _, _, _, buffDuration, buffExpire = UnitBuff("player", j)
	while buffExpire do
		if buffName == spell then
			rfExpire = buffExpire - GetTime()
			break
		end
		j = j + 1
		buffName, _, _, _, buffDuration, buffExpire = UnitBuff("player", j)
	end
	return rfExpire, rfDuration
end

function PallyPower:GetSealExpiration()
	local spell = self.Seals[self.opt.seal]
	local j = 1
	local sealExpire, sealDuration = 9999, 30 * 60
	local buffName, _, _, _, buffDuration, buffExpire = UnitBuff("player", j)
	while buffExpire do
		if buffName == spell then
			sealExpire = buffExpire - GetTime()
			break
		end
		j = j + 1
		buffName, _, _, _, buffDuration, buffExpire = UnitBuff("player", j)
	end
	return sealExpire, sealDuration
end

function PallyPower:UpdatePButtonOnPostClick(button, mousebutton)
	local classID = button:GetAttribute("classID")
	local playerID = button:GetAttribute("playerID")
	if classID and playerID then
		local _, _, cbNum, pbNum = strfind(button:GetName(), "PallyPowerC(.+)P(.+)")
		self:UpdatePButton(button, "PallyPowerC" .. cbNum .. "P" .. pbNum, classID, playerID, mousebutton)
		self:ButtonsUpdate()
		C_Timer.After(
			1.0,
			function()
				self:UpdatePButton(button, "PallyPowerC" .. cbNum .. "P" .. pbNum, classID, playerID, mousebutton)
				self:ButtonsUpdate()
			end
		)
	end
end

function PallyPower:PButtonPreClick(button, mousebutton)
	if InCombatLockdown() then return end

	local classID = button:GetAttribute("classID")
	local playerID = button:GetAttribute("playerID")
	if classID and playerID then
		local unit = classes[classID][playerID]
		local spellID, gspellID = self:GetSpellID(classID, unit.name)
		local nSpell, gSpell = self:CanBuffBlessing(spellID, gspellID, unit.unitid)
		-- Enable Greater Blessing of Salvation on everyone but do not allow Blessing of Salvation on tanks if SalvInCombat is disabled
		if IsInRaid() and (spellID == 4 or gspellID == 4) and not self.opt.SalvInCombat then
			for k, v in pairs(classmaintanks) do
				-- If for some reason the targeted unit is in combat and there is a tank present
				-- in the Class Group then disable Greater Blessing of Salvation for this unit.
				if UnitAffectingCombat(unit.unitid) and gspellID == 4 and (k == classID and v == true) then
					gSpell = nil
				end
				if k == unit.unitid and v == true then
					-- Do not allow Salvation on tanks - Blessings [disabled]
					if (spellID == 4) then
						nSpell = nil
					end
					if (gspellID == 4) then
						gSpell = nil
					end
				end
			end
			-- Greater Blessing of Salvation [enabed for non-tanks]
			button:SetAttribute("spell1", gSpell)
			-- Normal Blessing of Salvation [enabed for non-tanks]
			button:SetAttribute("spell2", nSpell)
		end
	end
end

function PallyPower:UpdatePButton(button, baseName, classID, playerID, mousebutton)
	--self:Debug("UpdatePButton()")
	local button = _G[baseName]
	local buffIcon = _G[baseName .. "BuffIcon"]
	local tankIcon = _G[baseName .. "TankIcon"]
	local rng = _G[baseName .. "Rng"]
	local dead = _G[baseName .. "Dead"]
	local name = _G[baseName .. "Name"]
	local time = _G[baseName .. "Time"]
	local unit = classes[classID][playerID]
	local raidtank
	if unit then
		local nneed = 0
		local nspecial = 0
		local nhave = 0
		local ndead = 0
		if unit.visible then
			if not unit.hasbuff then
				if unit.specialbuff then
					nspecial = 1
				end
			else
				nhave = 1
			end
		else
			if unit.hasbuff then
				nhave = 1
			else
				nneed = 1
			end
		end
		if unit.dead then
			ndead = 1
		end
		local spellID, gspellID = self:GetSpellID(classID, unit.name)
		tankIcon:Hide()
		buffIcon:SetTexture(self.BlessingIcons[spellID])
		buffIcon:SetVertexColor(1, 1, 1)
		time:SetText(self:FormatTime(unit.hasbuff))
		local spell = self.Spells[spellID]
		local spell2 = self.GSpells[spellID]
		local gspell = self.GSpells[gspellID]
		local isPet = unit.unitid:find("pet")
		if IsInRaid() and (not isPet) then
			local n = select(3, unit.unitid:find("(%d+)"))
			if n then
				raidtank = select(10, GetRaidRosterInfo(n))
			end
			if raidtank == "MAINTANK" then
				local _, _, buffName = self:IsBuffActive(spell, spell2, unit.unitid)
				tankIcon:Show()
				if buffName == self.GSpells[4] or buffName == self.Spells[4] then
					nhave = 0
					if InCombatLockdown() and (buffName ~= self.Spells[7]) then
						nspecial = 0
					end
				elseif (buffName ~= self.GSpells[4] and gspellID == 4) or (buffName ~= self.Spells[4] and spellID == 4) then
					nhave = 1
				end
				if (buffName ~= self.Spells[7]) and spellID == 7 then
					nspecial = 0
				end
			end
			if self.zone ~= unit.zone then
				if unit.hasbuff then
					nhave = 1
				else
					nneed = 0
				end
			end
		end
		-- The following logic keeps Blessing of Salvation from being assigned to Warrior, Druid and Paladin tanks while in a RAID
		-- and SalvInCombat isn't enabled. Allows Normal Blessing of Salvation on everyone else and all other blessings.
		if not InCombatLockdown() then
			local nSpell, gSpell = self:CanBuffBlessing(spellID, gspellID, unit.unitid)
			-- Normal Blessing of Salvation [enabled] and Greater Blessing of Salvation [disabled] in a raid and SalvInCombat isn't allowed
			if IsInRaid() and (spellID == 4 or gspellID == 4) and not self.opt.SalvInCombat then
				for k, v in pairs(classmaintanks) do
					-- If for some reason the targeted unit is in combat and there is a tank present
					-- in the Class Group then disable Greater Blessing of Salvation for this unit.
					if gspellID == 4 and (k == classID and v == true) then
						-- This assignment is enabled by the PButtonPreClick() function for non-tanks on a per-click basis while not in combat
						gSpell = nil
					end
					if k == unit.unitid and v == true then
						-- Do not allow Salvation on tanks - Blessings [disabled]
						if (spellID == 4) then
							nSpell = nil
						end
						if (gspellID == 4) then
							gSpell = nil
						end
					end
				end
				-- Greater Blessing of Salvation [enabed for non-tanks]
				button:SetAttribute("spell1", gSpell)
				-- Normal Blessing of Salvation [enabed for non-tanks]
				button:SetAttribute("spell2", nSpell)
			else
				-- Greater Blessings [enabled]
				button:SetAttribute("spell1", gSpell)
				-- Normal Blessings [enabled]
				button:SetAttribute("spell2", nSpell)
			end
		end
		if (nspecial == 1) then
			self:ApplyBackdrop(button, self.opt.cBuffNeedSpecial)
		elseif (nhave == 0) then
			self:ApplyBackdrop(button, self.opt.cBuffNeedAll)
		else
			self:ApplyBackdrop(button, self.opt.cBuffGood)
		end
		if unit.hasbuff then
			buffIcon:SetAlpha(1)
			if not unit.visible and not unit.inrange then
				rng:SetVertexColor(1, 0, 0)
				rng:SetAlpha(1)
			elseif unit.visible and not unit.inrange then
				rng:SetVertexColor(1, 1, 0)
				rng:SetAlpha(1)
			else
				rng:SetVertexColor(0, 1, 0)
				rng:SetAlpha(1)
			end
			dead:SetAlpha(0)
		else
			buffIcon:SetAlpha(0.4)
			if not unit.visible and not unit.inrange then
				rng:SetVertexColor(1, 0, 0)
				rng:SetAlpha(1)
			elseif unit.visible and not unit.inrange then
				rng:SetVertexColor(1, 1, 0)
				rng:SetAlpha(1)
			else
				rng:SetVertexColor(0, 1, 0)
				rng:SetAlpha(1)
			end
			if unit.dead then
				dead:SetVertexColor(1, 0, 0)
				dead:SetAlpha(1)
			else
				dead:SetVertexColor(0, 1, 0)
				dead:SetAlpha(0)
			end
		end
		if unit.name then
			local shortname = Ambiguate(unit.name, "short")
			name:SetText(shortname)
		end
	else
		self:ApplyBackdrop(button, self.opt.cBuffGood)
		buffIcon:SetAlpha(0)
		rng:SetAlpha(0)
		dead:SetAlpha(0)
	end
end

function PallyPower:ButtonsUpdate()
	--self:Debug("ButtonsUpdate()")
	local minClassExpire, minClassDuration, minSpecialExpire, minSpecialDuration, sumnhave, sumnneed, sumnspecial = 9999, 9999, 9999, 9999, 0, 0, 0
	for cbNum = 1, PALLYPOWER_MAXCLASSES do -- scan classes and if populated then assign textures, etc
		local cButton = self.classButtons[cbNum]
		local classIndex = cButton:GetAttribute("classID")
		if classIndex > 0 then
			self:ScanClass(classIndex) -- scanning for in-range and buffs
			local classExpire, classDuration, specialExpire, specialDuration, nhave, nneed, nspecial = self:UpdateButton(cButton, "PallyPowerC" .. cbNum, classIndex)
			minClassExpire = min(minClassExpire, classExpire)
			minSpecialExpire = min(minSpecialExpire, specialExpire)
			minClassDuration = min(minClassDuration, classDuration)
			minSpecialDuration = min(minSpecialDuration, specialDuration)
			sumnhave = sumnhave + nhave
			sumnneed = sumnneed + nneed
			sumnspecial = sumnspecial + nspecial
			local pButtons = self.playerButtons[cbNum]
			for pbNum = 1, PALLYPOWER_MAXPERCLASS do
				local pButton = pButtons[pbNum]
				local playerIndex = pButton:GetAttribute("playerID")
				if playerIndex > 0 then
					self:UpdatePButton(pButton, "PallyPowerC" .. cbNum .. "P" .. pbNum, classIndex, playerIndex)
				end
			end -- by pbnum
		end -- class has players
	end -- by cnum
	local autobutton = _G["PallyPowerAuto"]
	local time = _G["PallyPowerAutoTime"]
	local time2 = _G["PallyPowerAutoTime2"]
	local text = _G["PallyPowerAutoText"]
	if (sumnhave == 0) then
		self:ApplyBackdrop(autobutton, self.opt.cBuffNeedAll)
	elseif (sumnneed > 0) then
		self:ApplyBackdrop(autobutton, self.opt.cBuffNeedSome)
	elseif (sumnspecial > 0) then
		self:ApplyBackdrop(autobutton, self.opt.cBuffNeedSpecial)
	else
		self:ApplyBackdrop(autobutton, self.opt.cBuffGood)
	end
	time:SetText(self:FormatTime(minClassExpire))
	time:SetTextColor(self:GetSeverityColor(minClassExpire and minClassDuration and minClassDuration > 0 and (minClassExpire / minClassDuration) or 0))
	time2:SetText(self:FormatTime(minSpecialExpire))
	time2:SetTextColor(self:GetSeverityColor(minSpecialExpire and minSpecialDuration and minSpecialDuration > 0 and (minSpecialExpire / minSpecialDuration) or 0))
	if (sumnneed + sumnspecial > 0) then
		text:SetText(sumnneed + sumnspecial)
	else
		text:SetText("")
	end
	local rfbutton = _G["PallyPowerRF"]
	local time1 = _G["PallyPowerRFTime1"] -- rf timer
	local time2 = _G["PallyPowerRFTime2"] -- seal timer
	local expire1, duration1 = self:GetRFExpiration()
	local expire2, duration2 = self:GetSealExpiration()
	if self.opt.rf then
		time1:SetText(self:FormatTime(expire1))
		time1:SetTextColor(self:GetSeverityColor(expire1 / duration1))
		if self.opt.display.buffDuration == true and expire1 < 1800 then
			prevBuffDuration = true
			self.opt.display.buffDuration = false
		elseif self.opt.display.buffDuration == false and prevBuffDuration == true then
			prevBuffDuration = nil
			self.opt.display.buffDuration = true
		end
	else
		time1:SetText("")
	end
	time2:SetText(self:FormatTime(expire2))
	time2:SetTextColor(self:GetSeverityColor(expire2 / duration2))
	if (expire1 == 9999 and self.opt.rf) and (expire2 == 9999 and self.opt.seal == 0) then
		self:ApplyBackdrop(rfbutton, self.opt.cBuffNeedAll)
	elseif (expire1 == 9999 and self.opt.rf) or (expire2 == 9999 and self.opt.seal > 0) then
		self:ApplyBackdrop(rfbutton, self.opt.cBuffNeedSome)
	else
		self:ApplyBackdrop(rfbutton, self.opt.cBuffGood)
	end
	if self.opt.auras then
		self:UpdateAuraButton(PallyPower_AuraAssignments[self.player])
	end
	if minClassExpire ~= 9999 or minSpecialExpire ~= 9999 or expire1 ~= 9999 or expire2 ~= 9999 then
		if isPally and not self.buttonUpdate then
			self.buttonUpdate = self:ScheduleRepeatingTimer(self.ButtonsUpdate, 1, self)
		end
	else
		self:CancelTimer(self.buttonUpdate)
		self.buttonUpdate = nil
	end
end

function PallyPower:UpdateAnchor(displayedButtons)
	PallyPowerAnchor:SetChecked(self.opt.display.frameLocked)
	if self.opt.display.enableDragHandle and ((GetNumGroupMembers() == 0 and self.opt.ShowWhenSolo) or (GetNumGroupMembers() > 0 and self.opt.ShowInParty)) then
		PallyPowerAnchor:Show()
	else
		PallyPowerAnchor:Hide()
	end
end

function PallyPower:NormalBlessingCount(classID)
	local nbcount = 0
	if classlist[classID] then
		for pbNum = 1, math.min(classlist[classID], PALLYPOWER_MAXPERCLASS) do
			local unit = self:GetUnit(classID, pbNum)
			if unit and unit.name and PallyPower_NormalAssignments[self.player] and PallyPower_NormalAssignments[self.player][classID] and PallyPower_NormalAssignments[self.player][classID][unit.name] then
				nbcount = nbcount + 1
			end
		end -- by pbnum
	end
	return nbcount
end

function PallyPower:GetSpellID(classID, playerName)
	local normal = 0
	local greater = 0
	if playerName and PallyPower_NormalAssignments[self.player] and PallyPower_NormalAssignments[self.player][classID] and PallyPower_NormalAssignments[self.player][classID][playerName] then
		normal = PallyPower_NormalAssignments[self.player][classID][playerName]
	end
	if PallyPower_Assignments[self.player] and PallyPower_Assignments[self.player][classID] then
		greater = PallyPower_Assignments[self.player][classID]
	end
	if normal == 0 then
		normal = greater
	end
	return normal, greater
end

function PallyPower:GetUnit(classID, playerID)
	return classes[classID][playerID]
end

function PallyPower:GetUnitIdByName(name)
	for _, unit in ipairs(roster) do
		if unit.name == name then
			return unit.unitid
		end
	end
end

function PallyPower:GetUnitAndSpellSmart(classid, mousebutton)
	local class = classes[classid]
	local now = time()
	-- Greater Blessings
	if (mousebutton == "LeftButton") then
		local minExpire, classMinExpire, classNeedsBuff, classMinUnitPenalty, classMinUnit, classMinSpell, classMaxSpell = 600, 600, true, 600, nil, nil, nil
		for _, unit in pairs(class) do
			local isPet = unit.unitid:find("pet")
			local spellID, gspellID = self:GetSpellID(classid, unit.name)
			local spell = self.Spells[spellID]
			local gspell = self.GSpells[gspellID]
			if (IsSpellInRange(gspell, unit.unitid) == 1) and (not UnitIsDeadOrGhost(unit.unitid)) then
				local penalty = 0
				local buffExpire, buffDuration, buffName = self:IsBuffActive(spell, gspell, unit.unitid)
				local nSpell, gSpell = self:CanBuffBlessing(spellID, gspellID, unit.unitid)
				local recipients = #classes[classid]

				if (self.AutoBuffedList[unit.name] and now - self.AutoBuffedList[unit.name] < recipients*1.65) then
					penalty = PALLYPOWER_GREATERBLESSINGDURATION
				end
				if (self.PreviousAutoBuffedUnit and (unit.hasbuff and unit.hasbuff > minExpire) and unit.name == self.PreviousAutoBuffedUnit.name and GetNumGroupMembers() > 0) then
					penalty = PALLYPOWER_GREATERBLESSINGDURATION
				else
					penalty = 0
				end
				-- Buff Duration option disabled - allow spamming buffs
				if not self.opt.display.buffDuration then
					for i = 1, recipients do
						local unitID = classes[classid][i]
						if IsSpellInRange(gspell, unitID.unitid) ~= 1 or UnitIsDeadOrGhost(unitID.unitid) or UnitIsAFK(unitID.unitid) or not UnitIsConnected(unitID.unitid) then
							recipients = recipients - 1
						end
					end
					if not self.AutoBuffedList[unit.name] or now - self.AutoBuffedList[unit.name] > (1.65 * recipients) then
						buffExpire = 0
						penalty = 0
					end
				else
					-- If normal blessing - set duration to zero and buff it - but only if an alternate blessing isn't assigned
					if (buffName and buffName == spell and spellID == gspellID) then
						buffExpire = 0
						penalty = 0
					end
				end
				if IsInRaid() then
					for k, v in pairs(classmaintanks) do
						if (gspellID == 4 and not self.opt.SalvInCombat) then
							-- Skip tanks if Salv is assigned. This allows autobuff to work since some tanks
							-- have addons and/or scripts to auto cancel Salvation. Prevents getting stuck
							-- buffing a tank when auto buff rotates among players in the class group.
							if k == unit.unitid and v == true then
								buffExpire = 9999
								penalty = 9999
							end
						end
					end
				end
				-- We don't buff pets with Greater Blessings
				if isPet then
					buffExpire = 9999
					penalty = 9999
				end
				-- Refresh any greater blessing under a 10 min duration
				if ((not buffExpire or (buffExpire < classMinExpire) and buffExpire < PALLYPOWER_GREATERBLESSINGDURATION) and classMinExpire > 0) then
					if (penalty < classMinUnitPenalty) then
						classMinUnit = unit
						classMinUnitPenalty = penalty
					end
					classMinSpell = nSpell
					classMaxSpell = gSpell
					classMinExpire = (buffExpire or 0)
				end
			elseif (UnitIsVisible(unit.unitid) == false and not UnitIsAFK(unit.unitid) and UnitIsConnected(unit.unitid)) and (IsInRaid() == false or #classes[classid] > 3) then
				classNeedsBuff = false
			end
		end
		-- Refresh any greater blessing under a 10 min duration
		if (classMinUnit and classMinUnit.name and (classNeedsBuff or not self.opt.autobuff.waitforpeople) and classMinExpire + classMinUnitPenalty < minExpire and minExpire > 0) then
			self.AutoBuffedList[classMinUnit.name] = now
			self.PreviousAutoBuffedUnit = classMinUnit
			return classMinUnit.unitid, classMinSpell, classMaxSpell
		end
	-- Normal Blessings
	elseif (mousebutton == "RightButton") then
		local minExpire = 240
		for _, unit in pairs(class) do
			local spellID, gspellID = self:GetSpellID(classid, unit.name)
			local spell = self.Spells[spellID]
			local spell2 = self.GSpells[spellID]
			local gspell = self.GSpells[gspellID]
			if (IsSpellInRange(spell, unit.unitid) == 1) and (not UnitIsDeadOrGhost(unit.unitid)) then
				local penalty = 0
				local greaterBlessing = false
				local buffExpire, buffDuration, buffName = self:IsBuffActive(spell, spell2, unit.unitid)
				local nSpell, gSpell = self:CanBuffBlessing(spellID, gspellID, unit.unitid)
				local recipients = #classes[classid]

				if (self.AutoBuffedList[unit.name] and now - self.AutoBuffedList[unit.name] < recipients*1.65) then
					penalty = PALLYPOWER_NORMALBLESSINGDURATION
				end
				if (self.PreviousAutoBuffedUnit and (unit.hasbuff and unit.hasbuff > minExpire) and unit.name == self.PreviousAutoBuffedUnit.name and GetNumGroupMembers() > 0) then
					penalty = PALLYPOWER_NORMALBLESSINGDURATION
				else
					penalty = 0
				end
				-- Flag valid Greater Blessings | If it falls below 4 min refresh it with a Normal Blessing
				if buffName and buffName == gspell and buffExpire > minExpire then
					greaterBlessing = true
					penalty = PALLYPOWER_NORMALBLESSINGDURATION
				elseif buffName and buffName == gspell and buffExpire < minExpire then
					greaterBlessing = false
					penalty = 0
				end
				if (buffName and buffName == gspell) then
					-- If we're using Blessing of Sacrifice then set the expiration to match Normal Blessings so Auto Buff works.
					if (spell == self.Spells[7]) then
						greaterBlessing = false
						buffExpire = 270
						penalty = 0
					-- Alternate Blessing assigned then always allow buffing over a Greater Blessing: Set duration to zero and buff it.
					elseif (spell ~= self.Spells[7] and spellID ~= gspellID) then
						greaterBlessing = false
						buffExpire = 0
						penalty = 0
					end
				end
				-- Buff Duration option disabled - allow spamming buffs
				-- This logic counts the number of players in a class and subtracts the ratio from the
				-- buffs overall duration resulting in a "round robin" approach for spamming buffs so
				-- auto buff doesn't get stuck on one person. The ratio is reduced when a player has
				-- a Greater Blessing, is out of range, dead, afk, or not connected.
				if not self.opt.display.buffDuration then
					for i = 1, recipients do
						local unitID = classes[classid][i]
						if (unitID.hasbuff and unitID.hasbuff > 300) or IsSpellInRange(nSpell, unitID.unitid) ~= 1 or UnitIsDeadOrGhost(unitID.unitid) or UnitIsAFK(unitID.unitid) or not UnitIsConnected(unitID.unitid) then
							recipients = recipients - 1
						end
					end
					-- Blessing of Sacrifice
					if (spell == self.Spells[7]) then
						if not buffExpire or buffExpire < (30 - ((1.65 * recipients) - 1.65)) then
							buffExpire = 0
							penalty = 0
						end
					-- Normal Blessings
					elseif (spell ~= self.Spells[7]) then
						if not buffExpire or buffExpire < (300 - ((1.65 * recipients) - 1.65)) then
							buffExpire = 0
							penalty = 0
						end
					end
				end
				if IsInRaid() then
					-- Skip tanks if Salv is assigned. This allows autobuff to work since some tanks
					-- have addons and/or scripts to auto cancel Salvation. Tanks shouldn't have a
					-- Normal Blessing of Salvation but sometimes there are way more Paladins in a
					-- Raid than there are buffs to assign so an Alternate Blessing might not be in
					-- use to wipe Salvation from a tank. Prevents getting stuck buffing a tank when
					-- auto buff rotates among players in the class group.
					for k, v in pairs(classmaintanks) do
						if k == unit.unitid and v == true then
							if (spellID == 4 and not self.opt.SalvInCombat) then
								buffExpire = 9999
								penalty = 9999
							end
						end
					end
				end
				-- Refresh any normal blessing under a 4 min duration
				if ((not buffExpire or buffExpire + penalty < minExpire and buffExpire < PALLYPOWER_NORMALBLESSINGDURATION) and minExpire > 0 and not greaterBlessing) then
					self.AutoBuffedList[unit.name] = now
					self.PreviousAutoBuffedUnit = unit
					return unit.unitid, nSpell, gSpell
				end
			end
		end
	end
	return nil, "", ""
end

function PallyPower:IsBuffActive(spellName, gspellName, unitID)
	local j = 1
	local buffName = UnitBuff(unitID, j)
	while buffName do
		if (buffName == spellName) or (buffName == gspellName) then
			local _, buffDuration, buffExpire
			if self.isBCC then
				_, _, _, _, buffDuration, buffExpire = UnitAura(unitID, j, "HELPFUL")
			else
				_, _, _, _, buffDuration, buffExpire = LCD.UnitAuraWrapper(unitID, j, "HELPFUL")
			end
			if buffExpire then
				if buffExpire == 0 then
					buffExpire = 0
				else
					buffExpire = buffExpire - GetTime()
				end
			end
			--self:Debug("[IsBuffActive] buffName: "..buffName.." | buffExpire: "..buffExpire.." | buffDuration: "..buffDuration)
			return buffExpire, buffDuration, buffName
		end
		j = j + 1
		buffName = UnitBuff(unitID, j)
	end
	return nil
end

function PallyPower:ButtonPreClick(button, mousebutton)
	if InCombatLockdown() then return end

	-- Greater Blessing: Clear
	button:SetAttribute("macrotext1", nil)
	button:SetAttribute("spellName1", nil)
	button:SetAttribute("step1", nil)
	button:UnwrapScript(button, "OnClick")
	-- Normal Blessing: Clear
	button:SetAttribute("macrotext2", nil)
	local classid = button:GetAttribute("classID")
	local spell, gspell, unitName, unitid
	if classid and classid > 0 then
		if IsInRaid() and (mousebutton == "LeftButton") and (classid ~= 10) then
			unitid, spell, gspell = self:GetUnitAndSpellSmart(classid, mousebutton)
			if unitid and classid then
				unitName = GetUnitName(unitid, true)
			end
			spell = false
		elseif not IsInRaid() or ((IsInRaid() and mousebutton == "RightButton")) then
			unitid, spell, gspell = self:GetUnitAndSpellSmart(classid, mousebutton)
			if unitid then
				if classid == 10 then
					local unitPrefix = "party"
					local offSet = 9
					if (unitid:find("raid")) then
						unitPrefix = "raid"
						offSet = 8
					end
					unitName = GetUnitName(unitPrefix .. unitid:sub(offSet), true) .. "-pet"
				else
					unitName = GetUnitName(unitid, true)
				end
			end
			if mousebutton == "LeftButton" then
				spell = false
			end
			if mousebutton == "RightButton" then
				gspell = false
			end
		end
		if unitName then
			local spellID, gspellID = self:GetSpellID(classid, unitName)
			-- Enable Greater Blessing of Salvation on everyone but do not allow Normal Blessing of Salvation on tanks if SalvInCombat is disabled
			if IsInRaid() and (spellID == 4 or gspellID == 4) and (not self.opt.SalvInCombat) then
				for k, v in pairs(classmaintanks) do
					-- If the buff recipient unit(s) is in combat and there is a tank present in
					-- the Class Group then disable Greater Blessing of Salvation for this unit(s).
					if UnitAffectingCombat(unitid) and (gspellID == 4) and (k == classid and v == true) then
						gspell = false
					end
					if k == unitid and v == true then
						-- Do not allow Salvation on tanks - Blessings [disabled]
						if (spellID == 4) then
							spell = false
						end
						if (gspellID == 4) then
							gspell = false
						end
					end
				end
			end
			-- Set Greater Blessing: left click
			if gspell then
				local gspellMacro = "/cast [@" .. unitName .. ",help,nodead] " .. gspell
				button:SetAttribute("macrotext1", gspellMacro)
				--self:Debug("Single Unit Macro Executed: "..gspellMacro)
			end
			-- Set Normal Blessing: right click (Only works while not in combat. Cleared in PostClick.)
			if spell then
				local spellMacro = "/cast [@" .. unitName .. ",help,nodead] " .. spell
				button:SetAttribute("macrotext2", spellMacro)
				--self:Debug("Single Unit Macro Executed: "..spellMacro)
			end
		end
	end
end

function PallyPower:ButtonPostClick(button, mousebutton)
	if InCombatLockdown() then return end

	if IsInRaid() then
		-- Greater Blessing: Clear current macro
		button:SetAttribute("macrotext1", nil)
		button:SetAttribute("spellName1", nil)
		button:SetAttribute("step1", nil)
		button:UnwrapScript(button, "OnClick")
		-- Create a list of viable players for in-combat script
		local targetNames = {}
		local gSpell = false
		local numPlayers = 0
		local classid = button:GetAttribute("classID")
		if (mousebutton == "LeftButton") and (classid ~= 10) then
			for i = 1, PALLYPOWER_MAXPERCLASS do
				if numPlayers < 9 and classid and classes[classid] and classes[classid][i] then
					local unit = classes[classid][i]
					local spellID, gspellID = self:GetSpellID(classid, unit.name)
					local _, gspell = self:CanBuffBlessing(spellID, gspellID, unit.unitid)
					if gspell and (IsSpellInRange(gspell, unit.unitid) == 1) and (not UnitIsDeadOrGhost(unit.unitid)) and (not UnitIsAFK(unit.unitid)) and UnitIsConnected(unit.unitid) then
						local unitName = GetUnitName(classes[classid][i].unitid, true)
						table.insert(targetNames, unitName)
						numPlayers = numPlayers + 1
						gSpell = gspell
					end
				else
					break
				end
			end
		end
		-- If there is a tank present for this "classid" then disable Greater Blessing of Salvation.
		if gSpell and strfind(gSpell, self.GSpells[4]) and not self.opt.SalvInCombat then
			for k, v in pairs(classmaintanks) do
				if (k == classid and v == true) then
					gSpell = false
				end
			end
		end
		if gSpell and numPlayers > 0 then
			button:SetAttribute("spellName1", gSpell)
			button:SetAttribute("step1", 1)

			button:Execute("unitNames = newtable([=[" .. strjoin("]=],[=[", unpack(targetNames)) .. "]=])\n")

			button:WrapScript(button, "OnClick", [=[
				local spellName = self:GetAttribute("spellName1")
				local step = self:GetAttribute("step1")

				if step > table.maxn(unitNames) then
					step = 1
				end

				if unitNames[step] and SecureCmdOptionParse("[@" .. unitNames[step] .. ",help,nodead]") then
					local gspellMacro = "/cast %s %s"
					local targetName = "[@" .. unitNames[step] .. ",help,nodead]"
					gspellMacro = format(gspellMacro, targetName, spellName)
					self:SetAttribute("macrotext1", gspellMacro)
					print("Secure Macro: "..gspellMacro)
				end
				self:SetAttribute("step1", step + 1)

			]=])
		end
	end
	-- Normal Blessing: Clear current macro
	button:SetAttribute("macrotext2", nil)
end

function PallyPower:ClickHandle(button, mousebutton)
	-- Lock & Unlock the frame on left click, and toggle config dialog with right click
	local function RelockActionBars()
		self.opt.display.frameLocked = true
		if (self.opt.display.LockBuffBars) then
			LOCK_ACTIONBAR = "1"
		end
		_G["PallyPowerAnchor"]:SetChecked(true)
	end
	if (mousebutton == "RightButton") then
		if IsShiftKeyDown() then
			self:OpenConfigWindow()
			button:SetChecked(self.opt.display.frameLocked)
		else
			PallyPowerBlessings_Toggle()
			button:SetChecked(self.opt.display.frameLocked)
		end
	elseif (mousebutton == "LeftButton") then
		self.opt.display.frameLocked = not self.opt.display.frameLocked
		if (self.opt.display.frameLocked) then
			if (self.opt.display.LockBuffBars) then
				LOCK_ACTIONBAR = "1"
			end
		else
			if (self.opt.display.LockBuffBars) then
				LOCK_ACTIONBAR = "0"
			end
			self:ScheduleTimer(RelockActionBars, 30)
		end
		button:SetChecked(self.opt.display.frameLocked)
	end
end

function PallyPower:DragStart()
	-- Start dragging if not locked
	if (not self.opt.display.frameLocked) then
		_G["PallyPowerFrame"]:StartMoving()
		PallyPowerFrame:SetClampedToScreen(true)
	end
end

function PallyPower:DragStop()
	-- End dragging
	_G["PallyPowerFrame"]:StopMovingOrSizing()
end

function PallyPower:AutoBuff(button, mousebutton)
	if InCombatLockdown() then return end

	local now = time()
	local greater = (mousebutton == "LeftButton" or mousebutton == "Hotkey2")
	if greater then
		-- Greater Blessings
		local minExpire, minUnit, minSpell, maxSpell = 600, nil, nil, nil
		for i = 1, PALLYPOWER_MAXCLASSES do
			local classMinExpire, classNeedsBuff, classMinUnitPenalty, classMinUnit, classMinSpell, classMaxSpell = 600, true, 600, nil, nil, nil
			for j = 1, PALLYPOWER_MAXPERCLASS do
				if (classes[i] and classes[i][j]) then
					local unit = classes[i][j]
					local spellID, gspellID = self:GetSpellID(i, unit.name)
					local spell = self.Spells[spellID]
					local gspell = self.GSpells[gspellID]
					local isPet = unit.unitid:find("pet")
					if (IsSpellInRange(gspell, unit.unitid) == 1) and not UnitIsDeadOrGhost(unit.unitid) then
						local penalty = 0
						local buffExpire, buffDuration, buffName = self:IsBuffActive(spell, gspell, unit.unitid)
						local nSpell, gSpell = self:CanBuffBlessing(spellID, gspellID, unit.unitid)
						local recipients = #classes[i]

						if (self.AutoBuffedList[unit.name] and now - self.AutoBuffedList[unit.name] < recipients*1.65) then
							penalty = PALLYPOWER_GREATERBLESSINGDURATION
						end

						if (self.PreviousAutoBuffedUnit and (unit.hasbuff and unit.hasbuff > minExpire) and unit.name == self.PreviousAutoBuffedUnit.name and GetNumGroupMembers() > 0) then
							penalty = PALLYPOWER_GREATERBLESSINGDURATION
						else
							penalty = 0
						end
						-- If normal blessing - set duration to zero and buff it - but only if an alternate blessing isn't assigned
						if buffName and buffName == spell and spellID == gspellID then
							buffExpire = 0
							penalty = 0
						end
						if IsInRaid() then
							for k, v in pairs(classmaintanks) do
								if (gspellID == 4 and not self.opt.SalvInCombat) then
									-- If for some reason the targeted unit is in combat and there is a tank present
									-- in the Class Group then disable Greater Blessing of Salvation for this unit.
									if UnitAffectingCombat(unit.unitid) and (k == classID and v == true) then
										buffExpire = 9999
										penalty = 9999
									end
									-- Skip tanks if Salv is assigned. This allows autobuff to work since some tanks
									-- have addons and/or scripts to auto cancel Salvation. Prevents getting stuck
									-- buffing a tank when auto buff rotates among players in the class group.
									if k == unit.unitid and v == true then
										buffExpire = 9999
										penalty = 9999
									end
								end
							end
							-- We don't buff pets with Greater Blessings
							if isPet then
								buffExpire = 9999
								penalty = 9999
							end
						end
						-- Refresh any greater blessing under a 10 min duration
						if ((not buffExpire or buffExpire < classMinExpire and buffExpire < PALLYPOWER_GREATERBLESSINGDURATION) and classMinExpire > 0) then
							if (penalty < classMinUnitPenalty) then
								classMinUnit = unit
								classMinUnitPenalty = penalty
							end

							classMaxSpell = gSpell
							classMinExpire = (buffExpire or 0)
						end
					elseif (UnitIsVisible(unit.unitid) == false and not UnitIsAFK(unit.unitid) and UnitIsConnected(unit.unitid)) and (IsInRaid() == false or #classes[i] > 3) then
						classNeedsBuff = false
					end
				end
			end
			if ((classNeedsBuff or not self.opt.autobuff.waitforpeople) and classMinExpire + classMinUnitPenalty < minExpire and minExpire > 0) then
				minExpire = classMinExpire + classMinUnitPenalty
				minUnit = classMinUnit
				maxSpell = classMaxSpell
			end
		end
		if (minExpire < 600) then
			local button = self.autoButton
			button:SetAttribute("unit", minUnit.unitid)
			button:SetAttribute("spell", maxSpell)
			self.AutoBuffedList[minUnit.name] = now
			self.PreviousAutoBuffedUnit = minUnit
			C_Timer.After(
				1.0,
				function()
					local _, unitClass = UnitClass(minUnit.unitid)
					local cID = self.ClassToID[unitClass]
					self:UpdateButton(nil, "PallyPowerC" .. cID, cID)
					self:ButtonsUpdate()
				end
			)
		end
	else
		-- Normal Blessings
		local minExpire, minUnit, minSpell = 240, nil, nil
		for _, unit in ipairs(roster) do
			local spellID, gspellID = self:GetSpellID(self:GetClassID(unit.class), unit.name)
			local spell = self.Spells[spellID]
			local spell2 = self.GSpells[spellID]
			local gspell = self.GSpells[gspellID]
			if (IsSpellInRange(spell, unit.unitid) == 1) and not UnitIsDeadOrGhost(unit.unitid) then
				local penalty = 0
				local buffExpire, buffDuration, buffName = self:IsBuffActive(spell, spell2, unit.unitid)
				local nSpell, gSpell = self:CanBuffBlessing(spellID, gspellID, unit.unitid)
				local recipients = #roster

				if (self.AutoBuffedList[unit.name] and now - self.AutoBuffedList[unit.name] < recipients*1.65) then
					penalty = PALLYPOWER_NORMALBLESSINGDURATION
				end
				if (self.PreviousAutoBuffedUnit and (unit.hasbuff and unit.hasbuff > minExpire) and unit.name == self.PreviousAutoBuffedUnit.name and GetNumGroupMembers() > 0) then
					penalty = PALLYPOWER_NORMALBLESSINGDURATION
				else
					penalty = 0
				end
				-- If a Greater Blessing falls below 4 min, refresh it with a Normal Blessing
				if buffName and buffName == gspell and buffExpire > minExpire then
					penalty = PALLYPOWER_NORMALBLESSINGDURATION
				elseif buffName and buffName == gspell and buffExpire < minExpire then
					penalty = 0
				end
				if (buffName and buffName == gspell) then
					-- If we're using Blessing of Sacrifice then set the expiration to match Normal Blessings so Auto Buff works.
					if (spell == self.Spells[7]) then
						buffExpire = 270
						penalty = 0
					-- Alternate Blessing assigned then always allow buffing over a Greater Blessing: Set duration to zero and buff it.
					elseif (spell ~= self.Spells[7] and spellID ~= gspellID) then
						buffExpire = 0
						penalty = 0
					end
				end
				if IsInRaid() then
					-- Skip tanks if Salv is assigned. This allows autobuff to work since some tanks
					-- have addons and/or scripts to auto cancel Salvation. Tanks shouldn't have a
					-- Normal Blessing of Salvation but sometimes there are way more Paladins in a
					-- Raid than there are buffs to assign so an Alternate Blessing might not be in
					-- use to wipe Salvation from a tank. Prevents getting stuck buffing a tank when
					-- auto buff rotates among players in the class group.
					for k, v in pairs(classmaintanks) do
						if k == unit.unitid and v == true then
							if (spellID == 4 and not self.opt.SalvInCombat) then
								buffExpire = 9999
								penalty = 9999
							end
						end
					end
				end
				-- Refresh any blessing under a 4 min duration
				if ((not buffExpire or buffExpire + penalty < minExpire and buffExpire < PALLYPOWER_NORMALBLESSINGDURATION) and minExpire > 0) then
					minExpire = (buffExpire or 0) + penalty
					minUnit = unit
					minSpell = nSpell
				end
			end
		end
		if (minExpire < 240) then
			local button = self.autoButton
			button:SetAttribute("unit", minUnit.unitid)
			button:SetAttribute("spell", minSpell)
			self.AutoBuffedList[minUnit.name] = now
			self.PreviousAutoBuffedUnit = minUnit
			C_Timer.After(
				1.0,
				function()
					local _, unitClass = UnitClass(minUnit.unitid)
					local cID = self.ClassToID[unitClass]
					if cID then
						self:UpdateButton(nil, "PallyPowerC" .. cID, cID)
					end
					self:ButtonsUpdate()
				end
			)
		end
	end
end

function PallyPower:AutoBuffClear(button, mousebutton)
	if InCombatLockdown() then return end

	local button = self.autoButton
	if not button:GetAttribute("unit") == nil then
		local abUnit = button:GetAttribute("unit")
		local abName = UnitName(abUnit)
		for _, unit in ipairs(roster) do
			if unit.unitid == abUnit and unit.name == abName then
				local classIndex = self.ClassToID[unit.class]
				self:UpdateButton(button, "PallyPowerC" .. classIndex, classIndex)
			end
		end
	end
	button:SetAttribute("unit", nil)
	button:SetAttribute("spell", nil)
end

function PallyPower:ApplySkin()
	local border = LSM3:Fetch("border", self.opt.border)
	local background = LSM3:Fetch("background", self.opt.skin)
	local tmp = {bgFile = background, edgeFile = border, tile = false, tileSize = 8, edgeSize = 8, insets = {left = 0, right = 0, top = 0, bottom = 0}}
	if BackdropTemplateMixin then
		Mixin(PallyPowerAura, BackdropTemplateMixin)
		Mixin(PallyPowerRF, BackdropTemplateMixin)
		Mixin(PallyPowerAuto, BackdropTemplateMixin)
	end
	PallyPowerAura:SetBackdrop(tmp)
	PallyPowerRF:SetBackdrop(tmp)
	PallyPowerAuto:SetBackdrop(tmp)
	for cbNum = 1, PALLYPOWER_MAXCLASSES do
		local cButton = self.classButtons[cbNum]
		if BackdropTemplateMixin then
			Mixin(cButton, BackdropTemplateMixin)
		end
		cButton:SetBackdrop(tmp)
		local pButtons = self.playerButtons[cbNum]
		for pbNum = 1, PALLYPOWER_MAXPERCLASS do
			local pButton = pButtons[pbNum]
			if BackdropTemplateMixin then
				Mixin(pButton, BackdropTemplateMixin)
			end
			pButton:SetBackdrop(tmp)
		end
	end
end

function PallyPower:ApplyBackdrop(button, preset)
	-- button coloring: preset
	if BackdropTemplateMixin then
		Mixin(button, BackdropTemplateMixin)
	end
	button:SetBackdropColor(preset["r"], preset["g"], preset["b"], preset["t"])
end

function PallyPower:SetSeal(seal)
	self.opt.seal = seal
end

function PallyPower:SealCycle()
	if InCombatLockdown() then return end

	if IsShiftKeyDown() then
		self.opt.rf = not self.opt.rf
		self:RFAssign()
	else
		if not self.opt.seal then
			self.opt.seal = 0
		end
		local cur = self.opt.seal
		for test = cur + 1, 10 do
			cur = test
			if GetSpellInfo(self.Seals[cur]) then
				do
					break
				end
			end
		end
		if cur == 10 then
			cur = 0
		end
		self:SealAssign(cur)
	end
end

function PallyPower:SealCycleBackward()
	if InCombatLockdown() then return end

	if IsShiftKeyDown() then
		self.opt.rf = not self.opt.rf
		self:RFAssign()
	else
		if not self.opt.seal then
			self.opt.seal = 0
		end
		local cur = self.opt.seal
		if cur == 0 then
			cur = 10
		end
		for test = cur - 1, 0, -1 do
			cur = test
			if GetSpellInfo(self.Seals[test]) then
				do
					break
				end
			end
		end
		self:SealAssign(cur)
	end
end

function PallyPower:RFAssign()
	local name, _, icon = GetSpellInfo(self.RFSpell)
	local rfIcon = _G["PallyPowerRFIcon"]
	if self.opt.rf then
		rfIcon:SetTexture(icon)
		self.rfButton:SetAttribute("spell1", name)
	else
		rfIcon:SetTexture(nil)
		self.rfButton:SetAttribute("spell1", nil)
	end
end

function PallyPower:SealAssign(seal)
	self.opt.seal = seal
	local name, _, icon = GetSpellInfo(self.Seals[seal])
	local sealIcon = _G["PallyPowerRFIconSeal"] -- seal icon
	sealIcon:SetTexture(icon)
	self.rfButton:SetAttribute("spell2", name)
end

function PallyPower:AutoAssign()
	if InCombatLockdown() then return end

	local shift = (IsShiftKeyDown() and PallyPowerBlessingsFrame:IsMouseOver())
	local precedence
	if IsInRaid() and not (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() or shift) then
		precedence = {6, 1, 3, 2, 4, 5, 7, 8} -- fire, devotion, concentration, retribution, shadow, frost, sanctity, crusader
	else
		precedence = {1, 3, 2, 4, 5, 6, 7, 8} -- devotion, concentration, retribution, shadow, frost, fire, sanctity, crusader
	end
	if self:CheckLeader(self.player) or PP_Leader == false then
		WisdomPallys, MightPallys, KingsPallys, SalvPallys, LightPallys, SancPallys = {}, {}, {}, {}, {}, {}
		self:ClearAssignments(self.player)
		self:SendMessage("CLEAR")
		self:AutoAssignBlessings(shift)
		self:UpdateRoster()
		C_Timer.After(
			0.25,
			function()
				for name in pairs(AllPallys) do
					local s = ""
					local BuffInfo = PallyPower_Assignments[name]
					for i = 1, PALLYPOWER_MAXCLASSES do
						if not BuffInfo[i] or BuffInfo[i] == 0 then
							s = s .. "n"
						else
							s = s .. BuffInfo[i]
						end
					end
					self:SendMessage("PASSIGN " .. name .. "@" .. s)
				end
				C_Timer.After(
					0.25,
					function()
						self:AutoAssignAuras(precedence)
						self:UpdateLayout()
					end
				)
			end
		)
	end
end

function PallyPower:CalcSkillRanks(name)
	local wisdom, might, kings, salv, light, sanct
	if AllPallys[name][1] then
		wisdom = tonumber(AllPallys[name][1].rank) + tonumber(AllPallys[name][1].talent) -- /12 removed division / Zid
	end
	if AllPallys[name][2] then
		might = tonumber(AllPallys[name][2].rank) + tonumber(AllPallys[name][2].talent) -- /10 removed division / Zid
	end
	if AllPallys[name][3] then
		kings = tonumber(AllPallys[name][3].rank)
	end
	if AllPallys[name][4] then
		salv = tonumber(AllPallys[name][4].rank)
	end
	if AllPallys[name][5] then
		light = tonumber(AllPallys[name][5].rank)
	end
	if AllPallys[name][6] then
		sanct = tonumber(AllPallys[name][6].rank)
	end
	return wisdom, might, kings, salv, light, sanct
end

function PallyPower:AutoAssignBlessings(shift)
	local pallycount = 0
	local pallytemplate
	for name in pairs(AllPallys) do
		pallycount = pallycount + 1
	end
	if pallycount == 0 then
		return
	end
	if pallycount > 6 then
		pallycount = 6
	end

	if isPally then
		-- Does leader have salvation? This is the hardest assignment to deal with so
		-- we'd want someone with experience dealing with DPS classes that can also
		-- Tank; and thus know how to assign alternate Normal Blessings to Tanks so
		-- DPS'ers can have Greater Blessing of Salvation. Only leaders can use the
		-- Auto Assign feature so it makes sense to insert this logic here and only
		-- apply it to Raid groups specifically.
		local _, _, _, salv, _, _ = self:CalcSkillRanks(self.player)
		if (IsInRaid() and not IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and self:CheckLeader(self.player) and not shift and salv) then
			PP_LeaderSalv = true
		end
	end

	for name in pairs(AllPallys) do
		local wisdom, might, kings, salv, light, sanct = self:CalcSkillRanks(name)
		if wisdom then
			tinsert(WisdomPallys, {pallyname = name, skill = wisdom})
		end
		if might then
			tinsert(MightPallys, {pallyname = name, skill = might})
		end
		if kings then
			tinsert(KingsPallys, {pallyname = name, skill = kings})
		end
		if salv then
			tinsert(SalvPallys, {pallyname = name, skill = salv})
		end
		if light then
			tinsert(LightPallys, {pallyname = name, skill = light})
		end
		if sanct then
			tinsert(SancPallys, {pallyname = name, skill = sanct})
		end
	end

	-- get template for the number of available paladins in the raid
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() or shift then
		pallytemplate = self.BattleGroundTemplates[pallycount]
	else
		if IsInRaid() then
			pallytemplate = self.RaidTemplates[pallycount]
		else
			pallytemplate = self.Templates[pallycount]
		end
	end
	-- re-rate buffs for each of the improvable/skillable buffs / Zid
	self:AssignNewBuffRatings(WisdomPallys)
	self:AssignNewBuffRatings(MightPallys)
	self:AssignNewBuffRatings(KingsPallys)
	self:AssignNewBuffRatings(SancPallys)
	-- assign based on the class templates
	self:SelectBuffsByClass(pallycount, 1, pallytemplate[1]) -- warrior
	self:SelectBuffsByClass(pallycount, 2, pallytemplate[2]) -- rogue
	self:SelectBuffsByClass(pallycount, 3, pallytemplate[3]) -- priest
	self:SelectBuffsByClass(pallycount, 4, pallytemplate[4]) -- druid
	self:SelectBuffsByClass(pallycount, 5, pallytemplate[5]) -- paladin
	self:SelectBuffsByClass(pallycount, 6, pallytemplate[6]) -- hunter
	self:SelectBuffsByClass(pallycount, 7, pallytemplate[7]) -- mage
	self:SelectBuffsByClass(pallycount, 8, pallytemplate[8]) -- lock
	self:SelectBuffsByClass(pallycount, 9, pallytemplate[9]) -- shaman
	self:SelectBuffsByClass(pallycount, 10, pallytemplate[10]) -- pets
end

function PallyPower:AssignNewBuffRatings(BuffPallys)
	-- assign new buff ratings based on the given BuffPallys (WisdomPallys, MightPallys, etc..) / Zid
	for _, pally in ipairs(BuffPallys) do
		if (pally.skill > 1) then
			-- reduce the rated difference from default buffs
			self:DownRateDefaultBuffs(pally.pallyname, pally.skill - 1)
		end
	end
end

function PallyPower:DownRateDefaultBuffs(name, rating)
	-- SalyPallys and LightPallys skill-rating will be reduced for given pallys by given rating / Zid
	for i, pally in ipairs(SalvPallys) do
		if (pally.pallyname == self.player and PP_LeaderSalv) then
			SalvPallys[i].skill = SalvPallys[i].skill + rating
		elseif pally.pallyname == name then
			SalvPallys[i].skill = SalvPallys[i].skill - rating
		end
	end
	for i, pally in ipairs(LightPallys) do
		if (pally.pallyname == name) then
			LightPallys[i].skill = LightPallys[i].skill - rating
		end
	end
end

function PallyPower:SelectBuffsByClass(pallycount, class, prioritylist)
	local pallys = {}
	for name in pairs(AllPallys) do
		if self:CanControl(name) then
			tinsert(pallys, name)
		end
	end
	local bufftable = prioritylist
	if pallycount > 0 then
		local pallycounter = 1
		for _, nextspell in pairs(bufftable) do
			if pallycounter <= pallycount then
				local buffer = self:BuffSelections(nextspell, class, pallys)
				for i in pairs(pallys) do
					if buffer == pallys[i] then
						tremove(pallys, i)
					end
				end
				if buffer ~= "" then
					pallycounter = pallycounter + 1
				end
			end
		end
	end
end

function PallyPower:BuffSelections(buff, class, pallys)
	local t = {}
	if buff == 1 then
		t = WisdomPallys
	end
	if buff == 2 then
		t = MightPallys
	end
	if buff == 3 then
		t = KingsPallys
	end
	if buff == 4 then
		t = SalvPallys
	end
	if buff == 5 then
		t = LightPallys
	end
	if buff == 6 then
		t = SancPallys
	end
	local Buffer = ""
	tsort(
		t,
		function(a, b)
			return a.skill > b.skill
		end
	)
	for _, v in pairs(t) do
		if self:PallyAvailable(v.pallyname, pallys) then --removed check if v.skill / Zid
			Buffer = v.pallyname
			break
		end
	end
	if Buffer ~= "" then
		if (IsInRaid() and buff > 2) then
			for pclass = 1, PALLYPOWER_MAXCLASSES do
				PallyPower_Assignments[Buffer][pclass] = buff
			end
		elseif PallyPower_Assignments and not PallyPower_Assignments[Buffer] then
			PallyPower_Assignments[Buffer] = {}
			PallyPower_Assignments[Buffer][class] = buff
		else
			PallyPower_Assignments[Buffer][class] = buff
		end
		if IsInRaid() then
			-----------------------------------------------------------------------------------------------------------------
			-- Warriors
			-----------------------------------------------------------------------------------------------------------------
			if (buff == self.opt.mainTankGSpellsW) and (class == 1) and self.opt.mainTank then
				for i = 1, MAX_RAID_MEMBERS do
					local playerName, _, _, _, playerClass = GetRaidRosterInfo(i)
					if playerName and self:CheckMainTanks(playerName) and (class == self:GetClassID(string.upper(playerClass))) then
						SetNormalBlessings(Buffer, class, playerName, self.opt.mainTankSpellsW)
					end
				end
			end
			if (buff == self.opt.mainAssistGSpellsW) and (class == 1) and self.opt.mainAssist then
				for i = 1, MAX_RAID_MEMBERS do
					local playerName, _, _, _, playerClass = GetRaidRosterInfo(i)
					if playerName and self:CheckMainAssists(playerName) and (class == self:GetClassID(string.upper(playerClass))) then
						SetNormalBlessings(Buffer, class, playerName, self.opt.mainAssistSpellsW)
					end
				end
			end
			-----------------------------------------------------------------------------------------------------------------
			-- Druids and Paladins
			-----------------------------------------------------------------------------------------------------------------
			if (buff == self.opt.mainTankGSpellsDP) and (class == 4 or class == 5) and self.opt.mainTank then
				for i = 1, MAX_RAID_MEMBERS do
					local playerName, _, _, _, playerClass = GetRaidRosterInfo(i)
					if playerName and self:CheckMainTanks(playerName) and (class == self:GetClassID(string.upper(playerClass))) then
						SetNormalBlessings(Buffer, class, playerName, self.opt.mainTankSpellsDP)
					end
				end
			end
			if (buff == self.opt.mainAssistGSpellsDP) and (class == 4 or class == 5) and self.opt.mainAssist then
				for i = 1, MAX_RAID_MEMBERS do
					local playerName, _, _, _, playerClass = GetRaidRosterInfo(i)
					if playerName and self:CheckMainAssists(playerName) and (class == self:GetClassID(string.upper(playerClass))) then
						SetNormalBlessings(Buffer, class, playerName, self.opt.mainAssistSpellsDP)
					end
				end
			end
		end
	else
	end
	return Buffer
end

function PallyPower:PallyAvailable(pally, pallys)
	local available = false
	for i in pairs(pallys) do
		if pallys[i] == pally then
			available = true
		end
	end
	return available
end

function PallyPowerAuraButton_OnClick(btn, mouseBtn)
	if InCombatLockdown() then return end

	local _, _, pnum = strfind(btn:GetName(), "PallyPowerBlessingsFramePlayer(.+)Aura1")
	pnum = pnum + 0
	local pname = _G["PallyPowerBlessingsFramePlayer" .. pnum .. "Name"]:GetText()
	if not PallyPower:CanControl(pname) then
		return false
	end
	if (mouseBtn == "RightButton") then
		PallyPower_AuraAssignments[pname] = 0
		PallyPower:SendMessage("AASSIGN " .. pname .. " 0")
	else
		PallyPower:PerformAuraCycle(pname)
	end
end

function PallyPowerAuraButton_OnMouseWheel(btn, arg1)
	if InCombatLockdown() then return end

	local _, _, pnum = strfind(btn:GetName(), "PallyPowerBlessingsFramePlayer(.+)Aura1")
	pnum = pnum + 0
	local pname = _G["PallyPowerBlessingsFramePlayer" .. pnum .. "Name"]:GetText()
	if not PallyPower:CanControl(pname) then
		return false
	end
	if (arg1 == -1) then --mouse wheel down
		PallyPower:PerformAuraCycle(pname)
	else
		PallyPower:PerformAuraCycleBackwards(pname)
	end
end

function PallyPower:HasAura(name, test)
	if (not AllPallys[name].AuraInfo[test]) or (AllPallys[name].AuraInfo[test].rank == 0) then
		return false
	end
	return true
end

function PallyPower:PerformAuraCycle(name, skipzero)
	if not PallyPower_AuraAssignments[name] then
		PallyPower_AuraAssignments[name] = 0
	end
	local cur = PallyPower_AuraAssignments[name]
	for test = cur + 1, PALLYPOWER_MAXAURAS do
		if self:HasAura(name, test) then
			cur = test
			do
				break
			end
		end
	end
	if (cur == PallyPower_AuraAssignments[name]) then
		if skipzero and self:HasAura(name, 1) then
			cur = 1
		else
			cur = 0
		end
	end
	PallyPower_AuraAssignments[name] = cur
	local msgQueue
	msgQueue =
		C_Timer.NewTimer(
		2.0,
		function()
			self:SendMessage("AASSIGN " .. name .. " " .. PallyPower_AuraAssignments[name])
			self:UpdateLayout()
			msgQueue:Cancel()
		end
	)
end

function PallyPower:PerformAuraCycleBackwards(name, skipzero)
	if not PallyPower_AuraAssignments[name] then
		PallyPower_AuraAssignments[name] = 0
	end
	local cur = PallyPower_AuraAssignments[name] - 1
	if (cur < 0) or (skipzero and (cur < 1)) then
		cur = PALLYPOWER_MAXAURAS
	end
	for test = cur, 0, -1 do
		if self:HasAura(name, test) or (test == 0 and not skipzero) then
			PallyPower_AuraAssignments[name] = test
			local msgQueue
			msgQueue =
				C_Timer.NewTimer(
				2.0,
				function()
					self:SendMessage("AASSIGN " .. name .. " " .. PallyPower_AuraAssignments[name])
					self:UpdateLayout()
					msgQueue:Cancel()
				end
			)
			do
				break
			end
		end
	end
end

function PallyPower:IsAuraActive(aura)
	local bFound = false
	local bSelfCast = false
	if (aura and aura > 0) then
		local spell = self.Auras[aura]
		local j = 1
		local buffName, _, _, _, _, buffExpire, castBy = UnitBuff("player", j)
		while buffExpire do
			if buffName == spell then
				bFound = true
				bSelfCast = (castBy == "player")
				do
					break
				end
			end
			j = j + 1
			buffName, _, _, _, _, buffExpire, castBy = UnitBuff("player", j)
		end
	end
	return bFound, bSelfCast
end

function PallyPower:UpdateAuraButton(aura)
	local pallys = {}
	local auraBtn = _G["PallyPowerAura"]
	local auraIcon = _G["PallyPowerAuraIcon"]
	if (aura and aura > 0) then
		for name in pairs(AllPallys) do
			if (name ~= self.player) and (AllPallys[name].subgroup == AllPallys[self.player].subgroup) and (aura == PallyPower_AuraAssignments[name]) then
				tinsert(pallys, name)
			end
		end
		local name, _, icon = GetSpellInfo(self.Auras[aura])
		if (not InCombatLockdown()) then
			auraIcon:SetTexture(icon)
			auraBtn:SetAttribute("spell", name)
		end
	else
		if (not InCombatLockdown()) then
			auraIcon:SetTexture(nil)
			auraBtn:SetAttribute("spell", "")
		end
	end
	-- only support two lines of text, so only deal with the first two players in the list...
	local player1 = _G["PallyPowerAuraPlayer1"]
	if pallys[1] then
		local shortpally1 = Ambiguate(pallys[1], "short")
		player1:SetText(shortpally1)
		player1:SetTextColor(1.0, 1.0, 1.0)
	else
		player1:SetText("")
	end
	local player2 = _G["PallyPowerAuraPlayer2"]
	if pallys[2] then
		local shortpally2 = Ambiguate(pallys[2], "short")
		player2:SetText(shortpally2)
		player2:SetTextColor(1.0, 1.0, 1.0)
	else
		player2:SetText("")
	end
	local btnColour = self.opt.cBuffGood
	local active, selfCast = self:IsAuraActive(aura)
	if (active == false) then
		btnColour = self.opt.cBuffNeedAll
	elseif (selfCast == false) then
		btnColour = self.opt.cBuffNeedSome
	end
	self:ApplyBackdrop(auraBtn, btnColour)
end

function PallyPower:AutoAssignAuras(precedence)
	local pallys = {}
	for i = 1, 8 do
		pallys[("subgroup%d"):format(i)] = {}
	end
	for name in pairs(AllPallys) do
		if AllPallys[name].subgroup then
			local subgroup = "subgroup" .. AllPallys[name].subgroup
			if self:CanControl(name) then
				tinsert(pallys[subgroup], name)
			end
		end
	end
	for _, subgroup in pairs(pallys) do
		for _, aura in pairs(precedence) do
			local assignee = ""
			local testRank = 0
			local testTalent = 0
			for _, pally in pairs(subgroup) do
				if self:HasAura(pally, aura) and (AllPallys[pally].AuraInfo[aura].rank >= testRank) then
					testRank = AllPallys[pally].AuraInfo[aura].rank
					if AllPallys[pally].AuraInfo[aura].talent >= testTalent then
						testTalent = AllPallys[pally].AuraInfo[aura].talent
						assignee = pally
					end
				end
			end
			if assignee ~= "" then
				for i, name in pairs(subgroup) do
					if assignee == name then
						tremove(subgroup, i)
						PallyPower_AuraAssignments[assignee] = aura
						self:SendMessage("AASSIGN " .. assignee .. " " .. aura)
					end
				end
			end
		end
	end
end

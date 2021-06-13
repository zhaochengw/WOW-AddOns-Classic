--[[
ADDON:SpellWhisper
THANKS TO: Mariatakagi BabyAnnie(玉儿宝贝)
]]
--版本控制：2.1.1 取消对TradeLog的支持

local AddonName, Addon = ...
local L = Addon.L

Addon.Version = GetAddOnMetadata(AddonName, "Version")
Addon.VerNum = 0
Addon.PrefixSW = "SWPX"
Addon.HasTask = false
Addon.Followed = {
	["UnitIndex"] = "player",
	["GUID"] = "",
	["StartTime"] = 0,
	["FromWhisper"] = false,
}

Addon.Output = {} -- 交易记录输出窗口

Addon.MinimapIcon = {} -- 小地图按钮

Addon.CurrentSpellListText = ""
--不需要保存的内容
Addon.MissReason = {		--Miss原因
--	["ABSORB"] = L["ABSORB"],
--	["BLOCK"] = L["BLOCK"],
--	["DEFLECT"] = L["DEFLECT"],
	["DODGE"] = L["DODGE"],
--	["EVADE"] = L["EVADE"],
	["IMMUNE"] = L["IMMUNE"],
	["MISS"] = L["MISS"],
	["PARRY"] = L["PARRY"],
	["REFLECT"] = L["REFLECT"],
	["RESIST"] = L["RESIST"],
}
Addon.FailReason = {		--失败原因
	["Out of range"] = L["Out of range"],
	["Target not in line of sight"] = L["Target not in line of sight"],
}
Addon.RaidIconList = {		--RaidIcon标记
	[1] = L["Star"],
	[2] = L["Circle"],
	[3] = L["Diamond"],
	[4] = L["Triangle"],
	[5] = L["Moon"],
	[6] = L["Square"],
	[7] = L["Cross"],
	[8] = L["Skull"],
}

--需要存入SavedVariables的内容
Addon.Config = { --默认config
	["IsEnable"] = true,
	["ThreatType"] = "worldboss",
	["SelfOnly"] = false,
	["DelayTips"] = true,
	["IsWhisperEnable"] = true,
	["IsBGWarningEnable"] = true,
	["WaitTime"] = 8,
	["BreakTime"] = 8,
	["OutputChannel"] = "raid",
	["ToTWarningEnable"] = false,
	["CombatFollow"] = false,
	["StartFollow"] = "",
	["StopFollow"] = "",
	["CombatFollowSwitchKey"] = "",
	["SelectedSpellType"] = "Other",
	["SelectedSpellOutputType"] = "SPELLWHISPER_TEXT_SENTTOGROUPDONE",
	["SpellOutput"] = {},
	["ShowMinimapIcon"] = true,
	["MinimapIconAngle"] = 180,
	["HUDPos"] = {[1] = "CENTER", [2] = true, [3] = "CENTER", [4] = 0, [5] = 240,},
}
--运行监控法术表
Addon.RunTime = {
	InstantHarm = {},
	InstantHelp = {},
	CastHarm = {},
	CastHelp = {},
	SelfBuff = {},
	Healing = {},
	Other = {},
	Ignore = {},
}
--默认监控法术列表
Addon.Default = {
	InstantHarm = {
		--瞬发控制
		[L["Repentance"]] = L["Repentance"],
		[L["Wyvern Sting"]] = L["Wyvern Sting"],
		[L["Gouge"]] = L["Gouge"],
		[L["Hammer of Justice"]] = L["Hammer of Justice"],
		[L["Scatter Shot"]] = L["Scatter Shot"],
		[L["Blind"]] = L["Blind"],
		[L["Sap"]] = L["Sap"],
		[L["Death Coil"]] = L["Death Coil"],
		[L["Intimidating Shout"]] = L["Intimidating Shout"],
		[L["Psychic Scream"]] = L["Psychic Scream"],
	},
	InstantHelp = {
		--瞬发增益
		[L["Innervate"]] = L["Innervate"],
		[L["Fear Ward"]] = L["Fear Ward"],
		[L["Power Infusion"]] = L["Power Infusion"],
		[L["Divine Intervention"]] = L["Divine Intervention"],
		[L["Blessing of Protection"]] = L["Blessing of Protection"],
		[L["Blessing of Freedom"]] = L["Blessing of Freedom"],
		[L["Lay on Hands"]] = L["Lay on Hands"],
	},
	CastHarm = {
		--施法控制
		[L["Polymorph"]] = L["Polymorph"],
		[L["Hibernate"]] = L["Hibernate"],
		[L["Shackle Undead"]] = L["Shackle Undead"],
		[L["Banish"]] = L["Banish"],
		[L["Fear"]] = L["Fear"],
		[L["Howl of Terror"]] = L["Howl of Terror"],
		[L["Entangling Roots"]] = L["Entangling Roots"],
		[L["Turn Undead"]] = L["Turn Undead"],
		[L["Enslave Demon"]] = L["Enslave Demon"],
		[L["Scare Beast"]] = L["Scare Beast"],
	},
	CastHelp = {
		--施法增益
		[L["Rebirth"]] = L["Rebirth"],
		[L["Resurrection"]] = L["Resurrection"],
		[L["Redemption"]] = L["Redemption"],
		[L["Ancestral Spirit"]] = L["Ancestral Spirit"],
		[L["Ritual of Summoning"]] = L["Ritual of Summoning"],
		[L["Soulstone Resurrection"]] = L["Soulstone Resurrection"],
	},
	SelfBuff = {
		[L["Shield Wall"]] = L["Shield Wall"],
		[L["Last Stand"]] = L["Last Stand"],
		[L["Gift of Life"]] = L["Gift of Life"],
	},
	Healing = {
		--治疗法术
		[L["Holy Light"]] = L["Holy Light"],
		[L["Flash of Light"]] = L["Flash of Light"],
		[L["Lay on Hands"]] = L["Lay on Hands"],
		[L["Holy Shock"]] = L["Holy Shock"],
		[L["Lesser Healing Wave"]] = L["Lesser Healing Wave"],
		[L["Healing Wave"]] = L["Healing Wave"],
		[L["Chain Heal"]] = L["Chain Heal"],
		[L["Healing Touch"]] = L["Healing Touch"],
		[L["Regrowth"]] = L["Regrowth"],
		[L["Rejuvenation"]] = L["Rejuvenation"],
		[L["Swiftmend"]] = L["Swiftmend"],
		[L["Power Word: Shield"]] = L["Power Word: Shield"],
		[L["Heal"]] = L["Heal"],
		[L["Lesser Heal"]] = L["Lesser Heal"],
		[L["Renew"]] = L["Renew"],
		[L["Flash Heal"]] = L["Flash Heal"],
		[L["Greater Heal"]] = L["Greater Heal"],
	},
	Other = {
		--其他需要通告的被抵抗技能
		[L["Taunt"]] = L["Taunt"],
		[L["Mocking Blow"]] = L["Mocking Blow"],
		[L["Challenging Shout"]] = L["Challenging Shout"],
		[L["Shield Slam"]] = L["Shield Slam"],
		[L["Growl"]] = L["Growl"],
		[L["Challenging Roar"]] = L["Challenging Roar"],
		-- [L["Kidney Shot"]] = L["Kidney Shot"],
		-- [L["Feign Death"]] = L["Feign Death"],
	},
	Ignore = {
		--不存在打破的控制技能
		[L["Banish"]] = L["Banish"],
		[L["Fear"]] = L["Fear"],
		[L["Howl of Terror"]] = L["Howl of Terror"],
		[L["Entangling Roots"]] = L["Entangling Roots"],
		[L["Turn Undead"]] = L["Turn Undead"],
		[L["Enslave Demon"]] = L["Enslave Demon"],
		[L["Scare Beast"]] = L["Scare Beast"],
	},
}

--注册Frames
Addon.Frame = CreateFrame("Frame", AddonName .. "Frame")
Addon.Frame:Hide()
Addon.Warning = CreateFrame("Frame", AddonName .. "Warning")
Addon.Warning:SetSize(400, 50)
Addon.Warning:SetMovable(false)
Addon.Warning:RegisterForDrag("MiddleButton")
Addon.Warning:EnableMouse(false)
Addon.Warning:SetScript("OnDragStart", Addon.Warning.StartMoving)
Addon.Warning:SetScript("OnDragStop", Addon.Warning.StopMovingOrSizing)
Addon.Warning.Text = Addon.Warning:CreateFontString(nil, "ARTWORK", "GameFontNormalLargeLeft")
Addon.Warning.Text:SetPoint("CENTER", 0, 0)
Addon.Warning.Text:SetTextHeight(30)
Addon.Warning.Text:Hide()
Addon.Panel = CreateFrame("Frame", AddonName .. "Panel")
Addon.Panel:Hide()
Addon.ScrollFrame = CreateFrame("ScrollFrame", nil, UIParent, "UIPanelScrollFrameTemplate")
Addon.ScrollFrame:Hide()

--Frame方法
function Addon.Warning:AddMessage(msg)
	-- msg = string.gsub(msg, "[%[%]]", "|cFFFF143C[%[%]]|r")
	Addon.Warning.Text:SetText(msg)
	C_Timer.After(3, function()
		if Addon.Warning.Text:GetText() == msg then
			Addon.Warning.Text:SetText("")
		end
	end)
end
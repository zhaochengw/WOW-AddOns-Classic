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
	-- ["DEFLECT"] = L["DEFLECT"],
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
	Notips = {},
}
--默认监控法术列表
Addon.Default = {
	InstantHarm = {
		--瞬发控制
		[(GetSpellInfo(20066))] = true, -- Repentance
		[(GetSpellInfo(19386))] = true, -- Wyvern Sting
		[(GetSpellInfo(1776))] = true, -- Gouge
		[(GetSpellInfo(853))] = true, -- Hammer of Justice
		[(GetSpellInfo(19503))] = true, -- Scatter Shot
		[(GetSpellInfo(2094))] = true, -- Blind
		[(GetSpellInfo(2070))] = true, -- Sap
		[(GetSpellInfo(6789))] = true, -- Death Coil
		[(GetSpellInfo(5246))] = true, -- Intimidating Shout
		[(GetSpellInfo(8122))] = true, -- Psychic Scream
		[(GetSpellInfo(31661))] = true, -- Dragon's Breath
		[(GetSpellInfo(34490))] = true, -- Silencing Shot
		[(GetSpellInfo(15487))] = true, -- Silence
	},
	InstantHelp = {
		--瞬发增益
		[(GetSpellInfo(29166))] = true, -- Innervate
		[(GetSpellInfo(6346))] = true, -- Fear Ward
		[(GetSpellInfo(10060))] = true, -- Power Infusion
		[(GetSpellInfo(19752))] = true, -- Divine Intervention
		[(GetSpellInfo(1022))] = true, -- Blessing of Protection
		[(GetSpellInfo(1044))] = true, -- Blessing of Freedom
		[(GetSpellInfo(633))] = true, -- Lay on Hands
		[(GetSpellInfo(33206))] = true, -- Pain Suppression
	},
	CastHarm = {
		--施法控制
		[(GetSpellInfo(118))] = true, -- Polymorph
		[(GetSpellInfo(2637))] = true, -- Hibernate
		[(GetSpellInfo(9484))] = true, -- Shackle Undead
		[(GetSpellInfo(710))] = true, -- Banish
		[(GetSpellInfo(5782))] = true, -- Fear
		[(GetSpellInfo(5484))] = true, -- Howl of Terror
		[(GetSpellInfo(339))] = true, -- Entangling Roots
		[(GetSpellInfo(2878))] = true, -- Turn Undead
		[(GetSpellInfo(1098))] = true, -- Enslave Demon
		[(GetSpellInfo(1513))] = true, -- Scare Beast
		[(GetSpellInfo(33786))] = true, -- Cyclone
	},
	CastHelp = {
		--施法增益
		[(GetSpellInfo(20484))] = true, -- Rebirth
		[(GetSpellInfo(2006))] = true, -- Resurrection
		[(GetSpellInfo(7328))] = true, -- Redemption
		[(GetSpellInfo(2008))] = true, -- Ancestral Spirit
		[(GetSpellInfo(698))] = true, -- Ritual of Summoning
		[(GetSpellInfo(20707))] = true, -- Soulstone Resurrection
	},
	SelfBuff = {
		[(GetSpellInfo(871))] = true, -- Shield Wall
		[(GetSpellInfo(12975))] = true, -- Last Stand
		[(GetSpellInfo(23725))] = true, -- Gift of Life
	},
	Healing = {
		--治疗法术
		[(GetSpellInfo(635))] = true, -- Holy Light
		[(GetSpellInfo(19750))] = true, -- Flash of Light
		[(GetSpellInfo(633))] = true, -- Lay on Hands
		[(GetSpellInfo(20473))] = true, -- Holy Shock
		[(GetSpellInfo(8004))] = true, -- Lesser Healing Wave
		[(GetSpellInfo(331))] = true, -- Healing Wave
		[(GetSpellInfo(1064))] = true, -- Chain Heal
		[(GetSpellInfo(5185))] = true, -- Healing Touch
		[(GetSpellInfo(8936))] = true, -- Regrowth
		[(GetSpellInfo(774))] = true, -- Rejuvenation
		[(GetSpellInfo(18562))] = true, -- Swiftmend
		[(GetSpellInfo(17))] = true, -- Power Word: Shield
		[(GetSpellInfo(2054))] = true, -- Heal
		[(GetSpellInfo(2050))] = true, -- Lesser Heal
		[(GetSpellInfo(139))] = true, -- Renew
		[(GetSpellInfo(2061))] = true, -- Flash Heal
		[(GetSpellInfo(2060))] = true, -- Greater Heal
		-- TBC
		[(GetSpellInfo(33763))] = true, -- Lifebloom
		[(GetSpellInfo(32546))] = true, -- Binding Heal
		[(GetSpellInfo(33076))] = true, -- Prayer of Mending
	},
	Other = {
		--其他需要通告的被抵抗技能
		[(GetSpellInfo(355))] = true, -- Taunt
		[(GetSpellInfo(694))] = true, -- Mocking Blow
		[(GetSpellInfo(1161))] = true, -- Challenging Shout
		[(GetSpellInfo(23922))] = true, -- Shield Slam
		[(GetSpellInfo(6795))] = true, -- Growl
		[(GetSpellInfo(5209))] = true, -- Challenging Roar
		[(GetSpellInfo(5384))] = true, -- Feign Death
		-- Kidney Shot
		-- Feign Death
	},
	Ignore = {
		--不存在打破的控制技能
		[(GetSpellInfo(710))] = true, -- Banish
		[(GetSpellInfo(5782))] = true, -- Fear
		[(GetSpellInfo(5484))] = true, -- Howl of Terror
		[(GetSpellInfo(339))] = true, -- Entangling Roots
		[(GetSpellInfo(2878))] = true, -- Turn Undead
		[(GetSpellInfo(1098))] = true, -- Enslave Demon
		[(GetSpellInfo(1513))] = true, -- Scare Beast
		[(GetSpellInfo(6789))] = true, -- Death Coil
		[(GetSpellInfo(5246))] = true, -- Intimidating Shout
		[(GetSpellInfo(8122))] = true, -- Psychic Scream
		[(GetSpellInfo(34490))] = true, -- Silencing Shot
		[(GetSpellInfo(15487))] = true, -- Silence
	},
	Notips = {
		-- 不需要提示破控的技能
		[(GetSpellInfo(8218))] = true, -- Sneak
		[(GetSpellInfo(31661))] = true, -- Dragon's Breath
		[(GetSpellInfo(1776))] = true, -- Gouge
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
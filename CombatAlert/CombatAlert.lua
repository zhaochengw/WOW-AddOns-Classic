-----------------------------------
-- 離開和進入戰鬥,大文字提示
local _, ns = ...
--如需要显示中文，请注意文件编码格式UTF-8
ns.setting = {
	EnableCombat = true,		--开启进入/脱离战斗提示
	EnableHealth = false,		--开启低血量报警提示
	EnableInterrupt = false,		--开启打断提示
	EnableExecute = false,		--开启斩杀提示
	OnlyShowBoss = false,		--仅显示Boss的斩杀提示
	AutoThreshold = true,		--根据职业自动判断斩杀阶段
	ExecuteThreshold = 0.2,		--斩杀阶段血量
}

ns.texts = {
	EnterCombat = {
		"进入战斗！",
		
		},
	LeaveCombat = {
		"脱离战斗！",
		
		},
	ExecutePhase = {
		"!!斩杀!!",		
		},
	Hplow = {
		"血量低于35%",
		},
	Mplow = {
		"魔法值低于35%",
		},
}

ns.class = {
	["WARRIOR"] = { 0.2, 0.2, 0.2}, --每个职业每个天赋的斩杀阶段血量，统计可能不准确，0即为不显示，3个数字依次是3系天赋
	["DRUID"] = { 0, 0.25, 0.25},
	["PALADIN"] = { 0, 0, 0.2},
	["PRIEST"] = { 0, 0, 0.20},
	["DEATHKNIGHT"] = { 0, 0.35, 0},
	["WARLOCK"] = { 0.25, 0.25, 0.20},
	["ROGUE"] = { 0.35, 0, 0},
	["HUNTER"] = { 0.2, 0.2, 0.2},
	["MAGE"] = { 0, 0.35, 0},
	["SHAMAN"] = { 0, 0, 0},
	["MONK"] = { 0, 0, 0},	
}

local MyAddon = CreateFrame("Frame")
local imsg = CreateFrame("Frame", "CombatAlert")
imsg:SetSize(420, 70)
imsg:SetPoint("TOP", 0, -230)
imsg:Hide()
imsg.bg = imsg:CreateTexture(nil, 'BACKGROUND')
imsg.bg:SetTexture([[Interface\LevelUp\LevelUpTex]])
imsg.bg:SetPoint('BOTTOM')
imsg.bg:SetSize(326, 103)
imsg.bg:SetTexCoord(0.00195313, 0.63867188, 0.03710938, 0.23828125)
imsg.bg:SetVertexColor(1, 1, 1, 0.5)

imsg.lineTop = imsg:CreateTexture(nil, 'BACKGROUND')
imsg.lineTop:SetDrawLayer('BACKGROUND', 2)
imsg.lineTop:SetTexture([[Interface\LevelUp\LevelUpTex]])
imsg.lineTop:SetPoint("TOP")
imsg.lineTop:SetSize(420, 7)
imsg.lineTop:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

imsg.lineBottom = imsg:CreateTexture(nil, 'BACKGROUND')
imsg.lineBottom:SetDrawLayer('BACKGROUND', 2)
imsg.lineBottom:SetTexture([[Interface\LevelUp\LevelUpTex]])
imsg.lineBottom:SetPoint("BOTTOM")
imsg.lineBottom:SetSize(420, 7)
imsg.lineBottom:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

imsg.text = imsg:CreateFontString(nil, 'ARTWORK', 'GameFont_Gigantic')
imsg.text:SetPoint("BOTTOM", 0, 15)
imsg.text:SetTextColor(1, 0.82, 0)
imsg.text:SetJustifyH("CENTER")
imsg.text:SetFont("fonts\\ARHei.TTF", 36, "OUTLINE") -- 字体设置
CombatAlert:SetScale(0.9)

local flag = 0
ExecuteThreshold =  ns.setting.ExecuteThreshold
local function ShowAlert(texts)
	CombatAlert.text:SetText(texts[math.random(1,table.getn(texts))])
	CombatAlert:Show()
end

local function ShowInterruptAlert(texts,name)
	CombatAlert.text:SetText("打断—"..texts)
	CombatAlert:Show()
end

if ns.setting.EnableCombat then
	MyAddon:RegisterEvent("PLAYER_REGEN_ENABLED")
	MyAddon:RegisterEvent("PLAYER_REGEN_DISABLED")
end
if ns.setting.EnableHealth then
	MyAddon:RegisterEvent("UNIT_HEALTH")
end

if ns.setting.EnableExecute then
	MyAddon:RegisterEvent("UNIT_HEALTH")
	MyAddon:RegisterEvent("PLAYER_TARGET_CHANGED")
end
if ns.setting.AutoThreshold then
	MyAddon:RegisterEvent("PLAYER_ENTERING_WORLD")
end
if ns.setting.EnableInterrupt then
	MyAddon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

MyAddon:SetScript("OnEvent", function(self, event, _, subevent, _, _, sourceName, _, _, _, destName, _, _, _, _, _, spellID, spellName)
	if event == "PLAYER_REGEN_DISABLED" then
		ShowAlert(ns.texts.EnterCombat)
		flag = 0
	elseif event == "PLAYER_REGEN_ENABLED" then
		ShowAlert(ns.texts.LeaveCombat)
		flag = 0
	elseif event == "PLAYER_TARGET_CHANGED" then
		flag = 0
	elseif event == "UNIT_HEALTH" then
		if (UnitName("player") and (UnitHealth("player") / UnitHealthMax("player") < 0.35 and not UnitIsDead("player") and flag == 0 )) then
			ShowAlert(ns.texts.Hplow)
			flag = 1
		elseif (UnitName("target") and UnitCanAttack("player", "target") and not UnitIsDead("target") and ( UnitHealth("target")/UnitHealthMax("target") < ExecuteThreshold ) and flag == 0 ) then
			if ((ns.setting.OnlyShowBoss and UnitLevel("target")==-1) or ( not ns.setting.OnlyShowBoss)) then 
				ShowAlert(ns.texts.ExecutePhase)
				flag = 1
			end
		end

	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" and subevent=="SPELL_INTERRUPT" and (sourceName == UnitName("player") or sourceName == UnitName("pet")) then
		ShowInterruptAlert(spellName,destName)
	end
end)

local timer = 0
imsg:SetScript("OnShow", function(self)
	timer = 0
	self:SetScript("OnUpdate", function(self, elasped)
		timer = timer + elasped
		if (timer<0.5) then self:SetAlpha(timer*2) end
		if (timer>1 and timer<2) then self:SetAlpha(1-(timer-1)*2) end
		if (timer>=2 ) then self:Hide() end
	end)
end)
-------------------------------------

-- 打斷提示 
-------------------------------------
local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
frame:SetScript("OnEvent", function(self, event, ...)
    local _, subevent, _, _, sourceName, sourceFlag, _, _, destName, _, _, _, _, _, extraSpellID = CombatLogGetCurrentEventInfo()
    if (subevent ~= 'SPELL_INTERRUPT') then return end
    if (bit.band(sourceFlag, COMBATLOG_OBJECT_AFFILIATION_MINE) == 0) then return end
    if (not sourceName) then return end
    local msg = format("%s -%s- %s", sourceName or "", INTERRUPT, GetSpellLink(extraSpellID))
    if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
        SendChatMessage(msg, "INSTANCE_CHAT")
    elseif (IsInRaid()) then
        SendChatMessage(msg, "RAID")
    elseif (IsInGroup()) then
        SendChatMessage(msg, "PARTY")
    end
end)

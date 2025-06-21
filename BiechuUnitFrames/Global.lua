local addonName = ...
local BC = _G[addonName] or CreateFrame('Frame', addonName)
local L = _G[addonName .. 'Locale']
BC.charKey = UnitName('player') .. ' - ' .. GetRealmName()
BC.class = select(2, UnitClass('player'))
BC.texture = 'Interface\\AddOns\\' .. addonName .. '\\Textures\\'

-- 默认设置
BC.default = {
	global = {
		healthBarColor = true,
		nameClassColor = true,
		carry = 1,
		nameFont = L.fontList[1].value,
		valueFont = L.fontList[1].value,
		fontFlags = L.fontFlagsList[2].value,
		dragSystemFarmes = true,
		incomingHeals = true,
		autoTab = true,
		autoDalaran = true,
	},
	player = {
		relative = 'CENTER',
		offsetX = -223,
		offsetY = -98,
		combatFlash = true,
		miniIcon = true,
		autoTalentEquip = true,
		equipmentIcon = true,
		hidePartyNumber = true,
		fiveSecondRule = true,
		druidBar = true,
		nameFontSize = 13,
		valueFontSize = 12,
		valueStyle = 9,
		drag = true,
		scale = 1,
		border = 1,
		portrait = 0,
	},
	pet = {
		anchor = 'PlayerFrame',
		relative = 'TOPLEFT',
		offsetX = 84,
		offsetY = not UnitHasVehiclePlayerFrameUI('player') and (BC.class == 'DEATHKNIGHT' or BC.class == 'SHAMAN') and -80 or -61,
		hideName = true,
		nameFontSize = 10,
		valueFontSize = 10,
		valueStyle = 2,
	},
	pettarget = {
		anchor = 'PetFrame',
		relative = 'BOTTOMRIGHT',
		offsetX = 58,
		offsetY = -8,
		portrait = 1,
		outRange = true,
		hideName = true,
		nameFontSize = 12,
		valueFontSize = 12,
		valueStyle = 7,
		scale = .6,
	},
	target = {
		relative = 'CENTER',
		offsetX = 223,
		offsetY = -98,
		combatFlash = true,
		threatLeft = true,
		miniIcon = true,
		statusBarAlpha = .5,
		nameFontSize = 13,
		valueFontSize = 12,
		valueStyle = 7,
		drag = true,
		scale = 1,
		selfCooldown = true,
		dispelCooldown = true,
		dispelStealable = true,
		auraSize = 20,
		auraPercent = .8,
		auraRows = 5,
		auraX = 6,
		auraY = 52,
	},
	targettarget = {
		anchor = 'TargetFrame',
		relative = 'BOTTOMRIGHT',
		offsetX = -35,
		offsetY = -10,
		outRange = true,
		nameFontSize = 10,
		valueFontSize = 10,
		valueStyle = 2,
	},
	focus = {
		relative = 'CENTER',
		offsetX = -418,
		offsetY = -98,
		combatFlash = true,
		threatLeft = true,
		miniIcon = true,
		statusBarAlpha = .5,
		nameFontSize = 13,
		valueFontSize = 12,
		valueStyle = 7,
		drag = true,
		scale = 1,
		selfCooldown = true,
		dispelCooldown = true,
		dispelStealable = true,
		auraSize = 20,
		auraPercent = .8,
		auraRows = 5,
		auraX = 6,
		auraY = 52,
	},
	focustarget = {
		anchor = 'FocusFrame',
		relative = 'BOTTOMRIGHT',
		offsetX = -35,
		offsetY = -10,
		outRange = true,
		nameFontSize = 10,
		valueFontSize = 10,
		valueStyle = 2,
	},
	party = {
		relative = 'LEFT',
		offsetX = 190,
		offsetY = 325,
		portraitCombat = true,
		combatFlash = true,
		outRange = true,
		raidShowParty = true,
		showLevel = true,
		showCastBar = true,
		nameFontSize = 10,
		valueFontSize = 10,
		valueStyle = 7,
		drag = true,
		scale = 1,
		selfCooldown = true,
		dispelCooldown = true,
		dispelStealable = true,
		auraRows = 16,
		auraSize = 16,
		auraPercent = .8,
		auraX = 1,
		auraY = 18,
	},
	partypet = {
		relative = 'BOTTOMRIGHT',
		offsetX = -22,
		offsetY = -1,
		hideName = true,
		nameFontSize = 7,
		valueFontSize = 7,
		valueStyle = 7,
	},
	partytarget = {
		relative = 'TOPRIGHT',
		offsetX = 150,
		offsetY = 2,
		outRange = true,
		nameFontSize = 10,
		valueFontSize = 10,
		valueStyle = 7,
		scale = 1,
	},
}

-- 单元框体
BC.unitList = {
	'player',
	'pet',
	'pettarget',
	'target',
	'targettarget',
	'focus',
	'focustarget',
	'party1',
	'party2',
	'party3',
	'party4',
	'party1pet',
	'party2pet',
	'party3pet',
	'party4pet',
	'party1target',
	'party2target',
	'party3target',
	'party4target',
}

-- 边框材质
BC.borderList = {
	'TargetingFrame\\UI-TargetingFrame',
	'TargetingFrame\\UI-TargetingFrame-Rare',
	'TargetingFrame\\UI-TargetingFrame-Rare-Elite',
	'TargetingFrame\\UI-TargetingFrame-Elite',
	'TargetingFrame\\UI-SmallTargetingFrame',
	'TargetingFrame\\UI-TargetofTargetFrame',
	'TargetingFrame\\UI-PartyFrame',
}

-- 条材质
BC.barList = {
	'TargetingFrame\\UI-StatusBar', -- 条背景
	'Tooltips\\UI-StatusBar-Border', -- 边框
	'CastingBar\\UI-CastingBar-Border-Small', -- 队友施法条边框
	'CastingBar\\UI-CastingBar-Small-Shield', -- 队友施法条边框(无法打断)
}

-- 头像材质
BC.portraitList = {
	[0] = 'New-Class-Icon',
	[1] = 'TargetingFrame\\UI-Classes-Circles',
	[2] = 'Cat',
	[3] = 'Dog',
	[4] = 'Panda',
	[5] = 'Moonkin',
	[6] = 'CoolFace',
}

-- 种类图标
BC.creatureList = {
	[1] = 'Interface\\Icons\\Ability_Racial_BearForm', -- 野兽
	[2] = 'Interface\\Icons\\Spell_Holy_PrayerOfHealing', -- 人型生物
	[3] = 'Interface\\Icons\\INV_Misc_Head_Dragon_01', -- 龙类
	[4] = 'Interface\\Icons\\INV_Gizmo_02', -- 机械
	[5] = 'Interface\\Icons\\Spell_Shadow_Metamorphosis', -- 恶魔
	[6] = 'Interface\\Icons\\Spell_Frost_SummonWaterElemental', -- 元素生物
	[7] = 'Interface\\Icons\\Ability_Racial_Avatar', -- 巨人
	[8] = 'Interface\\Icons\\Spell_Shadow_RaiseDead', -- 亡灵
	[9] = 'Interface\\Icons\\Spell_Nature_NatureResistanceTotem', -- 图腾
	[10] = 'Interface\\Icons\\spell_shadow_antishadow', -- 畸变怪
	[11] = 'Interface\\Icons\\ABILITY_SEAL', -- 小动物
	[12] = 'Interface\\Icons\\INV_Elemental_Mote_Air01', -- 气体云雾
	[13] = 'Interface\\Icons\\Spell_Nature_Polymorph', -- 非战斗宠物
	[14] = 'Interface\\Icons\\INV_Misc_QuestionMark', -- 未指定
}

-- 材质切换
function BC:file(file, dark)
	return 'Interface\\'.. ((dark or BC:getDB('global', 'dark')) and 'AddOns\\' .. addonName .. '\\Textures\\' .. file:gsub('.-([^\\/]-%.?[^%.\\/]*)$', '%1') or file)
end

-- 获取玩家载具单位
function BC:vehicleUnit(unit)
	if UnitHasVehiclePlayerFrameUI('player') then
		if unit == 'pet' or unit == 'vehicle' then
			return 'player'
		elseif unit == 'player' then
			return 'pet'
		end
	end
	return unit
end

-- 格式化单位
function BC:formatUnit(unit)
	return type(unit) == 'string' and unit:gsub('-', ''):gsub('^partypet(%d)$', 'party%1pet')
end

-- 读取变量
function BC:getDB(key, name)
	if type(key) ~= 'string' then return end
	local db = BiechuUnitFramesDB or {}
	if key == 'cache' then
		db.cache = db.cache or {}
		return db.cache[name]
	end

	db.config = db.config or {}
	local config = db.config[self.charKey] or 'Public'
	if key == 'config' then return config end

	db = db[config] or {}
	if type(db) == 'table' and type(db[key]) == 'table' and db[key][name] ~= nil then
		return db[key][name]
	elseif type(self.default[key]) == 'table' then
		return self.default[key][name]
	end
end

-- 保存变量
function BC:setDB(key, name, value)
	if type(key) ~= 'string' then return end
	local db = BiechuUnitFramesDB or {}

	if key == 'cache' then
		db.cache = db.cache or {}
		db.cache[name] = value
		return
	end

	db.config = db.config or {}
	if key == 'config' then
		db.config[self.charKey] = name
	else
		local config = db.config[self.charKey] or 'Public'
			if key == 'reset' then
			db[config] = nil
		else
			db[config] = db[config] or {}
			db[config][key] = db[config][key] or {}
			if self.default[key] and self.default[key][name] == value then
				db[config][key][name] = nil
			else
				db[config][key][name] = value
			end
		end
	end
	BiechuUnitFramesDB = db
	if self[key] then
		self:init(key)
	elseif key == 'party' then
		for i = 1, MAX_PARTY_MEMBERS do
			self:init('party' .. i)
		end
	elseif key == 'partypet' then
		for i = 1, MAX_PARTY_MEMBERS do
			self:init('party' .. i .. 'pet')
		end
	elseif key == 'partytarget' then
		for i = 1, MAX_PARTY_MEMBERS do
			self:init('party' .. i .. 'target')
		end
	elseif key == 'global' or key == 'config' or key == 'reset' then
		self:init()
	end
end

-- 确认
function BC:comfing(text, accept)
	StaticPopupDialogs[addonName .. 'Comfing'] = {
		text = text,
		button1 = OKAY,
		button2 = CANCEL,
		OnAccept = accept,
		OnCancel = function (self) end,
		hideOnEscape = 1,
		timeout = 0,
		whileDead = 1,
	}
	StaticPopup_Show(addonName .. 'Comfing'):SetFrameStrata('TOOLTIP')
end

-- 非战斗中按住Shift拖动
function BC:drag(frame, parent, drag, callBack)
	local mover = parent or frame
	if not frame or not mover then return end

	frame:SetScript('OnMouseDown', function(self, button)
		if InCombatLockdown() or button ~= 'LeftButton' then return end
		if type(callBack) == 'function' then
			if not drag or not IsShiftKeyDown() then return end
		elseif not BC:getDB('global', 'dragSystemFarmes') then
			return
		end

		self.moving = true
		mover:SetMovable(true) -- 允许移动
		mover:SetClampedToScreen(true) -- 屏幕内移动
		mover:StartMoving()
	end)
	frame:SetScript('OnMouseUp', function(self)
		if self.moving then
			mover:StopMovingOrSizing()
			mover:SetUserPlaced(self.unit == 'player' or self.unit == 'vehicle') -- 不保存在 layout-local.txt
			if type(callBack) == 'function' then callBack(mover) end
		end
		self.moving = nil
	end)
end
BC:drag(QuestFrame) -- 任务对话框
BC:drag(GossipFrame) -- 对话框
BC:drag(MerchantFrame) -- 购物框
BC:drag(PetStableFrame) -- 宠物存放处
BC:drag(PaperDollFrame, CharacterFrame) -- 角色信息
BC:drag(PetPaperDollFrame, CharacterFrame) -- 宠物信息
BC:drag(ReputationFrame, CharacterFrame) -- 声望
BC:drag(SkillFrame, CharacterFrame) -- 技能
BC:drag(HonorFrame, CharacterFrame) -- 荣誉
BC:drag(SpellBookFrame) -- 法术书和技能
BC:drag(QuestLogFrame) -- 任务日志
BC:drag(FriendsFrame) -- 社交
BC:drag(CommunitiesFrame) -- 群组
BC:drag(PVPFrame, PVPParentFrame) -- PVP
BC:drag(BattlefieldFrame, PVPParentFrame) -- 战场
BC:drag(PVEFrame) -- 地下城与副本查找器
BC:drag(GameMenuFrame) -- 主菜单
BC:drag(HelpFrame) -- 客服支持
BC:drag(SettingsPanel) -- 设置选项
BC:drag(AddonList) -- 插件列表
BC:drag(GossipFrame) -- 对话框
BC:drag(MerchantFrame) -- 购物框
hooksecurefunc('UIParentLoadAddOn', function(addon)
	if addon == 'Blizzard_TrainerUI' then -- 技能训练对话框
		BC:drag(ClassTrainerFrame)
	elseif addon == 'Blizzard_TalentUI' then -- 天赋
		BC:drag(PlayerTalentFrame)
	elseif addon == 'Blizzard_MacroUI' then -- 宏命令设置
		BC:drag(MacroFrame)
	elseif addon == 'Blizzard_AchievementUI' then -- 成就
		BC:drag(AchievementFrameHeader, AchievementFrame)
		BC:drag(AchievementFrameCategoriesContainer, AchievementFrame)
	elseif addon == 'Blizzard_Collections' then -- 藏品
		BC:drag(WardrobeFrame) -- 幻化对话框
		BC:drag(CollectionsJournal)
	end
end)

-- 保护性驱散Debuff
BC.debuffTable = {
	['Curse'] = {
		2782, -- 德鲁伊 解除诅咒
		475, -- 法师 解除诅咒
	},
	['Disease'] = {
		4987, -- 圣骑士 清洁术
		528, -- 牧师 祛病术
		552, -- 牧师 驱除疾病
		2870, -- 萨满 祛病术
		8170, -- 萨满 净化图腾
	},
	['Magic'] = {
		4987, -- 圣骑士 清洁术
		527, -- 牧师 驱散魔法
		19505, -- 术士 吞噬魔法
	},
	['Poison'] = {
		2893, -- 德鲁伊 驱毒术
		8946, -- 德鲁伊 消毒术
		4987, -- 圣骑士 清洁术
		526, -- 萨满 驱毒术
		8170, -- 萨满 净化图腾
	},
}
-- 进攻性驱散Buff
BC.buffTable = {
	['Magic'] = {
		527, -- 牧师 驱散魔法
		19505, -- 术士 吞噬魔法
		370, -- 萨满 净化术
	},
	[''] = { -- 激怒
		19801, -- 猎人 宁神射击
	}
}
function BC:dispel(unit, dispelType)
	local spell
	if UnitCanAttack('player', unit) then
		spell = self.buffTable[dispelType]
	elseif UnitIsFriend('player', unit) then
		spell = self.debuffTable[dispelType]
	end
	if not spell then return end
	for _, id in pairs(spell) do
		if GetSpellInfo(GetSpellInfo(id)) then
			return id
		end
	end
end

-- 宠物/队友buff/debuff直接显示时隐藏buff鼠标提示
hooksecurefunc('PartyMemberBuffTooltip_Update', function()
	PartyMemberBuffTooltip:Hide()
end)

-- OmniCC 冷却倒计时立即更新
hooksecurefunc('CooldownFrame_Set', function(self)
	if self:IsShown() and self._occ_show ~= nil then
		self:Hide()
		self:Show()
	end
end)

-- Buff/Debuff
function BC:aura(unit)
	unit = self:formatUnit(unit)
	if not unit then return end
	local frame = self[unit]
	if not frame then return end
	local key = unit:gsub('%d', '')
	local maxBuffs = MAX_TARGET_BUFFS -- 最多Buff
	local maxDebuffs = MAX_TARGET_DEBUFFS -- 最多Debuff
	local rows = self:getDB(key, 'auraRows') or maxDebuffs -- 一行Buff/Debuff数量
	local size = self:getDB(key, 'auraSize') or 20 -- Buff/Debuff图标大小
	local percent = self:getDB(key, 'auraPercent') or .8 -- 显示百分比
	local auraX = self:getDB(key, 'auraX') -- 起始坐标X
	local auraY = self:getDB(key, 'auraY') -- 起始坐标Y
	local spac = 2 -- 间隔
	local dark = self:getDB('global', 'dark')
	local valueFont = self:getDB('global', 'valueFont')
	local fontFlags = self:getDB('global', 'fontFlags')
	local selfCooldown = self:getDB(key, 'selfCooldown')
	local dispelCooldown = self:getDB(key, 'dispelCooldown')
	local dispelStealable = self:getDB(key, 'dispelStealable')
	local total = 0
	local x = auraX
	for i = 1, maxBuffs do
		local name = frame:GetName() .. 'Buff' .. i
		local buff = _G[name] or key == 'party' and CreateFrame('Button', name, frame)
		if not buff then break end

		buff:SetFrameLevel(5)
		buff.icon = _G[name .. 'Icon']
		if not buff.icon then
			buff.icon = buff:CreateTexture(name .. 'Icon', 'BACKGROUND')
			buff.icon:SetPoint('CENTER')
		end
		buff.icon:SetTexCoord(.05, .95, .05, .95)

		buff.cooldown = _G[name .. 'Cooldown']
		if not buff.cooldown then
			buff.cooldown = CreateFrame('Cooldown', name .. 'Cooldown', buff, 'CooldownFrameTemplate')
			buff.cooldown:SetReverse(true)
		end

		buff.count = _G[name .. 'Count'] or buff:CreateFontString(name .. 'Count', 'OVERLAY')
		buff.count:SetPoint('BOTTOMRIGHT', 2, -2)

		buff.stealable = _G[name .. 'Stealable']
		if not buff.stealable then
			buff.stealable = buff:CreateTexture(name .. 'Stealable', 'ARTWORK')
			buff.stealable:SetPoint('CENTER')
			buff.stealable:SetBlendMode('ADD')
			buff.stealable:SetTexture('Interface\\TargetingFrame\\UI-TargetingFrame-Stealable')
		end
		buff.stealable:Hide()

		buff.border = _G[name .. 'Border']
		if not buff.border then
			buff.border = buff:CreateTexture(name .. 'Border', 'BORDER')
			buff.border:SetAllPoints(buff)
			buff.border:SetTexture(self.texture .. 'Border')
		end
		if dark then
			buff.border:SetVertexColor(.1, .1, .1)
		else
			buff.border:SetVertexColor(.3, .3, .3)
		end

		buff:SetScript('OnEnter', function(self)
			GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
			GameTooltip:SetUnitBuff(unit, i)
		end)
		buff:SetScript('OnLeave', function()
			GameTooltip:Hide()
		end)

		local name, icon, count, dispelType, duration, expirationTime, source, isStealable, _, spellId = UnitBuff(unit, i)
		if icon then
			CooldownFrame_Set(buff.cooldown, expirationTime - duration, duration, true)
			local selfCast = source == 'player' or source == 'pet'
			if UnitCanAttack('player', unit) then -- 进攻驱散
				local canDispel = self:dispel(unit, dispelType) -- 可以驱散
				buff.cooldown._occ_show = not dispelCooldown or canDispel or false -- 倒计时
				if dispelStealable and canDispel then buff.stealable:Show() end -- 高亮
			elseif UnitIsFriend('player', unit) then -- 施放Buff
				buff.cooldown._occ_show = not selfCooldown or selfCast
			end

			local iconSize = selfCast and size or size * percent
			buff:SetSize(iconSize, iconSize)
			buff.count:SetFont(valueFont, iconSize * .6, fontFlags)

			if auraX and auraY then
				local y = ceil(i / rows) -- 列数
				buff:ClearAllPoints()
				buff:SetPoint('TOPLEFT', buff:GetParent(), 'BOTTOMLEFT', x, auraY - (size + spac) * y)
				if math.fmod(i, rows) == 0 then
					x = auraX
				else
					x = x + iconSize + spac
				end
			end

			buff.icon:SetSize(iconSize - 2, iconSize - 2)
			buff.icon:SetTexture(icon)

			buff.stealable:SetSize(iconSize + 4, iconSize + 4)

			if type(count) == 'number' and count > 1 then
				buff.count:SetText(count)
			else
				buff.count:SetText(nil)
			end

			buff:Show()
			total = total + 1
		else
			buff:Hide()
		end
	end

	-- Debuff
	local row = ceil(total / rows) -- 行数
	total = 0
	x = auraX
	for i = 1, maxDebuffs do
		local name = frame:GetName() .. 'Debuff' .. i
		local debuff = _G[name] or key == 'party' and CreateFrame('Button', name, frame)
		if not debuff then break end
		debuff:SetFrameLevel(5)

		debuff.icon = _G[name .. 'Icon']
		if not debuff.icon then
			debuff.icon = debuff:CreateTexture(name .. 'Icon', 'BACKGROUND')
			debuff.icon:SetPoint('CENTER')
		end
		debuff.icon:SetTexCoord(.05, .95, .05, .95)

		debuff.cooldown = _G[name .. 'Cooldown']
		if not debuff.cooldown then
			debuff.cooldown = CreateFrame('Cooldown', name .. 'Cooldown', debuff, 'CooldownFrameTemplate')
			debuff.cooldown:SetReverse(true)
		end

		debuff.count = _G[name .. 'Count'] or debuff:CreateFontString(name .. 'Count', 'OVERLAY')
		debuff.count:SetPoint('BOTTOMRIGHT', 2, -2)

		debuff.stealable = _G[name .. 'Stealable']
		if not debuff.stealable then
			debuff.stealable = debuff:CreateTexture(name .. 'Stealable', 'ARTWORK')
			debuff.stealable:SetPoint('CENTER')
			debuff.stealable:SetBlendMode('ADD')
			debuff.stealable:SetTexture('Interface\\TargetingFrame\\UI-TargetingFrame-Stealable')
		end
		debuff.stealable:Hide()

		debuff.border = _G[name .. 'Border']
		if not debuff.border then
			debuff.border = debuff:CreateTexture(name .. 'Border', 'BORDER')
			debuff.border:SetAllPoints(debuff)
			debuff.border:SetTexture(self.texture .. 'Border')
		end
		if dark then
			debuff.border:SetVertexColor(.1, .1, .1)
		else
			debuff.border:SetVertexColor(.3, .3, .3)
		end

		debuff:SetScript('OnEnter', function(self)
			GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
			GameTooltip:SetUnitDebuff(unit, i)
		end)
		debuff:SetScript('OnLeave', function()
			GameTooltip:Hide()
		end)

		local _, icon, count, dispelType, duration, expirationTime, source = UnitDebuff(unit, i)
		if icon then
			CooldownFrame_Set(debuff.cooldown, expirationTime - duration, duration, true)
			local selfCast = source == 'player' or source == 'pet'
			if UnitCanAttack('player', unit) then -- Dot
				debuff.cooldown._occ_show = not selfCooldown or selfCast
			elseif UnitIsFriend('player', unit) then -- 防御驱散
				local canDispel = self:dispel(unit, dispelType)
				if dispelStealable and canDispel then debuff.stealable:Show() end -- 高亮
				debuff.cooldown._occ_show = not dispelCooldown or canDispel
			end

			local iconSize = selfCast and size or size * percent
			debuff:SetSize(iconSize, iconSize)
			debuff.count:SetFont(valueFont, iconSize * .6, fontFlags)

			if auraX and auraY then
				local y = ceil(i / rows) + row -- 列数
				debuff:ClearAllPoints()
				debuff:SetPoint('TOPLEFT', debuff:GetParent(), 'BOTTOMLEFT', x, auraY - (size + spac) * y)
				if math.fmod(i, rows) == 0 then
					x = auraX
				else
					x = x + iconSize + spac
				end
			end

			debuff.icon:SetSize(iconSize - 2, iconSize - 2)
			debuff.icon:SetTexture(icon)

			debuff.stealable:SetSize(iconSize + 4, iconSize + 4)

			if type(count) == 'number' and count > 1 then
				debuff.count:SetText(count)
			else
				debuff.count:SetText(nil)
			end

			-- 边框
			if dispelType then
				local color = DebuffTypeColor[dispelType]
				if type(color) == 'table' then
					debuff.border:SetVertexColor(color.r, color.g, color.b)
					debuff.border:Show()
				end
			end

			debuff:Show()
			total = total + 1
		else
			debuff:Hide()
		end
	end

	-- 施法条定位
	if frame.castBar then
		rows = ceil(total / rows) + row -- 行数
		if key == 'party' then
			frame.castBar:SetPoint('BOTTOMLEFT', 18, - (size + spac) * rows - 8)
		else
			local offsetY = - (size + spac) * rows + 24
			local tot = self[unit .. 'target']
			if offsetY > -18 and type(tot) == 'table' and tot:IsShown() then offsetY = -18 end
			offsetY = offsetY > 7 and 7 or offsetY
			frame.castBar.offsetY = offsetY
			frame.castBar:ClearAllPoints()
			frame.castBar:SetPoint('TOPLEFT', frame, 'BOTTOMLEFT', 26, offsetY)
		end
	end
end

-- 头像
function BC:portrait(unit)
	unit = self:formatUnit(unit)
	if not unit then return end
	local frame = self[unit]
	if not (frame and frame.portrait) then return end
	local key = unit:gsub('%d', '')
	local index = self:getDB(key, 'portrait')
	if index == 1 and UnitIsPlayer(unit) then
		local coord = CLASS_ICON_TCOORDS[select(2, UnitClass(unit))]
		if type(coord) == 'table' then
			frame.portrait:SetTexCoord(unpack(coord))
			frame.portrait:SetTexture(self:getDB('global', 'newClassIcon') and (self.texture .. self.portraitList[0]) or self:file(self.portraitList[1]))
		end
	else
		frame.portrait:SetTexCoord(0, 1, 0, 1)
		if type(index) == 'number' and index > 1 and UnitIsPlayer(unit) then
			frame.portrait:SetTexture(self:file(self.portraitList[index], 1))
		else
			SetPortraitTexture(frame.portrait, self:vehicleUnit(unit))
		end
	end
end
hooksecurefunc('UnitFramePortrait_Update', function(self)
	BC:portrait(self.unit)
end)

-- 小图标(职业/种类)
function BC:miniIcon(unit)
	local frame = self[unit]
	if not (frame and frame.miniIcon and frame.miniIcon:IsShown()) then return end
	if unit == 'player' then
		local active = GetActiveTalentGroup('player', false) -- 当前天赋
		local passive = 3 - active -- 将切换天赋
		local talent = {}
		local text
		for i = 1, MAX_TALENT_TABS do
			local _, name, _, icon, point = GetTalentTabInfo(i, 'player', false, active)
			text = (text and text .. '/' or '') .. point
			if point > 0 and (type(talent[active]) ~= 'table' or talent[active].point < point) then
				talent[active] = {
					name = name,
					icon = icon,
					point = point,
				}
			end
			_, name, _, _, point = GetTalentTabInfo(i, 'player', false, passive)
			if point > 0 and (type(talent[passive]) ~= 'table' or talent[passive].point < point) then
				talent[passive] = {
					name = name,
					point = point,
				}
			end
		end

		if type(talent[active]) == 'table' and type(talent[active].name) == 'string' then
			frame.miniIcon.tip = {[1] = {(active == 1 and L.primary or L.secondary) .. '(' .. talent[active].name .. '):', text, 1, 1, 0, 0, 1, 0}}
			frame.miniIcon.icon:SetTexture(talent[active].icon)
		else
			frame.miniIcon.tip = {[1] = {(active == 1 and L.primary or L.secondary)  .. ':', text, 1, 1, 0, 1, 0, 0}}
			frame.miniIcon.icon:SetTexture('Interface\\Icons\\INV_Misc_QuestionMark')
		end

		frame.miniIcon.tip[2] = {L.shiftKeyDown .. ':', L.nude, 1, 1, 0, 0, 1, 0} -- Shift 一键脱装

		if GetNumTalentGroups('player', false) > 1 then -- 可以切换天赋(开启双天赋)
			frame.miniIcon.tip[3] = {L.click .. ':', L.switch .. (active == 1 and L.secondary or L.primary), 1, 1, 0, 0, 1, 0}
			if BC:getDB('player', 'autoTalentEquip') and type(talent[passive]) == 'table' and type(talent[passive].name) == 'string' then
				frame.miniIcon.tip[4] = {L.switchAfter .. ':', talent[passive].name, 1, 1, 0, 0, 1, 0} -- 切换天赋后
			end
		end
		if type(frame.miniIcon.callBack) == 'function' then frame.miniIcon.callBack() end -- 切换天赋后回调
		frame.miniIcon.click = function()
			if IsShiftKeyDown() then -- 按住Shift 一键脱光
				EQUIPMENTMANAGER_BAGSLOTS = {} -- 背包空间缓存
				for _, i in pairs({16, 17, 5, 7, 1, 3, 9, 10, 6, 8}) do
					local durability = GetInventoryItemDurability(i)
					if durability and durability > 0 then -- 有耐久度
						for	bag = BACKPACK_CONTAINER, NUM_BAG_FRAMES do
							local free, family = C_Container.GetContainerNumFreeSlots(bag)
							if free > 0 and family == 0 then -- 有空位 且是背包
								EQUIPMENTMANAGER_BAGSLOTS[bag] = EQUIPMENTMANAGER_BAGSLOTS[bag] or {}
								for slot = 1, C_Container.GetContainerNumSlots(bag) do
									if not C_Container.GetContainerItemID(bag, slot) and not EQUIPMENTMANAGER_BAGSLOTS[bag][slot] then -- 有空位
										PickupInventoryItem(i)
										if bag == 0 then
											PutItemInBackpack()
										else
											PutItemInBag(C_Container.ContainerIDToInventoryID(bag))
										end
										EQUIPMENTMANAGER_BAGSLOTS[bag][slot] = true
										break
									end
								end
							end
						end
					end
				end
				for i = 1, 6 do
					equip = _G['EquipSetFrame' .. i]
					if equip then
						equip:SetAlpha(.3)
						equip.isEquipped = nil
					end
				end
			else
				SetActiveTalentGroup(passive) -- 切换天赋
				frame.miniIcon.callBack = function() -- 切换天赋回调
					if BC:getDB('player', 'autoTalentEquip') and type(talent[passive]) == 'table' and talent[passive].name then
						local setID = C_EquipmentSet.GetEquipmentSetID(talent[passive].name)
						if setID then C_EquipmentSet.UseEquipmentSet(setID) end
					end
					frame.miniIcon.callBack = nil
				end
			end
		end
	else
		if UnitIsPlayer(unit) then
			local class, base = UnitClass(unit)
			local color = RAID_CLASS_COLORS[base]
			if color then
				frame.miniIcon.tip = {[1] = {L.playerClass .. ':', class, 1, 1, 0, color.r, color.g, color.b}}
				if UnitFactionGroup('player') == UnitFactionGroup(unit) and not UnitIsUnit('player', unit) then -- 同阵营
					frame.miniIcon.tip[2] = {L.altKeyDown .. ':', L.invite, 1, 1, 0, 0, 1, 0}
				end
				frame.miniIcon.tip[4] = {L.shiftKeyDown .. ':', L.copyName, 1, 1, 0, 0, 1, 0}
				frame.miniIcon.tip[5] = {L.leftButton .. ':', L.inspect, 1, 1, 0, 0, 1, 0}
				if UnitIsFriend('player', unit) and not UnitIsUnit('player', unit) then
					frame.miniIcon.tip[3] = {L.ctrlKeyDown .. ':', L.trade, 1, 1, 0, 0, 1, 0}
					frame.miniIcon.tip[6] = {L.middleButton .. ':', L.sendTell, 1, 1, 0, 0, 1, 0}
					frame.miniIcon.tip[7] = {L.rightButton .. ':', L.followUnit, 1, 1, 0, 0, 1, 0}
				end
			end
			local coord = CLASS_ICON_TCOORDS[base]
			if coord then
				frame.miniIcon.icon:SetTexture(self:getDB('global', 'newClassIcon') and (self.texture .. self.portraitList[0]) or self:file(self.portraitList[1]))
				frame.miniIcon.icon:SetTexCoord(unpack(coord))
			end
		else
			local creature = UnitCreatureType(unit)
			if creature and L.creatureList[creature] then
				frame.miniIcon.tip = {[1] = {L.creatureType .. ':', creature, 1, 1, 0, 0, 1, 0}}
				frame.miniIcon.tip[2] = {L.shiftKeyDown .. ':', L.copyName, 1, 1, 0, 0, 1, 0}
				frame.miniIcon.icon:SetTexture(self.creatureList[L.creatureList[creature]])
				frame.miniIcon.icon:SetTexCoord(.05, .95, .05, .95)
			end
		end
	end
end

-- 设置暗黑模式
function BC:dark(unit)
	unit = self:formatUnit(unit)
	if not unit then return end
	local frame = self[unit]
	if not frame then return end
	local dark = self:getDB('global', 'dark')
	local key = unit:gsub('%d', '')

	-- 边框材质
	local index
	if frame.borderTexture then
		if key == 'player' then
			index = self:getDB(key, 'border')

			-- 小队编号边框
			local indicator = self:file('CharacterFrame\\UI-CharacterFrame-GroupIndicator')
			PlayerFrameGroupIndicatorLeft:SetTexture(indicator)
			PlayerFrameGroupIndicatorRight:SetTexture(indicator)
			PlayerFrameGroupIndicatorMiddle:SetTexture(indicator)

		elseif key == 'target' or key == 'focus' then
			local classification = UnitClassification(key)
			if classification == 'elite' or classification == 'worldboss' then
				index = 4
			elseif classification == 'rareelite' then
				index = 3
			elseif classification == 'rare' then
				index = 2
			else
				index = 1
			end
		elseif key == 'pettarget' then
			index = 5
		elseif key == 'targettarget' or key == 'focustarget' or key == 'partytarget' then
			index = 6
		elseif key == 'pet' or key == 'party' or key == 'partypet'then
			index = 7
		end
		if index then frame.borderTexture:SetTexture(self:file(self.borderList[index])) end
	end

	-- 状态栏
	if frame.statusBar then
		if UnitIsPlayer(unit) and BC:getDB(key, 'statusBarClass') then
			local color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
			frame.statusBar:SetVertexColor(color.r, color.g, color.b)
			frame.statusBar:Show()
		elseif unit == 'player' then
			BC.player.statusBar:Hide()
		else
			if not UnitPlayerControlled(unit) and UnitIsTapDenied(unit) then
				frame.statusBar:SetVertexColor(.5, .5, .5)
			else
				frame.statusBar:SetVertexColor(UnitSelectionColor(unit))
			end
		end
		frame.statusBar:SetTexture(self:file(self.barList[1]))

		-- 状态栏透明度
		if self:getDB(key, 'statusBarAlpha') then frame.statusBar:SetAlpha(self:getDB(key, 'statusBarAlpha')) end
	end

	if frame.healthbar then frame.healthbar:SetStatusBarTexture(self:file(self.barList[1])) end -- 生命条
	if frame.manabar then frame.manabar:SetStatusBarTexture(self:file(self.barList[1])) end -- 法力条

	-- PVP图标
	if frame.pvpIcon then
		local factionGroup = UnitFactionGroup(unit)
		if UnitIsPVPFreeForAll(unit) then
			frame.pvpIcon:SetTexture(self:file('TargetingFrame\\UI-PVP-FFA'))
		elseif factionGroup and factionGroup ~= 'Neutral' and UnitIsPVP(unit) then
			frame.pvpIcon:SetTexture(self:file('TargetingFrame\\UI-PVP-' .. factionGroup))
		end
	end
end
-- 法力条暗黑模式
hooksecurefunc('UnitFrameManaBar_UpdateType', function(self)
	BC:dark(self.unit)
end)

-- 数字进制
function BC:carry(value)
	if type(value) ~= 'number' then return 0 end
	local carry = self:getDB('global', 'carry')
	if carry == 1 then
		if value >= 1e6 then
			return ('%.1f'):format(value/1e6):gsub('%.?0+$', '') .. 'M'
		elseif value >= 1e4 then
			return ('%.1f'):format(value/1e3):gsub('%.?0+$', '') .. 'K'
		end
	elseif carry == 2 then
		if value >= 1e8 then
			return ('%.2f'):format(value / 1e8):gsub('%.?0+$', '') .. L.yi
		elseif value >= 1e4 then
			return ('%.2f'):format(value / 1e4):gsub('%.?0+$', '') .. L.wan
		end
	end
	return value
end

-- 条
function BC:bar(bar)
	local unit = bar and self:formatUnit(bar.unit)
	if not unit or not UnitExists(unit) then return end
	local font = self:getDB('global', 'valueFont')
	local flag = self:getDB('global', 'fontFlags')
	local key = unit == 'vehicle' and 'player' or (UnitHasVehiclePlayerFrameUI('player') and unit == 'player' and 'pet' or unit:gsub('%d', ''))
	local size = self:getDB(key, 'valueFontSize')
	if not size then return end

	local value = bar:GetValue()
	local _, valueMax = bar:GetMinMaxValues()
	local color
	if UnitHasVehiclePlayerFrameUI('player') and unit == 'pet' then
		if bar.powerType then
			value = UnitPower('player')
			valueMax = UnitPowerMax('player')
			color = PowerBarColor[UnitPowerType('player')]
		else
			value = UnitHealth('player')
			valueMax = UnitHealthMax('player')
		end
	end

	if key == 'pettarget' or key == 'partytarget' or key == 'partypet' or bar:GetName() == 'PlayerFrameDruidBar' then
		if bar.powerType then
			value = UnitPower(bar.unit, bar.powerType)
			valueMax = UnitPowerMax(bar.unit, bar.powerType)
			color = PowerBarColor[bar.powerType]
		else
			value = UnitHealth(bar.unit)
			valueMax = UnitHealthMax(bar.unit)
		end
		bar:SetMinMaxValues(0, valueMax)
		bar:SetValue(value)
	end

	-- 条颜色
	local percent = valueMax == 0 and 0 or value / valueMax
	if not bar.powerType then
		if self:getDB(key, 'healthBarClass') and UnitIsPlayer(bar.unit) then -- 职业色
			color = RAID_CLASS_COLORS[select(2, UnitClass(bar.unit))]
		elseif self:getDB('global', 'healthBarColor') then -- 生命值百分比变化
			color = {r = 0, g = 1, b = 0}
			if percent > .5 then
				color.r = (1 - percent) * 2
			else
				color.r = 1
				color.g = percent * 2
			end
		end
	end
	if type(color) == 'table' then
		if UnitHasVehiclePlayerFrameUI('player') and unit == 'player' then
			bar:SetStatusBarColor(color.r, color.g, color.b)
		else
			bar:SetStatusBarColor(color.r, color.g, color.b)
		end
	end

	-- 数值文字
	if bar.MiddleText then
		bar.MiddleText:Hide()
		bar.MiddleText:SetFont(font, size, flag)
	end
	if bar.LeftText then
		bar.LeftText:Hide()
		bar.LeftText:SetFont(font, size, flag)
	end
	if bar.RightText then
		bar.RightText:Hide()
		bar.RightText:SetFont(font, size, flag)
	end
	if bar.SideText then
		bar.SideText:Hide()
		bar.SideText:SetFont(font, size, flag)
	end

	bar:SetScript('OnEnter', function(self)
		local key = BC:formatUnit(BC:vehicleUnit(self.unit))
		if not key then return end
		local valueStyle = BC:getDB(key:gsub('[%d-]', ''), 'valueStyle')
		if type(valueStyle) == 'number' and valueStyle > 6 then
			local value = self:GetValue()
			local _, valueMax = self:GetMinMaxValues()
			if valueStyle == 9 then
				local percent = valueMax == 0 and 0 or value / valueMax
				percent = floor(percent * 100 + .5) .. '%'
				if self.MiddleText then self.MiddleText:SetText(percent) end
			else
				if self.MiddleText then self.MiddleText:SetText(BC:carry(value) .. '/' .. BC:carry(valueMax)) end
			end
			if self.MiddleText then self.MiddleText:Show() end
		end
	end)
	bar:SetScript('OnLeave', function(self)
		local key = BC:formatUnit(BC:vehicleUnit(self.unit))
		if not key then return end
		local valueStyle = BC:getDB(key:gsub('[%d-]', ''), 'valueStyle')
		if type(valueStyle) == 'number' and valueStyle > 6 then
			if self.MiddleText then self.MiddleText:Hide() end
		end
	end)

	-- 死亡
	local frame = self[unit]
	local dead = UnitIsDeadOrGhost(unit) or not bar.powerType and value <= 0
	if frame and frame.deadText then
		if dead then
			frame.deadText:SetText(DEAD)
			frame.deadText:Show()
		else
			frame.deadText:Hide()
		end
	end
	if dead then return end

	local valueStyle = self:getDB(key, 'valueStyle')
	percent = floor(percent * 100 + .5) .. '%'

	if valueStyle == 1 then
		if bar.LeftText then
			bar.LeftText:SetText(value > 0 and (not bar.powerType or bar.powerType == 0) and percent or '')
			bar.LeftText:Show()
		end
		if bar.RightText then
			bar.RightText:SetText(self:carry(value))
			bar.RightText:Show()
		end
	elseif valueStyle == 2 then
		if bar.MiddleText then
			bar.MiddleText:SetText(percent)
			bar.MiddleText:Show()
		end
	elseif valueStyle == 3 then
		if bar.MiddleText then
			bar.MiddleText:SetText(self:carry(value))
			bar.MiddleText:Show()
		end
	elseif valueStyle == 4 then
		if bar.MiddleText then
			bar.MiddleText:SetText(self:carry(value) .. '/' .. self:carry(valueMax))
			bar.MiddleText:Show()
		end
	elseif valueStyle == 5 then
		if bar.MiddleText then
			bar.MiddleText:SetText(self:carry(value))
			bar.MiddleText:Show()
		end
		if bar.SideText then
			bar.SideText:SetText(percent)
			bar.SideText:Show()
		end
	elseif valueStyle == 6 then
		if bar.MiddleText then
			bar.MiddleText:SetText(self:carry(value) .. '/' .. self:carry(valueMax))
			bar.MiddleText:Show()
		end
		if bar.SideText then
			bar.SideText:SetText(percent)
			bar.SideText:Show()
		end
	elseif valueStyle == 7 then
		if bar.SideText then
			bar.SideText:SetText(percent)
			bar.SideText:Show()
		end
	elseif valueStyle == 8 then
		if bar.SideText then
			bar.SideText:SetText(self:carry(value))
			bar.SideText:Show()
		end
	elseif valueStyle == 9 then
		if bar.SideText then
			bar.SideText:SetText(self:carry(value) .. '/' .. self:carry(valueMax))
			bar.SideText:Show()
		end
	end
end
-- 条更新
hooksecurefunc('TextStatusBar_UpdateTextString', function(self)
	BC:bar(self)
end)

-- 更新
function BC:update(unit)
	unit = self:formatUnit(unit)
	if not unit then return end
	local frame = self[unit]
	if not frame then return end
	local key = unit:gsub('%d', '')

	-- 显示/隐藏 框体
	if key == 'party' or key == 'partytarget' then
		if self:getDB('party', 'hideFrame') or not self:getDB('party', 'raidShowParty') and UnitInRaid('player') then
			frame:SetAlpha(0)
			self[unit .. 'target']:SetAlpha(0)
			return
		elseif key == 'partytarget' then
			if not self:getDB(key, 'hideFrame') and UnitExists(unit) then
				frame:SetAlpha(1)
			else
				frame:SetAlpha(0)
				return
			end
		elseif UnitExists(unit) then
			if not frame:IsShown() then
				if InCombatLockdown() then
					self.updateCombat = self.updateCombat or {}
					self.updateCombat[unit] = true
				else
					frame:Show()
				end
			end
			frame:SetAlpha(1)
			self:update(unit .. 'target')
		else
			frame:SetAlpha(0)
		end
	elseif self:getDB(key, 'hideFrame') or UnitHasVehiclePlayerFrameUI('player') and unit == 'pettarget' then
		frame:SetAlpha(0)
		return
	elseif key == 'targettarget' or key == 'pettarget' or key == 'partypet' then
		if UnitExists(unit) then
			frame:SetAlpha(1)
		else
			frame:SetAlpha(0)
			return
		end
	end

	-- 名字
	if frame.name then
		if self:getDB(key, 'hideName') then
			frame.name:Hide()
		else
			if key == 'pettarget' or key == 'partypet' or key == 'partytarget' then frame.name:SetText(UnitName(unit)) end
			local color
			if self:getDB('global', 'nameClassColor') and UnitIsPlayer(unit) then
				color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
			else
				color = { r = 1, g = .82, b = 0}
			end
			if UnitHasVehiclePlayerFrameUI('player') then
				if unit == 'pet' or unit == 'vehicle' then
					frame.name:SetText(UnitName('player'))
					if self:getDB('global', 'nameClassColor') then color = RAID_CLASS_COLORS[select(2, UnitClass('player'))] end
				elseif unit == 'player' then
					frame.name:SetText(UnitName('pet'))
					color = { r = 1, g = .82, b = 0}
				end
			end
			if type(color) == 'table' then frame.name:SetTextColor(color.r, color.g, color.b) end
			frame.name:SetFont(self:getDB('global', 'nameFont'), self:getDB(key, 'nameFontSize'), self:getDB('global', 'fontFlags'))
			frame.name:Show()
		end
	end

	self:dark(unit)
	self:portrait(unit)
	if not frame.manabar.powerType then frame.manabar.powerType = UnitPowerType(unit) end
	self:bar(frame.manabar)
	self:bar(frame.healthbar)
end

-- 预治疗
function BC:incomingHeals(unit)
	local frame = self[unit]
	if not frame then return end

	if self:getDB('global', 'incomingHeals') then
		frame.incomingHealsBar:Show()
	else
		frame.incomingHealsBar:Hide()
		return
	end

	local heals = UnitGetIncomingHeals(unit)
	if type(heals) ~= 'number' then
		if frame.incomingHealsBar then frame.incomingHealsBar:SetValue(0) end
		return
	end

	for _, v in pairs(self.unitList) do
		if UnitIsUnit(unit, v) and self[v] and self[v]:IsShown() and self[v].incomingHealsBar then
			self[v].incomingHealsBar:SetValue(heals == 0 and 0 or (UnitHealth(unit) + heals) / UnitHealthMax(unit))
		end
	end
end

-- 始初化
function BC:init(unit)
	unit = self:formatUnit(unit)
	if not unit then
		for _, u in pairs(self.unitList) do
			self:init(u)
		end
		return
	end

	local frame = self[unit]
	if not frame then return end
	local key = unit:gsub('%d', '')

	-- 初始定位
	local anchor = self:getDB(key, 'anchor')
	local relative = self:getDB(key, 'relative')
	local offsetX = self:getDB(key, 'offsetX')
	local offsetY = self:getDB(key, 'offsetY')
	if not InCombatLockdown() then
		frame:ClearAllPoints()
		if key == 'partytarget' then
			frame:SetPoint(relative, self[unit:gsub('target$', '')], offsetX, offsetY)
		elseif key ~= 'party' or unit == 'party1' then
			if anchor and type(relative) == 'string' then
				frame:SetPoint(relative, anchor, offsetX, offsetY)
			else
				frame:SetPoint(relative, offsetX, offsetY)
			end
			if unit == 'player' then frame:SetUserPlaced(true) end
		end
	end

	-- 拖动
	self:drag(frame, key == 'party' and unit ~= 'party1' and PartyMemberFrame1, self:getDB(key, 'drag'), function(self)
		local _, _, relative, offsetX, offsetY = self:GetPoint()
		local anchor = BC:getDB(key, 'anchor')

		-- 有父对像
		if type(anchor) == 'string' then
			offsetX = self:GetLeft() - _G[anchor]:GetLeft()
			offsetY = self:GetTop() - _G[anchor]:GetTop()
			relative = 'TOPLEFT'
		end

		BC:setDB(key, 'relative', relative)
		BC:setDB(key, 'offsetX', floor(offsetX + .5))
		BC:setDB(key, 'offsetY', floor(offsetY + .5))
	end)

	-- 头像显示战斗信息
	local registered = frame:IsEventRegistered('UNIT_COMBAT')
	if self:getDB(key, 'portraitCombat') then
		if unit == 'player' or unit == 'pet' then
			if not registered then frame:RegisterEvent('UNIT_COMBAT') end
		else
			if not frame.portraitCombat then
				frame.portraitCombat = CreateFrame('Frame', nil, frame)
				frame.portraitCombat:SetFrameLevel(frame:GetFrameLevel() + 2)
			end
			if not frame.portraitCombatText then
				frame.portraitCombatText = frame.portraitCombat:CreateFontString(nil, 'OVERLAY', 'NumberFontNormalHuge')
				frame.portraitCombatText:SetPoint('CENTER', frame.portrait)
			end
			CombatFeedback_Initialize(frame.portraitCombat, frame.portraitCombatText, frame.portrait:GetWidth() / 2)

			frame.portraitCombat:RegisterEvent('UNIT_COMBAT')
			frame.portraitCombat:SetScript('OnEvent', function(self, event, ...)
				if event == 'UNIT_COMBAT' then
					local arg1, arg2, arg3, arg4, arg5 = ...
					if unit == arg1 then
						CombatFeedback_OnCombatEvent(self, arg2, arg3, arg4, arg5)
					end
				end
			end)
			frame.portraitCombat:SetScript('OnUpdate', function(self, elapsed)
				if self and self.feedbackStartTime then CombatFeedback_OnUpdate(self, elapsed) end
			end)
		end
	else
		if unit == 'player' or unit == 'pet' then
			if registered then frame:UnregisterEvent('UNIT_COMBAT') end
		else
			if frame.portraitCombat then
				if frame.portraitCombat:IsEventRegistered('UNIT_COMBAT') then
					frame.portraitCombat:UnregisterAllEvents()
				end
				frame.portraitCombat:SetScript('OnEvent', nil)
				frame.portraitCombat:SetScript('OnUpdate', nil)
			end
			if frame.portraitCombatText and frame.portraitCombatText:IsShown() then
				frame.portraitCombatText:Hide()
			end
		end
	end

	-- 显示小图标(职业/种类)
	if self:getDB(key, 'miniIcon') then
		if not frame.miniIcon then
			frame.miniIcon = CreateFrame('Button', nil, frame)
			if unit == 'player' then
				frame.miniIcon:SetPoint('TOPLEFT', 88, 1)
			else
				frame.miniIcon:SetPoint('TOPLEFT', 114, 0)
			end
			frame.miniIcon:SetFrameLevel(4)
			frame.miniIcon:SetSize(28, 28)
			frame.miniIcon:SetAlpha(.8)
			frame.miniIcon:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight')
			frame.miniIcon.border = frame.miniIcon:CreateTexture(nil, 'OVERLAY')
			frame.miniIcon.border:SetPoint('CENTER', 9, -9)
			frame.miniIcon.border:SetSize(40, 40)
			frame.miniIcon.icon = frame.miniIcon:CreateTexture(nil, 'ARTWORK')
			frame.miniIcon.icon:SetPoint('CENTER', 1, -.5)
			frame.miniIcon.icon:SetTexCoord(.05, .95, .05, .95)
			frame.miniIcon.icon:SetSize(13, 13)
			frame.miniIcon:SetScript('OnEnter', function(self)
				if InCombatLockdown() then return end -- 战斗中
				GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
				if type(self.tip) == 'table' then
					for _, val in pairs(self.tip) do
						GameTooltip:AddDoubleLine(unpack(val))
					end
					GameTooltip:Show()
				end
			end)
			frame.miniIcon:SetScript('OnLeave', function()
				GameTooltip:Hide()
			end)
		end
		frame.miniIcon:Show()
		frame.miniIcon:SetScript('OnMouseDown', function(self, button)
			if unit == 'player' then
				if type(self.click) == 'function' then self.click() end
			else
				local name, server = UnitName(unit)
				if server and server ~= '' then name = name .. '-' .. server end
				if IsShiftKeyDown() then
					local editbox = ChatEdit_ChooseBoxForSend()
					if not editbox:IsShown() then ChatEdit_ActivateChat(editbox) end
					editbox:SetFocus()
					editbox:SetText(name)
					editbox:HighlightText()
				elseif UnitIsPlayer(unit) then
					if IsAltKeyDown() then
						InviteUnit(name) -- 邀请
					elseif IsControlKeyDown() then
						if UnitFactionGroup('player') == UnitFactionGroup(unit) and not UnitIsUnit('player', unit) then
							InitiateTrade(unit) -- 交易
						end
					elseif button == 'LeftButton' then
						InspectUnit(unit) -- 观察
					elseif button == 'MiddleButton' then
						if UnitIsFriend('player', unit) and not UnitIsUnit('player', unit) then
							ChatFrame_SendTell(name) -- 密语
						end
					elseif button == 'RightButton' and UnitIsFriend('player', unit) then
						if UnitIsFriend('player', unit) and not UnitIsUnit('player', unit) then
							FollowUnit(unit) -- 跟随
						end
					end
				end
			end
		end)
		frame.miniIcon.border:SetTexture(self:file('Minimap\\MiniMap-TrackingBorder'))
	elseif frame.miniIcon then
		frame.miniIcon:Hide()
	end

	-- 死亡
	if not frame.deadText then
		frame.deadFrame = CreateFrame('Frame', nil, frame)
		frame.deadFrame:SetAllPoints(frame.healthbar)
		frame.deadFrame:SetFrameLevel(5)
		frame.deadText = frame.deadFrame:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
		frame.deadText:SetPoint('CENTER', 0, key == 'partypet' and -2 or -4)
	end
	frame.deadText:SetFont(STANDARD_TEXT_FONT, self:getDB(key, 'valueFontSize') + 2, 'OUTLINE')

	-- 缩放
	local scale = self:getDB(key, 'scale')
	if not InCombatLockdown() and type(scale) == 'number' then frame:SetScale(scale) end

	-- 战斗状态边框红光
	if frame.flash then
		if not frame.flash.hook then
			hooksecurefunc(frame.flash, 'Hide', function(self)
				if BC:getDB(key, 'combatFlash') and UnitAffectingCombat(unit) then
					self:SetVertexColor(1, 0, 0)
					self:SetAlpha(.6)
					if not self:IsShown() then self:Show() end
				else
					self:SetAlpha(0)
				end
			end)
			frame.flash.hook = true
		end
		frame.flash:Hide()
	end

	-- 超出范围半透明
	if BC:getDB(key, 'outRange') and not frame.hook then
		frame:SetScript('OnUpdate', function(self)
			if not self:IsShown() or self:GetAlpha() == 0 then return end
			local unit = self.unit
			if type(unit) ~= 'string' or not UnitExists(unit) then return end
			if UnitIsUnit('player', unit) or UnitInRange(unit) or (not InCombatLockdown() or UnitCanAttack('player', unit)) and CheckInteractDistance(unit, 4) then
				self:SetAlpha(1)
			else
				for _, id in pairs({
					5176, -- 愤怒
					5185, -- 治疗之触
					75, -- 自动射击
					133, -- 火球术
					635, -- 圣光术
					2050, -- 次级治疗术
					453, -- 安抚心灵
					8092, -- 心灵震爆
					589, -- 暗言术：痛
					403, -- 闪电箭
					331, -- 治疗波
					686, -- 暗影箭
					1490, -- 元素诅咒
					603, -- 厄运诅咒
					5138, -- 吸取法力
					1120, -- 吸取灵魂
					689, -- 吸取生命
					6789, -- 死亡缠绕
					980, -- 痛苦诅咒
					27243, -- 腐蚀之种
					172, -- 腐蚀术
					702, -- 虚弱诅咒
					1714, -- 语言诅咒
					704, -- 鲁莽诅咒
				}) do
					local spell = GetSpellInfo(id)
					if spell and IsSpellInRange(spell, unit) == 1 then
						self:SetAlpha(1)
						return
					end
				end
				self:SetAlpha(.5)
			end
		end)
		frame.hook = true
	elseif frame.hook then
		frame:SetAlpha(1)
		frame.hook = nil
		frame:SetScript('OnUpdate', nil)
	end

	-- PVP图标
	if frame.pvpIcon then
		if not frame.pvpIcon.hook then
			hooksecurefunc(frame.pvpIcon, 'Show', function()
				BC:dark(unit)
			end)
			frame.pvpIcon.hook = true
		end
	end

	-- 预治疗
	if frame.healthbar then
		if not frame.incomingHealsBar then
			frame.incomingHealsBar = CreateFrame('StatusBar', nil, frame.healthbar)
			frame.incomingHealsBar:SetSize(frame.healthbar:GetSize())
			frame.incomingHealsBar:SetPoint('LEFT')
			frame.incomingHealsBar:SetFrameLevel(0)
			frame.incomingHealsBar:SetMinMaxValues(0, 1)
			frame.incomingHealsBar:SetValue(0)
			frame.incomingHealsBar:SetStatusBarTexture(self.texture .. 'UI-IncomingHealsBar')
		end
	end

	if type(frame.init) == 'function' then frame.init() end
	self:update(unit)
end

for _, event in pairs({
	'PLAYER_ENTERING_WORLD', -- 进入世界
	'PLAYER_REGEN_ENABLED', -- 结束战斗
	'PLAYER_FOCUS_CHANGED', -- 焦点目标变化
	'PLAYER_TARGET_CHANGED', -- 我的目标变化
	'UNIT_TARGET', -- 目标切换
	'UNIT_FLAGS', -- 战斗状态
	'UNIT_HEAL_PREDICTION', -- 治疗预测
	'UNIT_HEALTH', -- 体力变化
	'ZONE_CHANGED', -- 区域更改
	'ZONE_CHANGED_NEW_AREA', -- 传送
}) do
	BC:RegisterEvent(event)
end
BC:SetScript('OnEvent', function(self, event, unit)
	unit = self:formatUnit(unit)
	if event == 'PLAYER_ENTERING_WORLD' then
		self:drag(LFGParentFrame) -- 寻求组队
		self:init()
	elseif event == 'PLAYER_REGEN_ENABLED' then
		if self.updateCombat then
			for u, v in pairs(self.updateCombat) do
				if v then
					self:update(u)
				end
			end
			self.updateCombat = nil
		end
	elseif event == 'PLAYER_FOCUS_CHANGED' then
		self:incomingHeals('focus')
	elseif event == 'PLAYER_TARGET_CHANGED' then
		self:incomingHeals('target')
	elseif event == 'UNIT_TARGET' then
		unit = unit == 'player' and 'target' or unit
		self:update(unit == 'player' and 'target' or unit .. 'target')
	elseif event == 'UNIT_FLAGS' then
		if self[unit] and self[unit].flash then self[unit].flash:Hide() end
	elseif event == 'UNIT_HEAL_PREDICTION' or event == 'UNIT_HEALTH' then -- 治疗预测
		self:incomingHeals(unit)
	elseif event == 'ZONE_CHANGED' or event == 'ZONE_CHANGED_NEW_AREA' then
		-- PVP环境自动设置TAB选择敌对玩家
		if self:getDB('global', 'autoTab') then
			local _, instance = IsInInstance()
			if instance == 'arena' or instance == 'pvp' then
				SetBinding('TAB', 'TARGETNEARESTENEMYPLAYER', 1)
			else
				SetBinding('TAB', 'TARGETNEARESTENEMY', 1)
			end
		end
	end
end)

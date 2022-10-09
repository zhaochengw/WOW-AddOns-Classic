local class = select(2, UnitClass('player'))
local frame = CreateFrame('Frame')
for _, item in pairs({
	'PLAYER_ENTERING_WORLD',
	'UNIT_AURA',
	'UPDATE_SHAPESHIFT_FORM',
	'UNIT_SPELLCAST_SUCCEEDED',
	'UNIT_POWER_FREQUENT',
}) do
	frame:RegisterEvent(item, 'player')
end
frame:SetScript('OnEvent', function(self, event, ...)
	if event == 'PLAYER_ENTERING_WORLD' then
		function self.cure(key)
			local type = UnitPowerType('player')
			if key == 'druid' then type = 0 end
			return UnitPower('player', type), type
		end
		function self.rest(key, event, unit, powerType)
			local cure, type = self.cure(key)
			if event == 'UPDATE_SHAPESHIFT_FORM' and class == 'DRUID' then --小德变身
				self[key].cure = cure
				self[key].timer = GetTime()
			elseif event == 'UNIT_POWER_FREQUENT' and unit == 'player' then -- 能量/法力更新
				if cure > self[key].cure then
					self[key].cure = cure
					self[key].timer = GetTime()
					PowerSparkDB[key].timer = self[key].timer
				end
			elseif event == 'UNIT_SPELLCAST_SUCCEEDED' and unit == 'player' then -- 施法成功
				if cure < self[key].cure and type == 0 then self[key].wait = GetTime() + 5 end -- 5秒回蓝
				self[key].cure = cure
			end
		end
		function self.init(parent, key) --初始化
			if not parent or self[key] then return end
			if not PowerSparkDB then PowerSparkDB = {} end
			if not PowerSparkDB[key] then PowerSparkDB[key] = {} end
			local power = CreateFrame('StatusBar', nil, parent)
			power:SetWidth(parent.width or parent:GetWidth())
			power:SetHeight(parent.height or parent:GetHeight())
			power:SetPoint('CENTER')
			power.spark = power:CreateTexture(nil, 'OVERLAY')
			power.spark:SetTexture('Interface\\CastingBar\\UI-CastingBar-Spark')
			power.spark:SetWidth(32)
			power.spark:SetHeight(32)
			power.spark:SetBlendMode('ADD')
			power.spark:SetAlpha(0)
			power.cure = self.cure(key)
			power.rate = GetTime()
			power.timer = PowerSparkDB[key].timer or GetTime()
			power.interval = 2
			power.key = key
			power.parent = parent
			function power.hide(key)
				local cure, type = self.cure(key)
				return UnitIsDeadOrGhost('player') or key == 'default' and type == 1 or type == 0 and cure >= UnitPowerMax('player', 0) or type == 3 and cure >= UnitPowerMax('player') and not IsStealthed() and (not UnitCanAttack('player', 'target') or UnitIsDeadOrGhost('target')) --角色死亡/怒气/满蓝/满能量且不潜行且目标不可攻击
			end
			power:HookScript('OnUpdate', function(self)
				local now = GetTime()
				if now < self.rate then return end
				self.rate = now + 0.02 --刷新率
				if self.hide(self.key) then
					self.spark:SetAlpha(0)
				elseif self.wait and self.wait > now and (UnitPowerType('player') == 0 or self.key == 'druid') then --5秒等待回蓝
					self.spark:SetAlpha(1)
					self.spark:SetPoint('CENTER', self, 'LEFT', self:GetWidth() * (self.wait - now) / 5, 0)
				elseif self.timer then
					self.spark:SetAlpha(1)
					self.spark:SetPoint('CENTER', self, 'LEFT', self:GetWidth() * (mod(now - self.timer, self.interval) / self.interval), 0)
				end
			end)
			self[key] = power
		end
		if SUFUnitplayer and SUFUnitplayer.powerBar then -- 兼容 SUF
			self.init(SUFUnitplayer.powerBar, 'default')
			if class == 'DRUID' and SUFUnitplayer.druidBar then self.init(SUFUnitplayer.druidBar, 'druid') end
		elseif ElvUF_Player and ElvUF_Player.Power then	-- 兼容 ElvUI
			self.init(ElvUF_Player.Power, 'default')
		elseif StatusBars2_playerPowerBar then	-- 兼容 Statusbars2
			self.init(StatusBars2_playerPowerBar, 'default')
		else
			self.init(PlayerFrameManaBar, 'default')
		end
		if class == 'DRUID' and DruidBarFrame then
			DruidBarFrame.width = DruidBarKey.width - 4
			DruidBarFrame.health = DruidBarKey.height - 4
			self.init(DruidBarFrame, 'druid')
		end
		if class == 'DRUID' and BC_DruidBar then
			BC_DruidBar.width = BC_DruidBar.Mana:GetWidth() - 4
			BC_DruidBar.health = BC_DruidBar.Mana:GetHeight() - 4
			self.init(BC_DruidBar, 'druid')
		end
	elseif event == 'UNIT_AURA' and class == 'ROGUE' and unit == 'player' then
		self.interval = 2
		local i = 1
		while UnitBuff('player', i) do
			if select(10, UnitBuff('player', i)) == 13750 then --开了冲动
				self.interval = 1
				break
			end
			i = i + 1
		end
	elseif self.rest then
		self.rest('default', event, ...)
		if self.druid then self.rest('druid', event, ...) end
	end
end)
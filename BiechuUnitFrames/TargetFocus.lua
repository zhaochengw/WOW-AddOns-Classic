local BC = _G[...]

-- 更新Buff/Debuff
hooksecurefunc('TargetFrame_UpdateAuras', function(self)
	BC:aura(self.unit)
end)

-- 切换目标立即更新战斗状态边框红光
hooksecurefunc('TargetFrame_Update', function(self)
	if self.unit ~= 'target' and self.unit ~= 'focus' then return end
	if self.flash then self.flash:Hide() end
	BC:update(self.unit)
	BC:update(self.unit .. 'target')
	BC:miniIcon(self.unit)
end)

-- 等级
hooksecurefunc('TargetFrame_UpdateLevelTextAnchor', function(self)
	if self.levelText then self.levelText:SetPoint('CENTER', 63, -16) end
end)

for unit, frame in pairs {
	target = TargetFrame,
	focus = FocusFrame
} do
	-- 名字
	frame.name:SetWidth(120)
	frame.name:SetPoint('CENTER', -50, 17.5)

	-- 施法条
	frame.castBar = _G[frame:GetName() .. 'SpellBar']
	hooksecurefunc(frame.castBar, 'Show', function(self)
		if self.offsetY then self:SetPoint('TOPLEFT', frame, 'BOTTOMLEFT', 26, self.offsetY) end
	end)

	frame.flash = _G[frame:GetName() .. 'Flash']              -- 战斗中边框发红光
	frame.statusBar = frame.nameBackground                    -- 状态栏
	frame.deadText:SetPoint('CENTER', frame.healthbar, 0, -4) -- 死亡
	frame.levelText:SetFont(STANDARD_TEXT_FONT, 13, 'OUTLINE') -- 等级

	-- 体力
	frame.healthbar.MiddleText = frame.textureFrame.HealthBarText
	frame.healthbar.MiddleText:SetPoint('CENTER', frame.healthbar, 0, -.5)
	frame.healthbar.LeftText:SetPoint('LEFT', frame.healthbar, 1, -.5)
	frame.healthbar.RightText:SetPoint('RIGHT', frame.healthbar, -3, -.5)
	frame.healthbar.SideText = frame.healthbar:CreateFontString()
	frame.healthbar.SideText:SetPoint('RIGHT', frame.healthbar, 'LEFT', -3, -.5)

	-- 法力
	frame.manabar.MiddleText = frame.textureFrame.ManaBarText
	frame.manabar.MiddleText:SetPoint('CENTER', frame.manabar, 0, -.5)
	frame.manabar.LeftText:SetPoint('LEFT', frame.manabar, 1, -.5)
	frame.manabar.RightText:SetPoint('RIGHT', frame.manabar, -3, -.5)
	frame.manabar.SideText = frame.manabar:CreateFontString()
	frame.manabar.SideText:SetPoint('RIGHT', frame.manabar, 'LEFT', -3, -.5)

	-- 威胁值
	frame.threatNumericIndicator.border = frame.threatNumericIndicator:CreateTexture(nil, 'OVERLAY')
	frame.threatNumericIndicator.border:SetAllPoints(frame.threatNumericIndicator)
	frame.threatNumericIndicator.border:SetTexCoord(0, .77, 0, .55)
	frame.threatNumericIndicator.text:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')

	frame.init = function()
		BC:aura(unit)   -- 更新Buff/Debuff
		BC:miniIcon(unit) -- 更新小图标

		-- Quartz 施法条
		local QuartzCastBar = _G['Quartz3CastBar' .. unit:gsub('^%l', string.upper)]
		if QuartzCastBar then
			hooksecurefunc(QuartzCastBar, 'Show', function(self)
				if frame.castBar.offsetY then
					self:ClearAllPoints()
					self:SetPoint('TOPLEFT', frame, 'BOTTOMLEFT', 0, frame.castBar.offsetY + 6)
				end
			end)
		end

		-- 威胁值
		frame.threatNumericIndicator.bg:SetTexture(BC:file(BC.barList[1]))
		frame.threatNumericIndicator.border:SetTexture(BC:file('TargetingFrame\\NumericThreatBorder'))
		frame.threatNumericIndicator:SetPoint('TOP', BC:getDB(unit, 'threatLeft') and -84 or -50, -5)
	end

	-- 目标的目标
	local totFrame = _G[frame:GetName() .. 'ToT']
	totFrame.borderTexture = _G[totFrame:GetName() .. 'TextureFrameTexture']

	-- 体力
	totFrame.healthbar.MiddleText = totFrame.borderTexture:GetParent():CreateFontString()
	totFrame.healthbar.MiddleText:SetPoint('CENTER', totFrame.healthbar)
	totFrame.healthbar.SideText = totFrame.borderTexture:GetParent():CreateFontString()
	totFrame.healthbar.SideText:SetPoint('LEFT', totFrame.healthbar, 'RIGHT', 2, 0)

	-- 死亡
	totFrame.deadText:ClearAllPoints()
	totFrame.deadText:SetPoint('CENTER', totFrame.healthbar, .5, -4)

	-- 法力
	totFrame.manabar.MiddleText = totFrame.borderTexture:GetParent():CreateFontString()
	totFrame.manabar.MiddleText:SetPoint('CENTER', totFrame.manabar, 0, -.5)
	totFrame.manabar.SideText = totFrame.borderTexture:GetParent():CreateFontString()
	totFrame.manabar.SideText:SetPoint('LEFT', totFrame.manabar, 'RIGHT', 2, -.5)

	BC[unit] = frame
	BC[unit .. 'target'] = totFrame
end

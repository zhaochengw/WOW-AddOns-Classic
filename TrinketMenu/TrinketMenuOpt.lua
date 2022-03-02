--[[ TrinketMenuOpt.lua : Options and sort window for TrinketMenu ]]

local _G, math, string, table = _G, math, string, table

TrinketMenu.CheckOptInfo = {
	{"ShowIcon", "ON", "小地图按钮", "显示或隐藏小地图按钮."},
	{"SquareMinimap", "OFF", "方形小地图", "如果迷你地图是方形移动迷你地图按钮.", "ShowIcon"},
	{"CooldownCount", "OFF", "冷却计时", "在按钮上显示剩余冷却时间."},
	{"TooltipFollow", "OFF", "跟随鼠标", "提示信息跟随鼠标.", "ShowTooltips"},
	{"KeepOpen", "OFF", "保持列表开启", "保持饰物列表始终开启."},
	{"KeepDocked", "ON", "保持列表粘附", "保持饰物列表粘附在当前装备列表."},
	{"Notify", "OFF", "可使用提示", "饰物冷却后提示玩家."},
	{"DisableToggle", "OFF", "禁止开关", "止使用点击小地图按钮来控制列表的显示/隐藏.", "ShowIcon"},
	{"NotifyChatAlso", "OFF", "在聊天窗口提示", "在饰物冷却结束后在聊天窗口也发出提示信息."},
	{"Locked", "OFF", "锁定窗口", "不能移动,缩放,转动饰品列表."},
	{"ShowTooltips", "ON", "显示提示信息", "显示提示信息."},
	{"NotifyThirty", "ON", "三十秒提示", "在饰品冷却前三十秒时提示玩家."},
	{"MenuOnShift", "OFF", "Shift显示列表", "只有按下Shift才会显示饰品选择列表."},
	{"TinyTooltips", "OFF", "迷你提示", "简化饰品的提示信息变为只有名字, 用途, 冷却.", "ShowTooltips"},
	{"SetColumns", "OFF", "设置列表列数", "设置饰品选择列表的列数.\n\n不选择此项 TrinketMenu 会自动排列."},
	{"LargeCooldown", "ON", "大字体", "用更大的字体显示冷却时间.", "CooldownCount"},
	{"ShowHotKeys", "ON", "显示快捷键", "在饰品上显示绑定的快捷键."},
	{"StopOnSwap", "OFF", "被动饰品停止排队", "当换上一个被动饰品时停止自动排队.  选中这个选项时, 当一个可点击饰品通过 TrinketMenu 被手动换上时同样会停止自动排队. 当频繁标记饰品为优先时这个选项尤其有用"},
	{"HideOnLoad", "OFF", "当配置载入时关闭", "当你载入一个配置时关闭这个窗口."},
	{"RedRange", "OFF", "射程警告", "当有效目标在饰品的射程外时饰品变红警告.  例如, 侏儒死亡射线和侏儒捕网器."},
	{"HidePetBattle", "ON", "宠物战斗时隐藏", "在宠物战斗时自动隐藏该窗口"},
	{"MenuOnRight", "OFF", "右击菜单", "防止菜单出现除非一个警告饰品被右击.\n\n提示: 战斗中不能改变这个选项."}
}

TrinketMenu.TooltipInfo = {
	{"TrinketMenu_LockButton", "锁定窗口", "不能移动,缩放,转动饰品列表."},
	{"TrinketMenu_Trinket0Check", "上面饰品栏自动排队", "选中这个选项会让饰品自动排队替换到上面的饰品栏.  你也可以Alt+点击饰品来开关自动排队."},
	{"TrinketMenu_Trinket1Check", "下面饰品栏自动排队", "选中这个选项会让饰品自动排队替换到下面的饰品栏.  你也可以Alt+点击饰品来开关自动排队."},
	{"TrinketMenu_SortPriority", "高优先权", "当选中这个选项时, 这个饰品会被第一时间装备上, 而不管装备着的饰品是否在冷却中.\n\n当没选中时, 这个饰品不会替换掉没有在冷却中的已装备饰品."},
	{"TrinketMenu_SortDelay", "延迟替换", "设置一个饰品被替换的时间 (秒).  比如, 你需要20秒得到大地之击的20秒BUFF."},
	{"TrinketMenu_SortKeepEquipped", "暂停自动排队", "选中这个选项,当这个饰品被装备时会暂停自动排队替换. 比如, 你有一个自动换装的插件在你骑马时把棍子上的胡萝卜装备上了."},
	{"TrinketMenu_Profiles", "配置文件", "你可以载入或保存一个队列配置."},
	{"TrinketMenu_Delete", "删除", "从列表中删这个饰品.  更下面的饰品完全不会影响.  这个选项仅仅用来保持列表的可控性. 提示: 你包包里的饰品将回到列表的最下面."},
	{"TrinketMenu_ProfilesDelete", "删除配置", "移除这个配置Remove this profile."},
	{"TrinketMenu_ProfilesLoad", "载入配置", "为选中饰品槽载入一个队列.  你也可以双击一个配置来载入它."},
	{"TrinketMenu_ProfilesSave", "保存配置", "保存选中饰品槽的队列.  任一饰品槽都可以使用它."},
	{"TrinketMenu_ProfileName", "配置名", "为这个配置输入一个名字.  保存后, 你可以载入给任一饰品槽."},
	{"TrinketMenu_OptBindButton", "绑定饰品", "单击这里为你的上/下面饰品绑定一个热键."}
}

function TrinketMenu.InitOptions()
	TrinketMenu.CreateTimer("DragMinimapButton", TrinketMenu.DragMinimapButton, 0, 1)
	TrinketMenu.MoveMinimapButton()
	local item
	for i = 1, #TrinketMenu.CheckOptInfo do
		item = _G["TrinketMenu_Opt"..TrinketMenu.CheckOptInfo[i][1].."Text"]
		if item then
			item:SetText(TrinketMenu.CheckOptInfo[i][3])
			item:SetTextColor(.95, .95, .95)
		end
	end
	TrinketMenu.Tab_OnClick(1)
	table.insert(UISpecialFrames, "TrinketMenu_OptFrame")
	TrinketMenu_Title:SetText("TrinketMenu "..TrinketMenu_Version)
	TrinketMenu_OptFrame:SetBackdropBorderColor(.3, .3, .3, 1)
	TrinketMenu_SubOptFrame:SetBackdropBorderColor(.3, .3, .3, 1)
	if TrinketMenu.QueueInit then
		TrinketMenu.QueueInit()
		TrinketMenu_Tab1:Show()
		TrinketMenu_OptFrame:SetHeight(336)
		TrinketMenu_SubOptFrame:SetPoint("TOPLEFT", TrinketMenu_OptFrame, "TOPLEFT", 8, - 50)
	else
		TrinketMenu_OptStopOnSwap:Hide() -- remove StopOnSwap option if queue not loaded
		TrinketMenu_Tab1:Hide() -- hide options tab if it's only tab
		TrinketMenu_OptFrame:SetHeight(300)
		TrinketMenu_SubOptFrame:SetPoint("TOPLEFT", TrinketMenu_OptFrame, "TOPLEFT", 8, - 24)
	end
	TrinketMenu_OptColumnsSlider:SetValue(TrinketMenuOptions.Columns)
	TrinketMenu_OptColumnsSliderText:SetText(TrinketMenuOptions.Columns.." trinkets")
	TrinketMenu_OptMainScaleSlider:SetValue(TrinketMenuPerOptions.MainScale)
	TrinketMenu_OptMenuScaleSlider:SetValue(TrinketMenuPerOptions.MenuScale)
	TrinketMenu.ReflectLock()
	TrinketMenu.ReflectCooldownFont()
	TrinketMenu.KeyBindingsChanged()
end

function TrinketMenu.ToggleFrame(frame)
	if frame:IsVisible() then
		frame:Hide()
	else
		frame:Show()
	end
end

function TrinketMenu.OptFrame_OnShow()
	TrinketMenu.ValidateChecks()
	if TrinketMenu.CurrentlySorting then
		TrinketMenu.PopulateSort(TrinketMenu.CurrentlySorting)
	end
end

--[[ Minimap button ]]

function TrinketMenu.MoveMinimapButton()
	local xpos,ypos
	if TrinketMenuOptions.SquareMinimap == "ON" then
		xpos = 110 * cos(TrinketMenuOptions.IconPos or 0)
		ypos = 110 * sin(TrinketMenuOptions.IconPos or 0)
		xpos = math.max(- 82, math.min(xpos, 84))
		ypos = math.max(- 86, math.min(ypos, 82))
	else
		xpos = 80 * cos(TrinketMenuOptions.IconPos or 0)
		ypos = 80 * sin(TrinketMenuOptions.IconPos or 0)
	end
	TrinketMenu_IconFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - xpos, ypos - 52)
	if TrinketMenuOptions.ShowIcon == "ON" then
		TrinketMenu_IconFrame:Show()
	else
		TrinketMenu_IconFrame:Hide()
	end
end

function TrinketMenu.DragMinimapButton()
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft() or 400, Minimap:GetBottom() or 400
	xpos = xmin - xpos / Minimap:GetEffectiveScale() + 70
	ypos = ypos / Minimap:GetEffectiveScale() - ymin - 70
	TrinketMenuOptions.IconPos = math.deg(math.atan2(ypos, xpos))
	TrinketMenu.MoveMinimapButton()
end

function TrinketMenu.MinimapButton_OnClick(button)
	PlaySound(825)
	if IsShiftKeyDown() then
		TrinketMenuOptions.Locked = TrinketMenuOptions.Locked == "ON" and "OFF" or "ON"
		TrinketMenu.ReflectLock()
	elseif IsAltKeyDown() and TrinketMenu.QueueInit then
		if button == "LeftButton" then
			TrinketMenuQueue.Enabled[0] = not TrinketMenuQueue.Enabled[0] and 1 or nil
		elseif button == "RightButton" then
			TrinketMenuQueue.Enabled[1] = not TrinketMenuQueue.Enabled[1] and 1 or nil
		end
		TrinketMenu.ReflectQueueEnabled()
		TrinketMenu.UpdateCombatQueue()
	else
		if button == "LeftButton" and TrinketMenuOptions.DisableToggle == "OFF" then
			TrinketMenu.ToggleFrame(TrinketMenu_MainFrame)
		else
			TrinketMenu.ToggleFrame(TrinketMenu_OptFrame)
		end
	end
end

--[[ CheckButton ]]

function TrinketMenu.ValidateChecks()
	local check, button
	for i = 1, #TrinketMenu.CheckOptInfo do
		check = TrinketMenu.CheckOptInfo[i]
		button = _G["TrinketMenu_Opt"..check[1]]
		if button then
			button:SetChecked(TrinketMenuOptions[check[1]] == "ON")
			if check[5] then
				if TrinketMenuOptions[check[5]] == "ON" then
					button:Enable()
					_G["TrinketMenu_Opt"..check[1].."Text"]:SetTextColor(.95, .95, .95)
				else
					button:Disable()
					_G["TrinketMenu_Opt"..check[1].."Text"]:SetTextColor(.5, .5, .5)
				end
			end
		end
	end
	TrinketMenu_OptColumnsSlider:SetAlpha((TrinketMenuOptions.SetColumns == "ON") and 1 or .5)
	TrinketMenu_OptColumnsSlider:EnableMouse((TrinketMenuOptions.SetColumns == "ON") and 1 or 0)
	TrinketMenu_OptColumnsSlider:SetValue(TrinketMenuOptions.Columns)
end

function TrinketMenu.OptColumnsSlider_OnValueChanged(self, value)
	if not self._onsetting then
		self._onsetting = true
		self:SetValue(self:GetValue())
		value = self:GetValue()
		self._onsetting = false
	else
		return
	end
	if TrinketMenuOptions then
		TrinketMenuOptions.Columns = self:GetValue()
		TrinketMenu_OptColumnsSliderText:SetText(TrinketMenuOptions.Columns.." trinkets")
		if TrinketMenu_MenuFrame:IsVisible() then
			TrinketMenu.BuildMenu()
		end
	end
end

function TrinketMenu.OptMainScaleSlider_OnValueChanged(self, value)
	if not self._onsetting then
		self._onsetting = true
		self:SetValue(self:GetValue())
		value = self:GetValue()
		self._onsetting = false
	else
		return
	end
	if TrinketMenuPerOptions then
		TrinketMenuPerOptions.MainScale = self:GetValue()
		TrinketMenu_OptMainScaleSliderText:SetText(format("Main Scale: %.2f", TrinketMenuPerOptions.MainScale))
		TrinketMenu_MainFrame:SetScale(TrinketMenuPerOptions.MainScale)
	end
end

function TrinketMenu.OptMenuScaleSlider_OnValueChanged(self, value)
	if not self._onsetting then
		self._onsetting = true
		self:SetValue(self:GetValue())
		value = self:GetValue()
		self._onsetting = false
	else
		return
	end
	if TrinketMenuPerOptions then
		TrinketMenuPerOptions.MenuScale = self:GetValue()
		TrinketMenu_OptMenuScaleSliderText:SetText(format("Menu Scale: %.2f", TrinketMenuPerOptions.MenuScale))
		TrinketMenu_MenuFrame:SetScale(TrinketMenuPerOptions.MenuScale)
	end
end

function TrinketMenu.SliderOnMouseWheel(self, delta)
	if delta > 0 then
		self:SetValue(self:GetValue() + self:GetValueStep())
	else
		self:SetValue(self:GetValue() - self:GetValueStep())
	end
end

function TrinketMenu.CheckButton_OnClick(self)
	local _, _, var = string.find(self:GetName(), "TrinketMenu_Opt(.+)")
	if TrinketMenuOptions[var] then
		TrinketMenuOptions[var] = self:GetChecked() and "ON" or "OFF"
		PlaySound(self:GetChecked() and 856 or 857)
		TrinketMenu.ValidateChecks()
	end
	if self == TrinketMenu_OptCooldownCount then
		TrinketMenu.WriteWornCooldowns()
		TrinketMenu.WriteMenuCooldowns()
	elseif self == TrinketMenu_OptLocked then
		TrinketMenu.DockWindows()
		TrinketMenu.ReflectLock()
	elseif self == TrinketMenu_OptKeepOpen or self == TrinketMenu_OptSetColumns then
		if TrinketMenuOptions.KeepOpen == "ON" then
			TrinketMenu.BuildMenu()
		end
	elseif self == TrinketMenu_OptKeepDocked then
		TrinketMenu.DockWindows()
	elseif self == TrinketMenu_OptLargeCooldown then
		TrinketMenu.ReflectCooldownFont()
	elseif self == TrinketMenu_OptSquareMinimap then
		TrinketMenu.MoveMinimapButton()
	elseif self == TrinketMenu_OptShowHotKeys then
		TrinketMenu.KeyBindingsChanged()
	elseif self == TrinketMenu_OptShowIcon then
		TrinketMenu.MoveMinimapButton()
	elseif self == TrinketMenu_OptRedRange then
		TrinketMenu.ReflectRedRange()
	elseif self == TrinketMenu_OptMenuOnRight then
		TrinketMenu.ReflectMenuOnRight()
	elseif self == TrinketMenu_OptNotify or self == TrinketMenu_OptNotifyThirty then
		if TrinketMenu_OptNotify:GetChecked() or TrinketMenu_OptNotifyThirty:GetChecked() then
			TrinketMenu.StartTimer("CooldownUpdate")
		elseif not TrinketMenu_OptNotify:GetChecked() and not TrinketMenu_OptNotifyThirty:GetChecked() then
			TrinketMenu.StopTimer("CooldownUpdate")
		end
	end
end

function TrinketMenu.ReflectLock()
	local c = TrinketMenuOptions.Locked == "ON" and 0 or .5
	TrinketMenu_OptFrame:SetBackdropBorderColor(c, c, c, 1)
	TrinketMenu_MainFrame:SetBackdropColor(c, c, c, c)
	TrinketMenu_MainFrame:SetBackdropBorderColor(c, c, c, c * 2)
	TrinketMenu_MenuFrame:SetBackdropColor(c, c, c, c)
	TrinketMenu_MenuFrame:SetBackdropBorderColor(c, c, c, c * 2)
	TrinketMenu_MenuFrame:EnableMouse(c * 2)
	if TrinketMenuOptions.Locked == "ON" then
		TrinketMenu_OptLocked:SetChecked(true)
	else
		TrinketMenu_OptLocked:SetChecked(false)
	end
	local normalTexture = TrinketMenu_LockButton:GetNormalTexture()
	local pushedTexture = TrinketMenu_LockButton:GetPushedTexture()
	if c == 0 then
		normalTexture:SetTexCoord(.875, 1, .125, .25)
		pushedTexture:SetTexCoord(.75, .875, .125, .25)
	else
		normalTexture:SetTexCoord(.75, .875, .125, .25)
		pushedTexture:SetTexCoord(.875, 1, .125, .25)
	end
end

function TrinketMenu.ReflectCooldownFont()
	TrinketMenu.SetCooldownFont("TrinketMenu_Trinket0")
	TrinketMenu.SetCooldownFont("TrinketMenu_Trinket1")
	for i = 1, 30 do
		TrinketMenu.SetCooldownFont("TrinketMenu_Menu"..i)
	end
end

function TrinketMenu.SetCooldownFont(button)
	local item = _G[button.."Time"]
	if TrinketMenuOptions.LargeCooldown == "ON" then
		item:SetFont("Fonts\\ARHei.TTF", 16, "OUTLINE")
		item:SetTextColor(1, .82, 0, 1)
		item:ClearAllPoints()
		item:SetPoint("CENTER", button, "CENTER")
	else
		item:SetFont("Fonts\\ARHei.TTF", 14, "OUTLINE")
		item:SetTextColor(1, 1, 1, 1)
		item:ClearAllPoints()
		item:SetPoint("BOTTOM", button, "BOTTOM")
	end
end

--[[ Titlebar buttons ]]

function TrinketMenu.SmallButton_OnClick(self)
	PlaySound(856)
	if self == TrinketMenu_CloseButton then
		TrinketMenu_OptFrame:Hide()
	elseif self == TrinketMenu_LockButton then
		TrinketMenuOptions.Locked = (TrinketMenuOptions.Locked == "ON") and "OFF" or "ON"
		TrinketMenu.DockWindows()
		TrinketMenu.ReflectLock()
	end
end

--[[ Tabs ]]

function TrinketMenu.Tab_OnClick(id)
	PlaySound(825)
	local tab
	if TrinketMenu_ProfilesFrame then
		TrinketMenu_ProfilesFrame:Hide()
	end
	for i = 1, 3 do
		tab = _G["TrinketMenu_Tab"..i]
		if tab then
			tab:UnlockHighlight()
		end
	end
	_G["TrinketMenu_Tab"..id]:LockHighlight()
	if id == 1 then
		TrinketMenu_SubOptFrame:Show()
		if TrinketMenu_SubQueueFrame then
			TrinketMenu_SubQueueFrame:Hide()
		end
	else
		TrinketMenu_SubOptFrame:Hide()
		TrinketMenu_SubQueueFrame:Show()
		TrinketMenu.OpenSort(3 - id)
	end
end

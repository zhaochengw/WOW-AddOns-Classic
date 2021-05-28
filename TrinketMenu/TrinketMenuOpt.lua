--[[ TrinketMenuOpt.lua : Options and sort window for TrinketMenu ]]

local _G, math, string, table = _G, math, string, table

TrinketMenu.CheckOptInfo = {
	{"ShowIcon", "ON", "小地图按钮", "Show or hide minimap button."},
	{"SquareMinimap", "OFF", "方形小地图", "Move minimap button as if around a square minimap.", "ShowIcon"},
	{"CooldownCount", "OFF", "冷却时间计数", "Display time remaining on cooldowns ontop of the button."},
	{"TooltipFollow", "OFF", "鼠标提示", "Display all tooltips near the mouse.", "ShowTooltips"},
	{"KeepOpen", "OFF", "总是打开菜单", "Keep menu open at all times."},
	{"KeepDocked", "ON", "总是停靠菜单", "Keep menu docked at all times."},
	{"Notify", "OFF", "CD好时通告", "Sends an overhead notification when a trinket's cooldown is complete."},
	{"DisableToggle", "OFF", "禁用切换", "Disables the minimap button's ability to toggle the trinket frame.", "ShowIcon"},
	{"NotifyChatAlso", "OFF", "通告聊天框", "Sends notifications through chat also."},
	{"Locked", "OFF", "锁定框架", "Prevents the windows from being moved, resized or rotated."},
	{"ShowTooltips", "ON", "显示鼠标提示", "Shows tooltips."},
	{"NotifyThirty", "ON", "30秒时通告", "Sends an overhead notification when a trinket has 30 seconds left on cooldown."},
	{"MenuOnShift", "OFF", "Shift键菜单", "Check this to prevent the menu appearing unless Shift is held."},
	{"TinyTooltips", "OFF", "迷你鼠标提示", "Shrink trinket tooltips to only their name, charges and cooldown.", "ShowTooltips"},
	{"SetColumns", "OFF", "自动换行: ", "Define how many trinkets before the menu will wrap to the next row.\n\nUncheck to let TrinketMenu choose how to wrap the menu."},
	{"LargeCooldown", "ON", "大字体", "Display the cooldown time in a larger font.", "CooldownCount"},
	{"ShowHotKeys", "ON", "显示按键绑定", "Display the key bindings over the equipped trinkets."},
	{"StopOnSwap", "OFF", "交换时停止队列", "Swapping a passive trinket stops an auto queue.  Check this to also stop the auto queue when a clickable trinket is manually swapped in via TrinketMenu.  This will have the most use to those with frequent trinkets marked Priority."},
	{"HideOnLoad", "OFF", "配置加载时关闭", "Check this to dismiss this window when you load a profile."},
	{"RedRange", "OFF", "超出范围显示红色", "Check this to red out worn trinkets that are out of range to a valid target.  ie, Gnomish Death Ray and Gnomish Net-O-Matic."},
	{"HidePetBattle", "ON", "宠物战斗时隐藏", "Check this auto hide the frame while in a pet battle."},
	{"MenuOnRight", "OFF", "右键菜单", "Check this to prevent the menu from appearing until either worn trinket is right-clicked.\n\nNOTE: This setting CANNOT be changed while in combat."}
}

TrinketMenu.TooltipInfo = {
	{"TrinketMenu_LockButton", "锁定框架", "Prevents the windows from being moved, resized or rotated."},
	{"TrinketMenu_Trinket0Check", "饰品1自动队列", "Check this to enable auto queue for this trinket slot.  You can also Alt+Click the trinket slot to toggle Auto Queue."},
	{"TrinketMenu_Trinket1Check", "饰品2自动队列", "Check this to enable auto queue for this trinket slot.  You can also Alt+Click the trinket slot to toggle Auto Queue."},
	{"TrinketMenu_SortPriority", "高优先级", "When checked, this trinket will be swapped in as soon as possible, whether the equipped trinket is on cooldown or not.\n\nWhen unchecked, this trinket will not equip over one already worn that's not on cooldown."},
	{"TrinketMenu_SortDelay", "交换延迟", "This is the time (in seconds) before a trinket will be swapped out.  ie, for Earthstrike you want 20 seconds to get the full 20 second effect of the buff."},
	{"TrinketMenu_SortKeepEquipped", "暂停队列", "Check this to suspend the auto queue while this trinket is equipped. ie, for Carrot on a Stick if you have a mod to auto-equip it to a slot with Auto Queue active."},
	{"TrinketMenu_Profiles", "配置", "Here you can load or save auto queue profiles."},
	{"TrinketMenu_Delete", "删除", "Remove this trinket from the list.  Trinkets further down the list don't affect performance at all.  This option is merely to keep the list managable. Note: Trinkets in your bags will return to end of the list."},
	{"TrinketMenu_ProfilesDelete", "删除配置", "Remove this profile."},
	{"TrinketMenu_ProfilesLoad", "加载配置", "Load a queue order for the selected trinket slot.  You can double-click a profile to load it also."},
	{"TrinketMenu_ProfilesSave", "保存配置", "Save the queue order from the selected trinket slot.  Either trinket slot can use saved profiles."},
	{"TrinketMenu_ProfileName", "配置文件名", "Enter a name to call the profile.  When saved, you can load this profile to either trinket slot."}
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
	TrinketMenu_OptColumnsSliderText:SetText(TrinketMenuOptions.Columns.." 饰品")
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

function TrinketMenu.MinimapButton_OnClick()
	PlaySound(825)
	if IsShiftKeyDown() then
		TrinketMenuOptions.Locked = TrinketMenuOptions.Locked == "ON" and "OFF" or "ON"
		TrinketMenu.ReflectLock()
	elseif IsAltKeyDown() and TrinketMenu.QueueInit then
		if arg1 == "LeftButton" then
			TrinketMenuQueue.Enabled[0] = not TrinketMenuQueue.Enabled[0] and 1 or nil
		elseif arg1 == "RightButton" then
			TrinketMenuQueue.Enabled[1] = not TrinketMenuQueue.Enabled[1] and 1 or nil
		end
		TrinketMenu.ReflectQueueEnabled()
		TrinketMenu.UpdateCombatQueue()
	else
		if arg1 == "LeftButton" and TrinketMenuOptions.DisableToggle == "OFF" then
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
		TrinketMenu_OptMainScaleSliderText:SetText(format("框架大小: %.2f", TrinketMenuPerOptions.MainScale))
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
		TrinketMenu_OptMenuScaleSliderText:SetText(format("菜单大小: %.2f", TrinketMenuPerOptions.MenuScale))
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
		item:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
		item:SetTextColor(1, .82, 0, 1)
		item:ClearAllPoints()
		item:SetPoint("CENTER", button, "CENTER")
	else
		item:SetFont("Fonts\\ARIALN.TTF", 14, "OUTLINE")
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
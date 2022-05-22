-- bar_config.lua =============================================================================
local addon_name, addon_data = ...
local print = addon_data.utils.print_msg


--[[============================================================================================]]--
--[[================================== CONFIG WINDOW RELATED ===================================]]--
--[[============================================================================================]]--

addon_data.bar.UpdateConfigPanelValues = function()
    local panel = addon_data.bar.config_frame
    local settings = character_bar_settings
    panel.enabled_checkbox:SetChecked(settings.enabled)
    panel.is_locked_checkbox:SetChecked(settings.is_locked)

    panel.is_lag_detection_enabled_checkbox:SetChecked(settings.lag_detection_enabled)
    panel.is_twist_color_enabled_checkbox:SetChecked(settings.enable_twist_bar_color)
    panel.hide_when_inactive_checkbox:SetChecked(settings.hide_when_inactive)
    panel.show_judgement_marker_checkbox:SetChecked(settings.judgement_marker)

    panel.lag_multiplier_editbox:SetText(tostring(character_player_settings.lag_multiplier))
    panel.lag_multiplier_editbox:SetCursorPosition(0)

    panel.lag_threshold_editbox:SetText(tostring(character_player_settings.lag_threshold))
    panel.lag_threshold_editbox:SetCursorPosition(0)

    -- panel.show_border_checkbox:SetChecked(settings.show_border)
    -- panel.classic_bars_checkbox:SetChecked(settings.classic_bars)
    -- panel.fill_empty_checkbox:SetChecked(settings.fill_empty)
    panel.show_left_text_checkbox:SetChecked(settings.show_left_text)
    panel.show_right_text_checkbox:SetChecked(settings.show_right_text)
    panel.width_editbox:SetText(tostring(settings.width))
    panel.width_editbox:SetCursorPosition(0)
    panel.height_editbox:SetText(tostring(settings.height))
    panel.height_editbox:SetCursorPosition(0)
	panel.fontsize_editbox:SetText(tostring(settings.fontsize))
    panel.fontsize_editbox:SetCursorPosition(0)
    panel.x_offset_editbox:SetText(tostring(settings.x_offset))
    panel.x_offset_editbox:SetCursorPosition(0)
    panel.y_offset_editbox:SetText(tostring(settings.y_offset))
    panel.y_offset_editbox:SetCursorPosition(0)

    panel.twist_window_editbox:SetText(tostring(settings.twist_window))
    panel.twist_window_editbox:SetCursorPosition(0)

    panel.grace_period_editbox:SetText(tostring(settings.grace_period))
    panel.grace_period_editbox:SetCursorPosition(0)

    panel.tick_width_slider:SetValue(tostring(settings.tick_width))
    panel.tick_width_slider.editbox:SetCursorPosition(0)

    -- panel.main_color_picker.foreground:SetColorTexture(
    --     settings.main_r, settings.main_g, settings.main_b, settings.main_a)
    -- panel.main_text_color_picker.foreground:SetColorTexture(
    --     settings.main_text_r, settings.main_text_g, settings.main_text_b, settings.main_text_a)
    -- panel.in_combat_alpha_slider:SetValue(settings.in_combat_alpha)
    -- panel.in_combat_alpha_slider.editbox:SetCursorPosition(0)
    -- panel.ooc_alpha_slider:SetValue(settings.ooc_alpha)
    -- panel.ooc_alpha_slider.editbox:SetCursorPosition(0)
    panel.backplane_alpha_slider:SetValue(settings.backplane_alpha)
    panel.backplane_alpha_slider.editbox:SetCursorPosition(0)
end

addon_data.bar.EnabledCheckBoxOnClick = function(self)
    character_bar_settings.enabled = self:GetChecked()
    addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.bar.TwistBarToggle = function()
    currently_on = character_bar_settings.enabled == true
    if not currently_on then
        character_bar_settings.enabled = true
    else
        character_bar_settings.enabled = false
    end
    addon_data.bar.UpdateConfigPanelValues()
    addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.bar.TwistBarLockToggle = function()
    currently_on = character_bar_settings.is_locked == true
    if not currently_on then
        character_bar_settings.is_locked = true
    else
        character_bar_settings.is_locked = false
    end
    addon_data.bar.UpdateConfigPanelValues()
    addon_data.bar.UpdateVisualsOnSettingsChange()
end


addon_data.bar.IsLockedCheckBoxOnClick = function(self)
    character_bar_settings.is_locked = self:GetChecked()
    addon_data.bar.frame:EnableMouse(not character_bar_settings.is_locked)
    addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.bar.LagDetectionEnabledBoxOnClick = function(self)
    character_bar_settings.lag_detection_enabled = self:GetChecked()
    addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.bar.TwistColorEnabledBoxOnClick = function(self)
    character_bar_settings.enable_twist_bar_color = self:GetChecked()
end

addon_data.bar.DisableWhenInactiveBoxOnClick = function(self)
    character_bar_settings.hide_when_inactive = self:GetChecked()
end

addon_data.bar.ShowLeftTextCheckBoxOnClick = function(self)
    character_bar_settings.show_left_text = self:GetChecked()
    addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.bar.ShowRightTextCheckBoxOnClick = function(self)
    character_bar_settings.show_right_text = self:GetChecked()
    addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.bar.ShowJudgementMarkerOnClick = function(self)
    character_bar_settings.judgement_marker = self:GetChecked()
    -- addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.bar.WidthEditBoxOnEnter = function(self)
    character_bar_settings.width = tonumber(self:GetText())
    addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.bar.HeightEditBoxOnEnter = function(self)
    character_bar_settings.height = tonumber(self:GetText())
    addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.bar.FontSizeEditBoxOnEnter = function(self)
    character_bar_settings.fontsize = tonumber(self:GetText())
    addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.bar.XOffsetEditBoxOnEnter = function(self)
    character_bar_settings.x_offset = tonumber(self:GetText())
    addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.bar.YOffsetEditBoxOnEnter = function(self)
    character_bar_settings.y_offset = tonumber(self:GetText())
    addon_data.bar.UpdateVisualsOnSettingsChange()
end


addon_data.bar.LagMultiplierOnEnter = function(self)
    character_player_settings.lag_multiplier = tonumber(self:GetText())    
end

addon_data.bar.LagThresholdOnEnter = function(self)
    character_player_settings.lag_threshold = tonumber(self:GetText())    
end

addon_data.bar.TwistWindowOnEnter = function(self)
    character_bar_settings.twist_window = tonumber(self:GetText())
end

addon_data.bar.GracePeriodOnEnter = function(self)
    character_bar_settings.grace_period = tonumber(self:GetText())
end

addon_data.bar.TickWidthOnValChange = function(self)
    character_bar_settings.tick_width = tonumber(self:GetValue())
    addon_data.bar.UpdateVisualsOnSettingsChange()
end

addon_data.bar.CreateConfigPanel = function(parent_panel)
    addon_data.bar.config_frame = CreateFrame("Frame", addon_name .. "PlayerConfigPanel", parent_panel)
    local panel = addon_data.bar.config_frame
    local settings = character_bar_settings
    
    -- Title Text
    panel.title_text = addon_data.config.TextFactory(panel, "Twist Bar", 18)
    panel.title_text:SetPoint("TOPLEFT", 0, 60)
    panel.title_text:SetTextColor(1, 0.82, 0, 1)
    
    -- Enabled Checkbox
    panel.enabled_checkbox = addon_data.config.CheckBoxFactory(
        "PlayerEnabledCheckBox",
        panel,
        " Enable",
        "Enables the twist bar.",
        addon_data.bar.EnabledCheckBoxOnClick)
    panel.enabled_checkbox:SetPoint("TOPLEFT", 10, 36)
    
    -- Is Locked Checkbox
    panel.is_locked_checkbox = addon_data.config.CheckBoxFactory(
        "IsLockedCheckBox",
        panel,
        " Lock Bar",
        "Locks the twist bar in place.",
        addon_data.bar.IsLockedCheckBoxOnClick)
    panel.is_locked_checkbox:SetPoint("TOPLEFT", 10, 16)

    -- Show Left Text Checkbox
    panel.show_left_text_checkbox = addon_data.config.CheckBoxFactory(
        "PlayerShowLeftTextCheckBox",
        panel,
        "Show Attack Speed Text",
        "Shows the player's attack speed on the left of the bar.",
        addon_data.bar.ShowLeftTextCheckBoxOnClick)
    panel.show_left_text_checkbox:SetPoint("TOPLEFT", 10, -4)

    -- Show Right Text Checkbox
    panel.show_right_text_checkbox = addon_data.config.CheckBoxFactory(
        "PlayerShowRightTextCheckBox",
        panel,
        "Show Swing Timer Text",
        "Shows the player's swing timer on the right of the bar.",
        addon_data.bar.ShowRightTextCheckBoxOnClick)
    panel.show_right_text_checkbox:SetPoint("TOPLEFT", 10, -24)
    
    -- lag detection enabled checkbox
    panel.is_lag_detection_enabled_checkbox = addon_data.config.CheckBoxFactory(
        "IsLagDetectionEnabledCheckbox",
        panel,
        " Lag Detection",
        "Enables experimental lag detection, changing the bar colour to yellow when lag might ruin a twist attempt.",
        addon_data.bar.LagDetectionEnabledBoxOnClick
    )
    panel.is_lag_detection_enabled_checkbox:SetPoint("TOPLEFT", 10, -44)

    -- twist color enabled checkbox
    panel.is_twist_color_enabled_checkbox = addon_data.config.CheckBoxFactory(
        "IsTwistColorEnabledCheckbox",
        panel,
        " Twist Color Enabled",
        "When enabled, turns the bar a special color when the player has two active seals i.e is twisting." ..
        " Defaults to purple.",
        addon_data.bar.TwistColorEnabledBoxOnClick
        -- addon_data.bar.TwistColorEnabledBoxOnClick
    )
    panel.is_twist_color_enabled_checkbox:SetPoint("TOPLEFT", 10, -64)

    -- Hide When Inactive Checkbox
    panel.hide_when_inactive_checkbox = addon_data.config.CheckBoxFactory(
        "HideWhenInactiveCheckbox",
        panel,
        " Hide When Inactive",
        "Hides the bar when the player is both out of combat, and has no active seals.",
        addon_data.bar.DisableWhenInactiveBoxOnClick
    )
    panel.hide_when_inactive_checkbox:SetPoint("TOPLEFT", 10, -84)

    -- Show Judgement Marker Checkbox
    panel.show_judgement_marker_checkbox = addon_data.config.CheckBoxFactory(
        "ShowJudgementMarkerCheckbox",
        panel,
        " Show Judgement Indicator",
        "Shows a large yellow line on the bar when the judgement spell is coming off cooldown that swing.",
        addon_data.bar.ShowJudgementMarkerOnClick
    )
    panel.show_judgement_marker_checkbox:SetPoint("TOPLEFT", 10, -104)

    -- Width EditBox
    panel.width_editbox = addon_data.config.EditBoxFactory(
        "PlayerWidthEditBox",
        panel,
        "Bar Width",
        75,
        25,
        addon_data.bar.WidthEditBoxOnEnter)
    panel.width_editbox:SetPoint("TOPLEFT", 220, -15, "BOTTOMRIGHT", 275, -85)

    -- Height EditBox
    panel.height_editbox = addon_data.config.EditBoxFactory(
        "PlayerHeightEditBox",
        panel,
        "Bar Height",
        75,
        25,
        addon_data.bar.HeightEditBoxOnEnter)
    panel.height_editbox:SetPoint("TOPLEFT", 300, -15, "BOTTOMRIGHT", 355, -85)

	-- Font Size EditBox
	panel.fontsize_editbox = addon_data.config.EditBoxFactory(
        "FontSizeEditBox",
        panel,
        "Font Size",
        75,
        25,
        addon_data.bar.FontSizeEditBoxOnEnter)
    panel.fontsize_editbox:SetPoint("TOPLEFT", 180, 30)

    -- X Offset EditBox
    panel.x_offset_editbox = addon_data.config.EditBoxFactory(
        "PlayerXOffsetEditBox",
        panel,
        "X Offset",
        75,
        25,
        addon_data.bar.XOffsetEditBoxOnEnter)
    panel.x_offset_editbox:SetPoint("TOPLEFT", 260, 30, "BOTTOMRIGHT", 240, 30)

    -- Y Offset EditBox
    panel.y_offset_editbox = addon_data.config.EditBoxFactory(
        "PlayerYOffsetEditBox",
        panel,
        "Y Offset",
        75,
        25,
        addon_data.bar.YOffsetEditBoxOnEnter)
    panel.y_offset_editbox:SetPoint("TOPLEFT", 340, 30, "BOTTOMRIGHT", 355, 30)
    
    -- Lag multiplier EditBox
    panel.lag_multiplier_editbox = addon_data.config.EditBoxFactory(
        "LagMultiplierEditBox",
        panel,
        "Lag Multiplier (s)",
        -- "A multiplier used in calibrating the lag detection. Your world ping multiplied by this number" ..
        -- " will be compared to the time left on your swing to detect impossible twists.",
        75,
        25,
        addon_data.bar.LagMultiplierOnEnter
    )
    panel.lag_multiplier_editbox:SetPoint("TOPLEFT", 200, -60, "BOTTOMRIGHT", 355, 30)

    -- Lag threshold EditBox
    panel.lag_threshold_editbox = addon_data.config.EditBoxFactory(
        "LagThresholdEditBox",
        panel,
        "Lag Threshold (s)",
        -- "A multiplier used in calibrating the lag detection. Your world ping multiplied by this number" ..
        -- " will be compared to the time left on your swing to detect impossible twists.",
        75,
        25,
        addon_data.bar.LagThresholdOnEnter
    )
    panel.lag_threshold_editbox:SetPoint("TOPLEFT", 315, -60, "BOTTOMRIGHT", 355, 30)

    panel.twist_window_editbox = addon_data.config.EditBoxFactory(
        "TwistWindowEditBox",
        panel,
        "Twist Window (s)",
        75,
        25,
        addon_data.bar.TwistWindowOnEnter
    )
    panel.twist_window_editbox:SetPoint("TOPLEFT", 200, -100, "BOTTOMRIGHT", 355, 30)

    panel.grace_period_editbox = addon_data.config.EditBoxFactory(
        "GracePeriodEditBox",
        panel,
        "Grace Period (s)",
        75,
        25,
        addon_data.bar.GracePeriodOnEnter
    )
    panel.grace_period_editbox:SetPoint("TOPLEFT", 315, -100, "BOTTOMRIGHT", 355, 30)

    -- Twist bar color picker
    -- panel.main_color_picker = addon_data.config.color_picker_factory(
    --     'PlayerMainColorPicker',
    --     panel,
    --     settings.main_r, settings.main_g, settings.main_b, settings.main_a,
    --     "Twist Bar Color",
    --     addon_data.bar.MainColorPickerOnClick)
    -- panel.main_color_picker:SetPoint('TOPLEFT', 205, -150)

    -- -- Twist bar text color picker
    -- panel.main_text_color_picker = addon_data.config.color_picker_factory(
    --     'PlayerMainTextColorPicker',
    --     panel,
    --     settings.main_text_r, settings.main_text_g, settings.main_text_b, settings.main_text_a,
    --     "Twist Bar Text Color",
    --     addon_data.bar.MainTextColorPickerOnClick)
    -- panel.main_text_color_picker:SetPoint('TOPLEFT', 205, -170)
    panel.tick_width_slider = addon_data.config.SliderFactory(
        "TickWidthSlider",
        panel,
        "Marker Width",
        0, 5, 1,
        addon_data.bar.TickWidthOnValChange    
    )
    panel.tick_width_slider:SetPoint("TOPLEFT", 405, -60)

    -- In Combat Alpha Slider
    -- panel.in_combat_alpha_slider = addon_data.config.SliderFactory(
    --     "PlayerInCombatAlphaSlider",
    --     panel,
    --     "In Combat Opacity",
    --     0,
    --     1,
    --     0.05,
    --     addon_data.bar.CombatAlphaOnValChange)
    -- panel.in_combat_alpha_slider:SetPoint("TOPLEFT", 405, -60)

    -- -- Out Of Combat Alpha Slider
    -- panel.ooc_alpha_slider = addon_data.config.SliderFactory(
    --     "PlayerOOCAlphaSlider",
    --     panel,
    --     "Out of Combat Opacity",
    --     0,
    --     1,
    --     0.05,
    --     addon_data.bar.OOCAlphaOnValChange)
    -- panel.ooc_alpha_slider:SetPoint("TOPLEFT", 405, -110)
    
    -- Backplane Alpha Slider
    panel.backplane_alpha_slider = addon_data.config.SliderFactory(
        "PlayerBackplaneAlphaSlider",
        panel,
        "Backplane Opacity",
        0,
        1,
        0.05,
        addon_data.bar.BackplaneAlphaOnValChange)
    panel.backplane_alpha_slider:SetPoint("TOPLEFT", 405, -110)
    
    -- Return the final panel
    addon_data.bar.UpdateConfigPanelValues()
    return panel
end


-- addon_data.bar.MainColorPickerOnClick = function()
--     local settings = character_bar_settings
--     local function MainOnActionFunc(restore)
--         local settings = character_bar_settings
--         local new_r, new_g, new_b, new_a
--         if restore then
--             new_r, new_g, new_b, new_a = unpack(restore)
--         else
--             new_a, new_r, new_g, new_b = 1 - OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
--         end
--         settings.main_r, settings.main_g, settings.main_b, settings.main_a = new_r, new_g, new_b, new_a
--         addon_data.bar.frame.bar:SetVertexColor(
--             settings.main_r, settings.main_g, settings.main_b, settings.main_a)
--         addon_data.bar.config_frame.main_color_picker.foreground:SetColorTexture(
--             settings.main_r, settings.main_g, settings.main_b, settings.main_a)
--     end
--     ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = 
--         MainOnActionFunc, MainOnActionFunc, MainOnActionFunc
--     ColorPickerFrame.hasOpacity = true 
--     ColorPickerFrame.opacity = 1 - settings.main_a
--     ColorPickerFrame:SetColorRGB(settings.main_r, settings.main_g, settings.main_b)
--     ColorPickerFrame.previousValues = {settings.main_r, settings.main_g, settings.main_b, settings.main_a}
--     ColorPickerFrame:Show()
-- end

-- addon_data.bar.MainTextColorPickerOnClick = function()
--     local settings = character_bar_settings
--     local function MainTextOnActionFunc(restore)
--         local settings = character_bar_settings
--         local new_r, new_g, new_b, new_a
--         if restore then
--             new_r, new_g, new_b, new_a = unpack(restore)
--         else
--             new_a, new_r, new_g, new_b = 1 - OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
--         end
--         settings.main_text_r, settings.main_text_g, settings.main_text_b, settings.main_text_a = new_r, new_g, new_b, new_a
--         addon_data.bar.frame.left_text:SetTextColor(
--             settings.main_text_r, settings.main_text_g, settings.main_text_b, settings.main_text_a)
--         addon_data.bar.frame.right_text:SetTextColor(
--             settings.main_text_r, settings.main_text_g, settings.main_text_b, settings.main_text_a)
--         addon_data.bar.config_frame.main_text_color_picker.foreground:SetColorTexture(
--             settings.main_text_r, settings.main_text_g, settings.main_text_b, settings.main_text_a)
--     end
--     ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = 
--         MainTextOnActionFunc, MainTextOnActionFunc, MainTextOnActionFunc
--     ColorPickerFrame.hasOpacity = true 
--     ColorPickerFrame.opacity = 1 - settings.main_text_a
--     ColorPickerFrame:SetColorRGB(settings.main_text_r, settings.main_text_g, settings.main_text_b)
--     ColorPickerFrame.previousValues = {settings.main_text_r, settings.main_text_g, settings.main_text_b, settings.main_text_a}
--     ColorPickerFrame:Show()
-- end


-- addon_data.bar.CombatAlphaOnValChange = function(self)
--     character_bar_settings.in_combat_alpha = tonumber(self:GetValue())
--     addon_data.bar.UpdateVisualsOnSettingsChange()
-- end

-- addon_data.bar.OOCAlphaOnValChange = function(self)
--     character_bar_settings.ooc_alpha = tonumber(self:GetValue())
--     addon_data.bar.UpdateVisualsOnSettingsChange()
-- end

addon_data.bar.BackplaneAlphaOnValChange = function(self)
    character_bar_settings.backplane_alpha = tonumber(self:GetValue())
    addon_data.bar.UpdateVisualsOnSettingsChange()
end


--=========================================================================================
-- End, if debug verify module was read.
--=========================================================================================
if addon_data.debug then print('-- Parsed bar_config.lua module correctly') end
local _, addon = ...
local F = CreateFrame("Frame")

local defaults = {
    spacing = 5,
    backgroundColor = {0.1, 0.1, 0.1, 0.8},
    lock = false,
    scale = 1,
    visible = true,
    useClassColor = true,
    borderColor = {1, 1, 1, 1},
    position = {
        point = "TOP",
        relativeTo = "UIParent",
        relativePoint = "TOP",
        x = 0,
        y = 0
    },
    showTopLine = true,
    showBottomLine = true,
    showLeftLine = true,
    showRightLine = true,
    showTimeModule = true,
    backgroundAlpha = 0.8,
    borderThickness = 1
}

local ConfigManager = {}
addon.ConfigManager = ConfigManager
ConfigManager.dbName = "FuxBarDB"

function ConfigManager:ShallowCopy(src)
    if type(src) ~= "table" then return src end
    local copy = {}
    for k, v in pairs(src) do
        copy[k] = v
    end
    return copy
end

function ConfigManager:Init()
    local account = GetCVar("accountName") or "UnknownAccount"
    local _, realm = UnitFullName("player")
    self.configKey = account.."-"..(realm or "UnknownRealm")
    
    if not _G[self.dbName] then
        _G[self.dbName] = {}
    end
    
    if not _G[self.dbName][self.configKey] then
        _G[self.dbName][self.configKey] = self:ShallowCopy(defaults)
    end

    self.config = _G[self.dbName][self.configKey]
    self:MigrateConfig()
    return self.config
end

function ConfigManager:MigrateConfig()
    for k, v in pairs(defaults) do
        if self.config[k] == nil then
            self.config[k] = type(v) == "table" and self:ShallowCopy(v) or v
        end
    end
    
    if not self.config.backgroundColor[4] then
        self.config.backgroundColor[4] = self.config.backgroundAlpha or 0.8
    end
    if not self.config.borderThickness then
        self.config.borderThickness = 1
    end
end

local saveTimer
function ConfigManager:SaveToFile(silent)
    if saveTimer then
        saveTimer:Cancel()
    end
    
    saveTimer = C_Timer.After(0.5, function()
        _G[self.dbName][self.configKey] = self:ShallowCopy(self.config)
    end)
end

function ConfigManager:GetConfigFilePath()
    local account = GetCVar("accountName") or "UnknownAccount"
    return "WTF/Account/"..account.."/SavedVariables/"..self.dbName..".lua"
end

function ConfigManager:Serialize(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        if type(k) == "string" then
            result = result..string.format("[%q]=%s,", k, self:SerializeValue(v))
        else
            result = result.."["..tostring(k).."]="..self:SerializeValue(v)..","
        end
    end
    return result.."}"
end

function ConfigManager:SerializeValue(v)
    if type(v) == "table" then
        return self:Serialize(v)
    elseif type(v) == "string" then
        return string.format("%q", v)
    else
        return tostring(v)
    end
end

function addon.CreateFuxBar()
    local bar = CreateFrame("Frame", "FuxBar", UIParent)
    bar:SetMovable(true)
    bar:SetUserPlaced(true)
    bar:SetClampedToScreen(true)
    bar:SetFrameStrata("BACKGROUND")
    bar.modules = {}
    
    bar:SetSize(400, 40)
    bar:SetScale(ConfigManager.config.scale)
    bar:ClearAllPoints()
    bar:SetPoint(
        ConfigManager.config.position.point,
        UIParent,
        ConfigManager.config.position.relativePoint,
        ConfigManager.config.position.x,
        ConfigManager.config.position.y
    )

    local backgroundFrame = CreateFrame("Frame", nil, bar, "BackdropTemplate")
    backgroundFrame:SetAllPoints(bar)
    backgroundFrame:SetBackdrop({
        bgFile = "Interface\\AddOns\\MenuBar\\Menu\\bj.tga",
        edgeFile = nil,
    })
    backgroundFrame:SetAlpha(ConfigManager.config.visible and ConfigManager.config.backgroundAlpha or 0)

    bar.topLine = bar:CreateTexture(nil, "ARTWORK")
    bar.topLine:SetHeight(ConfigManager.config.borderThickness)
    bar.topLine:SetPoint("TOPLEFT", bar, "TOPLEFT")
    bar.topLine:SetPoint("TOPRIGHT", bar, "TOPRIGHT")

    bar.bottomLine = bar:CreateTexture(nil, "ARTWORK")
    bar.bottomLine:SetHeight(ConfigManager.config.borderThickness)
    bar.bottomLine:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT")
    bar.bottomLine:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT")

    function bar:UpdateBorderColor()
        local r, g, b, a
        if ConfigManager.config.useClassColor then
            local _, class = UnitClass("player")
            local classColor = RAID_CLASS_COLORS[class]
            r, g, b = classColor.r, classColor.g, classColor.b
            a = ConfigManager.config.borderColor[4] or 1
        else
            r, g, b, a = unpack(ConfigManager.config.borderColor)
        end

        self.topLine:SetColorTexture(r, g, b, a)
        self.bottomLine:SetColorTexture(r, g, b, a)
        
        self.topLine:SetShown(ConfigManager.config.showTopLine)
        self.bottomLine:SetShown(ConfigManager.config.showBottomLine)
    end

    function bar:UpdateLayout()
        local spacing = ConfigManager.config.spacing
        local currentX = spacing
        local totalWidth = spacing
        
        for _, module in ipairs(self.modules) do
            totalWidth = totalWidth + module:GetWidth() + spacing
        end
        
        self:SetWidth(totalWidth)
        backgroundFrame:SetWidth(totalWidth)
        
        for _, module in ipairs(self.modules) do
            module:ClearAllPoints()
            module:SetPoint("LEFT", self, "LEFT", currentX, 0)
            currentX = currentX + module:GetWidth() + spacing
        end
    end
    
    function bar:AddModule(module)
        table.insert(self.modules, module)
        self:UpdateLayout()
        return module
    end

    bar:UpdateBorderColor()

    bar:SetScript("OnMouseDown", function(self)
        if not ConfigManager.config.lock then
            self:StartMoving()
        end
    end)

    bar:SetScript("OnMouseUp", function(self)
        self:StopMovingOrSizing()
        if not ConfigManager.config.lock then
            ConfigManager.config.position.point, _, 
            ConfigManager.config.position.relativePoint, 
            ConfigManager.config.position.x, 
            ConfigManager.config.position.y = self:GetPoint()
            ConfigManager:SaveToFile(true)
        end
    end)

    bar:EnableMouse(not ConfigManager.config.lock)

    local alphaSlider = _G["FuxBar设置$parentAlpha"]
    if alphaSlider then
        alphaSlider:SetScript("OnValueChanged", function(self, value)
            value = math.floor(value)
            ConfigManager.config.backgroundAlpha = value / 100
            backgroundFrame:SetAlpha(ConfigManager.config.visible and ConfigManager.config.backgroundAlpha or 0)
            self.Text:SetText(string.format("背景透明度：%d%%", value))
            ConfigManager:SaveToFile()
        end)
    end

    return bar
end

function addon.CreateConfigPanel()
    local panel = CreateFrame("Frame")
    panel.name = "FuxBar设置"
    panel:SetSize(600, 350)
    local leftXOffset = 20
    local rightXOffset = 320
    local yOffset = -30

    local visibleCheck = CreateFrame("CheckButton", "$parentVisible", panel, "UICheckButtonTemplate")
    visibleCheck:SetPoint("TOPLEFT", leftXOffset, yOffset)
    visibleCheck.Text:SetText("微型菜单条开关")
    visibleCheck:SetChecked(ConfigManager.config.visible)
    visibleCheck:SetScript("OnClick", function(self)
        local checked = self:GetChecked()
        ConfigManager.config.visible = checked
        local fuxBar = _G["FuxBar"]
        if fuxBar then
            fuxBar:SetShown(checked) 
        end
        ConfigManager:SaveToFile()
    end)
    yOffset = yOffset - 40

    local lockButton = CreateFrame("CheckButton", "$parentLock", panel, "UICheckButtonTemplate")
    lockButton:SetPoint("TOPLEFT", leftXOffset, yOffset)
    lockButton.Text:SetText("移动位置开关（解锁后可拖动）")
    lockButton:SetChecked(ConfigManager.config.lock)
    lockButton:SetScript("OnClick", function(self)
        local checked = self:GetChecked()
        ConfigManager.config.lock = checked
        local fuxBar = _G["FuxBar"]
        if fuxBar then
            fuxBar:EnableMouse(not checked)
        end
        ConfigManager:SaveToFile()
    end)
    yOffset = yOffset - 60

    local scaleSlider = CreateFrame("Slider", "$parentScale", panel, "OptionsSliderTemplate")
    scaleSlider:SetPoint("TOPLEFT", leftXOffset, yOffset)
    scaleSlider:SetMinMaxValues(0.5, 2)
    scaleSlider:SetValueStep(0.05)
    scaleSlider:SetValue(ConfigManager.config.scale)
    scaleSlider.Text:SetText(string.format("整体缩放：%.2f", ConfigManager.config.scale))
    scaleSlider.Low:SetText("0.5")
    scaleSlider.High:SetText("2")
    scaleSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value * 20) / 20
        ConfigManager.config.scale = value
        self.Text:SetText(string.format("整体缩放：%.2f", value))
        local fuxBar = _G["FuxBar"]
        if fuxBar then
            fuxBar:SetScale(value)
        end
        ConfigManager:SaveToFile()
    end)
    yOffset = yOffset - 60

    local spacingSlider = CreateFrame("Slider", "$parentSpacing", panel, "OptionsSliderTemplate")
    spacingSlider:SetPoint("TOPLEFT", leftXOffset, yOffset)
    spacingSlider:SetMinMaxValues(0, 20)
    spacingSlider:SetValueStep(1)
    spacingSlider:SetValue(ConfigManager.config.spacing)
    spacingSlider.Text:SetText("按钮间距："..ConfigManager.config.spacing)
    spacingSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value)
        ConfigManager.config.spacing = value
        self.Text:SetText("按钮间距："..value)
        local fuxBar = _G["FuxBar"]
        if fuxBar and fuxBar.UpdateLayout then
            fuxBar:UpdateLayout()
        end
        ConfigManager:SaveToFile()
    end)
    yOffset = yOffset - 60

    local alphaSlider = CreateFrame("Slider", "$parentAlpha", panel, "OptionsSliderTemplate")
    alphaSlider:SetPoint("TOPLEFT", leftXOffset, yOffset)
    alphaSlider:SetMinMaxValues(0, 100)
    alphaSlider:SetValueStep(1)
    alphaSlider:SetValue(ConfigManager.config.backgroundAlpha * 100)
    alphaSlider.Text:SetText(string.format("背景透明度：%d%%", ConfigManager.config.backgroundAlpha * 100))
    alphaSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value)
        ConfigManager.config.backgroundAlpha = value / 100
        local fuxBar = _G["FuxBar"]
        if fuxBar then
            local backgroundFrame = fuxBar:GetChildren()
            backgroundFrame:SetAlpha(ConfigManager.config.visible and ConfigManager.config.backgroundAlpha or 0)
        end
        self.Text:SetText(string.format("背景透明度：%d%%", value))
        ConfigManager:SaveToFile()
    end)
    yOffset = yOffset - 40

    local talentAnimationCheck = CreateFrame("CheckButton", "$parentTalentAnimation", panel, "UICheckButtonTemplate")
    talentAnimationCheck:SetPoint("TOPLEFT", leftXOffset, yOffset)
    talentAnimationCheck.Text:SetText("悬停动画开关")
    talentAnimationCheck:SetChecked(FuxPanel_EnableScaleAnimation)

    local hoverHighlightCheck = CreateFrame("CheckButton", "$parentHoverHighlight", panel, "UICheckButtonTemplate")
    hoverHighlightCheck:SetPoint("TOPLEFT", leftXOffset, yOffset - 40)
    hoverHighlightCheck.Text:SetText("鼠标悬停高亮")
    hoverHighlightCheck:SetChecked(FuxPanel_EnableHighlightEffect)

    talentAnimationCheck:SetScript("OnClick", function(self)
        local checked = self:GetChecked()
        
        if checked then
            FuxPanel_EnableScaleAnimation = true
            FuxPanel_EnableHighlightEffect = false
            if hoverHighlightCheck then
                hoverHighlightCheck:SetChecked(false)
            end
        else
            FuxPanel_EnableScaleAnimation = false
        end
        
        local function UpdateAllButtonHighlightStates() end
        UpdateAllButtonHighlightStates()
        ConfigManager:SaveToFile()
    end)
    yOffset = yOffset - 40


    hoverHighlightCheck:SetScript("OnClick", function(self)
        local checked = self:GetChecked()
        
        if checked then
            FuxPanel_EnableHighlightEffect = true
            FuxPanel_EnableScaleAnimation = false
            talentAnimationCheck:SetChecked(false)
        else
            FuxPanel_EnableHighlightEffect = false
        end
        
        local function UpdateAllButtonHighlightStates() end
        UpdateAllButtonHighlightStates()
        ConfigManager:SaveToFile()
    end)

    yOffset = -30

    local showTopLineCheck = CreateFrame("CheckButton", "$parentShowTopLine", panel, "UICheckButtonTemplate")
    showTopLineCheck:SetPoint("TOPLEFT", rightXOffset, yOffset)
    showTopLineCheck.Text:SetText("显示顶部装饰线条")
    showTopLineCheck:SetChecked(ConfigManager.config.showTopLine)
    showTopLineCheck:SetScript("OnClick", function(self)
        local checked = self:GetChecked()
        ConfigManager.config.showTopLine = checked
        local fuxBar = _G["FuxBar"]
        if fuxBar and fuxBar.topLine then
            fuxBar.topLine:SetShown(checked)
        end
        ConfigManager:SaveToFile()
    end)
    yOffset = yOffset - 40

    local showBottomLineCheck = CreateFrame("CheckButton", "$parentShowBottomLine", panel, "UICheckButtonTemplate")
    showBottomLineCheck:SetPoint("TOPLEFT", rightXOffset, yOffset)
    showBottomLineCheck.Text:SetText("显示底部装饰线条")
    showBottomLineCheck:SetChecked(ConfigManager.config.showBottomLine)
    showBottomLineCheck:SetScript("OnClick", function(self)
        local checked = self:GetChecked()
        ConfigManager.config.showBottomLine = checked
        local fuxBar = _G["FuxBar"]
        if fuxBar and fuxBar.bottomLine then
            fuxBar.bottomLine:SetShown(checked)
        end
        ConfigManager:SaveToFile()
    end)
    yOffset = yOffset - 40

    local useClassColorCheck = CreateFrame("CheckButton", "$parentUseClassColor", panel, "UICheckButtonTemplate")
    useClassColorCheck:SetPoint("TOPLEFT", rightXOffset, yOffset)
    useClassColorCheck.Text:SetText("线条使用职业颜色")
    useClassColorCheck:SetChecked(ConfigManager.config.useClassColor)

    local borderColorPicker = CreateFrame("Button", "$parentBorderColor", panel, "UIPanelButtonTemplate")
    borderColorPicker:SetPoint("TOPLEFT", rightXOffset, yOffset - 40)
    borderColorPicker:SetSize(120, 25)
    borderColorPicker:SetText("线条颜色自定义")
    borderColorPicker:SetScript("OnClick", function()
        local originalColor = {unpack(ConfigManager.config.borderColor)}
        
        ColorPickerFrame:SetColorRGB(unpack(ConfigManager.config.borderColor))
        ColorPickerFrame.hasOpacity = true
        ColorPickerFrame.opacity = ConfigManager.config.borderColor[4]

        ColorPickerFrame.func = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            local a = OpacitySliderFrame:GetValue()
            a = 1.0 - a

            ConfigManager.config.borderColor = {r, g, b, a}
            local fuxBar = _G["FuxBar"]
            if fuxBar and fuxBar.UpdateBorderColor then
                fuxBar:UpdateBorderColor()
            end
            ConfigManager:SaveToFile()
        end

        ColorPickerFrame.opacityFunc = ColorPickerFrame.func
        ColorPickerFrame.cancelFunc = function()
            ConfigManager.config.borderColor = originalColor
            local fuxBar = _G["FuxBar"]
            if fuxBar and fuxBar.UpdateBorderColor then
                fuxBar:UpdateBorderColor()
            end
        end

        ColorPickerFrame:Show()
    end)

    useClassColorCheck:SetScript("OnClick", function(self)
        local checked = self:GetChecked()
        ConfigManager.config.useClassColor = checked
        local fuxBar = _G["FuxBar"]
        if fuxBar and fuxBar.UpdateBorderColor then
            fuxBar:UpdateBorderColor()
        end
        if borderColorPicker then
            borderColorPicker:SetEnabled(not checked)
        end
        ConfigManager:SaveToFile()
    end)
    yOffset = yOffset - 80

    local borderThicknessSlider = CreateFrame("Slider", "$parentBorderThickness", panel, "OptionsSliderTemplate")
    borderThicknessSlider:SetPoint("TOPLEFT", rightXOffset, yOffset - 30)
    borderThicknessSlider:SetMinMaxValues(1, 6)
    borderThicknessSlider:SetValueStep(1)
    borderThicknessSlider:SetValue(ConfigManager.config.borderThickness)
    borderThicknessSlider.Text:SetText("边框线条粗细："..ConfigManager.config.borderThickness)
    borderThicknessSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value)
        ConfigManager.config.borderThickness = value
        self.Text:SetText("边框线条粗细："..value)
        local fuxBar = _G["FuxBar"]
        if fuxBar then
            fuxBar.topLine:SetHeight(value)
            fuxBar.bottomLine:SetHeight(value)
        end
        ConfigManager:SaveToFile()
    end)

    -- 添加快速位置设置按钮
    local positionTitle = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    positionTitle:SetPoint("TOPLEFT", rightXOffset, yOffset - 80)
    positionTitle:SetText("快速位置设置")

    local function CreatePositionButton(text, point, x, y, offsetX, offsetY)
        local button = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
        button:SetSize(100, 25)
        button:SetPoint("TOPLEFT", rightXOffset + offsetX, yOffset - 110 + offsetY)
        button:SetText(text)
        button:SetScript("OnClick", function()
            local fuxBar = _G["FuxBar"]
            if fuxBar then
                ConfigManager.config.position.point = point
                ConfigManager.config.position.relativePoint = point
                ConfigManager.config.position.x = x
                ConfigManager.config.position.y = y
                
                fuxBar:ClearAllPoints()
                fuxBar:SetPoint(point, UIParent, point, x, y)
                ConfigManager:SaveToFile()
            end
        end)
    end

    CreatePositionButton("顶部居中", "TOP", 0, 0, 0, 0)
    CreatePositionButton("底部居中", "BOTTOM", 0, 0, 110, 0)

    local helpText = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    helpText:SetPoint("BOTTOMLEFT", 20, 20)
    helpText:SetPoint("BOTTOMRIGHT", -20, 20)
    helpText:SetJustifyH("LEFT")
    helpText:SetText("设置将自动保存 - |r|cffFF7F00蓝|r|r|cffFF7F00雨|r|r|cffFF7F00秋|r|r|cffFF7F00夜|r")

    return panel
end

function addon.AddModule(bar, moduleName, createFunc)
    if not bar or not createFunc then return nil end
    local module = createFunc(bar)
    if module then
        bar:AddModule(module)
    end
    return module
end

local initialized = false
function addon.Initialize()
    if initialized then return end
    
    ConfigManager.dbName = addon.DB_NAME or "FuxBarDB"
    addon.config = ConfigManager:Init()
    
    local fuxBar = addon.CreateFuxBar()
    
    local panel = addon.CreateConfigPanel()
    if InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(panel)
    else
        local category, layout = Settings.RegisterCanvasLayoutCategory(panel, panel.name);
        Settings.RegisterAddOnCategory(category);
    end
    
    StaticPopupDialogs["FUXBAR_CONFIRM_RESET"] = {
        text = "确定要重置所有配置为默认值吗？此操作不可恢复。",
        button1 = "确定",
        button2 = "取消",
        OnAccept = function()
            _G[ConfigManager.dbName][ConfigManager.configKey] = ConfigManager:ShallowCopy(defaults)
            addon.config = ConfigManager:Init()
            
            if fuxBar then
                fuxBar:SetScale(ConfigManager.config.scale)
                local backgroundFrame = fuxBar:GetChildren()
                backgroundFrame:SetAlpha(ConfigManager.config.visible and ConfigManager.config.backgroundAlpha or 0)
                fuxBar:UpdateBorderColor()
                
                fuxBar:ClearAllPoints()
                fuxBar:SetPoint(
                    ConfigManager.config.position.point,
                    UIParent,
                    ConfigManager.config.position.relativePoint,
                    ConfigManager.config.position.x,
                    ConfigManager.config.position.y
                )
                fuxBar.topLine:SetHeight(ConfigManager.config.borderThickness)
                fuxBar.bottomLine:SetHeight(ConfigManager.config.borderThickness)
            end
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    
    SLASH_FUXBAR1 = "/fuxbar"
    SlashCmdList["FUXBAR"] = function(msg)
        if msg:lower() == "reload" then
            if ConfigManager:SaveToFile(true) then
                ReloadUI()
            end
        elseif msg:lower() == "reset" then
            StaticPopup_Show("FUXBAR_CONFIRM_RESET")
        elseif msg:lower() == "config" or msg == "" then
            InterfaceOptionsFrame_OpenToCategory("FuxBar设置")
            InterfaceOptionsFrame_OpenToCategory("FuxBar设置")
        end
    end
    
    C_Timer.After(1, function()
        if CreateCharacterPanel then
            addon.AddModule(fuxBar, "角色面板", CreateCharacterPanel)
        end
        
        if CreateSpellbookPanel then
            addon.AddModule(fuxBar, "法术书", CreateSpellbookPanel)
        end
        
        if CreateTalentPanel then
            addon.AddModule(fuxBar, "天赋", CreateTalentPanel)
        end
        
        if CreateAchievementPanel then
            addon.AddModule(fuxBar, "成就", CreateAchievementPanel)
        end
        
        if CreateDailyBar then
            addon.AddModule(fuxBar, "Daily", CreateDailyBar)
        end
        
        if CreateGuildPanel then
            addon.AddModule(fuxBar, "Guild", CreateGuildPanel)
        end

        if CreateTimePanel and ConfigManager.config.showTimeModule then
            addon.AddModule(fuxBar, "Time", CreateTimePanel)
        end
        
        if CreatePVEPanel then
            addon.AddModule(fuxBar, "PVE", CreatePVEPanel)
        end
        
        if CreateMountPanel then
            addon.AddModule(fuxBar, "Mount", CreateMountPanel)
        end
        
        if CreatePVPPanel then
            addon.AddModule(fuxBar, "PVP", CreatePVPPanel)
        end
        
        if CreateDurabilityPanel then
            addon.AddModule(fuxBar, "Dura", CreateDurabilityPanel)
        end
        
        if CreateBagPanel then
            addon.AddModule(fuxBar, "Bag", CreateBagPanel)
        end
        
        if CreatePositionPanel then
            addon.AddModule(fuxBar, "Menu", CreatePositionPanel)
        end		
    end)
    
    initialized = true
end

F:RegisterEvent("PLAYER_LOGIN")
F:RegisterEvent("PLAYER_LOGOUT")
F:RegisterEvent("PLAYER_LEAVING_WORLD")
F:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        C_Timer.After(0.1, function()
            addon.Initialize()
        end)
    elseif event == "PLAYER_LOGOUT" or event == "PLAYER_LEAVING_WORLD" then
        if initialized then
            ConfigManager:SaveToFile(true)
        end
    end
end)
-- MainBar.lua
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
        point = "CENTER",
        relativeTo = "UIParent",
        relativePoint = "CENTER",
        x = 0,
        y = 0
    },

    configWindowPos = {
        point = "CENTER",
        relativeTo = "UIParent",
        relativePoint = "CENTER",
        x = 0,
        y = 0
    },
    showTopLine = true,  
    showBottomLine = true, 
    showTimeModule = true, 
    backgroundAlpha = 0.8,
    borderThickness = 1,    
    frameWidth = 550, 
    borderScale = 1.0, 
    backgroundTexture = "Interface\\AddOns\\MicroMenuBar\\Media\\ClassIcon\\bj.tga", 
    timeFontSize = 18,
    timeFontType = 2
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
    
    if self.config.backgroundWidth then
        self.config.frameWidth = self.config.backgroundWidth
        self.config.backgroundWidth = nil
    end
    
    if not self.config.borderScale then
        self.config.borderScale = self.config.borderLength or 1.0
        self.config.borderLength = nil
    end
    
    if not self.config.backgroundTexture then
        self.config.backgroundTexture = defaults.backgroundTexture
    end
    
    if not self.config.timeFontSize then
        self.config.timeFontSize = defaults.timeFontSize
    end
    if not self.config.timeFontType then
        self.config.timeFontType = defaults.timeFontType
    end
    
    if not self.config.configWindowPos then
        self.config.configWindowPos = defaults.configWindowPos
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

function addon.CreateFuxBar()
    local bar = CreateFrame("Frame", "FuxBar", UIParent)
    bar:SetMovable(true)
    bar:SetUserPlaced(true)
    bar:SetClampedToScreen(true)
    bar:SetFrameStrata("BACKGROUND")
    bar.modules = {}
    
    bar:SetSize(ConfigManager.config.frameWidth, 40)
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
    
    local function SetupBackgroundTexture()
        if ConfigManager.config.backgroundTexture == "" then
            backgroundFrame:SetBackdrop({
                bgFile = nil,
                edgeFile = nil,
            })
            backgroundFrame:SetBackdropColor(0, 0, 0, 0)
        else
            backgroundFrame:SetBackdrop({
                bgFile = ConfigManager.config.backgroundTexture,
                edgeFile = nil,
            })
            backgroundFrame:SetBackdropColor(1, 1, 1, ConfigManager.config.backgroundAlpha)
        end
    end
    
    SetupBackgroundTexture()
    backgroundFrame:SetAlpha(ConfigManager.config.visible and ConfigManager.config.backgroundAlpha or 0)
    bar.backgroundFrame = backgroundFrame 

    bar.topLine = bar:CreateTexture(nil, "ARTWORK")
    bar.topLine:SetHeight(ConfigManager.config.borderThickness)
    
    bar.bottomLine = bar:CreateTexture(nil, "ARTWORK")
    bar.bottomLine:SetHeight(ConfigManager.config.borderThickness)
    
    function bar:UpdateBorderPositions()
        local centerOffset = bar:GetWidth() / 2
        local halfLength = bar:GetWidth() * ConfigManager.config.borderScale / 2
        
        bar.topLine:ClearAllPoints()
        bar.topLine:SetPoint("TOPLEFT", bar, "TOP", -halfLength, 0)
        bar.topLine:SetPoint("TOPRIGHT", bar, "TOP", halfLength, 0)
        
        bar.bottomLine:ClearAllPoints()
        bar.bottomLine:SetPoint("BOTTOMLEFT", bar, "BOTTOM", -halfLength, 0)
        bar.bottomLine:SetPoint("BOTTOMRIGHT", bar, "BOTTOM", halfLength, 0)
    end

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
        
        local buttonTotalWidth = 0
        for _, module in ipairs(self.modules) do
            buttonTotalWidth = buttonTotalWidth + module:GetWidth() + spacing
        end
        buttonTotalWidth = buttonTotalWidth - spacing 
        
        currentX = (self:GetWidth() - buttonTotalWidth) / 2
        
        for _, module in ipairs(self.modules) do
            module:ClearAllPoints()
            module:SetPoint("LEFT", self, "LEFT", currentX, 0)
            currentX = currentX + module:GetWidth() + spacing
        end

        self:UpdateBorderPositions()
    end
    
    function bar:AddModule(module)
        table.insert(self.modules, module)
        self:UpdateLayout()
        return module
    end

    bar:UpdateBorderPositions()
    bar:UpdateBorderColor()

    local configButton = CreateFrame("Button", nil, bar)
    bar.configButton = configButton  
    configButton:SetSize(18, 18)
    configButton:SetPoint("TOPRIGHT", 10, 6)
    configButton:SetNormalTexture("Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\lockPosition.tga")
    configButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
    
    configButton:SetShown(not ConfigManager.config.lock)

    configButton:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not ConfigManager.config.lock then
            bar:StartMoving()
        end
    end)

    configButton:SetScript("OnMouseUp", function(self, button)
        bar:StopMovingOrSizing()
        
        if button == "LeftButton" and not ConfigManager.config.lock then
            ConfigManager.config.position.point, _, 
            ConfigManager.config.position.relativePoint, 
            ConfigManager.config.position.x, 
            ConfigManager.config.position.y = bar:GetPoint()
            ConfigManager:SaveToFile(true)
        end
    end)

    return bar
end

local configWindow
function addon.CreateConfigWindow()
    configWindow = CreateFrame("Frame", "FuxBarConfigWindow", UIParent, "BackdropTemplate")
    configWindow:SetSize(1000, 450)
    
    local pos = ConfigManager.config.configWindowPos
    local relativeTo = pos.relativeTo and _G[pos.relativeTo] or UIParent
    configWindow:ClearAllPoints()
    configWindow:SetPoint(pos.point, relativeTo, pos.relativePoint, pos.x, pos.y)
    
    configWindow:SetFrameStrata("FULLSCREEN_DIALOG")
    configWindow:SetFrameLevel(10)
    
    configWindow:SetMovable(true)
    configWindow:EnableMouse(true)
    configWindow:SetClampedToScreen(true)
    
    configWindow.bgTex = configWindow:CreateTexture(nil, "BACKGROUND", nil, -8)
    configWindow.bgTex:SetAllPoints(configWindow)
    configWindow.bgTex:SetTexture("Interface\\AddOns\\MicroMenuBar\\Media\\ClassIcon\\TalentsClassBackgroundMonk1.png")
    configWindow.bgTex:SetTexCoord(0, 1, 0, 1)
    configWindow.bgTex:SetAlpha(0.8)
    
    configWindow:SetBackdrop({
        bgFile = nil,
        edgeFile = nil,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    
    configWindow:Hide() 
    
    local titleText = configWindow:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    titleText:SetPoint("TOP", 0, -8)
    titleText:SetText("Micro 选项面板")
    titleText:SetTextColor(1, 0.82, 0)

    local closeButton = CreateFrame("Button", nil, configWindow, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", -8, -8)
    closeButton:SetScript("OnClick", function()
        configWindow:Hide()
    end)

    configWindow:RegisterForDrag("LeftButton")
    configWindow:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    
    configWindow:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, rt, rpoint, x, y = self:GetPoint()
        ConfigManager.config.configWindowPos = {
            point = point,
            relativeTo = rt and (rt:GetName() or "UIParent") or "UIParent",
            relativePoint = rpoint,
            x = x,
            y = y
        }
        ConfigManager:SaveToFile()
    end)

    local leftMargin = 110        
    local rightMargin = 50       
    local columnSpacing = 110     
    local topMargin = 50         
    
    local windowTotalWidth = configWindow:GetWidth()
    local availableWidth = windowTotalWidth - leftMargin - rightMargin
    local columnWidth = (availableWidth - (columnSpacing * 2)) / 3  
    
    local leftXOffset = leftMargin
    local middleXOffset = leftXOffset + columnWidth + columnSpacing
    local rightXOffset = middleXOffset + columnWidth + columnSpacing
    local yOffset = -topMargin

    local leftGroup = CreateFrame("Frame", nil, configWindow)
    leftGroup:SetPoint("TOPLEFT", leftXOffset, yOffset)
    leftGroup:SetSize(columnWidth, 400)
    
    local middleGroup = CreateFrame("Frame", nil, configWindow)
    middleGroup:SetPoint("TOPLEFT", middleXOffset, yOffset)
    middleGroup:SetSize(columnWidth, 400)
    
    local rightGroup = CreateFrame("Frame", nil, configWindow)
    rightGroup:SetPoint("TOPLEFT", rightXOffset, yOffset)
    rightGroup:SetSize(columnWidth, 400)

    local visibleCheck = CreateFrame("CheckButton", "$parentVisible", leftGroup, "UICheckButtonTemplate")
    visibleCheck:SetPoint("TOPLEFT", 0, 0)
    visibleCheck.Text:SetText("微型菜单条开关")
    visibleCheck:SetChecked(ConfigManager.config.visible)
    visibleCheck:SetScript("OnClick", function(self)
        ConfigManager.config.visible = self:GetChecked()
        local fuxBar = _G["FuxBar"]
        if fuxBar then
            fuxBar:SetShown(ConfigManager.config.visible)
        end
        ConfigManager:SaveToFile()
    end)

    local lockButton = CreateFrame("CheckButton", "$parentLock", leftGroup, "UICheckButtonTemplate")
    lockButton:SetPoint("TOPLEFT", 0, -40)
    lockButton.Text:SetText("移动位置开关（解锁后长按小锁可拖动）")
    lockButton:SetChecked(ConfigManager.config.lock)
    lockButton:SetScript("OnClick", function(self)
        ConfigManager.config.lock = self:GetChecked()
        local fuxBar = _G["FuxBar"]
        if fuxBar then
            fuxBar:EnableMouse(not ConfigManager.config.lock)
            if fuxBar.configButton then
                fuxBar.configButton:SetShown(not ConfigManager.config.lock)
            end
        end
        ConfigManager:SaveToFile()
    end)

    local scaleSlider = CreateFrame("Slider", "$parentScale", leftGroup, "OptionsSliderTemplate")
    scaleSlider:SetPoint("TOPLEFT", 0, -100)
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

    local spacingSlider = CreateFrame("Slider", "$parentSpacing", leftGroup, "OptionsSliderTemplate")
    spacingSlider:SetPoint("TOPLEFT", 0, -150)
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

    local alphaSlider = CreateFrame("Slider", "$parentAlpha", leftGroup, "OptionsSliderTemplate")
    alphaSlider:SetPoint("TOPLEFT", 0, -200)
    alphaSlider:SetMinMaxValues(0, 100)
    alphaSlider:SetValueStep(1)
    alphaSlider:SetValue(ConfigManager.config.backgroundAlpha * 100)
    alphaSlider.Text:SetText(string.format("背景透明度：%d%%", ConfigManager.config.backgroundAlpha * 100))
    alphaSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value)
        ConfigManager.config.backgroundAlpha = value / 100
        local fuxBar = _G["FuxBar"]
        if fuxBar and fuxBar.backgroundFrame then
            fuxBar.backgroundFrame:SetAlpha(ConfigManager.config.visible and ConfigManager.config.backgroundAlpha or 0)
        end
        self.Text:SetText(string.format("背景透明度：%d%%", value))
        ConfigManager:SaveToFile()
    end)

    local animationGroup = CreateFrame("Frame", nil, leftGroup)
    animationGroup:SetPoint("TOPLEFT", 0, -260)
    animationGroup:SetSize(columnWidth, 100)

    local animationTitle = animationGroup:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    animationTitle:SetPoint("TOPLEFT", 0, 0)
    animationTitle:SetText("动画效果")

    local talentAnimationCheck = CreateFrame("CheckButton", "$parentTalentAnimation", animationGroup, "UICheckButtonTemplate")
    talentAnimationCheck:SetPoint("TOPLEFT", 0, -20)
    talentAnimationCheck.Text:SetText("悬停缩放动画")
    talentAnimationCheck:SetChecked(FuxPanel_EnableScaleAnimation)

    local hoverHighlightCheck = CreateFrame("CheckButton", "$parentHoverHighlight", animationGroup, "UICheckButtonTemplate")
    hoverHighlightCheck:SetPoint("TOPLEFT", 0, -50)
    hoverHighlightCheck.Text:SetText("鼠标悬停高亮")
    hoverHighlightCheck:SetChecked(FuxPanel_EnableHighlightEffect)

    talentAnimationCheck:SetScript("OnClick", function(self)
        FuxPanel_EnableScaleAnimation = self:GetChecked()
        FuxPanel_EnableHighlightEffect = not self:GetChecked()
        if hoverHighlightCheck then
            hoverHighlightCheck:SetChecked(false)
        end
        ConfigManager:SaveToFile()
    end)

    hoverHighlightCheck:SetScript("OnClick", function(self)
        FuxPanel_EnableHighlightEffect = self:GetChecked()
        FuxPanel_EnableScaleAnimation = not self:GetChecked()
        if talentAnimationCheck then
            talentAnimationCheck:SetChecked(false)
        end
        ConfigManager:SaveToFile()
    end)

    local showTopLineCheck = CreateFrame("CheckButton", "$parentShowTopLine", middleGroup, "UICheckButtonTemplate")
    showTopLineCheck:SetPoint("TOPLEFT", 0, 0)
    showTopLineCheck.Text:SetText("显示顶部装饰线条")
    showTopLineCheck:SetChecked(ConfigManager.config.showTopLine)
    showTopLineCheck:SetScript("OnClick", function(self)
        ConfigManager.config.showTopLine = self:GetChecked()
        local fuxBar = _G["FuxBar"]
        if fuxBar and fuxBar.topLine then
            fuxBar.topLine:SetShown(ConfigManager.config.showTopLine)
        end
        ConfigManager:SaveToFile()
    end)

    local showBottomLineCheck = CreateFrame("CheckButton", "$parentShowBottomLine", middleGroup, "UICheckButtonTemplate")
    showBottomLineCheck:SetPoint("TOPLEFT", 0, -40)
    showBottomLineCheck.Text:SetText("显示底部装饰线条")
    showBottomLineCheck:SetChecked(ConfigManager.config.showBottomLine)
    showBottomLineCheck:SetScript("OnClick", function(self)
        ConfigManager.config.showBottomLine = self:GetChecked()
        local fuxBar = _G["FuxBar"]
        if fuxBar and fuxBar.bottomLine then
            fuxBar.bottomLine:SetShown(ConfigManager.config.showBottomLine)
        end
        ConfigManager:SaveToFile()
    end)

    local useClassColorCheck = CreateFrame("CheckButton", "$parentUseClassColor", middleGroup, "UICheckButtonTemplate")
    useClassColorCheck:SetPoint("TOPLEFT", 0, -80)
    useClassColorCheck.Text:SetText("线条使用职业颜色")
    useClassColorCheck:SetChecked(ConfigManager.config.useClassColor)

    local borderColorPicker = CreateFrame("Button", "$parentBorderColor", middleGroup, "UIPanelButtonTemplate")
    borderColorPicker:SetPoint("TOPLEFT", 0, -110)
    borderColorPicker:SetSize(120, 25)
    borderColorPicker:SetText("线条颜色自定义")
    borderColorPicker:SetEnabled(not ConfigManager.config.useClassColor)
    borderColorPicker:SetScript("OnClick", function()
        local originalColor = {unpack(ConfigManager.config.borderColor)}
        ColorPickerFrame:SetColorRGB(unpack(ConfigManager.config.borderColor))
        ColorPickerFrame.hasOpacity = true
        ColorPickerFrame.opacity = 1 - ConfigManager.config.borderColor[4]
        ColorPickerFrame.func = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            local a = 1 - OpacitySliderFrame:GetValue()
            ConfigManager.config.borderColor = {r, g, b, a}
            local fuxBar = _G["FuxBar"]
            if fuxBar and fuxBar.UpdateBorderColor then
                fuxBar:UpdateBorderColor()
            end
            ConfigManager:SaveToFile()
        end
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
        ConfigManager.config.useClassColor = self:GetChecked()
        borderColorPicker:SetEnabled(not self:GetChecked())
        local fuxBar = _G["FuxBar"]
        if fuxBar and fuxBar.UpdateBorderColor then
            fuxBar:UpdateBorderColor()
        end
        ConfigManager:SaveToFile()
    end)

    local borderThicknessSlider = CreateFrame("Slider", "$parentBorderThickness", middleGroup, "OptionsSliderTemplate")
    borderThicknessSlider:SetPoint("TOPLEFT", 0, -160)
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

    local frameWidthSlider = CreateFrame("Slider", "$parentFrameWidth", middleGroup, "OptionsSliderTemplate")
    frameWidthSlider:SetPoint("TOPLEFT", 0, -220)
    frameWidthSlider:SetMinMaxValues(200, 550)
    frameWidthSlider:SetValueStep(10)
    frameWidthSlider:SetValue(ConfigManager.config.frameWidth)
    frameWidthSlider.Text:SetText("主框架宽度："..ConfigManager.config.frameWidth)
    frameWidthSlider.Low:SetText("200")
    frameWidthSlider.High:SetText("550")
    frameWidthSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value)
        ConfigManager.config.frameWidth = value
        self.Text:SetText("主框架宽度："..value)
        local fuxBar = _G["FuxBar"]
        if fuxBar then
            fuxBar:SetSize(value, fuxBar:GetHeight())
            fuxBar:UpdateLayout()
        end
        ConfigManager:SaveToFile()
    end)

    local textureOptions = {
        {name = "默认材质", value = "Interface\\AddOns\\MicroMenuBar\\Media\\ClassIcon\\bj.tga"},
        {name = "Blizzard", value = "Interface\\CHARACTERFRAME\\UI-Party-Background"},
        {name = "Details-条纹", value = "Interface\\AddOns\\MicroMenuBar\\Media\\ClassIcon\\overlay_indicator_1.blp"},
        {name = "Eltreum-Tapped", value = "Interface\\AddOns\\MicroMenuBar\\Media\\ClassIcon\\Eltreum-Tapped.tga"},
        {name = "Eltreum-Stripes", value = "Interface\\AddOns\\MenuBar\\Media\\ClassIcon\\Eltreum-Stripes.tga"},
        {name = "ElvUI-简约", value = "Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\NormTex"},
        {name = "透明背景", value = ""}  
    }
    
    local textureWidth = 180
    local texturePanelHeight = 140
    
    local textureDropdownContainer = CreateFrame("Frame", "FuxBarTextureDropdownContainer", rightGroup)
    textureDropdownContainer:SetPoint("TOPLEFT", 0, 0)
    textureDropdownContainer:SetSize(textureWidth, 25)
    
    local textureDropdown = CreateFrame("Button", "FuxBarTextureDropdown", textureDropdownContainer, "UIPanelButtonTemplate")
    textureDropdown:SetAllPoints(textureDropdownContainer)
    textureDropdown:SetText("选择背景材质")
    
    local textureSelectionPanel = CreateFrame("Frame", "FuxBarTextureSelectionPanel", rightGroup, "BackdropTemplate")
    textureSelectionPanel:SetPoint("TOPLEFT", textureDropdownContainer, "BOTTOMLEFT", 0, -5)
    textureSelectionPanel:SetSize(textureWidth, texturePanelHeight)
    textureSelectionPanel:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    textureSelectionPanel:SetBackdropColor(0, 0, 0, 1)
    textureSelectionPanel:Hide()
    
    local scrollFrame = CreateFrame("ScrollFrame", "FuxBarTextureScrollFrame", textureSelectionPanel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 10, -10)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 10)
    
    local contentHeight = #textureOptions * 25
    local scrollContent = CreateFrame("Frame", "FuxBarTextureScrollContent", scrollFrame)
    scrollContent:SetSize(textureWidth - 40, contentHeight)
    scrollFrame:SetScrollChild(scrollContent)
    
    local function CreateTextureOptionTexture(parent, option, index)
        local textureFrame = CreateFrame("Button", nil, parent, "BackdropTemplate")
        textureFrame:SetSize(textureWidth - 50, 20)
        textureFrame:SetPoint("TOPLEFT", 0, -((index-1) * 25))
        
        textureFrame:SetBackdrop({
            bgFile = option.value == "" and "Interface\\DialogFrame\\UI-DialogBox-Background" or option.value,
            edgeFile = nil,
            tile = true, tileSize = 16,
            insets = { left = 0, right = 0, top = 0, bottom = 0 }
        })
        
        textureFrame:SetScript("OnEnter", function(self)
            self:SetBackdropBorderColor(1, 0.82, 0)
        end)
        textureFrame:SetScript("OnLeave", function(self)
            self:SetBackdropBorderColor(1, 1, 1)
        end)
        textureFrame:SetScript("OnClick", function()
            ConfigManager.config.backgroundTexture = option.value
            local fuxBar = _G["FuxBar"]
            if fuxBar and fuxBar.backgroundFrame then
                if option.value == "" then
                    fuxBar.backgroundFrame:SetBackdrop({bgFile = nil, edgeFile = nil})
                    fuxBar.backgroundFrame:SetBackdropColor(0, 0, 0, 0)
                else
                    fuxBar.backgroundFrame:SetBackdrop({bgFile = option.value, edgeFile = nil})
                    fuxBar.backgroundFrame:SetBackdropColor(1, 1, 1, ConfigManager.config.backgroundAlpha)
                end
            end
            textureSelectionPanel:Hide()
            ConfigManager:SaveToFile()
        end)
        
        local nameText = textureFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        nameText:SetPoint("LEFT", 5, 0)
        nameText:SetText(option.name)
        nameText:SetTextColor(1, 1, 1)
        
        return textureFrame
    end
    
    for i, option in ipairs(textureOptions) do
        CreateTextureOptionTexture(scrollContent, option, i)
    end
    
    textureDropdown:SetScript("OnClick", function()
        textureSelectionPanel:SetShown(not textureSelectionPanel:IsShown())
    end)
    configWindow:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and textureSelectionPanel:IsShown() then
            if not textureSelectionPanel:IsMouseOver() and not textureDropdown:IsMouseOver() then
                textureSelectionPanel:Hide()
            end
        end
    end)

    local fontSettingsGroup = CreateFrame("Frame", nil, rightGroup)
    fontSettingsGroup:SetPoint("TOPLEFT", textureDropdownContainer, "BOTTOMLEFT", 0, -texturePanelHeight - 20)
    fontSettingsGroup:SetSize(textureWidth, 120)

    local fontTitle = fontSettingsGroup:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    fontTitle:SetPoint("TOPLEFT", 0, 10)
    fontTitle:SetText("时间模块字体设置项：")
	fontTitle:SetTextColor(1, 0.82, 0) 

    local fontSizeSlider = CreateFrame("Slider", "$parentFontSize", fontSettingsGroup, "OptionsSliderTemplate")
    fontSizeSlider:SetPoint("TOPLEFT", 0, -30)
    fontSizeSlider:SetMinMaxValues(16, 28)
    fontSizeSlider:SetValueStep(1)
    fontSizeSlider:SetValue(ConfigManager.config.timeFontSize)
    fontSizeSlider.Text:SetText("字体大小：" .. ConfigManager.config.timeFontSize)
    fontSizeSlider.Low:SetText("16")
    fontSizeSlider.High:SetText("28")
    fontSizeSlider:SetScript("OnValueChanged", function(self, value)
        value = math.floor(value)
        ConfigManager.config.timeFontSize = value
        self.Text:SetText("字体大小：" .. value)
        
        if _G.UpdateTimeModuleFont then
            _G.UpdateTimeModuleFont()
        end
        
        ConfigManager:SaveToFile()
    end)

    local fontTypeSlider = CreateFrame("Slider", "$parentFontType", fontSettingsGroup, "OptionsSliderTemplate")
    fontTypeSlider:SetPoint("TOPLEFT", 0, -80)
    fontTypeSlider:SetMinMaxValues(1, 3)
    fontTypeSlider:SetValueStep(1)
    fontTypeSlider:SetValue(ConfigManager.config.timeFontType)
    
    local fontTypeNames = {
        [1] = "聊天",
        [2] = "默认",
        [3] = "战斗"
    }
    
    fontTypeSlider.Text:SetText("字体类型：" .. fontTypeNames[ConfigManager.config.timeFontType])
    fontTypeSlider.Low:SetText("聊天")
    fontTypeSlider.High:SetText("战斗")
    
    fontTypeSlider:SetScript("OnValueChanged", function(self, value)
        local type = math.floor(value)
        ConfigManager.config.timeFontType = type
        self.Text:SetText("字体类型：" .. fontTypeNames[type])
        
        if _G.UpdateTimeModuleFont then
            _G.UpdateTimeModuleFont()
        end
        
        ConfigManager:SaveToFile()
    end)

    local helpText = configWindow:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    helpText:SetPoint("BOTTOMLEFT", 20, 20)
    helpText:SetPoint("BOTTOMRIGHT", -20, 20)
    helpText:SetJustifyH("LEFT")
    helpText:SetText("设置将自动保存 - |r|cffFF7F00蓝|r|r|cffFF7F00雨|r|r|cffFF7F00秋|r|r|cffFF7F00夜|r")

    local resetPositionButton = CreateFrame("Button", nil, configWindow, "UIPanelButtonTemplate")
    resetPositionButton:SetSize(120, 25)
    resetPositionButton:SetPoint("BOTTOMRIGHT", -20, 20)
    resetPositionButton:SetText("重置位置")
    resetPositionButton:SetScript("OnClick", function()
        local fuxBar = _G["FuxBar"]
        if fuxBar then
            ConfigManager.config.position = {
                point = "CENTER",
                relativeTo = "UIParent",
                relativePoint = "CENTER",
                x = 0,
                y = 0
            }
            fuxBar:ClearAllPoints()
            fuxBar:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
            ConfigManager:SaveToFile()
        end
    end)

    return configWindow
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
    
    local configWindow = addon.CreateConfigWindow()
    
    StaticPopupDialogs["FUXBAR_CONFIRM_RESET"] = {
        text = "确定要重置所有配置为默认值吗？此操作不可恢复。",
        button1 = "确定",
        button2 = "取消",
        OnAccept = function()
            _G[ConfigManager.dbName][ConfigManager.configKey] = ConfigManager:ShallowCopy(defaults)
            addon.config = ConfigManager:Init()
            
            if fuxBar then
                fuxBar:SetScale(ConfigManager.config.scale)
                local backgroundFrame = fuxBar.backgroundFrame
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
                fuxBar:UpdateBorderPositions()
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
            if configWindow:IsShown() then
                configWindow:Hide()
            else
                configWindow:Show()
            end
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
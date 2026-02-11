-- ========================================
-- Core/UILib.lua
-- RurutiaSuite UI 组件库（学习 Pig 插件）
-- ========================================
-- 职责：
-- 1. 提供统一的黑色半透明扁平风格 UI 组件
-- 2. 封装 CreateFrame、CreateButton 等常用方法
-- 3. 集中管理所有 UI 样式配置
-- 4. 不依赖 AceGUI，使用原生 CreateFrame
-- ========================================

local addonName, ns = ...
local UILib = {}
ns.UILib = UILib

-- 引用全局配置 (确保 Config.lua 已加载)
local CFG = _G.RURUTIA_SUITE_CONFIG

-- ========================================
-- 全局配置
-- ========================================

-- UILib.Defaults (New)
UILib.Defaults = {
    fontSize = 14,
    titleFontSize = 12,
    titleOffsetY = -5,
    buttonHeight = 22,
}

-- Backdrop 材质配置
UILib.bgFile = "Interface\\Tooltips\\UI-Tooltip-Background"
UILib.edgeFile = "Interface\\Tooltips\\UI-Tooltip-Background"
UILib.Backdropinfo = {
    bgFile = UILib.bgFile,
    edgeFile = UILib.edgeFile,
    tile = true, tileSize = 16, edgeSize = 1,
    insets = { left = 1, right = 1, top = 1, bottom = 1 }
}

-- 框体配置
UILib.FrameBGColor = {0, 0, 0, 0.8}
UILib.FrameBorderColor = {0, 0, 0, 0.3}

-- 按钮配置
UILib.ButtonBGColor = {0.1, 0.1, 0.1, 0.8}
UILib.ButtonBorderColor = {0, 0, 0, 1}
UILib.ButtonBorderColor_OnEnter = {0, 0.8, 1, 0.9}
UILib.ButtonBGColor_OnEnter = {0.2, 0.2, 0.2, 0.9}

-- 文字配置
UILib.TextColor = {1, 0.843, 0, 1}
UILib.TextColor_Disabled = {0.5, 0.5, 0.5, 1}
UILib.FontSize = 14
UILib.FontPath = "Fonts\\ARKai_T.ttf"

-- ========================================
-- 核心函数：应用窗口样式
-- ========================================
function UILib:ApplyWindowStyle(frameObj)
    if not frameObj then return end
    
    -- 设置背景边框
    frameObj:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        tile = true, tileSize = 16, edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    
    -- 从配置读取透明度
    local RS_CFG = ns.Config
    local bgAlpha = RS_CFG and RS_CFG.theme.background.a or 0.85
    frameObj:SetBackdropColor(0, 0, 0, bgAlpha)
    frameObj:SetBackdropBorderColor(0, 0, 0, 0.8)
end

-- ========================================
-- 辅助函数：获取职业色
-- ========================================
local function GetClassColor()
    local _, class = UnitClass("player")
    local classColor = RAID_CLASS_COLORS and RAID_CLASS_COLORS[class]
    if classColor then
        return string.format("|cFF%02x%02x%02x", classColor.r * 255, classColor.g * 255, classColor.b * 255)
    end
    return "|cFFFFD700"
end
UILib.GetClassColor = GetClassColor

-- ========================================
-- 核心函数：创建框体
-- ========================================
function UILib:CreateFrame(parent, point, size, name)
    local frame = CreateFrame("Frame", name, parent, "BackdropTemplate")
    
    if size then frame:SetSize(size[1], size[2]) end
    
    if point then
        if type(point[1]) == "table" then
            for _, p in ipairs(point) do
                frame:SetPoint(p[1], p[2] or parent, p[3] or p[1], p[4] or 0, p[5] or 0)
            end
        else
            frame:SetPoint(point[1], point[2] or parent, point[3] or point[1], point[4] or 0, point[5] or 0)
        end
    end
    
    frame:SetBackdrop(UILib.Backdropinfo)
    frame:SetBackdropColor(unpack(UILib.FrameBGColor))
    frame:SetBackdropBorderColor(unpack(UILib.FrameBorderColor))
    
    function frame:SetBGAlpha(alpha)
        self:SetBackdropColor(UILib.FrameBGColor[1], UILib.FrameBGColor[2], UILib.FrameBGColor[3], alpha)
    end
    
    function frame:SetBorderAlpha(alpha)
        self:SetBackdropBorderColor(UILib.FrameBorderColor[1], UILib.FrameBorderColor[2], UILib.FrameBorderColor[3], alpha)
    end
    
    return frame
end

-- ========================================
-- 核心函数：创建按钮 (原生)
-- ========================================
function UILib:CreateNativeButton(parent, point, size, text, name)
    local button = CreateFrame("Button", name, parent, "BackdropTemplate")
    
    if size then button:SetSize(size[1], size[2]) end
    
    if point then
        if type(point[1]) == "table" then
            for _, p in ipairs(point) do
                button:SetPoint(p[1], p[2] or parent, p[3] or p[1], p[4] or 0, p[5] or 0)
            end
        else
            button:SetPoint(point[1], point[2] or parent, point[3] or point[1], point[4] or 0, point[5] or 0)
        end
    end
    
    button:SetBackdrop(UILib.Backdropinfo)
    button:SetBackdropColor(unpack(UILib.ButtonBGColor))
    button:SetBackdropBorderColor(unpack(UILib.ButtonBorderColor))
    
    button.Text = button:CreateFontString(nil, "OVERLAY")
    button.Text:SetPoint("CENTER", 0, 0)
    button.Text:SetFont(UILib.FontPath, UILib.FontSize, "OUTLINE")
    button.Text:SetTextColor(unpack(UILib.TextColor))
    button.Text:SetText(text or "")
    
    button:SetScript("OnEnter", function(self)
        if self:IsEnabled() then
            self:SetBackdropColor(unpack(UILib.ButtonBGColor_OnEnter))
            self:SetBackdropBorderColor(unpack(UILib.ButtonBorderColor_OnEnter))
        end
    end)
    
    button:SetScript("OnLeave", function(self)
        if self:IsEnabled() then
            self:SetBackdropColor(unpack(UILib.ButtonBGColor))
            self:SetBackdropBorderColor(unpack(UILib.ButtonBorderColor))
        end
    end)
    
    button:SetScript("OnMouseDown", function(self)
        if self:IsEnabled() then
            local point, relativeTo, relativePoint, offsetX, offsetY = self.Text:GetPoint()
            self.Text:SetPoint(point, relativeTo, relativePoint, offsetX + 1.5, offsetY - 1.5)
        end
    end)
    
    button:SetScript("OnMouseUp", function(self)
        local point, relativeTo, relativePoint, offsetX, offsetY = self.Text:GetPoint()
        self.Text:SetPoint(point, relativeTo, relativePoint, offsetX - 1.5, offsetY + 1.5)
    end)
    
    function button:SetText(newText) self.Text:SetText(newText) end
    function button:GetText() return self.Text:GetText() end
    
    button._originalEnable = button.Enable
    function button:Enable()
        self:_originalEnable()
        self.Text:SetTextColor(unpack(UILib.TextColor))
    end
    
    button._originalDisable = button.Disable
    function button:Disable()
        self:_originalDisable()
        self.Text:SetTextColor(unpack(UILib.TextColor_Disabled))
    end
    
    return button
end

-- ========================================
-- 核心函数：创建字体字符串
-- ========================================
function UILib:CreateFontString(parent, point, text, fontSize, outline)
    local fontString = parent:CreateFontString(nil, "OVERLAY")
    
    if point then
        if type(point[1]) == "table" then
            for _, p in ipairs(point) do
                fontString:SetPoint(p[1], p[2] or parent, p[3] or p[1], p[4] or 0, p[5] or 0)
            end
        else
            fontString:SetPoint(point[1], point[2] or parent, point[3] or point[1], point[4] or 0, point[5] or 0)
        end
    end
    
    local fontSize = fontSize or UILib.FontSize
    local outline = outline and "OUTLINE" or nil
    -- [修改] 确保使用全局配置的字体
    fontString:SetFont(UILib.FontPath, fontSize, outline)
    fontString:SetTextColor(unpack(UILib.TextColor))
    fontString:SetText(text or "")
    
    return fontString
end

-- ========================================
-- 辅助函数：禁用窗口尺寸调整
-- ========================================
function UILib:DisableResizeVisual(frame)
    if not frame or not frame.frame then return end
    local frameObj = frame.frame
    
    if frame.EnableResize then
        frame:EnableResize(false)
    end

    for _, key in ipairs({"sizer_se", "sizer_s", "sizer_e"}) do
        local sizer = frameObj[key]
        if sizer then
            if sizer.Hide then sizer:Hide() end
            if sizer.EnableMouse then sizer:EnableMouse(false) end
            if sizer.SetScript then
                sizer:SetScript("OnMouseDown", nil)
                sizer:SetScript("OnMouseUp", nil)
            end
        end
    end
end

-- ========================================
-- [New] 统一窗口管理函数 (AceGUI)
-- ========================================
function UILib:GetOrCreateWindow(registryTable, key, config)
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    -- 1. 单例与置顶逻辑
    local frame = registryTable[key]
    if frame then
        if not frame:IsShown() then
            frame:Show()
            if config.onShow then config.onShow(frame) end
        end
        if frame.frame and frame.frame.Raise then
            frame.frame:Raise()
        end
        return frame, false -- 返回 frame 和 isNew=false
    end

    -- 2. 创建窗口
    frame = AceGUI:Create("Frame")
    registryTable[key] = frame -- 自动保存引用

    -- 3. 基础属性
    frame:SetTitle(config.title or "RurutiaSuite Window")
    frame:SetLayout(config.layout or "Fill")
    if config.width then frame:SetWidth(config.width) end
    if config.height then frame:SetHeight(config.height) end

    -- 4. 样式统一应用
    local frameObj = frame.frame
    self:ApplyWindowStyle(frameObj)
    
    local RS = LibStub("AceAddon-3.0"):GetAddon("RurutiaSuite", true)
    if RS and RS.SkinFrame then
        RS:SkinFrame(frameObj)
    end
    
    -- 清理标题栏材质 (通用逻辑)
    for _, region in pairs({frameObj:GetRegions()}) do
        if region:GetObjectType() == "Texture" then
            local texturePath = region:GetTexture()
            if texturePath and type(texturePath) == "string" then
                if texturePath:find("UI%-") or texturePath:find("Dialog") then
                    region:Hide()
                    region:SetTexture(nil)
                end
            end
        end
    end

    -- 设置标题样式 (通用逻辑)
    if frame.titletext then
        -- 尝试从全局配置获取字体大小，如果失败则使用默认值
        local titleFontSize = UILib.Defaults.titleFontSize
        local titleOffsetY = UILib.Defaults.titleOffsetY
        
        -- [重构] 优先使用 RS.db 配置，其次 ns.Config，最后 UILib.Defaults
        local RS = LibStub("AceAddon-3.0"):GetAddon("RurutiaSuite", true)
        if RS and RS.db and RS.db.profile and RS.db.profile.uiSizes and RS.db.profile.uiSizes.titleBar then
            titleFontSize = RS.db.profile.uiSizes.titleBar.fontSize or UILib.Defaults.titleFontSize
            titleOffsetY = RS.db.profile.uiSizes.titleBar.offsetY or UILib.Defaults.titleOffsetY
        elseif ns.Config and ns.Config.font then
            titleFontSize = ns.Config.font.headerSize or UILib.Defaults.titleFontSize
            titleOffsetY = (ns.Config.offsets and ns.Config.offsets.titleBarY) or UILib.Defaults.titleOffsetY
        end

        frame.titletext:SetFont(UILib.FontPath, titleFontSize, "OUTLINE")
        frame.titletext:ClearAllPoints()
        frame.titletext:SetPoint("TOP", frameObj, "TOP", 0, titleOffsetY)
    end

    -- 5. 尺寸调整控制
    if not config.resizable then
        self:DisableResizeVisual(frame)
        C_Timer.After(0, function() self:DisableResizeVisual(frame) end)
    end

    -- 5.1 [New] 隐藏状态栏
    if config.hideStatusBar then
        frame:SetStatusText("")
        if frame.statustext and frame.statustext:GetParent() then
            frame.statustext:GetParent():Hide()
        end
    end

    -- 5.2 [New] 隐藏默认关闭按钮
    if config.hideCloseButton then
        local frameObj = frame.frame
        for _, child in pairs({frameObj:GetChildren()}) do
            if child:GetObjectType() == "Button" and child:GetText() == _G.CLOSE then
                child:Hide()
                break
            end
        end
    end

    -- 6. 生命周期管理
    -- 监听 OnClose 事件（通常由 AceGUI 内部触发，如点击 X 按钮或 ESC）
    frame:SetCallback("OnClose", function(widget)
        if config.onClose then config.onClose(widget) end
        widget:Release()
        -- registryTable[key] = nil -- 移至 OnRelease 处理，确保 Release() 直接调用时也能清除
    end)

    -- 监听 OnRelease 事件（无论是通过 OnClose 还是直接调用 Release() 都会触发）
    -- 这是防止"僵尸控件"的关键：确保控件被回收时，引用一定被清除
    frame:SetCallback("OnRelease", function(widget)
        registryTable[key] = nil -- 自动清除引用
    end)

    return frame, true -- 返回 frame 和 isNew=true
end

-- ========================================
-- [New] 统一组件工厂 (Button - AceGUI)
-- ========================================
-- 注意：这里重载了上面的原生 CreateButton，参数 config 是 table
function UILib:CreateButton(config, ...)
    -- 如果第一个参数不是 table，则调用原生的 CreateNativeButton
    if type(config) ~= "table" then
        return self:CreateNativeButton(config, ...) 
    end
    
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    local btn = AceGUI:Create("Button")
    
    if config.text then btn:SetText(config.text) end
    if config.width then btn:SetWidth(config.width) end
    
    -- 尝试从全局配置获取默认按钮高度
    local defaultHeight = UILib.Defaults.buttonHeight or 22
    btn:SetHeight(config.height or defaultHeight)
    
    if config.onClick then
        btn:SetCallback("OnClick", config.onClick)
    end
    
    if config.tooltip then
        btn:SetCallback("OnEnter", function(widget)
            GameTooltip:SetOwner(widget.frame, "ANCHOR_TOP")
            GameTooltip:SetText(config.tooltip, 1, 1, 1)
            GameTooltip:Show()
        end)
        btn:SetCallback("OnLeave", function() GameTooltip:Hide() end)
    end

    -- 自动应用皮肤
    local RS = LibStub("AceAddon-3.0"):GetAddon("RurutiaSuite", true)
    if RS and RS.SkinButton then
        RS:SkinButton(btn.frame)
    end

    -- 自动添加到父容器
    if config.parent then
        config.parent:AddChild(btn)
    end

    return btn
end

-- ========================================
-- [New] 嵌入 AceGUI 到原生 Frame (Embed)
-- ========================================
function UILib:Embed(parent, config)
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    local container = AceGUI:Create("SimpleGroup")
    container:SetLayout(config.layout or "Fill")
    
    -- 手动重挂载和定位
    container.frame:SetParent(parent)
    container.frame:ClearAllPoints()
    
    if config.points then
        -- 支持多点定位
        for _, p in ipairs(config.points) do
            container.frame:SetPoint(unpack(p))
        end
    else
        -- 默认填满，留边距
        local margin = config.margin or 10
        container.frame:SetPoint("TOPLEFT", margin, -margin)
        container.frame:SetPoint("BOTTOMRIGHT", -margin, margin)
    end
    
    container.frame:Show()
    
    return container
end

-- ========================================
-- [New] 统一组件工厂 (SimpleGroup)
-- ========================================
function UILib:CreateSimpleGroup(config)
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    local group = AceGUI:Create("SimpleGroup")
    group:SetLayout(config.layout or "Flow")
    
    if config.fullWidth ~= false then group:SetFullWidth(true) end
    if config.width then group:SetWidth(config.width) end
    if config.height then group:SetHeight(config.height) end
    
    if config.parent then
        config.parent:AddChild(group)
    end
    
    return group
end

-- ========================================
-- [New] 统一组件工厂 (CheckBox)
-- ========================================
function UILib:CreateCheckBox(config)
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    local check = AceGUI:Create("CheckBox")
    
    if config.label then check:SetLabel(config.label) end
    if config.width then check:SetWidth(config.width) end
    if config.disabled ~= nil then check:SetDisabled(config.disabled) end
    
    -- 设置初始值
    if config.checked ~= nil then 
        check:SetValue(config.checked) 
    elseif config.get then
        check:SetValue(config.get())
    elseif config.value ~= nil then
        check:SetValue(config.value)
    end
    
    -- 回调处理
    if config.onValueChanged then
        check:SetCallback("OnValueChanged", function(widget, event, value)
            config.onValueChanged(widget, value)
        end)
    elseif config.set then
        check:SetCallback("OnValueChanged", function(widget, event, value)
            config.set(value)
        end)
    end
    
    if config.tooltip then
        check:SetCallback("OnEnter", function(widget)
            GameTooltip:SetOwner(widget.frame, "ANCHOR_TOP")
            GameTooltip:SetText(config.tooltip, 1, 1, 1)
            GameTooltip:Show()
        end)
        check:SetCallback("OnLeave", function() GameTooltip:Hide() end)
    end
    
    if config.parent then
        config.parent:AddChild(check)
    end

    return check
end

-- ========================================
-- [New] 统一组件工厂 (TabGroup)
-- ========================================
function UILib:CreateTabGroup(config)
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    local tab = AceGUI:Create("TabGroup")
    tab:SetLayout(config.layout or "Flow")
    
    -- 设置标签页定义
    -- tabs 格式: { {text="Tab1", value="val1"}, {text="Tab2", value="val2"} }
    if config.tabs then
        tab:SetTabs(config.tabs)
    end
    
    if config.width then tab:SetWidth(config.width) end
    if config.height then tab:SetHeight(config.height) end

    -- 回调处理
    tab:SetCallback("OnGroupSelected", function(container, event, group)
        container:ReleaseChildren()
        if config.onGroupSelected then
            config.onGroupSelected(container, group)
        end
    end)
    
    -- 默认选中第一个或指定的标签
    if config.defaultTab then
        tab:SelectTab(config.defaultTab)
    elseif config.tabs and config.tabs[1] then
        tab:SelectTab(config.tabs[1].value)
    end
    
    if config.parent then
        config.parent:AddChild(tab)
    end
    
    return tab
end

-- ========================================
-- [New] 统一组件工厂 (ScrollFrame)
-- ========================================
function UILib:CreateScrollFrame(config)
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout(config.layout or "List") -- 默认为 List 布局，适合长列表
    
    if config.width then scroll:SetWidth(config.width) end
    if config.height then scroll:SetHeight(config.height) end
    if config.fullWidth then scroll:SetFullWidth(config.fullWidth) end
    
    if config.parent then
        config.parent:AddChild(scroll)
    end
    
    return scroll
end

-- ========================================
-- [New] 统一组件工厂 (Label)
-- ========================================
function UILib:CreateLabel(config)
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    local label = AceGUI:Create("Label")
    label:SetText(config.text or "")
    
    if config.fullWidth ~= false then
        label:SetFullWidth(true)
    end
    
    -- 样式预设
    if config.type == "Header" then
        label:SetFontObject(GameFontNormalLarge)
        label:SetColor(1, 0.84, 0) -- 金色
        if label.label then
            label.label:SetTextColor(1, 0.84, 0, 1) -- 强制直接设置 FontString
        end
    elseif config.type == "Description" then
        label:SetFontObject(GameFontHighlight)
        label:SetColor(0.8, 0.8, 0.8) -- 浅灰
    else
        -- 默认样式
        if config.fontObject then label:SetFontObject(config.fontObject) end
        if config.color then label:SetColor(unpack(config.color)) end
    end

    if config.parent then
        config.parent:AddChild(label)
    end
    
    return label
end

-- ========================================
-- [New] 统一组件工厂 (Dropdown)
-- ========================================
function UILib:CreateDropdown(config)
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    local dropdown = AceGUI:Create("Dropdown")
    
    if config.label then dropdown:SetLabel(config.label) end
    if config.width then dropdown:SetWidth(config.width) end
    if config.list then dropdown:SetList(config.list) end
    if config.value then dropdown:SetValue(config.value) end
    
    if config.onValueChanged then
        dropdown:SetCallback("OnValueChanged", function(widget, event, value)
            config.onValueChanged(widget, value)
        end)
    end
    
    if config.parent then
        config.parent:AddChild(dropdown)
    end
    
    return dropdown
end

-- ========================================
-- [New] 统一组件工厂 (Slider)
-- ========================================
function UILib:CreateSlider(config)
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    local slider = AceGUI:Create("Slider")
    
    if config.label then slider:SetLabel(config.label) end
    if config.width then slider:SetWidth(config.width) end
    
    if config.min and config.max then
        slider:SetSliderValues(config.min, config.max, config.step or 1)
    end
    
    if config.value then slider:SetValue(config.value) end
    
    if config.onValueChanged then
        slider:SetCallback("OnValueChanged", function(widget, event, value)
            config.onValueChanged(widget, value)
        end)
    end
    
    if config.parent then
        config.parent:AddChild(slider)
    end
    
    return slider
end

-- ========================================
-- [New] 统一组件工厂 (EditBox)
-- ========================================
function UILib:CreateEditBox(config)
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    local edit = AceGUI:Create("MultiLineEditBox") -- 默认使用多行，也可加参数控制
    
    if config.label then edit:SetLabel(config.label) end
    if config.width then edit:SetWidth(config.width) end
    if config.height then edit:SetHeight(config.height) end
    if config.text then edit:SetText(config.text) end
    
    -- 禁用按钮（可选）
    if config.disableButton then
        edit:DisableButton(true)
    end
    
    if config.parent then
        config.parent:AddChild(edit)
    end
    
    return edit
end

-- ========================================
-- [New] 布局辅助函数
-- ========================================

-- 1. 基础空行函数
function UILib:AddSpacer(parent, size)
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    local spacer = AceGUI:Create("SimpleGroup")
    spacer:SetLayout(nil) -- 禁用 Layout 以精确控制高度
    spacer:SetFullWidth(true)
    spacer:SetHeight(size or 10)
    
    if parent then
        parent:AddChild(spacer)
    end
end

-- 1.5 水平空行函数 (用于 Flow 布局)
function UILib:AddHorizontalSpacer(parent, width)
    local AceGUI = LibStub("AceGUI-3.0", true)
    if not AceGUI then return end

    local spacer = AceGUI:Create("SimpleGroup")
    spacer:SetLayout(nil)
    spacer:SetWidth(width or 10)
    spacer:SetHeight(1)
    
    if parent then
        parent:AddChild(spacer)
    end
end

-- 2. 带间距的文本 (默认 Top=6, Bottom=0)
function UILib:CreateSpacedLabel(parent, text, top, bottom)
    self:AddSpacer(parent, top or 6)
    self:CreateLabel({
        text = text,
        parent = parent
    })
    if bottom and bottom > 0 then
        self:AddSpacer(parent, bottom)
    end
end

-- 3. 带间距的按钮 (默认 Top=10, Bottom=10)
function UILib:CreateSpacedButton(parent, params, top, bottom)
    self:AddSpacer(parent, top or 10)
    -- 确保 params 中包含 parent
    if not params.parent then params.parent = parent end
    local btn = self:CreateButton(params)
    self:AddSpacer(parent, bottom or 10)
    return btn
end

-- 4. 带间距的复选框 (默认 Top=6, Bottom=6)
function UILib:CreateSpacedCheckBox(parent, params, top, bottom)
    self:AddSpacer(parent, top or 6)
    -- 确保 params 中包含 parent
    if not params.parent then params.parent = parent end
    local check = self:CreateCheckBox(params)
    self:AddSpacer(parent, bottom or 6)
    return check
end

-- 5. 带标题的区域 (Header)
function UILib:CreateHeader(parent, text)
    return self:CreateLabel({
        text = text,
        type = "Header",
        parent = parent
    })
end

function UILib:CreateSectionHeader(parent, text, top, bottom)
    self:AddSpacer(parent, top or 10)
    self:CreateLabel({
        text = text,
        type = "Header",
        parent = parent
    })
    self:AddSpacer(parent, bottom or 5)
end

-- 挂载
if ns.RS then ns.RS.UILib = UILib end
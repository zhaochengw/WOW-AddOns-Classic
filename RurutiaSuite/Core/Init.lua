local addonName, ns = ...
local RS = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")
ns.RS = RS
_G.RurutiaSuite = RS

-- UILib 会在 UILib.lua 加载时自动挂载到 RS.UILib

-- 默认配置
local defaults = {
    profile = {
        modules = {
            ['*'] = true,
        },
        minimap = {
            hide = false,
        },
    },
    global = {
        lastSeenVersion = "0.0.0",
    }
}

-- ========================================
-- TOC 版本检测
-- ========================================
-- 允许加载动作条模块的 TOC 白名单
-- 304xx: WotLK Classic (3.4.x)
-- 308xx: WotLK Classic (3.8.x - 特殊版本)
-- 504xx: MoP (5.4.x)
function RS:IsBarModuleSupported()
    local _, _, _, tocVersion = GetBuildInfo()
    tocVersion = tonumber(tocVersion) or 0

    -- 允许加载动作条模块的 TOC 白名单
    -- 304xx: WotLK Classic (3.4.x)
    -- 308xx: WotLK Classic (3.8.x - 特殊版本)
    -- 504xx: MoP (5.4.x)
    
    -- 简单的白名单检查逻辑
    if tocVersion >= 30000 and tocVersion < 40000 then return true end -- WLK
    if tocVersion >= 50000 and tocVersion < 60000 then return true end -- MoP
    
    return false
end

function RS:OnInitialize()
    -- 注册 Slash 命令
    self:RegisterChatCommand("rs", "OnChatCommand")

    -- 初始化数据库
    self.db = LibStub("AceDB-3.0"):New("RurutiaSuiteDB", defaults, true)
    self.db:SetProfile("Default") -- 强制使用全局统一配置

    self.db.profile.minimap = self.db.profile.minimap or {}
    self.db.profile.minimap.hide = false
    
    -- 创建设置面板
    self:CreateOptionsPanel()

    local icon = LibStub("LibDBIcon-1.0", true)
    local ldb = LibStub("LibDataBroker-1.1", true)
    if icon and ldb then
        local broker = ldb:NewDataObject(addonName, {
            type = "launcher",
            text = "RurutiaSuite",
            icon = "Interface\\AddOns\\RurutiaSuite\\Media\\icon",
            OnClick = function(_, button)
                RS:ToggleMainFrame()
            end,
            OnTooltipShow = function(tooltip)
                tooltip:AddLine("RurutiaSuite |cffff559a露露的工具箱|r")
                tooltip:AddLine("|cffeda55f点击|r 打开主界面")
            end,
        })

        if icon.IsRegistered and icon:IsRegistered(addonName) then
            icon:Refresh(addonName, self.db.profile.minimap)
        else
            icon:Register(addonName, broker, self.db.profile.minimap)
        end
        icon:Show(addonName)
    end
    
    -- 获取版本号
    local version = GetAddOnMetadata(addonName, "Version") or "Unknown"
    self:Print("已加载 v" .. version)
end

function RS:Print(msg, ...)
    if select("#", ...) > 0 then
        msg = msg:format(...)
    end
    print("|cff00ff00[RS]|r " .. msg)
end

function RS:OnEnable()
    -- 临时禁用自动弹出更新日志（调试中）
    -- 检查版本更新
    if self.CheckVersionUpdate then
        self:CheckVersionUpdate()
    end
end

function RS:OnChatCommand(input)
    if not input or input:trim() == "" then
        self:ToggleMainFrame()
    elseif input:trim():lower() == "help" then
        print("|cff00ff00[RS]|r 露露的工具箱 命令列表")
        print("   |cff00ff00/rs|r        - 打开主界面")
        print("   |cff00ff00/rs help|r   - 显示命令列表")
        print("   |cff00ff00/rsm|r       - 解锁/锁定 法师传送门")
        print("   |cff00ff00/ram|r       - 标记坦克/治疗")
        print("   |cff00ff00/ramc|r      - 清除标记")
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("rs", "RurutiaSuite", input)
    end
end

-- ========================================
-- 创建设置面板 (复刻 RSE 风格)
-- ========================================

function RS:CreateOptionsPanel()
    -- 确保兼容层已加载
    local AddCategory = RS.Compat and RS.Compat.InterfaceOptions_AddCategory or _G.InterfaceOptions_AddCategory

    -- 创建主面板
    local panel = CreateFrame("Frame", "RSOptionsPanel", UIParent)
    panel.name = "RS |cffff559a露露的工具箱|r"
    panel:Hide()

    -- 注册到设置面板
    if AddCategory then
        AddCategory(panel)
    end

    -- 标题
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("RS |cffff559a露露的工具箱|r")

    -- 副标题
    local subtitle = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    subtitle:SetText("All-in-One Utility Suite")
    
    -- 版本号
    local version = GetAddOnMetadata(addonName, "Version") or "Unknown"
    local versionText = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    versionText:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -8)
    versionText:SetText("|cffFFD700版本: |r|cffFFFFFF" .. version .. "|r")
    
    -- 分隔线
    local divider = panel:CreateTexture(nil, "ARTWORK")
    divider:SetHeight(1)
    divider:SetPoint("TOPLEFT", versionText, "BOTTOMLEFT", 0, -8)
    divider:SetPoint("RIGHT", -16, 0)
    divider:SetColorTexture(0.5, 0.5, 0.5, 0.5)

    -- 创建按钮容器（用于定位AceGUI按钮）
    local buttonContainer = CreateFrame("Frame", nil, panel)
    buttonContainer:SetSize(200, 50)
    buttonContainer:SetPoint("TOPLEFT", divider, "BOTTOMLEFT", 0, -16)

    -- 打开主界面按钮（使用 UILib 工厂）
    local openButton = self.UILib:CreateButton({
        text = "打开主界面",
        width = 180,
        height = 40,
        onClick = function()
            RS:ShowMainFrame()
        end
    })

    openButton.frame:SetParent(buttonContainer)
    openButton.frame:ClearAllPoints()
    openButton.frame:SetPoint("TOPLEFT", buttonContainer, "TOPLEFT", 0, 0)
    openButton.frame:Show()

    -- 保存按钮引用，防止被垃圾回收
    panel.openButton = openButton

    -- 说明文本
    local description = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    description:SetPoint("TOPLEFT", buttonContainer, "BOTTOMLEFT", 0, -16)
    description:SetPoint("RIGHT", -16, 0)
    description:SetJustifyH("LEFT")
    description:SetText([[
|cffFFD700插件简介：|r
RurutiaSuite (RS) 是一个轻量化、模块化的自用魔兽世界工具箱，旨在提供高效、便捷的游戏辅助体验。

|cffFFD700核心功能：|r
• 自动标记 (RMA)：自动标记坦克与治疗，支持自定义标记。
• 法师传送门动作条：法师传送/传送门动作条，不使用则自动折叠。
• CVAR设置：快速调整系统设置（伤害数字开关、装备对比、画面效果等）。
• 数据导出 (RSE)：批量导出物品与法术信息（开发者工具）。

|cffFFD700使用方法：|r
• 点击"打开主界面"按钮打开工具箱
• 或使用命令 /rs 打开主界面

|cffFFD700关于作者：|r
• 作者：露露緹婭 (@Bilibili)
• KOOK社区：https://kook.top/W064MD
• 网易DD频道号：16888
• 有问题可在B站私信/评论留言，或者在我的KK/DD频道反馈，感谢支持。
    ]])
    
    -- 保存面板引用
    self.optionsPanel = panel

    -- ========================================
    -- 注册子模块面板 (复用 Tab 绘制逻辑)
    -- ========================================

    -- 1. 自动标记 (AutoMark)
    local amPanel = CreateFrame("Frame", "RSAutoMarkOptions", UIParent)
    amPanel.name = "自动标记"
    amPanel.parent = panel.name
    amPanel:Hide()
    if AddCategory then AddCategory(amPanel) end
    
    amPanel:SetScript("OnShow", function(self)
        if not self.isInitialized then
            local container = RS.UILib:Embed(self, {layout="Fill", margin=0})
            local mod = RS:GetModule("AutoMark", true)
            if mod and mod.DrawSettings then
                mod:DrawSettings(container)
            end
            self.isInitialized = true
        end
    end)

    -- 2. 法师动作条 (Portal)
    local portalPanel = CreateFrame("Frame", "RSPortalOptions", UIParent)
    portalPanel.name = "法师动作条"
    portalPanel.parent = panel.name
    portalPanel:Hide()
    if AddCategory then AddCategory(portalPanel) end
    
    portalPanel:SetScript("OnShow", function(self)
        if not self.isInitialized then
            local container = RS.UILib:Embed(self, {layout="Fill", margin=0})
            local mod = RS:GetModule("Consumables", true)
            if mod and mod.DrawSettings then
                mod:DrawSettings(container)
            end
            self.isInitialized = true
        end
    end)

    -- 3. CVAR设置 (CVarSettings)
    local cvarPanel = CreateFrame("Frame", "RSCVarOptions", UIParent)
    cvarPanel.name = "CVAR设置"
    cvarPanel.parent = panel.name
    cvarPanel:Hide()
    if AddCategory then AddCategory(cvarPanel) end
    
    cvarPanel:SetScript("OnShow", function(self)
        if not self.isInitialized then
            local mod = RS:GetModule("CVarSettings")
            if mod and mod.DrawSettings then
                local container = RS.UILib:Embed(self, {layout="Fill", margin=0})
                mod:DrawSettings(container)
            end
            self.isInitialized = true
        end
    end)
end

-- ========================================
-- 主界面构建 (完全使用 Config 配置)
-- ========================================

-- 获取主题色
-- useClassColor: 是否使用职业色（如果为 false 或 nil，且是牧师，则返回绿色）
function RS:GetThemeColorCode(useClassColor)
    local _, class = UnitClass("player")
    
    -- 如果不强制使用职业色，且玩家是牧师，则返回绿色（用于正文高亮）
    if not useClassColor and class == "PRIEST" then
        return "|cff00ff00"
    end
    
    local color = RAID_CLASS_COLORS and RAID_CLASS_COLORS[class]
    if color then
        return string.format("|cFF%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
    end
    
    return "|cFFFFD700" -- 默认金色
end

-- 关闭其他已管理的窗口 (实现互斥显示)
function RS:CloseAllManagedWindows(exceptKey)
    local managedKeys = {
        "mainFrame",
        "changelogFrame"
    }
    
    for _, key in ipairs(managedKeys) do
        if key ~= exceptKey then
            local win = self[key]
            if win and win.IsShown and win:IsShown() then
                win:Hide()
            end
        end
    end
end

-- 显示主界面（如果已显示，则置顶；如果未显示，则显示）
function RS:ShowMainFrame()
    -- 关闭其他互斥窗口
    self:CloseAllManagedWindows("mainFrame")

    local cfg = ns.Config.windows.mainFrame
    
    -- 标题始终使用职业色（牧师也是白色）
    local colorCode = self:GetThemeColorCode(true)
    local title = colorCode .. "露露的工具箱|r"

    local frame, isNew = self.UILib:GetOrCreateWindow(self, "mainFrame", {
        title = title,
        width = cfg.width,
        height = cfg.height,
        resizable = false,
        hideStatusBar = true, -- [New] 使用 UILib 特性
        hideCloseButton = true, -- [New] 使用 UILib 特性
        onClose = function(widget)
            if widget.subtitle then widget.subtitle:Hide() end
        end
    })

    if not isNew then return end

    local frameObj = frame.frame
    
    -- 创建副标题（版本号）
    local version = GetAddOnMetadata(addonName, "Version") or "Unknown"
    local subCfg = ns.Config.offsets
    local subtitle = frameObj:CreateFontString(nil, "OVERLAY")
    frame.subtitle = subtitle
    subtitle:SetFont("Fonts\\ARKai_T.ttf", ns.Config.font.subHeaderSize, "OUTLINE")
    subtitle:SetText("v" .. version)
    subtitle:SetTextColor(subCfg.subTitleColor.r, subCfg.subTitleColor.g, subCfg.subTitleColor.b)
    subtitle:SetPoint("TOP", frameObj, "TOP", 0, subCfg.subTitleY)
    
    -- 创建主容器
    local mainContainer = self.UILib:CreateSimpleGroup({
        layout = "Fill",
        fullWidth = true,
        fullHeight = true,
        parent = frame
    })
    
    -- 创建 TabGroup 容器（预留底部按钮空间）
    local tabContainer = self.UILib:CreateSimpleGroup({
        layout = "Fill",
        fullWidth = true,
        fullHeight = true,
        parent = mainContainer
    })
    
    -- 应用 TabGroup 布局
    local function ApplyTabLayout()
        local tcFrame = tabContainer.frame
        local tabCfg = ns.Config.offsets.mainTabGroup
        tcFrame:ClearAllPoints()
        tcFrame:SetPoint("TOPLEFT", frameObj, "TOPLEFT", tabCfg.left, tabCfg.top)
        tcFrame:SetPoint("BOTTOMRIGHT", frameObj, "BOTTOMRIGHT", tabCfg.right, tabCfg.bottom)
    end
    ApplyTabLayout()
    
    -- 构建标签页列表
    local tabs = {
        {value = "autoMark", text = "自动标记"},
        {value = "portal", text = "法师动作条"},
        {value = "cvar", text = "CVAR设置"},
    }

    -- 仅当 RSE 加载时显示 "其他" 标签页
    if IsAddOnLoaded("RurutiaSuite_Exporter") then
        table.insert(tabs, {value = "misc", text = "其他"})
    end

    table.insert(tabs, {value = "about", text = "关于"})

    -- 创建 TabGroup
    local tabGroup = self.UILib:CreateTabGroup({
        layout = "Fill",
        tabs = tabs,
        onGroupSelected = function(container, group)
            if group == "autoMark" then
                local mod = RS:GetModule("AutoMark", true)
                if mod and mod.DrawSettings then
                    mod:DrawSettings(container)
                else
                    RS:Print("模块 AutoMark 未加载")
                end
            elseif group == "portal" then
                local mod = RS:GetModule("Consumables", true)
                if mod and mod.DrawSettings then
                    mod:DrawSettings(container)
                else
                    RS:Print("模块 Consumables 未加载")
                end
            elseif group == "cvar" then
                local mod = RS:GetModule("CVarSettings")
                if mod and mod.DrawSettings then
                    mod:DrawSettings(container)
                end
            elseif group == "misc" then
                RS:DrawMiscTab(container)
            elseif group == "about" then
                RS:DrawAboutTab(container)
            end
        end,
        defaultTab = "autoMark",
        parent = tabContainer
    })
    
    -- 应用 RS 皮肤系统（美化 TabGroup）
    if RS.SkinTabGroup then
        RS:SkinTabGroup(tabGroup)
    end
    
    -- 底部按钮
    local btnContainer = self.UILib:CreateSimpleGroup({
        layout = "Table",
        fullWidth = true,
        height = ns.Config.buttons.height.dialog + 25,
        parent = frame
    })
    
    local btnWidthCfg = ns.Config.buttons.width
    local btnBottomCfg = ns.Config.offsets.mainBottomButtons
    
    btnContainer:SetUserData("table", {
        columns = {btnWidthCfg.bottomButton1, btnWidthCfg.bottomButton2},
        space = btnBottomCfg.spacing,
        align = "LEFT"
    })
    
    -- 应用底部按钮布局
    local function ApplyBottomButtonLayout()
        local btnFrame = btnContainer.frame
        btnFrame:ClearAllPoints()
        btnFrame:SetPoint("BOTTOMLEFT", frameObj, "BOTTOMLEFT", btnBottomCfg.left, btnBottomCfg.bottom)
        btnFrame:SetPoint("BOTTOMRIGHT", frameObj, "BOTTOMRIGHT", btnBottomCfg.right, btnBottomCfg.bottom)
    end
    ApplyBottomButtonLayout()
    
    -- 更新日志按钮
    self.UILib:CreateButton({
        text = "更新日志",
        width = btnWidthCfg.bottomButton1,
        height = ns.Config.buttons.height.dialog,
        onClick = function() RS:ShowChangelog() end,
        parent = btnContainer
    })
    
    -- 关闭按钮
    self.UILib:CreateButton({
        text = "关闭",
        width = btnWidthCfg.bottomButton2,
        height = ns.Config.buttons.height.dialog,
        onClick = function() frame:Hide() end,
        parent = btnContainer
    })
end

-- 切换主界面显示/隐藏状态
function RS:ToggleMainFrame()
    if self.mainFrame and self.mainFrame:IsShown() then
        self.mainFrame:Hide()
    else
        self:ShowMainFrame()
    end
end

-- ---------------------------------------------------------
-- 布局辅助函数 (已移至 UILib.lua，此处通过 self.UILib 调用)
-- ---------------------------------------------------------

function RS:DrawMiscTab(container)
    local scroll = self.UILib:CreateScrollFrame({
        layout = "List",
        parent = container
    })
    
    self.UILib:AddSpacer(scroll, 10)
    
    -- ========================================
    -- [RSE] 数据导出模块
    -- ========================================
    if IsAddOnLoaded("RurutiaSuite_Exporter") then
        local rseGroup = self.UILib:CreateSimpleGroup({
            layout = "List",
            fullWidth = true,
            parent = scroll
        })
        
        -- 模块标题
        self.UILib:CreateSectionHeader(rseGroup, "|cffffd700开发者工具 (RSE)|r", 40, 5)
        
        local rse = LibStub("AceAddon-3.0"):GetAddon("RurutiaSuite_Exporter", true)
        
        -- 打开按钮
        self.UILib:AddSpacer(rseGroup, 8)
        
        local btnGroup = self.UILib:CreateSimpleGroup({
            layout = "Flow",
            fullWidth = true,
            parent = rseGroup
        })
        
        self.UILib:AddHorizontalSpacer(btnGroup, 3)
        
        self.UILib:CreateButton({
            text = "打开 RSE 主界面",
            width = 180,
            height = 35,
            onClick = function()
                if rse and rse.UI then rse.UI:ShowMainFrame() end
                if self.mainFrame then
                    self.mainFrame:Hide()
                end
            end,
            parent = btnGroup
        })
        
        -- 说明文本
        local textLine = self.UILib:CreateSimpleGroup({
            layout = "Flow",
            fullWidth = true,
            parent = rseGroup
        })
        
        self.UILib:AddHorizontalSpacer(textLine, 3)
        
        local label = self.UILib:CreateLabel({
            text = "批量导出法术和物品数据工具。",
            fullWidth = false,
            parent = textLine
        })
        label:SetRelativeWidth(0.96)
    end
end

function RS:DrawAboutTab(container)
    local scroll = self.UILib:CreateScrollFrame({
        layout = "List",
        parent = container
    })
    
    self.UILib:AddSpacer(scroll, 10) -- [Fix] 统一顶部间距

    -- 简介内容
    local function AddInfoLine(text, isHeader)
        local label = self.UILib:CreateLabel({
            text = text,
            type = isHeader and "Header" or "Description",
            parent = scroll
        })
        -- Description 类型默认是浅灰，Header 是金色
        -- 如果需要更细致的控制，CreateLabel 已支持
        if isHeader then
            self.UILib:AddSpacer(scroll, 10)
        else
            -- 覆盖 Description 的颜色为 0.9
            label:SetColor(0.9, 0.9, 0.9)
            self.UILib:AddSpacer(scroll, 5)
        end
    end
    
    AddInfoLine("插件简介", true)
    AddInfoLine("RurutiaSuite (RS) 是一个轻量化、模块化的自用魔兽世界工具箱，旨在提供高效、便捷的游戏辅助体验。")
    
    self.UILib:AddSpacer(scroll, 10)
    AddInfoLine("核心功能", true)
    AddInfoLine("• |cffffd700自动标记 (RMA)：|r 自动标记坦克与治疗，支持自定义标记。")
    AddInfoLine("• |cffffd700法师传送门动作条：|r 法师传送/传送门动作条，不使用则自动折叠。")
    AddInfoLine("• |cffffd700CVAR设置：|r 快速调整系统设置（伤害数字开关、装备对比、画面效果等）。")
    AddInfoLine("• |cffffd700数据导出 (RSE)：|r 批量导出物品与法术信息（开发者工具）。")
    
    self.UILib:AddSpacer(scroll, 10)
    AddInfoLine("关于作者", true)
    AddInfoLine("作者：露露緹婭 (@Bilibili)")
    AddInfoLine("KOOK社区：https://kook.top/W064MD")
    AddInfoLine("网易DD频道号：16888")
    AddInfoLine("有问题可在B站私信/评论留言，或者在我的KK/DD频道反馈，感谢支持。")
    
    self.UILib:AddSpacer(scroll, 20)
end

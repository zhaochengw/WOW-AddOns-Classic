-- ========================================
-- Core/Changelog.lua
-- 更新日志弹窗模块
-- ========================================
-- 职责：
-- 1. 检测版本更新
-- 2. 显示更新日志弹窗
-- 3. 记录用户已查看的版本
-- ========================================

local addonName, ns = ...
local RS = ns.RS
local AceGUI = LibStub("AceGUI-3.0", true)
if not AceGUI then return end

-- 兼容性处理：获取版本号
local function GetAddOnVersion()
    if C_AddOns and C_AddOns.GetAddOnMetadata then
        return C_AddOns.GetAddOnMetadata(addonName, "Version") or "0.0.0"
    end
    return GetAddOnMetadata(addonName, "Version") or "0.0.0"
end

-- 获取职业色
local function GetClassColor()
    local _, class = UnitClass("player")
    if class and RAID_CLASS_COLORS and RAID_CLASS_COLORS[class] then
        local color = RAID_CLASS_COLORS[class]
        return string.format("|cFF%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
    end
    -- 默认金色
    return "|cFFFFD700"
end

-- ========================================
-- 更新日志内容
-- ========================================

local CHANGELOG = {
-- @StartChangelogData
    ["latest"] = {
        version = "2.6.5",
        date = "2026-01-07",
        content = function()
            local classColor = GetClassColor()
            local text = [[
%sv2.6.5|r
%s[法师动作条]|r
• 新增法术：新增托尔巴拉德传送/传送门（MOP）。

%s[自动标记]|r
• 权限优化：/ram、/ramc、标记/清标按钮，不需要队长权限也可以使用。
• 队长权限：默认不勾选。

%s[CVAR自动设置]|r
• 失控警报：新增选项，默认禁用失控警报。


%sv2.6.4|r
%s[法师动作条]|r
• 材料刷新：购买/消耗符文后，图示材料数量实时刷新，无需/RL。
• 事件优化：仅在动作条启用且需要显示材料时监听背包变化，避免无效开销。

%s[CVAR自动设置]|r
• 失控警报：新增“禁用失控警报”开关，4/5 版本可用；WLK 3.x 自动隐藏且不会写入。
• WLK兼容：WLK 3.x 下自动隐藏不支持的特效相关选项，并拦截写入以防无效设置。


%sv2.6.3|r
%s[法师动作条]|r
• 解锁展开：点击解锁后将强制展开显示全部按钮，不再只显示一个按钮。
• 覆盖层修复：解锁拖拽绿色覆盖层保持覆盖整条动作条，交互更直观。

%s[CVAR自动设置]|r
• 默认勾选：41码血条现在默认启用（推荐预设改为 41 码）。


%sv2.6.2|r
%s[法师动作条]|r
• 内置字体：现在使用插件自带的 Rurutia.ttf（思源黑体），防止乱码问题。
• 初始化优化：修复登录时动作条默认展开的问题，现在会正确保持折叠状态。
• UI微调：优化传送门按钮文本。
• 智能显示：根据游戏版本智能显示施法材料。

%s[数据修正]|r
• MOP传送门：修正锦绣谷传送门法术ID和图标显示问题（MOP）。

%s[CVAR自动设置]|r
• 即时开关：新增模块启用/禁用开关，切换后立刻生效，无需 /RL。
• 持久化修复：用户勾选/取消的自定义设置稳定写入 WTF，不再因 /RL 或重登丢失。
• 预设精简：移除冗余预设，统一基于“露露基准 + 用户自定义覆盖”。
• 新增选项：新增“禁用系统法术特效”，并默认启用禁用（关闭系统触发特效）。
• 默认勾选：屏蔽 Lua 错误、关闭死亡特效、关闭全屏幕泛光默认勾选。
• 样式统一：复刻其他 Tab 的标题/间距/布局，交互更一致。


%sv2.6.0|r
%s[新增功能]|r
• 功能迁移：CVAR设置模块迁移到插件中，设置命令/rs。
• 法师动作条：新增生长方向选择，支持上/下/左/右四个方向自由生长，满足不同布局需求。
• 设置面板：未安装RSE插件时，智能隐藏“其他”标签页。

%s[问题修复]|r
• 法师动作条：适配MOP，修复传送锦绣谷按钮阵营主城（七星殿/双月殿）识别问题。


%sv2.5.8|r
%s[核心重构]|r
• 架构升级：全面消除全局变量依赖，统一使用 UILib 组件工厂，代码更健壮。
• 模块标准化：CVar、更新日志、法师动作条等模块完成组件化适配。
• 配置统一：模块配置路径迁移至，移除旧兼容层。

%s[界面优化]|r
• 样式统一：所有子窗口和按钮统一调用 UILib 标准样式，视觉体验更一致。
• 代码精简：移除冗余的胶水代码和硬编码尺寸，体积更小巧。

%s[问题修复]|r
• CVar 设置：修复选项注册时的报错问题。
• UI 组件：修复按钮 Tooltip 锚点错误及变长参数支持问题。


%sv2.5.7|r
%s[新增功能]|r
• 设置界面升级：游戏参数设置页面全新改版，更好看、更好用，且已整合到工具箱内。  
• 超远视距：新增视距调整滑块，可拉得比默认更远，视野更广。  
• 画质细节开关：新增伤害数字、装备管理、天气、泛光等设置的单独开关，/rs进行设置。  

%s[体验优化]|r
• 智能应用：设置智能生效。
• 快速入口：现在可以在 ESC-选项-插件-RS 露露的工具箱 中找到全新的设置页。

%s[问题修复]|r
• 修复报错：修复了一些语言包加载顺序导致的报错。


%sv2.5.6|r
%s[新增功能]|r
• 兼容性扩展：新增 MoP (熊猫人之谜) 版本支持，完美适配 5.4.x 版本客户端。
• 字体优化：默认使用系统字体，移除对第三方字体的依赖，提升跨平台兼容性。
• UI 容器工厂：新增通用布局容器工厂，彻底解决 RSE 窗口重复布局问题。

%s[性能优化]|r
• 自动标记优化：重构标记逻辑，使用表复用技术减少 GC 压力，提升运行效率。
• 内存管理：优化自动标记模块内存使用，减少临时表创建，降低内存占用。

%s[界面改进]|r
• 窗口美化：新增隐藏状态栏和关闭按钮选项，界面更加简洁美观。
• 布局统一：标准化所有窗口布局参数，确保不同模块间的一致性体验。

%s[代码架构]|r
• 异步库：新增 AsyncLib.lua 提供异步操作支持，为后续功能扩展奠定基础。
• 兼容层：新增 Compat.lua 兼容层，统一处理不同版本间的 API 差异。
• UI 库增强：UILib 新增容器工厂函数，简化复杂界面构建流程。
            ]]
            return text:gsub("%%s", classColor)
        end,
    },
    -- @EndChangelogData
}

-- ========================================
-- 检查版本更新
-- ========================================

function RS:CheckVersionUpdate()
    -- 获取当前版本号
    local currentVersion = GetAddOnVersion()
    local lastSeenVersion = self.db.global.lastSeenVersion or "0.0.0"

    -- 比较完整版本号（包括修订号）
    -- 任何版本号变化都会弹窗
    if currentVersion ~= lastSeenVersion then
        -- 立即更新版本号，防止 /rl 后重复弹出
        self.db.global.lastSeenVersion = currentVersion

        -- 延迟3秒显示，避免登录时弹窗过多
        C_Timer.After(3, function()
            self:ShowChangelogWindow()
        end)
    end
end

-- ========================================
-- 显示更新日志弹窗
-- ========================================

function RS:ShowChangelogWindow()
    -- 关闭其他互斥窗口
    if self.CloseAllManagedWindows then
        self:CloseAllManagedWindows("changelogFrame")
    end

    -- 获取当前版本号用于记录
    local currentVersion = GetAddOnVersion()

    -- 标题始终使用职业色（牧师也是白色）
    local classColor = RS:GetThemeColorCode(true)
    local title = string.format("%s露露的工具箱 更新日志|r", classColor)
    
    local winCfg = ns.Config.windows.changelogWindow

    local frame, isNew = self.UILib:GetOrCreateWindow(self, "changelogFrame", {
        title = title,
        width = winCfg.width,
        height = winCfg.height,
        resizable = winCfg.resizable,
        onClose = function(widget)
            self.db.global.lastSeenVersion = currentVersion
        end
    })

    if not isNew then return end

    -- 获取内层原生Frame
    local frameObj = frame.frame

    -- 隐藏AceGUI自带的关闭按钮
    for _, child in pairs({frameObj:GetChildren()}) do
        if child:GetObjectType() == "Button" and child:GetText() == _G.CLOSE then
            child:Hide()
            break
        end
    end

    -- 隐藏状态栏
    if frame.statustext then
        frame.statustext:GetParent():Hide()
    end

    -- 创建主容器（SimpleGroup）
    local mainContainer = self.UILib:CreateSimpleGroup({
        layout = "Fill",
        fullWidth = true,
        fullHeight = true,
        parent = frame
    })

    -- 创建滚动框容器（占据大部分空间）
    local scrollContainer = self.UILib:CreateSimpleGroup({
        layout = "Fill",
        fullWidth = true,
        parent = mainContainer
    })

    -- 布局应用函数 (模仿 Init.lua，复用主界面边距)
    -- [Refactor] 直接使用 ns.Config
    local mainCfg = {
        tabGroup = ns.Config.offsets.mainTabGroup,
        bottomButtons = {
            container = ns.Config.offsets.mainBottomButtons,
            button1 = { width = ns.Config.buttons.width.bottomButton1 },
            button2 = { width = ns.Config.buttons.width.bottomButton2 },
            spacing = ns.Config.offsets.mainBottomButtons.spacing,
        }
    }
    
    local function ApplyScrollLayout()
        local scFrame = scrollContainer.frame
        scFrame:ClearAllPoints()
        -- 使用主界面的 tabGroup 边距配置
        scFrame:SetPoint("TOPLEFT", frameObj, "TOPLEFT", mainCfg.tabGroup.left, mainCfg.tabGroup.top)
        scFrame:SetPoint("BOTTOMRIGHT", frameObj, "BOTTOMRIGHT", mainCfg.tabGroup.right, mainCfg.tabGroup.bottom)
    end
    ApplyScrollLayout()

    -- 创建滚动文本框
    local scrollFrame = self.UILib:CreateScrollFrame({
        layout = "Flow",
        fullWidth = true,
        fullHeight = true,
        parent = scrollContainer
    })

    -- 2. 显示合并后的更新日志
    local entry = CHANGELOG["latest"]
    local contentCfg = { fontSize = ns.Config.font.contentSize }
    
    if entry then
        local body = type(entry.content) == "function" and entry.content() or entry.content

        -- [Fix] 如果当前版本比日志版本新，插入提示
        if currentVersion ~= entry.version then
            local classColor = RS:GetThemeColorCode(true)
            local warning = string.format("%sv%s|r\n待补充。\n\n", classColor, currentVersion)
            body = warning .. body
        end

        self.UILib:CreateLabel({
            text = body,
            font = "Fonts\\ARKai_T.ttf",
            fontSize = contentCfg.fontSize,
            outline = "OUTLINE",
            fullWidth = true,
            parent = scrollFrame
        })
    else
        self.UILib:CreateLabel({
            text = "未找到更新日志数据。",
            font = "Fonts\\ARKai_T.ttf",
            fontSize = contentCfg.fontSize,
            outline = "OUTLINE",
            fullWidth = true,
            parent = scrollFrame
        })
    end

    -- 创建按钮组容器（位于底部，复用主界面配置）
    local btnCfg = mainCfg.bottomButtons
    local btnContainer = self.UILib:CreateSimpleGroup({
        layout = "Table",
        fullWidth = true,
        height = ns.Config.buttons.height.dialog + 25,
        parent = frame -- 注意：直接作为 frame 的子元素
    })
    
    btnContainer:SetUserData("table", {
        columns = {btnCfg.button1.width, btnCfg.button2.width}, 
        space = btnCfg.spacing,
        align = "LEFT"
    })

    -- 应用底部按钮布局 (模仿 Init.lua)
    local function ApplyBottomButtonLayout()
        local btnFrame = btnContainer.frame
        btnFrame:ClearAllPoints()
        btnFrame:SetPoint("BOTTOMLEFT", frameObj, "BOTTOMLEFT", btnCfg.container.left, btnCfg.container.bottom)
        btnFrame:SetPoint("BOTTOMRIGHT", frameObj, "BOTTOMRIGHT", btnCfg.container.right, btnCfg.container.bottom)
    end
    ApplyBottomButtonLayout()

    -- 打开主界面按钮 (Width: button1)
    self.UILib:CreateButton({
        text = "打开主界面",
        width = btnCfg.button1.width,
        height = ns.Config.buttons.height.dialog,
        onClick = function()
            if RS.ShowMainFrame then
                RS:ShowMainFrame()
            else
                RS:Print("功能未实现: ShowMainFrame")
            end
        end,
        parent = btnContainer
    })

    -- 关闭按钮 (Width: button2)
    self.UILib:CreateButton({
        text = "关闭",
        width = btnCfg.button2.width,
        height = ns.Config.buttons.height.dialog,
        onClick = function()
            self.db.global.lastSeenVersion = currentVersion
            frame:Release()
        end,
        parent = btnContainer
    })
end

-- ========================================
-- 手动显示更新日志
-- ========================================

function RS:ShowChangelog(version)
    -- version 参数不再使用，但为了兼容性保留接口
    self:ShowChangelogWindow()
end

-- ========================================
-- Core/Config.lua
-- RurutiaSuite 全局配置
-- ========================================

local addonName, ns = ...

-- 字体逻辑
local FONT_PREFERRED = "Interface\\AddOns\\MikScrollingBattleText\\Fonts\\Rurutia.ttf"
local FONT_FALLBACK  = "Fonts\\ARKai_T.ttf"
local GLOBAL_FONT = FONT_FALLBACK
--local GLOBAL_FONT = IsAddOnLoaded("MikScrollingBattleText") and FONT_PREFERRED or FONT_FALLBACK

local RURUTIA_SUITE_CONFIG = {
    -- ========================================
    -- [全局视觉主题]
    -- ========================================
    theme = {
        iconCoords = { 0.08, 0.92, 0.08, 0.92 }, 
        border = {
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            edgeSize = 1,
            color = { r = 0, g = 0, b = 0, a = 1 },
        },
        background = { r = 0, g = 0, b = 0, a = 0.8 },
    },

    -- ========================================
    -- 基础配置
    -- ========================================
    font = {
        path = GLOBAL_FONT,
        headerSize = 22, subHeaderSize = 17, normalSize = 14, 
        labelSize = 20, contentSize = 17, changelogTitleSize = 16,
    },
    
    background = { opacity = 0.8, color = { r=0,g=0,b=0 }, borderColor = { r=0,g=0,b=0,a=0.3 }, borderSize = 1 },
    
    buttons = {
        height = { main=40, dialog=35, close=35, class=50 },
        width = { main=250, dialog=140, import=183, export=200, bottomButton1=275, bottomButton2=275, class=270 },
    },
    
    windows = {
        mainFrame = { width=600, height=650, resizable=false },
        importWindow = { width=600, height=650, resizable=false },
        itemImportWindow = { width=600, height=650, resizable=false },
        exportWindow = { width=600, height=650, resizable=false },
        changelogWindow = { width=600, height=650, resizable=false },
        presetWindow = { width=600, height=650, resizable=false },
    },
    
    offsets = {
        titleBarY = -20, subTitleY = -50, subTitleColor = {r=1,g=1,b=1},
        mainTabGroup = { top=-65, bottom=90, left=25, right=-25 },
        mainTabContent = { top=-45, left=25 },
        mainBottomButtons = { left=25, right=-25, bottom=25, spacing=0 },
        mainFunctionButtons = { spacing=0, align="CENTER" },
        importWindow = { editBox={top=-80,bottom=70,left=30,right=-10}, label={top=5,left=5}, buttons={bottom=25,left=30,right=-15} },
        exportWindow = { editBox={top=-60,bottom=70,left=15,right=-15}, closeButton={left=200,right=-15,bottom=25} },
        changelogWindow = { scrollBox={top=-60,bottom=70,left=25,right=-25}, topSpacer=50, title={offsetX=0,offsetY=-30}, content={offsetX=15,offsetY=-60}, buttons={height=55,width=140,spacing=0,left=25,right=-25,bottom=25} },
        presetWindow = { scrollBox={top=-60,bottom=70,left=30,right=-15}, classButtons={spacing=0,left=0,right=-15}, closeButton={left=200,right=-15,bottom=25} },
    },
    
    changelog = { suffix=" 更新日志", useClassColor=true, fallbackColor={r=0.1,g=0.7,b=1.0} },
    statusBar = { show=false },

    -- ========================================
    -- 动作条 1 (消耗品) - 放在头像上方
    -- ========================================
    consumableBar = {
        enabled = false,  -- [开关] 是否启用消耗品动作条
        anchor = "CENTER",

        -- [修改] 增加默认坐标配置 (取整自 SavedVariables)
        defaultPosition = { x = -288, y = -328 },

        layout = "HORIZONTAL",

        -- [修改] 样式与法术条(bar2)保持一致
        buttonWidth = 31,
        buttonHeight = 28,
        spacing = 1,

        maxButtons = 12,

        -- [层级设置] 控制框体显示层级，避免被其他UI遮挡
        -- 可选值: "BACKGROUND"(最低), "LOW", "MEDIUM"(默认), "HIGH", "DIALOG"(最高)
        frameStrata = "HIGH",
        frameLevel = 100,  -- 相对层级，数值越大越靠前

        unlock = { bgColor={r=0,g=0,b=0,a=0.8}, borderColor={r=0,g=0,b=0,a=1} },
        unlockUI = {
            width=210, height=160, offsetY=-100, bgOpacity=0.9, titleFontSize=18,
            buttons={width=80,height=25,spacing=10,offsetY=-55},
            coordLabels={xLabelY=-95,yLabelY=-115},
            arrows={centerX=140,centerY=-85,buttonSize=30,spacing=5},
        },
    },

    -- ========================================
    -- 动作条 2 (法术/传送门) - 放在小地图下方
    -- ========================================
    spellBar = {
        enabled = true,  -- [开关] 是否启用法术动作条
        classRestriction = "MAGE",  -- [职业限制] 只有法师才加载此动作条
        anchor = "TOPRIGHT",

        -- [修改] 增加默认坐标配置 (取整自 SavedVariables)
        defaultPosition = { x = -150, y = -218 },

        layout = "VERTICAL",

        buttonWidth = 34,
        buttonHeight = 34,
        spacing = 1,
        maxButtons = 12,

        -- [层级设置] 控制框体显示层级，避免被其他UI遮挡
        -- 可选值: "BACKGROUND"(最低), "LOW", "MEDIUM"(默认), "HIGH", "DIALOG"(最高)
        frameStrata = "MEDIUM",
        frameLevel = 100,  -- 相对层级，数值越大越靠前

        unlock = { bgColor={r=0,g=0,b=0,a=0.8}, borderColor={r=0,g=0,b=0,a=1} },

        texts = {
            -- [文本1] 顶部文字 (传送门材料数量)
            top = {
                font=GLOBAL_FONT,
                size=12,
                flags="OUTLINE",
                point="TOP",
                x=1, y=-3, -- [Fix] 向右微调
                color={r=1,g=1,b=1}
            },

            -- [文本2] 底部文字 (例如 "达拉", "奥格")
            bottom = {
                font=GLOBAL_FONT,
                size=15,
                flags="OUTLINE",
                point="CENTER",
                x=1, y=-9,
                color={r=1,g=1,b=1}
            },
        },
    },
    
}

_G.RURUTIA_SUITE_CONFIG = RURUTIA_SUITE_CONFIG
ns.Config = RURUTIA_SUITE_CONFIG
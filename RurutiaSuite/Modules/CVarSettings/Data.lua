-- ============================================================
-- Modules\CVarSettings\Data.lua
-- CVAR配置数据定义
-- ============================================================

local _, ns = ...
-- 安全的本地化处理
local L = LibStub("AceLocale-3.0"):GetLocale("RurutiaSuite", true) 
if not L then
    L = setmetatable({}, { __index = function(t, k) return k end })
end

-- CVAR预设配置
local CVarPresets = {}

-- CVAR元数据 - 用于UI显示和验证
local CVarMetadata = {
    -- 镜头相关
    cameraDistanceMaxZoomFactor = {
        name = "最远视距",
        description = "控制镜头的最大缩放距离",
        category = "camera",
        type = "range",
        min = 1,
        max = 3.4,
        step = 0.1,
        default = 3.4
    },
    
    -- 界面相关
    nameplateMaxDistance = {
        name = "姓名板距离",
        description = "姓名板的最大显示距离",
        category = "interface",
        type = "select",
        options = {20, 41},
        optionNames = {"标准 (20码)", "扩展 (41码)"},
        default = 41
    },
    
    alwaysCompareItems = {
        name = "装备自动对比",
        description = "鼠标悬停在装备上时自动对比属性",
        category = "interface",
        type = "toggle",
        default = 1
    },
    
    chatClassColorOverride = {
        name = "聊天框职业色",
        description = "在聊天框中显示职业颜色",
        category = "interface",
        type = "toggle",
        default = 0
    },
    
    equipmentManager = {
        name = "装备管理",
        description = "启用系统自带的装备管理功能",
        category = "interface",
        type = "toggle",
        default = 1
    },
    
    -- 视觉效果
    ffxDeath = {
        name = "死亡特效",
        description = "角色死亡时的视觉特效",
        category = "effects",
        type = "toggle",
        default = 0
    },
    
    ffxGlow = {
        name = "全屏幕泛光",
        description = "全屏幕的光晕效果",
        category = "effects",
        type = "toggle",
        default = 0
    },
    
    violenceLevel = {
        name = "暴力等级",
        description = "血液和暴力效果的强度",
        category = "effects",
        type = "range",
        min = 0,
        max = 5,
        step = 1,
        optionNames = {"无", "最小", "低", "中", "高", "最大"},
        default = 2
    },
    
    weatherdensity = {
        name = "天气密度",
        description = "天气效果的密度和强度",
        category = "environment",
        type = "range",
        min = 0,
        max = 3,
        step = 1,
        optionNames = {"关闭", "低", "中", "高"},
        default = 1
    },
    
    -- 战斗相关
    floatingCombatTextCombatDamage = {
        name = "伤害数字",
        description = "显示战斗伤害数字",
        category = "combat",
        type = "toggle",
        default = 1
    },
    
    -- 调试相关
    scriptErrors = {
        name = "Lua错误显示",
        description = "是否显示Lua脚本错误",
        category = "debug",
        type = "toggle",
        default = 0
    },

    -- 法术特效
    spellActivationOverlayOpacity = {
        name = "法术警报透明度",
        description = "控制法术触发提示（如冰冷手指、节能施法等）的透明度",
        category = "combat",
        type = "range",
        min = 0,
        max = 1,
        step = 0.1,
        default = 0
    },

    lossOfControl = {
        name = "禁用失控警报",
        description = "关闭系统失控警报提示",
        category = "combat",
        type = "toggle",
        default = 0
    }
}

local _, _, _, tocVersion = GetBuildInfo()
tocVersion = tonumber(tocVersion) or 0
if tocVersion >= 30000 and tocVersion < 40000 then
    CVarMetadata.spellActivationOverlayOpacity = nil
end

do
    local supported = false
    if tocVersion >= 40000 then
        local ok = pcall(GetCVar, "lossOfControl")
        supported = ok and (GetCVar("lossOfControl") ~= nil)
    end
    if not supported then
        CVarMetadata.lossOfControl = nil
    end
end

-- 配置分类定义
local ConfigCategories = {
    camera = {
        name = "镜头设置",
        description = "镜头和视角相关设置",
        order = 1
    },
    interface = {
        name = "界面设置",
        description = "用户界面相关设置",
        order = 2
    },
    effects = {
        name = "视觉效果",
        description = "视觉特效相关设置",
        order = 3
    },
    environment = {
        name = "环境效果",
        description = "环境和天气相关设置",
        order = 4
    },
    combat = {
        name = "战斗设置",
        description = "战斗相关设置",
        order = 5
    },
    debug = {
        name = "调试设置",
        description = "调试和开发相关设置",
        order = 6
    }
}

-- 性能影响评估
local PerformanceImpact = {
    low = { -- 影响极小，可放心使用
        "cameraDistanceMaxZoomFactor",
        "nameplateMaxDistance",
        "chatClassColorOverride",
        "alwaysCompareItems",
        "equipmentManager",
        "lossOfControl"
    },
    medium = { -- 中等影响，根据需求选择
        "floatingCombatTextCombatDamage",
        "violenceLevel"
    },
    high = { -- 高影响，谨慎使用
        "ffxDeath",
        "ffxGlow",
        "weatherdensity"
    }
}

-- [Fix] 初始化基础预设配置
CVarPresets.rurutia = {}
for cvar, data in pairs(CVarMetadata) do
    if data.default ~= nil then
        CVarPresets.rurutia[cvar] = data.default
    end
end

-- 数据验证函数
local function ValidateSetting(cvar, value)
    local metadata = CVarMetadata[cvar]
    if not metadata then
        return false, "未知的CVAR: " .. cvar
    end
    
    if metadata.type == "toggle" then
        if value ~= "0" and value ~= "1" then
            return false, string.format("开关类型CVAR %s 的值必须是 0 或 1，当前值: %s", cvar, value)
        end
    elseif metadata.type == "range" then
        local numValue = tonumber(value)
        if not numValue then
            return false, string.format("范围类型CVAR %s 的值必须是数字，当前值: %s", cvar, value)
        end
        if numValue < metadata.min or numValue > metadata.max then
            return false, string.format("CVAR %s 的值超出范围 [%s, %s]，当前值: %s", 
                cvar, metadata.min, metadata.max, value)
        end
    elseif metadata.type == "select" then
        local valid = false
        for _, option in ipairs(metadata.options) do
            if tostring(value) == tostring(option) then
                valid = true
                break
            end
        end
        if not valid then
            return false, string.format("选择类型CVAR %s 的值不在有效选项中，当前值: %s", cvar, value)
        end
    end
    
    return true
end

-- 获取配置影响等级
local function GetPerformanceImpact(cvar)
    for level, cvars in pairs(PerformanceImpact) do
        for _, cvarName in ipairs(cvars) do
            if cvarName == cvar then
                return level
            end
        end
    end
    return "low" -- 默认低影响
end

-- 获取分类配置
local function GetSettingsByCategory(category)
    local settings = {}
    for cvar, metadata in pairs(CVarMetadata) do
        if metadata.category == category then
            settings[cvar] = metadata
        end
    end
    return settings
end

-- 数据导出
local Data = {
    presets = CVarPresets,
    metadata = CVarMetadata,
    categories = ConfigCategories,
    performance = PerformanceImpact,
    
    -- 工具函数
    validate = ValidateSetting,
    getImpact = GetPerformanceImpact,
    getByCategory = GetSettingsByCategory,
    
    -- 预设名称本地化
    presetNames = {
        rurutia = L["露露推荐"] or "露露推荐"
    }
}

-- 导出到模块命名空间
local _, ns = ...
if ns.Modules and ns.Modules.CVarSettings then
    ns.Modules.CVarSettings.Data = Data
    ns.Modules.CVarSettings.DEFAULT_PRESET = CVarPresets.rurutia
    ns.Modules.CVarSettings.METADATA = CVarMetadata
end

return Data

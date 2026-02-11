-- ============================================================
-- Modules\CVarSettings\Core.lua
-- CVAR设置模块 - 极简优雅实现
-- ============================================================

local addonName, ns = ...
local RS = ns.RS
-- 安全的本地化处理
local L = LibStub("AceLocale-3.0"):GetLocale("RurutiaSuite", true)
if not L then
    L = setmetatable({}, { __index = function(t, k) return k end })
end

-- 确保模块命名空间存在
ns.Modules = ns.Modules or {}

-- 创建模块 - 极简设计，仅依赖必要组件
local CVarSettings = RS:NewModule("CVarSettings", "AceEvent-3.0")
ns.Modules.CVarSettings = CVarSettings

-- 模块常量定义
local MODULE_NAME = "CVarSettings"
local MODULE_VERSION = "1.0.0"

local _, _, _, tocVersion = GetBuildInfo()
tocVersion = tonumber(tocVersion) or 0
local IS_WLK_TOC = (tocVersion >= 30000 and tocVersion < 40000)
local IS_LOSS_OF_CONTROL_SUPPORTED = false
if (not IS_WLK_TOC) and tocVersion >= 40000 then
    local ok = pcall(GetCVar, "lossOfControl")
    IS_LOSS_OF_CONTROL_SUPPORTED = ok and (GetCVar("lossOfControl") ~= nil)
end

-- 默认数据库配置
local defaults = {
    profile = {
        enabled = true,            -- [New] 模块启用状态
        customSettings = {},       -- 用户自定义设置
        autoApply = true,          -- 登录时自动应用
        notifyOnApply = false,     -- 应用时是否通知
        smartApply = true          -- 仅应用变更的设置
    }
}

function CVarSettings:Toggle(value)
    value = value and true or false
    self.db.profile.enabled = value
    if value then
        if not self:IsEnabled() then
            self:Enable()
        end
    else
        if self:IsEnabled() then
            self:Disable()
        end
    end
end

-- ============================================================
-- 模块生命周期函数
-- ============================================================

function CVarSettings:OnInitialize()
    -- 初始化数据库
    self.db = RS.db:RegisterNamespace(MODULE_NAME, defaults)
    
    -- 注册配置界面（延迟加载）
    self:RegisterOptions()
    
    self:PrintDebug("模块初始化完成")
end

function CVarSettings:OnEnable()
    if not self.db.profile.enabled then return end

    if self.db.profile.autoApply then
        -- 注册登录事件，仅执行一次
        self:RegisterEvent("PLAYER_ENTERING_WORLD")
        
        -- 如果已经登录，立即应用
        if IsLoggedIn() then
            self:ApplyCurrentSettings()
        end
    end
    
    self:PrintDebug("模块已启用")
end

function CVarSettings:OnDisable()
    -- 清理事件注册
    self:UnregisterAllEvents()
    
    self:PrintDebug("模块已禁用")
end

-- ============================================================
-- 核心功能函数
-- ============================================================

-- 获取当前设置（基准 + 自定义）
function CVarSettings:GetCurrentSettings()
    -- 1. 获取基准配置 (露露推荐)
    local settings = {}
    if self.Data and self.Data.presets and self.Data.presets["rurutia"] then
        -- 显式复制基准配置
        for k, v in pairs(self.Data.presets["rurutia"]) do
            settings[k] = v
        end
    end
    
    -- 2. 合并用户自定义配置 (覆盖基准)
    local custom = self.db.profile.customSettings
    for k, v in pairs(custom) do
        if not (IS_WLK_TOC and k == "spellActivationOverlayOpacity") and (IS_LOSS_OF_CONTROL_SUPPORTED or k ~= "lossOfControl") then
            settings[k] = v
        end
    end

    if IS_WLK_TOC then
        settings.spellActivationOverlayOpacity = nil
    end

    if not IS_LOSS_OF_CONTROL_SUPPORTED then
        settings.lossOfControl = nil
    end
    
    return settings
end

-- 获取预设配置 (仅保留基准获取)
function CVarSettings:GetBaseSettings()
    if self.Data and self.Data.presets then
        return self.Data.presets["rurutia"]
    end
    return {}
end

-- 应用设置到游戏
function CVarSettings:ApplySettings(settings)
    if not self.db.profile.enabled then return 0 end

    if not settings or not next(settings) then
        return 0
    end
    
    local appliedCount = 0
    
    if self.db.profile.smartApply then
        -- 智能应用：仅应用变更的设置
        for cvar, newValue in pairs(settings) do
            if not (IS_WLK_TOC and cvar == "spellActivationOverlayOpacity") and (IS_LOSS_OF_CONTROL_SUPPORTED or cvar ~= "lossOfControl") then
                local currentValue = GetCVar(cvar)
                if tostring(currentValue) ~= tostring(newValue) then
                    if pcall(GetCVar, cvar) then
                        SetCVar(cvar, tostring(newValue))
                        appliedCount = appliedCount + 1
                        self:PrintDebug("应用 %s = %s (原值: %s)", cvar, newValue, currentValue)
                    else
                        self:PrintDebug("跳过未知CVAR: %s", cvar)
                    end
                end
            end
        end
    else
        -- 全量应用：应用所有设置
        for cvar, value in pairs(settings) do
            if not (IS_WLK_TOC and cvar == "spellActivationOverlayOpacity") and (IS_LOSS_OF_CONTROL_SUPPORTED or cvar ~= "lossOfControl") then
                if pcall(GetCVar, cvar) then
                    SetCVar(cvar, tostring(value))
                    appliedCount = appliedCount + 1
                end
            end
        end
    end
    
    return appliedCount
end

-- 应用当前配置
function CVarSettings:ApplyCurrentSettings()
    local settings = self:GetCurrentSettings()
    local applied = self:ApplySettings(settings)
    
    if applied > 0 and self.db.profile.notifyOnApply then
        self:Print("已应用 %d 项CVAR设置", applied)
    end
    
    self:PrintDebug("配置应用完成，共 %d 项", applied)
    return applied
end

-- 加载并应用预设 (Deprecated but kept for safety/refactor, redirected to ApplyCurrent)
function CVarSettings:LoadAndApplyPreset(presetName)
    -- 忽略 presetName，直接应用当前混合配置
    self:ApplyCurrentSettings()
end

-- ============================================================
-- 事件处理函数
-- ============================================================

function CVarSettings:PLAYER_ENTERING_WORLD()
    -- 登录时应用配置，执行一次后立即注销事件
    self:ApplyCurrentSettings()
    
    -- 注销事件，避免重复执行
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    
    self:PrintDebug("登录事件处理完成，事件监听器已注销")
end

-- ============================================================
-- 配置管理函数
-- ============================================================

-- 保存自定义设置
function CVarSettings:SetCustomSetting(cvar, value)
    if not self.db.profile.enabled then return end

    if IS_WLK_TOC and cvar == "spellActivationOverlayOpacity" then
        return
    end

    if (not IS_LOSS_OF_CONTROL_SUPPORTED) and cvar == "lossOfControl" then
        return
    end

    self.db.profile.customSettings[cvar] = tostring(value)
    
    -- 立即应用变更
    if pcall(GetCVar, cvar) then
        SetCVar(cvar, tostring(value))
    end
    
    self:PrintDebug("自定义设置 %s = %s", cvar, value)
end

-- 获取自定义设置
function CVarSettings:GetCustomSetting(cvar)
    return self.db.profile.customSettings[cvar]
end

-- 重置为默认设置
function CVarSettings:ResetToRecommended()
    self.db.profile.customSettings = {}
    
    -- 重新应用 (此时只有基准配置)
    self:ApplyCurrentSettings()
    self:Print("已重置为默认设置")
end

-- ============================================================
-- 配置注册函数
-- ============================================================

function CVarSettings:RegisterOptions()
    local options = {
        name = "CVAR设置",
        type = "group",
        args = {
            general = self:BuildGeneralTab(),
            advanced = self:BuildAdvancedTab()
        }
    }
    
    -- 注册到 AceConfig
    LibStub("AceConfig-3.0"):RegisterOptionsTable("RurutiaSuite_CVarSettings", options)
    
    -- 添加到 RS 设置面板 (需要 Config.lua 支持)
    -- 注意：这里我们假设 RS 已经有了 AceConfigDialog 的集成
    -- 或者是作为独立的设置页面
end

-- ============================================================
-- 界面绘制 (RS主界面集成)
-- ============================================================

function CVarSettings:DrawSettings(container)
    local scroll = RS.UILib:CreateScrollFrame({
        layout = "List",
        parent = container
    })
    
    RS.UILib:AddSpacer(scroll, 10)

    local headerGroup = RS.UILib:CreateSimpleGroup({
        layout = "List",
        fullWidth = true,
        parent = scroll
    })

    RS.UILib:CreateSectionHeader(headerGroup, "自动设置", 10, 5)

    local checkGroup = RS.UILib:CreateSimpleGroup({
        layout = "Flow",
        fullWidth = true,
        parent = headerGroup
    })

    RS.UILib:CreateCheckBox({
        label = L["启用"] or "启用",
        value = self.db.profile.enabled and true or false,
        width = 150,
        onValueChanged = function(_, value)
            self:Toggle(value)
            self:Print("自动设置 %s", value and "|cff00ff00已启用|r" or "|cffff0000已禁用|r")
            if container then
                container:ReleaseChildren()
                self:DrawSettings(container)
            end
        end,
        parent = checkGroup
    })

    RS.UILib:AddSpacer(headerGroup, 15)
    
    local isEnabled = self.db.profile.enabled
    local isDisabled = not isEnabled

    -- ==================== 常用设置 ====================
    RS.UILib:CreateSectionHeader(scroll, "常用设置", 10, 5)
    
    local groupCommon = RS.UILib:CreateSimpleGroup({
        layout = "Flow",
        fullWidth = true,
        parent = scroll
    })
    
    -- 1. 显示伤害数字 (floatingCombatTextCombatDamage)
    RS.UILib:CreateCheckBox({
        label = "显示伤害数字",
        value = (GetCVar("floatingCombatTextCombatDamage") == "1"),
        width = 150,
        disabled = isDisabled,
        onValueChanged = function(widget, value)
            self:SetCustomSetting("floatingCombatTextCombatDamage", value and "1" or "0")
        end,
        parent = groupCommon
    })
    
    -- 2. 装备自动对比 (alwaysCompareItems)
    RS.UILib:CreateCheckBox({
        label = "装备自动对比",
        value = (GetCVar("alwaysCompareItems") == "1"),
        width = 150,
        disabled = isDisabled,
        onValueChanged = function(widget, value)
            self:SetCustomSetting("alwaysCompareItems", value and "1" or "0")
        end,
        parent = groupCommon
    })

    -- 3. 开启装备管理 (equipmentManager)
    RS.UILib:CreateCheckBox({
        label = "开启装备管理",
        value = (GetCVar("equipmentManager") == "1"),
        width = 150,
        disabled = isDisabled,
        onValueChanged = function(widget, value)
            self:SetCustomSetting("equipmentManager", value and "1" or "0")
        end,
        parent = groupCommon
    })
    
    -- 5. 血条距离 (nameplateMaxDistance) - CheckBox 逻辑：选中=41, 未选中=20
    RS.UILib:CreateCheckBox({
        label = "41码血条",
        value = (tonumber(GetCVar("nameplateMaxDistance")) or 0) >= 41,
        width = 150,
        disabled = isDisabled,
        onValueChanged = function(widget, value)
            self:SetCustomSetting("nameplateMaxDistance", value and "41" or "20")
        end,
        parent = groupCommon
    })
    
    -- 6. 聊天框职业色 (chatClassColorOverride) - 0=开启, 1=关闭
    RS.UILib:CreateCheckBox({
        label = "聊天框职业色",
        value = (GetCVar("chatClassColorOverride") == "0"),
        width = 150,
        disabled = isDisabled,
        onValueChanged = function(widget, value)
            self:SetCustomSetting("chatClassColorOverride", value and "0" or "1")
        end,
        parent = groupCommon
    })

    -- 7. 屏蔽Lua错误 (scriptErrors) - 选中(屏蔽)=0, 未选中(显示)=1
    RS.UILib:CreateCheckBox({
        label = "屏蔽Lua错误",
        value = (GetCVar("scriptErrors") == "0"),
        width = 150,
        disabled = isDisabled,
        onValueChanged = function(widget, value)
            self:SetCustomSetting("scriptErrors", value and "0" or "1")
        end,
        parent = groupCommon
    })

    if IS_LOSS_OF_CONTROL_SUPPORTED then
        RS.UILib:CreateCheckBox({
            label = "禁用失控警报",
            value = (GetCVar("lossOfControl") == "0"),
            width = 150,
            disabled = isDisabled,
            onValueChanged = function(_, value)
                self:SetCustomSetting("lossOfControl", value and "0" or "1")
            end,
            parent = groupCommon
        })
    end

    if not IS_WLK_TOC then
        RS.UILib:CreateCheckBox({
            label = "禁用系统法术特效",
            value = (tonumber(GetCVar("spellActivationOverlayOpacity")) or 1) == 0,
            width = 150,
            disabled = isDisabled,
            onValueChanged = function(widget, value)
                self:SetCustomSetting("spellActivationOverlayOpacity", value and "0" or "1")
            end,
            parent = groupCommon
        })
    end

    RS.UILib:AddSpacer(groupCommon, 10) -- 强制换行

    -- 9. 视距 (cameraDistanceMaxZoomFactor) - Slider 1-3.4
    RS.UILib:CreateSlider({
        label = "视距",
        value = tonumber(GetCVar("cameraDistanceMaxZoomFactor")) or 3.4,
        min = 1, max = 3.4, step = 0.1,
        width = 200,
        disabled = isDisabled,
        onValueChanged = function(widget, value)
            self:SetCustomSetting("cameraDistanceMaxZoomFactor", value)
        end,
        parent = groupCommon
    })
    
    
    -- ==================== 画面设置 ====================
    RS.UILib:AddSpacer(scroll, 20)
    RS.UILib:CreateSectionHeader(scroll, "画面设置", 10, 5)
    
    local groupGraphics = RS.UILib:CreateSimpleGroup({
        layout = "Flow",
        fullWidth = true,
        parent = scroll
    })
    
    -- 1. 关闭死亡特效 (ffxDeath) - 选中(关闭)=0, 未选中(开启)=1
    RS.UILib:CreateCheckBox({
        label = "关闭死亡特效",
        value = (GetCVar("ffxDeath") == "0"),
        width = 150,
        disabled = isDisabled,
        onValueChanged = function(widget, value)
            self:SetCustomSetting("ffxDeath", value and "0" or "1")
        end,
        parent = groupGraphics
    })
    
    -- 2. 关闭全屏幕泛光 (ffxGlow) - 选中(关闭)=0, 未选中(开启)=1
    RS.UILib:CreateCheckBox({
        label = "关闭全屏幕泛光",
        value = (GetCVar("ffxGlow") == "0"),
        width = 150,
        disabled = isDisabled,
        onValueChanged = function(widget, value)
            self:SetCustomSetting("ffxGlow", value and "0" or "1")
        end,
        parent = groupGraphics
    })
    
    RS.UILib:AddSpacer(scroll, 10)
    
    -- 3. 天气特效范围 (weatherdensity) Slider 0-3
    local sliderGroup = RS.UILib:CreateSimpleGroup({
        layout = "Flow",
        fullWidth = true,
        parent = scroll
    })

    RS.UILib:CreateSlider({
        label = "天气特效范围",
        value = tonumber(GetCVar("weatherdensity")) or 0,
        min = 0, max = 3, step = 1,
        width = 200,
        disabled = isDisabled,
        onValueChanged = function(widget, value)
            self:SetCustomSetting("weatherdensity", value)
        end,
        parent = sliderGroup
    })
    
    -- 4. 溅血效果调整 (violenceLevel) Slider 0-5
    RS.UILib:CreateSlider({
        label = "溅血效果调整",
        value = tonumber(GetCVar("violenceLevel")) or 2,
        min = 0, max = 5, step = 1,
        width = 200,
        disabled = isDisabled,
        onValueChanged = function(widget, value)
            self:SetCustomSetting("violenceLevel", value)
        end,
        parent = sliderGroup
    })
end

-- 构建配置界面
function CVarSettings:GetOptionsTable()
    return {
        name = L["CVAR设置"] or "CVAR设置",
        type = "group",
        childGroups = "tab",
        args = {
            general = self:BuildGeneralTab(),
            advanced = self:BuildAdvancedTab()
        }
    }
end

-- 常规设置标签页
function CVarSettings:BuildGeneralTab()
    local isDisabled = function() return not self.db.profile.enabled end

    return {
        name = L["常规设置"] or "常规设置",
        type = "group",
        order = 1,
        args = {
            enabled = {
                type = "toggle",
                name = L["启用模块"] or "启用模块",
                get = function() return self.db.profile.enabled end,
                set = function(_, value) 
                    self:Toggle(value)
                end,
                width = "full",
                order = 0
            },

            description = {
                type = "description",
                name = L["一键应用露露的CVAR优化配置，帮助您快速优化游戏体验。"] or "一键应用露露的CVAR优化配置，帮助您快速优化游戏体验。",
                fontSize = "medium",
                order = 1
            },
            
            reset = {
                type = "execute",
                name = L["重置为默认设置"] or "重置为默认设置",
                desc = L["清除所有自定义设置，恢复为默认设置"] or "清除所有自定义设置，恢复为默认设置",
                disabled = isDisabled,
                func = function()
                    self:ResetToRecommended()
                end,
                confirm = true,
                confirmText = L["确定要清除所有自定义设置吗？"] or "确定要清除所有自定义设置吗？",
                width = "full",
                order = 10
            },
            
            options = {
                type = "group",
                name = L["选项"] or "选项",
                inline = true,
                order = 30,
                disabled = isDisabled,
                args = {
                    autoApply = {
                        type = "toggle",
                        name = L["登录时自动应用"] or "登录时自动应用",
                        desc = L["角色登录时自动应用CVAR设置"] or "角色登录时自动应用CVAR设置",
                        get = function() return self.db.profile.autoApply end,
                        set = function(_, value)
                            self.db.profile.autoApply = value and true or false
                            self:Print("自动应用设置%s", value and "|cff00ff00已开启|r" or "|cffff0000已关闭|r")
                            if value and self.db.profile.enabled and self:IsEnabled() and IsLoggedIn() then
                                self:ApplyCurrentSettings()
                            end
                        end,
                        width = "full",
                        order = 1
                    },
                    smartApply = {
                        type = "toggle", 
                        name = L["智能应用"] or "智能应用",
                        desc = L["仅应用与当前值不同的设置，减少系统调用"] or "仅应用与当前值不同的设置，减少系统调用",
                        get = function() return self.db.profile.smartApply end,
                        set = function(_, value) self.db.profile.smartApply = value end,
                        width = "full",
                        order = 2
                    },
                    notifyOnApply = {
                        type = "toggle",
                        name = L["应用时通知"] or "应用时通知",
                        desc = L["应用设置时显示通知消息"] or "应用设置时显示通知消息",
                        get = function() return self.db.profile.notifyOnApply end,
                        set = function(_, value) self.db.profile.notifyOnApply = value end,
                        width = "full",
                        order = 3
                    }
                }
            }
        }
    }
end

-- 高级设置标签页
function CVarSettings:BuildAdvancedTab()
    if not self.Data then return {} end

    local isDisabled = function() return not self.db.profile.enabled end

    local args = {
        description = {
            type = "description",
            name = L["自定义各项CVAR设置。注意：修改此处设置会自动切换到'自定义'方案。"] or "自定义各项CVAR设置。注意：修改此处设置会自动切换到'自定义'方案。",
            fontSize = "medium",
            order = 1
        },
        
        reset = {
            type = "execute",
            name = L["重置为推荐配置"] or "重置为推荐配置",
            desc = L["清除所有自定义设置，恢复为默认推荐配置"] or "清除所有自定义设置，恢复为默认推荐配置",
            disabled = isDisabled,
            func = function()
                self:ResetToRecommended()
            end,
            confirm = true,
            confirmText = L["确定要清除所有自定义设置吗？"] or "确定要清除所有自定义设置吗？",
            order = 5
        }
    }
    
    -- 动态构建分类
    local sortedCategories = {}
    for key, data in pairs(self.Data.categories) do
        table.insert(sortedCategories, {key = key, data = data})
    end
    table.sort(sortedCategories, function(a, b) return a.data.order < b.data.order end)
    
    for _, cat in ipairs(sortedCategories) do
        args[cat.key] = {
            type = "group",
            name = cat.data.name,
            desc = cat.data.description,
            order = 10 + cat.data.order,
            disabled = isDisabled,
            args = self:BuildCategoryOptions(cat.key)
        }
    end
    
    return {
        name = L["高级设置"] or "高级设置",
        type = "group",
        order = 2,
        args = args
    }
end

-- 构建特定分类的选项
function CVarSettings:BuildCategoryOptions(category)
    local args = {}
    
    for cvar, metadata in pairs(self.Data.metadata) do
        if metadata.category == category then
            -- 基础选项属性
            local option = {
                name = metadata.name,
                desc = metadata.description .. (metadata.default and ("\n默认值: " .. metadata.default) or ""),
                order = 10,
                width = "full",
            }
            
            -- 根据类型构建控件
            if metadata.type == "toggle" then
                option.type = "toggle"
                option.get = function() 
                    -- 优先读取自定义设置，否则读取当前CVAR值
                    local val = self:GetCustomSetting(cvar)
                    if cvar == "lossOfControl" then
                        if val then return val == "0" end
                        return GetCVar(cvar) == "0"
                    end
                    if val then return val == "1" end
                    return GetCVar(cvar) == "1"
                end
                option.set = function(_, val) 
                    if cvar == "lossOfControl" then
                        self:SetCustomSetting(cvar, val and "0" or "1")
                        return
                    end
                    self:SetCustomSetting(cvar, val and "1" or "0")
                end
                
            elseif metadata.type == "range" then
                option.type = "range"
                option.min = metadata.min
                option.max = metadata.max
                option.step = metadata.step
                option.get = function() 
                    local val = self:GetCustomSetting(cvar) or GetCVar(cvar)
                    return tonumber(val) or metadata.default
                end
                option.set = function(_, val) 
                    self:SetCustomSetting(cvar, val)
                end
                
            elseif metadata.type == "select" then
                option.type = "select"
                option.values = {}
                for i, v in ipairs(metadata.options) do
                    option.values[v] = metadata.optionNames[i]
                end
                option.get = function() 
                    local val = self:GetCustomSetting(cvar) or GetCVar(cvar)
                    -- 尝试匹配最接近的选项
                    for _, v in ipairs(metadata.options) do
                        if tostring(val) == tostring(v) then
                            return v
                        end
                    end
                    return metadata.default
                end
                option.set = function(_, val) 
                    self:SetCustomSetting(cvar, val)
                end
            end
            
            args[cvar] = option
        end
    end
    
    return args
end

-- ============================================================
-- 工具函数
-- ============================================================

-- 调试输出
function CVarSettings:PrintDebug(msg, ...)
    if RS.db and RS.db.profile and RS.db.profile.debugMode then
        self:Print("[DEBUG] " .. msg, ...)
    end
end

-- 用户通知
function CVarSettings:Print(msg, ...)
    RS:Print(msg, ...)
end

-- ============================================================
-- 模块导出
-- ============================================================

-- 导出模块接口
CVarSettings.MODULE_NAME = MODULE_NAME
CVarSettings.MODULE_VERSION = MODULE_VERSION

return CVarSettings

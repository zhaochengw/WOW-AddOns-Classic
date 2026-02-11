-- ============================================================
-- Modules\AutoMark\Core.lua
-- 自动标记模块 (移植自 RurutiaAutoMark)
-- ============================================================
local addonName, ns = ...
local RS = ns.RS or LibStub("AceAddon-3.0"):GetAddon("RurutiaSuite", true)
if not RS then return end
local Module = RS:NewModule("AutoMark", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0")

-- 颜色定义
local PREFIX = "|cff00ff00[RAM]|r "
local wipe = table.wipe

-- 静态常量
local UNIT_IDS = { "player", "party1", "party2", "party3", "party4" }

-- 复用表 (避免GC)
local t_tanks = {}
local t_heals = {}
local t_logs = {}
local t_managed = {}

-- 默认配置
local defaults = {
    profile = {
        enabled = true,          -- 启用插件
        leaderOnly = false,      -- 仅队长/助理可用
        logLevel = 1,            -- 日志等级: 1=无, 2=简单
        updateDelay = 0.2,       -- 标记延迟（秒）
        -- 标记池 (避免重叠)
        -- 坦克: 2(大饼), 6(方块), 3(菱形)
        tankMarks = { 2, 6, 3 }, 
        -- 治疗: 1(星星), 5(月亮), 4(三角)
        healMarks = { 1, 5, 4 }  
    }
}

function Module:OnInitialize()
    self.db = RS.db:RegisterNamespace("AutoMark", defaults)
    
    -- 注册聊天命令
    self:RegisterChatCommand("ram", "OnChatCommand")
    self:RegisterChatCommand("ramc", "OnChatCommandClear")
end

-- 聊天命令处理 (/ram)
function Module:OnChatCommand(input)
    self:MarkRoles(true, true)
end

-- 聊天命令处理 (/ramc)
function Module:OnChatCommandClear(input)
    self:ClearAllMarks(true)
end


function Module:OnEnable()
    if self.db.profile.enabled then
        self:RegisterEvent("GROUP_ROSTER_UPDATE")
        self:RegisterEvent("PLAYER_ENTERING_WORLD", "GROUP_ROSTER_UPDATE")
    end
end

function Module:OnDisable()
    self:UnregisterAllEvents()
    self:CancelAllTimers()
end

-- =============================================
-- 工具函数
-- =============================================
local function LogSimple(msg, level)
    if (level or 2) >= 2 then
        print(PREFIX .. msg)
    end
end

-- 获取标记图标材质字符串
local function GetMarkIconTexture(index)
    return "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..index..":0|t"
end

-- 获取带职业颜色的名字
local function GetColoredName(unit)
    local name = UnitName(unit)
    if not name then return "Unknown" end
    
    local _, class = UnitClass(unit)
    if class then
        local color = RAID_CLASS_COLORS[class]
        if color then
            return string.format("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, name)
        end
    end
    return name
end

-- =============================================
-- 核心逻辑
-- =============================================
function Module:GetRole(unit)
    if UnitGroupRolesAssigned then
        return UnitGroupRolesAssigned(unit)
    end
    return "NONE"
end

function Module:MarkRoles(forceLog, ignorePermission)
    self.updateTimer = nil -- 清除定时器句柄
    
    local db = self.db.profile
    if not db.enabled then return end
    if not IsInGroup() then return end
    if IsInRaid() then return end -- 仅支持小队
    
    -- 权限检查
    local isLeader = UnitIsGroupLeader("player")
    local isAssist = UnitIsGroupAssistant("player")
    if (not ignorePermission) and db.leaderOnly and not (isLeader or isAssist) then
        return
    end

    -- 重置复用表
    wipe(t_tanks)
    wipe(t_heals)
    wipe(t_logs)

    -- 1. 扫描队伍
    for _, unit in ipairs(UNIT_IDS) do
        if UnitExists(unit) then
            local role = self:GetRole(unit)
            
            if role == "TANK" then
                table.insert(t_tanks, unit)
            elseif role == "HEALER" then
                table.insert(t_heals, unit)
            end
        end
    end
    
    -- 2. 应用/清除标记
    local changesMade = 0
    -- local simpleLogEntries = {} -- 使用 t_logs
    
    local function ApplyMarks(roleUnits, markList)
        for i, unit in ipairs(roleUnits) do
            local mark = markList[i]
            if mark then
                local currentMark = GetRaidTargetIndex(unit)
                if currentMark ~= mark then
                    SetRaidTarget(unit, mark)
                    local name = GetColoredName(unit)
                    table.insert(t_logs, name .. "为" .. GetMarkIconTexture(mark))
                    changesMade = changesMade + 1
                end
            end
        end
    end
    
    ApplyMarks(t_tanks, db.tankMarks)
    ApplyMarks(t_heals, db.healMarks)
    
    -- 3. 清理不再需要的标记
    wipe(t_managed)
    for _, m in ipairs(db.tankMarks) do t_managed[m] = "TANK" end
    for _, m in ipairs(db.healMarks) do t_managed[m] = "HEALER" end
    
    for _, unit in ipairs(UNIT_IDS) do
        if UnitExists(unit) then
            local currentMark = GetRaidTargetIndex(unit)
            if currentMark and t_managed[currentMark] then
                local role = self:GetRole(unit)
                local shouldHaveThisMark = false
                
                if role == "TANK" then
                    for _, tm in ipairs(db.tankMarks) do
                        if currentMark == tm then shouldHaveThisMark = true break end
                    end
                elseif role == "HEALER" then
                    for _, hm in ipairs(db.healMarks) do
                        if currentMark == hm then shouldHaveThisMark = true break end
                    end
                end
                
                if not shouldHaveThisMark then
                    SetRaidTarget(unit, 0)
                    table.insert(t_logs, GetColoredName(unit) .. "清除标记")
                    changesMade = changesMade + 1
                end
            end
        end
    end
    
    if db.logLevel and db.logLevel >= 2 then
        if changesMade > 0 then
            if #t_logs > 0 then
                LogSimple("标记：" .. table.concat(t_logs, "，"), db.logLevel)
            else
                LogSimple("已更新标记", db.logLevel)
            end
        elseif forceLog then
            LogSimple("无可用变更", db.logLevel)
        end
    end
end

function Module:ClearAllMarks(ignorePermission)
    if not IsInGroup() then return end

    local db = self.db.profile
    if db and db.leaderOnly and (not ignorePermission) then
        local isLeader = UnitIsGroupLeader("player")
        local isAssist = UnitIsGroupAssistant("player")
        if not (isLeader or isAssist) then
            return
        end
    end
    
    for _, unit in ipairs(UNIT_IDS) do
        if UnitExists(unit) then
            SetRaidTarget(unit, 0)
        end
    end
end

function Module:GROUP_ROSTER_UPDATE()
    self:RequestUpdate()
end

function Module:RequestUpdate()
    if self.updateTimer then return end
    local delay = self.db.profile.updateDelay or 0.5
    self.updateTimer = self:ScheduleTimer("MarkRoles", delay)
end

-- =============================================
-- 配置接口 (供 Config UI 调用)
-- =============================================

function Module:Toggle(value)
    self.db.profile.enabled = value
    if value then
        self:Enable()
        self:RequestUpdate()
    else
        self:Disable()
    end
end

function Module:SetLeaderOnly(value)
    self.db.profile.leaderOnly = value
    self:RequestUpdate()
end

function Module:SetUpdateDelay(value)
    self.db.profile.updateDelay = value
end

function Module:SetLogLevel(value)
    self.db.profile.logLevel = value
end

function Module:SetTankMark(index, value)
    self.db.profile.tankMarks[index] = value
    self:RequestUpdate()
end

function Module:SetHealMark(index, value)
    self.db.profile.healMarks[index] = value
    self:RequestUpdate()
end

-- 获取标记选项列表 (供 Dropdown 使用)
function Module:GetMarkOptions()
    return {
        "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:16|t 星星",
        "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:16|t 大饼",
        "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:16|t 菱形",
        "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:16|t 三角",
        "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:16|t 月亮",
        "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:16|t 方块",
        "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:16|t 叉叉",
        "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:16|t 骷髅"
    }
end

-- =============================================
-- 界面绘制 (标准化接口)
-- =============================================
function Module:DrawSettings(container)
    local UILib = RS.UILib
    local db = self.db.profile
    
    local scroll = UILib:CreateScrollFrame({
        layout = "List",
        parent = container
    })

    UILib:AddSpacer(scroll, 10)

    -- ========================================
    -- [RS] 自动标记模块 (AutoMark)
    -- ========================================
    local amGroup = UILib:CreateSimpleGroup({
        layout = "List",
        fullWidth = true,
        parent = scroll
    })
    
    UILib:CreateSectionHeader(amGroup, "自动标记 (RurutiaAutoMark)", 10, 5)
    
    -- 1. 基础开关组
    local checkGroup = UILib:CreateSimpleGroup({
        layout = "Flow",
        fullWidth = true,
        parent = amGroup
    })
    
    -- 启用
    UILib:CreateCheckBox({
        label = "启用",
        value = db.enabled,
        width = 150,
        onValueChanged = function(widget, value)
            self:Toggle(value)
        end,
        parent = checkGroup
    })
    
    -- 仅队长
    UILib:CreateCheckBox({
        label = "仅队长",
        value = db.leaderOnly,
        width = 150,
        onValueChanged = function(widget, value)
            self:SetLeaderOnly(value)
        end,
        parent = checkGroup
    })

    -- 提示信息
    UILib:CreateCheckBox({
        label = "提示信息",
        value = (db.logLevel == 2),
        width = 150,
        onValueChanged = function(widget, value)
            self:SetLogLevel(value and 2 or 1)
        end,
        parent = checkGroup
    })
    
    UILib:AddSpacer(amGroup, 25)

    -- 2. 标记偏好组 (下拉菜单)
    local markGroup = UILib:CreateSimpleGroup({
        layout = "List",
        fullWidth = true,
        parent = amGroup
    })
    
    local markOptions = self:GetMarkOptions()
    
    -- 坦克标记
    UILib:CreateDropdown({
        label = "坦克首选",
        width = 150,
        list = markOptions,
        value = db.tankMarks[1],
        onValueChanged = function(widget, value)
                -- 自动设置第二个标记为顺延
                local nextMark = value + 1
                if nextMark > 8 then nextMark = 1 end
                self:SetTankMark(1, value)
                self:SetTankMark(2, nextMark)
        end,
        parent = markGroup
    })
    
    UILib:AddSpacer(markGroup, 10)

    -- 治疗标记
    UILib:CreateDropdown({
        label = "治疗首选",
        width = 150,
        list = markOptions,
        value = db.healMarks[1],
        onValueChanged = function(widget, value)
                local nextMark = value + 1
                if nextMark > 8 then nextMark = 1 end
                self:SetHealMark(1, value)
                self:SetHealMark(2, nextMark)
        end,
        parent = markGroup
    })

    UILib:AddSpacer(amGroup, 40)
    
    -- 3. 功能按钮组
    local btnGroup = UILib:CreateSimpleGroup({
        layout = "Flow",
        fullWidth = true,
        parent = amGroup
    })
    
    UILib:AddHorizontalSpacer(btnGroup, 3)
    
    -- 立刻标记
    UILib:CreateButton({
        text = "立刻标记",
        width = 147,
        height = 35,
        onClick = function()
            self:MarkRoles(true, true)
        end,
        parent = btnGroup
    })
    
    UILib:AddHorizontalSpacer(btnGroup, 25)
    
    -- 清除标记
    UILib:CreateButton({
        text = "清除标记",
        width = 147,
        height = 35,
        onClick = function()
            self:ClearAllMarks(true)
        end,
        parent = btnGroup
    })

    UILib:AddSpacer(amGroup, 40)

    -- 说明文本
    UILib:CreateSectionHeader(amGroup, "常用命令", 0, 5)

    local colorCode = RS:GetThemeColorCode(false)
    
    local commands = {
        { cmd = "/ram", desc = "立刻标记" },
        { cmd = "/ramc", desc = "清除标记" },
    }

    for _, item in ipairs(commands) do
        local line = UILib:CreateSimpleGroup({
            layout = "Flow",
            fullWidth = true,
            parent = amGroup
        })
        
        UILib:AddHorizontalSpacer(line, 3)
        
        local label = UILib:CreateLabel({
            text = colorCode .. item.cmd .. "|r - " .. item.desc,
            fullWidth = false,
            parent = line
        })
        -- 如果 UILib:CreateLabel 返回的 label 支持 SetRelativeWidth，则调用
        if label.SetRelativeWidth then
            label:SetRelativeWidth(0.9)
        end
    end
end

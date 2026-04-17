local addonName, addon = ...
local Manager = CreateFrame("Frame", "快跑兄弟的全职业输出助手", UIParent)

-- ======================== VF_Core 核心代码 ========================
local VF_initCore = nil
local VF_updateNextActionIndex = nil
local p, rt, rp, x, y = "CENTER", UIParent, "CENTER", 235, -210
local w, h = 88, 88
local CoreInitFlag = false
local Core = nil
local NextActionIndex = 1
local SnapshotIndex = 1
local SnapshotCode = 0
local SnapshotBitLen = 4
local ActionList = {}
local SHFMT = nil
local DetectLyr = nil
local TriggerLyr = nil
local CoverLyr = nil
local DataLyr = nil
local BottomLyr = nil
local MouseLocker = nil
local MouseLockerkeepShow = false
local VF_Button = nil
local Daemon = nil


if InCombatLockdown() then
    CoreInitFlag = true
end

local function updateNextActionIndex(index)
    NextActionIndex = index
    if(IsMouselooking() or SpellIsTargeting() or (GetMouseFoci()[1]==nil)) then
        NextActionIndex = 70
        if MouseLocker then
            MouseLocker:SetSize(w, h)
        end
        if (GetMouseFoci()[1]==nil) then 
            MouseLockerkeepShow = false
        end
    else
        if not MouseLockerkeepShow and MouseLocker then
            MouseLocker:SetSize(0, 0)
        end
    end
end
local function showMouseLocker(handle)
    MouseLockerkeepShow = true
    if MouseLocker then
        MouseLocker:SetSize(w, h)
    end
end
local function hideMouseLocker(handle)
    MouseLockerkeepShow = false
    if MouseLocker then
        MouseLocker:SetSize(0, 0)
    end
end
local function showAllLyr(handler)
    if CoverLyr then
        CoverLyr:Show()
    end
    if BottomLyr then
        BottomLyr:Show()
    end
end
local function hideAllLyr(handler, active)
    if CoverLyr then
        CoverLyr:Hide()
    end
    if BottomLyr then
        BottomLyr:Hide()
    end
end

local function encode_SHFMT(index)
    if (index <= #SHFMT) then
        for _, leaf in ipairs(SHFMT) do
            if ActionList[index] and (leaf[1] == ActionList[index][1]) then
                return leaf[2], leaf[3]
            end
        end
    else
        return 255, 8
    end
    -- 如果没有找到匹配的动作，返回默认值
    return 255, 8
end

local function updateBitOffset(self, bitoffset)
    if (bitoffset == 0) then
        SnapshotCode, SnapshotBitLen = encode_SHFMT(NextActionIndex)
        SnapshotIndex = NextActionIndex
    end
    if (bit.band(bit.rshift(SnapshotCode, (SnapshotBitLen - bitoffset) - 1), 1) == 1) then
        if CoverLyr then
            CoverLyr:Show()
        end
    else
        if CoverLyr then
            CoverLyr:Hide()
        end
    end
end

local function feedbackIndex(self, index)
    --if(index ~= SnapshotIndex) then print("feedback error data! index="..index..", SnapshotIndex=",SnapshotIndex) end
    for i, leaf in ipairs(SHFMT) do
        if ActionList[index] and (leaf[1] == ActionList[index][1]) then
            leaf[4] = leaf[4] + 1
            for j = i, 2, -1 do
                if (SHFMT[j][4] > SHFMT[j-1][4]) then
                    SHFMT[j][1], SHFMT[j-1][1] = SHFMT[j-1][1], SHFMT[j][1]
                    SHFMT[j][4], SHFMT[j-1][4] = SHFMT[j-1][4], SHFMT[j][4]
                else
                    break
                end
            end
        end
    end
end


local ExecuteStr = [[
        Core = self
        ActionList = newtable()
        VF_Button = nil
        LastActionIndex = 0
        SnapshotIndex = 0
        DetectLyr = nil
        TriggerLyr = nil
        CoverLyr = nil
        DataLyr = nil
        BottomLyr = nil
        SHFMT = newtable()
        Running = false
        Tick = 0
        BitOffset = 0
        SnapshotCode = 0

        bindAction = [==[
            if ((LastActionIndex ~= SnapshotIndex) and (SnapshotIndex >= 1) and (SnapshotIndex <= #ActionList)) then
                VF_Button:SetAttribute("type", ActionList[SnapshotIndex][2])
                if(ActionList[SnapshotIndex][2] == "macro") then
                    VF_Button:SetAttribute("macrotext", ActionList[SnapshotIndex][3])
                else
                    VF_Button:SetAttribute(ActionList[SnapshotIndex][2], ActionList[SnapshotIndex][3])
                end
                LastActionIndex = SnapshotIndex
            end
        ]==]

        OnTransferStart = [==[
            if not Running then
                Core:Run(showAllLyr)
                Running,Tick,BitOffset,SnapshotCode,LastActionIndex = true,0,0,0,0
                DataLyr:Hide()
                TriggerLyr:Show()
                Daemon:CallMethod("update", 0) 
                Daemon:RegisterAutoHide(0)
            end
        ]==]

        hideAllLyr = [==[ 
            DetectLyr:Hide()
            TriggerLyr:Hide()
            DataLyr:Hide()
            Daemon:CallMethod("hideAllLyr")
        ]==]

        showAllLyr = [==[
            DetectLyr:Show()
            TriggerLyr:Show()
            DataLyr:Show()
            Daemon:CallMethod("showAllLyr")
        ]==]
    ]]

local decode_SHFMT = [[
    if Tick == 0 then
        TriggerLyr:Hide()
        DataLyr:Show()
    elseif Tick == 1 then
        TriggerLyr:Show()
    else
        SnapshotCode = SnapshotCode * 2 + tonumber((SecureCmdOptionParse("[@mouseover,harm]0;1")))
        if BitOffset < 8 then
            BitOffset = BitOffset + 1
            if((BitOffset==8) and (SnapshotCode==255)) then
                VF_Button:SetAttribute("type", nil)
                Running = false
                Core:Run(hideAllLyr)
                return
            else
                for i, leaf in ipairs(SHFMT) do
                    if (leaf[3] == BitOffset) and (leaf[2] == SnapshotCode) then
                        for j, action in ipairs(ActionList) do
                            if action[1] == leaf[1] then
                                SnapshotIndex = j
                                Core:Run(bindAction)
                                break
                            end
                        end
                        leaf[4] = leaf[4] + 1
                        for j = i, 2, -1 do
                            if SHFMT[j][4] > SHFMT[j - 1][4] then
                                SHFMT[j][1], SHFMT[j - 1][1] = SHFMT[j - 1][1], SHFMT[j][1]
                                SHFMT[j][4], SHFMT[j - 1][4] = SHFMT[j - 1][4], SHFMT[j][4]
                            else
                                break
                            end
                        end
                        Daemon:CallMethod("feedback", SnapshotIndex)
                        BitOffset, SnapshotCode = 0, 0
                        break
                    end
                end
            end
        else
            BitOffset, SnapshotCode = 0, 0
        end
        Daemon:CallMethod("update", BitOffset)
        DataLyr:Hide()
    end
    if Running then
        Tick = (Tick + 1) % 3
        Daemon:RegisterAutoHide(0)
    end
]]

local function initCore(list)
    if (CoreInitFlag == true) then
        return
    else
        CoreInitFlag = true
    end
    w, h = addon.config.size.width, addon.config.size.height
    p, rt, rp = addon.config.position.point, addon.config.position.relativeTo, addon.config.position.relativePoint
    x, y = addon.config.position.x, addon.config.position.y
    Core = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
    ActionList = list
    SHFMT = {}
    Core.Execute = SecureHandlerExecute
    Core.WrapScript = function(self, frame, script, preBody, postBody) 
        return SecureHandlerWrapScript(frame, script, self, preBody, postBody) 
    end
    Core.SetFrameRef = SecureHandlerSetFrameRef
    Core:Execute(ExecuteStr)
    
    for i, action in ipairs(ActionList) do
        SHFMT[i] = {}
        SHFMT[i][1], SHFMT[i][4] = action[1], 0
        if (i <= 10) then
            SHFMT[i][2], SHFMT[i][3] = i - 1, 4
        elseif (i <= 22) then
            SHFMT[i][2], SHFMT[i][3] = i + 29, 6
        elseif (i <= 69) then
            SHFMT[i][2], SHFMT[i][3] = i + 184, 8
        else
            break
        end
        Core:Execute(string.format([[local i=%d ActionList[i]=newtable() ActionList[i][1]=%d ActionList[i][2]="%s" ActionList[i][3]=%s]], i, action[1], action[2], ((type(action[3])=="number") and action[3]) or string.format([["%s"]], action[3])))
        Core:Execute(string.format([[local i=%d SHFMT[i]=newtable() SHFMT[i][1]=ActionList[i][1] SHFMT[i][2]=%d SHFMT[i][3]=%d SHFMT[i][4]=0]], i, SHFMT[i][2], SHFMT[i][3]))
    end
    
    
    DetectLyr = CreateFrame("Button","VF_DetectLyr", UIParent, "SecureActionButtonTemplate")
    DetectLyr:EnableMouseMotion(true)
    DetectLyr:SetPropagateMouseMotion(true)
    DetectLyr:SetPassThroughButtons("LeftButton", "RightButton", "MiddleButton", "Button4", "Button5")
    DetectLyr:SetAllPoints()
    DetectLyr:SetFrameStrata("BACKGROUND")
    DetectLyr:SetFrameLevel(100)  -- 降低层级，避免覆盖其他框体
    Core:SetFrameRef("DetectLyr", DetectLyr)
    Core:Execute([[DetectLyr = Core:GetFrameRef("DetectLyr")]])
    Core:WrapScript(DetectLyr, "OnHide", [[Running=false Core:Run(hideAllLyr)]], nil)
    Core:WrapScript(DetectLyr, "OnEnter", [[Core:Run(OnTransferStart) return true,true]],[[Daemon:CallMethod("hideMouseLocker")]])
    Core:WrapScript(DetectLyr, "OnLeave", [[Running=false return true,true]],[[if DetectLyr:IsShown() then Daemon:CallMethod("showMouseLocker") end]])
    
    VF_Button = CreateFrame("Button", "VF_Button", UIParent, "SecureActionButtonTemplate")
    VF_Button:EnableMouse(true)
    VF_Button:SetPropagateMouseMotion(true)
    VF_Button:RegisterForClicks("AnyDown","AnyUp")
    VF_Button:SetPassThroughButtons("RightButton", "MiddleButton", "Button4", "Button5")
    VF_Button:SetPoint(p, rt, rp, x, y)
    VF_Button:SetSize(w, h)
    VF_Button:SetFrameStrata("BACKGROUND")
    VF_Button:SetFrameLevel(1)  -- 确保在最底层，不影响其他框体
    Core:SetFrameRef("VF_Button", VF_Button)
    Core:Execute([[VF_Button = Core:GetFrameRef("VF_Button")]])
    Core:WrapScript(VF_Button, "OnClick", "Core:Run(OnTransferStart)",nil)
    SetOverrideBindingClick(VF_Button, true, addon.config.VFButtonKey, VF_Button:GetName(), "LeftButton")
    
    TriggerLyr = CreateFrame("Button", "VF_TriggerLyr", UIParent, "SecureUnitButtonTemplate")
    TriggerLyr:EnableMouseMotion(true)
    TriggerLyr:SetPropagateMouseMotion(true)
    TriggerLyr:SetPassThroughButtons("LeftButton", "RightButton", "MiddleButton", "Button4", "Button5")
    TriggerLyr:SetFrameStrata("BACKGROUND")
    TriggerLyr:SetFrameLevel(300)
    TriggerLyr:SetAllPoints()
    TriggerLyr:SetAttribute("unit", "raidpet40")
    TriggerLyr:Hide()
    Core:SetFrameRef("TriggerLyr", TriggerLyr)
    Core:Execute([[TriggerLyr = Core:GetFrameRef("TriggerLyr")]])
    
    CoverLyr = CreateFrame("Frame", "VF_CoverLyr", UIParent)
    CoverLyr:EnableMouseMotion(true)
    CoverLyr:SetPropagateMouseMotion(false)
    CoverLyr:SetPassThroughButtons("LeftButton", "RightButton", "MiddleButton", "Button4", "Button5")
    CoverLyr:SetFrameStrata("BACKGROUND")
    CoverLyr:SetFrameLevel(200)
    CoverLyr:SetAllPoints()
    CoverLyr:Hide()
    Core:SetFrameRef("CoverLyr", CoverLyr)
    Core:Execute([[CoverLyr = Core:GetFrameRef("CoverLyr")]])
    
    DataLyr = CreateFrame("Button", "VF_DataLyr", UIParent, "SecureUnitButtonTemplate")
    DataLyr:EnableMouseMotion(true)
    DataLyr:SetPropagateMouseMotion(true)
    DataLyr:SetPassThroughButtons("LeftButton", "RightButton", "MiddleButton", "Button4", "Button5")
    DataLyr:SetFrameStrata("BACKGROUND")
    DataLyr:SetFrameLevel(100)
    DataLyr:SetAllPoints()
    DataLyr:SetAttribute("unit", "target")
    DataLyr:Hide()
    Core:SetFrameRef("DataLyr", DataLyr)
    Core:Execute([[DataLyr = Core:GetFrameRef("DataLyr")]])
    
    BottomLyr = CreateFrame("Frame", "VF_BottomLyr", UIParent)
    BottomLyr:EnableMouse(true)
    BottomLyr:SetPropagateMouseClicks(false)
    BottomLyr:SetPropagateMouseMotion(false)
    BottomLyr:SetPassThroughButtons("RightButton", "MiddleButton", "Button4", "Button5")
    BottomLyr:SetFrameStrata("BACKGROUND")
    BottomLyr:SetFrameLevel(1)
    BottomLyr:SetAllPoints()
    BottomLyr:EnableMouse(false)
    BottomLyr:EnableMouseMotion(true)
    BottomLyr:Hide()
    Core:SetFrameRef("BottomLyr", BottomLyr)
    Core:Execute([[BottomLyr = Core:GetFrameRef("BottomLyr")]])
    
    MouseLocker = CreateFrame("Frame", "VF_MouseLocker", UIParent)
    MouseLocker:SetFrameLevel(1)  -- 降低层级，避免覆盖其他框体
    MouseLocker:SetPoint(p, rt, rp, x, y)
    MouseLocker:SetSize(w, h)
    MouseLocker:EnableMouse(false)
    MouseLocker.txt = MouseLocker:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    MouseLocker.txt:SetAllPoints()
    MouseLocker.txt:SetFont((MouseLocker.txt:GetFont()), w/3, "OUTLINE")
    MouseLocker.txt:SetText("锁定")
    MouseLocker:Hide()
    
    Daemon = CreateFrame("Button", "VF_Daemon", UIParent, "SecureActionButtonTemplate")
    Daemon:EnableMouse(false)
    Daemon:SetAllPoints()
    Daemon:SetFrameLevel(500)  -- 降低层级，避免覆盖其他框体
    Daemon:Hide()
    Daemon.update = updateBitOffset
    Daemon.feedback = feedbackIndex
    Daemon.showMouseLocker = showMouseLocker
    Daemon.hideMouseLocker = hideMouseLocker
    Daemon.showAllLyr = showAllLyr
    Daemon.hideAllLyr = hideAllLyr
    Core:SetFrameRef("Daemon", Daemon)
    Core:Execute([[Daemon = Core:GetFrameRef("Daemon")]])
    
    Core:WrapScript(_G["SecureHoverDriverManager"], "OnHide", "return Running,true", decode_SHFMT)
    RegisterStateDriver(DetectLyr, "visibility", "[@target,harm,exists,nodead] show;hide")
    RegisterStateDriver(VF_Button, "visibility", "[@target,harm,exists,nodead] show;hide")
    RegisterStateDriver(MouseLocker, "visibility", "[@target,harm,exists,nodead] show;hide")
    
end
VF_initCore = initCore
VF_updateNextActionIndex = updateNextActionIndex

-- ======================== 配置保存/加载 =======================

-- ======================== 配置保存/加载 =======================
local SavedConfig = {}
local CONFIG_VERSION = 2.0

local function LoadConfig()
    if KP_Hekili_Assistant_SavedConfig and KP_Hekili_Assistant_SavedConfig.version == CONFIG_VERSION then
        SavedConfig = KP_Hekili_Assistant_SavedConfig
        -- 将保存的配置应用到addon.config
        for k, v in pairs(SavedConfig) do
            if k ~= "version" then
                if type(addon.config[k]) == "table" and type(v) == "table" then
                    for k2, v2 in pairs(v) do
                        addon.config[k][k2] = v2
                    end
                else
                    addon.config[k] = v
                end
            end
        end
        -- 应用保存的绑定键
        if addon.config.bindingKey then
            addon:SetBindingKey(addon.config.bindingKey)
        end
        -- 更新_ManagerFrame的BindingKey属性
        _ManagerFrame:SetAttribute("BindingKey", addon.config.bindingKey)
        return true
    end
    return false
end

local function SaveConfig()
    -- 从addon.config更新到SavedConfig
    for k, v in pairs(addon.config) do
        if k ~= "version" then
            if type(addon.config[k]) == "table" then
                SavedConfig[k] = SavedConfig[k] or {}
                for k2, v2 in pairs(v) do
                    SavedConfig[k][k2] = v2
                end
            else
                SavedConfig[k] = v
            end
        end
    end
    SavedConfig.version = CONFIG_VERSION
    KP_Hekili_Assistant_SavedConfig = SavedConfig
    DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 配置已保存", 1, 1, 1)
end

-- ======================== 技能列表数据库 =======================
local SkillDB = {}
local DB_VERSION = 1.0

local function LoadSkillDB()
    if KP_Hekili_Assistant_DB and KP_Hekili_Assistant_DB.version == DB_VERSION then
        SkillDB = KP_Hekili_Assistant_DB
        return true
    end
    return false
end

local function SaveSkillDB()
    SkillDB.version = DB_VERSION
    KP_Hekili_Assistant_DB = SkillDB
end

local function GetPlayerSpecialization()
    local playerClass = select(2, UnitClass("player"))
    if playerClass ~= "DRUID" then return nil end
    
    if GetSpecialization then
        local specIndex = GetSpecialization()
        if specIndex then
            return select(2, GetSpecializationInfo(specIndex))
        end
    end
    
    -- Fallback for older versions
    return nil
end

local function GetPlayerSkillList()
    local playerClass = select(2, UnitClass("player")) or "DRUID"
    
    if playerClass == "DRUID" then
        local spec = GetPlayerSpecialization()
        if spec and SkillDB[playerClass] and SkillDB[playerClass][spec] then
            return SkillDB[playerClass][spec]
        elseif not SkillDB[playerClass] then
            SkillDB[playerClass] = {}
        end
        return SkillDB[playerClass]
    else
        if not SkillDB[playerClass] then
            SkillDB[playerClass] = {}
        end
        return SkillDB[playerClass]
    end
end

local function SavePlayerSkillList(skillList)
    local playerClass = select(2, UnitClass("player")) or "DRUID"
    
    if playerClass == "DRUID" then
        local spec = GetPlayerSpecialization()
        if spec then
            if not SkillDB[playerClass] then
                SkillDB[playerClass] = {}
            end
            SkillDB[playerClass][spec] = skillList
        else
            SkillDB[playerClass] = skillList
        end
    else
        SkillDB[playerClass] = skillList
    end
    SaveSkillDB()
end

-- ======================== KP定时器兼容层 =======================
local CTimer = {}

if _KP_GAME_VERSION.isMOP then
    CTimer.After = C_Timer.After
    CTimer.NewTimer = C_Timer.NewTimer
    CTimer.NewTicker = C_Ticker and C_Ticker.NewTicker or C_Timer.NewTicker
else
    local timers = {}
    local tickers = {}
    local nextID = 1
    local timerFrame = CreateFrame("Frame")
    
    timerFrame:SetScript("OnUpdate", function(self, elapsed)
        local now = GetTime()
        
        -- 清理过期定时器
        local expiredTimers = {}
        for id, timer in pairs(timers) do
            if now >= timer.expireTime then
                table.insert(expiredTimers, id)
            end
        end
        for _, id in ipairs(expiredTimers) do
            timers[id].callback()
            timers[id] = nil
        end
        
        local expiredTickers = {}
        for id, ticker in pairs(tickers) do
            if now >= ticker.nextTick then
                ticker.callback()
                ticker.nextTick = now + ticker.interval
            end
            if ticker.cancelled then
                table.insert(expiredTickers, id)
            end
        end
        for _, id in ipairs(expiredTickers) do
            tickers[id] = nil
        end
    end)
    
    function CTimer.After(delay, callback)
        if not callback or type(callback) ~= "function" then return end
        local id = nextID
        nextID = nextID + 1
        timers[id] = {
            expireTime = GetTime() + math.max(0, delay),
            callback = callback
        }
        return { cancel = function() timers[id] = nil end }
    end
    
    function CTimer.NewTimer(delay, callback)
        return CTimer.After(delay, callback)
    end
    
    function CTimer.NewTicker(interval, callback)
        if not callback or type(callback) ~= "function" then return end
        local id = nextID
        nextID = nextID + 1
        tickers[id] = {
            interval = math.max(0.05, interval),
            nextTick = GetTime() + math.max(0.05, interval),
            callback = callback,
            cancelled = false
        }
        return { 
            cancel = function() 
                if tickers[id] then tickers[id].cancelled = true end 
            end 
        }
    end
end

-- ======================== KP核心配置 ========================
-- 定义绑定键变量
local KEY1 = "R"  -- 主绑定键
local KEY2 = "MouseWheelDown"               -- 次绑定键

local defaultConfig = {
    bindingKey = KEY1,
    secondaryBindingKey = KEY2,
    VFButtonKey = KEY1,
    position = {point = "CENTER", relativeTo = UIParent, relativePoint = "CENTER", x = 235, y = -210},
    size = {width = 88, height = 88},
    followHekili = true,
    isFrameLocked = true,
    classSQW = {
        DRUID = {[1] = 200, [2] = 300, [3] = 350, [4] = 400, default = 400},
        WARRIOR = {[1] = 250, [2] = 250, [3] = 350, default = 300},
        PALADIN = {[1] = 250, [2] = 350, [3] = 400, default = 350},
        HUNTER = {default = 300},
        ROGUE = {default = 200},
        MAGE = {default = 350},
        WARLOCK = {default = 350},
        PRIEST = {[1] = 350, [2] = 400, [3] = 400, default = 400},
        SHAMAN = {[1] = 350, [2] = 250, [3] = 400, default = 350},
        DEATHKNIGHT = {[1] = 250, [2] = 250, [3] = 250, default = 250},
        MONK = {[1] = 250, [2] = 250, [3] = 250, default = 250},
        default = 400
    },
    -- 如果你有工程专业，希望跟随HEKILI的推荐应用手套，请在下边编辑工程手套的名字。
    gloveNames = {
        "厄运皮护手","塞纳里奥手铠","诺达希尔手甲","灼热之握","古代熔火皮手套","诺达希尔护手","太阳之王的护手","塞纳里奥指套",
        "愤怒火花手套","远古智慧之树皮手套","亵渎者护手","北境手套","烈焰守卫护手","神使护手","预言裹手","眠火手套","法纹手套",
        "裂隙追猎者护手","提瑞斯法手套",
    }
}

-- 初始化配置
addon.config = CopyTable(defaultConfig)
LoadConfig()  -- LoadConfig函数已经将配置应用到addon.config，不需要重复应用

-- 解析位置参数
local p = addon.config.position.point
local rt = addon.config.position.relativeTo
local rp = addon.config.position.relativePoint
local x = addon.config.position.x
local y = addon.config.position.y
local w = addon.config.size.width
local h = addon.config.size.height

-- ======================== KP全局变量初始化 =======================
local currentActionList = {}
local currentDisplayIndex = 1
local HekiliSpellID = 0
local CoverLyrs = {}
local CheckLyrs = {}
local deepest = 1
local lastdeepest = 100
local isFrameLocked = addon.config.isFrameLocked
local updateTicker = nil

-- ======================== KP覆盖层更新 ========================
local function updateCoverStat(index)
    if not CoverLyrs or #CoverLyrs == 0 then return end
    local total = #currentActionList
    local processed = 0 
    
    local function updateChunk()
        for i = 1, 3 do  
            if processed >= total then 
                return 
            end 
            local idx = total - processed 
            if CoverLyrs[idx] then
                local size = (idx < index) and w or 0
                CoverLyrs[idx]:SetSize(size, size)
            end
            processed = processed + 1 
        end 
        if processed < total then 
            CTimer.After(0.01, updateChunk)
        end 
    end 
    updateChunk()
end

-- ======================== KP安全框架逻辑 ========================
local _ManagerFrame = CreateFrame("Frame", "SafeFrameManager", UIParent, "SecureHandlerStateTemplate")
_ManagerFrame.Execute = SecureHandlerExecute
_ManagerFrame.WrapScript = function(self, frame, script, preBody, postBody) 
    return SecureHandlerWrapScript(frame, script, self, preBody, postBody) 
end
_ManagerFrame.SetFrameRef = SecureHandlerSetFrameRef
_ManagerFrame:SetAttribute("BindingKey", addon.config.bindingKey)

_ManagerFrame:Execute([[
    Manager = self
    ActionType = newtable()
    ActionDetail = newtable()
    BindLyr = nil
    CheckLyrs = newtable()
    deepest = 100
    lastdeepest = 100
    bindingKey = self:GetAttribute("BindingKey")

    onBindLyrClick = [==[
        local button,down = ...
        if down then
        else
            if (lastdeepest == deepest) then
                return
            elseif (deepest >= 1) and (deepest <= #ActionType) then
                local actionType = ActionType[deepest]
                local actionDetail = ActionDetail[deepest]
                
                -- 执行技能
                BindLyr:SetAttribute("type", actionType)
                if(actionType == "macro") then
                    BindLyr:SetAttribute("macrotext", actionDetail)
                else
                    BindLyr:SetAttribute(actionType, actionDetail)
                end
                lastdeepest = deepest
            end
        end
    ]==]

    afterBindLyrClick = [==[
        local message,button,down = ...
        if message then
            if (deepest <= #ActionType) then
                deepest = 100
            end
        end
    ]==]

    onBindLyrShow = [==[
        local currentBindingKey = self:GetAttribute("BindingKey")
        if (currentBindingKey ~= nil) then
            BindLyr:SetBindingClick(true, currentBindingKey, BindLyr:GetName(), "LeftButton")
        end
    ]==]

    onBindLyrHide = [==[
        local currentBindingKey = self:GetAttribute("BindingKey")
        if (currentBindingKey ~= nil) then
            BindLyr:ClearBinding(currentBindingKey)
        end
    ]==]
         
    onCheckLyr = [==[
        local index = ...
        if(deepest > index) then
            deepest = index
        end
    ]==]
]])

-- ======================== KP动态创建技能层 ========================
local function createActionLayers()
    -- 清理旧层
    for i = 1, #CoverLyrs do
        if CoverLyrs[i] then
            CoverLyrs[i]:Hide()
            CoverLyrs[i] = nil
        end
    end
    _ManagerFrame:Execute([[
        ActionType = newtable()
        ActionDetail = newtable()
        CheckLyrs = newtable()
    ]])

    for i, spell in ipairs(currentActionList) do
        local actionType = spell[2]
        local actionDetail = spell[1]
        
        if spell[2] == "item" then
            actionDetail = tostring(spell[1])
        elseif spell[2] == "macro" then
            actionDetail = spell[1] == 6603 and "/startattack" or ""
        end
        
        _ManagerFrame:Execute(string.format([[
            local index = %d 
            ActionType[index]="%s" 
            ActionDetail[index]="%s"
        ]], i, actionType, actionDetail))
        
        local cvr = CreateFrame("Frame", "CoverLyr"..i, UIParent)
        cvr:EnableMouse(true)
        cvr:SetPropagateMouseMotion(false)
        cvr:SetPassThroughButtons("RightButton")
        cvr:SetFrameLevel(i*2+1)
        cvr:SetPoint(p, rt, rp, x, y)
        cvr:SetSize(w, h)
        cvr:Show()
        CoverLyrs[i] = cvr
        
        local chk = CreateFrame("Button", "CheckLyr"..i, UIParent, "SecureActionButtonTemplate")
        _ManagerFrame:SetFrameRef("CheckLyr", chk)
        chk:RegisterForClicks("AnyDown")
        chk:SetPropagateMouseMotion(true)
        chk:SetPassThroughButtons("RightButton")
        chk:SetFrameLevel(i*2)
        chk:SetPoint(p, rt, rp, x, y)
        chk:SetSize(w, h)
        chk:Show()
        
        _ManagerFrame:Execute(string.format([[
            local index = %d 
            CheckLyrs[index] = Manager:GetFrameRef("CheckLyr")
        ]], i))
        _ManagerFrame:WrapScript(chk, "OnClick", string.format([[Manager:Run(onCheckLyr, %d)]], i))
        _ManagerFrame:WrapScript(chk, "OnEnter", string.format([[Manager:Run(onCheckLyr, %d)]], i))
        _ManagerFrame:WrapScript(chk, "OnLeave", string.format([[Manager:Run(onCheckLyr, %d)]], i))
    end
    
    -- 同时更新VF_Core的技能列表
    if VF_initCore then
        -- 转换技能列表格式以适应 VF_Core
        local vfActionList = {}
        for i, spell in ipairs(currentActionList) do
            local actionType = spell[2]
            local actionDetail = spell[1]
            
            if actionType == "item" then
                actionDetail = tostring(spell[1])
            elseif actionType == "macro" then
                actionDetail = spell[1] == 6603 and "/startattack" or ""
            end
            
            table.insert(vfActionList, {spell[1], actionType, actionDetail})
        end
        
        VF_initCore(vfActionList)
        -- 重新应用绑定键，确保VF_Button使用正确的绑定键
        if VF_Button and addon.config.bindingKey then
            ClearOverrideBindings(VF_Button)
            SetOverrideBindingClick(VF_Button, true, addon.config.bindingKey, VF_Button:GetName(), "LeftButton")
            -- 应用次要绑定键到VF_Button
            if addon.config.secondaryBindingKey then
                SetOverrideBindingClick(VF_Button, true, addon.config.secondaryBindingKey, VF_Button:GetName(), "LeftButton")
            end
        end
    end
end

-- ======================== KP绑定层 ========================
local bndlyr = CreateFrame("Button", "BndLyr", UIParent, "SecureActionButtonTemplate")
_ManagerFrame:SetFrameRef("BindLyr", bndlyr)
bndlyr:RegisterForClicks("AnyUp")
bndlyr:SetPropagateMouseMotion(true)
bndlyr:SetPassThroughButtons("RightButton")
bndlyr:SetFrameLevel(100)
bndlyr:SetPoint(p, rt, rp, x, y)
bndlyr:SetSize(w, h)
bndlyr:Show()

-- 绑定事件
_ManagerFrame:Execute([[BindLyr = Manager:GetFrameRef("BindLyr")]])
_ManagerFrame:WrapScript(bndlyr, "OnClick", 
    [[Manager:Run(onBindLyrClick, button, down) return button,true]], 
    [[Manager:Run(afterBindLyrClick, message, button, down)]])
_ManagerFrame:WrapScript(bndlyr, "OnShow", [[Manager:Run(onBindLyrShow)]])
_ManagerFrame:WrapScript(bndlyr, "OnHide", [[Manager:Run(onBindLyrHide)]])

-- 绑定键设置（修复战斗中提示）
function addon:SetBindingKey(newKey, isSecondary)
    if InCombatLockdown() then
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[KP_Hekili_Assistant]|r 战斗中无法修改绑定键", 1, 1, 1)
        return false
    end
    
    -- 验证按键有效性
    if not newKey or newKey == "" then
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[KP_Hekili_Assistant]|r 无效的按键", 1, 1, 1)
        return false
    end
    
    -- 更新配置
    if isSecondary then
        addon.config.secondaryBindingKey = newKey
    else
        addon.config.bindingKey = newKey
        addon.config.VFButtonKey = newKey
    end
    
    -- 清除旧绑定
    ClearOverrideBindings(bndlyr)
    
    -- 应用主绑定键
    local success, errorMsg = pcall(function()
        SetOverrideBindingClick(bndlyr, true, addon.config.bindingKey, bndlyr:GetName(), "LeftButton")
    end)
    
    if not success then
        DEFAULT_CHAT_FRAME:AddMessage("|cffff00ff00[KP_Hekili_Assistant]|r 主绑定键设置失败："..(errorMsg or "未知错误"), 1, 1, 1)
        -- 回退到默认绑定
        SetOverrideBindingClick(bndlyr, true, "MouseWheelDown", bndlyr:GetName(), "LeftButton")
        addon.config.bindingKey = "MouseWheelDown"
        addon.config.VFButtonKey = "MouseWheelDown"
    end
    
    -- 应用次要绑定键
    if addon.config.secondaryBindingKey then
        local secondarySuccess, secondaryErrorMsg = pcall(function()
            SetOverrideBindingClick(bndlyr, true, addon.config.secondaryBindingKey, bndlyr:GetName(), "LeftButton")
        end)
        
        if not secondarySuccess then
            DEFAULT_CHAT_FRAME:AddMessage("|cffff00ff00[KP_Hekili_Assistant]|r 次要绑定键设置失败："..(secondaryErrorMsg or "未知错误"), 1, 1, 1)
            addon.config.secondaryBindingKey = nil
        end
    end
    
    -- 更新 VF_Core 绑定
    if VF_Button then
        ClearOverrideBindings(VF_Button)
        SetOverrideBindingClick(VF_Button, true, addon.config.bindingKey, VF_Button:GetName(), "LeftButton")
        if addon.config.secondaryBindingKey then
            SetOverrideBindingClick(VF_Button, true, addon.config.secondaryBindingKey, VF_Button:GetName(), "LeftButton")
        end
    end
    
    _ManagerFrame:SetAttribute("BindingKey", addon.config.bindingKey)
    SaveConfig()
    
    if isSecondary then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 次要绑定键已修改为："..newKey, 1, 1, 1)
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 主绑定键已修改为："..newKey, 1, 1, 1)
    end
    
    return true
end

-- 初始绑定 (延迟到PLAYER_LOGIN后执行，确保配置已正确加载)
local function applyInitialBinding()
    -- 清除旧绑定
    ClearOverrideBindings(bndlyr)
    -- 应用当前配置的绑定键
    SetOverrideBindingClick(bndlyr, true, addon.config.bindingKey, bndlyr:GetName(), "LeftButton")
    
    -- 应用次要绑定键
    if addon.config.secondaryBindingKey then
        SetOverrideBindingClick(bndlyr, true, addon.config.secondaryBindingKey, bndlyr:GetName(), "LeftButton")
    end
    
    -- 同时更新 VF_Core 绑定
    if VF_Button then
        ClearOverrideBindings(VF_Button)
        SetOverrideBindingClick(VF_Button, true, addon.config.bindingKey, VF_Button:GetName(), "LeftButton")
        -- 应用次要绑定键到VF_Button
        if addon.config.secondaryBindingKey then
            SetOverrideBindingClick(VF_Button, true, addon.config.secondaryBindingKey, VF_Button:GetName(), "LeftButton")
        end
        -- 确保VF_ButtonKey与bindingKey保持一致
        addon.config.VFButtonKey = addon.config.bindingKey
    end
    
    -- 更新 _ManagerFrame 的 BindingKey 属性
    _ManagerFrame:SetAttribute("BindingKey", addon.config.bindingKey)
    
    local bindingText = "初始绑定键设置为：" .. addon.config.bindingKey
    if addon.config.secondaryBindingKey then
        bindingText = bindingText .. "，次要绑定键设置为：" .. addon.config.secondaryBindingKey
    end
    DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r " .. bindingText, 1, 1, 1)
end

-- 注册PLAYER_LOGIN事件时执行初始绑定
local originalOnEvent = Manager:GetScript("OnEvent")
Manager:SetScript("OnEvent", function(self, event, ...)
    if originalOnEvent then
        originalOnEvent(self, event, ...)
    end
    if event == "PLAYER_LOGIN" then
        applyInitialBinding()
    end
end)

-- ======================== KP底部攻击按钮 =======================
local btmbtn = CreateFrame("Button", "BtmBtn", UIParent, "SecureActionButtonTemplate")
btmbtn:RegisterForClicks("AnyDown")
btmbtn:SetPropagateMouseClicks(false)
btmbtn:SetPropagateMouseMotion(false)
btmbtn:SetPassThroughButtons("RightButton")
btmbtn:SetFrameLevel(1)
btmbtn:SetPoint(p, rt, rp, x, y)
btmbtn:SetSize(w, h)
btmbtn:SetAttribute("type", "macro")
btmbtn:SetAttribute("macrotext", "/startattack")
btmbtn:Show()

-- ======================== KP显示框架 =======================
local DisplayFrame = CreateFrame("Frame", "CRH_Display", UIParent)
DisplayFrame:SetSize(w, h)
DisplayFrame:SetPoint(p, rt, rp, x, y)
DisplayFrame:SetFrameStrata("MEDIUM")
DisplayFrame:SetFrameLevel(5)
DisplayFrame:EnableMouse(true)
DisplayFrame:SetPropagateMouseClicks(true)
DisplayFrame:Show()

-- 框体移动控制
local controlDot = CreateFrame("Button", nil, DisplayFrame)
controlDot:SetSize(8, 8)  -- 缩小红点尺寸
controlDot:SetPoint("BOTTOM", DisplayFrame, "TOP", 0, 1)
controlDot:SetFrameLevel(DisplayFrame:GetFrameLevel() + 10)
controlDot:RegisterForClicks("LeftButtonUp", "RightButtonUp")
controlDot:Show()

local dotTexture = controlDot:CreateTexture(nil, "BACKGROUND")
dotTexture:SetAllPoints()
dotTexture:SetColorTexture(isFrameLocked and 1 or 0, isFrameLocked and 0 or 1, 0, 0.8)
controlDot.texture = dotTexture

-- 提示文字
local tooltipTimer
controlDot:SetScript("OnEnter", function(self)
    if InCombatLockdown() then return end
    if tooltipTimer then
        tooltipTimer:cancel()
        tooltipTimer = nil
    end
    tooltipTimer = CTimer.NewTimer(2, function()
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(isFrameLocked and "|cffff0000锁定|r - 点击解锁拖动" or "|cff00ff00解锁|r - 点击锁定位置", 1, 1, 1)
            GameTooltip:AddLine("右键点击：设置绑定键", 0.8, 0.8, 0.8, true)
            GameTooltip:AddLine("提示：拖动框体后自动保存位置", 0.8, 0.8, 0.8, true)
            GameTooltip:Show()
            tooltipTimer = nil
        end)
end)

controlDot:SetScript("OnLeave", function(self)
    if tooltipTimer then
        tooltipTimer:cancel()
        tooltipTimer = nil
    end
    GameTooltip:Hide()
end)

-- 锁定/解锁
local function toggleFrameLock()
    if InCombatLockdown() then
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[KP_Hekili_Assistant]|r 战斗中无法切换锁定状态", 1, 1, 1)
        return
    end
    
    isFrameLocked = not isFrameLocked
    dotTexture:SetColorTexture(isFrameLocked and 1 or 0, isFrameLocked and 0 or 1, 0, 0.8)
    
    addon.config.isFrameLocked = isFrameLocked
    SaveConfig()
    
    DisplayFrame:SetFrameLevel(isFrameLocked and 10 or 1000)  -- 解锁时设置更高的层级，确保能接收鼠标事件
    DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[KP_Hekili_Assistant]|r 框体已" .. (isFrameLocked and "|cffff0000锁定|r" or "|cff00ff00解锁|r"), 1, 1, 1)
end

controlDot:SetScript("OnClick", function(self, button, down)
    if button == "LeftButton" then
        toggleFrameLock()
    elseif button == "RightButton" then
        if InCombatLockdown() then
            DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[KP_Hekili_Assistant]|r 战斗中无法修改绑定键", 1, 1, 1)
            return
        end
        
        -- 测试右键点击
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 右键点击触发", 1, 1, 1)
        
        -- 显示绑定键设置菜单
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 请设置绑定键：", 1, 1, 1)
        
        -- 创建一个背景框体，使控件更加集中
        local backgroundFrame = CreateFrame("Frame", "KP_KeyBindBackground", UIParent, "BackdropTemplate")
        backgroundFrame:SetSize(300, 280)
        backgroundFrame:SetPoint("CENTER", UIParent, "CENTER")
        backgroundFrame:SetBackdrop({
            bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            tile = true,
            tileSize = 32,
            edgeSize = 32,
            insets = {
                left = 11,
                right = 12,
                top = 12,
                bottom = 11
            }
        })
        -- 为背景框体添加拖动功能
        backgroundFrame:EnableMouse(true)
        backgroundFrame:SetMovable(true)
        backgroundFrame:RegisterForDrag("LeftButton")
        backgroundFrame:SetScript("OnDragStart", function(self)
            self:StartMoving()
        end)
        backgroundFrame:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
        end)
        backgroundFrame:Show()
        
        -- 添加插件名称标签
        local titleLabel = backgroundFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        titleLabel:SetPoint("TOP", backgroundFrame, "TOP", 0, -10)
        titleLabel:SetText("KP_Hekili_Assistant")
        titleLabel:Show()
        
        -- 添加作者信息标签
        local authorLabel = backgroundFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        authorLabel:SetPoint("TOP", titleLabel, "BOTTOM", 0, -5)
        authorLabel:SetText("作者：快跑兄弟")
        authorLabel:Show()
                
        -- 创建主绑定键输入框
        local mainEditBox = CreateFrame("EditBox", "KP_MainKeyBindEditBox", backgroundFrame, "InputBoxTemplate")
        mainEditBox:SetSize(200, 30)
        mainEditBox:SetPoint("CENTER", backgroundFrame, "CENTER", 0, 50)
        mainEditBox:SetText(addon.config.bindingKey)
        mainEditBox:Show()
        
        -- 为主绑定键输入框添加拖动功能
        mainEditBox:EnableMouse(true)
        mainEditBox:SetMovable(true)
        mainEditBox:RegisterForDrag("LeftButton")
        mainEditBox:SetScript("OnDragStart", function(self)
            self:StartMoving()
        end)
        mainEditBox:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
        end)
        
        -- 创建主绑定键标签
        local mainLabel = mainEditBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        mainLabel:SetPoint("BOTTOM", mainEditBox, "TOP", 0, 5)
        mainLabel:SetText("主绑定键 (KEY1)")
        mainLabel:Show()
        
        -- 创建次绑定键输入框
        local secondaryEditBox = CreateFrame("EditBox", "KP_SecondaryKeyBindEditBox", backgroundFrame, "InputBoxTemplate")
        secondaryEditBox:SetSize(200, 30)
        secondaryEditBox:SetPoint("CENTER", backgroundFrame, "CENTER", 0, -10)
        secondaryEditBox:SetText(addon.config.secondaryBindingKey or "")
        secondaryEditBox:Show()
        
        -- 为次绑定键输入框添加拖动功能
        secondaryEditBox:EnableMouse(true)
        secondaryEditBox:SetMovable(true)
        secondaryEditBox:RegisterForDrag("LeftButton")
        secondaryEditBox:SetScript("OnDragStart", function(self)
            self:StartMoving()
        end)
        secondaryEditBox:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
        end)
        
        -- 创建次绑定键标签
        local secondaryLabel = secondaryEditBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        secondaryLabel:SetPoint("BOTTOM", secondaryEditBox, "TOP", 0, 5)
        secondaryLabel:SetText("次绑定键 (KEY2)")
        secondaryLabel:Show()
        
        -- 创建确认按钮
        local confirmButton = CreateFrame("Button", "KP_ConfirmButton", backgroundFrame, "UIPanelButtonTemplate")
        confirmButton:SetSize(100, 30)
        confirmButton:SetPoint("RIGHT", backgroundFrame, "CENTER", -10, -60)
        confirmButton:SetText("确认")
        confirmButton:Show()
        
        -- 创建取消按钮
        local cancelButton = CreateFrame("Button", "KP_CancelButton", backgroundFrame, "UIPanelButtonTemplate")
        cancelButton:SetSize(100, 30)
        cancelButton:SetPoint("LEFT", backgroundFrame, "CENTER", 10, -60)
        cancelButton:SetText("取消")
        cancelButton:Show()
        
        -- 隐藏所有控件的函数
        local function hideAllControls()
            if backgroundFrame then
                backgroundFrame:Hide()
                backgroundFrame = nil
            end
            if mainEditBox then
                mainEditBox:Hide()
                mainEditBox = nil
            end
            if secondaryEditBox then
                secondaryEditBox:Hide()
                secondaryEditBox = nil
            end
            if confirmButton then
                confirmButton:Hide()
                confirmButton = nil
            end
            if cancelButton then
                cancelButton:Hide()
                cancelButton = nil
            end
        end
        
        -- 确认按钮点击事件
        confirmButton:SetScript("OnClick", function(self)
            local mainKey = mainEditBox:GetText()
            local secondaryKey = secondaryEditBox:GetText()
            
            -- 设置主绑定键
            if mainKey and mainKey ~= "" then
                local mainSuccess, mainResult = pcall(function()
                    return addon:SetBindingKey(mainKey, false)
                end)
                if not mainSuccess then
                    DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[KP_Hekili_Assistant]|r 主绑定键设置失败：" .. tostring(mainResult), 1, 1, 1)
                end
            end
            
            -- 设置次绑定键
            if secondaryKey and secondaryKey ~= "" then
                local secondarySuccess, secondaryResult = pcall(function()
                    return addon:SetBindingKey(secondaryKey, true)
                end)
                if not secondarySuccess then
                    DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[KP_Hekili_Assistant]|r 次绑定键设置失败：" .. tostring(secondaryResult), 1, 1, 1)
                end
            else
                -- 清除次绑定键
                addon.config.secondaryBindingKey = nil
                -- 重新应用绑定键
                addon:SetBindingKey(addon.config.bindingKey, false)
                DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 次绑定键已清除", 1, 1, 1)
            end
            
            -- 隐藏所有控件
            hideAllControls()
            DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 绑定键设置已完成", 1, 1, 1)
        end)
        
        -- 取消按钮点击事件
        cancelButton:SetScript("OnClick", function(self)
            -- 隐藏所有控件
            hideAllControls()
            DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 取消设置绑定键", 1, 1, 1)
        end)
        
        -- 输入框失去焦点事件
        mainEditBox:SetScript("OnEditFocusLost", function(self)
            -- 隐藏所有控件
            hideAllControls()
            DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 取消设置绑定键", 1, 1, 1)
        end)
        
        secondaryEditBox:SetScript("OnEditFocusLost", function(self)
            -- 隐藏所有控件
            hideAllControls()
            DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 取消设置绑定键", 1, 1, 1)
        end)
    end
end)

-- 拖动功能
local function StartMoving()
    if not InCombatLockdown() and not isFrameLocked then
        -- 确保显示框体是最顶层的
        DisplayFrame:SetFrameStrata("DIALOG")
        DisplayFrame:SetFrameLevel(1000)
        -- 开始移动
        DisplayFrame:StartMoving()
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 开始拖动框体", 1, 1, 1)
    end
end

local function StopMovingOrSizing()
    DisplayFrame:StopMovingOrSizing()
    -- 恢复显示框体的层级
    DisplayFrame:SetFrameStrata("MEDIUM")
    DisplayFrame:SetFrameLevel(isFrameLocked and 10 or 1000)
    DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 停止拖动框体", 1, 1, 1)
    
    local point, relativeTo, relativePoint, xOfs, yOfs = DisplayFrame:GetPoint()
    addon.config.position.point = point
    addon.config.position.relativeTo = relativeTo
    addon.config.position.relativePoint = relativePoint
    addon.config.position.x = xOfs
    addon.config.position.y = yOfs
    
    local p, rt, rp = point, relativeTo, relativePoint
    local x, y = xOfs, yOfs
    
    if bndlyr then
        bndlyr:ClearAllPoints()
        bndlyr:SetPoint(p, rt, rp, x, y)
    end
    
    if btmbtn then
        btmbtn:ClearAllPoints()
        btmbtn:SetPoint(p, rt, rp, x, y)
    end
    
    if CoverLyrs then
        for i, cvr in ipairs(CoverLyrs) do
            cvr:ClearAllPoints()
            cvr:SetPoint(p, rt, rp, x, y)
        end
    end
    
    if _ManagerFrame then
        _ManagerFrame:Execute(string.format([[
            for i, chk in ipairs(CheckLyrs) do
                chk:ClearAllPoints()
                chk:SetPoint("%s", UIParent, "%s", %d, %d)
            end
        ]], point, relativePoint, xOfs, yOfs))
    end
    
    SaveConfig()
    DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 框体位置已保存", 1, 1, 1)
end

-- 确保显示框体能够接收鼠标事件
DisplayFrame:EnableMouse(true)
DisplayFrame:SetMovable(true)
DisplayFrame:RegisterForDrag("LeftButton")
DisplayFrame:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" and not InCombatLockdown() and not isFrameLocked then
        self:StartMoving()
    end
end)
DisplayFrame:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" and not InCombatLockdown() and not isFrameLocked then
        self:StopMovingOrSizing()
        -- 保存位置
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
        addon.config.position.point = point
        addon.config.position.relativeTo = relativeTo
        addon.config.position.relativePoint = relativePoint
        addon.config.position.x = xOfs
        addon.config.position.y = yOfs
        
        local p, rt, rp = point, relativeTo, relativePoint
        local x, y = xOfs, yOfs
        
        if bndlyr then
            bndlyr:ClearAllPoints()
            bndlyr:SetPoint(p, rt, rp, x, y)
        end
        
        if btmbtn then
            btmbtn:ClearAllPoints()
            btmbtn:SetPoint(p, rt, rp, x, y)
        end
        
        if CoverLyrs then
            for i, cvr in ipairs(CoverLyrs) do
                cvr:ClearAllPoints()
                cvr:SetPoint(p, rt, rp, x, y)
            end
        end
        
        if _ManagerFrame then
            _ManagerFrame:Execute(string.format([[
                for i, chk in ipairs(CheckLyrs) do
                    chk:ClearAllPoints()
                    chk:SetPoint("%s", UIParent, "%s", %d, %d)
                end
            ]], point, relativePoint, xOfs, yOfs))
        end
        
        SaveConfig()
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 框体位置已保存", 1, 1, 1)
    end
end)
DisplayFrame:SetScript("OnDragStart", StartMoving)
DisplayFrame:SetScript("OnDragStop", StopMovingOrSizing)

-- 技能图标
DisplayFrame.texture = DisplayFrame:CreateTexture(nil, "ARTWORK")
DisplayFrame.texture:SetAllPoints()
DisplayFrame.texture:SetTexture(GetSpellTexture(6603) or "Interface\\Icons\\INV_Misc_QuestionMark")
DisplayFrame.texture:SetMouseClickEnabled(false)
DisplayFrame.texture:SetMouseMotionEnabled(false)
DisplayFrame.texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)

-- 冷却条
DisplayFrame.cooldown = CreateFrame("Cooldown", nil, DisplayFrame, "CooldownFrameTemplate")
DisplayFrame.cooldown:SetAllPoints()
DisplayFrame.cooldown:EnableMouse(false)
DisplayFrame.cooldown:SetDrawEdge(false)
DisplayFrame.cooldown:SetSwipeColor(0, 0, 0, 0.7)
DisplayFrame.cooldown:Show()

-- 底部文字
local tipText = DisplayFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
tipText:SetText("KP按键提示")
tipText:SetPoint("BOTTOM", DisplayFrame, "BOTTOM", 0, 2)
tipText:SetTextColor(1, 0.8, 0, 1)
tipText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
tipText:Show()

-- 技能名称提示
local spellNameText = DisplayFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
spellNameText:SetPoint("TOP", DisplayFrame, "TOP", 0, -2)
spellNameText:SetTextColor(1, 1, 1, 1)
spellNameText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
spellNameText:SetText("自动攻击")
spellNameText:Show()

-- ======================== KP查找技能索引 ========================
local function findSpellIndex(spellID)
    if not spellID or #currentActionList == 0 then
        return #currentActionList
    end
    for index, value in ipairs(currentActionList) do
        if value and value[1] == spellID then
            return index
        end
    end
    
    if spellID == 54758 then
        for index, value in ipairs(currentActionList) do
            if value and value[1] == 10 and value[2] == "item" then
                return index
            end
        end
    end
    
    -- 改进的动态添加逻辑
    if spellID > 0 then
        -- 检查是否是法术
        local spellName = GetSpellInfo(spellID)
        if spellName then
            -- 添加到列表中
            table.insert(currentActionList, {spellID, "spell"})
            
            -- 保存到数据库
            SavePlayerSkillList(currentActionList)
            
            -- 重新创建技能层
            createActionLayers()
            
            -- 更新 VF_Core
            if VF_initCore then
                -- 转换技能列表格式以适应 VF_Core
                local vfActionList = {}
                for i, spell in ipairs(currentActionList) do
                    local actionType = spell[2]
                    local actionDetail = spell[1]
                    
                    if actionType == "item" then
                        actionDetail = tostring(spell[1])
                    elseif actionType == "macro" then
                        actionDetail = spell[1] == 6603 and "/startattack" or ""
                    end
                    
                    table.insert(vfActionList, {spell[1], actionType, actionDetail})
                end
                
                VF_initCore(vfActionList)
                -- 重新应用绑定键，确保VF_Button使用正确的绑定键
                if VF_Button and addon.config.bindingKey then
                    ClearOverrideBindings(VF_Button)
                    SetOverrideBindingClick(VF_Button, true, addon.config.bindingKey, VF_Button:GetName(), "LeftButton")
                end
            end
            
            -- 返回新添加的技能索引
            return #currentActionList
        end
    end
    
    -- 确保返回一个有效的索引，避免返回0导致错误
    return #currentActionList
end

-- ======================== KP更新技能显示 ========================
local function UpdateDisplay(index)
    if #currentActionList == 0 then 
        DisplayFrame.texture:SetTexture(GetSpellTexture(6603) or "Interface\\Icons\\INV_Misc_QuestionMark")
        DisplayFrame.cooldown:SetCooldown(0, 0)
        spellNameText:SetText("自动攻击")
        return 
    end
    
    index = index or 1
    index = math.max(1, math.min(index, #currentActionList))
    
    local spellInfo = currentActionList[index]
    if not spellInfo or not spellInfo[1] then
        DisplayFrame.texture:SetTexture(GetSpellTexture(6603) or "Interface\\Icons\\INV_Misc_QuestionMark")
        DisplayFrame.cooldown:SetCooldown(0, 0)
        spellNameText:SetText("自动攻击")
        return
    end
    
    local texture, start, duration, usable
    if spellInfo[2] == "item" then
        texture = GetInventoryItemTexture("player", spellInfo[1]) or "Interface\\Icons\\INV_Misc_QuestionMark"
        start, duration = GetInventoryItemCooldown("player", spellInfo[1])
        usable = select(3, GetInventoryItemCooldown("player", spellInfo[1])) == 1
    else
        texture = GetSpellTexture(spellInfo[1]) or "Interface\\Icons\\INV_Misc_QuestionMark"
        start, duration = GetSpellCooldown(spellInfo[1])
        usable = IsUsableSpell(spellInfo[1])
    end
    
    DisplayFrame.texture:SetTexture(texture)
    DisplayFrame.cooldown:SetCooldown(start or 0, duration or 0)
    
    local spellName = ""
    if spellInfo[2] == "spell" then
        spellName = GetSpellInfo(spellInfo[1]) or "未知技能"
    elseif spellInfo[2] == "item" then
        if spellInfo[1] == 10 then
            local itemLink = GetInventoryItemLink("player", 10)
            if itemLink then
                local currentItemName = itemLink:match("%[(.-)%]")
                local found = false
                for _, gloveName in ipairs(addon.config.gloveNames) do
                    if currentItemName == gloveName then
                        spellName = gloveName
                        found = true
                        break
                    end
                end
                if not found then
                    spellName = "工程手套"
                end
            else
                spellName = "工程手套"
            end
        else
            spellName = GetItemInfo(spellInfo[1]) or "未知物品"
        end
    elseif spellInfo[2] == "macro" then
        spellName = "自动攻击"
    end
    spellNameText:SetText(spellName)
    
    if not usable then
        DisplayFrame.texture:SetDesaturated(true)
        DisplayFrame.texture:SetAlpha(0.5)
    else
        DisplayFrame.texture:SetDesaturated(false)
        DisplayFrame.texture:SetAlpha(1)
    end
    
    updateCoverStat(index)
    currentDisplayIndex = index
end

-- ======================== KP获取Hekili推荐技能 ========================
local function CalculateNextSpell()
    if not addon.config.followHekili then
        UpdateDisplay(#currentActionList)
        -- 更新 VF_Core
        if VF_updateNextActionIndex then
            VF_updateNextActionIndex(#currentActionList)
        end
        return #currentActionList
    end
    
    if not UnitExists("target") or not UnitCanAttack("player","target") or UnitIsDead("target") then
        UpdateDisplay(#currentActionList)
        -- 更新 VF_Core
        if VF_updateNextActionIndex then
            VF_updateNextActionIndex(#currentActionList)
        end
        return #currentActionList
    end
    
    local spellID = 0
    if IsAddOnLoaded("Hekili") and HekiliDisplayPrimary and HekiliDisplayPrimary.Recommendations then
        spellID = HekiliDisplayPrimary.Recommendations[1] and HekiliDisplayPrimary.Recommendations[1].actionID or 0
    end
    HekiliSpellID = spellID
    
    -- 德鲁伊形态检查
    local playerClass = select(2, UnitClass("player"))
    if playerClass == "DRUID" then
        local currentForm = GetShapeshiftForm()
        
        -- 检查是否穿着T2套装（允许在变形状态下施放愈合）
        local hasT2Set = false
        -- 检查头部、肩部、胸部、手套、腿部装备
        local t2Items = {
            30233, -- 诺达希尔头巾
            30230, -- 诺达希尔野性护肩
            30222, -- 诺达希尔胸甲
            30223, -- 诺达希尔手甲
            30229, -- 诺达希尔野性褶裙
        }
        local t2Count = 0
        for i = 1, 5 do
            local itemID = GetInventoryItemID("player", i)
            for _, t2ItemID in ipairs(t2Items) do
                if itemID == t2ItemID then
                    t2Count = t2Count + 1
                    break
                end
            end
        end
        hasT2Set = (t2Count >= 2) -- T2套装效果需要2件
        
        -- 猫形态下不能施放的技能
        local catFormForbiddenSpells = {
            48461,  -- 愤怒
            48441,  -- 回春术
            48465,  -- 星火术
            48463,  -- 月火术
            48378,  -- 治疗之触
        }
        
        -- 如果没有T2套装，添加愈合到禁止列表
        if not hasT2Set then
            table.insert(catFormForbiddenSpells, 48443)  -- 愈合
        end
        
        -- 检查是否是猫形态
        if currentForm == 3 then -- 3 = 猫形态
            for _, forbiddenSpellID in ipairs(catFormForbiddenSpells) do
                if spellID == forbiddenSpellID then
                    -- 在猫形态下，不使用这些技能
                    UpdateDisplay(#currentActionList)
                    -- 更新 VF_Core
                    if VF_updateNextActionIndex then
                        VF_updateNextActionIndex(#currentActionList)
                    end
                    return #currentActionList
                end
            end
        end
    end
    
    -- 确保只有Hekili推荐的技能被使用
    if spellID > 0 then
        local spellIndex = findSpellIndex(spellID)
        UpdateDisplay(spellIndex)
        
        -- 更新 VF_Core
        if VF_updateNextActionIndex then
            VF_updateNextActionIndex(spellIndex)
        end
        
        return spellIndex
    else
        -- 如果Hekili没有推荐技能，不使用任何技能
        UpdateDisplay(#currentActionList)
        -- 更新 VF_Core
        if VF_updateNextActionIndex then
            VF_updateNextActionIndex(#currentActionList)
        end
        return #currentActionList
    end
end

-- ======================== KP事件监听 ========================
Manager:RegisterEvent("PLAYER_LOGIN")
Manager:RegisterEvent("PLAYER_REGEN_DISABLED")
Manager:RegisterEvent("PLAYER_REGEN_ENABLED")
Manager:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
Manager:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
Manager:RegisterEvent("PLAYER_LOGOUT")

Manager:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        -- 初始化职业技能列表
        local playerClass = select(2, UnitClass("player")) or "DRUID"
        
        -- 加载保存的技能列表
        local savedSkillList = GetPlayerSkillList()
        if savedSkillList and #savedSkillList > 0 then
            -- 使用保存的技能列表
            currentActionList = savedSkillList
        else
            -- 使用默认的职业技能列表
            if playerClass == "DRUID" then
                local spec = GetPlayerSpecialization()
                if spec and _KP_ClassActionLists[playerClass] and _KP_ClassActionLists[playerClass][spec] then
                    currentActionList = _KP_ClassActionLists[playerClass][spec]
                else
                    -- 如果无法检测到专精，默认使用野性德鲁伊的技能列表
                    currentActionList = _KP_ClassActionLists[playerClass] and _KP_ClassActionLists[playerClass]["Feral"] or {}
                end
            else
                currentActionList = _KP_ClassActionLists[playerClass] or {}
            end
        end
        
        createActionLayers()
        
        -- 初始化 VF_Core
        if VF_initCore then
            -- 转换技能列表格式以适应 VF_Core
            local vfActionList = {}
            for i, spell in ipairs(currentActionList) do
                local actionType = spell[2]
                local actionDetail = spell[1]
                
                if actionType == "item" then
                    actionDetail = tostring(spell[1])
                elseif actionType == "macro" then
                    actionDetail = spell[1] == 6603 and "/startattack" or ""
                end
                
                table.insert(vfActionList, {spell[1], actionType, actionDetail})
            end
            
            VF_initCore(vfActionList)
        end
        
        -- 立即更新显示
        UpdateDisplay(#currentActionList)
        CalculateNextSpell()
        
        -- 启动更新定时器
        local UPDATE_THROTTLE = 0.15
        local lastUpdate = 0
        if updateTicker then updateTicker:cancel() end
        updateTicker = CTimer.NewTicker(UPDATE_THROTTLE, function()
            local now = GetTime()
            if now - lastUpdate >= UPDATE_THROTTLE then
                CalculateNextSpell()
                lastUpdate = now
            end
        end)
        
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 加载完成！框架已显示在屏幕中偏右下位置", 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 输入 /kphekili 查看指令，红色小点可解锁拖动", 1, 1, 1)
        
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
        local unit = ...
        if unit == "player" then
            local playerClass = select(2, UnitClass("player")) or "DRUID"
            if playerClass == "DRUID" then
                local spec = GetPlayerSpecialization()
                if spec and _KP_ClassActionLists[playerClass] and _KP_ClassActionLists[playerClass][spec] then
                    currentActionList = _KP_ClassActionLists[playerClass][spec]
                else
                    -- 如果无法检测到专精，默认使用野性德鲁伊的技能列表
                    currentActionList = _KP_ClassActionLists[playerClass] and _KP_ClassActionLists[playerClass]["Feral"] or {}
                end
            else
                currentActionList = _KP_ClassActionLists[playerClass] or {}
            end
            createActionLayers()
            
            -- 更新 VF_Core
            if VF_initCore then
                -- 转换技能列表格式以适应 VF_Core
                local vfActionList = {}
                for i, spell in ipairs(currentActionList) do
                    local actionType = spell[2]
                    local actionDetail = spell[1]
                    
                    if actionType == "item" then
                        actionDetail = tostring(spell[1])
                    elseif actionType == "macro" then
                        actionDetail = spell[1] == 6603 and "/startattack" or ""
                    end
                    
                    table.insert(vfActionList, {spell[1], actionType, actionDetail})
                end
                
                VF_initCore(vfActionList)
            end
            
            UpdateDisplay(#currentActionList)
        end
    elseif event == "UPDATE_SHAPESHIFT_FORM" then
        CalculateNextSpell()
    elseif event == "PLAYER_REGEN_DISABLED" then
        if tooltipTimer then
            tooltipTimer:cancel()
            tooltipTimer = nil
        end
        GameTooltip:Hide()
    elseif event == "PLAYER_LOGOUT" then
        SaveConfig()
    end
end)

-- ======================== KP指令系统 =======================
SLASH_KPHEKILI1 = "/kphekili"
SlashCmdList["KPHEKILI"] = function(cmd)
    local args = {}
    for arg in string.gmatch(cmd, "%S+") do
        table.insert(args, arg)
    end
    
    if #args == 0 then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00=== KP_Hekili_Assistant 指令帮助 ===", 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00/kphekili lock|r - 锁定/解锁框体", 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00/kphekili key [按键]|r - 修改主绑定键（如 /kphekili key F1）", 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00/kphekili secondarykey [按键]|r - 修改次要绑定键（如 /kphekili secondarykey F2）", 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00/kphekili hekili|r - 开关Hekili跟随", 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00/kphekili reset|r - 重置所有配置", 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00/kphekili show|r - 显示/隐藏框体", 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00/kphekili resetpos|r - 重置框体位置到默认", 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00/kphekili export|r - 导出当前技能列表到聊天框", 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00当前主绑定键：|r"..addon.config.bindingKey, 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00当前次要绑定键：|r"..(addon.config.secondaryBindingKey or "未设置"), 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Hekili跟随：|r"..(addon.config.followHekili and "开启" or "关闭"), 1, 1, 1)
        return
    end
    
    local cmdKey = string.lower(args[1])
    
    if cmdKey == "lock" then
        toggleFrameLock()
    elseif cmdKey == "key" and args[2] then
        addon:SetBindingKey(args[2], false)
    elseif cmdKey == "secondarykey" and args[2] then
        addon:SetBindingKey(args[2], true)
    elseif cmdKey == "hekili" then
        addon.config.followHekili = not addon.config.followHekili
        SaveConfig()
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r Hekili跟随已"..(addon.config.followHekili and "开启" or "关闭"), 1, 1, 1)
    elseif cmdKey == "reset" then
        if InCombatLockdown() then
            DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[KP_Hekili_Assistant]|r 战斗中无法重置配置", 1, 1, 1)
            return
        end
        KP_Hekili_Assistant_SavedConfig = nil
        SavedConfig = {}
        addon.config = CopyTable(defaultConfig)
        DisplayFrame:ClearAllPoints()
        DisplayFrame:SetPoint("CENTER", UIParent, "CENTER", 235, -210)
        StopMovingOrSizing()
        addon:SetBindingKey("MouseWheelDown")
        isFrameLocked = true
        dotTexture:SetColorTexture(1, 0, 0, 0.8)
        DisplayFrame:SetFrameLevel(5)
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 配置已重置为默认值", 1, 1, 1)
    elseif cmdKey == "show" then
        local isVisible = DisplayFrame:IsShown()
        if isVisible then
            DisplayFrame:Hide()
            bndlyr:Hide()
            btmbtn:Hide()
            controlDot:Hide()
            for _, lyr in ipairs(CoverLyrs) do
                lyr:Hide()
            end
        else
            DisplayFrame:Show()
            bndlyr:Show()
            btmbtn:Show()
            controlDot:Show()
            for _, lyr in ipairs(CoverLyrs) do
                lyr:Show()
            end
        end
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 框体已"..(isVisible and "隐藏" or "显示"), 1, 1, 1)
    elseif cmdKey == "resetpos" then
        DisplayFrame:ClearAllPoints()
        DisplayFrame:SetPoint("CENTER", UIParent, "CENTER", 235, -210)
        
        -- 同时重置其他相关框体的位置
        if bndlyr then
            bndlyr:ClearAllPoints()
            bndlyr:SetPoint("CENTER", UIParent, "CENTER", 235, -210)
        end
        
        if btmbtn then
            btmbtn:ClearAllPoints()
            btmbtn:SetPoint("CENTER", UIParent, "CENTER", 235, -210)
        end
        
        if VF_Button then
            VF_Button:ClearAllPoints()
            VF_Button:SetPoint("CENTER", UIParent, "CENTER", 235, -210)
        end
        
        if MouseLocker then
            MouseLocker:ClearAllPoints()
            MouseLocker:SetPoint("CENTER", UIParent, "CENTER", 235, -210)
        end
        
        if CoverLyrs then
            for _, lyr in ipairs(CoverLyrs) do
                lyr:ClearAllPoints()
                lyr:SetPoint("CENTER", UIParent, "CENTER", 235, -210)
            end
        end
        
        StopMovingOrSizing()
        
        -- 更新配置中的位置信息
        addon.config.position = {
            point = "CENTER",
            relativeTo = UIParent,
            relativePoint = "CENTER",
            x = 235,
            y = -210
        }
        
        SaveConfig()
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 框体位置已重置到默认（屏幕中偏右下）", 1, 1, 1)
    elseif cmdKey == "export" then
        local playerClass = select(2, UnitClass("player")) or "DRUID"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r 职业技能列表（共"..#currentActionList.."个技能）：", 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r ============================================", 1, 1, 1)
        
        DEFAULT_CHAT_FRAME:AddMessage("    -- "..playerClass.." = {", 1, 1, 1)
        
        local lineText = "        "
        for i, spell in ipairs(currentActionList) do
            if spell[2] == "item" then
                lineText = lineText..string.format("{%d, \"item\"}, ", spell[1])
            elseif spell[2] == "macro" then
                lineText = lineText..string.format("{%d, \"macro\"}, ", spell[1])
            else
                lineText = lineText..string.format("{%d, \"spell\"}, ", spell[1])
            end
            if i % 6 == 0 then
                DEFAULT_CHAT_FRAME:AddMessage(lineText, 1, 1, 1)
                lineText = "        "
            end
        end
        
        if lineText ~= "        " then
            DEFAULT_CHAT_FRAME:AddMessage(lineText, 1, 1, 1)
        end
        
        DEFAULT_CHAT_FRAME:AddMessage("    },", 1, 1, 1)
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[KP_Hekili_Assistant]|r ============================================", 1, 1, 1)
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[KP_Hekili_Assistant]|r 未知指令！输入 /kphekili 查看帮助", 1, 1, 1)
    end
end

-- ======================== KP性能优化 ========================
CTimer.NewTicker(300, function()
    if not InCombatLockdown() then 
        collectgarbage("collect")
    end 
end)

-- ======================== KP全局导出 ========================
_G.KP_Hekili_Assistant = addon
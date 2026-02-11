-- FuxPanel.lua

local function A(B, C)
    local D = CreateFrame("Button", C.name, B, "BackdropTemplate")
    local function E()
        local F = B:GetHeight()
        local G
        if C.sizeRatio then
            G = F * C.sizeRatio
        else
            G = C.size or (F * 0.8)
        end
        D:SetSize(G, G)
        if D.texts then
            for _, H in ipairs(C.texts) do
                if H.sizeSync then
                    D.texts[H.name]:SetTextHeight(G * H.sizeScale)
                end
            end
        end
    end
    E()
    B:SetScript("OnSizeChanged", function()
        E()
        D:SetPoint("CENTER", B, "CENTER", C.xOffset, 0)
    end)
    D:SetPoint("CENTER", B, "CENTER", C.xOffset, 0)
    D:EnableMouse(true)
    D:RegisterForClicks("AnyUp")
    D:SetFrameStrata("LOW")
    D:SetFrameLevel(B:GetFrameLevel())
    local I = D:CreateTexture(nil, "ARTWORK")
    I:SetAllPoints(D)
    I:SetTexture(C.texture)
    I:SetTexCoord(C.texCoord and unpack(C.texCoord) or 0.08, 0.92, 0.08, 0.92)
    local J = D:CreateTexture(nil, "HIGHLIGHT")
    J:SetAllPoints(D)
    J:SetTexture(C.highlightTexture or "Interface\\Buttons\\ButtonHilight-Square")
    J:SetBlendMode(C.blendMode or "ADD")
    J:SetAlpha(C.highlightAlpha or 0.5)
    J:Hide()
    local K = C.waveAmplitude or 0.3 
    local L = C.waveDuration or 0.5 
    local M = 0
    local N = 1
    local O = 2
    local P = 3
    local Q = M
    local R = D:CreateAnimationGroup()
--    R:SetLooping("REPEAT") 
    local S = R:CreateAnimation("Scale")
    S:SetDuration(L)
    S:SetScale(1 + K, 1 + K) 
    S:SetSmoothing("OUT")
    local T = R:CreateAnimation("Scale")
    T:SetDuration(L)
    T:SetScale(1, 1) 
    T:SetSmoothing("IN")
    T:SetStartDelay(L) 
    local V = false
    local function W()
        if _G.FuxPanel_EnableScaleAnimation then
            if V then
                if not R:IsPlaying() then
                    R:Play()
                end
            else
                if R:IsPlaying() then
                    R:Stop()
                end
            end
        end
    end
    _G.FuxPanel_EnableScaleAnimation = true
    local function X()
        if _G.FuxPanel_EnableHighlightEffect then
            J:SetShown(V)
        else
            J:Hide()
        end
    end
    D:SetScript("OnEnter", function(self)
        V = true
        W()
        X()
        if C.onEnter then C.onEnter(self, self.data) end
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -80, 0)
        GameTooltip:ClearLines()
        local Y = type(C.tooltip) == "function" and C.tooltip(self.data) or C.tooltip
        for _, Z in ipairs(Y or {}) do
            GameTooltip:AddLine(unpack(Z))
        end
        GameTooltip:Show()
    end)
    D:SetScript("OnLeave", function(self)
        V = false
        W()
        X()
        GameTooltip:Hide()
    end)
    _G.FuxPanel_EnableHighlightEffect = false
    if C.texts then
        D.texts = {}
        for _, AA in ipairs(C.texts) do
            local BB = D:CreateFontString(nil, "OVERLAY")
            local CC = AA.absoluteSize or (AA.sizeScale and (B:GetHeight() * AA.sizeScale)) or (D:GetHeight() * 0.3)
            BB:SetFont(AA.font, CC, AA.outline)
            BB:SetPoint(AA.point, AA.x, AA.y)
            BB:SetTextColor(unpack(AA.color))
            D.texts[AA.name] = BB
        end
    end
    D.data = {}
    if C.dataLoader then
        D.data = C.dataLoader()
    end
    if C.events then
        for DD, EE in pairs(C.events) do
            D:RegisterEvent(DD)
            D:SetScript("OnEvent", function(self, ...)
                if C.dataLoader then
                    self.data = C.dataLoader()
                end
                if C.texts then
                    for _, FF in ipairs(C.texts) do
                        if FF.updater then
                            self.texts[FF.name]:SetText(FF.updater(self.data))
                        end
                    end
                end
                EE(self, ...)
            end)
        end
    end
    D:SetScript("OnClick", C.onClick)
    if C.texts and C.dataLoader then
        local GG = C.dataLoader()
        for _, HH in ipairs(C.texts) do
            if HH.updater then
                D.texts[HH.name]:SetText(HH.updater(GG))
            end
        end
    end
    return D
end

local function I(B)
    local function L()
        local M, N = GetGameTime()
        return string.format("%02d:%02d", M, N) 
    end
    
    local addonMemoryList = {}
    local MAX_ADDONS_TO_DISPLAY = 20  
    
    local hasMemoryAPI = false
    if GetAddOnInfo and UpdateAddOnMemoryUsage and GetAddOnMemoryUsage then
        hasMemoryAPI = true
    end
    
    local function UpdateAddonMemory()
        if not hasMemoryAPI then return end
        
        wipe(addonMemoryList)
        UpdateAddOnMemoryUsage()
        
        local numAddons = GetNumAddOns and GetNumAddOns() or 0
        
        for i = 1, numAddons do
            if IsAddOnLoaded(i) then
                local name, _, _, enabled = GetAddOnInfo(i)
                if enabled then
                    local mem = GetAddOnMemoryUsage(i)
                    table.insert(addonMemoryList, {name = name, memory = mem})
                end
            end
        end
        
        table.sort(addonMemoryList, function(a, b)
            return a.memory > b.memory
        end)
    end
    
    local function FormatMemory(mem)
        if mem < 1000 then
            return string.format("%.1f KB", mem)
        else
            return string.format("%.2f MB", mem / 1024)
        end
    end
    
    local P = CreateFrame("Button", nil, B)
    P:SetSize(60, B:GetHeight())
    P:EnableMouse(true)
    P:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    
    local hourText = P:CreateFontString(nil, "OVERLAY")
    hourText:SetPoint("RIGHT", P, "CENTER", -2, 0)
    
    local colonText = P:CreateFontString(nil, "OVERLAY")
    colonText:SetPoint("CENTER", P, "CENTER", 0, 0)
    
    local minuteText = P:CreateFontString(nil, "OVERLAY")
    minuteText:SetPoint("LEFT", P, "CENTER", 2, 0)

    local fontPaths = {
        [1] = "Fonts\\FRIZQT__.ttf",  
        [2] = "Fonts\\bHEI00M.ttf", 
        [3] = "Fonts\\ARKai_C.ttf"   
    }

    local function GetConfig()
        local db = _G["FuxBarDB"]
        if not db then return {} end
        
        local account = GetCVar("accountName") or "UnknownAccount"
        local _, realm = UnitFullName("player")
        local configKey = account.."-"..(realm or "UnknownRealm")
        
        return db[configKey] or {}
    end

    function _G.UpdateTimeModuleFont()
        local config = GetConfig()
        local fontSize = config.timeFontSize or 18
        local fontType = config.timeFontType or 2
        local fontPath = fontPaths[fontType] or fontPaths[2]
        
        hourText:SetFont(fontPath, fontSize, "OUTLINE")
        colonText:SetFont(fontPath, fontSize, "OUTLINE")
        minuteText:SetFont(fontPath, fontSize, "OUTLINE")
        

        local timeStr = L()
        hourText:SetText(strsub(timeStr, 1, 2))
        colonText:SetText(strsub(timeStr, 3, 3))
        minuteText:SetText(strsub(timeStr, 4, 5))
    end

    _G.UpdateTimeModuleFont()

    local _, class = UnitClass("player")
    local classColor = RAID_CLASS_COLORS[class]
    local r, g, b = classColor.r, classColor.g, classColor.b
    
    hourText:SetTextColor(r, g, b, 1)
    colonText:SetTextColor(r, g, b, 1)
    minuteText:SetTextColor(r, g, b, 1)

    local timeStr = L()
    hourText:SetText(strsub(timeStr, 1, 2))
    colonText:SetText(strsub(timeStr, 3, 3))
    minuteText:SetText(strsub(timeStr, 4, 5))
    
    local flashTimer = 0
    local flashDuration = 1  
    local flashIntensity = 0.1 
    
    P:SetScript("OnUpdate", function(self, elapsed)
        self._updateTimer = (self._updateTimer or 0) + elapsed
        if self._updateTimer >= 1 then
            self._updateTimer = 0
            
            local timeStr = L()
            hourText:SetText(strsub(timeStr, 1, 2))
            colonText:SetText(strsub(timeStr, 3, 3))
            minuteText:SetText(strsub(timeStr, 4, 5))
        end
        
        local currentShiftState = IsShiftKeyDown()
        if currentShiftState ~= lastShiftState then
            lastShiftState = currentShiftState
            isShiftDown = currentShiftState
            
            if GameTooltip:GetOwner() == self then
                self:GetScript("OnEnter")(self)
            end
        end
        
        if not self.isMouseOver then
            flashTimer = flashTimer + elapsed
            if flashTimer > flashDuration then
                flashTimer = flashTimer - flashDuration
            end
            
            local alpha = 1 - (math.sin((flashTimer / flashDuration) * math.pi * 2) * 0.5 + 0.5) * (1 - flashIntensity)
            colonText:SetAlpha(alpha)
        end
    end)
    
    P:SetScript("OnEnter", function(self)
        self.isMouseOver = true
        hourText:SetTextColor(1, 1, 1, 1)
        colonText:SetTextColor(1, 1, 1, 1)
        minuteText:SetTextColor(1, 1, 1, 1)
        colonText:SetAlpha(1) 
        
        local S = date("*t")
        local T = {"日", "一", "二", "三", "四", "五", "六"}
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 5, 5)
        GameTooltip:ClearLines()
        
        GameTooltip:AddLine(string.format("周%s，%d年%d月%d日", T[S.wday], S.year, S.month, S.day), 1, 0.82, 0)
        GameTooltip:AddLine("本地时间：" .. date("%H:%M"), 0.6, 0.8, 1)
        if GetGameTime then
            local U, V = GetGameTime()
            GameTooltip:AddLine("服务器时间：" .. string.format("%02d:%02d", U, V), 0.6, 0.8, 1)
        end
        
        local fps = math.floor(GetFramerate())
        local latencyHome, latencyWorld = select(3, GetNetStats())
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("性能监控:", 1, 0.82, 0)
        GameTooltip:AddDoubleLine("FPS:", fps, 0.6, 0.8, 1, 0.6, 0.8, 1)
        GameTooltip:AddDoubleLine("本地延迟:", latencyHome.."ms", 0.6, 0.8, 1, 0.6, 0.8, 1)
        GameTooltip:AddDoubleLine("世界延迟:", latencyWorld.."ms", 0.6, 0.8, 1, 0.6, 0.8, 1)
        
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("操作提示:", 1, 0.82, 0)
        GameTooltip:AddLine("左键：回收内存", 0.6, 0.8, 1)
        GameTooltip:AddLine("右键：打开日历", 0.6, 0.8, 1)
        
        if hasMemoryAPI then
            GameTooltip:AddLine("Shift+悬停：查看插件内存", 0.6, 0.8, 1)
        else
            GameTooltip:AddLine("内存监控不可用", 0.6, 0.3, 0.3)
        end
        
        if isShiftDown and hasMemoryAPI then
            UpdateAddonMemory()  
            
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("插件内存占用 (前 "..MAX_ADDONS_TO_DISPLAY.."):", 1, 0.82, 0)
            GameTooltip:AddDoubleLine("插件名称", "内存占用", 0.6, 0.8, 1, 0.6, 0.8, 1)
            
            local totalMemory = 0
            local displayedCount = 0
            
            for i, addon in ipairs(addonMemoryList) do
                if displayedCount < MAX_ADDONS_TO_DISPLAY then
                    GameTooltip:AddDoubleLine(addon.name, FormatMemory(addon.memory), 1, 1, 1, 1, 1, 1)
                    displayedCount = displayedCount + 1
                end
                totalMemory = totalMemory + addon.memory
            end
            
            GameTooltip:AddLine(" ")
            GameTooltip:AddDoubleLine("总插件内存:", FormatMemory(totalMemory), 1, 0.82, 0, 1, 1, 1)
            GameTooltip:AddLine("松开Shift键隐藏列表", 0.5, 0.5, 0.5)
        end
        
        GameTooltip:Show()
    end)
    
    P:SetScript("OnLeave", function(self)
        self.isMouseOver = false
        hourText:SetTextColor(r, g, b, 1)
        colonText:SetTextColor(r, g, b, 1)
        minuteText:SetTextColor(r, g, b, 1)
        colonText:SetAlpha(1) 
        
        GameTooltip:Hide()
    end)
    
    P:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            if hasMemoryAPI then
                UpdateAddonMemory()
                local beforeMemory = 0
                for _, addon in ipairs(addonMemoryList) do
                    beforeMemory = beforeMemory + addon.memory
                end
                
                collectgarbage('collect')
                
                UpdateAddonMemory()
                local afterMemory = 0
                for _, addon in ipairs(addonMemoryList) do
                    afterMemory = afterMemory + addon.memory
                end
                
                local savedMemory = beforeMemory - afterMemory
                
                print(string.format("|cFF33FF99内存回收完成：|r减少了 %s 内存使用", FormatMemory(savedMemory)))
            else
                print("|cFFFF3333内存监控API不可用，无法执行内存回收|r")
            end
        elseif button == "RightButton" then
            if C_Calendar and C_Calendar.OpenCalendar then
                if InCombatLockdown() then
                    print("战斗中无法打开日历")
                else
                    ToggleCalendar()
                end
            else
                print("当前游戏版本不支持日历功能")
            end
        end
    end)
    
    B:Show()  
    
    return P
end
_G.CreateTimePanel = I

local function J(B)
    return A(B, {
        name = "lany_CharacterIcon",
        xOffset = 0,
        sizeRatio = 0.9,
        texture = "Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\Character.blp",
        scaleFactor = 1.15,
        tooltip = {
            { "角色面板", 1, 0.82, 0 },
            { "左键：打开角色信息", 0.6, 0.8, 1 },
            { "右键：打开货币标签", 0.6, 0.8, 1 }  
        },
        onClick = function(_, C)
            if InCombatLockdown() then
                UIErrorsFrame:AddMessage("战斗中无法打开角色面板", 1.0, 0.1, 0.1, 1.0)
                return
            end
            
            if C == "LeftButton" then
                ToggleCharacter("PaperDollFrame")  
            elseif C == "RightButton" then
                ToggleCharacter("TokenFrame")  
            end
        end
    })
end
_G.CreateCharacterPanel = J

local function K(B)
    return A(B, {
        name = "lany_SpellbookIcon",
        xOffset = 0,
        sizeRatio = 0.9,
        texture = "Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\Spellbook.blp",
        scaleFactor = 1.15,
        tooltip = {
            { "法术书", 1, 0.82, 0 },
            { "左键：打开法术列表", 0.4, 0.8, 0.2 },
            { "右键：切换宠物法术书", 0.8, 0.4, 1 }
        },
        onClick = function(_, C)
            if C == "LeftButton" then
                ToggleSpellBook(BOOKTYPE_SPELL)
            elseif C == "RightButton" then
                if HasPetSpells() then
                    ToggleSpellBook(BOOKTYPE_PET)
                else
                    UIErrorsFrame:AddMessage("你没有可用的宠物法术", 1.0, 0.1, 0.1, 1.0)
                end
            end
        end
    })
end
_G.CreateSpellbookPanel = K

local function L(B)
    return A(B, {
        name = "lany_TalentIcon",
        xOffset = 0,
        sizeRatio = 0.9,
        texture = "Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\Talents.blp",
        highlightAlpha = 0.6,
        scaleFactor = 1.15,
        clickTypes = "AnyUp",
        tooltip = {
            { "天赋系统", 1, 0.82, 0, 1 },
            { "左键：打开天赋面板", 0.6, 0.8, 1 },
            { "右键：切换天赋配置", 0.6, 0.8, 1 }
        },
        onClick = function(self, button, down)
            -- 获取当前游戏版本信息
            local isWOTLK = (LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_WRATH_OF_THE_LICH_KING)
            local isMOP = (LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_MISTS_OF_PANDARIA)
            
            -- 左键：打开天赋面板（所有版本通用）
            if button == "LeftButton" and not down then
                -- 1. 状态检测
                if InCombatLockdown() then
                    UIErrorsFrame:AddMessage("战斗中无法打开天赋面板", 1, 0, 0)
                    return
                end

                -- 2. 加载天赋界面
                if not PlayerTalentFrame then
                    LoadAddOn("Blizzard_TalentUI")
                end

                -- 3. 开关面板
                if PlayerTalentFrame:IsShown() then
                    HideUIPanel(PlayerTalentFrame)
                else
                    ShowUIPanel(PlayerTalentFrame)
                    -- MoP版本使用不同的更新函数
                    if isMOP and PlayerTalentFrame_Update then
                        PlayerTalentFrame_Update()
                    end
                end
            end

            -- 右键：切换天赋配置（区分WLK和MoP）
            if button == "RightButton" and not down then
                -- 状态检测（所有版本通用）
                if InCombatLockdown() then
                    UIErrorsFrame:AddMessage("战斗中无法切换天赋", 1, 0, 0)
                    return
                end
                if UnitIsDead("player") then
                    UIErrorsFrame:AddMessage("死亡状态无法操作", 1, 0, 0)
                    return
                end
                
                -- MoP版本（专精切换）
                if isMOP then
                    -- 获取当前专精和专精数量
                    local currentSpec = GetSpecialization()
                    local numSpecs = GetNumSpecializations()
                    
                    if numSpecs < 2 then
                        UIErrorsFrame:AddMessage("未解锁双专精", 1, 0, 0)
                        return
                    end
                    
                    -- 计算下一个专精
                    local nextSpec = (currentSpec % numSpecs) + 1
                    
                    -- 切换专精
                    SetSpecialization(nextSpec)
                    
                    -- 获取专精名称
                    local _, specName = GetSpecializationInfo(nextSpec)
                    UIErrorsFrame:AddMessage("已切换至专精: "..specName, 0, 1, 0)
                    
                    -- 刷新界面
                    if PlayerTalentFrame and PlayerTalentFrame:IsShown() then
                        PlayerTalentFrame_Update()
                    end
                
                -- WLK版本（天赋组切换）
                elseif isWOTLK then
                    -- 获取当前天赋组
                    local currentGroup = GetActiveTalentGroup()
                    local numGroups = GetNumTalentGroups()
                    
                    if numGroups < 2 then
                        UIErrorsFrame:AddMessage("未解锁双天赋", 1, 0, 0)
                        return
                    end
                    
                    -- 执行切换
                    local newGroup = (currentGroup == 1) and 2 or 1
                    SetActiveTalentGroup(newGroup)
                    UIErrorsFrame:AddMessage("已切换至天赋组 "..newGroup, 0, 1, 0)
                    
                    -- 刷新界面
                    if PlayerTalentFrame and PlayerTalentFrame:IsShown() then
                        PlayerTalentFrame_Update()
                    end
                else
                    UIErrorsFrame:AddMessage("当前版本不支持天赋切换", 1, 0, 0)
                end
            end
        end
    })
end
_G.CreateTalentPanel = L

local function M(B)
    local function N()
        local O = 0
        if C_PlayerInfo and C_PlayerInfo.GetPlayerAchievementPoints then
            O = C_PlayerInfo.GetPlayerAchievementPoints()
        elseif GetTotalAchievementPoints then
            O = GetTotalAchievementPoints()
        end
        local P = ""
        if C_Achievements and C_Achievements.GetLatestCompletedAchievement then
            local Q = C_Achievements.GetLatestCompletedAchievement()
            P = Q and GetAchievementLink(Q) or ""
        end
        return { points = O, lastAchievement = P }
    end
    return A(B, {
        name = "lany_AchievementIcon",
        xOffset = 0,
        sizeRatio = 0.9,
        texture = "Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\Achievement.blp",
        highlightAlpha = 1,
        scaleFactor = 1.15,
        dataLoader = N,
        tooltip = function(R)
            local S = {
                { "成就系统", 1, 0.82, 0 },
                { "成就点数：|cFFFFD700" .. R.points, 0.4, 1, 0.4 }
            }
            if R.lastAchievement ~= "" then
                table.insert(S, { "最近成就：|cFF00FFFF" .. R.lastAchievement, 0.8, 0.8, 1 })
            else
                table.insert(S, { "暂无最近成就", 0.5, 0.5, 0.5 })
            end
            table.insert(S, { "左键打开成就面板", 0.6, 0.8, 1 })
            return S
        end,
        onClick = function(_, C)
            if C == "LeftButton" then
                if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                    ToggleAchievementFrame()
                elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC then
                    AchievementMicroButton:Click()
                else
                    UIErrorsFrame:AddMessage("该版本无成就系统", 1.0, 0.1, 0.1, 1.0)
                end
            end
        end
    })
end
_G.CreateAchievementPanel = M

local function N(B)
    local function O()
        if C_QuestLog and C_QuestLog.GetNumQuestLogEntries then
            return C_QuestLog.GetNumQuestLogEntries()
        elseif GetNumQuestLogEntries then
            return GetNumQuestLogEntries()
        end
        return 0
    end
    return A(B, {
        name = "lany_QuestIcon",
        xOffset = 0,
        sizeRatio = 0.9,
        texture = "Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\Quest.blp",
        scaleFactor = 1.15,
        dataLoader = O,
        events = {
            ["QUEST_LOG_UPDATE"] = function(self)
                self.data = O()
                if GameTooltip:IsOwned(self) then
                    self:GetScript("OnEnter")(self)
                end
            end
        },
        tooltip = function(P)
            return {
                { "任务日志", 1, 0.82, 0 },
                { "当前任务数量：|cFF00FF00" .. P, 0.4, 1, 0.4 },
                { "左键：打开任务列表", 0.2, 0.6, 1 },
                { "右键：切换任务追踪", 0.2, 0.6, 1 }
            }
        end,
        onClick = function(_, C)
            if C == "LeftButton" then
                if ToggleQuestLog then
                    ToggleQuestLog()
                elseif QuestLog_Toggle then
                    QuestLog_Toggle()
                end
            elseif C == "RightButton" then
                if C_QuestLog and C_QuestLog.GetNumQuestWatches then
                    if C_QuestLog.GetNumQuestWatches() > 0 then
                        QuestWatch_Close()
                    else
                        QuestWatch_Initialize()
                    end
                elseif ToggleQuestWatch then
                    ToggleQuestWatch()
                end
            end
        end
    })
end
_G.CreateDailyBar = N

local function O(B)
    local function P()
        if not IsInGuild() then return { online = 0 } end
        GuildRoster()
        local Q = 0
        for i = 1, GetNumGuildMembers() do
            local _, _, _, _, _, _, _, _, R = GetGuildRosterInfo(i)
            if R then Q = Q + 1 end
        end
        return {
            online = Q,
            guildName = GetGuildInfo("player") or "我的公会"
        }
    end
    return A(B, {
        name = "lany_GuildIcon",
        xOffset = 0,
        sizeRatio = 0.9,
        texture = "Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\Guild.blp",
        scaleFactor = 1.15,
        dataLoader = P,
        texts = {
            {
                name = "onlineText",
                font = "Fonts\\ARHei.TTF",
                absoluteSize = 13,    
                sizeScale = 0.3,      
                minSize = 10,        
                maxSize = 26,        
                outline = "OUTLINE",
                point = "TOPRIGHT",
                x = 5,
                y = -2,
                color = { 0, 1, 0 },
                updater = function(R)
                    return R.online > 0 and R.online or ""
                end,
                sizeSync = true       
            }
        },
        events = {
            ["GUILD_ROSTER_UPDATE"] = function(self)
                self.data = P()
                if GameTooltip:IsOwned(self) then
                    self:GetScript("OnEnter")(self)
                end
            end,
            ["PLAYER_GUILD_UPDATE"] = function(self)
                self.data = P()
            end
        },
        tooltip = function(R)
            if IsInGuild() then
                return {
                    { R.guildName, 0.4, 0.8, 0.2 },
                    { "在线成员：|cFF00FF00" .. R.online, 1, 1, 1 },
                    { "左键打开好友列表", 0.8, 0.8, 0.8 },
                    { "右键打开公会面板", 0.8, 0.8, 0.8 }
                }
            else
                return {
                    { "加入公会", 1, 0.5, 0 },
                    { "你还没有加入任何公会", 1, 1, 1 },
                    { "左键打开好友列表", 0.8, 0.8, 0.8 }
                }
            end
        end,
        onClick = function(_, C)
            if C == "LeftButton" then
                ToggleFriendsFrame(1) 
            elseif C == "RightButton" then
                if IsInGuild() then
                    if ToggleGuildFrame then
                        ToggleGuildFrame()
                    elseif GuildFrame_Toggle then
                        GuildFrame_Toggle()
                    elseif GuildFrame then
                        ToggleFrame(GuildFrame)
                    end
                else
                    UIErrorsFrame:AddMessage("你还没有加入公会", 1.0, 0.1, 0.1, 1.0)
                end
            end
        end
    })
end
_G.CreateGuildPanel = O

local function P(B)
    return A(B, {
        name = "lany_PVEIcon",
        xOffset = 0,
        sizeRatio = 0.9,
        texture = "Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\PVE.blp",
        highlightAlpha = 0.6,
        scaleFactor = 1.15,
        events = {
            ["LFG_UPDATE"] = function(self)
                if GameTooltip:IsOwned(self) then
                    self:GetScript("OnEnter")(self)
                end
            end
        },
        tooltip = function()
            local Q = {
                { "队伍查找器", 1, 0.82, 0, 1 }
            }
            if LFG_IsPlayerInLFGQueue then
                local R = LFG_IsPlayerInLFGQueue() and "|cFF00FF00进行中|r" or "|cFFFF0000未激活|r"
                table.insert(Q, { "当前队列状态: " .. R, 0.4, 0.8, 1 })
            end
            table.insert(Q, { "左键：打开/关闭队伍查找器", 0.6, 0.8, 1 })
            table.insert(Q, { "右键：自动排本 (优先级: 节日 > 天神 > 英雄 > 普通)", 0.6, 0.8, 1 })
            return Q
        end,
        onClick = function(self, button)
            if button == "LeftButton" then
                if InCombatLockdown() then
                    print("|cffff0000战斗中无法打开组队面板|r")
                    return
                end
                if PVEFrame_ToggleFrame then
                    PVEFrame_ToggleFrame()
                elseif LFGFrame_Toggle then
                    LFGFrame_Toggle()
                else
                    UIErrorsFrame:AddMessage("当前版本无组队系统", 1.0, 0.1, 0.1, 1.0)
                end
            elseif button == "RightButton" then
                if InCombatLockdown() then
                    print("|cffff0000战斗中无法排队副本|r")
                    return
                end
                
                local priorityList = {
                    -- 节日副本 (示例ID，可能需要根据实际情况调整)
                    { id = 285, name = "节日副本" },
                    { id = 286, name = "节日副本" },
                    { id = 287, name = "节日副本" },
                    { id = 288, name = "节日副本" },
                    
                    { id = 3034, name = "随机熊猫人之谜天神地下城" },    
                    { id = 462, name = "随机熊猫人之谜英雄地下城" },
                    { id = 463, name = "随机熊猫人之谜地下城" },               
                    
                    { id = 262, name = "随机英雄副本" },
                    { id = 261, name = "随机普通副本" },
                }
                
                local selectedDungeon = nil
                
                for _, dungeon in ipairs(priorityList) do
                    if IsLFGDungeonJoinable(dungeon.id) then
                        selectedDungeon = dungeon
                        break
                    end
                end
				
                if selectedDungeon then
                    LFG_JoinDungeon(1, selectedDungeon.id)
                    SendSystemMessage("已进入" .. selectedDungeon.name .. "队列")
                else
                    print("|cffff0000没有可加入的副本队列|r")
                end
            end
        end
    })
end
_G.CreatePVEPanel = P

local function Q(B)
    return A(B, {
        name = "lany_MountIcon",
        xOffset = 0,
        sizeRatio = 0.9,
        texture = "Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\Mount.blp",
        highlightAlpha = 0.6,
        scaleFactor = 1.15,
        tooltip = function()
            local R = {
                { "坐骑与宠物", 1, 0.82, 0 },
            }
            local mountCount = 0
            
            if C_MountJournal and C_MountJournal.GetMountIDs then
                local mountIDs = C_MountJournal.GetMountIDs()
                for _, mountID in ipairs(mountIDs) do
                    local _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
                    if isCollected then
                        mountCount = mountCount + 1
                    end
                end
            
            elseif MountJournal and MountJournal.GetNumMounts then
                for mountType = 1, MountJournal.GetNumMountTypes() do
                    local numMounts = MountJournal.GetNumMounts(mountType)
                    for i = 1, numMounts do
                        local _, _, _, isCollected = MountJournal.GetMountInfo(mountType, i)
                        if isCollected then
                            mountCount = mountCount + 1
                        end
                    end
                end
            end
            
            table.insert(R, { format("当前可用坐骑：|cff00ff00%d|r ", mountCount), 0.4, 0.8, 1 })
            table.insert(R, { "左键：打开坐骑面板", 0.6, 0.8, 1 })
            table.insert(R, { "右键：智能召唤坐骑", 0.6, 0.8, 1 }) 
            
            return R
        end,
        onClick = function(_, C)
            if C == "LeftButton" then
                if InCombatLockdown() then
                    print("|cffff0000战斗中无法打开坐骑面板|r")
                    return
                end

                if MountJournal_LoadUI then
                    if not MountJournal then
                        MountJournal_LoadUI()
                    end
                    ToggleFrame(MountJournal)
                elseif CollectionsJournal_LoadUI then
                    if not CollectionsJournal then
                        CollectionsJournal_LoadUI()
                    end
                    if CollectionsJournal:IsShown() then
                        HideUIPanel(CollectionsJournal)
                    else
                        ShowUIPanel(CollectionsJournal)
                        if CollectionsJournal.SetTab then
                            CollectionsJournal.SetTab(CollectionsJournal, 2)
                        end
                    end
                else
                    UIErrorsFrame:AddMessage("当前版本无坐骑收藏功能", 1.0, 0.1, 0.1, 1.0)
                    UIFrameFlash(self, 0.5, 0.5, 3, false)
                end

            elseif C == "RightButton" then
                if InCombatLockdown() then
                    print("|cffff0000战斗中无法召唤坐骑|r")
                    return
                end

                if C_MountJournal and C_MountJournal.SummonByID then
                    local success, err = pcall(function()

                        C_MountJournal.SummonByID(0)
                    end)
                    if not success then
                        print("|cffff0000召唤失败:|r", err)
                        UIErrorsFrame:AddMessage("无法召唤坐骑", 1.0, 0.1, 0.1, 1.0)
                    end

                -- 怀旧服兼容方案
                elseif MountJournal then
                    local collectedMounts = {}
                    -- 收集所有可用坐骑
                    for mountType = 1, MountJournal.GetNumMountTypes() do
                        for i = 1, MountJournal.GetNumMounts(mountType) do
                            local name, _, _, isCollected = MountJournal.GetMountInfo(mountType, i)
                            if isCollected then
                                table.insert(collectedMounts, {type = mountType, index = i})
                            end
                        end
                    end
                    
                    if #collectedMounts > 0 then
                        local random = math.random(#collectedMounts)
                        MountJournal.SummonByID(collectedMounts[random].type, collectedMounts[random].index)
                    else
                        UIErrorsFrame:AddMessage("没有可用的坐骑", 1.0, 0.1, 0.1, 1.0)
                    end
                else
                    UIErrorsFrame:AddMessage("当前版本不支持召唤功能", 1.0, 0.1, 0.1, 1.0)
                end
            end
        end
    })
end
_G.CreateMountPanel = Q

local function R(B)
    local function S()
        local T = UnitPVPRank("player")
        local U = "无"
        if T > 0 then
            U = select(1, GetPVPRankInfo(T)) or "无"
        end
        return {
            rank = U,
            kills = GetPVPSessionStats() or 0
        }
    end
    return A(B, {
        name = "lany_PVPIcon",
        xOffset = 0,
        sizeRatio = 0.9,
        texture = "Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\PVP.blp",
        highlightAlpha = 0.6,
        scaleFactor = 1.15,
        dataLoader = S,
        events = {
            ["PLAYER_ENTERING_WORLD"] = function(self)
                self:GetScript("OnEnter")(self)
            end,
            ["PLAYER_PVP_RANK_CHANGED"] = function(self)
                if GameTooltip:IsOwned(self) then
                    self:GetScript("OnEnter")(self)
                end
            end,
            ["PLAYER_PVP_KILLS_CHANGED"] = function(self)
                if GameTooltip:IsOwned(self) then
                    self:GetScript("OnEnter")(self)
                end
            end
        },
        tooltip = function(T)
            return {
                { "PVP竞技系统", 1, 0.82, 0 },
                { "当前军衔：", T.rank, 0.4, 0.8, 1, 1, 1, 1 },
                { "荣誉击杀：", T.kills, 0.4, 0.8, 1, 1, 1, 1 }
            }
        end,
        onClick = function(self, C)
            if C == "LeftButton" then
                if InCombatLockdown() then
                    print("|cffff0000战斗中无法打开PVP面板|r")
                    return
                end
                if TogglePVPFrame then
                    TogglePVPFrame()
                elseif PVPParentFrame then
                    ToggleFrame(PVPParentFrame)
                else
                    print("|cffff0000无法打开PVP面板|r")
                    UIFrameFlash(self, 0.5, 0.5, 3, false)
                end
            end
        end
    })
end
_G.CreatePVPPanel = R

local function S(B)
    return A(B, {
        name = "lany_StoreIcon",
        xOffset = 0,
        sizeRatio = 0.9,
        texture = "Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\Store.blp",
        highlightAlpha = 0.6,
        scaleFactor = 1.15,
        tooltip = {
            { "暴雪商城", 1, 0.82, 0, 1 },
            { "点击查看最新商品", 0.4, 0.8, 1 }
        },
        onClick = function(_, C)
            if C == "LeftButton" then
                if C_StorePublic and C_StorePublic.IsEnabled() then
                    ToggleStoreUI()
                else
                    if not IsAddOnLoaded("Blizzard_StoreUI") then
                        LoadAddOn("Blizzard_StoreUI")
                    end
                    if StoreFrame then
                        if StoreFrame:IsShown() then
                            HideUIPanel(StoreFrame)
                        else
                            ShowUIPanel(StoreFrame)
                        end
                    else
                        UIErrorsFrame:AddMessage("|TInterface\\MoneyFrame\\UI-GoldIcon:16|t 当前版本无商城功能", 1.0, 0.1, 0.1, 1.0)
                    end
                end
            end
        end
    })
end
_G.CreateDurabilityPanel = S

local function T(B)
    local U = false
    local function V()
        return {
            currencies = {}  
        }
    end
    
    local function W()
        if not U then return end
        local X = 0
        for bag = 0, 4 do
            local Y = C_Container and C_Container.GetContainerNumSlots(bag) or GetContainerNumSlots(bag)
            for slot = 1, Y do
                local Z
                if C_Container and C_Container.GetContainerItemInfo then
                    Z = C_Container.GetContainerItemInfo(bag, slot)
                elseif GetContainerItemInfo then
                    Z = { select(1, GetContainerItemInfo(bag, slot)) }
                    Z.hyperlink = select(2, GetContainerItemInfo(bag, slot))
                    Z.quality = select(3, GetContainerItemInfo(bag, slot))
                    Z.hasNoValue = select(11, GetContainerItemInfo(bag, slot))
                end
                if Z and Z.hyperlink and Z.quality == 0 and not Z.hasNoValue then
                    local A = 0
                    if GetItemInfo then
                        A = select(11, GetItemInfo(Z.hyperlink)) * (Z.stackCount or 1)
                    end
                    if A > 0 then
                        if C_Container and C_Container.UseContainerItem then
                            C_Container.UseContainerItem(bag, slot)
                        elseif UseContainerItem then
                            UseContainerItem(bag, slot)
                        end
                        X = X + A
                    end
                end
            end
        end
        if X > 0 then
            print(string.format("|cff99CCFF已卖出灰色物品，获得：|r%s", GetMoneyString(X)))
        end
    end
    
    return A(B, {
        name = "lany_BagIcon",
        xOffset = 0,
        sizeRatio = 0.9,
        texture = "Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\bags.blp",
        scaleFactor = 1.15,
        dataLoader = V,
        events = {
            ["BAG_UPDATE"] = function(self)
                self.data = V()
            end,
            ["MERCHANT_SHOW"] = function(self)
                W()
            end,
        },
        tooltip = function(X)
            local Y = {
                { "背包", "", 0, 0.6, 1 },
            }
            if GetNumWatchedTokens then
                for i = 1, GetNumWatchedTokens() do
                    local Z, A, B, C = GetBackpackCurrencyInfo(i)
                    if Z and A then
                        local D = 0
                        if C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
                            local E = C_CurrencyInfo.GetCurrencyInfo(C)
                            D = E and E.maxQuantity or 0
                        end
                        local F = Z .. ": " .. A
                        if D > 0 then
                            F = F .. "/" .. D
                        end
                        table.insert(Y, { F, 1, 1, 1 })
                    end
                end
            end
            table.insert(Y, { "左键：打开/关闭背包", 0.6, 0.8, 1 })
            table.insert(Y, { "右键：自动售卖灰色物品", 0.6, 0.8, 1 })
            return Y
        end,
        onClick = function(self, C)
            if C == "LeftButton" then
                ToggleAllBags()
            elseif C == "RightButton" then
                U = true
                W()
                U = false
            end
        end
    })
end
_G.CreateBagPanel = T

local function U(B)

    local menuButton = A(B, {
        name = "FuxPanel_GameMenuIcon",
        xOffset = 0,
        sizeRatio = 0.9,
        texture = "Interface\\AddOns\\MicroMenuBar\\Media\\Icons\\GameMenu.blp",
        blendMode = "ADD",
        scaleFactor = 1.15,
        tooltip = {
            { "游戏菜单", 1, 0.82, 0 },
            { "左键：打开系统菜单", 0.4, 0.8, 1 },
            { "右键：插件设置选项", 1, 0.5, 0 },
            { "alt+右键：重载用户界面", 0.4, 0.8, 1 }
        },
        onClick = function(self, button)
            if button == "LeftButton" then
                if InCombatLockdown() then
                    print("战斗中无法打开游戏菜单")
                    return
                end
                if GameMenuFrame and GameMenuFrame:IsShown() then
                    HideUIPanel(GameMenuFrame)
                else
                    ShowUIPanel(GameMenuFrame)
                end
            elseif button == "RightButton" then
                if IsAltKeyDown() then  
                    ReloadUI()
                else

                    local configWindow = _G["FuxBarConfigWindow"]
                    if not configWindow then
                        configWindow = addon.CreateConfigWindow()
                    end
                    
                    configWindow:SetFrameStrata("FULLSCREEN_DIALOG")
                    
                    if configWindow:IsShown() then
                        configWindow:Hide()
                    else
                        configWindow:Show()
                    end
                end
            end
        end
    })
    
    return menuButton
end
_G.CreatePositionPanel = U
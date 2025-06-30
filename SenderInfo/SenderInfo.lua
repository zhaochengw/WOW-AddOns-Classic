local __addon, __private = ...;

local View = {}
View.Cfg = {};
__private.View = View;
local Main = __private.Main;

-- 创建原生配置框架
local configFrame = CreateFrame("Frame", "SenderInfoConfigFrame", InterfaceOptionsFramePanelContainer)
configFrame.name = "SenderInfo"
configFrame:Hide()

-- 初始化插件
SenderInfo = LibStub("AceAddon-3.0"):NewAddon("SenderInfo");
__private.SenderInfo = SenderInfo;

local L = LibStub("AceLocale-3.0"):GetLocale("SenderInfo");

if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
    SenderInfo.isClassic = true;
elseif (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) then
    SenderInfo.isTBC = true;
elseif (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
    SenderInfo.isRetail = true;
end

-- 默认配置选项
SenderInfo.optionDefaults = {
    global = {
        Open = true,
        SendSelfInfo = true,
        Push = false,
        OpenTeamHelper = true,
        SeekTeamOpen = true,
        LeaderOpenHelper = true,
        TeamHelperViewWidth = 1500,
        AutoOpenHelperTime = 10,
        JoinGroupNotify = true,
        LeaderNotify = true,
        CombatLessen = true,
        JoinSystemMessage = false,
        ShowClassColour = true,
        ShowLevel = true,
        DetailTalent = true,
        ShowWCL = false,
        UseOfficialWCL = true,
        UseUnofficialWCL = false,
        ShowWCLReverse = true,
        ShowWCLHideKills = false,
        ShowWCL10Normal = false,
        ShowWCL10Heroic = false,
        ShowWCL25Normal = false,
        ShowWCL25Heroic = false,
        ShowGS = true,
        ShowEquipLevel = true,
        InfoShowToSystem = true,
        ShowIntervalTime = 30,
        SendSelfInfoInput = "1",
        SendSelfInfoEventWhisper = true,
        SendSelfInfoEventParty = true,
        SendSelfInfoEventRaid = true,
        SendSelfInfoEventGuild = true,
        SendSelfWCL = true,
        SendSelfOfficialWCL = true,
        SendSelfUnofficialWCL = false,
        ReplyMsg1 = "满了",
        ReplyMsg2 = "需要其他职业",
        ReplyMsg3 = "需要其他职责",
        ReplyMsg4 = "",
        ReplyMsg5 = "",
        ReplyMsg6 = "",
        WhiteEquipColourLevel = 230,
        GreenEquipColourLevel = 240,
        BlueEquipColourLevel = 250,
        VioletEquipColourLevel = 260,
        AutoOpenOnMessage = true
    }
}

function SenderInfo:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("SenderInfoOptions", SenderInfo.optionDefaults, "Default");

    -- 注册原生配置页面
    if InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(configFrame)
    else
        local category, layout = Settings.RegisterCanvasLayoutCategory(configFrame, configFrame.name);
        Settings.RegisterAddOnCategory(category);
        self.settingsCategory = category
    end

    -- 初始化配置界面
    self:InitializeConfigUI()
end

-- 创建配置UI的辅助函数
local function createCheckbox(parent, label, description, onClick, order)
    local check = CreateFrame("CheckButton", "SenderInfoCheck" .. label, parent, "InterfaceOptionsCheckButtonTemplate")
    check:SetScript("OnClick", function(self)
        local tick = self:GetChecked()
        onClick(self, tick and true or false)
        if tick then
            PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
        else
            PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
        end
    end)
    check.label = _G[check:GetName() .. "Text"]
    check.label:SetText(label)
    check.tooltipText = label
    check.tooltipRequirement = description
    return check
end

local function createSliderWithLayout(parent, label, description, min, max, step, onClick, order, currentY)
    -- label
    local labelText = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    labelText:SetPoint("TOPLEFT", 20, currentY)
    labelText:SetText(label)
    currentY = currentY - 20
    -- slider
    local slider = CreateFrame("Slider", "SenderInfoSlider" .. label .. order, parent, "OptionsSliderTemplate")
    slider:SetPoint("TOPLEFT", 20, currentY)
    slider:SetMinMaxValues(min, max)
    slider:SetValueStep(step)
    slider:SetScript("OnValueChanged", function(self, value)
        onClick(self, value)
        if self.valueText then
            self.valueText:SetText(string.format("%d", value))
        end
    end)
    slider.tooltipText = label
    slider.tooltipRequirement = description
    currentY = currentY - 20
    -- min/max
    _G[slider:GetName() .. "Low"]:SetText(min)
    _G[slider:GetName() .. "High"]:SetText(max)
    _G[slider:GetName() .. "Text"]:SetText("")
    slider:SetWidth(200)
    -- 当前值显示
    local valueText = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    valueText:SetPoint("LEFT", slider, "RIGHT", 10, 0)
    valueText:SetText(string.format("%d", slider:GetValue()))
    slider.valueText = valueText
    currentY = currentY - 20
    return slider, labelText, currentY
end

local function createEditBoxWithLayout(parent, label, description, onChange, order, currentY)
    -- label
    local labelText = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    labelText:SetPoint("TOPLEFT", 20, currentY)
    labelText:SetText(label)
    currentY = currentY - 20
    -- editbox
    local editBox = CreateFrame("EditBox", "SenderInfoEditBox" .. label .. order, parent, "InputBoxTemplate")
    editBox:SetPoint("TOPLEFT", 20, currentY)
    editBox:SetWidth(200)
    editBox:SetHeight(20)
    editBox:SetScript("OnTextChanged", function(self)
        onChange(self, self:GetText())
    end)
    editBox.tooltipText = label
    editBox.tooltipRequirement = description
    currentY = currentY - 30
    return editBox, labelText, currentY
end

local function createButton(parent, label, description, onClick, order)
    local btn = CreateFrame("Button", "SenderInfoButton" .. (order or label), parent, "UIPanelButtonTemplate")
    btn:SetWidth(160)
    btn:SetHeight(24)
    btn:SetText(label)
    btn:SetScript("OnClick", function(self)
        onClick(self)
        PlaySound(852) -- 按钮点击音效
    end)
    btn.tooltipText = label
    btn.tooltipRequirement = description
    -- 鼠标悬停提示
    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(label)
        if description then
            GameTooltip:AddLine(description, 1, 1, 1, true)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    return btn
end

function SenderInfo:InitializeConfigUI()
    -- 创建标题
    local title = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("|cffff6900SenderInfo (v" .. GetAddOnMetadata("SenderInfo", "Version") .. ")|r")

    -- 创建滚动框架
    local scrollFrame = CreateFrame("ScrollFrame", "SenderInfoScrollFrame", configFrame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -20)
    scrollFrame:SetPoint("BOTTOMRIGHT", -32, 16)

    local scrollChild = CreateFrame("Frame", "SenderInfoScrollChild", scrollFrame)
    scrollChild:SetSize(400, 800)
    scrollFrame:SetScrollChild(scrollChild)

    -- 保存UI元素引用
    self.configUI = {
        frame = configFrame,
        scrollFrame = scrollFrame,
        scrollChild = scrollChild,
        title = title,
        controls = {}
    }

    -- 创建配置控件
    self:CreateConfigControls()
end

function SenderInfo:CreateConfigControls()
    local scrollChild = self.configUI.scrollChild
    local currentY = -20
    local spacing = 25

    -- 插件信息区域（最前面）
    local infoTitle = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    infoTitle:SetPoint("TOPLEFT", 0, currentY)
    infoTitle:SetText("插件信息")
    currentY = currentY - 30

    -- 空白防误触输入框
    local dummyEdit, dummyLabel, newY = createEditBoxWithLayout(scrollChild, "", "", function() end, 0, currentY)
    dummyEdit:SetText("")
    dummyEdit:ClearFocus()
    currentY = newY

    for i = 0, 4 do
        local infoText = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        infoText:SetPoint("TOPLEFT", 20, currentY)
        infoText:SetWidth(350)
        infoText:SetWordWrap(true)
        infoText:SetText(string.format("|cfffff000%s|r", L["插件提示" .. i]))
        infoText:SetJustifyH("LEFT")
        infoText:SetJustifyV("TOP")
        infoText:Show()
        local h = infoText:GetStringHeight() or 20
        currentY = currentY - h - 4
    end
    currentY = currentY - 20 -- 插件信息和设置项之间再空一行

    -- 创建标题
    local title = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 0, currentY)
    title:SetText("基础功能")
    currentY = currentY - 30

    -- 开关选项
    local openCheck = createCheckbox(scrollChild, L["开关标题"], L["开关描述"],
        function(_, value) SenderInfo:SetOpenToggle(nil, value) end, 1)
    openCheck:SetPoint("TOPLEFT", 20, currentY)
    openCheck:SetChecked(self.db.global.Open)
    currentY = currentY - spacing

    -- 发送自己信息
    local sendSelfCheck = createCheckbox(scrollChild, L["是否开启发送自己信息标题"], L["是否开启发送自己信息描述"],
        function(_, value) SenderInfo:SetSendSelfInfoToggle(nil, value) end, 2)
    sendSelfCheck:SetPoint("TOPLEFT", 20, currentY)
    sendSelfCheck:SetChecked(self.db.global.SendSelfInfo)
    currentY = currentY - spacing

    -- 推广选项
    local pushCheck = createCheckbox(scrollChild, L["推广标题"], L["推广描述"],
        function(_, value) SenderInfo:SetPushToggle(nil, value) end, 3)
    pushCheck:SetPoint("TOPLEFT", 20, currentY)
    pushCheck:SetChecked(self.db.global.Push)
    currentY = currentY - spacing

    -- 开团助手
    local teamHelperCheck = createCheckbox(scrollChild, L["开团助手标题"], L["开团助手描述"],
        function(_, value) SenderInfo:SetOpenTeamHelperToggle(nil, value) end, 4)
    teamHelperCheck:SetPoint("TOPLEFT", 20, currentY)
    teamHelperCheck:SetChecked(self.db.global.OpenTeamHelper)
    currentY = currentY - spacing

    -- 收到消息时自动打开小助手
    local autoOpenOnMsgCheck = createCheckbox(scrollChild, "收到消息时自动打开小助手", "收到新消息且小助手未打开时自动弹出界面",
        function(_, value) SenderInfo:SetAutoOpenOnMessageToggle(nil, value) end, 4.5)
    autoOpenOnMsgCheck:SetPoint("TOPLEFT", 40, currentY)
    autoOpenOnMsgCheck:SetChecked(self.db.global.AutoOpenOnMessage)
    currentY = currentY - spacing

    -- 寻求组队
    local seekTeamCheck = createCheckbox(scrollChild, L["寻求组队标题"], L["寻求组队描述"],
        function(_, value) SenderInfo:SetSeekTeamOpenToggle(nil, value) end, 5)
    seekTeamCheck:SetPoint("TOPLEFT", 20, currentY)
    seekTeamCheck:SetChecked(self.db.global.SeekTeamOpen)
    currentY = currentY - spacing

    -- 队长时打开助手
    local leaderHelperCheck = createCheckbox(scrollChild, L["队长时打开助手标题"], L["队长时打开助手描述"],
        function(_, value) SenderInfo:SetLeaderOpenHelperToggle(nil, value) end, 6)
    leaderHelperCheck:SetPoint("TOPLEFT", 20, currentY)
    leaderHelperCheck:SetChecked(self.db.global.LeaderOpenHelper)
    currentY = currentY - spacing

    -- 手动打开助手按钮
    local openHelperBtn = createButton(scrollChild, L["手动打开助手标题"], L["手动打开助手描述"],
        function(_) SenderInfo:ExecuteOpenHelper(nil) end, 7)
    openHelperBtn:SetPoint("TOPLEFT", 20, currentY)
    currentY = currentY - 40

    -- 助手设置区域
    local helperTitle = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    helperTitle:SetPoint("TOPLEFT", 0, currentY)
    helperTitle:SetText("助手设置")
    currentY = currentY - 30

    -- 助手界面宽度
    local widthSlider, widthLabel, newY = createSliderWithLayout(scrollChild, L["开团助手界面宽度标题"], L["开团助手界面宽度描述"],
        300, 3000, 50, function(_, value) SenderInfo:SetTeamHelperViewWidth(nil, value) end, 8, currentY)
    widthSlider:SetValue(self.db.global.TeamHelperViewWidth or 1000)
    currentY = newY

    -- 自动打开时间
    local autoTimeSlider, autoTimeLabel, newY = createSliderWithLayout(scrollChild, L["缩小后自动打开时间标题"], L["缩小后自动打开时间描述"],
        0, 300, 1, function(_, value) SenderInfo:SetAutoOpenHelperTime(nil, value) end, 9, currentY)
    autoTimeSlider:SetValue(self.db.global.AutoOpenHelperTime or 10)
    currentY = newY

    -- 重置位置按钮
    local resetPosBtn = createButton(scrollChild, L["重置小助手位置标题"], L["重置小助手位置描述"],
        function(_) SenderInfo:ExecuteResetHelperViewPos(nil) end, 10)
    resetPosBtn:SetPoint("TOPLEFT", 20, currentY)
    currentY = currentY - 40

    -- 通知设置区域
    local notifyTitle = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    notifyTitle:SetPoint("TOPLEFT", 0, currentY)
    notifyTitle:SetText("通知设置")
    currentY = currentY - 30

    -- 加入通知
    local joinNotifyCheck = createCheckbox(scrollChild, L["加入通知标题"], L["加入通知描述"],
        function(_, value) SenderInfo:SetJoinGroupNotifyToggle(nil, value) end, 21)
    joinNotifyCheck:SetPoint("TOPLEFT", 20, currentY)
    joinNotifyCheck:SetChecked(self.db.global.JoinGroupNotify)
    currentY = currentY - spacing

    -- 仅队长通知
    local leaderNotifyCheck = createCheckbox(scrollChild, L["仅队长通知标题"], L["仅队长通知描述"],
        function(_, value) SenderInfo:SetLeaderNotifyToggle(nil, value) end, 22)
    leaderNotifyCheck:SetPoint("TOPLEFT", 20, currentY)
    leaderNotifyCheck:SetChecked(self.db.global.LeaderNotify)
    currentY = currentY - spacing

    -- 战斗中自动缩小
    local combatLessenCheck = createCheckbox(scrollChild, L["战斗中自动缩小标题"], L["战斗中自动缩小描述"],
        function(_, value) SenderInfo:SetCombatLessenToggle(nil, value) end, 23)
    combatLessenCheck:SetPoint("TOPLEFT", 20, currentY)
    combatLessenCheck:SetChecked(self.db.global.CombatLessen)
    currentY = currentY - spacing

    -- 加入仅自己可见
    local joinSystemCheck = createCheckbox(scrollChild, L["加入仅自己可见标题"], L["加入仅自己可见描述"],
        function(_, value) SenderInfo:SetJoinSystemMessageToggle(nil, value) end, 24)
    joinSystemCheck:SetPoint("TOPLEFT", 20, currentY)
    joinSystemCheck:SetChecked(self.db.global.JoinSystemMessage)
    currentY = currentY - 40

    -- 显示设置区域
    local displayTitle = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    displayTitle:SetPoint("TOPLEFT", 0, currentY - 20)
    displayTitle:SetText("显示设置")
    currentY = currentY - 50

    -- 显示职业颜色
    local showClassColourCheck = createCheckbox(scrollChild, L["显示职业颜色标题"], L["显示职业颜色描述"],
        function(_, value) SenderInfo:SetShowClassColourToggle(nil, value) end, 41)
    showClassColourCheck:SetPoint("TOPLEFT", 20, currentY)
    showClassColourCheck:SetChecked(self.db.global.ShowClassColour)
    currentY = currentY - spacing

    -- 显示等级
    local showLevelCheck = createCheckbox(scrollChild, L["显示等级标题"], L["显示等级描述"],
        function(_, value) SenderInfo:SetShowLevelToggle(nil, value) end, 42)
    showLevelCheck:SetPoint("TOPLEFT", 20, currentY)
    showLevelCheck:SetChecked(self.db.global.ShowLevel)
    currentY = currentY - spacing

    -- 具体天赋加点
    local detailTalentCheck = createCheckbox(scrollChild, L["具体天赋加点提示标题"], L["具体天赋加点提示描述"],
        function(_, value) SenderInfo:SetDetailTalentToggle(nil, value) end, 43)
    detailTalentCheck:SetPoint("TOPLEFT", 20, currentY)
    detailTalentCheck:SetChecked(self.db.global.DetailTalent)
    currentY = currentY - spacing

    -- 显示WCL
    local showWCLCheck = createCheckbox(scrollChild, L["显示WCL标题"], L["显示WCL描述"],
        function(_, value) SenderInfo:SetShowWCLToggle(nil, value) end, 44)
    showWCLCheck:SetPoint("TOPLEFT", 20, currentY)
    showWCLCheck:SetChecked(self.db.global.ShowWCL)
    currentY = currentY - spacing

    -- WCL设置分组
    local wclTitle = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    wclTitle:SetPoint("TOPLEFT", 0, currentY - 20)
    wclTitle:SetText("WCL设置")
    currentY = currentY - 50

    -- 使用官方WCL
    local useOfficialWCLCheck = createCheckbox(scrollChild, L["使用官方WCL标题"], L["使用官方WCL描述"],
        function(_, value) SenderInfo:SetUseOfficialWCLToggle(nil, value) end, 44.5)
    useOfficialWCLCheck:SetPoint("TOPLEFT", 40, currentY)
    useOfficialWCLCheck:SetChecked(self.db.global.UseOfficialWCL)
    currentY = currentY - spacing

    -- 使用非官方WCL
    local useUnofficialWCLCheck = createCheckbox(scrollChild, L["使用非官方WCL标题"], L["使用非官方WCL描述"],
        function(_, value) SenderInfo:SetUseUnofficialWCLToggle(nil, value) end, 44.6)
    useUnofficialWCLCheck:SetPoint("TOPLEFT", 40, currentY)
    useUnofficialWCLCheck:SetChecked(self.db.global.UseUnofficialWCL)
    currentY = currentY - spacing

    -- WCL倒序显示
    local showWCLReverseCheck = createCheckbox(scrollChild, L["WCL倒序显示标题"], L["WCL倒序显示描述"],
        function(_, value) SenderInfo:SetShowWCLReverseToggle(nil, value) end, 45)
    showWCLReverseCheck:SetPoint("TOPLEFT", 40, currentY)
    showWCLReverseCheck:SetChecked(self.db.global.ShowWCLReverse)
    currentY = currentY - spacing

    -- WCL不显示击杀次数
    local showWCLHideKillsCheck = createCheckbox(scrollChild, L["WCL不显示击杀次数标题"], L["WCL不显示击杀次数描述"],
        function(_, value) SenderInfo:SetShowWCLHideKillsToggle(nil, value) end, 46)
    showWCLHideKillsCheck:SetPoint("TOPLEFT", 40, currentY)
    showWCLHideKillsCheck:SetChecked(self.db.global.ShowWCLHideKills)
    currentY = currentY - spacing

    --[[ 

    -- WCL 10人普通
    local showWCL10NormalCheck = createCheckbox(scrollChild, L["WCL10人普通标题"], L["WCL10人普通描述"],
        function(_, value) SenderInfo:SetShowWCL10NormalToggle(nil, value) end, 47)
    showWCL10NormalCheck:SetPoint("TOPLEFT", 40, currentY)
    showWCL10NormalCheck:SetChecked(self.db.global.ShowWCL10Normal)
    currentY = currentY - spacing

    -- WCL 10人精英
    local showWCL10HeroicCheck = createCheckbox(scrollChild, L["WCL10人精英标题"], L["WCL10人精英描述"],
        function(_, value) SenderInfo:SetShowWCL10HeroicToggle(nil, value) end, 48)
    showWCL10HeroicCheck:SetPoint("TOPLEFT", 40, currentY)
    showWCL10HeroicCheck:SetChecked(self.db.global.ShowWCL10Heroic)
    currentY = currentY - spacing

    -- WCL 25人普通
    local showWCL25NormalCheck = createCheckbox(scrollChild, L["WCL25人普通标题"], L["WCL25人普通描述"],
        function(_, value) SenderInfo:SetShowWCL25NormalToggle(nil, value) end, 49)
    showWCL25NormalCheck:SetPoint("TOPLEFT", 40, currentY)
    showWCL25NormalCheck:SetChecked(self.db.global.ShowWCL25Normal)
    currentY = currentY - spacing

    -- WCL 25人精英
    local showWCL25HeroicCheck = createCheckbox(scrollChild, L["WCL25人精英标题"], L["WCL25人精英描述"],
        function(_, value) SenderInfo:SetShowWCL25HeroicToggle(nil, value) end, 50)
    showWCL25HeroicCheck:SetPoint("TOPLEFT", 40, currentY)
    showWCL25HeroicCheck:SetChecked(self.db.global.ShowWCL25Heroic)
    currentY = currentY - spacing

    ]]

    -- 显示GS
    local showGSCheck = createCheckbox(scrollChild, L["显示GS标题"], L["显示GS描述"],
        function(_, value) SenderInfo:SetShowGSToggle(nil, value) end, 51)
    showGSCheck:SetPoint("TOPLEFT", 20, currentY)
    showGSCheck:SetChecked(self.db.global.ShowGS)
    currentY = currentY - spacing

    -- 显示装等
    local showEquipLevelCheck = createCheckbox(scrollChild, L["显示装等标题"], L["显示装等描述"],
        function(_, value) SenderInfo:SetShowEquipLevelToggle(nil, value) end, 52)
    showEquipLevelCheck:SetPoint("TOPLEFT", 20, currentY)
    showEquipLevelCheck:SetChecked(self.db.global.ShowEquipLevel)
    currentY = currentY - spacing

    -- 显示在系统频道
    local infoShowToSystemCheck = createCheckbox(scrollChild, L["显示的信息在系统频道标题"], L["显示的信息在系统频道描述"],
        function(_, value) SenderInfo:SetInfoShowToSystemToggle(nil, value) end, 53)
    infoShowToSystemCheck:SetPoint("TOPLEFT", 20, currentY)
    infoShowToSystemCheck:SetChecked(self.db.global.InfoShowToSystem)
    currentY = currentY - spacing

    -- 提示间隔
    local showIntervalSlider, showIntervalLabel, newY = createSliderWithLayout(scrollChild, L["提示间隔标题"], L["提示间隔描述"],
        0, 600, 10, function(_, value) SenderInfo:SetShowIntervalTime(nil, value) end, 54, currentY)
    showIntervalSlider:SetValue(self.db.global.ShowIntervalTime or 30)
    currentY = newY

    -- 发送设置区域
    local sendTitle = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    sendTitle:SetPoint("TOPLEFT", 0, currentY - 20)
    sendTitle:SetText("发送设置")
    currentY = currentY - 50

    -- 发送自己信息触发内容
    local sendSelfInfoInput, sendSelfInfoLabel, newY = createEditBoxWithLayout(scrollChild, L["发送自己信息标题"], L["发送自己信息描述"],
        function(_, value)
            -- 仅暂存，不立即写入数据库
            self.pendingSendSelfInfoInput = value
        end, 59, currentY)
    sendSelfInfoInput:SetText(self.db.global.SendSelfInfoInput or "")
    -- 确定按钮
    local confirmBtn = createButton(scrollChild, "确定", "点击后保存触发内容", function()
        local old = self.db.global.SendSelfInfoInput or ""
        local new = self.pendingSendSelfInfoInput or sendSelfInfoInput:GetText() or ""
        if old ~= new then
            self.db.global.SendSelfInfoInput = new
            print("[SenderInfo] 触发内容修改成功，之前内容：" .. old .. "，最新内容：" .. new)
        else
            print("[SenderInfo] 触发内容未变化，无需保存。")
        end
    end, 1001)
    confirmBtn:SetPoint("LEFT", sendSelfInfoInput, "RIGHT", 10, 0)
    confirmBtn:SetWidth(60)
    confirmBtn:SetHeight(24)
    confirmBtn:SetText("|cffff2222确定|r")
    currentY = newY

    local sendSelfWhisperCheck = createCheckbox(scrollChild, L["自己信息私聊发送标题"], L["自己信息私聊发送描述"],
        function(_, value) SenderInfo:SetSendSelfInfoEventWhisperToggle(nil, value) end, 61)
    sendSelfWhisperCheck:SetPoint("TOPLEFT", 20, currentY)
    sendSelfWhisperCheck:SetChecked(self.db.global.SendSelfInfoEventWhisper)
    currentY = currentY - spacing

    local sendSelfPartyCheck = createCheckbox(scrollChild, L["自己信息队伍发送标题"], L["自己信息队伍发送描述"],
        function(_, value) SenderInfo:SetSendSelfInfoEventPartyToggle(nil, value) end, 62)
    sendSelfPartyCheck:SetPoint("TOPLEFT", 20, currentY)
    sendSelfPartyCheck:SetChecked(self.db.global.SendSelfInfoEventParty)
    currentY = currentY - spacing

    local sendSelfRaidCheck = createCheckbox(scrollChild, L["自己信息团队发送标题"], L["自己信息团队发送描述"],
        function(_, value) SenderInfo:SetSendSelfInfoEventRaidToggle(nil, value) end, 63)
    sendSelfRaidCheck:SetPoint("TOPLEFT", 20, currentY)
    sendSelfRaidCheck:SetChecked(self.db.global.SendSelfInfoEventRaid)
    currentY = currentY - spacing

    local sendSelfGuildCheck = createCheckbox(scrollChild, L["自己信息公会发送标题"], L["自己信息公会发送描述"],
        function(_, value) SenderInfo:SetSendSelfInfoEventGuildToggle(nil, value) end, 64)
    sendSelfGuildCheck:SetPoint("TOPLEFT", 20, currentY)
    sendSelfGuildCheck:SetChecked(self.db.global.SendSelfInfoEventGuild)
    currentY = currentY - spacing

    local sendSelfWCLCheck = createCheckbox(scrollChild, L["发送自己的WCL标题"], L["发送自己的WCL描述"],
        function(_, value) SenderInfo:SetSendSelfWCLToggle(nil, value) end, 65)
    sendSelfWCLCheck:SetPoint("TOPLEFT", 20, currentY)
    sendSelfWCLCheck:SetChecked(self.db.global.SendSelfWCL)
    currentY = currentY - spacing

    -- 发送设置中的WCL数据源选择
    local sendSelfOfficialWCLCheck = createCheckbox(scrollChild, L["发送使用官方WCL标题"], L["发送使用官方WCL描述"],
        function(_, value) SenderInfo:SetSendSelfOfficialWCLToggle(nil, value) end, 66)
    sendSelfOfficialWCLCheck:SetPoint("TOPLEFT", 40, currentY)
    sendSelfOfficialWCLCheck:SetChecked(self.db.global.SendSelfOfficialWCL)
    currentY = currentY - spacing

    local sendSelfUnofficialWCLCheck = createCheckbox(scrollChild, L["发送使用非官方WCL标题"], L["发送使用非官方WCL描述"],
        function(_, value) SenderInfo:SetSendSelfUnofficialWCLToggle(nil, value) end, 67)
    sendSelfUnofficialWCLCheck:SetPoint("TOPLEFT", 40, currentY)
    sendSelfUnofficialWCLCheck:SetChecked(self.db.global.SendSelfUnofficialWCL)
    currentY = currentY - spacing

    local replyTitle = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    replyTitle:SetPoint("TOPLEFT", 0, currentY - 20)
    replyTitle:SetText("快速回复设置")
    currentY = currentY - 50

    for i = 1, 6 do
        local replyInput, replyLabel, newY = createEditBoxWithLayout(scrollChild, L["快速回复标题"] .. i, L["快速回复描述"],
            function(_, value)
                if i == 1 then
                    SenderInfo:SetReplyMsg1Input(nil, value)
                elseif i == 2 then
                    SenderInfo:SetReplyMsg2Input(nil, value)
                elseif i == 3 then
                    SenderInfo:SetReplyMsg3Input(nil, value)
                elseif i == 4 then
                    SenderInfo:SetReplyMsg4Input(nil, value)
                elseif i == 5 then
                    SenderInfo:SetReplyMsg5Input(nil, value)
                elseif i == 6 then
                    SenderInfo:SetReplyMsg6Input(nil, value)
                end
            end, 70 + i, currentY)
        if i == 1 then
            replyInput:SetText(self.db.global.ReplyMsg1 or "")
        elseif i == 2 then
            replyInput:SetText(self.db.global.ReplyMsg2 or "")
        elseif i == 3 then
            replyInput:SetText(self.db.global.ReplyMsg3 or "")
        elseif i == 4 then
            replyInput:SetText(self.db.global.ReplyMsg4 or "")
        elseif i == 5 then
            replyInput:SetText(self.db.global.ReplyMsg5 or "")
        elseif i == 6 then
            replyInput:SetText(self.db.global.ReplyMsg6 or "")
        end
        currentY = newY
    end

    -- 装等着色设置区域
    local equipTitle = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    equipTitle:SetPoint("TOPLEFT", 0, currentY - 20)
    equipTitle:SetText("装等着色设置")
    currentY = currentY - 50

    -- 白色装备等级
    local whiteLevelSlider, whiteLevelLabel, newY = createSliderWithLayout(scrollChild, L["白色"], L["装等着色等级设置描述"],
        0, 300, 5, function(_, value) SenderInfo:SetWhiteEquipColourLevel(nil, value) end, 100, currentY)
    whiteLevelSlider:SetValue(self.db.global.WhiteEquipColourLevel or 235)
    currentY = newY

    -- 绿色装备等级
    local greenLevelSlider, greenLevelLabel, newY = createSliderWithLayout(scrollChild, L["绿色"], L["装等着色等级设置描述"],
        0, 300, 5, function(_, value) SenderInfo:SetGreenEquipColourLevel(nil, value) end, 101, currentY)
    greenLevelSlider:SetValue(self.db.global.GreenEquipColourLevel or 245)
    currentY = newY

    -- 蓝色装备等级
    local blueLevelSlider, blueLevelLabel, newY = createSliderWithLayout(scrollChild, L["蓝色"], L["装等着色等级设置描述"],
        0, 300, 5, function(_, value) SenderInfo:SetBlueEquipColourLevel(nil, value) end, 102, currentY)
    blueLevelSlider:SetValue(self.db.global.BlueEquipColourLevel or 255)
    currentY = newY

    -- 紫色装备等级
    local violetLevelSlider, violetLevelLabel, newY = createSliderWithLayout(scrollChild, L["紫色"], L["装等着色等级设置描述"],
        0, 300, 5, function(_, value) SenderInfo:SetVioletEquipColourLevel(nil, value) end, 103, currentY)
    violetLevelSlider:SetValue(self.db.global.VioletEquipColourLevel or 265)
    currentY = newY

    -- 恢复默认设置按钮（始终在最下方）
    currentY = currentY - 40
    local resetBtn = createButton(scrollChild, "恢复默认设置", "将所有参数恢复为默认值并重载界面", function()
        StaticPopupDialogs["SENDERINFO_RESET_CONFIRM"] = {
            text = "确定要恢复所有设置为默认值并重载界面吗？此操作不可撤销。",
            button1 = "确定",
            button2 = "取消",
            OnAccept = function()
                SenderInfo.db:ResetDB("Default")
                ReloadUI()
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,
        }
        StaticPopup_Show("SENDERINFO_RESET_CONFIRM")
    end, 999)
    resetBtn:SetPoint("TOPLEFT", 20, currentY)
    resetBtn:SetWidth(200)
    resetBtn:SetHeight(28)
    resetBtn:SetText("|cffff2222恢复默认设置|r")
    self.configUI.controls.resetBtn = resetBtn

    -- 更新滚动区域大小
    scrollChild:SetHeight(math.abs(currentY) + 50)

    -- 保存控件引用
    self.configUI.controls = {
        openCheck = openCheck,
        sendSelfCheck = sendSelfCheck,
        pushCheck = pushCheck,
        teamHelperCheck = teamHelperCheck,
        seekTeamCheck = seekTeamCheck,
        leaderHelperCheck = leaderHelperCheck,
        openHelperBtn = openHelperBtn,
        widthSlider = widthSlider,
        autoTimeSlider = autoTimeSlider,
        resetPosBtn = resetPosBtn,
        joinNotifyCheck = joinNotifyCheck,
        leaderNotifyCheck = leaderNotifyCheck,
        combatLessenCheck = combatLessenCheck,
        joinSystemCheck = joinSystemCheck,
        showClassColourCheck = showClassColourCheck,
        showLevelCheck = showLevelCheck,
        detailTalentCheck = detailTalentCheck,
        showWCLCheck = showWCLCheck,
        useOfficialWCLCheck = useOfficialWCLCheck,
        useUnofficialWCLCheck = useUnofficialWCLCheck,
        showWCLReverseCheck = showWCLReverseCheck,
        showWCLHideKillsCheck = showWCLHideKillsCheck,
        showWCL10NormalCheck = showWCL10NormalCheck,
        showWCL10HeroicCheck = showWCL10HeroicCheck,
        showWCL25NormalCheck = showWCL25NormalCheck,
        showWCL25HeroicCheck = showWCL25HeroicCheck,
        showGSCheck = showGSCheck,
        showEquipLevelCheck = showEquipLevelCheck,
        infoShowToSystemCheck = infoShowToSystemCheck,
        showIntervalSlider = showIntervalSlider,
        sendSelfInfoInput = sendSelfInfoInput,
        sendSelfWhisperCheck = sendSelfWhisperCheck,
        sendSelfPartyCheck = sendSelfPartyCheck,
        sendSelfRaidCheck = sendSelfRaidCheck,
        sendSelfGuildCheck = sendSelfGuildCheck,
        sendSelfWCLCheck = sendSelfWCLCheck,
        sendSelfOfficialWCLCheck = sendSelfOfficialWCLCheck,
        sendSelfUnofficialWCLCheck = sendSelfUnofficialWCLCheck,
        whiteLevelSlider = whiteLevelSlider,
        greenLevelSlider = greenLevelSlider,
        blueLevelSlider = blueLevelSlider,
        violetLevelSlider = violetLevelSlider
    }

    -- 主动清除所有EditBox焦点，防止自动聚焦
    for _, ctrl in pairs(self.configUI.controls) do
        if ctrl and ctrl.ClearFocus then ctrl:ClearFocus() end
    end
end

local function PintBool(value, title)
    print(string.format("%s: %s", title or "", value and "True" or "False"))
end


local function ChangeShowHeader(info)
    if not __private.Load.Prepare and info == nil then
        return;
    end

    local txt = "";

    if SenderInfo.db.global.DetailTalent then
        if SenderInfo.db.global.ShowLevel then
            txt = txt .. L["天赋提示预览1"]
        else
            txt = txt .. L["天赋提示预览3"]
        end
    else
        if SenderInfo.db.global.ShowLevel then
            txt = txt .. L["天赋提示预览2"]
        else
            txt = txt .. L["天赋提示预览4"]
        end
    end

    if SenderInfo.db.global.ShowClassColour then
        txt = string.format(L["职业颜色2"], txt)
    else
        txt = string.format(L["职业颜色1"], txt)
    end

    if SenderInfo.db.global.ShowWCL then
        if SenderInfo.db.global.UseOfficialWCL then
            txt = txt .. L["官方WCL显示"]
        elseif SenderInfo.db.global.UseUnofficialWCL then
            txt = txt .. L["非官方WCL显示"]
        else
            txt = txt .. L["WCL显示"]
        end
    end

    if SenderInfo.db.global.ShowGS then
        txt = txt .. L["GS显示"]
    end

    if SenderInfo.db.global.ShowEquipLevel then
        txt = txt .. L["平均装等显示"]
    end


    if SenderInfo.db.global.Push and (not SenderInfo.db.global.InfoShowToSystem) then
        txt = txt .. L["推广后缀"]
    end

    if SenderInfo.configUI and SenderInfo.configUI.controls and SenderInfo.configUI.controls.ShowHeader then
        SenderInfo.configUI.controls.ShowHeader:SetText(string.format("|CffDEDE42%s|r\n\n   %s \n\n", L["预览"],
            (info or txt)))
    end
end


function SenderInfo:SetTextToggle(info, value)
    self.db.global.TextToggle = value;
    ChangeShowHeader();
end

function SenderInfo:GetTextToggle(info)
    return self.db.global.TextToggle;
end

--------- Open ------------

function SenderInfo:SetOpenToggle(info, value)
    self.db.global.Open = value;
    Main:ChangeOpen(value);
    ChangeShowHeader();
end

function SenderInfo:GetOpenToggle(info)
    return self.db.global.Open;
end

--------- Open ------------

--快捷开关
SLASH_SINFOP1 = "/sinfop";
SlashCmdList["SINFOP"] = function()
    local open = SenderInfo.db.global.Open;
    SenderInfo:SetOpenToggle(nil, not open);
end;


--------- Push ------------

function SenderInfo:SetPushToggle(info, value)
    self.db.global.Push = value;
    Main:ChangePush(value);
    ChangeShowHeader();
end

function SenderInfo:GetPushToggle(info)
    return self.db.global.Push;
end

--------- Push ------------


--------- DetailTalent ------------

function SenderInfo:SetDetailTalentToggle(info, value)
    self.db.global.DetailTalent = value;
    Main:ChangeDetailTalent(value);
    ChangeShowHeader();
end

function SenderInfo:GetDetailTalentToggle(info)
    return self.db.global.DetailTalent;
end

--------- DetailTalent ------------


--------- ShowLevel ------------

function SenderInfo:SetShowLevelToggle(info, value)
    self.db.global.ShowLevel = value;
    Main:ChangeShowLevel(value);
    ChangeShowHeader();
end

function SenderInfo:GetShowLevelToggle(info)
    return self.db.global.ShowLevel;
end

--------- ShowLevel ------------


--------- ShowClassColour ------------

function SenderInfo:SetShowClassColourToggle(info, value)
    self.db.global.ShowClassColour = value;
    Main:ChangeShowClassColour(value);
    ChangeShowHeader();
end

function SenderInfo:GetShowClassColourToggle(info)
    return self.db.global.ShowClassColour;
end

--------- ShowClassColour ------------



--------- ShowEquipLevel ------------

function SenderInfo:SetShowEquipLevelToggle(info, value)
    self.db.global.ShowEquipLevel = value;
    Main:ChangeShowEquipLevel(value);
end

function SenderInfo:GetShowEquipLevelToggle(info)
    return self.db.global.ShowEquipLevel;
end

--------- ShowEquipLevel ------------


--------- GetCombatLessenToggle ------------


function SenderInfo:SetCombatLessenToggle(info, value)
    self.db.global.CombatLessen = value;
    __private.InviteTeamView:ChangeCombatLessen(value);
end

function SenderInfo:GetCombatLessenToggle(info)
    return self.db.global.CombatLessen;
end

--------- GetCombatLessenToggle ------------


--------- JoinSystemMessageToggle ------------


function SenderInfo:SetJoinSystemMessageToggle(info, value)
    self.db.global.JoinSystemMessage = value;
    __private.InviteTeamView:ChangeJoinSystemMessage(value);
end

function SenderInfo:GetJoinSystemMessageToggle(info)
    return self.db.global.JoinSystemMessage;
end

--------- JoinSystemMessageToggle ------------



--------- InfoShowToSystem ------------

function SenderInfo:SetInfoShowToSystemToggle(info, value)
    self.db.global.InfoShowToSystem = value;
    Main:ChangeInfoShowToSystem(value);
    ChangeShowHeader();
end

function SenderInfo:GetInfoShowToSystemToggle(info)
    return self.db.global.InfoShowToSystem;
end

--------- InfoShowToSystem ------------


--------- ShowGS ------------

function SenderInfo:SetShowGSToggle(info, value)
    self.db.global.ShowGS = value;
    Main:ChangeShowGS(value);
    ChangeShowHeader();
end

function SenderInfo:GetShowGSToggle(info)
    return self.db.global.ShowGS;
end

--------- ShowGS ------------


--------- ShowWCL ------------

function SenderInfo:SetShowWCLToggle(info, value)
    self.db.global.ShowWCL = value;
    Main:ChangeShowWCL(value);
    ChangeShowHeader();
end

function SenderInfo:GetShowWCLToggle(info)
    return self.db.global.ShowWCL;
end

--------- ShowWCL ------------

--------- UseOfficialWCL ------------

function SenderInfo:SetUseOfficialWCLToggle(info, value)
    self.db.global.UseOfficialWCL = value;
    Main:ChangeUseOfficialWCL(value);
    ChangeShowHeader();
end

function SenderInfo:GetUseOfficialWCLToggle(info)
    return self.db.global.UseOfficialWCL;
end

--------- UseOfficialWCL ------------

--------- UseUnofficialWCL ------------

function SenderInfo:SetUseUnofficialWCLToggle(info, value)
    self.db.global.UseUnofficialWCL = value;
    Main:ChangeUseUnofficialWCL(value);
    ChangeShowHeader();
end

function SenderInfo:GetUseUnofficialWCLToggle(info)
    return self.db.global.UseUnofficialWCL;
end

--------- UseUnofficialWCL ------------

--------- ShowWCLReverse ------------

function SenderInfo:SetShowWCLReverseToggle(info, value)
    self.db.global.ShowWCLReverse = value;
    Main:ChangeShowWCLReverse(value);
end

function SenderInfo:GetShowWCLReverseToggle(info)
    return self.db.global.ShowWCLReverse;
end

--------- ShowWCLReverse ------------

--------- ShowWCLHideKills ------------

function SenderInfo:SetShowWCLHideKillsToggle(info, value)
    self.db.global.ShowWCLHideKills = value;
    Main:ChangeShowWCLHideKills(value);
end

function SenderInfo:GetShowWCLHideKillsToggle(info)
    return self.db.global.ShowWCLHideKills;
end

--------- ShowWCLHideKills ------------

--------- ShowWCL10Normal ------------

function SenderInfo:SetShowWCL10NormalToggle(info, value)
    self.db.global.ShowWCL10Normal = value;
    Main:ChangeShowWCL10Normal(value);
end

function SenderInfo:GetShowWCL10NormalToggle(info)
    return self.db.global.ShowWCL10Normal;
end

--------- ShowWCL10Normal ------------

--------- ShowWCL10Heroic ------------

function SenderInfo:SetShowWCL10HeroicToggle(info, value)
    self.db.global.ShowWCL10Heroic = value;
    Main:ChangeShowWCL10Heroic(value);
end

function SenderInfo:GetShowWCL10HeroicToggle(info)
    return self.db.global.ShowWCL10Heroic;
end

--------- ShowWCL10Heroic ------------

--------- ShowWCL25Normal ------------

function SenderInfo:SetShowWCL25NormalToggle(info, value)
    self.db.global.ShowWCL25Normal = value;
    Main:ChangeShowWCL25Normal(value);
end

function SenderInfo:GetShowWCL25NormalToggle(info)
    return self.db.global.ShowWCL25Normal;
end

--------- ShowWCL25Normal ------------

--------- ShowWCL25Heroic ------------

function SenderInfo:SetShowWCL25HeroicToggle(info, value)
    self.db.global.ShowWCL25Heroic = value;
    Main:ChangeShowWCL25Heroic(value);
end

function SenderInfo:GetShowWCL25HeroicToggle(info)
    return self.db.global.ShowWCL25Heroic;
end

--------- ShowWCL25Heroic ------------


function SenderInfo:ExecuteOpenHelper(info)
    __private.InviteTeamView:SwichViewHelper();
end

function SenderInfo:ExecuteResetHelperViewPos(info)
    __private.InviteTeamView:ResetHelperViewPos();
end

function View:Init()
    Main = __private.Main;

    View.Cfg = SenderInfo.db.global;

    SenderInfo:SetOpenToggle(nil, SenderInfo.db.global.Open);
end

function SenderInfo:SetAutoOpenOnMessageToggle(info, value)
    self.db.global.AutoOpenOnMessage = value;
    if __private.InviteTeamView and __private.InviteTeamView.ChangeAutoOpenOnMessage then
        __private.InviteTeamView:ChangeAutoOpenOnMessage(value)
    end
end

function SenderInfo:GetAutoOpenOnMessageToggle(info)
    return self.db.global.AutoOpenOnMessage;
end

--------- ShowIntervalTime ------------

function SenderInfo:SetShowIntervalTime(info, value)
    self.db.global.ShowIntervalTime = value;
    if Main and Main.ChangeShowIntervalTime then
        Main:ChangeShowIntervalTime(value)
    end
end

function SenderInfo:GetShowIntervalTime(info)
    return self.db.global.ShowIntervalTime;
end

--------- ShowIntervalTime ------------


--------- SendSelfInfoEvent ------------

function SenderInfo:SetSendSelfInfoEventWhisperToggle(info, value)
    self.db.global.SendSelfInfoEventWhisper = value;
    Main:ChangeSendSelfInfoEventWhisper(value);
end

function SenderInfo:GetSendSelfInfoEventWhisperToggle(info)
    return self.db.global.SendSelfInfoEventWhisper;
end

function SenderInfo:SetSendSelfInfoEventPartyToggle(info, value)
    self.db.global.SendSelfInfoEventParty = value;
    Main:ChangeSendSelfInfoEventParty(value);
end

function SenderInfo:GetSendSelfInfoEventPartyToggle(info)
    return self.db.global.SendSelfInfoEventParty;
end

function SenderInfo:SetSendSelfInfoEventRaidToggle(info, value)
    self.db.global.SendSelfInfoEventRaid = value;
    Main:ChangeSendSelfInfoEventRaid(value);
end

function SenderInfo:GetSendSelfInfoEventRaidToggle(info)
    return self.db.global.SendSelfInfoEventRaid;
end

function SenderInfo:SetSendSelfInfoEventGuildToggle(info, value)
    self.db.global.SendSelfInfoEventGuild = value;
    Main:ChangeSendSelfInfoEventGuild(value);
end

function SenderInfo:GetSendSelfInfoEventGuildToggle(info)
    return self.db.global.SendSelfInfoEventGuild;
end

function SenderInfo:SetSendSelfInfoInput(info, value)
    self.db.global.SendSelfInfoInput = value;
    Main:ChangeSendSelfInfoCondition(value);
end

function SenderInfo:GetSendSelfInfoInput(info)
    return self.db.global.SendSelfInfoInput;
end

--------- SendSelfInfoEvent ------------



--------- SendSelfInfo ------------

function SenderInfo:SetSendSelfInfoToggle(info, value)
    self.db.global.SendSelfInfo = value;
    Main:ChangeSendSelfInfo(value);
end

function SenderInfo:GetSendSelfInfoToggle(info)
    return self.db.global.SendSelfInfo;
end

--------- SendSelfInfo ------------



--------- OpenTeamHelper ------------

function SenderInfo:SetOpenTeamHelperToggle(info, value)
    self.db.global.OpenTeamHelper = value;
    __private.InviteTeamView:ChangeOpenTeamHelper(value);
end

function SenderInfo:GetOpenTeamHelperToggle(info)
    return self.db.global.OpenTeamHelper;
end

--------- OpenTeamHelper ------------



--------- TeamHelperViewWidth ------------

function SenderInfo:SetTeamHelperViewWidth(info, value)
    self.db.global.TeamHelperViewWidth = value
    if __private.InviteTeamView and __private.InviteTeamView.ChangeViewWidth then
        __private.InviteTeamView:ChangeViewWidth(value)
    end
end

function SenderInfo:GetTeamHelperViewWidth(info)
    return self.db.global.TeamHelperViewWidth;
end

--------- TeamHelperViewWidth ------------


--------- AutoOpenHelperTime ------------

function SenderInfo:SetAutoOpenHelperTime(info, value)
    self.db.global.AutoOpenHelperTime = value
    if __private.InviteTeamView and __private.InviteTeamView.ChangeAutoOpenHelperTime then
        __private.InviteTeamView:ChangeAutoOpenHelperTime(value)
    end
end

function SenderInfo:GetAutoOpenHelperTime(info)
    return self.db.global.AutoOpenHelperTime;
end

--------- AutoOpenHelperTime ------------



--------- JoinGroupNotify ------------

function SenderInfo:SetJoinGroupNotifyToggle(info, value)
    self.db.global.JoinGroupNotify = value;
    __private.Main:ChangeJoinGroupNotify(value);
end

function SenderInfo:GetJoinGroupNotifyToggle(info)
    return self.db.global.JoinGroupNotify;
end

--------- JoinGroupNotify ------------

--------- LeaderNotify ------------

function SenderInfo:SetLeaderNotifyToggle(info, value)
    self.db.global.LeaderNotify = value;
    __private.Main:ChangeLeaderNotify(value);
end

function SenderInfo:GetLeaderNotifyToggle(info)
    return self.db.global.LeaderNotify;
end

--------- LeaderNotify ------------


--------- SeekTeamOpen ------------

function SenderInfo:SetSeekTeamOpenToggle(info, value)
    self.db.global.SeekTeamOpen = value;
    __private.InviteTeamView:ChangeSeekTeamOpen(value);
end

function SenderInfo:GetSeekTeamOpenToggle(info)
    return self.db.global.SeekTeamOpen;
end

function SenderInfo:SetLeaderOpenHelperToggle(info, value)
    self.db.global.LeaderOpenHelper = value;
    __private.InviteTeamView:ChangeLeaderOpenHelper(value);
end

function SenderInfo:GetLeaderOpenHelperToggle(info)
    return self.db.global.LeaderOpenHelper;
end

--------- SeekTeamOpen ------------

--------- ReplyMsg ------------

function SenderInfo:SetReplyMsg1Input(info, value)
    self.db.global.ReplyMsg1 = value;
    __private.InviteTeamView:ChangeReplyMsg1(value);
end

function SenderInfo:GetReplyMsg1Input(info)
    return self.db.global.ReplyMsg1;
end

function SenderInfo:SetReplyMsg2Input(info, value)
    self.db.global.ReplyMsg2 = value;
    __private.InviteTeamView:ChangeReplyMsg2(value);
end

function SenderInfo:GetReplyMsg2Input(info)
    return self.db.global.ReplyMsg2;
end

function SenderInfo:SetReplyMsg3Input(info, value)
    self.db.global.ReplyMsg3 = value;
    __private.InviteTeamView:ChangeReplyMsg3(value);
end

function SenderInfo:GetReplyMsg3Input(info)
    return self.db.global.ReplyMsg3;
end

function SenderInfo:SetReplyMsg4Input(info, value)
    self.db.global.ReplyMsg4 = value;
    __private.InviteTeamView:ChangeReplyMsg4(value);
end

function SenderInfo:GetReplyMsg4Input(info)
    return self.db.global.ReplyMsg4;
end

function SenderInfo:SetReplyMsg5Input(info, value)
    self.db.global.ReplyMsg5 = value;
    __private.InviteTeamView:ChangeReplyMsg5(value);
end

function SenderInfo:GetReplyMsg5Input(info)
    return self.db.global.ReplyMsg5;
end

function SenderInfo:SetReplyMsg6Input(info, value)
    self.db.global.ReplyMsg6 = value;
    __private.InviteTeamView:ChangeReplyMsg6(value);
end

function SenderInfo:GetReplyMsg6Input(info)
    return self.db.global.ReplyMsg6;
end

--------- ReplyMsg ------------


--------- EquipColourLevel ------------

function SenderInfo:SetWhiteEquipColourLevel(info, value)
    self.db.global.WhiteEquipColourLevel = value
    if Main and Main.ChangeWhiteEquipColourLevel then
        Main:ChangeWhiteEquipColourLevel(value)
    end
end

function SenderInfo:GetWhiteEquipColourLevel(info)
    return self.db.global.WhiteEquipColourLevel;
end

function SenderInfo:SetGreenEquipColourLevel(info, value)
    self.db.global.GreenEquipColourLevel = value
    if Main and Main.ChangeGreenEquipColourLevel then
        Main:ChangeGreenEquipColourLevel(value)
    end
end

function SenderInfo:GetGreenEquipColourLevel(info)
    return self.db.global.GreenEquipColourLevel;
end

function SenderInfo:SetBlueEquipColourLevel(info, value)
    self.db.global.BlueEquipColourLevel = value
    if Main and Main.ChangeBlueEquipColourLevel then
        Main:ChangeBlueEquipColourLevel(value)
    end
end

function SenderInfo:GetBlueEquipColourLevel(info)
    return self.db.global.BlueEquipColourLevel;
end

function SenderInfo:SetVioletEquipColourLevel(info, value)
    self.db.global.VioletEquipColourLevel = value
    if Main and Main.ChangeVioletEquipColourLevel then
        Main:ChangeVioletEquipColourLevel(value)
    end
end

function SenderInfo:GetVioletEquipColourLevel(info)
    return self.db.global.VioletEquipColourLevel;
end

--------- EquipColourLevel ------------

--------- SendSelfWCL ------------
function SenderInfo:SetSendSelfWCLToggle(info, value)
    self.db.global.SendSelfWCL = value;
    Main:ChangeSendSelfWCL(value);
end

function SenderInfo:GetSendSelfWCLToggle(info)
    return self.db.global.SendSelfWCL;
end
--------- SendSelfWCL ------------

--------- SendSelfOfficialWCL ------------
function SenderInfo:SetSendSelfOfficialWCLToggle(info, value)
    self.db.global.SendSelfOfficialWCL = value;
    Main:ChangeSendSelfOfficialWCL(value);
end

function SenderInfo:GetSendSelfOfficialWCLToggle(info)
    return self.db.global.SendSelfOfficialWCL;
end
--------- SendSelfOfficialWCL ------------

--------- SendSelfUnofficialWCL ------------
function SenderInfo:SetSendSelfUnofficialWCLToggle(info, value)
    self.db.global.SendSelfUnofficialWCL = value;
    Main:ChangeSendSelfUnofficialWCL(value);
end

function SenderInfo:GetSendSelfUnofficialWCLToggle(info)
    return self.db.global.SendSelfUnofficialWCL;
end
--------- SendSelfUnofficialWCL ------------

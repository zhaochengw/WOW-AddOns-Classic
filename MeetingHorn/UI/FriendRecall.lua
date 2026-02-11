-- FriendRecall.lua  战友召回
-- @Author : Generated
-- @Date   : 23/12/2025, 4:20:00 PM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local FriendRecall = ns.Addon:NewClass('UI.FriendRecall', 'Frame')
LibStub:GetLibrary('AceEvent-3.0'):Embed(FriendRecall)

-- 职业图标路径映射
local CLASS_ICONS = {
    ["WARRIOR"] = "Interface\\Icons\\ClassIcon_Warrior",
    ["PALADIN"] = "Interface\\Icons\\ClassIcon_Paladin",
    ["HUNTER"] = "Interface\\Icons\\ClassIcon_Hunter",
    ["ROGUE"] = "Interface\\Icons\\ClassIcon_Rogue",
    ["PRIEST"] = "Interface\\Icons\\ClassIcon_Priest",
    ["DEATHKNIGHT"] = "Interface\\Icons\\ClassIcon_DeathKnight",
    ["SHAMAN"] = "Interface\\Icons\\ClassIcon_Shaman",
    ["MAGE"] = "Interface\\Icons\\ClassIcon_Mage",
    ["WARLOCK"] = "Interface\\Icons\\ClassIcon_Warlock",
    ["DRUID"] = "Interface\\Icons\\ClassIcon_Druid"
}

function FriendRecall:Constructor()
    self.db = ns.Addon.db
    self.currentPage = 1
    self.friendsData = {}
    self.FriendRecallVersion = 1
    self.countdownTimer = nil

    self:RegisterMessage('MEETINGHORN_SHOW')
    self:RegisterMessage('MEETINGHORN_SQIR')
    self:RegisterMessage('MEETINGHORN_SERVER_CONNECTED')

    -- 创建顶部信息容器
    self.TopContainer = CreateFrame("Frame", nil, self)
    self.TopContainer:SetPoint("TOPLEFT", self, "TOPLEFT", 10, -10)
    self.TopContainer:SetSize(800, 120)

    -- 左侧活动信息窗口
    self.InfoPanel = CreateFrame("Frame", nil, self.TopContainer, "InsetFrameTemplate")
    self.InfoPanel:SetPoint("TOPLEFT", self.TopContainer, "TOPLEFT", 0, 0)
    self.InfoPanel:SetSize(520, 120)

    -- 主标题
    self.TitleLabel = self.InfoPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    self.TitleLabel:SetText("战友召回活动")
    self.TitleLabel:SetPoint("TOPLEFT", self.InfoPanel, "TOPLEFT", 15, -15)
    self.TitleLabel:SetJustifyH("LEFT")
    self.TitleLabel:SetTextColor(1, 0.82, 0, 1)

    -- 活动时间
    self.TimeLabel = self.InfoPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    self.TimeLabel:SetText("活动时间：2025.12.23 - 2025.12.30")
    self.TimeLabel:SetPoint("TOPLEFT", self.TitleLabel, "BOTTOMLEFT", 0, -10)
    self.TimeLabel:SetJustifyH("LEFT")
    self.TimeLabel:SetTextColor(0.9, 0.9, 0.9, 1)

    -- 活动介绍
    self.IntroLabel = self.InfoPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    self.IntroLabel:SetText("活动规则：邀请老友重返艾泽拉斯，共同体验全新的冒险之旅。成功召回战友可获得丰厚奖励，包括坐骑、宠物、金币等珍贵物品。每位玩家最多可召回3名战友，活动期间内完成指定任务即可获得对应奖励。")
    self.IntroLabel:SetPoint("TOPLEFT", self.TimeLabel, "BOTTOMLEFT", 0, -10)
    self.IntroLabel:SetWidth(470)
    self.IntroLabel:SetJustifyH("LEFT")
    self.IntroLabel:SetTextColor(0.8, 0.8, 0.8, 1)

    -- 右侧倒计时窗口
    self.CountdownPanel = CreateFrame("Frame", nil, self.TopContainer, "InsetFrameTemplate")
    self.CountdownPanel:SetPoint("TOPLEFT", self.InfoPanel, "TOPRIGHT", 10, 0)
    self.CountdownPanel:SetSize(280, 120)

    -- 倒计时标题
    self.CountdownTitle = self.CountdownPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    self.CountdownTitle:SetText("活动剩余时间")
    self.CountdownTitle:SetPoint("TOP", self.CountdownPanel, "TOP", 0, -15)
    self.CountdownTitle:SetTextColor(0.7, 0.7, 0.7, 1)

    -- 倒计时框架
    self.CountdownFrame = CreateFrame("Frame", nil, self.CountdownPanel, "InsetFrameTemplate")
    self.CountdownFrame:SetPoint("CENTER", self.CountdownPanel, "CENTER", 0, -10)
    self.CountdownFrame:SetSize(250, 60)

    -- 倒计时文本
    self.CountdownText = self.CountdownFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
    self.CountdownText:SetPoint("CENTER", self.CountdownFrame, "CENTER", 0, 0)
    self.CountdownText:SetTextColor(0, 1, 0, 1) -- 绿色

    -- 创建好友列表容器窗口
    self.FriendsMainContainer = CreateFrame("Frame", nil, self, "InsetFrameTemplate")
    self.FriendsMainContainer:SetPoint("TOPLEFT", self.TopContainer, "BOTTOMLEFT", 0, -10)
    self.FriendsMainContainer:SetSize(810, 250)

    -- 好友窗口容器
    self.FriendsContainer = CreateFrame("Frame", nil, self.FriendsMainContainer)
    self.FriendsContainer:SetPoint("TOPLEFT", self.FriendsMainContainer, "TOPLEFT", 10, -10)
    self.FriendsContainer:SetSize(780, 180)

    -- 创建分页控件容器
    self.PaginationContainer = CreateFrame("Frame", nil, self.FriendsMainContainer)
    self.PaginationContainer:SetPoint("BOTTOM", self.FriendsMainContainer, "BOTTOM", 0, 10)
    self.PaginationContainer:SetSize(400, 30)

    -- 初始化好友数据和分页
    self:InitializeFriendsData()
    self:CreatePaginationControls()
    self:StartCountdown()

    -- 初始显示
    self:UpdateFriendsDisplay()

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)

    -- 处理在初始化过程中收到的暂存数据
    if self.pendingServerData then
        local data = self.pendingServerData
        self.pendingServerData = nil
        self:UpdateServerData(data)
    end
end

function FriendRecall:InitializeFriendsData()
    -- 初始化为空的好友数据，等待服务器数据
    self.friendsData = {}
end

function FriendRecall:CreateFriendWindow(friendData)
    local window = CreateFrame("Frame", nil, self.FriendsContainer, "InsetFrameTemplate")
    window:SetSize(200, 200)

    -- 职业头像
    window.classIcon = window:CreateTexture(nil, "ARTWORK")
    window.classIcon:SetSize(64, 64)
    window.classIcon:SetPoint("TOP", window, "TOP", 0, -20)
    window.classIcon:SetTexture(CLASS_ICONS[friendData.class] or "Interface\\Icons\\INV_Misc_QuestionMark")

    -- 角色名字
    window.nameLabel = window:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    window.nameLabel:SetText(friendData.name)
    window.nameLabel:SetPoint("TOP", window.classIcon, "BOTTOM", 0, -10)
    window.nameLabel:SetTextColor(1, 1, 1, 1)

    -- 服务器名字
    window.serverLabel = window:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    window.serverLabel:SetText(friendData.server)
    window.serverLabel:SetPoint("TOP", window.nameLabel, "BOTTOM", 0, -5)
    window.serverLabel:SetTextColor(0.7, 0.7, 0.7, 1)

    -- 离线天数（只有存在时才显示）
    window.offlineDaysLabel = window:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    if friendData.lost_days and friendData.lost_days > 0 then
        window.offlineDaysLabel:SetText("离线" .. friendData.lost_days .. "天")
        window.offlineDaysLabel:SetPoint("TOP", window.serverLabel, "BOTTOM", 0, -3)
        window.offlineDaysLabel:SetTextColor(0.5, 0.5, 0.5, 1) -- 灰色
        window.offlineDaysLabel:Show()
    else
        window.offlineDaysLabel:Hide()
    end

    -- 立即召唤按钮
    window.recallButton = CreateFrame("Button", nil, window, "GameMenuButtonTemplate")
    window.recallButton:SetSize(120, 30)
    window.recallButton:SetPoint("BOTTOM", window, "BOTTOM", 0, 15)

    -- 根据invited状态设置按钮文本和颜色
    if friendData.invited then
        window.recallButton:SetText("查看召唤结果")
        -- 设置绿色文字
        window.recallButton:SetNormalFontObject("GameFontNormal")
        window.recallButton:GetFontString():SetTextColor(0, 0.8, 0, 1) -- 绿色文字
    else
        window.recallButton:SetText("立即召回")
        -- 恢复默认文字颜色
        window.recallButton:SetNormalFontObject("GameFontNormal")
        window.recallButton:GetFontString():SetTextColor(1, 1, 1, 1) -- 白色文字
    end

    window.recallButton:SetScript("OnClick", function()
        self:OnRecallButtonClick(friendData)
    end)

    return window
end

function FriendRecall:UpdateFriendsDisplay()
    -- 清除现有窗口
    if self.friendWindows then
        for _, window in ipairs(self.friendWindows) do
            window:Hide()
        end
    end
    self.friendWindows = {}

    -- 计算当前页面显示的好友
    local totalFriends = #self.friendsData
    local startIndex = (self.currentPage - 1) * 3 + 1
    local endIndex = math.min(startIndex + 2, totalFriends)
    local displayCount = endIndex - startIndex + 1

    -- 创建并定位好友窗口
    for i = 1, displayCount do
        local friendIndex = startIndex + i - 1
        local friendData = self.friendsData[friendIndex]
        local window = self:CreateFriendWindow(friendData)
        table.insert(self.friendWindows, window)

        -- 根据数量调整位置
        if displayCount == 1 then
            -- 单个居中
            window:SetPoint("CENTER", self.FriendsContainer, "CENTER", 0, -8)
        elseif displayCount == 2 then
            -- 两个居中
            if i == 1 then
                window:SetPoint("CENTER", self.FriendsContainer, "CENTER", -110, -8)
            else
                window:SetPoint("CENTER", self.FriendsContainer, "CENTER", 110, -8)
            end
        else
            -- 三个并排
            local xOffset = (i - 2) * 220
            window:SetPoint("CENTER", self.FriendsContainer, "CENTER", xOffset, -8)
        end

        window:Show()
    end

    -- 更新分页按钮状态
    self:UpdatePaginationButtons()
end

function FriendRecall:NextPage()
    local totalFriends = #self.friendsData
    local maxPages = math.ceil(totalFriends / 3)

    self.currentPage = self.currentPage + 1
    if self.currentPage > maxPages then
        self.currentPage = 1
    end

    self:UpdateFriendsDisplay()
end

function FriendRecall:OnRecallButtonClick(friendData)
    if friendData.invited then
        -- 获取URL，优先使用好友数据中的URL，如果没有则使用全局URL
        local url = friendData.resultLink or (self.serverData and self.serverData.resultLink)

        -- 调用打开URL对话框
        if ns.OpenUrlDialog then
            ns.OpenAnnouncementUrl(url)
        end
    else
        ns.LFG:SendServer('CQIR', {name=friendData.name, server=friendData.server})
    end
end

-- 创建分页控件
function FriendRecall:CreatePaginationControls()
    -- 上一页文本按钮
    self.PrevText = self.PaginationContainer:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    self.PrevText:SetText("<")
    self.PrevText:SetPoint("CENTER", self.PaginationContainer, "CENTER", -80, 0)
    self.PrevText:SetTextColor(0.8, 0.8, 0.8, 1)

    -- 创建上一页点击区域
    self.PrevButton = CreateFrame("Button", nil, self.PaginationContainer)
    self.PrevButton:SetSize(20, 20)
    self.PrevButton:SetPoint("CENTER", self.PrevText, "CENTER", 0, 0)
    self.PrevButton:SetScript("OnClick", function()
        self:PrevPage()
    end)
    self.PrevButton:SetScript("OnEnter", function()
        if self.PrevButton:IsEnabled() then
            self.PrevText:SetTextColor(1, 1, 1, 1)
        end
    end)
    self.PrevButton:SetScript("OnLeave", function()
        if self.PrevButton:IsEnabled() then
            self.PrevText:SetTextColor(0.8, 0.8, 0.8, 1)
        else
            self.PrevText:SetTextColor(0.4, 0.4, 0.4, 1)
        end
    end)

    -- 页码文本数字 - 固定创建4个位置
    self.pageTexts = {}
    self.pageButtons = {}
    self.pageNumbers = {} -- 存储当前显示的页码数字

    for i = 1, 4 do
        -- 创建页码文本
        local pageText = self.PaginationContainer:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        pageText:SetText("")

        local xOffset = -40 + (i - 1) * 30
        pageText:SetPoint("CENTER", self.PaginationContainer, "CENTER", xOffset, 0)
        pageText:SetTextColor(0.8, 0.8, 0.8, 1)

        -- 创建页码点击区域
        local pageButton = CreateFrame("Button", nil, self.PaginationContainer)
        pageButton:SetSize(20, 20)
        pageButton:SetPoint("CENTER", pageText, "CENTER", 0, 0)
        pageButton:SetScript("OnClick", function()
            if self.pageNumbers[i] then
                self:GoToPage(self.pageNumbers[i])
            end
        end)
        pageButton:SetScript("OnEnter", function()
            if self.pageNumbers[i] and self.pageNumbers[i] ~= self.currentPage then
                pageText:SetTextColor(1, 1, 1, 1)
            end
        end)
        pageButton:SetScript("OnLeave", function()
            if self.pageNumbers[i] and self.pageNumbers[i] ~= self.currentPage then
                pageText:SetTextColor(0.8, 0.8, 0.8, 1)
            end
        end)

        self.pageTexts[i] = pageText
        self.pageButtons[i] = pageButton
        self.pageNumbers[i] = nil
    end

    -- 下一页文本按钮
    self.NextText = self.PaginationContainer:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    self.NextText:SetText(">")
    self.NextText:SetPoint("CENTER", self.PaginationContainer, "CENTER", 80, 0)
    self.NextText:SetTextColor(0.8, 0.8, 0.8, 1)

    -- 创建下一页点击区域
    self.NextButton = CreateFrame("Button", nil, self.PaginationContainer)
    self.NextButton:SetSize(20, 20)
    self.NextButton:SetPoint("CENTER", self.NextText, "CENTER", 0, 0)
    self.NextButton:SetScript("OnClick", function()
        self:NextPage()
    end)
    self.NextButton:SetScript("OnEnter", function()
        if self.NextButton:IsEnabled() then
            self.NextText:SetTextColor(1, 1, 1, 1)
        end
    end)
    self.NextButton:SetScript("OnLeave", function()
        if self.NextButton:IsEnabled() then
            self.NextText:SetTextColor(0.8, 0.8, 0.8, 1)
        else
            self.NextText:SetTextColor(0.4, 0.4, 0.4, 1)
        end
    end)
end

-- 更新分页按钮状态
function FriendRecall:UpdatePaginationButtons()
    local totalPages = math.ceil(#self.friendsData / 3)

    -- 如果只有1页，隐藏整个分页容器
    if totalPages <= 1 then
        if self.PaginationContainer then
            self.PaginationContainer:Hide()
        end
        return
    else
        if self.PaginationContainer then
            self.PaginationContainer:Show()
        end
    end

    -- 更新上一页按钮状态
    self.PrevButton:SetEnabled(self.currentPage > 1)
    if self.currentPage > 1 then
        self.PrevText:SetTextColor(0.8, 0.8, 0.8, 1)
    else
        self.PrevText:SetTextColor(0.4, 0.4, 0.4, 1)
    end

    -- 更新下一页按钮状态
    self.NextButton:SetEnabled(self.currentPage < totalPages)
    if self.currentPage < totalPages then
        self.NextText:SetTextColor(0.8, 0.8, 0.8, 1)
    else
        self.NextText:SetTextColor(0.4, 0.4, 0.4, 1)
    end

    -- 计算要显示的页码范围
    local startPage, endPage
    if totalPages <= 4 then
        -- 总页数不超过4，显示全部
        startPage = 1
        endPage = totalPages
    else
        -- 总页数超过4，需要滚动显示
        if self.currentPage <= 2 then
            -- 当前页在前面，显示 1 2 3 4
            startPage = 1
            endPage = 4
        elseif self.currentPage >= totalPages - 1 then
            -- 当前页在后面，显示最后4页
            startPage = totalPages - 3
            endPage = totalPages
        else
            -- 当前页在中间，以当前页为中心显示
            startPage = self.currentPage - 1
            endPage = self.currentPage + 2
        end
    end

    -- 更新页码显示
    for i = 1, 4 do
        local pageNum = startPage + i - 1
        local pageText = self.pageTexts[i]
        local pageButton = self.pageButtons[i]

        if pageNum <= endPage and pageNum <= totalPages then
            -- 显示这个页码
            self.pageNumbers[i] = pageNum
            pageText:SetShown(true)
            pageButton:SetShown(true)

            if pageNum == self.currentPage then
                pageText:SetText("|cFFFFD700" .. pageNum .. "|r") -- 金色高亮当前页
                pageText:SetTextColor(1, 0.82, 0, 1)
            else
                pageText:SetText(tostring(pageNum))
                pageText:SetTextColor(0.8, 0.8, 0.8, 1)
            end
        else
            -- 隐藏这个位置
            self.pageNumbers[i] = nil
            pageText:SetShown(false)
            pageButton:SetShown(false)
        end
    end
end

-- 上一页
function FriendRecall:PrevPage()
    if self.currentPage > 1 then
        self.currentPage = self.currentPage - 1
        self:UpdateFriendsDisplay()
    end
end

-- 跳转到指定页
function FriendRecall:GoToPage(page)
    local totalPages = math.ceil(#self.friendsData / 3)
    if page >= 1 and page <= totalPages then
        self.currentPage = page
        self:UpdateFriendsDisplay()
    end
end

-- 开始倒计时
function FriendRecall:StartCountdown()
    -- 停止现有倒计时
    if self.countdownTimer then
        self.countdownTimer:Cancel()
        self.countdownTimer = nil
    end

    -- 使用服务器提供的时间戳，如果没有则使用默认时间
    local endTime = self.targetTime or time({year=2025, month=12, day=30, hour=23, min=59, sec=59})

    local function updateCountdown()
        local currentTime = time()
        local remaining = endTime - currentTime

        if remaining <= 0 then
            self.CountdownText:SetText("活动已结束")
            self.CountdownText:SetTextColor(1, 0, 0, 1) -- 红色
            if self.countdownTimer then
                self.countdownTimer:Cancel()
                self.countdownTimer = nil
            end
            return
        end

        -- 计算剩余天数、小时、分钟、秒数
        local days = math.floor(remaining / 86400)
        local hours = math.floor((remaining % 86400) / 3600)
        local minutes = math.floor((remaining % 3600) / 60)
        local seconds = remaining % 60

        local countdownStr = string.format("%d天 %02d:%02d:%02d", days, hours, minutes, seconds)
        self.CountdownText:SetText(countdownStr)
        self.CountdownText:SetTextColor(0, 1, 0, 1) -- 绿色
    end

    -- 立即更新一次
    updateCountdown()

    -- 每秒更新一次倒计时
    self.countdownTimer = C_Timer.NewTicker(1, updateCountdown)
end

-- 停止倒计时
function FriendRecall:StopCountdown()
    if self.countdownTimer then
        self.countdownTimer:Cancel()
        self.countdownTimer = nil
    end
end

function FriendRecall:OnShow()
    if self.flashFrame then
        ns.HideAtFrameFlash(self.flashFrame)
    end
    ns.LogStatistics:InsertLog({ time(), 10, 1 })

    -- 重新开始倒计时
    if not self.countdownTimer then
        self:StartCountdown()
    end

    -- 请求服务器数据
    self:RequestData()
end

function FriendRecall:OnHide()
    -- 停止倒计时以节省资源
    self:StopCountdown()
end

function FriendRecall:MEETINGHORN_SHOW()
    if not self.db.global.FriendRecallVersion or (self.FriendRecallVersion > self.db.global.FriendRecallVersion) then
        if not self.flashFrame then
            self.flashFrame = ns:CreateFlashFrame()
            ns.BindFlashAtFrame(self.flashFrame, ns.Addon.MainPanel.Tabs[6])
        end
        ns.ShowAtFrameFlash(self.flashFrame)
        self.db.global.FriendRecallVersion = self.FriendRecallVersion
    end
end

-- 请求战友召回数据
function FriendRecall:RequestData()
    if self.connected and not self.isGetData then
        self.isGetData = true
        ns.LFG:SendServer('CQIRSL')
    end
end

-- 服务器连接成功
function FriendRecall:MEETINGHORN_SERVER_CONNECTED()
    self.connected = true
    self:RequestData()
end

function FriendRecall:MEETINGHORN_SQIR(eventName, data)
    if not data or not data.code then
        return
    end
    -- code: 0成功，1参数错误，2不存在召回关系，3召回失败
    if data.code == 0 then
        -- 召回成功，更新对应好友的invited状态
        if data.name and data.server then
            -- 查找并更新对应的好友数据
            for i, friend in ipairs(self.friendsData) do
                if friend.name == data.name and friend.server == data.server then
                    friend.invited = true
                    self:UpdateButtonStateForFriend(data.name, data.server)
                    break
                end
            end
        end
    end
end

function FriendRecall:UpdateButtonStateForFriend(name, server)
    if not self.friendWindows then
        return
    end

    -- 查找对应的窗口并更新按钮状态
    for _, window in ipairs(self.friendWindows) do
        if window.nameLabel and window.serverLabel and window.recallButton then
            local windowName = window.nameLabel:GetText()
            local windowServer = window.serverLabel:GetText()

            if windowName == name and windowServer == server then
                -- 找到对应的窗口，更新按钮状态
                window.recallButton:SetText("查看召唤结果")
                window.recallButton:SetNormalFontObject("GameFontNormal")
                window.recallButton:GetFontString():SetTextColor(0, 0.8, 0, 1) -- 绿色文字
                break
            end
        end
    end
end

-- 更新服务器数据
function FriendRecall:UpdateServerData(data)
    -- 检查UI是否已经初始化完成
    if not self.TitleLabel then
        -- UI还没有初始化完成，暂存数据等待稍后处理
        self.pendingServerData = data
        return
    end

    if not data or type(data) ~= 'table' then
        -- 没有数据，清空显示
        self.friendsData = {}
        self.currentPage = 1
        self.serverData = nil
        self:UpdateFriendsDisplay()
        return
    end

    -- 存储服务器数据以供其他函数使用
    self.serverData = data

    -- 更新活动标题
    if data.eventTitle then
        self.TitleLabel:SetText(data.eventTitle)
    end

    -- 更新活动时间（处理开始时间和结束时间）
    if data.startTime and data.endTime then
        if type(data.startTime) == "number" and type(data.endTime) == "number" then
            -- 时间戳格式，转换为可读时间范围（不显示年份）
            local startTimeText = date("%m月%d日 %H:%M", data.startTime)
            local endTimeText = date("%m月%d日 %H:%M", data.endTime)
            local timeText = "活动时间：" .. startTimeText .. " - " .. endTimeText
            self.TimeLabel:SetText(timeText)

            -- 更新倒计时目标时间（使用结束时间）
            self.targetTime = data.endTime
            self:StartCountdown()
        else
            -- 字符串格式，直接使用
            local timeText = "活动时间：" .. tostring(data.startTime) .. " - " .. tostring(data.endTime)
            self.TimeLabel:SetText(timeText)
        end
    elseif data.eventTime then
        -- 兼容旧格式（单个时间戳）
        if type(data.eventTime) == "number" then
            local timeText = "活动时间：" .. date("%m月%d日 %H:%M", data.eventTime)
            self.TimeLabel:SetText(timeText)
            self.targetTime = data.eventTime
            self:StartCountdown()
        else
            local timeText = "活动时间：" .. tostring(data.eventTime)
            self.TimeLabel:SetText(timeText)
        end
    end

    -- 更新活动规则
    if data.eventRules then
        self.IntroLabel:SetText(data.eventRules)
    end

    -- 更新好友列表数据
    if data.friends and type(data.friends) == "table" then
        self.friendsData = data.friends
    else
        self.friendsData = {}
    end

    -- 重置到第一页
    self.currentPage = 1

    -- 刷新显示
    self:UpdateFriendsDisplay()
end

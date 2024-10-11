-- Recent.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 11/4/2020, 10:41:15 AM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local Recent = ns.Addon:NewClass('UI.Recent', 'Frame')
LibStub:GetLibrary('AceEvent-3.0'):Embed(Recent)

local RecentItem = ns.Addon:NewClass('UI.RecentItem', ns.GUI:GetClass('ViewItem'))
local ActivityItem = ns.Addon:NewClass('UI.ActivityItem', ns.GUI:GetClass('ViewItem'))

function ActivityItem:Constructor()
    self.starIcon = self:CreateTexture(nil, "ARTWORK")
    self.starIcon:SetSize(128 / 1.3, 32 / 1.3)
    self.starIcon:SetPoint("LEFT", 0, 0)

    self.describe = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    self.describe:SetSize(145, 32)
    self.describe:SetPoint('LEFT',self.starIcon, "RIGHT" , -22, 0)
    self.describe:SetJustifyH("LEFT")

    self.activityEndTime = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightLeft')
    self.activityEndTime:SetSize(110, 32)
    self.activityEndTime:SetPoint('LEFT',self.describe, "RIGHT" , 0, 0)

    self.leaderName = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    self.leaderName:SetSize(95, 32)
    self.leaderName:SetPoint('LEFT',self.activityEndTime, "RIGHT" , 0, 0)
    self.leaderName:SetJustifyH("LEFT")

    self.bg = self:CreateTexture(nil, 'BACKGROUND')
    self.bg:SetAllPoints(true)
    self.bg:SetColorTexture(0.588, 0.588, 0.588, 0.05)

        -- 边框
    self.topBorder = self:CreateTexture(nil, 'BORDER')
    self.topBorder:SetPoint("TOPLEFT", self.bg, "TOPLEFT", 1, -1)
    self.topBorder:SetPoint("TOPRIGHT", self.bg, "TOPRIGHT", -1, -1)
    self.topBorder:SetHeight(1)
    self.topBorder:SetColorTexture(0.7843, 0.4902, 0.0980, 0.5)

    self.bottomBorder = self:CreateTexture(nil, 'BORDER')
    self.bottomBorder:SetPoint("BOTTOMLEFT", self.bg, "BOTTOMLEFT", 1, 1)
    self.bottomBorder:SetPoint("BOTTOMRIGHT", self.bg, "BOTTOMRIGHT", -1, 1)
    self.bottomBorder:SetHeight(1)
    self.bottomBorder:SetColorTexture(0.7843, 0.4902, 0.0980, 0.5)

    self.leftBorder = self:CreateTexture(nil, 'BORDER')
    self.leftBorder:SetPoint("TOPLEFT", self.bg, "TOPLEFT", 1, -1)
    self.leftBorder:SetPoint("BOTTOMLEFT", self.bg, "BOTTOMLEFT", 1, 1)
    self.leftBorder:SetWidth(1)
    self.leftBorder:SetColorTexture(0.7843, 0.4902, 0.0980, 0.5)

    self.rightBorder = self:CreateTexture(nil, 'BORDER')
    self.rightBorder:SetPoint("TOPRIGHT", self.bg, "TOPRIGHT", -1, -1)
    self.rightBorder:SetPoint("BOTTOMRIGHT", self.bg, "BOTTOMRIGHT", -1, 1)
    self.rightBorder:SetWidth(1)
    self.rightBorder:SetColorTexture(0.7843, 0.4902, 0.0980, 0.5)

    local ht = self:CreateTexture(nil, 'HIGHLIGHT')
    ht:SetAllPoints(true)
    ht:SetColorTexture(0.588, 0.588, 0.588, 0.05)
    self:SetBorderVisible(false)
end

function ActivityItem:SetBorderVisible(visible)
    if visible then
        self.topBorder:Show()
        self.bottomBorder:Show()
        self.leftBorder:Show()
        self.rightBorder:Show()
    else
        self.topBorder:Hide()
        self.bottomBorder:Hide()
        self.leftBorder:Hide()
        self.rightBorder:Hide()
    end

end

function RecentItem:Constructor()
    self.Text = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    self.Text:SetPoint('CENTER', 0, 8)

    self.bg = self:CreateTexture(nil, 'BACKGROUND')
    self.bg:SetSize(170, 48)
    self.bg:SetPoint("LEFT", 0, -3)

    self.ht = self:CreateTexture(nil, 'ARTWORK')
    self.ht:SetSize(20, 20)
    self.ht:SetPoint("TOPRIGHT", 0, 8)
end

function Recent:CreateCategory(parent, title, items)
    local itemHeight = 30
    local itemSpacing = 10
    local itemsPerRow = 3
    local rows = math.max(1, math.ceil(#items / itemsPerRow))  -- 确保最低为一行

    -- 创建categoryFrame并设置大小
    local categoryFrame = CreateFrame("Frame", nil, parent)
    categoryFrame:SetSize(parent:GetWidth(), 30 + (rows * (itemHeight + itemSpacing)) + itemHeight)

    local validTitles = { ["输出:"] = true, ["坦克:"] = true, ["治疗:"] = true }

    local icon = nil
    if validTitles[title] then
        icon = categoryFrame:CreateTexture(nil, "ARTWORK")
        icon:SetSize(16, 16) -- 设置图标大小
        icon:SetPoint("TOPLEFT",0, 0)
    end

    -- 设置分类标题
    local titleLabel = categoryFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
    titleLabel:SetText(title)
    if validTitles[title] then
        titleLabel:SetPoint( "LEFT", icon, "RIGHT", -150, 0)
    else
        local width = -130
        if #title < 4 * 3 then
            width = -150
        end
        titleLabel:SetPoint("TOPLEFT",width, 0)
    end
    titleLabel:SetSize(parent:GetWidth(), 30)

    if title == "输出:" then
        icon:SetTexture('Interface/AddOns/MeetingHorn/Media/Recent/DPS')
    elseif title == "坦克:" then
        icon:SetTexture('Interface/AddOns/MeetingHorn/Media/Recent/Tank')
    elseif title == "治疗:" then
        icon:SetTexture("Interface/AddOns/MeetingHorn/Media/Recent/Healer")
    end

    -- 创建subGridView并绑定到categoryFrame
    local subGridView = ns.GUI:GetClass('GridView'):Bind(CreateFrame("Frame", nil, categoryFrame))
    subGridView:SetItemHeight(itemHeight)
    subGridView:SetItemClass(RecentItem)
    subGridView:SetColumnCount(itemsPerRow)
    subGridView:SetItemSpacing(itemSpacing, itemSpacing)
    subGridView:EnableMouseWheel(false)
    subGridView:SetCallback('OnItemFormatting', function(_, button, info)
        button.Text:SetText(Ambiguate(info.role_name, 'none'))
        button.Text:SetTextColor(1, 1, 1)
        button.ht:SetTexture('Interface/AddOns/MeetingHorn/Media/Recent/'..info.job)
        if title == "输出:" then
            button.bg:SetTexture('Interface/AddOns/MeetingHorn/Media/Recent/DPSBG')
        elseif title == "坦克:" then
            button.bg:SetTexture('Interface/AddOns/MeetingHorn/Media/Recent/TankBG')
        elseif title == "治疗:" then
            button.bg:SetTexture('Interface/AddOns/MeetingHorn/Media/Recent/HealerBG')
        else
            button.bg:SetTexture('Interface/AddOns/MeetingHorn/Media/Recent/CustomBG')
        end
    end)
    subGridView:SetCallback('OnItemMenu', function(_, button, info)
        self:CreateMenu(_, button, info)
    end)

    -- 设置subGridView的位置在titleLabel下方
    subGridView:SetPoint("TOP", titleLabel, "BOTTOM", 0, -5)
    subGridView:SetPoint("BOTTOMRIGHT", categoryFrame, "BOTTOMRIGHT", -10, 10)

    -- 设置subGridView的大小并刷新
    subGridView:SetSize(parent:GetWidth() - 20, rows * (itemHeight + itemSpacing))
    subGridView:SetItemList(items)
    subGridView:Refresh()

    return categoryFrame
end

function Recent:UpdateContentHeight(height)
    local currentHeight = self.Members.ContentFrame:GetHeight()
    self.Members.ContentFrame:SetHeight(currentHeight + height)
end

function Recent:CreateOccupationFrame(positionClass, iconPath)
    local frame = CreateFrame("Frame", "RoleIconFrame", self.Instance)
    frame:SetSize(100, 20) -- 调整宽高
    frame:SetPoint("CENTER") -- 设置位置

    -- 创建图标
    local icon = frame:CreateTexture(nil, "ARTWORK")
    icon:SetSize(16, 16) -- 设置图标大小
    icon:SetPoint("LEFT", positionClass, "RIGHT", 5, 0)
    icon:SetTexture(iconPath) -- 使用内置的角色图标纹理

    -- 创建文字
    local textString = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    textString:SetPoint("LEFT", icon, "RIGHT", 5, 0) -- 文字位于图标右侧
    textString:SetText("10 人")

    return textString
end

function Recent:CreateAndPositionCategory(title, items, offsetY)
    if not items or #items == 0 then
        return nil, offsetY
    end
    local categoryFrame = self:CreateCategory(self.Members.ContentFrame, title, items)
    categoryFrame:SetPoint("TOPLEFT", 0, -offsetY)
    categoryFrame:SetPoint("TOPRIGHT",0, -offsetY)
    local categoryHeight = categoryFrame:GetHeight() - 20
    offsetY = offsetY + categoryHeight
    self:UpdateContentHeight(categoryHeight)
    return categoryFrame, offsetY
end

function Recent:CreateMenu(_, button, info)
    local name = Ambiguate(info.role_name, 'none')
        ns.GUI:ToggleMenu(button, {
            { text = RAID_CLASS_COLORS[info.job]:WrapTextInColorCode(name), isTitle = true }, {
                text = WHISPER,
                func = function()
                    ChatFrame_SendTell(name)
                end,
            }, {
                text = INVITE,
                func = function()
                    InviteToGroup(name)
                end,
            }, {
                text = ADD_FRIEND,
                func = function()
                    C_FriendList.AddFriend(name)
                end,
            }, { text = CANCEL },
        })
end

function Recent:Constructor()
    self.BGFrame = CreateFrame("Frame", "RecentBgFrame", self)
    self.BGFrame:SetSize(1015, 505)
    self.BGFrame:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 65)
    self.BGFrame:SetFrameStrata("MEDIUM")
    self.BGFrame:SetFrameLevel(6)
    self.BGFrame:Hide()

    local BGFrameTexture = self.BGFrame:CreateTexture(nil, "OVERLAY")
    BGFrameTexture:SetTexture("Interface/AddOns/MeetingHorn/Media/Recent_bg") -- 指向你的图片
    BGFrameTexture:SetAllPoints(self.BGFrame) -- 使纹理覆盖整个框架

    self.db = ns.Addon.db
    self:RegisterMessage('MEETINGHORN_SQG')

    self.StarHeader:SetText(L['Certification'])
    self.DescribeHeader:SetText(L['Activity'])
    self.ActivityEndTimeHeader:SetText('活动截止时间')
    self.LeaderHeader:SetText(L['Leader'])

    self.StarHeader:Disable()
    self.DescribeHeader:Disable()
    self.ActivityEndTimeHeader:Disable()
    self.LeaderHeader:Disable()


    ns.GUI:GetClass('GridView'):Bind(self.Left)
    self.Left:SetItemHeight(36)
    self.Left:SetItemClass(ActivityItem)
    self.Left:SetColumnCount(1)
    self.Left:SetItemSpacing(3, 3)
    self.Left:SetCallback('OnItemFormatting', function(_, button, info)
        local starData = ns.Addon.db.realm.starRegiment.regimentData[info.role_name]
        if starData then
            button.starIcon:SetTexture(format('Interface/AddOns/MeetingHorn/Media/certification_icon_%d', starData.level))
        end
        button.describe:SetText(info.raid_name)
        button.activityEndTime:SetText(info.start_time)
        button.leaderName:SetText(info.role_name)
        local r, g, b = GetClassColor(info.job)
        button.leaderName:SetTextColor(r, g, b)
        if self.Left._buttons[1] == button then
            button:SetBorderVisible(true)
        end
    end)
    self.Left:SetCallback('OnItemClick', function(_,  selectedButton, info)
        for _, button in pairs(self.Left._buttons) do
            if button == selectedButton then
                button:SetBorderVisible(true)
            else
                button:SetBorderVisible(false)
            end
        end
        self:LeftItemClick(_, selectedButton, info)
    end)

    -- 创建滚动框架
    local scrollFrame = CreateFrame("ScrollFrame", nil, self.Members, "UIPanelScrollFrameTemplate")
    Mixin(scrollFrame, BackdropTemplateMixin)
    scrollFrame:SetPoint("TOPLEFT", self.Members, "TOPLEFT", 0, -4)
    scrollFrame:SetPoint("BOTTOMRIGHT", self.Members, "BOTTOMRIGHT", -23, 40)

    -- 设置背景
    scrollFrame:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = nil,
        tile = false,
        tileSize = 0,
        edgeSize = 0,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })

    -- 设置背景颜色
    scrollFrame:SetBackdropColor(32/255, 38/255, 48/255, 0.5) -- 使用RGBA格式设置背景颜色

    -- 创建内容框架
    local contentFrame = CreateFrame("Frame", nil, scrollFrame)
    contentFrame:SetWidth(350)
    contentFrame:SetHeight(68)
    scrollFrame:SetScrollChild(contentFrame)

    self.LeaderButton = CreateFrame("Button", nil, contentFrame)
    self.LeaderButton:SetSize(200, 48)
    self.LeaderButton:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 0, 0)

    local describeText = self.LeaderButton:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
    describeText:SetPoint("TOP", self.LeaderButton, "TOP", 90, 0)
    describeText:SetFont("Fonts\\ARHei.ttf", 10)
    describeText:SetTextColor(0.5, 0.5, 0.5, 1)
    describeText:SetText("可鼠标右键针对玩家进行操作")

    self.LeaderButton:SetScript("OnMouseUp", function(_, button)
        if button == "RightButton" then
            self:CreateMenu(_, self.LeaderButton, self.LeaderButton.info)
        end
    end)

    local LeaderText = self.LeaderButton:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightLarge')
    LeaderText:SetSize(50, 38)
    LeaderText:SetPoint('LEFT', 2, -10)
    LeaderText:SetText("队长: ")

    local bg = self.LeaderButton:CreateTexture(nil, 'BACKGROUND')
    bg:SetSize(150, 38)
    bg:SetPoint('LEFT', LeaderText, "RIGHT", 0, -8)
    bg:SetTexture('Interface/AddOns/MeetingHorn/Media/Recent/LeaderBG')

    self.LeaderTextHt = self.LeaderButton:CreateTexture(nil, 'ARTWORK')
    self.LeaderTextHt:SetSize(20, 20)
    self.LeaderTextHt:SetPoint("TOPRIGHT",bg,"TOPRIGHT",  -38, 2)

    self.LeaderText = self.LeaderButton:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    self.LeaderText:SetPoint('CENTER', bg, 'CENTER', -18, 6)

    -- 设置 self.Members 的内容框架
    self.Members.ContentFrame = contentFrame

    ns.UI.CountdownButton:Bind(self.Invite)

    self.Invite:SetText(L['Invite All'])
    self.Instance.Label:SetText('预约组队列表')

    self.Instance.Text:SetFont("Fonts\\ARHei.ttf", 10)
    self.Instance.Text:SetText('下方列表仅展示在移动端创建和参与组队活动信息')

    self.RightTop:SetScript("OnEnter", function()
        if not self.ActivityNameText then
            return
        end
        GameTooltip:SetOwner(self, 'ANCHOR_NONE')
        GameTooltip:SetPoint('TOPLEFT', self, 'TOPRIGHT', 8, 60)
        GameTooltip:SetText(self.ActivityNameText)
        GameTooltip:Show()
    end)
    self.RightTop:SetScript('OnLeave', GameTooltip_Hide)


    self.DPSText = self:CreateOccupationFrame(self.Instance.TeamConfiguration, "Interface/AddOns/MeetingHorn/Media/Recent/DPS")
    self.TankText = self:CreateOccupationFrame(self.DPSText, "Interface/AddOns/MeetingHorn/Media/Recent/Tank")
    self.HealerText = self:CreateOccupationFrame(self.TankText, "Interface/AddOns/MeetingHorn/Media/Recent/Healer")

    self.CustomizedText = self.Instance:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
    self.CustomizedText:SetPoint("TOPLEFT", self.Instance.TeamConfiguration, "BOTTOMLEFT", 0, -12)
    self.CustomizedText:SetFont("Fonts\\ARHei.ttf", 12)

    local tipsText = self.Instance:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
    tipsText:SetPoint("BOTTOM", self.Right, "TOP", 0, 10)
    tipsText:SetFont("Fonts\\ARHei.ttf", 10)
    tipsText:SetTextColor(0.5, 0.5, 0.5, 1)
    tipsText:SetText("成员配置明细均来自团长在“掌上集结号”内设置，结果仅供参考")

    self.gatherToggle = false
    local checkButtonFrame = CreateFrame("CheckButton", nil, self.Instance, "ChatConfigCheckButtonTemplate");
    checkButtonFrame:SetSize(30, 30);
    checkButtonFrame:SetHitRectInsets(0, -80, 0, 0);
    checkButtonFrame:SetPoint("LEFT", self.Instance.Text, "RIGHT", 10, 0)
    checkButtonFrame.Text:SetText("只看我创建的")
    checkButtonFrame.Text:SetTextColor(1, 0.83, 0)
    checkButtonFrame:SetScript("OnClick", function(checkButtonSelf)
        if checkButtonSelf:GetChecked() then
            self.gatherToggle = true;
        else
            self.gatherToggle = false;
        end
        self:Refresh()
    end);

    local refreshButton = CreateFrame("Button", nil, self.Instance, "UIPanelButtonTemplate");
    refreshButton:SetSize(50, 25)
    refreshButton:SetPoint("LEFT", checkButtonFrame.Text, "RIGHT", 10, 0);
    refreshButton:SetText("刷新");
    refreshButton:SetScript("OnClick", function()
        ns.LFG:SendServerCQG()
    end)

    self.Invite:SetScript('OnClick', function(btn)
        local playerName, _ = UnitName("player")
        if self.LeaderButton.info.role_name == playerName then
            ns.LogStatistics:InsertLog({time(), 8, 3})
            local groupData = self.LeaderButton.info.group_detail
            if not groupData then
                return
            end

            for _, tankItme in ipairs(groupData.tank) do
                self:InviteToGroup(tankItme)
            end
            for _, healerItme in ipairs(groupData.healer) do
                self:InviteToGroup(healerItme)
            end
            for _, dpsItme in ipairs(groupData.dps) do
                self:InviteToGroup(dpsItme)
            end

            for _, customVale in ipairs(groupData.custom) do
                local info = customVale.info
                for _, customItme in ipairs(info) do
                    self:InviteToGroup(customItme)
                end
            end
        else
            ns.LogStatistics:InsertLog({time(), 8, 2})
            ChatFrame_SendTell(self.LeaderButton.info.role_name)
        end
        btn:SetCountdown(3)
    end)

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)

    if self.db.char.RecentData then
        self:Refresh()
    end
end

function Recent:InviteToGroup(info)
    if not (UnitInRaid(info.role_name) or UnitInParty(info.role_name)) then
        if not IsInRaid() then
            ConvertToRaid()
        end
        InviteToGroup(info.role_name)
    end
end

function Recent:LeftItemClick(_, button, info)
    self.Instance.TipsText:SetText(info.raid_name)
    self.ActivityNameText = info.title
    local text = self.ActivityNameText
    local maxLength = 47 -- 根据需要调整最大长度
    if string.len(text) > maxLength then
       text = string.sub(text, 1, maxLength - 3) .. "..."
    end
    self.Instance.ActivityNameText:SetText(text)

    local groupData = info.group_detail

    self.DPSText:SetText((format("%d 人", #groupData.dps)))
    self.TankText:SetText((format("%d 人", #groupData.tank)))
    self.HealerText:SetText((format("%d 人", #groupData.healer)))

    -- 清除旧的内容
    local function ClearContent(frame)
        local children = { frame:GetChildren() }
        for _, child in ipairs(children) do
            if child and child ~= self.LeaderButton then
                child:Hide()  -- 隐藏子组件
                child:ClearAllPoints()  -- 清除所有锚点
                child:SetParent(nil)  -- 移除父组件
            end
        end
    end
    -- 使用此函数清除之前的组件
    ClearContent(self.Members.ContentFrame)
    self.Members.ContentFrame:SetHeight(68)

    local offsetY = self.Members.ContentFrame:GetHeight()

    _ , offsetY  = self:CreateAndPositionCategory( '输出:', groupData.dps, offsetY)
    _ , offsetY  = self:CreateAndPositionCategory('坦克:', groupData.tank, offsetY)
    _ , offsetY = self:CreateAndPositionCategory('治疗:', groupData.healer, offsetY)

    local customizedText = ''
    for i, value in ipairs(groupData.custom) do
        if i == 1 then
            customizedText = format("%s: %d 人", value.name, #value.info)
        else
            if i == 4 then
                customizedText = customizedText..'\n'.. format("%s: %d 人", value.name, #value.info)
            else
                customizedText = customizedText .. format("      %s: %d 人", value.name, #value.info)
            end
        end
        _ , offsetY  = self:CreateAndPositionCategory( value.name, value.info, offsetY)
    end

    self.CustomizedText:ClearAllPoints()
    if #groupData.custom > 3 then
        self.CustomizedText:SetPoint("TOPLEFT", self.Instance.TeamConfiguration, "BOTTOMLEFT", 0, -10)
    else
        self.CustomizedText:SetPoint("TOPLEFT", self.Instance.TeamConfiguration, "BOTTOMLEFT", 0, -12)
    end

    self.CustomizedText:SetText(customizedText)

    self.LeaderButton.info = info
    self.LeaderText:SetText(info.role_name)
    self.LeaderText:SetTextColor(1, 1, 1)
    self.LeaderTextHt:SetTexture('Interface/AddOns/MeetingHorn/Media/Recent/'..info.job)

    local playerName, _ = UnitName("player")
    if info.role_name == playerName then
        self.Invite:SetText(L['Invite All'])
    else
        self.Invite:SetText('私聊队长')
    end
end

function Recent:OnShow()
    ns.LogStatistics:InsertLog({time(), 8, 1})
    self.BGFrame:Hide()
    if not self.db.char.RecentData then
        self.BGFrame:Show()
        return
    end
    local RecentItmeData = self.db.char.RecentData[1]
    if RecentItmeData then
        self:LeftItemClick(_,_, RecentItmeData)
    else
        self.BGFrame:Show()
    end
end

function Recent:OnHide()
    self.BGFrame:Hide()
end

function Recent:Refresh()
    local RecentData = self.db.char.RecentData
    if self.gatherToggle then
        RecentData = self.db.char.RecentOwnData
    end
    self.Left:SetItemList(RecentData)
    if not RecentData or #RecentData == 0 then
        self.BGFrame:Show()
    end
    self.Left:Refresh()
end

function Recent:MEETINGHORN_SQG(eventName, data)
    if data ~= self.db.char.RecentData then
        self.db.char.RecentData = data
    end
    self.db.char.RecentOwnData = {}
    for _, info in ipairs(data) do
        if info.role_name == UnitName("player") then
            table.insert(self.db.char.RecentOwnData, info)
        end
    end
    self:Refresh()
end


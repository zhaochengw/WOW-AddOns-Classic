---@type ns
local ns = select(2, ...)
ns.isOpenVoiceRoom = true

local L = ns.L

local VOICEICON = [[|TInterface\AddOns\MeetingHorn\Media\voiceIocn:20:20:0:-2:96:96:0:96:0:96|t]]

local medalTextures = {
    [1] = [[|TInterface\AddOns\MeetingHorn\Media\StbTexture\StbTextureBgBig1:16:46:0:0:128:64:0:128:0:46|t]],
    [2] = [[|TInterface\AddOns\MeetingHorn\Media\StbTexture\StbTextureBgBig2:16:46:0:0:128:64:0:128:0:46|t]],
    [140] = [[|TInterface\AddOns\MeetingHorn\Media\StbTexture\StbTextureBgBig140:16:46:0:0:128:64:0:128:0:46|t]],
    [170] = [[|TInterface\AddOns\MeetingHorn\Media\StbTexture\StbTextureBgBig170:16:46:0:0:128:64:0:128:0:46|t]],
    [200] = [[|TInterface\AddOns\MeetingHorn\Media\StbTexture\StbTextureBgBig200:16:52:0:0:256:64:0:146:0:46|t]],
}

---@class MeetingHornUIBrowser: ScrollFrame
---@field sortId number
---@field sortOrder number
---@field private ActivityList ListView
---@field private Activity Button
---@field private Mode Button
---@field private Header1 Button
---@field private Header2 Button
---@field private Header3 Button
---@field private Header4 Button
local Browser = ns.Addon:NewClass('UI.Browser', 'Frame')

function Browser:Constructor()
    self.MySearchQuicks = {}
    self.SearchQueueMaxSize = 3 -- 队列的最大长度
    self.index = 1

    self.Empty.Text:SetText(L['There are no activity, please try searching.'])

    self.Header1:SetText(L['Activity'])
    self.Header2:SetText(L['Mode'])
    self.Header3:SetText(L['Members'])
    self.Header4:SetText(L['Leader'])
    self.Header5:SetText(L['Comment'])
    self.Header6:SetText(L['Operation'])
    self.Header7:SetText(L['Certification'])
    self.Header8:SetText(L['LeaderQrCode'])
    -- self.Header1:Disable()
    self.Header2:Disable()
    self.Header3:Disable()
    self.Header4:Disable()
    self.Header5:Disable()
    self.Header6:Disable()
    self.Header7:Disable()
    self.Header8:Disable()

    -- self.CreateButton:SetText(L['Create Activity'])
    self.ActivityLabel:SetText(L['Activity'])
    self.ModeLabel:SetText(L['Activity Mode'])
    self.SearchLabel:SetText(SEARCH)
    self.ProgressBar.Loading:SetText(L['Receiving active data, please wait patiently'])
    self.ProgressBar:SetMinMaxValues(0, 1)

    ns.GUI:GetClass('Dropdown'):Bind(self.Activity)
    ns.GUI:GetClass('Dropdown'):Bind(self.Mode)

    ns.ApplyImageButton(self.ApplyLeaderBtn, {
        text = '申请星团长',
        summary = '大神扫码 了解星团长',
        texture = [[Interface/AddOns/MeetingHorn/Media/ApplyLeaderQR]],
        points = {'BOTTOMLEFT', self, 'BOTTOMRIGHT', 5, -25},
    })
    ns.ApplyImageButton(self.RechargeBtn, {
        text = '直充专区',
        summary = '支付宝/微信扫码登录充值更便捷时时有特惠',
        texture = [[Interface/AddOns/MeetingHorn/Media/RechargeQR]],
        points = {'BOTTOMLEFT', self, 'BOTTOMRIGHT', 5, -25},
    })

    self.RechargeBtn:Hide() -- 直充专区按键隐藏

    local function Search()
        return self:Search()
    end

    --[=[@classic@
    self:SetupQuickButton(2717)
    self:SetupQuickButton(1977)
    self:SetupQuickButton(2677)
    self:SetupQuickButton(3429)
    self:SetupQuickButton(3428)
    self:SetupQuickButton(3456)
    --@end-classic@]=]

    --[==[@bcc@
   self:SetupQuickButton(4075)
   self:SetupQuickButton(3959)
   self:SetupQuickButton(3805)
   self:SetupQuickButton(3606)
   self:SetupQuickButton(3845)
   self:SetupQuickButton(3607)
   self:SetupQuickButton(3457)
   self:SetupQuickButton(3923)
   self:SetupQuickButton(3836)
   self:SetupQuickButton('5H')
    --@end-bcc@]==]

    -- @lkc@
   self:SetupQuickButton('TOC')
   self:SetupQuickButton('HTOC')
   self:SetupQuickButton('ULD')
   self:SetupQuickButton('ICC')
   self:SetupQuickButton('奥杜尔')
   self:SetupQuickButton('宝库')
   self:SetupQuickButton('日常')
   self:SetupQuickButton('周常')
   self:SetupQuickButton('黑龙')
    -- @end-lkc@

    local  button = CreateFrame("Button", "Frame", self, "UIPanelButtonTemplate");
    button:SetSize(80, 25)
    button:SetPoint("BOTTOMRIGHT", self.Input, "TOPRIGHT", 0, -0);
    button:SetText("保存搜索");
    button:Show()
    button:SetScript("OnClick", function()
        local search = self.Input:GetText()
        if not search or search == "" or search == nil then
            return
        end
        self:AddToQueue(search)
        ns.LogStatistics:InsertLog({ time(), 10, 2 })
    end);

    self.QuickSearchText = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
    self.QuickSearchText:SetPoint("LEFT", self.Input, "RIGHT", 0, 5)
    self.QuickSearchText:SetText('快捷搜索：')

    self.MySearchText = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
    self.MySearchText:SetPoint("BOTTOM", self.QuickSearchText, "TOP", 0, 8)
    self.MySearchText:SetText('我的搜索：')

    self.Quick11 = CreateFrame("Button", nil, self, "MeetingHornQuickTemplate");
    self.Quick11:SetSize(35, 22)
    self.Quick11:SetPoint("BOTTOMLEFT", self.quicks[1], "TOPLEFT", 0, 0);
    self.Quick11:SetText("战场")
    self.MySearchQuicks[1] = self.Quick11

    self.Quick12 = CreateFrame("Button", nil, self, "MeetingHornQuickTemplate");
    self.Quick12:SetSize(35, 22)
    self.Quick12:SetPoint("LEFT", self.Quick11, "RIGHT", 5, 0);
    self.Quick12:SetText("JJC")
    self.MySearchQuicks[2] = self.Quick12

    self.Quick13 = CreateFrame("Button", nil, self, "MeetingHornQuickTemplate");
    self.Quick13:SetSize(35, 22)
    self.Quick13:SetPoint("LEFT", self.Quick12, "RIGHT", 5, 0);
    self.Quick13:SetText("附魔")
    self.MySearchQuicks[3] = self.Quick13

    local reversedQueue = self:GetQueueContents()
    if #reversedQueue > 0 then
        for i = 1, #reversedQueue do
            self:AddToQueue(reversedQueue[i])
        end
    end

    self.Activity:SetMenuTable(ns.ACTIVITY_FILTER_MENU)
    self.Activity:SetDefaultText(ALL)
    self.Activity:SetCallback('OnSelectChanged', function()
        if forbidCallBack then
            return
        end
        local activityId = tonumber(self.Activity:GetValue())
        local activityData = activityId and ns.GetActivityData(activityId)
        self.Input:SetText(activityData and activityData.shortName or '')
        self:Search()
    end)
    self.Activity:SetMaxItem(20)

    self.Mode:SetMenuTable(ns.MODE_FILTER_MENU)
    self.Mode:SetDefaultText(ALL)
    self.Mode:SetCallback('OnSelectChanged', Search)
    self.Mode:SetMaxItem(20)

    self.Input:HookScript('OnTextChanged', Search)

    self.VoiceActivity.VoiceActivityTitle:SetTextColor(1, 0.984, 0.863)
    self.VoiceActivity.VoiceActivityTitle:SetText(VOICEICON.."语音开团快人一步")

    self.VoiceActivityList = CreateFrame("ScrollFrame", "VoiceActivityList", self.VoiceActivity, "HybridScrollFrameTemplate")
    self.VoiceActivityList:SetPoint("TOPLEFT", self.VoiceActivity.VoiceActivityTitle, "BOTTOMLEFT", 0, 3)
    self.VoiceActivityList:SetPoint("BOTTOMRIGHT", self.VoiceActivity, "BOTTOMRIGHT", 0, 0)
    self.VoiceActivityList:SetFrameStrata("MEDIUM")
    self.VoiceActivityList:SetFrameLevel(6)

    local scrollBar = CreateFrame("Slider", "$parentScrollBar", self.VoiceActivityList, "HybridScrollBarTemplate")
    scrollBar:SetPoint("TOPLEFT", self.VoiceActivityList, "TOPRIGHT", 0, -13)
    scrollBar:SetPoint("BOTTOMLEFT", self.VoiceActivityList, "BOTTOMRIGHT", 0, 12)

    self.VoiceActivityList.scrollBar = scrollBar

    ns.UI.ListView:Bind(self.VoiceActivityList)
    self.VoiceActivityList:SetItemTemplate('MeetingHornAcitvityTemplate')

    ns.UI.ListView:Bind(self.ActivityList)
    self.ActivityList:SetItemTemplate('MeetingHornAcitvityTemplate')

    ---@param item MeetingHornActivity
    self.ActivityList:SetCallback('OnItemFormatting', function(_, button, item)
        self:OnItemFormatting(button, item, false)
    end)
    self.VoiceActivityList:SetCallback('OnItemFormatting', function(_, button, item)
        self:OnItemFormatting(button, item, true)
    end)
    ---@param item MeetingHornActivity
    self.ActivityList:SetCallback('OnItemSignupClick', function(_, button, item)
        self:OnItemSignupClick(button, item, false)
    end)
    self.VoiceActivityList:SetCallback('OnItemSignupClick', function(_, button, item)
        self:OnItemSignupClick(button, item, true)
    end)

    ---@param item MeetingHornActivity
    self.ActivityList:SetCallback('OnItemDoubleClick', function(_, _, item)
        self:OnItemDoubleClick(item, false)
    end)
    self.VoiceActivityList:SetCallback('OnItemDoubleClick', function(_, _, item)
        self:OnItemDoubleClick(item, true)
    end)

    self.ActivityList:SetCallback('OnItemRightClick', function(_, button, item)
        self:OpenActivityMenu(item, button)
    end)
    self.VoiceActivityList:SetCallback('OnItemRightClick', function(_, button, item)
        self:OpenActivityMenu(item, button)
    end)

    ---@param item MeetingHornActivity
    self.ActivityList:SetCallback('OnItemEnter', function(_, button, item)
        self:OnItemEnter(item)
    end)
    self.VoiceActivityList:SetCallback('OnItemEnter', function(_, button, item)
        self:OnItemEnter(item)
    end)
    self.ActivityList:SetCallback('OnItemLeave', GameTooltip_Hide)
    self.VoiceActivityList:SetCallback('OnItemLeave', GameTooltip_Hide)

    self.Reset:SetScript('OnClick', function()
        self.Activity:SetValue(nil)
        self.Mode:SetValue(nil)
        self.Input:SetText('')
        self.sortOrder = nil
        self.sortId = nil
        self:Search()
    end)

    self.Refresh:SetScript('OnClick', Search)

    -- self.CreateButton:SetScript('OnClick', function()
    --     ns.Addon.MainPanel:SetTab(2)
    -- end)

    self.progressTimer = ns.Timer:New(function()
        self:UpdateProgress()
    end)

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)
    -- self:Show()

    --[=[@classic@
    self.Header1:ClearAllPoints()
    self.Header1:SetPoint('BOTTOMLEFT', self.ActivityList, 'TOPLEFT', 2, 5)
    self.Header7:SetShown(false)
    self.Header5:SetWidth(290)
    --@end-classic@]=]
    self.VoiceActivity:Hide()
end

function Browser:QuickButtonOnClick(button)
    if button.id then
        self.Activity:SetValue(button.id)
    elseif button.search then
        self.Input:SetText(button.search)
    end
end

function Browser:AllocQuick()
    local button = self.quicks[self.index]
    self.index = self.index + 1
    return button
end

function Browser:SetupQuickButton(search, index)
    local button
    if index then
        button = self.MySearchQuicks[index]
    else
        button = self:AllocQuick()
    end
    local id
    if type(search) == 'number' then
        local mapName = C_Map.GetAreaInfo(search)
        id = ns.NameToId(mapName) or ns.MatchId(mapName)

        local data = ns.GetActivityData(id)
        if data then
            search = data.shortName or data.name
            search = search:gsub('（.+）', '')
        end
    end

    button:SetText(search)
    button:SetWidth(button:GetTextWidth())
    button:SetScript('OnClick', function()
        self:QuickButtonOnClick(button)
    end)
    button:Show()
    button.id = id
    button.search = search
end

function Browser:AddToQueue(search)
    if not ns.Addon.db.realm.SearchQueue or ns.Addon.db.realm.SearchQueue == nil then
        ns.Addon.db.realm.SearchQueue = {}
    end
    if #ns.Addon.db.realm.SearchQueue >= self.SearchQueueMaxSize then
        table.remove(ns.Addon.db.realm.SearchQueue, 1)
    end
    table.insert(ns.Addon.db.realm.SearchQueue, search)

        -- 更新按钮显示
    for i = 1, self.SearchQueueMaxSize do
        if ns.Addon.db.realm.SearchQueue[self.SearchQueueMaxSize - i + 1] then
            self:SetupQuickButton(ns.Addon.db.realm.SearchQueue[self.SearchQueueMaxSize - i + 1], i)
        else
            -- 如果队列中该位置为空，隐藏按钮
            local button = self.MySearchQuicks[self.SearchQueueMaxSize - i + 1]
            if button then
                button:Hide()
            end
        end
    end
end

local function deepCopy(original)
    if type(original) ~= 'table' then
        return original
    end
    local copy = {}
    for key, value in pairs(original) do
        copy[deepCopy(key)] = deepCopy(value)
    end
    return copy
end

function Browser:GetQueueContents()
    if not ns.Addon.db.realm.SearchQueue or ns.Addon.db.realm.SearchQueue == nil then
        return {}
    end
    return deepCopy(ns.Addon.db.realm.SearchQueue)
end

function Browser:OnItemFormatting(button, item, isVoice)
        local inApplicant = item:GetCooldown() > 0
        local inActivity = ns.UnitInGroup(item:GetLeader()) or UnitIsUnit(item:GetLeader(), 'player')
        -- local canSignup = not IsInGroup(LE_PARTY_CATEGORY_HOME) and not ns.LFG:GetCurrentActivity()
        local state
        if inActivity then
            state = LFG_LIST_APP_INVITE_ACCEPTED
        elseif inApplicant then
            state = L['Applicanted']
        end
        button.Name:SetText(item:GetTitle())
        button.Leader:SetText(item:GetLeader())
        button.Comment:SetText(item:GetComment())
        button.Mode:SetText(item:GetMode())
        local r, g, b = GetClassColor(item:GetLeaderClass())
        button.Leader:SetTextColor(r, g, b)
        --[=[@classic@
        button.Comment:SetWidth(item:IsActivity() and 290 or 360)
        --@end-classic@]=]

        -- @lkc@
        if item:GetCertificationLevel() then
            button.Icon:SetTexture(string.format([[Interface\AddOns\MeetingHorn\Media\certification_icon_%d]],
                                                 item:GetCertificationLevel()))
            button.Icon:SetShown(true)
        else
            button.Icon:SetShown(false)
        end
        button.Comment:SetWidth(item:IsActivity() and 250 or 320)
        -- @end-lkc@
        local members = item:GetMembers()
        if members then
            members = format('%d/%d', members, item.data.members)
            button.Members:SetText([[|TInterface\AddOns\MeetingHorn\Media\DataBroker:16:16:0:0:64:32:32:64:0:32|t ]] ..
                                       members)
        else
            button.Members:SetText('-')
        end

        button.State:SetShown(state)
        button.State:SetText(state)
        button.State:SetTextColor(GREEN_FONT_COLOR:GetRGB())

        button.Signup:SetText(L['Whisper'])
        button.Signup:SetShown(item:IsActivity() and not state)
        -- button.Signup:SetEnabled(canSignup)

        local sameInstance = item:GetCertificationBgID() ~= 0 and item:GetCertificationBgID() ~= nil
        if item:HaveProgress()  then
            button.Instance:SetWidth(16)
            sameInstance = item:IsSameInstance()
            button.Instance.Same:SetShown(sameInstance)
            button.Instance.Diff:SetShown(not sameInstance)
        else
            button.Instance:SetWidth(1)
            button.Instance.Same:Hide()
            button.Instance.Diff:Hide()
        end

        button.SameInstanceBgLeft:SetTexture(format("Interface/AddOns/MeetingHorn/Media/ProgressBg%d", item:GetCertificationBgID()))
        button.NormalBg:SetShown(not sameInstance)
        button.SameInstanceBgLeft:SetShown(sameInstance)
        button.QRIcon:SetShown(item:IsOurAddonCreate() and isVoice)
        button.QRIcon:SetSize(149 * 0.5, 64 * 0.3)
        button.QRIcon:ClearAllPoints()
        button.QRIcon:SetPoint("LEFT", button.Members, "RIGHT", -15, 0)
        button.QRIcon:SetNormalTexture("Interface/AddOns/MeetingHorn/Media/buttonInRoom")
        local normalTexture = button.QRIcon:GetNormalTexture()
        normalTexture:SetTexCoord(0, 1, 0, 1)  -- 根据需要调整
        button.QRIcon:SetHighlightTexture("Interface/AddOns/MeetingHorn/Media/buttonInRoom", "ADD")
        local highlightTexture = button.QRIcon:GetHighlightTexture()
        highlightTexture:SetTexCoord(0, 1, 0, 1)  -- 根据需要调整
        if item:IsOurAddonCreate() then
            button.QRIcon:SetScript('OnClick', function()
                self:OpenVoiceRoom(item)
            end)
        end

        --[=[@classic@
        button.Instance:ClearAllPoints()
        button.Instance:SetPoint('RIGHT', button, 'LEFT', 155, 0)
        button.Name:SetPoint('LEFT', 5, 0)
        --@end-classic@]=]
end

function Browser:OnItemSignupClick(button, item, isVoice)
    if item:IsActivity() then
        ns.LogStatistics:InsertLog({ time(), 1, item:GetLeader() })
        -- ns.LFG:SignupActivity(item)
        ChatFrame_SendTell(item:GetLeader())
    end
end

function Browser:OnItemDoubleClick(item, isVoice)
    if not item:IsActivity() then
        ChatFrame_SendTell(item:GetLeader())
    end
end

function Browser:OnItemEnter(item)
    local LeaderName = item:GetLeader()
    local r, g, b = GetClassColor(item:GetLeaderClass())
    GameTooltip:SetOwner(self, 'ANCHOR_NONE')
    GameTooltip:SetPoint('TOPLEFT', self, 'TOPRIGHT', 8, 60)
    GameTooltip:SetText(item:GetTitle())
    GameTooltip:AddLine(LeaderName, r, g, b)

    local medalList = ns.LFG:GetMedalList(LeaderName)
    local medalText = ""
    if medalList then
        for _, medal in ipairs(medalList) do
            local texture = medalTextures[medal]
            if texture then
                if medal == 200 then
                    GameTooltip:AddLine(texture)
                else
                    medalText = medalText.. texture
                end
            end
        end
    end

    GameTooltip:AddLine(medalText)
    local level = item:GetLeaderLevel()
    if level then
        local color = GetQuestDifficultyColor(level)
        GameTooltip:AddLine(format('%s |cff%02x%02x%02x%s|r', LEVEL, color.r * 255, color.g * 255, color.b * 255,
            item:GetLeaderLevel()), 1, 1, 1)
    end
    GameTooltip:AddLine(item:GetComment(), 0.6, 0.6, 0.6, true)
    GameTooltip:AddLine(' ')

    if not item:IsActivity() then
        GameTooltip:AddLine(L['<Double-Click> Whisper to player'], 1, 1, 1)
    end
    GameTooltip:AddLine(L['<Right-Click> Open activity menu'], 1, 1, 1)
    GameTooltip:Show()
end

function Browser:OnShow()
    self:SendServerCQDUStart()
    self:RegisterMessage('MEETINGHORN_ACTIVITY_ADDED')
    self:RegisterMessage('MEETINGHORN_ACTIVITY_UPDATE')
    self:RegisterMessage('MEETINGHORN_ACTIVITY_REMOVED')
    self:RegisterMessage('MEETINGHORN_ACTIVITY_FILTER_UPDATED', 'Search')
    self:RegisterMessage('MEETINGHORN_CHANNEL_READY')
    self:Search()
    self:UpdateProgress()
end

function Browser:OnHide()
    self:SendServerCQDUStop()
    self:UnregisterAllMessages()

    if self.QRTooltip then
        self.QRTooltip:Hide()
    end
end

function Browser:UpdateProgress()
    if not self.startTime or GetTime() - self.startTime > 10 then
        self.ProgressBar:Hide()
        self.progressTimer:Stop()
    elseif self.ProgressBar:IsShown() then
        self.ProgressBar:SetValue((GetTime() - self.startTime) / 10)
    else
        self.progressTimer:Start(0.1)
        self.ProgressBar:Show()
        self.ProgressBar:SetValue(0)
    end

    -- @lkc@
    self.IconTip:SetShown(not self.ProgressBar:IsShown())
    -- @end-lkc@
end

function Browser:OnClick(id)
    if id == self.sortId then
        self.sortOrder = (self.sortOrder + 1) % 2
    else
        self.sortId = id
        self.sortOrder = 0
    end
    self:Sort()
end

function Browser:Sort(List)
    local sortCall = function()
        sort(List:GetItemList(), function(a, b)
            -- @lkc@
            local acl, bcl = a:GetCertificationLevel(), b:GetCertificationLevel()
            if acl or bcl then
                if acl == bcl then
                    local bgIDAcl, bgIDbcl = a:GetCertificationBgID(), b:GetCertificationBgID()
                    if bgIDAcl or bgIDbcl then
                        if bgIDAcl and bgIDbcl then
                            return bgIDAcl > bgIDbcl
                        else
                            return bgIDAcl
                        end
                    end
                elseif acl and bcl then
                    return acl > bcl
                else
                    return acl
                end
            end

            if not self.sortId and not ns.Addon.db.global.SortFilteringData then
                return false
            end
            -- @end-lkc@
            local aid, bid = a:GetActivityId(), b:GetActivityId()
            if aid == bid then
                return a:GetTick() < b:GetTick()
            end

            if aid == 0 then
                return false
            elseif bid == 0 then
                return true
            end

            if self.sortOrder == 0 then
                return aid < bid
            else
                return bid < aid
            end
        end)
        List:Refresh()
    end

    -- @lkc@
    sortCall()
    -- @end-lkc@
    if self.sortId then
        --[=[@classic@
        sortCall()
        --@end-classic@]=]
        self.Sorter:Show()
        self.Sorter:SetParent(self['Header' .. self.sortId])
        self.Sorter:ClearAllPoints()
        self.Sorter:SetPoint('RIGHT', self['Header' .. self.sortId], 'RIGHT', -5, 0)

        if self.sortOrder == 0 then
            self.Sorter:SetTexCoord(0, 0.5, 0, 1)
        else
            self.Sorter:SetTexCoord(0, 0.5, 1, 0)
        end
    else
        self.Sorter:Hide()
    end
end

function Browser:SendServerCQDUStart()
    if not self.timer then
        -- 立即执行一次
        ns.LFG:SendServerCQDU()
        self.timer = C_Timer.NewTicker(60, function()
            ns.LFG:SendServerCQDU()
        end)
    end
end

function Browser:SendServerCQDUStop()
    if self.timer then
        self.timer:Cancel()
        self.timer = nil
    end
end

function Browser:Search()
    self.updateCount = 0
    self.Refresh.SpellHighlightAnim:Stop()
    self.Refresh.SpellHighlightTexture:Hide()

    local activityFilter = self.Activity:GetValue()
    local modeId = self.Mode:GetValue()
    local search = self.Input:GetText()
    local path, activityId

    if type(activityFilter) == 'string' then
        path = activityFilter
    else
        activityId = activityFilter
    end

    local result, VoiceActivityResult = ns.LFG:Search(path, activityId, modeId, search)

    self.ActivityList:ClearAllPoints()
    self.VoiceActivity.BackgroundTexture:ClearAllPoints()
    if #VoiceActivityResult > 0 then
        self.VoiceActivity:Show()

        if #VoiceActivityResult == 1 then
            self.VoiceActivity:SetPoint("BOTTOMRIGHT", -20, 245)
            self.ActivityList:SetPoint("TOPLEFT", 5, -50)
            self.ActivityList:SetPoint("BOTTOMRIGHT", -20, 5)
        elseif #VoiceActivityResult == 2 then
            self.VoiceActivity:SetPoint("BOTTOMRIGHT", -20, 220)
            self.ActivityList:SetPoint("TOPLEFT", 5, -75)
            self.ActivityList:SetPoint("BOTTOMRIGHT", -20, 5)
        else
            self.VoiceActivity:SetPoint("BOTTOMRIGHT", -20, 195)
            self.ActivityList:SetPoint("TOPLEFT", 5, -100)
            self.ActivityList:SetPoint("BOTTOMRIGHT", -20, 5)
        end
        self.VoiceActivity.BackgroundTexture:SetPoint("TOPLEFT",self.VoiceActivity,"TOPLEFT")
        self.VoiceActivity.BackgroundTexture:SetPoint("BOTTOMRIGHT",self.VoiceActivity,"BOTTOMRIGHT")
    else
        self.VoiceActivity:Hide()
        self.ActivityList:SetPoint("TOPLEFT", 5, -5)
        self.ActivityList:SetPoint("BOTTOMRIGHT", -20, 5)
    end

    self.ActivityList:SetItemList(result)
    self.VoiceActivityList:SetItemList(VoiceActivityResult)
    self:Sort(self.ActivityList)
    self:Sort(self.VoiceActivityList)
    self.ActivityList:Refresh()
    self.VoiceActivityList:Refresh()
    self.Empty.Text:SetShown(#result == 0 and #VoiceActivityResult == 0)
end

function Browser:MEETINGHORN_ACTIVITY_ADDED()
    if ns.Addon.MainPanel:IsMouseOver() then
        self.updateCount = (self.updateCount or 0) + 1

        if self.updateCount > 5 then
            self.Refresh.SpellHighlightAnim:Play()
            self.Refresh.SpellHighlightTexture:Show()
        end
    end
end

function Browser:MEETINGHORN_ACTIVITY_UPDATE()
    if ns.Addon.MainPanel:IsMouseOver() then
        self.ActivityList:Refresh()
        self.VoiceActivityList:Refresh()
    else
        self:Search()
    end
end

function Browser:MEETINGHORN_ACTIVITY_REMOVED(_, activity)
    local list = self.ActivityList:GetItemList()
    for i, v in ipairs(list) do
        if v:GetLeaderGUID() == activity:GetLeaderGUID() then
            table.remove(list, i)
            break
        end
    end
    self.ActivityList:Refresh()
    self.VoiceActivityList:Refresh()
end

function Browser:MEETINGHORN_CHANNEL_READY()
    self.startTime = GetTime()
    self:UpdateProgress()
end

function Browser:OpenActivityMenu(activity, button)
    if not activity:IsSelf() then
        ns.GUI:ToggleMenu(button, self:CreateActivityMenu(activity), 'cursor')
    end
end

function Browser:CreateActivityMenu(activity)
    return {
        {
            text = format('|c%s%s|r', select(4, GetClassColor(activity:GetLeaderClass())), activity:GetLeader()),
            isTitle = true,
        }, {
            text = WHISPER,
            func = function()
                ChatFrame_SendTell(activity:GetLeader())
            end,
        }, {
            text = C_FriendList.IsIgnored(activity:GetLeader()) and IGNORE_REMOVE or IGNORE,
            func = function()
                C_FriendList.AddOrDelIgnore(activity:GetLeader())
                if not C_FriendList.IsIgnored(activity:GetLeader()) then
                    ns.LFG:RemoveActivity(activity)
                end
            end,
        }, {isSeparator = true}, {text = REPORT_PLAYER, isTitle = true},
        {
            text = REPORT_CHAT,
            func = function()
                local reportInfo = ReportInfo:CreateReportInfoFromType(Enum.ReportType.Chat)
                local leader = activity:GetLeader()
                ReportFrame:InitiateReport(reportInfo, leader, activity:GetLeaderPlayerLocation())
                ns.GUI:CloseMenu()
            end,
        },
        {isSeparator = true},
        {
            text = "打开语音房间",
            func = function()
                self:OpenVoiceRoom(activity)
            end,
        },
        {isSeparator = true},
        {text = CANCEL},
    }
end

-- 进语音房间
function Browser:OpenVoiceRoom(activity)
    local regimentData = ns.Addon.db.realm.starRegiment.regimentData[activity:GetLeader()]
    if regimentData then
        local currentRoomID = regimentData.roomID
        local sendData = { roomID = currentRoomID }
        ns.ThreeDimensionsCode:sendCommand('joinRoom', ns.TableToJson(sendData))
        ns.isOpenVoiceRoom = false

        if not self.QRTooltip then
            self.QRTooltip = CreateFrame('Frame', nil, self, 'MeetingHornActivityTooltipTemplate')
            self.QRTooltip:SetSize(240, 340)
            self.QRTooltip:SetPoint('TOPLEFT', self, 'TOPRIGHT', 0, 0)
            self.QRTooltip.Text:SetText('如果您已安装网易DD客户端，将会自动进入该团长的语音频道。请稍等片刻…\n\n您也可以使用网易大神APP扫码下方二维码查看该团长的主页，了解有关TA的更多信息')
            self.QRTooltip.Text:ClearAllPoints()
            self.QRTooltip.Text:SetPoint('TOPLEFT', self.QRTooltip, "TOPLEFT", 8, -30)
            self.QRTooltip.Text:SetPoint('TOPRIGHT', self.QRTooltip, "BOTTOMRIGHT", -8, 8)
            self.QRTooltip.QRCode:ClearAllPoints()
            self.QRTooltip.QRCode:SetPoint('BOTTOM', self.QRTooltip, "BOTTOM", 0, 30)
            ns.UI.QRCodeWidget:Bind(self.QRTooltip.QRCode)
        end
        self.QRTooltip.QRCode:SetValue(ns.MakeQRCode(activity:GetLeader()))
        self.QRTooltip:Show()

        local  data = ns.NetEaseBase64:EnCode(format('%s+%d', UnitGUID("player"), GetRealmID()))
        ns.LogStatistics:InsertLog({time(), 7, 1, data})

        C_Timer.After(3, function(...)
            if ns.isOpenVoiceRoom then
                return
            end
            ns.ThreeDimensionsCode:sendCommand('joinRoom', '-1')
            ns.LogStatistics:InsertLog({time(), 7, 2, data})
            ns.OpenUrlDialog(format('https://dd.163.com/room/%s/?utm_source=jjh&utm_term=%s', currentRoomID, data), '复制并访问以下链接，即可快速进入这位星团长的【网页版】DD语音房间。')
        end)
    end
end

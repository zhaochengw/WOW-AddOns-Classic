-- BannerPlugin.lua
-- @Date   : 07/01/2024, 10:01:07 AM
--
---@type ns
local ns = select(2, ...)

local BannerPlugin = ns.Addon:NewModule('BannerPlugin', 'AceEvent-3.0', 'AceComm-3.0', 'LibCommSocket-3.0')
ns.BannerPlugin = BannerPlugin

function BannerPlugin:OnEnable()
    self:Init()
    self:CreateClickableFrame()
    if self.db.global.BannerShData then
        self:MEETINGHORN_SH(_, self.db.global.BannerShData)
    end
end

function BannerPlugin:Init()
    self.db = ns.Addon.db

    self:RegisterMessage('MEETINGHORN_SHOW')
    self:RegisterMessage('MEETINGHORN_HIDE')
    self:RegisterMessage('MEETINGHORN_SH')
    self:RegisterMessage('MEETINGHORN_STB')

    self.infoPages = {
        {id = 3, texture = "Interface\\AddOns\\MeetingHorn\\Media\\BannerPlugin\\StbTextureBg3"},
        {id = 4, texture = "Interface\\AddOns\\MeetingHorn\\Media\\BannerPlugin\\StbTextureBg4"},
    }

    self.currentPage = 1
    self.timer = nil  -- 初始化定时器成员变量

    self.frame = CreateFrame("Frame", "BannerFrame", UIParent, "BackdropTemplate")
    self.frame:SetSize(256, ns.Addon.MainPanel:GetHeight())
    self.frame:SetPoint("LEFT", ns.Addon.MainPanel, "RIGHT", 0, 0)
    self.frame:EnableMouse(true)
    self.frame:SetMovable(true)
    self.frame:SetClampedToScreen(true)
    self.frame:SetScript("OnMouseDown", function()
        self:PrintCurrentID()
    end)

    -- 创建关闭按钮
    self.CloseButton = CreateFrame("Button", nil, self.frame, "UIPanelCloseButton")
    self.CloseButton:SetSize(32, 32)  -- 设置按钮大小
    self.CloseButton:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", -5, -5)  -- 设置按钮位置

    -- 设置点击事件
    self.CloseButton:SetScript("OnClick", function()
        self.db.global.BannerTime = time()
        self.frame:Hide()  -- 隐藏 self.frame
        ns.LogStatistics:InsertLog({ time(), 10, 1 })
    end)

    -- 创建背景纹理
    self.BannerBackground = self.frame:CreateTexture(nil, "BACKGROUND")
    self.BannerBackground:SetAllPoints(self.frame)

    self:CreateButtons()
    self.frame:Hide()
end

function BannerPlugin:CreateButtons()
    self.PreviousButton = CreateFrame("Button", nil, self.frame)
    self.PreviousButton:SetSize(48, 48)
    self.PreviousButton:SetPoint("LEFT", 10, 0)
    self.PreviousButton:SetNormalTexture('Interface\\AddOns\\MeetingHorn\\Media\\banner_btn_left')
    self.PreviousButton:SetHighlightTexture("Interface\\AddOns\\MeetingHorn\\Media\\banner_btn_left", "ADD")
    local  PreviousNormalTexture = self.PreviousButton:GetNormalTexture()
    PreviousNormalTexture:SetTexCoord(0, 1, 0, 1)
    local PreviousHighlightTexture = self.PreviousButton:GetHighlightTexture()
    PreviousHighlightTexture:SetTexCoord(0, 1, 0, 1)
    self.PreviousButton:SetScript("OnClick", function()
        self:OnPreviousClick()
    end)

    self.NextButton = CreateFrame("Button", nil, self.frame)
    self.NextButton:SetSize(48, 48)
    self.NextButton:SetPoint("RIGHT", -10, 0)
    self.NextButton:SetNormalTexture('Interface\\AddOns\\MeetingHorn\\Media\\banner_btn_right')
    self.NextButton:SetHighlightTexture("Interface\\AddOns\\MeetingHorn\\Media\\banner_btn_right", "ADD")
    local nextNormalTexture = self.NextButton:GetNormalTexture()
    nextNormalTexture:SetTexCoord(0, 1, 0, 1)
    local nextHighlightTexture = self.NextButton:GetHighlightTexture()
    nextHighlightTexture:SetTexCoord(0, 1, 0, 1)

    self.NextButton:SetScript("OnClick", function()
        self:OnNextClick()
    end)

end

function BannerPlugin:UpdateBanner()
    if not self.db.global.BannerData or #self.db.global.BannerData == 0 then
        return
    end
    if #self.db.global.BannerData == 1 then
        self.PreviousButton:Hide()
        self.NextButton:Hide()
    else
        self.PreviousButton:Show()
        self.NextButton:Show()
    end
    self.BannerBackground:SetTexture(self.db.global.BannerData[self.currentPage].texture)
    self.BannerBackground:SetTexCoord(0, 1, 0, 424 / 512)
end

function BannerPlugin:OnPreviousClick()
    self.currentPage = self.currentPage - 1
    if self.currentPage < 1 then
        self.currentPage = #self.db.global.BannerData
    end
    self:UpdateBanner()
end

function BannerPlugin:OnNextClick()
    self.currentPage = self.currentPage + 1
    if self.currentPage > #self.db.global.BannerData then
        self.currentPage = 1
    end
    self:UpdateBanner()
end

function BannerPlugin:PrintCurrentID()
    local stbUrl = self.db.global.BannerData[self.currentPage]['u']
    if stbUrl == '' or stbUrl == nil then
        return
    end
    if self.db.global.BannerData[self.currentPage].a == 2 then
        ns.OpenAnnouncementUrl(stbUrl)
    else
        ns.OpenUrlDialog(stbUrl)
    end
    ns.LogStatistics:InsertLog({time(), 5, stbUrl})
end

function BannerPlugin:AutoRotateBanner()
    self:OnNextClick()
    self.timer = C_Timer.NewTimer(15, function() self:AutoRotateBanner() end)
end

function BannerPlugin:CreateClickableFrame()
    -- 创建一个 Frame，作为可点击区域
    self.clickableFrame = CreateFrame("Frame", "ClickableFrame", ns.Addon.MainPanel.Browser)
    self.clickableFrame:SetSize(420, 30)
    self.clickableFrame:SetPoint("BOTTOM", 80, -25)
    self.clickableFrame:Hide()

    self.callIconButton = CreateFrame("Button", nil, ns.Addon.MainPanel.Browser)
    self.callIconButton:SetSize(20, 20)
    self.callIconButton:SetNormalTexture('Interface\\AddOns\\MeetingHorn\\Media\\call_icon')
    self.callIconButton:SetPoint("RIGHT", self.clickableFrame, "LEFT", 0, 0)
    self.callIconButton:Hide()

    -- 设置 Frame 的背景颜色（这里设置为透明）
    self.clickableFrame.bg = self.clickableFrame:CreateTexture(nil, "BACKGROUND")
    self.clickableFrame.bg:SetColorTexture(0, 0, 0, 0) -- 设置为完全透明
    self.clickableFrame.bg:SetAllPoints(self.clickableFrame)

    -- 创建一个 ScrollFrame 作为滚动区域
    local scrollFrame = CreateFrame("ScrollFrame", nil, self.clickableFrame)
    scrollFrame:SetAllPoints(self.clickableFrame)

    -- 创建一个子 Frame 作为滚动内容
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(self.clickableFrame:GetWidth(), self.clickableFrame:GetHeight())
    scrollFrame:SetScrollChild(content)

    -- 创建并设置一个字体字符串来显示文本
    self.fontString = content:CreateFontString(nil, "ARTWORK")
    self.fontString:SetFontObject("GameFontNormalSmall")
    self.fontString:SetJustifyH("LEFT")
    self.fontString:SetPoint("LEFT", content, "LEFT", 5, 0)

    local function ScrollText()
        if self.animationGroup then
            self.animationGroup:Stop()
            self.animationGroup = nil
        end

        local textWidth = self.fontString:GetStringWidth()
        local frameWidth = self.clickableFrame:GetWidth()

        if textWidth > frameWidth or self.db.global.BannerShData ~= nil then
            -- 设置文本滚动
            content:SetWidth(textWidth + 10) -- 确保内容框架足够宽以显示整个文本
            self.fontString:SetPoint("LEFT", content, "LEFT", frameWidth, 0) -- 初始位置在框架外右侧
            self.fontString:SetPoint("RIGHT", content, "RIGHT", frameWidth + textWidth, 0)

            self.animationGroup = self.fontString:CreateAnimationGroup()

            local translation = self.animationGroup:CreateAnimation("Translation")
            translation:SetDuration(20)
            translation:SetOffset(-(textWidth + frameWidth), 0)

            self.animationGroup:SetLooping("REPEAT")
            self.animationGroup:Play()
        else
            -- 文本适合框架宽度，不需要滚动
            content:SetWidth(frameWidth)
            self.fontString:ClearAllPoints()
            self.fontString:SetPoint("LEFT", content, "LEFT", 5, 0)
            self.fontString:SetPoint("RIGHT", content, "RIGHT", -5, 0)
        end
    end

    -- 当 Frame 显示时调用 ScrollText
    self.clickableFrame:SetScript("OnShow", ScrollText)

    -- 设置 Frame 的点击事件
    self.clickableFrame:EnableMouse(true)
    self.clickableFrame:SetScript("OnMouseDown", function()
        if not self.db.global.BannerShData then
            return
        end
        local shUrl = self.db.global.BannerShData['u']
        if self.db.global.BannerShData.a == 2 then
            ns.OpenAnnouncementUrl(shUrl)
        else
            ns.OpenUrlDialog(shUrl)
        end
        ns.LogStatistics:InsertLog({time(), 6, shUrl})
    end)
end

function BannerPlugin:MEETINGHORN_SH(_, data)
    if not data then
        return
    end
    self.db.global.BannerShData = data
    local shTest = self.db.global.BannerShData['t']
    self.fontString:SetText(shTest)
    if not shTest or shTest == '' then
        self.callIconButton:Hide()
        self.clickableFrame:Hide()
    else
        self.callIconButton:Show()
        self.clickableFrame:Show()
    end
end

function BannerPlugin:MEETINGHORN_STB(_, data, BannerIntervalTime)
    self.db.global.BannerData = {}
    self.db.global.BannerIntervalTime = BannerIntervalTime
    for _, val in pairs(data) do
        for _, page in pairs(self.infoPages) do
            if val.id == page.id then
                page['u'] = val['u']
                page['a'] = val['a']
                table.insert(self.db.global.BannerData, page)
            end
        end
    end
    if not self.db.global.BannerData or #self.db.global.BannerData == 0 then
        self.frame:Hide()
        return
    end
    self:MEETINGHORN_SHOW()
end

function BannerPlugin:MEETINGHORN_SHOW()
    if not self.db.global.BannerData or #self.db.global.BannerData == 0
    or  not ns.Addon.MainPanel:IsVisible() then
        return
    end
    if self.db.global.BannerIntervalTime and self.db.global.BannerTime
    and  (self.db.global.BannerTime + self.db.global.BannerIntervalTime) > time() then
        return
    end
    self.frame:Show()
    if not self.timer then
        self:AutoRotateBanner()
    end
end

function BannerPlugin:MEETINGHORN_HIDE()
    self.frame:Hide()
    if self.timer then
        self.timer:Cancel()
        self.timer = nil
    end
end

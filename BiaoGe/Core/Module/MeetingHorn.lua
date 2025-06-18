if BG.IsBlackListPlayer then return end
local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local RGB_16 = ns.RGB_16
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local GetText_T = ns.GetText_T
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local pt = print
local RealmID = GetRealmID()
local player = BG.playerName
local GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded

BG.Init2(function()
    BG.MeetingHorn = {}

    BiaoGe.MeetingHorn = BiaoGe.MeetingHorn or {}
    BiaoGe.MeetingHorn[RealmID] = BiaoGe.MeetingHorn[RealmID] or {}
    BiaoGe.MeetingHorn[RealmID][player] = BiaoGe.MeetingHorn[RealmID][player] or {}

    BiaoGe.MeetingHornWhisper = BiaoGe.MeetingHornWhisper or {}
    BiaoGe.MeetingHornWhisper[RealmID] = BiaoGe.MeetingHornWhisper[RealmID] or {}
    BiaoGe.MeetingHornWhisper[RealmID][player] = BiaoGe.MeetingHornWhisper[RealmID][player] or {}

    local addonName = "MeetingHorn"
    if not IsAddOnLoaded(addonName) then return end
    local MeetingHorn = LibStub("AceAddon-3.0"):GetAddon(addonName)
    local LFG = MeetingHorn:GetModule('LFG', 'AceEvent-3.0', 'AceTimer-3.0', 'AceComm-3.0', 'LibCommSocket-3.0')
    local Activity = MeetingHorn:GetClass('Activity')

    local ver = GetAddOnMetadata(addonName, "Version"):gsub("%-%d+", ""):gsub("%D", "")
    ver = tonumber(ver)

    -- 历史搜索记录
    do
        local edit = MeetingHorn.MainPanel.Browser.Input

        local f = CreateFrame("Frame", nil, edit, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 2,
        })
        f:SetBackdropColor(0, 0, 0, 0.9)
        f:SetBackdropBorderColor(0, 0, 0, 1)
        f:SetSize(260, 50)
        f:SetPoint("BOTTOMRIGHT", edit, "TOPRIGHT", 0, 0)
        f:Hide()

        local t = f:CreateFontString()
        t:SetPoint("BOTTOM", f, "TOP", 0, 0)
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetTextColor(RGB("FFFFFF"))
        t:SetText(L["< 历史搜索记录 >"])

        local buttons = {}
        local max = 8
        local function CreateHistory()
            for i, v in pairs(buttons) do
                v:Hide()
            end
            wipe(buttons)

            for i, v in ipairs(BiaoGe.MeetingHorn[RealmID][player]) do
                if #BiaoGe.MeetingHorn[RealmID][player] <= max then
                    break
                end
                tremove(BiaoGe.MeetingHorn[RealmID][player], 1)
            end

            local lastBotton
            for i, v in ipairs(BiaoGe.MeetingHorn[RealmID][player]) do
                local bt = CreateFrame("Button", nil, f, "BackdropTemplate")
                bt:SetBackdrop({
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = 1,
                })
                bt:SetBackdropBorderColor(1, 1, 1, 0.2)
                bt:SetNormalFontObject(BG.FontGold15)
                bt:SetDisabledFontObject(BG.FontDis15)
                bt:SetHighlightFontObject(BG.FontWhite15)
                bt:SetSize(f:GetWidth() / (max / 2) - 2, 24)
                bt:RegisterForClicks("LeftButtonUp", "RightButtonUp")
                if i == 1 then
                    bt:SetPoint("TOPLEFT", 4, -2)
                elseif i == (max / 2 + 1) then
                    bt:SetPoint("TOPLEFT", 4, -bt:GetHeight())
                else
                    bt:SetPoint("LEFT", lastBotton, "RIGHT", 0, 0)
                end
                bt:SetText(v)
                local string = bt:GetFontString()
                if string then
                    string:SetWidth(bt:GetWidth() - 2)
                    string:SetWordWrap(false)
                end
                lastBotton = bt
                tinsert(buttons, bt)

                bt:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(f, "ANCHOR_NONE")
                    GameTooltip:SetPoint("BOTTOMRIGHT", f, "BOTTOMLEFT", -2, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
                    GameTooltip:AddLine(AddTexture("LEFT") .. L["搜索该记录"], 1, 0.82, 0)
                    GameTooltip:AddLine(AddTexture("RIGHT") .. L["删除该记录"], 1, 0.82, 0)
                    GameTooltip:Show()
                end)
                BG.GameTooltip_Hide(bt)
                bt:SetScript("OnLeave", function(self)
                    GameTooltip:Hide()
                end)
                bt:SetScript("OnClick", function(self, enter)
                    if enter == "RightButton" then
                        tremove(BiaoGe.MeetingHorn[RealmID][player], i)
                        CreateHistory()
                    else
                        edit:SetText(v)
                    end
                    BG.PlaySound(1)
                end)
            end
        end

        local bt = CreateFrame("Button", nil, edit)
        bt:SetSize(16, 16)
        bt:SetPoint("RIGHT", -22, 0)
        bt:SetNormalTexture("interface/raidframe/readycheck-ready")
        bt:SetHighlightTexture("interface/raidframe/readycheck-ready")
        bt:Hide()
        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:SetText(L["把搜索文本添加至历史记录"])
        end)
        BG.GameTooltip_Hide(bt)
        bt:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
        bt:SetScript("OnClick", function(self)
            local text = edit:GetText()
            if text ~= "" then
                tinsert(BiaoGe.MeetingHorn[RealmID][player], edit:GetText())
                CreateHistory()
                BG.PlaySound(1)
            end
        end)

        edit:HookScript("OnEditFocusGained", function(self)
            local name = "MeetingHorn_history"
            if BiaoGe.options[name] == 1 then
                CreateHistory()
                f:Show()
                bt:Show()
            end
        end)
        edit:HookScript("OnEditFocusLost", function(self)
            f:Hide()
            bt:Hide()
        end)
    end

    -- 自动加入集结号频道
    do
        MeetingHorn.MainPanel:HookScript("OnHide", function(self)
            C_Timer.After(0.5, function()
                if BiaoGe.options["MeetingHorn_always"] == 1 then
                    LFG.leaveTimer:Stop()
                end
            end)
        end)

        local channelName = "MeetingHorn"
        if BiaoGe.options["MeetingHorn_always"] == 1 then
            local function JoinMeetingHorn()
                if not select(2, GetChannelName(channelName)) then
                    local channels = { GetChannelList() }
                    if channels and #channels > 3 then
                        JoinTemporaryChannel(channelName)
                    end
                    BG.After(3, JoinMeetingHorn)
                end
            end
            JoinMeetingHorn()
        end
    end

    -- 按人数排序
    do
        local Browser = MeetingHorn:GetClass('UI.Browser', 'Frame')
        local bt = MeetingHorn.MainPanel.Browser.Header3
        local name = "MeetingHorn_members"

        BG.MeetingHorn.BrowserSort_oldFuc = Browser.Sort
        BG.MeetingHorn.BrowserSort_newFuc = function(self)
            sort(self.ActivityList:GetItemList(), function(a, b)
                if not self.sortId then
                    if BG.IsWLK then
                        local acl, bcl = a:GetCertificationLevel(), b:GetCertificationLevel()
                        if acl or bcl then
                            if acl and bcl then
                                return acl > bcl
                            else
                                return acl
                            end
                        end
                    end
                    return false
                end

                if self.sortId == 3 then -- 按队伍人数排序
                    local aid, bid = a:GetMembers(), b:GetMembers()
                    if aid or bid then
                        if aid and bid then
                            if aid == bid then
                                local aid, bid = a:GetActivityId(), b:GetActivityId()
                                if aid == bid then
                                    return a:GetTick() < b:GetTick()
                                else
                                    return aid < bid
                                end
                            end
                            if self.sortOrder == 0 then
                                return aid > bid
                            else
                                return bid > aid
                            end
                        else
                            return aid
                        end
                    end
                elseif self.sortId == 1 then -- 按副本排序
                    if not BG.IsVanilla then
                        local acl, bcl = a:GetCertificationLevel(), b:GetCertificationLevel()
                        if acl or bcl then
                            if acl and bcl then
                                if acl ~= bcl then
                                    return acl > bcl
                                end
                            else
                                return acl
                            end
                        end
                    end
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
                end
                return false
            end)
            self.ActivityList:Refresh()

            if self.sortId then
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
        if BiaoGe.options[name] == 1 then
            bt:SetEnabled(true)
            Browser.Sort = BG.MeetingHorn.BrowserSort_newFuc
        end
    end

    -- 密语模板
    do
        local lastfocus

        local Browser = MeetingHorn.MainPanel.Browser
        -- 按钮
        do
            local bt = CreateFrame("Button", nil, Browser, "UIPanelButtonTemplate")
            bt:SetSize(120, 22)
            if BG.IsVanilla_60 then
                bt:SetPoint("RIGHT", Browser.ApplyLeaderBtn, "LEFT", 0, 0)
            elseif ver >= 200 then
                bt:SetPoint("RIGHT", Browser.ApplyLeaderBtn, "LEFT", 0, 0)
            else
                -- bt:SetPoint("RIGHT", Browser.RechargeBtn, "LEFT", -10, 0)
                bt:SetPoint("BOTTOMRIGHT", MeetingHorn.MainPanel, "BOTTOMRIGHT", -4, 4)
            end
            bt:SetText(L["密语模板"])
            bt:SetFrameLevel(10)
            BG.MeetingHorn.WhisperButton = bt
            if BiaoGe.options["MeetingHorn_whisper"] ~= 1 then
                bt:Hide()
            else
                local BannerPlugin = MeetingHorn:GetModule('BannerPlugin', 'AceEvent-3.0', 'AceComm-3.0', 'LibCommSocket-3.0')
                if BannerPlugin and BannerPlugin.clickableFrame then
                    BannerPlugin.clickableFrame:HookScript("OnShow", function(self)
                        self:Hide()
                    end)
                end
            end
            if IsAddOnLoaded("NDui_Plus") then
                local B = unpack(NDui)
                B.Reskin(bt)
            end

            bt:SetScript("OnClick", function(self)
                if BG.MeetingHorn.WhisperFrame:IsVisible() then
                    BG.MeetingHorn.WhisperFrame:Hide()
                    BiaoGe.MeetingHornWhisper.WhisperFrame = nil
                else
                    BG.MeetingHorn.WhisperFrame:Show()
                    BiaoGe.MeetingHornWhisper.WhisperFrame = true
                end
                BG.PlaySound(1)
            end)
        end

        -- 背景框
        local f = CreateFrame("Frame", nil, BG.MeetingHorn.WhisperButton, "BackdropTemplate")
        do
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 2,
            })
            f:SetBackdropColor(0, 0, 0, 0.8)
            f:SetBackdropBorderColor(0, 0, 0, 0.8)
            f.width = 200
            if BG.IsVanilla then
                f.height = 160
            else
                f.height = 224
            end
            f:SetPoint("TOPLEFT", MeetingHorn.MainPanel, "BOTTOMRIGHT", 0, f.height)
            f:SetPoint("BOTTOMRIGHT", MeetingHorn.MainPanel, "BOTTOMRIGHT", f.width, 0)
            f:EnableMouse(true)
            BG.MeetingHorn.WhisperFrame = f
            if not BiaoGe.MeetingHornWhisper.WhisperFrame then
                f:Hide()
            end
            f:SetScript("OnMouseDown", function(self, enter)
                if lastfocus then
                    lastfocus:ClearFocus()
                end
            end)
            f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
            f.CloseButton:SetPoint("TOPRIGHT", BG.CloseButtonOffset, BG.CloseButtonOffset)
            f.CloseButton:HookScript("OnClick", function()
                BiaoGe.MeetingHornWhisper.WhisperFrame = nil
                BG.PlaySound(1)
            end)

            -- 标题
            local t = f:CreateFontString()
            t:SetPoint("TOP", 0, -5)
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetTextColor(RGB("FFFFFF"))
            t:SetText(L["< 密语模板 >"])

            -- 提示
            local bt = CreateFrame("Button", nil, f)
            bt:SetSize(30, 30)
            bt:SetPoint("TOPLEFT", 3, 3)
            local tex = bt:CreateTexture()
            tex:SetAllPoints()
            tex:SetTexture(616343)
            bt:SetHighlightTexture(616343)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["密语模板"], 1, 1, 1)
                if BG.IsVanilla then
                    GameTooltip:AddLine(L["预设装等、自定义文本，当你点击集结号活动密语时会自动添加该内容。"], 1, 0.82, 0, true)
                else
                    GameTooltip:AddLine(L["预设成就、装等、自定义文本，当你点击集结号活动密语时会自动添加该内容。"], 1, 0.82, 0, true)
                end
                GameTooltip:AddLine(L["按住SHIFT+点击密语时不会添加。"], 1, 0.82, 0, true)
                GameTooltip:AddLine(L["聊天频道玩家的右键菜单里增加密语模板按钮。"], 1, 0.82, 0, true)
                GameTooltip:AddLine(L["聊天输入框的右键菜单里增加密语模板按钮。"], 1, 0.82, 0, true)
                GameTooltip:AddLine(L["集结号活动的右键菜单里增加邀请按钮。"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            BG.GameTooltip_Hide(bt)
        end

        -- 成就
        local AchievementTitle, AchievementTitleID, AchievementEdit, AchievementCheckButton
        if not BG.IsVanilla then
            local onEnterTextTbl = {
                "25ICC",
                4637,
                4608,
                4603,
                4635,
                4634,
                4633,
                4632,
                "10ICC",
                4636,
                4532,
                4602,
                4631,
                4630,
                4629,
                4628,
                -- "25TOC",
                -- 3812,
                -- 3916,
                -- 3819,
                -- 3818,
                -- 3817,
                -- "10TOC",
                -- 3918,
                -- 3917,
                -- 3810,
                -- 3809,
                -- 3808,
                -- "ULD(25)",
                -- 2895,
                -- 3037,
                -- 3164,
                -- 3163,
                -- 3189, -- 烈火金刚
                -- 3184, -- 珍贵的宝箱
                -- 2944,
                -- 3059,
                -- "ULD(10)",
                -- 2894,
                -- 3036,
                -- 3159,
                -- 3158,
                -- 3180,
                -- 3182,
                -- 2941,
                -- 3058,
                -- "RS",
                -- 4816,
                -- 4815,
                -- 4818,
                -- 4817,
            }
            local t = f:CreateFontString()
            t:SetPoint("TOPLEFT", 15, -30)
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetTextColor(RGB(BG.g1))
            t:SetText(L["成就"])
            AchievementTitle = t

            local l = f:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("BOTTOMLEFT", t, -5, -2)
            l:SetEndPoint("BOTTOMLEFT", t, f.width - 25, -2)
            l:SetThickness(1)

            local t = f:CreateFontString()
            t:SetPoint("TOPLEFT", AchievementTitle, "BOTTOMLEFT", 0, -8)
            t:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
            t:SetTextColor(RGB("FFFFFF"))
            t:SetText(L["成就ID："])
            AchievementTitleID = t

            -- 编辑框
            local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
            edit:SetSize(80, 20)
            edit:SetPoint("LEFT", t, "RIGHT", 5, 0)
            edit:SetAutoFocus(false)
            edit:SetNumeric(true)
            if BiaoGe.MeetingHornWhisper[RealmID][player].AchievementID then
                edit:SetText(BiaoGe.MeetingHornWhisper[RealmID][player].AchievementID)
            end
            AchievementEdit = edit
            edit:HookScript("OnEditFocusGained", function(self, enter)
                lastfocus = edit
            end)
            edit:SetScript("OnMouseDown", function(self, enter)
                if enter == "RightButton" then
                    edit:SetEnabled(false)
                    edit:SetText("")
                end
            end)
            edit:SetScript("OnMouseUp", function(self, enter)
                if enter == "RightButton" then
                    edit:SetEnabled(true)
                end
            end)
            edit:SetScript("OnEnterPressed", function(self)
                self:ClearFocus()
            end)
            edit:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["成就ID参考"], 1, 1, 1)
                for i, ID in ipairs(onEnterTextTbl) do
                    if tonumber(ID) then
                        if select(4, GetAchievementInfo(ID)) then
                            local r, g, b = 1, .82, 0
                            GameTooltip:AddLine(ID .. ": " .. GetAchievementLink(ID), r, g, b)
                        else
                            local r, g, b = .5, .5, .5
                            GameTooltip:AddLine(ID .. ": " .. GetAchievementLink(ID):gsub("|cff......", ""):gsub("|r", ""), r, g, b)
                        end
                    else
                        GameTooltip:AddLine(" ")
                        GameTooltip:AddLine(ID, 1, 1, 1)
                    end
                end
                GameTooltip:Show()
            end)
            BG.GameTooltip_Hide(edit)

            local bt = CreateFrame("CheckButton", nil, f, "ChatConfigCheckButtonTemplate")
            bt:SetSize(25, 25)
            bt:SetPoint("TOPLEFT", AchievementTitleID, "BOTTOMLEFT", 0, -5)
            bt:SetHitRectInsets(0, -BG.MeetingHorn.WhisperFrame.width + 50, 0, 0)
            bt:SetChecked(true)
            if BiaoGe.MeetingHornWhisper[RealmID][player].AchievementChoose == 1 then
                bt:SetChecked(true)
            elseif BiaoGe.MeetingHornWhisper[RealmID][player].AchievementChoose == 0 then
                bt:SetChecked(false)
            end
            bt.Text:SetTextColor(.5, .5, .5)
            bt.Text:SetWidth(BG.MeetingHorn.WhisperFrame.width - 50)
            bt.Text:SetWordWrap(false)
            AchievementCheckButton = bt
            bt:SetScript("OnClick", function(self)
                if self:GetChecked() then
                    BiaoGe.MeetingHornWhisper[RealmID][player].AchievementChoose = 1
                else
                    BiaoGe.MeetingHornWhisper[RealmID][player].AchievementChoose = 0
                end
                BG.PlaySound(1)
            end)
            bt:SetScript("OnEnter", function(self)
                if edit:GetText() ~= "" and GetAchievementLink(edit:GetText()) then
                    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:SetHyperlink(GetAchievementLink(edit:GetText()))
                end
            end)
            BG.GameTooltip_Hide(bt)

            edit:SetScript("OnTextChanged", function(self)
                if self:GetText() ~= "" and GetAchievementLink(self:GetText()) then
                    local text = GetAchievementLink(self:GetText())
                    if not select(4, GetAchievementInfo(self:GetText())) then
                        text = text:gsub("|cff......", "|cff808080")
                    end
                    bt.Text:SetText(text)

                    BiaoGe.MeetingHornWhisper[RealmID][player].AchievementID = self:GetText()
                else
                    bt.Text:SetText(L["当前没有成就"])
                    BiaoGe.MeetingHornWhisper[RealmID][player].AchievementID = nil
                end
            end)
        end

        -- 装等
        local iLevelTitle, iLevelCheckButton
        do
            local t = f:CreateFontString()
            if BG.IsVanilla then
                t:SetPoint("TOPLEFT", 15, -30)
            else
                t:SetPoint("TOPLEFT", AchievementCheckButton, "BOTTOMLEFT", 0, -5)
            end
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetTextColor(RGB(BG.g1))
            t:SetText(L["装等"])
            iLevelTitle = t

            local l = f:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("BOTTOMLEFT", t, -5, -2)
            l:SetEndPoint("BOTTOMLEFT", t, f.width - 25, -2)
            l:SetThickness(1)

            local bt = CreateFrame("CheckButton", nil, f, "ChatConfigCheckButtonTemplate")
            bt:SetSize(25, 25)
            bt:SetPoint("TOPLEFT", iLevelTitle, "BOTTOMLEFT", 0, -5)
            bt:SetHitRectInsets(0, -40, 0, 0)
            bt:SetChecked(true)
            if BiaoGe.MeetingHornWhisper[RealmID][player].iLevelChoose == 1 then
                bt:SetChecked(true)
            elseif BiaoGe.MeetingHornWhisper[RealmID][player].iLevelChoose == 0 then
                bt:SetChecked(false)
            end
            bt.Text:SetWidth(BG.MeetingHorn.WhisperFrame.width - 50)
            bt.Text:SetWordWrap(false)
            iLevelCheckButton = bt
            BG.MeetingHorn.iLevelCheckButton = bt
            bt:SetScript("OnClick", function(self)
                if self:GetChecked() then
                    BiaoGe.MeetingHornWhisper[RealmID][player].iLevelChoose = 1
                else
                    BiaoGe.MeetingHornWhisper[RealmID][player].iLevelChoose = 0
                end
                BG.PlaySound(1)
            end)
        end

        -- 自定义文本
        local otherTitle, otherCheckButton1, otherEdit1, otherCheckButton2, otherEdit2
        do
            -- 继承旧版数据
            if BiaoGe.MeetingHornWhisper[RealmID][player].otherChoose then
                BiaoGe.MeetingHornWhisper[RealmID][player].otherChoose1 = BiaoGe.MeetingHornWhisper[RealmID][player].otherChoose
                BiaoGe.MeetingHornWhisper[RealmID][player].otherChoose = nil
            end
            if BiaoGe.MeetingHornWhisper[RealmID][player].otherText then
                BiaoGe.MeetingHornWhisper[RealmID][player].otherText1 = BiaoGe.MeetingHornWhisper[RealmID][player].otherText
                BiaoGe.MeetingHornWhisper[RealmID][player].otherText = nil
            end
        end
        do
            local t = f:CreateFontString()
            t:SetPoint("TOPLEFT", iLevelCheckButton, "BOTTOMLEFT", 0, -5)
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetTextColor(RGB(BG.g1))
            t:SetText(L["自定义文本"])
            otherTitle = t

            local l = f:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("BOTTOMLEFT", t, -5, -2)
            l:SetEndPoint("BOTTOMLEFT", t, f.width - 25, -2)
            l:SetThickness(1)

            -- 职业
            local bt = CreateFrame("CheckButton", nil, f, "ChatConfigCheckButtonTemplate")
            bt:SetSize(25, 25)
            bt:SetPoint("TOPLEFT", otherTitle, "BOTTOMLEFT", 0, -5)
            bt:SetHitRectInsets(0, 0, 0, 0)
            bt:SetChecked(true)
            if BiaoGe.MeetingHornWhisper[RealmID][player].otherChoose1 == 1 then
                bt:SetChecked(true)
            elseif BiaoGe.MeetingHornWhisper[RealmID][player].otherChoose1 == 0 then
                bt:SetChecked(false)
            end
            otherCheckButton1 = bt
            BG.MeetingHorn.otherCheckButton2 = bt
            bt:SetScript("OnClick", function(self)
                if self:GetChecked() then
                    BiaoGe.MeetingHornWhisper[RealmID][player].otherChoose1 = 1
                else
                    BiaoGe.MeetingHornWhisper[RealmID][player].otherChoose1 = 0
                end
                BG.PlaySound(1)
            end)

            local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
            edit:SetPoint("TOPLEFT", otherCheckButton1, "TOPRIGHT", 5, -2)
            edit:SetSize(BG.MeetingHorn.WhisperFrame.width - 60, 20)
            edit:SetAutoFocus(false)
            edit:SetMaxBytes(100)
            if BiaoGe.MeetingHornWhisper[RealmID][player].otherText1 then
                edit:SetText(BiaoGe.MeetingHornWhisper[RealmID][player].otherText1)
            else
                local class = UnitClass("player")
                edit:SetText(class)
            end
            otherEdit1 = edit

            edit:HookScript("OnEditFocusGained", function(self, enter)
                lastfocus = edit
            end)
            edit:SetScript("OnMouseDown", function(self, enter)
                if enter == "RightButton" then
                    edit:SetEnabled(false)
                    edit:SetText("")
                end
            end)
            edit:SetScript("OnMouseUp", function(self, enter)
                if enter == "RightButton" then
                    edit:SetEnabled(true)
                end
            end)
            edit:SetScript("OnTextChanged", function(self)
                BiaoGe.MeetingHornWhisper[RealmID][player].otherText1 = self:GetText()
            end)
            edit:SetScript("OnEnterPressed", function(self)
                self:ClearFocus()
            end)
            edit:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["自定义文本1"], 1, 1, 1)
                GameTooltip:AddLine(L["输入你的职业、天赋等"])
                GameTooltip:Show()
            end)
            BG.GameTooltip_Hide(edit)

            -- 经验
            local bt = CreateFrame("CheckButton", nil, f, "ChatConfigCheckButtonTemplate")
            bt:SetSize(25, 25)
            bt:SetPoint("TOPLEFT", otherCheckButton1, "BOTTOMLEFT", 0, 2)
            bt:SetHitRectInsets(0, 0, 0, 0)
            bt:SetChecked(true)
            if BiaoGe.MeetingHornWhisper[RealmID][player].otherChoose2 == 1 then
                bt:SetChecked(true)
            elseif BiaoGe.MeetingHornWhisper[RealmID][player].otherChoose2 == 0 then
                bt:SetChecked(false)
            end
            otherCheckButton2 = bt
            BG.MeetingHorn.otherCheckButton2 = bt

            bt:SetScript("OnClick", function(self)
                if self:GetChecked() then
                    BiaoGe.MeetingHornWhisper[RealmID][player].otherChoose2 = 1
                else
                    BiaoGe.MeetingHornWhisper[RealmID][player].otherChoose2 = 0
                end
                BG.PlaySound(1)
            end)

            local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
            edit:SetPoint("TOPLEFT", otherCheckButton2, "TOPRIGHT", 5, -2)
            edit:SetSize(BG.MeetingHorn.WhisperFrame.width - 60, 20)
            edit:SetAutoFocus(false)
            edit:SetMaxBytes(100)
            if BiaoGe.MeetingHornWhisper[RealmID][player].otherText2 then
                edit:SetText(BiaoGe.MeetingHornWhisper[RealmID][player].otherText2)
            end
            otherEdit2 = edit

            edit:HookScript("OnEditFocusGained", function(self, enter)
                lastfocus = edit
            end)
            edit:SetScript("OnMouseDown", function(self, enter)
                if enter == "RightButton" then
                    edit:SetEnabled(false)
                    edit:SetText("")
                end
            end)
            edit:SetScript("OnMouseUp", function(self, enter)
                if enter == "RightButton" then
                    edit:SetEnabled(true)
                end
            end)
            edit:SetScript("OnTextChanged", function(self)
                if self:GetText() ~= "" then
                    BiaoGe.MeetingHornWhisper[RealmID][player].otherText2 = self:GetText()
                else
                    BiaoGe.MeetingHornWhisper[RealmID][player].otherText2 = nil
                end
            end)
            edit:SetScript("OnEnterPressed", function(self)
                self:ClearFocus()
            end)
            edit:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["自定义文本2"], 1, 1, 1)
                GameTooltip:AddLine(L["输入你的经验、WCL分数等"])
                if edit:GetText() ~= "" then
                    GameTooltip:AddLine(" ")
                    GameTooltip:AddLine(edit:GetText(), 1, .82, 0, true)
                end
                GameTooltip:Show()
            end)
            BG.GameTooltip_Hide(edit)
        end

        -- 右键菜单
        local function GetWhisperText(onlylevel)
            local text = " "
            if IsShiftKeyDown() then
                return text
            end
            if BiaoGe.options["MeetingHorn_whisper"] == 1 then
                local iLevel
                if BG.IsVanilla then
                    iLevel = iLevelCheckButton.Text:GetText() .. L["装等"]
                else
                    iLevel = iLevelCheckButton.Text:GetText()
                end

                if onlylevel then
                    text = text .. iLevel .. otherEdit1:GetText() .. " "
                else
                    if AchievementCheckButton then
                        if AchievementCheckButton:GetChecked() and AchievementEdit:GetText() ~= "" and GetAchievementLink(AchievementEdit:GetText()) then
                            text = text .. GetAchievementLink(AchievementEdit:GetText()) .. " "
                        end
                    end

                    if iLevelCheckButton:GetChecked() and (otherCheckButton1:GetChecked() and otherEdit1:GetText() ~= "") then
                        text = text .. iLevel .. otherEdit1:GetText() .. " "
                    elseif iLevelCheckButton:GetChecked() and not (otherCheckButton1:GetChecked() and otherEdit1:GetText() ~= "") then
                        text = text .. iLevel .. " "
                    elseif not iLevelCheckButton:GetChecked() and (otherCheckButton1:GetChecked() and otherEdit1:GetText() ~= "") then
                        text = text .. otherEdit1:GetText() .. " "
                    end

                    if otherCheckButton2:GetChecked() and otherEdit2:GetText() ~= "" then
                        text = text .. otherEdit2:GetText() .. " "
                    end
                end
            end
            return text
        end

        local function SendWhisper(name, type)
            ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
            ChatEdit_ChooseBoxForSend():SetText("")
            local text = "/W " .. name .. GetWhisperText(type)
            ChatEdit_InsertLink(text)
        end

        -- 集结号活动右键菜单
        local oldFuc = Browser.CreateActivityMenu
        function Browser:CreateActivityMenu(activity)
            local tbl = oldFuc(Browser, activity)
            if BiaoGe.options["MeetingHorn_whisper"] == 1 then
                local text1 = GetWhisperText()
                if text1 ~= " " then
                    text1 = text1:sub(2)
                end
                local text2 = GetWhisperText("onlylevel")
                if text2 ~= " " then
                    text2 = text2:sub(2)
                end
                tinsert(tbl, 3,
                    {
                        text = L["密语模板"],
                        tooltipTitle = L["密语模板"],
                        tooltipText = text1,
                        func = function()
                            SendWhisper(activity:GetLeader())
                        end,
                    })
                tinsert(tbl, 4,
                    {
                        text = L["装等+职业"],
                        tooltipTitle = L["装等+职业"],
                        tooltipText = text2,
                        func = function()
                            SendWhisper(activity:GetLeader(), "onlylevel")
                        end,
                    }
                )
                local InviteUnit = InviteUnit or C_PartyInfo.InviteUnit
                tinsert(tbl, 5,
                    {
                        text = INVITE,
                        func = function()
                            InviteUnit(activity:GetLeader())
                        end,
                    })
                tinsert(tbl, 6,
                    {
                        text = L["复制活动说明"],
                        func = function()
                            ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                            ChatEdit_ChooseBoxForSend():SetText(activity:GetComment() or "")
                            ChatEdit_ChooseBoxForSend():HighlightText()
                        end,
                    })
            end
            return tbl
        end

        -- 聊天框右键菜单
        if BG.IsNewUI then
            if BiaoGe.options["MeetingHorn_whisper"] == 1 then
                Menu.ModifyMenu("MENU_UNIT_FRIEND", function(owner, rootDescription, contextData)
                    rootDescription:CreateDivider()
                    rootDescription:CreateButton(L["密语模板"], function()
                        SendWhisper(contextData.name)
                    end)
                    rootDescription:CreateButton(L["装等+职业"], function()
                        SendWhisper(contextData.name, "onlylevel")
                    end)
                end)
            end
        end

        -- 输入框右键菜单
        local edit = ChatEdit_ChooseBoxForSend()
        if edit and edit.GetObjectType and edit:GetObjectType() == "EditBox" then
            local dropDown = LibBG:Create_UIDropDownMenu(nil, edit)
            edit:HookScript("OnMouseUp", function(self, button)
                if BiaoGe.options["MeetingHorn_whisper"] ~= 1 then return end
                if button == "RightButton" then
                    local text1 = GetWhisperText()
                    if text1 ~= " " then
                        text1 = text1:sub(2)
                    end
                    local text2 = GetWhisperText("onlylevel")
                    if text2 ~= " " then
                        text2 = text2:sub(2)
                    end
                    local menu = {
                        {
                            text = L["密语模板"],
                            notCheckable = true,
                            tooltipTitle = L["使用密语模板"],
                            tooltipText = text1,
                            tooltipOnButton = true,
                            func = function()
                                ChatEdit_ActivateChat(edit)
                                local text = GetWhisperText()
                                text = text:gsub("^%s", "")
                                edit:SetCursorPosition(strlen(edit:GetText()))
                                ChatEdit_InsertLink(text)
                            end
                        },
                        {
                            text = L["装等+职业"],
                            notCheckable = true,
                            tooltipTitle = L["装等+职业"],
                            tooltipText = text2,
                            tooltipOnButton = true,
                            func = function()
                                ChatEdit_ActivateChat(edit)
                                local text = GetWhisperText("onlylevel")
                                text = text:gsub("^%s", "")
                                edit:SetCursorPosition(strlen(edit:GetText()))
                                ChatEdit_InsertLink(text)
                            end
                        },
                        {
                            text = CANCEL,
                            notCheckable = true,
                            func = function(self)
                                LibBG:CloseDropDownMenus()
                            end,
                        }
                    }
                    LibBG:EasyMenu(menu, dropDown, "cursor", 0, 20, "MENU", 2)
                end
            end)
        end

        -- 组队频道的活动显示密语按钮
        local function Set()
            if BiaoGe.options["MeetingHorn_whisper"] ~= 1 then return end
            local buttons = MeetingHorn.MainPanel.Browser.ActivityList._buttons
            for i, v in pairs(buttons) do
                local bt = v.Signup
                if bt then
                    if not bt.hasClick then
                        bt.hasClick = true
                        bt:RegisterForClicks("AnyUp")
                        bt:SetScript("OnClick", function(self, button)
                            if button == "LeftButton" then
                                SendWhisper(v.item.leaderLower)
                            elseif button == "RightButton" then
                                SendWhisper(v.item.leaderLower, "onlylevel")
                            end
                        end)
                    end
                end
            end
        end
        hooksecurefunc(MeetingHorn.MainPanel.Browser.ActivityList, "update", Set)

        if BiaoGe.options["MeetingHorn_whisper"] == 1 then
            Browser.ActivityList:SetCallback('OnItemSignupClick', function() end)

            function Activity:IsActivity()
                return true
            end

            function Activity:GetTitle()
                if not self.channel then
                    return self.data.name
                else
                    return format('%s(%s)', self.data.name, self.channel)
                end
            end
        end
    end

    -- 多个关键词搜索
    do
        local name = "MeetingHorn_search"
        BG.MeetingHorn.ActivityMatch_oldFuc = Activity.Match
        BG.MeetingHorn.ActivityMatch_newFuc = function(self, path, activityId, modeId, search)
            if path and path ~= self:GetPath() then
                return false
            end
            if activityId and activityId ~= self.id then
                return false
            end
            if modeId and modeId ~= self.modeId then
                return false
            end

            if MeetingHorn.db.profile.options.activityfilter and LFG:IsFilter(self.commentLower) then
                return false
            end

            if type(search) == "string" then
                local yes = 0
                local num = 0
                local str = (self.data.nameLower or "") .. (self.data.shortNameLower or "") ..
                    (self.commentLower or "")
                for s_and in search:gmatch("%S+") do
                    num = num + 1
                    for _, v in pairs({ strsplit("/", s_and) }) do
                        if str:find(v, nil, true) then
                            yes = yes + 1
                            break
                        end
                    end
                end
                if yes ~= num then
                    return false
                end
            elseif type(search) == "table" then
                for _, s in ipairs(search) do
                    local str = (self.data.nameLower or "") .. (self.data.shortNameLower or "") ..
                        (self.commentLower or "")
                    if str:find(s, nil, true) then
                        return true
                    end
                end
                return false
            end

            return true
        end

        if BiaoGe.options[name] == 1 then
            Activity.Match = BG.MeetingHorn.ActivityMatch_newFuc
        end
    end

    -- 星团长聊天标记
    if BG.IsWLK and ver >= 200 then
        local function StarTexture(currentLevel)
            return "Interface/AddOns/MeetingHorn/Media/certification_icon_" .. currentLevel
        end
        local function GetCoords(type)
            if ver >= 228 then
                if type == "chat" then
                    return ":15:18:0:0:100:100:65:95:0:50"
                else
                    return ":17:60:0:0:100:100:0:100:0:50"
                end
            else
                if type == "chat" then
                    return ":18:18:0:0:100:100:42:60:10:90"
                else
                    return ":17:60:0:0:100:100:0:60:15:85"
                end
            end
        end
        local function AddStarRaidLeader(self, text, ...)
            if BiaoGe.options["MeetingHorn_starRaidLeader"] ~= 1 then return self.oldFunc_BiaoGe(self, text, ...) end
            local isChannel = text:find("|Hchannel:channel:%d+.-|h")
            local name = text:match("|Hplayer:(.-):.-|h")
            if not (isChannel and name) then return self.oldFunc_BiaoGe(self, text, ...) end
            local currentLevel = MeetingHorn.db.realm.starRegiment.regimentData[BG.GSN(name)]
            if not currentLevel then return self.oldFunc_BiaoGe(self, text, ...) end
            currentLevel = currentLevel.level
            text = gsub(text, "(|Hchannel:channel:%d+|h.-|h)%s-(|Hplayer:.+|h.+|h)",
                "%1"
                .. "|T" .. StarTexture(currentLevel) .. GetCoords("chat") .. "|t"
                .. "%2")
            return self.oldFunc_BiaoGe(self, text, ...)
        end
        for i = 1, NUM_CHAT_WINDOWS do
            if i ~= 2 then
                local chatFrame = _G["ChatFrame" .. i]
                chatFrame.oldFunc_BiaoGe = chatFrame.AddMessage
                chatFrame.AddMessage = AddStarRaidLeader
            end
        end

        -- 鼠标悬停
        local CD
        local function SetTooltip(unit)
            local name = BG.GN(unit)
            local currentLevel = MeetingHorn.db.realm.starRegiment.regimentData[name]
            if not currentLevel then return end
            currentLevel = currentLevel.level
            local nameNum
            local ii = 1
            while _G["GameTooltipTextLeft" .. ii] do
                local text = _G["GameTooltipTextLeft" .. ii]:GetText()
                if text and text:find(name) then
                    nameNum = ii
                    break
                end
                ii = ii + 1
            end
            if not nameNum then return end
            local nextText = _G["GameTooltipTextLeft" .. nameNum + 1]
            if nextText and nextText:GetText() then
                nextText:SetText("|T" .. StarTexture(currentLevel) .. GetCoords("tooltip") .. "|t\n" .. nextText:GetText())
                nextText:SetWidth(nextText:GetWidth() + 2)
            end
            GameTooltip:Show()
        end
        GameTooltip:HookScript("OnTooltipSetUnit", function(self)
            if BiaoGe.options["MeetingHorn_starRaidLeader"] ~= 1 then return end
            local unit = "mouseover"
            if not (UnitIsPlayer(unit) and UnitIsSameServer(unit)) then return end
            if CD then return end
            CD = true
            BG.After(0, function() CD = false end)
            SetTooltip(unit)
        end)

        hooksecurefunc(GameTooltip, "SetUnit", function(self, unit)
            if BiaoGe.options["MeetingHorn_starRaidLeader"] ~= 1 then return end
            if not (UnitIsPlayer(unit) and UnitIsSameServer(unit)) then return end
            if CD then return end
            CD = true
            BG.After(0, function() CD = false end)
            SetTooltip(unit)
        end)
    end

    -- 标记已密语过的活动
    do
        local isSend = {
        }

        local function Set()
            if BiaoGe.options["MeetingHorn_isSend"] ~= 1 then return end
            local buttons = MeetingHorn.MainPanel.Browser.ActivityList._buttons
            for _, v in pairs(buttons) do
                local name = v.Leader:GetText()
                local text = v.Comment
                if isSend[name] then
                    text:SetTextColor(.5, .5, .5)
                else
                    text:SetTextColor(1, 1, 1)
                end
            end
        end
        hooksecurefunc(MeetingHorn.MainPanel.Browser.ActivityList, "update", Set)

        hooksecurefunc("SendChatMessage", function(msg, chatType, _, name)
            if chatType == "WHISPER" and BiaoGe.options["MeetingHorn_isSend"] == 1 then
                isSend[name] = time()
                if MeetingHorn.MainPanel.Browser.ActivityList:IsVisible() then
                    Set()
                end
            end
        end)

        C_Timer.NewTicker(60, function()
            if BiaoGe.options["MeetingHorn_isSend"] ~= 1 then return end
            local time = time()
            for name, _time in pairs(isSend) do
                if time - _time >= 60 * 15 then
                    isSend[name] = nil
                end
            end
        end)
    end

    -- 禁用语音开团快人一步
    if BG.IsWLK and LFG.SQDU then
        local name = "MeetingHorn_banVoiceList"
        BG.MeetingHorn.SQDU_oldFuc = LFG.SQDU
        BG.MeetingHorn.SQDU_newFuc = function() end

        if BiaoGe.options[name] == 1 then
            LFG.SQDU = BG.MeetingHorn.SQDU_newFuc
        end
    end
end)

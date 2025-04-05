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

local Maxb = ns.Maxb

local pt = print
local RealmId = GetRealmID()
local player = BG.playerName

BG.Init(function()
    BiaoGe.options.showAuctionLogFrame = BiaoGe.options.showAuctionLogFrame or 0
    BiaoGe.options.auctionLogChoose = BiaoGe.options.auctionLogChoose or 1
    BiaoGe.auctionTrade = nil
    BG.auctionTrade = {}

    local bt = CreateFrame("Button", nil, BG.MainFrame)
    do
        bt:SetPoint("LEFT", BG.ButtonAucitonWA, "RIGHT", BG.TopLeftButtonJianGe, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(L["拍卖记录"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        BG.ButtonAuctionLog = bt

        bt:SetScript("OnClick", function(self)
            if BG.auctionLogFrame:IsVisible() then
                BiaoGe.options.showAuctionLogFrame = 0
                BG.auctionLogFrame:Hide()
            else
                BiaoGe.options.showAuctionLogFrame = 1
                BG.auctionLogFrame:Show()
            end
            BG.PlaySound(1)
        end)
        bt:SetScript("OnEnter", function(self)
            local FB = BG.FB1
            local sum = 0
            local color = "00FF00"
            local tbl
            local isHistory
            if BG.History.chooseNum then
                isHistory = true
            end
            if isHistory then
                local DT = BiaoGe.HistoryList[FB][BG.History.chooseNum][1]
                tbl = BiaoGe.History[FB][DT].auctionLog
                color = BG.b1
            elseif BG.HistoryMainFrame:IsVisible() then
                tbl = nil
                isHistory = true
                color = BG.b1
            else
                tbl = BiaoGe[FB].auctionLog
            end
            if tbl then
                for i, v in ipairs(tbl) do
                    sum = sum + (tonumber(v.jine) or 0)
                end
            end

            GameTooltip:SetOwner(self, "ANCHOR_NONE")
            GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(L["自动拍卖装备（拍卖WA）的记录。"], 1, 0.82, 0, true)
            GameTooltip:AddLine(format(L["自动拍卖合计收入：|cff%s%s|r"], color, sum), 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", GameTooltip_Hide)
    end

    local frame, child, scroll
    local CancelAllChoose

    -- 主界面
    local f = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
    local dropDown = LibBG:Create_UIDropDownMenu(nil, f)
    do
        do
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            f:SetBackdropColor(0, 0, 0, 0.8)
            f:SetBackdropBorderColor(GetClassRGB(nil, "player", BG.borderAlpha))
            f:SetSize(220, BG.FBHeight[BG.FB1])
            f:SetPoint("TOPRIGHT", BG.MainFrame, "TOPLEFT", 1, 0)
            f:EnableMouse(true)
            BG.auctionLogFrame = f
            if BiaoGe.options.showAuctionLogFrame ~= 1 then
                f:Hide()
            else
                f:Show()
            end
            f:SetScript("OnShow", function(self)
                BG.UpdateAuctionLogFrame()
            end)
            f:SetScript("OnMouseUp", function(self)
                BG.MainFrame:GetScript("OnMouseUp")(BG.MainFrame)
            end)
            f:SetScript("OnMouseDown", function(self)
                BG.MainFrame:GetScript("OnMouseDown")(BG.MainFrame)
            end)

            f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
            f.CloseButton:SetPoint("TOPLEFT", BG.IsRetail and 0 or -4, BG.IsRetail and 0 or 4)
            f.CloseButton:HookScript("OnClick", function(self)
                BiaoGe.options.showAuctionLogFrame = 0
            end)

            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOP", f, "TOP", 0, -5)
            BG.auctionLogFrame.title = t

            -- 提示
            local bt = CreateFrame("Button", nil, f)
            bt:SetSize(28, 28)
            bt:SetPoint("LEFT", BG.auctionLogFrame.title, "RIGHT", 0, -1)
            local tex = bt:CreateTexture()
            tex:SetAllPoints()
            tex:SetTexture(616343)
            bt:SetHighlightTexture(616343)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_NONE")
                GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
                GameTooltip:ClearLines()
                local r, g, b = t:GetTextColor()
                GameTooltip:AddLine(t:GetText(), r, g, b)
                GameTooltip:AddLine(L["自动拍卖装备（拍卖WA）的记录。该记录会跟随清空表格一起被清空，也会跟随保存表格一同保存到历史表格。"], 1, 0.82, 0, true)
                if not BG.HistoryMainFrame:IsVisible() then
                    GameTooltip:AddLine(" ", 1, 0.82, 0, true)
                    GameTooltip:AddLine(L["操作提示："], 1, 1, 1, true)
                    GameTooltip:AddLine(L["右键点击一个装备可以打开菜单"], 1, 0.82, 0, true)
                    GameTooltip:AddLine(L["在未拍列表可以按住CTRL、SHIFT来多选装备，便于团长批量发起拍卖"], 1, 0.82, 0, true)
                end
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", GameTooltip_Hide)
        end

        -- 筛选显示
        do
            local buttons = {}
            local numOptions = {
                { name = L["全部"], },
                { name = L["成功"], },
                { name = L["流拍"], },
                { name = L["未拍"], },
            }
            local buttonGroup = CreateFrame("Frame", nil, f)
            buttonGroup:SetPoint("TOPLEFT", 7, -40)
            buttonGroup:SetSize(1, 1)
            for i = 1, #numOptions do
                local bt = CreateFrame("CheckButton", nil, buttonGroup, "UIRadioButtonTemplate")
                if i == 4 then
                    bt:SetPoint("LEFT", (i - 1) * 50 + 10, 0)
                else
                    bt:SetPoint("LEFT", (i - 1) * 50, 0)
                end
                bt:SetSize(15, 15)
                tinsert(buttons, bt)
                bt.Text = bt:CreateFontString()
                bt.Text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                bt.Text:SetPoint("LEFT", bt, "RIGHT", 0, 0)
                bt.Text:SetText(numOptions[i].name)
                bt.Text:SetTextColor(1, .82, 0)
                bt:SetHitRectInsets(0, -bt.Text:GetWidth(), -5, -5)

                if i == BiaoGe.options.auctionLogChoose then
                    bt:SetChecked(true)
                    bt.Text:SetTextColor(0, 1, 0)
                end

                bt:SetScript("OnClick", function(self)
                    BG.PlaySound(1)
                    for _, radioButton in ipairs(buttons) do
                        if radioButton ~= self then
                            radioButton:SetChecked(false)
                            radioButton.Text:SetTextColor(1, .82, 0)
                        end
                    end
                    self:SetChecked(true)
                    self.Text:SetTextColor(0, 1, 0)
                    BiaoGe.options.auctionLogChoose = i
                    BG.auctionLogFrame.changeFrame:Hide()
                    BG.UpdateAuctionLogFrame()
                    LibBG:CloseDropDownMenus()
                end)
            end

            local l = buttons[1]:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("BOTTOMLEFT", 0, -2)
            l:SetEndPoint("BOTTOMLEFT", 145, -2)
            l:SetThickness(1)

            local l = buttons[4]:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("BOTTOMLEFT", 0, -2)
            l:SetEndPoint("BOTTOMLEFT", 45, -2)
            l:SetThickness(1)
        end

        -- 滚动框
        do
            frame = CreateFrame("Frame", nil, BG.auctionLogFrame, "BackdropTemplate")
            frame:SetBackdrop({
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            frame:SetBackdropBorderColor(.5, .5, .5, .5)
            frame:SetBackdropColor(0, 0, 0, 0.8)
            frame:SetPoint("TOPLEFT", 5, -55)
            frame:SetPoint("BOTTOMRIGHT", -5, 90)
            frame:EnableMouse(true)

            scroll = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
            scroll:SetPoint("TOPLEFT", 5, -5)
            scroll:SetPoint("BOTTOMRIGHT", -26, 5)
            scroll.ScrollBar.scrollStep = BG.scrollStep
            frame.scroll = scroll
            BG.CreateSrollBarBackdrop(scroll.ScrollBar)
            BG.HookScrollBarShowOrHide(scroll)

            child = CreateFrame("Frame", nil, scroll)
            child:SetAllPoints()
            child:SetWidth(scroll:GetWidth())
            child:SetHeight(scroll:GetHeight())
            scroll:SetScrollChild(child)

            local _f = CreateFrame("Frame", nil, frame)
            _f:SetSize(1, 1)
            _f:SetPoint("TOPRIGHT", 0, 1)
            frame.tooltip = _f

            local t = child:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOP", 0, 0)
            t:SetTextColor(1, 0, 0)
            t:SetText(L["没有自动拍卖记录。"])
            t:Hide()
            BG.auctionLogFrame.notText = t
        end

        -- 开始拍卖
        do
            local bt = BG.CreateButton(frame)
            bt:SetPoint("TOPLEFT", frame, "BOTTOM", -10, 30)
            bt:SetPoint("BOTTOMRIGHT", frame, -22, 2)
            bt:SetFrameLevel(110)
            bt:SetText(L["开始拍卖"])
            bt:RegisterForClicks("AnyUp")
            bt:Hide()
            BG.auctionLogFrame.ButtonStartAuction = bt
            bt:SetScript("OnClick", function(self, button)
                BG.PlaySound(1)
                BG.StartAuction(BG.auctionLogFrame.choosed, bt, nil, true)
                if BG.StartAucitonFrame and BG.StartAucitonFrame:IsVisible() then
                    BG.StartAucitonFrame:ClearAllPoints()
                    BG.StartAucitonFrame:SetPoint("BOTTOM", frame, 0, 0)
                end
                CancelAllChoose()
            end)

            local bt = BG.CreateButton(BG.auctionLogFrame.ButtonStartAuction)
            bt:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 2, 30)
            bt:SetPoint("BOTTOMRIGHT", frame, "BOTTOM", -8, 2)
            bt:SetFrameLevel(110)
            bt:SetText(L["取消选择"])
            BG.auctionLogFrame.ButtonCancelChoose = bt
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                CancelAllChoose()
            end)
        end

        -- 合计收入
        do
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 2, -5)
            t:SetTextColor(1, 1, 1)
            t:SetJustifyH("LEFT")
            t:SetWordWrap(false)
            BG.auctionLogFrame.sumText = t
        end

        -- 增加
        do
            local bt = BG.CreateButton(BG.auctionLogFrame)
            bt:SetSize(28, 20)
            bt:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 0, -3)
            bt:SetText("+")
            BG.auctionLogFrame.ButtonAdd = bt
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                if BG.auctionLogFrame.changeFrame:IsVisible() and BG.auctionLogFrame.changeFrame.type == "new" then
                    BG.auctionLogFrame.changeFrame:Hide()
                else
                    BG.auctionLogFrame.changeFrame:Hide()
                    BG.auctionLogFrame.changeFrame.type = "new"
                    BG.auctionLogFrame.changeFrame.info = {}
                    BG.auctionLogFrame.changeFrame:Show()
                    BG.auctionLogFrame.changeFrame:ClearAllPoints()
                    BG.auctionLogFrame.changeFrame:SetPoint("BOTTOM", frame, "BOTTOM", 0, 0)
                end
            end)
        end

        -- 搜索
        do
            local edit = CreateFrame("EditBox", nil, f, "SearchBoxTemplate")
            edit:SetSize(f:GetWidth() - 20, 22)
            edit:SetPoint("TOPLEFT", BG.auctionLogFrame.sumText, "BOTTOMLEFT", 7, -5)
            BG.auctionLogFrame.serachEdit = edit
            edit:SetScript("OnMouseDown", function(self, button)
                if button == "RightButton" then
                    self:SetEnabled(false)
                    self:SetText("")
                end
            end)
            edit:SetScript("OnMouseUp", function(self, button)
                self:SetEnabled(true)
            end)
            edit:SetScript("OnEditFocusGained", function(self)
                BG.lastfocus = self
            end)
        end

        -- 生成账单按钮
        do
            local bt = BG.CreateButton(BG.auctionLogFrame)
            bt:SetSize(110, 25)
            bt:SetPoint("BOTTOMLEFT", BG.auctionLogFrame, 5, 10)
            bt:SetText(L["生成表格账单"])
            BG.auctionLogFrame.ButtonCreateLedger = bt
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
                GameTooltip:AddLine(L["根据自动拍卖记录，直接覆盖表格里每件装备所对应的买家和金额。"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", GameTooltip_Hide)
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(2)
                local FB = BG.FB1
                for b = 1, Maxb[FB] - 1 do
                    for i = 1, BG.Maxi do
                        local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                        local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                        local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
                        if zhuangbei then
                            maijia:SetText("")
                            maijia:SetTextColor(1, 1, 1)
                            BiaoGe[FB]["boss" .. b]["maijia" .. i] = nil
                            for k, v in pairs(BG.playerClass) do
                                BiaoGe[FB]["boss" .. b][k .. i] = nil
                            end
                            jine:SetText("")
                            BiaoGe[FB]["boss" .. b]["jine" .. i] = nil
                        end
                    end
                end
                BiaoGe[FB].tradeTbl = {}

                for _, v in ipairs(BiaoGe[FB].auctionLog) do
                    if v.type == 1 then
                        local itemID = GetItemID(v.zhuangbei)
                        for b = 1, Maxb[FB] - 1 do
                            local yes
                            for i = 1, BG.Maxi do
                                local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                                local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                                local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
                                if zhuangbei and GetItemID(zhuangbei:GetText()) == itemID and
                                    maijia:GetText() == "" and jine:GetText() == ""
                                then
                                    yes = true
                                    maijia:SetText(v.maijia or "")
                                    BiaoGe[FB]["boss" .. b]["maijia" .. i] = v.maijia
                                    if v.color then
                                        maijia:SetTextColor(unpack(v.color))
                                    else
                                        maijia:SetTextColor(1, 1, 1)
                                    end
                                    for k in pairs(BG.playerClass) do
                                        BiaoGe[FB]["boss" .. b][k .. i] = v[k]
                                    end

                                    jine:SetText(v.jine or "")
                                    BiaoGe[FB]["boss" .. b]["jine" .. i] = v.jine
                                    break
                                end
                            end
                            if yes then break end
                        end
                    end
                end
            end)

            local bt = BG.CreateButton(BG.auctionLogFrame)
            bt:SetSize(95, 25)
            bt:SetPoint("BOTTOMRIGHT", BG.auctionLogFrame, -5, 10)
            bt:SetText(L["生成对账单"])
            BG.auctionLogFrame.ButtonCreateDuiZhang = bt
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
                GameTooltip:AddLine(L["根据自动拍卖记录，生成一个对账单。"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", GameTooltip_Hide)
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(2)
                local FB = BG.FB1
                local duizhang = {}
                duizhang.addons = "biaoge"
                duizhang.FB = FB
                duizhang.t = GetServerTime()
                duizhang.time = date("%m-%d %H:%M:%S", GetServerTime())
                duizhang.msgTbl = {}
                duizhang.player = BG.STC_g1(L["自动拍卖记录"])
                duizhang.sumjine = 0
                duizhang.zhangdan = {}
                local num = 0
                for i, v in ipairs(BiaoGe[FB].auctionLog) do
                    if v.type == 1 then
                        num = num + 1
                        duizhang.zhangdan[num] = BG.Copy(v)
                        duizhang.zhangdan[num].type = nil
                        duizhang.zhangdan[num].time = nil
                        duizhang.zhangdan[num].bindType = nil
                        duizhang.zhangdan[num].itemlevel = nil
                        duizhang.zhangdan[num].quality = nil
                        duizhang.sumjine = duizhang.sumjine + (tonumber(v.jine) or 0)
                    end
                end
                tinsert(BiaoGe.duizhang, duizhang)
                BG.DuiZhangList()
            end)
        end
    end

    -- 增加记录
    do
        local f = CreateFrame("Frame", nil, BG.auctionLogFrame, "BackdropTemplate")
        do
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 10,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.8)
            f:SetSize(220, 140)
            f:SetFrameLevel(117)
            f:EnableMouse(true)
            f:Hide()
            BG.auctionLogFrame.changeFrame = f
            f:SetScript("OnMouseDown", function(self)
                if BG.FrameZhuangbeiList then
                    BG.FrameZhuangbeiList:Hide()
                end
                BG.ClearFocus()
            end)
            f:SetScript("OnShow", function(self)
                if BG.auctionLogFrame.changeFrame.type == "change" then
                    f.item:Show()
                    f.zhuangbei:Hide()
                    f.title:SetText(BG.auctionLogFrame.changeFrame.typeText)
                    f.ButtonSure:Enable()
                elseif BG.auctionLogFrame.changeFrame.type == "new" then
                    f.item:Hide()
                    f.zhuangbei:Show()
                    f.zhuangbei:SetFocus()
                    f.title:SetText(L["增加记录"])
                    f.ButtonSure:Disable()
                elseif BG.auctionLogFrame.changeFrame.type == "set" then
                    f.item:Show()
                    f.zhuangbei:Hide()
                    f.title:SetText(L["设为已拍"])
                    f.ButtonSure:Disable()
                end
                f.zhuangbei:SetText("")
                f.maijia:SetText("")
                f.jine:SetText("")
            end)

            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOP", 0, -10)
            f.title = t
        end
        -- 装备
        do
            local title = f:CreateFontString()
            title:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            title:SetPoint("TOPLEFT", 5, -35)
            title:SetText(L["装备："])
            title:SetTextColor(1, 0.82, 0)
            title:SetWidth(60)
            title:SetJustifyH("RIGHT")
            title:SetWordWrap(false)

            -- 修改装备
            do
                local _f = CreateFrame("Frame", nil, BG.auctionLogFrame.changeFrame, "BackdropTemplate")
                _f:SetPoint("LEFT", title, "RIGHT", 10, 0)
                _f:SetSize(120, 15)
                _f:SetHyperlinksEnabled(true)
                local t = _f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                t:SetAllPoints()
                t:SetJustifyH("LEFT")
                t:SetWordWrap(false)
                f.item = t
                t.title = title
                _f:SetScript("OnHyperlinkEnter", function(self, link, text, button)
                    local itemID = GetItemInfoInstant(link)
                    if itemID then
                        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -self:GetWidth() + t:GetWrappedWidth(), 0)
                        GameTooltip:ClearLines()
                        GameTooltip:SetHyperlink(BG.SetSpecIDToLink(link))
                    end
                end)
                _f:SetScript("OnHyperlinkLeave", GameTooltip_Hide)
            end

            -- 手动添加装备
            do
                local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
                edit:SetSize(110, 20)
                edit:SetPoint("LEFT", title, "RIGHT", 10, 0)
                edit:SetAutoFocus(false)
                f.zhuangbei = edit
                edit:SetScript("OnEditFocusGained", function(self)
                    self:HighlightText()
                    BG.lastfocus = self
                end)
                edit:SetScript("OnTextChanged", function(self)
                    if GetItemID(self:GetText()) and GetItemInfoInstant(self:GetText()) then
                        f.ButtonSure:Enable()
                    else
                        f.ButtonSure:Disable()
                    end
                end)
                edit:SetScript("OnMouseDown", function(self, button)
                    if BG.auctionLogFrame.changeFrame.type == "set" then return end
                    if button == "RightButton" then
                        self:SetEnabled(false)
                        self:SetText("")
                        return
                    end
                end)
                edit:SetScript("OnMouseUp", function(self, button)
                    if BG.auctionLogFrame.changeFrame.type == "set" then return end
                    local infoType, itemID, itemLink = GetCursorInfo()
                    if infoType == "item" then
                        self:SetText(itemLink)
                        self:ClearFocus()
                        ClearCursor()
                    end
                    self:SetEnabled(true)
                end)
                edit:SetScript("OnEnter", function(self, button)
                    if not tonumber(self:GetText()) then
                        local link = self:GetText()
                        local itemID = GetItemInfoInstant(link)
                        if itemID then
                            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                            GameTooltip:ClearLines()
                            GameTooltip:SetHyperlink(BG.SetSpecIDToLink(link))
                        end
                    end
                end)
                edit:SetScript("OnLeave", GameTooltip_Hide)

                -- 提示
                local bt = CreateFrame("Button", nil, edit)
                bt:SetSize(28, 28)
                bt:SetPoint("LEFT", edit, "RIGHT", 0, -1)
                f.zhuangbei.tip = bt
                local tex = bt:CreateTexture()
                tex:SetAllPoints()
                tex:SetTexture(616343)
                bt:SetHighlightTexture(616343)
                bt:SetScript("OnEnter", function(self)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:ClearLines()
                    GameTooltip:AddLine(L['添加装备'], 1, 1, 1, true)
                    GameTooltip:AddLine(L["按住Shift+点击表格/背包/聊天框装备；直接把装备拖到格子里"], 1, 0.82, 0, true)
                    GameTooltip:Show()
                end)
                bt:SetScript("OnLeave", GameTooltip_Hide)
            end
        end
        -- 买家
        do
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOPLEFT", f.item.title, "BOTTOMLEFT", 0, -7)
            t:SetText(L["买家："])
            t:SetTextColor(1, 0.82, 0)
            t:SetWidth(60)
            t:SetJustifyH("RIGHT")
            t:SetWordWrap(false)
            local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
            edit:SetSize(110, 20)
            edit:SetPoint("LEFT", t, "RIGHT", 10, 0)
            edit:SetAutoFocus(false)
            edit.title = t
            f.maijia = edit
            edit:SetScript("OnTextChanged", function(self)
                if self:GetText() == "" then
                    self:SetTextColor(1, 1, 1)
                    BG.auctionLogFrame.changeFrame.info.maijia = nil
                    BG.auctionLogFrame.changeFrame.info.color = nil
                    if BG.FrameMaijiaList then
                        BG.FrameMaijiaList:Hide()
                    end
                else
                    BG.auctionLogFrame.changeFrame.info.maijia = self:GetText()
                    BG.auctionLogFrame.changeFrame.info.color = { self:GetTextColor() }
                end
                if BG.auctionLogFrame.changeFrame.type == "set" then
                    if self:GetText() ~= "" or f.maijia:GetText() ~= "" then
                        f.ButtonSure:Enable()
                    else
                        f.ButtonSure:Disable()
                    end
                end
            end)
            edit:SetScript("OnEditFocusGained", function(self)
                self:HighlightText()
                BG.lastfocus = self
                BG.SetListmaijia(self, true, nil, true)
            end)
            edit:SetScript("OnEditFocusLost", function(self)
                self:ClearHighlightText()
                if BG.FrameMaijiaList then
                    BG.FrameMaijiaList:Hide()
                end
            end)
            edit:SetScript("OnEnterPressed", function(self)
                self:ClearFocus()
                if BG.FrameMaijiaList then
                    BG.FrameMaijiaList:Hide()
                end
            end)
            edit:SetScript("OnMouseDown", function(self, enter)
                if enter == "RightButton" then
                    self:SetEnabled(false)
                    self:SetText("")
                    if BG.lastfocus then
                        BG.lastfocus:ClearFocus()
                    end
                end
            end)
            edit:SetScript("OnMouseUp", function(self, enter)
                self:SetEnabled(true)
            end)
        end
        -- 金额
        do
            local t = f:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOPLEFT", f.maijia.title, "BOTTOMLEFT", 0, -7)
            t:SetText(L["金额："])
            t:SetTextColor(1, 0.82, 0)
            t:SetWidth(60)
            t:SetJustifyH("RIGHT")
            t:SetWordWrap(false)
            local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
            edit:SetSize(110, 20)
            edit:SetPoint("LEFT", t, "RIGHT", 10, 0)
            edit:SetAutoFocus(false)
            edit:SetNumeric(true)
            f.jine = edit
            edit:SetScript("OnTextChanged", function(self)
                BG.UpdateTwo0(self)
                if self:GetText() == "" then
                    BG.auctionLogFrame.changeFrame.info.jine = nil
                else
                    BG.auctionLogFrame.changeFrame.info.jine = self:GetText()
                end
                if BG.auctionLogFrame.changeFrame.type == "set" then
                    if self:GetText() ~= "" or f.maijia:GetText() ~= "" then
                        f.ButtonSure:Enable()
                    else
                        f.ButtonSure:Disable()
                    end
                end
            end)
            edit:SetScript("OnEditFocusGained", function(self)
                self:HighlightText()
                BG.lastfocus = self
                local f = BG.CreateNumFrame(BG.auctionLogFrame.changeFrame)
                if f then
                    f:ClearAllPoints()
                    f:SetPoint("TOPLEFT", BG.auctionLogFrame.changeFrame, "TOPRIGHT", 0, 0)
                end
            end)
            edit:HookScript("OnEditFocusLost", function(self)
                if BG.FrameNumFrame then
                    BG.FrameNumFrame:Hide()
                end
            end)
            edit:SetScript("OnEnterPressed", function(self)
                f.ButtonSure:GetScript("OnClick")()
            end)
            edit:SetScript("OnMouseDown", function(self, enter)
                if enter == "RightButton" then
                    self:SetEnabled(false)
                    self:SetText("")
                    if BG.lastfocus then
                        BG.lastfocus:ClearFocus()
                    end
                end
            end)
            edit:SetScript("OnMouseUp", function(self, enter)
                self:SetEnabled(true)
            end)
        end
        -- 按钮
        do
            local bt = BG.CreateButton(f)
            bt:SetSize(95, 22)
            bt:SetPoint("BOTTOMLEFT", 10, 10)
            bt:SetText(L["确定"])
            f.ButtonSure = bt
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                local FB = BG.FB1
                if BG.auctionLogFrame.changeFrame.type == "change" then
                    local i = BG.auctionLogFrame.changeFrame.info.num
                    if not (BG.auctionLogFrame.changeFrame.info.maijia or BG.auctionLogFrame.changeFrame.info.jine) then
                        BiaoGe[FB].auctionLog[i].type = 2
                        BiaoGe[FB].auctionLog[i].maijia = nil
                        BiaoGe[FB].auctionLog[i].jine = nil
                    else
                        BiaoGe[FB].auctionLog[i].type = 1
                        BiaoGe[FB].auctionLog[i].maijia = BG.auctionLogFrame.changeFrame.info.maijia or ""
                        BiaoGe[FB].auctionLog[i].jine = BG.auctionLogFrame.changeFrame.info.jine or ""
                    end
                    for k in pairs(BG.playerClass) do
                        BiaoGe[FB].auctionLog[i][k] = BG.auctionLogFrame.changeFrame.info[k]
                    end
                    f:Hide()
                    BG.UpdateAuctionLogFrame(true)
                elseif BG.auctionLogFrame.changeFrame.type == "new" or BG.auctionLogFrame.changeFrame.type == "set" then
                    local zhuangbei
                    if BG.auctionLogFrame.changeFrame.type == "new" then
                        zhuangbei = f.zhuangbei:GetText()
                    elseif BG.auctionLogFrame.changeFrame.type == "set" then
                        zhuangbei = f.item:GetText():gsub("|T.+|t", ""):gsub(":|h", ":|h["):gsub("|h|r", "]|h|r")
                    end

                    local name, link, quality, level, _, _, _, _, EquipLoc, Texture,
                    _, typeID, subclassID, bindType = GetItemInfo(zhuangbei)
                    local a = {
                        time = GetServerTime(),
                        zhuangbei = zhuangbei,
                        itemlevel = level,
                        quality = quality,
                        bindType = bindType,
                    }

                    if not (BG.auctionLogFrame.changeFrame.info.maijia or BG.auctionLogFrame.changeFrame.info.jine) then
                        a.type = 2
                        a.maijia = nil
                        a.jine = nil
                    else
                        a.type = 1
                        a.maijia = BG.auctionLogFrame.changeFrame.info.maijia or ""
                        a.jine = BG.auctionLogFrame.changeFrame.info.jine or ""
                    end
                    for k in pairs(BG.playerClass) do
                        a[k] = BG.auctionLogFrame.changeFrame.info[k]
                    end
                    BiaoGe[FB].auctionLog = BiaoGe[FB].auctionLog or {}
                    tinsert(BiaoGe[FB].auctionLog, a)
                    f:Hide()
                    if BG.auctionLogFrame.changeFrame.type == "new" then
                        BG.UpdateAuctionLogFrame(nil, true)
                    elseif BG.auctionLogFrame.changeFrame.type == "set" then
                        BG.UpdateAuctionLogFrame(true, true)
                    end
                end
            end)

            local bt = BG.CreateButton(f)
            bt:SetSize(95, 22)
            bt:SetPoint("BOTTOMRIGHT", -10, 10)
            bt:SetText(L["取消"])
            bt:SetScript("OnClick", function(self)
                f:Hide()
            end)
        end
    end

    BG.auctionLogFrame.auctioning = {}
    BG.auctionLogFrame.buttons = {}
    BG.auctionLogFrame.choosed = {}
    local lastChoose

    local function UpdateButtonStartAuction()
        local bt = BG.auctionLogFrame.ButtonStartAuction
        if BiaoGe.options.auctionLogChoose ~= 4 then
            bt:Hide()
        end
        if #BG.auctionLogFrame.choosed > 0 then
            bt:Show()
            if BG.IsML then
                bt:Enable()
            else
                bt:Disable()
            end
        else
            bt:Hide()
        end
    end
    -- 右键菜单
    local function CreateMenu(f, i, v, notAuctioned, link, icon, isHistory)
        local FB = BG.FB1
        local menu
        if isHistory then
            -- 成功
            if v.type == 1 and v.log then
                local text = ""
                local isMore = true
                for i, _v in ipairs(v.log) do
                    if _v.i == 1 then
                        isMore = false
                    end
                    text = text .. _v.i .. L["、"] .. _v.money .. format(L["（%s）"], _v.player) .. NN
                end
                if isMore then
                    text = BG.STC_dis("......\n") .. text
                end
                menu = {
                    {
                        isTitle = true,
                        text = link:gsub("%[", ""):gsub("%]", ""),
                        notCheckable = true,
                    },
                    {
                        text = L["出价记录"],
                        notCheckable = true,
                        tooltipTitle = L["出价记录"],
                        tooltipText = text,
                        tooltipOnButton = true,
                    },
                    {
                        isTitle = true,
                        text = "   ",
                        notCheckable = true,
                    },
                    {
                        text = CANCEL,
                        notCheckable = true,
                        func = function(self)
                            LibBG:CloseDropDownMenus()
                        end,
                    },
                }
            end
        elseif notAuctioned then
            menu = {
                {
                    isTitle = true,
                    text = link:gsub("%[", ""):gsub("%]", ""),
                    notCheckable = true,
                },
                {
                    text = L["开始拍卖"],
                    disabled = not BG.IsML,
                    notCheckable = true,
                    func = function()
                        BG.StartAuction(link, f, true, true)
                    end
                },
                {
                    isTitle = true,
                    text = "   ",
                    notCheckable = true,
                },
                {
                    text = L["设为已拍"],
                    notCheckable = true,
                    func = function()
                        BG.auctionLogFrame.changeFrame:Hide()
                        BG.auctionLogFrame.changeFrame.type = "set"
                        BG.auctionLogFrame.changeFrame.info = {}
                        BG.auctionLogFrame.changeFrame:Show()
                        BG.auctionLogFrame.changeFrame:ClearAllPoints()
                        BG.auctionLogFrame.changeFrame:SetPoint("TOP", f, "BOTTOM", 10, 0)
                        BG.auctionLogFrame.changeFrame.item:SetText(AddTexture(icon) .. v.zhuangbei:gsub("%[", ""):gsub("%]", ""))
                    end
                },
                {
                    text = L["设为流拍"],
                    notCheckable = true,
                    func = function()
                        BiaoGe[FB].auctionLog = BiaoGe[FB].auctionLog or {}
                        tinsert(BiaoGe[FB].auctionLog, {
                            type = 2,
                            time = GetServerTime(),
                            zhuangbei = v.zhuangbei,
                            itemlevel = v.level,
                            quality = v.quality,
                            bindType = v.bindType,
                        })
                        BG.UpdateAuctionLogFrame(true, true)
                    end
                },
                {
                    isTitle = true,
                    text = "   ",
                    notCheckable = true,
                },
                {
                    text = CANCEL,
                    notCheckable = true,
                    func = function(self)
                        LibBG:CloseDropDownMenus()
                    end,
                }
            }
        else
            menu = {
                {
                    isTitle = true,
                    text = link:gsub("%[", ""):gsub("%]", ""),
                    notCheckable = true,
                },
                {
                    -- 修改记录
                    notCheckable = true,
                    func = function(self, arg1)
                        BG.auctionLogFrame.changeFrame:Hide()
                        BG.auctionLogFrame.changeFrame.type = "change"
                        BG.auctionLogFrame.changeFrame.typeText = arg1
                        BG.auctionLogFrame.changeFrame.info = {}
                        BG.auctionLogFrame.changeFrame.info.num = i
                        for k in pairs(BG.playerClass) do
                            BG.auctionLogFrame.changeFrame.info[k] = v[k]
                        end
                        BG.auctionLogFrame.changeFrame:Show()
                        BG.auctionLogFrame.changeFrame:ClearAllPoints()
                        BG.auctionLogFrame.changeFrame:SetPoint("TOP", f, "BOTTOM", 10, 0)
                        BG.auctionLogFrame.changeFrame.item:SetText(AddTexture(icon) .. link:gsub("%[", ""):gsub("%]", ""))
                        BG.auctionLogFrame.changeFrame.item.itemID = GetItemID(link)
                        BG.auctionLogFrame.changeFrame.maijia:ClearFocus()
                        BG.auctionLogFrame.changeFrame.maijia:SetText(v.maijia or "")
                        BG.auctionLogFrame.changeFrame.maijia:SetTextColor(unpack(v.color or { 1, 1, 1 }))
                        BG.auctionLogFrame.changeFrame.jine:ClearFocus()
                        BG.auctionLogFrame.changeFrame.jine:SetText(v.jine or "")
                    end
                },

                {
                    text = L["删除记录"],
                    notCheckable = true,
                    func = function()
                        BG.auctionLogFrame.changeFrame:Hide()
                        tremove(BiaoGe[FB].auctionLog, i)
                        BG.UpdateAuctionLogFrame(true, true)
                    end
                },
                {
                    isTitle = true,
                    text = "   ",
                    notCheckable = true,
                },
                {
                    text = CANCEL,
                    notCheckable = true,
                    func = function(self)
                        LibBG:CloseDropDownMenus()
                    end,
                }
            }

            if v.type == 1 then
                -- 成功
                menu[2].text = L["修改记录"]
                menu[2].arg1 = menu[2].text

                local num = 2
                if v.log then
                    local text = ""
                    local isMore = true
                    for i, _v in ipairs(v.log) do
                        if _v.i == 1 then
                            isMore = false
                        end
                        text = text .. _v.i .. L["、"] .. _v.money .. format(L["（%s）"], _v.player) .. NN
                    end
                    if isMore then
                        text = BG.STC_dis("......\n") .. text
                    end
                    tinsert(menu, num,
                        {
                            text = L["出价记录"],
                            notCheckable = true,
                            tooltipTitle = L["出价记录"],
                            tooltipText = text,
                            tooltipOnButton = true,
                        }
                    )
                    num = num + 1
                end
                tinsert(menu, num,
                    {
                        text = L["设为流拍"],
                        notCheckable = true,
                        func = function()
                            v.type = 2
                            v.maijia = nil
                            v.jine = nil
                            v.trade = nil
                            for k in pairs(BG.playerClass) do
                                v[k] = nil
                            end
                            BG.UpdateAuctionLogFrame(true, true)
                        end
                    }
                )
                num = num + 1
                if v.trade then
                    tinsert(menu, num,
                        {
                            text = L["设为未交易"],
                            notCheckable = true,
                            func = function()
                                v.trade = nil
                                BG.UpdateAuctionLogFrame(true, true)
                            end
                        }
                    )
                else
                    tinsert(menu, num,
                        {
                            text = L["设为已交易"],
                            notCheckable = true,
                            tooltipTitle = L["设为已交易"],
                            tooltipText = L["交易时不再显示该装备的应收/应付金额，团长也不会自动摆放该装备。"],
                            tooltipOnButton = true,
                            func = function()
                                v.trade = true
                                BG.UpdateAuctionLogFrame(true, true)
                            end
                        }
                    )
                end

                tinsert(menu, num + 1,
                    {
                        isTitle = true,
                        text = "   ",
                        notCheckable = true,
                    }
                )
            elseif v.type == 2 then
                -- 流拍
                menu[2].text = L["设为已拍"]
                menu[2].arg1 = menu[2].text

                tinsert(menu, 3,
                    {
                        isTitle = true,
                        text = "   ",
                        notCheckable = true,
                    }
                )
            end
        end
        return menu
    end
    -- 列表内容
    local function CreateButton(i, v, isHistory, num)
        local FB = BG.FB1
        local bts = {}
        local width = child:GetWidth()
        local link = v.zhuangbei
        local itemID = GetItemID(link)
        local icon, typeID = select(5, GetItemInfoInstant(link))
        local r, g, b = GetItemQualityColor(v.quality)
        local notAuctioned = v.type == 3
        bts.link = link
        bts.itemID = itemID
        bts.num = num

        -- 主框架
        do
            local function CancelChoose(bt)
                bt.ischoose = nil
                if bt.num % 2 == 0 then
                    bt.tex:SetColorTexture(.5, .5, .5, .15)
                else
                    bt.tex:SetColorTexture(0, 0, 0, .25)
                end
            end

            local f = CreateFrame("Frame", nil, child, "BackdropTemplate")
            f:SetSize(width, 32)
            if #BG.auctionLogFrame.buttons == 0 then
                f:SetPoint("TOPLEFT")
            else
                f:SetPoint("TOPLEFT", BG.auctionLogFrame.buttons[#BG.auctionLogFrame.buttons].frame, "BOTTOMLEFT", 0, 0)
            end
            f:Show()
            f.link = link
            bts.frame = f
            f:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(frame.tooltip, "ANCHOR_BOTTOMRIGHT", 0, 0)
                GameTooltip:ClearLines()
                local itemID = GetItemInfoInstant(link)
                if itemID then
                    GameTooltip:SetHyperlink(BG.SetSpecIDToLink(link))
                    BG.Show_AllHighlight(link, "auctionlog")
                    BG.SetHistoryMoney(itemID)
                    if IsAltKeyDown() and BG.IsML and v.type == 3 and BiaoGe.options["autoAuctionStart"] == 1 then
                        SetCursor("interface/cursor/repair")
                    end
                    if v.type == 3 and BG.IsML then
                        BG.canShowStartAuctionCursor = true
                    end
                end
                bts.ds:Show()
            end)
            f:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                BG.Hide_AllHighlight()
                BG.HideHistoryMoney()
                bts.ds:Hide()
                SetCursor(nil)
                BG.canShowStartAuctionCursor = false
            end)
            f:SetScript("OnMouseDown", function(self, button)
                if button == "RightButton" then
                    wipe(BG.auctionLogFrame.choosed)
                    lastChoose = num
                    for _i, bt in ipairs(BG.auctionLogFrame.buttons) do
                        CancelChoose(bt)
                    end
                    if IsAltKeyDown() then
                        BG.StartAuction(link, f, true, nil, button == "RightButton")
                    else
                        local menu = CreateMenu(f, i, v, notAuctioned, link, icon, isHistory)
                        if menu then
                            LibBG:EasyMenu(menu, dropDown, "cursor", 10, 10, "MENU", 2)
                            BG.PlaySound(1)
                        end
                    end
                else
                    if v.type == 3 then
                        BG.PlaySound(1)
                        if IsControlKeyDown() then
                            bts.ischoose = not bts.ischoose
                            if bts.ischoose then
                                if #BG.auctionLogFrame.choosed < 5 then
                                    tinsert(BG.auctionLogFrame.choosed, itemID)
                                    bts.tex:SetColorTexture(1, 1, 0, .5)
                                else
                                    bts.ischoose = nil
                                end
                                lastChoose = num
                            else
                                for _i = #BG.auctionLogFrame.choosed, 1, -1 do
                                    if BG.auctionLogFrame.choosed[_i] == itemID then
                                        tremove(BG.auctionLogFrame.choosed, _i)
                                    end
                                end

                                CancelChoose(bts)
                            end
                        elseif IsAltKeyDown() then
                            BG.StartAuction(link, f, true, nil, button == "RightButton")
                            CancelAllChoose()
                        elseif IsShiftKeyDown() then
                            if #BG.auctionLogFrame.choosed == 0 then
                                BG.InsertLink(link)
                            elseif lastChoose then
                                for _i, bt in ipairs(BG.auctionLogFrame.buttons) do
                                    if _i ~= i then
                                        CancelChoose(bt)
                                    end
                                end
                                wipe(BG.auctionLogFrame.choosed)

                                local count = 0
                                for _i = lastChoose, num, lastChoose < num and 1 or -1 do
                                    if count < 5 then
                                        local bt = BG.auctionLogFrame.buttons[_i]
                                        bt.ischoose = true
                                        tinsert(BG.auctionLogFrame.choosed, bt.itemID)
                                        bt.tex:SetColorTexture(1, 1, 0, .5)
                                        count = count + 1
                                    end
                                end
                                lastChoose = nil
                            end
                        else
                            BG.PlaySound(1)

                            for _i, bt in ipairs(BG.auctionLogFrame.buttons) do
                                if _i ~= i then
                                    CancelChoose(bt)
                                end
                            end
                            wipe(BG.auctionLogFrame.choosed)

                            bts.ischoose = not bts.ischoose
                            if bts.ischoose then
                                tinsert(BG.auctionLogFrame.choosed, itemID)
                                bts.tex:SetColorTexture(1, 1, 0, .5)
                                lastChoose = num
                            else
                                for _i = #BG.auctionLogFrame.choosed, 1, -1 do
                                    if BG.auctionLogFrame.choosed[_i] == itemID then
                                        tremove(BG.auctionLogFrame.choosed, _i)
                                    end
                                end
                                CancelChoose(bts)
                            end
                        end
                        UpdateButtonStartAuction()
                        LibBG:CloseDropDownMenus()
                    else
                        if IsShiftKeyDown() then
                            BG.PlaySound(1)
                            BG.InsertLink(link)
                        end
                    end
                end
            end)

            local tex = bts.frame:CreateTexture(nil, "BACKGROUND")
            tex:SetAllPoints()
            if num % 2 == 0 then
                tex:SetColorTexture(.5, .5, .5, .15)
            else
                tex:SetColorTexture(0, 0, 0, .25)
            end
            bts.tex = tex

            local tex = bts.frame:CreateTexture()
            tex:SetAllPoints()
            tex:SetColorTexture(.5, .5, .5, .5)
            tex:Hide()
            bts.ds = tex

            tinsert(BG.auctionLogFrame.buttons, bts)

            BG.UpdateFilter(f, link)
        end
        -- 图标和装等
        do
            local f = CreateFrame("Frame", nil, bts.frame, "BackdropTemplate")
            f:SetBackdrop({
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            f:SetBackdropBorderColor(r, g, b)
            f:SetSize(bts.frame:GetHeight() - 2, bts.frame:GetHeight() - 2)
            f:SetPoint("LEFT")
            bts.iconFrame = f
            local tex = f:CreateTexture(nil, "BACKGROUND")
            tex:SetAllPoints()
            tex:SetTexture(icon)
            tex:SetTexCoord(.04, .96, .04, .96)
            bts.icon = tex
            f.level = f:CreateFontString()
            f.level:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
            f.level:SetPoint("BOTTOM", bts.icon, 0, 1)
            f.level:SetText((typeID == 2 or typeID == 4) and v.itemlevel or nil)
            f.level:SetTextColor(r, g, b)
            if v.bindType == 2 then
                local text = bts.iconFrame:CreateFontString()
                text:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
                text:SetPoint("TOP", bts.iconFrame, 0, -1)
                text:SetText(L["装绑"])
                text:SetTextColor(0, 1, 0)
            end
        end
        -- 装备
        do
            local text = bts.frame:CreateFontString()
            text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
            text:SetWidth(width - bts.icon:GetWidth())
            text:SetPoint("TOPLEFT", bts.icon, "TOPRIGHT", 1, 0)
            text:SetText(link:gsub("%[", ""):gsub("%]", ""))
            text:SetJustifyH("LEFT")
            text:SetWordWrap(false)
            bts.item = text
        end
        -- 买家和金额
        do
            local text = bts.frame:CreateFontString()
            text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
            text:SetPoint("BOTTOMLEFT", bts.icon, "BOTTOMRIGHT", 1, 0)
            text:SetWidth(width - bts.icon:GetWidth())
            text.notAuctionedText = BG.STC_dis(L["<未拍>"])
            text.LiuPaiText = BG.STC_r1(L["<流拍>"])
            text.auctionText = BG.STC_y1(L["<正在拍卖>"])
            if v.type == 1 then
                text:SetText(v.jine .. "|c" .. select(4, GetClassColor(v.class)) .. " " .. v.maijia .. "" .. RR)
            elseif notAuctioned then
                text:SetText(text.notAuctionedText)
            else
                text:SetText(text.LiuPaiText)
            end
            text:SetJustifyH("LEFT")
            text:SetWordWrap(false)
            bts.money = text
        end
        -- 已拍未交易
        if v.type == 1 and v.trade then
            local text = bts.frame:CreateFontString()
            text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
            text:SetPoint("TOPRIGHT", -1, -1)
            text:SetText(L["已交易"])
            text:SetTextColor(0, 1, 0)
        end
    end

    function CancelAllChoose()
        wipe(BG.auctionLogFrame.choosed)
        BG.UpdateAuctionLogFrame(nil, true)
    end

    local function SearchText(v)
        local searchText = BG.auctionLogFrame.serachEdit:GetText()
        if searchText == "" then
            return true
        end
        if v.zhuangbei and v.zhuangbei:match("%[.+%]"):find(searchText, 1, true) then
            return true
        end
        if v.maijia and v.maijia:find(searchText, 1, true) then
            return true
        end
        if v.jine and v.jine == searchText then
            return true
        end
    end

    local function UpdateFrameSize()
        BG.auctionLogFrame:SetHeight(BG.FBHeight[BG.FB1])
        child:SetHeight(scroll:GetHeight())
    end

    function BG.UpdateAuctionLogFrame(notSetDown, notSetUp)
        if not BG.auctionLogFrame:IsVisible() then return end
        UpdateFrameSize()
        for i, v in ipairs(BG.auctionLogFrame.buttons) do
            v.frame:Hide()
        end
        wipe(BG.auctionLogFrame.buttons)
        BG.auctionLogFrame.notText:Hide()
        if not notSetUp then
            wipe(BG.auctionLogFrame.choosed)
            lastChoose = nil
        end
        UpdateButtonStartAuction()

        local FB = BG.FB1
        local sum = 0
        local tbl
        local isHistory
        local notCache = 0
        if BG.History.chooseNum then
            isHistory = true
        end
        if isHistory then
            local DT = BiaoGe.HistoryList[FB][BG.History.chooseNum][1]
            tbl = BiaoGe.History[FB][DT].auctionLog
        elseif BG.HistoryMainFrame:IsVisible() then
            isHistory = true
        else
            tbl = BiaoGe[FB].auctionLog
        end
        if not tbl or #tbl == 0 then
            BG.auctionLogFrame.ButtonCreateLedger:Disable()
            BG.auctionLogFrame.ButtonCreateDuiZhang:Disable()
            if BiaoGe.options.auctionLogChoose ~= 4 then
                BG.auctionLogFrame.notText:Show()
            end
        else
            BG.auctionLogFrame.ButtonCreateLedger:Enable()
            BG.auctionLogFrame.ButtonCreateDuiZhang:Enable()
        end
        if isHistory then
            BG.auctionLogFrame.ButtonCreateLedger:Disable()
            BG.auctionLogFrame.ButtonCreateDuiZhang:Disable()
            BG.auctionLogFrame.ButtonAdd:Disable()
            BG.auctionLogFrame.title:SetText(L["历史自动拍卖记录"])
            BG.auctionLogFrame.title:SetTextColor(RGB(BG.b1))
        else
            BG.auctionLogFrame.ButtonAdd:Enable()
            BG.auctionLogFrame.title:SetText(L["自动拍卖记录"])
            BG.auctionLogFrame.title:SetTextColor(1, 1, 1)
        end
        if tbl then
            local num = 0
            for i, v in ipairs(tbl) do
                if (BiaoGe.options.auctionLogChoose == 1 or
                        (v.type == 1 and BiaoGe.options.auctionLogChoose == 2)
                        or (v.type == 2 and BiaoGe.options.auctionLogChoose == 3))
                    and SearchText(v)
                then
                    num = num + 1
                    CreateButton(i, v, isHistory, num)
                end
                sum = sum + (tonumber(v.jine) or 0)
            end
        end

        if BiaoGe.options.auctionLogChoose == 4 then
            local newTbl = {}
            for b = 1, Maxb[FB] do
                for i = 1, BG.Maxi do
                    if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                        local zb
                        if isHistory then
                            if BG.History.chooseNum then
                                local DT = BiaoGe.HistoryList[FB][BG.History.chooseNum][1]
                                zb = BiaoGe.History[FB][DT]["boss" .. b]["zhuangbei" .. i]
                            end
                        else
                            zb = BiaoGe[FB]["boss" .. b]["zhuangbei" .. i]
                        end
                        if GetItemID(zb) then
                            tinsert(newTbl, zb)
                        end
                    end
                end
            end
            if tbl then
                local copyTbl = BG.Copy(tbl)
                for i = #newTbl, 1, -1 do
                    for _i = #copyTbl, 1, -1 do
                        if GetItemID(newTbl[i]) == GetItemID(copyTbl[_i].zhuangbei) then
                            tremove(newTbl, i)
                            tremove(copyTbl, _i)
                            break
                        end
                    end
                end
            end
            for i, zhuangbei in ipairs(newTbl) do
                local item = Item:CreateFromItemID(GetItemID(zhuangbei))
                if not GetItemInfo(zhuangbei) then
                    notCache = 0.5
                end
                item:ContinueOnItemLoad(function()
                    local name, link, quality, level, _, _, _, _, EquipLoc, Texture,
                    _, typeID, subclassID, bindType = GetItemInfo(zhuangbei)
                    newTbl[i] = {
                        type = 3,
                        zhuangbei = zhuangbei,
                        itemlevel = level,
                        quality = quality,
                        bindType = bindType,
                    }
                end)
            end

            local function Create()
                for i, bt in ipairs(BG.auctionLogFrame.buttons) do
                    bt.frame:Hide()
                end
                wipe(BG.auctionLogFrame.buttons)

                for i, v in ipairs(newTbl) do
                    if SearchText(v) then
                        CreateButton(i, v, isHistory, i)
                    end
                end
                BG.UpdateAuctioning()

                for i, itemID in ipairs(BG.auctionLogFrame.choosed) do
                    for i, bt in ipairs(BG.auctionLogFrame.buttons) do
                        if bt.itemID == itemID then
                            bt.ischoose = true
                            bt.tex:Show()
                            bt.tex:SetColorTexture(1, 1, 0, .5)
                            break
                        end
                    end
                end
            end
            if notCache == 0 then
                Create()
            else
                BG.After(notCache, function()
                    Create()
                end)
            end
        end

        BG.auctionLogFrame.sumText:SetText(L["合计收入："] .. sum)

        if BiaoGe.options.auctionLogChoose == 4 then
            if not notSetUp then
                BG.After(notCache + 0.05, function()
                    local min, max = frame.scroll.ScrollBar:GetMinMaxValues()
                    frame.scroll.ScrollBar:SetValue(min)
                end)
            end
        elseif not notSetDown then
            BG.After(0, function()
                local min, max = frame.scroll.ScrollBar:GetMinMaxValues()
                frame.scroll.ScrollBar:SetValue(max)
            end)
        end
    end

    function BG.UpdateAuctioning()
        if BiaoGe.options.auctionLogChoose == 4 then
            local auctioning = BG.Copy(BG.auctionLogFrame.auctioning)
            for _, bt in ipairs(BG.auctionLogFrame.buttons) do
                bt.money:SetText(bt.money.notAuctionedText)
                for i = #auctioning, 1, -1 do
                    if bt.itemID == auctioning[i] then
                        bt.money:SetText(bt.money.auctionText)
                        tremove(auctioning, i)
                        break
                    end
                end
            end
        end
    end

    BG.auctionLogFrame.serachEdit:HookScript("OnTextChanged", BG.UpdateAuctionLogFrame)

    -- 记录自动拍卖结果
    do
        local function DeleteAuctioning(itemID)
            for i = #BG.auctionLogFrame.auctioning, 1, -1 do
                if BG.auctionLogFrame.auctioning[i] == itemID then
                    tremove(BG.auctionLogFrame.auctioning, i)
                    break
                end
            end
        end
        function BG.auctionLogFrame.GetTargetTradeTbl(tradeName)
            local FB = BG.FB1
            BG.auctionTrade[tradeName] = {}
            for _, v in ipairs(BiaoGe[FB].auctionLog or {}) do
                if v.type == 1 and not v.trade and v.maijia == tradeName then
                    tinsert(BG.auctionTrade[tradeName], BG.Copy(v))
                end
            end
        end

        BG.RegisterEvent("CHAT_MSG_RAID_LEADER", function(self, event, msg, ...)
            local time = GetServerTime()
            local zhuangbei, maijia, jine
            zhuangbei, maijia, jine = msg:match("{rt6}拍卖成功{rt6} (.-) (.-) (.+)")
            if not (zhuangbei and maijia and jine) then
                zhuangbei, maijia, jine = msg:match("{rt6}拍賣成功{rt6} (.-) (.-) (.+)")
            end
            if (zhuangbei and maijia and jine) then
                local itemID = GetItemID(zhuangbei)
                DeleteAuctioning(itemID)
                local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID, bindType = GetItemInfo(zhuangbei)
                local FB = BG.FB1
                local log
                if BG.sendMoneyLog and BG.sendMoneyLog[itemID] and next(BG.sendMoneyLog[itemID]) then
                    log = {}
                    local num = 1
                    local isVIP = BG.BiaoGeVIPVerNum and BG.BiaoGeVIPVerNum >= 10120 or nil
                    for i = #BG.sendMoneyLog[itemID], 1, -1 do
                        if not isVIP and num > 5 then break end
                        num = num + 1
                        local a = BG.Copy(BG.sendMoneyLog[itemID][i])
                        a.i = i
                        tinsert(log, 1, a)
                    end
                    BG.After(0, function()
                        BG.sendMoneyLog[itemID] = nil
                    end)
                end

                local playerClass = {}
                for k, v in pairs(BG.playerClass) do
                    local value = select(v.select, v.func(maijia))
                    if value == 0 then value = nil end
                    playerClass[k] = value
                end
                if not playerClass.guild then
                    playerClass.realm = nil
                end
                local a = {
                    type = 1,
                    time = time,
                    zhuangbei = zhuangbei,
                    maijia = maijia,
                    jine = jine,
                    itemlevel = level,
                    quality = quality,
                    bindType = bindType,
                    log = log,
                }
                for k, v in pairs(playerClass) do
                    a[k] = v
                end
                BiaoGe[FB].auctionLog = BiaoGe[FB].auctionLog or {}
                tinsert(BiaoGe[FB].auctionLog, a)
                BG.UpdateAuctionLogFrame(nil, true)

                local tradeName = BG.GN("NPC")
                if BG.tradelastAuctionFrame.frame:IsVisible() and tradeName and maijia == tradeName then
                    BG.auctionLogFrame.GetTargetTradeTbl(maijia)
                    if BG.ImML() then
                        BG.tradelastAuctionFrame.UpdateChooseType()
                        BG.tradelastAuctionFrame.UpdateAutoButtons()
                    end
                end
                return
            end

            zhuangbei = msg:match("{rt7}流拍{rt7} (.+)")
            if zhuangbei then
                DeleteAuctioning(GetItemID(zhuangbei))
                local name, link, quality, level, _, _, _, _, EquipLoc, Texture,
                _, typeID, subclassID, bindType = GetItemInfo(zhuangbei)
                local FB = BG.FB1
                local a = {
                    type = 2,
                    time = time,
                    zhuangbei = zhuangbei,
                    itemlevel = level,
                    quality = quality,
                    bindType = bindType,
                }
                BiaoGe[FB].auctionLog = BiaoGe[FB].auctionLog or {}
                tinsert(BiaoGe[FB].auctionLog, a)
                BG.UpdateAuctionLogFrame(nil, true)
                return
            end

            zhuangbei = msg:match("{rt7}拍卖取消{rt7} (.+)")
            if not zhuangbei then
                zhuangbei = msg:match("^{rt7}拍賣取消{rt7} (.+)$")
            end
            if zhuangbei then
                DeleteAuctioning(GetItemID(zhuangbei))
                BG.UpdateAuctioning()
            end
        end)
    end

    -- 拍卖成功的聊天信息后面附上出价记录
    do
        ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", function(self, event, msg, ...)
            if BiaoGe.options.autoAuctionLogLink ~= 1 then return end
            if not (msg:match("^{rt6}拍卖成功{rt6}") or msg:match("^{rt6}拍賣成功{rt6}")) then return end
            local itemID = GetItemID(msg)
            if not itemID then return end
            BG.chatAuctionLog = BG.chatAuctionLog or {}
            local FB = BG.FB1
            local log
            if BiaoGe[FB].auctionLog and next(BiaoGe[FB].auctionLog) then
                local info = BiaoGe[FB].auctionLog[#BiaoGe[FB].auctionLog]
                if GetItemID(info.zhuangbei) == itemID and info.log then
                    log = BG.Copy(info.log)
                end
            end
            if not log then return end
            tinsert(BG.chatAuctionLog, log)
            local link = "|cffFFFF00" .. "|Hgarrmission:BiaoGe:AuctionWALog:" .. itemID .. ":"
                .. #BG.chatAuctionLog .. "|h[" .. L["记录"] .. "]|h|r"
            local newmsg = msg .. link
            return false, newmsg, ...
        end)
        local function OnHyperlinkEnter(self, link)
            if not link then return end
            local _, arg2, arg3, itemID, num = strsplit(":", link)
            if arg2 == "BiaoGe" and arg3 == "AuctionWALog" and num then
                itemID = tonumber(itemID)
                num = tonumber(num)
                local _, link = GetItemInfo(itemID)
                if not link then return end
                GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(link:gsub("%[", ""):gsub("%]", ""), 1, 1, 1, true)
                if BG.chatAuctionLog[num][1] and BG.chatAuctionLog[num][1].i ~= 1 then
                    GameTooltip:AddLine("......", .5, .5, .5, true)
                end
                for i, v in ipairs(BG.chatAuctionLog[num]) do
                    GameTooltip:AddLine(v.i .. L["、"] .. v.money .. format(L["（%s）"], v.player), 1, .82, 0)
                end
                GameTooltip:Show()
            end
        end
        local i = 1
        while _G["ChatFrame" .. i] do
            _G["ChatFrame" .. i]:HookScript("OnHyperlinkEnter", OnHyperlinkEnter)
            _G["ChatFrame" .. i]:HookScript("OnHyperlinkLeave", GameTooltip_Hide)
            i = i + 1
        end
        hooksecurefunc("SetItemRef", function(link, text, button)
            if not link then return end
            local _, arg2, arg3, itemID, num = strsplit(":", link)
            if arg2 == "BiaoGe" and arg3 == "AuctionWALog" and num then
                itemID = tonumber(itemID)
                num = tonumber(num)
                local _, link = GetItemInfo(itemID)
                if not link then return end
                ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
                ItemRefTooltip:ClearLines()
                ItemRefTooltip:AddLine(link:gsub("%[", ""):gsub("%]", ""), 1, 1, 1, true)
                if BG.chatAuctionLog[num][1] and BG.chatAuctionLog[num][1].i ~= 1 then
                    ItemRefTooltip:AddLine("......", .5, .5, .5, true)
                end
                for i, v in ipairs(BG.chatAuctionLog[num]) do
                    ItemRefTooltip:AddLine(v.i .. L["、"] .. v.money .. format(L["（%s）"], v.player), 1, .82, 0)
                end
                ItemRefTooltip:Show()
            end
        end)
    end

    -- 提示已拍未交易
    do
        hooksecurefunc(GameTooltip, "SetBagItem", function(self, b, i)
            if not BG.ImML() then return end
            local info = C_Container.GetContainerItemInfo(b, i)
            if not info then return end
            local FB = BG.FB1
            if type(BiaoGe[FB].auctionLog) ~= "table" then return end
            local notBound
            if not info.isBound then
                notBound = true
            else
                for i = 1, GameTooltip:NumLines() do
                    local tx = _G["GameTooltipTextLeft" .. i]:GetText()
                    if tx then
                        local time = tx:match(BIND_TRADE_TIME_REMAINING:gsub("%%s", "(.+)"))
                        if time then
                            notBound = true
                            break
                        end
                    end
                    i = i + 1
                end
            end
            if notBound then
                for k, v in pairs(BiaoGe[FB].auctionLog) do
                    if v.type == 1 and not v.trade and BG.IsSameItem(info.hyperlink, v.zhuangbei) then
                        local text = v.jine .. "(|c" .. select(4, GetClassColor(v.class)) .. v.maijia .. "|r)"
                        -- local text = "|c" .. select(4, GetClassColor(v.class)) .. v.maijia .. "|r(" .. v.jine .. ")"
                        GameTooltip:AddDoubleLine(L["已拍未交易"], text)
                        GameTooltip:Show()
                    end
                end
            end
        end)
    end

    -- 创建应收/应付对象
    do
        local f = CreateFrame("Frame", nil, TradeFrame)
        f:SetFrameStrata("HIGH")
        local text = f:CreateFontString()
        text:SetPoint("TOPRIGHT", TradeRecipientMoneyBg, "BOTTOMRIGHT", -5, 3)
        text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
        BG.trade.GiveMeMoneyText = text

        local f = CreateFrame("Frame", nil, TradeFrame)
        f:SetFrameStrata("HIGH")
        local text = f:CreateFontString()
        text:SetPoint("TOPLEFT", TradePlayerInputMoneyInsetBg, "BOTTOMLEFT", 5, 3)
        text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
        BG.trade.GiveYouMoneyText = text

        for i = 1, 6 do
            local text = _G["TradePlayerItem" .. i .. "ItemButton"]:CreateFontString()
            text:SetPoint("BOTTOMLEFT", _G["TradePlayerItem" .. i .. "ItemButton"], "BOTTOMRIGHT", 8, -2)
            text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            text:Hide()
            _G["TradePlayerItem" .. i .. "ItemButton"].money = text

            local text = _G["TradeRecipientItem" .. i .. "ItemButton"]:CreateFontString()
            text:SetPoint("BOTTOMLEFT", _G["TradeRecipientItem" .. i .. "ItemButton"], "BOTTOMRIGHT", 8, -2)
            text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            text:Hide()
            _G["TradeRecipientItem" .. i .. "ItemButton"].money = text
        end
    end

    -- 交易时
    do
        local sumTargetMoney = 0
        local sumPlayerMoney = 0

        local function UpdateTargetQianKuan()
            if not (BiaoGe.options["autoAuctionMoney"] == 1 and BiaoGe.options["autoAuctionQianKuan"] == 1) then return end
            local targetMoney = GetTargetTradeMoney()
            if targetMoney then
                targetMoney = math.modf(targetMoney / 10000)
                local m = sumTargetMoney - targetMoney
                if m <= 0 then
                    m = ""
                end
                BG.QianKuan.edit:ClearFocus()
                BG.QianKuan.edit:SetText(m)
            end
        end
        local function UpdateMyQianKuan()
            if not (BiaoGe.options["autoAuctionMoney"] == 1 and BiaoGe.options["autoAuctionQianKuan"] == 1) then return end
            local playerMoney = GetPlayerTradeMoney()
            if playerMoney then
                playerMoney = math.modf(playerMoney / 10000)
                local m = sumPlayerMoney - playerMoney
                if m <= 0 then
                    m = ""
                end
                BG.QianKuan.edit:ClearFocus()
                BG.QianKuan.edit:SetText(m)
            end
        end

        local function MLAcceptTrade()
            if not (BiaoGe.options["autoAuctionMoney"] == 1 and BiaoGe.options["autoAuctionSureClick"] == 1) then return end
            local targetMoney = floor(GetTargetTradeMoney() / 1e4)
            if targetMoney > 0 and targetMoney == sumTargetMoney then
                if not TradeFrame.BiaoGeUpdateFrame then
                    TradeFrame.BiaoGeUpdateFrame = CreateFrame("Frame")
                end
                TradeFrame.BiaoGeUpdateFrame.elapsed = 0
                TradeFrame.BiaoGeUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
                    if not TradeFrame:IsVisible() then
                        self:SetScript("OnUpdate", nil)
                        return
                    end
                    self.elapsed = self.elapsed + elapsed
                    if self.elapsed >= .5 then
                        self:SetScript("OnUpdate", nil)
                        local targetMoney = floor(GetTargetTradeMoney() / 1e4)
                        if targetMoney > 0 and targetMoney == sumTargetMoney then
                            UIErrorsFrame:AddMessage(L["BiaoGe正在申请确认交易"], 1, 1, 0)
                            AcceptTrade()
                        end
                    end
                end)
            end
        end
        local function PlayerAcceptTrade()
            if not (BiaoGe.options["autoAuctionMoney"] == 1 and BiaoGe.options["autoAuctionSureClick"] == 1) then return end
            local playerMoney = floor(GetPlayerTradeMoney() / 1e4)
            if playerMoney > 0 and playerMoney == sumPlayerMoney then
                if not TradeFrame.BiaoGeUpdateFrame then
                    TradeFrame.BiaoGeUpdateFrame = CreateFrame("Frame")
                end
                TradeFrame.BiaoGeUpdateFrame.elapsed = 0
                TradeFrame.BiaoGeUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
                    if not TradeFrame:IsVisible() then
                        self:SetScript("OnUpdate", nil)
                        return
                    end
                    self.elapsed = self.elapsed + elapsed
                    if self.elapsed >= .5 then
                        self:SetScript("OnUpdate", nil)
                        local playerMoney = floor(GetPlayerTradeMoney() / 1e4)
                        if playerMoney > 0 and playerMoney == sumPlayerMoney then
                            UIErrorsFrame:AddMessage(L["BiaoGe正在申请确认交易"], 1, 1, 0)
                            AcceptTrade()
                        end
                    end
                end)
            end
        end
        local function SetMyMoney()
            if not (BiaoGe.options["autoAuctionMoney"] == 1 and BiaoGe.options["autoAuctionSetMoney"] == 1) then return end
            local moneyFrame = TradePlayerInputMoneyFrame
            local money = floor(GetMoney() / 1e4)
            if money >= sumPlayerMoney then
                MoneyInputFrame_ResetMoney(moneyFrame)
                _G[moneyFrame:GetName() .. "Gold"]:SetNumber(sumPlayerMoney)
            else
                UIErrorsFrame:AddMessage(L["你的钱不够！"], 1, 0, 0)
            end
        end

        local function UpdateGiveMeMoneyTextColor()
            local targetMoney = GetTargetTradeMoney()
            if targetMoney then
                targetMoney = math.modf(targetMoney / 10000)
                if targetMoney == sumTargetMoney then
                    BG.trade.GiveMeMoneyText:SetTextColor(0, 1, 0)
                    for i = 1, 6 do
                        _G["TradePlayerItem" .. i .. "ItemButton"].money:SetTextColor(0, 1, 0)
                    end
                elseif targetMoney > sumTargetMoney then
                    BG.trade.GiveMeMoneyText:SetTextColor(1, 0, 0)
                    for i = 1, 6 do
                        _G["TradePlayerItem" .. i .. "ItemButton"].money:SetTextColor(1, 0, 0)
                    end
                else
                    BG.trade.GiveMeMoneyText:SetTextColor(1, 0, 0)
                    for i = 1, 6 do
                        _G["TradePlayerItem" .. i .. "ItemButton"].money:SetTextColor(1, 0, 0)
                    end
                end
            end
        end
        local function UpdateGiveYouMoneyTextColor()
            local playerMoney = GetPlayerTradeMoney()
            if playerMoney then
                playerMoney = math.modf(playerMoney / 10000)
                if playerMoney == sumPlayerMoney then
                    BG.trade.GiveYouMoneyText:SetTextColor(0, 1, 0)
                    for i = 1, 6 do
                        _G["TradeRecipientItem" .. i .. "ItemButton"].money:SetTextColor(0, 1, 0)
                    end
                elseif playerMoney > sumPlayerMoney then
                    BG.trade.GiveYouMoneyText:SetTextColor(1, 0, 0)
                    for i = 1, 6 do
                        _G["TradeRecipientItem" .. i .. "ItemButton"].money:SetTextColor(1, 0, 0)
                    end
                else
                    BG.trade.GiveYouMoneyText:SetTextColor(RGB(BG.b1))
                    for i = 1, 6 do
                        _G["TradeRecipientItem" .. i .. "ItemButton"].money:SetTextColor(RGB(BG.b1))
                    end
                end
            end
        end
        -- 团长自动摆放装备
        BG.RegisterEvent("TRADE_SHOW", function(self, ...)
            sumTargetMoney = 0
            sumPlayerMoney = 0
            for i = 1, 6 do
                _G["TradePlayerItem" .. i .. "ItemButton"].money:Hide()
                _G["TradeRecipientItem" .. i .. "ItemButton"].money:Hide()
            end
            BG.trade.GiveMeMoneyText:Hide()
            BG.trade.GiveYouMoneyText:Hide()
            if BiaoGe.options["autoAuctionPut"] ~= 1 then return end
            if not BG.ImML() then return end
            local tradeName = BG.GN("NPC")
            if not (BG.auctionTrade[tradeName] and next(BG.auctionTrade[tradeName])) then return end
            ClearCursor()
            local bagTbl = {}
            local tradeTbl = {}
            local function GiveItem(index)
                if not TradeFrame:IsVisible() then return end
                local v = BG.auctionTrade[tradeName][index]
                if not v then return end
                for b = 0, NUM_BAG_SLOTS do
                    for i = 1, C_Container.GetContainerNumSlots(b) do
                        if not bagTbl[b .. "-" .. i] then
                            local info = C_Container.GetContainerItemInfo(b, i)
                            if info then
                                if BG.IsSameItem(v.zhuangbei, info.hyperlink) and not info.isLocked then
                                    local notBound
                                    if not info.isBound then
                                        notBound = true
                                    else
                                        BiaoGeTooltip3:SetOwner(UIParent, "ANCHOR_NONE", 0, 0)
                                        BiaoGeTooltip3:ClearLines()
                                        BiaoGeTooltip3:SetBagItem(b, i)
                                        local ii = 1
                                        while _G["BiaoGeTooltip3TextLeft" .. ii] do
                                            local tx = _G["BiaoGeTooltip3TextLeft" .. ii]:GetText()
                                            if tx then
                                                local time = tx:match(BIND_TRADE_TIME_REMAINING:gsub("%%s", "(.+)"))
                                                if time then
                                                    notBound = true
                                                    break
                                                end
                                            end
                                            ii = ii + 1
                                        end
                                    end
                                    if notBound then
                                        for ii = 1, 6 do
                                            if not tradeTbl[ii] then
                                                if not GetTradePlayerItemLink(ii) then
                                                    C_Container.PickupContainerItem(b, i)
                                                    _G["TradePlayerItem" .. ii .. "ItemButton"]:Click()
                                                    ClearCursor()
                                                    bagTbl[b .. "-" .. i] = true
                                                    tradeTbl[ii] = true
                                                    BG.After(0.02, function()
                                                        GiveItem(index + 1)
                                                    end)
                                                    return
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                GiveItem(index + 1)
            end
            GiveItem(1)
        end)
        -- 团长
        BG.RegisterEvent("TRADE_PLAYER_ITEM_CHANGED", function(self, ...)
            sumTargetMoney = 0
            for i = 1, 6 do
                _G["TradePlayerItem" .. i .. "ItemButton"].money:Hide()
            end
            if not BG.ImML() then return end
            local tradeName = BG.GN("NPC")
            if not (BG.auctionTrade[tradeName] and next(BG.auctionTrade[tradeName])) then return end
            local haveItem = {}
            for _, v in ipairs(BG.auctionTrade[tradeName]) do
                local money = tonumber(v.jine) or 0
                for i = 1, 6 do
                    if not haveItem[i] then
                        local link = GetTradePlayerItemLink(i)
                        if link then
                            if GetItemID(v.zhuangbei) == GetItemID(link) then
                                haveItem[i] = true
                                sumTargetMoney = sumTargetMoney + money
                                if BiaoGe.options["autoAuctionMoney"] == 1 then
                                    _G["TradePlayerItem" .. i .. "ItemButton"].money:Show()
                                    _G["TradePlayerItem" .. i .. "ItemButton"].money:SetText(L["应收："] .. GetMoneyString(tonumber(money .. "0000")))
                                end
                                break
                            end
                        end
                    end
                end
            end
            if BiaoGe.options["autoAuctionMoney"] == 1 then
                if sumTargetMoney ~= 0 then
                    BG.trade.GiveMeMoneyText:Show()
                    BG.trade.GiveMeMoneyText:SetText(L["合计应收："] .. GetMoneyString(tonumber(sumTargetMoney .. "0000")))
                    UpdateGiveMeMoneyTextColor()
                else
                    BG.trade.GiveMeMoneyText:Hide()
                end
            end
            UpdateTargetQianKuan()
        end)
        -- 团员
        BG.RegisterEvent("TRADE_TARGET_ITEM_CHANGED", function(self, ...)
            sumPlayerMoney = 0
            for i = 1, 6 do
                _G["TradeRecipientItem" .. i .. "ItemButton"].money:Hide()
            end
            if BG.ImML() then return end
            local tradeName = player
            if not (BG.auctionTrade[tradeName] and next(BG.auctionTrade[tradeName])) then return end
            local haveItem = {}
            for _, v in ipairs(BG.auctionTrade[tradeName]) do
                local money = tonumber(v.jine) or 0
                for i = 1, 6 do
                    if not haveItem[i] then
                        local link = GetTradeTargetItemLink(i)
                        if link then
                            if GetItemID(v.zhuangbei) == GetItemID(link) then
                                haveItem[i] = true
                                sumPlayerMoney = sumPlayerMoney + money
                                if BiaoGe.options["autoAuctionMoney"] == 1 then
                                    _G["TradeRecipientItem" .. i .. "ItemButton"].money:Show()
                                    _G["TradeRecipientItem" .. i .. "ItemButton"].money:SetText(L["应付："] .. GetMoneyString(tonumber(money .. "0000")))
                                end
                                break
                            end
                        end
                    end
                end
            end
            if BiaoGe.options["autoAuctionMoney"] == 1 then
                if sumPlayerMoney ~= 0 then
                    BG.trade.GiveYouMoneyText:Show()
                    BG.trade.GiveYouMoneyText:SetText(L["合计应付："] .. GetMoneyString(tonumber(sumPlayerMoney .. "0000")))
                    UpdateGiveYouMoneyTextColor()
                else
                    BG.trade.GiveYouMoneyText:Hide()
                end
            end
            UpdateMyQianKuan()
            SetMyMoney()
        end)
        BG.RegisterEvent("TRADE_MONEY_CHANGED", function(self, ...)
            if not BG.ImML() then return end
            if BG.trade.GiveMeMoneyText:IsVisible() then
                UpdateGiveMeMoneyTextColor()
            end
            UpdateTargetQianKuan()
            MLAcceptTrade()
        end)
        TradePlayerInputMoneyFrameGold:HookScript("OnTextChanged", function()
            if BG.ImML() then return end
            if BG.trade.GiveYouMoneyText:IsVisible() then
                UpdateGiveYouMoneyTextColor()
            end
            UpdateMyQianKuan()
            PlayerAcceptTrade()
        end)

        -- 交易成功后，把拍卖记录设为已交易
        BG.RegisterEvent("UI_INFO_MESSAGE", function(self, event, _, text)
            if text ~= ERR_TRADE_COMPLETE then return end
            local FB = BG.FB1
            if not BiaoGe[FB].auctionLog then return end
            local tradeName, tradeTbl
            if BG.ImML() then
                tradeName = BG.trade.target
                tradeTbl = BG.trade.playeritems
            else
                tradeName = BG.trade.player
                tradeTbl = BG.trade.targetitems
            end
            for _, vv in ipairs(tradeTbl) do
                for _, v in ipairs(BiaoGe[FB].auctionLog) do
                    if v.type == 1 and not v.trade and v.maijia == tradeName and
                        GetItemID(v.zhuangbei) == GetItemID(vv.link) then
                        v.trade = true
                        break
                    end
                end
            end
            BG.UpdateAuctionLogFrame(true, true)
        end)
    end
end)

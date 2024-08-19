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
local FrameDongHua = ns.FrameDongHua
local FrameHide = ns.FrameHide
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local Maxb = ns.Maxb
local Maxi = ns.Maxi

local pt = print
local RealmId = GetRealmID()
local player = UnitName("player")

BG.RegisterEvent("ADDON_LOADED", function(self, event, addonName)
    if addonName ~= AddonName then return end

    BiaoGe.options.showAuctionLogFrame = BiaoGe.options.showAuctionLogFrame or 0
    BiaoGe.options.auctionLogChoose = BiaoGe.options.auctionLogChoose or 1
    BiaoGe.AuctionLog = BiaoGe.AuctionLog or {}

    local bt = CreateFrame("Button", nil, BG.MainFrame)
    do
        bt:SetPoint("LEFT", BG.ButtonAucitonWA, "RIGHT", BG.TopLeftButtonJianGe, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(AddTexture("QUEST") .. L["拍卖记录"])
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

    local f = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
    do
        do
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 2,
            })
            f:SetBackdropColor(0, 0, 0, 0.8)
            f:SetBackdropBorderColor(0, 0, 0, 1)
            f:SetSize(220, 700)
            f:SetPoint("TOPRIGHT", BG.MainFrame, "TOPLEFT", 0, 0)
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
            f.CloseButton:SetPoint("TOPLEFT", -4, 4)
            f.CloseButton:HookScript("OnClick", function(self)
                BiaoGe.options.showAuctionLogFrame = 0
            end)

            local t = f:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
                    GameTooltip:AddLine(L["右键记录打开菜单：修改记录、删除记录。"], 1, 0.82, 0, true)
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
            }
            local buttonGroup = CreateFrame("Frame", nil, f)
            buttonGroup:SetPoint("TOPLEFT", 10, -40)
            buttonGroup:SetSize(1, 1)
            for i = 1, #numOptions do
                local bt = CreateFrame("CheckButton", nil, buttonGroup, "UIRadioButtonTemplate")
                bt:SetPoint("LEFT", ((i - 1) * 60), 0)
                bt:SetSize(15, 15)
                if i == BiaoGe.options.auctionLogChoose then
                    bt:SetChecked(true)
                end
                tinsert(buttons, bt)
                bt.Text = bt:CreateFontString()
                bt.Text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                bt.Text:SetPoint("LEFT", bt, "RIGHT", 0, 0)
                bt.Text:SetText(numOptions[i].name)
                bt.Text:SetTextColor(1, .82, 0)
                bt:SetHitRectInsets(0, -bt.Text:GetWidth(), -5, -5)

                bt:SetScript("OnClick", function(self)
                    BG.PlaySound(1)
                    for _, radioButton in ipairs(buttons) do
                        if radioButton ~= self then
                            radioButton:SetChecked(false)
                        end
                    end
                    self:SetChecked(true)
                    BiaoGe.options.auctionLogChoose = i
                    BG.auctionLogFrame.changeFrame:Hide()
                    BG.UpdateAuctionLogFrame()
                end)
            end
        end

        do
            local t = f:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("BOTTOMLEFT", 6, 40)
            t:SetTextColor(1, 1, 1)
            t:SetJustifyH("LEFT")
            t:SetWordWrap(false)
            BG.auctionLogFrame.sumText = t
        end

        -- 生成账单按钮
        do
            local bt = CreateFrame("Button", nil, BG.auctionLogFrame, "UIPanelButtonTemplate")
            bt:SetSize(100, 25)
            bt:SetPoint("BOTTOMLEFT", BG.auctionLogFrame, 5, 5)
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
                    for i = 1, Maxi[FB] do
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

                for _, v in ipairs(BiaoGe[FB].auctionLog) do
                    if v.type == 1 then
                        local itemID = GetItemID(v.zhuangbei)
                        for b = 1, Maxb[FB] - 1 do
                            local yes
                            for i = 1, Maxi[FB] do
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

            local bt = CreateFrame("Button", nil, BG.auctionLogFrame, "UIPanelButtonTemplate")
            bt:SetSize(85, 25)
            bt:SetPoint("BOTTOMRIGHT", BG.auctionLogFrame, -5, 5)
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
                duizhang.t = time()
                duizhang.time = date("%H:%M:%S")
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

    local frame, child = BG.CreateScrollFrame(BG.auctionLogFrame,
        BG.auctionLogFrame:GetWidth() - 10,
        BG.auctionLogFrame:GetHeight() - 115)
    do
        frame:SetBackdrop({
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        frame:SetBackdropBorderColor(.5, .5, .5, .5)
        frame:SetPoint("TOP", 0, -55)

        local _f = CreateFrame("Frame", nil, frame)
        _f:SetSize(1, 1)
        _f:SetPoint("TOPRIGHT", 0, 1)
        frame.tooltip = _f

        local t = child:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("TOP", 0, 0)
        t:SetTextColor(1, 0, 0)
        t:SetText(L["没有自动拍卖记录。"])
        t:Hide()
        BG.auctionLogFrame.notText = t
    end

    local dropDown = LibBG:Create_UIDropDownMenu(nil, f)
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
                self.maijia:SetText("")
                self.jine:SetText("")
            end)

            local t = f:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            t:SetPoint("TOP", 0, -10)
            t:SetText(L["修改记录"])
        end
        -- 装备
        do
            local title = f:CreateFontString()
            title:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            title:SetPoint("TOPLEFT", 5, -35)
            title:SetText(L["装备："])
            title:SetTextColor(1, 0.82, 0)
            title:SetWidth(60)
            title:SetJustifyH("RIGHT")
            title:SetWordWrap(false)
            local _f = CreateFrame("Frame", nil, BG.auctionLogFrame.changeFrame, "BackdropTemplate")
            _f:SetPoint("LEFT", title, "RIGHT", 10, 0)
            _f:SetSize(120, 15)
            _f:SetHyperlinksEnabled(true)

            local t = _f:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            t:SetAllPoints()
            t:SetJustifyH("LEFT")
            t:SetWordWrap(false)
            f.item = t
            t.title = title

            _f:SetScript("OnHyperlinkEnter", function(self, link, text, button)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -self:GetWidth() + t:GetWrappedWidth(), 0)
                GameTooltip:ClearLines()
                local itemID = GetItemInfoInstant(link)
                if itemID then
                    GameTooltip:SetItemByID(itemID)
                    GameTooltip:Show()
                end
            end)
            _f:SetScript("OnHyperlinkLeave", GameTooltip_Hide)
        end
        -- 买家
        do
            local t = f:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
            end)
            edit:SetScript("OnEditFocusGained", function(self)
                self:HighlightText()
                BG.lastfocus = self
                BG.SetListmaijia(self, true, nil, true)
            end)
            edit:SetScript("OnEditFocusLost", function(self)
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
            t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
                if self:GetText() == "" then
                    BG.auctionLogFrame.changeFrame.info.jine = nil
                else
                    BG.auctionLogFrame.changeFrame.info.jine = self:GetText()
                end
            end)
            edit:SetScript("OnEditFocusGained", function(self)
                self:HighlightText()
                BG.lastfocus = self
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
            local bt = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
            bt:SetSize(95, 25)
            bt:SetPoint("BOTTOMLEFT", 10, 10)
            bt:SetText(L["确定"])
            f.ButtonSure = bt
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                local FB = BG.FB1
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
                BG.UpdateAuctionLogFrame()
                f:Hide()
            end)

            local bt = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
            bt:SetSize(95, 25)
            bt:SetPoint("BOTTOMRIGHT", -10, 10)
            bt:SetText(L["取消"])
            bt:SetScript("OnClick", function(self)
                f:Hide()
            end)
        end
    end

    local buttons = {}

    local function CreateButton(i, v, isHistory)
        local FB = BG.FB1
        local bts = {}
        local width = child:GetWidth()
        local link = v.zhuangbei
        local icon = select(5, GetItemInfoInstant(link))
        local r, g, b = GetItemQualityColor(v.quality)

        -- 主框架
        do
            local f = CreateFrame("Frame", nil, child, "BackdropTemplate")
            f:SetSize(width, 32)
            if #buttons == 0 then
                f:SetPoint("TOPLEFT")
            else
                f:SetPoint("TOPLEFT", buttons[#buttons].frame, "BOTTOMLEFT", 0, 0)
            end
            f:Show()
            bts.frame = f
            f:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(frame.tooltip, "ANCHOR_BOTTOMRIGHT", 0, 0)
                GameTooltip:ClearLines()
                local itemID = GetItemInfoInstant(link)
                if itemID then
                    GameTooltip:SetItemByID(itemID)
                    GameTooltip:Show()
                    BG.HighlightBiaoGe(link)
                    BG.HighlightBag(link)
                    BG.HighlightChatFrame(link)
                end
                bts.ds:Show()
            end)
            f:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                BG.Hide_AllHighlight()
                bts.ds:Hide()
            end)
            f:SetScript("OnMouseDown", function(self, button)
                if button == "RightButton" and not isHistory then
                    BG.PlaySound(3)
                    local menu = {
                        {
                            isTitle = true,
                            text = link:gsub("%[", ""):gsub("%]", ""),
                            notCheckable = true,
                        },
                        {
                            text = L["修改记录"],
                            notCheckable = true,
                            func = function()
                                BG.auctionLogFrame.changeFrame.info = {}
                                BG.auctionLogFrame.changeFrame.info.num = i
                                for k in pairs(BG.playerClass) do
                                    BG.auctionLogFrame.changeFrame.info[k] = v[k]
                                end
                                BG.auctionLogFrame.changeFrame:Show()
                                BG.auctionLogFrame.changeFrame:ClearAllPoints()
                                BG.auctionLogFrame.changeFrame:SetPoint("TOPLEFT", f, "BOTTOMLEFT", -10, 0)
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
                                BG.UpdateAuctionLogFrame(true)
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
                    LibBG:EasyMenu(menu, dropDown, "cursor", 10, 10, "MENU", 2)
                elseif IsShiftKeyDown() then
                    BG.PlaySound(1)
                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                    ChatEdit_InsertLink(link)
                end
            end)
            local tex = bts.frame:CreateTexture()
            tex:SetAllPoints()
            tex:SetColorTexture(.5, .5, .5, .3)
            tex:Hide()
            bts.ds = tex
        end
        -- 图标
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
            f.level:SetFont(BIAOGE_TEXT_FONT, 11, "OUTLINE")
            f.level:SetPoint("BOTTOM", bts.icon, 0, 1)
            f.level:SetText(v.itemlevel)
            f.level:SetTextColor(r, g, b)
            if v.bindType == 2 then
                local text = bts.iconFrame:CreateFontString()
                text:SetFont(BIAOGE_TEXT_FONT, 10, "OUTLINE")
                text:SetPoint("TOP", bts.iconFrame, 0, -1)
                text:SetText(L["装绑"])
                text:SetTextColor(0, 1, 0)
            end
        end
        -- 装备
        do
            local text = bts.frame:CreateFontString()
            text:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
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
            text:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
            text:SetPoint("BOTTOMLEFT", bts.icon, "BOTTOMRIGHT", 1, 0)
            text:SetWidth(width - bts.icon:GetWidth())
            if v.type == 1 then
                text:SetText(v.jine .. "|c" .. select(4, GetClassColor(v.class)) .. " " .. v.maijia .. "" .. RR)
            else
                text:SetText(L["<流拍>"])
                text:SetTextColor(1, 0, 0)
            end
            text:SetJustifyH("LEFT")
            text:SetWordWrap(false)
            bts.money = text
        end
        tinsert(buttons, bts)
    end

    function BG.UpdateAuctionLogFrame(notSetDown)
        if not BG.auctionLogFrame:IsVisible() then return end
        for i, v in ipairs(buttons) do
            v.frame:Hide()
        end
        wipe(buttons)

        local FB = BG.FB1
        local sum = 0
        local tbl
        local isHistory
        if BG.History.chooseNum then
            isHistory = true
        end
        if isHistory then
            local DT = BiaoGe.HistoryList[FB][BG.History.chooseNum][1]
            tbl = BiaoGe.History[FB][DT].auctionLog
        elseif BG.HistoryMainFrame:IsVisible() then
            tbl = nil
            isHistory = true
        else
            tbl = BiaoGe[FB].auctionLog
        end
        if not tbl or #tbl == 0 then
            BG.auctionLogFrame.ButtonCreateLedger:Disable()
            BG.auctionLogFrame.ButtonCreateDuiZhang:Disable()
            BG.auctionLogFrame.notText:Show()
        else
            BG.auctionLogFrame.ButtonCreateLedger:Enable()
            BG.auctionLogFrame.ButtonCreateDuiZhang:Enable()
            BG.auctionLogFrame.notText:Hide()
        end
        if isHistory then
            BG.auctionLogFrame.ButtonCreateLedger:Disable()
            BG.auctionLogFrame.ButtonCreateDuiZhang:Disable()
            BG.auctionLogFrame.title:SetText(L["历史自动拍卖记录"])
            BG.auctionLogFrame.title:SetTextColor(RGB(BG.b1))
        else
            BG.auctionLogFrame.title:SetText(L["自动拍卖记录"])
            BG.auctionLogFrame.title:SetTextColor(1, 1, 1)
        end

        if tbl then
            for i, v in ipairs(tbl) do
                if BiaoGe.options.auctionLogChoose == 1 or
                    (v.type == 1 and BiaoGe.options.auctionLogChoose == 2)
                    or (v.type == 2 and BiaoGe.options.auctionLogChoose == 3)
                then
                    CreateButton(i, v, isHistory)
                end
                sum = sum + (tonumber(v.jine) or 0)
            end
        end

        BG.auctionLogFrame.sumText:SetText(L["合计收入："] .. sum)

        if not (BG.auctionLogFrame.changeFrame:IsVisible() or notSetDown) then
            BG.After(0, function()
                local min, max = frame.scroll.ScrollBar:GetMinMaxValues()
                frame.scroll.ScrollBar:SetValue(max)
            end)
        end
    end

    local function CheckItemToFB(item)
        for _, FB in ipairs(BG.GetAllFB()) do
            for b = 1, Maxb[FB] do
                for i = 1, BG.Maxi do
                    local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                    if zhuangbei and GetItemID(zhuangbei:GetText()) == GetItemID(item) then
                        return FB
                    end
                end
            end
        end
    end
    BG.RegisterEvent("CHAT_MSG_RAID_LEADER", function(self, even, ...)
        local msg, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid = ...
        local zhuangbei, maijia, jine
        zhuangbei, maijia, jine = msg:match("{rt6}拍卖成功{rt6} (.-) (.-) (.+)")
        if not (zhuangbei and maijia and jine) then
            zhuangbei, maijia, jine = msg:match("{rt6}拍賣成功{rt6} (.-) (.-) (.+)")
        end
        if (zhuangbei and maijia and jine) then
            local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID, bindType = GetItemInfo(zhuangbei)
            local FB = BG.FB2
            if not FB then
                FB = CheckItemToFB(zhuangbei) or BG.FB1
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
                time = time(),
                zhuangbei = zhuangbei,
                maijia = maijia,
                jine = jine,
                itemlevel = level,
                quality = quality,
                bindType = bindType,
            }
            for k, v in pairs(playerClass) do
                a[k] = v
            end
            BiaoGe[FB].auctionLog = BiaoGe[FB].auctionLog or {}
            tinsert(BiaoGe[FB].auctionLog, a)
            BG.UpdateAuctionLogFrame()

            BiaoGe.AuctionLog[maijia] = BiaoGe.AuctionLog[maijia] or {}
            tinsert(BiaoGe.AuctionLog[maijia], {
                time = time(),
                item = zhuangbei,
                itemID = GetItemID(zhuangbei),
                money = tonumber(jine),
            })
            return
        end

        zhuangbei = msg:match("{rt7}流拍{rt7} (.+)")
        if zhuangbei then
            local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID, bindType = GetItemInfo(zhuangbei)
            local FB = BG.FB2
            if not FB then
                FB = CheckItemToFB(zhuangbei) or BG.FB1
            end

            local a = {
                type = 2,
                time = time(),
                zhuangbei = zhuangbei,
                itemlevel = level,
                quality = quality,
                bindType = bindType,
            }
            BiaoGe[FB].auctionLog = BiaoGe[FB].auctionLog or {}
            tinsert(BiaoGe[FB].auctionLog, a)
            BG.UpdateAuctionLogFrame()
            return
        end
    end)

    -- 自动清理超过半小时的记录
    C_Timer.NewTicker(60, function()
        if TradeFrame:IsVisible() then return end
        local time = time()
        for maijia, v in pairs(BiaoGe.AuctionLog) do
            for i = #v, 1, -1 do
                if time - v[i].time >= 1800 then
                    tremove(v, i)
                end
            end
            if #v == 0 then
                BiaoGe.AuctionLog[maijia] = nil
            end
        end
    end)

    -- 应收/应付
    do
        local f = CreateFrame("Frame", nil, TradeFrame)
        f:SetFrameStrata("HIGH")
        local text = f:CreateFontString()
        text:SetPoint("TOPRIGHT", TradeRecipientMoneyBg, "BOTTOMRIGHT", -5, 3)
        text:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
        BG.trade.GiveMeMoneyText = text

        local f = CreateFrame("Frame", nil, TradeFrame)
        f:SetFrameStrata("HIGH")
        local text = f:CreateFontString()
        text:SetPoint("TOPLEFT", TradePlayerInputMoneyInsetBg, "BOTTOMLEFT", 5, 3)
        text:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
        BG.trade.GiveYouMoneyText = text

        for i = 1, 6 do
            local text = _G["TradePlayerItem" .. i .. "ItemButton"]:CreateFontString()
            text:SetPoint("BOTTOMLEFT", _G["TradePlayerItem" .. i .. "ItemButton"], "BOTTOMRIGHT", 8, -2)
            text:SetFont(BIAOGE_TEXT_FONT, 12, "OUTLINE")
            text:Hide()
            _G["TradePlayerItem" .. i .. "ItemButton"].money = text

            local text = _G["TradeRecipientItem" .. i .. "ItemButton"]:CreateFontString()
            text:SetPoint("BOTTOMLEFT", _G["TradeRecipientItem" .. i .. "ItemButton"], "BOTTOMRIGHT", 8, -2)
            text:SetFont(BIAOGE_TEXT_FONT, 12, "OUTLINE")
            text:Hide()
            _G["TradeRecipientItem" .. i .. "ItemButton"].money = text
        end
    end

    -- 交易时
    do
        local sumTargetMoney = 0
        local sumPlayerMoney = 0
        local lastTradeItemNum = {}

        local function UpdateGiveMeMoneyTextColor()
            local targetMoney = GetTargetTradeMoney()
            if targetMoney then
                targetMoney = math.modf(targetMoney / 10000)
                if targetMoney >= sumTargetMoney then
                    BG.trade.GiveMeMoneyText:SetTextColor(0, 1, 0)
                    for i = 1, 6 do
                        _G["TradePlayerItem" .. i .. "ItemButton"].money:SetTextColor(0, 1, 0)
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
                if playerMoney >= sumPlayerMoney then
                    BG.trade.GiveYouMoneyText:SetTextColor(0, 1, 0)
                    for i = 1, 6 do
                        _G["TradeRecipientItem" .. i .. "ItemButton"].money:SetTextColor(0, 1, 0)
                    end
                else
                    BG.trade.GiveYouMoneyText:SetTextColor(RGB(BG.b1))
                    for i = 1, 6 do
                        _G["TradeRecipientItem" .. i .. "ItemButton"].money:SetTextColor(RGB(BG.b1))
                    end
                end
            end
        end
        BG.RegisterEvent("TRADE_SHOW", function(self, ...)
            wipe(lastTradeItemNum)
            sumTargetMoney = 0
            sumPlayerMoney = 0
            for i = 1, 6 do
                _G["TradePlayerItem" .. i .. "ItemButton"].money:Hide()
                _G["TradeRecipientItem" .. i .. "ItemButton"].money:Hide()
            end
            BG.trade.GiveMeMoneyText:Hide()
            BG.trade.GiveYouMoneyText:Hide()
            if not BG.ImML() then return end
            if not BiaoGe.AuctionLog[UnitName("NPC")] then return end
            for _, v in ipairs(BiaoGe.AuctionLog[UnitName("NPC")]) do
                local yes
                for b = 0, NUM_BAG_SLOTS do
                    for i = 1, C_Container.GetContainerNumSlots(b) do
                        local info = C_Container.GetContainerItemInfo(b, i)
                        if info then
                            local itemID = info.itemID
                            if v.itemID == itemID then
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
                                if notBound and not info.isLocked then
                                    ClearCursor()
                                    for ii = 1, 6 do
                                        if not GetTradePlayerItemLink(ii) then
                                            C_Container.PickupContainerItem(b, i)
                                            _G["TradePlayerItem" .. ii .. "ItemButton"]:Click()
                                            ClearCursor()
                                            yes = true
                                            break
                                        end
                                    end
                                end
                            end
                        end
                        if yes then break end
                    end
                    if yes then break end
                end
            end
        end)
        BG.RegisterEvent("TRADE_PLAYER_ITEM_CHANGED", function(self, ...)
            sumTargetMoney = 0
            for i = 1, 6 do
                _G["TradePlayerItem" .. i .. "ItemButton"].money:Hide()
            end
            if not BG.ImML() then return end
            if not BiaoGe.AuctionLog[UnitName("NPC")] then return end
            local have = {}
            for num, v in ipairs(BiaoGe.AuctionLog[UnitName("NPC")]) do
                for i = 1, 6 do
                    if not have[i] then
                        local link = GetTradePlayerItemLink(i)
                        if link then
                            local itemID = GetItemID(link)
                            if v.itemID == itemID then
                                lastTradeItemNum.player = UnitName("NPC")
                                tinsert(lastTradeItemNum, num)
                                have[i] = true
                                sumTargetMoney = sumTargetMoney + v.money
                                _G["TradePlayerItem" .. i .. "ItemButton"].money:Show()
                                _G["TradePlayerItem" .. i .. "ItemButton"].money:SetText(L["应收："] .. GetMoneyString(tonumber(v.money .. "0000")))
                                break
                            end
                        end
                    end
                end
            end
            if sumTargetMoney ~= 0 then
                BG.trade.GiveMeMoneyText:Show()
                BG.trade.GiveMeMoneyText:SetText(L["合计应收："] .. GetMoneyString(tonumber(sumTargetMoney .. "0000")))
                UpdateGiveMeMoneyTextColor()
            else
                BG.trade.GiveMeMoneyText:Hide()
            end
        end)
        BG.RegisterEvent("TRADE_TARGET_ITEM_CHANGED", function(self, ...)
            sumPlayerMoney = 0
            for i = 1, 6 do
                _G["TradeRecipientItem" .. i .. "ItemButton"].money:Hide()
            end
            if BG.ImML() then return end
            if not BiaoGe.AuctionLog[UnitName("player")] then return end
            local have = {}
            for num, v in ipairs(BiaoGe.AuctionLog[UnitName("player")]) do
                for i = 1, 6 do
                    if not have[i] then
                        local link = GetTradeTargetItemLink(i)
                        if link then
                            local itemID = GetItemID(link)
                            if v.itemID == itemID then
                                lastTradeItemNum.player = UnitName("player")
                                tinsert(lastTradeItemNum, num)
                                have[i] = true
                                sumPlayerMoney = sumPlayerMoney + v.money
                                _G["TradeRecipientItem" .. i .. "ItemButton"].money:Show()
                                _G["TradeRecipientItem" .. i .. "ItemButton"].money:SetText(L["应付："] .. GetMoneyString(tonumber(v.money .. "0000")))
                                break
                            end
                        end
                    end
                end
            end
            if sumPlayerMoney ~= 0 then
                BG.trade.GiveYouMoneyText:Show()
                BG.trade.GiveYouMoneyText:SetText(L["合计应付："] .. GetMoneyString(tonumber(sumPlayerMoney .. "0000")))
                UpdateGiveYouMoneyTextColor()
            else
                BG.trade.GiveYouMoneyText:Hide()
            end
        end)
        BG.RegisterEvent("TRADE_MONEY_CHANGED", function(self, ...)
            if not BG.ImML() then return end
            if BG.trade.GiveMeMoneyText:IsVisible() then
                UpdateGiveMeMoneyTextColor()
            end
        end)
        TradePlayerInputMoneyFrameGold:HookScript("OnTextChanged", function()
            if BG.ImML() then return end
            if BG.trade.GiveYouMoneyText:IsVisible() then
                UpdateGiveYouMoneyTextColor()
            end
        end)
        BG.RegisterEvent("TRADE_CLOSED", function(self, ...)
            local player = lastTradeItemNum.player
            if not (player and BiaoGe.AuctionLog[player]) then return end
            for i = #BiaoGe.AuctionLog[player], 1, -1 do
                for ii = #lastTradeItemNum, 1, -1 do
                    if i == lastTradeItemNum[ii] then
                        tremove(BiaoGe.AuctionLog[player], i)
                        tremove(lastTradeItemNum, ii)
                    end
                end
            end
        end)
    end
end)

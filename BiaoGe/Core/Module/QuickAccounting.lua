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
local realmID = GetRealmID()
local player = BG.playerName
local realmName = GetRealmName()

BG.Init(function()
    -- 创建买家
    local function CreateMaijiaFrame(parent)
        local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
        f:SetWidth(395)
        f:SetHeight(230)
        f:SetPoint("TOP", parent, "TOP", 0, -55)
        f:EnableMouse(true)
        parent.maijiaFrame = f
        parent.buttons = {}
        local framedown
        local frameright = f
        local raid = BG.SortRaidRosterInfo()
        for t = 1, 4 do
            for i = 1, 10 do
                local bt = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
                bt:SetSize(90, 20)
                bt:SetAutoFocus(false)
                bt:SetEnabled(false)
                if t >= 2 and i == 1 then
                    bt:SetPoint("TOPLEFT", frameright, "TOPLEFT", 97, 0)
                    frameright = bt
                end
                if t == 1 and i == 1 then
                    bt:SetPoint("TOPLEFT", frameright, "TOPLEFT", 10, -5)
                    frameright = bt
                end
                if i > 1 then
                    bt:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -2)
                end
                if not IsInRaid(1) and t == 1 and i == 1 then -- 单人时
                    bt:SetText(BG.GN())
                    bt:SetCursorPosition(0)
                    bt:SetTextColor(GetClassRGB(BG.GN()))
                    bt.hasName = true
                    for k, v in pairs(BG.playerClass) do
                        bt[k] = select(v.select, v.func("player"))
                    end
                end
                local num = (t - 1) * 10 + i
                if raid[num] and raid[num].name then
                    if raid[num].role then
                        bt:SetText(AddTexture(raid[num].role) .. raid[num].name)
                    elseif raid[num].combatRole == "HEALER" then
                        bt:SetText(AddTexture(raid[num].combatRole) .. raid[num].name)
                    else
                        bt:SetText(raid[num].name)
                    end
                    bt:SetCursorPosition(0)
                    bt:SetTextColor(GetClassRGB(GetText_T(raid[num].name)))
                    bt.hasName = true
                else
                    bt:EnableMouse(false)
                end
                framedown = bt

                if bt.hasName then
                    tinsert(parent.buttons, bt)

                    bt.ds = bt:CreateTexture()
                    bt.ds:SetPoint("TOPLEFT", -3, -2)
                    bt.ds:SetPoint("BOTTOMRIGHT", -1, 2)
                    bt.ds:SetColorTexture(1, 1, 1, BG.onEnterAlpha)
                    bt.ds:Hide()

                    bt.choose = bt:CreateTexture()
                    bt.choose:SetPoint("TOPLEFT", -3, -2)
                    bt.choose:SetPoint("BOTTOMRIGHT", -1, 2)
                    bt.choose:SetColorTexture(0, 1, 0, 0.2)
                    bt.choose:Hide()

                    bt:SetScript("OnMouseDown", function(self, enter)
                        for i, _bt in ipairs(parent.buttons) do
                            _bt.Left:SetVertexColor(1, 1, 1)
                            _bt.Right:SetVertexColor(1, 1, 1)
                            _bt.Middle:SetVertexColor(1, 1, 1)
                            _bt.choose:Hide()
                        end
                        if parent.maijia == GetText_T(self) then
                            parent.maijia = nil
                            for k, v in pairs(BG.playerClass) do
                                parent[k] = nil
                            end
                        else
                            parent.maijia = GetText_T(self)
                            if raid[num] or self.class then
                                for k, v in pairs(BG.playerClass) do
                                    parent[k] = raid[num] and raid[num][k] or self[k]
                                end
                            end
                            self.Left:SetVertexColor(0, 1, 0)
                            self.Right:SetVertexColor(0, 1, 0)
                            self.Middle:SetVertexColor(0, 1, 0)
                            self.choose:Show()
                        end
                        BG.ChatAccountingFrame:SureButtonUpdate()
                        BG.PlaySound(1)
                    end)
                    bt:SetScript("OnEnter", function(self)
                        self.ds:Show()
                    end)
                    bt:SetScript("OnLeave", function(self)
                        GameTooltip:Hide()
                        self.ds:Hide()
                    end)
                end
            end
        end
    end
    -- 找到合适的格子
    local function HasEmptyGeZi(link)
        local FB = BG.FB1
        for b = 1, Maxb[FB] do
            for i = 1, BG.GetMaxi(FB, b) do
                local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]

                if zhuangbei and GetItemID(zhuangbei:GetText()) == GetItemID(link) and
                    maijia:GetText() == "" and jine:GetText() == "" and
                    not BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
                    return b, i, zhuangbei, maijia, jine, FB
                end
            end
        end
    end
    -- 记账失败
    local frames = {}
    local updateFrame = CreateFrame("Frame")
    updateFrame.time = 0
    local function JiZhangError(link)
        BG.FrameLootMsg:AddMessage(L["表格里没找到此次交易的装备，或者该装备已记过账"], RED_FONT_COLOR:GetRGB())
        if BG.ChatAccountingFrame:IsVisible() then
            BG.ChatAccountingFrame:Hide()
        end

        for i, textrue in ipairs(frames) do
            textrue:Hide()
        end
        wipe(frames)

        updateFrame.time = 0
        local FB = BG.FB1
        for b = 1, Maxb[FB] do
            for i = 1, BG.GetMaxi(FB, b) do
                local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]

                if zhuangbei and GetItemID(zhuangbei:GetText()) == GetItemID(link) then
                    if not zhuangbei.JiZhangErrorTextrue then
                        local textrue = zhuangbei:CreateTexture()
                        textrue:SetPoint("TOPLEFT", zhuangbei, "TOPLEFT", -4, -2)
                        textrue:SetPoint("BOTTOMRIGHT", jine, "BOTTOMRIGHT", -2, 0)
                        textrue:SetColorTexture(1, 0, 0, 0.3)
                        zhuangbei.JiZhangErrorTextrue = textrue
                    end
                    zhuangbei.JiZhangErrorTextrue:Show()
                    zhuangbei.JiZhangErrorTextrue:SetAlpha(1)
                    tinsert(frames, zhuangbei.JiZhangErrorTextrue)
                end
            end
        end
        if #frames ~= 0 then
            updateFrame:SetScript("OnUpdate", function(self, elapsed)
                updateFrame.time = updateFrame.time + elapsed
                if updateFrame.time >= 3 and updateFrame.time < 5 then
                    for i, textrue in ipairs(frames) do
                        textrue:SetAlpha((5 - updateFrame.time) / 2)
                    end
                elseif updateFrame.time >= 5 then
                    for i, textrue in ipairs(frames) do
                        textrue:Hide()
                    end
                    updateFrame.time = 0
                    updateFrame:SetScript("OnUpdate", nil)
                end
            end)
        end
    end
    -- 记账效果预览
    local function UpdateSeeText()
        if not BG.ChatAccountingFrame.itemLink then return end
        if BG.ChatAccountingFrame.maijia or BG.ChatAccountingFrame.jine ~= "" then
            local b, i, zhuangbei, maijia, jine, FB = HasEmptyGeZi(BG.ChatAccountingFrame.itemLink)
            local Texture = select(10, GetItemInfo(BG.ChatAccountingFrame.itemLink))
            local maijiaText = SetClassCFF(BG.ChatAccountingFrame.maijia or "")
            if maijiaText == "" then
                maijiaText = BG.STC_y2(L["无"])
            end
            local jineText = "|cffFFD700" .. 0 .. "|rg"
            if BG.ChatAccountingFrame.jine ~= "" then
                jineText = "|cffFFD700" .. BG.ChatAccountingFrame.jine .. "|rg"
            end
            local qiankuantext = ""
            if BG.ChatAccountingFrame.qiankuan ~= "" then
                qiankuantext = format("|cffFF0000" .. L["（欠款%d）"] .. RR, BG.ChatAccountingFrame.qiankuan)
            end

            local text = format(L["|cff00BFFF< 快速记账成功 >|r\n|cffFFFFFF装备：%s\n买家：%s\n金额：%s%s\nBoss：%s"],
                (AddTexture(Texture) .. BG.ChatAccountingFrame.itemLink),
                maijiaText,
                jineText,
                qiankuantext,
                "|cff" .. BG.Boss[FB]["boss" .. b]["color"] .. BG.Boss[FB]["boss" .. b]["name2"] .. RR)
            BG.ChatAccountingFrame.seeText:SetText(text)
        else
            BG.ChatAccountingFrame.seeText:SetText("")
        end
    end

    -- 主UI
    local f = CreateFrame("Frame", "BG.ChatAccountingFrame", UIParent, "BackdropTemplate")
    do
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            edgeSize = 32,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.8)
        f:SetSize(430, 380)
        f:SetFrameStrata("HIGH")
        f:SetClampedToScreen(true)
        f:SetFrameLevel(300)
        f:EnableMouse(true)
        f:SetMovable(true)
        f:SetHyperlinksEnabled(true)
        f:SetScript("OnMouseUp", function(self)
            self:StopMovingOrSizing()
        end)
        f:SetScript("OnMouseDown", function(self)
            self:StartMoving()
        end)
        f:SetScript("OnHyperlinkEnter", function(self, link, text, button)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR", 0, 0)
            GameTooltip:ClearLines()
            local itemID = GetItemInfoInstant(link)
            if itemID then
                GameTooltip:SetHyperlink(BG.SetSpecIDToLink(link))
            end
        end)
        f:SetScript("OnHyperlinkLeave", GameTooltip_Hide)
        f:SetScript("OnShow", function(self)
            if BG.ChatAccountingFrame.maijiaFrame then
                BG.ChatAccountingFrame.maijiaFrame:Hide()
            end
            CreateMaijiaFrame(BG.ChatAccountingFrame)
            local link = ""
            local Texture
            if BG.ChatAccountingFrame.itemLink then
                Texture = select(10, GetItemInfo(BG.ChatAccountingFrame.itemLink))
                link = BG.ChatAccountingFrame.itemLink
            end

            local x, y = GetCursorPosition()
            x, y = x / UIParent:GetEffectiveScale(), y / UIParent:GetEffectiveScale()
            BG.ChatAccountingFrame:ClearAllPoints()
            BG.ChatAccountingFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x + 10, y + 10)
            BG.ChatAccountingFrame.item:SetText(link)
            BG.ChatAccountingFrame.icon:SetTexture(Texture)
            BG.ChatAccountingFrame.maijia = nil
            BG.ChatAccountingFrame.jine = ""
            BG.ChatAccountingFrame.qiankuan = ""
            BG.ChatAccountingFrame.jineFrame:SetText("")
            BG.ChatAccountingFrame.jineFrame:SetFocus()
            BG.ChatAccountingFrame.qiankuanFrame:SetText("")
            for k, v in pairs(BG.playerClass) do
                BG.ChatAccountingFrame[k] = nil
            end
            if BiaoGe.options.fastCountPreview == 1 then
                BG.ChatAccountingFrame.seeFrame:Show()
            else
                BG.ChatAccountingFrame.seeFrame:Hide()
            end
            BG.ChatAccountingFrame:SureButtonUpdate()
        end)
        f:SetScript("OnHide", function(self)
            if BG.ChatAccountingFrame.BlinkHilight then
                BG.ChatAccountingFrame.BlinkHilight:Hide()
            end
        end)
        BG.ChatAccountingFrame = f
    end
    tinsert(UISpecialFrames, "BG.ChatAccountingFrame")

    -- 顶部标题
    do
        local t = f:CreateTexture(nil, "ARTWORK")
        t:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")
        t:SetWidth(256)
        t:SetHeight(64)
        t:SetPoint("TOP", f, 0, 12)
        f.texture = t
        local t = f:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetText(L["< 快速记账 >"])
        t:SetPoint("TOP", f.texture, 0, -13)
        t:SetTextColor(RGB(BG.b1))
    end

    -- 装备
    do
        BG.ChatAccountingFrame.item = BG.ChatAccountingFrame:CreateFontString()
        BG.ChatAccountingFrame.item:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        BG.ChatAccountingFrame.item:SetPoint("TOP", BG.ChatAccountingFrame, "TOP", 0, -35)
        BG.ChatAccountingFrame.item:SetTextColor(RGB("FFD100"))

        BG.ChatAccountingFrame.icon = BG.ChatAccountingFrame:CreateTexture(nil, 'ARTWORK')
        BG.ChatAccountingFrame.icon:SetPoint('LEFT', BG.ChatAccountingFrame.item, "LEFT", -20, 0)
        BG.ChatAccountingFrame.icon:SetSize(18, 18)
    end

    -- 金额
    do
        local edit = CreateFrame("EditBox", nil, BG.ChatAccountingFrame, "InputBoxTemplate")
        edit:SetSize(120, 20)
        edit:SetPoint("BOTTOMRIGHT", BG.ChatAccountingFrame, "BOTTOM", -10, 60)
        edit:SetAutoFocus(false)
        BG.ChatAccountingFrame.jineFrame = edit
        edit:SetScript("OnTextChanged", function(self)
            BG.UpdateTwo0(self)
            BG.ChatAccountingFrame.jine = self:GetText()
            BG.ChatAccountingFrame:SureButtonUpdate()
        end)
        edit:SetScript("OnEnterPressed", function()
            BG.ChatAccountingFrame:SureOnClick()
        end)
        edit:SetScript("OnTabPressed", function()
            BG.ChatAccountingFrame.qiankuanFrame:SetFocus()
        end)
        edit:SetScript("OnMouseDown", function(self, button)
            if button == "RightButton" then
                self:SetEnabled(false)
                self:SetText("")
                if self:HasFocus() then
                    self:ClearFocus()
                end
            end
        end)
        edit:SetScript("OnMouseUp", function(self, button)
            self:SetEnabled(true)
        end)
        edit:SetScript("OnEditFocusGained", function(self)
            local f = BG.CreateNumFrame(BG.ChatAccountingFrame)
            if f then
                f:ClearAllPoints()
                f:SetPoint("BOTTOMRIGHT", BG.ChatAccountingFrame, "BOTTOMLEFT", 2, 0)
            end
        end)
        edit:SetScript("OnEditFocusLost", function(self, button)
            edit:ClearHighlightText()
            BG.After(0, function()
                if BG.ChatAccountingFrame.clickChat then
                    edit:SetFocus()
                    edit:ClearHighlightText()
                end
            end)
            if BG.FrameNumFrame then
                BG.FrameNumFrame:Hide()
            end
        end)

        local t = BG.ChatAccountingFrame.jineFrame:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("RIGHT", BG.ChatAccountingFrame.jineFrame, "LEFT", -10, 0)
        t:SetTextColor(RGB("FFD100"))
        t:SetText(L["金额："])
    end

    -- 欠款
    do
        local edit = CreateFrame("EditBox", nil, BG.ChatAccountingFrame, "InputBoxTemplate")
        edit:SetSize(120, 20)
        edit:SetPoint("BOTTOMRIGHT", BG.ChatAccountingFrame, "BOTTOMRIGHT", -40, 60)
        edit:SetAutoFocus(false)
        edit:SetNumeric(true)
        edit:SetTextColor(1, 0, 0)
        BG.ChatAccountingFrame.qiankuanFrame = edit
        edit:SetScript("OnTextChanged", function(self)
            BG.UpdateTwo0(self)
            BG.ChatAccountingFrame.qiankuan = self:GetText()
            BG.ChatAccountingFrame:SureButtonUpdate()
        end)
        edit:SetScript("OnEnterPressed", function()
            BG.ChatAccountingFrame:SureOnClick()
        end)
        edit:SetScript("OnTabPressed", function()
            BG.ChatAccountingFrame.jineFrame:SetFocus()
        end)
        edit:SetScript("OnMouseDown", function(self, button)
            if button == "RightButton" then
                self:SetEnabled(false)
                self:SetText("")
                if self:HasFocus() then
                    self:ClearFocus()
                end
            end
        end)
        edit:SetScript("OnMouseUp", function(self, button)
            self:SetEnabled(true)
        end)
        edit:SetScript("OnEditFocusGained", function(self)
            local f = BG.CreateNumFrame(BG.ChatAccountingFrame)
            if f then
                f:ClearAllPoints()
                f:SetPoint("BOTTOMRIGHT", BG.ChatAccountingFrame, "BOTTOMLEFT", 2, 0)
            end
        end)
        edit:SetScript("OnEditFocusLost", function(self, button)
            edit:ClearHighlightText()
            BG.After(0, function()
                if BG.ChatAccountingFrame.clickChat then
                    edit:SetFocus()
                    edit:ClearHighlightText()
                end
            end)
            if BG.FrameNumFrame then
                BG.FrameNumFrame:Hide()
            end
        end)

        local t = BG.ChatAccountingFrame.qiankuanFrame:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("RIGHT", BG.ChatAccountingFrame.qiankuanFrame, "LEFT", -10, 0)
        t:SetTextColor(RGB("FFD100"))
        t:SetText(L["欠款："])
    end

    -- 确定/取消
    do
        local function GetJinE(jine)
            if jine and jine ~= "" then
                return jine
            end
            return 0
        end
        function BG.ChatAccountingFrame:SureOnClick()
            if not self.sureButton:IsEnabled() then return end
            local b, i, zhuangbei, maijia, jine, FB = HasEmptyGeZi(self.itemLink)
            if b then
                maijia:SetText(self.maijia or "")
                maijia:SetTextColor(unpack(self.color or { 1, 1, 1 }))
                jine:SetText(GetJinE(self.jine))
                BiaoGe[FB]["boss" .. b]["maijia" .. i] = self.maijia
                BiaoGe[FB]["boss" .. b]["jine" .. i] = GetJinE(self.jine)
                for k, v in pairs(BG.playerClass) do
                    BiaoGe[FB]["boss" .. b][k .. i] = self[k]
                end

                local Texture = select(10, GetItemInfo(self.itemLink))

                local maijiaText = SetClassCFF(self.maijia or "")
                if maijiaText == "" then
                    maijiaText = BG.STC_y2(L["无"])
                end

                local jineText = "|cffFFD700" .. 0 .. "|rg"
                if self.jine ~= "" then
                    jineText = "|cffFFD700" .. self.jine .. "|rg"
                end

                local qiankuantext = ""
                if self.qiankuan ~= "" then
                    BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = self.qiankuan
                    BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Show()
                    qiankuantext = format("|cffFF0000" .. L["（欠款%d）"] .. RR, self.qiankuan)
                end
                self:Hide()

                if BiaoGe.options["fastCountMsg"] == 1 then
                    local text = format(L["|cff00BFFF< 快速记账成功 >|r\n|cffFFFFFF装备：%s\n买家：%s\n金额：%s%s\n表格：%s\nBoss：%s"],
                        (AddTexture(Texture) .. self.itemLink),
                        maijiaText,
                        jineText,
                        qiankuantext,
                        BG.GetFBinfo(FB, "localName"),
                        "|cff" .. BG.Boss[FB]["boss" .. b]["color"] .. BG.Boss[FB]["boss" .. b]["name2"] .. RR)
                    BG.FrameTradeMsg:AddMessage(text)
                end
                return
            end
            JiZhangError(self.itemLink)
        end

        function BG.ChatAccountingFrame:SureButtonUpdate()
            if self.maijia or self.jine ~= "" then
                self.sureButton:Enable()
            else
                self.sureButton:Disable()
            end
            UpdateSeeText()
        end

        local bt = CreateFrame("Button", nil, BG.ChatAccountingFrame, "UIPanelButtonTemplate")
        bt:SetSize(150, 25)
        bt:SetPoint("BOTTOMRIGHT", BG.ChatAccountingFrame, "BOTTOM", -10, 20)
        bt:SetText(L["确定"])
        BG.ChatAccountingFrame.sureButton = bt
        bt:SetScript("OnClick", function(self)
            BG.ChatAccountingFrame:SureOnClick()
            BG.PlaySound(1)
        end)
        local bt = CreateFrame("Button", nil, BG.ChatAccountingFrame, "UIPanelButtonTemplate")
        bt:SetSize(150, 25)
        bt:SetPoint("BOTTOMRIGHT", BG.ChatAccountingFrame, "BOTTOMRIGHT", -40, 20)
        bt:SetText(L["取消"])
        bt:SetScript("OnClick", function(self)
            BG.ChatAccountingFrame:Hide()
            BG.PlaySound(1)
        end)
    end

    -- 预览框
    do
        local f = CreateFrame("Frame", nil, BG.ChatAccountingFrame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        f:SetBackdropColor(0, 0, 0, 0.7)
        f:SetBackdropBorderColor(0, 0, 0, 1)
        f:SetSize(200, 200)
        f:SetPoint("BOTTOMLEFT", BG.ChatAccountingFrame, "BOTTOMRIGHT", -2, 5)
        f:EnableMouse(true)
        BG.ChatAccountingFrame.seeFrame = f

        local text = f:CreateFontString()
        text:SetPoint("TOP", f, "TOP", 0, -10)
        text:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
        text:SetText(L["记账效果预览"])

        local text = f:CreateFontString()
        text:SetPoint("TOPLEFT", f, "TOPLEFT", 8, -45)
        text:SetWidth(f:GetWidth() - 10)
        text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        text:SetJustifyH("LEFT") -- 对齐格式
        BG.ChatAccountingFrame.seeText = text
    end

    hooksecurefunc("SetItemRef", function(link, text, button)
        if BG.IsML then return end -- 如果是团长或物品分配者则退出
        if BiaoGe.options["fastCount"] ~= 1 then return end
        local _type, name, line, chattype = strsplit(":", link)
        if _type == "item" then
            if button == "RightButton" then
                local item, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
                if not link then return end
                if ItemRefTooltip:IsVisible() then
                    ItemRefTooltip:Hide()
                end
                local b, i, zhuangbei, maijia, jine, FB = HasEmptyGeZi(link)
                if b then
                    BG.ChatAccountingFrame.itemLink = link
                    BG.ChatAccountingFrame:Hide()
                    BG.ChatAccountingFrame:Show()
                    GameTooltip:Hide()

                    local f = BG.Create_BlinkHilight(zhuangbei)
                    f:SetPoint("TOPLEFT", zhuangbei, "TOPLEFT", -80, 5)
                    f:SetPoint("BOTTOMRIGHT", jine, "BOTTOMRIGHT", 90, -5)
                    BG.ChatAccountingFrame.BlinkHilight = f
                    return
                end
                JiZhangError(link)
            end
        elseif _type == "player" and chattype == "RAID" and BG.ChatAccountingFrame:IsVisible() then
            BG.ChatAccountingFrame.clickChat = true
            BG.After(0.1, function()
                BG.ChatAccountingFrame.clickChat = false
            end)
            ChatFrame1EditBox:Hide()
            ChatFrame1EditBox:SetText("")

            local num
            local raid = BG.raidRosterInfo
            for i, v in ipairs(raid) do
                if v.name == name then
                    num = i
                    break
                end
            end
            if num then
                for i, _bt in ipairs(BG.ChatAccountingFrame.buttons) do
                    _bt.Left:SetVertexColor(1, 1, 1)
                    _bt.Right:SetVertexColor(1, 1, 1)
                    _bt.Middle:SetVertexColor(1, 1, 1)
                    _bt.choose:Hide()
                end
                if BG.ChatAccountingFrame.maijia == name then
                    BG.ChatAccountingFrame.maijia = nil
                    for k, v in pairs(BG.playerClass) do
                        BG.ChatAccountingFrame[k] = nil
                    end
                else
                    BG.ChatAccountingFrame.maijia = name
                    for k, v in pairs(BG.playerClass) do
                        BG.ChatAccountingFrame[k] = raid[num][k]
                    end
                    for i, _bt in ipairs(BG.ChatAccountingFrame.buttons) do
                        if GetText_T(_bt) == name then
                            _bt.Left:SetVertexColor(0, 1, 0)
                            _bt.Right:SetVertexColor(0, 1, 0)
                            _bt.Middle:SetVertexColor(0, 1, 0)
                            _bt.choose:Show()
                        end
                    end
                end
                BG.ChatAccountingFrame:SureButtonUpdate()
                BG.PlaySound(1)
            end
        end
    end)
end)

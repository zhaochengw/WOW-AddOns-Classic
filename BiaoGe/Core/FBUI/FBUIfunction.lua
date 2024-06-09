local _, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local BossNum = ADDONSELF.BossNum
local FrameHide = ADDONSELF.FrameHide
local AddTexture = ADDONSELF.AddTexture
local GetItemID = ADDONSELF.GetItemID

local pt = print
local RealmId = GetRealmID()
local player = UnitName("player")

local p = {}
local preWidget
local framedown
local frameright
local red, greed, blue = 1, 1, 1

------------------结算工资------------------
local function Sumjine()
    local FB = BG.FB1
    local sum = 0
    for b = 1, Maxb[FB], 1 do
        for i = 1, Maxi[FB], 1 do
            if BG.Frame[FB]["boss" .. b]["jine" .. i] then
                sum = sum + (tonumber(BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText()) or 0)
            end
        end
    end
    return sum
end
local function SumZC()
    local FB = BG.FB1
    local sum = 0
    for i = 1, Maxi[FB], 1 do
        if BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i] then
            sum = sum + (tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]:GetText()) or 0)
        end
    end
    return sum
end
local function SumJ()
    local FB = BG.FB1
    local n1 = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine1"]:GetText()) or 0
    local n2 = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine2"]:GetText()) or 0
    local jing = n1 - n2
    return jing
end
local function SumGZ()
    local FB = BG.FB1
    local n1 = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine3"]:GetText()) or 0
    local n2 = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine4"]:GetText()) or 0
    local gz
    if BiaoGe.options["moLing"] == 1 then
        gz = math.modf(n1 / n2)
    else
        gz = format("%.2f", n1 / n2)
    end
    return gz
end
BG.SumGZ = SumGZ

------------------标题------------------
function BG.FBBiaoTiUI(FB, t, b, bb, i, ii)
    local fontsize = 15
    if b == 1 and i == 1 then
        local version = BG["Frame" .. FB]:CreateFontString()
        if t == 1 then
            version:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 13, -60)
        else
            version:SetPoint("TOPLEFT", frameright, "TOPLEFT", 100, 0)
        end
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.y2))
        version:SetText(L["  项目"])
        preWidget = version

        local version = BG["Frame" .. FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 70, 0)
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.y2))
        version:SetText(L["装备"])
        preWidget = version
        p.preWidget0 = version

        local version = BG["Frame" .. FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 155, 0)
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.y2))
        version:SetText(L["买家"])
        preWidget = version

        local version = BG["Frame" .. FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 95, 0)
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.y2))
        version:SetText(L["金额"])
        preWidget = version
        frameright = version
    end
end

------------------装备------------------
local function OnTextChanged(self)
    local FB = self.FB
    local t = self.t
    local b = self.b
    local i = self.i
    local itemText = self:GetText()
    local itemID = GetItemInfoInstant(itemText)
    local name, link, quality, level, _, _, _, _, _, Texture, _, typeID, _, bindType
    if itemID then
        name, link, quality, level, _, _, _, _, _, Texture, _, typeID, _, bindType = GetItemInfo(itemID)
    end

    local hard
    if link then
        if FB == "ULD" then
            for index, value in ipairs(BG.Loot.ULD.Hard10) do
                if itemID == value then
                    self:SetText(link .. "H")
                    hard = true
                end
            end
            if not hard then
                for index, value in ipairs(BG.Loot.ULD.Hard25) do
                    if itemID == value then
                        self:SetText(link .. "H")
                    end
                end
            end
        elseif FB == "ICC" then
            if itemID == 52030 or itemID == 52029 or itemID == 52028 then
                self:SetText(link .. "H")
            end
        end

        -- 装备图标
        self.icon:SetTexture(Texture)
    else
        self.icon:SetTexture(nil)
    end

    if self:GetText() == "" then
        BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i] = nil
        BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i]:Hide()
    end

    local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID -- 隐藏
    if num ~= 0 then
        BG.UpdateFilter(self)
    end

    if self ~= BG.Frame[FB]["boss" .. Maxb[FB]]["zhuangbei" .. i] and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i] and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i] then
        BG.DuiZhangFrame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i]:SetText(self:GetText())
    end

    if self:GetText() ~= "" then
        BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i] = self:GetText() -- 储存文本
    else
        BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i] = nil
    end

    -- 装绑图标
    BG.BindOnEquip(self, bindType)
    -- 在按钮右边增加装等显示
    BG.LevelText(self, level, typeID)
end
function BG.FBZhuangBeiUI(FB, t, b, bb, i, ii)
    local bt = CreateFrame("EditBox", nil, BG["Frame" .. FB], "InputBoxTemplate")
    bt:SetSize(150, 20)
    bt:SetFrameLevel(110)
    if b > 1 and i == 1 then
        bt:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -20)
    else
        bt:SetPoint("TOPLEFT", p["preWidget" .. i - 1], "BOTTOMLEFT", 0, -3)
    end
    bt:SetAutoFocus(false)
    bt:Show()
    bt.FB = FB
    bt.bossnum = BossNum(FB, b, t)
    bt.t = t
    bt.b = b
    bt.i = i
    bt.icon = bt:CreateTexture(nil, 'ARTWORK')
    bt.icon:SetPoint('LEFT', -22, 0)
    bt.icon:SetSize(16, 16)
    if BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i] then
        if BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i] ~= "" then
            bt:SetText(BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i])
            BG.EditItemCache(bt, OnTextChanged)
        else
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i] = nil
        end
    end
    BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i] = bt
    preWidget = bt
    p["preWidget" .. i] = bt
    framedown = p["preWidget" .. ii]
    --创建关注按钮
    BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i] = BG.CreateGuanZhuButton(bt, "biaoge")

    -- 内容改变时
    bt:SetScript("OnTextChanged", OnTextChanged)
    -- 鼠标按下时
    bt:SetScript("OnMouseDown", function(self, enter)
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i] then -- 右键清空格子
            self:SetEnabled(false)
            self:SetText("")
            if BG.lastfocus then
                BG.lastfocus:ClearFocus()
            end
            return
        end
        if IsAltKeyDown() and IsControlKeyDown() and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i] then
            self:SetEnabled(false)
            bt:ClearFocus()
            if BG.lastfocus then
                BG.lastfocus:ClearFocus()
            end
            BG.JiaoHuan(bt, FB, b, i, t)
            return
        end
        if IsShiftKeyDown() then
            if self:GetText() ~= "" then
                self:SetEnabled(false)
                bt:ClearFocus()
                if BG.lastfocus then
                    BG.lastfocus:ClearFocus()
                end
                local f = GetCurrentKeyBoardFocus()
                if not f then
                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                end
                local text = self:GetText()
                ChatEdit_InsertLink(text)
            end
            return
        end
        if IsAltKeyDown() and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i] and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i] then
            if self:GetText() ~= "" then
                self:SetEnabled(false)
                bt:ClearFocus()
                if BG.lastfocus then
                    BG.lastfocus:ClearFocus()
                end
                if BG.IsLeader then -- 开始拍卖
                    local link = self:GetText()
                    BG.StartAuction(link, self)
                else -- 关注装备
                    BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i] = true
                    BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i]:Show()
                end
            end
            return
        end
        if IsControlKeyDown() then
            if self:GetText() ~= "" then
                self:SetEnabled(false)
                BG.TurntoItemLib(self)
            end
            return
        end
    end)
    bt:SetScript("OnMouseUp", function(self, enter)
        if self:IsEnabled() then
            local infoType, itemID, itemLink = GetCursorInfo()
            if infoType == "item" then
                self:SetText(itemLink)
                self:ClearFocus()
                ClearCursor()
                return
            end
        end
        if self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i] then
            self:SetEnabled(true)
        end
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i] then -- 右键清空格子
            self:SetEnabled(true)
        end
    end)
    -- 鼠标悬停在装备时
    bt:SetScript("OnEnter", function(self)
        BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show()
        if not tonumber(self:GetText()) then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
            GameTooltip:ClearLines()
            local itemLink = bt:GetText()
            local itemID = select(1, GetItemInfoInstant(itemLink))
            if itemID then
                GameTooltip:SetItemByID(itemID)
                GameTooltip:Show()
                local h = { FB, itemID, true, BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i]:GetText() }
                BG.HistoryJine(unpack(h))
                BG.HistoryMOD = h
            end
            BG.HilightBag(itemLink)
        end
    end)
    bt:SetScript("OnLeave", function(self)
        BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
        GameTooltip:Hide()
        if BG["HistoryJineFrameDB1"] then
            for i = 1, BG.HistoryJineFrameDBMax do
                BG["HistoryJineFrameDB" .. i]:Hide()
            end
            BG.HistoryJineFrame:Hide()
        end
        BG.Hide_AllHilight()
    end)
    -- 获得光标时
    bt:SetScript("OnEditFocusGained", function(self)
        FrameHide(1)
        self:HighlightText()
        BG.lastfocuszhuangbei = self
        BG.lastfocus = self

        local infoType, itemID, itemLink = GetCursorInfo()
        if infoType ~= "item" then -- 如果鼠标拿着物品则不会显示装备下拉列表
            BG.SetListzhuangbei(self)
        end

        if BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i + 1] then
            BG.lastfocuszhuangbei2 = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i + 1]
        else
            BG.lastfocuszhuangbei2 = nil
        end
        BG.FrameDs[FB .. 2]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show()
    end)
    -- 失去光标时
    bt:SetScript("OnEditFocusLost", function(self)
        self:ClearHighlightText()
        BG.FrameDs[FB .. 2]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
    end)
    -- 按TAB跳转右边
    bt:SetScript("OnTabPressed", function(self)
        local b = BossNum(FB, b, t)
        BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetFocus()
    end)
    -- 按ENTER
    bt:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
        if BG.FrameZhuangbeiList then
            BG.FrameZhuangbeiList:Hide()
        end
    end)
    -- 按箭头跳转
    bt:SetScript("OnKeyDown", function(self, enter)
        local bb = b
        local tt = t
        local b = BossNum(FB, b, t)
        if not IsModifierKeyDown() then
            if enter == "UP" then -- 上↑
                if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i - 1] then
                    BG.Frame[FB]["boss" .. b]["zhuangbei" .. i - 1]:SetFocus()
                else
                    local b = b
                    if b == 1 then
                        b = Maxb[FB] + 2
                    end
                    local i
                    for ii = Maxi[FB], 1, -1 do
                        if BG.Frame[FB]["boss" .. b - 1]["zhuangbei" .. ii] then
                            i = ii
                            break
                        end
                    end
                    BG.Frame[FB]["boss" .. b - 1]["zhuangbei" .. i]:SetFocus()
                end
            elseif enter == "DOWN" then -- 下↓
                if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i + 1] then
                    BG.Frame[FB]["boss" .. b]["zhuangbei" .. i + 1]:SetFocus()
                else
                    local b = b
                    if b == Maxb[FB] + 1 then
                        b = 0
                    end
                    BG.Frame[FB]["boss" .. b + 1]["zhuangbei" .. 1]:SetFocus()
                end
            elseif enter == "LEFT" then  -- 左←
                BG.Frame[FB]["boss" .. b]["jine" .. i]:SetFocus()
            elseif enter == "RIGHT" then -- 右→
                BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetFocus()
            end
        else
            if enter == "UP" then -- 上↑
                local b = b
                if b == 1 then
                    b = Maxb[FB] + 2
                end
                if BG.Frame[FB]["boss" .. b - 1]["zhuangbei" .. i] then
                    BG.Frame[FB]["boss" .. b - 1]["zhuangbei" .. i]:SetFocus()
                else
                    local i
                    for ii = Maxi[FB], 1, -1 do
                        if BG.Frame[FB]["boss" .. b - 1]["zhuangbei" .. ii] then
                            i = ii
                            break
                        end
                    end
                    BG.Frame[FB]["boss" .. b - 1]["zhuangbei" .. i]:SetFocus()
                end
            elseif enter == "DOWN" then -- 下↓
                local b = b
                if b == Maxb[FB] + 1 then
                    b = 0
                end
                if BG.Frame[FB]["boss" .. b + 1]["zhuangbei" .. i] then
                    BG.Frame[FB]["boss" .. b + 1]["zhuangbei" .. i]:SetFocus()
                else
                    local i
                    for ii = Maxi[FB], 1, -1 do
                        if BG.Frame[FB]["boss" .. b + 1]["zhuangbei" .. ii] then
                            i = ii
                            break
                        end
                    end
                    BG.Frame[FB]["boss" .. b + 1]["zhuangbei" .. i]:SetFocus()
                end
            end
        end
    end)
    -- 按ESC退出
    bt:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        if BG.FrameZhuangbeiList then
            BG.FrameZhuangbeiList:Hide()
        end
    end)
    -- 复原按钮为可点击
    if bt ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i] then
        bt:SetScript("OnShow", function(self)
            bt:Enable()
        end)
    end
end

------------------买家------------------
function BG.FBMaiJiaUI(FB, t, b, bb, i, ii)
    local bt = CreateFrame("EditBox", nil, BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i],
        "InputBoxTemplate")
    bt:SetSize(90, 20)
    bt:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 5, 0)
    bt:SetFrameLevel(110)
    -- button:SetMaxBytes(19) --限制字数
    bt:SetAutoFocus(false)
    bt:Show()
    local color = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["color" .. i]
    if color then
        if not (color[1] == 1 and color[2] == 1 and color[3] == 1) then
            bt:SetTextColor(unpack(color))
        else
            color = nil
        end
    end
    if BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i] then
        if BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i] ~= "" then
            bt:SetText(BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i])
            bt:SetCursorPosition(0)
        else
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i] = nil
        end
    end
    preWidget = bt
    BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i] = bt
    -- 当内容改变时
    bt:SetScript("OnTextChanged", function(self)
        if bt:GetText() ~= "" then
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i] = self:GetText()         -- 储存文本
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["color" .. i] = { self:GetTextColor() } -- 储存颜色
        else
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i] = nil
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["color" .. i] = nil
            self:SetTextColor(1, 1, 1)
        end
    end)
    -- 点击时
    bt:SetScript("OnMouseDown", function(self, enter)
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["maijia" .. i] then -- 右键清空格子
            self:SetEnabled(false)
            self:SetText("")
            if BG.lastfocus then
                BG.lastfocus:ClearFocus()
            end
            return
        end
        if IsAltKeyDown() and IsControlKeyDown() and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["maijia" .. i] then
            self:SetEnabled(false)
            bt:ClearFocus()
            if BG.lastfocus then
                BG.lastfocus:ClearFocus()
            end
            BG.JiaoHuan(bt, FB, b, i, t)
            return
        end
    end)
    bt:SetScript("OnMouseUp", function(self, enter)
        if self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["maijia" .. i] then
            self:SetEnabled(true)
        end
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["maijia" .. i] then -- 右键清空格子
            self:SetEnabled(true)
        end
    end)
    -- 悬停鼠标时
    bt:SetScript("OnEnter", function(self) -- 底色
        BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show()
    end)
    bt:SetScript("OnLeave", function(self)
        BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
    end)
    -- 获得光标时
    bt:SetScript("OnEditFocusGained", function(self)
        FrameHide(1)
        bt:HighlightText()
        BG.lastfocus = self
        BG.maijiaButton = self
        BG.SetListmaijia(self)
        BG.FrameDs[FB .. 2]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show() -- 底色
        if BG.FramePaiMaiMsg then
            BG.FramePaiMaiMsg:SetParent(BG.FrameMaijiaList)
            BG.FramePaiMaiMsg:ClearAllPoints()
            BG.FramePaiMaiMsg:SetPoint("TOPRIGHT", BG.FrameMaijiaList, "TOPLEFT", 0, 0)
            BG.FramePaiMaiMsg:Show()
            if BiaoGe.options["auctionChatHoldNew"] == 1 then
                BG.FramePaiMaiMsg2:ScrollToBottom()
            end
            if BiaoGe.options["auctionChat"] == 1 then
                BG.FramePaiMaiMsg:Show()
            else
                BG.FramePaiMaiMsg:Hide()
            end
        end
    end)
    -- 失去光标时
    bt:SetScript("OnEditFocusLost", function(self)
        self:ClearHighlightText()
        BG.FrameDs[FB .. 2]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
    end)
    -- 按TAB跳转右边
    bt:SetScript("OnTabPressed", function(self)
        local b = BossNum(FB, b, t)
        BG.Frame[FB]["boss" .. b]["jine" .. i]:SetFocus()
    end)
    -- 按ENTER
    bt:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
        if BG.FrameMaijiaList then
            BG.FrameMaijiaList:Hide()
        end
    end)
    -- 按箭头跳转
    bt:SetScript("OnKeyDown", function(self, enter)
        local b = BossNum(FB, b, t)
        if not IsModifierKeyDown() then
            if enter == "UP" then -- 上↑
                if BG.Frame[FB]["boss" .. b]["maijia" .. i - 1] then
                    BG.Frame[FB]["boss" .. b]["maijia" .. i - 1]:SetFocus()
                else
                    local b = b
                    if b == 1 then
                        b = Maxb[FB] + 2
                    end
                    local i
                    for ii = Maxi[FB], 1, -1 do
                        if BG.Frame[FB]["boss" .. b - 1]["maijia" .. ii] then
                            i = ii
                            break
                        end
                    end
                    BG.Frame[FB]["boss" .. b - 1]["maijia" .. i]:SetFocus()
                end
            elseif enter == "DOWN" then -- 下↓
                if BG.Frame[FB]["boss" .. b]["maijia" .. i + 1] then
                    BG.Frame[FB]["boss" .. b]["maijia" .. i + 1]:SetFocus()
                else
                    local b = b
                    if b == Maxb[FB] + 1 then
                        b = 0
                    end
                    BG.Frame[FB]["boss" .. b + 1]["maijia" .. 1]:SetFocus()
                end
            elseif enter == "LEFT" then  -- 左←
                BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:SetFocus()
            elseif enter == "RIGHT" then -- 右→
                BG.Frame[FB]["boss" .. b]["jine" .. i]:SetFocus()
            end
        else
            if enter == "UP" then -- 上↑
                local b = b
                if b == 1 then
                    b = Maxb[FB] + 2
                end
                if BG.Frame[FB]["boss" .. b - 1]["maijia" .. i] then
                    BG.Frame[FB]["boss" .. b - 1]["maijia" .. i]:SetFocus()
                else
                    local i
                    for ii = Maxi[FB], 1, -1 do
                        if BG.Frame[FB]["boss" .. b - 1]["maijia" .. ii] then
                            i = ii
                            break
                        end
                    end
                    BG.Frame[FB]["boss" .. b - 1]["maijia" .. i]:SetFocus()
                end
            elseif enter == "DOWN" then -- 下↓
                local b = b
                if b == Maxb[FB] + 1 then
                    b = 0
                end
                if BG.Frame[FB]["boss" .. b + 1]["maijia" .. i] then
                    BG.Frame[FB]["boss" .. b + 1]["maijia" .. i]:SetFocus()
                else
                    local i
                    for ii = Maxi[FB], 1, -1 do
                        if BG.Frame[FB]["boss" .. b + 1]["maijia" .. ii] then
                            i = ii
                            break
                        end
                    end
                    BG.Frame[FB]["boss" .. b + 1]["maijia" .. i]:SetFocus()
                end
            end
        end
    end)
    -- 按ESC退出
    bt:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        if BG.FrameMaijiaList then
            BG.FrameMaijiaList:Hide()
        end
    end)
end

------------------金额------------------
function BG.FBJinEUI(FB, t, b, bb, i, ii)
    local bt = CreateFrame("EditBox", nil, BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i],
        "InputBoxTemplate")
    bt:SetSize(80, 20)
    bt:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 5, 0)
    bt:SetFrameLevel(110)
    -- button:SetNumeric(true)      -- 只能输入整数
    bt:SetAutoFocus(false)
    bt:Show()
    bt.FB = FB
    bt.bossnum = BossNum(FB, b, t)
    bt.t = t
    bt.b = b
    bt.i = i
    if BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i] then
        if BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i] ~= "" then
            bt:SetText(BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i])
        else
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i] = nil
        end
    end
    preWidget = bt
    BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i] = bt
    -- 创建欠款按钮
    BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["qiankuan" .. i] = BG.CreateQiankuanButton(bt, "biaoge")

    -- 当内容改变时
    bt:SetScript("OnTextChanged", function(self)
        local name = "autoAdd0"
        if BiaoGe.options[name] == 1 and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i] and not IsModifierKeyDown() then
            local len = strlen(self:GetText())
            local lingling
            if len then
                lingling = strsub(self:GetText(), len - 1, len)
            end
            if lingling ~= "00" and lingling ~= "0" and tonumber(self:GetText()) and self:HasFocus() then
                self:Insert("00")
                self:SetCursorPosition(1)
            end
        end
        if self ~= BG.Frame[FB]["boss" .. Maxb[FB]]["jine" .. i] and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i] and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i] then
            BG.DuiZhangFrame[FB]["boss" .. BossNum(FB, b, t)]["myjine" .. i]:SetText(self:GetText())
        end

        if bt:GetText() ~= "" then
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i] = bt:GetText() -- 储存文本
        else
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i] = nil
        end
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine1"]:SetText(Sumjine()) -- 计算总收入
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine2"]:SetText(SumZC())   -- 计算总支出
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine3"]:SetText(SumJ())    -- 计算净收入
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine5"]:SetText(SumGZ())   -- 计算人均工资

        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine1"]:SetCursorPosition(0)
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine2"]:SetCursorPosition(0)
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine3"]:SetCursorPosition(0)
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine5"]:SetCursorPosition(0)
    end)
    -- 点击时
    bt:SetScript("OnMouseDown", function(self, enter)
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i] then -- 右键清空格子
            FrameHide(1)
            self:SetEnabled(false)
            self:SetText("")
            return
        end
        if IsAltKeyDown() and IsControlKeyDown() and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i] then
            self:SetEnabled(false)
            bt:ClearFocus()
            if BG.lastfocus then
                BG.lastfocus:ClearFocus()
            end
            BG.JiaoHuan(bt, FB, b, i, t)
            return
        end
    end)
    bt:SetScript("OnMouseUp", function(self, enter)
        if self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i] then
            self:SetEnabled(true)
        end
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i] then -- 右键清空格子
            self:SetEnabled(true)
        end
    end)
    -- 悬停鼠标时
    bt:SetScript("OnEnter", function(self) -- 底色
        BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show()
    end)
    bt:SetScript("OnLeave", function(self)
        BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
    end)
    -- 获得光标时
    bt:SetScript("OnEditFocusGained", function(self)
        FrameHide(1)
        bt:HighlightText()
        BG.lastfocus = self
        BG.maijiaButton = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i]
        BG.FrameDs[FB .. 2]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show() -- 底色
        if self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i] and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i] then
            BG.SetListjine(self, FB, BossNum(FB, b, t), i)
        end
        if BG.FramePaiMaiMsg then
            BG.FramePaiMaiMsg:SetParent(BG.FrameJineList)
            BG.FramePaiMaiMsg:ClearAllPoints()
            BG.FramePaiMaiMsg:SetPoint("TOPRIGHT", BG.FrameJineList, "TOPLEFT", 0, 0)
            if BiaoGe.options["auctionChatHoldNew"] == 1 then
                BG.FramePaiMaiMsg2:ScrollToBottom()
            end
            if BiaoGe.options["auctionChat"] == 1 then
                BG.FramePaiMaiMsg:Show()
            else
                BG.FramePaiMaiMsg:Hide()
            end
        end
    end)
    -- 失去光标时
    bt:SetScript("OnEditFocusLost", function(self)
        self:ClearHighlightText()
        BG.FrameDs[FB .. 2]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
    end)
    -- 按TAB跳转下一行的装备
    bt:SetScript("OnTabPressed", function(self)
        local b = BossNum(FB, b, t)
        if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i + 1] then
            BG.Frame[FB]["boss" .. b]["zhuangbei" .. i + 1]:SetFocus()
        elseif b + 1 ~= Maxb[FB] + 2 then
            BG.Frame[FB]["boss" .. b + 1]["zhuangbei" .. 1]:SetFocus()
        end
    end)
    -- 按ENTER
    bt:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
        if BG.FrameJineList then
            BG.FrameJineList:Hide()
        end
    end)
    -- 按ESC退出
    bt:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        if BG.FrameJineList then
            BG.FrameJineList:Hide()
        end
        -- BG.FramePaiMaiMsg:Hide()
    end)
    -- 按箭头跳转
    bt:SetScript("OnKeyDown", function(self, enter)
        local b = BossNum(FB, b, t)
        if not IsModifierKeyDown() then
            if enter == "UP" then -- 上↑
                if BG.Frame[FB]["boss" .. b]["jine" .. i - 1] then
                    BG.Frame[FB]["boss" .. b]["jine" .. i - 1]:SetFocus()
                else
                    local b = b
                    if b == 1 then
                        b = Maxb[FB] + 2
                    end
                    local i
                    for ii = Maxi[FB], 1, -1 do
                        if BG.Frame[FB]["boss" .. b - 1]["jine" .. ii] then
                            i = ii
                            break
                        end
                    end
                    BG.Frame[FB]["boss" .. b - 1]["jine" .. i]:SetFocus()
                end
            elseif enter == "DOWN" then -- 下↓
                if BG.Frame[FB]["boss" .. b]["jine" .. i + 1] then
                    BG.Frame[FB]["boss" .. b]["jine" .. i + 1]:SetFocus()
                else
                    local b = b
                    if b == Maxb[FB] + 1 then
                        b = 0
                    end
                    BG.Frame[FB]["boss" .. b + 1]["jine" .. 1]:SetFocus()
                end
            elseif enter == "LEFT" then  -- 左←
                BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetFocus()
            elseif enter == "RIGHT" then -- 右→
                BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:SetFocus()
            end
        else
            if enter == "UP" then -- 上↑
                local b = b
                if b == 1 then
                    b = Maxb[FB] + 2
                end
                if BG.Frame[FB]["boss" .. b - 1]["jine" .. i] then
                    BG.Frame[FB]["boss" .. b - 1]["jine" .. i]:SetFocus()
                else
                    local i
                    for ii = Maxi[FB], 1, -1 do
                        if BG.Frame[FB]["boss" .. b - 1]["jine" .. ii] then
                            i = ii
                            break
                        end
                    end
                    BG.Frame[FB]["boss" .. b - 1]["jine" .. i]:SetFocus()
                end
            elseif enter == "DOWN" then -- 下↓
                local b = b
                if b == Maxb[FB] + 1 then
                    b = 0
                end
                if BG.Frame[FB]["boss" .. b + 1]["jine" .. i] then
                    BG.Frame[FB]["boss" .. b + 1]["jine" .. i]:SetFocus()
                else
                    local i
                    for ii = Maxi[FB], 1, -1 do
                        if BG.Frame[FB]["boss" .. b + 1]["jine" .. ii] then
                            i = ii
                            break
                        end
                    end
                    BG.Frame[FB]["boss" .. b + 1]["jine" .. i]:SetFocus()
                end
            end
        end
    end)
end

------------------BOSS名字------------------
function BG.FBBossNameUI(FB, t, b, bb, i, ii)
    local fontsize = 14
    if FB == "ICC" and BossNum(FB, b, t) <= 13 then
        local f = CreateFrame("Frame", nil, BG["Frame" .. FB])
        f:SetPoint("TOP", BG.Frame[FB]["boss" .. BossNum(FB, b, t)].zhuangbei1, "TOPLEFT", -45, -2)
        f:SetSize(15, 40)
        local version = f:CreateFontString()
        version:SetPoint("CENTER")
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].color))
        version:SetText(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].name)
        f:SetSize(version:GetStringWidth() - 5, version:GetStringHeight())
        BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["name"] = version
        f:SetScript("OnMouseUp", function(self)
            if IsShiftKeyDown() then
                local b = BossNum(FB, b, t)
                BG.ClickTabButton(BG.tabButtons, BG.BossMainFrameTabNum)

                for i, v in ipairs(BG["BossTabButtons" .. FB]) do
                    v:Enable()
                    v.spellScrollFrame:Hide()
                    v.classScrollFrame:Hide()
                end
                BG["BossTabButtons" .. FB][b]:Disable()
                BG["BossTabButtons" .. FB][b].spellScrollFrame:Show()
                BG["BossTabButtons" .. FB][b].classScrollFrame:Show()
                BiaoGe.BossFrame[FB].lastFrame = b
                PlaySound(BG.sound1, "Master")
            end
            BG.MainFrame:GetScript("OnMouseUp")(BG.MainFrame)
        end)
        f:SetScript("OnMouseDown", function(self)
            BG.MainFrame:GetScript("OnMouseDown")(BG.MainFrame)
        end)
        f:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine("|cff" .. BG.Boss[FB]["boss" .. BossNum(FB, b, t)].color .. BG.Boss[FB]["boss" .. BossNum(FB, b, t)].name2 .. RR)
            GameTooltip:AddLine(L["SHIFT+点击："], 1, 1, 1)
            GameTooltip:AddLine(L["查看该BOSS攻略"])
            -- GameTooltip:SetText(L["查看该BOSS攻略"])
            GameTooltip:Show()
            version:SetTextColor(1, 1, 1)
        end)
        f:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
            version:SetTextColor(RGB(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].color))
        end)
    else
        local version = BG["Frame" .. FB]:CreateFontString()
        version:SetPoint("TOP", BG.Frame[FB]["boss" .. BossNum(FB, b, t)].zhuangbei1, "TOPLEFT", -45, -2)
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].color))
        version:SetText(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].name)
        BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["name"] = version
    end
    if BG.Frame[FB]["boss" .. BossNum(FB, b, t)] == BG.Frame[FB]["boss" .. Maxb[FB] + 2] then
        local version = BG["Frame" .. FB]:CreateFontString()
        version:SetPoint("BOTTOM", BG.Frame[FB]["boss" .. Maxb[FB] + 2].zhuangbei5, "BOTTOMLEFT", -45, 7)
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB("00BFFF"))
        version:SetText(L["工\n资"])
    end
    BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["bossname"] = nil
    BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["bossname2"] = nil
end

------------------击杀用时------------------
function BG.FBJiShaUI(FB, t, b, bb, i, ii)
    if BossNum(FB, b, t) > Maxb[FB] - 2 then return end
    local text = BG["Frame" .. FB]:CreateFontString()
    local num
    for i = 1, Maxi[FB] do
        if not BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i + 1] then
            num = i
            break
        end
    end
    text:SetPoint("TOPLEFT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. num], "BOTTOMLEFT", -0, -3)
    text:SetFont(BIAOGE_TEXT_FONT, 10, "OUTLINE,THICK")
    text:SetAlpha(0)
    BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["time"] = text

    if BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["time"] then
        text:SetText(BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["time"])
    end
end

------------------底色材质------------------
function BG.FBDiSeUI(FB, t, b, bb, i, ii)
    -- 先做底色材质1（鼠标悬停的）
    local textrue = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i]:CreateTexture()
    textrue:SetPoint("TOPLEFT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i], "TOPLEFT", -4, -2)
    textrue:SetPoint("BOTTOMRIGHT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i], "BOTTOMRIGHT", -2, 0)
    textrue:SetColorTexture(red, greed, blue, BG.onEnterAlpha)
    textrue:Hide()
    BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i] = textrue

    -- 底色材质2（点击框体后）
    local textrue = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i]:CreateTexture()
    textrue:SetPoint("TOPLEFT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i], "TOPLEFT", -4, -2)
    textrue:SetPoint("BOTTOMRIGHT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i], "BOTTOMRIGHT", -2, 0)
    textrue:SetColorTexture(red, greed, blue, BG.onEnterAlpha)
    textrue:Hide()
    BG.FrameDs[FB .. 2]["boss" .. BossNum(FB, b, t)]["ds" .. i] = textrue

    -- 底色材质3（团长发的装备高亮）
    local textrue = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i]:CreateTexture()
    textrue:SetPoint("TOPLEFT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i], "TOPLEFT", -4, -2)
    textrue:SetPoint("BOTTOMRIGHT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i], "BOTTOMRIGHT", -2, 0)
    textrue:SetColorTexture(1, 1, 0, BG.highLightAlpha)
    textrue:Hide()
    BG.FrameDs[FB .. 3]["boss" .. BossNum(FB, b, t)]["ds" .. i] = textrue
end

------------------支出、总览、工资------------------
function BG.FBZhiChuZongLanGongZiUI(FB)
    -- 初始化支出内容
    if not BiaoGe[FB]["boss" .. Maxb[FB] + 1]["zhuangbei1"] then
        BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei1"]:SetText(L["坦克补贴"])
    end
    if not BiaoGe[FB]["boss" .. Maxb[FB] + 1]["zhuangbei2"] then
        BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei2"]:SetText(L["治疗补贴"])
    end
    if not BiaoGe[FB]["boss" .. Maxb[FB] + 1]["zhuangbei3"] then
        BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei3"]:SetText(L["输出补贴"])
    end
    if not BG.IsVanilla() then
        if not BiaoGe[FB]["boss" .. Maxb[FB] + 1]["zhuangbei4"] then
            BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei4"]:SetText(L["放鱼补贴"])
        end
    end
    -- 设置支出颜色：绿
    for i = 1, Maxi[FB], 1 do
        if BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i] then
            BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i]:SetTextColor(RGB("00FF00"))
            BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]:SetTextColor(RGB("00FF00"))
        end
    end

    -- 总览和工资
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei1"]:SetText(L["总收入"])
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei2"]:SetText(L["总支出"])
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei3"]:SetText(L["净收入"])
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei4"]:SetText(L["分钱人数"])
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei5"]:SetText(L["人均工资"])
    if BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine4"]:GetText() == "" then
        if BG.IsVanilla() then
            BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine4"]:SetText(BG.GetFBinfo(FB, "maxplayers") or "10")
        else
            BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine4"]:SetText(BG.GetFBinfo(FB, "maxplayers") or "25")
        end
    end
    for i = 1, 5, 1 do
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i]:SetEnabled(false)
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["maijia" .. i]:SetEnabled(false)
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i]:SetEnabled(false)
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i]:SetCursorPosition(0)
    end
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine4"]:SetEnabled(true)
    -- 设置总览颜色：粉
    for i = 1, 3, 1 do
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i]:SetTextColor(RGB("EE82EE"))
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i]:SetTextColor(RGB("EE82EE"))
    end
    -- 设置工资颜色：蓝
    for i = 4, 5, 1 do
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i]:SetTextColor(RGB("00BFFF"))
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i]:SetTextColor(RGB("00BFFF"))
    end
    -- 设置工资人数的鼠标提示
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei4"]:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:SetText(L["人数可自行修改"])
    end)
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine4"]:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:SetText(L["人数可自行修改"])
    end)
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine4"]:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
end

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
-- local last
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

local function HighlightBiaoGeSameItems(itemID, self)
    local tbl = {}
    local FB = BG.FB1
    for b = 1, Maxb[FB], 1 do
        for i = 1, Maxi[FB], 1 do
            local zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
            local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
            if zb then
                if itemID == GetItemID(zb:GetText()) then
                    tinsert(tbl, { zb = zb, jine = jine })
                end
            end
        end
    end
    if #tbl > 1 then
        local frame
        for i, v in ipairs(tbl) do
            local f = CreateFrame("Frame", nil, v.zb, "BackdropTemplate")
            f:SetBackdrop({
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 2,
            })
            f:SetBackdropBorderColor(RGB("FF69B4", 0.5))
            f:SetPoint("TOPLEFT", v.zb, "TOPLEFT", -4, -2)
            f:SetPoint("BOTTOMRIGHT", v.jine, "BOTTOMRIGHT", -2, 0)
            f:SetFrameLevel(114)
            tinsert(BG.LastBagItemFrame, f)

            frame = f
        end
        local t = frame:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 20, "OUTLINE")
        t:SetPoint("RIGHT", self, "RIGHT", -2, 0)
        t:SetTextColor(RGB("FF69B4"))
        t:SetText(#tbl)
    end
    tbl = nil
end

function BG.UpdateZhiChuPercent(zhuangbei, jine)
    local FB = BG.FB1
    zhuangbei:SetTextColor(0, 1, 0)
    jine:SetTextColor(0, 1, 0)
    zhuangbei.hasPercent = false
    jine.hasPercent = false
    if BiaoGe.options["zhichuPercent"] ~= 1 then return end

    local num = tonumber(zhuangbei:GetText():match("(%d+)%%"))
    if num then
        local text = floor(BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine1"]:GetText() * num * 0.01)
        if text == 0 then text = "" end
        jine:SetText(text)
        zhuangbei:SetTextColor(RGB("008000"))
        jine:SetTextColor(RGB("008000"))
        zhuangbei.hasPercent = num
        jine.hasPercent = num

        if zhuangbei.isEnter then
            zhuangbei:GetScript("OnEnter")(zhuangbei)
        end
        if jine.isEnter then
            jine:GetScript("OnEnter")(jine)
        end
        return
    end
    if zhuangbei.isEnter or jine.isEnter then
        GameTooltip:Hide()
    end
end

local function OnEnterZhiChuPercent(self)
    if self.hasPercent then
        if BG.ButtonIsInRight(self) then
            GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
        else
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
        end
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
        GameTooltip:AddLine(format(L["该支出项含有百分比|cff00ff00（%s%%）|r，正在自动计算支出金额。"], self.hasPercent), 1, 0.82, 0, true)
        GameTooltip:AddLine(L["你可以通过删除支出项的百分比符号来取消自动计算，或者在表格设置里关闭该项功能。"], 0.5, 0.5, 0.5, true)
        GameTooltip:Show()
    end
end

function BG.GetGeZiTardeInfo(FB, b, i)
    for ii, _ in ipairs(BiaoGe[FB].tradeTbl) do
        for _, v in ipairs(BiaoGe[FB].tradeTbl[ii]) do
            if b == v.b and i == v.i then
                return BiaoGe[FB].tradeTbl[ii], ii
            end
        end
    end
end

local function ShowTardeHighLightItem(self)
    local b = self.bossnum
    local i = self.i
    local FB = BG.FB1
    local tradeInfo = BG.GetGeZiTardeInfo(FB, b, i)
    if tradeInfo then
        for _, v in ipairs(tradeInfo) do
            for b = 1, Maxb[FB] do
                for i = 1, Maxi[FB] do
                    local zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                    local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
                    if zb and b == v.b and i == v.i then
                        local f = CreateFrame("Frame", nil, zb, "BackdropTemplate")
                        f:SetBackdrop({
                            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                            edgeSize = 2,
                        })
                        f:SetBackdropBorderColor(0, 1, 0, 0.5)
                        f:SetPoint("TOPLEFT", zb, "TOPLEFT", -4, -2)
                        f:SetPoint("BOTTOMRIGHT", jine, "BOTTOMRIGHT", -2, 0)
                        f:SetFrameLevel(114)
                        tinsert(BG.LastBagItemFrame, f)

                        local t = f:CreateFontString()
                        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                        t:SetPoint("LEFT", jine, "RIGHT", 2, 0)
                        t:SetTextColor(0, 1, 0)
                        t:SetText(L["打包交易"])
                    end
                end
            end
        end
    end
end

------------------标题------------------
function BG.FBBiaoTiUI(FB, t)
    local fontsize = 15
    local parent = BG["Frame" .. FB]
    local version = parent:CreateFontString()
    if t == 1 then
        version:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 13, -60)
    else
        version:SetPoint("TOPLEFT", frameright, "TOPLEFT", 100, 0)
    end
    version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    version:SetText(L["  项目"])
    preWidget = version

    local version = parent:CreateFontString()
    version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 70, 0)
    version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    version:SetText(L["装备"])
    preWidget = version
    p.preWidget0 = version

    local version = parent:CreateFontString()
    version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 155, 0)
    version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    version:SetText(L["买家"])
    preWidget = version

    local version = parent:CreateFontString()
    version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 95, 0)
    version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    version:SetText(L["金额"])
    preWidget = version
    frameright = version
end

------------------装备------------------
local function OnTextChanged(self)
    local FB = self.FB
    local t = self.t
    local b = self.b
    local i = self.i
    local bossnum = self.bossnum
    local itemText = self:GetText()
    local itemID = GetItemInfoInstant(itemText)
    local name, link, quality, level, _, _, _, _, _, Texture, _, typeID, _, bindType = GetItemInfo(itemText)

    if link and itemText:find("item:") then
        if FB == "ULD" then
            local hard
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

    if bossnum ~= Maxb[FB] and bossnum ~= Maxb[FB] + 1 and bossnum ~= Maxb[FB] + 2 then
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
    -- 已拥有图标
    BG.IsHave(self)

    -- 支出百分比
    if bossnum == Maxb[FB] + 1 then
        local jine = BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]
        BG.UpdateZhiChuPercent(self, jine)
    end
end
function BG.FBZhuangBeiUI(FB, t, b, bb, i, ii, scrollFrame)
    local parent = scrollFrame or BG["Frame" .. FB]
    local bt = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    bt:SetSize(150, 20)
    bt:SetFrameLevel(110)
    if BG.zaxiang[FB] and BossNum(FB, b, t) == Maxb[FB] - 1 and i == BG.zaxiang[FB].i then
        bt:SetPoint("TOPLEFT", frameright, "TOPLEFT", 170, -18)
    else
        if scrollFrame and i == 1 then
            bt:SetPoint("TOPLEFT", scrollFrame, 5, 0)
        elseif b > 1 and i == 1 then
            bt:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -20)
        else
            if BG.zaxiang[FB] and BossNum(FB, b, t) == Maxb[FB] and i == 1 then
                bt:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -20)
            else
                bt:SetPoint("TOPLEFT", p["preWidget" .. i - 1], "BOTTOMLEFT", 0, -3)
            end
        end
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
            BG.Hide_AllHiLight()
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
                if BG.IsML then -- 开始拍卖
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
                BG.GoToItemLib(self)
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
                if BG.FrameZhuangbeiList then
                    BG.FrameZhuangbeiList:Hide()
                end
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
        self.isEnter = true
        if BossNum(FB, b, t) ~= Maxb[FB] + 2 or (BossNum(FB, b, t) == Maxb[FB] + 2 and i == 4) then
            BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show()
        end
        if not tonumber(self:GetText()) then
            local link = bt:GetText()
            local itemID = GetItemInfoInstant(link)
            BG.Hide_AllHiLight()
            BG.HighlightBag(link)
            BG.HighlightItemGuoQi(link)
            if itemID then
                if BG.ButtonIsInRight(self) then
                    GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
                else
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                end
                GameTooltip:ClearLines()
                GameTooltip:SetItemByID(itemID)
                GameTooltip:Show()
                local h = { FB, itemID, true, BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i]:GetText() }
                BG.HistoryJine(unpack(h))
                BG.HistoryMOD = h

                HighlightBiaoGeSameItems(itemID, self)
            end
        end
        OnEnterZhiChuPercent(self)
    end)
    bt:SetScript("OnLeave", function(self)
        self.isEnter = false
        BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
        GameTooltip:Hide()
        if BG["HistoryJineFrameDB1"] then
            for i = 1, BG.HistoryJineFrameDBMax do
                BG["HistoryJineFrameDB" .. i]:Hide()
            end
            BG.HistoryJineFrame:Hide()
        end
        BG.Hide_AllHiLight()
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
        if BossNum(FB, b, t) ~= Maxb[FB] + 2 or (BossNum(FB, b, t) == Maxb[FB] + 2 and i == 4) then
            BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show()
        end
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
        local bossnum = self.bossnum

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

        if bossnum ~= Maxb[FB] and bossnum ~= Maxb[FB] + 1 and bossnum ~= Maxb[FB] + 2 then
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

        -- 支出百分比
        if bossnum == Maxb[FB] + 1 then
            local zhuangbei = BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i]
            BG.UpdateZhiChuPercent(zhuangbei, self)
        end
        if self == BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine1"] then
            for i = 1, Maxi[FB] do
                local zhuangbei = BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i]
                local jine = BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]
                if zhuangbei then
                    BG.UpdateZhiChuPercent(zhuangbei, jine)
                end
            end
        end
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
        self.isEnter = true
        if BossNum(FB, b, t) ~= Maxb[FB] + 2 or (BossNum(FB, b, t) == Maxb[FB] + 2 and i == 4) then
            BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show()
        end
        OnEnterZhiChuPercent(self)
        ShowTardeHighLightItem(self)
    end)
    bt:SetScript("OnLeave", function(self)
        self.isEnter = false
        BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
        GameTooltip:Hide()
        BG.Hide_AllHiLight()
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
function BG.FBBossNameUI(FB, t, b, bb, i, ii, frameName)
    local version
    local fontsize = 14
    if FB == "ICC" and BossNum(FB, b, t) <= 13 then
        local f = CreateFrame("Frame", nil, BG["Frame" .. FB])
        f:SetPoint("TOP", BG.Frame[FB]["boss" .. BossNum(FB, b, t)].zhuangbei1, "TOPLEFT", -45, -2)
        f:SetSize(15, 40)
        version = f:CreateFontString()
        version:SetPoint("CENTER")
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].color))
        version:SetText(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].name)
        f:SetSize(version:GetStringWidth() - 5, version:GetStringHeight())
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
            GameTooltip:Show()
            version:SetTextColor(1, 1, 1)
        end)
        f:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
            version:SetTextColor(RGB(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].color))
        end)
    else
        version = BG["Frame" .. FB]:CreateFontString()
        if frameName and BG[frameName .. FB]["scrollFrame" .. BossNum(FB, b, t)] then
            version:SetPoint("TOP", BG[frameName .. FB]["scrollFrame" .. BossNum(FB, b, t)].owner, "TOPLEFT", -40, -2)
        else
            version:SetPoint("TOP", BG.Frame[FB]["boss" .. BossNum(FB, b, t)].zhuangbei1, "TOPLEFT", -45, -2)
        end
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].color))
        version:SetText(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].name)
    end
    BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["name"] = version

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
    text:SetTextColor(RGB(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].color))
    text:SetAlpha(0)
    BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["time"] = text

    if BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["time"] then
        text:SetText(L["击杀用时"] .. " " .. BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["time"])
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
    if BG.IsWLK() then
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
    local function OnEnter(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:SetText(L["人数可自行修改"])
    end
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei4"]:HookScript("OnEnter", OnEnter)
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine4"]:HookScript("OnEnter", OnEnter)
end

function BG.CreateFBScrollFrame(frameName, FB, bossNum)
    local t, b = BG.GetBossNumInfo(FB, bossNum)
    local pointFrame, pointX, pointY
    if b == 1 then
        if BG.zaxiang[FB] and bossNum == Maxb[FB] then
            pointFrame = BG[frameName][FB]["boss" .. bossNum - 1]["zhuangbei" .. BG.GetBossButtonCount(FB, bossNum - 1)]
            pointX, pointY = -5, -20
        else
            pointFrame = p["preWidget" .. 0]
            pointX, pointY = -5, -3
        end
    elseif BG[frameName .. FB]["scrollFrame" .. bossNum - 1] then
        pointFrame = BG[frameName .. FB]["scrollFrame" .. bossNum - 1].owner
        pointX, pointY = 0, -18
    else
        pointFrame = BG[frameName][FB]["boss" .. bossNum - 1]["zhuangbei" .. BG.GetBossButtonCount(FB, bossNum - 1)]
        pointX, pointY = -5, -20
    end

    local parent = BG[frameName .. FB]
    local scroll = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate") -- 滚动
    scroll:SetWidth(350)
    scroll:SetHeight(BG.GetBossButtonCount(FB, bossNum) * 23)
    scroll:SetPoint("TOPLEFT", pointFrame, "BOTTOMLEFT", pointX, pointY)
    -- scroll.ScrollBar.scrollStep = BG.scrollStep
    BG.CreateSrollBarBackdrop(scroll.ScrollBar)

    local child = CreateFrame("Frame", nil, scroll) -- 子框架
    child:SetSize(1, 1)
    child.owner = scroll
    scroll:SetScrollChild(child)
    BG[frameName .. FB]["scrollFrame" .. bossNum] = child
    if bossNum == Maxb[FB] + 2 then
        scroll.ScrollBar:Hide()
    end
end

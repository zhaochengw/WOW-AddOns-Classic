local _, ns = ...
if BG.IsBlackListPlayer then return end

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local Maxb = ns.Maxb
local BossNum = ns.BossNum
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local pt = print
local RealmId = GetRealmID()
local player = BG.playerName

local p = {}
BG.Frame.p = p
local preWidget
local framedown
local frameright
local red, greed, blue = 1, 1, 1

------------------结算工资------------------
function BG.GetTotalIncome(FB)
    local FB = FB or BG.FB1
    local sum = 0
    for b = 1, Maxb[FB] do
        for i = 1, BG.GetMaxi(FB, b) do
            if BG.Frame[FB]["boss" .. b]["jine" .. i] then
                sum = sum + (tonumber(BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText()) or 0)
            end
        end
    end
    return sum
end

function BG.GetTotalExpenditure(FB)
    local FB = FB or BG.FB1
    local sum = 0
    local b = Maxb[FB] + 1
    for i = 1, BG.GetMaxi(FB, b) do
        if BG.Frame[FB]["boss" .. b]["jine" .. i] then
            sum = sum + (tonumber(BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText()) or 0)
        end
    end
    return sum
end

function BG.GetNetIncome(FB)
    local FB = FB or BG.FB1
    local totalIncome = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine1"]:GetText()) or 0
    local expenditure = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine2"]:GetText()) or 0
    return totalIncome - expenditure
end

function BG.GetWages(FB)
    local FB = FB or BG.FB1
    local netIncome = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine3"]:GetText()) or 0
    local num = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine4"]:GetText()) or 0
    local wages
    if BiaoGe.options["moLing"] == 1 then
        wages = math.modf(netIncome / num)
    else
        wages = format("%.2f", netIncome / num)
    end
    return wages
end

local function HighlightBiaoGeSameItems(itemID, self)
    local tbl = {}
    local FB = BG.FB1
    for b = 1, Maxb[FB] do
        for i = 1, BG.GetMaxi(FB, b) do
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
            frame = BG.CreateHighlightFrame(v.zb, nil, { RGB("FF69B4", 0.5) }, 4)
            frame:ClearAllPoints()
            frame:SetPoint("TOPLEFT", v.zb, "TOPLEFT", 0, 0)
            frame:SetPoint("BOTTOMRIGHT", v.jine, "BOTTOMRIGHT", 0, 0)
        end
        local t = frame:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 20, "OUTLINE")
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

    local num = tonumber(zhuangbei:GetText():match("(%d+%.-%d-)%%"))
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

function BG.UpdateZhiChuMan(zhuangbei, jine)
    zhuangbei.hasMan = nil
    jine.hasMan = nil
    local num = tonumber(zhuangbei:GetText():match("(%d+)人"))
    if num and num ~= 0 then
        local money = tonumber(jine:GetText()) or 0
        local tbl = {
            num = num,
            money = money,
            avg = floor(money / num),
        }
        zhuangbei.hasMan = tbl
        jine.hasMan = tbl

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
    if self.hasPercent or self.hasMan then
        if BG.ButtonIsInRight(self) then
            GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
        else
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
        end
        GameTooltip:ClearLines()
    end
    if self.hasPercent then
        GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
        GameTooltip:AddLine(format(L["该支出项含有百分比|cff00ff00（%s%%）|r，正在自动计算支出金额。"], self.hasPercent), 1, 0.82, 0, true)
        GameTooltip:AddLine(L["你可以通过删除支出项的百分比符号来取消自动计算，或者在表格设置里关闭该项功能。"], 0.5, 0.5, 0.5, true)
        if not self.hasMan then
            GameTooltip:Show()
        end
    end
    if self.hasMan then
        if self.hasPercent then
            GameTooltip:AddLine(" ", 1, 1, 1, true)
        end
        local money = self.hasMan.money
        local num = self.hasMan.num
        local avg = self.hasMan.avg
        GameTooltip:AddLine(L["该支出项含有人数"], 1, 1, 1, true)
        GameTooltip:AddLine(format(L["支出：%s"], money), 1, 0.82, 0, true)
        GameTooltip:AddLine(format(L["人数：%s人"], num), 1, 0.82, 0, true)
        GameTooltip:AddLine(format(L["每人：|cff00ff00%s|r"], avg), 1, 0.82, 0, true)
        GameTooltip:Show()
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
                for i = 1, BG.GetMaxi(FB, b) do
                    local zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                    local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
                    if zb and FB == v.FB and b == v.b and i == v.i then
                        local f = BG.CreateHighlightFrame(zb, nil, { 0, 1, 0, 0.5 }, 4)
                        f:ClearAllPoints()
                        f:SetPoint("TOPLEFT", zb, "TOPLEFT", 0, 0)
                        f:SetPoint("BOTTOMRIGHT", jine, "BOTTOMRIGHT", 0, 0)
                        local t = f:CreateFontString()
                        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                        t:SetPoint("LEFT", jine, "RIGHT", 2, 0)
                        t:SetTextColor(0, 1, 0)
                        t:SetText(L["打包交易"])
                    end
                end
            end
        end
    end
end

local function UpdateCancelDelete(self, FB, b, i, type)
    if self:GetText() == "" then return end
    BG.cancelDelete = {}
    BG.cancelDelete.type = type
    BG.cancelDelete.bt = self
    BG.cancelDelete.FB = FB
    BG.cancelDelete.b = b
    BG.cancelDelete.i = i
    BG.cancelDelete.text = self:GetText()
    if type == "zhuangbei" then
        BG.cancelDelete.loot = BG.Copy(BiaoGe[FB]["boss" .. b]["loot" .. i])
        BG.cancelDelete.guanzhu = BiaoGe[FB]["boss" .. b]["guanzhu" .. i]
    elseif type == "maijia" then
        for k, v in pairs(BG.playerClass) do
            BG.cancelDelete[k] = BiaoGe[FB]["boss" .. b][k .. i]
        end
    elseif type == "jine" then
    end
    BG.ButtonCancelDelete:Show()
    if BG.ButtonCancelDelete.OnUpdate then
        BG.ButtonCancelDelete.OnUpdate:SetScript("OnUpdate", nil)
    end
    BG.ButtonCancelDelete.OnUpdate = BG.OnUpdateTime(function(self, elapsed)
        self.timeElapsed = self.timeElapsed + elapsed
        if self.timeElapsed >= 5 then
            self:SetScript("OnUpdate", nil)
            BG.ButtonCancelDelete:Hide()
        end
    end)
end

-- 鼠标提示玩家的欠款和罚款
do
    local CD
    local function SetTooltip(unit)
        local name = BG.SPN(BG.GN(unit))
        local FB = BG.FB1
        local fkMoney = 0
        local qkMoney = 0
        BG.PairFBItem(function(item, buyer, money, b, i)
            if buyer:GetText() == name then
                if b == Maxb[FB] then
                    fkMoney = fkMoney + (tonumber(money:GetText()) or 0)
                end
                qkMoney = qkMoney + (tonumber(BiaoGe[FB]["boss" .. b]["qiankuan" .. i]) or 0)
            end
        end)
        if fkMoney ~= 0 then
            GameTooltip:AddLine(L["罚款："] .. BG.STC_w1(fkMoney), 1, .82, 0)
        end
        if qkMoney ~= 0 then
            GameTooltip:AddLine(L["欠款："] .. BG.STC_w1(qkMoney), 1, .82, 0)
        end
        if fkMoney ~= 0 or qkMoney ~= 0 then
            GameTooltip:Show()
        end
    end
    GameTooltip:HookScript("OnTooltipSetUnit", function(self)
        if BiaoGe.options["mouseFK"] ~= 1 then return end
        local unit = "mouseover"
        if not (UnitIsPlayer(unit) and UnitIsSameServer(unit)) then return end
        if CD then return end
        CD = true
        BG.After(0, function() CD = false end)
        SetTooltip(unit)
    end)

    hooksecurefunc(GameTooltip, "SetUnit", function(self, unit)
        if BiaoGe.options["mouseFK"] ~= 1 then return end
        if not (UnitIsPlayer(unit) and UnitIsSameServer(unit)) then return end
        if CD then return end
        CD = true
        BG.After(0, function() CD = false end)
        SetTooltip(unit)
    end)
end

------------------标题------------------
function BG.FBTitleUI(FB, t)
    local fontsize = 15
    local parent = BG["Frame" .. FB]
    local version = parent:CreateFontString()
    if t == 1 then
        version:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 13, -60)
    else
        version:SetPoint("TOPLEFT", frameright, "TOPLEFT", 100, 0)
    end
    version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    version:SetText(L["  项目"])
    preWidget = version

    local version = parent:CreateFontString()
    version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 70, 0)
    version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    version:SetText(L["装备"])
    preWidget = version
    p.preWidget0 = version

    local version = parent:CreateFontString()
    version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 155, 0)
    version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    version:SetText(L["买家"])
    preWidget = version

    local version = parent:CreateFontString()
    version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 95, 0)
    version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    version:SetText(L["金额"])
    preWidget = version
    frameright = version
end

------------------装备------------------
local updateFrame = CreateFrame("Frame")
local function OnTextChanged(self)
    local FB = self.FB
    local t = self.t
    local b = self.b
    local i = self.i
    local bossnum = self.bossnum
    local itemText = self:GetText()
    local itemID = GetItemID(itemText)
    if itemID then
        local item = Item:CreateFromItemID(itemID)
        item:ContinueOnItemLoad(function()
            local name, link, quality, level, _, _, _, _, _, Texture,
            _, typeID, _, bindType = GetItemInfo(itemText)
            if FB == "ULD" and not itemText:match("H$") then
                local hard
                for index, value in ipairs(BG.Loot.ULD.Hard10) do
                    if itemID == value then
                        self:SetText(itemText .. "H")
                        hard = true
                        break
                    end
                end
                if not hard then
                    for index, value in ipairs(BG.Loot.ULD.Hard25) do
                        if itemID == value then
                            self:SetText(itemText .. "H")
                            break
                        end
                    end
                end
            elseif FB == "ICC" and not itemText:match("H$") then
                if itemID == 52030 or itemID == 52029 or itemID == 52028 then
                    self:SetText(link .. "H")
                end
            end
            self.icon:SetTexture(Texture)
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["itemLevel" .. i] = level
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["bindOnEquip" .. i] = bindType == 2 and true or nil
            BG.BindOnEquip(self, bindType)
            BG.LevelText(self, level, typeID)
            BG.IsHave(self)
        end)
    else
        self.icon:SetTexture(nil)
        BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["itemLevel" .. i] = nil
        BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["bindOnEquip" .. i] = nil
        BG.BindOnEquip(self)
        BG.LevelText(self)
        BG.IsHave(self)
    end

    BG.UpdateFilter(self)

    if bossnum ~= Maxb[FB] and bossnum ~= Maxb[FB] + 1 and bossnum ~= Maxb[FB] + 2 then
        BG.DuiZhangFrame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i]:SetText(itemText)
    end

    if itemText ~= "" then
        BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i] = itemText
    else
        BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i] = nil
        BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i] = nil
        BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i]:Hide()
        BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["loot" .. i] = nil
    end

    -- 支出百分比
    if bossnum == Maxb[FB] + 1 then
        local jine = BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]
        BG.UpdateZhiChuPercent(self, jine)
        BG.UpdateZhiChuMan(self, jine)
    end

    -- 更新未拍
    if BiaoGe.options.auctionLogChoose == 4 then
        updateFrame.t = 0
        updateFrame:SetScript("OnUpdate", function(self, t)
            self.t = self.t + t
            if self.t >= 0.1 then
                BG.UpdateAuctionLogFrame(nil, true)
                updateFrame:SetScript("OnUpdate", nil)
            end
        end)
    end
end
function BG.FBZhuangBeiUI(FB, t, b, bb, i, ii, scrollFrame)
    local parent = scrollFrame or BG["Frame" .. FB]
    local bt = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    if BossNum(FB, b, t) <= Maxb[FB] then
        bt:SetSize(150, 20)
    else
        bt:SetSize(245, 20)
    end
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
                bt:SetPoint("TOPLEFT", p["preWidget" .. i - 1], "BOTTOMLEFT", 0, BG.IsBigFB(FB) and 0 or -3)
            end
        end
    end
    bt:SetAutoFocus(false)
    bt.FB = FB
    bt.bossnum = BossNum(FB, b, t)
    bt.t = t
    bt.b = b
    bt.i = i
    bt.type = "zhuangbei"
    bt.icon = bt:CreateTexture(nil, 'ARTWORK')
    bt.icon:SetPoint('LEFT', -22, 0)
    bt.icon:SetSize(16, 16)
    if BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i] then
        if BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i] ~= "" then
            bt:SetText(BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i])
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

    if bt.bossnum == Maxb[FB] + 1 then
        BG.After(0, function()
            local jine = BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]
            BG.UpdateZhiChuPercent(bt, jine)
            BG.UpdateZhiChuMan(bt, jine)
        end)
    end

    -- 内容改变时
    bt:SetScript("OnTextChanged", OnTextChanged)
    -- 鼠标按下时
    bt:SetScript("OnMouseDown", function(self, button)
        if button == "RightButton" and not IsAltKeyDown() and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i] then
            UpdateCancelDelete(self, FB, BossNum(FB, b, t), i, self.type)
            self:SetEnabled(false)
            self:SetText("")
            BG.Hide_AllHighlight()
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
                BG.InsertLink(self:GetText())
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
                    BG.StartAuction(link, self, nil, nil, button == "RightButton")
                else -- 关注装备
                    if button ~= "RightButton" then
                        BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i] = true
                        BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i]:Show()
                    end
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
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i] then
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
            local link = self:GetText()
            local itemID = GetItemID(link)
            BG.Show_AllHighlight(link, "biaoge")
            if itemID then
                if BG.ButtonIsInRight(self) then
                    GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
                else
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                end
                GameTooltip:ClearLines()
                GameTooltip:SetHyperlink(BG.SetSpecIDToLink(link))

                local _r, _g, _b = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i]:GetTextColor()
                BG.SetHistoryMoney(
                    itemID,
                    BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i]:GetText(),
                    BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i]:GetText(),
                    _r, _g, _b
                )

                HighlightBiaoGeSameItems(itemID, self)

                BG.DressUpLastButton = self
                if IsAltKeyDown() and IsControlKeyDown() then
                    SetCursor(nil)
                elseif IsControlKeyDown() then
                    SetCursor("Interface/Cursor/Inspect")
                    BG.DressUp()
                elseif IsAltKeyDown() then
                    if BG.IsML then
                        if BiaoGe.options["autoAuctionStart"] == 1 then
                            SetCursor("interface/cursor/repair")
                        end
                    else
                        SetCursor("interface/cursor/quest")
                    end
                end
                BG.canShowTrunToItemLibCursor = true
                if BG.IsML then
                    BG.canShowStartAuctionCursor = true
                else
                    BG.canShowHopeCursor = true
                end
            end
        end
        OnEnterZhiChuPercent(self)
    end)
    bt:SetScript("OnLeave", function(self)
        self.isEnter = false
        BG.FrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
        GameTooltip:Hide()
        BG.HideHistoryMoney()
        BG.Hide_AllHighlight()
        SetCursor(nil)
        BG.canShowTrunToItemLibCursor = false
        BG.canShowStartAuctionCursor = false
        BG.canShowHopeCursor = false
        if BG.DressUpFrame then
            BG.DressUpFrame:Hide()
        end
        BG.DressUpLastButton = nil
    end)
    -- 获得光标时
    bt:SetScript("OnEditFocusGained", function(self)
        BG.FrameHide(1)
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
        if BG.Frame[FB]["boss" .. b]["maijia" .. i]:IsVisible() then
            BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetFocus()
        else
            BG.Frame[FB]["boss" .. b]["jine" .. i]:SetFocus()
        end
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
                    for ii = BG.GetMaxi(FB, b), 1, -1 do
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
                if BG.Frame[FB]["boss" .. b]["maijia" .. i]:IsVisible() then
                    BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetFocus()
                else
                    BG.Frame[FB]["boss" .. b]["jine" .. i]:SetFocus()
                end
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
                    for ii = BG.GetMaxi(FB, b), 1, -1 do
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
                    for ii = BG.GetMaxi(FB, b), 1, -1 do
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
    bt:SetAutoFocus(false)
    bt.FB = FB
    bt.bossnum = BossNum(FB, b, t)
    bt.t = t
    bt.b = b
    bt.i = i
    bt.type = "maijia"
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
    if BossNum(FB, b, t) <= Maxb[FB] then
        preWidget = bt
    else
        bt:Hide()
    end
    BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i] = bt
    -- 当内容改变时
    bt:SetScript("OnTextChanged", function(self)
        if bt:GetText() ~= "" then
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i] = self:GetText()         -- 储存文本
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["color" .. i] = { self:GetTextColor() } -- 储存颜色
        else
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i] = nil
            for k, v in pairs(BG.playerClass) do
                BiaoGe[FB]["boss" .. BossNum(FB, b, t)][k .. i] = nil
            end
            self:SetTextColor(1, 1, 1)
        end
    end)

    bt:SetScript("OnMouseDown", function(self, enter)
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["maijia" .. i] then
            UpdateCancelDelete(self, FB, BossNum(FB, b, t), i, self.type)
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
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["maijia" .. i] then
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
        BG.FrameHide(1)
        bt:HighlightText()
        BG.lastfocus = self
        BG.maijiaButton = self
        BG.SetListmaijia(self)
        BG.FrameDs[FB .. 2]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show() -- 底色
        if BG.FrameAuctionMSGbg then
            BG.FrameAuctionMSG.item = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i]:GetText()
            if BiaoGe.options["auctionChatHoldNew"] == 1 then
                BG.FrameAuctionMSG:ScrollToBottom()
            end
            if BiaoGe.options["auctionChat"] == 1 then
                BG.FrameAuctionMSGbg:Show()
            else
                BG.FrameAuctionMSGbg:Hide()
            end
            BG.FrameAuctionMSGbg:SetParent(BG.FrameMaijiaList)
            BG.FrameAuctionMSGbg:ClearAllPoints()
            BG.FrameAuctionMSGbg:SetPoint("TOPRIGHT", BG.FrameMaijiaList, "TOPLEFT", 2, 0)
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
                        b = Maxb[FB] + 1
                    end
                    local i
                    for ii = BG.GetMaxi(FB, b), 1, -1 do
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
                    if b == Maxb[FB] then
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
                    b = Maxb[FB] + 1
                end
                if BG.Frame[FB]["boss" .. b - 1]["maijia" .. i] then
                    BG.Frame[FB]["boss" .. b - 1]["maijia" .. i]:SetFocus()
                else
                    local i
                    for ii = BG.GetMaxi(FB, b), 1, -1 do
                        if BG.Frame[FB]["boss" .. b - 1]["maijia" .. ii] then
                            i = ii
                            break
                        end
                    end
                    BG.Frame[FB]["boss" .. b - 1]["maijia" .. i]:SetFocus()
                end
            elseif enter == "DOWN" then -- 下↓
                local b = b
                if b == Maxb[FB] then
                    b = 0
                end
                if BG.Frame[FB]["boss" .. b + 1]["maijia" .. i] then
                    BG.Frame[FB]["boss" .. b + 1]["maijia" .. i]:SetFocus()
                else
                    local i
                    for ii = BG.GetMaxi(FB, b), 1, -1 do
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
    bt:SetAutoFocus(false)
    bt:Show()
    bt.FB = FB
    bt.bossnum = BossNum(FB, b, t)
    bt.t = t
    bt.b = b
    bt.i = i
    bt.type = "jine"
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

        if self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. 4] then
            BG.UpdateTwo0(self)
        end

        if bossnum ~= Maxb[FB] and bossnum ~= Maxb[FB] + 1 and bossnum ~= Maxb[FB] + 2 then
            BG.DuiZhangFrame[FB]["boss" .. BossNum(FB, b, t)]["myjine" .. i]:SetText(self:GetText())
        end

        if bt:GetText() ~= "" then
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i] = bt:GetText() -- 储存文本
        else
            BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i] = nil
        end
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine1"]:SetText(BG.GetTotalIncome())      -- 计算总收入
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine2"]:SetText(BG.GetTotalExpenditure()) -- 计算总支出
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine3"]:SetText(BG.GetNetIncome())        -- 计算净收入
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine5"]:SetText(BG.GetWages())            -- 计算人均工资

        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine1"]:SetCursorPosition(0)
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine2"]:SetCursorPosition(0)
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine3"]:SetCursorPosition(0)
        BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine5"]:SetCursorPosition(0)

        -- 支出百分比
        if bossnum == Maxb[FB] + 1 then
            local zhuangbei = BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i]
            BG.UpdateZhiChuPercent(zhuangbei, self)
            BG.UpdateZhiChuMan(zhuangbei, self)
        end
        if self == BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine1"] then
            for i = 1, BG.GetMaxi(FB, Maxb[FB] + 1) do
                local zhuangbei = BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i]
                local jine = BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]
                if zhuangbei then
                    BG.UpdateZhiChuPercent(zhuangbei, jine)
                end
            end
        end
    end)
    bt:SetScript("OnMouseDown", function(self, enter)
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i] then
            UpdateCancelDelete(self, FB, BossNum(FB, b, t), i, self.type)
            BG.FrameHide(1)
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
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i] then
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
        BG.Hide_AllHighlight()
    end)
    -- 获得光标时
    bt:SetScript("OnEditFocusGained", function(self)
        BG.FrameHide(1)
        bt:HighlightText()
        BG.lastfocus = self
        BG.maijiaButton = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i]
        BG.FrameDs[FB .. 2]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show() -- 底色
        if self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i] and self ~= BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i] then
            BG.SetListjine(self, FB, BossNum(FB, b, t), i)
            BG.CreateNumFrame(BG.FrameJineList)
        end
        if BG.FrameAuctionMSGbg then
            BG.FrameAuctionMSG.item = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i]:GetText()
            if BiaoGe.options["auctionChatHoldNew"] == 1 then
                BG.FrameAuctionMSG:ScrollToBottom()
            end
            if BiaoGe.options["auctionChat"] == 1 then
                BG.FrameAuctionMSGbg:Show()
            else
                BG.FrameAuctionMSGbg:Hide()
            end
            BG.FrameAuctionMSGbg:SetParent(BG.FrameJineList)
            BG.FrameAuctionMSGbg:ClearAllPoints()
            BG.FrameAuctionMSGbg:SetPoint("TOPRIGHT", BG.FrameJineList, "TOPLEFT", 2, 0)
        end
    end)
    -- 失去光标时
    bt:SetScript("OnEditFocusLost", function(self)
        self:ClearHighlightText()
        BG.FrameDs[FB .. 2]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
        if BG.FrameNumFrame then
            BG.FrameNumFrame:Hide()
        end
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
                    for ii = BG.GetMaxi(FB, b), 1, -1 do
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
            elseif enter == "LEFT" then -- 左←
                if BG.Frame[FB]["boss" .. b]["maijia" .. i]:IsVisible() then
                    BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetFocus()
                else
                    BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:SetFocus()
                end
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
                    for ii = BG.GetMaxi(FB, b), 1, -1 do
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
                    for ii = BG.GetMaxi(FB, b), 1, -1 do
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
    local fontsize = 14
    local boss = BossNum(FB, b, t)
    local f = CreateFrame("Frame", nil, BG["Frame" .. FB])
    if frameName and BG[frameName .. FB]["scrollFrame" .. boss] then
        f:SetPoint("TOP", BG[frameName .. FB]["scrollFrame" .. boss].owner, "TOPLEFT", -40, -2)
    else
        f:SetPoint("TOP", BG.Frame[FB]["boss" .. boss].zhuangbei1, "TOPLEFT", -45, -2)
    end
    f:SetSize(15, 40)
    f.text = f:CreateFontString()
    f.text:SetPoint("CENTER")
    f.text:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
    f.text:SetTextColor(RGB(BG.Boss[FB]["boss" .. boss].color))
    f.text:SetText(BG.Boss[FB]["boss" .. boss].name)
    f:SetSize(f.text:GetStringWidth() - 5, f.text:GetStringHeight())
    BG.Frame[FB]["boss" .. boss].bossName = f
    if FB == "ICC" and boss <= 13 then
        f:SetScript("OnMouseUp", function(self)
            if IsShiftKeyDown() then
                local b = boss
                BG.ClickTabButton(BG.BossMainFrameTabNum)
                for i, v in ipairs(BG["BossTabButtons" .. FB]) do
                    v:Enable()
                    v.spellScrollFrame:Hide()
                    v.classScrollFrame:Hide()
                end
                BG["BossTabButtons" .. FB][b]:Disable()
                BG["BossTabButtons" .. FB][b].spellScrollFrame:Show()
                BG["BossTabButtons" .. FB][b].classScrollFrame:Show()
                BiaoGe.BossFrame[FB].lastFrame = b
                BG.PlaySound(1)
            end
            BG.MainFrame:GetScript("OnMouseUp")(BG.MainFrame)
        end)
        f:SetScript("OnMouseDown", function(self)
            BG.MainFrame:GetScript("OnMouseDown")(BG.MainFrame)
        end)
        f:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine("|cff" .. BG.Boss[FB]["boss" .. boss].color .. BG.Boss[FB]["boss" .. boss].name2 .. RR)
            GameTooltip:AddLine(L["SHIFT+点击：查看该BOSS攻略"], 1, .82, 0)
            GameTooltip:Show()
            f.text:SetTextColor(1, 1, 1)
        end)
        f:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
            f.text:SetTextColor(RGB(BG.Boss[FB]["boss" .. boss].color))
        end)
    end

    if BG.Frame[FB]["boss" .. boss] == BG.Frame[FB]["boss" .. Maxb[FB] + 2] then
        local text = BG["Frame" .. FB]:CreateFontString()
        text:SetPoint("BOTTOM", BG.Frame[FB]["boss" .. Maxb[FB] + 2].zhuangbei5, "BOTTOMLEFT", -45, 7)
        text:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
        text:SetTextColor(RGB("00BFFF"))
        text:SetText(L["工\n资"])
    end
end

------------------击杀用时------------------
function BG.FBJiShaUI(FB, t, b, bb, i, ii)
    if BossNum(FB, b, t) > Maxb[FB] - 2 then return end
    local text = BG["Frame" .. FB]:CreateFontString()
    local num
    for i = 1, BG.GetMaxi(FB, BossNum(FB, b, t)) do
        if not BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i + 1] then
            num = i
            break
        end
    end
    text:SetPoint("TOPLEFT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. num], "BOTTOMLEFT", -0, -3)
    text:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE,THICK")
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
        BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei1"]:SetText(L["T补贴"])
    end
    if not BiaoGe[FB]["boss" .. Maxb[FB] + 1]["zhuangbei2"] then
        BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei2"]:SetText(L["N补贴"])
    end
    if not BiaoGe[FB]["boss" .. Maxb[FB] + 1]["zhuangbei3"] then
        BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei3"]:SetText(L["DPS补贴"])
    end
    if BG.IsWLK then
        if not BiaoGe[FB]["boss" .. Maxb[FB] + 1]["zhuangbei4"] then
            BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei4"]:SetText(L["放鱼补贴"])
        end
    end
    -- 设置支出颜色：绿
    for i = 1, BG.GetMaxi(FB, Maxb[FB] + 1), 1 do
        if BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i] then
            BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i]:SetTextColor(RGB("00FF00"))
            BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]:SetTextColor(RGB("00FF00"))
        end
    end

    -- 总览和工资
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei1"]:SetScript("OnTextChanged", function(self)
        self:SetText(L["总收入"])
        BiaoGe[FB]["boss" .. Maxb[FB] + 2]["zhuangbei1"] = self:GetText()
    end)
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei2"]:SetScript("OnTextChanged", function(self)
        self:SetText(L["总支出"])
        BiaoGe[FB]["boss" .. Maxb[FB] + 2]["zhuangbei2"] = self:GetText()
    end)
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei3"]:SetScript("OnTextChanged", function(self)
        self:SetText(L["净收入"])
        BiaoGe[FB]["boss" .. Maxb[FB] + 2]["zhuangbei3"] = self:GetText()
    end)
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei4"]:SetScript("OnTextChanged", function(self)
        self:SetText(L["分钱人数"])
        BiaoGe[FB]["boss" .. Maxb[FB] + 2]["zhuangbei4"] = self:GetText()
    end)
    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei5"]:SetScript("OnTextChanged", function(self)
        self:SetText(L["人均工资"])
        BiaoGe[FB]["boss" .. Maxb[FB] + 2]["zhuangbei5"] = self:GetText()
    end)
    if BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine4"]:GetText() == "" then
        if BG.IsVanilla then
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

    -- 修复默认支出名称
    local b = Maxb[FB] + 1
    for i = 1, BG.GetMaxi(FB, b) do
        local zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
        if zb then
            zb:SetText(zb:GetText():gsub(L["坦克补贴"], L["T补贴"]))
            zb:SetText(zb:GetText():gsub(L["治疗补贴"], L["N补贴"]))
            zb:SetText(zb:GetText():gsub(L["输出补贴"], L["DPS补贴"]))
        end
    end
end

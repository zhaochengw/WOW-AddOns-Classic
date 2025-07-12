local _, ns = ...

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

local p = {}
local preWidget
local framedown
local frameright
local red, greed, blue = 1, 1, 1
local touming1, touming2, touming3 = 0.1, 0.1, BG.highLightAlpha

local function ShowTardeHighLightItem_MyJine(self)
    local b = self.bossnum
    local i = self.i
    local FB = BG.FB1
    local tradeInfo = BG.GetGeZiTardeInfo(FB, b, i)
    if tradeInfo then
        for _, v in ipairs(tradeInfo) do
            for b = 1, Maxb[FB] do
                for i = 1, BG.GetMaxi(FB, b) do
                    local myjine = BG.DuiZhangFrame[FB]["boss" .. b]["myjine" .. i]
                    if myjine and FB == v.FB and b == v.b and i == v.i then
                        local f = BG.CreateHighlightFrame(myjine, nil, { 0, 1, 0, 0.5 }, 4)
                        f:ClearAllPoints()
                        f:SetPoint("TOPLEFT", myjine, "TOPLEFT", -5, 0)
                        f:SetPoint("BOTTOMRIGHT", myjine, "BOTTOMRIGHT", 0, 0)
                    end
                end
            end
        end
    end
end

local function ShowTardeHighLightItem_OtherJine(self)
    local b = self.bossnum
    local i = self.i
    local FB = BG.FB1
    if self.tradeTbl then
        for i, v in ipairs(self.tradeTbl) do
            local otherjine = BG.DuiZhangFrame[FB]["boss" .. v.b]["otherjine" .. v.i]
            local f = BG.CreateHighlightFrame(otherjine, nil, { 0, 1, 0, 0.5 }, 4)
            f:ClearAllPoints()
            f:SetPoint("TOPLEFT", otherjine, "TOPLEFT", -5, 0)
            f:SetPoint("BOTTOMRIGHT", otherjine, "BOTTOMRIGHT", 0, 0)
        end
    end
end


------------------标题------------------
function BG.DuiZhangBiaoTiUI(FB, t, b, bb, i, ii)
    local fontsize = 15
    if b == 1 and i == 1 then
        local version = BG["DuiZhangFrame" .. FB]:CreateFontString()
        if t == 1 then
            version:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 13, -60)
        else
            version:SetPoint("TOPLEFT", frameright, "TOPLEFT", 105, 0)
        end
        version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.y2))
        version:SetText(L["  项目"])
        preWidget = version

        local version = BG["DuiZhangFrame" .. FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 70, 0);
        version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.y2))
        version:SetText(L["装备"])
        preWidget = version
        p.preWidget0 = version

        local version = BG["DuiZhangFrame" .. FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 155, 0);
        version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.y2))
        version:SetText(L["我的金额"])
        version:SetTextColor(RGB("00BFFF"))
        preWidget = version

        local version = BG["DuiZhangFrame" .. FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 90, 0);
        version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.y2))
        version:SetText(L["对方金额"])
        version:SetTextColor(RGB("FF69B4"))
        preWidget = version
        frameright = version
    end
end

------------------装备------------------
local function OnTextChanged(self)
    local FB = self.FB
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
            BG.BindOnEquip(self, bindType)
            BG.LevelText(self, level, typeID)
            BG.IsHave(self)
        end)
    else
        self.icon:SetTexture(nil)
        BG.BindOnEquip(self)
        BG.LevelText(self)
        BG.IsHave(self)
    end
end
function BG.DuiZhangZhuangBeiUI(FB, t, b, bb, i, ii)
    local bt = CreateFrame("EditBox", nil, BG["DuiZhangFrame" .. FB], "InputBoxTemplate");
    bt:SetSize(150, 20)
    bt:SetFrameLevel(110)
    if BG.zaxiang[FB] and BossNum(FB, b, t) == Maxb[FB] - 1 and i == BG.zaxiang[FB].i then
        bt:SetPoint("TOPLEFT", frameright, "TOPLEFT", 170, -18)
    else
        if b > 1 and i == 1 then
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
    bt:SetEnabled(false)
    BG.SetBorderAlpha(bt)
    local b = BossNum(FB, b, t)
    bt.icon = bt:CreateTexture(nil, 'ARTWORK')
    bt.icon:SetPoint('LEFT', -22, 0)
    bt.icon:SetSize(16, 16)
    if BiaoGe[FB]["boss" .. b]["zhuangbei" .. i] and b ~= Maxb[FB] and b ~= Maxb[FB] + 1 then
        bt:SetText(BiaoGe[FB]["boss" .. b]["zhuangbei" .. i])
    end
    BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i] = bt
    preWidget = bt
    p["preWidget" .. i] = bt
    framedown = p["preWidget" .. ii]

    if bt == BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei1"] then
        bt:SetText(L["装备总收入"])
        bt:SetTextColor(RGB("00FF00"))
    end
    if bt == BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei2"] then
        bt:SetText(L["差额"])
        bt:SetTextColor(RGB("00FF00"))
    end

    -- 内容改变时
    bt:SetScript("OnTextChanged", OnTextChanged)
    -- 发送装备到聊天输入框
    bt:SetScript("OnMouseDown", function(self, enter)
        if IsShiftKeyDown() then
            BG.InsertLink(self:GetText())
        end
    end)
    -- 鼠标悬停在装备时
    bt:SetScript("OnEnter", function(self)
        BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i]:Show()
        if not tonumber(self:GetText()) then
            local link = bt:GetText()
            local itemID = select(1, GetItemID(link))
            BG.Hide_AllHighlight()
            BG.HighlightBag(link)
            BG.HighlightChatFrame(link)
            BG.HighlightItemOutTime(link)
            BG.HighlightItemAuctionLog(link)
            if itemID then
                if BG.ButtonIsInRight(self) then
                    GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
                else
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                end
                GameTooltip:ClearLines()
                GameTooltip:SetHyperlink(BG.SetSpecIDToLink(link))
            end
        end
    end)
    bt:SetScript("OnLeave", function(self)
        BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i]:Hide()
        GameTooltip:Hide()
    end)
end

------------------我的金额------------------
function BG.DuiZhangMyJinEUI(FB, t, b, bb, i, ii)
    local b = BossNum(FB, b, t)
    local bt = CreateFrame("EditBox", nil, BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i], "InputBoxTemplate");
    bt:SetSize(85, 20)
    bt:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 5, 0);
    bt:SetFrameLevel(110)
    bt:SetAutoFocus(false)
    bt:SetEnabled(false)
    bt:SetTextColor(RGB("00BFFF"))
    BG.SetBorderAlpha(bt)
    bt.FB = FB
    bt.bossnum = b
    bt.t = t
    bt.i = i
    if BiaoGe[FB]["boss" .. b]["jine" .. i] and b ~= Maxb[FB] and b ~= Maxb[FB] + 1 then
        bt:SetText(BiaoGe[FB]["boss" .. b]["jine" .. i])
    end
    preWidget = bt
    BG.DuiZhangFrame[FB]["boss" .. b]["myjine" .. i] = bt

    bt:SetScript("OnTextChanged", function(self)
        local sum = 0
        local n = 0
        for b = 1, Maxb[FB] - 1, 1 do
            for i = 1, BG.GetMaxi(FB, b), 1 do
                local myjine = BG.DuiZhangFrame[FB]["boss" .. b]["myjine" .. i]
                if myjine then
                    n = tonumber(myjine:GetText())
                    if n then
                        sum = sum + n
                    end
                end
            end
        end
        if sum == 0 then
            sum = ""
        end
        BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["myjine1"]:SetText(sum)

        C_Timer.After(0.02, function()
            local myjine = tonumber(BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["myjine1"]:GetText())
            local otherjine = tonumber(BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["otherjine1"]:GetText())
            if myjine and otherjine then
                if myjine > otherjine then
                    local c = myjine - otherjine
                    BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["myjine2"]:SetText("")
                    BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["otherjine2"]:SetText(c)
                elseif myjine < otherjine then
                    local c = otherjine - myjine
                    BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["myjine2"]:SetText(c)
                    BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["otherjine2"]:SetText("")
                elseif myjine == otherjine then
                    BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["myjine2"]:SetText("")
                    BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["otherjine2"]:SetText("")
                end
            else
                BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["myjine2"]:SetText("")
                BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["otherjine2"]:SetText("")
            end
        end)
    end)
    -- 鼠标悬停在装备时
    bt:SetScript("OnEnter", function(self)
        BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i]:Show()
        ShowTardeHighLightItem_MyJine(self)
        local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetText()
        if maijia ~= "" and self:GetText() ~= "" then
            local r, g, b = BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetTextColor()
            if BG.ButtonIsInRight(self) then
                GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
            else
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
            end
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["|cffFFFFFF买家：|r"] .. maijia, r, g, b, true)
            GameTooltip:Show()
        end
    end)
    bt:SetScript("OnLeave", function(self)
        BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i]:Hide()
        GameTooltip:Hide()
        BG.Hide_AllHighlight()
    end)
end

------------------别人的金额------------------
function BG.DuiZhangOtherJinEUI(FB, t, b, bb, i, ii)
    local b = BossNum(FB, b, t)
    local bt = CreateFrame("EditBox", nil, BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i], "InputBoxTemplate");
    bt:SetSize(85, 20)
    bt:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 5, 0);
    bt:SetFrameLevel(110)
    bt:SetAutoFocus(false)
    bt:SetEnabled(false)
    bt:SetTextColor(RGB("FF69B4"))
    BG.SetBorderAlpha(bt)
    bt.FB = FB
    bt.bossnum = b
    bt.t = t
    bt.i = i
    preWidget = bt
    BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i] = bt

    local texture = bt:CreateTexture()
    texture:SetSize(16, 16)
    texture:SetPoint("RIGHT", 16, 0)
    BG.DuiZhangFrame[FB]["boss" .. b]["yes" .. i] = texture

    bt:SetScript("OnTextChanged", function(self)
        local sum = 0
        local n = 0
        for b = 1, Maxb[FB], 1 do
            for i = 1, BG.GetMaxi(FB, b), 1 do
                local otherjine = BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i]
                if otherjine then
                    n = tonumber(otherjine:GetText())
                    if n then
                        sum = sum + n
                    end
                end
            end
        end
        if sum == 0 then
            sum = ""
        end
        BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["otherjine1"]:SetText(sum)

        C_Timer.After(0.02, function()
            local myjine = tonumber(BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["myjine1"]:GetText())
            local otherjine = tonumber(BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["otherjine1"]:GetText())
            if myjine and otherjine then
                if myjine > otherjine then
                    local c = myjine - otherjine
                    BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["myjine2"]:SetText("")
                    BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["otherjine2"]:SetText(c)
                elseif myjine < otherjine then
                    local c = otherjine - myjine
                    BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["myjine2"]:SetText(c)
                    BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["otherjine2"]:SetText("")
                elseif myjine == otherjine then
                    BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["myjine2"]:SetText("")
                    BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["otherjine2"]:SetText("")
                end
            else
                BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["myjine2"]:SetText("")
                BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 1]["otherjine2"]:SetText("")
            end
        end)
    end)
    -- 鼠标悬停在装备时
    bt:SetScript("OnEnter", function(self)
        BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i]:Show()
        ShowTardeHighLightItem_OtherJine(self)
        local maijia = BG.DuiZhangFrame[FB]["boss" .. b]["maijia" .. i]
        local color = BG.DuiZhangFrame[FB]["boss" .. b]["color" .. i]
        if maijia and color and self:GetText() ~= "" then
            local r, g, b = unpack(color)
            if BG.ButtonIsInRight(self) then
                GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
            else
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
            end
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["|cffFFFFFF买家：|r"] .. maijia, r, g, b, true)
            GameTooltip:Show()
        end
    end)
    bt:SetScript("OnLeave", function(self)
        BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i]:Hide()
        GameTooltip:Hide()
        BG.Hide_AllHighlight()
    end)
end

------------------底色材质------------------
function BG.DuiZhangDiSeUI(FB, t, b, bb, i, ii)
    local b = BossNum(FB, b, t)
    local textrue = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]:CreateTexture()
    textrue:SetPoint("TOPLEFT", BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i], "TOPLEFT", -4, -2)
    textrue:SetPoint("BOTTOMRIGHT", BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i], "BOTTOMRIGHT", -2, 0)
    -- textrue:SetColorTexture(red, greed, blue, touming1)
    textrue:Hide()
    BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i] = textrue

    local textrue = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]:CreateTexture()
    textrue:SetPoint("TOPLEFT", BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i], "TOPLEFT", -4, -2)
    textrue:SetPoint("BOTTOMRIGHT", BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i], "BOTTOMRIGHT", -2, 0)
    textrue:SetColorTexture(1, 0, 0, touming3)
    textrue:Hide()
    BG.DuiZhangFrameDs[FB .. 3]["boss" .. b]["ds" .. i] = textrue
end

------------------BOSS名字------------------
function BG.DuiZhangBossNameUI(FB, t, b, bb, i, ii)
    local fontsize = 14
    local b = BossNum(FB, b, t)
    local version = BG["DuiZhangFrame" .. FB]:CreateFontString()
    version:SetPoint("TOP", BG.DuiZhangFrame[FB]["boss" .. b].zhuangbei1, "TOPLEFT", -45, -2)
    version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    if b == Maxb[FB] then
        version:SetText(BG.STC_r1(L["你\n漏\n记\n的\n装\n备"]))
    elseif b == Maxb[FB] + 1 then
        version:SetText(BG.STC_g1(L["总\n结"]))
    else
        version:SetText("|cff" .. BG.Boss[FB]["boss" .. b].color .. BG.Boss[FB]["boss" .. b].name .. RR)
    end
    BG.DuiZhangFrame[FB]["boss" .. b]["name"] = version
    if BG.DuiZhangFrame[FB]["boss" .. b] == BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 2] then
        local version = BG["DuiZhangFrame" .. FB]:CreateFontString()
        version:SetPoint("BOTTOM", BG.DuiZhangFrame[FB]["boss" .. Maxb[FB] + 2].zhuangbei5, "BOTTOMLEFT", -45, 7)
        version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB("00BFFF"))
        version:SetText(L["工\n资"])
    end
end

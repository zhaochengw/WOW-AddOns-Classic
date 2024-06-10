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

local pt = print

local p = {}
local preWidget
local framedown
local frameright
local red, greed, blue = 1, 1, 1
local touming1, touming2, touming3 = 0.1, 0.1, BG.highLightAlpha

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
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.y2))
        version:SetText(L["  项目"])
        preWidget = version

        local version = BG["DuiZhangFrame" .. FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 70, 0);
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.y2))
        version:SetText(L["装备"])
        preWidget = version
        p.preWidget0 = version

        local version = BG["DuiZhangFrame" .. FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 155, 0);
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB(BG.y2))
        version:SetText(L["我的金额"])
        version:SetTextColor(RGB("00BFFF"))
        preWidget = version

        local version = BG["DuiZhangFrame" .. FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 90, 0);
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
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
    local itemID = GetItemInfoInstant(itemText)
    local name, link, quality, level, _, _, _, _, _, Texture, _, typeID, _, bindType
    if itemID then
        name, link, quality, level, _, _, _, _, _, Texture, _, typeID, _, bindType = GetItemInfo(itemID)
    end

    local hard
    if link and itemText:find("item:") then
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

    -- 装绑图标
    BG.BindOnEquip(self, bindType)
    -- 在按钮右边增加装等显示
    BG.LevelText(self, level, typeID)
    -- 已拥有图标
    BG.IsHave(self)
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
                bt:SetPoint("TOPLEFT", p["preWidget" .. i - 1], "BOTTOMLEFT", 0, -3)
            end
        end
    end
    bt:SetAutoFocus(false)
    bt:SetEnabled(false)
    local b = BossNum(FB, b, t)
    bt.icon = bt:CreateTexture(nil, 'ARTWORK')
    bt.icon:SetPoint('LEFT', -22, 0)
    bt.icon:SetSize(16, 16)
    if BiaoGe[FB]["boss" .. b]["zhuangbei" .. i] and b ~= Maxb[FB] and b ~= Maxb[FB] + 1 then
        bt:SetText(BiaoGe[FB]["boss" .. b]["zhuangbei" .. i])
        BG.EditItemCache(bt, OnTextChanged)
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
            local f = GetCurrentKeyBoardFocus()
            if not f then
                ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
            end
            local text = self:GetText()
            ChatEdit_InsertLink(text)
        end
    end)
    -- 鼠标悬停在装备时
    bt:SetScript("OnEnter", function(self)
        BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i]:Show()
        if not tonumber(self:GetText()) then
            local itemLink = bt:GetText()
            local itemID = select(1, GetItemInfoInstant(itemLink))
            if itemID then
                if BG.ButtonIsInRight(self) then
                    GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
                else
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                end
                GameTooltip:ClearLines()
                GameTooltip:SetItemByID(itemID);
                GameTooltip:Show()
            end
        end
    end)
    bt:SetScript("OnLeave", function(self)
        BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i]:Hide()
        GameTooltip:Hide()
        if BG["HistoryJineFrameDB1"] then
            for i = 1, BG.HistoryJineFrameDBMax do
                BG["HistoryJineFrameDB" .. i]:Hide()
            end
            BG.HistoryJineFrame:Hide()
        end
    end)
end

------------------我的金额------------------
function BG.DuiZhangMyJinEUI(FB, t, b, bb, i, ii)
    local b = BossNum(FB, b, t)
    local button = CreateFrame("EditBox", nil, BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i], "InputBoxTemplate");
    button:SetSize(85, 20)
    button:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 5, 0);
    button:SetFrameLevel(110)
    button:SetAutoFocus(false)
    button:SetEnabled(false)
    button:SetTextColor(RGB("00BFFF"))
    if BiaoGe[FB]["boss" .. b]["jine" .. i] and b ~= Maxb[FB] and b ~= Maxb[FB] + 1 then
        button:SetText(BiaoGe[FB]["boss" .. b]["jine" .. i])
    end
    preWidget = button
    BG.DuiZhangFrame[FB]["boss" .. b]["myjine" .. i] = button

    button:SetScript("OnTextChanged", function(self)
        local sum = 0
        local n = 0
        for b = 1, Maxb[FB] - 1, 1 do
            for i = 1, Maxi[FB], 1 do
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
    button:SetScript("OnEnter", function(self)
        BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i]:Show()
    end)
    button:SetScript("OnLeave", function(self)
        BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i]:Hide()
        GameTooltip:Hide()
    end)
end

------------------别人的金额------------------
function BG.DuiZhangOtherJinEUI(FB, t, b, bb, i, ii)
    local b = BossNum(FB, b, t)
    local button = CreateFrame("EditBox", nil, BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i], "InputBoxTemplate");
    button:SetSize(85, 20)
    button:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 5, 0);
    button:SetFrameLevel(110)
    button:SetAutoFocus(false)
    button:SetEnabled(false)
    button:SetTextColor(RGB("FF69B4"))
    preWidget = button
    BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i] = button

    local texture = button:CreateTexture()
    texture:SetSize(16, 16)
    texture:SetPoint("RIGHT", 16, 0)
    BG.DuiZhangFrame[FB]["boss" .. b]["yes" .. i] = texture

    button:SetScript("OnTextChanged", function(self)
        local sum = 0
        local n = 0
        for b = 1, Maxb[FB], 1 do
            for i = 1, Maxi[FB], 1 do
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
    button:SetScript("OnEnter", function(self)
        BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i]:Show()
    end)
    button:SetScript("OnLeave", function(self)
        BG.DuiZhangFrameDs[FB .. 1]["boss" .. b]["ds" .. i]:Hide()
        GameTooltip:Hide()
    end)
end

------------------底色材质------------------
function BG.DuiZhangDiSeUI(FB, t, b, bb, i, ii)
    local b = BossNum(FB, b, t)
    local textrue = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]:CreateTexture()
    textrue:SetPoint("TOPLEFT", BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i], "TOPLEFT", -4, -2)
    textrue:SetPoint("BOTTOMRIGHT", BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i], "BOTTOMRIGHT", -2, 0)
    textrue:SetColorTexture(red, greed, blue, touming1)
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
    version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
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
        version:SetFont(BIAOGE_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB("00BFFF"))
        version:SetText(L["工\n资"])
    end
end

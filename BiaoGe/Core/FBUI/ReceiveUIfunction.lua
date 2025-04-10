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
BG.ReceiveFrame.p = p

local preWidget
local framedown
local frameright
local red, greed, blue = 1, 1, 1
local touming1, touming2 = 0.1, 0.1

------------------标题------------------
function BG.ReceiveTitleUI(FB, t, b, bb, i, ii)
    local fontsize = 15
    local version = BG["ReceiveFrame" .. FB]:CreateFontString()
    if t == 1 then
        version:SetPoint("TOPLEFT", BG.ReceiveMainFrame, "TOPLEFT", 13, -60)
    else
        version:SetPoint("TOPLEFT", frameright, "TOPLEFT", 100, 0)
    end
    version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    version:SetText(L["  项目"])
    preWidget = version

    local version = BG["ReceiveFrame" .. FB]:CreateFontString()
    version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 70, 0);
    version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    version:SetText(L["装备"])
    preWidget = version
    p.preWidget0 = version

    local version = BG["ReceiveFrame" .. FB]:CreateFontString()
    version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 155, 0);
    version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    version:SetText(L["买家"])
    preWidget = version

    local version = BG["ReceiveFrame" .. FB]:CreateFontString()
    version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 95, 0);
    version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.y2))
    version:SetText(L["金额"])
    preWidget = version
    frameright = version
end

------------------装备------------------
function BG.ReceiveZhuangBeiUI(FB, t, b, bb, i, ii, scrollFrame)
    local parent = scrollFrame or BG["ReceiveFrame" .. FB]
    local bt = CreateFrame("EditBox", nil, parent, "InputBoxTemplate");
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
                bt:SetPoint("TOPLEFT", p["preWidget" .. i - 1], "BOTTOMLEFT", 0, -3)
            end
        end
    end
    bt:SetAutoFocus(false)
    bt:SetEnabled(false)
    BG.SetBorderAlpha(bt)
    local icon = bt:CreateTexture(nil, 'ARTWORK')
    icon:SetPoint('LEFT', -22, 0)
    icon:SetSize(16, 16)
    BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i] = bt
    preWidget = bt
    p["preWidget" .. i] = bt
    framedown = p["preWidget" .. ii]
    -- 内容改变时
    bt:SetScript("OnTextChanged", function(self)
        local itemText = bt:GetText()
        local itemID = GetItemID(itemText)
        if itemID then
            local item = Item:CreateFromItemID(itemID)
            item:ContinueOnItemLoad(function()
                local name, link, quality, level, _, _, _, _, _, Texture,
                _, typeID, _, bindType = GetItemInfo(itemText)
                icon:SetTexture(Texture)
                BG.BindOnEquip(self, bindType)
                BG.LevelText(self, level, typeID)
                BG.IsHave(self)
            end)
        else
            icon:SetTexture(nil)
            BG.BindOnEquip(self)
            BG.LevelText(self)
            BG.IsHave(self)
        end
    end)
    -- 发送装备到聊天输入框
    bt:SetScript("OnMouseDown", function(self, enter)
        if IsShiftKeyDown() then
            BG.PlaySound(1)
            BG.InsertLink(self:GetText())
        end
    end)
    -- 鼠标悬停在装备时
    bt:SetScript("OnEnter", function(self)
        BG.ReceiveFrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show()
        if not tonumber(self:GetText()) then
            local link = bt:GetText()
            local itemID = GetItemID(link)
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
        BG.ReceiveFrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
        GameTooltip:Hide()
    end)
end

------------------买家------------------
function BG.ReceiveMaiJiaUI(FB, t, b, bb, i, ii)
    local bt = CreateFrame("EditBox", nil, BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i], "InputBoxTemplate");
    bt:SetSize(90, 20)
    bt:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 5, 0);
    bt:SetFrameLevel(110)
    bt:SetMaxBytes(19) --限制字数
    bt:SetAutoFocus(false)
    bt:SetEnabled(false)
    BG.SetBorderAlpha(bt)
    if BossNum(FB, b, t) <= Maxb[FB] then
        preWidget = bt
    else
        bt:Hide()
    end
    BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i] = bt

    -- 鼠标悬停在装备时
    bt:SetScript("OnEnter", function(self)
        BG.ReceiveFrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show()
    end)
    bt:SetScript("OnLeave", function(self)
        BG.ReceiveFrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
        GameTooltip:Hide()
    end)
end

------------------金额------------------
function BG.ReceiveJinEUI(FB, t, b, bb, i, ii)
    local bt = CreateFrame("EditBox", nil, BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i], "InputBoxTemplate");
    bt:SetSize(80, 20)
    bt:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 5, 0);
    bt:SetFrameLevel(110)
    bt:SetAutoFocus(false)
    bt:SetEnabled(false)
    BG.SetBorderAlpha(bt)
    preWidget = bt
    BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i] = bt

    -- 鼠标悬停在装备时
    bt:SetScript("OnEnter", function(self)
        BG.ReceiveFrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Show()
    end)
    bt:SetScript("OnLeave", function(self)
        BG.ReceiveFrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i]:Hide()
        GameTooltip:Hide()
    end)
end

------------------BOSS名字------------------
function BG.ReceiveBossNameUI(FB, t, b, bb, i, ii, frameName)
    local fontsize = 14
    local version = BG["ReceiveFrame" .. FB]:CreateFontString()
    if frameName and BG[frameName .. FB]["scrollFrame" .. BossNum(FB, b, t)] then
        version:SetPoint("TOP", BG[frameName .. FB]["scrollFrame" .. BossNum(FB, b, t)].owner, "TOPLEFT", -40, -2)
    else
        version:SetPoint("TOP", BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)].zhuangbei1, "TOPLEFT", -45, -2)
    end
    version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
    version:SetTextColor(RGB(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].color))
    version:SetText(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].name)
    BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)]["name"] = version
    if BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)] == BG.ReceiveFrame[FB]["boss" .. Maxb[FB] + 2] then
        local version = BG["ReceiveFrame" .. FB]:CreateFontString()
        version:SetPoint("BOTTOM", BG.ReceiveFrame[FB]["boss" .. Maxb[FB] + 2].zhuangbei5, "BOTTOMLEFT", -45, 7)
        version:SetFont(STANDARD_TEXT_FONT, fontsize, "OUTLINE")
        version:SetTextColor(RGB("00BFFF"))
        version:SetText(L["工\n资"])
    end
end

------------------击杀用时------------------
function BG.ReceiveJiShaUI(FB, t, b, bb, i, ii)
    local text = BG["ReceiveFrame" .. FB]:CreateFontString()
    local num
    for i = 1, BG.GetMaxi(FB, BossNum(FB, b, t)) do
        if not BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i + 1] then
            num = i
            break
        end
    end
    text:SetPoint("TOPLEFT", BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. num], "BOTTOMLEFT", -0, -3)
    text:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE,THICK")
    text:SetTextColor(RGB(BG.Boss[FB]["boss" .. BossNum(FB, b, t)].color))
    text:SetAlpha(0.8)
    BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)]["time"] = text
end

------------------底色材质------------------
function BG.ReceiveDiSeUI(FB, t, b, bb, i, ii)
    -- 先做底色材质1（鼠标悬停的）
    local textrue = BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i]:CreateTexture()
    textrue:SetPoint("TOPLEFT", BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i], "TOPLEFT", -4, -2)
    textrue:SetPoint("BOTTOMRIGHT", BG.ReceiveFrame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i], "BOTTOMRIGHT", -2, 0)
    -- textrue:SetColorTexture(red, greed, blue, touming1)
    textrue:Hide()
    BG.ReceiveFrameDs[FB .. 1]["boss" .. BossNum(FB, b, t)]["ds" .. i] = textrue
end

------------------支出、总览、工资------------------
function BG.ReceiveZhiChuZongLanGongZiUI(FB)
    -- 设置支出颜色：绿
    for i = 1, BG.GetMaxi(FB, Maxb[FB] + 1), 1 do
        if BG.ReceiveFrame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i] then
            BG.ReceiveFrame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i]:SetTextColor(RGB("00FF00"))
            BG.ReceiveFrame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]:SetTextColor(RGB("00FF00"))
        end
    end

    -- 设置总览颜色：粉
    for i = 1, 3, 1 do
        BG.ReceiveFrame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i]:SetTextColor(RGB("EE82EE"))
        BG.ReceiveFrame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i]:SetTextColor(RGB("EE82EE"))
    end
    -- 设置工资颜色：蓝
    for i = 4, 5, 1 do
        BG.ReceiveFrame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i]:SetTextColor(RGB("00BFFF"))
        BG.ReceiveFrame[FB]["boss" .. Maxb[FB] + 2]["jine" .. i]:SetTextColor(RGB("00BFFF"))
    end
end

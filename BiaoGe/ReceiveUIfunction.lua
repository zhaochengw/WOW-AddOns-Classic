local _, ADDONSELF = ...

local Listmaijia = ADDONSELF.Listmaijia
local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local Sumjine = ADDONSELF.Sumjine
local SumZC = ADDONSELF.SumZC
local SumJ = ADDONSELF.SumJ
local SumGZ = ADDONSELF.SumGZ
local Listzhuangbei = ADDONSELF.Listzhuangbei
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local Listjine = ADDONSELF.Listjine
local BossNum = ADDONSELF.BossNum
local FrameHide = ADDONSELF.FrameHide

local pt = print

local p = {}
local preWidget
local framedown
local frameright
local red,greed,blue = 1,1,1
local touming1,touming2 = 0.2,0.4

------------------标题------------------
function BG.ReceiveBiaoTiUI(FB,t,b,bb,i,ii)
    if b == 1 and i == 1 then
        local version = BG["ReceiveFrame"..FB]:CreateFontString()
        if t == 1 then
            version:SetPoint("TOPLEFT", BG.ReceiveMainFrame, "TOPLEFT", 10, -35)
        else
            version:SetPoint("TOPLEFT", frameright, "TOPLEFT", 100, 0)
        end
        version:SetFontObject(GameFontNormal)
        version:SetText("  项目")
        version:Show()
        preWidget = version

        local version = BG["ReceiveFrame"..FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 70, 0);
        version:SetFontObject(GameFontNormal)
        version:SetText("装备")
        version:Show()
        preWidget = version
        p.preWidget0 = version

        local version = BG["ReceiveFrame"..FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 155, 0);
        version:SetFontObject(GameFontNormal)
        version:SetText("买家")
        version:Show()
        preWidget = version
        
        local version = BG["ReceiveFrame"..FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 95, 0);
        version:SetFontObject(GameFontNormal)
        version:SetText("金额")
        version:Show()
        preWidget = version
        frameright = version

    end
end

------------------底色材质------------------
function BG.ReceiveDiSsUI(FB,t,b,bb,i,ii)
    local TextureDs ={}
        -- 先做底色材质1（鼠标悬停的）
    local ds = CreateFrame("Button", nil, BG["ReceiveFrame"..FB])
    ds:SetSize(331, 18)
    ds:SetFrameLevel(102)
    if b > 1 and i == 1 then
        ds:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", -3, -22);
    else
        ds:SetPoint("TOPLEFT", p["preWidget"..i-1], "BOTTOMLEFT", -3, -4);
    end

    ds:Hide()
    local textrue= ds:CreateTexture()
    textrue:SetAllPoints(ds)
    textrue:SetColorTexture(red,greed,blue,touming1)
    BG.ReceiveFrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i] = ds
end

------------------装备------------------
function BG.ReceiveZhuangBeiUI(FB,t,b,bb,i,ii)
    local button = CreateFrame("EditBox", nil, BG["ReceiveFrame"..FB], "InputBoxTemplate");
    button:SetSize(150, 20)
    button:SetFrameLevel(110)
    if b > 1 and i == 1 then
        button:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -20);
    else
        button:SetPoint("TOPLEFT", p["preWidget"..i-1], "BOTTOMLEFT", 0, -3);
    end
    button:SetAutoFocus(false)
    button:Show()
    button:SetEnabled(false)
    local icon = button:CreateTexture(nil, 'ARTWORK')
    icon:SetPoint('LEFT', -22, 0)
    icon:SetSize(16, 16)
    BG.ReceiveFrame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i] = button
    preWidget = button
    p["preWidget"..i] = button
    framedown = p["preWidget"..ii]
        -- 内容改变时
    button:SetScript("OnTextChanged", function(self)
        local itemText = button:GetText()
        local itemID = select(1, GetItemInfoInstant(itemText))
            -- 装备的图标
        if not tonumber(self:GetText()) then
            local itemIcon = GetItemIcon(itemID)
            if itemIcon then
                icon:SetTexture(itemIcon)
            else
                icon:SetTexture(nil)
            end
        end
    end)
        -- 发送装备到聊天输入框
    button:SetScript("OnMouseDown", function(self,enter)
        if IsShiftKeyDown() then
            button:ClearFocus()
            for b=1,Maxb[FB] do
                for i=1,Maxi[FB] do
                    if BG.Frame[FB]["boss"..b]["zhuangbei"..i] then
                        BG.Frame[FB]["boss"..b]["zhuangbei"..i]:SetEnabled(false)
                    end
                end
            end
            _G.ChatFrame1EditBox:Show()
            _G.ChatFrame1EditBox:SetFocus()
            local text=self:GetText()
            _G.ChatFrame1EditBox:Insert(text)
            return
        end
    end)
        -- 鼠标悬停在装备时
    button:SetScript("OnEnter", function(self) 
        BG.ReceiveFrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i]:Show()
        if not tonumber(self:GetText()) then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT",-70,0);
            GameTooltip:ClearLines();
            local itemLink = button:GetText()
            local itemID = select(1, GetItemInfoInstant(itemLink))
            if itemID then
            GameTooltip:SetItemByID(itemID);
            GameTooltip:Show()
            -- BG.HistoryJine(FB,itemID)
        end
        end
    end)
    button:SetScript("OnLeave", function(self) 
        BG.ReceiveFrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i]:Hide()
        GameTooltip:Hide()
        if BG["ReceiveJineFrameDB1"] then
            for i=1,BG.ReceiveJineFrameDBMax do
                BG["ReceiveJineFrameDB"..i]:Hide()
            end
            BG.ReceiveJineFrame:Hide()
        end
    end)
end

------------------买家------------------
function BG.ReceiveMaiJiaUI(FB,t,b,bb,i,ii)
    local button = CreateFrame("EditBox", nil, BG["ReceiveFrame"..FB], "InputBoxTemplate");
    button:SetSize(90, 20)
    button:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 5, 0);
    button:SetFrameLevel(110)
    button:SetMaxBytes(19) --限制字数
    button:SetAutoFocus(false)
    button:Show()
    button:SetEnabled(false)
    preWidget = button
    BG.ReceiveFrame[FB]["boss"..BossNum(FB,b,t)]["maijia"..i] = button

    -- 鼠标悬停在装备时
    button:SetScript("OnEnter", function(self) 
        BG.ReceiveFrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i]:Show()
    end)
    button:SetScript("OnLeave", function(self) 
        BG.ReceiveFrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i]:Hide()
        GameTooltip:Hide() 
    end)
end

------------------金额------------------
function BG.ReceiveJinEUI(FB,t,b,bb,i,ii)
    local button = CreateFrame("EditBox", nil, BG["ReceiveFrame"..FB], "InputBoxTemplate");
    button:SetSize(80, 20)
    button:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 5, 0);
    button:SetFrameLevel(110)
    button:SetNumeric(true)
    button:SetAutoFocus(false)
    button:Show()
    button:SetEnabled(false)
    preWidget = button
    BG.ReceiveFrame[FB]["boss"..BossNum(FB,b,t)]["jine"..i] = button

    -- 鼠标悬停在装备时
    button:SetScript("OnEnter", function(self) 
        BG.ReceiveFrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i]:Show()
    end)
    button:SetScript("OnLeave", function(self) 
        BG.ReceiveFrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i]:Hide()
        GameTooltip:Hide() 
    end)
end

------------------BOSS名字------------------
function BG.ReceiveBossNameUI(FB,t,b,bb,i,ii)
    local version = BG["ReceiveFrame"..FB]:CreateFontString();
    version:SetPoint("TOP", BG.ReceiveFrame[FB]["boss"..BossNum(FB,b,t)].zhuangbei1, "TOPLEFT", -45, -3)           
    version:SetFontObject(GameFontNormal)
    version:SetText(BiaoGe[FB]["boss"..BossNum(FB,b,t)].bossname)                
    version:Show()
    BG.ReceiveFrame[FB]["boss"..BossNum(FB,b,t)]["bossname"] = version
    if BG.ReceiveFrame[FB]["boss"..BossNum(FB,b,t)] == BG.ReceiveFrame[FB]["boss"..Maxb[FB]+2] then
        local version1 = BG["ReceiveFrame"..FB]:CreateFontString()
        version1:SetPoint("BOTTOM", BG.ReceiveFrame[FB]["boss"..Maxb[FB]+2].zhuangbei5, "BOTTOMLEFT", -45, 7)
        version1:SetFontObject(GameFontNormal)
        version1:SetText("|cff00BFFF工\n资|r")
        version1:Show()
    end
end

------------------击杀用时------------------
function BG.ReceiveJiShaUI(FB,t,b,bb,i,ii)
    local text = BG["ReceiveFrame"..FB]:CreateFontString();
    local num
    local color
    for i=1,Maxi[FB] do
        if not BG.ReceiveFrame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i+1] then
            num = i
            break
        end
    end
    text:SetPoint("TOPLEFT", BG.ReceiveFrame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..num], "BOTTOMLEFT", -0, -3)           
    text:SetFont(STANDARD_TEXT_FONT,10,"OUTLINE,THICK")
    text:SetAlpha(0.8)
    BG.ReceiveFrame[FB]["boss"..BossNum(FB,b,t)]["time"] = text
end

------------------支出、总览、工资------------------
function BG.ReceiveZhiChuZongLanGongZiUI(FB)
        -- 设置支出颜色：绿
    for i = 1, 5, 1 do
        BG.ReceiveFrame[FB]["boss"..Maxb[FB]+1]["zhuangbei"..i]:SetTextColor(RGB("00FF00"))
        BG.ReceiveFrame[FB]["boss"..Maxb[FB]+1]["jine"..i]:SetTextColor(RGB("00FF00"))
    end
        -- 设置总览颜色：粉
    for i = 1, 3, 1 do
        BG.ReceiveFrame[FB]["boss"..Maxb[FB]+2]["zhuangbei"..i]:SetTextColor(RGB("EE82EE"))
        BG.ReceiveFrame[FB]["boss"..Maxb[FB]+2]["jine"..i]:SetTextColor(RGB("EE82EE"))
    end
        -- 设置工资颜色：蓝
    for i = 4, 5, 1 do
        BG.ReceiveFrame[FB]["boss"..Maxb[FB]+2]["zhuangbei"..i]:SetTextColor(RGB("00BFFF"))
        BG.ReceiveFrame[FB]["boss"..Maxb[FB]+2]["jine"..i]:SetTextColor(RGB("00BFFF"))
    end
end


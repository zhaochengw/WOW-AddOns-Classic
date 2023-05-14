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
function BG.FBBiaoTiUI(FB,t,b,bb,i,ii)    
    if b == 1 and i == 1 then
        local version = BG["Frame"..FB]:CreateFontString()
        if t == 1 then
            version:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 10, -35)
        else
            version:SetPoint("TOPLEFT", frameright, "TOPLEFT", 100, 0)
        end
        version:SetFontObject(GameFontNormal)
        version:SetText("  项目")
        version:Show()
        preWidget = version

        local version = BG["Frame"..FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 70, 0)
        version:SetFontObject(GameFontNormal)
        version:SetText("装备")
        version:Show()
        preWidget = version
        p.preWidget0 = version

        local version = BG["Frame"..FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 155, 0)
        version:SetFontObject(GameFontNormal)
        version:SetText("买家")
        version:Show()
        preWidget = version
        
        local version = BG["Frame"..FB]:CreateFontString()
        version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 95, 0)
        version:SetFontObject(GameFontNormal)
        version:SetText("金额")
        version:Show()
        preWidget = version
        frameright = version
    end
end

------------------底色材质------------------
function BG.FBDiSsUI(FB,t,b,bb,i,ii)
        -- 先做底色材质1（鼠标悬停的）
    local ds = CreateFrame("Button", nil, BG["Frame"..FB])
    ds:SetSize(331, 18)
    ds:SetFrameLevel(102)
    if b > 1 and i == 1 then
        ds:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", -3, -22)
    else
        ds:SetPoint("TOPLEFT", p["preWidget"..i-1], "BOTTOMLEFT", -3, -4)
    end
    ds:Hide()
    local textrue= ds:CreateTexture()
    textrue:SetAllPoints(ds)
    textrue:SetColorTexture(red,greed,blue,touming1)
    BG.FrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i] = ds

        -- 底色材质2（点击框体后）
    local ds = CreateFrame("Button", nil, BG["Frame"..FB])
    ds:SetSize(331, 18)
    ds:SetFrameLevel(103)
    if b > 1 and i == 1 then
        ds:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", -3, -22)
    else
        ds:SetPoint("TOPLEFT", p["preWidget"..i-1], "BOTTOMLEFT", -3, -4)
    end
    ds:Hide()
    local textrue= ds:CreateTexture()
    textrue:SetAllPoints(ds)
    textrue:SetColorTexture(red,greed,blue,touming2)
    BG.FrameDs[FB..2]["boss"..BossNum(FB,b,t)]["ds"..i] = ds

        -- 底色材质3（团长发的装备高亮）
    local ds = CreateFrame("Button", nil, BG["Frame"..FB])
    ds:SetSize(331, 18)
    ds:SetFrameLevel(101)
    if b > 1 and i == 1 then
        ds:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", -3, -22)
    else
        ds:SetPoint("TOPLEFT", p["preWidget"..i-1], "BOTTOMLEFT", -3, -4)
    end
    ds:Hide()
    local textrue= ds:CreateTexture()
    textrue:SetAllPoints(ds)
    textrue:SetColorTexture(1,1,0,0.4)
    BG.FrameDs[FB..3]["boss"..BossNum(FB,b,t)]["ds"..i] = ds
end

------------------装备------------------
function BG.FBZhuangBeiUI(FB,t,b,bb,i,ii)
    local button = CreateFrame("EditBox", nil, BG["Frame"..FB], "InputBoxTemplate")
    button:SetSize(150, 20)
    button:SetFrameLevel(110)
    -- button:SetTextColor(RGB("FFD100"))
    if b > 1 and i == 1 then
        button:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -20)
    else
        button:SetPoint("TOPLEFT", p["preWidget"..i-1], "BOTTOMLEFT", 0, -3)
    end
    button:SetAutoFocus(false)
    button:Show()
    local icon = button:CreateTexture(nil, 'ARTWORK')
    icon:SetPoint('LEFT', -22, 0)
    icon:SetSize(16, 16)
    if BiaoGe[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i] then
        button:SetText(BiaoGe[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i])
    end
    BG.Frame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i] = button
    BiaoGe[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i] = button:GetText()
    preWidget = button
    p["preWidget"..i] = button
    framedown = p["preWidget"..ii]
        -- 内容改变时
    local _,class = UnitClass("player")
    button:SetScript("OnTextChanged", function(self)
        local itemText = button:GetText()
        local itemID = select(1, GetItemInfoInstant(itemText))
        -- itemText = strtrim(itemText, "[]")
        local name,link,quality,level,_,_,_,_,_,_,_,typeID=GetItemInfo(itemText)
        local hard
        if link then
            if FB == "ULD" then
                for index, value in ipairs(BG.Loot.ULD.Hard10) do
                    if itemID == value then
                        self:SetText(link.."★")
                        hard = true
                    end
                end
                if not hard then
                    for index, value in ipairs(BG.Loot.ULD.Hard25) do
                        if itemID == value then
                            self:SetText(link.."★")
                        end
                    end
                end
            end
        end
        if self:GetText() == "" then
            BiaoGe[FB]["boss"..BossNum(FB,b,t)]["guanzhu"..i] = nil
            BG.Frame[FB]["boss"..BossNum(FB,b,t)]["guanzhu"..i]:Hide()
        end

        local num = BiaoGeA.filterClassNum  -- 隐藏
        if num ~= 0 then
            BG.FilterClass(FB,BossNum(FB,b,t),i,button,class,num,BiaoGeFilterTooltip,"Frame")
            C_Timer.After(0.01,function ()
                BG.FilterClass(FB,BossNum(FB,b,t),i,button,class,num,BiaoGeFilterTooltip,"Frame")
            end)
        end

        BiaoGe[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i] = button:GetText()      -- 储存文本
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
        -- 鼠标按下时
    button:SetScript("OnMouseDown", function(self,enter)
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss"..Maxb[FB]+2]["zhuangbei"..i] then  -- 右键清空格子
            self:SetEnabled(false)
            self:SetText("")
            if BG.lastfocus then
                BG.lastfocus:ClearFocus()
            end
            return
        end
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
        if IsAltKeyDown() then
            if self:GetText() ~= "" then
                button:ClearFocus()
                for b=1,Maxb[FB] do
                    for i=1,Maxi[FB] do
                        if BG.Frame[FB]["boss"..b]["zhuangbei"..i] then
                            BG.Frame[FB]["boss"..b]["zhuangbei"..i]:SetEnabled(false)
                        end
                    end
                end
                BiaoGe[FB]["boss"..BossNum(FB,b,t)]["guanzhu"..i] = true
                BG.Frame[FB]["boss"..BossNum(FB,b,t)]["guanzhu"..i]:Show()
            end
            return
        end
        if IsControlKeyDown() then
            BG.TongBaoHis(button,BG.HistoryJineDB)
            return
        end
    end)
    button:SetScript("OnMouseUp", function(self,enter)
        for b=1,Maxb[FB] do
            for i=1,Maxi[FB] do
                if BG.Frame[FB]["boss"..b]["zhuangbei"..i] then
                    BG.Frame[FB]["boss"..b]["zhuangbei"..i]:SetEnabled(true)
                end
            end
        end
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss"..Maxb[FB]+2]["zhuangbei"..i] then  -- 右键清空格子
            self:SetEnabled(true)
        end
    end)
        -- 鼠标悬停在装备时
    button:SetScript("OnEnter", function(self) 
        BG.FrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i]:Show()
        if not tonumber(self:GetText()) then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT",-70,0)
            GameTooltip:ClearLines()
            local itemLink = button:GetText()
            local itemID = select(1, GetItemInfoInstant(itemLink))
            if itemID then
                GameTooltip:SetItemByID(itemID)
                GameTooltip:Show()
                BG.HistoryJine(FB,itemID)
            end
        end
    end)
    button:SetScript("OnLeave", function(self) 
        BG.FrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i]:Hide()
        GameTooltip:Hide()
        if BG["HistoryJineFrameDB1"] then
            for i=1,BG.HistoryJineFrameDBMax do
                BG["HistoryJineFrameDB"..i]:Hide()
            end
            BG.HistoryJineFrame:Hide()
        end
    end)
        -- 获得光标时
    button:SetScript("OnEditFocusGained", function(self)
        FrameHide(1)
        self:HighlightText()
        BG.lastfocuszhuangbei = self
        BG.lastfocus = self
        Listzhuangbei(self,BossNum(FB,b,t),FB,BiaoGe[FB]["boss"..BossNum(FB,b,t)]["guanzhu"..i],BG.Frame[FB]["boss"..BossNum(FB,b,t)]["guanzhu"..i])
        if BG.Frame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i+1] then
            BG.lastfocuszhuangbei2 = BG.Frame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i+1]
        else
            BG.lastfocuszhuangbei2 = nil
        end
        BG.FrameDs[FB..2]["boss"..BossNum(FB,b,t)]["ds"..i]:Show()
    end)
        -- 失去光标时
    button:SetScript("OnEditFocusLost", function(self)
        self:HighlightText(0,0)
        if BG.FrameZhuangbeiList then
            BG.FrameZhuangbeiList:Hide()
        end
        BG.FrameDs[FB..2]["boss"..BossNum(FB,b,t)]["ds"..i]:Hide()
    end)
        -- 按TAB跳转右边
    button:SetScript("OnTabPressed", function(self)
        BG.Frame[FB]["boss"..BossNum(FB,b,t)]["maijia"..i]:SetFocus()
    end)
        -- 按ENTER跳转下边
    button:SetScript("OnEnterPressed", function(self)
        if BG.Frame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i+1] then
            BG.Frame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i+1]:SetFocus()
        elseif not BG.Frame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i+1] then
            if BG.Frame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i] ~= BG.Frame[FB]["boss"..Maxb[FB]]["zhuangbei"..Maxi[FB]] then
                BG.Frame[FB]["boss"..BossNum(FB,b,t)+1]["zhuangbei1"]:SetFocus()
            end
        end
    end)
end

------------------关注装备------------------
function BG.FBGuanZhuUI(FB,t,b,bb,i,ii)
    local frame = CreateFrame("Frame", nil, BG["Frame"..FB])     -- 关注按钮
    frame:SetSize(50, 23)
    frame:SetPoint("RIGHT", preWidget, "RIGHT", 5, -1)
    frame:SetFrameLevel(112)
    local fontString = frame:CreateFontString()
    fontString:SetAllPoints()
    fontString:SetFontObject(GameFontNormal)
    fontString:SetText(BG.STC_b1("关注"))
    if BiaoGe[FB]["boss"..BossNum(FB,b,t)]["guanzhu"..i] then
        frame:Show()
    else
        frame:Hide()
    end
    BG.Frame[FB]["boss"..BossNum(FB,b,t)]["guanzhu"..i] = frame

    -- 鼠标悬停提示
    frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0)
        GameTooltip:ClearLines()
        GameTooltip:SetText(BG.STC_b1("关注中，团长拍卖此装备会提醒").."\n右键取消关注")
    end)
    frame:SetScript("OnLeave",function (self)
        GameTooltip:Hide()
    end)
    -- 单击触发
    frame:SetScript("OnMouseDown", function(self,enter)
        if enter == "RightButton" then  -- 右键清空格子
            FrameHide(0)
            BiaoGe[FB]["boss"..BossNum(FB,b,t)]["guanzhu"..i] = nil
            self:Hide()
        end
    end)
end

------------------买家------------------
function BG.FBMaiJiaUI(FB,t,b,bb,i,ii)
    local button = CreateFrame("EditBox", nil, BG["Frame"..FB], "InputBoxTemplate")
    button:SetSize(90, 20)
    button:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 5, 0)
    button:SetFrameLevel(110)
    button:SetMaxBytes(19) --限制字数
    button:SetAutoFocus(false)
    button:Show()
    if BiaoGe[FB]["boss"..BossNum(FB,b,t)]["maijia"..i] then
        button:SetText(BiaoGe[FB]["boss"..BossNum(FB,b,t)]["maijia"..i])         
    end
    if BiaoGe[FB]["boss"..BossNum(FB,b,t)]["color"..i]  then
        button:SetTextColor(BiaoGe[FB]["boss"..BossNum(FB,b,t)]["color"..i][1],BiaoGe[FB]["boss"..BossNum(FB,b,t)]["color"..i][2],BiaoGe[FB]["boss"..BossNum(FB,b,t)]["color"..i][3])         
    end
    preWidget = button
    BiaoGe[FB]["boss"..BossNum(FB,b,t)]["maijia"..i] = button:GetText()
    BiaoGe[FB]["boss"..BossNum(FB,b,t)]["color"..i] = {button:GetTextColor()}
    BG.Frame[FB]["boss"..BossNum(FB,b,t)]["maijia"..i] = button
        -- 当内容改变时
    button:SetScript("OnTextChanged", function(self)
        BiaoGe[FB]["boss"..BossNum(FB,b,t)]["maijia"..i] = button:GetText()     -- 储存文本
        if self:GetText() == "" then        -- 如果没有名字，就恢复白色
            self:SetTextColor(1,1,1)
        end
        BiaoGe[FB]["boss"..BossNum(FB,b,t)]["color"..i] = {button:GetTextColor()}       -- 储存颜色
    end)
        -- 点击时
    button:SetScript("OnMouseDown", function(self,enter)
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss"..Maxb[FB]+2]["maijia"..i] then  -- 右键清空格子
            self:SetEnabled(false)
            self:SetText("")
            if BG.lastfocus then
                BG.lastfocus:ClearFocus()
            end
        end
    end)
    button:SetScript("OnMouseUp", function(self,enter)
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss"..Maxb[FB]+2]["maijia"..i] then  -- 右键清空格子
            self:SetEnabled(true)
        end
    end)
        -- 悬停鼠标时
    button:SetScript("OnEnter", function(self)      -- 底色
        BG.FrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i]:Show()
    end)
    button:SetScript("OnLeave",function (self)
        BG.FrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i]:Hide()
    end)
        -- 获得光标时
    button:SetScript("OnEditFocusGained", function(self)
        FrameHide(1)
        button:HighlightText()
        BG.lastfocus = self
        Listmaijia(self)
        BG.FrameDs[FB..2]["boss"..BossNum(FB,b,t)]["ds"..i]:Show()    -- 底色
    end)
        -- 失去光标时
    button:SetScript("OnEditFocusLost", function(self)
        button:HighlightText(0,0)
        BG.FrameMaijiaList:Hide()
        BG.FrameDs[FB..2]["boss"..BossNum(FB,b,t)]["ds"..i]:Hide()
    end)
        -- 按TAB跳转右边
    button:SetScript("OnTabPressed", function(self)
        BG.Frame[FB]["boss"..BossNum(FB,b,t)]["jine"..i]:SetFocus()
    end)
        -- 按ENTER跳转下边
    button:SetScript("OnEnterPressed", function(self)
        if BG.Frame[FB]["boss"..BossNum(FB,b,t)]["maijia"..i+1] then
            BG.Frame[FB]["boss"..BossNum(FB,b,t)]["maijia"..i+1]:SetFocus()
        elseif not BG.Frame[FB]["boss"..BossNum(FB,b,t)]["maijia"..i+1] then
            if BG.Frame[FB]["boss"..BossNum(FB,b,t)]["maijia"..i] ~= BG.Frame[FB]["boss"..Maxb[FB]]["maijia"..Maxi[FB]] then
                BG.Frame[FB]["boss"..BossNum(FB,b,t)+1]["maijia1"]:SetFocus()
            end
        end
    end)
end

------------------金额------------------
function BG.FBJinEUI(FB,t,b,bb,i,ii)
    local button = CreateFrame("EditBox", nil, BG["Frame"..FB], "InputBoxTemplate")
    button:SetSize(80, 20)
    button:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 5, 0)
    button:SetFrameLevel(110)
    -- button:SetNumeric(true)      -- 只能输入整数
    button:SetAutoFocus(false)
    -- button:SetJustifyH("RIGHT")      -- 字体对齐
    button:Show()
    if BiaoGe[FB]["boss"..BossNum(FB,b,t)]["jine"..i] then
        button:SetText(BiaoGe[FB]["boss"..BossNum(FB,b,t)]["jine"..i])            
    end
    preWidget = button
    BiaoGe[FB]["boss"..BossNum(FB,b,t)]["jine"..i] = button:GetText()
    BG.Frame[FB]["boss"..BossNum(FB,b,t)]["jine"..i] = button
        -- 当内容改变时
    button:SetScript("OnTextChanged", function(self)
        if BiaoGe.AutoJine0 == 1 and self ~= BG.Frame[FB]["boss"..Maxb[FB]+2]["jine"..i] then
            local len = strlen(self:GetText())
            local lingling
            if len then
                lingling = strsub(self:GetText(),len-1,len)
            end
            if lingling ~= "00" and lingling ~= "0" and tonumber(self:GetText()) and self:HasFocus() then
                self:Insert("00")
                self:SetCursorPosition(1)
            end
        end
        BiaoGe[FB]["boss"..BossNum(FB,b,t)]["jine"..i] = button:GetText()       -- 储存文本
        BG.Frame[FB]["boss"..Maxb[FB]+2]["jine1"]:SetText(Sumjine(BiaoGe[FB],Maxb[FB],Maxi[FB]))     -- 计算总收入
        BG.Frame[FB]["boss"..Maxb[FB]+2]["jine2"]:SetText(SumZC(BiaoGe[FB],Maxb[FB],Maxi[FB]))     -- 计算总支出
        BG.Frame[FB]["boss"..Maxb[FB]+2]["jine3"]:SetText(SumJ(BiaoGe[FB],Maxb[FB],Maxi[FB]))     -- 计算净收入
        BG.Frame[FB]["boss"..Maxb[FB]+2]["jine5"]:SetText(SumGZ(BiaoGe[FB],Maxb[FB],Maxi[FB]))     -- 计算人均工资
        -- if self ~= BG.Frame[FB]["boss"..Maxb[FB]+1]["jine"..i] and self ~= BG.Frame[FB]["boss"..Maxb[FB]+2]["jine"..i] then
        --     if not tonumber(self:GetText()) and self:GetText() ~= "" then        -- 如果文本里不是数字且不是空白
        --         self:SetTextColor(1,0,0)
        --     else
        --         self:SetTextColor(1,1,1)
        --     end
        -- end
    end)
        -- 点击时
    button:SetScript("OnMouseDown", function(self,enter)
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss"..Maxb[FB]+2]["jine"..i] then  -- 右键清空格子
            FrameHide(1)
            self:SetEnabled(false)
            self:SetText("")
        end
    end)
    button:SetScript("OnMouseUp", function(self,enter)
        if enter == "RightButton" and self ~= BG.Frame[FB]["boss"..Maxb[FB]+2]["jine"..i] then  -- 右键清空格子
            self:SetEnabled(true)
        end
    end)
        -- 悬停鼠标时
    button:SetScript("OnEnter", function(self)      -- 底色
        BG.FrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i]:Show()
    end)
    button:SetScript("OnLeave",function (self)
        BG.FrameDs[FB..1]["boss"..BossNum(FB,b,t)]["ds"..i]:Hide()
    end)
        -- 获得光标时
    button:SetScript("OnEditFocusGained", function(self)
        FrameHide(1)
        button:HighlightText()
        BG.lastfocus = self
        BG.FrameDs[FB..2]["boss"..BossNum(FB,b,t)]["ds"..i]:Show()    -- 底色
        if self ~= BG.Frame[FB]["boss"..Maxb[FB]+1]["jine"..i] and self ~= BG.Frame[FB]["boss"..Maxb[FB]+2]["jine"..i] then
            Listjine(self,FB,BossNum(FB,b,t),i)
        end
        if BG.FramePaiMaiMsg then
            BG.FramePaiMaiMsg:SetParent(BG.FrameJineList)
            BG.FramePaiMaiMsg:ClearAllPoints()
            BG.FramePaiMaiMsg:SetPoint("TOPRIGHT",BG.FrameJineList,"TOPLEFT",0,0)
            BG.FramePaiMaiMsg:Show()
            BG.FramePaiMaiMsg2:ScrollToBottom()
        end
    end)
        -- 失去光标时
    button:SetScript("OnEditFocusLost", function(self)
        button:HighlightText(0,0)
        BG.FrameDs[FB..2]["boss"..BossNum(FB,b,t)]["ds"..i]:Hide()
    end)
        -- 按TAB跳转下一行的装备
    button:SetScript("OnTabPressed", function(self)
        if BG.Frame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i+1] then
            BG.Frame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i+1]:SetFocus()
        elseif BG.Frame[FB]["boss"..BossNum(FB,b,t)]["jine"..i] == BG.Frame[FB]["boss"..BossNum(FB,b,t)]["jine5"] then
            if BG.Frame[FB]["boss"..BossNum(FB,b,t)]["jine"..i] ~= BG.Frame[FB]["boss"..Maxb[FB]]["jine5"] then
                BG.Frame[FB]["boss"..BossNum(FB,b,t)+1]["zhuangbei1"]:SetFocus()
            end
        end
    end)
        -- 按ENTER跳转下边
    button:SetScript("OnEnterPressed", function(self)
        if BG.Frame[FB]["boss"..BossNum(FB,b,t)]["jine"..i+1] then
            BG.Frame[FB]["boss"..BossNum(FB,b,t)]["jine"..i+1]:SetFocus()
        elseif not BG.Frame[FB]["boss"..BossNum(FB,b,t)]["jine"..i+1] then
            if BG.Frame[FB]["boss"..BossNum(FB,b,t)]["jine"..i] ~= BG.Frame[FB]["boss"..Maxb[FB]]["jine"..Maxi[FB]] then
                BG.Frame[FB]["boss"..BossNum(FB,b,t)+1]["jine1"]:SetFocus()
            end
        end
    end)
    button:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        BG.FrameJineList:Hide()
        BG.FramePaiMaiMsg:Hide()
    end)
end

------------------欠款------------------
function BG.FBQianKuanUI(FB,t,b,bb,i,ii)
    local frame = CreateFrame("Frame", nil, BG["Frame"..FB])     -- 欠款按钮
    frame:SetSize(23, 23)
    frame:SetPoint("LEFT", preWidget, "RIGHT", 0, 0)
    frame:SetFrameLevel(110)
    local fontString = frame:CreateFontString()
    fontString:SetAllPoints()
    fontString:SetFontObject(GameFontNormal)
    fontString:SetText("|cffFF0000欠|r")
    if not BiaoGe[FB]["boss"..BossNum(FB,b,t)]["qiankuan"..i] then
        BiaoGe[FB]["boss"..BossNum(FB,b,t)]["qiankuan"..i] = ""
    end
    if BiaoGe[FB]["boss"..BossNum(FB,b,t)]["qiankuan"..i] == "" or BiaoGe[FB]["boss"..BossNum(FB,b,t)]["qiankuan"..i] == "0" then
        frame:Hide()
    else
        frame:Show()
    end
    preWidget = frame
    BG.Frame[FB]["boss"..BossNum(FB,b,t)]["qiankuan"..i] = frame

    -- 鼠标悬停提示
    frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0)
        GameTooltip:ClearLines()
        GameTooltip:SetText("|cffFF0000欠款："..BiaoGe[FB]["boss"..BossNum(FB,b,t)]["qiankuan"..i].."|r\n右键清除欠款")
    end)
    frame:SetScript("OnLeave",function (self)
        GameTooltip:Hide()
    end)
    -- 单击触发
    frame:SetScript("OnMouseDown", function(self,enter)
        if enter == "RightButton" then  -- 右键清空格子
            FrameHide(0)
            BiaoGe[FB]["boss"..BossNum(FB,b,t)]["qiankuan"..i] = ""
            self:Hide()
        end
    end)
end

------------------BOSS名字------------------
function BG.FBBossNameUI(FB,t,b,bb,i,ii)
    local version = BG["Frame"..FB]:CreateFontString()
    version:SetPoint("TOP", BG.Frame[FB]["boss"..BossNum(FB,b,t)].zhuangbei1, "TOPLEFT", -45, -3)           
    version:SetFontObject(GameFontNormal)
    version:SetText(BiaoGe[FB]["boss"..BossNum(FB,b,t)].bossname)                
    version:Show()
    BG.Frame[FB]["boss"..BossNum(FB,b,t)]["bossname"] = version
    if BG.Frame[FB]["boss"..BossNum(FB,b,t)] == BG.Frame[FB]["boss"..Maxb[FB]+2] then
        local version1 = BG["Frame"..FB]:CreateFontString()
        version1:SetPoint("BOTTOM", BG.Frame[FB]["boss"..Maxb[FB]+2].zhuangbei5, "BOTTOMLEFT", -45, 7)
        version1:SetFontObject(GameFontNormal)
        version1:SetText("|cff00BFFF工\n资|r")
        version1:Show()
    end
end

------------------击杀用时------------------
function BG.FBJiShaUI(FB,t,b,bb,i,ii)
    if BG.Loot.encounterID[FB][BossNum(FB,b,t)] then
        local text = BG["Frame"..FB]:CreateFontString()
        local num
        local color
        for i=1,Maxi[FB] do
            if not BG.Frame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..i+1] then
                num = i
                break
            end
        end
        text:SetPoint("TOPLEFT", BG.Frame[FB]["boss"..BossNum(FB,b,t)]["zhuangbei"..num], "BOTTOMLEFT", -0, -3)           
        text:SetFont(STANDARD_TEXT_FONT,10,"OUTLINE,THICK")
        text:SetAlpha(0.8)
        BG.Frame[FB]["boss"..BossNum(FB,b,t)]["time"] = text

        if BiaoGe[FB]["boss"..BossNum(FB,b,t)]["time"] then
            -- if BiaoGe[FB]["boss"..BossNum(FB,b,t)]["time"] ~= "" then
                text:SetText(BiaoGe[FB]["boss"..BossNum(FB,b,t)]["time"])
            -- end
        end
    end
end

------------------支出、总览、工资------------------
function BG.FBZhiChuZongLanGongZiUI(FB)
    -- 初始化支出内容
    if BiaoGe[FB]["boss"..Maxb[FB]+1]["zhuangbei1"] == "" then
        BG.Frame[FB]["boss"..Maxb[FB]+1]["zhuangbei1"]:SetText("坦克 补贴")
    end
    if BiaoGe[FB]["boss"..Maxb[FB]+1]["zhuangbei2"] == "" then
        BG.Frame[FB]["boss"..Maxb[FB]+1]["zhuangbei2"]:SetText("治疗 补贴")
    end
    if BiaoGe[FB]["boss"..Maxb[FB]+1]["zhuangbei3"] == "" then
        BG.Frame[FB]["boss"..Maxb[FB]+1]["zhuangbei3"]:SetText("输出 补贴")
    end
    if BiaoGe[FB]["boss"..Maxb[FB]+1]["zhuangbei4"] == "" then
        BG.Frame[FB]["boss"..Maxb[FB]+1]["zhuangbei4"]:SetText("放鱼 补贴")
    end
    if BiaoGe[FB]["boss"..Maxb[FB]+1]["zhuangbei5"] == "" then
        BG.Frame[FB]["boss"..Maxb[FB]+1]["zhuangbei5"]:SetText("其他 补贴")
    end
        -- 设置支出颜色：绿
    for i = 1, 5, 1 do
        BG.Frame[FB]["boss"..Maxb[FB]+1]["zhuangbei"..i]:SetTextColor(RGB("00FF00"))
        BG.Frame[FB]["boss"..Maxb[FB]+1]["jine"..i]:SetTextColor(RGB("00FF00"))
    end

    -- 总览和工资
    BG.Frame[FB]["boss"..Maxb[FB]+2]["zhuangbei1"]:SetText("总收入")
    BG.Frame[FB]["boss"..Maxb[FB]+2]["zhuangbei2"]:SetText("总支出")
    BG.Frame[FB]["boss"..Maxb[FB]+2]["zhuangbei3"]:SetText("净收入")
    BG.Frame[FB]["boss"..Maxb[FB]+2]["zhuangbei4"]:SetText("分钱人数")
    BG.Frame[FB]["boss"..Maxb[FB]+2]["zhuangbei5"]:SetText("人均工资")
    if BG.Frame[FB]["boss"..Maxb[FB]+2]["jine4"]:GetText() == "" then
        BG.Frame[FB]["boss"..Maxb[FB]+2]["jine4"]:SetText("25")
    end
    for i = 1, 5, 1 do
        BG.Frame[FB]["boss"..Maxb[FB]+2]["zhuangbei"..i]:SetEnabled(false)
        BG.Frame[FB]["boss"..Maxb[FB]+2]["maijia"..i]:SetEnabled(false)
        BG.Frame[FB]["boss"..Maxb[FB]+2]["jine"..i]:SetEnabled(false)
        -- BG.Frame[FB]["boss"..Maxb[FB]]["maijia"..i]:SetEnabled(false)       -- 关掉罚款的买家按键
    end
    BG.Frame[FB]["boss"..Maxb[FB]+2]["jine4"]:SetEnabled(true)
        -- 设置总览颜色：粉
    for i = 1, 3, 1 do
        BG.Frame[FB]["boss"..Maxb[FB]+2]["zhuangbei"..i]:SetTextColor(RGB("EE82EE"))
        BG.Frame[FB]["boss"..Maxb[FB]+2]["jine"..i]:SetTextColor(RGB("EE82EE"))
    end
        -- 设置工资颜色：蓝
    for i = 4, 5, 1 do
        BG.Frame[FB]["boss"..Maxb[FB]+2]["zhuangbei"..i]:SetTextColor(RGB("00BFFF"))
        BG.Frame[FB]["boss"..Maxb[FB]+2]["jine"..i]:SetTextColor(RGB("00BFFF"))
    end
        -- 设置工资人数的鼠标提示
    BG.Frame[FB]["boss"..Maxb[FB]+2]["jine4"]:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0)
        GameTooltip:ClearLines()
        GameTooltip:SetText("人数可自行修改。而总览和工资是不能修改的")
    end)
    BG.Frame[FB]["boss"..Maxb[FB]+2]["jine4"]:SetScript("OnLeave",function (self)
        GameTooltip:Hide()
    end)
end
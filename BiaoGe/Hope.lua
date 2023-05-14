local _, ADDONSELF = ...

local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local Listzhuangbei = ADDONSELF.Listzhuangbei
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi
local FrameHide = ADDONSELF.FrameHide

local pt = print

local yunqi = random(100)
function BG.HopeUI(FB)

    local p = {}
    local preWidget
    local framedown
    local frameright
    local framedownH
    local red,greed,blue = 1,1,1
    local touming1,touming2 = 0.2,0.4

    for n = 1, HopeMaxn[FB], 1 do
        for b = 1, HopeMaxb[FB], 1 do

                ------------------标题------------------
            do
                if b == 1 then
                    local version = BG["HopeFrame"..FB]:CreateFontString()
                    if n == 1 then
                        version:SetPoint("TOPRIGHT", BG.MainFrame, "TOPLEFT", 110, -35)
                    elseif n == 2 or n == 4 then
                        version:SetPoint("TOPRIGHT", frameright, "TOPLEFT", 300, 0)
                    elseif n == 3 then
                        version:SetPoint("TOPLEFT", framedownH, "TOPLEFT", -102, -70)
                    end
                    version:SetFontObject(GameFontNormal)
                    if n == 1 then
                        version:SetText("< |cffFFFFFF10人|r|cff00BFFF普通|r >")
                    elseif n == 2 then
                        version:SetText("< |cffFFFFFF25人|r|cff00BFFF普通|r >")
                    elseif n == 3 then
                        version:SetText("< |cffFFFFFF10人|r|cffFF0000英雄|r >")
                    elseif n == 4 then
                        version:SetText("< |cffFFFFFF25人|r|cffFF0000英雄|r >")
                    end
                    version:Show()
                    preWidget = version
                    
                    local version = BG["HopeFrame"..FB]:CreateFontString()
                    version:SetPoint("TOPLEFT", preWidget, "TOPRIGHT", 20, 0)
                    version:SetFontObject(GameFontNormal)
                    version:SetText("心愿1")
                    version:Show()
                    preWidget = version
                    framedown = version
            
                    local version = BG["HopeFrame"..FB]:CreateFontString()
                    version:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 176, 0)
                    version:SetFontObject(GameFontNormal)
                    version:SetText("心愿2")
                    version:Show()
                    preWidget = version
                    frameright = version
                end
            end
            for i = 1, HopeMaxi, 1 do
                ------------------底色材质------------------
                do
                        -- 先做底色材质1（鼠标悬停的）
                    local ds = CreateFrame("Button", nil, BG["HopeFrame"..FB])
                    ds:SetSize(152, 18)
                    ds:SetFrameLevel(102)
                    if i == 1 then
                        ds:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", -3, -5)
                    else
                        ds:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 173, -1)
                    end
                    ds:Hide()
                    local textrue= ds:CreateTexture()
                    textrue:SetAllPoints(ds)
                    textrue:SetColorTexture(red,greed,blue,touming1)
                    BG.HopeFrameDs[FB..1]["nandu"..n]["boss"..b]["ds"..i] = ds

                        -- 底色材质2（点击框体后）
                    local ds = CreateFrame("Button", nil, BG["HopeFrame"..FB])
                    ds:SetSize(152, 18)
                    ds:SetFrameLevel(103)
                    if i == 1 then
                        ds:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", -3, -5)
                    else
                        ds:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 173, -1)
                    end
                    ds:Hide()
                    local textrue= ds:CreateTexture()
                    textrue:SetAllPoints(ds)
                    textrue:SetColorTexture(red,greed,blue,touming2)
                    BG.HopeFrameDs[FB..2]["nandu"..n]["boss"..b]["ds"..i] = ds


                        -- 底色材质3（团长发的装备高亮）
                    local ds = CreateFrame("Button", nil, BG["HopeFrame"..FB])
                    ds:SetSize(152, 18)
                    ds:SetFrameLevel(101)
                    if i == 1 then
                        ds:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", -3, -5)
                    else
                        ds:SetPoint("TOPLEFT", preWidget, "TOPLEFT", 173, -1)
                    end
                    ds:Hide()
                    local textrue= ds:CreateTexture()
                    textrue:SetAllPoints(ds)
                    textrue:SetColorTexture(1,1,0,0.4)
                    BG.HopeFrameDs[FB..3]["nandu"..n]["boss"..b]["ds"..i] = ds

                end
                ------------------装备------------------
                do
                    local button = CreateFrame("EditBox", nil, BG["HopeFrame"..FB], "InputBoxTemplate")
                    button:SetSize(150, 20)
                    button:SetFrameLevel(110)
                    if i == 1 then
                        button:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -4)
                    else
                        button:SetPoint("TOPLEFT", framedown, "TOPLEFT", 176, 0)
                    end
                    button:SetAutoFocus(false)
                    button:Show()
                    local icon = button:CreateTexture(nil, 'ARTWORK')
                    icon:SetPoint('LEFT', -22, 0)
                    icon:SetSize(16, 16)
                    if BiaoGeA.Hope[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                        button:SetText(BiaoGeA.Hope[FB]["nandu"..n]["boss"..b]["zhuangbei"..i])
                    end
                    BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] = button
                    BiaoGeA.Hope[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] = button:GetText()
                    preWidget = button
                    if i == 1 then
                        framedown = button
                        if n == 1 or n == 3 and b == HopeMaxb[FB] then
                            framedownH = button
                        end
                    end
                        -- 内容改变时
                    local _,class = UnitClass("player")
                    button:SetScript("OnTextChanged", function(self)
                        local itemText = button:GetText()
                        local itemID = select(1, GetItemInfoInstant(itemText))
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
                            BiaoGeA.Hope[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i] = nil
                            BG.HopeFrame[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i]:Hide()
                            BG.HopeFrame[FB]["nandu"..n]["boss"..b]["jingzheng"..i]:Hide()
                        end

                        local num = BiaoGeA.filterClassNum  -- 隐藏
                        if num ~= 0 then
                            BG.FilterClass(FB,b,i,button,class,num,BiaoGeFilterTooltip,"HopeFrame",n)
                            C_Timer.After(0.01,function ()
                                BG.FilterClass(FB,b,i,button,class,num,BiaoGeFilterTooltip,"HopeFrame",n)
                            end)
                        end

                        BiaoGeA.Hope[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] = button:GetText()      -- 储存文本
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
                        -- 点击
                    button:SetScript("OnMouseDown", function(self,enter)
                        if enter == "RightButton" then  -- 右键清空格子
                            self:SetEnabled(false)
                            self:SetText("")
                            if BG.lastfocus then
                                BG.lastfocus:ClearFocus()
                            end
                            return
                        end
                        if IsShiftKeyDown() then
                            button:ClearFocus()
                            for n = 1, HopeMaxn[FB], 1 do
                                for b=1,HopeMaxb[FB] do
                                    for i=1,HopeMaxi do
                                        if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                                            BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:SetEnabled(false)
                                        end
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
                                for n = 1, HopeMaxn[FB], 1 do
                                    for b=1,HopeMaxb[FB] do
                                        for i=1,HopeMaxi do
                                            if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                                                BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:SetEnabled(false)
                                            end
                                        end
                                    end
                                end
                                BiaoGeA.Hope[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i] = true
                                BG.HopeFrame[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i]:Show()
                            end
                            return
                        end
                    end)
                    button:SetScript("OnMouseUp", function(self,enter)
                        for n = 1, HopeMaxn[FB], 1 do
                            for b=1,HopeMaxb[FB] do
                                for i=1,HopeMaxi do
                                    if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                                        BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:SetEnabled(true)
                                    end
                                end
                            end
                        end
                        if enter == "RightButton" then -- 右键清空格子
                            self:SetEnabled(true)
                        end
                    end)
                        -- 鼠标悬停在装备时
                    button:SetScript("OnEnter", function(self) 
                        BG.HopeFrameDs[FB..1]["nandu"..n]["boss"..b]["ds"..i]:Show()
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
                        BG.HopeFrameDs[FB..1]["nandu"..n]["boss"..b]["ds"..i]:Hide()
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
                        Listzhuangbei(self,b,FB,BiaoGeA.Hope[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i],BG.HopeFrame[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i],n)
                        if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i+1] then
                            BG.lastfocuszhuangbei2 = BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i+1]
                        else
                            BG.lastfocuszhuangbei2 = nil
                        end
                        BG.HopeFrameDs[FB..2]["nandu"..n]["boss"..b]["ds"..i]:Show()
                    end)
                        -- 失去光标时
                    button:SetScript("OnEditFocusLost", function(self)
                        self:HighlightText(0,0)
                        if BG.FrameZhuangbeiList then
                            BG.FrameZhuangbeiList:Hide()
                        end
                        BG.HopeFrameDs[FB..2]["nandu"..n]["boss"..b]["ds"..i]:Hide()
                    end)
                        -- 按TAB跳转右边
                    button:SetScript("OnTabPressed", function(self)
                        if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i+1] then
                            BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i+1]:SetFocus()
                        elseif BG.HopeFrame[FB]["nandu"..n]["boss"..b+1]["zhuangbei"..i] then
                            BG.HopeFrame[FB]["nandu"..n]["boss"..b+1]["zhuangbei"..i]:SetFocus()
                        elseif BG.HopeFrame[FB]["nandu"..n+1]["boss"..b]["zhuangbei"..1] then
                            BG.HopeFrame[FB]["nandu"..n+1]["boss"..b]["zhuangbei"..1]:SetFocus()
                        end
                    end)
                        -- 按ENTER跳转下边
                    button:SetScript("OnEnterPressed", function(self)
                        if BG.HopeFrame[FB]["nandu"..n]["boss"..b+1]["zhuangbei"..i] then
                            BG.HopeFrame[FB]["nandu"..n]["boss"..b+1]["zhuangbei"..i]:SetFocus()
                        elseif BG.HopeFrame[FB]["nandu"..n+1]["boss"..b]["zhuangbei"..i] then
                            BG.HopeFrame[FB]["nandu"..n+1]["boss"..b]["zhuangbei"..i]:SetFocus()
                        end
                    end)
                end
                ------------------已掉落装备------------------
                do
                    local frame = CreateFrame("Frame", nil, BG["HopeFrame"..FB])     -- 已掉落按钮
                    frame:SetSize(55, 23)
                    frame:SetPoint("RIGHT", preWidget, "RIGHT", 3, -1)
                    frame:SetFrameLevel(112)
                    local fontString = frame:CreateFontString()
                    fontString:SetAllPoints()
                    fontString:SetFontObject(GameFontNormal)
                    fontString:SetText(BG.STC_g1("已掉落"))
                    if BiaoGeA.Hope[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i] then
                        frame:Show()
                    else
                        frame:Hide()
                    end
                    BG.HopeFrame[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i] = frame
                
                    -- 鼠标悬停提示
                    frame:SetScript("OnEnter", function(self)
                        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0)
                        GameTooltip:ClearLines()
                        GameTooltip:SetText(BG.STC_g1("恭喜你，该装备已掉落").."\n右键取消提示")
                    end)
                    frame:SetScript("OnLeave",function (self)
                        GameTooltip:Hide()
                    end)
                    -- 单击触发
                    frame:SetScript("OnMouseDown", function(self,enter)
                        if enter == "RightButton" then  -- 右键清空格子
                            FrameHide(0)
                            BiaoGeA.Hope[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i] = nil
                            self:Hide()
                        end
                    end)
                end

                ------------------装备有竞争------------------
                do
                    local frame = CreateFrame("Frame", nil, BG["HopeFrame"..FB])
                    frame:SetSize(23, 23)
                    frame:SetPoint("RIGHT", BG.HopeFrame[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i], "LEFT", 0, 0)
                    -- frame:SetPoint("RIGHT", preWidget, "LEFT", 0, 0)
                    frame:SetFrameLevel(112)
                    local fontString = frame:CreateFontString()
                    fontString:SetAllPoints()
                    fontString:SetFont(STANDARD_TEXT_FONT,20,"OUTLINE")       -- 游戏主界面文字
                    -- fontString:SetFontObject(GameFontNormal)
                    BG.HopeFrame[FB]["nandu"..n]["boss"..b]["jingzhengtext"..i] = ""
                    fontString:SetText(BG.STC_r1(BG.HopeFrame[FB]["nandu"..n]["boss"..b]["jingzhengtext"..i]))
                    frame:Hide()
                    BG.HopeFrame[FB]["nandu"..n]["boss"..b]["jingzheng"..i] = frame
                    BG.HopeFrame[FB]["nandu"..n]["boss"..b]["jingzhengfontString"..i] = fontString
                
                    -- 鼠标悬停提示
                    frame:SetScript("OnEnter", function(self)
                        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0)
                        GameTooltip:ClearLines()
                        GameTooltip:SetText(BG.STC_r1("当前团队还有 "..BG.HopeFrame[FB]["nandu"..n]["boss"..b]["jingzhengtext"..i].." 人也许愿该装备！").."\n右键取消提示")
                    end)
                    frame:SetScript("OnLeave",function (self)
                        GameTooltip:Hide()
                    end)
                    -- 单击触发
                    frame:SetScript("OnMouseDown", function(self,enter)
                        if enter == "RightButton" then  -- 右键清空格子
                            FrameHide(0)
                            self:Hide()
                        end
                    end)
                end
            end
            ------------------BOSS名字------------------
            do
                local version = BG["HopeFrame"..FB]:CreateFontString()
                version:SetPoint("TOPRIGHT", BG.HopeFrame[FB]["nandu"..n]["boss"..b].zhuangbei1, "TOPLEFT", -28, -3)           
                version:SetFontObject(GameFontNormal)

                local bossname = BiaoGe[FB]["boss"..b]["bossname"]
                local color
                if strfind(bossname,"|cff") then
                    color = strsub(bossname,strfind(bossname,"|cff"),strfind(bossname,"|cff")+9)
                end
                if color then
                    version:SetText(color..BiaoGe[FB]["boss"..b].bossname2)
                else
                    version:SetText(BiaoGe[FB]["boss"..b].bossname2)
                end

                version:Show()
                BG.HopeFrame[FB]["nandu"..n]["boss"..b]["bossname"] = version
            end
        end
    end

    ------------------查询团队竞争------------------
    do
        local btjingzheng = CreateFrame("Button", nil, BG["HopeFrame"..FB], "UIPanelButtonTemplate")    -- 查询团队竞争按键
        btjingzheng:SetSize(130, 25)
        btjingzheng:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 1000, -50)
        btjingzheng:SetText("查询心愿竞争")
        btjingzheng:Show()
        btjingzheng:SetFrameLevel(105)
        BG["HopeJingZheng"..FB] = btjingzheng

        btjingzheng:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self,"ANCHOR_TOPLEFT",0,0)
            GameTooltip:ClearLines()
            GameTooltip:SetText("查询团队里，有多少人许愿跟你相同的装备")
        end)
        btjingzheng:SetScript("OnLeave",function (self)
            GameTooltip:Hide()
        end)
        btjingzheng:SetScript("OnClick",function (self) -- 点击
            if not IsInRaid() then
                print("不在团队，无法查询")
                return
            end
            BG.HopeJingzheng = {}
            local yes
            for n=1,HopeMaxn[FB] do
                for b=1,HopeMaxb[FB] do
                    for i=1,HopeMaxi do
                        if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                            BG.HopeFrame[FB]["nandu"..n]["boss"..b]["jingzheng"..i]:Hide()
                            local itemID = GetItemInfoInstant(BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:GetText())
                            if itemID then
                                BG.HopeJingzheng[itemID] = {}
                                C_ChatInfo.SendAddonMessage("BiaoGe", "Hope-"..FB.." "..itemID, "RAID")
                            end
                        end
                    end
                end
            end

            C_Timer.After(1.5,function () -- 2秒后出结果
                for n=1,HopeMaxn[FB] do
                    for b=1,HopeMaxb[FB] do
                        for i=1,HopeMaxi do
                            if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                                local itemID = GetItemInfoInstant(BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:GetText())
                                if itemID then
                                    for key, value in pairs(BG.HopeJingzheng) do
                                        if tonumber(itemID) == tonumber(key) and #BG.HopeJingzheng[key] ~= 0 then
                                            BG.HopeFrame[FB]["nandu"..n]["boss"..b]["jingzhengtext"..i] = #BG.HopeJingzheng[key]
                                            BG.HopeFrame[FB]["nandu"..n]["boss"..b]["jingzhengfontString"..i]:SetText(BG.STC_r1(#BG.HopeJingzheng[key]))
                                            BG.HopeFrame[FB]["nandu"..n]["boss"..b]["jingzheng"..i]:Show()
                                            yes = true
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if not yes then
                    pt(BG.STC_g1("恭喜你，当前团队没人许愿跟你相同的装备"))
                end
            end)
            self:SetEnabled(false)
            C_Timer.After(2,function ()
                self:SetEnabled(true)
            end)
        end)
    end

    ------------------分享心愿------------------
    do
        local f
        local xinyuan = {"分享心愿10PT","分享心愿25PT","分享心愿10H","分享心愿25H"}

        local xinyuan2 = {"10PT","25PT","10H","25H"}
        for n=1,HopeMaxn[FB] do
            local bt = CreateFrame("Button", nil, BG["HopeFrame"..FB], "UIPanelButtonTemplate")    -- 分享心愿按键
            bt:SetSize(130, 25)
            if n == 1 then
                bt:SetPoint("TOPLEFT", BG["HopeJingZheng"..FB], "BOTTOMLEFT", 0, -50)
            else
                bt:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0, -10)
            end
            bt:SetText(xinyuan[n])
            bt:SetFrameLevel(105)
            f = bt

            -- 鼠标悬停提示
            bt:SetScript("OnEnter", function(self)
                local text = "|cffffffff< 我 的 心 愿 >|r\n"
                text = text.."副本难度："..BG.STC_b1(BG[FB.."name"].." "..xinyuan2[n]).."\n"
                for b=1,HopeMaxb[FB] do
                    local link = {}
                    for i=1,HopeMaxi do
                        if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                            local _,l = GetItemInfo(BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:GetText())
                            if l then
                                table.insert(link,l)
                            end
                        end
                    end
                    local tx
                    if Size(link) ~= 0 then
                        tx = BiaoGe[FB]["boss"..b]["bossname2"].."："
                        for index, value in ipairs(link) do
                            tx = tx..value
                        end
                        text = text..tx.."\n"
                    end
                end
                GameTooltip:SetOwner(self,"ANCHOR_TOPLEFT",0,0)
                GameTooltip:ClearLines()
                GameTooltip:SetText(text)
            end)
            bt:SetScript("OnLeave",function (self)
                GameTooltip:Hide()
            end)

            -- 单击触发
            bt:SetScript("OnClick", function(self)
                FrameHide(0)
                if not BiaoGe["HopeSend"..FB] then return end
                local send = {"RAID","PARTY","GUILD","WHISPER"}
                local s
                if BiaoGe["HopeSend"..FB] == "频道：团队" then
                    s = 1
                    if not IsInRaid() then
                        print("不在团队，无法通报")
                        PlaySound(BG.sound1,"Master")
                        return
                    end
                end
                if BiaoGe["HopeSend"..FB] == "频道：队伍" then
                    s = 2
                    if not IsInGroup() then
                        print("不在队伍，无法通报")
                        PlaySound(BG.sound1,"Master")
                        return
                    end
                end
                if BiaoGe["HopeSend"..FB] == "频道：公会" then
                    s = 3
                    if not IsInGuild() then
                        print("没有公会，无法通报")
                        PlaySound(BG.sound1,"Master")
                        return
                    end
                end
                if BiaoGe["HopeSend"..FB] == "频道：私密" then
                    s = 4
                    if not UnitName("target") then
                        print("没有目标，无法通报")
                        PlaySound(BG.sound1,"Master")
                        return
                    end
                end

                self:SetEnabled(false)      -- 点击后按钮变灰2秒
                C_Timer.After(2,function ()
                    bt:SetEnabled(true)
                end)
                local text = "————我的心愿————"
                SendChatMessage(text,send[s],nil,UnitName("target"))
                text = "副本难度："..BG[FB.."name"].." "..xinyuan2[n]
                SendChatMessage(text,send[s],nil,UnitName("target"))
                for b=1,HopeMaxb[FB] do
                    local link = {}
                    for i=1,HopeMaxi do
                        if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                            local _,l = GetItemInfo(BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:GetText())
                            if l then
                                table.insert(link,l)
                            end
                        end
                    end
                    if Size(link) ~= 0 then
                        text = BiaoGe[FB]["boss"..b]["bossname2"].."："
                        for index, value in ipairs(link) do
                            text = text..value
                        end
                        SendChatMessage(text,send[s],nil,UnitName("target"))
                    end
                end
                text = "——感谢使用金团表格——"
                SendChatMessage(text,send[s],nil,UnitName("target"))
                PlaySoundFile(BG.sound2)
            end)
        end

            -- 频道
        local dropDown = CreateFrame("FRAME", nil, BG["HopeFrame"..FB], "UIDropDownMenuTemplate")
        dropDown:SetPoint("TOP", f, "BOTTOM",0,-10)
        UIDropDownMenu_SetWidth(dropDown, 100)
        if not BiaoGe["HopeSend"..FB] then
            BiaoGe["HopeSend"..FB] = "频道：团队"
            UIDropDownMenu_SetText(dropDown, "频道：团队")
        else
            UIDropDownMenu_SetText(dropDown, BiaoGe["HopeSend"..FB])
        end
        UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
            FrameHide(0)
            PlaySound(BG.sound1,"Master")
            local info = UIDropDownMenu_CreateInfo()
                info.text, info.func = "团队", function ()
                    BiaoGe["HopeSend"..FB] = "频道：团队"
                    UIDropDownMenu_SetText(dropDown, BiaoGe["HopeSend"..FB])
                    FrameHide(0)
                    PlaySound(BG.sound1,"Master")
                end
            UIDropDownMenu_AddButton(info)
            local info = UIDropDownMenu_CreateInfo()
                info.text, info.func = "队伍", function ()
                    BiaoGe["HopeSend"..FB] = "频道：队伍"
                    UIDropDownMenu_SetText(dropDown, BiaoGe["HopeSend"..FB])
                    FrameHide(0)
                    PlaySound(BG.sound1,"Master")
                end 
                UIDropDownMenu_AddButton(info)
            local info = UIDropDownMenu_CreateInfo()
                info.text, info.func = "公会", function ()
                    BiaoGe["HopeSend"..FB] = "频道：公会"
                    UIDropDownMenu_SetText(dropDown, BiaoGe["HopeSend"..FB])
                    FrameHide(0)
                    PlaySound(BG.sound1,"Master")
                end 
                UIDropDownMenu_AddButton(info)
            local info = UIDropDownMenu_CreateInfo()
                info.text, info.func = "私密目标", function ()
                    BiaoGe["HopeSend"..FB] = "频道：私密"
                    UIDropDownMenu_SetText(dropDown, BiaoGe["HopeSend"..FB])
                    FrameHide(0)
                    PlaySound(BG.sound1,"Master")
                end 
                UIDropDownMenu_AddButton(info)
        end)
    end


    ------------------文字------------------
    do
        local xinyuantext = BG["HopeFrame"..FB]:CreateFontString()
        xinyuantext:SetPoint("TOPLEFT", framedownH, "TOPLEFT", -95, -40)
        -- xinyuantext:SetPoint("TOPLEFT", framedownH, "TOPLEFT", -102, -40)
        xinyuantext:SetFont(STANDARD_TEXT_FONT,20,"OUTLINE")
        xinyuantext:SetText(BG.STC_g1("心愿清单："))
        -- xinyuantext:SetText("< "..BG.STC_g1("心愿清单").." >")

        local text = BG["HopeFrame"..FB]:CreateFontString()
        text:SetPoint("LEFT",xinyuantext,"RIGHT",5,-1)
        text:SetFont(STANDARD_TEXT_FONT,13,"OUTLINE")
        text:SetText(BG.STC_g2("心愿装备只要掉落就会有提醒，并且掉落后自动关注团长拍卖"))

        local rolltext = BG["HopeFrame"..FB]:CreateFontString()
        rolltext:SetPoint("LEFT",text,"RIGHT",160,0)
        rolltext:SetFont(STANDARD_TEXT_FONT,13,"OUTLINE")
        rolltext:SetText(BG.STC_b1("你今天的运气指数(1-100)："))

        local text = BG["HopeFrame"..FB]:CreateFontString()
        text:SetPoint("LEFT",rolltext,"RIGHT",5,0)
        text:SetFont(STANDARD_TEXT_FONT,20,"OUTLINE")
        text:SetText(BG.STC_b1(yunqi))
    end
end

------------------处理查询团队竞争事件------------------
do
    local f=CreateFrame("Frame")    -- 团队消息
    f:RegisterEvent("CHAT_MSG_ADDON")
    f:SetScript("OnEvent", function(self,even,...)
        local prefix, msg, distType, sender = ...
        if prefix ~= "BiaoGe" then return end
        if distType ~= "RAID" then return end
        local sendername = strsplit("-", sender)
        local playername = UnitName("player")
        if sendername == playername then return end
        if strfind(msg, "^(Hope)") then
            local _, fbitemID = strsplit("-", msg)
            local FB, itemID = strsplit(" ", fbitemID)
            itemID = tonumber(itemID)
            if not itemID then return end
            for n=1,HopeMaxn[FB] do
                for b=1,HopeMaxb[FB] do
                    for i=1,HopeMaxi do
                        if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                            if itemID == GetItemInfoInstant(BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:GetText()) then
                                C_ChatInfo.SendAddonMessage("BiaoGe", "True-"..itemID, "WHISPER", sender)
                                return
                            end
                        end
                    end
                end
            end
        end
    end)

    local f=CreateFrame("Frame")    -- 私密消息
    f:RegisterEvent("CHAT_MSG_ADDON")
    f:SetScript("OnEvent", function (self,even,...)
        local prefix, msg, distType, sender = ...
        if prefix ~= "BiaoGe" then return end
        if distType ~= "WHISPER" then return end
        if strfind(msg, "^(True)") then
        local _, itemID = strsplit("-", msg)
            itemID = tonumber(itemID)
            if not itemID then return end
            table.insert(BG.HopeJingzheng[itemID],itemID)
        end
    end)
end



-- local prefix = "SomePrefix123"
-- local playerName = UnitName("player")

-- local function OnEvent(self, event, ...)
--     if event == "CHAT_MSG_ADDON" then
--         print(event, ...)
--     end
-- end
-- local f = CreateFrame("Frame")
-- f:RegisterEvent("CHAT_MSG_ADDON")
-- f:RegisterEvent("PLAYER_ENTERING_WORLD")
-- f:SetScript("OnEvent", OnEvent)
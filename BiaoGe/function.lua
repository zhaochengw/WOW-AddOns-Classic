local _, ADDONSELF = ...

local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

local pt = print
------------------函数：是否空表------------------
local function Size(t)
    local s = 0
    for k, v in pairs(t) do
        if v ~= nil then s = s + 1 end
    end
    return s
end
ADDONSELF.Size = Size
------------------函数：第几个BOSS------------------
local function BossNum(FB,b,t)
    local back = 0
    if FB == "ICC" then
        if t == 1 then
            t = 0
        elseif t == 2 then
            t = 6
        elseif t == 3 then
            t = 12
        end
    elseif FB == "TOC" then
        if t == 1 then
            t = 0
        elseif t == 2 then
            t = 5
        elseif t == 3 then
            t = 8
        end
    elseif FB == "ULD" then
        if t == 1 then
            t = 0
        elseif t == 2 then
            t = 6
        elseif t == 3 then
            t = 12
        elseif t == 4 then
            t = 16
        end
    elseif FB == "NAXX" then
        if t == 1 then
            t = 0
        elseif t == 2 then
            t = 6
        elseif t == 3 then
            t = 12
        elseif t == 4 then
            t = 16
        end
    end    
    back = b + t
    return back
end
ADDONSELF.BossNum = BossNum

------------------函数：把16进制颜色转换成0-1RGB------------------
local function RGB(hex,Alpha)
    local red = string.sub(hex, 1, 2)
    local green = string.sub(hex, 3, 4)
    local blue = string.sub(hex, 5, 6)
 
    red = tonumber(red, 16)/255
    green = tonumber(green, 16)/255
    blue = tonumber(blue, 16)/255

    if Alpha then
        return red,green,blue,Alpha
    else
        return red,green,blue
    end
        
end
ADDONSELF.RGB = RGB

------------------函数：设置颜色（0-1代码变为16进制颜色）------------------
local function RGB_16(name,c1,c2,c3)
    local c1,c2,c3 = c1,c2,c3
    if not c1 then
        c1,c2,c3 = name:GetTextColor()
        name = name:GetText()
    end
    if tonumber(c1) and name then
        local r = string.format("%X", tonumber(c1)*255)
        local g = string.format("%X", tonumber(c2)*255)
        local b = string.format("%X", tonumber(c3)*255)
        local c = r..g..b
        c = "|cff"..c..name.."|r"
        return c
    end
end
ADDONSELF.RGB_16 = RGB_16

------------------函数：获取名字的职业颜色RGB------------------
local function GetClassRGB(name)
    local _,class = UnitClass(name)
    local c1,c2,c3 = 1,1,1
    if class then
        c1,c2,c3 = GetClassColor(class)
    end
    return c1,c2,c3
end
ADDONSELF.GetClassRGB = GetClassRGB

------------------函数：设置名字为职业颜色CFF代码（|cffFFFFFF名字|r）------------------
local function SetClassCFF(name)
    local _,class = UnitClass(name)
    local c4 = ""
    if class then
        c4 = select(4,GetClassColor(class))
        c4 = "|c"..c4..name.."|r"
        return c4
    else
        return name
    end
end
ADDONSELF.SetClassCFF = SetClassCFF

------------------函数：总收入------------------
local function Sumjine(BiaoGeFB,MaxbFB,MaxiFB)
    local sum = 0
    local n = 0
    for b = 1, MaxbFB, 1 do
        for i = 1, MaxiFB, 1 do
            if BiaoGeFB["boss"..b]["jine"..i] then
                n = tonumber(BiaoGeFB["boss"..b]["jine"..i])
                if n then
                    sum = sum + n
                end
            end

        end                
    end
    return sum
end
ADDONSELF.Sumjine = Sumjine

------------------函数：总支出------------------
local function SumZC(BiaoGeFB,MaxbFB,MaxiFB)
    local sum = 0
    local n = 0
    for i = 1, MaxiFB, 1 do
        if BiaoGeFB["boss"..MaxbFB+1]["jine"..i] then
            n = tonumber(BiaoGeFB["boss"..MaxbFB+1]["jine"..i])
            if n then
                sum = sum + n
            end
        end
    end
    return sum
end
ADDONSELF.SumZC = SumZC

------------------函数：净收入------------------
local function SumJ(BiaoGeFB,MaxbFB,MaxiFB)
    local jing = 0
    local n1 = tonumber(BiaoGeFB["boss"..MaxbFB+2]["jine1"])
    local n2 = tonumber(BiaoGeFB["boss"..MaxbFB+2]["jine2"])
    if n1 and n2 then
        jing = n1 - n2
    end
    return jing
end
ADDONSELF.SumJ = SumJ

------------------函数：人均工资------------------
local function SumGZ(BiaoGeFB,MaxbFB,MaxiFB)
    local gz = 0
    local n1 = tonumber(BiaoGeFB["boss"..MaxbFB+2]["jine3"])
    local n2 = tonumber(BiaoGeFB["boss"..MaxbFB+2]["jine4"])
    if n1 and n2 then
        gz = math.modf(n1 / n2)
    end
    return gz
end
ADDONSELF.SumGZ = SumGZ

------------------函数：买家按职业排序-----------------
local function Classpx(zhiye)
    local Classpxname1 = {}
    local Classpxclass1 = {}
    local Classpxid = {}
    local num = GetNumGroupMembers()
    local raid
    for i = 1, num, 1 do
        raid = "raid"..i
        local name = UnitName(raid)
        local _,class,id = UnitClass(raid)
        if zhiye == "jianshang" then
            if id == 2 or id == 11 or id == 5 then
                table.insert(Classpxname1,name)      -- 保存名字
                table.insert(Classpxclass1,class)       -- 保存职业
                table.insert(Classpxid,id)       -- 保存职业ID
            end
        else
            table.insert(Classpxname1,name)      -- 保存名字
            table.insert(Classpxclass1,class)       -- 保存职业
            table.insert(Classpxid,id)       -- 保存职业ID
        end
    end

    local Classpxname2 = {}
    local Classpxclass2 = {}
    for i = 1, num, 1 do
        if Classpxid[i] == 6 then       -- DK
            table.insert(Classpxname2,Classpxname1[i])
            table.insert(Classpxclass2,Classpxclass1[i])
        end
    end
    for i = 1, num, 1 do
        if Classpxid[i] == 2 then       -- QS
            table.insert(Classpxname2,Classpxname1[i])
            table.insert(Classpxclass2,Classpxclass1[i])
        end
    end
    for i = 1, num, 1 do
        if Classpxid[i] == 1 then       -- ZS
            table.insert(Classpxname2,Classpxname1[i])
            table.insert(Classpxclass2,Classpxclass1[i])
        end
    end
    for i = 1, num, 1 do
        if Classpxid[i] == 7 then       -- SM
            table.insert(Classpxname2,Classpxname1[i])
            table.insert(Classpxclass2,Classpxclass1[i])
        end
    end
    for i = 1, num, 1 do
        if Classpxid[i] == 3 then       -- LR
            table.insert(Classpxname2,Classpxname1[i])
            table.insert(Classpxclass2,Classpxclass1[i])
        end
    end
    for i = 1, num, 1 do
        if Classpxid[i] == 11 then       -- XD
            table.insert(Classpxname2,Classpxname1[i])
            table.insert(Classpxclass2,Classpxclass1[i])
        end
    end
    for i = 1, num, 1 do
        if Classpxid[i] == 4 then       -- DZ
            table.insert(Classpxname2,Classpxname1[i])
            table.insert(Classpxclass2,Classpxclass1[i])
        end
    end
    for i = 1, num, 1 do
        if Classpxid[i] == 8 then       -- FS
            table.insert(Classpxname2,Classpxname1[i])
            table.insert(Classpxclass2,Classpxclass1[i])
        end
    end
    for i = 1, num, 1 do
        if Classpxid[i] == 9 then       -- SS
            table.insert(Classpxname2,Classpxname1[i])
            table.insert(Classpxclass2,Classpxclass1[i])
        end
    end
    for i = 1, num, 1 do
        if Classpxid[i] == 5 then       -- MS
            table.insert(Classpxname2,Classpxname1[i])
            table.insert(Classpxclass2,Classpxclass1[i])
        end
    end
    return Classpxname2,Classpxclass2
end
ADDONSELF.Classpx = Classpx
-- BG.ClassPaiXu = Classpx

------------------函数：买家下拉列表------------------    -- FramePaiMaiMsg：nil就是要显示拍卖聊天框，focus：0就是要清空光标,zhiye："jianshang"就是只显示骑士、德鲁伊、牧师
local function Listmaijia(maijia,FramePaiMaiMsg,focus,zhiye)
    -- 背景框
    local frame
    if not FramePaiMaiMsg then
        frame = BG.MainFrame
    else
        frame = BG.helperFrame
    end
    BG.FrameMaijiaList = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    BG.FrameMaijiaList:SetWidth(300)
    BG.FrameMaijiaList:SetHeight(230)
    BG.FrameMaijiaList:SetFrameLevel(120)
    BG.FrameMaijiaList:SetBackdrop({
        -- bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16
    })
    -- BG.FrameMaijiaList:SetBackdropColor(0, 0, 0, 1)
    BG.FrameMaijiaList:SetPoint("TOPLEFT",maijia,"BOTTOMLEFT",-9,2)
    BG.FrameMaijiaList:Show()
    BG.FrameMaijiaList:SetScript("OnMouseUp", function(self)
    end)
    local ds = BG.FrameMaijiaList:CreateTexture()
    ds:SetSize(292,222)
    ds:SetPoint("CENTER")
    ds:SetColorTexture(0,0,0,0.9)
    -- 聊天记录
    if not FramePaiMaiMsg then
        if BG.FramePaiMaiMsg then
            BG.FramePaiMaiMsg:SetParent(BG.FrameMaijiaList)
            BG.FramePaiMaiMsg:ClearAllPoints()
            BG.FramePaiMaiMsg:SetPoint("TOPRIGHT",BG.FrameMaijiaList,"TOPLEFT",0,0)
            BG.FramePaiMaiMsg:Show()
            BG.FramePaiMaiMsg2:ScrollToBottom()
        end
    end

    -- 下拉列表
    local framedown
    local frameright = BG.FrameMaijiaList
    local Classpxname,Classpxclass = Classpx(zhiye)
    for t=1,3 do
        for i=1,10 do
            local button=CreateFrame("EditBox",nil,BG.FrameMaijiaList,"InputBoxTemplate")
            button:SetSize(90, 20)
            button:SetFrameLevel(125)
            if t >= 2 and i == 1 then
                button:SetPoint("TOPLEFT", frameright, "TOPLEFT", 97, 0)
                frameright = button
            end
            if t == 1 and i == 1 then
                button:SetPoint("TOPLEFT", frameright, "TOPLEFT", 10, -5)
                frameright = button
            end
            if i > 1 then
                button:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -2)
            end
            if not zhiye and not IsInRaid() and t == 1 and i == 1 then  -- 单人时
                button:SetText(UnitName("player"))
                button:SetTextColor(GetClassRGB(UnitName("player")))
            end
            if Classpxname then
                if Classpxname[(t-1)*10+i] then
                    button:SetText(Classpxname[(t-1)*10+i])
                end
                if Classpxname[(t-1)*10+i] then
                    button:SetTextColor(GetClassRGB(Classpxname[(t-1)*10+i]))
                end
            end
            button:Show()
            framedown = button
            -- 点击名字时触发
            button:SetScript("OnMouseDown", function(self,enter)
                if enter == "RightButton" then  -- 右键清空格子
                    if BG.lastfocus then
                        BG.lastfocus:ClearFocus()
                    end
                    return
                end
                maijia:SetText(button:GetText())
                maijia:SetTextColor(button:GetTextColor())
                BG.FrameMaijiaList:Hide()
                if focus == 0 then
                    if BG.lastfocus then
                        BG.lastfocus:ClearFocus()
                    end
                end
            end)
        end
    end
end
ADDONSELF.Listmaijia = Listmaijia

local function Filter(bt)
    
end
------------------函数：装备下拉列表------------------    
local function Listzhuangbei(zhuangbei,bossnum,FB,BiaoGeguanzhu,BGFrameguanzhu,hopenandu)  
    local p = GetRaidDifficultyID()
    local nandu
    local lootlink = {}
    local lootlevel = {}
    if p == 3 or p == 175 then
        nandu = "P10"
    elseif p == 4 or p == 176 then
        nandu = "P25"
    elseif p == 5 or p == 193 then
        nandu = "H10"
    elseif p == 6 or p == 194 then
        nandu = "H25"
    end
    if hopenandu then
        if hopenandu == 1 then
            nandu = "P10"
        elseif hopenandu == 2 then
            nandu = "P25"
        elseif hopenandu == 3 then
            nandu = "H10"
        elseif hopenandu == 4 then
            nandu = "H25"
        end
    end
    -- pt(FB,nandu)
    if BG.Loot[FB][nandu] then
        if BG.Loot[FB][nandu]["boss"..bossnum] then
            local sum = #BG.Loot[FB][nandu]["boss"..bossnum]
            for index, value in ipairs(BG.Loot[FB][nandu]["boss"..bossnum]) do
                local name,link,quality,level,_,_,_,_,_,_,_,typeID=GetItemInfo(value)
                table.insert(lootlink,link)
                table.insert(lootlevel,level)
            end
            -- 背景框    
            BG.FrameZhuangbeiList = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
            BG.FrameZhuangbeiList:SetWidth(480)
            BG.FrameZhuangbeiList:SetHeight(230)
            BG.FrameZhuangbeiList:SetFrameLevel(120)
            BG.FrameZhuangbeiList:SetBackdrop({
                -- bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 16
            })
            -- BG.FrameZhuangbeiList:SetBackdropColor(0, 0, 0, 1)
            BG.FrameZhuangbeiList:SetPoint("TOPLEFT",zhuangbei,"BOTTOMLEFT",-9,2)
            BG.FrameZhuangbeiList:Show()
            BG.FrameZhuangbeiList:SetScript("OnMouseUp", function(self)
            end)
            local ds = BG.FrameZhuangbeiList:CreateTexture()
            ds:SetSize(472,222)
            ds:SetPoint("CENTER")
            ds:SetColorTexture(0,0,0,0.9)
            -- 提示文字
            local text = BG.FrameZhuangbeiList:CreateFontString()
            text:SetPoint("TOPLEFT",BG.FrameZhuangbeiList,"BOTTOMLEFT",3,0)
            text:SetFont(STANDARD_TEXT_FONT,14,"OUTLINE")       -- 游戏主界面文字
            if hopenandu then
                text:SetText(BG.STC_b1("（ALT+点击可设置为已掉落，SHIFT+点击可发送装备，CTRL+点击可通报历史价格）"))
            else
                text:SetText(BG.STC_b1("（ALT+点击可关注装备，SHIFT+点击可发送装备，CTRL+点击可通报历史价格）"))
            end
            -- 下拉列表
            local framedown
            local frameright = BG.FrameZhuangbeiList
            local _,class = UnitClass("player")
            BG.ZhuangbeiList = {}
            if #lootlink == sum then
                for t=1,3 do
                    for i=1,10 do
                        local button=CreateFrame("EditBox",nil,BG.FrameZhuangbeiList,"InputBoxTemplate")
                        button:SetSize(150, 20)
                        button:SetFrameLevel(125)
                        local icon = button:CreateTexture(nil, 'ARTWORK')
                        icon:SetPoint('LEFT', -4, 0)
                        icon:SetSize(16, 16)
                        if t >= 2 and i == 1 then
                            button:SetPoint("TOPLEFT", frameright, "TOPLEFT", 157, 0)
                            frameright = button
                        end
                        if t == 1 and i == 1 then
                            button:SetPoint("TOPLEFT", frameright, "TOPLEFT", 10, -5)
                            frameright = button
                        end
                        if i > 1 then
                            button:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -2)
                        end
                        if lootlink[(t-1)*10+i] then
                            button:SetText(lootlink[(t-1)*10+i].."|cff".."9370DB".."("..lootlevel[(t-1)*10+i]..")")
                            button:SetTextInsets(14,0,0,0)
                            local itemID = select(1, GetItemInfoInstant(lootlink[(t-1)*10+i]))
                            local itemIcon = GetItemIcon(itemID)
                            if itemIcon then
                                icon:SetTexture(itemIcon)
                            else
                                icon:SetTexture(nil)
                            end

                            local num = BiaoGeA.filterClassNum  -- 隐藏
                            if num ~= 0 then
                                BG.FilterClass(nil,nil,nil,button,class,num,BiaoGeFilterTooltip,"zhuangbei")
                            end
                        end
                        button:Show()
                        BG.ZhuangbeiList["button"..(t-1)*10+i] = button
                        -- 鼠标悬停在装备时
                        button:SetScript("OnEnter", function(self) 
                            GameTooltip:SetOwner(self, "ANCHOR_RIGHT",-50,0)
                            GameTooltip:ClearLines()
                            local Link = button:GetText()
                            local itemID = select(1, GetItemInfoInstant(Link))
                            if itemID then
                                GameTooltip:SetItemByID(itemID)
                                GameTooltip:Show()
                                BG.HistoryJine(FB,itemID)
                            end
                        end)
                        button:SetScript("OnLeave", function(self) 
                            GameTooltip:Hide()
                            if BG["HistoryJineFrameDB1"] then
                                for i=1,BG.HistoryJineFrameDBMax do
                                    BG["HistoryJineFrameDB"..i]:Hide()
                                end
                                BG.HistoryJineFrame:Hide()
                            end
                        end)
                        -- 点击时触发
                        button:SetScript("OnMouseDown", function(self,enter)
                            if enter == "RightButton" then  -- 右键清空格子
                                if BG.lastfocus then
                                    BG.lastfocus:ClearFocus()
                                end
                                return
                            end
                            if lootlink[(t-1)*10+i] then
                                if IsShiftKeyDown() then
                                    _G.ChatFrame1EditBox:Show()
                                    _G.ChatFrame1EditBox:SetFocus()
                                    _G.ChatFrame1EditBox:Insert(lootlink[(t-1)*10+i])
                                    zhuangbei:ClearFocus()
                                    return
                                end
                                if IsControlKeyDown() then
                                    BG.TongBaoHis(button,BG.HistoryJineDB)
                                    zhuangbei:ClearFocus()
                                    return
                                end
                                zhuangbei:SetText(lootlink[(t-1)*10+i])
                                if IsAltKeyDown() then
                                    BiaoGeguanzhu = true
                                    BGFrameguanzhu:Show()
                                end
                            end
                            BG.FrameZhuangbeiList:Hide()
                            zhuangbei:ClearFocus()
                        end)
                        framedown = button
                    end
                end
            else
                C_Timer.After(0.01,function ()
                    lootlink = {}
                    lootlevel = {}
                    for index, value in ipairs(BG.Loot[FB][nandu]["boss"..bossnum]) do
                        local name,link,quality,level,_,_,_,_,_,_,_,typeID=GetItemInfo(value)
                        table.insert(lootlink,link)
                        table.insert(lootlevel,level)
                    end
                    for t=1,3 do
                        for i=1,10 do
                            local button=CreateFrame("EditBox",nil,BG.FrameZhuangbeiList,"InputBoxTemplate")
                            button:SetSize(150, 20)
                            button:SetFrameLevel(125)
                            local icon = button:CreateTexture(nil, 'ARTWORK')
                            icon:SetPoint('LEFT', -4, 0)
                            icon:SetSize(16, 16)
                            if t >= 2 and i == 1 then
                                button:SetPoint("TOPLEFT", frameright, "TOPLEFT", 157, 0)
                                frameright = button
                            end
                            if t == 1 and i == 1 then
                                button:SetPoint("TOPLEFT", frameright, "TOPLEFT", 10, -5)
                                frameright = button
                            end
                            if i > 1 then
                                button:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -2)
                            end
                            if lootlink[(t-1)*10+i] then
                                button:SetText(lootlink[(t-1)*10+i].."|cff".."9370DB".."("..lootlevel[(t-1)*10+i]..")")
                                button:SetTextInsets(14,0,0,0)
                                local itemID = select(1, GetItemInfoInstant(lootlink[(t-1)*10+i]))
                                local itemIcon = GetItemIcon(itemID)
                                if itemIcon then
                                    icon:SetTexture(itemIcon)
                                else
                                    icon:SetTexture(nil)
                                end

                                local num = BiaoGeA.filterClassNum  -- 隐藏
                                if num ~= 0 then
                                    BG.FilterClass(nil,nil,nil,button,class,num,BiaoGeFilterTooltip,"zhuangbei")
                                end
                            end
                            button:Show()
                            BG.ZhuangbeiList["button"..(t-1)*10+i] = button
                            -- 鼠标悬停在装备时
                            button:SetScript("OnEnter", function(self) 
                                GameTooltip:SetOwner(self, "ANCHOR_RIGHT",-70,0)
                                GameTooltip:ClearLines()
                                local Link = button:GetText()
                                local itemID = select(1, GetItemInfoInstant(Link))
                                if itemID then
                                GameTooltip:SetItemByID(itemID)
                                GameTooltip:Show()
                                end
                            end)
                            button:SetScript("OnLeave", function(self) 
                                GameTooltip:Hide() 
                            end)
                            -- 点击时触发
                            button:SetScript("OnMouseDown", function(self,enter)
                                if enter == "RightButton" then  -- 右键清空格子
                                    if BG.lastfocus then
                                        BG.lastfocus:ClearFocus()
                                    end
                                    return
                                end
                                if lootlink[(t-1)*10+i] then
                                    if IsShiftKeyDown() then
                                        _G.ChatFrame1EditBox:Show()
                                        _G.ChatFrame1EditBox:SetFocus()
                                        _G.ChatFrame1EditBox:Insert(lootlink[(t-1)*10+i])
                                        zhuangbei:ClearFocus()
                                        return
                                    end
                                    if IsControlKeyDown() then
                                        BG.TongBaoHis(button,BG.HistoryJineDB)
                                        zhuangbei:ClearFocus()
                                        return
                                    end
                                    zhuangbei:SetText(lootlink[(t-1)*10+i])
                                    if IsAltKeyDown() then
                                        BiaoGeguanzhu = true
                                        BGFrameguanzhu:Show()
                                    end
                                end
                                BG.FrameZhuangbeiList:Hide()
                                zhuangbei:ClearFocus()
                            end)
                            framedown = button
                        end
                    end
                end)
            end
        end
    end
end
ADDONSELF.Listzhuangbei = Listzhuangbei

------------------函数：金额下拉列表------------------
local function Listjine(jine,FB,b,i)
    -- 背景框
    BG.FrameJineList = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
    BG.FrameJineList:SetWidth(95)
    BG.FrameJineList:SetHeight(230)
    BG.FrameJineList:SetFrameLevel(120)
    BG.FrameJineList:SetBackdrop({
        -- bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16
    })
    -- BG.FrameJineList:SetBackdropColor(0, 0, 0, 1)
    BG.FrameJineList:SetPoint("TOPLEFT",jine,"BOTTOMLEFT",-9,2)
    BG.FrameJineList:Show()
    BG.FrameJineList:SetScript("OnMouseUp", function(self)
    end)
    local ds = BG.FrameJineList:CreateTexture()
    ds:SetSize(87,222)
    ds:SetPoint("CENTER")
    ds:SetColorTexture(0,0,0,0.8)

    local text = BG.FrameJineList:CreateFontString()
    text:SetPoint("TOP",BG.FrameJineList,"TOP",0,-10)
    text:SetFontObject(GameFontNormal)    -- 普通设置方法
    text:SetText("欠款金额")
    text:SetTextColor(1,0,0)

    local edit = CreateFrame("EditBox", nil, BG.FrameJineList, "InputBoxTemplate")
    edit:SetSize(80, 20)
    edit:SetTextColor(1,0,0)
    edit:SetPoint("TOP",text,"BOTTOM",2,-5)
    if BiaoGe[FB]["boss"..b]["qiankuan"..i] then
        if BiaoGe[FB]["boss"..b]["qiankuan"..i] == "" or BiaoGe[FB]["boss"..b]["qiankuan"..i] == 0 then
            edit:SetText("")
        else
            edit:SetText(BiaoGe[FB]["boss"..b]["qiankuan"..i])
        end
    end
    edit:SetNumeric(true)
    edit:SetAutoFocus(false)
    BG.FrameQianKuanEdit = edit
    edit:SetScript("OnTextChanged", function(self)
        if BiaoGe.AutoJine0 == 1 then
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
        BiaoGe[FB]["boss"..b]["qiankuan"..i] = self:GetText()
        if BiaoGe[FB]["boss"..b]["qiankuan"..i] == "" or BiaoGe[FB]["boss"..b]["qiankuan"..i] == "0" then
            BG.Frame[FB]["boss"..b]["qiankuan"..i]:Hide()
        else
            BG.Frame[FB]["boss"..b]["qiankuan"..i]:Show()
        end
    end)
    edit:SetScript("OnEscapePressed", function(self)
        BG.FrameJineList:Hide()
    end)
    -- 点击时
    edit:SetScript("OnMouseDown", function(self,enter)
        if enter == "RightButton" then  -- 右键清空格子
            self:SetEnabled(false)
            self:SetText("")
        end
    end)
    edit:SetScript("OnMouseUp", function(self,enter)
        if enter == "RightButton" then  -- 右键清空格子
            self:SetEnabled(true)
        end
    end)
end
ADDONSELF.Listjine  = Listjine


------------------函数：窗口切换动画------------------
local function FrameDongHua(frame,h2,w2)
    local h1 = frame:GetHeight()
    local w1 = frame:GetWidth()
    local Time = 0.5
    local T = 50
    local t1 = Time/T    
    local t2 = Time/T  
    if w1 > w2 then
        for i = T , 1 ,-1 do
            C_Timer.After(t1,function ()
                frame:SetWidth(w2+(w1-w2)*((i-1)/T))       -- 窗口变小
            end)
            t1 = t1 + Time/T
        end    
    elseif w2 > w1 then
        for i = 1 , T ,1 do
            C_Timer.After(t1,function ()
                frame:SetWidth(w1+(w2-w1)*(i/T))       -- 窗口变大
            end)
            t1 = t1 + Time/T
        end
    end
    if h1 > h2 then
        for i = T , 1 ,-1 do
            C_Timer.After(t2,function ()
                frame:SetHeight(h2+(h1-h2)*((i-1)/T))       -- 窗口变小
            end)
            t2 = t2 + Time/T
        end    
    elseif h2 > h1 then
        for i = 1 , T ,1 do
            C_Timer.After(t2,function ()
                frame:SetHeight(h1+(h2-h1)*(i/T))       -- 窗口变大
            end)
            t2 = t2 + Time/T
        end
    end
end
ADDONSELF.FrameDongHua = FrameDongHua

------------------函数：隐藏窗口------------------   -- 0：隐藏焦点+全部框架，1：隐藏全部框架，2：隐藏除历史表格外的框架
local function FrameHide(num)
    if num == 0 then
        if BG.lastfocus then
            BG.lastfocus:ClearFocus()
        end
    end
    if BG.FrameZhuangbeiList then
        BG.FrameZhuangbeiList:Hide()
    end
    if BG.FrameMaijiaList then
        BG.FrameMaijiaList:Hide()
    end
    if BG.FrameJineList then
        BG.FrameJineList:Hide()
    end
    if BG.FrameSheZhi then
        BG.FrameSheZhi:Hide()
    end
    if BG.frameZhuFuList then
        BG.frameZhuFuList:Hide()
    end
    if num ~= 2 then   -- num是0就取消焦点，其他数字就不取消焦点
        if BG.History then
            if BG.History.List then
                BG.History.List:Hide()
            end
        end
    end
end
ADDONSELF.FrameHide = FrameHide

------------------函数：清空表格------------------
function BG.Frame:QingKong(BiaoGeFB,FB,MaxbFB,MaxiFB,BiaoGeAFB)
    if BG["Frame"..FB] and BG["Frame"..FB]:IsVisible() or not BiaoGeAFB then
        for b=1,MaxbFB do
            for i=1,MaxiFB do
                if self[FB]["boss"..b]["zhuangbei"..i] then
                    self[FB]["boss"..b]["zhuangbei"..i]:SetText("")
                    self[FB]["boss"..b]["maijia"..i]:SetText("")
                    self[FB]["boss"..b]["jine"..i]:SetText("")
                    self[FB]["boss"..b]["qiankuan"..i]:Hide()
                    self[FB]["boss"..b]["guanzhu"..i]:Hide()
                    BiaoGeFB["boss"..b]["qiankuan"..i] = ""
                    BiaoGeFB["boss"..b]["guanzhu"..i] = nil
                end
            end
            if self[FB]["boss"..b]["time"] then
                self[FB]["boss"..b]["time"]:SetText("")
                BiaoGeFB["boss"..b]["time"] = nil
            end
        end
        for i=1,5 do
            self[FB]["boss"..MaxbFB+1]["maijia"..i]:SetText("")
            self[FB]["boss"..MaxbFB+1]["jine"..i]:SetText("")
        end
        if BiaoGeFB["ChengPian"] then
            BiaoGeFB["ChengPian"] = nil
        end
    else
        for n=1,4 do
            for b=1,MaxbFB-1 do
                for i=1,2 do
                    if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                        BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:SetText("")
                        BiaoGeAFB["nandu"..n]["boss"..b]["yidiaoluo"..i] = nil
                    end
                end
            end
        end
    end
end

------------------函数：给文本上颜色------------------
function BG.STC_b1(text)
    if text then
        local t
        t = "|cff".."00BFFF"..text.."|r"
        return t
    end
end

function BG.STC_r1(text)
    if text then
        local t
        t = "|cff".."FF0000"..text.."|r"
        return t
    end
end
function BG.STC_r2(text)
    if text then
        local t
        t = "|cff".."FF1493"..text.."|r"
        return t
    end
end
function BG.STC_r3(text)
if text then
    local t
    t = "|cff".."FF69B4"..text.."|r"
    return t
end
end

function BG.STC_g1(text)
    if text then
        local t
        t = "|cff".."00FF00"..text.."|r"
        return t
    end
end
function BG.STC_g2(text)
    if text then
        local t
        t = "|cff".."90EE90"..text.."|r"
        return t
    end
end

------------------把副本英文转换为中文------------------
function BG.FBcn(FB)
    local r = ""
    local fb = {NAXX = "纳克萨玛斯",ULD = "奥杜尔",TOC = "十字军的试炼",ICC = "冰冠堡垒"}
    for index, value in pairs(fb) do
        if FB == index then
            r = value
            return r
        end
    end
end

------------------隐藏或显示历史表格------------------
function BG.FrameHiSH(SH)
    if SH == 1 then
        BG["Frame"..BG.FB1]:Hide()
        BG["HistoryFrame"..BG.FB1]:Show()

        BG.Title:Hide()
        BG.NanDuDropDown.BiaoTi:Hide()
        BG.NanDuDropDown.DropDown:Hide()

        BG.ButtonQingKong:SetEnabled(false)
        BG.ButtonTongBao:SetEnabled(false)
        BG.ButtonLiuPai:SetEnabled(false)
        BG.ButtonXiaoFei:SetEnabled(false)
        BG.ButtonYongShi:SetEnabled(false)
        BG.ButtonWCL:SetEnabled(false)
        BG.ButtonQianKuan:SetEnabled(false)

        BG.ButtonHope:SetEnabled(false)
        BG.ButtonHope0:Hide()

        BG.ButtonICC:SetEnabled(false)
        BG.ButtonTOC:SetEnabled(false)
        BG.ButtonULD:SetEnabled(false)
        BG.ButtonNAXX:SetEnabled(false)

        BG.History.SaveButton:SetEnabled(false)
        BG.History.YongButton:Show()
        BG.History.EscButton:Show()

        BG.History.Title:Show()
        -- BG.History.SendButton:SetText("分享历史表格")

    end
    if SH == 0 then
        BG["Frame"..BG.FB1]:Show()
        BG["HistoryFrame"..BG.FB1]:Hide()
        BG.History.List:Hide()

        BG.Title:Show()
        BG.NanDuDropDown.BiaoTi:Show()
        BG.NanDuDropDown.DropDown:Show()

        BG.ButtonQingKong:SetEnabled(true)
        BG.ButtonTongBao:SetEnabled(true)
        BG.ButtonLiuPai:SetEnabled(true)
        BG.ButtonXiaoFei:SetEnabled(true)
        BG.ButtonYongShi:SetEnabled(true)
        BG.ButtonWCL:SetEnabled(true)
        BG.ButtonQianKuan:SetEnabled(true)

        BG.ButtonHope:SetEnabled(true)
        BG.ButtonHope0:Show()

        BG.ButtonICC:SetEnabled(true)
        BG.ButtonTOC:SetEnabled(true)
        BG.ButtonULD:SetEnabled(true)
        BG.ButtonNAXX:SetEnabled(true)
        BG["Button"..BG.FB1]:SetEnabled(false)

        BG.History.SaveButton:SetEnabled(true)
        BG.History.YongButton:Hide()
        BG.History.EscButton:Hide()

        BG.History.Title:Hide()
        -- BG.History.SendButton:SetText("分享当前表格")

    end
end

------------------当前表格是否空白------------------  -- true 是空白，false 不是空白
function BG.CheckKongBai(FB,MaxbFB,MaxiFB)
    for b=1,MaxbFB do
        for i=1,MaxiFB do
            if BG.Frame[FB]["boss"..b]["zhuangbei"..i] then
                if BG.Frame[FB]["boss"..b]["zhuangbei"..i]:GetText() ~= "" then
                    return false
                end
                if BG.Frame[FB]["boss"..b]["maijia"..i]:GetText() ~= "" then
                    return false
                end
                if BG.Frame[FB]["boss"..b]["jine"..i]:GetText() ~= "" then
                    return false
                end
            end
        end
    end
    for i=1,5 do
        if BG.Frame[FB]["boss"..MaxbFB+1]["maijia"..i]:GetText() ~= "" then
            return false
        end
        if BG.Frame[FB]["boss"..MaxbFB+1]["jine"..i]:GetText() ~= "" then
            return false
        end
    end
    return true
end

------------------通报历史价格------------------
function BG.TongBaoHis(button,DB)
    button:ClearFocus()
    button:SetEnabled(false)
    if not IsInRaid() then 
        print("不在团队，无法通报")
        PlaySound(BG.sound1,"Master")
        return
    end
    if DB.DB then
        local db = DB.DB
        local link = DB.Link
        local name,_,quality,level,_,_,_,_,_,_,_,typeID=GetItemInfo(link)
        local text = "———通报历史价格———"
        SendChatMessage(text,"RAID")
        text = "装备："..link.."("..level..")"
        SendChatMessage(text,"RAID")
        for i=1,#db do
            local a = strsub(db[i][1],3,4)
            local b = strsub(db[i][1],5,6)
            -- local t = a.."/"..b
            local t = a.."月"..b.."日"
            local m = db[i][3]
            local j = db[i][5]
            if m == "" then
                text = t.."，价格:"..j
            else
                text = t.."，价格:"..j.."，买家:"..m
            end
            SendChatMessage(text,"RAID")
        end
        text = "——感谢使用金团表格——"
        SendChatMessage(text,"RAID")
        PlaySoundFile(BG.sound2,"Master")
    end
end

------------------过滤装备------------------
function BG.FilterClass(FB,b,i,bt,class,num,BiaoGeFilterTooltip,Frame,n)
    local text = bt:GetText()
    local itemID = GetItemInfoInstant(text)
    local yes
    if itemID then
        BiaoGeFilterTooltip:ClearLines()
        BiaoGeFilterTooltip:SetItemByID(itemID)

        local tab = {}
        for ii=1,30 do
            if _G["BiaoGeFilterTooltipTextLeft"..ii] then
                local tx = _G["BiaoGeFilterTooltipTextLeft"..ii]:GetText()
                if tx and tx ~= "" then
                    table.insert(tab,tx)
                end
            end
            if _G["BiaoGeFilterTooltipTextRight"..ii] then
                local tx = _G["BiaoGeFilterTooltipTextRight"..ii]:GetText()
                if tx and tx ~= "" then
                    table.insert(tab,tx)
                end
            end
        end
        local TooltipText = table.concat(tab)
        local c = UnitClass("player")
        local zhiye = strfind(TooltipText,"职业：")
        if zhiye then
            if not strfind(TooltipText,c) then
                zhiye = true
            else
                zhiye = false
            end
        end
        for tt=1,2 do   -- 提示工具左边和右边的文字
            local LorR
            local LorR_Text
            if tt == 1 then
                LorR_Text = BG["DisClassTextLeft"][class..num] -- BG.DisClassLeftText.DEATHKNIGHT1
            elseif tt == 2 then
                LorR_Text = BG["DisClassTextRight"][class] -- BG.DisClassRightText.DEATHKNIGHT
            end

            for key, value in pairs(LorR_Text) do  -- 历遍该职业的过滤关键词
                yes = strfind(TooltipText,value)
                if zhiye or yes then
                    local alpha = 0.4
                    if Frame == "Frame" then
                        BG[Frame][FB]["boss"..b]["zhuangbei"..i]:SetAlpha(alpha)
                        BG[Frame][FB]["boss"..b]["maijia"..i]:SetAlpha(alpha)
                        BG[Frame][FB]["boss"..b]["jine"..i]:SetAlpha(alpha)
                        BG[Frame][FB]["boss"..b]["guanzhu"..i]:SetAlpha(alpha)
                        BG[Frame.."Ds"][FB..1]["boss"..b]["ds"..i]:SetAlpha(alpha)
                        BG[Frame.."Ds"][FB..2]["boss"..b]["ds"..i]:SetAlpha(alpha)
                        BG[Frame.."Ds"][FB..3]["boss"..b]["ds"..i]:SetAlpha(alpha)
                    elseif Frame == "HopeFrame" then
                        BG[Frame][FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:SetAlpha(alpha)
                        BG[Frame][FB]["nandu"..n]["boss"..b]["yidiaoluo"..i]:SetAlpha(alpha)
                        BG[Frame.."Ds"][FB..1]["nandu"..n]["boss"..b]["ds"..i]:SetAlpha(alpha)
                        BG[Frame.."Ds"][FB..2]["nandu"..n]["boss"..b]["ds"..i]:SetAlpha(alpha)
                        BG[Frame.."Ds"][FB..3]["nandu"..n]["boss"..b]["ds"..i]:SetAlpha(alpha)
                    elseif Frame == "HistoryFrame" then
                        BG[Frame][FB]["boss"..b]["zhuangbei"..i]:SetAlpha(alpha)
                        BG[Frame][FB]["boss"..b]["maijia"..i]:SetAlpha(alpha)
                        BG[Frame][FB]["boss"..b]["jine"..i]:SetAlpha(alpha)
                        BG[Frame.."Ds"][FB..1]["boss"..b]["ds"..i]:SetAlpha(alpha)
                    elseif Frame == "zhuangbei" then
                        bt:SetAlpha(alpha)
                    end
                    return
                end
            end
        end
    end
    if not yes then
        local alpha = 1
        if Frame == "Frame" then
            BG[Frame][FB]["boss"..b]["zhuangbei"..i]:SetAlpha(alpha)
            BG[Frame][FB]["boss"..b]["maijia"..i]:SetAlpha(alpha)
            BG[Frame][FB]["boss"..b]["jine"..i]:SetAlpha(alpha)
            BG[Frame][FB]["boss"..b]["guanzhu"..i]:SetAlpha(alpha)
            BG[Frame.."Ds"][FB..1]["boss"..b]["ds"..i]:SetAlpha(alpha)
            BG[Frame.."Ds"][FB..2]["boss"..b]["ds"..i]:SetAlpha(alpha)
            BG[Frame.."Ds"][FB..3]["boss"..b]["ds"..i]:SetAlpha(alpha)
        elseif Frame == "HopeFrame" then
            BG[Frame][FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:SetAlpha(alpha)
            BG[Frame][FB]["nandu"..n]["boss"..b]["yidiaoluo"..i]:SetAlpha(alpha)
            BG[Frame.."Ds"][FB..1]["nandu"..n]["boss"..b]["ds"..i]:SetAlpha(alpha)
            BG[Frame.."Ds"][FB..2]["nandu"..n]["boss"..b]["ds"..i]:SetAlpha(alpha)
            BG[Frame.."Ds"][FB..3]["nandu"..n]["boss"..b]["ds"..i]:SetAlpha(alpha)
        elseif Frame == "HistoryFrame" then
            BG[Frame][FB]["boss"..b]["zhuangbei"..i]:SetAlpha(alpha)
            BG[Frame][FB]["boss"..b]["maijia"..i]:SetAlpha(alpha)
            BG[Frame][FB]["boss"..b]["jine"..i]:SetAlpha(alpha)
            BG[Frame.."Ds"][FB..1]["boss"..b]["ds"..i]:SetAlpha(alpha)
        elseif Frame == "zhuangbei" then
            bt:SetAlpha(alpha)
        end
    end
end

function BG.FBfilter()
    local num = BiaoGeA.filterClassNum  -- 隐藏
    local FB = BG.FB1
    local _,class = UnitClass("player")
    if num ~= 0 then
        for b=1,Maxb[FB] do
            for i=1,Maxi[FB] do
                local bt = BG.Frame[FB]["boss"..b]["zhuangbei"..i]
                if bt then
                    BG.FilterClass(FB,b,i,bt,class,num,BiaoGeFilterTooltip,"Frame")
                end
            end
        end
        for n=1,HopeMaxn[FB] do -- 心愿清单
            for b=1,HopeMaxb[FB] do
                for i=1,2 do
                    local bt = BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]
                    if bt then
                        BG.FilterClass(FB,b,i,bt,class,num,BiaoGeFilterTooltip,"HopeFrame",n)
                    end
                end
            end
        end
    else
        for b=1,Maxb[FB] do
            for i=1,Maxi[FB] do
                local bt = BG.Frame[FB]["boss"..b]["zhuangbei"..i]
                if bt then
                    BG.Frame[FB]["boss"..b]["zhuangbei"..i]:SetAlpha(1)
                    BG.Frame[FB]["boss"..b]["maijia"..i]:SetAlpha(1)
                    BG.Frame[FB]["boss"..b]["jine"..i]:SetAlpha(1)
                    BG.Frame[FB]["boss"..b]["guanzhu"..i]:SetAlpha(1)
                end
            end
        end
        for n=1,HopeMaxn[FB] do
            for b=1,HopeMaxb[FB] do
                for i=1,2 do
                    local bt = BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]
                    if bt then
                        BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:SetAlpha(1)
                        BG.HopeFrame[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i]:SetAlpha(1)
                    end
                end
            end
        end
    end
end

------------------获取玩家所在的团队框体位置（例如5-2）------------------
function BG.GetRaidWeiZhi()
    local team = {}
    local num = GetNumGroupMembers()
    if not num then return end
    for i=1,num do
        local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(i)
        name = strsplit("-",name)
        if not team[subgroup] then
            team[subgroup] = {}
        end
        table.insert(team[subgroup],name)
    end
    
    local weizhi = {}
    for i,v in pairs(team) do
        if type(team[i]) == "table" then
            for ii, vv in ipairs(team[i]) do
                weizhi[vv] = i.."-"..ii
            end
        end
    end
    return weizhi
end
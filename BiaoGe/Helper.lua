local _, ADDONSELF = ...

local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local RGB_16 = ADDONSELF.RGB_16
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local FrameDongHua = ADDONSELF.FrameDongHua
local FrameHide = ADDONSELF.FrameHide
local Listmaijia = ADDONSELF.Listmaijia

local red,greed,blue = 1,1,1
local touming1,touming2 = 0.2,0.4

local pt = print

------------------生成UI------------------
function BG.HelperUI()
    local f = CreateFrame("Frame", "BG.helperFrame", UIParent, "BasicFrameTemplate")
    f:SetWidth(800)
    f:SetHeight(385)
    f:SetFrameStrata("DIALOG")
    f:SetPoint("CENTER")
    f:SetFrameLevel(100)
    f:SetMovable(true)
    BG.helperFrame = f
    tinsert(UISpecialFrames, "BG.helperFrame")     -- 按ESC可关闭插件        
    f:SetScript("OnMouseUp", function(self)
        self:StopMovingOrSizing()
    end)
    f:SetScript("OnMouseDown", function(self)
        FrameHide(0)
        self:StartMoving()
    end)

    -- 各种文字
    do
        local TitleText = BG.helperFrame:CreateFontString()
        TitleText:SetPoint("TOP", BG.helperFrame, "TOP", 0, -4)
        TitleText:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")
        TitleText:SetText("|cff".."00BFFF".."< BiaoGe > 团减助手")
        BG.helperTitle = TitleText

        local text = BG.helperFrame:CreateFontString()
        text:SetPoint("TOPRIGHT", BG.helperFrame, "TOPLEFT", 90, -35)
        text:SetFontObject(GameFontNormal)
        text:SetText("圣骑士")
        BG.helperTextQS = text
        local text = BG.helperFrame:CreateFontString()
        text:SetPoint("LEFT", BG.helperTextQS, "RIGHT", 30, 0)
        text:SetFontObject(GameFontNormal)
        text:SetText("祝福分配")
        BG.helperTextZF = text
        local text = BG.helperFrame:CreateFontString()
        text:SetPoint("TOPLEFT",BG.helperTextQS,"BOTTOMLEFT",0,-10)
        text:SetFont(STANDARD_TEXT_FONT,14,"OUTLINE")
        text:SetText("|cffF48CBA当你的团队里有圣骑士时才会显示|r")
        BG.helperTextQS_tishi = text

        local text = BG.helperFrame:CreateFontString()
        text:SetPoint("LEFT", BG.helperTextZF, "RIGHT", 150, 0)
        text:SetFontObject(GameFontNormal)
        text:SetText("术士")
        BG.helperTextSS = text
        local text = BG.helperFrame:CreateFontString()
        text:SetPoint("LEFT", BG.helperTextSS, "RIGHT", 20, 0)
        text:SetFontObject(GameFontNormal)
        text:SetText("灵魂石分配")
        BG.helperTextLHS = text
        local text = BG.helperFrame:CreateFontString()
        text:SetPoint("TOPLEFT",BG.helperTextSS,"BOTTOMLEFT",0,-10)
        text:SetFont(STANDARD_TEXT_FONT,14,"OUTLINE")
        text:SetText("|cff9382C9当你的团队里有术士时才会显示|r")
        BG.helperTextSS_tishi = text

        local text = BG.helperFrame:CreateFontString()
        text:SetPoint("TOPRIGHT", BG.helperFrame, "TOPLEFT", 90, -228)
        text:SetFontObject(GameFontNormal)
        text:SetText("团减安排")
        BG.helperTextTJ = text
        local down
        local n = {"一","二","三","四",}
        for i=1,4 do
            local text = BG.helperFrame:CreateFontString()
            text:SetPoint("TOPRIGHT",down or BG.helperTextTJ,"BOTTOMRIGHT",0,-10)
            text:SetFontObject(GameFontNormal)
            text:SetText(n[i].."团减")
            BG["helperTextTJ"..i] = text
            down = text
        end
        local text = BG.helperFrame:CreateFontString()
        text:SetPoint("BOTTOMLEFT",BG.helperFrame,"BOTTOMLEFT",50,20)
        text:SetFont(STANDARD_TEXT_FONT,13,"OUTLINE")
        text:SetText(BG.STC_b1("当你的团队里有 |cffF48CBA圣骑士|r / |cffF0EBE0牧师|r / |cffFF7C0A德鲁伊|r 时才能选择玩家和技能"))
        BG.helperTextTJ_tishi = text

        local text = BG.helperFrame:CreateFontString()
        text:SetPoint("BOTTOMRIGHT",BG.helperFrame,"BOTTOMRIGHT",-50,20)
        text:SetFont(STANDARD_TEXT_FONT,13,"OUTLINE")
        text:SetText(BG.STC_r3("鼠标右键输入框可快速清除内容"))
        BG.helperTextQK_tishi = text
    end

    -- 团减输入框
    do
        if not BiaoGe.helperEditTJ then
            BiaoGe.helperEditTJ = {}
        end
        BG.helperEditTJ = {}
        BG.helperDsTJ1 = {}
        BG.helperDsTJ2 = {}
        local righted
        local x
        local t
        local w
        for j=1,4 do
            righted = nil
            for i=1,6 do
                -- local y
                if i == 1 then
                    x = 20
                    w = 90
                    y = "player"
                elseif i == 3 or i == 5 then
                    x = 40
                    w = 90
                    -- y = "player"
                else
                    x = 22
                    w = 75
                    -- y = "jineng"
                end
                local ed = CreateFrame("EditBox", nil, BG.helperFrame, "InputBoxTemplate")  -- 输入框
                ed:SetSize(w, 20)
                ed:SetPoint("LEFT",righted or BG["helperTextTJ"..j],"RIGHT",x,0)
                ed:SetFrameLevel(110)
                ed:SetAutoFocus(false)
                if BiaoGe.helperEditTJ["tj"..j..i] then
                    ed:SetText(BiaoGe.helperEditTJ["tj"..j..i])
                    if BiaoGe.helperEditTJ["color"..j..i] then
                        ed:SetTextColor(BiaoGe.helperEditTJ["color"..j..i][1],BiaoGe.helperEditTJ["color"..j..i][2],BiaoGe.helperEditTJ["color"..j..i][3])
                    end
                end
                BG.helperEditTJ["tj"..j..i] = ed
                righted = ed

                if i%2 == 0 then
                    local ds = CreateFrame("Button", nil, BG.helperFrame)  -- 悬停底色
                    ds:SetPoint("TOPLEFT",BG.helperEditTJ["tj"..j..(i-1)],"TOPLEFT",-6,0)
                    ds:SetPoint("BOTTOMRIGHT",BG.helperEditTJ["tj"..j..(i)],"BOTTOMRIGHT",1,-0)
                    ds:SetFrameLevel(103)
                    ds:SetAlpha(0)
                    local textrue= ds:CreateTexture()
                    textrue:SetAllPoints(ds)
                    textrue:SetColorTexture(red,greed,blue,touming1)
                    BG.helperDsTJ1["tj"..j..(i-1)] = ds

                    ds:SetScript("OnEnter", function(self)
                        ds:SetAlpha(1)
                    end)
                    ds:SetScript("OnLeave", function(self) 
                        ds:SetAlpha(0)
                    end)

                    local ds = CreateFrame("Button", nil, BG.helperFrame)  -- 点击后的底色
                    ds:SetPoint("TOPLEFT",BG.helperEditTJ["tj"..j..(i-1)],"TOPLEFT",-6,0)
                    ds:SetPoint("BOTTOMRIGHT",BG.helperEditTJ["tj"..j..(i)],"BOTTOMRIGHT",1,-0)
                    ds:SetFrameLevel(102)
                    ds:SetAlpha(0)
                    local textrue= ds:CreateTexture()
                    textrue:SetAllPoints(ds)
                    textrue:SetColorTexture(red,greed,blue,touming2)
                    BG.helperDsTJ2["tj"..j..(i-1)] = ds
                end

                local icon = ed:CreateTexture() -- 技能图标
                icon:SetPoint('LEFT', -22, 0)
                icon:SetSize(16, 16)
                if j == 1 then
                    if i == 1 then
                        t = "玩家"..(i+1)/2
                    elseif i == 3 or i == 5 then
                        t = "玩家"..(i+1)/2
                    else
                        t = "技能"..i/2
                    end
                    local text = BG.helperFrame:CreateFontString()  -- 小标题
                    text:SetPoint("BOTTOMLEFT",ed,"TOPLEFT",2,5)
                    text:SetFontObject(GameFontNormal)
                    text:SetText(t)
                    BG["helperTextTJbt"..i] = text
                    
                end

                if i%2 == 1 then   -- 玩家
                    ed:SetScript("OnEditFocusGained",function (self)
                        self:HighlightText()
                        BG.lastfocus = self
                        Listmaijia(self,0,0,"jianshang",class)
                        BG.helperDsTJ2["tj"..j..(i)]:SetAlpha(1)
                    end)
                    ed:SetScript("OnEditFocusLost", function(self)
                        self:HighlightText(0,0)
                        if BG.FrameMaijiaList then
                            BG.FrameMaijiaList:Hide()
                        end
                        BG.helperDsTJ2["tj"..j..(i)]:SetAlpha(0)
                    end)
                    ed:SetScript("OnTextChanged", function(self)
                        local text = self:GetText()
                        local _,class,id = UnitClass(text)
                        if class == "PALADIN" then
                            if BG.helperEditTJ["tj"..j..(i+1)]:GetText() == "" then
                                BG.helperEditTJ["tj"..j..(i+1)]:SetFocus()
                            end
                        elseif class == "DRUID" then
                            local link = GetSpellLink(48447)
                            BG.helperEditTJ["tj"..j..(i+1)]:SetText(link)
                        elseif class == "PRIEST" then
                            local link = GetSpellLink(64843)
                            BG.helperEditTJ["tj"..j..(i+1)]:SetText(link)
                        end
                        if self:GetText() == "" then        -- 如果没有名字，就恢复白色
                            self:SetTextColor(1,1,1)
                            BG.helperEditTJ["tj"..j..(i+1)]:SetText("")
                        end
                        BiaoGe.helperEditTJ["tj"..j..i] = self:GetText()
                        BiaoGe.helperEditTJ["color"..j..i] = {self:GetTextColor()}
                    end)

                    ed:SetScript("OnMouseDown", function(self,enter)
                        if enter == "RightButton"  then  -- 右键清空格子
                            self:SetEnabled(false)
                            self:SetText("")
                            if BG.lastfocus then
                                BG.lastfocus:ClearFocus()
                            end
                            return
                        end
                    end)
                    ed:SetScript("OnMouseUp", function(self,enter)
                        if enter == "RightButton"  then  -- 右键清空格子
                            self:SetEnabled(true)
                        end
                    end)

                    ed:SetScript("OnEnter", function(self)
                        BG.helperDsTJ1["tj"..j..(i)]:SetAlpha(1)
                    end)
                    ed:SetScript("OnLeave", function(self) 
                        BG.helperDsTJ1["tj"..j..(i)]:SetAlpha(0)
                    end)
                end

                if i%2 == 0 then   -- 技能
                    ed:SetScript("OnEditFocusGained",function (self)
                        self:HighlightText()
                        BG.lastfocus = self
                        local text = BG.helperEditTJ["tj"..j..(i-1)]:GetText()
                        local _,class,id = UnitClass(text)
                        if class == "PALADIN" then
                            BG.Listzhufu(self,"qs")
                        elseif class == "DRUID" then
                            BG.Listzhufu(self,"xd")
                        elseif class == "PRIEST" then
                            BG.Listzhufu(self,"ms")
                        end
                        BG.helperDsTJ2["tj"..j..(i-1)]:SetAlpha(1)
                    end)
                    ed:SetScript("OnEditFocusLost", function(self)
                        self:HighlightText(0,0)
                        if BG.frameZhuFuList then
                            BG.frameZhuFuList:Hide()
                        end
                        BG.helperDsTJ2["tj"..j..(i-1)]:SetAlpha(0)
                    end)
                    ed:SetScript("OnTextChanged", function(self)
                        local text = self:GetText()
                        local _,a = strfind(text,"spell:")
                        if a then
                            local b = strfind(text,":",a+1)
                            local spellID = tonumber(strsub(text,a+1,b-1))
                            if spellID then
                                local spellIcon = GetSpellTexture(spellID)
                                icon:SetTexture(spellIcon)
                            end
                        else
                            icon:SetTexture(nil)
                        end
                        if self:GetText() == "" then        -- 如果没有名字，就恢复白色
                            self:SetTextColor(1,1,1)
                        end
                        BiaoGe.helperEditTJ["tj"..j..i] = self:GetText()
                        BiaoGe.helperEditTJ["color"..j..i] = {self:GetTextColor()}
                    end)

                    ed:SetScript("OnEnter", function(self)
                        local text = self:GetText()
                        local _,a = strfind(text,"spell:")
                        if a then
                            local b = strfind(text,":",a+1)
                            local spellID = tonumber(strsub(text,a+1,b-1))
                            if spellID then
                                GameTooltip:SetOwner(self, "ANCHOR_RIGHT",0,0)
                                GameTooltip:ClearLines()
                                GameTooltip:SetSpellByID(spellID)
                                GameTooltip:Show()
                            end
                        end
                        BG.helperDsTJ1["tj"..j..(i-1)]:SetAlpha(1)
                    end)
                    ed:SetScript("OnLeave", function(self)
                        GameTooltip:Hide()
                        BG.helperDsTJ1["tj"..j..(i-1)]:SetAlpha(0)
                    end)

                    ed:SetScript("OnMouseDown", function(self,enter)
                        if enter == "RightButton"  then  -- 右键清空格子
                            self:SetEnabled(false)
                            self:SetText("")
                            if BG.lastfocus then
                                BG.lastfocus:ClearFocus()
                            end
                            return
                        end
                    end)
                    ed:SetScript("OnMouseUp", function(self,enter)
                        if enter == "RightButton"  then  -- 右键清空格子
                            self:SetEnabled(true)
                        end
                    end)
                end
            end
        end
        -- BG["helperTextTJbt1"]:SetTextColor(RGB("00FFFF"))
        -- BG["helperTextTJbt2"]:SetTextColor(RGB("00FFFF"))
        -- BG["helperTextTJbt3"]:SetTextColor(RGB("00FF7F"))
        -- BG["helperTextTJbt4"]:SetTextColor(RGB("00FF7F"))
        -- BG["helperTextTJbt5"]:SetTextColor(RGB("FFB6C1"))
        -- BG["helperTextTJbt6"]:SetTextColor(RGB("FFB6C1"))

        BG["helperTextTJ1"]:SetTextColor(RGB("00FFFF"))
        BG["helperTextTJ2"]:SetTextColor(RGB("00FFCC"))
        BG["helperTextTJ3"]:SetTextColor(RGB("00FF66"))
        BG["helperTextTJ4"]:SetTextColor(RGB("00FF00"))
    end

    local bt = CreateFrame("Button",nil,BG.helperFrame) -- 返回表格
    bt:SetSize(80, 30)
    bt:SetPoint("TOPRIGHT", BG.helperFrame, "TOPRIGHT", -50, 4)
    bt:SetNormalFontObject(BG.FontGreen1)
    bt:SetDisabledFontObject(BG.FontDisabled)
    bt:SetHighlightFontObject(BG.FontHilight)
    bt:SetText("返回表格")
    BG.ButtonBiaoGe = bt
    bt:SetScript("OnClick", function(self)
        if BG.MainFrame and not BG.MainFrame:IsVisible() then
            BG.helperFrame:Hide()
            BG.MainFrame:Show()
        else
            BG.helperFrame:Hide()
        end
    end)

        ------------------通报模块------------------
    do
        BG.helperTongBao = {}
        if not BiaoGe.helperTongBao then
            BiaoGe.helperTongBao = {}
        end

        do
            local text = BG.helperFrame:CreateFontString()  -- 通报
            text:SetPoint("LEFT",BG.helperTextLHS,"RIGHT",140,0)
            text:SetFontObject(GameFontNormal)
            text:SetText("通报频道：")
            BG.helperTongBao.pindao = text

            local bt = CreateFrame("CheckButton", nil, BG.helperFrame, "ChatConfigCheckButtonTemplate") -- 团队频道
            bt:SetSize(30, 30)
            bt:SetHitRectInsets(0, -25, 0, 0)
            bt:SetPoint("LEFT", BG.helperTongBao.pindao, "RIGHT", 5, 0)
            bt.Text:SetText("团队")
            BG.helperTongBao.raid = bt
            if not BiaoGe.helperTongBao.raid then
                BiaoGe.helperTongBao.raid = 1
                bt:SetChecked(true)
            elseif BiaoGe.helperTongBao.raid == 1 then
                bt:SetChecked(true)
            elseif BiaoGe.helperTongBao.raid == 0 then
                bt:SetChecked(false)
            end
            bt:SetScript("OnClick", function(self)
                if self:GetChecked() then
                    BiaoGe.helperTongBao.raid = 1
                else
                    BiaoGe.helperTongBao.raid = 0
                end
                PlaySound(BG.sound1,"Master")
            end)

            local bt = CreateFrame("CheckButton", nil, BG.helperFrame, "ChatConfigCheckButtonTemplate") -- 私密频道
            bt:SetSize(30, 30)
            bt:SetHitRectInsets(0, -25, 0, 0)
            bt:SetPoint("LEFT", BG.helperTongBao.raid, "RIGHT", 30, 0)
            bt.Text:SetText("私密")
            BG.helperTongBao.whisper = bt
            if not BiaoGe.helperTongBao.whisper then
                BiaoGe.helperTongBao.whisper = 0
                bt:SetChecked(false)
            elseif BiaoGe.helperTongBao.whisper == 1 then
                bt:SetChecked(true)
            elseif BiaoGe.helperTongBao.whisper == 0 then
                bt:SetChecked(false)
            end
            bt:SetScript("OnClick", function(self)
                if self:GetChecked() then
                    BiaoGe.helperTongBao.whisper = 1
                else
                    BiaoGe.helperTongBao.whisper = 0
                end
                PlaySound(BG.sound1,"Master")
            end)
        end

        -- 通报祝福
        do
            local bt = CreateFrame("Button",nil,BG.helperFrame,"UIPanelButtonTemplate")   -- 通报祝福
            bt:SetSize(100, 25)
            bt:SetPoint("TOPLEFT",BG.helperTongBao.pindao,"BOTTOMLEFT",0,-15)
            bt:SetText("通报祝福")
            BG.helperTongBao.buttonZF = bt
            -- 鼠标悬停提示
            bt:SetScript("OnEnter", function(self)
                local tx = {}
                local num = 1
                local text = "|cffffffff< 祝 福 分 配 >|r\n"
                table.insert(tx,text)
                for i=1,#BG.helperZF do
                    local qs = BG.helperTextQS_qs[i]:GetText()
                    local zf = BG.helperTextQS_zf[i]:GetText()
                    if zf ~= "" then
                        text =  num.."、"..SetClassCFF(qs).."："..zf.."\n"
                        table.insert(tx,text)
                        num = num + 1
                    end
                end
                text = table.concat(tx)
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
                if not IsInRaid() then
                    print("不在团队，无法通报")
                    PlaySound(BG.sound1,"Master")
                    return
                end
                self:SetEnabled(false)      -- 点击后按钮变灰2秒
                C_Timer.After(2,function ()
                    bt:SetEnabled(true)
                end)
                local tx = {}
                local txwhisper = {}
                local num = 1
                local text = "———通报祝福分配———"
                table.insert(tx,text)
                for i=1,#BG.helperZF do
                    local qs = BG.helperTextQS_qs[i]:GetText()
                    local zf = BG.helperTextQS_zf[i]:GetText()
                    if zf ~= "" then
                        text =  num.."、"..(qs).."："..zf
                        table.insert(tx,text)
                        num = num + 1

                        if BiaoGe.helperTongBao.whisper == 1 then
                            local w = {
                                name = qs,
                                text = "通知：你负责刷全团祝福 "..zf
                            }
                            table.insert(txwhisper,w)
                        end
                    end
                end
                if BiaoGe.helperTongBao.raid == 1 then
                    for index, value in ipairs(tx) do
                        SendChatMessage(value,"RAID")
                    end
                end
                if BiaoGe.helperTongBao.whisper == 1 then
                    for index, value in ipairs(txwhisper) do
                        SendChatMessage(value.text,"WHISPER",nil,value.name)
                    end
                end
                PlaySoundFile(BG.sound2,"Master")
            end)
        end

        -- 通报灵魂石
        do
            local bt = CreateFrame("Button",nil,BG.helperFrame,"UIPanelButtonTemplate")   -- 通报灵魂石
            bt:SetSize(100, 25)
            bt:SetPoint("TOPLEFT",BG.helperTongBao.buttonZF,"BOTTOMLEFT",0,-5)
            bt:SetText("通报灵魂石")
            BG.helperTongBao.buttonLHS = bt
            -- 鼠标悬停提示
            bt:SetScript("OnEnter", function(self)
                local tx = {}
                local num = 1
                local text = "|cffffffff< 灵 魂 石 分 配 >|r\n"
                table.insert(tx,text)
                for i=1,#BG.helperLHS do
                    local ss = BG.helperTextSS_ss[i]:GetText()
                    local lhs = BG.helperTextSS_lhs[i]:GetText()
                    local wz = BG.helperTextSS_weizhi[i]:GetText() or ""
                    if wz ~= "" then
                        wz = "（"..wz.."）"
                    end
                    if lhs ~= "" then
                        text =  num.."、"..SetClassCFF(ss).."："..SetClassCFF(lhs)..wz.."\n"
                        table.insert(tx,text)
                        num = num + 1
                    end
                end
                text = table.concat(tx)
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
                if not IsInRaid() then
                    print("不在团队，无法通报")
                    PlaySound(BG.sound1,"Master")
                    return
                end
                self:SetEnabled(false)      -- 点击后按钮变灰2秒
                C_Timer.After(2,function ()
                    bt:SetEnabled(true)
                end)
                local tx = {}
                local txwhisper = {}
                local num = 1
                local text = "———通报灵魂石分配———"
                table.insert(tx,text)
                for i=1,#BG.helperLHS do
                    local ss = BG.helperTextSS_ss[i]:GetText()
                    local lhs = BG.helperTextSS_lhs[i]:GetText()
                    local wz = BG.helperTextSS_weizhi[i]:GetText() or ""
                    if wz ~= "" then
                        wz = "（"..wz.."）"
                    end
                    if lhs ~= "" then
                        text =  num.."、"..(ss).." 绑给："..lhs..wz
                        table.insert(tx,text)
                        num = num + 1

                        if BiaoGe.helperTongBao.whisper == 1 then
                            local w = {
                                name = ss,
                                text = "通知：你的灵魂石负责绑给 "..lhs..wz
                            }
                            table.insert(txwhisper,w)
                        end
                    end
                end
                if BiaoGe.helperTongBao.raid == 1 then
                    for index, value in ipairs(tx) do
                        SendChatMessage(value,"RAID")
                    end
                end
                if BiaoGe.helperTongBao.whisper == 1 then
                    for index, value in ipairs(txwhisper) do
                        SendChatMessage(value.text,"WHISPER",nil,value.name)
                    end
                end
                PlaySoundFile(BG.sound2,"Master")
            end)
        end

        -- 通报团减
        do
            local bt = CreateFrame("Button",nil,BG.helperFrame,"UIPanelButtonTemplate")   -- 通报团减
            bt:SetSize(100, 25)
            bt:SetPoint("TOPLEFT",BG.helperTongBao.buttonLHS,"BOTTOMLEFT",0,-20)
            bt:SetText("通报团减")
            BG.helperTongBao.buttonTZ = bt
            -- 鼠标悬停提示
            bt:SetScript("OnEnter", function(self)
                local tx = {}
                local t = {
                    tx1 = {},
                    tx2 = {},
                    tx3 = {},
                    tx4 = {},
                }
                local text = "|cffffffff< 团 减 安 排 >|r\n"
                table.insert(tx,text)
                for j=1,4 do
                    for i=1,6 do
                        if (i+1)%2 == 0 then
                            local name = BG.helperEditTJ["tj"..j..i]:GetText()
                            local tj = BG.helperEditTJ["tj"..j..(i+1)]:GetText()
                            if name ~= "" then
                                local a = {
                                    name = SetClassCFF(name),
                                    tj = tj
                                }
                                table.insert(t["tx"..j],a)
                            end
                        end
                    end
                end
                for j=1,4 do
                    if Size(t["tx"..j]) ~= 0 then
                        text = BG["helperTextTJ"..j]:GetText().."："    -- 一团减：
                        for index, value in ipairs(t["tx"..j]) do
                            local jia = ""
                            if tonumber(index) ~= tonumber(#t["tx"..j]) then
                                jia = " + "
                            else
                                jia = "\n"
                            end
                            text = text..value.name..value.tj..jia    -- 骑士[光环掌握]+
                        end
                        table.insert(tx,text)
                    end
                end
                text = table.concat(tx)
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
                if not IsInRaid() then
                    print("不在团队，无法通报")
                    PlaySound(BG.sound1,"Master")
                    return
                end
                self:SetEnabled(false)      -- 点击后按钮变灰2秒
                C_Timer.After(2,function ()
                    bt:SetEnabled(true)
                end)
                local tx = {}
                local t = {
                    tx1 = {},
                    tx2 = {},
                    tx3 = {},
                    tx4 = {},
                }
                local txwhisper = {}
                local text = "———通报团减安排———"
                table.insert(tx,text)
                for j=1,4 do
                    for i=1,6 do
                        if (i+1)%2 == 0 then
                            local name = BG.helperEditTJ["tj"..j..i]:GetText()
                            local tj = BG.helperEditTJ["tj"..j..(i+1)]:GetText()
                            if name ~= "" then
                                local a = {
                                    name = name,
                                    tj = tj
                                }
                                table.insert(t["tx"..j],a)

                                if BiaoGe.helperTongBao.whisper == 1 then
                                    local w = {
                                        name = name,
                                        text = "通知："..BG["helperTextTJ"..j]:GetText().." 你的 "..tj  -- 通知：一团减 你的 [神圣牺牲]
                                    }
                                    table.insert(txwhisper,w)
                                end
                            end
                        end
                    end
                end
                for j=1,4 do
                    if Size(t["tx"..j]) ~= 0 then
                        text = BG["helperTextTJ"..j]:GetText().."："    -- 一团减：
                        for index, value in ipairs(t["tx"..j]) do
                            local jia = ""
                            if tonumber(index) ~= tonumber(#t["tx"..j]) then
                                jia = "+"
                            end
                            text = text..value.name..value.tj..jia    -- 一团减：骑士[光环掌握]+
                        end
                        table.insert(tx,text)
                    end
                end
                if BiaoGe.helperTongBao.raid == 1 then
                    for index, value in ipairs(tx) do
                        SendChatMessage(value,"RAID")
                    end
                end
                if BiaoGe.helperTongBao.whisper == 1 then
                    for index, value in ipairs(txwhisper) do
                        SendChatMessage(value.text,"WHISPER",nil,value.name)
                    end
                end
                PlaySoundFile(BG.sound2,"Master")
            end)
        end
    end
end

------------------技能下拉列表------------------
function BG.Listzhufu(zhufu,jianshang)
    local zfTable
    if jianshang == "qs" then
        zfTable = {64205,31821} -- 神圣牺牲、光环掌握
    elseif jianshang == "xd" then
        zfTable = {48447} -- 宁静
    elseif jianshang == "ms" then
        zfTable = {64843} -- 神圣赞美诗
    else
        zfTable = {25899,25898,48934,48938} -- 庇护、王者、力量、智慧祝福
    end

    local f = CreateFrame("Frame", nil, BG.helperFrame, "BackdropTemplate")
    f:SetWidth(130)
    f:SetHeight(8+22*#zfTable)
    f:SetFrameLevel(120)
    f:SetBackdrop({
        -- bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16
    })
    -- f:SetBackdropColor(0, 0, 0, 1)
    f:SetPoint("TOPLEFT",zhufu,"BOTTOMLEFT",-9,2)
    f:Show()
    BG.frameZhuFuList = f
    f:SetScript("OnMouseUp", function(self)
    end)
    local ds = f:CreateTexture()
    ds:SetSize(f:GetWidth()-8,f:GetHeight()-8)
    ds:SetPoint("CENTER")
    ds:SetColorTexture(0,0,0,0.9)

    local framedown
    for i=1,#zfTable do
        local ed=CreateFrame("EditBox",nil,BG.frameZhuFuList,"InputBoxTemplate")
        ed:SetSize(112, 20)
        ed:SetFrameLevel(125)
        ed:SetTextInsets(16,0,0,0)
        if i == 1 then
            ed:SetPoint("TOPLEFT", BG.frameZhuFuList, "TOPLEFT", 11, -5)
        else
            ed:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -2)
        end
        framedown = ed

        local icon = ed:CreateTexture()
        icon:SetPoint('LEFT', -2, 0)
        icon:SetSize(16, 16)
        local spellIcon = GetSpellTexture(zfTable[i])
        icon:SetTexture(spellIcon)
        local link = GetSpellLink(zfTable[i])
        ed:SetText(link)

        ed:SetScript("OnEnter", function(self) 
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT",0,0)
            GameTooltip:ClearLines()
            GameTooltip:SetSpellByID(zfTable[i])
            GameTooltip:Show()
        end)
        ed:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
        ed:SetScript("OnMouseDown", function(self,enter)
            if enter == "RightButton" then  -- 右键清空格子
                if BG.lastfocus then
                    BG.lastfocus:ClearFocus()
                end
                return
            end
            zhufu:SetText(link)
            if BG.lastfocus then
                BG.lastfocus:ClearFocus()
            end
        end)
    end
end

------------------祝福模块------------------
function BG.UpDateZhuFu()
    BG.helperZF = {}
    if IsInRaid() then
        local num = GetNumGroupMembers()
        for i=1,num do
            local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(i)
            if class == "圣骑士" then
                name = strsplit("-",name)
                local yes
                if BiaoGe.helperZF and Size(BiaoGe.helperZF) ~= 0 then
                    for k,v in pairs(BiaoGe.helperZF) do
                        if name == v.name then
                            local qs = {
                                name = name,
                                zf = v.zf
                            }
                            table.insert(BG.helperZF,qs)
                            yes = true
                        end
                    end
                end
                if not yes then
                    local qs = {
                        name = name,
                        zf = ""
                    }
                    table.insert(BG.helperZF,qs)
                end
            end
        end
    end
    BiaoGe.helperZF = BG.helperZF

    if BG.helperTextQS_qs then
        local max = #BG.helperTextQS_qs
        for i=1,max do
            BG.helperTextQS_qs[i]:Hide()
            BG.helperTextQS_zf[i]:Hide()
        end
    end
    if Size(BG.helperZF) == 0 then
        BG.helperTextQS_tishi:Show()
        BG.helperTongBao.buttonZF:SetEnabled(false)
        return
    else
        BG.helperTextQS_tishi:Hide()
        BG.helperTongBao.buttonZF:SetEnabled(true)
    end

    local down
    BG.helperTextQS_qs = {}
    BG.helperTextQS_zf = {}
    for i=1,#BG.helperZF do
        if i == 7 then return end
        local text = BG.helperFrame:CreateFontString()  -- 圣骑士
        text:SetPoint("TOPRIGHT",down or BG.helperTextQS,"BOTTOMRIGHT",0,-8)
        text:SetFontObject(GameFontNormal)
        text:SetText(BG.helperZF[i].name)
        text:SetTextColor(GetClassRGB(BG.helperZF[i].name))
        down = text
        BG.helperTextQS_qs[i] = text

        local ed = CreateFrame("EditBox", nil, BG.helperFrame, "InputBoxTemplate")  -- 输入框
        ed:SetSize(112, 20)
        ed:SetPoint("LEFT",text,"RIGHT",30,0)
        ed:SetAutoFocus(false)
        ed:SetText(BiaoGe.helperZF[i].zf)
        local icon = ed:CreateTexture()
        icon:SetPoint('LEFT', -22, 0)
        icon:SetSize(16, 16)
        BG.helperTextQS_zf[i] = ed
        ed:SetScript("OnTextChanged", function(self)
            local text = self:GetText()
            local _,a = strfind(text,"spell:")
            if a then
                local b = strfind(text,":",a+1)
                local spellID = tonumber(strsub(text,a+1,b-1))
                if spellID then
                    local spellIcon = GetSpellTexture(spellID)
                    icon:SetTexture(spellIcon)
                end
            else
                icon:SetTexture(nil)
            end

            if BG.helperTextQS_qs[#BG.helperZF] then
                BiaoGe.helperZF = {}
                for ii=1,#BG.helperZF do
                    local qs = {
                        name = BG.helperZF[ii].name,
                        zf = BG.helperTextQS_zf[ii]:GetText()
                    }
                    table.insert(BiaoGe.helperZF,qs)
                end
            end
        end)

        ed:SetScript("OnMouseDown", function(self,enter)
            if enter == "RightButton"  then  -- 右键清空格子
                self:SetEnabled(false)
                self:SetText("")
                if BG.lastfocus then
                    BG.lastfocus:ClearFocus()
                end
                return
            end
        end)
        ed:SetScript("OnMouseUp", function(self,enter)
            if enter == "RightButton"  then  -- 右键清空格子
                self:SetEnabled(true)
            end
        end)

        ed:SetScript("OnEnter", function(self)
            local text = self:GetText()
            local _,a = strfind(text,"spell:")
            if a then
                local b = strfind(text,":",a+1)
                local spellID = tonumber(strsub(text,a+1,b-1))
                if spellID then
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT",0,0)
                    GameTooltip:ClearLines()
                    GameTooltip:SetSpellByID(spellID)
                    GameTooltip:Show()
                end
            end
        end)
        ed:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        ed:SetScript("OnEditFocusGained", function(self)
            self:HighlightText()
            BG.lastfocus = self
            BG.Listzhufu(self)
        end)
        ed:SetScript("OnEditFocusLost", function(self)
            self:HighlightText(0,0)
            if BG.frameZhuFuList then
                BG.frameZhuFuList:Hide()
            end
        end)
    end
end

------------------灵魂石模块------------------
function BG.UpDateLingHunShi()
    BG.helperLHS = {}
    if IsInRaid() then
        local num = GetNumGroupMembers()
        for i=1,num do
            local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(i)
            if class == "术士" then
                name = strsplit("-",name)
                local yes
                if BiaoGe.helperLHS and Size(BiaoGe.helperLHS) ~= 0 then
                    for k,v in pairs(BiaoGe.helperLHS) do
                        if name == v.name then
                            local ss = {
                                name = name,
                                lhs = v.lhs,
                                color = v.color
                            }
                            table.insert(BG.helperLHS,ss)
                            yes = true
                        end
                    end
                end
                if not yes then
                    local ss = {
                        name = name,
                        lhs = "",
                        color = {1,1,1,1}
                    }
                    table.insert(BG.helperLHS,ss)
                end
            end
        end
    end
    BiaoGe.helperLHS = BG.helperLHS

    if BG.helperTextSS_ss then
        local max = #BG.helperTextSS_ss
        for i=1,max do
            BG.helperTextSS_ss[i]:Hide()
            BG.helperTextSS_lhs[i]:Hide()
            BG.helperTextSS_weizhi[i]:Hide()
        end
    end
    if Size(BG.helperLHS) == 0 then
        BG.helperTextSS_tishi:Show()
        BG.helperTongBao.buttonLHS:SetEnabled(false)
        return
    else
        BG.helperTextSS_tishi:Hide()
        BG.helperTongBao.buttonLHS:SetEnabled(true)
    end

    local down
    BG.helperTextSS_ss = {}
    BG.helperTextSS_lhs = {}
    BG.helperTextSS_weizhi = {}
    for i=1,#BG.helperLHS do
        if i == 7 then return end
        local text = BG.helperFrame:CreateFontString()  -- 术士
        text:SetPoint("TOPRIGHT",down or BG.helperTextSS,"BOTTOMRIGHT",0,-8)
        text:SetFontObject(GameFontNormal)
        text:SetText(BG.helperLHS[i].name)
        text:SetTextColor(GetClassRGB(BG.helperLHS[i].name))
        down = text
        BG.helperTextSS_ss[i] = text

        local ed = CreateFrame("EditBox", nil, BG.helperFrame, "InputBoxTemplate")  -- 输入框
        ed:SetSize(112, 20)
        ed:SetPoint("LEFT",text,"RIGHT",20,0)
        ed:SetAutoFocus(false)
        ed:SetText(BiaoGe.helperLHS[i].lhs)
        ed:SetTextColor(BiaoGe.helperLHS[i].color[1],BiaoGe.helperLHS[i].color[2],BiaoGe.helperLHS[i].color[3])
        BG.helperTextSS_lhs[i] = ed

        local frame = CreateFrame("Frame", nil, BG.helperFrame)     -- 位置
        frame:SetSize(40, 23)
        frame:SetPoint("RIGHT",ed,"RIGHT",0,-1)
        local fontString = frame:CreateFontString()
        fontString:SetAllPoints()
        fontString:SetFontObject(GameFontNormal)
        fontString:SetText("")
        BG.helperTextSS_weizhi[i] = fontString

        ed:SetScript("OnTextChanged", function(self)
            if BG.helperTextSS_ss[#BG.helperLHS] then
                BiaoGe.helperLHS = {}
                for ii=1,#BG.helperLHS do
                    local ss = {
                        name = BG.helperLHS[ii].name,
                        lhs = BG.helperTextSS_lhs[ii]:GetText(),
                        color = {BG.helperTextSS_lhs[ii]:GetTextColor()}
                    }
                    table.insert(BiaoGe.helperLHS,ss)
                end
            end
            local team = BG.GetRaidWeiZhi()
            for key, value in pairs(team) do
                if key == self:GetText() then
                    BG.helperTextSS_weizhi[i]:SetText(value)
                    local c = {self:GetTextColor()}
                    BG.helperTextSS_weizhi[i]:SetTextColor(c[1],c[2],c[3])
                end
            end
            if self:GetText() == "" then        -- 如果没有名字，就恢复白色
                self:SetTextColor(1,1,1)
                BG.helperTextSS_weizhi[i]:SetText("")
            end
        end)

        ed:SetScript("OnMouseDown", function(self,enter)
            if enter == "RightButton"  then  -- 右键清空格子
                self:SetEnabled(false)
                self:SetText("")
                if BG.lastfocus then
                    BG.lastfocus:ClearFocus()
                end
                return
            end
        end)
        ed:SetScript("OnMouseUp", function(self,enter)
            if enter == "RightButton"  then  -- 右键清空格子
                self:SetEnabled(true)
            end
        end)

        ed:SetScript("OnEditFocusGained", function(self)
            self:HighlightText()
            BG.lastfocus = self
            Listmaijia(self,0,0)
        end)
        ed:SetScript("OnEditFocusLost", function(self)
            self:HighlightText(0,0)
            if BG.FrameMaijiaList then
                BG.FrameMaijiaList:Hide()
            end
        end)
    end
end

------------------团减模块------------------
function BG.UpDateTuanJian()
    if not IsInRaid then
        for j=1,4 do
            for i=1,6 do
                BG.helperEditTJ["tj"..j..i]:SetText("")
                BG.helperEditTJ["tj"..j..i]:SetTextColor(1,1,1)
                BiaoGe.helperEditTJ["tj"..j..i] = ""
                BiaoGe.helperEditTJ["color"..j..i] = {1,1,1}
            end
        end
        return
    end

    local raidname = {}
    local num = GetNumGroupMembers()
    for i=1,num do
        local name = UnitName("raid"..i)
        table.insert(raidname,name)
    end
    local yes
    for j=1,4 do
        for i=1,6 do
            if i == 1 or i == 3 or i == 5 then
                local text = BG.helperEditTJ["tj"..j..i]:GetText()
                for index, value in pairs(raidname) do
                    if value == text then
                        yes = true
                    end
                end
                if not yes then
                    BG.helperEditTJ["tj"..j..i]:SetText("")
                    BG.helperEditTJ["tj"..j..i]:SetTextColor(1,1,1)
                    BG.helperEditTJ["tj"..j..(i+1)]:SetText("")
                    BG.helperEditTJ["tj"..j..(i+1)]:SetTextColor(1,1,1)
                    BiaoGe.helperEditTJ["tj"..j..i] = ""
                    BiaoGe.helperEditTJ["color"..j..i] = {1,1,1}
                    BiaoGe.helperEditTJ["tj"..j..(i+1)] = ""
                    BiaoGe.helperEditTJ["color"..j..(i+1)] = {1,1,1}
                end
            end
        end
    end
end


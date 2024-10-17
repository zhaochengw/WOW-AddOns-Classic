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
local Maxi = ns.Maxi
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi
local FrameHide = ns.FrameHide
local AddTexture = ns.AddTexture
local RGB_16 = ns.RGB_16
local GetItemID = ns.GetItemID

local pt = print

BG.History = {}

function BG.UpdateHistoryButton()
    local bt = BG.History.HistoryButton
    bt:SetFormattedText(L["历史表格（%d个）"], #BiaoGe.HistoryList[BG.FB1])
    bt:SetSize(bt:GetFontString():GetWidth(), 20)
end

function BG.HistoryUI()
    local parent = BG.FBMainFrame
    local width_jiange = -7

    ------------------下拉框架------------------
    do
        local f = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.9)
        f:SetSize(270, 380)
        f:SetPoint("TOPRIGHT", BG.MainFrame, "TOPRIGHT", -20, -20)
        f.frameLevel = 130
        f:SetFrameLevel(f.frameLevel)
        f:EnableMouse(true)
        f:Hide()
        BG.History.List = f
        f:SetScript("OnHide", function(self)
            BG.History.GaiMingFrame:Hide()
        end)

        local scroll = CreateFrame("ScrollFrame", nil, BG.History.List, "UIPanelScrollFrameTemplate") -- 滚动
        scroll:SetWidth(BG.History.List:GetWidth() - 27)
        scroll:SetHeight(BG.History.List:GetHeight() - 9)
        scroll:SetPoint("TOPLEFT", BG.History.List, "TOPLEFT", 0, -5)
        scroll.ScrollBar.scrollStep = BG.scrollStep
        BG.CreateSrollBarBackdrop(scroll.ScrollBar)
        BG.HookScrollBarShowOrHide(scroll)
        BG.History.scroll = scroll

        local child = CreateFrame("Frame", nil, BG.History.List) -- 子框架
        child:SetWidth(scroll:GetWidth())
        child:SetHeight(scroll:GetHeight())
        BG.History.child = child
        scroll:SetScrollChild(child)

        local TitleText = BG["HistoryFrame" .. BG.FB1]:CreateFontString() -- 标题
        TitleText:SetPoint("TOP", BG.MainFrame, "TOP", 0, -4);
        TitleText:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        TitleText:SetTextColor(RGB("00FF00"))
        BG.History.Title = TitleText

        local text = BG.History.List:CreateFontString() -- 提示文字
        text:SetPoint("TOP", BG.History.List, "BOTTOM", 0, 0)
        text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
        text:SetText(BG.STC_w1(L["（ALT+左键改名，ALT+右键删除表格）"]))
    end
    ------------------历史表格按键------------------
    do
        local bt = CreateFrame("Button", nil, parent)
        bt:SetPoint("TOPRIGHT", BG.MainFrame, "TOPRIGHT", -30, -1)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        BG.SetTextHighlightTexture(bt)
        BG.History.HistoryButton = bt
        BG.UpdateHistoryButton()
        -- 单击触发
        bt:SetScript("OnClick", function(self)
            FrameHide(2)
            if BG.History.SaveButton:GetButtonState() ~= "DISABLED" then
                BG.CreatHistoryListButton(BG.FB1)
            end
            if BG.History.List and BG.History.List:IsVisible() then
                BG.History.List:Hide()
            else
                BG.History.List:Show()
            end
            BG.PlaySound(1)
        end)
    end
    ------------------保存当前表格按键------------------
    do
        function BG.SaveBiaoGe(FB)
            local FB = FB or BG.FB1
            local DT = tonumber(date("%y%m%d%H%M%S", GetServerTime()))
            local DTcn = date(L["%m月%d日%H:%M:%S\n"], GetServerTime())
            BiaoGe.History[FB][DT] = {}
            BiaoGe.History[FB][DT].tradeTbl = {}
            for b = 1, Maxb[FB] + 2 do
                BiaoGe.History[FB][DT]["boss" .. b] = {}
                for i = 1, Maxi[FB] do
                    local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                    if zhuangbei then
                        if zhuangbei:GetText() ~= "" then
                            BiaoGe.History[FB][DT]["boss" .. b]["zhuangbei" .. i] = zhuangbei:GetText()
                        end

                        local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                        if maijia:GetText() ~= "" then
                            BiaoGe.History[FB][DT]["boss" .. b]["maijia" .. i] = maijia:GetText()
                            for k, v in pairs(BG.playerClass) do
                                BiaoGe.History[FB][DT]["boss" .. b][k .. i] = BiaoGe[FB]["boss" .. b][k .. i]
                            end
                        end

                        local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
                        if jine:GetText() ~= "" then
                            BiaoGe.History[FB][DT]["boss" .. b]["jine" .. i] = jine:GetText()
                        end

                        local guanzhu = BiaoGe[FB]["boss" .. b]["guanzhu" .. i]
                        if guanzhu then
                            BiaoGe.History[FB][DT]["boss" .. b]["guanzhu" .. i] = true
                        end

                        local qiankuan = BiaoGe[FB]["boss" .. b]["qiankuan" .. i]
                        if qiankuan then
                            BiaoGe.History[FB][DT]["boss" .. b]["qiankuan" .. i] = qiankuan
                        end

                        local loot = BG.Copy(BiaoGe[FB]["boss" .. b]["loot" .. i])
                        if loot then
                            BiaoGe.History[FB][DT]["boss" .. b]["loot" .. i] = loot
                        end
                    end
                end
                BiaoGe.History[FB][DT]["boss" .. b]["time"] = BiaoGe[FB]["boss" .. b]["time"]
            end
            for i, v in ipairs(BiaoGe[FB].tradeTbl) do
                BiaoGe.History[FB][DT].tradeTbl[i] = BG.Copy(v)
            end
            if BiaoGe[FB].raidRoster then
                BiaoGe.History[FB][DT].raidRoster = {}
                for k, v in pairs(BiaoGe[FB].raidRoster) do
                    BiaoGe.History[FB][DT].raidRoster[k] = BG.Copy(v)
                end
            end
            if BiaoGe[FB].lockoutIDtbl then
                BiaoGe.History[FB][DT].lockoutIDtbl = {}
                for k, v in pairs(BiaoGe[FB].lockoutIDtbl) do
                    BiaoGe.History[FB][DT].lockoutIDtbl[k] = BG.Copy(v)
                end
            end
            if BiaoGe[FB].auctionLog then
                BiaoGe.History[FB][DT].auctionLog = {}
                for k, v in pairs(BiaoGe[FB].auctionLog) do
                    BiaoGe.History[FB][DT].auctionLog[k] = BG.Copy(v)
                end
            end

            local d = { DT, format(L["%s%s %s人 工资:%s"], DTcn, BG.GetFBinfo(FB, "localName"),
                BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. 4]:GetText(),
                BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. 5]:GetText()) }
            table.insert(BiaoGe.HistoryList[FB], 1, d)
            BG.UpdateHistoryButton()
            BG.CreatHistoryListButton(FB)
        end

        local bt = CreateFrame("Button", nil, parent)
        bt:SetPoint("TOPRIGHT", BG.History.HistoryButton, "TOPLEFT", width_jiange, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(L["保存表格"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        BG.History.SaveButton = bt

        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(L["把当前表格保存至历史表格。"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        -- 单击触发
        bt:SetScript("OnClick", function(self)
            FrameHide(2)
            self:SetEnabled(false) -- 点击后按钮变灰2秒
            C_Timer.After(0.5, function()
                bt:SetEnabled(true)
            end)
            BG.SaveBiaoGe()
            BG.PlaySound(2)
        end)
    end
    ------------------分享表格按键------------------
    do
        local bt = CreateFrame("Button", nil, parent)
        bt:SetPoint("TOPRIGHT", BG.History.SaveButton, "TOPLEFT", width_jiange, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(L["分享表格"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        BG.History.SendButton = bt

        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(L["把当前表格发给别人，类似发WA那样。"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        local updateFrame = CreateFrame("Frame")
        updateFrame.timeElapsed = 0
        BG.canSendBiaoGe = false
        bt:SetScript("OnClick", function(self)
            BG.canSendBiaoGe = true
            updateFrame.timeElapsed = 0
            updateFrame:SetScript("OnUpdate", function(self, elapsed)
                updateFrame.timeElapsed = updateFrame.timeElapsed + elapsed
                if updateFrame.timeElapsed >= 300 then
                    BG.canSendBiaoGe = false
                    updateFrame.timeElapsed = 0
                    updateFrame:SetScript("OnUpdate", nil)
                end
            end)

            FrameHide(2)

            local text = ""
            local playerFullName, server = UnitFullName("player")
            playerFullName = playerFullName .. "-" .. server
            text = "[BiaoGe:" .. playerFullName .. "-"
            if not BG.History.EscButton:IsVisible() then
                text = text .. L["当前表格-"] .. BG.FB1 .. "]" -- [BiaoGe:风行-阿拉希盆地-当前表格-ULD]
            else
                local t = BiaoGe.HistoryList[BG.FB1][BG.History.chooseNum][2]
                t = string.gsub(t, "\n", "")
                text = text .. L["历史表格-"] .. BG.FB1 .. "-" .. t .. "]" -- [BiaoGe:风行-阿拉希盆地-历史表格-ULD-04月20日18:20:23 奥杜尔 25人 工资:15000]
            end
            ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
            ChatEdit_InsertLink(text)

            BG.PlaySound(1)
        end)
    end
    ------------------导出表格按键------------------
    do
        BG.frameWenBen = {}
        local f = CreateFrame("Frame", nil, BG.MainFrame, "BasicFrameTemplate")
        f:SetWidth(350)
        f:SetHeight(650)
        f.TitleText:SetText(L["导出表格"])
        f:SetFrameLevel(300)
        f:SetPoint("CENTER")
        f:EnableMouse(true)
        f:SetMovable(true)
        f:SetToplevel(true)
        f:Hide()
        f:SetScript("OnMouseUp", function(self)
            self:StopMovingOrSizing()
        end)
        f:SetScript("OnMouseDown", function(self)
            self:StartMoving()
        end)
        BG.frameWenBen.frame = f

        local edit = CreateFrame("EditBox", nil, BG.frameWenBen.frame)
        edit:SetWidth(BG.frameWenBen.frame:GetWidth() - 27)
        edit:SetHeight(1)
        edit:SetAutoFocus(true)
        edit:EnableMouse(true)
        edit:SetTextInsets(10, 10, 10, 10)
        edit:SetMultiLine(true)
        edit:SetFontObject(GameFontNormal)
        edit:HookScript("OnEscapePressed", function()
            BG.frameWenBen.frame:Hide()
        end)
        BG.frameWenBen.edit = edit

        local scroll = CreateFrame("ScrollFrame", nil, BG.frameWenBen.frame, "UIPanelScrollFrameTemplate")
        scroll:SetWidth(BG.frameWenBen.frame:GetWidth() - 27)
        scroll:SetHeight(BG.frameWenBen.frame:GetHeight() - 29)
        scroll:SetPoint("BOTTOMLEFT", BG.frameWenBen.frame, "BOTTOMLEFT", 0, 2)
        scroll.ScrollBar.scrollStep = BG.scrollStep
        BG.CreateSrollBarBackdrop(scroll.ScrollBar)
        BG.HookScrollBarShowOrHide(scroll)
        scroll:SetScrollChild(edit)
        BG.frameWenBen.scroll = scroll

        -- 创建按键
        local bt = CreateFrame("Button", nil, parent)
        bt:SetPoint("TOPRIGHT", BG.History.SendButton, "TOPLEFT", width_jiange, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(L["导出表格"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        BG.History.DaoChuButton = bt

        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(L["把表格导出为文本。"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
        bt:SetScript("OnClick", function(self)
            if BG.frameWenBen.frame:IsVisible() then
                BG.frameWenBen.frame:Hide()
                return
            else
                BG.frameWenBen.frame:Show()
            end
            local FB = BG.FB1
            local Frame
            local text
            if BG["Frame" .. FB]:IsVisible() then
                Frame = BG.Frame
            elseif BG["HistoryFrame" .. FB]:IsVisible() then
                Frame = BG.HistoryFrame
            end
            BG.frameWenBen.edit:SetText("")
            for b = 1, Maxb[FB] + 2 do
                local bossname2 = BG.Boss[FB]["boss" .. b].name2
                local bosscolor = BG.Boss[FB]["boss" .. b].color
                text = "|cff" .. bosscolor .. bossname2 .. RN
                BG.frameWenBen.edit:Insert(text) -- BOSS名字
                for i = 1, Maxi[FB] do
                    if Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                        if Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText() ~= "" or Frame[FB]["boss" .. b]["maijia" .. i]:GetText() ~= "" or Frame[FB]["boss" .. b]["jine" .. i]:GetText() ~= "" then
                            text = Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText() .. " " .. RGB_16(Frame[FB]["boss" .. b]["maijia" .. i]) .. " " .. Frame[FB]["boss" .. b]["jine" .. i]:GetText() .. "\n"
                            BG.frameWenBen.edit:Insert(text)
                        end
                    end
                end
                BG.frameWenBen.edit:Insert("\n")
            end
            -- 删掉末尾的两个回车
            local text = BG.frameWenBen.edit:GetText()
            text = strsub(text, 1, -2)
            BG.frameWenBen.edit:SetText(text)
            BG.frameWenBen.edit:HighlightText()
            -- 设置滚动条到末尾
            C_Timer.After(0, function()
                BG.SetScrollBottom(BG.frameWenBen.scroll, BG.frameWenBen.edit)
            end)
        end)
    end
    ------------------应用表格按键------------------
    do
        function BG.SetBiaoGeFormHistory(FB, num)
            local num = num or BG.History.chooseNum
            local FB = FB or BG.FB1
            for _date, value in pairs(BiaoGe.History[FB]) do
                if tonumber(_date) == tonumber(BiaoGe.HistoryList[FB][num][1]) then
                    local DT = BiaoGe.HistoryList[FB][num][1]
                    for b = 1, Maxb[FB] + 2 do
                        for i = 1, Maxi[FB] do
                            if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                                BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:SetText(BiaoGe.History[FB][DT]["boss" .. b]["zhuangbei" .. i] or "")
                                BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetText(BiaoGe.History[FB][DT]["boss" .. b]["maijia" .. i] or "")
                                BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetCursorPosition(0)
                                if BiaoGe.History[FB][DT]["boss" .. b]["color" .. i] then
                                    BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetTextColor(unpack(BiaoGe.History[FB][DT]["boss" .. b]["color" .. i]))
                                end
                                BG.Frame[FB]["boss" .. b]["jine" .. i]:SetText(BiaoGe.History[FB][DT]["boss" .. b]["jine" .. i] or "")
                                BG.Frame[FB]["boss" .. b]["guanzhu" .. i]:Hide()
                                BiaoGe[FB]["boss" .. b]["guanzhu" .. i] = nil

                                BiaoGe[FB]["boss" .. b]["zhuangbei" .. i] = BiaoGe.History[FB][DT]["boss" .. b]["zhuangbei" .. i]
                                BiaoGe[FB]["boss" .. b]["maijia" .. i] = BiaoGe.History[FB][DT]["boss" .. b]["maijia" .. i]
                                BiaoGe[FB]["boss" .. b]["jine" .. i] = BiaoGe.History[FB][DT]["boss" .. b]["jine" .. i]
                                for k, v in pairs(BG.playerClass) do
                                    BiaoGe[FB]["boss" .. b][k .. i] = BiaoGe.History[FB][DT]["boss" .. b][k .. i]
                                end

                                if BiaoGe.History[FB][DT]["boss" .. b]["guanzhu" .. i] then
                                    BiaoGe[FB]["boss" .. b]["guanzhu" .. i] = true
                                    BG.Frame[FB]["boss" .. b]["guanzhu" .. i]:Show()
                                else
                                    BiaoGe[FB]["boss" .. b]["guanzhu" .. i] = nil
                                    BG.Frame[FB]["boss" .. b]["guanzhu" .. i]:Hide()
                                end

                                if BiaoGe.History[FB][DT]["boss" .. b]["qiankuan" .. i] then
                                    BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = BiaoGe.History[FB][DT]["boss" .. b]["qiankuan" .. i]
                                    BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Show()
                                else
                                    BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = nil
                                    BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Hide()
                                end

                                if BiaoGe.History[FB][DT]["boss" .. b]["loot" .. i] then
                                    BiaoGe[FB]["boss" .. b]["loot" .. i] = BG.Copy(BiaoGe.History[FB][DT]["boss" .. b]["loot" .. i])
                                else
                                    BiaoGe[FB]["boss" .. b]["loot" .. i] = nil
                                end
                            end
                        end
                        if BG.Frame[FB]["boss" .. b]["time"] then
                            if BiaoGe.History[FB][DT]["boss" .. b]["time"] then
                                BG.Frame[FB]["boss" .. b]["time"]:SetText(L["击杀用时"] .. " " .. BiaoGe.History[FB][DT]["boss" .. b]["time"])
                            else
                                BG.Frame[FB]["boss" .. b]["time"]:SetText("")
                            end
                            BiaoGe[FB]["boss" .. b]["time"] = BiaoGe.History[FB][DT]["boss" .. b]["time"]
                        end
                    end
                    BiaoGe[FB].tradeTbl = {}
                    if type(BiaoGe.History[FB][DT].tradeTbl) == "table" then
                        for i, v in ipairs(BiaoGe.History[FB][DT].tradeTbl) do
                            BiaoGe[FB].tradeTbl[i] = BG.Copy(v)
                        end
                    end
                    if type(BiaoGe.History[FB][DT].raidRoster) == "table" then
                        BiaoGe[FB].raidRoster = {}
                        for k, v in pairs(BiaoGe.History[FB][DT].raidRoster) do
                            BiaoGe[FB].raidRoster[k] = BG.Copy(v)
                        end
                    end
                    if type(BiaoGe.History[FB][DT].lockoutIDtbl) == "table" then
                        BiaoGe[FB].lockoutIDtbl = {}
                        for k, v in pairs(BiaoGe.History[FB][DT].lockoutIDtbl) do
                            BiaoGe[FB].lockoutIDtbl[k] = BG.Copy(v)
                        end
                    end
                    if type(BiaoGe.History[FB][DT].auctionLog) == "table" then
                        BiaoGe[FB].auctionLog = {}
                        for k, v in pairs(BiaoGe.History[FB][DT].auctionLog) do
                            BiaoGe[FB].auctionLog[k] = BG.Copy(v)
                        end
                    end
                    break
                end
            end
            if BiaoGe.lastFrame == "FB" then
                BG.FBMainFrame:Show()
                BG.UpdateLockoutIDText()
            end
            BG.UpdateAuctionLogFrame()
        end

        local bt = CreateFrame("Button", nil, BG.HistoryMainFrame)
        bt:SetPoint("TOPRIGHT", BG.History.DaoChuButton, "TOPLEFT", width_jiange, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(L["应用表格"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        BG.History.YongButton = bt

        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(L["把该历史表格复制粘贴到当前表格，这样你可以编辑内容。"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
        bt:SetScript("OnClick", function(self)
            local FB = BG.FB1
            if BG.BiaoGeIsHavedItem(FB) then
                StaticPopup_Show("YINGYONGBIAOGE")
                return
            end
            BG.SetBiaoGeFormHistory()
            BG.PlaySound(2)
        end)

        StaticPopupDialogs["YINGYONGBIAOGE"] = {
            text = L["确定应用表格？\n你当前的表格将被"] .. BG.STC_r1(L[" 替换 "]),
            button1 = L["是"],
            button2 = L["否"],
            OnCancel = function()
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            showAlert = true,
        }
        StaticPopupDialogs["YINGYONGBIAOGE"].OnAccept = function()
            BG.SetBiaoGeFormHistory()
            BG.PlaySound(2)
        end
    end
    ------------------退出历史表格按键------------------
    do
        local bt = CreateFrame("Button", nil, BG.HistoryMainFrame)
        bt:SetPoint("TOPRIGHT", BG.History.YongButton, "TOPLEFT", width_jiange, 0)
        bt:SetNormalFontObject(BG.FontFen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(L["返回表格"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        BG.History.EscButton = bt

        bt:SetScript("OnClick", function(self)
            FrameHide(2)
            BG.FBMainFrame:Show()
            BG.UpdateAuctionLogFrame()
            BG.PlaySound(1)
        end)
    end

    ------------------改名------------------
    do
        local f = CreateFrame("Frame", nil, BG.History.List, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.9)
        f:SetSize(250, 150)
        f:SetPoint("TOPRIGHT", BG.History.List, "TOPLEFT", -2, 0)
        f:SetFrameLevel(130)
        f:Hide()
        BG.History.GaiMingFrame = f
        f:SetScript("OnMouseDown", function(self)
        end)

        local text = f:CreateFontString() -- 标题
        text:SetPoint("TOP", BG.History.GaiMingFrame, "TOP", 0, -20)
        text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        text:SetTextColor(RGB("00BFFF"))
        BG.History.GaiMingBiaoTi = text

        local f = CreateFrame("Frame", nil, BG.History.GaiMingFrame, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.2)
        f:SetSize(230, 60)
        f:SetPoint("TOPRIGHT", BG.History.GaiMingFrame, "TOPRIGHT", -10, -45)

        local edit = CreateFrame("EditBox", nil, f)
        edit:SetSize(f:GetWidth() - 10, f:GetHeight())
        edit:SetPoint("TOPLEFT", 5, -5)
        edit:SetAutoFocus(false)
        edit:EnableMouse(true)
        edit:SetMultiLine(true)
        edit:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
        edit.bg = f
        BG.History.GaiMingEdit1 = edit
        edit:SetScript("OnEscapePressed", function(self)
            BG.History.GaiMingFrame:Hide()
        end)
        f:SetScript("OnMouseDown", function(self)
            edit:SetFocus()
            edit:SetCursorPosition(strlen(edit:GetText()))
        end)

        local bt = CreateFrame("Button", nil, BG.History.GaiMingFrame, "UIPanelButtonTemplate")
        bt:SetSize(110, 25)
        bt:SetPoint("BOTTOMLEFT", BG.History.GaiMingFrame, "BOTTOMLEFT", 10, 15)
        bt:SetText(L["确定"])
        bt:SetScript("OnClick", function(self)
            local FB = BG.FB1
            local text = BG.History.GaiMingEdit1:GetText()
            if text ~= "" then
                for i, v in ipairs(BiaoGe.HistoryList[FB]) do
                    if i ~= BG.History.GaiMingNum then
                        if v[2] == text then
                            SendSystemMessage(BG.BG .. BG.STC_r1(L["不能使用该名字，因为跟其他历史表格重名！"]))
                            return
                        end
                    end
                end

                BiaoGe.HistoryList[FB][BG.History.GaiMingNum][2] = text
                BG.History.GaiMingFrame:Hide()
                BG.CreatHistoryListButton(FB)

                BG.PlaySound(1)
            end
        end)

        local bt = CreateFrame("Button", nil, BG.History.GaiMingFrame, "UIPanelButtonTemplate")
        bt:SetSize(110, 25)
        bt:SetPoint("BOTTOMRIGHT", BG.History.GaiMingFrame, "BOTTOMRIGHT", -10, 15)
        bt:SetText(L["取消"])
        bt:SetScript("OnClick", function(self)
            BG.History.GaiMingFrame:Hide()
            BG.PlaySound(1)
        end)
    end
    ------------------装备历史价格框架------------------
    do
        BG.HistoryJineDB = {}

        local f = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
        f:SetSize(300, 210)
        f:SetPoint("BOTTOMRIGHT", BG.MainFrame, "BOTTOMRIGHT", -3, 80)
        f:SetFrameLevel(118)
        f:Hide()
        BG.HistoryJineFrame = f

        f.tex = f:CreateTexture()
        f.tex:SetSize(f:GetWidth(), f:GetHeight() + 50)
        f.tex:SetPoint("TOP")
        f.tex:SetTexture("Interface\\Buttons\\WHITE8x8")
        f.tex:SetGradient("VERTICAL", CreateColor(0, 0, 0, 0), CreateColor(0, 0, 0, 1))

        --标题（装备）
        local text = BG.HistoryJineFrame:CreateFontString()
        text:SetPoint("TOP", BG.HistoryJineFrame, "TOP", 3, -10)
        text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        BG.HistoryJineFrameBiaoTi = text
    end
end

------------------下拉框架的内容------------------
do
    function BG.CreatHistoryListButton(FB)
        -- 先隐藏列表内容
        local i = 1
        while BG.History["ListButton" .. i] do
            BG.History["ListButton" .. i]:Hide()
            BG.History["ListButton" .. i] = nil
            i = i + 1
        end
        -- BG.History.scroll.ScrollBar:Hide()

        -- 再重新创建新的列表内容
        for i = 1, #BiaoGe.HistoryList[FB] do
            local bt = CreateFrame("Button", nil, BG.History.child, "BackdropTemplate")
            bt:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
            })
            bt:SetBackdropColor(1, 1, 1, 0.1)
            if i == 1 then
                bt:SetPoint("TOPLEFT", BG.History.child, "TOPLEFT", 10, -10)
            else
                bt:SetPoint("TOPLEFT", BG.History["ListButton" .. i - 1], "BOTTOMLEFT", 0, -5)
            end
            bt:SetSize(230, 40)
            bt:SetNormalFontObject(BG.FontBlue13)
            bt:SetDisabledFontObject(BG.FontWhite13)
            bt:SetHighlightFontObject(BG.FontWhite13)
            bt:SetText("" .. i .. ". " .. BiaoGe.HistoryList[FB][i][2])
            local t = bt:GetFontString()
            t:SetWidth(bt:GetWidth() - 10)
            t:SetPoint("LEFT", 3, 0)
            t:SetJustifyH("LEFT")
            BG.History["ListButton" .. i] = bt
            local tex2 = bt:CreateTexture(nil, "ARTWORK")
            tex2:SetAllPoints()
            tex2:SetColorTexture(RGB(BG.b1))
            bt:SetDisabledTexture(tex2)

            bt:HookScript("OnEnter", function(self)
                bt:SetBackdropColor(RGB(BG.b1, 0.6))
            end)
            bt:HookScript("OnLeave", function(self)
                bt:SetBackdropColor(1, 1, 1, 0.1)
            end)

            -- 单击触发
            bt:SetScript("OnMouseUp", function(self, button)
                FrameHide(2)

                if IsAltKeyDown() then
                    if button == "RightButton" then -- 删除
                        BG.PlaySound(1)
                        BG.DeleteHistory(FB, i)
                        BG.History.GaiMingFrame:Hide()
                        for b = 1, Maxb[FB] + 2 do
                            for i = 1, Maxi[FB] do
                                if BG.HistoryFrame[FB]["boss" .. b]["zhuangbei" .. i] then
                                    BG.HistoryFrame[FB]["boss" .. b]["zhuangbei" .. i]:SetText("")
                                    BG.HistoryFrame[FB]["boss" .. b]["maijia" .. i]:SetText("")
                                    BG.HistoryFrame[FB]["boss" .. b]["maijia" .. i]:SetTextColor(1, 1, 1)
                                    BG.HistoryFrame[FB]["boss" .. b]["jine" .. i]:SetText("")
                                    BG.HistoryFrame[FB]["boss" .. b]["guanzhu" .. i]:Hide()
                                    BG.HistoryFrame[FB]["boss" .. b]["qiankuan" .. i]:Hide()
                                end
                            end
                            if BG.HistoryFrame[FB]["boss" .. b]["time"] then
                                BG.HistoryFrame[FB]["boss" .. b]["time"]:SetText("")
                            end
                        end
                        BG.History.Title:SetText(L["< 历史表格 > "])
                        BG.TextLockoutID:SetText(L["团本锁定ID："] .. L["无"])
                        BG.TextLockoutID:SetTextColor(0.5, 0.5, 0.5)
                        return
                    else -- 改名
                        BG.PlaySound(1)
                        BG.History.GaiMingNum = i
                        BG.History.GaiMingFrame:Show()
                        BG.History.GaiMingBiaoTi:SetText(format(L["你正在改名第 %s 个表格"], i))
                        BG.History.GaiMingEdit1:SetText(BiaoGe.HistoryList[FB][i][2])
                        BG.History.GaiMingEdit1:SetFocus()
                        BG.History.GaiMingEdit1:HighlightText()
                        return
                    end
                end

                do
                    local i = 1
                    while BG.History["ListButton" .. i] do
                        BG.History["ListButton" .. i]:Enable()
                        i = i + 1
                    end
                    if self:IsEnabled() then
                        BG.PlaySound(1)
                    end
                    self:Disable()
                end

                BG.History.chooseNum = i
                local DT = BiaoGe.HistoryList[FB][i][1]
                for b = 1, Maxb[FB] + 2 do
                    for i = 1, Maxi[FB] do
                        if BG.HistoryFrame[FB]["boss" .. b]["zhuangbei" .. i] then
                            BG.HistoryFrame[FB]["boss" .. b]["zhuangbei" .. i]:SetText(BiaoGe.History[FB][DT]["boss" .. b]["zhuangbei" .. i] or "")
                            BG.HistoryFrame[FB]["boss" .. b]["maijia" .. i]:SetText(BiaoGe.History[FB][DT]["boss" .. b]["maijia" .. i] or "")
                            BG.HistoryFrame[FB]["boss" .. b]["maijia" .. i]:SetCursorPosition(0)
                            if BiaoGe.History[FB][DT]["boss" .. b]["color" .. i] then
                                BG.HistoryFrame[FB]["boss" .. b]["maijia" .. i]:SetTextColor(unpack(BiaoGe.History[FB][DT]["boss" .. b]["color" .. i]))
                            end
                            BG.HistoryFrame[FB]["boss" .. b]["jine" .. i]:SetText(BiaoGe.History[FB][DT]["boss" .. b]["jine" .. i] or "")

                            if BiaoGe.History[FB][DT]["boss" .. b]["guanzhu" .. i] then
                                BG.HistoryFrame[FB]["boss" .. b]["guanzhu" .. i]:Show()
                            else
                                BG.HistoryFrame[FB]["boss" .. b]["guanzhu" .. i]:Hide()
                            end

                            if BiaoGe.History[FB][DT]["boss" .. b]["qiankuan" .. i] then
                                BG.HistoryFrame[FB]["boss" .. b]["qiankuan" .. i].qiankuan = BiaoGe.History[FB][DT]["boss" .. b]["qiankuan" .. i]
                                BG.HistoryFrame[FB]["boss" .. b]["qiankuan" .. i]:Show()
                            else
                                BG.HistoryFrame[FB]["boss" .. b]["qiankuan" .. i]:Hide()
                            end
                        end
                    end
                    if BG.HistoryFrame[FB]["boss" .. b]["time"] then
                        if BiaoGe.History[FB][DT]["boss" .. b]["time"] then
                            BG.HistoryFrame[FB]["boss" .. b]["time"]:SetText(L["击杀用时"] .. " " .. BiaoGe.History[FB][DT]["boss" .. b]["time"])
                        else
                            BG.HistoryFrame[FB]["boss" .. b]["time"]:SetText("")
                        end
                    end
                end
                BG.HistoryMainFrame:Show()

                BG.History.Title:SetParent(BG["HistoryFrame" .. FB])
                BG.History.Title:SetText(L["< 历史表格 > "] .. " " .. i)
                BG.History.chooseNum = i

                BG.UpdateLockoutIDText(DT)
                BG.UpdateAuctionLogFrame(BiaoGe.History[FB][DT].auctionLog)
            end)
        end
    end

    function BG.DeleteHistory(FB, num)
        local FB = FB or BG.FB1
        for _date, value in pairs(BiaoGe.History[FB]) do
            if tonumber(_date) == tonumber(BiaoGe.HistoryList[FB][num][1]) then
                BiaoGe.History[FB][_date] = nil
                break
            end
        end
        table.remove(BiaoGe.HistoryList[FB], num)
        BG.History.chooseNum = nil
        BG.UpdateHistoryButton()
        BG.CreatHistoryListButton(FB)
        BG.UpdateAuctionLogFrame()
    end
end

------------------装备历史价格------------------
do
    function BG.HistoryJine(FB, itemID, dangqian, jine) -- dangqian：用来确定是否显示当前鼠标悬停的装备价格
        BG.HistoryJineFrame:Hide()
        if BG["HistoryJineFrameDB1"] then
            for i = 1, BG.HistoryJineFrameDBMax do
                BG["HistoryJineFrameDB" .. i]:Hide()
            end
            BG.HistoryJineFrame:Hide()
        end

        local itemStackCount = select(8, GetItemInfo(itemID))
        if not itemStackCount or itemStackCount > 1 then return end

        local maxCount
        if dangqian then
            maxCount = 7
        else
            maxCount = 8
        end
        local db = {}
        local num = 1
        for DT in pairs(BiaoGe.History[FB]) do
            if num > 15 then break end
            for b = 1, Maxb[FB] do
                for i = 1, Maxi[FB] do
                    local zhuangbei = BiaoGe.History[FB][DT]["boss" .. b]["zhuangbei" .. i]
                    if zhuangbei then
                        local HitemID = GetItemID(zhuangbei)
                        if HitemID and (HitemID == itemID) and tonumber(BiaoGe.History[FB][DT]["boss" .. b]["jine" .. i]) then
                            local m = BiaoGe.History[FB][DT]["boss" .. b]["maijia" .. i] or ""
                            local c = BiaoGe.History[FB][DT]["boss" .. b]["color" .. i] or { 1, 1, 1 }
                            local j = BiaoGe.History[FB][DT]["boss" .. b]["jine" .. i]
                            table.insert(db, {
                                tonumber(DT),
                                zhuangbei,
                                m,
                                c,
                                tonumber(j)
                            })
                        end
                    end
                end
            end
            num = num + 1
        end
        if #db == 0 then
            BG.HistoryJineDB = {}
            return
        end

        sort(db, function(a, b)
            return a[1] > b[1]
        end)

        if #db > maxCount then
            for i = #db, maxCount + 1, -1 do
                tremove(db, i)
            end
        end

        if dangqian then
            if not tonumber(jine) or tonumber(jine) == 0 then
                jine = 0
            end
            local a = { 0, "", "", { 1, 1, 1 }, tonumber(jine) }
            table.insert(db, 1, a)
        end
        local maxJine -- 找到表格里最大的金额
        for i = 1, #db do
            if maxJine == nil then
                maxJine = db[i][5]
            end
            if maxJine < db[i][5] then
                maxJine = db[i][5]
            end
        end
        BG.HistoryJineFrame:Show()
        local name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(itemID)
        if not link then return end
        BG.HistoryJineFrameBiaoTi:SetText(format(L["历史价格：%s%s(%s)"], (AddTexture(Texture) .. link), "|cff" .. "9370DB", level or ""))

        local down
        -- local color = {"00FFFF","00FFCC","00FF99","00FF66","00FF33","00FF00","00FF33","00FF66","00FF99","00FFCC"}   -- 绿色渐变
        -- local color = {"6600FF","3300FF","6633FF","3300CC","0033CC","3366FF","0033FF","0066FF","0099FF","00CCFF"}   -- 蓝色渐变
        local color = { (dangqian and "00BFFF" or "33FFCC"), "00FFCC", "00FF99", "00FF66", "00FF33", "33FF66", "00CC33", "33CC00", "66FF33", "33FF00", "66FF00", "99FF00", "CCFF00", "CCFF33", "99CC00" } -- 蓝绿渐变
        for i = 1, #db do
            local f = CreateFrame("Frame", nil, BG.HistoryJineFrame, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            })
            f:SetBackdropColor(RGB(color[i], 1))
            if i == 1 then
                f:SetPoint("TOPRIGHT", BG.HistoryJineFrame, "TOPRIGHT", -80, -40)
            else
                f:SetPoint("TOPRIGHT", down, "BOTTOMRIGHT", 0, -8)
            end
            local widthPercent = db[i][5] / maxJine
            local width
            if widthPercent == 0 then
                width = 1
            else
                width = (BG.HistoryJineFrame:GetWidth() - 160) * widthPercent
            end
            f:SetSize(width, 14)
            down = f
            BG["HistoryJineFrameDB" .. i] = f
            BG.HistoryJineFrameDBMax = i

            local text = f:CreateFontString() -- 日期
            text:SetPoint("LEFT", f, "RIGHT", 3, 0)
            text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            text:SetTextColor(RGB(color[i]))
            if dangqian and i == 1 then
                text:SetText(L["当前"])
            else
                local a = strsub(db[i][1], 3, 4)
                local b = strsub(db[i][1], 5, 6)
                local t = a .. L["月"] .. b .. L["日"]
                text:SetText(t)
            end

            local text = f:CreateFontString() -- 金额
            text:SetPoint("RIGHT", f, "LEFT", -3, 0)
            text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            text:SetTextColor(RGB(color[i]))
            local t = db[i][5]
            text:SetText(t)
            local textjine = text

            local text = f:CreateFontString() -- 买家
            text:SetPoint("CENTER", f, "CENTER", 0, 1)
            text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
            text:SetTextColor(db[i][4][1], db[i][4][2], db[i][4][3])
            local t = db[i][3]
            text:SetText(t)
            if IsControlKeyDown() then
                text:Show()
            else
                text:Hide()
            end
        end
        BG.HistoryJineDB.DB = db
        BG.HistoryJineDB.Link = link
    end
end

-- 按住CTRL时显示买家
local frame = CreateFrame("Frame")
frame:RegisterEvent("MODIFIER_STATE_CHANGED")
frame:SetScript("OnEvent", function(self, event, enter)
    if (enter == "LCTRL" or enter == "RCTRL") and BG.HistoryJineFrame:IsVisible() then
        BG.HistoryJine(unpack(BG.HistoryMOD))
    end
end)

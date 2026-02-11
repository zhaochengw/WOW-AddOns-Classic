if BG.IsBlackListPlayer then return end
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
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local pt = print

local dangqianTbl = { "当前表格", "當前表格", "Current table" }
local historyTbl = { "历史表格", "歷史表格", "Historical table" }

function BG.ReceiveUI()
    ----------接收表格主界面----------
    do
        BG.ReceiveMainFrame = CreateFrame("Frame", "BG.ReceiveFrame", UIParent, "BackdropTemplate")
        BG.ReceiveMainFrame:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 2
        })
        BG.ReceiveMainFrame:SetBackdropColor(0, 0, 0, 0.9)
        BG.ReceiveMainFrame:SetPoint("CENTER")
        BG.ReceiveMainFrame:SetFrameLevel(100)
        BG.ReceiveMainFrame:SetMovable(true)
        BG.ReceiveMainFrame:SetToplevel(true)
        BG.ReceiveMainFrame:SetScript("OnMouseUp", function(self)
            self:StopMovingOrSizing()
        end)
        BG.ReceiveMainFrame:SetScript("OnMouseDown", function(self)
            BG.FrameHide(0)
            self:StartMoving()
        end)
        BG.ReceiveMainFrame:SetScript("OnHide", function(self)
            StaticPopup_Hide("BiaoGe_YingYongReceiveBiaoGe")
        end)
        -- BG.After(3, function()
        --     for k, FB in pairs(BG.FBtable) do
        --         BG.CreateFBUI(FB, "Receive")
        --     end
        --     local FB = "DS"
        --     BG["ReceiveFrame" .. FB]:Show()
        --     BG.ReceiveMainFrame:SetWidth(BG.FBWidth[FB])
        --     BG.ReceiveMainFrame:SetHeight(BG.FBHeight[FB] - 20)
        --     BG.ReceiveMainFrame:Show()
        -- end)
        tinsert(UISpecialFrames, "BG.ReceiveFrame") -- 按ESC可关闭插件

        local _, class = UnitClass("player")
        local r, g, b, cff = GetClassColor(class)
        BG.ReceiveMainFrame:SetBackdropBorderColor(r, g, b)

        BG.ReceiveMainFrame.CloseButton = CreateFrame("Button", nil, BG.ReceiveMainFrame, "UIPanelCloseButton")
        BG.ReceiveMainFrame.CloseButton:SetPoint("TOPRIGHT", BG.ReceiveMainFrame, "TOPRIGHT", 0, 0)
        BG.ReceiveMainFrame.CloseButton:SetSize(40, 40)

        local TitleText = BG.ReceiveMainFrame:CreateFontString()
        TitleText:SetPoint("TOP", BG.ReceiveMainFrame, "TOP", 0, -10)
        TitleText:SetFont(BIAOGE_TEXT_FONT, 16, "OUTLINE")
        BG.ReceiveMainFrameTitle = TitleText

        local l = BG.ReceiveMainFrame:CreateLine()
        l:SetColorTexture(r, g, b)
        l:SetStartPoint("BOTTOMLEFT", TitleText, -20, -2)
        l:SetEndPoint("BOTTOMRIGHT", TitleText, 20, -2)
        l:SetThickness(1.5)

        local bt = BG.CreateButton(BG.ReceiveMainFrame)
        bt:SetSize(120, 25)
        bt:SetPoint("BOTTOMRIGHT", BG.ReceiveMainFrame, "BOTTOM", -10, 20)
        bt:SetText(L["使用该表格"])
        bt:SetScript("OnClick", function(self)
            BG.PlaySound(1)
            if not StaticPopupDialogs["BiaoGe_YingYongReceiveBiaoGe"] then
                StaticPopupDialogs["BiaoGe_YingYongReceiveBiaoGe"] = {
                    text = L["确定使用该表格？\n你的当前表格将被其|cffff0000替换|r"],
                    button1 = L["是"],
                    button2 = L["否"],
                    OnCancel = function()
                    end,
                    timeout = 0,
                    whileDead = true,
                    hideOnEscape = true,
                    showAlert = true,
                }
            end
            StaticPopupDialogs["BiaoGe_YingYongReceiveBiaoGe"].OnAccept = function()
                local FB = BG.ReceiveBiaoGe.FB
                BG.ClearBiaoGe("biaoge", FB)
                BG.PairFBItem(function(item, buyer, money, b, i)
                    item:SetText(BG.ReceiveBiaoGe["boss" .. b]["zhuangbei" .. i] or "")
                    buyer:SetText(BG.ReceiveBiaoGe["boss" .. b]["maijia" .. i] or "")
                    buyer:SetCursorPosition(0)
                    if BG.ReceiveBiaoGe["boss" .. b]["color" .. i] then
                        buyer:SetTextColor(unpack(BG.ReceiveBiaoGe["boss" .. b]["color" .. i]))
                    end
                    money:SetText(BG.ReceiveBiaoGe["boss" .. b]["jine" .. i] or "")
                    if BG.Frame[FB]["boss" .. b]["time"] then
                        local t = BG.ReceiveBiaoGe["boss" .. b]["time"]
                        if t then
                            BG.Frame[FB]["boss" .. b]["time"]:SetText(L["击杀用时"] .. " " .. t)
                            BiaoGe[FB]["boss" .. b]["time"] = t
                        end
                    end
                end, nil, true, FB)
                BG.ReceiveMainFrame:Hide()
                BG.MainFrame:Show()
                BG.ClickTabButton(BG.FBMainFrameTabNum)
                BG.ClickFBbutton(FB)
                BG.PlaySound(2)
            end
            StaticPopup_Show("BiaoGe_YingYongReceiveBiaoGe")
        end)

        local bt = BG.CreateButton(BG.ReceiveMainFrame)
        bt:SetSize(120, 25)
        bt:SetPoint("BOTTOMLEFT", BG.ReceiveMainFrame, "BOTTOM", 10, 20)
        bt:SetText(L["保存至历史表格"])
        bt:SetScript("OnClick", function(self)
            local FB = BG.ReceiveBiaoGe.FB
            local DT = BG.ReceiveBiaoGe.DT
            local BiaoTi = BG.ReceiveBiaoGe.BiaoTi
            for key, value in pairs(BiaoGe.History[FB]) do
                if tonumber(DT) == key then
                    BG.ReceiveMainFrametext:SetText(BG.STC_r1(L["该表格已在你历史表格里"]) .. AddTexture("interface/raidframe/readycheck-notready"))
                    return
                end
            end

            BiaoGe.History[FB][DT] = {}
            for b = 1, Maxb[FB] + 2 do
                BiaoGe.History[FB][DT]["boss" .. b] = {}
                for i = 1, BG.GetMaxi(FB, b) do
                    if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                        BiaoGe.History[FB][DT]["boss" .. b]["zhuangbei" .. i] = BG.ReceiveBiaoGe["boss" .. b]
                            ["zhuangbei" .. i]
                        BiaoGe.History[FB][DT]["boss" .. b]["maijia" .. i] = BG.ReceiveBiaoGe["boss" .. b]["maijia" .. i]
                        BiaoGe.History[FB][DT]["boss" .. b]["color" .. i] = { BG.ReceiveBiaoGe["boss" .. b]["color" .. i]
                            [1], BG.ReceiveBiaoGe["boss" .. b]["color" .. i][2],
                            BG.ReceiveBiaoGe["boss" .. b]["color" .. i][3] }
                        BiaoGe.History[FB][DT]["boss" .. b]["jine" .. i] = BG.ReceiveBiaoGe["boss" .. b]["jine" .. i]
                    end
                end
                if BG.Frame[FB]["boss" .. b]["time"] then
                    BiaoGe.History[FB][DT]["boss" .. b]["time"] = BG.ReceiveBiaoGe["boss" .. b]["time"]
                end
            end
            local d = { DT, BiaoTi }
            table.insert(BiaoGe.HistoryList[FB], 1, d)
            BG.UpdateHistoryButton()
            BG.CreatHistoryListButton(FB)
            BG.ReceiveMainFrametext:SetText(L["已保存至历史表格1"] .. AddTexture("interface/raidframe/readycheck-ready"))

            BG.PlaySound(2)
        end)

        local text = BG.ReceiveMainFrame:CreateFontString()
        text:SetPoint("LEFT", bt, "RIGHT", 10, 0)
        text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        text:SetTextColor(0, 1, 0)
        BG.ReceiveMainFrametext = text

        -- 二级
        for i, FB in ipairs(BG.FBtable) do
            BG["ReceiveFrame" .. FB] = CreateFrame("Frame", "BG.ReceiveFrame" .. FB, BG.ReceiveMainFrame)
            BG["ReceiveFrame" .. FB]:Hide()
        end
    end
    ------------------把分享表格文字转换为链接------------------
    do
        local function ChangSendLink(self, event, msg, player, l, cs, t, flag, channelId, ...)
            if not strfind(msg, "^%[BiaoGe:.*%]$") then return end
            msg = strtrim(msg, "[]")
            local _, text = strsplit(":", msg, 2)
            if text then
                local newmsg = "|cff00BFFF|Hgarrmission:" .. msg .. "|h[" .. text .. "]|h|r"
                if newmsg then
                    return false, newmsg, player, l, cs, t, flag, channelId, ...
                end
            end
        end

        ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", ChangSendLink)
        ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", ChangSendLink)

        local cd = {}
        hooksecurefunc("SetItemRef", function(link)
            local _, biaoge, text = strsplit(":", link, 3)
            if not (biaoge == "BiaoGe" and text) then return end
            local player, server, type, FB, historyname = strsplit("-", text)
            local yes
            for key, _FB in pairs(BG.FBtable) do
                if FB == _FB then
                    yes = true
                    break
                end
            end
            if not yes then return end
            if IsShiftKeyDown() then
                local text = "[" .. biaoge .. ":" .. player .. "-" .. server .. "-" .. type .. "-" .. FB
                if historyname then
                    text = text .. "-" .. historyname .. "]"
                else
                    text = text .. "]"
                end
                BG.InsertLink(text)
            else
                if BG.SetCD(cd, 5) then return end
                BG.ReceiveMainFrame:Hide()
                for b = 1, Maxb[FB] + 2 do
                    for i = 1, BG.GetMaxi(FB, b) do
                        if BG.ReceiveFrame[FB]["boss" .. b]["zhuangbei" .. i] then
                            BG.ReceiveFrame[FB]["boss" .. b]["zhuangbei" .. i]:SetText("")
                            BG.ReceiveFrame[FB]["boss" .. b]["maijia" .. i]:SetText("")
                            BG.ReceiveFrame[FB]["boss" .. b]["maijia" .. i]:SetTextColor(1, 1, 1)
                            BG.ReceiveFrame[FB]["boss" .. b]["jine" .. i]:SetText("")
                        end
                    end
                    if BG.ReceiveFrame[FB]["boss" .. b]["time"] then
                        BG.ReceiveFrame[FB]["boss" .. b]["time"]:SetText("")
                    end
                end

                BG.ReceiveBiaoGe = {}
                for b = 1, Maxb[FB] + 2 do
                    BG.ReceiveBiaoGe["boss" .. b] = {}
                    for i = 1, BG.GetMaxi(FB, b) do
                        if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                            BG.ReceiveBiaoGe["boss" .. b]["zhuangbei" .. i] = ""
                            BG.ReceiveBiaoGe["boss" .. b]["maijia" .. i] = ""
                            BG.ReceiveBiaoGe["boss" .. b]["color" .. i] = { 1, 1, 1 }
                            BG.ReceiveBiaoGe["boss" .. b]["jine" .. i] = ""
                        end
                    end
                end

                if not historyname then
                    historyname = ""
                end
                text = type .. "-" .. FB .. "-" .. historyname

                local fullName = player .. "-" .. server
                ChatThrottleLib:SendAddonMessage("NORMAL", "BiaoGe", text, "WHISPER", fullName)
                BG.SendSystemMessage(format(L["已向%s发送请求。"], SetClassCFF(fullName)))
            end
        end)
    end
    ------------------发送表格数据------------------
    do
        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_ADDON")
        f:SetScript("OnEvent", function(self, event, ...)
            if not BG.canSendBiaoGe then return end
            local prefix, msg, distType, sender = ...
            if prefix ~= "BiaoGe" then return end
            local type, FB, historyname = strsplit("-", msg)
            local yes
            for key, _FB in pairs(BG.FBtable) do
                if FB == _FB then
                    yes = true
                    break
                end
            end
            if not yes then return end

            BG.SendBiaoGe = {}
            BG.SendBiaoGe.FB = FB

            if BG.FindTableString(type, dangqianTbl) then
                local DT = tonumber(date("%y%m%d%H%M%S", GetServerTime()))
                local DTcn = date(L["%m月%d日%H:%M:%S\n"], GetServerTime())
                local biaoti = format(L["%s%s %s人 工资:%s"], DTcn, BG.GetFBinfo(FB, "shortName"),
                    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. 4]:GetText(),
                    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. 5]:GetText())
                BG.SendBiaoGe.DT = DT
                BG.SendBiaoGe.BiaoTi = biaoti

                for b = 1, Maxb[FB] + 2 do
                    BG.SendBiaoGe["boss" .. b] = {}
                    for i = 1, BG.GetMaxi(FB, b) do
                        if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                            BG.SendBiaoGe["boss" .. b]["zhuangbei" .. i] = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText()
                            BG.SendBiaoGe["boss" .. b]["maijia" .. i] = BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetText()
                            local c1, c2, c3 = BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetTextColor()
                            c1 = string.format("%.3f", c1)
                            c2 = string.format("%.3f", c2)
                            c3 = string.format("%.3f", c3)
                            BG.SendBiaoGe["boss" .. b]["color" .. i] = { c1, c2, c3 }
                            BG.SendBiaoGe["boss" .. b]["jine" .. i] = BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText()
                        end
                    end
                    if BiaoGe[FB]["boss" .. b]["time"] then
                        BG.SendBiaoGe["boss" .. b]["time"] = BiaoGe[FB]["boss" .. b]["time"]
                    end
                end
            elseif BG.FindTableString(type, historyTbl) and historyname then
                local DT
                for key, value in pairs(BiaoGe.HistoryList[FB]) do
                    local t = string.gsub(BiaoGe.HistoryList[FB][key][2], "\n", "")
                    if historyname == t then
                        DT = tonumber(BiaoGe.HistoryList[FB][key][1])
                        BG.SendBiaoGe.DT = DT
                        BG.SendBiaoGe.BiaoTi = BiaoGe.HistoryList[FB][key][2]
                        break
                    end
                end
                if not BG.SendBiaoGe.DT then return end

                for b = 1, Maxb[FB] + 2 do
                    BG.SendBiaoGe["boss" .. b] = {}
                    for i = 1, BG.GetMaxi(FB, b) do
                        if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                            BG.SendBiaoGe["boss" .. b]["zhuangbei" .. i] = BiaoGe.History[FB][DT]["boss" .. b]["zhuangbei" .. i]
                            BG.SendBiaoGe["boss" .. b]["maijia" .. i] = BiaoGe.History[FB][DT]["boss" .. b]["maijia" .. i]
                            local c1, c2, c3 = 1, 1, 1
                            if BiaoGe.History[FB][DT]["boss" .. b]["color" .. i] then
                                c1, c2, c3 = BiaoGe.History[FB][DT]["boss" .. b]["color" .. i][1], BiaoGe.History[FB][DT]["boss" .. b]["color" .. i][2], BiaoGe.History[FB][DT]["boss" .. b]["color" .. i][3]
                            end
                            c1 = string.format("%.3f", c1)
                            c2 = string.format("%.3f", c2)
                            c3 = string.format("%.3f", c3)
                            BG.SendBiaoGe["boss" .. b]["color" .. i] = { c1, c2, c3 }
                            BG.SendBiaoGe["boss" .. b]["jine" .. i] = BiaoGe.History[FB][DT]["boss" .. b]["jine" .. i]
                        end
                    end
                    if BiaoGe.History[FB][DT]["boss" .. b]["time"] then
                        BG.SendBiaoGe["boss" .. b]["time"] = BiaoGe.History[FB][DT]["boss" .. b]["time"]
                    end
                end
            end

            local text = "BG-" .. "FB:" .. BG.SendBiaoGe.FB .. "-" .. "DT:" .. BG.SendBiaoGe.DT .. "-" .. "BiaoTi:" .. BG.SendBiaoGe.BiaoTi -- BG-FB:ULD-DT:230420182045-BiaoTi:04年4月20日18:20:45\n 奥杜尔 风行
            ChatThrottleLib:SendAddonMessage("NORMAL", "BiaoGe", text, "WHISPER", sender)

            local text = "BG"
            for b = 1, Maxb[FB] + 2 do
                for i = 1, BG.GetMaxi(FB, b) do
                    if BG.SendBiaoGe["boss" .. b]["zhuangbei" .. i] then
                        if BG.SendBiaoGe["boss" .. b]["zhuangbei" .. i] ~= "" then
                            local t = { text, "-", "b", b, "zb", i, ":", BG.SendBiaoGe["boss" .. b]["zhuangbei" .. i] }
                            local tt = table.concat(t, "") -- BG-b1zb1:[某装备]
                            if strlen(tt) >= 255 then
                                ChatThrottleLib:SendAddonMessage("NORMAL", "BiaoGe", text, "WHISPER", sender)
                                t = { "BG-", "b", b, "zb", i, ":", BG.SendBiaoGe["boss" .. b]["zhuangbei" .. i] }
                                text = table.concat(t, "")
                            else
                                text = tt
                            end
                        end
                        if BG.SendBiaoGe["boss" .. b]["maijia" .. i] ~= "" then
                            local t = { text, "-", "b", b, "mj", i, ":", BG.SendBiaoGe["boss" .. b]["maijia" .. i] }
                            local tt = table.concat(t, "") -- BG-b1zb1:[某装备]-b1mj1:某买家
                            if strlen(tt) >= 255 then
                                ChatThrottleLib:SendAddonMessage("NORMAL", "BiaoGe", text, "WHISPER", sender)
                                t = { "BG-", "b", b, "mj", i, ":", BG.SendBiaoGe["boss" .. b]["maijia" .. i] }
                                text = table.concat(t, "")
                            else
                                text = tt
                            end

                            local t = { text, "-", "b", b, "c", i, ":", BG.SendBiaoGe["boss" .. b]["color" .. i][1] .. "," .. BG.SendBiaoGe["boss" .. b]["color" .. i][2] .. "," .. BG.SendBiaoGe["boss" .. b]["color" .. i][3] }
                            local tt = table.concat(t, "") -- BG-b1zb1:[某装备]-b1mj1:某买家-b1c1:1,1,1
                            if strlen(tt) >= 255 then
                                ChatThrottleLib:SendAddonMessage("NORMAL", "BiaoGe", text, "WHISPER", sender)
                                t = { "BG-", "b", b, "c", i, ":", BG.SendBiaoGe["boss" .. b]["color" .. i][1] .. "," .. BG.SendBiaoGe["boss" .. b]["color" .. i][2] .. "," .. BG.SendBiaoGe["boss" .. b]["color" .. i][3] }
                                text = table.concat(t, "")
                            else
                                text = tt
                            end
                        end
                        if BG.SendBiaoGe["boss" .. b]["jine" .. i] ~= "" then
                            local t = { text, "-", "b", b, "je", i, ":", BG.SendBiaoGe["boss" .. b]["jine" .. i] }
                            local tt = table.concat(t, "") -- BG-b1zb1:[某装备]-b1mj1:某买家-b1c1:1,1,1-b1je1:2000
                            if strlen(tt) >= 255 then
                                ChatThrottleLib:SendAddonMessage("NORMAL", "BiaoGe", text, "WHISPER", sender)
                                t = { "BG-", "b", b, "je", i, ":", BG.SendBiaoGe["boss" .. b]["jine" .. i] }
                                text = table.concat(t, "")
                            else
                                text = tt
                            end
                        end
                    end
                end
                if BG.SendBiaoGe["boss" .. b]["time"] then
                    local t = { text, "-", "b", b, "tm", ":", BG.SendBiaoGe["boss" .. b]["time"] }
                    local tt = table.concat(t, "") -- BG-b1tm:2分10秒
                    if strlen(tt) >= 255 then
                        ChatThrottleLib:SendAddonMessage("NORMAL", "BiaoGe", text, "WHISPER", sender)
                        t = { "BG-", "b", b, "tm", ":", BG.SendBiaoGe["boss" .. b]["time"] }
                        text = table.concat(t, "")
                    else
                        text = tt
                    end
                end
            end
            if text ~= "" then
                ChatThrottleLib:SendAddonMessage("NORMAL", "BiaoGe", text, "WHISPER", sender)
            end
            text = "BG-END"
            ChatThrottleLib:SendAddonMessage("NORMAL", "BiaoGe", text, "WHISPER", sender)
        end)
    end
    ------------------接收表格数据------------------
    do
        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_ADDON")
        f:SetScript("OnEvent", function(self, event, ...)
            local prefix, msg, distType, sender = ...
            if prefix ~= "BiaoGe" then return end
            local Receive = { strsplit("-", msg) }
            if Receive[1] ~= "BG" then return end
            for index, value in ipairs(Receive) do
                local type, neirong = strsplit(":", value, 2)
                if type == "FB" then
                    BG.ReceiveBiaoGe.FB = neirong
                    BG.SendSystemMessage(format(L["正在接收%s的表格数据。"], SetClassCFF(sender)))
                end
                if type == "DT" then
                    BG.ReceiveBiaoGe.DT = tonumber(neirong)
                end
                if type == "BiaoTi" then
                    BG.ReceiveBiaoGe.BiaoTi = neirong
                end
                if strfind(type, "b%d+zb%d+") then
                    local b = strmatch(type, "%d+")
                    local z = strfind(type, "zb")
                    local i = strmatch(type, "%d+", z)
                    BG.ReceiveBiaoGe["boss" .. b]["zhuangbei" .. i] = neirong
                end
                if strfind(type, "b%d+mj%d+") then
                    local b = strmatch(type, "%d+")
                    local z = strfind(type, "mj")
                    local i = strmatch(type, "%d+", z)
                    BG.ReceiveBiaoGe["boss" .. b]["maijia" .. i] = neirong
                end
                if strfind(type, "b%d+c%d+") then
                    local b = strmatch(type, "%d+")
                    local z = strfind(type, "c")
                    local i = strmatch(type, "%d+", z)
                    local c1, c2, c3 = strsplit(",", neirong)
                    BG.ReceiveBiaoGe["boss" .. b]["color" .. i] = { c1, c2, c3 }
                end
                if strfind(type, "b%d+je%d+") then
                    local b = strmatch(type, "%d+")
                    local z = strfind(type, "je")
                    local i = strmatch(type, "%d+", z)
                    BG.ReceiveBiaoGe["boss" .. b]["jine" .. i] = neirong
                end
                if strfind(type, "b%d+tm") then
                    local b = strmatch(type, "%d+")
                    BG.ReceiveBiaoGe["boss" .. b]["time"] = neirong
                end
                if type == "END" then
                    local FB = BG.ReceiveBiaoGe.FB
                    local DT = BG.ReceiveBiaoGe.DT
                    local BiaoTi = BG.ReceiveBiaoGe.BiaoTi
                    if FB and BiaoTi then
                        BG.CreateFBUI(FB, "Receive")

                        for b = 1, Maxb[FB] + 2 do
                            for i = 1, BG.GetMaxi(FB, b) do
                                if BG.ReceiveFrame[FB]["boss" .. b]["zhuangbei" .. i] then
                                    BG.ReceiveFrame[FB]["boss" .. b]["zhuangbei" .. i]:SetText(BG.ReceiveBiaoGe["boss" .. b]["zhuangbei" .. i] or "")
                                    BG.ReceiveFrame[FB]["boss" .. b]["maijia" .. i]:SetText(BG.ReceiveBiaoGe["boss" .. b]["maijia" .. i] or "")
                                    BG.ReceiveFrame[FB]["boss" .. b]["maijia" .. i]:SetCursorPosition(0)
                                    if BG.ReceiveBiaoGe["boss" .. b]["color" .. i] then
                                        BG.ReceiveFrame[FB]["boss" .. b]["maijia" .. i]:SetTextColor(BG.ReceiveBiaoGe["boss" .. b]["color" .. i][1], BG.ReceiveBiaoGe["boss" .. b]["color" .. i][2], BG.ReceiveBiaoGe["boss" .. b]["color" .. i][3])
                                    end
                                    BG.ReceiveFrame[FB]["boss" .. b]["jine" .. i]:SetText(BG.ReceiveBiaoGe["boss" .. b]["jine" .. i] or "")
                                end
                            end
                            if BG.ReceiveBiaoGe["boss" .. b]["time"] then
                                BG.ReceiveFrame[FB]["boss" .. b]["time"]:SetText(L["击杀用时"] .. " " .. BG.ReceiveBiaoGe["boss" .. b]["time"])
                            end
                        end

                        BG.MainFrame:Hide()
                        BG.ReceiveMainFrame:SetWidth(BG.FBWidth[FB])
                        BG.ReceiveMainFrame:SetHeight(BG.FBHeight[FB] - 20)
                        BG.ReceiveMainFrame:Show()

                        for i, FB in ipairs(BG.FBtable) do
                            BG["ReceiveFrame" .. FB]:Hide()
                        end
                        BG["ReceiveFrame" .. FB]:Show()

                        BG.ReceiveMainFrameTitle:SetText(BiaoTi)
                        BG.ReceiveMainFrametext:SetText("")
                        BG.SendSystemMessage(format(L["已成功接收%s的表格。"], SetClassCFF(sender)))
                    end
                end
            end
        end)
    end
end

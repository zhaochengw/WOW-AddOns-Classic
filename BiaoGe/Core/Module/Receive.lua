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
local Width = ADDONSELF.Width
local Height = ADDONSELF.Height
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi
local FrameHide = ADDONSELF.FrameHide


local pt = print

local dangqianTbl = { "当前表格", "當前表格" }
local historyTbl = { "历史表格", "歷史表格" }

function BG.ReceiveUI()
    ------------------把分享表格文字转换为链接------------------
    do
        local function ChangSendLink(self, even, msg, player, l, cs, t, flag, channelId, ...)
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

        hooksecurefunc("SetItemRef", function(link)
            local _, biaoge, text = strsplit(":", link, 3)
            if not (biaoge == "BiaoGe" and text) then return end
            local playername, servername, type, FB, historyname = strsplit("-", text)
            -- if playername == UnitName("player") then return end
            local yes
            for key, _FB in pairs(BG.FBtable) do
                if FB == _FB then
                    yes = true
                    break
                end
            end
            if not yes then return end
            BG.ReceiveMainFrame:Hide()
            for b = 1, Maxb[FB] + 2 do
                for i = 1, Maxi[FB] do
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
                for i = 1, Maxi[FB] do
                    if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                        BG.ReceiveBiaoGe["boss" .. b]["zhuangbei" .. i] = ""
                        BG.ReceiveBiaoGe["boss" .. b]["maijia" .. i] = ""
                        BG.ReceiveBiaoGe["boss" .. b]["color" .. i] = { 1, 1, 1 }
                        BG.ReceiveBiaoGe["boss" .. b]["jine" .. i] = ""
                    end
                end
                if BG.Frame[FB]["boss" .. b]["time"] then
                    BG.ReceiveBiaoGe["boss" .. b]["time"] = ""
                end
            end

            playername = playername .. "-" .. servername
            if not historyname then
                historyname = ""
            end
            text = type .. "-" .. FB .. "-" .. historyname

            C_ChatInfo.SendAddonMessage("BiaoGe", text, "WHISPER", playername)
        end)
    end
    ------------------发送表格数据------------------
    do
        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_ADDON")
        f:SetScript("OnEvent", function(self, even, ...)
            if not BG.canSendBiaoGe then return end

            local prefix, msg, distType, sender = ...
            if prefix ~= "BiaoGe" then return end
            local sendername = strsplit("-", sender)
            local playername = UnitName("player")
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
                local DT = tonumber(date("%y%m%d%H%M%S"))
                local DTcn = date(L["%m月%d日%H:%M:%S\n"])
                local biaoti = format(L["%s%s %s人 工资:%s"], DTcn, BG.GetFBinfo(FB, "localName"),
                    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. 4]:GetText(),
                    BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. 5]:GetText())
                BG.SendBiaoGe.DT = DT
                BG.SendBiaoGe.BiaoTi = biaoti

                for b = 1, Maxb[FB] + 2 do
                    BG.SendBiaoGe["boss" .. b] = {}
                    for i = 1, Maxi[FB] do
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
                    if BG.Frame[FB]["boss" .. b]["time"] then
                        BG.SendBiaoGe["boss" .. b]["time"] = BG.Frame[FB]["boss" .. b]["time"]:GetText()
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
                    for i = 1, Maxi[FB] do
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
            C_ChatInfo.SendAddonMessage("BiaoGe", text, "WHISPER", sender)

            local text = "BG"
            for b = 1, Maxb[FB] + 2 do
                for i = 1, Maxi[FB] do
                    if BG.SendBiaoGe["boss" .. b]["zhuangbei" .. i] then
                        if BG.SendBiaoGe["boss" .. b]["zhuangbei" .. i] ~= "" then
                            local t = { text, "-", "b", b, "zb", i, ":", BG.SendBiaoGe["boss" .. b]["zhuangbei" .. i] }
                            local tt = table.concat(t, "") -- BG-b1zb1:[某装备]
                            if strlen(tt) >= 255 then
                                C_ChatInfo.SendAddonMessage("BiaoGe", text, "WHISPER", sender)
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
                                C_ChatInfo.SendAddonMessage("BiaoGe", text, "WHISPER", sender)
                                t = { "BG-", "b", b, "mj", i, ":", BG.SendBiaoGe["boss" .. b]["maijia" .. i] }
                                text = table.concat(t, "")
                            else
                                text = tt
                            end

                            local t = { text, "-", "b", b, "c", i, ":", BG.SendBiaoGe["boss" .. b]["color" .. i][1] .. "," .. BG.SendBiaoGe["boss" .. b]["color" .. i][2] .. "," .. BG.SendBiaoGe["boss" .. b]["color" .. i][3] }
                            local tt = table.concat(t, "") -- BG-b1zb1:[某装备]-b1mj1:某买家-b1c1:1,1,1
                            if strlen(tt) >= 255 then
                                C_ChatInfo.SendAddonMessage("BiaoGe", text, "WHISPER", sender)
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
                                C_ChatInfo.SendAddonMessage("BiaoGe", text, "WHISPER", sender)
                                t = { "BG-", "b", b, "je", i, ":", BG.SendBiaoGe["boss" .. b]["jine" .. i] }
                                text = table.concat(t, "")
                            else
                                text = tt
                            end
                        end
                    end
                end
                if BG.SendBiaoGe["boss" .. b]["time"] ~= "" then
                    local t = { text, "-", "b", b, "tm", ":", BG.SendBiaoGe["boss" .. b]["time"] }
                    local tt = table.concat(t, "") -- BG-b1tm:2分10秒
                    if strlen(tt) >= 255 then
                        C_ChatInfo.SendAddonMessage("BiaoGe", text, "WHISPER", sender)
                        t = { "BG-", "b", b, "tm", ":", BG.SendBiaoGe["boss" .. b]["time"] }
                        text = table.concat(t, "")
                    else
                        text = tt
                    end
                end
            end
            if text ~= "" then
                C_ChatInfo.SendAddonMessage("BiaoGe", text, "WHISPER", sender)
            end
            text = "BG-END"
            C_ChatInfo.SendAddonMessage("BiaoGe", text, "WHISPER", sender)
        end)
    end
    ------------------接收表格数据------------------
    do
        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_ADDON")
        f:SetScript("OnEvent", function(self, even, ...)
            local prefix, msg, distType, sender = ...
            if prefix ~= "BiaoGe" then return end
            local sendername = strsplit("-", sender)
            local playername = UnitName("player")
            local Receive = { strsplit("-", msg) }
            if Receive[1] ~= "BG" then return end
            for index, value in ipairs(Receive) do
                local type, neirong = strsplit(":", value, 2)
                if type == "FB" then
                    BG.ReceiveBiaoGe.FB = neirong
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

                    for b = 1, Maxb[FB] + 2 do
                        for i = 1, Maxi[FB] do
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
                        if BG.ReceiveFrame[FB]["boss" .. b]["time"] then
                            BG.ReceiveFrame[FB]["boss" .. b]["time"]:SetText(BG.ReceiveBiaoGe["boss" .. b]["time"] or "")
                        end
                    end

                    BG.MainFrame:Hide()
                    BG.ReceiveMainFrame:SetWidth(Width[FB])
                    BG.ReceiveMainFrame:SetHeight(Height[FB] - 20)
                    BG.ReceiveMainFrame:Show()

                    for i, FB in ipairs(BG.FBtable) do
                        BG["ReceiveFrame" .. FB]:Hide()
                    end
                    BG["ReceiveFrame" .. FB]:Show()

                    BG.ReceiveMainFrameTitle:SetText(BiaoTi)
                    BG.ReceiveMainFrametext:SetText("")
                end
            end
        end)
    end
end

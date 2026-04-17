local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local SetClassCFF = ns.SetClassCFF
local RGB_16 = ns.RGB_16

local Maxb = ns.Maxb
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print
BG.tongBaoSendCD = 0.3
BG.TongBaoButtons = {}
local step = 2
local updateFrame = CreateFrame("Frame")
updateFrame.errorCount = 0
updateFrame:SetScript("OnEvent", function(self, event, msg)
    if event == "CHAT_MSG_SYSTEM" and msg == ERR_CHAT_THROTTLED then
        self.errorCount = self.errorCount + 1
        if self.errorCount >= 5 then
            self:SetScript("OnUpdate", nil)
            self:UnregisterEvent("CHAT_MSG_SYSTEM")
            BG.SendSystemMessage(L["|cffff0000由于服务器聊天限流，通报已被停止。"])
            if self.callback then
                self.callback()
                self.callback = nil
            end
        end
    end
end)

function BG.SendMsgToRaid(tbl, dalay, callback)
    if updateFrame.callback then
        updateFrame.callback()
        updateFrame.callback = nil
    end
    dalay = dalay or 0
    local channel = BiaoGe.NotifyChannel
    local db = {}
    for _, texts in ipairs(tbl) do
        for i = 1, #texts, step do
            local one = {}
            for ii = i, i + step - 1 do
                if not texts[ii] then break end
                tinsert(one, texts[ii])
            end
            tinsert(db, one)
        end
    end
    BG.After(dalay, function()
        local index = 1
        updateFrame.t = BG.tongBaoSendCD
        updateFrame.callback = callback
        updateFrame:SetScript("OnUpdate", function(self, t)
            if not db[index] then
                self:SetScript("OnUpdate", nil)
                if self.callback then
                    self.callback()
                    self.callback = nil
                end
                return
            end
            self.t = self.t + t
            if self.t >= BG.tongBaoSendCD then
                self.t = 0
                for _, msg in ipairs(db[index]) do
                    SendChatMessage(msg, channel)
                end
                index = index + 1
            end
        end)
        updateFrame.errorCount = 0
        updateFrame:RegisterEvent("CHAT_MSG_SYSTEM")
    end)
end

function BG.IsErrorSendChannel()
    local channel = BiaoGe.NotifyChannel
    if channel == "RAID" and not IsInRaid(1) then
        BG.SendSystemMessage(L["不在团队，无法通报。"])
        BG.PlaySound(1)
        return true
    end
    if channel == "GUILD" and not IsInGuild() then
        BG.SendSystemMessage(L["没有公会，无法通报。"])
        BG.PlaySound(1)
        return true
    end
    if (channel == "SAY" or channel == "YELL") and not IsInInstance() then
        BG.SendSystemMessage(L["该频道需在副本内才能通报。"])
        BG.PlaySound(1)
        return true
    end
end

-- 总览和工资
local function ZongLan(onClick, tbl1, tbl2)
    local FB = BG.FB1
    local tbl1 = tbl1 or {}
    local tbl2 = tbl2 or {}
    local text
    if onClick then
        text = format(L["< 总 %s 览 >"], BG.SetRaidTargetingIcons(onClick, "ziling"))
    else
        text = "|cffffffff" .. format(L["< 总 %s 览 >"], BG.SetRaidTargetingIcons(onClick, "ziling")) .. RN
    end
    table.insert(tbl1, text)
    table.insert(tbl2, { text })

    local b = Maxb[FB] + 2
    local sum
    for i = 1, 3, 1 do
        if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
            local text
            local item = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText()
            local money = BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText()
            local moneyNum = tonumber(money) or 0
            local perText = ""
            if i == 1 then
                sum = moneyNum
            elseif i == 2 and sum and sum ~= 0 then
                perText = L["（占比%s%%）"]:format(format("%.0f", moneyNum / sum * 100))
            end
            if onClick then
                text = item .. L["："] .. money .. perText
            else
                text = "|cffEE82EE" .. item .. L["："] .. money .. perText .. RN
            end
            table.insert(tbl1, text)
            table.insert(tbl2, { text })
        end
    end

    local text
    if onClick then
        text = format(L["< 工 %s 资 >"], BG.SetRaidTargetingIcons(onClick, "fangkuai"))
    else
        text = "|cffffffff" .. format(L["< 工 %s 资 >"], BG.SetRaidTargetingIcons(onClick, "fangkuai")) .. RN
    end
    table.insert(tbl1, text)
    table.insert(tbl2, { text })


    local text
    if onClick then
        text = BG.Frame[FB]["boss" .. b]["zhuangbei4"]:GetText() .. L["："] ..
            BG.Frame[FB]["boss" .. b]["jine4"]:GetText() .. L["人"]
    else
        text = "|cff00BFFF" .. BG.Frame[FB]["boss" .. b]["zhuangbei4"]:GetText() .. L["："] ..
            BG.Frame[FB]["boss" .. b]["jine4"]:GetText() .. L["人"] .. RN
    end
    table.insert(tbl1, text)
    table.insert(tbl2, { text })


    local text
    if onClick then
        text = BG.Frame[FB]["boss" .. b]["zhuangbei5"]:GetText() .. L["："] ..
            BG.Frame[FB]["boss" .. b]["jine5"]:GetText()
    else
        text = "|cff00BFFF" .. BG.Frame[FB]["boss" .. b]["zhuangbei5"]:GetText() .. L["："] ..
            BG.Frame[FB]["boss" .. b]["jine5"]:GetText() .. RN
    end
    table.insert(tbl1, text)
    table.insert(tbl2, { text })

    local text
    if onClick then
        text = BG.Frame[FB]["boss" .. b]["jine5"]:GetText() .. " x 5 = " ..
            (tonumber(BG.Frame[FB]["boss" .. b]["jine5"]:GetText()) * 5)
    else
        text = "|cff00BFFF" .. BG.Frame[FB]["boss" .. b]["jine5"]:GetText() .. " x 5 = " ..
            (tonumber(BG.Frame[FB]["boss" .. b]["jine5"]:GetText()) * 5) .. RN
    end
    table.insert(tbl1, text)
    table.insert(tbl2, { text })

    return tbl1, tbl2
end

local function GetFaKuanSumMoney()
    local sum = 0
    BG.PairFBItem(function(item, buyer, money, b, i)
        sum = sum + (tonumber(money:GetText()) or 0)
    end, Maxb[BG.FB1])
    return sum
end

local function FaKuan(onClick, tbl1, tbl2)
    local FB = BG.FB1
    local tbl1 = tbl1 or {}
    local tbl2 = tbl2 or {}
    local num = 1
    local yes
    local tbl_boss = {}
    local b = Maxb[FB]
    for i = 1, BG.GetMaxi(FB, b) do
        local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
        local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
        local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
        if zhuangbei then
            if tonumber(jine:GetText()) and tonumber(jine:GetText()) ~= 0 then
                local text
                local fakuan = zhuangbei:GetText()
                if fakuan == "" then
                    fakuan = L["罚款"]
                end
                if onClick then
                    text = fakuan .. " " .. maijia:GetText() .. " " ..
                        jine:GetText()
                else
                    text = num .. ". " .. fakuan .. " " ..
                        RGB_16(maijia:GetText(), unpack({ maijia:GetTextColor() })) .. " " ..
                        jine:GetText()
                end
                table.insert(tbl1, text)
                table.insert(tbl_boss, text)
                num = num + 1
                yes = true
            end
        end
    end
    if #tbl_boss ~= 0 then
        local tbl = {}
        for i, v in ipairs(tbl_boss) do
            tbl[i] = v
        end
        table.insert(tbl2, tbl)
        local sumText = format(L["罚款合计：%s"], GetFaKuanSumMoney())
        table.insert(tbl1, sumText)
        table.insert(tbl2, { sumText })
    end
    if not yes then
        local text = L["没有罚款"]
        table.insert(tbl1, text)
        table.insert(tbl2, { text })
    end
    return tbl1, tbl2
end

local function ZhiChu(onClick, tbl1, tbl2)
    local FB = BG.FB1
    local tbl1 = tbl1 or {}
    local tbl2 = tbl2 or {}
    local num = 1
    local yes
    local tbl_boss = {}
    local b = Maxb[FB] + 1
    for i = 1, BG.GetMaxi(FB, b) do
        local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
        local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
        if zhuangbei then
            if tonumber(jine:GetText()) and tonumber(jine:GetText()) ~= 0 then
                local text
                if onClick then
                    text = zhuangbei:GetText() .. " " .. jine:GetText()
                else
                    text = num .. ". " .. "|cff00FF00" .. zhuangbei:GetText() .. " " .. jine:GetText() .. "|r"
                end
                table.insert(tbl1, text)
                table.insert(tbl_boss, text)
                num = num + 1
                yes = true
            end
        end
    end
    if #tbl_boss ~= 0 then
        local tbl = {}
        for i, v in ipairs(tbl_boss) do
            tbl[i] = v
        end
        table.insert(tbl2, tbl)
    end
    if not yes then
        local text = L["没有支出"]
        table.insert(tbl1, text)
        table.insert(tbl2, { text })
    end
    return tbl1, tbl2
end

local function HasQianKuan()
    local FB = BG.FB1
    for b = 1, Maxb[FB] do
        for i = 1, BG.GetMaxi(FB, b) do
            local bt = BG.Frame[FB]["boss" .. b]["qiankuan" .. i]
            if BG.Frame[FB]["boss" .. b]["qiankuan" .. i] and BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
                return true
            end
        end
    end
end

local function CreateListTable(onClick, tbl1)
    local FB = BG.FB1
    local tbl1 = tbl1 or {}
    local tbl2 = {}
    -- 收入
    do
        local text
        if onClick then
            text = format(L["< 收 %s 入 >"], BG.SetRaidTargetingIcons(onClick, "xingxing"))
        else
            text = "|cffffffff" .. format(L["< 收 %s 入 >"], BG.SetRaidTargetingIcons(onClick, "xingxing")) .. RN
        end
        table.insert(tbl1, text)
        table.insert(tbl2, { text })
        local yes
        for b = 1, Maxb[FB] do
            local tbl_boss = {}
            for i = 1, BG.GetMaxi(FB, b) do
                local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
                if zhuangbei then
                    if (tonumber(jine:GetText()) and tonumber(jine:GetText()) ~= 0)
                        or (zhuangbei:GetText() ~= "" and (maijia:GetText() ~= "" or jine:GetText() ~= "")) then
                        local text
                        local jineText = jine:GetText()
                        if jineText:gsub(" ", "") == "" then
                            jineText = 0
                        end
                        local maijiaText = maijia:GetText()
                        local _r, _g, _b = maijia:GetTextColor()
                        if maijiaText:gsub(" ", "") == "" or tonumber(maijiaText) then
                            maijiaText = L["未知买家"]
                            _r, _g, _b = .5, .5, .5
                        end
                        local zhuangbeiText = zhuangbei:GetText()
                        if zhuangbeiText:gsub(" ", "") == "" then
                            if b == Maxb[FB] then
                                zhuangbeiText = L["罚款"]
                            else
                                zhuangbeiText = L["未知装备"]
                            end
                        end
                        if onClick then
                            text = zhuangbeiText .. " " .. maijiaText .. " " .. jineText
                        else
                            text = zhuangbeiText .. " " .. RGB_16(maijiaText, _r, _g, _b) .. " " .. jineText
                        end
                        table.insert(tbl_boss, text)
                    end
                end
            end
            if #tbl_boss ~= 0 then
                yes = true
                local b_tx
                if b == Maxb[FB] - 1 or b == Maxb[FB] then
                    b_tx = L["项目："]
                else
                    b_tx = L["Boss："]
                end

                local bossname2 = BG.Boss[FB]["boss" .. b].name2
                local bosscolor = BG.Boss[FB]["boss" .. b].color
                local text
                local faKuanSumText = ""
                if b == Maxb[FB] then
                    faKuanSumText = format(L["（合计%s）"], GetFaKuanSumMoney())
                end
                if onClick then
                    text = b_tx .. bossname2 .. faKuanSumText
                else
                    text = "|cff" .. bosscolor .. b_tx .. bossname2 .. faKuanSumText .. "|r"
                end

                table.insert(tbl2, { text })
                local tbl = {}
                for i, v in ipairs(tbl_boss) do
                    tbl[i] = v
                end
                table.insert(tbl2, tbl)

                table.insert(tbl_boss, 1, text)
                for index, value in ipairs(tbl_boss) do
                    table.insert(tbl1, value)
                end
            end
        end
        if not yes then
            local text = L["没有收入"] .. NN
            table.insert(tbl1, text)
            table.insert(tbl2, { text })
        end
    end
    -- 支出
    do
        local text
        if onClick then
            text = format(L["< 支 %s 出 >"], BG.SetRaidTargetingIcons(onClick, "sanjiao"))
        else
            text = "|cffffffff" .. format(L["< 支 %s 出 >"], BG.SetRaidTargetingIcons(onClick, "sanjiao")) .. RN
        end
        table.insert(tbl1, text)
        table.insert(tbl2, { text })
        local yes
        local tbl_boss = {}
        local num = 1

        local b = Maxb[FB] + 1
        for i = 1, BG.GetMaxi(FB, b), 1 do
            local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
            local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
            if zhuangbei then
                local jineText = jine:GetText()
                if tonumber(jineText) and tonumber(jineText) ~= 0 then
                    local zhuangbeiText = zhuangbei:GetText()
                    if zhuangbeiText:gsub(" ", "") == "" then
                        zhuangbeiText = L["支出"]
                    end
                    local text
                    if onClick then
                        text = zhuangbeiText .. " " .. jineText
                    else
                        text = BG.STC_g1(zhuangbeiText) .. " " .. BG.STC_g1(jineText)
                    end
                    table.insert(tbl_boss, text)
                    num = num + 1
                end
            end
        end
        if #tbl_boss ~= 0 then
            yes = true
            local tbl = {}
            for i, v in ipairs(tbl_boss) do
                tbl[i] = v
            end
            table.insert(tbl2, tbl)
            for i, v in ipairs(tbl_boss) do
                table.insert(tbl1, v)
            end
        end
        if not yes then
            local text = L["没有支出"] .. NN
            table.insert(tbl1, text)
            table.insert(tbl2, { text })
        end
    end
    -- 总览和工资
    tbl1, tbl2 = ZongLan(onClick, tbl1, tbl2)
    return tbl1, tbl2
end
local function OnEnter(self)
    self.OnEnter = true
    if BG.Backing then return end
    local FB = BG.FB1
    local tbl1 = {}

    if IsAltKeyDown() then
        local type = nil
        local text = L["———通报总览———"]
        table.insert(tbl1, text)
        -- 总览和工资
        tbl1 = ZongLan(type, tbl1)
    elseif IsShiftKeyDown() then
        local type = nil
        local text = L["———通报罚款———"]
        table.insert(tbl1, text)
        -- 罚款
        tbl1 = FaKuan(type, tbl1)
    elseif IsControlKeyDown() then
        local type = nil
        local text = L["———通报支出———"]
        table.insert(tbl1, text)
        -- 支出
        tbl1 = ZhiChu(type, tbl1)
    else
        local text = L["———通报账单———"]
        table.insert(tbl1, text)
        local text = format(BG.STC_b1(L["表格：%s"]), BG.FB1)
        table.insert(tbl1, text)
        tbl1 = CreateListTable(nil, tbl1)
    end

    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0);
    GameTooltip:ClearLines()
    for i, v in ipairs(tbl1) do
        GameTooltip:AddLine(v)
    end
    GameTooltip:Show()
    GameTooltip:SetClampedToScreen(false)

    BiaoGeTooltip2:SetOwner(GameTooltip, "ANCHOR_NONE", 0, 0);
    BiaoGeTooltip2:SetPoint("BOTTOMLEFT", GameTooltip, "BOTTOMRIGHT", 0, 0)
    BiaoGeTooltip2:ClearLines()
    BiaoGeTooltip2:AddLine(L["其他选项"])
    BiaoGeTooltip2:AddLine(L["长按SHITF：仅通报罚款"], 0.5, 0.5, 0.5)
    BiaoGeTooltip2:AddLine(L["长按CTRL：仅通报支出"], 0.5, 0.5, 0.5)
    BiaoGeTooltip2:AddLine(L["长按ALT：仅通报总览"], 0.5, 0.5, 0.5)
    BiaoGeTooltip2:Show()
end

local function OnClick(self)
    local FB = BG.FB1
    BG.FrameHide(0)
    if BG.IsErrorSendChannel() then return end
    self:SetEnabled(false)
    C_Timer.After(2, function()
        self:SetEnabled(true)
    end)

    if IsAltKeyDown() then
        -- 总览和工资
        local _, tbl = ZongLan(true)
        tinsert(tbl, 1, { L["———通报总览———"] })
        BG.SendMsgToRaid(tbl)
    elseif IsShiftKeyDown() then
        -- 罚款
        local _, tbl = FaKuan(true)
        tinsert(tbl, 1, { L["———通报罚款———"] })
        BG.SendMsgToRaid(tbl)
    elseif IsControlKeyDown() then
        -- 支出
        local _, tbl = ZhiChu(true)
        tinsert(tbl, 1, { L["———通报支出———"] })
        BG.SendMsgToRaid(tbl)
    else
        if HasQianKuan() then
            BG.PlaySound("qiankuan")
        end
        local channel = BiaoGe.NotifyChannel
        if channel == "RAID" then
            BG.After(2, function()
                for ii in ipairs(BiaoGe[FB].tradeTbl) do
                    local text = "DuiZhang-"
                    local yes = true
                    for i, v in ipairs(BiaoGe[FB].tradeTbl[ii]) do
                        if i == 1 then
                            if BiaoGe[v.FB]["boss" .. v.b]["maijia" .. v.i] then
                                -- DuiZhang-苍牧-
                                text = text .. BiaoGe[v.FB]["boss" .. v.b]["maijia" .. v.i] .. "-"
                            else
                                yes = nil
                                break
                            end
                        end
                        local jine = BiaoGe[v.FB]["boss" .. v.b]["jine" .. v.i]
                        if not jine then
                            yes = nil
                            break
                        end
                        if jine == L["打包交易"] then
                            jine = "t"
                        end
                        -- DuiZhang-苍牧-24478 10000,27854 t,27503 t,
                        text = text .. v.itemID .. " " .. jine .. ","
                    end
                    if yes then
                        C_ChatInfo.SendAddonMessage("BiaoGe", text, "RAID")
                    end
                end
            end)
        end
        local _, tbl = CreateListTable(true)
        tinsert(tbl, 1, { format(L["表格：%s"], BG.FB1) })
        tinsert(tbl, 1, { L["———通报账单———"] })
        tinsert(tbl, { L["—感谢使用BiaoGe插件—"] })
        BG.SendMsgToRaid(tbl)
    end
    BG.PlaySound(2)
end

function BG.ZhangDanUI(lastbt)
    local bt = BG.CreateButton(BG.FBMainFrame)
    bt:SetSize(60, 25)
    bt.jiange = 5
    if lastbt then
        bt:SetPoint("LEFT", lastbt, "RIGHT", bt.jiange, 0)
    else
        local x = -290
        if BG.hasWCL then
            x = x - 60
        end
        bt:SetPoint("BOTTOMRIGHT", BG.MainFrame, "BOTTOMRIGHT", x, 38)
    end
    bt:SetText(L["账单"])
    BG.ButtonZhangDan = bt
    tinsert(BG.TongBaoButtons, bt)

    -- 鼠标悬停提示账单
    bt:SetScript("OnEnter", OnEnter)
    bt:SetScript("OnLeave", function(self)
        self.OnEnter = false
        GameTooltip:Hide()
        GameTooltip:SetClampedToScreen(true)
        BiaoGeTooltip2:Hide()
    end)
    -- 点击通报账单
    bt:SetScript("OnClick", OnClick)

    local f = CreateFrame("Frame")
    f:RegisterEvent("MODIFIER_STATE_CHANGED")
    f:SetScript("OnEvent", function(self, event, enter)
        if (enter == "LALT" or enter == "RALT"
                or enter == "LSHIFT" or enter == "RSHIFT"
                or enter == "LCTRL" or enter == "RCTRL")
            and bt.OnEnter then
            OnEnter(bt)
        end
    end)

    local t = bt:CreateFontString()
    t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
    t:SetPoint("RIGHT", bt, "LEFT", -5, 0)
    t:SetTextColor(1, 0.82, 0)
    t:SetText(L["通报："])

    return bt
end

-- 聊天框显示支出占比
local sumMoney
local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_RAID_LEADER")
f:RegisterEvent("CHAT_MSG_RAID")
f:SetScript("OnEvent", function(self, event, msg, sender, ...)
    local sum = tonumber(msg:match("^" .. L["总收入"] .. L["："] .. "(%d+)$"))
    if sum and sum ~= 0 then
        sumMoney = sum
        BG.After(1, function()
            sumMoney = nil
        end)
    end
end)

local function FormatExpenses(self, event, msg, ...)
    if sumMoney then
        local expenseMoney = tonumber(msg:match("^" .. L["总支出"] .. L["："] .. "(%d+)$"))
        if expenseMoney then
            local newMsg = msg .. L["（占比%s%%）"]:format(format("%.0f", expenseMoney / sumMoney * 100))
            return false, newMsg, ...
        end
    end
    -- local man = tonumber(msg:match("^" .. L["分钱人数"] .. L["："] .. "(%d+)"))
    -- if man then
    --     local nowMan = GetNumGroupMembers()
    --     if man > nowMan then
    --         local color = "ff0000" or "ffffff"
    --         msg = msg:gsub("(%d+)", "|cff" .. color .. "%1")
    --         return false, msg, ...
    --     end
    -- end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", FormatExpenses)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", FormatExpenses)

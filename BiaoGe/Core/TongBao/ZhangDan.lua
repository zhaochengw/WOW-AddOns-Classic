local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local FrameHide = ns.FrameHide
local SetClassCFF = ns.SetClassCFF
local RGB_16 = ns.RGB_16

local Maxb = ns.Maxb
local Maxi = ns.Maxi
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print
BG.tongBaoSendCD = 0.3

BG.TongBaoButtons = {}

function BG.SendMsgToRaid(tbl, t)
    local t = t or 0
    for ii, vv in ipairs(tbl) do
        BG.After(t, function()
            for _, text in ipairs(tbl[ii]) do
                SendChatMessage(text, "RAID")
            end
        end)
        t = t + BG.tongBaoSendCD
    end
    return t
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
    for i = 1, 3, 1 do
        if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
            local text
            if onClick then
                text = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText() .. L["："] ..
                    BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText()
            else
                text = "|cffEE82EE" .. BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText() .. L["："] ..
                    BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText() .. RN
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

local function FaKuan(onClick, tbl1, tbl2)
    local FB = BG.FB1
    local tbl1 = tbl1 or {}
    local tbl2 = tbl2 or {}
    local num = 1
    local yes
    local tbl_boss = {}
    local b = Maxb[FB]
    for i = 1, Maxi[FB] do
        local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
        local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
        local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
        if zhuangbei then
            if tonumber(jine:GetText()) and tonumber(jine:GetText()) ~= 0 then
                local text
                if onClick then
                    text = zhuangbei:GetText() .. " " .. (maijia:GetText()) .. " " ..
                        jine:GetText()
                else
                    text = num .. ". " .. zhuangbei:GetText() .. " " ..
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
    for i = 1, Maxi[FB] do
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
            for i = 1, Maxi[FB] do
                local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
                if zhuangbei then
                    if (tonumber(jine:GetText()) and tonumber(jine:GetText()) ~= 0)
                        or (zhuangbei:GetText() ~= "" and (maijia:GetText() ~= "" or jine:GetText() ~= "")) then
                        local text
                        local jineText = jine:GetText()
                        if jineText == "" then
                            jineText = 0
                        end
                        if onClick then
                            text = zhuangbei:GetText() .. " " ..
                                (maijia:GetText()) .. " " .. jineText
                        else
                            text = zhuangbei:GetText() .. " " ..
                                RGB_16(maijia:GetText(), unpack({ maijia:GetTextColor() })) .. " " .. jineText
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
                if onClick then
                    text = b_tx .. bossname2
                else
                    text = "|cff" .. bosscolor .. b_tx .. bossname2 .. RN
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
        for i = 1, Maxi[FB], 1 do
            local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
            local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
            if zhuangbei then
                if tonumber(jine:GetText()) and tonumber(jine:GetText()) ~= 0 then
                    local text
                    if onClick then
                        text = zhuangbei:GetText() .. " " .. jine:GetText()
                    else
                        text = BG.STC_g1(zhuangbei:GetText()) .. " " .. BG.STC_g1(jine:GetText())
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
    FrameHide(0)
    if not IsInRaid(1) then
        SendSystemMessage(L["不在团队，无法通报"])
        BG.PlaySound(1)
    else
        self:SetEnabled(false) -- 点击后按钮变灰2秒
        C_Timer.After(2, function()
            self:SetEnabled(true)
        end)

        if IsAltKeyDown() then
            local text = L["———通报总览———"]
            SendChatMessage(text, "RAID")
            -- 总览和工资
            local _, tbl = ZongLan(true)
            BG.SendMsgToRaid(tbl, BG.tongBaoSendCD)
        elseif IsShiftKeyDown() then
            local text = L["———通报罚款———"]
            SendChatMessage(text, "RAID")
            -- 罚款
            local _, tbl = FaKuan(true)
            BG.SendMsgToRaid(tbl, BG.tongBaoSendCD)
        elseif IsControlKeyDown() then
            local text = L["———通报支出———"]
            SendChatMessage(text, "RAID")
            -- 支出
            local _, tbl = ZhiChu(true)
            BG.SendMsgToRaid(tbl, BG.tongBaoSendCD)
        else
            local text = L["———通报账单———"]
            SendChatMessage(text, "RAID")

            local text = format(L["表格：%s"], BG.FB1)
            BG.After(BG.tongBaoSendCD, function()
                SendChatMessage(text, "RAID")
            end)

            local _, tbl = CreateListTable(true)
            local t = BG.SendMsgToRaid(tbl, BG.tongBaoSendCD + BG.tongBaoSendCD)

            BG.After(t, function()
                local text = L["——感谢使用BiaoGe插件——"]
                SendChatMessage(text, "RAID")
            end)
        end

        BG.PlaySound(2)
    end
end

function BG.ZhangDanUI(lastbt)
    local bt = CreateFrame("Button", nil, BG.FBMainFrame, "UIPanelButtonTemplate")
    bt:SetSize(60, 30)
    bt.jiange = 5
    if lastbt then
        bt:SetPoint("LEFT", lastbt, "RIGHT", bt.jiange, 0)
    else
        bt:SetPoint("BOTTOMRIGHT", BG.MainFrame, "BOTTOMRIGHT", -300, 35)
    end
    bt:SetText(L["账单"])
    bt:Show()
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

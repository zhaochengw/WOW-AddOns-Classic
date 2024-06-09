local AddonName, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local FrameHide = ADDONSELF.FrameHide
local SetClassCFF = ADDONSELF.SetClassCFF
local RGB_16 = ADDONSELF.RGB_16

local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

local pt = print

-- 总览和工资
local function ZongLan(type, tx)
    local FB = BG.FB1
    local text
    if type then
        text = format(L["< 总 %s 览 >"], BG.SetRaidTargetingIcons(type, "ziling"))
    else
        text = "|cffffffff" .. format(L["< 总 %s 览 >"], BG.SetRaidTargetingIcons(type, "ziling")) .. RN
    end
    table.insert(tx, text)

    local b = Maxb[FB] + 2
    for i = 1, 3, 1 do
        if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
            local text
            if type then
                text = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText() .. "：" ..
                    BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText()
            else
                text = "|cffEE82EE" .. BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText() .. "：" ..
                    BG.Frame[FB]["boss" .. b]["jine" .. i]:GetText() .. RN
            end
            table.insert(tx, text)
        end
    end

    local text
    if type then
        text = format(L["< 工 %s 资 >"], BG.SetRaidTargetingIcons(type, "fangkuai"))
    else
        text = "|cffffffff" .. format(L["< 工 %s 资 >"], BG.SetRaidTargetingIcons(type, "fangkuai")) .. RN
    end
    table.insert(tx, text)

    local text
    if type then
        text = BG.Frame[FB]["boss" .. b]["zhuangbei4"]:GetText() .. "：" ..
            BG.Frame[FB]["boss" .. b]["jine4"]:GetText() .. L["人"]
    else
        text = "|cff00BFFF" .. BG.Frame[FB]["boss" .. b]["zhuangbei4"]:GetText() .. "：" ..
            BG.Frame[FB]["boss" .. b]["jine4"]:GetText() .. L["人"] .. RN
    end
    table.insert(tx, text)

    local text
    if type then
        text = BG.Frame[FB]["boss" .. b]["zhuangbei5"]:GetText() .. "：" ..
            BG.Frame[FB]["boss" .. b]["jine5"]:GetText()
    else
        text = "|cff00BFFF" .. BG.Frame[FB]["boss" .. b]["zhuangbei5"]:GetText() .. "：" ..
            BG.Frame[FB]["boss" .. b]["jine5"]:GetText() .. RN
    end
    table.insert(tx, text)

    local text
    if type then
        text = BG.Frame[FB]["boss" .. b]["jine5"]:GetText() .. " x 5 = " ..
            (tonumber(BG.Frame[FB]["boss" .. b]["jine5"]:GetText()) * 5)
    else
        text = "|cff00BFFF" .. BG.Frame[FB]["boss" .. b]["jine5"]:GetText() .. " x 5 = " ..
            (tonumber(BG.Frame[FB]["boss" .. b]["jine5"]:GetText()) * 5) .. RN
    end
    table.insert(tx, text)
    return tx
end

local function FaKuan(type, tx)
    local FB = BG.FB1
    local num = 1
    local yes
    local b = Maxb[FB]
    for i = 1, Maxi[FB] do
        local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
        local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
        local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
        if zhuangbei then
            if tonumber(jine:GetText()) and tonumber(jine:GetText()) ~= 0 then
                local text
                if type then
                    text = num .. ". " .. zhuangbei:GetText() .. " " .. (maijia:GetText()) .. " " ..
                        jine:GetText()
                else
                    text = num .. ". " .. zhuangbei:GetText() .. " " ..
                        RGB_16(maijia:GetText(), unpack({ maijia:GetTextColor() })) .. " " ..
                        jine:GetText()
                end
                table.insert(tx, text)
                num = num + 1
                yes = true
            end
        end
    end
    if not yes then
        local text = L["没有罚款"]
        table.insert(tx, text)
    end
    return tx
end

local function CreateListTable(type, tx)
    local FB = BG.FB1
    local tx = tx or {}
    -- 收入
    do
        local text
        if type then
            text = format(L["< 收 %s 入 >"], BG.SetRaidTargetingIcons(type, "xingxing"))
        else
            text = "|cffffffff" .. format(L["< 收 %s 入 >"], BG.SetRaidTargetingIcons(type, "xingxing")) .. RN
        end
        table.insert(tx, text)
        local yes
        for b = 1, Maxb[FB] do
            local tx_1 = {}
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
                        if type then
                            text = zhuangbei:GetText() .. " " ..
                                (maijia:GetText()) .. " " .. jineText
                        else
                            text = zhuangbei:GetText() .. " " ..
                                RGB_16(maijia:GetText(), unpack({ maijia:GetTextColor() })) .. " " .. jineText
                        end
                        table.insert(tx_1, text)
                    end
                end
            end
            if #tx_1 ~= 0 then
                yes = true
                local text = ""
                local b_tx
                if b == Maxb[FB] - 1 or b == Maxb[FB] then
                    b_tx = L["项目："]
                else
                    b_tx = L["Boss："]
                end
                local bossname2 = BG.Boss[FB]["boss" .. b].name2
                local bosscolor = BG.Boss[FB]["boss" .. b].color
                local text
                if type then
                    text = b_tx .. bossname2
                else
                    text = "|cff" .. bosscolor .. b_tx .. bossname2 .. RN
                end
                table.insert(tx_1, 1, text)
                for index, value in ipairs(tx_1) do
                    table.insert(tx, value)
                end
            end
        end
        if not yes then
            local text = L["没有收入"] .. NN
            table.insert(tx, text)
        end
    end
    -- 支出
    do
        local text
        if type then
            text = format(L["< 支 %s 出 >"], BG.SetRaidTargetingIcons(type, "sanjiao"))
        else
            text = "|cffffffff" .. format(L["< 支 %s 出 >"], BG.SetRaidTargetingIcons(type, "sanjiao")) .. RN
        end
        table.insert(tx, text)
        local yes
        local tx_1 = {}
        local num = 1

        local b = Maxb[FB] + 1
        for i = 1, Maxi[FB], 1 do
            local zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
            local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
            local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
            if zhuangbei then
                if tonumber(jine:GetText()) and tonumber(jine:GetText()) ~= 0 then
                    local text
                    if type then
                        text = zhuangbei:GetText() .. " " .. (maijia:GetText()) .. " " .. jine:GetText()
                    else
                        text = BG.STC_g1(zhuangbei:GetText()) .. " " ..
                            RGB_16(maijia:GetText(), unpack({ maijia:GetTextColor() })) .. " " ..
                            BG.STC_g1(jine:GetText())
                    end
                    table.insert(tx_1, text)
                    num = num + 1
                end
            end
        end
        if #tx_1 ~= 0 then
            yes = true
            for index, value in ipairs(tx_1) do
                table.insert(tx, value)
            end
        end
        if not yes then
            local text = L["没有支出"] .. NN
            table.insert(tx, text)
        end
    end
    -- 总览和工资
    tx = ZongLan(type, tx)

    if not type then
        local text = BG.STC_dis(L["(长按ALT：仅通报总览)"])
        table.insert(tx, text)
        local text = BG.STC_dis(L["(长按SHITF：仅通报罚款)"])
        table.insert(tx, text)
    end
    return tx
end


function BG.ZhangDanUI(lastbt)
    local bt = CreateFrame("Button", nil, BG.FBMainFrame, "UIPanelButtonTemplate")
    bt:SetSize(90, 30)
    if lastbt then
        bt:SetPoint("LEFT", lastbt, "RIGHT", 10, 0)
    else
        if BG.IsVanilla() then
            bt:SetPoint("BOTTOMRIGHT", BG.MainFrame, "BOTTOMRIGHT", -430, 35)
        else
            bt:SetPoint("BOTTOMRIGHT", BG.MainFrame, "BOTTOMRIGHT", -530, 35)
        end
    end
    bt:SetText(L["通报账单"])
    bt:Show()
    BG.ButtonZhangDan = bt

    -- 鼠标悬停提示账单
    local function OnEnter(self)
        self.OnEnter = true
        if BG.Backing then return end
        local FB = BG.FB1
        local tx = {}

        if IsAltKeyDown() then
            local type = nil
            local text = L["———通报总览———"]
            table.insert(tx, text)
            -- 总览和工资
            tx = ZongLan(type, tx)
        elseif IsShiftKeyDown() then
            local type = nil
            local text = L["———通报罚款———"]
            table.insert(tx, text)
            -- 罚款
            tx = FaKuan(type, tx)
        else
            local text = L["———通报金团账单———"]
            table.insert(tx, text)
            tx = CreateListTable(nil, tx)
        end

        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0);
        GameTooltip:ClearLines()
        for i, v in ipairs(tx) do
            GameTooltip:AddLine(v)
        end
        GameTooltip:Show()

        local a = GameTooltip:GetHeight()
        local b = UIParent:GetHeight()
        if a and b then
            a = tonumber(a)
            b = tonumber(b)
            if a >= b then
                local scale = 1 - ((a - b) / b) * 0.5
                local s = 0
                if scale >= 0.9 then
                    s = 0.13
                elseif scale >= 0.8 then
                    s = 0.15
                elseif scale >= 0.7 then
                    s = 0.11
                elseif scale >= 0.6 then
                    s = 0.08
                elseif scale >= 0.55 then
                    s = 0.06
                elseif scale >= 0.5 then
                    s = 0.05
                end
                scale = string.format("%.2f", scale) - s
                if scale <= 0 then
                    scale = 0.4
                end
                GameTooltip:SetScale(scale)
            end
        end
    end
    bt:SetScript("OnEnter", OnEnter)

    bt:SetScript("OnLeave", function(self)
        self.OnEnter = false
        GameTooltip:Hide()
        GameTooltip:SetScale(1)
    end)
    -- 点击通报账单
    bt:SetScript("OnClick", function(self)
        local FB = BG.FB1
        FrameHide(0)
        if not IsInRaid(1) then
            SendSystemMessage(L["不在团队，无法通报"])
            PlaySound(BG.sound1, "Master")
        else
            self:SetEnabled(false) -- 点击后按钮变灰2秒
            C_Timer.After(2, function()
                bt:SetEnabled(true)
            end)

            local tx = {}
            if IsAltKeyDown() then
                local type = true
                local text = L["———通报总览———"]
                table.insert(tx, text)
                -- 总览和工资
                tx = ZongLan(type, tx)
            elseif IsShiftKeyDown() then
                local type = true
                local text = L["———通报罚款———"]
                table.insert(tx, text)
                -- 罚款
                tx = FaKuan(type, tx)
            else
                local text = L["———通报金团账单———"]
                table.insert(tx, text)
                tx = CreateListTable(true, tx)
                local text = L["——感谢使用金团表格——"]
                table.insert(tx, text)
            end

            for index, value in ipairs(tx) do
                SendChatMessage(value, "RAID")
            end

            PlaySoundFile(BG.sound2, "Master")
        end
    end)

    local f = CreateFrame("Frame")
    f:RegisterEvent("MODIFIER_STATE_CHANGED")
    f:SetScript("OnEvent", function(self, event, enter)
        if (enter == "LALT" or enter == "RALT" or enter == "LSHIFT" or enter == "RSHIFT") and bt.OnEnter then
            OnEnter(bt)
        end
    end)

    return bt
end

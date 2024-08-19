local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local TongBao = ns.TongBao
local FrameHide = ns.FrameHide
local RGB = ns.RGB

local Maxb = ns.Maxb
local Maxi = ns.Maxi
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print

function BG.YongShiUI(lastbt)
    local bt = CreateFrame("Button", nil, BG.ButtonZhangDan, "UIPanelButtonTemplate")
    bt:SetSize(BG.ButtonZhangDan:GetWidth(), BG.ButtonZhangDan:GetHeight())
    bt:SetPoint("LEFT", lastbt, "RIGHT", BG.ButtonZhangDan.jiange, 0)
    bt:SetText(L["用时"])
    BG.ButtonYongShi = bt
    tinsert(BG.TongBaoButtons, bt)
    bt:SetScript("OnEnter", function(self)
        if BG.Backing then return end
        local FB = BG.FB1
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(L["———通报击杀用时———"])
        local yes
        for b = 1, Maxb[FB] do
            local time = BiaoGe[FB]["boss" .. b]["time"]
            if time then
                local bossname2 = BG.Boss[FB]["boss" .. b].name2
                local bosscolor = BG.Boss[FB]["boss" .. b].color
                GameTooltip:AddLine(b .. ". " .. bossname2 .. " " .. time, unpack({ RGB(bosscolor) }))
                yes = true
            end
            if BG.Frame[FB]["boss" .. b]["time"] then
                BG.Frame[FB]["boss" .. b]["time"]:SetAlpha(0.8)
            end
        end
        if not yes then
            GameTooltip:AddLine(L["没有记录"])
        end
        GameTooltip:Show()
        GameTooltip:SetClampedToScreen(false)
    end)
    bt:SetScript("OnLeave", function(self)
        local FB = BG.FB1
        for b = 1, Maxb[FB] do
            if BG.Frame[FB]["boss" .. b]["time"] then
                BG.Frame[FB]["boss" .. b]["time"]:SetAlpha(0)
            end
        end
        GameTooltip:Hide()
        GameTooltip:SetClampedToScreen(true)
    end)
    bt:SetScript("OnClick", function(self)
        FrameHide(0)
        if not IsInRaid(1) then
            SendSystemMessage(L["不在团队，无法通报"])
            BG.PlaySound(1)
        else
            self:SetEnabled(false) -- 点击后按钮变灰2秒
            C_Timer.After(2, function()
                bt:SetEnabled(true)
            end)
            local FB = BG.FB1
            SendChatMessage(L["———通报击杀用时———"], "RAID")
            local yes
            local t = 0
            for b = 1, Maxb[FB] do
                local time = BiaoGe[FB]["boss" .. b]["time"]
                if time then
                    -- BG.After(t, function()
                    local bossname2 = BG.Boss[FB]["boss" .. b].name2
                    SendChatMessage(b .. ". " .. bossname2 .. " " .. time, "RAID")
                    -- end)
                    -- t = t + BG.tongBaoSendCD
                    yes = true
                end
            end
            if not yes then
                SendChatMessage(L["没有记录"], "RAID")
            end
            BG.PlaySound(2)
        end
    end)

    local timestart
    -- 获取BOSS战ID+
    local f = CreateFrame("Frame")
    f:RegisterEvent("ENCOUNTER_START")
    f:RegisterEvent("BOSS_KILL")
    f:SetScript("OnEvent", function(self, even, ID)
        if not BG.FB2 then return end
        if even == "ENCOUNTER_START" then
            timestart = GetTime()
        elseif even == "BOSS_KILL" then
            if timestart then
                local time = GetTime() - timestart
                local m, s = math.modf(time / 60)
                s = string.format("%02d", s * 60)
                time = m .. ":" .. s
                timestart = nil

                local numb
                if BG.Loot.encounterID[BG.FB2] then
                    for _numb, _bossID in ipairs(BG.Loot.encounterID[BG.FB2]) do
                        if ID == _bossID then
                            numb = _numb
                            break
                        end
                    end
                end
                if not numb then return end

                BG.Frame[BG.FB2]["boss" .. numb]["time"]:SetText(L["击杀用时"] .. " " .. time)
                BiaoGe[BG.FB2]["boss" .. numb]["time"] = time
            end
        end
    end)

    return bt
end

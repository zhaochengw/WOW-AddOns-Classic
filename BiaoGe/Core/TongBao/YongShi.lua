local AddonName, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local TongBao = ADDONSELF.TongBao
local FrameHide = ADDONSELF.FrameHide

local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

local pt = print

function BG.YongShiUI(lastbt)
    local bt = CreateFrame("Button", nil, BG.FBMainFrame, "UIPanelButtonTemplate")
    bt:SetSize(90, BG.ButtonZhangDan:GetHeight())
    bt:SetPoint("LEFT", lastbt, "RIGHT", 10, 0)
    bt:SetText(L["通报用时"])
    bt:Show()
    BG.ButtonYongShi = bt
    bt:SetScript("OnEnter", function(self)
        if BG.Backing then return end
        local FB = BG.FB1
        local text = "|cffffffff" .. L["< 通报击杀用时 >"] .. RN
        for b = 1, Maxb[FB] do
            local time = BiaoGe[FB]["boss" .. b]["time"]
            if time then
                local s, e = strfind(time, "：")
                if s then
                    time = strsub(time, e + 1, strlen(time))
                end
                local bossname2 = BG.Boss[FB]["boss" .. b].name2
                local bosscolor = BG.Boss[FB]["boss" .. b].color
                text = text .. b .. "、" .. "|cff" .. bosscolor .. bossname2 .. "：" .. time .. RN
            end
            if BG.Frame[FB]["boss" .. b]["time"] then
                BG.Frame[FB]["boss" .. b]["time"]:SetAlpha(0.8)
            end
        end
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:SetText(text)
    end)
    bt:SetScript("OnLeave", function(self)
        local FB = BG.FB1
        for b = 1, Maxb[FB] do
            if BG.Frame[FB]["boss" .. b]["time"] then
                BG.Frame[FB]["boss" .. b]["time"]:SetAlpha(0)
            end
        end
        GameTooltip:Hide()
    end)
    bt:SetScript("OnClick", function(self)
        FrameHide(0)
        if not IsInRaid(1) then
            SendSystemMessage(L["不在团队，无法通报"])
            PlaySound(BG.sound1, "Master")
        else
            self:SetEnabled(false) -- 点击后按钮变灰2秒
            C_Timer.After(2, function()
                bt:SetEnabled(true)
            end)
            local FB = BG.FB1
            local text = L["———通报击杀用时———"]
            SendChatMessage(text, "RAID")
            for b = 1, Maxb[FB] do
                local time = BiaoGe[FB]["boss" .. b]["time"]
                if time then
                    local s, e = strfind(time, "：")
                    if s then
                        time = string.gsub(strsub(time, e + 1, strlen(time)), "|r", "")
                    end
                    text = b .. "、" .. BG.Boss[FB]["boss" .. b]["name2"] .. "：" .. time
                    SendChatMessage(text, "RAID")
                end
            end
            SendChatMessage(L["——感谢使用金团表格——"], "RAID")
            PlaySoundFile(BG.sound2, "Master")
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
                time = m .. L["分"] .. s .. L["秒"]

                local numb
                if BG.Loot.encounterID[BG.FB2] then
                    for key, value in pairs(BG.Loot.encounterID[BG.FB2]) do
                        if tonumber(ID) == tonumber(key) then
                            numb = value
                            break
                        end
                    end
                end
                if not numb then return end

                local bosscolor = BG.Boss[BG.FB2]["boss" .. numb].color
                local text = "|cff" .. bosscolor .. L["击杀用时："] .. time .. RR
                BG.Frame[BG.FB2]["boss" .. numb]["time"]:SetText(text)
                BiaoGe[BG.FB2]["boss" .. numb]["time"] = text

                timestart = nil
            end
        end
    end)

    return bt
end

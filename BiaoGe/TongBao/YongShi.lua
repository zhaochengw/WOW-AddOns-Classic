local _, ADDONSELF = ...

local TongBao = ADDONSELF.TongBao
local FrameHide = ADDONSELF.FrameHide

local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi
    
local pt = print

local function TongBaoUI()
    local bt = CreateFrame("Button", nil, BG.MainFrame, "UIPanelButtonTemplate")
    bt:SetSize(90, 25)
    bt:SetPoint("BOTTOM", BG.MainFrame, "BOTTOM", -80, 15)
    bt:SetText("通报用时")
    bt:Show()
    BG.ButtonYongShi = bt
    bt:SetScript("OnEnter", function(self)
        local FB = BG.FB1
        local text = "|cffffffff< 通报击杀用时 >|r\n"
        for b=1,Maxb[FB] do
            local time = BiaoGe[FB]["boss"..b]["time"]
            if time then
                local s,e = strfind(time,"：")
                if s then
                    time = strsub(time,e+1,strlen(time))
                end
                local bossname = BiaoGe[FB]["boss"..b]["bossname"]
                local color
                if strfind(bossname,"|cff") then
                    color = strsub(bossname,strfind(bossname,"|cff"),strfind(bossname,"|cff")+9)
                end
                if color then
                    text = text..b.."、"..color..BiaoGe[FB]["boss"..b]["bossname2"].."："..time.."|r\n"
                else
                    text = text..b.."、"..BiaoGe[FB]["boss"..b]["bossname2"].."："..time.."|r\n"
                end
            end
        end
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0)
        GameTooltip:ClearLines()
        GameTooltip:SetText(text)
    end)
    bt:SetScript("OnLeave",function (self)
        GameTooltip:Hide()
    end)
    bt:SetScript("OnClick", function(self)
        FrameHide(0)
        if not IsInRaid() then
            print("不在团队，无法通报")
            PlaySound(BG.sound1,"Master")
        else
            self:SetEnabled(false)      -- 点击后按钮变灰2秒
            C_Timer.After(2,function ()
                bt:SetEnabled(true)
            end)
            local FB = BG.FB1
            local text = "———通报击杀用时———"
            SendChatMessage(text,"RAID")
            for b=1,Maxb[FB] do
                local time = BiaoGe[FB]["boss"..b]["time"]
                if time then
                    local s,e = strfind(time,"：")
                    if s then
                        time = strsub(time,e+1,strlen(time))
                    end
                    text = b.."、"..BiaoGe[FB]["boss"..b]["bossname2"].."："..time
                    SendChatMessage(text,"RAID")
                end
            end
            SendChatMessage("——感谢使用金团表格——","RAID")
            PlaySoundFile(BG.sound2,"Master")
        end
    end)

    local numb
    local timestart,timekill,time
    -- 获取BOSS战ID+
    local f=CreateFrame("Frame")
    f:RegisterEvent("ENCOUNTER_START")
    f:RegisterEvent("BOSS_KILL")
    f:SetScript("OnEvent", function(self,even,ID)
        if not BG.FB2 then return end
        if even == "ENCOUNTER_START" then
            timestart = GetTime()
        elseif even == "BOSS_KILL" then
            if timestart then
                timekill = GetTime()
                time = timekill - timestart
                local m,s = math.modf(time / 60)
                s = string.format("%02d",s * 60)
                time = m.."分"..s.."秒"

                if BG.Loot.encounterID[BG.FB2] then
                    for key, value in ipairs(BG.Loot.encounterID[BG.FB2]) do
                        if ID == value then
                            numb = key
                        end
                    end
                end

                if not numb then return end

                local bossname = BiaoGe[BG.FB2]["boss"..numb]["bossname"]
                local color
                local text
                if strfind(bossname,"|cff") then
                    color = strsub(bossname,strfind(bossname,"|cff"),strfind(bossname,"|cff")+9)
                end
                if color then
                    text = color.."击杀用时："..time
                    BG.Frame[BG.FB2]["boss"..numb]["time"]:SetText(text)
                else
                    text = "击杀用时："..time
                    BG.Frame[BG.FB2]["boss"..numb]["time"]:SetText(text)
                end
                BiaoGe[BG.FB2]["boss"..numb]["time"] = text

                timestart = nil
                timekill = nil
                time = nil
            end
        end
    end)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "BiaoGe" then
        TongBaoUI()
    end
end)
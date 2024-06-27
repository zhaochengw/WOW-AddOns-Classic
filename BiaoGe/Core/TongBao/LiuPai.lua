local AddonName, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local FrameHide = ADDONSELF.FrameHide
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

local AddTexture = ADDONSELF.AddTexture
local GetItemID = ADDONSELF.GetItemID
local BossNum = ADDONSELF.BossNum

local pt = print

local function CreateListTable(type, tx)
    local FB = BG.FB1
    local tx = tx or {}

    local text = L["———通报流拍装备———"]
    table.insert(tx, text)
    local num = 0

    local yes
    for b = 1, Maxb[FB] - 1 do
        local tx_1 = {}
        for i = 1, Maxi[FB] do
            if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                if BG.Frame[BG.FB1]["boss" .. b]["zhuangbei" .. i]:GetText() ~= ""
                    and GetItemID(BG.Frame[BG.FB1]["boss" .. b]["zhuangbei" .. i]:GetText())
                    and BG.Frame[BG.FB1]["boss" .. b]["maijia" .. i]:GetText() == ""
                    and BG.Frame[BG.FB1]["boss" .. b]["jine" .. i]:GetText() == "" then
                    local name, link, quality, level, _, _, _, _, _, _, _, typeID = GetItemInfo(BG.Frame[BG.FB1]["boss" .. b]["zhuangbei" .. i]:GetText())
                    local leveltext = ""
                    if typeID == 2 or typeID == 4 then
                        if type then
                            leveltext = "(" .. level .. ")"
                        else
                            leveltext = "|cff9370DB(" .. level .. ")"
                        end
                    end
                    local text = L["流拍："] .. BG.Frame[BG.FB1]["boss" .. b]["zhuangbei" .. i]:GetText() .. leveltext
                    table.insert(tx_1, text)
                    num = num + 1
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
        local text = L["没有流拍装备"]
        table.insert(tx, text)
    else
        local text
        if type then
            text = format(L["%s 流拍装备一共%s件 %s"], BG.SetRaidTargetingIcons(type, "chacha"), num, BG.SetRaidTargetingIcons(type, "chacha"))
        else
            text = "|cffffffff" .. format(L["%s 流拍装备一共%s件 %s"], BG.SetRaidTargetingIcons(type, "chacha"), num, BG.SetRaidTargetingIcons(type, "chacha"))
        end
        table.insert(tx, text)
    end
    return tx, num
end


function BG.LiuPaiUI(lastbt)
    local bt = CreateFrame("Button", nil, BG.FBMainFrame, "UIPanelButtonTemplate")
    bt:SetSize(90, BG.ButtonZhangDan:GetHeight())
    bt:SetPoint("LEFT", lastbt, "RIGHT", 10, 0)
    bt:SetText(L["通报流拍"])
    bt:Show()
    BG.ButtonLiuPai = bt

    bt:SetScript("OnEnter", function(self)
        if BG.Backing then return end
        local FB = BG.FB1
        local tx = {}
        CreateListTable(nil, tx)

        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0);
        GameTooltip:ClearLines()
        for i, v in ipairs(tx) do
            GameTooltip:AddLine(v)
        end
        GameTooltip:Show()
    end)
    bt:SetScript("OnLeave", function(self)
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
            local tx = {}
            tx = CreateListTable(true, tx)

            local t = 0
            for index, value in ipairs(tx) do
                -- BG.After(t, function()
                SendChatMessage(value, "RAID")
                -- end)
                -- t = t + BG.tongBaoSendCD
            end

            PlaySoundFile(BG.sound2, "Master")
        end
    end)

    return bt
end

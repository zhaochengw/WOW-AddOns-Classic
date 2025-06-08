local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Maxb = ns.Maxb
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID
local BossNum = ns.BossNum

local pt = print

local function CreateListTable(onClick, tbl1)
    local FB = BG.FB1
    local tbl1 = tbl1 or {}
    local tbl2 = {}

    local text = L["———通报流拍装备———"]
    table.insert(tbl1, text)
    table.insert(tbl2, { text })
    local num = 0

    local yes
    for b = 1, Maxb[FB] - 1 do
        local tbl_boss = {}
        for i = 1, BG.GetMaxi(FB, b) do
            if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                if BG.Frame[BG.FB1]["boss" .. b]["zhuangbei" .. i]:GetText() ~= ""
                    and GetItemID(BG.Frame[BG.FB1]["boss" .. b]["zhuangbei" .. i]:GetText())
                    and BG.Frame[BG.FB1]["boss" .. b]["maijia" .. i]:GetText() == ""
                    and BG.Frame[BG.FB1]["boss" .. b]["jine" .. i]:GetText() == "" then
                    local name, link, quality, level, _, _, _, _, _, _, _, typeID = GetItemInfo(BG.Frame[BG.FB1]["boss" .. b]["zhuangbei" .. i]:GetText())
                    local leveltext = ""
                    if typeID == 2 or typeID == 4 then
                        if onClick then
                            leveltext = "(" .. level .. ")"
                        else
                            leveltext = "|cff9370DB(" .. level .. ")"
                        end
                    end
                    local text = L["流拍："] .. BG.Frame[BG.FB1]["boss" .. b]["zhuangbei" .. i]:GetText() .. leveltext
                    table.insert(tbl_boss, text)
                    num = num + 1
                end
            end
        end
        if #tbl_boss ~= 0 then
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
        local text = L["没有流拍装备"]
        table.insert(tbl1, text)
        table.insert(tbl2, { text })
    else
        local text
        if onClick then
            text = format(L["%s 流拍装备一共%s件 %s"], BG.SetRaidTargetingIcons(onClick, "chacha"), num, BG.SetRaidTargetingIcons(onClick, "chacha"))
        else
            text = "|cffffffff" .. format(L["%s 流拍装备一共%s件 %s"], BG.SetRaidTargetingIcons(onClick, "chacha"), num, BG.SetRaidTargetingIcons(onClick, "chacha"))
        end
        table.insert(tbl1, text)
        table.insert(tbl2, { text })
    end
    return tbl1, tbl2, num
end


function BG.LiuPaiUI(lastbt)
    local bt = BG.CreateButton(BG.ButtonZhangDan)
    bt:SetSize(BG.ButtonZhangDan:GetWidth(), BG.ButtonZhangDan:GetHeight())
    bt:SetPoint("LEFT", lastbt, "RIGHT", BG.ButtonZhangDan.jiange, 0)
    bt:SetText(L["流拍"])
    BG.ButtonLiuPai = bt
    tinsert(BG.TongBaoButtons, bt)

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
        GameTooltip:SetClampedToScreen(false)
    end)
    bt:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        GameTooltip:SetClampedToScreen(true)
    end)

    bt:SetScript("OnClick", function(self)
        BG.FrameHide(0)
        if not IsInRaid(1) then
            SendSystemMessage(L["不在团队，无法通报"])
            BG.PlaySound(1)
        else
            self:SetEnabled(false) 
            C_Timer.After(2, function()
                bt:SetEnabled(true)
            end)
            local _, tbl = CreateListTable(true)
            BG.SendMsgToRaid(tbl)

            BG.PlaySound(2)
        end
    end)

    return bt
end

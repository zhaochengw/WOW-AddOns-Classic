local AddonName, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local Size = ADDONSELF.Size
local FrameHide = ADDONSELF.FrameHide
local SetClassCFF = ADDONSELF.SetClassCFF
local RGB_16 = ADDONSELF.RGB_16

local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

local pt = print

------------------函数：通报欠款-----------------
local function CreateListTable(onClick, tbl1)
    local alltable = {}
    local maijiatable = {}
    local sumtable = {}
    local FB = BG.FB1
    for b = 1, Maxb[FB] do
        for i = 1, Maxi[FB] do
            if BG.Frame[FB]["boss" .. b]["qiankuan" .. i] then
                if BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
                    local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetText() == "" and L["没记买家"]
                        or BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetText()
                    local q = {
                        zhuangbei = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:GetText(),
                        maijia = maijia,
                        color = { BG.Frame[FB]["boss" .. b]["maijia" .. i]:GetTextColor() },
                        qiankuan = tonumber(BiaoGe[FB]["boss" .. b]["qiankuan" .. i])
                    }
                    tinsert(alltable, q)
                    -- 单独保存买家名字
                    maijiatable[maijia] = true
                end
            end
        end
    end
    for maijia, _ in pairs(maijiatable) do
        local sum = 0
        local color
        for i, v in ipairs(alltable) do
            if maijia == v.maijia then
                sum = v.qiankuan + sum
                color = v.color
            end
        end
        local s = { maijia = maijia, color = color, qiankuan = sum }
        tinsert(sumtable, s)
    end
    sort(sumtable, function(a, b)
        if a.qiankuan > b.qiankuan then
            return true
        end
        return false
    end)

    -- 开始
    local tbl1 = tbl1 or {}
    local tbl2 = {}
    local text = L["————通报欠款————"]
    table.insert(tbl1, text)
    table.insert(tbl2, { text })

    if #alltable ~= 0 then
        local tbl_boss = {}
        for i, v in ipairs(alltable) do
            if onClick then
                text = L["欠款："] .. v.zhuangbei .. " " .. v.maijia .. " " .. v.qiankuan
            else
                text = L["欠款："] .. v.zhuangbei .. " " .. RGB_16(v.maijia, unpack(v.color)) .. " |cffFF0000" .. v.qiankuan .. RR
            end
            table.insert(tbl1, text)
            table.insert(tbl_boss, text)
        end
        table.insert(tbl2, tbl_boss)

        for i, v in ipairs(sumtable) do
            if onClick then
                text = L["合计欠款："] .. v.maijia .. " " .. v.qiankuan
            else
                text = L["合计欠款："] .. RGB_16(v.maijia, unpack(v.color)) .. " |cffFF0000" .. v.qiankuan .. RR
            end
            table.insert(tbl1, text)
            table.insert(tbl2, { text })
        end
    else
        local text = L["没有欠款"]
        table.insert(tbl1, text)
        table.insert(tbl2, { text })
    end
    return tbl1, tbl2
end


function BG.QianKuanUI(lastbt)
    local bt = CreateFrame("Button", nil,BG.ButtonZhangDan, "UIPanelButtonTemplate")
    bt:SetSize(90, BG.ButtonZhangDan:GetHeight())
    bt:SetPoint("LEFT", lastbt, "RIGHT", 10, 0)
    bt:SetText(L["通报欠款"])
    BG.ButtonQianKuan = bt
    tinsert(BG.TongBaoButtons,bt)

    bt:SetScript("OnEnter", function(self)
        if BG.Backing then return end
        local tx = CreateListTable(nil)

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
    -- 单击触发
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

            local _, tbl = CreateListTable(true)
            BG.SendMsgToRaid(tbl)

            PlaySoundFile(BG.sound2, "Master")
        end
    end)

    return bt
end

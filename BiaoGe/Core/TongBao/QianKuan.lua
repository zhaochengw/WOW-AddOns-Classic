local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local SetClassCFF = ns.SetClassCFF
local RGB_16 = ns.RGB_16

local Maxb = ns.Maxb
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print

------------------函数：通报欠款-----------------
local function CreateListTable(onClick, tbl1)
    local alltable = {}
    local maijiatable = {}
    local sumtable = {}
    local allsum = 0
    local FB = BG.FB1
    for b = 1, Maxb[FB] do
        for i = 1, BG.Maxi do
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
    for i, v in ipairs(alltable) do
        allsum = v.qiankuan + allsum
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
    local text = L["———通报欠款———"]
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

        if onClick then
            text = L["总欠款："] .. allsum
        else
            text = L["总欠款："] .. " |cffFF0000" .. allsum .. RR
        end
        table.insert(tbl1, text)
        table.insert(tbl2, { text })
    else
        local text = L["没有欠款"]
        table.insert(tbl1, text)
        table.insert(tbl2, { text })
    end
    return tbl1, tbl2
end


function BG.QianKuanUI(lastbt)
    local bt=BG.CreateButton(BG.ButtonZhangDan)
    bt:SetSize(BG.ButtonZhangDan:GetWidth(), BG.ButtonZhangDan:GetHeight())
    bt:SetPoint("LEFT", lastbt, "RIGHT", BG.ButtonZhangDan.jiange, 0)
    bt:SetText(L["欠款"])
    BG.ButtonQianKuan = bt
    tinsert(BG.TongBaoButtons, bt)

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
        BG.FrameHide(0)
        if not IsInRaid(1) then
            SendSystemMessage(L["不在团队，无法通报"])
            BG.PlaySound(1)
        else
            self:SetEnabled(false) -- 点击后按钮变灰2秒
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

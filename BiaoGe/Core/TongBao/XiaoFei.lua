local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local FrameHide = ns.FrameHide
local SetClassCFF = ns.SetClassCFF
local RGB_16 = ns.RGB_16

local Maxb = ns.Maxb
local Maxi = ns.Maxi
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print

------------------函数：通报消费排名-----------------
local function CreateListTable(onClick, tbl1)
    local alltable = {}
    local newtable = {}
    local FB = BG.FB1
    for b = 1, Maxb[FB] do
        for i = 1, Maxi[FB] do
            local maijia = BG.Frame[FB]["boss" .. b]["maijia" .. i]
            local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
            if maijia then
                local maijiaText = maijia:GetText()
                local jineText = jine:GetText()
                if maijiaText ~= "" and tonumber(jineText) and tonumber(jineText) ~= 0 then
                    if not alltable[maijiaText] then
                        alltable[maijiaText] = {
                            maijia = maijiaText,
                            color = { maijia:GetTextColor() },
                            jine = tonumber(jineText),
                        }
                    else
                        alltable[maijiaText].jine = alltable[maijiaText].jine + tonumber(jineText)
                    end
                end
            end
        end
    end
    for k, v in pairs(alltable) do
        tinsert(newtable, v)
    end

    sort(newtable, function(a, b)
        if a.jine > b.jine then
            return true
        end
        return false
    end)

    -- 开始
    local tbl1 = tbl1 or {}
    local tbl2 = {}
    local text = L["———通报消费排名———"]
    table.insert(tbl1, text)
    table.insert(tbl2, { text })

    if #newtable ~= 0 then
        for i, v in ipairs(newtable) do
            if onClick then
                text = i .. ". " .. v.maijia .. " " .. v.jine
            else
                text = i .. ". " .. RGB_16(v.maijia, unpack(v.color)) .. " " .. v.jine
            end
            table.insert(tbl1, text)
            table.insert(tbl2, { text })
        end
    else
        local text = L["没有消费记录"]
        table.insert(tbl1, text)
        table.insert(tbl2, { text })
    end
    return tbl1, tbl2
end


function BG.XiaoFeiUI(lastbt)
    local bt = CreateFrame("Button", nil, BG.ButtonZhangDan, "UIPanelButtonTemplate")
    bt:SetSize(90, BG.ButtonZhangDan:GetHeight())
    bt:SetPoint("LEFT", lastbt, "RIGHT", 10, 0)
    bt:SetText(L["通报消费"])
    BG.ButtonXiaoFei = bt
    tinsert(BG.TongBaoButtons, bt)
    -- 鼠标悬停提示
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
    -- 点击通报消费排名
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

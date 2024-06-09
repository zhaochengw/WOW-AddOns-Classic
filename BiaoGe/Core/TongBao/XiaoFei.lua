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

------------------函数：通报消费排名-----------------
local function CreateListTable(type, tx)
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
    local tx = tx or {}
    local text = L["———通报消费排名———"]
    table.insert(tx, text)

    if #newtable ~= 0 then
        for i, v in ipairs(newtable) do
            if type then
                text = i .. ". " .. v.maijia .. " " .. v.jine
            else
                text = i .. ". " .. RGB_16(v.maijia, unpack(v.color)) .. " " .. v.jine
            end
            table.insert(tx, text)
        end
    else
        local text = L["没有消费记录"]
        table.insert(tx, text)
    end
    return tx
end


function BG.XiaoFeiUI(lastbt)
    local bt = CreateFrame("Button", nil, BG.FBMainFrame, "UIPanelButtonTemplate")
    bt:SetSize(90, BG.ButtonZhangDan:GetHeight())
    bt:SetPoint("LEFT", lastbt, "RIGHT", 10, 0)
    bt:SetText(L["通报消费"])
    bt:Show()
    BG.ButtonXiaoFei = bt
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
    end)
    bt:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
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

            local tx = CreateListTable(true)
            for index, value in ipairs(tx) do
                SendChatMessage(value, "RAID")
            end

            PlaySoundFile(BG.sound2, "Master")
        end
    end)

    return bt
end

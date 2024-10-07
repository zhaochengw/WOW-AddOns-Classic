local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local FrameHide = ns.FrameHide
local SetClassCFF = ns.SetClassCFF
local RGB_16 = ns.RGB_16
local RGB = ns.RGB
local AddTexture = ns.AddTexture

local Maxb = ns.Maxb
local Maxi = ns.Maxi
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print

local funcTbl = { BG.GetTotalIncome, BG.GetTotalExpenditure, BG.GetNetIncome }
local function CreateListTable(onClick, tbl)
    local tbl = tbl or {}
    local db = { 0, 0, 0 }
    local text = L["——通报多本总览账单——"]
    table.insert(tbl, { text })

    for i, bt in ipairs(BG.FrameZhangDanSum.buttons) do
        if bt:GetChecked() then
            local FB = bt.FB
            local FBlocalName = BG.GetFBinfo(FB, "localName")

            local b = Maxb[FB] + 2
            for i = 1, 2 do
                local zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                local text
                if onClick then
                    text = FBlocalName .. " " .. zb:GetText() .. L["："] .. funcTbl[i](FB)
                else
                    text = "|cffF58CBA" .. FBlocalName .. " " .. zb:GetText() .. L["："] .. funcTbl[i](FB) .. RN
                end
                table.insert(tbl, { text })
                db[i] = db[i] + (tonumber(funcTbl[i](FB)) or 0)
            end
            db[3] = db[3] + (tonumber(funcTbl[3](FB)) or 0)
        end
    end

    local FB = BG.FB1
    db[4] = tonumber(BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. 4]:GetText()) or 0
    local gz
    if BiaoGe.options["moLing"] == 1 then
        gz = math.modf(db[3] / db[4])
    else
        gz = format("%.2f", db[3] / db[4])
    end
    db[5] = gz
    db[6] = db[5] * 5

    if onClick then
        text = format(L["< 总 %s 览 >"], BG.SetRaidTargetingIcons(onClick, "ziling"))
    else
        text = "|cffffffff" .. format(L["< 总 %s 览 >"], BG.SetRaidTargetingIcons(onClick, "ziling")) .. RN
    end
    table.insert(tbl, { text })

    for i = 1, 3 do
        local zb = BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. i]
        local text
        if onClick then
            text = zb:GetText() .. L["："] .. db[i]
        else
            text = "|cffEE82EE" .. zb:GetText() .. L["："] .. db[i] .. RN
        end
        table.insert(tbl, { text })
    end

    local text
    if onClick then
        text = format(L["< 工 %s 资 >"], BG.SetRaidTargetingIcons(onClick, "fangkuai"))
    else
        text = "|cffffffff" .. format(L["< 工 %s 资 >"], BG.SetRaidTargetingIcons(onClick, "fangkuai")) .. RN
    end
    table.insert(tbl, { text })


    local zb = BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. 4]
    local jine = BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine" .. 4]
    local text
    if onClick then
        text = zb:GetText() .. L["："] .. jine:GetText() .. L["人"]
    else
        text = "|cff00BFFF" .. zb:GetText() .. L["："] .. jine:GetText() .. L["人"] .. RN
    end
    table.insert(tbl, { text })

    local zb = BG.Frame[FB]["boss" .. Maxb[FB] + 2]["zhuangbei" .. 5]
    local text
    if onClick then
        text = zb:GetText() .. L["："] .. db[5]
    else
        text = "|cff00BFFF" .. zb:GetText() .. L["："] .. db[5] .. RN
    end
    table.insert(tbl, { text })

    local text
    if onClick then
        text = db[5] .. " x 5 = " .. db[6]
    else
        text = "|cff00BFFF" .. db[5] .. " x 5 = " .. db[6] .. RN
    end
    table.insert(tbl, { text })

    return tbl
end

function BG.ZhangDanSumUI(lastbt)
    local bt = CreateFrame("Button", nil, BG.ButtonZhangDan, "UIPanelButtonTemplate")
    bt:SetSize(BG.ButtonZhangDan:GetWidth(), BG.ButtonZhangDan:GetHeight())
    bt:SetPoint("LEFT", lastbt, "RIGHT", 10, 0)
    bt:SetText(L["多本账单"])
    BG.ButtonZhangDanSum = bt
    tinsert(BG.TongBaoButtons, bt)

    local texture = bt:CreateTexture(nil, "BACKGROUND", nil, -7) -- 高亮材质
    texture:SetPoint("CENTER")
    texture:SetSize(bt:GetWidth() + 15, bt:GetHeight() + 10)
    texture:SetTexture("Interface/ChatFrame/UI-ChatIcon-BlinkHilight")

    bt:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:ClearLines()
        GameTooltip:AddLine(L["通报多本总览账单"], 1, 0.82, 0, true)
        GameTooltip:AddLine(L["|cffFFFFFF点击：|r显示选项面板。"], 1, 0.82, 0, true)
        GameTooltip:Show()
    end)
    bt:SetScript("OnLeave", GameTooltip_Hide)
    bt:SetScript("OnClick", function()
        BG.PlaySound(1)
        if BG.FrameZhangDanSum:IsVisible() then
            BG.FrameZhangDanSum:Hide()
        else
            BG.FrameZhangDanSum:Show()
        end
    end)

    local f = CreateFrame("Frame", nil, bt, "BackdropTemplate")
    do
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 10,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.9)
        f:SetWidth(180)
        f:SetPoint("BOTTOM", bt, "TOP", 0, 0)
        f:EnableMouse(true)
        f:SetFrameLevel(130)
        f.first = true
        f.timeElapsed = 0
        f:Hide()
        BiaoGeTooltip4:SetParent(f)
        BG.FrameZhangDanSum = f
        f:SetScript("OnShow", function(self)
            if self.first then
                self.first = false
                BG.UpdateFrameZhangDanSum_CheckButtons()
            end
            GameTooltip:Hide()
            BG.UpdateFrameZhangDanSum_GameTooltip()

            self:SetScript("OnUpdate", function(self, timeElapsed)
                self.timeElapsed = self.timeElapsed + timeElapsed
                if self.timeElapsed >= 0.2 then
                    self.timeElapsed = 0
                    BG.UpdateFrameZhangDanSum_GameTooltip()
                end
            end)
        end)
        f:SetScript("OnHide", function(self)
            self:SetScript("OnUpdate", nil)
        end)

        local t = f:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("TOPLEFT", f, 10, -10)
        t:SetTextColor(RGB("FFD100"))
        t:SetText(L["请选择需要通报哪些总览账单？"])
        t:SetWidth(f:GetWidth() - 30)
        t:SetJustifyH("LEFT")

        f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
        f.CloseButton:SetPoint("TOPRIGHT", f, "TOPRIGHT", 2, 2)

        f.buttons = {}
        for i, FB in ipairs(BG.FBtable) do
            local bt = CreateFrame("CheckButton", nil, f, "ChatConfigCheckButtonTemplate")
            bt:SetSize(25, 25)
            if i == 1 then
                bt:SetPoint("TOPLEFT", t, "BOTTOMLEFT", 0, -5)
            else
                bt:SetPoint("TOPLEFT", f.buttons[i - 1], "BOTTOMLEFT", 0, -0)
            end
            bt.FB = FB
            bt.name = BG.GetFBinfo(FB, "localName")
            bt.ID = BG.GetFBinfo(FB, "ID")
            bt.Text:SetText(bt.name)
            bt:SetHitRectInsets(0, -bt.Text:GetWidth(), 0, 0)
            bt.Text:SetWidth(f:GetWidth() - 30)
            bt.Text:SetWordWrap(false)
            tinsert(f.buttons, bt)
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                BG.UpdateFrameZhangDanSum_GameTooltip()
            end)
        end

        local bt = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        bt:SetSize(100, 25)
        bt:SetPoint("BOTTOM", 0, 10)
        bt:SetText(L["通报"])
        f.SureButton = bt
        bt:SetScript("OnClick", function(self)
            FrameHide(0)
            if not IsInRaid(1) then
                SendSystemMessage(L["不在团队，无法通报"])
                BG.PlaySound(1)
            else
                local isChoose
                for i, bt in ipairs(BG.FrameZhangDanSum.buttons) do
                    if bt:GetChecked() then
                        isChoose = true
                        break
                    end
                end
                if isChoose then
                    self:Disable()
                    C_Timer.After(2, function()
                        self:Enable()
                    end)

                    local tbl = CreateListTable(true)
                    local t = BG.SendMsgToRaid(tbl)

                    BG.After(t, function()
                        local text = L["—感谢使用BiaoGe插件—"]
                        SendChatMessage(text, "RAID")
                    end)
                    BG.PlaySound(2)
                else
                    BG.SendSystemMessage(L["请选择一个账单。"])
                    BG.PlaySound(1)
                end
            end
        end)

        f:SetHeight(#BG.FBtable * 25 + t:GetHeight() + 50)
    end

    function BG.UpdateFrameZhangDanSum_GameTooltip()
        if not BG.FrameZhangDanSum:IsVisible() then return end
        local isChoose
        for i, bt in ipairs(BG.FrameZhangDanSum.buttons) do
            if bt:GetChecked() then
                isChoose = true
                break
            end
        end
        if isChoose then
            local tbl = CreateListTable()
            BiaoGeTooltip4:SetOwner(BG.FrameZhangDanSum, "ANCHOR_NONE")
            BiaoGeTooltip4:SetPoint("BOTTOMLEFT", BG.FrameZhangDanSum, "BOTTOMRIGHT", 0, 0)
            BiaoGeTooltip4:ClearLines()
            for ii, vv in ipairs(tbl) do
                for i, v in ipairs(tbl[ii]) do
                    BiaoGeTooltip4:AddLine(v)
                end
            end
            BiaoGeTooltip4:Show()
            BiaoGeTooltip4:SetClampedToScreen(false)
        else
            BiaoGeTooltip4:Hide()
        end
    end

    function BG.UpdateFrameZhangDanSum_CheckButtons()
        for i, bt in ipairs(BG.FrameZhangDanSum.buttons) do
            if BG.IsVanilla_60 then
                if bt.FB == BG.FB1 then
                    bt:SetChecked(true)
                end
            else
                for _, FB in ipairs(BG.phaseFBtable[BG.FB1]) do
                    if bt.FB == FB then
                        bt:SetChecked(true)
                    end
                end
            end
        end
    end

    return bt
end

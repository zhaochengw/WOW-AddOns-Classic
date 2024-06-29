local AddonName, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local RGB_16 = ADDONSELF.RGB_16
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local GetText_T = ADDONSELF.GetText_T
local FrameDongHua = ADDONSELF.FrameDongHua
local FrameHide = ADDONSELF.FrameHide
local AddTexture = ADDONSELF.AddTexture
local GetItemID = ADDONSELF.GetItemID

local Width = ADDONSELF.Width
local Height = ADDONSELF.Height
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

local pt = print
local RealmId = GetRealmID()
local player = UnitName("player")

BG.RegisterEvent("ADDON_LOADED", function(self, event, addonName)
    if addonName ~= AddonName then return end

    local bt = CreateFrame("Button", nil, BG.MainFrame)
    do
        bt:SetPoint("LEFT", BG.ButtonAucitonWA, "RIGHT", BG.TopLeftButtonJianGe, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(AddTexture("QUEST") .. L["上传到新手盒子"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        BG.ButtonNewBee = bt
        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(L["把本次活动的账单上传到新手盒子，用于日后总结与回顾。"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", GameTooltip_Hide)
        bt:SetScript("OnClick", function()
            BG.PlaySound(1)
            if BG.FrameNewBee:IsVisible() then
                BG.FrameNewBee:Hide()
            else
                BG.FrameNewBee:Show()
            end
        end)
        bt:Hide()
    end

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
        f:SetPoint("TOPLEFT", bt, "BOTTOMLEFT", 0, 0)
        f:EnableMouse(true)
        f:SetFrameLevel(130)
        f.first = true
        f:Hide()
        BG.FrameNewBee = f
        f:SetScript("OnShow", function(self)
            if self.first then
                self.first = false
                BG.UpdateFrameNewBee_CheckButtons()
            end
            BG.UpdateFrameNewBee_SureButton()
        end)

        local t = f:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("TOPLEFT", f, 10, -10)
        t:SetTextColor(RGB("FFD100"))
        t:SetText(L["请选择需要上传哪些账单？"])
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
                BG.UpdateFrameNewBee_SureButton()
            end)
        end

        local bt = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        bt:SetSize(100, 25)
        bt:SetPoint("BOTTOM", 0, 10)
        bt:SetText(L["上传账单"])
        f.SureButton = bt
        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L[""], 1, 1, 1, true)
            GameTooltip:AddLine(L[""], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", GameTooltip_Hide)
        bt:SetScript("OnClick", function(self)
            BG.PlaySound(1)
            BG.CreateNewBeeReport()
        end)

        f:SetHeight(#BG.FBtable * 25 + t:GetHeight() + 50)
    end


    function BG.UpdateFrameNewBee_SureButton()
        local isChoose
        for i, bt in ipairs(BG.FrameNewBee.buttons) do
            if bt:GetChecked() then
                isChoose = true
                break
            end
        end
        if isChoose then
            BG.FrameNewBee.SureButton:Enable()
        else
            BG.FrameNewBee.SureButton:Disable()
        end
    end

    function BG.UpdateFrameNewBee_CheckButtons()
        for i, bt in ipairs(BG.FrameNewBee.buttons) do
            if BG.IsVanilla_60() then
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

    local function GetEncounterID(bossNum, FB)
        local FB = FB or BG.FB1
        if BG.Loot.encounterID[FB] then
            for encounterID, _bossNum in pairs(BG.Loot.encounterID[FB]) do
                if _bossNum == bossNum then
                    return encounterID
                end
            end
        end
    end

    function BG.CreateNewBeeReport()
        wipe(BiaoGe.newbee_report)
        -- 时间戳
        BiaoGe.newbee_report.time = time()
        -- 副本ID
        BiaoGe.newbee_report.instanceIDs = {}
        for i, bt in ipairs(BG.FrameNewBee.buttons) do
            if bt:GetChecked() then
                tinsert(BiaoGe.newbee_report.instanceIDs, bt.ID)
            end
        end
        -- 团长
        BiaoGe.newbee_report.raidLeader = {}
        if IsInRaid(1) then
            for i = 1, GetNumGroupMembers() do
                local name, rank, subgroup, level, classlocalized, class, zone,
                online, isDead, role, isML, combatRole = GetRaidRosterInfo(i)
                if name then
                    local name, realm = strsplit("-", name)
                    if not realm then realm = GetRealmName() end
                    local unit = "raid" .. i
                    if rank == 2 then
                        BiaoGe.newbee_report.raidLeader.name = name
                        for k, v in pairs(BG.playerClass) do
                            BiaoGe.newbee_report.raidLeader[k] = select(v.select, v.func(unit))
                        end
                        break
                    end
                end
            end
        end
        -- 上传者
        local unit = "player"
        BiaoGe.newbee_report.uploader = {}
        BiaoGe.newbee_report.uploader.name = UnitName(unit) -- 玩家名字
        for k, v in pairs(BG.playerClass) do
            BiaoGe.newbee_report.uploader[k] = select(v.select, v.func(unit))
        end
        -- 账单
        BiaoGe.newbee_report.ledger = {}
        for i, instanceID in ipairs(BiaoGe.newbee_report.instanceIDs) do
            local FB
            for i, v in ipairs(BG.FBtable2) do
                if v.ID == instanceID then
                    FB = v.FB
                    break
                end
            end
            local tbl = {}
            tbl.instanceID = instanceID
            tbl.instanceName = GetRealZoneText(instanceID)
            tbl.lockoutID = BiaoGe[FB].lockoutID

            for b = 1, Maxb[FB] + 2 do
                local name
                if b <= Maxb[FB] - 2 then
                    local encounterID = GetEncounterID(b, FB)
                    name = "boss:" .. encounterID
                elseif b == Maxb[FB] - 1 then
                    name = "otherItem"
                elseif b == Maxb[FB] then
                    name = "penalty"
                elseif b == Maxb[FB] + 1 then
                    name = "expenses"
                elseif b == Maxb[FB] + 2 then
                    name = "summary"
                end
                if name then
                    tbl[name] = {}
                    for i = 1, Maxi[FB] do
                        local zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                        local mj = BG.Frame[FB]["boss" .. b]["maijia" .. i]
                        local je = BG.Frame[FB]["boss" .. b]["jine" .. i]

                        if zb then
                            if b == Maxb[FB] + 1 and je:GetText() ~= "" or
                                (b ~= Maxb[FB] + 1 and (zb:GetText() ~= "" or mj:GetText() ~= "" or je:GetText() ~= ""))
                            then
                                local item = BiaoGe[FB]["boss" .. b]["zhuangbei" .. i]
                                local itemID = item and GetItemID(item) or nil
                                local buyer = BiaoGe[FB]["boss" .. b]["maijia" .. i]
                                local money = BiaoGe[FB]["boss" .. b]["jine" .. i]

                                local a = {
                                    item = item,
                                    itemID = itemID,
                                    buyer = {
                                        name = buyer,
                                    },
                                    money = money,
                                }
                                for k, v in pairs(BG.playerClass) do
                                    a.buyer[k] = BiaoGe[FB]["boss" .. b][k .. i]
                                end
                                tinsert(tbl[name], a)
                            end
                        end
                    end
                end
            end
            tinsert(BiaoGe.newbee_report.ledger, tbl)
        end

        BG.SendSystemMessage(format(L["账单已上传！"]))
    end
end)

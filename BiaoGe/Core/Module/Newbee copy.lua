if not BG.IsWLK then return end

local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local RGB_16 = ns.RGB_16
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local GetText_T = ns.GetText_T
local FrameDongHua = ns.FrameDongHua
local FrameHide = ns.FrameHide
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local Width = ns.Width
local Height = ns.Height
local Maxb = ns.Maxb
local Maxi = ns.Maxi
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print
local RealmId = GetRealmID()
local player = UnitName("player")

local UPLOADTIME = 30

BG.RegisterEvent("ADDON_LOADED", function(self, event, addonName)
    if addonName ~= AddonName then return end

    BiaoGe.newbee_report = BiaoGe.newbee_report or {}
    BiaoGe.newbee_report_notuploaded = BiaoGe.newbee_report_notuploaded or {}


    local textTbl, buttonTbl

    local function GetEncounterID(bossNum)
        local FB = BG.FB1
        if BG.Loot.encounterID[FB] then
            for _bossNum, encounterID in ipairs(BG.Loot.encounterID[FB]) do
                if _bossNum == bossNum then
                    return encounterID
                end
            end
        end
    end
    local function UpdateButonUpload()
        if Size(BiaoGe.newbee_report_notuploaded) == 0 then
            BG.FrameNewBee.ButtonUpload:Disable()
        else
            BG.FrameNewBee.ButtonUpload:Enable()
        end
    end
    local function UpdateButonLoot()
        if Size(BiaoGe.newbee_report) == 0 and Size(BiaoGe.newbee_report_notuploaded) == 0 then
            BG.FrameNewBee.ButtonLoot:Disable()
            BG.FrameNewBee.ButtonDelete:Disable()
        else
            BG.FrameNewBee.ButtonLoot:Enable()
            BG.FrameNewBee.ButtonDelete:Enable()
        end
    end
    local function UpdateFrameNewBeeText()
        local db, uploadstateText
        if Size(BiaoGe.newbee_report) ~= 0 then
            db = BiaoGe.newbee_report
            if BiaoGe.newbee_report.uploadstate == 0 then
                uploadstateText = L["正在上传"]
            else
                uploadstateText = L["已上传"]
            end
        else
            db = BiaoGe.newbee_report_notuploaded
            if Size(BiaoGe.newbee_report_notuploaded) ~= 0 then
                uploadstateText = L["未上传"]
            else
                uploadstateText = L["无"]
            end
        end
        local FB = db.biaoge
        local time = db.time
        local name = db.uploader and db.uploader.name or nil
        local color = db.uploader and db.uploader.color or nil
        local raidleader = db.raidLeader and db.raidLeader.name or nil
        local raidleadercolor = db.raidLeader and db.raidLeader.color or nil

        local t = BG.FrameNewBee.Textbiaoge
        if FB then
            t:SetText(t.text .. (BG.GetFBinfo(FB, "localName") or L["无"]))
        else
            t:SetText(t.text .. L["无"])
        end

        local t = BG.FrameNewBee.TextcreateTimeText
        if time then
            local d = date("*t", time)
            d = strsub(d.year, 3) .. "/" .. d.month .. "/" .. d.day .. " " .. format("%02d", d.hour) .. ":" .. format("%02d", d.min)
            t:SetText(t.text .. d)
        else
            t:SetText(t.text .. L["无"])
        end

        local t = BG.FrameNewBee.TextcreateManText
        if name then
            t:SetText(t.text .. name)
        else
            t:SetText(t.text .. L["无"])
        end
        if color then
            t:SetTextColor(unpack(color))
        else
            t:SetTextColor(1, 1, 1)
        end

        local t = BG.FrameNewBee.TextcheckText
        if raidleader then
            t:SetText(t.text .. raidleader)
        else
            t:SetText(t.text .. L["无"])
        end
        if raidleadercolor then
            t:SetTextColor(unpack(raidleadercolor))
        else
            t:SetTextColor(1, 1, 1)
        end

        local t = BG.FrameNewBee.TextuploadText
        t:SetText(t.text .. uploadstateText)
        if uploadstateText == L["未上传"] then
            t:SetTextColor(1, 0, 0)
        elseif uploadstateText == L["正在上传"] or uploadstateText == L["无"] then
            t:SetTextColor(1, 1, 1)
        elseif uploadstateText == L["已上传"] then
            t:SetTextColor(0, 1, 0)
        end
        UpdateButonLoot()
        UpdateButonUpload()
    end
    local function CreateNewBeeLoot()
        local db
        if Size(BiaoGe.newbee_report) ~= 0 then
            db = BiaoGe.newbee_report
        else
            db = BiaoGe.newbee_report_notuploaded
        end

        BG.FrameNewBee.lootFrameChild:SetText("")

        local FB = db.biaoge
        if db.ledger then
            for ii, vv in ipairs(db.ledger) do
                local bossNum
                if vv.instanceID then
                    for num, encounterID in ipairs(BG.Loot.encounterID[FB]) do
                        if encounterID == vv.encounterID then
                            bossNum = num
                            break
                        end
                    end
                else
                    if vv.type == "otherItem" then
                        bossNum = Maxb[FB] - 1
                    elseif vv.type == "penalty" then
                        bossNum = Maxb[FB]
                    elseif vv.type == "expenses" then
                        bossNum = Maxb[FB] + 1
                    elseif vv.type == "summary" then
                        bossNum = Maxb[FB] + 2
                    end
                end
                local text = BG.Boss[FB]["boss" .. bossNum].name2
                local color = BG.Boss[FB]["boss" .. bossNum].color
                text = "|cff" .. color .. text .. RR
                BG.FrameNewBee.lootFrameChild:Insert(text .. NN)
                if vv.lockoutID then
                    local text = BG.STC_dis(L["团本锁定ID"] .. " " .. vv.lockoutID)
                    BG.FrameNewBee.lootFrameChild:Insert(text .. NN)
                elseif vv.instanceID then
                    local text = BG.STC_r1(L["团本锁定ID"] .. " " .. L["无"])
                    BG.FrameNewBee.lootFrameChild:Insert(text .. NN)
                end
                for i, v in pairs(db.ledger[ii]) do
                    if type(v) == "table" then
                        local item = v.item or ""
                        local buyer = v.buyer.name or ""
                        if v.buyer.color then
                            buyer = "|cff" .. RGB_16(nil, v.buyer.color[1], v.buyer.color[2], v.buyer.color[3]) .. buyer .. RR
                        end
                        local money = v.money or ""
                        local text = item .. " " .. buyer .. " " .. money
                        BG.FrameNewBee.lootFrameChild:Insert(text .. NN)
                    end
                end
                BG.FrameNewBee.lootFrameChild:Insert(NN)
            end
            local text = BG.FrameNewBee.lootFrameChild:GetText()
            text = strsub(text, 1, -2)
            BG.FrameNewBee.lootFrameChild:SetText(text)

            if BG.FrameNewBee.lootFrame.isFirst then
                BG.FrameNewBee.lootFrame.isFirst = false
                BG.After(0, function()
                    BG.SetScrollBottom(BG.FrameNewBee.lootFrameScroll, BG.FrameNewBee.lootFrameChild)
                end)
            end
        end
    end
    local function CreateNewBeeReport()
        if BG.FrameNewBee.onUpdate then
            BG.FrameNewBee.onUpdate:SetScript("OnUpdate", nil)
            BG.FrameNewBee.onUpdate:Hide()
        end
        wipe(BiaoGe.newbee_report_notuploaded)
        wipe(BiaoGe.newbee_report)
        -- 时间戳
        BiaoGe.newbee_report_notuploaded.time = GetServerTime()
        -- 表格
        BiaoGe.newbee_report_notuploaded.biaoge = BG.FB1
        -- 团长
        BiaoGe.newbee_report_notuploaded.raidLeader = {}
        if IsInRaid(1) then
            for i = 1, GetNumGroupMembers() do
                local name, rank, subgroup, level, classlocalized, class, zone,
                online, isDead, role, isML, combatRole = GetRaidRosterInfo(i)
                if name then
                    local name, realm = strsplit("-", name)
                    if not realm then realm = GetRealmName() end
                    local unit = "raid" .. i
                    if rank == 2 then
                        BiaoGe.newbee_report_notuploaded.raidLeader.name = name
                        for k, v in pairs(BG.playerClass) do
                            BiaoGe.newbee_report_notuploaded.raidLeader[k] = select(v.select, v.func(unit))
                        end
                        break
                    end
                end
            end
        end
        -- 上传者2
        local unit = "player"
        BiaoGe.newbee_report_notuploaded.uploader = {}
        BiaoGe.newbee_report_notuploaded.uploader.name = UnitName(unit) -- 玩家名字
        for k, v in pairs(BG.playerClass) do
            BiaoGe.newbee_report_notuploaded.uploader[k] = select(v.select, v.func(unit))
        end
        -- 账单
        BiaoGe.newbee_report_notuploaded.ledger = {}
        local FB = BG.FB1
        for b = 1, Maxb[FB] + 2 do
            local name
            if b <= Maxb[FB] - 2 then
                name = "boss"
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
                local tbl = {}
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
                            local packTrade = BG.GetGeZiTardeInfo(FB, b, i) and true or nil

                            local a = {
                                item = item,
                                itemID = itemID,
                                buyer = {
                                    name = buyer,
                                },
                                money = money,
                                packTrade = packTrade
                            }
                            for k, v in pairs(BG.playerClass) do
                                a.buyer[k] = BiaoGe[FB]["boss" .. b][k .. i]
                            end
                            tinsert(tbl, a)
                        end
                    end
                end

                if #tbl > 0 then
                    tbl.type = name
                    tbl.encounterID = GetEncounterID(b)

                    local instanceID = BG.instanceIDfromBossPosition[FB][b]
                    local lockoutID
                    if instanceID and BiaoGe[FB].lockoutIDtbl and BiaoGe[FB].lockoutIDtbl[instanceID] then
                        lockoutID = BiaoGe[FB].lockoutIDtbl[instanceID].lockoutID
                    end
                    tbl.instanceID = instanceID
                    tbl.lockoutID = lockoutID

                    tinsert(BiaoGe.newbee_report_notuploaded.ledger, tbl)
                end
            end
        end

        UpdateFrameNewBeeText()

        if BG.FrameNewBee.lootFrame:IsVisible() then
            CreateNewBeeLoot()
        end
    end

    textTbl = {
        { text = BG.STC_y2(L["账单表格："]), name2 = "biaoge" },
        { text = BG.STC_y2(L["创建时间："]), name2 = "createTimeText" },
        { text = BG.STC_y2(L["创建人："]), name2 = "createManText" },
        { text = BG.STC_y2(L["团长："]), name2 = "checkText" },
        { text = BG.STC_y2(L["上传状态："]), name2 = "uploadText" },
    }
    buttonTbl = {
        {
            name = L["创建账单"],
            name2 = "Create",
            onEnter = {
                L["使用当前表格的数据创建一个账单，用于上传新手盒子。"],
                L["每件装备的拍卖价格也将有助于新手盒子建立市场平均价，使其他玩家更了解市场行情。"],
                -- L["该账单可随时在新手盒子中查看。而每件装备的拍卖价格也将有助于新手盒子建立市场平均价，使其他玩家更了解市场行情。"],
            },
            onClick = function(self)
                if BiaoGe.newbee_report.uploadstate == 0 then
                    StaticPopup_Show("BIAOGE_CREATE_NEWBEE_REPORT")
                else
                    BG.PlaySound(1)
                    CreateNewBeeReport()
                end
            end
        },
        {
            name = L["浏览账单"],
            name2 = "Loot",
            onClick = function(self)
                BG.PlaySound(1)
                if BG.FrameNewBee.lootFrame:IsVisible() then
                    BG.FrameNewBee.lootFrame:Hide()
                else
                    BG.FrameNewBee.lootFrame:Show()
                    CreateNewBeeLoot()
                end
            end
        },
        {
            name = L["删除账单"],
            name2 = "Delete",
            onClick = function(self)
                BG.PlaySound(1)
                if BG.FrameNewBee.onUpdate then
                    BG.FrameNewBee.onUpdate:SetScript("OnUpdate", nil)
                    BG.FrameNewBee.onUpdate:Hide()
                end
                wipe(BiaoGe.newbee_report_notuploaded)
                wipe(BiaoGe.newbee_report)
                UpdateFrameNewBeeText()
                CreateNewBeeLoot()
                BG.FrameNewBee.lootFrame:Hide()
            end
        },
        {
            name = L["上传账单"],
            name2 = "Upload",
            onEnter = { format(L["把账单上传到新手盒子，点击后会重载一次游戏，请你确保新手盒子是正在运行。"], UPLOADTIME), },
            -- onEnter = { format(L["把账单上传到新手盒子，点击后会重载一次游戏，请你确保新手盒子是正在运行。重载后等待%s秒，就能在新手盒子看到本次上传的结果。"], UPLOADTIME), },
            onClick = function(self)
                StaticPopup_Show("BIAOGE_UPLOAD")
            end
        },
    }

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
        -- BG.ButtonNewBee:Hide()
        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(L["把本次活动的账单上传到新手盒子。"], 1, 0.82, 0, true)
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
    end

    BG.FrameNewBee = CreateFrame("Frame", nil, bt, "BackdropTemplate")
    do
        BG.FrameNewBee:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 10,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        BG.FrameNewBee:SetBackdropColor(0, 0, 0, 0.9)
        BG.FrameNewBee:SetSize(350, 190)
        BG.FrameNewBee:SetPoint("TOP", bt, "BOTTOM", 0, 0)
        BG.FrameNewBee:EnableMouse(true)
        BG.FrameNewBee:SetFrameLevel(130)
        BG.FrameNewBee:Hide()
        BG.FrameNewBee = BG.FrameNewBee

        BG.FrameNewBee.CloseButton = CreateFrame("Button", nil, BG.FrameNewBee, "UIPanelCloseButton")
        BG.FrameNewBee.CloseButton:SetPoint("TOPRIGHT", BG.FrameNewBee, "TOPRIGHT", 2, 2)

        local t = BG.FrameNewBee:CreateFontString()
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("TOPLEFT", BG.FrameNewBee, 10, -10)
        t:SetTextColor(RGB("FFD100"))
        t:SetText(L["< 账单信息 >"])
        t:SetWidth(200)
        t:SetJustifyH("CENTER")


        BG.FrameNewBee.texts = {}
        for i, v in ipairs(textTbl) do
            local f = CreateFrame("Frame", nil, BG.FrameNewBee, "BackdropTemplate")
            f:SetSize(200, 25)
            if i == 1 then
                f:SetPoint("TOPLEFT", BG.FrameNewBee, "TOPLEFT", 15, -35)
            else
                f:SetPoint("TOPLEFT", BG.FrameNewBee.texts[i - 1], "BOTTOMLEFT", 0, -2)
            end
            f.text = f:CreateFontString()
            f.text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            f.text:SetAllPoints()
            f.text:SetTextColor(1, 1, 1)
            f.text:SetJustifyH("LEFT")
            f.text.text = v.text
            f.text.owner = f
            BG.FrameNewBee["Text" .. v.name2] = f.text
            tinsert(BG.FrameNewBee.texts, f.text)

            f:SetScript("OnEnter", function(self)
                if self.text:GetStringWidth() > self:GetWidth() then
                    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:AddLine(self.text:GetText(), 1, 0.82, 0, true)
                    GameTooltip:Show()
                end
            end)
            f:SetScript("OnLeave", GameTooltip_Hide)

            local l = f:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("BOTTOMLEFT", 0, 3)
            l:SetEndPoint("BOTTOMRIGHT", 0, 3)
            l:SetThickness(1)
        end

        BG.FrameNewBee.buttons = {}
        for i, v in ipairs(buttonTbl) do
            local bt = CreateFrame("CheckButton", nil, BG.FrameNewBee, "UIPanelButtonTemplate")
            bt:SetSize(100, 30)
            if i == 1 then
                bt:SetPoint("TOPRIGHT", BG.FrameNewBee, "TOPRIGHT", -15, -35)
            else
                bt:SetPoint("TOPLEFT", BG.FrameNewBee.buttons[i - 1], "BOTTOMLEFT", 0, -5)
            end
            bt:SetText(v.name)
            BG.FrameNewBee["Button" .. v.name2] = bt
            tinsert(BG.FrameNewBee.buttons, bt)
            bt:SetScript("OnClick", v.onClick)
            bt:SetScript("OnEnter", function(self)
                if v.onEnter then
                    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
                    for i, text in ipairs(v.onEnter) do
                        GameTooltip:AddLine(text, 1, 0.82, 0, true)
                    end
                    GameTooltip:Show()
                end
            end)
            bt:SetScript("OnLeave", GameTooltip_Hide)
        end


        do
            local f = CreateFrame("Frame", nil, BG.FrameNewBee, "BackdropTemplate")
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 10,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.9)
            f:SetSize(BG.FrameNewBee:GetWidth(), 500)
            f:SetPoint("TOP", BG.FrameNewBee, "BOTTOM", 0, 0)
            f:EnableMouse(true)
            f.isFirst = true
            f:Hide()

            local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate") -- 滚动
            scroll:SetWidth(f:GetWidth() - 31)
            scroll:SetHeight(f:GetHeight() - 9)
            scroll:SetPoint("TOPLEFT", f, "TOPLEFT", 5, -5)
            scroll.ScrollBar.scrollStep = 150
            BG.CreateSrollBarBackdrop(scroll.ScrollBar)
            BG.HookScrollBarShowOrHide(scroll)

            local child = CreateFrame("EditBox", nil, f) -- 子框架
            child:SetFontObject(GameFontNormal)
            child:SetWidth(scroll:GetWidth())
            child:SetAutoFocus(false)
            child:EnableMouse(false)
            child:SetTextInsets(0, 0, 0, 0)
            child:SetMultiLine(true)
            child:SetHyperlinksEnabled(true)
            scroll:SetScrollChild(child)
            BG.FrameNewBee.lootFrame = f
            BG.FrameNewBee.lootFrameScroll = scroll
            BG.FrameNewBee.lootFrameChild = child

            child:SetScript("OnHyperlinkEnter", function(self, link, text, button)
                GameTooltip:SetOwner(BG.FrameNewBee, "ANCHOR_BOTTOMRIGHT", 0, 0)
                GameTooltip:ClearLines()
                local itemID = GetItemInfoInstant(link)
                if itemID then
                    GameTooltip:SetItemByID(itemID)
                    GameTooltip:Show()
                    BG.Show_AllHighlight(link)
                end
            end)
            child:SetScript("OnHyperlinkLeave", function(self, link, text, button)
                GameTooltip:Hide()
                BG.Hide_AllHighlight()
            end)
        end
        UpdateFrameNewBeeText()
    end

    StaticPopupDialogs["BIAOGE_CREATE_NEWBEE_REPORT"] = {
        text = L["确认创建账单？\n你有一个账单正在上传，现在创建账单会导致上传失败哦！"],
        button1 = L["是"],
        button2 = L["否"],
        OnAccept = function()
            CreateNewBeeReport()
        end,
        OnCancel = function()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        showAlert = true,
    }

    StaticPopupDialogs["BIAOGE_UPLOAD"] = {
        text = L["确认上传账单吗？\n点击后会立刻|cffff0000重载游戏|r，用于新手盒子读取账单。"],
        button1 = L["是"],
        button2 = L["否"],
        OnAccept = function()
            wipe(BiaoGe.newbee_report)
            for k, v in pairs(BiaoGe.newbee_report_notuploaded) do
                BiaoGe.newbee_report[k] = v
            end
            BiaoGe.newbee_report.uploadstate = 0
            BG.FrameNewBee.uploadstate = true
            wipe(BiaoGe.newbee_report_notuploaded)
            ReloadUI()
        end,
        OnCancel = function()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        showAlert = true,
    }
end)

-- 登录游戏时，如果状态为正在上传，则设置倒计时x秒
BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even, isLogin, isReload)
    if not (isLogin or isReload) then return end
    BG.After(3, function()
        if BiaoGe.newbee_report.uploadstate == 0 then
            PlaySoundFile(BG["sound_uploading" .. BiaoGe.options.Sound], "Master")
            BG.SendSystemMessage(format(L["账单正在上传新手盒子！请你确保新手盒子是正在运行。上传需要%s秒。"], UPLOADTIME))
            -- BG.SendSystemMessage(format(L["账单正在上传新手盒子！请你确保新手盒子是正在运行。等待%s秒后，就能在新手盒子看到本次上传的结果。"], UPLOADTIME))
            BG.FrameNewBee.onUpdate = BG.OnUpdateTime(function(self, elapsed)
                self.timeElapsed = self.timeElapsed + elapsed
                BG.FrameNewBee.TextuploadText:SetText(BG.FrameNewBee.TextuploadText.text .. L["正在上传"] .. format(L["（%s）"], floor(UPLOADTIME - self.timeElapsed) + 1))
                if self.timeElapsed >= UPLOADTIME then
                    self:SetScript("OnUpdate", nil)
                    self:Hide()
                    BG.FrameNewBee.TextuploadText:SetText(BG.FrameNewBee.TextuploadText.text .. L["已上传"])
                    BG.FrameNewBee.TextuploadText:SetTextColor(0, 1, 0)
                    PlaySoundFile(BG["sound_uploaded" .. BiaoGe.options.Sound], "Master")
                    BG.SendSystemMessage(L["账单已上传到新手盒子！感谢你的支持！"])
                    BiaoGe.newbee_report.uploadstate = 1
                end
            end)
        end
    end)
end)

-- 登出游戏时，如果状态为正在上传，则设置为已上传
BG.RegisterEvent("PLAYER_LOGOUT", function(self, even)
    if not BG.FrameNewBee.uploadstate and Size(BiaoGe.newbee_report) ~= 0 then
        BiaoGe.newbee_report.uploadstate = 1
    end
end)

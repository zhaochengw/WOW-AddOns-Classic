local AddonName, ns = ...

if not BG.IsWLK then return end

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

BG.RegisterEvent("ADDON_LOADED", function(self, event, addonName)
    if addonName ~= AddonName then return end

    BiaoGe.newbee_report = BiaoGe.newbee_report or {}
    BiaoGe.newbee_report_notuploaded = BiaoGe.newbee_report_notuploaded or {}

    local LEAST_VER = "1.10.0"

    local textTbl, buttonTbl

    local function TargetIsTrueVer(ver)
        if BG.GetVerNum(ver) >= BG.GetVerNum(LEAST_VER) then
            return true
        end
    end
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
    local function UpdateFrameNewBeeText(FB, time, name, color, text3, text4)
        if FB then
            BG.FrameNewBee.texts[1]:SetText(textTbl[1].text .. (BG.GetFBinfo(FB, "localName") or L["无"]))
        else
            BG.FrameNewBee.texts[1]:SetText(textTbl[1].text .. L["无"])
        end

        if time then
            local d = date("*t", date(time))
            d = strsub(d.year, 3) .. "/" .. d.month .. "/" .. d.day .. " " .. format("%02d", d.hour) .. ":" .. format("%02d", d.min)
            BG.FrameNewBee.texts[2]:SetText(textTbl[2].text .. d)
        else
            BG.FrameNewBee.texts[2]:SetText(textTbl[2].text .. L["无"])
        end

        if name then
            BG.FrameNewBee.texts[3]:SetText(textTbl[3].text .. name)
        else
            BG.FrameNewBee.texts[3]:SetText(textTbl[3].text .. L["无"])
        end
        if color then
            BG.FrameNewBee.texts[3]:SetTextColor(unpack(color))
        else
            BG.FrameNewBee.texts[3]:SetTextColor(1, 1, 1)
        end

        BG.FrameNewBee.texts[4]:SetText(textTbl[4].text .. text3)
        if text3 == L["未审核"] then
            BG.FrameNewBee.texts[4]:SetTextColor(1, 0, 0)
        else
            BG.FrameNewBee.texts[4]:SetTextColor(0, 1, 0)
        end

        BG.FrameNewBee.texts[5]:SetText(textTbl[5].text .. text4)
        if text4 == L["未上传"] then
            BG.FrameNewBee.texts[5]:SetTextColor(1, 0, 0)
        else
            BG.FrameNewBee.texts[5]:SetTextColor(0, 1, 0)
        end
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
        if BiaoGe.newbee_report_notuploaded.ledger then
            for ii, vv in ipairs(BiaoGe.newbee_report_notuploaded.ledger) do
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
                for i, v in pairs(BiaoGe.newbee_report_notuploaded.ledger[ii]) do
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
        wipe(BiaoGe.newbee_report_notuploaded)
        -- 时间戳
        BiaoGe.newbee_report_notuploaded.time = time()
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
        -- 上传者
        local unit = "player"
        BiaoGe.newbee_report_notuploaded.uploader = {}
        BiaoGe.newbee_report_notuploaded.uploader.name = UnitName(unit) -- 玩家名字
        for k, v in pairs(BG.playerClass) do
            BiaoGe.newbee_report_notuploaded.uploader[k] = select(v.select, v.func(unit))
        end
        -- 账单
        BiaoGe.newbee_report_notuploaded.ledger = {}
        BiaoGe.newbee_report_notuploaded.allBuyer = {}
        BiaoGe.newbee_report_notuploaded.allCanCheckBuyer = {}
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
                            tinsert(tbl, a)

                            if buyer and not BiaoGe.newbee_report_notuploaded.allBuyer[buyer] then
                                local b = {}
                                for k, v in pairs(a.buyer) do
                                    b[k] = v
                                end

                                local ver = BG.raidBiaoGeVersion[buyer]
                                if ver and TargetIsTrueVer(ver) then
                                    b.canCheck = true
                                    BiaoGe.newbee_report_notuploaded.allCanCheckBuyer[buyer] = b
                                else
                                    b.canCheck = false
                                end
                                BiaoGe.newbee_report_notuploaded.allBuyer[buyer] = b
                            end
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

        --[[
        不能审核的情况：
        1、玩家自己没权限：不是团长、没A、没物品分配权
        2、没有团长信息
        3、没有买家
        4、只有一个买家、且该买家是自己
        5、有多个买家，但这些买家有80%人不在团队里


        正常审核：
        发送给团队里有表格插件的人去审核，时间30秒


        ]]
        local FB = BiaoGe.newbee_report_notuploaded.biaoge
        local time = BiaoGe.newbee_report_notuploaded.time
        local name = BiaoGe.newbee_report_notuploaded.uploader.name
        local color = BiaoGe.newbee_report_notuploaded.uploader.color
        local checkText = L["未审核"]
        if Size(BiaoGe.newbee_report_notuploaded.allCanCheckBuyer) == 0 then
            checkText = L["无需审核"]
        elseif Size(BiaoGe.newbee_report_notuploaded.allCanCheckBuyer) == 1 and
            BiaoGe.newbee_report_notuploaded.allCanCheckBuyer[UnitName("Player")] then
            checkText = L["无需审核"]
        end
        UpdateFrameNewBeeText(FB, time, name, color, checkText, L["未上传"])

        if BG.FrameNewBee.lootFrame:IsVisible() then
            CreateNewBeeLoot()
        end
    end


    local bt = CreateFrame("Button", nil, BG.MainFrame)
    do
        bt:SetPoint("LEFT", BG.ButtonAucitonWA, "RIGHT", BG.TopLeftButtonJianGe, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(AddTexture("QUEST") .. L["上传到新手盒子"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        bt:Hide()
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
        -- bt:Hide()
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
        BG.FrameNewBee:SetSize(350, 200)
        BG.FrameNewBee:SetPoint("TOP", bt, "BOTTOM", 0, 0)
        BG.FrameNewBee:EnableMouse(true)
        BG.FrameNewBee:SetFrameLevel(130)
        BG.FrameNewBee:Hide()
        BG.FrameNewBee = BG.FrameNewBee

        BG.FrameNewBee:SetScript("OnShow", function(self)
            local FB = BiaoGe.newbee_report_notuploaded.biaoge
            local time = BiaoGe.newbee_report_notuploaded.time
            local name = BiaoGe.newbee_report_notuploaded.uploader and BiaoGe.newbee_report_notuploaded.uploader.name or nil
            local color = BiaoGe.newbee_report_notuploaded.uploader and BiaoGe.newbee_report_notuploaded.uploader.color or nil
            UpdateFrameNewBeeText(FB, time, name, color, L["未审核"], L["未上传"])

            CreateNewBeeLoot()
        end)

        BG.FrameNewBee.CloseButton = CreateFrame("Button", nil, BG.FrameNewBee, "UIPanelCloseButton")
        BG.FrameNewBee.CloseButton:SetPoint("TOPRIGHT", BG.FrameNewBee, "TOPRIGHT", 2, 2)

        local t = BG.FrameNewBee:CreateFontString()
        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        t:SetPoint("TOPLEFT", BG.FrameNewBee, 10, -10)
        t:SetTextColor(RGB("FFD100"))
        t:SetText(L["< 账单信息 >"])
        t:SetWidth(200)
        t:SetJustifyH("CENTER")

        textTbl = {
            { text = BG.STC_y2(L["账单表格："]), name = "biaoge" },
            { text = BG.STC_y2(L["生成时间："]), name = "createTimeText" },
            { text = BG.STC_y2(L["生成人："]), name = "createManText" },
            { text = BG.STC_y2(L["审核状态："]), name = "checkText" },
            { text = BG.STC_y2(L["上传状态："]), name = "uploadText" },
        }
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
            f.text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
            f.text:SetAllPoints()
            f.text:SetTextColor(1, 1, 1)
            f.text:SetJustifyH("LEFT")
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


        buttonTbl = {
            {
                name = L["生成账单"],
                onEnter = { L["使用当前表格的数据生成一个账单，用于上传新手盒子。"], },
                onClick = function(self)
                    BG.PlaySound(1)
                    CreateNewBeeReport()
                end
            },
            {
                name = L["浏览账单"],
                onEnter = { L["浏览已经生成的账单，便于你核对是否有错。"], },
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
                name = L["审核账单"],
                onEnter = { L["把账单发给装有BiaoGe插件的团员审核，只要有80%通过就视为通过。"],
                    " ",
                    L["说明"],
                    L["未审核的账单：只用于团队内部浏览，不参与国服土豪排行榜"],
                    L["已审核的账单：除了用于团队内部浏览，也会参与国服土豪排行榜"], },
                onClick = function(self)

                end
            },
            {
                name = L["上传账单"],
                onEnter = { L["把账单上传到新手盒子，点击后会重载一次游戏。重载后等待30秒，打开新手盒子就能看到本次上传的结果。"], },
                onClick = function(self)

                end
            },
        }
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
            tinsert(BG.FrameNewBee.buttons, bt)
            bt:SetScript("OnClick", v.onClick)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
                for i, text in ipairs(v.onEnter) do
                    GameTooltip:AddLine(text, 1, 0.82, 0, true)
                end
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", GameTooltip_Hide)
        end


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

        local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate") -- 滚动
        scroll:SetWidth(f:GetWidth() - 31)
        scroll:SetHeight(f:GetHeight() - 9)
        scroll:SetPoint("TOPLEFT", f, "TOPLEFT", 5, -5)
        scroll.ScrollBar.scrollStep = 150
        BG.CreateSrollBarBackdrop(scroll.ScrollBar)

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
                BG.HighlightBiaoGe(link)
                BG.HighlightBag(link)
            end
        end)
        child:SetScript("OnHyperlinkLeave", function(self, link, text, button)
            GameTooltip:Hide()
            BG.Hide_AllHighlight()
        end)
    end
end)

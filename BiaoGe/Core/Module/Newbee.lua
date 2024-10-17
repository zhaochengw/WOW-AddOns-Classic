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
    local function CreateNewBeeReport()
        if BG.ButtonNewBee.onUpdate then
            BG.ButtonNewBee.onUpdate:SetScript("OnUpdate", nil)
            BG.ButtonNewBee.onUpdate:Hide()
        end
        wipe(BiaoGe.newbee_report)
        BiaoGe.newbee_report.uploadstate = 0
        BG.ButtonNewBee.uploadstate = true
        -- 时间戳
        BiaoGe.newbee_report.time = GetServerTime()
        -- 表格
        BiaoGe.newbee_report.biaoge = BG.FB1
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
                    local lockoutID, realmID
                    if instanceID and BiaoGe[FB].lockoutIDtbl and BiaoGe[FB].lockoutIDtbl[instanceID] then
                        lockoutID = BiaoGe[FB].lockoutIDtbl[instanceID].lockoutID
                        realmID = BiaoGe[FB].lockoutIDtbl[instanceID].realmID
                    end
                    tbl.instanceID = instanceID
                    tbl.lockoutID = lockoutID
                    tbl.realmID = realmID

                    tinsert(BiaoGe.newbee_report.ledger, tbl)
                end
            end
        end
        ReloadUI()
    end

    local bt = CreateFrame("Button", nil, BG.MainFrame)
    do
        bt:SetPoint("LEFT", BG.ButtonGuoQi, "RIGHT", BG.TopLeftButtonJianGe, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(L["上传账单"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        BG.ButtonNewBee = bt
        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_NONE")
            GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(L["把当前表格的数据上传到|cff00ff00新手盒子|r。每件装备的拍卖价格也将有助于新手盒子建立市场平均价，使其他玩家更了解市场行情。"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt:SetScript("OnLeave", GameTooltip_Hide)
        bt:SetScript("OnClick", function()
            StaticPopup_Show("BIAOGE_UPLOAD")
        end)
    end

    StaticPopupDialogs["BIAOGE_UPLOAD"] = {
        text = L["确认上传账单吗？\n点击后会立刻|cffff0000重载游戏|r，用于新手盒子读取账单。"],
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
end)

-- 登录游戏时，如果状态为正在上传，则设置倒计时x秒
BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even, isLogin, isReload)
    if not (isLogin or isReload) then return end
    BG.After(3, function()
        if BiaoGe.newbee_report.uploadstate == 0 then
            PlaySoundFile(BG["sound_uploading" .. BiaoGe.options.Sound], "Master")
            BG.SendSystemMessage(format(L["账单正在上传新手盒子！请你确保新手盒子是正在运行。上传需要%s秒。"], UPLOADTIME))
            BG.ButtonNewBee.onUpdate = BG.OnUpdateTime(function(self, elapsed)
                self.timeElapsed = self.timeElapsed + elapsed
                if self.timeElapsed >= UPLOADTIME then
                    self:SetScript("OnUpdate", nil)
                    self:Hide()
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
    if not BG.ButtonNewBee.uploadstate and Size(BiaoGe.newbee_report) ~= 0 then
        BiaoGe.newbee_report.uploadstate = 1
    end
end)

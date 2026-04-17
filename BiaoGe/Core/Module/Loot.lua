if BG.IsBlackListPlayer then return end
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
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local Maxb = ns.Maxb
local HopeMaxn = ns.HopeMaxn
local HopeMaxb = ns.HopeMaxb
local HopeMaxi = ns.HopeMaxi

local pt = print
local RealmId = GetRealmID()
local player = BG.playerName

local saveZaXiangNum = 0
local saveZaXiangTbl = {}

local r, g, b = GetClassRGB(nil, "player")

BG.Init(function()
    -- 拾取事件通报到屏幕中上
    local name = "lootTime"
    BG.options[name .. "reset"] = 8
    local f = CreateFrame("ScrollingMessageFrame", "BG.FrameLootMsg", UIParent, "BackdropTemplate")
    do
        f:SetSpacing(3)                                                       -- 行间隔
        f:SetFadeDuration(1)                                                  -- 淡出动画的时间
        f:SetTimeVisible(BiaoGe.options[name] or BG.options[name .. "reset"]) -- 可见时间
        f:SetJustifyH("LEFT")                                                 -- 对齐格式
        f:SetSize(700, 170)                                                   -- 大小
        f:SetFont(BIAOGE_TEXT_FONT, BiaoGe.options["lootFontSize"] or 20, "OUTLINE")
        f:SetFrameStrata("FULLSCREEN_DIALOG")
        f:SetFrameLevel(130)
        f:SetClampedToScreen(true)
        f:SetHyperlinksEnabled(true)
        f.name = L["装备记录通知"]
        f.homepoin = { "TOPLEFT", nil, "TOP", -200, 0 }
        if BiaoGe.point[f:GetName()] then
            BiaoGe.point[f:GetName()][2] = nil
            f:SetPoint(unpack(BiaoGe.point[f:GetName()]))
        else
            f:SetPoint(unpack(f.homepoin)) --设置显示位置
        end
        tinsert(BG.Movetable, f)
        BG.FrameLootMsg = f

        f.name = f:CreateFontString()
        f.name:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
        f.name:SetTextColor(1, 1, 1, 1)
        f.name:SetText(L["装备记录通知"])
        f.name:SetPoint("TOP", 0, -5)
        f.name:Hide()

        BG.FrameLootMsg:SetScript("OnHyperlinkEnter", function(self, link, text, button)
            local arg1, arg2, arg3 = strsplit(":", link)
            if arg2 == "BiaoGeGuoQi" and arg3 == L["详细"] then
                GameTooltip:SetOwner(self, "ANCHOR_CURSOR", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(L["装备过期剩余时间"], 1, 1, 1)
                GameTooltip:AddLine(" ", 1, 1, 1)
                if #BG.itemGuoQiFrame.tbl == 0 then
                    GameTooltip:AddLine(L["背包里没有可交易的装备。"], 1, 0, 0)
                else
                    for i, v in ipairs(BG.itemGuoQiFrame.tbl) do
                        if i > 20 then
                            GameTooltip:AddLine("......", 1, 0.82, 0)
                            break
                        end
                        local link, itemID, time, b, i = v.link, v.itemID, v.time, v.b, v.i
                        local name, _, quality, level, _, _, _, _, _,
                        Texture, _, typeID, _, bindType = GetItemInfo(itemID)

                        local r, g, b = 0, 1, 0
                        if time < 30 then
                            r, g, b = 1, 0, 0
                        end
                        GameTooltip:AddDoubleLine(AddTexture(Texture) .. link, time .. "m", 1, 1, 1, r, g, b)
                    end
                end
                GameTooltip:Show()
            else
                local itemID = GetItemInfoInstant(link)
                if itemID then
                    GameTooltip:SetOwner(self, "ANCHOR_CURSOR", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:SetHyperlink(BG.SetSpecIDToLink(link))
                end
            end
        end)
        BG.FrameLootMsg:SetScript("OnHyperlinkLeave", function(self, link, text, button)
            GameTooltip:Hide()
        end)
        BG.FrameLootMsg:SetScript("OnHyperlinkClick", function(self, link, text, button)
            local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = strsplit(":", link)
            if arg2 == "BiaoGeGuoQi" and arg3 == L["详细"] then
                BG.MainFrame:Show()
                BG.itemGuoQiFrame:Show()
                BG.ClickTabButton(BG.FBMainFrameTabNum)
            elseif arg2 == "BiaoGeGuoQi" and arg3 == L["设置为1小时内不再提醒"] then
                BiaoGe.lastGuoQiTime = GetServerTime() + 60 * 55
                BG.FrameLootMsg:AddMessage(BG.STC_b1(L["已设置为1小时内不再提醒。"]))
            elseif arg2 == "BiaoGeInSertItem" then
                local _saveZaXiangNum, itemID, FB, Texture, level, Hope, count, typeID, lootplayer = arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11
                if Hope == "0" then Hope = nil end
                _saveZaXiangNum = tonumber(_saveZaXiangNum)
                itemID = tonumber(itemID)
                Texture = tonumber(Texture)
                level = tonumber(level)
                count = tonumber(count)
                typeID = tonumber(typeID)
                if not saveZaXiangTbl[_saveZaXiangNum] then
                    saveZaXiangTbl[_saveZaXiangNum] = true
                    local numb = Maxb[FB] - 1
                    local link = select(2, GetItemInfo(itemID))
                    BG.AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer)
                end
            else
                local name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
                if link then
                    if button == "RightButton" then
                        BG.CancelGuanZhu(link)
                    end
                    if IsShiftKeyDown() then
                        BG.InsertLink(text)
                    elseif IsAltKeyDown() then
                        if BG.IsML then -- 开始拍卖
                            BG.StartAuction(link, nil, nil, nil, button == "RightButton")
                        else            -- 关注装备
                            if button ~= "RightButton" then
                                BG.AddGuanZhu(link)
                            end
                        end
                    end
                end
            end
        end)
    end

    local trade
    local buy
    local quest

    local f = CreateFrame("Frame")
    f:RegisterEvent("TRADE_ACCEPT_UPDATE")
    f:RegisterEvent("TRADE_CLOSED")
    f:RegisterEvent("MERCHANT_UPDATE")
    f:RegisterEvent("QUEST_TURNED_IN")
    f:RegisterEvent("QUEST_FINISHED")
    f:SetScript("OnEvent", function(self, event, arg1, arg2)
        if event == "TRADE_ACCEPT_UPDATE" then -- 屏蔽交易添加
            if arg1 == 1 or arg2 == 1 then
                trade = true
            else
                trade = nil
            end
        elseif event == "TRADE_CLOSED" then
            trade = nil
        elseif event == "MERCHANT_UPDATE" then -- 屏蔽购买物品
            buy = true
            C_Timer.After(0.5, function()
                buy = nil
            end)
        elseif event == "QUEST_TURNED_IN" or event == "QUEST_FINISHED" then -- 屏蔽任务物品
            quest = true
            C_Timer.After(0.5, function()
                quest = nil
            end)
        end
    end)

    -- 装备未拾取提醒
    local remindUpdateFrame = CreateFrame("Frame")
    local function NotLootRemind()
        if BiaoGe.options.autoLoot == 1 and BiaoGe.options.autolootRemind == 1
            and IsMasterLooter() then
            remindUpdateFrame.t = 0
            remindUpdateFrame:SetScript("OnUpdate", function(self, t)
                self.t = self.t + t
                if self.t >= 30 then
                    if IsMasterLooter() then
                        BG.FrameLootMsg:AddMessage(BG.STC_r1(L["提醒：你可能还没拾取刚击杀BOSS的掉落哦！"]))
                        PlaySoundFile("Interface\\AddOns\\BiaoGe\\Media\\sound\\other\\remind.mp3", "Master")
                    end
                    self:SetScript("OnUpdate", nil)
                end
            end)
        end
    end

    local numb
    local lasttime = 0
    local _time
    local start
    local function IsBWLsod_boss5orboss6(bossID)
        if BG.IsVanilla_Sod and (bossID == 614 or bossID == 615) then
            return 5
        end
    end
    -- 获取BOSS战ID
    local f = CreateFrame("Frame")
    f:RegisterEvent("ENCOUNTER_START")
    f:RegisterEvent("ENCOUNTER_END")
    f:SetScript("OnEvent", function(self, event, ...)
        local bossID, _, _, _, success = ...
        local FB = BG.FB2
        if not FB then return end
        if event == "ENCOUNTER_START" then
            start = true
            if IsBWLsod_boss5orboss6(bossID) then
                numb = IsBWLsod_boss5orboss6(bossID)
                lasttime = GetTime()
            else
                local _numb = BG.GetBossIndexByBossID(bossID)
                if _numb then
                    numb = _numb
                    lasttime = GetTime()
                end
            end
        elseif event == "ENCOUNTER_END" then
            if success == 1 then
                if IsBWLsod_boss5orboss6(bossID) then
                    numb = IsBWLsod_boss5orboss6(bossID)
                    lasttime = GetTime()
                else
                    local _numb = BG.GetBossIndexByBossID(bossID)
                    if _numb then
                        numb = _numb
                        lasttime = GetTime()
                        start = nil
                        BiaoGe[FB].raidRoster = { time = GetServerTime(), realm = BG.realmName, roster = {} }
                        for i, v in ipairs(BG.raidRosterInfo) do
                            tinsert(BiaoGe[FB].raidRoster.roster, v.name)
                        end
                        NotLootRemind()
                    end
                end
            else
                numb = Maxb[FB] - 1
                start = nil
            end
        end
    end)
    -- 击杀BOSS x秒后进入下一次战斗，就变回杂项
    BG.RegisterEvent("PLAYER_REGEN_DISABLED", function(self, event)
        local FB = BG.FB2
        if not FB then return end
        if start then return end
        _time = GetTime()
        if numb ~= Maxb[FB] - 1 then
            if _time - lasttime >= 45 then
                numb = Maxb[FB] - 1
            end
        end
    end)

    -- 记录拾取信息
    local function AddLootLog(FB, numb, i, lootplayer, count)
        if lootplayer and lootplayer ~= "" then
            BiaoGe[FB]["boss" .. numb]["loot" .. i] = BiaoGe[FB]["boss" .. numb]["loot" .. i] or {}
            tinsert(BiaoGe[FB]["boss" .. numb]["loot" .. i], {
                time = GetServerTime(),
                player = lootplayer,
                class = select(2, UnitClass(lootplayer)),
                count = count,
            })
        end
    end

    -- 记录物品进表格
    local biaogefull
    local function _AddLootItem(itemID, FB, numb, link, Texture, level, Hope, count, typeID, lootplayer, fromLast)
        local icon
        if BG.GetItemCount(itemID) ~= 0 then
            icon = AddTexture("interface/raidframe/readycheck-ready")
        else
            icon = BG.LootFilterClassItem(link)
        end
        local levelText = ""
        if typeID == 2 or typeID == 4 then
            levelText = "(" .. level .. ")"
        end
        local startI, endI, addI = 1, BG.GetMaxi(FB, numb), 1
        if fromLast then
            startI, endI, addI = BG.GetMaxi(FB, numb), 1, -1
        end
        for i = startI, endI, addI do
            local zb = BG.Frame[FB]["boss" .. numb]["zhuangbei" .. i]
            local zbNext = BG.Frame[FB]["boss" .. numb]["zhuangbei" .. (i + addI)]
            local duizhangzb = BG.DuiZhangFrame[FB]["boss" .. numb]["zhuangbei" .. i]
            if zb and zb:GetText() == "" then
                if Hope then
                    BiaoGe[FB]["boss" .. numb]["guanzhu" .. i] = true
                    BG.Frame[FB]["boss" .. numb]["guanzhu" .. i]:Show()
                end
                if count == 1 then
                    zb:SetText(link)
                    duizhangzb:SetText(link)
                    BiaoGe[FB]["boss" .. numb]["zhuangbei" .. i] = link
                    if BiaoGe.options["autolootNotice"] == 1 then
                        BG.FrameLootMsg:AddMessage(icon .. "|cff00BFFF" ..
                            format(L["已自动记入表格：%s%s%s => %s<%s>%s"], RR, (AddTexture(Texture) .. link),
                                levelText, "|cff" .. BG.Boss[FB]["boss" .. numb]["color"],
                                BG.Boss[FB]["boss" .. numb]["name2"], RR) .. icon)
                    end
                else
                    zb:SetText(link .. "x" .. count)
                    duizhangzb:SetText(link .. "x" .. count)
                    BiaoGe[FB]["boss" .. numb]["zhuangbei" .. i] = link .. "x" .. count
                    if BiaoGe.options["autolootNotice"] == 1 then
                        BG.FrameLootMsg:AddMessage(icon .. "|cff00BFFF" ..
                            format(L["已自动记入表格：%s%s%s x%d => %s<%s>%s"], RR, (AddTexture(Texture) .. link),
                                levelText, count, "|cff" .. BG.Boss[FB]["boss" .. numb]["color"],
                                BG.Boss[FB]["boss" .. numb]["name2"], RR) .. icon)
                    end
                end
                AddLootLog(FB, numb, i, lootplayer, count)
                if BGV and BGV.UpdateCPMoney then
                    BGV.UpdateCPMoney(itemID, count, FB, numb, i)
                end
                return
            elseif zb and not zbNext then
                local inSertItem = ""
                if numb ~= Maxb[FB] - 1 then
                    local has
                    for i = 1, BG.GetMaxi(FB, numb) do
                        local zb = BG.Frame[FB]["boss" .. Maxb[FB] - 1]["zhuangbei" .. i]
                        if zb and zb:GetText() == "" then
                            has = true
                            break
                        end
                    end
                    if has then
                        local Hope = Hope and 1 or 0
                        saveZaXiangNum = saveZaXiangNum + 1
                        inSertItem = " |cffFFFF00|Hgarrmission:" .. format("BiaoGeInSertItem:%s:%s:%s:%s:%s:%s:%s:%s:%s",
                            saveZaXiangNum, itemID, FB, Texture, level, Hope, count, typeID, lootplayer or "") .. "|h[" .. L["点击记入杂项"] .. "]|h|r"
                    end
                end

                BG.FrameLootMsg:AddMessage(icon .. format(
                    "|cffDC143C" .. L["自动记录失败：%s%s%s。因为%s< %s >%s的格子满了"], RR,
                    (AddTexture(Texture) .. link), levelText, "|cff" .. BG.Boss[FB]["boss" .. numb]["color"],
                    BG.Boss[FB]["boss" .. numb]["name2"], RR) .. inSertItem .. icon)
                if not biaogefull then
                    biaogefull = true
                    BG.After(1, function()
                        biaogefull = false
                    end)
                    BG.PlaySound("biaogefull")
                end
                return
            end
        end
    end
    local function AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer, notlater, fromLast)
        local itemID = GetItemInfoInstant(link)
        BG.Tooltip_SetItemByID(itemID)
        if notlater then
            _AddLootItem(itemID, FB, numb, link, Texture, level, Hope, count, typeID, lootplayer, fromLast)
        else
            BG.After(0.1, function()
                _AddLootItem(itemID, FB, numb, link, Texture, level, Hope, count, typeID, lootplayer, fromLast)
            end)
        end
    end
    local function AddLootItem_stackCount(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer)
        local yes
        local levelText = ""
        if typeID == 2 or typeID == 4 then
            levelText = "(" .. level .. ")"
        end
        local itemID = GetItemID(link)
        for b = 1, Maxb[FB] do
            for i = 1, BG.GetMaxi(FB, b) do
                local zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                local duizhangzb = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]
                if zb then
                    if itemID == GetItemID(zb:GetText()) then
                        if Hope then
                            BiaoGe[FB]["boss" .. b]["guanzhu" .. i] = true
                            BG.Frame[FB]["boss" .. b]["guanzhu" .. i]:Show()
                            BG.FrameLootMsg:AddMessage(BG.STC_g2(format(L["自动关注心愿装备：%s。团长拍卖此装备时会提醒"],
                                (AddTexture(Texture) .. link))))
                        end
                        AddLootLog(FB, b, i, lootplayer, count)
                        count = count + (tonumber(strmatch(zb:GetText(), "|h%[.*%]|h|r[*xX%s]-(%d+)")) or 1)
                        zb:SetText(link .. "x" .. count)
                        duizhangzb:SetText(link .. "x" .. count)
                        BiaoGe[FB]["boss" .. b]["zhuangbei" .. i] = link .. "x" .. count
                        local icon
                        if BG.GetItemCount(link) ~= 0 then
                            icon = AddTexture("interface/raidframe/readycheck-ready")
                        else
                            icon = BG.LootFilterClassItem(link)
                        end
                        if BiaoGe.options["autolootNotice"] == 1 then
                            BG.FrameLootMsg:AddMessage(icon .. "|cff00BFFF" ..
                                format(L["已自动记入表格：%s%s%s x%d => %s<%s>%s"], RR, (AddTexture(Texture) .. link),
                                    levelText, count, "|cff" .. BG.Boss[FB]["boss" .. b]["color"],
                                    BG.Boss[FB]["boss" .. b]["name2"], RR) .. icon)
                        end
                        if BGV and BGV.UpdateCPMoney then
                            BGV.UpdateCPMoney(itemID, count, FB, b, i)
                        end
                        return
                    end
                end
            end
        end
        -- 如果表格里没这个物品，则记录到杂项里
        if not yes then
            local numb = Maxb[FB] - 1
            AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer, "notlater")
            return
        end
    end
    BG.AddLootItem_stackCount = AddLootItem_stackCount
    BG.AddLootItem = AddLootItem

    function BG.ItemIsHope(FB, link, Texture, level, itemID)
        itemID = itemID or GetItemID(link)
        for n = 1, HopeMaxn[FB] do
            for b = 1, HopeMaxb[FB] do
                for i = 1, HopeMaxi do
                    local bt = BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                    if bt and itemID == GetItemID(bt:GetText()) then
                        BG.FrameLootMsg:AddMessage(BG.STC_g1(format(L["你的心愿达成啦！！！>>>>> %s(%s) <<<<<"], (AddTexture(Texture) .. link), level)))
                        bt.looted:Show()
                        BG.PlaySound("hope")
                        return true
                    end
                end
            end
        end
    end

    -- 拾取事件监听
    -- local testItemID = 59521
    local testItemID = 67429
    GetItemInfo(testItemID)
    local function LootItem(self, event, msg, ...)
        if BiaoGe.options["autoLoot"] ~= 1 then -- 有没勾选自动记录功能
            return
        end

        local FB = BG.FB2
        if BG.DeBug then
            FB = BG.FB1
        else
            if not FB then return end
        end

        if trade then return end -- 是否刚交易完

        local lootplayer, link, count
        link, count = strmatch(msg, string.gsub(string.gsub(LOOT_ITEM_SELF_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
        if (not link) then
            link, count = strmatch(msg, string.gsub(string.gsub(LOOT_ITEM_PUSHED_SELF_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
            if (not link) then
                link = msg:match(LOOT_ITEM_SELF:gsub("%%s", "(.+)"));
                if (not link) then
                    link = msg:match(LOOT_ITEM_PUSHED_SELF:gsub("%%s", "(.+)"));

                    if (not link) then
                        lootplayer, link, count = strmatch(msg, string.gsub(string.gsub(LOOT_ITEM_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
                        if (not link) then
                            lootplayer, link, count = strmatch(msg, string.gsub(string.gsub(LOOT_ITEM_PUSHED_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
                            if (not link) then
                                lootplayer, link = msg:match("^" .. LOOT_ITEM:gsub("%%s", "(.+)"));
                                if (not link) then
                                    lootplayer, link = msg:match("^" .. LOOT_ITEM_PUSHED:gsub("%%s", "(.+)"));
                                end
                            end
                        end
                    end
                end
            end
        end

        if buy and not lootplayer then return end   -- 你是否刚购买了物品
        if quest and not lootplayer then return end -- 是否获得了任务物品
        if not link then return end
        if not lootplayer then lootplayer = BG.playerName end
        if not count then count = 1 end

        local name, _, quality, level, _, _, _, stackCount, _, Texture, _, typeID, subclassID, bindType = GetItemInfo(link)
        if bindType == 4 then return end -- 属于任务物品的不记录
        local itemID = GetItemInfoInstant(link)
        if stackCount == 1 and BG.ValueInTable(BG.Loot.stackItems, itemID) then
            stackCount = 10
        end
        for _, id in ipairs(BG.Loot.blacklist) do -- 过滤黑名单物品
            if itemID == id then
                return
            end
        end

        local Iswhitelist
        if not BG.DeBug then
            for _, id in ipairs(BG.Loot.whitelist) do -- 过滤白名单物品
                if itemID == id then
                    Iswhitelist = true
                    break
                end
            end
            if BG.verLess2 then
                if typeID == 9 and quality >= 3 then -- 60服蓝色图纸
                    Iswhitelist = true
                end
            end
            if not Iswhitelist then
                if quality < BG.lootQuality[FB] then
                    return
                end
                -- 不记录牌子、宝石
                if typeID == 10 or typeID == 3 then
                    return
                end
                -- 过滤附魔分解的物品（例如：深渊水晶），subclassID==0 是60年代的附魔材料子分类
                if typeID == 7 and (subclassID == 12 or subclassID == 0) then
                    return
                end
            end
        end
        remindUpdateFrame:SetScript("OnUpdate", nil)

        -- 更新装备库已掉落显示
        if BG.ItemLibMainFrame:IsVisible() then
            local itemID = BG.GetLeiTingItem(itemID, FB)
            -- 装备库
            local count = BG.ItemLibMainFrame.buttoncount
            if count then
                for i = 1, count do
                    local get = BG.ItemLibMainFrame.buttons[i].get
                    local _itemID = BG.ItemLibMainFrame.buttons[i].itemID
                    if _itemID == itemID then
                        get.looted:Show()
                        break
                    end
                end
            end
            -- 心愿汇总
            for k, bt in pairs(BG.ItemLibMainFrame.Hope) do
                if type(bt) == "table" and bt.EquipLoc then
                    local _itemID = GetItemID(bt:GetText())
                    if _itemID == itemID then
                        bt.looted:Show()
                    end
                end
            end
        end
        -- 心愿装备
        local isHope = BG.ItemIsHope(FB, link, Texture, level, BG.GetLeiTingItem(itemID, FB))
        -- 可堆叠物品记录到杂项
        if stackCount ~= 1 then
            AddLootItem_stackCount(FB, nil, link, Texture, level, isHope, count, typeID, lootplayer)
            return
        end
        -- 特殊物品总是记录到杂项
        for _, _itemID in ipairs(BG.Loot.zaXiangItems) do
            if _itemID == itemID then
                local numb = Maxb[FB] - 1
                AddLootItem(FB, numb, link, Texture, level, isHope, count, typeID, lootplayer, nil)
                return
            end
        end
        -- 图纸、坐骑记录到杂项
        if typeID == 9 or (typeID == 15 and subclassID == 5) then
            local numb = Maxb[FB] - 1
            AddLootItem(FB, numb, link, Texture, level, isHope, count, typeID, lootplayer, nil, typeID == 9)
            return
        end
        -- ICC小怪掉落总是记录到杂项
        if FB == "ICC" then
            for key, value in pairs(BG.Loot.ICC.H25.boss14) do
                if itemID == value then
                    local numb = Maxb[FB] - 1
                    AddLootItem(FB, numb, link, Texture, level, isHope, count, typeID, lootplayer)
                    return
                end
            end
        end
        -- TOC嘉奖宝箱通过读取掉落列表来记录装备
        if FB == "TOC" and itemID ~= 47242 then
            local difID = GetRaidDifficultyID()
            local hard
            if difID == 6 or difID == 194 then
                hard = "H25"
            elseif difID == 5 or difID == 193 then
                hard = "H10"
            elseif difID == 4 or difID == 176 then
                hard = "N25"
            elseif difID == 3 or difID == 175 then
                hard = "N10"
            end
            if hard == "H25" or hard == "H10" then
                for i, _itemID in ipairs(BG.Loot.TOC[hard].boss6) do
                    if itemID == _itemID then
                        local numb = 6
                        AddLootItem(FB, numb, link, Texture, level, isHope, count, typeID, lootplayer)
                        return
                    end
                end
            end
            for b = 3, 4 do
                for i, _itemID in ipairs(BG.Loot.TOC[hard]["boss" .. b]) do
                    if itemID == _itemID then
                        local numb = b
                        AddLootItem(FB, numb, link, Texture, level, isHope, count, typeID, lootplayer)
                        return
                    end
                end
            end
        end
        -- plus神庙老3
        if FB == "Temple" then
            for _, _itemID in pairs(BG.Loot.Temple.N.boss3) do
                if itemID == _itemID then
                    local numb = 3
                    AddLootItem(FB, numb, link, Texture, level, isHope, count, typeID, lootplayer)
                    return
                end
            end
        end
        -- 正常拾取
        if not numb then
            numb = Maxb[FB] - 1 -- 第一个boss前的小怪设为杂项
        end
        AddLootItem(FB, numb, link, Texture, level, isHope, count, typeID, lootplayer)
    end
    ns.LootItem = LootItem

    BG.RegisterEvent("CHAT_MSG_LOOT", LootItem)
end)

----------一键分配装备给自己----------
BG.Init2(function()
    if BG.IsRetail then return end

    local blackList = {
        52019, -- 小宝的丝带
    }

    local cpPlayer, cpItemID, GetInfo, testItem

    local function IsTrueLoot(quality, bindType, itemStackCount, typeID, itemLink)
        local itemID = GetItemID(itemLink)
        if itemID then
            if itemID == cpItemID and cpPlayer then
                return false
            end
            if BG.ValueInTable(blackList, itemID) then
                return
            end
        end

        local _quality = GetLootThreshold()
        if _quality then
            if quality < _quality then
                return
            end
            if bindType == 4 then          -- 任务物品
                return
            elseif bindType == 1 then      -- 拾取绑定的
                if itemStackCount > 1 then -- 堆叠数量大于1
                    return
                end
            end
            return true
        end
    end

    local function OnEnter(self)
        self.isOnter = true
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(L["一键分配"], 1, 1, 1, true)
        GameTooltip:AddLine(L["把全部可交易的物品分配给自己。"], 1, 0.82, 0, true)
        GameTooltip:AddLine(BG.STC_dis(L["你可在插件设置-BiaoGe-其他功能里关闭这个功能。"]), 0.5, 0.5, 0.5, true)

        local items = {}
        for li = 1, GetNumLootItems() do
            if LootSlotHasItem(li) then
                local itemLink = GetLootSlotLink(li)
                if itemLink then
                    local name, link, quality, level, _, _, _, itemStackCount, _, Texture,
                    _, typeID, _, bindType = GetItemInfo(itemLink)
                    if IsTrueLoot(quality, bindType, itemStackCount, typeID, itemLink) then
                        tinsert(items, AddTexture(Texture, -3) .. link .. "|cffFFFFFF(" .. level .. ")|r")
                    end
                end
            end
        end
        GameTooltip:AddLine(" ", 1, 1, 0, true)
        GameTooltip:AddLine(L["点击后会把这些物品分配给你："], 1, 1, 0, true)
        if next(items) then
            for i, item in ipairs(items) do
                GameTooltip:AddLine(i .. ". " .. item, 1, 1, 0)
            end
        else
            GameTooltip:AddLine(BG.STC_dis(L["没有符合条件的物品。"]), 1, 1, 0, true)
        end

        if cpItemID and cpPlayer then
            local items = {}
            for li = 1, GetNumLootItems() do
                for ci = 1, GetNumGroupMembers() do
                    if LootSlotHasItem(li) and GetMasterLootCandidate(li, ci) == cpPlayer then
                        local itemLink = GetLootSlotLink(li)
                        if itemLink then
                            local itemID = GetItemID(itemLink)
                            if itemID == cpItemID then
                                local name, link, quality, level, _, _, _, itemStackCount, _, Texture,
                                _, typeID, _, bindType = GetItemInfo(itemLink)
                                tinsert(items, AddTexture(Texture, -3) .. link .. "|cffFFFFFF(" .. level .. ")|r")
                            end
                        end
                        break
                    end
                end
            end
            if next(items) then
                GameTooltip:AddLine(" ", 1, 1, 0, true)
                GameTooltip:AddLine(format(L["这些物品分配给>%s<："], SetClassCFF(cpPlayer)), 1, 1, 0, true)
                for i, item in ipairs(items) do
                    GameTooltip:AddLine(i .. ". " .. item, 1, 1, 0)
                end
            end
        end
        GameTooltip:Show()
    end

    local parent = ElvLootFrame or XLootFrame or LootFrame
    BG.autoLootButton = BG.CreateButton(parent)
    do
        BG.autoLootButton:SetPoint("BOTTOM", parent, "TOP", 0, 0)
        BG.autoLootButton:SetText(L["一键分配"])
        BG.autoLootButton:SetSize(BG.autoLootButton:GetFontString():GetWidth() + 10, 25)
        BG.autoLootButton:SetFrameLevel(parent:GetFrameLevel() + 10)
        BG.autoLootButton:Hide()
        BG.autoLootButton = BG.autoLootButton
        BG.autoLootButton:SetScript("OnEnter", OnEnter)
        BG.autoLootButton:SetScript("OnLeave", function(self)
            self.isOnter = false
            GameTooltip:Hide()
        end)
        BG.autoLootButton:SetScript("OnClick", function(self)
            BG.PlaySound(1)
            self:GiveLoot()
        end)

        BG.autoLootButton.SPbutton = CreateFrame("Button", nil, BG.autoLootButton)
        BG.autoLootButton.SPbutton:SetSize(1, 20)
        BG.autoLootButton.SPbutton:SetPoint("BOTTOM", BG.autoLootButton, "TOP", 0, 0)
        BG.autoLootButton.SPbutton:SetNormalFontObject(BG.FontGreen15)
        BG.autoLootButton.SPbutton:SetDisabledFontObject(BG.FontDis15)
        BG.autoLootButton.SPbutton:SetHighlightFontObject(BG.FontWhite15)
        BG.autoLootButton.SPbutton.title = L["|cffff8000橙片：|r"]
        BG.autoLootButton.SPbutton:RegisterForClicks("AnyUp")
        BG.autoLootButton.SPbutton.owner = BG.autoLootButton
        BG.SetTextHighlightTexture(BG.autoLootButton.SPbutton)
        BG.autoLootButton.SPbutton:SetScript("OnClick", function(self, button)
            if button == "LeftButton" then
                if self.frame and self.frame:IsVisible() then
                    self.frame:Hide()
                else
                    self:ShowRaidMember()
                end
            elseif button == "RightButton" then
                if self.frame then
                    self.frame:Hide()
                end
                cpPlayer = nil
                self:Update()
            end
        end)
        BG.autoLootButton.SPbutton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["橙片"], 1, 1, 1, true)
            GameTooltip:AddLine(AddTexture("LEFT") .. L["选择指定人员"], 1, 0.82, 0, true)
            GameTooltip:AddLine(AddTexture("RIGHT") .. L["清除指定人员"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        BG.autoLootButton.SPbutton:SetScript("OnLeave", GameTooltip_Hide)
    end

    function BG.autoLootButton:GiveLoot()
        if not IsMasterLooter() then return end
        for li = 1, GetNumLootItems() do
            for ci = 1, GetNumGroupMembers() do
                if LootSlotHasItem(li) and GetMasterLootCandidate(li, ci) == BG.playerName then
                    local itemLink = GetLootSlotLink(li)
                    if itemLink then
                        local name, link, quality, level, _, _, _, itemStackCount, _, Texture,
                        _, typeID, _, bindType = GetItemInfo(itemLink)
                        if IsTrueLoot(quality, bindType, itemStackCount, typeID, itemLink) then
                            GiveMasterLoot(li, ci)
                        end
                    end
                    break
                end
            end
        end

        if cpItemID and cpPlayer then
            local count = BG.autoLoot[cpPlayer] and
                BG.autoLoot[cpPlayer][cpItemID]
            if count then
                if count == "finish" then
                    BG.SendSystemMessage(format(L["|cffff0000%s的橙片任务已完成，不能分配给它！|r"], SetClassCFF(cpPlayer)))
                    return
                else
                    local info = GetInfo()
                    if info.maxCount then
                        local lootCount = 0
                        for li = 1, GetNumLootItems() do
                            if LootSlotHasItem(li) then
                                local itemLink = GetLootSlotLink(li)
                                if itemLink then
                                    local itemID = GetItemID(itemLink)
                                    if itemID == cpItemID then
                                        local lootQuantity = select(3, GetLootSlotInfo(li)) or 1
                                        lootCount = lootCount + lootQuantity
                                    end
                                end
                            end
                        end
                        if lootCount + count > info.maxCount then
                            BG.SendSystemMessage(format(L["|cffff0000%s的橙片可能已达上限，不能分配给它！|r"], SetClassCFF(cpPlayer)))
                            return
                        end
                    end
                end
            end
            BG.After(0, function()
                for li = 1, GetNumLootItems() do
                    for ci = 1, GetNumGroupMembers() do
                        if LootSlotHasItem(li) and GetMasterLootCandidate(li, ci) == cpPlayer then
                            local itemLink = GetLootSlotLink(li)
                            if itemLink then
                                local itemID = GetItemID(itemLink)
                                if itemID == cpItemID then
                                    GiveMasterLoot(li, ci)
                                end
                            end
                            break
                        end
                    end
                end
            end)
        end
    end

    function BG.autoLootButton.SPbutton:ShowRaidMember()
        local mainFrame = CreateFrame("Frame", nil, self, "BackdropTemplate")
        do
            mainFrame:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeSize = 1,
            })
            mainFrame:SetBackdropColor(0, 0, 0, .9)
            mainFrame:SetBackdropBorderColor(1, 1, 1, .5)
            mainFrame:SetSize(405, 380)
            mainFrame:SetPoint("TOPLEFT", self, "TOPRIGHT", 5, 0)
            mainFrame:SetFrameLevel(200)
            mainFrame:SetToplevel(true)
            mainFrame:EnableMouse(true)
            mainFrame:SetClampedToScreen(true)
            mainFrame.buttons = {}
            self.frame = mainFrame
            mainFrame.CloseButton = CreateFrame("Button", nil, mainFrame, "UIPanelCloseButton")
            mainFrame.CloseButton:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", 2, 2)
            mainFrame:SetScript("OnHide", function(self)
                self:Hide()
            end)
        end

        local function CreateRaidButton(i)
            local f = CreateFrame("Frame", nil, mainFrame, "BackdropTemplate")
            do
                f:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = 1,
                })
                f:SetBackdropColor(0, 0, 0, .2)
                f:SetBackdropBorderColor(1, 1, 1, .2)
                f:SetSize(90, 30)
                if i == 1 then
                    f:SetPoint("TOPLEFT", 15, -25)

                    local text = f:CreateFontString()
                    text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
                    text:SetPoint("BOTTOM", f, "TOP", 0, 2)
                    text:SetText(1)
                    text:SetTextColor(.5, .5, .5)
                elseif i == 21 then
                    f:SetPoint("TOPLEFT", mainFrame.buttons[5], "BOTTOMLEFT", 0, -30)

                    local text = f:CreateFontString()
                    text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
                    text:SetPoint("BOTTOM", f, "TOP", 0, 2)
                    text:SetText((i - 1) / 5 + 1)
                    text:SetTextColor(.5, .5, .5)
                elseif (i - 1) % 5 == 0 then
                    f:SetPoint("TOPLEFT", mainFrame.buttons[i - 5], "TOPRIGHT", 5, 0)

                    local text = f:CreateFontString()
                    text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
                    text:SetPoint("BOTTOM", f, "TOP", 0, 2)
                    text:SetText((i - 1) / 5 + 1)
                    text:SetTextColor(.5, .5, .5)
                else
                    f:SetPoint("TOPLEFT", mainFrame.buttons[i - 1], "BOTTOMLEFT", 0, -1)
                end
                tinsert(mainFrame.buttons, f)

                local tex = f:CreateTexture()
                tex:SetPoint("CENTER", f, "TOPLEFT", 2, -2)
                tex:SetSize(10, 10)
                f.icon = tex

                local text = f:CreateFontString()
                text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
                text:SetPoint("TOPLEFT", 2, -1)
                text:SetWidth(f:GetWidth() - 5)
                text:SetJustifyH("LEFT")
                text:SetWordWrap(false)
                f.nameText = text

                local text = f:CreateFontString()
                text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
                text:SetPoint("BOTTOMLEFT", 2, 2)
                text:SetWidth(f:GetWidth() - 5)
                text:SetJustifyH("LEFT")
                text:SetWordWrap(false)
                f.infoText = text
            end

            function f:GetPlayer()
                return f.player
            end

            f:SetScript("OnMouseDown", function()
                if not f:GetPlayer() then return end
                BG.PlaySound(1)
                cpPlayer = f.player
                mainFrame:Hide()
                self:Update()
            end)

            f:SetScript("OnEnter", function()
                if f:GetPlayer() then
                    f:SetBackdropColor(.5, .5, .5, .2)
                end
                if not f.tips then return end
                GameTooltip:SetOwner(f, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                local r, g, b = f.nameText:GetTextColor()
                GameTooltip:AddLine(f.nameText:GetText(), r, g, b, true)
                if f.tips == "finish" then
                    GameTooltip:AddLine(L["已完成橙片任务。"], 0, 1, 0, true)
                else
                    GameTooltip:AddLine(L["未知橙片数量|cffFFD100（该玩家可能未安装BiaoGe插件，或者BiaoGe插件版本太低）|r"], 1, 0, 0, true)
                end
                GameTooltip:Show()
            end)
            f:SetScript("OnLeave", function()
                f:SetBackdropColor(0, 0, 0, .2)
                GameTooltip:Hide()
            end)
        end

        for i = 1, 40 do
            CreateRaidButton(i)
        end

        for i, v in ipairs(BG.raidRosterInfo) do
            local team = v.subgroup
            local bt
            for i = 1, 5 do
                if not mainFrame.buttons[(team - 1) * 5 + i].player then
                    bt = mainFrame.buttons[(team - 1) * 5 + i]
                    break
                end
            end
            bt.player = v.name
            bt.nameText:SetText(v.name)
            local r, g, b = GetClassColor(v.class)
            bt.nameText:SetTextColor(r, g, b)
            local infoText = ""
            if BG.autoLoot[v.name] and BG.autoLoot[v.name][cpItemID] then
                infoText = BG.autoLoot[v.name][cpItemID]
                if infoText == "finish" then
                    infoText = L["|cff00ff00已完成任务|r"]
                    bt.tips = "finish"
                elseif infoText == 0 then
                    infoText = BG.STC_dis(infoText)
                end
            else
                infoText = L["|cff808080未知数量|r"]
                bt.tips = "not"
            end
            bt.infoText:SetText(infoText)

            if v.rank == 2 then
                bt.icon:SetTexture("interface/groupframe/ui-group-leadericon")
            elseif v.role == "MAINTANK" then
                bt.icon:SetTexture(132064)
            elseif v.role == "MAINASSIST" then
                bt.icon:SetTexture(132063)
            elseif v.rank == 1 then
                bt.icon:SetTexture("interface/groupframe/ui-group-assistanticon")
            end
        end
    end

    function BG.autoLootButton.SPbutton:Update()
        self:Hide()
        cpItemID = nil
        local info = GetInfo()
        if info then
            cpItemID = info.itemID
            self:Show()
            if cpPlayer then
                local count = BG.autoLoot[cpPlayer] and BG.autoLoot[cpPlayer][cpItemID]
                if count then
                    if type(count) == "number" then
                        count = format("|cffffffff(%s)|r", count)
                    else
                        count = "|cff00ff00(已完成任务)|r"
                    end
                else
                    count = L["|cff808080(未知数量)|r"]
                end
                self:SetText(self.title .. SetClassCFF(cpPlayer) .. count)
            else
                self:SetText(self.title .. L["|cffff0000未指定|r"])
            end
            local width = self:GetFontString():GetWidth() + 10
            self:SetWidth(width)
            self.owner:SetWidth(width)
        end
    end

    -- 时光服世界BOSS
    if BG.IsTitan then
        local FB = "Worldtitan"
        BG.saveWorldBossLoot = {}
        BG.saveWorldBossLoot.isSave = {}

        -- 记录到表格
        do
            local bt = BG.CreateButton(parent)
            bt:SetPoint("TOPLEFT", parent, "TOP", 0, 25)
            bt:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", 0, 0)
            bt:SetText(L["记录到表格"])
            bt:SetSize(bt:GetFontString():GetWidth() + 10, 25)
            bt:Hide()
            BG.saveLootButton = bt
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
                GameTooltip:AddLine(L["把全部掉落记录到BOSS对应的表格。"], 1, 0.82, 0, true)
                GameTooltip:AddLine(" ", 1, 0.82, 0, true)
                GameTooltip:AddLine(L["如果BOSS格子里已有旧记录，则会自动清空旧记录。"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", function(self)
                self.isOnter = false
                GameTooltip:Hide()
            end)
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                wipe(BG.saveWorldBossLoot.isSave)
                BG.saveWorldBossLoot:AutoSave()
            end)

            function BG.saveWorldBossLoot:AutoSave()
                local guid = UnitGUID("target")
                if not self.isSave[guid] then
                    self.isSave[guid] = true
                    local numb = self.bossIndex
                    BG.ClearBiaoGeByIndex(FB, numb)
                    for li = 1, GetNumLootItems() do
                        if LootSlotHasItem(li) then
                            local count = select(3, GetLootSlotInfo(li)) or 1
                            local itemLink = GetLootSlotLink(li)
                            if itemLink then
                                local name, link, quality, level, _, _, _, itemStackCount, _, Texture,
                                _, typeID, _, bindType = GetItemInfo(itemLink)
                                local isHope = BG.ItemIsHope(FB, link, Texture, level)
                                BG.AddLootItem(FB, numb, link, Texture, level, isHope, count, typeID)
                            end
                        end
                    end
                    BG.ClickTabButton(BG.FBMainFrameTabNum)
                    BG.ClickFBbutton(FB)
                end
            end
        end

        function BG.saveWorldBossLoot:OnShow()
            if BG.badManLootFrame then
                BG.badManLootFrame:Hide()
            end
            if BG.saveLootButton then
                BG.saveLootButton:Hide()
            end
            if BG.LootAuctionLogButton then
                BG.LootAuctionLogButton:Hide()
            end
            -- BG.saveLootButton:Show() -- debug
            -- BG.LootAuctionLogButton:Show() -- debug
            local guid = UnitGUID("target")
            if not IsInInstance() and guid then
                local npcID = BG.GetNpcID(guid)
                for index, _npcID in ipairs(BG.worldBossNpcID) do
                    if npcID == _npcID then
                        BG.saveWorldBossLoot.bossIndex = index
                        BG.saveWorldBossLoot:AutoSave()
                        BG.saveLootButton:Show()
                        BG.LootAuctionLogButton:Show()
                        BG.LootAuctionLogFrame:SetShown(BiaoGe.options.showLootAuctionLogFrame == 1)
                        BG.badManLootFrameUpdate()
                        break
                    end
                end
            end
        end

        -- 通报CD成员
        local isSend = {}
        function BG.badManLootFrameUpdate()
            if IsMasterLooter() then
                local list = {}
                local quality = GetLootThreshold()
                local point = BG.GetRaidPoint()
                for li = 1, GetNumLootItems() do
                    if LootSlotHasItem(li) then
                        local lootIcon, lootName, lootQuantity, currencyID, lootQuality = GetLootSlotInfo(li)
                        if lootQuality >= quality then
                            for ci = 1, GetNumGroupMembers() do
                                if not GetMasterLootCandidate(li, ci) then
                                    local unit = "raid" .. ci
                                    local name = GetUnitName(unit, true)
                                    if name and not list[name] then
                                        local colorName = SetClassCFF(name, unit)
                                        list[name] = { colorName = colorName, point = point[name] }
                                    end
                                end
                            end
                        end
                    end
                end
                if next(list) then
                    local f = CreateFrame("Frame", nil, parent)
                    f:SetSize(1, 1)
                    f:SetPoint("TOPLEFT", parent, "TOPRIGHT", 2, 0)
                    local t = f:CreateFontString()
                    t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                    t:SetPoint("TOPLEFT")
                    t:SetTextColor(1, 0, 0)
                    t:SetText(L["以下玩家无法分配装备：\n(已有CD或没进战斗)"])
                    t:SetJustifyH("LEFT")
                    BG.badManLootFrame = f
                    local count = 0
                    local sendTbl = {}
                    for name, v in pairs(list) do
                        local colorName = v.colorName
                        local point = v.point
                        local pointStr = point and L["（%s）"]:format(point) or ""
                        count = count + 1
                        local t = f:CreateFontString()
                        t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                        t:SetPoint("TOPLEFT", 0, -count * 20 - 15)
                        t:SetText(count .. L["、"] .. colorName .. pointStr)
                        tinsert(sendTbl, { count .. L["、"] .. name .. pointStr })
                    end
                    local guid = UnitGUID("target")
                    if guid and not isSend[guid] then
                        isSend[guid] = true
                        tinsert(sendTbl, 1, { L["——通报CD异常玩家——"] })
                        tinsert(sendTbl, 2, { L["无法分配装备(已有CD或没进战斗)："] })
                        BG.SendMsgToRaid(sendTbl)
                    end
                end
            end
        end

        -- 拍卖记录
        do
            BiaoGe.options.showLootAuctionLogFrame = BiaoGe.options.showLootAuctionLogFrame or 1

            BG.LootAuctionLogButton = BG.CreateButton(parent)
            do
                BG.LootAuctionLogButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 25)
                BG.LootAuctionLogButton:SetPoint("BOTTOMRIGHT", parent, "TOP", 0, 0)
                BG.LootAuctionLogButton:Hide()
                BG.LootAuctionLogButton:SetScript("OnClick", function(self)
                    BG.PlaySound(1)
                    BG.LootAuctionLogFrame:SetShown(not BG.LootAuctionLogFrame:IsVisible())
                end)
                BG.LootAuctionLogButton:SetScript("OnShow", function(self)
                    BG.LootAuctionLogButton:UpdateText()
                end)

                function BG.LootAuctionLogButton:UpdateText()
                    self:SetText(BG.LootAuctionLogFrame:IsVisible() and L["关闭拍卖记录"] or L["显示拍卖记录"])
                end
            end

            BG.LootAuctionLogFrame = CreateFrame("Frame", nil, BG.LootAuctionLogButton, "BackdropTemplate")
            do
                BG.LootAuctionLogFrame:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = 1
                })
                BG.LootAuctionLogFrame:SetBackdropColor(0, 0, 0, 0.9)
                BG.LootAuctionLogFrame:SetBackdropBorderColor(r, g, b)
                BG.LootAuctionLogFrame:SetSize(220, 400)
                BG.LootAuctionLogFrame:SetPoint("TOPRIGHT", parent, "TOPLEFT", -2, 0)
                BG.LootAuctionLogFrame:EnableMouse(true)
                BG.LootAuctionLogFrame:SetScale(1)
                BG.LootAuctionLogFrame.buttons = {}
                BG.LootAuctionLogFrame:SetShown(BiaoGe.options.showLootAuctionLogFrame == 1)
                BG.LootAuctionLogFrame:SetScript("OnShow", function(self)
                    BG.LootAuctionLogButton:UpdateText()
                    BiaoGe.options.showLootAuctionLogFrame = BG.LootAuctionLogFrame:IsShown() and 1 or 0
                    if self.cd then return end
                    self.cd = true
                    BG.After(0, function()
                        self.cd = nil
                    end)
                    BG.UpdateLootAuctionLogFrame()
                end)
                BG.LootAuctionLogFrame:SetScript("OnHide", function(self)
                    BG.LootAuctionLogButton:UpdateText()
                    BiaoGe.options.showLootAuctionLogFrame = BG.LootAuctionLogFrame:IsShown() and 1 or 0
                end)

                local t = BG.LootAuctionLogFrame:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, 16, "OUTLINE")
                t:SetPoint("TOP", BG.LootAuctionLogFrame, "TOP", 0, -5)
                t:SetText(L["拍卖记录"])
            end

            -- 滚动框
            do
                local frame = CreateFrame("Frame", nil, BG.LootAuctionLogFrame, "BackdropTemplate")
                frame:SetBackdrop({
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = 1,
                })
                frame:SetBackdropBorderColor(.5, .5, .5, .5)
                frame:SetBackdropColor(0, 0, 0, 0.8)
                frame:SetPoint("TOPLEFT", 5, -25)
                frame:SetPoint("BOTTOMRIGHT", -5, 5)
                frame:EnableMouse(true)
                BG.LootAuctionLogFrame.frame = frame

                local scroll = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
                scroll:SetPoint("TOPLEFT", 5, -5)
                scroll:SetPoint("BOTTOMRIGHT", -26, 5)
                scroll.ScrollBar.scrollStep = BG.scrollStep
                frame.scroll = scroll
                BG.CreateSrollBarBackdrop(scroll.ScrollBar)
                BG.HookScrollBarShowOrHide(scroll)
                BG.LootAuctionLogFrame.scroll = scroll

                local child = CreateFrame("Frame", nil, scroll)
                child:SetAllPoints()
                child:SetWidth(scroll:GetWidth())
                child:SetHeight(scroll:GetHeight())
                scroll:SetScrollChild(child)
                BG.LootAuctionLogFrame.child = child

                local t = child:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                t:SetPoint("TOP", 0, 0)
                t:SetTextColor(1, 0, 0)
                t:SetText(L["没有自动拍卖记录。"])
                t:SetWidth(scroll:GetWidth())
                t:Hide()
                BG.LootAuctionLogFrame.notText = t
            end

            -- 列表内容
            local buttons = BG.LootAuctionLogFrame.buttons
            local function CreateButton(index, v)
                local bts = {}
                local width = BG.LootAuctionLogFrame.child:GetWidth()
                local link = v.zhuangbei
                local itemID = GetItemID(link)
                local icon, typeID = select(5, GetItemInfoInstant(link))
                local r, g, b = GetItemQualityColor(v.quality)
                bts.link = link
                bts.itemID = itemID
                bts.num = index
                -- 主框架
                do
                    local f = CreateFrame("Frame", nil, BG.LootAuctionLogFrame.child, "BackdropTemplate")
                    f:SetSize(width, 32)
                    if not next(buttons) then
                        f:SetPoint("TOPLEFT")
                    else
                        f:SetPoint("TOPLEFT", buttons[#buttons].frame, "BOTTOMLEFT", 0, 0)
                    end
                    f.link = link
                    bts.frame = f
                    f:SetScript("OnEnter", function(self)
                        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                        GameTooltip:ClearLines()
                        local itemID = GetItemInfoInstant(link)
                        if itemID then
                            GameTooltip:SetHyperlink(BG.SetSpecIDToLink(link))
                        end
                        bts.ds:Show()
                    end)
                    f:SetScript("OnLeave", function(self)
                        GameTooltip:Hide()
                        bts.ds:Hide()
                    end)

                    local tex = bts.frame:CreateTexture(nil, "BACKGROUND")
                    tex:SetAllPoints()
                    if index % 2 == 0 then
                        tex:SetColorTexture(.5, .5, .5, .15)
                    else
                        tex:SetColorTexture(0, 0, 0, .25)
                    end
                    bts.tex = tex

                    local tex = bts.frame:CreateTexture()
                    tex:SetAllPoints()
                    tex:SetColorTexture(.5, .5, .5, .5)
                    tex:Hide()
                    bts.ds = tex

                    tinsert(buttons, bts)
                end
                -- 图标和装等
                do
                    local f = CreateFrame("Frame", nil, bts.frame, "BackdropTemplate")
                    f:SetBackdrop({
                        edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                        edgeSize = 1,
                    })
                    f:SetBackdropBorderColor(r, g, b)
                    f:SetSize(bts.frame:GetHeight() - 2, bts.frame:GetHeight() - 2)
                    f:SetPoint("LEFT")
                    bts.iconFrame = f
                    local tex = f:CreateTexture(nil, "BACKGROUND")
                    tex:SetAllPoints()
                    tex:SetTexture(icon)
                    tex:SetTexCoord(unpack(BG.iconTexCoord))
                    bts.icon = tex
                    f.level = f:CreateFontString()
                    f.level:SetFont(BIAOGE_TEXT_FONT, 11, "OUTLINE")
                    f.level:SetPoint("BOTTOM", bts.icon, 0, 1)
                    f.level:SetText((typeID == 2 or typeID == 4) and v.itemlevel or nil)
                    f.level:SetTextColor(r, g, b)
                    if v.bindType == 2 then
                        local text = bts.iconFrame:CreateFontString()
                        text:SetFont(BIAOGE_TEXT_FONT, 10, "OUTLINE")
                        text:SetPoint("TOP", bts.iconFrame, 0, -1)
                        text:SetText(L["装绑"])
                        text:SetTextColor(0, 1, 0)
                    end
                end
                -- 装备
                do
                    local text = bts.frame:CreateFontString()
                    text:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
                    text:SetWidth(width - bts.icon:GetWidth())
                    text:SetPoint("TOPLEFT", bts.icon, "TOPRIGHT", 1, 0)
                    text:SetText(link:gsub("%[", ""):gsub("%]", ""))
                    text:SetJustifyH("LEFT")
                    text:SetWordWrap(false)
                    bts.item = text
                end
                -- 买家和金额
                do
                    local text = bts.frame:CreateFontString()
                    text:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
                    text:SetPoint("BOTTOMLEFT", bts.icon, "BOTTOMRIGHT", 1, 0)
                    text:SetWidth(width - bts.icon:GetWidth())
                    text.LiuPaiText = BG.STC_r1(L["<流拍>"])
                    if v.type == 1 then
                        local color = "FFFFFF"
                        if v.color then
                            local r, g, b = unpack(v.color)
                            color = ns.RGB_16(nil, r, g, b)
                        end
                        text:SetText(format("%s |cff%s%s|r", BG.FormatNumber(v.jine, 2), color, v.maijia))
                    else
                        text:SetText(text.LiuPaiText)
                    end
                    text:SetJustifyH("LEFT")
                    text:SetWordWrap(false)
                    bts.money = text
                end
            end

            function BG.UpdateLootAuctionLogFrame()
                if not BG.LootAuctionLogFrame:IsVisible() then return end
                for i, v in ipairs(BG.LootAuctionLogFrame.buttons) do
                    v.frame:Hide()
                end
                wipe(BG.LootAuctionLogFrame.buttons)
                BG.LootAuctionLogFrame.notText:Show()
                local tbl = BiaoGe[FB].auctionLog
                if tbl then
                    for index, v in ipairs(tbl) do
                        CreateButton(index, v)
                    end
                end
                if tbl and next(tbl) then
                    BG.LootAuctionLogFrame.notText:Hide()
                end
            end
        end
    end

    -- 拾取框显示
    do
        local function HasSP()
            local info = GetInfo()
            if info then
                local itemID = info.itemID
                for i = 1, GetNumLootItems() do
                    if LootSlotHasItem(i) then
                        local itemLink = GetLootSlotLink(i)
                        if itemLink then
                            local _itemID = GetItemID(itemLink)
                            if itemID == _itemID then
                                return true
                            end
                        end
                    end
                end
            end
        end

        local function OnMouseDown(self, button)
            if IsAltKeyDown() and BG.IsML and LootSlotHasItem(self.slot) then
                local link = GetLootSlotLink(self.slot)
                if link then
                    BG.StartAuction(link, self, nil, nil, button == "RightButton")
                end
            end
        end
        local lootName = (ElvLootFrame and "ElvLootSlot") or (XLootFrame and "XLootFrameButton") or "LootButton"
        local function HookClick()
            for i = 1, 20 do
                local bt = _G[lootName .. i]
                if bt and not bt.biaogeHook then
                    bt.biaogeHook = true
                    if not bt.slot then
                        bt.slot = i
                    end
                    bt:HookScript("OnMouseDown", OnMouseDown)
                end
            end
        end

        local function OnShow()
            BG.autoLootButton.isOnter = false
            BG.autoLootButton:Hide()
            if BiaoGe.options["allLootToMe"] == 1 and IsMasterLooter() and IsInInstance() then
                BG.autoLootButton:Show()
                BG.autoLootButton.SPbutton:Update()
                if BiaoGe.options["autoAllLootToMe"] == 1 and not IsModifierKeyDown() then
                    BG.After(0.1, function()
                        if not HasSP() then
                            BG.autoLootButton:GiveLoot()
                        end
                    end)
                end
            end
            if BG.saveWorldBossLoot then
                BG.saveWorldBossLoot:OnShow()
            end
            BG.After(.2, function()
                HookClick()
            end)
        end

        hooksecurefunc("LootFrame_Show", OnShow)
        if ElvLootFrame then
            ElvLootFrame:HookScript("OnShow", OnShow)
        end
        if XLootFrame then
            XLootFrame:HookScript("OnShow", OnShow)
        end

        -- 当物品被捡走时，刷新鼠标提示工具
        BG.RegisterEvent("LOOT_SLOT_CLEARED", function(self, event)
            if BG.autoLootButton.isOnter and BG.autoLootButton:IsEnabled() then
                OnEnter(BG.autoLootButton)
            end
        end)
    end

    -- 橙片
    do
        BG.autoLoot = {}
        BG.autoLoot.info = {}
        if BG.IsVanilla_60 then
            BG.autoLoot.info = {
                NAXX = { { itemID = 22726, quest = 9250, maxCount = 40 } },
            }
        elseif BG.IsWLK then
            BG.autoLoot.info = {
                ICC = {
                    { itemID = 50274, quest = 24548, maxCount = 50, diff = { 4, 6, 176, 194 } }, -- 25人橙斧
                    { itemID = 45038, quest = 13622, maxCount = 30, diff = { 3, 5, 175, 193 } }, -- 10人橙锤
                },
                NAXXtitan = { { itemID = 22726, quest = 9250, maxCount = 40 } },
            }
        elseif BG.IsCTM then
            BG.autoLoot.info = {
                DS = {
                    { itemID = 77952, quest = 30116 },
                },
            }
        end

        function GetInfo()
            if BG.DeBug then
                -- return { itemID = testItem, quest = 13622, maxCount = 30, diff = { 3, 5, 175, 193 } }
                return { itemID = testItem, quest = 13622, maxCount = 40 }
            end
            local info = BG.FB2 and BG.autoLoot.info[BG.FB2]
            if info then
                local _info
                local diff = GetRaidDifficultyID()
                for _, items in ipairs(info) do
                    if items.diff then
                        for _, _diff in ipairs(items.diff) do
                            if diff == _diff then
                                _info = items
                                break
                            end
                        end
                    else
                        _info = items
                        break
                    end
                end
                return _info
            end
        end

        -- BOSS战结束后，发送自己的橙片数量到插件频道，以便物品分配者查看每个人的橙片数量
        BG.RegisterEvent("ENCOUNTER_END", function(self, event, bossID, _, _, _, success)
            if success == 1 then
                local info = GetInfo()
                if info and IsInRaid(1) then
                    local count = GetItemCount(info.itemID, true)
                    if info.quest and C_QuestLog.IsQuestFlaggedCompleted(info.quest) then
                        count = "finish"
                    end
                    local msg = format("AutoLoot,%s,%s", info.itemID, count)
                    C_ChatInfo.SendAddonMessage("BiaoGe", msg, "RAID")
                end
            end
        end)

        -- 获取刚刚时谁拾取了橙片，如果是自己拾取的，则发送消息到插件频道
        local lootplayer
        BG.RegisterEvent("CHAT_MSG_LOOT", function(self, event, msg)
            local info = GetInfo()
            if info and IsInRaid(1) then
                local _lootplayer, link, count
                link, count = strmatch(msg, string.gsub(string.gsub(LOOT_ITEM_SELF_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
                if (not link) then
                    link, count = strmatch(msg, string.gsub(string.gsub(LOOT_ITEM_PUSHED_SELF_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
                    if (not link) then
                        link = msg:match(LOOT_ITEM_SELF:gsub("%%s", "(.+)"));
                        if (not link) then
                            link = msg:match(LOOT_ITEM_PUSHED_SELF:gsub("%%s", "(.+)"));

                            if (not link) then
                                _lootplayer, link, count = strmatch(msg, string.gsub(string.gsub(LOOT_ITEM_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
                                if (not link) then
                                    _lootplayer, link, count = strmatch(msg, string.gsub(string.gsub(LOOT_ITEM_PUSHED_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
                                    if (not link) then
                                        _lootplayer, link = msg:match("^" .. LOOT_ITEM:gsub("%%s", "(.+)"));
                                        if (not link) then
                                            _lootplayer, link = msg:match("^" .. LOOT_ITEM_PUSHED:gsub("%%s", "(.+)"));
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if link then
                    local itemID = GetItemID(link)
                    if itemID == info.itemID then
                        lootplayer = _lootplayer or BG.playerName
                        if lootplayer == BG.playerName then
                            BG.After(1, function()
                                local count = GetItemCount(info.itemID, true)
                                local msg = format("AutoLoot,%s,%s,print", info.itemID, count)
                                C_ChatInfo.SendAddonMessage("BiaoGe", msg, "RAID")
                            end)
                        end
                    end
                end
            end
        end)

        BG.RegisterEvent("CHAT_MSG_ADDON", function(self, event, prefix, msg, distType, sender)
            if not (prefix == "BiaoGe" and distType == "RAID") then return end
            local arg1, itemID, count, canprint = strsplit(",", msg)
            sender = BG.GSN(sender)
            if arg1 == "AutoLoot" then
                itemID = tonumber(itemID)
                if tonumber(count) then
                    count = tonumber(count)
                end
                BG.autoLoot[sender] = BG.autoLoot[sender] or {}
                BG.autoLoot[sender][itemID] = count
                if sender == BG.autoLootButton.cpPlayer then
                    BG.autoLootButton.SPbutton:Update()
                end
                -- 如果是刚刚拾取橙片的玩家发过来的插件消息
                -- if canprint == "print" and sender == lootplayer then
                --     if itemID ~= 77952 and not (BG.IsTitan and itemID == 22726) then
                --         BG.SendSystemMessage(format(L["%s当前橙片数量：%s"], SetClassCFF(lootplayer), count))
                --     end
                -- end
            end
        end)

        BG.RegisterEvent("GROUP_ROSTER_UPDATE", function(self, event)
            BG.After(.5, function()
                if not IsInRaid(1) then
                    cpPlayer = nil
                    lootplayer = nil
                end
            end)
        end)

        -- BG.DeBug = true
        -- testItem = 5071
    end
end)

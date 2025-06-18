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
        f:SetFont(STANDARD_TEXT_FONT, BiaoGe.options["lootFontSize"] or 20, "OUTLINE")
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
        f.name:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
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
                BiaoGe.lastGuoQiTime = GetServerTime() + 3300
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
            and IsMasterLooter() and GetLootMethod() == "master" then
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
    f:SetScript("OnEvent", function(self, event, bossID, _, _, _, success)
        local FB = BG.FB2
        if not FB then return end
        if event == "ENCOUNTER_START" then
            start = true
            if IsBWLsod_boss5orboss6(bossID) then
                numb = IsBWLsod_boss5orboss6(bossID)
                lasttime = GetTime()
            else
                for _numb, _bossID in ipairs(BG.Loot.encounterID[FB]) do
                    if bossID and (bossID == _bossID) then
                        numb = _numb
                        lasttime = GetTime()
                        return
                    end
                end
            end
        elseif event == "ENCOUNTER_END" then
            if success == 1 then
                if IsBWLsod_boss5orboss6(bossID) then
                    numb = IsBWLsod_boss5orboss6(bossID)
                    lasttime = GetTime()
                else
                    for _numb, _bossID in ipairs(BG.Loot.encounterID[FB]) do
                        if bossID and (bossID == _bossID) then
                            numb = _numb
                            lasttime = GetTime()
                            start = nil
                            BiaoGe[FB].raidRoster = { time = GetServerTime(), realm = GetRealmName(), roster = {} }
                            for i, v in ipairs(BG.raidRosterInfo) do
                                tinsert(BiaoGe[FB].raidRoster.roster, v.name)
                            end
                            NotLootRemind()
                            return
                        end
                    end
                end
            else
                numb = Maxb[FB] - 1
                start = nil
            end
        end
    end)
    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_REGEN_DISABLED") -- 进入战斗
    f:SetScript("OnEvent", function(self, event, ID)
        local FB = BG.FB2
        if not FB then return end
        if start then return end
        _time = GetTime()
        if numb ~= Maxb[FB] - 1 then
            if _time - lasttime >= 45 then -- 击杀BOSS x秒后进入下一次战斗，就变回杂项
                numb = Maxb[FB] - 1
                -- local text = BG.STC_r1(L["非BOSS战"])
                -- PrintLootBoss(FB, event, numb, text)
            end
        end
    end)

    -- 记录拾取信息
    local function AddLootLog(FB, numb, i, lootplayer, count)
        BiaoGe[FB]["boss" .. numb]["loot" .. i] = BiaoGe[FB]["boss" .. numb]["loot" .. i] or {}
        tinsert(BiaoGe[FB]["boss" .. numb]["loot" .. i], {
            time = GetServerTime(),
            player = lootplayer,
            class = select(2, UnitClass(lootplayer)),
            count = count,
        })
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
                    BG.FrameLootMsg:AddMessage(BG.STC_g2(format(L["自动关注心愿装备：%s。团长拍卖此装备时会提醒"],
                        (AddTexture(Texture) .. link))))
                end
                if count == 1 then
                    zb:SetText(link)
                    duizhangzb:SetText(link)
                    BiaoGe[FB]["boss" .. numb]["zhuangbei" .. i] = link
                    if BiaoGe.options["autolootNotice"] == 1 then
                        BG.FrameLootMsg:AddMessage(icon .. "|cff00BFFF" ..
                            format(L["已自动记入表格：%s%s%s => %s< %s >%s"], RR, (AddTexture(Texture) .. link),
                                levelText, "|cff" .. BG.Boss[FB]["boss" .. numb]["color"],
                                BG.Boss[FB]["boss" .. numb]["name2"], RR) .. icon)
                    end
                else
                    zb:SetText(link .. "x" .. count)
                    duizhangzb:SetText(link .. "x" .. count)
                    BiaoGe[FB]["boss" .. numb]["zhuangbei" .. i] = link .. "x" .. count
                    if BiaoGe.options["autolootNotice"] == 1 then
                        BG.FrameLootMsg:AddMessage(icon .. "|cff00BFFF" ..
                            format(L["已自动记入表格：%s%s%s x%d => %s< %s >%s"], RR, (AddTexture(Texture) .. link),
                                levelText, count, "|cff" .. BG.Boss[FB]["boss" .. numb]["color"],
                                BG.Boss[FB]["boss" .. numb]["name2"], RR) .. icon)
                    end
                end
                AddLootLog(FB, numb, i, lootplayer, count)
                return
            elseif zb and not zbNext then
                if Hope then
                    BG.FrameLootMsg:AddMessage(format("|cffDC143C" .. L["自动关注心愿装备失败：%s%s"],
                        RR, ((AddTexture(Texture) .. link))))
                end
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
                            saveZaXiangNum, itemID, FB, Texture, level, Hope, count, typeID, lootplayer) .. "|h[" .. L["点击记入杂项"] .. "]|h|r"
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
        for b = 1, Maxb[FB] do
            for i = 1, BG.GetMaxi(FB, b) do
                local zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                local duizhangzb = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]
                if zb then
                    if GetItemID(link) == GetItemID(zb:GetText()) then
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
                                format(L["已自动记入表格：%s%s%s x%d => %s< %s >%s"], RR, (AddTexture(Texture) .. link),
                                    levelText, count, "|cff" .. BG.Boss[FB]["boss" .. b]["color"],
                                    BG.Boss[FB]["boss" .. b]["name2"], RR) .. icon)
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

    -- 拾取事件监听
    -- local testItemID = 59521
    local testItemID = 67429
    GetItemInfo(testItemID)
    local function LootItem(self, event, msg, ...)
        local FB = BG.FB2
        if BiaoGe.options["autoLoot"] ~= 1 then -- 有没勾选自动记录功能
            return
        end

        if BG.DeBug then
            FB = BG.FB1
        else
            if not FB then -- 有没FB
                return
            end
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
        if not lootplayer then lootplayer = BG.GN() end
        if not count then count = 1 end

        local name, _, quality, level, _, _, _, stackCount, _, Texture, _, typeID, subclassID, bindType = GetItemInfo(link)
        local itemID = GetItemInfoInstant(link)
        if bindType == 4 then return end          -- 属于任务物品的不记录

        for _, id in ipairs(BG.Loot.blacklist) do -- 过滤黑名单物品
            if itemID == id then
                return
            end
        end

        if BG.DeBug then
            -- link = GetItemInfo(testItemID) and select(2, GetItemInfo(testItemID))
            stackCount = 1
            count = 1
            -- numb = 1
        end

        local Iswhitelist
        if not BG.DeBug then
            for _, id in ipairs(BG.Loot.whitelist) do -- 过滤白名单物品
                if itemID == id then
                    Iswhitelist = true
                    break
                end
            end
            if BG.IsVanilla then
                if typeID == 9 and quality >= 3 then -- 60服蓝色图纸
                    Iswhitelist = true
                end
            end
            if not Iswhitelist then
                if quality < BG.lootQuality[FB] then
                    return
                end

                if not BG.IsVanilla then
                    if typeID == 9 or typeID == 10 or typeID == 3 then -- 过滤图纸、牌子、宝石
                        return
                    end
                    if FB == "ICC" then
                        for i = 2, 5 do
                            if BG.Loot.ICC.Faction["1156:" .. i] then
                                for _, _itemId in ipairs(BG.Loot.ICC.Faction["1156:" .. i]) do -- 过滤ICC声望戒指
                                    if itemID == _itemId then
                                        return
                                    end
                                end
                            end
                        end
                    end
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
        local Hope
        for n = 1, HopeMaxn[FB] do
            for b = 1, HopeMaxb[FB] do
                for i = 1, HopeMaxi do
                    local bt = BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                    if bt then
                        if GetItemID(link) == GetItemID(bt:GetText()) then
                            BG.FrameLootMsg:AddMessage(BG.STC_g1(format(L["你的心愿达成啦！！！>>>>> %s(%s) <<<<<"], (AddTexture(Texture) .. link), level)))
                            bt.looted:Show()
                            Hope = true
                            BG.PlaySound("hope")
                            break
                        end
                    end
                end
                if Hope then break end
            end
            if Hope then break end
        end
        -- 可堆叠物品记录到杂项
        if stackCount ~= 1 then
            AddLootItem_stackCount(FB, nil, link, Texture, level, Hope, count, typeID, lootplayer)
            return
        end
        -- 特殊物品总是记录到杂项
        for _, _itemID in ipairs(BG.Loot.zaXiangItems) do
            if _itemID == itemID then
                local numb = Maxb[FB] - 1
                AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer, nil)
                return
            end
        end
        -- 经典旧世的图纸、牌子、宝石记录到杂项
        if BG.IsVanilla then
            if typeID == 9 or typeID == 10 or typeID == 3 then
                local numb = Maxb[FB] - 1
                AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer, nil, typeID == 9)
                return
            end
        else
            -- TOC的图纸记到杂项
            if typeID == 9 then
                local numb = Maxb[FB] - 1
                AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer, nil, typeID == 9)
                return
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
                        AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer)
                        return
                    end
                end
            end
            for b = 3, 4 do
                for i, _itemID in ipairs(BG.Loot.TOC[hard]["boss" .. b]) do
                    if itemID == _itemID then
                        local numb = b
                        AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer)
                        return
                    end
                end
            end
        end
        -- ICC小怪掉落
        if FB == "ICC" then
            for key, value in pairs(BG.Loot.ICC.H25.boss14) do
                if itemID == value then
                    local numb = Maxb[FB] - 1
                    AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer)
                    return
                end
            end
        end
        -- plus神庙老3
        if FB == "Temple" then
            for _, _itemID in pairs(BG.Loot.Temple.N.boss3) do
                if itemID == _itemID then
                    local numb = 3
                    AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer)
                    return
                end
            end
        end
        -- 正常拾取
        if not numb then
            numb = Maxb[FB] - 1 -- 第一个boss前的小怪设为杂项
        end
        AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer)
    end
    ns.LootItem = LootItem

    BG.RegisterEvent("CHAT_MSG_LOOT", LootItem)
end)


----------一键分配装备给自己----------
BG.Init2(function()
    if BG.IsRetail then return end

    local blackList = {
        52019,
    }

    local cpPlayer, cpItemID, GetInfo

    local function IsTrueLoot(quality, bindType, itemStackCount, typeID, itemLink)
        local itemID = GetItemID(itemLink)
        if itemID then
            if itemID == cpItemID then
                return
            end
            for i, _itemID in ipairs(blackList) do
                if itemID == _itemID then
                    return
                end
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
    local bt = BG.CreateButton(parent)
    do
        bt:SetPoint("BOTTOM", parent, "TOP", 0, 0)
        bt:SetText(L["一键分配"])
        bt:SetSize(bt:GetFontString():GetWidth() + 10, 25)
        bt:Hide()
        BG.autoLootButton = bt
        bt:SetScript("OnEnter", OnEnter)
        bt:SetScript("OnLeave", function(self)
            self.isOnter = false
            GameTooltip:Hide()
        end)
        bt:SetScript("OnClick", function(self)
            BG.PlaySound(1)
            self:GiveLoot()
        end)

        bt.SPbutton = CreateFrame("Button", nil, bt)
        bt.SPbutton:SetSize(1, 20)
        bt.SPbutton:SetPoint("BOTTOM", bt, "TOP", 0, 0)
        bt.SPbutton:SetNormalFontObject(BG.FontGreen15)
        bt.SPbutton:SetDisabledFontObject(BG.FontDis15)
        bt.SPbutton:SetHighlightFontObject(BG.FontWhite15)
        bt.SPbutton.title = L["|cffff8000橙片：|r"]
        bt.SPbutton:RegisterForClicks("AnyUp")
        bt.SPbutton.owner = bt
        BG.SetTextHighlightTexture(bt.SPbutton)
        bt.SPbutton:SetScript("OnClick", function(self, button)
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
        bt.SPbutton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["橙片"], 1, 1, 1, true)
            GameTooltip:AddLine(AddTexture("LEFT") .. L["选择指定人员"], 1, 0.82, 0, true)
            GameTooltip:AddLine(AddTexture("RIGHT") .. L["清除指定人员"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end)
        bt.SPbutton:SetScript("OnLeave", GameTooltip_Hide)
    end

    function bt:GiveLoot()
        if not IsMasterLooter() then return end
        for li = 1, GetNumLootItems() do
            for ci = 1, GetNumGroupMembers() do
                if LootSlotHasItem(li) and GetMasterLootCandidate(li, ci) == BG.GN() then
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
                    local lootCount = 0
                    for li = 1, GetNumLootItems() do
                        if LootSlotHasItem(li) then
                            local itemLink = GetLootSlotLink(li)
                            if itemLink then
                                local itemID = GetItemID(itemLink)
                                if itemID == cpItemID then
                                    lootCount = lootCount + 1
                                end
                            end
                        end
                    end
                    local info = GetInfo()
                    if lootCount + count > info.maxCount then
                        BG.SendSystemMessage(format(L["|cffff0000%s的橙片可能已达上限，不能分配给它！|r"], SetClassCFF(cpPlayer)))
                        return
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

    function bt.SPbutton:ShowRaidMember()
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
                    text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                    text:SetPoint("BOTTOM", f, "TOP", 0, 2)
                    text:SetText(1)
                    text:SetTextColor(.5, .5, .5)
                elseif i == 21 then
                    f:SetPoint("TOPLEFT", mainFrame.buttons[5], "BOTTOMLEFT", 0, -30)

                    local text = f:CreateFontString()
                    text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                    text:SetPoint("BOTTOM", f, "TOP", 0, 2)
                    text:SetText((i - 1) / 5 + 1)
                    text:SetTextColor(.5, .5, .5)
                elseif (i - 1) % 5 == 0 then
                    f:SetPoint("TOPLEFT", mainFrame.buttons[i - 5], "TOPRIGHT", 5, 0)

                    local text = f:CreateFontString()
                    text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
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
                text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                text:SetPoint("TOPLEFT", 2, -1)
                text:SetWidth(f:GetWidth() - 5)
                text:SetJustifyH("LEFT")
                text:SetWordWrap(false)
                f.nameText = text

                local text = f:CreateFontString()
                text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
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

    local testItem

    function GetInfo()
        if BG.DeBug then
            BG.autoLoot.info.ICC.itemID = testItem
            return BG.autoLoot.info.ICC
        end
        local info = BG.FB2 and BG.autoLoot.info[BG.FB2]
        if info then
            if info.diff and not tContains(info.diff, GetRaidDifficultyID()) then
                return
            end
            return info
        end
    end

    function bt.SPbutton:Update()
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

    do
        local function OnShow()
            bt.isOnter = false
            if BiaoGe.options["allLootToMe"] == 1 and IsMasterLooter() then
                bt:Show()
                bt.SPbutton:Update()
                if BiaoGe.options["autoAllLootToMe"] == 1 and not IsModifierKeyDown() then
                    BG.After(0.1, function()
                        bt:GiveLoot()
                    end)
                end
            else
                bt:Hide()
            end
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
            if bt.isOnter and bt:IsEnabled() then
                OnEnter(bt)
            end
        end)
    end

    -- 橙片
    BG.autoLoot = {}
    if BG.IsVanilla_60 then
        BG.autoLoot.info = {
            NAXX = { itemID = 22726, quest = 9250, maxCount = 40 },
        }
    else
        BG.autoLoot.info = {
            ICC = { itemID = 50274, quest = 24548, maxCount = 50, diff = { 4, 6, 176, 194 } },
        }
    end
    BG.RegisterEvent("ENCOUNTER_END", function(self, event, bossID, _, _, _, success)
        if success == 1 then
            local info = GetInfo()
            if info and IsInRaid(1) then
                local count = GetItemCount(info.itemID, true)
                if info.quest and BG.questsCompleted[info.quest] then
                    count = "finish"
                end
                local msg = format("AutoLoot,%s,%s", info.itemID, count)
                C_ChatInfo.SendAddonMessage("BiaoGe", msg, "RAID")
            end
        end
    end)

    BG.RegisterEvent("CHAT_MSG_LOOT", function(self, event, msg)
        local info = GetInfo()
        if info and IsInRaid(1) then
            local itemID = tonumber(msg:match("item:(%d+)"))
            if itemID == info.itemID then
                local count = GetItemCount(info.itemID, true)
                local msg = format("AutoLoot,%s,%s", info.itemID, count)
                C_ChatInfo.SendAddonMessage("BiaoGe", msg, "RAID")
            end
        end
    end)

    BG.RegisterEvent("CHAT_MSG_ADDON", function(self, event, prefix, msg, distType, sender)
        if not (prefix == "BiaoGe" and distType == "RAID") then return end
        local arg1, itemID, count = strsplit(",", msg)
        sender = BG.GSN(sender)
        if arg1 == "AutoLoot" then
            itemID = tonumber(itemID)
            if tonumber(count) then
                count = tonumber(count)
            end
            BG.autoLoot[sender] = BG.autoLoot[sender] or {}
            BG.autoLoot[sender][itemID] = count
            if sender == bt.cpPlayer then
                bt.SPbutton:Update()
            end
        end
    end)

    -- DEBUG
    -- testItem = 2169
    -- BG.DeBug = true
    -- local msg = format("AutoLoot,%s,%s", testItem, 5)
    -- C_ChatInfo.SendAddonMessage("BiaoGe", msg, "RAID")
    -- function BG.A()
    --     pt(cpPlayer, cpItemID)
    -- end
end)

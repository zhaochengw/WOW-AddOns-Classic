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
            -- pt(_saveZaXiangNum, itemID, FB, Texture, level, Hope, count, typeID, lootplayer)
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
    local remindUpdateFrame = CreateFrame("Frame")
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
                            if BiaoGe.options.autoLoot == 1 and BiaoGe.options.autolootRemind == 1 and BG.ImML() and GetLootMethod() == "master" then
                                remindUpdateFrame.elapsed = 0
                                remindUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
                                    self.elapsed = self.elapsed + elapsed
                                    if self.elapsed >= 30 then
                                        if BG.ImML() then
                                            BG.FrameLootMsg:AddMessage(BG.STC_r1(L["提醒：你可能还没拾取刚击杀BOSS的掉落哦！"]))
                                            PlaySoundFile("Interface\\AddOns\\BiaoGe\\Media\\sound\\other\\remind.mp3", "Master")
                                        end
                                        self:SetScript("OnUpdate", nil)
                                    end
                                end)
                            end
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
            local zbNext = BG.Frame[FB]["boss" .. numb]["zhuangbei" ..  (i + addI)]
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
                    PlaySoundFile(BG["sound_biaogefull" .. BiaoGe.options.Sound], "Master")
                end
                return
            end
        end
    end
    local function AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer, notlater,fromLast)
        local itemID = GetItemInfoInstant(link)
        BG.Tooltip_SetItemByID(itemID)
        if notlater then
            _AddLootItem(itemID, FB, numb, link, Texture, level, Hope, count, typeID, lootplayer,fromLast)
        else
            BG.After(0.1, function()
                _AddLootItem(itemID, FB, numb, link, Texture, level, Hope, count, typeID, lootplayer,fromLast)
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
                        for _, _itemId in ipairs(BG.Loot.ICC.Faction["1156"]) do -- 过滤ICC声望戒指
                            if itemID == _itemId then
                                return
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
                            PlaySoundFile(BG["sound_hope" .. BiaoGe.options.Sound], "Master")
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
                AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer,nil)
                return
            end
        end
        -- 经典旧世的图纸、牌子、宝石记录到杂项
        if BG.IsVanilla then
            if typeID == 9 or typeID == 10 or typeID == 3 then
                local numb = Maxb[FB] - 1
                AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer,nil, typeID == 9)
                return
            end
        else
            -- TOC的图纸记到杂项
            if typeID == 9 then
                local numb = Maxb[FB] - 1
                AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, lootplayer,nil,typeID == 9)
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

    local f = CreateFrame("Frame")
    f:RegisterEvent("CHAT_MSG_LOOT")
    f:SetScript("OnEvent", LootItem)
end)

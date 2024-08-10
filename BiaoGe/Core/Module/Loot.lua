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

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName ~= AddonName then return end
    -- 拾取事件通报到屏幕中上
    local name = "lootTime"
    BG.options[name .. "reset"] = 8
    local f = CreateFrame("ScrollingMessageFrame", "BG.FrameLootMsg", UIParent, "BackdropTemplate")
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
                GameTooltip:SetItemByID(itemID)
                GameTooltip:Show()
            end
        end
    end)
    BG.FrameLootMsg:SetScript("OnHyperlinkLeave", function(self, link, text, button)
        GameTooltip:Hide()
    end)
    BG.FrameLootMsg:SetScript("OnHyperlinkClick", function(self, link, text, button)
        local arg1, arg2, arg3 = strsplit(":", link)
        if arg2 == "BiaoGeGuoQi" and arg3 == L["详细"] then
            BG.MainFrame:Show()
            BG.itemGuoQiFrame:Show()
            BG.ClickTabButton(BG.tabButtons, BG.FBMainFrameTabNum)
        elseif arg2 == "BiaoGeGuoQi" and arg3 == L["设置为1小时内不再提醒"] then
            BiaoGe.lastGuoQiTime = time() + 3300
            BG.FrameLootMsg:AddMessage(BG.STC_b1(L["已设置为1小时内不再提醒。"]))
        else
            local name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
            if link then
                if button == "RightButton" then
                    BG.CancelGuanZhu(link)
                end
                if IsShiftKeyDown() then
                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                    ChatEdit_InsertLink(text)
                elseif IsAltKeyDown() then
                    if BG.IsML then -- 开始拍卖
                        BG.StartAuction(link)
                    else            -- 关注装备
                        BG.AddGuanZhu(link)
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
    f:SetScript("OnEvent", function(self, even, arg1, arg2)
        if even == "TRADE_ACCEPT_UPDATE" then -- 屏蔽交易添加
            if arg1 == 1 or arg2 == 1 then
                trade = true
            else
                trade = nil
            end
        elseif even == "TRADE_CLOSED" then
            trade = nil
        elseif even == "MERCHANT_UPDATE" then -- 屏蔽购买物品
            buy = true
            C_Timer.After(0.5, function()
                buy = nil
            end)
        elseif even == "QUEST_TURNED_IN" or even == "QUEST_FINISHED" then -- 屏蔽任务物品
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

    local function PrintLootBoss(FB, even, numb, text)
        if BiaoGe.options["autoLoot"] ~= 1 then return end
        SendSystemMessage(BG.BG .. text .. "，" .. L["当前装备自动记录位置："] ..
            "|cff" .. BG.Boss[FB]["boss" .. numb].color .. BG.Boss[FB]["boss" .. numb].name2 .. RR)
    end

    -- 获取BOSS战ID
    local f = CreateFrame("Frame")
    f:RegisterEvent("ENCOUNTER_START")
    f:RegisterEvent("ENCOUNTER_END")
    f:SetScript("OnEvent", function(self, even, bossID, _, _, _, success)
        local FB = BG.FB2
        if not FB then return end
        if even == "ENCOUNTER_START" then
            start = true
            for _numb, _bossID in ipairs(BG.Loot.encounterID[FB]) do
                if bossID and (bossID == _bossID) then
                    numb = _numb
                    lasttime = GetTime()
                    -- local text = BG.STC_g1(L["BOSS战开始"])
                    -- PrintLootBoss(FB, even, numb, text)
                    break
                end
            end
        elseif even == "ENCOUNTER_END" and success == 1 then
            for _numb, _bossID in ipairs(BG.Loot.encounterID[FB]) do
                if bossID and (bossID == _bossID) then
                    numb = _numb
                    lasttime = GetTime()
                    start = nil
                    -- local text = BG.STC_g1(L["BOSS击杀成功"])
                    -- PrintLootBoss(FB, even, numb, text)
                    BiaoGe[FB].raidRoster = { time = time(), realm = GetRealmName(), roster = {} }
                    for i, v in ipairs(BG.raidRosterInfo) do
                        tinsert(BiaoGe[FB].raidRoster.roster, v.name)
                    end
                    break
                end
            end
        elseif even == "ENCOUNTER_END" and success ~= 1 then -- 团灭
            numb = Maxb[FB] - 1
            start = nil
            -- local text = BG.STC_r1(L["BOSS击杀失败"])
            -- PrintLootBoss(FB, even, numb, text)
        end
    end)
    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_REGEN_DISABLED") -- 进入战斗
    f:SetScript("OnEvent", function(self, even, ID)
        local FB = BG.FB2
        if not FB then return end
        if start then return end
        _time = GetTime()
        if numb ~= Maxb[FB] - 1 then
            if _time - lasttime >= 30 then -- 击杀BOSS 30秒后进入下一次战斗，就变回杂项
                numb = Maxb[FB] - 1
                -- local text = BG.STC_r1(L["非BOSS战"])
                -- PrintLootBoss(FB, even, numb, text)
            end
        end
    end)

    -- 记录物品进表格
    local biaogefull
    local function _AddLootItem(itemID, FB, numb, link, Texture, level, Hope, count, typeID, lateTime)
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

        for i = 1, Maxi[FB] do
            local zb = BG.Frame[FB]["boss" .. numb]["zhuangbei" .. i]
            local zb1 = BG.Frame[FB]["boss" .. numb]["zhuangbei" .. (i + 1)]
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
                    BG.FrameLootMsg:AddMessage(icon .. "|cff00BFFF" ..
                        format(L["已自动记入表格：%s%s%s => %s< %s >%s"], RR, (AddTexture(Texture) .. link),
                            levelText, "|cff" .. BG.Boss[FB]["boss" .. numb]["color"],
                            BG.Boss[FB]["boss" .. numb]["name2"], RR) .. icon)
                else
                    zb:SetText(link .. "x" .. count)
                    duizhangzb:SetText(link .. "x" .. count)
                    BiaoGe[FB]["boss" .. numb]["zhuangbei" .. i] = link .. "x" .. count
                    BG.FrameLootMsg:AddMessage(icon .. "|cff00BFFF" ..
                        format(L["已自动记入表格：%s%s%s x%d => %s< %s >%s"], RR, (AddTexture(Texture) .. link),
                            levelText, count, "|cff" .. BG.Boss[FB]["boss" .. numb]["color"],
                            BG.Boss[FB]["boss" .. numb]["name2"], RR) .. icon)
                end
                return
            elseif zb and not zb1 then
                if Hope then
                    BG.FrameLootMsg:AddMessage(format("|cffDC143C" .. L["自动关注心愿装备失败：%s%s"],
                        RR, ((AddTexture(Texture) .. link))))
                end
                BG.FrameLootMsg:AddMessage(icon .. format(
                    "|cffDC143C" .. L["自动记录失败：%s%s%s。因为%s< %s >%s的格子满了。。"], RR,
                    (AddTexture(Texture) .. link), levelText, "|cff" .. BG.Boss[FB]["boss" .. numb]["color"],
                    BG.Boss[FB]["boss" .. numb]["name2"], RR) .. icon)
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
    local function AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, notlater)
        local itemID = GetItemInfoInstant(link)
        BG.Tooltip_SetItemByID(itemID)
        if notlater then
            _AddLootItem(itemID, FB, numb, link, Texture, level, Hope, count, typeID)
        else
            BG.After(0.1, function()
                _AddLootItem(itemID, FB, numb, link, Texture, level, Hope, count, typeID)
            end)
        end
    end
    local function AddLootItem_stackCount(FB, numb, link, Texture, level, Hope, count, typeID)
        local yes
        local levelText = ""
        if typeID == 2 or typeID == 4 then
            levelText = "(" .. level .. ")"
        end
        for b = 1, Maxb[FB] do
            for i = 1, Maxi[FB] do
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
                        BG.FrameLootMsg:AddMessage(icon .. "|cff00BFFF" ..
                            format(L["已自动记入表格：%s%s%s x%d => %s< %s >%s"], RR, (AddTexture(Texture) .. link),
                                levelText, count, "|cff" .. BG.Boss[FB]["boss" .. b]["color"],
                                BG.Boss[FB]["boss" .. b]["name2"], RR) .. icon)
                        return
                    end
                end
            end
        end
        -- 如果表格里没这个物品，则记录到杂项里
        if not yes then
            local numb = Maxb[FB] - 1
            AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID, "notlater")
            return
        end
    end

    -- 拾取事件监听
    -- local testItemID = 59521
    local testItemID = 67429
    GetItemInfo(testItemID)
    local function LootItem(self, even, msg, ...)
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

        if BG.DeBug then
            link = GetItemInfo(testItemID) and select(2, GetItemInfo(testItemID))
            count = 1
            -- numb = 1
        end

        if buy and not lootplayer then return end   -- 你是否刚购买了物品
        if quest and not lootplayer then return end -- 是否获得了任务物品
        if not link then return end
        if not count then count = 1 end

        local name, _, quality, level, _, _, _, stackCount, _, Texture, _, typeID, subclassID, bindType = GetItemInfo(link)
        local itemID = GetItemInfoInstant(link)
        if bindType == 4 then return end          -- 属于任务物品的不记录

        for i, id in ipairs(BG.Loot.blacklist) do -- 过滤黑名单物品
            if itemID == id then
                return
            end
        end

        local Iswhitelist
        if not BG.DeBug then
            for i, id in ipairs(BG.Loot.whitelist) do -- 过滤白名单物品
                if itemID == id then
                    Iswhitelist = true
                    break
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
                        for i, _itemId in ipairs(BG.Loot.ICC.Faction["1156"]) do -- 过滤ICC声望戒指
                            if itemID == _itemId then
                                return
                            end
                        end
                    end
                end
                -- 过滤附魔分解的物品（例如：深渊水晶），subclassID==0是60年代的附魔材料子分类
                if typeID == 7 and (subclassID == 12 or subclassID == 0) then
                    return
                end
            end
        end

        -- 更新装备库已掉落显示
        if BG.ItemLibMainFrame:IsVisible() then
            -- 装备库
            local num = 1
            local count = BG.ItemLibMainFrame[num].buttoncount
            if count then
                for i = 1, count do
                    local get = BG.ItemLibMainFrame[num]["button" .. i].get
                    local _itemID = BG.ItemLibMainFrame[num]["button" .. i].itemID
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
            AddLootItem_stackCount(FB, nil, link, Texture, level, Hope, count)
            return
        end

        -- Plus黑上部分boss需要根据物品id直接记录
        if FB == "UBRS" then
            for numb, v in pairs(BG.SpecialLoot[FB]) do
                for _, _itemID in pairs(BG.SpecialLoot[FB][numb]) do
                    if _itemID == itemID then
                        AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID)
                        return
                    end
                end
            end
        end

        -- 特殊物品总是记录到杂项
        for _, _itemID in ipairs(BG.Loot.zaXiangItems) do
            if _itemID == itemID then
                local numb = Maxb[FB] - 1
                -- local numb = Maxb[FB] -- test
                AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID)
                return
            end
        end

        -- 经典旧世的图纸、牌子、宝石记录到杂项
        if BG.IsVanilla then
            if typeID == 9 or typeID == 10 or typeID == 3 then
                local numb = Maxb[FB] - 1
                AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID)
                return
            end
        end

        -- TOC嘉奖宝箱通过读取掉落列表来记录装备
        if FB == "TOC" and itemID ~= 47242 then
            local nanduID = GetRaidDifficultyID()
            local H
            if nanduID == 6 or nanduID == 194 then     -- 25H
                H = "H25"
            elseif nanduID == 5 or nanduID == 193 then -- 10H
                H = "H10"
            end
            if H then
                for index, value in ipairs(BG.Loot.TOC[H].boss6) do
                    if itemID == value then
                        local numb = 6
                        AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID)
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
                    AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID)
                    return
                end
            end
        end

        -- plus神庙老3
        if FB == "Temple" then
            for _, _itemID in pairs(BG.Loot.Temple.N.boss3) do
                if itemID == _itemID then
                    local numb = 3
                    AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID)
                    return
                end
            end
        end

        -- 正常拾取
        if not numb then
            numb = Maxb[FB] - 1 -- 第一个boss前的小怪设为杂项
        end

        AddLootItem(FB, numb, link, Texture, level, Hope, count, typeID)
    end
    ns.LootItem = LootItem

    local f = CreateFrame("Frame")
    f:RegisterEvent("CHAT_MSG_LOOT")
    f:SetScript("OnEvent", LootItem)
end)

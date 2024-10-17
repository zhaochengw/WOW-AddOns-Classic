local _, ns = ...

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
local FrameHide = ns.FrameHide
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID
local BossNum = ns.BossNum

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

------------------过滤装备------------------
do
    local alpha1 = 0.4
    local alpha2 = 1

    function BG.Tooltip_SetItemByID(itemID)
        BiaoGeTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        BiaoGeTooltip:ClearLines()
        BiaoGeTooltip:SetItemByID(itemID)
    end

    local function GetTooltipTextLeftAll(itemID)
        BG.Tooltip_SetItemByID(itemID)
        local tab = {}
        local ii = 1
        while _G["BiaoGeTooltipTextLeft" .. ii] do
            local text = _G["BiaoGeTooltipTextLeft" .. ii]:GetText()
            if text and text ~= "" then
                text = text:gsub("每5秒恢复%d+点法力值", "每5秒回复%d+点法力值")
                if (not text:find(WARDROBE_SETS)) and
                    (not text:find(ITEM_MOD_FERAL_ATTACK_POWER:gsub("%%s", "(.+)"))) -- 小德的武器词缀：在猎豹、熊等等攻击强度提高%s点
                then
                    table.insert(tab, text)
                end
            end
            ii = ii + 1
        end
        local TooltipText = table.concat(tab)
        return TooltipText
    end
    local function FilterArmor(typeID, EquipLoc, subclassID)
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
        if not num then return end
        if typeID == 4 and EquipLoc ~= "INVTYPE_CLOAK" then
            for id, v in pairs(BiaoGe.FilterClassItemDB[RealmId][player][num].Armor) do
                if subclassID == tonumber(id) then
                    if subclassID == 0 then
                        if EquipLoc == "INVTYPE_HOLDABLE" then
                            return true
                        end
                    else
                        return true
                    end
                end
            end
        end
    end
    local function FilterWeapon(typeID, EquipLoc, subclassID)
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
        if not num then return end
        if typeID == 2 then
            for id, v in pairs(BiaoGe.FilterClassItemDB[RealmId][player][num].Weapon) do
                if subclassID == tonumber(id) then
                    return true
                end
            end
        end
    end
    local function GetDBShuXingInfo(text)
        for k, v in pairs(BG.FilterClassItemDB.ShuXing) do
            if text == v.name then
                return v.value:gsub("%%s", "(.+)"), v.nothave
            end
        end
    end
    local function FilterShuXing(TooltipText)
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
        if not num then return end
        for name, _ in pairs(BiaoGe.FilterClassItemDB[RealmId][player][num].ShuXing) do
            local localText, nothave = GetDBShuXingInfo(name)
            if localText then
                if strfind(TooltipText, localText) then
                    if nothave then
                        for _, nothaveLocalText in pairs(nothave) do
                            if strfind(TooltipText, nothaveLocalText) then
                                return false
                            end
                        end
                        return true
                    else
                        return true
                    end
                end
            end
        end
    end
    local function FilterCLASS(TooltipText)
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
        if not num then return end
        if strfind(TooltipText, CLASS) then
            for id, v in pairs(BiaoGe.FilterClassItemDB[RealmId][player][num].Class) do
                if id == "过滤职业限定" then
                    local c = UnitClass("player")
                    if not strfind(TooltipText, c) then
                        return true
                    end
                end
            end
        end
    end
    local function FilterTANK(TooltipText, typeID, EquipLoc)
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
        if not num then return end
        if typeID == 4 and EquipLoc ~= "INVTYPE_TRINKET" and EquipLoc ~= "INVTYPE_RELIC" then
            for id, v in pairs(BiaoGe.FilterClassItemDB[RealmId][player][num].Tank) do
                if id == "过滤坦克" then
                    local tank
                    for key, value in pairs(BG.FilterClassItem_Default.TankKey) do
                        tank = strfind(TooltipText, value)
                        if tank then
                            break
                        end
                    end
                    if not tank then
                        return true
                    end
                end
            end
        end
    end
    function BG.FilterAll(itemID, typeID, EquipLoc, subclassID)
        local TooltipText = GetTooltipTextLeftAll(itemID)
        if FilterArmor(typeID, EquipLoc, subclassID) then
            return true
        end
        if FilterWeapon(typeID, EquipLoc, subclassID) then
            return true
        end
        if FilterShuXing(TooltipText) then
            return true
        end
        if FilterCLASS(TooltipText) then
            return true
        end
        if not BG.IsVanilla then
            if FilterTANK(TooltipText, typeID, EquipLoc) then
                return true
            end
        end
    end

    function BG.FilterItem(bt, link)
        local text = link or bt:GetText()
        local itemID, _, _, EquipLoc, _, typeID, subclassID = GetItemInfoInstant(text)
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID

        if itemID and num then
            if BG.FilterAll(itemID, typeID, EquipLoc, subclassID) then
                bt:SetAlpha(alpha1)
                return
            end
        end
        bt:SetAlpha(alpha2)
    end

    function BG.UpdateFilter(bt, link)
        local text = link or bt:GetText()
        local itemID = GetItemID(text)
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
        if not (text:find("item:") and itemID and num) then
            bt:SetAlpha(alpha2)
            return
        end

        local item = Item:CreateFromItemID(itemID)
        item:ContinueOnItemLoad(function()
            if not BG.itemCaches[itemID] then
                BG.Tooltip_SetItemByID(itemID)
                BG.After(0.01, function()
                    BG.FilterItem(bt, link)
                    BG.itemCaches[itemID] = true
                end)
            else
                BG.FilterItem(bt, link)
            end
        end)
    end

    function BG.UpdateAllFilter()
        local FB = BG.FB1
        for b = 1, Maxb[FB] do -- 当前表格
            for i = 1, Maxi[FB] do
                local bt = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                if bt then
                    BG.UpdateFilter(bt)
                end
            end
        end
        for b = 1, Maxb[FB] do -- 历史表格
            for i = 1, Maxi[FB] do
                local bt = BG.HistoryFrame[FB]["boss" .. b]["zhuangbei" .. i]
                if bt then
                    BG.UpdateFilter(bt)
                end
            end
        end
        for n = 1, HopeMaxn[FB] do -- 心愿清单
            for b = 1, HopeMaxb[FB] do
                for i = 1, HopeMaxi do
                    local bt = BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                    if bt then
                        BG.UpdateFilter(bt)
                    end
                end
            end
        end
        if BG.ZhuangbeiList then
            local i = 1
            while BG.ZhuangbeiList["button" .. i] do
                local bt = BG.ZhuangbeiList["button" .. i]
                BG.UpdateFilter(bt)
                i = i + 1
            end
        end
        -- 装备过期列表
        if BG.itemGuoQiFrame:IsVisible() then
            for i, bt in ipairs(BG.itemGuoQiFrame.buttons) do
                BG.UpdateFilter(bt, bt.link)
            end
        end
        -- 自动拍卖记录
        if BG.auctionLogFrame:IsVisible() then
            for i, bt in ipairs(BG.auctionLogFrame.buttons) do
                BG.UpdateFilter(bt.frame, bt.link)
            end
        end

        for k, bt in pairs(BG.ItemLibMainFrame.Hope) do
            if type(bt) == "table" and bt.EquipLoc then
                BG.UpdateFilter(bt)
            end
        end

        BG.FilterClassItemMainFrame.AddFrame:Hide()
        if not BG.ItemLibMainFrame:IsVisible() then
            BG.itemLibNeedUpdate = true
        end

        if BGA.Frames then
            for _, f in ipairs(BGA.Frames) do
                f.filter = nil
                if f.player and f.player == UnitName("player") then
                    f:SetBackdropColor(unpack(BGA.aura_env.backdropColor_IsMe))
                    f:SetBackdropBorderColor(unpack(BGA.aura_env.backdropBorderColor_IsMe))
                    f.autoFrame:SetBackdropColor(unpack(BGA.aura_env.backdropColor_IsMe))
                    f.autoFrame:SetBackdropBorderColor(unpack(BGA.aura_env.backdropBorderColor_IsMe))
                else
                    f:SetBackdropColor(unpack(BGA.aura_env.backdropColor))
                    f:SetBackdropBorderColor(unpack(BGA.aura_env.backdropBorderColor))
                    f.autoFrame:SetBackdropColor(unpack(BGA.aura_env.backdropColor))
                    f.autoFrame:SetBackdropBorderColor(unpack(BGA.aura_env.backdropBorderColor))
                end
                f.hide:SetNormalFontObject(_G.BGA.FontGreen15)
                f.cancel:SetNormalFontObject(_G.BGA.FontGreen15)
                f.autoTextButton:SetNormalFontObject(_G.BGA.FontGreen15)
                f.logTextButton:SetNormalFontObject(_G.BGA.FontGreen15)

                local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
                if num then
                    local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID, bindType = GetItemInfo(f.itemID)
                    if BG.FilterAll(f.itemID, typeID, EquipLoc, subclassID) then
                        f.filter = true
                        if not (f.player and f.player == UnitName("player")) then
                            f:SetBackdropColor(unpack(BGA.aura_env.backdropColor_filter))
                            f:SetBackdropBorderColor(unpack(BGA.aura_env.backdropBorderColor_filter))
                            f.autoFrame:SetBackdropColor(unpack(BGA.aura_env.backdropColor_filter))
                            f.autoFrame:SetBackdropBorderColor(unpack(BGA.aura_env.backdropBorderColor_filter))
                            f.hide:SetNormalFontObject(_G.BGA.FontDis15)
                            f.cancel:SetNormalFontObject(_G.BGA.FontDis15)
                            f.autoTextButton:SetNormalFontObject(_G.BGA.FontDis15)
                            f.logTextButton:SetNormalFontObject(_G.BGA.FontDis15)
                        end
                    end
                end
            end
        end
    end

    -- 拾取通知
    function BG.LootFilterClassItem(link)
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
        if not num then return "" end

        local icon = AddTexture(BiaoGe.FilterClassItemDB[RealmId][player][num].Icon)
        local itemID, _, _, EquipLoc, _, typeID, subclassID = GetItemInfoInstant(link)

        if itemID then
            if BG.FilterAll(itemID, typeID, EquipLoc, subclassID) then
                return ""
            end
        end
        return icon
    end
end

------------------函数：按职业排序------------------
function BG.PaiXuRaidRosterInfo(filter)
    local tbl =filter or {
        "DEATHKNIGHT", --     "死亡骑士",
        "PALADIN",     --     "圣骑士",
        "WARRIOR",     --     "战士",
        "SHAMAN",      --     "萨满祭司",
        "HUNTER",      --     "猎人",
        "DRUID",       --     "德鲁伊",
        "ROGUE",       --     "潜行者",
        "MAGE",        --     "法师",
        "WARLOCK",     --     "术士",
        "PRIEST",      --     "牧师",
    }

    local newTbl = {}
    if type(BG.raidRosterInfo) == "table" then
        for _, vv in ipairs(tbl) do
            for _, v in ipairs(BG.raidRosterInfo) do
                if v.class == vv then
                    table.insert(newTbl, v)
                end
            end
        end
    end
    return newTbl
end

------------------函数：装备缓存本地化------------------
function BG.EditItemCache(self, func)
    local _itemID = GetItemID(self:GetText())
    if _itemID and not GetItemInfo(_itemID) then
        self:RegisterEvent("GET_ITEM_INFO_RECEIVED")
        self:SetScript("OnEvent", function(self, even, itemID, success)
            if itemID == _itemID and success then
                func(self)
                self:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
            end
        end)
    end
end

------------------函数：装备下拉列表------------------
do
    local function CreateLootLog(self)
        if self.hopenandu then return end
        local FB = self.FB
        local b = self.bossnum
        local i = self.i
        if not BiaoGe[FB]["boss" .. b]["loot" .. i] then return end
        local f = CreateFrame("Frame", nil, BG.FrameZhuangbeiList, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, .8)
        f:SetPoint("TOPRIGHT", BG.FrameZhuangbeiList, "TOPLEFT", 3, 0)
        f:SetSize(120, BG.FrameZhuangbeiList:GetHeight())
        f:EnableMouse(true)
        BG.FrameLootLog = f

        local text = f:CreateFontString()
        text:SetPoint("TOP", 0, -10)
        text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
        text:SetText(L["拾取记录"])

        local w = f:GetWidth() - 15
        local h = f:GetHeight() - 37
        local frame, child = BG.CreateScrollFrame(f, w, h, nil, true)
        frame:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 1,
        })
        frame:SetBackdropColor(0, 0, 0, 0)
        frame:SetBackdropBorderColor(.5, .5, .5, .5)
        frame:SetPoint("TOPLEFT", f, 8, -30)
        frame.scroll:SetWidth(frame:GetWidth() - 10)
        child:SetWidth(frame:GetWidth() - 10)
        BG.HookScrollBarShowOrHide(frame.scroll, true)

        local texts = {}
        for _, v in ipairs(BiaoGe[FB]["boss" .. b]["loot" .. i]) do
            local t = child:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            if #texts == 0 then
                t:SetPoint("TOPLEFT", 0, 0)
            else
                t:SetPoint("TOPLEFT", texts[#texts], "BOTTOMLEFT", 0, -3)
            end
            t:SetHeight(15)
            t:SetTextColor(1, 0.82, 0)
            t:SetText(date("%m-%d %H:%M", v.time))
            t:SetWidth(child:GetWidth())
            t:SetJustifyH("LEFT")
            t:SetWordWrap(false)
            tinsert(texts, t)

            local t = child:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            t:SetPoint("TOPRIGHT", texts[#texts], "BOTTOMRIGHT", 0, 0)
            t:SetHeight(15)
            t:SetText("x" .. v.count)

            local t = child:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
            t:SetPoint("TOPLEFT", texts[#texts], "BOTTOMLEFT", 0, 0)
            t:SetHeight(15)
            t:SetText("|c" .. select(4, GetClassColor(v.class)) .. v.player .. RR)
            tinsert(texts, t)

            local l = child:CreateLine()
            l:SetColorTexture(RGB("808080", 1))
            l:SetStartPoint("TOPLEFT", 0, -1 - #texts * 15 - (#texts / 2 - 1) * 3)
            l:SetEndPoint("TOPRIGHT", 0, -1 - #texts * 15 - (#texts / 2 - 1) * 3)
            l:SetThickness(1)
        end
    end
    local function GetNanDu(bossnum)
        local FB = BG.FB1
        if BG.IsWLKFB() then
            local nandutable = {
                NAXX = {
                    [3] = "N10",
                    [175] = "N10",
                    [4] = "N25",
                    [176] = "N25",
                    [5] = "N10",
                    [193] = "N10",
                    [6] = "N25",
                    [194] = "N25",
                },
                TOC = {
                    [3] = "N10",
                    [175] = "N10",
                    [4] = "N25",
                    [176] = "N25",
                    [5] = "H10",
                    [193] = "H10",
                    [6] = "H25",
                    [194] = "H25",
                },
            }
            nandutable.ULD = nandutable.NAXX
            nandutable.ICC = nandutable.TOC
            return nandutable[FB][GetRaidDifficultyID()]
        else
            local nandutable = {
                [3] = "N",
                [175] = "N",
                [4] = "N",
                [176] = "N",
                [5] = "H",
                [193] = "H",
                [6] = "H",
                [194] = "H",
            }
            return nandutable[GetRaidDifficultyID()]
        end
    end
    local function GetHopeNanDu(hopenandu)
        if BG.IsWLKFB() then
            local hopenandutable = {
                [1] = "N10",
                [2] = "N25",
                [3] = "H10",
                [4] = "H25",
            }
            return hopenandutable[hopenandu]
        else
            local hopenandutable = {
                [1] = "N",
                [2] = "H",
            }
            return hopenandutable[hopenandu]
        end
    end
    local function SetButtonText(self)
        local name, link, quality, level, _, _, _, _, _, Texture, _, typeID, _, bindType = GetItemInfo(self.itemID)
        self.link = link

        local ICCH = "" -- 277套装徽记的H标记
        if BG.FB1 == "ICC" then
            if self.itemID == 52030 or self.itemID == 52029 or self.itemID == 52028 then
                ICCH = "H"
            end
        end
        if typeID == 2 or typeID == 4 then
            self:SetText(link .. ICCH .. "|cff" .. "808080" .. "(" .. level .. ")")
            -- self:SetText(link .. ICCH .. "|cff" .. "9370DB" .. "(" .. level .. ")")
        else
            self:SetText(link .. ICCH)
        end
        self:SetTextInsets(14, 0, 0, 0)
        -- 装备图标
        self.icon:SetTexture(Texture)
        -- 装绑图标
        BG.BindOnEquip(self, bindType)
        -- 已拥有图标
        BG.IsHave(self, true)

        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID -- 隐藏
        if num ~= 0 then
            local _, class = UnitClass("player")
            BG.UpdateFilter(self)
        end
    end
    function BG.SetListzhuangbei(self)
        local FB = self.FB
        local bossnum = self.bossnum
        local nandu = GetNanDu(bossnum)
        if self.hopenandu then
            nandu = GetHopeNanDu(self.hopenandu)
        end
        if not nandu then nandu = "N" end
        local loots = BG.Loot[FB][nandu] and BG.Loot[FB][nandu]["boss" .. bossnum]

        if bossnum > Maxb[FB] - 1 then return end

        -- 背景框
        local f = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
        f:SetFrameLevel(120)
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.9)
        f:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -9, 2)
        f:EnableMouse(true)
        f:SetClampedToScreen(true)
        BG.FrameZhuangbeiList = f
        if not loots or #loots == 0 then
            f:SetSize(300, 150)
            local text = f:CreateFontString()
            text:SetPoint("TOPLEFT", f, "TOPLEFT", 5, -10)
            text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
            text:SetWidth(f:GetWidth() - 10)
            text:SetJustifyH("LEFT")
            text:SetText(BG.STC_w1(L["|cff00BFFF由于该BOSS未有具体掉落列表，如果你想手动添加装备，可以使用以下方法：|r\n\n第一种：从背包把装备拖进表格\n\n第二种：先点击一个表格格子，然后SHIFT+点击聊天框/背包装备"]))
            return
        end

        local MaxI = 10
        -- 根据掉落总数改变按钮数量
        if #loots > MaxI * 2 then
            local a = format("%d", #loots / 2)
            local b = #loots % 2
            MaxI = a + b
        end
        -- 提示文字
        local text = f:CreateFontString()
        text:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 3, 0)
        text:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
        text:SetJustifyH("LEFT")
        if self.hopenandu then
            text:SetText(BG.STC_w1(L["（SHIFT+点击发送装备，CTRL+点击查看该部位的其他可选装备）"]))
        else
            text:SetText(BG.STC_w1(L["（ALT+点击关注装备，SHIFT+点击发送装备，CTRL+点击查看该部位的其他可选装备）"]))
        end
        -- 下拉列表
        BG.ZhuangbeiList = {}
        local frameright
        local framedown
        local btwidth = 230
        local btheight = 20
        for t = 1, 2 do
            for i = 1, MaxI do
                local n = (t - 1) * MaxI + i

                local bt = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
                bt:SetSize(btwidth, btheight)
                bt:SetFrameLevel(125)
                bt:SetTextInsets(14, 0, 0, 0)
                bt:SetAutoFocus(false)
                bt:Disable()
                bt.owner = self
                bt.itemID = loots[n]
                bt.icon = bt:CreateTexture(nil, 'ARTWORK')
                bt.icon:SetPoint('LEFT', -4, 0)
                bt.icon:SetSize(16, 16)
                if t == 1 and i == 1 then
                    bt:SetPoint("TOPLEFT", f, "TOPLEFT", 10, -5)
                    frameright = bt
                elseif t >= 2 and i == 1 then
                    bt:SetPoint("TOPLEFT", frameright, "TOPRIGHT", 5, 0)
                    frameright = bt
                elseif i > 1 then
                    bt:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -2)
                end
                framedown = bt
                BG.ZhuangbeiList["button" .. n] = bt

                bt.ds = bt:CreateTexture()
                bt.ds:SetPoint("TOPLEFT", -4, -2)
                bt.ds:SetPoint("BOTTOMRIGHT", 0, 0)
                bt.ds:SetColorTexture(1, 1, 1, BG.onEnterAlpha)
                bt.ds:Hide()

                if bt.itemID then
                    bt:RegisterEvent("GET_ITEM_INFO_RECEIVED")
                    bt:SetScript("OnEvent", function(self, even, _itemID, success)
                        if self.itemID == _itemID and success then
                            SetButtonText(bt)
                            self:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
                        end
                    end)

                    if GetItemInfo(bt.itemID) then
                        SetButtonText(bt)
                        -- else
                        --     pt(bt.itemID) -- 测试新添加的装备ID是否有错误
                    end
                end

                bt:SetScript("OnEnter", function(self)
                    if bt.itemID then
                        if BG.ButtonIsInRight(self) then
                            GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
                        else
                            GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
                        end
                        GameTooltip:ClearLines()
                        GameTooltip:SetItemByID(self.itemID)
                        GameTooltip:Show()
                        local h = { FB, self.itemID }
                        BG.HistoryJine(unpack(h))
                        BG.HistoryMOD = h
                    end
                    self.ds:Show()
                end)
                bt:SetScript("OnLeave", function(self)
                    GameTooltip:Hide()
                    self.ds:Hide()
                    if BG["HistoryJineFrameDB1"] then
                        for i = 1, BG.HistoryJineFrameDBMax do
                            BG["HistoryJineFrameDB" .. i]:Hide()
                        end
                        BG.HistoryJineFrame:Hide()
                    end
                end)
                bt:SetScript("OnMouseDown", function(self, enter)
                    if self.link then
                        if IsShiftKeyDown() then
                            BG.InsertLink(self.link, true)
                        elseif IsControlKeyDown() then
                            BG.GoToItemLib(self)
                        elseif IsAltKeyDown() then
                            if not self.owner.hopenandu then
                                BiaoGe[FB]["boss" .. self.owner.bossnum]["guanzhu" .. self.owner.i] = true
                                BG.Frame[FB]["boss" .. self.owner.bossnum]["guanzhu" .. self.owner.i]:Show()
                            end
                            self.owner:SetText(self.link)
                            self.owner:ClearFocus()
                            BG.FrameZhuangbeiList:Hide()
                        else
                            self.owner:SetText(self.link)
                            self.owner:ClearFocus()
                            BG.FrameZhuangbeiList:Hide()
                        end
                    else
                        self.owner:SetText("")
                        self.owner:ClearFocus()
                        BG.FrameZhuangbeiList:Hide()
                    end
                end)
            end
        end
        f:SetSize(btwidth * 2 + 10 + 10, (btheight + 2) * MaxI + 5 + 3)
        text:SetWidth(f:GetWidth())

        CreateLootLog(self)
    end
end

------------------创建：装绑图标------------------
function BG.BindOnEquip(bt, bindType, height)
    if not bt.bindingTex then
        local f = CreateFrame("Frame", nil, bt)
        f:SetSize(20, height or 20)
        f:SetPoint("RIGHT", 3, 0)
        local tex = f:CreateTexture()
        tex:SetSize(13, 12)
        tex:SetPoint("CENTER")
        tex:SetTexture("Interface\\FriendsFrame\\StatusIcon-Online")
        bt.bindingTex = f
        f:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:AddLine(L["装绑"], 1, 1, 1, true)
            GameTooltip:Show()
        end)
        BG.GameTooltip_Hide(f)
    end
    if bindType == 2 then
        if bt.GetText then
            if bt:GetText():find("item:") then
                bt.bindingTex:Show()
            else
                bt.bindingTex:Hide()
            end
        else
            bt.bindingTex:Show()
        end
    else
        bt.bindingTex:Hide()
    end
end

------------------创建：装等------------------
function BG.LevelText(bt, level, typeID)
    if not bt.levelText then
        local f = CreateFrame("Frame", nil, bt)
        f:SetPoint("RIGHT", 0, 0)
        f.text = f:CreateFontString()
        f.text:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
        f.text:SetTextColor(RGB("A9A9A9", 0.8))
        f:SetSize(f.text:GetWidth(), 20)
        bt.levelText = f
    end
    if bt:GetText():find("item:") and (typeID == 2 or typeID == 4) and level then
        bt.levelText.text:ClearAllPoints()
        local x = -1
        if bt.bindingTex and bt.bindingTex:IsVisible() then
            x = -9
        end
        bt.levelText.text:SetPoint("RIGHT", x, 0)
        bt.levelText.text:SetText(level)
        bt.levelText:Show()
    else
        bt.levelText:Hide()
    end
end

------------------创建：已拥有（勾子）------------------
function BG.IsHave(bt, isZhuangbeiList)
    if not bt.isHaveTex then
        local tex = bt:CreateTexture(nil, 'OVERLAY')
        tex:SetSize(28, 28)
        if isZhuangbeiList then
            tex:SetPoint('LEFT', -10, 0)
        else
            tex:SetPoint('RIGHT', bt, 'LEFT', 0, 0)
        end
        tex:SetTexture("interface/raidframe/readycheck-ready")
        bt.isHaveTex = tex
    end

    local itemID = GetItemInfoInstant(bt:GetText())
    if bt:GetText():find("item:") and itemID and BG.GetItemCount(itemID) ~= 0 then
        bt.isHaveTex:Show()
    else
        bt.isHaveTex:Hide()
    end
end

------------------创建：已掉落------------------
function BG.LootedText(bt)
    if bt.looted then
        return
    end
    local f = CreateFrame("Frame", nil, bt, "BackdropTemplate")
    f:SetBackdrop({
        bgFile = "Interface/ChatFrame/ChatFrameBackground",
    })
    f:SetBackdropColor(0, 0, 0, 0.5)
    f:SetPoint("RIGHT", 0, 0)
    f:SetFrameLevel(bt:GetFrameLevel() + 10)
    f:Hide()
    f.text = f:CreateFontString()
    f.text:SetPoint("RIGHT")
    f.text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
    f.text:SetTextColor(RGB(BG.dis))
    f.text:SetText(L["已掉落"])
    f:SetSize(f.text:GetWidth(), 15)
    bt.looted = f
end

------------------创建：关注------------------
function BG.CreateGuanZhuButton(bt, _type)
    local FB = bt.FB
    local bossnum = bt.bossnum
    local t = bt.t
    local b = bt.b
    local i = bt.i

    local f = CreateFrame("Frame", nil, bt, "BackdropTemplate")
    f:SetBackdrop({
        bgFile = "Interface/ChatFrame/ChatFrameBackground",
        insets = { left = 0, right = 0, top = 3, bottom = 2 }
    })
    f:SetBackdropColor(0, 0, 0, 0.5)
    f:SetSize(20, 20)
    f:SetPoint("RIGHT", bt, "RIGHT", 0, 0)
    f:SetFrameLevel(112)
    f:Hide()
    f.text = f:CreateFontString()
    f.text:SetPoint("CENTER")
    f.text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
    f.text:SetTextColor(RGB(BG.b1))
    f.text:SetText(L["关注"])
    f:SetWidth(f.text:GetWrappedWidth())
    if _type == "biaoge" then
        if BiaoGe[FB]["boss" .. bossnum]["guanzhu" .. i] then
            f:Show()
        end
    end

    f:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        if _type == "biaoge" then
            GameTooltip:AddLine(BG.STC_b1(L["关注中，团长拍卖此装备会提醒"]))
            GameTooltip:AddLine(L["右键取消关注"], 1, 0.82, 0)
        elseif _type == "history" then
            GameTooltip:AddLine(BG.STC_b1(L["关注中"]))
        end
        GameTooltip:Show()
    end)
    BG.GameTooltip_Hide(f)

    f:SetScript("OnMouseDown", function(self, enter)
        if _type == "biaoge" then
            if enter == "RightButton" then
                FrameHide(0)
                BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i] = nil
                self:Hide()
            end
        end
    end)

    return f
end

------------------创建：欠款------------------
function BG.CreateQiankuanButton(bt, _type)
    local FB = bt.FB
    local bossnum = bt.bossnum
    local t = bt.t
    local b = bt.b
    local i = bt.i

    local f = CreateFrame("Frame", nil, bt)
    f:SetSize(23, 23)
    f:SetPoint("LEFT", bt, "RIGHT", 0, 0)
    f:SetFrameLevel(115)
    f:Hide()
    f.text = f:CreateFontString()
    f.text:SetPoint("CENTER")
    f.text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
    f.text:SetTextColor(RGB(BG.r1))
    f.text:SetText(L["欠"])
    f:SetWidth(f.text:GetWrappedWidth())
    if _type == "biaoge" then
        if BiaoGe[FB]["boss" .. bossnum]["qiankuan" .. i] == "" then
            BiaoGe[FB]["boss" .. bossnum]["qiankuan" .. i] = nil
        end
        if BiaoGe[FB]["boss" .. bossnum]["qiankuan" .. i] then
            f:Show()
        end
    end

    f:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        if _type == "biaoge" then
            GameTooltip:AddLine(L["欠款："] .. BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["qiankuan" .. i], 1, 0, 0)
            GameTooltip:AddLine(L["右键清除欠款"], 1, 0.82, 0)
        elseif _type == "history" then
            GameTooltip:AddLine(L["欠款："] .. f.qiankuan, 1, 0, 0)
        end
        GameTooltip:Show()
    end)
    BG.GameTooltip_Hide(f)

    f:SetScript("OnMouseDown", function(self, enter)
        if _type == "biaoge" then
            if enter == "RightButton" then
                FrameHide(0)
                BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["qiankuan" .. i] = nil
                self:Hide()
            end
        end
    end)

    return f
end

------------------创建：买家下拉列表------------------    -- focus：0就是要清空光标,zhiye："jianshang"就是只显示骑士、德鲁伊、牧师
function BG.SetListmaijia(maijia, clearFocus, filter, isAuctionLogFrame)
    if BG.FrameMaijiaList then BG.FrameMaijiaList:Hide() end
    -- 背景框
    local f = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
    f:SetWidth(395)
    f:SetHeight(230)
    f:SetFrameLevel(120)
    f:SetBackdrop({
        bgFile = "Interface/ChatFrame/ChatFrameBackground",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    f:SetBackdropColor(0, 0, 0, 0.8)
    f:SetPoint("TOPLEFT", maijia, "BOTTOMLEFT", -9, 2)
    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    BG.FrameMaijiaList = f

    -- 下拉列表
    local framedown
    local frameright = f
    local raid = BG.PaiXuRaidRosterInfo(filter)
    for t = 1, 4 do
        for i = 1, 10 do
            local bt = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
            bt:SetSize(90, 20)
            bt:SetFrameLevel(125)
            bt:SetAutoFocus(false)
            if t >= 2 and i == 1 then
                bt:SetPoint("TOPLEFT", frameright, "TOPLEFT", 97, 0)
                frameright = bt
            end
            if t == 1 and i == 1 then
                bt:SetPoint("TOPLEFT", frameright, "TOPLEFT", 10, -5)
                frameright = bt
            end
            if i > 1 then
                bt:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -2)
            end
            if not filter and not IsInRaid(1) and t == 1 and i == 1 then -- 单人时
                bt:SetText(UnitName("player"))
                bt:SetCursorPosition(0)
                bt:SetTextColor(GetClassRGB(UnitName("player")))
                bt.hasName = true
                for k, v in pairs(BG.playerClass) do
                    bt[k] = select(v.select, v.func("player"))
                end
            end
            local num = (t - 1) * 10 + i
            if raid[num] and raid[num].name then
                if raid[num].role then
                    bt:SetText(AddTexture(raid[num].role) .. raid[num].name)
                else
                    bt:SetText(AddTexture(raid[num].combatRole) .. raid[num].name)
                end
                bt:SetCursorPosition(0)
                bt:SetTextColor(GetClassRGB(GetText_T(raid[num].name)))
                bt.hasName = true
            else
                bt:EnableMouse(false)
            end
            framedown = bt

            if bt.hasName then
                bt.ds = bt:CreateTexture()
                bt.ds:SetPoint("TOPLEFT", -4, -2)
                bt.ds:SetPoint("BOTTOMRIGHT", 0, 0)
                bt.ds:SetColorTexture(1, 1, 1, BG.onEnterAlpha)
                bt.ds:Hide()

                bt:SetScript("OnMouseDown", function(self, enter)
                    maijia:SetTextColor(bt:GetTextColor())
                    maijia:SetText(GetText_T(self))
                    maijia:SetCursorPosition(0)
                    if raid[num] or self.class then
                        for k, v in pairs(BG.playerClass) do
                            if isAuctionLogFrame then
                                BG.auctionLogFrame.changeFrame.info[k]
                                = raid[num] and raid[num][k] or self[k]
                            else
                                BiaoGe[maijia.FB]["boss" .. maijia.bossnum][k .. maijia.i]
                                = raid[num] and raid[num][k] or self[k]
                            end
                        end
                    end
                    f:Hide()
                    if clearFocus then
                        if BG.lastfocus then
                            BG.lastfocus:ClearFocus()
                        end
                    end
                end)
                bt:SetScript("OnEnter", function(self)
                    self.ds:Show()
                end)
                bt:SetScript("OnLeave", function(self)
                    GameTooltip:Hide()
                    self.ds:Hide()
                end)
            end
        end
    end
end

------------------创建：金额下拉列表------------------
do
    function BG.CreateNumFrame(self)
        if BiaoGe.options["NumFrame"] ~= 1 then return end
        if not BG.FrameNumFrame then
            local f = CreateFrame("Frame", nil, nil, "BackdropTemplate")
            f:SetSize(130, 230)
            f:SetBackdrop({
                bgFile = "Interface/ChatFrame/ChatFrameBackground",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 16,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            f:SetBackdropColor(0, 0, 0, 0.8)
            f:Hide()
            f:EnableMouse(true)
            BG.FrameNumFrame = f
            f:SetScript("OnHide", function(self)
                self:SetParent(nil)
                self:Hide()
            end)

            f.buttons = {}

            local function CreateButton(isYellow)
                local bt = CreateFrame("Button", nil, f, "BackdropTemplate")
                bt:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = 1.5,
                })
                bt:SetBackdropColor(0, 0, 0, 0.5)
                bt.color = isYellow and { RGB(BG.g2) } or { RGB(BG.y2) }

                bt:SetBackdropBorderColor(unpack(bt.color))
                bt:SetNormalFontObject(isYellow and BG.FontGreen215 or BG.FontGold15)
                bt:SetDisabledFontObject(BG.FontDis15)
                bt:SetHighlightFontObject(BG.FontWhite15)
                bt:HookScript("OnEnter", function(self)
                    bt:SetBackdropBorderColor(1, 1, 1, 1)
                end)
                bt:HookScript("OnLeave", function(self)
                    bt:SetBackdropBorderColor(unpack(bt.color))
                end)
                return bt
            end
            for i = 1, 9 do
                local bt = CreateButton()
                bt:SetSize(35, 35)
                bt:SetText(i)
                if i == 1 then
                    bt:SetPoint("BOTTOMLEFT", 8, 107)
                elseif (i - 1) % 3 == 0 then
                    bt:SetPoint("BOTTOMLEFT", f.buttons[i - 3], "TOPLEFT", 0, 5)
                else
                    bt:SetPoint("BOTTOMLEFT", f.buttons[i - 1], "BOTTOMRIGHT", 5, 0)
                end
                tinsert(f.buttons, bt)
                bt:SetScript("OnClick", function(self)
                    BG.PlaySound(1)
                    local edit = GetCurrentKeyBoardFocus()
                    if edit then
                        edit:Insert(self:GetText())
                    end
                end)
            end
            -- 0
            local bt = CreateButton()
            bt:SetSize(75, 30)
            bt:SetText(0)
            bt:SetPoint("TOPLEFT", f.buttons[1], "BOTTOMLEFT", 0, -5)
            f.button0 = bt
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                local edit = GetCurrentKeyBoardFocus()
                if edit then
                    edit:Insert(self:GetText())
                end
            end)
            -- .
            local bt = CreateButton()
            bt:SetSize(35, f.button0:GetHeight())
            bt:SetText(".")
            bt:SetPoint("TOPLEFT", f.button0, "TOPRIGHT", 5, 0)
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                local edit = GetCurrentKeyBoardFocus()
                if edit then
                    edit:Insert(self:GetText())
                end
            end)
            -- ←
            local bt = CreateButton(true)
            bt:SetSize(35, f.button0:GetHeight())
            bt:SetText("←")
            bt:SetPoint("TOPLEFT", f.button0, "BOTTOMLEFT", 0, -8)
            f.buttonJ = bt
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                local edit = GetCurrentKeyBoardFocus()
                if edit then
                    local text = edit:GetText()
                    local p = edit:GetCursorPosition()
                    local t1, t2 = text:sub(1, p), text:sub(p + 1)
                    t1 = string.utf8sub(t1, 1, string.utf8len(t1) - 1)
                    edit:SetText(t1 .. t2)
                    edit:SetCursorPosition(#t1)
                end
            end)
            -- Delete
            local bt = CreateButton(true)
            bt:SetSize(f.button0:GetWidth(), f.button0:GetHeight())
            bt:SetText("Delete")
            bt:SetPoint("TOPLEFT", f.buttonJ, "TOPRIGHT", 5, 0)
            bt:SetAlpha(f.buttonJ:GetAlpha())
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                local edit = GetCurrentKeyBoardFocus()
                if edit then
                    local text = edit:GetText()
                    local p = edit:GetCursorPosition()
                    local t1, t2 = text:sub(1, p), text:sub(p + 1)
                    t2 = string.utf8sub(t2, 2, string.utf8len(t2))
                    edit:SetText(t1 .. t2)
                    edit:SetCursorPosition(#t1)
                end
            end)

            -- 关闭
            local bt = CreateButton(true)
            bt:SetSize(f:GetWidth() - 15, 23)
            bt:SetText(L["关闭"])
            bt:SetPoint("BOTTOM", 1, 6)
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                local edit = GetCurrentKeyBoardFocus()
                if edit then
                    edit:ClearFocus()
                end
            end)

            local h = -4
            local l = f.button0:CreateLine()
            l:SetColorTexture(.5, .5, .5)
            l:SetStartPoint("BOTTOMLEFT", -5, h)
            l:SetEndPoint("BOTTOMLEFT", f:GetWidth() - 11, h)
            l:SetThickness(1)
        end
        local f = BG.FrameNumFrame
        f:SetParent(self)
        f:ClearAllPoints()
        f:SetPoint("TOPLEFT", self, "TOPRIGHT", -2, 0)
        f:Show()
        return f
    end

    function BG.GetGeZiTardeInfo(FB, b, i, isHistory)
        local tbl
        if isHistory then
            local DT = BiaoGe.HistoryList[FB][BG.History.chooseNum][1]
            tbl = BiaoGe.History[FB][DT].tradeTbl
        else
            tbl = BiaoGe[FB].tradeTbl
        end
        for ii, _ in ipairs(tbl) do
            for _, v in ipairs(tbl[ii]) do
                if FB == v.FB and b == v.b and i == v.i then
                    return tbl[ii], ii
                end
            end
        end
    end

    function BG.SetListjine(jine, FB, b, i)
        -- 背景框
        local f = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
        f:SetWidth(100)
        f:SetHeight(230)
        f:SetFrameLevel(120)
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.8)
        f:SetPoint("TOPLEFT", jine, "BOTTOMLEFT", -9, 2)
        f:EnableMouse(true)
        f:SetClampedToScreen(true)
        f:SetHyperlinksEnabled(true)
        BG.FrameJineList = f
        f:SetScript("OnHyperlinkEnter", function(self, link, text, button)
            -- GameTooltip:SetOwner(self, "ANCHOR_CURSOR", 0, 0)
            GameTooltip:SetOwner(button, "ANCHOR_RIGHT", 0, 0)
            GameTooltip:ClearLines()
            local itemID = GetItemInfoInstant(link)
            if itemID then
                GameTooltip:SetItemByID(itemID)
                GameTooltip:Show()
                BG.HighlightBiaoGe(link)
            end
        end)
        f:SetScript("OnHyperlinkLeave", function(self, link, text, button)
            GameTooltip:Hide()
            BG.Hide_AllHighlight()
        end)

        local t = f:CreateFontString()
        t:SetPoint("TOP", f, "TOP", 0, -10)
        t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
        t:SetText(L["欠款金额"])
        t:SetTextColor(1, 0, 0)
        t:SetWidth(f:GetWidth() - 5)
        t:SetWordWrap(false)

        local edit = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
        edit:SetSize(f:GetWidth() - 15, 20)
        edit:SetTextColor(1, 0, 0)
        edit:SetPoint("TOP", t, "BOTTOM", 2, -5)
        if BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
            edit:SetText(BiaoGe[FB]["boss" .. b]["qiankuan" .. i])
        end
        edit:SetNumeric(true)
        edit:SetAutoFocus(false)
        BG.FrameQianKuanEdit = edit
        edit:SetScript("OnTextChanged", function(self)
            BG.UpdateTwo0(self)
            if self:GetText() ~= "" then
                BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = self:GetText()
                BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Show()
            else
                BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = nil
                BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Hide()
            end
        end)
        edit:SetScript("OnEscapePressed", function(self)
            BG.FrameJineList:Hide()
        end)
        edit:SetScript("OnEnterPressed", function(self)
            BG.FrameJineList:Hide()
        end)
        edit:SetScript("OnEditFocusGained", function(self)
            BG.CreateNumFrame(BG.FrameJineList)
        end)
        edit:HookScript("OnEditFocusLost", function(self)
            if BG.FrameNumFrame then
                BG.FrameNumFrame:Hide()
            end
        end)
        edit:SetScript("OnMouseDown", function(self, enter)
            if enter == "RightButton" then
                self:SetEnabled(false)
                self:SetText("")
            end
        end)
        edit:SetScript("OnMouseUp", function(self, enter)
            if enter == "RightButton" then
                self:SetEnabled(true)
            end
        end)

        local tradeInfo, num = BG.GetGeZiTardeInfo(FB, b, i)
        if tradeInfo then
            local t = f:CreateFontString()
            t:SetPoint("TOP", edit, "BOTTOM", 0, -15)
            t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            t:SetText(L["打包交易"])
            t:SetTextColor(0, 1, 0)
            t:SetWidth(BG.FrameJineList:GetWidth() - 5)
            t:SetWordWrap(false)
            local tradeText = t

            local buttons = {}
            for i, v in ipairs(tradeInfo) do
                local f = CreateFrame("Frame", nil, BG.FrameJineList, "BackdropTemplate")
                f:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                })
                f:SetBackdropColor(0.5, 0.5, 0.5, 0)
                if i == 1 then
                    f:SetPoint("TOP", tradeText, "BOTTOM", 0, -5)
                else
                    f:SetPoint("TOP", buttons[i - 1], "BOTTOM", 0, 0)
                end
                f:SetSize(BG.FrameJineList:GetWidth() - 10, 18)
                f:EnableMouse(true)
                tinsert(buttons, f)
                f:SetScript("OnEnter", function(self)
                    self:SetBackdropColor(0.5, 0.5, 0.5, 0.5)
                    GameTooltip:SetOwner(f, "ANCHOR_RIGHT", 0, 0)
                    GameTooltip:ClearLines()
                    GameTooltip:SetItemByID(v.itemID)
                    GameTooltip:Show()
                    if BG.Frame[v.FB]["boss" .. v.b] then
                        local zb = BG.Frame[v.FB]["boss" .. v.b]["zhuangbei" .. v.i]
                        local jine = BG.Frame[v.FB]["boss" .. v.b]["jine" .. v.i]
                        if zb then
                            local f = BG.CreateHighlightFrame(zb, nil, { 0, 1, 0, 0.5 }, 4)
                            f:ClearAllPoints()
                            f:SetPoint("TOPLEFT", zb, "TOPLEFT", 0, 0)
                            f:SetPoint("BOTTOMRIGHT", jine, "BOTTOMRIGHT", 0, 0)
                        end
                    end
                end)
                f:SetScript("OnLeave", function(self)
                    self:SetBackdropColor(0.5, 0.5, 0.5, 0)
                    GameTooltip:Hide()
                    BG.Hide_AllHighlight()
                end)

                local icon = f:CreateTexture()
                icon:SetPoint('LEFT', 0, 0)
                icon:SetSize(14, 14)
                icon:SetTexture(select(5, GetItemInfoInstant(v.itemID)))

                local t = f:CreateFontString()
                t:SetPoint("LEFT", icon, "RIGHT", 0, 0)
                t:SetWidth(f:GetWidth() - icon:GetWidth())
                t:SetFontObject(GameFontNormal)
                t:SetText(v.link)
                t:SetJustifyH("LEFT")
                t:SetWordWrap(false)
            end

            local bt = CreateFrame("Button", nil, BG.FrameJineList, "UIPanelButtonTemplate")
            bt:SetSize(BG.FrameJineList:GetWidth() - 15, 20)
            bt:SetPoint("BOTTOM", 0, 5)
            bt:SetText(L["删除打包交易记录"])
            BG.ButtonTextSetWordWrap(bt)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
                GameTooltip:AddLine(L["删除后不再高亮绿色框。请放心，该按钮不会删除表格内容。"], 1, 0.82, 0, true)
                GameTooltip:Show()
            end)
            bt:SetScript("OnLeave", GameTooltip_Hide)
            bt:SetScript("OnClick", function(self)
                BG.PlaySound(1)
                for _, FB in ipairs(BG.FBtable) do
                    local tradeInfo, num = BG.GetGeZiTardeInfo(FB, b, i)
                    if num then
                        tremove(BiaoGe[FB].tradeTbl, num)
                    end
                end
                jine:ClearFocus()
                jine:SetFocus()
            end)
        end
    end
end

------------------函数：窗口切换动画------------------
local function FrameDongHua(frame, h2, w2)
    local h1 = frame:GetHeight()
    local w1 = frame:GetWidth()
    local Time = 0.5
    local T = 50
    local t1 = Time / T
    local t2 = Time / T
    if w1 > w2 then
        for i = T, 1, -1 do
            C_Timer.After(t1, function()
                frame:SetWidth(w2 + (w1 - w2) * ((i - 1) / T)) -- 窗口变小
            end)
            t1 = t1 + Time / T
        end
    elseif w2 > w1 then
        for i = 1, T, 1 do
            C_Timer.After(t1, function()
                frame:SetWidth(w1 + (w2 - w1) * (i / T)) -- 窗口变大
            end)
            t1 = t1 + Time / T
        end
    end
    if h1 > h2 then
        for i = T, 1, -1 do
            C_Timer.After(t2, function()
                frame:SetHeight(h2 + (h1 - h2) * ((i - 1) / T)) -- 窗口变小
            end)
            t2 = t2 + Time / T
        end
    elseif h2 > h1 then
        for i = 1, T, 1 do
            C_Timer.After(t2, function()
                frame:SetHeight(h1 + (h2 - h1) * (i / T)) -- 窗口变大
            end)
            t2 = t2 + Time / T
        end
    end
end
ns.FrameDongHua = FrameDongHua

------------------单元格内容交换------------------
function BG.JiaoHuan(button, FB, b, i, t)
    if not BG.copy1 then
        BG.copy1 = {
            fb = FB,
            b = BossNum(FB, b, t),
            i = i,
            btzhuangbei = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i],
            btmaijia = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i],
            btjine = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i],
            btqiankuan = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["qiankuan" .. i],
            btguanzhu = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i],

            zhuangbei = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i],
            maijia = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i],
            jine = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i],
            qiankuan = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["qiankuan" .. i],
            guanzhu = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i],

            tradeInfo = BG.GetGeZiTardeInfo(FB, BossNum(FB, b, t), i),
            loot = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["loot" .. i],
        }
        for k, v in pairs(BG.playerClass) do
            BG.copy1[k] = BiaoGe[FB]["boss" .. BossNum(FB, b, t)][k .. i]
        end

        BG.PlaySound(1)

        local bt = CreateFrame("Button", nil, BG["Frame" .. FB], "UIPanelButtonTemplate")
        bt:SetSize(80, 20)
        bt:SetPoint("RIGHT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i], "LEFT", -5, 0)
        bt:SetFrameLevel(BG.MainFrame:GetFrameLevel() + 15)
        bt:SetText(L["取消交换"])
        BG.copyButton = bt
        bt:SetScript("OnClick", function()
            if BG.copy1 then
                BG.copy1 = nil
            end
            BG.copyButton:Hide()
            BG.PlaySound(1)
        end)
        bt:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
            GameTooltip:ClearLines()
            GameTooltip:SetText(BG.STC_b1(L["你正在交换该行全部内容"]) .. L["\n点击取消交换"])
        end)
        BG.GameTooltip_Hide(bt)

        local f = BG.Create_BlinkHilight(bt)
        f:SetPoint("TOPLEFT", bt, "TOPLEFT", -10, 5)
        f:SetPoint("BOTTOMRIGHT", bt, "BOTTOMRIGHT", 10, -5)

        local f = BG.Create_BlinkHilight(bt, BG.MainFrame:GetFrameLevel() + 1)
        f:SetPoint("TOPLEFT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i], "TOPLEFT", -80, 5)
        f:SetPoint("BOTTOMRIGHT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i], "BOTTOMRIGHT", 90, -5)
    else
        BG.copy2 = {
            fb = FB,
            b = BossNum(FB, b, t),
            i = i,
            btzhuangbei = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i],
            btmaijia = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i],
            btjine = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i],
            btqiankuan = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["qiankuan" .. i],
            btguanzhu = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i],

            zhuangbei = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i],
            maijia = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i],
            jine = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i],
            qiankuan = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["qiankuan" .. i],
            guanzhu = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i],

            tradeInfo = BG.GetGeZiTardeInfo(FB, BossNum(FB, b, t), i),
            loot = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["loot" .. i],
        }
        for k, v in pairs(BG.playerClass) do
            BG.copy2[k] = BiaoGe[FB]["boss" .. BossNum(FB, b, t)][k .. i]
        end

        if BG.copy1.fb == BG.copy2.fb then -- 是同一个副本
            -- 打包交易
            if not (BG.copy1.tradeInfo and BG.copy2.tradeInfo and BG.copy1.tradeInfo == BG.copy2.tradeInfo) then
                if BG.copy1.tradeInfo then
                    -- 修改该打包交易中，格子1的b和i改为格子2的b和i
                    for i, v in ipairs(BG.copy1.tradeInfo) do
                        if BG.copy1.b == v.b and BG.copy1.i == v.i then
                            v.b = BG.copy2.b
                            v.i = BG.copy2.i
                        end
                    end
                end
                if BG.copy2.tradeInfo then
                    for i, v in ipairs(BG.copy2.tradeInfo) do
                        if BG.copy2.b == v.b and BG.copy2.i == v.i then
                            v.b = BG.copy1.b
                            v.i = BG.copy1.i
                        end
                    end
                end
            else
                local copy1_b = BG.copy1.b
                local copy1_i = BG.copy1.i
                local copy2_b = BG.copy2.b
                local copy2_i = BG.copy2.i
                for i, v in ipairs(BG.copy1.tradeInfo) do
                    if copy1_b == v.b and copy1_i == v.i then
                        v.b = copy2_b
                        v.i = copy2_i
                    elseif copy2_b == v.b and copy2_i == v.i then
                        v.b = copy1_b
                        v.i = copy1_i
                    end
                end
            end

            BG.copy1.btzhuangbei:SetText(BG.copy2.zhuangbei or "")
            BG.copy1.btmaijia:SetText(BG.copy2.maijia or "")
            BG.copy1.btmaijia:SetTextColor(unpack(BG.copy2.color or { 1, 1, 1 }))
            BG.copy1.btjine:SetText(BG.copy2.jine or "")

            BG.copy2.btzhuangbei:SetText(BG.copy1.zhuangbei or "")
            BG.copy2.btmaijia:SetText(BG.copy1.maijia or "")
            BG.copy2.btmaijia:SetTextColor(unpack(BG.copy1.color or { 1, 1, 1 }))
            BG.copy2.btjine:SetText(BG.copy1.jine or "")

            local FB = BG.copy1.fb
            local b1, i1 = BG.copy1.b, BG.copy1.i
            local b2, i2 = BG.copy2.b, BG.copy2.i

            for k, v in pairs(BG.playerClass) do
                BiaoGe[FB]["boss" .. b1][k .. i1] = BG.copy2[k]
                BiaoGe[FB]["boss" .. b2][k .. i2] = BG.copy1[k]
            end
            -- 拾取记录
            BiaoGe[FB]["boss" .. b1]["loot" .. i1], BiaoGe[FB]["boss" .. b2]["loot" .. i2] =
                BiaoGe[FB]["boss" .. b2]["loot" .. i2], BiaoGe[FB]["boss" .. b1]["loot" .. i1]
            -- 关注
            BiaoGe[FB]["boss" .. b1]["guanzhu" .. i1], BiaoGe[FB]["boss" .. b2]["guanzhu" .. i2] =
                BiaoGe[FB]["boss" .. b2]["guanzhu" .. i2], BiaoGe[FB]["boss" .. b1]["guanzhu" .. i1]
            if BiaoGe[FB]["boss" .. b1]["guanzhu" .. i1] then
                BG.Frame[FB]["boss" .. b1]["guanzhu" .. i1]:Show()
            else
                BG.Frame[FB]["boss" .. b1]["guanzhu" .. i1]:Hide()
            end
            if BiaoGe[FB]["boss" .. b2]["guanzhu" .. i2] then
                BG.Frame[FB]["boss" .. b2]["guanzhu" .. i2]:Show()
            else
                BG.Frame[FB]["boss" .. b2]["guanzhu" .. i2]:Hide()
            end
            -- 欠款
            BiaoGe[FB]["boss" .. b1]["qiankuan" .. i1], BiaoGe[FB]["boss" .. b2]["qiankuan" .. i2] =
                BiaoGe[FB]["boss" .. b2]["qiankuan" .. i2], BiaoGe[FB]["boss" .. b1]["qiankuan" .. i1]
            if BiaoGe[FB]["boss" .. b1]["qiankuan" .. i1] then
                BG.Frame[FB]["boss" .. b1]["qiankuan" .. i1]:Show()
            else
                BG.Frame[FB]["boss" .. b1]["qiankuan" .. i1]:Hide()
            end
            if BiaoGe[FB]["boss" .. b2]["qiankuan" .. i2] then
                BG.Frame[FB]["boss" .. b2]["qiankuan" .. i2]:Show()
            else
                BG.Frame[FB]["boss" .. b2]["qiankuan" .. i2]:Hide()
            end

            local text = BG.copy2.btzhuangbei:CreateFontString()
            text:SetPoint("RIGHT", BG.copy2.btzhuangbei, "LEFT", -5, 0)
            text:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
            text:SetText(BG.STC_b1(L["交换成功"]))
            C_Timer.After(1, function()
                BG.DongHuaAlpha(text)
            end)

            BG.copy1 = nil
            BG.copy2 = nil
            BG.copyButton:Hide()
        else -- 不是同一个副本
            BG.copy1 = nil
            BG.copy2 = nil
            BG.copyButton:Hide()

            BG.copy1 = {
                fb = FB,
                b = BossNum(FB, b, t),
                i = i,
                btzhuangbei = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i],
                btmaijia = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i],
                btjine = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i],
                btqiankuan = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["qiankuan" .. i],
                btguanzhu = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i],

                zhuangbei = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i]:GetText(),
                maijia = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i]:GetText(),
                color = { BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i]:GetTextColor() },
                jine = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i]:GetText(),
                qiankuan = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["qiankuan" .. i],
                guanzhu = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i],
            }
            BG.PlaySound(1)

            local bt = CreateFrame("Button", nil, BG["Frame" .. FB], "UIPanelButtonTemplate")
            bt:SetSize(80, 20)
            bt:SetPoint("RIGHT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i], "LEFT", -5, 0)
            bt:SetFrameLevel(BG.MainFrame:GetFrameLevel() + 15)
            bt:SetText(L["取消交换"])
            BG.copyButton = bt
            bt:SetScript("OnClick", function()
                if BG.copy1 then
                    BG.copy1 = nil
                end
                BG.copyButton:Hide()
                BG.PlaySound(1)
            end)
            bt:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:SetText(BG.STC_b1(L["你正在交换该行全部内容"]) .. L["\n点击取消交换"])
            end)
            BG.GameTooltip_Hide(bt)

            local f = BG.Create_BlinkHilight(bt)
            f:SetPoint("TOPLEFT", bt, "TOPLEFT", -10, 5)
            f:SetPoint("BOTTOMRIGHT", bt, "BOTTOMRIGHT", 10, -5)

            local f = BG.Create_BlinkHilight(bt, BG.MainFrame:GetFrameLevel() + 1)
            f:SetPoint("TOPLEFT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i], "TOPLEFT", -80, 5)
            f:SetPoint("BOTTOMRIGHT", BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i], "BOTTOMRIGHT", 90, -5)
        end

        BG.PlaySound(1)
    end
end

------------------模板：创建蓝底高光材质------------------
function BG.Create_BlinkHilight(Parent, level)
    local f = CreateFrame("Frame", nil, Parent)
    f:SetFrameLevel(level or Parent:GetFrameLevel() - 1)
    local texture = f:CreateTexture(nil, "BACKGROUND") -- 高亮材质
    texture:SetAllPoints()
    texture:SetTexture("Interface/ChatFrame/UI-ChatIcon-BlinkHilight")
    return f
end

------------------动画：慢慢透明然后隐藏------------------
function BG.DongHuaAlpha(bt, time)
    if not time then
        time = 2
    end
    local T = 50 * time
    local t = time / T
    for i = T, 1, -1 do
        C_Timer.After(t, function()
            bt:SetAlpha(1 * ((i - 1) / T))
        end)
        t = t + time / T
    end
    C_Timer.After(time, function()
        bt:Hide()
    end)
end

------------------表格/背包高亮对应装备------------------
do
    function BG.CreateHighlightFrame(parent, flash, color, level, size)
        local r, g, b, a
        if color then
            r, g, b, a = unpack(color)
        else
            r, g, b, a = 1, 0, 0, 1
        end
        local parent = parent or UIParent
        local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
        f:SetBackdrop({
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = size or (flash and 4 or 2),
        })
        f:SetBackdropBorderColor(r, g, b, a)
        f:SetPoint("TOPLEFT")
        f:SetPoint("BOTTOMRIGHT")
        f:SetFrameLevel(parent:GetFrameLevel() + (level or 8))
        tinsert(BG.LastBagItemFrame, f)

        if flash then
            local flashGroup = f:CreateAnimationGroup()
            for i = 1, 3 do
                local fade = flashGroup:CreateAnimation('Alpha')
                fade:SetChildKey('flash')
                fade:SetOrder(i * 2)
                fade:SetDuration(.4)
                fade:SetFromAlpha(.1)
                fade:SetToAlpha(1)

                local fade = flashGroup:CreateAnimation('Alpha')
                fade:SetChildKey('flash')
                fade:SetOrder(i * 2 + 1)
                fade:SetDuration(.4)
                fade:SetFromAlpha(1)
                fade:SetToAlpha(.1)
            end
            flashGroup:Play()
            flashGroup:SetLooping("REPEAT")
        end

        return f
    end

    function BG.HighlightBag(link)
        if BiaoGe.options["HighOnterItem"] ~= 1 then return end
        if not GetItemID(link) then return end
        if _G["NDui_BackpackSlot1"] then
            local i = 1
            while _G["NDui_BackpackSlot" .. i] do
                local bag = _G["NDui_BackpackSlot" .. i]
                local _link = C_Container.GetContainerItemLink(bag.bagId, bag.slotId)
                if _link and GetItemID(_link) == GetItemID(link) then
                    BG.CreateHighlightFrame(bag, true)
                end
                i = i + 1
            end
        elseif _G["ElvUI_ContainerFrame"] then
            local b = -1
            local i = 1
            while _G["ElvUI_ContainerFrameBag" .. b .. "Slot" .. i] do
                while _G["ElvUI_ContainerFrameBag" .. b .. "Slot" .. i] do
                    local bag = _G["ElvUI_ContainerFrameBag" .. b .. "Slot" .. i]
                    local _link = C_Container.GetContainerItemLink(bag.BagID, bag.SlotID)
                    if _link and GetItemID(_link) == GetItemID(link) then
                        BG.CreateHighlightFrame(bag, true)
                    end
                    i = i + 1
                end
                b = b + 1
                i = 1
            end
        elseif _G["CombuctorFrame1"] then
            local i = 1
            while _G["CombuctorItem" .. i] do
                local bag = _G["CombuctorItem" .. i]
                local _link = C_Container.GetContainerItemLink(bag:GetParent():GetID(), bag:GetID())
                if _link and GetItemID(_link) == GetItemID(link) then
                    BG.CreateHighlightFrame(bag, true)
                end
                i = i + 1
            end
        elseif _G["BagnonContainerItem1"] then
            local i = 1
            while _G["BagnonContainerItem" .. i] do
                local bag = _G["BagnonContainerItem" .. i]
                local _link = C_Container.GetContainerItemLink(bag:GetParent():GetID(), bag:GetID())
                if _link and GetItemID(_link) == GetItemID(link) then
                    BG.CreateHighlightFrame(bag, true)
                end
                i = i + 1
            end
        else
            local b = 1
            local i = 1
            while _G["ContainerFrame" .. b .. "Item" .. i] do
                while _G["ContainerFrame" .. b .. "Item" .. i] do
                    local bag = _G["ContainerFrame" .. b .. "Item" .. i]
                    local _link = C_Container.GetContainerItemLink(bag:GetParent():GetID(), bag:GetID())
                    if _link and GetItemID(_link) == GetItemID(link) then
                        BG.CreateHighlightFrame(bag, true)
                    end
                    i = i + 1
                end
                b = b + 1
                i = 1
            end
        end
    end

    function BG.HighlightBiaoGe(link)
        if BiaoGe.options["HighOnterItem"] ~= 1 then return end
        if not GetItemID(link) then return end
        local type
        if BG.FBMainFrame:IsVisible() then
            type = "FB"
        elseif BG.DuiZhangMainFrame:IsVisible() then
            type = "DuiZhang"
        end
        if not type then return end
        local FB = BG.FB1
        for b = 1, Maxb[FB] do
            for i = 1, Maxi[FB] do
                local zb, jine
                if type == "FB" then
                    zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                    jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
                elseif type == "DuiZhang" then
                    zb = BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]
                    jine = BG.DuiZhangFrame[FB]["boss" .. b]["otherjine" .. i]
                end
                if zb then
                    if GetItemID(link) == GetItemID(zb:GetText()) then
                        local f = BG.CreateHighlightFrame(zb)
                        f:ClearAllPoints()
                        f:SetPoint("TOPLEFT", zb, "TOPLEFT", 0, 0)
                        f:SetPoint("BOTTOMRIGHT", jine, "BOTTOMRIGHT", 0, 0)
                    end
                end
            end
        end
    end

    function BG.HighlightItemOutTime(link)
        if not BG.itemGuoQiFrame or not BG.itemGuoQiFrame:IsVisible() then return end
        if not link then return end
        local itemID = GetItemID(link)
        for i, bt in ipairs(BG.itemGuoQiFrame.buttons) do
            if bt.itemID == itemID then
                BG.CreateHighlightFrame(bt)
            end
        end
    end

    function BG.HighlightItemAuctionLog(link)
        if not BG.auctionLogFrame or not BG.auctionLogFrame:IsVisible() then return end
        if not link then return end
        local itemID = GetItemID(link)
        for i, bt in ipairs(BG.auctionLogFrame.buttons) do
            if bt.itemID == itemID then
                BG.CreateHighlightFrame(bt.frame)
            end
        end
    end

    BG.updateHighlightChatFrame = CreateFrame("Frame")
    BG.updateHighlightChatFrame.frames = {}
    function BG.HighlightChatFrame(link)
        if BiaoGe.options["HighOnterItem"] ~= 1 then return end
        if not IsInRaid(1) then return end
        local itemID = GetItemID(link)
        if not itemID then return end
        BG.highlightChatFrameItemID = itemID
        local i = 1
        while _G["ChatFrame" .. i] do
            local ChatFrame = _G["ChatFrame" .. i]
            if ChatFrame and ChatFrame:IsVisible() then
                for i, fontString in ipairs(ChatFrame.visibleLines) do
                    local text = fontString:GetText()
                    if text and text:find("item:" .. itemID .. ":") and fontString:IsVisible() and fontString:GetAlpha() ~= 0 then
                        local f = CreateFrame("Frame", nil, nil, "BackdropTemplate")
                        f:SetPoint("TOPLEFT", fontString, "TOPLEFT", 0, 0)
                        f:SetPoint("BOTTOMRIGHT", fontString, "BOTTOMRIGHT", 0, 0)
                        f:SetFrameLevel(ChatFrame:GetFrameLevel() + 2)
                        tinsert(BG.updateHighlightChatFrame.frames, f)
                        tinsert(BG.LastBagItemFrame, f)

                        local l = f:CreateLine()
                        l:SetColorTexture(1, 0, 0)
                        l:SetStartPoint("BOTTOMLEFT", 0, 0)
                        l:SetEndPoint("BOTTOMRIGHT", 0, 0)
                        l:SetThickness(1)
                    end
                end
            end
            i = i + 1
        end
    end

    function BG.Show_AllHighlight(link, btType)
        BG.Hide_AllHighlight()
        if (btType and btType ~= "bag") or not btType then
            BG.HighlightBag(link)
        end
        if (btType and btType ~= "biaoge") or not btType then
            BG.HighlightBiaoGe(link)
        end
        if (btType and btType ~= "chat") or not btType then
            BG.HighlightChatFrame(link)
        end
        if (btType and btType ~= "outtime") or not btType then
            BG.HighlightItemOutTime(link)
        end
        if (btType and btType ~= "auctionlog") or not btType then
            BG.HighlightItemAuctionLog(link)
        end
    end

    function BG.Hide_AllHighlight()
        for _, f in pairs(BG.LastBagItemFrame) do
            f:Hide()
        end
        wipe(BG.LastBagItemFrame)

        BG.Hide_ChatHighlight()
        BG.highlightChatFrameItemID = nil
    end

    function BG.Hide_ChatHighlight()
        for _, f in pairs(BG.updateHighlightChatFrame.frames) do
            f:Hide()
        end
        wipe(BG.updateHighlightChatFrame.frames)
    end
end

------------------创建按钮模板1------------------
function BG.Create_Button1(parent)
    local bt = CreateFrame("Button", nil, parent)
    bt:SetNormalFontObject(BG.FontBlue15)
    bt:SetDisabledFontObject(BG.FontBlue15)
    bt:SetHighlightFontObject(BG.FontBlue15)

    local texture2 = bt:CreateTexture(nil, "OVERLAY")
    texture2:SetBlendMode("ALPHAKEY")
    texture2:SetAllPoints()
    texture2:SetColorTexture(RGB("FFA500", 0.2))
    local texture3 = bt:CreateTexture(nil, "BACKGROUND")
    texture3:SetAllPoints()
    texture3:SetColorTexture(RGB("DCDCDC", 0.2))
    bt:SetDisabledTexture(texture2)
    bt:SetNormalTexture(texture3)

    bt:HookScript("OnEnter", function(self)
        texture3:SetColorTexture(RGB("FFA500", 0.5))
    end)
    bt:HookScript("OnLeave", function(self)
        texture3:SetColorTexture(RGB("DCDCDC", 0.2))
    end)
    -- bt:HookScript("OnClick", function(self)
    -- end)
    return bt
end

------------------返回表格页面------------------
function BG.BackBiaoGe(parent)
    local bt = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    bt:SetSize(150, 30)
    bt:SetPoint("BOTTOMRIGHT", BG.MainFrame, "BOTTOMRIGHT", -30, 35)
    bt:SetText(L["返回表格"])
    bt:SetScript("OnClick", function(self)
        BG.ClickTabButton(BG.FBMainFrameTabNum)
        BG.Backing = true
        C_Timer.After(1, function()
            BG.Backing = nil
        end)
        BG.PlaySound(1)
    end)
end

------------------跳转装备库相同部位------------------
local function CheckItemEquipLoc(link)
    local itemID, _, _, itemEquipLoc = GetItemInfoInstant(link)
    for _, FB in pairs(BG.phaseFBtable[BG.FB1]) do
        if BG.Loot[FB].ExchangeItems[itemID] then
            local firstItem = BG.Loot[FB].ExchangeItems[itemID][1]
            if firstItem then
                local _, _, _, itemEquipLoc = GetItemInfoInstant(firstItem)
                if itemEquipLoc then
                    return BG.GetEquipLocName(itemEquipLoc)
                end
            end
        end
    end
    if itemEquipLoc then
        return BG.GetEquipLocName(itemEquipLoc)
    end
end
function BG.GoToItemLib(button)
    local link = button:GetText()
    local itemEquipLoc = CheckItemEquipLoc(link)
    if itemEquipLoc then
        for i, bt in ipairs(BG.itemLib_Inv_Buttons) do
            if bt.inv == itemEquipLoc then
                BG.ClickTabButton(BG.ItemLibMainFrameTabNum)
                BG.InvOnClick(bt)
                return
            end
        end
    else
        UIErrorsFrame:AddMessage(L["这个物品不是装备"], RED_FONT_COLOR:GetRGB())
    end
end

------------------获取Auction插件里某个物品的历史价格------------------
function BG.GetAuctionPrice(itemID, mod)
    itemID = tostring(itemID)
    local realmName = GetRealmName()
    local faction = UnitFactionGroup("player")
    if AUCTIONATOR_PRICE_DATABASE and AUCTIONATOR_PRICE_DATABASE[realmName .. " " .. faction] and
        AUCTIONATOR_PRICE_DATABASE[realmName .. " " .. faction][itemID] then
        local m = AUCTIONATOR_PRICE_DATABASE[realmName .. " " .. faction][itemID].m
        if mod == "notsilver" then
            m = m - (m % 10000)
        elseif mod == "notcopper" then
            m = m - (m % 100)
        end

        return GetMoneyString(m, true), m
    else
        return ""
    end
end

------------------复原一个设置------------------
function BG.Once(name, dt, func)
    if BiaoGe and BiaoGe.options and BiaoGe.options.SearchHistory then
        if not BiaoGe.options.SearchHistory[name .. dt] then
            func()
            BiaoGe.options.SearchHistory[name .. dt] = true
        end
    end
end

------------------创建滚动框------------------
do
    function BG.CreateScrollFrame(parent, w, h, isEdit, alwaysHide)
        local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        f:SetBackdropColor(0, 0, 0, 0.8)
        if w and h then
            f:SetSize(w, h)
        end
        f:EnableMouse(true)
        f:Show()

        local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate") -- 滚动
        scroll:SetWidth(f:GetWidth() - 31)
        scroll:SetHeight(f:GetHeight() - 9)
        scroll:SetPoint("TOPLEFT", f, "TOPLEFT", 5, -5)
        scroll.ScrollBar.scrollStep = BG.scrollStep
        f.scroll = scroll
        BG.CreateSrollBarBackdrop(scroll.ScrollBar)
        BG.HookScrollBarShowOrHide(scroll, alwaysHide)

        local child
        if isEdit then
            child = CreateFrame("EditBox", nil, scroll)
            child:SetWidth(scroll:GetWidth())
            child:SetHeight(scroll:GetHeight())
            child:SetAutoFocus(false)
            child:EnableMouse(false)
            child:SetMultiLine(true)
            child:SetFontObject(GameFontNormal)
        else
            child = CreateFrame("Frame", nil, scroll) -- 子框架
            child:SetWidth(scroll:GetWidth())
            child:SetHeight(scroll:GetHeight())
        end
        scroll:SetScrollChild(child)

        return f, child
    end

    function BG.CreateSrollBarBackdrop(bar)
        local tex = bar:CreateTexture()
        tex:SetPoint("TOPLEFT", bar.ScrollUpButton, -0, 0)
        tex:SetPoint("BOTTOMRIGHT", bar.ScrollDownButton, 0, -0)
        tex:SetColorTexture(0, 0, 0, 0.3)
    end

    function BG.HookScrollBarShowOrHide(scroll, alwaysHide)
        scroll.ScrollBar:Hide()
        scroll:HookScript("OnScrollRangeChanged", function(self, xrange, yrange)
            if alwaysHide then
                scroll.ScrollBar:Hide()
            else
                if yrange == 0 then
                    self.ScrollBar:Hide()
                else
                    self.ScrollBar:Show()
                end
            end
        end)
    end
end

------------------右键通知框清除关注------------------
function BG.CancelGuanZhu(link)
    local name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
    local yes
    for _, FB in pairs(BG.FBtable) do
        for b = 1, Maxb[FB] do
            for i = 1, Maxi[FB] do
                local bt = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                if bt then
                    if GetItemID(link) == GetItemID(bt:GetText()) then
                        BiaoGe[FB]["boss" .. b]["guanzhu" .. i] = nil
                        BG.Frame[FB]["boss" .. b]["guanzhu" .. i]:Hide()
                        yes = true
                    end
                end
            end
        end
    end
    if yes then
        BG.FrameLootMsg:AddMessage(BG.STC_r1(format("已取消关注装备：%s",
            AddTexture(Texture) .. link)))
    end
end

------------------通知框关注装备------------------
function BG.AddGuanZhu(link)
    local name, link, quality, level, _, _, _, _, _, Texture, _, typeID = GetItemInfo(link)
    local yes
    for _, FB in pairs(BG.FBtable) do
        for b = 1, Maxb[FB] do
            for i = 1, Maxi[FB] do
                local bt = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                if bt then
                    if GetItemID(link) == GetItemID(bt:GetText()) then
                        BiaoGe[FB]["boss" .. b]["guanzhu" .. i] = true
                        BG.Frame[FB]["boss" .. b]["guanzhu" .. i]:Show()
                        yes = true
                    end
                end
            end
        end
    end
    if yes then
        BG.FrameLootMsg:AddMessage(BG.STC_g2(format(L["已成功关注装备：%s。团长拍卖此装备时会提醒"],
            AddTexture(Texture) .. link)))
    end
end

------------------金额自动加零------------------
function BG.UpdateTwo0(bt)
    if BiaoGe.options["autoAdd0"] == 1 and bt:HasFocus() and not IsModifierKeyDown() then
        local text = bt:GetText()
        local numtext = tonumber(text)
        local len = strlen(text)
        if numtext then
            if numtext == 0 and len == 2 then
                bt:SetText("")
                return
            end

            if numtext ~= 0 and len == 1 then
                bt:Insert("00")
                bt:SetCursorPosition(1)
            end
        end
    end
end

function BG.auctionLogFrame_InsertLink(text)
    if BG.auctionLogFrame.changeFrame.zhuangbei:HasFocus() then
        BG.auctionLogFrame.changeFrame.zhuangbei:SetText(text:gsub("(|h|r)H", "%1"))
        BG.auctionLogFrame.changeFrame.zhuangbei:ClearFocus()
        return true
    elseif BG.auctionLogFrame.serachEdit:HasFocus() then
        BG.auctionLogFrame.serachEdit:SetText(text:match("%[(.+)%]"))
        return true
    end
end

function BG.InsertLink(text, isZhuangbeiList)
    if BG.auctionLogFrame_InsertLink(text) then
        return
    end
    if AuctionatorShoppingFrame and AuctionatorShoppingFrame:IsVisible() then
        ChatEdit_InsertLink(text)
        return
    elseif AuctionFrameBrowse and AuctionFrameBrowse:IsVisible() then
        ChatEdit_InsertLink(text)
        return
    end
    if not GetCurrentKeyBoardFocus() or isZhuangbeiList then
        ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
    end
    ChatEdit_InsertLink(text)
end

function BG.FindDropdownItem(dropdown, text)
    local name = dropdown:GetName()
    for i = 1, UIDROPDOWNMENU_MAXBUTTONS do
        local dropdownItem = _G[name .. 'Button' .. i]
        if dropdownItem:IsShown() and dropdownItem:GetText() == text then
            return i, dropdownItem
        end
    end
end
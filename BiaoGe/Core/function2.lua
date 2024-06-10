local _, ADDONSELF = ...

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
local FrameHide = ADDONSELF.FrameHide
local AddTexture = ADDONSELF.AddTexture
local GetItemID = ADDONSELF.GetItemID
local BossNum = ADDONSELF.BossNum

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

------------------过滤装备------------------
do
    local alpha1 = 0.4
    local alpha2 = 1

    function BG.Tooltip_SetItemByID(itemID)
        BiaoGeTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        BiaoGeTooltip:ClearLines()
        BiaoGeTooltip:SetItemByID(itemID)
    end

    local function Get_G_key(text)
        for k, v in pairs(BG.FilterClassItemDB.ShuXing) do
            if text == v.name then
                return string.gsub(v.value, "%%s", "(.+)")
            end
        end
        return "!!!!!!!!"
    end
    local function GetTooltipTextLeftAll(itemID, EquipLoc)
        BG.Tooltip_SetItemByID(itemID)
        local tab = {}
        local ii = 1
        while _G["BiaoGeTooltipTextLeft" .. ii] do
            local tx = _G["BiaoGeTooltipTextLeft" .. ii]:GetText()
            if tx and tx ~= "" and (not tx:find(WARDROBE_SETS)) and
                (not tx:find(ITEM_MOD_FERAL_ATTACK_POWER:gsub("%%s", "(.+)"))) then -- 小德的武器词缀：在猎豹、熊等等攻击强度提高%s点
                table.insert(tab, tx)
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
    local function FilterShuXing(TooltipText)
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
        if not num then return end
        for k, _ in pairs(BiaoGe.FilterClassItemDB[RealmId][player][num].ShuXing) do
            local text = Get_G_key(k)
            for _, v in pairs(BG.FilterClassItemDB.ShuXing) do
                if k == v.name and v.nothave then
                    if strfind(TooltipText, text) then
                        for _, vv in pairs(v.nothave) do
                            if strfind(TooltipText, vv) then
                                return false
                            end
                        end
                    end
                end
            end

            if strfind(TooltipText, text) then
                return true
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
        local TooltipText = GetTooltipTextLeftAll(itemID, EquipLoc)
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
        if not BG.IsVanilla() then
            if FilterTANK(TooltipText, typeID, EquipLoc) then
                return true
            end
        end
    end

    function BG.FilterItem(bt)
        local text = bt:GetText()
        local itemID = GetItemInfoInstant(text)
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID

        if itemID and num then
            local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID = GetItemInfo(itemID)
            -- if not quality then return 1 end
            if BG.FilterAll(itemID, typeID, EquipLoc, subclassID) then
                bt:SetAlpha(alpha1)
                return
            end
        end
        bt:SetAlpha(alpha2)
    end

    function BG.UpdateFilter(bt)
        local text = bt:GetText()
        local itemID = GetItemInfoInstant(text)
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
                    BG.FilterItem(bt)
                    BG.itemCaches[itemID] = true
                end)
            else
                BG.FilterItem(bt)
            end
        end)
    end

    function BG.UpdateAllFilter()
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
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
        for k, bt in pairs(BG.ItemLibMainFrame.Hope) do
            if type(bt) == "table" and bt.EquipLoc then
                BG.UpdateFilter(bt)
            end
        end

        BG.FilterClassItemMainFrame.AddFrame:Hide()
    end

    -- 拾取通知
    function BG.LootFilterClassItem(link)
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
        if not num then return "" end

        local icon = AddTexture(BiaoGe.FilterClassItemDB[RealmId][player][num].Icon)
        local itemID = GetItemInfoInstant(link)

        if itemID then
            local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID = GetItemInfo(link)
            if BG.FilterAll(itemID, typeID, EquipLoc, subclassID) then
                return ""
            end
        end
        return icon
    end
end

------------------函数：按职业排序------------------
function BG.PaiXuRaidRosterInfo(guolv)
    local c = {
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
    local c_guolv = {}
    if guolv and type(guolv) == "table" then
        for i, v in ipairs(guolv) do
            for index, value in ipairs(c) do
                if v == value then
                    table.insert(c_guolv, value)
                end
            end
        end
    else
        c_guolv = c
    end

    local re = {}
    if BG.raidRosterInfo and type(BG.raidRosterInfo) == "table" then
        for i, v in ipairs(c_guolv) do
            for index, value in ipairs(BG.raidRosterInfo) do
                if value.class == v then
                    table.insert(re, value)
                end
            end
        end
    end
    return re
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
    local function GetNanDu(bossnum)
        local FB = BG.FB1
        if BG.IsWLKFB() then
            if FB == "TOC" and bossnum == 7 then
                local nandutable = {
                    TOC = {
                        [3] = "N10",
                        [175] = "N10",
                        [4] = "N25",
                        [176] = "N25",
                        [5] = "N10",
                        [193] = "N10",
                        [6] = "N25",
                        [194] = "N25",
                    },
                }
                return nandutable[FB][GetRaidDifficultyID()]
            else
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
                    ULD = {
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
                    ICC = {
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
                return nandutable[FB][GetRaidDifficultyID()]
            end
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
            text:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
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
        text:SetFont(BIAOGE_TEXT_FONT, 14, "OUTLINE")
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
                            ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                            ChatEdit_InsertLink(self.link)
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
        f.text:SetFont(BIAOGE_TEXT_FONT, 11, "OUTLINE")
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
    f.text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
    f.text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
    f:Hide()
    f.text = f:CreateFontString()
    f.text:SetPoint("CENTER")
    f.text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
function BG.SetListmaijia(maijia, focus, guolv)
    -- 背景框
    local frame = BG.MainFrame
    BG.FrameMaijiaList = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    BG.FrameMaijiaList:SetWidth(395)
    BG.FrameMaijiaList:SetHeight(230)
    BG.FrameMaijiaList:SetFrameLevel(120)
    BG.FrameMaijiaList:SetBackdrop({
        bgFile = "Interface/ChatFrame/ChatFrameBackground",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    BG.FrameMaijiaList:SetBackdropColor(0, 0, 0, 0.8)
    BG.FrameMaijiaList:SetPoint("TOPLEFT", maijia, "BOTTOMLEFT", -9, 2)
    BG.FrameMaijiaList:EnableMouse(true)
    BG.FrameMaijiaList:SetClampedToScreen(true)

    -- 下拉列表
    local framedown
    local frameright = BG.FrameMaijiaList
    local raid = BG.PaiXuRaidRosterInfo(guolv)
    for t = 1, 4 do
        for i = 1, 10 do
            local button = CreateFrame("EditBox", nil, BG.FrameMaijiaList, "InputBoxTemplate")
            button:SetSize(90, 20)
            button:SetFrameLevel(125)
            button:SetAutoFocus(false)
            if t >= 2 and i == 1 then
                button:SetPoint("TOPLEFT", frameright, "TOPLEFT", 97, 0)
                frameright = button
            end
            if t == 1 and i == 1 then
                button:SetPoint("TOPLEFT", frameright, "TOPLEFT", 10, -5)
                frameright = button
            end
            if i > 1 then
                button:SetPoint("TOPLEFT", framedown, "BOTTOMLEFT", 0, -2)
            end
            if not guolv and not IsInRaid(1) and t == 1 and i == 1 then -- 单人时
                button:SetText(UnitName("player"))
                button:SetCursorPosition(0)
                button:SetTextColor(GetClassRGB(UnitName("player")))
            end
            local num = (t - 1) * 10 + i
            if raid[num] then
                if raid[num].name then
                    if raid[num].role then
                        button:SetText(AddTexture(raid[num].role) .. raid[num].name)
                    elseif raid[num].combatRole == "HEALER" then
                        button:SetText(AddTexture(raid[num].combatRole) .. raid[num].name)
                    else
                        button:SetText(raid[num].name)
                    end
                    button:SetCursorPosition(0)
                    button:SetTextColor(GetClassRGB(GetText_T(raid[num].name)))
                end
            end
            framedown = button

            button.ds = button:CreateTexture()
            button.ds:SetPoint("TOPLEFT", -4, -2)
            button.ds:SetPoint("BOTTOMRIGHT", 0, 0)
            button.ds:SetColorTexture(1, 1, 1, BG.onEnterAlpha)
            button.ds:Hide()

            button:SetScript("OnMouseDown", function(self, enter)
                maijia:SetTextColor(button:GetTextColor())
                maijia:SetText(GetText_T(button))
                maijia:SetCursorPosition(0)
                BG.FrameMaijiaList:Hide()
                if focus == 0 then
                    if BG.lastfocus then
                        BG.lastfocus:ClearFocus()
                    end
                end
            end)
            button:SetScript("OnEnter", function(self)
                self.ds:Show()
            end)
            button:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                self.ds:Hide()
            end)
        end
    end
end

------------------创建：金额下拉列表------------------
function BG.SetListjine(jine, FB, b, i)
    -- 背景框
    BG.FrameJineList = CreateFrame("Frame", nil, BG.MainFrame, "BackdropTemplate")
    BG.FrameJineList:SetWidth(95)
    BG.FrameJineList:SetHeight(230)
    BG.FrameJineList:SetFrameLevel(120)
    BG.FrameJineList:SetBackdrop({
        bgFile = "Interface/ChatFrame/ChatFrameBackground",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    BG.FrameJineList:SetBackdropColor(0, 0, 0, 0.8)
    BG.FrameJineList:SetPoint("TOPLEFT", jine, "BOTTOMLEFT", -9, 2)
    BG.FrameJineList:EnableMouse(true)
    BG.FrameJineList:SetClampedToScreen(true)

    local text = BG.FrameJineList:CreateFontString()
    text:SetPoint("TOP", BG.FrameJineList, "TOP", 0, -10)
    text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
    text:SetText(L["欠款金额"])
    text:SetTextColor(1, 0, 0)

    local edit = CreateFrame("EditBox", nil, BG.FrameJineList, "InputBoxTemplate")
    edit:SetSize(80, 20)
    edit:SetTextColor(1, 0, 0)
    edit:SetPoint("TOP", text, "BOTTOM", 2, -5)
    if BiaoGe[FB]["boss" .. b]["qiankuan" .. i] then
        edit:SetText(BiaoGe[FB]["boss" .. b]["qiankuan" .. i])
    end
    edit:SetNumeric(true)
    edit:SetAutoFocus(false)
    BG.FrameQianKuanEdit = edit
    edit:SetScript("OnTextChanged", function(self)
        local name = "autoAdd0"
        if BiaoGe.options[name] == 1 then
            local len = strlen(self:GetText())
            local lingling
            if len then
                lingling = strsub(self:GetText(), len - 1, len)
            end
            if lingling ~= "00" and lingling ~= "0" and tonumber(self:GetText()) and self:HasFocus() then
                self:Insert("00")
                self:SetCursorPosition(1)
            end
        end
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
    -- 点击时
    edit:SetScript("OnMouseDown", function(self, enter)
        if enter == "RightButton" then -- 右键清空格子
            self:SetEnabled(false)
            self:SetText("")
        end
    end)
    edit:SetScript("OnMouseUp", function(self, enter)
        if enter == "RightButton" then -- 右键清空格子
            self:SetEnabled(true)
        end
    end)
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
ADDONSELF.FrameDongHua = FrameDongHua

------------------函数：清空表格------------------
function BG.QingKong(_type, FB)
    if BG.DeBug and not FB then
        FB = BG.FB1
    end
    if not FB then return end
    if _type == "biaoge" then
        for b = 1, Maxb[FB] do
            for i = 1, Maxi[FB] + 10 do
                -- 表格
                if BG.Frame[FB]["boss" .. b]["zhuangbei" .. i] then
                    BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]:SetText("")
                    BG.Frame[FB]["boss" .. b]["maijia" .. i]:SetText("")
                    BG.Frame[FB]["boss" .. b]["jine" .. i]:SetText("")
                    BG.Frame[FB]["boss" .. b]["qiankuan" .. i]:Hide()
                    BG.Frame[FB]["boss" .. b]["guanzhu" .. i]:Hide()
                end
                BiaoGe[FB]["boss" .. b]["zhuangbei" .. i] = nil
                BiaoGe[FB]["boss" .. b]["maijia" .. i] = nil
                BiaoGe[FB]["boss" .. b]["jine" .. i] = nil
                BiaoGe[FB]["boss" .. b]["qiankuan" .. i] = nil
                BiaoGe[FB]["boss" .. b]["guanzhu" .. i] = nil

                -- 对账
                if BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i] then
                    BG.DuiZhangFrame[FB]["boss" .. b]["zhuangbei" .. i]:SetText("")
                    BG.DuiZhangFrame[FB]["boss" .. b]["myjine" .. i]:SetText("")
                end
            end
            if BG.Frame[FB]["boss" .. b]["time"] then
                BG.Frame[FB]["boss" .. b]["time"]:SetText("")
                BiaoGe[FB]["boss" .. b]["time"] = nil
            end
        end
        for i = 1, Maxi[FB] + 10 do -- 清空支出
            if BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i] then
                if BiaoGe.options["retainExpenses"] ~= 1 then
                    BG.Frame[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i]:SetText("")
                end
                BG.Frame[FB]["boss" .. Maxb[FB] + 1]["maijia" .. i]:SetText("")
                BG.Frame[FB]["boss" .. Maxb[FB] + 1]["jine" .. i]:SetText("")
            end
            if BiaoGe.options["retainExpenses"] ~= 1 then
                BiaoGe[FB]["boss" .. Maxb[FB] + 1]["zhuangbei" .. i] = nil
            end
            BiaoGe[FB]["boss" .. Maxb[FB] + 1]["maijia" .. i] = nil
            BiaoGe[FB]["boss" .. Maxb[FB] + 1]["jine" .. i] = nil
        end

        if BiaoGe[FB]["ChengPian"] then
            BiaoGe[FB]["ChengPian"] = nil
        end
        if BiaoGe[FB]["BaoZhu"] then
            BiaoGe[FB]["BaoZhu"] = nil
        end

        local num -- 分钱人数
        if BG.IsVanilla() then
            num = BG.GetFBinfo(FB, "maxplayers") or 10
        else
            num = 25
            local nanduID = GetRaidDifficultyID()
            if nanduID == 3 or nanduID == 175 then
                num = BiaoGe.options["10MaxPlayers"] or 10
            elseif nanduID == 4 or nanduID == 176 then
                num = BiaoGe.options["25MaxPlayers"] or 25
            elseif nanduID == 5 or nanduID == 193 then
                num = BiaoGe.options["10MaxPlayers"] or 10
            elseif nanduID == 6 or nanduID == 194 then
                num = BiaoGe.options["25MaxPlayers"] or 25
            end
        end
        if BiaoGe.options["autoQingKong"] == 1 then
            BG.Frame[FB]["boss" .. Maxb[FB] + 2]["jine4"]:SetText(num)
            BiaoGe[FB]["boss" .. Maxb[FB] + 2]["jine4"] = num
        end
        return num
    elseif _type == "hope" then
        for n = 1, 4 do
            for b = 1, Maxb[FB] - 1 do
                for i = 1, HopeMaxi do
                    if BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i] then
                        BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]:SetText("")
                        BiaoGe.Hope[RealmId][player][FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i] = nil
                    end
                end
            end
        end
        BG.UpdateItemLib_LeftHope_HideAll()
        BG.UpdateItemLib_RightHope_HideAll()
    end
end

------------------获取玩家所在的团队框体位置（例如5-2）------------------
function BG.GetRaidWeiZhi()
    local team = {}
    local num = GetNumGroupMembers()
    if not num then return end
    for i = 1, num do
        local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(i)
        name = strsplit("-", name)
        if not team[subgroup] then
            team[subgroup] = {}
        end
        table.insert(team[subgroup], name)
    end

    local weizhi = {}
    for i, v in pairs(team) do
        if type(team[i]) == "table" then
            for ii, vv in ipairs(team[i]) do
                weizhi[vv] = i .. "-" .. ii
            end
        end
    end
    return weizhi
end

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

            zhuangbei = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i]:GetText(),
            maijia = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i]:GetText(),
            color = { BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i]:GetTextColor() },
            jine = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i]:GetText(),
            qiankuan = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["qiankuan" .. i],
            guanzhu = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i],
        }
        PlaySound(BG.sound1, "Master")

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
            PlaySound(BG.sound1, "Master")
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

            zhuangbei = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["zhuangbei" .. i]:GetText(),
            maijia = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i]:GetText(),
            color = { BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["maijia" .. i]:GetTextColor() },
            jine = BG.Frame[FB]["boss" .. BossNum(FB, b, t)]["jine" .. i]:GetText(),
            qiankuan = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["qiankuan" .. i],
            guanzhu = BiaoGe[FB]["boss" .. BossNum(FB, b, t)]["guanzhu" .. i],
        }

        if BG.copy1.fb == BG.copy2.fb then -- 是同一个副本
            BG.copy1.btzhuangbei:SetText(BG.copy2.zhuangbei)
            BG.copy1.btmaijia:SetText(BG.copy2.maijia)
            BG.copy1.btmaijia:SetTextColor(BG.copy2.color[1], BG.copy2.color[2], BG.copy2.color[3])
            BG.copy1.btjine:SetText(BG.copy2.jine)

            BG.copy2.btzhuangbei:SetText(BG.copy1.zhuangbei)
            BG.copy2.btmaijia:SetText(BG.copy1.maijia)
            BG.copy2.btmaijia:SetTextColor(BG.copy1.color[1], BG.copy1.color[2], BG.copy1.color[3])
            BG.copy2.btjine:SetText(BG.copy1.jine)


            local FB = BG.copy1.fb
            local b1, i1 = BG.copy1.b, BG.copy1.i
            local b2, i2 = BG.copy2.b, BG.copy2.i

            BiaoGe[FB]["boss" .. b1]["guanzhu" .. i1], BiaoGe[FB]["boss" .. b2]["guanzhu" .. i2] = BiaoGe[FB]["boss" .. b2]["guanzhu" .. i2], BiaoGe[FB]["boss" .. b1]["guanzhu" .. i1]
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

            BiaoGe[FB]["boss" .. b1]["qiankuan" .. i1], BiaoGe[FB]["boss" .. b2]["qiankuan" .. i2] = BiaoGe[FB]["boss" .. b2]["qiankuan" .. i2], BiaoGe[FB]["boss" .. b1]["qiankuan" .. i1]
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
            text:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
            PlaySound(BG.sound1, "Master")

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
                PlaySound(BG.sound1, "Master")
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

        PlaySound(BG.sound1, "Master")
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
    local function SetHighlightBag(bag)
        local f = CreateFrame("Frame", nil, bag, "BackdropTemplate")
        f:SetBackdrop({
            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeSize = 3,
        })
        f:SetBackdropBorderColor(1, 0, 0, 1)
        f:SetPoint("TOPLEFT", bag, 0, 0)
        f:SetPoint("BOTTOMRIGHT", bag, 0, 0)
        f:SetFrameLevel(bag:GetFrameLevel() + 10)
        tinsert(BG.LastBagItemFrame, f)
    end

    function BG.HighlightBag(biaogelink)
        if BiaoGe.options["HighOnterItem"] ~= 1 then return end
        if not GetItemID(biaogelink) then return end
        if _G["NDui_BackpackSlot1"] then
            local i = 1
            while _G["NDui_BackpackSlot" .. i] do
                local bag = _G["NDui_BackpackSlot" .. i]
                local link = C_Container.GetContainerItemLink(bag.bagId, bag.slotId)
                if link and GetItemID(link) == GetItemID(biaogelink) then
                    SetHighlightBag(bag)
                end
                i = i + 1
            end
        elseif _G["ElvUI_ContainerFrame"] then
            local b = -1
            local i = 1
            while _G["ElvUI_ContainerFrameBag" .. b .. "Slot" .. i] do
                while _G["ElvUI_ContainerFrameBag" .. b .. "Slot" .. i] do
                    local bag = _G["ElvUI_ContainerFrameBag" .. b .. "Slot" .. i]
                    local link = C_Container.GetContainerItemLink(bag.BagID, bag.SlotID)
                    if link and GetItemID(link) == GetItemID(biaogelink) then
                        SetHighlightBag(bag)
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
                local link = C_Container.GetContainerItemLink(bag:GetParent():GetID(), bag:GetID())
                if link and GetItemID(link) == GetItemID(biaogelink) then
                    SetHighlightBag(bag)
                end
                i = i + 1
            end
        else
            local b = 1
            local i = 1
            while _G["ContainerFrame" .. b .. "Item" .. i] do
                while _G["ContainerFrame" .. b .. "Item" .. i] do
                    local bag = _G["ContainerFrame" .. b .. "Item" .. i]
                    local link = C_Container.GetContainerItemLink(bag:GetParent():GetID(), bag:GetID())
                    if link and GetItemID(link) == GetItemID(biaogelink) then
                        SetHighlightBag(bag)
                    end
                    i = i + 1
                end
                b = b + 1
                i = 1
            end
        end
    end

    function BG.HilightBiaoGeSaveItems(link)
        if BiaoGe.options["HighOnterItem"] ~= 1 then return end
        if not GetItemID(link) then return end
        if not BG.FBMainFrame:IsVisible() then return end
        local FB = BG.FB1
        for b = 1, Maxb[FB], 1 do
            for i = 1, Maxi[FB], 1 do
                local zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                local jine = BG.Frame[FB]["boss" .. b]["jine" .. i]
                if zb then
                    if GetItemID(link) == GetItemID(zb:GetText()) then
                        local f = CreateFrame("Frame", nil, zb, "BackdropTemplate")
                        f:SetBackdrop({
                            edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                            edgeSize = 2,
                        })
                        f:SetBackdropBorderColor(1, 0, 0, 1)
                        f:SetPoint("TOPLEFT", zb, "TOPLEFT", -4, -2)
                        f:SetPoint("BOTTOMRIGHT", jine, "BOTTOMRIGHT", -2, 0)
                        f:SetFrameLevel(zb:GetFrameLevel() + 3)
                        tinsert(BG.LastBagItemFrame, f)
                    end
                end
            end
        end
    end

    function BG.Hide_AllHiLight()
        for key, value in pairs(BG.LastBagItemFrame) do
            value:Hide()
        end
        wipe(BG.LastBagItemFrame)
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
    bt:SetSize(120, 30)
    bt:SetPoint("BOTTOMRIGHT", BG.MainFrame, "BOTTOMRIGHT", -30, 35)
    bt:SetText(L["返回表格"])
    bt:SetScript("OnClick", function(self)
        BG.ClickTabButton(BG.tabButtons, BG.FBMainFrameTabNum)
        BG.Backing = true
        C_Timer.After(1, function()
            BG.Backing = nil
        end)
        BG.PlaySound(1)
    end)
end

------------------跳转装备库相同部位------------------
local function CheckItemEquipLoc(link)
    local itemID = GetItemInfoInstant(link)
    for _, FB in pairs(BG.phaseFBtable[BG.FB1]) do
        if BG.Loot[FB].ExchangeItems[itemID] then
            local firstItem = BG.Loot[FB].ExchangeItems[itemID][1]
            if firstItem then
                local name, link, quality, level, _, _, _, _, itemEquipLoc = GetItemInfo(firstItem)
                if itemEquipLoc then
                    for i, _ in ipairs(BG.invtypetable) do
                        for _, v in ipairs(BG.invtypetable[i].key) do
                            if itemEquipLoc == v then
                                return BG.invtypetable[i].name2
                            end
                        end
                    end
                end
            end
        end
    end
    local name, link, quality, level, _, _, _, _, itemEquipLoc = GetItemInfo(link)
    if itemEquipLoc then
        for i, _ in ipairs(BG.invtypetable) do
            for _, v in ipairs(BG.invtypetable[i].key) do
                if itemEquipLoc == v then
                    return BG.invtypetable[i].name2
                end
            end
        end
    end
end
function BG.GoToItemLib(button)
    local link = button:GetText()
    local itemEquipLoc = CheckItemEquipLoc(link)
    if itemEquipLoc then
        for i, bt in ipairs(BG.itemLib_Inv_Buttons) do
            if bt.inv == itemEquipLoc then
                BG.InvOnClick(bt)
                BG.ClickTabButton(BG.tabButtons, BG.ItemLibMainFrameTabNum)
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
function BG.CreateScrollFrame(parent, w, h)
    local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    f:SetBackdrop({
        bgFile = "Interface/ChatFrame/ChatFrameBackground",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    f:SetBackdropColor(0, 0, 0, 0.8)
    f:SetSize(w, h)
    f:EnableMouse(true)
    f:Show()

    local s = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate") -- 滚动
    s:SetWidth(f:GetWidth() - 31)
    s:SetHeight(f:GetHeight() - 9)
    s:SetPoint("TOPLEFT", f, "TOPLEFT", 5, -5)
    s.ScrollBar.scrollStep = BG.scrollStep

    local child = CreateFrame("Frame", nil, f) -- 子框架
    child:SetWidth(s:GetWidth())
    child:SetHeight(s:GetHeight())
    s:SetScrollChild(child)

    return f, child
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

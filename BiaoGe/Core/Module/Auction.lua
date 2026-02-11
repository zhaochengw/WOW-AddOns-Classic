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
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded

BG.Init(function()
    BiaoGe.Auction = BiaoGe.Auction or {}
    if BG.IsVanilla then
        BiaoGe.Auction.money = BiaoGe.Auction.money or 1
        BiaoGe.Auction.fastMoney = BiaoGe.Auction.fastMoney or { 100, 300, 500, 1000, 2000 }
    elseif BG.IsTitan then
        BG.Once("fastMoney", 251201, function()
            BiaoGe.Auction.money = nil
            BiaoGe.Auction.fastMoney = nil
        end)
        BiaoGe.Auction.money = BiaoGe.Auction.money or 1000
        BiaoGe.Auction.fastMoney = BiaoGe.Auction.fastMoney or { 300, 500, 1000, 2000, 3000 }
    elseif BG.IsWLK then
        BiaoGe.Auction.money = BiaoGe.Auction.money or 1000
        BiaoGe.Auction.fastMoney = BiaoGe.Auction.fastMoney or { 1000, 2000, 3000, 5000, 10000 }
    else
        BG.Once("fastMoney", 260110, function()
            BiaoGe.Auction.money = nil
            BiaoGe.Auction.fastMoney = nil
        end)
        BiaoGe.Auction.money = BiaoGe.Auction.money or 10000
        BiaoGe.Auction.fastMoney = BiaoGe.Auction.fastMoney or { 10000, 20000, 30000, 50000, 100000 }
    end

    local sending = {}
    local sendDone = {}
    local sendingCount = {}
    local notShowSendingText = {}

    local function UpdateGuildFrame(frame)
        if IsInRaid(1) then
            frame:SetWidth(1)
            frame:Hide()
        elseif IsInGuild() then
            local numTotal, numOnline, numOnlineAndMobile = GetNumGuildMembers()
            frame.text:SetFormattedText(frame.title2, (Size(frame.table) .. "/" .. numOnline))
            frame:SetWidth(frame.text:GetWidth() + 10)
            frame:Show()
        end
    end

    local function UpdateAddonFrame(frame)
        if IsInRaid(1) then
            local count = 0
            for name in pairs(frame.table) do
                name = BG.GSN(name)
                if BG.raidRosterName[name] then
                    count = count + 1
                end
            end
            frame.text:SetFormattedText(frame.title2, (count .. "/" .. GetNumGroupMembers()))
            frame:SetWidth(frame.text:GetWidth() + 10)
            frame:Show()
        else
            wipe(frame.table)
            frame:Hide()
        end
    end
    local function Guild_OnEnter(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self.title, 0, 1, 0)
        GameTooltip:AddLine(" ")
        local ii = 0
        for i = 1, GetNumGuildMembers() do
            local name, rankName, rankIndex, level, classDisplayName, zone,
            publicNote, officerNote, isOnline, status, class, achievementPoints,
            achievementRank, isMobile, canSoR, repStanding, guid = GetGuildRosterInfo(i)
            if isOnline then
                name = BG.GSN(name)
                if ii > 40 then
                    GameTooltip:AddLine("......")
                    break
                end
                ii = ii + 1
                local line = 2
                local Ver = self.table[name] or L["无"]
                local r, g, b = GetClassColor(class)
                GameTooltip:AddDoubleLine(BG.GSN(name), Ver, r, g, b, 1, 1, 1)
                if Ver == L["无"] then
                    local alpha = 0.3
                    if _G["GameTooltipTextLeft" .. (ii + line)] then
                        _G["GameTooltipTextLeft" .. (ii + line)]:SetAlpha(alpha)
                    end
                    if _G["GameTooltipTextRight" .. (ii + line)] then
                        _G["GameTooltipTextRight" .. (ii + line)]:SetAlpha(alpha)
                    end
                end
            end
        end
        GameTooltip:Show()
    end

    local function Addon_OnEnter(self)
        self.isOnEnter = true

        local line = 2
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self.title, 0, 1, 0)
        if self.isAuciton then
            GameTooltip:AddLine(L["需全团安装拍卖WA，没安装的人将会看不到拍卖窗口。"], 0.5, 0.5, 0.5, true)
            local text = ""
            if not WeakAurasOptions then
                text = BG.STC_r1(L["（WA面板尚未初始化）"])
            elseif BG.ButtonRaidAuction.loadProgressNum and BG.ButtonRaidAuction.total then
                text = BG.STC_y1(format(L["（WA面板正在初始化：%s/%s）"],
                    BG.ButtonRaidAuction.loadProgressNum, BG.ButtonRaidAuction.total))
            else
                text = BG.STC_g1(L["（WA面板已初始化，可以发送了）"])
            end
            GameTooltip:AddLine(L["SHIFT+点击：把WA字符串通过密语发送给没有的团员。"] .. text, 1, 1, 1, true)
            line = line + 2
        end
        GameTooltip:AddLine(" ")
        local raid = BG.SortRaidRosterInfo()
        for i, v in ipairs(raid) do
            local name = v.name
            local Ver = self.table[name]
            if not Ver then
                if v.online then
                    Ver = L["无"]
                else
                    Ver = L["未知"]
                end
                if self.isAuciton then
                    if sendDone[name] then
                        Ver = L["接收完毕，但未导入"]
                    elseif sending[name] then
                        Ver = L["正在接收拍卖WA"]
                    end
                end
            end
            local vip = self.table2[name] and AddTexture("VIP") or ""
            local role = ""
            local y
            if v.rank == 2 then
                role = role .. AddTexture("interface/groupframe/ui-group-leadericon", y)
            elseif v.rank == 1 then
                role = role .. AddTexture("interface/groupframe/ui-group-assistanticon", y)
            end
            if v.isML then
                role = role .. AddTexture("interface/groupframe/ui-group-masterlooter", y)
            end
            local c1, c2, c3 = GetClassRGB(name)
            GameTooltip:AddDoubleLine(name .. role .. vip, Ver, c1, c2, c3, 1, 1, 1)
            if Ver == L["无"] or Ver == L["未知"] then
                local alpha = 0.4
                if _G["GameTooltipTextLeft" .. (i + line)] then
                    _G["GameTooltipTextLeft" .. (i + line)]:SetAlpha(alpha)
                end
                if _G["GameTooltipTextRight" .. (i + line)] then
                    _G["GameTooltipTextRight" .. (i + line)]:SetAlpha(alpha)
                end
            end
        end
        GameTooltip:Show()
    end

    local function UpdateOnEnter(self)
        if self and self.isOnEnter then
            self:GetScript("OnEnter")(self)
        end
    end

    local cd
    local function CanSend()
        if IsAddOnLoaded("WeakAuras") then
            if not IsAddOnLoaded("WeakAurasOptions") then
                if not LoadAddOn("WeakAurasOptions") then
                    BG.SendSystemMessage(L["你没有启用WeakAurasOptions插件。"])
                    return
                end
            end
            return true
        else
            BG.SendSystemMessage(L["你没有安装WeakAuras插件。"])
        end
    end
    local function StartSend()
        if cd then return end
        for i = 1, 10 do
            local header = _G["WeakAurasLoadedHeaderButton" .. i]
            if header then
                local titleString = _G[header:GetName() .. "Text"]:GetText()
                if titleString:match("/") then
                    -- if titleString:match("Loaded/Standby") or titleString:match("已载入") then
                    local tbl = { header:GetParent():GetChildren() }
                    for i, bt in ipairs(tbl) do
                        if bt.id and WeakAuras.IsAuraLoaded(bt.id) then
                            local ver = bt.id:match("<BiaoGe>拍卖%s-v(%d+%.%d+)")
                            if ver then
                                if IsShiftKeyDown() then
                                    cd = true
                                    BG.After(2, function() cd = nil end)
                                    BG.PlaySound(2)
                                    local edit = ChatEdit_ChooseBoxForSend()
                                    edit:SetText("")
                                    ChatEdit_ActivateChat(edit)
                                    bt:Click()
                                    BG.ButtonRaidAuction.WACode = edit:GetText()
                                    edit:SetText("")
                                    edit:Hide()
                                    GameTooltip:Hide()
                                    if BG.ButtonRaidAuction.isOnEnter then
                                        BG.ButtonRaidAuction:GetScript("OnEnter")(BG.ButtonRaidAuction)
                                    end
                                    if BG.ButtonRaidAuction.WACode ~= "" then
                                        for _, v in ipairs(BG.raidRosterInfo) do
                                            if not BG.raidAuctionVersion[v.name] and v.online then
                                                SendChatMessage(BG.ButtonRaidAuction.WACode, "WHISPER", nil, v.name)
                                            end
                                        end
                                    end
                                else
                                    BG.SendSystemMessage(L["需要按下SHIFT才能发送WA。"])
                                end
                                return
                            end
                        end
                    end
                    break
                end
            end
        end
        BG.SendSystemMessage(L["在你的WA面板里未找到拍卖WA字符串，你需要先从表格左上角的\"拍卖WA\"按钮导入该字符串。"])
    end
    local function SendWACode()
        if not CanSend() then return end
        if not IsShiftKeyDown() then return end
        if not WeakAurasOptions then
            WeakAuras.OpenOptions()
            WeakAurasOptions:Hide()
            BG.ButtonRaidAuction.total = 0
            for _, _ in pairs(WeakAurasSaved.displays) do
                BG.ButtonRaidAuction.total = BG.ButtonRaidAuction.total + 1
            end
            BG.OnUpdateTime(function(self)
                BG.ButtonRaidAuction.loadProgressNum = WeakAurasOptions.loadProgressNum
                if BG.ButtonRaidAuction.isOnEnter then
                    BG.ButtonRaidAuction:GetScript("OnEnter")(BG.ButtonRaidAuction)
                end
                if not WeakAurasOptions.loadProgress:IsShown() then
                    self:SetScript("OnUpdate", nil)
                    self:Hide()
                    BG.ButtonRaidAuction.total = nil
                    BG.ButtonRaidAuction.loadProgressNum = nil
                    if BG.ButtonRaidAuction.isOnEnter then
                        BG.ButtonRaidAuction:GetScript("OnEnter")(BG.ButtonRaidAuction)
                    end
                    BG.After(0, function()
                        StartSend()
                    end)
                end
            end)
        else
            StartSend()
        end
    end

    -- 团长开始拍卖UI
    do
        BiaoGe.Auction.duration = BiaoGe.Auction.duration or 40
        BiaoGe.Auction.mod = BiaoGe.Auction.mod or "normal"
        BiaoGe.Auction.aotoSendLate = BiaoGe.Auction.aotoSendLate or 3

        local mods = {
            normal = L["金团竞价"],
            roll = L["Roll点"],
        }
        if not mods[BiaoGe.Auction.mod] then
            BiaoGe.Auction.mod = "normal"
        end
        local mainFrameWidth = 250
        local mainFrameHeight = 145
        local mainFrameHeight_roll = 100

        local function ClearAllFocus(f)
            f.Edit1:ClearFocus()
            f.Edit2:ClearFocus()
            LibBG:CloseDropDownMenus()
        end
        local function item_OnEnter(self)
            if BG.ButtonIsInRight(self) then
                GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
            else
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
            end
            GameTooltip:ClearLines()
            GameTooltip:SetHyperlink(self.link)
            self.isOnEnter = true
            if self.isIcon then
                self.owner.lastIcon = self
                if not self.isChooseTex then
                    self.isChooseTex = self:CreateTexture()
                    self.isChooseTex:SetAllPoints()
                    self.isChooseTex:SetColorTexture(1, 1, 1, .2)
                    self.isChooseTex:Hide()
                end
                self.isChooseTex:Show()
            end
        end
        local function item_OnLeave(self)
            GameTooltip_Hide()
            self.isOnEnter = nil
            if self.isIcon then
                self.owner.lastIcon = nil
                self.isChooseTex:Hide()
            end
        end
        local function Start_OnClick(self)
            if not self.noSound then
                BG.PlaySound(1)
            end
            local mod = BiaoGe.Auction.mod
            if mod == "roll" then
                if #self.items > 1 then
                    return
                end
                SendChatMessage(format(L["{rt1}Roll点开始{rt1} %s"], self.items[1].link), "RAID_WARNING")
            else
                local money = self.money or tonumber(BiaoGe.Auction.money)
                local _duration = tonumber(BiaoGe.Auction.duration)
                local duration = _duration and _duration > 0 and _duration
                if not (money and duration) then return end
                local t = 0
                for i, v in ipairs(self.items) do
                    local itemID = v.id
                    local link = v.link
                    BG.After(t, function()
                        local text = "StartAuction," .. GetTime() .. "," .. itemID .. "," ..
                            money .. "," .. duration .. ",," .. mod .. "," .. link
                        C_ChatInfo.SendAddonMessage("BiaoGeAuction", text, "RAID")
                    end)
                    t = t + 0.8
                end
            end
            self:GetParent():Hide()
        end
        local function Start_OnEnter(self)
            if BiaoGe.Auction.mod == "roll" and #self.items > 1 then
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                GameTooltip:ClearLines()
                GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
                GameTooltip:AddLine(L["不能同时发起多件装备Roll点。"], 1, 0, 0, true)
                GameTooltip:Show()
            end
        end
        local function OnTextChanged(self)
            BiaoGe.Auction[self._type] = self:GetText()
        end
        local function OnEnterPressed(self)
            if self.num == 1 then
                self:GetParent().Edit2:SetFocus()
            else
                Start_OnClick(self:GetParent().bt)
            end
        end
        local function Edit_OnEnter(self)
            if BG.ButtonIsInRight(self) then
                GameTooltip:SetOwner(self, "ANCHOR_LEFT", 0, 0)
            else
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
            end
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(L["最后20秒有人出价时，拍卖时间会重置到20秒"], 1, 0.82, 0, true)
            GameTooltip:Show()
        end
        local matchStr = ITEM_CLASSES_ALLOWED:gsub("%%s", "")
        function BG.GetTooltipClassText(itemID)
            BG.Tooltip_SetItemByID(itemID)
            for i = 1, BiaoGeTooltip:NumLines() do
                local str = _G["BiaoGeTooltipTextLeft" .. i]:GetText()
                if str then
                    local classStr = str:match(matchStr .. "(.+)")
                    if classStr then
                        local colorCls = ""
                        for _, className in ipairs({ strsplit(",", classStr) }) do
                            className = className:gsub("^%s+", "")
                            colorCls = colorCls .. (BG.classColorNames[className] or className) .. "  "
                        end
                        return colorCls
                    end
                end
            end
            return ""
        end

        local function UpdateFrame()
            local mainFrame = BG.StartAucitonFrame
            mainFrame.Text3:ClearAllPoints()
            mainFrame.bt:ClearAllPoints()
            if BiaoGe.Auction.mod == "roll" then
                mainFrame.Text1:Hide()
                mainFrame.Edit1:Hide()
                mainFrame.Text2:Hide()
                mainFrame.Edit2:Hide()
                if mainFrame.fastMoneyFrame then
                    mainFrame.fastMoneyFrame:Hide()
                end
                mainFrame.Text3:SetPoint("TOPLEFT", mainFrame.itemFrame, "BOTTOMLEFT", 8, -2)
                mainFrame.bt:SetPoint("LEFT", mainFrame.dropDown, "RIGHT", 0, 4)
                mainFrame.bt:SetText(L["开始Roll点"])
                mainFrame:SetHeight(mainFrameHeight_roll)
            else
                mainFrame.Text1:Show()
                mainFrame.Edit1:Show()
                mainFrame.Text2:Show()
                mainFrame.Edit2:Show()
                if mainFrame.fastMoneyFrame then
                    mainFrame.fastMoneyFrame:Show()
                end
                mainFrame.Text3:SetPoint("LEFT", mainFrame.Text1, "RIGHT", 25, 0)
                mainFrame.bt:SetPoint("TOPLEFT", mainFrame.Text3, "BOTTOMLEFT", -1, -35)
                mainFrame.bt:SetText(L["开始拍卖"])
                mainFrame:SetHeight(mainFrameHeight)
            end
        end

        function BG.StartAuction(link, bt, isNotAuctioned, notAlt, isRightButton, noSound)
            if BiaoGe.options["autoAuctionStart"] ~= 1 and not notAlt then return end
            if not link then return end
            if not BG.IsML then return end
            local link = BG.Copy(link)
            local items = {}
            if type(link) == "table" then
                items = link
            else
                items[1] = { id = GetItemID(link), link = link }
            end
            if BG.StartAucitonFrame then BG.StartAucitonFrame:Hide() end
            GameTooltip:Hide()
            local name, link, quality, level, _, itemType, itemSubType, _, itemEquipLoc, Texture,
            _, classID, subclassID, bindType = GetItemInfo(items[1].link)

            local mainFrame
            local f = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
            do
                f:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = 2,
                })
                f:SetBackdropColor(0.3, 0.3, 0.3, 0.8)
                f:SetBackdropBorderColor(0, 0, 0, 1)
                f:SetSize(mainFrameWidth, mainFrameHeight)
                if bt then
                    if isNotAuctioned then
                        f:SetPoint("TOP", bt, "BOTTOM", 10, 0)
                    else
                        f:SetPoint("BOTTOM", bt, "TOP", 0, 0)
                    end
                else
                    local x, y = GetCursorPosition()
                    x, y = x / UIParent:GetEffectiveScale(), y / UIParent:GetEffectiveScale()
                    f:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", x + 10, y + 10)
                end
                f:SetFrameStrata("DIALOG")
                f:SetFrameLevel(300)
                f:SetClampedToScreen(true)
                f:SetToplevel(true)
                f:EnableMouse(true)
                f:SetMovable(true)
                f:SetScript("OnMouseUp", function(self)
                    f:StopMovingOrSizing()
                    f:SetScript("OnUpdate", nil)
                end)
                f:SetScript("OnMouseDown", function(self)
                    f:StartMoving()
                    ClearAllFocus(f)

                    f.time = 0
                    f:SetScript("OnUpdate", function(self, time)
                        f.time = f.time + time
                        if f.time >= 0.2 then
                            f.time = 0
                            if f.itemFrame.isOnEnter then
                                GameTooltip:Hide()
                                f.itemFrame:GetScript("OnEnter")(f.itemFrame)
                            elseif f.lastIcon then
                                GameTooltip:Hide()
                                f.lastIcon:GetScript("OnEnter")(f.lastIcon)
                            end
                        end
                    end)
                end)
                mainFrame = f
                BG.StartAucitonFrame = mainFrame

                f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
                f.CloseButton:SetFrameLevel(f.CloseButton:GetParent():GetFrameLevel() + 50)
                f.CloseButton:SetPoint("TOPRIGHT", f, 0, 0)
                f.CloseButton:SetSize(35, 35)
            end

            -- 装备显示
            do
                local f = CreateFrame("Frame", nil, mainFrame, "BackdropTemplate")
                f:SetPoint("TOPLEFT", f:GetParent(), "TOPLEFT", 2, -2)
                f:SetPoint("BOTTOMRIGHT", f:GetParent(), "TOPRIGHT", -2, -35)
                f:SetFrameLevel(f:GetParent():GetFrameLevel() + 10)
                f.itemID = items[1].id
                f.link = items[1].link
                f:SetScript("OnMouseUp", function(self)
                    mainFrame:GetScript("OnMouseUp")(mainFrame)
                end)
                f:SetScript("OnMouseDown", function(self)
                    mainFrame:GetScript("OnMouseDown")(mainFrame)
                end)
                mainFrame.itemFrame = f
                -- 黑色背景
                local s = CreateFrame("StatusBar", nil, f)
                s:SetAllPoints()
                s:SetFrameLevel(s:GetParent():GetFrameLevel() - 5)
                s:SetStatusBarTexture("Interface/ChatFrame/ChatFrameBackground")
                s:SetStatusBarColor(0, 0, 0, 0.8)

                local icons = {}
                for i, v in ipairs(items) do
                    local itemID = v.id
                    local link = v.link
                    local name, link, quality, level, _, itemType, itemSubType, _, itemEquipLoc, Texture,
                    _, classID, subclassID, bindType = GetItemInfo(link)

                    -- 图标
                    local r, g, b = GetItemQualityColor(quality)
                    local ftex = CreateFrame("Frame", nil, f, "BackdropTemplate")
                    ftex:SetBackdrop({
                        edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                        edgeSize = 1.5,
                    })
                    ftex:SetBackdropBorderColor(r, g, b, 1)
                    if i == 1 then
                        ftex:SetPoint("TOPLEFT", 0, 0)
                    else
                        ftex:SetPoint("TOPLEFT", icons[i - 1], "TOPRIGHT", 3, 0)
                    end
                    ftex:SetSize(f:GetHeight() - 2, f:GetHeight() - 2)
                    ftex.itemID = itemID
                    ftex.link = link
                    tinsert(icons, ftex)

                    ftex.isIcon = true
                    ftex.owner = mainFrame
                    ftex:SetScript("OnEnter", item_OnEnter)
                    ftex:SetScript("OnLeave", item_OnLeave)
                    ftex:SetScript("OnMouseUp", function(self)
                        mainFrame:GetScript("OnMouseUp")(mainFrame)
                    end)
                    ftex:SetScript("OnMouseDown", function(self)
                        mainFrame:GetScript("OnMouseDown")(mainFrame)
                    end)

                    ftex.tex = ftex:CreateTexture(nil, "BACKGROUND")
                    ftex.tex:SetAllPoints()
                    ftex.tex:SetTexture(Texture)
                    ftex.tex:SetTexCoord(0.1, 0.9, 0.1, 0.9)
                    -- 装备等级
                    local t = ftex:CreateFontString()
                    t:SetFont(BIAOGE_TEXT_FONT, 12, "OUTLINE")
                    t:SetPoint("BOTTOM", ftex, "BOTTOM", 0, 1)
                    t:SetText(level)
                    t:SetTextColor(r, g, b)
                    -- 装绑
                    if bindType == 2 then
                        local t = ftex:CreateFontString()
                        t:SetFont(BIAOGE_TEXT_FONT, 11, "OUTLINE")
                        t:SetPoint("TOP", ftex, 0, -2)
                        t:SetText(L["装绑"])
                        t:SetTextColor(0, 1, 0)
                    end
                end

                if #items == 1 then
                    -- 装备名称
                    local t = f:CreateFontString()
                    t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                    t:SetPoint("TOPLEFT", icons[1], "TOPRIGHT", 2, -2)
                    t:SetWidth(f:GetWidth() - f:GetHeight() - 10)
                    t:SetText(link:gsub("%[", ""):gsub("%]", ""))
                    t:SetJustifyH("LEFT")
                    t:SetWordWrap(false)
                    local itemNameText = t
                    -- 装备类型
                    local t = f:CreateFontString()
                    t:SetFont(BIAOGE_TEXT_FONT, 12, "OUTLINE")
                    t:SetPoint("BOTTOMLEFT", icons[1], "BOTTOMRIGHT", 2, 1)
                    t:SetHeight(12)
                    t:SetWidth(itemNameText:GetWidth())
                    local classText = BG.GetTooltipClassText(items[1].id) or ""
                    if _G[itemEquipLoc] then
                        if classID == 2 then
                            t:SetText(itemSubType .. "  " .. classText)
                        else
                            t:SetText(_G[itemEquipLoc] .. " " .. itemSubType .. "  " .. classText)
                        end
                    else
                        t:SetText(classText)
                    end
                    t:SetJustifyH("LEFT")
                end
            end

            local width = 90
            -- 起拍价、拍卖时长
            do
                local t = mainFrame:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                t:SetSize(width, 20)
                t:SetPoint("TOPLEFT", mainFrame.itemFrame, "BOTTOMLEFT", 8, -2)
                t:SetJustifyH("LEFT")
                t:SetWordWrap(false)
                t:SetText(L["|cffFFD100拍卖时长(秒)"])
                mainFrame.Text1 = t

                local edit = CreateFrame("EditBox", nil, mainFrame, "BiaoGe_InputBoxTemplate")
                edit:SetSize(width, 20)
                edit:SetPoint("TOPLEFT", t, "BOTTOMLEFT", 3, 0)
                edit._type = "duration"
                edit.num = 1
                edit:SetText(BiaoGe.Auction[edit._type])
                edit:SetAutoFocus(false)
                edit:SetNumeric(true)
                edit:SetScript("OnTextChanged", OnTextChanged)
                edit:SetScript("OnEnterPressed", OnEnterPressed)
                edit:SetScript("OnEnter", Edit_OnEnter)
                edit:SetScript("OnLeave", GameTooltip_Hide)
                mainFrame.Edit1 = edit

                local t = f:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                t:SetSize(width, 20)
                t:SetPoint("TOPLEFT", mainFrame.Text1, "BOTTOMLEFT", 0, -20)
                t:SetJustifyH("LEFT")
                t:SetWordWrap(false)
                t:SetText(L["|cffFFD100起拍价|r"])
                mainFrame.Text2 = t

                local edit = CreateFrame("EditBox", nil, mainFrame, "BiaoGe_InputBoxTemplate")
                edit:SetSize(width, 20)
                edit:SetPoint("TOPLEFT", t, "BOTTOMLEFT", 3, 0)
                edit._type = "money"
                edit.num = 2
                edit:SetText(BiaoGe.Auction[edit._type])
                edit:SetAutoFocus(false)
                edit:SetNumeric(true)
                edit:SetMaxBytes(9)
                edit:SetScript("OnTextChanged", OnTextChanged)
                edit:SetScript("OnEnterPressed", OnEnterPressed)
                mainFrame.Edit2 = edit
            end

            -- 拍卖模式
            do
                local t = f:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                t:SetSize(width, 20)
                t:SetJustifyH("LEFT")
                t:SetText(L["|cffFFD100拍卖模式|r"])
                mainFrame.Text3 = t

                local dropDown = LibBG:Create_UIDropDownMenu(nil, mainFrame)
                dropDown:SetScale(0.95)
                dropDown:SetPoint("TOPLEFT", mainFrame.Text3, "BOTTOMLEFT", -17, 2)
                LibBG:UIDropDownMenu_SetText(dropDown, mods[BiaoGe.Auction.mod])
                dropDown.Text:SetJustifyH("LEFT")
                LibBG:UIDropDownMenu_SetWidth(dropDown, width + 5)
                LibBG:UIDropDownMenu_SetAnchor(dropDown, 0, 0, "BOTTOM", dropDown, "TOP")
                mainFrame.dropDown = dropDown
                BG.dropDownToggle(dropDown)
                LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level)
                    ClearAllFocus(mainFrame)
                    for mod, name in pairs(mods) do
                        local info = LibBG:UIDropDownMenu_CreateInfo()
                        info.text = name
                        info.arg1 = mod
                        info.func = function(self, arg1, arg2)
                            BiaoGe.Auction.mod = arg1
                            LibBG:UIDropDownMenu_SetText(dropDown, mods[BiaoGe.Auction.mod])
                            UpdateFrame()
                        end
                        info.checked = info.arg1 == BiaoGe.Auction.mod
                        LibBG:UIDropDownMenu_AddButton(info)
                    end
                end)
            end

            -- 开始拍卖
            do
                local bt = BG.CreateButton(mainFrame)
                bt:SetSize(width + 19, 25)
                bt.items = items
                bt.noSound = noSound
                mainFrame.bt = bt
                bt:SetScript("OnClick", Start_OnClick)
                bt:SetScript("OnEnter", Start_OnEnter)
                bt:SetScript("OnLeave", GameTooltip_Hide)
                if BiaoGe.Auction.mod ~= "roll" and isRightButton and BiaoGeVIP and BiaoGeVIP.auction then
                    local _duration = tonumber(BiaoGe.Auction.duration)
                    local duration = _duration and _duration > 0 and _duration
                    if duration then
                        local tbl = {}
                        for _, FB in pairs(BG.FBtable) do
                            if FB == BG.FB1 then
                                tinsert(tbl, 1, FB)
                            else
                                tinsert(tbl, FB)
                            end
                        end
                        local itemID = items[1].id
                        for _, FB in ipairs(tbl) do
                            local money = BiaoGeVIP.auction[FB].money[itemID]
                            if money then
                                bt.money = money
                                Start_OnClick(bt)
                                break
                            end
                        end
                    end
                end
            end

            -- 底部文字
            if BiaoGe.options["fastMoney"] == 1 then
                mainFrame.fastMoneyFrame = CreateFrame("Frame", nil, mainFrame)
                local tex = mainFrame.fastMoneyFrame:CreateTexture()
                tex:SetPoint("TOPLEFT", mainFrame, "BOTTOMLEFT", 2, 22)
                tex:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -2, 2)
                tex:SetColorTexture(0.2, 0.2, 0.2, 1)

                local buttons = {}
                local function CreateButton()
                    local money = BiaoGe.Auction.fastMoney[#buttons + 1]
                    local bt = CreateFrame("Button", nil, mainFrame.fastMoneyFrame)
                    bt:SetSize(50, 20)
                    if #buttons == 0 then
                        bt:SetPoint("BOTTOMLEFT", mainFrame, 0, 2)
                    else
                        bt:SetPoint("BOTTOMLEFT", buttons[#buttons], "BOTTOMRIGHT", 0, 0)
                    end
                    if BiaoGe.Auction.fastMoney[#buttons + 1] == "" then
                        bt:Hide()
                    end
                    bt.money = money
                    local t = bt:CreateFontString()
                    t:SetFont(BIAOGE_TEXT_FONT, 10, "OUTLINE")
                    t:SetWidth(bt:GetWidth())
                    t:SetPoint("CENTER")
                    t:SetText(BG.FormatNumber(money, 2))
                    t:SetTextColor(1, 0.82, 0)
                    t:SetWordWrap(false)
                    bt:SetFontString(t)
                    tinsert(buttons, bt)
                    bt:SetScript("OnClick", function(self)
                        mainFrame.Edit2:SetText(self.money)
                        BiaoGe.Auction.money = self.money
                        Start_OnClick(mainFrame.bt)
                    end)
                    bt:SetScript("OnEnter", function(self)
                        t:SetTextColor(1, 1, 1)
                        if t:GetStringWidth() > bt:GetWidth() then
                            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                            GameTooltip:ClearLines()
                            GameTooltip:AddLine(t:GetText(), 1, 0.82, 0, true)
                            GameTooltip:Show()
                        end
                    end)
                    bt:SetScript("OnLeave", function(self)
                        t:SetTextColor(1, .82, 0)
                        GameTooltip:Hide()
                    end)
                end
                for i = 1, #BiaoGe.Auction.fastMoney do
                    CreateButton()
                end
            else
                mainFrame:SetHeight(mainFrameHeight - 20)
            end

            UpdateFrame()
        end

        -- ALT点击背包生效
        if BG.IsRetail then
            hooksecurefunc("ContainerFrameItemButton_OnClick", function(self, button)
                if not IsAltKeyDown() then return end
                local link = C_Container.GetContainerItemLink(self:GetParent():GetID(), self:GetID())
                BG.StartAuction(link, self, nil, nil, button == "RightButton")
            end)
        else
            hooksecurefunc("ContainerFrameItemButton_OnModifiedClick", function(self, button)
                if not IsAltKeyDown() then return end
                local link = C_Container.GetContainerItemLink(self:GetParent():GetID(), self:GetID())
                BG.StartAuction(link, self, nil, nil, button == "RightButton")
            end)
        end
    end

    -- 插件版本
    do
        BG.guildBiaoGeVersion = {}
        BG.guildClass = {}
        BG.raidBiaoGeVersion = {}
        BG.raidAuctionVersion = {}
        BG.raidBiaoGeVIPVersion = {}

        -- 会员插件
        local guild = CreateFrame("Frame", nil, BG.MainFrame)
        do
            guild:SetSize(1, 20)
            guild:SetPoint("LEFT", BG.ButtonAd, "RIGHT", 0, 0)
            guild:Hide()
            guild.title = L["BiaoGe版本"] .. "(" .. GUILD .. ")"
            guild.title2 = GUILD .. L["插件：%s"]
            guild.table = BG.guildBiaoGeVersion
            guild.isGuild = true
            guild:SetScript("OnEnter", Guild_OnEnter)
            guild:SetScript("OnLeave", GameTooltip_Hide)
            guild.text = guild:CreateFontString()
            guild.text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
            guild.text:SetPoint("LEFT")
            guild.text:SetTextColor(RGB(BG.g1))
            BG.ButtonGuildVer = guild
        end

        -- 团员插件
        local addon = CreateFrame("Frame", nil, BG.MainFrame)
        do
            addon:SetSize(1, 20)
            addon:SetPoint("LEFT", BG.ButtonGuildVer, "RIGHT", 0, 0)
            addon:Hide()
            addon.title = L["BiaoGe版本"] .. "(" .. RAID .. ")"
            addon.title2 = L["插件：%s"]
            addon.table = BG.raidBiaoGeVersion
            addon.table2 = BG.raidBiaoGeVIPVersion
            addon.isAddon = true
            addon:SetScript("OnEnter", Addon_OnEnter)
            addon:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                self.isOnEnter = false
            end)
            addon.text = addon:CreateFontString()
            addon.text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
            addon.text:SetPoint("LEFT")
            addon.text:SetTextColor(RGB(BG.g1))
            BG.ButtonRaidVer = addon
        end

        -- 拍卖WA
        local auction = CreateFrame("Frame", nil, BG.MainFrame)
        do
            auction:SetSize(1, 20)
            auction:SetPoint("LEFT", addon, "RIGHT", 0, 0)
            auction:Hide()
            auction.title = L["拍卖WA版本"]
            auction.title2 = L["拍卖：%s"]
            auction.table = BG.raidAuctionVersion
            auction.table2 = BG.raidBiaoGeVIPVersion
            auction.isAuciton = true
            auction:SetScript("OnEnter", Addon_OnEnter)
            auction:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                self.isOnEnter = false
            end)
            auction:SetScript("OnMouseUp", function(self)
                SendWACode()
            end)
            auction.text = auction:CreateFontString()
            auction.text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
            auction.text:SetPoint("LEFT")
            auction.text:SetTextColor(RGB(BG.g1))
            BG.ButtonRaidAuction = auction
        end

        local lastNum = 0
        function BG.CanSend_BiaoGeVer()
            local n
            local canSend = true
            if IsInRaid(1) then
                n = GetNumGroupMembers(1)
                if lastNum >= n then
                    canSend = false
                end
            else
                canSend = false
                n = 0
            end
            lastNum = n
            return canSend
        end

        local f = CreateFrame("Frame")
        f:RegisterEvent("GROUP_ROSTER_UPDATE")
        f:RegisterEvent("GUILD_ROSTER_UPDATE")
        f:RegisterEvent("CHAT_MSG_SYSTEM")
        f:RegisterEvent("CHAT_MSG_ADDON")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:SetScript("OnEvent", function(self, event, ...)
            if event == "GROUP_ROSTER_UPDATE" then
                local canSend = BG.CanSend_BiaoGeVer()
                BG.After(1, function()
                    if IsInRaid(1) then
                        if canSend then
                            C_ChatInfo.SendAddonMessage("BiaoGe", "MyVer-" .. BG.ver, "RAID")
                        end
                    else
                        UpdateAddonFrame(addon)
                        UpdateAddonFrame(auction)
                    end
                    UpdateGuildFrame(guild)
                end)
            elseif event == "GUILD_ROSTER_UPDATE" then
                BG.After(1, function()
                    for i = 1, GetNumGuildMembers() do
                        local name, rankName, rankIndex, level, classDisplayName, zone,
                        publicNote, officerNote, isOnline, status, class, achievementPoints,
                        achievementRank, isMobile, canSoR, repStanding, guid = GetGuildRosterInfo(i)
                        if name then
                            name = BG.GSN(name)
                            if not isOnline then
                                BG.guildBiaoGeVersion[name] = nil
                                BG.guildClass[name] = nil
                            else
                                BG.guildClass[name] = class
                            end
                        end
                    end
                    UpdateGuildFrame(guild)
                end)
            elseif event == "CHAT_MSG_SYSTEM" then -- 如果团队里有人退出，就删掉
                local text = ...
                local leave = ERR_RAID_MEMBER_REMOVED_S:gsub("%%s", "(.+)")
                local name = strmatch(text, leave)
                if name then
                    BG.raidBiaoGeVersion[name] = nil
                    BG.raidAuctionVersion[name] = nil
                    BG.raidBiaoGeVIPVersion[name] = nil
                    UpdateAddonFrame(addon)
                    UpdateAddonFrame(auction)
                end
            elseif event == "CHAT_MSG_ADDON" then
                local prefix, msg, distType, sender = ...
                sender = BG.GSN(sender)
                if prefix == "BiaoGe" and distType == "GUILD" then
                    if strfind(msg, "MyVer") then
                        local _, version = strsplit("-", msg)
                        BG.guildBiaoGeVersion[sender] = version
                        UpdateGuildFrame(guild)
                    end
                elseif prefix == "BiaoGe" and distType == "RAID" then -- 插件版本
                    if msg == "VersionCheck" then
                        C_ChatInfo.SendAddonMessage("BiaoGe", "MyVer-" .. BG.ver, "RAID")
                    elseif strfind(msg, "MyVer") then
                        local _, version = strsplit("-", msg)
                        BG.raidBiaoGeVersion[sender] = version
                        UpdateAddonFrame(addon)
                        if BG.worldBossCDFrame then
                            BG.worldBossCDFrame:UpdateFrame(sender)
                        end
                    end
                elseif prefix == "BiaoGeAuction" and distType == "RAID" then -- 拍卖版本
                    local arg1, version = strsplit(",", msg)
                    if arg1 == "MyVer" then
                        BG.raidAuctionVersion[sender] = version
                        UpdateAddonFrame(auction)
                        if sendDone[sender] then
                            sendDone[sender] = nil
                            if not notShowSendingText[sender] and sendingCount[sender] <= 2 then
                                BG.SendSystemMessage(format(BG.STC_g1(L["%s已成功导入拍卖WA。"]), SetClassCFF(sender)))
                            end
                            UpdateOnEnter(BG.ButtonRaidAuction)
                            UpdateOnEnter(BG.StartAucitonFrame)
                        end
                    end
                elseif prefix == "BiaoGeVIP" and distType == "RAID" then -- VIP版本
                    if strfind(msg, "MyVer") then
                        local _, version = strsplit("-", msg)
                        BG.raidBiaoGeVIPVersion[sender] = version
                    end
                end
            elseif event == "PLAYER_ENTERING_WORLD" then
                self:UnregisterEvent("PLAYER_ENTERING_WORLD")
                C_Timer.After(3, function()
                    if IsInRaid(1) then
                        C_ChatInfo.SendAddonMessage("BiaoGe", "VersionCheck", "RAID")
                        C_ChatInfo.SendAddonMessage("BiaoGeAuction", "VersionCheck", "RAID")
                    end
                end)
            end
        end)
    end
    -- 移除屏蔽
    local function CheckIgnore()
        if BiaoGe.options.ignore ~= 1 then return end
        for i = 1, C_FriendList.GetNumIgnores() do
            local ignoreName = C_FriendList.GetIgnoreName(i)
            for i, v in ipairs(BG.raidRosterInfo) do
                if v.name == ignoreName then
                    C_FriendList.DelIgnore(ignoreName)
                    BG.SendSystemMessage((format(L["已把%s从屏蔽名单中移除，防止你看不到对方的拍卖聊天信息。"], SetClassCFF(ignoreName))))
                    break
                end
            end
        end
    end
    -- 删除aaa插件
    if IsAddOnLoaded("aaa") then
        BG.After(10, function()
            BG.SendSystemMessage(L["请你删除aaa插件，该插件会破坏系统的通讯功能，导致其他插件功能失效。"])
        end)
    end
    -- 给拍卖WA设置关注和心愿
    function BG.HookCreateAuction(f)
        -- 关注
        if not f.itemFrame2.guanzhu then
            local t = f.itemFrame2:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, 12, "OUTLINE")
            t:SetPoint("LEFT", f.itemFrame2.itemTypeText, "RIGHT", 2, 0)
            t:SetText(L["<关注>"])
            t:SetTextColor(RGB(BG.b1))
            f.itemFrame2.guanzhu = t
        end
        f.itemFrame2.guanzhu:Hide()
        for _, FB in ipairs(BG.GetAllFB()) do
            for b = 1, Maxb[FB] do
                for i = 1, BG.GetMaxi(FB, b) do
                    local zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                    if zb and f.itemID == GetItemID(zb:GetText()) and BiaoGe[FB]["boss" .. b]["guanzhu" .. i] then
                        f.itemFrame2.guanzhu:Show()
                        BG.After(0.5, function()
                            f.autoFrame:Show()
                        end)
                        break
                    end
                end
                if f.itemFrame2.guanzhu:IsVisible() then break end
            end
            if f.itemFrame2.guanzhu:IsVisible() then break end
        end
        -- 心愿
        if not f.itemFrame2.hope then
            local t = f.itemFrame2:CreateFontString()
            t:SetFont(BIAOGE_TEXT_FONT, 12, "OUTLINE")
            t:SetPoint("LEFT", f.itemFrame2.guanzhu, "RIGHT", 2, 0)
            t:SetText(L["<心愿>"])
            t:SetTextColor(0, 1, 0)
            f.itemFrame2.hope = t
        end
        f.itemFrame2.hope:Hide()
        for _, FB in ipairs(BG.GetAllFB()) do
            for n = 1, HopeMaxn[FB] do
                for b = 1, HopeMaxb[FB] do
                    for i = 1, HopeMaxi do
                        local zb = BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                        if zb and f.itemID == GetItemID(zb:GetText()) then
                            local hope = f.itemFrame2.hope
                            hope:ClearAllPoints()
                            if f.itemFrame2.guanzhu:IsVisible() then
                                hope:SetPoint("LEFT", f.itemFrame2.guanzhu, "RIGHT", 2, 0)
                            else
                                hope:SetPoint("LEFT", f.itemFrame2.itemTypeText, "RIGHT", 2, 0)
                            end
                            hope:Show()
                            BG.After(0.5, function()
                                f.autoFrame:Show()
                            end)
                            break
                        end
                    end
                    if f.itemFrame2.hope:IsVisible() then break end
                end
                if f.itemFrame2.hope:IsVisible() then break end
            end
            if f.itemFrame2.hope:IsVisible() then break end
        end
        if f.itemFrame2.guanzhu:IsVisible() or f.itemFrame2.hope:IsVisible() then
            if not f.highlight then
                local function Create()
                    local f1, f2
                    f1 = BG.CreateHighLightAnim(f)
                    f1:SetFrameLevel(120)
                    f.highlight = f1
                    f1:SetScript("OnEnter", function(self)
                        f1.flashGroup:Stop()
                        f2.flashGroup:Stop()
                        f1:Hide()
                        f2:Hide()
                    end)

                    f2 = BG.CreateHighLightAnim(f.autoFrame)
                    f2:SetFrameLevel(120)
                    f.autoFrame.highlight = f2
                    f2:SetScript("OnEnter", f1:GetScript("OnEnter"))
                end
                Create()
            end
        end
        -- 过滤
        f.filter = nil
        local num = BiaoGe.FilterClassItemDB[RealmId][player].chooseID
        if num then
            local name, link, quality, level, _, _, _, _, EquipLoc, Texture, _, typeID, subclassID, bindType = GetItemInfo(f.itemID)
            if BG.FilterAll(f.itemID, typeID, EquipLoc, subclassID) then
                f.filter = true
                if not (f.player and f.player == BG.GN()) then
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

        tinsert(BG.auctionLogFrame.auctioning, f.itemID)
        BG.UpdateAuctioning()
        CheckIgnore()
    end

    -- 拍卖欢呼语
    do
        local tbl = {
            [[<%s>这波操作，直接把竞拍场变成了 "金币战场"，敌方全员溃败！]],
            [[天呐！<%s>的金币像 "冰霜新星"一样冻住了所有竞争者！太强了！]],
            [[<%s>出价如 "炎爆术"般炸裂，直接秒杀全场竞拍者！]],
            [[救命！<%s>的金币大军开着 "奥术飞弹"来了，谁顶得住啊！]],
            [[这波出价，堪比 "星辰坠落"！<%s>这是要把装备砸穿地心啊！]],
            [[<%s>一喊价，就像按下了 "群体驱散"，其他出价瞬间消失！]],
            [[别人竞拍靠 "普通攻击"，<%s>竞拍直接 "开大"！这谁受得了！]],
            [[<%s>的金币如 "复活币"般珍贵，这波操作直接让装备 "起死回生"！]],
            [[哇塞！<%s>这波 "闪现"出价，直接把其他玩家甩到外太空！]],
            [[<%s>的金币像 "治疗链"一样疯狂跳，直接把竞拍值抬到天花板！]],
            [[这出价，是要发动 "末日决战"吗？<%s>太强了！]],
            [[<%s>一出手，就像 "圣骑士开无敌"，其他竞拍者完全无法抵抗！]],
            [[救命！<%s>的金币如 "恶魔之怒"般汹涌，直接把竞拍场炸翻！]],
            [[<%s>这波 "影遁"出价，其他玩家根本找不到机会反击！]],
            [[别人出价是 "普通任务"，<%s>出价是 "史诗级成就"！瑞斯拜！]],
            [[<%s>的金币像 "狂暴战"一样疯狂输出，直接把竞拍值打崩！]],
            [[这波操作，堪比 "法师偷取增益"，<%s>直接把装备buff拉满！]],
            [[<%s>一喊价，就像 "猎人开威慑"，其他出价全成了挠痒痒！]],
            [[<%s>的金币如 "盗贼伏击"般突然，直接把竞拍节奏带飞！]],
            [[哇哦！<%s>这波 "牧师渐隐术"出价，其他玩家完全跟不上节奏！]],
            [[这出价，是要发动 "萨满嗜血"吗？<%s>直接让竞拍速度翻倍！]],
            [[<%s>一出手，就像 "术士召唤末日守卫"，其他竞拍者直接吓退！]],
            [[救命！<%s>的金币如 "猎人瞄准射击"般精准，直接命中装备！]],
            [[<%s>这波 "战士冲锋"出价，直接把其他玩家撞出竞拍圈！]],
            [[别人出价是 "小怪巡逻"，<%s>出价是 "BOSS碾压"！太强了！]],
            [[<%s>的金币像 "德鲁伊变熊"一样坚挺，直接把竞拍价稳住！]],
            [[这波操作，堪比 "潜行者偷袭"，<%s>直接把装备偷走啦！]],
            [[<%s>一喊价，就像 "死亡骑士开大军"，其他出价全成了炮灰！]],
            [[<%s>的金币如 "法师暴风雪"般覆盖全场，其他玩家根本无处可逃！]],
            [[哇塞！<%s>这波 "圣骑士制裁"出价，其他竞拍者直接被沉默！]],
            [[这出价，是要发动 "猎人误导"吗？<%s>直接把装备骗到手！]],
            [[<%s>一出手，就像 "萨满开英勇"，其他玩家只能看着干瞪眼！]],
            [[救命！<%s>的金币如 "术士生命虹吸"般疯狂，直接吸干所有竞争者！]],
            [[<%s>这波 "盗贼消失"出价，其他玩家根本反应不过来！]],
            [[别人出价是 "普通攻击"，<%s>出价是 "暴击秒杀"！太狠了！]],
            [[<%s>的金币像 "牧师治疗祷言"一样慷慨，直接把装备价格抬到天际！]],
            [[这波操作，堪比 "法师奥术飞弹连发"，<%s>直接把竞拍值打穿！]],
            [[<%s>一喊价，就像 "战士破甲"，其他玩家的抵抗瞬间瓦解！]],
            [[<%s>的金币如 "德鲁伊回春术"般持续，直接把竞拍热度拉满！]],
            [[哇哦！<%s>这波 "圣骑士奉献"出价，其他竞拍者全被烧死啦！]],
            [[这出价，是要发动 "猎人假死"吗？<%s>直接让其他玩家放弃抵抗！]],
            [[<%s>一出手，就像 "萨满地震术"，其他玩家的出价全被震碎！]],
            [[救命！<%s>的金币如 "术士恐惧术"般可怕，其他玩家直接吓跑！]],
            [[<%s>这波 "盗贼闷棍"出价，其他玩家根本无法反击！]],
            [[别人出价是 "新手村练习"，<%s>出价是 "团本开荒"！太强了！]],
            [[<%s>的金币像 "法师炎爆术"一样高伤害，直接秒杀所有竞争者！]],
            [[这波操作，堪比 "潜行者毁伤"，<%s>直接把装备拆分成碎片！]],
            [[<%s>一喊价，就像 "死亡骑士冰链术"，其他玩家的出价全被冻结！]],
            [[<%s>的金币如 "猎人爆炸射击"般炸裂，直接把竞拍场炸上天！]],
            [[哇塞！<%s>这波 "圣骑士神恩术"出价，其他玩家只能望尘莫及！]],

            [[救命！<%s>这手速和魄力，是吃了“竞拍开挂套餐”吧！太强了！]],
            [[<%s>出价，寸草不生！这波直接把竞拍门槛抬到外太空！]],
            [[家人们快看！大佬<%s>的金币正在组团冲锋，势不可挡！]],
            [[这出价，是要把装备焊在身上的节奏啊！<%s>太狠了！]],
            [[<%s>这波操作，直接让竞拍变成了个人秀场，瑞斯拜！]],
            [[别人出价靠犹豫，<%s>出价靠霸气！膝盖已献上！]],
            [[哇哦！<%s>这一嗓子，整个服务器都在颤抖！]],
            [[竞拍界的“钞能力”天花板出现了！<%s>yyds！]],
            [[<%s>的金币如瀑布般倾泻，这谁顶得住啊！]],
            [[这波出价，直接给竞拍结果盖棺定论！<%s>太会了！]],
            [[救命！<%s>的金币大军已抵达战场，宣告胜利！]],
            [[<%s>一出手，就知有没有！这格局，爱了爱了！]],
            [[别人出价是试水，<%s>出价是海啸！太强了！]],
            [[<%s>这波操作，直接把竞拍玩成了“金币交响乐”！]],
            [[天呐！<%s>的金币正在疯狂上分，无人能敌！]],
            [[<%s>出价，直接“杀疯了”！这装备妥妥是你的！]],
            [[这出价，是要把其他竞拍者“卷”到地心吗？<%s>牛！]],
            [[别人竞拍靠运气，<%s>竞拍靠实力！瑞斯拜！]],
            [[<%s>的金币正在上演“速度与激情”，太刺激了！]],
            [[哇塞！<%s>这气势，直接把竞拍现场变成了“土豪专属区”！]],
            [[救命！<%s>这波操作，直接让竞拍进入“碾压局”！]],
            [[<%s>一喊价，空气都凝固了！这威慑力绝了！]],
            [[别人出价是小打小闹，<%s>出价是惊天动地！]],
            [[<%s>的金币如火箭般发射，这谁能拦得住！]],
            [[这波出价，直接给装备贴上了“<%s>专属”标签！]],
            [[天呐！<%s>的金币正在疯狂刷屏，太壕了！]],
            [[<%s>出价，直接“封神”！这操作太秀了！]],
            [[别人竞拍是过家家，<%s>竞拍是打BOSS！太强了！]],
            [[<%s>的金币正在谱写“竞拍传奇”，太牛了！]],
            [[哇哦！<%s>这一出手，直接把竞拍变成了“降维打击”！]],
            [[救命！<%s>的金币大军已势不可挡，宣告胜利！]],
            [[<%s>一喊价，全场都沸腾了！这魅力谁能抗拒！]],
            [[别人出价是毛毛雨，<%s>出价是倾盆大雨！]],
            [[<%s>的金币正在上演“王者归来”，太霸气了！]],
            [[这波出价，直接把装备“拿捏”得死死的！<%s>牛！]],
            [[天呐！<%s>的金币正在疯狂输出，太猛了！]],
            [[<%s>出价，直接“炸场”！这操作太顶了！]],
            [[别人竞拍是青铜，<%s>竞拍是王者！瑞斯拜！]],
            [[<%s>的金币正在书写“竞拍神话”，太厉害了！]],
            [[哇塞！<%s>这气势，直接把竞拍现场变成了“个人演唱会”！]],
            [[救命！<%s>这波操作，直接让竞拍进入“无敌模式”！]],
            [[<%s>一喊价，世界都安静了！这实力太震撼了！]],
            [[别人出价是小浪花，<%s>出价是惊涛骇浪！]],
            [[<%s>的金币正在发起“总攻”，胜利在望！]],
            [[这波出价，直接给装备插上了“<%s>的翅膀”！]],
            [[天呐！<%s>的金币正在疯狂收割，太绝了！]],
            [[<%s>出价，直接“起飞”！这操作太帅了！]],
            [[别人竞拍是新手村，<%s>竞拍是终极大本营！太强了！]],
            [[<%s>的金币正在创造“竞拍奇迹”，太牛啦！]],
            [[哇哦！<%s>这一出手，直接把竞拍变成了“老板的Show Time”！]],
        }

        if BG.IsVanilla then
            BG.autoAuctionHappySay_minMoney = 20000
        elseif BG.IsWLK_80 then
            BG.autoAuctionHappySay_minMoney = 100000
        elseif BG.IsTitan then
            BG.autoAuctionHappySay_minMoney = 20000
        elseif BG.IsMOP then
            BG.autoAuctionHappySay_minMoney = 1000000
        else
            BG.autoAuctionHappySay_minMoney = 100000
        end
        BG.RegisterEvent("CHAT_MSG_ADDON", function(self, event, ...)
            if not (BG.IsLeader and BiaoGe.options.autoAuctionHappySay == 1) then return end
            local prefix, msg, distType, sender = ...
            if prefix ~= "BiaoGeAuction" then return end
            local arg1, arg2, arg3, arg4, arg5, arg6, arg7 = strsplit(",", msg)
            sender = BG.GSN(sender)
            if arg1 == "SendMyMoney" and distType == "RAID" then
                local auctionID = tonumber(arg2)
                local money = tonumber(arg3)
                if money and money >= BG.autoAuctionHappySay_minMoney then
                    for _, f in pairs(_G.BGA.Frames) do
                        if not f.IsEnd and f.mod ~= "anonymous" and f.auctionID == auctionID then
                            if random(10) > 5 then
                                local text = tbl[random(#tbl)]
                                if text and sender then
                                    SendChatMessage(format(text, sender), "RAID")
                                end
                            end
                            return
                        end
                    end
                end
            end
        end)
    end

    -- 拍卖WA字符串
    local wa
    -- WA字符串
    wa = [[
!WA:2!S3xxZrXr2coZCFtpD3zJyEz3hQO3Wt09qR2TewymlWUscbO7iHyLeJ3zD4ODRURwQg6URE6QAazBMaWxBW8HbJbBmgpyWFmm2MpgUZaIVmrS)cUX8tyUQBj90eX(lypNmZQQmZkZQQws235JRcB6QQ8KN8KN8KN8KN8Kz(935pS2pS8pS8j(V30ULBvR6MnNyFtp2O7zKRBvYU(u2TAwY87pzj7Q2n)N(hG)ASHYwonQwC(PnpKBHk2nRv0TqJcUw1mluE(6fRzvQG7CnnDMZUA55VEPwoU21qy)b)rN5kw2(G)8jQuXX09)637UfRxAo7M712QU7mdpYEMEKj)JLSHCzFW6tDqRgMVsdd9Lf9TVFJ)XGsyFnkx01CMwKF()6HQrkpR5CdHvMx5yUnTMDwZMo75h3K94xmK78nmhQvDl3)ulhZcfREWIZ742SL5R8NCAnJ5bmR7ovRkvSo0Dlm8GtnDHPMEWjNEsY3V(W21lB5Azx35F9)8miDA28yonmRwD0Yo9CmeDiEdq0EBAciAYP27iJn2KaRY0PNRxgi4kvMgiIM7EKX27o33yNVvDgX1ZDH6)VOv9sUwhWS)I1NVX)PIKNNMM(42Ln)6VxJu65s1SlxOjWnELRduZ0ahX1QXC))2VPzJbbcTK7KfbYFUZ7ywTcTDyOjME6jg)pwSLl00mrdsLRNHkB6u6q)dvw8jxz5J8M)5hF5Lp1zw63(GfFWPw5kxPNE6CZp7fhSZLUD7p66TF3lT0xD7)8Jp9sx4gl(W3PZ785DUW9GVVYfFA7Z(UTp(dx6Y)ZDo1zAFM3VZ9orNJIq25UxR9TE7L)03esIIHox6Bw6ZE4IlCMfF4BrbEFJ(VDKJT8TVpftDo5jx(2F(loiGXLE0hsZdffauT)IJ15xFf2hV)Dx6rNLMeGRHSkAVlZoN98l(O7bfC7ZE7fF0NdfdqRuyiyfWbuL(OFFN3)olFR70(jxeQV9CGnMRF43ox42Do9rx(u)ULV9n7CLVU9vUt7t)(yI9bjU4tVv7pdP5L)M3R9B(5DU2B1(SxAPh9uOETYhCRvU(LqaZZdiJtCT3QZV(EaulUWrwCHVCLJFM2N9t8Yr)5EbihTp9tBFUZ05gxR9Jp7IlCkkByP35oTVYnO1IoFWNS8V5TOGbvaehF2za29Ip6(D(G7rHCLRCKL)IJU0XEq7J)OLU2Tw(wFgsIN7D682Nz534juGXcCZqbsZbf2oN8sab150V9kN)waYao3Ip(YqjamOoVZ5BFIpyXNCMLEYTGIDPh)Bx6Q3KwRw6rVxNp(Qa6x6l)G2N9tHM72F2VdB9)G7TYh87XY55rg6BFQ2N8guggM4voYIp5DqI(tE8kF45AFcq25xV8DEJ2N4oGWw73(mimx8oTpYJHsBXhFjG7ZqpLgV4jG2Ee3BcXnLoiP3(e3hjxk1VWzA)wNHVc0(nVXkVXnOqcaS8roninV4t)yOTU97CvO6Hz5SKwJb8r8kh)Dx56F8Y37nx(PhVVfx44aYb(YYp9Jw(ANgyeTFRpeOXbhB6niWf94FTV9dOLkpvsH5UCDN)bdvXUUBJ)XD206vn(F1QyzOZCrJPNU58uTO7()5R8)5lpY3779dA8FrHsGsShgQUDDZzMZ0A25Cp6Fc6BBdF0Q0lAv2DUHgeEDOQ2flFVMw1NfgfOXpAgh4PQMd1SOv5ZJQXQdQVAo3F0QUJlO02SaQZSNjlvTOJZpAYATaTk9CEe4cnTRA2ZDXSWW1RmJBXQGQVF0)626HGQQaQQo3qO2h8BxVSfOCTeGI5)X)RBgOXM2wLGVpKJ1RAIa0e14bkH20Kqz309hDSY2fCSBvVmOthuU(Jpp8oDiGxzg6Vh57V7VUQDPIvnk2QzrJTr(PGz9dyy3041oCp4R5G6dKskSFDQE6PcrhRDDcO52LP7pZS5EAvlnmqqMEmG)AA62QzDdx76TQnJztmbOcMdyJLMdFjlGQ0pt5n8m5G)jtQmzWYkFpM1l3tpwvmQB7Auyx5gAxdA4oNzDckzVVnKKcEp3oBIJlq)SzvhtsAakKOmVkrgJTUn50yyIKQFXfuliVIug(Rh6z5zWwe(W4fTQtieX8RbOTSBRYMPZiG3auocoYNs8qszl7REtZzTCCnBoy1QKp5OfxmMJaYqlfslKEqUX)pGBWefWh9(QVObnPEOchdwUSD9HNRy96MvrPe6ahSQDQEgUaKM7O1RyNBspshZX4MoofN1KokF6qyktp9qflhdWj03TMPl0zEMQMPFTdN141c4oqFNYMhcaYtSmnbSSg73C(m(GjiwsLhtlaaw5pCgwzoyfxcdy4ctd2f0mh5DwAfksRzJUJcyT1)Tu(em(VMqAGmg9zOfcAvs7LaKRxDUPFXuCYBJ9sPgSQRNYpYqmlDHRcAOt9YyHGPTYJ(1DEVtkKMxwBF2VSZvEB2W9N49x6T)TTFVJ2(eV1kV5zalqGK68XVboaXzj2rquHsXllJx5sRCX7RoJF9j5Z4Y)lFQFH25tEqNZCRfFYNGwIqgoegBQZroANl8aq7F7R)RBF8Z2(bVz7h(f0YcH)9USp8TFJh0(uxSZBEka(LV1jb47SWhXG3RiWQZPFB6y2TF6xTYrUkm6wNl(7Pd5rrls5sW8LpfGbWpcJpl6k3W3qJfFYtbJy68OlV8tU1Ip4QqE1HCmxpEbXC9nl)4VuixQkUTVDdOMAS1TsXtWREaaVstcFWNipXNV4dFyAQHjzyKG438znx5iR8vxcmAS9tEpyKEbocjPoV)Jx6I3dssIY8Zi2EFZ3gEy5)W9HMwadszNca8afaapCcCHLKuiIGMP(O3LcWYF6hV09oQFsVEPkv25o3rF5ZZxbaZfE9Mu4daGVAqbims8RdkXGFfqx2z2(rQ5uB2dJeQmRemHr1wn4n)0y7HrKci85Re6GXrjLxq3TB(PTxybAEyDO4)Ipg4qndp8FXhBCwDYWgPPBP)W5WViwTYd)15pCuaIqmg5K4Zy(8y6DoX5w8HFw4wg(uv2YqbyXhCN236EkZ7Y39((j5LXxRP7MomBIcN4CTp5vjFW4zCO)hffEab1xLaXHSNNHmQ4n5d8O55zOrkzreqypQYQycInnumY30W(Ipye1x4SD0O7IQPkaavQPOkyJajuTRrJe6GwimWKOG5GW1FU9dUhoqWjz66OdHHZi(Zo(YF6t47yV4cFbds)kiX8EwD5KxAP3)Kbc5)Ul2(XhHjE)7U4kV)PK4E0MvEUh7l(Gr49maOp7R06wFdm)S2p9nw6CVfpRy5BCt)Vlp4YJps7ZD7Lp(xcJaY3fgiS2x8Q43p1fL6otBndNLGVhklHbwjyBF7OIbyGloWdghkinVmYnOeFLELlC0236YlUWnz0fx9EL359zjPV24ptzy67Wi8WK70v)A)nNwgsF0s9oXj(kyeqMk6BFbyatC8jYudzL4cOziuaqxKC7Z25RVgikbVU4cpKolzQLfOFmiGHUlbMwozGqiVqBouJqdt44ab0mJm(CkzGmbFY4dpgJmGQZd(kkzquNfqgWRlDmfKb8DGm6CL3GoClsg34M8KbLBlWqcjvQuEekR235SuoaTeb(GNUh)erEpxIEz(p)4t8mo)5h)2uO9FZh339AGDH(nimCE3Z7)rbPCcmuhdXpQ2Y34sRC6)zUUCbaiL0)2rok974dIdYXp8wOs8BGkfOOrSqVj0oGFuf7mayookpWlUWXzu45(Af6(oZfxCHVKxXKVYU2V)TAFKtjPNkWvhieeFBWNzm5ae4LmpcKkzETLsLCN39H8kpvuY8zwrjlHaui)(3TZLU9Z44B6pNzrNghHghJggD)UxR9tFZL)IJIDqU)VBLRDp6dVEt09xx5Qq2rFS9OFZsp6Mm1gN4o4GW)5hFvFRJfllrtWekRZluwFYXuwwp4Xl9qwNpUYYxG4ZoEN)LBeikCSpC5B8iEHay06(8mjau6)Bof5diA4TaLBy((ywiGdfecAQDpC99OtHlO8jtmtWQiALD5B)5GT1a1c6YLCG4IlCKL(OFp2l9c3dQHsEtgF9sxDLJC5LU6NJ6OE7JGo19jFc1jY(UBgXgOX7S3gvld6OU5NU01UfQO723V97EsiVu06RHKJY(T3fS0hyCukZ3KsqlVhLDEgLrQCl9HpMrzWRx(KHPSvU2T9Pmg2KOSR)qKY(QtXOmcA5vAgqCmpb)fpAPh(usTHXfJUEROwslKv(ORV09VmIiVkD0KPon5XoLmHbFtY0ZuH8WtuujAfN0i6tnjxxywFFt1LUUy4QwL2VHRTbz9yk6AU29CXe1Ropsdge)MAu1SyzZMOBeRAB7AuRi6MjJ5k6y0WSznlhh0DLabucDiBvsgl65GQvP)mMgWHv9snnl6y(SLnPpyaLBdd2k7vSkqJLMRy9znDmMbsTSbqfZB3QPXmwL7kVCmMD9znA000XHWgl)lA54cVBvY04x2cyUvNFn6PJPk10UkLXuZUfuro4CMaJYQo5tw1B0Y1yg7dfBPh2Xh)C7wkD8b89iD8Xeqb30j9G1TRppssjY3hJJu2mMgZznlKBG2lsRaLA1Sj6yvcrNCFHOcDGmM5VSvXQiRarnXr7wqZdFBAyb2HjsEkDnYq2JSA8lYEX6Ywmwf(dzkKKngYQSMCNe3HmTDdedqVonijjocXVX1axCwTUcziooBy)GShCvBQsWqeUbrSOIWrimhxBms9YML7opHSZIwvndZutIJqu3ygRpqgQ18snaj3diEv0PAvQeOyPsRQRb)G4HmQyoWf6sNH4LFklmbofXVGsUhrEruL2wmgmk9xX6reIM49IAIJbtj3TiKHh3IXW2nMxurLrX6L9hJrPJrgguAxSbxI8tIyKd1aqqeUgjOLxPJrOTfX6yKPmDngV4Hm47LQZJi4YN2laOXe1J1vibWwPseobXdSe6aeuNfOTozE9aQww1AvdRA4Y6SFZYRcxEGdawdLtkB5GRmLHFfdgbPMDzRkOLmwo5(ln)EmAfdh7AM21nXX2CegfeSIjRHLRXbTQIRCmBnYjw8aWgyNJ5CfRwbGYDoQTfw1jmuIqDnqqplrgNGfCzFnpujtWmjsEDOYvEna5IWliCGLmNGmoJoqA1NwmSeu7j6iK0pdNfikDcYESPSPgvlwIxqjKpqWM(DB54A3CELUaronFFGKZqPlq8hAlAVGGflYtDT3Ir0UaHJDYbQVdqYV)K4)dMwnQsiJPiXiHXOUM16gFGiIKbRwnj()WxFkv3yslBzVGiJg(s)7sFGG6pk2egmOkmoqz6SEiDfrBtjwGzubmk9zCYzeuSGWyDSNeOIXULlkMJ9PWix71BMZyqaDW7goTypCWIyuhqeGnGPtbp9mo)p05wK9y7A6WjySkCkIVThOLOKX7PzykpJPjIE69mYUiZ6BmYS(4OK)AWdjqldg8pO6oRkGktcFOst7AHNo7bH5V20SKP1bGwsSnghMa06AwZOijcf4MhlgadMLZzGtlLfCtqM8seSxPvvCEXZJtNb04zdMzuYnNXERsM2kHycpH6Cs2JUo7gLPLRWqTZUsfmUAPvejYxKfeQYWp7HUX9k8JYxlbZ4JxiTB95sCLfI)Hz2aUx6KvjHfLumxTN0ySYsJEf8ja1KFasnfn0At5fmq0KHI2nLyOaXYxkO2mRPBkHGiIfQm7Y0DFau7PyntsbM1aJ13mkjPDUN0yq6MXRCXHZR7fuuEi0d)0iLbtolKuXQ1WG8XTji2A5MovVPYAeGlV0P)c1qGQMeFMqwcrCgP8Ybdt2Bk8hsousSt9TfXYWLpTYGhyZPeEvSoOkWZiiL2O4fyBXvt5dKlPA8u7TBQXSxvvjvG7j31qPNZ8qzHriBmxXmC8SMGkicVcd)pNwZqbRVSg9Zd1SnnbsimCBmRXZXd3mvBzQaSbYASPmbHNhTm9J9q4vOe3ugJN1O)bgGaHx55dd5dYqXknFGW3LHXJzsQ4kBejfpd)umqGvB7Qm8r2MA6omguPdVZDMMkDs76d9sNVrqln(IqRmPzxu4Uqwds8P6LhkIKIdrgmatbvkqk60uaZeU(OeAXoFIXTiLqiBDccbIDz8ihkMeOgoWjbiyvyeG0pxwSJfLPGPKMKXmbr5Na6F9sK(ouCap43NYBGeU2f)mML(yKDmZ6r6(nC92Rr7fwyLJF2EkBtsHWjirMBFaPm1e7Bp74No60aVPW0Jo9yJuyI9o9OtSNct8tLGUFa6b20lmWlSXGe21KJmYE6JyzoXPqPcsAYr2bjbQ)Psfi0ssTwXdTNw1OHU62m6pFqkV4O7y6DdFBJ9X9XDpYO7A3tdFTV8de81PgFWXgRGFA9Vr(sFVJm40qnA8rKW)UhDhJSZjhC8r8sSVG0mlpR5uwVkHKYXvqZuS0(l30UXWS28xZiFw2)LBtghomGdz3emQia8(iQEaW7tf0e4kuXQkn0pFnJCGIf))FJXua6YOurfnW52SEcBuNXnjzWxLl0A)cVa0OIv)mXrE(zpVsMaAr6K24IMGbQBqywtBqQxECNzd(yqk40Oh3UU58tpdg6VbrLlkVFNZIMAD7pNA(d1Xf8(OW31empvW9rF88AgdqjyGAZY91(YJFoFOVpqEAc0)juEWVpGYe3yEVCsbrrwHe6xDYBmVpQz4qv2zjPeI6wvPzNHfVupCG6JB(bl(K3Zt9HO2Vu7YUA5(2CkKTtcSB76U0pjeR8(FfJSzWIbxt8tPt5LyG2WmQZ3wGrCWDmbv3kkgLBZ9d)BeGtkHPMEW9SJbNChfMEK)3txyNtSNPbEWMbTKSnpxkUHVLQz7WYrQIr(ICbs(y3xTiztSwf0Fup0DtLsr9zGq1NbuvudS6Qpd0v1NbIU(mqIAK2fAVIu1I9Tqsg0pVkKaPzuSYXuMffWR162bNdMSPuDJ9n5s9fPFU7RBSmgQ7f(FrbCsRBQTDCKYwUdnBAZYEtKeFk3yMvWzfIpVfA1ajPwn93YkEaHeazxqMo1yJSZPHHH6Da)2cbOWbZtVzu7PIe9WEkatMnRuSK5ZwYUwn76SFCml2S0CPuNZHTHH4sNBZaYZ9cOqE((WXQ7JR5KKLjX9YvS1kcuCvRjrtAsrTXqfykRx(P29vm(SsRzOPn5FESkTrSkUPnUz5A24wLlt2Sjrx1OG5t09LxIQdsxSj1NHdYtAyhHYQhCb1jiZm8PnVDp3siVbSRnRvkWRhZeZ8lW5kG7kj8v6YhNraSPk10QbuvMO(0fNHSyFMLbQN0JX(qf4)SUmoItPInmdN3HRc1KDAxQLJ2CcFHaWyGbzY5C3a)SkYtJn37QOvDHs2pRiVwPsHDs2)J7HoFxyAVcolWFIWycOVmKJjiX5y2Qg)oslXWIpVTGTOLprq1kx1ZpbWdceiMWwngqlAPzF)qMHVUf01b9cZvS3(4r(b5sTpuBwWmO9Q67pdwfYRCM(he1V7TmjHNEi67slCIoznEodMvCIZLvOYT)mQGOOdQfB)esSk6Ia4Febe5feOWzdk5WpV)2Vpo6JGbJE9gMXFZWXt5E)ndOCz)IGX4UYpZZrsLJmW3(dZDu7uJrDMeMlc1Z(Io3BuNrRJPLUVmKfneDRWOoKvcGbUNRpZOgXJpMG7kyY1QC1b7BBZ3BRH2ILP9azBbtGIsfK(gYjtdiTXSTD1Sntjownk(c94AysH5PLUuX6tbWsPoYw7uXS5YionpkvIY6wv5DfqabYLgut5z7ceoNe9UmrTgKMIXnXEkoPZOwiN5f1I13FwdqcK49Fui8aMvzomQF2VznEvyMLznSRJRhqwrPCNDa1cap24g90cAzr3YuBMIUtA7T1lLyvwH6Nup0o2vKulkmJw()yoqIuxucaw)qpwJvtLa4v1Xo8ECbLas4mauuoKsqOCnagg7tpqEWOgeKDdqq46kbG2saGOQjrSPbaI1gPM)qBLinFAWY4JrWb0YQU(W3Ah8siypCOV4Abgt00vvpLSgfZecEqsH2CUnJ(vlUOP7LN771PXKRaiv3OXTCh0KGDD6NrpQs1CeUq52U2ia8Bv7WBsBWWUXN)NbACjA6Zs(XBtJJwmo4O7ivMqKG3VOcKcznQGrzAJIwGsdXnMoVgeMY6kGA8raYg1)hOvpt4QrLC0q9DltnN9btNrknmGvqRGgQLlm2(wiwwny1QedyDId6alDNEI9c2xvbQPWtmlCLbpNn5ONaSNOFooH84R(Kl3HdW3sKBEjsHRrHmStGPg7HylwEPbIysoP5nDQo)mNzswBlyiTOgfPovBT8WhCgKWmPbPMTdc(HBRdkXkf5zS(vn(pQd46KQQWcs4ZcQZBgcdbkxwrtxwGna2UUZM21i1ybRnK5dYR8Mhlwav88YUT)PaIsj2PKCSgGgb6F0jiklPJyc4CeJpuWjqXyyAsKqOjng1j8slvOlytLC2hSUztpUd21EkyMyvFrR6LTpOQv7XVmaz6HSMLaOt6kYDaeXJCdnfM5ac0BENP5cQsrCjBYaMp2KOuRUMdGCvabO5ic1Bzkx7gPZef0Q64lRoNqayVBI(X4jffGMiIsr(sc5jtRrQFooD0kNbsuAjLPMW6bvnqqv7zJdewe5swMd6b4IsWaMz0GincMgosT5jyzeY86vWwcvlXqHHuM9RcErG99)tWA8LLFP9YOd3XnKtaGcJ24nKOWaKIRX3gWPp0lR)iONz3KJDjqIPxJnMKsHEcS55Yjwj59AVcLfoL(b0IZC4zEx3vz5YIYQDaKcmGaFGLuCkvj1GxEgehNKWEvMscjIHcVCIPBvVb810kZtoQtUJa7WtyCVG986cMnFUIHFhqmIce9lA7JCrmZSjNCaybIqpKZuSzCidbzvwrujdjIUOKzettexsZtyuNbR6(tnNFhWy1kTZUlSH37VOg9wyklYJbOlJkn0lSjdbwfeQyjdTA5GrMVsZY0BCHVHz6TTWlOM)pSTy9X2coSOE(sDXCPucJOvbQlIqwfOemrRcucc)i(kbGBeEfPN0r45dtN1NX57UrixNguvEeDH3)oCuvW(ezsrhKBWy1qKQg1LTKWrB)W65GRXmGe3WQ5xphvD9QvxaBIn3YMggjg)RNXYty167Mb5Jy824gMxtwL9Gi3kJanntuFeCXJ9ACetKsQSK2B1IZpfgoLP5IdZOCKbbXj0rgElJfP7pjlIC0DH9ZOhU0yB8eyEtJZCzW9m8UNyYcHxQCEguC5wXQ0Zyw85KinpMvDFosCoGHpZdwUmMvEtB8um1N3oeiM8PzFJrvUrdQSeIPi2ez6WMw(jhA98h0ASIjGM1CfloSPQLMZPaervlhM0SNTRke6P7T6U0)DrPePBDAjLa8oczdwCbrTsVe3rX6lhE5g00jpI1y1VE)38D3vjZH0oA4czAlzuk4RtuvZ5)Io5uDktwnhgmybma))OUyyDdu0OpgVX(kA7v3R5VBKkcTdMvky4vT)VrM8KJIOKrNEw5DsDwHiIxuPnxbSDJ(gi(civoYFP0Hu(WyWdZ9A03ZL1)njlBuviwSqBHUnTHNPz9LSE5C1Wz2r(ejYQslSRYZYbilUuiCv1JsO0hhCHGXF5sW6hukb9ghZS4bmJQ3yWI7WxaSjkROa(NSkc)x90KAkUYxLBL1OGWgMI8gjcQ2qkLXQdLlTbsM5fodYyVszesKMPEjzceFZh2mBbS3Ba25kbkzJfbMknoOOF6xbsbXIs2U5rPv3mqZRFLHfzKG0ebTECsoEivXiJudIEoYhyN1)8EOJvnjcZznoaoldl60mcTjtuftah4L67LrKslVTsFp8Cyq2(2Ge7)L7rFuTjl0YykXj5qFtfxceij2uhYycMBF45pIdahIrX7YjHXCO9AvW59kJEfY76cZwGy0XZ9L6ra24lR2xImwmcq8Raid4WRORQqDrFeggmQSxF(aUj2cmSjXiGmq)09n6ElI1uHpVAcGpCs7DNLLQMqMSJPxTMAGWTMS2qebRdgCayE3496uvR60PCKdFktW0lg2UUBt7QAMIbUzyB10XUz6uJ6hc50V8SJwNC9nLsKY0ByNF71OQsfiMH2vi17dTRC4OAfgSA1DR355QGsUYQWbny2a2d9CHH2NtjQfHHIys9yhzsAVdQyQ8WUkgBnMrJvYddsoO5QUv1mrZxj(Gjw(AiOshf7eHow(PmqPtmxmiCzqZYldFcFLMDM39cMxovhGRFai57(VGO6N6gRuCrQdT)Nj5OPPSOZ1qm5cMNWsuru420SwrlVilYB4hMjFPEMCBSsQaIgg9WnJQOrVi5mzWdrpRFguaAHSg1ksUJwivnqvkmoZ4fp0pRy1wMYotLMfYLmJXpbZNAFJsYB6deAD8ciPTI7uz1d6q0UY2fUOnu4qBPRWSQL8f)x2gxuGNrFqAg0O5w0TLZqffxPC(Rph59bCMWluMYb)IQy6ZBRqNp3MYKOWoTsoFofEj3eEVDgYT0AYL2DHw)5dTd7IS(93Ink9T(2OeSJaxTnkk22J6dUiLet6anf42lYhgCLU6ldXzDoPYOdt8knIC9Wf6hNp3ajjIPuS(OrvrsL3jvSllUaD0BeeIEL2(dXPT(QIk1wzWcsBI0OltrCje3sJRKMcgAsyDOd2FRtr3NwHrLBKsHBuVQb)mhSwAjALVW90yVdK46e1Si)k2O7qdCODzeOWh0ad94PsT(mvAV(vKJdiTATyN2vBl8P8IhgYq9AtW8(uYa9JTvHd(ZmrNbfBSAfsrCZ(ZBjJ9kTioXBdiA1iMNHXRHxpRsmkl0tkIhHUKZ4fiTG9Ra7iuH6xmUZWA10P2bcw1KtfAqZXV90sYWfkLV1ylT8FG9To4j7bsPJzJ6LL)c9cGmH5)L86h9Y0El2Z60)6s9qXUcm6kgnQ2Z1V2WAx1F4YsHRrL3Qsf4)ZypqLZYuoK1x4nRVyE4vLsb7i5T3Af88vzWDe(MafdmitKkbTMeMmvcQo8SJtFGMUsP0Wox3KGIuyi8HyTNaqmT2kBqv8TEulqR4Ctkrs4CHbbzKt5qXqRqOg6yJjQuzUlK78d6L8upejRNVjJB70fSFFh2UEDZsUMLthAF3glI9ABNAEhGw8ADz6LhAN7CNBLE3LU9xVPrOLBwR(EFHdCzsORvc5CknRbvRaTVzMKIV)I9ymnALOroM4FDY8xdNZPXWR0meyxm6TQ(zKiCy4DKSm6RAWlxAMYG(ry7UbyJOC92S5X9N2Hk7gEBuPRrdT6PiQBRVXpqyHjQpoEBQqCyT0Iy6Vydbty0h2uzsR52JoXf5(AKKvzOIccyFn6YINndC8yrbTwGCH3uojLUM1ju76GrMFa5(wrZQRUvp7jc3hGG04nOPso6spJAQgNwV2YoONB)PvSLbcMqxmtwrbEZv2YPIQnTvuWNZfOFQDErEUgN8OTujJjSFMuXygPUc(I2AQKph4dOHGgWTPUfmznljVjz1lnOTvRBAXepxOxtTnsSrfl6SyTpb18KXStkVjo(sWq4AVXgYQQAPyHkta7krIXjreMBbytMOlg7asSrXy5Hhobsk2ODosDYeD6KR(g2Agv2SQRWP0mlSvWOwXRkrGb9bJumL4d6gsjZf0h8lA1)3nrdHGYEg0KOFH9So2FWk0Rnip4fBslgBlYXejnCpIHJlVg)Ax)CkRiyv0PE0uyz07641l8b5LeJ0p(9ImM)I8YukjX15QjUJJCDNle)6oRpCV6My6nsjYCKtCn9bPtHSErAKuqsrrxwAHXfRuXfkNDRmH)2mNANK36OXFWPOEmsmLaIZl83ssxSycB0GlHgp)Us)lW7RcIRI8nwbMfjgMSBCr0pZN8znMnRXm0GJe5D8kqcxpdRZWp)mFHRmyc0fh1mKJvydn1tsa8L1RCs4McOBUKkxf75GiV9Z(2Exhe0vnXB7Gvzx1)DOpsabPEGgr5C1M2ev(vPFjtY3RujFdrf0kPAMTYHYc79cLXZu88StZDVXB)wi8wyTSKsaBmrROkRBozrqhkxXwjZi0SEXU4PuePgRSqjupMAVa)OpL0uuTZkeSv0MhYzl6hgmPU1qQDxW9cXXi5oxP42p((2wNUc3EqlS55ABh14(aXqcqv))vZwsIJIs2gsI7irZRRT0IdisObhmSPt0EysWf9k0Or9Mk3J5SBG0MJIpLJugkdG3Ma021s3x(mK4PsTq9q7kxaLMA3TCMbY1W21mNOEebyHCm0jFcv7ZW76tsQUqis7I0h9cqZy4ya)yvAV2nA1yhwfjBoIuuwlZZzfM0SHzrxKusPzPp6sCO7qPmWndFxD50P(KzCgcVhV1rkSRC)8rMkkO6Nc1EMqnqqZo9(6EBX5PzG1OgfUw1mTB5sU0sudXbNZQQj7mRennrnu4z6H3H6CKa6aw(myvZMUAH6Wrocs3jnatzAWsLmB4gnlsHY2eu(fiwXPV0dw47KP7ntuB5BLeymrzlmKdllz90XQ4a(nY91CLCTcwA0WUUk44krdyEuilWD935fbB0IeSY46UUVvoVb66L7fkX(NuX0h8kYGGjrvyeXZK0EKJ5nwcFuBhCZqPx7y0X)sKxW4RM4YPc)HLHq0DQ5s0jJM8Q44TkYBtNmkLtwluJASSMOlVJIi6HCp3PFF4lld(S5DU811zm8zpAxIaPdKVUm)ENTV04pkRXRzi0HmBWb7DuYzGqMNWyZughwh67FDf)cQejgLuZUmzgMf9VEFvDm3Uw6SHoP5eF(Ip8HPPxNWzKx46KZp5VsIpCKh0TRfcoIWKl5KQO6XdRExI0fn1AXhF8ShULRB0uOmK0x1AVuJTvNoSUbxRd0ys0NrUwJ0CKGTAYA3Pttjk6kTAsyiCxOUO9zDsKzDrwzDxizvjDeAmJ10iERlJ6TEmYN0oCt4WmShnbticaA49yGHTPZeB08iKh9ZMiMtRj1blIGvOIhPe(vf6SZPAH3(2yS9XvTGRK2dl3QMYJXS8T(MLEYT4VQMfmLuDg9xjz(l7o2rngHYaGKdUbkQcAl9pkiF8rAFUBJtY(K3W7eVqtUuSQ0(v4r4VhSixOSP7tpG(3RuXczWDQKcqzndYNN2Qe)953rwrfZZlAv2DU0Hszx0DrI3(mbFNczgTvJydbGqq75BiPtgejUJLZy2L2VzzfSaIMNqTyc9ygPE5aFKPyYJ8(N3xkWR)vKoV3)oPHFBwrMWn6YUq3eRcDwuSBvLZqMONcoVx6s8AS(D6sItWl6Em)TJx3FkbPJ33L3Hfc654wvSqQPvgsbk0sQu3FqGKeBriVWa8zojLWAPaIa)cdggvzipUPq4msYtQmPLakIYvUdF01nSFkcixLtabruqOcJyXVWHpinpXEXD4l2gCeKkDjQnNj72qmFpsNHq4nMwVg9XlZg0dwqU(LSEzH6JshKhPJ38DSQh1WEydkUvP3GXaXV7H1GiDOqZ6qWDGEqXJsE7WZzwA)EhQKtCaZMvl2GtHaJDg6o2EvWxdwB6I1TQHk2dXfzRXQnEzsrd0NqN9YS7pFBq6VMhudrEtoigtg1lT7(JSAWvDkeuFkeuHO21HYE)QTHFhFsBiS7fXAKABbnvxjG9R3f0xX5OY0iYHbojfcsC4VGbNm8qVF3y4Khm2N4HmYiXpIZNu1BXRqR(C3SZII8aYrs8wKOabaXl7h21ceNSh92)(WFB0bielKw84)UbJ(KglWpnrxdnt1xc(gzJjQTtVavGRDZmvJ0oaH2lDmSU26aC1JgUyDxYYDs5z8rNsKAtjtILlNAUoteGjxW4a6rZQosnecQbxpRa1f7gYXNfjqkYT5O7e1TXWHq(0Sl4109r9O5v0FYqxr5DVvW4Ye51mzI)wFuyF7feIn91JFPSMcLME1fknKwanNGkvcMLOBsU6E6Mgjrnce20lRzFcPTruZgyHCZemU9bGbEMO5uwVQ6dVa6gWIeNe7kQWMaT2Jvc7RHIWLwEOvqxqHU6u0wyWtI6TTAeZiK(maLAtuDBy1vBJpDOnYnpMUnDLUVNWHg1ngNUyycT4iDdYX5gfz0NZbkvX4eGle1yj4g(tEwTWvJPPKSUHs9vK1m2RHBpQ1fUvVEIb5jFigGN2qA)syK309bOKLHNL(aRYIHYz((YKPh1Atlw1CvMFX1t27y(AV2owe2q(mXvbvhtCb8DvQb62HbOEbnFI2bJryS)AAJcg6U6MZXjeaWlGqsYm5JE4g4I7Q8wTdlMQ4bmhHSXRtJB8A(Xo8p6t8dBd8lBPwr3sZLof550pt5nKzlErIkBihAxe0IB4j(dzFPn492iGYDddUjT8zVDSKmgOOqT4G6IuwQim3V3En49hz7J)Kox8o9Wu6kF8Tr9bPIaptC)BkUggObx1t7faQHGyuNFMLJfXfHrJRCwoKI1m0b5tmNP5brIsOQJ2DNzs3HojExAk56uHOHrVJofjOi95wm1ubpY0f1t17eJGwLiDkzSoMKxzNVJK1mx(AChXRbS4qwNjDU6QSZIU9Mb3sGSYfoA7BD5fx4MS1yx5j)S24qsPpvJ0AIUJKIg)sJ)P9GLhpX4f68FU3HEu1V4tVvNl8aYE2pQ9lrOkY3vnuIRGI2BJIUG36VvC01KgzH0nTODbTN0gYV4y4bUWj(k)dm(o3(cl(KpzLV6sD(G7HNrd0ICbClYqbap8lU9z781xJUVsxCHh25khzXN8o0DjdKkfSfx4ml(4lt3DUqEx(wFdiaIrplhNlEPen7miPjIR)GNncnBXOWuLMnuLSVDdjD9fzUCx1o2w0d5koJ)dvgQ358XwqS9YSY96VccjID9FOIZMY0N2pyPfu7K4DuFcRPQRTXCVU6x75QHrS5wxfvpnB)8vDZNufs21AAgN2)m(xLjwrosTFG9YrRYb4VQBWXidmcTlW9AkMcwnXvqmXwWQp(c6QOiO7IKGUmAcwTboW3cbpq3habDvqe0vbsqubtGIqP0xGvXLqQw51vTKAEnx9G(YPk93Sg50qwKfJCQ6Thv8c0YPwe)AxjKVkWGSGFIrH6odBF7DU5N2(k3GNDf(WP876UfAeh02TGiPN4(fHKOts0NX66eEyl(bbICQLRT5yR9oK6VaM7PklQ1z6G25CPXO2yylAAX8hfpM7D5KVd9uLBj(FDZdk6nIOSZ0dyJTf6W2nK2yoyJyNDhApe6LRTlyVhFOoUv9r6Os60h2yx(3q7Gup0S1TfDz(TWENnY9pRhHfEl0Mqtn1e)DEl1t3Stz5wYhIZMQxEARgoAw7hX9fR6SU6Qn0y2D1xlSdqJgANFX(99GbdnSAHaAclBRBvQO4SMvDYkmaVHwxL1qXz3nfsVTGSXpb3eNKpIpLX4z5VqReJtIqbbGUoaEx7vSv5r3ndj5apNvTt7lLML5lD)TFO3DGH32dbtOS3zrjOTJ4p8vxSbi25GO7J9AxFGhXhmhKbxO03VSvXQwUqTOQ5bW(TfOvVPNVHj9PPAnd9fwkJ8lBz1agYoRboQrRMSn7kKAjCRgI8fNwZ4)8mwGep98JcS4yuKZbQqstoH1XGgH7IQHn2ajj5TRnMGhRux8TtUjits8S3TnSKJTHbu28Q0RwzIqOtOnH2CWieIiqqtfzNGzKQozdbKk4792RXIl8OLU4Px5JVo5dkJVg2H1pjgcsr(HUQyz1Tg54zRpB3wmTznOM6AMsZMMmD49I(mZUtRQKZimU7Hjy4ccQdEcXWSnrfJPcVfPXBS61hSG371Edj7FTy7d5HxD7J01HTqQmkuFP9lFD9JxaMsbQKANWjf5jzugNu9fXCl7U4aK1RuosUI6IzHscwQtTlcCMqIFc3NFDt0Wrlz60viNXjYBhajnWbkG53KeERTQ0LkbDNYdFx4AKGTjpXo4I7bwNG4Pl4B9l(rEDfcH2MMWNPspAcghVt9vPGviJMW9SMNEIGy3twdsOCwRRJ)geZbw04)wUgOyHEblja9OmKZXre7Yt8QVmghorhk7CvG4JYab9(rY1jh2VFhX3HP4qz8Qz4sHCGwoSiC69ltSCYCEXCtxZSLJPgRAM6dFJqLN0h2qq0kOjYRKYagtC56p(aWkbvufXh2Qk8WeDWT3DKtu7VaD)P5I(lU)4kvDBbdFaw7NH3cRbuOyRi5vwEeiq1OVnieTF6)78bpUgnksHQBKg7vjgZ6ue2VkdQvfWrEymCsdP7pF(iGv)GRSlTLnfPv7HWx4JuALCjUZUL1gls4qG5BnRGpCcksHLMiRrUNlI8OUzuciU2W(giVgaPEUgQv5gqdaU2UfRonvFxUNttXfAZYkrlsDeJD8rAeeQtjBYpUbJEGe(sj45yg(GDvzYyBSaOeFPxoCWISYaE3pHdYOgzIIQT6fzOEft(iv2igKOkwlcnQidlwLG8Zc5ju9kf(mreONRhb2FscU)4QCXK1KRT2dsPqpC1mxDER9JwnLKDcXnF91R5SV(nV9Kn3DjnL)fYjJH)C57dV9tF(nkNS(ra1UBg8IMNTf27qQMkyGmTWC(umdKKPCnMn5IQzreXLrEut1x8cDuwGNKi7IkVFTxezrF18fQWy4tzz5FZsgrPf1UeATmtB5g1U(AAPRPQKnt0eqxXD)1ejLPxQwAFRXlKNmLMsyiADOjU4f9uftCQIQ7sKUfDIcHRbugTkNez4DYlmf6VIUrEDZ68U1c91JX9oCclEzR13ym5tNI2eB1ES2ChXsKtoYhJ6k(vYad3v79nTRs38UzfajEz1OkE56YqYl0aM(X8eUANjHlHNb3YIRyqSmK9HsOaReB07u6KGKztBkC(rqnjIgqneZlQWf0oWCjW7t5(ZRgEb9j0bp7)5vdkU6YuF5PiAD8aApTQz20QKcDjEqmEXdn08UMoPFHWPhVXmM(HifohYngD7M3wmjFcaBeAtgIF1mw)bY42PmPYQBp0KjgKqC91EBA64iIfX4EnryHp78BVL4Ym56uXlZSxJTaf3uAb5wkHi0PNK5Zew(M36mVH96dfw1zID)GQL(hibwqlio4hVIHmpMP(JMctbiBHTLqOlgTJ6vtZs2lVPS8hCbVUsRqgCbWE55lHBTWEjpMstjif4SrOrAMq6JOsA8QJ23O7TyDZQ0eIxN0mkvGKpuSAmJwft4SG6VFvqN8qwgGxDKOpJ7QyQr06oKLzCvvh87hq6DM0(TkKJWiJp5gNgqzIiMgF96f1uT9j8(ogC(QcLssAXY48k5iufjgVJzIj7EkJKVtNYKK2RCm2j(J24AP3En68ENzXNCfzhSGjCYl1(SFsx2LHNycitQKsxD8msZI)22vDUEX5SCndNlMSF5eDAHoJKrv(tIvWlk4P8eoXw585FXGtyw89d56HpJBebqmOYEZY5IZivAE3lzdZtZhxIzWt0fH6s0sPr2JLD2zj1xDMOgDL)42sFwIEmvbXxmAKfv0WlrU8TUt7NCX)UtIKnhzr5XneT8iLvTEipgTeLqRNWzgNyZyKIrJXNVUuEsoVssx8Ip0Tqb9IO(V7eIc7ZojjlsuurcquJFIXgZTXOKU45KF7lJfPwl69DsxQ3Yptjust)aWY(4HE3RWj4h4H3Xht1kTpJBOndOSdzbqsIViuTKj)TVeEC7)TvVizLkoMUERMIqVJnXToTDLcsXDvu0Aidznn)XRrMUs(kP6b8R1I99vjqQYpu9hwa9)F7DT)BCCuhNO8dfDIFkGqc4xoDqW3Q6CyFoNtAujcF(514hHZ2XfffUEp2Z3ME(2JBVZXoOGObkL0cQpqO2QYJg3IcGeuW84hAGGes87wr8Na2o9x7FbmFNz2DNz2zMD3Zxcfb(hoF3UZ757mZ357RpSQZ7DE(9F3x4G34Eh(UV)dx15vxUiMz5Jk42FchSgGRKZ5BmLyXhjV6eebDWQuo3LOFNlNqjYWMx9WybKZ6d0sogB7TuZUOqbeyl06AoRMKbHtO7xf(mqu2dNK27FL8GwewWz5gw17EbZTXa8OgL4rn93zXb6jyofLN82L7uJAtG6v)hiIDSaTMa1G2er4dpiT3tNSHTTJzE7TMXUd4NjPnmIvCeZRGkGrZJ5r0cy3nqILksC6(cotI2qTJDZi0ZNceT3QTb)yiKc(HTA0KyrZkot3Zi84e(fDdRS6v)syfjK96zzpa)dU7R(GBT7d(o)GdEZ3lruKYgUIsLFIjVWSfxA1fz90lnICJ(kSccClPrCDGXrYKlSgEMk4W5M5wCSx)w37G3(fucQWuhy5RsCzgIUjO(ptax(K0x7FZoJ2)0OlRbU)sKvU1Oj0syTtcpCmE0GPxMcsz(fVInfYua1GkEiO7XyOtD4(nFjMHsWbfEKP5CZOsJOJ59Ufh9)kt0K2ObT0JKbRiRNa(G8nHmGHuiSvR7sZDJWOITQY4macuZe2vo83CRdF)7itDFz1PVVquWxwPk4tQKJHMLN9vqM5hvilyoGXoGMKxWrQf6YACPeqNEKrJdV7RYY0PVRPHO9vgITdDKkcJwJgd1HsgUeygnO2oX9Maq3ve8wFvBhshm0QoupIQ9FLF4H353fxDi3xknwUKKOevmSJMLFeRltOqGx7e1f4dMvf6muJOd2p36o9QKo1jVmQ4tLYW9NxH8tHC9u9C6AvF75sNc3efBjOnawRt52I6yv1YA03weUXUeczaMx)j3IZlG9cBT0tOMeTzFxzpln1FlHOU(iG)xk5LuNAKKevRkiBSMv22QdnrXvwBPIxyiPk3IyNC5goPiyiXDcWqWy4qOwcQ4C)kEwene22SM3fEhzGRdoftinqm8xJO)q2DzLU44WF)D3)N9s)NAhx(fi8NKYRyvIuoilegDmU7JxA2lZ6RVxrA44I6JVk2(KF5eJNehHylNF(c0qGaeqsCacqDrkexTuSlAQukqbqTRM1SGv62NCRC)2V2d(T3(Gx)pFWp92cKhoImlcqYBpN8L7iHvCNiULippwoAzWI)jsYjZf2D0DzEHS51p8wugvEvvvqS2vfMx)Xfs5cwO7mT1Lk3SNPd(mWry9pfNyiSRkLH05iFY8w)Q)1F9nrtMFWR)hfVXGlGmr9jc9R75sD)CczGcqWEkGPxpH2KJBMnqw1ebS4gze7IC)wuUzeZXsUeZaiA6AW25GJh)eJikYxSugDFF2CcV2d(xYYDfu2qDxFlGoz(QTxJL3WRKlTo57uiAvZGskglscWbl)jwCLUeZ7JGWOuM)vBhzzVnyy070Qpkt6v91UHSp8ud87q)kI3Lusqo3bjmClDzrq0ZoKdH4AhEbEYbtJGZgqypHJmlkcr5CshIxPqmPmOGKuM0aNfYLYnKgNOHvV8ibCSwalw9HSiMS)rylKfluXLW8hw(r6LibJCkStjYWvE5ZYrhQ5fP9IZY1OG88HT0EWb68sLHB)J87HvChbiGxVhcnGBZdCaSx5TcaVYpcWJEFtrekYORv0(XU6uTIkAruH(Kk8Hdb4ddAVh2KDgHgmMJcXMIz9NmjHe6GF5T3)V8YjppmNlF)qU(Klm5hYHSSOPVYlB(G79J2)5)fhC7Vx89Hbzh4PwvfA9Hbo)xqu7xf9KbNynY)2X4z3wWhh0EqTYBdhQ3pO3ZhmzcnQuoYsefpIiCVHisoMGua12ir88lbEy8vWOmcwe47kSwdtZMbBf(Vl0grWmlO(946rddcVzGNZ0Tv65iy2tF5yAxsqjebZWN1mF8V2lVL0RWUkP1ahxPc30pcMbLDZAbTJ3WTNPyzgCzmLmQIECPUKyeyQtLsM1r5Mc125wGBk7JbXsUKS0C7FlzH8YEbzT24KF(IJP8jGwYdeRq2hqN5nrlGa(fF7pIqaltqj(nCgPwnY)vsk)4)Fs5bkPCqk5(XkrJfXSEH651Y0XOHe3PYnHCBBZK7tjkxcbtxwIfI2VeRQmLoj9tg2fIHzFQLjJyjBNkIcQro8RgiodjXHOcZcd1qHZ3FIMLdgrBVM6Tt1zNFc8mE2ULYhyAvCZijWT7drMbL9n1SDXpgeEfV5R6gCCn8lmovrpNT9ZYfOD5V8KSuiPn4fAMzIG)flBvROTdAKhhkHniVdc2qET1z6yVbKm0ltWfWCP6Fik0BWoeW1juF7NigexpcrBCFfRXp65BETl3fnnuoDukc6ikRamcuodnhQDpepHcort2S8gTnRTInI820SfZ1Hen13rD12g(fRy3gBsoIzyb7nXo3PWJjGqACgUUmBiwhN9uxbJlHUMxLcRP0BvvcpDERl4Jk5zzKsyRirxoRiGvYiSzQOkuKvdvtCs84p0GpyhmUtbElFOdctVjIGwovVbxAoxrZ1TGLy4FLo1KZnXkLwy5zlnXutT0IHKyWM6UyPIlT8ktxS0QxCQjwz6qYXfNFIVgkTtVikhfwC2sRTuX5NkK8SWstvyMcOCT8kOkOeQfU4Stpvu7haMcuA(PNyQPlkMf(n)HhjbzT3eVZqMmz4eZUjz8fX8NWaMkdPPDhZ6wBnCYnCwFyWpx7sI16oOjn85tzeGmbqK44SaYmpaSlOeqmyIkDDwhIVZDwpl(ZXWFEA8N5WFoo(ZZG)8SG2V72XPDtl0GXWPOTZZkcaW0glzF4Lxmn5jbr9vuDJhC4WgcyLLBph)wmCpixUU0(GxqWNbLcGUKYOORioMc9CjHAY(mAS6bQjaEKvJaKhXjY9luwkHMePcehdKiFz9OHN4FUISJcplEb8EzZBY(taQbIJ15ZjFvxqqjIn9JsZoKMCCaR8abams3XN6gM9O7D)iH8oi2olN(w9IHtRkXEqGaF6ZPk9(kfeTtIYgqnscoJIeq9IhydizkbI8Apvg6MC0zRsNUguy5rWUCcnXcpeZNi2)rKL68MekBOUOocIf2lv4Ia(W4zcQgHeKr7stmiVHu62uHWybQ4zyHc9RmLLXdJM6Rst(asV0qUhzF0zY7VrkID)zY3f44lQX0AuUrZX48nA0JUZDTWo9tAu7eB)sZKpcbXzDHpqLfEKk5Jq4HwYYBgauPql0zeTcJgjWKHfz2a1bI00GVjAHQ9a0mxEM8xHS1nfs2XQvhOiLaCQsMHXLBmMz9P0jgakikK3ANp4h)38q3yOeJuHjhWigKtF6EhLbn3EuS8UnFscvSIee)CcKiuUrdJaTKRjQGUVCi(0wORuuxQfMknlo)e1UQfUKSBHw21ZCPw42ND5APdjMfk9SeCzrx)G7KrjViMDHBj6Hn6FZoDh9gKqgaeaJUZlHFqYt6KK1YTojI8Fy9Log6Ge0AyK2JpwNqqPhqmW3eDHDOZalrO51i5tMmBUCrB9hzGqOeos7Sb3aam6xxeKdFVcmRrLwBIIlIUdykLelgXMJmsWs4rdlzhHlrO7sdqBM9sgAN3ySbngx1mmNyk6o0ee5bv4qtACUjp7rwI1WYiadq1LHuMEHSiYArCO8qMX6OWVOgvwCvvlJD(coM3IPdjOHxhSG8Wtezgvsq7IpzmsYn8YKeipclDAJZ8XHtwvRR5288m3GDcd)GK4DlPEUVrqSEmo7RO8fKWDlrUSfMA6zkoXctxALclmDOX)2a3Jyv)ORA66ABMgj6JRI2px3KtW3k3CdEmvqnFRqnMYJWEyPz2KYGIPPERzc87ZR01HKYcAk2oQpuHQedr9cveSpIC)xjqrQ7F0uMMPHAWucP9WIw0OuQucVcUCl55QJ)bXdjv7sSKP1MRWYxC6IP0lUJ(Hasl1JB1gpcO)NxqgpQylq7ANJ4gns7hhDPPyOLy8sMDCSaQFZQpB84ulUau8cBJQl2TrWjAtOvk7uijgiQV0(LPXdvI8hDYm0(CLxo9NPnokiAQufJslzDWtQy)qUEyc2tWGTYQT6enT4eSJL9i0TcjqZtQGXIwfOsPXrFetHwOun5JLMi1aHKOBN0U2C88tUsX5tbNK4(KI4NOy)wqAk0LiJQnS94feJkenyIBzCi(XbX0mRFBIFYxQqlN2Mv7MkgNePs(b(vJuC(rlsEkoJivfFkNpW3SvCMG8UR3Ox5wRxX0Ayaw)UkyMpx1QfFhqrAi3w(CiwFR2inW674uwFp47)k7)I)C8dsMoZPmC)4XnKGt8ioPs7vb49cj1b(Rq1OGAiwnQh8hENi3OeNhE00iDvZ(Y9QwfTFE9En7VMAF1mj6CQ8MMi(zxWzD)YWireoUvSviN2jqFgDrP)0ZHMBixrsn1HFjOFiMVc(64I1DuDMYwnnR5xtFHWhidPAhCdzuZxWOsDex4ons0(ZHygayLahibj3TSuB6xkcWQwTBwheVH11n)mvCS71PQzfRnAB3P7hIJfeTk3KYGX7DFNgLRzFTNEjC4c8438A0i0XnDdvhz7zvB3RVwNVXCRBuF0XxyN6wBrd9eF3pXoWrF2Ta(sYdmOVRvlsRa9We7uZ0PCxG3hZg7u1Uf6c7GLQKyhNEvkIZNZN9tV3jUp6Nv8839DR7BgohV9NxAhf6HLA3XSQf0foENTin(5(kBv8x)Xq)9HOl93WUdMLsOPvz5jb3AR9NQQTDtuNfBLyUMbBJoxL4WG5bBBCNU2v3Km08X)hZKYQw7p5tsK4)5j7CLCZXYKTigIgoE7t0ZXCsAzUGDTIOE6ZueBUVpx7VO6MEtZ1lxD7s1BAB3Prf0itDR1t0XQfuXMnYFDB7no2UK5fSKAEQJDSJD8DPLxbu6Rm6yJDMZE6B62FEMxdSDn8O(47n7m7DI9Y(3nl7adJMTwVBJh7(USGIT5wuTatho3esdmaTx28yeBfY4Ex7X2BR92EVRJ(6cIp5eovYLj7izg)eB(pF6)9p
    ]]
    -- 更新记录
    local updateTbl = {
        L["v3.2：支持英语本地化"],
        L["v3.1：修复了输入框变绿的问题"],
        L["v3.0：修复了拍卖框架的一个重叠问题"],
        L["v2.9：匿名模式下团长现在可以无视匿名。重复出价时现在需要点击确认框后才能出价"],
        L["v2.8：现在点击折叠按钮时，会重新排列位置。缩短拍卖结束后窗口消失的时间"],
        L["v2.7：手动输入的最低价格限制回调到之前的数值。优化窗口折叠效果"],
        L["v2.6：拍卖窗口刷新时，不再重新排列全部窗口，而是保持原位不变"],
        L["v2.5：拍卖金额超过1万时会进行缩写。ALT+点击折叠时，会对全部拍卖窗口折叠"],
        -- L["v2.4：3千-5千的加价幅度改为100，3万-5万的加价幅度改为1000"],
        -- L["v2.3：拍卖框体右上角的隐藏按钮改为折叠按钮"],
        -- L["v2.2：按加价时，可以直接把出价设置为合适的价格"],
        -- L["v2.1：如果你的出价太低时，出价框显示为红色"],
        -- L["v2.0：重做进入动画；按组合键时可以发送或观察装备"],
        -- L["v1.9：增加一个绿色钩子，用来表示你是否已经拥有该物品"],
        -- L["v1.8：增加出价记录；UI缩小了一点；提高了最小加价幅度"],
        -- L["v1.7：增加自动出价功能"],
        -- L["v1.6：增加显示正在拍卖的装备类型"],
        -- L["v1.5：拍卖价格为100~3000的加价幅度现在为100一次"],
        -- L["v1.4：增加一个开始拍卖时的动画效果"],
        -- L["v1.3：修复有部分玩家不显示拍卖界面的问题；当你是出价最高者时的高亮效果更加显眼"],
        -- L["v1.2：现在物品分配者也可以开始拍卖装备了"],
    }
    do
        local function OnClick(self, button)
            if button == "LeftButton" then
                if not CanSend() then return end
                if not WeakAurasOptions then
                    WeakAuras.OpenOptions()
                    BG.OnUpdateTime(function(self)
                        if not WeakAurasOptions.loadProgress:IsShown() then
                            self:SetScript("OnUpdate", nil)
                            self:Hide()
                            WeakAuras.Import(wa)
                        end
                    end)
                else
                    WeakAuras.Import(wa)
                end
            elseif button == "RightButton" then
                if self.frame and self.frame:IsVisible() then
                    self.frame:Hide()
                else
                    local f = CreateFrame("Frame", nil, self, "BackdropTemplate")
                    f:SetBackdrop({
                        bgFile = "Interface/ChatFrame/ChatFrameBackground",
                        insets = { left = 3, right = 3, top = 3, bottom = 3 }
                    })
                    f:SetBackdropColor(0, 0, 0, 1)
                    f:SetBackdropBorderColor(1, 1, 1, 0.6)
                    f:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 0, -20)
                    f:SetPoint("BOTTOMRIGHT", BG.MainFrame, "BOTTOMRIGHT", 0, 0)
                    f:SetFrameLevel(310)
                    f:EnableMouse(true)
                    self.frame = f
                    local edit = CreateFrame("EditBox", nil, f)
                    edit:SetWidth(f:GetWidth())
                    edit:SetAutoFocus(true)
                    edit:EnableMouse(true)
                    edit:SetTextInsets(5, 20, 5, 10)
                    edit:SetMultiLine(true)
                    edit:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
                    edit:SetText(wa)
                    edit:HighlightText()
                    edit:SetCursorPosition(0)
                    self.edit = edit
                    local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
                    scroll:SetWidth(f:GetWidth() - 10)
                    scroll:SetHeight(f:GetHeight() - 10)
                    scroll:SetPoint("CENTER")
                    scroll.ScrollBar.scrollStep = BG.scrollStep
                    BG.CreateSrollBarBackdrop(scroll.ScrollBar)
                    BG.HookScrollBarShowOrHide(scroll)
                    scroll:SetScrollChild(edit)
                    edit:SetScript("OnEscapePressed", function()
                        f:Hide()
                    end)
                end
            end
            BG.PlaySound(1)
        end
        local function OnEnter(self)
            GameTooltip:SetOwner(self, "ANCHOR_NONE")
            GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddLine(AddTexture("LEFT") .. L["一键导入WA字符串"])
            GameTooltip:AddLine(AddTexture("RIGHT") .. L["复制WA字符串"])
            GameTooltip:AddLine(" ", 1, 0, 0, true)
            GameTooltip:AddDoubleLine(L["拍卖WA版本："], BGA.ver)
            GameTooltip:AddLine(L["全新的拍卖方式，不再通过传统的聊天栏来拍卖装备，而是使用新的UI来拍卖。"], 1, 0.82, 0, true)
            GameTooltip:AddLine(" ", 1, 0, 0, true)
            GameTooltip:AddLine(L["|cffFFFFFF安装WA：|r此WA是团员端，用于接收团长发出的拍卖消息，没安装的团员显示不了拍卖UI。请团长安装该WA字符串后发给团员安装。如果团员已经安装了BiaoGe插件，可以不用安装该WA。"], 1, 0.82, 0, true)
            GameTooltip:AddLine(" ", 1, 0, 0, true)
            GameTooltip:AddLine(L["|cffFFFFFF拍卖教程：|r团长/物品分配者ALT+点击表格/背包/聊天框的装备来打开拍卖面板，填写起拍价、拍卖时长、拍卖模式即可开始拍卖。可同时拍卖多件装备。"], 1, 0.82, 0, true)
            GameTooltip:AddLine(" ", 1, 0, 0, true)
            GameTooltip:AddLine(L["更新记录："], 1, 1, 1, true)
            for i, text in ipairs(updateTbl) do
                GameTooltip:AddLine(text, 1, 0.82, 0, true)
            end
            GameTooltip:Show()
        end

        local bt = CreateFrame("Button", nil, BG.MainFrame)
        bt:SetPoint("LEFT", BG.ButtonMove, "RIGHT", BG.TopLeftButtonJianGe, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:RegisterForClicks("AnyUp")
        bt:SetText(L["拍卖WA"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        bt:SetScript("OnClick", OnClick)
        bt:SetScript("OnEnter", OnEnter)
        BG.GameTooltip_Hide(bt)
        BG.ButtonAucitonWA = bt
    end

    -- WA链接版本提醒
    local function ChangSendLink(self, event, msg, player, l, cs, t, flag, channelId, ...)
        if not _G.BGA.ver then
            return false, msg, player, l, cs, t, flag, channelId, ...
        end
        msg = msg:gsub("(%[WeakAuras:.+<BiaoGe>拍卖%s-v(%d+%.%d+)%])", function(wa, ver)
            ver = tonumber(ver)
            if ver then
                local myver = tonumber(_G.BGA.ver:match("v(%d+%.%d+)"))
                if myver and myver >= ver then
                    return wa .. "  " .. format(BG.STC_g1(L["（你当前版本是%s，无需下载）"]), _G.BGA.ver)
                else
                    return wa
                end
            end
        end)
        return false, msg, player, l, cs, t, flag, channelId, ...
    end

    ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", ChangSendLink)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", ChangSendLink)

    ------------------正在发送WA------------------
    hooksecurefunc(C_ChatInfo, "SendAddonMessage", function(prefix, msg, channel, player)
        local done, total, displayName, ver = strsplit(" ", msg)
        if not (prefix == "WeakAurasProg" and displayName:find("<BiaoGe>拍卖")) then return end
        if not sending[player] then
            sending[player] = true
            sendingCount[player] = sendingCount[player] or 0
            sendingCount[player] = sendingCount[player] + 1
            if sendingCount[player] > 2 then
                if not notShowSendingText[player] then
                    notShowSendingText[player] = true
                    BG.SendSystemMessage(format(L["由于%s多次点击WA链接，不再提示他的相关文本了。"], SetClassCFF(player)))
                end
            else
                BG.SendSystemMessage(format(L["%s正在接收拍卖WA。"], SetClassCFF(player)))
            end
            UpdateOnEnter(BG.ButtonRaidAuction)
            UpdateOnEnter(BG.StartAucitonFrame)
        end
        if done == total then
            sending[player] = nil
            sendDone[player] = true
            UpdateOnEnter(BG.ButtonRaidAuction)
            UpdateOnEnter(BG.StartAucitonFrame)
        end
    end)
end)

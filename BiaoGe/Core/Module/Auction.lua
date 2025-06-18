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
            if header and _G[header:GetName() .. "Text"]:GetText():match("Loaded/Standby") then
                local tbl = header.obj.childButtons
                for i, v in ipairs(tbl) do
                    local bt = v.frame
                    if WeakAuras.IsAuraLoaded(bt.id) and bt:GetPoint(1) then
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
        BiaoGe.Auction = BiaoGe.Auction or {}
        if BG.IsVanilla then
            BiaoGe.Auction.money = BiaoGe.Auction.money or 1
            BiaoGe.Auction.fastMoney = BiaoGe.Auction.fastMoney or { 100, 300, 500, 1000, 2000 }
        else
            BiaoGe.Auction.money = BiaoGe.Auction.money or 1000
            BiaoGe.Auction.fastMoney = BiaoGe.Auction.fastMoney or { 1000, 2000, 3000, 5000, 10000 }
        end
        BiaoGe.Auction.duration = BiaoGe.Auction.duration or 40
        BiaoGe.Auction.mod = "normal"

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
            GameTooltip:SetItemByID(self.itemID)
            GameTooltip:Show()
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
            BG.PlaySound(1)
            local money = self.money or tonumber(BiaoGe.Auction.money)
            local _duration = tonumber(BiaoGe.Auction.duration)
            local duration = _duration and _duration > 0 and _duration
            local mod = BiaoGe.Auction.mod
            if not (money and duration) then return end
            local t = 0
            for i, itemID in ipairs(self.itemIDs) do
                BG.After(t, function()
                    local text = "StartAuction," .. GetTime() .. "," .. itemID .. "," ..
                        money .. "," .. duration .. ",," .. mod
                    C_ChatInfo.SendAddonMessage("BiaoGeAuction", text, "RAID")
                end)
                t = t + 0.2
            end
            self:GetParent():Hide()
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

        function BG.StartAuction(link, bt, isNotAuctioned, notAlt, isRightButton)
            if BiaoGe.options["autoAuctionStart"] ~= 1 and not notAlt then return end
            if not link then return end
            if not BG.IsML then return end
            local link = BG.Copy(link)
            local itemIDs = {}
            if type(link) == "table" then
                itemIDs = link
            else
                itemIDs[1] = GetItemID(link)
            end
            if BG.StartAucitonFrame then BG.StartAucitonFrame:Hide() end
            GameTooltip:Hide()
            local name, link, quality, level, _, itemType, itemSubType, _, itemEquipLoc, Texture,
            _, classID, subclassID, bindType = GetItemInfo(itemIDs[1])

            local mainFrame
            local mainFrameWidth = 250
            local mainFrameHeight = 145
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
                f.itemID = itemIDs[1]
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
                for i, itemID in ipairs(itemIDs) do
                    local name, link, quality, level, _, itemType, itemSubType, _, itemEquipLoc, Texture,
                    _, classID, subclassID, bindType = GetItemInfo(itemID)

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
                    t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
                    t:SetPoint("BOTTOM", ftex, "BOTTOM", 0, 1)
                    t:SetText(level)
                    t:SetTextColor(r, g, b)
                    -- 装绑
                    if bindType == 2 then
                        local t = ftex:CreateFontString()
                        t:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
                        t:SetPoint("TOP", ftex, 0, -2)
                        t:SetText(L["装绑"])
                        t:SetTextColor(0, 1, 0)
                    end
                end

                if #itemIDs == 1 then
                    -- 装备名称
                    local t = f:CreateFontString()
                    t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                    t:SetPoint("TOPLEFT", icons[1], "TOPRIGHT", 2, -2)
                    t:SetWidth(f:GetWidth() - f:GetHeight() - 10)
                    t:SetText(link:gsub("%[", ""):gsub("%]", ""))
                    t:SetJustifyH("LEFT")
                    t:SetWordWrap(false)
                    -- 装备类型
                    local t = f:CreateFontString()
                    t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
                    t:SetPoint("BOTTOMLEFT", icons[1], "BOTTOMRIGHT", 2, 1)
                    t:SetHeight(12)

                    if _G[itemEquipLoc] then
                        if classID == 2 then
                            t:SetText(itemSubType)
                        else
                            t:SetText(_G[itemEquipLoc] .. " " .. itemSubType)
                        end
                    else
                        t:SetText("")
                    end
                    t:SetJustifyH("LEFT")
                end
            end

            local width = 90
            -- 起拍价、拍卖时长
            do
                local t = mainFrame:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                t:SetSize(width, 20)
                t:SetPoint("TOPLEFT", mainFrame.itemFrame, "BOTTOMLEFT", 8, -2)
                t:SetJustifyH("LEFT")
                t:SetWordWrap(false)
                t:SetText(L["|cffFFD100拍卖时长(秒)"])
                mainFrame.Text1 = t

                local edit = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
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
                t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                t:SetSize(width, 20)
                t:SetPoint("TOPLEFT", mainFrame.Text1, "BOTTOMLEFT", 0, -20)
                t:SetJustifyH("LEFT")
                t:SetWordWrap(false)
                t:SetText(L["|cffFFD100起拍价|r"])
                mainFrame.Text2 = t

                local edit = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
                edit:SetSize(width, 20)
                edit:SetPoint("TOPLEFT", t, "BOTTOMLEFT", 3, 0)
                edit._type = "money"
                edit.num = 2
                edit:SetText(BiaoGe.Auction[edit._type])
                edit:SetAutoFocus(false)
                edit:SetNumeric(true)
                edit:SetMaxBytes(8)
                edit:SetScript("OnTextChanged", OnTextChanged)
                edit:SetScript("OnEnterPressed", OnEnterPressed)
                mainFrame.Edit2 = edit
            end

            -- 拍卖模式
            do
                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                t:SetSize(width, 20)
                t:SetPoint("LEFT", mainFrame.Text1, "RIGHT", 25, 0)
                t:SetJustifyH("LEFT")
                t:SetText(L["|cffFFD100拍卖模式|r"])
                mainFrame.Text3 = t

                local tbl = {
                    normal = L["正常模式"],
                    anonymous = L["半匿名模式"],
                }

                local dropDown = LibBG:Create_UIDropDownMenu(nil, mainFrame)
                dropDown:SetScale(0.95)
                dropDown:SetPoint("TOPLEFT", mainFrame.Text3, "BOTTOMLEFT", -17, 2)
                LibBG:UIDropDownMenu_SetText(dropDown, tbl[BiaoGe.Auction.mod])
                dropDown.Text:SetJustifyH("LEFT")
                LibBG:UIDropDownMenu_SetWidth(dropDown, width + 5)
                LibBG:UIDropDownMenu_SetAnchor(dropDown, 0, 0, "BOTTOM", dropDown, "TOP")
                mainFrame.dropDown = dropDown
                BG.dropDownToggle(dropDown)
                LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level)
                    ClearAllFocus(mainFrame)
                    local info = LibBG:UIDropDownMenu_CreateInfo()
                    info.text = L["正常模式"]
                    info.arg1 = "normal"
                    info.func = function(self, arg1, arg2)
                        BiaoGe.Auction.mod = arg1
                        LibBG:UIDropDownMenu_SetText(dropDown, tbl[BiaoGe.Auction.mod])
                    end
                    if info.arg1 == BiaoGe.Auction.mod then
                        info.checked = true
                    end
                    LibBG:UIDropDownMenu_AddButton(info)
                end)
            end

            -- 开始拍卖
            do
                local bt = BG.CreateButton(mainFrame)
                bt:SetSize(width + 19, 25)
                bt:SetPoint("TOPLEFT", mainFrame.Text3, "BOTTOMLEFT", -1, -35)
                bt.itemIDs = itemIDs
                bt:SetText(L["开始拍卖"])
                mainFrame.bt = bt
                bt:SetScript("OnClick", Start_OnClick)
                if isRightButton and BiaoGeVIP and BiaoGeVIP.auction then
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
                        local itemID = itemIDs[1]
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
                local tex = mainFrame:CreateTexture()
                tex:SetPoint("TOPLEFT", mainFrame, "BOTTOMLEFT", 2, 22)
                tex:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -2, 2)
                tex:SetColorTexture(0.2, 0.2, 0.2, 1)

                local buttons = {}
                local function CreateButton()
                    local bt = CreateFrame("Button", nil, f)
                    bt:SetSize(50, 20)
                    if #buttons == 0 then
                        bt:SetPoint("BOTTOMLEFT", mainFrame, 0, 2)
                    else
                        bt:SetPoint("BOTTOMLEFT", buttons[#buttons], "BOTTOMRIGHT", 0, 0)
                    end
                    if BiaoGe.Auction.fastMoney[#buttons + 1] == "" then
                        bt:Hide()
                    end
                    local t = bt:CreateFontString()
                    t:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
                    t:SetWidth(bt:GetWidth())
                    t:SetPoint("CENTER")
                    t:SetText(20000)
                    t:SetText(BiaoGe.Auction.fastMoney[#buttons + 1])
                    t:SetTextColor(1, 0.82, 0)
                    t:SetWordWrap(false)
                    bt:SetFontString(t)
                    tinsert(buttons, bt)
                    bt:SetScript("OnClick", function(self)
                        BG.PlaySound(1)
                        local money = bt:GetText()
                        mainFrame.Edit2:SetText(money)
                        BiaoGe.Auction.money = money
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
            BG.GameTooltip_Hide(guild)
            guild.text = guild:CreateFontString()
            guild.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
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
            addon.text = addon:CreateFontString()
            addon.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
            addon.text:SetPoint("LEFT")
            addon.text:SetTextColor(RGB(BG.g1))
            BG.ButtonRaidVer = addon
            addon:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                self.isOnEnter = false
            end)
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
            auction.text = auction:CreateFontString()
            auction.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
            auction.text:SetPoint("LEFT")
            auction.text:SetTextColor(RGB(BG.g1))
            BG.ButtonRaidAuction = auction
            auction:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                self.isOnEnter = false
            end)
            auction:SetScript("OnMouseUp", function(self)
                SendWACode()
            end)
        end

        local f = CreateFrame("Frame")
        f:RegisterEvent("GROUP_ROSTER_UPDATE")
        f:RegisterEvent("GUILD_ROSTER_UPDATE")
        f:RegisterEvent("CHAT_MSG_SYSTEM")
        f:RegisterEvent("CHAT_MSG_ADDON")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:SetScript("OnEvent", function(self, event, ...)
            if event == "GROUP_ROSTER_UPDATE" then
                BG.After(1, function()
                    if IsInRaid(1) then
                        C_ChatInfo.SendAddonMessage("BiaoGe", "MyVer-" .. BG.ver, "RAID")
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
                local isLogin, isReload = ...
                if not (isLogin or isReload) then return end
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
            t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
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
            t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
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

        local minMoney = 10000
        if BG.IsWLK then
            minMoney = 20000
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
                if money and money >= minMoney then
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
!WA:2!S3xxZXXT1cMK9HTk(u2SvLx29HUMB5KzIgoEiLPITwrvljfffJjf1LKYAVRlvJ7HtpK9vd7EUt3JKODukz5RJKSTSuST8xr(7V012s2r5gz9PDv3FbQYpHeodjFYvTpTpU4aGUBa0aO7EiLtU7nSKi7UXbhCWbhCWbhCaW3FV)OL)r1(r1oZ)JwUT9By7y1AMdo)utU)XFF7fCDMZTDRfS((ZUGBd3w)I)tOFAUTA2EnByUY8wh3VsD3wlB6xPzfF7LTQuBfhZLTxOI)sTS8wYTrTvE)fA757Uma7pO1kZuVUNL)((F(e)V)0t(9(E)GRz6SWsUToGRTJF1XgF)Zp(S)XfCrzZ9yoZDm7Mwprtd1fg5TVFZFyurCWM1m9TQ2g)N)TaunETfTwAuO28eNYVL9IlA1YB))Kw0h)4r9xPP1OTDS9)tT9SQy24yMR453QT1t8N8Ax16Owo(Z1UED7JFTkJnYCZxzU5hz25Nf)93FmxNA2(2UoE37)AvGoTADkVMwnAmznV(ofGoaVpXSi2ILxFH47aTSq4B25oW4tn17xdrW1RppIiATVXN6a79Gt9sTDOexFxdv))hB7SGV9rTg00zLM)xmXpppj9PDRz95FVM5uZLw2TwLwiUXt08NOgOgwlAUWkvQ3W1T1s)FoILvZrq1If8N1ev3w6LmDSxgEYzhZ65B2YFV)BwMEwZ53YYzr)L(pFVF0OoUow)XATBHHQcWqB5zHy418ofaku5U32gDztBN9EVFgkd3BB3R496)ELU32Qw32X2BjXp364bYkhF2p97H(bXM8m9HsWAPRXut(bJw31XV5pCVTSFsJ)(2M1qqyAm)8)rVLmrn()de08F)718)MKQ)c0hqKXsw2lUK)t)sEwnQteihDM5NFMPhTHRzTR3Y2zru)JM)4QEONAynAlt7AVe0(6GAqBTuvFZgO21F8Sl3UHVDFZUqdtpVF89gPV3VMns0zb0xx5NCVHrLslx7fqF)AqEPi9j(J2oi(QZcwyoxFVeG8kTCBy13OqZaGhCz1avwnwAup7N0c(2FYSnsUhXYx4q218xA0rqV2cepqIJ74Ef(XNQMBfp32o1w6EL7BueB2)N8sOpr6U8evj)9KF)D8)1a9td3fmByyIyWgdJ)tflNJA42Y4PorFq6WNkHQQOuZD0TxQCU(WFUow201HK(ew(pMvR93E58OoqfWaa)0Yc1W5y4760E5QwTGerv9sisFHLGxkIqz(hO22EGsOFvixHcq5wgNDlNAKcYUUHJRVrLjkn6eJy4VKLti6PFB4asn6BL2BlOJxuswn8ScHbHsbQoOswWyxdlMgfJ4u5k(OAy4NcPAAXqZ7iTX8QPHUbaHfhpkaCN7ZUMv(cC4po6hhuTOeN4u35bDAzTOTNVvRrA0a)jVeXlLjgdXGg68CWehtb)nI7rfVGhztjuKJKCFrcDJuRMRZylz64y1aK(g120DclklkhgUXQGs3FsN6ULMnO6b5AAlppZfTiQBZhdBfiLcr0FkeUrAkw2YhPaPAdR8p1jkA8urcuOER1SoocOar(8yWkACeRvkiryajUtKZZZbqad5efyk7rQ7JzmJvzEK64wLWVZKEftsTDY9ub4aHVLlSVrEKG6uaSiXeJHrW8Kln)HYjiPo1JNBKg(BBTtDZoN(2Dp75w)zU7AVY709INj3Hb0cPTXTF7UV8ZXLgB27C(pT7LoBNF77VXf)MUN5vx7S)lDE5NUZz(1B8SNB9t(SOK6(wpZgVXf6C(xT71pt3N)CDo3RsWnnJx6134IFL8m(5phBgx)3)bCfC339MDp3vx9UV7AV5)CNtFRvV9x155UC3t(0DFLB258VEN3)T7C6Z35MpBNB9XKYdG)LFZq478m3SZZFXUp7ZJGF9R(Ci47EJFlfE2IbQwVWz7C(Vy1B)rD(MpBJt(oR)Lpt3l(VIkVUV7DiOgQbcW8PFdcguzaWWXUU0Lx)RF5op7h199(1RE3VzTx5YDV9BU(DV6Q38Dq5xvba56o3GpxF9635t5YLQIC372avRn21Ui4k6vo66mF0Q36w578cFtNlCUc0sL)BCCLlDYn(SxF1B9IDU7l35SNJJzGtQ7REN1U41rjjHGcZm0SFLZIEy9)WxHAHryrafeaqpqaaHlbzV4cvkKww)dE21U9VHa06FWBT21FAUK)LluV(E37EgOCz2k03EN38x2IKNiayRweaKJOW6KuSewH0HcIyDxm3a1NqkIiIYcWihD7YG0u29YVxN7CEJDhhzsGGJFJPhkNgxU89iVYh05g3GKxAFo2VWHjMIHIp2VWHvCZ7A3(L7(wVdfR4M31(dxa(s8QAz0pD)dpncQymmXKyZ8t1Y)NFcsI4hnEapswLLGyPwUmG8UN5cRERpmEtoBQkBYjaT6n)Yox96sZ)6x7RctsGW3XjiCjur055Eh8hquj5FHvcmqigNuGIZXjDLy540VeNPXaVmwhtMLYajAarvmvQ)ik7IaqLMoIUAniIOOozergpeG7dpxNZCDwDcDU51HXwEU3LIr8OJiix)dp96FWDzvoS6n(ykKCv2N717CEAMrpV2R(C8Dm(DxSZDojTlXV7IB8QpVKMgsliBtd9lCGILyParEMtH4v)61U7v78npZAx4xZYIw)Yxj87Yg)6oNSZf(I1p9NIgSLvDaIq7CX3b((ZFrjQgiT(XZw03LMT4zqjO7E3GYg04KmzjAiVO0cYS44FmmInELNUZvFZvVXvO0idVyJx8vPjPV215cViXIPv)MRImW4pFYtPQ(25RFbri5q9hFQUV9L6CMpdnsmD4GV4vqJFdJp(AiLbVaTuVbyjeba0h7(fNV7N)Eirp0RREJBHgDy17(IeJBqPsaB1BCUvVZBsgigLxK8aQMb2gXWjIOBkz8reYaygHKXBCkkzGQs38ZiKbwlxezGEDTtjHmqFhrgDV0ZqgUhiJlFfwYGW1JXuIj1QuEfvMD(YZt4eKsgXpcupfMi0oWKilc(27CMhW7BVZzj5i8nUY4AVhYC1WgikUV2lf(Xy9gWWT(v)Yo39ISJMU(LF9nEH)zHUPrajj5)8jFAsAWdXhGLDOvPuWxJQWiLx8eXvqTvWhvXYJYadxxmdREJttP6l85k0TEUlU6n(uwfEHkt78QxTZjFEj6)gzQ53wecE2lVXZCzweajhHKGKfrIafWQrwGc6(BULOcAjualcKqbsqc0j5RUw3x)lEaVWzVWyc3lad6dd7JmA4AVxNV5zx)JFAOd2x97249Uo5HFzluNI1U07GYokX1U9NS2TVcv1Zz(sym9V9o0biIvw8MlYvwVexz9UNsAzDZ7S2TODEzkloHLp80D)9xosm5uVX6x(2IciitbgiW0b0GkFYZJ)aGowlNzSKyaQLeWqnXGMywLqFxYSsJOd8CnZX7fjb3vT)8G7zJMCo8gkV4)42YihXJU5y9jcbee(9Zf3Ji08NZ3S1Iw(5K6xfQ3bqZx)GiO3V5YwyIOOb4Y5cAj39U)8GJKlWspGtXCc8LuaYzlpIheaqkIs2SXYGFo8B51SHTF(C9NRObpodGH8xexarPZcpJj1yo1dx2LkzGWe8hCU0wjM77IkbfNH1bAEqnn54ELVUPYVEyKh1yY6dX0Wje9hMeUYChOx4k0pPIrOOSMDIrZVK1XlAmsJMlzwqGh3YQgH3cEO1RDvcOdu0yqrixSLfISId72lA8qIWwTrBljGourJDuOpM6du2HUjg9kQK3rbJh0yWHgkeQGYneo8hKbjTudbeENfowMnMzOuaatk0YHGfm8jktiMVulpy5pgSecJT39MNi1tufH0sSstEPe4dCsiyrM4DEQu0aVQeS5LGujUmMclI5bkPWKsEcWfuxNLMl(o9YD1mHaXlXiM4HUPSKjbRXOsMSH9DBdRf8Z)qfHo1eMhKsECMlW7HwUI6xUaU)kbpOhc7hZoZBM20WmxK8yQumuKTkfRXV)(n6CJBSXPpp(TAUHqI5E41WzaePo3mhC)75rNCEe)SY8to)uJxzMdm)KZS)kZ8Oakqt2DJx5QB8o)(Ux8msWWGimm0oEKHEKTBi9hGio3Px7wFImmmXSJp((bAihX9e54tE2X3dorItxY1hFQlBE893EzYsEmSXGL5t9qtUN53h67BFaHe234toX(MhLYaLhIpL5MEKPMQsy6dUDrQ5aJpY8iw00JlP823K7z89o7itpEaadWNUvTfTMZ(jXKAjHcUQ5chPwl3MJrf6EkJYfP)R0omoHCGh1TvnRwrzzaS(uuwgqvoWWwPUDdYYc8ugLqAkd))2trbPkZsks9zO0dRNiN0BAlCMchBbjH8ipcsiayjfsdPgIIYkzmWkIoRlSUoWI8qwppEiM22XEAxhRvMVkSkrpvFII2F55bxp)fFezwnKPtZoZ5WzQsN4kZh5W1tzmeHorezrHugOmKuzPPnuzsIKFjnVqAdPeGHkhGbcykqbjrvG4y3Oyqrb)HfItexP0vETvV7llQuIxVBUjCBuBGhohapELaDD8jFk2IXgMcSuxi7J8TGpLpxqIr6HlOoV7en2iSg(eT7G8sPhEq0Vtil4sAU5hz)7zKz3tL5h))18v27m7FEex4Hr6MPH8sogJreQL7X2tOsI)IScfNqVvfXzLVgg1zuFosBfut9BOy1VHuvKd171VHYC9Bi91VHsvd4eGvycvr63Kk5qsQhLujzMVIs1ULug2S1ZJTKTVLq9K(nzL8Hij1B1tAMJ1Le(xsziT1tnwjVxCW7SFIX9iB8Jn7Pql)He5nsU9YCMGcVpC0s2ZHmcdUrWKDqpeRWGe3LXqAlccAoccjOu2jmhO(rgR2)aIf0XyGaXi7FiEZ9dQshbVo)LvoLLJbnDbUMtTnQ1rsn2GrqOzTXQKxtL)ifubLPh4(JJGj9gWCEq)koWa)cdjynPeVOe8ZrcX1aymz0pRuLYAu4S)qYZhjo4mTiYENL7LRew()iY5K6Nb3KEZISzzkltKzoXM6ev8u10VOFF4qVuPmcDcGC4iZKifPsXcWltPVom9u3)O98kjEC8FjM8YMG5Ft566RjcSYu1JeTOZYzAjd5IdVjjwFwiUPPuE(WG5vIt9jIQfshXcM0BshO8ZpGKAetpt0mArA5MacwWPTGE)E5lOUZk1nzMohPObQ3dogdHoqh1QbDg6ds)BrJNezYCrdxhiWFlgVNQ3Eq1meUCHaDYgjoaZ5D5QM(ZI(IbX)z88pBP93DKgTB8KTzmZ2z)HoBDCDtjqqDgCDju1vcualbuOfWDucmMRHGKW9ucgHRIGJYE1dyaCQbdAwqqHBDucePvdbMQMp(MreG02t18psRkU5wd2MEkmUqsdQRNSsjrVif(ti9R(2oEwT8L1dSOHzbP5bjPrebqtDxT4MIUUS(4v3iemfgMvKC5iQeilLusJxXe6JZHsJnShJhWJidRMELhZQfEyTCfX)jiymrPn7itUNCY1xdkJQu0avLDmAAAJuaXh4NIAJOJsuhngY4o1mmH)hoKsb58S6Lwacc6g7CULCpw(csshc4zWqZrB7JSdANJ1WYeIJvC8A7LMCGS7edC(CZpZbYHm5bzRz)dYNrPguesBcrI79rARSesJPfjHb3qAMPHilYE292YDz84mXggxCeizlZagFOQphkbRLzhRnRYHCilxCHpCiWcg(fgUT8ScvevDt2MpeLODgeqRzLzCgRH9chjpe6)IgJxN4z56LCpMJvlwUhiAp3YMnACiBNAUhtL7PdlpuZ7O2lIb2lFDzYd84tSQeb3siIoykx5zcYiM5eYrNlzV4snGD3GAvvmavQoAOPLW2ASZ58DBMVqs5qvFczQZWeei4J1BKostc4PMiLKxDKRm6nr9wPr3LYzPKKIfzmX4QouPWSH7IPbSfA3QLLJp2)PKnCGsqrm7Kbtq7VgU2YRGX241S9vY6KYbS9TiROWGb5loqqNeWt(5JwNHISlTqbD4nnAWJaMt59uJV35rQ0QJ0Qf9g)AlSnWS((P9Lr6W2hE7hHKW63y7PTKiBqPzHAsuPf8A)CLh4gHH0I3sW(Jl7vCMSjLfebjhZOmNJWslEfQWkWnlZIHZIz3stjdeYOXx(I8TDAI(AEP5PeX3zjucONGaqa6PMrMpBotG)hru8ckdg3mdXIP6IzJSqWJig9qx1SvAqkawpwXujJXJsDYu8PfhFIAMWZOFKg(pQ1k7bzVGs7CZOT0b)KKfeXMQGSXC0HeoZlfZCCZzISwrk5GhQ32d2vIknTuTXpCgxQ22NG4b8Vz7ZwVTpmyq90EY40IuchVLkQlUywQOeuElvucgRfikbIXAdkmzXAd2WvyR1MJSpk9w4G7IwyW9(3XJUJSBsKCub52m6vcv2O)0v7kz7z2QhKpHbczgEV89Jr33kLg4WiVyGOzSjI1)9NDfzOk(DVbhjmgFAn5qdAK5tRqh8qwIgut5moJ74Jx3dfaqQkmjFGgMRmhe3B5zcIU04miCbLrNbfSKFyvm4SgVLycOpSRBdF7MGCYmaoYdZABK9p2(Mz2ksNAumgAsyrUuklJLfd4Ektz7WX5sJZTyrYi1QbOG1CSaLIdWgw7jKxfBveIYvsm(KbSPzVJOdJA53mOpWNBBbvuouTLurtdgvjri4egS4UThTxbRD5k6eng2EWE0NQjPmlRozMqmbhverl6rCnKpoZrSWHJ7n6euOKc)XhYx(p8QxKjhd1jWin806kOStLQUakoul0j)RsbwVCaxafYqS)sDrX09sHGYuStesH8I6EL)nPjA7i3MUmMafl74Vdp5tpfrtLk9)I7c0ICrnD8bvykODBmWqPRGYvc)toDiNnurckH(ng4Hkg(MeR7Kvy20WCISltrptY(JBF4sldZqg)jCe3LNBNYwKbqAWcH50QhjtRFMyc7L)9rfi5bstzp9PSmpQvs905xuq2cKX5fkkWFHTj6Fo5XCdyLvR1UOrLy7Oi8xWrN32YPmqRiC0THrIOGEec6xccqaqYC)4mJ6ouw(0w4kP(5ljMsJuDGIdGOaowdiF6xHKIsfQz25jkNfdnlL71fKhjLIlUaUVaFNO0MwvIIYt8hyop0y9eld7a3PPOXrHz4ztMIxSDfHQy04Op(ahgkaszVlY7YNhj0CnmcGbpCFjhTLQ6KqzKjjrwmQgQGJIe8XZrrQXuu36XYl5nYqktL19ICJFs0GOO1kOS6Nl)BPnoCeMU2OWExaqB)WQ9TmTzaak9RwnntYJmbDHQuYrlBK1iS6IIAbGwUXSWgdvaPZ4GtEatGJW95TIOcfCutVzLUSjnlBrp2mMGbWULyfgpI2InedvktIyJJUYK7jpzem0BtUNcPzgN4PboMRJFl3gAMkiSdzB3YZTv(CtcTv1nxW6bjF5bN0bF6LQiu20B8COmWKQGarGJoH0H1gDIsqLPYinASp9lUJmijCQg2ohjrN(bz3YFF2E(UTO6Euwm8WjV5iJ9wjDrKzUIc7rsHLms578Ge1K7y3Oq6ApW(0lvThXGmFAAgGCLQ2braZ3ZC)OWDdMkvWHUBe6OEIMVxfr3fS7mk3xmxwp3cTSB6Np3moe3PMJjQ7i6jSAy20ZQgpndyZhzcinrjRwCll4i)LgTGbddtnbp3duA71ZfvbqJE6leOerXfEeIEWWmib0kfnw2eFgDIRAOHgqJXoT5XFmZgTTexiaswWh4Og)miF9j1F(48M)OfeB8JiPDb7qzLJgxVeDN1c2LcdPNVoDwg4Ve(YWmBzcTbAwqJMVPFBVrn5Jcf2JsvX92BHmfwAYlMbc2UZLlTJ0gQwHCk4Wnn(23uXYPelxk3Wydww6gCuz97)FSrzGT2gf(nWxV0Oizx8PIGuqm5J0uulxXO(BWk4oqbSZC9eWmdMyvA0N2(ULlnKQ4rpvXgGCIpxzVCjoachD0VgcrTIA8qHjsvkjEaXktKe9MkJfh(q)qXMrYhRnMj(jI2MPZr2RLXlzFTswBxD39WmhTUUPAfyHTSpSplLRQqMIHFf(OesPcbFU4ZM7yCSG(mOyVcRokycclGGstZbuk2LyepkOAhTivZN(T4suK2OMu4pOtXhUkO0I2)j0JxeI)7yocJLtNkvq2ZKtDsGAkUxhtmeP0y)PG9FEO8JPQPCbDtIFj6G2pf5)XdSG)W4oxGVlhmZ0C8DPAcTZCho55lnOYTMr81)3PgSUDbRuxKpyt8WSf7AwByJmgiywmuew(Q0ju9lK(nALkHk((Y0Zz1u1lwP1nPRxSSd34K6cRq6pxUcBDccABpJFQkh0gMqdMQn)wSpsK)KCu(KOajteJGhiqreTODMzADWoBlALzCM2TTNf2bgsCQFOtTIgupe(CfYR4MGiZf)bBMfVyvxcbDWM9i5qTEcrj4Uelz6SOvTSqnk8jUw)4IhddFl1OzLh2vqNi5c64ciTZtHS8nqFIPj13DUhBp8firbTMt8Rs1aSsWFPA2E1vTzz0LNs(O6dIrM0HYFVfLxszAQMhrCM24ok4zk5asmBvCHfJAWhwDlE6BcZwZ3MtksBRCwAH5VZg2YAhLWQLSOmX5mPKRK(gLSW7sIVfnsMYts6IYQMAC(EkzNPUlrA7oiSGdPVBaSECsy1XxNEw4JrQPosotCSd8yqhAjlRguFrwZQHFSJTu6sodR4mB1gdlmxgjRdCyw2woLxasAxiBTJDLLvIm2Gu0CGxjB6Z6A6IwPRuTaSSIK55xBAX4WISuSPSLs2AMPCTNiSROvGImJ8ylbvpf)pXpCOey4HXduIXrK2BRI0gFzB2yQmX1APs6xRf9HgsVeFIALYlzb(ot)IUxPyqKfieOeeuwKuOcXlrsHwwVkpfU1Lj2qg4Fy2dYc52aaPerObHptA7cNqySfDY9h47eYprEqHtCNNpsl0IabrL9tB0ptxgNIglw0OkjOSa(POcR41B56OcXd1)wA9pQQ4eLwqaJWqr9hhiqfdkVmem1z5AgRhJxBTxBn)LiITJ66N5q2Et01)Vq9ZIim5daY3xrVzD6WJmDxf6T95s23ilrTOQ8aHSLdM(Tk1GZx3YmN8Xb2lCFyzIPsb4saA4bRiRL0eQuTkiz0KiA57BS7Hj1APfkM6Hu7hXtgqknPtoqshbfYeCYd6hooRULsqEiMlHsdJne1X2h4HZdjFDH9qu8P0OTnwH7E4xgov6t6LThcdLL(nhcZrNvGQcjE1KNOXwASx3fAlgdck6Bl)O0kstj5kqL5XsUnXx7Vs(ujm(vgEcTq5WD58dugFN3oGAprn6eLIO2C7RTxvuohZDzRzCYvONJfW4cRmnk98jZugf8uUkFjViy0ghyb5Tx4aUnB3Cp2M4GjN)EQTYSwnTm9bskNMGYmJ4r3bMyKRG(U6(hs9PbyvC7bCdbuzIs)dJpxsqoibY9pJAarIg4LFM9c5v7kbPgvWvGUBBF8fnGAOo2s2nSONJIGjvQHeoJkqkU9wWe7Fb9a7HSEBKgwT81c5jsvuDKnPh00khzHfSA6NmluHs(uslvWwOQMsIwKV0PZVqA2YXkj4mePDOHePOOyGUEfNgUjUFzRxQD06oj31KrhxhAaLBfXcSYDyd(OtpnlTOQB)wPZNISGJSHyy4X8l5b2IoAH0dMrp7TzJidu7rawWyEIrcA8t(y5AO1hlaAV2D71yuOo7bfbxuGP4YZOGM8l5yMs7TOrbLYuBwQsoM200xWX5Z(bPTgqi)mt1)r4A8j(zJVywdoV96Pmh)O3ShqIWHRxpGJGZ4wsmCu04Pm46qxm600wNSisqmqGTvUGlwE5fXGB5Lrm1VyJPw2TgEM5MoUoRSmAsh5ufzBBMoOsUjZLepyPMhZErAEIuDMWUzi(ec5O0t28QCpH(GomdIdAXlBm0kVLnlACugkS9S2q1yS30jMv8TfrRPr)i(gsrZrZvVM9SPJujAYKwsjyrExVm02TfkwTLjpDFrqQNLGKo20MEu2TSrA3QgTvuxinqghsBCJr3Yn(U6NsHgF7kpmO4S7L)aji8utK4lcI(5DpmLzoTQLVhZPT9ByjoAKSl)9cPjZHXRG4nSfjpeQebOSqXHGYOwRWdSrjxP8AYPIyGiKraCVstzv3NCA41CjZ8dOhy8EUm1qpTDTAnS0aoTPs2P1TmH)W2Keza857q218xkFSuMGeN8brsp8obYcARwPkGuILJapOj58NqGRz7nL7chbFBUkJTG1jjTLLR324o1I84OIPaZU6jHsnS9pvU8kCxfnSBCeSlgaNHg7UKmwNoj7hpXmvi9oBG1VNzEv4)lsGwGXp4OXWnG0M7SVr3YG1d3afC6yzwtuPgSknywe0sNWsjXgsuPQ4exMhweKLsBZwyPOS4g(nPYtC0AUGkgNVCfYlaukObrLmjxNbDcaWmvAoKKIcfuwLQYI74dKKVm45rHLvl6alvYvr3s4u43lVrNAoW9ox)gdi2Fis7bx)Mh3(WXQZA2lRj4MZqxGhqH0h2MK7T3Tzmu63egkqOouLIvGI5iIGGxTTjJTK1chj4OMCMJA1QHztbfu0MGy36XBI2IOiJW0XEzyakPCD6Q37cxRvKqDt6jdn96y3f1JB5aihf)MSWmo91iHi6kXQgBqwgvhRevjj2(cYY)QHHVdpPDxPeehOyoqfnSaHmeYlQONzWAUauiideWfgqOWFrgOtXf56RJIxwWOFIfsTvP42Ve7uov2psI7HKwTgDBaNEvfgprJeCIDCeqU0nJfbkKlW5tC)UJLuwpHKGFVnJbKmUwy6XDyx1gpo674TKxQu8WrHWQ)vTrQSnkMmGogDpz1eSMKJz64Jx8DcFMn(SsCeaSBdyYTMlEgo4kXpMMA01ZXIexy74hyjTQOtsmchXHkuPhwFN2SgLsC5tXwXwt3Ze2A96plSRl9shlY2dS8EHcz7c1m2wRlkyZgOpUsEtfqz9RkGYWTsL14vAYm59tRBgtBdjVghmR7Wcx5Nr4vrdTITzh(EEyA3JIgyCMwZz)KY328KnImocGMqxabbwatlHd2uXMJqq)rLmF2Hho4owL5UmsXi4ygGuTpQUl0s1gcxhALEYg0lduMHHQtymvTtqgSokFt8bFweIjVxcPugIKfHG3KMOV8phyTLaNGKA66Ik0psuZA)g(9jxx6Uc6LgLNYXyobAtj9zrJ8NFaekPz4bjpqR4qGtxEGcf6tU2yZgw9y(5JqHGdHQd46zJzdLlKufuEuJgX7LPIiRdJWV78lN4EHoHjZSLSDOrtggXYWX94eivzX28VyGGRcCmiuzM(egqKEACrcai(sR)(ny9JANtF3Ux8lXPWOus8WZI4)ufHwi)UZMFfzaJyCYheUYXGysVhZ2Zg7sZKXxjBpCXBj94vjfN04AQEA3V1zzFRLP9DTGBGJftsQDwBCcmrFbMahGZJp9q9x(ElkQ1lrNPMkhQYQSi0H5AMB)YmhkPrndYScq80Jv5OUQ21rmlv0gVYt35QV5Q34k0Owq65NSYigtPFHtCK7SrAjxosgZw5rapC2UZPy5cVi5GLF1V5QDFLB(Np5PsE3)iTI9DDdj)QmP9UQid89WnIMQM9elOS2QNX6rwAS)4t19TVuNZ8zHhL7D)Ixz17(UB8zVE3x76F7DEbArFdytHraa9XUFX57(5Vhz3HV6nUv3lDYvV7ls2xyOujGT6no3Q35nj7bFuEx)QFnsyfI)Agoz6KK0SV4KmXA9hVPA0CMcfZY0CcddWnUDwwdx6YjO68CG3R)koH(JvEQp)nsvHspnduEkIiHWs48ejwr7sACMpme95uRLPZMJmu7LZbs5TUBixHPwNWwsVhQYAoSk2unZsQKIULtJ9eHNq)QmzmrlkeVlmLDDOPoqc20X3rVgJhPiop2CX6rMJMJShrh9quDSzcEJ7tbWrVfehzoqoYCWCKuaDOiWzdf2vC0sQuwFtjLxwZf1yOmUsFvRqgpM1IPqgx9gcm5oeIPAcFnZDs6rSi2XjtOrENPDV7Ux5d6CPlZYcLF0p(xIUvAezu2Tc3ljt9RK2linrEit3p5dhkomEItTEZ7)bT3Cv)v28VLnRavMTODoMAmkpb2LMw3WnxwkUfTt)EyLfdsAxCSowCp3KK9WbzYi0KWKhfGjpAodgKUJBdY5U5ShLnCz3L(OLvkDhcFQCzFFQiQDnCYL99PDQowct1UvpGaLVH1ZG5WAInZGLHkl7pDMLJc78oNAZB30tZ6sXVt0LN9C98M(KC(utXy(qwzrdYrUB4obn4AiiyhZajuRi0Hf7c(n3sWZ3gI7ctFTNp9VeJ9cSEuY2U9FQTzdBFuDQH1rbXTkKk78R00I80CTRsEHMY4)tTTBIg9QObOySDlskla7XtGd51UA4ZvTrniKdATji3kmGuFEXBGeQQoGEKU)8HedyTYzb0f(iHW5pCmWS2mJp)pgsOXwP7N0piSqRfBYKghkzHfqIA4WBQoJCo499qUOV3F)gREJBV2fFHnER3p8Jkdmg65VoEr6ZH)dzjLkQAXNHJlD6MnzERLr1FFRCA2ZQ5JFKeuDX9A3aFu7XCv9G0)HrF0tagwSf0Rox8DbpCHyV1Gf4A1oymNWBDBoiprVVLE3I2nVYqdqNKmCOj3Z87RiBeqgtd8FNq0fPpIiycbKckd6PbsXe7YEads7BlgUwjDKZtijB1qKXiBjMiBSRZUEnm5iudzUb4JFhz7Fcb99rQ7f3TjyLtqnh)G4gsg0EomwjQ4Hrdw1b63X3cZE8bBx03hmEcS6LIfNBkI)L69PjIAcoGPfIQavXT6Yb6KIcWprTvXY5YzoiAamhzat4BLAcItQfmfamGYaUidrmrGy5afs5P6btfiDHdaE8Ne564Zz8VJ47O5nqy8Yz4cXbGsompC6DIIwozPGaLjZmBXGFXEzfRJwSYs4dBdNxvQefagcOTsdQxNykQC9QfPsx9JWRtLK2Ce6wjonX7yCfFHDGKTxscbqp2uf7wXwyNyb1r6QCSzMJsbNcGj0W07DcnJrWDIAheIVwTgjwpfMdkjEDvgbQsGf)WuWurYpy5YjaV(bwPBX3DODobXWP8tw(yCnMJPNnplJ7m)5(Q10NiLfn36ku0O0dLq(u3elait77advwdWe3jJQPLgsdq(U(MnMNOZR0dPPOLUlLfOnHoSjo(iju)uPWn9NCMQhiHTeIEwZWh0BnrkRJgHJWl9ZKFAOpgX7(zmqQ8MIbJMDfe2MbfrzLkK4JEtfloGGAZ4IvjKxAmubQBjWwqtKxE)ok91vz2ccUF5hZacXb5MXhaSw4NSAlj2jKKVa2Q8hWwNpbsVFbKO9Ct6FGTqFeW7NGbGlfZF(2LbI(rm1U9ecc5NH59qvmxXXKyuFHyZfuYmtsNs3uSZweNDrc312QCDa)9eOyNdCI07G7bvErFP)2QlwHrXN0Yk8clutPLgnjBMzIl2a3t3yu9e1LUzSMc6lnxXw6n(lMuUWgzJvOpDkBfWqY6EtnjW7jmQ4vDvxfrzfL8cMBs0MSQPuzqF6lqf65K3GVLAXFwT6FRACZtKbYqCgaBpf5vNc5mntGuz)UI1WgFIHM0nnReJx871R04WmhZLZpSca5V)Ruf8D9qC(fBW3WGHcc0K0W9GJRErXBiIvg194Sc4t60Sn8T0BByW5Kp2cL6mbLdAQjWT67Gs4ab5HtDdz82b)5QbhwkyIRbvenobaU)2lB1YEbfQBaOsNnpwHH)emn0TNCZsW2KPCkbDCsRcuoQzSHJZXSdGYvu1EdQqkqe2dBhOLLNhpM4Jj2uJjwuWUnDsdcWxcsbiG(AQky(nHwegesq5DyT(Pmzf7CKr0WUGrhhaeA1z1(GinmdougmiNtujmggLAPnvZijvQUr6Q3l7k4gIes9AZPGeGJC2HJj1Y0UwD8ysOsP2klaB1W(XpMttjjjqCvOGQAm1tePrwTthCYdy6y1GKq6vrvvQYgKUjjTkvvQmdM81GdQkhzl8Or5rDKUx1VhNrgHVGYwvFv1RW(p4E4667RqwdI8(0B)BevfVAsIHF9IJQ2ohbPbBeavHAjo9uXidOenQ14J)XcPafbk2eVr3kK22Xsuwn8NuD2J0F)gDF5ZT6DVKkFfba8CVENZ)U9q3pwIKVkqKSY8b3jjBHBfy558qlz7BjpN0(p1s9zoBvbB5cN3nNZHGtzlyU4YYB49foMjk2VMrZrvFnbRmAiJhwwozSBMK)dG3W(K8YKyb4uSjwDlzjDTAaONZzsg3VQUr8zpE00NTKhNNRBae9ZefzIsWKyZNC)Y)3KJJM8pVu82m2r5KeJz5KBPcZZATOThsIyVUTWcuE5ZnIZkGdK2AfAjxwm9GyBygZGGRE94IEMGCj2un2XKb1VLtpLQ1EUQV091Mm3nIannZEw1cj8F86ZKMT61FTi4hFg)HBeM4cwjACh7PJrHEsMuWlip0qX1UOsivMhugmfcTx9l7C3l(3uXRwfFIgQqyHBLI4zuWL7WGnz5woL0tXM3EWidX8lyYH4AT(bpBNp80DF9VETp8wF3TwR1L7hFwR)qirVeqm7M2zueXIDcN6IuWp)Xlw52iJEFOHKGvgJuRNKbSXcrKefS65aLvJmgGiPsw11iyrYKely71vFBlBL3ITQB9(kUHgxysV5wYUU)JATc(YMvZkSsJ37jWhJwqBokpJ6A2Qgnqo1V2SWACGDB4iic6OOojWhYh(1XwY11ZAu3JJgvf2Ls5luitNGBHiAs8TKZui5J8GqI8tWeC9EmKcXwUnsrnFpGtupytylWKaI)oAnn1lpW7AXGORmMRfPk6gu)6HLgudOO(GIdTVXT)nRF2RT(Z8cDFJVOV06ptCHMB0rg7rNy2zo4(f3RBj4CtAY4vNjaJLd26NLlnuAQmLQIpu9SoES5K(B)6UV7P1EjRt3Nu)9KDLfzrIOBrlPBKwcpyZf)H06SMfGClFd4mO(WsuGIydmMW719bKNhzR2nZBXxHAHmgBnTfhWnyit0OBCVhhRLOcOqbKjz0GmRnYkzGjaT0)QfWXCrmZ8LlHx5Xhb(f5jjzcFfGH3cdbYNNins)2lWSlrK0lGyc1Ax5SRDRpr163oyslGBcRw7GkxTwP(4hiZWaTHiLmGKSHTxgVpjvKiNiAQuvGXM0fOLWPw72)gX5HfTRkr9J0EGWNkozk4MdKX1(MWoLm)T4lRnUgk9Q7lLNfdQubtzskx7BPcLDUW5w7t(YEnOc65iiq(04OcLmMxpyCoQpZbHb)6qvxW(EXySGrIgzmYox0RD185EGhhvm5Yvi41dtEvso)fT98TRVY(YNdtUYOkKIMd1YSPSvHxLQd0t7hCGMIoeWvz9LoBSDCE4bFmD0ZXqda5l7BbB9y4EfOmC4Ljjr6o7LaIUExeL7dkt1(pDKzN)qZm7J(tvUKNKa1COIgYUWZ4gr6Nc83FkIQqOn4rClnI120Qw4KWlFFBvAv0yTeAIn1iR4SOwELDWw73D7oV9Z)xdA957KXpQF8LQN4zhsNPb2EmxJvzIhNDRXFyLhCC0TgVgv38Dnz2a(zy6cr5pgHbhjeg4Jec9OwYjaNgn55YLWnpAIAm0OqGtnEmncN8Lw)QVx3x76DFR3tIyLNOXXWvtEBVrnBPy6jEPuvCC7i90Aej)xuKBgNF4PZXisYAy9kSZEATtxhYydcq88F2HeON2gnxZJ)yMnAB5HhNUS4g3YlJUdSQjaRx8g7Z(VS6DFduJ9gV2)QSzrfCnUr3qqjRpHlh96O3XqIqK)an)HoiBOyT8XYEcNRBCCkXQm37Q8Hjj(b7Z4)x7DL(BBCCfhg6lfc9tUffOTFHGfbHeXr1uYY2bWXa6GYIf6WGsokfgbmIIlLyJejljL8rrkKLT1H1LpIJ8H8HuLtusrKCfkKL1r1x6Fafg9)GYDj5Nkq(lOVzM9y2DNzpiLf6L)GS0UZ8Mz25nV5nV59E)SY6LiGD7sOTwqr0)hCCwMxhBWuLYuB9mkIkWnvRPJ2tNShRiJNYlzjOoam7AHSTMkBjqgD1)6G5W6CSXZW2bKgp(Jq9EhAuqU04cPDTTrp4uM9ewVvlxZRy7gbAW7ps)n5Ff0fZlhueNh2BtXFrb82Ctw1wR0dj7xXkhiAZgJ66tQPY1dUoKjpAY4oVKzCA2h5TsJBX9stvA2g(JBXzQ4UUspe3mepsQGEet31cgm2vCGWbImkNiGWiXnkAW8M6)h1Yn2jwj6Pov0HN8l2eNhu4h)hQGYP5AcP)BtT0IpwqFpJ0ANRefOvEt59oBut2HW2pUqEvx2EUWbd2ra0FItLLEYV3Z9Wo7vAYg(Ua95dLTDb)UJKUba6Di5lpKZVIi(bWOG7jKqPzduAXbyM6nzQKxziydvVwF9tUMBb56ut(I8BVTpXz2x82Z6NhNHLbjORBwERcD3THvMCRV9yuFBXJEyWE63XPyDNYuYHR4mEiSAsRUK4UZ75SiEcBWbF6Xjohj5Sn9vkk3dMx8VCpXB(cPLgV8cYigB2AtmhPlaJmEHPHvndQrcR)T1z(0cgccjl1hWsde4OWtY(qtsGkpflRSiZ3dNjVXRKdos(Pn)E7pPGJIQineZMBGf5SGksp(NZW9Zmtg8rG6zabHbn3B0ENJ6mMjadp9OCcjPkjCK4Ra9vSmKWWArpFz4oCik5WyNH2ZW0ScG5WEHJ)Pj3s6uEMHHrCGx4LAWySDsE7DLUtxoozCncC(QdVksosMo1777LNR2PukR9ontgqqd825y7aMuqZ4bgQVr7gyPxHQvx3680gGC(du3(xdP8n7SGOfa365)B4caw2zsBGqzKWJ)FnlfEV))sHdTLcSxjuU(YVRxmyT9uv7L2PKeJyWuPW622GIcVplt4yiew44d)vkJUvEAkJXpLAoU058zQGKRnpwuw25Ip(qZmNPXjskDIJ5AXke9JpN7OTUiABKdtY4gNdvFUzSYGP(T(4PnghuFqd7EzFTfYbFb(vi7cQ3ZWvsb5uZ2684HwtL6Z0LoZnFErwLItFXu6XNcYqc3BIyHtHcBfCsC3V27rjFn1(FlzsneQO(8RItR6tq5ux3Kt4zrsGqhZYA)y0fjj7kaIc0UdwZFL18S9UYbtz96ZjKH6lVrBazIEVBRW44Dzhyc4c30G9ouAHyDNcwMiiK0Wrhn659bOVKw8l7ovAS3OXQITNAeCuOZ4ve0v2nFsVinUnGRU3pbdOS0EHihNzw)kvBtyZmEwnCxOWPGxSwwq5o1DeiB9hov3VDtYmc1yyYb5Qx0trMwAk)bk4iWId2RG8BQCQrEg(V85TPwBO7iT315I0qZn3zhoOci3v98rc3zxDhmCKlC(MBO7GoOwNVTg(1q5d2buRqDCUi90z42A2b1R9oBoulHGA2v3qdfb6TDCUGmRO(DwqpYCA2uyeSyKAQPgDcdeiFabTvn81WmdcrEv6mcXtC5J5zOS9Fmuu3NJapgzHzg8gG1yaCwqxlbUkO7UWeaVyjW(iNopZ0pkP6NP)AX)So8ppb(N1J)5jX)8uiFMixMSPhmb8z4yEX9qJ4dQCFKi3URo8rEI5y9dAs83eDGpdA1KYag)wmwYyLtYPbDjuyjnAK43g8XLUWSs9uLzwSwfvLcLnimyWOgKBXBfkAzjUiz6(gWOw0hApCHAspeSaym6iPcnjSM3y9pgGdJtVcaDMLwbXLCyxVs6220LDzcWMLv214UrZEYYPpuyVvpWGn838xmCcEfwfSA0x(65vET7MfeGWTdeJuGtXgH6Qi8sIrUJHkJDcQqck5dmlwDdUYkqQGHtGIOFuOZJGakv)AMpRM8LZlxyK1k8A1sDYw7a5PuOb(RA6LN2eCAVOdAgAn4iDRLg1eVbkX3sJ5q6GzBg6xUdd1g4HX1lGZK1GVyPe4OFZh0pXoFwlnAVmglV)sUe3ru2Mm2VDV3WIokqOkusqYDs74rmnzKGmBadahnnO5lDqRBIN5IT04NqeOEr5UiYhdqCKCW6zdZWy66IzwnoDIhaJmmYJxU093xfu3ru0reJpe5Cqn9z17K1wsze5Ql2MmLeHa)z2amzg(EZgGYyi1mlk()IJDQlK1N(DzYf4Zj5pfuA)6RNg)apVtwp0Ee27aZ6hZAUzmGTX4k)SuSMRekIYN65YmiC6r0GaXrixp)EoJNARVE7z3idEd1USMLrQEICyzfSreRVnEp5i90q4oGds4Tm8NcNdvCvkhJR4CoC4GCfN0bdh1bhNv5XH5uzrvehNdfO5)atXvsMj6WrZ1k4SwwD2kuFM(SyoqWk2tkPcACNeAJoZblrzGwlcXrobQNQh(ZWFXPSLd62T97mh8sEnooJBXZDXyeDKbuUkflWLc9XzGTWyr0EZyFHiZCCsSIAfJYi52ttswXsPCwTtLRoQaV146eYEQpNEca)apyPQY5ne)SXpxJRCTzZhIzPd1CWwc3q7bJ0DO2d64nJOmipXwFX97Ejo2Ck7YrGKU7aGRaj0JLTb1V3wx0TcK74JsWIFzSHwL)30FFwldgpt6X7LEGQbXYCXEz1esd9JihTNdmoR8p5s7JQZ6NIk(uX5B4lLxVgEf6S7KNZpJQ4oKOohXj36P1qDD(GH9AT1CkhMil5GuAw3Xe9)C2P5WA7BlxVugcxERyGjRy2(iHmztG4Uf67ZCNguUfa3B)kqBrlQaxOrq9sBrJDsNw7okyDbmM7Lo7qo2D5Um3hXupI9L7yUpHrpRlKmJZVAi9JMAp4hlAeVo7joVB525FP4CDw8UNjckJt8Kkg3PKpfFfVTM6oCBErY6vEsy8t8ZnkzYjZKhWYu1LAsmlKZW4ZUWP1RSG6O0XEm(j)YqjZMwOVCEDXEf8oeVwZWeS2ScoMPUdv)JfhDQHexv4NgnBQHZ0Nq0edLovMCP)5GyaKqeCUWKODyK0Y)sye(5f7nzhO3yPU0h3z84zfYv1YdNvXhugySljN0lgtj7xeTVujJNO)QxgX4Nkjs(sJOnsFtVdNBGuz6KCL4vpwFafaIM8tBmMq2(UCvEYV3IKa7O40Zw4BED(xpDPfxS6QL(Uv6PbPhSU4Jxw8opOWFC9)5UZu4lwn)2Zjn3lK(Injw0tC(7ioX2fE0ni6ZIYFVxdvsPnwsCTPqzDLhDdcfiPYW8BnB(ThNu4le6Fm6yfx)vekjDRBvC9x0tdaflSZdj1HqcOuIF1yspDr5h(QnkSZ8Kxb0IyTtP5VB(D2eAyX5xp)oVaAgOVskdMQanGH0J)ZsF5ljjHsy8w9i1vZXH)p)(RjUIw3sAPXLE6Mq)o)wJMFRVT0eZko)ZlTWALw(bvpsT18bqnOd(H8BnnzauyUxkU4QK2xAHNx8RhNumOPr0yLzLdLMf2KuYsloAXV6Afg71ItStHLwR4ARaTS4TNtAQzlE99KDOoObpn0GKAqkljBFlnZuLU7AaXGXC(DFe0cWqtAU7ko5c53B2c7Tg0Sf29Bk8SVJmQkSZ9KEYZaYx4BxqC()amrjUYFcnVrcYDODof0ostnT4TwLesfOxU4O53BosWTw6H3wCsyw)PfF51fN8LaBI4uZIkZ9FP4O7cTw(DFG4mFPm5j9X7pjmRHO9jr0M0pWVxCYxH6UKE)wZko(S0daXBUAPRVkPKqbko6maFy(9FI0mxtCUNbdpuvMhpBuVkHlnXDkT8tkU5nlU)ebYV1eaXHVlf3)XfxAg4dH44pe6Jn0w3VNUVIkF)ex)1KwLUxskZYWcl4aL4vplND4OHXRVY(Z(j)TJ(g4pJQMHds)lyUIgTuos6mc9LaPgqvHXUW71cJHXLQs)JvwpIQKIl0oqMFdjwkBe5JJlNlvFJquI4hmYF1BIyP)rNHW1FwsV1dIrUXRMk1qhzJ4AEYtvFpCcxyPpw)lK8GOD1eksc)EC6zjzVdkRzY9QD4eX24Q9K532A)(Jh4KTNjrsu7jmq6JcICAsUd2EQyHHD9(0nisLWge4xDKJCKQ2qEyhc(qfnqD1DQtFInsKKm(bYx9YXtCz58hZn(HhnB06RjaSm6OJ83)4)1
    ]]
    -- 更新记录
    local updateTbl = {
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
                    edit:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
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
            local myver = tonumber(_G.BGA.ver:match("v(%d+%.%d+)"))
            if ver then
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

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
        BiaoGe.Auction.aotoSendLate = BiaoGe.Auction.aotoSendLate or 3

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
                t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
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
                local canSend = BG.canSend()
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
!WA:2!S33A3XXTXcMC)i)0EYh2p3NzpEZmrdhpdPPISwrDwskkkEnFOLKYA31hDMmKtpK9QHtZ7m9OhXr5ilFvKKTLLsKLFf5hYp11os2X5gB90(C2Fc7FHWzi5N8FHffa6UbqxaD3dPCYn3lp2A6UrHcafkuOqvfa(Xh8NS6pP6pP6f)V10TTxDNg2nN9ilm1KZm(h4SKBJ5DB3Cj7FCZtnBTATS9o0)9tn3N9Ji)9vvDATw9kNEb7t59p8bl1ULN7Q0NBEAFi)f)V)SZ(J(r)dFvLglTIBZd760WBXXgFMfgFU)Fl56wVQ7jBm)jDwZ(xSMLaYkxZT5Qv8kVwzpNvT5V9Jx7)uyrCK1QwXZEX20F()6JQXRUS9knRSKNJBJw7EUwEvA69F(CvDl3YTDJQRSynNgoTwPVrj)49F93r(odH)Ifz)E2F8pB(6UlvPUvL2nRynm9NY2noHLBtRN)m9bVw4e2njPK5edwOuM(6Rw7g0sJcAHjS9Ew7MZ0E1ST8AMRplYFnT9A3SHLNBJ2RUODtibNglxG0EwAf4L8euL9jQURNOa5FYLjxoOSk2NDJQ91NtnRgUEwLNOWOtmIL3k2nOOK)(Wqvk89chSzLvTBX(SD9w200iOqPM53iYzTVHvtJJjAQbfxyRG(kuZGF9rpppJ0MshMUItdAfro)AaAVhYPQD2Cs4neLJFc7gEO4HMYEpsJM2l70YZU5i1Rt)ulT4ItCKqgW3Lvk9WCd)Fi1GZkap6)1awdws9XyogPAv3gJTsLgnSRdCjJ6uXDcBEZotFJvMKM3KnQ5wyo)QoKJPTB1QYY2hUPDnNtLncMY1xFm2YPi4KmSAvBVkEvwSUD2N)m5TE(qQtzNgvTpfbiF2YSuWYBDC7tNlamj2sg)ywjaGg)zYXlZrQ5rjaJvEbYyXMfOVZtRCfwlBYdugATbVLHY7MLWynfahPl2Ays6)Yvw4Oze4SM65YmsDVDTX5UxNl8GUx6YB(IpAJx796E9lM5ya6G026bVB3R9ssP5N1ox5Z6EJl153)bBD9VR7fF9nU0)sNR9cDU4VzRZF5np75jj19DEXTERR25kVE3V(IDF5l35YVodV8mEJ3CRR)n4z8p8sIzCZ)0hguODF)719Y3z9h9(B82)ZDUW9x)bFtNx6wDp7l091UxNR8MD(G3TZfUsN7D(o3)tyLfa)1E7a478I3RZlF9UN)LjWV5DEjc8DV7VNdVFranNx5sDUYxS(d(4oF3NV1zFVn)YxS71)xjLv33)Hm0c1Cfy(SVJadb)ambKOBCRn)2R158FC3B(Bw)rF3gV2T6(G3EZhDN1V37rYRoKd56H3voxF7Mp8ZKYfwXT)9BrAPw7BFm8e(Aq95IF863)(z78kFxNRE5C8st(BbuHBC2T(83C97)QDE016CPll14Pj191F4gx)RjjPujcYi01E7lrEyZ)83q6fjyqj7maipWaGGhbEROmniCdB(HNFJh8BzaS5h(oB81Vqqs)QLQv7Gh8aLkwuSb89p8T)vnzWhcGyZGbquKe0gqXqqdqx2zSQDPTCcpoksySNkWefv7ZI1v19w3SZdVI1(JIieicOR06bNIslVWrw3(d7C37YYdFSJ4xcWGaQ54r8lbyJ21TXdUw33594yJ21TXF(QWxKBwfj)19p)ceiIqyutYpJpFtVF(zyjqF06jAXYgwcILwXIas7EXRU(9)OODNIPI2DYay979LDUZxJM3n)QVjijHk7UpdJIqqDNx69OFGuZy)xqfNceHiHcKmLLnCqKYY)ImbsawmYKqgJqSysQineDIPycLcbatIetwQbKWeKAgjS5Nay(Ol35IFT445o37Rbz(V07ZXgD2kcKB(rxyZp8rIdSx)UFchYGg4l9MDUcpJKN341FPqM8)4178WZYzV)JxFRx)Lvi)SEirYp)lbGr5a5aWEoqO1D(2nE0D68DV4gx93isk28w3o47QZJ8WZ25QFXMx4Zit2joeMuX6C93d((lFDLHZSE1Ozj87rYsuGrbB)7hemqMJsa8WPCctZpJIZ)i0O361EHo35Tx)U3MxVeA3B9QVopj9TMox9vzALS(3DhYK5)LZEoDTVoF7ROczaA)KZ19DVrNl(5Kza5IO)IxJmNjm)0Bqge)k8s8UGghmaiFS7xCLU)HBsyLiVU(DVprI96p6vzkrqsLb2639YR)W3MnrijVK(Cslc0brGcewN5vJpMvnaIqq14TohVAqAo37ZzvdQKPWQb51nohs1G8Ds1O7nEr20Tq14w3wSAWO2seKiCLO8JKYQZxEfgfGvIe6GVOLGebAVqI(z(7F4fFIwF)dVed6G3cW9xDtIkGbDiCC(v)UGpkXLtHzZ78LDE01fNvBZB9MB9k)Zcd5cbqjP)YzFb23HhKNKtC6TiL43sAuebnYf6Tj9dWhXiNHalqrfbE97EbEn8Q)bezFx(6RF3ptuWuGWUoV(D6C2xwro1itTWUcZ85V1wV4TeZmKCic8twebkLSO0sLsU7V9(IcprkzXmJuYkiayY)MVQ7B(fprRaT8ful6vGjBHPBjtu)v3SZ3D(n)KxagG8n)XTU5xZE4x1KWuVXnEps2jjUXd(0nEWT5InU4xcZN(9pKl8oszjRcMuz97KkR3)COL19E4g3Np4tOScyi(Ol09pDRqwHZ9wBERhiYeqMgUK)02eH(F6lt)aGgrnqfMfVeFwCyQGiqZuHryShB1AHLpDnyzyw7qXukZKTDdhp2IsHNiWt)XTPvgWor2C9Bil0KLmbFEzKxHppFz8Q0CzBVms2gGVcyYAupcbQzil)NwG5T8A22ohAv6GZKTbbUC(LlyCMg(26WhH(4NTczi58KKQuFvyT7EnBTwDhVSz6ptERqC5No7xslKuRMdEMwTKmKeT8kuWIGb4hAoqRSZ)4QYYXvqDLdpHmNr6v52aM9KOiL1P4BVQ4API2NrPfp)HttlM)kwJeb3ZnXOzxX(u5TgP(ARujNanRPDvgTcSQxR2lYaRuERbeHA5M2KQqu4gmV1tjc3I1BBJa2q5T2DUqRUXkZatksELuI7oN1tAnWqdrHWV8cGH(bvO4LwaqW7QW4tmPnC0orAXZXpdduy12VQcVX(uBVXQxPvRXo4bZY4ozd9jJsp9AH90Wls9Y0UDzM7Y5TwcqLFEyisX8ICyiefqOaTOZYamx02dk0Yd(KnhjRISKBD3M0kimKXV6WWKuTraCQD)QBVKx2NkpmWIruGuYsZyUqJ3jH(F1s0XomCqEiymL)Qdf6xcYyE2JghyM3VQh0X1F)wKvRV1fUsFvDPPqPeudVxIuvMF2JmZbEMjxGqBkVWKlm14LN9Wlm5SZuE2NXIKvYIW261UZwV3FQ71VOsUhGK7H29tp0tpOf6FqbF5lSX9)u1CpXCJp(mqzNHT04mHjn34hGMaBb(zc50PPUALtnt7vzMXEyRbkgMYrN8alCiY3gSKWhp04toXHwG81sfhk8RZp9itnv5G0gyqXs)WJpYceYW0JRG)dn5bg)GZnY0J7NyPW0SRUS98o)sAvQGqbTyLLoE1MURngNr55TkMN)Ff2T1zIc4OUnRA3me8su5veWlHbnfUY1CQZmd8ZBvGink4)hmMcqxgvkkZaxyp6Ryt2AABAgcKtt6TF6NM0Pcn)CXv9cYEruIqZkovNZfStpy0(qxUecX0onCM2TH9PxyrWI)HgJhyl)YRaMF8l(yMg4SL0jU6TGvlXx8KWhdWZZBneRUrQy5f(APIWNlg57dvKLa7FIKh47dPprwcmyKtUHt98HipiXZeo6)2VX6p6A(J(LfELzc36vlTNmavH6Uf3gESpj5bRGVc(BGmHVNn8PSz8tmuywo88TxYegG7bzIgHo0c7zaY)AaCAjm)cJmZbgzUduEHX)FUq5do7mlqAL7HiKJ7g0mcZ(Q0YoGtlLgg9lQfi9JPVzrZMCRkCKHEOttJcP9muK2Zqyf1q9w7zOu1EgYC7zOe1jnbOUHsZI)TiCgSp3dCGSmk344Ivmb82TTDYvC8SvAB8VPwQhL950324zmYWl4)mbCsBB4Q(nEvhVrxoRDv)1bcpvyk7AWI6GN3lRzavP2ndCKSpqqfGgXbzZm14hCbYec9puqFHeuW0QzjJmgalrFSNHGj7M1QSK9tUK7QR62G)tl7knxALm45CmxYKnzlShcYl80atEXsWSMLe6oPzzoNLxj(wffkHM1CGYfzyZ2JbgA7ki103WeZkRLbkzu8NdnPbHM4UhCpQTSPDQwTUDSnngybvAyInPADy6YDPbeCc)KgYrKS6dxyBIKzo(0M30tTKYBi5ApA5c8hXm7I)Fav9HyfaEDgi8xQNtcS5xQPZAKMYSnwOYIhUPDRw2vj1E6ig3tvw8Z6Y44TwQYA2rZ7y1jTKd6Uu7wAZj5luaMIOAKAopeHEwhOPXM7jQ40qQKdYkqRrfkCqAKandB5QKvTkTw)G1XcjiVCW2RgSim45Hdd8HaKWKQw3Fz6KhKkaiH9znKw0YY(XjzM819cRCVFYs16VKiYpPqQLaPrHlG1VQFCAKsueDH2NeKp7BO2ORoRgz6ahyjd5TEklUwyYlLuQXD8CyquPfif640QyDyf6K)rgqGwqHcwxLI928)74b4Oefdw97pnrqiMiwZ9)BrIWHJldgN6Q(Sifjtb6exhpk1b3Mct2AoIw9tzxHSiaPf3ZzJWmma)BdhyBYiXzKpedhUWbwrG2vc2y0CDC6P25QBz1w5OrBMAYRwbwWZuUUEAIdSyR(SOZBoPfpLDPknMNalR2rJ9kKLyLtETxCs4WWQpexFEyfuinslDYwt2ak2SLuQ4cdoMWgeGmrt32RnTnmORv2C4Jx42dTsJJN3IWmVmKfGF(e215M(za(V5T(LK1aM3YTbe8K5LhW06aKwbbpUqKy5q6zbdSS6Iv8MZLoXiyOuzsLtKHCnIesDYv1ksR9u8pUPGOTfuaG2hy7zOzIcGFthKD4tfqbKsziqXOqOGWOAey4Kp9a5ddoia5MabLQJcaRNGacwxICxdbiEFeo9H1lr7(0GLPNIIdsplE7rS3o8LiWEMiFXZHOxrtpSrk5TQKlc8eofw35WwdGZUOz4LVH41j8vOaOnxZ4wDaAsWUor9GTrzsoIwOcXtjaGySugnkkj64n9PFw7M0zlYKN(JFuDckpoYKhitUivb)FbbiLZBrA(nSwRIdrOHCKJkkbHlSUgrm(4KQDf4)dKQNlAZOwbslCj767D(vCpz2CkPvPTNlOq0OT9iQjSxQswJuVovx2wXbDOsVlm7HjQA9uK1G0)acnt15HdQlcHM7JP6srLQIafNoNsOkjZq1zROYSmC2ISIQy1qCfYC2MHdNVY0uenyIIvNBqqXfUQpqTz)eU6ODKHLyTkIe2GMM4h1bCdAtvYVbbKGgI(UIJauV)z7Xd6yIoUhSP7Q0wSKQeQ0bvhK5tILqLiTmTd(Kqug5rC0GkguwmiWLL5L0vzcPCunlqOeaBmz5qJv3zPJNTLD9AICl1y(vPwb3t2WUPp1bg3opzfx1pQtJQUNeZPmbLbHNEuNLPa2kBn1baY4rTJMbZkKkO)6lZkewyY4svFaiF8flHllwaGc1imqRqzQ378EURLnNjOXg4RkRMwbGr3uHFXxvqanrvkK8LKQNAD1OW34eaJUsftsjvRnrLdIjLVU7YXbYsTB20UHh1BdSTpbkyeIPzquMEsdfz1ttXY401VJqwI0kD8Sz(mBam4LboWopHEvlVOZ0YPd3XnLtiGsZ2WnUtnIuNW3K9Q2UG1g0pF8iroZHSb2ncht)wdMKsz0zxyHzN230s8sY)1(LklyP)dPfNfGTCv6ASczbTzhcPebi0wxjfNknsn4vKajqjPKx0usyLy0OoWlB7gRr(Aw08uGzmBdyN8eeEkWiVuqSfZvm07WkJmdXaY6(OwelUCYRoeyjvc9qUyLMXHmaKESHGXdjJot8mYPjJlLfbmzRrQ79m2N(aK5QrvIofkO7)NPzVLwpI6Ca6YiQIErvziuRGiflDQvNwJqMYavTm9kxeOyMEDl8JaZ)dDl2z0Tqal4RxkfRLcfgzTcWlIiAfGcMSwbOGioJpkacZWJKEsNHxmWy2zMNpDZqUdnPQ6m6sV)d4SQe9tuRk6GCxw9sLeBwxURFnR)Wo5KRXmHKW0Qf3jNvDNQxxcBYD3QQgAeJ)BN5YtyZ6hMj5nmFBCtZRjRQMhuWThKUMzBmo4Ky)oh5ezvvEshUELtppeLJzfcxstgYGI4eAidF3Drh(tZImfDcyCMRBDpN1G(4zH8Mfw5YiZm2HMDUYrDjUibkUCJ4nEoXsmNuU5PCAeqrIZamIzEKQvHSkQAJVGPs(bYFm5tZgCHjCJf8yjetg2Xl6WMw6PaA9Th02SHjHMTDdloSH1tlyuakRQtlo3SVURim9Jr1FkL2VZKqK0A0swfW)aCi0ZbYsLEoHdcHJf1xcAgKBWbQbT7)UF4ogphu3bfxOlBjhkJVowvnhNe64t1jmPxoAjGcyiX)bVy4ddq60NsuzFK(E8rn)7gUIiB3sugd)M9)f6INAHenn6KZQUVpZlfd6YcTfkG9BvAO4lGmfO)LrhsfJrbFm3VvPNkFWBkA2Gvio8qGHTNsjpZY6Z5CScRcRSJ(jAeuLvAFWMxaqEqNqPQ4ZsGAJdH4R4VDRW6NukbJgNYUYjSnnAm05oIfaFHYifW)OtfY)1ilTLcE(QA78wLL2xt03OrA1UYGgiomQ0UOzwK5mmJ9RKrsISm1pnte23IrvZwc79hIDHsGvTHIasnh1j3Sp9RjCbXIs((NbvRBoOf17zyzcjHBIIwFkPanKjyKxvdJYo6h4N0wIwOJ3mPmZ5TobSkdh2YmISxpWC4)jEUshdqkR82h79ORHbi7dtsCGJ1N(OFtLPLtuIJZH9ggvIWqs1PoIYeCZ(isFKNaocHs0KtsZ5Wg1Iq59lJ(LY7ocXwQYOJMhW1dam4XWTLiNedaeVha5ah1JUyXXI(irmCwz)X8HutOhymBQsa5iJtpYKhUc0sL(CVeDEWI2tNMLylit1W09QQgaCBlTnKrWoGchempjHen6PN8azzs5jVn5bYzAfn0LDmMBdVMU11S0dyVS2Uzl3MzZmzqiKZ(YtozJwRzVKxg5ASEf(c6hNelvsLz0jIi2F0jkav4YJuV(H0BuDmOyuH6onoUwd3azZ27qoT8CBYhRJIAzyIsEtWOgg7R60XiZ5gZS0O0WWKd7UA4upNz6k12mXsxJavwtKta6yPNQaLnXuXWWObuxVk5tWRSSZT6xi3nt2GxqGjfywWWO6NzERmcrWdBCPD9kRfSjeccRrGBLO2cprKqVTP9QvC8J4i)PL4QcM5jkmyTmHvAYSkE5WIM9k0JubFe9Kbzab0Y5TwTc9KtK20iIyjZ)mDLt9SvQ32w1iRSSqp6hT(zq(WTzknVzpre)7fwL2hSNHXNmIk1LVFybDRGP8YwJRTl9lbVmSqOFNtFKzg2P5vXRDRrRi7bDXd1s1DKBUOoqdDsrtftj)nLCXc7oxII10AfcOuWrpz092zeZvRjxA3fAdumYoSZy77Vh7ukTZ2PeUJa71ofKT9O(GocTYKnusbS9IcGb8awPCuJ41ktoDysuOHr)KlnoUyHHssKuH43utnKmfBLjw3Llvp63qfrVq7GP402EXQLABmqbPnrwuNHeVcX5YC06u4uts(NoC)TopBFEffvEg5chuVOHGmh6JTe5rmypn2)qjOnrfZGju5xtpKD0kmXtkosLoOaZzodiBwzKEgHvA57Ew)sZWrBj1SoSvCJV9jQHl1uF7uoIg0xvKpMmPh7jK0cd8F(becZguchET41tTcx75QtnwaQjUpVsIiyuEgn6NQ(hrNXweCsRPt5cY6u)c7OopH5)581E)y0bGGn5gyhPDeDN6fd)G0XtD2cdOnuYX(dCfe4xiFpbfAZXyp6uPMI0b2Hy(mX5dy3J6jieYsY731YakpUNFYFMOr8A1IkzJ4Xo6CJB4UMrkz0qL2Xyqm2hh9S81VFnMor0(jKVf5dm(uKd9NeX4kerb0jBuJQbuElHveIAqAXE7YZ2yA32TSPgYqXO3bgNkurIayZKlRMZ6)exKhzTKyvQAivGJSwklEUMzW2LhgsSsLglBxnjLUg7kR1UP054OxhfASg)(8h0eLjMI04h1wRaZvfaF(0S21EpGtl61easiMgQrrmt4IG3cvDAvdli)nbFbps9NqSI7iAp5rNdkHj66pWimJ3aHUOTLQOlQOdWc7ahgVhmzDljVlP35g02RLMEm5tJ)TvFJczeXjfYT(e0YtgXoP0M4OlHZGO98iopwZcXW2jGCLi24KWclyW(KX6c(AsHmk77xr4KQsXgDCgLjtLPF0vSTRZTLyv76Esh(MC3CcE50VjrHbwhHIpidaDxzICfXO1zPAL)NgVNjjSNdn1BP8N1r(d9OJwNckY2Kv2xOQXqdZ9GXqXv9jKw)TWifHEDHTsxj3UK647i6b8IcHmiEpmgJigV3assCa1lXPMr)ruoE)rOp8astmGzKJSa9K4rVtDlN33Z0kovNHU8SctW36Xf6pPLNiyBjY0tY3(QI7IE85iHucRC(HlrsgIftygfEgR7B7a2FHwqqIDvMUXlW8qLHZ7gxeGYD9rERLZBTilyAaANOaKOTZOYmcYp3EoOozsxC3Xro0GT00oPb8rE)YjHbrAAU4K6Hyu14f9XJ7OunCOAIdt1ECO6FfgJewHWNOrMphx1gt5ht(sUKhB9jpa6d7LWwzRQlo5VxUkCQVwKFE76pF7Jb3EY7zPLa0zcArvv3AYmupqTKVIAeA8JGhCQwqBXOfkT2dP2pHEucTozQFgHXgPppIro0pnysnRHs)UK5fIJqkCoKiS)nd0ToBnH9Squ1Z12pQX8bYUkcB8FVec7c1OKfa7cNpo(dTvSaMCfn8admBII5Dj7HHirJDPjk8yb31O3ONiFQaTmqd4RMeODxnBPI0B6Ys4m1JorHWAAMd1U1IKCnM7Q2Z2WGJ3uJTc1tU0acEQp5rsbtKwVez2jkCco4iyNLoS7ATx7aovObtR8Tvz55SxZUIhuvYOjG5sjo0DcLfAMHFOU5vWpMUwKs7HZf(Ytu4)14ZBcQbyqnZS4ar62PUXu8Q4uRbKXrbCZ3622JESYJdXjxXPUn)amdunbhkypG7FyFAeWwenFgPUDtpTqDgJZGKoUbYsMgzPLSxZZmjcryBck)YuT40x6HoTjzYEZzAlcIwbJj6Rit5WZsEFzSiN2Jg3hC1k0o0()rnDv42Bxdys3JV(A(nSvye8Me3)O7(TeDDdmNc5hIzbhBLSh8lYqhI6VsuX7aerIK2JOg)5seJMVONqNrLoA2hUgVin7fFlxtCZvlf1pAUMdYPjVihhkgVVdYHYNSDQn4yzBvV8p6kyh(XcNkYrpe1fZM)54uQZy0ZQUuIaLdWPuMF)d6rMp0ZB98wsdiZhEkVAIpJWK5Zm2mJ1z0H(b2rXVKirQsjR6wLUcZknCBC6vjkDNb7mpC7myd5UewzPwjMEkED7DgJhmIBNkSHq9i5vvzXJNbp6HtrxTw8jgNJr75sJKc0qvSNLEHJTEtgwAW1oqDmjYZOx3fAocz6LSMozAOOivs1uWq0HqPO)zhILzhHxzhNjPN4oImNX2AgVDKz92jM5tzNpiD4x1NMiMbaau8EkIITzZfBeZiLh9RMiMt3d8Gfrslu5TGCqtHT6CMu49pmNSpnMdxP9hoE1TvNJb7sBoxCzmWtYIxcs8JMgAnJaKAWnWqvyFzWrhgYvaTMCH4v6Gg84I3pk07jWSL0dyW9nsSqgExBGakVBq98xfJ9pGEBSHkNNJ6u1BLSrszcw0f7h)XW7miZPTzeBiaebAFBdPStYvOooTMYDPJBxfHeqL8ePhtAeZ4nQgAJmKfpkAF(aUa)XxgnEFWfuGy43txWnyYUi3vEsdwq2ftQziN5LGlALUe7J1FqDjofVG5Xc2MgP)uLqhTpLhO5sY5e8kweX0OHuaIusuz)HbssSfHQJbeZCskHTtbya)stgAQmuN3ukCgP5jtUSkazOCvhWBUTbJtbafACsiWqbbcmIf)shwvS8e7b9EaBB4rwNYLZZk28BjRI9PCMta3ep9BvsKNnCeSeF9Z5CmP2dQbYnA4TadR6xB4pSlK79ZDznu87Qmnishk04hcHnaodpO02XwXEPJ7FiKn7jSBwVYAcce4KZi3cQ9aDn030vA4SkiypcvK7Jvx4MfHfOproRo5xlYUeU)v9HAu6BQbXyYQ9k76tJndHMt5W2t5WgetVoG37xpm8D4jTXGUFeRrBTL10CvaoODxwFdxOwMfqozItAHavo4xIcNC8WUSF44uem(NeH0yO0B48Sd7peVpNMWN34bQGc7TCLIWaiF5qWVgje49yxARN5XXaGiKqwXd)7USkPmxqqAYMgAX6ph5B0nxJ2b9s1cW3nlw3OEas9x6iyPw7aW7rJvPHh1DNmAMy0PyuAkDrSc5uZXFVemfcNhqpA65i1qkOg881cuxSBOgFw0aPOWEmpikTXWHu(0S7i1m8bF28A6pjrRHExTeoVmLFnxU4VcWK2CkHHytP(ckLTvO00VUqPH2dOzN1xlCvIEj5QEinDsYseOKPJjCdLjJxnDIA2al0tY6PDpbzINzBoVZVeFtTY2cG04KyctHnbOThVeoYAiHlnYHUA5uDQRkn5jv82(SIzgYacaQ0eSBpLeV9mnHw09HCC7BrDFpHtnQBooDXWeOXr21Oh)pmKXEUarOkeNacHOgpbVOFYxRfHwmlLKnmuzSIQKX(T86dxw4(8hjgMNIria(sdzJljZ8MTebL8m8KSh4nwiuolwkxU(WLMwPUDpMFz)j7F8VCy3wouYqXCX1aXJjUq6oMyG0onG8(CTyI2TGgu6FBTHbJCxUkyafkaWfxfnzoFsFctGjCvV6B4I(73s0UBDUWJ6E9V0)cLx94RHzRnKaSsEFkkBREqXIgz9d0YiqmzRN1PLd1uyMXfzbW0I1oYbzqmN1RHrCrKMJ2DHys3jkjE3iQyIqPO(qVb9KRqgTTumTujlpKI2j(ooiSxXOX3I1aCIdQdmyQM1SUQWrFxijoIwikN3GOYi0Theem1)wV2l05oV96392CFjJEIyQnEBqTDOXzntxvYm(vKZR9a3fojDLg8F1xLDe(U(3DNUV29(lN9CM3xarAi)q1rj7PaTNs3PG2gSLt01LASqstpAkQ7jTJ8tox339gDU4NhCq629lET1F07V1N)MDFJV(7F4RWlY7cBfegaKp29lUs3)Wnz7FY1V797EJZU(JEv2UbHKkdS1V7Lx)HVnBxOsY7M35BjmGquIkq5INlrZoGrzbN6p49mizlgbMys2arYbZlMu)OXnTm2otw2sWiN9Xrkd8DiESfeFp7IUN2rQig2D7rkoxgrFHGGcwsStI354jSLI3AJ5(UlO1l0cnSjo7HMNMTzDp39P0GunHKM5Pdo7JXuXY4m1bbWQqDvnq2XUzRmgaaADK72Y359I)ZJXh69UF0tL3YtNhZtPxZ7vhK)yWj5P3r5PYz5PYH5MCAosidgWWIC5SPLFTN5ulQ5kzkGpv79lncFAenYIHpfFBafpdTAQvGVMkM8EadQm(jgf4dg2)(7E7pSZnULi5k6bj2p0dl0WoODybLtpXJlIWrNKOSIp0j60wItcyCPLBV1yR9U14Vbw7jMg16uDq7AU0OuBmKfn9ybZIhZ9rzY3jAy5wH(3W(KYwJWKEM(aBfO(LEPXcWAyhmhzVY5NR9lPVNyi9Tp9r0hA9ma2yDZzKDkPpA23WMlZhd7ruJ7tu)kw0TkAcv1utCM57sJ0SJqfCTb1ytnQUGZAT04Jd59)jEw7Twdl2u79wHBiA0u3fDQDGfm4OH3kKqtuEBDEJHHZvDAqTKo5nq7Q8wiNDPmi93QTw)myZks)i8uoRNu8I(qoEaI4SBDda8Voq4EZq3nMf9aFL3SZgWLM3ID(ugSn78pdW93geqcvZdY5OwuV38(T8WcQup(RP(i9rmCfOtRW2NI)tTRu3XJu)RBFcyeBzwdBHtVMn7P5BVi7fEkJ)p12znYK15TG5lA3KLYsWgPdOgTAVyWZl6q4ZzNostWU6dabhzfpw(5Zea1LiBczibFYNUO2MEFyLKO0oTDJ0dJGHu6mrTEvodmxs9amIpVkq7Wd7yO7SjRmnOb4EMWV3F)wRF3hSX1FLTENpG(b04fHFOet9jEg6pmV8KxNpFHZqy(Uhyb7vjTrp7mA2eGzJU3QxC5d6uNEMxjCFtqMwGI6WNamSCtqayMOB5x4g7CNbl0lz)HvUavdG8m92(IChylrQIc8lTy1RRy4catjWBWn2MsKuKdnUFkzynKPlU24JhvJmjtha9SQGdEQPiqqIW(jDFgLMO7IvYSLLqpZoudVDf5THIBfd6FQadOLrFqCNAcsXgMkmt8eTGo0M8VY7PZwHXhw43gq(JIYkKcvlnHdsT(0eCj(NIPkoFpNMWxCvF5eHXIMQeKi5C1uhpjaMd1Cj4TcRbSf6zSua0VMbuoHkXe(SxLYzDMeDs6k0aI3R5sY9ns1PhET)ar3jlLHr4Xj4kUoxlfwgo92Fjwkzb)yij1eB1yeXzvB9HHqKYt5d7IMFtrsKsgGy8QWaXhqrjOHIeVt9u4ojBi7WlCB9XlVU)0CHgf3Fk397yBPGaaIhJ6cZjuF9ejgksEJvebs1AWgg0kDq6B)kTP01eqYXkrrj0tnQSxTyuRdjmwrdste4OpmfSeHSduSOby1p5k)a0F3g1xpc(IEejJsLeols2EKiPd1KhBAbFMeuKsUGiVvHNYqEW7gvasOpS0qf1aiZc1KwvHH0aGNRxL6lWK3v4P0uCr28Nk1fLbIXo)ilI40jKn5hFEMNirSucFoMPp4xjyCYgpGaHx6xah8ifmK29ZeG00mtmuTp)iD0VykAuyJCqpI4ZbnIiJYwLG8ZdTjq8kd(CgcCXDIavpjbRECnUyYAYLw7dPsig2lRvxuBFZIPu0tiU1RVtTM9DU1TNS1URiP8VroPhcwlFj4wE7NpOAY6NbuB057h1odh16qylfmKNwAnFiRajzcxJztBGTkcdxgRMwQV8fxLkdpnr(f16aAV9ymFDjfPW44dTScUbTmuAM21lBNvAR2PM6RDKuxRs2krtq9kU7JfJ1m9C1k7dlrM8Kj0ubdMLHM4Ix2svC2PAy3ngPfDYmHBduAwKtIu8o5fgI8lZDY7yANNwn03jM37mjS4v1wFWyYNobTjwR9y152GRWPhHHMUkdvuWWRxVxn9qnZ7Eqas(YxblU4szO3fzcZGyBc8QzsOsWzkTk7keSkJ6EQeYWQqg9p1jPiz5S2sNhcmvIybodv9IAcbNdzTeW9g5afXHxsEcBYZb(54GcErMzlpKOYXhOzAVQDtNLqKL4dX0vo1ON2ZUv29en94vMXoiuOG1qoO5(n)TssXea24SUma)4e2GjYe2rmzYRBVYKlgKqn91HBA3QLmwKJV1eHfXSlUnwIlZ0Rhe)mZFn2cuEZvfMBLemitpjRNjk)TO2z(t7vcyw1PI9aerldmuc0GwIDiiUeJOEmx8hlfUaqUBSvqOhevJ6ftZt2pVzCcMCPzfNQ1OtUqWE1tVeSf56N(ygnLGsaYAqI0IrKhX40efhDKjpCLg21zjeVmPfrfGumsmzSOwbtWQGgyamOtEOjtGhpIZx0RhwAeRTtYYIEyTHGXb0rNjDClcFeeb8jx50WAMmIzXrVEwnSTjH)3HGWhlKjPPflHZVKniksoUgZft29fgPEhfLlj9xf4Kt4hTrXs)9B19AxE9hDdvdSaj8sVzNR8(PCiJyLjSAY4us1XnillbB)u8CD0vC8SJMloVF1eD6xUOMRi6(LSIcCQfblSvnFb3MRuIL44qHr4l6ziqHjIS3JAUeusLL3dt3a4S8jKi9IsxQTyMl14iw(zbLYy1fnn7Q4XhL(SyEovj2xiQJLf0iYrYI1D2T87)UJVKVszzUYDzT7IMylfPy7imNZzVStlsV9bDBszuALnZinonyzLDgMq21XqkzddYucze1lpvDj7SRgcb2Xqd2n9uyooDrVi7Hlv7RrajjlTeZc4)9p)ECBBP)AY4gDjWbBeezMKyvms8erixQ4Tuw()tnK8OFmMnmtgmqcy(UZx25rx))qmltmRXj)zKQDc20uWakDGtAM)tsy5uI5lLtERMxHPYfDC3hE(oF0f6(MF7gF09F864UA4gtwuJjccm3Rgr)J9gg2KudfHxCkgBoArIRhj59HgsbJck0vloL9KIZaJmlPoYknWZaiicNsndmkSmOOPxV6ANDe36izt9E3Doez0t2A(vCQ59m2NME1eAWDD8G8Dc6rue0NsYZOUvAwLh9FMD0hymDQPRgHuHobHXh(q2GVo2kUUTSh19uKz0GDos2C5s1jGvaIMKEpumfHxilWqGetISTr)KTgJieRPB9e0YpayeVJSgShfIbXpUDygsSlRrDVGWTtYmxCbwdy2rlXHsi71gqC61TEWVDZl9vB(IVs336l6lj2tJwqzgDKXEMjMB2JmJ4E3YGX14jrDfGpMk6VLelwyO4Q4fwKEqKzFkP1H97)2UV)f0ED4Y3Ck)pyBfgMxi47lMiBItwBT3dWmE7ZGxR2X3zedGh3zk1eXiIi4g4Tuu4XCfQWBk3B(YzkIdpvNe0FAmYSosVlJXcCgoa5jMNZpJAdxoH09rh)xTanMlHOLTybQlREA4FypPKb6LHdn(0955otCCXolje2)kCZm1v242xAJ7)Pyo2BatE2lgx5naQR8qTrmuTcIKcwpFjLSq13KUXYqsqIvl2H1uSeX7DmQXgp43kUMKWTDgH3x7HdDSuQeqTkLchFYixkRLjQFnPTMix6ujy)3RtCiNyy0XNbmvDU6L34t)Y06T4EY9W4lJHZujOo6aYumpHd3az)qutrpyrNLlWnsMyFVl3Q9IzZ8ephb9zYKZ)1JXEvjx)JTB55u70hkBgAvuTMqeaC0Mvwt1BQ6gwtEAgWyoimYWfu6nUK0(6n4axLpd1yeH9EyFZFpvcNx4fHd)jKe5BFrgi6gvWeSoaMy1F6iZTWrNDUN5NI6glweXnuEl1RXhPza(Pan8NsQje05)iTxKqcxZUAWImlUJ7TnnDiRqu4VkZtHIszrhCSXF8bDE3x(VwsCLhGiptQSluzwIGnqO0GsMRP8epN4E49yOhWw89VRgXNYdNe2HWj40IlmFrQiWw(3IUL)1JsLtklnsrZKrZ9xNXrZggWIk(uAK7z)DBENB29n(6UVZnvypAPQSiCzY2U1OvAIOkEReksuwhRwgvWs(li5uyb7TmTyELSf0ocguMuDv1HiXiOIQR)UvGCAhYAMo1ZwPEB7w05alkUtuALctrTyfaUw4DMx6Fz9h9wKoZTEJ)v1vm4FvcX39dMh3lbDVmdzeeOe5eq3BGrBgsQNnswnCMwjrzuBIsVRA3mwGxHBXm4Yf6KG4Cylg)0fvnll1GC(PpWqkjhCXLmG0sqfp866zd0HTRSdQSYHyfU16WLuOg)Yds6tgmrgWHA)jXBe5YcPNaJrPn)hzTeB7TDgf9Ek9tLHUuFJcKdVyLb9D4ps0DjdYD(6o5fin6WIO37ZXmjKu9i4OKCNPsifThIZWX6fvVCTLSoKS)cfGmQHK0cAK5cLGCv0t(zy0R8DyBQgaRw8XmiMj)iUbYQivDiS8KL)n9qKONokIDjy3i649Yj)ssxL3lndxtYDMECdT35UU0rTHBVFNLhh62gxE5M3lq7W15D8REDTRka2)9j4I9UN5iI9o92OP9tDXPBevYo7e6rUWhpmGpo49ECZ2Ll2Jx5KWSPPxFFwmwOU36MDE4vS2p0NJlpuQn5FbVhZKSI3d8AxS5MF716C(pU7n)nPF3kGnHNExvyC3kiTtfu9(1Cb2GtTeLtDqz1Tv2ndgNOw7QHJDFoyEpoylCyNY1iRVKS3hIFFpKOTGa6vbDU(s3oqq(cOvjMDIIc6Afo6k221Jwlctl2kr0mpEJ))T31wVTXXv4yOhAbrFi1TWaoTpiWI4ic7Ogjzz7cKgarDXIb6wxrhLaJakEzPiJP4YUlLCKlsHmTJLVOlXkXX3KVXA74K2i5kuilBzdbuG(oHr)f4YLK6Pc4Fb9CMz3L7UCwUCLemArJEGIC2zoZzM5SNzMZCMVJHJF3P3DHTJ7TGXvMoHL3reYYtNZH(oesHAWH717AnL32RrFM3cN6rPgmSQut70VgCvjHerQ0JDT3NJoKt8qYg5z0Rcjhinf))C)2Uz5lsQ5WA35PIDkxo65YytYmlD5DjBQS63GCvDbUYLZjE5PP4872I)gxoueB0dQqb4ZF7)lraMLHskZ46SA178)KIY79heL3wfLRusEZ4aXosyU6g1tJZQ2cnyCXPuZOb126k9BB2UeM89Dgop8Mvy1kxPJr7u3YfCGxbx1fz4iB7eYSHAyh4qRarHyC1NSZddRIeoJO2VTEoyn6w(k3RPO6hFQinJl7M56aBWQvZWak2lhChR023kE1njz04vgDFvvaW1tzIz4OO7wq4ygatxJBEIvoyWdAGTSom5Nly8iCcOpVtGjyp0NHWkKgV2LOWOy2Gh6Ya04QC(d1I8gQHa3oH17(PgHR1Ta(Hx(G1m27v29AhmnmmeSHAHek9O6nGrf05T6g473YOGcjtTNi4OP4J4xaeV55tQB7qMD13MupTnYd8lKI4soMlqVcJtUgNMsMg(mDs31r1dA6KI7(JjrAqv3RYcVPu7TkxAN5D1GzugP1itbBlY0rB2CC4vNXMvmvHff1JvdCmUBFqNp6hmQdbAV(O0j054GanBPEpgYJ21kH8RgC3E3T5pqVdE4aT1rh93Nnzg9PUbcW1)G(7KlWrgOJ283PnLyGEA7JG82zFqj813Hdmu)C90HnLP3(7Wxx(GsnOFOccaCyFhUZkkKrn5ysmcWZJtEnVXgB0GnZ5PDwWk5m16TYRysjYhn(NUV6hvAK9Hxp10uarxcgbit20OPiAaAFBsrqdGxrurWY4vHoWKtCeewMfhPzYNTq(C)KpBL85biFEq8qStlkLkrCOByFUjCO5WpRcps1LoyFnqtPci7hRssFIHi2a(2HAdM8usqyGTTzvyDnaQxxSdaBjwI5TMJUOydMbWqUjXovTqncgLWIqdVgobv9nrlldyimnQnj8E8BREmQZ8FQMDtjOPObm9Sg3y9NPWaGt8WEd2ivn0KuJS(wHTTHLDsOYUc46I2CklDJJEk6FFLiERTqCBKVT(LH9BvM1cvbgZFRwL)YhShOaXsgicndh0fZr4Tu0WOsgZvvWxoyzEWcTbHNQDVnuwWNAe7awS4h4Bam2QO5SNESb4otRKzCN9UR2R(0PWbYRBXkWVAmiRvluL6lucJG8otySJQTRlVLv3blSUlVPX1wvR4enuAqMMuUMQDetoDCY1RPbGpjEkuxERbGr2UqKptIxtuEla5YmEjuxyiXxsqtEs7KrQyWioD0aAa10WqzNHcQ9kKzoAxE)yQc2JQWI4byJsKmc6OmgHj01bJSLL0PUAjA0HRNDJlTUwKbgPynrm2bHHTZHVQ9mLvpP2IC09iJoKeGgaCQsOPHr)DLHPgl0IkHxcPYHt7)Gy6M(mkOgGyHZ3Cbsc1)Ms1R31GEtyuFFwtzs46X0rszRknhPqerY30IjGDbInauAqPCEQ)DRV5wBTgaeFsd3uP3uJW4YqrVhvn4Irw7nz(5ad1gxFWMjCVjGh0ApObTDiX4yPNxnssowQA7tcB7vABZl55eDuBzjshOWZZ22cDPqmYRMv6Uf2Bw12lgYZ637wnO4L4EE6UfR2D)UQ976fc)IwCxVQY9(sZvTz4OW6STdEQU2qtnCBI(UpbMCy5htwCLXAIf4Yw1vIx2M6gDMCBqo9OOZ1BFMOJOmqUmJztNrUTNMu4VXU8vvW23jB9Wk9cguwFWpt)agjH6jANva1apvgylDIkdBMOJAYAFD0zxCT1BNb87R3oD0eF6mop1MIr94CTx2Sd)nJYndNjGLk3WKvS)1F0w)mDlOdRbDkP8Oeax1ENPIF)EwERQyUNb36BOLJlQwgWu1qrd9jrnRaJ4UQ6Fk5SbDmQhDuObTaVl0l52TPhH2mGMU1qdHZcBSPPo51qD7BWb6KZD1TI0MraQQspQvRZeG()E7d9QAzbv9DNTOIgMTJTBdFzwy8d4fLIJs)8HpMZwPMtJgZ9obux6vJqY04ixYAwig(oB5ZoH1Hbz1bOaZmJ8N6XqO8Zg8SvcORmpZyfkxTy0Q52b7JOQYwcjIZCKKI12bCvzdR5TqZYg02NwbTuBvGvNNET3JzXb0z1GpnY5s9DkgNuwdQUJDpT7NRh34mjQPWrsXc9TO5VuEfPPQIOrA47KVAlw5nib9JKGfnR)kTss5x7lPuk(WPD7GzISYCeLRgMb7i7cNP4qugylnJmcO9OV9iQ8177f7u8owY4PFXys8bcM44bNqcxL9WVqASqKbXbhlA04F6YbAVTb9JJHC(5iPNTDHKWcTXdFp3BeIQ(kd0EtKWxejxzqYH0Dyom(rl5sJEdqoRtoyoZE6jBe(qa5rLxID3zpd01r6z(XsQWCUwguS9jez0X5BoyYjs9tds(UF6Z7vic)F51s9lGCH1ob0bPRMoqkLVWHrtRiVKaaajdMqr15x(YJXZNQnYydhQ(n28OVVqueFGCVEx)D(GsONqWNCK0X(r52T3KGY6NRQQM42EIs8HHMVugmRi7NRzVKW7yUMGcKR5CTKB)5Af()onNch5oE8(1b)5ncVu4pToF5F2c07esPlmtXV9X5F8f2yHfC5QW3F3HARWvws(6zLV4vk(Nx6F)0Pl(vpi)tMTWS3RWxTc1wSYZDr5PEsXRDA6ohq4q9KyolS8DKx8CiaHCTttPafX6YV6m5FYzOz(i((xtMP0spIsPcN)8Lw6Ed1gqXIRDvAzOKaYL89Zu4MlOK4JwU4AZrFeqlQDQlm385xBfOILNBP8RDpOAaELMhcvbAanPR)3k81pKINGq7114T0ytW)ZV(IY3fzlTBRG8CxP4ARdS(gxEXnYEfmJVJ(mQ0yVZzkCZvGCLF1jZV63TXuZip3TvlrZn(BGsO)cyKF1lqBPfN9HYl8akJw4Y3U03CgA2aEePXDNr566C5vO5CJfMS09pzXmpwEQ1kENflT4Drw8lMTW5MP0PEMI)hcv4HGkKwcAEPOMCHPp3gZViqmOZj)tVgudqFqHzNx(Sxo)ZMP4ZweQ2Ip9BlERVN2QkU2xw4g3ciFXV7YYZ9NGru57(xXby6LmhQNdc1tHZDb5Z)aAhg(WfMm)ZMLE5v34QFH8zbXJBw6HNs(SpeKNKp3myEU0dLN8PqTL)PxrE6VwH8uE8sNfgErAFaK2u(G8C5Z(iKDPC)QZiFMz03aK)8hSXPEanNqgkn50GaB(1VrHPpP8S3cAEyrMJmA0QgH3yQlUr2BuALpV06t1u(vNcio0VuA9Rx6otdDeYN5Qap2wp(3RHEr1(p5LEmTw1ZL08KAVm1fGkbcezcqpu8WbshtKxkMqIit4nQqY0PE9UeJFI6)DJfmc65t173)ZLIfmIWX)O(JgvIp9V81YckUqFob0Z9g7k3UFo8ZqAWtqiQpAEYSG6ofF7lM3ecbJScA(iilP2vij4Bj49IypY8OwXKGAqXyHshmbOnCxCJogukxCey0yx562v2iXbfUHHuNyp56aQarH4HH0xglRcrh(5XjNhvyEI2ixZJepGOqcExEr1AiDi1fXPRI5vk(j4X0Eb6KuOIUWeStXlbZ2rWJA4myNb6eB7oKKWyIH5dfF0ucIPt526UuyI3aqNg)WkDzFiTlRUu7X6YKGFKGHNiq0eccIXMhxLeX8xHOg5keWkrJpIRSIKoCuXQxC3Dph47ycI9t91lxzcdD1qfMCyycePGPrnZ8XYctROakmN(NWCAHWkFjxZP(vwZIPe5dhhNNOUxc9Wq1s2acYlHgSD8(HYrIfj1L6NRYgiruDR8yIFc9c46f9v4SPfcpoDwNF84)d3XJK6N9Uu9LVhv8TEufyMJRGlqzubiOu7eg9AxH8WeDCy3mhXt6pP3tiim6oAES4rw(edj(77EeprB6a9cYByfXhB5OLDKV6wMoYqSQ37VJDSJ6YgwBwBxlhpjTLd)Imzl2H4dYqOMAPLdEO9VtPqT2ytGE0Do()8d)pp
    ]]
    -- 更新记录
    local updateTbl = {
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

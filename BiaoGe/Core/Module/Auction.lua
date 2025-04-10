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
        for i = 1, 5000 do
            local bt = _G["WeakAurasDisplayButton" .. i]
            if bt and WeakAuras.IsAuraLoaded(bt.id) and bt:GetPoint(1) then
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

    ------------------团长开始拍卖UI------------------
    do
        BiaoGe.Auction = BiaoGe.Auction or {}
        if BG.IsVanilla then
            BiaoGe.Auction.money = BiaoGe.Auction.money or 1
            BiaoGe.Auction.fastMoney = BiaoGe.Auction.fastMoney or { 100, 300, 500, 1000, 2000 }
        else
            BiaoGe.Auction.money = BiaoGe.Auction.money or 1000
            BiaoGe.Auction.fastMoney = BiaoGe.Auction.fastMoney or { 1000, 2000, 3000, 5000, 10000 }
        end
        BiaoGe.Auction.duration = BiaoGe.Auction.duration or 30
        BiaoGe.Auction.mod = BiaoGe.Auction.mod or "normal"

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
                    anonymous = L["匿名模式"],
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

                    local info = LibBG:UIDropDownMenu_CreateInfo()
                    info.text = L["匿名模式"]
                    info.arg1 = "anonymous"
                    info.tooltipTitle = L["匿名模式"]
                    info.tooltipText = L["拍卖过程中不会显示当前出价最高人是谁。拍卖结束后才会知晓"]
                    info.tooltipOnButton = true
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
            --[[             do
                local tex = mainFrame:CreateTexture()
                tex:SetPoint("TOPLEFT", mainFrame, "BOTTOMLEFT", 2, 22)
                tex:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -2, 2)
                tex:SetColorTexture(0.2, 0.2, 0.2, 1)

                local auction = CreateFrame("Frame", nil, mainFrame)
                auction:SetSize(1, 20)
                auction:SetPoint("LEFT", tex, "LEFT", 0, 0)
                auction.title = L["拍卖WA版本"]
                auction.title2 = L["拍卖：%s"]
                auction.table = BG.raidAuctionVersion
                auction.isAuciton = true
                auction:SetScript("OnEnter", Addon_OnEnter)
                auction.text = auction:CreateFontString()
                auction.text:SetFont(STANDARD_TEXT_FONT, 13, "OUTLINE")
                auction.text:SetPoint("CENTER")
                auction.text:SetTextColor(0.7, 0.7, 0.7)
                mainFrame.auction = auction
                UpdateAddonFrame(auction)

                auction:SetScript("OnMouseUp", function(self)
                    mainFrame:GetScript("OnMouseUp")(mainFrame)
                end)
                auction:SetScript("OnMouseDown", function(self)
                    mainFrame:GetScript("OnMouseDown")(mainFrame)
                end)
                auction:SetScript("OnLeave", function(self)
                    GameTooltip:Hide()
                    self.isOnEnter = false
                end)
            end ]]
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
    ------------------插件版本------------------
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
        BG.After(10,function ()
            BG.SendSystemMessage(L["请你删除aaa插件，该插件会破坏系统的通讯功能，导致其他插件功能失效。"])
        end)
    end
    ------------------给拍卖WA设置关注和心愿------------------
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

    ------------------拍卖WA字符串------------------
    local wa
    -- WA字符串
    wa = [[
!WA:2!S3xxZXXXrcA77n80E(IWVC3dDm3j7zmhmAaOaTKosghaiiiwbqWfa08UtbdOby6bOxoygSZ0djHKPdsklXpHiffPeff1xusw0sMFyABkWVeJ4(f4q)ewJzaWtkI9xWLzvv3Dvvxv1Dpau2ExZqIC6UZkRQYkRmZkZSQ67VZF4C)WI)WIN8)zTQnCl7uXU2O7DIHhA3dCnNPRwz8QnQnT93V2HhTuP62U76)1Hh7l(EWFMFtfDQpF5clmH9HDNSu1AZvWDY5N01zo7jlUqLcZ5m9KUZwZU(SvlxCHRnDJ6UvNdH9huBbpu9s)F)IJ(9(E)G7uOY0ZwT2EQ6uXDQ(hy3tmWyFZ0vHIv9qvg)qoZB)sZBPVYOp99N)FiOk278fl4ApvdY)8)ZdvduCg7z7d7tV0XDR5mZm21QV7FCn2p)195UW8291OIJ7)AJ62twO8HkSqD3AnSFP)16nMY(G2vChVrPsoh(ot2FVJpXKJprVJnXyK3FT(RwPOJRt1k1)t)xMcBN21oE95TlxEOI1744i6q8gGO9uZgq0yJVNbgE4XaALD9oUwrObxQ0eqJO2Ugy49SZ9o8fAuH1464oq))FUrLPDDoOD3fQSW8)Nlq(9e0Vps1I2)2V38)xvsLO)ymKyv8FdiX21QuO8ph68q79T(3oGT989cT1PDhRa0dM9c1TlxIou03OtmXOJ8nfA4cJoJopP)1rFfTRp9H)p9nl)ORU6rFTV9Hxz1ZS4k)M7T89oZAx9QD0rRB8P7R3wx(wnFVR18nV8kF5T(2hE2vU41x((VrR34ZADX7cVFTl94MN7nBEI7VYv(vToZInx8TBD3t26yiKTUZh38MNA1p51GprXqRl)1R8P3F5LwC57)6uG37q)5JE8vV1xrXuRtF6vV1NTVEbmUYdExAzOOaGQ5V(4T(GRYE5xDNvEW5OFcWvFofQoODRZDHLFWDHkU55U1Yp4ZGQbARuyiyfWb0LEV)qR3(2REZB38rxc6VDCWUZ9SW)UYBC7Mx96RC8718epO1PVCZZ9rTo7Pw7c3S17GiC5hEL1oXIq5A9gxO5jFNLF0IR8OBcOBLh(Bw5dVbTNSYdERwV)h288VXkFX708CFcqfA(P)oKO8o3DT35pG1ZpdQNwN6mnp91x9RFRMV2NHF8QhD5h9gl)GVQ1h9W1E3Z38Kaj9dw92VAZtEBymO5PweH5s3U5rFiuBl)Wl38SVnd9024LojqsqCVfe302b57np5xHnxARFPfB(6lY3bA(AxFTx96uibaw9ONfgKx(XVFRZESMVXhcDpSiN7YiI7XhXRDI3CTR9(RE3xB1hFIUwEPtaihOlR(43B1p(SaHO5R)UqBS3HNytcurp6xZBDpATY3kPWGvZZavZMBU4R2zpWFH8lN(JaQsZ79AnV)VU1fV3YlD)UYNhW0MHkUZEG)shm5rSTz)gDRp(1x(rVvZZ97xEPtV6NFbOuRDLZV67Co2OlPu8J3yP7gl9zpff90oaLJAfG3b47p9Pb2D4tREZVgydae088NCnGz4k)k6ajIJUaCqzyx(rFe2wjLO5N(fWWndLK3aTpVjf3FL7FTvp1DWsd9uKHR5XqYlWPaSmRCXh8Tp89GM1kp4xH13frwtAZcMTS2rpwRt(2R(5hV5T(qGDV5NEI7Wj94h0xPQvCN)FyN1CEzR)PgfkwRGBbRjM4BQpBbqw6)hQe8)BQf5mn7h9vPAf7PM12zMzDp21aPGtasIDDMF2(kxTqX7wZPYmGkN5)rtvh(vz7(QvWP4fqHLLbHKLNDk3cLbzL)OXMRbuQogB6YfQx)h9N2AhxabCYAvlB3XDqWz45L(gNk1DbDj2tIIY7GGQkaQQnBFOaoSOxROdicFAaHl8J)tpl02Qv1zA499v35LTra(xbPDvH2UZ07ZPO7S91l8ynuwli7BlJbOVM7p64fRoz9QnQue0MaI1)XxaEMQ85LMI(Vh97))iNv5QtxOSvHg1kyTnY)mPDLdAvTM1RCKoSG)GVkh06GVMcLPKQdYRlreZxTc97dA7cIQ3DJ5sd6IYqaa)tnB3g1Qy5wTsJ5MYUg(rGkKdA4tpl(qwaLPFQIB6PYb)vMuzYG1BEsXTRuKwroLSQu11AYbZ13G9A5oRDfF0ZE328AQbVl3oRHQRc(KD562(WaOuQv71jZyT1Tj)nggjFvO6d6H(VYVvZQgwz7TbHwnsbNkKgwy8ObWNFxofTtNra)Hr)aOYAT4K81NFVvQzpJtDqTAVLltEv9iXlJigcXOXoPfGjmM8(3aQhJ9c)j)x8z5OFUJaMUElwSAL(NTqLk2LrUpQYqgjkfbU(Ne(U7qvkvn3yEDpSuJyxVEHzSPgWKoe2YqRfkR)WaUbPeZz7ccpMQSD6x5izTELagkyIBr7dda5XYNMawwRdyVqgfmda7oLppTaaEeKJKHRU7TKlHW0)Kta29ulh5zUVpzbAVDODmjsbcEmL)KJ0aN6WiWaFI12aGE5zNyFPKyvh(ft1BzxpfyNAXvF1hTYf)qqlBQ9J4f)2Ap4dA9wNw4B8fV55(Iwx9umRzo5BVYP(nnFRJ18KV(AV2IGbwWNA9(VkQO)CeZKiQOO4MvWRE51U0xPUG)2tZxWv)9FIqf36JUxRfVPGYMtF9wGAHlEpqtEZR9bnpX5OQkP1hc)BDfF4B(Q3R5zUuRx7ma8REZtdW3AP3JbpF1GDlq1ivVZJ)Y1o6hcwR06s)bQMpkQXEGemFXJbyG6aHrGCDvMTqe90pgSxR1dUYQGs179Hq51vbyPE4sIL6Rx9HFHqP0vLBF7wqV2ARBLIRGhfAxN8Zw((3pDZZ(4MNFXmSAv8DcuLRE01(YldMf3eS14ulkqmiFQ1B)WvU0DHpPOb5xyCy)gNc(XQ)XVcgHbSiHckaWpOaa4sI3lmtLgUf0O8h8MuGw9tE)vU7Xe(8Vy6sL25o3byofFhcmk5xuJwMaa47wuauJi)(KsS43HmHcMfteQbD1kHreLvwcg1OBRw0HYwx)JB(WZzT9Witbec0Bs7HrPj1R4mYB8jnxAjAzzZ54FJaM4Qgg(4FdpOVsn3UocDmU5dpAZp)mKxy9u1T4PWWJm7FHvFCPhtEtDaikY9WbWvS2BFMW4GooqXbatR394Wu6aCi0j5w7dRtskZk)XZJVjmLhSqpFR)4XaOcn(j)jPU9p7i0ps(jFFj0hKR185rK36KNF57)PH5a5)QwoqkqlFVB38M3vz5x9oFL)NKA4BHnEbvrZt)HKxG06NsyazlSbeLafMItNzZtXzVjmrJdEvKoUcRKasfiJlNrJ0yQS3aa0j4LQ6WaIO6nIgru1ZiCF6I4kM5er18E3fv1D6pIHrIYA0TgF6jw9tEeVSQLx6xZGuOZswkiRFD6lVYBFAX5P)Ulbt6yZq)DxcM8OyOHocYp0WEJaOeowgq0FliFMS0YMp(vx58VopjA1RFd)3RsDkir483A1t8fGUFEPt4S8l9H47pZLuiPIo6hUybVxzXcxaTGU9TJY(a12CfjqdCW38kSS6yocXAx8ynV5vwEPBWAJC0I1EJ3M9jZ9UMN)nOgWT8Jrxa8Np6X11FB(1NvgsbutDj1j)sWWaM2PBDrWCcuDnzr(SADj0WmkaOFXU15A9B)yQ7fq3pq8be1wlF)cG(i7HxHAxauwGFa6zOPACuIG2nRz8z0Mbsm8BgV7XzndOlDVVK2mis5cAgWJRCCfnd49qZO1vFvQ1hyZ463GVzqP6HikH4A1YVc1zZBFoE)4a0dpXt(Fehh4(ipc(2hEYNQ(3(WtrlH)tc1XD(yW6z)bigUVZf8FzOzdmN7GEiKx5(Qx)YRD2FL000aGu85)8rpg9B4pcRVNxtVYwWxdDyq4LyJ4gWyf(sDK8GcWr1LlWYlDcwR(8)wnYwx8slV0xWlWZxyAZ3(Mnp6zui)lW5FiueV9XJa8ZbiX7ZYirQfWlrwQf06nVVSaAfTaEeOOfWJeF3si51MDNgD4FWAuXNa0r(NQ1SsrJrqkExdqbbQs3uHDmaR8PCluBgB3ukDVaBrYWQw3la9UlmNnPrK1cdIrgJn3DU70yuiYW3EqFdvXZLkEiNV(OlKgbjl85cLNdxUVBT6Zx2XnDQotL1seNEWq)xGkaT0XWFtAQH8TfPUZLZcWe(pKszStm(3fDcgo97dSYadnPeEuSVPZ9weKhmyY7kT4qjKDlKcQY47PDOkSxPJqOPUgBW(spR9HZA1B55NTqgjACn7IuAl6OY6nMIcAxzT6wgYzQzdnRWWU5SwpJmStvUHTcq7jR1wY0bx)bRBFVLcpc18wYy90wD3tp(q5vV(WrEHkiz1QpG4Z8WXtSjedTmaKMcREOyHaFK8eYLl28d2U9J(rV)DUZ0uUEQOiqkXcZlYLGVqGdHWYeEYZKzTiUMNVSuKQWZPmybIhkKI0ustboJ((SYsjoPxThxPnWPRwUAnsJhNMY3mPynuRKRyexyw2EA30ptwCsnL4HFjnPWzeDuPqv9lMMmFLIh4h(ZJ5xWh3yQFHZs)zSemKLVlfAWVZoTAU0sRDIZrEQyvFijupsqm6cAQJp6E39oEHHMaONtoXqtm8ato6EMyOr39KJ(cikWaDDXBU2h(7BDPtQadDdyONT8C98CB2s5FWgXINyL7)5QWWGJnWa7gBdPORkoL4NhBGDq(iDT(P6q8RZv4W7UXCup)VnRUZl(19n0oMyxW73CxsFyxdm0G7Ac4lDLVhXVm(i9o8Wt6)9U3SCRzpd07eajAKbuuF7AODmWohR3rgWdGUe)UDXzSh35Ljn1Csv8ufM(afRvD((zmDVIv(SS)l3wSoIAG7RATI21cksxe5Pqr6sxjiWozjNYuVJ)kw5ajL())MJrfPRWkQsZfi3ZAUrou9rSjfYx3cWH8CphWeGKKmXPP6JI8AjmyOehRkgEdmwh0WAjcXiovCgPAf7fMykmyjVshYS23(COdyV1NrnMMUko(fS5Vaj26L4EPaUEfREOTtOrMv6lDLh)uELFRN80ps)lLLf)wpAbON8EyGcMguq)OoqQ4uoRxvH)dpehjSqPB8ol)O3swOKOC3udwTCXUE2ui8KaIvTIl9vHIjP)xWi(a2h5AJVkDkVpgihoJ(Y(8GUrmm2uP7i)sUNTB4VJOiKAA8j6D37O3X2XKtmW)7jMCNJU7jaQWZcYMzPsvkoJrK6L7WPUuNK8gvvk5dTxxKuuXEyWKrZLiUDqd9VEc1)6rxv2t73)6jX9VEm3)6jwdGdIwHj1fzVtjNd9tTjNkTWIDuM0TOkW6TFEOzDCTL6NS3PQM3h9tTx)Kv4qtjX)lQce3(PbRK3jj)v2n14EWg)qREY3YF8JIgj3yobtqXN3wqKRfqgLax2BXoWpcvz4h3QvpgRckAoaGe4lppUgOobJv7Sl5k6qCqaeYo7r0CFVU0bir7oV2LSCiCOZZJq6TrTeW14GgbbRAJxiVHo)bYOdQc1r3FCastVmUMh4VcdmsViqIwtQWlkE)5a(4QlcMS6KNRsBpYF1Fa)8bcdo3iIQN5PEPYr4)pGAkP5vWnu9XaBwg2UayMtOLoXyp1T8l273MVxQ0MOkEqUTaZKOvPw2c0ltXVpmYWp5A7P124jPbL8Nhz4mBiDkAwhpMGbLCnssU9OWMZmHniLrP3gAuLKXOdl9wO7ou9HQG1A6Uu0p4MfcREfKOniMQCJyJZ0RNoJ(jMmxIvOYbYAbZuizyhoz5G2LzRgVB2)M16LbZJZAvTcM84zdpRS(oG(dGRQyU94ad946BNBQcUJbVXI6RmrQMJY52vuMGxIn7cHmrN)pSvMt6BAbc7ZOBkXUUwG8ijOWlpQJwGjunask1tlyuQkahJ8Agqp40dgoSaqrgD0ceDudat3WN4WiaiB8up9JoQsgUnGncRmHBqF)KNlj4bLWFeLV11PsD7AUQM3L1QqgLLb40OSaWY01ZUPzclV)CnPnGRYiKIORh6u)KG)O0iXLJFJdFJp)(cNzFGPtJSWp3UgrXvQSK)XlRdHVnwVdTJuQLiJIGMmRf0rRynFbhqSJygokldIPhOeOLyGkfTkG)VVsJmQPuLYnnM4VLF(XNT6HsNrX3X86fnLSVgUGLopF)LTlGjSjzNoupoLaSSKaC6utm6Esbg1awt2z3IfuPjd(TnPuo9jyBlVIMg3isekYa5XSCbfSyDN1Qohr7sif1Y6Dufibc(GUVakr7H51RMu(qbKLkmZhjxprt78ZRursHUgvPc8dFqlX4AeWrZjhTs)LDM(aPXnnJS52LO(oUuUQhQIDnEQhYAp(CfkxEFovkw9q6CaTF9bdV95mdb46PlPIFqeFYDLa4MfA0ElQknx2RWTQp5C5200U4m1tRz0rnVqLiTWC(6MVxU6mXbSPBuRMDfxId(OjgUwqDRoF0Gjj8YavBUfiyBGIoUAjDkPaWcDPU8UBVYfgiCmgD1C6ahHNL333zmH34iakaybzpdpWoNaMrwcMug8KOZV3eAlANmwryk4Ui7peGdRtRnh3AIUZ0gd7jb1M3JDkuF46C7XiEZHBjWK3X5kMssqaKceJ8cEQjU4vQdRb38eloklHCR8ljOH0xy)RNUrL5H3MwzzYrDUte1a8lmc54m1es85lze0)GgLiJs3H1skxntntYAwa8qJXm0tvOwCqkcwB2X0XJjIst8uIFlm(KLmrwgAVLDFb7f2bOUtRzAj0uqV)eLcWqw6QsNJjKiyDKCHdRnoqzRYMdrfVtDCVJP1Yi96UfSnsVQBV8KsL4FIwsL7ZP22OuTWjQOvF1fsrRwqfv0QfmEfOAbItzjdMKOSKpCWBSQmtUsMnqDtYkifE(7yLtGAF5MJoi3Kv72qvP8IfnHOvhVrRJkc54CANY)Kq50gj3GagfzdKTclsS(3EQftqx87E9LrOIkUAmnGgvEuWF51uNHddLJwza8iNGFWueaAxH7Z7PCHfghZRO0CjPuCwkoPIs4sX9cPcredPOHhjgeNdt366iFYOiosJl6O3D3)UgDSjvAzFicAuyrnxkpHLhdKzkd7urGYfhxlWJKElwerbV1eEcf7IpTHJOSAYaCQWvAouKaSziLWnHrJ0Bo075XJnGoQaQ2q6OXbJ64iK8HaHD3PoBwbVzLAMe1pXEW20JwrjmlPU4J2y82r6bUCoSeYxKBNCV)W(cmcbkXWBO(0L)dV4fv8XyFcnsJSQKmANuPBkGMToVj(FDcWANTrpwj9W)x6RkUPxAyugMFHqA4x0pR8VZnXghf2lvHyO4jh)3jl(SUMSvrN8F5n3vwHSsnSsfUkA7wD1t8QOu5i)jLjKZhEEVAOtRUEMS(pPW6ovvMdlnsOBEm430I)Io7p3C4kKjVIKrtPf2aCz5aKLmgekTEnzgDtcxQg83gDGOvKgZz6dBx4G2rntxmKm8viNZl0uH)JofG)RsAc1aJRvXgzTMm0o2G8gs2pTPuAtPfkfDteKiZOhGGovGaaaAH7Kuyy6qE1lBrOM6uSM4QnA3bRoeImKi9sF1Ve4IIfQ5YSFTRIHvK8TB4qbUus15r9LO7uH2SUsqw0rEb3XUeVJe5ihKjnzToiUcph6s8cL156Iq(bFXU2pwb06ER0NvVosC4ABaaDV)oIoB20njHriJIJmBqpudffy8jRrrPXum36XtlfnYqjrL39Ic6pPsq0mA5vxDku(n0bhHgMPXi)zxiqBE)6dDiByabk(bBLvi1Xf2uIIeD2igyncVSOGraCKRFBIXqzazg7DO9uaPicVEJi)7qh10EwPRArZQ8z)6Xeme2neRWer0gSHyqTmeqg7BHH2rAQgm4PH2rM4SItYYa7VAf3AvlByPG4oqSrT6vRLo1q4yvPctB)00380dvHCsKQjrImB8SppWq6GaAG9nOs1A9nyoSZmzVLlVlyKTmo6QEcOkiPuQYovoqKo9dlUT7UCQ7wTgt2J2Qreo1dhjC2kDkIkZv0ypsmSKrjDxeKGH8koLZeVXdIp9I14riithNHbSuXACqgW0Tn1pizJWLsveEf(ya6yEIwCwfv2fM9757iKlRhF6AoZ7Mo1OvOUtnfxoprLtyxUW81Tlk2MrS5cMaY(OIGDwZEUcoE5QLNAyMj4PEQCBUuQGoaO90vko)b5IBaIEA)cOa0jZAnxbYrbiPRbQgaDSJu4W)8cLBylhiaAriNRHw)uSCDO0F(KYM(GzKh8dAsBf3bOA1gxkhBNlI2LIQ0txITkdYB8FyBCPKUX8KYBqZTGBJ69vqmjk4pXgL37KzsuwvPUA6YB7KMp3wIBMg5tPWZqXWBponHtjuP0UHC6oVYnqM2(3)ECqPRn2bfXniv7mOOyxsPRbPPXKoqsrXuzdMVHrWTRmeN5wxcZCyIxOrhgN7MxxUahRmdqDtpv(6PIu9HqROZ856rxdrVyAIIWiBvAB8iI1(rAQhQnrset8dnB)dxISyUSNiyt8noDNSfUMDnYxTz9t29lCquDJv8xXnenUl2ulOqLyHFj5GArR4axHCJv4SzlJ5cOzNyQphy8skaVAZWPoiXHyu)jOBpeOuUN5nvqqE2OVPiE6fso6kGVfK7)SdVbQ374oMuv3o1kESTBoLOzzO8ojtE6RoQMkRpLS(RouEsRA4QOKj53eCAEhJY)IE2VVFYKl0ZLDN42C49ayeJZy82WGV5fUTahPg5bnjX)Qo4oaZJ)kRpNO6qTzC7OOB4xCwh7yomwZ30Afs8MVP6SfnQjBA4ttLkZ3rdzHput9gMANXevCA09pHIJ0eT7Ocfz2brKTMmpX4kOm6iC(r0jhTYivBu3M4ObfoF335tbQF9HpvM0Aoy4tC1V35tI3MkPObT35BZMdZohOLqMsmBHkZyxmjTgn(U2O)wjABixecgIqWw9MePMrNubXD9e0WSGZjgH2FF(D4uNCEYNXOI)FzSufQa)5k6uVKU9KHPYKZf6paHmQJO72lBSus00zVFyI2av0qZ0sbuyGPCaadgW3M(r84peMSHV1hxKXr5KmclEcUVHnoQGuRi4jHPmXKQe)bLKq7IIUfOjt7b5AwvDtdojpMKZypLiUthKcmq8NgGXntbPoC805Hputn2zCzK6oi6G23S22Lz(mSODz3qhFJSqdJrgMVBtGfx1HI416xKnLs79HIXaoBu3vsIyyiLuSsqI4m73Mg6cIivScukplzAXyilNVu0qMgZrkvX2sBmIOKRGifrx7COqf1w5Pt4djhjcUFE7ez((y8WIpU5b26n3hJmMitg)yIyofoAN8i0ixEoB0lxMdo(Kz9YaaPeAGIYS0kvkVgIkfWAx(j)Dil1gsp)4YVD)vBda(LGgQxAUe3PWrKUzbhC2EE5G(NaFDiWUlshzvAwSbX49JBwkZc3swRzYAnfn5Pq6PSaRW9B1YO8XdZtug9KPU85KvriHWst)NKWoz9QVeK0Zj5shQnZRAJ3Ae)LiZQdM6N4uREDm1)VqZZcAyQvakoxXSzDMWJkzxzAV9JsY3WjbJO68aHQW2YE3KfXZz08CNaSE2l8eiCUmUasnGd8OvKfJAbv6IxrcnjIv)UwBFB0ETYkL06XV2jqt6szBYeFGIjcA4je4hmRooPULsIFiKlHIdHv7b2T)YqA7tBKWR8XiRGgVcjgxnDIDAND7bxll(71dUZHipjkkC(PyJMyqYoRoDd5ukqJia1NlrbcuPxCIC)mxv61KSIxLJGFTzBqnOevNlDx5j3uMDP3Hv(n1D6aliSVbFXuKw7K7Qr9PaC0F15ShLULzuv)7pZgz2)bS00CIbenXge0CQ(f5(sRuUgb(nwTRf83u7MavWJ2EAP2MLywGgNqdO7UStP9q0agWNkp(hxH0FWx1bHSYZIC(tLFzcOXtkgpMr5mUk8j4OA3OzoQBgVe9A3ObwIFdzlKTfAoeWZyO8konsmEAGNrlp16TvPgtR72N3P(WUrUTYyW1hDQ)z86ii8z8RCr9owMARch(agRnqI0zWuBGdVZVpA0sZA9kwctOZgCQGAIxeye9yyRLY7EIvDv09gEDeYYwIk55QwKyzDHkvRSWCGrdP0LdjRNjOkUxsvK5fXMgZFpuDKyDY3TEA8reC)43Sff5EeZP3tcyhmIx(Cvt9iBsK4OnLZABPH6Xy7jtmP4BdQTgh5JKt6DdhboTBXtMmsTOjrsjvGf1t9sWy3giB1gg)0tegP2MdsPUP1Tw2nmnTBuABLLfsteeCNRAiVpyP2UBvUvXP4OcXGVzuNgdc29kUXF9pCTOoXIkFE7BJrmhrx43iuAh3Y2YAJuD3PMjof2pEJY3uiSdkhsReauvO0POmy0Y)C9sXnYQHsQjgM(ecK6LBy7sU0tDQ5NTq6UmdmzVnfBOhXPyXY2gaNnuP6mjvfZV)ysKeaXYTpNIUZMo0xgKMrQE5Sk(mfYmg7wXkGYHkHNpvuSpVLOAo1hU60hGCR0PISqKjPmKVk9QPp3a)8oTU9u4OYNpXRr)4q8(qO76QqtMuSFwKluM47ebEpCL4OJ9xKaGsWpMtd(jW)67SJWK7PBJZpBbzNCXQqPHOkdYSK03iCXlFQkeRQt29R8iij126TYIrDjOwnQ6twlSqY(rkxQmPLakgTbzHhr3NrzciWCDAbKeJkffcfR6s443IwUeSh5KoDndoW)uCv5ml5lI7fUGtDc8EXPtRUKNpei9qyEZl6S)q9zd7fSiCFP3F8BHSFSjf3RGBYQN4NC0AqOjufd)5YTfRP414yI4z12UBmxO9Ni9wokuOUO3yEhr1GvO7VXn6rnAtc)7nz1LIjQ(FpSNfMQ8lcVNKL(XIsk0cXqMmv5yjSp0rFNjcDBPgOoO5P)cvCjXnIsN5deCKS0K13WvAdhK6cWLtCsQE012b9ui(GUEMgOlmOYPsbjMK5EwZPHFsdhQq50S7SmKi(rSx7mF4yws5DarGWuc)EMmj7Umkuo8hev7U6qOMxxrUUtDrUMmkL3G7ZOl5WnU(djUdKIsCiKU9lDVlfGxnd0AYN)NFCIlrpiy08O1g35LvVt6O7njsmeh0uifrv6SAyVZRjlmLKFmzIpmr9svtQiZTYeDACMdHaOu6JURMIyThXmHwLB2rtZ4m9(iethtnTgT4VqfN5spp5KqjaX0NZbcLDDi9k(SeH9rxLVoEtcLMPil7Stl3oulT0F32guM8H6(EYlzocaqhd4NM(dw3kthQfYwawSBckKyyr9oHj2t16oKoC(mr1vwxP)ssgQbtJH2ijTdgeKdeAl6qacV4cjGWgo6qsBc7STGMZfHUpD59wsZt8Owx62Y3TUYhffuVKOjLse3dvI(DfTaOsAVKkkeedv)N7u3H44IOXhS8cs1BRC7khJZTtdDpJ7kQKKD5jA3rj5SNqzEGEx3eUbgPNbIGciS(V2O)RodGdg9I01kXY9k8Zo9DlMY5NIJhIddQuHkFwSPvLLUCdMZHWRDXJ18Mxz5LUbl2Kkpnc1MxiA9suKQ9swtl66rHcpThOQ4jLQGGLZ)g0JP1LF8nBDX79Np6XJohDv2X(UEGu0xYgp5NtaD3pDX1nShzfL0r9e2psYG9V(4T(GR28KFP)bJARBDXLF0hT2xEz6fApRQxctDBkas3Y9lV09z3V9Ex39uWwEPfx(HxHUt5GYU6n)AGzft(Bokz84KmK96kwvQ5dlmdsoJHGzvsor1ac6TtsKAyoxu3UUu0hGAoVBdvF63LSXQsz75qT71xfnSi21VHQ6Q0bNj83tLcI1s0oOnb9E1uGyEfS5tv461rSXXAJUSHTu66AywrNu2NwgSNW)8UvNjJrArH8fJKQlxe9HlCDhf32nsUXiAURVi6M4y2M8422gXUD9eI2NqHPT9cvBIdxBIdzRPW2Ai948z21CunPLxFDXLN3W1EKppUXlsxf84HSwmg846Zh)ONqi)1c4Bt8KK2elYtCseAupzA7BV1n(KMx968Kq1hLs)LyALbwgTtRiZss08kLZcIt(fXn9tT6qz14rU061V)hmEpq8xzR)w1Qc0z2IX1yAWO8iixggD93cjX4kvu7j)wO9bbpgumUuX(qH9Ctu2d7vilFtcJwlaxzmStjvErd7vYTlypkFsXTvZ5eNY2Tp8XYF3DORrT1TfDD)eAJIzCZI51avVFXsWMFIEIiYc)sA)klRf9qEZFhr5DS36L544hkMfzPj5x56lcVI9scto7X2(uSqo0(ejn0JbU)Lgfk74c9PY2hehqMK2zNyH5TP)A8gtrFG9Lb(xA4mpiFpRfk6Orn6xMg3RtifQEJP8)9uovkob9adzq6PqoYxKw(eVMjmaBpkp)PWp6rAvtcOz1A(isRvFTejDyMSpw7rAWwRdAmRMsA0I)Z0bhwZIWGemW1zNwlV0dw5sNDT3)A(VuB(vWozpjX6nf5FOb8iRUyyIheNSKREc75G(PRDkd7rR0Vs47CIzWnViUJA4oc4bjbe0h8ledZudv7MkByIxXzS3yWc5AjFBs3dMcqEK2FlSTbT71uHM4FbVJ3HrsjPI5aRZLjbz0M7mDfJL4e)e(rAoSCw)yoGZahV6mGiTu2sLX6NAL2bttSmzmCwKs7Go6HiHPBrOjaHU0vIi5qIi3qO2Ct285QY(yjTebkjKZvBIinSNt(H825dL5UnIOx59ynUB2qjDH3aG1fZaSG33D4pWlnluYxPjPmk1HH08W74vukq4z0frcpjCbzDMSSVqLCUeNzhiMd234(pLBEKDspBUeGETmKkY1ig0JTSRmwhjwreGRde7qFlTZ4vr1jNYMFhr3b7XPeE1eCP4RRLclcNzNtyKsMZl7nsmXwoFncL5dARlPxSjsz1jGvcymlRY1TzjSXOZ1U2XQmQcC3MZMtbztr4Yqs4fwWN)eivzSTpaMXMUekkuatcLSeXRZXxyHwkUyBsd1)7TFdnjzlLktyLLoiL0Ngn5SummUursKQnTival5hdJlGjD35Zhb8MvSY2GCBX4kjcHt1NRQHOAChYfRFsMWjMXtuBZpsmRAPBH)CpteLt)qSeGCJVD1tEdatDtl0tZ1JbGCR6wO8euzE5EgdvTY94NuBtAcBK6hP5SMobUX)CJsVIe(Ai43guFWUBFyKowo6Hp0jx5zjVxaT7NYbP2ZjDcA2QxMg6vf51kqsmHd140DjXMHzRIOSSCtcf3sHnJHui8jDQJBQZSbKX5Q3KUs5x46XJc8w4hTylf2jeLNf2O8UWgNhgIVxgui9CD6THnqpoi61HUWRUPF2MvbIznMgZzEVuPzBI(1kKd84(yWCHqRfuXktINq3ySDlKxDre3iK6CDG49zJ8KdYhz3uKDR9AUW8TQsOkJHpL1L)fRJHAlosswpRexEaUTUVeARwx8wXAmAFX5cMWSXFH4YL2Dv8m9XtyRegIw2BSBcIEcJXEvs3bXFsrPiJ56eTrlAkwg0h)kuJCo1d4BOw8NuR(3O0BEKe0mKxbWMJrznjqorReiw2VRj2WKZBVOUr0uy8IB7EX75x4qUC(z1aO4T)GUKARnYFUqkF9tYimboId1dpSwLzVXmbPVQhMNbFOkZ3aFx8Tn07uILyHsjUKDbwAcE7Z1TckGxzee3q1329ptp4yEiqDnOMSCXdWD3yo7AotRrCdcv8S5X2pTIWLHU5Ohw82(j5JjOdqhvW6rpH1xph3oRjvwD75MmXarepSTNA21RlIjXCnn2yIhf8B)L4GaYvaGhcypgRkwCZDfGbPpO9Uw08sMSdDAniByNN2XUqMwtwT3niHP7EsGb5cSk(5gOslTzsgPFLjBKfZFvxvKyggAwAodepCKYXxNuTcoflr0jb1sXfMEw7PpqNKFMYqnPibx1iGAQqINOCJ8sNWBX(k2LPFi(IOMsPWgq2KIrLP0kmdx8v3DRRejlTJHYOpdYNYTnxrgLUafBkxD9l)5pKz4MM7RHxdZO94B)BqRkC3KMB8Mzh1Tnj8(gMG96sHrY3JfH0RLyqSMyEfMjgOWtWM89zsM4ooMJrQX)jwhigD2PvR3AXLF0v15RieGtF5MN7JAJPF8nsXUaLZkXh7D0I5VfBvxY9nRJRT6sYM)um2NyJtP5YUTtbNdHjPaUwCvL1)2YKqeLNxZj5ykxdjbmOY4zvvso7MPLFpK9yoTSCFKCHohQVfnNUrjaSttif69NYKgF(dHiZflA98ctdWSkMkitMdMMZ70lq1)oFCWI)f5I3K1wYhfBmpLCdLzEm7zCQdCe7SAncdv90P6TYcOdK2yzA7NCkG2gST(fmbmUMLJl7zca9H1dh43YrgwxSNNYv5(ftL7gNYnwREwxGe(pEZzIZwO6Vwy8dVIF)nysygRinUJ)uNitBXtk5fKNPNWsx0XKQYdkDhdM2BE7Mp6s)Dr86fXhPHkus4gjlEczCfoYfJMVvqi9W8LTnmYqU8sMCihR1p51A(PNO1L)6v(07)DxSwlP2p(8w)biXmhqi7ME(GmIL4eo9vPKF(dxTQTrgEUNEuGvoJulfLbSHsrKizSA7eL1apgIiLCwLmWyrlKclyB3OVTHf5TqrDR9J4gOxyO6JpRtj3xWEbYvTMHiSYYE8bjNhu4youM(QwOwrwICAo2SymoiUnSxObDqysc(I0(VT)zRwTUDFvpmOvf3ksPZKjrhRy(iAiYDmXWa)rAYf3VYtges)UFqGyTQLJrpFhOtu3784gNjce)DumnnZpi6ArVSRmKRfzc662C8WIdQruuQBzv7R9G3C1tDNvF1Z26DVvhX1FMKknvF92)lm4yJU3DlVhYIW5MSptIoJhgZ7TLkZNRN40zYn1mOZMSpCO1K(EFDRp6egVIrz7UQ)j6E5IgKi2g7s5guLsdwF5FiRpBiaKB4BNNUnNwIsTi(eJX)wnTl1Lrv0U5EsXDTUybdftBzfUEQmbTBcphgR5ymOyfKiEuVcBmZk5GXdTS)1iG9xfiMPZNJe5XNd)l6VuuiYfOdzlm4XFEK4W97mn3UerXSaQjuRCJtTY9)CDXVT7OcGBerRTBTrRvPp(XMPFI2q5s6srXi2lt2DLA(OalASevqWMYa0sPuR8G3uEDyb7ftyEKPdJT4rjJb1SReg7Bk5uX63chwBspu5fFvmpJd0jcMrK0g7BLmLnp)IR853UDtQG2odcuVmogtjN51DhMI6YDatighQss23lNJfCC0GXip)m1Bmv6up1lcvtQuz8EC)0hvuY)Xg1DDkTWUsNI0Cv1Qabn7RwH5vffEDIoGFTB0bAAMq08RUtRREk5jebNgVmTN9dkGCv9oVnSmENkNhpuWu8r2(bMcIPzxuH7DRs0(pP3XMyFJo2l8t0gYtAIA2twlvxxqcAK(ji99NaTkaTE)KmsdK25Tl6Vi88pXIsRMbRzHf2uKgXzzP8ANGTYV7bn)GZ8xds9fNKjQ1pCO6PE2HozQRnhY1yto4lYVH63V2dKn2gQ3GOBXPMCBB)eSCHGYhQHfCVXBg1koz1mijpvQiU3(IuIHbbccIXdjr4Oxy1B(XTEN7269)yfSv1LnoEC3cUnQ3xHAAwEs9ykkoSDK1nAeP4B0uAoNFu3KJruuu)(L)K94ANUjKXNeGK1)SffqpIdSwZd)ZluUHDDIE68YBCR6j0DGtvaHTE4b7t9Bw(rVlmyV278huTkkVllj2gckA5jcLOD1Ehcjsz(do877GSEcnYhQ4rCEPjqPK7YcpRZhM08h0S3lXRpPdHQwWZhGNlVk3RtCyQhmD3Jcq8VEu6o0s75pefxxopv3rVGFhiCQfQ2BQQLajNQ)Bggd3CSDEgXpG83M1tY99y6uqT4yVZNyFJUXzm7ZywvRw3RePIGGlhB0(n2pbBXsP5o4DJ(Ybx50m13J3XqXOqBY)isDJRbfkJMK18shXLVq1d5jpX4sZbTAh)PfCLgUla9CAp51rPcI33WjwWGCtjgchOYOIJaczKllAiSs9)MA6M6JJj(HoD3A(Q5ks2fPVkE3KkkiU3R(rj6yJ9k1xPp8xF3N9rHY15fBV5TY3tG2(tKRNFJRqcpMnI5L8EBZTeR73DZBsW))T3vZVTrruCfLdfzXPacj4u0IG6vKAWXnnfPsKYhonUkojATlPOQQT(J1FqD8US7g3VurIiGdWHkbI70iHGZ5upGaje)byvX)cTIZ8xaZBM9Jz3DMzN1Mgqa(GL9SZm7S78MzEZB(9E)MKBlVrHz70WMqP1NFcQpVKrpnepvLo0LlRqjhPIlnpru7z)WJE6p(W5xbKjsHfPPFoXXij5w03pRC3y(V)tF9t)SV7zp6ZNmNmIXITP4ZrrCWO4hyQwGzqJxXrVAPK7wiMtijuFaHgiqk3tkDxtYGk()6PSyUS72ss51qm5(B1Cz3PHIYIWmGxwYQbVfN97zymizRj8As1yswbmqYXK4YrtJ7gXxb57k0LVWAj)WjaUBqnjPVXqJ8RWD5N0Tw4G)mV7ueLJzy4djqzN5G2SbbF6qL7ItciIlyW5To6s6UK4FQY5u4bLo)Cjg9zjmqqifiZX2amRHqJdeR8XTlGquFgw2Sco6ye38FPW6pKVPtcgqyaWx8T)dCaal7if(GqzeW35FndfER)FOWP2qb2JeMuS6N5bdITxAqRmnLGy4JL(zoYYgu1W5yzIMyUOchm6pTc6IqskJNFk1CYi47zQGuMn)vtw2XIpPeZmMOXXtjLb4TcgHe95tEG0MbVPXZni7eVpmi9KCmbt9BZZtBmoSLqiHXY(yj8CUc8La7(ff53(bMCQE7iiAyltZBfjiNNC)GSYfN2sIGMpfvBO1OFBntWTuWH2D1WRdbxTG2)M2MhaznVAa)MgnCMtDCsYiZcZabBJsmofZqi1oeI51CrVBBK)SBHYWzJLH1h04alJ21nrYCggdJTpR4WuVi9jAIVyDtlm0TyvWQMJWUSnJlrisxQimCuoJMrsxxHIhPXfx5gywnLgYECq(BuX(uJUXmsRaxPooz86lYImUPmOUNPs4uCAsqpUvX6WXVCrDoaUOO7IsiN79cQ8iKKgBXr1e5lWnTW)lVY6BTAD9Q1US(QBSXU7irbaSDUNU2U1Qxwt)Q7TXQ1llrP2B7v)au(lVdQuv25Y67VR22Bir5QU7gv2ScQK1QJUr6Ow7oxUmZcgDAAijgmc)i8yYcfkeHDhmiVarQ(f7TrsbeYGFlBJo9VZcZFGt3faxu3LWafoOEg8QjfIXqiGn8Xfbm0Fcwgri7Y4f7lT7cXZE7UlI)Ue(7ZJ)Ej83xa)9YaadCTDSg0h9AybfClmojv61gjtcwBN8Kus6yCOBj(Dsegqbgn5)aJVkMqteHOSq2bHIqJHNe1uiPv6mZkonnHH85aQ9PItz0ddM6AYkLMqvxcjNNegNhtDoVx6CwzIf1XtaJPONa2)Gv)gRpm4FfzTxEeB46t7ps20NMMDkn5mgTOzzs6qPBO3ZBE6tfX7aTVtr(M)GHZZlZb8bt08VeV8hEqMOjq42aAtYWYSPjTPIsIyeOvOcVLi9XqAmJeweDCNENgDtWJZVpxjMHyJqqO)uG07E8JjhMGYnwGBzcoTcpwtL6mi4vShKtqBuNqPrPq2qXExWM0HO)atpdiGZNeRc5j87B7w8bKiCaeyE((VeNW8VHZ80y2a9xsEaeO9n)mofhuMe9Qb)qHPNPe9U5rDfxh11Ed8yjLlHpy5G0GJBEffqtpa)1E8HL((RQTdsPaLj4GeLNzLM2oJm1P83DNZPENKuRKWkSOoPZBtIIfNotCpfQAis1cOntRkIqjkku3q5GHY4gmYbghiAfkWDy44uhbObLb2cP2kdCsjQYbgaVHe4OZcpOfWWtAk6BwobXW8Oysn1qEEZg2PNjsphNGWvy2Om4s61jjcQ4NprkFMPvkLAoPLFaDhaobY0nE(yUkBomm(i3uMVMyIJkBuEtTvRwwVELQLLE(BkJ7q2QBh1SpJtkkzojtifXEsCNqcs2BlyFCQW5AkM3jp1elQE8ZzG8FI)VIqh3ik(PHtiH(bnKMl5Y)LbbVa6KiA2YHkn9)4L78unwvQAjFaxRswSk6LavxjPZ377ZgBG6saeX(BvP2EL1ueVzMjrisOeK)TnBcr)NBBkNwlFlC8Yem5YZL9xjsy79nSD6ds3gTUv20GkRKOB17IUx0tvGZ0iOvMkJ4sA0HMOJL9ht2kLBFbPDqbmxhjrlITTnt2MWmTYvhAlVLrJ(0S4F9plHvEP0RCENyI8VP4ynxEMzLWJTKtLNHjvZ7JRWTxVU224nS4NIgofvUiQ21tiVOWW6sqaVPIC8bxnCiGXbPokTFQHt5TRm0XYOLRsgwRG3(EdVnmj2hru3j1riO2SdA9uNE5oQdS7H(3Z4vB6yEODlJM9pWY021sbnDamzco(Pr0su3shiBjD07zD08ng38jo9A0282xB3oDCmCN16n5xMbgDB06U6DgyAA37OB75h1h57q1lEy)2NCV9T)OT6Q2P4fQEmmoXCimD0AW6UAyu)ELzrFoP)qsvJUEUJBB40WfM9ZO3jE39kTmh2SyPslFXZFSZHn1W1KZR9kJN7jO)2mWnbTED(nxlBJw9H5hN9pq6J3Z0gVAb0CAwBDaJ8wZDOJX6MMdqp)dRA2wdEFS29mnpyg7pK4DcRbOk4yxZwJit1(cJ(vL(TTEPlroLOvi6Ap)OflCXt6eE4EZQHd76ZQHbOZNy9YT8UlqZ0hzm9AIEi70VBo02(GQ3O3xbNxl(LYfgxzZXZnU0Vy0WbQtJHDD7DMN4VgbgdlOsGQG2ohb5bESgxAnmJlcfCSZzg7o(WXJq)C34PCcPphVXRRmZmZm7Xqf1hFWE5oYVTEZJ70)oEEY9N(IZ50CPcfxSW7o3OF7A)j
    ]]
    -- 更新记录
    local updateTbl = {
        L["v2.8：现在点击折叠按钮时，会重新排列位置。缩短拍卖结束后窗口消失的时间"],
        L["v2.7：手动输入的最低价格限制回调到之前的数值。优化窗口折叠效果"],
        L["v2.6：拍卖窗口刷新时，不再重新排列全部窗口，而是保持原位不变"],
        L["v2.5：拍卖金额超过1万时会进行缩写。ALT+点击折叠时，会对全部拍卖窗口折叠"],
        L["v2.4：3千-5千的加价幅度改为100，3万-5万的加价幅度改为1000"],
        L["v2.3：拍卖框体右上角的隐藏按钮改为折叠按钮"],
        L["v2.2：按加价时，可以直接把出价设置为合适的价格"],
        L["v2.1：如果你的出价太低时，出价框显示为红色"],
        L["v2.0：重做进入动画；按组合键时可以发送或观察装备"],
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
            GameTooltip:AddDoubleLine(L["拍卖WA版本："], BGA.ver)
            -- GameTooltip:AddLine(" ", 1, 0, 0, true)
            GameTooltip:AddDoubleLine(L["鼠标左键："], L["一键导入WA字符串"])
            GameTooltip:AddDoubleLine(L["鼠标右键："], L["复制WA字符串"])
            GameTooltip:AddLine(" ", 1, 0, 0, true)
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

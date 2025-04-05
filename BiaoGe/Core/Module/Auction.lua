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
                for i = 1, BG.Maxi do
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
!WA:2!S33AZXXXrcAVFeF6c)H9BxeDmxOZZyoy0aqnus8iyCaGGGyfEWdau8IJbJXnW0drVCq3yNUhsctthuulnFirrAts9YuVLS5kzsjRDTe4tfX(ty)lymda(K)lS1RU76Dx9mG0Y3AesC6URSYQQSYkRSYmRQ(H7)hT8pQ2pQ2f)F10VvydxpNMZCO5NCIPh7JDx03Bo)wnx05h28uZuVEGt4b(FFQz)8Fa4Vv2rn3GvAyV68oNkSAD)MlBhwDLQHUl7uT2QE2l7Uy1WLA6eSKFJAR(Xl2ki0FziS)Dnxncv)0)FF(z)b)G)UV22BXL8BEqFxVWfgDSPNFSz)pw0hKn)t6n3jDxX5NUIL6cd)2pCL)BjfXHwPMDOZcTq)8VhHQXQDmNLAAVyORVxWUMni0Uz4F)5Q5xnWVLxTLwOURNBWs9nc4NW)N)AW3Xi8NUa(3Z(d)V)3B1WFr7gw2TAABne6NQoENWYVP1PptFwG)GFQ0jCAcsn3jgS0ZNRp0NR3YdvS40h3j8LDAoDRLZhe2Saca4FnDcB10Zk03R1Yl40eMOR3XkbAClUe8LIauM)zQTJNPe4FkKRqby5wgLDhVA4cYTULNFOv1XlnY4dBfUKJxm6jFBOOQAY3kT)M2l7eKKKtJaNyyaOKRwh1ilyTNH4tJGruQmfFslm(tX1AsXqY7WTq0QPSD9qvmr8OaWDFa3Ao5lWGFr0p2jC8cvItuQ7(qEnDoMBqOtZHB0a9PGuXlHikGyidCEgyeXu0Vjupc7f8r6uIz5Wj3xct3W1Q57n6s2EEonGCFJ4A7pUdHeLdb3OvbPhoHxD)sZg18G5AkNGa7J5CWMo1DpvEbSvaxkyw)jb4gm2DzNq7q7fA4K)0NPO1PtyOQ66vZ5uaGIy5ZJaRO1XDwTGeMba7oMpppdareKZuGQShUEiIWmA15bd8Bwc9ov6vTXT2j2xvifi61QtSVCueQ6W(aKSgmdF04M8aM4jH4bWcznei))SLM)W544IN8i5gUr4o24C3R9fEqNlDLnF1hTXn(Go38I5okSiHPT1dE)ox)YmPrN92x9Z7CRl1(38XBDZVRZfFZnU0)s7R)kTV4VCRZFLnp75bj159E1TENR1(QVzNV5IDETR0(kVjg3KmER3ERB(TYZ4V)Y0zCZ)1pHPG78H3RZvU76p6d34D)NBFH7V(d(22x(2Do7R05g3R9vF72F873(cxT99oF77)BXLhe(R)UXW3(vVx7x7MDo)RbGFZ7Eza8Dw73qGNUyGnRx)sTV6xU(d(S2F3xS1z)Gn)QxTZn)3aLxNp8HyudBbCW85FhagqzaHHHCDRBV5JVE7Z)zD(OF56p6724g3UZdE3nF0Dx)EFai)QkayUE4AS56XB(WpNjxQkY9UxlqR2Ap7bJRKxzQxx8Zw)(3pF7x)7AFTRuGuQSFJHQCRZU1x82RF)3O9JUE7lDfgIbkPoV5d34MFdijjvO4md72VZLapS5F8Bb9WaSWHcmaGhWaaWfhVNitLcULn)KZVXd(vyG28tEVn(MxHj5F(I1RV)9VVbkxMUb9NF47(ZBIZtca0nlmaYruCBskwIBq6qbMTUdIAagtifrywzoyKJU9yH7k7C7pQ9dVQ1EfrMeiyO3O6dHsJkx2rK35tAV2A48sgZr)fgmrvme8r)fAqpDZWbodUpU9dpB7F3RH(G1ZeyrtHbVIHPZB9nGHSOVeaacJ8iCa4k26nFnrCG7hW4aatN35CGH0j4GPrIkLnEW178EFaPrIYZg)XRb)IiLVm4Vo)XxbaLq)hFsCn7N)m4erps3wesGVulxgI8ox8ARF)pvKdKovLCGyGw)EFv77(nsZ)MF93gNexfFxK(lqr0(YFa6dqA9ZW0HSlshIuGeP44r20uCYxejAuWlJ0rLzPeqSazqdtL0ySS3eauj4fp1HgeHN3iDeHNEgc3NEL2x8BOfr1(EFdCQUl)HemIMSga5MF6f28tEeTSQ1x73sGKPXE53U9vjzg88gV5LzhN(hUjyqhze6F4MGbps6AW9G0DnKVWakIJLae(zg5Z39XB8O72(7E1nU2VKMeT5TVt83LnDkqIW1(YnVWNdM7Nw6eCu(n)a43FTBkrsfU3xmBjFxA2eZGsq37EHY(atBtLLKzGtslkZ8thtri26gVs77(URV2Di1rkAXwVXBsssFRR91EdScCR)D3fOVZF6SNtv7T9JFDEizq9V9CDE)B1(IFbqXaYStF5naQtaNU(TacdEDsPUguXmmaGp25lVANF)hby9aVU(A3hmz16p6nW6Absfd26RDL1F47I1laKxa)aOLbvvJIsKuVjvJpdxnGeJ4QX7Cos1a0KU3xGRgiPCjvdWRBCojvdW3bvJo36vXAFaRg3(o0vdmvxGOiW1QKFfuMT)QRIPe4sgqpIepfNiSFGkrAe8NF4fFMG)8dVeohXVXugF9hb0EoUdIG7V(xh)rHrdi428UFv7hDt6j3382V9wV()m3W0eGKK8F6SVcon4dIZ3tptV0AWJbnyGWl2kXDa9vWpQIKNKbkQoFgwFTlqQ1x73Rq26vU56R950c8IfM2(nVB7Z(AsK)n8KZVJeeC(BV1REBAeatobjrjZJeUAaTezUAqNF195fqlPgqJaj1aAKeBXcod6mD(wEUHjlFf(gaDOF8BALdA6khQP9bl3edcOidZjAZas(ZfA38yoH5KA5bY6NbRA9qaONgSOwuLOOvyZwof0wD3)059aWxGU(anBKxK1wIqoD5HxJneKIGKTBSm0saHndwPHBy(C9NROfloJGb)lGkaQPZcFgvvfm7fQSlvYcGj4pOCPTrm3tJgbbNXTbsEaDn5yELTTPYYxiKN0zsBLntOe8wmscvzUd2nufYNuriuuwZo(i5xY5ufTgUXklzxGJg30PgM2cTHzqRfWGoqrRb5H8ynDavlry3zrRNJh2fA0YrcOvkATRc9r1EGLDSHubVck5DvW6zTgSsLyOIk3y4qFqgKKsngq470WrtSredLmaOQcPCWybbFQ8e85Zy(bNWrByhem6(3FEmxpwueqkXQRWYLa)adhcILrCWt1IwlcrjDEXivIrvjWciEqHuOQsEmWfu3MLMl2b9YnglUcUOFd)MOkpCykD1eJvHAjv2qw3SHZIH5FUIWb1yIhmL8OmxG1gMmf1pFr04vmEapepoMEbFu9PXzUi(rJemuKUjj053F)wTxBTTUWvrVvZpgse1d5NJbav15M5qtVVxAI5b0ZQZpX8tow1zo48tmZ0vN5LGOaSgRTUXD36d(x7CZlkbddcWqLD9IvEXDAj9pyL4kxyJ7)7KHHXNDSXMgwhYHxvCo2KNDS9HseVw)C9XM6Y2NA6wlJDkWqwdwMn1dpX(M)aGVVZb4s4aJnX4hyEqkduUcFXDWXgEEanyQXKGWdmX(gB)Zo8uJfbWozt3P2XCMZ9NHQlL4W8c2lE8An9xzucx1PTkxK8FL2L1zKd8i(nR50mjldGeycYYaQYbc2Q1DBGTm(PTkbefg))70GcsvMLuK6ZqPxqFLCIGPCqzkEYdalWl(IGEzijPGjv1yuuwjHPPTBTz9HU2a6Ndkl8hdXuUEUt575S68laDuYP7JN39RUk0cRF5NH1wgVmn6vKfVciYcIO(idUoTvfC9eujlYLYaLHjH(FXeRugNk(FKMzyAvucqLYryadMcuGtufiEUnkgvuWFOH4mIIDUZBT(JUoVyhwjR5g3VrTbEHCq4rEdZ3le)jbhsgNc0DpanGcDGFkFUOetK0wqDE3ny2pO7GXYVHmmLEHbb)BkzbvsZn)WtVVHNDFvNFS)VZxD)Zm98aQWlaK(s8nEok1n4AL7ZnGRrI(IScfLq31erzLTfMmAuFomTbQP9vrO9vrvrwP7BFvYC7RI(2xfJ6ahhQNfxtK8nPCo4K6sovCMzBOeXBPLHETDEYLCdD4ANKVjRKpmoPURDsYSWqs4)LwgmTDQrp49JcsKPXQVd0Ixy9rX62dtKvn4wlZOKj89HsCBndYWe4grlNb8GqHbtCpwv0wey0CCasaPSB4QC6hOoA)dWxqNKccaHS)kSk0h1KooYF2LvUOKtc76IS5JATqRd4ACHArbwxgTqEnn(Jxqfu2bqdCCCuvVbCvnG)reyi9cbjuFrj2jj6VJhJRbqyYQFAUkLTO413b4NpUi4u9iYENM6LReI))4YPK6xJ2ebZcuAzshBGEocloIWEQAbwKVpuSDOugLkrqouIEs4IujBb0osM3gMAYNC198kR8OyGIp5PMSW2sJchgzZYOrjvLefypsu6SGOgPek9qqLQ40gDsUVcAUtemHhSuZpGK2b1OqW6tbs0gVPFRvMYbospiFb1dmjg9Y274fTaJuogmBWblNWPbz92ds(TO1pdOFCrlFpy0awuCuzW(aThaU8Hb2JlORhUc2LxWoCwWxSWwdJLQ5kDSTN0O7ITABlOJo9FK1EJABkbc2MHgIe20vcuejbk8kI6OeyevdajM6PemmvfahH8QhWi4udgSBbafQ3rjq4EnayQ6(y7gbas6pvt)W9QOUBnydXkJ4gu3oP5ssErk8Nr6xdD9cCAgkBCxrl7csZdGtdZcawNUA2nfdyPTyRUzdOkmePi9Ybp0pl4pTzKOcWV5aPrhCFIH1hq1PPw9LDAIM4kxr0prHCiiTzhEI9LtUezOiOQfTanupRvSDbIDydVrEzqK5bQdMLymVAw2G)p695w2UrJd76vZ)KOVNmzsb5uW6Lw02BrNg7EUL8pz(css3UvOpufZrAfc0aA3J2WXggfNOi(lWKCa04ebC(CZpZbZbu2bOLz)dYMrPQsex34Id1NG1TYsQAu9uPmbhqonjarbAYU)M(lJM1rycC(5JK5cbe(anFguc1tME(2SYFYGSCImLOaafQYxCWMYskuvPQBt39bQjAx7aS3S6mEJ2WDXJNpWPrDE1WRJTAC9s(N0ZPjn1JNfxHPNJlpq37iUhdbCq(6I8dGfQHWQBWWa(cLDgjSpSfpFlpbULaTXO1MLNkmxOw8iF8GRBuQjJuvQnEAdJK3s5hOOs8qd)Jzcyl2QzthVqKHcXbxUsqd9xjDW4KbQHQT8QiSnwn3qLKoPuaW6LX2gFWO8jceSpgAY68jwmViTrYlOdVMiVkbygrvto2(NhmaUoymCYBSgrFhqvA7NWkcgXEah3JTuiGdRFRDAAjnYmZp)mtnlSLKuArV2pt5bxUCfT4TeC7VK9gov2KscsGKHyuMXGpMIxUgScCttSOOSiYT0uYqfzer70NVL3kGVMxAEkHTrK(syHJLnsoaEqvrp0ly30eKcblL(TKgdldMQUqwuQRlJnnv4RPZY2UWPYGBdctAtSziPQepYOIqjXlIbTS0HBe(soRUpW0CkvplJQgg9xAt8jO5RSjp0HegTI4ZS4SWjZAkT60BtcZOtK65GJImkzYXrt3jDtp11kJQeo2zmvxCcZyQeu2zmvcg9mHkbIAwpcmAM1lz2Ld7wlCjax8oSE(NMtaYpf0250D8ZVX86t9z622NlJsQi)0wjDMv6XzUiEKqJGCZNcjlYK7bH44fcQA6jmrn9vk(0rgFkIvnvkVg0iB1VXlfeBqxazEgVX8cr2lngGd2WE15GH3sEQyLXK1fIWugxxyKD)rd5rzvKupoGyoVVFJq3vG92ZaXrEOkTdp9OhyMzRkvVrbkwAyrUUg0uoAmGytN01ZjG1kbPUoxAKawKpef0tXfnQBa6OxnL8QiqKXJEXo6pdyttKjRdJAP3uOpA90BdnuguTT0qnbJQ4i4wHkID3nGmQGwxhfdIgfPKsxAEL0KwLv7nHRmr7z6e7Ikkc8iu714JkAyQueOyGP5IPl)xEXlY4JHTj4e)ivLlOCqLQHak2b364)vjaRB2n3WcPc9)OUOOgEPGrzsATZvWVOEu5FJBI0pYSLEeyOOjh)pqRikqrivOs(p)EmQitStkoPcvbTxRbQywbLRe6VC6qoTpKJkH(Tg45kg)Me13KvyUKyDaVhMapJZ(rCpAPLHlBd9juy3KNzFyvKcqsedGO0QNjt7A3P8h(FD0asFIudhPpPJ9jCsBKoRb)PlqQvuROa)hCTb)NxEe1a6KLATkAvvyJdG(ckeD2roLXDbMIUdes4z0tqq)sqaaaCM7hLzWWHYYxxctj1pBjrvA4MdS4Gqua52r8N(faUiJqnvaMRCzkKSuUB9nhGlfvCruFo6owOnPPKeQxOpqDWarBDlkYbAqtrRtaxcNlEnCcXgTk34EIJmWrHfaUS3d(D5lue2DneaGbpAFPhYvQgKqiKPXrwmPfQGIcy8rRrrQYueBnrtlzvYqkrL2MxmZFILGOO3kQS6Nj)BRDomvmD9rXJUGaTZJQ2XuKUbiqM7kpsMK71rDrZq6HmxI2i0YIs6bG9CJ6GugQaqMXHM4G2qkcZN3ocsmOzx6oT0LTOzzgsUxubdc72IwySiABwrmqPmbGmoYQtSV84zWaVnX(kyYkorldCuFVWM(n0Suq4gHRvZa)M5ZnbSVQU9Iopl(lp7eEbR4SyOIODrVYZX8atOccqfCKXLoT2iJxc2yQoCJgha0Z2a27kFaOmiXuQgUEhpvR6bZUt4bCdc9BsK9OSyyHtE3rghTIhIitDff6JyGMmsP7SGK0L752OGz9hiB6zu)HaK5nPBaMlJ6h4bmFxt9tI8f4sPQb(e81e0rSxn7OkSSlyiAxUpbdBp3InDxjmFUz8Wgunhva4GLt40WELaNAS1zi2cbQassuIh4InXn90WevWZ9mL2z9CjnaWSNHCErojGrtq0ZgNbjGwTO1Y2OdRoutdm1ayo2PSp1lB3OLdVv4XzbDY7z9tG5RpPw9hL38NOaFNFsvApWnIOYzJRxIS)6IctU81jRYa9L4xgIkUP1gforDAH2HTcgXM1f90NPG87WVczkMDKxmdeTPhlxAxMghlco6GDpCj13mMydAnLqw2HjgspmVmgSS(YWeNI8)pY4mW2lJd7on6joJZoFYZ4KgZzkrlSccw(ejU1YvmrUf09Qduazu8aUsJct0cF7tRmWYQcWxJC7V8QEUY8vnjtdZul6VCPkQQiQNUdPqrQ1kLvEiIvMioabvgLiSr1HI96riAonQqJizh7nhEBRjwYHA512PEHuHSoK2KOBQF42FgUL1KpMuMORFb6Cxr54ZqMiyL5OwRG(mOyBxQoaxGzIU00CicImSi2UmQ2WasLnRFheKeenQRkShgHOtIcqAjb6p5SyaBfuQt9u51tLIS66QtDCSaYVTX4h(QIQjtlEoTOda5hvRM0hkzI)ljNB3gK)JeToOJIgCbTa8GzUolUH)sPFg63sOtmJCBzIbPt9CJezNAx429kI)QymNOCxwQDVNOQ7NDuh5ul0OXBk1MZSXBYoQqtBWMc(0C5k8uQlt8mknQBQB6tKXPH3uesoatuUnjKeJmir2kcrhTRevRdfO7rRoJ3u(TcCqgSrItmInIxY0VXWNRqEfhb8zU4p0kzXQD1LuHo0kDz1HONdOMGgsSKT3XCQLLAJcFaO1U1OzBqx9bA80YEIgejNrhvaMnsUEjS7QGJjMc3E39(CdqNC8f0oX)VWOPcLG)s1CdQRANtOlpLcbThaHmTtC7UBfAsjAYxtImI2yEkOzkPasuWK3rQjD4dPUh38UWS191BCrA7LZspm7bY(2w)OesTeNqjszmKQyENswODPr3sMjt55YArzntnoBWqYPXdjmD4aNdwmFya0)Jsi1IXLan8cvvJdn1uN7anh0HxYXPbX2R1CAekCAmsCXo0d70nBeSWvDiXV3Xzzh5uEZNO1X9AN7klEEvysksoqEUN8SUUUep7zKdNPzjZZ6lE(4od76zd7PK5JqL(AdtUs84gDCCxUqVfVtINioCe844Fk14Ms7z)UPXtxVgdPP6BPQM7Bj9Hct3epMA5Yl5aTYL(GmOAXOiPGlWqWOSiUq5IpK0cLUULFkEFSI1HKEV8hT3(LRdamLKkAu4cz6q4ucBVKZb7iRCG)lXwhmS7S0rsHwewHi8(MgT3e3wv06yfTwaheAq6jValX2TCzuX4HyjkTwYuvCXskiiHWsr7hf4tfJkVme84z5oeQlJpDTxce)Lic1tg6N5quVhg6)xOXzjvm5taYowrVAD6WJmzxfEATXDs6rvzbczU)M8TQ1GNQOLPoVxJ0x4jGBXjCbOsa2Xd1ISwAlOsL)kYOkrKYp0AVdHB1sluuThMA)aAYasRt64dKmqqbpbd)G(PJZQzP44hemjKjewLN)2XldPRpcrex5JwwbfwfI1VAQe70n7AgQAM57zgQdDOijksm(jBLgPqY(9xSfFOzOqeG8dHOebQ4RirQhl5Vc6YbvYNkHWVYO2Ojih(lNFGYO7eZbuBWQ4Q6(DbliCKXpsouTT6bAfSaahJ6VSZm4TEKSY)Of2oJIsalno2IaIMiDckoc)s1f51l1kXUXYnTq8owxhOmw0oAwQHSyJMwtCnGQRMoP6dHDyaDirfF2eIFGUOtCzvKg50hY(8eqTNNlrmJ8rUM4X1OCZOP3RBAVt86wVbwNENtZerikoYVlOj)soZq0E2FxqjpvVwRKJPEU(fDKomnKBRb056ZSW)i82fq8a9LpRrhEsDvMfp1W6cKWDsj1f4i6W6d7T0IwN2IzaDXKJauD8IagXig2M5IUryLxedUTxgcA2IMsEz)AinRT989wDzGsd5ufdj9YaujxZOsI8cJPX0xRuNXOJZUEPYNIZ9nVAZkY9m6dVNmWoOfV0XtN8E2SiXrzyX11sdvJXUtMywX32uD1e5JOJ1DnNVnDB2ZMmsLOjtsjLGf5d9YqF32iB12g)0tegPUMds6Ct98SSBBZ0UDnBlVSqCGGa3bWAI7dYwei0NAvCsotv0yBg5HXaJEVSBG64tolSrSWYN37qeI5uQC)gIs7g2WHF2izxfQfmjZX(BK)AbbNhCTeaOmxPJrzsVv8H2LKlyvn5uHpmJjeqQxPjDQhIpqHwzj78dOhy0EeZyONYTwTgoAaN0vj7KdvgZFCFsQea28HpbNeszCCePgfZQuN1tABwg5qzHCeztfj7xEoQMBWK(lEC0LmNmYcsMKux(k1QMXCd0J7uA2tMZfF6aVgAhhK1heUzRegmjzFbXNPcMBebAlCLzVJ9xehGIWpmMgI3Kb92zWHoZt3fhw2mYoP8vHufrL6KzoPVPyIx6qvWOIJ38R0iilLwVwyguwmtRMw5XplmtW(HYxUc55aYG6aVWJ0BZqzcqGPA0miXGcfkeYOYI5ymdNVUEVgQi4rtCNYa9XOJAp5YK(v5YeKllkRzDB456cnvrCtDOcIeuh24r7eIJuVKxRLpk397rC41qlfqpO1vTzrue1P7Eo0c3pbq0(mnNZ9NjUFpYI3rS9Cxo)kOnpFcsWVxYUbqcj6g4G2HyKedL(zZ6256BWcSJMbb21hk1h7HjBSOK8uwyasKdDi68aqhb4Nf)aPzvOp5UxZgmVEgYeRfGJ2uYh0pWf1GlxiTMsp5PVS0vdKcaQJipSmoGzsiAKrabVqMqGq6oyDtw82Hg7EjH7jqMBz)l8Oo38R4VZa539Yyfcv49m2WfNDjMW5T9Yh5)ubiMi4LDdCr6OLo(assrfVJ0DMLbh1BAAEAda8SeiDzkqW50RvWjlQ1svScMQsqPqbyMQRlA)Yd2PKEVu1I0injPhDgVcaPJpz7py7gK59q(JVhLEpuvyqrT23TUXR0(UV76RDhIzyLEawP0fykvio1Tbu2QAPxos2Ulkpd(GhUEmcwU2BGpz)w)7UBNBCV)0zpx6HJK0g2t7os2LnR9Wcnd094iJtv3EQfuw71Zy7ilD2)2Z159Vv7l(fXNLED(YBS(J(WT(I3gFt9sk61GrPggaURV31x7(KlU3O7XxmyRV2vw)HVlEtbaY7M39XaMvyCUrrjnJtstG6jXZ46pFz0i50abZYKCcNgGzE7SyukY6OuTbtyxUJIJirHYt9gcYOcLS9kuUTMKuXszdoju0(4oN5J3(imI1Y0MfkdTE5uadVtyIPkuT6uIr(UOjRz3Z0tDZsAK8ldvJ(eXhrIQuzmvnk4VGhKDQYR2YO9SbR7wJwBGHR7nJxNzZtNDtu3fMPUxSg9tils3DwLoZwMoZwNwNfQ1ejaXm7kovkuYR3tC5LvFvmKWJR9IaucpUG2IgWJRo0dtFabFQ2WVM5bjDjw4h4Kj0iFW0E3BN78jTV1TPjHYp1i(lXWknSmkhwHgLKPXvshfyIRuPg(jF6q(PXtDP19U9h0E0H)9S1FlBvbQuBr7Am1OuEkKln9UXrlRbxnukpKBec5tAmiPFXZ5KIwUjn9HJYKvSkHPplavE0SPqKEZhgLZ9YOpkT))3JE3)lTEhdVrbfDFQQu7zO0l7NqXeV24IpQckp04ZGxzWh(teVeKpUWkAHppBId(7OtkXOGKdMqTIqwAuOK0B(0KTvIyYjV21Byxo)lHVGZXN4n)tTSB4gUA89BEvCJD(vxXb)0CTwa)cjLX(NA5Ucq(ErlOOJwnXPGUpUHuOGwle)8cUE1MhV3OhhFW1IVIZ5oKujcdG1hPh1gWeJiTYjb4a4PCkrWt8SezTBgTLDQW1zR0an6NMIR3IozCNdPAHyqs646VFR1x7bBCZxFR37JJ)ihZtYSpKdXmK3fZH(b7WJIQCeg8mhJehzZ7SmODg6Ktt4ONx8EMFHJb3NgWGhM6udgijaH(KNGyaELX7vlN4LFo8kyB7blO7j1H4Ue5yG8mDF06VnfO(YqJ534SWR9cgzj6SHKSZCU09k7ahLXp0jAL51AzHuKVCOKRCcC0xyFQPBHpL7uD3NrgVZxxCpAkNYBYpw9GhCE5POHOl(oRFIvEx4LtqHc6V35zlFz0cEAIRsiepg)1zt3uprkjRjfTn8KfhwCtIKmhcFuRHK4bR5Oh43ydqrYdHKmZVBZGX1puqO4wHa6UtUdlosqMlMaTWoOMk9zGJ)R3NM4oi6GMIZp5fu5WIibGa8Qq0Oqox28Ohi60)aG5KDqx8BLwbYAPMVMdWOAgKksvjgpIVFGcwNXihgq1am2Z4C7rqzuD05n2tj6oqDDmHxobNZ97kPWSWP32fAPKLIcUJmtS5dNdHaJqzzX9HDGYRkzQCadd7NsdQxKQbnUUvnxPoDG6A5uFWyPZbykSJReZIrFTOkl21Ibqp2KXwi1FkcXsHzno6mZutHRfhvrJtV7ROQstXutPkDaUBbcrUuiAqUAnsRBGUNC4t3DgRmyrpmjC9n5hSC5uGx)eRKTkWU0UqdbCk)eMtGQrTDF7DsgZEh(jQQ7NXWIM7IdU0ZLs(u3fZbiv)7avkRbySvCbTuQGTteOq)q7gZJL5v650u0s3TdC1nUbSPo)ioK2ujW18tqd1tKqxcjpRz6dYTfbH0rcHp4l9tLFsS9Lq7(juqQ8eJfHM9efiIrfrzLcKyJhrf2KNtSPiBvk5Le6sqXTyylOjcd7MinuiFPmRLQgJMSzUKBz5Gl8d7fdoqRHF6ITKONqAgEy7Y4dBFgGWCJqir653Z2uJXgLya4LVXZl7c3pLzm1gx2rrAZqSM9sW(EujMmwqyTGswzIzcDXzm1RwE6vxKYDmMkBtWEY(Zp4aLi5UhBqLh436pF5fkmc(KwwXxXaAkntKK0lReNVdURo5O7QANzRy1G6Njh126v(tGlNvdsgMEZe2YHH0L9ACvG1uBe2R6QosIZkkzzm7r0MUOjJuO38cuHCo5D4BRA8NvT(3UM38mzOAWVcGDAqE1jqotReWi93v46y0jpuA3nmsuEjSxUwI4UQyiMZ(fuai75GTQyERlcVoHjFJJbjy8Dyc1dES1XZEdduKr8pfnd(eER0c(nZ1nm68YdPHsDQyHbS0e49WZGsOar5HrCdE(2bFE1GddtbSPbveemraoDRLDA6UOcXnqOmtNhN4OocUm0DME3s0UtPSHGogUxbwoQjSXZZrTXBYvu1wYPGbiczHTd20jiGftSHIQXyIgf07ogtqa6WqocbKxnQGz37xjyGlbL36u6xYKJW(wLxXUOzhhaY0QtR9bbsygSsguiNHvjo0bLQPnrYiovISrsibi7sZcgaI6LMtajch5CJNtQPTBnKZ4EwqPuB1fxYzXJ3p6XCAkjjX)QcbuliiEcZnslDcEVi750aNG5IOwqQWgGSjj9klOuygCXxdoOQCKTOsgKh1by(cHD5kYW0fq2wiuv7kE8dAeUUX(k41Gb8U56)MuReBM4qNxp7OQDrruAW4VxveoIs3iczunrJyn2WoSGbOisWg)j7Ebt7hlri1WFm6QaO)(T6C9RS(JULkBfbb4YVD7R(HDXWp6kjBtaZzL5daiC2I3bUYZ5HxYn0rEojJFQz8zx1ckU2)6NX4qWysaUwCz5n(Eddre5hxtj5yHqnXimykJxqwoP0BgNF8DapoVujIUAlfABPZPRvca5CvqY8(lOBgF6JJb9zl955zggad6ySGmEoyCiXJVk5(B8Xjl(NLlEhw7QCASX0uYTvM5zDoMBaGJy)(nrmub5ZnS3QqdiT9Y0ok68qRlyBJZygyC1lhN3Yea0lopCIDlNAsv(EEHqPBNmzMBCHqJw9Skhj8F9gZyYoS67lm(IR4pE)NiYyLQYD0hkff6kEsoRG8CveLUOIjvMfug0aM27(vTF0n)BI4vlIpvfvWKWTtw8mY4YC4tLoFlJq6jPZBxOKbF(5u5G3xRFY5B)PxOZB)4n(07)0ZxR1LBhFAT)airphGGEtWCFahKNXqgHtDrYzNFXIvUoYWBc7ksWkLsQ1ttbwHqejvgRUoqz1WJbrKuoR6AySWzsIgSDR332288MGx36EpUbMxyIG5wYTE4l5Sk6sNrJhwjbm(4OJlkyFoipJ4B3Sgjqo17BwOpoqMnCyqf6eGbjWpKp(RJUKVFGZi(NcmRkCNkLVG5ojLb9tGoTTNeWFKhDfgl9Gdb1UhfiqSPFddA57dAe1dTcCF1KcIFk5tt98dSMwmk6kfmTirq3G69hMjOgII6dYp1(wp4xT5L(6nF1xVZ78L9zQ9mrfAUrgE0xA8zN5qtZVfZsX4MKKrENjcJLJ2XLLlvXKgtPfG3l7amjSM0FZJ78Hxq7LTgzZx9)bVvVWojISVVKU)vX0GEl(djTznoGCBF3(mO(WsKRgrhymX3VBdippY82n1BsU1zzZOGpT5NWnAktWSBmVlI1seguybKjE0OmRnYkPGjcTKF1c4O(aIz(YLqEE8fH)d(jjzcDvcG2cdr8NNXeUF3fP2LisgfGvHAJ7CPnU)VtL)Bhmnh4MI3AhuP3ALAJFy1moqBWCjdijBi9LrB(sfjYWIAKOce2K6GwmLAJh8R4xhwYw1emos3z1MzusdOMdKrFFJjNsw)MOBTrTqPxbigEeiOsemHiP033szkBFTRSXV7REsXuwXiMskXnyUsk9RhuKKgsDauW6iQ6Ck4ZhKfuS0aTr29XcATq(CpZraftUCfIE9O4xLKZ)HwbHU1x9a5ZHQUYQvajnhUP9kYCdVkzhGNMgAbnfJiA)TFDNBDj(reJmo(YnB8sKPphfmduOSVfTHMHxVKLHhAyssKSFHXGOB4fw6(GYKT)JhE25p8mZ(s)yL(8ehPMvkAj7MtGzkPFmK((Jb1kaAJEe1tdiTR4ulEv4LFI5MwfDwlbwztnSlN5fZRCe2g)Hh0(9FTVpi2NDqg70(I(QhBAh8GPb2PGTXQo(rO3W9hv5b2gzd3Rr2n7qtQT1FgwVqs(fQyjxHU6rTKtEnnIYZLlLRWOuLyOrGaJCCbjcN9xV5D)OoV13059(ijSvb8AhpxODyRGrSBQy9jbgkkwurYaTArY(ff5MY6hb6SmIKSg3UIhSBQI66qgDuaIwa0UKa9uUGfBEQx2UrlNa0e1L535wbz0EGlydHnqSZ(s)lR)O3b0zV1B9VjBzur3BeKDeuQHbitg62jVfqcxK)0FfHoBHSKYrOgdXHVvY8Uk7wIJzq9wSeE5rCs4SjW9p)lwwMj1rgjncMbRibKLqYiHPkSCE6ZvXEYGPQongIBaIHtOClOkxOdF49VtqF4on2GziB)rFxEsFLmBOHavIJdTsMThAgIk2uMD950p7QstQKQS)KRguOkBjxa45uCdeUDF1OkDyM8BXudMlKPofFQPU9vHeIIj(jBX948xNScwVJ1x0uql3yFkbxQU6mqVSYdJDOub2BBXmlyGVQyGWbSmkteqWJCErdIZJ)xvd3KFcnr31P6odwoxr2UgHLX7MvrbMERcNMOJT3luyP2TV3UnFtdL9416R(TV3tG6(tKlNyTlkcE0Ay4vCBxZTy0TBBQBmWmxSQgfMnpG1LCRp5yuFsXJ(0G9SGXNM5MYuQGRypwywTo3(JA)WRATxiprk3HM0TZORdzdM0N(Mtw6AX38XxV95)SoF0VS72yrsMSnL9zeZMkI3jPZgB5tHBwFMu3P4Qf424rA1hqRnbmAljL(2rYH6ibMOSyFzFRkz0ofs6nFAH(Y(gfI9ouusiLjIg0sCo8sooneRnjPzuLrebsIEJUzBg1lBXi1kiVQ2T5fsl5R2fH4getgUFyOJ2RKv5lUvwueZzKsIr5yjg(WGiRZVrn5b(E6Hh3l0nboCjhfuDqsvdXhjQ56pNQWNlck9rCMGbcsUaivyBaPyiX4aC5N3UaAJ0ZK8M1aIM7ARCBnu(tUTnfdaq4aGl)HFpCaGm7iL0qGhYXkNA4VwhkSJ)2qHNAdfKpsOBJp)mpyqV9sJRLPPeKK9vzeWmtBqFsWkZenCBlffXLpKr))S8UY6TnsocVo6HeqKh24eyaVjpiWG4veXwXuYYkbyJdiLOS4cDLH0R2fggu8yOiTP4mzgkzlVWbs0h6W6WwR8LS2dZS(y3KyzWSqwNqalYpacH8lWHdpEAb8VGTQUhsoKCMHKsjope9afzpvxD1Dxt1xvxF7hfD98EuvQ)kMMtn6W9QobPAE7V8O2(yPPtdPECqtJBhz14ST68gIkGODv58S1WnOr(Qp6V0(W8PxoStOoY(R1SX0dPZjyiR6hlrPyrEXE7DUyvEX4EEbNyOtoUluuCpV81dQgvAilLfh9vG(gmUd6JHdVkkKO9UPcphdOA5L)oe4gcjnhsTxweoxXXjvn6SOfiCzu67BI1qu2UGBL7ic026UH3TtGG3TecAlK7H4z95Kd05yzdxY6Sk110nR8qmjp0jhpXDTulJDZnc5AARYJOyRRIOkSCKcMJhBEfvjPZAe39b52Fs2nEocqNQ0n90WBFlwTVIr0yvsRrn160GWZ2KAG8SInuxERs0i7k2PKY2vmnIv4hd6CqxHszxuz65Ynq2gb00uxD0uz0L)Qzr(vdgBRtloD1TJt7Ys7T3Bpvrgq)5Spxm96WPngxNPV2T40wvKR(6YYhb0BRhix2750U6VxMUAVkYx392U9oSd50HtOGCbsBpN2MQzSyZ0ysQal5JqENSXgBSiaFGL2act9RKwJYvqOV8ZlW6p4LoA9djo4rXRLEekOuic9mKrtASeqdb3dFswWn6VmGhrxaNroExkmig26fgSjYNnt(8eKpBH85jjF2k6tbree5dfeAgoQrIewkUvklJuJGo6PbAkLFz4GIK0MueOOGVnLRctEkbJt0ZjYkayikW4ySMyQc42QsIvl2mThdZZ5r7h7I2GkdbnBQvuorbV0fVEkBZ5jOPZVVYWyzzdQtmatqTN8acIA9BQ9NkqYs1UF5fThU5qcOQu03pIDfe5AmcrR2wsxq7g79KTt)gr9o)SVRG(T2VmCcTiopeXum9TOf9foitWaIMcGpkbTQoeDSVqPivcUkkcPLW8XGzmdkl6DCNYNgTh8wM)XAQXeMSjeuerfXbV1wJEycgp3r1g1nYDAfYaPQIZGqRSDfd6iJUOOCufWFOsAluhhIu(hAEgD6TC4AvbOd)JfIy(k0OAagmEE6njju)VsSEL(Sb8tknOtNDNDiPicePxtdPsrqSPY6DBa6kol01EoY7sgFpYblNpn84MpLrCMEOlxldrwU63ctpWKcmUhoiXQhSL2VDg1uNY)R7CEJ3jvvJKOwOqDVA3Mg5kEZy4EFmvd9MAbkZkNkIUAuk86gfxQWQ5QVuDoJdgHc15kWOX94iV))QIVfQyPm4jLyQ6Cga5xjirKfTCTavU9mMZTTC6e3Yl2NuRyyo3JBHkteTNtJaVvbYuSHlvMN0OMso60BYN10iLvLnPwVIYoascuZnY3RCtQdRHL(MBfSxt3Id7TBRdglDBZLt7DBRQTFRyZDOl11VPA3ItfMK5EXGur7NKMgKWKLxc2FUIUZ1(WUtdkmSysgYoZR)x2VpLU3vJI9FA8esuwrlG8LAcjM5dybktIoZwnqxZC)jtDdkewtk4sd5HFv6Gvf)iCQR001(g3xBaeAeQdr0FN2D0NngJ6VyM9IsKUAq5k2Atj6)7wMYBQHV199L9GXL)RS(k9u2(awbXGO2nR3luBZGQwXv3UhfklLMkienckLveKCPcDHTOtT9FSCPS6wxqLoOavhhPmjs992SCzIGUkNjSq1VZOfxBA6)81LcmV5kZCToXKQVLsJDZvRTzLcTT0tLxLTuTHC(vyxT5KPlYcwYLcdjftA6r1rKvYnRBOCjFqUXE1HbCoiH9fry6OkVAAKu(n2dlYZ6nIXAyScTw3BHIrvW8rp46uXriykkSGHbheSb0ZreK)6tSInmwhoCWiVAyrwxUdDr3JkIZTDGxjoShshPJH97p4LI7QnloCI9JmoziPhRnUWW0BXt3jX74HAekkuNdfYUprdrr2H8DageWNfnKNF9r2yCgyKTU6kMpwpa7rtqcDARR(64mDTWWHLfodXbZtNNOJocBtUdpk)pXn57oPpVBoFS)T3I)NduHLojsVrNBRlE5VWGOdLVyGSiF8RbE9fyz5Tq6Ayq7NbIEr570D0CxUBgI7g)(1b)bYNO7iOLw2a7kgWTpUl(r963ViBKFXBz1pS0k(3UdHGxU()4WU9HNsx9oDYBuv5bfexG2QlKxdedAmWd(aA7ENdL4W7c)0t(RVOhQNcm(RWJmdYDqVKleTvs04neNBFRIl8diL)qEeHVfI1kE3NxaBXddnXcb8eXDiOL(qmdnmuPnWqUIUhkrBgI5li0z6fsD0JK4pafKaxqVq6XX8kZ0b2nyyXi4ssiU(IHfqM7sGleRbRy7gYhszro5WawfdEzwmnRyuYyGxtUq2HDhsEWMpjk2mHN55H9iYnSGxwpbhINtiYc4Hntgb7KjE7o(ww3I4jDYgEWib(HjoS1WWOC7MBmoIGiiYcfGpXOiPOgtcNwjOezchqgs4mXzs8bj6h()blnf5EUpK2ZvNhGn(doOHyEZRaBiQxq)aOj8aXei9lybyfN(NvqfW7LQ78j3EzQhQN5MZM(Rwp563m7YlBWqQ)(x2VLu3FfPhgt623p9FDLVBRzsV4ZsUXCPM7XPwCvi9S3zhP5VT0eBKEPRjV5oRozQXrktf)rspFkmKrS01OCGgh2sU2Sj34guIpJ9)9yrZSYlPCk10tNzLh3VfGJP38b08qzbqL0tIM6ZwwoXxgp9MZtFeWl6XuMA(fsU5Qqbln)kj38XqXaYkLgcxbEavPh(nPU7lOrqpO(AyKMASv4)PM6Mst)mQdrJ1KLhl52ZrVAAzFWTKMeQQFwMxCvPjFb02in1Sin35fsJTfW0KBDFPzUB6V(EsZ)xOXq4u3zsqurEFsK3KAk95st(sO4tDpumbbu6gZMDIzXuMBbPjVN01Fw2R(mkLabzgBgOXp5oFAQzgxAUpp52ZIzz(7JmUL8mo7e3oBSpnZQxpZotyo5Atampj0rUZdZ8OzsV1xjDJhaYOLUC(RthDDPj2uwcPsWwljTY60svPukhoPHI5eqX0S0Sx9yTaFG9Jt)fqRI06xxAJNKAX1tU2gMp(Xbo1muWhRf4dTO54i3AoVqN6r3i52FI08)JKRnDMNUaKRSlDRm3B(uZmv2fEonxYskjfm3nH5EMPOSNwbO90PH(uqFC6PP(yef7nagiDRjZowuG3Y3HvGhMbEqvKsU9xGYkjhsF5xdD3YSKERnE0nYPSUr6nILzQ4yUHA6sq)L04yZlOPaQmPxCZVBRhcIv6nVgwEl(CGnuXc0IZo24PM8UzEAuPv(CAavigm8GCqG4A)yvnV7v(ljCUaohlY2t5HUjuXvq(pG)xQTTyEbwVbrlu1z9YCCdDagIZroo)plNLamp58kXacNNE9ZSIUnwSiCEhHAE7hnY)0yqF8)03J((1PODD1JVYWqGpJ6I7VGtCu3RbZQb4eiRdbTW4XrB4TVI)GG902KlxyyngCmIMgoOV4xUFH)uNdAYV5t2ny0hlu2a8hr7Avi2bD7Dux(dXXjeio1UhzdZE)dCGduxUgh7GLppMBU5w)TNiEWWuoavgd7cJ4aIxVuF2WWbf90sJMBQXF3bh5F9HF)
    ]]
    -- 更新记录
    local updateTbl = {
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

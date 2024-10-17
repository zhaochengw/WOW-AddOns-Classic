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

BG.RegisterEvent("ADDON_LOADED", function(self, event, addonName)
    if addonName ~= AddonName then return end

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
            name = strsplit("-", name)
            if isOnline then
                if ii > 40 then
                    GameTooltip:AddLine("......")
                    break
                end
                ii = ii + 1
                local line = 2
                local Ver = L["无"]
                for _name, ver in pairs(self.table) do
                    if name == _name then
                        Ver = ver
                        break
                    end
                end

                local r, g, b = GetClassColor(class)
                GameTooltip:AddDoubleLine(name, Ver, r, g, b, 1, 1, 1)
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
            GameTooltip:AddLine(L["需全团安装拍卖WA，没安装的人将会看不到拍卖窗口"], 0.5, 0.5, 0.5, true)
            line = line + 1
        end
        GameTooltip:AddLine(" ")
        local raid = BG.PaiXuRaidRosterInfo()
        for i, v in ipairs(raid) do
            local Ver
            if v.online then
                Ver = L["无"]
            else
                Ver = L["未知"]
            end
            if self.isAuciton then
                if sending[v.name] then
                    Ver = L["正在接收拍卖WA"]
                end
                if sendDone[v.name] then
                    Ver = L["接收完毕，但未导入"]
                end
            end

            for name, ver in pairs(self.table) do
                if v.name == name then
                    Ver = ver
                    break
                end
            end

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
            local c1, c2, c3 = GetClassRGB(v.name)
            GameTooltip:AddDoubleLine(v.name .. role, Ver, c1, c2, c3, 1, 1, 1)
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

    ------------------团长开始拍卖UI------------------
    do
        if not BiaoGe.Auction then
            BiaoGe.Auction = {}
        end
        if not BiaoGe.Auction.money then
            if BG.IsVanilla then
                BiaoGe.Auction.money = 1
            else
                BiaoGe.Auction.money = 5000
            end
        end
        if not BiaoGe.Auction.duration then
            BiaoGe.Auction.duration = 60
        end
        if not BiaoGe.Auction.mod then
            BiaoGe.Auction.mod = "normal"
        end

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
            if not (tonumber(BiaoGe.Auction.money) and tonumber(BiaoGe.Auction.duration) and tonumber(BiaoGe.Auction.duration) > 0) then return end
            local t = 0
            for i, itemID in ipairs(self.itemIDs) do
                BG.After(t, function()
                    local text = "StartAuction," .. GetTime() .. "," .. itemID .. "," ..
                        BiaoGe.Auction.money .. "," .. BiaoGe.Auction.duration .. ",," .. BiaoGe.Auction.mod
                    C_ChatInfo.SendAddonMessage("BiaoGeAuction", text, "RAID")
                end)
                t = t + 0.2
            end
            self:GetParent():Hide()
            BG.PlaySound(1)
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

        function BG.StartAuction(link, bt, isNotAuctioned,notAlt)
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
            local mainFrameWidth = 240
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
                if #itemIDs == 1 then
                    f:SetScript("OnEnter", item_OnEnter)
                    f:SetScript("OnLeave", item_OnLeave)
                end
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
                    if #itemIDs > 1 then
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
                    end

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
                local f = CreateFrame("Frame", nil, mainFrame)
                f:SetSize(width, 20)
                f:SetPoint("TOPLEFT", mainFrame.itemFrame, "BOTTOMLEFT", 8, -2)
                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                t:SetPoint("LEFT")
                t:SetJustifyH("LEFT")
                t:SetText(L["|cffFFD100起拍价|r"])
                mainFrame.Text1 = f

                local edit = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
                edit:SetSize(width, 20)
                edit:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 3, 0)
                edit._type = "money"
                edit.num = 1
                edit:SetText(BiaoGe.Auction[edit._type])
                edit:SetAutoFocus(false)
                edit:SetNumeric(true)
                edit:SetScript("OnTextChanged", OnTextChanged)
                edit:SetScript("OnEnterPressed", OnEnterPressed)
                mainFrame.Edit1 = edit

                local f = CreateFrame("Frame", nil, mainFrame)
                f:SetSize(width, 20)
                f:SetPoint("TOPLEFT", edit, "BOTTOMLEFT", -3, 0)
                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                t:SetPoint("LEFT")
                t:SetJustifyH("LEFT")
                t:SetText(L["|cffFFD100拍卖时长(秒)"])

                local edit = CreateFrame("EditBox", nil, mainFrame, "InputBoxTemplate")
                edit:SetSize(width, 20)
                edit:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 3, 0)
                edit._type = "duration"
                edit.num = 2
                edit:SetText(BiaoGe.Auction[edit._type])
                edit:SetAutoFocus(false)
                edit:SetNumeric(true)
                edit:SetScript("OnTextChanged", OnTextChanged)
                edit:SetScript("OnEnterPressed", OnEnterPressed)
                edit:SetScript("OnEnter", Edit_OnEnter)
                edit:SetScript("OnLeave", GameTooltip_Hide)
                mainFrame.Edit2 = edit
            end

            -- 拍卖模式
            do
                local f = CreateFrame("Frame", nil, mainFrame)
                f:SetSize(width, 20)
                f:SetPoint("LEFT", mainFrame.Text1, "RIGHT", 15, 0)
                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 15, "OUTLINE")
                t:SetPoint("LEFT")
                t:SetJustifyH("LEFT")
                t:SetText(L["|cffFFD100拍卖模式|r"])

                local tbl = {
                    normal = L["正常模式"],
                    anonymous = L["匿名模式"],
                }

                local dropDown = LibBG:Create_UIDropDownMenu(nil, mainFrame)
                dropDown:SetPoint("TOPLEFT", f, "BOTTOMLEFT", -15, 1)
                LibBG:UIDropDownMenu_SetText(dropDown, tbl[BiaoGe.Auction.mod])
                dropDown.Text:SetJustifyH("LEFT")
                LibBG:UIDropDownMenu_SetWidth(dropDown, 95)
                LibBG:UIDropDownMenu_SetAnchor(dropDown, 0, 0, "BOTTOM", dropDown, "TOP")
                mainFrame.dropDown = dropDown
                BG.dropDownToggle(dropDown)
                LibBG:UIDropDownMenu_Initialize(dropDown, function(self, level)
                    BG.PlaySound(1)
                    ClearAllFocus(mainFrame)
                    local info = LibBG:UIDropDownMenu_CreateInfo()
                    info.text = L["正常模式"]
                    info.arg1 = "normal"
                    info.func = function(self, arg1, arg2)
                        BiaoGe.Auction.mod = arg1
                        LibBG:UIDropDownMenu_SetText(dropDown, tbl[BiaoGe.Auction.mod])
                        BG.PlaySound(1)
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
                        BG.PlaySound(1)
                    end
                    if info.arg1 == BiaoGe.Auction.mod then
                        info.checked = true
                    end
                    LibBG:UIDropDownMenu_AddButton(info)
                end)
            end

            -- 开始拍卖
            do
                local r, g, b = 1, 1, 1

                local bt = CreateFrame("Button", nil, mainFrame, "BackdropTemplate")
                bt:SetBackdrop({
                    bgFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = 1,
                })
                bt:SetBackdropColor(0, 0, 0, 0.5)
                bt:SetBackdropBorderColor(r, g, b, 0.5)
                bt:SetPoint("TOPLEFT", mainFrame.dropDown, "BOTTOMLEFT", 18, -5)
                bt:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -12, 28)
                bt.itemIDs = itemIDs
                local font = bt:CreateFontString()
                font:SetTextColor(r, g, b)
                font:SetFont(STANDARD_TEXT_FONT, 16, "OUTLINE")
                bt:SetFontString(font)
                bt:SetText(L["开始拍卖"])
                mainFrame.bt = bt

                bt:SetScript("OnEnter", function(self)
                    bt:SetBackdropBorderColor(r, g, b, 1)
                    bt:SetBackdropColor(0, 0, 0, 0)
                end)
                bt:SetScript("OnLeave", function(self)
                    bt:SetBackdropBorderColor(r, g, b, 0.5)
                    bt:SetBackdropColor(0, 0, 0, 0.5)
                end)
                bt:SetScript("OnClick", Start_OnClick)
            end

            -- 底部文字
            do
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
            end
        end

        -- ALT点击背包生效
        hooksecurefunc("ContainerFrameItemButton_OnModifiedClick", function(self, button)
            if not IsAltKeyDown() then return end
            local link = C_Container.GetContainerItemLink(self:GetParent():GetID(), self:GetID())
            BG.StartAuction(link, self)
        end)
    end
    ------------------插件版本------------------
    do
        BG.guildBiaoGeVersion = {}
        BG.guildClass = {}
        BG.raidBiaoGeVersion = {}
        BG.raidAuctionVersion = {}

        -- 会员插件
        local guild = CreateFrame("Frame", nil, BG.MainFrame)
        do
            guild:SetSize(1, 20)
            guild:SetPoint("LEFT", BG.ButtonAd, "RIGHT", 0, 0)
            guild:Hide()
            guild.title = L["BiaoGe版本"] .. "(" .. GUILD .. ")"
            guild.title2 = GUILD .. L["插件：%s"]
            guild.table = BG.guildBiaoGeVersion
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
        end

        local f = CreateFrame("Frame")
        f:RegisterEvent("GROUP_ROSTER_UPDATE")
        f:RegisterEvent("GUILD_ROSTER_UPDATE")
        f:RegisterEvent("CHAT_MSG_SYSTEM")
        f:RegisterEvent("CHAT_MSG_ADDON")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:SetScript("OnEvent", function(self, even, ...)
            if even == "GROUP_ROSTER_UPDATE" then
                BG.After(1, function()
                    if IsInRaid(1) then
                        C_ChatInfo.SendAddonMessage("BiaoGe", "MyVer-" .. BG.ver, "RAID")
                    else
                        UpdateAddonFrame(addon)
                        UpdateAddonFrame(auction)
                    end
                    UpdateGuildFrame(guild)
                end)
            elseif even == "GUILD_ROSTER_UPDATE" then
                BG.After(1, function()
                    for i = 1, GetNumGuildMembers() do
                        local name, rankName, rankIndex, level, classDisplayName, zone,
                        publicNote, officerNote, isOnline, status, class, achievementPoints,
                        achievementRank, isMobile, canSoR, repStanding, guid = GetGuildRosterInfo(i)
                        if name then
                            name = strsplit("-", name)
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
            elseif even == "CHAT_MSG_SYSTEM" then -- 如果团队里有人退出，就删掉
                local text = ...
                local leave = ERR_RAID_MEMBER_REMOVED_S:gsub("%%s", "(.+)")
                local name = strmatch(text, leave)
                if name then
                    name = strsplit("-", name)
                    BG.raidBiaoGeVersion[name] = nil
                    BG.raidAuctionVersion[name] = nil
                    UpdateAddonFrame(addon)
                    UpdateAddonFrame(auction)
                end
            elseif even == "CHAT_MSG_ADDON" then
                local prefix, msg, distType, sender = ...
                local sendername = strsplit("-", sender)
                if prefix == "BiaoGe" and distType == "GUILD" then
                    if strfind(msg, "MyVer") then
                        local _, version = strsplit("-", msg)
                        BG.guildBiaoGeVersion[sendername] = version
                        UpdateGuildFrame(guild)
                    end
                elseif prefix == "BiaoGe" and distType == "RAID" then -- 插件版本
                    if msg == "VersionCheck" then
                        C_ChatInfo.SendAddonMessage("BiaoGe", "MyVer-" .. BG.ver, "RAID")
                    elseif strfind(msg, "MyVer") then
                        local _, version = strsplit("-", msg)
                        BG.raidBiaoGeVersion[sendername] = version
                        UpdateAddonFrame(addon)
                    end
                elseif prefix == "BiaoGeAuction" and distType == "RAID" then -- 拍卖版本
                    local arg1, version = strsplit(",", msg)
                    if arg1 == "MyVer" then
                        BG.raidAuctionVersion[sendername] = version
                        UpdateAddonFrame(auction)
                        if sendDone[sendername] then
                            sendDone[sendername] = nil
                            if not notShowSendingText[sendername] and sendingCount[sendername] <= 2 then
                                BG.SendSystemMessage(format(BG.STC_g1(L["%s已成功导入拍卖WA。"]), SetClassCFF(sendername)))
                            end
                            UpdateOnEnter(BG.ButtonRaidAuction)
                            UpdateOnEnter(BG.StartAucitonFrame)
                        end
                    end
                end
            elseif even == "PLAYER_ENTERING_WORLD" then
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
    ------------------给拍卖WA设置关注和心愿------------------
    function BG.HookCreateAuction(f)
        -- 关注
        if not f.itemFrame.guanzhu then
            local t = f.itemFrame:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            t:SetPoint("LEFT", f.itemFrame.itemTypeText, "RIGHT", 2, 0)
            t:SetText(L["<关注>"])
            t:SetTextColor(RGB(BG.b1))
            f.itemFrame.guanzhu = t
        end
        f.itemFrame.guanzhu:Hide()
        for _, FB in ipairs(BG.GetAllFB()) do
            for b = 1, Maxb[FB] do
                for i = 1, BG.Maxi do
                    local zb = BG.Frame[FB]["boss" .. b]["zhuangbei" .. i]
                    if zb and f.itemID == GetItemID(zb:GetText()) and BiaoGe[FB]["boss" .. b]["guanzhu" .. i] then
                        f.itemFrame.guanzhu:Show()
                        BG.After(0.5, function()
                            f.autoFrame:Show()
                        end)
                        break
                    end
                end
                if f.itemFrame.guanzhu:IsVisible() then break end
            end
            if f.itemFrame.guanzhu:IsVisible() then break end
        end
        -- 心愿
        if not f.itemFrame.hope then
            local t = f.itemFrame:CreateFontString()
            t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
            t:SetPoint("LEFT", f.itemFrame.guanzhu, "RIGHT", 2, 0)
            t:SetText(L["<心愿>"])
            t:SetTextColor(0, 1, 0)
            f.itemFrame.hope = t
        end
        f.itemFrame.hope:Hide()
        for _, FB in ipairs(BG.GetAllFB()) do
            for n = 1, HopeMaxn[FB] do
                for b = 1, HopeMaxb[FB] do
                    for i = 1, HopeMaxi do
                        local zb = BG.HopeFrame[FB]["nandu" .. n]["boss" .. b]["zhuangbei" .. i]
                        if zb and f.itemID == GetItemID(zb:GetText()) then
                            local hope = f.itemFrame.hope
                            hope:ClearAllPoints()
                            if f.itemFrame.guanzhu:IsVisible() then
                                hope:SetPoint("LEFT", f.itemFrame.guanzhu, "RIGHT", 2, 0)
                            else
                                hope:SetPoint("LEFT", f.itemFrame.itemTypeText, "RIGHT", 2, 0)
                            end
                            hope:Show()
                            BG.After(0.5, function()
                                f.autoFrame:Show()
                            end)
                            break
                        end
                    end
                    if f.itemFrame.hope:IsVisible() then break end
                end
                if f.itemFrame.hope:IsVisible() then break end
            end
            if f.itemFrame.hope:IsVisible() then break end
        end
        if f.itemFrame.guanzhu:IsVisible() or f.itemFrame.hope:IsVisible() then
            if not f.highlight then
                local function CreateAnim(self, w, h)
                    local tex = self:CreateTexture()
                    tex:SetSize(self:GetWidth() + w, self:GetHeight() + h)
                    tex:SetPoint("CENTER", 0, -1)
                    tex:SetAtlas("ShipMission_FollowerListButton-Select")
                    -- local tex = self:CreateTexture()
                    -- tex:SetSize(self:GetWidth() + 20, self:GetHeight() + 25)
                    -- tex:SetPoint("CENTER", 0, 0)
                    -- tex:SetAtlas("Talent-Highlight")
                    local tex = self:CreateTexture()
                    tex:SetSize(self:GetWidth(), self:GetHeight())
                    tex:SetPoint("CENTER", 0, -1)
                    tex:SetAtlas("GarrMission_ListGlow-Select")

                    local flashGroup = self:CreateAnimationGroup()
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
                    self.flashGroup = flashGroup
                end
                local function Create()
                    local f1, f2
                    f1 = CreateFrame("Frame", nil, f)
                    f1:SetAllPoints()
                    f1:SetFrameLevel(120)
                    f.highlight = f1
                    CreateAnim(f1, 0, 0)
                    f1:SetScript("OnEnter", function(self)
                        f1.flashGroup:Stop()
                        f2.flashGroup:Stop()
                        f1:Hide()
                        f2:Hide()
                    end)

                    f2 = CreateFrame("Frame", nil, f.autoFrame)
                    f2:SetFrameLevel(120)
                    f2:SetPoint("CENTER", f.autoFrame)
                    f2:SetSize(f.autoFrame:GetSize())
                    CreateAnim(f2, 0, 0)
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

        tinsert(BG.auctionLogFrame.auctioning, f.itemID)
        BG.UpdateAuctioning()
    end

    ------------------拍卖WA字符串------------------
    local wa
    -- WA字符串
    wa = [[
!WA:2!S33AZTXXvIEZ9J8t3kFy)09dOWw(AmrGWGKIY2ALuv8LOymFOLeYAZQvfwqIbIZvGyWIzGSKvukz71rs2wrkrw(HIDSLFe7nzTSxVBS1t7QU)eYFHLaK8t5VWTFnZ0poDpZaaj7SByjrcmZPpD3N(0N(0NhD)do4pCJFy1Fy1l(30YTTFDNg2Tw6iLMFUfN5dCwZTXkUTBTM9p4pwPT)6UTwQPVJBdVH(YQoEnRx5mLSpT))ZpyT2E(UBq(8F0B9kvDFUFYs1Q5z7))()XxwPXAOYDyxNg(Ro1mlwAML)JR56whbtJvEoNM2)JnZWHRY1CBTrf)Ynl77SHn7B)GM)VIQHJ0SAfF7vBt(Z)Vaunt1tyVERkRrAD7zzp)kT8)REXQUL9CB3O66RwZPHJ36dnj6p()F(vONtr4)4Q0)E(FWq1Zu3DTk1ZuPDRkLTBCQm7p6JUTYC2Znug0pbpQWPSBHGi7PgTWizhI8QATBqQ(iyM12)zTBTy7nY553YIae(Nw2(TB1iJVBJ2BSQDl8lDACIcOo6ARJ)sEeAZ9yv31Jva9lRSww46ViP42nQsRmNAzA46NP8SfMC2jY4VUDJq0ZE2(dAYrpRWbBvzdBVOxzx3ZoegekbA58DyRm7B)qWWWobcHMsuVn8rH9awvYk7eTj0UfQ40G0ivXJga37HCQANZsa)QOFMtz3qlkXVCVhPrl7t445B3AI61XpX3lwSYiNk4fZwNtagvmf83iAhhdh(R8VfGNCir2XjQw1TXuRxPrd76y(YjDQ4oRnJyLLa7uLrV3FUg1ClSCqxfxQfS98QCc7d3YUMZPZbIrlATrNGmpc)OP2By7xXVYQ1TZD2ZLpZzJy1k70OQ9PrafmHihbS8zoP9zSaynqteOZaYjaqab6CwHC85qSCZJBdOb8m7h1lF(1lD0Ss8CZFSStu3FxB9I3PZfUx3lD5TFPhS1R)EDV(fZECmHb)UDU3VP71EfH3Xx8ox5319DUuNF9hSZ1)2Ux8n26s)lDU2l05I)8DE5lV95Fz0R6(UV0oV9v7CL3O7xDXUV6L7C53GIBwbFN3ANR)1Wf8F9v4l42)7FOqf399Vt3lFRnFW7V1n(N7CH7U59(6oVYN298Vq3x)oDUYB15d(nDUWv6CNxUZD)T06dd)1Uri8DEP705vVE3x(vrWV9TEfe8DV9VMbpF1G7wV2L6CLpFZ79XD(2F)oN)92(lEPUx))avFDF)7trnUhibZV7BrWGQdmmcKR35t3(BUwNx(J7EZF(Mp4B361)0U37gB)GBT5DEpu51vb4sD)BlwQVz77)7ekLUQ8ahidQxNzF7JIROVk0UU4hV5DVBUoV2325Qx2IvRIptGQ8oNFNF)BT5D)fDEW16CPllqmiVQ7BC)TU(xHEfqdkSW4H9p7sOpS9F4RrJWiSiHckaOpqbaHljEpvMknClB)HV8w37xsbA7p8D36REbHx)txRwTdEWPhPyr(o0F6(34N2IwMia47wuaGruyFcelHDitOGYw3LqnqZjareLvwcgy0TVm0HYUF6n7C)RK5aQidacb6nP9WO0K6vCg5N9HDU9TPLLnNJ)jcyIRAy4J)j8GE2w(JCo6yCN7F(oFYRsEqMhZldpfg9vkmDFZVcnLL8epequKhGdexXoVXRQId64afhiy6(2ViAkDeoe6KKAzR7DTUV77X6KKYS1F4Q4NOs5lI(P7F4fqqPm(j)kPU9tEo6ljFKVVO8c5ATyrmY7EXRU5D)ivoq(3QLdKc0M35l6CRVcS8B)LFD4RKA47HnEHQIoVY7rEaMw)ycdi7HnGacKkfNoZMNIZEIkrJdEishxHbjGubYOoMoPXuzVraOtWlDPddiIUUr8iIU8mgUp6YDU4xXlIQZD(k8sDVY7ZWizXAeKB)rxy7p8b8YQ282)wgKcTXBC1TFt2uWDUX)g(Zc0I36B26JUl7138ZXFwDOHocYp0WEIaOeowgq0pliF(wFZwp4wD(2xARR(Z5jrB)PFw4ZHwofjr4QF(2x43Hw7Nx6eEw(1Fp8ZF1RdiPIo6RwSONdwm1cOf0dCaSSp0Y2CfjAf4O3fuy5LJ5ie786VqNBDJnV9NXAJC0ID(fVb7vM7DDU6VGQa3MF7Tq678FE(xux)TZ38AYqkG6F7l2938oDU4VhPyaB1Pp)1rQtGxU(nrcdEnwTEBSIzuaqpS7NFLU)R3eX6H(6M3(UOfR28b)cQUwO3sbBZBF5nV)nO6fGklIFa1ZWQQXrjIA3SMXhtBgyIryZ4TFrwZa1LUZVN2mis5IAgOVU1lc0mqph1m6(oVev7dCZ4t)m(MbLQRquu4A1YVIQZoFXvOucAnJOhbINcFjECG7L8i4pD)l(yE)P7FjAjc)MqD8L3eP9C4aed3F5Vk8HkZgiWT9T(Iop468lUV9N(w78A)ZsttJac41)NN)fOVd)b1175xPpR4w0vThWYZozU1TpD(mtuV56vI2QdDFvTSRI3zf1yaETxLc6i5ZmQmKNOLnA7SQWow(m7wg2vR32ga0XZNzpwdXzscCDhArc0xr18ESY8ezgD8XdHkOEdHJ8aiiz1AiG4VZdh)MPjedD2nidPPWQhkwiWhTnrEtyyOCGBaxZ40k2(tvVIN3uh8G5AG2(E(myZtz3kFg)Z002IVXJFaPThuVy4fmxaDyOC(mRHrjFzPifWSemyreWJ0WH2uYrb2sF)gSu4wdSvmOnR1CR72I0KrCXz5BCuCP024kgXma1TxZp3UZNz2asg(n5if2sCZ(cv1pDTSzkuGHh0hiph93S8AEXnAgw480pg7WpfwUUKYW(WdNbPi)ox4kKVv1neYq2aIPdhb1CxzPJS40pZCLkm7kLlnxP5NP8shU0ClTy5LEgmAqk8SZRFRDEV)9Ux)IAWYOiSm(EE6XF6XYa(dUXC5lS1D)eDyz2LNzMfXTLSuvvZQcYYZmnbaQs4zhsfIJo30LoecKXgPiuXp8mtuc1)wygeiJcaXHMB6zo4YtSWmbanMkm2vpH9koppEqE0cJR((vRS2jR2YT5umoOZMPyE2)kSNmNtFbM0Tvv7wrfBeIOruXgXuPiWxUMtDFBAXkGe8f()XsyfQdbjOQNZBbBs5eweani(0pnAmc3PTsAJievfn21BvXP6YUyR7Hn1h1wVQqTGtdNfCByFMsRITx4zhsMB8lUc2igF(ht1bGQjeVspHkzW05G7Hc46SzgJ2Ern28sVbT9C0Zlc(UXksFj9xGLf)UX1cWyfdWafmnOG(sDG0WPE(GQc)hEioNQ8Kp7n38bxJZuPRuAIfNEILNUCPz(7kv(GlTyjzHnu4WdbC22KxoCU6elDEs3Nz5SawxxTgiIaCB479p8pmAXIJwOuPdM9VrqEzewF(1NAXuJ1jw(zQ4uUubF)AgqSQHzhiiUv7LpsQr8bxEU)()2sLlxEQFYYa0J0JizKW7tdXviZoRB9QJ8uzXShe3bGqe9rk(Mj8nOInvl7k(24hLlBWlJwX0sFz3ls3fSxYORdJftu4Pgf97ykcPMu76iM(NcTkkZDGzT02lN2XtQtsEcuLsErV1fjfvShgjo2CjsAh0q)BCL(346QYX79(34PU)nU5(34jAaCwSMYsDr2Za5COVQh5uPfwSJYwulUc0V9ZNBDhFBP(j7zq18rPVQ36NScRmLe)V4kqs7NXStM58wgPoW82vqArOSfcMpK1Tne2ZPBNyrK(05YsFuwT(fnOi7xuDeA9RDlE(Ts32Zqkcn)JGotoJ9gIt5HazH5Tgy9uASoSSGgDCQhq8ZSgf)SG1mKnuSFSMnaAfoV0BqKH58MRbUfKBeG(vnerWbvMri7aCX2BmBl32nxWgVPFVCw8A6ioHKU)SwvACY8z8AV6jWflFM62NYUoBFSJY(B(mppsp18zCBGdnL8k4ZXBAuFcHlxSpMDq8g49iUXQv8xg9eQIvsuqhlvSuJUhuLEyWpSDU653YRzDhKqGHrAVlU9A1EzffvRbqjHuOfimjcbeHsPfOakiUbgqm1cmHiJGKsS1cgDqabhB0WmGbWPhm8OickYGPwGOdYiW0nAloQJaKn8RN(rzciChgWgHZNW8OVFYZuf9fq4ph4tjXbrbNgE2T81nVnFMkWCuioukVaAN16ztnmHhXMbweEXEsviHUKS6Ik6in1H8Ze0IwkGvwb9s(GvbomvqRmUWzEwKmDIPKYt(dFi1GE)Ytm30Ae5tKLLpdQx3iJtZkoibyIXWJS0m2so1qlintJQzQG)VWAuwW0UAfwRsJ1SRV3vw395Yzb8(kT9DXQmmzBFF3g7DQ62vWHLeji68ssjqAqqaox2slDyKGQDJ0Ay4rflOYwFeABsHv1dX2wrGMg3WscwMejHNfPtonoXbB5Ubz9kfDdKxjlyvz(AleNiYGaAXwZMF17EH5uaHzv5gNQCjNnSBvyIAiHbynfdJGkrYJPgzTk8dROwwS6iEyKy7Yl1yQ6oRDYCE21RjVlOAul9wRG7Z1WUfpvfZ6RX894ceO5BooVYk2tiGqWqUrKEtiQL7t03sEhyeak)(rvcrqzSj3wdCrSL809qAgAPoKk6R12dEgUkC05jKpMtpVUejPyHX0tue4gvOjaIwePjsaW3komsP2vWwToNKPWJLvAkISdnmteDjNOU)ZyFMPrCsqsh7Ljv06mishJK8RmOeXcJKirGEUPvNdMacqcLkfsmMPbE6C6MzXVdoNtSUpT4QuSzrdMLCDR770eZ3Segp5QH6wtS4uhAPLlp)mhSevgBrdtaIdllp3ShcanC8m8yGWQpps9nEwDEaqJG4xt6t7Dw28oR8mB6J(hM32CrneLNudjqn7vcrvpfXN4kzC(FPVQ4MSzGHzE3teTmPg(gc3IJh7LYIb(lCvSXtb3)RWyXts(RRvOU7j8WQvx0mHGd)kXJqEb)cjYiWmGDqfDGmJmEYQOSfi)K1eY53eEqnmCMr2D(WVbSfCOkZbl5mmEhqFMw8J5C8cBG9te5rKSXiNqmBKNdqMnziuA45Fkk3PSWEKbf(ZJoGgU1EBgpAZANYoUz8IAdXxPC65yOs)Xovq)RrocvbRJz125ZuwjYgipH4ZLDLvRbTOu2DrqImdFecggabiaOfEysHrtlkcRlLqnnSynX7Fika7F)eiSi7gJ(OFgIBkrOMZR4A3FeRif7NTRG4yjvzWiGeTNkeN1DIcHgYd4sfio598Ke2Uypf3UybD6RUDZEQJnYXXvcT(3h97WBJfpSTFeaJECL3TAl7kNmrtAye0KWDMpQNAG6IMmSYgvQxhuHRnoZcY0vrLqajWR1Uvl7g(bfLtrssRuZixqDnSq5h4ducnotJxHZ4Wan2X1Bxh2qcgivJ2anPGRqQBvtNPEsLb)50wHxgv0ibEeCkBIctwizjhzUdxbtveE8GYQ8o(2BaRDw)QIfg2bIwwIiAaROfQwMdrcM8mZnDo6QtOVn30XQ6B4MaNYTHFl36g2iioc8A3YZTvUSZHPZ1QSM9tqFYtmxdVM2R5RXkEMvqwymCoDqHAKtolzfKjNTaUduEI61peA0SoEevT1cbfLYu3PXjTspVfKEaAwOpbQiOTtlcwenVHtDlyIbUIJNyOavUurdISNfE3cvrpg)1iuuRWQvAjZyrL96J6vfLb02FL1A500px2LAq9OwwotRrNQyxVstp7QIk6HXMps7g2lbceYw2BuXjW8GbROW0Ym7JvySAzJ6aOfc8LIjYiVefHONiSaaGwoFMnQqYTssxdjDdTuXcvo9ZwPEBBzllrlcjPrZ8JWLtYCqmIdPS5oLIXUIAs7dPbvrTlQuRal84W8i4vMYvJPin5jHFz)qoF1s)YqrJE(v8B7nzfACWLRDJMvw7K54ZlwdbTNLvYxdtxnosqikwSWESgkj(2OwHqQh2KUQrLJGKydLsBCamArW4wrB)7)UmqnYGDGsmwn6LbkGa2qRPFHBm5IKOufjpjeglKOPrSiw80lRLomXlCziJZXlQZDvmnzNPQJVE)cb30Zw0lMoTCRy4IfgxxdrV4CYswX2Q024Xiw7lPU3dWI7qomtt8oGxkP2EJcIOvOz8UA15BKzAm9Z6dlCKZ1c07JQHgXW)OIp5sLkT0cbVByC83o84anCIedi5d)mCUcOxCGVGRuesNolZfqtKGjrU52VdUq81MHefLyqi6EO15TBZcan7h8Af8DBgtBsmZtjz7a6DIEPMfN)utzXLM7WnATci75MeI(IheKJUkJ(PxZUFIc8SyODyx9G97tGNEISsxSjElX4Do4GikyWlF4WmSVDmgrc6iNIS0S0(mrmZAxRpzmZq5ADCCYAg3ZM16r4WMAIEhmu1lJlqCCIolxtsQO1f6k7nIUscrgzUAG6oy0iWXA1v(r6YATEawRmoZlrogJcvxJ7frrCc3dJepNePxHBOGzhpvZtkBNR8ytbBLmJpqlxKjiOl6KfA2qS2EWK7dzTpL5rQEv0kjo2jHPLoEkiXWK690ym2bjEtvKGnklXtTGBBpBIfva8GqOvYIuEke(Sw50C6kz1lnHJ087ugBE2wofxdKdMu(CnHCdvoXe1RZg2KzutrSde7yZrA2hJmS(oAqHSA06vACc7QPjke04hcJ2lNOffDWvVhF2xW6xWRVWhnoXUHzQRZWlfTaT)U3PD8iNkvwgvO9NLov8aQOcvD8QPle(mvMc(OogIIg3Xgu8wrhsDfqQNUDXQs9MPHgINwkaW2MK9WB0i)(1p0N8XYECCS)4RmoCNMHAXJxQb2akanxJlXmhREgOmjFekn0V4ODrQvQ9KMiVUUAcJ5pdK1ephjPZpad2uDlQKiX7KLko66221z2YUQDDFLtxcM34XoJNxAnbw8gEbCrEyr2vwTRDfZYQ86HrDIBk6yq6i3VkCoiJtTyddjJh7sjnm1KMYOxPrd00y9Ou5K7rP4JSeJH8ySB4WgRSghXM8qWqKanAFI8zwLgTq4HzfxdhtmSewEMjNIpQEEuYXXA9y7eLjB0woyT6egzJP5iLShcCsJNhypk5WJy9Gc94igRy2fGbMpRHs1Eb69GOoQROBdDq(6K9SYvXh5df5o6ncKs)qWhO4Z)Mmhy)0AfuNlsPXVDyuBAe4qYEGnUOm(ywEuVyfhPXgLD6AGyh6uDJh8qHkp0ZzKHQ(k49uJ1yPAoTMbszxEIo9r32961y2NR1zkI9RffO(Cz0vWE0bmIOyRwBkxyyUjCcEfzUc65Qm3hl4spr0bEubsDapXGLfST3GMBNvD3i3ifHtlvem7tBimk0DoOdsT0jN9yzj9MYhQT3QiupL7g2lrZmcO23XXznxfC6hM1Aqh4wOzcKHdCCCWg2K9SqTcTJS8Q8sb0ChJ8kiW4GlmO7eJXUeyGDDNqUbCA8TMWSiN(b(6jYRj8Q2WFsIP2ZfmpLCpNYZjhKocjzFs25RzVaz8q5TF8qfrk4K8hfsbHdGHdkjld4GlGb0Ij5tljz8fXnniADWyBG0oxhPnogPlI37BDS3GxA1)V4tAn1dfd5IgKAP9uHvZuZEaj15dQ9Ech(SuKMgy(5ZC2mctVZhDAoeh)jI5mGrUvw8rjVw7bqw7Cd3QKDluPHBJZSbAf(S6IeH(zsfWztoGR8tmnG)SO8CjkfF7NgFmoio5nBrzMNl2Gejm6LGhrs7mATbDuFj1rpw7DzpPfNdW2CsKdrocISmKK79yXtNSiTOjvsJaWc8uOuogoGzZgO8xp0yS6zokW1e67v3gyRWnOwLtwgNyanGt1pdXUaxWs77YTDQCQBWngBpd7NqbLttOPpe3hQJhUPXICm6Iahy)SrGf05ciYWJJFDB5LMGom1TssHdTTV85GhTm0wjcq4tramkJgIdAmqhr7gkPg)fesiWK4cZBxZ3WHHGiWKmljXqVGt1Q1TnaoBOc(GwqDgt4ysSeaXYDuNQ(RNt5nZsJ3XGiIe)DkKwg7wjY5nkLiWsiazrRevZXBE31oj5CXw5m1yiTtich1XtefonX4djxSrueVmT4p9DvMxOjZiGkSv62EoV5Ms9XuW3Dwgh7AWWq9U)t8Et2XTxovGun7aN9SnFGHagMyQ4lbAlZj)oX1USV30SkG26KY6JTqAIRszB0YJK0uJdIkmb1NWY(XvNYAjieHpKYL1kNeq91bHuiJmL3SpzJP2(e9B8SOPQ0WNyqAnxpFH6NXbL(WLqeUcIUYqp66zVyi4Wb)aXz68RHSBejo5OWtzoCytIP)1won5EGHaI1Y8zNwnZhmx4Z2nnE9pCZjr5ralru1ejAi58rWOg1i63aLUkGYrEmhCk5F8WewiQcgE8bWKeLi9nYPAr(PQ)DC2WgDCM(KQl4GLtZPRLqdKQvNVvVfWymjdLtUObbMiCW8HDrHX5gL1jgrts1eBUnyaHWzGUPqlhKOM0PX(iT6CpL019zEkrbAx)AMPR72nDfIT6ofsJVLATIZZdNZqPw4EKewQhOCseDjblZ0l(uTsdNnY1KKU(riI(9cvQxhFpal5sB2l9bFmDWdFo6pMf4RIB2SpquAZTKXWz8hcErIWuOlQmfviKrltGBIJGwbIb8tq)aRhBfxDmu)S(tAhIqARGuaK4k1zrSMkXrmW5IhLEnK0QCS8bN6mzL7pbH73Rl8GUx)lKVUeGswC6Mj14VCPacxWUwyXhnYjfa6rqmN3Z645q25E84dPkiP6TbtuWegu4X0nngk3XUBTEnKUL2BSIpwnVlyXgzc6KygndbSrSDr4dDSObQbxkPemPm0qbGtl1DcLbFB4PDtTXHUeD)4fx(QaUKRMAu04pAp7(IRD)D)LVxSefjb4gICTyyVJzYHo2B80rbzPPXaJSnQQls9j7PLBUTHKaNR(0NIfjQszHNU2efbOHftkJOu1UubiLcd)EH5BPkRlsrVhMcOztWqkNl3R3V5UDp0LnK9b91WmqNuEBzXi4p8qWt3Y4Xk6N3TdgOx9O)f6vFmKa)m0F(Ai1Eti9EuOh8QqSEwOF8UWdjpm0BEzi1EAivEBWqyCOLzUVyJ1E8lWZeB8KRhGjg4YjoEIO243mEoE53wr8cxnHZc6rSipZiXOjC2IMtAe9tw0D3m)9JPngyP0oTHmlivZBajAPWp5pe2XMXJY5VNTDgin01PGHXTP07kihZyuOzr5wJh6oCqohrJ)WTsbvadsnSFo1n(gNASbfktOMCXlyNRmQzdrnThfdbuOGsFabvj5ddJ9zokmaB7HWN(RXf(g1(2F819dXekqFsfe0cHZRGu6Hb6X8eZwU54USbOhuMHXcFWb9x09l9gUvZJzYjXau)6e6O(j5(jl4lgokKtM(783Gx0dFN)P2vQ74FMWlWRY0UAPZ00M(PvAVk9lS3mZ)uBNMij35ZGfN0Uf9nKBqkm9XR9QHFEvNgvlrte1zPh8O07WlPZCuMWbC7b8Oha)YacRo(o(4VQymbGLWIlPDaNKouJlnSdROOXdEgGro174BwZIWPenio8Wz2823BRR)A78UFq4dL4IIwDIDWLr8zwwYFOMv2KtbdcBWs2BG6N(2zneD)5uVL0w9e40zbhJ3CNaSibde0h9jmgWx4znQMv9Q7cFBupyWc7oTw5EUwe6Z1FjbXam)hGqfU9Mt8YahFRgpUYQS)1ccxmzviOlZPEW)Vk((vSfe5e44Damf7uTij5ONMq9ku0yKKr5OIJm3f7DmYhKZYbhY9Yh(pYPGgojcWtPhcYvBs02DLze10NWJERDZ)C(jX4fKbZxczFqcXdOCcZi5)llnPQ2gbZSr1UM58kLCJ05gt8DgacZrzyx43k0eZQOxvfjadAzKBl9OgXSbSCJybCb9b5XtUoqIDSM1qXs1jN5spIO7ivtPeEycEsVrRG9YN5TOBKIwiWVUPMOl7UwhD3bNk1L0d2fPS6cTbjGXrRrHyU4ftqNJxJUY9Il7fn2zWX6zCrIMj3Xyi2Jufigotckq2cbWm20DHtQy7Ff)WMSohFHfAP4DJsAOHVV3BO6ExsdxlzXesX6MrDUQLaTRaIDoDbdgeSKpmpwB(CJwSymWBE1wP8AypgvRwb3WhVukupUSdU)jDcPA8dvLupxcRAbZpNptHDht50pulbi348iJx0aWuRwI6PCbCJkq(U(vQxIk8RWUnu1GzBHuBtAIBSlysdrgDsEt(5GH(vu4RHOpByDe2b8pJ0XcWh8xgMR8Si)jI29J4Gu7r2kbn7liIJcQIIAfmf0)P2KwJnOLeFQYwftzzXebwSlfwldrS0d7iN1uNzaeWTW5vLuym1pBTMxN)4fBbOVqCBXEqTn7b3wTt32TbKG(90SZmC73JGV3gEYXGaX8QOgJE0Gifz)Ig7rgm(xgnVqz7KaBBjzcGtqGNdT1JyUPK0z3aXZXE5jl8Xm(OApbUnFaQRuzm8bwxHhO(gQTKizPF2QU8GCpDMY2tTUKTL2e0(sY5rSzLbv40Ls2eEg)Kj8vcdXlloXnbW0GOMUJL00IsrgZ(eTXlEkvk6N8kwJmp4b(b6obs7UbguRNEUu0mK3zWyjOSMVU(tXoesKE9A8NAIUruauQXVxVTDclSSbRh(P0aO45HRUG7QhIJmLfIdJfhCCmKeQh(aXtM9ghqet6EAEg85A0Sn(zjxNXGtJpI2k14I5d0wwW3(mJcqbckJGyh66UJ(K6bh7eFQTd1eShbaUyBKyfN10i2bdvY0)Xom6BWBpDS4hwcI49Ije0zOJk46rpHnC9oUG5pBEtH6VvcqgXkChULTNNk2edTYeJnz0WhA(jbjKZCwesKpNztudqmFt4BkkVu7LUK5TxzRKtZYk9fSY5iygztA1pksQZOJNcf2fyFcdRoqnXzslPVLjVK50CORpkCW5zwcpdKaCK1jCDQwvCQwJSofQwQEM1w3ETtom5Jznutab)PgHwRQiYIYzYlXcFZT2WUo9fjxS1QGcGqYRagvwvRao8MZgDuDLiDHKlQm6dG6v97XDSrPlOITQVU(v4CiYS94KfOHFdhu3jx)4OwMAxLgE4Mzj1LPabVdhJ56IWpY7teXmOLeJyoXG2ZkbOj5c60q1kWi34)KKjsPCObyRt6SwKrvdLuhKm5HEpltJouU3HVBcb1w8rGzo(l7EU)AHc8pe57KpoQYYt6Ut3hE4mDV2L38bVJoRFIa4Wv886HLi4BBITCQ0VuFkCrlwyMPcxYJUUJVnCjvVTfhwXQL4dYaSHHGkFWIk7CJRU9BEf5fs4wQAvFdbKnshLNsUKXpzj2fmWdsWQnkWJGpu3Olj1xYQacxffBJiz6nHdEIHL3BskTwi81KoKKp5zHXi4l24rc2DyXo(1Rc6gyc5ueF07c3gGc2uAvAeOrKNjlxIMQk07CY)RL8j2efvPt7kZEkgN4jEYYGui1Ex2(eo4dF8d62IiMXlx2jACgml4GxC2uKtpsybARg3oGdlmGAHR2t78v28Ni0RQyVOJswyEDbbZQ(G5GjK)nw1prMPtNNm)Z4jdjj3c)(c3SQncdZmlvUKeT1p(JjdREMjtY(P7ECvrh646GS96OjGl8wFrNhC9)BJW4yvvKspE0QQOa3OWbwx8mJkIsNNV8PtIQwCqaqFiz8HVCNp6cDFRVzRp6Up6cjdyvyf22SGoS64guu2gJHdztCAoXU8jvTxGQw)UwWXz)4M1doolamsX0RtBVg39XWZHrgiNwTyy0OfuI96)QP9nAbG58wzDNA(pJ9zi34ugcedw2uHA6trpwsrLzs3kTQYceCZHWb2fOepjmbQbDk0Kg8dYf(0Pw311ZEs3tJwcfNvFqjBSP4VnerZrYjI5r8j5ix74G327K(9uibLTCRNGE(0y)RCKM4Kqlge)iY4nPyFpHbNTIzCqYh35E)YTV0xU9l9ADF7phqOONSqXv8R432BYkTcnDV0rKLjBj6jjfXZOuKHLnHpP4HnGq3yKu3TBczHPRo7FfKQA8(d)1Ft33)ca0OOBtqwAk(3stkskozzijy2Ft9Tt)fZYmVXyi4eg45c3OMdLzPweFq0fEfgocCzuwYeWImmqJ8ItW6HSv5c(QAXkW8LggdIUtJqTZo5et9mZU8shzXPZcxyJbynhmbOL9xJaoLlI(KRybsGg804Fr)usMqxWznUmddHtffOjA)S1NDPTU7NOlsmIOgAdgJyI8Ir1g5fG(MdxJs513iafJO0ljTI18sbwklGU(w37xkVzNOCkgXgB6cAlPKMeqEgjLbMcL(aSfj1yoH0hbVeHsW5WH8QiH8lDU6L36t(IEnYD65W0bEJsmUfofwhvLY4ZDyMi6y3AsAmlBHwown0s679eETxnx2h7yOQjBwRGVEC6xbk5pUTNVtTZCOCzjnxOwfA69rBvPjuOUOBwn6t4JPcWWccVs0x)LDFNljZAp5S0BIWzlWwgAkKKCFONfKc947q9I4dzoGxYYkDkiMMNagEce5Pp(elx6OlT8Z84AdHaAGrpoMRqlmugIhhtEFCuJcH2GpsgOru2M2vd3HBXhkr9G2zkB9VDVo)Mx9H0mL0iwvCYI4E)uJHfQXmOtkgzmflcvE2JXFunCCThuFSJQbdctfNIXDGqKcLNJkVsdl6ks2mQtYXHDu1KnMH)4N5ByInUfgoXwzM95)vBFRB29n)QUV7nhyAJNarQQQz5PlszsUkxPvB)rFeRT)iHhMrf2da0l4G2c2PF2k1BB7rwaTOC6q6LsRNTAfmSEQJ6x6FzZh82Or9DEZ)dO9xeC7XWsVUyLRiuGED1yfKifACdpUcpJsrI58ZtG4i3lf(UoR7rd0wZ21dFLX8Cy2x8b8)txeYAYetjgaZOJdaY6eoC8Bhvz0J7G1Cq7fCYeWWoGAm4gVRYJK(iNBmJHgdhlXMrs39utimj0ezgXZrAALkt7bDN5KoB8bBFV4Nxp4wLF3MxLx32nJFnOOlmySkGSpIuNlRMR20(6gsgCkn8fzCcwawObeEe92J1UsSdkVCoDSu(IwsXyzIoTvfAF9qVH2ZpDS8dXBC1ulcX8nefOyeQ0SKikrg5axklfT(Z3zgGteeg60DXFdZvK(7cCigY0oZn1xn4XnLFWFRGdAi8()Q4oo0oaUtUnNcTpK6dp0UHXnUrl8zFtcVhS7zoOeDfyhBc6M6Qv30005IP(G79HlJ7dtE2hvSRwj(KYpPmPA4s2xgkRx3p9MDU)vYCampIzbYc9v(7qDWnXV93CToV8h39M)8El79awYnMK5tiZ9KD14YHM(ugXIVDm1DxiLDFg1kWOXeS5oyOZbO7wIYlW4ZjWKLpGjoD8aVFKTgQ3YgpXBCvGiXsfvKTeD01TTRd3QIEFIAuWibypt6ZNpZBBQFZLp9QpFgJ5yjrh6R0drjggtjmXZ4JXQiRfOMZyAI2lwnjO6mGbusqWP5wVkq0hIkflLZQQ)(TVNYtGc2AO6Oxv2NE68MD4S6cATaOmhJxGgAi66AvJngaXIOrgKWHS9fIn4jJkFVe4Wsx4SPmo3aNJjmVi6(Yvnu8WtkEL3)7HtkGSrvuhbFkCRDzK)CD6XU(ltp(oD6b8SJEn22t9eeZ2NnSvgNsuaj6CaWclVWHHHHm0Ju6DOju47xMFtXYjq)Nt9OEig3bvUk1gsBvilIPnCFGZClnPRC6tPlLzlaxz)jYu3Pituy5ICn5XYWNdF1pcQNCoDAWP5obr8sHf2TiC50a51ylkkgx2bhZ(CJ(crgXHCDpPWr2V6ghHGst7r5cHq6c)B5kovx2fNviKlUalryWNuIH9Jd2YDdm45ScVtufpK(5CTvs4LXsNWBrZCaeA6WHVOeye0VIpI(wj3JFiKmMhxcGPQxzJM2vl5I4bTTBiT)m5aixTck52KeTxqfCb3tropfaEf960L7SdNDEG72etA9aE0XYInxbJ2tkE2JtU5tl80CHHIMGXvCEqShC5apRGwwpnaESrpoQwrdR6SxpZ4kAkoNDvuSPwnnjYmA0HKvTfnWSZiqZCk7gWSIwYGfMKu4VGQXPo0eLkVWkZwEIPNEPfJhECSzE4YlV0kLMz5Yh5WtprPzIVqhE(j(jiWNzruHMBXzlF0LwE(PJVylS00ZDW5qfCLsOQPmQPU4SZavorP24cdCnXJEC(mfkuq4wlXMq5q6hkrhuzmOZ4B2YUMZPZNzdVtKhFGr4tVyv8qJi2Toy761xKYFwq6(Vb7EasrX(qa8E0X4fQe7KST1jgjp(3Js(9yKFVBYVhN879q(9tIdWb)wEnR7Gii5ZsATqoiI2QZJQ0k13qOqdNvUpPeBNnBH5ydqrsBAQz(gQGKbaHlri8u2aQl5TKRfitXah)Dkr4vRmU9O9O9x(Eyg3ShG3U7H3xwZ5ndQ3qVcOsZLcehImElxP49aY9p1(J)oBfurcIGEYDDv49MdDmo(ZOEGBXOKAuFbdlhC)zLWMF)20JPzNYJAEiBLhXJJhfzlj8iHjpChaXWLRFkXU1bC4TPKi8JRd(ixYIegOTbuLcWtQ)QeSVUEVaoXLKolCr6)H0AhX0yktKy(xFvCgJFwTConigjHEDaJVGiV9TPE7i7XZRTmHUtHDlcZ5KeDf7CdzOnwMEjHfZ13Le9a(A8I)hSWACa)fCZWvd3vj7L9ST8h5C0tQa8j11N8QKhK5X8YWhdjOVsHbhWDx)BjpXdbKjsdPtrUWZugHZHgkogA494K5uz3hX74Hpd7Z8dKfRDjo(Xz3XCLp6elVisxKS9GNpt)Dvw)oOKQbNVRhKEKpyLOvxGoRL6v540tJIhncY7hfq0QWbUfZRDIr(PuenrjpYIWNMPgYihn5JsyQudesLCBCs9sktRlPzZcihWk6cdcGK5zKaRdA4UpqmuCHpv1()xEhD90ghbHYdTYQpKsRqkPVeLkfHvLOyijKivffmfeocAtpiLK0kz8zF2(sC8D9oBdgPwboKeGgdecjHc0KGvGcKeiYQIWNcP2)awO(li13D4NIu(f0z29SXqSngIAEP(fo2D2zMDM9MD35MDN0aN1M0UdevDLLlJVTalnF9S74KE5NKeUCTo098eL5LPOQ(P0vcKcOwz0pW5gZCAbDNVWMNMRt1hQ3YxvBDmv3yTwB2sJ1M3MW3H)LO722PX9UHNDzTN7h7sBZDwz1UewmDHX4MrZ3yv7TXouPPzRXO(wHs92XB8)NoNNKLThu54N2j9U8w5u2mNPztDbhKEr019MLmwBYF6qxAACQX0WsPPYXX0PU2Ev4cBPLNJrP75eVRpAyF0s9wA6C1YSlBz)TzCvohuLK87ZXv)VBNnVBMHpNV)Spm78F2gYY14UVJtsMhhWZz)k7TLzTFsJ1ngeOx6MqsbyaKB31utnL5t5rXm5P03Kz3B7LiF(4gzCINDYCz2JSzZRNyE(3fpO54Lz48iyZrM9WjALVuDyrZDjH2yo9T57ijWBsQkYpcLTVruElRZIBSZMWMMoQPHTqgeYLMmYlBOMMzAGStPKLWqkXywdqDF6V4ykN3UmB7U3Xs(LzlBICB0idlmo9ZgiPKVWIxzro7(oYEy6OST57Titgtnzzkz4NHpDIXqWwxC5cST81hvs)XPmJchZ(HjTEPFzoR280MTGY4QSB9LY(zrDPVM870jF7rTwt1n1mQlzAMHuEKAe8cl0g)SwPG9CeN9Zatm2qdHG(VhpwCiBieIAKgTg7qSuRGmyMCx2qehCSa6rtBs1xBdNRUZ3Wq(9QZCgIcM9UmzOAaUkS5nO4hzJ8CZ06BuWb3tlq8tbOqKsUP5ORW2QO(dmyUUZXRjN7AV28OBy9oV(kCCIvt0pmOXz3HAt)OYhk5zMxQ9VXPtzoF1FM2zMTa4NzhCY2BVOWQp7XTuT6iZRmweLBpI2tM)vRElTHNo(Y9R2)KQdVauEI7UUYa3w5MlRnA36UsyHEu7cHun6ekZ1lE5jmA3umqVFWIVy44lFdkWN3Y)0zOnN)fumP2xFBo)KTunGrTv(vABOOaGszQqQpyC9cFruTvgGwfGl63JtDGHIVYcklTq8fhwR3Euh)PkJpTPYQQSYv75EXxzY4l2hWvkdmp55WqhHIacjbcyWG6y)H69Eo96F7vRoQHavuMj4VukhFThHDesGCO84zJVw)Q3FbeH0OHFIBKS3TS2Yr2S3OyRlhADIBgwPRr3C9XuU(Kk9nT2WR8Qvht9w9QTs3kd2tIHNdqdLPGUDIo7cy2n)9qkZ)q6zF3qatLDkKjI8aL(Eu8f7m(IZQTY6absm0mkpBqQkr93MCZjMgj)ApcvydofveP(ltQoEVqpuR3zuUtxiYozkKr58KD3XoVfTvNr55dacuGmAHwc5ZbgmXtgbvxJ3jufYbqVFPRRS8uiUQkfUs)gFuPVhU51wdR)ePQNkCqFKo(0uvpim32P7ha)4a40kPheoqwAQ8Y)5klV8YrrFAexR)NdiIwpWSQpDcS9hBhYjQNVs5HlcoqfG6D7buOylQeAr81Nt5XHbXuIRnTsp3qR)zuMdgdfwNLPmljebaeK4(ZLiYiGKrzT7OlR3(PHGshIqBokDGrv6cGXxfPzfanP8pvPa0mX1ddnn(spuFGqA8nvgbAaXppJV8JV1B1rqWgdVDR(ClXj7wWJJGMDk41N4bQtIVJd)T(T5adOGd3CZsbt(QERxA2olOG3lcyod)MSGLTdvsSdUb8VSPoD3S0aBQRHWVVkXfnSuhXygNZFb07qaCILWkdp5HZmEtpmeAa0lyHuY9g8EL9HEEGe8Dgyi3JbLWCv)E8XByieyRscE4mefBIoUAL1NnpG11sIvlyXKhmhBhap4rJDgGzKe4TdLBgTMHaqOfjAgCBwMVdoSSxIrDaiA4Ttom9MjzCa8c8P1qOibddJdYkl4xYohl)vffK8jEKSlyH5DTcIoUw3q2TnhcTDbQ4RiXJM924HZLn7bT60JGGK7HWaTHSO4te7a19NC2KXO7GZRlFUF)yh0SxyHZBKCzZeXKKmhWSoKdHGItwe7IMj596yxaAqSlg7sX((y)a83I3zjSq7CY7YqejI(eBRzC)JmKdIZzlc(fYUam4qOnVTcZgjBZhsyo3rG5X0VCp6(dZ4Cm21Fi2ff)SS3XfL4SZJt6uedjev7kQZTIMLIm3HGWvlu6Y0JmOzmi9I4tWEa68uFqG)6i8oe)4VKAl)00b)hgTal(jj5AKMjJWu3IfdA)A0RbMFKbvtVggU5wqISRkuaW2un4bNlcaQE0z5Uc)8oI2rls)y9Um600jAegfJ8aNBgsMlQOOunnXjGNTWclSOO69ylG8L1uLvw1jpwuEV0UoW5gIyp1IdmuSm7XlZufLDQId83x4F)
    ]]
    -- 更新记录
    local updateTbl = {
        L["v2.1：如果你的出价太低时，出价框显示为红色"],
        L["v2.0：重做进入动画；按组合键时可以发送或观察装备"],
        L["v1.9：增加一个绿色钩子，用来表示你是否已经拥有该物品"],
        L["v1.8：增加出价记录；UI缩小了一点；提高了最小加价幅度"],
        L["v1.7：增加自动出价功能"],
        L["v1.6：增加显示正在拍卖的装备类型"],
        L["v1.5：拍卖价格为100~3000的加价幅度现在为100一次"],
        -- L["v1.4：增加一个开始拍卖时的动画效果"],
        -- L["v1.3：修复有部分玩家不显示拍卖界面的问题；当你是出价最高者时的高亮效果更加显眼"],
        -- L["v1.2：现在物品分配者也可以开始拍卖装备了"],
    }
    do
        local function OnClick(self)
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

            BG.PlaySound(1)
        end
        local function OnEnter(self)
            GameTooltip:SetOwner(self, "ANCHOR_NONE")
            GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(self:GetText(), 1, 1, 1, true)
            GameTooltip:AddDoubleLine(L["拍卖WA版本"], BGA.ver)
            GameTooltip:AddLine(" ", 1, 0, 0, true)
            GameTooltip:AddLine(L["全新的拍卖方式，不再通过传统的聊天栏来拍卖装备，而是使用新的UI来拍卖。"], 1, 0.82, 0, true)
            GameTooltip:AddLine(" ", 1, 0, 0, true)
            GameTooltip:AddLine(L["|cffFFFFFF安装WA：|r此WA是团员端，用于接收团长发出的拍卖消息，没安装的团员显示不了拍卖UI。请团长安装该WA字符串后发给团员安装。如果团员已经安装了BiaoGe插件并且版本在1.7.0或以上，可以不用安装该WA。"], 1, 0.82, 0, true)
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
        bt:SetText(L["拍卖WA"])
        bt:SetSize(bt:GetFontString():GetWidth(), 20)
        BG.SetTextHighlightTexture(bt)
        bt:SetScript("OnClick", OnClick)
        bt:SetScript("OnEnter", OnEnter)
        BG.GameTooltip_Hide(bt)
        BG.ButtonAucitonWA = bt
    end

    -- WA链接版本提醒
    local function ChangSendLink(self, even, msg, player, l, cs, t, flag, channelId, ...)
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
    do
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
    end
end)

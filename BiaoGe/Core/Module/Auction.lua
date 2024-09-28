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
            frame.text:SetFormattedText(frame.title2, (Size(frame.table) .. "/" .. GetNumGroupMembers()))
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

        function BG.StartAuction(link, bt, isNotAuctioned)
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
                    t:SetFont(BIAOGE_TEXT_FONT, 12, "OUTLINE")
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
                    t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
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
                font:SetFont(BIAOGE_TEXT_FONT, 16, "OUTLINE")
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
                auction.text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
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
            addon:SetScript("OnEnter", Addon_OnEnter)
            addon.text = addon:CreateFontString()
            addon.text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
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
            auction.text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
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
    do
        wa = [[
!WA:2!S33A3TXXvcUz)2YpTN8H9t7h6tNJxJEeimiPOSTIKoh(wCmFOHeYAZQrhmniAq2RarJbDdzjROCKThhjzBfPez5hk2Xw(rSNKXYE8KyRN2)hYpHDiaj)u(lS1RU76D3naKSZmHhjsGUV1TQ6w36w36(OQFWS)Wn)Hv)HvV4pULx7G6UnCAT8rlTW8lnZh4UMxJv9A3AnNFWFYUDWgETwUzGRxd)H(YQU(nRBFMsoNo4)6hSwB)aVnrF(p5VHDvVN7NSCTA(ob)p)V8L2nwduUJ452iOYuZSuPzw5pTMNxDamnw95CB68p00GcxLR51At7GYnlh4UPd5B)GM)3JRHJ2SQDGtL2O)8)d0Q8aq4U2XCRgSXKta(Al71qTX9TIFGDRG)hVyvVY(ETBuDJk1CB46VXqtc(tW)RFf45y0(pub)3Z)d(VnUHrDV1SRBy3ULDzNgNY4GXF0RLXzp3qgGFcFuHt50caH5PgTqrZHqVQw7gO6pgM5CcEwNwl1EZC(bTSqab)PLtq7wnmc8A0EZkoTGV0TX6fa9M12a(L8a0M7XQUNhRa4xwMwwW6ViQ4onQIRm3Agn8cmkpxHjNBcJGnCAeHEYZoyyto(zfMTL9Mo(XVYPUVtemaukPLt3HTmoWbLbdb7iiyAkX92Ohf1divjPSt0gr7w02TbQrkIhfaU)d7w1jNfd(fr)mNYPHsucF5(pAJwoR76h40AI61HpjWprSsiNc4fYDNJbgrmf(3yAhfdh8R0Vvcp5qSSJtuTQxJP2WUrdN6q(YjDT9MZHqSmrWovzW7dMVrnVcRe2vHLArhFF71DoslNAUNoNumAHRn8eKfa4hmdFtNa7a7k1DYD2ZL34SXSALDBu150aGcNqKdbwEJt6CgljSgGjc4za5yaiKaDoRio(CawUfGTbWaUXbb9YNFJshZKJNBHJBor9G9S9lENox4EDV0L35LEW2V(7196x08eqcd8D7EVFt3R9kmVJU4DUYVR77CPo)6py3R)TDV4BS9L(N7CTxOZf)57(YxENZ)YGx19DFPDF7R25kVr3V6IDF1l35YVbg3Kc(oV1Ux)RLxW)LxHUG78V9HmvC33)oDV8T26bV)234FQZfU7w37R78kFA3Z)cDF9705kVvNp4305cxPZDE5o393IRpi8x7grW35LUtNx96DF5xfa)o36vaW392)Ac80vdSB9AxQZv(8TU3h35B)97E(3BNV4L6E9)aO(6((3hJAypGdMF33cGbuhqyyixVZNUZ3CToV8h39M)8TEW3U9R)PDV3n25b3AR78EGYRQcGL6(3MTuFZo3)3Xukvv5HoKbOxBCGdGXv8xzAxx8J36U3nxNx7B7C1lBrQv2NXqvENZV7V)T26U)Iop4ADU0LzigOx19nU)2x)RaVssdkQWWH9p7sGpSZF8RbJWaSWHcmaGpGbaGloEprMkfCl78HV8237xIbANp8D3(REbMx)txRwTzND6rkwKUd9NV)n(PTWLjga6Ufga5ikQpjflrDiDOaZw3frnaZjKIimRmhmYr3bmWdLD)0B25(xX4qIitcem0Bu7HqPr1l7mYp7d7C7BJllzoh9tyWev1qWh9tOb9STcg5C4X4o3)8D(Kxf9aJhZ3GMcd(kgMUV5xbMYIEIpaimYdXbGRy334vfXbECaJdamDF7xemLoghmDsuTS99Uw3399iDsuz2(pEv4teP8fb)09p(caOeg)4Ffx3(jph(LOps3xeEbFTwSie5DV4v36UFKihi9BvYbIbAR78fDU1xjT878LFD0R4A47JmEbQIoVY7HEaKw)ymdi7JmGifirkoEMnnfN8erIgf8YiDufwkbelqg0Xujngl7ngavcEXlDObr41nsgr4LNHW9rxUZf)kAruDUZxbxQ7vEFcgrlwdGCNp6c78HpGww1w3(3sGKPnEJRUZBsMcU7n(xHFMHw8wFZ2F0DjV(MFo8ZIdn4rq6HgYtyafXXsac)zg5Z36B2(b3QZ3(sBF1FonjANp9ZIEUSLtbseU6NVZf(DG1(PLobNLF93d(8x96sKuHh9flw8ZLwmXcOe0dDiOSpWY2ufjEf443fwy(LJPie7(6VqNBDJTU9NrAJu0ID)fVb5v67DDU6VaRa3wF7Ta678VF(xuv)TZ38A8qYG6F7l2938oDU4VhOyaz1Pp)1bQtaxU(nbcdEnsTEBOIzyaapS7NFLU)l3eW6b(6w3(UGfR26b)cSUwG3IbBRBF5TU)nW6faklGFa0ZGQQrrjIB3KMXhJBgqIruZ4TFrsZa0LUZVh3mqs5IBgGVU9lkPzaEoOz09DEjS2hWMXN(z0ndmvxGOiW1QKFfuND(IRGPe4Agqpcfpf9s44a1lPrWF((x8X8)Z3)s4se9nM64lVjq75ObicU)YFv0dfMnGGBNB9fDEW1PxCFNp9T291(N4MMgdKKx)VF(xa)o4hexVNELEt2TOlApGvMBYCB4C68gtuV5g2XB1bVVQwovH7ScBma)2vWGosEJr5HC9woGTZkc7y5n2lpSvQ32rcOJN3yFwdrzscyDhzrcWxb18(SmEcJrhF8iOcR3i4qpqgKKAncq43PHJEZ0iIHk7gyGAkK6bJfe8XBtK2egAkN0nGRyCAvNGPQB77p1SZMRby775nGwPYPvEJGZ00XIUXdFaQThwVq4zmxaEyOCEJ1GOKUSyKkXSeeybeWJ2Wf3uYHb2sD)wAPGTg5wXa3SwZRUxlutgWfBs34W4sOTrvmKzaQ7SwqU9M3yUqsg8n5qf2IDZ(mv1pDntJcfi4b8b0Zb)1KwZlQrZOcNh)Xeh(XWs1Leg2hEydGI87EHRG(wvViiJydq2oCeqZD1Lp6st)mZxQWCRwU08LwyMYlFKsZV8sLx(zGObOWZUV(T299(36E9lQalJcWY477Ph)PhZq6pWgZLVW239tuHL5wzMzwc2wmXQQAkcYkZmncaSs4MdjcXXMF6shgaYyJuuwXpYmtuc0)wCgaiJkbIdp)0Zm7ktS4mHanMimovx3zv3NhoipAHXfFFf71oz1wEnNIWbDwJI5j)RW(moN6cmPxRQoTIl2iirJGInIUsHGVCn36bo4Ivai4l6)JLYkufcsrvpV)IoOYXSiayq8PFAWyeStBL2greQkQTR3Y2T6kEqR7bn1h2wVIqTOBd3f9A4CMsvG2l8SdXZn(fxbAeJp)JX6aG1eIwPNiLmi6Cq9qgCDwJXWTxqJnp3BaBph88IsF3yfXVe)lPLf(UXvcWyfdXagmfOa)svG0WTE(WQc(hAioNO8Kp7n36bxJYuPRwAILMEIvMUCPz(FxQ8SlVujEHny4Gdbu22KwoCU6ilDEsVNzftjwxxSgqIa8Ae4)3)3pAXIJwOuPzn)XmYlJX6ZVXulLzSoXkpJTB5sfccQPbXIgMDGG4wTx5OzgXZUY8)F(7kvUC5P(jRiHEKDeXJeAFAWUcP5CE1RoYtzczpqUdaGi8Je8nt0BafBQwo2boWhLZm8LXRyAPUS7hO7c0zz41HHIjk8uJc(DcfbvtIDDat)tbwfL4vqtlL9YPD956KONiRsrVO36IOIY2dJfhRVePTdQP)nUq)BCvv549E)B8m3)gxF)B8unaohutzUUi5zs5CWVQh5uXfMTJswulPc0V9ZNBd3ahU(j5zYQ5JHFvV1pjfwykj8FjvG02ptyNmZ7VcqDGfCSbAriSfcIpKvTneYZXBNyjG(05mXpYuPFrdlYbzvhbx)k3IxqRST9mGIql8iOZKtBVb5uEzGS4cwdSEkoKhwHrJok1dq(zwHIFwY1mKmuCqOMns0kCbU3aidZ7pFdyli3is6x1aebxqzgbTdWLAV5CT8A3Crh4M(9ZzrRPd7es8(ZAz34K5n8BxzDyXYBu35uo1j7JDuYFZB88a9uZB41agHk5fWNR)0G(eaxEqFm7c4nG7rCZk2bRaEcwXkokORLiwQH3dQqpm8hYox9dA53SUlqiWWaT3z3ETyV0wq1AjOerkuceKebacrPucuife2adjMkbgrKbqIj2kbdpiaGJmAOhWq4udgCueafAWujq4bzayQgTzh1basg(vt)WmbiUdnydX5JyEu3pPzQI)Iu4pN0NIIdIcUn8DAfOAEBEdB5CuaoumVayN1Qzt1mHhWMjTi0I94QqeDjD1fw0rwQd(NXOfnxaRSk4L0bRI8WubSY4IN5zbY0rMskp6p0Hud49RmX8tRqKpswwEdqVUHHBtBxGam2y4HxAgzjNAGfKMPrvdB4)zwJYsoTRwH1SBSMt99V6gEpxoljVhgCBqvgMSDqGxJ9pvDhByyjHILo)0ucGgeiGZzwA5JaeuTxGwddpkBbf26dtBJlSQEi22kkPPrnSKILjbs4jr6KBJ1NTL3MO1Re0nGFLSWvLPRTiCcidmOfAnB6vV7fMtgeAkYnov5sUB60QWe1acdGAkgfbvSKhDnYA20dRGwwI6iEeGy7Yl3yQ6URDYC(o1RXVlOAyl9wRG3Z1WPfnvfY6RW89WceQ5BokVYY2tqGGWqUr4EteQ57t43IEN0iaK)9JkeIG8yJVTg6Iyl(P7r0mWsDav0xRTV8z4IWHNNG(yo186CKKIfgtnrHHBuGMir0clnHda6wXrak1Uk0Q154mfEISstHKDOGzcPl5e1dEgNZmnGtsM0XEzsfUodJ0Xyj)cdkXSWajsiONFAX5GPGaKsPsreJzAaNoNTzw07GZD9ncWfxKInhyWSKNx9a3Mq(MLH4jxnq3AILM6WlVs5fMz2syzSf1mbijSSY8ZDyjOHINHgdiw9faQVrZQtdayee(AuFA)ZrM3zLNytFW)G826lQMO8eBibSzVsjQ6Pi(ewjJt)l1vf1Knnmml4TE8YKk4BqClU(KxYlg4VYvrgpzC)VaJfnj5hvRqDV19HQvxupHGc)cXJqEg)cXYiqmGDyfDiJrgpDvKzb0pM6qo9MWdRHHngzV5J(MKTGlRYCHsoJI3bWNXf)4UNOWMq)eHEekPmYXeZg5PaKytgeLw(8pbL7ewyp2Gc)Lrhqb3AVnJhSzTt5K0mEwTHORuk9C0uP)TU2G)1ihIQa1XSA78gLfISb0tq(CzpMknOfMYUhes4z4JrWWsqaaaCHhgvyW0IIY1LIPMgMTMO9pegGdEqeewODJHF0pdWnLkut5vCL7pIuKI9Z2vaCSOQmCeGJ2JfIt6oXHqd6buPceL8EAsczxSNIAxSsD6RQDZEQJpYjGvcU(pa(7Y3glCy7Gaag9ecVRslh7tMQjnecAA4oZh3t1qDbtgwDt761LQW1MNzrE6kRsisjWR1UvlNgbHfLsrsuRuXixyDnmt5h4dumnoDJxrZ4Gan2juBxhYqceirJ2iBsbvHe3QMkt9Kjd(tPTcTmQ4rc4i4uoifMSaYso68hXgsvyE8GYQ8UboBkx7S(vfliSdeTSyr0awrlqTmpGem5zMF6C4vNaFB(Ptu13OnboLxJGwE11Srqye41ULVxRCMZdPZ1SxZ5jWp5jMVHFtN1cuyfp9kiZmgoVkOanYjNdTcYKZva2bkpr96hgmAwhoIk2ALbfMYu3TXjTYoVLm9auSqFkurqzNMfSyAEd36wYjgWkozIHau5Yeni2EwWDluf8y4xJrrTcvSBXZyHL9ga6vf5b0jy11A52miN5YnWEuZKY0A4Pko1TB67uLvrpi2caA3qEPKaHSLZM2UHMhmCffIwMMpwHXQzg3baleeWftKXEjkgrprubKaA58gBAJYTsuxdiDdSuXI2N(zTR32H3Ys4IGsAuJ)gy54mheH4GkBUtjySR4M0baAqvu5Ik1kqcpoipcCLPC1iksJEs0xoOmNVAPEzO4rVa7G2(tAJJdUCTB00ETtMJoVy1e0EwwPFnmv14iHHOyXc7ZAO04BJAfIOEqt6kgvomsI1ukLXbWOfLg3kk7F)NLbQrgSduSXQrVmqjjGnuA6x5nMCXsuQcKNebJfq00iwilE6BAPct0cxgs7C8IQCxfrt2zQ6gO2VqYB6Mf9tOtZ3kgUyHXv1qulohTKvITkLnEiIv(sS79KyXDzomtr8oaxkP2(JdIOvXz8Uy1fOLzAm1Z6JkCSZ1c17dRHgYW)GIp5YLkT8IHVByy83o84sA4ijgYKp8ZG5kGAXbbmUsHjD6S0xafrcgh5MA)oWcrxBAsuuKbHW7HwL3U1lauVFWRviWRzcTj2mpfLTdG3X6LAsC(JnLfvAUlVrRuazp3Ka0x4GaF0vP1p9k29tCGNLaTd6QhOFFc90tSv6smXBrgVZfgerHdE5JgML7BhTrKGkYjllnjTptfZSY16thZSSCTojozfJ7MMwpch2et07WHQEzCrghhRZYvKKkkDHUWEJWRKGKrMRMuDh0Ae4eT6k9iDzLwpaQvgL5LqNJrrQRr9I4ioH6HXINtJ0ROnuqSJNO5j5TZvEOPGTsNXhWLl2ee4fDmLnBirBpOZ9HK2NW8irVkALgh7KY0shofezys1EAmb7GKSPksXgL54Pw0RTVdYIks8GqKvYIvEkcEtRCkoDLS6LMWrB(DkJnnBlLIRHYbtlFUIqUblNyI61jdB8mQzi2bsCS5On7JrgsFhmOGwnAd7gR7unlrHGc)qO1E5iTOWdUQ94Zbcx)sLA(y)HbxFzrCNy)t76JoQPS0QL6plB6TjPIku11VMQ4YtxzkeaihaYusNfqjBAC5rLNijzMgkOik7ws2GdVVyJhJoO6bP0pa1JdozDGjldkSNUtjrmu4vP(HMKLoxsDSyvUuEkmKxvFqJlfsn7wAz1KgHLQKKMkzAi5JhBdhN6ed4w1PEGWrQaXf0qpqtlIcblCxEs8lCur2JPsb2jSwcTYhypxMHoMmfd7xTSgKbNvIXEJ2ZAO0gBwCZfuRPKgAAIUrPC6DJsYHtH248lrTSDGAOqrSrpuACbagTxpVrfCiYahMf8hAcbUru5j2zj5qz5rjhhP1dnoIHzSE2KwDkdNVSCok2drlO2dbRhLC4XSEYI32ygReu9vdZN1qzsb4EpYHJ7kQ2fJmh8rEw5QWZ5GIuN3eHsPFi44p4H(IXHoiUwLQ(cQ0W3omOnnI84qEGnUim(OxEuVy6cUXgHT3PHyh5jzTN2orkp0ZPHGO(kWnsc1yPAoL2(qyRnSE6q1EC61avNQ1Plm1RfhD6uPXu4gtLy5m2wTY8mqZCt5z1u8E0XhMWuFSGh(0axYJkGQd5tmiP(z7nXj0yvVnZnsr55IjaMdOmU9y6oZ6culDY5oUjQ3u(WT9Raq9uEB6SmoDaK1(obmvXSH5CNP1GoALaZeqdhWGxGmSXBo9AfAhBUr(LcWjmf6vYaJcUOinJnWYsHvLvDSWgYPr3AIsDA8hORNyxfqRAd9XNLypNXMm89CmphFKPWKz5PztK6D9H2tI2(XTmiPGtsF()e6dCnNoqwAWbLxYvIj(JiiE8fZnniADYX2aPDUbqBCisxcUP26qxGUCL)VWJxmXtcc(IgMpL9uHftpXEaj1PJK7EchbK8cghn65noRbZ078XhHbjXFcyodzKBzcp)0vUrF0ANB6vfTBb7gEnoZMGv4nvzvM(zsLKdKBj(Vo10a6dGXZLQ8ATFA8j4v003SzLzEUeJmIOq2r(iswNrRmsB6lPoQXAVl7jR4Ca2MtJCi05UJLMm7UhlE2KfPenzsAKeSiFkughdhWSzdu(RhAmw9mhL01e67v3gyRWnOwLJxghRx8H53Mgh2tfHWbEuBNkN4gCtW2ZYDogJYPP00hS7d11h20iHlfErGdDqYiWIQ8McA4XnOUd)stYobXTstHJI9e(d)nCzWTsaGYtDEikJhIdBmYoxY1usf(liIqajXfwWPwGMtaawGrPtrQHEr3QvR7ObCYqL8txaXzmrJjjsaylh66PkNWBMdhKFHHbi87yiT02Tsr8PkPeHwcrsQJYr1C9xWBTtIomOfoijgs5eIOrD4erMJql64qfAef2Bqk6JCwH5fkshazf2kBBpN2Ctzo38)UZY4qF(ffFZ9F2MRZoU9YrHJOzhOSNT(tjdPXgLi(sH2YuYVtDTZ77nfRcOSoXS(qlKM6QK3gT0ijl14GOctr9XSSFs1jVwcmH1cQCMw54aQVo9FIyKX8M9jBm22NGFdNfnLDJaKbPvCN0fPFgfuQdsbw4kW6kd1ORN9IbJdhccfNPYVg8Ure5KJcpL(yannM(xz5ueW9AIcul9hyy10FAubpqZu41)OnNeh88KSVur4xbKZhdJymnQEduQQamh5XDH5H(jIIs)4ky4XhatsecV1yNQf7NQ(3XzdR1XzQZKSWttnfhPusoHKcS6XaQclzOC6fnWWebJGnOlk0o3OSkXikYKKedOFniuEAxRlEQLsut704aGwDENI7oUmpMOiBx)kMPR6k9CvKT6ofqJVLBTQ7ZlprzYSW9yjSypq5Mk6skwMPx8PQDd3nZ1eLJ6Xic)9c21RdVdC5CPn5LbsFmEWdE4XpML0xL0S5ajHMm1sgdBemK8fjIYBS4YuuGqgVmbSjocyficWpb(dKESvs1Xq9Z6pzDicOTcqbqKRuNdWAke8Ssom4W0RH4wLJKe0yNjlCPbWCPwDHh096Fb)DeGSmKgVzsf(lNlkOzSRfu8rJCCrDDmeZ7)SU(UODUNm(aQcIQEhPzhxkJe6e6MAJF5e3TwVghZC7nwWhR63fmBJmfDsiJMMa2iXUO8tAR4bQbxEyeoPmYqbsNwQ6y5s(vaNYn1Me6s1LcxsjPH0LCvuJSg)r5bwxsT7V7VX5sKOWjaxtKRLa7DctouXEdNoYilnlgyKSrvvb9oApTuZT1K5Zu1N6uqivvkjGYvMDesAyjKNecvThwasPOGENz(wMYkHm07LtbuSjyzkNZ3RpysPhsM7YAI5)(AywsNKFBzji4p6KFt1Y4jk6N2TdAOx9O)f6vFmKc)m0F(AiZEti7EuOh8QqIEwOF8UWdjpm0BEziZEAitEBqtyCOKzUVyJvEMdqZeR94AxctSKBK3KjIkJFZK545FRn7TmAkNf0JyHFMrQrt0SffhVgQNSO6cj(7htB0WsPCAdAwqMM3iLOLb)K)qyhBAp)I)E22zKPHUkfm0UnLExb5egJImlk1A8YU4c0EITOoSzPrLKbPgopN4gFtsn2WczePjxYc2PkJy2qut55pqifkS0hIrvs6WW4a6JcdPT9i4Z(DxcDJ6ahm56(HycfOoPccBHYZRGm6Hb8zBeXwU5OoH9XNoKrXcF4PBx8LQ8MEvZdzYrXau)6e64(j6s5k8lAo)FtN(70xBv4tCM)X221Ddot0TwvzCxT0zA6G)0QTRG)c5nZ8p22TjqYDEdO4K2TWVbDTjbPp(TRe95kUnQwcNiQZHpTnXxCvCh0MeHdW2J08Th(YqcRk(o64VQycbGfZIlzDahLouJZnSlxrrTN2ksg5eVyRjnleNs8G4WdBS1TV32x)129D)GOhYXffV6e506c5Zmt0FWMvwNtbddBWsoBc6NboMAIU)CIxnyvwhMolWy8M6ypfiyaH(4pbXa8w(QrvtX7Rk4vW8GblKlYzHl3zwOpx)LeedW8FqgQGT3CS3a2WRY3XfwL9hXiCrNvHKDdg1d()vW3VSTGyNaNSdGXyhRfjkh9ueQxrIgJLmYhvCO5UqVJH(aFwo4IUm6G)Hpf0GjraCk9qYC1ghTDpgJiM(e(4RQA6NtpjgUGS08LG3hKY4beowv48)LLIuvBZWz2GAxXCEHsUz2CJj8GYhG54mSl6BfAczvuRQchGHTm0veECJyUqwUrSKCR0jZJNuDGu7ynRHsKQJoOHEer3bQMIj8Yj4P9ACsUx(0VfDTu0cH(1nZeDE316Q6INuOU4EWEqLvvOnWbmmAnkKWTnyk6C0A0vUxCzpRXodplltks005ognXEKOaXOzsYcKTia0Jnv3YIc2(xWpSPRZrxyMwkC3OOgA0779gQQ3L2W1IxmbxSUPvNRAPq7kjXoNQGbtgSOpSauB(CJwSycWRF1wU8AyFAvRwa3YpPMeOEuzhC)t6ys14hQkPEUuw1mMFoVrH9Mq5upuZbi148iJxudWyRwc6PubCJiqbEb21lHf(vyVAQAPzBbxBJBIBIlyIdrgvsEt)5GH6vuORH4pRzDeYPApH0rcWh4xgMQ8Ki)jM293qbPYZPueAoqyehfwffvkykS)JTjTcBqZj(uKTkHYsIjcOyxmSwAIyPh2roRUoZaiGBLNxvCHXu)S1AAD(twSLe9fsAl2dQTzp42QD22UTejOFpn7mJ2(9iWlRGNCmzGOFvuTrpAyKICqwJ9Wdg9lJNxiSDsjBBjDcGtrGNlBRhjC9aPYUbShE78twOJz8rvEStR)udxOYi4tADfDkYRP2sJKL(zR68dY90bPAp16s3wAtr7lnhcV6vguGtNlztOz8tNWxomKSS4u3eKMge1uDqPNvuYYy2NOnzXtzsr)0xXkK5jFGFGUtGSUBGb16PNldnd(DgmwkkR(7O(mSdHuPxVc)PMQRbejk1e0RxXmrfw4k3)Puai7DxGQG7QhIJmHfIJIfhyCmKgQh8aXJN9ggqet6DAAg85B0Sn8zPxNXWtJpK2k1OI5dWwwGx5kJkHcewggXo41Dh9jvdo0j(yBhQiypcbCP2aXkURPqSdeQ0P)Jtu03a3E6yjpSegX7ftjOZGhvG1JAcB06DubZVzEDH6VvkqgYkChPLJVVi2ydTYuJnE0qhA(PbjOZCwas4pNztvdGnFtOBkcVu5nnK(Tx5iKtZ8k9fUY5iqgzDA1pkqQZOJNbf2zyFIcRoPAItKwIFlrEjXP5YUZKGbNNEj8eqcXHPB06uTSDRwdTofOwQEM12WzTtom6JMAQjjb)PcHwveezH5mPLybVUsB4uh)I0l2QIubqa5vsgvQOuahCZzJoQQsKTqYfug1bqDLGEChBy6cOyvcu1VIMdHMTNKSaf8BWG6o96hh3Ye7Q4WdxplPQmfi8DWymxve(HEFQiMHTKeeZXg0EwPanPxqNcQwbc5g(N0mrkJdns26KkRfPv1qo1brtEWxUW4OdL6DWlKpPAl(iWmh)1Dp3FTqg(hK8D0hhvy5jvxK5dpSr3RD5TEW7OY6NaaoITVFpSebDBJTLJL(L5tHlCXIYmv5L8yB4g4iVKIxXGdly1s4bza0WqYkF4Ik7EJRUZBEf(fsOwQQsGMaYgOJYtXxYKNSK4cgWbj5QnYWJapu3Wlj1xYQKeUkc2gHZ0Bmh8edZV3KmATq53n4YK8XplmbbFjgpsYDhwIJF9QGUbMqobXh9UWTbOGnHwLcbAi5z8YLWPQc(Iw8)yjFImrru60Em2xXKeprtwgKcP2)koR7cp8XN1RfsmJFoZjACgil4GxC2uOtps5c0QK0oGJkSe1cR0t78L38Na0lQypRJswCbvbbtLaP5GPm)BujivMPtLNm)l4jdPj3c)(c3SOncJYmlrUKuT1p6JjdREMjJZ(P7DCrrhQ46Kz71rtbx4T(Iop46)NgHXjQQiME8OvvrgUrMdSUKzgfeLUaD5ZMevL4abG6qY4dF5oF0f6(wFZ2F0DF0fsgYvHLzBZm6WQIBqqzBigoSdYP5i7YNw1ELu1Q31cmo7hxVEWjzbGrkMDDA714UpbEoiYKYPvlbgnCb5yV(pAAFdwayE)v3WTwWZ4Cg0noLMaXGKnvGM(u4JLuqzM0ZUvvsGGRpeoGUaf5jHjanOtbM0aFqUONo1gEE(ot6DAWsOWS6twYgRl(BJq08OCIybaFso0DTT0R4Cu)EkGGYwE1trpFAO)voAtysOLaIFez8MmSVNOGZwWmoa5J7EVF5ox6l35LETUV9NlrOOpVqXvdSdA7pPDRit3ZDezPZwI(Csr81kfzyEt4JkEudiYngP1D76qwu6Qt(xbUQgU)WF93099VGeAu8Tjijnf)7WjfjgNKmKuA2FJ9Tt)fZYeVXOj4eg45c3O6dLzUweDq0fDfgoI8YiSKPelYqan2loHRhswLl8RIfRaXxAqmW6one12CYjM6zMBLLp6stBkVWAdWAkycrl5VAbCkpa9jxXcOan4PH)c)P0mHUG7AuzggaNckqJ0(z7p7sBF3prvKyetnugmgje5fJQmYlK6BoynYLxFJiPyiLErPvSIxYWszjPRV99(L8B2joNIbSX6UG2slPjfKNrYyGPGPps2IKymNG6JsVeHsX5Wb)Qir8lDU6L3(t(IEnYD65W0r(gLiClukSoQiLjG6WmH1XU140yM3cTuSAGL03)6(TRKZ8XooOAmnTc)6jWFvsj)BB7h4w7mhoNjQ5kRvbMEFSw2nLfQlQMvd(e8yQqAybbxj6R)YUVZL4zTNCo8nr4CfildnfqsEGSNfMc9WRJ8IWdzojVKKv6yq0nprA4jGKN(4tSsPJT8kpZJRmecWbg94qUcLWGziECi59XbnkaAd)iAGgqzB6unAhUfFOe1dkNPS9)6968BE1hsZuYIyv2jlS79tmgwWgZapPyKXeSiu55oo9r1WjuEq9roQg0imLDkg1bcrguEoU8cnS4Riz9Oonhh2XvJzcd)jpZxZeBylmAITWm7Z)R25w3S7B(vDF3BoW0gpfIufvZYxvKYKEvUYQ2(J(iwB)rIomJkSpjqVOlylyN(zTR32XhTaAr(0H0pJwpRInewFXr9l9pV1dEBWO(UV5Fq2(lcV9yiPxxIYvykqVUASas4cnUHhxGNrOijC(5XqC47LmFxL19WbARE76bVYyEoi7l8a()PlkZAYitjgcZOJlbKnqC4W3oQWOh1bR5G2l4OjGrDaXyWnzxLhl9Hp3ygdmgowQnJKQ7PMiysPjY0INJ20ktM2t2DMt2SXNC77L886b3Q87v)Q8Q2UzYRbfFHbdvbK8rG6CMkUAt7RBizPtPLFrgNIfGzAarhrV9yTle7G8lNJhl5VOLemwgRtBfHoqn0BQ88thk)G9gxnZIq0FdrjvmcwAwAeLWJCjxklfT(l3zgsNiWm0P6I)woxr2VlWLXqM1zUz(QbpPP8d(BfCPgcV)VkUtcTdG7KB9Pq7dP(WdTByCTB0cE23KY7b7EMdkvxb2jMGUzUAvnnnBUyQp4EF4Y4(WKN9rf7QvQpP8tltQcUKdyGz96(P3SZ9VIXHG8i6fiZ0xPVd1LUj(D(MR15L)4U38N3BzVNKLCtiz(yYCpExnUsKPp5rm7BhtC3fCz3NwTc0AmbhQdg6Cs0Dlv5fyY5ey6YhWuNoEsVFKTgQ3Ygp2BCvjrILiQqBj6yB44uxERk(9PQrjhjs2ZK685t)2M63C5tT6ZNrBowI0H(k9quIbXukt8m6ySk2AbI5mMIO9IutmQolXakPi408Qxvs0hckfjLZQQ((TVNYtGcokO6GxvoaF68AoSPQGwlek9X4LudneFDTQWgdsXcRrg4WbV9fsm4jJlFVe4WCx4Szmo3KohJzEr89LRyO4bNu8kV)3dNuiZgvXDe4PWTYLr(l1Ph75Vo9470PhYND0RX2EMNGO3(SrTYKuIssIohcmZYluyyyzg6Hl9ouek89lZVUy5us)Ns9OEig3LQCvMnKwfzwetz4(ipZTuKUYzpLUeMTi5k7pvM6odzIcjxKRXpwg9C5x9Js1toNkn4uCNGWEPWk3Tiu50a61qlkYgx2HhZ(uJ(mrgXH98ojZr2V4ghLbLI2JWfcb3f(3k2UvxXdMviOlUalwyGNuIr9JzB5Tje8Cwr3jQShs)uU2kn8YqPtWTOPpac1D4WxKdme6xnaqFTZ94hgiJ5X5ayQ62B20PAjpapOJtdU9NXha5IvqjVMOO9swbx07uOZtbjVcFD6sD2HtopW9AcjT(sE0XnHMRGq7rf38eOB(0cpnvyOOiyCzNhK4bxUKNvqjRhLj4j2lrrrPmvIGzYQPi3KbeCuIYwud)lPppZPCAiN7YIhSO8Ec(fqno1HNOu5fxDUYtm90lVuYWdd3YJuELLxT0mRu(Ohz6jkntYf6ilmXpba(mlbk08lnx5JT8klmDYfBXLNE(zNhuWvlbQMYGM6sZnJSYXkigwyj387GhN3OqHcmxejoikhqLpo6G4ynEsCZwo1CpDEJn9xpp8mGiaFxP4dgrCAnB761xcZYvG7kTbAXFurHUfq6vJJ27ijYHtBR1hjp83JI(9yOFVx0Vhh979H(9tcJzHGw(nR7cii5nrTwz(8b3QZdQu76BYuOHn57tcHRzZwqo2quK2MMyYSbkiAaG5EbcolmK6IEl6M(rxyTrFnreDBjdBpkpT(5VALHn7b4f2E0vG18(Za6n4B1PSCp)qHiTxCvcoeaDLsDWKVgwLQBas2n66Rk6QWbpgN8XoVKlMO0ANEgBfhELyLYMF)20tOzNXtpEzM)oMhhoksws4rctEKs9jWLREkXEvbC0fKel8JRc(yVScegOSbufdWtQ(2bSVUXUKCikXD82cuPdOioGPrxYfrCzEfysGFwLConq29aFd)cVZhV9TXoWW8e5vwMipKqUyGP87HQIDUH00glJV3Vs4g5IJEi)M5I(hOWAym8fEzVvd2vrBp9STcg5C4dFa4HV1N8QOhy8y(g0Hfc4RyyGXq31)w0t8baPJ0G6uO7WmHr4CGHIJdgEpbAoL5bqo8o6zq3GFitOcJWqcNCTXv(ytSYsaDrm7bNzM9RFS(DqjtdoFxpi9iFWkvRUi74tQxLJJpGjE0iiVFuarPchWwmT2jA5NYqacL(GfcEaLQjjBuKIjrzhTKOKKAJtI37yk9Ymzwa6mtrvKnij)Cgj0GFAUodyJU2eV9dQy3kzGWdxkoF9IbJY8njJt85zsiC60dnZluMkrrp55OheqpalLHKd5w030N))lVRVFAJJN4q5Hwz1hAsQqQjVeLkfbQsuaNqsK(QOYraHJGM0dNsuFX2N9z7lXX317o7G5HkWHKa0WpcHKqb(MFyfOq(bezvramriL(pGvu)li13D2pfP8xqNz3ZogITdquZl1V4Z7T7mZo76p7UZo7of)F(Br46C1HwTDIMBHTX2B2HDBT38wgcFtMmIUABVvV9bEEpZ9CNGlTbluvuCjmz6eJXfJUvD)SpeCOQYdRPAZLcL7FhVZVpEjpCkB0pXXDRj)Q8BdtSfo4XM7oli)KOZ7TibH2SFmZDv5jPvNhvQkxylMo01gFfoXwA6LOx62ow6Qs9KJoB1whNUz23Zs2)q6xvYovzz)oSF1)5wzZhNr4l5)F2bWo)RTGSs1V7h5LveWo88Up)2BAw7KitD7ra(LpesUmggL23B0MMk85SOyHSu67kSBV1sSv2VIcoWZMfUcBr2Iz1tm097taA5euy5di6YtHTWjIYxLzEr4US5U6sABZpsAG3Lv1V1yuX22NTSUUiMXUykBAeMM6jcfqjxvwNPSTMSZ2gzLsztHLKs1f1NZvn)JtDL8cJzdxNo22AbRYoixWmkWeJZ)4(rs5BTfurI3T6b2gdhvSfF)w2uWOnwHIV9fyRtQokS0fF(aSLV)GYMpoldQCycbdA9Qqk8oCf4IUIOGZY25RucXHTLQDeYRxHUI7OPg7Wo2wYANLKESMedct0g3PQC590eJ9Zcdm2wBrH6FGa28OyjksAKhotUpokkilgC2vSeZdphqEeAtU1MB70TCM2gluqtHZsCa27CKUQH5R3vWis7Yf5z7033UOh(hxM0(GCHeLC5XrNHTdjZhyXWxNN3qok1bDfWey9gV5888snsAFyrWz)JH7MlbMUHK7QLxW7sb3cr(G(u9)Pj3ltqak)LzbYjocJScVBO6RefZkk(jTYqcUQjRhkqsRjpuYdNSb479S5uyjE19jRa(W4HxXDxvCk9N8GoBuFIf1MkM21NW4rl(61UMX4ZLA1H1hEg9XxcspZnxxBKRRD1vnMSptRtSu)69I5up(91wya8kwyY(OuGElILA5HsT6vOz(m2(7EIMEXNrPK(GdMEXz6SrGIgj(nAzOKaYL2Sr1VZ0Mj(S4gjgH(kGw0T4tFKXsLyjTvwk1YJBmq)6t)yTPNRUAosn1Q3)TsLyMulpiivAJSi55HGkcLaewcmWIf9P(d9B9u6Le3RxBslHRVMAHVZC1H06DY0RpL2LNrBW5mgpXRxBk9RnGrI(0gT)mJVG(TxIswqWZ0tVa7s)7r1w8U0Z4ULW1vZXaYOf7oAdEVul3tQLFOrI1tpq8mJnV2tgLQu1))ZK((ZHQNNFpuLp6S0kP(VoJ(0daYOXaZRDJErID0CeJ68jzf4PoJnJ1Mx7PJaQeGngrxbLZrgnZJMav4t3d8kucs8mTvUS2QZI06i5Ov(3SJAdE30x6547Bi37PnEOHtNEoAJh0UUHtXpK9ddzN(s6bEl1YRwxT1(lwRT2AXEb5XCJHFkqi67bHv)X3hl)H2KEIAoSCM9IqdSbq)M9dDgWsyfkrQ1xq7bdbQPmxAoT(VIXWZRTa0lyitrMkSexbaiqMBVqMytaAgTNFdtD9gp1du(quAlq5d0VWubm9AipRh4jv(PnkapZC5HGIMAL7A2rip5MQJGwaPVPGiciuGdpraGhb3ou9lZR4xmGNimEfdQk9fTil09()HqU8GooW(TBxoYP86vHxT1VZ5p9WEkRSpPG4mUnFiPvoQlm17lClcuv8IbB2JpE)m48awcTyKSyiPk5uGNcWZGxOdJHGIbbutz)VuiOIkAncc0IfwY1vqLSxiuavblJHz2HSyaElXXIyslNCQUcaiUvM0gGIkaq0UHSh5GjpbijYIcUH0zqeomdeErCAb)mkcDZJPXG3jpoLoqX1vW4RoaTbVZOOkcD)IVItrmKSBEoHlijkRkDWIx4a8(C5oIdVbefHkOIFxGo5SuvAfrVO5Dns0Sx6iCGS4vWhbXhjOn43C1z16ro6HIjZ7dqDrmwgCLFrZQGDcdEO4sfrL59hZDUbJSedgnILuiL9wzY9(s4NC5oV9SKORtfsFDXfDjzE3c44evW0TO4fkNL4UO9k9Lz5mwMS(PPF5ZrpcFmOtZftv0Dy6GmFw4)8acEK2Z)JIAECAN09JyDs7gApAYKyWOySOsoU3364kv8gO3GFrzYcHWAoxhnHhFTXW90NywqoQX)QpKGN4D3P8p3QVQ9wxdTd90q2d6dGdMEtL)4uTpXcENS8YlVIyWy0M3fj995XfcsR(GmBrURS967I9HLbF2Tc3HRPU6R5y7o8FD2)5p
        ]]
    end
    -- 更新记录
    local updateTbl = {
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
                    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                    edgeSize = 16,
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
            GameTooltip:AddLine(L["|cffFFFFFF拍卖教程：|r团长ALT+点击表格/背包/聊天框的装备来打开拍卖面板，填写起拍价、拍卖时长、拍卖模式即可开始拍卖。可同时拍卖多件装备。"], 1, 0.82, 0, true)
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

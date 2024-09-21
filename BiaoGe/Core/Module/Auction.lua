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
                        f.autoFrame:Show()
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
                            f.autoFrame:Show()
                            break
                        end
                    end
                    if f.itemFrame.hope:IsVisible() then break end
                end
                if f.itemFrame.hope:IsVisible() then break end
            end
            if f.itemFrame.hope:IsVisible() then break end
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
!WA:2!S33A3TXXvcoj7UFrFAp5d7N7tphVg9iqeasrzBns6muKuumMp0aczTZOrhKgeni7vGayq3q20kkhz7Xws2srkrw(HIDSLFeRXzSShNjY6P1)H9NWoeGKFk)f26v3D9U7gas2zt4rIeO7BDRQU1TU1TUpQ6hCWF0A)OQ)OQN7VTDZo(1DB40EXJuAUzxy6pYD5MnwQzN2l78dkUCZ6nB)t(Va(P1oR661QU96LCEb)Y1A2EnB)YTk77UMt5QR3WEn3Ll7VABhVvBwV66F0YD88BUge2Fy71xSwnph)d939t)h)8Z8x9x9d)A7glVAZ2hUPBd)kto9cLMU4)NLBckwZNVXspVBlNFAld1vg(B)Gw)3JQIJ0QQTVtLoO)8)1Ud4X2(UlFu3Q(REGjaFTT9Y(UnB4T7IE(2T9)F8YvBw2RzNgvx9aUnC9)F(RaFhJUFAf8FpZp4)6)nJ6nx2UUHDN22LDACsJ9f9XMTno1P3Hb4NGhL7KoTbqyEYc5EgZDGEvTonqvBemZ44)CoTxOZAz88BBHac(tBh)oTBy43SrN1Q40g(s3gRKd0jwEv4xYcqBMNO6oFICGFzzAzbR)8OI70OkUYCRz0OPVr5zYDGzMWWFvNgHON8S9f0KJEwUd22EnhVOx5u3ZjegakL0YP7Wwg7DFYGHGDeemnLOEB4Jc7bKQKu2j6GODZB72a1ifXJca3ZHCR6KXIb)IOF6t60qjkHVCphPrBNvC98DApr96WN47flwjKtb8czQZWaJiMc(BeTJIHd(v63kHNChSSJtuTAZgtUQDJgo1H8LhW1U5moeILjc2jldEV)SnQ1mxXGUkSuZ745zVIZHB7uZ9fYifJwgJmIrVF)n6(AxO3L(vBCVBT9zU2gp86B)r)YTFPRGBj4jpZbQBWC)1C8T9TRu3jZPoDwJtfXgw2TrvNxaauWKLmiWYACcN1TKW2aMKGNDKHbGaI3PTcNnKbWoohSnaygm2hGc8IRw6OMC8JZDmZjQ7VZnF5709S3R35V4wVYd28n)GEx9CMhhs0GVB779B6DLxN5D0fV7L(8EV357(R)OTV6d7DU3AZZ)V29kVu3Z9AB)QxCRZ8QGx179FLTF3l39sVvVBDUEVXf7EX3cJBsbFV3z7R(nYl4)2RtxWT(9Fmtf37dVtVlEZnEWhU51(x6E27UX9(MUV(n6DMxQ3BENUx6D6(r)MUN9sDVZR29U)wC9bH)kxle(UVYD6(gxT3R(ga436MVoa(E3(xtGNUAGDRlC(Ux6l34EFA3h(72(mFWwF1R07Q)hG6R3hEFmQH9aoy(8hcGbuhqyyixV3n26BVs3x9t7D9xBJh8WnFZB07ExBRhCZnUZhakVQkawQ7FB2s9TBD)pNPuQQY9VFdqV2yV7fJROVY0Uo3NUXDVBMUx4HDV8fTi1k7ZyOkV3z2(39oBC3Fr3hCLUN)Imed0R69w3FZRElWRK0GclmCy)lop4dB9h(gWimalCOada4dyaa4IJ3tKPsb3YwF8RU59(LyG26JF)nV1lX86F2Y1QDWdovH85P7q)X7FTFwBCzIaGUBHbqoIc7tsXsyhshkWS19qudWCcPicZkZbJC0Txd8qzVBC9U3)sg7xezsGGHEJApeknQEzNr(fFC3BFBCzjZ5OFcdMOQgc(OFcnONQTFHtJhJ7E)Z09ZEd0dmEcpdAkm4Ryy6923cmLf9epaqyKhGdaxX2V1BiId84aghay69UVmykDeoy6KOAzZ7DLEV)hq6KOYS5F4YWNis5Zd(P3F4Laqjm(X)kUU9tDA8lrFKUVi8c(AnFEiY7DUlVXD)eroq63QKded0g35R6EZBjT8B91Ft4R4A47MmEbQIUV(hGEaKw)emdi7MmGifirkoEMnnfN8erIgf8YiDufwkbelqg0Xujngl7ncavcEXlDObr41nIhr4LNHW9jxS75UfTiQU35wWL6E9pKGr0I1ai36to7wF8dOLvTXT)TeizAJx7YB92KPGBFT)D4NzOfVZ3U5NCxYRV(xc)S4qdEeKEOH8egqrCSeGWFMr(8n)2nFWn7(WxzZl)A0KOTUXxe(CzlNcKiC5VCRZ(5G1(PLobNLF1pa(834QsKuHh9flw0ZLwmXcOe09VFOSpWY2ufjAf4O3fuy(LJPieB)MVu3BETnU9xqAJu0IT)fVf5v67DDV8VaRa3gp8Ma9D(ppZlRQ)29BVapKmO(3(Y9(nVx3Z97akgqwD6lFtG6eWLRFBGWGlqQ1Bdvmdda4H9(Yl17F76awpWx3423fSy1gp4xG11c8wmyBC7lUX9VgwVaqzb8dGEguvnkkru7M0m(uCZasmcBgV7ltAgGU0D(D4MbskxuZa81nFzjndWZbnJEV3RG1(a2mUXxq3mWuDbIIaxRs(vqD29RUeMsGRza9iq8u4lHJduVKgb)X7FUNW7pE)ZJlr43yQJV(6aTNdhGi4(R)vHpuy2acUTU5x19bxLEX9TUX7S9f(x4MMgbKKx)FEMxc)o4hexVNELEt2TVlARGIZCGmR68cznMOERvTJ2QdEFvTDQc3zf2qbEDQGbTqwJr5HCL2oGT6kc7yzn2fpSvQ3XrcOJN1y3w7GYCfW6o0AfGVcQ5DBz8JngD8XdHkOEdHd9azqsQ1qaHFNgo6nAJigQSPGbQPqQhmwqWhTnrAZBOPCs3CUIXPLC8NSUTN3Kh8GzAa2AFwdOHRCAN1WF9wow0nE4dqT9G6fcpJPeWddLZASmeL0LfJujMSGalGaEKgU4MsgmWwQ73slfS1i3ch4MfYyGOMmGl2KUXHXLqBJQyiZau3zz)m7kRXmbKm4BYGkSf7M9zQQF2YMg5YrWd4dONd(RjTMxuJMHfol(JXo8JHLQljmSpYigaf53(Sxc9TQndHmKnazoXcGM7slEKfM6zNTuUzwQCPzln30Lx8WLMDXfkV4ZImAYfo)2V5n3(d(99U65uGLrbyz8D)mJ)mJzi9hyJ5INDZ7(zQWYmfNE6fGTftSQQMIGuC6PqaGvc3ChIqC0zNQ0HaGmwH8Yk(HNEIsG(38tdazujqCOzNA6dwCI5NoaOXeHXP6kol5(IWb5rZnU47RyV8jQ2UzRjjCqNYiFwY)YTBJtRUahOz7QoTJkwbKOrqXkORui4lxZTUVdUy5ac(c))yjScvHGeu1Z6nVdQCmlcageFMNbmgb70wjTreIQ8A76TTDRwSj0YFqZaITdSiuZ72WD(MnCwVufOTep1o45g)QlbnIXx(PyDaWAcrR0tOsgeDoOEidUoLXy42lOXML7nGTNdEEEPVBS84xI)L0YcF34kbyS8byadMcuGFPkqA4wpBqvb)dneNwuEYx82B8GRqzQ0LknXctnrXPkxA6)xLkFWfxOeVWgmCWHakBBslhotDKLoprZNTOPelVlwdiranB479p9pnA(8JMRuPdA(3YiVmcRV4QtUqQX6efFwB3YLY57xtdIfnm7qbXT7u8iPgXhS4S)J)9LkxU8K)dfLqpspI4rcT)oyxH0CMM1Rw4PnHShixfaqe(rc(Tj8nGInzBhBFh4JYyg8YOvmTux29a0Db6)m86WqXe5E6rb)oMIGQjXUoGP)PbRIsCJOPLYE5uUECDs0tKvPOx0FDrurz7HrIJ1xIK2b10)gxO)nUQQC8(V)nEQ7FJRV)nEIgaNbQPmxxK8mPCo4x1NCQ4cZ2rjlQfxbg0(5ZVQRVdx)K8mz18rXVQ)6NKclmLe(V4kqs7NXStMz9kcuhyohBGwecBHG4FzvBdH8C82jwaOpDgt8Jmv6Z0GISpw1rW1VYT453oDBpdOi0Cpg6mz02BqoSxgiZpN1qRNIJcIImA0rPEaYh0ku8ZsUMHKHI9b1SrIwHZX9gazywVzBaBbzkiPFvdqeCbLPaAhGl0zTzA3StR5DGB63lJfTMoStiX7pRTDJtK1WRtLvGflRrDNt6uNSp2rj)nRXlc0tnRrZgWqAjRa(C9Mc0Na4Qj0hZUaEd4EexRITFrWtWkwXrbDTeXsn8Eqf6Hb)q25QNFBVw1DbcbgbO9o72Rf7L2cQwlbLisHsGGKiaqikLsGcOGWgyaXujWiImasmXwjy4bbaCKrd9agaNAWGJIaOqdMkbcpidat1On7OoaqYWVA6hMjaXDObBioFeZJ6(jntv0xKc)PL(uuCqKZTHNtBFvZBZAylNJcWHI5fa7SwnBQMj8a2mPfHwShxfIOljRUWIostDW)mgTO5cMLLaVKoqwKhclGvgNF9NdithzkPSO)qhUnG3xCIzNsHiFKSSSgGEDdd3w2UabySX3dV0mYso1alinDJQg2W)ZSgLLCAxTClB3yzN67zPvB(8zSK8Ey8Ubvz4aD89B2yptw3XggYsOWRZljLaObbc4mMLw8Wabv7cO1WiJYwqHT(W024c5QhHTT8sAAudljyzsGeEsuq52yLd2U5AO1Re0nGFLSGvLPRTqCcidmOfAnB6vV7hMtgeAkYnoz5sUR50o3e1acdGAkggbvSKhDnYA20dRGwwS6iEyGy7Yl2yY6UlFImEo1RXVlOAyl9wlxZNVHtBAQkK1xH57HfiqZ3muELLTNGabHHmf4EtiQ57t43IEN0OdK)9Jke(G8yJVTg4Iyl(P7H0mWsDav0xUJN8z4IWHNNG(yg186CKK85gtnrHHBuGMir0clnHda6wXHbk1Ue0Q1z4mfESSstIKDOGzcPl5e19FwN1NcWjjt6y)mPcxNbrbzKKFHbLiwyGeje0ZoL4CWeqasOuPqIX0nGtNfig0BsZDLv9XqisuMbmEvQzZ6(UTGSglc7biybn(jwyYdTyXYZn9blHLKMxdBEcquXzN5qsWefZbnsq80Zb0tJMNMgaWqf81OkzpZqMGzLLy8EW)GmX6lQMW5eBXaS9TsiQ6Rq7ewjJt)l1vf1SknCgZ1CLO1dvWGG4wD9iVKF(ECcM)ZiElbV9lWErty(RRLREZv8GArNxp5Gc)cHFqwg3aXYoqSxDqfTFJcJNSkYmh6htDiNEp3b1Wigf2v2WVjzh3YQmxOGYWWBa8zCXpM7XZTg0TqOhHslJmmHOrwkajMGbrPLpluqxoH1XJSFWFA0buWT2FZ7b7n7KoXnVNv5h6kLsTgnv6pX1g8VgzqufOkLv7K1OSqGmGEcYfl70uP9RWu2DIqcpdFecgrccaaGl8iOcdMwKxUQtm10iS1eT7GWaSV9HGWcT5l8J(5aUPeHAkNGRC7qKIKFq2DcGJfvLbJaC0ESOCs3jkIzqpGkRGOK6ttsiBA9KuBAvQpEvT51tESchhwj46FV4VlFxRWHT9bay0Jl8UkTDSprIM0qiOjH7mBupvd1fmzyP1SRxx6oxwB955PRSQIiLaVCN2TDA4huuk9grTsfJCb11imLFOpqX040nEfoJdc0yhxTzCidjqGeTrJSjfufsCNzQSStQSVpLol0YOIgjGJGt6GuBYcil5iZEyBivH5XdlJW767S2FoRepOwMfqcoW6Zovg8QtGVn7uXQaSETyJLGlBXrfR(fZ6M6KnhA6KmacyvWJHFncR1YvXUnFNcpV3huh55b0XFPLB72YpJ5InWoVXKYko4HjN62T8CQYQKbeB(GvwjVusm312znB3alrfinJOHJ5tKBSAMrDaGqiFUWVlYHeri6hhwajGwoRXA2O04d11aZSaIPM3(fEo76DC4nIbUiOCx04VbwoolpqioOYM5Kc2vjQjTxWQ35vkqRwosKybxUhkvmtnIsCONe(L9jZpFwQfbgn65B73X7a24qUktNgTSx(ezOtptnXhMLvYLFQQgleenC5ZTBRDKeZOxlxi1dA9qXaaHrkGMsP0LZJMxAisOS)9NldufgUduSHfq)mqjj2auALr5nMmrsuQcKNecJfq0ublKX18mTuHjAHl7q7C88Q8mcrlQPR66R2feYB6M59IPtZ3kgjFUXv1quloVHBDRDeBRszJhIyLVe7jjjg3vMVzu4AD4sj12tu8QSeo5QfRoFTmtJPEwFyHJ8JtGohyTdq2ygu8dSyPsloFW7gbgQNJmUKgosIHm5d)CyyPRwCGpJv7zYCll9fqrqhXrUP01gwi6AttojImgbE)BQCSQEbG6D5ATC(nBftBInjhrbwp4DSoeLes5yZOqLr1YB0kfq23nja9foiWhipADjScnVJIXPyODqVkaDXqGtfISquS54jYWrUW4vjyWlB4WSC3iO153QiNSS0KmmmrmZkxRpzmZYsR344KvmUBAA9yCytmNIdgQ6NXfzCCS(Lvr(qO0BTcofeVscsgzMAs1DqRbiJ1IF0J0QD)euRmktBGofDcvxJ6frb3a1dJepNePxHBOGydjrtJXBJLSqZqALSn(Ilx02FXl6ykB2qS77vNdSiTpH5rI(1YkjoviHzanCkiYOyQ91vm7bpEVjLaJGWXtnFZoEoiV4kX61HwOjs5Pq4nTYO4q(XQFAchP13Pm20STukUgihmP85kIUdSCIjQxNmSXZOMc3uh7yZrAnaJmK(oyqbTA0Q2nwXPAAcLef2axRTArArHhCv7TH9gS(Lk18X(IbU(Y84oXEMY1dDQgzPvl1FE60BtsfLRQRxnvHaMUYKZhqoaKP4o2zI3SSYdamrsY0nuqru2TKSbhE)agngTp1dsjFaQphCs7atAguypiHIJyOWJgdcnjnDU46yrQCPmH)ZQQpOXC2jMDlPSAsdMpvsstKmnK8XJUQJtDIbCR6u3xi79jU)e69tAruiyH7YtIpjdlYonvkWoM1sOv(a71Su0XKPy4GQL1Wm8GInUp0ES2K0OdAy4XIy9wr5HI3kiolvXqxc1Y2bQHcfXg9qP(KgmAVswJk4WZaoml4lUycAGWYtSZs8HrXJtoosRhACedZi9SjT6egqzP5i7RpIxnTN3spo5WJy9KfANrmwXO6RgMpRDKkfG7)GunQROAxmYCWh5zLRctP(8uhTbbsPFe44p45lIX(3hUwLQ(cQ0W3ocOnvqEiVo0gxegF0lpQFmDb3yJW270qSrMLp2d2LqLh67iExuFf4gjHASunJsBFiS1gwpDOApo9Bmrt160fr01IceAQmMjyJPsSCgBRwziTRzUP8eOjAp64Z0wQpMRzl058SKhLdvhYNyqYYWoRHZDUQnxltH8Yt7pam7vzmJX0DoOlqT0dmZXmr9MYhQJxfaQNS5AolIJ8CzTVJdZkjBy6DzAnSJugWmb0Wbm4fidB8MtVwUorMBKFPaCU5GELmWOGlmkNydQPeyvzvNaPbCA0TMWS0f)b66jYvb0Q2qFsnj2ZzSjdFphZZXhFLmjXCs2ePExFO9qpDqCldsk4bOpQzc8bUMdIgln4GYl5kXe)Prdp(I4MggTo5yBO0oxfOnoePla3uBDOlqxSY)B4jzL4HoaFrdsDV(QWIzcxFGK60rrCFHdFskOIJe6SgNYGz6D2OSLpo(taZzaJCBt4r1TYn6Jw7CTMvr7wWUrZgRVgyfEtvwLzqMuj5SFwI)RtmnG(S(70jkfkhKgFmEfn5nBwzMNo2iJimKDKpIK2z0kJ0MbsQJAS2)YEslohIT5KihcDeVyPjjI7ZINozrkrtQKgjblYNcLYXWHmB2qL)6rgJvFZrjDnHbE1TH2kCdRv54LXX6fFyUvPXH9uriSFtQTtLrCdUXy7z5ohJr50eA6d29H66bBAKWLcViW(3hzeyEvEtbn846x3HFPjzhw1wjPWHXEc)5mgUm4wjaq5zPneLrdXbngzhb2AkPc)fesiGK4CZ5uZxtYMZcmku(tm0Z7wTADhnGtgQKNi7IZychtILaWwo0LJugH3mdoi)ccdq43XqAPTBLG4tvsjcSeIK0wKJQ56nxZLpb6Chw4mlyhkNqeoQdNiYCAnrhhQqJOWErgrF6MkmVqr6aiRWwPB750MBsTn7vyUPV7Smo0NFHX38GNVZ6SJB)CQRiA2bk7zR)azqASrjIVeOTmL87ex78(EtXQakRtmRp0cPjUk5TrlnsstnomQWeuFml7hxDYRLatyTGkNPvgoGgOdAMqgzmV5aYgJT9j43WzrtA3WhzqAfxnAH6NrbL6GuGfUCSUYqn66BVyW4Wb)aXzQ8RbVBero5i3tRpgqtIP)vwofbCVMOa1s)ztvn9h8rWZolfE9pCZjrbppjZ)ue(va58rWigtJQ3aLQkaZrEmxyoqF8WO0pQcgz8HWKeHWBnYPAr(PAWDC2iADCM6mjl4G7sXPxKKdJhFR(mGQWsgkNCrdmmrWiyd6IcTZnkRsmIImjj2a6xdcLNYV6INAPe1Kon2hOvxZtYDvlMftuKTRFfZ0vDZsUeYwDNeOX3ITxY9fLNOmPw4EKewShOCteDjblZ0p(u1UH7AzAHYpA(zJWxnd5GJedbjVHMa8cuIHIERqUV6bpNYHWa9ftao4lAgZLGGr51RWIHuNfAid69kX82PijMAg6d(ygiqihEyVLzuMRifrGk1md7ExIAYqx7fV(RaLja6NH805maohHyBvYXcgEfWDWTi0kRwhUZsSVEfo(4zUEJo7d6D1VI)0IxwcmJ3RNc3zZfKYmMDco7UrgUGIocIz9Eoxpx0gRJhFan1qvVJ0KxlHbQCmDtTHxCSBMQFdZyUTUk4cu9BsLTrMGojKrtt8ueBxu6EgPS34WlnjcuElCF8sxHs1j2K8ldmL75mo0LORhS4YHcPRiQOgzTnJYt0S4A3F3F3JflrHBHknbwwmS3Xm5qf7nC6iJS00y)pY(ivft6OTCsn3wtIjtvFQZqGevPK49wzYliPHftAmiu1nXcqkfgt6mZ3svsdKIEVCkGI9Okt3z(E9(Il7nsDxwti5pqdZs6K87Akgb)HhkyQwgpwr)0Efqd9Qpn)F)6cGe4gGbZvaP2y)P3G)9Hr)J1W)dIX)Fe5aG(ZjaP2raPYzaAIYcLmZdeBSYJeaAMyThC3syILC3Sgpruz4vgphp)BTzVVjt4SG(el8ZmsmAcNTO40Vq9KfvxnTF)yAJgwkLtBqZcs18gPeTu4g7hb7yt7bC73Z2oJmn0vPGH2TP0)kihZyuOvlPwJx2ryV2duf1r1knQKmi1W55f34BCQXguiJqn5IxWovzetwHAkpEacOqbLE)mQsshLe7vFqsiTThcF6VflOBu7DFXx3pcJ3F1X8FqluEy)NshaqSdiUAYqDwRJp4addv9GdFUORx31AwnlKjhfIodQpIJ6NORNPGVO5OHnz6VtFbgHpqy(N7yx31F9W7VOY4UAP1B5G)0sDQG)c5nt)p3XTfqYDwdO4KoTXVbDb6aPpEDQe(5kUnQwcNNOZGpigXxHrCNbJeHdW2J00Hh(YacRk(o6WJkFmXhfZIlPDahLTsJZnSlxrrThgksg5eVIJjnleNs0G4iJySXTV3Mx9cB)(Fu4d54IIwDICyAHCPLj6py3vOZNDbr1xjN1a9tFhtnbFFgXljQkRaZ2eyiyplCzNA2l78JHcgqOp6tqmaVVNAu1u8MlcEz8oCWc5k9v4A(Lf6tpy5OWqm9eKHky7nd7DHm8sDDCHvz)RzeUOZQqs9Y6q0fTSTK06RwCTG1OeLoDkIkRqXKrsj5dGn08yOJSqFGpHeCrxrzW)WNTyW49ho9EhY8kghDENgfeZ0bp8fym9ZPNqdxCwAQnW7Uqz8dcNakCoE2srwLTwWSCqTRy(VqjxlDECeEEQdWCuYWf(TCTGSmQvBHdWGwg6IJoQrmtaRxblj3vzYCojvhizoVfj5owQo6mb6XeDhOMkMWlNGN0l3h5E8t)211srZ57I6t5tnrNlojG4r(s1c1f3d2jQSQIcboGHbwrUyUd6sqNJw7UY9J31zn8zWXozCbnMoxZOjmHefigotswmNfcGESP6U3tWpac(KnzDo6cZ0sH7mf1qdFF)3qv9UKgzv8Ij4clnT6FvlbAAjjm3uf3wYGf9H5GA2Nz085JbE9R2YLcc7wRk2c4w(HQKa1JkrEhCshtwb)ivH1tNWQMXu0znYTRykN6HAoaPgNlmEEnaJTGjONsDkqicKFtF76LWc)YTlnvT0eJGRTXnXn2fmXHvPkjVj)iRq9kk01q0N1SocjIJiKourWFzeQY)JjFoK293qbPYJuueA2lrl9WQiVsbtb9FS9PvypAT5hFcklj(iGIDXWAP5GV(rDqUQRZmeInw5PafxinniBZMwN)4fBjrFH42U9WAl3dVTDNUTElrc63ttKYWTIxaEVc8uJjde9RIQnqpdIAK9XA4hEWOFz08cHTtkzBljtaCcIrCzB9iMBrgv2pG9CwNFYcTjdgv5jeT(d4BHkJGpP1v4b(UMAljswgKTQZpi3xN5P9vRlzBPnbTVKCE5QxzqboDU8cHMXpzcF5Wq8YItCtqQ5WQP6mnpTOKLXCarB8INsLI(jVIviZt(a)qDNaPD3adR1tpDkAg87mySeuw93C5PyhcjsVEf(wnr3yhsuQXVFVnyclSWfX(tRaq2Rzavb6vFetzclehgxoWyAijup4zxhp7nm4ioqZxGMbF2gT6aFwY1zm4GZdPTsnQ4)aSLf4TJYOsOabLHrSdED3rFk1GdDOp22Hkc8JaaxOdqSI7Yke7aHkz6)4egjoWTNow8dlbr)E(ec604rfy9OMWgUEhvG9BMvxy)BLaKHSc3HB745jIn2WSmXyJhn0HPFsqc64HfGe(Je2e1ayZ9e6MIWlvEPaPF7vocPFmVsFbRCwGnzBe1QFuGuNrhpfkSZW(egIDs1eNiTe)wI8sId0LD9gbdup9s4jGeGdt3W1PAB7wTgADkqTuD9Lx1z5tmc6JMAQjjbcQcHwveezH5mPLybVvlB4uh)IKl2QIubqa5vsgvQOuahCZzJoQQsKUWZfug1btDf)(ChBy6cOyv8v1VcNdHMThNSaf8BWa8o56hh1Ye7Q4qfxplPQSgi4DW4nxv0(HEFIiMbTKyeZXgaFwjanjxqNcQwoc5g(NKmrkLdns26KkRfPv1qo1brtEW3bT4ifL6DW7opPAl(yWmh)LDppyTqg(hK8D0hhvy5jv331JmIrVRCXnEW7PY6NaaoSTNxFSebDBJTLJL(L6dmlCXcZsv5L8OR667iVKI3gGJiy1s4zoa0WqYkFWIkBFTlV1BFj(fsOwQQIVMGZgOJYtZxY4NSe7cgWbj5QnYWJap)1WljnqYQKeUkc2gHZ0BmbG0i87njLwlu(viTmjF8ZcJrWxSXJKC3Hf74x)kOBOjKtq8r)lCBikytOvPqGgsEgVCjCARGVte))VKprMOikDANg7oFCINOjldtHu7POZkUWZj8d2SnsmJxgZjASoKfC4loBs0b9OCbAvIBhWHfwIAHv6RD(YB(ta6fvSN1rjZpNQGGPIV08XuM)nQ4NiZ0PYtM)j8KHKKNHFFHBw0gHHzPLixsI26h9rMHvFZKXz)0DnUOOdvCDYS96OjGl8MFv3hC1)SryCSQkIPhpEvvKHBK5SLlEMrbrPZrx(0jrvjoqaOoKm(4xT7NC2EVZ3U5NC3hFHKHCvyz22mJoSQ4geu2gIHd5GCAoYU8jvTxjvT6DTaJZ(X1RhCCwaOq(0RtR(4UpgolyrKYpvlg2jCb5yI(l6y3N6yhgiWcMmamxC779l368F9wVYf69UFPKjGE8taxY32VJ3bSBhAMyUJMjD2TYJJJ1tlh7i8Mlgv8WgqOjZtQRD1HSW0KM8VCCvnCVi)6VT3hEwj0OOlzos6X93JtgpmojzMN0Sog7hHbl(yjw(xJJWh65G1O6dBwUweDaBfEZ2vqEzsqMmfaAKhdcK9sKOg8vXILJ43gigyDDdIABEGjM8zNP4IhzHPmLxyTbZlfmbOL8xTaozta9jt(CiNA)mWFH)usMqNZDzQSqcGtbL1qR0U5xC(nV7NPYR)rudLo(pgV8pQsV8l1pqWAm0mp4X4cskgsblu6SQ4LmSuws66BEVFjVI1r5YkGnw392vsjnjG8uiLbbbM(irDCX4Ba1hLE3YKGZ)b(aGlKFP7LV4MF2x1VrjsFhsiYvkNWTqPC0OIugFQdrdwNiwJt7mERbsXQ524e7zfVovYy(ehdunMMwbF944VkPK)KoE(U1w)qzmrnxzTkW07J22ULSWQq1SAWNGhpcsdbf4krFZx379oppR9bMbFb1ntoYYqtcKK7l7zbPUn8wQop8WntYljzdngeDZtK6kCK80NCIILo6IfF2NuP7QXbH74qUcLWGziEsi59jbnkaAd(iAGgqzB5unC3u5FK4HDLZu28F)ED)nVXJOzkPrSk7Kf29zigVe4noJNuuymbRpuEMJrFebCCLhqCKJianctzNIrDqeiX7xQI(3OYl0WIU5C1J6KCkjhvnMXm8h)mFntSHTWWj2cZSpZVARBE9EV9T69(xFOPnEcePkQMLNQOYi5QCLwT9h9XS2(fcpeDYTBjqpVly7wVWZzxVJJhAb088PENxkTutfBiSEIJ6N)FDJh8UGr9TF7)dz7Vi4sfHKkxXkxHPa97QXciHlmSgzCbEgHIeZ52gdXHVxY8DvwschuN6THe8Me55HSVWZ99NjVmlxImBvamJoUeqwfXHdF7OcJEuhOJdBpUIMag2beJ3Z4DlBK0h(8WymWy4yj2ygQU(scHjHgQrlEoslRuzGjzxLkPZstYTYu8ZRhERYVl9RYRA7MXVgu09ilufqYhbQZzQ4gVCGU4CLoLw(9BBcwaMPbeE0W2N1UqCQXVCoESK)(3rWyzSoiueAF1qVMYZTBO8d2lIZulcr)fhKuXiyPzjrucpYLC(VK36pDNziDIaZqNQ7dA5CfP)kIwgdzAN5M6Bm64MYp8VSOLA07b)gAoo0oeUQM1NUMpI6dpYU4P1Url45SscVEK7BoOeDZihBYGM6Qv100KNAOdi37Jwg3hL8SpUyxTs8j0EszsvWLSxdmRxVBC9U3)sg7hYJOxGmtFL(Q1w6M436BVs3x9t7D9xR)Yumjl5gtIJXKLy8UvSyOPp5rm7BhtC3fCzsMwTc0AmbhQdK4ms0Dlr5Gw85FwYY9SeN6xsV2CT2r)L5xSxeNsI6hruH2s0rx1XPU8wv07tuJsosKSNj15oM(TnnO5nMA1NxxB(8H0H(s9rejbXuctYj645jYAbI5NKIilIutmQolXakjiqOAwVQKiDdEDvHtVPQQV2Z7RyspNJcQo4vL9XNkSMJyQkaPcGsF8ej1qdr3INkSXGuSWAKboCWBFHyduVOY3pbPk39qAkJPkPZXyMxeDnQkg2xWjfV(h(9WjfYSrvuhbE6pRCzK)uD6Xo)ltp(oD6H8zh9BCuN6ji6TpByRmoLOKKuTbaZS8cfggrMHE4sLafHD9GY8RlUbL0)PupQpINAPkxLAdPvrMfXugUpYZsifPgB6tFiHzlsUj3tKPUtrwpqY71A8JLHpx(voOu9KZOsdoRyUL9r3vOYDlISljF2yao44DN9I5pkYiouZMNG5OIxCJJYGsr7r4IiG7IMROTB1InHzGa6aZ3Ifg4PYxy)aElIcbpJv4DXj7HdpLRTscVmu6eClA6dGqDhk555adH(L8b0x7mp5HaYyEsoaMSU9ATCQwQjGh0XPb3(Z4dwzXkOuZwOO9swbNV5jr5UVKxHUFvZqDovto7PB2csA9K8OJzcnxbH2JVGypo6g3m3Zqfgkkc8w25bXEizl5z5uY6rzcEI9suuuktLiyMSAkYdwabhLuM51W)s6ZtFsNgY5US4blmhBGFbuJtEOjkvE(LMP8etn1Ilep8WWT8WLlU4sLMUy5JC4PMO00XxOdp3e)daWNEbqHMDHzkF0flo3uskgRavyzLCXEdECwJC5YXCrw4GOaav346pIJz4jJTA7uZ9fYASM3kzHNBa(47AdpaL1P9b7uV(cywNCCxjkql3Jkk08(sVAv0Eh7qoqtBVsHSWFpk63JH(9Uq)EC0V3n63pfm2d8B71QUlGGK1e1AL57gCRolOsTRVgtHgXKVpje2LTAd58cqrsBAIjafOGObaM7vg4SPaQl6TOBkgDHNg9vlq4TTlS9O8eEN)Q5f2ShI3h3ux87td6n4BfO0CpXqHiTx8rcg2hDLeTV4VgpLUgpsgm66pk8Qubpgh)rvUKl2MKAVDgB(gCLkLWM)G20JPzNYtCCzMXoIhhokseT)yHjpu58y4YvpLyxQao8c2Hf(XvbFK3sbcdu2aQIb4PuF7Ynq34tso4D4osubQMbuOgEDXRXDQexFxbM4WNsjNtdK9lW3qSW7mWBFBSJimpEwLLj0thKlwwk)xOQyNEhAAJLX3BuXCJoXrpKFZor)duynmw8cUSWQb7QOTzEQ2(fonoH1HhytF2BGEGXt4zqhEhGVIHbglCx9HON4bashPb1Pq3bwcJWzadfhdm8EC0CkZ9ICCD4ZGUZE)Mqf)GH2n5AhR8rNO4caDkm7dNsM(RVQbDqjvdoFxpi9yFWkrRUi7i3PFLJJpucE8iiFquarPchWwmT2jA5NsrG(K8G(bEOwQjzzuKQiHzuRKODKAdqI3vvk9wmzwa6C2qvekijpBkey4onhb(SrjBSNy(vSBhpq4HlfNjBrGrzgM4Xj(mWiaoD6HM6fktKOON600dcOhGLYqUVVSKFtrQ98lqT46W(WHMDQPpyXjMF6YLMD(PtSiCot)G31CnR0l4jgDp7h5smwAsPCj4JXkgd3mAsdJSbrougkznwKTcfo7q477xBsMWgV3qVUq3LJUMrLF5JgMN70pcR3RIlX0GFiqNHQLArHLmHx7T4LUyFfuXw8Z1WLM67IvFCezC0dn7shE6IXSL9bHVINP6)x5DT1tBCefgQFirR6dnPvu1K(akvkQ8cYajqIsvvzPbfQinPlqj9jZUEhBVKnE3URT5YdvGdjfOfmXqP0GBUyfqqUaiRkU5GIu6Falu(fKUxGNQe)c65SZAhscKMGuZlLx8WmN5CoZ3mZzM5mZSZZ1OkV43JTR(F3kBE7mc)RS)ZEWSZ)zli7v1U7BjA6sydEI)l(MnnR9YlB8z7cK32nHuGWyO2(V(Aftv(cEuCN845lRSVzRL41zFh2XbEErLBN9S6U51t8PFpOeuZjPZrKv4f3zpCIw5)uxArZD5PUSxPVnFlHaVSOQ81tq7223S7y9Z82EzcbGrk0dXehMTCWGqZ5V(OAUbNMfpqaSrb7KpnQoXhVCh8DPJtSRTNQhvaRQI0u0abK6mJV6QTPM9btJMRzoN4txNsyyUD4MCehZlYK2IRRsKLBquNHdFXO1zYDybAxTc878o(GMdSx3yJPfjca7XEtAN50nE(6BPXKrd7QCmzGEAT7GoXivYhUl1dW7eUzA6NvrKC)IupcqfkcNVXv0j15t1h(8A5d6C7d6WtAt9O7orYKG8(7YxazffTqBDrcrTwOq4pchAPiu8oCVs1XZF3QxNpAKqkANJU)omSIeD)D6z)wp4oTwR1eZBozAZRnH99M)VF4pBp2mgRoS1Wtzn2Iq8WcyntCnZFCv7R3N7QAxSFRErkTYCBZ5gaVI9xVpkhOFXImwEiJvVkL4wA4V6j(gZVeLtwdo4gZpvR1cC0o7VrZdLfavMth36gPCJCPm2ztqtc4fDlESsK0i7IMRSOXYJzpq)wPUVzQzQO8Ak3Rv)JBKDkJLhe0kZeZ7eEiOGqzGJibbWWyn5Fyn(c0pivWYYzIvr5Ne(1m9nmh8wgl3JXY31o7J2yGmBMCwZhmcfnS(9P242ZGLR1UfIvJmnv7S(PPSsnaWC7bM1C0ErMDIcmJEQbYlPjBPb7hoR5cjGYcig74RaXzLyKnV3eisLQhijudYUK5kxXC1PrEvtbET9p)BMdEZnU8Ay6vxiDkQJEkl1muuhQqEURFnq(XbYPjsVPsglVAfE9(dv51RxS6BBc3E4fagrthuwR7FBm)h7fWjQ)pk4NdhEmJ9yzT(L(HArmhvb5W4rZzENHayAZlpJz)x1E4znNdQ(gYvLPkRZE4cmyZFDUntpbGmMRnQlw)8hxDQCCaT5OYbQqDbGupeLzLGmP6pTsbK5MxziiRgRCtAdJTR3umcQbwxpeVOshF35ceqNe5JlInaS8B13REnPUl9BIYlI7PBPn3S6H3XEK0aCyhtXDKe)UbyddJOlqpYj9(y)kkYGqdFAXGKqSO9(XrpdOPevTebDiKmHfVa(jrdvoB8BiHi8YG1Os4Uuu5ismCoxV8sY9Lmjrc9PPityYGK7YN2yrRcoeGXggyIwiwDPUjyCS4hhL22Y56(hMx2DsdJghl84EE)rc6kr18teKUKQIwKK4(b64sbbQJdCrTlqrnpvgvsmt3TQ99NjyzbQO6ZY580v4jJuyAPh4ntAnsq4x02jlolCWwQoFeCcoKqPblSUFOc67DtdwE5COv)qLK7qRd)RqHRUS6hKh7quo)bxluMTb9VJ6NS7wpv1i(LWYQNTGLWd2fDMViQucnvhEBDYe4z7LVh2UvuUuXATtVWuS4rukDef)XOW1(J9Nhrsu99)mQnQpN2YQu0Yss8KA4uURo3bQp3HYDQht41r2schmsO9TE(z25Cc300jq1HOECKguxYDkwNxOxmJ5K2xU2ZDXCYqWp8fJr9GqLBDUicmadho6bNZrnS38ysdaVfQOQQQ5ehtacgqkid0ydldaWdz39aWekdTo1XznFvXfxSN0(lmIjt88WEBADsR0pZx0j3Dlc(7G6chV8kQS8tEWyp5c)d
        ]]
    end
    -- 更新记录
    local updateTbl = {
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

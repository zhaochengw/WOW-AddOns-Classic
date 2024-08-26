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
            local Ver = L["无"]
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
            if Ver == L["无"] then
                local alpha = 0.3
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
        end
        local function Start_OnClick(self)
            if not (tonumber(BiaoGe.Auction.money) and tonumber(BiaoGe.Auction.duration) and tonumber(BiaoGe.Auction.duration) > 0) then return end
            local text = "StartAuction," .. GetTime() .. "," .. self.itemID .. "," ..
                BiaoGe.Auction.money .. "," .. BiaoGe.Auction.duration .. ",," .. BiaoGe.Auction.mod
            C_ChatInfo.SendAddonMessage("BiaoGeAuction", text, "RAID")
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

        function BG.StartAuction(link, bt)
            if not link then return end
            if not BG.IsML then return end
            if BG.StartAucitonFrame then BG.StartAucitonFrame:Hide() end
            GameTooltip:Hide()
            local itemID = GetItemInfoInstant(link)
            local name, link, quality, level, _, itemType, itemSubType, _, itemEquipLoc, Texture, _, classID, subclassID, bindType = GetItemInfo(itemID)

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
                    f:SetPoint("BOTTOM", bt, "TOP", 0, 0)
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
                end)
                f:SetScript("OnMouseDown", function(self)
                    f:StartMoving()
                    ClearAllFocus(f)
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
                f.itemID = itemID
                f:SetScript("OnEnter", item_OnEnter)
                f:SetScript("OnLeave", GameTooltip_Hide)
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
                -- 图标
                local r, g, b = GetItemQualityColor(quality)
                local ftex = CreateFrame("Frame", nil, f, "BackdropTemplate")
                ftex:SetBackdrop({
                    edgeFile = "Interface/ChatFrame/ChatFrameBackground",
                    edgeSize = 1.5,
                })
                ftex:SetBackdropBorderColor(r, g, b, 1)
                ftex:SetPoint("TOPLEFT", 0, 0)
                ftex:SetSize(f:GetHeight() - 2, f:GetHeight() - 2)
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
                    t:SetPoint("TOP", ftex, 0, -1)
                    t:SetText(L["装绑"])
                    t:SetTextColor(0, 1, 0)
                end
                -- 装备名称
                local t = f:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                t:SetPoint("TOPLEFT", ftex, "TOPRIGHT", 2, -2)
                t:SetWidth(f:GetWidth() - f:GetHeight() - 10)
                t:SetText(link:gsub("%[", ""):gsub("%]", ""))
                t:SetJustifyH("LEFT")
                t:SetWordWrap(false)
                -- 装备类型
                local t = f:CreateFontString()
                t:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
                t:SetPoint("BOTTOMLEFT", ftex, "BOTTOMRIGHT", 2, 1)
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
                bt.itemID = itemID
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
                auction.title2 = L["已安装拍卖WA：%s"]
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
                elseif prefix == "BiaoGe" and distType == "RAID" then
                    if msg == "VersionCheck" then
                        C_ChatInfo.SendAddonMessage("BiaoGe", "MyVer-" .. BG.ver, "RAID")
                    elseif strfind(msg, "MyVer") then
                        local _, version = strsplit("-", msg)
                        BG.raidBiaoGeVersion[sendername] = version
                        UpdateAddonFrame(addon)
                        if sendDone[sendername] then
                            sendDone[sendername] = nil
                            BG.SendSystemMessage(format(BG.STC_g1(L["%s已成功导入拍卖WA。"]), SetClassCFF(sendername)))
                            UpdateOnEnter(BG.ButtonRaidAuction)
                            UpdateOnEnter(BG.StartAucitonFrame)
                        end
                    end
                elseif prefix == "BiaoGeAuction" and distType == "RAID" then
                    local arg1, version = strsplit(",", msg)
                    if arg1 == "MyVer" then
                        BG.raidAuctionVersion[sendername] = version
                        UpdateAddonFrame(auction)
                        if sendDone[sendername] then
                            sendDone[sendername] = nil
                            BG.SendSystemMessage(format(BG.STC_g1(L["%s已成功导入拍卖WA。"]), SetClassCFF(sendername)))
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
    BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even, isLogin, isReload)
        if not (isLogin or isReload) then return end
        hooksecurefunc(BGA.aura_env, "CreateAuction", function()
            for _, f in ipairs(BGA.Frames) do
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
                                if not f.autoFrame.isClicked then
                                    f.autoFrame:Show()
                                end
                                break
                            end
                        end
                        if f.itemFrame.guanzhu:IsVisible() then break end
                    end
                    if f.itemFrame.guanzhu:IsVisible() then break end
                end

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
                                    if not f.autoFrame.isClicked then
                                        f.autoFrame:Show()
                                    end
                                    break
                                end
                            end
                            if f.itemFrame.hope:IsVisible() then break end
                        end
                        if f.itemFrame.hope:IsVisible() then break end
                    end
                    if f.itemFrame.hope:IsVisible() then break end
                end

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
            end
        end)

        local oldFunction = BGA.aura_env.SendMyMoney_OnClick
        ---@diagnostic disable-next-line: duplicate-set-field
        function BGA.aura_env.SendMyMoney_OnClick(self)
            oldFunction(self)
            local f = self.owner
            if not f.start and f.ButtonSendMyMoney:IsEnabled() then
                local num = random(10)
                -- pt(num)
                if num <= 1 then
                    PlaySoundFile(BG["sound_HusbandComeOn" .. BiaoGe.options.Sound], "Master")
                end
            end
        end
    end)
    ------------------拍卖WA字符串------------------
    local wa
    -- WA字符串
    do
        wa =
        [[!WA:2!S33AZTXXvIMS3pKQ4N2B2T8hU19dtHTCkmrGWGKIY2ALuT8TymFOaczTz9QcEaXaYzf4myXmq20kkLS8AljBPifll)qXo2YpI16el71zJJEAx1(lqL)jKLaK8tPQ7FG7TFmp63ZmaqYoxhwsKaDF6t39Pp9Pp95C6U)Ut)9x77x97x90)9nDA5v3Y2S5IhS0CZUWuVR1Yo2l50Q5YMF3VYOL3QonxSHNLJT7aFwvl3g1nwVK5t79x9Ul3Y1Zzn0N)k3vnQ68u)KfRvZ107)935ZmSxguUd4yz7vzIPwO0uf)QLDCQdGXEPNYQH5t2qJaxLR50CndVYnk7zTMP)3(Un(RJQHd2OQHNzLwO)8hbTkhaewlFiRQERo(yGVooSv)KN0RP1kRy20DHFqt)p(Rh3B9gMJ3Y2Y7p2Y1SSr9NYyDxVMTmFY)OBRkMh102BPw1Qz90Fw5jgBPsLxQ0yflveL(7oHJDvluFVOTXAMUdCs3gM1RpBv3bcl8bAAckCXLoWuZn3jH1aSQEY7(3wb27mB(Uvbn7A1kbAen3)uZDGPp4CVClB)ghII(V0YEzpRJAoSH96n(FAG(CjC(Z7u183(DAKroTAnNQLBcOjpzJFGCGQBUIXYRxUwDhNMR()5iMMngd0pw2RiGg6S6lByBbPMo27QORNrtVPV7FZ42o2M)xMgUMl5100EfVv)EFv1wnrqvgsqB6Aci4vDpjegyN7U7y81mSSbL9U74U5(E3DW7M)Up0D3rLAw2wURYMCXLDQ708h9)a8dGa5A4bXT5Qn2H8or11bdbwlx2B1MMURc4LwF8Ao2En(RNUP1ZO9JBzufGcdTsLAUoMnC))dp5)0hDIVZ35V6Dbdvfnxbom()6bU7FZxb(AfJLpYkaoF7Qvw10ALv9E2)Ra(ZPQUI5QJx3XO6R20YgcuJhOIl4t1nhVPHv1xgogxhm0xF1kEg1bCapqX1Av3ZAGIlx3W19bU74d8Yqal30PU5aFgeCF88KJdj7iaGPAdqsZvh316zmHP1eo0dAJ76U)Wh4KvDk7cBERooG(59dEzW3XZgEYk4)(0)FRPPPv3zzJ6AgaQxzt7JQT3Op60u7yhFaaiHjLhuBaiYC0HY)izgaLvneRNJDemZy694MnxO1AzbZr0rab)PPjyeYwZZXU1AvmBcZe0NYdgEwEv4xYbqB2hS6oEW8GFPNrxhw)fqf30UkUYSQPz74PvEM8JpZyAERAAhIE)02BqtokT8t3eoXlklZ6UMHWaqPGwozhwxBp7vem(yhbbvtjQ3gMuypWVk9l7yTq0U5HC9WgjpEKa4U3VvvZS6u4Nh9tbeUifLWm39bTBc4QD9mBow96Wu8CJfR(Kto8cfkNLcgEmf83iAhbdh8RK5kGNCaA2XXQw1XEIvnSTnRd5lh3YWzgtFIvgeStugKV3S21CYxmORcl18MUUgRyIf9Mvig11gCqTo)UR2(foBNZ)YBCRpF7tC5n(YRS97(l2(zViULGN8mhOUbslwZ0di(OsDZSh7450oweBiyYBvZNgauWKLSiWYPDeZ11fW2aMKGNDKLcGaI3X1dNnKfWoohSnayg02lGc8mRw6qzy4hN7jYmwDVDS5jVr7tDRoN5CB9C3zZx5T7CPtN5WqIgmVTV1VQZfFrQ8ilE7Z)rDEZZ0(x(UBFPVSZPF1npZ)E7l(STp9lS9ZFUToXZdYQZB9CB)gxO95F1oF(P78sNR95EvmU9l4B(6BFP)G4c(BFrYcU1V79OQ4oVZn6CURTXDENnV8)w7tDZnU1FO9lE1oN4z78k3O95F92V7VQ9PoF7B88TV5VgxFq4V4LdHV9ZDJ2V0L688Vea(TU2lcGVZ1)L(WtwnWU1zpt7Z)jBCRpO9x(B2(eV9wF6Z15s)NG6RZ7CBmQH9agy(OVeadOoGWqrUEZRU1xCX2p)h05kVWg35l38vUANBD5TUZ124gVnO8YQayPU91Pl1xS1T)iQsjRk33(0a9AT9ShmUI(kv760FWg38MzBF2VS9foNUFTsNgfv5npX2)MxFJB(ZBFNl2(mNJIyGYQZRE7nV0NdYsqdkSWWH9p(mGpS1V)pagHbyHbfyaaFadaaxm8E8mvs4w269E(nV1Vad0wV3BT5N)Suz)txUwTPNEYHkuGSd9NU9L)PnXLjcaYUfgaXikSpjelHDivOaZw3brnaZjeIimRmdmIr3E0WdLDU6vAF7ZRTpEKjack6nQ94tPr1l9mYp(9AF9RJlR)CoYuOWer14JpYuib9yn9g644X423(eT)WxcLG2d6QrsHbFfdtNx7ZbtzrP4cacJ8aCa4k2(vFjECGhhW4aatN34KGP0r4GQtIQLnV1f78wVTFNevMn)9xaMcpLVa4No)(Nfaf34hBwmD7h(44mrFKSVWLbBTwOae5Do9f24MVpphizUs5aXaTXn(02x7Zfw(T(S)qywmn8D5pEbQI2V4BJsasRFqQbKD5pGieiEkoEMnjf3pfEIgb8IiDefwibelqg0XKjngl7ncazcEXlDOar41nIhr4LNHW9(NR9P)CsruTVXNdxQ7fFhFmIwSga5wV)P269UdPSQnU(V2hsQ24LVWwVM)uWTV8)b8Zu0Ix)l289VPF2x5tGFMFObpcso04NcfOiowFGWFMs(81(InVZ1A)Lp3Mx4fijrBD1pomDrlNcKiCHpzRt9rG1(jLobNLFP3gM(lDjbsQWJ(8flkDHfJVasbDF7dk7dSSnrrIwbokVGcZUCmbHy7x5zBFTlVX1)y)2ibTy7F(R6NL6Ex7l8ZXkWTXxEnG(o)3N4KY6VT)IZYcjfQ)1NSZV6nBF6FdqXa)vN(KxbOobC56xdim4S(161HkMHbaKyNp58D(TxbW6b(6gx)MGfR24o)CSUwGCXGTX1p3g3(Yy9caLfWpa6zqv1iOerTB)MXhGBgqIryZ4noPFZa0LUXVb3mqs5IAgGVU5jf0maPdAgDEZNdR9bSzC1pMSzGP6CefoUwP8RG6S9NEEmLaxZa6rG4PWmHJdezsIG)0Tp9d6(NU9zWLi8Bu1XNDfG2ZHdq(4(ZE5We5MnGGBRR9PTVZLixCFRR(6BF2)nMPPraji7)7t8S48GFGF9EYv6ZqV9DEBfuCMXZUQ5tNtBS6nw1iARo49v10SkCNvydf42Qcg0HYPnmlKR00eSvxEyhjN2ozHTs9wMcaD0CA7sFacZvaR7qRva(kOM3LU2dPn8OJgcvq9gchkbrq6xRHac)ojCKB0grmKztbnutXVEWybbF02ejnVHIYjCZ5sgNwY0BcOLPMy6PZcnJzonSPjZPbTKNozJhMaQThuVq4PmLaEyOConKXUillgPcmzHpSac4bTTWnLSyG1L3VfwkyRrSfoWnlKvfrnzaxCgYghgxCTnIIHmdqDZL9YUZCAZeqYG5KfvyD6n7tvv)0LZOLpVpEaFaLo4Vzi18Iy0mSW5WFm2HFmSeDjUH9bhudOi)2N68OVv1jeYq2aK9ehc0CxAXdUWKp2SLYpZsLlnBP5MQ8IhO0SlUq5fFmKrto7z2(vU22V9VRZLoTeSmmalJURhD0hDenH)aBmN7uBEZpugwMP4utTaSTKbRQAgEqko1KiaWkHNzaEio0StwA)aqgzOcIk(bMASsG(38tbazybqS)zNCQPlo28tfa0i8WywDfZLSEg4G8W5hLpFODKR20PXe(CqhtRqo))LFxAhxEbg3PzvZMrfBiKOrqXgsvPqWxUMvDptCXYde8f()rsyfkdbjOQN1DEtu5Oweami(Opkymc2P1tAJievfu21HwsVOd0YFqZaITdmpuZBzBnVJT56LQaTL4XgGLB8tpp0igFYhG1baRjePspHkz4RZbrIu46yAJGBVGgBoMCaBphKEbH5nsbCM4FjSSW8gvkaJuiadyWKGcCMYaX2QEUGQc(hsiooV8Kp(124oxKWuPlvASfMCSItwU0u)JLkp9IluIvydgo4qaHTnjLdNToYsNhX5XkMrGL35RbKiahBp3)5)5Hluy48LknDM)Ek5Lry9zwDIfsnwhR4JzyvUuEpVAkqmVHz7liUzRIhm1iE6IZ(p9JlvUC5j(jffqpspIyrcP)oOxHmZmo1Ro0JKbYEGCvaar4K48BtyoGInrttdptyszZeKz0kM6Yl7Ub6Ua9fiEDyOyI8pYWGFhtrq1eFxhW0)iGvr9D0DgDP9YjTCz6KOuevPOm6UUiQO09WiXXQlrs7Gk6FJY1)gvwvoA33)gn19Vrv3)gnrdGZa1uMPl6NMqohCwDjNkUW0Du)f1IRa9A)8Pw1YZKPF6NMOA(q4S6U(PFH5Msc)xCfiP9Zy2jZSUfbQdmNPbqlcUTq47FzzBdXpD82jwaOpD2m4KYi1NPbfzV0QJGRFPBXdgBjPz7zafHM7(qNjRYEdYH9Iaz(507B9uCu8uKsJoc1dq(GwIIF6I1m0FOyVqnBeOv4Cm5aidZ6oRnSfKDib9RAaIGfOmdH2b4cTwBgyyBmVjCt)Uz1j10HEcjE)znnSpson3wvqr7ronuuI4Vp2H9)BoTNbONAonhByqxLJdFwUtc6taC5a9XSfG3aUhX1Qy4veKcwXkgkOLopwQH3dkxpm4h)DU6610TrDlGqGbbAVtV9A(EPbNQ1cqjIuifiijcaeIsjfOakiSbgqmLcmIidGetSLcgEqaaN)OHAadGtoyWrrauObtPaHhKbGjB0MEuhaO)WVC6hMjaXDOaBioFeZJ8(jjtv0xec)XfMkkoiYBz7A20t282CAgI5OaCOyEbWoRLZMQycpGntyrif7XuHi6sYQlSOJ0uhSPrPfntWSSeitYazrCiSawzC(1FCGmDKPKYH(dz42aYV4yZoPer(izz50a9ABnRggwaby0X3dR0m)LCQbwqAk7QAgW)tTgLUyAxT8lByVSz9DV0QopvwDb5dJxtOkdJ3YZZXE3tu30agYsOWd1njLaObbc4SzkT4bacQ2jqRHbhMUGCB9HQTXeYv3dBBfe00igwsWYKaj8(rbLL9kt30zn06vC6gWUswWQYK1wiobKbk0cTMn5Q3DdZjfcZWZnor5swRz2m)y1acdGAkggbv0KhvnYAgKdRGwwS6iEaGy7YlAprDRLpswxZ61y3funSLERL35PSnBssvHS(smFpSabA(MLWRS09eeiimKDiMCcrnBFcNlkpHrhiB(dZf(GSyJTTg4IyD2P7H0mWsDav0xULR4z48WHNNG(yw586mKKc5hrorHIBKJMiq0cnnHbaYwXbak1Ue0Q1zzmfESSstGKDiHzcPl5y19EmZ1NeWjjs6y3mPcxNbrbzKKFUbLiwyGeje0Zoj)CWeqasOuPqIXu2WPZCedYnPbJOAme8eLzaJxLCCQ7z1aYASiShGGf04hBHj2)Iflp3utxcljTGc28eGOIZoZ(fGjcMdsKG4PNdONgjpnjaGHky2Okz3Z4pbtpNVX7b)dYeRUOkcNtSfdW23kHOQRcTtyLmk5VKxveZQuWzmNZkrRhkHbbXTA56Nj7894em)TiEloV9ZXErsy(7QLVUZkUqTOlOMCqGFUWpihLBGOzh8TxDqfTpTHgnzvuM8OFYOc5K75oOgguBODMl8Bc2XTOkZckOmm8gaFgx8NW6W5xd6wiusOJtswQq0ihbG(MGbrPfplKtxoU1XJSFWFE0bKWT2DZ7b7n7OMXnVNw5hYkLqTgfv6pYYa8p7SiQcuLYQTYPvMlqgqPGCXYoYi1(vyk7oqiHLHpcbdkabaaWfEquHbtlkiw1jQAAq6AI0Dqya27ErqOJ28foPFgGBkrOMWj4s3oKFrk0l7obWXIQYGragApwuUF3jkIzqjqCQGiK6tss8306rj20QqF8kBZRh9jg6WWkbx)7b)DX7AfoSTxaadFyU8Q0004ijAsJpbnjCN5I6PkOUGjdlTMr96c35YARpplDLwveHe4LB1SPPTxqrj0Be1kLmYfuxdsv(((afvJt14v4moiqJCy5MXXFibceVnAenPGOq87mtMLDsL99j0zHugv0ibCeCctKAt6azjhC2dyaPkuj3VmcVLN5AFBwjEqTmlGem(6Zozw8QtGVn7KXQaSATyJLGlAXrjR(fZ6MQKnhA6KSacyWb2ncR1YxXOjBNcpV3duhfyb00BPLBA1WlBMfTXoVjdHvCWdtM1nA4AwLwjdi28aRS6NPGyURPj84c7BjQaPz(A4K5bZpsTmrDaGqipMWVlYHeri6HclGaqlNtBnd0X4d11aZSaIPM34PFCJ6TmznIbUiOZUO2pewoglp4tCqLn7r5SRsutApGvVlivGwT8(rIfC5EOuXS18vIdLs4x2Ri)8Plxey0ONNHxl3XnWHCv2w2nmw(izjpEMkIpmD9Kl)uwnouq0Wvi)U0hijMrVw(qQh06H8bacLuafLsQlNhUGWqKqA)7Bldud1FhOOdlGUzGsqSbi1kJIBmzJKOufipjegDGOPH0rgxZnJUmmrkCzaLZXliZZi(Arnvvlp5UGqCtptb3y60STIblKFuzne5IZTTQRpqSTkPnEiILMj2tscmURiFZiX16WLsQT7O4vzj8HRMV68uYmnI8z9HfoYpob6CG1oazJzqXhFXsLwC(G8gegQNdoQGgosIHi5d)myyPlxCGhLv7Po5w6QlGKGoIHCtORnSqK1MIZKiYye49VjZXQQfaQ2LR1Y750iM2e9HCefy9G8ODiQFiLJnJcXjQwCJwQaYUUjbOVWbb2a5rPlHLO5DumofdTd6vbOlgcCQqKfII9mEImCKfmEvcg8Yfoml2nckD(TmYjnlT)jmmrmZsxRpzmZIowVXXjlzCptg97JdB8NP4GHQUzCrehhTFzLCEiK6TwoNcIxjbjJmBnH6oO0aKXAXpYrA5UFcQvgHPnqxKrHQRrKruWnqKyK45Ki9kCdf(2qI30yS2yjh0mK6jBJV4YfT9x8IozenBi299QYbw(TpU5r8(1spjoviHNaA4uqKrXK7RRy2dE8EtkbgbHHNAENwUMiV4kW61HwOjs5Pq4ZONvYL8JE30eoyJVwzSjzBjuCnqoys5ZLeDhy5eJvVU)WglJAkCtDSJnhSrpmY433bdkOvJw1WEfZQPjusKydCL2QfPffEWvU3g2tW6xYuZh7lg46lZJ7e7Eslx0TAKUsTu)zPtVnbvu(QwU1KfcyQktEpa5aqMI7ANjEZYkoaW4jjtzlHIiTBjydoS(bmAmAVYhKs(auxo4K2bM0mOqFrcfhXqIhn6fAsA6CX1XIu5s6b(pNS(GcZzNy2TKYQjmy(KjjnrY0qYhp0QMM19nGBvZ6ECNEFF3Fc9(jPikeSWD5jWNKHfzhzKkWoM1siv(a71Su0XePyyVQLv)m8GInUpuET2K0OdQF4XIy9wr5(I3k8DwQKHUeQLTjudfcInkrH(KgmAVsoTk4WZaomZ5lUycAGWY7BNL4dJI7NCC(TEOXr0YePNTFRoHbuwAUY(6I4vt59T09to8iwprH2zeJvmQ(QG5tFGuPaC3hKQrDfz7IrKd(8tRCv4rQVaXvBqGu67bo(dE)IOTV9IRvHQVGknm3bbTPHehYR9TXfUXh1YJ6gtxWm2WT9ofeBKz5J9IDju5b5bPmXE041nbUPrO2jvZk1ohc3gJGDjkBJnDBGqt0mtByqtCEzc2wQa7MjPFinY27pHrny0gvxqh0734ynzCT8TImPgR4o85pbLLiWiGlmsEOdCNey5uz3YMb0tYwt4jrf)bY6jYC4KlFtEBeX3ZPS7aBphV9y2yiK6G6MKnkP28(kVyp7fxpGMPpo51PsGFEvCzRORaheEcwkMyVXvyXxe3u)O1jgB9L25QanoHiDb4g3QdDZ3Iv(xG3wt8hSE2IgC806QcZFAV6cKuNmsz7kC45FmlXr7BoTJPrn9ox0jcpo(taZzaJCZmWRJAPBMfzdI1CQI0i2W2XE91aRILrMLh6LjvcUFJf4J2etdiVp7oEIoMG9sJpgp)L8MnTmZJhR3)ddlfXJiPDgT0OjPNK6ihRDVSN0IZ(yBojYHqxJj6koOSDzXtNSiPOjvsJeGfXtHs5yyFMnRVYFDpJXQR5OeUMqpV6wFBfU(1QCSY4O9un88dPWP0erbRNdXUhYYVjUySVQyharPCAc3EpT7DSCHnn)qccViW(2R)iW8Y8yaA4XYRUj7stIUqM1tsHdJVc27slCzWTsaGIpjYqugneh0yeDnpROKsSjEiHasIZpNznpfhOAAGrHREIHEERQvRBQaC)HkXhwB(zmHJjXsaOlh6bSklxoZGdKTGqDd(DmK6k7wjigmfuIalai4O5Xq1SCNZz5JGUBD5ox(diDcr4OoCIi1nsezSwcTza9J1d5n4j38cjH8UOcNYTNtAsf52LwINF)6Z6Vq)AfgdVSMpDWbL6FzqwQmyRkpYQQ6O0riH1bTdgvI9E6ClQYoSDZTMcVjviShT6lubHX2ep(sWobiwBkX1oRVZKScN06epTgAHZexLS2yLejPPg7hvycQpkvAIRoz1aIkSuqLlJEwgG6PlkMqgzmVzpYgJV8Fa)golAcdBpKbLL80MfQ7jbuYdYaA4Yt7kc5ORR9cbLjE9cevlZVeSglh5KI8pI6y4mjMUxA5KeW8kIItD13Tu1uFXfbV7RK41(WnEff87(NCpjHpfynSiy4Jjr5BouwfG5iFcl4zy(WHrzFufm4O9HjjCHNAKtXI8ZuV74Rbv64l5NeSGlElj3(qcUmD807YaIclzOCYfnqXebJan7wRPEUrzzIrKCsqInG8vGqXhzxvXdTqIAsNg7b0y15OmpvI5Wefrw0qYmDzVmKlHSd5rbAZUyZLSEgXh0LulCpsclCOBVAwjIUKGLz6gFIcFTzZ2aD(MzNncZAg)l(rme(N7NXcEHAr5YD2vDH3Z4qyG(zkahSfnBMLGGr4eWWIHuvhAKgY9bsL7K(hS0SKxCXuqGqo8YAl7WupXj8avYjl9(YIAYqxmgV(RaLja6NHCr5maohUytvW16fEfWbyweALvRd31m2TTCx)7upprN6oDU0NYEBVl6aiJ3hRe3rZ5WwctQbNDBNLjOMJGyw3h3Y1cz0G4Xhqtnu1Bk8WNLqh5gt3uz4bh7gf72WeMzB5CU3v9gWPBKjOtcz0uepeX2ffUFycBP2)oMdbkVfAJcHRqj7gxs8J5L0TGgh6s0Z7vCNbcHRikPgPT7K0BKS4A3F9)2HflrHzHkfbgwmS3Xm5qg7nC6iLS00yBt)9rklMYrB5KyUTIdwmr9jpc)tuL6hV2sp8bcAyXCme4QAhSaKsHXuo18Tuf0)PO3lMcizpQI0DMTxV34o9fPUlRiK67PHzbDs2DnfJG)Wl1lzlJhROFspEOGE1LU2OBDVrcCXrV5MJu7iJ07mJUWHgX6uJEXXg3JCUr35GJu7KJu5OdfrqIuM5EInw6r6NKjw5fVTaMybVTQXteLgxKXZXZMRb97fzcNf0LyHDMrIrt4Sfj3EfYNSi7PL9BgtBuWsjDAdAwqQM3iKOLcx0FpyhBkVGA)g22zePHUmfmuUnLUxb5ygJcTAjXA8IUc6vEHOipIDjrLGbjBZNIFJVXPgBqH0c1KlEb7eLH)Wgut6X7pGcfu69rPkjzeGSh1baIW2Ei8P)vOGSrTN9gFDFpm09dKGWh1(bTqXbUFkDaGVDaXvtwI7kD8f)xyy4hC5Xf984UMt1E1ZWr9o0JQuWxuCHUMmT2jF2HWxJl)RTmQB5TE4RouzChS06nmXFAPwvWFXpNP(xBz1aiVoNguisRM4Cqp7nqQIBRkHFUILD1s4t35m4Rpr8dpeZnNOViby7r0LHpzSCviPbZvAh9qhDOrLmgk0zAmKD(xvy)khnmpazyiSX1V1Mx6SB)wVByImSarlO4F)vH8cvg0FWEyqLB2ccYWsMRb6nEMzuCwaYY)UmvzLPTqpUpzMfUsrnJLnFi4Cze6J(eedWNyj7Qz4FSGGV)T9hS4)k6Y9Y6sd9X7TJmrF80sicvW2Bw6NFy47O6OClm(3rjzqLHCe6y0(OxvPBjP19Q4AbRei6eSjjiXcLXfjIJnE6qZwH(Ec9b2ZhHf6vbd(hMCqh)a4K4be5ilg68o0gI)Gx4IFZGjtNCcnC9uHN0cwp8jIFG7shHXxX9zh)bVwYbL3YWzgtKoeHFlFdiBGCThyamO(rV)YYAsZeWCnKUGhamrEmuANlz(xfjzowQm6A3PhOZaTdXeAXe4K(M4i2rBQ3LCVtZIPxhONs5UX7WrgTl4kpmUaEs2(mueEl0secz0efNuHaihtYER3OSznN)dJVZqwqQwhChuOgxy(PVXL0i8HDUat4rPuPIAjq9bbHBLS4hseSOpmhuxZSdxOqmWREjeMW8Fxk1mKd3IVCE4OEehw2EN0rDYBVNQf2Xtyvtzs0CA53zmLt(qndGeJZdnAbfaJTKgONsCBcWdKNJNrD4WneWDQOQfE4dyABmtmJv(io8(WvEHbsri9XebyquOkIdX1q0N3bQeQEzv9jDOIG)YGeL)H8)CiT7hsaP0RMseA2JVQNHvrbPcMc6)y7KkXUOkpd6jOS((PhkwfdRUIlq571bBPQotFignfFmJycTMEzVJKkYgVylbR7h3Ei7x7JS)TxY0TFsbsq)g6HvmC)LdbVF6F4rebI6vrvgWHbrVWEPTMblyKzgnVGBpsc0npzcGtqSklsx8yEnsKTPy67RB2jlK7dEyP30WQVOO5QmF8jSUcV4WvuBjrYsVS)t2b5U6UZSRADjBFBjO9LK7Dv1kdYXPZC(eiz8tMWxgmeVS4e3eeAJNAYUBStlkPzm7r0gV4PuPOFYRyjY8epW3x3jqA3nq)A90JNIMb7odgjbLv9lGDk2HqI0RxIp(s0l)GaLA862xvKWcZ9GE)isaK(6Qxwah1fX2e3cXHXhc036jH6bVd0yzVHoPFCNNMKbFw7gTGPLCDgdUa2qARuJioeaBzb(kBmSakqqzOe7Gx3D4hwo4qhlJnMMKaqiaWfAbeRyTSeXoqOsM(pMHrecC7PJe)WsquyxiHGofEubwpYjSHR3reG5zYPk8Z1taYqww7annDD5XgD4(LySXIgYWfpjibDnJcqc7vlAIAa0NbcYMcxMsFCzuV9ktUJblRsFbRCoe9H(GxR(HbsDgE0uOWof7tyOEjutCFPL4C9Lx67sxrptoWagtTeEFqcWrgRW1PAAyvTgADkqTuD9Lx1C5Jmi6JzuutccirjcTQWjYcZzskXc(6iABwhNrYfBvrOaiG8kbJkvKkGdU5SHhwwjsxyIckJ8G6TIxxUJnmDbuSkEY6xHZHqZ2JtwGe(nyGgNC9JJAz8DvCilRMLuw0RhKhmUNLf1zO8teXmOLeJyo6ajtpbOj5c6Kq1Y7tUH)jjtKs5qJGTojZArkvnKrDq0Kh8BzkoIfjYd(gSjuBX7dM54VS75ERfsX)GKVJ(4WClpj7DtEWb16CXZTXDEtzw)eaWbmCD7ILiiBB0TCS0VuFPuHlw4PLuCjp0QwEMIlj)Rk3GCwTeE23Hggsu5dwuz7lFHTETZZUqcXsvv8ueKWaDuEe2sg)KLyxWaoijwTrkEe4DCgEjPEswLGyWGZ2imMEJkQAgKDVjP0AHIFkIfj5JDwymc(IniBe7oSyh)6wbD9nHCCIp6EHB9rbBCTkjc0qYZyLlHp(e43wV))l5t(tu4LoTdTDvioXtKKL(PqQDx0CflxGEwt70ejMXnBMXSxhYc2)fNnb6YuuSaTkXTd4WclqTWkD1oFzn)ja98k2t7OK5NtwaUuXt45cuK)nQ4LiZ0jZtM)z8KHKCE3(Mc3mVncdpTq8CjjARFKxDd6DntgJ9t35O8IoKX1jY2RdNaUWR9PTVZL(wJW4yvvetpU)QQif3i1DCw8mJCIsNJS8PtIQuCGaqEiz8EpF73)uDE9VyZ3)M3)cjdXQWsTTzkDyLXnWPSned73e50CKD5tQAVcQA57Abg84JQwp44SaWqfsVoTQdM8y4SGfri)uTyyNWfKHj6VOJDxQJDyW9YzYaWCXTV1VyRZ8zB9CNTZB8jcMa6YobCjpdVwUJB0m0mXmxrqQSBLldhRRso2bznxmQ4HnGqtMNux7QczHhxx))LNPQH7f5x(fDENtjGgf9yL5FGT(X4JhggN(NvmHN(vSFe6T4J13Y)kCeEF)GfnS6WMLPfrgWwHVqAdjUmj445eaAKhdcK96lrn4R8flVVFBGyG21niQDMXhBIhBMIlEWfMmJ4cRmyEjGjaT()vjGt4aOpzlKh5u7hf(l8N44)WRAU5hFMnV5hkZd(r9mPoXpgp2pSup2l0NoWAm0Kn4XRHeumKYsOdlPKmPype1138w)cwLKJoPKawsXQiNostcipdLYaAatFeOAnFSkG6JcFlwsWDkaBWSfYV0(cNBZp8t72i(ORdVdXky7ZTqOOZW8ugpIlMbAhcwJrtlwl7rWQzzFKDVIBRkzZ8GpbOAYKrp4Rhg)vbL8h1Y1ZQ267pBguZvuRcmv9qnnAikejIMH(FCR2)Qx6EefpntpPj606EY7dD8MPWe3HgHBhPLN5jipiZhw6LxL)bzwXKs6HkIJlTapIilIqJkpxdl6v5unQtYn4Au1KjJ6jCXZbjwNS8bhC8W4nItVJt8YBDTR051(8oV1v6BAOLGPM8l96kZt9jFz40Qb4W3N1aCOWl4J87sa0ZBbub)PFCJ6TmDrcIlWECSCt5U3RyaH1LFu)m)7BCN3amQV9R9FksNZGhZb)J3tSYvOkq3kvNdjmHMZGJYXZWvKyUtPOioS9sQVlZ6c4a9tTDfGVGdpfK9fENu)OfeznlKPmcGz4rfaYQioCyUdZn6rCzZ1V9chAcyyhGpgaJ3vDrsFyJn)raJHJK4n4k7PvieMeU5DL45Gn0tLrhe9mpKoRpi2YdXpVU)Tk)ovVkVSTGe)AqrVFNWJ0U)h)zG9fk5LgSNEWsfoLw87kAcwaMQbeETv2L1oxSlXUCoESK9TbHZak0onIhAp5qVM07uyO8d6haXulcr9JAIqXiyPzjruclYfCrxuq)pFNziCIa1qNS3HxXCfP)P5vedzAN5M6xQ34MY3)FKEfAi0E)LXno02hEICvFe(Uh1hUN9G)QCJwa(OK(S021Cqj6fPn2diyQRwzttt(XfSh5EV3Y4EVKN9(f7QEIV9OtktQeUK9OHz96C1R0(2NxBFqEe1cKP6RKpPXc3e)wFXfB)8FqNR8cD3PhsWsUXCyIOo5qSUAQyOj04EG6PYDe(DxWC6IuQvGsJjysCzPMvGUBj6Cjf)zskzNhPeFCGe(CLQpq3DAGOFaefeji8OcTLOdTQPzDXTQO8tuJsmseSNj5NNi1BBQxplrYvFEDLNXlKo0NVlIsfiMs4bFHmgpISwa)zwrs0M4xtuQolWakji4yCQxvq0pbFkDWh5LQYFUP7Q4uoVPeQoiRYE47UYmdMrwqZeaL6ymrOHgIEHbLyJbHyH2idm4G1(cXg8wrLVBcCrM3iXugNncNJrnVi6jEKpuGGtkEX35BGtkezJQOoc8MPv6Yi)560JD8xME8160dXZo62yRn1tquBF2WwzCkrj4Gwgam1Yleyyqrg6Hj8YLekU9kZVQyjtq)Nq9OUigBfQCvQnKwfrwetAiGi(KJi54sM(Juc3SfbVG2jYu3Pis49plK1yhldtx8ZHM4N1FzAWPhZRBo6DmK2Ti8ar86KthyObxx1mp7EmVovfnSQw0bgU4O7BBDAyGxHAH4h(0dcbpRE4d4h91tnHpNsctguSbCVtQJ2lvxlYfyadH(L8a9BJSz2pyYplEMOUXAnmRwYbWCyAAZSXj2ilLVck50afopIk48ohfDqRfKf6rzmB(hLi66KeGJ08wXEB8kiTWlExo7aqywBFBqiPOeMFGZ0t1KCEdb0k0HFRGI3cF)(8uh10wmJHolyHNLb4xa14e7FSsLNFPzkp2KtU4cXdpmS2oq5IlUuPPkw(GhyYXknv8f6aZn2pba(ulak0Slmt5dTyX5MuqXOfsblRGhYxqY50YNpp1vyVjIcauhIP)WpMHNh1OPznRNoN2AURKdE(S9W3Y(UakRzZPBvV(cywN8mpbcqRHJkk0K5cFkfu(MA4FXr2CLHYb)9WOFpc637e97rr)ExOF)Wq)5710TrDlabjxguRvK)qWT6CGk1O(AufAWmS9jUynQrtiNxaksAtJ)GMakiAaG6DKaoBkG6IYf9YqOke7iVxYdFDnHThDjfG7P4e2S7JV)Uep0Ztb6n4xbK08crqGiLp0jCglh9eKS34F2(eUUjs8j65oj81wapgRhloe8KwKuBytzh1GNqLe2871MEmn7uEZolY0Wr84WrrFr73xyYdv4ngUC5tj2PmGdFdoOHFuzWh5bsGWaPnGQyaE4(3BecZRdIYRb(zDHAvbusf(8qRWfL(UtUc8aAEmPCo2iBcGFriHVryx)6yJ7N5W5KwMqVh4)qss4tazf74dOOnwg)IXeZB5cd9q8B6c5pqH1W4Bl4XbQgSRI262XA6n0XXhmy4fJZh(sOe0EqxnYqMa8vmmW4l7sFjkfxaqQinOof61VHBeolyO4jadVhgnNkZEqodomnOlI3xg4B5kmSB9FMHkFOXkUaqNImDHJ(s3RBt)yq5RB6(9vAVWduuVi2fFwTV)i3Tx0xqQ(bWwmPYekNBMIyDj5X9c8U(tX5oqsu3hEqdfeWFe7xH)DPrQdt95Wrx)aYCsVGJSWqb2UsXndoDGIg7fjEfJMXdeE4sYvvveyewIiECIVAacGtLAJPEDTejM5Hpo5GakbSee)32hDXpKBkpw3YLUg2h2)Sto10fhB(PkxA25NkXsCzmYcEtU16cbpXOQy3ixIYMosLlbtgRhlCVJjnsQ6f5qzjK1O7VZLWzhCFFFkpNf0H8m0XdKD5OxbqXVnGHh)xYKWQPk5ngm4hFOZs0s1jWs2WxLs8st0zb1dfNUcU0u)uj6HdkHdT)zx6atvmMDy3l8vkzQcQ(UKV6BDBe5(Zk8kN)0fIDit8)xVD00tBCeno(sKvprYLQEjk5srrYYgdfQuuvaUeqcfjxrGBe8URXBl4DLxWXKdrG5JyBfBhahQdyfiRcitGyJSQa)bOEO)bqv9Fq2zw8PiXVG(M9T2H0AiPrO4lE1mVVM3oVzN3BM3mxO(pDE97UVqafrwhEbUF9)30S(sU4r7BsGFNEiK6agKjTFYltuu4RhaWgfGYlSl2YZjc)n8dp)BHRXbc9Scsj7MzEer4nNOIBHrLgMVXbKKnk)3BclB4UAq385gkYVsAG)lRA5ZJrN1cLC266peC8MpYPn5Vd60Y6YBC(4GZ8zizZhCZUHE4d7LnHAXhj8TEuKMiaNGhXXKLcm(jgNDU(hEutdHL(lfFdZl9WbVNxVkcJBDrwKOnMDShCoWTmHiFHjDoSBVktowVJWl30ekcDljnkGK)(K4DdQShOgqyeGymZOUyFcPGOFuyGcT1fVGcxOlxH(2xpqN005jRQswiT(25F)bpvpvwTYjOj2GMApOCWFpsYfipPS(kZA6e4ErOtZGKw4vKCrzja8kZIuapBu0kgxR88iW93Z7Mk8X53hPenwSJZVXaDcuuVYlqCqsaqr2mm9LzmlC)c6vsIvb0cxKdAYf1QShP0EAftPhncnZoKmzDAVD7oOrwwRYgAfJbsfjzEJNJdneKagSeyGnB0v)D6Y7Ih9nGxS2c60EhW)e1xsIToU8X1QC1(7r)GTi7MeyVwXP0dxckJM8zv3onRXLzkOkajadsP5iL3KrR2RtRtF2qrIT2XZCiR(FOE9OIcVc4rffOd)O8WfaVnaCSsmLv0kw2Pdhp2LdhoyA8tXC9e7cecRhew6oVIHFR1zhuMwX3GE4x3tEdAKvpvf6ZJakEggUam0(JCKxhNMjA1zYsImVEITi5anECtrgfwJ1meiq1Flxv10GMHC4sAhUoRR0hVVLr(yO0YH8bEhyQaYCaJNTa8eLF9OBrwAAGNvNloGQwP1W3LNwUrDe8gqLtYp44d0BwPXgFCMpC0T66rssJzr(Mn0cLzAoKCaborMTN1cE)WsqA9eWNjFsbm(anZqYZp3nldbKVgNPXgJu12no(c8lyIA0fBRrOoUexq0E(kb)ZBiYlF1BJ9I)jSHCDwFVWp0mZSdxlfTDBCYYB1TX2pAAvWW2CbV95bAWEfhXg4qoJWc(u9kgsG3iBwN9BkGJzy43AVwSyXAbZwBpaAEC6Yv7D0A4AI9dcechB5U3jK73Cj4xtkEAZUZwS)Jnf8Vh8F(d]]
    end
    -- 更新记录
    local updateTbl = {
        L["v1.8：增加出价记录；UI缩小了一点；提高了最小加价幅度"],
        L["v1.7：增加自动出价功能"],
        L["v1.6：增加显示正在拍卖的装备类型"],
        L["v1.5：拍卖价格为100~3000的加价幅度现在为100一次"],
        L["v1.4：增加一个开始拍卖时的动画效果"],
        L["v1.3：修复有部分玩家不显示拍卖界面的问题；当你是出价最高者时的高亮效果更加显眼"],
        L["v1.2：现在物品分配者也可以开始拍卖装备了"],
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
                BG.UpdateScrollBarShowOrHide(scroll.ScrollBar)
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
                BG.SendSystemMessage(format(L["%s正在接收拍卖WA。"], SetClassCFF(player)))
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

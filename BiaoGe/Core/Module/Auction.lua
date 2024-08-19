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
        local line = 2
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self.title, 0, 1, 0)
        if self.IsAuciton then
            GameTooltip:AddLine(L["需全团安装拍卖WA，没安装的人将会看不到拍卖窗口"], 0.5, 0.5, 0.5, true)
            line = line + 1
        end
        GameTooltip:AddLine(" ")
        local raid = BG.PaiXuRaidRosterInfo()
        for i, v in ipairs(raid) do
            local Ver = L["无"]
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
            GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 0)
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
            GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 0)
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
                f.CloseButton:SetPoint("TOPRIGHT", f, -1, -1)
                f.CloseButton:SetSize(33, 33)
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
                auction.IsAuciton = true
                auction:SetScript("OnEnter", Addon_OnEnter)
                BG.GameTooltip_Hide(auction)
                auction.text = auction:CreateFontString()
                auction.text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
                auction.text:SetPoint("CENTER")
                auction.text:SetTextColor(0.7, 0.7, 0.7)
                UpdateAddonFrame(auction)

                auction:SetScript("OnMouseUp", function(self)
                    mainFrame:GetScript("OnMouseUp")(mainFrame)
                end)
                auction:SetScript("OnMouseDown", function(self)
                    mainFrame:GetScript("OnMouseDown")(mainFrame)
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
            BG.GameTooltip_Hide(addon)
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
            auction.IsAuciton = true
            auction:SetScript("OnEnter", Addon_OnEnter)
            BG.GameTooltip_Hide(auction)
            auction.text = auction:CreateFontString()
            auction.text:SetFont(BIAOGE_TEXT_FONT, 13, "OUTLINE")
            auction.text:SetPoint("LEFT")
            auction.text:SetTextColor(RGB(BG.g1))
            BG.ButtonRaidAuction = auction
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
                    end
                elseif prefix == "BiaoGeAuction" and distType == "RAID" then
                    local arg1, version = strsplit(",", msg)
                    if arg1 == "MyVer" then
                        BG.raidAuctionVersion[sendername] = version
                        UpdateAddonFrame(auction)
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
                                f.autoFrame:Show()
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
                            f.autoText:SetNormalFontObject(_G.BGA.FontDis15)
                        end
                    end
                end
            end
        end)
    end)
    ------------------拍卖WA字符串------------------
    local wa
    -- WA字符串
    do
        wa =
        [[!WA:2!T33AtUXXrckz9H7IjUpSN2lue3U3hqGnKdGJyGXmJgkjUCySZBosZdAmGI2RwfGng0yqBIbnw0ni5iz6GIAL4drkkjsQNupiLKfTEqktBlrXhsrS3FagkUFbEhGzMp5l8VGlZQ6hv3Dvv34bPSx7jiNbO7SYkRSYkRSYmRQU3PU)vU)I3FXJ9pwxVHzfTQQ1xy35MDM5N8IAlPxDr9g1xs9EZUKEf96p29b)uBlf1mQvrz1CQh0mFj96ROyMVwEtTvuZxC1QkROTuEZY1vnkRxP4QxCPggM6RGW(d(oJYkf1pWpDHsLmun)FDpxvP6sL1RVlDTQMfgFY5Znz2VBjDOu6hO6IhqRM6ERftCDr)29w7VXTg2DTIkMQfAq(Z)UnQMS4YQLhdBm79iM11wEz16gZ)dRB9XF5yMRwtDSgv1m)9nmuZRu5akRAywVH6E)9gnkOUF1QMl2OujTdE18Jp6I5YVyUrZMll55xCC9Qf1m10RA4a7UQRcWMDXDn5SZEeJAQvQmtrJ(U9FBbSzOwplWGun67iyvH15EVyrGGlvkhqe135KZURP29SVAJQwexFxfA))SgvxYuB)QdQuD1A)3viFoh99ZPxu9ZUNA)9C5s0pKfzwfR9dfZiROUSYsRMVufD96L)J7tvT2OaDVKzwfOLv(ihqVEX9uxP2r2J1h(oLgMq32c1in8(gROQXsh8hO36Z)W9mAR34knF7l28vEJ1)0R8hU5jx)SxATR)sTEPpQ1z)s45BEUVT5PFLMh96R)w)BTEXt18uVwRV8yTEweYwx9cnV8X34dEE4vum06n(M1)WRV21o1Ax)fOaV7z(po8r24kFfftToXj24kF0EgfW4634nPLHIcaQM)YJ06DpV1d)QRU(non9vaUgttrFA1wN(vx7gFzZV(lx7AND9JFSwN)ZAE(lnq6hoDMwh71w7gF0Ax7eav180xH85tbnekcivjub91xR3(3261(InU8x08wN7pCZ3QV9dLg(BZl(UnpX7VXr)KMN4sqlDTB8vnpX7TXZDl89B1590gxRp)dGAL24G2nG(MF4rx)xFJMV7lIGpmao9LawA9(3CTRD9bYK5xmuMmzqU0jEFe5F9Z386)Y1FPVaqe99RDTd36ZUaw(hYP6GNT21(KM38Wn)4x0IX)6FjbhxA9ZEJwN7yaZclXqqjw7BVCZp8uTo)X385UuZJ9cR)s)QMxg4sNYIKPe75o5MVZfbeS5RF5nV4B8hU5B38wNzTB9(y3pPn368hEZp9n24WppTEGpV21VmTEa(Mfd483eRZbH6Ks)RF8FvZZ8SqDU5ZFkOOR91VhL)Zs3uEe0nwFvQAKD(pT3)5p5W3Z98dgRKEvZA)ntvx7PJ9JBOuSUIPsSC5QfxSK)k6fZdGPU3lcJEZQUmkp)39a3(()o4RfuwAFldQeRwSqzvTLlB(S)EqUxhkT2s7rROz5Xgf(6yv0vk(A11QIGw7bkyaFQI6y1v0k(Q4q8QGoH6LlyQubun8azxPrftT(gdhE9a3EK(EveU811RO23vrOTqZEZUuffddce4JRaiPs5Xm0EAv8z1rvaaLU1SgMk1nFGJuupVbsOLlusRQMr5(gd(J5p8vHNt1nU3c0)EW)FpFSyXQOVKsLyknQRKxT6(JnI7h1Rh7zouFaiopknq(aeXrH749rEvjI6i9QUWmTQ5tOwF(gRKa0BMKae(tDvZg1RgZuVAJvkOwhFj0atdCWLkJFjfG2epyXT8GPHFLmEYKy9NHuC1QfPvMwPyv1nJLF60Jn9OXmlRw1b9wpBeBs29zPNQoQK19vQvmuDGbqjhkNTbNm22hHhmwyNaHhsXT168iNwGvvAv2rBq4DZPOvLqKbXJaa32o1kQMiPh8he9tcZajeL4l32URwhKZnmvRpALk4tmncfRwSZa4fNIoHhycIj7)6Y7ye4WVY(woYK95vCC0If1RoEzLQvvRGYLuL5wmR4eyhpp8EZzQwspDw7MkwQ5unmuwwLo)CcUymzS(7pwRFZLA(cNKo)WMhguhEHnV4RS5ZEgFuYSq1dQFwr1e0ZuOIAIN5qPI9mUsIWG5IQheaYE8sccyPITp1vtYrYbgNqhGKWda28VdL0zarcqICwCmmipeBeGj80LZTN4(ejDPZNm(Ovm3Y6h5RBE0B064NcMkA9Z(EGQ44pfYaX3T5nE3wN5eEEhx8080FcmTG1SVh718PUgEvR35528nF5MNMmTorDnTsSk45FJnp3xXVGF2jyl4g)MpGpf069)6wN6YWen4CxwtUEPwh(zBD2VU5PFdCUUJEA6mI0kgH)mVLd8nFUVU5lEUwp)lcWVXLpbaFRR92wWZT(Wg6jpU1SqF7NU5HFVn(INR15(T05JP1b2M8bZN8TamqLHWWNtE(lTX3CMMp)h16cVWA36BbRlADJ3AJBDz6uEIQjSu38AEl13SXn)epLk06Eh7igWqIT9TtrQ7x5tPN8BB(YNYQ(PFMlCS9jBsM8hm8dmkO5XpfBtGTRGcwRx7MRFUVeatgnZf7OK0NFC4dB87(kqObELK6Gcm8bkWWRejJhu4nmPs0Q1B8kuO34dEN1)YNLpC)8LkvAQPMaSrJLXaM)8ZRtlSlaSSekaHGrhEax050OJeU8zchxmszV(Gje8U9yujOwx6cnV5PJTJGyLde87LiuOv)dHseOVamW(AxJInlncSprIepBz88eUL5zQBoWHOcnuJvjpi2dAeJTFb(QJX3GMfYtmaGO1InoaXSnFTxmioO9EuCaW06npcO5Xfh8B)uR1VXzA9oVNv7Nu41)DVm(ej9xWAmY0639Sa4b6(9)krCKh(quOiFKTzg4fcPJmzWQR1XE51U(hgu2M9THlBtHETV(lGLZWfrBC1VY5vIAtB1QxgQuyzDKhG9qpONUXTA1nYfij9tunnS9twprchMPG84Zmyro3Mo)dUGrbt(qNQXfGqNNHo3PemsN4SnWi1ggSaF4PAESVKvjkSqE6kDTqnXIgaYn(WJUXhClwTPRDTFPfK8P636L341Tg3V5B9RXpZNFrwnSfCx4k4NL0ZsLey7zTEc)YqgDybn9Z8N35YFZ636Yn)2NB9x(fyzSBCPp355sTcbuv9YxH1vfwThq9Z5Ep85V45KPDLkxfS8UpxE5dwYWlZo2b1PjSL11ug33zJfH21WW128SpBZl)wRDTp3I8zyCB(sVM1RIihO5l)sudPx7BVmyL5)XHpIiEsZV5K(HKFDqDL1X(01U(1TMz(kNfSXbTR51b1vN0Q6VgAxmfa0FAx50T(Slq9r0Ax76We1RDRxIAQl6xlcyOV1U5BrnMckliobTv00jgEJBdWIm(ikzGShhY4npIfzaTTV(tPKbrHSlzaFD9JWHmGNJ(w68ph1mnKmU0NZsg0(bXCNas)bL7DwlEqxxKD6Xsuw9GPInALALvCx2f1hj1vlIRYJ63cJgfOGoqQyd6hYLRRcR8oiSdLk2d5h2cvAOYb0HtfBRj7JX7jyD748e4RqnV1KX(rXgC4HDGYUEDGJ8aEqAvRoaIFNfo219tygICXrmcPyvpuSqG3DjRSEBrs546Rab9tlQAoo6tSXNAQeOh0tfJ6o9uXqV3NKL4XhqOD76fH3JNnODd5tfJ4Mn2YsrkhpOyblWa3DvnkPKGcCsXTBULcPg(oCHswKaTqizqwoolXrXvaAJPyexsurDjZepuQytBZYW3KGu4KED8GNQ6NVu8yPtBHh4dKNd)noR1qm9Mofof9JH29tHLPjfOBV)(Jb2MV5rpn5Bf1doGN4MZbaYDXf298t84ZKl90lMp3m5MDY8lSRCZSW85x4Xj(W5KhFZZE5nFVFtRZDmbyzqaldV1hD4hDOyC)bjMtD01V(hlcltNDYjNhPL4uZh5OFk7KtqaGAZC8(ccXEMzIC7eazObYWR47AYrZbTV5MeazqoqSZzMyYPYo6CtAd0qbHrT4YQlQ90yN8GPho47rhDxSUETXTKGEMyzsz9V0Bn2HexGX0RxuTUBXgGOAek2aYkfb(8L0QyQslwAqXNZ)hkIvOieeHQEgJ5ujLZZKaqN4J(OqFe2OtgvIWbvzK20rV8NvhDej6vsg3sZk4)5V(A36m95oGEXCJo)eJMDI85M8NKl)ulmFo)JkOWHUbLXHGSkmsuH4EW9P)4zJZXJ1bRbISQEvtJ)L)LbZKzW05Ynv8)rpdSDX6txE85BBSoA2hxrlFU0MMLKG4GEZSNG46nYU72gXtLDM)5FCU85Zp(pnlh(r7Ji)iHnobEvLhFA9kfh4rIJIhexSdiI(OaX7W5nqXgVUQIPk(OeXTFPRQ9KIl72GjzXGKrNWaLNt)idc)oKIqQPGnDySWJaQ7TYLG4jf2kNqZWxJK8eEvk5fDwtKuuVTqx9gYlruBGsAFdhO9nSOQC4oV9nCB3(gwE7B4i1bonAsNVMO1Z4k5qFvhkPslS3gQL23Wkq32opqzntvFTtRNXRM3d9vDw70QWbgsI)lSce12ziMCpJrwyERzvvGP7cyRRvCzfzVS1ZP29opy4xI40hfxySgTlYiEN3Kw)cxlcMNoTZ6iGzSN9UqJjH0wdjq38azUzt2ZAP0CHkRhtpympGe7wbwOKKVjmwDfJeRQwLGqm3S(EdWgMXyMQifKyaoTRsatqdkZaKLQmFJvMgZ9H5uXvNAKijRLoEhqsxirDLQ7lvmy1ZKuMivmsssyTGRbT(BQypTEvaw9QyETLka(0mMaAtaU0XaZQbYg4IzwPGIzw4judR8Xb1sgelLOlwkql0(hRLybl43Owfnqjq)GzMExhyWwPcANyFXe8JfkjScHaHSiaicNsiq2CqKaTzMcbMWKbiPmBHGr7ea4S6nKdOnCIbd7fbOiDMcbI2jdGjQ32BVoaOv3Vy(hviGiDibBejFIWJ42jRqL7x4c)H4(usYdKwRQHADtrJBtftHVefiHsLfGLakwmvYaEqmJBryv75Rcj8LOvxuvhTtD4)zESI2xsGSi8s2eaHFQFaZmo3QpbOtN4ZJuK)WMMkW7Zo6mtiqLprxwQyqRUAmTAkAGcmV5fJFTzwt5ucMqAYQfJPG)3ZCuj5Z7kLEjLQlPwzBlww)aj82Bhy9iEkGV8hYFlicZOakdTs0gTQlpvD9viQ2dmnQFL(2tGXwBo4eiopOf9qj7eDDs)Ohegpyh345ZPTIA90Jwcg3Ggv5KHoEzpYiYskSmBGYc1CQDbA4YVq1XROT0(syOwPK)fmuI69UsP1pqv16SCvukrGlzXcyBKycEXXYBtIalbvjgW3BCQd)no6BjVJBMO5)9dgiv18JnHeTDq1s6FSIdqW8eG9Tl1WG)WJGWTTXROQuN8rjs)(4nzspKyUJh5ZamhoJl9YC8balvSlWIWfrFtMWNdpdv4ACYyCbIxedXgTI5JRU6eGSfpvlDYWmADAN6DUQnd0P4kuNwHc9mteCuzeyarupLdZyYQ4a8amd2v4Gj2lfIGmLPH(RC66vm1QHIglGTacSaXp68JVZfYMF2jNkxCQ3sLiVhbeLDMP3jhmXiCWIeIm9SGroSY0SaaDv4RjvY2M2AKwYuwUOf(hkelVOrjbcPR7M6LO2fNDuYeI12WS)sCDYmotISYJPPa)RAIvatlxfNjOyJuXYhiMsKNqCI4wIlCfAeCeBleK43fKUiOFoiaaGw4(jfo2oILHV(np1u)ERjwhEsbyKriqKKyEb9r)cy9wrc1mXJqOTfwfjt3yubiAqQs7EaF8E6uJwnh3GxsEat(IZmlkY)gH5Xo82ThBioCvl4haDQZa9pe6kjE9TrrGjf3EE7kFGmsQ9my1puM(bGs5N13ZOGHKsbesa(dWdi0qM7ySHqPcGcqoXDsYyOmrIzq4g3PzhIjKHD4hugcqjdFNKJiLL4WtOmfkx5ojBrkFXHXyXzOSMEj5iIn4YhYq3NyPiFPxvZrXhMmMTWQNZ1qlCo)XvjM)KeMnz3ZSlL6Wx984ELJg1mvx5VKT1cQLzawWyRoZeKkIWqMzIqTkXX0yndl2h7IlcLHpRQY(v9XWzRjFlclqn5UipzZo7SM3eadSi8y8RUyTu6ck193OOteB6zwylavnxCP6A1mteFHQuhuhNz530Uj1kk1mul6DLbi2mbBRSEjNeGPU6kkA2UqW2ob629lr8hm9qLI72aa7Bm9LlmUoD1fr)iNcWb08PITIcz)9qAAWiR50QoNYbFcLknu9VwtAri7RPy)VXY5BbIwmhsztS)al)1LK2oXybUgWrCuGvArGg8H(IjrP0wHzaFIZxgHxSmsk2BDU9EMkMnmgtHM)djAuTMcSCt2TULKK1izqNtY1Ssz14a2PMsM0BnzFrXvHLs7W9q3(emi3E0ciPucdR2Gz4ggyHTV)sPJAGEBhL3qF2jDuCI)PqNbXNys4QrPiOpXbMKGQPbss8bIr8KIWeRYL(KogpJiV)UYQZHMqmzrntE(HtgPhpJrinA)ur)WsSfriIvNxvRsY(cLQes8iIf(sQ3Y54doEU6wq4dXPskTn3yYViDxxgS6mLkmnK4r9ofMCYwKiEUf2LTnhuRdiUcek(ylKl3cZz)oWqw4xdZHWjAm4PF4xG5iQy1bM89YQNTKqs5Luqgw4JV3OoAEjr0ele3QvY(5bg3aI2K10lkCsYvjkpqtLsBQxlQeN3niejbyH35nEqwP(j7J8UXk53meQeT7jsOpa7O8NzdsJrMaZ0Dt6JqyRONIr3gB7OylvJT1oMchrurdJKVDhCkhrb((iwAybfXGfmqWAF2ePHacnvOnhcWBR1fM8VazJ4Xt(9rpAW91NDVyN0LXtQ0Be6eKTZcJBxGGbrNAIO0nrjUgJinUOH6ez2(EXHDanZJjuiKZUdh7)yEHBeHzEOR((OO8ZzfkwUTiO3wzqTLpjIVfF9AcxjnTCURNMolwCEJpcDH0YcCHf9fyKvW4zeo(6GTrioOK4NgXX4iKv37SU7zG1D7B99r05k(eTMtVHHkjiEEfV865hxJYCGpEYecoyrs2jKWUR99Q8nR0lJbXbu5gI4UGW9tvxmALkwdL9lV2grPm0(MDxRl6zSA7qNczAQYkvxwTi3Cliqau8gyqFrsXJReT6ifhZQThZp3L)KmmqnwdtGsWzBMJ2e22eAgKdrfUzxxhlNeLQoDrnJs8g5YnpJ4zGH0g2Kvf0UcNMclJD84Y8rIqVqh0d0TC)oIZ7Vv2x3XTBBon3mvsKwHin(KmwFpLvvRy5KZIQvmdSDtTcsmgJy2XIeyX19WjYTofzlXfQ8je9ISZNsdjrB0W4zRt3A4qVmthIE(ii9aqiQj6ap37ZzYFjS2qDSFEEo23ToIKB9TchLG(ViA9OkoLldhN8qUHVh6YxovSc0C9g7Rdmtti5xHt5T8drObT5UQyNf1JUkiwCxZgTO62nVyANJ4QUj)BKE8CC3tE3vuKxQR5kOfITDsegt2xBzHxNNeEUnfrMPZlYywplFrCJHMHzd6AR6(oqeZWDjFSDmcTw5oVnP04B7hOPb4pTEpRFjq)JC9tDYs0913ey9lsy2e)zh6XtGJffItctPwUGRkcTDPycHRNNRr8CwgKiZ670e9KHmB308Kjz6Tx3fh)djODimZD7nPjk0BtQlmY2weNF3NA5uoGNt(BFDK7(eDEVzZtyRoNTAg9dSvOR7DzNsM9CXGd1ZU4yVQQlzTUo)z7TNDIxuSYpI(Tw6jlxpXl7KXVJXUv)Td7PKdcGKsWbtGrfIj)Nga(XxA8md2kZW7EQJp26j0zzWQsePZJU8Tcg1Rfk8ZWtsKG7Lw)f1EhP0rfgBr2coTvXdSWqsqIwrViXmsLQ6vxDfqvFCrbWSNi1Y7KYmsBkNEsTljOpCcTRtohWNH0UYNctvGUAmKyS25JKAxC2dP5OmQISp8tkzNE1HfpQJS4Ga(cTTjFVhlA0tLjUJjm0XsbCvp216x7sDS80K4n2C4EWqsy4ysKqtDg7ite0C(qC)gFFD7XeNiUqpV7SondK0SYQcQ1E7yelE2C8DJQfdvZSIQq138oAgtgfS4eSz)N9k0Yqjxaq(7cpeL01wWLQ4DGpkbfC9MkdRbz6PNvTKPKDvOxGj5aCKHEoTIfROkbCRop(7yrwP(G9pHYdSlk5UEibZZMMMuq2Pne(DkmjL2AIq(SXPe2lkmyCh9ZS0mMvFP9ro0adS5u7t4idNoBCePNtWc28wdxgP3lfb2JMSadqeK(W8kCBUIn2vzl21Lc2jT3XDqirHIGWLfM74I8jCUtEv63VCstf(ixLEpY2fxzIC8AK21DY8)wNSv6dUEChVqkFBcZnZncITiyBnZ8qrSU9hefbZLjSgPJBrVAfXk0Vx1yrr7uFDF11vhdbocpu5HUu0HEkma)gLChxPQjX5DcUBwCShJbkrHo2pCP962xXORJ94Rh3PzARduKpG97ysIdHt)iYtqSO4MuHLtqw9kjZWsk)q(Oevnmikqs0wJGXUwtqytDwmIBg6AT9IeKlgWKdUWempNeVGjrvavI8j1WTA7t5KkWUvq)d3dgKeiL3CdaHRp97(Gm0V0GmiE7QyFcOi4STGZbZGzhMIgwAgYhDvdEeI2oQIOXkYhBKxKAebPREOzeSeeg0E3250YrwVo3HXMGPG6733D9ukktH3Q8fmsx0vB1IeVHTFWmXfQVO2tZpB8BBL7UAyXUUrIPfj(seMMPtI)KsvTvsuJSjm9pAeF10wNaxuiS2CcJcVGS7ZiVnWgSZapWxryW4byJd)fnr8frWyc4ItXi2aJoUGDDvEE7ew7(TeSNGKEGGGC8OakXGEou0dcuo9eExWJljJHZjCBgbZia7IiHdAAqYjqIUX5iIHodyGJAxphx)h9wTo3x4)K1L3gHKU6pbr3lq8Vy8KeoaUAcFjbPleZy8eAgAK1z3rr5keIwAYbg6sM60mi03cudean5lf1lrgHgjkzijyXH2e5UYqghc27Y1zBRTCwTo3Puc9StH)LxHWvRf9ZKLOCDwewgrZDsTWQAVoKr4jvtKBjF)FPzekBY3SpsYRMqgceYairdbWHSokiBxhasHqyIQswXiZ4FjBPrM6tCwahPk1kJyf6dgoe22D86RK9ultvRtvYGk9yddV)XKYCGtOvIe2aFwrBK8Y(B(JiV93nTDVEsQ31Xhwcdh(0fuSjzQ8qNWGn0bsyCDBmc604eeHyf0JIxqBhrG2pQaDqKbcn6aDzec6HrjOZIuqBhTG2kIbsYBHWLQ7k5zH7ZywPzHoClmPzoxxzHZwfMfAHl67)TkEVJPI4WHoel(hIez04mSrWMSx6OgrxpBF)n(rIiLWXpKHdT1aiU8Q2i633bw5NZSC)zWYI4zoViBpKUkNo3i6q6JCCxjZS(8ozJLECnioLkzrfNoPQQhi4cOdZux7cfZXiVW1WZuMGz0DjH7vyBoKDP3HhRmztUITlp3k4s7oW3(Nd4Se12hj86(oy(rBRbjyQrBtH8Zo620Z)woaKwnjyoWDPhlzo56S9rBL7nP3k6f72WW626ixRf2FrYboA0SJN9IFGECr8V2qPIM5Qo37d5PnWCRwtL(PfBuG(fR3m5)AdTAG(6uXqLinQtFd5Iha5kgnk485cAvlMJUV6MME4UrV6h8DUUzPsaPhENOYSPjvMOMNuTBVhz)zmSG(qUrrZhBp4fqOvLt6MD7b6V)yRDTBS(5o5MVZfDEOpra3juSoDDiHFko5p0qlil(A2zCxo1vGwJPACjPMDIG3mgfwEknY1Rq8zWzkkPSK6pchltqV7NqmGxYfvlgp411aEv51BWI1fUxGlHpVqFOUld27HjVopuH0BcV3uH4z(5WbMy8FWJMbzo7HBer7HHt1lL0UXvLwluJajBtibPDLJooxvC(tmnYOvmOtKp47TengJquC47nK0xhhe3hViy5JpVfFhvXSdCX5n9gPwRRoe)HWJx)EGJOaFbdUhhzp84XgkVMI(0QeBfC(w6Ay3TyRe8bOD9tUsgfrstBlenqsox1k8cjOWgx0cGkrdCOCzYH0rxWNbRaPmA(m4OEbkWpsAYxeC3ZZcPvBBps(oj8VUURZ(GxJ5yqvAa99VEcj5VI3r(ocAUnvs1fpzcgaeJjr3QoE8FDGOhgEJHTGEOoCLseIZ59TpXf1u4X)ybF5)KuJhkfUzcGDk8sPkbgoaq3lSDaqZHAlYWJR98EdnkkPWeLLt8GL8HzrdJtmyMmHaV8578LU)BvQzSbWn)JWe(PrQViZ3ngzYoty4ImCuCeMXM9kdo7DgD2EgEYX4Z)eDl(4yi6a4XS7dpepqKlblnLKSdf6iEx2JFWyFPRsYagzXzYDIQ1OndN8SzK3K5HCOQlY6zVh7O(hSWAW8GcpXdLFwwgOYSWh36Y58pvsTfLjx6gdy93j3rhvxDe1fnd)Ia9fLJ5n5Zfhqs3xgmZk4hnLV(Wq46IJmjWDXGLeDgD2UO0RGzxI2Wvp1wtYg9kwGoVWtS624GsMZKNMD6HWTtHD7yTw0(Jiaq5xx5baTdc)Ean)orUeJ6tuyJ4rGI)bmy4Jgt)GS21ot1AnWNfDJuSp)vitpwIjczX6NC6upihwHDz8iNtv0p4dlgCmKh0L)ji0y2aoFdqowBjbY5iurBcxvNqucqMEOW7wSZZWmre0jP9ky9iMX6OGLjfkJNswcwMmciJSwWDvx1Wii28MAkrgB(rdBcrgfKqoZXaK4)CglseG30YLLuc8sHhk7YTNxnWoIYVvg2QQhWBEih0mYbb1pdoCByHOhXhNKqGRPFwQnPV1sXPvWg4D8YJPYG411XaInoIR5S8a865Tez5bqTuC1LkRU0(6N8X4sQjoPkJaLwfcOYIkzYQXcVvHQQwH(IOR2Qaxfq493usbWYtbhUAGbhuuj6WmzckS4mrRGzhUwbkdckwbtrnqNbtKH9HPuqGGhMDCr3YmxklytLMNDYLnfLeM2Vdtwprjgb59rIzAtjHOVZBUoKmcOj6A8eW1sBXUX)eLruTzxdhJ2f5Ncz9sL85oiYOi6LbgnPAyEhEjMmCMVFwG9FDDBDhf6r(H56goW8u8YMalVV16mNATBDEr(DdaaVcR7G5kyPnVuEHo7ijHwSDQTC5kO7p4xY9uwZuLFjdETS0Fa)LH7lt0Le8kFeVSTzM8QGSeAdSA5r8xYWh1e6mhSx44jfgOqYHtdDUPUsPfN4igy55(8(JNia3V)vR0MoSI)L6hpvG(hogIgWqdim)tILq7)6unE9mTDb0J05A56HA4cqvc0SruS5xbf7Lf9)5srL1aLGQP2sBOMY7DPDVtz12YQUSMby41u61jQBmseF0QRIII9E1AEVQ7tkTWbSv07vdV8chnle97joa9bT03Rp7NBwrbRTGj3D3cpxTxWu09dG)bfCdQ2)PyqH9mhrs4x2A)(tfH)GoBK6NrFItrArJS7wzXbC9dE(MF4rB9gFZ6F41V7fWv(wh4zPjEmpqKwVa2XGyyNQKqIrCcAuTOGtvl2YqmhYgwUjgHTkRbY0(MlipNYcrVhZD0S058T15X7Ugo5F18LU18fNC)jWYYGXIBEJxzJJF1nEUt26nVcNbGg(ha6CHR64toFNhbY8nGHpjwdPsS9733CgEUXxD8pzutFbziZzx7yFp)oCGmRP5B)nTE)JY7oG25IIWkVT)X0SeNItRugN7MGH602UkZJkz5MvjPnspp)IhuE(e7JIythdNBNIb4xMiKLU2G66EwBDVwAuT)AWIL2Yj5ig86NCc3o(yJo(JpD2f298teNFHLMrumWyJwR)kfWX1b(tImPjHs8rXFr)ua5p6SMR)5hF9R)XIIBQBltyOtdjoPdkmoPCDGowJoRgM2FnaNIrSlISNje8spIh8A6RFJxXVXTUBycqKKVPTThRjcSNbAZWit5pCSxuseIjnwEbkik7Xq)5SIJGtZx(uR)XFrNgW9oo668xrPLydJfpdgKfXUfn9ggMs(m5YV3tyK50QUVTTSrJcjI)GpjunXJN0(Rpf9RCk5J1WWuR0Q7mrCc5YJQGXS7PUsnEbM2DO6V(gnF3x8oehVDgN6LP71i0GrUKUqjkZDGHcSTlYp9tYUXMEkHh4fwBSjjJo92vXS9Ps2j3XUbim3Rgj5OokhLBEV(BLv8WLG4BCwA7nsMtwEeWaKd)QBC5l061)YwVZf6zMQfHHMbNd2qu8rJ(8XTRPGdEx2uWbC2WVP3khONtdSf)GpHsLgQgefXz8NXZgT5cVlOGWAeSx)4)Q1U1Bc96B(6)wEgFYE)2hf9kbUM(7eT6bqIVeIO)HdiZeOiHCyt4H54Vv657ICZan9QK7Gbqy38aO4lE4u(Oz45PkIFPSHzWH5aszIeo(2bd07XCC00RJ0bzaOtdiyMxfE4qC1(4pfChc6dhkYR0n0lo4iUk(qU9Ft2wEFG3PSC75gc(UGi8X19Uz5Fi5ZYlATiHphK7fUeU13CVHvJl4MRP3CvtXDSn)BeQimtmFkX5mVQdjJaPoI)j4P9U(pSUd4BfVUOpi0MIHEfHNEHOgfVxmpTTsf5NY4CvSq1VffLl(roNTcBMK)57yfUdn801j6QuJVur7F7QXtGSDhl32x2ArwjWDW7znUEnT7VCZcdT9GB5m57MN7qTH7y3zBsxmg5IbpAxfADVmv43cArAxd15eGOXYrFZe1Lc03zLLVtkgF3scozKpFkJQCByIlBpgvwS1LUqZBE6y7afwKR(2tJM9g6JRta24BotZN)JADHxOZ2ZhCMGoKTaIN97H)ywL1XfCbUAs982HcU6eF7jeP2qi1zeEUqG5yPxK2njHVtsI2UijYBIdU3Syj7RZ2dhCUiGddvKLuTNYQQv4tvUVpsefFKWznxI3fiYx2v3UdqeBS9Qs3zoelUpDhKbliMI42vGnrqC92qWDAGG0ZYQM8yOnhhWeHeNrVsroPAcEM8t3FcffFxo2r5sAAvbCD4vwxo)XI3FCrjAJnuYZOkUoQGZTMEeWIxNue429oz7LVm(Ue6BZKkZ3fDu0YQm5JX8mUW9wAkyQaHdkoX7)NGdk45Jl3gcEs3jCAK)CD4Xw(Rdp(ED4b)rhDAEp22dqK7FxhQmmJO4S94Sb2Z0lmyOFEUfsuoalibi72rbYYonomcg7K6G8BKRvwTT)3kWZrActQe(P5VGn5w7N))bg2W5YUms(mVnsxzRDWwj)9LopN)91c)RIxrMYLmKlIuYnJK34ReeiMlsuVPAQ95GPVRpiFxngzv0kMvhtsxYb5zsVWmnUIeB8JxMri42xuWbo3lzcEvueYq9h4IOKN)yYoVfZ4dmc6x0eA3kjIVtqlGF8mEfLvQPwmNoiCOQw13kO8NRQbRGC61ijieVcoN((jBpwVVsqQr6vgk0J5popZ5e9l4LWSRwslVpiOOjLCdPwsWUbd4jKDKugjxpTwT5j3VAv(caj9dMtMIJFbQXX35O5Yp3ItNF0jMyH5dhEmH42v(SlSyUjZMF37AIrZnz4fAxZo6pfaFY5HcnZ8tNFplKD2j4umVkJWYY5kaeECQyPtN2ZzGRkHda2)4R9eSpJoEPwD1sAhmvSvmwofU7znPhtVgaNvT(unQuzEQOtAFNHYOZYjff9Oo3ZIzPhk3wx2A1xEGu4VhK87Hi)(Hi)EyYV3k53pmMaaM1nQvrdyiPItOwEHlHs1PGkvPYkEku)X93McKCs1QJsE2OiQKwGqIGfK0b45GOghnzZDjVLC0sll58ypytDUMVq6jPGce4obdj7E4n3hZve5KqRHEmI3ohX0mis6jLEapN7CnWhYDde35hjQjjNx6ohxZ0(4KHIdoNj2r171E8GQ9zWEej)UL0dHSBZJmsEof2vgh7fTuTFxri3XW2qKYfpK4HebSZH4Tx4hwe8UbOeugiKaksb4H7DhY4(oEXLE(YoJbA9eymkEXskjcMwrBUaUB5EgHsovjobW3TnfEdJCTRrDRF8NkLWc7eab)3wvmHfqu5puFsO680dH(qoE49XH4FmXZ(dQ(gtro77BGsyJ37Q3EM6MdCi6g4eprt(4xK8GypOrm2KTa(kfgmx1o33sEIbaKmMfP1roz9d05Na6LEsON)Pid3IVDs0JDEggt5DehVl5Wu416kmi)Egn78G5gX7GWa2ENC(9IEN)KPd4UANGWZsIov1mDZ1E3r3C3ytHqBiqkM1GdPJwBJ0Lj6PodESTjzxniiv(D2gJCYIqM10e8WVp8WPAjQt244IcQpNneXa2E2s8reQ3mjnSdx7syw5goq0(njx42uWyCpr44KUPUTHtMnMT9KGTNINh(qS9gKhq1PyDLcKK)9hJ09hUyfVov(oNzIjNk7OZnz(CZm3KrwzCyxf9rwvuigy2jAQ84XhHAQWhtT(fxXzutpRE7QDCgKGlhzWiPrIMVcXzBGUx1q8VaIC2CXSpIAkRGlYi7FSGobdLMKbljCU6ROtn59vOTQ0NlrMSTVpMmPzQWE25mlURjZgYQW7gPiPIq2vFhkf9xClw5UZm8sh)0bkzUJTglzYDpHADdnuGxDP91EMz1j3UzZTkuFSQqCaC)i1g6nwgL4DCsipNy2ZU9SK4TFUtZ4N447SuroYeV(hxwd650mYQwrxPiFNwIk1tyblQUZg6KsDx5DjoqWQAWOvrIcAIyETRd0t(hjhKPvvQyjkFMJucTDw7Pv)FwWqVr9LulOTsn96MVkgDiY4JTE7jN6FxvXaJ8HA1Lnl)F523)yWc8v)o7rqKiSx3qDj9QfnocckoK42zhdNxAQB)JHcC7S3EXBN727g(70(FY3zuwPO(b(jluQKHQ59vaqtjTL77IL0oOArY(Q7F7)2rwsxVcau19EX6Qld1jwdJHt4CXIQgkMiLOw(IifOHKKrF1(7HXM4iBYXXc1UU8lz9HBNnljvkE2RYa0pO2)aNIulVj0hLVwD1L0qo29v7(ByOoUf5mNEXSqnV3xf9tpzDbfOw)p2tRRVY9w)NrtQ(XWatFrt9L2pLT)FD))FIRvS2F72PXnzhuZlJT)bs)WzjN9Y33vl5gSP77pcgcxwVor9l2WlS44yMJx)Guw2o)Noy2p5EGFgSHwXRU6akzlzS6kp2YfHveHvOA5A)pS5FytZovnkFvkNNSYHh7EV379(SzhZamYcdm0qp8J8qxvRkLtaKDFxeA6wH4S89Buy40dmy6h9(3))3FY)))]]
    end
    -- 更新记录
    local updateTbl = {
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
end)

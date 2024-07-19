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
            local name, link, quality, level, _, _, _, _, _, Texture, _, typeID, _, bindType = GetItemInfo(link)

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
                    f:SetPoint("CENTER")
                end
                f:SetFrameStrata("HIGH")
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
                f.CloseButton:SetPoint("TOPRIGHT", f, "TOPRIGHT", 5, 5)
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
                t:SetPoint("BOTTOM", ftex, "BOTTOM", 0, 0)
                t:SetText(level)
                t:SetTextColor(r, g, b)
                -- 装备名称
                local t = f:CreateFontString()
                t:SetFont(BIAOGE_TEXT_FONT, 15, "OUTLINE")
                t:SetPoint("LEFT", ftex, "RIGHT", 2, bindType == 2 and 5 or 0)
                t:SetWidth(f:GetWidth() - f:GetHeight() - 10)
                t:SetText(link:gsub("%[", ""):gsub("%]", ""))
                t:SetJustifyH("LEFT")
                t:SetWordWrap(false)
                -- 装绑
                if bindType == 2 then
                    local t = ftex:CreateFontString()
                    t:SetFont(BIAOGE_TEXT_FONT, 12, "OUTLINE")
                    t:SetPoint("BOTTOMLEFT", ftex, "BOTTOMRIGHT", 2, 0)
                    t:SetText(L["装绑"])
                    t:SetTextColor(0, 1, 0)
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
                    PlaySound(BG.sound1, "Master")
                    ClearAllFocus(mainFrame)
                    local info = LibBG:UIDropDownMenu_CreateInfo()
                    info.text = L["正常模式"]
                    info.arg1 = "normal"
                    info.func = function(self, arg1, arg2)
                        BiaoGe.Auction.mod = arg1
                        LibBG:UIDropDownMenu_SetText(dropDown, tbl[BiaoGe.Auction.mod])
                        PlaySound(BG.sound1, "Master")
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
                        PlaySound(BG.sound1, "Master")
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
    ------------------拍卖WA字符串------------------
    local wa
    -- WA字符串
    do
        wa =
        [[!WA:2!T3tAZTXXvAhxBLTqTFiX7wERnz)akKYPawbIaqAiBRiPk8w0MhkGqwjXXf0aGbete4myNzaLOCukj5dDyRiBjlFiBhBlFgNyRSkjY60QQS)bu5A)fKLaK8lBQk)c2(19C09mDpZaakfVzdTmjW0V(1D)6x)63r)65UN4Ex8EREVvp23vxRLzdfvz952vXPNA2XpVsfn151APxr(U)cPwM110NRPPIMQrSMBQQIrZgslxuE)MLQPPVOKzPMLmvwuUu1LvLwuPsjZ66Yg11AuD5ZxPLHP2IaSFf9LNRwndzZD892Zp6Jp0DDxFLlkPwbH5DQPOAwE0XNT44f(IkAOQPTp153Nst590mU4gJ8T7U5xZTj2vZQsMYLBH)ZFe1V1qqOuz3kvnRpYWOVQlvbpk2CbdtjDZ77iv1kzO1sTA9ruuvm)2Ng9Dc62tzYF3)V8VlE84n0Qi1iUulDPsYQlfFBUFutp(tEWyiqCEuMLK1rqKyPCzYNigUOATuXTRlmtkB(yY6Z2AXKgM6PWab)OlB2sxnUPMARfllRdfQOUqg0OOsD4lPrOn59xDt3Fg0VsLivkO9ZIRUSAvsJPulUQMz8stMzKjhoUzDzvh0B9STz3LDFwMj0Lwu2WTi5ggYoWGqjNEo9aov8TUnEWyHDmemDf3rRZJCgbwnPvDhUfM2nJKIkUt6hpcaCl7qPQCYum43p6hFjzvHOekCl7svxEbfdtz9HB0aEIPrOy1IC6dVaxDsgy8Jj7)6s7Oy4GVgJLFB4Qv1uhTUKQQCdGXBefjTjLTOgjWWoAju5MtPwtltb7XcuRzKnmKwqEN6Y1u2FsUymv8bgiENF7h1(zF(oN60RCTlT(Ho3k38Dw)8V46h(mE6jtJAE0c8fLnLmLk3qo5tEW0XFsxwTskQvL3pci7fejXGLo(ELxofhwd0cbYkGKmaytGoykho(KiwUPHfPOj84Bdreoq9I7oHhEo3(5JNy4gMBA1JCL2h9ADo(jx7PUXQV0B15ShlXtaeqOS1V2VOZzobtzCXt7t9XDEJJ3(1p)6N9MDo2lV6X)LTpZHBFSND9N5KRDONbvuN38Pw)1EH2N6L7CPJ155oz7t(YKgXQIVXRU(z)m(v8xFc6kU2V9D53d682xPZj)0vUXBV65E62h9QRCTpR9j(Ooh6WDEPR0(uVA7Z)lAF0t1(kpt7R(bKggG)mNZb(2p1vA)CNTZZ8Ci4x7tpbc(ox(1TGNB7bd0N)4Tp1fw5AVF7B(Rw)qV1A)MNQZz)DOgUZBFDsBaJjpW8X3ebdQXay4tjFJpATp)mTFM3VZ78SRCJBU6l9rDU25w7gF6kx5Tqisulb166xMTwF(Ax)JzQvOT923ECebj(w3kbPUFLFp95Vz7x4KwTp5ZCHJEoz934qR)RE1vU6pV9not7JFs6Ha9ubbSoV81x9SxcbwG0loSuHXRS27(mRETxKa9AV7BU6LomF4(PvQvBIjglx2S0D3)01p3pvNuzxaO7OeacbJR97)muxeHrUOJukcDrcxeABhmrdTQHlgjewpWecE3ACY8ANp6DAF9tfF7(Xkhi4plH7HwZp4EIGvXFY72(YxMGnR1P0pja(q66W8eU15j1nZDqctt7RFO2F4ZHFq873io98c6Rey68kxcTEh)edeqKwXghi2S1F5NZpoiZEeCGGPZRDeK8axCWF8JBUvV2z68MVL14hx5v)9Va8KaMVYI(PZV)WiW9n97TiruKh8GeOWFKEy6RaH9JSzHMRZXEHvU675N3MU0W5TjqVYv(nT)0lXfrRDXpZPirJPnBnlJA02N4TWpaMHUFMPXnBnnYfOaMNisAONNSEsauyQkYJotHLGP2KDfqdErBjq2aWfGqL(t2rlams2oRlWirZcOcV3jBFSlrleT9vUeSN8jEBluJ1Zab5AV3rx7DVbT00vU8hybj)E95EH1EfR19RFU)d4Z8PxV6NV67Dvl4ENlaFM1Gb)wNuyYrswxE)PJpCJM1LCv8IygKUCvqppIPjgTktanx64d6fYf0Lrkx7h2Hsh)b8cB5gTK5aA(0X3CQyugibTTJ9rOVIA5nNk(3j(G5Z7aLD76ah(b8G0QvDae(onC0Q2JjgISIjoURy1oeSGH3vPvAdQcOECnhqW808YMJ2qYWy0jMijYYBuBc2klJmt0C5MYPO78WdW9D72fGNX4fY0qP0XRaOKUUeKYXijlyreWDHSEg3vssaoL4Xn3Ab9g(2ur6wv0AOPJ7YiU4e0DocU813OQg2OKgYvmt(aPJpPnjdkjjUYPyn9GPP(Pvseptgl8G(a(5O)MGwYl1SPtLtt(yOt)eyPgs(M2DMTXoQihQxn)C7A2XE0PkMzY5lvCQItpEP52zXPMB2sZ9OyJ1E(JV(l9PR)w)wKrlCWWGimKFZpC(hEO4C)bHH2N8ORE1pKhgMSW4Jpl0hsq2jkbBXfgFmCHKTEt4zaS7PgR4oqfpuUSER2ohF4IOXYmJJkEqpLUJPgB8jkm8mJBdWqSLlxDb55voamFnyM8SLvwQYERQR1CulgHNmE202)lZMJFq(qpIMEvzD36KdlEdvNCIQbg2stzmJmUcmssrKQh(HrudCtMkcTPlEYkSH1LuQwqdmKhSQN43My2tFFYRSYnotm3LbZxC4zhB4cJvQ44)GILMyUzlIlSQMNvzG7dOmKMEzwYgyZQ3R2Jwibhx54VfWSbAQMg)4F8GzZoyMIfNiX3Lz5Glwpq9rNTRX6WfEujLsfZyAwlae73laBiiwVvHD11iEIct9J((flvQ0O)WcCOhDpI8IeAhOXkamXKAnQM7HsaShyFpHqe5r(CeOtjOQnQUSKPm8OKjSl0vGykX1DlOTMapYseZc8WzEObr)oKQGBj)dDe))dHesA5C6ePeokhtXWZGe)eEnkUGEBiIRk7iKDb)dLf(VePcU2rDWgWynVVXAErnz(EFSMVVgR5dESMpstStcki5z4A9mUCuKI6roysLzh0wsIdRc974CF1vmL9moTEgVwE3KI6TXPvL9Tuf(xyviQJZquGDkJcO9XMwwcT1NpnhTcKHiTpTEorlYzrQrLmb5rje6CE7QSn29rjTVqn7n17oTYr7Ep9DGbtYahn4idXdKzMo1g2iLeVTcmQIqP2aoyhc0yjLFBvPMk2wCvLg(HyMP9ucImmLXuQqpizooJRAiIGcQo5Wk(pBRfNuxRvZzKbB9msMIwdi2fKe1Y1Lu3B64iBrxaQw64nKxsUHL5ldA930XpGMkcwnviaQP9HpfJXqJjeU0GaDOG4natdwSSKzb0tikC5HcQKYpwQrm9W3i0(hldwqMpB0SHcsiWai9nzTQY)Ouc0BmwCb)yHsmPqiqajcbeMsjeiBki0bTjMcbgtKrqsi2cbJmjGGZA2iyaTHtmyWSick8KPqGitYiWenBZoRJa0A6xm9JWeG5ocaByoFmZJ4XjntL7x4c)b5(uCW4YOOAiRBkADB64s85OqCOeEbKvyIztdybpInJBvOf75PbX0LO1werhDtB49zmAx7jOQZJkKoGQ8dLkANXzw(XqY0XEqin(p0X1fvEHHNAmbI8XYYshhnQvJR0usbjaJnqYELMzTLtn0gsJRwnUe8)m7rLIpTRwMksQvKBSL5RRTVKSZ2(StHPcEc4U3rqe2rbjm0kW1kQlmHU2Iyr7(2g1RqF7nWOBnhCI6CmOf83h9gD9Y8idct4FIB0sfvwuwpZW1qRBaLQCI4nl5jOoznjAInQNfQ6u7ejHR0CQJ2qPYEtAi3OgdHdEqgT9PI6wtziWzMam2keMKN3Mt5dCckHkHXzYCIaXPv9o08aggi(NGdE1IB312P3H3DZMzWi0Hzyye3F9SIHMDCNivXMh8)wspo0dKkibIxdxD5rXlZepdd9xZhvE5XqDmERU7foDsBAFAsCLC5tkaffrIa9uJ5FHrxrkIOqdhYY4QWQnwYYKO5LIAAnmvAct6ZbDqmiOgB4zhDhZvO00JprXeeFcYVEJ2qwsFA0g(0h8hAaq0mOymE3YKw8JPsB54q0)a(NGRAuoCkeBqjEsPBXzpDqvGwlp9Ve3MuS(bmv9iksO)PMCrKAwldsfR2kD8s(Iwb(jyhTTPecTwbJJ4BcJeVUPZfbdWbbiaivEaCLJV94z5VvitlnaBlr7uqcaBBByisH3QL8OFgY2JiHAlxIh4(SwvjB)SblI1a3K2ZaEO9e7cSgoUHfd)aQdBOlOy632OESdTDRXhIdv1c(CGdoYnWqGBv4n3gfgM0CN5TB8CzdO1Zcn)qzhabuAVK(nSEWqb2dWDb0Fq0aCFi7TnYqO9cupaOe3o7gdLnsedm142n5qChjVd9Gqqq9K83oPibssCOjeIcHQC7KSeiDXHWyrziKMnYUJiYGlDi7kx79x5YNin(lBuTC4ImvmLxKVUfwkvd74pQmU8uO9s21u7ush9vMh7J02R6L4JufbevyQj3bhmrTZrxPTdQvMcrtgz5Pgd3qyk0uJ1p6f4A4tsu)Uk6XWxDXyTmLL09QEnzhitMTFSau2C(k6knntMyovIxktqzdgH6i3qQPHCvwDtbSzIuQWQqoNPaD5fLuSTJ0EdssYiKmX9NzOAjChaOn2n9C8cC98MlI(oovGdOLshFrj8HMgp0qmvZOOoJ0(FmPgTyMICRcodfI)Vb1JDvLnXbx3KlLYRwrUDPTI3LuG)bSjXMsMTmgrs3nkF2rwpfNA5GCW0y)biKH3mGAjm0ddMLByZcWTfchh569XbB0t6LXbNqOiYNuc6mjD5hRI4gDGjfIXoxkSnCgEWmfMOznJfihIqgKfxEgqYlphcfu3orwJqgWE7bdGSkjmUu)ccuvAKkwO9kHDEaXclK4SnoEmGNNYee9bqiuTT4gsV5jjbH)MZmqgPHeVGWPY4KVkzIIZTt7njiIZX(Zav9rMRyX5MXUSbYd)Vau53jmmNP3aQLhHa8I(rTmwXYcSTY5l)m40Gj2dWiYDlDyRyc3iV(yaNDx0YeeNm2YhroG2PJSnErUlyxtxlJPwZO0XypiW4dFgQmwVhBDUSOFeBAnWFiWvUy)3br0Dyg1Bmqd0B68Y1mMWdhc5eCOf4DlB)zzjbSRov0aZFdfiMF2tSPDyb47kRadGGiIBezl5D02dJNKZCwIeP(lbL2)zQ3M62lKsEClS(yxWXfuON395bEYUdy5EjRLIxxiWiBeQkU0Z5LeApbeDdkpPIttvSmppf4gthQh6kvmkcJCuV0Yyl)(iIc1wwsLytEM1eA9bPEU2Gq2ijbpf9c14JGC3Qv)JzfLFpWgoU6HJVpSyeBzPyVYgG1qm(nFkJ5a(bV6nebRt9WwnJwldzS))zzTOc9XK06e5aFIujfKhTP6LUWUA(xuEBAo3LfiMne2CbbQJiMy4gnSwc7LpTNcUrOZq7QzFm)yrbqtnyLTQlPUGCvptpcC8lBan84by2yksMof7R9Tg3lDM)2muqnsltupb2VzgRjXXumWjwm3titpZTeLMotvfJA8w)Y9ScWBR)ahyJRkyCfEFkSOUZ4QVTfHzHEygOFP(9eL37Omw)rT7Akn3tBGi5drA9jET(URll3WYhvvLBy6lbSScUfeBl61Iyyblr4eXjNQSPecf(eIes6DvjUsTlgyDvKzJOQdBKrOn6XrnW0pmQbO1dZSivacG0oNksz9LKftsl5Hz1tB4EcmcpATcM)IO(JYvvmPP44hYnSJOP8fshVm58AcZ1(2PjK4c7uFRtRDOU6(okBNvVhmGpEcxLhT61DB887MR9H(5CdeyYXENJF3LvK3zFXLrleT8cGzmvSUsxVnIZZJ7GsKA78cXH1Zkvfs7RSzY7ti(THqFazqA8TVnsRYDhCCTHsha1NYXFd(nSziFZublPQxmx3ZCJp7zcGyJDVCOPURJUfr6e75xhgWkjqlMQjfABpx159ywKiL771ZlgvxSBpTyuhlwB7W44NioJbSy4j0Q0AdXySGt4AClcbP0Ql61jNwUNdr1X)nwx70pr36k2uf6MYjTriFGUXCDal9wZ0zmoNEUTPYSIRRzzBN3ZTjtg1efn9JGhLd8EDzdX334vTJqN3UjBP2e99KbKvVPcahuzURqm5n7Etfqa9XXvyrTQy9CKu1uxErKeOeIcZvFts5D1gfPWN23TCaXjWxKo7YzTnWjSuHyXhF3R4SAkI6vWKAx0rJfKkZE96rNU8(ykeCKk4v5Uu0h9gwFPXEUU8(2Yj0(9)rzniLd7LC1GDdch1J5UQp4GkWIPqdOUdNAeBtVw1ZHtxylruJbuSkInMxf7Orr30E9FZ1x51IdZcz(VFyvQrwCGWfo29g(9eNIaNa5ii0nO)whXmbEwgTK1fg)XTH)2cb1aKH0JRah45NW50f42aEpBb9ev2xi8CnIY1UK(3qPbc0qjbhngQCYsqg4W0bjPOIzp6W5qTpHzqH2XrBjpxoPqiBrMoW5CUi6aWi6UyDESYclH2nAo95voa)JZsxVwWvxeuVeYqYyrjAYryvzVyXOKQYIjBIp6NE59GIM0kdyjqyD6Eggva(G)Hl13zB0aUiwayaD4TXH3QMmX8ayuwY4un8(WGIm0zLftPJzDWdtMjVaiWihsfVKdYCfF5hOIAjz9LQBxgmel8TuTgyeENKuzre5aM6yZL9PL09(UcPUC)U7RRzO40L3(lbK8gbkQkgVekNC4s(3Bj1qXCzN8jVe7)aTiBPlJ)m43dyGJ(yzf1QfjEXFsYbWLKS4Eo7TwsyGwIxcGrFKjWz0tahpIEEEb7dO8cMD4Eyk4CvqZs)SACRTLOoHA4Mg)zxs(adeFLlFTvp7ZV(BEENh6zo3k9vCV6mW7AKa)hImYG2w02uIIYlIgKMYjcWCJK(tX(YlmHcopTtmfOMrnPkYFhWvly07(jadq2YRwnH)8(gU2R2yWI1LNLVlulwOpyQVeAqM72CO(Bs2BAmiHjEiFkh9T8CHNl(uSYvrMnqTGy7jDR6qKwH4cqShkt6)KNWiuZvMMhyilIHDpXFWtPybjBdlpXtjyxuaRTJXBRyp05n5jpVOxpdowIvblR7GaV6IWBE335KWJoCBWQOyDfVJVI1XhrfNVLPjmDlwHopaA3(475nrDPjTzIYLIZD2aNBOGWPq4Z6tFqJK0njePKbisNUNb3iHN5KRCJ3qKKyea7K(gN0v6CztVINjwJzlFMMjIT3ughNHzHtMyd48rpx5FcCbq6)sBIx12HYc1BG(Ft(106AqIxn9FAQhW)1u4aGpigyiE1pIPDpbySiVY4GLqFiXHVJFJxarpzWSERjXzmi6knXJh2DyBWbNirA(xZaPeUQotDKfcO2PSzSUEJxXtS8fSIdPpjRRGrnR86bgmVyCWE(29Ih2s9l7hJjCVCAqvUKm1hpX4wgK8f59v)qeGZZmRAHpf2RIgPrypDk0UnikkK(uuo7Ic7vm8RU3Jd4nK8kJIoZ4)Rlzvwlv8lPAtDHKk2loGno5vBX(fwYeA6yjogjtmS6YaR4gVKn2lyJubwzSdc5wzCjbxz8H3bvzVhyNaypjzoehbQSNJFX3RpqFiI3OpiqJ4D5J1IJ1E3NP97DuYTUs)yXfRzErYmRUyZarC49(gerzN(8d1FBAKlB3l)pyL6dHrMkHNduiE0yI)B7ffTELJpn8zoeJyaXGHwgU(1EX1o(fx7PE(oV2f4S2ZW7ApNmF1E9NNXSbXj08J0GHh(yJa5JhiEEov3Pdy50RKr2vgbHmNRSv78r2ttd7M)6FEN3(O8sVBNdrOLx2((eV1rWPLR74L011mXVARelBRweeOHWriUoAd3Tp5YKpyh94Ppr7SgNZUyo(1jcUpXguS2byrH7qg0NbeVY8v)vldHIJXaHSBZfHP3jgz4rF0jlaxw(j4x5G4UPHXgTw)nqahvdrFsMnd(Gr(WWViFkLpfkj7zU6NC8vV6hgtqsa7o0eMhWbNdW5YjmhGn9Tlhia0eERBKiGS1Yv9pS7Rfuid)HOXE7x4KR(H)My9ycqB2Rzrp9a3wNbYW2EV8bPD3oCHwcE6jp5Oy4hveTxRrPilCxrrZ7cs)etgvu37wwaEJNK4(FC4Uemrk7V(eKVYPMpsldtLAlVdRraVEfIpC36sntIp0wP4mdS61ErVksYoQ5Qgz3XD2xCO85szNYy1pBqU3Ie8TyX(LHwOjMUV7(BEoFd2t5qNETp9D68kxQZB(oBy7(6x9wY4MsZt)RrnyLOkGRmqbSD7U7dEhE3DX3shyOzUJuSU7K8aw4QrZO4vzj8Bsg)(f44)YvUXRbVO0ELFxqxxmqK3IIyTnKlkeFiXInI(ICiBivjKR1egIJ3rjZ3fz0i5qzfS5I7dyDbTuE4SCkToM1fEXVKFJ2hJ4vp4w3Vxj4B3P)RndRcgYFKCcWeKqZS3iAEviPNBQUYKqENZSizBO3ewQRnL9oMcbIuem8TBDph0GAcHF1KyUHC6V5UoK)b1wOFEcRN47D1zx2n8Dj44DxtRx)fuCxbB9Rhinfdj7PWVRLoi(eu6t6ariuuKqqJuoH7nBQ)VlNpxgDMjer5Qa)55Up9feCgq7QvMDDgne5L03gtObUoNQ)ZXHWqBFM2dHEl5GZz9OLee9)Sq45arKUYK69oGiU)uD17eH(Gf427SFQODew7I58Wi18EfoNkc7fzQ1mkBezN7l4nH8zBT97XCo4hYVrV78mo6zJOTFE79Kg8YxZwqXc8zODsvI3sYRdQl44)bVxqoULmKFfCTXzy7GfOrOmz7jhTgSlF4wMAKK3JJNkSbA2wlkRRuHtmYbicxnshQKJgQujRdTEQCZMNuHGlS(W7ux2WGfzCYYZWqL7vab)ELB5rQtXhjC0F3F9JMk8SkDTS9IcaD(Su(ONQhcCoGjeRgCR6Qk3GuMGLcuXzMOugFLZee)BRgIrRmo2jhHW1JFFgYRwwxEkv5xp8BgWEjQ2zSeQ4JOJkI3LfINW4BdvWHSMRnQCYG9iGfw7t9LP1P6UG275QbOlJAVNm(jAHTVlws4MUsKq37DnXjE7V8TMWI5xW4GYp5z)RMvhB6VT64VORo4V4aRU8DI1h(2mGFVmmvEkBk8KJWS7cfggq8Qr)NXkm9W)PRQFxfe0HfHdHGsRg)tBHYqYvNOU2)mL55WfHXYL)XOSQIbpFu19NVsFlB4KS0BaNKgMPc4cjZNjkO5sNNhlKK3Loz15Pexiz9ooB3y9HESGYbD2t2f7n8V)319b8Mfn03vCX4Mcq(EzNhm)L9lXHGpZgbL6jz9agg9ZBIg3sjtSdKaaV4z0gsl2uUArneFHSSQhtD8EQX83af1AIJipVkoJ2s4B8o2IeCqLyzFcnJh48mNKBW)vaIRasl3giOQbDdzutWzTh)68zGbZMnGB2aRX84ljRYNbiLxWCobQWxqT4O7y4ILMz(jln8yJn3SHdpCeu2zPcZnFXXluAx7CSHloE4vANtp8peb(4ZIQ0uZozPDpxHPhJt1yLdb1LtsmJEC64zYKHjlbLXuaKQpEgpIUmHAQlxtz)PJVOXcO1VO(kCobG7Nj1QY6t0QrJzjSoz8CB)a(ufxvWXRCV1Ge(kCKkbA1xixA43dI)9q4F)a4FNh)7nJ)9dY8kWnDcCVLNx1j9A4vJGuJf99EZLDm57Ot0uh48Srru7A(8Cour8eaZvMeSAYM6IlfFfif0rXGohVCUPNG(tkbvW31cf0T3aZgBoV4r7U0RLjVCfCVYY1DXW4A7BZ5oyk0kXSFcNl3jYCCQqXbN8boQUSLX1N4(F07(9BxpKUTOUCKEB5sgsU84WSOZBrY7am5o60gcxU4LepGiGDsZzw4ZlcE34yHegiSduLaWdUXLg2EsaBEr7QRFbay5K8Ync(vho2(F6i3b3yLFY72(YxM4p(epH4xK1oE(3t9P9NVO6FWyb0Rlrsa)qsGEpui(jsp9pr79HqoR38eTV(HA)Hph(bWRDc6iSJ(Q1BNIx5sRF2BIFI1lMIaxgtUvb8n5Nenl94Oz(NaVClXwXbz05zqOh3Ec4inchWqRRAVs7E4cZIu3irpe7RU7UfyJy25lnta3rNe4M8a9JOzpVHFVTkBUF0PqOoe2VcbSv4iWvRD5ByPODclc5nTeVZYAF(gxk4WGAXPJtjprbYMZbDv8BGjxFJeP3rwUGhW7klxGc8DMf1foqWVvXCbmKxYw9Z(FDNmNh8G0ZeD9RchgdxdxMBV(kWXNIgH8QWjuPqHOBzViKI9fUViHuK3ziGIVDZlFGnwdDCV5g3UWZqVhHrOfGqmiOhGUxfU14Eb56KHF0pIOflNBBx6FSGM(oMmffws6CRYs2vITiqnvYZdGNSRV0GbcaALWU3XuZVZXleIb49dxuGSq2nFpYf9)7St5oZM7bU(PheYCBZ8QG47EmzDdfGHxUYE7onS6LRG7zwg1E0IqCaCj81WkNDC48cJXX)G88F5g2vlwao6N72mE7C89tQiFyQymT2ckOzofJcYn0KQY3FLGq9KwWcI7SHovGEQ8oefWFtny0AirXlrmT2135PkxdTtHr9yhbPO8clGyNN9BRB9Xpyei84J0cjN8p2YqUKuJ9jTSbOl3E(JgTkdtvMZ3QwnL9FXsJo88flH0GUqXc4NF(r1uRQa9jJJa1fqYEoIrt5gnMQQrScW1MNrmh0StSJKlGetp9036BwMS(78vLlJqpSAsFhJp9oNyxtF6wQwDUyxeTs7NGPoljpOK6Yn)6s4pxKu(mAvL)13vZVjckaBGUWLi6YvQP1hkyIO1vB(T5ccuwPgYlivz5s1AOPPx)pVxz5MdJgcvmlaYjQFAj7BQXnFRV(e36BmIksoYFqwYaIgKS6cM1)QFHTmf8jnq3qUcISyCeagyyDRbhb2Pgv3Bn4Tg6RERh4w5V1MrF8F27tkGp5OpY9G(brvmKmb0kx)IuD9VYi1qwX08RnHUYbI)9Bjvfciv8If)cJ6sv123pCUA1mKn)xVRZJO5qmjqZmFJ77wFJVa91Yo5NvzsqRpCZeIjkiHILGwFpJalDEzW(k4QG8(kBG(ud5r0rCFNgMZvrtT61lBk1andFFfwSvdtLyJaeW77w7i2Pb4kPR1qo2fbOTqZEkuboi4yiGhJJ8v9rmuoGm8S)qfnTgOHJ64vxqU(iki65EocmWHG19Vu2qRLEf5Ykl2ut38pRaXNvvQHLu6Zyrk(besX9CK9zLjLhXoLkhSLs1lUCoPc1mwEXhzHQxurLm2H3G3Nxht1G5TrafBgbnruP5)tNp5929WDE1l0(1pF7x8vx9xDH)01F(vFPpALR(Z78ZF)oV0LqpF9ZEZ2N6fBF0RU65EAl)qCPJ15WaKDU470(tpoKXIN7PjyGCxBSYLp5kx9zjaVRP(Vp0rw7cFgbtDoXjw7cV)UhgHXvV2RrQdbfiOA)bhPZV4nSE4NDXvV2PifHWfjwCDo1Px5AxQ9vU0kx(Lw94hRZB8RB)gFuUmpyMSDo2ltEn8J6vTp1fWF(KObcbb4Me1a2CCtHi8LZn0qp4d9aCxJvX6d3Aq99ti3747T)cF8DH(zKdOPT4D38BjMdRPUCffyg7E(Zid(QRPJvZai8LNFu4m0xqcUsFUNM)t2CdasSpLr11)jKuBye4iFCEtTklrM))7x6)mHs1M)JBLqk2oH6gFPCzYF(koIRI18Er8DJAHyKyKcaVEbCoHC4ZJkYko(1lJQtnLfIHwaanGC9tdrLd7fGYeB9ViHFdBd(JC339DFpNhjKtUkoRnF6)HJy353ZfR5gc575EnkNptUbZ8W37s)x)G)3]]
    end
    -- 更新记录
    local updateTbl = {
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
        bt:SetPoint("LEFT", BG.ButtonGuoQi, "RIGHT", BG.TopLeftButtonJianGe, 0)
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
end)

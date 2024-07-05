local AddonName, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local RR = ADDONSELF.RR
local NN = ADDONSELF.NN
local RN = ADDONSELF.RN
local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local RGB_16 = ADDONSELF.RGB_16
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local GetText_T = ADDONSELF.GetText_T
local FrameDongHua = ADDONSELF.FrameDongHua
local FrameHide = ADDONSELF.FrameHide
local AddTexture = ADDONSELF.AddTexture
local GetItemID = ADDONSELF.GetItemID

local Width = ADDONSELF.Width
local Height = ADDONSELF.Height
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

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
            if BG.IsVanilla() then
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
            -- pt(link)
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
    -- 下版本WA
    do
        wa = --v1.3
        "!WA:2!T3tAZTXXvAh)HDlu7hY6DlxvYUFykKYPawbIaqAkBRiPA5TOnVciKvsCCbnayaXebod2zgqjAhTLK8HoSvKTKLpKLJTLpJtSuwLezDAxv2)aQCT)cYsas(LnvLFbB)6Eo6EMUNzaiLs2SHwMey6x)6UF9RF97Q75Eh)(x8(RE)vp231qVLvdvnfJz3DXPMCMXUGAfDT51Bzur5EnoWS1QzQyTR)1du4tVh0pxUQQzZgYlxu5awFTluPLPL(I4pBSSdK79h(Ph6EUNV2LL1Qux3yoDvnRYJm2mfhRWxvrxVrv99Rn)(vBQS3MsuiRunDJfLTk1SKL6Ik2F7EB(19AID3SQSLs5w4)87Cq1yvxqPUHCflvDnZTwW0s2W6bosv9sM6T0QwVCnvnvZ6jgg9hRV9PrpNGW9wM83d8HBxQHEf5gsYTmKlPOTK0o8(OUH0ZCWesOFCEu2LumqqKCP8zhizcCr1APHBDpyMqX6jumMP1IPmTmsJbc(XqXQLHMKLUwRflRyafQQTqw04SsD4lzqOn1dwDlpyw0VsNmDAO9ZHRUIwvsJPwtst3sQ0ezhEIHKSQRO5IE7NTdNUS3ZYoUH8IkMEfP0WuXfgek50ZPhWPL2(o4bJn2XqW0v8gTUpYDey3K21DOwyA30YQA4ozq8iaWTTl1QkPsZG)GOFSLu0eIsOWTTBndLfunTumgQrd4jwMrIvBYza8cC1PyGjiMC(RhTJIHd(Acw(THQwvxBK6YAAknagVHvL1NqXMAKed7iLqLBnPwn9SfCglqTMwX0uEbL5muQPEGuCXyAP(6tQZV(tA)cVuNtD6vUXvw)qNBLV89w)cVY6h(m(6jtHAE0c8fvSKTKl3qj1ZCWmspJhRwjvTQkhabKZcIuyWYiTpLLtZH1aTqGScifdaoeOdM2LJpfILBkyrkAcxAhiIWtxV4Es6JNZRF(KjhQH1ww9ixR9rVrNJFY1E2BT6R(oDo7Xs(uabekB9B8Z6CMtWugx80(uFANZF82V1fw)SFzNJ9ARE8FE7ZC42h7fw)5p5Ah65rf15TF21FZxU9PETox5yDEXt2(KVgPrSR45FJ1p7NZVI)YtqxX1(1Vp)EqN39ADo5fx5wV7QN75AF0RVYn(82N4t6COd35vVw7t9gTVWpR9rpv7R98TV(hrAya(ZCox4B)SxR9lE2op)lIGFTlEce8DU6Bzdp32dgOV0XBFQlTYn(W2F5Vy9d9oR9RE2oN93GA4oV7njTbmM8bZN(LiyqngadFk55)K1(IZ0(5)WoV3lSYT(YvF1pPZno3A36IRCT3bHirTeuRBEv2A9fRDZpLPwr227CNsicI023obPEFLFp9L(Y2V8jTBFYN5ch9CY6N)qR)lEJvU(pT9Tot7JFs6Ha9ubbSoV2nx9SxbbwO0loSurXRS27)8REJxHa9AV)BV6vomF4(jvQvB8XhnFUC0D3)Wnp3pXGuzpaO7OeaIaJR9B)CuxeHrUOJukcDXcxeABhmrdTQHlgjewFWebE3UezETZN8ETV5PK2zqSYbc(Zs4EO98dUNiyv8N9(TV6vjyZEDk9tcHpKUompHBDEgdR8hKW00(MhQ9h)I4hi9GMs0ZlOVsGPZRFf06D8tmrarAfhCGyZw)1EXG4Gm7rWbcMoV5rqYd8Wb)XpU5w9gNPZB)o2JFCLx93(YWtcz(kh6No)2dJapW0V)IerrE4dsGc)r6HzGce2pYLdAUoh7Lx56FqqEB6sJM3Ma9kx7x1(IxHlIw7YFUBrIgtB1Ewg1OTpX7GFamd9GmtJB1EAKlqHmprK0qppz)KqOWuvKhDMclHtTj7kGg8I2sGSbGhark9NSJwiyKSDwxGrIMfqf(Gt2(yxHwiA7RDfyp5t8U2OgRNbcY1(GJU27FlAPPRC1pYgs(96Z9YR962R7x)C)hWN5tVEJVy1p462W9Exc(mRbdbToPWedNQUYbYinuJM1L9u8IygKHsvqppIPjMTktanFgP(9d5cgkiLRdc7azKEi)WwUrlfoGoygPTMobLbsqB7AFe6ROwERPL(os9p4GUq50UUWHFapiTBvxaHVtdhTQ9yIHiRyKWDf72HGfm8EkTsBqvi1JR5acMNMxXAKgYMMJm(4P0qgtKrcSvwbzMO1Ynvst35HhG77oTlapJXlKPHszKQaOKUUeKYXijByreWDJSDg3vsraoT4Xn3Ab9g(2ur6wv0BOBG7YiU4K0DocUc03OQg2OKgkvSs9qzKMWHKbLKcx50SMEW0u)KkjLYM1gpOpGFo6VjPL8snB6w5mKpg50pbwQHuGPD3zBS7kYJ6vZp7UNz0hFYIzNy(sfNS4uJvA25ko5SZuA2hhBS2lD81F1lU(78RrgTWbd9JWWGB9rh8rhqI7pim0(KhD1R)X8WWefgBSzG(qsYorjzlUWyJIlKS1BsFdG9m5Of3fQ4bYNZF1MBSHkIgltpgQ4(9v6UMC0XgVWqtpMdadWwUHSA1c6GnTGbUexyKWzK8zV(k36mj84iMV4qZm6qfgTuXX((fln(SZuexyvDFmCGL0u2usZXLQb2cZ9P)4fsYXRgbBbmfrxZY8h9J6pxU(ZwS44j)UmCgEy9PRpYmDnwhQWJlRwQywlRAHG4GgeVPGyJwf2DxJ4Xlm5p87vSuPsJ8dkWHE09iYpsO9LeRSGKtO3OA(hjjWEGDddcrKhfWNyULGQ2igkYwkWJsL0PqpzdPfx3THKsdoNKiXbTnzUSps)OFhrvWTuWHoAZPhbjVW2rSjtlCuoQQPVbj(j8AuCb92qexv2riJwejFKCW)LmD41oUd2qgRdgySoOOMCWEFSo4gASoy4J1bJ1e7eGUc(gU2pJlhfPOEKdMuz2bDoSYE5IQcB0X5(RRAP4BCA)mET8Eif1BJt7khyPk8VOQqChNrOl3KMfq7JnLICvKAO(vIY2N(IueZ(5efQMbPrrQKKhLuOFQDQYoy3hL0(cvY1YO7uqDsZPN6UWGjvOJgCqs4bY0tLEtBKsc9ubgvrOuBa73FbASKoOzButf7qstTrqiMEkFLGidtAoPg0dsLNZ4QgIiOIQtESoWZ0AXjm0B1CAfWShZuPP1aIDbjrdvdzT9Lrczw2cq1Yi1qzjLg2AY3V9FZi906Aiy11GGfMja(unhfnMq4sh85VkI3a0sEXYYwfqpHOWLpkOA6GyPgrl8aJqNFS1DhzjPzZgQiHa9LmJeRbgbhLYGEJjKe8JnkXKcHabKieqykLqGCOGqh0HykeymrgbjHylemYKaco7zJWb0boXGbZIiOWtMcbImjJat0Sn7Socq7PFX0pctaM7ieSH58XmpIhN0mvEFHl8hK7tXXLkRQMPIHLO1TzKK5ZrH4qj8ciBzeZMgYcEeBg3Qql2ZxdIPlXRTiIo6M2W)Zy0U2x8fNhviDSf5hvr0oJtV8tGKPJnMod(p0H4evEHHMCubI8XYYYiHg1AsQnLvrcWyJPQFPz2B5udTH0yAvLKH)NzpQ08PD1YwrwRIsJTnFD99NID2oGDkmvWxSN9pcIXokiHH2XWvvBHXn0xelApW2O(f67SbgDR5ItuNJbTGRVO3ORxMhzqyYGtCJuQO6IkgzhQgADdOuLBWFzjpH1jRjttSr9SivNAoKeUsZQnsd1k7lLPsJAmeo4bz13VgQBnPPa)6bW4OqykEoEnDaWjOeQegNPYlce3w1)qZhyyG4Nmd8Qf3URJ)FJU7MlB)XOdZWWiU)6Bfdn74CivXMhCfvkF(2cKkidIxJwD5rWlZepdd9xRhxz5rrDmERU7foDsB6KyfEsUcifGIIitGEYrdUWORifXuOHlzzmny1glzzc08srD9gwQnHj9zHoigeuJn0mJSRzluAQXgViAnCog77OR3inuKnMcTHpDoWqdaIMbfJX72MWMFmnXuk8)a(NWRACYtdInOepP0T4SNYzdO1gK(xIBtkw)qMQEmvz0)0sTisnRLbPIvBLrQuah3JFc2rBBjPqRvW4qAlyK43nDEiOpoiabaPY9HRS0oLYXFRqMwQp2ws42H2vk3gzFq0miUrDiu(ire13jDlQa5GFav6X5bkEyUdQh7sc2U0aCg82WNh8dr((gixM88MbIZ0AgUZpoTD(CIB8bHgFGC9HGjZG3zA(bcP5ZNdp4ZLdn8rJ)C3XiaHqbYribyAaIiK7ogvimYGdDatiakXDqsry0chIbHAaKJ7G0JqjiUuecjbttUtsucLQ4swSPlycZMzVrerWJkKBLB8HRC1tGjdBATC0cjvTuwK)M(2A7cBfpIcU80iH87EY5KnqFL5XbOS9QcdbivXarfMCIDXbtu7v0vQHGALjr0KHxEYrXneMcn5OBKnS9SijfQFxf9y4REySw2YYg(17LSNJfZgo2aQynFfd1MwPsoRgX9HjPmoIqDuAi30uPkRsJa2Sq72BxiN4EBOSOSQJbEoBjssy(ujFWSdulP3aaTzULVqG75smpe9DCRahqlLrArzCI9IhAiMQPv1Mw(apHCJwmtrEvbNf9s)lq9yxv5qCW1n1sP9RUIxxA74DMey4Udj2s2QL5WYgEHFJ8VSBnnNA5ICWM1GrUJH3mKAjmMa9NJB8ScXFcchh579XbByn6LXbNyBiYzrc6mP84hRI4gDHjnIXoFASXvM(WmfMOzntekhIqgKfxEAqYlpp1ew3ozoZigW(7b9HmxikU0Gcc0uBKorK9kHDEaXclK4fmoMYZZfwcclaieQ228I128Ke1pyZzfkJ0aIxq4wz8bekvYIZoNZMeeX5yhnGQ(WZwS4St7uwFdc)Vauf07im5DAi1YNqaEHLOww7Gmb(x09l)7qglj21SiYDldyRyc3iV(yi5xkAzcItgBRJipd72r2bVqQfUpJRL1sVzC6ySjRkobPqLX6wx7ChI(rSPEp)Hax5IB8oiIUdZO(dozOU5M35HIjUTrqobpnbUDYXrt2sa7Qm3fy(BOcbJZzInJllaFFmfQN9frCJjBjV0VokEsoZzjtM(pfu6G59Td1TxiL84wyD(TGuAtOlXd4ACYUdy5EPQLMxxi0qoePkU0Z5LeApbe2bkxCIpqLyzE(kWlylup0tQyCeg5QEPTXwb9kefQTTKk5w8nRj06ds98SbHSrssEk6fPXhH5hu7(hZkQGUgnAC1dPyoSyeBzPy3LgI1qmo0EsZzb(b)6nedRt9XwnTEltfSJ5zzTOIjXe06e5cFY0PeCwpt3lDHD38pP820CUllqmBeS5cIGgrmXqnAyVe2pFApf1HiNH2DZnW8Jnfan1Gv2QUS2ckv9n9iWvVSrAWNpFzd2hz6uStW3UKF6m)TzOGA4wwOEcSFZ02tIJQAIp8RCtDLEMBjonD2QQM14T(LBq85T1FOdSX0emUIUpfv4Wz803oIXSqpmdSrP(9eL3)OmXgJA31uAUPbGi5dXA9jET(EQRO0W2hvvvAyf4qczh1jiOt0RfXWcwIKNZXjXPkBjPqHpriHKExvIRu7IbwxfY0yQ6WMzOtJFaod9iYf3iN6JzwKkaHqANvdPS(skIjPL8XS6Rn8snIOdJQG5VyQ)OsvvlAko(HCd0iAkFHmsLjjsjmxhyNMicyRB9TtJ6iD19Dv2o7EpyaVuspLhT71DBG27MRMGnsa9d9aCE3JF3JvKxsP4XOfHwEHWmMorxPR3MrI24nOeP2oVqCy)SsvHZJvUSdgqi(DGqFaNYrPDUdsRYDhCCTHs7d1NYZFd(nTzOaZuHlPQxmx33Cta7zcHyJDVCKhVuxDlIvQ0fuhgWkjqlMQPeABpx159zwKiL771e5IQl2TPXfv(Q6yhgh)eXzmGfdpUELwBkgJf(Hcg3IqqkT7I(DYPT75quD8Ft01o9t0ndIdvHUPCpphKpq3yEoGLERz6t1mNEUJPYSIRRzBBN)eQK5OUehn9JHhLd9UhztX334vTdlxzFvn0BYCQRGTY6peGhw3OQIHVQKpKqZJJqWI6vXASiRPRT8IizjjffWQnmXH3fPtSce6gULdXJ)bIzjx6VGihhg9pxa6pp7X478dxE9yURpZjIIowPGmt2lOn6dCDGjAbj8aVk3LcMO3o5pBS2QlVXMCxgUXZa0WuDRxoIdSIVDvEL7k5WD5plMImC3UCQXSn9BZnhoDHTerjdqTNy2y(v7IgfDt7TXBUn0XbXLzHm)VryvQrwCGWfoY6Mb9tMQax04kUZlK82jaMa)(IwY6btWOQWxuFynazi9KQiv4Z)uUX(3Rb8h5)EIkhiaBEM44z1Wg3mM(c1mgbjUc1rzsWbxHPdsozhw9O7GJ06bMbfAhh9L8D9wcbufPypNSqru6Pi628CEScalH2nAwJ5vFA(jBsxVwWt)cuVeoyHjItSEJXQYEXEos20ypYtrD0rijVOR(8ozIN399dsbUn6EhEM4GpJ0oFjKddqOl0sW7uetsCH)TwYnuTw29qexI9FGoqTmuWFgSPgg4OpwwvRArIhINGKCNKtiSV860E9b0s8o1p0HJhFmocj07988c2)cdky2HBG65Cv4Ys)SBCBHQuz)eUPXF2xnuQUGcADIc(cZjb1T7Zkx9gRE2xA93(cUp0h7G95KW7Qualomj(pKf)HjV3rt4IklIg)iXfHOTCQGh56YlmUk(C7MCsy)ZAYvu(oGf(y079jadWPNwRAYGNdyyOV5GfBcOZhzb6GPVlz0GNOyuFif79PecWCpsGnW)w(UwNfNhKC3SDtCNA2Es3ULnPviorc7JRubZDbgrxEsU8bdzPkiHh)bFLIfxSdSudFLGnngwbNG32f(OZBrI1RI0RAbxtWQeG9Xl3)(L8M3dePDF6zSjVnQ9fzn(IKgNKdUFlBty6wSsh(a0P9HBxbHDPjCyIYNMZXXNZHppAkeoBr2a0izdlcrkvicUP7zW9U2zo5k368IeQIayo67vppbTLT8lPLyXGJOwAMi2EtzSNQNbYTTgqg2oB5FmCn3f8(4Hx12L6c1BG(Fl(10(gUHxndMpU95kRSpW84(gGx1I5bPMamwsxzSx2PZUy477rTQvDWT79NZFnj(jaroPPz8WUl3c2R2jZW)GJNw4I5S1rkVIANYwj66TofpFYxEkowWKJRdmQzft3x)dkghSjgTF8WwAqr(ymH7Ltb6PLIP(4jgVYGS2FWa1pc528SaOw0tH9QerAe2tPV0Dajqr0NItsVjSxXWV6DY8X7d5x0e9zD(VSerzVuXva1w6cbuSNa8npXuBZ5LWW46gybnMPsoK2Yah4MVan2BkH0HwzSlR4wzCjHxzCYEGQS)e8ieUsYjnHJCu28(w8f0c0hI5vZcc0yEPSyVMyT3)5B)bhLC9zSrmvI10TyzFuxShGpg7EF7Gq2oFWb2y7mKpx3lKpCf2JGTL64WgQK64XY(x3WjE9kxVseWuhMf9IbdTOB9B8kRD8lV2Z(sDEZlXzLMP)vAUNlsNvB(gZMeNGY3t3M(4JndLpUpPb5uD3oGTBRsfBpoegYc4(aFnnSL9B9fDE3JY7W)6MIz2(j77r83gbN2oFJ3rYTMf(LZJyjz1IH4leoIWdpB6ENjF2bd3Xm(6t0UBXnZ2YZVoXW1ioGI1falkCxkGslGuvMVgSAzjuCmgiKDhUim9o5WdnYJprb46(oj)khg3nnmoO1(VHc4i6i6tQCzXPn3Jc)I8PaCGKnix9Zo(Qx)Jti4eI6nYeEird)aIMpVWdiQvG92a5FwWRnGKHCuE801d7)zbfYWEiyO3(Lp5QF8VkrpE4yT61tyn942r)aYO2zd8(PDxoClec(WzqsIaeevenvRrP0kCb)qZ5cY(etfv1232waEJnK8bFs4cGlzANV(uKVYPMpwltl1AlVl7raVEfIlCpgYntHtOhEZaREJxXVsJSJAUQm2DmNBigu(mPStzSkL1p3Bya(wN48YCkYdTCGlSzEUvd2r5qNETl(EDE9R05TFVnT9EdQklzCtPUzWLOMSYtfWvgQ41UDV9(VlV3U4BWbm0m3FgWeyUC(PrrRenJAxLLXVjmcmPF8F(k36nH3ZtV(VjSBseiWzXrQ2MYDiraKyZfrFg)ZfrvI4gVGH24FuY8Dr2hsYiOWTmC)aNlOIYJMJtP1XCUWR8Ib3S9IiEXdU1d6ac(Myg8gvWUGbcgIMqS)iYd9zmTTkItUz6UYEqEj5uSmm0)zzPRTJ9UM(aI0cm6DB9srwqlHOV1kS2usmyURd5NdVcDPtu9KaVQb7YUrG7hf)BAA)klGI7kCtF9bPLyiztq7Uw6G403lG0bIqO4iHGgPCIJBU0)FxoFUm6mtiIsJD(ZZDFMTlibe7QvMDDYUh7L03bZ1DUEMQls)9OQFuzeFKxfk4dMC8Yp(no9m60Jpw3lo9EhqeFC6U6gPpYjZqUf26IjZCcNm5KDJDX8yuKpEVFythJDkS0BgNTjCoQd4Ticy4RZljzo4hoyA(3xym0Zgw)a82zid4aUMTGIf4opNtdhEdd)(oUGRZb8FZM4vYabv)0bNrT)sOwiYCm94SNUt5d1YsNCQR44gbhGMP1IkgQv4eJAaIOvYZLk5Q)i154GwlsUh0J0rGlS2QZzOyAYImohpVOqL3z3NFVYR8y1P4JeoAxhS(XtbBwvIw2zrbGUa2XE0t1dbUgWeIvdUou1uAqktWsbQa(suzIVQtcJ)mUHy0zIJvSXiC543qC8QL9TErv(1d)UwRxcVCwBHkbi6OI4Dlp4lE6oqfESJ5AbjNJECmWcR1JboISP7UON77mD3LHp33HbjEXpVlws4DswiXq3)AIt8U)53AcBMFbJdkNyN7VywDSL)6QJ)KU6G)IdSkW3nwFeyZa(9YOu5PSLWC5Gz3fkm0N4vJbt2jm9iyAoTrxfewECWHqqPvtWPTizi5Qtux79KY8ChIWWSYpngRQAYZdsDF(ngyzdNZr7MqsUWmva3Kubmrbnx6(8erCUoPphZ8uIln)ZkeVJEmB6tXETRh8LKDiVhgJ8nRvcUhqMaVAOdN3X5M1p8uLiStZroFGHr)8wOXTCQK7cT42pEgPH8InvQwuhnNROO5Zmg)jRvWgOOEtCKW5vXP1xcFnKXwKG8dIL1iYdraNN5EEbcEVm4j8RLwteLnLGQMoKl7GAcsFD49QIuF9NlxihOD7X8ylPOXNbiTFWCtZt4lOwCKDnuXstp)eLgA0rNDMOHhY8J5kvy25lowHs7EUrhQ4yrxP5MAOFac8XMbvPjNzIs7z2ctnkNQXkJbQlNZUk6XzKYMnlZXRtbtbqQ14B8i6gEPPHsn1dKrArZfqRFr9via9WLMJwvfJXB1OXmewNS(UcwaVzIRk4YtUxLlcFH3514YglKpd87(X)Ea8VFi8Vhe)7TI)9dZ8cdntsCVLN)Sj9A4(QxUXIbElJYoMcKZcnnaophue3UwaFwdvepbWCp2aRMCOU4sX3lnHLde0hBk3RFhO)KwqfcCx9aD7nXdHlNxtJD35sL5aTk4Y(KR7DHX1o3H7fJtKvIz)eo34oK540rIdohK246Ivg3AI7)XV7Vr76r0Tf1LJ17wuYqYJhhMfDFN7DxGj3vF1i4YfVK4HebS75dMf(bfbVxeKqcde2bQsa4H38o)Y(o5Y8IZuxFRSB7a8Ync)fTm22E6yMbxJGF273(QxL4R9KpL4x7VUE13x9P9vVO6FWeH0Rlro56rCYZ9rH4Fc0P)jExs95TFDa0(MhQ9h)I4haVlaOJTn6R2VYaE9RS(z)s8tSFBbe6YyYXXpWKFk0S0tIM5Fk8YTKBhhEp3Nbb9BNjHCjeYSp77)Ss7zOcZGu3izpeRQU7q5Vzm78Nnta3vNe4MZ(BerZ(EFOEhv28grNcH6q4CVU7OWrORw7Yx7nXl3gI41FdVKiDd(AWj8qCAZPJp3BIc8mNmmv8Rfhp)EeRxCrEGhYlWipGc9fze1z4p8x1tEagXB(OnY(FDNmNh(G0ZeD97NKaowjCzU967LKakAeX7NKiLcfHUL9Iqk2xp5IesrEroak(2n3i8BUg64DH9TtHjVUpHrOfGq8fOhGE3pP14ERL6EW6OFerlwoxbQ0)ydn9vlyAkSKY9Q(KSReBrGAQKNhcpzxFtUcea0kH9SRjNFUXkeHb4BeUOqzHCA(EKl6)3zNYDNn3dD9tpiK5oM5vHX39ekgMQadVsL91DAy1l3lYtVmQ9OfH4c4s4BFto74W5T4HR)b55)YnT7KRqC0p3Tz83547Nur(Wu1Ck9furZCQMfuAOlxLV)kbH6PSHfe35aD6q9u5DjkqWMQ)41qIIxIyATNVZtFeKcYlSaInEMVTH9h)OHHqEpClK8XFFltLsYn2V8YMGoC793B2QmmfznFRA1upWLlnYqZxSesZ5cflGF(fgrxRQk0xmpcuxaj79iMnvA0yYQMjka3ZCMjU93SmzjMl(Md7j5ci50tn1fQQugHEyvKXUgBQ5gF3tD6wA2DUexgTc7hJPklP0VS2Yn)7LXFUiP8P1RQ8lVNMjrqbnbOdCjIoCLAwYcrClHwuxcTqxzVxa1bTd4w9)4(uuAoeQFwXQaieO(PL1uxeloyR3(Rp(Vtr2eIXJI2cw1)BU93yynKiJVYrGbofbmmvQGg7Mhbaf673o)WW2WJF7COkC783U)BpWTFi0FVF)p5RKBzvx3y2MyYwIHRQywP5)tNp7d2ZqDEJl1(TUq7x5nw9xCP)WnFPvF1pzLR)t78t)WoV6vqphzkB7t9kTp61x9CpNT9Tx5yDomazNl)ETV4XHJG25EocgixucRC1tUY1FbcW7EY)7dDK1U0NtWuNtCI1U0hUNHqyC1B8MK6qqbcQ2F0r68ZoV9d)8lV6nofPieUiX4PZPo9k34kTV2vw5QV6Qh)yDo)VS95)K8zF4S56CSxJ8o3g1RAFQlH)8jrdeccWnjQbAUfXtyvxgX1OwPKvDdfZ66nQU8W1qgS18RpUH6tl99AjxfI9MuXIFLzD5Q67)hmBTAMkw)Z3tZ)joiTI9hUD(YKOVF4tdrtbB9wzInAddYeEnWWrd9wnFGYMOp1qzyd0YQtdm1AiwwJ6LTKBG4CFGcl2cXcLyyG55bU9ejonaxjd9gkjUmaTnA2BHkqULJHaEmoKE1h2u9PvGN97rmb6adxf8PPByiXihwfXrT3JadwiwKFJYM6TmQOuwDXM6gwChDnT)qbGYv1MG89jeK77pQcbJwtUH92wN5i73(qCEeNtZzzulwtDHexWqzbeeaF8WGwCn)2INFAOSGCLLlvRHUUr9JubTIc1MA7fTm2u2cwIOu)Y21Ese6lNFGbE4h5HUaAPFbCJy(nFGB)n(k0xl7Ea9A(Te3CnnuQOcD)7Ra(isC4M3pIEoIDZIw)xawCp8tRRV49A8JjNVGHHm74cw6vwImY)Bx6)mPA1M)dBNW9UtYccPLYNDGluXvcwIcYW1YZ99hrMDIwGIv2bOiLNFeih6B(p6mwHEPtcmvV)wQvV8Y5LluZC5fFSfQI4JGwfreQ5fP477YKPgS95p29EV379DbK8pLQ4j)N7V7YQAKbn8(8UaonVFS7d9Z9BwEWS57p7JE)l9F99)Fd"
    end
    -- 旧版本WA
    --[[wa = -- v1.2
        "!WA:2!T3ZAZTXXrAh)H7ku3hsCUYvDj3hqHuofWjqeastzBfjvHVfT5RaczLehxqlawqSrG7IB3fuI2rxjj)qpSvKTKLFilhBl)moXw5usK1tRQY9hqLR7xqocqY6Q6sv5xWn9m7JzMDMDbaPStQ7OTib2PNEMUNE6PNU7z27E87DX7TY9w5yFFtJM2110vnND3fMAYzg7cALn0N3OPzz17(luAAxZWC2g2Ag6wXASLkAwnQRSCb1dyxSQH5Ik2fBu0wBr1IvwwxzrTYfTRzQAvZOELLVq5Mw2glcW(1mxE2QvTuT31pyV)Kp(q31D91UKIEzeMNZqt3U0iJntHXY)fLnqvZy)6ZVFTgQ7TrC5ng5B3DJVUFtS7gvuSvl1e)N)eQFBGGqR8E0QyxB4HqF1uPmMk2AElBft777ivmkAz0uVsTsv101SQfBy0FS)UNg9CcA3BjYFpWR)Fx3OSs94knnvkQQVu8D4)rdZ4p1bJ5(1mlPAIknXs5Y0FIyX0Qgx3WoEXjYm8edf3UMQES4OFC((oGA6)9mJBQSOQf5XQ1TuXLrA5Qn1X9(4tOA)yQMZ0CXKw2MPWq4dfPXTn0BUyjvtacn9fYG4dLRbFjnQFL8(RSL7pd6xPsKYV6MQ2nn1H6JFKQEf8FX)crd(nknDMk(23bvroebUapk1h5crStDgQjM4MwrthZdyRVeG22U0QOMmfdE9r5ylPQlenqbBB36MQlOzzRAou96WtSTKIjNrfgCbcOjzk3V2W)85fuIkWxJ5lPmuLkg6JutrxxToiYmSMIXeQouzIyJuevM9K6vnYK3TVc1yAvllLfuNZuTQ2bskeBPI3xFXB)7(Owp3l0(uNELRF51p05w5wVZ6x4Lw)WNHQhmfQzrZjxu1wXwPuD1Kp1bth)P8zyf10ROEaeqUsFjXGLo((ux2x2Hs(X2GiYLKbaGHCWu4jdjrIltbIQObU47ar0pzTc7jbL8IFF7XtmuD7TS6rUARJE92h)KR903C1x(TAF2JL4jaMfu26x)x2(mNGPSa4O1P(42N)4TEJlS(zVv7J9kRE8FvRZC4wh75w)zp5Ah6zrf1(nF61F9xS1PEL2x(yTF(t26KVcPbCQ45FT1p7NjUI)MtqxX1(DVBWwV9BF12N8tx5MV9QN7zAD0RTY1)SwN4JAFOd3(LVARt9ATUWVS1rpvRR(STU2hqAua(ZCop4B90xT1ZF22p7ZJGFTp9ei4BFL3Wb(aTfqGVWXBDQlUY1F)w36xV(HER1(TpD7Z(7rnA73(ge8d0chmF8TqWGAiaMGCVZ)rR95NP1Z((TFNNBLBERvF5pQ91p3A38tx5QVfcjYAfOw34kS16Zx7gFmtTcTD35oJJycX3(2ji0)Rb7HVWTA9IN0PDjFoam08)1p)Hw)x)ARCTFrRBEMwh)K0DBA2obS2VYnw9SxgbMu(JaXMWKhw7DF2vV(lrGCT39nx9Yhoim)8YvRo(4JMlBw6U4F(gN7NBsQOpa0DocaHGT1(dFgQBHWMqurkfHQiXdHp2gZGqZeeInctKdMqW52Jtg7A)rVtRBCQ47migfarWrdCpZzCa3demJ8tE3wx5keS4mNJ(jsKVOHN5jbG)PmTZDqIarRBCOwF4ZJFq873kon)h9vcmTF1lJM3IFIfcisl4IdKi06VYZhehKrjcoqW0(1pcAETpocsZ4MA1RFM2V5B5qZ4kU6F4fHNizCjl6N2)HdJanWqmFrI4cp4bjqG)inPfOaHTF2SqZ0(yV4kx79ckZsxA4YSeix5Q)2wF6LfIK1U0N5vKi6yRoJMOgR1jEl8dGrI7Nz4ARodxcbsY4brtb94HZtKWnPQKiEkfgKZzjAVreRmv3ef1(aeQwAYkoHGnYYnDi2iR0da)ENS1XUmTYVwx9YWALN4TDqlEDFeKR9EhDT39M0Abx5kFGdKb7TN7fx7vDMdV(5(3HphK)8AF(QV31CG5DUi8zS5CX8m)2d68tmCYAQhiD8HQ3OMskkt1nvRa2vrS92Qzjcy5shVFAOwWufzGAq4giD8hGgUs1BQkaSbthFRP8nLM0MEg(J(kQf3AQ4FV49p4GyiCBppyWpGhkNwZdi478W4AEmMWfzPFCCZ7GFcgWWsSq2DFnHapJP0c49ZRApsDflRrgF8KOnDIWpSnrv0(BSxUHAk3oi8fC)ZTDay9mWNWElMoEzavU1HGiUno4adIXSB0geXnDscGPcstcHgAz29xqA(Yg1nmXDlKexc3obP(m9bkWXgTxxTSDYhinS9lcRakjjUIuBRJb9)8YjINjJdoqFa)C0Ft4Q5JAeXRIPjFu6qhbgNUU3qM3ifE)15qT(8ZU7zg9rNSqMjMVyHjlm1yfNDUcto7mfN9rXBw5fo(6V8NU(B97qgXZv7(r1EWT(Wd(Wdex4pOA36KhD1R9H81EI8Jn2mqBNGOPpHFr5hBuCbKLYsq1H3ZKJwyxOIgiBwAWNBSHkG63tpgQO(Pkzxto6yJNFOPhZTWb8lZurRsEdyFBWM4i7Qpg0B)KxDLBEMyKr05lm0mJou(rlwySFuHIJp7mfIvXGsab2zi1EMCLqswhV7P9z8O5tWTB7GyetPgOT4(t)P9NnB)zkuy8eFFVruFS9K1gzMUcBdL)rv0kwiJTDvjiKDZDByeA2m)U7keoE(j)j)WcflwCKFCEo6U7qaDLP9Hb78YetyuVsUhkbiuIDnacjKhX4MhVNIQYiMQk2QWJsMWTq)5PPexVTH0ac(8ImRhT0s2mpu)OFhc44wiiPIuU)qO5VoU(lrkPu2OAwCeg(j8ni(HDpzHRglvXSsBIhkl8FUUSsun7gcuaTnyaABqrn1G9gTnyptBdgoTnyhn4nbS2khj68SasmKh3dsMKkYsOzXg(KnmG3O02(RPzRYrBopJVv3d5XDpT5uXat7G)pmG7uAtIDotALhTgYuQkvqMIrBWHJBLfzSIZZigFmdA15Kjipkra)B6ckLhkn9ApHg2zBgTXztAn9uFP3zrIccay6P6zQGenH8mlH7S8l23VswLpf7wkO6H7iUUwD2sNEkQNIiXjTMuhAXK54wIRkI80qWMdBV3mnxCctJMnMwfmr3kzQ4owmWARiXYmtf99LooABdlavjD86QlPw3Xc1(D(B64pPHocwdDimqPzWLM1OO(pcpgGFF1qJTGfHlwsXop6jeJt44sASUggg(d4sF3FCSnfT7gRg11qtg7lr64(glhKQua7OIjYoqhuHjBHaaSceayoIqaC5sqhYLHjeqmtebfHzkeecdgbJdNwoqUWigeyKbbbEasiaKbneiIg9yhfra5mCkM)qgqXJ0sWcwIfleiMEOfm8)saypyGNGJRqgnDlvtBzZTshxjOubs6ImUISlxSiwitirIkba3XGtmTgn(itHfIhhvxs7SWC6n7gH(70F27dubvAEea0busCOKqltn9YpgsHmENIPX)HoEwOYZp0KJYPVgRWkDCeBupUwdfnKwk2GLrRYYz9HQOvogtVsCf4FmlMKkipQAMYk6LvRVT5RzS)KuHAI2WEgaPcwiDpnKLaqA2CcgNM(cJBASiw3mZAA8ASDxHXf7E4c1jyqh4Jf3vH6LXegKLGDqyKIf0wu1mZqvrtCaRu8IEh70NW6CvvCzKOEKu7tMdP2Q4S6JuxR8(sAPwVQhZb(sgJ9RJ6gtAjWrrq5UwtLuKx6sXakbvqfW4kzorf71s0DFoqWaem6X8qlSR56CWW7AzZ0FeDoVbE59nkPAxrP5qM3mp4pKKCoxbMHQa6iLBh5i4PaIhPG(L9JQU8OOob)mTErYK0wUrX2xRHikwHa1KJYka3XKBetG9i7X0Hzc(K9eiECbdJ62AnGbUzHodUyeYhAMr21S5lo1yJxanVkR3MxORZi1vvmNcTARBsdqxiIFafHX32MWrokfzVc4)hg)LxToja4Knvr2YF3GVEky4qlni9Ve3EoISsgkEenf0)RNCrKDmldAKQ0mD8ImERf)nSxE2scHMTJRB8TGRmTVH8RyFCveviPs9HRu8DgpBWLsyWEF(yx4YjoaNTBwhbnsGrUlXtr2eBAjnnLx3XpifyHqwMuacrc7W5rEK22Jpahr5axoydX56BGSPZXZj7KHL0b4ZUTxUSIBWbHgCGS9Hkp9GBUn5asAYCzXez2SiYerNz30jujuAwcPIPveXMDtNALrUU0lMGbk(oajlJMDjAcvdK9Da6wkH7r5esht73jiEPuVh57q)ygWMrpqeX6tTzx56V)kx5eyYDd3AYvsPzRUyWfkDSKdwgBevCzPqkr39KZPyI(kZJz4A9YcSmSIoab5NCIDXHbhDXD8s1impjIUhE5jhfJCmxyYr72f38TCojQ)vb9y4ReSuntjftA75i6YT9uK7aGQ98Ln1AyNmXS6eFpLGYWDcLRwxPHLAfwR4bmzJwv0PqbocYuDrfn3nD4UedjbAtM4(Zmq1e(DA0cG2PsftSFx8r03ZRccaTy64lQGZAqmPHesMwtFALd8yk1B6nmWL3Qqwsg)FbQh3U3Cyo46MCPaEwYVlTD8Qbc3mTpl2wXUP1WkM(XnH8)z2Akb1Yd5W(PcgYfp5UiQLuNa3F2ao4wQHhrqh56D6W3h29kDiWr9YCqHKotsF5XkiPrpysHeSrBTg2eHfhMPWeTOjdmHkTivyzXLNg0IY7XGOiHezTIG457b9HmNokj2Gkf01QhStfzVukXanK0cjEKHBlRr5AfP9jFvFv3MFayMNKXWbRVDOcDdiFYJxLXhUGKjkm7CUlwquXJ3KnQ6dpBHcZoTBz9ni8pjOkO3aysQUqQvekme5KWQzCcMb4lmVV8VbPiIC3fIgoAAclltKEf1NdjX6qtXqs(49Di23Vu9QDikEnY7yKoNTrJoPJXMPE4StbvgRBhDsSd6hXMZWIjbH6u34DqeFhgHPJ4vN4lyHJ9oCAXbamcwm4HgWDnUoOXrJAxLoJWeK6AqeJChSt7jwe0hnrrIsz4DOOQOCqnk5ubJJjK0L)kG7hmPyD549c7vWZc8awNbljVLK6IyHUlMSsewhAYQPe1TeVmyyEsMwEOOW9HaUBNY1H4JWfw)ixb(brG6H(AqJsXLNjSoBglOxCOqRZUTsSfQrnP7CHuh)9Vqw8jb)6cHU5LW81OtFIzMvq3pgoE6H8XfMqI3TPyxskzNumodEsRzHXBA7mczNQCIktB00sf78AFXfk)YpbTnuEWMivsjhQSuDtZU7gFLiJslbUSevOriU6pcWnTEO61DM(rlZ1vEJpYrGD3Oh4)oukI1JnQQMI(cQvOy)sCLkRx4P8PkBqQidvIDE82JZZddUuafed30g16W6bt7m4mQMf(01fy3R90OFN0KzQOzvLFUwGaeZV8COeXy6cOHO7dYc7kJN32reC4UK7Ur4SDnxLMII1BCYUIlgi0YIM3g5Ci88W9utvTUJVLQOw3M5um4evfiOkUZxWWaw)NJl)4DbDljcOeicnt0RqrCxzh0574W51bl5UzfwVolaCHE(B6KO6rj8jAPtjSUz1rgXUKQywwrkHloCscJE4H0tW4rhAdLAfnBAoj(HbcogA4BH0XlrY(nyCJr7Dibn0REo5GQuxe)LIiJtpf2qB8e(gn50l7MG42nNP4EnqXHEYUUZjN6lsXNOc(cmryPticvPI1r27Srs0cFcqKzP8U(357fRahoKSzgKrP5DGWbahjQ47ChKwuOnf4AdL2hQ)KtSjhBkJcc3yPCnkDZwj5gdySrpeMl2TQspVzERhhz6ofC9EWAFyf)kjfUxtHMSYzEVidy71e0HQR1PPNdvU)5UhcoFviOpJvnoUr5M98gjKF6)WTaeSnNUdTZ3CCpeIJI)BSUYHtYo29UuUBt4L46Kp42i(ocKEzp6JRixp1D7B(QlR6Sxe6KyJj93JYk2oWtMHEq(3W(CfpdByLY7RIPrJHnmROAYCyq8SwIXKzSdMx0OcEXCfDd9Lxen9nHOu)CdtFIUajcnhs3WTOeNetVDSWyBzzyB87aq8wJ9KU6W19I5nkWeKkHhcsMbfjXbxuf7G520AA)k1q)U8geXlgS9wcYjBuPBZKAwnDE2Dfywu4EELflILxjtyxUtBh(TVXjEke7K1sHvZ7GgG36b6Q3jTXgRj6Qml3BWMmg2ld1vjcXiCGdYPfR7p0eSlDpDm(rf1jhCK4ko00jFyyDsDqvKHHys3)X1qwvM7j8c7QpIPd6AhZ9yI)GVL1eJw34wq3xOwqlj3bOojdcY59a8lscJBNk6J1HWSbPBYpaBKoDJL4UYYGypHS5uqG)LfsFz3eBZJxGCjKM)znNx7jfhp)Us(MD9xuVeo4rDuiWIyww3Svcssk4qTjPYwDsEI5z(PBYq5FpuGmKPx1F7B1n(Om6(fj5TSWjoChvwYjbKex3)1Mk11Sx27GawK9)bdiAAQI)mSDnGirFSKMELceN8nbjN5iN0pQ0LZr2hAf(draDeiXzqEirBSN594TSoOGrGaXKuW1riHp50yok)OsueCtH)SpRTV(IVYvU(QN9fw)nVa(buJJo5RT)5mgRRkb(pKzOHP011gWcQlIig0CAjMwNm45GS0cJRHp8DjMewGQQsz1VhSdrmQ9)eGb44nQxjrWdYNALfu3CWcstaGfQd)4bLqkCg6YKhBDSDX(kfrTBs2B0deqzFiMLi)oC35McvQlEzTnH1czB9oDrrc2jEta7CJKSbALr5HVUdQYjtEaDP4pqvcEI7oWZFPEkEdzWCPy8kJ54FBjUV7IONhb7J1RaBNd4j)Qq8JFbcxi3k3BYlm5CvFIV(nXrL17BzAadJYxgNdq32hoJYs7st4kCKlLGdcl3j4mCodou2BaEJIPnH5KuGQs3EcC78CMtUYnppVwoubZ5EZjrDFvzZR2JyJSREpAHd)wTe2LIZajntDiL)MT0pdUGJcEJrWxLDPTqT6O)zlUwo3fd81kyIb23aW)4HRdoEIeaXQCkH95jDoncFhFbedobT)S01ISLveVIMHWJvVHBSphtKw8rVmLWzEzQHSHdH)s2bpgWDYcuIhOeRCdhrmYHcaOuwDL91)GIRpB6xYJd2sz15IXcUNnfygtsM6Ihe8ldYH4bzQBikq5n8TA4dt9Q6kAK11jiXMS6Hi6lrLUmc7nmYH(NRvMfdO1JqFId)BB9joI9DM2e2dA5gxNY2CVOOh3WeRzWkzIH0xgeN2808WEyItjTIyxKiSI4sKxrCSQrvKpg1seVijHUefDSPZP47saO9J4weabsi3FaocXR9UpBR37OKtjEVSJa2TFe52a6cLW93ZkHPxHeWYGd07kHZLTZ1Rk3q1ieYOohBsvogTa2)VEDX9gV9eZOjNz6Oyqqtpw)6V0Ah)sR90Vq7x)ICZlS4Nx4DaNCNBqrFwexNf0VNwCYJwHkp2x8b5QQxJ64eKKD82FLHOaBRLQjHv9EJpV9BFuoEHFER44PLFiXJneC54(g(37dvTXxt)Y1TuncfkO6hHRf20DlqUmdk2XaC9f6T87LUm5ccFeBt3fm8QQyvv7sfwNhuZX8v2QKHWzX1MWEDLoW81edp0ip6e5Hl30ebROmjv6YDrNZFLc0igi(qYSzW5EZdd)I8jgjkYsqR(jhF1R9HXeCSR8PcHN8QWpXv5Yj8exzhyXeq3KnCjfNqsoU7Bne2lKckGz4waj26fp5QF4VnwxEYYS7LJXin95UslH6CxzSFAhKcxTtGpegeNPgCOHy3wvkt4GBCcAPpqVKyoLM((22cW9)CI7)XHB8NePC)6tq(kxTEKMw2AvxExo9A(EcsAApMknsIZYaEo8Qx)LOnHIL6cyavNlG1ZczIf0yhoyTKP)aN2oX2G7(kzqcScUgl5DtdOj)qNETp9DA)QxU9B(oB412cAyhH(OSfJD6KfREnjswsvZ1TRB2)xsRBk(ynJHK5aLddozZsZpc34sgZvkPGVpTzgmp(VALB(6WBMHx93htYrPhcPruAB2WhG6aiWrYG(aRMneWd5yEZWd4PkMVZVlhs(oiE)n7hK8GL2FWSCLudl1bbdyWnlNqHf4XTi72GfV5OGh7xQDQpyhzVDKNaPoy)drCCIs1X7ZruABe5gE4ti8oE)y3XxFvKvsHVkMFoXbR2g(rK2EdNXFcN3emr9e68GOA9aVyE6IMM5G5tVOKZLKmLuI8TSXbLTyOcMvLDTlLfNurbMntuwe1mAAKji(zzt93gsVbewzy6IYZuXJHDxQNkivO64ztDv2O2XtbVdLmQc9gshMFQHM(n4tVw0zR6gN(dpzvJ8S237nSm5RuDuA40Hm8Scz4CNsXoKxhfPk6TmwQq0EAB0ikvNUjgmJAtMnt5(6ZJd3WjKGxx5yONnSXbePTmn40LgnHIf4(g3JKbwjkVF)Y7TXs(JgUFjdWAcLl(IsNR0DKWCgr4wlZTm4vYk54bWTfuxaMP5IQMAL5crhuA4gR4Xn8S)HkTOPTcsyEtNke8GTYAotvllwej48HegA8p8LI7n(LhzNrmc4SgmyDJ2Gq2L(x2vihqfZELo6P6Y41byaj6a3HC6Q1jLjqKMkeyeZbcAwGKqV50am2dWTtPoi6G43Bk81W5OgxrCDWVjs6MaTLXrjadtf9y(JElxeeDHqEe0eURfbNnTiWa7owcCUQs15XmK7G91fbnKlLRJoQHDOiTFUHZg5qqM(eV9FDit7i8kPFt5aYS)nP09w()LUVJlDhu4gBU3Ds57akKf3ZcZ8Hs2sdqnJ2DQA3N4zsbt5cN3rSBgsYYIrTacMYcb2HKifUc12IUA33L43sTWqtfmdOQOzX7PHUlTOci2l4uETbcwpd7gUUmymxhnof4zXc50jrFe6ezeuQGzzVOdahBYC4FNWY(6ruYBzOiFfueJj7ZzEHbgUmG7v3R8WbhwguNLcemAN3grxkjtSl0er66psDLfBOwPGbACuvvNYeE(KgHfPfmAGJiiFfM2yj8DMI)JLK3cEdZX6Oe7vWZ8YHx2dvRVcPM6nqCUKsQwkbhT1Qss5u4IspEF9Nnl3XI0H2gBj8lSvbdMPObXlPVGVGAHr21qfko98tuCOrhD2zchwiY1Zvm)SZxyS8f39CJouHXcVcZn1q)yeOJndQctoZef3ZS5NAuUQWo3hQNGtE1sW761mzYW4smvmfJmnGJgKfYXgMQv1oq64lATaAogQFcbPeUTb0ROAoEZ61NHisKH68T76blCvbxCj8CYl8T5c3nIS5c5sd)UF8Vha)7ha)7bX)ER4F)GmVERsNa3BzD3bAYCdtq6GTJNUJBc0w47Z2q4BbmckHRuxL6lg4nTfBdg4(PcAF84bZDgamPXLzJlfFxai21xoSkQtLG31CaqwYElFf4oraO(nXtuMGx5qD(bVkW1IQGlpmjWsORDUdVlPGiReZ6lcU5diJGPIehCNwSU5wknW911o78U)gTRhr3wwxUtUUmDijFzCyu079wJeH8GVCQCOInvXFpdlJq(x(KLhqgWEhxow4hug8(HuaPTrAhOcbGhCZ748j5G8f2TMCxFVT64L3s1L(ofe(rhVrA6GQaxctFY726kxH4i5eprA5xAQUURMR(0oIww9pyNFR16DJB5CkUKDinfW1cEGn7TR22CoxSWTUXHA9Hpp(bWTkmDWnrF15Yh(vV86N9w4N4CVdhP(lYPxnGqss0O3JJKqEc8mZeBhhNiVNbrpANjGeXcspkNBTMI7zO8ZGSDjrpClr3DNL1nRrP)QBW4l9bfH3RWBeL9CVLY(ksB)gX(fP2R4EFZ6ACtOZT7YRK)olu5rC18lkF(2Gxr)HhbqN5c4dBJSlhEbj9N0RS)qvftCpsh9YxWh8qEjm4duOVmgOoYUH)6RWhWWF7nejr2R3u6DUwSh8G0JCD9DMEu202HA53i3z6sUtkKE3PhPUUiSjUxufY(QenmvHeLFDZDu8M7g08VxQ2zOVTFPuSHMmdHAGMa9Vl7Qk8gUZ7Shr)iIn2CUrG(hhits1ltrHHKExzCK19ylcmGM88qKj76B6pG4rZq2ZUMC(5glFe72FJibfQ4JBZ3Jsq)F(Dq9LJrdHoxAdQWrivCNyJH8YLpMQPLgmHqT8(6o3wDh(1KDi55KNlqf5AwqjHhaIDfBq6P73ZsuHNi0vQOPHoTlgSB2F39kjjSxv3H2B5FHPdaCeK1VlSas2zMVRPZh)GHHqspCtKsR)utl1Ik13VYYwGHy79pz1SeqW2Z3SAvTdCPIJm08fkImloFH84NFHrm0ROb9nRJa1fqYEpIvd161NSIvS8WTZKvSB)TlrKR9W3CypuNhP8CQPUqf1si0dIUM7ASPMB8Dp1PBQ705IDjKy9pdZTwsTFf9LB8nuWFUaP8PnQO(BURgjqqbnbyGBrIbxfBu0gX0lIMjven7sDVn(UYbQU6ckLxUy16ggM1(l7tvTXqiIOSDEyAzTtRORTiEc6wV93y8)OQIfeCiv9fSR93D7V1W6OjXFH7uyC89nTulJymwhbafiSB3)WWcNJF7COkC7(V9a3(bU9GO)(n5FI5bMTAvlv7D9doq(p(Uq)G4owk2aYvRDjkc4RnCv0wuA81h3u7jJ)dBQubcwv8cf(cRAkvm2)pMGM)57QX3wavx25d3U)sKqlFyHG1W5d5bEuLHRBOu5vGnpzA0SX9vYc9P6QdBIKgpnm2JdUvTs2k1rdW3x(fBw3wlw(Yqg6EF3EIyNgaSOPrD1yxca3bp7DyGrJbaEQocjM1g2s7jvHN9hlByuhro6Jvzb1AdRH4Q79iaHdbX7FQKLrtZYQL0wSHHP9FrdI1QUsDhvJNXHv8JiSI750q0zWBjRezJxLqyRQ2cXUqzpH4yxWuDb0hGXSHbBmoIBhyVdJgik34)P9N8E7zO2V2fB9gxO1l9AR(RV4F(gVWQV8hTY1(fT)fVF7x(YKxa1To1l16OxB1Z9moUH4YhR9HbiBFP3P1NEC4yzDUNHGbYrQFLRCYvU2ZraE3t(FDOJS2f)mNxL1N4eRDX3FpdHW4Qx)1j1HGceuT(GJ0(xEENh(zxA1RFksriCrIFx7tD6vU(LBD1lVYvE5vp(XAF(FtRZ)r5Y8GzY2(yVc5LVkQx16uxe)5tIieccWnjQbCL4MeXIkLBGbEWh6bUaAoCEmtY6BDF3(B9fOVwY7upLxbUpmUNgFh5t1AyQwwdgFUNlv1pmR3tEC(XF4g)JUmCOQUzTtnZFgjzZhgs7IlyBuEjYy8F)s)hj0Q04BUDc5Utchm(s5Y0)r2VZPa8iUhhWg3lscBeh0JuCKh0k8xqBuSMHj28cyuV08JajG9WpPHXI3D)n1QCPLZPKVQ1Yl(ilubj8dnSATlGWKta7RDjIygEF1pYDF3399CbKQn1k4tQ2Z8pCjnDc9dVprZJZ04h5Eq)CVwLgmtU(Z8W37s)N)O)3"
        ]]
    --[[wa = -- v1.1
        "!WA:2!T3ZAZTXXrAh)HCfQ7d5CUYvDp(akKYPaobcdqAk7OiPk8TOnFfqiRK44cAbWcIncCxC7Uqsuo6kz54ilzRiBll)kYX20ppNy7CkjY6PDv5xGkx3VGCeGKvD1LQYVGR7z2hZS7SpaiLtsDhTmjWo90Z090tpD3tpZENtE3lF31U7Ap93wxRTztfvz953FPzMEUjwvPQM6IAT1RkFNfRQ1ut)HUl4Nw7OMIrRMsRus(OMLRRPVSKz5wLnvwwUCTvuLwwPAzZg6Ygn0AwBLvR22WuBze2VI(kZxVUHS5((oh8h8HN4oUJVYLKuR2qtFbnfvZkJnXCLMO4xuvdQM2rux8ikTKpyRKb3y0VDNT(AUnX(BvtYuUsBYF(dsTHhlzQu9ak1mBm6iWxhfPPdEstDLLwsw3yUVPU1hFVrnxPL8OTvvm)dTnKll18isRyyQ3w(G)bJ2vKpSSQ5ITRxx5OxQ8yJSyPYlwAKILksE(QJPPwtXurt14KyDrKCWtA0sUzZPRzKOiWtKns4GMf0Lb0uCXfMyMzU1FFfK6K1xTg0TRxVe0j033eZSWK7FMxOTQvNlXLaUWpQTAvtLdlpOK6kT(7KiFUeT8z1Qj)RUJw)tc5v0puezz1(taJwwxvQ5Jaep0Fp7F6qYYTgb6QvnlcCkTgVGKQcYZ0u3zrdtjDZjV1xFuvnv5FVSKH8IM6YQlz24R(f1ARtGQmY20nKb2AnJtIWGKWTYo6YskQqDVv2BnWx9w5U19DR83kBL6kQkgn8(4VagOaXG5BryHjgTMSr1w)pD)O35aJ09v(Ko)8v788VY6)Yp5pEJND9x8dw7A)SU)S3T7lEz45BEHpVZ5E(oN6AR)A)KUpZz7C2xQ7LF6Upbcz3l9wD(4tVXB)uqrum09v(S1FNRT2vo7Ax7NsbE)t)FDItUXN8Pum19mNzJp5DpWiagx)6VkTouuaq159oz3FXfTE4NEP1V(5Ofb4AufjTPK7EUxyTRF5ox9YRDLxC9t)0DV4VQZf)Gc5EGC57(0V0Ax)Dx7kNb6vDo3Nq(8zbcHIastcnWxy0qce7)(0zi)Z3XO11unB91Mux5yj)UTLQbCBPKLkTkiFvcMHyQ0QXQGavr5LqE2)49CRV(xaFTIu1dTempwTwLgYkl1W8j(92ZNMO2sYngTPMuTxsxrfbQ19uXa(ut5r1LuQ9cOKRkiGQ3OIPutqo9EkUCBOHsmkkECp3A8eVacxzDTMYjUecTfAoyXQnLmmiqGpUjGKMng1q5yY4Z0rrvOpUZBTJ75K10kBGDVgJcscMFZxa(oD27bRq)7rFL7QPwvPMjLabSYYQho5EC)OMEYh)4jS)AoOVcLM6WfYvivIek1tQQzMS8u5gDQrsA2qwnrs4hRVVhSMUFp3K64Ks6JLBAitkJ2Y1jt00utoLSjmpzU2lNgueKHaHlu0g3utT9YvK1ria2royQt1g4xYc9R03BTDCV5GFLjvg3QRlB2wxfRp5rYQ1i)L8lGgCBuw6mtYDVhMISicsbouQlYfIyR6msBcXnlo9e5b81paG21(uQjNodhEDr5eGwnHOblyx7xvhesna9oJ0Sj(etJaXK1OchUW1bsZvUBTX)3LxWiQGFnHRKYi1QPPowdjvv5MOidDoRfvMkXyLHYmNwTUwUI29vSgZkByiTKmvHDAHyltYbgiz3FZh05N(SuvaBEIxBTp)T2C1NFZN48m9GzGMfMyVSSjmrUst50p(XZM8XDzyWKPAYhfaYw6lnbSSjpK8kUYomYpMAurU0CaGmKJNHmziniUmdkQcdCj3dq0hRrPdKIrEXTV9OPgPP5ow)KxTZPUE3tF2nEYBU(l(gDVWtN6XqMfw2Mx)x098NHRmF4OZ5(WUx80wktV4P7(6p5MV6Z15CeDYe9Tu0zb2fFLnVWNIG9RodlyB8BEB)yU7BE1UN9Jx7MVjQm)uxBTR)PDoZh09epr3x8QDo3R0z1FrNtDUox9P6CT3J2ei8N)1CGVZtE1opZf6(upda)gF8za47ELFUf8(AlSZ)SNMQOUZN)l38eVXg)6NS7f(TqJ29nVbf)yp3dmF4NdWanecJFoZf)Gn(SZ35PE3UV1pDTB(5GY)Ux)124MF8Ax9naKeuRG16gxHVwF2g34d5QvOT7E3BsGjKC37MIq3V6Vh(SFENN7SwTl9Z(GHL)V5fpXM)YxbwlUZnpFNtFw2UnlBNcw3x6gRFHldGfi)rGqsyYd4Y6x)5PqUXB)6RF5NWpm)4Q1Rp5KJxiFE2U4F8gV2pwNwrxay7CuacbBB87(uOBbytiQOLcOks8q5JDjmOnoXtjeBuMOhycbN7ojDSR7h8wDUX5sUx)yuae(hni9mRXbspqWmYp6T7CLRqXI1Co2NeG8fl8CpXh8pUUzHJtfi6CJt059FgYdsEVgjz5)WxTm77LVmmVL8edaiAlyJdqeAZx6z8Jd6OefhamDF1tcZRDXHFAM0uRF9Z391FdlAMuX1)Dph(KagxYd)0939eaO(gI9wKiUWdCCkeKpYsA(kqy7Npp2mDF6NBTR9o(LzzlnCzwkKRD1FDNp(YcrYgx6tDkseDStRrtOX6CM3G8aCK4E5gU2P1WLqGcy8GQPGD8W6jbWnzQKiEkdgcMZs1EdeBqQUPkQDbiuT00vCcbB0LBIj2ORIJa)oNTZtFzwLFG3j4ALN5nTqlznDaYnENtTXBFtwTGRDL3Zcs)92x7524LTMdV5R9FGF2p)H4QLfmV1NGFMyQwchtRDGU4uJMUH8rZMCKMTAiLHXmCD5AOntu7QbFBOGviBYbzHAjDzW4t)Wnu2K3plCvA2wwaydNn5oZ4AMmTnDmQh(k0I7mtY7l5Gdpmbc72ZbgYd8cLvR5ae(DVWyB6lHWfzfFssZBHFkgiWsT(12NLqGNZmzb8(fLnhd9CBSjNmngJISjPXIiBs0P(m2Dq8lK(ND7GW6y8oL9woBsItG21HIipofybdWy2p48hPPttbmJFAsi0ylZ77aT5jrNI0TajUu2DcA956dmGtmiVPCvZ03Fw01kkRaljnPImUSXH(FC1ujZLZchWhiph(BkBnFmJiovml9Jbo0rHXQR7mK5msr8zUa06lo)(NB8hE6s5MAXYLMU0mtuE(fkn98ZvE(hM4iYZE6nFXpEZ343agO7P2dc1E4D(Tg(BnusH)a1UZzp16x799w7PkoXeZHTDkQM(uUfvCIXjfqxklfth(atpEP9bfnu(8SGVWeJuc63Zobu0GmLSVPhFIjloYStyx4qULHbDOOg6tg6Gg1J9eyV9JE51U55tqhrxS0iZn(ifhVCPj(ELkp58Zvkrnngbe0Rpg)HSLqs3K4z0H0E4IP84jTFmsOunW91F4pCW85hmxPstM6B7mI6ITJ1yS56jSnsXhwsPCPCMM1daH8oUTLrOE7I7VNq4KfN(h8DlvUC5X((f9q39gcyRmB8j4NxMAkTM1k8GPqHsIB)asOpIleoopfQYy6YsMY4JsNYUq35PzexVDbAaXGLsN1dlTKp3doi87qaN0c(jvq5(dcZFTICEQmbszJRy4HWipXBdsEyVtwKQXtvCR0M6bZJ)ND4OevZEHafqBd7J2gwutnC)rBd3302WHtBdhRbVPW1w9qIwpZNed9X9HKjTI8eAEIHp5dd4TkTDGgknL9qBwpZBRA94EN2SQOVPD4)cd44sBbyNZ(Bno0llYToI1AaKGlgWsnz4TRflCgzPAK4mQQ00EnKPnMwfXD6cE0OwhySkaSfiMxmx7LNcJw(SYOfHgPZK0AbkEttOgcOlPEOSjbRujbypBssi1TmiAqR)Mn5X0uby1uXnTllhUumgh6PaE0WqiQym7mObilxrYSi8e6AHE4hk8rzeJMUVOdB)JLPqGX0gTAQaJ9dKkBsxBZ8tvs4Y2jez2HfQiKTqaqwbaaHJieaBUe2HSzycbKWebOOmtHGqzWamwC6GbYggXGGJmaeKbiHaqh0aqen6XpkcaznCkM)qhqjJ0bGLzNHGdqiqm9Wky4(fFWECFpHeI6CkQgY6MbnlkBsj)sfG0fDCfmduSiwit9arfFGBBmHOVZ(zNpWeY)fbayd3V4a9dkAMDLhrwNOElvwYFy3TbO8IJm94P4DpHOdiBY6jvutQ0ssbM4ZVvgSAbS2bR65M2yc1AjLG)hD9zoaW0POokLIekFrmgFCX65QkPwvU5UwSH2rsZSfbSgTXbiZM8WsdH4bjOgXAtuaVQNuxBzIIqhZRrQXR6rBpESXUdUGobh6q)N1TCITFgT4qwk(HNXkxszzz9CJuhKsXvGC21fEz1W6C1LSzKqpkW1Ewa0ruEE1XAQu9qPb)nR7WCWVKt7iQq3yAdbbbal3ELY0IIatgoqPOcRabxPliQyNwIT77beca(31pVqlSRzh4NW7A5ZnyeDoNb(G7Bms12Islatrwe91nThhNX5UsOcPGTrymYuaXJuy)Y8HLxzCOtK2ZI89JKjTTS39rx9jIOyjkutpoVaCSj3iMa7q2tGjgcdzpfWJTs0aCGBESZqkgq(iZn2(MVy5zMyYsW8Q8ogMYwNXAklPpdS0M9M9YwiWpWIi4BxtzjhLHAhi5F44FWvloBCj1GzQ7C9c(IXMyI4Dy2Fjg7wcObW4Fifj4FQPxgmryfu)tT2ztwMlUBKVr8xFhPegFqsDtUdsLz9Y3TId4PIqH0knaPsj3BY8(x4Gd7d4IDHlEybC(EzvdGVtqUnXZq2uZfPnnt8tjpidM)h55sudGe2J1JCiTDNCipeLfCfqxBkmWq5ZwWlNmodlz9XNTBVc5f3GdJn4q5hakp7WBVn5qb0KfYtiY85bYeOZ8B7eAauAEkPsOvGyZVTtTbrU20lHGrk(2ajhenBt0uQgj7Bd0DGeUdLtjDcTF7G4dK6DiFl6NWa2o6bIiwxQnpnB6iK7wU1cwjLIP8Y(xw0YUnCrRXKjLLbuIU)Pxqsh(k3J54A9ZYPCSIyGGItp1(8GblDXXEHzaZtd09ORm94eKt4ctpEVU4MRDYPH(NDQIsXs9CvK0zTEJQl30rrUfaYMlwvxPLz6uZRstR3umMPtPC5MsTmKRXBZoIjtyvrRcfeJfDzm5uTCXWEjgAAYMo19MBO6PC70WcGMzYKqCinCr095ubbGwoBYLLi52fH0aHKzvuNv6OpIuZ2oddEYUqmx2s(VG1ZJVAwmhsDtFyFbTXTlTBYQbcDU2LfBkz22yujD3iGt)xUDMrqTCqo69K)GN7i3frTcmCEdM3xOkd0WJiOJc9pD4gnY(LoeeY1GcuraDM0UYJ1aPrhyYac2GJ0OldgEWmdMyfn5GjuPLafwwELzrTOEJpquKqQ8grq8E7bdaMthLeRFLcQkn93PISxgiXGnuGfsJmJhhuJkqkb2NCv9vFxUHsFrAED6V(MHk0nuWtECQm5KwKovP5xWEXcQkEIl1q1hD(sLMFw7Ygyy8)dav(99Nl9OcPwrOWquWcRNZkHcWyI58L)nCZ(do8HWWrBDCzzQ0RO(CiPifmfdK8j(DioSQm9Q9ShrbQlWogTZzQ1koDm(CUIKNbqz8HF0Al6zFeF2FkMeeQtDR3bb(oocZMzhrfU2ah7T40BHWGY(dgHgmCn2bOXshBpLQA4uMMk42Zyp8N1rqXFmAIIOdCiiMcVIYVWOKCfmYMkGU8FrmE4pfiThd6hgUGN57b8HhoGSujWGglmaY0vRi6ztxpJOUL4Lkdl2YSsiLf6RcgaEMGjsoqxeDOEkWDdhyEORw2OuU5yMRLdB(J0ddAT8il1oyg1c07gADC9XHUavkVRDeQdoHf9rR(e3Cn)bKmC80hzFjofL4rQ4GugG3wCHhEAJ5XXBwBrcXBwpIkZQ12qMeoBxXfMi1pfRDwoWMkt6aoEqz6LMD)T(ZImkRe4kbOuncXv3raptRhPztRPFSYC9u85JCey)T6d(VfLcSEIHxnKuxsUgd7pGWTYhxEM4UYVTv0HkXbyE3j9Yd9VuadeJ22eADC9GzTgCgxXGCoP85HBFn6hNMmxnfJ6ENR5BZK9UGDOeXeQcOHO7dbTrSCrNBprWH7rU7wHZ2ZCvwkkr)Xj7jUOVnBw082iNdrMhEGgYYnTI)un5MMC5SU1oVGB8I98fcmO1rf8Kn02GUJu(uceHMj2vOOH0mgD(yVbFXyj3TRn6lEBjxON2I4SpFmcFIw6maw38QGjShwwmlRmJWLhCs3y9W32pbJhX0gk5AkMSCsYd9TbAWW3sztwHM8z44gN27q2yrN6zLXHbgg5VuezS6POtVjt5A0KvVSx2w3E5eK2VBDCONJNBFYPUIuEtDbxbMiS0jeHQmjIL9oBLuVWLaezwQ3ThW67LRHhfG85gMtP5THTmapamj37EOTOqBki1glDaO)uqSjhBlJccDSmynk9IRKEgd4SrpeMlj0RbE6ICwpoYeGY)69O1(4k(1sl0xtHMS6X8ErgW2VPSdtxlUjSdtEcA7dHNyviOptunoPw129TJebFwViTaUHCwDh2a0zfWiGJs(BIEkeubDiRTPC7MWoAPwTSDJ4gSq2L9ypCAE6P2UV5QUSULViSP1M7PqlgHNngr7m0JT9woUSKzyJkv9q101AnQMEnzDUu)3XAjotMjbHEzTAKfZLu1uxzzy6Bkrjd6wM(eDDbeAwLULBXacKmR7yHX2YZX286bGyxJDKUI56EjCgf42ilHh5nUbLa2RCrvmgZTz10(Nvd97X7lcN9PT)sIUGgv61SUMxtNJDx(MffEKx5XIy5v6e2vIB7419npINcXoDTuC18y0aETEGT6XPn2AnrpLR5od20XW(zOUovigWbzJqn4d)HIaV0D0X4UZPw5PtaHIdMo5cdFqQ9RImmet7(pQcyvzHhZzRzDrm7gZgBUh3(p4Azn1O1TUf0deQf0bKFbmN6bbzbVp(fnfYnZe9rarygJ0l5qGjOtx7WEU8PW9EcS5uqYbe02(h0DQ1IKfipmO5FE9fvoM498VNKV5x)f6L45(jwBbweZY6fxjOjYGf1MMj)1P5sMJ5N2jmL7Toayit)Q)21QBY(qA)LaYTzHtC8CWiPhep6o9(V2wQPI5koNdVY8)dnGOTUm5ZO7AircFSIIATs0G8nfnV6Oh0oMuQZs2hBfVhRa2DGKKL5HSBJ9nVN4Y6Wcgb8TNKcUy5O8jRgZs5htYKqAkYNDzTdmqY1UY1x)cp7MV(QKhWmoALt3UNQuIUQuK)qNHgMsxBBaljVmqmWC6amToT)JHyLLMuHC23snnUavDPQY3h6Hib1UFAuN7wXu(phDY1wsE7blGMaelmN9WJhaP4XqxUCDl22f7QueA3083Fdaq5FqULi)gEU9efQux8YABdRfY36XDrrk2PrtGeCJ08B0kNYdxDhmLtN8G6sjFGPeYe39qM)Y8uIdz4CPeEvg7H)TJKUHlIDEe6hRtbMwNVsVRc5D8Z32f6zL7T5fMSU0gjxKIKDL15B5AHdJbVmUhaTBF8ichyxAkBHJczeCou9CApdNZq2k7TaVrs3KYCslqvPDpbVlwo)zx7Mx0RwoOGfSVNCyUDIm9Q2JAJSTEpwHd3wTcjKIZHjnttmTaNVYpcVoB8F)a4Tk7tzPgnXRhwX1Y6K37Tw(tEWbgc)FVWfJdSifqIkNkKyEYM3J43j3yZyqqhmpBTOUSc8kwgIxS6mCtI5yQSIpmMzeoZlxdWgoa)vm9FKHJZcuIhOeRCJSJy0doasP86khyWHfxF(u00lo4lLxNlblKE2mOzmP5QlzqWTmmpJhMRUHOa1RHV1dFyQFvxXISEobj2MvperFjQ0LryVHto09KUYTyaREe2tL4FDRpXsSpEAt4pmMBDDk7Y(k)DsnDIMbJ0PgrDfuCA7tZd)XlotGvKeIeHvKusWvKSx1qf9Uh1biErtu9au0T1sWtSNfXnoaasi31awI3B82pvN35u0tuE)4RaVJjr6GqpOEEW(w9m7ANiwgEO(x9CH8XxJBWMWgH4hZPGlq1Mrl69)RXxCVXXBzoD8Ctufdcm9yZR)8BC6lTXt(SDF1pXZ8cdVZlCoEu2ZnyOpdAq18hrudpYJgHkpoqYH9uvNg1k8iPJTJXbHiFo8Y0K46H)8pR7BEkp8c3mAXkgmFxASCO4YkWoEVB)RBsUk2dw3s9iuOa1pIGoSThWGc5gwCid80xydgGtI0uWp8r4aVnyK1BjQQ2h5fobQMJ7R8vjhLZsQnL9AlDq4RPgDKXE4PkIxYLP8xXGKuzl3gDw)nqGgtd4dPZNJKvoFl8x0pXjrrxcA9p60RFT3pHGdTLlvi8CBf(51QqbHNxltFlMG6MmXlR2ubK97U2jrIpPGc4gUfqIDEUZU(7)Rt0JNlnZ(5qqYsF2R0sPo7vghKn0P4fefgDHHj5WHh0qTORoJXD49vbR0hQxsmNsr9q7Aj8Eao19(O4TduQm2F9XOF1tTEO2gMk1xzFw9AV9eqA6a6sTstY)aVC41V(ZZACfp15ZaQ4lG13czIf04ho4TKzqFNvpXwNBF18haScUod9gahut(jEHn(43Q7lF5UV(BTLxBZVHDu6JXwm(Ptg861cqYkq1C966Md(L06MIpu0ei5oo64Gt(8S8JWnUKZCLksK7vzUbZt)VV2nFv8g6)L)Tjc4G4JB2ruAB2Yh)AFiWsYG94UMpeWd5qIZXd8svCF3Rxo0mHqS)nhbL8WL2FG8EkH(YDc3MGH3UcpfrGN0I8oil25i)hAygF4how2Bh5ztkg(peXbnktS9ZrucDePdpEtv8y7p2T91xfzLu4RI5MTC4QTHFaRn3Y5cOW5n(tHpHbpiQw33lOLEOP5ow)SlkzDz5YiLeSlBEGYumu(Z3YEoyZIt3iFZMPklIAgnlYeSZA5Z8xhsV(ew5y6IYavXJH9wsPkijPI9SPEkpvJ9uWBtPPQWOHeZmxn0eZHCU2Iopw360F4PXAKNl)(VHds(ktSsqNyYWZlKH758lgtEDuKQO32uzcr7PPwROuDANYWCQn5CMY(1OMhCJNDcV6kNaE2OAhvK2YSyqxA1glwq4BSpSgeLOEJ7xrhhl9EOXDlziEtOSXxu6Cd0JeUtpIN1YSldF72sp4aECb1gG5AVSSUsvpBEhwA4gR4WnCS)HjHPzTcsygvNje8qSYAbDzddEej4KJegACpwMI7nULhzNrmc8ynO)6gTbH8l9VITqoIkoFLo156XDYdXai6G3aDQYnPLjqKMzZXOMd43SGa2uoRgGZEapEkfJ9nK8(ZWBnSoeY1exhYBKIEzl4YzPeGJPcp27HY1ZElAdrW7TMqVweCQ1Iad8ES47exLj(7MONJ8xpSDIEsg7O3pXyks7M1487PiktFM38VmKPTeEdOFZeaY8)vP09o()LUVTlD7x4MyU3Tt5BFkKf3ZcZ8HkMbUb1CA3zQ9aINj5pzmSExHUDijh0EulGGzSqGFijsHRqTTON8(UIxxQfU1u(ZnQAkgEJ0qVLWu(e7fC(V2cBwph7gVin4mxhgN89SeHCULypCDImckJ)8Vx0rJJpzoCVrz5Fn5fWl6NiFDvKGlV05EXXfUmG9f)BWBhCy5wDEgqiODrt818F6u7dMiYw)XAkTCl5AL0GXrzzvgt49M0i8iTKwlYoc6TcZQDyYTPI7Jd6LdV9WCIyLYVcEMt29YFCBDvi1wTfW5shq1Yi4qVwpGKrfVM1toWG5Z75atY(wQx4GzgwqCshmYRQ(0PgBFJuQ8Slov5rgF85NlCyXDUEHYfNFXstuS8(xy8rknr4vyHzg57dGoXCqfMEUPkFG5loZ4EQc)CFSEcotwhgFNFMlxoUqIjtOyW0ap0qqB5ylY75(Sjx2yjyog0pXnPeVhcuRjRpz7MnNJksKJ5KVBhblsvXqCj(DUVO38lEUpL1xQqw83ds(9qKFF)KFpm537K87hG79ov2uKElF4oGjZT0rPd(oE2y3e470FtnHVEUOOeVqELAUSVxbw8nOVBUkS9jJhC3Ma4KgBMnPuYTeG4qFzXQyoVcoxacizf0RFlF3wci1VnEwZe8Ilk(hjlFxQQcUwXcawkDT394C9fezL4wFrWDIaDemtK4WZ5iRxUJt9DtET34393QD9i62b1LJZfPPfj5kJJJIoVJBcqiNEB(PwJg87yF)H2NtdCmWmI5bbpP5(dcyNduhp8dhe8UBTaO1jWoqnkapW23b(lGJ6xy39YBd31RwX)TsZaFnaI)OsCXMD7wWlUPp6T7CLRqdXCQhlBWx0Q2bY2t9zdrDq1)4X)UV15w6Y6KFf0b7uaF0)H8S)UoCly)oS)gNOZ7)mKhG3nXSB7j8vRRW4x(YBEHpN8eRBV4i1SrpXR(eBsdJEpkiZ8yK5SP2nzhKCEgUVs7nfMIwyItzDt3u(aJuCoWQMu9XTpDVD(x3UgL(lUbJV0hueExeVvwgWZ76S)mVoWwXcNaTOX(UQ128NqNJ3Jx5)XBZ0J4Q)xug)TfFfae(EeAnNGCqDc6YNxqAbg4ReGqvjtdGsSE5o4cEiVKhCbk0x2dmh33WF9y4cy4VDiIKi3(U31JV(Th44SJL98nWEu2bht9)BLBG9aUHlc8MypsTGryhD)OKK)vvAmus2d34XBVo15ElxT3qF19YOQdMEJBpblb6EZ4vx49LNZ5vI9ru7X9e6b2FSGmntVmddgs7Cb0rxrKVi0yB6ZdrMSNV3arIhMHCG9n9IlmrXiIqWwrckuXh7MVpLG()8EB9LJzeHoxAlQWrivC7WjsVYLpISUHcoHqU6H6TqDDB(f0Di5gLtytffoxujHdaIdFRF6P39MjQT0i0vQyPH42f93nhS3EbNe2Rc8q7TEFvTJaCRbt0kfiPGYzO9HLPwNuUvztOhwge7kdIIYh8K1rJNvoM8)qfdT26vLROSClnDZwFZGRCt5LKQUs56n100B8fgnKQPDKV381RBiBExVagoDIfYvO2bpyBLAxALcsfRBSYYp0s10pkfY99DoAXp8oGFwvxEjGMrj6rrT9xsrL2C4RcWvRjBizIZAKBSADLJkxJCys(j)TT(Ne0)QA9HBL9pbgk2qtNOmbXCLfhdtrZwFJGPQw6YvvWPA31LQ7Uvs31LyQXxP1FFvnTMa5s2vo78tOH(pIMwTJIBW8QMAvpmDs7Ft2)7uk1A913nDJz2l1sWKhUqUcJEmnTLVZw3DBd5XSq5SA1kIdjfjzD8tCYJyDIOoP9rJQsvn16klLa80bBa5gfLW74G76s0HaIlap0DEN35DTkaynfKbAK4K294dAtjtdLwPWqd9ap49F3gfho3dMB47(W)NFV)3p"
        ]]
    --[[wa = -- v1.0
        "!WA:2!T3t)tUrXvcHFixP6(HCCxrvj39dtPuKs68UkAxJmGJTRB)2lSFfTY4KqOKhjnA1elnJUzgT2leFLXaXFaogSX8HXeaZNhjGZ5KyS9AdvL7Faxu3Fb5wPD3F5sv5VGRFDpF09mDpZiPfcxUSy2vA6x)6x)6x)6371VUN7CY7UXDx5URCIVNHElR6QAkgZVVcZm9CtCj1Y6AlQ3YOSYDAC45Rw1uXAV)lho)hEhOFAUTkQMnRlVsbLdBvSQUrdzRInlAP2qPyLv0KBOwUOvndfZA61RSYLk3Y0sVba7xZyfhuDGF0hE074o(AxrwRCnDJf0v1Skn2eZvyI8FEzDu10pK2IhsTPYbAkjUXiF7oB(n8AI91SISLsPw4)87Dq1evwsPMHCzlvDnZDK30s2W6Eowf9IM6T0QuBuvnvRVZzrFNGOduI83d)gRkjvxVSCDj5wgYfv0wwA3EFu3q6joscj0popkZYkgiisU8qzYMmbUi1QsA6wsfNkZOtnIKvnfn8JHFSF2UDWI3ZYmPHCdftVIuQBQ4cdHIQ2sd3FKMsX6rumMRvJuMwgPDHYdscrzPR1QrjfdakvTLYG4CLRbFzae9M6ERST7nd6xPtMMffgkwTm0aC4(yfTkjC)cQ)5ra08H0s7A3ufz3XWfWWf8AeHnGDDhPfUdpRSQgM)eepcaCN7vTIsQ0m4pi6NyzfnHOekCN7tZqzjvtlfJrQxhEILzKy1EKmaEbH7umWeeto)1J3rj(bFnbR03ivQORnwnznnL6Gy4OQY6tPyZnsIHDSIOYTMwRQEM8o9fOwZQyAkVKYcgkvvpCkUymT0Gdk1538bT)zpxNZC21w9QBE0lS2N9wBEPxyZN8Cj8rkZGAF0e9gkwYwYLQRK6joYaspHNyErvTkkhgbKJyCkmydiDqLv4kaAPtKBtXaGdh6iPDNTLcjZndi3JgXL2nIl841kS)K(e68OZhn5i1T226h76Tp(QDo5P34PU16V4B058Ni5JbCqOSnx9x05CNIPmU4P9z(Wox8KTFTlT55)m0h686p1MV6Z3(mVuNREIop7PBF6xIGsBWU4RS55)eaSF1PObBJFZBZh7DEZR350F8A36nx)cpD7JFJ1w9tAFQpOZrFYoV41BFMxP9L(fTp(zAF9NP9nEpsZaWFUl4cF7N66TF2Z35zEwe8B8XNcbFNR9A2WZT9GoXZDY2N5YRT672(Z(LBE03yJF9t158)wud35nVjPnGEGpy(WpdbdQXay4ZLU4hSXNEU2pZ725T(zRDRpB9x8d6S6f24wF8Ax)nqisulb16MxJTwF6g38dzQvKT9E2JeIHiTRDrqQ3x5tPp3N1(5pTD7t(mx4Oht28IhDZF5RS2n(5TV15AFYtt3fOhkiG15LU56N)QiWcLFXrakkzLnE7Nz9vFbc0B82V(6x9j5d3pTC1Qto54dLnln5(hV5f(PgKk7banHsaicmUXV7tqKicJCrhPue6IfUi82oyM2gh9z4IrcJ1hmrG3Djrgx78bVv7BEgP9eeRCGG)OeMcThFWuIGzXF0B3(AxJGn75P0pje5q66W8eU15jmSg6ieHM238OTF)Nf)aP71uIECb9vcmDE5RIMVJFIjcisR4GdKy2MV0ZgehKrpcoqW05vpgsFGho43)Xn36REUoV(By3)XvE9F3ZdpjKXRSOF687Ese4bg(9xKioY9Fecu4ps3nduGq6iBwO56CINFTB8obLTPlnAzBc0RD9FD7p(QCr0gx5tClsuFAh2JYOgT9PEd8dGrO7LzyCh2dJCbkKXjIMg6Xj7NechMQI84ZuyjCUnzvbuNx0scKfa8aisT)Kv0cbJKLZ6cmsSAaQW7C62N4Q0krBF9RcRjFQ30g1yBiqqUX7C8nE7BrRnDTR9E2qYNQVWZVXlBpVFZl8FaFMp)6v(01FNByd3BDz4ZjySL21Fb3ALFQrtvt5Wdins9M1Kt7Z)cdLkGnCeNfmBvIa6qdinSFixYqbz5Cqy3(as3NFylvVLchqZnG0os7zZpPTD9yb9vulVJ0sFxPHZLZfkN21fo8d4bPDR6ci8DA4OTBhZme5IIeMuSBhcwWW7zqkTJAHupU26lyCArfRXQlBAo2KtMc5DnQnb)HvqoUzTstL00ep8amT70Ua8mEMqggkoGuzaL01LGuoEazdlIbUpKFYysjfb40I73CRfqn8DyIqwL1RRBGjzKuCsAIJGRa0gv1WoCuxPSvQ7BaWVtcldkjfUY(8RLPP(PLtkLjJnEqFa)C0FtsR5LA00TYdq(yKd)eyP6sbg2DhTXHKyievT487BUXF4PlKzQflwy6cZmrX5xOW0ZpxX5FySNyp3j38f)4nFJFdYHeoyyyegYTJhm3dUDjU)GWq7tF81VX7ZddtLFIjMdOHKKvIsYwC(jghxizP3K(6a7F6XlSxuXBpBw)vBHjgPaQVm7eOIh2xP7D6XNyY8Jm7eoaSD2YnKvRKxhCyf8ELeAKeo9Kp6Lx7wNlHNeXIfgzUXhj)4flmXpOqXjNFUc4cRO7tGdCtMYFrAjUu1XEpEq9hoFsoHSiylG5i6AwM)4F8WzZoCMcfMm53JrYWdRpETXMRRX6i5Fyz1IfYyzvneeh0z3TeeB0k)(6Aepz(P)rF)cflwCSFyEo8JUhr(rcDGIy1fKCk96vg6bscIh4ySGqe5rbI1MBjOQnMHISLc8OujDk0t3qAX1DNiT0qaijACqltMnZdmm63rufClfSRJwC6bq6lSJgBY0c7LJRA6RtIFcVgfxqV1fXvLThYyfrYhil8F0XoKxTJBNnK(AUa91CIAYC9EFnxF1xZfEFnxSgyNcSvWx31(zCLOif1JsWKkZ2PZIn2lBuvOF7N7VMADfF9t7NXRLTlQ36N2voWuv4FrvH42pJWwU91CCevNNzTmQ1DWrfwWsEPdA3paWmkYvWbgwtTo96xtBoTg0oPgIJw7QiMVkQodHnvAUwnMYqVvZzvaRJntLMEHs2XnIHmgYAhCajK17lbvBaP6klRu32GVHT)7aspUUgcwDnyJLgia(unhhr5iCPdH9v1C2zaJPAus2kp6jK1L9XNuthelvjgRfOh68JTjEihomBwxfjRmyYbKyTdnyVugmViHKGFSrjMvieiGfHacZPecKdheiqhMPqGXmzeKeMTqWidci4Shnchqh4edgmkIGcpykeiYGmcmrJ2SJ6iaTh(fZ)icbyPJqW2SZGXfs4rC)KwOY7lCH)iCFkERjYOQzQyyjA25asY8LOqsOezbKjVIftdzAnsmJBvODFs0ZymqY3()SiQq69(H)U(GuUn7kpIIbw1AYbW)HElOqLNFKPhpjF36W6zgqQQKQMKAtzvKYf298YVMg7TlTAMPnNqRIKm6)b3hNdbCQKeNotI3whEmlUC3QzklRvwP(oxSM(HsXogfWiuMk4Bxd933IHN7ivy27(MQ2stAO3aRqMJICulYaleScdQOe0ldBmimzWXPXkwqTHIrMrQIeHHLbD3ko2(CyezvzAoiIYICbWfqkBkoV2y1vlFWuih2RY40f8Gm6hsdrwtBkismamolHNIxOYshaCckHkHXzQHebIBR6VR5dmmq83BzE1Il56eXUOj3SzgogemJaJy6130aAj6fqZVwecEqkFrJaucidA6I2aNXWZDepcd0R1dRSY4iclfhlt6fjDsB6Sp3EkQcm1MIJitGE6XdoXORyfXutGlBzcny2glBzk04sbD96wQnHb95bcedcQXgzUX2785loZetwanholJf501BS6kYgZGw7LoLeObaXZGIX4DNtzlpMMy8l(FG8t4vno7AoXRbIVVDloJXoOd4oh9Ve3cuc6HmW8qQYO)PLQbY(MvaDGvAnGuXabwf)eCGq2wsHbhgJdPTHrI)WO4HGb5GaeaKkpiUYs7rkl)vZyAPbzBjHROzxPS9ZszOXlCJ6WO8XIi2ntilQaTJFqAitPYgi9LqDZDt9yxwWUGihYP7BxJHqLbH87eVE73)zhkBwEdeXz0DaUdtoKWqzdJgYrObGoxB13DTRDQCFrrh5YgbVatiyQLqjWh)cKLekpbtl5YsZv2kPfrCapwafpylRHJEQHQLsd(k2TTObu3oMcU80OP27B6fKnqFL5XbyR96Icb4uXar5NEQ9YbtuAi6QLAqTY0iEYORm944gcZHME8(rnTNvNPq0Df0JHV6HXQzkjB432gIMglg1m2aQyTyzd1MwPsoVgjNrtszamH7OuxUPPsfwddaSzH0XBxiNDJYqPHSQJr8okcjPQAQK3BMTxnPxhaPc3knVC2emOZdrFx3kWb0Idi1qgNkD4UgsOAwvTzLp8JixVfZqevgHc5rO0)mup2jvomhCDtTCA)ls5rs7cM7jYJlhwSLSvlZrLn8cko5Fz2rAo1Yf5GFjbJNoJSzi1syK6gol3OmhIJGc7hd179d2Gn2l9dorCuK))ciMuEYJvqsJUWKgjypuASb0M(WmfMOfnteQeIqbKgRmlO5LNl2Hr2jZAgrh2pfmiYiXOKsdQiqtTE6ersvcjEaXclKeydoURXl2dcIclOeQ6o9Ia(IKuJnyZzfQG02fpHWTY4uZpvYcZVGZIee15yNjrvF05luy(zDkBWCW)lavb9aMjBWcPw(ucWlkWvZyN)cqiJC)Y)gKhbIJ6gID3YawkMinYJgdjRVqttqsYylCff5pxcz37MxCScnCGvZyP3moegBkKHtBbuzSrQZEh9PFeBcXYVlWvVy)tGi(omI6pjscnYLuC1(mIGU74mQnGGn4eEbBDIDvg2bthQRc7gIZq9aUcf8JSqOHVve7oMcQ8stYOKs5mkMmz6VAW7dMXMo87EH5YtIIniOcsgfHHgnqisjRGG1nMQAAEKqOXtosZGPLckk0Ndic6uH6cFCNW6f9vGxm2PEONMZ4OWY1euB)XcgVakuB7TvYT5ButOhkK655NczXMK8mgmshuclEy20hZCSGHilAC1djhkm9e79P4WMfIhtmb2CAZ5b5b)2wedpy9jwnREltfCaAzfTOIn9u02n5cFY0PeCeSs3lKW(A(NvzBAj3veO4ncXCb7KcrnXi1RBpf2VCApf95ihH2xZ(y8XMdGgAWgKvtwBjLk(gEeeeq2io7lAGSB6dz4uC4r3LKF(m)LzOGA0wwikbwVzw7bXXvnXhjnUztqplTeNMotfvZQ8M)YDVB5zmqODSj0e0VIMMIAVozcf4UJXOqpmc0VC)EIZ7VxMO)42DnNMU9Ju)qSMFINRV)Akk1TJJvfL6wbsVF79Ja2oc65Iyybl6gItIG7uLTLuOYNi0qsVQkjCRDrhRR26SyA6Ww5wOf)n6k0d3sC3bnFcZImbiew78Ait1xwrmlTOpHvFTH3wKh9gSjy8lM2pQur1IMJJFi3TGcnKV0asLi52gmwhyLMi2kp36BNaKrgo8Vuf7SPEWjFPKEgpAt1D7gU2nhQ4(zJDd9Ox9LN8UNOiVKtWtqlcR8crymDIUYwVTIeUWRtjYSDEBdI9ZkAPxbolfzZKlGA8Va2Ge4ekjTND70UCxfhxFs5dIORH4Vm)w24uGXRW1x1loT7BekGxnHWWXbIoYJhMRfgXkXQcAjd4ReyltLuc9WNRr9(CosKj(9AA9qrIDBs9qLSIoEJXjArC6dyLXtQxU1wIlzHFO(WTiSDM2KO)WHAh2oexh)3eDDWafDY(D4k0nLtCQTPc6gZluT0lqtFQe5q5oomZQ0UQThE(tVoVJFymduEmI9CO3DaBjrjhpRDu5YhSIHEZr1nQOyWC2jySjmGZf4ThOHEfSPiYA6AR0aPEiPODRQV7V8UBlI1UG23TCiH7pWgwgclnBawkpFN4hOcxjYyUcDcMrjMTuK75zmWGMGmxGxL7s9g0A7)kJlrD5fII7oO3)jWxy2x1lPFoR2vxlm5oRm84YZIPi33Axr0y2M(DmMJiUWwIydayvsmBm)wfrJIUP96)MRVsiFxHfY4F)iQuLm5aHl8wKBgmywQcIJIREoV9w3otUeeCw0uwpycU1h8vBhwdq6spQkYc7HEm3nX3Rb8Vf(9exoWUG55hINr99VNgdgQNgcYafQJzIGtzadbssdFREmMTrACptNcTwJ(Y(UA4GD9ez3nN0jruEMi6MWBr8I5lJwnAEJfvFC(znsxpxWZwbevchiReXzdzJXSYEXDlsAXy3ZtrLN)KSq01CBNuQZ760azmw)U2HNhi4Df35lHKl3HorlbVtFjjFd(xBjxx1Af3dFzr2)bg)0Yqb)zWLxOJJ(yjvTkfiHXDkswAsozL(sqt75hqlX7iAqVN54SWpK9hVNhxWU)NtWOd3DtNZ1ijl)ZUXTvQsLgt4Mg)zpw(GdkT21wD9Z)CB(6xY9H(gZTZLDVJJmwNxs8FiZWdtPUJDUfuAG6KiDcH4ErQGNh1slnPk(qnMCAyrYQYLv(UGx2y079jadWrlvRsYGhssLklPS1GfK2eal(oWPhjKUKpd7dKnLDLVaEkAr0rk2lJeeGzFGalp)T9DxRkoDf5Uu6w46WSus3UGmPvirWbhGPubtFagftE6L8bdzIiO)g)bFLIvgSBSobFLGDIfMFMG3Ib(4ZBtInKE0ZjH4cWUeV9HU1)QH8g3dSz3(SIylErs7R4v8vSkopdC)wMMWWTytk8bOt7dN5CHK0uocrdLMZHuMZX(nAoeoHn6dEKSHfHjLke1Y0ugCPfDUtV2TUOiTPiawG(sPYtdBjl)Qyj(d4OJLwiILAkHdt8Cq6Lvhse25l9tG7iQGxMf8Q2EvxQwD0)BXVM2xpe8QzW0MDWTd)ppyJ5bzLamw9wjCCTPZ8x477xTIvniq3dN1FnjU(J4H0mkEy3vebhh5KdW)G7Mw4m4m1q2JIANswj66fkfpiYxjkEpyjhLgOxZQBEWHZjghSjTSF8WwAq98ymHPYzatVsXuF8aJxzqg1Nlq9JqznpJ6Rg9qyVQgKgH9uAd9fGANiOP4KSzcPkg5vVtgnEXh)6JOp9P)LLEj7PkXxRe7bXDRt30oDUiYNu3aRDXmvYr0wbe7261IXE80thALXHEIBLXLeELXzwbQY(ZMIqefjh9dokp7)0UgOUyE9xGanMx8f2tr24TFM2VZXj3Mb9JFsSoNflNJ6ILegUVwsGEDCat52E)TKWqz7ET7HBEEeIUuNr1qvrhpX2)6knXJQCJWqahByM4lgm00Rnx9f24KxzJN6568QxMZCkt)ZPCpSIoZR81Nnjb0KFuRn9jhBgQC8Gs54uDxcWoeuPIDGfcdzbcwGVMgwR(1(0oV5X5DICDZPl7yE99jXoJGt7aPX7CYw1c)oQqSoRQXqrfchreiNT8GWmuMCHhggF0eDWvCtLSH4xNyeiehqX2dGvfUxfWAfqvkZxdwTmeoogde2UJueMFNC0rg7HNkpCZ4MKFLdt6Mggh0A)3qbCmDe)jv2m48u7bHFr(uajqYsHR)rNC9B8(jeCSn96zcp5MHFQnhAiHNAtRalOb6)SGBy7KHC2z8S3dhlzbfYiEiOR3(5p96V)VorpEIvT61J9mD)2XsasV2zv7HPd9nCtSbrSjhopL4GkI1QvPmCfURvOLCbDFI5IQAhCNlbxU5jV3hfU5TsM25Rpg5RCQ5d1Y0sT6k71UhWJQqsH73qUzkCUZWBey9vFb)goY2R5ACy3jC2xcO8fszhYyTeByUh7F(EO48EpjYtsCG72uEbrdwr5ONDJp(T68YxTZR)wBzR9g0Ovs)MYgZGtrnz1NkqQmu1RD7A7d)L8A7IVwfWqZCPwadGzZ6NhfTr0mMDvsgFPXhyq)K)7RDRxfELO8Y)2WUEpGnbloA12sUyhcGeBPi6dEF2iQsexdfm8g)9sMVlYtqs29eUpGhcKCbtuU)SCkTgwYf2gPCB1Hpep5b36bdcbFNjdEnhqfZKCX2)JipLLX03QioQKP7k)b5LWsXYXq)hEKU2p2V0ShqKvGrVARx2Ocwje9vjH1wso4YDEi)0LvyWBIIsc8w5QljJaxAj(x00(29Ms6kCxF9bPLyizZf6Uw7G4uXlG2bIsO4OHGgPC212SP))Us(Cf0zgqeLX48hN7(KixqYe2vZm768kp2tP)cmTY5gzQUitZJ82ebFsEJxEN3)8JOt78yDzZ07eGi5W4FZH0fdgzfoyWjtb7IXHO6(8EvgMogAQT0Bgh10ohbaSk6aoE68(8Kd(HZGLF9YtGE2O6hMNM5bGaG1SfuSGWP5CWVWkS9h728UoN7)Q8WRKTh08phCgL(9q9qJ5ePXznvNYhPLLo5agXXnEhGMRvdfd1YC2CyaIOnYYLl5A)g1HHG2koUNwI0rGlS1IlyOyAYImoNeTOqL3HvNpv5vESik(iHJ1TbRF8mWL1KKvCMuaOlGFKh)m9WogdycjQb3rOAk1jLjyQa1MUsmzHVPlc24x7gIXMfoErgJ9Pg)YmIxTSVMhQWVE4xlq9Yw8MXwPsaMoQiExRb(2tBhOcF)B56bhNZABmWcR3BbonOP7UDW23HyUl3cBFhSI4Th2DXucVtfczFS9pN4uV5x9Mtyl8lOFqfe5S)fZSJT9xND8N1zh8NCGnH9lJ5hbwmGpvgLjpLSeMafmRUqHHbfpBmychz)s1EREwqy5rbhgbLvnbh2IuGKRnrDD0lkXlCec3Mt(5pyfvtErWP7tSWatB4CMu3csYeMHc4QtkGlkOXs3NNiIZij9HbMNrCP5FUB4DmEztuj27I8GVpxd5n(wKVNGsW9COe4TyA4Yoox38HNQcHD2jY6dmm6x0c1VLtLCVOj3(XZy1LB0uPsbD0yUIIMp3y8NSubBGc6nX7enVkoR(Y47Dl2IeKFoSIgrMY(CEMB25h8kiWt5xlTMioBkbvnDixcavfKS4iEcKQzzZgYHd3UppXY43c2Ceas7hm3uTe(cQfhBVJuO4SlovXrgF85NlA4HmVyHI5NFXctKV4(wy8rkmr0vAHzg5hIaFI5qvA65MQ4(Np)mJZPAS6yG6Y5CGUm8c0otMmmhvnfmhazwJV(JOlZKMgkvvp8asnmxcn)frRWgKd3pmAvumMSv96ZreDY472gbIMiUQqih5ERLW8U3MFexKnwAObGFpm(3Bh)77d)7C4FVd8VVFMxAHdKetTb2Z)MgGKdlHpqSBI0iuax0o82ABmkHRgE56nc8(tKTbdeczO9XJhm3GlWKlhMnUu8nYsyPKa9zwY9INb6wPfuHa3snqVFl88TY5Ttx3DKpzoROcUSl5gTwOFTND7ELWezLywEHZDndzemDK4GZzunUrmLjkNy6p(KF)s6rq2Ii5y9kvK0L8KXHrr339yceYj3dTAviBerStB7ECAGRbUrmpq8KM7teWUhoxw4ZjcEVT8bP1ribuHaW9V1D4H9DSH5TXqBb3K52XqVu9WFFXIdpa92Ebx9EF0B3(AxJeU(KpM43EPUBmGV6thUFr1)ijcHQlsoi5rCqW9XZ4FGWP)jExS7dzFP63(MhT97)S4ha3O(0Bpn6R2x8(V8v388Fg(j235(Ho1NC64dioKcnk9OizHhdpxm5UW7qN7ZG9TBpjH0besop7BlSI7FK8ZHSyjzpSDvD3zKFRy05RmdaFPoiWnT77h15(Exs(Nz959JLkcTmX52s3XmMqNp3LVWzIxcmeXlEgEzkAF(cOj89r1EUa(aUjA3P5KgPIFH04fCLy9kdYd8qE1b5buOVcHOow(H)swYdWiENdT1UMz3PN6(pc9ytx)Eajq8CcxpDV(()iG5kr8EajsnxrydBVOyJ91bDmuS1f386BTou5DB7TNiFNPBREcnLe2wd6oO3naAvU3lOUNNo6hrSfMZLmk9p2qNIIsttHLuUxMMKvYylcm2L88qKj767kvGbGMjS)9o9Ilmr(i8qVFKIcveYP57rPO)FN3oF5SCFOZF6bLmFH5KwyYDpIIHPkiWRu(GDxOK6LBE4zxb1E0QqCbCz8fOjNvC482YWnSK8cBkOeWfa(HiDl7M3kKTGq8rxTA3tEbjXHJ)Rolr7bsKRzk4YjmDPQivZM1sCmKTQlTes(zUVJH9hFVrHT4E0wift)HwMkfLRFi5vmbZPoWFWSvjOJBTyRQvvp8vko2ilwOiYi28fYJF(LgtxRIkqNMhdQlGKdCmZMk1RpDfZe5H7OnZeUOzbCaJZJ0loZm3(BvIiWFPkkLqOheFn27eZSWK7BMZ2sZM4sCfKO9pbZ1wwzyzTvA(3jJ)Cbs5ZQxr5xDhn)hrqbydmhTiX4PInT)qEl0yqL)KkStCAY1TN8C6)0bvuAocIulBLhMaw7yhY(iLDmNZwwECcs(q3f6herAkBbtvvQ95M1KROFOF48vRAQy9pDhJwfzAFZVXKgQpU03VLCfyRGKku4sOUQsf8Ht6P)B5sHLT)WOAivbLiBg8t(hKBzPJEOAzCvhfsrUrRRlx5LaVmm0B18EkzI(uDLrblmplW2X7puTswY1rm57jFJw1TutKVmKmX3ZThlXzbalAOxxjXvaWTXZbgf69yaGNQHqIrTrnvFCf4zJQwwx7antYLZcS0Ii9ufbgYbogWaGTl7BwYuVLrzLsQnAQByDjeAT3sthM2pGW0URZcBHb2BMseFwgULALRSYqY5RAUsJhAPkn)oIB46kljxELIvRRRBu7sgklHgpbXNrHv(VIQgbA4fe8OOHTYn)F68rVZ(hPZRC52V2LA)cVY6)Yl)hV5ZT(l(bRDJFENF(725fVk5TSF7Z8cTp(nw)cpTTN(x9eDEsaYox5TA)XNeopDx4PjyGC)oS21o9A34NraEFt)FF0JTXL)e73x)N6uBC53D)JGW46R(QK6qqbcQ2V3X68lUO9d)KRS(QNHuecxKnmRZzo7ARE12x)QRDTxC9tEIox8x1(IFWqzU)mz7CIxI8s9grvTpZLXF(0Oocbb4Me1axXMZnnAaS0qBF73)dCFxcndmpMpz(TUNB)n)C0xl5EC0(CKexnDJ5BINhNO53wmNVPHszvy6ZD9NqUjHQeEPyG3xAXXGe7U5DJgZhdnMJgR1qtoZdYhJ(466nUtJFcjz7hfsZIlzPxEzYmX)ML)ptQwP5F)Ui9(9qyOslpuMSxPQ3MREx5LHBNM7kp(Gj8KNvwtLmiVJB)nM82FZB)G)EfztawfTLSQ91)CN1vXjWJHPcIzuX8yama5E7hCuWAvCfVDJV(T1UT(TBI(494)jLq1RQ6sjqt(a6vPwZ)HY2DpG)4K3s1Ucr(g7l8dDN35DExxQSRQXehZPkh4ku82V2DBMpxMhitU7E5)RFW)7"
        ]]

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
            GameTooltip:AddLine(L["v1.3：修复有部分玩家不显示拍卖界面的问题；当你是出价最高者时的高亮效果更加显眼"], 1, 0.82, 0, true)
            GameTooltip:AddLine(L["v1.2：现在物品分配者也可以开始拍卖装备了"], 1, 0.82, 0, true)
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

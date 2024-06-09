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

    local function Addon_OnEnter(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
        GameTooltip:ClearLines()
        local c1, c2, c3 = RGB(BG.g1)
        GameTooltip:AddLine(self.title, c1, c2, c3)
        if self.IsAuciton then
            GameTooltip:AddLine(L["需全团安装拍卖WA，没安装的人将会看不到拍卖窗口"], 0.5, 0.5, 0.5, true)
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
            local notVerTex = ""
            if Ver == L["无"] then
                notVerTex = AddTexture("interface/raidframe/readycheck-notready")
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
            GameTooltip:AddDoubleLine(notVerTex .. v.name .. role, Ver, c1, c2, c3, 1, 1, 1)
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
            if not BG.IsLeader then return end
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
        do
            local function NDuiOnClick(self)
                if not IsAltKeyDown() then return end
                local link = C_Container.GetContainerItemLink(self.bagId, self.slotId)
                BG.StartAuction(link, self)
            end

            local function EUIOnClick(self)
                if not IsAltKeyDown() then return end
                local link = C_Container.GetContainerItemLink(self.BagID, self.SlotID)
                BG.StartAuction(link, self)
            end

            local function BigFootOnClick(self)
                if not IsAltKeyDown() then return end
                local link = C_Container.GetContainerItemLink(self:GetParent():GetID(), self:GetID())
                BG.StartAuction(link, self)
            end

            local function OnClick(self)
                if not IsAltKeyDown() then return end
                local link = C_Container.GetContainerItemLink(self:GetParent():GetID(), self:GetID())
                BG.StartAuction(link, self)
            end

            BG.RegisterEvent("PLAYER_ENTERING_WORLD", function(self, even, isLogin, isReload)
                if not (isLogin or isReload) then return end
                if _G["NDui_BackpackSlot1"] then
                    --NDUI背包
                    local i = 1
                    while _G["NDui_BackpackSlot" .. i] do
                        _G["NDui_BackpackSlot" .. i]:HookScript("OnClick", NDuiOnClick)
                        i = i + 1
                    end
                elseif _G["ElvUI_ContainerFrameBag-1Slot1"] then
                    --EUI背包
                    local b = -1
                    local i = 1
                    while _G["ElvUI_ContainerFrameBag" .. b .. "Slot" .. i] do
                        while _G["ElvUI_ContainerFrameBag" .. b .. "Slot" .. i] do
                            _G["ElvUI_ContainerFrameBag" .. b .. "Slot" .. i]:HookScript("OnClick", EUIOnClick)
                            i = i + 1
                        end
                        b = b + 1
                        i = 1
                    end
                elseif _G["CombuctorFrame1"] then
                    --大脚背包
                    local yes
                    _G["CombuctorFrame1"]:HookScript("OnShow", function()
                        if not yes then
                            local i = 1
                            while _G["CombuctorItem" .. i] do
                                _G["CombuctorItem" .. i]:HookScript("OnClick", BigFootOnClick)
                                i = i + 1
                            end
                            yes = true
                        end
                    end)
                else
                    -- 原生背包
                    local b = 1
                    local i = 1
                    while _G["ContainerFrame" .. b .. "Item" .. i] do
                        while _G["ContainerFrame" .. b .. "Item" .. i] do
                            _G["ContainerFrame" .. b .. "Item" .. i]:HookScript("OnClick", OnClick)
                            i = i + 1
                        end
                        b = b + 1
                        i = 1
                    end
                end
            end)
        end
    end
    ------------------团员插件版本------------------
    do
        BG.raidBiaoGeVersion = {}
        BG.raidAuctionVersion = {}

        -- 团员插件
        local addon = CreateFrame("Frame", nil, BG.MainFrame)
        do
            addon:SetSize(1, 20)
            addon:SetPoint("LEFT", BG.ButtonOnLineCount, "RIGHT", 0, 0)
            addon:Hide()
            addon.title = L["BiaoGe版本"]
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
        f:RegisterEvent("CHAT_MSG_SYSTEM")
        f:RegisterEvent("CHAT_MSG_ADDON")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:SetScript("OnEvent", function(self, even, ...)
            if even == "GROUP_ROSTER_UPDATE" then
                C_Timer.After(1, function()
                    if IsInRaid(1) then
                        C_ChatInfo.SendAddonMessage("BiaoGe", "MyVer-" .. BG.ver, "RAID")
                    else
                        UpdateAddonFrame(addon)
                        UpdateAddonFrame(auction)
                    end
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
                if prefix == "BiaoGe" and distType == "RAID" then
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
    local wa =
    "!WA:2!T3ZAZTXXrAh)HCfQ7d5CUYvDp(akKYPaobcdqAk7OiPk8TOnFfqiRK44cAbWcIncCxC7Uqsuo6kz54ilzRiBll)kYX20ppNy7CkjY6PDv5xGkx3VGCeGKvD1LQYVGR7z2hZS7SpaiLtsDhTmjWo90Z090tpD3tpZENtE3lF31U7Ap93wxRTztfvz953FPzMEUjwvPQM6IAT1RkFNfRQ1ut)HUl4Nw7OMIrRMsRus(OMLRRPVSKz5wLnvwwUCTvuLwwPAzZg6Ygn0AwBLvR22WuBze2VI(kZxVUHS5((oh8h8HN4oUJVYLKuR2qtFbnfvZkJnXCLMO4xuvdQM2rux8ikTKpyRKb3y0VDNT(AUnX(BvtYuUsBYF(dsTHhlzQu9ak1mBm6iWxhfPPdEstDLLwsw3yUVPU1hFVrnxPL8OTvvm)dTnKll18isRyyQ3w(G)bJ2vKpSSQ5ITRxx5OxQ8yJSyPYlwAKILksE(QJPPwtXurt14KyDrKCWtA0sUzZPRzKOiWtKns4GMf0Lb0uCXfMyMzU1FFfK6K1xTg0TRxVe0j033eZSWK7FMxOTQvNlXLaUWpQTAvtLdlpOK6kT(7KiFUeT8z1Qj)RUJw)tc5v0puezz1(taJwwxvQ5Jaep0Fp7F6qYYTgb6QvnlcCkTgVGKQcYZ0u3zrdtjDZjV1xFuvnv5FVSKH8IM6YQlz24R(f1ARtGQmY20nKb2AnJtIWGKWTYo6YskQqDVv2BnWx9w5U19DR83kBL6kQkgn8(4VagOaXG5BryHjgTMSr1w)pD)O35aJ09v(Ko)8v788VY6)Yp5pEJND9x8dw7A)SU)S3T7lEz45BEHpVZ5E(oN6AR)A)KUpZz7C2xQ7LF6Upbcz3l9wD(4tVXB)uqrum09v(S1FNRT2vo7Ax7NsbE)t)FDItUXN8Pum19mNzJp5DpWiagx)6VkTouuaq159oz3FXfTE4NEP1V(5Ofb4AufjTPK7EUxyTRF5ox9YRDLxC9t)0DV4VQZf)Gc5EGC57(0V0Ax)Dx7kNb6vDo3Nq(8zbcHIastcnWxy0qce7)(0zi)Z3XO11unB91Mux5yj)UTLQbCBPKLkTkiFvcMHyQ0QXQGavr5LqE2)49CRV(xaFTIu1dTempwTwLgYkl1W8j(92ZNMO2sYngTPMuTxsxrfbQ19uXa(ut5r1LuQ9cOKRkiGQ3OIPutqo9EkUCBOHsmkkECp3A8eVacxzDTMYjUecTfAoyXQnLmmiqGpUjGKMng1q5yY4Z0rrvOpUZBTJ75K10kBGDVgJcscMFZxa(oD27bRq)7rFL7QPwvPMjLabSYYQho5EC)OMEYh)4jS)AoOVcLM6WfYvivIek1tQQzMS8u5gDQrsA2qwnrs4hRVVhSMUFp3K64Ks6JLBAitkJ2Y1jt00utoLSjmpzU2lNgueKHaHlu0g3utT9YvK1ria2royQt1g4xYc9R03BTDCV5GFLjvg3QRlB2wxfRp5rYQ1i)L8lGgCBuw6mtYDVhMISicsbouQlYfIyR6msBcXnlo9e5b81paG21(uQjNodhEDr5eGwnHOblyx7xvhesna9oJ0Sj(etJaXK1OchUW1bsZvUBTX)3LxWiQGFnHRKYi1QPPowdjvv5MOidDoRfvMkXyLHYmNwTUwUI29vSgZkByiTKmvHDAHyltYbgiz3FZh05N(SuvaBEIxBTp)T2C1NFZN48m9GzGMfMyVSSjmrUst50p(XZM8XDzyWKPAYhfaYw6lnbSSjpK8kUYomYpMAurU0CaGmKJNHmziniUmdkQcdCj3dq0hRrPdKIrEXTV9OPgPP5ow)KxTZPUE3tF2nEYBU(l(gDVWtN6XqMfw2Mx)x098NHRmF4OZ5(WUx80wktV4P7(6p5MV6Z15CeDYe9Tu0zb2fFLnVWNIG9RodlyB8BEB)yU7BE1UN9Jx7MVjQm)uxBTR)PDoZh09epr3x8QDo3R0z1FrNtDUox9P6CT3J2ei8N)1CGVZtE1opZf6(upda)gF8za47ELFUf8(AlSZ)SNMQOUZN)l38eVXg)6NS7f(TqJ29nVbf)yp3dmF4NdWanecJFoZf)Gn(SZ35PE3UV1pDTB(5GY)Ux)124MF8Ax9naKeuRG16gxHVwF2g34d5QvOT7E3BsGjKC37MIq3V6Vh(SFENN7SwTl9Z(GHL)V5fpXM)YxbwlUZnpFNtFw2UnlBNcw3x6gRFHldGfi)rGqsyYd4Y6x)5PqUXB)6RF5NWpm)4Q1Rp5KJxiFE2U4F8gV2pwNwrxay7CuacbBB87(uOBbytiQOLcOks8q5JDjmOnoXtjeBuMOhycbN7ojDSR7h8wDUX5sUx)yuae(hni9mRXbspqWmYp6T7CLRqXI1Co2NeG8fl8CpXh8pUUzHJtfi6CJt059FgYdsEVgjz5)WxTm77LVmmVL8edaiAlyJdqeAZx6z8Jd6OefhamDF1tcZRDXHFAM0uRF9Z391FdlAMuX1)Dph(KagxYd)0939eaO(gI9wKiUWdCCkeKpYsA(kqy7Npp2mDF6NBTR9o(LzzlnCzwkKRD1FDNp(YcrYgx6tDkseDStRrtOX6CM3G8aCK4E5gU2P1WLqGcy8GQPGD8W6jbWnzQKiEkdgcMZs1EdeBqQUPkQDbiuT00vCcbB0LBIj2ORIJa)oNTZtFzwLFG3j4ALN5nTqlznDaYnENtTXBFtwTGRDL3Zcs)92x7524LTMdV5R9FGF2p)H4QLfmV1NGFMyQwchtRDGU4uJMUH8rZMCKMTAiLHXmCD5AOntu7QbFBOGviBYbzHAjDzW4t)Wnu2K3plCvA2wwaydNn5oZ4AMmTnDmQh(k0I7mtY7l5Gdpmbc72ZbgYd8cLvR5ae(DVWyB6lHWfzfFssZBHFkgiWsT(12NLqGNZmzb8(fLnhd9CBSjNmngJISjPXIiBs0P(m2Dq8lK(ND7GW6y8oL9woBsItG21HIipofybdWy2p48hPPttbmJFAsi0ylZ77aT5jrNI0TajUu2DcA956dmGtmiVPCvZ03Fw01kkRaljnPImUSXH(FC1ujZLZchWhiph(BkBnFmJiovml9Jbo0rHXQR7mK5msr8zUa06lo)(NB8hE6s5MAXYLMU0mtuE(fkn98ZvE(hM4iYZE6nFXpEZ343agO7P2dc1E4D(Tg(BnusH)a1UZzp16x799w7PkoXeZHTDkQM(uUfvCIXjfqxklfth(atpEP9bfnu(8SGVWeJuc63Zobu0GmLSVPhFIjloYStyx4qULHbDOOg6tg6Gg1J9eyV9JE51U55tqhrxS0iZn(ifhVCPj(ELkp58Zvkrnngbe0Rpg)HSLqs3K4z0H0E4IP84jTFmsOunW91F4pCW85hmxPstM6B7mI6ITJ1yS56jSnsXhwsPCPCMM1daH8oUTLrOE7I7VNq4KfN(h8DlvUC5X((f9q39gcyRmB8j4NxMAkTM1k8GPqHsIB)asOpIleoopfQYy6YsMY4JsNYUq35PzexVDbAaXGLsN1dlTKp3doi87qaN0c(jvq5(dcZFTICEQmbszJRy4HWipXBdsEyVtwKQXtvCR0M6bZJ)ND4OevZEHafqBd7J2gwutnC)rBd3302WHtBdhRbVPW1w9qIwpZNed9X9HKjTI8eAEIHp5dd4TkTDGgknL9qBwpZBRA94EN2SQOVPD4)cd44sBbyNZ(Bno0llYToI1AaKGlgWsnz4TRflCgzPAK4mQQ00EnKPnMwfXD6cE0OwhySkaSfiMxmx7LNcJw(SYOfHgPZK0AbkEttOgcOlPEOSjbRujbypBssi1TmiAqR)Mn5X0uby1uXnTllhUumgh6PaE0WqiQym7mObilxrYSi8e6AHE4hk8rzeJMUVOdB)JLPqGX0gTAQaJ9dKkBsxBZ8tvs4Y2jez2HfQiKTqaqwbaaHJieaBUe2HSzycbKWebOOmtHGqzWamwC6GbYggXGGJmaeKbiHaqh0aqen6XpkcaznCkM)qhqjJ0bGLzNHGdqiqm9Wky4(fFWECFpHeI6CkQgY6MbnlkBsj)sfG0fDCfmduSiwit9arfFGBBmHOVZ(zNpWeY)fbayd3V4a9dkAMDLhrwNOElvwYFy3TbO8IJm94P4DpHOdiBY6jvutQ0ssbM4ZVvgSAbS2bR65M2yc1AjLG)hD9zoaW0POokLIekFrmgFCX65QkPwvU5UwSH2rsZSfbSgTXbiZM8WsdH4bjOgXAtuaVQNuxBzIIqhZRrQXR6rBpESXUdUGobh6q)N1TCITFgT4qwk(HNXkxszzz9CJuhKsXvGC21fEz1W6C1LSzKqpkW1Ewa0ruEE1XAQu9qPb)nR7WCWVKt7iQq3yAdbbbal3ELY0IIatgoqPOcRabxPliQyNwIT77beca(31pVqlSRzh4NW7A5ZnyeDoNb(G7Bms12Islatrwe91nThhNX5UsOcPGTrymYuaXJuy)Y8HLxzCOtK2ZI89JKjTTS39rx9jIOyjkutpoVaCSj3iMa7q2tGjgcdzpfWJTs0aCGBESZqkgq(iZn2(MVy5zMyYsW8Q8ogMYwNXAklPpdS0M9M9YwiWpWIi4BxtzjhLHAhi5F44FWvloBCj1GzQ7C9c(IXMyI4Dy2Fjg7wcObW4Fifj4FQPxgmryfu)tT2ztwMlUBKVr8xFhPegFqsDtUdsLz9Y3TId4PIqH0knaPsj3BY8(x4Gd7d4IDHlEybC(EzvdGVtqUnXZq2uZfPnnt8tjpidM)h55sudGe2J1JCiTDNCipeLfCfqxBkmWq5ZwWlNmodlz9XNTBVc5f3GdJn4q5hakp7WBVn5qb0KfYtiY85bYeOZ8B7eAauAEkPsOvGyZVTtTbrU20lHGrk(2ajhenBt0uQgj7Bd0DGeUdLtjDcTF7G4dK6DiFl6NWa2o6bIiwxQnpnB6iK7wU1cwjLIP8Y(xw0YUnCrRXKjLLbuIU)Pxqsh(k3J54A9ZYPCSIyGGItp1(8GblDXXEHzaZtd09ORm94eKt4ctpEVU4MRDYPH(NDQIsXs9CvK0zTEJQl30rrUfaYMlwvxPLz6uZRstR3umMPtPC5MsTmKRXBZoIjtyvrRcfeJfDzm5uTCXWEjgAAYMo19MBO6PC70WcGMzYKqCinCr095ubbGwoBYLLi52fH0aHKzvuNv6OpIuZ2oddEYUqmx2s(VG1ZJVAwmhsDtFyFbTXTlTBYQbcDU2LfBkz22yujD3iGt)xUDMrqTCqo69K)GN7i3frTcmCEdM3xOkd0WJiOJc9pD4gnY(LoeeY1GcuraDM0UYJ1aPrhyYac2GJ0OldgEWmdMyfn5GjuPLafwwELzrTOEJpquKqQ8grq8E7bdaMthLeRFLcQkn93PISxgiXGnuGfsJmJhhuJkqkb2NCv9vFxUHsFrAED6V(MHk0nuWtECQm5KwKovP5xWEXcQkEIl1q1hD(sLMFw7Ygyy8)dav(99Nl9OcPwrOWquWcRNZkHcWyI58L)nCZ(do8HWWrBDCzzQ0RO(CiPifmfdK8j(DioSQm9Q9ShrbQlWogTZzQ1koDm(CUIKNbqz8HF0Al6zFeF2FkMeeQtDR3bb(oocZMzhrfU2ah7T40BHWGY(dgHgmCn2bOXshBpLQA4uMMk42Zyp8N1rqXFmAIIOdCiiMcVIYVWOKCfmYMkGU8FrmE4pfiThd6hgUGN57b8HhoGSujWGglmaY0vRi6ztxpJOUL4Lkdl2YSsiLf6RcgaEMGjsoqxeDOEkWDdhyEORw2OuU5yMRLdB(J0ddAT8il1oyg1c07gADC9XHUavkVRDeQdoHf9rR(e3Cn)bKmC80hzFjofL4rQ4GugG3wCHhEAJ5XXBwBrcXBwpIkZQ12qMeoBxXfMi1pfRDwoWMkt6aoEqz6LMD)T(ZImkRe4kbOuncXv3raptRhPztRPFSYC9u85JCey)T6d(VfLcSEIHxnKuxsUgd7pGWTYhxEM4UYVTv0HkXbyE3j9Yd9VuadeJ22eADC9GzTgCgxXGCoP85HBFn6hNMmxnfJ6ENR5BZK9UGDOeXeQcOHO7dbTrSCrNBprWH7rU7wHZ2ZCvwkkr)Xj7jUOVnBw082iNdrMhEGgYYnTI)un5MMC5SU1oVGB8I98fcmO1rf8Kn02GUJu(uceHMj2vOOH0mgD(yVbFXyj3TRn6lEBjxON2I4SpFmcFIw6maw38QGjShwwmlRmJWLhCs3y9W32pbJhX0gk5AkMSCsYd9TbAWW3sztwHM8z44gN27q2yrN6zLXHbgg5VuezS6POtVjt5A0KvVSx2w3E5eK2VBDCONJNBFYPUIuEtDbxbMiS0jeHQmjIL9oBLuVWLaezwQ3ThW67LRHhfG85gMtP5THTmapamj37EOTOqBki1glDaO)uqSjhBlJccDSmynk9IRKEgd4SrpeMlj0RbE6ICwpoYeGY)69O1(4k(1sl0xtHMS6X8ErgW2VPSdtxlUjSdtEcA7dHNyviOptunoPw129TJebFwViTaUHCwDh2a0zfWiGJs(BIEkeubDiRTPC7MWoAPwTSDJ4gSq2L9ypCAE6P2UV5QUSULViSP1M7PqlgHNngr7m0JT9woUSKzyJkv9q101AnQMEnzDUu)3XAjotMjbHEzTAKfZLu1uxzzy6Bkrjd6wM(eDDbeAwLULBXacKmR7yHX2YZX286bGyxJDKUI56EjCgf42ilHh5nUbLa2RCrvmgZTz10(Nvd97X7lcN9PT)sIUGgv61SUMxtNJDx(MffEKx5XIy5v6e2vIB7419npINcXoDTuC18y0aETEGT6XPn2AnrpLR5od20XW(zOUovigWbzJqn4d)HIaV0D0X4UZPw5PtaHIdMo5cdFqQ9RImmet7(pQcyvzHhZzRzDrm7gZgBUh3(p4Azn1O1TUf0deQf0bKFbmN6bbzbVp(fnfYnZe9rarygJ0l5qGjOtx7WEU8PW9EcS5uqYbe02(h0DQ1IKfipmO5FE9fvoM498VNKV5x)f6L45(jwBbweZY6fxjOjYGf1MMj)1P5sMJ5N2jmL7Toayit)Q)21QBY(qA)LaYTzHtC8CWiPhep6o9(V2wQPI5koNdVY8)dnGOTUm5ZO7AircFSIIATs0G8nfnV6Oh0oMuQZs2hBfVhRa2DGKKL5HSBJ9nVN4Y6Wcgb8TNKcUy5O8jRgZs5htYKqAkYNDzTdmqY1UY1x)cp7MV(QKhWmoALt3UNQuIUQuK)qNHgMsxBBaljVmqmWC6amToT)JHyLLMuHC23snnUavDPQY3h6Hib1UFAuN7wXu(phDY1wsE7blGMaelmN9WJhaP4XqxUCDl22f7QueA3083Fdaq5FqULi)gEU9efQux8YABdRfY36XDrrk2PrtGeCJ08B0kNYdxDhmLtN8G6sjFGPeYe39qM)Y8uIdz4CPeEvg7H)TJKUHlIDEe6hRtbMwNVsVRc5D8Z32f6zL7T5fMSU0gjxKIKDL15B5AHdJbVmUhaTBF8ichyxAkBHJczeCou9CApdNZq2k7TaVrs3KYCslqvPDpbVlwo)zx7Mx0RwoOGfSVNCyUDIm9Q2JAJSTEpwHd3wTcjKIZHjnttmTaNVYpcVoB8F)a4Tk7tzPgnXRhwX1Y6K37Tw(tEWbgc)FVWfJdSifqIkNkKyEYM3J43j3yZyqqhmpBTOUSc8kwgIxS6mCtI5yQSIpmMzeoZlxdWgoa)vm9FKHJZcuIhOeRCJSJy0doasP86khyWHfxF(u00lo4lLxNlblKE2mOzmP5QlzqWTmmpJhMRUHOa1RHV1dFyQFvxXISEobj2MvperFjQ0LryVHto09KUYTyaREe2tL4FDRpXsSpEAt4pmMBDDk7Y(k)DsnDIMbJ0PgrDfuCA7tZd)XlotGvKeIeHvKusWvKSx1qf9Uh1biErtu9au0T1sWtSNfXnoaasi31awI3B82pvN35u0tuE)4RaVJjr6GqpOEEW(w9m7ANiwgEO(x9CH8XxJBWMWgH4hZPGlq1Mrl69)RXxCVXXBzoD8Ctufdcm9yZR)8BC6lTXt(SDF1pXZ8cdVZlCoEu2ZnyOpdAq18hrudpYJgHkpoqYH9uvNg1k8iPJTJXbHiFo8Y0K46H)8pR7BEkp8c3mAXkgmFxASCO4YkWoEVB)RBsUk2dw3s9iuOa1pIGoSThWGc5gwCid80xydgGtI0uWp8r4aVnyK1BjQQ2h5fobQMJ7R8vjhLZsQnL9AlDq4RPgDKXE4PkIxYLP8xXGKuzl3gDw)nqGgtd4dPZNJKvoFl8x0pXjrrxcA9p60RFT3pHGdTLlvi8CBf(51QqbHNxltFlMG6MmXlR2ubK97U2jrIpPGc4gUfqIDEUZU(7)Rt0JNlnZ(5qqYsF2R0sPo7vghKn0P4fefgDHHj5WHh0qTORoJXD49vbR0hQxsmNsr9q7Aj8Eao19(O4TduQm2F9XOF1tTEO2gMk1xzFw9AV9eqA6a6sTstY)aVC41V(ZZACfp15ZaQ4lG13czIf04ho4TKzqFNvpXwNBF18haScUod9gahut(jEHn(43Q7lF5UV(BTLxBZVHDu6JXwm(Ptg861cqYkq1C966Md(L06MIpu0ei5oo64Gt(8S8JWnUKZCLksK7vzUbZt)VV2nFv8g6)L)Tjc4G4JB2ruAB2Yh)AFiWsYG94UMpeWd5qIZXd8svCF3Rxo0mHqS)nhbL8WL2FG8EkH(YDc3MGH3UcpfrGN0I8oil25i)hAygF4how2Bh5ztkg(peXbnktS9ZrucDePdpEtv8y7p2T91xfzLu4RI5MTC4QTHFaRn3Y5cOW5n(tHpHbpiQw33lOLEOP5ow)SlkzDz5YiLeSlBEGYumu(Z3YEoyZIt3iFZMPklIAgnlYeSZA5Z8xhsV(ew5y6IYavXJH9wsPkijPI9SPEkpvJ9uWBtPPQWOHeZmxn0eZHCU2Iopw360F4PXAKNl)(VHds(ktSsqNyYWZlKH758lgtEDuKQO32uzcr7PPwROuDANYWCQn5CMY(1OMhCJNDcV6kNaE2OAhvK2YSyqxA1glwq4BSpSgeLOEJ7xrhhl9EOXDlziEtOSXxu6Cd0JeUtpIN1YSldF72sp4aECb1gG5AVSSUsvpBEhwA4gR4WnCS)HjHPzTcsygvNje8qSYAbDzddEej4KJegACpwMI7nULhzNrmc8ynO)6gTbH8l9VITqoIkoFLo156XDYdXai6G3aDQYnPLjqKMzZXOMd43SGa2uoRgGZEapEkfJ9nK8(ZWBnSoeY1exhYBKIEzl4YzPeGJPcp27HY1ZElAdrW7TMqVweCQ1Iad8ES47exLj(7MONJ8xpSDIEsg7O3pXyks7M1487PiktFM38VmKPTeEdOFZeaY8)vP09o()LUVTlD7x4MyU3Tt5BFkKf3ZcZ8HkMbUb1CA3zQ9aINj5pzmSExHUDijh0EulGGzSqGFijsHRqTTON8(UIxxQfU1u(ZnQAkgEJ0qVLWu(e7fC(V2cBwph7gVin4mxhgN89SeHCULypCDImckJ)8Vx0rJJpzoCVrz5Fn5fWl6NiFDvKGlV05EXXfUmG9f)BWBhCy5wDEgqiODrt818F6u7dMiYw)XAkTCl5AL0GXrzzvgt49M0i8iTKwlYoc6TcZQDyYTPI7Jd6LdV9WCIyLYVcEMt29YFCBDvi1wTfW5shq1Yi4qVwpGKrfVM1toWG5Z75atY(wQx4GzgwqCshmYRQ(0PgBFJuQ8Slov5rgF85NlCyXDUEHYfNFXstuS8(xy8rknr4vyHzg57dGoXCqfMEUPkFG5loZ4EQc)CFSEcotwhgFNFMlxoUqIjtOyW0ap0qqB5ylY75(Sjx2yjyog0pXnPeVhcuRjRpz7MnNJksKJ5KVBhblsvXqCj(DUVO38lEUpL1xQqw83ds(9qKFF)KFpm537K87hG79ov2uKElF4oGjZT0rPd(oE2y3e470FtnHVEUOOeVqELAUSVxbw8nOVBUkS9jJhC3Ma4KgBMnPuYTeG4qFzXQyoVcoxacizf0RFlF3wci1VnEwZe8Ilk(hjlFxQQcUwXcawkDT394C9fezL4wFrWDIaDemtK4WZ5iRxUJt9DtET34393QD9i62b1LJZfPPfj5kJJJIoVJBcqiNEB(PwJg87yF)H2NtdCmWmI5bbpP5(dcyNduhp8dhe8UBTaO1jWoqnkapW23b(lGJ6xy39YBd31RwX)TsZaFnaI)OsCXMD7wWlUPp6T7CLRqdXCQhlBWx0Q2bY2t9zdrDq1)4X)UV15w6Y6KFf0b7uaF0)H8S)UoCly)oS)gNOZ7)mKhG3nXSB7j8vRRW4x(YBEHpN8eRBV4i1SrpXR(eBsdJEpkiZ8yK5SP2nzhKCEgUVs7nfMIwyItzDt3u(aJuCoWQMu9XTpDVD(x3UgL(lUbJV0hueExeVvwgWZ76S)mVoWwXcNaTOX(UQ128NqNJ3Jx5)XBZ0J4Q)xug)TfFfae(EeAnNGCqDc6YNxqAbg4ReGqvjtdGsSE5o4cEiVKhCbk0x2dmh33WF9y4cy4VDiIKi3(U31JV(Th44SJL98nWEu2bht9)BLBG9aUHlc8MypsTGryhD)OKK)vvAmus2d34XBVo15ElxT3qF19YOQdMEJBpblb6EZ4vx49LNZ5vI9ru7X9e6b2FSGmntVmddgs7Cb0rxrKVi0yB6ZdrMSNV3arIhMHCG9n9IlmrXiIqWwrckuXh7MVpLG()8EB9LJzeHoxAlQWrivC7WjsVYLpISUHcoHqU6H6TqDDB(f0Di5gLtytffoxujHdaIdFRF6P39MjQT0i0vQyPH42f93nhS3EbNe2Rc8q7TEFvTJaCRbt0kfiPGYzO9HLPwNuUvztOhwge7kdIIYh8K1rJNvoM8)qfdT26vLROSClnDZwFZGRCt5LKQUs56n100B8fgnKQPDKV381RBiBExVagoDIfYvO2bpyBLAxALcsfRBSYYp0s10pkfY99DoAXp8oGFwvxEjGMrj6rrT9xsrL2C4RcWvRjBizIZAKBSADLJkxJCys(j)TT(Ne0)QA9HBL9pbgk2qtNOmbXCLfhdtrZwFJGPQw6YvvWPA31LQ7Uvs31LyQXxP1FFvnTMa5s2vo78tOH(pIMwTJIBW8QMAvpmDs7Ft2)7uk1A913nDJz2l1sWKhUqUcJEmnTLVZw3DBd5XSq5SA1kIdjfjzD8tCYJyDIOoP9rJQsvn16klLa80bBa5gfLW74G76s0HaIlap0DEN35DTkaynfKbAK4K294dAtjtdLwPWqd9ap49F3gfho3dMB47(W)NFV)3p"
    -- 旧版本wa
    do
        local wa = -- v1.0
        "!WA:2!T3t)tUrXvcHFixP6(HCCxrvj39dtPuKs68UkAxJmGJTRB)2lSFfTY4KqOKhjnA1elnJUzgT2leFLXaXFaogSX8HXeaZNhjGZ5KyS9AdvL7Faxu3Fb5wPD3F5sv5VGRFDpF09mDpZiPfcxUSy2vA6x)6x)6x)6371VUN7CY7UXDx5URCIVNHElR6QAkgZVVcZm9CtCj1Y6AlQ3YOSYDAC45Rw1uXAV)lho)hEhOFAUTkQMnRlVsbLdBvSQUrdzRInlAP2qPyLv0KBOwUOvndfZA61RSYLk3Y0sVba7xZyfhuDGF0hE074o(AxrwRCnDJf0v1Skn2eZvyI8FEzDu10pK2IhsTPYbAkjUXiF7oB(n8AI91SISLsPw4)87Dq1evwsPMHCzlvDnZDK30s2W6Eowf9IM6T0QuBuvnvRVZzrFNGOduI83d)gRkjvxVSCDj5wgYfv0wwA3EFu3q6joscj0popkZYkgiisU8qzYMmbUi1QsA6wsfNkZOtnIKvnfn8JHFSF2UDWI3ZYmPHCdftVIuQBQ4cdHIQ2sd3FKMsX6rumMRvJuMwgPDHYdscrzPR1QrjfdakvTLYG4CLRbFzae9M6ERST7nd6xPtMMffgkwTm0aC4(yfTkjC)cQ)5ra08H0s7A3ufz3XWfWWf8AeHnGDDhPfUdpRSQgM)eepcaCN7vTIsQ0m4pi6NyzfnHOekCN7tZqzjvtlfJrQxhEILzKy1EKmaEbH7umWeeto)1J3rj(bFnbR03ivQORnwnznnL6Gy4OQY6tPyZnsIHDSIOYTMwRQEM8o9fOwZQyAkVKYcgkvvpCkUymT0Gdk1538bT)zpxNZC21w9QBE0lS2N9wBEPxyZN8Cj8rkZGAF0e9gkwYwYLQRK6joYaspHNyErvTkkhgbKJyCkmydiDqLv4kaAPtKBtXaGdh6iPDNTLcjZndi3JgXL2nIl841kS)K(e68OZhn5i1T226h76Tp(QDo5P34PU16V4B058Ni5JbCqOSnx9x05CNIPmU4P9z(Wox8KTFTlT55)m0h686p1MV6Z3(mVuNREIop7PBF6xIGsBWU4RS55)eaSF1PObBJFZBZh7DEZR350F8A36nx)cpD7JFJ1w9tAFQpOZrFYoV41BFMxP9L(fTp(zAF9NP9nEpsZaWFUl4cF7N66TF2Z35zEwe8B8XNcbFNR9A2WZT9GoXZDY2N5YRT672(Z(LBE03yJF9t158)wud35nVjPnGEGpy(WpdbdQXay4ZLU4hSXNEU2pZ725T(zRDRpB9x8d6S6f24wF8Ax)nqisulb16MxJTwF6g38dzQvKT9E2JeIHiTRDrqQ3x5tPp3N1(5pTD7t(mx4Oht28IhDZF5RS2n(5TV15AFYtt3fOhkiG15LU56N)QiWcLFXrakkzLnE7Nz9vFbc0B82V(6x9j5d3pTC1Qto54dLnln5(hV5f(PgKk7banHsaicmUXV7tqKicJCrhPue6IfUi82oyM2gh9z4IrcJ1hmrG3Djrgx78bVv7BEgP9eeRCGG)OeMcThFWuIGzXF0B3(AxJGn75P0pje5q66W8eU15jmSg6ieHM238OTF)Nf)aP71uIECb9vcmDE5RIMVJFIjcisR4GdKy2MV0ZgehKrpcoqW05vpgsFGho43)Xn36REUoV(By3)XvE9F3ZdpjKXRSOF687Ese4bg(9xKioY9Fecu4ps3nduGq6iBwO56CINFTB8obLTPlnAzBc0RD9FD7p(QCr0gx5tClsuFAh2JYOgT9PEd8dGrO7LzyCh2dJCbkKXjIMg6Xj7NechMQI84ZuyjCUnzvbuNx0scKfa8aisT)Kv0cbJKLZ6cmsSAaQW7C62N4Q0krBF9RcRjFQ30g1yBiqqUX7C8nE7BrRnDTR9E2qYNQVWZVXlBpVFZl8FaFMp)6v(01FNByd3BDz4ZjySL21Fb3ALFQrtvt5Wdins9M1Kt7Z)cdLkGnCeNfmBvIa6qdinSFixYqbz5Cqy3(as3NFylvVLchqZnG0os7zZpPTD9yb9vulVJ0sFxPHZLZfkN21fo8d4bPDR6ci8DA4OTBhZme5IIeMuSBhcwWW7zqkTJAHupU26lyCArfRXQlBAo2KtMc5DnQnb)HvqoUzTstL00ep8amT70Ua8mEMqggkoGuzaL01LGuoEazdlIbUpKFYysjfb40I73CRfqn8DyIqwL1RRBGjzKuCsAIJGRa0gv1WoCuxPSvQ7BaWVtcldkjfUY(8RLPP(PLtkLjJnEqFa)C0FtsR5LA00TYdq(yKd)eyP6sbg2DhTXHKyievT487BUXF4PlKzQflwy6cZmrX5xOW0ZpxX5FySNyp3j38f)4nFJFdYHeoyyyegYTJhm3dUDjU)GWq7tF81VX7ZddtLFIjMdOHKKvIsYwC(jghxizP3K(6a7F6XlSxuXBpBw)vBHjgPaQVm7eOIh2xP7D6XNyY8Jm7eoaSD2YnKvRKxhCyf8ELeAKeo9Kp6Lx7wNlHNeXIfgzUXhj)4flmXpOqXjNFUc4cRO7tGdCtMYFrAjUu1XEpEq9hoFsoHSiylG5i6AwM)4F8WzZoCMcfMm53JrYWdRpETXMRRX6i5Fyz1IfYyzvneeh0z3TeeB0k)(6Aepz(P)rF)cflwCSFyEo8JUhr(rcDGIy1fKCk96vg6bscIh4ySGqe5rbI1MBjOQnMHISLc8OujDk0t3qAX1DNiT0qaijACqltMnZdmm63rufClfSRJwC6bq6lSJgBY0c7LJRA6RtIFcVgfxqV1fXvLThYyfrYhil8F0XoKxTJBNnK(AUa91CIAYC9EFnxF1xZfEFnxSgyNcSvWx31(zCLOif1JsWKkZ2PZIn2lBuvOF7N7VMADfF9t7NXRLTlQ36N2voWuv4FrvH42pJWwU91CCevNNzTmQ1DWrfwWsEPdA3paWmkYvWbgwtTo96xtBoTg0oPgIJw7QiMVkQodHnvAUwnMYqVvZzvaRJntLMEHs2XnIHmgYAhCajK17lbvBaP6klRu32GVHT)7aspUUgcwDnyJLgia(unhhr5iCPdH9v1C2zaJPAus2kp6jK1L9XNuthelvjgRfOh68JTjEihomBwxfjRmyYbKyTdnyVugmViHKGFSrjMvieiGfHacZPecKdheiqhMPqGXmzeKeMTqWidci4Shnchqh4edgmkIGcpykeiYGmcmrJ2SJ6iaTh(fZ)icbyPJqW2SZGXfs4rC)KwOY7lCH)iCFkERjYOQzQyyjA25asY8LOqsOezbKjVIftdzAnsmJBvODFs0ZymqY3()SiQq69(H)U(GuUn7kpIIbw1AYbW)HElOqLNFKPhpjF36W6zgqQQKQMKAtzvKYf298YVMg7TlTAMPnNqRIKm6)b3hNdbCQKeNotI3whEmlUC3QzklRvwP(oxSM(HsXogfWiuMk4Bxd933IHN7ivy27(MQ2stAO3aRqMJICulYaleScdQOe0ldBmimzWXPXkwqTHIrMrQIeHHLbD3ko2(CyezvzAoiIYICbWfqkBkoV2y1vlFWuih2RY40f8Gm6hsdrwtBkismamolHNIxOYshaCckHkHXzQHebIBR6VR5dmmq83BzE1Il56eXUOj3SzgogemJaJy6130aAj6fqZVwecEqkFrJaucidA6I2aNXWZDepcd0R1dRSY4iclfhlt6fjDsB6Sp3EkQcm1MIJitGE6XdoXORyfXutGlBzcny2glBzk04sbD96wQnHb95bcedcQXgzUX2785loZetwanholJf501BS6kYgZGw7LoLeObaXZGIX4DNtzlpMMy8l(FG8t4vno7AoXRbIVVDloJXoOd4oh9Ve3cuc6HmW8qQYO)PLQbY(MvaDGvAnGuXabwf)eCGq2wsHbhgJdPTHrI)WO4HGb5GaeaKkpiUYs7rkl)vZyAPbzBjHROzxPS9ZszOXlCJ6WO8XIi2ntilQaTJFqAitPYgi9LqDZDt9yxwWUGihYP7BxJHqLbH87eVE73)zhkBwEdeXz0DaUdtoKWqzdJgYrObGoxB13DTRDQCFrrh5YgbVatiyQLqjWh)cKLekpbtl5YsZv2kPfrCapwafpylRHJEQHQLsd(k2TTObu3oMcU80OP27B6fKnqFL5XbyR96Icb4uXar5NEQ9YbtuAi6QLAqTY0iEYORm944gcZHME8(rnTNvNPq0Df0JHV6HXQzkjB432gIMglg1m2aQyTyzd1MwPsoVgjNrtszamH7OuxUPPsfwddaSzH0XBxiNDJYqPHSQJr8okcjPQAQK3BMTxnPxhaPc3knVC2emOZdrFx3kWb0Idi1qgNkD4UgsOAwvTzLp8JixVfZqevgHc5rO0)mup2jvomhCDtTCA)ls5rs7cM7jYJlhwSLSvlZrLn8cko5Fz2rAo1Yf5GFjbJNoJSzi1syK6gol3OmhIJGc7hd179d2Gn2l9dorCuK))ciMuEYJvqsJUWKgjypuASb0M(WmfMOfnteQeIqbKgRmlO5LNl2Hr2jZAgrh2pfmiYiXOKsdQiqtTE6ersvcjEaXclKeydoURXl2dcIclOeQ6o9Ia(IKuJnyZzfQG02fpHWTY4uZpvYcZVGZIee15yNjrvF05luy(zDkBWCW)lavb9aMjBWcPw(ucWlkWvZyN)cqiJC)Y)gKhbIJ6gID3YawkMinYJgdjRVqttqsYylCff5pxcz37MxCScnCGvZyP3moegBkKHtBbuzSrQZEh9PFeBcXYVlWvVy)tGi(omI6pjscnYLuC1(mIGU74mQnGGn4eEbBDIDvg2bthQRc7gIZq9aUcf8JSqOHVve7oMcQ8stYOKs5mkMmz6VAW7dMXMo87EH5YtIIniOcsgfHHgnqisjRGG1nMQAAEKqOXtosZGPLckk0Ndic6uH6cFCNW6f9vGxm2PEONMZ4OWY1euB)XcgVakuB7TvYT5ButOhkK655NczXMK8mgmshuclEy20hZCSGHilAC1djhkm9e79P4WMfIhtmb2CAZ5b5b)2wedpy9jwnREltfCaAzfTOIn9u02n5cFY0PeCeSs3lKW(A(NvzBAj3veO4ncXCb7KcrnXi1RBpf2VCApf95ihH2xZ(y8XMdGgAWgKvtwBjLk(gEeeeq2io7lAGSB6dz4uC4r3LKF(m)LzOGA0wwikbwVzw7bXXvnXhjnUztqplTeNMotfvZQ8M)YDVB5zmqODSj0e0VIMMIAVozcf4UJXOqpmc0VC)EIZ7VxMO)42DnNMU9Ju)qSMFINRV)Akk1TJJvfL6wbsVF79Ja2oc65Iyybl6gItIG7uLTLuOYNi0qsVQkjCRDrhRR26SyA6Ww5wOf)n6k0d3sC3bnFcZImbiew78Ait1xwrmlTOpHvFTH3wKh9gSjy8lM2pQur1IMJJFi3TGcnKV0asLi52gmwhyLMi2kp36BNaKrgo8Vuf7SPEWjFPKEgpAt1D7gU2nhQ4(zJDd9Ox9LN8UNOiVKtWtqlcR8crymDIUYwVTIeUWRtjYSDEBdI9ZkAPxbolfzZKlGA8Va2Ge4ekjTND70UCxfhxFs5dIORH4Vm)w24uGXRW1x1loT7BekGxnHWWXbIoYJhMRfgXkXQcAjd4ReyltLuc9WNRr9(CosKj(9AA9qrIDBs9qLSIoEJXjArC6dyLXtQxU1wIlzHFO(WTiSDM2KO)WHAh2oexh)3eDDWafDY(D4k0nLtCQTPc6gZluT0lqtFQe5q5oomZQ0UQThE(tVoVJFymduEmI9CO3DaBjrjhpRDu5YhSIHEZr1nQOyWC2jySjmGZf4ThOHEfSPiYA6AR0aPEiPODRQV7V8UBlI1UG23TCiH7pWgwgclnBawkpFN4hOcxjYyUcDcMrjMTuK75zmWGMGmxGxL7s9g0A7)kJlrD5fII7oO3)jWxy2x1lPFoR2vxlm5oRm84YZIPi33Axr0y2M(DmMJiUWwIydayvsmBm)wfrJIUP96)MRVsiFxHfY4F)iQuLm5aHl8wKBgmywQcIJIREoV9w3otUeeCw0uwpycU1h8vBhwdq6spQkYc7HEm3nX3Rb8Vf(9exoWUG55hINr99VNgdgQNgcYafQJzIGtzadbssdFREmMTrACptNcTwJ(Y(UA4GD9ez3nN0jruEMi6MWBr8I5lJwnAEJfvFC(znsxpxWZwbevchiReXzdzJXSYEXDlsAXy3ZtrLN)KSq01CBNuQZ760azmw)U2HNhi4Df35lHKl3HorlbVtFjjFd(xBjxx1Af3dFzr2)bg)0Yqb)zWLxOJJ(yjvTkfiHXDkswAsozL(sqt75hqlX7iAqVN54SWpK9hVNhxWU)NtWOd3DtNZ1ijl)ZUXTvQsLgt4Mg)zpw(GdkT21wD9Z)CB(6xY9H(gZTZLDVJJmwNxs8FiZWdtPUJDUfuAG6KiDcH4ErQGNh1slnPk(qnMCAyrYQYLv(UGx2y079jadWrlvRsYGhssLklPS1GfK2eal(oWPhjKUKpd7dKnLDLVaEkAr0rk2lJeeGzFGalp)T9DxRkoDf5Uu6w46WSus3UGmPvirWbhGPubtFagftE6L8bdzIiO)g)bFLIvgSBSobFLGDIfMFMG3Ib(4ZBtInKE0ZjH4cWUeV9HU1)QH8g3dSz3(SIylErs7R4v8vSkopdC)wMMWWTytk8bOt7dN5CHK0uocrdLMZHuMZX(nAoeoHn6dEKSHfHjLke1Y0ugCPfDUtV2TUOiTPiawG(sPYtdBjl)Qyj(d4OJLwiILAkHdt8Cq6Lvhse25l9tG7iQGxMf8Q2EvxQwD0)BXVM2xpe8QzW0MDWTd)ppyJ5bzLamw9wjCCTPZ8x477xTIvniq3dN1FnjU(J4H0mkEy3vebhh5KdW)G7Mw4m4m1q2JIANswj66fkfpiYxjkEpyjhLgOxZQBEWHZjghSjTSF8WwAq98ymHPYzatVsXuF8aJxzqg1Nlq9JqznpJ6Rg9qyVQgKgH9uAd9fGANiOP4KSzcPkg5vVtgnEXh)6JOp9P)LLEj7PkXxRe7bXDRt30oDUiYNu3aRDXmvYr0wbe7261IXE80thALXHEIBLXLeELXzwbQY(ZMIqefjh9dokp7)0UgOUyE9xGanMx8f2tr24TFM2VZXj3Mb9JFsSoNflNJ6ILegUVwsGEDCat52E)TKWqz7ET7HBEEeIUuNr1qvrhpX2)6knXJQCJWqahByM4lgm00Rnx9f24KxzJN6568QxMZCkt)ZPCpSIoZR81Nnjb0KFuRn9jhBgQC8Gs54uDxcWoeuPIDGfcdzbcwGVMgwR(1(0oV5X5DICDZPl7yE99jXoJGt7aPX7CYw1c)oQqSoRQXqrfchreiNT8GWmuMCHhggF0eDWvCtLSH4xNyeiehqX2dGvfUxfWAfqvkZxdwTmeoogde2UJueMFNC0rg7HNkpCZ4MKFLdt6Mggh0A)3qbCmDe)jv2m48u7bHFr(uajqYsHR)rNC9B8(jeCSn96zcp5MHFQnhAiHNAtRalOb6)SGBy7KHC2z8S3dhlzbfYiEiOR3(5p96V)VorpEIvT61J9mD)2XsasV2zv7HPd9nCtSbrSjhopL4GkI1QvPmCfURvOLCbDFI5IQAhCNlbxU5jV3hfU5TsM25Rpg5RCQ5d1Y0sT6k71UhWJQqsH73qUzkCUZWBey9vFb)goY2R5ACy3jC2xcO8fszhYyTeByUh7F(EO48EpjYtsCG72uEbrdwr5ONDJp(T68YxTZR)wBzR9g0Ovs)MYgZGtrnz1NkqQmu1RD7A7d)L8A7IVwfWqZCPwadGzZ6NhfTr0mMDvsgFPXhyq)K)7RDRxfELO8Y)2WUEpGnbloA12sUyhcGeBPi6dEF2iQsexdfm8g)9sMVlYtqs29eUpGhcKCbtuU)SCkTgwYf2gPCB1Hpep5b36bdcbFNjdEnhqfZKCX2)JipLLX03QioQKP7k)b5LWsXYXq)hEKU2p2V0ShqKvGrVARx2Ocwje9vjH1wso4YDEi)0LvyWBIIsc8w5QljJaxAj(x00(29Ms6kCxF9bPLyizZf6Uw7G4uXlG2bIsO4OHGgPC212SP))Us(Cf0zgqeLX48hN7(KixqYe2vZm768kp2tP)cmTY5gzQUitZJ82ebFsEJxEN3)8JOt78yDzZ07eGi5W4FZH0fdgzfoyWjtb7IXHO6(8EvgMogAQT0Bgh10ohbaSk6aoE68(8Kd(HZGLF9YtGE2O6hMNM5bGaG1SfuSGWP5CWVWkS9h728UoN7)Q8WRKTh08phCgL(9q9qJ5ePXznvNYhPLLo5agXXnEhGMRvdfd1YC2CyaIOnYYLl5A)g1HHG2koUNwI0rGlS1IlyOyAYImoNeTOqL3HvNpv5vESik(iHJ1TbRF8mWL1KKvCMuaOlGFKh)m9WogdycjQb3rOAk1jLjyQa1MUsmzHVPlc24x7gIXMfoErgJ9Pg)YmIxTSVMhQWVE4xlq9Yw8MXwPsaMoQiExRb(2tBhOcF)B56bhNZABmWcR3BbonOP7UDW23HyUl3cBFhSI4Th2DXucVtfczFS9pN4uV5x9Mtyl8lOFqfe5S)fZSJT9xND8N1zh8NCGnH9lJ5hbwmGpvgLjpLSeMafmRUqHHbfpBmychz)s1EREwqy5rbhgbLvnbh2IuGKRnrDD0lkXlCec3Mt(5pyfvtErWP7tSWatB4CMu3csYeMHc4QtkGlkOXs3NNiIZij9HbMNrCP5FUB4DmEztuj27I8GVpxd5n(wKVNGsW9COe4TyA4Yoox38HNQcHD2jY6dmm6x0c1VLtLCVOj3(XZy1LB0uPsbD0yUIIMp3y8NSubBGc6nX7enVkoR(Y47Dl2IeKFoSIgrMY(CEMB25h8kiWt5xlTMioBkbvnDixcavfKS4iEcKQzzZgYHd3UppXY43c2Ceas7hm3uTe(cQfhBVJuO4SlovXrgF85NlA4HmVyHI5NFXctKV4(wy8rkmr0vAHzg5hIaFI5qvA65MQ4(Np)mJZPAS6yG6Y5CGUm8c0otMmmhvnfmhazwJV(JOlZKMgkvvp8asnmxcn)frRWgKd3pmAvumMSv96ZreDY472gbIMiUQqih5ERLW8U3MFexKnwAObGFpm(3Bh)77d)7C4FVd8VVFMxAHdKetTb2Z)MgGKdlHpqSBI0iuax0o82ABmkHRgE56nc8(tKTbdeczO9XJhm3GlWKlhMnUu8nYsyPKa9zwY9INb6wPfuHa3snqVFl88TY5Ttx3DKpzoROcUSl5gTwOFTND7ELWezLywEHZDndzemDK4GZzunUrmLjkNy6p(KF)s6rq2Ii5y9kvK0L8KXHrr339yceYj3dTAviBerStB7ECAGRbUrmpq8KM7teWUhoxw4ZjcEVT8bP1ribuHaW9V1D4H9DSH5TXqBb3K52XqVu9WFFXIdpa92Ebx9EF0B3(AxJeU(KpM43EPUBmGV6thUFr1)ijcHQlsoi5rCqW9XZ4FGWP)jExS7dzFP63(MhT97)S4ha3O(0Bpn6R2x8(V8v388Fg(j235(Ho1NC64dioKcnk9OizHhdpxm5UW7qN7ZG9TBpjH0besop7BlSI7FK8ZHSyjzpSDvD3zKFRy05RmdaFPoiWnT77h15(Exs(Nz959JLkcTmX52s3XmMqNp3LVWzIxcmeXlEgEzkAF(cOj89r1EUa(aUjA3P5KgPIFH04fCLy9kdYd8qE1b5buOVcHOow(H)swYdWiENdT1UMz3PN6(pc9ytx)Eajq8CcxpDV(()iG5kr8EajsnxrydBVOyJ91bDmuS1f386BTou5DB7TNiFNPBREcnLe2wd6oO3naAvU3lOUNNo6hrSfMZLmk9p2qNIIsttHLuUxMMKvYylcm2L88qKj767kvGbGMjS)9o9Ilmr(i8qVFKIcveYP57rPO)FN3oF5SCFOZF6bLmFH5KwyYDpIIHPkiWRu(GDxOK6LBE4zxb1E0QqCbCz8fOjNvC482YWnSK8cBkOeWfa(HiDl7M3kKTGq8rxTA3tEbjXHJ)Rolr7bsKRzk4YjmDPQivZM1sCmKTQlTes(zUVJH9hFVrHT4E0wift)HwMkfLRFi5vmbZPoWFWSvjOJBTyRQvvp8vko2ilwOiYi28fYJF(LgtxRIkqNMhdQlGKdCmZMk1RpDfZe5H7OnZeUOzbCaJZJ0loZm3(BvIiWFPkkLqOheFn27eZSWK7BMZ2sZM4sCfKO9pbZ1wwzyzTvA(3jJ)Cbs5ZQxr5xDhn)hrqbydmhTiX4PInT)qEl0yqL)KkStCAY1TN8C6)0bvuAocIulBLhMaw7yhY(iLDmNZwwECcs(q3f6herAkBbtvvQ95M1KROFOF48vRAQy9pDhJwfzAFZVXKgQpU03VLCfyRGKku4sOUQsf8Ht6P)B5sHLT)WOAivbLiBg8t(hKBzPJEOAzCvhfsrUrRRlx5LaVmm0B18EkzI(uDLrblmplW2X7puTswY1rm57jFJw1TutKVmKmX3ZThlXzbalAOxxjXvaWTXZbgf69yaGNQHqIrTrnvFCf4zJQwwx7antYLZcS0Ii9ufbgYbogWaGTl7BwYuVLrzLsQnAQByDjeAT3sthM2pGW0URZcBHb2BMseFwgULALRSYqY5RAUsJhAPkn)oIB46kljxELIvRRRBu7sgklHgpbXNrHv(VIQgbA4fe8OOHTYn)F68rVZ(hPZRC52V2LA)cVY6)Yl)hV5ZT(l(bRDJFENF(725fVk5TSF7Z8cTp(nw)cpTTN(x9eDEsaYox5TA)XNeopDx4PjyGC)oS21o9A34NraEFt)FF0JTXL)e73x)N6uBC53D)JGW46R(QK6qqbcQ2V3X68lUO9d)KRS(QNHuecxKnmRZzo7ARE12x)QRDTxC9tEIox8x1(IFWqzU)mz7CIxI8s9grvTpZLXF(0Oocbb4Me1axXMZnnAaS0qBF73)dCFxcndmpMpz(TUNB)n)C0xl5EC0(CKexnDJ5BINhNO53wmNVPHszvy6ZD9NqUjHQeEPyG3xAXXGe7U5DJgZhdnMJgR1qtoZdYhJ(466nUtJFcjz7hfsZIlzPxEzYmX)ML)ptQwP5F)Ui9(9qyOslpuMSxPQ3MREx5LHBNM7kp(Gj8KNvwtLmiVJB)nM82FZB)G)EfztawfTLSQ91)CN1vXjWJHPcIzuX8yama5E7hCuWAvCfVDJV(T1UT(TBI(494)jLq1RQ6sjqt(a6vPwZ)HY2DpG)4K3s1Ucr(g7l8dDN35DExxQSRQXehZPkh4ku82V2DBMpxMhitU7E5)RFW)7"
    end
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
                local s = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
                s:SetWidth(f:GetWidth() - 10)
                s:SetHeight(f:GetHeight() - 10)
                s:SetPoint("CENTER")
                s.ScrollBar.scrollStep = BG.scrollStep
                s:SetScrollChild(edit)
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
            GameTooltip:Show()
        end

        local bt = CreateFrame("Button", nil, BG.MainFrame)
        bt:SetPoint("LEFT", BG.ButtonMove, "RIGHT", 15, 0)
        bt:SetNormalFontObject(BG.FontGreen15)
        bt:SetDisabledFontObject(BG.FontDis15)
        bt:SetHighlightFontObject(BG.FontWhite15)
        bt:SetText(L["拍卖WA字符串"])
        bt:SetSize(bt:GetFontString():GetWidth(), 30)
        bt:SetScript("OnClick", OnClick)
        bt:SetScript("OnEnter", OnEnter)
        BG.GameTooltip_Hide(bt)
        BG.ButtonAucitonWA = bt
    end
end)

-- 拍卖倒数
--[[         local f = CreateFrame("Frame")
            local PaiMai

            local function Channel(leader, assistant, looter, optionchannel)
                if leader then
                    return optionchannel
                elseif assistant and looter then
                    return optionchannel
                elseif looter then
                    return "RAID"
                end
            end

            function BG.StartCountDown(link)
                if not link then return end
                if BiaoGe.options["countDown"] ~= 1 then return end
                local leader
                local assistant
                local looter
                local player = UnitName("player")
                if BG.raidRosterInfo and type(BG.raidRosterInfo) == "table" then
                    for index, v in ipairs(BG.raidRosterInfo) do
                        if v.rank == 2 and v.name == player then
                            leader = true
                        elseif v.rank == 1 and v.name == player then
                            assistant = true
                        end
                        if v.isML and v.name == player then
                            looter = true
                        end
                    end
                end
                if not leader and not looter then return end

                local channel = Channel(leader, assistant, looter, BiaoGe.options["countDownSendChannel"])
                if PaiMai then
                    local text = L["{rt7}倒数暂停{rt7}"]
                    SendChatMessage(text, channel)
                    PaiMai = nil
                    f:SetScript("OnUpdate", nil)
                    return
                end

                local Maxtime = BiaoGe.options["countDownDuration"]
                local text = link .. L[" {rt1}拍卖倒数{rt1}"]
                -- local text = link .. L[" {rt1}拍卖倒数"] .. Maxtime .. L["秒{rt1}"]
                SendChatMessage(text, channel)
                PaiMai = true

                local timeElapsed = 0
                local lasttime = Maxtime + 1
                f:SetScript("OnUpdate", function(self, elapsed)
                    timeElapsed = timeElapsed + elapsed
                    if timeElapsed >= 1 then
                        lasttime = lasttime - format("%d", timeElapsed)
                        if lasttime <= 0 then
                            PaiMai = nil
                            f:SetScript("OnUpdate", nil)
                            return
                        end
                        local text = "> " .. lasttime .. " <"
                        SendChatMessage(text, channel)
                        timeElapsed = 0
                    end
                end)
            end ]]

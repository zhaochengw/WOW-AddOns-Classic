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
        for i = 1, 10 do
            local header = _G["WeakAurasLoadedHeaderButton" .. i]
            if header and _G[header:GetName() .. "Text"]:GetText():match("Loaded/Standby") then
                local tbl = header.obj.childButtons
                for i, v in ipairs(tbl) do
                    local bt=v.frame
                    if WeakAuras.IsAuraLoaded(bt.id) and bt:GetPoint(1) then
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
                break
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
        BiaoGe.Auction.duration = BiaoGe.Auction.duration or 40
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
                    anonymous = L["半匿名模式"],
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
                    info.text = L["半匿名模式"]
                    info.arg1 = "anonymous"
                    info.tooltipTitle = info.text
                    info.tooltipText = L["拍卖过程中不会显示当前出价最高人是谁。拍卖结束后才会知晓|cff00ff00（团长可以无视匿名）|r"]
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
        BG.After(10, function()
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
!WA:2!S33AZXXXrcUEVVXpDH)W9P7dDmxOZZyoy0mGc0s8izeaGGGWcp4bakEBWGXSnW0drFCWmyNUh(WY0bf1ktsjrrAlr9YupOEYvYKsw7Ak(u6)W(t4mMbaFs)fUkRQ6UR3D1daPT31iK40DxzLvvzLvwzLzwv9J2)pE5FCTFCTl8)QDRoHn8B61EMdn)Ktm9yFK)ITAoxRoTx07hn7ITA0Q9p))c6VVPMFWknCp98ENk8V)JwStqyRLXp)VhSKBTwN8FyM61d8c)V)39nUnxCPwTpyl)MHlm6ytp)yZ(VVyRwnqW0CUt6VI3)4kom4QA9wTx2nS6kvd9x2J(2pAL)RjLWHwPMBO3cDW)8)ZTd6ZUH(lEy)AHlnYWOxB7UyOFRMb7C2Gq32H)3oxTwvdA1PzTLgXVPF4)ZFl6Dc6(hxG87z)rf(uNgTw0THJBN2Uo7b)tvVMNWPvBNN)mBZb9h8PsNWRnk1CNyWsptUTH)C9onXfhj9X9cFoV2t3z58bHTlGba(RTxyN2nDcB1SZYl41gs0V5XkHQ4lUe8srekZ)e12(tuc9pfYvOauULXz3Rznsb5x3PzRqNQJxAKXh2jCjVMXON(T9evvt(wP932DzVGKK8Ae4fddcLc16OgzbNDVhX0OyeNkxXN0cJ)uCTMwm08oChmTAkx)M4kMmE0a4UoGFnV8f4WVm6h7eEnd1ItCQ76qnB7Dm)GqV2d3Ob(tbPIxkrucXa7BEoyKXu0Vjupk7f8iBkXSCKK3wct3W1Q1Q5Ol52SPxdG7BeF3wJ7rjr5WWnAvu6Ht0SERsZg18GCnLxqG7X8oyBV6(NkVe2kqkfcR)KiCJgYUSxOBO7cn8Y)8NPOZZNWqv1VznVtHakILppgSIoh370fuWmGy3j8555aiIGCMcmL9W1dXeMrRopAyF7s43zsVQlP1oX(QcuGQUvJEpx8OJ8iw1jbOrmko7bb1VyP5pCobE1jpsUHBeU91o3D7E(737IxA9x8HR9gFqVREHChfqmK2g3)9796VmxASzV7L)IEx7ID)DF0gx977DH3CTl(V091FHUx4xVXlDP1p7lHsQ379IB8oxP7LFZE3(c9ELl19sVjb30mET3EJR(TQZ4V)LzZ46)RFmxb37dVBVlDRvF4hU27(p3983B17)TDF5B07SVqV34UDV8B39JE)UN)YDV7l19EFgP8a4F93ng(UV4D7(kxT3l9ki4x)wVmc(E353rHNTyGM1REXUx(Rw9(FA3V)l34SFW6F9l27Q)BOYR3h(acQHwGamFX3JGbvgamCKRRDJ1)UxV7l9P9U(VE1h(9R9g3O39F31F4Tw9UFak)6kaixp4o8567w)bFbxU0vK7DVoOwTZU3nbxjVYvVUWNU69Ux(UV6339kxQaTu5)ghv5ANDJV8Tx9EVw3h(6DV4L4ig4K69MpyTREBuskQqXzg62V5frpS(F8Br9WiSiGccaOhiaGWLaVNmtLgUL1)4xAT7)BiaT(h)ERD7xGl5F5I1RV)9VVkLlZ2G(Hh8U)Y2K8KaaBZIaGAef3MuIL4gKjuqyR7HPgOXekreHvwag1OB3oKUYE346DFWLD2RmYuabh9gxFOuAC5YpI8MFC37ChsEPJ5y)chMykgk(y)clOpF7WkNH0h39bNT7N)k4p48eboSuy0Rey69w3gnKf)LaeqeKhHdexXgV5RiJds)abhiy69oNdnKobhCnsCPS29F9EV3hqBK48S2F8kWxKP8Lr)17p(ciOK6)etsOz)Zodjr8JSTfPeel1YLbK37cxz179jYCGSPQLdKa0Q39R7ERBRm)R)nFBCscv8Ds7Vqfr3x(dWFaO1pbxhYoPDikbsMItgzZsXPFrMOXaVkshtMvsajcKrnmDsJjYEtaqNGxYuhgqezEJ0rez6zaUp5sDVWTzfr19U3gMQ7L)qkgXtwJGC9p58R)XpKvw1Q35ZOqY1yF53U7LPzg98AV5lZpo9pCv0Go6i0)WvrdEu01q6bz7AOFHdumhlfiYZCYNV13T2dVv3V)fx7k)Aws0634MXFx10Pijcx5Rw)8FbAUFwPtWO8R(bW3FLRQqsfP3xoBjFxz2KZGwq37EbzFOPTzYsYmWjPfLzXPJzieB8gVq3B9URENBsRJm0InET3KMK5wx3R8Aef4w97VfsFN)0zpNU2B3V7vfHKd1F2569(xR7f(sKIb0zN(Q3aPobmD9BHeg8Q0s9oGIzeaqFS3xD5E)(RJy9qVU6DUhAYQvF4Rr01cLkbSvVZLw9bVlrVauEr8dOwgOQgdLiPEtRgFkPAaeJ4QX7CoA1a1KU7xsQgyPCjvd0RRDofvd03rvJEx7fjAFavJBCt2QbHQlruK4A1YVIkZUF9LjucsjJOhrINIte6hysKfb)WdUWte8dp4IKCe)gxz8nxhP9CChef3FZVn(JsJgWWT(T(6Up8QStUV(nE7nE1)zHHPjaPi5)0zFbsAWdYZ3ZotVYAW3HAWiHx8vIBI6RGpQJKNKbgQUygw9oNNwRVYVxJS1lD1vVZxWkWlwyA338wDp7ROq(3Wto)2tqWlDJnEXBWIai5eKeLSiseQbSsKfQb9(n3tuaTIAalcuuduGeyqY3(n9E7V6jcIxmfJgLVkmPpmTpsPHV56D)(xA9p7fGbyF7FyJRFBYd)Y2ObfRDTpaLDuIRD)pFT7FtQONl81WC6)WdOtqivw8AVYvw)wUY6dpNYY6UpyT7rh8Yuw8glsWQutNVtt)WK1GdVHQB4FA12jhy9npgTAqRMMacQ(hMt2Wh08Nl0T9X8cZP08juJaGwu(HqqpT7YE4krrNW2D8kyS6U)PZ3ebFb26dy7RMrMmkc5SLhXqbaifrj72yzWCgHTdwPHFy(CdKROdpoJGH8lIkGQPZcpJRQs2Udx2Lk5GWe8doxgBeZ94OrqXzCBGMhuxtoUx5BB6mFhg5jDMSMk0gkHOzVuqvM7G9dvH(jDecnL1SJps(L8ovrNHBSYsUfeOXT9QrOTGHyd6Sab0kfDgueYJ12dvTKHDhfDEkryxOrhpfGourNDwyBmThOSJTgm6vujVZcopPZGdnumurLBmC4pOcsAPgdi8olCSeBmXqldaUQqlhcwWWNkpHy(SMFWlC0gUbbJU)9NNW1tefHKsC6v45sGpWXHGzzKh8uTOZIakzZlbPkSmmfweXdesHRk5jaxqFBwzU4h0R2IYKki2jk4kpmmLTAsWQuTKjByt02WBXW8pvryqnH4bPKhN5c8gILRO(LlIhVsWd6H4XXSRNLPpnoZfjpALGHISnjPo)bgWP7DUZgN)Y43Q1kgsm1d7KMkOQ6CZCOP33ZoX8i6z15Ny(jhR6mhC(jMz6QZ8SakqlHCJ34wB8b)R9U6fuGHbryyOD(md9m7Wr5FqL4sNFT795QWW4Zo2ytd1HCKf9NJp5zhBF4ejMYi324tDz3tnDNLjE2ypodwMp1dpX(M)aOVVJkcjCGXMy8dmpkLkLhIpL5MA4jNSAC6dUdXAZbhB45rKOPgtr5DGj23y7F2HNASiaQWNUxTJ5nN)VaxvljuWl4U4XR1U1kJsz6EENYfP)xPD6Cg1apsR218ANKLky5POSurxoWWwTUFdI1)FENsijLX))oSOG0LzffP5mu6PnxjNiykpCMINBbXH8mpdIjaijfSPQgJIYAjmTD9RnBlW9nGVCiUTJhIP8B6pvRMENE(faNb98BtK1(RVmyF5V6tjRvGSiv21JgV(p6Ybz(ihUEENHi1tuLSOqkvkdjvwzAdvMKi5FuMxiTH0cWqLJWabmnOGKOoqA63Oyurb)WcXzKfkDZ3A1h(6IcL4L7MB8wnQv5PZbWJD4xRMHKpj5Z14uapAH0pk0d(u(CrjMihUG(8Ul0CJG)Ujs3b(Lsp9GO)nLSGlP5MF4P33WZUVQZp2)N5RU)zMEEev4PrYMPo1phJYicTY95hi0iXFrvHItO)AI4SY3ctgmAoh22an0(gsQ9nKUICO(V9nuMBFdzU9nKvDGJdAHj0ePFtjNdjP(KtLKz(gkv6wAzyZ2op5s(HEcTt63uvYhMKu)1oPzwAij8FPLbBBNg0sE)4OGzAIY9iD8Lw9uSM)qI8kj3zzovqH33tIN55qgHa3iAXoOhKkmiXD7mKXIGGMJJqckLDbRbAaKYQdurSGojdeic5adXRUFut64yN5xw7swoj01fzWl96OwhX14dkbHw1gRqEdn(JxqhuUbG5pooUQ3awZd6FKbgOxyibTjvyfLO)oEmUQGXKZaSCvABrXR(dXpFCzWz6ru9ol1lxjm))XvtjnVcUjcMfPZYKEUi1CKw6eL9u3YVOFFpXwPsBG4eb5EsutIuKAzlaRmzFByQjF0v3ZRTYJdZlXKx2fu)BYwTcneOvzQ5rIyUz5uTKP6IJIjfAFwqw1uknFpG6vIl9jPwlKoIemrWenHYpFffTiMrMOv0IKYnE7wDwzkpy0Fq(c6hSsntMBZJx0bn65yq2GbqNWRbDf6ds)TOZVaPYCrNwnHqBSO8i1G9HAziC1cINjFe7aSM3LxWnCw0xCi2pJN(5RC8EtLb1gF12vsTD2)ORwh320ce0MbtxcnDTafrsabAruhTaJPAiijupTGrOQi4OKxZagbNEWGUfeu4EhTar61qGPR7JVBebiT)up9J0RI7UnGTPMeJle3G(2jlxsYlkH)mk)AOFZaV2HQgbw0XTGY8G40iSaOLURNDtZqxwB8AAgcMcdtksVCefcKLskT5RyIWX5qPXgDJYX1isXQPo9Z51gpTwUI4FII5suAZo8e7lNA51GWOQfDqn5MoR46JeaXhFNIsJOZsuhnhYynR54c)F8ukfutZQxAr3Ml61yxZTuRtMVGI0HOAgu0CKoHi9G21On8CHWvfhe1b2KdKENyGZNB(zoyoKkpiDnhyq(mQuHI46Mqa3(iSUvwrvJPhjLj3qsMPrclsF293U1Y45zKMgxCgivUzaJpuZNdLG2YSZ1Mv(qoKLtM5dhPRGIFXrvlpPqxLQUlB3hQMyCfeqVz1zAoAd)fpE(aVg1fvgVoXYY1l16Kn9AZs9aw75w2TrJd73SwRtQZ80XLhQ7De)JHboiFDv8d84tSPKa3sOkD0sUYZe6omRjums2nnSZMHEAvYoTXfQePjZ5RB8EJwhZgWwSt72EndXM)Jew8AbnS1kPdMGWlduTLpngBJvZpulPtjfaTmyIbXhmkFYab9XGHOZNyM8ISwgVGj8AJaOeG5K9m5y7FE0iY6ObLjVXBA8TdALoaLvene8aE(hBPqeh2ao7W2sAKzMF(zMAwOLKuArVoax5bRcEiJ4TeSDCYEdNjBkjbjqYrmkZzhhBXRqdwdUzjwmuwm5wzkzOImIS13Z3P5kOVMxzEkrm9tkLa6jW)5Wi1ms8zZzk0)KkfpJYGYZskwmlCSSvTqWJQmMHEb322GuaS(SHPJhJhLM4P4ttgFIsMWliD4gHpR3P3hA6oTQPLrvbJ(lTjaL00v1CoMqcN2rIzwE24KjBvwDWtX7ha7CoTAgPFUBoDJ0p1DuqIPs8pEwsL7YR(wPuTWXprR(ItAIwTGYprRwWyNavlqmtwsHjltwY6S4T2PmZ(KmBHZnjobj37pMNCcnTVy1rhKB3PFROQM8I6RH0NoEREoQuKJZm7u5hftoTvYnWHrE2arTWsfR)130IzOj(4F(YuMIY2zmnGgvwuiE51edKJ6kNP5yndXwDwdaKMctYhSH7PNdI6O8mHWKnlfhxqzCP4roCblIbNv5EIXHXWTA1i0FfGpzgah5HfDm80JEGzMTQsn7LiOPHf1CPSewwmGhPmPFtokNnMwGfjdxRgGcwTjIekwHnOItjVAc)DIWvsewKbSziE4nHrJ0Bg0hzXJTGgkhQ2sAO2GrDCec2qaZU7hqhvWQwPMbrJI1hSpTOvAcZYQj(ivMO9JFIjNLLqEeM9X(rLTfykcuSWAOX0L)tV4fv8XqBcusdVQKcAhuPBiGMZnat8)6eG1pNHaqHme7)OVOygEPHrzs2fcPHFr)OY)g3eTFKBJKjXqXso(FGx8zGMyzrN8FXD2wrUywvEsfMcAVovgYUckxj8F5mHCwh1hvcd4u5Pkg)McT7uvy(0GmHSZ5qptY(r8pAPLHviJ)eoENYZT7)kYainunWuA9ZKz0mjmbDWFD0asFIulhPpPN7j8sBKoVlzylqgJxOPa)5(UO)RzEm1a8RvTofDQkTFoWFbhBuBpN2WCHqr3ogjIm6jiyafiabajZdGZmA4qz1lBHRKgGVKyknsZbkoaIcyp9s(0VcXfzfQzI7FTRIHMLY9R7qrCP4IlI6lq3jcTPnLKySd)bMdDkwdjYqoWdAk6CcyfE(KL4jft668q(josLJcfaPS3n5D1RJe6U2dcGbp62spw30niHsitJJSysludffX4JxJIsLPOM1JLwYRKHsIkR5f5M)KibrtVvuznax(3s7C4QyM6JIhDbaTJJQ31H0Ubai7D2kntQ9lSPafj9yvmrBewzrj9aqp3OEyLHkGKzCOjoOlqr4(8wrm5bgQP)0sx1IMvzZ(nJkyaSBjAHXJOTyfXqLYeiY4iNEI9LNmdg6Tj2xbBwXjEzGJ2Qzy7wnmSuqy)j2PDqR25Znb0xv3DrVNK8LNCIMbR4TyOMajYSYZX8atOdcufCKXvoT2iJxcAmvhUrJdG6zBa9UQhaQcscLQHFZJNQr)GS7fEa)GWwTPYE0wm8WPU7iJJwjdruPUIg9rSqtgL0DEqs6YB63OGD9hyB6zv)HeK5TPBaYLv9dIaMVVP(jbBeSuQAOpbVMGoQLO5hvrKDbXgF5TjzY65wST)kH5ZnttI5uZXeZte5eEnCxjWRgFDgWwisfqAIkC2zBVLD9JIvROPHPQGN7jkTJ65sAaOzpdf8ZFsu5MGONmodkaTArNLDXheI4MgAQb0CSt5EQNZTrhprhbqYc(uD05Nc5BBkTNpoV5prbXo)KQ0UH9hQ2zJRxIUVgb9sHP0ZxNUkd8xIFzpmbSUX4KkQtl0nStWiU8brb75vP4oRSqMIQk1ftLOnBA5s702inkMsbNGKYBEonUtrkxA3Uodww52ltB77)i2PuzRTtHF7t1pDkk2dv6QqAQm5tKuulxXKXBGhCRuaBm3abmZGjwHgBZ4y3YLgsx0aBvSbOUYNRCqUuNaHREmGHkIEb14PctTwPTYdiwBIKGpuBOKWh6hA2kiHyPXmXprYM8BoYoDtUKdnYzTd9d3JZCIFDTYdSWgMg2LBQfvOsWWVcFqUOvGqix0XYD00vWCg0Stn1hfmrHfquPz4qxeBsmIff0TFcuk5Z8gmijsB0xv4p8gXhTfO0sI(F6H7aX(DmNsSQRNAfq23vN6K4muCNMjo8vhvtL(Nc6)fGYpUwnzlq2K4xsonZTi)hjsd(JIhCb2UCWmxNL3JGP0pdECdC)wKd3smLAQNZMylS6d7gSi(RIXCIQD2MXnKIUUF(rD0t5rRgVPvpe7gVP6OvnTbBA4tZLRWJPUm5Z01OUP(PprfNgzhuO4ipr7EQqrSDGfzRj2tmUgkJMcNThT6mnNQvNapSPguy(9yZpLm9Bm85kKxZbJFMl(dTswS3uDfvOdTsFwDO65GQj4Hel528yE1YsTrJ1RnAXv8Sn4lccd(iy3rdIuZOJlaBxrbXrlWyIPiT3DTp)a85PFbJt8)RSAQqf4Vun)G662vgMYtPqu7brit7ekV)IhlLenDA8lt0gRPgAMwkGcfmfDbysh(E03JBFxy26(2CCrg7LZspm)by)ww)OcsTc3NitzSKQyFNswODPr3sMjt75yBrvntdMj3sYP1djSD4GGRbSFya45mfKAzpQZcVuv16yUm15oWZbD4L88AqTAynVgHshVJuNdd(gMTzJHfw1Hcp2gNLTNt79bJrxoBCURS4ZqPjPO5a7Zz6ZM66s8jLvUkLLLmpVxKfJykIttTSNsL3T06Lic5kXxrK1ol5SO(ksDKpeDei4XrUtQr8JXZkFBJeSnB0pMQxrQAVxrmheh9tKeAKlVKhyLlZUhVAXOyaqiKgiOSiPqfISH0ccS(LFkEpYs0HmYsUSB4F16aaPKurJc0fBhcNsaNLCUHhzLdYFj26GJDNNosl0IqfIY7BBCktD4srNJv0zbs4tb0trbwYTB1YOIXd1sugTKPUi6KwqaHWrt7hhYofJkVme2Zz5oxQpJSAJxAg)5i2Qtg6N5GREtm0)ptJZsQyQNaKFSIz16mHhvYUk0F7iLSVLts6r1zbcvoUL(TQ1GZH0YmNqSr6l8iWHUuUaCjaD8GwK1sBbv68xrgvjIw(Ho7DpKwTYcfx7HuhartQOSozIpqXabn8eC8dMNooRMLsGFqYKq2qyJrT0gooEDi5RlSBFKxsJX(ynM7H3Hz6KN0pBKdMAM9BJdMJyOirfkSQjFLgRPX(BTyhXOfqZyB1h5qjskj3iKmpwQ1k47avfFQeg)AdKG2OC0A58vkJVcqRO3suXv197JwP3iJFKC4AB1d0jybeogT1YEZq2nmQk)JwOVdSpz(zM(T((qUjJ8MADzx6E0I2)bEx3FXd2ALoRSpFxCKHZFZEwDwVv8CdHQuodryzgXJPZEUeRf946csr)bR2c4(d4WwV64L(hgBU0GCqcKtpJEarSgyFjZEfMwql0iYLEubxoXT6eIpZ21d1jxcn0GEK0bADPhs48sajBpyrxSjimdCasbVHB41o0iKNXQq0iBCpOvEo8Il6Tsy6KqnZdyzDPkwjw91Kex9z30cfSz)dRTcNHWMdnRjfffJMoqZblAQB(16L6K4Ak1wVm(KZWeOConlsr494WhQ5249rD3wOkxYfXNKSXly8jMk5b2IoXR4rl6N9IbrKaA84OkAArXW6u(qKvTeAZo2341uA)gWb1zp1h4cPln3dbfmKFfh5rgVqckOLNAZwRuJPnD9l6OLzAGBRbe)oZSW)x4grr(ygxmRrN9B9vMLpfd7dKiCqV1h4i64cLeqgfDEEhUb0ftoyInXlIyeJyyBNl6Q4wDrm4wEzij(fRm1YTQHx8UBZwnp9YO1LKl2iawCIAUzg0Q42GwraFznDN92)7mwDKBUzQ8Petr2xT5fdFgZrvygyrmIx2GKvDpBwKcPnwx7BjK6Xy)jNmR4BlQUAJmt8fqHHZER(n7ztUPw0KjjNkWI6HEzOVBlKTAlJF6rcJuFZbPC(Qn9mVBzZ(UvndSOSqs8NbBzEdljIUNAcBzEzggmjS6ONItxy(tCG4t1pI9jiYN37EOeZP051FmL2pSHN4SrQUXQlytMJdZbXlWisEi1seGQIGhckt6TIpqbvCpyBiNAcDIycbq9knPx9qYXD3kl5MVIzGXBQsRHEk)A1A4zaCAxLQddzvm)X9jPsa4Z3H9RfUuEPugNei8rHkp8obYcgBwwfhls5iYQAkoGjeOA(bt2AXJJVSmvrwWYKugPjkDMsm3a74oTEBH7g8GDhFGnNayBuPRGpPbtk2iDIzQG9gwG1gNz2P8)zjUlW4hmQy8ohAZDO1yYRy9Xb3pNStgxKQuruLX2IG03u8SeBeszvXj61hweKLsBZwywuwCtRMw5jolmxmgJZxUc5faYI6GOWJ0BZGmbayMgnhsSOqbHqwvwCN7FK8LbRmk4LTKtAuf3GxlHtHFt4MCC3axxxd4urC8qI0dUXnhX)OsTzdBc1umPzS5UJQH0h2UIR70T7mK97jdni0eQSWBtmNTde8ASpH)qIC6ollTXOjx(AsEyNCrEEgvDwsxRSB19AKQe8VB3PIIbQXPlBzHfACe03XBoiROKC1qW1fl0WkH9sN5MMi0910aGdvg1Tzi2ZHe6mB8NKklnE9nm52Wn4ahCL4hKQhD9DSwWfwcHrQgOl6leJGlCOqu6PnV7FYAuyWLpnBkud7)Nu2KVMpvERR8YNjrykMFVqHSDXQjT1HscMMkBJRK3ubmZa6cygCVuzdMpJSKJqBThITDK8sCWKUJkC1VLGxnD0A2gr7AoSjrpbsP5zApN)Vq9g4LSLiXr4W4Mc4bykDAjCOv0e83cYpQM5tX4OieNiYC3urNgh5GjakL(O7oXXQTMQj0QCpwBAeNPVNIyAlNP1Og)Un9xo)k4JGPeetEVesOm4gEHGtJMyOYpB3GqHrkIYohWjCBQLwU7OXHj5PSuZpsEj1qai0rb(jjpqBwf2MAHSUOf7MHmX7Q0OJ2Md2kWh3GlxiTMYMkQ7Ysxns1yuDehuuJJKdiTZaXab3NQyqODhBty2e6HQdX1)sxZ3SwlP75FyVR(1Ix53INboeRKOjOI436M82Df0aOz(OyzucIjcEo)aFSHlshFOLxGlEpLNscwCGbBO5zCZyMLn1sM2uMcg7rkAe0B6g5kyQwgifka36)6J2V6nEqsVxQMwXkZRWo6m2SykhFY3FW3nOAkuXdbsTtzPBljWyq4nEJxO7TE3vVZnP(Mu5XGQ2yfrRvIsDAVSv1sVCumHN2tYz4iAMtWYvEnY5d9QF)T69g39pD2ZL(wdqzd7XDhjVTKnEKZNb6E8Uurx3EQfuw71Zy7ilD2F2569(xR7f(Y4tK5EF1BS6d)Wn(Y3U3BD7F4bVkTOVdSJriaG(yVV6Y9(9xNS1rx9o3R31o7Qp81iBAeuQeWw9oxA1h8UKnOlkVRFRVdXScrEjdL0oojdBAgfRk18PuObjNwiywLKtyAaU5TZINAOgxu3M9M3gGAoOTLkp9BoFRku6wDw7rmGIkwkh2asfDlsNZ8XbNlNyTmTX9ZqRxnfWY7(XyQctRoL9RAF0KnSt23uDZkAKI20YG(eXh026uzmvnkeVr2uDRgP3DHBAV42VEY1cV5U58OBM9zB29BBF472nJlAFe5M2(ZvTz2DTz2LTMCBRHWJlMzxZjeNwE9nfxEzd33AX84gVbVvWJlPTOf8463TqPpGqmvx4RzEqsFIfXbozcnQhmT3927MFC3RDdwsO6tWT)CmSYalJ2Hv4rjzACLYrb2eFrmd)upDO404PU06nV9hmEb08xyR)w1Qc0P2IX1yAqP8uixg6DJ3wjwCxUA)UxJfdk6xA6Dszl3KM(WrzYjwLW0NfGjpg2G2k3RDr5CVC6JYguC72CmXPSEhdVv27EB6Qu7EpPx2pI2gRg3kRrvq17M1mSHOiheRu3VKpUWk6qoBjJ3LurN32rrooKqTIalno(k3CE4LVvIzYPV23hEoIU2hlPHSL0(N642Wpe1MA4DcOdPkPXo)PxXJ80CDwG8cnLX(N64Vcs(Erhq0rN2Kuwe2)tafkOZcXpVGFZAZtoNIgNC9ha8f5fpQ9PcdG6JY9UkKyePvnjGevRLtjSwJNLiRDZ4Tp)qcD2AnqJ5PPe6TytM05qRwygKKoUbgWz17C)1U6RUX79rXFuB8vqpqHX(6nh(hIdpkQZhMW5)ln4QN3Bzu7m0lNH9TvE5TL7chd2A1WUSH5UNajjaJ(KNamCS2W0U5K3jOWn86wdwG7j2iPVXxJSCqEM(FBTTfTJ2uHg1xw2QUMSHlpnHGuXSJ1zIKGcAJDMkwSeh7d4hHXWIr9JzhoJ44vhbe5fIwQco)uN8(qyIvOGHJazsd0xpezmClKgaiDBpLsWHKsSHq05gFMxOk6JfMLizscXy1glsdA54he3IFGm39Gf9kEcqa7WnqsN8McmGpcWs((GYjWkntk4R0eug13MHW8i6uDvWr4f05rIijCjrDMOSpPCUCMJSdaZjNQfXVvAfGDspBUaGr1mGkYujgpITSsbl3N8mnaRD9TW52HkQo(W99XeDhPpoHWRMGl4FDTuyE4mBCcJuYsrrVrMj2IXRHuKpOTSe(W2X5vNawbGHOSQ0GMLWArJRF1JvPxfyUg5nhcYM8WLHGWtwWx8aivrSDmaMXMUaksYHjsblHDno2mZvtHfBJROXP3)v0SeTuQuHvu6GqqFAuLZ6wOCPIGivByrQaw8dtclGj)GLlNc8MNyLUb52PXvsiHt1hNZsunMd(InpjJ7u04rQU5NXYIMZE9fDk9uPKp9DXcaY0)wzOYgaMyMwulT0qgakSvOBJ5jY8k9ugkAL7XpH6MWa2uNFKeZA6e4A)XvN(jsylHKNnm9b9sfJs6OXOh8Yam5Ng8Ej0UFkdKAVEgWOz3rrAyuruwRaj(aouJr3feBkZwLsEPXMeiULaBbdHq4J6qh3uJzliIZvVjDfIVWnJffy1WpDXwk0tinllSvzDHTolmyVvgui9CtATHTqloWB1HkWDg3pBhQaX8mMgJz(OqPzp821sYaEmjMmwqATGkwzIDcDTy7wiU6IuUkA1z6a(RrlXbh4ePxrTdQ921X8L5KuHrXNYYk((8YqPzJKKnZkXf7G7RRPL(Q2z3kwTO(zZ9AJzL)K4Yf2DvSm92jSvadPl716QaVLWOSx11D)FKvuYZyUjrB6IMSsHE7lqnY5u3HVLQXFw16FRAEZZKHQH4ka2Hf51Ka5mTsaR0FxJVHXNbFPDrmQq5LW(9g)moZsMC(P1ai)LoJUGARpIFoPjFJdYiiaoSH6bNr0IS3qKGmsRtXYGprZv6aFZEDdJoCQXAOuNjyxqlnbU0lhubfikpCIBiZ3o4ptp4qCiqmnOMOCjcWP7SSxB)f1iUbGYoDE8IdRiyzO7i9ULOTFszlbDmsVcuo6jSXZZXSZAYvu3EUPGficBHTd22liGht8XAQ1yIffSB)fBqa(Mhjcb0xTQG53CxjyqibTxXRMxYKN0P1GOIDrZowbyAnP1(GijmdouguiNJvjo2avQPnvYijvQSrQp)vDd1cryOzP5uqIWro)45KA76xRoEojuPu70lUK3IhFa8J5muskcWvncOwqs8eHBKv60HM4GUn9AqsWErulOuyds2KIELf0kmdw81GdQlhzlSJr5rFeKVqyFUImcDbLTfc11UIh)GhHBASVgEniI2Tx)3KALCZKeB8Mzh1TnjIsdcWEDHWioDRiKr1edI14JRWcwGIibBIxJsfSTFSeLud)y1bIXad4071V0Qp8A6SveaWl)2DV8h2hd)yRK8nbcNvMp27izlEl2QoNhEj)qp15Ko(PM1NyJlO5o2EaoJdbbPaSwCv5n(s6ftefhxZi5yHqdbbmAkJNwvoz0BMK)dI3J5K8YKi(MKxQTLoNUrja0ttifZ7VGPz8zpeImNT0NNNByaevXebzICWKyENCVn)34Jtw8ppx82D2z50yJzPKBPmZZ6Dm)aehX(B1gZqfKp3WnpnyaPTwMwY1VqFW2gNXmW4AwoUOLjixleliDYoK6rp9cHk3VyQm3icuBw9Sohj8F(gZyZwO6Vuy8LxXF8gmrMXkvL7yp1jk0x8Kcwb5Pgsw6IoMuvwqzqlyAV1x39Hx9VjIxVi(uvuHqc3kzXZiJl3rUy68TCcPNKnV9HsgI5xqLdrFT(XVu3p589E7VBTp5Ep(81AD12XNv7pesmZbiP30UsIiwSr40xKc25xUyvRJm69HgsbwzusTEAkWkfIiPYy13bkRbEmark5SQBGXIKjfAW2VEFBlZZBsEDR)94gAEHjcMBj)6HpR3PX3WJg8Wkn6XhhFEqb95O8msl321ObYPzFZc(4aB2WHrvOtGgKaFiF8xhDPwTc8gP1PqZQcBfP8fkKPJvSyenb(oMyse)rEGjr9jdcUDpksGy7wnSOLVpWiQhAfyJZKcIFm5ttZ8d8Mwmk6kLmTivq3GM9hMnOgqr9bfNAFJ7)Bw)IFZ6V4R27D(QTzR9mXfAUrgE0ND8zN5qtlUhYsX4M0KXENjcJLJ2sLLlnKnnMslCmWytENsAnP)UVR3hEEJ3SX0Dx1)BYE5I4Ki6g7s5guLqd2CXFiTnBWbKB5BNNbnhwIc1i2aJj(YuUI68OYB3mVj7HAHmk5tBXjCJMYen7g37YyTeLbfkGmXJgLzJrwjdmrOL(RrahTfIyMVCjSNhFg4FipPit4lqh8wyiI)8m2W97ViZUerXOaIkuRDZlU29(CD(VDW0CGBkERDqTERvPn(HQzCG2q4sQOiBy9LX7UsnjYXIALOcm2u6GwcLAT7)BexhwYEXenoY0HXMDuslOMvYOVVjKtfRFt2T24wOYl(klpJd0jcMsK067BLmLDVYLw7Z)6(nOc67iiq9Y4OmLmQxpOmfnK5aMG3pu1f0Vxmgly4OrkJSRJf0zH85EIJGkMC5ke96rjVQiN)8obH(1p9bYNdxDvvRqcAoCB3vu5fEDIoqpnnyanndiGlh2RDrXbejNgV0zphfnbuOQVfTHLHRY9YWHcMIeP7hyciMgDreUpOkr7)KHND(dpZSp7prRlpjbQ5qfDuDDbXnJ0pbOV)euTcH2OhX90is7kE1IxeE5hzEPvtN1sOf2uJ4XzrP8AhGT2F4(DF)x5VeK6ZpiJFwFzx1tSSdzWuLDizASQJFe2nu)r1EGSr3q9geDZp0KzB7NHLlKKFPkgCul4GpQfmJAfNSAgKKNlxk3BFPkXWGaboX4sseo7VD9BD9EV1T79ExxbBvGOYXWL9BNGrCBRz5jbwkkwwpYaJkrY)fn5MX4hbMmmIISg3UIhSBRE6MqgBqaIx)Zova9u(O1AEQNZTrhVa880Lf34wbz0CGl4cWgi3zFX)LvF47G6S34T(3uTkQOllj6gckD5jC5OFN9wcjcr(d09hBGSHK65LYEkNxACukXMm376SHjj(bnB9s46t6KWulW5dWZuwL51XgmncMbhsbiXxpkdkT0E2drXnLXt1D0le3aKdTq1wtvTeiXq9FhO(WDyTXZW2bK9gUUkt6wAuqT44qRKzBJU1Pm7tzEQwTMxj1jcsUWSb93OpI0flxo1ZxUvFHHRCyM672BlMyKRofFePU1vHKIOjXzEj94IxY6swYJ3V0mqR2WFAbxPI7CqVS2tEDqQa)9nCMfmiwvSq4argLncierUOOb5j1)RQHBQpoMy760Dt6RMRiBxU(Q4DZQOaBVR9tt0Xw71SVsB4V5UJ7tdLBYl7EZBLVhb19hjxz)gxHeCmBiFXVB09tpAUF3tDtcM5Iv3OWS5nS(KBnBmQ))BVJ1EBISRqPsBLv)qxAfvL9lrUQSXciLKqaQeL24ehIRYRoX0STiKJFmo2loECNXjlHvuLyG8I8acVHWcXLhzPDj00QqEwKw1FawO(lyRh)4tRe)c65CVJTNXEMXJtOPvTnFWX(oN75EU37zo379Cpp2IE867eE0Td2tlgo0LBuMsn4koEfuwTKZpN46txXjqEIsKfPL3pjXijJTOFwq18G5P)Rxx8Ypj5CdV5CYivwSTe(CKchmQWlmLjNAqleXkFATfFAHcCcjD3pGUkiWqUNuPDnjwzX)xPnlAQ8DBjd51qQM7VTyQ8DAiLzryvmVSIrd5ioD5NLnyXut(NziIPyeOILCSzC5OTI7gP9gKhqxx(ISl5P3eM7gIjd6BmYT8R8NYVy3Ard7ptQLuS5yvu8HbSYoUGEv3i4lTPYDSnJrexfRgJ6WJCgHg)tnFqZAzkDzHsFRpRifeKpfiRHUbufd5voqb1Vq9cORvFMVULRXrxqIB(DQz9NpFtxSXaIVam(J(pWxautps57iYuc4H(VMxf2)))vHTTxfu)nHnRT6x2VmOV(sZrLLAtqQ4JLzbwXYgYWWbvtfnf4IkAyJ(BvgD9SKuv6)Y2MtzA89QUbPYw9xUvtpwANuIvnMOPHNsAedVvN3qu2)mUH0wgEtJKBq6RW5WCLxCoMq193wPw7gtJSLq(egR6xlHKZvqEeQ3pLw(D2atUSzBfw0qZCCNvrqoV4ZdQguAqlff08LLQnyCfWldh6wkKq7UL8phdUA5O)M456fbTsl5YVPkdN5YUojJWZIsGWJrPVDkwgHu78MyENrGXwxv(Hnda8HfaqdbD1BywVo4aEow2qfCoRcnt9QLFJMKh6GlmX0TuRITY1pXLTv5r0ePRSimSYCgTkfDAZYYJ0KQB(mKSAQCt2tdl)vjBFjJUXQuwvAY1PbGNUg1sg3YuOUKQs0O6Ytc6fQvmFA4xUWKdAxuYNIkIpxAaYw)aNM6SJwkcUCUPf5xvAUHMR3HZw78KoRVXgBVndub02o7Wjt7D6WgJZt1rJ17WMbQvhTu)VgG3wBqTS32jD2v7mT0ObQxRT3O9MSd1Sthqd5eO22oPnvROsX0yrQKr47N8ozvvvLIS7alDae26xbJgfZGqF5pmpRVaN7av0RqphaDr9i0mqHamZqwnPQcYqiOo8jvbv0FrzzeDZUmsX(s(EW4zpFp1q(SwYNhM8zDKppc5ZJIgyqeEHWbdaddhWmHclmjvkrJuHGD2wL0sk2X4GMKmMOidOGVnLTdtEkjHMONfLLp7GilHgJ9elLijTkhy1IttBYq(CUu7JDbBqNHK6Ak3uAImCPBY5PiLZtsDo)0sNZklArDIaysk6jx2)qT5n1(tL8VIr1xUcD4MnT)yqsFRq2LGKlZOfTAQKop3no7jjNEBH9o3UVlb)T2VmCyTaox(Grj81Pf85VitqaIMeGxkahv90K2wkLePsGwrw4Te2pgSJzGzrVR7u62ODJEC(NQjhtiIsiOP)umP3T8Y0ltW8zoGM1j3TviL1uLDheAvTlyshA0jnLgvIKnubJfQN0HK)hkEgTaUSjXQ85j8pLps1xGgHdWaZZZUcPGk(rcvi3MnGFsHbTaTB(Asjcaq6n0q6uK0ZurZUvctfNgMApd5DjZhNCXY5kdVU5tyg3PhA)1s5dlNDvptBWMcmVjUirJNzL2QtgL1KY)UNC22NKm0kjQfwu3SYTPrXIThb3BHTAO3wlqAw(wr0LJsMv3iZbdnIBWymJXbJwH64omA4uh5SguvSTqzhLbVPelgZyaKELGeDw0Y0cuXtAQoRA50jgMR0Mulzip3Tl(sdeDMtJGWvEWKPWLsJtAeujlC6T5ZYALsdjt6Oxq(eaPaQ4gjFm3I65WWcFZTeYRPQ4WEJ2AIP(wT50H9wTzy53YuUd9OU(Su(sCkXMm3mcKuOpjnfiHflDeSFxjnNRTGCNkLjyXIu(5mh)Fr)(e664gkTFA8gsK3rZNMl1m)xMl4fiVi6oB1ivAM9pjORugXArgwQmxUwLUyLYhHBDLwU2EFF5LnqJqniIUA2ENDyJXS(hMzZWePlhu2MT8yI(FUJPSDT8TUVVSjeU8VKZxPhZ2VILxiaYDZ65SL3oOk3KOBRdaTLCrfeG6hPYsMrCPeDEv0PM(hlMkn25ck1ffO66ifrrQRBZIPjsMw5uH4nUMrv2BQ5DFFjpYRT0ixRBmX4JuAOnxTuZknp2sVvEvuPALzTRWwAWbtlKdSKTegsjw00IQJiXKxTUH1LCb8g7glFW1jjeWiaBhvUFQrk5hBpKqywprmxgRvO15EZ3mQMyF0l1Dk7keS42hSEQGFtrHdo0tpGSG22hV0xFQvCaYAFHce5R6tG1PRGFIRbeW9429xj0NBYeAN95ZxGZTOZgQVth48jJdgs5XAGleSnx8wEI)bUPcJIc99GbT7vWuueDiEZJOoiAgNbwARLwyWu)SGPyEzDdOhffX3STw6OPt1Ym9fsI4mTiiM6Jj8Q9ZwJRqde(9Dr(Ud6ZBLZl7FChH)aakS1jr)n6ECDgw6lmygJYB49Pki4ZCgKThxEgWPVGCC8(F7zzzdxpz(JbfY6p6Ni5f4rZ6o4VXvFr8ZX3o96TWoGGRiOizw)H3V2nJ3bGoCapoJ4NNvWpxqVdy1hCcTWFNM4dC(k(L95YlEzFv4Wb)aT7ZNaBKM)5D)BE(G7yhFJyWWhExjqRT39eFVVb(P7CU)OBQXfmuyZA30WRkor6RBRb5C5Dj8WJqDdVh3cW3cYAfDM6zWzlYnc63DexbHjR9W0BFbJeWedXNF3t8gmndcOtEUGSMwebxcpD)MaHeIGNKHyXmMiOkeGkE)wXrsSQX8ga4H8aiCG9f)Nbenpxapq5wfcCEweGV0dhmMW9jHS5Thw)wXyWr3rXbi8st)bUf46J3dR7a9gMJpsmObKUuD)VrWVlOAFeDmBxZGsEjhA1n9OP10xaVlE(U4)Tn3JfFvFKw5px2r3ZX88Da)fJNm0ImGwXn9TyGq0rpOqtwHjxpN7B2qInMLAK6PVYKP(8vsSYvYm7SMmL8lECx1N8oliE)yIx7oP(dl81RprQBmFIvNk5upj5nwckpZnFT40xtCKvtDVljPFNLgn5qiKjxCoXxmggbjU3LOyGgw2sS8KjwDykWNY()yWOPx4vumLC8XtVWt6QEaJPw7U06qrbaL4tJM8ZMvQWxTyQ1MM(iax0BQm50ZKyTLGgwC6fsS2tGMbOvkmeSc4a6s3)VK8wVKgq9G(RP(RPQFc8F5QenXYxHsoPM6LIZopfBjV9Js)SHPGbikZitk(4jLmY)BVefYmZoy6NouQORioYAPM7fPFXJto3WIxDQKJnz6lUHKPabn4XGgKwdkS04qCYjglZmVaqg0dsS(9Gwai0KtnJ4O3oXgtMAJxanBQ1)8up8lOdDPw76jFWdb0N653wC6FpmSl(4)eolqD)wODok0ojh7kIJpp1yVXho7Gj2ykQB3L5UxvCuyo8Zs)Ylko6lHjDXXMeH5MVuCW1HwlX63rCIBjHEknEZrH5ae3hbXnLoipxC0xHKlL6xEsXHNuEhq8YZN5IZtHeai9GtaCvjE9dsoXqIt9qO7Hvz67GiUUCioZixltShKEPlN(1JuDILhbqomUK(13p9CtadeIdFxGgRVfh7xXOy2XpXfwH2QYPsPWMn0mhgAMAfN8IhSo4dKbD8hbJkIRCzXvFAYBSsILxT6dDiat1cn8bRd(qlyoeITAZr0WmEInUU40)5elpE6NnduRm37QPV90sZUKAjF(gRDnyTNymk6PDaktxkGzfErB8XP8o0CmcGaXRoAgGz4ExsY)CbCunYetEdjXgpcPvsneF8ZHPBjuszwNB4SVfUAQvJLESfXAd9uKHtCiC4f4uawMu3yTVE97dKvQ1Ue2E3aznPKf86zMbhk5O3k9ZIkUWdProIyWkFsr7Il9TvDjlpsFXAiyF(VLeRlc5kO0w3VE4FO2c4dZZ6jac1UEliggwCICChuKM7oBaDYRf9L3Es2v4VxwzTiQYA(L(5)yQF2zfTpUyr480pTL)w9)3mhWB4V7XPsrobDEScuWWmOzdrKuEK4VFtX3B8U)swxcy7WgQNi(FV3K9OkKfg4fybP6EfIIWGex8UTss8VyfJh89I3B8qX5GV(9lSKW7gK43Gerdl6ZGlMXqSP1HSEEoUE3PBaZ(c0JjyTnKSz9ZqsNj7Ar6Ydenh(l25o35UwuAu0oub3vxBTh9yhoA2HJUJ5j3gAmTBb31vv1qNC39)3)O)5p
    ]]
    -- 更新记录
    local updateTbl = {
        L["v2.9：匿名模式下团长现在可以无视匿名。重复出价时现在需要点击确认框后才能出价"],
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

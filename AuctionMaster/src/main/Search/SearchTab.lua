--[[
	Copyright (C) Udorn (Blackhand)
	
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.	
--]]

vendor.SearchTab = vendor.Vendor:NewModule("SearchTab", "AceEvent-3.0", "AceHook-3.0")
vendor.SearchTab:SetEnabledState(true)

local L = vendor.Locale.GetInstance()
local log = vendor.Debug:new("SearchTab")

local AceGUI = LibStub("AceGUI-3.0", true)

local SCAN_TOOLTIP = L["Scans the auction house for updating statistics and sniping items. Uses a fast \"GetAll\" scan, if the scan button is displayed with a green background. This is only possible each 15 minutes."]

local function _NotScanning(self)
    local isScanning, getAll = vendor.Scanner:IsScanning()
    if (isScanning) then
        self.getAll = getAll
    end
    return not isScanning
end

local function _OnSniperClick(checkbox)
    local self = checkbox.obj
    local selected = checkbox:GetChecked()
    self.itemModel:SetSniperVisibility(checkbox.sniperId, selected)
    if (selected) then
        vendor.Scanner.db.profile.snipers[checkbox.sniperId] = true
    else
        vendor.Scanner.db.profile.snipers[checkbox.sniperId] = nil
    end
end

local function _PickFromCursor(nameEdit)
    local self = nameEdit.obj
    local type, _, itemLink = GetCursorInfo()
    if (type and type == "item" and itemLink) then
        self:PickItem(itemLink, true)
    end
    ClearCursor()
end

local function _OnUpdate(frame)
    local self = frame.obj
    if (_NotScanning(self)) then
        self.search:Enable()
        self.scan:Show()
        self.stop:Hide()
    else
        self.search:Disable()
        self.scan:Hide()
        self.stop:Show()
    end

    local _, allAllowed = CanSendAuctionQuery()
    allAllowed = allAllowed and vendor.Scanner.db.profile.getAll
    if (allAllowed and vendor.Scanner.SCAN_SPEED_OFF ~= vendor.Scanner.db.profile.scanSpeed) then
        self.scan:SetNormalTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\UI-Panel-Button-Up-green")
        self.scan:GetNormalTexture():SetTexCoord(2 / 128, 78 / 128, 2 / 32, 22 / 32)
        vendor.GuiTools.AddTooltip(self.scan, SCAN_TOOLTIP)
    else
        self.scan:SetNormalTexture("Interface\\Buttons\\UI-Panel-Button-Up")
        self.scan:GetNormalTexture():SetTexCoord(2 / 128, 78 / 128, 2 / 32, 22 / 32)
        if (vendor.Scanner.SCAN_SPEED_OFF == vendor.Scanner.db.profile.scanSpeed) then
            vendor.GuiTools.AddTooltip(self.scan, L["(Fast full-scan deactivated)"])
        elseif (vendor.Scanner.db.profile.lastGetAll) then
            local diff = GetTime() - vendor.Scanner.db.profile.lastGetAll
            local remaining = 15 * 60 - diff
            if (remaining < 0 and remaining > -10) then
                remaining = 0
            end
            if (remaining >= 0 and remaining <= 910) then
                if (remaining > 60) then
                    vendor.GuiTools.AddTooltip(self.scan, L["(Fast full-scan available in %s)"]:format(SecondsToTime(remaining, true)))
                else
                    vendor.GuiTools.AddTooltip(self.scan, L["(Fast full-scan available in %s)"]:format(SecondsToTime(remaining)))
                end
            else
                vendor.GuiTools.AddTooltip(self.scan, L["(Fast full-scan currently not possible)"])
            end
        else
            vendor.GuiTools.AddTooltip(self.scan, L["(Fast full-scan currently not possible)"])
        end
    end
end

local function _ClearSearch(self)
    self.nameEdit:SetText("")
    self.minLevel:SetText("")
    self.maxLevel:SetText("")
    self.rarity:SetValue(0)
    self.maxRarity:SetValue(0)
    self.classIndex:SetValue(0)
    self.subclassIndex:SetValue(0)
    self.usable:SetChecked(false)
    self.exactMatch:SetChecked(false)
    self.unique:SetChecked(false)
    MoneyInputFrame_SetCopper(self.maxPrice, 0)
    self.bid:SetChecked(true)
    self.buyout:SetChecked(true)
end

local function _Clear(self)
    self.itemModel:Clear()
    self.itemTable:Update()
    self.possibleGap = 0
    self.statusBar:SetValue(0)
    self.statusBarText:SetText("")
end

local function _DiffSearchInfo(self, searchInfo)
    return searchInfo.name ~= self.nameEdit:GetText() or
            searchInfo.minLevel ~= self.minLevel:GetNumber() or
            searchInfo.maxLevel ~= self.maxLevel:GetNumber() or
            searchInfo.rarity ~= self.rarity:GetValue() or
            searchInfo.maxRarity ~= self.maxRarity:GetValue() or
            searchInfo.classIndex ~= self.classIndex:GetValue() or
            searchInfo.subclassIndex ~= self.subclassIndex:GetValue() or
            searchInfo.usable ~= self.usable:GetChecked() or
            searchInfo.exactMatch ~= self.exactMatch:GetChecked() or
            searchInfo.unique ~= self.unique:GetChecked() or
            searchInfo.maxPrice ~= MoneyInputFrame_GetCopper(self.maxPrice) or
            searchInfo.bid ~= self.bid:GetChecked() or
            searchInfo.buyout ~= self.buyout:GetChecked()
end

local function _FillSearchInfo(self, searchInfo)
    searchInfo.lowerName = nil
    searchInfo.name = self.nameEdit:GetText()
    if (searchInfo.name) then
        searchInfo.lowerName = strlower(searchInfo.name)
    end
    searchInfo.minLevel = self.minLevel:GetNumber()
    searchInfo.maxLevel = self.maxLevel:GetNumber()
    searchInfo.rarity = self.rarity:GetValue()
    searchInfo.maxRarity = self.maxRarity:GetValue()
    searchInfo.classIndex = self.classIndex:GetValue()
    searchInfo.subclassIndex = self.subclassIndex:GetValue()
    searchInfo.usable = self.usable:GetChecked()
    searchInfo.exactMatch = self.exactMatch:GetChecked()
    searchInfo.unique = self.unique:GetChecked()
    searchInfo.maxPrice = MoneyInputFrame_GetCopper(self.maxPrice)
    searchInfo.bid = self.bid:GetChecked()
    searchInfo.buyout = self.buyout:GetChecked()
    log:Debug("FillSearchInfo name [%s] itemLinkKey [%s] unqiue [%s]", searchInfo.name, searchInfo.itemLinkKey, searchInfo.unique)
end

local function _InitSearchInfo(self)
    log:Debug("_InitSearchInfo")
    local searchInfo = self.searchInfo
    _FillSearchInfo(self, searchInfo)
    searchInfo.observer = self
    return searchInfo
end

local function _Stop(self)
    log:Debug("_Stop")
    vendor.Scanner:StopScan()
end

local function _FinishFullScan(self, result)
    if (result and result.scanId and not result.cancelled) then
        vendor.Scanner.db.factionrealm.lastScan = date()
    end
end

local function _Search(self)
    _Clear(self)
    local info = _InitSearchInfo(self)
    vendor.Scanner:SearchScan(info, false, self.searchModules, _Stop, self)
end

local function _Scan(self)
    _Clear(self)
    self:SetProgress(L["Performing getAll scan. This may last up to several minutes..."], 0)
    vendor.Scanner:FullScan(self.scanModules, _FinishFullScan, self, self)
end

local function _Bid(self)
    log:Debug("_Bid")
    local rows = wipe(self.tmpList1)
    local auctions = wipe(self.buyTable)
    for _, row in pairs(self.itemModel:GetSelectedItems()) do
        local _, itemLink, _, name, _, count, minBid, minIncrement, buyout, bidAmount, _, _, index = self.itemModel:Get(row)
        local bid = minBid
        if (bidAmount and bidAmount > 0) then
            bid = bidAmount + (minIncrement or 0)
        end
        local info = { itemLink = itemLink, name = name, count = count, bidAmount = bidAmount, minBid = minBid, buyout = buyout, bid = bid, index = index, minIncrement = minIncrement, doBid = true, reason = L["Bid"] }
        log:Debug("name [%s] minBid [%s] minIncrement [%s]", name, minBid, minIncrement)
        table.insert(rows, row)
        table.insert(auctions, info)
    end
    self.itemModel:RemoveRows(rows)
    local n = #auctions
    if (self.getAll) then
        --vendor.Scanner:PlaceAuctionBid("list", auctions, self.possibleGap)
        local task = vendor.GetAllPlaceAuctionTask:new(auctions, false)
        vendor.TaskQueue:AddTask(task)
    else
        vendor.Scanner:BuyScan(auctions)
    end
    self.possibleGap = self.possibleGap + n
end

local function _Buyout(self)
    log:Debug("_Buyout")
    local rows = wipe(self.tmpList1)
    local auctions = wipe(self.buyTable)
    for _, row in pairs(self.itemModel:GetSelectedItems()) do
        local _, itemLink, _, name, _, count, minBid, minIncrement, buyout, _, _, _, index = self.itemModel:Get(row)
        log:Debug("name [%s] minBid [%s] minIncrement [%s]", name, minBid, minIncrement)
        local info = { name = name, itemLink = itemLink, count = count, bidAmount = bidAmount, minBid = minBid, buyout = buyout, bid = buyout, index = index, doBuyout = true, reason = L["Buy"] }
        tinsert(rows, row)
        tinsert(auctions, info)
    end
    local n = #auctions
    self.itemModel:RemoveRows(rows)
    if (self.getAll) then
        --    	vendor.Scanner:PlaceAuctionBid("list", auctions, self.possibleGap)
        local task = vendor.GetAllPlaceAuctionTask:new(auctions, false)
        vendor.TaskQueue:AddTask(task)
    else
        vendor.Scanner:BuyScan(auctions)
    end
    self.possibleGap = self.possibleGap + n
end

local function _InitFrame(self)
    local frame = vendor.AuctionHouse:CreateTabFrame("AMScanTab", L["Scan"], L["Scan"], self)
    frame.obj = self
    frame:SetScript("OnUpdate", _OnUpdate)
    vendor.AuctionHouse:CreateCloseButton(frame, "AMSearchTabClose")

    local statusBar = CreateFrame("StatusBar", nil, frame, "TextStatusBar")

    statusBar.obj = self
    statusBar:SetHeight(14)
    statusBar:SetWidth(622)
    statusBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    statusBar:SetPoint("TOPLEFT", 70, -17)
    statusBar:SetMinMaxValues(0, 1)
    statusBar:SetValue(1)
    statusBar:SetStatusBarColor(0, 1, 0)

    local statusBarText = statusBar:CreateFontString(nil, "ARTWORK")
    statusBarText:SetPoint("CENTER", statusBar)
    statusBarText:SetFontObject("GameFontHighlightSmall")

    self.frame = frame
    self.statusBar = statusBar
    self.statusBarText = statusBarText
end

local function _InitSearch(self)
    local frame = self.frame

    local nameLabel = frame:CreateFontString(nil, "ARTWORK")
    nameLabel:SetPoint("TOPLEFT", 80, -41)
    nameLabel:SetFontObject(GameFontHighlightSmall)
    nameLabel:SetText(NAME)

    local levelLabel = frame:CreateFontString(nil, "ARTWORK")
    levelLabel:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 230, -47)
    levelLabel:SetFontObject(GameFontHighlightSmall)
    levelLabel:SetText(LEVEL_RANGE)

    local name = CreateFrame("EditBox", vendor.GuiTools.EnsureName(), frame, "InputBoxTemplate")
    name.obj = self
    name:SetMaxBytes(64)
    name:SetFontObject(ChatFontNormal)
    name:SetWidth(140)
    name:SetHeight(16)
    name:SetPoint("TOPLEFT", nameLabel, "BOTTOMLEFT", 3, -2)
    name:SetAutoFocus(false)
    name:RegisterForDrag("LeftButton")
    name:SetScript("OnEscapePressed", function(this) this:ClearFocus() end)
    name:SetScript("OnDragStart", _PickFromCursor)
    name:SetScript("OnReceiveDrag", _PickFromCursor)
    name:SetScript("OnEnterPressed", function(this) _Search(this.obj); this:ClearFocus() end)
    --name:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
    vendor.GuiTools.AddTooltip(name, L["Drop item here or simply shift-left-click it"])

    local minLevel = CreateFrame("EditBox", vendor.GuiTools.EnsureName(), frame, "InputBoxTemplate")
    minLevel.obj = self
    minLevel:SetMaxLetters(2)
    minLevel:SetNumeric(true)
    minLevel:SetWidth(25)
    minLevel:SetHeight(16)
    minLevel:SetPoint("TOPLEFT", levelLabel, "BOTTOMLEFT", 3, -6)
    minLevel:SetAutoFocus(false)
    minLevel:SetScript("OnEscapePressed", function(this) this:ClearFocus() end)

    local maxLevel = CreateFrame("EditBox", vendor.GuiTools.EnsureName(), frame, "InputBoxTemplate")
    maxLevel.obj = self
    maxLevel:SetMaxLetters(2)
    maxLevel:SetNumeric(true)
    maxLevel:SetWidth(25)
    maxLevel:SetHeight(16)
    maxLevel:SetPoint("LEFT", minLevel, "RIGHT", 12, 0)
    maxLevel:SetAutoFocus(false)
    maxLevel:SetScript("OnEscapePressed", function(this) this:ClearFocus() end)

    local minusLabel = frame:CreateFontString(nil, "ARTWORK")
    minusLabel:SetPoint("LEFT", minLevel, "RIGHT", 2, 1)
    minusLabel:SetFontObject(GameFontHighlightSmall)
    minusLabel:SetText("-")

    local search = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    search.obj = self
    search:SetText(SEARCH)
    search:SetWidth(95)
    search:SetHeight(22)
    search:SetPoint("TOPLEFT", 30, -75)
    search:SetScript("OnClick", function(this) _Search(this.obj) end)

    local scan = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    scan.obj = self
    scan:SetText(L["Scan"])
    scan:SetWidth(95)
    scan:SetHeight(22)
    scan:SetPoint("TOPLEFT", search, "BOTTOMLEFT", 0, -5)
    scan:SetScript("OnClick", function(this) _Scan(this.obj) end)

    local stop = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    stop.obj = self
    stop:SetText(L["Stop"])
    stop:SetWidth(80)
    stop:SetHeight(22)
    stop:SetAllPoints(scan)
    stop:SetScript("OnClick", function(but) _Stop(but.obj) end)
    vendor.GuiTools.AddTooltip(stop, L["Aborts the current scan."])

    local reset = CreateFrame("Button", nil, frame)
    reset.obj = self
    reset:SetWidth(32)
    reset:SetHeight(32)
    reset:SetPoint("LEFT", search, "RIGHT", -6, -2)
    reset:SetScript("OnClick", function(this) _ClearSearch(this.obj) end)
    reset:SetNormalTexture("Interface\\Buttons\\CancelButton-Up")
    reset:SetPushedTexture("Interface\\Buttons\\CancelButton-Down")
    reset:SetHighlightTexture("Interface\\Buttons\\CancelButton-Highlight", "ADD")
    reset:SetHitRectInsets(9, 7, -7, 10)
    vendor.GuiTools.AddTooltip(reset, L["Reset search"])

    local speeds = {}
    speeds[vendor.Scanner.SCAN_SPEED_OFF] = L["off"]
    speeds[vendor.Scanner.SCAN_SPEED_SLOW] = L["slow"]
    speeds[vendor.Scanner.SCAN_SPEED_MEDIUM] = L["easy"]
    speeds[vendor.Scanner.SCAN_SPEED_FAST] = L["fast"]
    speeds[vendor.Scanner.SCAN_SPEED_HURRY] = L["hurry"]

    --	local scanSpeed = vendor.DropDownButton:new(nil, frame, 60, nil, L["Too high scan speed may lead to disconnects. You should lower it, if you encounter problems."])
    --	scanSpeed:SetPoint("TOPLEFT", frame, "TOPLEFT", 110, -100)
    --	scanSpeed:SetItems(speeds, vendor.Scanner.db.profile.scanSpeed or vendor.Scanner.SCAN_SPEED_FAST)
    --	scanSpeed:SetId(SCAN_SPEED)
    --	scanSpeed:SetListener(self)

    local scanSpeed = AceGUI:Create("Dropdown")
    scanSpeed.obj = self
    scanSpeed.frame:SetParent(frame)
    scanSpeed:SetWidth(75)
    scanSpeed:SetPoint("TOPLEFT", frame, "TOPLEFT", 128, -100)
    scanSpeed:SetList(speeds)
    scanSpeed:SetValue(vendor.Scanner.db.profile.scanSpeed or vendor.Scanner.SCAN_SPEED_FAST)
    scanSpeed:SetCallback("OnValueChanged", function(widget, event, value)
        vendor.Scanner.db.profile.scanSpeed = value
    end)
    vendor.GuiTools.AddTooltip(scanSpeed.frame, L["Too high scan speed may lead to disconnects. You should lower it, if you encounter problems."])

    local scanSpeedLabel = frame:CreateFontString(nil, "ARTWORK")
    scanSpeedLabel:SetPoint("BOTTOMRIGHT", scanSpeed.frame, "TOPRIGHT", -20, 0)
    scanSpeedLabel:SetFontObject(GameFontHighlightSmall)
    scanSpeedLabel:SetText(L["Speed"])

    local qualities = {}
    qualities[0] = L["All"]
    qualities[1] = L["Common"]
    qualities[2] = L["Uncommon"]
    qualities[3] = L["Rare"]
    qualities[4] = L["Epic"]

    --	local rarity = vendor.DropDownButton:new(nil, frame, 70, RARITY)
    --	rarity:SetPoint("TOPLEFT", frame, "TOPLEFT", 320, -46)
    --	rarity:SetId(RARITY_ID)
    --	rarity:SetItems(qualities, 0)
    --	rarity:SetListener(self)

    local rarity = AceGUI:Create("Dropdown")
    rarity.obj = self
    rarity.frame:SetParent(frame)
    rarity:SetWidth(90)
    rarity:SetPoint("TOPLEFT", frame, "TOPLEFT", 320, -46)
    rarity:SetList(qualities)
    rarity:SetValue(0)
    rarity:SetCallback("OnValueChanged", function(widget, event, value)
        local self = widget.obj
        wipe(self.maxQualities)
        self.maxQualities[0] = L["All"]
        if (value <= 1) then
            self.maxQualities[1] = L["Common"]
        end
        if (value <= 2) then
            self.maxQualities[2] = L["Uncommon"]
        end
        if (value <= 3) then
            self.maxQualities[3] = L["Rare"]
        end
        if (value <= 4) then
            self.maxQualities[4] = L["Epic"]
        end
        self.maxRarity:SetList(self.maxQualities)
        self.maxRarity:SetValue(0)
    end)

    local f = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    f:SetText(RARITY)
    f:SetPoint("BOTTOMLEFT", rarity.frame, "TOPLEFT", 4, 0)

    local secondMiusLabel = frame:CreateFontString(nil, "ARTWORK")
    secondMiusLabel:SetPoint("LEFT", rarity.frame, "RIGHT", 4, 0)
    secondMiusLabel:SetFontObject(GameFontHighlightSmall)
    secondMiusLabel:SetText("-")

    self.maxQualities = {}
    self.maxQualities[0] = L["All"]
    self.maxQualities[1] = L["Common"]
    self.maxQualities[2] = L["Uncommon"]
    self.maxQualities[3] = L["Rare"]
    self.maxQualities[4] = L["Epic"]

    --	local maxRarity = vendor.DropDownButton:new(nil, frame, 70)
    --	maxRarity:SetPoint("LEFT", rarity.button, "RIGHT", -20, 0)
    --	maxRarity:SetId(MAX_RARITY)
    --	maxRarity:SetItems(self.maxQualities, 0)

    local maxRarity = AceGUI:Create("Dropdown")
    maxRarity.obj = self
    maxRarity.frame:SetParent(frame)
    maxRarity:SetWidth(90)
    maxRarity:SetPoint("LEFT", rarity.frame, "RIGHT", 10, 0)
    maxRarity:SetList(self.maxQualities)
    maxRarity:SetValue(0)
    maxRarity:SetCallback("OnValueChanged", function(widget, event, value)
    end)

    local classes = {}
    classes[0] = L["All"]
    local itemClasses = {vendor.Items:GetAuctionItemClasses()}
    if (#itemClasses > 0) then
        for off, itemClass in pairs(itemClasses) do
            classes[off] = itemClass
        end
    end

    local classIndex = AceGUI:Create("Dropdown")
    classIndex.obj = self
    classIndex.frame:SetParent(frame)
    classIndex:SetWidth(100)
    classIndex:SetPoint("LEFT", maxRarity.frame, "RIGHT", 16, 0)
    classIndex:SetList(classes)
    classIndex:SetValue(0)
    classIndex:SetCallback("OnValueChanged", function(widget, event, value)
        local self = widget.obj
        local subclasses = wipe(self.subclasses)
        subclasses[0] = L["All"]
        if (value >= 1) then
            local itemSubclasses = { GetAuctionItemSubClasses(value) }
            if (#itemSubclasses > 0) then
                local itemSubclass
                for off, itemSubclass in pairs(itemSubclasses) do
                    subclasses[off] = itemSubclass
                end
            end
        end
        self.subclassIndex:SetList(subclasses)
        self.subclassIndex:SetValue(0)
    end)

    local f = classIndex.frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    f:SetText(L["Class"])
    f:SetPoint("BOTTOMLEFT", classIndex.frame, "TOPLEFT", 4, 0)

    -- subclass
    --	local subclassIndex = vendor.DropDownButton:new(nil, frame, 100, nil)
    --	subclassIndex:SetPoint("LEFT", classIndex.button, "RIGHT", -15, 0)
    --    local subclasses = {}
    --    tinsert(subclasses, {value = 0, text = L["All"]})
    --	subclassIndex:SetItems(subclasses, 0)
    local subclassIndex = AceGUI:Create("Dropdown")
    subclassIndex.obj = self
    subclassIndex.frame:SetParent(frame)
    subclassIndex:SetWidth(100)
    subclassIndex:SetPoint("LEFT", classIndex.frame, "RIGHT", 6, 0)
    local subclasses = {}
    subclasses[0] = L["All"]
    subclassIndex:SetList(subclasses)
    subclassIndex:SetValue(0)
    subclassIndex:SetCallback("OnValueChanged", function(widget, event, value)
        local self = widget.obj
    end)

    local f = subclassIndex.frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    f:SetText(L["Subclass"])
    f:SetPoint("BOTTOMLEFT", subclassIndex.frame, "TOPLEFT", 4, 0)

    local maxPriceName = vendor.GuiTools.EnsureName()
    local maxPrice = CreateFrame("Frame", maxPriceName, frame, "MoneyInputFrameTemplate")
    maxPrice:SetPoint("TOPLEFT", minLevel, "BOTTOMLEFT", 0, -18)
    local gold = _G[maxPriceName .. "Gold"]
    gold:SetMaxLetters(6)

    local f = maxPrice:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    f:SetText(L["Max price"])
    f:SetPoint("BOTTOMLEFT", maxPrice, "TOPLEFT", -4, 1)

    local bid = vendor.GuiTools.CreateCheckButton(nil, frame, "UICheckButtonTemplate", 24, 24)
    bid:SetPoint("LEFT", maxPrice, "RIGHT", 0, -3)

    local bidLabel = bid:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    bidLabel:SetText(L["Bid"])
    bidLabel:SetPoint("BOTTOMLEFT", bid, "TOPLEFT", 2, -2)

    local buyout = vendor.GuiTools.CreateCheckButton(nil, frame, "UICheckButtonTemplate", 24, 24)
    buyout:SetPoint("LEFT", bid, "RIGHT", 20, 0)

    local buyoutLabel = buyout:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    buyoutLabel:SetText(L["Buyout"])
    buyoutLabel:SetPoint("BOTTOMLEFT", buyout, "TOPLEFT", 2, -2)

    local usable = vendor.GuiTools.CreateCheckButton(nil, frame, "UICheckButtonTemplate", 24, 24)
    usable:SetPoint("LEFT", buyout, "RIGHT", 40, 0)

    local usableLabel = usable:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    usableLabel:SetText(L["Usable"])
    usableLabel:SetPoint("BOTTOMLEFT", usable, "TOPLEFT", 2, -2)

    local unique = vendor.GuiTools.CreateCheckButton(nil, frame, "UICheckButtonTemplate", 24, 24, 0, L["Finds only the cheapest item (for e.g. recipes, glyphs and battle pets)"])
    unique:SetPoint("LEFT", usable, "RIGHT", 40, 0)

    local uniqueLabel = unique:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    uniqueLabel:SetText(L["Unique"])
    uniqueLabel:SetPoint("BOTTOMLEFT", unique, "TOPLEFT", 2, -2)

    local exactMatch = vendor.GuiTools.CreateCheckButton(nil, frame, "UICheckButtonTemplate", 24, 24, 0, AH_EXACT_MATCH_TOOLTIP)
    exactMatch:SetPoint("LEFT", unique, "RIGHT", 40, 0)

    local exactMatchLabel = exactMatch:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    exactMatchLabel:SetText(AH_EXACT_MATCH)
    exactMatchLabel:SetPoint("BOTTOMLEFT", exactMatch, "TOPLEFT", 2, -2)

    self.rarity = rarity
    self.maxRarity = maxRarity
    self.nameEdit = name
    self.minLevel = minLevel
    self.maxLevel = maxLevel
    self.usable = usable
    self.unique = unique
    self.exactMatch = exactMatch
    self.bid = bid
    self.buyout = buyout
    self.classIndex = classIndex
    self.subclassIndex = subclassIndex
    self.maxPrice = maxPrice
    self.search = search
    self.scan = scan
    self.stop = stop
end

local function _InitItemTable(self)
    local itemModel = vendor.ScannerItemModel:new()
    local cmds = {
        [1] = {
            title = L["Bid"],
            tooltip = L["Bids on all selected items."] .. " " .. L["Auctions may be selected with left clicks. Press the ctrl button, if you want to select multiple auctions. Press the shift button, if you want to select a range of auctions."],
            arg1 = self,
            func = _Bid,
            enabledFunc = _NotScanning
        },
        [2] = {
            title = L["Buyout"],
            tooltip = L["Buys all selected items."] .. " " .. L["Auctions may be selected with left clicks. Press the ctrl button, if you want to select multiple auctions. Press the shift button, if you want to select a range of auctions."],
            arg1 = self,
            func = _Buyout,
            enabledFunc = _NotScanning
        },
    }
    local cfg = {
        name = "AMSearchTab",
        parent = self.frame,
        itemModel = itemModel,
        cmds = cmds,
        config = vendor.Scanner.db.profile.scannerItemTableCfg,
        width = 637,
        height = 294,
        xOff = 188,
        yOff = -112,
        --sortButtonBackground = true,
    }
    self.itemTable = vendor.ItemTable:new(cfg)
    itemModel.ownerHighlight = self.itemTable:AddHighlight(0.6, 1, 1, 0.8)
    itemModel.playerHasBidHighlight = self.itemTable:AddHighlight(1, 0.6, 0.6, 0.8)
    self.itemModel = itemModel
end

local function _InitSearchList(self)
    self.searchList = vendor.SearchList:new()
end

local function _InitSnipers(self)
    local snipers = vendor.Sniper:GetSnipers()
    local yOff = -330
    local xOff = 20
    local checkbox
    for i = 1, #snipers do
        local sniper = snipers[i]
        local selected = vendor.Scanner.db.profile.snipers[sniper:GetId()]
        if (selected) then
            self.itemModel:SetSniperVisibility(sniper:GetId(), selected)
        end

        local row = CreateFrame("Frame", "AMSniperRow" .. i, self.frame)
        row:SetHeight(24)
        row:SetWidth(164)
        row:SetPoint("TOPLEFT", xOff, yOff)

        checkbox = vendor.GuiTools.CreateCheckButton(nil, row, "UICheckButtonTemplate", 24, 24, selected)
        checkbox.obj = self
        checkbox.sniperId = sniper:GetId()
        checkbox:SetPoint("TOPLEFT", 0, 0)
        checkbox:SetScript("OnClick", _OnSniperClick)

        local f = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        f:SetPoint("LEFT", checkbox, "RIGHT", 0, 0)
        f:SetText(sniper:GetDisplayName())
        f:SetWidth(125)
        f:SetJustifyH("LEFT")

        local config = vendor.GuiTools.CreateButton(row, nil, 16, 16)
        config.sniper = sniper
        config:SetPoint("TOPRIGHT", -7, -2)
        config:SetNormalTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\Button-Settings-Up")
        config:GetNormalTexture():SetTexCoord(0, 0.5, 0, 0.5)
        config:SetPushedTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\Button-Settings-Down")
        config:GetPushedTexture():SetTexCoord(0, 0.5, 0, 0.5)
        config:SetHighlightTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\Button-Highlight", "ADD")
        config:SetScript("OnClick", function(this) this.sniper.config:Toggle() end)

        yOff = yOff - 24
    end
    return checkbox
end

function vendor.SearchTab:OnInitialize()
    self.db = vendor.Vendor.db:RegisterNamespace("SearchTab", {
        profile = {}
    })
end

function vendor.SearchTab:InitTab()
    log:Debug("OnEnable self[%s]", self)
    self.buyTable = {}
    self.tmpList1 = {}
    self.possibleGap = 0
    self.searchInfo = {}
    self.subclasses = {}
    _InitFrame(self)
    _InitSearch(self)
    _InitItemTable(self)
    _InitSearchList(self)
    _InitSnipers(self)
    log:Debug("SearchTabl itemModel [%s]", self.itemModel)
    self.scanModules = { vendor.SniperScanModule:new(self.itemModel) }
    self.searchModules = { vendor.SearchScanModule:new(self.searchInfo, self.itemModel) }

    --	local itemName, itemLink = GetItemInfo("Hessonit")
    --	log:Debug("Hessonit [%s] [%s]", itemName, itemLink)
end

function vendor.SearchTab:Hide()
    self:HideTabFrame()
end

function vendor.SearchTab:UpdateTabFrame()
    AuctionFrameTopLeft:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\SearchTab-TopLeft")
    AuctionFrameTop:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\SearchTab-Top")
    AuctionFrameTopRight:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\SearchTab-TopRight")
    AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotLeft")
    AuctionFrameBot:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\SearchScanFrame-Bot")
    AuctionFrameBotRight:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\SearchScanFrame-BotRight")
end

function vendor.SearchTab:GetTabType()
    return "scan"
end

function vendor.SearchTab:ShowTabFrame()
    self.frame:Show()
    self:UpdateTabFrame()
    _ClearSearch(self)
    _Clear(self)
    self:SetProgress("", 0)
end

function vendor.SearchTab:HideTabFrame()
    self.frame:Hide()
end

function vendor.SearchTab:GetTabId()
    return self.id
end

function vendor.SearchTab:SetProgress(msg, percent)
    self.statusBar:SetValue(percent)
    self.statusBarText:SetText(msg)
    if (msg and strlen(msg) > 0) then
        self.title:Hide()
        self.statusBar:Show()
        self.statusBarText:Show()
    else
        self.title:Show()
        self.statusBar:Hide()
        self.statusBarText:Hide()
    end
end

function vendor.SearchTab:ScanFinished()
    if (self.frame:IsVisible()) then
        PlaySound(SOUNDKIT.AUCTION_WINDOW_CLOSE)
        self:SetProgress("", 0)
    end
end

function vendor.SearchTab:PickItem(itemLink, exact)
    log:Debug("PickItem")
    local name = vendor.Items:GetItemData(itemLink)
    log:Debug("name [%s]", name)
    if (name) then
        _ClearSearch(self)
        self.nameEdit:SetText(name)
        if (exact) then
            self.exactMatch:SetChecked(true)
        end
        _Search(self)
    end
end

--[[
	Returns the name of the single selected item, if any. Returns nil, if no item is selected. 
--]]
function vendor.SearchTab:GetSingleSelected()
    local map = self.itemModel:GetSelectedItems()
    if (#map > 0) then
        local _, _, _, name = self.itemModel:Get(map[1])
        return name
    end
    return nil
end

function vendor.SearchTab:SelectSearchInfo(searchInfo, search)
    log:Debug("SelectSearchInfo saveName")
    _ClearSearch(self)

    if (searchInfo.name and strbyte(searchInfo.name, 1) == 0x3d) then
        -- name starts with "="
        searchInfo.name = strsub(searchInfo.name, 2)
        searchInfo.exactMatch = true
    end

    self.nameEdit:SetText(searchInfo.name or "")
    if (not searchInfo.minLevel or searchInfo.minLevel == 0) then
        self.minLevel:SetText("")
    else
        self.minLevel:SetText(searchInfo.minLevel)
    end
    if (not searchInfo.maxLevel or searchInfo.maxLevel == 0) then
        self.maxLevel:SetText("")
    else
        self.maxLevel:SetText(searchInfo.maxLevel)
    end
    self.rarity:SetValue(searchInfo.rarity or 0)
    -- removed value 10 with version > 3.6.1
    if (searchInfo.maxRarity == 10) then
        searchInfo.maxRarity = 0
    end
    self.maxRarity:SetValue(searchInfo.maxRarity or 0)
    self.classIndex:SetValue(searchInfo.classIndex or 0)
    self.subclassIndex:SetValue(searchInfo.subclassIndex or 0)
    self.usable:SetChecked(searchInfo.usable)
    self.exactMatch:SetChecked(searchInfo.exactMatch)
    self.unique:SetChecked(searchInfo.unique)
    if (not searchInfo.maxPrice or searchInfo.maxPrice == 0) then
        MoneyInputFrame_ResetMoney(self.maxPrice)
    else
        MoneyInputFrame_SetCopper(self.maxPrice, searchInfo.maxPrice)
    end
    self.bid:SetChecked(searchInfo.bid)
    self.buyout:SetChecked(searchInfo.buyout)

    if (search) then
        _Search(self)
    end
end

function vendor.SearchTab:FillSearchInfo(searchInfo)
    _FillSearchInfo(self, searchInfo)
end

function vendor.SearchTab:DiffSearchInfo(searchInfo)
    return _DiffSearchInfo(self, searchInfo)
end

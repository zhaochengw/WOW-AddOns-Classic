-- Browse.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/21/2020, 10:59:31 AM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local BUTTON_HEIGHT = 18

local Browse = ns.Addon:NewClass('UI.Browse', 'Frame')

function Browse:Constructor()
    self.scaner = ns.BrowseScaner:New()
    self.scaner:SetCallback('OnDone', function()
        self.isSearching = nil
        self:UpdateAll()
    end)

    self:LayoutBlizzard()
    self:SetupSortButtons()
    self:SetupScrollFrame()
    self:SetupEventsAndHooks()
    self:SaveSorts()
end

function Browse:LayoutBlizzard()
    self.BuyFrame = CreateFrame('Frame', nil, self, 'tdAuctionBrowseBuyFrameTemplate')
    self.Name = BrowseName
    self.SearchButton = BrowseSearchButton
    self.PrevPageButton = BrowsePrevPageButton
    self.NextPageButton = BrowseNextPageButton
    self.QualityDropDown = BrowseDropDown
    self.IsUsableCheckButton = IsUsableCheckButton
    self.BidPrice = BrowseBidPrice
    self.BidButton = BrowseBidButton
    self.BuyoutButton = BrowseBuyoutButton
    self.SearchCountText = BrowseSearchCountText
    self.MinLevel = BrowseMinLevel
    self.MaxLevel = BrowseMaxLevel
    self.ScrollFrame = self.BuyFrame.ScrollFrame
    self.NoResultsText = self.BuyFrame.NoResultsText
    self.ResetButton = self.BuyFrame.ResetButton
    self.SortButtonFrame = self.BuyFrame.SortButtonFrame

    local hide = ns.hide
    local point = ns.point
    local function text(obj, text)
        obj:SetFontObject('GameFontHighlightSmall')
        obj:SetText(text)
    end
    local function parent(obj)
        obj:SetParent(self.BuyFrame)
        obj:Show()
        obj.Hide = nop
    end

    for i = 1, NUM_BROWSE_TO_DISPLAY do
        hide(_G['BrowseButton' .. i])
    end
    hide(BrowseQualitySort)
    hide(BrowseLevelSort)
    hide(BrowseDurationSort)
    hide(BrowseHighBidderSort)
    hide(BrowseCurrentBidSort)
    hide(BrowseScrollFrame)
    hide(BrowseIsUsableText)
    hide(BrowseShowOnCharacterText)
    hide(BrowseTabText)
    hide(BrowseNoResultsText)

    text(ShowOnPlayerCheckButtonText, DISPLAY_ON_CHARACTER)
    text(IsUsableCheckButtonText, USABLE_ITEMS)

    local labels = {BrowseLevelText, BrowseNameText, BrowseDropDownName}
    local height = 0
    for _, label in ipairs(labels) do
        height = max(height, label:GetHeight())
    end
    for _, label in ipairs(labels) do
        label:SetHeight(height)
    end

    local nameWidth = 220

    self.Name:SetWidth(nameWidth)
    UIDropDownMenu_SetWidth(self.QualityDropDown, 60)

    point(BrowseSearchDotsText, 'LEFT', self.NoResultsText, 'RIGHT')

    point(self.SearchButton, 'TOPRIGHT', self.ResetButton, 'TOPLEFT', -5, 0)
    point(self.PrevPageButton, 'TOPLEFT', 658, -53)
    point(self.NextPageButton, 'TOPRIGHT', 70, -53)
    point(self.SearchCountText, 'BOTTOMLEFT', 190, 17)
    point(self.BidPrice, 'BOTTOM', 115, 18)

    point(BrowseLevelText, 'TOPLEFT', nameWidth + 90, -38)
    point(BrowseDropDownName, 'TOPLEFT', self, nameWidth + 170, -38)

    point(self.Name, 'TOPLEFT', BrowseNameText, 'BOTTOMLEFT', 3, -3)
    point(self.QualityDropDown, 'TOPLEFT', BrowseDropDownName, 'BOTTOMLEFT', -18, 3)
    point(self.IsUsableCheckButton, 'TOPLEFT', nameWidth + 260, -38)
    point(ShowOnPlayerCheckButton, 'TOPLEFT', self.IsUsableCheckButton, 'BOTTOMLEFT', 0, 2)

    parent(self.PrevPageButton)
    parent(self.NextPageButton)
    parent(self.SearchCountText)
    parent(self.BidButton)
    parent(self.BuyoutButton)
    parent(self.SearchButton)
    parent(self.ResetButton)

    ns.UI.ComboBox:Bind(self.QualityDropDown)
    self.QualityDropDown:SetItems((function()
        local items = {{text = ALL, value = -1}}
        for i = Enum.ItemQuality.Poor, Enum.ItemQuality.Epic do
            tinsert(items, {text = ns.ITEM_QUALITY_DESCS[i], value = i})
        end
        return items
    end)())
    self.QualityDropDown:SetValue(-1)
end

function Browse:SetupScrollFrame()

    self.ScrollFrame.update = function()
        return self:UpdateItems()
    end
    HybridScrollFrame_CreateButtons(self.ScrollFrame, 'tdAuctionBrowseItemTemplate')

    for _, button in ipairs(self.ScrollFrame.buttons) do
        ns.UI.BrowseItem:Bind(button)
    end
end

function Browse:SetupSortButtons()
    self.sortButtons = {}

    local headers = {
        {width = 147, relative = 'left', reverse = false, sortColumn = 'quality', text = NAME},
        {width = 30, relative = 'left', reverse = true, sortColumn = 'level', text = REQ_LEVEL_ABBR},
        {width = 60, relative = 'left', reverse = true, sortColumn = 'duration', text = L['Time']},
        {width = nil, relative = 'middle', reverse = true, sortColumn = 'seller', text = AUCTION_CREATOR},
        {width = 96, relative = 'right', reverse = true, sortColumn = 'bid', text = L['Bid price']},
        {width = 96, relative = 'right', reverse = true, sortColumn = 'buyout', text = BUYOUT},
        {width = 96, relative = 'right', reverse = true, sortColumn = 'unitprice', text = L['Unit price']},
    }

    local function OnClick(button)
        AuctionFrame_OnClickSortColumn('list', button.sortColumn)
        self:SaveSorts()
    end

    for i, info in pairs(headers) do
        local button = CreateFrame('Button', nil, self.SortButtonFrame, 'tdAuctionSortButtonTemplate')
        button.reverse = not not info.reverse
        button.sortColumn = info.sortColumn
        button:SetScript('OnClick', OnClick)
        button.Text:SetText(info.text)
        if info.width then
            button:SetWidth(info.width)
        end
        tinsert(self.sortButtons, button)
    end

    for i, button in ipairs(self.sortButtons) do
        local info = headers[i]

        if info.relative == 'left' or info.relative == 'middle' then
            if i == 1 then
                button:SetPoint('LEFT')
            else
                button:SetPoint('LEFT', self.sortButtons[i - 1], 'RIGHT')
            end
        end

        if info.relative == 'right' or info.relative == 'middle' then
            if i == #self.sortButtons then
                button:SetPoint('RIGHT')
            else
                button:SetPoint('RIGHT', self.sortButtons[i + 1], 'LEFT')
            end
        end
    end
end

function Browse:SetupEventsAndHooks()
    AuctionFrameBrowse_Update = nop
    AuctionFrameBrowse_UpdateArrows = nop
    AuctionFrameBrowse_Search = function()
        return self:RequestSearch()
    end

    hooksecurefunc('BrowseWowTokenResults_Update', function()
        self.BuyFrame:SetShown(not self:IsAtWowToken())
    end)

    hooksecurefunc('SetSelectedAuctionItem', function(listType)
        if listType == 'list' then
            self:UpdateItems()
            self:UpdateSelected()
        end
    end)

    self.SearchButton:HookScript('OnEnable', function()
        for _, button in ipairs(self.sortButtons) do
            button:Enable()
        end
    end)

    self.SearchButton:HookScript('OnDisable', function()
        for _, button in ipairs(self.sortButtons) do
            button:Disable()
        end
    end)

    self:SetScript('OnEvent', function()
        self.isSearching = nil
        self:UpdateAll()
    end)

    self:HookScript('OnShow', function()
        self:RestoreSorts()
        self:UpdateAll()
    end)

    local orig_ChatEdit_InsertLink = ChatEdit_InsertLink
    _G.ChatEdit_InsertLink = function(text)
        if self.Name:IsVisible() and IsShiftKeyDown() then
            self.Name:Hide()
            local ok = orig_ChatEdit_InsertLink(text)
            self.Name:Show()

            if not ok then
                local name, link = GetItemInfo(text)
                if link then
                    self.Name:SetText(link)
                    self:RequestSearch()
                    ok = true
                end
            end
            return ok
        else
            return orig_ChatEdit_InsertLink(text)
        end
    end

    AuctionFrame:HookScript('OnHide', function()
        self.Name:SetText('')
    end)

    self:PatchVisible('UpdateItems')
    self:PatchVisible('UpdateSelected')
    self:PatchVisible('UpdateControls')
    self:PatchVisible('UpdateSortButtons')
end

function Browse:UpdateAll()
    self:UpdateItems()
    self:UpdateSelected()
    self:UpdateControls()
    self:UpdateSortButtons()
end

function Browse:UpdateItems()
    local scrollFrame = self.ScrollFrame
    local offset = HybridScrollFrame_GetOffset(scrollFrame)
    local page = self.page
    local pageStart = NUM_AUCTION_ITEMS_PER_PAGE * page

    local ourSearch = self:IsOurSearch()
    local shouldHide = self.isSearching or not ourSearch
    local num, total, hasScrollBar, buttonWidth
    local totalHeight = 0

    if not shouldHide then
        num, total = GetNumAuctionItems('list')
        hasScrollBar = num * BUTTON_HEIGHT > scrollFrame:GetHeight()
        buttonWidth = hasScrollBar and 608 or 630
        totalHeight = num * BUTTON_HEIGHT
    end

    if not self.isSearching then
        self.ScrollFrame:SetWidth(hasScrollBar and 612 or 632)
    end

    for i, button in ipairs(scrollFrame.buttons) do
        local id = offset + i
        local index = id + pageStart
        if shouldHide or (index > num + pageStart) then
            button:Hide()
        else
            button:Show()
            button:Update(id)
            button:SetWidth(buttonWidth)
        end
    end
    HybridScrollFrame_Update(scrollFrame, totalHeight, scrollFrame:GetHeight())

    if not ourSearch then
        self.NoResultsText:SetText(BROWSE_SEARCH_TEXT)
    elseif self.isSearching then
        self.NoResultsText:SetText(SEARCHING_FOR_ITEMS)
    elseif not num or num == 0 then
        self.NoResultsText:SetText(BROWSE_NO_RESULTS)
    else
        self.NoResultsText:SetText('')
    end
end

function Browse:UpdateSortButtons()
    local sortColumn, reverse = GetAuctionSort('list', 1)
    for i, button in ipairs(self.sortButtons) do
        if sortColumn == button.sortColumn then
            if reverse ~= button.reverse then
                button.Arrow:SetTexCoord(0, 0.5625, 1, 0)
            else
                button.Arrow:SetTexCoord(0, 0.5625, 0, 1)
            end
            button.Arrow:Show()
        else
            button.Arrow:Hide()
        end
    end
end

function Browse:UpdateSelected()
    self.BidButton:Show()
    self.BuyoutButton:Show()
    self.BidButton:Disable()
    self.BuyoutButton:Disable()

    local id = GetSelectedAuctionItem('list')
    if id == 0 then
        return
    end

    local money = GetMoney()
    local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount,
          highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo =
        GetAuctionItemInfo('list', id)
    local ownerName = ownerFullName or owner
    local isMine = UnitName('player') == ownerName

    if buyoutPrice > 0 and buyoutPrice >= minBid then
        local canBuyout = 1
        if money < buyoutPrice then
            if not highBidder or money + bidAmount < buyoutPrice then
                canBuyout = nil
            end
        end
        if canBuyout and not isMine then
            self.BuyoutButton:Enable()
            AuctionFrame.buyoutPrice = buyoutPrice
        end
    else
        AuctionFrame.buyoutPrice = nil
    end

    local requiredBid

    if bidAmount == 0 then
        requiredBid = minBid
    else
        requiredBid = bidAmount + minIncrement
    end

    ns.SetMoneyFrame(self.BidPrice, requiredBid)

    if not highBidder and not isMine and money >= requiredBid and requiredBid <= MAXIMUM_BID_PRICE then
        self.BidButton:Enable()
    end
end

function Browse:UpdateControls()
    local shouldHide = self.isSearching or not self:IsOurSearch()
    if not shouldHide then
        local page = self.page
        local num, total = GetNumAuctionItems('list')
        if total > NUM_AUCTION_ITEMS_PER_PAGE and num <= NUM_AUCTION_ITEMS_PER_PAGE then
            self.PrevPageButton.isEnabled = page ~= 0
            self.NextPageButton.isEnabled = page ~= ceil(total / NUM_AUCTION_ITEMS_PER_PAGE) - 1

            local itemsMin = page * NUM_AUCTION_ITEMS_PER_PAGE + 1
            local itemsMax = itemsMin + num - 1
            self.SearchCountText:SetFormattedText(NUMBER_OF_RESULTS_TEMPLATE, itemsMin, itemsMax, total)
            return
        end
    end

    self.PrevPageButton.isEnabled = false
    self.NextPageButton.isEnabled = false
    self.SearchCountText:SetText('')
end

function Browse:IsAtWowToken()
    return AuctionFrame_DoesCategoryHaveFlag('WOW_TOKEN_FLAG', self.selectedCategoryIndex)
end

function Browse:IsOurSearch()
    return self.scaner == ns.Querier.scaner
end

function Browse:RequestSearch()
    self.isSearching = true
    self:BuildSearchParams()
    self:UpdateItems()
    self.scaner:Query(self.searchParams)
end

function Browse:BuildSearchParams()
    local params = {
        text = self.Name:GetText(),
        minLevel = self.MinLevel:GetNumber(),
        maxLevel = self.MaxLevel:GetNumber(),
        filters = self:GetFilters(),
        usable = self.IsUsableCheckButton:GetChecked(),
        quality = UIDropDownMenu_GetSelectedValue(self.QualityDropDown),
    }

    if not ns.ParamsEqual(params, self.searchParams) then
        self.searchParams = params
        self.page = 0
    end
    self.searchParams.page = self.page
end

function Browse:GetFilters()
    local categoryIndex = self.selectedCategoryIndex
    local subCategoryIndex = self.selectedSubCategoryIndex
    local subSubCategoryIndex = self.selectedSubSubCategoryIndex
    local filters

    if categoryIndex and subCategoryIndex and subSubCategoryIndex then
        filters = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].subCategories[subSubCategoryIndex]
                      .filters
    elseif categoryIndex and subCategoryIndex then
        filters = AuctionCategories[categoryIndex].subCategories[subCategoryIndex].filters
    elseif categoryIndex then
        filters = AuctionCategories[categoryIndex].filters
    else
    end
    return filters
end

function Browse:PatchVisible(method)
    local m = self[method]
    if m then
        self[method] = function()
            if self:IsVisible() then
                return m(self)
            end
        end
    end
end

function Browse:SaveSorts()
    local sorts = {}
    local i = 1
    while true do
        local column, reverse = GetAuctionSort('list', i)
        if not column then
            break
        end
        tinsert(sorts, 1, {column = column, reverse = reverse})

        i = i + 1
    end

    self.sorts = sorts
end

function Browse:RestoreSorts()
    SortAuctionClearSort('list')

    for i, v in ipairs(self.sorts) do
        SortAuctionSetSort('list', v.column, v.reverse)
    end
end

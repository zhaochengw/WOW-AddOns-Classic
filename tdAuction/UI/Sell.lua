-- Sell.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/21/2020, 1:46:18 PM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local Sell = ns.Addon:NewClass('UI.Sell', 'Frame')

function Sell:Constructor()
    self.scaner = ns.PriceScaner:New()
    self.scaner:SetCallback('OnDone', function()
        self:OnItemPriceScanDone()
    end)

    self:LayoutBlizzard()
    self:SetupEventsAndHooks()
end

function Sell:LayoutBlizzard()
    local t = AuctionsItemButton:CreateTexture(nil, 'BACKGROUND')
    t:SetSize(173, 40)
    t:SetPoint('TOPLEFT', -2, 2)
    t:SetTexture([[Interface\AuctionFrame\UI-AuctionFrame-ItemSlot]])
    t:SetTexCoord(0.15625, 0.83203125, 0.171875, 0.796875)

    self.SellFrame = CreateFrame('Frame', nil, self, 'tdAuctionSellFrameTemplate')
    self.StartPrice = StartPrice
    self.BuyoutPrice = BuyoutPrice
    self.PriceDropDown = PriceDropDown
    self.ItemCount = AuctionsItemButtonCount
    self.StackSizeEntry = AuctionsStackSizeEntry
    self.NumStacksEntry = AuctionsNumStacksEntry
    self.StackSizeMaxButton = AuctionsStackSizeMaxButton
    self.NumStacksMaxButton = AuctionsNumStacksMaxButton
    self.DurationDropDown = self.SellFrame.DurationDropDown
    self.PriceReading = self.SellFrame.PriceReading
    self.PriceList = self.SellFrame.PriceList
    self.PriceListButton = self.SellFrame.PriceListButton
    self.PriceSetText = self.SellFrame.PriceSetText

    local point = ns.point
    local hide = ns.hide

    hide(AuctionsShortAuctionButton)
    hide(AuctionsMediumAuctionButton)
    hide(AuctionsLongAuctionButton)

    point(AuctionsItemButton, 'TOPLEFT', 30, -94)
    point(AuctionsDurationText, 'LEFT', self.DurationDropDown, 'RIGHT', -192, 3)
    point(self.StartPrice, 'BOTTOMLEFT', 35, 196)
    point(self.BuyoutPrice, 'BOTTOMLEFT', self.StartPrice, 'BOTTOMLEFT', 0, -35)
    point(self.PriceDropDown, 'TOPRIGHT', self, 'TOPLEFT', 217, -192)

    point(self.StackSizeMaxButton, 'LEFT', self.StackSizeEntry, 'RIGHT', 0, 1)
    point(self.NumStacksMaxButton, 'LEFT', self.NumStacksEntry, 'RIGHT', 0, 1)
    point(self.StackSizeEntry, 'TOPLEFT', 33, -153)
    point(self.NumStacksEntry, 'LEFT', self.StackSizeEntry, 'RIGHT', 50, 0)
    point(AuctionsStackSizeEntryRight, 'RIGHT')
    point(AuctionsNumStacksEntryRight, 'RIGHT')

    point(AuctionsWowTokenAuctionFrame.BuyoutPriceLabel, 'TOPLEFT', 6, -58)

    AuctionsBuyoutErrorText:Hide()
    AuctionsBuyoutErrorText = self.SellFrame.BuyoutError

    self.StackSizeEntry:SetWidth(40)
    self.NumStacksEntry:SetWidth(40)
    self.StackSizeMaxButton:SetWidth(40)
    self.NumStacksMaxButton:SetWidth(40)

    self.PriceList.CountLabel:SetText(L['Count'])
    self.PriceList.PriceLabel:SetText(L['Price'])

    ns.UI.ComboBox:Bind(self.DurationDropDown)
    self.DurationDropDown:SetItems{
        {text = AUCTION_DURATION_ONE, value = 1},
        {text = AUCTION_DURATION_TWO, value = 2},
        {text = AUCTION_DURATION_THREE, value = 3},
    }
    self.DurationDropDown:SetCallback('OnValueChanged', function(_, value)
        self:SetDuration(value)
    end)

    self.priceType = 1
    self.DurationDropDown:SetValue(self.duration)

    HybridScrollFrame_CreateButtons(self.PriceList.ScrollFrame, 'tdAuctionPriceItemTemplate')
    self.PriceList.ScrollFrame.update = function()
        return self:UpdatePriceList()
    end
    self.PriceList:SetScript('OnShow', self.PriceList.ScrollFrame.update)

    local function OnClick(button)
        self:SetPrice(button.price - (button.isMine and 0 or 1))
    end

    for _, button in ipairs(self.PriceList.ScrollFrame.buttons) do
        button:SetScript('OnClick', OnClick)
    end
end

function Sell:SetupEventsAndHooks()
    AuctionsItemButton:HookScript('OnEvent', function(_, event)
        if event == 'NEW_AUCTION_UPDATE' then
            return self:OnSellItemUpdate()
        end
    end)

    AuctionsBlockFrame:HookScript('OnShow', function()
        self.PriceList:Hide()
    end)

    hooksecurefunc('ContainerFrameItemButton_OnModifiedClick', function(button)
        if ns.profile.sell.altSell and AuctionFrame:IsShown() and IsAltKeyDown() then
            local bag = button:GetParent():GetID()
            local slot = button:GetID()
            local locked = select(3, GetContainerItemInfo(bag, slot))

            if not locked then
                AuctionFrameTab_OnClick(AuctionFrameTab3)
                PickupContainerItem(bag, slot)
                ClickAuctionSellItemButton()
                ClearCursor()
            end
        end
    end)

    AuctionsStackSizeEntry:HookScript('OnTextChanged', function(_, text)
        if self.priceType ~= 1 and self.price then
            self:SetPrice(self.price)
        end
    end)

    self:HookScript('OnEvent', function(self, event, ...)
        if event == 'AUCTION_MULTISELL_UPDATE' then
            local n, m = ...
            if n == m then
                self:OnMultiSellDone()
            end
        elseif event == 'AUCTION_MULTISELL_FAILURE' then
            self:OnMultiSellDone()
        end
    end)

    self:HookScript('OnShow', self.OnSellItemUpdate)
end

function Sell:OnMultiSellDone()
    C_Timer.After(2, function()
        GetOwnerAuctionItems()
    end)
end

function Sell:OnSellItemUpdate()
    if not self:IsVisible() then
        return
    end

    self.price = nil

    local name, texture, count, quality, canUse, price, pricePerUnit, stackCount, totalCount, itemId =
        GetAuctionSellItemInfo()

    self.PriceList:Hide()
    self.PriceListButton:Hide()
    self.PriceSetText:Hide()
    self.DurationDropDown:Hide()
    self.PriceReading:Hide()

    if C_WowTokenPublic.IsAuctionableWowToken(itemId) then
        return
    end

    if totalCount > 1 then
        self.ItemCount:SetText(totalCount)
        self.ItemCount:Show()
        self.StackSizeEntry:Show()
        self.StackSizeMaxButton:Show()
        self.NumStacksEntry:Show()
        self.NumStacksMaxButton:Show()
        self.PriceDropDown:Show()
        UpdateMaximumButtons()
    else
        self.ItemCount:Hide()
        self.StackSizeEntry:Hide()
        self.StackSizeMaxButton:Hide()
        self.NumStacksEntry:Hide()
        self.NumStacksMaxButton:Hide()
        self.PriceDropDown:Hide()
    end

    if totalCount > 0 then
        local stackSize = ns.profile.sell.stackSize
        if stackSize == 0 then
            stackSize = stackCount
        end
        stackSize = min(stackSize, totalCount, stackCount)
        local numStacks = floor(totalCount / stackSize)

        self.StackSizeEntry:SetNumber(stackSize)
        self.NumStacksEntry:SetNumber(numStacks)

        local duration = ns.profile.sell.duration
        local durationNoDeposit = ns.profile.sell.durationNoDeposit

        local deposit = GetAuctionDeposit(duration, 1, 1, stackSize, numStacks)
        if durationNoDeposit and deposit == 0 then
            self:SetDuration(durationNoDeposit)
        else
            self:SetDuration(duration)
        end

        ns.SetMoneyFrame(self.StartPrice, 0)
        ns.SetMoneyFrame(self.BuyoutPrice, 0)

        local link = ns.GetAuctionSellItemLink()
        self.scaner:Query({text = link})
        self.PriceReading:Show()
    end

    self.DurationDropDown:Show()
end

function Sell:OnItemPriceScanDone()
    self.PriceReading:Hide()

    local link = ns.GetAuctionSellItemLink()
    if not link then
        self.scaner:Cancel()
        return
    end
    local itemKey = ns.ParseItemKey(link)
    local price = ns.prices[itemKey]
    local items = self.scaner:GetResponseItems()
    local errText

    if not price then
        local vendoPrice = select(11, GetItemInfo(link))
        if vendoPrice then
            local merchantRatio = ns.profile.sell.merchantRatio
            price = vendoPrice * merchantRatio
            errText = format(L['Use merchant price x%d'], merchantRatio)
        else
            errText = L['No price']
        end
    else
        if #items > 0 then
            for i, item in ipairs(items) do
                if not item.isMine then
                    price = item.price - 1
                    break
                else
                    price = item.price
                end
            end
        else
            price = price - 1
            errText = L['Use history price']
        end
    end

    if items and #items > 0 then
        self.PriceListButton:Show()
    end

    self.items = items
    self:SetPrice(price)
    self:UpdatePriceList()
    self.PriceSetText:Show()

    if errText then
        self.PriceSetText:SetText(errText)
        self.PriceSetText:SetTextColor(1, 0, 0)
    else
        self.PriceSetText:SetText(L['Choose other price'])
        self.PriceSetText:SetTextColor(1, 0.81, 0)

        if ns.profile.sell.autoOpenPriceList then
            self.PriceList:Show()
        end
    end
end

function Sell:UpdatePriceList()
    if not self.items or not self.PriceList:IsVisible() then
        return
    end

    local scrollFrame = self.PriceList.ScrollFrame
    local buttons = scrollFrame.buttons
    local offset = HybridScrollFrame_GetOffset(scrollFrame)
    local hasScrollBar = #self.items * 20 > scrollFrame:GetHeight()
    local width = hasScrollBar and 169 or 189

    for i, button in ipairs(buttons) do
        local item = self.items[i + offset]
        if not item then
            button:Hide()
        else
            button.isMine = item.isMine
            button.price = item.price
            button.Count:SetFormattedText('%dx%d', item.stackSize, item.count)
            button.Price:SetText(GetMoneyString(item.price))
            button:Show()
            button:SetWidth(width)

            if item.isMine then
                button.Price:SetTextColor(0, 1, 0)
            else
                button.Price:SetTextColor(1, 1, 1)
            end
        end
    end

    HybridScrollFrame_Update(scrollFrame, #self.items * 20, scrollFrame:GetHeight())

    scrollFrame:SetWidth(width)
end

function Sell:SetPrice(price)
    if not price then
        return
    end

    self.price = price

    local bidRatio = ns.profile.sell.bidRatio
    if self.priceType ~= 1 then
        price = price * self.StackSizeEntry:GetNumber()
    end

    ns.SetMoneyFrame(self.BuyoutPrice, price)
    ns.SetMoneyFrame(self.StartPrice, max(1, price * bidRatio))
end

function Sell:SetDuration(duration)
    self.duration = duration
    self.DurationDropDown:SetValue(duration)
    UpdateDeposit()
end

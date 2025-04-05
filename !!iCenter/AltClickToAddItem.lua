--[[
Alt-Click to add an item to a mail for sending or to the trade frame, and alt-click to buy a stack if reagents
]]--
AltClickToAddItem = LibStub("AceAddon-3.0"):NewAddon("AltClickToAddItem", "AceHook-3.0")

function AltClickToAddItem:OnEnable()
	self:Hook("ContainerFrameItemButton_OnModifiedClick", true)
	self:HookScript(TradeFrame, "OnShow", "TFShow")
	self:Hook("MerchantItemButton_OnModifiedClick", true)  
end

--------------------------------------------
-- Alt+Right-Click to buy full stack of an item from a vendor (like reagents).

function AltClickToAddItem:MerchantItemButton_OnModifiedClick(...)
	if IsAltKeyDown() then
		self.item = (...):GetID()
		local ItemMaxStack = GetMerchantItemMaxStack(self.item)
		local _, _, price, quantity = GetMerchantItemInfo(self.item)
		--Dont buy reagents at all when you are too poor to afford a full stack.
		if ItemMaxStack*price < GetMoney() then
			if ItemMaxStack == 1 and quantity > 1 then
				local itemStackCount = select(8,GetItemInfo(GetMerchantItemLink(self.item)))
				if itemStackCount and itemStackCount > 1 then
					ItemMaxStack = floor(itemStackCount/quantity)
				end
			end
			BuyMerchantItem(self.item, ItemMaxStack)
		else
			--return self.hooks["MerchantItemButton_OnModifiedClick"](...)
		end
	else
			--return self.hooks["MerchantItemButton_OnModifiedClick"](...)
	end
end

-- Various Alt-Click handlers for items in Bags.

function AltClickToAddItem:ContainerFrameItemButton_OnModifiedClick(...)
	if select(2, ...) == "LeftButton" and IsAltKeyDown() and not CursorHasItem() then
		self.bag, self.slot = (...):GetParent():GetID(), (...):GetID()

		-- add item to mail
		if SendMailFrame:IsVisible() then
			if IsAddOnLoaded("Postal") or IsAddOnLoaded("BulkMail2") then
				return self.hooks["ContainerFrameItemButton_OnModifiedClick"](...)
			end
		PickupContainerItem(self.bag, self.slot)
		ClickSendMailItemButton()
		return

		-- add item to trade frame
		elseif TradeFrame:IsVisible() then
			for i = 1, 6 do
				if not GetTradePlayerItemLink(i) then
					PickupContainerItem(self.bag, self.slot)
					ClickTradeButton(i)
					return
				end
			end

		-- add item into Auctioneer AuctionPost frame
		elseif AuctionFrameTabPost and AuctionFrameTabPost:IsVisible() and IsAddOnLoaded("Auctioneer") then
			PickupContainerItem(self.bag, self.slot)
			AuctionFrameTabPost:Click()
			AuctionFramePost_AuctionItem_OnClick(AuctionFramePostAuctionItem)
			return

		-- post auction
		elseif AuctionFrameAuctions and AuctionFrameAuctions:IsVisible() and not IsAddOnLoaded("Fence") and not IsAddOnLoaded("IMA_AuctionFrameMassAuction") then
			PickupContainerItem(self.bag, self.slot)
			ClickAuctionSellItemButton()
			return

		-- initiate trade
		elseif not CursorHasItem() and UnitExists("target") and CheckInteractDistance("target", 2) 
			and UnitIsFriend("player", "target") and UnitIsPlayer("target")  then
			InitiateTrade("target")
			self.target = UnitName("target")
			return
		end
	end
	--return self.hooks["ContainerFrameItemButton_OnModifiedClick"](...)
end

-- If trade is initiated by this addon, this is called to put the item into the Trade Frame after it shows.
function AltClickToAddItem:TFShow(...)
  self.hooks[TradeFrame].OnShow(...)
  if self.target and not CursorHasItem() and UnitName("target") == self.target then
    PickupContainerItem(self.bag, self.slot)
    ClickTradeButton(1)
  end
  self.target = nil
end

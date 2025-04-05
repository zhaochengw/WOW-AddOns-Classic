
local next = next;
local _G = _G;

local function noop()
end

--	30400Compatible 
if __ala_meta__.TOC_VERSION < 30401 then

	local ToPack = {
		["C_Container"] = {
			{ "GetBankBagSlotFlag", },
			-- { "GetContainerItemInfo", },
			{ "GetContainerItemLink", },
			{ "GetContainerFreeSlots", },
			{ "GetBagSlotFlag", },
			{ "GetContainerNumSlots", },
			{ "GetInsertItemsLeftToRight", },
			{ "GetContainerItemCooldown", },
			{ "ContainerIDToInventoryID", },
			{ "GetContainerItemID", },
			{ "GetContainerItemDurability", },
			{ "UseContainerItem", },
			{ "GetContainerNumFreeSlots", },
			{ "IsContainerFiltered", },
			{ "GetBagName", },
			{ "GetContainerItemQuestInfo", },
			{ "GetContainerItemPurchaseInfo", },
			{ "SplitContainerItem", },
			{ "PickupContainerItem", },
			{ "SetBagPortraitTexture", },
			{ "SetBagSlotFlag", },
			{ "SetInsertItemsLeftToRight", },
			{ "SocketContainerItem", },
			{ "GetContainerItemPurchaseCurrency", },
			{ "ContainerRefundItemPurchase", },
			{ "IsBagSlotFlagEnabledOnOtherBankBags", },
			{ "ShowContainerSellCursor", },
			{ "SetItemSearch", },
			{ "GetContainerItemPurchaseItem", },
			{ "GetContainerItemGems", },
		},
	};

	for C, D in next, ToPack do
		_G[C] = _G[C] or {  };
		local W = _G[C];
		for i = 1, #D do
			local d = D[i];
			local x, y = d[1], d[2] or d[1];
			W[x] = W[x] or _G[y] or noop;
		end
	end

end



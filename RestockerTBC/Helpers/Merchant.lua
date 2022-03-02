---@type RestockerAddon
local _, RS = ...;

local F = CreateFrame('FRAME');

F:RegisterEvent("MERCHANT_SHOW");
F:RegisterEvent("MERCHANT_UPDATE");

F:SetScript("OnEvent", function(self, event)
  for index = 1, GetMerchantNumItems() do
    local link = GetMerchantItemLink(index);
    local name = GetMerchantItemInfo(index);
    if link ~= nil and name ~= nil then
      RS.GetItemInfo(link, name);
    end
  end
end)

--  id = GetMerchantItemID(index)
--  link = GetMerchantItemLink(index);
--  name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost = GetMerchantItemInfo(index)

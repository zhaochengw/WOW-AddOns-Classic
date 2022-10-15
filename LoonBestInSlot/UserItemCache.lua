LBIS.UserItems = {}
LBIS.UserItemCacheBuilt = false;

local hasBagnon = Bagnon or Combuctor;
local LibItemCache = LibStub("LibItemCache-2.0", true)

local wowSlotCodes = {"HEADSLOT", "NECKSLOT", "SHOULDERSLOT", "CHESTSLOT", "WAISTSLOT", "LEGSSLOT", "FEETSLOT", "WRISTSLOT", 
    "HANDSSLOT", "FINGER0SLOT", "FINGER1SLOT", "TRINKET0SLOT", "TRINKET1SLOT", "BACKSLOT", "MAINHANDSLOT", "SECONDARYHANDSLOT", "RANGEDSLOT"}

local readBagsWithApi = function()

    for bag = -1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do        
        for slot = 1, GetContainerNumSlots(bag) do
            local itemLink = GetContainerItemLink(bag, slot);
            if itemLink then
                local itemId = LBIS:GetItemIdFromLink(itemLink);
                if bag < 0 or bag > NUM_BAG_SLOTS then
                    LBIS.UserItems[tonumber(itemId)] = "bank";
                else
                    LBIS.UserItems[tonumber(itemId)] = "bag";
                end     
            end
        end
    end
end

local readBagsWithBagnon = function ()

    for bag = -1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do

        local bagInfo = LibItemCache:GetBagInfo(UnitName("player"), bag);
        if bagInfo.count and bagInfo.count > 0 then
            for slot = 1, bagInfo.count do
                local item = LibItemCache:GetItemInfo(UnitName("player"), bag, slot);
                if item.id and item.id > 0 then
                    if bag < 0 or bag > NUM_BAG_SLOTS then
                        LBIS.UserItems[item.id] = "bank";
                    else
                        LBIS.UserItems[item.id] = "bag";
                    end
                end
            end
        end

    end
end

function LBIS:BuildItemCache()

    if LBIS.UserItemCacheBuilt then
        return;
    end

    for k,v in pairs(LBIS.UserItems) do
        LBIS.UserItems[k] = nil
    end

    for i, slotCode in ipairs(wowSlotCodes) do
        local itemLink = GetInventoryItemLink("player",GetInventorySlotInfo(slotCode));
        
        if itemLink then
            local itemId = LBIS:GetItemIdFromLink(itemLink);
            LBIS.UserItems[tonumber(itemId)] = "player";
        end
    end

    if hasBagnon then
        readBagsWithBagnon();
    else
        readBagsWithApi();
    end

end


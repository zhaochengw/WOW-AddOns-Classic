-- Compat for MoP Classic (5.5.0)
local _G = _G

-- AddOn metadata getter
TI_GetAddOnMetadata = (C_AddOns and TI_GetAddOnMetadata) or _G.GetAddOnMetadata

-- Item stats
TI_GetItemStats = (C_Item and TI_GetItemStats) or _G.GetItemStats

-- Challenge Mode (Retail only). Stub safely.
if (not C_ChallengeMode) then
    C_ChallengeMode = {}
    function C_ChallengeMode.GetMapUIInfo(mapID) return nil end
end

-- Container API shim (Retail vs Classic)
if (not C_Container) then
    C_Container = {}
    function C_Container.GetContainerNumSlots(bag) return _G.GetContainerNumSlots and _G.GetContainerNumSlots(bag) or 0 end
    function C_Container.GetContainerItemInfo(bag, slot)
        if (not _G.GetContainerItemInfo) then return nil end
        local texture, itemCount, locked, quality, readable, lootable, link = _G.GetContainerItemInfo(bag, slot)
        local itemID = nil
        if (link) then
            itemID = tonumber(string.match(link, "item:(%d+)"))
        end
        return {
            iconFileID = texture,
            stackCount = itemCount,
            isLocked = locked,
            quality = quality,
            isReadable = readable,
            hasLoot = lootable,
            hyperlink = link,
            isFiltered = false,
            hasNoValue = false,
            itemID = itemID,
        }
    end
end


-- Retail-only helpers (not in MoP Classic) -> safely stub to false
if (not IsArtifactRelicItem) then
    function IsArtifactRelicItem(item) return false end
end
if (not IsArtifactPowerItem) then
    function IsArtifactPowerItem(item) return false end
end

local myname, ns = ...
local myfullname = C_AddOns.GetAddOnMetadata(myname, "Title")

EventRegistry:RegisterFrameEventAndCallback("TRANSMOG_COLLECTION_SOURCE_ADDED", function(_, itemModifiedAppearanceID)
    if not ns.db.alerts then
        return
    end
    if PerksProgramFrame and PerksProgramFrame:IsShown() then
        return
    end
    if C_ContentTracking and C_ContentTracking.IsTracking(Enum.ContentTrackingType.Appearance, itemModifiedAppearanceID) then
        return
    end
    
    -- 经典旧世兼容处理
    if NewCosmeticAlertFrameSystem then
        NewCosmeticAlertFrameSystem:AddAlert(itemModifiedAppearanceID)
    else
        -- 经典旧世版本使用简单的系统消息提示
        local name = C_TransmogCollection.GetSourceInfo(itemModifiedAppearanceID)
        if name then
            print(format("|cff33ff99%s|r: 已收藏外观 - %s", myfullname, name))
        end
    end
end, myname)

-- EventRegistry:RegisterFrameEventAndCallback("TRANSMOG_COSMETIC_COLLECTION_SOURCE_ADDED", function(_, itemModifiedAppearanceID)
--     print("TRANSMOG_COSMETIC_COLLECTION_SOURCE_ADDED", itemModifiedAppearanceID)
-- end, myname)

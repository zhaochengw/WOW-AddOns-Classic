-- ========================================
-- Core/Compat.lua
-- 统一兼容层
-- ========================================
-- 职责：
-- 1. 处理不同 WoW 版本的 API 差异 (WLK vs Retail)
-- 2. 提供统一的 API 访问接口
-- 3. 避免在业务代码中散落兼容性检查
-- ========================================

local addonName, ns = ...
local RS = LibStub("AceAddon-3.0"):GetAddon("RurutiaSuite", true)
if not RS then return end

RS.Compat = RS.Compat or {}

-- ========================================
-- 设置面板兼容 (InterfaceOptions)
-- ========================================

-- InterfaceOptions_AddCategory
-- Retail (10.0+) 使用 Settings API，Classic/WLK 使用 InterfaceOptions API
RS.Compat.InterfaceOptions_AddCategory = _G.InterfaceOptions_AddCategory or function(frame, addOn, position)
    if frame.parent then
        local category = _G.Settings.GetCategory(frame.parent)
        local subcategory, layout = _G.Settings.RegisterCanvasLayoutSubcategory(category, frame, frame.name, frame.name)
        subcategory.ID = frame.name
        return subcategory, category
    else
        local category, layout = _G.Settings.RegisterCanvasLayoutCategory(frame, frame.name, frame.name)
        category.ID = frame.name
        _G.Settings.RegisterAddOnCategory(category)
        return category
    end
end

-- InterfaceOptionsFrame_OpenToCategory
RS.Compat.InterfaceOptionsFrame_OpenToCategory = _G.InterfaceOptionsFrame_OpenToCategory or function(categoryIDOrFrame)
    if type(categoryIDOrFrame) == "table" then
        local categoryID = categoryIDOrFrame.name
        return _G.Settings.OpenToCategory(categoryID)
    else
        return _G.Settings.OpenToCategory(categoryIDOrFrame)
    end
end

-- ========================================
-- 容器/物品 API 兼容 (Container/Item)
-- ========================================

-- GetContainerNumSlots -> C_Container.GetContainerNumSlots
RS.Compat.GetContainerNumSlots = _G.GetContainerNumSlots or function(bagID)
    return C_Container.GetContainerNumSlots(bagID)
end

-- GetContainerItemInfo -> C_Container.GetContainerItemInfo
-- 注意：Retail 返回 table (Info), Classic 返回多个值
-- 这里我们统一返回 (icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID, isBound)
-- 或者让调用者适配 table? 
-- 为了保持旧代码兼容性，我们解构 table 返回
RS.Compat.GetContainerItemInfo = _G.GetContainerItemInfo or function(bagID, slotID)
    local info = C_Container.GetContainerItemInfo(bagID, slotID)
    if info then
        return info.iconFileID, info.stackCount, info.isLocked, info.quality, info.isReadable, info.hasLoot, info.hyperlink, info.isFiltered, info.hasNoValue, info.itemID, info.isBound
    end
    return nil
end

-- GetContainerItemLink -> C_Container.GetContainerItemLink
RS.Compat.GetContainerItemLink = _G.GetContainerItemLink or function(bagID, slotID)
    return C_Container.GetContainerItemLink(bagID, slotID)
end

-- PickupContainerItem -> C_Container.PickupContainerItem
RS.Compat.PickupContainerItem = _G.PickupContainerItem or function(bagID, slotID)
    return C_Container.PickupContainerItem(bagID, slotID)
end

-- UseContainerItem -> C_Container.UseContainerItem
RS.Compat.UseContainerItem = _G.UseContainerItem or function(bagID, slotID, target)
    return C_Container.UseContainerItem(bagID, slotID, target)
end

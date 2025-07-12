-- GetAddOnMetadata 兼容实现
-- 创建一个兼容性函数
local function GetAddOnMetadataCompat(addonName, field)
    -- 首先尝试使用新的C_AddOns API
    if C_AddOns and C_AddOns.GetAddOnMetadata then
        return C_AddOns.GetAddOnMetadata(addonName, field)
    end
    
    -- 回退到旧的全局函数
    if _G.GetAddOnMetadata then
        return _G.GetAddOnMetadata(addonName, field)
    end
    
    -- 如果两个API都不可用，返回nil或抛出错误
    return nil
end

-- 可以替换全局函数（可选）
-- 这样插件中所有调用GetAddOnMetadata的地方都会自动使用兼容版本
_G.GetAddOnMetadata = GetAddOnMetadataCompat
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ADDON_LOADED")

local function SetupCVars()
    -- 确保使用正确的API调用
    SetCVar("addonProfilerEnabled", "0")
    
    -- 尝试使用多种方式禁用装备管理器
    ConsoleExec("equipmentManager 0")
    SetCVar("equipmentManager", 0)
    SetCVar("EQUIPMENTMANAGER_ENABLED", "0")
    
    local eqStatus = GetCVar("equipmentManager")
    
    if eqStatus == "0" and GetCVar("addonProfilerEnabled") == "0" then
        return true
    end
    return false
end

frame:SetScript("OnEvent", function(self, event, ...)
    if not self.success then
        self.success = SetupCVars()
    end
    
    if self.success then
        self:UnregisterAllEvents()
    end
end)

--插件初始化
local ADDONNAME = ...;
local ufpcd = CreateFrame("Frame");
ufpcd:RegisterEvent("ADDON_LOADED");
ufpcd:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...;
        if name == ADDONNAME then
            if IsAddOnLoaded("UnitFramesPlus") then
                UFPClassicDurations = LibStub("LibClassicDurations");
                UFPClassicDurations:Register(ADDONNAME);
            end
            ufpcd:UnregisterEvent("ADDON_LOADED");
        end
    end
end)


local __addon, __private = ...;

local Load = {}
__private.Load = Load;
Load.Prepare = false;
Load.TalentEmuLoaded = false;
Load.SelfLoaded= false;
local L = LibStub("AceLocale-3.0"):GetLocale("SenderInfo");

local function ADDON_LOADED(self,event,addonName,...)

    if addonName == "TalentEmu" then
        Load.TalentEmuLoaded = true;
    elseif addonName == "SenderInfo" then
        Load.SelfLoaded= true;
        SendSystemMessage(string.format("|cfffff000%s|r",L["插件提示1"]));
        SendSystemMessage(string.format("|cfffff000%s|r",L["插件提示2"]));
        SendSystemMessage(string.format("|cfffff000%s|r",L["插件提示3"]));
        SendSystemMessage(string.format("|cfffff000%s|r",L["插件提示4"]));
    end

    if Load.TalentEmuLoaded and Load.SelfLoaded then
        Load:Init();
    end

end

function Load:Init()

    if self.Prepare then
        return
    end

    self.Prepare = true;
    __private.View:Init();
    __private.InviteTeamView:Init();
    __private.Main:Init();
end 

local Load = CreateFrame("Frame")
Load:RegisterEvent("ADDON_LOADED");
Load:SetScript("OnEvent",ADDON_LOADED);

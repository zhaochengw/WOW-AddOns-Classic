
ChatPlusDefaultDB = {
    classcolor = 1,
    arrowkeys = 1,
    tabchannel = 1,
    chatcopy = 1,
    chatcopybutton = 1,
    cancelsticky = 1,
    editboxtotop = 0,
    shortname = 0,
    -- urlcopy = 1,
    version = "1.2",
}

--设置初始化
local function ChatPlus_Options_Init()
    if (not ChatPlusDB) then
        ChatPlusDB = ChatPlusDefaultDB;
    end

    -- local Version = GetAddOnMetadata("ChatPlus", "Version");
    if (not ChatPlusDB["version"]) or (ChatPlusDB["version"] ~= ChatPlusDefaultDB["version"]) then
        local k, v;
        for k, v in pairs(ChatPlusDefaultDB) do
            ChatPlusDB[k] = ChatPlusDB[k] or ChatPlusDefaultDB[k];
        end
        ChatPlusDB["version"] = ChatPlusDefaultDB["version"];
    end
end

--模块初始化
local function ChatPlus_Init()
    if ChatPlus_ClassColor then
        ChatPlus_ClassColor();
    end
    if ChatPlus_ArrowKeys then
        ChatPlus_ArrowKeys();
    end
    if ChatPlus_CancelSticky then
        ChatPlus_CancelSticky();
    end
    if ChatPlus_EditBoxToTop then
        ChatPlus_EditBoxToTop();
    end
    if ChatPlusDB_ShortChannelName then
        ChatPlusDB_ShortChannelName();
    end
end

--命令行
function ChatPlus_SlashHandler()
    if not IsAddOnLoaded("ChatPlus_Options") then
        LoadAddOn("ChatPlus_Options");
    end
    InterfaceOptionsFrame_OpenToCategory(ChatPlus_OptionsFrame);
    InterfaceOptionsFrame_OpenToCategory(ChatPlus_OptionsFrame);
end
SlashCmdList["ChatPlus"] = ChatPlus_SlashHandler;
SLASH_ChatPlus1 = "/chatplus";
SLASH_ChatPlus2 = "/cp";

--插件初始化
local cp = CreateFrame("Frame");
cp:RegisterEvent("ADDON_LOADED");
cp:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...;
        if name == "ChatPlus" then
            ChatPlus_Options_Init();
            ChatPlus_Init();
            cp:UnregisterEvent("ADDON_LOADED");
            print("|cFFFFFF99Chatplus loaded. Type|R |cFF00FF00/cp|R |cFFFFFF99or|R |cFF00FF00/chatplus|R |cFFFFFF99to open the option panel.");
        end
    end
end)

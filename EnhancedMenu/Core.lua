local addonName, EM = ...
_G.EnhancedMenu = EM

EM.funcs = {}
local F = EM.funcs
local L = EM.L

local LRI = LibStub("LibRealmInfo")

local EnhancedMenu_ItemOrder = {"SEND_WHO", "COPY_NAME", "GUILD_INVITE", "FRIEND_ADD"}
local EnhancedMenu_Items = {
    ["ENHANCED_MENU"] = {
        text = L["ENHANCED_MENU"],
        isTitle = true,
        notCheckable = 1,
    },
    ["SEND_WHO"] = {
        text = L["SEND_WHO"],
        notCheckable = 1,
    },
    ["COPY_NAME"] = {
        text = L["COPY_NAME"],
        notCheckable = 1,
    },
    ["GUILD_INVITE"] = {
        text = L["GUILD_INVITE"],
        notCheckable = 1,
    },
    ["FRIEND_ADD"] = {
        text = L["FRIEND_ADD"],
        notCheckable = 1,
    },
}
local EnhancedMenu_Func = {}
local EnhancedMenu_Which = {}
-- ["which"] = "SELF": unit frame self
--             "FOCUS": unit frame focus
--             "PLAYER": unit frame player
--             "TARGET": unit frame target (non-player)
--             "FRIEND": chat frame / friend
--             "FRIEND_OFFLINE": friend
--             "COMMUNITIES_GUILD_MEMBER": guild frame
--             "PARTY": party member
--             "RAID_PLAYER": raid member

----------------------------------------------------------------------------
-- which
----------------------------------------------------------------------------
EnhancedMenu_Which["SEND_WHO"] = {
    ["FRIEND"] = true,
}

EnhancedMenu_Which["COPY_NAME"] = {
    ["SELF"] = true,
    ["TARGET"] = true,
    ["PARTY"] = true,
    ["PLAYER"] = true,
    ["RAID_PLAYER"] = true,
    ["FRIEND"] = true,
    ["FRIEND_OFFLINE"] = true,
    ["COMMUNITIES_GUILD_MEMBER"] = true,
    ["BN_FRIEND"] = true,
}

EnhancedMenu_Which["GUILD_INVITE"] = {
    ["PLAYER"] = true,
    ["FRIEND"] = true,
    ["PARTY"] = true,
    ["RAID_PLAYER"] = true,
    ["BN_FRIEND"] = true,
}

EnhancedMenu_Which["FRIEND_ADD"] = {
    ["TARGET"] = true,
    ["PARTY"] = true,
    ["PLAYER"] = true,
    ["FRIEND"] = true,
    ["RAID_PLAYER"] = true,
    ["COMMUNITIES_GUILD_MEMBER"] = true,
}

----------------------------------------------------------------------------
-- func
----------------------------------------------------------------------------
local subInfos = {}

local submenu = CreateFrame("Frame", "EnhancedMenu_SubMenu")
local function ToggleEnhancedMenu_SubMenu(funcName)
    UIDropDownMenu_Initialize(submenu, function(self, level)
        for _, info in pairs(subInfos) do
            if funcName == "GUILD_INVITE" then
                info.func = function(self) F:ConfirmGuildInvite(info.name, info.server) end
            elseif funcName == "COPY_NAME" then
                info.func = function(self) F:ShowName(info.name, info.server) end
            elseif funcName == "ARMORY_URL" then
                info.func = function(self) F:ShowArmoryURL(info.name, info.server) end
            elseif funcName == "RAIDER_IO" then
                info.func = function(self) F:ShowRaiderIO(info.name, info.server) end
            end
            UIDropDownMenu_AddButton(info, level)
        end
    end)
    ToggleDropDownMenu(1, nil, submenu, "cursor", 0, 60)
end

EnhancedMenu_Func["SEND_WHO"] = function(name, server)
    -- local _, name, nameForAPI = LRI:GetRealmInfo(server)
    C_FriendList.SetWhoToUi(false)
    C_FriendList.SendWho("n-"..name)
end

EnhancedMenu_Func["COPY_NAME"] = function(name, server)
    if name and server then
        F:ShowName(name, server)
    else
        ToggleEnhancedMenu_SubMenu("COPY_NAME")
    end
end

EnhancedMenu_Func["GUILD_INVITE"] = function(name, server)
    if name and server then
        F:ConfirmGuildInvite(name, server)
    else
        ToggleEnhancedMenu_SubMenu("GUILD_INVITE")
    end
end

EnhancedMenu_Func["ARMORY_URL"] = function(name, server)
    if name and server then
        F:ShowArmoryURL(name, server)
    else
        ToggleEnhancedMenu_SubMenu("ARMORY_URL")
    end
end

EnhancedMenu_Func["RAIDER_IO"] = function(name, server)
    if name and server then
        F:ShowRaiderIO(name, server)
    else
        ToggleEnhancedMenu_SubMenu("RAIDER_IO")
    end
end

EnhancedMenu_Func["FRIEND_ADD"] = function(name, server)
    C_FriendList.AddFriend(name)
end

----------------------------------------------------------------------------
-- prepare buttons
----------------------------------------------------------------------------
local buttons = {}
local function PrepareButtons(which, name, server)
    wipe(buttons)
    if not server then server = GetRealmName() end

    local i = 0
    for _, itemName in pairs(EnhancedMenu_ItemOrder) do
        if EnhancedMenu_Which[itemName][which] then
            i = i + 1
            -- add item
            tinsert(buttons, EnhancedMenu_Items[itemName])
            -- set func
            buttons[i].func = function()
                EnhancedMenu_Func[itemName](name, server)
            end
        end
    end

    if i ~= 0 then
        tinsert(buttons, 1, EnhancedMenu_Items["ENHANCED_MENU"]) -- insert title
        return true
    end
end

----------------------------------------------------------------------------
-- hook
----------------------------------------------------------------------------
hooksecurefunc("UnitPopup_ShowMenu", function(self, which)
    if which == "BN_FRIEND" then return end

    local menuLevel = UIDROPDOWNMENU_MENU_LEVEL
    if menuLevel > 1 then return end

    local menu = UnitPopup_HasVisibleMenu() and UIDropDownMenu_GetCurrentDropDown() or nil
    if not menu then return end
    local show = PrepareButtons(menu.which, menu.name, menu.server)
    -- Interface\SharedXML\UIDropDownMenu.lua
    if show then
        UIDropDownMenu_AddSeparator()
        for _, info in pairs(buttons) do
            UIDropDownMenu_AddButton(info)
        end
    end
end)

-------------------------------------------------------
-- BNFriends
-------------------------------------------------------
hooksecurefunc("FriendsFrame_ShowBNDropdown", function(name, connected, lineID, chatType, chatFrame, friendsList, bnetIDAccount)
    if connected then
        local friendIndex = BNGetFriendIndex(bnetIDAccount)
        local numGameAccounts = C_BattleNet.GetFriendNumGameAccounts(friendIndex)

        wipe(subInfos)
        for accountIndex = 1, numGameAccounts do
            local gameAccountInfo = C_BattleNet.GetFriendGameAccountInfo(friendIndex, accountIndex)

            if gameAccountInfo["wowProjectID"] == 1 and gameAccountInfo["clientProgram"] == BNET_CLIENT_WOW then
                local info = UIDropDownMenu_CreateInfo()
                info.text = gameAccountInfo["characterName"].."-"..gameAccountInfo["realmName"]
                info.name = gameAccountInfo["characterName"]
                info.server = gameAccountInfo["realmName"]
                info.notCheckable = 1
                tinsert(subInfos, info)
            end
        end

        -- texplore(subInfos)
        if #subInfos == 0 then
            return
        elseif #subInfos == 1 then
            PrepareButtons("BN_FRIEND", subInfos[1]["name"], subInfos[1]["server"])
        else
            PrepareButtons("BN_FRIEND")
        end

        UIDropDownMenu_AddSeparator()
        for _, info in pairs(buttons) do
            UIDropDownMenu_AddButton(info)
        end
    end
end)

-------------------------------------------------------
-- Alt + LeftButton = Invite
-- stolen from FriendsMenuXP
-------------------------------------------------------
local function GetNameFromLink(link)
    local _, name, _ = strsplit(":", link)
    if ( name and (strlen(name) > 0) ) then	-- necessary?
        name = gsub(name, "([^%s]*)%s+([^%s]*)%s+([^%s]*)", "%3")
        name = gsub(name, "([^%s]*)%s+([^%s]*)", "%2")
    end
    return name
end

local function EnhancedMenu_ChatFrame_OnHyperlinkShow(self, playerString, text, button)
    if(playerString and strsub(playerString, 1, 6) == "player") then
        if IsAltKeyDown() and button == "LeftButton" then
			DEFAULT_CHAT_FRAME.editBox:Hide()
            C_PartyInfo.InviteUnit(GetNameFromLink(playerString))
            return
        end
    end
end

hooksecurefunc("ChatFrame_OnHyperlinkShow", EnhancedMenu_ChatFrame_OnHyperlinkShow)

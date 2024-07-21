local _, EM = ...
local L = EM.L
local F = EM.funcs

local LRI = LibStub("LibRealmInfo")

-- function F:URLEncode(obj)
--     local currentIndex = 1
--     local charArray = {}
--     while currentIndex <= #obj do
--         local char = string.byte(obj, currentIndex)
--         charArray[currentIndex] = char
--         currentIndex = currentIndex + 1
--     end
--     local converchar = ""
--     for _, char in ipairs(charArray) do
--         converchar = converchar..string.format("%%%X", char)
--     end
--     return converchar
-- end

function F:ShowArmoryURL(characterName, realmName)
    local id, name, nameForAPI, rules, locale, battlegroup, region, timezone, connectedIDs, englishName, englishNameForAPI = LRI:GetRealmInfo(realmName)

    region = strlower(region)

    locale = strlower(strsub(locale, 1, 2).."-"..strsub(locale, 3, 4))
    realmName = string.gsub(englishName, "'", "")
    realmName = strlower(string.gsub(realmName, " ", "-"))

    local armory = "https://worldofwarcraft.com/"..locale.."/character/"..region.."/"..realmName.."/"..characterName
    
    local editBox = ChatEdit_ChooseBoxForSend()
    ChatEdit_ActivateChat(editBox)
    editBox:SetText(armory)
    editBox:SetCursorPosition(0)
    editBox:HighlightText()
end

function F:ShowRaiderIO(characterName, realmName)
    local id, name, nameForAPI, rules, locale, battlegroup, region, timezone, connectedIDs, englishName, englishNameForAPI = LRI:GetRealmInfo(realmName)

    region = strlower(region)
    realmName = string.gsub(englishName, "'", "")
    realmName = strlower(string.gsub(realmName, " ", "-"))

    local armory = "https://raider.io/characters/"..region.."/"..realmName.."/"..characterName
    
    local editBox = ChatEdit_ChooseBoxForSend()
    ChatEdit_ActivateChat(editBox)
    editBox:SetText(armory)
    editBox:SetCursorPosition(0)
    editBox:HighlightText()
end

function F:ShowName(characterName, realmName)
    local _, name, nameForAPI = LRI:GetRealmInfo(realmName)
    local fullName = characterName.."-"..nameForAPI

    if SendMailNameEditBox and SendMailNameEditBox:IsVisible() then
        SendMailNameEditBox:SetText(fullName)
        SendMailNameEditBox:HighlightText()
    else
        local editBox = ChatEdit_ChooseBoxForSend()
        if editBox:HasFocus() then
            editBox:Insert(fullName)
        else
            ChatEdit_ActivateChat(editBox)
            editBox:SetText(fullName)
            editBox:HighlightText()
        end
    end
end

-- ConfirmGuildInvitePopupDialog -- by q3fuba
StaticPopupDialogs["ENHANCED_MENU_CONFIRM_GUILD_INVITE"] = {
    text = "",
    button1 = YES,
    button2 = NO,
    OnAccept = function() end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
}
function F:ConfirmGuildInvite(characterName, realmName)
    local _, name, nameForAPI = LRI:GetRealmInfo(realmName)
    local fullName = characterName.."-"..nameForAPI

    -- StaticPopupDialogs["ENHANCED_MENU_CONFIRM_GUILD_INVITE"].text = CHAT_GUILD_INVITE_SEND .. "\n" .. fullName
    -- StaticPopupDialogs["ENHANCED_MENU_CONFIRM_GUILD_INVITE"].OnAccept = function() GuildInvite(fullName) end
    -- StaticPopup_Show("ENHANCED_MENU_CONFIRM_GUILD_INVITE")
    GuildInvite(fullName)
end

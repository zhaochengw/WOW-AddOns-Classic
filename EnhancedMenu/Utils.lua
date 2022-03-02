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

    StaticPopupDialogs["ENHANCED_MENU_CONFIRM_GUILD_INVITE"].text = CHAT_GUILD_INVITE_SEND .. "\n" .. fullName
    StaticPopupDialogs["ENHANCED_MENU_CONFIRM_GUILD_INVITE"].OnAccept = function() GuildInvite(fullName) end
    StaticPopup_Show("ENHANCED_MENU_CONFIRM_GUILD_INVITE")
end

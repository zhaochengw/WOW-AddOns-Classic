
local L = LibStub('AceLocale-3.0'):NewLocale(..., 'enUS', true)
if not L then
    return
end

L["|cffff2020(Offline)|r"] = true
L["Always show"] = true
L["Appearance"] = true
L["Are you sure you want to restore the current Settings?"] = true
L["Auto Close"] = true
L["Auto Display"] = true
L["Bag Frame"] = true
L["Bag Style"] = true
L["Bag Toggle"] = true
L["Bank"] = true
L["Blizzard Panel"] = true
L["Bottom"] = true
L["Character Specific Settings"] = true
L["Closing the Character Info"] = true
L["Closing Trade Skills"] = true
L["COD"] = true
L["Color Empty Slots by Bag Type"] = true
L["Color Settings"] = true
L["Columns"] = true
L["Completed Trade"] = true
L["Container Colors"] = true
L["Default"] = true
L["DESC_COLORS"] = "Color preference Settings."
L["DESC_DISPLAY"] = "Auto Display and Close."
L["DESC_FRAMES"] = "%s preference Settings."
L["DESC_GENERAL"] = "General preference Settings."
L["Empty Slot Brightness"] = true
L["Enchanting Color"] = true
L["Entering Combat"] = true
L["Equip"] = true
L["Equipped"] = true
L["Expired"] = true
L["Features"] = true
L["Frame Settings"] = true
L["Global search"] = true
L["Global Settings"] = true
L["Herbalism Color"] = true
L["Highlight Border"] = true
L["Highlight Brightness"] = true
L["Highlight Equipment Set Items"] = true
L["Highlight Items by Quality"] = true
L["Highlight New Items"] = true
L["Highlight Quest Items"] = true
L["Highlight Unusable Items"] = true
L["HOTKEY_ALT_RIGHT"] = "Alt-RightClick"
L["HOTKEY_CTRL_RIGHT"] = "Ctrl-RightClick"
L["Inventory"] = true
L["Item Scale"] = true
L["Keyring Color"] = true
L["Leaving a Vendor"] = true
L["Leaving the Auction House"] = true
L["Leaving the Bank"] = true
L["Leaving the Mail Box"] = true
L["Less than %s days"] = true
L["Less than one day"] = true
L["Lock Frames"] = true
L["Mail"] = true
L["Move down"] = true
L["Move up"] = true
L["Need to reload UI to make some settings take effect"] = true
L["Never show"] = true
L["No record"] = true
L["Normal Color"] = true
L["Opening the Character Info"] = true
L["Opening Trade Skills"] = true
L["Plugin Buttons"] = true
L["Quiver Color"] = true
L["Restore default Settings"] = true
L["Reverse Bag Order"] = true
L["Reverse Slot Order"] = true
L["Show Character Portrait"] = true
L["Show Item Count in Tooltip"] = true
L["Show Junk Icon"] = true
L["Show Offline Text in Bag's Title"] = true
L["Show Quest Starter Icon"] = true
L["Slot Colors"] = true
L["Soul Color"] = true
L["Time Remaining"] = true
L["TITLE_BAG"] = "%s's Inventory"
L["TITLE_BANK"] = "%s's Bank"
L["TITLE_COD"] = "%s's COD"
L["TITLE_EQUIP"] = "%s's Equip"
L["TITLE_MAIL"] = "%s's Mail"
L["Token Frame"] = true
L["TOOLTIP_CHANGE_PLAYER"] = "View another character's items."
L["TOOLTIP_HIDE_BAG"] = "Hide bag"
L["TOOLTIP_HIDE_BAG_FRAME"] = "Hide bags list"
L["TOOLTIP_PURCHASE_BANK_SLOT"] = "Purchase bank slot"
L["TOOLTIP_RETURN_TO_SELF"] = "Return to the current character."
L["TOOLTIP_SEARCH_RECORDS"] = "Open saved search conditions"
L["TOOLTIP_SEARCH_TOGGLE"] = "Search bags"
L["TOOLTIP_SHOW_BAG"] = "Show bag"
L["TOOLTIP_SHOW_BAG_FRAME"] = "Show bags list"
L["TOOLTIP_TOGGLE_BAG"] = "Open inventory"
L["TOOLTIP_TOGGLE_BANK"] = "Open bank"
L["TOOLTIP_TOGGLE_EQUIP"] = "Open equip"
L["TOOLTIP_TOGGLE_GLOBAL_SEARCH"] = "Global search"
L["TOOLTIP_TOGGLE_MAIL"] = "Open mailbox"
L["TOOLTIP_TOGGLE_OTHER_FRAME"] = "Open other bags"
L["TOOLTIP_WATCHED_TOKENS"] = "Change watched tokens"
L["TOOLTIP_WATCHED_TOKENS_LEFTTIP"] = "Drag item to here to add watch"
L["TOOLTIP_WATCHED_TOKENS_ONLY_IN_BAG"] = "Only count in backpack"
L["TOOLTIP_WATCHED_TOKENS_RIGHTTIP"] = "Manage item watch"
L["Top"] = true
L["Total"] = true
L["Trade Containers Location"] = true
L["Trading Items"] = true
L["Visiting a Vendor"] = true
L["Visiting the Auction House"] = true
L["Visiting the Bank"] = true
L["Visiting the Mail Box"] = true
L["Watch Frame"] = true


--[[@debug@
-- @import@

L.TITLE_BAG = '%s\'s Inventory'
L.TITLE_BANK = '%s\'s Bank'
L.TITLE_MAIL = '%s\'s Mail'
L.TITLE_EQUIP = '%s\'s Equip'
L.TITLE_COD = '%s\'s COD'

L['Total'] = true
L['|cffff2020(Offline)|r'] = true
L['Bag Toggle'] = true
L['Expired'] = true

L['Equipped'] = true
L['Inventory'] = true
L['Bank'] = true
L['Mail'] = true
L['COD'] = true
L['Equip'] = true
L['Global search'] = true

L['Move up'] = true
L['Move down'] = true

L.TOOLTIP_CHANGE_PLAYER = 'View another character\'s items.'
L.TOOLTIP_RETURN_TO_SELF = 'Return to the current character.'
L.TOOLTIP_HIDE_BAG_FRAME = 'Hide bags list'
L.TOOLTIP_SHOW_BAG_FRAME = 'Show bags list'
L.TOOLTIP_TOGGLE_BAG = 'Open inventory'
L.TOOLTIP_TOGGLE_BANK = 'Open bank'
L.TOOLTIP_TOGGLE_MAIL = 'Open mailbox'
L.TOOLTIP_TOGGLE_EQUIP = 'Open equip'
L.TOOLTIP_TOGGLE_GLOBAL_SEARCH = 'Global search'
L.TOOLTIP_TOGGLE_OTHER_FRAME = 'Open other bags'
L.TOOLTIP_PURCHASE_BANK_SLOT = 'Purchase bank slot'
L.TOOLTIP_WATCHED_TOKENS_LEFTTIP = 'Drag item to here to add watch'
L.TOOLTIP_WATCHED_TOKENS_RIGHTTIP = 'Manage item watch'
L.TOOLTIP_WATCHED_TOKENS_ONLY_IN_BAG = 'Only count in backpack'
L.TOOLTIP_SHOW_BAG = 'Show bag'
L.TOOLTIP_HIDE_BAG = 'Hide bag'
L.TOOLTIP_SEARCH_TOGGLE = 'Search bags'
L.TOOLTIP_SEARCH_RECORDS = 'Open saved search conditions'

L.HOTKEY_CTRL_RIGHT = 'Ctrl-RightClick'
L.HOTKEY_ALT_RIGHT = 'Alt-RightClick'

---- options

L.DESC_GENERAL = 'General preference Settings.'
L.DESC_FRAMES = '%s preference Settings.'
L.DESC_COLORS = 'Color preference Settings.'
L.DESC_DISPLAY = 'Auto Display and Close.'

L['Character Specific Settings'] = true
L['Frame Settings'] = true
L['Appearance'] = true
L['Blizzard Panel'] = true
L['Reverse Bag Order'] = true
L['Reverse Slot Order'] = true
L['Columns'] = true
L['Item Scale'] = true

L['Time Remaining'] = true
L['Always show'] = true
L['Never show'] = true
L['Less than one day'] = true
L['Less than %s days'] = true

L['Features'] = true
L['Watch Frame'] = true
L['Bag Frame'] = true

L['No record'] = true

L['Restore default Settings'] = true
L['Are you sure you want to restore the current Settings?'] = true
L['Global Settings'] = true
L['Need to reload UI to make some settings take effect'] = true

L['Lock Frames'] = true
L['Show Junk Icon'] = true
L['Show Character Portrait'] = true
L['Show Quest Starter Icon'] = true
L['Show Offline Text in Bag\'s Title'] = true
L['Show Item Count in Tooltip'] = true
L['Trade Containers Location'] = true
L['Bag Style'] = true

L['Default'] = true
L['Top'] = true
L['Bottom'] = true

L['Color Settings'] = true
L['Highlight Border'] = true
L['Highlight Quest Items'] = true
L['Highlight Unusable Items'] = true
L['Highlight Items by Quality'] = true
L['Highlight Equipment Set Items'] = true
L['Highlight New Items'] = true
L['Highlight Brightness'] = true

L['Color Empty Slots by Bag Type'] = true
L['Slot Colors'] = true
L['Container Colors'] = true
L['Normal Color'] = true
L['Quiver Color'] = true
L['Soul Color'] = true
L['Enchanting Color'] = true
L['Herbalism Color'] = true
L['Keyring Color'] = true
L['Empty Slot Brightness'] = true

L['Plugin Buttons'] = true

L['Auto Display'] = true
L['Visiting the Mail Box'] = true
L['Visiting the Auction House'] = true
L['Visiting the Bank'] = true
L['Visiting a Vendor'] = true
L['Opening the Character Info'] = true
L['Opening Trade Skills'] = true
L['Trading Items'] = true
L['Auto Close'] = true
L['Leaving the Mail Box'] = true
L['Leaving the Auction House'] = true
L['Leaving the Bank'] = true
L['Leaving a Vendor'] = true
L['Closing the Character Info'] = true
L['Closing Trade Skills'] = true
L['Completed Trade'] = true
L['Entering Combat'] = true

-- @end-import@
--@end-debug@]]

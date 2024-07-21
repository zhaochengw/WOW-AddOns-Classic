-- Locale.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/17/2024, 3:31:22 PM
--
local A = ...
local function T(l, f)
    local o = LibStub('AceLocale-3.0'):NewLocale(A, l)
    if o then f(o) end
end

T('deDE', function(L)
-- @locale:language=deDE@
L = L or {}
--[[Translation missing --]]
--[[ L["|cffff2020(Offline)|r"] = "|cffff2020(Offline)|r"--]] 
--[[Translation missing --]]
--[[ L["Always show"] = "Always show"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Are you sure you want to restore the current Settings?"] = "Are you sure you want to restore the current Settings?"--]] 
--[[Translation missing --]]
--[[ L["Auto Close"] = "Auto Close"--]] 
--[[Translation missing --]]
--[[ L["Auto Display"] = "Auto Display"--]] 
--[[Translation missing --]]
--[[ L["Bag Frame"] = "Bag Frame"--]] 
--[[Translation missing --]]
--[[ L["Bag Style"] = "Bag Style"--]] 
--[[Translation missing --]]
--[[ L["Bag Toggle"] = "Bag Toggle"--]] 
--[[Translation missing --]]
--[[ L["Bank"] = "Bank"--]] 
--[[Translation missing --]]
--[[ L["Blizzard Panel"] = "Blizzard Panel"--]] 
--[[Translation missing --]]
--[[ L["Bottom"] = "Bottom"--]] 
--[[Translation missing --]]
--[[ L["Character Specific Settings"] = "Character Specific Settings"--]] 
--[[Translation missing --]]
--[[ L["Closing the Character Info"] = "Closing the Character Info"--]] 
--[[Translation missing --]]
--[[ L["Closing Trade Skills"] = "Closing Trade Skills"--]] 
--[[Translation missing --]]
--[[ L["COD"] = "COD"--]] 
--[[Translation missing --]]
--[[ L["Color Empty Slots by Bag Type"] = "Color Empty Slots by Bag Type"--]] 
--[[Translation missing --]]
--[[ L["Color Settings"] = "Color Settings"--]] 
--[[Translation missing --]]
--[[ L["Columns"] = "Columns"--]] 
--[[Translation missing --]]
--[[ L["Completed Trade"] = "Completed Trade"--]] 
--[[Translation missing --]]
--[[ L["Container Colors"] = "Container Colors"--]] 
--[[Translation missing --]]
--[[ L["Default"] = "Default"--]] 
--[[Translation missing --]]
--[[ L["DESC_COLORS"] = "Color preference Settings."--]] 
--[[Translation missing --]]
--[[ L["DESC_DISPLAY"] = "Auto Display and Close."--]] 
--[[Translation missing --]]
--[[ L["DESC_FRAMES"] = "%s preference Settings."--]] 
--[[Translation missing --]]
--[[ L["DESC_GENERAL"] = "General preference Settings."--]] 
--[[Translation missing --]]
--[[ L["Empty Slot Brightness"] = "Empty Slot Brightness"--]] 
--[[Translation missing --]]
--[[ L["Enchanting Color"] = "Enchanting Color"--]] 
--[[Translation missing --]]
--[[ L["Engineering Color"] = "Engineering Color"--]] 
--[[Translation missing --]]
--[[ L["Entering Combat"] = "Entering Combat"--]] 
--[[Translation missing --]]
--[[ L["Equip"] = "Equip"--]] 
--[[Translation missing --]]
--[[ L["Equipped"] = "Equipped"--]] 
--[[Translation missing --]]
--[[ L["Expired"] = "Expired"--]] 
--[[Translation missing --]]
--[[ L["Features"] = "Features"--]] 
--[[Translation missing --]]
--[[ L["Frame Settings"] = "Frame Settings"--]] 
--[[Translation missing --]]
--[[ L["Gems Color"] = "Gems Color"--]] 
--[[Translation missing --]]
--[[ L["Global search"] = "Global search"--]] 
--[[Translation missing --]]
--[[ L["Global Settings"] = "Global Settings"--]] 
--[[Translation missing --]]
--[[ L["Guild bank"] = "Guild bank"--]] 
--[[Translation missing --]]
--[[ L["Herbalism Color"] = "Herbalism Color"--]] 
--[[Translation missing --]]
--[[ L["Highlight Border"] = "Highlight Border"--]] 
--[[Translation missing --]]
--[[ L["Highlight Brightness"] = "Highlight Brightness"--]] 
--[[Translation missing --]]
--[[ L["Highlight Equipment Set Items"] = "Highlight Equipment Set Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Items by Quality"] = "Highlight Items by Quality"--]] 
--[[Translation missing --]]
--[[ L["Highlight New Items"] = "Highlight New Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Quest Items"] = "Highlight Quest Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Unusable Items"] = "Highlight Unusable Items"--]] 
--[[Translation missing --]]
--[[ L["HOTKEY_ALT_RIGHT"] = "Alt-RightClick"--]] 
--[[Translation missing --]]
--[[ L["HOTKEY_CTRL_RIGHT"] = "Ctrl-RightClick"--]] 
--[[Translation missing --]]
--[[ L["Inventory"] = "Inventory"--]] 
--[[Translation missing --]]
--[[ L["Item Scale"] = "Item Scale"--]] 
--[[Translation missing --]]
--[[ L["Keyring Color"] = "Keyring Color"--]] 
--[[Translation missing --]]
--[[ L["Leatherworking Color"] = "Leatherworking Color"--]] 
--[[Translation missing --]]
--[[ L["Leaving a Vendor"] = "Leaving a Vendor"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Auction House"] = "Leaving the Auction House"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Bank"] = "Leaving the Bank"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Mail Box"] = "Leaving the Mail Box"--]] 
--[[Translation missing --]]
--[[ L["Less than %s days"] = "Less than %s days"--]] 
--[[Translation missing --]]
--[[ L["Less than one day"] = "Less than one day"--]] 
--[[Translation missing --]]
--[[ L["Lock Frames"] = "Lock Frames"--]] 
--[[Translation missing --]]
--[[ L["Mail"] = "Mail"--]] 
--[[Translation missing --]]
--[[ L["Mining Color"] = "Mining Color"--]] 
--[[Translation missing --]]
--[[ L["Move down"] = "Move down"--]] 
--[[Translation missing --]]
--[[ L["Move up"] = "Move up"--]] 
--[[Translation missing --]]
--[[ L["Need to reload UI to make some settings take effect"] = "Need to reload UI to make some settings take effect"--]] 
--[[Translation missing --]]
--[[ L["Never show"] = "Never show"--]] 
--[[Translation missing --]]
--[[ L["No record"] = "No record"--]] 
--[[Translation missing --]]
--[[ L["Normal Color"] = "Normal Color"--]] 
--[[Translation missing --]]
--[[ L["Opening the Character Info"] = "Opening the Character Info"--]] 
--[[Translation missing --]]
--[[ L["Opening Trade Skills"] = "Opening Trade Skills"--]] 
--[[Translation missing --]]
--[[ L["Plugin Buttons"] = "Plugin Buttons"--]] 
--[[Translation missing --]]
--[[ L["Quiver Color"] = "Quiver Color"--]] 
--[[Translation missing --]]
--[[ L["Restore default Settings"] = "Restore default Settings"--]] 
--[[Translation missing --]]
--[[ L["Reverse Bag Order"] = "Reverse Bag Order"--]] 
--[[Translation missing --]]
--[[ L["Reverse Slot Order"] = "Reverse Slot Order"--]] 
--[[Translation missing --]]
--[[ L["Show Character Portrait"] = "Show Character Portrait"--]] 
--[[Translation missing --]]
--[[ L["Show Guild Bank Count in Tooltip"] = "Show Guild Bank Count in Tooltip"--]] 
--[[Translation missing --]]
--[[ L["Show Item Count in Tooltip"] = "Show Item Count in Tooltip"--]] 
--[[Translation missing --]]
--[[ L["Show Junk Icon"] = "Show Junk Icon"--]] 
--[[Translation missing --]]
--[[ L["Show Offline Text in Bag's Title"] = "Show Offline Text in Bag's Title"--]] 
--[[Translation missing --]]
--[[ L["Show Quest Starter Icon"] = "Show Quest Starter Icon"--]] 
--[[Translation missing --]]
--[[ L["Slot Colors"] = "Slot Colors"--]] 
--[[Translation missing --]]
--[[ L["Soul Color"] = "Soul Color"--]] 
--[[Translation missing --]]
--[[ L["Time Remaining"] = "Time Remaining"--]] 
--[[Translation missing --]]
--[[ L["TITLE_BAG"] = "%s's Inventory"--]] 
--[[Translation missing --]]
--[[ L["TITLE_BANK"] = "%s's Bank"--]] 
--[[Translation missing --]]
--[[ L["TITLE_COD"] = "%s's COD"--]] 
--[[Translation missing --]]
--[[ L["TITLE_EQUIP"] = "%s's Equip"--]] 
--[[Translation missing --]]
--[[ L["TITLE_MAIL"] = "%s's Mail"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_CHANGE_PLAYER"] = "View another character's items."--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_HIDE_BAG"] = "Hide bag"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_HIDE_BAG_FRAME"] = "Hide bags list"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_PURCHASE_BANK_SLOT"] = "Purchase bank slot"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_RETURN_TO_SELF"] = "Return to the current character."--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SEARCH_RECORDS"] = "Open saved search conditions"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SEARCH_TOGGLE"] = "Search bags"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SHOW_BAG"] = "Show bag"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SHOW_BAG_FRAME"] = "Show bags list"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_BAG"] = "Open inventory"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_BANK"] = "Open bank"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_EQUIP"] = "Open equip"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_GLOBAL_SEARCH"] = "Global search"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_MAIL"] = "Open mailbox"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_OTHER_FRAME"] = "Open other bags"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_LEFTTIP"] = "Drag item to here to add watch"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_ONLY_IN_BAG"] = "Only count in backpack"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_RIGHTTIP"] = "Manage item watch"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_SHIFT"] = "<Press SHIFT to view single item>"--]] 
--[[Translation missing --]]
--[[ L["Top"] = "Top"--]] 
--[[Translation missing --]]
--[[ L["Total"] = "Total"--]] 
--[[Translation missing --]]
--[[ L["Trade Containers Location"] = "Trade Containers Location"--]] 
--[[Translation missing --]]
--[[ L["Trading Items"] = "Trading Items"--]] 
--[[Translation missing --]]
--[[ L["Visiting a Vendor"] = "Visiting a Vendor"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Auction House"] = "Visiting the Auction House"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Bank"] = "Visiting the Bank"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Mail Box"] = "Visiting the Mail Box"--]] 
--[[Translation missing --]]
--[[ L["Watch Frame"] = "Watch Frame"--]]
--@end-locale@]=]
end)

T('esES', function(L)
-- @locale:language=esES@
L = L or {}
--[[Translation missing --]]
--[[ L["|cffff2020(Offline)|r"] = "|cffff2020(Offline)|r"--]] 
--[[Translation missing --]]
--[[ L["Always show"] = "Always show"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Are you sure you want to restore the current Settings?"] = "Are you sure you want to restore the current Settings?"--]] 
--[[Translation missing --]]
--[[ L["Auto Close"] = "Auto Close"--]] 
--[[Translation missing --]]
--[[ L["Auto Display"] = "Auto Display"--]] 
--[[Translation missing --]]
--[[ L["Bag Frame"] = "Bag Frame"--]] 
--[[Translation missing --]]
--[[ L["Bag Style"] = "Bag Style"--]] 
--[[Translation missing --]]
--[[ L["Bag Toggle"] = "Bag Toggle"--]] 
--[[Translation missing --]]
--[[ L["Bank"] = "Bank"--]] 
--[[Translation missing --]]
--[[ L["Blizzard Panel"] = "Blizzard Panel"--]] 
--[[Translation missing --]]
--[[ L["Bottom"] = "Bottom"--]] 
--[[Translation missing --]]
--[[ L["Character Specific Settings"] = "Character Specific Settings"--]] 
--[[Translation missing --]]
--[[ L["Closing the Character Info"] = "Closing the Character Info"--]] 
--[[Translation missing --]]
--[[ L["Closing Trade Skills"] = "Closing Trade Skills"--]] 
--[[Translation missing --]]
--[[ L["COD"] = "COD"--]] 
--[[Translation missing --]]
--[[ L["Color Empty Slots by Bag Type"] = "Color Empty Slots by Bag Type"--]] 
--[[Translation missing --]]
--[[ L["Color Settings"] = "Color Settings"--]] 
--[[Translation missing --]]
--[[ L["Columns"] = "Columns"--]] 
--[[Translation missing --]]
--[[ L["Completed Trade"] = "Completed Trade"--]] 
--[[Translation missing --]]
--[[ L["Container Colors"] = "Container Colors"--]] 
--[[Translation missing --]]
--[[ L["Default"] = "Default"--]] 
--[[Translation missing --]]
--[[ L["DESC_COLORS"] = "Color preference Settings."--]] 
--[[Translation missing --]]
--[[ L["DESC_DISPLAY"] = "Auto Display and Close."--]] 
--[[Translation missing --]]
--[[ L["DESC_FRAMES"] = "%s preference Settings."--]] 
--[[Translation missing --]]
--[[ L["DESC_GENERAL"] = "General preference Settings."--]] 
--[[Translation missing --]]
--[[ L["Empty Slot Brightness"] = "Empty Slot Brightness"--]] 
--[[Translation missing --]]
--[[ L["Enchanting Color"] = "Enchanting Color"--]] 
--[[Translation missing --]]
--[[ L["Engineering Color"] = "Engineering Color"--]] 
--[[Translation missing --]]
--[[ L["Entering Combat"] = "Entering Combat"--]] 
--[[Translation missing --]]
--[[ L["Equip"] = "Equip"--]] 
--[[Translation missing --]]
--[[ L["Equipped"] = "Equipped"--]] 
--[[Translation missing --]]
--[[ L["Expired"] = "Expired"--]] 
--[[Translation missing --]]
--[[ L["Features"] = "Features"--]] 
--[[Translation missing --]]
--[[ L["Frame Settings"] = "Frame Settings"--]] 
--[[Translation missing --]]
--[[ L["Gems Color"] = "Gems Color"--]] 
--[[Translation missing --]]
--[[ L["Global search"] = "Global search"--]] 
--[[Translation missing --]]
--[[ L["Global Settings"] = "Global Settings"--]] 
--[[Translation missing --]]
--[[ L["Guild bank"] = "Guild bank"--]] 
--[[Translation missing --]]
--[[ L["Herbalism Color"] = "Herbalism Color"--]] 
--[[Translation missing --]]
--[[ L["Highlight Border"] = "Highlight Border"--]] 
--[[Translation missing --]]
--[[ L["Highlight Brightness"] = "Highlight Brightness"--]] 
--[[Translation missing --]]
--[[ L["Highlight Equipment Set Items"] = "Highlight Equipment Set Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Items by Quality"] = "Highlight Items by Quality"--]] 
--[[Translation missing --]]
--[[ L["Highlight New Items"] = "Highlight New Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Quest Items"] = "Highlight Quest Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Unusable Items"] = "Highlight Unusable Items"--]] 
--[[Translation missing --]]
--[[ L["HOTKEY_ALT_RIGHT"] = "Alt-RightClick"--]] 
--[[Translation missing --]]
--[[ L["HOTKEY_CTRL_RIGHT"] = "Ctrl-RightClick"--]] 
--[[Translation missing --]]
--[[ L["Inventory"] = "Inventory"--]] 
--[[Translation missing --]]
--[[ L["Item Scale"] = "Item Scale"--]] 
--[[Translation missing --]]
--[[ L["Keyring Color"] = "Keyring Color"--]] 
--[[Translation missing --]]
--[[ L["Leatherworking Color"] = "Leatherworking Color"--]] 
--[[Translation missing --]]
--[[ L["Leaving a Vendor"] = "Leaving a Vendor"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Auction House"] = "Leaving the Auction House"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Bank"] = "Leaving the Bank"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Mail Box"] = "Leaving the Mail Box"--]] 
--[[Translation missing --]]
--[[ L["Less than %s days"] = "Less than %s days"--]] 
--[[Translation missing --]]
--[[ L["Less than one day"] = "Less than one day"--]] 
--[[Translation missing --]]
--[[ L["Lock Frames"] = "Lock Frames"--]] 
--[[Translation missing --]]
--[[ L["Mail"] = "Mail"--]] 
--[[Translation missing --]]
--[[ L["Mining Color"] = "Mining Color"--]] 
--[[Translation missing --]]
--[[ L["Move down"] = "Move down"--]] 
--[[Translation missing --]]
--[[ L["Move up"] = "Move up"--]] 
--[[Translation missing --]]
--[[ L["Need to reload UI to make some settings take effect"] = "Need to reload UI to make some settings take effect"--]] 
--[[Translation missing --]]
--[[ L["Never show"] = "Never show"--]] 
--[[Translation missing --]]
--[[ L["No record"] = "No record"--]] 
--[[Translation missing --]]
--[[ L["Normal Color"] = "Normal Color"--]] 
--[[Translation missing --]]
--[[ L["Opening the Character Info"] = "Opening the Character Info"--]] 
--[[Translation missing --]]
--[[ L["Opening Trade Skills"] = "Opening Trade Skills"--]] 
--[[Translation missing --]]
--[[ L["Plugin Buttons"] = "Plugin Buttons"--]] 
--[[Translation missing --]]
--[[ L["Quiver Color"] = "Quiver Color"--]] 
--[[Translation missing --]]
--[[ L["Restore default Settings"] = "Restore default Settings"--]] 
--[[Translation missing --]]
--[[ L["Reverse Bag Order"] = "Reverse Bag Order"--]] 
--[[Translation missing --]]
--[[ L["Reverse Slot Order"] = "Reverse Slot Order"--]] 
--[[Translation missing --]]
--[[ L["Show Character Portrait"] = "Show Character Portrait"--]] 
--[[Translation missing --]]
--[[ L["Show Guild Bank Count in Tooltip"] = "Show Guild Bank Count in Tooltip"--]] 
--[[Translation missing --]]
--[[ L["Show Item Count in Tooltip"] = "Show Item Count in Tooltip"--]] 
--[[Translation missing --]]
--[[ L["Show Junk Icon"] = "Show Junk Icon"--]] 
--[[Translation missing --]]
--[[ L["Show Offline Text in Bag's Title"] = "Show Offline Text in Bag's Title"--]] 
--[[Translation missing --]]
--[[ L["Show Quest Starter Icon"] = "Show Quest Starter Icon"--]] 
--[[Translation missing --]]
--[[ L["Slot Colors"] = "Slot Colors"--]] 
--[[Translation missing --]]
--[[ L["Soul Color"] = "Soul Color"--]] 
--[[Translation missing --]]
--[[ L["Time Remaining"] = "Time Remaining"--]] 
--[[Translation missing --]]
--[[ L["TITLE_BAG"] = "%s's Inventory"--]] 
--[[Translation missing --]]
--[[ L["TITLE_BANK"] = "%s's Bank"--]] 
--[[Translation missing --]]
--[[ L["TITLE_COD"] = "%s's COD"--]] 
--[[Translation missing --]]
--[[ L["TITLE_EQUIP"] = "%s's Equip"--]] 
--[[Translation missing --]]
--[[ L["TITLE_MAIL"] = "%s's Mail"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_CHANGE_PLAYER"] = "View another character's items."--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_HIDE_BAG"] = "Hide bag"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_HIDE_BAG_FRAME"] = "Hide bags list"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_PURCHASE_BANK_SLOT"] = "Purchase bank slot"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_RETURN_TO_SELF"] = "Return to the current character."--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SEARCH_RECORDS"] = "Open saved search conditions"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SEARCH_TOGGLE"] = "Search bags"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SHOW_BAG"] = "Show bag"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SHOW_BAG_FRAME"] = "Show bags list"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_BAG"] = "Open inventory"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_BANK"] = "Open bank"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_EQUIP"] = "Open equip"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_GLOBAL_SEARCH"] = "Global search"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_MAIL"] = "Open mailbox"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_OTHER_FRAME"] = "Open other bags"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_LEFTTIP"] = "Drag item to here to add watch"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_ONLY_IN_BAG"] = "Only count in backpack"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_RIGHTTIP"] = "Manage item watch"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_SHIFT"] = "<Press SHIFT to view single item>"--]] 
--[[Translation missing --]]
--[[ L["Top"] = "Top"--]] 
--[[Translation missing --]]
--[[ L["Total"] = "Total"--]] 
--[[Translation missing --]]
--[[ L["Trade Containers Location"] = "Trade Containers Location"--]] 
--[[Translation missing --]]
--[[ L["Trading Items"] = "Trading Items"--]] 
--[[Translation missing --]]
--[[ L["Visiting a Vendor"] = "Visiting a Vendor"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Auction House"] = "Visiting the Auction House"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Bank"] = "Visiting the Bank"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Mail Box"] = "Visiting the Mail Box"--]] 
--[[Translation missing --]]
--[[ L["Watch Frame"] = "Watch Frame"--]]
--@end-locale@]=]
end)

T('frFR', function(L)
-- @locale:language=frFR@
L = L or {}
--[[Translation missing --]]
--[[ L["|cffff2020(Offline)|r"] = "|cffff2020(Offline)|r"--]] 
--[[Translation missing --]]
--[[ L["Always show"] = "Always show"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Are you sure you want to restore the current Settings?"] = "Are you sure you want to restore the current Settings?"--]] 
--[[Translation missing --]]
--[[ L["Auto Close"] = "Auto Close"--]] 
--[[Translation missing --]]
--[[ L["Auto Display"] = "Auto Display"--]] 
--[[Translation missing --]]
--[[ L["Bag Frame"] = "Bag Frame"--]] 
--[[Translation missing --]]
--[[ L["Bag Style"] = "Bag Style"--]] 
--[[Translation missing --]]
--[[ L["Bag Toggle"] = "Bag Toggle"--]] 
--[[Translation missing --]]
--[[ L["Bank"] = "Bank"--]] 
--[[Translation missing --]]
--[[ L["Blizzard Panel"] = "Blizzard Panel"--]] 
--[[Translation missing --]]
--[[ L["Bottom"] = "Bottom"--]] 
--[[Translation missing --]]
--[[ L["Character Specific Settings"] = "Character Specific Settings"--]] 
--[[Translation missing --]]
--[[ L["Closing the Character Info"] = "Closing the Character Info"--]] 
--[[Translation missing --]]
--[[ L["Closing Trade Skills"] = "Closing Trade Skills"--]] 
--[[Translation missing --]]
--[[ L["COD"] = "COD"--]] 
--[[Translation missing --]]
--[[ L["Color Empty Slots by Bag Type"] = "Color Empty Slots by Bag Type"--]] 
--[[Translation missing --]]
--[[ L["Color Settings"] = "Color Settings"--]] 
--[[Translation missing --]]
--[[ L["Columns"] = "Columns"--]] 
--[[Translation missing --]]
--[[ L["Completed Trade"] = "Completed Trade"--]] 
--[[Translation missing --]]
--[[ L["Container Colors"] = "Container Colors"--]] 
--[[Translation missing --]]
--[[ L["Default"] = "Default"--]] 
--[[Translation missing --]]
--[[ L["DESC_COLORS"] = "Color preference Settings."--]] 
--[[Translation missing --]]
--[[ L["DESC_DISPLAY"] = "Auto Display and Close."--]] 
--[[Translation missing --]]
--[[ L["DESC_FRAMES"] = "%s preference Settings."--]] 
--[[Translation missing --]]
--[[ L["DESC_GENERAL"] = "General preference Settings."--]] 
--[[Translation missing --]]
--[[ L["Empty Slot Brightness"] = "Empty Slot Brightness"--]] 
--[[Translation missing --]]
--[[ L["Enchanting Color"] = "Enchanting Color"--]] 
--[[Translation missing --]]
--[[ L["Engineering Color"] = "Engineering Color"--]] 
--[[Translation missing --]]
--[[ L["Entering Combat"] = "Entering Combat"--]] 
--[[Translation missing --]]
--[[ L["Equip"] = "Equip"--]] 
--[[Translation missing --]]
--[[ L["Equipped"] = "Equipped"--]] 
--[[Translation missing --]]
--[[ L["Expired"] = "Expired"--]] 
--[[Translation missing --]]
--[[ L["Features"] = "Features"--]] 
--[[Translation missing --]]
--[[ L["Frame Settings"] = "Frame Settings"--]] 
--[[Translation missing --]]
--[[ L["Gems Color"] = "Gems Color"--]] 
--[[Translation missing --]]
--[[ L["Global search"] = "Global search"--]] 
--[[Translation missing --]]
--[[ L["Global Settings"] = "Global Settings"--]] 
--[[Translation missing --]]
--[[ L["Guild bank"] = "Guild bank"--]] 
--[[Translation missing --]]
--[[ L["Herbalism Color"] = "Herbalism Color"--]] 
--[[Translation missing --]]
--[[ L["Highlight Border"] = "Highlight Border"--]] 
--[[Translation missing --]]
--[[ L["Highlight Brightness"] = "Highlight Brightness"--]] 
--[[Translation missing --]]
--[[ L["Highlight Equipment Set Items"] = "Highlight Equipment Set Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Items by Quality"] = "Highlight Items by Quality"--]] 
--[[Translation missing --]]
--[[ L["Highlight New Items"] = "Highlight New Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Quest Items"] = "Highlight Quest Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Unusable Items"] = "Highlight Unusable Items"--]] 
--[[Translation missing --]]
--[[ L["HOTKEY_ALT_RIGHT"] = "Alt-RightClick"--]] 
--[[Translation missing --]]
--[[ L["HOTKEY_CTRL_RIGHT"] = "Ctrl-RightClick"--]] 
--[[Translation missing --]]
--[[ L["Inventory"] = "Inventory"--]] 
--[[Translation missing --]]
--[[ L["Item Scale"] = "Item Scale"--]] 
--[[Translation missing --]]
--[[ L["Keyring Color"] = "Keyring Color"--]] 
--[[Translation missing --]]
--[[ L["Leatherworking Color"] = "Leatherworking Color"--]] 
--[[Translation missing --]]
--[[ L["Leaving a Vendor"] = "Leaving a Vendor"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Auction House"] = "Leaving the Auction House"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Bank"] = "Leaving the Bank"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Mail Box"] = "Leaving the Mail Box"--]] 
--[[Translation missing --]]
--[[ L["Less than %s days"] = "Less than %s days"--]] 
--[[Translation missing --]]
--[[ L["Less than one day"] = "Less than one day"--]] 
--[[Translation missing --]]
--[[ L["Lock Frames"] = "Lock Frames"--]] 
--[[Translation missing --]]
--[[ L["Mail"] = "Mail"--]] 
--[[Translation missing --]]
--[[ L["Mining Color"] = "Mining Color"--]] 
--[[Translation missing --]]
--[[ L["Move down"] = "Move down"--]] 
--[[Translation missing --]]
--[[ L["Move up"] = "Move up"--]] 
--[[Translation missing --]]
--[[ L["Need to reload UI to make some settings take effect"] = "Need to reload UI to make some settings take effect"--]] 
--[[Translation missing --]]
--[[ L["Never show"] = "Never show"--]] 
--[[Translation missing --]]
--[[ L["No record"] = "No record"--]] 
--[[Translation missing --]]
--[[ L["Normal Color"] = "Normal Color"--]] 
--[[Translation missing --]]
--[[ L["Opening the Character Info"] = "Opening the Character Info"--]] 
--[[Translation missing --]]
--[[ L["Opening Trade Skills"] = "Opening Trade Skills"--]] 
--[[Translation missing --]]
--[[ L["Plugin Buttons"] = "Plugin Buttons"--]] 
--[[Translation missing --]]
--[[ L["Quiver Color"] = "Quiver Color"--]] 
--[[Translation missing --]]
--[[ L["Restore default Settings"] = "Restore default Settings"--]] 
--[[Translation missing --]]
--[[ L["Reverse Bag Order"] = "Reverse Bag Order"--]] 
--[[Translation missing --]]
--[[ L["Reverse Slot Order"] = "Reverse Slot Order"--]] 
--[[Translation missing --]]
--[[ L["Show Character Portrait"] = "Show Character Portrait"--]] 
--[[Translation missing --]]
--[[ L["Show Guild Bank Count in Tooltip"] = "Show Guild Bank Count in Tooltip"--]] 
--[[Translation missing --]]
--[[ L["Show Item Count in Tooltip"] = "Show Item Count in Tooltip"--]] 
--[[Translation missing --]]
--[[ L["Show Junk Icon"] = "Show Junk Icon"--]] 
--[[Translation missing --]]
--[[ L["Show Offline Text in Bag's Title"] = "Show Offline Text in Bag's Title"--]] 
--[[Translation missing --]]
--[[ L["Show Quest Starter Icon"] = "Show Quest Starter Icon"--]] 
--[[Translation missing --]]
--[[ L["Slot Colors"] = "Slot Colors"--]] 
--[[Translation missing --]]
--[[ L["Soul Color"] = "Soul Color"--]] 
--[[Translation missing --]]
--[[ L["Time Remaining"] = "Time Remaining"--]] 
--[[Translation missing --]]
--[[ L["TITLE_BAG"] = "%s's Inventory"--]] 
--[[Translation missing --]]
--[[ L["TITLE_BANK"] = "%s's Bank"--]] 
--[[Translation missing --]]
--[[ L["TITLE_COD"] = "%s's COD"--]] 
--[[Translation missing --]]
--[[ L["TITLE_EQUIP"] = "%s's Equip"--]] 
--[[Translation missing --]]
--[[ L["TITLE_MAIL"] = "%s's Mail"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_CHANGE_PLAYER"] = "View another character's items."--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_HIDE_BAG"] = "Hide bag"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_HIDE_BAG_FRAME"] = "Hide bags list"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_PURCHASE_BANK_SLOT"] = "Purchase bank slot"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_RETURN_TO_SELF"] = "Return to the current character."--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SEARCH_RECORDS"] = "Open saved search conditions"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SEARCH_TOGGLE"] = "Search bags"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SHOW_BAG"] = "Show bag"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SHOW_BAG_FRAME"] = "Show bags list"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_BAG"] = "Open inventory"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_BANK"] = "Open bank"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_EQUIP"] = "Open equip"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_GLOBAL_SEARCH"] = "Global search"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_MAIL"] = "Open mailbox"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_OTHER_FRAME"] = "Open other bags"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_LEFTTIP"] = "Drag item to here to add watch"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_ONLY_IN_BAG"] = "Only count in backpack"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_RIGHTTIP"] = "Manage item watch"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_SHIFT"] = "<Press SHIFT to view single item>"--]] 
--[[Translation missing --]]
--[[ L["Top"] = "Top"--]] 
--[[Translation missing --]]
--[[ L["Total"] = "Total"--]] 
--[[Translation missing --]]
--[[ L["Trade Containers Location"] = "Trade Containers Location"--]] 
--[[Translation missing --]]
--[[ L["Trading Items"] = "Trading Items"--]] 
--[[Translation missing --]]
--[[ L["Visiting a Vendor"] = "Visiting a Vendor"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Auction House"] = "Visiting the Auction House"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Bank"] = "Visiting the Bank"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Mail Box"] = "Visiting the Mail Box"--]] 
--[[Translation missing --]]
--[[ L["Watch Frame"] = "Watch Frame"--]]
--@end-locale@]=]
end)

T('itIT', function(L)
-- @locale:language=itIT@
L = L or {}
--[[Translation missing --]]
--[[ L["|cffff2020(Offline)|r"] = "|cffff2020(Offline)|r"--]] 
--[[Translation missing --]]
--[[ L["Always show"] = "Always show"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Are you sure you want to restore the current Settings?"] = "Are you sure you want to restore the current Settings?"--]] 
--[[Translation missing --]]
--[[ L["Auto Close"] = "Auto Close"--]] 
--[[Translation missing --]]
--[[ L["Auto Display"] = "Auto Display"--]] 
--[[Translation missing --]]
--[[ L["Bag Frame"] = "Bag Frame"--]] 
--[[Translation missing --]]
--[[ L["Bag Style"] = "Bag Style"--]] 
--[[Translation missing --]]
--[[ L["Bag Toggle"] = "Bag Toggle"--]] 
--[[Translation missing --]]
--[[ L["Bank"] = "Bank"--]] 
--[[Translation missing --]]
--[[ L["Blizzard Panel"] = "Blizzard Panel"--]] 
--[[Translation missing --]]
--[[ L["Bottom"] = "Bottom"--]] 
--[[Translation missing --]]
--[[ L["Character Specific Settings"] = "Character Specific Settings"--]] 
--[[Translation missing --]]
--[[ L["Closing the Character Info"] = "Closing the Character Info"--]] 
--[[Translation missing --]]
--[[ L["Closing Trade Skills"] = "Closing Trade Skills"--]] 
--[[Translation missing --]]
--[[ L["COD"] = "COD"--]] 
--[[Translation missing --]]
--[[ L["Color Empty Slots by Bag Type"] = "Color Empty Slots by Bag Type"--]] 
--[[Translation missing --]]
--[[ L["Color Settings"] = "Color Settings"--]] 
--[[Translation missing --]]
--[[ L["Columns"] = "Columns"--]] 
--[[Translation missing --]]
--[[ L["Completed Trade"] = "Completed Trade"--]] 
--[[Translation missing --]]
--[[ L["Container Colors"] = "Container Colors"--]] 
--[[Translation missing --]]
--[[ L["Default"] = "Default"--]] 
--[[Translation missing --]]
--[[ L["DESC_COLORS"] = "Color preference Settings."--]] 
--[[Translation missing --]]
--[[ L["DESC_DISPLAY"] = "Auto Display and Close."--]] 
--[[Translation missing --]]
--[[ L["DESC_FRAMES"] = "%s preference Settings."--]] 
--[[Translation missing --]]
--[[ L["DESC_GENERAL"] = "General preference Settings."--]] 
--[[Translation missing --]]
--[[ L["Empty Slot Brightness"] = "Empty Slot Brightness"--]] 
--[[Translation missing --]]
--[[ L["Enchanting Color"] = "Enchanting Color"--]] 
--[[Translation missing --]]
--[[ L["Engineering Color"] = "Engineering Color"--]] 
--[[Translation missing --]]
--[[ L["Entering Combat"] = "Entering Combat"--]] 
--[[Translation missing --]]
--[[ L["Equip"] = "Equip"--]] 
--[[Translation missing --]]
--[[ L["Equipped"] = "Equipped"--]] 
--[[Translation missing --]]
--[[ L["Expired"] = "Expired"--]] 
--[[Translation missing --]]
--[[ L["Features"] = "Features"--]] 
--[[Translation missing --]]
--[[ L["Frame Settings"] = "Frame Settings"--]] 
--[[Translation missing --]]
--[[ L["Gems Color"] = "Gems Color"--]] 
--[[Translation missing --]]
--[[ L["Global search"] = "Global search"--]] 
--[[Translation missing --]]
--[[ L["Global Settings"] = "Global Settings"--]] 
--[[Translation missing --]]
--[[ L["Guild bank"] = "Guild bank"--]] 
--[[Translation missing --]]
--[[ L["Herbalism Color"] = "Herbalism Color"--]] 
--[[Translation missing --]]
--[[ L["Highlight Border"] = "Highlight Border"--]] 
--[[Translation missing --]]
--[[ L["Highlight Brightness"] = "Highlight Brightness"--]] 
--[[Translation missing --]]
--[[ L["Highlight Equipment Set Items"] = "Highlight Equipment Set Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Items by Quality"] = "Highlight Items by Quality"--]] 
--[[Translation missing --]]
--[[ L["Highlight New Items"] = "Highlight New Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Quest Items"] = "Highlight Quest Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Unusable Items"] = "Highlight Unusable Items"--]] 
--[[Translation missing --]]
--[[ L["HOTKEY_ALT_RIGHT"] = "Alt-RightClick"--]] 
--[[Translation missing --]]
--[[ L["HOTKEY_CTRL_RIGHT"] = "Ctrl-RightClick"--]] 
--[[Translation missing --]]
--[[ L["Inventory"] = "Inventory"--]] 
--[[Translation missing --]]
--[[ L["Item Scale"] = "Item Scale"--]] 
--[[Translation missing --]]
--[[ L["Keyring Color"] = "Keyring Color"--]] 
--[[Translation missing --]]
--[[ L["Leatherworking Color"] = "Leatherworking Color"--]] 
--[[Translation missing --]]
--[[ L["Leaving a Vendor"] = "Leaving a Vendor"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Auction House"] = "Leaving the Auction House"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Bank"] = "Leaving the Bank"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Mail Box"] = "Leaving the Mail Box"--]] 
--[[Translation missing --]]
--[[ L["Less than %s days"] = "Less than %s days"--]] 
--[[Translation missing --]]
--[[ L["Less than one day"] = "Less than one day"--]] 
--[[Translation missing --]]
--[[ L["Lock Frames"] = "Lock Frames"--]] 
--[[Translation missing --]]
--[[ L["Mail"] = "Mail"--]] 
--[[Translation missing --]]
--[[ L["Mining Color"] = "Mining Color"--]] 
--[[Translation missing --]]
--[[ L["Move down"] = "Move down"--]] 
--[[Translation missing --]]
--[[ L["Move up"] = "Move up"--]] 
--[[Translation missing --]]
--[[ L["Need to reload UI to make some settings take effect"] = "Need to reload UI to make some settings take effect"--]] 
--[[Translation missing --]]
--[[ L["Never show"] = "Never show"--]] 
--[[Translation missing --]]
--[[ L["No record"] = "No record"--]] 
--[[Translation missing --]]
--[[ L["Normal Color"] = "Normal Color"--]] 
--[[Translation missing --]]
--[[ L["Opening the Character Info"] = "Opening the Character Info"--]] 
--[[Translation missing --]]
--[[ L["Opening Trade Skills"] = "Opening Trade Skills"--]] 
--[[Translation missing --]]
--[[ L["Plugin Buttons"] = "Plugin Buttons"--]] 
--[[Translation missing --]]
--[[ L["Quiver Color"] = "Quiver Color"--]] 
--[[Translation missing --]]
--[[ L["Restore default Settings"] = "Restore default Settings"--]] 
--[[Translation missing --]]
--[[ L["Reverse Bag Order"] = "Reverse Bag Order"--]] 
--[[Translation missing --]]
--[[ L["Reverse Slot Order"] = "Reverse Slot Order"--]] 
--[[Translation missing --]]
--[[ L["Show Character Portrait"] = "Show Character Portrait"--]] 
--[[Translation missing --]]
--[[ L["Show Guild Bank Count in Tooltip"] = "Show Guild Bank Count in Tooltip"--]] 
--[[Translation missing --]]
--[[ L["Show Item Count in Tooltip"] = "Show Item Count in Tooltip"--]] 
--[[Translation missing --]]
--[[ L["Show Junk Icon"] = "Show Junk Icon"--]] 
--[[Translation missing --]]
--[[ L["Show Offline Text in Bag's Title"] = "Show Offline Text in Bag's Title"--]] 
--[[Translation missing --]]
--[[ L["Show Quest Starter Icon"] = "Show Quest Starter Icon"--]] 
--[[Translation missing --]]
--[[ L["Slot Colors"] = "Slot Colors"--]] 
--[[Translation missing --]]
--[[ L["Soul Color"] = "Soul Color"--]] 
--[[Translation missing --]]
--[[ L["Time Remaining"] = "Time Remaining"--]] 
--[[Translation missing --]]
--[[ L["TITLE_BAG"] = "%s's Inventory"--]] 
--[[Translation missing --]]
--[[ L["TITLE_BANK"] = "%s's Bank"--]] 
--[[Translation missing --]]
--[[ L["TITLE_COD"] = "%s's COD"--]] 
--[[Translation missing --]]
--[[ L["TITLE_EQUIP"] = "%s's Equip"--]] 
--[[Translation missing --]]
--[[ L["TITLE_MAIL"] = "%s's Mail"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_CHANGE_PLAYER"] = "View another character's items."--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_HIDE_BAG"] = "Hide bag"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_HIDE_BAG_FRAME"] = "Hide bags list"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_PURCHASE_BANK_SLOT"] = "Purchase bank slot"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_RETURN_TO_SELF"] = "Return to the current character."--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SEARCH_RECORDS"] = "Open saved search conditions"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SEARCH_TOGGLE"] = "Search bags"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SHOW_BAG"] = "Show bag"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SHOW_BAG_FRAME"] = "Show bags list"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_BAG"] = "Open inventory"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_BANK"] = "Open bank"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_EQUIP"] = "Open equip"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_GLOBAL_SEARCH"] = "Global search"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_MAIL"] = "Open mailbox"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_OTHER_FRAME"] = "Open other bags"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_LEFTTIP"] = "Drag item to here to add watch"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_ONLY_IN_BAG"] = "Only count in backpack"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_RIGHTTIP"] = "Manage item watch"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_SHIFT"] = "<Press SHIFT to view single item>"--]] 
--[[Translation missing --]]
--[[ L["Top"] = "Top"--]] 
--[[Translation missing --]]
--[[ L["Total"] = "Total"--]] 
--[[Translation missing --]]
--[[ L["Trade Containers Location"] = "Trade Containers Location"--]] 
--[[Translation missing --]]
--[[ L["Trading Items"] = "Trading Items"--]] 
--[[Translation missing --]]
--[[ L["Visiting a Vendor"] = "Visiting a Vendor"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Auction House"] = "Visiting the Auction House"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Bank"] = "Visiting the Bank"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Mail Box"] = "Visiting the Mail Box"--]] 
--[[Translation missing --]]
--[[ L["Watch Frame"] = "Watch Frame"--]]
--@end-locale@]=]
end)

T('koKR', function(L)
-- @locale:language=koKR@
L = L or {}
L["|cffff2020(Offline)|r"] = "|cffff2020(접속종료)|r"
L["Always show"] = "항상 표시"
L["Appearance"] = "모양"
L["Are you sure you want to restore the current Settings?"] = "현재 설정을 복원 하시겠습니까?"
L["Auto Close"] = "자동 닫기"
L["Auto Display"] = "자동 표시"
L["Bag Frame"] = "가방 프레임"
L["Bag Style"] = "가방 스타일"
L["Bag Toggle"] = "가방 전환"
L["Bank"] = "은행"
L["Blizzard Panel"] = "블리자드 창 위치"
L["Bottom"] = "하단"
L["Character Specific Settings"] = "캐릭터 개별 설정"
L["Closing the Character Info"] = "캐릭터 정보 닫을 때"
L["Closing Trade Skills"] = "전문 기술 닫을 때"
L["COD"] = "대금청구물품"
L["Color Empty Slots by Bag Type"] = "가방 유형 별 빈 칸 색상"
L["Color Settings"] = "색상 설정"
L["Columns"] = "열"
L["Completed Trade"] = "거래 완료 시"
L["Container Colors"] = "소지품 색상"
L["Default"] = "기본"
L["DESC_COLORS"] = "색상 기본 설정입니다."
L["DESC_DISPLAY"] = "자동 표시 및 닫기입니다."
L["DESC_FRAMES"] = "가방 기본 설정입니다."
L["DESC_GENERAL"] = "일반 환경 설정입니다."
L["Empty Slot Brightness"] = "빈 칸 밝기"
L["Enchanting Color"] = "마법부여 색상"
--[[Translation missing --]]
--[[ L["Engineering Color"] = "Engineering Color"--]] 
L["Entering Combat"] = "전투 진입"
L["Equip"] = "장비"
L["Equipped"] = "착용"
L["Expired"] = "만료됨"
L["Features"] = "기능"
L["Frame Settings"] = "프레임 설정"
--[[Translation missing --]]
--[[ L["Gems Color"] = "Gems Color"--]] 
L["Global search"] = "전역 검색"
L["Global Settings"] = "전역 설정"
--[[Translation missing --]]
--[[ L["Guild bank"] = "Guild bank"--]] 
L["Herbalism Color"] = "약초 색상"
L["Highlight Border"] = "테두리 강조 "
L["Highlight Brightness"] = "밝게 강조"
L["Highlight Equipment Set Items"] = "세트 아이템 장비 강조"
L["Highlight Items by Quality"] = "품질 별 아이템 강조"
L["Highlight New Items"] = "새로운 아이템 강조"
L["Highlight Quest Items"] = "퀘스트 아이템 강조"
L["Highlight Unusable Items"] = "사용할 수 없는 아이템 강조"
L["HOTKEY_ALT_RIGHT"] = "알트-우클릭"
L["HOTKEY_CTRL_RIGHT"] = "컨트롤-우클릭"
L["Inventory"] = "가방"
L["Item Scale"] = "아이템 크기"
L["Keyring Color"] = "열쇠고리 색상"
--[[Translation missing --]]
--[[ L["Leatherworking Color"] = "Leatherworking Color"--]] 
L["Leaving a Vendor"] = "상점 떠날 때"
L["Leaving the Auction House"] = "경매장 떠날 때"
L["Leaving the Bank"] = "은행 떠날 때"
L["Leaving the Mail Box"] = "우편함 떠날 때"
L["Less than %s days"] = "%s일 미만"
L["Less than one day"] = "1일 미만"
L["Lock Frames"] = "프레임 고정"
L["Mail"] = "우편"
--[[Translation missing --]]
--[[ L["Mining Color"] = "Mining Color"--]] 
L["Move down"] = "아래로 이동"
L["Move up"] = "위로 이동"
L["Need to reload UI to make some settings take effect"] = "일부 설정을 적용하려면 UI를 다시 재시작(reload)해야합니다."
L["Never show"] = "표시 안함"
L["No record"] = "기록 없음"
L["Normal Color"] = "보통 색상"
L["Opening the Character Info"] = "캐릭터 정보 열 때"
L["Opening Trade Skills"] = "전문 기술 열 때"
L["Plugin Buttons"] = "플러그인 버튼"
L["Quiver Color"] = "화살통/탄환주머니 칸 색상"
L["Restore default Settings"] = "기본 설정 복원"
L["Reverse Bag Order"] = "가방 순서 반대로"
L["Reverse Slot Order"] = "칸 순서 반대로"
L["Show Character Portrait"] = "캐릭터 초상화 보기"
--[[Translation missing --]]
--[[ L["Show Guild Bank Count in Tooltip"] = "Show Guild Bank Count in Tooltip"--]] 
L["Show Item Count in Tooltip"] = "툴팁에 아이템 갯수 보기"
L["Show Junk Icon"] = "잡템 아이콘 보기"
L["Show Offline Text in Bag's Title"] = "다른 캐릭터 가방 제목에 접속종료 문자 보기"
L["Show Quest Starter Icon"] = "퀘스트 시작템 아이콘 보기"
L["Slot Colors"] = "칸 색상"
L["Soul Color"] = "영혼 칸 색상"
L["Time Remaining"] = "남은 시간"
L["TITLE_BAG"] = "%s의 소지품"
L["TITLE_BANK"] = "%s의 은행"
L["TITLE_COD"] = "%s의 대금 청구 물품"
L["TITLE_EQUIP"] = "%s의 장비"
L["TITLE_MAIL"] = "%s의 우편함"
L["TOOLTIP_CHANGE_PLAYER"] = "다른 캐릭터의 아이템을 봅니다."
L["TOOLTIP_HIDE_BAG"] = "가방 숨기기"
L["TOOLTIP_HIDE_BAG_FRAME"] = "가방 목록 숨기기"
L["TOOLTIP_PURCHASE_BANK_SLOT"] = "가방 보관함 구입"
L["TOOLTIP_RETURN_TO_SELF"] = "현재 캐릭터로 돌아가기"
L["TOOLTIP_SEARCH_RECORDS"] = "저장된 검색 조건 열기"
L["TOOLTIP_SEARCH_TOGGLE"] = "가방 검색"
L["TOOLTIP_SHOW_BAG"] = "가방 보기"
L["TOOLTIP_SHOW_BAG_FRAME"] = "가방 목록 보기"
L["TOOLTIP_TOGGLE_BAG"] = "소지품 열기"
L["TOOLTIP_TOGGLE_BANK"] = "은행 열기"
L["TOOLTIP_TOGGLE_EQUIP"] = "장비 열기"
L["TOOLTIP_TOGGLE_GLOBAL_SEARCH"] = "전역 검색"
L["TOOLTIP_TOGGLE_MAIL"] = "우편함 열기"
L["TOOLTIP_TOGGLE_OTHER_FRAME"] = "다른 가방 열기"
L["TOOLTIP_WATCHED_TOKENS_LEFTTIP"] = "집계를 추가하려면 아이템을 여기로 드래그"
L["TOOLTIP_WATCHED_TOKENS_ONLY_IN_BAG"] = "가방에 있는 것만 집계"
L["TOOLTIP_WATCHED_TOKENS_RIGHTTIP"] = "아이템 집계 관리"
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_SHIFT"] = "<Press SHIFT to view single item>"--]] 
L["Top"] = "상단"
L["Total"] = "총"
L["Trade Containers Location"] = "거래 물품 위치"
L["Trading Items"] = "아이템 거래 시"
L["Visiting a Vendor"] = "상점 방문 시"
L["Visiting the Auction House"] = "경매장 방문 시"
L["Visiting the Bank"] = "은행 방문 시"
L["Visiting the Mail Box"] = "우편함 방문 시"
L["Watch Frame"] = "집계 프레임"
--@end-locale@]=]
end)

T('ptBR', function(L)
-- @locale:language=ptBR@
L = L or {}
--[[Translation missing --]]
--[[ L["|cffff2020(Offline)|r"] = "|cffff2020(Offline)|r"--]] 
--[[Translation missing --]]
--[[ L["Always show"] = "Always show"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Are you sure you want to restore the current Settings?"] = "Are you sure you want to restore the current Settings?"--]] 
--[[Translation missing --]]
--[[ L["Auto Close"] = "Auto Close"--]] 
--[[Translation missing --]]
--[[ L["Auto Display"] = "Auto Display"--]] 
--[[Translation missing --]]
--[[ L["Bag Frame"] = "Bag Frame"--]] 
--[[Translation missing --]]
--[[ L["Bag Style"] = "Bag Style"--]] 
--[[Translation missing --]]
--[[ L["Bag Toggle"] = "Bag Toggle"--]] 
--[[Translation missing --]]
--[[ L["Bank"] = "Bank"--]] 
--[[Translation missing --]]
--[[ L["Blizzard Panel"] = "Blizzard Panel"--]] 
--[[Translation missing --]]
--[[ L["Bottom"] = "Bottom"--]] 
--[[Translation missing --]]
--[[ L["Character Specific Settings"] = "Character Specific Settings"--]] 
--[[Translation missing --]]
--[[ L["Closing the Character Info"] = "Closing the Character Info"--]] 
--[[Translation missing --]]
--[[ L["Closing Trade Skills"] = "Closing Trade Skills"--]] 
--[[Translation missing --]]
--[[ L["COD"] = "COD"--]] 
--[[Translation missing --]]
--[[ L["Color Empty Slots by Bag Type"] = "Color Empty Slots by Bag Type"--]] 
--[[Translation missing --]]
--[[ L["Color Settings"] = "Color Settings"--]] 
--[[Translation missing --]]
--[[ L["Columns"] = "Columns"--]] 
--[[Translation missing --]]
--[[ L["Completed Trade"] = "Completed Trade"--]] 
--[[Translation missing --]]
--[[ L["Container Colors"] = "Container Colors"--]] 
--[[Translation missing --]]
--[[ L["Default"] = "Default"--]] 
--[[Translation missing --]]
--[[ L["DESC_COLORS"] = "Color preference Settings."--]] 
--[[Translation missing --]]
--[[ L["DESC_DISPLAY"] = "Auto Display and Close."--]] 
--[[Translation missing --]]
--[[ L["DESC_FRAMES"] = "%s preference Settings."--]] 
--[[Translation missing --]]
--[[ L["DESC_GENERAL"] = "General preference Settings."--]] 
--[[Translation missing --]]
--[[ L["Empty Slot Brightness"] = "Empty Slot Brightness"--]] 
--[[Translation missing --]]
--[[ L["Enchanting Color"] = "Enchanting Color"--]] 
--[[Translation missing --]]
--[[ L["Engineering Color"] = "Engineering Color"--]] 
--[[Translation missing --]]
--[[ L["Entering Combat"] = "Entering Combat"--]] 
--[[Translation missing --]]
--[[ L["Equip"] = "Equip"--]] 
--[[Translation missing --]]
--[[ L["Equipped"] = "Equipped"--]] 
--[[Translation missing --]]
--[[ L["Expired"] = "Expired"--]] 
--[[Translation missing --]]
--[[ L["Features"] = "Features"--]] 
--[[Translation missing --]]
--[[ L["Frame Settings"] = "Frame Settings"--]] 
--[[Translation missing --]]
--[[ L["Gems Color"] = "Gems Color"--]] 
--[[Translation missing --]]
--[[ L["Global search"] = "Global search"--]] 
--[[Translation missing --]]
--[[ L["Global Settings"] = "Global Settings"--]] 
--[[Translation missing --]]
--[[ L["Guild bank"] = "Guild bank"--]] 
--[[Translation missing --]]
--[[ L["Herbalism Color"] = "Herbalism Color"--]] 
--[[Translation missing --]]
--[[ L["Highlight Border"] = "Highlight Border"--]] 
--[[Translation missing --]]
--[[ L["Highlight Brightness"] = "Highlight Brightness"--]] 
--[[Translation missing --]]
--[[ L["Highlight Equipment Set Items"] = "Highlight Equipment Set Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Items by Quality"] = "Highlight Items by Quality"--]] 
--[[Translation missing --]]
--[[ L["Highlight New Items"] = "Highlight New Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Quest Items"] = "Highlight Quest Items"--]] 
--[[Translation missing --]]
--[[ L["Highlight Unusable Items"] = "Highlight Unusable Items"--]] 
--[[Translation missing --]]
--[[ L["HOTKEY_ALT_RIGHT"] = "Alt-RightClick"--]] 
--[[Translation missing --]]
--[[ L["HOTKEY_CTRL_RIGHT"] = "Ctrl-RightClick"--]] 
--[[Translation missing --]]
--[[ L["Inventory"] = "Inventory"--]] 
--[[Translation missing --]]
--[[ L["Item Scale"] = "Item Scale"--]] 
--[[Translation missing --]]
--[[ L["Keyring Color"] = "Keyring Color"--]] 
--[[Translation missing --]]
--[[ L["Leatherworking Color"] = "Leatherworking Color"--]] 
--[[Translation missing --]]
--[[ L["Leaving a Vendor"] = "Leaving a Vendor"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Auction House"] = "Leaving the Auction House"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Bank"] = "Leaving the Bank"--]] 
--[[Translation missing --]]
--[[ L["Leaving the Mail Box"] = "Leaving the Mail Box"--]] 
--[[Translation missing --]]
--[[ L["Less than %s days"] = "Less than %s days"--]] 
--[[Translation missing --]]
--[[ L["Less than one day"] = "Less than one day"--]] 
--[[Translation missing --]]
--[[ L["Lock Frames"] = "Lock Frames"--]] 
--[[Translation missing --]]
--[[ L["Mail"] = "Mail"--]] 
--[[Translation missing --]]
--[[ L["Mining Color"] = "Mining Color"--]] 
--[[Translation missing --]]
--[[ L["Move down"] = "Move down"--]] 
--[[Translation missing --]]
--[[ L["Move up"] = "Move up"--]] 
--[[Translation missing --]]
--[[ L["Need to reload UI to make some settings take effect"] = "Need to reload UI to make some settings take effect"--]] 
--[[Translation missing --]]
--[[ L["Never show"] = "Never show"--]] 
--[[Translation missing --]]
--[[ L["No record"] = "No record"--]] 
--[[Translation missing --]]
--[[ L["Normal Color"] = "Normal Color"--]] 
--[[Translation missing --]]
--[[ L["Opening the Character Info"] = "Opening the Character Info"--]] 
--[[Translation missing --]]
--[[ L["Opening Trade Skills"] = "Opening Trade Skills"--]] 
--[[Translation missing --]]
--[[ L["Plugin Buttons"] = "Plugin Buttons"--]] 
--[[Translation missing --]]
--[[ L["Quiver Color"] = "Quiver Color"--]] 
--[[Translation missing --]]
--[[ L["Restore default Settings"] = "Restore default Settings"--]] 
--[[Translation missing --]]
--[[ L["Reverse Bag Order"] = "Reverse Bag Order"--]] 
--[[Translation missing --]]
--[[ L["Reverse Slot Order"] = "Reverse Slot Order"--]] 
--[[Translation missing --]]
--[[ L["Show Character Portrait"] = "Show Character Portrait"--]] 
--[[Translation missing --]]
--[[ L["Show Guild Bank Count in Tooltip"] = "Show Guild Bank Count in Tooltip"--]] 
--[[Translation missing --]]
--[[ L["Show Item Count in Tooltip"] = "Show Item Count in Tooltip"--]] 
--[[Translation missing --]]
--[[ L["Show Junk Icon"] = "Show Junk Icon"--]] 
--[[Translation missing --]]
--[[ L["Show Offline Text in Bag's Title"] = "Show Offline Text in Bag's Title"--]] 
--[[Translation missing --]]
--[[ L["Show Quest Starter Icon"] = "Show Quest Starter Icon"--]] 
--[[Translation missing --]]
--[[ L["Slot Colors"] = "Slot Colors"--]] 
--[[Translation missing --]]
--[[ L["Soul Color"] = "Soul Color"--]] 
--[[Translation missing --]]
--[[ L["Time Remaining"] = "Time Remaining"--]] 
--[[Translation missing --]]
--[[ L["TITLE_BAG"] = "%s's Inventory"--]] 
--[[Translation missing --]]
--[[ L["TITLE_BANK"] = "%s's Bank"--]] 
--[[Translation missing --]]
--[[ L["TITLE_COD"] = "%s's COD"--]] 
--[[Translation missing --]]
--[[ L["TITLE_EQUIP"] = "%s's Equip"--]] 
--[[Translation missing --]]
--[[ L["TITLE_MAIL"] = "%s's Mail"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_CHANGE_PLAYER"] = "View another character's items."--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_HIDE_BAG"] = "Hide bag"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_HIDE_BAG_FRAME"] = "Hide bags list"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_PURCHASE_BANK_SLOT"] = "Purchase bank slot"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_RETURN_TO_SELF"] = "Return to the current character."--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SEARCH_RECORDS"] = "Open saved search conditions"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SEARCH_TOGGLE"] = "Search bags"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SHOW_BAG"] = "Show bag"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SHOW_BAG_FRAME"] = "Show bags list"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_BAG"] = "Open inventory"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_BANK"] = "Open bank"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_EQUIP"] = "Open equip"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_GLOBAL_SEARCH"] = "Global search"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_MAIL"] = "Open mailbox"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_OTHER_FRAME"] = "Open other bags"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_LEFTTIP"] = "Drag item to here to add watch"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_ONLY_IN_BAG"] = "Only count in backpack"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_RIGHTTIP"] = "Manage item watch"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_SHIFT"] = "<Press SHIFT to view single item>"--]] 
--[[Translation missing --]]
--[[ L["Top"] = "Top"--]] 
--[[Translation missing --]]
--[[ L["Total"] = "Total"--]] 
--[[Translation missing --]]
--[[ L["Trade Containers Location"] = "Trade Containers Location"--]] 
--[[Translation missing --]]
--[[ L["Trading Items"] = "Trading Items"--]] 
--[[Translation missing --]]
--[[ L["Visiting a Vendor"] = "Visiting a Vendor"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Auction House"] = "Visiting the Auction House"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Bank"] = "Visiting the Bank"--]] 
--[[Translation missing --]]
--[[ L["Visiting the Mail Box"] = "Visiting the Mail Box"--]] 
--[[Translation missing --]]
--[[ L["Watch Frame"] = "Watch Frame"--]]
--@end-locale@]=]
end)

T('ruRU', function(L)
-- @locale:language=ruRU@
L = L or {}
L["|cffff2020(Offline)|r"] = "|cffff2020(Не в сети)|r"
--[[Translation missing --]]
--[[ L["Always show"] = "Always show"--]] 
L["Appearance"] = "Внешний вид"
--[[Translation missing --]]
--[[ L["Are you sure you want to restore the current Settings?"] = "Are you sure you want to restore the current Settings?"--]] 
L["Auto Close"] = "Автоматическое закрытие"
L["Auto Display"] = "Автоматический дисплей"
--[[Translation missing --]]
--[[ L["Bag Frame"] = "Bag Frame"--]] 
--[[Translation missing --]]
--[[ L["Bag Style"] = "Bag Style"--]] 
L["Bag Toggle"] = "Переключатель сумки"
L["Bank"] = "Банк"
L["Blizzard Panel"] = "Blizzard панель"
L["Bottom"] = "Дно"
--[[Translation missing --]]
--[[ L["Character Specific Settings"] = "Character Specific Settings"--]] 
L["Closing the Character Info"] = "Закрытие информации о персонаже"
L["Closing Trade Skills"] = "Закрытие торговых навыков"
--[[Translation missing --]]
--[[ L["COD"] = "COD"--]] 
L["Color Empty Slots by Bag Type"] = "Цвет пустых слотов по типу мешка"
L["Color Settings"] = "Параметры цветов"
L["Columns"] = "Столбцы"
L["Completed Trade"] = "Выполненная торговля"
L["Container Colors"] = "Цвета контейнера"
L["Default"] = "По умолчанию"
L["DESC_COLORS"] = "Настройки предпочтений цвета"
L["DESC_DISPLAY"] = "Автоматическое отображение и закрытие"
L["DESC_FRAMES"] = "Настройки предпочтений сумки"
L["DESC_GENERAL"] = "Общие настройки предпочтений"
L["Empty Slot Brightness"] = "Яркость пустого слота"
L["Enchanting Color"] = "Цвет чар"
--[[Translation missing --]]
--[[ L["Engineering Color"] = "Engineering Color"--]] 
L["Entering Combat"] = "Вход в бой"
--[[Translation missing --]]
--[[ L["Equip"] = "Equip"--]] 
L["Equipped"] = "Оборудованный"
--[[Translation missing --]]
--[[ L["Expired"] = "Expired"--]] 
--[[Translation missing --]]
--[[ L["Features"] = "Features"--]] 
L["Frame Settings"] = "Параметры рамки"
--[[Translation missing --]]
--[[ L["Gems Color"] = "Gems Color"--]] 
--[[Translation missing --]]
--[[ L["Global search"] = "Global search"--]] 
--[[Translation missing --]]
--[[ L["Global Settings"] = "Global Settings"--]] 
--[[Translation missing --]]
--[[ L["Guild bank"] = "Guild bank"--]] 
L["Herbalism Color"] = "Цвет травничества"
L["Highlight Border"] = "Выделение граници"
L["Highlight Brightness"] = "Яркость подсветки"
L["Highlight Equipment Set Items"] = "Выделение предметов набора"
L["Highlight Items by Quality"] = "Выделить предметы по качеству"
L["Highlight New Items"] = "Выделить новые предметы"
L["Highlight Quest Items"] = "Выделить квестовые предметы"
L["Highlight Unusable Items"] = "Выделить неиспользуемые элементы"
--[[Translation missing --]]
--[[ L["HOTKEY_ALT_RIGHT"] = "Alt-RightClick"--]] 
--[[Translation missing --]]
--[[ L["HOTKEY_CTRL_RIGHT"] = "Ctrl-RightClick"--]] 
L["Inventory"] = "Инвентарь"
L["Item Scale"] = "Шкала предметов"
--[[Translation missing --]]
--[[ L["Keyring Color"] = "Keyring Color"--]] 
--[[Translation missing --]]
--[[ L["Leatherworking Color"] = "Leatherworking Color"--]] 
L["Leaving a Vendor"] = "Оставленно у торговца"
L["Leaving the Auction House"] = "Оставленно на аукционе"
L["Leaving the Bank"] = "Оставленно в банке"
L["Leaving the Mail Box"] = "Оставленно на почте"
--[[Translation missing --]]
--[[ L["Less than %s days"] = "Less than %s days"--]] 
--[[Translation missing --]]
--[[ L["Less than one day"] = "Less than one day"--]] 
L["Lock Frames"] = "Закрепить рамку"
--[[Translation missing --]]
--[[ L["Mail"] = "Mail"--]] 
--[[Translation missing --]]
--[[ L["Mining Color"] = "Mining Color"--]] 
--[[Translation missing --]]
--[[ L["Move down"] = "Move down"--]] 
--[[Translation missing --]]
--[[ L["Move up"] = "Move up"--]] 
--[[Translation missing --]]
--[[ L["Need to reload UI to make some settings take effect"] = "Need to reload UI to make some settings take effect"--]] 
--[[Translation missing --]]
--[[ L["Never show"] = "Never show"--]] 
--[[Translation missing --]]
--[[ L["No record"] = "No record"--]] 
L["Normal Color"] = "Нормальный цвет"
L["Opening the Character Info"] = "Открытие информации о персонаже"
L["Opening Trade Skills"] = "Открытие торговых навыков"
L["Plugin Buttons"] = "Кнопки плагина"
L["Quiver Color"] = "Цвет колчана"
--[[Translation missing --]]
--[[ L["Restore default Settings"] = "Restore default Settings"--]] 
L["Reverse Bag Order"] = "Обратный порядок сумки"
L["Reverse Slot Order"] = "Обратный порядок слота"
--[[Translation missing --]]
--[[ L["Show Character Portrait"] = "Show Character Portrait"--]] 
--[[Translation missing --]]
--[[ L["Show Guild Bank Count in Tooltip"] = "Show Guild Bank Count in Tooltip"--]] 
L["Show Item Count in Tooltip"] = "Показать количество элементов в подсказке"
L["Show Junk Icon"] = "Показать значок над хламом"
L["Show Offline Text in Bag's Title"] = "Показать автономный текст в заголовке сумки"
L["Show Quest Starter Icon"] = "Скрыть иконку квестового предмета"
L["Slot Colors"] = "Цвета слотов"
L["Soul Color"] = "Цвет души"
--[[Translation missing --]]
--[[ L["Time Remaining"] = "Time Remaining"--]] 
L["TITLE_BAG"] = "%s's инвентарь"
L["TITLE_BANK"] = "%s's банк"
--[[Translation missing --]]
--[[ L["TITLE_COD"] = "%s's COD"--]] 
--[[Translation missing --]]
--[[ L["TITLE_EQUIP"] = "%s's Equip"--]] 
--[[Translation missing --]]
--[[ L["TITLE_MAIL"] = "%s's Mail"--]] 
L["TOOLTIP_CHANGE_PLAYER"] = "Просмотр предметов другого персонажа"
--[[Translation missing --]]
--[[ L["TOOLTIP_HIDE_BAG"] = "Hide bag"--]] 
L["TOOLTIP_HIDE_BAG_FRAME"] = "Скрыть список сумок"
L["TOOLTIP_PURCHASE_BANK_SLOT"] = "Покупка слота в банке"
L["TOOLTIP_RETURN_TO_SELF"] = "Возврат к предыдущей характеристике"
--[[Translation missing --]]
--[[ L["TOOLTIP_SEARCH_RECORDS"] = "Open saved search conditions"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SEARCH_TOGGLE"] = "Search bags"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_SHOW_BAG"] = "Show bag"--]] 
L["TOOLTIP_SHOW_BAG_FRAME"] = "Скрыть список сумок"
L["TOOLTIP_TOGGLE_BAG"] = "Открыть инвентарь"
L["TOOLTIP_TOGGLE_BANK"] = "Открыть банк"
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_EQUIP"] = "Open equip"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_GLOBAL_SEARCH"] = "Global search"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_MAIL"] = "Open mailbox"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_TOGGLE_OTHER_FRAME"] = "Open other bags"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_LEFTTIP"] = "Drag item to here to add watch"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_ONLY_IN_BAG"] = "Only count in backpack"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_RIGHTTIP"] = "Manage item watch"--]] 
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_SHIFT"] = "<Press SHIFT to view single item>"--]] 
L["Top"] = "Верх"
L["Total"] = "Весь"
L["Trade Containers Location"] = "Расположение торговых контейнеров"
L["Trading Items"] = "Торговые пункты"
L["Visiting a Vendor"] = "Посещение торговца"
L["Visiting the Auction House"] = "Посещение аукциона"
L["Visiting the Bank"] = "Посещение банка"
L["Visiting the Mail Box"] = "Посещение почтового ящика"
--[[Translation missing --]]
--[[ L["Watch Frame"] = "Watch Frame"--]]
--@end-locale@]=]
end)

T('zhTW', function(L)
-- @locale:language=zhTW@
L = L or {}
L["|cffff2020(Offline)|r"] = "|cffff2020(離線)|r"
L["Always show"] = "始終顯示"
L["Appearance"] = "外觀"
L["Are you sure you want to restore the current Settings?"] = "你確定要恢覆到默認設置嗎"
L["Auto Close"] = "自動關閉"
L["Auto Display"] = "自動顯示"
L["Bag Frame"] = "背包列表"
L["Bag Style"] = "背包風格"
L["Bag Toggle"] = "背包按鈕"
L["Bank"] = "銀行"
L["Blizzard Panel"] = "暴雪標準面板"
L["Bottom"] = "底部"
L["Character Specific Settings"] = "角色獨立設置"
L["Closing the Character Info"] = "關閉角色面板時"
L["Closing Trade Skills"] = "關閉專業技能時"
L["COD"] = "付款取信"
L["Color Empty Slots by Bag Type"] = "根據容器類型對空格著色"
L["Color Settings"] = "顏色設置"
L["Columns"] = "列數"
L["Completed Trade"] = "完成交易時"
L["Container Colors"] = "容器顏色"
L["Default"] = "默認"
L["DESC_COLORS"] = "顏色偏好設置"
L["DESC_DISPLAY"] = "自動顯示和關閉"
L["DESC_FRAMES"] = "%s偏好設置"
L["DESC_GENERAL"] = "通用偏好設置"
L["Empty Slot Brightness"] = "空格亮度"
L["Enchanting Color"] = "附魔材料袋顏色"
--[[Translation missing --]]
--[[ L["Engineering Color"] = "Engineering Color"--]] 
L["Entering Combat"] = "進入戰鬥時"
L["Equip"] = "裝備"
L["Equipped"] = "裝備時"
L["Expired"] = "過期"
L["Features"] = "功能"
L["Frame Settings"] = "背包設置"
--[[Translation missing --]]
--[[ L["Gems Color"] = "Gems Color"--]] 
L["Global search"] = "全局搜索"
L["Global Settings"] = "全局設置"
--[[Translation missing --]]
--[[ L["Guild bank"] = "Guild bank"--]] 
L["Herbalism Color"] = "草藥袋顏色"
L["Highlight Border"] = "邊框著色"
L["Highlight Brightness"] = "邊框著色亮度"
L["Highlight Equipment Set Items"] = "對套裝物品著色"
L["Highlight Items by Quality"] = "根據物品品質著色"
L["Highlight New Items"] = "對新物品著色"
L["Highlight Quest Items"] = "對任務物品著色"
L["Highlight Unusable Items"] = "對不可用物品著色"
L["HOTKEY_ALT_RIGHT"] = "Alt-右鍵"
L["HOTKEY_CTRL_RIGHT"] = "Ctrl-右鍵"
L["Inventory"] = "背包"
L["Item Scale"] = "物品縮放"
L["Keyring Color"] = "鑰匙鏈顏色"
--[[Translation missing --]]
--[[ L["Leatherworking Color"] = "Leatherworking Color"--]] 
L["Leaving a Vendor"] = "關閉商人時"
L["Leaving the Auction House"] = "關閉拍賣行時"
L["Leaving the Bank"] = "關閉銀行時"
L["Leaving the Mail Box"] = "關閉郵箱時"
L["Less than %s days"] = "低於%s天"
L["Less than one day"] = "低於1天"
L["Lock Frames"] = "鎖定位置"
L["Mail"] = "郵箱"
--[[Translation missing --]]
--[[ L["Mining Color"] = "Mining Color"--]] 
L["Move down"] = "下移"
L["Move up"] = "上移"
L["Need to reload UI to make some settings take effect"] = "需要重新載入UI後，使部分設置生效"
L["Never show"] = "從不顯示"
L["No record"] = "沒有記錄"
L["Normal Color"] = "普通容器顏色"
L["Opening the Character Info"] = "打開角色面板時"
L["Opening Trade Skills"] = "打開專業技能時"
L["Plugin Buttons"] = "擴展按鈕"
L["Quiver Color"] = "箭袋顏色"
L["Restore default Settings"] = "恢復默認設置"
L["Reverse Bag Order"] = "反向背包排列"
L["Reverse Slot Order"] = "反向物品排列"
L["Show Character Portrait"] = "顯示角色頭像"
--[[Translation missing --]]
--[[ L["Show Guild Bank Count in Tooltip"] = "Show Guild Bank Count in Tooltip"--]] 
L["Show Item Count in Tooltip"] = "鼠標提示物品統計"
L["Show Junk Icon"] = "顯示垃圾圖標"
L["Show Offline Text in Bag's Title"] = "在背包標題上顯示離線"
L["Show Quest Starter Icon"] = "顯示任務給予物圖標"
L["Slot Colors"] = "槽位顏色"
L["Soul Color"] = "靈魂袋顏色"
L["Time Remaining"] = "剩餘時間"
L["TITLE_BAG"] = "%s的背包"
L["TITLE_BANK"] = "%s的銀行"
L["TITLE_COD"] = "%s的付款取信"
L["TITLE_EQUIP"] = "%s的裝備"
L["TITLE_MAIL"] = "%s的郵箱"
L["TOOLTIP_CHANGE_PLAYER"] = "查看其他角色的物品"
L["TOOLTIP_HIDE_BAG"] = "隱藏背包"
L["TOOLTIP_HIDE_BAG_FRAME"] = "隱藏背包列表"
L["TOOLTIP_PURCHASE_BANK_SLOT"] = "購買銀行空位"
L["TOOLTIP_RETURN_TO_SELF"] = "返回到當前角色"
L["TOOLTIP_SEARCH_RECORDS"] = "打開/保存搜索條件"
L["TOOLTIP_SEARCH_TOGGLE"] = "搜索背包"
L["TOOLTIP_SHOW_BAG"] = "顯示背包"
L["TOOLTIP_SHOW_BAG_FRAME"] = "顯示背包列表"
L["TOOLTIP_TOGGLE_BAG"] = "打開背包"
L["TOOLTIP_TOGGLE_BANK"] = "打開銀行"
L["TOOLTIP_TOGGLE_EQUIP"] = "打開裝備欄"
L["TOOLTIP_TOGGLE_GLOBAL_SEARCH"] = "打開全局搜索"
L["TOOLTIP_TOGGLE_MAIL"] = "打開郵箱"
L["TOOLTIP_TOGGLE_OTHER_FRAME"] = "打開其它背包"
L["TOOLTIP_WATCHED_TOKENS_LEFTTIP"] = "拖動物品到這裡以添加監控"
L["TOOLTIP_WATCHED_TOKENS_ONLY_IN_BAG"] = "僅統計背包內數量"
L["TOOLTIP_WATCHED_TOKENS_RIGHTTIP"] = "管理物品監控"
--[[Translation missing --]]
--[[ L["TOOLTIP_WATCHED_TOKENS_SHIFT"] = "<Press SHIFT to view single item>"--]] 
L["Top"] = "頂部"
L["Total"] = "總共"
L["Trade Containers Location"] = "特殊容器位置"
L["Trading Items"] = "交易時"
L["Visiting a Vendor"] = "打開商人時"
L["Visiting the Auction House"] = "打開拍賣行時"
L["Visiting the Bank"] = "打開銀行時"
L["Visiting the Mail Box"] = "打開郵箱時"
L["Watch Frame"] = "物品監控"
--@end-locale@]=]
end)

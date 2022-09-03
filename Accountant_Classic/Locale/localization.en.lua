-- $Id: localization.en.lua 293 2018-03-15 13:44:58Z arith $ 

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("Accountant_Classic", "enUS", true, true);

if not L then return end
-- Header
L["Accountant Classic"] = "Accountant Classic"
L["A basic tool to track your monetary incomings and outgoings within WoW."] = "A basic tool to track your monetary incomings and outgoings within WoW."
L[ [=[Left-Click to open Accountant Classic.
Right-Click for Accountant Classic options.
Left-click and drag to move this button.]=] ] = [=[Left-Click to open Accountant Classic.
Right-Click for Accountant Classic options.
Left-click and drag to move this button.]=]
L[ [=[Left-click and drag to move this button.
Right-Click to open Accountant Classic.]=] ] = [=[Left-click and drag to move this button.
Right-Click to open Accountant Classic.]=]
L["Total Incomings"] = "Total Incomings"
L["Total Outgoings"] = "Total Outgoings"
L["Net Profit / Loss"] = "Net Profit / Loss"
L["Net Loss"] = "Net Loss"
L["Net Profit"] = "Net Profit"
L["Source"] = "Source"
L["Incomings"] = "Incomings"
L["Outgoings"] = "Outgoings"
L["Week Start"] = "Week Start"
L["Sum Total"] = "Sum Total"
L["Character"] = "Character"
L["Money"] = "Money"
L["Updated"] = "Updated"

-- Section Labels
L["Quest Rewards"] = "Quest Rewards"
L["Merchants"] = "Merchants"
L["Trade Window"] = "Trade Window"
L["Mail"] = "Mail"
L["Training Costs"] = "Training Costs"
L["Taxi Fares"] = "Taxi Fares"
L["Unknown"] = "Unknown"
L["Repair Costs"] = "Repair Costs"
L["LFD, LFR and Scen."] = "LFD, LFR and Scen."

-- Buttons
L["Reset"] = "Reset"
L["Options"] = "Options"
L["Exit"] = "Exit"

-- Tabs
L["This Session"] = "This Session"
L["Today"] = "Today"
L["Prv. Day"] = "Prv. Day"
L["This Week"] = "This Week"
L["Prv. Week"] = "Prv. Week"
L["This Month"] = "This Month"
L["Prv. Month"] = "Prv. Month"
L["This Year"] = "This Year"
L["Prv. Year"] = "Prv. Year"
L["Total"] = "Total"
L["All Chars"] = "All Chars"

-- Options
L["Accountant Classic Options"] = "Accountant Classic Options"
L["Show minimap button"] = "Show minimap button"
L["Show money"] = "Show money"
L["Show money on minimap button's tooltip"] = "Show money on minimap button's tooltip"
L["Show session info"] = "Show session info"
L["Show session info on minimap button's tooltip"] = "Show session info on minimap button's tooltip"
L["Show money on screen"] = "Show money on screen"
L["Reset position"] = "Reset position"
L["Reset money frame's position"] = "Reset money frame's position"
L["Minimap Button Settings"] = "Minimap Button Settings"
L["Minimap Button Position"] = "Minimap Button Position"
L["Start of Week"] = "Start of Week"
L["Done"] = "Done"
L["Display Instruction Tips"] = "Display Instruction Tips"
L["Toggle whether to display minimap button or floating money frame's operation tips."] = "Toggle whether to display minimap button or floating money frame's operation tips."
L["Select the character to be removed:"] = "Select the character to be removed:"
L["The selected character's Accountant Classic data will be removed."] = "The selected character's Accountant Classic data will be removed."
L["The selected character is about to be removed.\nAre you sure you want to remove the following character from Accountant Classic?"] = "The selected character is about to be removed.\nAre you sure you want to remove the following character from Accountant Classic?"
L["|cffffffff\"%s - %s|cffffffff\" character's Accountant Classic data has been removed."] = "|cffffffff\"%s - %s|cffffffff\" character's Accountant Classic data has been removed." -- "servername - charactername" character's Accountant Classic data has been removed.
L["Select the date format:"] = "Select the date format:"
L["Date format showing in \"All Chars\" and \"Week\" tabs"] = "Date format showing in \"All Chars\" and \"Week\" tabs"
L["Show net income / expanse on LDB"] = "Show net income / expanse on LDB"
L["Show current session's net income / expanse instead of total money on LDB"] = "Show current session's net income / expanse instead of total money on LDB"
L["Show all realms' characters info"] = "Show all realms' characters info"
L["Enable to show all characters' money info from all realms. Disable to only show current realm's character info."] = "Enable to show all characters' money info from all realms. Disable to only show current realm's character info."
L["Track location of incoming / outgoing money"] = "Track location of incoming / outgoing money"
L["Enable to track the location of each incoming / outgoing money and also show the breakdown info while mouse hover each of the expenditure."] = "Enable to track the location of each incoming / outgoing money and also show the breakdown info while mouse hover each of the expenditure."
L["Also track subzone info"] = "Also track subzone info"
L["Enable to also track on the subzone info. For example: Suramar - Sanctum of Order"] = "Enable to also track on the subzone info. For example: Suramar - Sanctum of Order"
L["Converts a number into a localized string, grouping digits as required."] = "Converts a number into a localized string, grouping digits as required."
L["Accountant Classic Frame's Scale"] = "Accountant Classic Frame's Scale"
L["Accountant Classic Frame's Transparency"] = "Accountant Classic Frame's Transparency"
L["Accountant Classic Floating Info's Scale"] = "Accountant Classic Floating Info's Scale"
L["Accountant Classic Floating Info's Transparency"] = "Accountant Classic Floating Info's Transparency"
L["LDB Display Settings"] = "LDB Display Settings"
L["LDB Display Type"] = "LDB Display Type"
L["Data type to be displayed on LDB"] = "Data type to be displayed on LDB"
L["General and Data Display Format Settings"] = "General and Data Display Format Settings"
L["Main Frame's Scale and Alpha Settings"] = "Main Frame's Scale and Alpha Settings"
L["Onscreen Actionbar's Scale and Alpha Settings"] = "Onscreen Actionbar's Scale and Alpha Settings"
L["Character Data's Removal"] = "Character Data's Removal"
L["Profile Options"] = "Profile Options"
L["Scale and Transparency"] = "Scale and Transparency"
L["Remember character selected"] = "Remember character selected"
L["Remember the latest character selection in dropdown menu."] = "Remember the latest character selection in dropdown menu."
L["Show all factions' characters info"] = "Show all factions' characters info"
L["Enable to show all characters' money info from all factions. Disable to only show all characters' info from current faction."] = "Enable to show all characters' money info from all factions. Disable to only show all characters' info from current faction."
L["Enhanced Tracking Options"] = "Enhanced Tracking Options"
L["All Factions"] = "All Factions"
L["All Servers"] = "All Servers"

-- Misc
L["Are you sure you want to reset the \"%s\" data?"] = "Are you sure you want to reset the \"%s\" data?" -- %s would be the log mode, for example, Session, Day, Week, etc.
L["New Accountant Classic profile created for %s"] = "New Accountant Classic profile created for %s" -- %s would be the character name
L["Loaded Accountant Classic Profile for %s"] = "Loaded Accountant Classic Profile for %s" -- %s would be the character name
L["Accountant Classic loaded."] = "Accountant Classic loaded."
L["g "] = "g "
L["s "] = "s "
L["c"] = "c"
L["About"] = "About"
L["Detected the conflicted addon - \"|cFFFF0000Accountant|r\" exists and loaded.\nIt has been disabled, click Okay button to reload the game."] = "Detected the conflicted addon - \"|cFFFF0000Accountant|r\" exists and loaded.\nIt has been disabled, click Okay button to reload the game."
L["You have manually called the function \n|cFF00FF00AccountantClassic_CleanUpAccountantDB()|r \nto clean up conflicted data existed in \"Accountant\". \nNow click Okay button to reload the game."] = "You have manually called the function \n|cFF00FF00AccountantClassic_CleanUpAccountantDB()|r \nto clean up conflicted data existed in \"Accountant\". \nNow click Okay button to reload the game."
L["Show All Characters"] = "Show All Characters"
L["Show all characters' incoming and outgoing data."] = "Show all characters' incoming and outgoing data."

-- Amount string for CHAT_MESSAGE_MONEY search
L["(%d+) Gold"] = "(%d+) Gold"
L["(%d+) Silver"] = "(%d+) Silver"
L["(%d+) Copper"] = "(%d+) Copper"

-- Key Bindings headers
L["BINDING_HEADER_ACCOUNTANT_CLASSIC_TITLE"] = "Accountant Classic Bindings"
L["BINDING_NAME_ACCOUNTANT_CLASSIC_TOGGLE"] = "Toggle Accountant Classic"


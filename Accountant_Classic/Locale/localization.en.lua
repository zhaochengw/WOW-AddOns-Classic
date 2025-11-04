-- $Id: localization.en.lua 396 2022-11-04 15:23:19Z arithmandar $ 

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

-- Tabs' name
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
-- Tabs' tooltip
L["TT1"] = "This Session"
L["TT2"] = "Today"
L["TT3"] = "Yesterday"
L["TT4"] = "This Week"
L["TT5"] = "Last Week"
L["TT6"] = "This Month"
L["TT7"] = "Last Month"
L["TT8"] = "This Year"
L["TT9"] = "Last Year"
L["TT10"] = "Total"
L["TT11"] = "All Characters"

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

-- Currency Tracker - Source labels (Enum.CurrencySource)
-- These are human-friendly display strings for source tokens used by the Currency Tracker.
L["ConvertOldItem"] = "Convert Old Item"
L["ConvertOldPvPCurrency"] = "Convert Old PvP Currency"
L["ItemRefund"] = "Item Refund"
L["QuestReward"] = "Quest Reward"
L["Cheat"] = "Cheat"
L["Vendor"] = "Vendor"
L["PvPKillCredit"] = "PvP Kill Credit"
L["PvPMetaCredit"] = "PvP Meta Credit"
L["PvPScriptedAward"] = "PvP Scripted Award"
L["Loot"] = "Loot"
L["UpdatingVersion"] = "Updating Version"
L["LFGReward"] = "LFG Reward"
L["Trade"] = "Trade"
L["Spell"] = "Spell"
L["ItemDeletion"] = "Item Deletion"
L["RatedBattleground"] = "Rated Battleground"
L["RandomBattleground"] = "Random Battleground"
L["Arena"] = "Arena"
L["ExceededMaxQty"] = "Exceeded Max Quantity"
L["PvPCompletionBonus"] = "PvP Completion Bonus"
L["Script"] = "Script"
L["GuildBankWithdrawal"] = "Guild Bank Withdrawal"
L["Pushloot"] = "Push Loot"
L["GarrisonBuilding"] = "Garrison Building"
L["PvPDrop"] = "PvP Drop"
L["GarrisonFollowerActivation"] = "Garrison Follower Activation"
L["GarrisonBuildingRefund"] = "Garrison Building Refund"
L["GarrisonMissionReward"] = "Garrison Mission Reward"
L["GarrisonResourceOverTime"] = "Garrison Resource Over Time"
L["QuestRewardIgnoreCapsDeprecated"] = "Quest Reward (Ignore Caps, Deprecated)"
L["GarrisonTalent"] = "Garrison Talent"
L["GarrisonWorldQuestBonus"] = "Garrison World Quest Bonus"
L["PvPHonorReward"] = "PvP Honor Reward"
L["BonusRoll"] = "Bonus Roll"
L["AzeriteRespec"] = "Azerite Respec"
L["WorldQuestReward"] = "World Quest Reward"
L["WorldQuestRewardIgnoreCapsDeprecated"] = "World Quest Reward (Ignore Caps, Deprecated)"
L["FactionConversion"] = "Faction Conversion"
L["DailyQuestReward"] = "Daily Quest Reward"
L["DailyQuestWarModeReward"] = "Daily Quest War Mode Reward"
L["WeeklyQuestReward"] = "Weekly Quest Reward"
L["WeeklyQuestWarModeReward"] = "Weekly Quest War Mode Reward"
L["AccountCopy"] = "Account Copy"
L["WeeklyRewardChest"] = "Weekly Reward Chest"
L["GarrisonTalentTreeReset"] = "Garrison Talent Tree Reset"
L["DailyReset"] = "Daily Reset"
L["AddConduitToCollection"] = "Add Conduit to Collection"
L["Barbershop"] = "Barbershop"
L["ConvertItemsToCurrencyValue"] = "Convert Items to Currency Value"
L["PvPTeamContribution"] = "PvP Team Contribution"
L["Transmogrify"] = "Transmogrify"
L["AuctionDeposit"] = "Auction Deposit"
L["PlayerTrait"] = "Player Trait"
L["PhBuffer_53"] = "Placeholder 53"
L["PhBuffer_54"] = "Placeholder 54"
L["RenownRepGain"] = "Renown Reputation Gain"
L["CraftingOrder"] = "Crafting Order"
L["CatalystBalancing"] = "Catalyst Balancing"
L["CatalystCraft"] = "Catalyst Craft"
L["ProfessionInitialAward"] = "Profession Initial Award"
L["PlayerTraitRefund"] = "Player Trait Refund"
L["AccountHwmUpdate"] = "Account High-Water Mark Update"
L["ConvertItemsToCurrencyAndReputation"] = "Convert Items to Currency and Reputation"
L["PhBuffer_63"] = "Placeholder 63"
L["SpellSkipLinkedCurrency"] = "Spell Skip Linked Currency"
L["AccountTransfer"] = "Account Transfer"

-- Currency Tracker - Destroy reason labels (Enum.CurrencyDestroyReason)
-- These keys complement Source tokens for loss-side reasons introduced in WoW 11.0.2.
-- Only add keys that are not already defined above.
L["VersionUpdate"] = "Version Update"
L["QuestTurnin"] = "Quest Turn-in"
L["Capped"] = "Capped"
L["Garrison"] = "Garrison"
L["DroppedToCorpse"] = "Dropped To Corpse"
L["FulfillCraftingOrder"] = "Fulfill Crafting Order"
L["ConcentrationCast"] = "Concentration Cast"

-- Currency Tracker - Custom internal source labels
-- Friendly names for string keys used by the headless Currency Tracker.
L["BaselinePrime"] = "Baseline (Initial Balance)"

-- Currency Tracker - /ct output strings (headers and labels)
-- Single-currency detail
L["CT_HeaderFormat"] = "=== %s (id: %s) - %s ==="
L["CT_TotalIncome"] = "Total Income"
L["CT_TotalOutgoing"] = "Total Outgoing"
L["CT_NetChange"] = "Net Change"
L["CT_TransactionsBySource"] = "Transactions by Source"
L["CT_NoTransactions"] = "No transactions recorded."

-- Summary view (all currencies)
L["CT_NoCurrencyData"] = "No currency data available."
L["CT_AllCurrenciesHeader"] = "=== All Currencies - %s ==="
L["CT_LineIncome"] = "Income"
L["CT_LineOutgoing"] = "Outgoing"
L["CT_LineNet"] = "Net"
L["CT_LineWeeklyMax"] = "WeeklyMax"
L["CT_LineTotalMax"] = "TotalMax"
L["CT_Unlimited"] = "Unlimited"
-- Near-cap warning
L["CT_WarnNearCap"] = "Warning: %s has reached or exceeded 90%% of total cap (%d)"

-- Currency Tracker headers (UI)
L["CT_Header_Currency"] = "Currency"
L["CT_Header_TotalMax"] = "Cap"
L["CT_Header_Income"]   = "Income"
L["CT_Header_Outgoing"] = "Outgoing"
L["CT_Header_Net"]      = "Net"

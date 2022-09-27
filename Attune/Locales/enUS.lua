--localization file for english/United States
local Lang = LibStub("AceLocale-3.0"):NewLocale("Attune", "enUS", true, true)
if (not Lang) then
	return;
end


-- INTERFACE
Lang["Credits"] = "A huge thank you to my guild |cffffd100<Divine Heresy>|r for their support and understanding while I test the addon, and heaps of kudos to |cffffd100Bushido @ Pyrewood Village|r for the help on TBC!\n\n Also, many, many thanks to the translators:\n  - German translation: |cffffd100Sumaya @ Razorfen DE|r\n  - Russian translation: |cffffd100Greymarch Guild @ Flamegor RU|r\n  - Spanish translation: |cffffd100Coyu @ Pyrewood Village EU|r\n  - Chinese translation (simp.): |cffffd100ly395842562|r and |cffffd100Icyblade|r\n  - Chinese translation (trad.): |cffffd100DayZ|r @ Ivus TW|r\n  - Korean translation: |cffffd100Drix @ Azshara KR|r\n\n/Hug from Cixi/Gaya @ Remulos Horde"
Lang["Mini"] = "Mini"
Lang["Maxi"] = "Maxi"
Lang["Version"] = "Attune v##VERSION## by Cixi@Remulos"
Lang["Splash"] = "v##VERSION## by Cixi@Remulos. Type /attune to start."
Lang["Survey"] = "Survey"
Lang["Guild"] = "Guild"
Lang["Party"] = "Party"
Lang["Raid"] = "Raid"
Lang["Run an attunement survey (for people with the addon)"] = "Run an attunement survey (for people with the addon)"
Lang["Toggle between attunements and survey results"] = "Toggle between attunements and survey results" 
Lang["Close"] = "Close" 
Lang["Export"] = "Export"
Lang["My Data"] = "My Data"
Lang["Last Survey"] = "Last Survey"
Lang["Guild Data"] = "Guild Data"
Lang["All Data"] = "All Data"
Lang["Export your Attune data to the website"] = "Export your Attune data to the website"
Lang["Copy the text below, then upload it to"] = "Copy the text below, then upload it to"
Lang["Results"] = "Results"
Lang["Not in a guild"] = "Not in a guild"
Lang["Click on a header to sort the results"] = "Click on header to sort the results" 
Lang["Character"] = "Character" 
Lang["Characters"] = "Characters"
Lang["Last survey results"] = "Last survey results"	
Lang["All FACTION results"] = "All ##FACTION## results"
Lang["Guild members"] = "Guild members" 
Lang["All results"] = "All results" 
Lang["Minimum level"] = "Minimum level" 
Lang["Click to navigate to that attunement"] = "Click to navigate to that attunement"
Lang["Attunes"] = "Attunes"
Lang["Guild members on this step"] = "Guild members on this step"
Lang["Attuned guild members"] = "Attuned guild members"
Lang["Attuned alts"] = "Attuned alts"
Lang["Alts on this step"] = "Alts on this step"
Lang["Settings"] = "Settings"
Lang["Survey Log"] = "Survey Log"
Lang["LeftClick"] = "Left Click"
Lang["OpenAttune"] = "    Open Attune"
Lang["RightClick"] = "Right Click"
Lang["OpenSettings"] = "  Open Settings"
Lang["Addon disabled"] = "Addon disabled"
Lang["StartAutoGuildSurvey"] = "Sending automatic Guild silent survey"
Lang["SendingDataTo"] = "Sending Attune data to |cffffd100##NAME##|r"
Lang["NewVersionAvailable"] = "A |cffffd100new version|r of Attune is available, make sure to update it!"
Lang["CompletedStep"] = "Completed ##TYPE## |cffe4e400##STEP##|r for attunement |cffe4e400##NAME##|r."
Lang["AttuneComplete"] = "Attunement |cffe4e400##NAME##|r complete!"
Lang["AttuneCompleteGuild"] = "##NAME## attunement complete!"
Lang["SendingSurveyWhat"] = "Sending ##WHAT## survey"
Lang["SendingGuildSilentSurvey"] = "Sending Guild silent survey"
Lang["SendingYellSilentSurvey"] = "Sending Yell silent survey"
Lang["ReceivedDataFromName"] = "Received data from |cffffd100##NAME##|r"
Lang["ExportingData"] = "Exporting Attune data for ##COUNT## character(s)"
Lang["ReceivedRequestFrom"] = "Received a survey request from |cffffd100##FROM##|r"
Lang["Help1"] = "This addon allows you to check and export your attunement progress"
Lang["Help2"] = "Run |cfffff700/attune|r to start."
Lang["Help3"] = "To survey the progress of your guild, click |cfffff700survey|r to collect the information."
Lang["Help4"] = "You will then receive progress data from any guild member with the addon."
Lang["Help5"] = "Once you have enough information, click |cfffff700export|r to export the guild progress"
Lang["Help6"] = "Data can be uploaded to |cfffff700https://warcraftratings.com/attune/upload|r"
Lang["Survey_DESC"] = "Run an attunement survey (for people with the addon)"
Lang["Export_DESC"] = "Export your Attune data to the website"
Lang["Toggle_DESC"] = "Toggle between attunements and survey results"
--Lang["PreferredLocale_TEXT"] = "Preferred Language"
--Lang["PreferredLocale_DESC"] = "Select the language you want to see Attune in. Changes to this will require a reload to take effect."
--v220
Lang["My Toons"] = "My Toons"
Lang["No Target"] = "You do not have a target"
Lang["No Response From"] = "No response from ##PLAYER##"
Lang["Sync Request From"] = "New Attune Sync request from:\n\n##PLAYER##"
Lang["Could be slow"] = "Depending on the amount of data you have, this could be a very slow process"
Lang["Accept"] = "Accept"
Lang["Reject"] = "Reject"
Lang["Busy right now"] = "##PLAYER## is busy right now, try again later"
Lang["Sending Sync Request"] = "Sending Sync Request to ##PLAYER##"
Lang["Request accepted, sending data to "] = "Request accepted, sending data to ##PLAYER##"
Lang["Received request from"] = "Received request from ##PLAYER##"
Lang["Request rejected"] = "Request rejected"
Lang["Sync over"] = "Sync over, took ##DURATION##"
Lang["Syncing Attune data with"] = "Syncing Attune data with ##PLAYER##"
Lang["Cannot sync while another sync is in progress"] = "Cannot sync while another sync is in progress"
Lang["Sync with target"] = "Sync with target"
Lang["Show Profiles"] = "Show Profiles"
Lang["Show Progress"] = "Back to Progress"
Lang["Status"] = "Status"
Lang["Role"] = "Role"
Lang["Last Surveyed"] = "Last Surveyed"
Lang['Seconds ago'] = "##DURATION## ago"
Lang["Main"] = "Main"
Lang["Alt"] = "Alt"
Lang["Tank"] = "Tank"
Lang["Healer"] = "Healer"
Lang["Melee DPS"] = "Melee DPS"
Lang["Ranged DPS"] = "Ranged DPS"
Lang["Bank"] = "Bank"
Lang["DelAlts_TEXT"] = "Delete all Alts"
Lang["DelAlts_DESC"] = "Delete all the information about players marked as Alts"
Lang["DelAlts_CONF"] = "Really delete all Alts?"
Lang["DelAlts_DONE"] = "All Alts deleted"
Lang["DelUnspecified_TEXT"] = "Delete Unspecified"
Lang["DelUnspecified_DESC"] = "Delete all the information about players with an unspecified Main/Alt status"
Lang["DelUnspecified_CONF"] = "Really delete all characters with an unspecified Main/Alt status?"
Lang["DelUnspecified_DONE"] = "All unspecified Main/Alt statuses deleted"
--v221
Lang["Open Raid Planner"] = "Open Raid Planner"
Lang["Unspecified"] = "Unspecified"
Lang["Empty"] = "Empty"
Lang["Guildies only"] = "Show Guildies only"
Lang["Show Mains"] = "Show Mains"
Lang["Show Unspecified"] = "Show Unspecified"
Lang["Show Alts"] = "Show Alts"
Lang["Show Unattuned"] = "Show Unattuned"
Lang["Raid spots"] = "##SIZE## Raid spots"
Lang["Group Number"] = "Group ##NUMBER##"
Lang["Move to next group"] = "    Move to the next group"
Lang["Remove from raid"] = "  Remove from raid"
Lang["Select a raid and click on players to add them in"] = "Select a raid and click on players to add them in"
--v224
Lang["Enter a new name for this raid group"] = "Enter a new name for this raid group"
Lang["Save"] = "Save"
--v226
Lang["Invite"] = "Invite"
Lang["Send raid invites to all listed players?"] = "Send raid invites to all listed players?"
Lang["External link"] = "Link to an online database"
--v243
Lang["Ogrila"] = "Ogri'la"
Lang["Ogri'la Quest Hub"] = "Ogri'la Quest Hub"
Lang["Ogrila_Desc"] = "Ogri'la is a Neutral faction in The Burning Crusade with weapons, armor, and consumables as rewards."
Lang["DelInactive_TEXT"] = "Delete Inactive"
Lang["DelInactive_DESC"] = "Delete all the information about players marked as Inactive"
Lang["DelInactive_CONF"] = "Really delete all Inactive?"
Lang["DelInactive_DONE"] = "All Inactive deleted"
Lang["RAIDS"] = "RAIDS"
Lang["KEYS"] = "KEYS"
Lang["MISC"] = "MISC"
Lang["HEROICS"] = "HEROICS"
--v244
Lang["Ally of the Netherwing"] = "Ally of the Netherwing"
Lang["Netherwing_Desc"] = "The Netherwing is a faction of dragons located in Outland."
--v247
Lang["Tirisfal Glades"] = "Tirisfal Glades"
Lang["Scholomance"] = "Scholomance"
--v248
Lang["Target"] = "Target"
Lang["SendingSurveyTo"] = "Sending survey to ##TO##"
--WOTLK
Lang["QUEST HUBS"] = "QUEST HUBS"
Lang["PHASES"] = "PHASES"
Lang["Angrathar the Wrathgate"] = "Angrathar the Wrathgate"
Lang["Unlock the Wrathgate events and the Battle for the Undercity"] = "Unlock the Wrathgate events and the Battle for the Undercity"
Lang["Sons of Hodir"] = "Sons of Hodir"
Lang["Unlock the Sons of Hodir quest hub"] = "Unlock the Sons of Hodir quest hub"
Lang["Knights of the Ebon Blade"] = "Knights of the Ebon Blade"
Lang["Unlock the Shadow Vault quest hub"] = "Unlock the Shadow Vault quest hub"
Lang["Goblin"] = "Goblin"
Lang["Death Knight"] = "Death Knight"
Lang["Eye"] = "Eye"
Lang["Abomination"] = "Abomination"
Lang["Banshee"] = "Banshee"
Lang["Geist"] = "Geist"
Lang["Icecrown"] = "Icecrown"
Lang["Dragonblight"] = "Dragonblight"
Lang["Borean Tundra"] = "Borean Tundra"
Lang["The Storm Peaks"] = "The Storm Peaks"
Lang["The Eye of Eternity"] = "The Eye of Eternity"
Lang["Sapphiron"] = "Sapphiron"
Lang["One_Desc"] = "Only one person in the group needs to have this key."


-- OPTIONS
Lang["MinimapButton_TEXT"] = "Show the Minimap button"
Lang["MinimapButton_DESC"] = "Display a Minimap button to quickly access the addon interface or options."
Lang["AutoSurvey_TEXT"] = "Run an automatic guild survey on logon"
Lang["AutoSurvey_DESC"] = "Whenever you log into the game, the addon will perform a guild survey."
Lang["ShowSurveyed_TEXT"] = "Show when I've been surveyed"
Lang["ShowSurveyed_DESC"] =  "Displays a chat message when receiving (and answering) a survey request."
Lang["ShowResponses_TEXT"] = "Show responses when I do a survey"
Lang["ShowResponses_DESC"] = "Displays a chat message for each survey response."
Lang["ShowSetMessages_TEXT"] = "Show step completion messages"
Lang["ShowSetMessages_DESC"] = "Displays a chat message when a step or attunement is completed."
Lang["AnnounceToGuild_TEXT"] = "Announce completion in guild chat"
Lang["AnnounceToGuild_DESC"] = "Send a guild message when an attunement is completed."
Lang["ShowOther_TEXT"] = "Show other chat messages"
Lang["ShowOther_DESC"] = "Displays all other generic chat messages (splash, sending survey, update available, etc)."
Lang["ShowGuildies_TEXT"] = "Show list of guild members at each attunement step.               Max list size"  --this has a gap for the editbox
Lang["ShowGuildies_DESC"] = "Displays in the step tooltip a list of guild members that are currently at that attunement step.\nAdjust the max number of guildies to list on each attunement step if needed."
Lang["ShowAltsInstead_TEXT"] = "Show list of alts instead of guild members"
Lang["ShowAltsInstead_DESC"] = "The step tooltips will display any of your alts that are currently at that attunement step instead of guildies."
Lang["ClearAll_TEXT"] = "Delete ALL results"
Lang["ClearAll_DESC"] = "Delete all the gathered information about other players."
Lang["ClearAll_CONF"] = "Really delete ALL results?"
Lang["ClearAll_DONE"] = "All results deleted."
Lang["DelNonGuildies_TEXT"] = "Delete non guildies"
Lang["DelNonGuildies_DESC"] = "Delete all the gathered information about players from outside your guild."
Lang["DelNonGuildies_CONF"] = "Really delete all non-guildies?"
Lang["DelNonGuildies_DONE"] = "All results outside your guild deleted."
Lang["DelUnder60_TEXT"] = "Delete characters under 60"
Lang["DelUnder60_DESC"] = "Delete all the gathered information about players under level 60."
Lang["DelUnder60_CONF"] = "Really delete all characters under level 60?"
Lang["DelUnder60_DONE"] = "All results under 60 deleted."
Lang["DelUnder70_TEXT"] = "Delete characters under 70"
Lang["DelUnder70_DESC"] = "Delete all the gathered information about players under level 70."
Lang["DelUnder70_CONF"] = "Really delete all characters under level 70?"
Lang["DelUnder70_DONE"] = "All results under 70 deleted."
--302
Lang["AnnounceAchieve_TEXT"] = "Announce Achievements in guild chat.                             Threshold:"
Lang["AnnounceAchieve_DESC"] = "Send a guild message when an achievement is earned rewarding at least that amount of points."
Lang["AchieveCompleteGuild"] = "##LINK## complete!" 
Lang["AchieveCompletePoints"] = "(##POINTS## points total)" 
Lang["AchieveSurvey"] = "Would you like |cFFFFD100Attune|r to announce |cFFFFD100##WHO##|r's achievements in guild chat?"
--306
Lang["showDeprecatedAttunes_TEXT"] = "Show deprecated attunements"
Lang["showDeprecatedAttunes_DESC"] = "Keep the older attunements (Onyxia 40, Naxxramas 40) visible in the list"
					

-- TREEVIEW
Lang["World of Warcraft"] = "World of Warcraft"
Lang["The Burning Crusade"] = "The Burning Crusade"
Lang["Molten Core"] = "Molten Core"
Lang["Onyxia's Lair"] = "Onyxia's Lair"
Lang["Blackwing Lair"] = "Blackwing Lair"
Lang["Naxxramas"] = "Naxxramas"
Lang["Scepter of the Shifting Sands"] = "Scepter of the Shifting Sands"
Lang["Shadow Labyrinth"] = "Shadow Labyrinth"
Lang["The Shattered Halls"] = "The Shattered Halls"
Lang["The Arcatraz"] = "The Arcatraz"
Lang["The Black Morass"] = "The Black Morass"
Lang["Thrallmar Heroics"] = "Thrallmar Heroics"
Lang["Honor Hold Heroics"] = "Honor Hold Heroics"
Lang["Cenarion Expedition Heroics"] = "Cenarion Expedition Heroics"
Lang["Lower City Heroics"] = "Lower City Heroics"
Lang["Sha'tar Heroics"] = "Sha'tar Heroics"
Lang["Keepers of Time Heroics"] = "Keepers of Time Heroics"
Lang["Nightbane"] = "Nightbane"
Lang["Karazhan"] = "Karazhan"
Lang["Serpentshrine Cavern"] = "Serpentshrine Cavern"
Lang["The Eye"] = "The Eye"
Lang["Mount Hyjal"] = "Mount Hyjal"
Lang["Black Temple"] = "Black Temple"
Lang["MC_Desc"] = "All members of the raid group need to have this attunement in order to zone into the raid instance, unless they enter via BRD." 
Lang["Ony_Desc"] = "All members of the raid group need to have the Drakefire Amulet in their bag, in order to zone into the raid instance."
Lang["BWL_Desc"] = "All members of the raid group need to have this attunement in order to zone into the raid instance, unless they enter via UBRS."
Lang["All_Desc"] = "All members of the raid group need to have this attunement in order to zone into the raid instance."
Lang["AQ_Desc"] = "Only one person per realm needs to complete this in order to open the gates of Ahn'Qiraj."
Lang["OnlyOne_Desc"] = "Only one person in the group needs to have this key. A rogue with 350 lockpicking can also open the gate."
Lang["Heroic_Desc"] = "All members of the group need to have the rep and key in order to zone into the Heroic dungeons."
Lang["NB_Desc"] = "Only one member of the raid group needs to have the Blackened Urn in order to summon Nightbane."
Lang["BT_Desc"] = "All members of the raid group need to have the Medallion of Karabor in order to zone into the raid instance."
Lang["BM_Desc"] = "All members of the group need to complete the quest chain in order to zone into the instance." 
--v250
Lang["Aqual Quintessence"] = "Aqual Quintessence"
Lang["MC2_Desc"] = "Used to summon Majordomo Executus. Every boss in Molten Core except Lucifron and Geddon have runes on the ground that need to be doused for Majordomo to spawn." 
--v254
Lang["Magisters' Terrace Heroic"] = "Magisters' Terrace Heroic"
Lang["Magisters' Terrace"] = "Magisters' Terrace"
Lang["MgT_Desc"] = "All players need to complete the dungeon on normal mode to be able to run it in heroic mode."
Lang["Isle of Quel'Danas"] = "Isle of Quel'Danas"
Lang["Wrath of the Lich King"] = "Wrath of the Lich King"


-- GENERIC
Lang["Reach level"] = "Reach level"
Lang["Attuned"] = "Attuned"
Lang["Not attuned"] = "Not attuned"
Lang["AttuneColors"] = "Blue: Attuned\nRed:  Not attuned"
Lang["Minimum Level"] = "This is the minimum level to have access to the quests."
Lang["NPC Not Found"] = "NPC information not found"
Lang["Level"] = "Level"
Lang["Exalted with"] = "Exalted with"
Lang["Revered with"] = "Revered with"
Lang["Honored with"] = "Honored with"
Lang["Friendly with"] = "Friendly with"
Lang["Neutral with"] = "Neutral with"
Lang["Quest"] = "Quest"
Lang["Pick Up"] = "Pick Up"
Lang["Turn In"] = "Turn In"
Lang["Kill"] = "Kill"
Lang["Interact"] = "Interact"
Lang["Item"] = "Item"
Lang["Required level"] = "Required level"
Lang["Requires level"] = "Requires level"
Lang["Attunement or key"] = "Attunement or key"
Lang["Reputation"] = "Reputation"
Lang["in"] = "in"
Lang["Unknown Reputation"] = "Unknown Reputation"
Lang["Current progress"] = "Current progress"
Lang["Completion"] = "Completion"
Lang["Quest information not found"] = "Quest information not found"
Lang["Information not found"] = "Information not found"
Lang["Solo quest"] = "Solo quest"
Lang["Party quest"] = "Party quest (##NB##-man)"
Lang["Raid quest"] = "Raid quest (##NB##-man)"
Lang["HEROIC"] = "H"
Lang["Elite"] = "Elite"
Lang["Boss"] = "Boss"
Lang["Rare Elite"] = "Rare Elite"
Lang["Dragonkin"] = "Dragonkin"
Lang["Troll"] = "Troll"
Lang["Ogre"] = "Ogre"
Lang["Orc"] = "Orc"
Lang["Half-Orc"] = "Half-Orc"
Lang["Dragonkin (in Blood Elf form)"] = "Dragonkin (in Blood Elf form)"
Lang["Human"] = "Human"
Lang["Dwarf"] = "Dwarf"
Lang["Mechanical"] = "Mechanical"
Lang["Arakkoa"] = "Arakkoa"
Lang["Dragonkin (in Humanoid form)"] = "Dragonkin (in Humanoid form)"
Lang["Ethereal"] = "Ethereal"
Lang["Blood Elf"] = "Blood Elf"
Lang["Elemental"] = "Elemental"
Lang["Shiny thingy"] = "Shiny thingy"
Lang["Naga"] = "Naga"
Lang["Demon"] = "Demon"
Lang["Gronn"] = "Gronn"
Lang["Undead (in Dragon form)"] = "Undead (in Dragon form)"
Lang["Tauren"] = "Tauren"
Lang["Qiraji"] = "Qiraji"
Lang["Gnome"] = "Gnome"
Lang["Broken"] = "Broken"
Lang["Draenei"] = "Draenei"
Lang["Undead"] = "Undead"
Lang["Gorilla"] = "Gorilla"
Lang["Shark"] = "Shark"
Lang["Chimaera"] = "Chimaera"
Lang["Wisp"] = "Wisp"
Lang["Night-Elf"] = "Night-Elf"


-- REP
Lang["Argent Dawn"] = "Argent Dawn"
Lang["Brood of Nozdormu"] = "Brood of Nozdormu"
Lang["Thrallmar"] = "Thrallmar"
Lang["Honor Hold"] = "Honor Hold"
Lang["Cenarion Expedition"] = "Cenarion Expedition"
Lang["Lower City"] = "Lower City"
Lang["The Sha'tar"] = "The Sha'tar"
Lang["Keepers of Time"] = "Keepers of Time"
Lang["The Violet Eye"] = "The Violet Eye"
Lang["The Aldor"] = "The Aldor"
Lang["The Scryers"] = "The Scryers"


-- LOCATIONS
Lang["Blackrock Mountain"] = "Blackrock Mountain"
Lang["Blackrock Depths"] = "Blackrock Depths"
Lang["Badlands"] = "Badlands"
Lang["Lower Blackrock Spire"] = "Lower Blackrock Spire"
Lang["Upper Blackrock Spire"] = "Upper Blackrock Spire"
Lang["Orgrimmar"] = "Orgrimmar"
Lang["Western Plaguelands"] = "Western Plaguelands"
Lang["Desolace"] = "Desolace"
Lang["Dustwallow Marsh"] = "Dustwallow Marsh"
Lang["Tanaris"] = "Tanaris"
Lang["Winterspring"] = "Winterspring"
Lang["Swamp of Sorrows"] = "Swamp of Sorrows"
Lang["Wetlands"] = "Wetlands"
Lang["Burning Steppes"] = "Burning Steppes"
Lang["Redridge Mountains"] = "Redridge Mountains"
Lang["Stormwind City"] = "Stormwind City"
Lang["Eastern Plaguelands"] = "Eastern Plaguelands"
Lang["Silithus"] = "Silithus"
Lang["The Temple of Atal'Hakkar"] = "The Temple of Atal'Hakkar"
Lang["Teldrassil"] = "Teldrassil"
Lang["Moonglade"] = "Moonglade"
Lang["Hinterlands"] = "Hinterlands"
Lang["Ashenvale"] = "Ashenvale"
Lang["Feralas"] = "Feralas"
Lang["Duskwood"] = "Duskwood"
Lang["Azshara"] = "Azshara"
Lang["Blasted Lands"] = "Blasted Lands"
Lang["Undercity"] = "Undercity"
Lang["Silverpine Forest"] = "Silverpine Forest"
Lang["Shadowmoon Valley"] = "Shadowmoon Valley"
Lang["Hellfire Peninsula"] = "Hellfire Peninsula"
Lang["Sethekk Halls"] = "Sethekk Halls"
Lang["Caverns Of Time"] = "Caverns Of Time"
Lang["Netherstorm"] = "Netherstorm"
Lang["Shattrath City"] = "Shattrath City"
Lang["The Mechanaar"] = "The Mechanaar"
Lang["The Botanica"] = "The Botanica"
Lang["Zangarmarsh"] = "Zangarmarsh"
Lang["Terokkar Forest"] = "Terokkar Forest"
Lang["Deadwind Pass"] = "Deadwind Pass"
Lang["Alterac Mountains"] = "Alterac Mountains"
Lang["The Steamvault"] = "The Steamvault"
Lang["Slave Pens"] = "Slave Pens"
Lang["Gruul's Lair"] = "Gruul's Lair"
Lang["Magtheridon's Lair"] = "Magtheridon's Lair"
Lang["Zul'Aman"] = "Zul'Aman"
Lang["Sunwell Plateau"] = "Sunwell Plateau"



-- ITEMS
Lang["Drakkisath's Brand"] = "Drakkisath's Brand"
Lang["Crystalline Tear"] = "Crystalline Tear"
Lang["I_18412"] = "Core Fragment"			-- https://www.thegeekcrusade-serveur.com/db/?item=18412
Lang["I_12562"] = "Important Blackrock Documents"			-- https://www.thegeekcrusade-serveur.com/db/?item=12562
Lang["I_16786"] = "Black Dragonspawn Eye"			-- https://www.thegeekcrusade-serveur.com/db/?item=16786
Lang["I_11446"] = "A Crumpled Up Note"			-- https://www.thegeekcrusade-serveur.com/db/?item=11446
Lang["I_11465"] = "Marshal Windsor's Lost Information"			-- https://www.thegeekcrusade-serveur.com/db/?item=11465
Lang["I_11464"] = "Marshal Windsor's Lost Information"			-- https://www.thegeekcrusade-serveur.com/db/?item=11464
Lang["I_18987"] = "Blackhand's Command"			-- https://www.thegeekcrusade-serveur.com/db/?item=18987
Lang["I_20383"] = "Head of the Broodlord Lashlayer"			-- https://www.thegeekcrusade-serveur.com/db/?item=20383
Lang["I_21138"] = "Red Scepter Shard"			-- https://www.thegeekcrusade-serveur.com/db/?item=21138
Lang["I_21146"] = "Fragment of the Nightmare's Corruption"			-- https://www.thegeekcrusade-serveur.com/db/?item=21146
Lang["I_21147"] = "Fragment of the Nightmare's Corruption"			-- https://www.thegeekcrusade-serveur.com/db/?item=21147
Lang["I_21148"] = "Fragment of the Nightmare's Corruption"			-- https://www.thegeekcrusade-serveur.com/db/?item=21148
Lang["I_21149"] = "Fragment of the Nightmare's Corruption"			-- https://www.thegeekcrusade-serveur.com/db/?item=21149
Lang["I_21139"] = "Green Scepter Shard"			-- https://www.thegeekcrusade-serveur.com/db/?item=21139
Lang["I_21103"] = "Draconic for Dummies - Chapter I"			-- https://www.thegeekcrusade-serveur.com/db/?item=21103
Lang["I_21104"] = "Draconic for Dummies - Chapter II"			-- https://www.thegeekcrusade-serveur.com/db/?item=21104
Lang["I_21105"] = "Draconic for Dummies - Chapter III"			-- https://www.thegeekcrusade-serveur.com/db/?item=21105
Lang["I_21106"] = "Draconic for Dummies - Chapter IV"			-- https://www.thegeekcrusade-serveur.com/db/?item=21106
Lang["I_21107"] = "Draconic for Dummies - Chapter V"			-- https://www.thegeekcrusade-serveur.com/db/?item=21107
Lang["I_21108"] = "Draconic for Dummies - Chapter VI"			-- https://www.thegeekcrusade-serveur.com/db/?item=21108
Lang["I_21109"] = "Draconic for Dummies - Chapter VII"			-- https://www.thegeekcrusade-serveur.com/db/?item=21109
Lang["I_21110"] = "Draconic for Dummies - Chapter VIII"			-- https://www.thegeekcrusade-serveur.com/db/?item=21110
Lang["I_21111"] = "Draconic For Dummies: Volume II"			-- https://www.thegeekcrusade-serveur.com/db/?item=21111
Lang["I_21027"] = "Lakmaeran's Carcass"			-- https://www.thegeekcrusade-serveur.com/db/?item=21027
Lang["I_21024"] = "Chimaerok Tenderloin"			-- https://www.thegeekcrusade-serveur.com/db/?item=21024
Lang["I_20951"] = "Narain's Scrying Goggles"			-- https://www.thegeekcrusade-serveur.com/db/?item=20951
Lang["I_21137"] = "Blue Scepter Shard"			-- https://www.thegeekcrusade-serveur.com/db/?item=21137
Lang["I_21175"] = "The Scepter of the Shifting Sands"			-- https://www.thegeekcrusade-serveur.com/db/?item=21175
Lang["I_31241"] = "Primed Key Mold"			-- https://www.thegeekcrusade-serveur.com/db/?item=31241
Lang["I_31239"] = "Primed Key Mold"			-- https://www.thegeekcrusade-serveur.com/db/?item=31239
Lang["I_27991"] = "Shadow Labyrinth Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=27991
Lang["I_31086"] = "Bottom Shard of the Arcatraz Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=31086
Lang["I_31085"] = "Top Shard of the Arcatraz Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=31085
Lang["I_31084"] = "Key to the Arcatraz"			-- https://www.thegeekcrusade-serveur.com/db/?item=31084
Lang["I_30637"] = "Flamewrought Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=30637
Lang["I_30622"] = "Flamewrought Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=30622
Lang["I_30623"] = "Reservoir Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=30623
Lang["I_30633"] = "Auchenai Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=30633
Lang["I_30634"] = "Warpforged Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=30634
Lang["I_30635"] = "Key of Time"			-- https://www.thegeekcrusade-serveur.com/db/?item=30635
Lang["I_185686"] = "Flamewrought Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=30637
Lang["I_185687"] = "Flamewrought Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=30622
Lang["I_185690"] = "Reservoir Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=30623
Lang["I_185691"] = "Auchenai Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=30633
Lang["I_185692"] = "Warpforged Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=30634
Lang["I_185693"] = "Key of Time"			-- https://www.thegeekcrusade-serveur.com/db/?item=30635
Lang["I_24514"] = "First Key Fragment"			-- https://www.thegeekcrusade-serveur.com/db/?item=24514
Lang["I_24487"] = "Second Key Fragment"			-- https://www.thegeekcrusade-serveur.com/db/?item=24487
Lang["I_24488"] = "Third Key Fragment"			-- https://www.thegeekcrusade-serveur.com/db/?item=24488
Lang["I_24490"] = "The Master's Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=24490
Lang["I_23933"] = "Medivh's Journal"			-- https://www.thegeekcrusade-serveur.com/db/?item=23933
Lang["I_25462"] = "Tome of Dusk"			-- https://www.thegeekcrusade-serveur.com/db/?item=25462
Lang["I_25461"] = "Book of Forgotten Names"			-- https://www.thegeekcrusade-serveur.com/db/?item=25461
Lang["I_24140"] = "Blackened Urn"			-- https://www.thegeekcrusade-serveur.com/db/?item=24140
Lang["I_31750"] = "Earthen Signet"			-- https://www.thegeekcrusade-serveur.com/db/?item=31750
Lang["I_31751"] = "Blazing Signet"			-- https://www.thegeekcrusade-serveur.com/db/?item=31751
Lang["I_31716"] = "Unused Axe of the Executioner"			-- https://www.thegeekcrusade-serveur.com/db/?item=31716
Lang["I_31721"] = "Kalithresh's Trident"			-- https://www.thegeekcrusade-serveur.com/db/?item=31721
Lang["I_31722"] = "Murmur's Essence"			-- https://www.thegeekcrusade-serveur.com/db/?item=31722
Lang["I_31704"] = "The Tempest Key"			-- https://www.thegeekcrusade-serveur.com/db/?item=31704
Lang["I_29905"] = "Kael's Vial Remnant"			-- https://www.thegeekcrusade-serveur.com/db/?item=29905
Lang["I_29906"] = "Vashj's Vial Remnant"			-- https://www.thegeekcrusade-serveur.com/db/?item=29906
Lang["I_31307"] = "Heart of Fury"			-- https://www.thegeekcrusade-serveur.com/db/?item=31307
Lang["I_32649"] = "Medaillon of Karabor"			-- https://www.thegeekcrusade-serveur.com/db/?item=32649
--v247
Lang["Shrine of Thaurissan"] = "Shrine of Thaurissan"
Lang["I_14610"] = "Araj's Scarab"
--v250
Lang["I_17332"] = "Hand of Shazzrah"
Lang["I_17329"] = "Hand of Lucifron"
Lang["I_17331"] = "Hand of Gehennas"
Lang["I_17330"] = "Hand of Sulfuron"
Lang["I_17333"] = "Aqual Quintessence"
--WOTLK
Lang["I_41556"] = "Slag Covered Metal"
Lang["I_44569"] = "Key to the Focusing Iris"
Lang["I_44582"] = "Key to the Focusing Iris"
Lang["I_44577"] = "Heroic Key to the Focusing Iris"
Lang["I_44581"] = "Heroic Key to the Focusing Iris"

Lang["I_"] = ""


-- QUESTS - Classic
Lang["Q1_7848"] = "Attunement to the Core"			-- https://www.thegeekcrusade-serveur.com/db/?quest=7848
Lang["Q2_7848"] = "Venture to the Molten Core entry portal in Blackrock Depths and recover a Core Fragment. Return to Lothos Riftwaker in Blackrock Mountain when you have recovered the Core Fragment."
Lang["Q1_4903"] = "Warlord's Command"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4903
Lang["Q2_4903"] = "Slay Highlord Omokk, War Master Voone, and Overlord Wyrmthalak. Recover Important Blackrock Documents. Return to Warlord Goretooth in Kargath when the mission has been accomplished."
Lang["Q1_4941"] = "Eitrigg's Wisdom"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4941
Lang["Q2_4941"] = "Speak with Eitrigg in Orgrimmar. When you have discussed matters with Eitrigg, seek council from Thrall.\n\nYou recall having seen Eitrigg in Thrall's chamber."
Lang["Q1_4974"] = "For The Horde!"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4974
Lang["Q2_4974"] = "Travel to Blackrock Spire and slay Warchief Rend Blackhand. Take his head and return to Orgrimmar."
Lang["Q1_6566"] = "What the Wind Carries"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6566
Lang["Q2_6566"] = "Listen to Thrall."
Lang["Q1_6567"] = "The Champion of the Horde"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6567
Lang["Q2_6567"] = "Seek out Rexxar. The Warchief has instructed you as to his whereabouts. Search the paths of Desolace, between the Stonetalon Mountains and Feralas."
Lang["Q1_6568"] = "The Testament of Rexxar"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6568
Lang["Q2_6568"] = "Deliver Rexxar's Letter to Myranda the Hag in the Western Plaguelands."
Lang["Q1_6569"] = "Oculus Illusions"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6569
Lang["Q2_6569"] = "Travel to Blackrock Spire and collect 20 Black Dragonspawn Eyes. Return to Myranda the Hag when the task is complete."
Lang["Q1_6570"] = "Emberstrife"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6570
Lang["Q2_6570"] = "Travel to the Wyrmbog in Dustwallow Marsh and seek out Emberstrife's Den. Once inside, wear the Amulet of Draconic Subversion and speak with Emberstrife."
Lang["Q1_6584"] = "The Test of Skulls, Chronalis"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6584
Lang["Q2_6584"] = "Guarding the Caverns of Time in the Tanaris Desert is Chronalis, child of Nozdormu. Destroy him and return his skull to Emberstrife."
Lang["Q1_6582"] = "The Test of Skulls, Scryer"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6582
Lang["Q2_6582"] = "You must find the blue dragonflight drake champion, Scryer, and slay him. Pry his skull from his corpse and return it to Emberstrife. \n\nYou know that Scryer can be found in Winterspring."
Lang["Q1_6583"] = "The Test of Skulls, Somnus"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6583
Lang["Q2_6583"] = "Destroy the drake champion of the Green Flight, Somnus. Take his skull and return it to Emberstrife."
Lang["Q1_6585"] = "The Test of Skulls, Axtroz"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6585
Lang["Q2_6585"] = "Travel to Grim Batol and track down Axtroz, drake champion of the Red Flight. Destroy him and take his skull. Return the skull to Emberstrife."
Lang["Q1_6601"] = "Ascension..."			-- https://www.thegeekcrusade-serveur.com/db/?quest=6601
Lang["Q2_6601"] = "It would appear as if the charade is over. You know that the Amulet of Draconic Subversion that Myranda the Hag created for you will not function inside Blackrock Spire. Perhaps you should find Rexxar and explain your predicament. Show him the Dull Drakefire Amulet. Hopefully he will know what to do next."
Lang["Q1_6602"] = "Blood of the Black Dragon Champion"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6602
Lang["Q2_6602"] = "Travel to Blackrock Spire and slay General Drakkisath. Gather his blood and return it to Rexxar."
Lang["Q1_4182"] = "Dragonkin Menace"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4182
Lang["Q2_4182"] = "Slay 15 Black Broodlings, 10 Black Dragonspawn, 4 Black Wyrmkin and 1 Black Drake. Return to Helendis Riverhorn when the task is complete."
Lang["Q1_4183"] = "The True Masters"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4183
Lang["Q2_4183"] = "Travel to Lakeshire and deliver Helendis Riverhorn's Letter to Magistrate Solomon."
Lang["Q1_4184"] = "The True Masters"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4184
Lang["Q2_4184"] = "Travel to Stormwind and deliver Solomon's Plea to Highlord Bolvar Fordragon.\n\nBolvar resides in Stormwind Keep."
Lang["Q1_4185"] = "The True Masters"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4185
Lang["Q2_4185"] = "Speak with Highlord Bolvar Fordragon after speaking with Lady Katrana Prestor."
Lang["Q1_4186"] = "The True Masters"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4186
Lang["Q2_4186"] = "Take Bolvar's Decree to Magistrate Solomon in Lakeshire."
Lang["Q1_4223"] = "The True Masters"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4223
Lang["Q2_4223"] = "Speak with Marshal Maxwell in the Burning Steppes."
Lang["Q1_4224"] = "The True Masters"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4224
Lang["Q2_4224"] = "Speak with Ragged John to learn of Marshal Windsor's fate and return to Marshal Maxwell when you have completed this task.\n\nYou recall Marshal Maxwell telling you to search for him in a cave to the north."
Lang["Q1_4241"] = "Marshal Windsor"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4241
Lang["Q2_4241"] = "Travel to Blackrock Mountain in the northwest and enter Blackrock Depths. Find out what became of Marshal Windsor.\n\nYou recall Ragged John talking about Windsor being dragged off to a prison."
Lang["Q1_4242"] = "Abandoned Hope"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4242
Lang["Q2_4242"] = "Give Marshal Maxwell the bad news."
Lang["Q1_4264"] = "A Crumpled Up Note"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4264
Lang["Q2_4264"] = "You may have just stumbled on to something that Marshal Windsor would be interested in seeing. There may be hope, after all."
Lang["Q1_4282"] = "A shred of Hope"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4282
Lang["Q2_4282"] = "Return Marshal Windsor's Lost Information.\n\nMarshal Windsor believes that the information is being held by Golem Lord Argelmach and General Angerforge."
Lang["Q1_4322"] = "Jail Break"			-- https://www.thegeekcrusade-serveur.com/db/?quest=4322
Lang["Q2_4322"] = "Help Marshal Windsor get his gear back and free his friends. Return to Marshal Maxwell if you succeed."
Lang["Q1_6402"] = "Stormwind Rendezvous"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6402
Lang["Q2_6402"] = "Travel to Stormwind City and venture to the city gates. Speak with Squire Rowe so that he may let Marshal Windsor know that you have arrived."
Lang["Q1_6403"] = "The Great Masquerade"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6403
Lang["Q2_6403"] = "Follow Reginald Windsor through Stormwind. Protect him from harm!"
Lang["Q1_6501"] = "The Dragon's Eye"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6501
Lang["Q2_6501"] = "You must search the world for a being capable of restoring the power to the Fragment of the Dragon's Eye. The only information you possess about such a being is that they exist."
Lang["Q1_6502"] = "Drakefire Amulet"			-- https://www.thegeekcrusade-serveur.com/db/?quest=6502
Lang["Q2_6502"] = "You must retrieve the Blood of the Black Dragon Champion from General Drakkisath. Drakkisath can be found in his throne room behind the Halls of Ascension in Blackrock Spire."
Lang["Q1_7761"] = "Blackhand's Command"			-- https://www.thegeekcrusade-serveur.com/db/?quest=7761
Lang["Q2_7761"] = "That is one stupid orc. It would appear as if you need to find this brand and gain the Mark of Drakkisath in order to access the Orb of Command.\n\nThe letter indicates that General Drakkisath guards the brand. Perhaps you should investigate."
Lang["Q1_9121"] = "The Dread Citadel - Naxxramas"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9121
Lang["Q2_9121"] = "Archmage Angela Dosantos at Light's Hope Chapel in the Eastern Plaguelands wants 5 Arcane Crystals, 2 Nexus Crystals, 1 Righteous Orb and 60 gold pieces. You must also be Honored with the Argent Dawn."
Lang["Q1_9122"] = "The Dread Citadel - Naxxramas"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9122
Lang["Q2_9122"] = "Archmage Angela Dosantos at Light's Hope Chapel in the Eastern Plaguelands wants 2 Arcane Crystals, 1 Nexus Crystal and 30 gold pieces. You must also be Revered with the Argent Dawn."
Lang["Q1_9123"] = "The Dread Citadel - Naxxramas"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9123
Lang["Q2_9123"] = "Archmage Angela Dosantos at Light's Hope Chapel in the Eastern Plaguelands will grant you Arcane Cloaking at no cost. You must be Exalted with the Argent Dawn."
Lang["Q1_8286"] = "What Tomorrow Brings"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8286
Lang["Q2_8286"] = "Venture to the Caverns of Time in Tanaris and find Anachronos, Brood of Nozdormu."
Lang["Q1_8288"] = "Only One May Rise"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8288
Lang["Q2_8288"] = "Return the Head of the Broodlord Lashlayer to Baristolth of the Shifting Sands at Cenarion Hold in Silithus."
Lang["Q1_8301"] = "The Path of the Righteous"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8301
Lang["Q2_8301"] = "Collect 200 Silithid Carapace Fragments and return to Baristolth."
Lang["Q1_8303"] = "Anachronos"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8303
Lang["Q2_8303"] = "Seek out Anachronos at the Caverns of Time in Tanaris."
Lang["Q1_8305"] = "Long Forgotten Memories"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8305
Lang["Q2_8305"] = "Locate the Crystalline Tear in Silithus and gaze into its depths."
Lang["Q1_8519"] = "A Pawn on the Eternal Board"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8519
Lang["Q2_8519"] = "Learn all that you can of the past, then speak with Anachronos at the Caverns of Time in Tanaris."
Lang["Q1_8555"] = "The Charge of the Dragonflights"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8555
Lang["Q2_8555"] = "Eranikus, Vaelastrasz, and Azuregos... No doubt you know of these dragons, mortal. It is no coincidence, then, that they have played such influential roles as watchers of our world.\n\nUnfortunately (and my own naivety is partially to blame) whether by agents of the Old Gods or betrayal by those that would call them friend, each guardian has fallen to tragedy. The extent of which has fueled my own distrust towards your kind.\n\nSeek them out... And prepare yourself for the worst."
Lang["Q1_8730"] = "Nefarius's Corruption"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8730
Lang["Q2_8730"] = "Slay Nefarian and recover the Red Scepter Shard. Return the Red Scepter Shard to Anachronos at the Caverns of Time in Tanaris. You have 5 hours to complete this task."
Lang["Q1_8733"] = "Eranikus, Tyrant of the Dream"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8733
Lang["Q2_8733"] = "Travel to the continent of Teldrassil and find Malfurion's agent somewhere outside the walls of Darnassus."
Lang["Q1_8734"] = "Tyrande and Remulos"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8734
Lang["Q2_8734"] = "Travel to the Moonglade and speak to Keeper Remulos."
Lang["Q1_8735"] = "The Nightmare's Corruption"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8735
Lang["Q2_8735"] = "Travel to the four Emerald Dream portals in Azeroth and collect a Fragment of the Nightmare's Corruption from each. Return to Keeper Remulos in the Moonglade when you have completed this task."
Lang["Q1_8736"] = "The Nightmare Manifests"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8736
Lang["Q2_8736"] = "Defend Nighthaven from Eranikus. Do not let Keeper Remulos perish. Do not slay Eranikus. Defend yourself. Await Tyrande."
Lang["Q1_8741"] = "The Champion Returns"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8741
Lang["Q2_8741"] = "Take the Green Scepter Shard to Anachronos at the Caverns of Time in Tanaris."
Lang["Q1_8575"] = "Azuregos's Magical Ledger"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8575
Lang["Q2_8575"] = "Deliver Azuregos's Magical Ledger to Narain Soothfancy in Tanaris."
Lang["Q1_8576"] = "Translating the Ledger"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8576
Lang["Q2_8576"] = "First things first! We need to figure out what Azuregos wrote in this ledger.\n\nYou say that he's told you to make an arcanite buoy and that this is the schematic? Strange that he would write this in Draconic. That old goat knows I can't read this nonsense.\n\nIf this is going to work, I'm going to need my scrying goggles, a five hundred pound chicken and volume II of 'Draconic for Dummies.' Not necessarily in that order."
Lang["Q1_8597"] = "Draconic for Dummies"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8597
Lang["Q2_8597"] = "Find Narain Soothfancy's book, buried on an island in the South Seas."
Lang["Q1_8599"] = "Love Song for Narain"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8599
Lang["Q2_8599"] = "Take Meridith's Love Letter to Narain Soothfancy in Tanaris."
Lang["Q1_8598"] = "rAnS0m"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8598
Lang["Q2_8598"] = "Return the Ransom Letter to Narain Soothfancy in Tanaris."
Lang["Q1_8606"] = "Decoy!"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8606
Lang["Q2_8606"] = "Narain Soothfancy in Tanaris wants you to travel to Winterspring and place the Bag of Gold at the drop off point documented by the booknappers."
Lang["Q1_8620"] = "The Only Prescription"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8620
Lang["Q2_8620"] = "Recover the 8 lost chapters of Draconic for Dummies and combine them with the Magical Book Binding and return the completed book of Draconic for Dummies: Volume II to Narain Soothfancy in Tanaris."
Lang["Q1_8584"] = "Never Ask Me About My Business"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8584
Lang["Q2_8584"] = "Narain Soothfancy in Tanaris wants you to speak with Dirge Quickcleave in Gadgetzan."
Lang["Q1_8585"] = "The Isle of Dread!"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8585
Lang["Q2_8585"] = "Recover Lakmaeran's Carcass and 20 Chimaerok Tenderloins for Dirge Quickcleave in Tanaris."
Lang["Q1_8586"] = "Dirge's Kickin' Chimaerok Chops"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8586
Lang["Q2_8586"] = "Dirge Quickcleave in Gadgetzan wants you to bring him 20 Goblin Rocket Fuel and 20 Deeprock Salt."
Lang["Q1_8587"] = "Return to Narain"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8587
Lang["Q2_8587"] = "Deliver the 500 Pound Chicken to Narain Soothfancy in Tanaris."
Lang["Q1_8577"] = "Stewvul, Ex-B.F.F."			-- https://www.thegeekcrusade-serveur.com/db/?quest=8577
Lang["Q2_8577"] = "Narain Soothfancy wants you to find his ex-best friend forever (BFF), Stewvul, and take back the scrying goggles that Stewvul stole from him."
Lang["Q1_8578"] = "Scrying Goggles? No Problem!"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8578
Lang["Q2_8578"] = "Find Narain's Scrying Goggles and return them to Narain Soothfancy in Tanaris."
Lang["Q1_8728"] = "The Good News and The Bad News"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8728
Lang["Q2_8728"] = "Narain Soothfancy in Tanaris wants you to bring him 20 Arcanite Bars, 10 Elementium Ore, 10 Azerothian Diamonds, and 10 Blue Sapphires."
Lang["Q1_8729"] = "The Wrath of Neptulon"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8729
Lang["Q2_8729"] = "Use the Arcanite Buoy at the Swirling Maelstrom at the Bay of Storms in Azshara."
Lang["Q1_8742"] = "The Might of Kalimdor"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8742
Lang["Q2_8742"] = "A thousand years has passed and just as it was fated, one stands before me. One who shall lead their people to a new age.\n\nThe Old God trembles. Oh yes, it fears your faith. Shatter the prophecy of C'Thun.\n\nIt knows you come, champion - and with you comes the might of Kalimdor. You have only to let me know when you are prepared and I shall grant you the Scepter of the Shifting Sands."
Lang["Q1_8745"] = "Treasure of the Timeless One"			-- https://www.thegeekcrusade-serveur.com/db/?quest=8745
Lang["Q2_8745"] = "Greetings, champion. I am Jonathan, keeper of the sacred gong and eternal watcher of the Bronze Flight.\n\nI have been empowered by the Timeless One himself to grant you an item of your choosing from his timeless treasure trove. May it aid you in your battles against C'Thun."


-- QUESTS - TBC
Lang["Q1_10755"] = "Entry Into the Citadel"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10755
Lang["Q2_10755"] = "Bring the Primed Key Mold to Nazgrel at Thrallmar in Hellfire Peninsula."
Lang["Q1_10756"] = "Grand Master Rohok"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10756
Lang["Q2_10756"] = "Bring the Primed Key Mold to Rohok in Thrallmar."
Lang["Q1_10757"] = "Rohok's Request"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10757
Lang["Q2_10757"] = "Bring 4 Fel Iron Bars, 2 Arcane Dust and 4 Motes of Fire to Rohok at Thrallmar in Hellfire Peninsula."
Lang["Q1_10758"] = "Hotter than Hell"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10758
Lang["Q2_10758"] = "Destroy a Fel Reaver in Hellfire Peninsula and plunge the Unfired Key Mold into its remains. Bring the Charred Key Mold to Rohok in Thrallmar."
Lang["Q1_10754"] = "Entry Into the Citadel"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10754
Lang["Q2_10754"] = "Bring the Primed Key Mold to Force Commander Danath at Honor Hold in Hellfire Peninsula."
Lang["Q1_10762"] = "Grand Master Dumphry"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10762
Lang["Q2_10762"] = "Bring the Primed Key Mold to Dumphry in Honor Hold."
Lang["Q1_10763"] = "Dumphry's Request"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10763
Lang["Q2_10763"] = "Bring 4 Fel Iron Bars, 2 Arcane Dust and 4 Motes of Fire to Dumphry at Honor Hold in Hellfire Peninsula."
Lang["Q1_10764"] = "Hotter than Hell"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10764
Lang["Q2_10764"] = "Destroy a Fel Reaver in Hellfire Peninsula and plunge the Unfired Key Mold into its remains. Bring the Charred Key Mold to Dumphry in Honor Hold."
Lang["Q1_10279"] = "To The Master's Lair"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10279
Lang["Q2_10279"] = "Speak to Andormu at the Caverns of Time."
Lang["Q1_10277"] = "The Caverns of Time"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10277
Lang["Q2_10277"] = "Andormu at the Caverns of Time has asked that you follow the Custodian of Time around the cavern."
Lang["Q1_10282"] = "Old Hillsbrad"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10282
Lang["Q2_10282"] = "Andormu at the Caverns of Time has asked that you venture to Old Hillsbrad and speak with Erozion."
Lang["Q1_10283"] = "Taretha's Diversion"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10283
Lang["Q2_10283"] = "Travel to Durnholde Keep and set 5 incendiary charges at the barrels located inside each of the internment lodges using the Pack of Incendiary Bombs given to you by Erozion."
Lang["Q1_10284"] = "Escape from Durnholde"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10284
Lang["Q2_10284"] = "When you are ready to proceed, let Thrall know. Follow Thrall out of Durnholde Keep and help him free Taretha and fulfill his destiny."
Lang["Q1_10285"] = "Return to Andormu"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10285
Lang["Q2_10285"] = "Return to the child Andormu at the Caverns of Time in the Tanaris desert."
Lang["Q1_10265"] = "Consortium Crystal Collection"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10265
Lang["Q2_10265"] = "Obtain an Arklon Crystal Artifact and return it to Nether-Stalker Khay'ji at Area 52 in the Netherstorm."
Lang["Q1_10262"] = "A Heap of Ethereals"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10262
Lang["Q2_10262"] = "Collect 10 Zaxxis Insignias and return them to Nether-Stalker Khay'ji at Area 52 in the Netherstorm."
Lang["Q1_10205"] = "Warp-Raider Nesaad"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10205
Lang["Q2_10205"] = "Kill Warp-Raider Nesaad and then return to Nether-Stalker Khay'ji at Area 52 in the Netherstorm."
Lang["Q1_10266"] = "Request for Assistance"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10266
Lang["Q2_10266"] = "Seek out and offer your services to Gahruj. He is located at the Midrealm Post inside Eco-Dome Midrealm in the Netherstorm."
Lang["Q1_10267"] = "Rightful Repossession"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10267
Lang["Q2_10267"] = "Collect 10 Boxes of Surveying Equipment and return them to Gahruj at the Midrealm Post inside Eco-Dome Midrealm in the Netherstorm."
Lang["Q1_10268"] = "An Audience with the Prince"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10268
Lang["Q2_10268"] = "Deliver the Surveying Equipment to the Image of Nexus-Prince Haramad at the Stormspire in the Netherstorm."
Lang["Q1_10269"] = "Triangulation Point One"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10269
Lang["Q2_10269"] = "Use the Triangulation Device to point your way toward the first triangulation point. Once you have found it, report the location to Dealer Hazzin at the Protectorate Watchpost on the Manaforge Ultris island in the Netherstorm."
Lang["Q1_10275"] = "Triangulation Point Two"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10275
Lang["Q2_10275"] = "Use the Triangulation Device to point your way toward the second triangulation point. Once you have found it, report the location to Wind Trader Tuluman at Tuluman's Landing, just on the other side of the bridge from the Manaforge Ara island in the Netherstorm."
Lang["Q1_10276"] = "Full Triangle"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10276
Lang["Q2_10276"] = "Recover the Ata'mal Crystal and deliver it to the Image of Nexus-Prince Haramad at the Stormspire in the Netherstorm."
Lang["Q1_10280"] = "Special Delivery to Shattrath City"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10280
Lang["Q2_10280"] = "Deliver the Ata'mal Crystal to A'dal on the Terrace of Light in Shattrath City."
Lang["Q1_10704"] = "How to Break Into the Arcatraz"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10704
Lang["Q2_10704"] = "A'dal has tasked you with the recovery of the Top and Bottom Shards of the Arcatraz Key. Return them to him, and he will fashion them into the Key to the Arcatraz for you."
Lang["Q1_9824"] = "Arcane Disturbances"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9824
Lang["Q2_9824"] = "Use the Violet Scrying Crystal near underground sources of water in the Master's Cellar and return to Archmage Alturus outside of Karazhan."
Lang["Q1_9825"] = "Restless Activity"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9825
Lang["Q2_9825"] = "Bring 10 Ghostly Essences to Archmage Alturus outside of Karazhan."
Lang["Q1_9826"] = "Contact from Dalaran"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9826
Lang["Q2_9826"] = "Bring Alturus's Report to Archmage Cedric in the outskirts of Dalaran."
Lang["Q1_9829"] = "Khadgar"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9829
Lang["Q2_9829"] = "Deliver Alturus's Report to Khadgar in Shattrath City in Terokkar Forest."
Lang["Q1_9831"] = "Entry Into Karazhan"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9831
Lang["Q2_9831"] = "Khadgar wants you to enter the Shadow Labyrinth at Auchindoun and retrieve the First Key Fragment from an Arcane Container hidden there."
Lang["Q1_9832"] = "The Second and Third Fragments"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9832
Lang["Q2_9832"] = "Obtain the Second Key Fragment from an Arcane Container inside Coilfang Reservoir and the Third Key Fragment from an Arcane Container inside Tempest Keep. Return to Khadgar in Shattrath City after you've completed this task."
Lang["Q1_9836"] = "The Master's Touch"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9836
Lang["Q2_9836"] = "Go into the Caverns of Time and convince Medivh to enable your Restored Apprentice's Key."
Lang["Q1_9837"] = "Return to Khadgar"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9837
Lang["Q2_9837"] = "Return to Khadgar in Shattrath City and show him the Master's Key."
Lang["Q1_9838"] = "The Violet Eye"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9838
Lang["Q2_9838"] = "Speak to Archmage Alturus outside Karazhan."
Lang["Q1_9630"] = "Medivh's Journal"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9630
Lang["Q2_9630"] = "Archmage Alturus at Deadwind Pass wants you go into Karazhan and speak to Wravien."
Lang["Q1_9638"] = "In Good Hands"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9638
Lang["Q2_9638"] = "Speak to Gradav at the Guardian's Library in Karazhan."
Lang["Q1_9639"] = "Kamsis"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9639
Lang["Q2_9639"] = "Speak to Kamsis at the Guardian's Library in Karazhan."
Lang["Q1_9640"] = "The Shade of Aran"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9640
Lang["Q2_9640"] = "Obtain Medivh's Journal and return to Kamsis at the Guardian's Library in Karazhan."
Lang["Q1_9645"] = "The Master's Terrace"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9645
Lang["Q2_9645"] = "Go to the Master's Terrace in Karazhan and read Medivh's Journal. Return to Archmage Alturus with Medivh's Journal after completing this task."
Lang["Q1_9680"] = "Digging Up the Past"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9680
Lang["Q2_9680"] = "Archmage Alturus wants you to go to the mountains south of Karazhan in Deadwind Pass and retrieve a Charred Bone Fragment.\n\nDon't be like Bel, get out of raid first."
Lang["Q1_9631"] = "A Colleague's Aid"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9631
Lang["Q2_9631"] = "Take the Charred Bone Fragment to Kalynna Lathred at Area 52 in Netherstorm."
Lang["Q1_9637"] = "Kalynna's Request"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9637
Lang["Q2_9637"] = "Kalynna Lathred wants you to retrieve the Tome of Dusk from Grand Warlock Nethekurse in the Shattered Halls of Hellfire Citadel and the Book of Forgotten Names from Darkweaver Syth in the Sethekk Halls in Auchindoun."
Lang["Q1_9644"] = "Nightbane"			-- https://www.thegeekcrusade-serveur.com/db/?quest=9644
Lang["Q2_9644"] = "Go to the Master's Terrace in Karazhan and use Kalynna's Urn to summon Nightbane. Retrieve the Faint Arcane Essence from Nightbane's corpse and bring it to Archmage Alturus."
Lang["Q1_10901|13431"] = "The Cudgel of Kar'desh"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10901|13431
Lang["Q2_10901|13431"] = "Skar'this the Heretic in the heroic Slave Pens of Coilfang Reservoir wants you to bring him the Earthen Signet and the Blazing Signet."
Lang["Q1_10900"] = "The Mark of Vashj"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10900
Lang["Q2_10900"] = ""
Lang["Q1_10681"] = "The Hand of Gul'dan"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10681
Lang["Q2_10681"] = "Speak with Earthmender Torlok at the Altar of Damnation in Shadowmoon Valley."
Lang["Q1_10458"] = "Enraged Spirits of Fire and Earth"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10458
Lang["Q2_10458"] = "Earthmender Torlok at the Altar of Damnation in Shadowmoon Valley wants you to use the Totem of Spirits to capture 8 Earthen Souls and 8 Fiery Souls."
Lang["Q1_10480"] = "Enraged Spirits of Water"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10480
Lang["Q2_10480"] = "Earthmender Torlok at the Altar of Damnation in Shadowmoon Valley wants you to use the Totem of Spirits to capture 5 Watery Souls."
Lang["Q1_10481"] = "Enraged Spirits of Air"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10481
Lang["Q2_10481"] = "Earthmender Torlok at the Altar of Damnation in Shadowmoon Valley wants you to use the Totem of Spirits to capture 10 Airy Souls."
Lang["Q1_10513"] = "Oronok Torn-heart"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10513
Lang["Q2_10513"] = "Seek out Oronok Torn-heart on the Shattered Shelf - north of Coilskar Cistern."
Lang["Q1_10514"] = "I Was A Lot Of Things..."			-- https://www.thegeekcrusade-serveur.com/db/?quest=10514
Lang["Q2_10514"] = "Oronok Torn-heart at Oronok's Farm in Shadowmoon Valley wants you to recover 10 Shadowmoon Tubers from the Shattered Plains."
Lang["Q1_10515"] = "A Lesson Learned"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10515
Lang["Q2_10515"] = "Oronok Torn-heart at Oronok's Farm in Shadowmoon Valley wants you to destroy 10 Ravenous Flayer Eggs on the Shattered Plains."
Lang["Q1_10519"] = "The Cipher of Damnation - Truth and History"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10519
Lang["Q2_10519"] = "Oronok Torn-heart at Oronok's Farm in Shadowmoon Valley wants you to listen to his story. Speak to Oronok to begin hearing his story."
Lang["Q1_10521"] = "Grom'tor, Son of Oronok"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10521
Lang["Q2_10521"] = "Find Grom'tor, Son of Oronok at Coilskar Point in Shadowmoon Valley."
Lang["Q1_10527"] = "Ar'tor, Son of Oronok"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10527
Lang["Q2_10527"] = "Find Ar'tor, Son of Oronok at Illidari Point in Shadowmoon Valley."
Lang["Q1_10546"] = "Borak, Son of Oronok"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10546
Lang["Q2_10546"] = "Find Borak, Son of Oronok near Eclipse Point in Shadowmoon Valley."
Lang["Q1_10522"] = "The Cipher of Damnation - Grom'tor's Charge"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10522
Lang["Q2_10522"] = "Grom'tor, Son of Oronok at Coilskar Point in Shadowmoon Valley wants you to recover the First Fragment of the Cipher of Damnation."
Lang["Q1_10528"] = "Demonic Crystal Prisons"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10528
Lang["Q2_10528"] = "Seek out and slay Painmistress Gabrissa at Illidari Point and return to the corpse of Ar'tor, Son of Oronok with the Crystalline Key."
Lang["Q1_10547"] = "Of Thistleheads and Eggs..."			-- https://www.thegeekcrusade-serveur.com/db/?quest=10547
Lang["Q2_10547"] = "Borak, Son of Oronok at the bridge north of Eclipse Point wants you to find a Rotten Arakkoa Egg and deliver it to Tobias the Filth Gorger in Shattrath City, located in northwest Terokkar Forest."
Lang["Q1_10523"] = "The Cipher of Damnation - The First Fragment Recovered"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10523
Lang["Q2_10523"] = "Take Grom'tor's Lockbox to Oronok Torn-heart at Oronok's Farm in Shadowmoon Valley."
Lang["Q1_10537"] = "Lohn'goron, Bow of the Torn-heart"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10537
Lang["Q2_10537"] = "The Spirit of Ar'tor at Illidari Point in Shadowmoon Valley wants you to recover Lohn'goron, Bow of the Torn-heart from the demons of the area."
Lang["Q1_10550"] = "The Bundle of Bloodthistle"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10550
Lang["Q2_10550"] = "Take the Bundle of Bloodthistle back to Borak, Son of Oronok at the bridge near Eclipse Point in Shadowmoon Valley."
Lang["Q1_10540"] = "The Cipher of Damnation - Ar'tor's Charge"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10540
Lang["Q2_10540"] = "The Spirit of Ar'tor at Illidari Point in Shadowmoon Valley wants you to recover the Second Fragment of the Cipher of Damnation from Veneratus the Many.\n\nCreatures attacked or damaged by the Spirit Hunter will not yield loot or experience."
Lang["Q1_10570"] = "To Catch A Thistlehead"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10570
Lang["Q2_10570"] = "Borak, Son of Oronok at the bridge near Eclipse Point in Shadowmoon Valley wants you to recover the Stormrage Missive."
Lang["Q1_10576"] = "The Shadowmoon Shuffle"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10576
Lang["Q2_10576"] = "Borak, Son of Oronok at the bridge near Eclipse Point in Shadowmoon Valley wants you to recover 6 pieces of Eclipsion Armor."
Lang["Q1_10577"] = "What Illidan Wants, Illidan Gets..."			-- https://www.thegeekcrusade-serveur.com/db/?quest=10577
Lang["Q2_10577"] = "Borak, Son of Oronok at the bridge near Eclipse Point in Shadowmoon Valley wants you to Deliver Illidan's Message to Grand Commander Ruusk at Eclipse Point."
Lang["Q1_10578"] = "The Cipher of Damnation - Borak's Charge"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10578
Lang["Q2_10578"] = "Borak, Son of Oronok at the bridge near Eclipse Point in Shadowmoon Valley wants you to recover the Third Part of the Cipher of Damnation from Ruul the Darkener."
Lang["Q1_10541"] = "The Cipher of Damnation - The Second Fragment Recovered"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10541
Lang["Q2_10541"] = "Take Ar'tor's Lockbox to Oronok Torn-heart at Oronok's Farm in Shadowmoon Valley."
Lang["Q1_10579"] = "The Cipher of Damnation - The Third Fragment Recovered"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10579
Lang["Q2_10579"] = "Take Borak's Lockbox to Oronok Torn-heart at Oronok's Farm in Shadowmoon Valley."
Lang["Q1_10588"] = "The Cipher of Damnation"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10588
Lang["Q2_10588"] = "Use the Cipher of Damnation at the Altar of Damnation to summon Cyrukh the Firelord.\n\nDestroy Cyrukh the Firelord and then speak with Earthmender Torlok, also found at the Altar of Damnation."
Lang["Q1_10883"] = "The Tempest Key"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10883
Lang["Q2_10883"] = "Speak with A'dal in Shattrath City."
Lang["Q1_10884"] = "Trial of the Naaru: Mercy"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10884
Lang["Q2_10884"] = "A'dal in Shattrath City wants you to recover the Unused Axe of the Executioner from the Shattered Halls of Hellfire Citadel.\n\nThis quest must be completed in Heroic dungeon difficulty."
Lang["Q1_10885"] = "Trial of the Naaru: Strength"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10885
Lang["Q2_10885"] = "A'dal in Shattrath City wants you to recover Kalithresh's Trident and Murmur's Essence.\n\nThis quest must be completed in Heroic dungeon difficulty."
Lang["Q1_10886"] = "Trial of the Naaru: Tenacity"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10886
Lang["Q2_10886"] = "A'dal in Shattrath City wants you to rescue Millhouse Manastorm from the Arcatraz of Tempest Keep.\n\nThis quest must be completed in Heroic dungeon difficulty."
Lang["Q1_10888|13430"] = "Trial of the Naaru: Magtheridon"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10888|13430
Lang["Q2_10888|13430"] = "A'dal in Shattrath City wants you to slay Magtheridon."
Lang["Q1_10680"] = "The Hand of Gul'dan"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10680
Lang["Q2_10680"] = "Speak with Earthmender Torlok at the Altar of Damnation in Shadowmoon Valley."
Lang["Q1_10445|13432"] = "The Vials of Eternity"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10445|13432
Lang["Q2_10445|13432"] = "Soridormi at Caverns of Time wants you to retrieve Vashj's Vial Remnant from Lady Vashj at Coilfang Reservoir and Kael's Vial Remnant from Kael'thas Sunstrider at Tempest Keep."
Lang["Q1_10568"] = "Tablets of Baa'ri"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10568
Lang["Q2_10568"] = "Anchorite Ceyla at the Altar of Sha'tar wants you to collect 12 Baa'ri Tablets from the ground and from Ashtongue Workers at the Ruins of Baa'ri.\n\nCompleting quests with the Aldor will cause your Scryers reputation level to decrease."
Lang["Q1_10683"] = "Tablets of Baa'ri"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10683
Lang["Q2_10683"] = "Arcanist Thelis at the Sanctum of the Stars wants you to collect 12 Baa'ri Tablets from the ground and from Ashtongue Workers at the Ruins of Baa'ri.\n\nCompleting quests with the Scryers will cause your Aldor reputation level to decrease."
Lang["Q1_10571"] = "Oronu the Elder"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10571
Lang["Q2_10571"] = "Anchorite Ceyla at the Altar of Sha'tar wants you to obtain the Orders from Akama from Oronu the Elder at the Ruins of Baa'ri.\n\nCompleting quests for the Aldor will cause your Scryers reputation level to decrease."
Lang["Q1_10684"] = "Oronu the Elder"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10684
Lang["Q2_10684"] = "Arcanist Thelis at the Sanctum of the Stars wants you to obtain the Orders from Akama from Oronu the Elder at the Ruins of Baa'ri.\n\nCompleting quests for the Scryers will cause your Aldor reputation level to decrease."
Lang["Q1_10574"] = "The Ashtongue Corruptors"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10574
Lang["Q2_10574"] = "Obtain the four medallion fragments from Haalum, Eykenen, Lakaan and Uylaru and return to Anchorite Ceyla at the Altar of Sha'tar in Shadowmoon Valley.\n\nPerforming quests for the Aldor will cause your Scryers reputation level to decrease."
Lang["Q1_10685"] = "The Ashtongue Corruptors"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10685
Lang["Q2_10685"] = "Obtain the four medallion fragments from Haalum, Eykenen, Lakaan and Uylaru and return to Arcanist Thelis at the Sanctum of the Stars in Shadowmoon Valley.\n\nPerforming quests for the Scryers will cause your Aldor reputation level to decrease."
Lang["Q1_10575"] = "The Warden's Cage"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10575
Lang["Q2_10575"] = "Anchorite Ceyla wants you to enter the Warden's Cage, south of the Ruins of Baa'ri and interrogate Sanoru on Akama's whereabouts.\n\nCompleting quests for the Aldor will cause your Scryers reputation to decrease."
Lang["Q1_10686"] = "The Warden's Cage"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10686
Lang["Q2_10686"] = "Arcanist Thelis wants you to enter the Warden's Cage, south of the Ruins of Baa'ri and interrogate Sanoru on Akama's whereabouts.\n\nCompleting quests for the Scryers will cause your Aldor reputation to decrease."
Lang["Q1_10622"] = "Proof of Allegiance"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10622
Lang["Q2_10622"] = "Slay Zandras at the Warden's Cage in Shadowmoon Valley and return to Sanoru."
Lang["Q1_10628"] = "Akama"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10628
Lang["Q2_10628"] = "Speak to Akama inside the hidden chamber in the Warden's Cage."
Lang["Q1_10705"] = "Seer Udalo"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10705
Lang["Q2_10705"] = "Find Seer Udalo inside the Arcatraz in Tempest Keep."
Lang["Q1_10706"] = "A Mysterious Portent"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10706
Lang["Q2_10706"] = "Return to Akama at the Warden's Cage in Shadowmoon Valley."
Lang["Q1_10707"] = "The Ata'mal Terrace"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10707
Lang["Q2_10707"] = "Go to the top of the Atam'al Terrace in Shadowmoon Valley and obtain the Heart of Fury. Return to Akama at the Warden's Cage in Shadowmoon Valley when you've completed this task."
Lang["Q1_10708"] = "Akama's Promise"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10708
Lang["Q2_10708"] = "Bring the Medallion of Karabor to A'dal in Shattrath City."
Lang["Q1_10944"] = "The Secret Compromised"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10944
Lang["Q2_10944"] = "Travel to the Warden's Cage in Shadowmoon Valley and speak to Akama."
Lang["Q1_10946"] = "Ruse of the Ashtongue"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10946
Lang["Q2_10946"] = "Travel into Tempest Keep and slay Al'ar while wearing the Ashtongue Cowl. Return to Akama in Shadowmoon Valley once you've completed this task."
Lang["Q1_10947"] = "An Artifact From the Past"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10947
Lang["Q2_10947"] = "Go to the Caverns of Time in Tanaris and gain access to the Battle of Mount Hyjal. Once inside, defeat Rage Winterchill and bring the Time-Phased Phylactery to Akama in Shadowmoon Valley."
Lang["Q1_10948"] = "The Hostage Soul"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10948
Lang["Q2_10948"] = "Travel to Shattrath City to tell A'dal about Akama's request."
Lang["Q1_10949"] = "Entry Into the Black Temple"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10949
Lang["Q2_10949"] = "Travel to the entrance to the Black Temple in Shadowmoon Valley and speak to Xi'ri."
Lang["Q1_10985|13429"] = "A Distraction for Akama"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10985|13429
Lang["Q2_10985|13429"] = "Ensure that Akama and Maiev enter the Black Temple in Shadowmoon Valley after Xi'ri's forces create a distraction."
--v243
Lang["Q1_10984"] = "Speak with the Ogre"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10984
Lang["Q2_10984"] = "Speak with the Ogre, Grok, in the Lower City section of Shattrath City."
Lang["Q1_10983"] = "Mog'dorg the Wizened"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10983
Lang["Q2_10983"] = "Visit Mog'dorg the Wizened atop one of the towers just outside the Circle of Blood in the Blade's Edge Mountains."
Lang["Q1_10995"] = "Grulloc Has Two Skulls"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10995
Lang["Q2_10995"] = "Retrieve Grulloc's Dragon Skull and deliver it to Mog'dorg the Wizened atop the tower at the Circle of Blood in the Blade's Edge Mountains."
Lang["Q1_10996"] = "Maggoc's Treasure Chest"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10996
Lang["Q2_10996"] = "Retrieve Maggoc's Treasure Chest and deliver it to Mog'dorg the Wizened atop the tower at the Circle of Blood in the Blade's Edge Mountains."
Lang["Q1_10997"] = "Even Gronn Have Standards"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10997
Lang["Q2_10997"] = "Retrieve Slaag's Standard and deliver it to Mog'dorg the Wizened atop the tower at the Circle of Blood in the Blade's Edge Mountains."
Lang["Q1_10998"] = "Grim(oire) Business"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10998
Lang["Q2_10998"] = "You must retrieve Vim'gol's Vile Grimoire. Deliver it to Mog'dorg the Wizened atop the tower at the Circle of Blood in the Blade's Edge Mountains."
Lang["Q1_11000"] = "Into the Soulgrinder"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11000
Lang["Q2_11000"] = "Retrieve Skulloc's Soul and deliver it to Mog'dorg the Wizened atop the tower at the Circle of Blood in the Blade's Edge Mountains."
Lang["Q1_11022"] = "Speak with Mog'dorg"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11022
Lang["Q2_11022"] = "Speak with Mog'dorg the Wizened. He stands atop the tower on the east side of the Circle of Blood in the Blade's Edge Mountains."
Lang["Q1_11009"] = "Ogre Heaven"			-- https://www.thegeekcrusade-serveur.com/db/?quest=11009
Lang["Q2_11009"] = "Mog'dorg the Wizened has asked you to speak with Chu'a'lor at Ogri'la in the Blade's Edge Mountains."
--v244
Lang["Q1_10804"] = "Kindness"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10804
Lang["Q2_10804"] = "Mordenai at Netherwing Fields in Shadowmoon Valley wants you to feed 8 Mature Netherwing Drakes."
Lang["Q1_10811"] = "Seek Out Neltharaku"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10811
Lang["Q2_10811"] = "Seek out Neltharaku, patron of the Netherwing Dragonflight."
Lang["Q1_10814"] = "Neltharaku's Tale"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10814
Lang["Q2_10814"] = "Speak with Neltharaku and listen to his story."
Lang["Q1_10836"] = "Infiltrating Dragonmaw Fortress"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10836
Lang["Q2_10836"] = "Neltharaku, flying high above Netherwing Fields in Shadowmoon Valley, wants you to slay 15 Dragonmaw Orcs."
Lang["Q1_10837"] = "To Netherwing Ledge!"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10837
Lang["Q2_10837"] = "Neltharaku, flying high above Netherwing Fields in Shadowmoon Valley, wants you to collect 12 Nethervine Crystals from Netherwing Ledge."
Lang["Q1_10854"] = "The Force of Neltharaku"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10854
Lang["Q2_10854"] = "Neltharaku, flying high above Netherwing Fields in Shadowmoon Valley, wants you to free 5 Enslaved Netherwing Drakes."
Lang["Q1_10858"] = "Karynaku"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10858
Lang["Q2_10858"] = "Seek out Karynaku at Dragonmaw Fortress."
Lang["Q1_10866"] = "Zuluhed the Whacked"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10866
Lang["Q2_10866"] = "Kill Zuluhed the Whacked and recover Zuluhed's Key. Use Zuluhed's Key on Zuluhed's Chains to free Karynaku."
Lang["Q1_10870"] = "Ally of the Netherwing"			-- https://www.thegeekcrusade-serveur.com/db/?quest=10870
Lang["Q2_10870"] = "Let Karynaku return you to Mordenai in the Netherwing Fields."
--v247
Lang["Q1_3801"] = "Dark Iron Legacy"			-- https://www.thegeekcrusade-serveur.com/db/?quest=3801
Lang["Q2_3801"] = "Speak with Franclorn Forgewright if you are interested in obtaining a key to the city major."
Lang["Q1_3802"] = "Dark Iron Legacy"			-- https://www.thegeekcrusade-serveur.com/db/?quest=3802
Lang["Q2_3802"] = "Slay Fineous Darkvire and recover the great hammer, Ironfel. Take Ironfel to the Shrine of Thaurissan and place it on the statue of Franclorn Forgewright."
Lang["Q1_5096"] = "Scarlet Diversions"
Lang["Q2_5096"] = "Proceed to the Scarlet Crusade's base camp between Felstone Field and Dalson's Tears and destroy their command tent."
Lang["Q1_5098"] = "All Along the Watchtowers"
Lang["Q2_5098"] = "Using the Beacon Torch, mark each tower in Andorhal; you will need to stand in the doorway of the tower to successfully mark it."
Lang["Q1_838"] = "Scholomance"
Lang["Q2_838"] = "Speak with Apothecary Dithers at the Bulwark, Western Plaguelands."
Lang["Q1_964"] = "Skeletal Fragments"
Lang["Q2_964"] = "Bring 15 Skeletal Fragments to Apothecary Dithers at the Bulwark, Western Plaguelands."
Lang["Q1_5514"] = "Mold Rhymes With..."
Lang["Q2_5514"] = "Bring the Imbued Skeletal Fragments and 15 gold coins to Krinkle Goodsteel in Gadgetzan."
Lang["Q1_5802"] = "Fire Plume Forged"
Lang["Q2_5802"] = "Take the Skeleton Key Mold and 2 Thorium Bars to the top of Fire Plume Ridge in Un'Goro Crater. Use the Skeleton Key Mold by the lava lake to forge the Unfinished Skeleton Key."
Lang["Q1_5804"] = "Araj's Scarab"
Lang["Q2_5804"] = "Destroy Araj the Summoner and bring Araj's Scarab to Apothecary Dithers at the Bulwark, Western Plaguelands."
Lang["Q1_5511"] = "The Key to Scholomance"
Lang["Q2_5511"] = "Well, here you are - the completed Skeleton Key.  I am certain as I can be that this key will allow you within the confines of the Scholomance. "
Lang["Q1_5092"] = "Clear the Way"
Lang["Q2_5092"] = "Kill 10 Skeletal Flayers and 10 Slavering Ghouls in Sorrow Hill."
Lang["Q1_5097"] = "All Along the Watchtowers"
Lang["Q2_5097"] = "Using the Beacon Torch, mark each tower in Andorhal; you will need to stand in the doorway of the tower to successfully mark it."
Lang["Q1_5533"] = "Scholomance"
Lang["Q2_5533"] = "Speak with Alchemist Arbington at Chillwind Point, Western Plaguelands."
Lang["Q1_5537"] = "Skeletal Fragments"
Lang["Q2_5537"] = "Bring 15 Skeletal Fragments to Alchemist Arbington at Chillwind Point, Western Plaguelands."
Lang["Q1_5538"] = "Mold Rhymes With..."
Lang["Q2_5538"] = "Bring the Imbued Skeletal Fragments and 15 gold coins to Krinkle Goodsteel in Gadgetzan."
Lang["Q1_5801"] = "Fire Plume Forged"
Lang["Q2_5801"] = "Take the Skeleton Key Mold and 2 Thorium Bars to the top of Fire Plume Ridge in Un'Goro Crater. Use the Skeleton Key Mold by the lava lake to forge the Unfinished Skeleton Key."
Lang["Q1_5803"] = "Araj's Scarab"
Lang["Q2_5803"] = "Destroy Araj the Summoner and bring Araj's Scarab to Alchemist Arbington at Chillwind Point, Western Plaguelands."
Lang["Q1_5505"] = "The Key to Scholomance"
Lang["Q2_5505"] = "Well, here you are - the completed Skeleton Key.  I am certain as I can be that this key will allow you within the confines of the Scholomance. "
--v250
Lang["Q1_6804"] = "Poisoned Water"
Lang["Q2_6804"] = "Use the Aspect of Neptulon on poisoned elementals of Eastern Plaguelands. Bring 12 Discordant Bracers and the Aspect of Neptulon to Duke Hydraxis in Azshara."
Lang["Q1_6805"] = "Stormers and Rumblers"
Lang["Q2_6805"] = "Kill 15 Dust Stormers and 15 Desert Rumbers and then return to Duke Hydraxis in Azshara."
Lang["Q1_6821"] = "Eye of the Emberseer"
Lang["Q2_6821"] = "Bring the Eye of the Emberseer to Duke Hydraxis in Azshara."
Lang["Q1_6822"] = "The Molten Core"
Lang["Q2_6822"] = "Kill 1 Fire Lord, 1 Molten Giant, 1 Ancient Core Hound and 1 Lava Surger, then return to Duke Hydraxis in Azshara."
Lang["Q1_6823"] = "Agent of Hydraxis"
Lang["Q2_6823"] = "Earn an Honored faction with the Hydraxian Waterlords, then talk to Duke Hydraxis in Azshara."
Lang["Q1_6824"] = "Hands of the Enemy"
Lang["Q2_6824"] = "Bring the Hands of Lucifron, Sulfuron, Gehennas and Shazzrah to Duke Hydraxis in Azshara."
Lang["Q1_7486"] = "A Hero's Reward"
Lang["Q2_7486"] = "Claim your reward from Hydraxis' Coffer."
--v254
Lang["Q1_11481"] = "Crisis at the Sunwell"
Lang["Q2_11481"] = "Adyen the Lightwarden on the Aldor Rise in Shattrath City has requested that you travel to Sunwell Plateau and speak with Larethor."
Lang["Q1_11488"] = "Magisters' Terrace"
Lang["Q2_11488"] = "Exarch Larethor at the Shattered Sun Staging Area wants you to search Magisters' Terrace and find Tyrith, a blood elf spy."
Lang["Q1_11490"] = "The Scryer's Scryer"
Lang["Q2_11490"] = "Tyrith wants you to use the orb on the balcony in Magisters' Terrace."
Lang["Q1_11492"] = "Hard to Kill"
Lang["Q2_11492"] = "Kalecgos has asked you to defeat Kael'thas in Magisters' Terrace. You are to take Kael's head and report back to Larethor at the Shattered Sun Staging Area."


--WOTLK QUESTS
-- The ids are Q1_<QuestId> and Q2_<QuestId>
-- Q1 is just the title of the quest
-- Q2 is the description/synopsis, with some helpful comments in between \n\n|cff33ff99 and |r--WOTLK
Lang["Q1_12892"] = "It's All Fun and Games"
Lang["Q2_12892"] = "Destroy The Ocular and then report to Baron Sliver at The Shadow Vault."
Lang["Q1_12887"] = "It's All Fun and Games"
Lang["Q2_12887"] = "Destroy The Ocular and then report to Baron Sliver at The Shadow Vault."
Lang["Q1_12891"] = "I Have an Idea, But First..."
Lang["Q2_12891"] = "Baron Sliver at The Shadow Vault has asked you to collect a Cultist Rod, an Abomination Hook, a Geist Rope, and 5 Scourge Essences.\n\n|cff33ff99They roam around the platforms surrounding the Vault.|r"
Lang["Q1_12893"] = "Free Your Mind"
Lang["Q2_12893"] = "Baron Sliver at the Shadow Vault wants you to use the Sovereign Rod on the corpses of Vile, Lady Nightswood, and The Leaper."
Lang["Q1_12897"] = "If He Cannot Be Turned"
Lang["Q2_12897"] = "Defeat General Lightsbane and then report your success back to Koltira Deathweaver aboard the gunship, Orgrim's Hammer."
Lang["Q1_12896"] = "If He Cannot Be Turned"
Lang["Q2_12896"] = "Defeat General Lightsbane and then report your success back to Thassarian aboard the gunship, The Skybreaker."
Lang["Q1_12899"] = "The Shadow Vault"
Lang["Q2_12899"] = "Report back to Baron Sliver at The Shadow Vault."
Lang["Q1_12898"] = "The Shadow Vault"
Lang["Q2_12898"] = "Report back to Baron Sliver at The Shadow Vault."
Lang["Q1_11978"] = "Into the Fold"
Lang["Q2_11978"] = "Emissary Brighthoof at the Westwind Refugee Camp in the Dragonblight wants you to recover 10 Horde Armaments."
Lang["Q1_11983"] = "Blood Oath of the Horde"
Lang["Q2_11983"] = "Speak to the taunka at Westwind Refugee Camp and make 5 of them pledge their allegiance to the Horde."
Lang["Q1_12008"] = "Agmar's Hammer"
Lang["Q2_12008"] = "Travel to Agmar's Hammer in the Dragonblight and speak to Overlord Agmar.\n\n|cff33ff99He is located in the hold at (38.1, 46.3).|r"
Lang["Q1_12034"] = "Victory Nears..."
Lang["Q2_12034"] = "Speak to Senior Sergeant Juktok at Agmar's Hammer.\n\n|cff33ff99In the middle of the camp, at (36.6, 46.6).|r"
Lang["Q1_12036"] = "From the Depths of Azjol-Nerub"
Lang["Q2_12036"] = "Explore the Pit of Narjun and return with your findings to Senior Sergeant Juktok at Agmar's Hammer.\n\n|cff33ff99Entrance is to the west of Agmar's Hammer, at (26.2, 49.6). Drop down the hole to get credit.|r"
Lang["Q1_12053"] = "The Might of the Horde"
Lang["Q2_12053"] = "Senior Sergeant Juktok at Agmar's Hammer in the Dragonblight wants you to use the Warsong Battle Standard at Icemist Village and defend it against attackers.\n\n|cff33ff99You can plant the banner around (25.2, 24.8).|r"
Lang["Q1_12071"] = "Attack by Air!"
Lang["Q2_12071"] = "Speak with Valnok Windrager at Agmar's Hammer."
Lang["Q1_12072"] = "Blightbeasts be Damned!"
Lang["Q2_12072"] = "Use Valnok's Flare Gun to call down a Kor'kron War Rider at Icemist Village. Mount the Kor'kron War Rider and then use it to kill 25 Anub'ar Blightbeasts!\n\n|cff33ff99There a few under the village near the lower waterfall, and quite some more near the large waterfalls.|r"
Lang["Q1_12063"] = "Strength of Icemist"
Lang["Q2_12063"] = "Find Banthok Icemist at Icemist Village.\n\n|cff33ff99He's at water level, in a little cove at (22.7, 41.6).|r"
Lang["Q1_12064"] = "Chains of the Anub'ar"
Lang["Q2_12064"] = "Banthok Icemist at Icemist Village in the Dragonblight has asked that you bring him Anok'ra's Key Fragment, Tivax's Key Fragment and Sinok's Key Fragment.\n\n|cff33ff99They are in the buildings. Tivax is at (26.7, 39.0), Sinok is at (24.3, 44.2) and Anok'ra is below Sinok at (24.9, 43.9).|r"
Lang["Q1_12069"] = "Return of the High Chief"
Lang["Q2_12069"] = "Free High Chief Icemist using the Anub'ar Prison Key and assist him in defeating Under-king Anub'et'kan.\n\n|cff33ff99The High Chief is in a magic cage, at (25.3, 40.9).|r"
Lang["Q1_12140"] = "All Hail Roanauk!"
Lang["Q2_12140"] = "Seek out Roanauk Icemist at Agmar's Hammer and initiate him as a member and leader of the Horde forces."
Lang["Q1_12189"] = "Imbeciles Abound!"
Lang["Q2_12189"] = "Travel to Venomspite in Dragonblight and speak with Chief Plaguebringer Middleton.\n\n|cff33ff99He is in the inside the building, at (77.7, 62.8).|r"
Lang["Q1_12188"] = "The Forsaken Blight and You: How Not to Die"
Lang["Q2_12188"] = "Chief Plaguebringer Middleton at Venomspite in Dragonblight wants you to bring him 10 Ectoplasmic Residue."
Lang["Q1_12200"] = "Emerald Dragon Tears"
Lang["Q2_12200"] = "Chief Plaguebringer Middleton at Venomspite in Dragonblight wants you to collect 8 Emerald Dragon Tears.\n\n|cff33ff99They look like green gems on the ground around (63.5, 71.9).|r"
Lang["Q1_12218"] = "Spread the Good Word"
Lang["Q2_12218"] = "Chief Plaguebringer Middleton at Venomspite in Dragonblight wants you to use the Forsaken Blight Spreader's Blight Bomb to destroy 30 Hungering Dead on the outskirts of the Carrion Fields."
Lang["Q1_12221"] = "The Forsaken Blight"
Lang["Q2_12221"] = "Deliver The Forsaken Blight to Doctor Sintar Malefious at Agmar's Hammer."
Lang["Q1_12224"] = "The Kor'kron Vanguard!"
Lang["Q2_12224"] = "Report to Saurfang the Younger at the Kor'kron Vanguard.\n\n|cff33ff99He is located at (40.7, 18.2).|r"
Lang["Q1_12496"] = "Audience With The Dragon Queen"
Lang["Q2_12496"] = "Seek out Alexstrasza the Life-Binder at Wyrmrest Temple in Dragonblight.\n\n|cff33ff99Talk to Tariolstrasz (57.9, 54.2) and ask to go to the top of the tower. She's there, in humanoid form (59.8, 54.7).|r"
Lang["Q1_12497"] = "Galakrond and the Scourge"
Lang["Q2_12497"] = "Speak with Torastrasza at Wyrmrest Temple in Dragonblight."
Lang["Q1_12498"] = "On Ruby Wings"
Lang["Q2_12498"] = "Destroy 30 Wastes Scavengers and recover the Scythe of Antiok. Return to Alexstrasza the Life-Binder at Wyrmrest Temple should you complete this task.\n\n|cff33ff99You can find them north, at (56.8, 33.3). Don't forget the Scythe, at (54.6, 31.4).|r"
Lang["Q1_12500"] = "Return To Angrathar"
Lang["Q2_12500"] = "Speak with Saurfang the Younger at the Kor'kron Vangaurd and tell him of your victory over the Scourge.\n\n|cff33ff99Enjoy the cutscene! :-)|r"
Lang["Q1_13242"] = "Darkness Stirs"
Lang["Q2_13242"] = "Gather Saurfang's Battle Armor from the field of battle and return it to High Overlord Saurfang at Warsong Hold in Borean Tundra."
Lang["Q1_13257"] = "Herald of War"
Lang["Q2_13257"] = "Report to Thrall at Grommash Hold in Orgrimmar.\n\n|cff33ff99Enjoy the RP :-)|r"
Lang["Q1_13266"] = "A Life Without Regret"
Lang["Q2_13266"] = "Take the portal to Undercity located in Grommash Hold and report to Vol'jin."
Lang["Q1_13267"] = "The Battle For The Undercity"
Lang["Q2_13267"] = "Assist Thrall and Sylvanas in retaking the Undercity for the Horde."
Lang["Q1_12235"] = "Naxxramas and the Fall of Wintergarde"
Lang["Q2_12235"] = "Speak with Gryphon Commander Urik at the gryphon station in Wintergarde Keep."
Lang["Q1_12237"] = "Flight of the Wintergarde Defender"
Lang["Q2_12237"] = "Rescue 10 Helpless Wintergarde Villagers and return to Gryphon Commander Urik at Wintergarde Keep."
Lang["Q1_12251"] = "Return to the High Commander"
Lang["Q2_12251"] = "Speak with High Commander Halford Wyrmbane at Wintergarde Keep in Dragonblight."
Lang["Q1_12253"] = "Rescue from Town Square"
Lang["Q2_12253"] = "High Commander Halford Wyrmbane at Wintergarde Keep in Dragonblight wants you to rescue 6 Trapped Wintergarde Villagers."
Lang["Q1_12309"] = "Find Durkon!"
Lang["Q2_12309"] = "Seek out Cavalier Durkon at the Wintergarde Crypt in Dragonblight.\n\n|cff33ff99He's standing just outside the Crypt, at (79.0, 53.2).|r"
Lang["Q1_12311"] = "The Noble's Crypt"
Lang["Q2_12311"] = "Cavalier Durkon at Wintergarde Keep wants you to slay Necrolord Amarion.\n\n|cff33ff99All the way down the crypt, at the very bottom.|r"
Lang["Q1_12275"] = "The Demo-gnome"
Lang["Q2_12275"] = "Speak with Siege Engineer Quarterflash at Wintergarde Keep in Dragonblight.\n\n|cff33ff99He's near the gryphon master, at (77.8, 50.3).|r"
Lang["Q1_12276"] = "The Search for Slinkin"
Lang["Q2_12276"] = "Find Slinkin the Demo-gnome in Wintergarde Mine. Use Quarterflash's Homing Bot if you need help finding the mine.\n\n|cff33ff99The robot is quite quick, mount up if you need to follow it.\nEnter the mine via the bottom entrance and keep right to find the body at (81.5, 42.2).|r"
Lang["Q1_12277"] = "Leave Nothing to Chance"
Lang["Q2_12277"] = "Retrieve a Wintergarde Mine Bomb and use it to blow up the Upper Wintergarde Mine Shaft and the Lower Wintergarde Mine Shaft. Report back to Siege Engineer Quarterflash at Wintergarde Keep in Dragonblight when you have completed this task.\n\n|cff33ff99Coming from the corpse, take a right to find the explosives at (80.7, 41.3).|r"
Lang["Q1_12325"] = "Into Hostile Territory"
Lang["Q2_12325"] = "Speak with Gryphon Commander Urik to secure a ride to Thorson's Post. Report to Duke August Foehammer when you arrive at Thorson's Post in Dragonblight.\n\n|cff33ff99Don't actually talk to the Gryphon Master, instead jump onto a gryphon vehicle.|r"
Lang["Q1_12312"] = "Secrets of the Scourge"
Lang["Q2_12312"] = "Deliver the Flesh-bound Tome to Cavalier Durkon at Wintergarde Keep in Dragonblight."
Lang["Q1_12319"] = "Mystery of the Tome"
Lang["Q2_12319"] = "Take the Flesh-bound Tome to High Commander Halford Wyrmbane at Wintergarde Keep in Dragonblight."
Lang["Q1_12320"] = "Understanding the Language of Death"
Lang["Q2_12320"] = "Take the Flesh-bound Tome to Inquisitor Hallard at the Wintergarde Keep prison.\n\n|cff33ff99The prison is the big barracks building up the road from Halford.\nIn the courtyard take the stairs going down (Behind Gluth). Hallard is at (76.7, 47.4).|r"
Lang["Q1_12321"] = "A Righteous Sermon"
Lang["Q2_12321"] = "Wait for Inquisitor Hallard to finish his Righteous Sermon and return to High Commander Halford Wyrmbane at Wintergarde Keep in Dragonblight with the information you uncover."
Lang["Q1_12272"] = "The Bleeding Ore"
Lang["Q2_12272"] = "Siege Engineer Quarterflash at Wintergarde Keep in Dragonblight wants you to recover 10 samples of Strange Ore from Wintergarde Mine."
Lang["Q1_12281"] = "Understanding the Scourge War Machine"
Lang["Q2_12281"] = "Deliver Quarterflash's Package to High Commander Halford Wyrmbane at Wintergarde Keep."
Lang["Q1_12326"] = "Steamtank Surprise"
Lang["Q2_12326"] = "Use an Alliance Steam Tank to destroy 6 Plague Wagons and deliver the 7th Legion Elites to Wintergarde Mausoleum. Speak with Ambo Cash inside the Wintergarde Mausoleum in Dragonblight should you succeed.\n\n|cff33ff99The Mausoleum is at (85.9, 50.8), Ambo Cash is waiting inside.|r"
Lang["Q1_12455"] = "Scattered To The Wind"
Lang["Q2_12455"] = "Ambo Cash at the Wintergarde Mausoleum in Dragonblight wants you to recover 8 Wintergarde Munitions.\n\n|cff33ff99They are outside the Mausoleum, scattered in the field around.|r"
Lang["Q1_12457"] = "The Chain Gun And You"
Lang["Q2_12457"] = "Ambo Cash at the Wintergarde Mausoleum in Dragonblight wants you to save 8 Injured 7th Legion Soldiers.\n\n|cff33ff99Soldiers always spawn at the back of the room, so make sure you clear that out with the gun.|r"
Lang["Q1_12463"] = "Plunderbeard Must Be Found!"
Lang["Q2_12463"] = "Ambo Cash at the Wintergarde Mausoleum in Dragonblight wants you to find Plunderbeard.\n\n|cff33ff99He is at the end of the room, in a side nook (84.2, 54.7).|r"
Lang["Q1_12465"] = "Plunderbeard's Journal"
Lang["Q2_12465"] = "Recover Page 4 of Plunderbeard's Journal, Page 5 of Plunderbeard's Journal, Page 6 of Plunderbeard's Journal, and Page 7 of Plunderbeard's Journal and return them to Ambo Cash at the Wintergarde Mausoleum in Dragonblight.\n\n|cff33ff99Follow the dirt tunnel starting at Plunderbeard to find the right mobs|r"
Lang["Q1_12466"] = "Chasing Icestorm: The 7th Legion Front"
Lang["Q2_12466"] = "Report to Legion Commander Tyralion at the 7th Legion Front in central Dragonblight.\n\n|cff33ff99The Legion Front is located at (64.7, 27.9)|r"
Lang["Q1_12467"] = "Chasing Icestorm: Thel'zan's Phylactery"
Lang["Q2_12467"] = "Recover Thel'zan's Phylactery from Icestorm and return it to High Commander Halford Wyrmbane at Wintergarde Keep."
Lang["Q1_12472"] = "Finality"
Lang["Q2_12472"] = "Take Thel'zan's Phylactery to Legion Commander Yorik inside the Wintergarde Mausoleum in Dragonblight.\n\n|cff33ff99The entrance to the tunnel is just outside the keep, at (82.0, 50.7).|r"
Lang["Q1_12473"] = "An End And A Beginning"
Lang["Q2_12473"] = "Defeat Thel'zan the Duskbringer and report to High Commander Halford Wyrmbane at Wintergarde Keep in Dragonblight.\n\n|cff33ff99If you die, don't release; the NPCs might finish your quest for you.|r"
Lang["Q1_12474"] = "To Fordragon Hold!"
Lang["Q2_12474"] = "Venture to Fordragon Hold in Dragonblight and speak with Highlord Bolvar Fordragon.\n\n|cff33ff99He is at the very top, at (37.8, 23.4).|r"
Lang["Q1_12495"] = "Audience With The Dragon Queen"
Lang["Q2_12495"] = "Seek out Alexstrasza the Life-Binder at Wyrmrest Temple in Dragonblight.\n\n|cff33ff99Talk to Tariolstrasz (57.9, 54.2) and ask to go to the top of the tower. She's there, in humanoid form (59.8, 54.7).|r"
Lang["Q1_12499"] = "Return To Angrathar"
Lang["Q2_12499"] = "Speak with Highlord Bolvar Fordragon at Fordragon Hold and tell him of your victory over the Scourge."
Lang["Q1_13347"] = "Reborn From The Ashes"
Lang["Q2_13347"] = "Gather Fordragon's Shield from the field of battle at Angrathar the Wrath Gate and return it to King Varian Wrynn at Stormwind Keep in Stormwind City."
Lang["Q1_13369"] = "Fate, Up Against Your Will"
Lang["Q2_13369"] = "Assist Lady Jaina Proudmoore in Orgrimmar. Speak to the Warchief of the Horde, Thrall, at Orgrimmar on the continent of Kalimdor."
Lang["Q1_13370"] = "A Royal Coup"
Lang["Q2_13370"] = "Use the portal in Grommash Hold to return to Stormwind Keep and deliver Thrall's message to King Varian Wrynn."
Lang["Q1_13371"] = "The Killing Time"
Lang["Q2_13371"] = "Use the Portal to the Undercity inside Stormwind Keep to teleport to the Undercity. Report to Broll Bearmantle when you arrive at your destination."
Lang["Q1_13377"] = "The Battle For The Undercity"
Lang["Q2_13377"] = "Assist King Varian Wrynn and Lady Jaina Proudmoore in bringing Grand Apothecary Putress to justice! Report to King Varian Wrynn should you succeed."
--WOTLK Sons of Hodir
Lang["Q1_12843"] = "They Took Our Men!"
Lang["Q2_12843"] = "Gretchen Fizzlespark wants you to go to Sifreldar Village and rescue 5 Goblin Prisoners.\n\n|cff33ff99Go to the village at (41.4, 70.6), kill giants to get keys to the prisoners' cages scattered in the village.|r"
Lang["Q1_12846"] = "Leave No Goblin Behind"
Lang["Q2_12846"] = "Find the entrance to the Forlorn Mine in northern Sifreldar Village and look for clues for Zeev Fizzlespark's whereabouts.\n\n|cff33ff99The entrance of the mine is in the village at (42.1, 69.5), not under. If you see spiders you're in the wrong one:-).|r"
Lang["Q1_12841"] = "The Crone's Bargain"
Lang["Q2_12841"] = "Lok'lira the Crone inside the Forlorn Mine wants you to retrieve the Runes of the Yrkvinn from Overseer Syra.\n\n|cff33ff99Syra patrols the side corridors of the mine.|r"
Lang["Q1_12905"] = "Mildred the Cruel"
Lang["Q2_12905"] = "Speak to Mildred the Cruel inside the Forlorn Mine.\n\n|cff33ff99Mildred is on the platform as you walk further inside the mine.|r"
Lang["Q1_12906"] = "Discipline"
Lang["Q2_12906"] = "Mildred the Cruel at the Forlorn Mine wants you to use the Disciplining Rod on 6 Exhausted Vrykul."
Lang["Q1_12907"] = "Examples to be Made"
Lang["Q2_12907"] = "Mildred the Cruel at the Forlorn Mine wants you to slay Garhal.\n\n|cff33ff99He's with a couple others further down the mine, at (45.4, 69.1). The guards help you.|r"
Lang["Q1_12908"] = "A Certain Prisoner"
Lang["Q2_12908"] = "Take Mildred's Key to Lok'lira the Crone in the Forlorn Mine."
Lang["Q1_12921"] = "A Change of Scenery"
Lang["Q2_12921"] = "Reconvene with Lok'lira the Crone in Brunnhildar Village."
Lang["Q1_12969"] = "Is That Your Goblin?"
Lang["Q2_12969"] = "Challenge Agnetta Tyrsdottar in order to save Zeev Fizzlespark. Return to Lok'lira the Crone in Brunnhildar Village after you've succeeded."
Lang["Q1_12970"] = "The Hyldsmeet"
Lang["Q2_12970"] = "Listen to Lok'lira the Crone's proposal.\n\n|cff33ff99Just talk to the crone and click through the various messages.|r"
Lang["Q1_12971"] = "Taking on All Challengers"
Lang["Q2_12971"] = "Lok'lira the Crone in Brunnhildar Village wants you to defeat 6 Victorious Challengers.\n\n|cff33ff99Just talk to the various challengers that are not currently in a fight.|r"
Lang["Q1_12972"] = "You'll Need a Bear"
Lang["Q2_12972"] = "Speak to Brijana outside Brunnhildar Village.\n\n|cff33ff99Brijana is at (53.1, 65.7).|r"
Lang["Q1_12851"] = "Bearly Hanging On"
Lang["Q2_12851"] = "Brijana at Brunnhildar Village wants you to mount Icefang and shoot 7 Frostworgs and 15 Frost Giants in the Valley of Ancient Winters."
Lang["Q1_12856"] = "Cold Hearted"
Lang["Q2_12856"] = "Brijana, just east of Brunnhildar Village, wants you to fly to Dun Niffelem, then free 3 Captured Proto-Drakes and rescue 9 Brunnhildar Prisoners.\n\n|cff33ff99Fly to (64.3, 61.5) and jump on one of the Proto-Drakes chained to the ceiling. You can then 'shoot' at the iceblocked maidens to free them. Do 3 then return. Do this 3 times to get all 9.|r"
Lang["Q1_13063"] = "Deemed Worthy"
Lang["Q2_13063"] = "Brijana wants you to go to Brunnhildar Village and speak with Astrid Bjornrittar.\n\n|cff33ff99Astrid is inside a house at (49.7, 71.8).|r"
Lang["Q1_12900"] = "Making a Harness"
Lang["Q2_12900"] = "Astrid Bjornrittar in Brunnhildar Village wants you to obtain 3 Icemane Yeti Hides."
Lang["Q1_12983"] = "The Last of Her Kind"
Lang["Q2_12983"] = "Astrid Bjornrittar in Brunnhildar Village wants you to rescue an Icemaw Matriarch in the Hibernal Cavern.\n\n|cff33ff99The entrance to the cavern is at (55.9, 64.3). Follow the path to the right and you'll find the matriarch easily.|r"
Lang["Q1_12996"] = "The Warm-Up"
Lang["Q2_12996"] = "Astrid Bjornrittar in Brunnhildar Village wants you to use the Reins of the Warbear Matriarch to defeat Kirgaraak.\n\n|cff33ff99Maul (4) on cooldown, when charge is ready, do the knockback (5) and then charge (6). If the bear dies finish the mob by yourself it you can, it will still count.|r"
Lang["Q1_12997"] = "Into the Pit"
Lang["Q2_12997"] = "Astrid Bjornrittar, in Brunnhildar Village, wants you to use the Reins of the Warbear Matriarch inside the Pit of the Fang and defeat 6 Hyldsmeet Warbears."
Lang["Q1_13061"] = "Prepare for Glory"
Lang["Q2_13061"] = "Speak to Lok'lira the Crone in Brunnhildar Village."
Lang["Q1_13062"] = "Lok'lira's Parting Gift"
Lang["Q2_13062"] = "Speak to Gretta the Arbiter in Brunnhildar Village."
Lang["Q1_12886"] = "The Drakkensryd"
Lang["Q2_12886"] = "Use the Hyldnir Harpoon to defeat 10 Hyldsmeet Drakeriders at the Temple of Storms. Use the Hyldnir Harpoon on a Column Ornament to exit the Drakkensryd and speak to Thorim when you've succeeded.\n\n|cff33ff99Use the harpoon to jump onto other drakes and kill their riders. After 10 times, use the harpoon on a little lamp hanging off a column, that will take you to the platform.|r"
Lang["Q1_13064"] = "Sibling Rivalry"
Lang["Q2_13064"] = "Thorim wants you to listen to his story."
Lang["Q1_12915"] = "Mending Fences"
Lang["Q2_12915"] = "Thorim at the Temple of Storms wants you to Kill Fjorn and 5 Stormforged Iron Giants at Fjorn's Anvil, east of Dun Niffelem.\n\n|cff33ff99Fly to the Anvil at the very east of Storm Peaks (76.9, 63.2), and pick up a boulder from the floor. Use Thorim's charm on a target and let the dwarves tank it.\nNote, you'll need a new (unique) boulder for each target (so 6 minimum).|r"
Lang["Q1_12922"] = "The Refiner's Fire"
Lang["Q2_12922"] = "You must collect 10 Furious Sparks from the Seething Revenants at Frostfield Lake and then use the anvil at Fjorn's Anvil."
Lang["Q1_12956"] = "A Spark of Hope"
Lang["Q2_12956"] = "You are to bring the Refined Gleaming Ore to Thorim in the Temple of Storms."
Lang["Q1_12924"] = "Forging an Alliance"
Lang["Q2_12924"] = "You are to go to Dun Niffelem and ask King Jokkum to allow Thorim's armor to be reforged. After completing Jokkum's task, you are to speak with Njormeld in Dun Niffelem.\n\n|cff33ff99The king is in the center of Dun Niffelem, at (65.4, 60.1).\n\nYou however eventually turn in this quest to Njormeld at (63.2, 63.3).|r"
Lang["Q1_13009"] = "A New Beginning"
Lang["Q2_13009"] = "Njormeld wants you to take the Reforged Armor to Thorim at the Temple of Storms."
Lang["Q1_13050"] = "Veranus"
Lang["Q2_13050"] = "Thorim, at the Temple of Storms, wants you to obtain 5 Small Proto-Drake Eggs from the peaks near Brunnhildar Village.\n\n|cff33ff99There's various nests around the area, for example at (52.5, 73.4).|r"
Lang["Q1_13051"] = "Territorial Trespass"
Lang["Q2_13051"] = "Place the Stolen Proto-Dragon Eggs on top of the Broodmother's Nest and return to Thorim at the Temple of Storms.\n\n|cff33ff99The correct nest is at (38.7, 65.5). Put the eggs down and wait for Thorim to appear on top of Veranus.|r"
Lang["Q1_13010"] = "Krolmir, Hammer of Storms"
Lang["Q2_13010"] = "Thorim wants you to talk to King Jokkum in Dun Niffelem and discover what he knows of Krolmir.\n\n|cff33ff99You might be short a little bit of rep for the King to answer your question. Complete one of the two daily quests to become friendly.|r"
Lang["Q1_12966"] = "You Can't Miss Him"
Lang["Q2_12966"] = "King Jokkum in Dun Niffelem wants you to find Njormeld at Fjorn's Anvil."
Lang["Q1_12967"] = "Battling the Elements"
Lang["Q2_12967"] = "Njormeld wants you to accompany Snorri to Fjorn's anvil and help him kill 10 Seething Revenants."
Lang["Q1_12975"] = "In Memoriam"
Lang["Q2_12975"] = "King Jokkum in Dun Niffelem wants you to collect 8 Horn Fragments from Thunderfall.\n\n|cff33ff99They look like little grey bits in the snow at (71.6, 48.9).|r"
Lang["Q1_12976"] = "A Monument to the Fallen"
Lang["Q2_12976"] = "King Jokkum wants you to bring Hodir's Horn Fragments to Njormeld in Dun Niffelem."
Lang["Q1_13011"] = "Culling Jorcuttar"
Lang["Q2_13011"] = "King Jokkum in Dun Niffelem wants you to slay Jorcuttar in Hibernal Cavern.\n\n|cff33ff99Enter the cave and stick to the right. You can summon Jorcuttar at (54.8, 61.0). It might take a few tries to get the bear meat.|r"
Lang["Q1_13372"] = "The Key to the Focusing Iris"
Lang["Q2_13372"] = "Deliver the Key to the Focusing Iris to Alexstrasza the Life-Binder atop Wyrmrest Temple in the Dragonblight."
Lang["Q1_13375"] = "The Heroic Key to the Focusing Iris"
Lang["Q2_13375"] = "Deliver the Heroic Key to the Focusing Iris to Alexstrasza the Life-Binder atop Wyrmrest Temple in the Dragonblight."

--  \n\n|cff33ff99 |r
Lang["Q1_"] = ""
Lang["Q2_"] = ""




-- NPC
Lang["N1_9196"] = "Highlord Omokk"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9196
Lang["N2_9196"] = "Highlord Omokk is the first boss that will be encountered in Lower Blackrock Spire."
Lang["N1_9237"] = "War Master Voone"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9237
Lang["N2_9237"] = "War Master Voone is a mini-boss that will be encountered in Lower Blackrock Spire."
Lang["N1_9568"] = "Overlord Wyrmthalak"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9568
Lang["N2_9568"] = "Overlord Wyrmthalak is the last boss that will be encountered in Lower Blackrock Spire."
Lang["N1_10429"] = "Warchief Rend Blackhand"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10429
Lang["N2_10429"] = "Warchief Rend Blackhand is the sixth boss that you will encounter in Upper Blackrock Spire. Dal'rend, commonly referred to as Rend, was the ruler of the Dark Horde and the largest threat to Thrall."
Lang["N1_10182"] = "Rexxar"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10182
Lang["N2_10182"] = "<Champion of the Horde>\n\nPaths from south Stonetalon Mountains all the way down to North Feralas."
Lang["N1_8197"] = "Chronalis"	-- https://www.thegeekcrusade-serveur.com/db/?npc=8197
Lang["N2_8197"] = "Chronalis of the Bronze Dragonflight.\n\nLocated at the entrance of the Caverns of Time."
Lang["N1_10664"] = "Scryer"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10664
Lang["N2_10664"] = "Scryer of the Blue Dragonflight.\n\nLocated at the bottom of the Mazthoril cave."
Lang["N1_12900"] = "Somnus"	-- https://www.thegeekcrusade-serveur.com/db/?npc=12900
Lang["N2_12900"] = "Somnus of the Green Dragonflight.\n\nLocated on the eastern side of the Sunken Temple."
Lang["N1_12899"] = "Axtroz"	-- https://www.thegeekcrusade-serveur.com/db/?npc=12899
Lang["N2_12899"] = "Axtroz of the Red Dragonflight.\n\nLocated in Grim Batol, Wetlands."
Lang["N1_10363"] = "General Drakkisath"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10363
Lang["N2_10363"] = "General Drakkisath is the last boss that you will encounter in Upper Blackrock Spire."
Lang["N1_8983"] = "Golem Lord Argelmach"	-- https://www.thegeekcrusade-serveur.com/db/?npc=8983
Lang["N2_8983"] = "Golem Lord Argelmach is the ninth boss that you will encounter in Blackrock Depths."
Lang["N1_9033"] = "General Angerforge"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9033
Lang["N2_9033"] = "General Angerforge is the seventh boss that you will encounter in Blackrock Depths."
Lang["N1_17804"] = "Squire Rowe"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17804
Lang["N2_17804"] = "Located at the Stormwind gates."
Lang["N1_10929"] = "Haleh"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10929
Lang["N2_10929"] = "Stands on top of the Mazthoril cave, outside.\nCan be reached via the blue rune on the floor deep inside the cave."
Lang["N1_9046"] = "Scarshield Quartermaster"	-- https://www.thegeekcrusade-serveur.com/db/?npc=9046
Lang["N2_9046"] = "Located outside the instance, in a little alcove near the balcony entrance of Upper Blackrock Spire"
Lang["N1_15180"] = "Baristolth of the Shifting Sands"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15180
Lang["N2_15180"] = "Baristolth of the Shifting Sands is located at Cenarion Hold in Silithus (49.6,36.6)."
Lang["N1_12017"] = "Broodlord Lashlayer"	-- https://www.thegeekcrusade-serveur.com/db/?npc=12017
Lang["N2_12017"] = "Broodlord Lashlayer is the third boss in Blackwing Lair."
Lang["N1_13020"] = "Vaelastrasz the Corrupt"	-- https://www.thegeekcrusade-serveur.com/db/?npc=13020
Lang["N2_13020"] = "Vaelastrasz the Corrupt is the second boss in Blackwing Lair."
Lang["N1_11583"] = "Nefarian"	-- https://www.thegeekcrusade-serveur.com/db/?npc=11583
Lang["N2_11583"] = "Nefarian is the eighth and final boss of Blackwing Lair."
Lang["N1_15362"] = "Malfurion Stormrage"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15362
Lang["N2_15362"] = "He can be found in The Temple of Atal'Hakkar, and spawns once you approach the Shade of Eranikus."
Lang["N1_15624"] = "Forest Wisp"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15624
Lang["N2_15624"] = "This wisp can be found on Teldrassil, not far from the gates of Darnassus, at (37.6,48.0)."
Lang["N1_15481"] = "Spirit of Azuregos"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15481
Lang["N2_15481"] = "The spirit of Azuregos pats the southern part of Azshara, around (58.8,82.2). He likes to chat."
Lang["N1_11811"] = "Narain Soothfancy"	-- https://www.thegeekcrusade-serveur.com/db/?npc=11811
Lang["N2_11811"] = "Located in a little hut north of Steamwheedle Port (65.2,18.4)."
Lang["N1_15526"] = "Meridith the Mermaiden"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15526
Lang["N2_15526"] = "She pats the underwater area before the big trench, around (59.6,95.6). Once you complete her quest, go see her again and she will give you a swim speed buff."
Lang["N1_15554"] = "Number Two"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15554
Lang["N2_15554"] = "Number Two can be summoned in Winterspring, at a specific site (67.2,72.6). He can take a bit of time to spawn."
Lang["N1_15552"] = "Doctor Weavil"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15552
Lang["N2_15552"] = "This evil gnome can be found on Alcaz Island in Dustwallow Marsh (77.8,17.6). He is stunning!"
Lang["N1_10184"] = "Onyxia"	-- https://www.thegeekcrusade-serveur.com/db/?npc=10184
Lang["N2_10184"] = "When she is not being a Lady in Stormwind, Onyxia resides in her Lair, south of Dustwallow Marsh."
Lang["N1_11502"] = "Ragnaros"	-- https://www.thegeekcrusade-serveur.com/db/?npc=11502
Lang["N2_11502"] = "Ragnaros, the Firelord, is the tenth and final boss of Molten Core. By Fire be Purged!"
Lang["N1_12803"] = "Lord Lakmaeran"	-- https://www.thegeekcrusade-serveur.com/db/?npc=12803
Lang["N2_12803"] = "Located on the Isle of Dread in Feralas, just a bit north of the Chimaera area entrance (29.8,72.6)."
Lang["N1_15571"] = "Maws"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15571
Lang["N2_15571"] = "duunnn dunnn... duuuunnnn duun... duuunnnnnnnn dun dun dun dun dun dun dun dun dun dun dunnnnnnnnnnn dunnnn in Azshara at (65.6,54.6)"
Lang["N1_22037"] = "Smith Gorlunk"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22037
Lang["N2_22037"] = "Located at the forge obviously (67,36), on the northern side of the Black Temple building"
Lang["N1_18733"] = "Fel Reaver"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18733
Lang["N2_18733"] = "Tends to roams the western side of Hellfire Citadel."
Lang["N1_18473"] = "Talon King Ikiss"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18473
Lang["N2_18473"] = "Talon King Ikiss is the last boss of Sethekk Halls in Auchindoun"
Lang["N1_20142"] = "Steward of Time"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20142
Lang["N2_20142"] = "Bronze dragon, near the hourglass in the Caverns of Time."
Lang["N1_20130"] = "Andormu"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20130
Lang["N2_20130"] = "Looks like a little boy, near the hourglass in the Caverns of Time."
Lang["N1_18096"] = "Epoch Hunter"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18096
Lang["N2_18096"] = "Last boss of Caverns of Time: Old Hillsbrad Foothills, spawns in Tarren Mill when Thrall gets there."
Lang["N1_19880"] = "Nether-Stalker Khay'ji"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19880
Lang["N2_19880"] = "He stands next to the forge in Area 52 (32,64)"
Lang["N1_19641"] = "Warp-Raider Nesaad"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19641
Lang["N2_19641"] = "He is located at (28,79). Has 2 adds with him"
Lang["N1_18481"] = "A'dal"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18481
Lang["N2_18481"] = "A'dal is located in the middle of Shattrath City. Big yellow shiny thingy. Can't miss it, really."
Lang["N1_19220"] = "Pathaleon the Calculator"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19220
Lang["N2_19220"] = "Pathaleon the Calculator is the last boss of the Mechanar."
Lang["N1_17977"] = "Warp Splinter"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17977
Lang["N2_17977"] = "Warp Splinter is the fifth boss in The Botanica. He is a large tree elemental."
Lang["N1_17613"] = "Archmage Alturus"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17613
Lang["N2_17613"] = "Stands in front of the entrance of Karazhan."
Lang["N1_18708"] = "Murmur"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18708
Lang["N2_18708"] = "Murmur is the final boss of the Shadow Labyrinth. He is a large wind elemental."
Lang["N1_17797"] = "Hydromancer Thespia"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17797
Lang["N2_17797"] = "Hydromancer Thespia is the first boss of The Steamvault in Coilfang Reservoir."
Lang["N1_20870"] = "Zereketh the Unbound"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20870
Lang["N2_20870"] = "Zereketh the Unbound is the first boss found in The Arcatraz."
Lang["N1_15608"] = "Medhivh"	-- https://www.thegeekcrusade-serveur.com/db/?npc=15608
Lang["N2_15608"] = "Medivh is near the portal, in the south part of the Black Morass."
Lang["N1_16524"] = "Shade of Aran"	-- https://www.thegeekcrusade-serveur.com/db/?npc=16524
Lang["N2_16524"] = "The crazy father of Medhivh, in Karazhan"
Lang["N1_16807"] = "Grand Warlock Nethekurse"	-- https://www.thegeekcrusade-serveur.com/db/?npc=16807
Lang["N2_16807"] = "Grand Warlock Nethekurse is a Fel Orc warlock and first boss in the Shattered Halls."
Lang["N1_18472"] = "Darkweaver Syth"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18472
Lang["N2_18472"] = "Darkweaver Syth is the first boss found in Sethekk Halls."
Lang["N1_22421"] = "Skar'this the Heretic"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22421
Lang["N2_22421"] = "Skar'this is only present in the HEROIC mode of Slave Pens. He is located shortly after the first boss. When you jump down into the pool of water and come out, he is on the left hand side in a cage."
Lang["N1_19044"] = "Gruul the Dragonkiller"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19044
Lang["N2_19044"] = "Gruul the Dragonkiller is the final boss of the raid dungeon Gruul's Lair in Blade's Edge Mountains."
Lang["N1_17225"] = "Nightbane"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17225
Lang["N2_17225"] = "Nightbane is a summonable Dragon boss in Karazhan. Check out his attunement for more info."
Lang["N1_21938"] = "Earthmender Splinthoof"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21938
Lang["N2_21938"] = "Earthmender Splinthoof is inside the small building on the highest point of Shadowmoon Village (28.6,26.6)."
Lang["N1_21183"] = "Oronok Torn-heart"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21183
Lang["N2_21183"] = "Oronok Torn-heart is on top of the hill at a place called Oronok's Farm (53.8,23.4), in between Coilskar Point and the Altar of Sha'tar."
Lang["N1_21291"] = "Grom'tor, Son of Oronok"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21291
Lang["N2_21291"] = "Located in Coilskar Point (44.6,23.6)."
Lang["N1_21292"] = "Ar'tor, Son of Oronok"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21292
Lang["N2_21292"] = "Located at Illidari Point (29.6,50.4), suspended in the air by red beams."
Lang["N1_21293"] = "Borak, Son of Oronok"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21293
Lang["N2_21293"] = "Located just north of Eclipse Point (47.6,57.2)."
Lang["N1_18166"] = "Khadgar"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18166
Lang["N2_18166"] = "He stands in the centre of Shattrath City, just next to A'dal, the big yellow shiny thingy."
Lang["N1_16808"] = "Kargath Bladefist"	-- https://www.thegeekcrusade-serveur.com/db/?npc=16808
Lang["N2_16808"] = "Warchief Kargath Bladefist is the final boss of the Shattered Halls. Spoiler alert, he has blades for fists."
Lang["N1_17798"] = "Warlord Kalithresh"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17798
Lang["N2_17798"] = "Warlord Kalithresh is the third and last boss of The Steamvault in Coilfang Reservoir."
Lang["N1_20912"] = "Harbinger Skyriss"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20912
Lang["N2_20912"] = "Harbinger Skyriss is the fifth and final boss of a multi-wave encounter in The Arcatraz."
Lang["N1_20977"] = "Millhouse Manastorm"	-- https://www.thegeekcrusade-serveur.com/db/?npc=20977
Lang["N2_20977"] = "Millhouse Manastorm is a gnome mage found in the Harbinger Skyriss encounter in The Arcratraz. He will assist in attacking the other creatures released from the prisons."
Lang["N1_17257"] = "Magtheridon"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17257
Lang["N2_17257"] = "Magtheridon is being held prisonner under Hellfire Citadel, in the raid instance called Magtheridon's Lair."
Lang["N1_21937"] = "Earthmender Sophurus"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21937
Lang["N2_21937"] = "Earthmender Sophurus stands outside the inn at Wildhammer Stronghold (36.4,56.8)."
Lang["N1_19935"] = "Soridormi"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19935
Lang["N2_19935"] = "Soridormi wanders around the big hourglass inside the Caverns of Time."
Lang["N1_19622"] = "Kael'thas Sunstrider"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19622
Lang["N2_19622"] = "Kael'thas Sunstrider is the fourth and final boss of the raid instance the Eye."
Lang["N1_21212"] = "Lady Vashj"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21212
Lang["N2_21212"] = "Lady Vashj is the final encounter of the raid instance Serpentshrine Cavern in Coilfang Reservoir."
Lang["N1_21402"] = "Anchorite Ceyla"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21402
Lang["N2_21402"] = "Anchorite Ceyla is at the Altar of Shatar (62.6,28.4)."
Lang["N1_21955"] = "Arcanist Thelis"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21955
Lang["N2_21955"] = "Arcanist Thelis is inside the Sanctum of the Stars (56.2,59.6)"
Lang["N1_21962"] = "Seer Udalo"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21962
Lang["N2_21962"] = "He's lying dead on the small ramp before the last boss fight of The Arcatraz."
Lang["N1_22006"] = "Shadowlord Deathwail"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22006
Lang["N2_22006"] = "He's riding a dragon on the northern tower of the Black Temple (71.6,35.6) "
Lang["N1_22820"] = "Seer Olum"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22820
Lang["N2_22820"] = "Seer Olum is located in Serpentshrine Cavern, behind Fathom-Lord Karathress."
Lang["N1_21700"] = "Akama"	-- https://www.thegeekcrusade-serveur.com/db/?npc=21700
Lang["N2_21700"] = "Akama is located at the Warden's Cage (58.0,48.2)."
Lang["N1_19514"] = "Al'ar"	-- https://www.thegeekcrusade-serveur.com/db/?npc=19514
Lang["N2_19514"] = "Al'ar is the first boss of The Eye. He's a big fiery bird thing."
Lang["N1_17767"] = "Rage Winterchill"	-- https://www.thegeekcrusade-serveur.com/db/?npc=17767
Lang["N2_17767"] = "Rage Winterchill is the first boss in the Mount Hyjal raid instance."
Lang["N1_18528"] = "Xi'ri"	-- https://www.thegeekcrusade-serveur.com/db/?npc=18528
Lang["N2_18528"] = "Xi'ri is located at the entrance of the Black Temple. Big blue shiny thingy. Can't miss it either, really."
--v243
Lang["N1_22497"] = "V'eru"	-- https://www.thegeekcrusade-serveur.com/db/?npc=22497
Lang["N2_22497"] = "V'eru is in the same room as A'dal, but he's blue. He's on the top landing."
--v244
Lang["N1_22113"] = "Mordenai"
Lang["N2_22113"] = "A Blood Elf (spoiler alert, actually a dragon) who walks the Netherwing Fields just east of the Sanctum of the Stars"
--v247
Lang["N1_8888"]  = "Franclorn Forgewright"
Lang["N2_8888"]  = "A ghost dwarf, standing on his own tomb OUTSIDE the dungeon, in the structure suspended above the lava. You can only interact with him if you are DEAD."
Lang["N1_9056"]  = "Fineous Darkvire"
Lang["N2_9056"]  = "He is INSIDE the dungeon, and patrols the quarry area outside of Lord Incendius' chamber."
Lang["N1_10837"] = "High Executor Derrington"
Lang["N2_10837"] = "He can be found at the Bulwark, near the border of Tirisfal and Western Plaguelands"
Lang["N1_10838"] = "Commander Ashlam Valorfist"
Lang["N2_10838"] = "He can be found at Chillwind Camp, just south of Andorhal in the Western Plaguelands"
Lang["N1_1852"]  = "Araj the Summoner"
Lang["N2_1852"]  = "The Lich, in the middle of Andorhal"
--v250
Lang["N1_13278"]  = "Duke Hydraxis"
Lang["N2_13278"]  = "A large Water Elemental on a tiny faraway island in Azshara (79.2,73.6)"
Lang["N1_12264"]  = "Shazzrah"
Lang["N2_12264"]  = "Shazzrah is the fifth boss of Molten Core."
Lang["N1_12118"]  = "Lucifron"
Lang["N2_12118"]  = "Lucifron is the first boss of Molten Core."
Lang["N1_12259"]  = "Gehennas"
Lang["N2_12259"]  = "Gehennas is the third boss of Molten Core."
Lang["N1_12098"]  = "Sulfuron Harbinger"
Lang["N2_12098"]  = "Sulfuron Harbinger, herald of Ragnaros, is the eighth boss of the Molten Core."




--WOTLK NPCs
--WOTLK QUESTS
-- The ids are N1_<NPCId> and N2_<NPCId>
-- N1 is just the name of the NPC
-- N2 is a helpful description
Lang["N1_29795"]  = "Koltira Deathweaver"
Lang["N2_29795"]  = "Don't look for him on the ground. He's on the Orgrim's Hammer, flying somewhere above over the plain between Ymirheim and Syndragosa's Fall."
Lang["N1_29799"]  = "Thassarian"
Lang["N2_29799"]  = "Don't look for him on the ground. He's on the Skybreaker, flying somewhere above over the plain between Ymirheim and Syndragosa's Fall."
Lang["N1_29804"]  = "Baron Sliver"
Lang["N2_29804"]  = "He is standing outside, south of the tower, just near the ground entrance (44, 24.6).\n\nOnce the chain is over he moves to (42.8, 25.1)."
Lang["N1_29747"]  = "The Ocular"
Lang["N2_29747"]  = "A big blue Eye of (not) Sauron, at the very top of the Shadow Vault (44.6, 21.6).\n\nSimply zap it 10 times with the Eyesore Blaster."
Lang["N1_29769"]  = "Vile"
Lang["N2_29769"]  = "Stands on the mid-platform just a bit south of Baron Sliver (44.4, 26.9)."
Lang["N1_29770"]  = "Lady Nightswood"
Lang["N2_29770"]  = "Stands on the small mid-platform just west of Baron Sliver (41.9, 24.5)."
Lang["N1_29840"]  = "The Leaper"
Lang["N2_29840"]  = "Bounces all around the top-platform high above Baron Sliver (45.0, 23.8).\nCan be hard to catch, use '/tar The Leaper'"
Lang["N1_29851"]  = "General Lightsbane"
Lang["N2_29851"]  = "Comes when the weapon rack inside at the end of the Shadow Vault is clicked. The other 3 you just killed come and help during the fight.\n\nYou can fly in and out (44.9, 20.0)."
Lang["N1_26181"]  = "Emissary Brighthoof"
Lang["N2_26181"]  = "Circles the lower part of the Westwind Refugee Camp in Dragonblight, at the border of Borean Tundra (13.9, 48.6)."
Lang["N1_26652"]  = "Greatmother Icemist"
Lang["N2_26652"]  = "She walks around the center circle in Agmar's Hammer. She's in blue armor with a purple staff."
Lang["N1_26505"]  = "Doctor Sintar Malefious"
Lang["N2_26505"]  = "He's in the alchemy corner of Agmar's Hammer (36.1, 48.8)."
Lang["N1_25257"]  = "Saurfang the Younger"
Lang["N2_25257"]  = "He's near the Wrathgate, in the north-west corner of Dragonblight, at (40.7, 18.1).\n\nDon't get too attached to him!"
Lang["N1_31333"]  = "Alexstrasza the Life-Binder"
Lang["N2_31333"]  = "She is now in dragon form, in front of the Wrathgate. Quite big, can't miss her (38.3, 19.2)."
Lang["N1_25256"]  = "High Overlord Saurfang"
Lang["N2_25256"]  = "Saurfang is Chuck Norris's main. He is at the bottom of Warsong Hold in Borean Tundra, at (41.4, 53.7)."
Lang["N1_27136"]  = "High Commander Halford Wyrmbane"
Lang["N2_27136"]  = "He is near the top of Wintergarde Keep, at (78.5, 48.3)."
Lang["N1_27872"]  = "Highlord Bolvar Fordragon"
Lang["N2_27872"]  = "Bolvar Fordragon, a true hero of the alliance, struck with a terrible fate.\n\nHe awaits it at (37.8, 23.4)."
Lang["N1_29611"]  = "King Varian Wrynn"
Lang["N2_29611"]  = "Doesn't look too happy.."
Lang["N1_29473"]  = "Gretchen Fizzlespark"
Lang["N2_29473"]  = "She's in the K3 Inn at (41.2, 86.1)."
Lang["N1_15989"]  = "Sapphiron"
Lang["N2_15989"]  = "Sapphiron is a gigantic undead frost wyrm who guards the entrance to Kel'Thuzad's inner sanctum in Naxxramas."

Lang["N1_"]  = ""
Lang["N2_"]  = ""



Lang["O_1"] = "Click Drakkisath's Brand to complete the quest.\nIt's a glowing orb located behind General Drakkisath."
Lang["O_2"] = "It's a tiny glowing red dot on the ground\nin front of the gates of Ahn'Qiraj (28.7,89.2)."
--v247
Lang["O_3"] = "The shrine is located at the end of a corridor\nthat starts from the upper level of the Ring of Law."
Lang["O_189311"] = "|cFFFFFFFFFlesh-bound Tome|r\n|cFF808080Starts a new quest|r\n\nThe book is on the floor of the crypt,\nnext to where Necrolord Amarion is (78.3, 52.3).\n\nOnce you have the quest, hurry up and get out\nof the crypt as mobs will spawn and attack you"
Lang["Flesh-bound Tome"] = "Flesh-bound Tome"


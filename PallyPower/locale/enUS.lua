local L = LibStub("AceLocale-3.0"):NewLocale("PallyPower", "enUS", true, false)
if not L then return end
L["ALTMENU_LINE1"] = "can be assigned"
L["ALTMENU_LINE2"] = "a Normal Blessing from:"
L["AURA"] = "Aura Button"
L["AURA_DESC"] = "[|cffffd200Enable|r/|cffffd200Disable|r] The Aura Button or select the Aura you want to track."
L["AURABTN"] = "Aura Button"
L["AURABTN_DESC"] = "[Enable/Disable] The Aura Button"
L["AURATRACKER"] = "Aura Tracker"
L["AURATRACKER_DESC"] = "Select the Aura you want to track"
L["AUTO"] = "Auto Buff Button"
L["AUTO_DESC"] = "[|cffffd200Enable|r/|cffffd200Disable|r] The Auto Buff Button or [|cffffd200Enable|r/|cffffd200Disable|r] Wait for Players."
L["AUTOASSIGN"] = "Auto-Assign"
L["AUTOASSIGN_DESC"] = [=[Auto-Assign all Blessings based on
the number of available Paladins
and their available Blessings.

|cffffffff[Shift-Left-Click]|r Use Battleground
assignment template instead of Raid
assignment template.]=]
L["AUTOBTN"] = "Auto Buff Button"
L["AUTOBTN_DESC"] = "[Enable/Disable] The Auto Buff Button"
L["AUTOKEY1"] = "Auto Normal Blessing Key"
L["AUTOKEY1_DESC"] = "Key Binding for automated buffing of normal blessings."
L["AUTOKEY2"] = "Auto Greater Blessing Key"
L["AUTOKEY2_DESC"] = "Key Binding for automated buffing of greater blessings."
L["BAP"] = "Blessing Assignments Scale"
L["BAP_DESC"] = "This allows you to adjust the overall size of the Blessing Assignments Panel"
L["BRPT"] = "Blessings Report"
L["BRPT_DESC"] = [=[Report all Blessing
assignments to the
Raid or Party channel.]=]
L["BSC"] = "PallyPower Buttons Scale"
L["BSC_DESC"] = "This allows you to adjust the overall size of the PallyPower Buttons"
L["BUFFDURATION"] = "Buff Duration"
L["BUFFDURATION_DESC"] = "If this option is disabled then Class and Player buttons will ignore a buffs duration allowing a buff to be reapplied at will. This is especially useful for Protection Paladins when they spam Greater Blessings to generate more threat."
L["BUTTONS"] = "Buttons"
L["BUTTONS_DESC"] = "Change the button settings"
L["CANCEL"] = "Cancel"
L["CLASSBTN"] = "Class Buttons"
L["CLASSBTN_DESC"] = "If this option is disabled it will also disable the Player Buttons and you will only be able to buff using the Auto Buff button."
L["CPBTNS"] = "Class & Player Buttons"
L["CPBTNS_DESC"] = "[|cffffd200Enable|r/|cffffd200Disable|r] The Player(s) or Class Buttons."
L["DISPEDGES"] = "Borders"
L["DISPEDGES_DESC"] = "Change the Button Borders"
L["DRAG"] = "Drag Handle Button"
L["DRAG_DESC"] = "[|cffffd200Enable|r/|cffffd200Disable|r] The Drag Handle Button."
L["DRAGHANDLE"] = [=[|cffffffff[Left-Click]|r |cffff0000Lock|r/|cff00ff00Unlock|r PallyPower
|cffffffff[Left-Click-Hold]|r Move PallyPower
|cffffffff[Right-Click]|r Open Blessing Assignments
|cffffffff[Shift-Right-Click]|r Open Options]=]
L["DRAGHANDLE_ENABLED"] = "Drag Handle"
L["DRAGHANDLE_ENABLED_DESC"] = "[Enable/Disable] The Drag Handle"
L["ENABLEPP"] = "Enable PallyPower"
L["ENABLEPP_DESC"] = "[Enable/Disable] PallyPower"
L["FREEASSIGN"] = "Free Assignment"
L["FREEASSIGN_DESC"] = [=[Allow others to change your
blessings without being Party
Leader / Raid Assistant.]=]
L["FULLY_BUFFED"] = "Fully Buffed"
L["HORLEFTDOWN"] = "Horizontal Left | Down"
L["HORLEFTUP"] = "Horizontal Left | Up"
L["HORRIGHTDOWN"] = "Horizontal Right | Down"
L["HORRIGHTUP"] = "Horizontal Right | Up"
L["LAYOUT"] = "Buff Button | Player Button Layout"
L["LAYOUT_DESC"] = [=[Vertical [Left/Right]
Horizontal [Up/Down]]=]
L["MAINASSISTANT"] = "Auto-Buff Main Assistant"
L["MAINASSISTANT_DESC"] = "If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Assistant|r role in the Blizzard Raid Panel. This is useful to avoid blessing the |cffffd200Main Assistant|r role with a Greater Blessing of Salvation."
L["MAINASSISTANTGBUFFDP"] = "Override Druids / Paladins..."
L["MAINASSISTANTGBUFFDP_DESC"] = "Select the Greater Blessing assignment you wish to over-write on Main Tank: Druids / Paladins."
L["MAINASSISTANTGBUFFW"] = "Override Warriors..."
L["MAINASSISTANTGBUFFW_DESC"] = "Select the Greater Blessing assignment you wish to over-write on Main Tank: Warriors."
L["MAINASSISTANTNBUFFDP"] = "...with Normal..."
L["MAINASSISTANTNBUFFDP_DESC"] = "Select the Normal Blessing you wish to use to over-write the Main Tank: Druids / Paladins."
L["MAINASSISTANTNBUFFW"] = "...with Normal..."
L["MAINASSISTANTNBUFFW_DESC"] = "Select the Normal Blessing you wish to use to over-write the Main Tank: Warriors."
L["MAINROLES"] = "Main Tank / Main Assist Roles"
L["MAINROLES_DESC"] = [=[These options can be used to automatically assign alternate Normal Blessings for any Greater Blessing assigned to Warriors, Druids or Paladins |cffff0000only|r.

Normally the Main Tank and the Main Assist roles have been used to identify Main Tanks and Off-Tanks (Main Assist) however, some guilds assign the Main Tank role to both Main Tanks and Off-Tanks and assign the Main Assist role to Healers.

By having a separate setting for both roles it will allow Paladin Class Leaders or Raid Leaders to remove, as an example, Greater Blessing of Salvation from Tanking classes or if Druid or Paladin Healers are marked with the Main Assist role they could be setup to get Normal Blessing of Wisdom vs Greater Blessing of Might which would allow assigning Greater Blessing of Might for DPS spec'd Druids and Paladins and Normal Blessing of Wisdom to Healing spec'd Druids and Paladins.]=]
L["MAINTANKGBUFFDP"] = "Override Druids / Paladins..."
L["MAINTANKGBUFFDP_DESC"] = "Select the Greater Blessing assignment you wish to over-write on Main Tank: Druids / Paladins."
L["MAINTANKGBUFFW"] = "Override Warriors..."
L["MAINTANKGBUFFW_DESC"] = "Select the Greater Blessing assignment you wish to over-write on Main Tank: Warriors."
L["MAINTANKNBUFFDP"] = "...with Normal..."
L["MAINTANKNBUFFDP_DESC"] = "Select the Normal Blessing you wish to use to over-write the Main Tank: Druids / Paladins."
L["MAINTANKNBUFFW"] = "...with Normal..."
L["MAINTANKNBUFFW_DESC"] = "Select the Normal Blessing you wish to use to over-write the Main Tank: Warriors."
L["MINIMAPICON"] = [=[|cffffffff[Left-Click]|r Open Blessing Assignments
|cffffffff[Right-Click]|r Open Options]=]
L["NONE"] = "None"
L["NONE_BUFFED"] = "None Buffed"
L["OPTIONS"] = "Options"
L["OPTIONS_DESC"] = [=[Opens the PallyPower
addon options panel.]=]
L["PARTIALLY_BUFFED"] = "Partially Buffed"
L["PLAYERBTNS"] = "Player Buttons"
L["PLAYERBTNS_DESC"] = "If this option is disabled then you will no longer see the pop out buttons showing individual players and you will not be able to reapply Normal Blessings while in combat."
L["PP_CLEAR"] = "Clear"
L["PP_CLEAR_DESC"] = [=[Clears all Blessing
assignments for Self,
Party, and Raid Paladins.]=]
L["PP_COLOR"] = "Change the status colors of the buff buttons"
L["PP_LOOKS"] = "Change the way PallyPower looks"
L["PP_MAIN"] = "Main PallyPower Settings"
L["PP_NAME"] = "PallyPower Classic"
L["PP_RAS1"] = "--- Paladin assignments ---"
L["PP_RAS2"] = "--- End of assignments ---"
L["PP_RAS3"] = "WARNING: There are more than 5 Paladins in raid."
L["PP_RAS4"] = "Tanks, manually switch off Blessing of Salvation!"
L["PP_REFRESH"] = "Refresh"
L["PP_REFRESH_DESC"] = [=[Refreshes all Blessing
assignments, Talents, and
Symbol of Kings among Self,
Party, and Raid Paladins.]=]
L["PP_RESET"] = "Just in case you mess up"
L["PPMAINTANK"] = "Auto-Buff Main Tank"
L["PPMAINTANK_DESC"] = "If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Tank|r role in the Blizzard Raid Panel. This is useful to avoid blessing the |cffffd200Main Tank|r role with a Greater Blessing of Salvation."
L["RAID"] = "Raid"
L["RAID_DESC"] = "Raid only options"
L["REPORTCHANNEL"] = "Blessings Report Channel"
L["REPORTCHANNEL_DESC"] = [=[Set the desired chennel to broadcast the Bliessings Report to:

|cffffd200[None]|r Selects channel based on group makeup. (Party/Raid)

|cffffd200[Channel List]|r An auto populated channel list based on channels the player has joined. Default channels such as Trade, General, etc. are automatically filtered from the list.

|cffffff00Note: If you change your Channel Order then you will need to reload your UI and verify that it is broadcasting to the correct channel.|r]=]
L["RESET"] = "Reset Frames"
L["RESET_DESC"] = "Reset all PallyPower frames back to center"
L["RESIZEGRIP"] = [=[Left-Click-Hold to resize
Right-Click resets default size]=]
L["RFM"] = "Righteous Fury"
L["RFM_DESC"] = "[Enable/Disable] Righteous Fury"
L["SALVCOMBAT"] = "Salv in Combat"
L["SALVCOMBAT_DESC"] = [=[If you enable this option you will be able to buff Warriors, Druids and Paladins with Greater Blessing of Salvation while in combat.

|cffffff00Note: This setting ONLY applies to raid groups because in our current culture, a lot of tanks use scripts/addons to cancel buffs which can only be done while not in combat. This option is basically a safety to prevent buffing a Tank with Salvation accidentally during combat.|r]=]
L["SEAL"] = "Seal Button"
L["SEAL_DESC"] = "[|cffffd200Enable|r/|cffffd200Disable|r] The Seal Button, Enable/Disable Righteous Fury or select the Seal you want to track."
L["SEALBTN"] = "Seal Button"
L["SEALBTN_DESC"] = "[Enable/Disable] The Seal Button"
L["SEALTRACKER"] = "Seal Tracker"
L["SEALTRACKER_DESC"] = "Select the Seal you want to track"
L["SETTINGS"] = "Settings"
L["SETTINGS_DESC"] = "Change global settings"
L["SETTINGSBUFF"] = "What to buff with PallyPower"
L["SHOWMINIMAPICON"] = "Show Minimap Icon"
L["SHOWMINIMAPICON_DESC"] = "[Show/Hide] Minimap Icon"
L["SHOWPETS"] = "Show Pets"
L["SHOWPETS_DESC"] = [=[If you enable this option pets will appear under their own class.

|cffffff00Note: Due to the way Greater Blessings work and the way that pets are classified, Pets will need to be buffed separately. Additionally, Warlock Imps will be hidden automatically unless Phase Shift is off.|r]=]
L["SHOWTIPS"] = "Show Tooltips"
L["SHOWTIPS_DESC"] = "[Show/Hide] The PallyPower Tooltips"
L["SKIN"] = "Background Textures"
L["SKIN_DESC"] = "Change the Button Background Textures"
L["SMARTBUFF"] = "Smart Buffs"
L["SMARTBUFF_DESC"] = "If you enable this option you will not be allowed to assign Blessing of Wisdom to Warriors or Rogues and Blessing of Might to Mages, Warlocks and Hunters."
L["USEPARTY"] = "Use in Party"
L["USEPARTY_DESC"] = "[Enable/Disable] PallyPower in Party"
L["USESOLO"] = "Use when Solo"
L["USESOLO_DESC"] = "[Enable/Disable] PallyPower while Solo"
L["VERDOWNLEFT"] = "Vertical Down | Left"
L["VERDOWNRIGHT"] = "Vertical Down | Right"
L["VERUPLEFT"] = "Vertical Up | Left"
L["VERUPRIGHT"] = "Vertical Up | Right"
L["WAIT"] = "Wait for Players"
L["WAIT_DESC"] = "If this option is enabled then the Auto Buff Button and the Class Buff Button(s) will not auto buff a Greater Blessing if recipient(s) are not within the Paladins range (100yds). This range check excludes AFK, Dead and Offline players."
 

local silent = false
--[==[@debug@
silent = true
--@end-debug@]==]

local L = LibStub("AceLocale-3.0"):NewLocale("PallyPower", "enUS", true, silent)
if not L then return end

L["--- End of assignments ---"] = "--- End of assignments ---"
L["--- Paladin assignments ---"] = "--- Paladin assignments ---"
L["...with Normal..."] = "...with Normal..."
L["[|cffffd200Enable|r/|cffffd200Disable|r] The Aura Button or select the Aura you want to track."] = "[|cffffd200Enable|r/|cffffd200Disable|r] The Aura Button or select the Aura you want to track."
L["[|cffffd200Enable|r/|cffffd200Disable|r] The Auto Buff Button or [|cffffd200Enable|r/|cffffd200Disable|r] Wait for Players."] = "[|cffffd200Enable|r/|cffffd200Disable|r] The Auto Buff Button or [|cffffd200Enable|r/|cffffd200Disable|r] Wait for Players."
L["[|cffffd200Enable|r/|cffffd200Disable|r] The Drag Handle Button."] = "[|cffffd200Enable|r/|cffffd200Disable|r] The Drag Handle Button."
L["[|cffffd200Enable|r/|cffffd200Disable|r] The Player(s) or Class Buttons."] = "[|cffffd200Enable|r/|cffffd200Disable|r] The Player(s) or Class Buttons."
L["[|cffffd200Enable|r/|cffffd200Disable|r] The Seal Button, Enable/Disable Righteous Fury or select the Seal you want to track."] = "[|cffffd200Enable|r/|cffffd200Disable|r] The Seal Button, Enable/Disable Righteous Fury or select the Seal you want to track."
L["[Enable/Disable] Class Buttons"] = "[Enable/Disable] Class Buttons"
L["[Enable/Disable] PallyPower"] = "[Enable/Disable] PallyPower"
L["[Enable/Disable] PallyPower in Party"] = "[Enable/Disable] PallyPower in Party"
L["[Enable/Disable] PallyPower while Solo"] = "[Enable/Disable] PallyPower while Solo"
L["[Enable/Disable] Righteous Fury"] = "[Enable/Disable] Righteous Fury"
L["[Enable/Disable] The Aura Button"] = "[Enable/Disable] The Aura Button"
L["[Enable/Disable] The Auto Buff Button"] = "[Enable/Disable] The Auto Buff Button"
L["[Enable/Disable] The Drag Handle"] = "[Enable/Disable] The Drag Handle"
L["[Enable/Disable] The Seal Button"] = "[Enable/Disable] The Seal Button"
L["[Show/Hide] Minimap Icon"] = "[Show/Hide] Minimap Icon"
L["[Show/Hide] The PallyPower Tooltips"] = "[Show/Hide] The PallyPower Tooltips"
L["a Normal Blessing from:"] = "a Normal Blessing from:"
L["Aura Button"] = "Aura Button"
L["Aura Tracker"] = "Aura Tracker"
L["Auto Buff Button"] = "Auto Buff Button"
L["Auto Greater Blessing Key"] = "Auto Greater Blessing Key"
L["Auto Normal Blessing Key"] = "Auto Normal Blessing Key"
L["AUTO_ASSIGN_TOOLTIP"] = [=[Auto-Assign all Blessings based on
the number of available Paladins
and their available Blessings.

|cffffffff[Shift-Left-Click]|r Use Battleground
assignment template instead of Raid
assignment template.]=]
L["Auto-Assign"] = "Auto-Assign"
L["Auto-Buff Main Assistant"] = "Auto-Buff Main Assistant"
L["Auto-Buff Main Tank"] = "Auto-Buff Main Tank"
L["AUTOKEY1_DESC"] = "Key Binding for automated buffing of normal blessings."
L["AUTOKEY2_DESC"] = "Key Binding for automated buffing of greater blessings."
L["Background Textures"] = "Background Textures"
L["Blessing Assignments Scale"] = "Blessing Assignments Scale"
L["BLESSING_REPORT_TOOLTIP"] = [=[Report all Blessing
assignments to the
Raid or Party channel.]=]
L["Blessings Report"] = "Blessings Report"
L["Blessings Report Channel"] = "Blessings Report Channel"
L["Borders"] = "Borders"
L["Buff Button | Player Button Layout"] = "Buff Button | Player Button Layout"
L["Buff Duration"] = "Buff Duration"
L["Buttons"] = "Buttons"
L["can be assigned"] = "can be assigned"
L["Change global settings"] = "Change global settings"
L["Change the Button Background Textures"] = "Change the Button Background Textures"
L["Change the Button Borders"] = "Change the Button Borders"
L["Change the button settings"] = "Change the button settings"
L["Change the status colors of the buff buttons"] = "Change the status colors of the buff buttons"
L["Change the way PallyPower looks"] = "Change the way PallyPower looks"
L["Class & Player Buttons"] = "Class & Player Buttons"
L["Class Buttons"] = "Class Buttons"
L["Clear"] = "Clear"
L["Drag Handle"] = "Drag Handle"
L["Drag Handle Button"] = "Drag Handle Button"
L["DRAGHANDLE_TOOLTIP"] = [=[|cffffffff[Left-Click]|r |cffff0000Lock|r/|cff00ff00Unlock|r PallyPower
|cffffffff[Left-Click-Hold]|r Move PallyPower
|cffffffff[Right-Click]|r Open Blessing Assignments
|cffffffff[Shift-Right-Click]|r Open Options]=]
L["Enable PallyPower"] = "Enable PallyPower"
L["Free Assignment"] = "Free Assignment"
L["FREE_ASSIGN_TOOLTIP"] = [=[Allow others to change your
blessings without being Party
Leader / Raid Assistant.]=]
L["Fully Buffed"] = "Fully Buffed"
L["Hide Bench (by Subgroup)"] = "Hide Bench (by Subgroup)"
L["Horizontal Left | Down"] = "Horizontal Left | Down"
L["Horizontal Left | Up"] = "Horizontal Left | Up"
L["Horizontal Right | Down"] = "Horizontal Right | Down"
L["Horizontal Right | Up"] = "Horizontal Right | Up"
L["If this option is disabled it will also disable the Player Buttons and you will only be able to buff using the Auto Buff button."] = "If this option is disabled it will also disable the Player Buttons and you will only be able to buff using the Auto Buff button."
L["If this option is disabled then Class and Player buttons will ignore buffs' duration, allowing buffs to be reapplied at will. This is especially useful for Protection Paladins when they spam Greater Blessings to generate more threat."] = "If this option is disabled then Class and Player buttons will ignore buffs' duration, allowing buffs to be reapplied at will. This is especially useful for Protection Paladins when they spam Greater Blessings to generate more threat."
L["If this option is disabled then you will no longer see the pop out buttons showing individual players and you will not be able to reapply Normal Blessings while in combat."] = "If this option is disabled then you will no longer see the pop out buttons showing individual players and you will not be able to reapply Normal Blessings while in combat."
L["If this option is enabled then the Auto Buff Button and the Class Buff Button(s) will not auto buff a Greater Blessing if recipient(s) are not within the Paladins range (100yds). This range check excludes AFK, Dead and Offline players."] = "If this option is enabled then the Auto Buff Button and the Class Buff Button(s) will not auto buff a Greater Blessing if recipient(s) are not within the Paladins range (100yds). This range check excludes AFK, Dead and Offline players."
L["If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Assistant|r role in the Blizzard Raid Panel. This is useful for spot buffing the |cffffd200Main Assistant|r role with Blessing of Sanctuary."] = "If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Assistant|r role in the Blizzard Raid Panel. This is useful for spot buffing the |cffffd200Main Assistant|r role with Blessing of Sanctuary."
L["If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Assistant|r role in the Blizzard Raid Panel. This is useful to avoid blessing the |cffffd200Main Assistant|r role with a Greater Blessing of Salvation."] = "If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Assistant|r role in the Blizzard Raid Panel. This is useful to avoid blessing the |cffffd200Main Assistant|r role with a Greater Blessing of Salvation."
L["If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Tank|r role in the Blizzard Raid Panel. This is useful for spot buffing the |cffffd200Main Tank|r role with Blessing of Sanctuary."] = "If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Tank|r role in the Blizzard Raid Panel. This is useful for spot buffing the |cffffd200Main Tank|r role with Blessing of Sanctuary."
L["If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Tank|r role in the Blizzard Raid Panel. This is useful to avoid blessing the |cffffd200Main Tank|r role with a Greater Blessing of Salvation."] = "If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Tank|r role in the Blizzard Raid Panel. This is useful to avoid blessing the |cffffd200Main Tank|r role with a Greater Blessing of Salvation."
L["If you enable this option, you will not be allowed to assign Blessing of Wisdom to Warriors or Rogues, and Blessing of Might to Mages, Warlocks, or Hunters."] = "If you enable this option, you will not be allowed to assign Blessing of Wisdom to Warriors or Rogues, and Blessing of Might to Mages, Warlocks, or Hunters."
L["If you enable this option, you will not be allowed to assign Blessing of Wisdom to Warriors, Rogues, or Death Knights and Blessing of Might to Mages, Warlocks, or Hunters."] = "If you enable this option, you will not be allowed to assign Blessing of Wisdom to Warriors, Rogues, or Death Knights and Blessing of Might to Mages, Warlocks, or Hunters."
L["LAYOUT_TOOLTIP"] = [=[Vertical [Left/Right]
Horizontal [Up/Down]]=]
L["Main PallyPower Settings"] = "Main PallyPower Settings"
L["Main Tank / Main Assist Roles"] = "Main Tank / Main Assist Roles"
L["MAIN_ROLES_DESCRIPTION"] = [=[These options can be used to automatically assign alternate Normal Blessings for any Greater Blessing assigned to Warriors, Druids, or Paladins |cffff0000only|r.

Normally the Main Tank and the Main Assist roles have been used to identify Main Tanks and Off-Tanks (Main Assist) however, some guilds assign the Main Tank role to both Main Tanks and Off-Tanks and assign the Main Assist role to Healers.

By having a separate setting for both roles it will allow Paladin Class Leaders or Raid Leaders to remove, as an example, Greater Blessing of Salvation from tanking classes. Another example being if Druid or Paladin Healers are marked with the Main Assist role, they could be set up to get normal Blessing of Wisdom vs Greater Blessing of Might which would allow assigning Greater Blessing of Might for DPS spec'd Druids and Paladins and normal Blessing of Wisdom to Healing spec'd Druids and Paladins.]=]
L["MAIN_ROLES_DESCRIPTION_WRATH"] = [=[These options can be used to automatically assign alternate Normal Blessings for any Greater Blessing assigned to Warriors, Death Knights, Druids, or Paladins |cffff0000only|r.

Normally the Main Tank and the Main Assist roles have been used to identify Main Tanks and Off-Tanks (Main Assist) however, some guilds assign the Main Tank role to both Main Tanks and Off-Tanks and assign the Main Assist role to Healers.

By having a separate setting for both roles it will allow Paladin Class Leaders or Raid Leaders to add, as an example, Blessing of Sanctuary to tanking classes. Another example being if Druid or Paladin Healers are marked with the Main Assist role, they could be set up to get normal Blessing of Wisdom vs Greater Blessing of Might which would allow assigning Greater Blessing of Might for DPS spec'd Druids and Paladins and normal Blessing of Wisdom to Healing spec'd Druids and Paladins.]=]
L["MINIMAP_ICON_TOOLTIP"] = [=[|cffffffff[Left-Click]|r Open Blessing Assignments
|cffffffff[Right-Click]|r Open Options]=]
L["None"] = "None"
L["None Buffed"] = "None Buffed"
L["Options"] = "Options"
L["OPTIONS_BUTTON_TOOLTIP"] = [=[Opens the PallyPower
addon options panel.]=]
L["Override Druids / Paladins..."] = "Override Druids / Paladins..."
L["Override Warriors / Death Knights..."] = "Override Warriors / Death Knights..."
L["Override Warriors..."] = "Override Warriors..."
L["PallyPower Buttons Scale"] = "PallyPower Buttons Scale"
L["PallyPower Classic"] = "PallyPower Classic"
L["Partially Buffed"] = "Partially Buffed"
L["Player Buttons"] = "Player Buttons"
L["PP_CLEAR_TOOLTIP"] = [=[Clears all Blessing
assignments for Self,
Party, and Raid Paladins.]=]
L["PP_REFRESH_TOOLTIP"] = [=[Refreshes all Blessing
assignments, Talents, and
Symbol of Kings among Self,
Party, and Raid Paladins.]=]
L["Preset"] = "Preset"
L["PRESET_TOOLTIP"] = [=[|cffffffff[Left-Click]|r Load the last saved Preset.

|cffffffff[Shift-Left-Click]|r Save a preset 
of all Greater and Normal Blessings 
currently configured.]=]
L["Raid only options"] = "Raid only options"
L["Refresh"] = "Refresh"
L["REPORT_CHANNEL_OPTION_TOOLTIP"] = [=[Set the desired channel to broadcast the Blessings Report to:

|cffffd200[None]|r Selects channel based on group makeup. (Party/Raid)

|cffffd200[Channel List]|r An auto populated channel list based on channels the player has joined. Default channels such as Trade, General, etc. are automatically filtered from the list.

|cffffff00Note: If you change your Channel Order then you will need to reload your UI and verify that it is broadcasting to the correct channel.|r]=]
L["Reset all PallyPower frames back to center"] = "Reset all PallyPower frames back to center"
L["Reset Frames"] = "Reset Frames"
L["RESIZEGRIP_TOOLTIP"] = [=[Left-Click-Hold to resize
Right-Click resets default size]=]
L["Righteous Fury"] = "Righteous Fury"
L["Salv in Combat"] = "Salv in Combat"
L["SALVCOMBAT_OPTION_TOOLTIP"] = [=[If you enable this option you will be able to buff Warriors, Druids and Paladins with Greater Blessing of Salvation while in combat.

|cffffff00Note: This setting ONLY applies to raid groups because in our current culture, a lot of tanks use scripts/addons to cancel buffs which can only be done while not in combat. This option is basically a safety to prevent buffing a Tank with Salvation accidentally during combat.|r]=]
L["Seal Button"] = "Seal Button"
L["Seal Tracker"] = "Seal Tracker"
L["Select the Aura you want to track"] = "Select the Aura you want to track"
L["Select the Greater Blessing assignment you wish to over-write on Main Assist: Druids / Paladins."] = "Select the Greater Blessing assignment you wish to over-write on Main Assist: Druids / Paladins."
L["Select the Greater Blessing assignment you wish to over-write on Main Assist: Warriors / Death Knights."] = "Select the Greater Blessing assignment you wish to over-write on Main Assist: Warriors / Death Knights."
L["Select the Greater Blessing assignment you wish to over-write on Main Assist: Warriors."] = "Select the Greater Blessing assignment you wish to over-write on Main Assist: Warriors."
L["Select the Greater Blessing assignment you wish to over-write on Main Tank: Druids / Paladins."] = "Select the Greater Blessing assignment you wish to over-write on Main Tank: Druids / Paladins."
L["Select the Greater Blessing assignment you wish to over-write on Main Tank: Warriors / Death Knights."] = "Select the Greater Blessing assignment you wish to over-write on Main Tank: Warriors / Death Knights."
L["Select the Greater Blessing assignment you wish to over-write on Main Tank: Warriors."] = "Select the Greater Blessing assignment you wish to over-write on Main Tank: Warriors."
L["Select the Normal Blessing you wish to use to over-write the Main Assist: Druids / Paladins."] = "Select the Normal Blessing you wish to use to over-write the Main Assist: Druids / Paladins."
L["Select the Normal Blessing you wish to use to over-write the Main Assist: Warriors / Death Knights."] = "Select the Normal Blessing you wish to use to over-write the Main Assist: Warriors / Death Knights."
L["Select the Normal Blessing you wish to use to over-write the Main Assist: Warriors."] = "Select the Normal Blessing you wish to use to over-write the Main Assist: Warriors."
L["Select the Normal Blessing you wish to use to over-write the Main Tank: Druids / Paladins."] = "Select the Normal Blessing you wish to use to over-write the Main Tank: Druids / Paladins."
L["Select the Normal Blessing you wish to use to over-write the Main Tank: Warriors / Death Knights."] = "Select the Normal Blessing you wish to use to over-write the Main Tank: Warriors / Death Knights."
L["Select the Normal Blessing you wish to use to over-write the Main Tank: Warriors."] = "Select the Normal Blessing you wish to use to over-write the Main Tank: Warriors."
L["Select the Seal you want to track"] = "Select the Seal you want to track"
L["Show Minimap Icon"] = "Show Minimap Icon"
L["Show Pets"] = "Show Pets"
L["Show Tooltips"] = "Show Tooltips"
L["SHOWPETS_OPTION_TOOLTIP_BCC"] = [=[If you enable this option, pets will appear under the respective class they share Greater Blessings with.

|cffffff00Note: Warlock Imps will be hidden unless Phase Shift is off. Sayaad (Succubi/Incubi) will always be hidden, as their primary use is Demonic Sacrifice.|r]=]
L["SHOWPETS_OPTION_TOOLTIP_VANILLA"] = [=[If you enable this option, pets will appear under their own class.

|cffffff00Note: Due to the way Greater Blessings work and the way that pets are classified, Pets will need to be buffed separately. Additionally, Warlock Imps will be hidden automatically unless Phase Shift is off.|r]=]
L["Smart Buffs"] = "Smart Buffs"
L["This allows you to adjust the overall size of the Blessing Assignments Panel"] = "This allows you to adjust the overall size of the Blessing Assignments Panel"
L["This allows you to adjust the overall size of the PallyPower Buttons"] = "This allows you to adjust the overall size of the PallyPower Buttons"
L["Use in Party"] = "Use in Party"
L["Use when Solo"] = "Use when Solo"
L["Vertical Down | Left"] = "Vertical Down | Left"
L["Vertical Down | Right"] = "Vertical Down | Right"
L["Vertical Up | Left"] = "Vertical Up | Left"
L["Vertical Up | Right"] = "Vertical Up | Right"
L["Visibility Settings"] = "Visibility Settings"
L["Wait for Players"] = "Wait for Players"
L["What to buff with PallyPower"] = "What to buff with PallyPower"
L["While you are in a Raid dungeon, hide any players outside of the usual subgroups for that dungeon. For example, if you are in a 10-player dungeon, any players in Group 3 or higher will be hidden."] = "While you are in a Raid dungeon, hide any players outside of the usual subgroups for that dungeon. For example, if you are in a 10-player dungeon, any players in Group 3 or higher will be hidden."


local debug = false
--[===[@debug@
debug = true
--@end-debug@]===]

local L = LibStub("AceLocale-3.0"):NewLocale("EasyFrames", "enUS", true, debug)

L["loaded. Options:"] = true

L["Opacity"] = true
L["Opacity of combat texture"] = true

L["Main options"] = true
L["In main options you can set the global options like colored frames, buffs settings, etc"] = true

L["Percent"] = true
L["Current + Max"] = true
L["Current + Max + Percent"] = true
L["Current + Percent"] = true
L["Custom format"] = true
L["Smart"] = true

L["None"] = true
L["Outline"] = true
L["Thickoutline"] = true
L["Monochrome"] = true

L["Portrait"] = true
L["Default"] = true
L["Hide"] = true

L["HP and MP bars"] = true

L["Font size"] = true
L["Healthbar font size"] = true
L["Manabar font size"] = true
L["Font family"] = true
L["Healthbar font style"] = true
L["Healthbar font family"] = true
L["Manabar font style"] = true
L["Manabar font family"] = true
L["Font style"] = true

L["Reverse the direction of losing health/mana"] = true
L["By default direction starting from right to left. If checked direction of losing health/mana will be from left to right"] = true

L["Custom format of HP"] = true
L["You can set custom HP format. More information about custom HP format you can read on project site.\n\n" ..
    "Formulas:"] = true
L["Use full values of health"] = true
L["Formula converts the original value to the specified value.\n\n" ..
    "Description: for example formula is '%.fM'.\n" ..
    "The first part '%.f' is the formula itself, the second part 'M' is the abbreviation\n\n" ..
    "Example, value is 150550. '%.f' will be converted to '151' and '%.1f' to '150.6'"] = true
L["Value greater than 1000"] = true
L["Value greater than 100 000"] = true
L["Value greater than 1 000 000"] = true
L["Value greater than 10 000 000"] = true
L["Value greater than 100 000 000"] = true
L["Value greater than 1 000 000 000"] = true
L["By default all formulas use divider (for value eq 1000 and more it's 1000, for 1 000 000 and more it's 1 000 000, etc).\n\n" ..
    "If checked formulas will use full values of HP (without divider)"] = true
L["Displayed HP by pattern"] = true
L["You can use patterns:\n\n" ..
    "%CURRENT% - return current health\n" ..
    "%MAX% - return maximum of health\n" ..
    "%PERCENT% - return percent of current/max health\n\n" ..
    "All values are returned from formulas. For set abbreviation use formulas' fields"] = true
L["Use Chinese numerals format"] = true
L["By default all formulas use divider (for value eq 1000 and more is 1000, for 1 000 000 and more is 1 000 000, etc).\n" ..
    "But with this option divider eq 10 000 and 100 000 000.\n\n" ..
    "The description of the formulas remains the same, so the description of the formulas is not correct with this parameter, but the formulas work correctly.\n\n" ..
    "Use these formulas for Chinese numerals:\n" ..
    "Value greater than 1000 -> '%.2f万', and '%.2f萬' for zhTW.\n" ..
    "Value greater than 100 000 -> '%.1f万', and '%.1f萬' for zhTW.\n" ..
    "Value greater than 1 000 000 -> '%.1f万', and '%.1f萬' for zhTW.\n" ..
    "Value greater than 10 000 000 -> '%.0f万', and '%.0f萬' for zhTW.\n" ..
    "Value greater than 100 000 000 -> '%.2f亿', and '%.2f億' for zhTW.\n" ..
    "Value greater than 1 000 000 000 -> '%.2f亿', and '%.2f億' for zhTW.\n\n" ..
    "More information about Chinese numerals format you can read on project site"] = true

L["Custom format of mana"] = true
L["You can set custom mana format. More information about custom mana format you can read on project site.\n\n" ..
        "Formulas:"] = true
L["Use full values of mana"] = true
L["By default all formulas use divider (for value eq 1000 and more it's 1000, for 1 000 000 and more it's 1 000 000, etc).\n\n" ..
        "If checked formulas will use full values of mana (without divider)"] = true
L["Displayed mana by pattern"] = true
L["You can use patterns:\n\n" ..
        "%CURRENT% - return current mana\n" ..
        "%MAX% - return maximum of mana\n" ..
        "%PERCENT% - return percent of current/max mana\n\n" ..
        "All values are returned from formulas. For set abbreviation use formulas' fields"] = true


L["Frames"] = true
L["Setting for unit frames"] = true

L["Class colored healthbars"] = true
L["If checked frames becomes class colored.\n\n" ..
    "This option excludes the option 'Healthbar color is based on the current health value'"] = true
L["Healthbar color is based on the current health value"] = true
L["Healthbar color is based on the current health value.\n\n"..
    "This option excludes the option 'Class colored healthbars'"] = true
L["Custom buffsize"] = true
L["Buffs settings (like custom buffsize, highlight dispelled buffs, etc)"] = true
L["Turn on custom buffsize"] = true
L["Turn on custom target and focus frames buffsize"] = true
L["Buffs"] = true
L["Buffsize"] = true
L["Self buffsize"] = true
L["Buffsize that you create"] = true
L["Highlight dispelled buffs"] = true
L["Highlight buffs that can be dispelled from target frame"] = true
L["Dispelled buff scale"] = true
L["Dispelled buff scale that can be dispelled from target frame"] = true
L["Only if player can dispel them"] = true
L["Highlight dispelled buffs only if player can dispel them"] = true
L["Show only my debuffs"] = true
L["Show only my debuffs (which the player creates)"] = true
L["Max buffs count"] = true
L["How many buffs you can see on target/focus frames"] = true
L["Max debuffs count"] = true
L["How many debuffs you can see on target/focus frames"] = true

L["Class portraits"] = true
L["Replaces the unit-frame portrait with their class icon"] = true
L["Hide frames out of combat"] = true
L["Hide frames out of combat (for example in resting)"] = true
L["Only if HP equal to 100%"] = true
L["Hide frames out of combat only if HP equal to 100%"] = true
L["Opacity of frames"] = true
L["Opacity of frames when frames is hidden (in out of combat)"] = true

L["Texture"] = true
L["Set the frames bar Texture"] = true
L["Bright frames border"] = true
L["You can set frames border bright/dark color. From bright to dark. 0 - dark, 100 - bright"] = true
L["Use a light texture"] = true
L["Use a brighter texture (like Blizzard's default texture)"] = true
L["Set the manabar texture by force"] = true
L["Use a force manabar texture setter. The Blizzard UI resets to default manabar texture each time an addon tries to modify it. " ..
        "With this option, the texture setter will set texture by force.\n\n" ..
        "IMPORTANT. When this option is enabled the addon will use a more CPU. More information in the issue #28"] = true

L["Frames colors"] = true
L["In this section you can set the default colors for friendly, enemy and neutral frames"] = true
L["Set default friendly healthbar color"] = true
L["You can set the default friendly healthbar color for frames"] = true
L["Set default enemy healthbar color"] = true
L["You can set the default enemy healthbar color for frames"] = true
L["Set default neutral healthbar color"] = true
L["You can set the default neutral healthbar color for frames"] = true
L["Reset color to default"] = true

L["Other"] = true
L["In this section you can set the settings like 'show welcome message' etc"] = true
L["Show welcome message"] = true
L["Show welcome message when addon is loaded"] = true

L["Save positions of frames to current profile"] = true
L["Restore positions of frames from current profile"] = true
L["Saved"] = true
L["Restored"] = true

L["Frame"] = true
L["Select the frame you want to set the position"] = true
L["X"] = true
L["X coordinate"] = true
L["Y"] = true
L["Y coordinate"] = true

L["Set the color of the frame name"] = true

L["Player"] = true
L["In player options you can set scale player frame, healthbar text format, etc"] = true
L["Set the player's portrait"] = true
L["Player name"] = true
L["Player name font family"] = true
L["Player name font size"] = true
L["Player name font style"] = true
L["Player name color"] = true
L["Show or hide some elements of frame"] = true
L["Show player name"] = true
L["Show player name inside the frame"] = true
L["Player frame scale"] = true
L["Scale of player unit frame"] = true
L["Enable hit indicators"] = true
L["Show or hide the damage/heal which you take on your unit frame"] = true
L["Player healthbar text format"] = true
L["Set the player healthbar text format"] = true
L["Player manabar text format"] = true
L["Set the player manabar text format"] = true
L["Show player specialbar"] = true
L["Show or hide the player specialbar, like Paladin's holy power, Priest's orbs, Monk's harmony or Warlock's soul shards"] = true
L["Show player resting icon"] = true
L["Show or hide player resting icon when player is resting (e.g. in the tavern or in the capital)"] = true
L["Show player status texture (inside the frame)"] = true
L["Show or hide player status texture (blinking glow inside the frame when player is resting or in combat)"] = true
L["Show player combat texture (outside the frame)"] = true
L["Show or hide player red background texture (blinking red glow outside the frame in combat)"] = true
L["Show player group number"] = true
L["Show or hide player group number when player is in a raid group (over portrait)"] = true
L["Show player role icon"] = true
L["Show or hide player role icon when player is in a group"] = true
L["Show player PVP icon"] = true
L["Show or hide player PVP icon"] = true


L["Target"] = true
L["In target options you can set scale target frame, healthbar text format, etc"] = true
L["Set the target's portrait"] = true
L["Target name"] = true
L["Target name font family"] = true
L["Target name font size"] = true
L["Target name font style"] = true
L["Target name color"] = true
L["Target frame scale"] = true
L["Scale of target unit frame"] = true
L["Target healthbar text format"] = true
L["Set the target healthbar text format"] = true
L["Target manabar text format"] = true
L["Set the target manabar text format"] = true
L["Show target name"] = true
L["Show target name inside the frame"] = true
L["Show target of target frame"] = true
L["Show target combat texture (outside the frame)"] = true
L["Show or hide target red background texture (blinking red glow outside the frame in combat)"] = true
L["Show blizzard's target castbar"] = true
L["When you change this option you need to reload your UI (because it's Blizzard config variable). \n\nCommand /reload"] = true
L["Show target PVP icon"] = true
L["Show or hide target PVP icon"] = true


L["Focus"] = true
L["In focus options you can set scale focus frame, healthbar text format, etc"] = true
L["Set the focus's portrait"] = true
L["Focus name"] = true
L["Focus name font family"] = true
L["Focus name font size"] = true
L["Focus name font style"] = true
L["Focus name color"] = true
L["Focus frame scale"] = true
L["Scale of focus unit frame"] = true
L["Focus healthbar text format"] = true
L["Set the focus healthbar text format"] = true
L["Focus manabar text format"] = true
L["Set the focus manabar text format"] = true
L["Show target of focus frame"] = true
L["Show name of focus frame"] = true
L["Show name of focus frame inside the frame"] = true
L["Show focus combat texture (outside the frame)"] = true
L["Show or hide focus red background texture (blinking red glow outside the frame in combat)"] = true
L["Show focus PVP icon"] = true
L["Show or hide focus PVP icon"] = true


L["Pet"] = true
L["In pet options you can set scale pet frame, show/hide pet name, enable/disable pet hit indicators, etc"] = true
L["Pet name"] = true
L["Pet name font family"] = true
L["Pet name font size"] = true
L["Pet name font style"] = true
L["Pet name color"] = true
L["Pet frame scale"] = true
L["Scale of pet unit frame"] = true
L["Pet healthbar text format"] = true
L["Set the pet healthbar text format"] = true
L["Pet manabar text format"] = true
L["Set the pet manabar text format"] = true
L["Show pet name"] = true
L["Show or hide the damage/heal which your pet take on pet unit frame"] = true
L["Show pet combat texture (inside the frame)"] = true
L["Show or hide pet red background texture (blinking red glow inside the frame in combat)"] = true
L["Show pet combat texture (outside the frame)"] = true
L["Show or hide pet red background texture (blinking red glow outside the frame in combat)"] = true


L["Party"] = true
L["In party options you can set scale party frames, healthbar text format, etc"] = true
L["Party frames scale"] = true
L["Scale of party unit frames"] = true
L["Party healthbar text format"] = true
L["Set the party healthbar text format"] = true
L["Party manabar text format"] = true
L["Set the party manabar text format"] = true
L["Party frames names"] = true
L["Show names of party frames"] = true
L["Party names font family"] = true
L["Party names font size"] = true
L["Party names font style"] = true
L["Party names color"] = true
L["Show party pet frames"] = true

L["Boss"] = true
L["In boss options you can set scale boss frames, healthbar text format, etc"] = true
L["Boss frames scale"] = true
L["Scale of boss unit frames"] = true
L["Boss healthbar text format"] = true
L["Set the boss healthbar text format"] = true
L["Boss manabar text format"] = true
L["Set the boss manabar text format"] = true
L["Boss frames names"] = true
L["Show names of boss frames"] = true
L["Boss names font style"] = true
L["Boss names font family"] = true
L["Boss names font size"] = true
L["Boss names color"] = true
L["Show names of boss frames inside the frame"] = true

local _, addonTable = ...
local L = addonTable.L

L[ [=[|cffffffffPresets:|r Load pre-configured stat weights and caps for your spec. Click to select from class-specific presets, custom saved presets, or Pawn imports.

|cffffffffImport:|r Use stat weights from WoWSims, Pawn, or QuestionablyEpic. WoWSims and QE can also import pre-calculated reforge plans.

|cffffffffTarget Level:|r Select your raid difficulty to calculate stat caps at the appropriate level (PvP, Heroic Dungeon, or Raid).

|cffffffffBuffs:|r Enable raid buffs you'll have active (Spell Haste, Melee Haste, Mastery) to account for their stat bonuses in cap calculations.

|cffffffffStat Weights:|r Assign relative values to each stat. Higher weights mean the optimizer will prioritize that stat more when reforging. For example, if Hit has weight 60 and Crit has weight 20, the optimizer values Hit three times more than Crit.

|cffffffffStat Caps:|r Set minimum or maximum values for specific stats. Use presets (Hit Cap, Expertise Cap, Haste Breakpoints) or enter custom values. The optimizer will respect these caps when calculating the optimal reforge plan.]=] ] = [=[|cffffffffPresets:|r Load pre-configured stat weights and caps for your spec. Click to select from class-specific presets, custom saved presets, or Pawn imports.

|cffffffffImport:|r Use stat weights from WoWSims, Pawn, or QuestionablyEpic. WoWSims and QE can also import pre-calculated reforge plans.

|cffffffffTarget Level:|r Select your raid difficulty to calculate stat caps at the appropriate level (PvP, Heroic Dungeon, or Raid).

|cffffffffBuffs:|r Enable raid buffs you'll have active (Spell Haste, Melee Haste, Mastery) to account for their stat bonuses in cap calculations.

|cffffffffStat Weights:|r Assign relative values to each stat. Higher weights mean the optimizer will prioritize that stat more when reforging. For example, if Hit has weight 60 and Crit has weight 20, the optimizer values Hit three times more than Crit.

|cffffffffStat Caps:|r Set minimum or maximum values for specific stats. Use presets (Hit Cap, Expertise Cap, Haste Breakpoints) or enter custom values. The optimizer will respect these caps when calculating the optimal reforge plan.]=]
L["Accuracy"] = "Accuracy"
L["Active window color"] = "Active window color"
L["Add cap"] = "Add cap"
L["AoE"] = "AoE"
L["Apply %s Output"] = "Apply %s Output"
L["At least"] = "At least"
L["At most"] = "At most"
L["Balanced"] = "Balanced"
L["Branch & Bound Mode"] = "Branch & Bound Mode"
L[ [=[Branch & Bound Mode uses an alternative optimization algorithm designed to speed up calculations when using stat caps.

Performance depends on your cap configuration:
• Multiple soft caps (low values): Nearly instant
• Multiple hard caps (high values): May be slower than standard mode

The algorithm guarantees the same optimal result - only the computation speed varies.

Note: Only available when both stat caps are configured.]=] ] = [=[Branch & Bound Mode uses an alternative optimization algorithm designed to speed up calculations when using stat caps.

Performance depends on your cap configuration:
• Multiple soft caps (low values): Nearly instant
• Multiple hard caps (high values): May be slower than standard mode

The algorithm guarantees the same optimal result - only the computation speed varies.

Note: Only available when both stat caps are configured.]=]
L["Buffs"] = "Buffs"
L["Cap value"] = "Cap value"
L["Click to load preset"] = "Click to load preset"
L["Compute"] = "Compute"
L["Custom presets are shared across all characters of this class"] = "Custom presets are shared across all characters of this class"
L["Debug"] = "Debug"
L["Defensive"] = "Defensive"
L["Delete preset '%s'?"] = "Delete preset '%s'?"
L["Enable spec profiles"] = "Enable spec profiles"
L["Enter the preset name"] = "Enter the preset name"
L["Enter WoWSims JSON or Pawn string"] = "Enter WoWSims JSON or Pawn string"
L["Exactly"] = "Exactly"
L["Expertise hard cap"] = "Expertise hard cap"
L["Expertise soft cap"] = "Expertise soft cap"
L["Export"] = "Export"
L["Import"] = "Import"
L["Import WoWSims/Pawn/QE"] = "Import WoWSims/Pawn/QE"
L["Inactive window color"] = "Inactive window color"
L["Masterfrost"] = "Masterfrost"
L["Melee DW hit cap"] = "Melee DW hit cap"
L["Melee Haste"] = "Melee Haste"
L["Melee hit cap"] = "Melee hit cap"
L["No reforge"] = "No reforge"
L["Offensive"] = "Offensive"
L["Open window when reforging"] = "Open window when reforging"
L["Pause"] = "Pause"
L["Pawn successfully imported."] = "Pawn successfully imported."
L["Presets"] = "Presets"
L["Prevent windows from going off screen"] = "Prevent windows from going off screen"
L["Reforging window must be open"] = "Reforging window must be open"
L["Remove cap"] = "Remove cap"
L["Result"] = "Result"
L["Run Algorithm Comparison"] = "Run Algorithm Comparison"
L["Save current stat weights and caps as a custom preset"] = "Save current stat weights and caps as a custom preset"
L["Shift+Click to delete"] = "Shift+Click to delete"
L["Show help buttons"] = "Show help buttons"
L["Show import button on Reforging window"] = "Show import button on Reforging window"
L["Single Target"] = "Single Target"
L["Spell Haste"] = "Spell Haste"
L["Spell hit cap"] = "Spell hit cap"
L[ [=[Stat caps allow you to set minimum or maximum values for specific stats when reforging.

'At least' (minimum): The optimizer will try to reach this value before prioritizing other stats. For example, setting Hit to 'At least 2550' ensures you reach the 7.5% hit cap before investing in other stats.

'At most' (maximum): The optimizer will never exceed this value. For example, setting Hit to 'At most 2550' prevents wasting stats beyond the hit cap, redirecting excess reforges to other stats.

Use caps to ensure you meet important breakpoints while maximizing your overall stat weights.]=] ] = [=[Stat caps allow you to set minimum or maximum values for specific stats when reforging.

'At least' (minimum): The optimizer will try to reach this value before prioritizing other stats. For example, setting Hit to 'At least 2550' ensures you reach the 7.5% hit cap before investing in other stats.

'At most' (maximum): The optimizer will never exceed this value. For example, setting Hit to 'At most 2550' prevents wasting stats beyond the hit cap, redirecting excess reforges to other stats.

Use caps to ensure you meet important breakpoints while maximizing your overall stat weights.]=]
L["Stat Weights"] = "Stat Weights"
L["Summarize reforged stats on tooltip"] = "Summarize reforged stats on tooltip"
L[ [=[The Accuracy slider controls the size of the optimization search space.

Lower accuracy = Faster computation but may miss the optimal solution
Higher accuracy = Slower computation but more thorough search

The optimizer explores possible reforge combinations within this accuracy range. If you're not getting expected results, increase the accuracy.]=] ] = [=[The Accuracy slider controls the size of the optimization search space.

Lower accuracy = Faster computation but may miss the optimal solution
Higher accuracy = Slower computation but more thorough search

The optimizer explores possible reforge combinations within this accuracy range. If you're not getting expected results, increase the accuracy.]=]
L[ [=[The Apply window shows the reforge plan generated by the optimizer.

Each row shows an item and its recommended reforge (e.g., '192 Haste > Spirit' means reforge 192 Haste to Spirit).

Check/uncheck items to select which reforges to apply.

The total gold cost is displayed at the bottom.

Click 'Reforge' to apply all selected changes at once by visiting the reforge NPCs.]=] ] = [=[The Apply window shows the reforge plan generated by the optimizer.

Each row shows an item and its recommended reforge (e.g., '192 Haste > Spirit' means reforge 192 Haste to Spirit).

Check/uncheck items to select which reforges to apply.

The total gold cost is displayed at the bottom.

Click 'Reforge' to apply all selected changes at once by visiting the reforge NPCs.]=]
L[ [=[The Item Table shows your currently equipped gear and their stats.

Each row represents one equipped item. Only stats present on your gear are shown as columns.

After computing, items being reforged show:
• Red numbers: Stat being reduced
• Green numbers: Stat being added

Click an item icon to lock/unlock it. Locked items (shown with a lock icon) are ignored during optimization.]=] ] = [=[The Item Table shows your currently equipped gear and their stats.

Each row represents one equipped item. Only stats present on your gear are shown as columns.

After computing, items being reforged show:
• Red numbers: Stat being reduced
• Green numbers: Stat being added

Click an item icon to lock/unlock it. Locked items (shown with a lock icon) are ignored during optimization.]=]
L[ [=[The Result table shows the stat changes from the optimized reforge.

The left column shows your total stats after reforging.

The right column shows how much each stat changed:
- Green: Stat increased and improved your weighted score
- Red: Stat decreased and lowered your weighted score
- Grey: No meaningful change (either unchanged, or changed but weighted score stayed the same)

Click 'Show' to see a detailed breakdown of which items to reforge.

Click 'Reset' to clear the current reforge plan.]=] ] = [=[The Result table shows the stat changes from the optimized reforge.

The left column shows your total stats after reforging.

The right column shows how much each stat changed:
- Green: Stat increased and improved your weighted score
- Red: Stat decreased and lowered your weighted score
- Grey: No meaningful change (either unchanged, or changed but weighted score stayed the same)

Click 'Show' to see a detailed breakdown of which items to reforge.

Click 'Reset' to clear the current reforge plan.]=]
L["This import is missing player equipment data! Please make sure 'Gear' is selected when exporting from WoWSims."] = "This import is missing player equipment data! Please make sure 'Gear' is selected when exporting from WoWSims."
L["ticks"] = "ticks"
L[ [=[Weight after cap - The stat weight value to use once the cap is reached.

This allows you to control whether the optimizer continues valuing this stat after hitting the cap.

Set to 0 to stop reforging into this stat after the cap.
Set to a positive value to continue prioritizing it (useful for soft caps).]=] ] = [=[Weight after cap - The stat weight value to use once the cap is reached.

This allows you to control whether the optimizer continues valuing this stat after hitting the cap.

Set to 0 to stop reforging into this stat after the cap.
Set to a positive value to continue prioritizing it (useful for soft caps).]=]
L[ [=[Your Expertise rating is being converted to spell hit.

In Mists of Pandaria, casters benefit from Expertise due to it automatically converting to Hit at a 1:1 ratio.

The Hit value shown above includes this converted Expertise rating.

Note: The character sheet is bugged and doesn't show Expertise converted to spell hit, but the conversion works correctly in combat.]=] ] = [=[Your Expertise rating is being converted to spell hit.

In Mists of Pandaria, casters benefit from Expertise due to it automatically converting to Hit at a 1:1 ratio.

The Hit value shown above includes this converted Expertise rating.

Note: The character sheet is bugged and doesn't show Expertise converted to spell hit, but the conversion works correctly in combat.]=]


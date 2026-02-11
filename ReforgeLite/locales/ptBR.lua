local _, addonTable = ...
local L = addonTable.L

--[[Translation missing --]]
--[[ L[ [=[|cffffffffPresets:|r Load pre-configured stat weights and caps for your spec. Click to select from class-specific presets, custom saved presets, or Pawn imports.

|cffffffffImport:|r Use stat weights from WoWSims, Pawn, or QuestionablyEpic. WoWSims and QE can also import pre-calculated reforge plans.

|cffffffffTarget Level:|r Select your raid difficulty to calculate stat caps at the appropriate level (PvP, Heroic Dungeon, or Raid).

|cffffffffBuffs:|r Enable raid buffs you'll have active (Spell Haste, Melee Haste, Mastery) to account for their stat bonuses in cap calculations.

|cffffffffStat Weights:|r Assign relative values to each stat. Higher weights mean the optimizer will prioritize that stat more when reforging. For example, if Hit has weight 60 and Crit has weight 20, the optimizer values Hit three times more than Crit.

|cffffffffStat Caps:|r Set minimum or maximum values for specific stats. Use presets (Hit Cap, Expertise Cap, Haste Breakpoints) or enter custom values. The optimizer will respect these caps when calculating the optimal reforge plan.]=] ] = ""--]] 
--[[Translation missing --]]
--[[ L["Accuracy"] = ""--]] 
--[[Translation missing --]]
--[[ L["Active window color"] = ""--]] 
--[[Translation missing --]]
--[[ L["Add cap"] = ""--]] 
--[[Translation missing --]]
--[[ L["AoE"] = ""--]] 
--[[Translation missing --]]
--[[ L["Apply %s Output"] = ""--]] 
--[[Translation missing --]]
--[[ L["At least"] = ""--]] 
--[[Translation missing --]]
--[[ L["At most"] = ""--]] 
--[[Translation missing --]]
--[[ L["Balanced"] = ""--]] 
--[[Translation missing --]]
--[[ L["Branch & Bound Mode"] = ""--]] 
--[[Translation missing --]]
--[[ L[ [=[Branch & Bound Mode uses an alternative optimization algorithm designed to speed up calculations when using stat caps.

Performance depends on your cap configuration:
• Multiple soft caps (low values): Nearly instant
• Multiple hard caps (high values): May be slower than standard mode

The algorithm guarantees the same optimal result - only the computation speed varies.

Note: Only available when both stat caps are configured.]=] ] = ""--]] 
--[[Translation missing --]]
--[[ L["Buffs"] = ""--]] 
--[[Translation missing --]]
--[[ L["Cap value"] = ""--]] 
--[[Translation missing --]]
--[[ L["Click to load preset"] = ""--]] 
--[[Translation missing --]]
--[[ L["Compute"] = ""--]] 
--[[Translation missing --]]
--[[ L["Custom presets are shared across all characters of this class"] = ""--]] 
--[[Translation missing --]]
--[[ L["Debug"] = ""--]] 
--[[Translation missing --]]
--[[ L["Defensive"] = ""--]] 
--[[Translation missing --]]
--[[ L["Delete preset '%s'?"] = ""--]] 
--[[Translation missing --]]
--[[ L["Enable spec profiles"] = ""--]] 
--[[Translation missing --]]
--[[ L["Enter the preset name"] = ""--]] 
--[[Translation missing --]]
--[[ L["Enter WoWSims JSON or Pawn string"] = ""--]] 
--[[Translation missing --]]
--[[ L["Exactly"] = ""--]] 
--[[Translation missing --]]
--[[ L["Expertise hard cap"] = ""--]] 
--[[Translation missing --]]
--[[ L["Expertise soft cap"] = ""--]] 
--[[Translation missing --]]
--[[ L["Export"] = ""--]] 
--[[Translation missing --]]
--[[ L["Import"] = ""--]] 
--[[Translation missing --]]
--[[ L["Import WoWSims/Pawn/QE"] = ""--]] 
--[[Translation missing --]]
--[[ L["Inactive window color"] = ""--]] 
--[[Translation missing --]]
--[[ L["Masterfrost"] = ""--]] 
--[[Translation missing --]]
--[[ L["Melee DW hit cap"] = ""--]] 
--[[Translation missing --]]
--[[ L["Melee Haste"] = ""--]] 
--[[Translation missing --]]
--[[ L["Melee hit cap"] = ""--]] 
--[[Translation missing --]]
--[[ L["No reforge"] = ""--]] 
--[[Translation missing --]]
--[[ L["Offensive"] = ""--]] 
--[[Translation missing --]]
--[[ L["Open window when reforging"] = ""--]] 
L["Pause"] = "Pausar"
--[[Translation missing --]]
--[[ L["Pawn successfully imported."] = ""--]] 
--[[Translation missing --]]
--[[ L["Presets"] = ""--]] 
--[[Translation missing --]]
--[[ L["Prevent windows from going off screen"] = ""--]] 
--[[Translation missing --]]
--[[ L["Reforging window must be open"] = ""--]] 
--[[Translation missing --]]
--[[ L["Remove cap"] = ""--]] 
--[[Translation missing --]]
--[[ L["Result"] = ""--]] 
--[[Translation missing --]]
--[[ L["Run Algorithm Comparison"] = ""--]] 
--[[Translation missing --]]
--[[ L["Save current stat weights and caps as a custom preset"] = ""--]] 
--[[Translation missing --]]
--[[ L["Shift+Click to delete"] = ""--]] 
--[[Translation missing --]]
--[[ L["Show help buttons"] = ""--]] 
--[[Translation missing --]]
--[[ L["Show import button on Reforging window"] = ""--]] 
--[[Translation missing --]]
--[[ L["Single Target"] = ""--]] 
--[[Translation missing --]]
--[[ L["Spell Haste"] = ""--]] 
--[[Translation missing --]]
--[[ L["Spell hit cap"] = ""--]] 
--[[Translation missing --]]
--[[ L[ [=[Stat caps allow you to set minimum or maximum values for specific stats when reforging.

'At least' (minimum): The optimizer will try to reach this value before prioritizing other stats. For example, setting Hit to 'At least 2550' ensures you reach the 7.5% hit cap before investing in other stats.

'At most' (maximum): The optimizer will never exceed this value. For example, setting Hit to 'At most 2550' prevents wasting stats beyond the hit cap, redirecting excess reforges to other stats.

Use caps to ensure you meet important breakpoints while maximizing your overall stat weights.]=] ] = ""--]] 
--[[Translation missing --]]
--[[ L["Stat Weights"] = ""--]] 
--[[Translation missing --]]
--[[ L["Summarize reforged stats on tooltip"] = ""--]] 
--[[Translation missing --]]
--[[ L[ [=[The Accuracy slider controls the size of the optimization search space.

Lower accuracy = Faster computation but may miss the optimal solution
Higher accuracy = Slower computation but more thorough search

The optimizer explores possible reforge combinations within this accuracy range. If you're not getting expected results, increase the accuracy.]=] ] = ""--]] 
--[[Translation missing --]]
--[[ L[ [=[The Apply window shows the reforge plan generated by the optimizer.

Each row shows an item and its recommended reforge (e.g., '192 Haste > Spirit' means reforge 192 Haste to Spirit).

Check/uncheck items to select which reforges to apply.

The total gold cost is displayed at the bottom.

Click 'Reforge' to apply all selected changes at once by visiting the reforge NPCs.]=] ] = ""--]] 
--[[Translation missing --]]
--[[ L[ [=[The Item Table shows your currently equipped gear and their stats.

Each row represents one equipped item. Only stats present on your gear are shown as columns.

After computing, items being reforged show:
• Red numbers: Stat being reduced
• Green numbers: Stat being added

Click an item icon to lock/unlock it. Locked items (shown with a lock icon) are ignored during optimization.]=] ] = ""--]] 
--[[Translation missing --]]
--[[ L[ [=[The Result table shows the stat changes from the optimized reforge.

The left column shows your total stats after reforging.

The right column shows how much each stat changed:
- Green: Stat increased and improved your weighted score
- Red: Stat decreased and lowered your weighted score
- Grey: No meaningful change (either unchanged, or changed but weighted score stayed the same)

Click 'Show' to see a detailed breakdown of which items to reforge.

Click 'Reset' to clear the current reforge plan.]=] ] = ""--]] 
--[[Translation missing --]]
--[[ L["This import is missing player equipment data! Please make sure 'Gear' is selected when exporting from WoWSims."] = ""--]] 
--[[Translation missing --]]
--[[ L["ticks"] = ""--]] 
--[[Translation missing --]]
--[[ L[ [=[Weight after cap - The stat weight value to use once the cap is reached.

This allows you to control whether the optimizer continues valuing this stat after hitting the cap.

Set to 0 to stop reforging into this stat after the cap.
Set to a positive value to continue prioritizing it (useful for soft caps).]=] ] = ""--]] 
--[[Translation missing --]]
--[[ L[ [=[Your Expertise rating is being converted to spell hit.

In Mists of Pandaria, casters benefit from Expertise due to it automatically converting to Hit at a 1:1 ratio.

The Hit value shown above includes this converted Expertise rating.

Note: The character sheet is bugged and doesn't show Expertise converted to spell hit, but the conversion works correctly in combat.]=] ] = ""--]] 


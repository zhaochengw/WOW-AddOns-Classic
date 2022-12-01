local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(AddonName, "enUS", true)

if L then
L["Transmute"] = true

L["Reset due to update"] = function(oldv, newv) return "Reset some or entire data due to version update ("..oldv.." -> "..newv.. ")" end
L["extended"] = "(extended)"

L["minites"] = "m"
L["Enabled"] = true
L["Disabled"] = true

L["Display settings"] = true
L["Show floating UI frame"] = true
L["Floating UI width"] = true
L["Floating UI height"] = true
L["Desc - Frame"] = "|cff00ff00■|r |cffccaa00Shift - Drag to move the Frame|r"
L["Show minimap icon"] = true
L["Show info"] = true
L["per Character"] = true
L["per Realm"] = true
L["Hide info from level under"] = true

L["Tooltip - Character info."] = true
L["Line 1 of char info."] = true
L["Line 2 of char info."] = true
L["Left"] = true
L["Right"] = true
L["Desc_Char"] = "|cff00ff00■|r |cffccaa00Keywords for Character info|r|n"
    .."|cffccaa00[name]|r Name(Class color)|n"
    .."|cffccaa00[name2]|r Name(No color)|n"
    .."|cffccaa00[level] [expCur] [expMax] [exp%]|r|n"
    .."|cffccaa00[expRest] [expRest%] [zone] [subzone]|r|n"
    .."|cffccaa00[elapsed]|r Elapsed time after last update|n"
    .."|cffccaa00[item:|cffffeeaaname or ID|r]|r Item Icon and Count|n"
    .."|cffccaa00[cooldown]|r Tradeskill cooldowns|n"
    .."|cffccaa00[dqCom] [dqMax]|r|n"
    .."|cffccaa00[dqReset]|r Time left until DQ reset|n"
    .."|cffccaa00[color/######]|r Color starts(RGB code)|n|cffccaa00[color]|r Color ends|n"
    .."  attach /###### to apply color|n"
    .."|cffffeeaa(ex) |r|cffccaa00[color/ffffff]WHITE[color] =>|r |cffffffffWHITE|r|n   |cffccaa00[item:6265|cffcc3333/cc66cc|r] => |r|cffcc66cc".."|T"..GetItemIcon(6265)..":14:14|t12|r|n"
    .."|cffccaa00[currency:|cffffeeaaname or ID|r]|r Currency Icon and Count|n"
L["Tooltip - Raid instances"] = true
L["Lines of raid instances"] = true
L["Desc_Inst"] = "|cff00ff00■|r |cffccaa00Keywords for Instance info|r|n"
    .."|cffccaa00[instName]|r Instance name|n"
    .."|cffccaa00[difficulty]|r Size and Difficulty|n"
    .."|cffccaa00[progress]|r Number of bosses killed|n"
    .."|cffccaa00[bosses]|r Number of bosses|n"
    .."|cffccaa00[time]|r Time to reset|n"
    .."|cffccaa00[instID]|r Instance ID|n"
L["Tooltip - Heroic instances"] = true
L["Lines of heroic instances"] = true
L["Show in one-line"] = true

L["Select character"] = true
L["Reset selected character"] = true
L["Are you really want to reset?"] = true
L["Reset all characters"] = true
L["Copy settings to"] = true
L["Copy"] = true
L["Confirm copy"] = "Overwrite settings to target character"

-- Localized Translation Table
L["color"     ] = true
L["item"      ] = true
L["currency"  ] = true
L["name"      ] = true
L["name2"     ] = true
L["zone"      ] = true
L["subzone"   ] = true
L["cooldown"  ] = true
L["elapsed"   ] = true
L["level"     ] = true
L["expCur"    ] = true
L["expMax"    ] = true
L["exp%"      ] = true
L["expRest"   ] = true
L["expRest%"  ] = true
L["dqCom"     ] = true
L["dqMax"     ] = true
L["dqReset"   ] = true
L["instName"  ] = true
L["instID"    ] = true
L["difficulty"] = true
L["progress"  ] = true
L["bosses"    ] = true
L["time"      ] = true
-- Localized Currency Name
L["gold"    ] = true
L["silver"  ] = true
L["copper"  ] = true
L["honor"   ] = true
L["arena"   ] = true
L["jewel"   ] = true
L["cook"    ] = true
L["heroism" ] = true
L["valor"   ] = true
L["conquest"] = true
L["triumph" ] = true
L["frost"   ] = true
L["champion"] = true
L["AV"      ] = true
L["AB"      ] = true
L["EotS"    ] = true
L["SotA"    ] = true
L["WSG"     ] = true
L["WG"      ] = true
L["IoC"     ] = true
L["shard"   ] = true
L["venture" ] = true
L["justice" ] = true
-- Heroic dungeon names, abbrs
L["TOK"] = true
L[ "AN"] = true
L["DTK"] = true
L["Gun"] = true
L["HoL"] = true
L["HoS"] = true
L["CoS"] = true
L["Nex"] = true
L["Ocu"] = true
L[ "VH"] = true
L[ "UK"] = true
L[ "UP"] = true
L["ToC"] = true
L["HoR"] = true
L["PoS"] = true
L["FoS"] = true
end

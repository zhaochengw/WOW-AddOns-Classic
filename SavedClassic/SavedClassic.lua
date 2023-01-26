local addonName, _ = ...
SavedClassic = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0")

SavedClassic.name = addonName
--SavedClassic.version = GetAddOnMetadata(addonName, "Version")
SavedClassic.version = "3.0.9"

local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

local MSG_PREFIX = "|cff00ff00■ |cffffaa00Saved!|r "
local MSG_SUFFIX = " |cff00ff00■|r"

local player , _ = UnitName("player")
local _, class, _ = UnitClass("player")
local p = function(str) print(MSG_PREFIX..str..MSG_SUFFIX) end

local dbDefault = {
    realm = {
        [player] = {
            frameX = 100,   frameY = 25,
            showInfoPer = "realm",
            hideLevelUnder = 1,

            default = true,
            minimapIcon = { hide = false },

            expCurrent = -1, expMax = -1, expPercent = -1, ExpRest = -1,

            honorPoint = -1, arenaPoint = -1,
            dqComplete = -1, dqMax = -1, dqReset = -1,

            lastUpdate = -1,
        }
    }
}

SavedClassic.ts = { -- Tradeskills of long cooldowns
    -- Alchemy
    [53781] = { altName = L["Transmute"], },    -- Transmute
    [60893] = { icon = "136240", },   -- Northrend Alchemy Research
    -- Mining
    [55208] = { icon = "237046", },   -- Smelt Titansteel
    -- Tailoring
    [56001] = { icon = "237025", },   -- Moonshroud
    [56002] = { icon = "237022", },   -- Ebonweave
    [56003] = { icon = "237026", },   -- Spellweave
    [56005] = { icon = "133666", },   -- Glacial Bag
    -- Inscription
    [61177] = { icon = "237171", },   -- Northrend Inscription Research
    [61288] = { icon = "237133", },   -- Minor Inscription Research
    -- Jewelcrafting
    [62242] = { icon = "134095", },   -- Icy Prism
}
SavedClassic.items = {  -- Items to count always
    [6265] = { },   -- Soulshard
}
SavedClassic.currencies = {
    [1]   = { altName = L["gold"    ], icon = "|TInterface/MoneyFrame/UI-GoldIcon:14:14:2:0|t"},   -- Gold
    [2]   = { altName = L["silver"  ], icon = "|TInterface/MoneyFrame/UI-SilverIcon:14:14:2:0|t" },   -- Silver
    [3]   = { altName = L["copper"  ], icon = "|TInterface/MoneyFrame/UI-CopperIcon:14:14:2:0|t" },   -- Copper
    [1901]= { altName = L["honor"   ] }, -- Honor point
    [1900]= { altName = L["arena"   ] }, -- Arena point
    [61]  = { altName = L["jewel"   ] }, -- Dalaran Jewelcrafter's Token Wrath of the Lich King  3.0.2
    [81]  = { altName = L["cook"    ] }, -- Epicurean's Award    Miscellaneous   3.1.0
    [101] = { altName = L["heroism" ] }, -- Emblem of Heroism    Dungeon and Raid    3.1.0
    [102] = { altName = L["valor"   ] }, -- Emblem of Valor  Dungeon and Raid    3.1.0
    [221] = { altName = L["conquest"] }, -- Emblem of Conquest   Dungeon and Raid    3.1.0
    [301] = { altName = L["triumph" ] }, -- Emblem of Triumph    Dungeon and Raid    3.3.5
    [341] = { altName = L["frost"   ] }, -- Emblem of Frost  Dungeon and Raid    3.3.5
    [241] = { altName = L["champion"] }, -- Champion's Seal  Wrath of the Lich King  3.1.0
    [121] = { altName = L["AV"      ] }, -- Alterac Valley Mark of Honor Player vs. Player   3.1.0
    [122] = { altName = L["AB"      ] }, -- Arathi Basin Mark of Honor   Player vs. Player   3.1.0
    [123] = { altName = L["EotS"    ] }, -- Eye of the Storm Mark of Honor   Player vs. Player   3.1.0
    [124] = { altName = L["SotA"    ] }, -- Strand of the Ancients Mark of Honor Player vs. Player   3.1.0
    [125] = { altName = L["WSG"     ] }, -- Warsong Gulch Mark of Honor  Player vs. Player   3.1.0
    [126] = { altName = L["WG"      ] }, -- Wintergrasp Mark of Honor    Player vs. Player   3.1.0
    [321] = { altName = L["IoC"     ] }, -- Isle of Conquest Mark of Honor   Player vs. Player   3.3.5
    [161] = { altName = L["shard"   ] }, -- Stone Keeper's Shard Player vs. Player   3.1.0
    [201] = { altName = L["venture" ] }, -- Venture Coin Player vs. Player   3.1.0
    [42]  = { altName = L["justice" ] }, -- Badge of Justice Miscellaneous   3.0.2
    order = {
        1,2,3,1901,1900,                  -- Money, Honor, Arena
        61,81,                      -- Tradeskills
        101,102,221,301,341,241,    -- Emblems
        121,122,123,124,125,126,321, -- Mark of Honors
        161,201,42                  -- PVP, etc
    }
}
setmetatable(SavedClassic.currencies, { __index = 
        function(t,k)
            for id, v in pairs(t) do
                if v.altName and v.altName == k then
                    v.id = id   -- Will be used in _TranslationTable
                    return v
                end
            end
            return nil
        end }
)

SavedClassic.abbr = {}
SavedClassic.abbr.heroic = {
    [C_Map.GetAreaInfo(4494)] = L["TOK"],
    [C_Map.GetAreaInfo(4277)] = L[ "AN"],
    [C_Map.GetAreaInfo(4196)] = L["DTK"],
    [C_Map.GetAreaInfo(4416)] = L["Gun"],
    [C_Map.GetAreaInfo(4272)] = L["HoL"],
    [C_Map.GetAreaInfo(4264)] = L["HoS"],
    [C_Map.GetAreaInfo(4100)] = L["CoS"],
    [C_Map.GetAreaInfo(4265)] = L["Nex"],
    [C_Map.GetAreaInfo(4228)] = L["Ocu"],
    [C_Map.GetAreaInfo(4415)] = L[ "VH"],
    [C_Map.GetAreaInfo(206 )] = L[ "UK"],
    [C_Map.GetAreaInfo(1196)] = L[ "UP"],
    [C_Map.GetAreaInfo(4723)] = L["ToC"],
    [C_Map.GetAreaInfo(4820)] = L["HoR"],
    [C_Map.GetAreaInfo(4813)] = L["PoS"],
    [C_Map.GetAreaInfo(4809)] = L["FoS"],
}
SavedClassic.abbr.raid = {
    [C_Map.GetAreaInfo(3456)] = L["Naxx"],
    [C_Map.GetAreaInfo(4493)] = L["OS"],
    [C_Map.GetAreaInfo(4500)] = L["EoE"],
    [C_Map.GetAreaInfo(4273)] = L["ULD"],
    [C_Map.GetAreaInfo(4722)] = L["ToC"],
    [C_Map.GetAreaInfo(4812)] = L["ICC"],
    [C_Map.GetAreaInfo(4987)] = L["RS"],
    [C_Map.GetAreaInfo(4603)] = L["VoA"],
}

local _TranslationTable = {
    ["color"    ] = function(_, option, color) return (color and color ~= "") and "|cff"..color or "|r" end,
    ["item"     ] = function(db, option, color)
                        local id = SavedClassic:StripLink(option)
                        local result = "|T"..GetItemIcon(id)..":14:14|t"..(db.itemCount[id] or "-")
                        if color and color ~= "" then result = "|cff"..color..result.."|r" end
                        return result
                    end,
    ["currency" ] = function(db, option, color)
                        local id = tonumber(option)
                        local currency = id and SavedClassic.currencies[id] or SavedClassic.currencies[option]
                        if currency then
                            id = id or currency.id
                            local result = currency.icon..(db.currencyCount[id] or "")
                            if color and color ~= "" then result = "|cff"..color..result.."|r" end
                            return result
                        else
                            return ""
                        end
                    end,
    ["name"     ] = "coloredName",
    ["name2"    ] = "name",
    ["zone"     ] = "zone",
    ["subzone"  ] = "subzone",
    ["cooldown" ] = "tsstr",
    ["elapsed"  ] = "elapsedTime",
    ["level"    ] = "level",
    ["expCur"   ] = "expCurrent",
    ["expMax"   ] = "expMax",
    ["exp%"     ] = "expPercent",
    ["expRest"  ] = "restXP",
    ["expRest%" ] = "restPercent",
    ["dqCom"    ] = "dqComplete",
    ["dqMax"    ] = "dqMax",
    ["dqReset"  ] = "dqReset",
    ["instName" ] = "name",
    ["instID"   ] = "id",
    ["difficulty"]= "difficultyName",
    ["progress" ] = "progress",
    ["bosses"   ] = "numBoss",
    ["time"     ] = function(instance, _, color)
                        local result = SecondsToTime(instance.reset - time())
                        if color and color ~= "" then result = "|cff"..color..result.."|r" end
                        return result
                    end,
    byLocale = {
        [L["color"     ] ] = "color",
        [L["item"      ] ] = "item",
        [L["currency"  ] ] = "currency",
        [L["name"      ] ] = "name",
        [L["name2"     ] ] = "name2",
        [L["zone"      ] ] = "zone",
        [L["subzone"   ] ] = "subzone",
        [L["cooldown"  ] ] = "cooldown",
        [L["elapsed"   ] ] = "elapsed",
        [L["level"     ] ] = "level",
        [L["expCur"    ] ] = "expCur",
        [L["expMax"    ] ] = "expMax",
        [L["exp%"      ] ] = "exp%",
        [L["expRest"   ] ] = "expRest",
        [L["expRest%"  ] ] = "expRest%",
        [L["dqCom"     ] ] = "dqCom",
        [L["dqMax"     ] ] = "dqMax",
        [L["dqReset"   ] ] = "dqReset",
        [L["instName"  ] ] = "instName",
        [L["instID"    ] ] = "instID",
        [L["difficulty"] ] = "difficulty",
        [L["progress"  ] ] = "progress",
        [L["bosses"    ] ] = "bosses",
        [L["time"      ] ] = "time",
    }
}
setmetatable(_TranslationTable, { __index = function(t,k) return t.byLocale[k] and t[t.byLocale[k] ] or k end })

function SavedClassic:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("SavedClassicDB", dbDefault)

    -- Reset old db
    if not self.db.global.version then
        self.db:ResetDB()
    elseif self.db.global.version < "3.0.0" then
        p(L["Reset due to update"](self.db.global.version, self.version))
        self.db:ResetDB()
    end

    self.db.global.version = self.version

    if self.db.realm[player].default then self:InitPlayerDB() end

    self:SetOrder()

    self:InitUI()
    self:InitDBIcon()

    self:BuildOptions() -- Build some tables and self.optionsTable
    LibStub("AceConfig-3.0"):RegisterOptionsTable(self.name, self.optionsTable)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(self.name, self.name, nil)

    self:RegisterEvent("PLAYER_MONEY", "CurrencyUpdate")
    self:RegisterEvent("PLAYER_XP_UPDATE")
    self:RegisterEvent("PLAYER_LEAVING_WORLD", "SaveZone")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "SaveInfo")

    self:RegisterEvent("ZONE_CHANGED", "SaveInfo")
    self:RegisterEvent("ZONE_CHANGED_INDOORS", "SaveInfo")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "RequestRaidInfo")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "CurrencyUpdate")
    self:RegisterEvent("UPDATE_INSTANCE_INFO", "SaveInfo")  -- API RequestRaidInfo() triggers UPDATE_INSTANCE_INFO

    self:RegisterEvent("TRADE_SKILL_UPDATE", "SaveTSCooldowns")

    self:RegisterEvent("BAG_UPDATE_DELAYED")
    self:RegisterEvent("QUEST_TURNED_IN")

    self:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN", "CurrencyUpdate")

    self.totalMoney = 0 -- Total money except current character
    for character, saved in pairs(self.db.realm) do
        if character and (character ~= player) and saved.currencyCount and saved.currencyCount[0] then
            self.totalMoney = self.totalMoney + saved.currencyCount[0]
        end
    end

    self:ClearItemCount()
    self:QUEST_TURNED_IN()
    self:BAG_UPDATE_DELAYED()
end

function SavedClassic:OnEnable()
    p(L["Enabled"])
end

function SavedClassic:OnDisable()
    p(L["Disabled"])
end

function SavedClassic:SetOrder()
    local db = self.db.realm[player]
    self.order = { }
    for k, v in pairs(self.db.realm) do
        table.insert(self.order, { name = v.name, level = v.level })
    end
    table.sort(self.order,
        function(a,b)
            if db.currentFirst then
                if a.name == player then return true end
                if b.name == player then return false end
            end
            local al = a.level or 0
            local bl = b.level or 0
            if al == bl then
                return a.name < b.name
            else
                return al > bl
            end
        end)
end

function SavedClassic:InitPlayerDB()
    local playerdb = self.db.realm[player]
    local classColor = RAID_CLASS_COLORS[class]

    playerdb.default = false
    playerdb.name = player
    playerdb.coloredName = string.format("|cff%.2x%.2x%.2x%s|r", classColor.r*255, classColor.g*255, classColor.b*255, player)

    playerdb.info1 = true
    playerdb.info1_1 = ""
    playerdb.info1_2 = "\n["..L["currency"]..":"..L["gold"].."/ffee99]  "
    playerdb.info2 = true
    playerdb.info2_1 = ""

    if UnitLevel("player") < GetMaxPlayerLevel() then
        if class == "WARLOCK" then
            playerdb.info1_1 = "\n["..L["color"].."/00ff00]■["..L["color"].."] [["..L["level"].."/ffffff]:["..L["name"].."]] ["..L["item"]..":6265/cc66cc] ["..L["color"].."/ffffff](["..L["zone"].."]: ["..L["subzone"].."])["..L["color"].."]"
        else
            playerdb.info1_1 = "\n["..L["color"].."/00ff00]■["..L["color"].."] [["..L["level"].."/ffffff]:["..L["name"].."]] ["..L["color"].."/ffffff](["..L["zone"].."]: ["..L["subzone"].."])["..L["color"].."]"
        end
        playerdb.info2_1 = "   ["..L["color"].."/cc66ff]["..L["expCur"].."]/["..L["expMax"].."] (["..L["exp%"].."]%)["..L["color"].."] ["..L["color"].."/66ccff]+["..L["expRest"].."] (["..L["expRest%"].."]%)["..L["color"].."]"
        playerdb.info2_2 = "["..L["color"].."/ffffff]["..L["currency"]..":"..L["justice"].."]["..L["currency"]..":"..L["honor"].."]["..L["color"].."]"
    else
        if class == "WARLOCK" then
            playerdb.info1_1 = "\n["..L["color"].."/00ff00]■["..L["color"].."] [["..L["name"].."]] ["..L["item"]..":6265/cc66cc] ["..L["color"].."/ffffff](["..L["zone"].."]: ["..L["subzone"].."])["..L["color"].."]"
        else
            playerdb.info1_1 = "\n["..L["color"].."/00ff00]■["..L["color"].."] [["..L["name"].."]] ["..L["color"].."/ffffff](["..L["zone"].."]: ["..L["subzone"].."])["..L["color"].."]"
        end
        playerdb.info2_1 = "   ["..L["color"].."/ffffff]["..L["currency"]..":"..L["conquest"].."] ["..L["currency"]..":"..L["valor"].."] [".. L["currency"]..":"..L["arena"].."] [".. L["currency"]..":"..L["honor"].."]["..L["color"].."]"
        playerdb.info2_2 = ""
    end

    playerdb.info3 = true
    playerdb.info3_1 = "   ["..L["instName"].."] (["..L["difficulty"].."]) ["..L["progress"].."]/["..L["bosses"].."]"
    playerdb.info3_2 = "["..L["time"].."] "
    playerdb.info4 = true
    playerdb.info4_1 = "   ["..L["color"].."/ffff99]["..L["instName"].."] (["..L["difficulty"].."]) ["..L["progress"].."]/["..L["bosses"].."]["..L["color"].."]"
    playerdb.info4_2 = "["..L["time"].."/ffff99] "

    playerdb.raids = { }
    playerdb.heroics = { }
    playerdb.tradeSkills = { }
    playerdb.itemCount = { }
    playerdb.currencyCount = { }

    playerdb.zone = ""
    playerdb.subzone = ""

    playerdb.lastUpdate = currentTime
    playerdb.frameShow = false

    self:PLAYER_MONEY()
    self:PLAYER_XP_UPDATE()
end

function SavedClassic:ResetPlayerDB()
    for k,_ in pairs(self.db.realm[player]) do
        self.db.realm[player][k] = nil
    end
    for k,v in pairs(dbDefault.realm[player]) do
        self.db.realm[player][k] = v
    end
    self:InitPlayerDB()
    self:SaveInfo()
end

function SavedClassic:ResetWholeDB()
    self.db:ResetDB()
    self.db.global.version = self.version
    self:InitPlayerDB()
    self:SetOrder()
    self.totalMoney = 0
    self:SaveInfo()
end

function SavedClassic:RequestRaidInfo()
    RequestRaidInfo()   -- RequestRaidInfo() triggers UPDATE_INSTANCE_INFO
end

function SavedClassic:SaveInfo()
    local db = self.db.realm[player]
    local classColor = RAID_CLASS_COLORS[class]
    db.coloredName = string.format("|cff%.2x%.2x%.2x%s|r", classColor.r*255, classColor.g*255, classColor.b*255, player)

    local raids, heroics = { }, { }
    local currentTime = time()

    -- instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName
    --      = GetSavedInstanceInfo(index)
    for i = 1, GetNumSavedInstances() do
        local instance = { }
        local isLocked, extended, remain, isRaid
        instance.name, instance.id, remain, _, isLocked, extended, _, isRaid, _, instance.difficultyName, instance.numBoss, instance.progress = GetSavedInstanceInfo(i)
        if isLocked or extended then
            instance.reset = remain + currentTime
            if extended then
                instance.extended = L["extended"]
            else
                instance.extended = ""
            end
            if isRaid then
                table.insert(raids, instance)
            else
                table.insert(heroics, instance)
            end
        end
    end

    table.sort(raids, function(a,b) return ( a.name < b.name ) or ( a.name == b.name and a.difficultyName < b.difficultyName ) end)
    table.sort(heroics, function(a,b) return ( a.name < b.name ) or ( a.name == b.name and a.difficultyName < b.difficultyName ) end)

    db.raids = raids
    db.heroics = heroics

    self:PLAYER_XP_UPDATE()
    self:CurrencyUpdate()
    self:SaveZone() 
    self:SaveTSCooldowns()
end

function SavedClassic:QUEST_TURNED_IN()
    local db = self.db.realm[player]
    local completed = GetDailyQuestsCompleted() or 0
    if (db.dqComplete or 0) == completed then
        C_Timer.After(2, function()
            db.dqComplete = GetDailyQuestsCompleted() or 0
        end)
    else
        db.dqComplete = completed
    end
    db.dqMax = GetMaxDailyQuests() or 0
    db.dqResetReal = time() + (GetQuestResetTime() or 0)    -- resolve game time to real time
end

function SavedClassic:PLAYER_XP_UPDATE()
    local db = self.db.realm[player]
    db.level = UnitLevel("player")
    db.expCurrent = UnitXP("player")
    local expMax = UnitXPMax("player")
    if expMax == 0 then expMax = db.expMax or 1 end
    db.expMax = expMax
    db.expPercent = floor(db.expCurrent / db.expMax * 100)
    db.expRest = GetXPExhaustion() or 0

    self:SetOrder()
end

function SavedClassic:SaveZone()
    local db = self.db.realm[player]
    local zone = GetZoneText()
    if zone and zone ~= "" then
        db.zone = zone
        db.subzone = GetSubZoneText()
    end
    db.lastUpdate = time()
end

function SavedClassic:SaveTSCooldowns()
    local db = self.db.realm[player]
    local currentTime = time()
    db.tradeSkills = db.tradeSkills or {}

    for id, ts in pairs(self.ts) do
        local start, duration = GetSpellCooldown(id)
        if duration > 0 then
            local remain =  start + duration - GetTime()
            if remain > 0 and remain < duration+100 then
                local ends = currentTime + remain   -- resolve game time to real time
                db.tradeSkills[id] = db.tradeSkills[id] or {}
                db.tradeSkills[id].ends = ends
                db.tradeSkills[id].name = ts.altName or GetSpellInfo(id)
            end
        else
            db.tradeSkills[id] = nil
        end
    end
end

function SavedClassic:ClearItemCount()
    self.db.realm[player].itemCount = { }
end

function SavedClassic:BAG_UPDATE_DELAYED()
    local db = self.db.realm[player]
    local infoStr = db.info1_1..db.info1_2..db.info2_1..db.info2_2
    local itemList = string.gmatch(infoStr, "%%[Iia]%{[^}]+%}")

    for itemLink in itemList do
        local itemID = self:StripLink(itemLink)
        db.itemCount[itemID] = GetItemCount(itemID, true) or 0
    end
    for id, _ in pairs(self.items) do
        db.itemCount[id] = GetItemCount(id, true) or 0
    end
end

function SavedClassic:StripLink(link)
    return tonumber(string.match(link, "(%d+):") or string.match(link, "(%d+)"))
end

function SavedClassic:PLAYER_MONEY()
    local money = abs(GetMoney())
    local db = self.db.realm[player]
    db.currencyCount[0] = money
    db.currencyCount[1] = floor(money / 10000)
    db.currencyCount[2] = floor(money % 10000 / 100)
    db.currencyCount[3] = floor(money % 100)
end

function SavedClassic:CurrencyUpdate()
    local db = self.db.realm[player]
    for currencyID, v in pairs(self.currencies) do
        local _, currentAmount, _ = GetCurrencyInfo(currencyID)
        db.currencyCount[currencyID] = currentAmount
        --local name, currentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered = GetCurrencyInfo(currencyID)
        --db.currencyCount[currencyID] = { currentAmount, earnedThisWeek, weeklyMax, totalMax }
    end
    -- It doesn't matter that belows overwrite 1-5
    self:PLAYER_MONEY()
    -- name, CurrentAmount, texture, earnedThisWeek, weeklyMax, totalMax, isDiscovered = GetCurrencyInfo(index)
    -- Achievement, Honor, Arena points
    -- Emblems of Heroism, Valor, Conquest, Triumph, Frost
--  local _, db.honorPoint, _, earnedThisWeek, weeklyMax, totalMax = GetCurrencyInfo(392)
--  local _, db,justice, _, earnedThisWeek, weeklyMax, totalMax = GetCurrencyInfo(395)
end

function SavedClassic:ShowInfoTooltip(tooltip)
    local mode = ""
    local db = self.db.realm[player]
    local realm = ""
    if db.showInfoPer == "realm" then realm = " - " .. GetRealmName() end

    local totalGold = floor((self.totalMoney + db.currencyCount[0]) / 10000)
    tooltip:AddDoubleLine(MSG_PREFIX .. realm .. MSG_SUFFIX, totalGold.. self.currencies[1].icon)

    self:SaveZone()
    self:QUEST_TURNED_IN()
    self:BAG_UPDATE_DELAYED()
    self:CurrencyUpdate()

    if db.showInfoPer == "realm" then
        for _, v in ipairs(self.order) do
            if v.level < db.hideLevelUnder then
            else    
                self:ShowInstanceInfo(tooltip, v.name)
            end
        end
    else
        self:ShowInstanceInfo(tooltip, player)
    end
end

function SavedClassic:ShowInstanceInfo(tooltip, character)

    local db = self.db.realm[character]
    local currentTime = time()

    local tsstr = ""
    if db.tradeSkills then
        for id, cooldown in pairs(db.tradeSkills) do
            local ts = self.ts[id]
            if ts and cooldown and cooldown.ends then
                local remain = cooldown.ends - currentTime
                if remain > 0 then
                    tsstr = tsstr..(ts.altName or ("|T"..ts.icon..":14:14|t"))..string.format("%02d:%02d", floor(remain / 3600), floor(remain % 3600 / 60))
                else
                    db.tradeSkills[id] = nil
                end
            else
                db.tradeSkills[id] = nil
            end
        end
    end
    db.tsstr = tsstr

    if db.dqResetReal and currentTime > db.dqResetReal then
        db.dqComplete = 0
    end

    db.dqReset = SecondsToTime(GetQuestResetTime() or 0)
    db.elapsedTime = SecondsToTime(currentTime - db.lastUpdate)
    db.restXP = floor(min(db.expRest + (currentTime - db.lastUpdate) / 28800 * 0.05 * db.expMax, db.expMax * 1.5))
    db.restPercent = floor(db.restXP / db.expMax * 100)

    if db.info1 then
        local line1_1 = self:TranslateCharacter(db.info1_1, db)
        local line1_2 = self:TranslateCharacter(db.info1_2, db)
        tooltip:AddDoubleLine(line1_1, line1_2)
    end
    if db.info2 then
        local line2_1 = self:TranslateCharacter(db.info2_1, db)
        local line2_2 = self:TranslateCharacter(db.info2_2, db)
        tooltip:AddDoubleLine(line2_1, line2_2)
    end

    db.raids = db.raids or {}
    if db.info3 then
        if db.info3oneline then
            local raidList = {}
            for i = 1, #db.raids do
                local instance = db.raids[i]
                local remain = SecondsToTime(instance.reset - time())
                local name = self.abbr.raid[instance.name] or instance.name
                if remain and ( remain ~= "" ) then
                    raidList[name] = raidList[name] or {}
                    table.insert(raidList[name], instance.difficultyName)
                end
            end
            local oneline = ""
            for name, v in pairs(raidList) do
                oneline = oneline.." "..name.."("..v[1]..(v[2] and "/"..v[2] or "")..")"
            end
            if oneline ~= "" then
                oneline = oneline:gsub("^ ","") -- trim leading space
                tooltip:AddLine("   "..oneline)
            end
        else
            for i = 1, #db.raids do
                local instance = db.raids[i]
                local remain = SecondsToTime(instance.reset - time())
                if remain and ( remain ~= "" ) then
                    local line3_1 = self:TranslateInstance(db.info3_1, instance)
                    local line3_2 = self:TranslateInstance(db.info3_2, instance)
                    tooltip:AddDoubleLine(line3_1, line3_2)
                end
            end
        end
    end

    db.heroics = db.heroics or {}
    if db.info4 then
        if db.info4oneline then
            local oneline = ""
            for i = 1, #db.heroics do
                local instance = db.heroics[i]
                local remain = SecondsToTime(instance.reset - time())
                if remain and ( remain ~= "" ) then
                    oneline = oneline.." "..(self.abbr.heroic[instance.name] or instance.name)
                end
            end
            if oneline ~= "" then
                oneline = oneline:gsub("^ ","") -- trim leading space
                tooltip:AddLine("|cffffff99   "..oneline.."|r")
            end
        else
            for i = 1, #db.heroics do
                local instance = db.heroics[i]
                local remain = SecondsToTime(instance.reset - time())
                if remain and ( remain ~= "" ) then
                    local line4_1 = self:TranslateInstance(db.info4_1, instance)
                    local line4_2 = self:TranslateInstance(db.info4_2, instance)
                    tooltip:AddDoubleLine(line4_1, line4_2)
                end
            end
        end
    end
end

function SavedClassic:TranslateCharacter(line, db)
    -- [keyword] [keyword:option] [keyword/color] [keyword:option/color]
    return line:gsub("(%[([^]^[^/^:]*):?([^]^[^/]*)/?([^]^[]*)%])", function(...) return self:TranslateCharacterWord(db, ...) end )
end

function SavedClassic:TranslateCharacterWord(db, strBefore, keyword, option, color)
    local tKeyword = _TranslationTable[keyword]
    local result = strBefore
    if tKeyword then 
        if type(tKeyword) == "function" then    -- color, item, currency need option1, option2 is color if present
            result = tKeyword(db, option, color)
        else                                    -- others don't need option, option1 is color if present
            result = db[tKeyword] or strBefore
            if color and color ~= "" then
                result = "|cff"..color..result.."|r"
            end
        end
    end
    return result
end

function SavedClassic:TranslateInstance(line, instance)
    -- [keyword] [keyword/color]
    return line:gsub("(%[([^]^[^/]*)/?([^]^[]*)%])", function(...) return self:TranslateInstanceWord(instance, ...) end )
end

function SavedClassic:TranslateInstanceWord(instance, strBefore, keyword, color)
    local tKeyword = _TranslationTable[keyword]
    local result = strBefore
    if tKeyword then
        if type(tKeyword) == "function" then
            result = tKeyword(instance, nil, color)
        else
            result = instance[tKeyword] or strBefore
            if color and color ~= "" then
                result = "|cff"..color..result.."|r"
            end
        end
    end
    return result
end

function SavedClassic:InitUI()
    local db = self.db.realm[player]
    local ui = CreateFrame("Button", self.name.."FloatingUI", UIParent, "BackdropTemplate")
    self.ui = ui
    ui:EnableMouse(true)
    ui:SetWidth(db.frameX)
    ui:SetHeight(db.frameY)
    ui:SetMovable(true)
    ui:SetBackdrop({
        bgFile = "Interface/TutorialFrame/TutorialFrameBackground",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    ui:SetBackdropBorderColor(1,0.82,0,1)
    ui:SetPoint("CENTER")

    text = ui:CreateFontString()
    text:SetAllPoints()
    text:SetFontObject("GameFontNormal")
    text:SetText("|cff00ff00Saved|r ")

    ui:RegisterForDrag("LeftButton")
    ui:RegisterForClicks("LeftButtonDown", "RightButtonDown")

    --ui:SetUserPlaced(true)
    ui:SetScript("OnEnter", function(s)
        local divider = GetScreenHeight() / 2
        local cursorY = select(2, GetCursorPosition())
        GameTooltip:Hide()
        GameTooltip:SetOwner(s, "ANCHOR_NONE", 0, 0)
        if cursorY > divider then
            GameTooltip:SetPoint("TOP", s , "BOTTOM")
        else
            GameTooltip:SetPoint("BOTTOM", s , "TOP")
        end
        self:ShowInfoTooltip(GameTooltip)
        GameTooltip:Show()
    end)
    ui:SetScript("OnLeave", function() GameTooltip:Hide() end)
    ui:SetScript("OnClick", function(s, btn)
        if (btn == "LeftButton" and not IsShiftKeyDown()) then
            LibStub("AceConfigDialog-3.0"):Open(self.name)
        end
    end)
    ui:SetScript("OnDragStart", function(s)
        if IsShiftKeyDown() then
            GameTooltip:Hide()
            s:StartMoving()
        end
    end)
    ui:SetScript("OnDragStop", function(s)
        s:StopMovingOrSizing()
        GameTooltip:Show()
    end)

    if self.db.realm[player].frameShow then
        self.ui:Show()
    else
        self.ui:Hide()
    end
end

function SavedClassic:InitDBIcon()
    self.icon = LibStub("LibDBIcon-1.0")
    self.iconLDB = LibStub("LibDataBroker-1.1"):NewDataObject(self.name .."Icon", {
        type = "data source",
        text = "Saved!",
        icon = "135757",
        OnClick = function() self:ToggleConfig() end,
        OnTooltipShow = function(tooltip) self:ShowInfoTooltip(tooltip) end,
    })
    self.icon:Register(self.name, self.iconLDB, self.db.realm[player].minimapIcon)
end

function SavedClassic:ToggleConfig()
    if self.configOpened then
        LibStub("AceConfigDialog-3.0"):Close(self.name)
        self.configOpened = nil
    else
        LibStub("AceConfigDialog-3.0"):Open(self.name)
        self.configOpened = true
    end
end

function SavedClassic:BuildOptions()
    local rdb = self.db.realm
    local ch = player
    local copyTo = ""
    local names = {}
    local order = self.order
    for i = 1, #order do
        names[order[i].name] = rdb[order[i].name].coloredName
    end
    local currencyTooltipText = ""
    -- icon into currency table and tooltip text
    for _, id in pairs(self.currencies.order) do
        local currency = self.currencies[id]
        if currency then
            if not currency.icon then
                local name, _, icon = GetCurrencyInfo(id)
                currency.name = name
                if id == 1901 then
                    currency.icon = "|T"..icon..":14:14:::14:14:8:0:8:0|t"
                else
                    currency.icon = "|T"..icon..":14:14|t"
                end
            end
            if currency.name then
                currencyTooltipText = currencyTooltipText.."\n"..currency.icon..currency.altName.."("..id.."): "..currency.name
            else
                currencyTooltipText = currencyTooltipText..currency.icon..currency.altName
            end
        end
    end
    local db = self.db.realm[player]
    self.optionsTable = {
        name = self.name .. " option",
        handler = self,
        type = 'group',
        get = function(info) return rdb[ch][info[#info]] end,
        set = function(info, value) rdb[ch][info[#info]] = value end,
        args = {
            show = {
                name = L["Display settings"],
                type = "group",
                inline = true,
                order = 11,
                get = function(info) return db[info[#info]] end,
                set = function(info, value) db[info[#info]] = value end,
                args = {
                    frameShow = {
                        name = L["Show floating UI frame"],
                        type = "toggle",
                        order = 101,
                        set = function(info, value)
                            db[info[#info] ] = value
                            if value then
                                self.ui:Show()
                            else
                                self.ui:Hide()
                            end
                        end,
                    },
                    frameX = {
                        name = L["Floating UI width"],
                        type = "range",
                        min = 80,
                        max = 200,
                        step = 1,
                        order = 102,
                        set = function(info, value)
                            db.frameX = value
                            self.ui:SetWidth(value)
                        end
                    },
                    frameY = {
                        name = L["Floating UI height"],
                        type = "range",
                        min = 20,
                        max = 50,
                        step = 1,
                        order = 103,
                        set = function(info, value)
                            db.frameY = value
                            self.ui:SetHeight(value)
                        end
                    },
                    frameDesc = {
                        name = L["Desc - Frame"],
                        type = "description",
                        order = 104
                    },
                    showMinimapIcon = {
                        name = L["Show minimap icon"],
                        type = "toggle",
                        order = 111,
                        get = function(info)
                            return not db.minimapIcon.hide
                        end,
                        set = function(info, value)
                            db.minimapIcon.hide = not value
                            if value then
                                self.icon:Show(self.name)
                            else
                                self.icon:Hide(self.name)
                            end
                        end,
                    },
                    showInfoPer = {
                        name = L["Show info"],
                        type = "select",
                        values = {
                            char = L["per Character"],
                            realm = L["per Realm"]
                        },
                        style = "radio",
                        order = 121
                    },
                    hideLevelUnder = {
                        name = L["Hide info from level under"],
                        type = "range",
                        min = 1,
                        max = GetMaxPlayerLevel(),
                        step = 1,
                        order = 131
                    },
                    currentFirst = {
                        name = L["Show current chracter first"],
                        type = "toggle",
                        set = function(info, value)
                            db[info[#info]] = value
                            self:SetOrder()
                        end,
                        order = 141
                    },
                }
            },
            character = {
                name = L["Select character"],
                type = "select",
                values = names,
                set = function(info, k) ch = k return k end,
                get = function(info) return ch end,
                order = 21
            },
            resetButton1 = {
                name = L["Reset selected character"],
                type = "execute",
                func = function()
                        if player == ch then
                            self:ResetPlayerDB()
                        else
                            rdb[ch] = nil
                            ch = player
                            self:SetOrder()
                        end
                    end,
                confirm = function() return L["Are you really want to reset?"] end,
                order = 22
            },
            resetButton2 = {
                name = L["Reset all characters"],
                type = "execute",
                func = function() self:ResetWholeDB() end,
                confirm = function() return L["Are you really want to reset?"] end,
                order = 23
            },
            infoChar = {
                name = L["Tooltip - Character info."],
                type = "group",
                inline = true,
                order = 31,
                args = {
                    info1 = {
                        name = L["Line 1 of char info."],
                        type = "toggle",
                        width = "full",
                        order = 11
                    },
                    info2 = {
                        name = L["Line 2 of char info."],
                        type = "toggle",
                        width = "full",
                        order = 21
                    },
                    info1_1 = {
                        name = L["Left"],
                        type = "input",
                        width = 2.5,
                        multiline = 2,
                        desc = L["Desc_Char"]..currencyTooltipText,
                        order = 12
                    },
                    info1_2 = {
                        name = L["Right"],
                        type = "input",
                        width = 1,
                        multiline = 2,
                        desc = L["Desc_Char"]..currencyTooltipText,
                        order = 13
                    },
                    info2_1 = {
                        name = L["Left"],
                        type = "input",
                        width = 2.5,
                        multiline = 2,
                        desc = L["Desc_Char"]..currencyTooltipText,
                        order = 22
                    },
                    info2_2 = {
                        name = L["Right"],
                        type = "input",
                        width = 1,
                        multiline = 2,
                        desc = L["Desc_Char"]..currencyTooltipText,
                        order = 23
                    },
                },
            },

            infoRaid = {
                name = L["Tooltip - Raid instances"],
                type = "group",
                inline = true,
                order = 41,
                args = {
                    info3 = {
                        name = L["Lines of raid instances"],
                        type = "toggle",
                        order = 30
                    },
                    info3oneline = {
                        name = L["Show in one-line"],
                        type = "toggle",
                        order = 31,
                    },
                    info3_1 = {
                        name = L["Left"],
                        type = "input",
                        width = 2.5,
                        multiline = 2,
                        desc = L["Desc_Inst"],
                        order = 32
                    },
                    info3_2 = {
                        name = L["Right"],
                        type = "input",
                        width = 1,
                        multiline = 2,
                        desc = L["Desc_Inst"],
                        order = 33
                    },
                },
            },

            infoHeroic = {
                name = L["Tooltip - Heroic instances"],
                type = "group",
                inline = true,
                order = 51,
                args = {
                    info4 = {
                        name = L["Lines of heroic instances"],
                        type = "toggle",
                        order = 30,
                    },
                    info4oneline = {
                        name = L["Show in one-line"],
                        type = "toggle",
                        order = 31,
                    },
                    info4_1 = {
                        name = L["Left"],
                        type = "input",
                        width = 2.5,
                        multiline = 2,
                        desc = L["Desc_Inst"],
                        order = 32
                    },
                    info4_2 = {
                        name = L["Right"],
                        type = "input",
                        width = 1,
                        multiline = 2,
                        desc = L["Desc_Inst"],
                        order = 33
                    },
                },
            },

            copySettings = {
                name = L["Copy settings to"],
                type = "select",
                values = names,
                set = function(info, k) copyTo = k return k end,
                get = function(info) return copyTo end,
                order = 91
            },
            copyButton = {
                name = L["Copy"],
                type = "execute",
                func = function()
                    local tdb = self.db.realm[copyTo]
                    tdb.info1 = rdb[ch].info1
                    tdb.info1_1 = rdb[ch].info1_1
                    tdb.info1_2 = rdb[ch].info1_2
                    tdb.info2 = rdb[ch].info2
                    tdb.info2_1 = rdb[ch].info2_1
                    tdb.info2_2 = rdb[ch].info2_2
                    tdb.info3 = rdb[ch].info3
                    tdb.info3_1 = rdb[ch].info3_1
                    tdb.info3_2 = rdb[ch].info3_2
                    tdb.info4 = rdb[ch].info4
                    tdb.info4_1 = rdb[ch].info4_1
                    tdb.info4_2 = rdb[ch].info4_2
                end,
                confirm = function() return L["Confirm copy"] end,
                order = 92
            },
        },
    }
end

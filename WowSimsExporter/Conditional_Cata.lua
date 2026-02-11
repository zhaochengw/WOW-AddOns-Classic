local Env = select(2, ...)
if not Env.IS_CLASSIC_CATA then return end

Env.prelink = "https://wowsims.github.io/cata/"

Env.supportedClasses = {
    "hunter",
    "mage",
    "shaman",
    "priest",
    "rogue",
    "druid",
    "warrior",
    "warlock",
    "paladin",
    "deathknight",
}

local TblMaxValIdx = Env.TableMaxValIndex

Env.AddSpec("shaman", "elemental", "shaman/elemental", function(t) return TblMaxValIdx(t) == 1 end)
Env.AddSpec("shaman", "enhancement", "shaman/enhancement", function(t) return TblMaxValIdx(t) == 2 end)
Env.AddSpec("shaman", "enhancement", "shaman/restoration", function(t) return TblMaxValIdx(t) == 3 end)

Env.AddSpec("hunter", "beast_mastery", "hunter/beast_mastery", function(t) return TblMaxValIdx(t) == 1 end)
Env.AddSpec("hunter", "marksman", "hunter/marksmanship", function(t) return TblMaxValIdx(t) == 2 end)
Env.AddSpec("hunter", "survival", "hunter/survival", function(t) return TblMaxValIdx(t) == 3 end)

Env.AddSpec("druid", "balance", "druid/balance", function(t) return TblMaxValIdx(t) == 1 end)
Env.AddSpec("druid", "feral", "druid/feral", function(t)
    return TblMaxValIdx(t) == 2
        -- and Env.GetTalentRankOrdered(2, 1) < 3 -- https://www.wowhead.com/cata/spell=16929/thick-hide
end)
--[[ 
Env.AddSpec("druid", "guardian", "druid/guardian", function(t)
    return TblMaxValIdx(t) == 2
        and Env.GetTalentRankOrdered(2, 1) == 3 -- https://www.wowhead.com/cata/spell=16929/thick-hide
end) 
]]
Env.AddSpec("druid", "balance", "druid/Restoration", function(t) return TblMaxValIdx(t) == 3 end)

Env.AddSpec("warlock", "affliction", "warlock/affliction", function(t) return TblMaxValIdx(t) == 1 end)
Env.AddSpec("warlock", "demonology", "warlock/demonology", function(t) return TblMaxValIdx(t) == 2 end)
Env.AddSpec("warlock", "destruction", "warlock/destruction", function(t) return TblMaxValIdx(t) == 3 end)

Env.AddSpec("rogue", "assassination", "rogue/assassination", function(t) return TblMaxValIdx(t) == 1 end)
Env.AddSpec("rogue", "combat", "rogue/combat", function(t) return TblMaxValIdx(t) == 2 end)
Env.AddSpec("rogue", "subtlety", "rogue/subtlety", function(t) return TblMaxValIdx(t) == 3 end)

Env.AddSpec("mage", "arcane", "mage/arcane", function(t) return TblMaxValIdx(t) == 1 end)
Env.AddSpec("mage", "fire", "mage/fire", function(t) return TblMaxValIdx(t) == 2 end)
Env.AddSpec("mage", "frost", "mage/frost", function(t) return TblMaxValIdx(t) == 3 end)

Env.AddSpec("warrior", "arms", "warrior/arms", function(t) return TblMaxValIdx(t) == 1 end)
Env.AddSpec("warrior", "fury", "warrior/fury", function(t) return TblMaxValIdx(t) == 2 end)
Env.AddSpec("warrior", "protection", "warrior/protection", function(t) return TblMaxValIdx(t) == 3 end)

Env.AddSpec("paladin", "protection", "paladin/holy", function(t) return TblMaxValIdx(t) == 1 end)
Env.AddSpec("paladin", "protection", "paladin/protection", function(t) return TblMaxValIdx(t) == 2 end)
Env.AddSpec("paladin", "retribution", "paladin/retribution", function(t) return TblMaxValIdx(t) == 3 end)

Env.AddSpec("priest", "disc", "priest/discipline", function(t) return TblMaxValIdx(t) == 1 end)
Env.AddSpec("priest", "holy", "priest/holy", function(t) return TblMaxValIdx(t) == 2 end)
Env.AddSpec("priest", "shadow", "priest/shadow", function(t) return TblMaxValIdx(t) == 3 end)

Env.AddSpec("deathknight", "blood", "death_knight/blood", function(t) return TblMaxValIdx(t) == 1 end)
Env.AddSpec("deathknight", "frost", "death_knight/frost", function(t) return TblMaxValIdx(t) == 2 end)
Env.AddSpec("deathknight", "unholy", "death_knight/unholy", function(t) return TblMaxValIdx(t) == 3 end)

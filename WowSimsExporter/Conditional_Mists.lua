local Env = select(2, ...)
if not Env.IS_CLASSIC_MISTS then return end

Env.prelink = "https://wowsims.github.io/mop/"

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
    "monk",
}

local GetSpecialization = C_SpecializationInfo.GetSpecialization

Env.AddSpec("shaman", "elemental", "shaman/elemental", function(t) return GetSpecialization() == 1 end, 262)
Env.AddSpec("shaman", "enhancement", "shaman/enhancement", function(t) return GetSpecialization() == 2 end, 263)
Env.AddSpec("shaman", "restoration", "shaman/restoration", function(t) return GetSpecialization() == 3 end, 264)

Env.AddSpec("hunter", "beast_mastery", "hunter/beast_mastery", function(t) return GetSpecialization() == 1 end, 253)
Env.AddSpec("hunter", "marksman", "hunter/marksmanship", function(t) return GetSpecialization() == 2 end, 254)
Env.AddSpec("hunter", "survival", "hunter/survival", function(t) return GetSpecialization() == 3 end, 255)

Env.AddSpec("druid", "balance", "druid/balance", function(t) return GetSpecialization() == 1 end, 102)
Env.AddSpec("druid", "feral", "druid/feral", function(t) return GetSpecialization() == 2 end, 103)
Env.AddSpec("druid", "guardian", "druid/guardian", function(t) return GetSpecialization() == 3 end, 104)
Env.AddSpec("druid", "restoration", "druid/restoration", function(t) return GetSpecialization() == 4 end, 105)

Env.AddSpec("warlock", "affliction", "warlock/affliction", function(t) return GetSpecialization() == 1 end, 265)
Env.AddSpec("warlock", "demonology", "warlock/demonology", function(t) return GetSpecialization() == 2 end, 266)
Env.AddSpec("warlock", "destruction", "warlock/destruction", function(t) return GetSpecialization() == 3 end, 267)

Env.AddSpec("rogue", "assassination", "rogue/assassination", function(t) return GetSpecialization() == 1 end, 259)
Env.AddSpec("rogue", "combat", "rogue/combat", function(t) return GetSpecialization() == 2 end, 260)
Env.AddSpec("rogue", "subtlety", "rogue/subtlety", function(t) return GetSpecialization() == 3 end, 261)

Env.AddSpec("mage", "arcane", "mage/arcane", function(t) return GetSpecialization() == 1 end, 62)
Env.AddSpec("mage", "fire", "mage/fire", function(t) return GetSpecialization() == 2 end, 63)
Env.AddSpec("mage", "frost", "mage/frost", function(t) return GetSpecialization() == 3 end, 64)

Env.AddSpec("warrior", "arms", "warrior/arms", function(t) return GetSpecialization() == 1 end, 71)
Env.AddSpec("warrior", "fury", "warrior/fury", function(t) return GetSpecialization() == 2 end, 72)
Env.AddSpec("warrior", "protection", "warrior/protection", function(t) return GetSpecialization() == 3 end, 73  )

Env.AddSpec("paladin", "holy", "paladin/holy", function(t) return GetSpecialization() == 1 end, 65)
Env.AddSpec("paladin", "protection", "paladin/protection", function(t) return GetSpecialization() == 2 end, 66)
Env.AddSpec("paladin", "retribution", "paladin/retribution", function(t) return GetSpecialization() == 3 end, 70)

Env.AddSpec("priest", "disc", "priest/discipline", function(t) return GetSpecialization() == 1 end, 256)
Env.AddSpec("priest", "holy", "priest/holy", function(t) return GetSpecialization() == 2 end, 257)
Env.AddSpec("priest", "shadow", "priest/shadow", function(t) return GetSpecialization() == 3 end, 258)

Env.AddSpec("deathknight", "blood", "death_knight/blood", function(t) return GetSpecialization() == 1 end, 250)
Env.AddSpec("deathknight", "frost", "death_knight/frost", function(t) return GetSpecialization() == 2 end, 251)
Env.AddSpec("deathknight", "unholy", "death_knight/unholy", function(t) return GetSpecialization() == 3 end, 252)

Env.AddSpec("monk", "brewmaster", "monk/brewmaster", function(t) return GetSpecialization() == 1 end, 268)
Env.AddSpec("monk", "mistweaver", "monk/mistweaver", function(t) return GetSpecialization() == 2 end, 270)
Env.AddSpec("monk", "windwalker", "monk/windwalker", function(t) return GetSpecialization() == 3 end, 269)

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end
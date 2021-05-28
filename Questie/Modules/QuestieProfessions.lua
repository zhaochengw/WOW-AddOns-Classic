---@class QuestieProfessions
local QuestieProfessions = QuestieLoader:CreateModule("QuestieProfessions");

local playerProfessions = {}
local professionTable = {}

function QuestieProfessions:Update()
    Questie:Debug(DEBUG_DEVELOP, "QuestieProfession: Update")
    ExpandSkillHeader(0) -- Expand all header
    local isProfessionUpdate = false

    for i=1, GetNumSkillLines() do
        if i > 14 then break; end -- We don't have to go through all the weapon skills

        local skillName, isHeader, _, skillRank, _, _, _, _, _, _, _, _, _ = GetSkillLineInfo(i)
        if isHeader == nil and professionTable[skillName] then
            isProfessionUpdate = true -- A profession leveled up, not something like "Defense"
            playerProfessions[professionTable[skillName]] = {skillName, skillRank}
        end
    end
    return isProfessionUpdate
end

-- This function is just for debugging purpose
-- There is no need to access the playerProfessions table somewhere else
function QuestieProfessions:GetPlayerProfessions()
    return playerProfessions
end

function QuestieProfessions:GetProfessionNames()
    local professionNames = {}
    for _, data in pairs(playerProfessions) do
        table.insert(professionNames, data[1])
    end

    return professionNames
end

local function _HasProfession(profession)
    return profession == nil or playerProfessions[profession] ~= nil
end

local function _HasSkillLevel(profession, skillLevel)
    return skillLevel == nil or playerProfessions[profession][2] >= skillLevel
end

function QuestieProfessions:HasProfessionAndSkillLevel(requiredSkill)
    if requiredSkill == nil then
        return true
    end

    local profession = requiredSkill[1]
    local skillLevel = requiredSkill[2]
    return _HasProfession(profession) and _HasSkillLevel(profession, skillLevel)
end

QuestieProfessions.professionKeys = {
    FIRST_AID = 129,
    BLACKSMITHING = 164,
    LEATHERWORKING = 165,
    ALCHEMY = 171,
    HERBALISM = 182,
    COOKING = 185,
    MINING = 186,
    TAILORING = 197,
    ENGINEERING = 202,
    ENCHANTING = 333,
    FISHING = 356,
    SKINNING = 393,
    JEWELCRAFTING = 755
}

local professionNames = {
    [QuestieProfessions.professionKeys.FIRST_AID] = "First Aid",
    [QuestieProfessions.professionKeys.BLACKSMITHING] = "Blacksmithing",
    [QuestieProfessions.professionKeys.LEATHERWORKING] = "Leatherworking",
    [QuestieProfessions.professionKeys.ALCHEMY] = "Alchemy",
    [QuestieProfessions.professionKeys.HERBALISM] = "Herbalism",
    [QuestieProfessions.professionKeys.COOKING] = "Cooking",
    [QuestieProfessions.professionKeys.MINING] = "Mining",
    [QuestieProfessions.professionKeys.TAILORING] = "Tailoring",
    [QuestieProfessions.professionKeys.ENGINEERING] = "Engineering",
    [QuestieProfessions.professionKeys.ENCHANTING] = "Enchanting",
    [QuestieProfessions.professionKeys.FISHING] = "Fishing",
    [QuestieProfessions.professionKeys.SKINNING] = "Skinning",
    [QuestieProfessions.professionKeys.JEWELCRAFTING] = "Jewelcrafting",
}

function QuestieProfessions:GetProfessionName(professionKey)
    return professionNames[professionKey]
end

professionTable = {
    ["First Aid"] = 129,
    ["Erste Hilfe"] = 129,
    ["Primeros auxilios"] = 129,
    ["Secourisme"] = 129,
    ["Primeiros Socorros"] = 129,
    ["Первая помощь"] = 129,
    ["急救"] = 129,
    ["응급치료"] = 129,

    ["Blacksmithing"] = 164,
    ["Schmiedekunst"] = 164,
    ["Herrería"] = 164,
    ["Forge"] = 164,
    ["Ferraria"] = 164,
    ["Кузнечное дело"] = 164,
    ["锻造"] = 164,
    ["鍛造"] = 164,
    ["대장기술"] = 164,

    ["Leatherworking"] = 165,
    ["Lederverarbeitung"] = 165,
    ["Marroquinería"] = 165,
    ["Travail du cuir"] = 165,
    ["Couraria"] = 165,
    ["Кожевничество"] = 165,
    ["制皮"] = 165,
    ["製皮"] = 165,
    ["가죽세공"] = 165,

    ["Alchemy"] = 171,
    ["Alchimie"] = 171,
    ["Alquimia"] = 171,
    ["Алхимия"] = 171,
    ["炼金术"] = 171,
    ["鍊金術"] = 171,
    ["연금술"] = 171,

    ["Herbalism"] = 182,
    ["Kräuterkunde"] = 182,
    ["Botánica"] = 182,
    ["Herboristerie"] = 182,
    ["Herborismo"] = 182,
    ["Травничество"] = 182,
    ["草药学"] = 182,
    ["草藥學"] = 182,
    ["약초채집"] = 182,

    ["Cooking"] = 185,
    ["Kochkunst"] = 185,
    ["Cocina"] = 185,
    ["Cuisine"] = 185,
    ["Culinária"] = 185,
    ["Кулинария"] = 185,
    ["烹饪"] = 185,
    ["烹飪"] = 185,
    ["요리"] = 185,

    ["Mining"] = 186,
    ["Bergbau"] = 186,
    ["Minería"] = 186,
    ["Minage"] = 186,
    ["Mineração"] = 186,
    ["Горное дело"] = 186,
    ["采矿"] = 186,
    ["採礦"] = 186,
    ["채광"] = 186,

    ["Tailoring"] = 197,
    ["Schneiderei"] = 197,
    ["Costura"] = 197,
    ["Couture"] = 197,
    ["Alfaiataria"] = 197,
    ["Портняжное дело"] = 197,
    ["裁缝"] = 197,
    ["裁縫"] = 197,
    ["재봉술"] = 197,

    ["Engineering"] = 202,
    ["Ingenieurskunst"] = 202,
    ["Ingeniería"] = 202,
    ["Ingénierie"] = 202,
    ["Engenharia"] = 202,
    ["Инженерное дело"] = 202,
    ["工程学"] = 202,
    ["工程學"] = 202,
    ["기계공학"] = 202,

    ["Enchanting"] = 333,
    ["Verzauberkunst"] = 333,
    ["Encantamiento"] = 333,
    ["Enchantement"] = 333,
    ["Encantamento"] = 333,
    ["Наложение чар"] = 333,
    ["附魔"] = 333,
    ["마법부여"] = 333,

    ["Fishing"] = 356,
    ["Angeln"] = 356,
    ["Pesca"] = 356,
    ["Pêche"] = 356,
    ["Рыбная ловля"] = 356,
    ["钓鱼"] = 356,
    ["釣魚"] = 356,
    ["낚시"] = 356,

    ["Skinning"] = 393,
    ["Kürschnerei"] = 393,
    ["Desollar"] = 393,
    ["Dépeçage"] = 393,
    ["Esfolamento"] = 393,
    ["Снятие шкур"] = 393,
    ["剥皮"] = 393,
    ["剝皮"] = 393,
    ["무두질"] = 393,

    ["Jewelcrafting"] = 755,

    -- alternate naming scheme (used by DB)
    ["Enchanter"] = 333,
    ["Tailor"] = 197,
    ["Leatherworker"] = 165,
    ["Engineer"] = 202,
    ["Blacksmith"] = 164,
    ["Herbalist"] = 182,
    ["Fisherman"] = 356,
    ["Fishmonger"] = 356,
    ["Skinner"] = 393,
    ["Alchemist"] = 171,
    ["Miner"] = 186,
    ["Cook"] = 185,
    ["Chef"] = 185,
    ["Butcher"] = 185,
    ["Physician"] = 129,
    ["Weapon Crafter"] = 164,
    ["Leathercrafter"] = 165,
    ["Armorsmith"] = 164,
    ["Weaponsmith"] = 164,
    ["Surgeon"] = 129
}

QuestieProfessions.professionTable = professionTable

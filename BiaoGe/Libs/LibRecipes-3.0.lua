local MAJOR = "LibRecipes-3.0"
local MINOR = 16 -- Should be manually increased
assert(LibStub, MAJOR .. " requires LibStub")

local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end -- No upgrade needed

lib.IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
lib.IsClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
lib.IsBCC = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC
lib.IsWOTLKC = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC

local type = type
local tonumber = tonumber
local error = error
local getn = getn
local pairs = pairs

local recipes = lib.recipes or {}
local spells = lib.spells or {}
local items = lib.items or {}
lib.recipes, lib.spells, lib.items = recipes, spells, items

--------------------------------------------------------------------------------
-- Internals                                                                  --
--------------------------------------------------------------------------------

local function AsNumber(value)
    local valueType = type(value)
    if valueType == "number" then
        return value
    elseif valueType == "string" then
        return tonumber(value)
    end
end

local function Flatten(t, i)
    if t == nil then
        return nil
    elseif i == nil then
        i = 1
        local f = {}
        for k, v in pairs(t) do
            f[i] = k
            f[i+1] = v
            i = i + 2
        end
        return Flatten(f, 1)
    elseif i <= getn(t) then
        return t[i], t[i+1] or nil, Flatten(t, i+2)
    end
end

--------------------------------------------------------------------------------
-- Public API                                                                 --
--------------------------------------------------------------------------------

--- Count total number of recipes loaded
-- @usage -- LibStub("LibRecipes-3.0"):GetCount()
-- @return Number of recipes
function lib:GetCount()
    local count = 0
    for _ in pairs(recipes) do count = count + 1 end
    return count
end

--- Register a recipe
-- @param recipeId Id of the recipe
-- @param spellId Id of the spell learned
-- @param itemId Id of the item created by casting the spell
-- @usage -- item:2553  Recipe: Elixir of Minor Agility
-- <br/>-- spell:3230 Elixir of Minor Agility
-- <br/>-- item:2457  Elixir of Minor Agility
-- <br/>LibStub("LibRecipes-3.0"):AddRecipe(2553, 3230, 2457)
-- @return nil
function lib:AddRecipe(recipeId, spellId, itemId)
    recipeId = AsNumber(recipeId)
    if recipeId == nil then
        error("invalid recipe id")
    end
    spellId = AsNumber(spellId)
    if spellId == nil then
        error("invalid spell id")
    end
    -- a craft spell usually creates an item
    itemId = AsNumber(itemId) or false

    -- recipe can provide multiple spells (e.g. "Plans: Balanced Trillium Ingot and Its Uses")
    local recipe = recipes[recipeId]
    if recipe == nil then
        recipes[recipeId] = {}
        recipe = recipes[recipeId]
    end
    recipe[spellId] = itemId

    -- multiple recipes can provide the same spell (e.g. "Design: Rigid Star of Elune")
    local spell = spells[spellId]
    if spell == nil then
        spells[spellId] = {}
        spell = spells[spellId]
    end
    spell[recipeId] = itemId

    -- multiple recipes can lead to the same item (e.g. "Smoking Heart of the Mountain")
    if itemId then
        local item = items[itemId]
        if item == nil then
            items[itemId] = {}
            item = items[itemId]
        end
        item[recipeId] = spellId
    end
end

--- Retrieves the spell and item id related to the specified recipe; repeats in case of multiple spells (spell1, item1, spell2, item2, ...)
-- @param recipeId Id of the recipe
-- @usage local spellId, itemId = LibStub("LibRecipes-3.0"):GetRecipeInfo(2553)
-- <br/>-- spellId = 3230
-- <br/>-- itemId = 2457
-- @return Id of the spell that is learned
-- @return Id of the item that is created by the spell or nil if not applicable
function lib:GetRecipeInfo(recipeId)
    recipeId = AsNumber(recipeId)
    if recipeId == nil then
        error("invalid recipe id")
    end
    return Flatten(recipes[recipeId])
end

--- Retrieves the recipe and item id related to the specified spell; repeats in case of multiple recipes (recipe1, item1, recipe2, item2, ...)
-- @param spellId Id of the spell
-- @usage local recipeId, itemId = LibStub("LibRecipes-3.0"):GetSpellInfo(3230)
-- <br/>-- recipeId = 2553
-- <br/>-- itemId = 2457
-- @return Id of the recipe that learns the spell
-- @return Id of the item that is created by the spell or nil if not applicable
function lib:GetSpellInfo(spellId)
    spellId = AsNumber(spellId)
    if spellId == nil then
        error("invalid spell id")
    end
    return Flatten(spells[spellId])
end

--- Retrieves the recipe and spell id related to the specified item; repeats in case of multiple recipes (recipe1, spell1, recipe2, spell2, ...)
-- @param itemId Id of the item that is created by a recipe spell
-- @usage local recipeId, spellId = LibStub("LibRecipes-3.0"):GetItemInfo(2457)
-- <br/>-- recipeId = 2553
-- <br/>-- spellId = 3230
-- @return Id of the recipe that learns the spell that creates the item
-- @return Id of the spell that creates the item
function lib:GetItemInfo(itemId)
    itemId = AsNumber(itemId)
    if itemId == nil then
        error("invalid item id")
    end
    return Flatten(items[itemId])
end

--- Determines if a spell is taught by a recipe
-- @param spellId Id of the spell
-- @param recipeId Id of the recipe
-- @usage local taughtBy = LibStub("LibRecipes-3.0"):TaughtBy(3230, 2553)
-- <br/>-- taughtBy = true
-- @return true if the recipe teaches the spell; otherwise false
function lib:TaughtBy(spellId, recipeId)
    spellId = AsNumber(spellId)
    if spellId == nil then
        error("invalid spell id")
    end
    recipeId = AsNumber(recipeId)
    if recipeId == nil then
        error("invalid recipe id")
    end
   return spells[spellId] and spells[spellId][recipeId] ~= nil or false
end

--- Determines if a recipe teaches a spell
-- @param recipeId Id of the recipe
-- @param spellId Id of the spell
-- @usage local teaches = LibStub("LibRecipes-3.0"):Teaches(2553, 3230)
-- <br/>-- teaches = true
-- @return true if the spell is taught by the recipe; otherwise false
function lib:Teaches(recipeId, spellId)
    recipeId = AsNumber(recipeId)
    if recipeId == nil then
        error("invalid recipe id")
    end
    spellId = AsNumber(spellId)
    if spellId == nil then
        error("invalid spell id")
    end
    return recipes[recipeId] and recipes[recipeId][spellId] ~= nil or false
end

--------------------------------------------------------------------------------
-- Retail Data (don't forget to increase MINOR when updated)                  --
if lib.IsRetail then                                                          --
--------------------------------------------------------------------------------

-- Alchemy
lib:AddRecipe(2553, 3230, 2457) -- Elixir of Minor Agility
lib:AddRecipe(2555, 2335, 2459) -- Swiftness Potion
lib:AddRecipe(3394, 3174, 3386) -- Potion of Curing
lib:AddRecipe(3395, 3175, 3387) -- Limited Invulnerability Potion
lib:AddRecipe(3396, 2333, 3390) -- Elixir of Lesser Agility
lib:AddRecipe(3830, 3450, 3825) -- Elixir of Fortitude
lib:AddRecipe(3831, 3451, 3826) -- Major Troll's Blood Elixir
lib:AddRecipe(3832, 3453, 3828) -- Elixir of Detect Lesser Invisibility
lib:AddRecipe(4597, 4508, 4596) -- Discolored Healing Potion
lib:AddRecipe(4624, 4942, 4623) -- Lesser Stoneshield Potion
lib:AddRecipe(5640, 6617, 5631) -- Rage Potion
lib:AddRecipe(5642, 6624, 5634) -- Free Action Potion
lib:AddRecipe(5643, 6618, 5633) -- Great Rage Potion
lib:AddRecipe(6053, 7255, 6051) -- Holy Protection Potion
lib:AddRecipe(6054, 7256, 6048) -- Shadow Protection Potion
lib:AddRecipe(6055, 7257, 6049) -- Fire Protection Potion
lib:AddRecipe(6056, 7258, 6050) -- Frost Protection Potion
lib:AddRecipe(6057, 7259, 6052) -- Nature Protection Potion
lib:AddRecipe(6068, 3449, 3824) -- Shadow Oil
lib:AddRecipe(6211, 3188, 3391) -- Elixir of Ogre's Strength
lib:AddRecipe(6454, 7935, 6453) -- Strong Anti-Venom
lib:AddRecipe(6663, 8240, 6662) -- Elixir of Giant Growth
lib:AddRecipe(9294, 11458, 9144) -- Wildvine Potion
lib:AddRecipe(9295, 11464, 9172) -- Invisibility Potion
lib:AddRecipe(9296, 11466, 9088) -- Gift of Arthas
lib:AddRecipe(9297, 11468, 9197) -- Elixir of Dream Vision
lib:AddRecipe(9298, 11472, 9206) -- Elixir of Giants
lib:AddRecipe(9300, 11477, 9224) -- Elixir of Demonslaying
lib:AddRecipe(9301, 11476, 9264) -- Elixir of Shadow Power
lib:AddRecipe(9302, 11473, 9210) -- Ghost Dye
lib:AddRecipe(9303, 11459, 9149) -- Philosopher's Stone
lib:AddRecipe(9304, 11479, 3577) -- Transmute: Iron to Gold
lib:AddRecipe(9305, 11480, 6037) -- Transmute: Mithril to Truesilver
lib:AddRecipe(10644, 11456, 9061) -- Goblin Rocket Fuel
lib:AddRecipe(12958, 17187, 12360) -- Transmute: Arcanite
lib:AddRecipe(13476, 17552, 13442) -- Mighty Rage Potion
lib:AddRecipe(13477, 17553, 13443) -- Superior Mana Potion
lib:AddRecipe(13478, 17554, 13445) -- Elixir of Superior Defense
lib:AddRecipe(13479, 17555, 13447) -- Elixir of the Sages
lib:AddRecipe(13480, 17556, 13446) -- Major Healing Potion
lib:AddRecipe(13481, 17557, 13453) -- Elixir of Brute Force
lib:AddRecipe(13482, 17559, 7078) -- Transmute: Air to Fire
lib:AddRecipe(13483, 17560, 7076) -- Transmute: Fire to Earth
lib:AddRecipe(13484, 17561, 7080) -- Transmute: Earth to Water
lib:AddRecipe(13485, 17562, 7082) -- Transmute: Water to Air
lib:AddRecipe(13486, 17563, 7080) -- Transmute: Undeath to Water
lib:AddRecipe(13487, 17564, 12808) -- Transmute: Water to Undeath
lib:AddRecipe(13488, 17565, 7076) -- Transmute: Life to Earth
lib:AddRecipe(13489, 17566, 12803) -- Transmute: Earth to Life
lib:AddRecipe(13490, 17570, 13455) -- Greater Stoneshield Potion
lib:AddRecipe(13491, 17571, 13452) -- Elixir of the Mongoose
lib:AddRecipe(13492, 17572, 13462) -- Purification Potion
lib:AddRecipe(13493, 17573, 13454) -- Greater Arcane Elixir
lib:AddRecipe(13494, 17574, 13457) -- Greater Fire Protection Potion
lib:AddRecipe(13495, 17575, 13456) -- Greater Frost Protection Potion
lib:AddRecipe(13496, 17576, 13458) -- Greater Nature Protection Potion
lib:AddRecipe(13497, 17577, 13461) -- Greater Arcane Protection Potion
lib:AddRecipe(13499, 17578, 13459) -- Greater Shadow Protection Potion
lib:AddRecipe(13501, 17580, 13444) -- Major Mana Potion
lib:AddRecipe(13517, 17632, 13503) -- Alchemist Stone
lib:AddRecipe(13518, 17634, 13506) -- Potion of Petrification
lib:AddRecipe(13519, 17635, 13510) -- Flask of the Titans
lib:AddRecipe(13520, 17636, 13511) -- Flask of Distilled Wisdom
lib:AddRecipe(13521, 17637, 13512) -- Flask of Supreme Power
lib:AddRecipe(14634, 3454, 3829) -- Frost Oil
lib:AddRecipe(17709, 21923, 17708) -- Elixir of Frost Power
lib:AddRecipe(18257, 22732, 18253) -- Major Rejuvenation Potion
lib:AddRecipe(19442, 23787, 19440) -- Powerful Anti-Venom
lib:AddRecipe(20011, 24365, 20007) -- Mageblood Elixir
lib:AddRecipe(20012, 24366, 20002) -- Greater Dreamless Sleep Potion
lib:AddRecipe(20013, 24367, 20008) -- Living Action Potion
lib:AddRecipe(20014, 24368, 20004) -- Mighty Troll's Blood Elixir
lib:AddRecipe(20761, 25146, 7068) -- Transmute: Elemental Fire
lib:AddRecipe(21547, 26277, 21546) -- Elixir of Greater Firepower
lib:AddRecipe(22900, 28543, 22823) -- Elixir of Camouflage
lib:AddRecipe(22901, 28546, 22826) -- Sneaking Potion
lib:AddRecipe(22902, 28549, 22827) -- Elixir of Major Frost Power
lib:AddRecipe(22903, 28550, 22828) -- Insane Strength Potion
lib:AddRecipe(22904, 28552, 22830) -- Elixir of the Searching Eye
lib:AddRecipe(22905, 28553, 22831) -- Elixir of Major Agility
lib:AddRecipe(22906, 28554, 22871) -- Shrouding Potion
lib:AddRecipe(22907, 28555, 22832) -- Super Mana Potion
lib:AddRecipe(22908, 28556, 22833) -- Elixir of Major Firepower
lib:AddRecipe(22909, 28557, 22834) -- Elixir of Major Defense
lib:AddRecipe(22910, 28558, 22835) -- Elixir of Major Shadow Power
lib:AddRecipe(22911, 28562, 22836) -- Major Dreamless Sleep Potion
lib:AddRecipe(22912, 28563, 22837) -- Heroic Potion
lib:AddRecipe(22913, 28564, 22838) -- Haste Potion
lib:AddRecipe(22914, 28565, 22839) -- Destruction Potion
lib:AddRecipe(22915, 28566, 21884) -- Transmute: Primal Air to Fire
lib:AddRecipe(22916, 28567, 21885) -- Transmute: Primal Earth to Water
lib:AddRecipe(22917, 28568, 22452) -- Transmute: Primal Fire to Earth
lib:AddRecipe(22918, 28569, 22451) -- Transmute: Primal Water to Air
lib:AddRecipe(22919, 28570, 22840) -- Elixir of Major Mageblood
lib:AddRecipe(22920, 28571, 22841) -- Major Fire Protection Potion
lib:AddRecipe(22921, 28572, 22842) -- Major Frost Protection Potion
lib:AddRecipe(22922, 28573, 22844) -- Major Nature Protection Potion
lib:AddRecipe(22923, 28575, 22845) -- Major Arcane Protection Potion
lib:AddRecipe(22924, 28576, 22846) -- Major Shadow Protection Potion
lib:AddRecipe(22925, 28577, 22847) -- Major Holy Protection Potion
lib:AddRecipe(22926, 28578, 22848) -- Elixir of Empowerment
lib:AddRecipe(22927, 28579, 22849) -- Ironshield Potion
lib:AddRecipe(23574, 29688, 23571) -- Transmute: Primal Might
lib:AddRecipe(24001, 28553, 22831) -- Elixir of Major Agility
lib:AddRecipe(25869, 32765, 25867) -- Transmute: Earthstorm Diamond
lib:AddRecipe(25870, 32766, 25868) -- Transmute: Skyfire Diamond
lib:AddRecipe(29232, 32766, 25868) -- Transmute: Skyfire Diamond
lib:AddRecipe(30443, 28568, 22452) -- Transmute: Primal Fire to Earth
lib:AddRecipe(31354, 17635, 13510) -- Flask of the Titans
lib:AddRecipe(31355, 17637, 13512) -- Flask of Supreme Power
lib:AddRecipe(31356, 17636, 13511) -- Flask of Distilled Wisdom
lib:AddRecipe(31680, 38960, 31679) -- Fel Strength Elixir
lib:AddRecipe(31681, 38962, 31676) -- Fel Regeneration Potion
lib:AddRecipe(31682, 38961, 31677) -- Fel Mana Potion
lib:AddRecipe(32070, 39637, 32063) -- Earthen Elixir
lib:AddRecipe(32071, 39639, 32068) -- Elixir of Ironskin
lib:AddRecipe(35294, 28578, 22848) -- Elixir of Empowerment
lib:AddRecipe(35295, 28564, 22838) -- Haste Potion
lib:AddRecipe(35752, 47046, 35748) -- Guardian's Alchemist Stone
lib:AddRecipe(35753, 47048, 35749) -- Sorcerer's Alchemist Stone
lib:AddRecipe(35754, 47049, 35750) -- Redeemer's Alchemist Stone
lib:AddRecipe(35755, 47050, 35751) -- Assassin's Alchemist Stone
lib:AddRecipe(44564, 53936, 40213) -- Mighty Arcane Protection Potion
lib:AddRecipe(44565, 53939, 40214) -- Mighty Fire Protection Potion
lib:AddRecipe(44566, 53937, 40215) -- Mighty Frost Protection Potion
lib:AddRecipe(44567, 53942, 40216) -- Mighty Nature Protection Potion
lib:AddRecipe(44568, 53938, 40217) -- Mighty Shadow Protection Potion
lib:AddRecipe(46023, 80498, 57191) -- Mythical Healing Potion
lib:AddRecipe(65435, 92643, 62288) -- Cauldron of Battle
lib:AddRecipe(65498, 92688, 65460) -- Big Cauldron of Battle
lib:AddRecipe(67538, 93328, 65891) -- Vial of the Sands
lib:AddRecipe(112022, 53938, 40217) -- Mighty Shadow Protection Potion
lib:AddRecipe(112023, 156560, 109262) -- Draenic Philosopher's Stone
lib:AddRecipe(112024, 156561, 109145) -- Draenic Agility Flask
lib:AddRecipe(112026, 156563, 109147) -- Draenic Intellect Flask
lib:AddRecipe(112027, 156564, 109148) -- Draenic Strength Flask
lib:AddRecipe(112030, 156568, 109152) -- Draenic Stamina Flask
lib:AddRecipe(112031, 156569, 109153) -- Greater Draenic Agility Flask
lib:AddRecipe(112033, 156571, 109155) -- Greater Draenic Intellect Flask
lib:AddRecipe(112034, 156572, 109156) -- Greater Draenic Strength Flask
lib:AddRecipe(112037, 156576, 109160) -- Greater Draenic Stamina Flask
lib:AddRecipe(112038, 156577, 109217) -- Draenic Agility Potion
lib:AddRecipe(112039, 156578, 109218) -- Draenic Intellect Potion
lib:AddRecipe(112040, 156579, 109219) -- Draenic Strength Potion
lib:AddRecipe(112041, 156580, 109220) -- Draenic Versatility Potion
lib:AddRecipe(112042, 156581, 109221) -- Draenic Channeled Mana Potion
lib:AddRecipe(112043, 156582, 109222) -- Draenic Mana Potion
lib:AddRecipe(112045, 156584, 109226) -- Draenic Rejuvenation Potion
lib:AddRecipe(112047, 162403, 112090) -- Transmorphic Tincture
lib:AddRecipe(120132, 175880, 118700) -- Secrets of Draenor Alchemy
lib:AddRecipe(122599, 181625, 113263) -- Transmute: Sorcerous Fire to Earth
lib:AddRecipe(122599, 181627, 113264) -- Transmute: Sorcerous Fire to Air
lib:AddRecipe(122599, 181628, 113262) -- Transmute: Sorcerous Fire to Water
lib:AddRecipe(122599, 181629, 113263) -- Transmute: Sorcerous Water to Earth
lib:AddRecipe(122599, 181630, 113264) -- Transmute: Sorcerous Water to Air
lib:AddRecipe(122599, 181631, 113264) -- Transmute: Sorcerous Earth to Air
lib:AddRecipe(122599, 181632, 113261) -- Transmute: Sorcerous Earth to Fire
lib:AddRecipe(122599, 181633, 113261) -- Transmute: Sorcerous Air to Fire
lib:AddRecipe(122599, 181634, 113261) -- Transmute: Sorcerous Water to Fire
lib:AddRecipe(122599, 181635, 113262) -- Transmute: Sorcerous Earth to Water
lib:AddRecipe(122599, 181636, 113262) -- Transmute: Sorcerous Air to Water
lib:AddRecipe(122599, 181637, 113263) -- Transmute: Sorcerous Air to Earth
lib:AddRecipe(122600, 181643, 118472) -- Transmute: Savage Blood
lib:AddRecipe(122605, 181647, 122601) -- Stone of Wind
lib:AddRecipe(122605, 181648, 122602) -- Stone of the Earth
lib:AddRecipe(122605, 181649, 122603) -- Stone of the Waters
lib:AddRecipe(122605, 181650, 122604) -- Stone of Fire
lib:AddRecipe(122710, 156591, 108996) -- Primal Alchemy
lib:AddRecipe(127898, 188297, 127834) -- Ancient Healing Potion
lib:AddRecipe(127899, 188301, 127835) -- Ancient Mana Potion
lib:AddRecipe(127900, 188304, 127836) -- Ancient Rejuvenation Potion
lib:AddRecipe(127901, 188307, 127837) -- Draught of Raw Magic
lib:AddRecipe(127902, 188310, 127838) -- Sylvan Elixir
lib:AddRecipe(127903, 188313, 127839) -- Avalanche Elixir
lib:AddRecipe(127904, 188316, 127840) -- Skaggldrynk
lib:AddRecipe(127905, 188319, 127841) -- Skystep Potion
lib:AddRecipe(127906, 188322, 127842) -- Infernal Alchemist Stone
lib:AddRecipe(127907, 188325, 127843) -- Potion of Deadly Grace
lib:AddRecipe(127908, 188328, 127844) -- Potion of the Old War
lib:AddRecipe(127909, 188331, 127845) -- Unbending Potion
lib:AddRecipe(127910, 188334, 127846) -- Leytorrent Potion
lib:AddRecipe(127911, 188337, 127847) -- Flask of the Whispered Pact
lib:AddRecipe(127912, 188340, 127848) -- Flask of the Seventh Demon
lib:AddRecipe(127913, 188343, 127849) -- Flask of the Countless Armies
lib:AddRecipe(127914, 188346, 127850) -- Flask of Ten Thousand Scars
lib:AddRecipe(127915, 188349, 127851) -- Spirit Cauldron
lib:AddRecipe(127917, 188299, 127834) -- Ancient Healing Potion
lib:AddRecipe(127918, 188302, 127835) -- Ancient Mana Potion
lib:AddRecipe(127919, 188305, 127836) -- Ancient Rejuvenation Potion
lib:AddRecipe(127920, 188308, 127837) -- Draught of Raw Magic
lib:AddRecipe(127921, 188311, 127838) -- Sylvan Elixir
lib:AddRecipe(127922, 188314, 127839) -- Avalanche Elixir
lib:AddRecipe(127923, 188317, 127840) -- Skaggldrynk
lib:AddRecipe(127924, 188320, 127841) -- Skystep Potion
lib:AddRecipe(127925, 188323, 127842) -- Infernal Alchemist Stone
lib:AddRecipe(127926, 188326, 127843) -- Potion of Deadly Grace
lib:AddRecipe(127927, 188329, 127844) -- Potion of the Old War
lib:AddRecipe(127928, 188332, 127845) -- Unbending Potion
lib:AddRecipe(127929, 188335, 127846) -- Leytorrent Potion
lib:AddRecipe(127930, 188338, 127847) -- Flask of the Whispered Pact
lib:AddRecipe(127931, 188341, 127848) -- Flask of the Seventh Demon
lib:AddRecipe(127932, 188344, 127849) -- Flask of the Countless Armies
lib:AddRecipe(127933, 188347, 127850) -- Flask of Ten Thousand Scars
lib:AddRecipe(127934, 188350, 127851) -- Spirit Cauldron
lib:AddRecipe(127935, 188300, 127834) -- Ancient Healing Potion
lib:AddRecipe(127936, 188303, 127835) -- Ancient Mana Potion
lib:AddRecipe(127937, 188306, 127836) -- Ancient Rejuvenation Potion
lib:AddRecipe(127938, 188309, 127837) -- Draught of Raw Magic
lib:AddRecipe(127939, 188312, 127838) -- Sylvan Elixir
lib:AddRecipe(127940, 188315, 127839) -- Avalanche Elixir
lib:AddRecipe(127941, 188318, 127840) -- Skaggldrynk
lib:AddRecipe(127942, 188321, 127841) -- Skystep Potion
lib:AddRecipe(127943, 188324, 127842) -- Infernal Alchemist Stone
lib:AddRecipe(127944, 188327, 127843) -- Potion of Deadly Grace
lib:AddRecipe(127945, 188330, 127844) -- Potion of the Old War
lib:AddRecipe(127946, 188333, 127845) -- Unbending Potion
lib:AddRecipe(127947, 188336, 127846) -- Leytorrent Potion
lib:AddRecipe(127948, 188339, 127847) -- Flask of the Whispered Pact
lib:AddRecipe(127949, 188342, 127848) -- Flask of the Seventh Demon
lib:AddRecipe(127950, 188345, 127849) -- Flask of the Countless Armies
lib:AddRecipe(127951, 188348, 127850) -- Flask of Ten Thousand Scars
lib:AddRecipe(127952, 188351, 127851) -- Spirit Cauldron
lib:AddRecipe(128209, 188800, 141323) -- Wild Transmutation
lib:AddRecipe(128210, 188801, 141323) -- Wild Transmutation
lib:AddRecipe(128211, 188802, 141323) -- Wild Transmutation
lib:AddRecipe(142119, 229217, 142117) -- Potion of Prolonged Power
lib:AddRecipe(142120, 229218, 142117) -- Potion of Prolonged Power
lib:AddRecipe(142121, 229220, 142117) -- Potion of Prolonged Power
lib:AddRecipe(151657, 247619, 151608) -- Lightblood Elixir
lib:AddRecipe(151658, 247620, 151608) -- Lightblood Elixir
lib:AddRecipe(151659, 247622, 151608) -- Lightblood Elixir
lib:AddRecipe(151703, 247688, 151609) -- Tears of the Naaru
lib:AddRecipe(151704, 247690, 151609) -- Tears of the Naaru
lib:AddRecipe(151705, 247691, 151609) -- Tears of the Naaru
lib:AddRecipe(151706, 247694, 151607) -- Astral Alchemist Stone
lib:AddRecipe(151707, 247695, 151607) -- Astral Alchemist Stone
lib:AddRecipe(151708, 247696, 151607) -- Astral Alchemist Stone
lib:AddRecipe(151710, 247701, 151568) -- Transmute: Primal Sargerite
lib:AddRecipe(152616, 251646, 152615) -- Astral Healing Potion
lib:AddRecipe(152617, 251651, 152615) -- Astral Healing Potion
lib:AddRecipe(152618, 251658, 152615) -- Astral Healing Potion
lib:AddRecipe(160661, 172542, 116981) -- Fire Ammonite Oil
lib:AddRecipe(160662, 172541, 116979) -- Blackwater Anti-Venom
lib:AddRecipe(160663, 172540, 109223) -- Healing Tonic
lib:AddRecipe(160664, 221690, 136653) -- Silvery Salve
lib:AddRecipe(162128, 252336, 152557) -- Steelskin Potion
lib:AddRecipe(162129, 252340, 152561) -- Potion of Replenishment
lib:AddRecipe(162130, 252343, 152560) -- Potion of Bursting Blood
lib:AddRecipe(162131, 252346, 152559) -- Potion of Rising Death
lib:AddRecipe(162132, 252350, 152638) -- Flask of the Currents
lib:AddRecipe(162133, 252353, 152639) -- Flask of Endless Fathoms
lib:AddRecipe(162134, 252356, 152640) -- Flask of the Vast Horizon
lib:AddRecipe(162135, 252359, 152641) -- Flask of the Undertow
lib:AddRecipe(162136, 252363, 152634) -- Endless Tincture of Renewed Combat
lib:AddRecipe(162137, 252370, 152637) -- Siren's Alchemist Stone
lib:AddRecipe(162138, 252378, 152636) -- Endless Tincture of Fractional Power
lib:AddRecipe(162139, 252381, 152632) -- Surging Alchemist Stone
lib:AddRecipe(162254, 252387, 152495) -- Coastal Mana Potion
lib:AddRecipe(162255, 252384, 152494) -- Coastal Healing Potion
lib:AddRecipe(162256, 252390, 163082) -- Coastal Rejuvenation Potion
lib:AddRecipe(162257, 252393, 152496) -- Demitri's Draught of Deception
lib:AddRecipe(162258, 252396, 152497) -- Lightfoot Potion
lib:AddRecipe(162259, 252399, 152550) -- Sea Mist Potion
lib:AddRecipe(162260, 252402, 152503) -- Potion of Concealment
lib:AddRecipe(162520, 276976, 162519) -- Mystical Cauldron
lib:AddRecipe(162521, 276977, 162519) -- Mystical Cauldron
lib:AddRecipe(162691, 252336, 152557) -- Steelskin Potion
lib:AddRecipe(162692, 252340, 152561) -- Potion of Replenishment
lib:AddRecipe(162693, 252343, 152560) -- Potion of Bursting Blood
lib:AddRecipe(162694, 252346, 152559) -- Potion of Rising Death
lib:AddRecipe(162695, 252350, 152638) -- Flask of the Currents
lib:AddRecipe(162696, 252353, 152639) -- Flask of Endless Fathoms
lib:AddRecipe(162697, 252356, 152640) -- Flask of the Vast Horizon
lib:AddRecipe(162698, 252359, 152641) -- Flask of the Undertow
lib:AddRecipe(162701, 252378, 152636) -- Endless Tincture of Fractional Power
lib:AddRecipe(162702, 252381, 152632) -- Surging Alchemist Stone
lib:AddRecipe(162703, 252387, 152495) -- Coastal Mana Potion
lib:AddRecipe(162704, 252384, 152494) -- Coastal Healing Potion
lib:AddRecipe(162705, 252390, 163082) -- Coastal Rejuvenation Potion
lib:AddRecipe(163313, 279161, 163223) -- Battle Potion of Agility
lib:AddRecipe(163314, 279161, 163223) -- Battle Potion of Agility
lib:AddRecipe(163315, 279164, 163222) -- Battle Potion of Intellect
lib:AddRecipe(163316, 279164, 163222) -- Battle Potion of Intellect
lib:AddRecipe(163317, 279167, 163225) -- Battle Potion of Stamina
lib:AddRecipe(163318, 279167, 163225) -- Battle Potion of Stamina
lib:AddRecipe(163319, 279170, 163224) -- Battle Potion of Strength
lib:AddRecipe(163320, 279170, 163224) -- Battle Potion of Strength
lib:AddRecipe(165929, 286922, 165927) -- Spirited Alchemist Stone
lib:AddRecipe(165930, 286923, 165928) -- Eternal Alchemist Stone
lib:AddRecipe(166271, 287449, 166270) -- Potion of the Unveiling Eye
lib:AddRecipe(166272, 287448, 166270) -- Potion of the Unveiling Eye
lib:AddRecipe(166422, 260403, 156631) -- Silas' Sphere of Transmutation
lib:AddRecipe(166977, 291085, 166975) -- Imbued Alchemist Stone
lib:AddRecipe(166978, 291086, 166976) -- Emblazoned Alchemist Stone
lib:AddRecipe(168757, 298996, 168675) -- Crushing Alchemist Stone
lib:AddRecipe(168758, 298997, 168676) -- Ascended Alchemist Stone
lib:AddRecipe(169492, 298728, 168529) -- Potion of Empowered Proximity
lib:AddRecipe(169494, 298746, 168506) -- Potion of Focused Resolve
lib:AddRecipe(169495, 298731, 168489) -- Superior Battle Potion of Agility
lib:AddRecipe(169496, 298736, 168501) -- Superior Steelskin Potion
lib:AddRecipe(169497, 298743, 168498) -- Superior Battle Potion of Intellect
lib:AddRecipe(169498, 298749, 168499) -- Superior Battle Potion of Stamina
lib:AddRecipe(169499, 298752, 168500) -- Superior Battle Potion of Strength
lib:AddRecipe(169500, 298845, 168651) -- Greater Flask of the Currents
lib:AddRecipe(169501, 298848, 168652) -- Greater Flask of Endless Fathoms
lib:AddRecipe(169502, 298852, 168653) -- Greater Flask of the Vast Horizon
lib:AddRecipe(169503, 298855, 168654) -- Greater Flask of the Undertow
lib:AddRecipe(169504, 298864, 168656) -- Greater Mystical Cauldron
lib:AddRecipe(169600, 298728, 168529) -- Potion of Empowered Proximity
lib:AddRecipe(169602, 298746, 168506) -- Potion of Focused Resolve
lib:AddRecipe(169603, 298864, 168656) -- Greater Mystical Cauldron
lib:AddRecipe(170208, 300751, 169299) -- Potion of Unbridled Fury
lib:AddRecipe(170209, 300754, 169300) -- Potion of Wild Mending
lib:AddRecipe(170210, 301312, 169451) -- Abyssal Healing Potion
lib:AddRecipe(171084, 305992, 171085) -- Peerless Alchemist Stone
lib:AddRecipe(171086, 305993, 171087) -- Awakened Alchemist Stone
lib:AddRecipe(171318, 305994, 171088) -- Unbound Alchemist Stone
lib:AddRecipe(180780, 334413, 180751) -- Red Noggin Candle
lib:AddRecipe(182660, 307143, 180457) -- Shadestone
lib:AddRecipe(182665, 307144, 186694) -- Stones to Ore
lib:AddRecipe(183106, 307087, 171284) -- Eternal Cauldron
lib:AddRecipe(183868, 343677, 173383) -- Crafter's Mark III
lib:AddRecipe(186986, 354882, 186699) -- Widow Burst
lib:AddRecipe(186987, 354884, 186698) -- Torch Burst
lib:AddRecipe(186988, 354881, 186701) -- Glory Burst
lib:AddRecipe(186989, 354880, 186700) -- Marrow Burst
lib:AddRecipe(186990, 354885, 186697) -- Blossom Burst
lib:AddRecipe(186991, 307144, 186694) -- Stones to Ore
lib:AddRecipe(187828, 360014, 187827) -- Infusion: Corpse Purification
lib:AddRecipe(187848, 360318, 187850) -- Sustaining Armor Polish
lib:AddRecipe(191429, 370438, 191318) -- Phial of the Eye in the Storm
lib:AddRecipe(191430, 370453, 191321) -- Phial of Still Air
lib:AddRecipe(191431, 370456, 191324) -- Phial of Icy Preservation
lib:AddRecipe(191432, 370457, 191327) -- Iced Phial of Corrupting Rage
lib:AddRecipe(191433, 370460, 191330) -- Phial of Charged Isolation
lib:AddRecipe(191434, 370462, 191333) -- Phial of Glacial Fury
lib:AddRecipe(191435, 370463, 191336) -- Phial of Static Empowerment
lib:AddRecipe(191436, 370465, 191339) -- Phial of Tepid Versatility
lib:AddRecipe(191437, 370472, 191342) -- Aerated Phial of Deftness
lib:AddRecipe(191438, 370473, 191345) -- Steaming Phial of Finesse
lib:AddRecipe(191439, 370476, 191348) -- Charged Phial of Alacrity
lib:AddRecipe(191440, 370478, 191351) -- Potion of Frozen Fatality
lib:AddRecipe(191441, 370483, 191354) -- Crystalline Phial of Perception
lib:AddRecipe(191442, 370504, 191357) -- Phial of Elemental Chaos
lib:AddRecipe(191443, 370521, 191360) -- Bottled Putrescence
lib:AddRecipe(191444, 370524, 191363) -- Potion of Frozen Focus
lib:AddRecipe(191445, 370525, 191366) -- Potion of Chilled Clarity
lib:AddRecipe(191446, 370528, 191369) -- Potion of Withering Vitality
lib:AddRecipe(191447, 370533, 191372) -- Residual Neural Channeling Agent
lib:AddRecipe(191448, 370536, 191375) -- Delicate Suspension of Spores
lib:AddRecipe(191449, 370539, 191378) -- Refreshing Healing Potion
lib:AddRecipe(191450, 370543, 191381) -- Elemental Potion of Ultimate Power
lib:AddRecipe(191451, 370547, 191384) -- Aerated Mana Potion
lib:AddRecipe(191452, 370551, 191387) -- Elemental Potion of Power
lib:AddRecipe(191454, 370556, 191393) -- Potion of the Hushed Zephyr
lib:AddRecipe(191455, 370558, 191396) -- Potion of Gusts
lib:AddRecipe(191456, 370561, 191399) -- Potion of Shocking Disclosure
lib:AddRecipe(191542, 370668, 191482) -- Potion Cauldron of Power
lib:AddRecipe(191543, 370672, 191485) -- Potion Cauldron of Ultimate Power
lib:AddRecipe(191544, 370673, 191488) -- Cauldron of the Pooka
lib:AddRecipe(191545, 370676, 191491) -- Sustaining Alchemist Stone
lib:AddRecipe(191547, 370677, 191492) -- Alacritous Alchemist Stone
lib:AddRecipe(191578, 370707, 190321) -- Transmute: Awakened Fire
lib:AddRecipe(191579, 370708, 190329) -- Transmute: Awakened Frost
lib:AddRecipe(191580, 370710, 190316) -- Transmute: Awakened Earth
lib:AddRecipe(191581, 370711, 190327) -- Transmute: Awakened Air
lib:AddRecipe(191582, 370714, nil) -- Transmute: Decay to Elements
lib:AddRecipe(191583, 370715, nil) -- Transmute: Order to Elements
lib:AddRecipe(191584, 370717, 191493) -- Primal Convergent
lib:AddRecipe(191585, 370722, 191496) -- Omnium Draconis
lib:AddRecipe(191586, 370723, 191499) -- Sagacious Incense
lib:AddRecipe(191587, 370724, 191502) -- Somniferous Incense
lib:AddRecipe(191588, 370725, 191505) -- Exultant Incense
lib:AddRecipe(191589, 370728, 191508) -- Fervid Incense
lib:AddRecipe(191590, 370729, 191511) -- Stable Fluidic Draconium
lib:AddRecipe(191591, 370730, 191514) -- Brood Salt
lib:AddRecipe(191592, 370731, 191517) -- Writhefire Oil
lib:AddRecipe(191593, 370732, 191520) -- Agitating Potion Augmentation
lib:AddRecipe(191594, 370733, 191523) -- Reactive Phial Embellishment
lib:AddRecipe(191596, 370735, 191529) -- Illustrious Insight
lib:AddRecipe(191597, 370738, 191532) -- Potion Absorption Inhibitor
lib:AddRecipe(191599, 370743, nil) -- Basic Potion Experimentation
lib:AddRecipe(191600, 370745, nil) -- Advanced Potion Experimentation
lib:AddRecipe(191601, 370746, nil) -- Basic Phial Experimentation
lib:AddRecipe(191602, 370747, nil) -- Advanced Phial Experimentation
lib:AddRecipe(198533, 381270, 197720) -- Aerated Phial of Quick Hands
lib:AddRecipe(201740, 370543, 191381) -- Elemental Potion of Ultimate Power
lib:AddRecipe(201740, 370672, 191485) -- Potion Cauldron of Ultimate Power
lib:AddRecipe(203420, 400270, 203407) -- Draconic Suppression Powder
lib:AddRecipe(204631, 405847, 204463) -- Transmute: Dracothyst
lib:AddRecipe(204695, 405879, 204633) -- Cauldron of Extracted Putrescence
lib:AddRecipe(204696, 406106, 204238) -- Draconic Phial Cauldron
lib:AddRecipe(204984, 405832, 204370) -- Stinky Bright Potion
lib:AddRecipe(210241, 415628, 207021) -- Dreamwalker's Healing Potion
-- Blacksmithing
lib:AddRecipe(2881, 2667, 2864) -- Runed Copper Breastplate
lib:AddRecipe(2882, 3330, 3481) -- Silvered Bronze Shoulders
lib:AddRecipe(2883, 3295, 3490) -- Deadly Bronze Poniard
lib:AddRecipe(3608, 3297, 3492) -- Mighty Iron Hammer
lib:AddRecipe(3609, 3321, 3471) -- Copper Chain Vest
lib:AddRecipe(3610, 3325, 3474) -- Gemmed Copper Gauntlets
lib:AddRecipe(3611, 3334, 3484) -- Green Iron Boots
lib:AddRecipe(3612, 3336, 3485) -- Green Iron Gauntlets
lib:AddRecipe(3866, 3493, 3850) -- Jade Serpentblade
lib:AddRecipe(3867, 3495, 3852) -- Golden Iron Destroyer
lib:AddRecipe(3868, 3497, 3854) -- Frost Tiger Blade
lib:AddRecipe(3869, 3500, 3856) -- Shadow Crescent Axe
lib:AddRecipe(3870, 3504, 3840) -- Green Iron Shoulders
lib:AddRecipe(3871, 3505, 3841) -- Golden Scale Shoulders
lib:AddRecipe(3872, 3507, 3843) -- Golden Scale Leggings
lib:AddRecipe(3873, 3511, 3845) -- Golden Scale Cuirass
lib:AddRecipe(3874, 3513, 3846) -- Polished Steel Boots
lib:AddRecipe(3875, 3515, 3847) -- Golden Scale Boots
lib:AddRecipe(5543, 6518, 5541) -- Iridescent Hammer
lib:AddRecipe(5578, 2673, 2869) -- Silvered Bronze Breastplate
lib:AddRecipe(6044, 7221, 6042) -- Iron Shield Spike
lib:AddRecipe(6045, 7222, 6043) -- Iron Counterweight
lib:AddRecipe(6046, 7224, 6041) -- Steel Weapon Chain
lib:AddRecipe(6047, 3503, 3837) -- Golden Scale Coif
lib:AddRecipe(6735, 8367, 6731) -- Ironforge Breastplate
lib:AddRecipe(7975, 9933, 7921) -- Heavy Mithril Pants
lib:AddRecipe(7976, 9939, 7967) -- Mithril Shield Spike
lib:AddRecipe(7978, 9811, 7913) -- Barbaric Iron Shoulders
lib:AddRecipe(7979, 9813, 7914) -- Barbaric Iron Breastplate
lib:AddRecipe(7980, 9814, 7915) -- Barbaric Iron Helm
lib:AddRecipe(7981, 9818, 7916) -- Barbaric Iron Boots
lib:AddRecipe(7982, 9820, 7917) -- Barbaric Iron Gloves
lib:AddRecipe(7983, 9945, 7926) -- Ornate Mithril Pants
lib:AddRecipe(7984, 9950, 7927) -- Ornate Mithril Gloves
lib:AddRecipe(7985, 9952, 7928) -- Ornate Mithril Shoulder
lib:AddRecipe(7989, 9964, 7969) -- Mithril Spurs
lib:AddRecipe(7990, 9970, 7934) -- Heavy Mithril Helm
lib:AddRecipe(7991, 9966, 7932) -- Mithril Scale Shoulders
lib:AddRecipe(7992, 9995, 7942) -- Blue Glittering Axe
lib:AddRecipe(7993, 10005, 7944) -- Dazzling Mithril Rapier
lib:AddRecipe(7995, 9937, 7924) -- Mithril Scale Bracers
lib:AddRecipe(8028, 10009, 7946) -- Runed Mithril Hammer
lib:AddRecipe(8029, 9997, 7943) -- Wicked Mithril Blade
lib:AddRecipe(8030, 10013, 7947) -- Ebon Shiv
lib:AddRecipe(9367, 11643, 9366) -- Golden Scale Gauntlets
lib:AddRecipe(10424, 12259, 10423) -- Silvered Bronze Leggings
lib:AddRecipe(10713, 11454, 9060) -- Inlaid Mithril Cylinder
lib:AddRecipe(10858, 3494, 3851) -- Solid Iron Maul
lib:AddRecipe(11610, 15292, 11608) -- Dark Iron Pulverizer
lib:AddRecipe(11611, 15294, 11607) -- Dark Iron Sunderer
lib:AddRecipe(11612, 15296, 11604) -- Dark Iron Plate
lib:AddRecipe(11614, 15293, 11606) -- Dark Iron Mail
lib:AddRecipe(11615, 15295, 11605) -- Dark Iron Shoulders
lib:AddRecipe(12162, 3492, 3849) -- Hardened Iron Shortsword
lib:AddRecipe(12163, 3496, 3853) -- Moonsteel Broadsword
lib:AddRecipe(12164, 3498, 3855) -- Massive Iron Axe
lib:AddRecipe(12261, 15973, 12260) -- Searing Golden Blade
lib:AddRecipe(12682, 16642, 12405) -- Thorium Armor
lib:AddRecipe(12683, 16643, 12406) -- Thorium Belt
lib:AddRecipe(12684, 16644, 12408) -- Thorium Bracers
lib:AddRecipe(12685, 16645, 12416) -- Radiant Belt
lib:AddRecipe(12687, 16646, 12428) -- Imperial Plate Shoulders
lib:AddRecipe(12688, 16647, 12424) -- Imperial Plate Belt
lib:AddRecipe(12689, 16648, 12415) -- Radiant Breastplate
lib:AddRecipe(12690, 16649, 12425) -- Imperial Plate Bracers
lib:AddRecipe(12691, 16650, 12624) -- Wildthorn Mail
lib:AddRecipe(12692, 16651, 12645) -- Thorium Shield Spike
lib:AddRecipe(12693, 16652, 12409) -- Thorium Boots
lib:AddRecipe(12694, 16653, 12410) -- Thorium Helm
lib:AddRecipe(12695, 16654, 12418) -- Radiant Gloves
lib:AddRecipe(12696, 16667, 12628) -- Demon Forged Breastplate
lib:AddRecipe(12697, 16656, 12419) -- Radiant Boots
lib:AddRecipe(12698, 16660, 12625) -- Dawnbringer Shoulders
lib:AddRecipe(12699, 16655, 12631) -- Fiery Plate Gauntlets
lib:AddRecipe(12700, 16657, 12426) -- Imperial Plate Boots
lib:AddRecipe(12701, 16658, 12427) -- Imperial Plate Helm
lib:AddRecipe(12702, 16659, 12417) -- Radiant Circlet
lib:AddRecipe(12703, 16661, 12632) -- Storm Gauntlets
lib:AddRecipe(12704, 16662, 12414) -- Thorium Leggings
lib:AddRecipe(12705, 16663, 12422) -- Imperial Plate Chest
lib:AddRecipe(12706, 16664, 12610) -- Runic Plate Shoulders
lib:AddRecipe(12707, 16665, 12611) -- Runic Plate Boots
lib:AddRecipe(12711, 16724, 12633) -- Whitesoul Helm
lib:AddRecipe(12713, 16725, 12420) -- Radiant Leggings
lib:AddRecipe(12714, 16726, 12612) -- Runic Plate Helm
lib:AddRecipe(12715, 16730, 12429) -- Imperial Plate Leggings
lib:AddRecipe(12716, 16728, 12636) -- Helm of the Great Chief
lib:AddRecipe(12717, 16729, 12640) -- Lionheart Helm
lib:AddRecipe(12718, 16731, 12613) -- Runic Breastplate
lib:AddRecipe(12719, 16732, 12614) -- Runic Plate Leggings
lib:AddRecipe(12720, 16741, 12639) -- Stronghold Gauntlets
lib:AddRecipe(12725, 16742, 12620) -- Enchanted Thorium Helm
lib:AddRecipe(12726, 16744, 12619) -- Enchanted Thorium Leggings
lib:AddRecipe(12727, 16745, 12618) -- Enchanted Thorium Breastplate
lib:AddRecipe(12728, 16746, 12641) -- Invulnerable Mail
lib:AddRecipe(12819, 16969, 12773) -- Ornate Thorium Handaxe
lib:AddRecipe(12821, 16970, 12774) -- Dawn's Edge
lib:AddRecipe(12823, 16971, 12775) -- Huge Thorium Battleaxe
lib:AddRecipe(12824, 16973, 12776) -- Enchanted Battlehammer
lib:AddRecipe(12825, 16978, 12777) -- Blazing Rapier
lib:AddRecipe(12827, 16983, 12781) -- Serenity
lib:AddRecipe(12828, 16984, 12792) -- Volcanic Hammer
lib:AddRecipe(12830, 16985, 12782) -- Corruption
lib:AddRecipe(12833, 16988, 12796) -- Hammer of the Titans
lib:AddRecipe(12834, 16990, 12790) -- Arcanite Champion
lib:AddRecipe(12835, 16991, 12798) -- Annihilator
lib:AddRecipe(12836, 16992, 12797) -- Frostguard
lib:AddRecipe(12837, 16993, 12794) -- Masterwork Stormhammer
lib:AddRecipe(12838, 16994, 12784) -- Arcanite Reaper
lib:AddRecipe(12839, 16995, 12783) -- Heartseeker
lib:AddRecipe(17049, 20872, 16989) -- Fiery Chain Girdle
lib:AddRecipe(17051, 20874, 17014) -- Dark Iron Bracers
lib:AddRecipe(17052, 20876, 17013) -- Dark Iron Leggings
lib:AddRecipe(17053, 20873, 16988) -- Fiery Chain Shoulders
lib:AddRecipe(17059, 20890, 17015) -- Dark Iron Reaver
lib:AddRecipe(17060, 20897, 17016) -- Dark Iron Destroyer
lib:AddRecipe(17706, 21913, 17704) -- Edge of Winter
lib:AddRecipe(18264, 22757, 18262) -- Elemental Sharpening Stone
lib:AddRecipe(18592, 21161, 17193) -- Sulfuron Hammer
lib:AddRecipe(19202, 23628, 19043) -- Heavy Timbermaw Belt
lib:AddRecipe(19203, 23632, 19051) -- Girdle of the Dawn
lib:AddRecipe(19204, 23629, 19048) -- Heavy Timbermaw Boots
lib:AddRecipe(19205, 23633, 19057) -- Gloves of the Dawn
lib:AddRecipe(19206, 23636, 19148) -- Dark Iron Helm
lib:AddRecipe(19207, 23637, 19164) -- Dark Iron Gauntlets
lib:AddRecipe(19208, 23638, 19166) -- Black Amnesty
lib:AddRecipe(19209, 23639, 19167) -- Blackfury
lib:AddRecipe(19210, 23650, 19170) -- Ebon Hand
lib:AddRecipe(19211, 23652, 19168) -- Blackguard
lib:AddRecipe(19212, 23653, 19169) -- Nightfall
lib:AddRecipe(19776, 24136, 19690) -- Bloodsoul Breastplate
lib:AddRecipe(19777, 24137, 19691) -- Bloodsoul Shoulders
lib:AddRecipe(19778, 24138, 19692) -- Bloodsoul Gauntlets
lib:AddRecipe(19779, 24139, 19693) -- Darksoul Breastplate
lib:AddRecipe(19780, 24140, 19694) -- Darksoul Leggings
lib:AddRecipe(19781, 24141, 19695) -- Darksoul Shoulders
lib:AddRecipe(20040, 24399, 20039) -- Dark Iron Boots
lib:AddRecipe(20553, 24912, 20549) -- Darkrune Gauntlets
lib:AddRecipe(20554, 24914, 20550) -- Darkrune Breastplate
lib:AddRecipe(20555, 24913, 20551) -- Darkrune Helm
lib:AddRecipe(22209, 27585, 22197) -- Heavy Obsidian Belt
lib:AddRecipe(22214, 27588, 22195) -- Light Obsidian Belt
lib:AddRecipe(22219, 27586, 22198) -- Jagged Obsidian Shield
lib:AddRecipe(22220, 27589, 22194) -- Black Grasp of the Destroyer
lib:AddRecipe(22221, 27590, 22191) -- Obsidian Mail Tunic
lib:AddRecipe(22222, 27587, 22196) -- Thick Obsidian Breastplate
lib:AddRecipe(22388, 27829, 22385) -- Titanic Leggings
lib:AddRecipe(22389, 27832, 22383) -- Sageblade
lib:AddRecipe(22390, 27830, 22384) -- Persuader
lib:AddRecipe(22766, 28461, 22762) -- Ironvine Breastplate
lib:AddRecipe(22767, 28462, 22763) -- Ironvine Gloves
lib:AddRecipe(22768, 28463, 22764) -- Ironvine Belt
lib:AddRecipe(23590, 29566, 23502) -- Adamantite Maul
lib:AddRecipe(23591, 29568, 23503) -- Adamantite Cleaver
lib:AddRecipe(23592, 29569, 23504) -- Adamantite Dagger
lib:AddRecipe(23593, 29571, 23505) -- Adamantite Rapier
lib:AddRecipe(23594, 29603, 23506) -- Adamantite Plate Bracers
lib:AddRecipe(23595, 29605, 23508) -- Adamantite Plate Gloves
lib:AddRecipe(23596, 29606, 23507) -- Adamantite Breastplate
lib:AddRecipe(23597, 29608, 23510) -- Enchanted Adamantite Belt
lib:AddRecipe(23598, 29611, 23511) -- Enchanted Adamantite Boots
lib:AddRecipe(23599, 29610, 23509) -- Enchanted Adamantite Breastplate
lib:AddRecipe(23600, 29613, 23512) -- Enchanted Adamantite Leggings
lib:AddRecipe(23601, 29614, 23515) -- Flamebane Bracers
lib:AddRecipe(23602, 29615, 23516) -- Flamebane Helm
lib:AddRecipe(23603, 29616, 23514) -- Flamebane Gloves
lib:AddRecipe(23604, 29617, 23513) -- Flamebane Breastplate
lib:AddRecipe(23605, 29619, 23517) -- Felsteel Gloves
lib:AddRecipe(23606, 29620, 23518) -- Felsteel Leggings
lib:AddRecipe(23607, 29621, 23519) -- Felsteel Helm
lib:AddRecipe(23608, 29628, 23524) -- Khorium Belt
lib:AddRecipe(23609, 29629, 23523) -- Khorium Pants
lib:AddRecipe(23610, 29630, 23525) -- Khorium Boots
lib:AddRecipe(23611, 29642, 23520) -- Ragesteel Gloves
lib:AddRecipe(23612, 29643, 23521) -- Ragesteel Helm
lib:AddRecipe(23613, 29645, 23522) -- Ragesteel Breastplate
lib:AddRecipe(23615, 29648, 23526) -- Swiftsteel Gloves
lib:AddRecipe(23617, 29649, 23527) -- Earthpeace Breastplate
lib:AddRecipe(23618, 29656, 23529) -- Adamantite Sharpening Stone
lib:AddRecipe(23619, 29657, 23530) -- Felsteel Shield Spike
lib:AddRecipe(23620, 29658, 23531) -- Felfury Gauntlets
lib:AddRecipe(23621, 29622, 23532) -- Gauntlets of the Iron Tower
lib:AddRecipe(23622, 29662, 23533) -- Steelgrip Gauntlets
lib:AddRecipe(23623, 29663, 23534) -- Storm Helm
lib:AddRecipe(23624, 29664, 23535) -- Helm of the Stalwart Defender
lib:AddRecipe(23625, 29668, 23536) -- Oathkeeper's Helm
lib:AddRecipe(23626, 29669, 23537) -- Black Felsteel Bracers
lib:AddRecipe(23627, 29671, 23538) -- Bracers of the Green Fortress
lib:AddRecipe(23628, 29672, 23539) -- Blessed Bracers
lib:AddRecipe(23629, 29692, 23540) -- Felsteel Longblade
lib:AddRecipe(23630, 29693, 23541) -- Khorium Champion
lib:AddRecipe(23631, 29694, 23542) -- Fel Edged Battleaxe
lib:AddRecipe(23632, 29695, 23543) -- Felsteel Reaper
lib:AddRecipe(23633, 29696, 23544) -- Runic Hammer
lib:AddRecipe(23634, 29697, 23546) -- Fel Hardened Maul
lib:AddRecipe(23635, 29698, 23554) -- Eternium Runed Blade
lib:AddRecipe(23636, 29699, 23555) -- Dirge
lib:AddRecipe(23637, 29700, 23556) -- Hand of Eternity
lib:AddRecipe(23638, 29728, 23575) -- Lesser Ward of Shielding
lib:AddRecipe(23639, 29729, 23576) -- Greater Ward of Shielding
lib:AddRecipe(24002, 29657, 23530) -- Felsteel Shield Spike
lib:AddRecipe(25526, 32285, 25521) -- Greater Rune of Warding
lib:AddRecipe(28632, 34608, 28421) -- Adamantite Weightstone
lib:AddRecipe(30321, 36389, 30034) -- Belt of the Guardian
lib:AddRecipe(30322, 36390, 30032) -- Red Belt of Battle
lib:AddRecipe(30323, 36391, 30033) -- Boots of the Protector
lib:AddRecipe(30324, 36392, 30031) -- Red Havoc Boots
lib:AddRecipe(31390, 38473, 31364) -- Wildguard Breastplate
lib:AddRecipe(31391, 38475, 31367) -- Wildguard Leggings
lib:AddRecipe(31392, 38476, 31368) -- Wildguard Helm
lib:AddRecipe(31393, 38477, 31369) -- Iceguard Breastplate
lib:AddRecipe(31394, 38478, 31370) -- Iceguard Leggings
lib:AddRecipe(31395, 38479, 31371) -- Iceguard Helm
lib:AddRecipe(32441, 40033, 32402) -- Shadesteel Sabots
lib:AddRecipe(32442, 40034, 32403) -- Shadesteel Bracers
lib:AddRecipe(32443, 40035, 32404) -- Shadesteel Greaves
lib:AddRecipe(32444, 40036, 32401) -- Shadesteel Girdle
lib:AddRecipe(32736, 41132, 32568) -- Swiftsteel Bracers
lib:AddRecipe(32737, 41133, 32570) -- Swiftsteel Shoulders
lib:AddRecipe(32738, 41134, 32571) -- Dawnsteel Bracers
lib:AddRecipe(32739, 41135, 32573) -- Dawnsteel Shoulders
lib:AddRecipe(33174, 42662, 33173) -- Ragesteel Shoulders
lib:AddRecipe(33186, 42688, 33185) -- Adamantite Weapon Chain
lib:AddRecipe(33792, 43549, 33791) -- Heavy Copper Longsword
lib:AddRecipe(33954, 43846, 32854) -- Hammer of Righteous Might
lib:AddRecipe(35208, 46140, 34380) -- Sunblessed Gauntlets
lib:AddRecipe(35209, 46141, 34378) -- Hard Khorium Battlefists
lib:AddRecipe(35210, 46142, 34379) -- Sunblessed Breastplate
lib:AddRecipe(35211, 46144, 34377) -- Hard Khorium Battleplate
lib:AddRecipe(35296, 42688, 33185) -- Adamantite Weapon Chain
lib:AddRecipe(41120, 54980, 40958) -- Reinforced Cobalt Legplates
lib:AddRecipe(41122, 54981, 40959) -- Reinforced Cobalt Chestpiece
lib:AddRecipe(41123, 54979, 40957) -- Reinforced Cobalt Helm
lib:AddRecipe(41124, 54978, 40956) -- Reinforced Cobalt Shoulders
lib:AddRecipe(44937, 62202, 44936) -- Titanium Plating
lib:AddRecipe(44938, 62202, 44936) -- Titanium Plating
lib:AddRecipe(45088, 63187, 45550) -- Belt of the Titans
lib:AddRecipe(45089, 63188, 45559) -- Battlelord's Plate Boots
lib:AddRecipe(45090, 63189, 45552) -- Plate Girdle of Righteousness
lib:AddRecipe(45091, 63190, 45561) -- Treads of Destiny
lib:AddRecipe(45092, 63191, 45551) -- Indestructible Plate Girdle
lib:AddRecipe(45093, 63192, 45560) -- Spiked Deathdealers
lib:AddRecipe(47622, 67091, 47591) -- Breastplate of the White Knight
lib:AddRecipe(47623, 67092, 47570) -- Saronite Swordbreakers
lib:AddRecipe(47624, 67093, 47589) -- Titanium Razorplate
lib:AddRecipe(47625, 67094, 47572) -- Titanium Spikeguards
lib:AddRecipe(47626, 67095, 47593) -- Sunforged Breastplate
lib:AddRecipe(47627, 67096, 47574) -- Sunforged Bracers
lib:AddRecipe(47640, 67130, 47592) -- Breastplate of the White Knight
lib:AddRecipe(47641, 67131, 47571) -- Saronite Swordbreakers
lib:AddRecipe(47642, 67135, 47575) -- Sunforged Bracers
lib:AddRecipe(47643, 67134, 47594) -- Sunforged Breastplate
lib:AddRecipe(47644, 67132, 47590) -- Titanium Razorplate
lib:AddRecipe(47645, 67133, 47573) -- Titanium Spikeguards
lib:AddRecipe(49969, 70562, 49902) -- Puresteel Legplates
lib:AddRecipe(49970, 70563, 49905) -- Protectors of Life
lib:AddRecipe(49971, 70565, 49903) -- Legplates of Painful Death
lib:AddRecipe(49972, 70566, 49906) -- Hellfrozen Bonegrinders
lib:AddRecipe(49973, 70567, 49904) -- Pillars of Might
lib:AddRecipe(49974, 70568, 49907) -- Boots of Kingly Upheaval
lib:AddRecipe(66100, 76439, 55054) -- Ebonsteel Belt Buckle
lib:AddRecipe(66101, 76440, 55056) -- Pyrium Shield Spike
lib:AddRecipe(66103, 76442, 55057) -- Pyrium Weapon Chain
lib:AddRecipe(66104, 76443, 55058) -- Hardened Elementium Hauberk
lib:AddRecipe(66105, 76444, 55059) -- Hardened Elementium Girdle
lib:AddRecipe(66106, 76445, 55060) -- Elementium Deathplate
lib:AddRecipe(66107, 76446, 55061) -- Elementium Girdle of Pain
lib:AddRecipe(66108, 76447, 55062) -- Light Elementium Chestguard
lib:AddRecipe(66109, 76448, 55063) -- Light Elementium Belt
lib:AddRecipe(66110, 76449, 55064) -- Elementium Spellblade
lib:AddRecipe(66111, 76450, 55065) -- Elementium Hammer
lib:AddRecipe(66112, 76451, 55066) -- Elementium Poleaxe
lib:AddRecipe(66113, 76452, 55067) -- Elementium Bonesplitter
lib:AddRecipe(66114, 76453, 55068) -- Elementium Shank
lib:AddRecipe(66115, 76454, 55069) -- Elementium Earthguard
lib:AddRecipe(66116, 76455, 55070) -- Elementium Stormshield
lib:AddRecipe(66117, 76456, 75124) -- Vicious Pyrium Bracers
lib:AddRecipe(66118, 76457, 75122) -- Vicious Pyrium Gauntlets
lib:AddRecipe(66119, 76458, 75123) -- Vicious Pyrium Belt
lib:AddRecipe(66120, 76459, 75120) -- Vicious Pyrium Boots
lib:AddRecipe(66121, 76461, 75119) -- Vicious Pyrium Shoulders
lib:AddRecipe(66122, 76462, 75136) -- Vicious Pyrium Legguards
lib:AddRecipe(66123, 76463, 75126) -- Vicious Pyrium Helm
lib:AddRecipe(66124, 76464, 75135) -- Vicious Pyrium Breastplate
lib:AddRecipe(66125, 76465, 75125) -- Vicious Ornate Pyrium Bracers
lib:AddRecipe(66126, 76466, 75121) -- Vicious Ornate Pyrium Gauntlets
lib:AddRecipe(66127, 76467, 75118) -- Vicious Ornate Pyrium Belt
lib:AddRecipe(66128, 76468, 75132) -- Vicious Ornate Pyrium Boots
lib:AddRecipe(66129, 76469, 75134) -- Vicious Ornate Pyrium Shoulders
lib:AddRecipe(66130, 76470, 75133) -- Vicious Ornate Pyrium Legguards
lib:AddRecipe(66131, 76471, 75129) -- Vicious Ornate Pyrium Helm
lib:AddRecipe(66132, 76472, 75128) -- Vicious Ornate Pyrium Breastplate
lib:AddRecipe(67603, 94718, 67602) -- Elementium Gutslicer
lib:AddRecipe(67606, 94732, 67605) -- Forged Elementium Mindcrusher
lib:AddRecipe(69957, 99439, 69936) -- Fists of Fury
lib:AddRecipe(69958, 99440, 69937) -- Eternal Elementium Handguards
lib:AddRecipe(69959, 99441, 69938) -- Holy Flame Gauntlets
lib:AddRecipe(69968, 99452, 69946) -- Warboots of Mighty Lords
lib:AddRecipe(69969, 99453, 69947) -- Mirrored Boots
lib:AddRecipe(69970, 99454, 69948) -- Emberforged Elementium Boots
lib:AddRecipe(70166, 99652, 70155) -- Brainsplinter
lib:AddRecipe(70167, 99653, 70156) -- Masterwork Elementium Spellblade
lib:AddRecipe(70168, 99654, 70157) -- Lightforged Elementium Hammer
lib:AddRecipe(70169, 99655, 70158) -- Elementium-Edged Scalper
lib:AddRecipe(70170, 99656, 70162) -- Pyrium Spellward
lib:AddRecipe(70171, 99657, 70163) -- Unbreakable Guardian
lib:AddRecipe(70172, 99658, 70164) -- Masterwork Elementium Deathblade
lib:AddRecipe(70173, 99660, 70165) -- Witch-Hunter's Harvester
lib:AddRecipe(72001, 101924, 71982) -- Pyrium Legplates of Purified Evil
lib:AddRecipe(72012, 101925, 71983) -- Unstoppable Destroyer's Legplates
lib:AddRecipe(72013, 101928, 71984) -- Foundations of Courage
lib:AddRecipe(72014, 101929, 71991) -- Soul Redeemer Bracers
lib:AddRecipe(72015, 101931, 71992) -- Bracers of Destructive Strength
lib:AddRecipe(72016, 101932, 71993) -- Titanguard Wristplates
lib:AddRecipe(74274, 10007, 7961) -- Phantom Blade
lib:AddRecipe(83787, 122649, 82975) -- Ghost Reaver's Breastplate
lib:AddRecipe(83788, 122650, 82976) -- Ghost Reaver's Gauntlets
lib:AddRecipe(83789, 122651, 82977) -- Living Steel Breastplate
lib:AddRecipe(83790, 122652, 82978) -- Living Steel Gauntlets
lib:AddRecipe(83791, 122653, 82979) -- Breastplate of Ancient Steel
lib:AddRecipe(83792, 122654, 82980) -- Gauntlets of Ancient Steel
lib:AddRecipe(84158, 122623, 82950) -- Contender's Revenant Belt
lib:AddRecipe(84159, 122622, 82949) -- Contender's Revenant Boots
lib:AddRecipe(84160, 122621, 82948) -- Contender's Revenant Bracers
lib:AddRecipe(84161, 122618, 82945) -- Contender's Revenant Breastplate
lib:AddRecipe(84162, 122619, 82946) -- Contender's Revenant Gauntlets
lib:AddRecipe(84163, 122616, 82943) -- Contender's Revenant Helm
lib:AddRecipe(84164, 122620, 82947) -- Contender's Revenant Legplates
lib:AddRecipe(84165, 122617, 82944) -- Contender's Revenant Shoulders
lib:AddRecipe(84166, 122631, 82958) -- Contender's Spirit Belt
lib:AddRecipe(84167, 122630, 82957) -- Contender's Spirit Boots
lib:AddRecipe(84168, 122629, 82956) -- Contender's Spirit Bracers
lib:AddRecipe(84169, 122626, 82953) -- Contender's Spirit Breastplate
lib:AddRecipe(84170, 122627, 82954) -- Contender's Spirit Gauntlets
lib:AddRecipe(84171, 122624, 82951) -- Contender's Spirit Helm
lib:AddRecipe(84172, 122628, 82955) -- Contender's Spirit Legplates
lib:AddRecipe(84173, 122625, 82952) -- Contender's Spirit Shoulders
lib:AddRecipe(84196, 122632, 90046) -- Living Steel Belt Buckle
lib:AddRecipe(84197, 122644, 82970) -- Masterwork Forgewire Axe
lib:AddRecipe(84198, 122648, 82974) -- Masterwork Ghost Shard
lib:AddRecipe(84208, 122642, 82968) -- Masterwork Lightsteel Shield
lib:AddRecipe(84217, 122646, 82972) -- Masterwork Phantasmal Hammer
lib:AddRecipe(84218, 122647, 82973) -- Masterwork Spiritblade Decimator
lib:AddRecipe(84219, 122599, 82926) -- Masterwork Spiritguard Belt
lib:AddRecipe(84220, 122598, 82925) -- Masterwork Spiritguard Boots
lib:AddRecipe(84221, 122597, 82924) -- Masterwork Spiritguard Bracers
lib:AddRecipe(84222, 122594, 82921) -- Masterwork Spiritguard Breastplate
lib:AddRecipe(84223, 122595, 82922) -- Masterwork Spiritguard Gauntlets
lib:AddRecipe(84224, 122592, 82919) -- Masterwork Spiritguard Helm
lib:AddRecipe(84225, 122596, 82923) -- Masterwork Spiritguard Legplates
lib:AddRecipe(84226, 122643, 82969) -- Masterwork Spiritguard Shield
lib:AddRecipe(84227, 122593, 82920) -- Masterwork Spiritguard Shoulders
lib:AddRecipe(87408, 126850, 87405) -- Unyielding Bloodplate
lib:AddRecipe(87409, 126851, 87406) -- Gauntlets of Battle Command
lib:AddRecipe(87410, 126852, 87402) -- Ornate Battleplate of the Master
lib:AddRecipe(87411, 126853, 87407) -- Bloodforged Warfists
lib:AddRecipe(87412, 126854, 87403) -- Chestplate of Limitless Faith
lib:AddRecipe(87413, 126855, 87404) -- Gauntlets of Unbound Devotion
lib:AddRecipe(90531, 131928, 86599) -- Ghost Iron Shield Spike
lib:AddRecipe(90532, 131929, 86597) -- Living Steel Weapon Chain
lib:AddRecipe(94552, 138646, 94111) -- Lightning Steel Ingot
lib:AddRecipe(94567, 138883, 94582) -- Thunder, Reborn
lib:AddRecipe(94568, 138882, 94581) -- Drakefist Hammer, Reborn
lib:AddRecipe(94569, 138877, 94576) -- Lunar Crescent, Reborn
lib:AddRecipe(94570, 138876, 94575) -- The Planar Edge, Reborn
lib:AddRecipe(94571, 138889, 94588) -- Lionheart Blade, Reborn
lib:AddRecipe(94572, 138888, 94587) -- Fireguard, Reborn
lib:AddRecipe(116726, 171691, 116426) -- Smoldering Helm
lib:AddRecipe(116727, 171692, 116427) -- Smoldering Breastplate
lib:AddRecipe(116728, 171693, 116425) -- Smoldering Greaves
lib:AddRecipe(116729, 171694, 116453) -- Steelforged Greataxe
lib:AddRecipe(116730, 171695, 116454) -- Steelforged Saber
lib:AddRecipe(116731, 171696, 116644) -- Steelforged Dagger
lib:AddRecipe(116732, 171697, 116646) -- Steelforged Hammer
lib:AddRecipe(116733, 171698, 116647) -- Steelforged Shield
lib:AddRecipe(116734, 171699, 116654) -- Truesteel Grinder
lib:AddRecipe(116735, 171700, 114231) -- Truesteel Pauldrons
lib:AddRecipe(116736, 171701, 114230) -- Truesteel Helm
lib:AddRecipe(116737, 171702, 114234) -- Truesteel Greaves
lib:AddRecipe(116738, 171703, 114237) -- Truesteel Gauntlets
lib:AddRecipe(116739, 171704, 114232) -- Truesteel Breastplate
lib:AddRecipe(116740, 171705, 114236) -- Truesteel Armguards
lib:AddRecipe(116741, 171706, 114235) -- Truesteel Boots
lib:AddRecipe(116742, 171707, 114233) -- Truesteel Waistguard
lib:AddRecipe(118044, 173355, 116428) -- Truesteel Reshaper
lib:AddRecipe(119329, 177169, 119328) -- Soul of the Forge
lib:AddRecipe(120129, 176090, 118720) -- Secrets of Draenor Blacksmithing
lib:AddRecipe(120260, 178243, 120259) -- Steelforged Axe
lib:AddRecipe(120262, 178245, 120261) -- Steelforged Aegis
lib:AddRecipe(122705, 182116, 108257) -- Riddle of Truesteel
lib:AddRecipe(123899, 182928, 123898) -- Leystone Armguards
lib:AddRecipe(123900, 182929, 123897) -- Leystone Waistguard
lib:AddRecipe(123901, 182930, 123896) -- Leystone Pauldrons
lib:AddRecipe(123902, 182931, 123895) -- Leystone Greaves
lib:AddRecipe(123903, 182932, 123894) -- Leystone Helm
lib:AddRecipe(123904, 182933, 123893) -- Leystone Gauntlets
lib:AddRecipe(123905, 182934, 123892) -- Leystone Boots
lib:AddRecipe(123906, 182935, 123891) -- Leystone Breastplate
lib:AddRecipe(123920, 182944, 123917) -- Demonsteel Armguards
lib:AddRecipe(123921, 182945, 123916) -- Demonsteel Waistguard
lib:AddRecipe(123922, 182946, 123915) -- Demonsteel Pauldrons
lib:AddRecipe(123923, 182947, 123914) -- Demonsteel Greaves
lib:AddRecipe(123924, 182948, 123913) -- Demonsteel Helm
lib:AddRecipe(123925, 182949, 123912) -- Demonsteel Gauntlets
lib:AddRecipe(123926, 182950, 123911) -- Demonsteel Boots
lib:AddRecipe(123927, 182951, 123910) -- Demonsteel Breastplate
lib:AddRecipe(123928, 182962, 123898) -- Leystone Armguards
lib:AddRecipe(123929, 182963, 123897) -- Leystone Waistguard
lib:AddRecipe(123930, 182964, 123896) -- Leystone Pauldrons
lib:AddRecipe(123931, 191931, 123895) -- Leystone Greaves
lib:AddRecipe(123932, 182966, 123894) -- Leystone Helm
lib:AddRecipe(123933, 182967, 123893) -- Leystone Gauntlets
lib:AddRecipe(123934, 182968, 123892) -- Leystone Boots
lib:AddRecipe(123935, 182969, 123891) -- Leystone Breastplate
lib:AddRecipe(123936, 182970, 123898) -- Leystone Armguards
lib:AddRecipe(123937, 182971, 123897) -- Leystone Waistguard
lib:AddRecipe(123938, 182972, 123896) -- Leystone Pauldrons
lib:AddRecipe(123939, 182973, 123891) -- Leystone Breastplate
lib:AddRecipe(123940, 182974, 123917) -- Demonsteel Armguards
lib:AddRecipe(123941, 182975, 123916) -- Demonsteel Waistguard
lib:AddRecipe(123942, 182976, 123915) -- Demonsteel Pauldrons
lib:AddRecipe(123943, 182977, 123914) -- Demonsteel Greaves
lib:AddRecipe(123944, 182978, 123913) -- Demonsteel Helm
lib:AddRecipe(123945, 182979, 123912) -- Demonsteel Gauntlets
lib:AddRecipe(123946, 182980, 123911) -- Demonsteel Boots
lib:AddRecipe(123947, 182981, 123910) -- Demonsteel Breastplate
lib:AddRecipe(123948, 182982, 123917) -- Demonsteel Armguards
lib:AddRecipe(123949, 182983, 123916) -- Demonsteel Waistguard
lib:AddRecipe(123950, 182984, 123915) -- Demonsteel Pauldrons
lib:AddRecipe(123951, 182985, 123914) -- Demonsteel Greaves
lib:AddRecipe(123952, 182986, 123913) -- Demonsteel Helm
lib:AddRecipe(123953, 182987, 123912) -- Demonsteel Gauntlets
lib:AddRecipe(123954, 182988, 123911) -- Demonsteel Boots
lib:AddRecipe(123955, 182989, 123910) -- Demonsteel Breastplate
lib:AddRecipe(123957, 182999, 123956) -- Leystone Hoofplates
lib:AddRecipe(124462, 184442, 124461) -- Demonsteel Bar
lib:AddRecipe(136696, 209496, 136683) -- Terrorspike
lib:AddRecipe(136697, 209497, 136684) -- Gleaming Iron Spike
lib:AddRecipe(136698, 209498, 136685) -- Consecrated Spike
lib:AddRecipe(136699, 209499, 136686) -- Flamespike
lib:AddRecipe(136709, 209564, 136708) -- Demonsteel Stirrups
lib:AddRecipe(137605, 191928, 123892) -- Leystone Boots
lib:AddRecipe(137606, 191930, 123893) -- Leystone Gauntlets
lib:AddRecipe(137607, 191929, 123894) -- Leystone Helm
lib:AddRecipe(137680, 182965, 123895) -- Leystone Greaves
lib:AddRecipe(137687, 213916, 137686) -- Fel Core Hound Harness
lib:AddRecipe(142279, 36131, 30077) -- Windforged Rapier
lib:AddRecipe(142282, 36134, 30087) -- Stormforged Axe
lib:AddRecipe(142283, 36135, 30088) -- Skyforged Great Axe
lib:AddRecipe(142284, 36133, 30086) -- Stoneforged Claymore
lib:AddRecipe(142286, 36136, 30089) -- Lavaforged Warhammer
lib:AddRecipe(142287, 36137, 30093) -- Great Earthforged Hammer
lib:AddRecipe(142337, 10011, 7959) -- Blight
lib:AddRecipe(142346, 16965, 12769) -- Bleakwood Hew
lib:AddRecipe(142357, 16970, 12774) -- Dawn's Edge
lib:AddRecipe(142358, 16978, 12777) -- Blazing Rapier
lib:AddRecipe(142370, 16990, 12790) -- Arcanite Champion
lib:AddRecipe(142383, 16987, 12802) -- Darkspear
lib:AddRecipe(142402, 36125, 30071) -- Light Earthforged Blade
lib:AddRecipe(151709, 247700, 151239) -- Felslate Anchor
lib:AddRecipe(151711, 247710, 151576) -- Empyrial Breastplate
lib:AddRecipe(151712, 247713, 151576) -- Empyrial Breastplate
lib:AddRecipe(151713, 247714, 151576) -- Empyrial Breastplate
lib:AddRecipe(162261, 253118, 152819) -- Stormsteel Shield
lib:AddRecipe(162262, 269425, 159860) -- Honorable Combatant's Plate Boots
lib:AddRecipe(162263, 269426, 159860) -- Honorable Combatant's Plate Boots
lib:AddRecipe(162265, 269422, 159861) -- Honorable Combatant's Plate Gauntlets
lib:AddRecipe(162266, 269423, 159861) -- Honorable Combatant's Plate Gauntlets
lib:AddRecipe(162267, 269446, 159863) -- Honorable Combatant's Plate Greaves
lib:AddRecipe(162268, 269447, 159863) -- Honorable Combatant's Plate Greaves
lib:AddRecipe(162269, 269449, 159865) -- Honorable Combatant's Plate Waistguard
lib:AddRecipe(162270, 269450, 159865) -- Honorable Combatant's Plate Waistguard
lib:AddRecipe(162271, 269452, 159866) -- Honorable Combatant's Plate Armguards
lib:AddRecipe(162272, 269453, 159866) -- Honorable Combatant's Plate Armguards
lib:AddRecipe(162273, 269459, 159851) -- Honorable Combatant's Shield
lib:AddRecipe(162274, 269460, 159851) -- Honorable Combatant's Shield
lib:AddRecipe(162275, 253158, 152835) -- Stormsteel Dagger
lib:AddRecipe(162276, 253161, 152834) -- Stormsteel Spear
lib:AddRecipe(162277, 269465, 159853) -- Honorable Combatant's Cutlass
lib:AddRecipe(162278, 269466, 159853) -- Honorable Combatant's Cutlass
lib:AddRecipe(162279, 269471, 159855) -- Honorable Combatant's Deckpounder
lib:AddRecipe(162280, 269472, 159855) -- Honorable Combatant's Deckpounder
lib:AddRecipe(162281, 269477, 159857) -- Honorable Combatant's Shanker
lib:AddRecipe(162282, 269478, 159857) -- Honorable Combatant's Shanker
lib:AddRecipe(162283, 269480, 159858) -- Honorable Combatant's Polearm
lib:AddRecipe(162284, 269481, 159858) -- Honorable Combatant's Polearm
lib:AddRecipe(162495, 253187, 162491) -- Imbued Stormsteel Legguards
lib:AddRecipe(162496, 253188, 162464) -- Emblazoned Stormsteel Legguards
lib:AddRecipe(162497, 253191, 162492) -- Imbued Stormsteel Girdle
lib:AddRecipe(162498, 253192, 162466) -- Emblazoned Stormsteel Girdle
lib:AddRecipe(162668, 253149, 162652) -- Honorable Combatant's Spellblade
lib:AddRecipe(162669, 253144, 162652) -- Honorable Combatant's Spellblade
lib:AddRecipe(162670, 278133, 162655) -- Stormsteel Saber
lib:AddRecipe(162706, 253118, 152819) -- Stormsteel Shield
lib:AddRecipe(162707, 253158, 152835) -- Stormsteel Dagger
lib:AddRecipe(162708, 253161, 152834) -- Stormsteel Spear
lib:AddRecipe(162774, 278133, 162655) -- Stormsteel Saber
lib:AddRecipe(165278, 283250, 164653) -- Sinister Combatant's Plate Boots
lib:AddRecipe(165279, 283251, 164653) -- Sinister Combatant's Plate Boots
lib:AddRecipe(165280, 283247, 164654) -- Sinister Combatant's Plate Gauntlets
lib:AddRecipe(165281, 283248, 164654) -- Sinister Combatant's Plate Gauntlets
lib:AddRecipe(165282, 283243, 164655) -- Sinister Combatant's Plate Greaves
lib:AddRecipe(165283, 283244, 164655) -- Sinister Combatant's Plate Greaves
lib:AddRecipe(165284, 282878, 164648) -- Sinister Combatant's Shield
lib:AddRecipe(165285, 282879, 164648) -- Sinister Combatant's Shield
lib:AddRecipe(165286, 283240, 164656) -- Sinister Combatant's Plate Waistguard
lib:AddRecipe(165287, 283241, 164656) -- Sinister Combatant's Plate Waistguard
lib:AddRecipe(165288, 283237, 164657) -- Sinister Combatant's Plate Armguards
lib:AddRecipe(165289, 283238, 164657) -- Sinister Combatant's Plate Armguards
lib:AddRecipe(165290, 282872, 164649) -- Sinister Combatant's Cutlass
lib:AddRecipe(165291, 282873, 164649) -- Sinister Combatant's Cutlass
lib:AddRecipe(165292, 282869, 164650) -- Sinister Combatant's Deckpounder
lib:AddRecipe(165293, 282870, 164650) -- Sinister Combatant's Deckpounder
lib:AddRecipe(165294, 282866, 164719) -- Sinister Combatant's Spellblade
lib:AddRecipe(165295, 282867, 164719) -- Sinister Combatant's Spellblade
lib:AddRecipe(165296, 282863, 164651) -- Sinister Combatant's Shanker
lib:AddRecipe(165297, 282864, 164651) -- Sinister Combatant's Shanker
lib:AddRecipe(165298, 282860, 164652) -- Sinister Combatant's Polearm
lib:AddRecipe(165299, 282861, 164652) -- Sinister Combatant's Polearm
lib:AddRecipe(165640, 285090, 165389) -- Fortified Stormsteel Legguards
lib:AddRecipe(165641, 285098, 165397) -- Tempered Stormsteel Legguards
lib:AddRecipe(165642, 285089, 165414) -- Fortified Stormsteel Girdle
lib:AddRecipe(165643, 285097, 165422) -- Tempered Stormsteel Girdle
lib:AddRecipe(166260, 286016, 152812) -- Monel-Hardened Hoofplates
lib:AddRecipe(168022, 253145, 152839) -- Khaz'gorian Smithing Hammer
lib:AddRecipe(168759, 298999, 168678) -- Reinforced Osmenite Legguards
lib:AddRecipe(168760, 299000, 168679) -- Banded Osmenite Legguards
lib:AddRecipe(168761, 299002, 168681) -- Reinforced Osmenite Girdle
lib:AddRecipe(168762, 299003, 168682) -- Banded Osmenite Girdle
lib:AddRecipe(169505, 294752, 167969) -- Notorious Combatant's Plate Gauntlets
lib:AddRecipe(169506, 294753, 167969) -- Notorious Combatant's Plate Gauntlets
lib:AddRecipe(169507, 294764, 167965) -- Notorious Combatant's Plate Armguards
lib:AddRecipe(169508, 294765, 167965) -- Notorious Combatant's Plate Armguards
lib:AddRecipe(169509, 294761, 167973) -- Notorious Combatant's Plate Waistguard
lib:AddRecipe(169510, 294762, 167973) -- Notorious Combatant's Plate Waistguard
lib:AddRecipe(169511, 294749, 167967) -- Notorious Combatant's Plate Boots
lib:AddRecipe(169512, 294750, 167967) -- Notorious Combatant's Plate Boots
lib:AddRecipe(169513, 294755, 167971) -- Notorious Combatant's Plate Greaves
lib:AddRecipe(169514, 294756, 167971) -- Notorious Combatant's Plate Greaves
lib:AddRecipe(169515, 294773, 167995) -- Notorious Combatant's Spellblade
lib:AddRecipe(169516, 294774, 167995) -- Notorious Combatant's Spellblade
lib:AddRecipe(169517, 294776, 167989) -- Notorious Combatant's Shanker
lib:AddRecipe(169518, 294777, 167989) -- Notorious Combatant's Shanker
lib:AddRecipe(169519, 294767, 167937) -- Notorious Combatant's Cutlass
lib:AddRecipe(169520, 294768, 167937) -- Notorious Combatant's Cutlass
lib:AddRecipe(169522, 294758, 167991) -- Notorious Combatant's Shield
lib:AddRecipe(169523, 294759, 167991) -- Notorious Combatant's Shield
lib:AddRecipe(169524, 294779, 167975) -- Notorious Combatant's Polearm
lib:AddRecipe(169525, 294780, 167975) -- Notorious Combatant's Polearm
lib:AddRecipe(169526, 294770, 167939) -- Notorious Combatant's Deckpounder
lib:AddRecipe(169528, 294771, 167939) -- Notorious Combatant's Deckpounder
lib:AddRecipe(169529, 265937, 158887) -- Monelite Reinforced Chassis
lib:AddRecipe(170392, 306081, 170288) -- Uncanny Combatant's Plate Waistguard
lib:AddRecipe(170393, 306080, 170288) -- Uncanny Combatant's Plate Waistguard
lib:AddRecipe(170394, 306087, 170285) -- Uncanny Combatant's Plate Boots
lib:AddRecipe(170395, 306086, 170285) -- Uncanny Combatant's Plate Boots
lib:AddRecipe(170396, 306085, 170286) -- Uncanny Combatant's Plate Gauntlets
lib:AddRecipe(170397, 306084, 170286) -- Uncanny Combatant's Plate Gauntlets
lib:AddRecipe(170398, 306083, 170287) -- Uncanny Combatant's Plate Greaves
lib:AddRecipe(170399, 306082, 170287) -- Uncanny Combatant's Plate Greaves
lib:AddRecipe(170400, 306312, 170364) -- Uncanny Combatant's Shield
lib:AddRecipe(170401, 306310, 170364) -- Uncanny Combatant's Shield
lib:AddRecipe(170402, 306079, 170289) -- Uncanny Combatant's Plate Armguards
lib:AddRecipe(170403, 306078, 170289) -- Uncanny Combatant's Plate Armguards
lib:AddRecipe(170946, 305844, 170290) -- Uncanny Combatant's Polearm
lib:AddRecipe(170947, 305845, 170290) -- Uncanny Combatant's Polearm
lib:AddRecipe(170948, 305846, 170291) -- Uncanny Combatant's Shanker
lib:AddRecipe(170949, 305847, 170291) -- Uncanny Combatant's Shanker
lib:AddRecipe(170950, 305848, 170292) -- Uncanny Combatant's Spellblade
lib:AddRecipe(170951, 305849, 170292) -- Uncanny Combatant's Spellblade
lib:AddRecipe(170952, 305850, 170293) -- Uncanny Combatant's Deckpounder
lib:AddRecipe(170953, 305851, 170293) -- Uncanny Combatant's Deckpounder
lib:AddRecipe(170954, 305852, 170294) -- Uncanny Combatant's Cutlass
lib:AddRecipe(170955, 305853, 170294) -- Uncanny Combatant's Cutlass
lib:AddRecipe(171107, 305838, 170391) -- Eldritch Osmenite Girdle
lib:AddRecipe(171108, 305839, 170390) -- Maddening Osmenite Girdle
lib:AddRecipe(171109, 305841, 170388) -- Eldritch Osmenite Legguards
lib:AddRecipe(171110, 305842, 170387) -- Maddening Osmenite Legguards
lib:AddRecipe(171316, 305843, 170386) -- Unsettling Osmenite Legguards
lib:AddRecipe(171317, 305840, 170389) -- Unsettling Osmenite Girdle
lib:AddRecipe(183094, 322590, 171445) -- Shadowsteel Helm
lib:AddRecipe(183095, 322593, 171447) -- Shadowsteel Pauldrons
lib:AddRecipe(183864, 343186, 173383) -- Crafter's Mark III
lib:AddRecipe(194453, 376621, 193605) -- Crimson Combatant's Draconium Helm
lib:AddRecipe(194454, 376618, 193602) -- Crimson Combatant's Draconium Breastplate
lib:AddRecipe(194455, 376620, 193606) -- Crimson Combatant's Draconium Greaves
lib:AddRecipe(194456, 376622, 193607) -- Crimson Combatant's Draconium Pauldrons
lib:AddRecipe(194457, 376619, 193604) -- Crimson Combatant's Draconium Gauntlets
lib:AddRecipe(194458, 376623, 193603) -- Crimson Combatant's Draconium Sabatons
lib:AddRecipe(194459, 376617, 193609) -- Crimson Combatant's Draconium Armguards
lib:AddRecipe(194460, 376624, 193608) -- Crimson Combatant's Draconium Waistguard
lib:AddRecipe(194461, 367605, 190498) -- Primal Molten Helm
lib:AddRecipe(194462, 367608, 190495) -- Primal Molten Breastplate
lib:AddRecipe(194463, 367604, 190499) -- Primal Molten Legplates
lib:AddRecipe(194464, 367603, 190500) -- Primal Molten Pauldrons
lib:AddRecipe(194465, 367606, 190497) -- Primal Molten Gauntlets
lib:AddRecipe(194466, 367607, 190496) -- Primal Molten Sabatons
lib:AddRecipe(194467, 367601, 190502) -- Primal Molten Vambraces
lib:AddRecipe(194468, 367602, 190501) -- Primal Molten Greatbelt
lib:AddRecipe(194469, 367622, 190503) -- Primal Molten Defender
lib:AddRecipe(194470, 365730, 190505) -- Primal Molten Shortblade
lib:AddRecipe(194471, 365731, 190506) -- Primal Molten Spellblade
lib:AddRecipe(194472, 367585, 190507) -- Primal Molten Longsword
lib:AddRecipe(194473, 365729, 190508) -- Primal Molten Warglaive
lib:AddRecipe(194474, 367586, 190509) -- Primal Molten Mace
lib:AddRecipe(194475, 365734, 190510) -- Primal Molten Greataxe
lib:AddRecipe(194476, 367587, 190511) -- Obsidian Seared Hexsword
lib:AddRecipe(194477, 367594, 190512) -- Obsidian Seared Runeaxe
lib:AddRecipe(194478, 367589, 190513) -- Obsidian Seared Facesmasher
lib:AddRecipe(194479, 367590, 190514) -- Obsidian Seared Claymore
lib:AddRecipe(194480, 367588, 190515) -- Obsidian Seared Halberd
lib:AddRecipe(194481, 367591, 190516) -- Obsidian Seared Crusher
lib:AddRecipe(194482, 367592, 190517) -- Obsidian Seared Invoker
lib:AddRecipe(194483, 367593, 190518) -- Obsidian Seared Slicer
lib:AddRecipe(194484, 367617, 190522) -- Infurious Helm of Vengeance
lib:AddRecipe(194485, 367616, 191985) -- Infurious Warboots of Impunity
lib:AddRecipe(194486, 367623, 192081) -- Shield of the Hearth
lib:AddRecipe(194489, 367615, 190519) -- Allied Chestplate of Generosity
lib:AddRecipe(194490, 367614, 190526) -- Allied Wristguard of Companionship
lib:AddRecipe(194491, 367619, 190523) -- Frostfire Legguards of Preparation
lib:AddRecipe(194492, 367618, 191623) -- Unstable Frostfire Belt
lib:AddRecipe(194493, 371349, 191250) -- Armor Spikes
lib:AddRecipe(194495, 371365, 191224) -- Khaz'gorite Sickle
lib:AddRecipe(194496, 371366, 191223) -- Khaz'gorite Pickaxe
lib:AddRecipe(194497, 371367, 191225) -- Khaz'gorite Skinning Knife
lib:AddRecipe(194498, 371368, 191226) -- Khaz'gorite Needle Set
lib:AddRecipe(194499, 371369, 191227) -- Khaz'gorite Leatherworker's Knife
lib:AddRecipe(194500, 371371, 191229) -- Khaz'gorite Leatherworker's Toolset
lib:AddRecipe(194501, 371412, 191888) -- Khaz'gorite Blacksmith's Hammer
lib:AddRecipe(194502, 371374, 191230) -- Khaz'gorite Blacksmith's Toolbox
lib:AddRecipe(194503, 371372, 191228) -- Black Dragon Touched Hammer
lib:AddRecipe(194504, 371650, 191933) -- Primal Whetstone
lib:AddRecipe(194505, 371674, 191943) -- Primal Weightstone
lib:AddRecipe(194506, 371682, 191948) -- Primal Razorstone
lib:AddRecipe(194507, 371394, 191256) -- Serevite Skeleton Key
lib:AddRecipe(194508, 371403, 191886) -- Alvin the Anvil
lib:AddRecipe(194963, 367713, 190533) -- Obsidian Seared Alloy
lib:AddRecipe(198713, 377281, 194542) -- Prototype Explorer's Barding Framework
lib:AddRecipe(198714, 377280, 194541) -- Prototype Regal Barding Framework
lib:AddRecipe(198719, 388279, 191304) -- Sturdy Expedition Shovel
lib:AddRecipe(200102, 367714, 190536) -- Infurious Alloy
lib:AddRecipe(201256, 367714, 190536) -- Infurious Alloy
lib:AddRecipe(202223, 397853, 202208) -- Impressive Steelforged Essence
lib:AddRecipe(202224, 397855, 202209) -- Remarkable Steelforged Essence
lib:AddRecipe(202226, 397856, 202210) -- Impressive Truesteel Essence
lib:AddRecipe(202227, 397857, 202211) -- Remarkable Truesteel Essence
lib:AddRecipe(203421, 400808, 203408) -- Ancient Ceremonial Trident
lib:AddRecipe(203824, 402118, 203817) -- Gurubashi Headplate
lib:AddRecipe(203825, 402123, 203810) -- Gurubashi Carver
lib:AddRecipe(203826, 402124, 203802) -- Venomfang
lib:AddRecipe(203827, 402125, 203812) -- Gurubashi Poker
lib:AddRecipe(203828, 402126, 203809) -- Gurubashi Grinder
lib:AddRecipe(203829, 402128, 203797) -- Gurubashi Hexxer
lib:AddRecipe(203830, 402129, 203804) -- Sceptre of Hexing
lib:AddRecipe(203831, 402130, 203806) -- Gurubashi Crusher
lib:AddRecipe(203832, 402131, 203811) -- Pitchfork of Mojo Madness
lib:AddRecipe(203833, 402134, 203790) -- Bloodherald
lib:AddRecipe(203834, 402135, 203793) -- Bloodlord's Reaver
lib:AddRecipe(203835, 402136, 203813) -- Fiery Vengeance
lib:AddRecipe(203836, 402137, 207011) -- Warblades of the Hakkari, Reborn
lib:AddRecipe(203837, 402138, 203801) -- Gurubashi Slicer
lib:AddRecipe(203861, 402133, 203860) -- Venomreaver
lib:AddRecipe(204138, 403162, 204124) -- Obsidian Combatant's Draconium Helm
lib:AddRecipe(204139, 403159, 204121) -- Obsidian Combatant's Draconium Breastplate
lib:AddRecipe(204140, 403161, 204125) -- Obsidian Combatant's Draconium Greaves
lib:AddRecipe(204141, 403163, 204126) -- Obsidian Combatant's Draconium Pauldrons
lib:AddRecipe(204142, 403160, 204123) -- Obsidian Combatant's Draconium Gauntlets
lib:AddRecipe(204143, 403164, 204122) -- Obsidian Combatant's Draconium Sabatons
lib:AddRecipe(204144, 403158, 204128) -- Obsidian Combatant's Draconium Armguards
lib:AddRecipe(204145, 403165, 204127) -- Obsidian Combatant's Draconium Waistguard
lib:AddRecipe(205137, 408282, 204994) -- Shadowed Alloy
lib:AddRecipe(205143, 408288, 205039) -- Shadowed Belt Clasp
lib:AddRecipe(205144, 408283, 205046) -- Shadowed Razing Annihilator
lib:AddRecipe(205145, 408326, 205168) -- Shadowed Impact Buckler
lib:AddRecipe(205161, 408299, 205038) -- Heat-Resistant Rescue Ring
lib:AddRecipe(206351, 10015, 7960) -- Truesilver Champion
lib:AddRecipe(206352, 10003, 7954) -- The Shatterer
lib:AddRecipe(206419, 413506, 206444) -- Icebane Coif
lib:AddRecipe(206420, 413507, 206443) -- Icebane Mantle
lib:AddRecipe(206421, 28242, 22669) -- Icebane Breastplate
lib:AddRecipe(206422, 28244, 22671) -- Icebane Bracers
lib:AddRecipe(206423, 28243, 22670) -- Icebane Gauntlets
lib:AddRecipe(206424, 413508, 206445) -- Icebane Waistguard
lib:AddRecipe(206425, 413509, 206442) -- Icebane Leggings
lib:AddRecipe(206426, 413510, 206446) -- Icebane Trudgers
lib:AddRecipe(206522, 413511, 206477) -- Warsword of Caer Darrow
lib:AddRecipe(206525, 413512, 206478) -- Darrowdirk
lib:AddRecipe(206526, 413513, 206479) -- Darrowshire Protector
lib:AddRecipe(206527, 413514, 206480) -- Mirah's Lullaby
lib:AddRecipe(206531, 413518, 206484) -- Strength of Menethil
lib:AddRecipe(206533, 413520, 206486) -- Midnight's Graze
lib:AddRecipe(206534, 413521, 206487) -- Weaver's Fang
lib:AddRecipe(206535, 413522, 206488) -- Widow's Weep
lib:AddRecipe(206536, 413523, 206489) -- Shade's Blade
lib:AddRecipe(206537, 413524, 206490) -- Edict of the Redeemed Crusader
lib:AddRecipe(206539, 413739, 206492) -- Blade of Unholy Might
lib:AddRecipe(206540, 413740, 206493) -- Axe of Sundered Bone
lib:AddRecipe(206541, 413741, 206494) -- The Plague Belcher
lib:AddRecipe(206542, 413742, 206495) -- Bracers of Vengeance
lib:AddRecipe(206544, 413744, 206497) -- The Final Dream
lib:AddRecipe(206545, 413745, 206498) -- Plated Construct's Ribcage
lib:AddRecipe(206546, 413746, 206499) -- Blade of the Fallen Seraph
lib:AddRecipe(206549, 413749, 206502) -- The Face of Doom
lib:AddRecipe(206550, 413750, 206503) -- Harbinger of Death
lib:AddRecipe(206553, 413753, 206506) -- Dawn of Demise
lib:AddRecipe(206555, 413755, 206508) -- Gauntlets of the Unrelenting
lib:AddRecipe(206557, 413757, 206510) -- Death's Gamble
lib:AddRecipe(206558, 413758, 206511) -- Belt of the Mentor
lib:AddRecipe(206560, 413760, 206513) -- Stygian Shield
lib:AddRecipe(206774, 414567, 206648) -- Undeath Metal
lib:AddRecipe(206805, 414590, 206787) -- Bucket Kickers
lib:AddRecipe(207567, 416682, 207555) -- Intrepid Shortblade
lib:AddRecipe(207568, 416683, 207556) -- Valiant Shortblade
lib:AddRecipe(207572, 416687, 207560) -- Sacred Guardian
lib:AddRecipe(207573, 416688, 207561) -- Ichor Slicer
lib:AddRecipe(208281, 419035, 208267) -- Verdant Combatant's Draconium Helm
lib:AddRecipe(208282, 419032, 208264) -- Verdant Combatant's Draconium Breastplate
lib:AddRecipe(208283, 419034, 208268) -- Verdant Combatant's Draconium Greaves
lib:AddRecipe(208284, 419036, 208269) -- Verdant Combatant's Draconium Pauldrons
lib:AddRecipe(208285, 419033, 208266) -- Verdant Combatant's Draconium Gauntlets
lib:AddRecipe(208286, 419037, 208265) -- Verdant Combatant's Draconium Sabatons
lib:AddRecipe(208287, 419031, 208271) -- Verdant Combatant's Draconium Armguards
lib:AddRecipe(208288, 419038, 208270) -- Verdant Combatant's Draconium Waistguard
lib:AddRecipe(210644, 426332, 210646) -- Flourishing Dream Helm
-- Cooking
lib:AddRecipe(728, 2543, 733) -- Westfall Stew
lib:AddRecipe(2697, 2542, 724) -- Goretusk Liver Pie
lib:AddRecipe(2698, 2545, 2682) -- Cooked Crab Claw
lib:AddRecipe(2699, 2547, 1082) -- Redridge Goulash
lib:AddRecipe(2700, 2548, 2685) -- Succulent Pork Ribs
lib:AddRecipe(2701, 2549, 1017) -- Seasoned Wolf Kabob
lib:AddRecipe(2889, 2795, 2888) -- Beer Basted Boar Ribs
lib:AddRecipe(3678, 3370, 3662) -- Crocolisk Steak
lib:AddRecipe(3679, 3371, 3220) -- Blood Sausage
lib:AddRecipe(3680, 3372, 3663) -- Murloc Fin Soup
lib:AddRecipe(3681, 3373, 3664) -- Crocolisk Gumbo
lib:AddRecipe(3682, 3376, 3665) -- Curiously Tasty Omelet
lib:AddRecipe(3683, 3377, 3666) -- Gooey Spider Cake
lib:AddRecipe(3734, 3397, 3726) -- Big Bear Steak
lib:AddRecipe(3735, 3398, 3727) -- Hot Lion Chops
lib:AddRecipe(3736, 3399, 3728) -- Tasty Lion Steak
lib:AddRecipe(3737, 3400, 3729) -- Soothing Turtle Bisque
lib:AddRecipe(4609, 4094, 4457) -- Barbecued Buzzard Wing
lib:AddRecipe(5482, 6412, 5472) -- Kaldorei Spider Kabob
lib:AddRecipe(5483, 6413, 5473) -- Scorpid Surprise
lib:AddRecipe(5484, 6414, 5474) -- Roasted Kodo Meat
lib:AddRecipe(5485, 6415, 5476) -- Fillet of Frenzy
lib:AddRecipe(5486, 6416, 5477) -- Strider Stew
lib:AddRecipe(5488, 6418, 5479) -- Crispy Lizard Tail
lib:AddRecipe(5489, 6419, 5480) -- Lean Venison
lib:AddRecipe(5528, 6501, 5526) -- Clam Chowder
lib:AddRecipe(6039, 7213, 6038) -- Giant Clam Scorcho
lib:AddRecipe(6325, 7751, 6290) -- Brilliant Smallfish
lib:AddRecipe(6326, 7752, 787) -- Slitherskin Mackerel
lib:AddRecipe(6328, 7753, 4592) -- Longjaw Mud Snapper
lib:AddRecipe(6329, 7754, 6316) -- Loch Frenzy Delight
lib:AddRecipe(6330, 7755, 4593) -- Bristle Whisker Catfish
lib:AddRecipe(6368, 7827, 5095) -- Rainbow Fin Albacore
lib:AddRecipe(6369, 7828, 4594) -- Rockscale Cod
lib:AddRecipe(6661, 8238, 6657) -- Savory Deviate Delight
lib:AddRecipe(6892, 8607, 6890) -- Smoked Bear Meat
lib:AddRecipe(7678, 9513, 7676) -- Thistle Tea
lib:AddRecipe(12226, 15935, 12224) -- Crispy Bat Wing
lib:AddRecipe(12227, 15853, 12209) -- Lean Wolf Steak
lib:AddRecipe(12228, 15855, 12210) -- Roast Raptor
lib:AddRecipe(12229, 15856, 13851) -- Hot Wolf Ribs
lib:AddRecipe(12231, 15861, 12212) -- Jungle Stew
lib:AddRecipe(12232, 15863, 12213) -- Carrion Surprise
lib:AddRecipe(12233, 15865, 12214) -- Mystery Stew
lib:AddRecipe(12239, 15906, 12217) -- Dragonbreath Chili
lib:AddRecipe(12240, 15910, 12215) -- Heavy Kodo Stew
lib:AddRecipe(13939, 18238, 6887) -- Spotted Yellowtail
lib:AddRecipe(13940, 18239, 13927) -- Cooked Glossy Mightfish
lib:AddRecipe(13941, 18241, 13930) -- Filet of Redgill
lib:AddRecipe(13942, 18240, 13928) -- Grilled Squid
lib:AddRecipe(13943, 18242, 13929) -- Hot Smoked Bass
lib:AddRecipe(13945, 18243, 13931) -- Nightfin Soup
lib:AddRecipe(13946, 18244, 13932) -- Poached Sunscale Salmon
lib:AddRecipe(13947, 18245, 13933) -- Lobster Stew
lib:AddRecipe(13948, 18246, 13934) -- Mightfish Steak
lib:AddRecipe(13949, 18247, 13935) -- Baked Salmon
lib:AddRecipe(16110, 15933, 12218) -- Monster Omelet
lib:AddRecipe(16111, 15915, 12216) -- Spiced Chili Crab
lib:AddRecipe(16767, 20626, 16766) -- Undermine Clam Chowder
lib:AddRecipe(17062, 20916, 8364) -- Mithril Head Trout
lib:AddRecipe(17200, 21143, 17197) -- Gingerbread Cookie
lib:AddRecipe(17201, 21144, 17198) -- Winter Veil Egg Nog
lib:AddRecipe(18046, 22480, 18045) -- Tender Wolf Steak
lib:AddRecipe(18160, 9513, 7676) -- Thistle Tea
lib:AddRecipe(18267, 22761, 18254) -- Runn Tum Tuber Surprise
lib:AddRecipe(20075, 24418, 20074) -- Heavy Crocolisk Stew
lib:AddRecipe(21025, 25659, 21023) -- Dirge's Kickin' Chimaerok Chops
lib:AddRecipe(21099, 25704, 21072) -- Smoked Sagefish
lib:AddRecipe(21219, 25954, 21217) -- Sagefish Delight
lib:AddRecipe(22647, 28267, 22645) -- Crunchy Spider Surprise
lib:AddRecipe(27684, 33279, 27651) -- Buzzard Bites
lib:AddRecipe(27685, 33276, 27635) -- Lynx Steak
lib:AddRecipe(27686, 33277, 24105) -- Roasted Moongraze Tenderloin
lib:AddRecipe(27687, 33278, 27636) -- Bat Bites
lib:AddRecipe(27688, 33284, 27655) -- Ravager Dog
lib:AddRecipe(27690, 33286, 27657) -- Blackened Basilisk
lib:AddRecipe(27691, 33287, 27658) -- Roasted Clefthoof
lib:AddRecipe(27692, 33288, 27659) -- Warp Burger
lib:AddRecipe(27693, 33289, 27660) -- Talbuk Steak
lib:AddRecipe(27694, 33290, 27661) -- Blackened Trout
lib:AddRecipe(27695, 33291, 27662) -- Feltail Delight
lib:AddRecipe(27696, 33292, 27663) -- Blackened Sporefish
lib:AddRecipe(27697, 33293, 27664) -- Grilled Mudfish
lib:AddRecipe(27698, 33294, 27665) -- Poached Bluefish
lib:AddRecipe(27699, 33295, 27666) -- Golden Fish Sticks
lib:AddRecipe(27700, 33296, 27667) -- Spicy Crawdad
lib:AddRecipe(30156, 36210, 30155) -- Clam Bar
lib:AddRecipe(31674, 38868, 31673) -- Crunchy Serpent
lib:AddRecipe(31675, 38867, 31672) -- Mok'Nathal Shortribs
lib:AddRecipe(33869, 43761, 33867) -- Broiled Bloodfin
lib:AddRecipe(33870, 43707, 33825) -- Skullfish Soup
lib:AddRecipe(33871, 43758, 33866) -- Stormchops
lib:AddRecipe(33873, 43765, 33872) -- Spicy Hot Talbuk
lib:AddRecipe(33875, 43772, 33874) -- Kibler's Bits
lib:AddRecipe(33925, 43779, 33924) -- Delicious Chocolate Cake
lib:AddRecipe(34413, 45022, 34411) -- Hot Apple Cider
lib:AddRecipe(34834, 45695, 34832) -- Captain Rumsey's Lager
lib:AddRecipe(35564, 46684, 35563) -- Charred Bear Kabobs
lib:AddRecipe(35566, 46688, 35565) -- Juicy Bear Burger
lib:AddRecipe(39644, 53056, 39520) -- Kungaloosh
lib:AddRecipe(43017, 57423, 43015) -- Fish Feast
lib:AddRecipe(43018, 45555, 34754) -- Mega Mammoth Meal
lib:AddRecipe(43019, 45556, 34755) -- Tender Shoveltusk Steak
lib:AddRecipe(43020, 45557, 34756) -- Spiced Worm Burger
lib:AddRecipe(43021, 45558, 34757) -- Very Burnt Worg
lib:AddRecipe(43022, 45559, 34758) -- Mighty Rhino Dogs
lib:AddRecipe(43023, 45567, 34766) -- Poached Northern Sculpin
lib:AddRecipe(43024, 45568, 34767) -- Firecracker Salmon
lib:AddRecipe(43025, 45571, 34768) -- Spicy Blue Nettlefish
lib:AddRecipe(43026, 45570, 34769) -- Imperial Manta Steak
lib:AddRecipe(43027, 57433, 42993) -- Spicy Fried Herring
lib:AddRecipe(43028, 57434, 42994) -- Rhinolicious Wormsteak
lib:AddRecipe(43029, 57435, 43004) -- Critter Bites
lib:AddRecipe(43030, 57436, 42995) -- Hearty Rhino
lib:AddRecipe(43031, 57437, 42996) -- Snapper Extreme
lib:AddRecipe(43032, 57438, 42997) -- Blackened Worg Steak
lib:AddRecipe(43033, 57439, 42998) -- Cuttlesteak
lib:AddRecipe(43034, 57440, 43005) -- Spiced Mammoth Treats
lib:AddRecipe(43035, 57441, 42999) -- Blackened Dragonfin
lib:AddRecipe(43036, 57442, 43000) -- Dragonfin Filet
lib:AddRecipe(43037, 57443, 43001) -- Tracker Snacks
lib:AddRecipe(43505, 58527, 43478) -- Gigantic Feast
lib:AddRecipe(43506, 58528, 43480) -- Small Feast
lib:AddRecipe(43507, 58512, 43490) -- Tasty Cupcake
lib:AddRecipe(43508, 58521, 43488) -- Last Week's Mammoth
lib:AddRecipe(43509, 58523, 43491) -- Bad Clams
lib:AddRecipe(43510, 58525, 43492) -- Haunted Herring
lib:AddRecipe(44858, 62049, 44840) -- Cranberry Chutney
lib:AddRecipe(44859, 62051, 44839) -- Candied Sweet Potato
lib:AddRecipe(44860, 62050, 44837) -- Spice Bread Stuffing
lib:AddRecipe(44861, 62045, 44838) -- Slow-Roasted Turkey
lib:AddRecipe(44862, 62044, 44836) -- Pumpkin Pie
lib:AddRecipe(44954, 62350, 44953) -- Worg Tartare
lib:AddRecipe(46710, 65454, 46691) -- Bread of the Dead
lib:AddRecipe(46803, 66038, 44837) -- Spice Bread Stuffing
lib:AddRecipe(46804, 66036, 44836) -- Pumpkin Pie
lib:AddRecipe(46805, 66035, 44840) -- Cranberry Chutney
lib:AddRecipe(46806, 66034, 44839) -- Candied Sweet Potato
lib:AddRecipe(46807, 66037, 44838) -- Slow-Roasted Turkey
lib:AddRecipe(62799, 88011, 62289) -- Broiled Dragon Feast
lib:AddRecipe(62800, 88036, 62290) -- Seafood Magnifique Feast
lib:AddRecipe(65406, 88047, 62656) -- Whitecrest Gumbo
lib:AddRecipe(65407, 88024, 62654) -- Lavascale Fillet
lib:AddRecipe(65408, 88017, 62673) -- Feathered Lure
lib:AddRecipe(65409, 88025, 62663) -- Lavascale Minestrone
lib:AddRecipe(65410, 88035, 62653) -- Salted Eye
lib:AddRecipe(65411, 88012, 62655) -- Broiled Mountain Trout
lib:AddRecipe(65412, 88028, 62651) -- Lightly Fried Lurker
lib:AddRecipe(65413, 88037, 62652) -- Seasoned Crab
lib:AddRecipe(65414, 88045, 62675) -- Starfire Espresso
lib:AddRecipe(65415, 88022, 62674) -- Highland Spirits
lib:AddRecipe(65416, 88030, 62657) -- Lurker Lunch
lib:AddRecipe(65417, 88033, 62660) -- Pickled Guppy
lib:AddRecipe(65418, 88021, 62659) -- Hearty Seafood Soup
lib:AddRecipe(65419, 88046, 62658) -- Tender Baked Turtle
lib:AddRecipe(65420, 88031, 62667) -- Mushroom Sauce Mudfish
lib:AddRecipe(65421, 88039, 62671) -- Severed Sagefish Head
lib:AddRecipe(65422, 88016, 62666) -- Delicious Sagefish Tail
lib:AddRecipe(65423, 88018, 62677) -- Fish Fry
lib:AddRecipe(65424, 88034, 62668) -- Blackbelly Sushi
lib:AddRecipe(65425, 88042, 62669) -- Skewered Eel
lib:AddRecipe(65426, 88003, 62661) -- Baked Rockfish
lib:AddRecipe(65427, 88004, 62665) -- Basilisk Liverdog
lib:AddRecipe(65428, 88020, 62662) -- Grilled Dragon
lib:AddRecipe(65429, 88005, 62670) -- Beer-Basted Crocolisk
lib:AddRecipe(65430, 88014, 62664) -- Crocolisk Au Gratin
lib:AddRecipe(65431, 88013, 62680) -- Chocolate Cookie
lib:AddRecipe(65432, 88019, 62649) -- Fortune Cookie
lib:AddRecipe(65433, 88044, 62672) -- South Island Iced Tea
lib:AddRecipe(68688, 96133, 68687) -- Scalding Murglesnout
lib:AddRecipe(74657, 125120, 86073) -- Spicy Salmon
lib:AddRecipe(74658, 125123, 86074) -- Spicy Vegetable Chips
lib:AddRecipe(75013, 105190, 74919) -- Pandaren Banquet
lib:AddRecipe(75017, 105194, 75016) -- Great Pandaren Banquet
lib:AddRecipe(78342, 6417, 5478) -- Dig Rat Stew
lib:AddRecipe(85502, 124029, 85501) -- Viseclaw Soup
lib:AddRecipe(85505, 124032, 85504) -- Krasarang Fritters
lib:AddRecipe(86393, 126654, 87264) -- Four Senses Brew
lib:AddRecipe(87266, 126655, 86432) -- Banana Infused Rum
lib:AddRecipe(101765, 145305, 101746) -- Seasoned Pomfruit Slices
lib:AddRecipe(101766, 145307, 101748) -- Spiced Blossom Soup
lib:AddRecipe(101767, 145308, 101745) -- Mango Ice
lib:AddRecipe(101768, 145309, 101747) -- Farmer's Delight
lib:AddRecipe(101769, 145310, 101749) -- Stuffed Lushrooms
lib:AddRecipe(101770, 145311, 101750) -- Fluffy Silkfeather Omelet
lib:AddRecipe(118310, 160958, 111431) -- Hearty Elekk Steak
lib:AddRecipe(118311, 160962, 111433) -- Blackrock Ham
lib:AddRecipe(118312, 160966, 111434) -- Pan-Seared Talbuk
lib:AddRecipe(118313, 160968, 111436) -- Braised Riverbeast
lib:AddRecipe(118314, 160969, 111437) -- Rylak Crepes
lib:AddRecipe(118315, 160971, 111438) -- Clefthoof Sausages
lib:AddRecipe(118316, 160973, 111439) -- Steamed Scorpion
lib:AddRecipe(118317, 160978, 111441) -- Grilled Gulper
lib:AddRecipe(118318, 160979, 111442) -- Sturgeon Stew
lib:AddRecipe(118319, 160981, 111444) -- Fat Sleeper Cakes
lib:AddRecipe(118320, 160982, 111445) -- Fiery Calamari
lib:AddRecipe(118321, 160983, 111446) -- Skulker Chowder
lib:AddRecipe(118322, 160984, 111447) -- Talador Surf and Turf
lib:AddRecipe(118323, 160986, 111449) -- Blackrock Barbecue
lib:AddRecipe(118324, 160987, 111450) -- Frosty Stew
lib:AddRecipe(118325, 160989, 111452) -- Sleeper Surprise
lib:AddRecipe(118326, 160999, 111453) -- Calamari Crepes
lib:AddRecipe(118327, 161000, 111454) -- Gorgrond Chowder
lib:AddRecipe(118328, 173978, 111457) -- Feast of Blood
lib:AddRecipe(118329, 173979, 111458) -- Feast of the Waters
lib:AddRecipe(122555, 180762, 122343) -- Sleeper Sushi
lib:AddRecipe(122556, 180761, 122348) -- Buttered Sturgeon
lib:AddRecipe(122557, 180759, 122346) -- Jumbo Sea Dog
lib:AddRecipe(122558, 180758, 122345) -- Pickled Eel
lib:AddRecipe(122559, 180757, 122344) -- Salty Squid Roll
lib:AddRecipe(122560, 180760, 122347) -- Whiptail Fillet
lib:AddRecipe(126927, 185708, 126936) -- Sugar-Crusted Fish Feast
lib:AddRecipe(126928, 185704, 126934) -- Lemon Herb Filet
lib:AddRecipe(126929, 185705, 126935) -- Fancy Darkmoon Feast
lib:AddRecipe(128501, 190788, 128498) -- Fel Eggs and Ham
lib:AddRecipe(133810, 201413, 133557) -- Salt and Pepper Shank
lib:AddRecipe(133812, 201496, 133561) -- Deep-Fried Mossgill
lib:AddRecipe(133813, 201497, 133562) -- Pickled Stormray
lib:AddRecipe(133814, 201498, 133563) -- Faronaar Fizz
lib:AddRecipe(133815, 201499, 133564) -- Spiced Rib Roast
lib:AddRecipe(133816, 201500, 133565) -- Leybeque Ribs
lib:AddRecipe(133817, 201501, 133566) -- Suramar Surf and Turf
lib:AddRecipe(133818, 201502, 133567) -- Barracuda Mrglgagh
lib:AddRecipe(133819, 201503, 133568) -- Koi-Scented Stormray
lib:AddRecipe(133820, 201504, 133569) -- Drogbar-Style Salmon
lib:AddRecipe(133821, 201505, 133570) -- The Hungry Magister
lib:AddRecipe(133822, 201506, 133571) -- Azshari Salad
lib:AddRecipe(133823, 201507, 133572) -- Nightborne Delicacy Platter
lib:AddRecipe(133824, 201508, 133573) -- Seed-Battered Fish Plate
lib:AddRecipe(133825, 201511, 133574) -- Fishbrul Special
lib:AddRecipe(133826, 201512, 133575) -- Dried Mackerel Strips
lib:AddRecipe(133827, 201513, 133576) -- Bear Tartare
lib:AddRecipe(133828, 201514, 133577) -- Fighter Chow
lib:AddRecipe(133829, 201515, 133578) -- Hearty Feast
lib:AddRecipe(133830, 201516, 133579) -- Lavish Suramar Feast
lib:AddRecipe(133831, 201524, 133557) -- Salt and Pepper Shank
lib:AddRecipe(133832, 201525, 133561) -- Deep-Fried Mossgill
lib:AddRecipe(133833, 201526, 133562) -- Pickled Stormray
lib:AddRecipe(133834, 201527, 133563) -- Faronaar Fizz
lib:AddRecipe(133835, 201528, 133564) -- Spiced Rib Roast
lib:AddRecipe(133836, 201529, 133565) -- Leybeque Ribs
lib:AddRecipe(133837, 201530, 133566) -- Suramar Surf and Turf
lib:AddRecipe(133838, 201531, 133567) -- Barracuda Mrglgagh
lib:AddRecipe(133839, 201532, 133568) -- Koi-Scented Stormray
lib:AddRecipe(133840, 201533, 133569) -- Drogbar-Style Salmon
lib:AddRecipe(133841, 201534, 133570) -- The Hungry Magister
lib:AddRecipe(133842, 201535, 133571) -- Azshari Salad
lib:AddRecipe(133843, 201536, 133572) -- Nightborne Delicacy Platter
lib:AddRecipe(133844, 201537, 133573) -- Seed-Battered Fish Plate
lib:AddRecipe(133845, 201538, 133574) -- Fishbrul Special
lib:AddRecipe(133846, 201539, 133575) -- Dried Mackerel Strips
lib:AddRecipe(133847, 201540, 133576) -- Bear Tartare
lib:AddRecipe(133848, 201541, 133577) -- Fighter Chow
lib:AddRecipe(133849, 201542, 133578) -- Hearty Feast
lib:AddRecipe(133850, 201543, 133579) -- Lavish Suramar Feast
lib:AddRecipe(133851, 201544, 133557) -- Salt and Pepper Shank
lib:AddRecipe(133852, 201545, 133561) -- Deep-Fried Mossgill
lib:AddRecipe(133853, 201546, 133562) -- Pickled Stormray
lib:AddRecipe(133854, 201547, 133563) -- Faronaar Fizz
lib:AddRecipe(133855, 201548, 133564) -- Spiced Rib Roast
lib:AddRecipe(133856, 201549, 133565) -- Leybeque Ribs
lib:AddRecipe(133857, 201550, 133566) -- Suramar Surf and Turf
lib:AddRecipe(133858, 201551, 133567) -- Barracuda Mrglgagh
lib:AddRecipe(133859, 201552, 133568) -- Koi-Scented Stormray
lib:AddRecipe(133860, 201553, 133569) -- Drogbar-Style Salmon
lib:AddRecipe(133861, 201554, 133570) -- The Hungry Magister
lib:AddRecipe(133862, 201555, 133571) -- Azshari Salad
lib:AddRecipe(133863, 201556, 133572) -- Nightborne Delicacy Platter
lib:AddRecipe(133864, 201557, 133573) -- Seed-Battered Fish Plate
lib:AddRecipe(133865, 201558, 133574) -- Fishbrul Special
lib:AddRecipe(133866, 201559, 133575) -- Dried Mackerel Strips
lib:AddRecipe(133867, 201560, 133576) -- Bear Tartare
lib:AddRecipe(133868, 201561, 133577) -- Fighter Chow
lib:AddRecipe(133869, 201562, 133578) -- Hearty Feast
lib:AddRecipe(133870, 201563, 133579) -- Lavish Suramar Feast
lib:AddRecipe(133871, 201683, 133681) -- Crispy Bacon
lib:AddRecipe(133872, 201684, 133681) -- Crispy Bacon
lib:AddRecipe(133873, 201685, 133681) -- Crispy Bacon
lib:AddRecipe(142331, 230046, 142334) -- Spiced Falcosaur Omelet
lib:AddRecipe(152565, 251258, 152564) -- Feast of the Fishes
lib:AddRecipe(162285, 259413, 154881) -- Kul Tiramisu
lib:AddRecipe(162286, 259416, 154882) -- Honey-Glazed Haunches
lib:AddRecipe(162287, 259420, 156525) -- Galley Banquet
lib:AddRecipe(162288, 259422, 156526) -- Bountiful Captain's Feast
lib:AddRecipe(162289, 259423, 156526) -- Bountiful Captain's Feast
lib:AddRecipe(162290, 259426, 154883) -- Ravenberry Tarts
lib:AddRecipe(162291, 259429, 154884) -- Swamp Fish 'n Chips
lib:AddRecipe(162292, 259432, 154889) -- Grilled Catfish
lib:AddRecipe(162293, 259435, 154891) -- Seasoned Loins
lib:AddRecipe(162294, 259438, 154887) -- Loa Loaf
lib:AddRecipe(162295, 259441, 154888) -- Sailor's Pie
lib:AddRecipe(162296, 259444, 154885) -- Mon'Dazi
lib:AddRecipe(162297, 259447, 154886) -- Spiced Snapper
lib:AddRecipe(163833, 280282, 163781) -- Heartsbane Hexwurst
lib:AddRecipe(166263, 287110, 166240) -- Sanguinated Feast
lib:AddRecipe(166264, 287112, 166240) -- Sanguinated Feast
lib:AddRecipe(166367, 288029, 166343) -- Wild Berry Bread
lib:AddRecipe(166368, 288033, 166344) -- Seasoned Steak and Potatoes
lib:AddRecipe(166806, 290472, 166804) -- Boralus Blood Sausage
lib:AddRecipe(166807, 290473, 166804) -- Boralus Blood Sausage
lib:AddRecipe(168330, 297080, 168310) -- Mech-Dowel's "Big Mech"
lib:AddRecipe(168331, 297083, 168313) -- Baked Port Tato
lib:AddRecipe(168332, 297086, 168311) -- Abyssal-Fried Rissole
lib:AddRecipe(168333, 297089, 168314) -- Bil'Tong
lib:AddRecipe(168334, 297074, 168312) -- Fragrant Kakavia
lib:AddRecipe(168368, 297107, 168315) -- Famine Evaluator And Snack Table
lib:AddRecipe(168369, 297106, 168315) -- Famine Evaluator And Snack Table
lib:AddRecipe(169457, 301392, 169449) -- Mecha-Bytes
lib:AddRecipe(170075, 303788, 169280) -- Unagi Skewer
lib:AddRecipe(170211, 297107, 168315) -- Famine Evaluator And Snack Table
lib:AddRecipe(170212, 301392, 169449) -- Mecha-Bytes
lib:AddRecipe(182668, 308403, 172043) -- Feast of Gluttonous Hedonism
lib:AddRecipe(184625, 347176, 184624) -- Extra Sugary Fish Feast
lib:AddRecipe(184683, 347457, 184682) -- Extra Lemony Herb Filet
lib:AddRecipe(184689, 347509, 184690) -- Extra Fancy Darkmoon Feast
lib:AddRecipe(187006, 354764, 186704) -- Twilight Tea
lib:AddRecipe(187007, 354766, 186725) -- Bonemeal Bread
lib:AddRecipe(187008, 354768, 186726) -- Porous Rock Candy
lib:AddRecipe(187804, 359333, 187648) -- Empty Kettle of Stone Soup
lib:AddRecipe(194964, 381388, 197776) -- Thrice-Spiced Mammoth Kabob
lib:AddRecipe(194965, 381413, 197793) -- Yusa's Hearty Stew
lib:AddRecipe(195881, 381385, 197774) -- Charred Hornswog Steaks
lib:AddRecipe(198092, 381365, 197758) -- Twice-Baked Potato
lib:AddRecipe(198093, 381367, 197759) -- Cheese and Quackers
lib:AddRecipe(198094, 381368, 197760) -- Mackerel Snackerel
lib:AddRecipe(198095, 381369, 197761) -- Probably Protein
lib:AddRecipe(198096, 381370, 197762) -- Sweet and Sour Clam Chowder
lib:AddRecipe(198097, 381371, 197763) -- Breakfast of Draconic Champions
lib:AddRecipe(198098, 378302, 194902) -- Ooey-Gooey Chocolate
lib:AddRecipe(198099, 381363, 197756) -- Pebbled Rock Salts
lib:AddRecipe(198100, 381364, 197757) -- Assorted Exotic Spices
lib:AddRecipe(198101, 381373, 197764) -- Salad on the Side
lib:AddRecipe(198102, 381375, 197765) -- Impossibly Sharp Cutting Knife
lib:AddRecipe(198103, 381376, 197766) -- Snow in a Cone
lib:AddRecipe(198104, 381377, 197767) -- Blubbery Muffin
lib:AddRecipe(198105, 381378, 197768) -- Celebratory Cake
lib:AddRecipe(198106, 381380, 197769) -- Tasty Hatchling's Treat
lib:AddRecipe(198107, 381381, 197770) -- Zesty Water
lib:AddRecipe(198108, 381382, 197771) -- Delicious Dragon Spittle
lib:AddRecipe(198109, 381383, 197772) -- Churnbelly Tea
lib:AddRecipe(198111, 381386, 197775) -- Scrambled Basilisk Eggs
lib:AddRecipe(198112, 381389, 197777) -- Hopefully Healthy
lib:AddRecipe(198113, 381391, 197778) -- Timely Demise
lib:AddRecipe(198114, 381392, 197779) -- Filet of Fangs
lib:AddRecipe(198115, 381393, 197780) -- Seamoth Surprise
lib:AddRecipe(198116, 381395, 197781) -- Salt-Baked Fishcake
lib:AddRecipe(198117, 381396, 197782) -- Feisty Fish Sticks
lib:AddRecipe(198118, 381397, 197783) -- Aromatic Seafood Platter
lib:AddRecipe(198119, 381398, 197784) -- Sizzling Seafood Medley
lib:AddRecipe(198120, 381399, 197785) -- Revenge, Served Cold
lib:AddRecipe(198121, 381400, 197786) -- Thousandbone Tongueslicer
lib:AddRecipe(198122, 381402, 197787) -- Great Cerulean Sea
lib:AddRecipe(198123, 381403, 197788) -- Braised Bruffalon Brisket
lib:AddRecipe(198124, 381404, 197789) -- Riverside Picnic
lib:AddRecipe(198125, 381407, 197790) -- Roast Duck Delight
lib:AddRecipe(198126, 381411, 197791) -- Salted Meat Mash
lib:AddRecipe(198127, 381412, 197792) -- Fated Fortune Cookie
lib:AddRecipe(198129, 381415, 197794) -- Gral's Reverence
lib:AddRecipe(198130, 381417, 197794) -- Gral's Veneration
lib:AddRecipe(198131, 381418, 197794) -- Gral's Devotion
lib:AddRecipe(198132, 381420, 197795) -- Hoard of Draconic Delicacies
lib:AddRecipe(201784, 381391, 197778) -- Timely Demise
lib:AddRecipe(201785, 381393, 197780) -- Seamoth Surprise
lib:AddRecipe(201786, 381395, 197781) -- Salt-Baked Fishcake
lib:AddRecipe(201787, 381392, 197779) -- Filet of Fangs
lib:AddRecipe(202249, 13028, 10841) -- Goldthorn Tea
lib:AddRecipe(202289, 398438, 202290) -- Firewater Sorbet
lib:AddRecipe(203422, 400807, 203409) -- Sparkling Spice Pouch
lib:AddRecipe(204073, 403018, 204072) -- Deviously Deviled Eggs
lib:AddRecipe(204847, 407066, 204845) -- Rocks on the Rocks
lib:AddRecipe(204849, 407100, 204848) -- Charitable Cheddar
lib:AddRecipe(210242, 416001, 207054) -- Slumbering Peacebloom Tea
-- Enchanting
lib:AddRecipe(6342, 7443, nil) -- Minor Mana
lib:AddRecipe(6344, 7766, nil) -- Minor Versatility
lib:AddRecipe(6346, 7776, nil) -- Lesser Mana
lib:AddRecipe(6347, 7782, nil) -- Minor Strength
lib:AddRecipe(6348, 7786, nil) -- Minor Beastslayer
lib:AddRecipe(6349, 7793, nil) -- Lesser Intellect
lib:AddRecipe(6375, 7859, nil) -- Lesser Versatility
lib:AddRecipe(6377, 7867, nil) -- Minor Agility
lib:AddRecipe(11038, 13380, nil) -- Lesser Versatility
lib:AddRecipe(11039, 13419, nil) -- Minor Agility
lib:AddRecipe(11081, 13464, nil) -- Lesser Protection
lib:AddRecipe(11101, 13536, nil) -- Lesser Strength
lib:AddRecipe(11150, 13612, nil) -- Mining
lib:AddRecipe(11152, 13620, nil) -- Fishing
lib:AddRecipe(11163, 13646, nil) -- Lesser Dodge
lib:AddRecipe(11164, 13653, nil) -- Lesser Beastslayer
lib:AddRecipe(11165, 13655, nil) -- Lesser Elemental Slayer
lib:AddRecipe(11166, 13698, nil) -- Skinning
lib:AddRecipe(11167, 13687, nil) -- Lesser Versatility
lib:AddRecipe(11168, 13689, nil) -- Lesser Parry
lib:AddRecipe(11202, 13817, nil) -- Stamina
lib:AddRecipe(11203, 13841, nil) -- Advanced Mining
lib:AddRecipe(11204, 13846, nil) -- Greater Versatility
lib:AddRecipe(11205, 13868, nil) -- Advanced Herbalism
lib:AddRecipe(11207, 13898, nil) -- Fiery Weapon
lib:AddRecipe(11208, 13915, nil) -- Demonslaying
lib:AddRecipe(11223, 13931, nil) -- Dodge
lib:AddRecipe(11225, 13945, nil) -- Greater Stamina
lib:AddRecipe(11226, 13947, nil) -- Riding Skill
lib:AddRecipe(11813, 15596, 11811) -- Smoking Heart of the Mountain
lib:AddRecipe(16214, 20008, nil) -- Greater Intellect
lib:AddRecipe(16215, 20020, nil) -- Greater Stamina
lib:AddRecipe(16217, 20017, nil) -- Greater Stamina
lib:AddRecipe(16218, 20009, nil) -- Superior Versatility
lib:AddRecipe(16219, 20012, nil) -- Greater Agility
lib:AddRecipe(16220, 20024, nil) -- Versatility
lib:AddRecipe(16221, 20026, nil) -- Major Health
lib:AddRecipe(16222, 20016, nil) -- Vitality
lib:AddRecipe(16223, 20029, nil) -- Icy Chill
lib:AddRecipe(16224, 20015, nil) -- Superior Defense
lib:AddRecipe(16242, 20028, nil) -- Major Mana
lib:AddRecipe(16244, 20013, nil) -- Greater Strength
lib:AddRecipe(16245, 20023, nil) -- Greater Agility
lib:AddRecipe(16246, 20010, nil) -- Superior Strength
lib:AddRecipe(16247, 20030, nil) -- Superior Impact
lib:AddRecipe(16248, 20033, nil) -- Unholy Weapon
lib:AddRecipe(16249, 20036, nil) -- Major Intellect
lib:AddRecipe(16250, 20031, nil) -- Superior Striking
lib:AddRecipe(16251, 20011, nil) -- Superior Stamina
lib:AddRecipe(16252, 20034, nil) -- Crusader
lib:AddRecipe(16253, 20025, nil) -- Greater Stats
lib:AddRecipe(16254, 20032, nil) -- Lifestealing
lib:AddRecipe(16255, 20035, nil) -- Major Versatility
lib:AddRecipe(17725, 21931, nil) -- Winter's Might
lib:AddRecipe(18259, 22749, nil) -- Spellpower
lib:AddRecipe(18260, 22750, nil) -- Healing Power
lib:AddRecipe(19444, 23799, nil) -- Strength
lib:AddRecipe(19445, 23800, nil) -- Agility
lib:AddRecipe(19446, 23801, nil) -- Argent Versatility
lib:AddRecipe(19447, 23802, nil) -- Healing Power
lib:AddRecipe(19448, 23803, nil) -- Mighty Versatility
lib:AddRecipe(19449, 23804, nil) -- Mighty Intellect
lib:AddRecipe(20726, 25072, nil) -- Threat
lib:AddRecipe(20727, 25073, nil) -- Shadow Power
lib:AddRecipe(20728, 25074, nil) -- Frost Power
lib:AddRecipe(20729, 25078, nil) -- Fire Power
lib:AddRecipe(20730, 25079, nil) -- Healing Power
lib:AddRecipe(20731, 25080, nil) -- Superior Agility
lib:AddRecipe(20734, 25083, nil) -- Stealth
lib:AddRecipe(20735, 25084, nil) -- Subtlety
lib:AddRecipe(20736, 25086, nil) -- Dodge
lib:AddRecipe(20752, 25125, 20745) -- Minor Mana Oil
lib:AddRecipe(20753, 25126, 20746) -- Lesser Wizard Oil
lib:AddRecipe(20754, 25127, 20747) -- Lesser Mana Oil
lib:AddRecipe(20755, 25128, 20750) -- Wizard Oil
lib:AddRecipe(20756, 25129, 203865) -- Brilliant Wizard Oil
lib:AddRecipe(20757, 25130, 203862) -- Brilliant Mana Oil
lib:AddRecipe(20758, 25124, 20744) -- Minor Wizard Oil
lib:AddRecipe(22392, 27837, nil) -- Agility
lib:AddRecipe(22530, 27906, nil) -- Greater Dodge
lib:AddRecipe(22531, 27911, nil) -- Superior Healing
lib:AddRecipe(22532, 27913, nil) -- Versatility Prime
lib:AddRecipe(22533, 27914, nil) -- Fortitude
lib:AddRecipe(22534, 27917, nil) -- Spellpower
lib:AddRecipe(22539, 27945, nil) -- Intellect
lib:AddRecipe(22540, 27946, nil) -- Parry
lib:AddRecipe(22542, 27948, nil) -- Vitality
lib:AddRecipe(22543, 27950, nil) -- Fortitude
lib:AddRecipe(22544, 27951, nil) -- Dexterity
lib:AddRecipe(22545, 27954, nil) -- Surefooted
lib:AddRecipe(22547, 27960, nil) -- Exceptional Stats
lib:AddRecipe(22551, 27968, nil) -- Major Intellect
lib:AddRecipe(22552, 27967, nil) -- Major Striking
lib:AddRecipe(22553, 27972, nil) -- Potency
lib:AddRecipe(22554, 27971, nil) -- Savagery
lib:AddRecipe(22555, 27975, nil) -- Major Spellpower
lib:AddRecipe(22556, 27977, nil) -- Major Agility
lib:AddRecipe(22557, 28004, nil) -- Battlemaster
lib:AddRecipe(22558, 28003, nil) -- Spellsurge
lib:AddRecipe(22559, 27984, nil) -- Mongoose
lib:AddRecipe(22560, 27981, nil) -- Sunfire
lib:AddRecipe(22561, 27982, nil) -- Soulfrost
lib:AddRecipe(22562, 28016, 22521) -- Superior Mana Oil
lib:AddRecipe(22563, 28019, 22522) -- Superior Wizard Oil
lib:AddRecipe(22565, 28022, 22449) -- Large Prismatic Shard
lib:AddRecipe(24000, 27911, nil) -- Superior Healing
lib:AddRecipe(24003, 27960, nil) -- Exceptional Stats
lib:AddRecipe(28270, 33992, nil) -- Major Armor
lib:AddRecipe(28271, 33994, nil) -- Precise Strikes
lib:AddRecipe(28272, 33997, nil) -- Major Spellpower
lib:AddRecipe(28273, 33999, nil) -- Major Healing
lib:AddRecipe(28274, 34003, nil) -- PvP Power
lib:AddRecipe(28279, 34007, nil) -- Cat's Swiftness
lib:AddRecipe(28280, 34008, nil) -- Boar's Speed
lib:AddRecipe(28281, 34010, nil) -- Major Healing
lib:AddRecipe(28282, 34009, nil) -- Major Stamina
lib:AddRecipe(33148, 25086, nil) -- Dodge
lib:AddRecipe(33149, 25083, nil) -- Stealth
lib:AddRecipe(33150, 25084, nil) -- Subtlety
lib:AddRecipe(33151, 25084, nil) -- Subtlety
lib:AddRecipe(33152, 25080, nil) -- Superior Agility
lib:AddRecipe(33153, 25072, nil) -- Threat
lib:AddRecipe(33165, 42620, nil) -- Greater Agility
lib:AddRecipe(33307, 42974, nil) -- Executioner
lib:AddRecipe(34872, 45765, 22449) -- Void Shatter
lib:AddRecipe(35297, 34008, nil) -- Boar's Speed
lib:AddRecipe(35298, 27948, nil) -- Vitality
lib:AddRecipe(35299, 34007, nil) -- Cat's Swiftness
lib:AddRecipe(35498, 46578, nil) -- Deathfrost
lib:AddRecipe(35500, 46594, nil) -- Dodge
lib:AddRecipe(35756, 47051, nil) -- Greater Dodge
lib:AddRecipe(37329, 44510, nil) -- Exceptional Versatility
lib:AddRecipe(37335, 44500, nil) -- Superior Agility
lib:AddRecipe(37337, 44616, nil) -- Greater Stats
lib:AddRecipe(37339, 44621, nil) -- Giant Slayer
lib:AddRecipe(37340, 44588, nil) -- Exceptional Armor
lib:AddRecipe(37343, 44633, nil) -- Exceptional Agility
lib:AddRecipe(37344, 44524, nil) -- Icebreaker
lib:AddRecipe(37346, 44598, nil) -- Haste
lib:AddRecipe(37347, 44591, nil) -- Superior Dodge
lib:AddRecipe(37348, 47898, nil) -- Greater Speed
lib:AddRecipe(37349, 44631, nil) -- Shadow Armor
lib:AddRecipe(38679, 7418, nil) -- Minor Health
lib:AddRecipe(38766, 7420, nil) -- Minor Health
lib:AddRecipe(38767, 7426, nil) -- Minor Absorption
lib:AddRecipe(38768, 7428, nil) -- Minor Dodge
lib:AddRecipe(38771, 7457, nil) -- Minor Stamina
lib:AddRecipe(38772, 7745, nil) -- Minor Impact
lib:AddRecipe(38773, 7748, nil) -- Lesser Health
lib:AddRecipe(38775, 7771, nil) -- Minor Protection
lib:AddRecipe(38777, 7779, nil) -- Minor Agility
lib:AddRecipe(38780, 7788, nil) -- Minor Striking
lib:AddRecipe(38782, 7857, nil) -- Health
lib:AddRecipe(38785, 7863, nil) -- Minor Stamina
lib:AddRecipe(38787, 13378, nil) -- Minor Stamina
lib:AddRecipe(38790, 13421, nil) -- Lesser Protection
lib:AddRecipe(38792, 13485, nil) -- Lesser Versatility
lib:AddRecipe(38793, 13501, nil) -- Lesser Stamina
lib:AddRecipe(38794, 13503, nil) -- Lesser Striking
lib:AddRecipe(38796, 13529, nil) -- Lesser Impact
lib:AddRecipe(38798, 13538, nil) -- Lesser Absorption
lib:AddRecipe(38799, 13607, nil) -- Mana
lib:AddRecipe(38803, 13622, nil) -- Lesser Intellect
lib:AddRecipe(38804, 13626, nil) -- Minor Stats
lib:AddRecipe(38805, 13631, nil) -- Lesser Stamina
lib:AddRecipe(38806, 13635, nil) -- Defense
lib:AddRecipe(38807, 13637, nil) -- Lesser Agility
lib:AddRecipe(38808, 13640, nil) -- Greater Health
lib:AddRecipe(38809, 13642, nil) -- Versatility
lib:AddRecipe(38810, 13644, nil) -- Lesser Stamina
lib:AddRecipe(38812, 13648, nil) -- Stamina
lib:AddRecipe(38816, 13659, nil) -- Versatility
lib:AddRecipe(38817, 13661, nil) -- Strength
lib:AddRecipe(38818, 13663, nil) -- Greater Mana
lib:AddRecipe(38821, 13693, nil) -- Striking
lib:AddRecipe(38822, 13695, nil) -- Impact
lib:AddRecipe(38824, 13700, nil) -- Lesser Stats
lib:AddRecipe(38825, 13746, nil) -- Greater Defense
lib:AddRecipe(38827, 13815, nil) -- Agility
lib:AddRecipe(38829, 13822, nil) -- Intellect
lib:AddRecipe(38830, 13836, nil) -- Stamina
lib:AddRecipe(38833, 13858, nil) -- Superior Health
lib:AddRecipe(38836, 13887, nil) -- Strength
lib:AddRecipe(38837, 13890, nil) -- Minor Speed
lib:AddRecipe(38839, 13905, nil) -- Greater Versatility
lib:AddRecipe(38841, 13917, nil) -- Superior Mana
lib:AddRecipe(38844, 13935, nil) -- Agility
lib:AddRecipe(38845, 13937, nil) -- Greater Impact
lib:AddRecipe(38846, 13939, nil) -- Greater Strength
lib:AddRecipe(38847, 13941, nil) -- Stats
lib:AddRecipe(38848, 13943, nil) -- Greater Striking
lib:AddRecipe(38851, 13948, nil) -- Minor Haste
lib:AddRecipe(38897, 27899, nil) -- Brawn
lib:AddRecipe(38898, 27905, nil) -- Stats
lib:AddRecipe(38904, 27944, nil) -- Lesser Dodge
lib:AddRecipe(38911, 27957, nil) -- Exceptional Health
lib:AddRecipe(38912, 27958, nil) -- Exceptional Mana
lib:AddRecipe(38914, 27961, nil) -- Major Armor
lib:AddRecipe(38928, 33990, nil) -- Major Versatility
lib:AddRecipe(38929, 33991, nil) -- Versatility Prime
lib:AddRecipe(38931, 33993, nil) -- Blasting
lib:AddRecipe(38933, 33995, nil) -- Major Strength
lib:AddRecipe(38934, 33996, nil) -- Assault
lib:AddRecipe(38937, 34001, nil) -- Major Intellect
lib:AddRecipe(38938, 34002, nil) -- Lesser Assault
lib:AddRecipe(38940, 34004, nil) -- Greater Agility
lib:AddRecipe(38949, 44383, nil) -- Armor
lib:AddRecipe(38951, 44484, nil) -- Haste
lib:AddRecipe(38953, 44488, nil) -- Precision
lib:AddRecipe(38954, 44489, nil) -- Dodge
lib:AddRecipe(38955, 44492, nil) -- Mighty Health
lib:AddRecipe(38960, 44506, nil) -- Gatherer
lib:AddRecipe(38961, 44508, nil) -- Greater Versatility
lib:AddRecipe(38962, 44509, nil) -- Greater Versatility
lib:AddRecipe(38964, 44513, nil) -- Greater Assault
lib:AddRecipe(38966, 44528, nil) -- Greater Fortitude
lib:AddRecipe(38967, 44529, nil) -- Major Agility
lib:AddRecipe(38968, 44555, nil) -- Exceptional Intellect
lib:AddRecipe(38971, 60616, nil) -- Assault
lib:AddRecipe(38973, 44582, nil) -- Minor Power
lib:AddRecipe(38974, 44584, nil) -- Greater Vitality
lib:AddRecipe(38976, 44589, nil) -- Superior Agility
lib:AddRecipe(38979, 44592, nil) -- Exceptional Spellpower
lib:AddRecipe(38980, 44593, nil) -- Major Versatility
lib:AddRecipe(38986, 60623, nil) -- Icewalker
lib:AddRecipe(38989, 44623, nil) -- Super Stats
lib:AddRecipe(38991, 44629, nil) -- Exceptional Spellpower
lib:AddRecipe(38992, 44630, nil) -- Greater Savagery
lib:AddRecipe(38997, 44635, nil) -- Greater Spellpower
lib:AddRecipe(39002, 47766, nil) -- Greater Dodge
lib:AddRecipe(39005, 47900, nil) -- Super Health
lib:AddRecipe(44449, 60606, nil) -- Assault
lib:AddRecipe(44453, 60621, nil) -- Greater Potency
lib:AddRecipe(44455, 60653, nil) -- Greater Intellect
lib:AddRecipe(44456, 60609, nil) -- Speed
lib:AddRecipe(44457, 60663, nil) -- Major Agility
lib:AddRecipe(44458, 60668, nil) -- Crusher
lib:AddRecipe(44471, 47672, nil) -- Mighty Stamina
lib:AddRecipe(44472, 47898, nil) -- Greater Speed
lib:AddRecipe(44473, 44595, nil) -- Scourgebane
lib:AddRecipe(44483, 60691, nil) -- Massacre
lib:AddRecipe(44484, 44575, nil) -- Greater Assault
lib:AddRecipe(44485, 44625, nil) -- Armsman
lib:AddRecipe(44486, 60707, nil) -- Superior Potency
lib:AddRecipe(44487, 60714, nil) -- Mighty Spellpower
lib:AddRecipe(44488, 47899, nil) -- Wisdom
lib:AddRecipe(44489, 60692, nil) -- Powerful Stats
lib:AddRecipe(44490, 60763, nil) -- Greater Assault
lib:AddRecipe(44491, 47901, nil) -- Tuskarr's Vitality
lib:AddRecipe(44492, 59621, nil) -- Berserking
lib:AddRecipe(44494, 44576, nil) -- Lifeward
lib:AddRecipe(44495, 59625, nil) -- Black Magic
lib:AddRecipe(44496, 59619, nil) -- Accuracy
lib:AddRecipe(44498, 60767, nil) -- Superior Spellpower
lib:AddRecipe(44944, 62256, nil) -- Major Stamina
lib:AddRecipe(45050, 15596, 11811) -- Smoking Heart of the Mountain
lib:AddRecipe(45059, 62948, nil) -- Greater Spellpower
lib:AddRecipe(45060, 62959, nil) -- Spellpower
lib:AddRecipe(45628, 63746, nil) -- Lesser Accuracy
lib:AddRecipe(46027, 64441, nil) -- Blade Ward
lib:AddRecipe(46348, 64579, nil) -- Blood Draining
lib:AddRecipe(50406, 71692, nil) -- Angler
lib:AddRecipe(52687, 74132, nil) -- Mastery
lib:AddRecipe(52733, 74242, nil) -- Power Torrent
lib:AddRecipe(52735, 74244, nil) -- Windwalk
lib:AddRecipe(52736, 74246, nil) -- Landslide
lib:AddRecipe(52737, 74247, nil) -- Greater Critical Strike
lib:AddRecipe(52738, 74248, nil) -- Greater Critical Strike
lib:AddRecipe(52739, 74250, nil) -- Peerless Stats
lib:AddRecipe(52740, 74251, nil) -- Greater Stamina
lib:AddRecipe(52743, 74189, nil) -- Earthen Vitality
lib:AddRecipe(52744, 74191, nil) -- Mighty Stats
lib:AddRecipe(52745, 74192, nil) -- Lesser Power
lib:AddRecipe(52746, 74193, nil) -- Speed
lib:AddRecipe(52747, 74195, nil) -- Mending
lib:AddRecipe(52748, 74197, nil) -- Avalanche
lib:AddRecipe(52749, 74198, nil) -- Haste
lib:AddRecipe(52750, 74199, nil) -- Haste
lib:AddRecipe(52751, 74200, nil) -- Stamina
lib:AddRecipe(52752, 74201, nil) -- Critical Strike
lib:AddRecipe(52753, 74202, nil) -- Intellect
lib:AddRecipe(52754, 74207, nil) -- Protection
lib:AddRecipe(52755, 74211, nil) -- Elemental Slayer
lib:AddRecipe(52756, 74212, nil) -- Exceptional Strength
lib:AddRecipe(52757, 74213, nil) -- Major Agility
lib:AddRecipe(52758, 74214, nil) -- Mighty Armor
lib:AddRecipe(52759, 74220, nil) -- Greater Haste
lib:AddRecipe(52760, 74223, nil) -- Hurricane
lib:AddRecipe(52761, 74225, nil) -- Heartsong
lib:AddRecipe(52762, 74226, nil) -- Mastery
lib:AddRecipe(52763, 74229, nil) -- Superior Dodge
lib:AddRecipe(52764, 74230, nil) -- Critical Strike
lib:AddRecipe(52765, 74231, nil) -- Exceptional Versatility
lib:AddRecipe(52766, 74232, nil) -- Precision
lib:AddRecipe(52767, 74234, nil) -- Protection
lib:AddRecipe(52768, 74235, nil) -- Superior Intellect
lib:AddRecipe(52769, 74236, nil) -- Precision
lib:AddRecipe(52770, 74237, nil) -- Exceptional Versatility
lib:AddRecipe(52771, 74238, nil) -- Mastery
lib:AddRecipe(52772, 74239, nil) -- Greater Haste
lib:AddRecipe(52773, 74240, nil) -- Greater Intellect
lib:AddRecipe(64411, 74252, nil) -- Assassin's Step
lib:AddRecipe(64412, 74253, nil) -- Lavawalker
lib:AddRecipe(64413, 74256, nil) -- Greater Speed
lib:AddRecipe(64414, 74255, nil) -- Greater Mastery
lib:AddRecipe(64415, 74254, nil) -- Mighty Strength
lib:AddRecipe(67308, 93841, 67274) -- Enchanted Lantern
lib:AddRecipe(67312, 93843, 67275) -- Magic Lamp
lib:AddRecipe(68134, 95471, nil) -- Mighty Agility
lib:AddRecipe(68787, 96264, nil) -- Agility
lib:AddRecipe(68788, 96261, nil) -- Major Strength
lib:AddRecipe(68789, 96262, nil) -- Mighty Intellect
lib:AddRecipe(71714, 13882, nil) -- Lesser Agility
lib:AddRecipe(72070, 33996, nil) -- Assault
lib:AddRecipe(74700, 104338, nil) -- Mastery
lib:AddRecipe(74701, 104385, nil) -- Major Dodge
lib:AddRecipe(74706, 104392, nil) -- Super Armor
lib:AddRecipe(74707, 104393, nil) -- Mighty Versatility
lib:AddRecipe(74708, 104395, nil) -- Glorious Stats
lib:AddRecipe(74709, 104397, nil) -- Superior Stamina
lib:AddRecipe(74710, 104398, nil) -- Accuracy
lib:AddRecipe(74711, 104401, nil) -- Greater Protection
lib:AddRecipe(74712, 104403, nil) -- Superior Intellect
lib:AddRecipe(74713, 104404, nil) -- Superior Critical Strike
lib:AddRecipe(74715, 104407, nil) -- Greater Haste
lib:AddRecipe(74716, 104408, nil) -- Greater Precision
lib:AddRecipe(74717, 104409, nil) -- Blurred Speed
lib:AddRecipe(74718, 104414, nil) -- Pandaren's Step
lib:AddRecipe(74719, 104416, nil) -- Greater Haste
lib:AddRecipe(74720, 104417, nil) -- Superior Haste
lib:AddRecipe(74721, 104419, nil) -- Super Strength
lib:AddRecipe(74722, 104420, nil) -- Superior Mastery
lib:AddRecipe(74723, 104425, nil) -- Windsong
lib:AddRecipe(74725, 104430, nil) -- Elemental Force
lib:AddRecipe(74727, 104440, nil) -- Colossus
lib:AddRecipe(74729, 104445, nil) -- Major Intellect
lib:AddRecipe(78343, 13617, nil) -- Herbalism
lib:AddRecipe(78348, 42974, nil) -- Executioner
lib:AddRecipe(84557, 104391, nil) -- Greater Agility
lib:AddRecipe(84559, 104389, nil) -- Super Intellect
lib:AddRecipe(84561, 104390, nil) -- Exceptional Strength
lib:AddRecipe(84580, 104442, nil) -- River's Song
lib:AddRecipe(84583, 104427, nil) -- Jade Spirit
lib:AddRecipe(84584, 104434, nil) -- Dancing Steel
lib:AddRecipe(89737, 130758, nil) -- Greater Parry
lib:AddRecipe(110617, 158907, nil) -- Breath of Critical Strike
lib:AddRecipe(110618, 158908, nil) -- Breath of Haste
lib:AddRecipe(110619, 158909, nil) -- Breath of Mastery
lib:AddRecipe(110621, 158911, nil) -- Breath of Versatility
lib:AddRecipe(112093, 159236, nil) -- Mark of the Shattered Hand
lib:AddRecipe(118161, 173716, nil) -- Illusion: Agility
lib:AddRecipe(118162, 173717, nil) -- Illusion: Battlemaster
lib:AddRecipe(118163, 173718, nil) -- Illusion: Berserking
lib:AddRecipe(118164, 173719, nil) -- Illusion: Greater Spellpower
lib:AddRecipe(118165, 173720, nil) -- Illusion: Crusader
lib:AddRecipe(118166, 173721, nil) -- Illusion: Elemental Force
lib:AddRecipe(118167, 173722, nil) -- Illusion: Executioner
lib:AddRecipe(118168, 173723, nil) -- Illusion: Fiery Weapon
lib:AddRecipe(118169, 173724, nil) -- Illusion: Hidden
lib:AddRecipe(118170, 173725, nil) -- Illusion: Landslide
lib:AddRecipe(118171, 173726, nil) -- Illusion: Lifestealing
lib:AddRecipe(118172, 173727, nil) -- Illusion: Mongoose
lib:AddRecipe(118173, 173728, nil) -- Illusion: Poisoned
lib:AddRecipe(118174, 173729, nil) -- Illusion: Power Torrent
lib:AddRecipe(118175, 173730, nil) -- Illusion: Spellsurge
lib:AddRecipe(118176, 173731, nil) -- Illusion: Striking
lib:AddRecipe(118177, 173732, nil) -- Illusion: Unholy
lib:AddRecipe(118394, 158877, nil) -- Breath of Critical Strike
lib:AddRecipe(118429, 158878, nil) -- Breath of Haste
lib:AddRecipe(118430, 158879, nil) -- Breath of Mastery
lib:AddRecipe(118432, 158881, nil) -- Breath of Versatility
lib:AddRecipe(118433, 158884, nil) -- Gift of Critical Strike
lib:AddRecipe(118434, 158885, nil) -- Gift of Haste
lib:AddRecipe(118435, 158886, nil) -- Gift of Mastery
lib:AddRecipe(118437, 158889, nil) -- Gift of Versatility
lib:AddRecipe(118438, 158892, nil) -- Breath of Critical Strike
lib:AddRecipe(118439, 158893, nil) -- Breath of Haste
lib:AddRecipe(118440, 158894, nil) -- Breath of Mastery
lib:AddRecipe(118442, 158896, nil) -- Breath of Versatility
lib:AddRecipe(118443, 158899, nil) -- Gift of Critical Strike
lib:AddRecipe(118444, 158900, nil) -- Gift of Haste
lib:AddRecipe(118445, 158901, nil) -- Gift of Mastery
lib:AddRecipe(118447, 158903, nil) -- Gift of Versatility
lib:AddRecipe(118453, 158914, nil) -- Gift of Critical Strike
lib:AddRecipe(118454, 158915, nil) -- Gift of Haste
lib:AddRecipe(118455, 158916, nil) -- Gift of Mastery
lib:AddRecipe(118457, 158918, nil) -- Gift of Versatility
lib:AddRecipe(118458, 159235, nil) -- Mark of the Thunderlord
lib:AddRecipe(118460, 159671, nil) -- Mark of Warsong
lib:AddRecipe(118461, 159672, nil) -- Mark of the Frostwolf
lib:AddRecipe(118462, 159673, nil) -- Mark of Shadowmoon
lib:AddRecipe(118463, 159674, nil) -- Mark of Blackrock
lib:AddRecipe(118467, 173323, nil) -- Mark of Bleeding Hollow
lib:AddRecipe(118526, 174979, nil) -- Illusion: Blood Draining
lib:AddRecipe(118548, 175070, nil) -- Illusion: Jade Spirit
lib:AddRecipe(118549, 175071, nil) -- Illusion: Frostbrand
lib:AddRecipe(118550, 175072, nil) -- Illusion: Flametongue
lib:AddRecipe(118551, 175074, nil) -- Illusion: Windfury
lib:AddRecipe(118552, 175076, nil) -- Illusion: Earthliving
lib:AddRecipe(118553, 175078, nil) -- Illusion: Rockbiter
lib:AddRecipe(118556, 175085, nil) -- Illusion: Mending
lib:AddRecipe(118557, 175086, nil) -- Illusion: River's Song
lib:AddRecipe(120135, 177043, 119293) -- Secrets of Draenor Enchanting
lib:AddRecipe(122711, 182129, 115504) -- Temporal Binding
lib:AddRecipe(128554, 190954, nil) -- Boon of the Scavenger
lib:AddRecipe(128562, 190866, nil) -- Word of Critical Strike
lib:AddRecipe(128563, 190867, nil) -- Word of Haste
lib:AddRecipe(128564, 190868, nil) -- Word of Mastery
lib:AddRecipe(128565, 190869, nil) -- Word of Versatility
lib:AddRecipe(128566, 190870, nil) -- Binding of Critical Strike
lib:AddRecipe(128567, 190871, nil) -- Binding of Haste
lib:AddRecipe(128568, 190872, nil) -- Binding of Mastery
lib:AddRecipe(128569, 190873, nil) -- Binding of Versatility
lib:AddRecipe(128570, 190874, nil) -- Word of Strength
lib:AddRecipe(128571, 190875, nil) -- Word of Agility
lib:AddRecipe(128572, 190876, nil) -- Word of Intellect
lib:AddRecipe(128573, 190877, nil) -- Binding of Strength
lib:AddRecipe(128574, 190878, nil) -- Binding of Agility
lib:AddRecipe(128575, 190879, nil) -- Binding of Intellect
lib:AddRecipe(128576, 190892, nil) -- Mark of the Claw
lib:AddRecipe(128577, 190893, nil) -- Mark of the Distant Army
lib:AddRecipe(128578, 190894, nil) -- Mark of the Hidden Satyr
lib:AddRecipe(128579, 190992, nil) -- Word of Critical Strike
lib:AddRecipe(128580, 190993, nil) -- Word of Haste
lib:AddRecipe(128581, 190994, nil) -- Word of Mastery
lib:AddRecipe(128582, 190995, nil) -- Word of Versatility
lib:AddRecipe(128583, 190996, nil) -- Binding of Critical Strike
lib:AddRecipe(128584, 190997, nil) -- Binding of Haste
lib:AddRecipe(128585, 190998, nil) -- Binding of Mastery
lib:AddRecipe(128586, 190999, nil) -- Binding of Versatility
lib:AddRecipe(128587, 191000, nil) -- Word of Strength
lib:AddRecipe(128588, 191001, nil) -- Word of Agility
lib:AddRecipe(128589, 191002, nil) -- Word of Intellect
lib:AddRecipe(128590, 191003, nil) -- Binding of Strength
lib:AddRecipe(128591, 191004, nil) -- Binding of Agility
lib:AddRecipe(128592, 191005, nil) -- Binding of Intellect
lib:AddRecipe(128593, 191006, nil) -- Mark of the Claw
lib:AddRecipe(128594, 191007, nil) -- Mark of the Distant Army
lib:AddRecipe(128595, 191008, nil) -- Mark of the Hidden Satyr
lib:AddRecipe(128596, 191009, nil) -- Word of Critical Strike
lib:AddRecipe(128597, 191010, nil) -- Word of Haste
lib:AddRecipe(128598, 191011, nil) -- Word of Mastery
lib:AddRecipe(128599, 191012, nil) -- Word of Versatility
lib:AddRecipe(128600, 191013, nil) -- Binding of Critical Strike
lib:AddRecipe(128601, 191014, nil) -- Binding of Haste
lib:AddRecipe(128602, 191015, nil) -- Binding of Mastery
lib:AddRecipe(128603, 191016, nil) -- Binding of Versatility
lib:AddRecipe(128604, 191017, nil) -- Word of Strength
lib:AddRecipe(128605, 191018, nil) -- Word of Agility
lib:AddRecipe(128606, 191019, nil) -- Word of Intellect
lib:AddRecipe(128607, 191020, nil) -- Binding of Strength
lib:AddRecipe(128608, 191021, nil) -- Binding of Agility
lib:AddRecipe(128609, 191022, nil) -- Binding of Intellect
lib:AddRecipe(128610, 191023, nil) -- Mark of the Claw
lib:AddRecipe(128611, 191024, nil) -- Mark of the Distant Army
lib:AddRecipe(128612, 191025, nil) -- Mark of the Hidden Satyr
lib:AddRecipe(128617, 190988, nil) -- Legion Herbalism
lib:AddRecipe(128618, 190989, nil) -- Legion Mining
lib:AddRecipe(128619, 190990, nil) -- Legion Skinning
lib:AddRecipe(128620, 190991, nil) -- Legion Surveying
lib:AddRecipe(128621, 191074, 128533) -- Enchanted Cauldron
lib:AddRecipe(128622, 191075, 128534) -- Enchanted Torch
lib:AddRecipe(128623, 191076, 128535) -- Enchanted Pen
lib:AddRecipe(128625, 191078, 128536) -- Leylight Brazier
lib:AddRecipe(136702, 209507, 136689) -- Soul Fibril
lib:AddRecipe(136704, 209509, 136691) -- Immaculate Fibril
lib:AddRecipe(138877, 217651, 138794) -- Tome of Illusions: Secrets of the Shado-Pan
lib:AddRecipe(138882, 217655, 138795) -- Tome of Illusions: Draenor
lib:AddRecipe(140634, 224199, 124440) -- Ley Shatter
lib:AddRecipe(141911, 228402, nil) -- Mark of the Heavy Hide
lib:AddRecipe(141912, 228405, nil) -- Mark of the Trained Soldier
lib:AddRecipe(141913, 228408, nil) -- Mark of the Ancient Priestess
lib:AddRecipe(141914, 228403, nil) -- Mark of the Heavy Hide
lib:AddRecipe(141915, 228406, nil) -- Mark of the Trained Soldier
lib:AddRecipe(141916, 228409, nil) -- Mark of the Ancient Priestess
lib:AddRecipe(141917, 228404, nil) -- Mark of the Heavy Hide
lib:AddRecipe(141918, 228407, nil) -- Mark of the Trained Soldier
lib:AddRecipe(141919, 228410, nil) -- Mark of the Ancient Priestess
lib:AddRecipe(144308, 235695, nil) -- Mark of the Master
lib:AddRecipe(144309, 235699, nil) -- Mark of the Master
lib:AddRecipe(144310, 235703, nil) -- Mark of the Master
lib:AddRecipe(144311, 235696, nil) -- Mark of the Versatile
lib:AddRecipe(144312, 235700, nil) -- Mark of the Versatile
lib:AddRecipe(144313, 235704, nil) -- Mark of the Versatile
lib:AddRecipe(144314, 235697, nil) -- Mark of the Quick
lib:AddRecipe(144315, 235701, nil) -- Mark of the Quick
lib:AddRecipe(144316, 235705, nil) -- Mark of the Quick
lib:AddRecipe(144317, 235698, nil) -- Mark of the Deadly
lib:AddRecipe(144318, 235702, nil) -- Mark of the Deadly
lib:AddRecipe(144319, 235706, nil) -- Mark of the Deadly
lib:AddRecipe(152658, 252106, 124441) -- Chaos Shatter
lib:AddRecipe(153430, 255035, nil) -- Kul Tiran Herbalism
lib:AddRecipe(153431, 255040, nil) -- Kul Tiran Mining
lib:AddRecipe(153434, 255065, nil) -- Kul Tiran Skinning
lib:AddRecipe(153435, 255066, nil) -- Kul Tiran Surveying
lib:AddRecipe(153436, 255068, nil) -- Swift Hearthing
lib:AddRecipe(153437, 255070, nil) -- Kul Tiran Crafting
lib:AddRecipe(153438, 255071, nil) -- Seal of Critical Strike
lib:AddRecipe(153439, 255072, nil) -- Seal of Haste
lib:AddRecipe(153440, 255073, nil) -- Seal of Mastery
lib:AddRecipe(153441, 255074, nil) -- Seal of Versatility
lib:AddRecipe(153442, 255075, nil) -- Pact of Critical Strike
lib:AddRecipe(153443, 255076, nil) -- Pact of Haste
lib:AddRecipe(153444, 255077, nil) -- Pact of Mastery
lib:AddRecipe(153445, 255078, nil) -- Pact of Versatility
lib:AddRecipe(153476, 255103, nil) -- Coastal Surge
lib:AddRecipe(153478, 255110, nil) -- Siphoning
lib:AddRecipe(153479, 255129, nil) -- Torrent of Elements
lib:AddRecipe(153480, 255141, nil) -- Gale-Force Striking
lib:AddRecipe(159464, 267458, nil) -- Zandalari Herbalism
lib:AddRecipe(159466, 267482, nil) -- Zandalari Mining
lib:AddRecipe(159467, 267486, nil) -- Zandalari Skinning
lib:AddRecipe(159468, 267490, nil) -- Zandalari Surveying
lib:AddRecipe(159469, 267495, nil) -- Swift Hearthing
lib:AddRecipe(159471, 267498, nil) -- Zandalari Crafting
lib:AddRecipe(159785, 268907, nil) -- Deadly Navigation
lib:AddRecipe(159786, 268894, nil) -- Quick Navigation
lib:AddRecipe(159787, 268901, nil) -- Masterful Navigation
lib:AddRecipe(159788, 268852, nil) -- Versatile Navigation
lib:AddRecipe(159789, 268913, nil) -- Stalwart Navigation
lib:AddRecipe(160328, 271366, nil) -- Safe Hearthing
lib:AddRecipe(160330, 271433, nil) -- Cooled Hearthing
lib:AddRecipe(162298, 255094, nil) -- Seal of Critical Strike
lib:AddRecipe(162299, 255095, nil) -- Seal of Haste
lib:AddRecipe(162300, 255096, nil) -- Seal of Mastery
lib:AddRecipe(162301, 255097, nil) -- Seal of Versatility
lib:AddRecipe(162302, 255098, nil) -- Pact of Critical Strike
lib:AddRecipe(162303, 255099, nil) -- Pact of Haste
lib:AddRecipe(162304, 255100, nil) -- Pact of Mastery
lib:AddRecipe(162305, 255101, nil) -- Pact of Versatility
lib:AddRecipe(162306, 265112, 152874) -- Enchanter's Sorcerous Scepter
lib:AddRecipe(162308, 269716, 159922) -- Honorable Combatant's Sorcerous Scepter
lib:AddRecipe(162309, 269719, 159922) -- Honorable Combatant's Sorcerous Scepter
lib:AddRecipe(162312, 268915, nil) -- Stalwart Navigation
lib:AddRecipe(162313, 268909, nil) -- Deadly Navigation
lib:AddRecipe(162314, 268897, nil) -- Quick Navigation
lib:AddRecipe(162315, 255105, nil) -- Coastal Surge
lib:AddRecipe(162316, 255112, nil) -- Siphoning
lib:AddRecipe(162317, 268903, nil) -- Masterful Navigation
lib:AddRecipe(162318, 255143, nil) -- Gale-Force Striking
lib:AddRecipe(162319, 255131, nil) -- Torrent of Elements
lib:AddRecipe(162320, 268879, nil) -- Versatile Navigation
lib:AddRecipe(162716, 255098, nil) -- Pact of Critical Strike
lib:AddRecipe(162717, 255099, nil) -- Pact of Haste
lib:AddRecipe(162718, 255100, nil) -- Pact of Mastery
lib:AddRecipe(162719, 255101, nil) -- Pact of Versatility
lib:AddRecipe(162720, 265112, 152874) -- Enchanter's Sorcerous Scepter
lib:AddRecipe(162721, 268915, nil) -- Stalwart Navigation
lib:AddRecipe(162722, 268909, nil) -- Deadly Navigation
lib:AddRecipe(162723, 255112, nil) -- Siphoning
lib:AddRecipe(162724, 268903, nil) -- Masterful Navigation
lib:AddRecipe(162725, 255143, nil) -- Gale-Force Striking
lib:AddRecipe(162726, 268879, nil) -- Versatile Navigation
lib:AddRecipe(165300, 282855, 164677) -- Sinister Combatant's Sorcerous Scepter
lib:AddRecipe(165301, 282857, 164677) -- Sinister Combatant's Sorcerous Scepter
lib:AddRecipe(165696, 285644, 152878) -- Enchanted Tiki Mask
lib:AddRecipe(168024, 287494, 164766) -- Iwen's Enchanting Rod
lib:AddRecipe(168446, 298009, nil) -- Accord of Critical Strike
lib:AddRecipe(168447, 297989, nil) -- Accord of Haste
lib:AddRecipe(168448, 297995, nil) -- Accord of Mastery
lib:AddRecipe(168449, 297993, nil) -- Accord of Versatility
lib:AddRecipe(168450, 298011, nil) -- Accord of Critical Strike
lib:AddRecipe(168451, 298016, nil) -- Accord of Haste
lib:AddRecipe(168452, 298002, nil) -- Accord of Mastery
lib:AddRecipe(168453, 297999, nil) -- Accord of Versatility
lib:AddRecipe(168592, 298438, nil) -- Oceanic Restoration
lib:AddRecipe(168593, 298433, nil) -- Machinist's Brilliance
lib:AddRecipe(168595, 298439, nil) -- Force Multiplier
lib:AddRecipe(168596, 298440, nil) -- Force Multiplier
lib:AddRecipe(168597, 298441, nil) -- Naga Hide
lib:AddRecipe(168598, 298442, nil) -- Naga Hide
lib:AddRecipe(169530, 298011, nil) -- Accord of Critical Strike
lib:AddRecipe(169531, 298016, nil) -- Accord of Haste
lib:AddRecipe(169532, 298002, nil) -- Accord of Mastery
lib:AddRecipe(169533, 297999, nil) -- Accord of Versatility
lib:AddRecipe(169534, 300770, nil) -- Machinist's Brilliance
lib:AddRecipe(169535, 300788, nil) -- Force Multiplier
lib:AddRecipe(169536, 298515, nil) -- Oceanic Restoration
lib:AddRecipe(169539, 294782, 167993) -- Notorious Combatant's Sorcerous Scepter
lib:AddRecipe(169540, 294783, 167993) -- Notorious Combatant's Sorcerous Scepter
lib:AddRecipe(169604, 298011, nil) -- Accord of Critical Strike
lib:AddRecipe(169605, 298016, nil) -- Accord of Haste
lib:AddRecipe(169606, 298002, nil) -- Accord of Mastery
lib:AddRecipe(169607, 297999, nil) -- Accord of Versatility
lib:AddRecipe(170213, 300789, nil) -- Naga Hide
lib:AddRecipe(171152, 305938, 170312) -- Uncanny Combatant's Sorcerous Scepter
lib:AddRecipe(171153, 305937, 170312) -- Uncanny Combatant's Sorcerous Scepter
lib:AddRecipe(172357, 309612, nil) -- Bargain of Critical Strike
lib:AddRecipe(172358, 309613, nil) -- Bargain of Haste
lib:AddRecipe(172359, 309614, nil) -- Bargain of Mastery
lib:AddRecipe(172360, 309615, nil) -- Bargain of Versatility
lib:AddRecipe(172361, 309616, nil) -- Tenet of Critical Strike
lib:AddRecipe(172362, 309617, nil) -- Tenet of Haste
lib:AddRecipe(172363, 309618, nil) -- Tenet of Mastery
lib:AddRecipe(172364, 309619, nil) -- Tenet of Versatility
lib:AddRecipe(172365, 309622, nil) -- Ascended Vigor
lib:AddRecipe(172366, 309627, nil) -- Celestial Guidance
lib:AddRecipe(172367, 309621, nil) -- Eternal Grace
lib:AddRecipe(172368, 309623, nil) -- Sinful Revelation
lib:AddRecipe(172370, 309620, nil) -- Lightless Force
lib:AddRecipe(172406, 309524, nil) -- Shadowlands Gathering
lib:AddRecipe(172407, 309525, nil) -- Strength of Soul
lib:AddRecipe(172408, 309526, nil) -- Eternal Strength
lib:AddRecipe(172410, 309528, nil) -- Fortified Speed
lib:AddRecipe(172411, 309530, nil) -- Fortified Avoidance
lib:AddRecipe(172412, 309531, nil) -- Fortified Leech
lib:AddRecipe(172413, 309532, nil) -- Agile Soulwalker
lib:AddRecipe(172414, 309608, nil) -- Illuminated Soul
lib:AddRecipe(172415, 309609, nil) -- Eternal Intellect
lib:AddRecipe(172416, 309610, nil) -- Shaded Hearthing
lib:AddRecipe(172418, 309535, nil) -- Eternal Bulwark
lib:AddRecipe(172419, 309534, nil) -- Eternal Agility
lib:AddRecipe(177659, 323760, nil) -- Eternal Skirmish
lib:AddRecipe(177660, 323755, nil) -- Soul Vitality
lib:AddRecipe(177661, 323609, nil) -- Soul Treads
lib:AddRecipe(177715, 323761, nil) -- Eternal Bounds
lib:AddRecipe(177716, 323762, nil) -- Sacred Stats
lib:AddRecipe(177962, 324773, nil) -- Eternal Stats
lib:AddRecipe(182666, 309636, 172437) -- Enchanted Elethium Bar
lib:AddRecipe(183096, 309644, 172230) -- Sacred Shard
lib:AddRecipe(183738, 342316, nil) -- Eternal Insight
lib:AddRecipe(186992, 355184, 186973) -- Anima-ted Leash
lib:AddRecipe(187824, 360007, 187823) -- Magically Regulated Automa Core
lib:AddRecipe(187826, 360013, 187825) -- Cosmic Protoweave
lib:AddRecipe(199802, 389513, nil) -- Draconic Finesse
lib:AddRecipe(199803, 389525, nil) -- Draconic Perception
lib:AddRecipe(199804, 389508, nil) -- Draconic Deftness
lib:AddRecipe(199811, 389403, nil) -- Graceful Avoidance
lib:AddRecipe(199812, 389480, nil) -- Rider's Reassurance
lib:AddRecipe(199813, 389419, nil) -- Sustained Strength
lib:AddRecipe(199814, 389479, nil) -- Plainsrunner's Breeze
lib:AddRecipe(199815, 389404, nil) -- Regenerative Leech
lib:AddRecipe(199816, 389416, nil) -- Accelerated Agility
lib:AddRecipe(199817, 389405, nil) -- Homebound Speed
lib:AddRecipe(199818, 389484, nil) -- Watcher's Loam
lib:AddRecipe(199937, 389301, nil) -- Devotion of Avoidance
lib:AddRecipe(199938, 389303, nil) -- Devotion of Leech
lib:AddRecipe(199939, 389304, nil) -- Devotion of Speed
lib:AddRecipe(199940, 389297, nil) -- Writ of Avoidance
lib:AddRecipe(199941, 389298, nil) -- Writ of Leech
lib:AddRecipe(199942, 389300, nil) -- Writ of Speed
lib:AddRecipe(199944, 389417, nil) -- Reserve of Intellect
lib:AddRecipe(199946, 389410, nil) -- Waking Stats
lib:AddRecipe(199950, 389397, nil) -- Writ of Avoidance
lib:AddRecipe(199951, 389398, nil) -- Writ of Leech
lib:AddRecipe(199952, 389400, nil) -- Writ of Speed
lib:AddRecipe(199953, 389292, nil) -- Devotion of Critical Strike
lib:AddRecipe(199954, 389293, nil) -- Devotion of Haste
lib:AddRecipe(199955, 389294, nil) -- Devotion of Mastery
lib:AddRecipe(199956, 389295, nil) -- Devotion of Versatility
lib:AddRecipe(199957, 388930, nil) -- Writ of Critical Strike
lib:AddRecipe(199958, 389135, nil) -- Writ of Haste
lib:AddRecipe(199959, 389136, nil) -- Writ of Mastery
lib:AddRecipe(199960, 389151, nil) -- Writ of Versatility
lib:AddRecipe(199963, 389519, nil) -- Draconic Inspiration
lib:AddRecipe(199965, 389530, nil) -- Draconic Resourcefulness
lib:AddRecipe(199966, 389547, nil) -- Burning Devotion
lib:AddRecipe(199967, 389537, nil) -- Burning Writ
lib:AddRecipe(199968, 389549, nil) -- Earthen Devotion
lib:AddRecipe(199969, 389540, nil) -- Earthen Writ
lib:AddRecipe(199970, 389550, nil) -- Sophic Devotion
lib:AddRecipe(199971, 389542, nil) -- Sophic Writ
lib:AddRecipe(199972, 389551, nil) -- Frozen Devotion
lib:AddRecipe(199973, 389543, nil) -- Frozen Writ
lib:AddRecipe(199974, 389558, nil) -- Wafting Devotion
lib:AddRecipe(199975, 389546, nil) -- Wafting Writ
lib:AddRecipe(199979, 389301, nil) -- Devotion of Avoidance
lib:AddRecipe(199980, 389303, nil) -- Devotion of Leech
lib:AddRecipe(199981, 389304, nil) -- Devotion of Speed
lib:AddRecipe(199982, 389297, nil) -- Writ of Avoidance
lib:AddRecipe(199983, 389298, nil) -- Writ of Leech
lib:AddRecipe(199984, 389300, nil) -- Writ of Speed
lib:AddRecipe(199986, 389417, nil) -- Reserve of Intellect
lib:AddRecipe(199988, 389410, nil) -- Waking Stats
lib:AddRecipe(199992, 389397, nil) -- Writ of Avoidance
lib:AddRecipe(199993, 389398, nil) -- Writ of Leech
lib:AddRecipe(199994, 389400, nil) -- Writ of Speed
lib:AddRecipe(199995, 389292, nil) -- Devotion of Critical Strike
lib:AddRecipe(199996, 389293, nil) -- Devotion of Haste
lib:AddRecipe(199997, 389294, nil) -- Devotion of Mastery
lib:AddRecipe(199998, 389295, nil) -- Devotion of Versatility
lib:AddRecipe(199999, 388930, nil) -- Writ of Critical Strike
lib:AddRecipe(200000, 389135, nil) -- Writ of Haste
lib:AddRecipe(200001, 389136, nil) -- Writ of Mastery
lib:AddRecipe(200002, 389151, nil) -- Writ of Versatility
lib:AddRecipe(200005, 389519, nil) -- Draconic Inspiration
lib:AddRecipe(200007, 389530, nil) -- Draconic Resourcefulness
lib:AddRecipe(200008, 389547, nil) -- Burning Devotion
lib:AddRecipe(200009, 389537, nil) -- Burning Writ
lib:AddRecipe(200010, 389549, nil) -- Earthen Devotion
lib:AddRecipe(200011, 389540, nil) -- Earthen Writ
lib:AddRecipe(200012, 389550, nil) -- Sophic Devotion
lib:AddRecipe(200013, 389542, nil) -- Sophic Writ
lib:AddRecipe(200014, 389551, nil) -- Frozen Devotion
lib:AddRecipe(200015, 389543, nil) -- Frozen Writ
lib:AddRecipe(200016, 389558, nil) -- Wafting Devotion
lib:AddRecipe(200017, 389546, nil) -- Wafting Writ
lib:AddRecipe(200021, 389301, nil) -- Devotion of Avoidance
lib:AddRecipe(200022, 389303, nil) -- Devotion of Leech
lib:AddRecipe(200023, 389304, nil) -- Devotion of Speed
lib:AddRecipe(200024, 389297, nil) -- Writ of Avoidance
lib:AddRecipe(200025, 389298, nil) -- Writ of Leech
lib:AddRecipe(200026, 389300, nil) -- Writ of Speed
lib:AddRecipe(200028, 389417, nil) -- Reserve of Intellect
lib:AddRecipe(200030, 389410, nil) -- Waking Stats
lib:AddRecipe(200034, 389397, nil) -- Writ of Avoidance
lib:AddRecipe(200035, 389398, nil) -- Writ of Leech
lib:AddRecipe(200036, 389400, nil) -- Writ of Speed
lib:AddRecipe(200037, 389292, nil) -- Devotion of Critical Strike
lib:AddRecipe(200038, 389293, nil) -- Devotion of Haste
lib:AddRecipe(200039, 389294, nil) -- Devotion of Mastery
lib:AddRecipe(200040, 389295, nil) -- Devotion of Versatility
lib:AddRecipe(200041, 388930, nil) -- Writ of Critical Strike
lib:AddRecipe(200042, 389135, nil) -- Writ of Haste
lib:AddRecipe(200043, 389136, nil) -- Writ of Mastery
lib:AddRecipe(200044, 389151, nil) -- Writ of Versatility
lib:AddRecipe(200047, 389519, nil) -- Draconic Inspiration
lib:AddRecipe(200049, 389530, nil) -- Draconic Resourcefulness
lib:AddRecipe(200050, 389547, nil) -- Burning Devotion
lib:AddRecipe(200051, 389537, nil) -- Burning Writ
lib:AddRecipe(200052, 389549, nil) -- Earthen Devotion
lib:AddRecipe(200053, 389540, nil) -- Earthen Writ
lib:AddRecipe(200054, 389550, nil) -- Sophic Devotion
lib:AddRecipe(200055, 389542, nil) -- Sophic Writ
lib:AddRecipe(200056, 389551, nil) -- Frozen Devotion
lib:AddRecipe(200057, 389543, nil) -- Frozen Writ
lib:AddRecipe(200058, 389558, nil) -- Wafting Devotion
lib:AddRecipe(200059, 389546, nil) -- Wafting Writ
lib:AddRecipe(200614, 390951, nil) -- Illusory Adornment: Fire
lib:AddRecipe(200615, 390951, nil) -- Illusory Adornment: Fire
lib:AddRecipe(200616, 390951, nil) -- Illusory Adornment: Fire
lib:AddRecipe(200911, 391813, 200883) -- Illusion: Primal Air
lib:AddRecipe(200912, 391814, 200905) -- Illusion: Primal Earth
lib:AddRecipe(200913, 391815, 200906) -- Illusion: Primal Fire
lib:AddRecipe(200914, 391816, 200907) -- Illusion: Primal Frost
lib:AddRecipe(200916, 390839, 200470) -- Illusion: Primal Mastery
lib:AddRecipe(201310, 391809, nil) -- Illusory Adornment: Frost
lib:AddRecipe(201311, 391809, nil) -- Illusory Adornment: Frost
lib:AddRecipe(201312, 391809, nil) -- Illusory Adornment: Frost
lib:AddRecipe(201313, 391811, nil) -- Illusory Adornment: Earth
lib:AddRecipe(201314, 391811, nil) -- Illusory Adornment: Earth
lib:AddRecipe(201315, 391811, nil) -- Illusory Adornment: Earth
lib:AddRecipe(201316, 391810, nil) -- Illusory Adornment: Air
lib:AddRecipe(201317, 391810, nil) -- Illusory Adornment: Air
lib:AddRecipe(201318, 391810, nil) -- Illusory Adornment: Air
lib:AddRecipe(201319, 391812, nil) -- Illusory Adornment: Order
lib:AddRecipe(201320, 391812, nil) -- Illusory Adornment: Order
lib:AddRecipe(201321, 391812, nil) -- Illusory Adornment: Order
lib:AddRecipe(201361, 391185, 200618) -- Primal Invocation Extract
lib:AddRecipe(203423, 400809, 203410) -- Glowing Crystal Bookmark
lib:AddRecipe(203838, 402139, 203808) -- Mindslave's Reach
lib:AddRecipe(204975, 405076, nil) -- Shadowflame Wreathe
lib:AddRecipe(204976, 405803, 204401) -- Spore Keeper's Baton
lib:AddRecipe(204977, 405650, nil) -- Illusory Adornment: Spores
lib:AddRecipe(204978, 404859, nil) -- Spore Tender
lib:AddRecipe(205337, 405937, 204673) -- Titan Training Matrix V
lib:AddRecipe(205338, 406108, 204681) -- Enchanted Whelpling's Shadowflame Crest
lib:AddRecipe(205339, 406413, 204682) -- Enchanted Wyrm's Shadowflame Crest
lib:AddRecipe(205340, 406418, 204697) -- Enchanted Aspect's Shadowflame Crest
lib:AddRecipe(207569, 416684, 207557) -- Magebane Nexus
lib:AddRecipe(207570, 416685, 207558) -- Smoked Fireshooter
lib:AddRecipe(207571, 416686, 207559) -- Stormwatcher
lib:AddRecipe(210171, 414989, 206961) -- Enchanted Aspect's Dreaming Crest
lib:AddRecipe(210172, 414988, 206960) -- Enchanted Wyrm's Dreaming Crest
lib:AddRecipe(210173, 414985, 206977) -- Enchanted Whelpling's Dreaming Crest
lib:AddRecipe(210174, 414946, nil) -- Illusory Adornment: Dreams
lib:AddRecipe(210175, 416047, nil) -- Dreaming Devotion
-- Engineering
lib:AddRecipe(4408, 3928, 4401) -- Mechanical Squirrel Box
lib:AddRecipe(4409, 3933, 4367) -- Small Seaforium Charge
lib:AddRecipe(4410, 3940, 4373) -- Shadow Goggles
lib:AddRecipe(4411, 3944, 4376) -- Flame Deflector
lib:AddRecipe(4412, 3954, 4383) -- Moonsight Rifle
lib:AddRecipe(4413, 3959, 4388) -- Discombobulator Ray
lib:AddRecipe(4414, 3960, 4403) -- Portable Bronze Mortar
lib:AddRecipe(4415, 3966, 4393) -- Craftsman's Monocle
lib:AddRecipe(4416, 3968, 4395) -- Goblin Land Mine
lib:AddRecipe(4417, 3972, 4398) -- Large Seaforium Charge
lib:AddRecipe(6672, 8243, 4852) -- Flash Bomb
lib:AddRecipe(6716, 8339, 6714) -- EZ-Thro Dynamite
lib:AddRecipe(7560, 9269, 7506) -- Gnomish Universal Remote
lib:AddRecipe(7561, 9273, 7148) -- Goblin Jumper Cables
lib:AddRecipe(7742, 3971, 4397) -- Gnomish Cloaking Device
lib:AddRecipe(10601, 12587, 10499) -- Bright-Eye Goggles
lib:AddRecipe(10602, 12597, 10546) -- Deadly Scope
lib:AddRecipe(10603, 12607, 10501) -- Catseye Ultra Goggles
lib:AddRecipe(10604, 12614, 10510) -- Mithril Heavy-bore Rifle
lib:AddRecipe(10605, 12615, 10502) -- Spellpower Goggles Xtreme
lib:AddRecipe(10606, 12616, 10518) -- Parachute Cloak
lib:AddRecipe(10607, 12617, 10506) -- Deepdive Helmet
lib:AddRecipe(10608, 12620, 10548) -- Sniper Scope
lib:AddRecipe(10609, 12624, 10576) -- Mithril Mechanical Dragonling
lib:AddRecipe(11827, 15633, 11826) -- Lil' Smoky
lib:AddRecipe(11828, 15628, 11825) -- Pet Bombling
lib:AddRecipe(13308, 3957, 4386) -- Ice Deflector
lib:AddRecipe(13309, 3939, 4372) -- Lovingly Crafted Boomstick
lib:AddRecipe(13310, 3979, 4407) -- Accurate Scope
lib:AddRecipe(13311, 3969, 4396) -- Mechanical Dragonling
lib:AddRecipe(14639, 3952, 4381) -- Minor Recombobulator
lib:AddRecipe(16041, 19790, 15993) -- Thorium Grenade
lib:AddRecipe(16042, 19791, 15994) -- Thorium Widget
lib:AddRecipe(16043, 19792, 15995) -- Thorium Rifle
lib:AddRecipe(16044, 19793, 15996) -- Lifelike Mechanical Toad
lib:AddRecipe(16045, 19794, 15999) -- Spellpower Goggles Xtreme Plus
lib:AddRecipe(16046, 19814, 16023) -- Masterwork Target Dummy
lib:AddRecipe(16047, 19795, 16000) -- Thorium Tube
lib:AddRecipe(16048, 19796, 16004) -- Dark Iron Rifle
lib:AddRecipe(16049, 19799, 16005) -- Dark Iron Bomb
lib:AddRecipe(16050, 19815, 16006) -- Delicate Arcanite Converter
lib:AddRecipe(16052, 19819, 16009) -- Voice Amplification Modulator
lib:AddRecipe(16053, 19825, 16008) -- Master Engineer's Goggles
lib:AddRecipe(16054, 19830, 16022) -- Arcanite Dragonling
lib:AddRecipe(16055, 19831, 16040) -- Arcane Bomb
lib:AddRecipe(16056, 19833, 16007) -- Flawless Arcanite Rifle
lib:AddRecipe(17720, 21940, 17716) -- Snowmaster 9000
lib:AddRecipe(18290, 22793, 18283) -- Biznicks 247x128 Accurascope
lib:AddRecipe(18291, 22797, 18168) -- Force Reactive Disk
lib:AddRecipe(18292, 22795, 18282) -- Core Marksman Rifle
lib:AddRecipe(18647, 23066, 9318) -- Red Firework
lib:AddRecipe(18648, 23068, 9313) -- Green Firework
lib:AddRecipe(18649, 23067, 9312) -- Blue Firework
lib:AddRecipe(18650, 23069, 18588) -- EZ-Thro Dynamite II
lib:AddRecipe(18651, 23071, 18631) -- Truesilver Transformer
lib:AddRecipe(18652, 23077, 18634) -- Gyrofreeze Ice Reflector
lib:AddRecipe(18653, 23078, 18587) -- Goblin Jumper Cables XL
lib:AddRecipe(18654, 23096, 18645) -- Gnomish Alarm-o-Bot
lib:AddRecipe(18655, 23079, 18637) -- Major Recombobulator
lib:AddRecipe(18656, 23080, 18594) -- Powerful Seaforium Charge
lib:AddRecipe(18657, 23081, 18638) -- Hyper-Radiant Flame Reflector
lib:AddRecipe(18658, 23082, 18639) -- Ultra-Flash Shadow Reflector
lib:AddRecipe(18661, 23129, 18660) -- World Enlarger
lib:AddRecipe(19027, 23507, 19026) -- Snake Burst Firework
lib:AddRecipe(20000, 24356, 19999) -- Bloodvine Goggles
lib:AddRecipe(20001, 24357, 19998) -- Bloodvine Lens
lib:AddRecipe(21724, 26416, 21558) -- Small Blue Rocket
lib:AddRecipe(21725, 26417, 21559) -- Small Green Rocket
lib:AddRecipe(21726, 26418, 21557) -- Small Red Rocket
lib:AddRecipe(21727, 26420, 21589) -- Large Blue Rocket
lib:AddRecipe(21728, 26421, 21590) -- Large Green Rocket
lib:AddRecipe(21729, 26422, 21592) -- Large Red Rocket
lib:AddRecipe(21730, 26423, 21571) -- Blue Rocket Cluster
lib:AddRecipe(21731, 26424, 21574) -- Green Rocket Cluster
lib:AddRecipe(21732, 26425, 21576) -- Red Rocket Cluster
lib:AddRecipe(21733, 26426, 21714) -- Large Blue Rocket Cluster
lib:AddRecipe(21734, 26427, 21716) -- Large Green Rocket Cluster
lib:AddRecipe(21735, 26428, 21718) -- Large Red Rocket Cluster
lib:AddRecipe(21737, 26443, 21570) -- Cluster Launcher
lib:AddRecipe(21738, 26442, 21569) -- Firework Launcher
lib:AddRecipe(22729, 28327, 22728) -- Steam Tonk Controller
lib:AddRecipe(23799, 30313, 23746) -- Adamantite Rifle
lib:AddRecipe(23800, 30314, 23747) -- Felsteel Boomstick
lib:AddRecipe(23802, 30315, 23748) -- Ornate Khorium Rifle
lib:AddRecipe(23803, 30316, 23758) -- Cogspinner Goggles
lib:AddRecipe(23804, 30317, 23761) -- Power Amplification Goggles
lib:AddRecipe(23805, 30318, 23762) -- Ultra-Spectropic Detection Goggles
lib:AddRecipe(23806, 30325, 23763) -- Hyper-Vision Goggles
lib:AddRecipe(23807, 30329, 23764) -- Adamantite Scope
lib:AddRecipe(23808, 30332, 23765) -- Khorium Scope
lib:AddRecipe(23809, 30334, 23766) -- Stabilized Eternium Scope
lib:AddRecipe(23810, 30337, 23767) -- Crashin' Thrashin' Robot
lib:AddRecipe(23811, 30341, 23768) -- White Smoke Flare
lib:AddRecipe(23814, 30344, 23771) -- Green Smoke Flare
lib:AddRecipe(23816, 30348, 23774) -- Fel Iron Toolbox
lib:AddRecipe(23817, 30349, 23775) -- Titanium Toolbox
lib:AddRecipe(23874, 30547, 23819) -- Elemental Seaforium Charge
lib:AddRecipe(23883, 30551, 33092) -- Healing Potion Injector
lib:AddRecipe(23884, 30552, 33093) -- Mana Potion Injector
lib:AddRecipe(23887, 30556, 23824) -- Rocket Boots Xtreme
lib:AddRecipe(23888, 30548, 23821) -- Zapthrottle Mote Extractor
lib:AddRecipe(25887, 32814, 25886) -- Purple Smoke Flare
lib:AddRecipe(32381, 39895, 7191) -- Fused Wiring
lib:AddRecipe(34114, 44391, 34113) -- Field Repair Bot 110G
lib:AddRecipe(35186, 46111, 34847) -- Annihilator Holo-Gogs
lib:AddRecipe(35187, 46107, 35185) -- Justicebringer 3000 Specs
lib:AddRecipe(35189, 46108, 35181) -- Powerheal 9000 Lens
lib:AddRecipe(35190, 46109, 35182) -- Hyper-Magnified Moon Specs
lib:AddRecipe(35191, 46106, 35183) -- Wonderheal XT68 Shades
lib:AddRecipe(35192, 46110, 35184) -- Primal-Attuned Goggles
lib:AddRecipe(35193, 46112, 34355) -- Lightning Etched Specs
lib:AddRecipe(35194, 46113, 34356) -- Surestrike Goggles v3.0
lib:AddRecipe(35195, 46114, 34354) -- Mayhem Projection Goggles
lib:AddRecipe(35196, 46115, 34357) -- Hard Khorium Goggles
lib:AddRecipe(35197, 46116, 34353) -- Quad Deathblow X44 Goggles
lib:AddRecipe(35310, 30551, 33092) -- Healing Potion Injector
lib:AddRecipe(35311, 30552, 33093) -- Mana Potion Injector
lib:AddRecipe(35582, 46697, 35581) -- Rocket Boots Xtreme Lite
lib:AddRecipe(44502, 60866, 41508) -- Mechano-Hog
lib:AddRecipe(44503, 60867, 44413) -- Mekgineer's Chopper
lib:AddRecipe(44918, 26443, 21570) -- Cluster Launcher
lib:AddRecipe(44919, 26442, 21569) -- Firework Launcher
lib:AddRecipe(49050, 68067, 49040) -- Jeeves
lib:AddRecipe(60223, 82207, nil) -- Explosive Bolts
lib:AddRecipe(70177, 100587, 70139) -- Flintlocke's Woodchucker
lib:AddRecipe(71078, 100687, 71077) -- Extreme-Impact Hole Puncher
lib:AddRecipe(89992, 128262, 87764) -- Serpent's Heart Firework
lib:AddRecipe(89993, 128261, 88491) -- Grand Celebration Firework
lib:AddRecipe(89994, 128260, 88493) -- Celestial Firework
lib:AddRecipe(89996, 131256, 89893) -- Autumn Flower Firework
lib:AddRecipe(89997, 131258, 89888) -- Jade Blossom Firework
lib:AddRecipe(116142, 171072, 116147) -- Alliance Firework
lib:AddRecipe(116144, 171073, 116148) -- Horde Firework
lib:AddRecipe(116146, 171074, 116149) -- Snake Firework
lib:AddRecipe(118476, 162199, 109168) -- Shrediron's Shredder
lib:AddRecipe(118477, 162202, 109120) -- Oglethorpe's Missile Splitter
lib:AddRecipe(118478, 162203, 109122) -- Megawatt Filament
lib:AddRecipe(118480, 162205, 109167) -- Findle's Loot-a-Rang
lib:AddRecipe(118481, 162206, 109183) -- World Shrinker
lib:AddRecipe(118484, 162209, 111402) -- Mechanical Axebeak
lib:AddRecipe(118485, 162210, 112057) -- Lifelike Mechanical Frostboar
lib:AddRecipe(118487, 162214, 108745) -- Personal Hologram
lib:AddRecipe(118488, 162216, 112059) -- Wormhole Centrifuge
lib:AddRecipe(118489, 162217, 111820) -- Swapblaster
lib:AddRecipe(118490, 162218, 111821) -- Blingtron 5000
lib:AddRecipe(118493, 169078, 114056) -- Didi's Delicate Assembly
lib:AddRecipe(118495, 173289, 118008) -- Hemet's Heartseeker
lib:AddRecipe(118497, 162195, 109173) -- Cybergenetic Mechshades
lib:AddRecipe(118498, 162196, 109171) -- Night-Vision Mechshades
lib:AddRecipe(118499, 162197, 109172) -- Plasma Mechshades
lib:AddRecipe(118500, 162198, 109174) -- Razorguard Mechshades
lib:AddRecipe(119177, 176732, 118741) -- Mechanical Scorpid
lib:AddRecipe(120134, 177054, 119299) -- Secrets of Draenor Engineering
lib:AddRecipe(122712, 182120, 111366) -- Primal Welding
lib:AddRecipe(133671, 198968, 132504) -- Semi-Automagic Cranial Cannon
lib:AddRecipe(133672, 198969, 132505) -- Sawed-Off Cranial Cannon
lib:AddRecipe(133673, 198970, 132506) -- Double-Barreled Cranial Cannon
lib:AddRecipe(133674, 198971, 132507) -- Ironsight Cranial Cannon
lib:AddRecipe(136700, 209501, 136687) -- "The Felic"
lib:AddRecipe(136701, 209502, 136688) -- Shockinator
lib:AddRecipe(137691, 198979, 132517) -- Intra-Dalaran Wormhole Generator
lib:AddRecipe(137692, 198980, 132518) -- Blingtron's Circuit Design Tutorial
lib:AddRecipe(137693, 198985, 132526) -- Reaves Module: Failure Detection Mode
lib:AddRecipe(137694, 198984, 132525) -- Reaves Module: Repair Mode
lib:AddRecipe(137695, 198983, 132524) -- Reaves Module: Wormhole Generator Mode
lib:AddRecipe(137697, 198991, 132500) -- Blink-Trigger Headgun
lib:AddRecipe(137698, 198992, 132501) -- Tactical Headgun
lib:AddRecipe(137699, 198993, 132502) -- Bolt-Action Headgun
lib:AddRecipe(137700, 198994, 132503) -- Reinforced Headgun
lib:AddRecipe(137701, 198995, 132504) -- Semi-Automagic Cranial Cannon
lib:AddRecipe(137702, 198996, 132505) -- Sawed-Off Cranial Cannon
lib:AddRecipe(137703, 198997, 132506) -- Double-Barreled Cranial Cannon
lib:AddRecipe(137704, 198998, 132507) -- Ironsight Cranial Cannon
lib:AddRecipe(137705, 198999, 132509) -- Deployable Bullet Dispenser
lib:AddRecipe(137706, 199000, 132510) -- Gunpowder Charge
lib:AddRecipe(137707, 199001, 132511) -- Pump-Action Bandage Gun
lib:AddRecipe(137708, 199002, 132513) -- Gunpack
lib:AddRecipe(137709, 199003, 132514) -- Auto-Hammer
lib:AddRecipe(137710, 199004, 132515) -- Failure Detection Pylon
lib:AddRecipe(137711, 199005, 132500) -- Blink-Trigger Headgun
lib:AddRecipe(137712, 199006, 132501) -- Tactical Headgun
lib:AddRecipe(137713, 199007, 132502) -- Bolt-Action Headgun
lib:AddRecipe(137714, 199008, 132503) -- Reinforced Headgun
lib:AddRecipe(137715, 199009, 132504) -- Semi-Automagic Cranial Cannon
lib:AddRecipe(137716, 199010, 132505) -- Sawed-Off Cranial Cannon
lib:AddRecipe(137717, 199011, 132506) -- Double-Barreled Cranial Cannon
lib:AddRecipe(137718, 199012, 132507) -- Ironsight Cranial Cannon
lib:AddRecipe(137719, 199013, 132509) -- Deployable Bullet Dispenser
lib:AddRecipe(137720, 199014, 132510) -- Gunpowder Charge
lib:AddRecipe(137721, 199015, 132511) -- Pump-Action Bandage Gun
lib:AddRecipe(137722, 199016, 132513) -- Gunpack
lib:AddRecipe(137723, 199017, 132514) -- Auto-Hammer
lib:AddRecipe(137724, 199018, 132515) -- Failure Detection Pylon
lib:AddRecipe(137725, 200466, 132982) -- Sonic Environment Enhancer
lib:AddRecipe(137726, 209645, 136606) -- Leystone Buoy
lib:AddRecipe(137727, 209646, 134125) -- Mecha-Bond Imprint Matrix
lib:AddRecipe(141849, 198989, 132530) -- Reaves Module: Bling Mode
lib:AddRecipe(144335, 235753, 144331) -- Tailored Skullblasters
lib:AddRecipe(144336, 235754, 144332) -- Rugged Skullblasters
lib:AddRecipe(144337, 235755, 144333) -- Chain Skullblasters
lib:AddRecipe(144338, 235756, 144334) -- Heavy Skullblasters
lib:AddRecipe(144343, 235775, 144341) -- Rechargeable Reaves Battery
lib:AddRecipe(151714, 247717, 151651) -- Gravitational Reduction Slippers
lib:AddRecipe(151717, 247744, 151652) -- Wormhole Generator: Argus
lib:AddRecipe(153591, 255936, nil) -- Belt Enchant: Holographic Horror Projector
lib:AddRecipe(153592, 255940, nil) -- Belt Enchant: Personal Space Amplifier
lib:AddRecipe(159829, 269123, nil) -- Belt Enchant: Miniaturized Plasma Shield
lib:AddRecipe(161135, 274621, 161134) -- Mecha-Mogul Mk2
lib:AddRecipe(162321, 265099, 158203) -- Incendiary Ammunition
lib:AddRecipe(162322, 265102, 158377) -- Frost-Laced Ammunition
lib:AddRecipe(162323, 272057, 160488) -- AZ3-R1-T3 Synthetic Specs
lib:AddRecipe(162324, 272058, 160488) -- AZ3-R1-T3 Synthetic Specs
lib:AddRecipe(162325, 272060, 160489) -- AZ3-R1-T3 Gearspun Goggles
lib:AddRecipe(162326, 272061, 160489) -- AZ3-R1-T3 Gearspun Goggles
lib:AddRecipe(162327, 272063, 160490) -- AZ3-R1-T3 Bionic Bifocals
lib:AddRecipe(162328, 272064, 160490) -- AZ3-R1-T3 Bionic Bifocals
lib:AddRecipe(162329, 272066, 160491) -- AZ3-R1-T3 Orthogonal Optics
lib:AddRecipe(162330, 272067, 160491) -- AZ3-R1-T3 Orthogonal Optics
lib:AddRecipe(162331, 255394, 153490) -- F.R.I.E.D.
lib:AddRecipe(162332, 255397, 153494) -- Thermo-Accelerated Plague Spreader
lib:AddRecipe(162337, 255409, 153487) -- Organic Discombobulation Grenade
lib:AddRecipe(162339, 256075, 153512) -- XA-1000 Surface Skimmer
lib:AddRecipe(162340, 256072, 153573) -- Electroshock Mount Motivator
lib:AddRecipe(162341, 256084, 153510) -- Interdimensional Companion Repository
lib:AddRecipe(162342, 256156, 153597) -- Deployable Attire Rearranger
lib:AddRecipe(162343, 264962, 158212) -- Crow's Nest Scope
lib:AddRecipe(162344, 264967, 158327) -- Monelite Scope of Alacrity
lib:AddRecipe(162345, 253152, 152837) -- Precision Attitude Adjuster
lib:AddRecipe(162346, 255459, 153506) -- Finely-Tuned Stormsteel Destroyer
lib:AddRecipe(162727, 265102, 158377) -- Frost-Laced Ammunition
lib:AddRecipe(162728, 272057, 160488) -- AZ3-R1-T3 Synthetic Specs
lib:AddRecipe(162729, 272058, 160488) -- AZ3-R1-T3 Synthetic Specs
lib:AddRecipe(162730, 272060, 160489) -- AZ3-R1-T3 Gearspun Goggles
lib:AddRecipe(162731, 272061, 160489) -- AZ3-R1-T3 Gearspun Goggles
lib:AddRecipe(162732, 272063, 160490) -- AZ3-R1-T3 Bionic Bifocals
lib:AddRecipe(162733, 272064, 160490) -- AZ3-R1-T3 Bionic Bifocals
lib:AddRecipe(162734, 272066, 160491) -- AZ3-R1-T3 Orthogonal Optics
lib:AddRecipe(162735, 272067, 160491) -- AZ3-R1-T3 Orthogonal Optics
lib:AddRecipe(162736, 255397, 153494) -- Thermo-Accelerated Plague Spreader
lib:AddRecipe(162741, 255409, 153487) -- Organic Discombobulation Grenade
lib:AddRecipe(162742, 256084, 153510) -- Interdimensional Companion Repository
lib:AddRecipe(162743, 256156, 153597) -- Deployable Attire Rearranger
lib:AddRecipe(162744, 264967, 158327) -- Monelite Scope of Alacrity
lib:AddRecipe(162745, 253152, 152837) -- Precision Attitude Adjuster
lib:AddRecipe(162746, 255459, 153506) -- Finely-Tuned Stormsteel Destroyer
lib:AddRecipe(163020, 269725, 159937) -- Honorable Combatant's Discombobulator
lib:AddRecipe(163021, 269726, 159937) -- Honorable Combatant's Discombobulator
lib:AddRecipe(163022, 269728, 159936) -- Honorable Combatant's Stormsteel Destroyer
lib:AddRecipe(163023, 269729, 159936) -- Honorable Combatant's Stormsteel Destroyer
lib:AddRecipe(163195, 278411, 165738) -- Makeshift Azerite Detector
lib:AddRecipe(165302, 282807, 164680) -- Sinister Combatant's Discombobulator
lib:AddRecipe(165303, 282808, 164680) -- Sinister Combatant's Discombobulator
lib:AddRecipe(165304, 282810, 164679) -- Sinister Combatant's Stormsteel Destroyer
lib:AddRecipe(165305, 282811, 164679) -- Sinister Combatant's Stormsteel Destroyer
lib:AddRecipe(165844, 286478, 165849) -- Mechantula
lib:AddRecipe(165911, 286865, 165892) -- SP1-R1-73D Bionic Bifocals
lib:AddRecipe(165912, 286866, 165897) -- Charged SP1-R1-73D Bionic Bifocals
lib:AddRecipe(165913, 286868, 165891) -- SP1-R1-73D Gearspun Goggles
lib:AddRecipe(165914, 286869, 165896) -- Charged SP1-R1-73D Gearspun Goggles
lib:AddRecipe(165915, 286871, 165893) -- SP1-R1-73D Orthogonal Optics
lib:AddRecipe(165916, 286872, 165898) -- Charged SP1-R1-73D Orthogonal Optics
lib:AddRecipe(165917, 286874, 165890) -- SP1-R1-73D Synthetic Specs
lib:AddRecipe(165918, 286875, 165895) -- Charged SP1-R1-73D Synthetic Specs
lib:AddRecipe(166276, 283916, 158379) -- Unstable Temporal Time Shifter
lib:AddRecipe(166277, 283915, 158379) -- Unstable Temporal Time Shifter
lib:AddRecipe(166736, 283915, 158379) -- Unstable Temporal Time Shifter
lib:AddRecipe(166987, 291090, 166980) -- Emblazoned Synthetic Specs
lib:AddRecipe(166988, 291092, 166982) -- Emblazoned Gearspun Goggles
lib:AddRecipe(166989, 291094, 166984) -- Emblazoned Bionic Bifocals
lib:AddRecipe(166990, 291096, 166986) -- Emblazoned Orthogonal Optics
lib:AddRecipe(168533, 298255, 168521) -- Ub3r-Module: P.O.G.O.
lib:AddRecipe(168534, 298257, 168522) -- Ub3r-Module: Ub3r-Coil
lib:AddRecipe(168535, 298256, 168523) -- Ub3r-Module: Scrap Cannon
lib:AddRecipe(168660, 298930, 168667) -- Blingtron 7000
lib:AddRecipe(168763, 299005, 168690) -- A5C-3N-D3D Synthetic Specs
lib:AddRecipe(168764, 299006, 168691) -- Charged A5C-3N-D3D Synthetic Specs
lib:AddRecipe(168765, 299008, 168693) -- A5C-3N-D3D Gearspun Goggles
lib:AddRecipe(168766, 299009, 168694) -- Charged A5C-3N-D3D Gearspun Goggles
lib:AddRecipe(168767, 299011, 168696) -- A5C-3N-D3D Bionic Bifocals
lib:AddRecipe(168768, 299012, 168697) -- Charged A5C-3N-D3D Bionic Bifocals
lib:AddRecipe(168769, 299014, 168699) -- A5C-3N-D3D Orthogonal Optics
lib:AddRecipe(168770, 299015, 168700) -- Charged A5C-3N-D3D Orthogonal Optics
lib:AddRecipe(169541, 294785, 167940) -- Notorious Combatant's Discombobulator
lib:AddRecipe(169542, 294786, 167940) -- Notorious Combatant's Discombobulator
lib:AddRecipe(169543, 294788, 167997) -- Notorious Combatant's Stormsteel Destroyer
lib:AddRecipe(169544, 294789, 167997) -- Notorious Combatant's Stormsteel Destroyer
lib:AddRecipe(169609, 256132, 158886) -- Super-Charged Engine
lib:AddRecipe(170404, 305944, 171007) -- Superior Synthetic Specs
lib:AddRecipe(170405, 305943, 171006) -- Paramount Synthetic Specs
lib:AddRecipe(170406, 305941, 171004) -- Superior Gearspun Goggles
lib:AddRecipe(170407, 305940, 171003) -- Paramount Gearspun Goggles
lib:AddRecipe(170408, 305950, 171013) -- Superior Bionic Bifocals
lib:AddRecipe(170409, 305949, 171012) -- Paramount Bionic Bifocals
lib:AddRecipe(170410, 305947, 171010) -- Superior Orthogonal Optics
lib:AddRecipe(170411, 305946, 171009) -- Paramount Orthogonal Optics
lib:AddRecipe(171313, 305942, 171005) -- A-N0M-A-L0U5 Gearspun Goggles
lib:AddRecipe(171314, 305945, 171008) -- A-N0M-A-L0U5 Synthetic Specs
lib:AddRecipe(172917, 255936, nil) -- Belt Enchant: Holographic Horror Projector
lib:AddRecipe(172918, 255936, nil) -- Belt Enchant: Holographic Horror Projector
lib:AddRecipe(172919, 255936, nil) -- Belt Enchant: Holographic Horror Projector
lib:AddRecipe(174271, 305859, 170314) -- Uncanny Combatant's Stormsteel Destroyer
lib:AddRecipe(174272, 305858, 170314) -- Uncanny Combatant's Stormsteel Destroyer
lib:AddRecipe(174273, 305862, 170313) -- Uncanny Combatant's Discombobulator
lib:AddRecipe(174274, 305861, 170313) -- Uncanny Combatant's Discombobulator
lib:AddRecipe(174362, 305951, 171014) -- A-N0M-A-L0U5 Bionic Bifocals
lib:AddRecipe(174364, 305948, 171011) -- A-N0M-A-L0U5 Orthogonal Optics
lib:AddRecipe(183097, 331007, 180208) -- PHA7-YNX
lib:AddRecipe(183858, 310535, 172924) -- Wormhole Generator: Shadowlands
lib:AddRecipe(183867, 343102, 173383) -- Crafter's Mark III
lib:AddRecipe(187116, 84425, nil) -- Cardboard Assassin
lib:AddRecipe(187832, 360088, 187831) -- Pure-Air Sail Extensions
lib:AddRecipe(187837, 360126, 187836) -- Erratic Genesis Matrix
lib:AddRecipe(198781, 382343, 198228) -- Gravitational Displacer
lib:AddRecipe(198782, 382339, 198263) -- Bottomless Mireslush Ore Satchel
lib:AddRecipe(198783, 382340, 194126) -- Spring-Loaded Khaz'gorite Fabric Cutters
lib:AddRecipe(198784, 382322, 198278) -- Primal Deconstruction Charge
lib:AddRecipe(198785, 382332, 193572) -- Quack-E
lib:AddRecipe(199221, 382371, 192443) -- Element-Infused Rocket Helmet
lib:AddRecipe(199222, 382317, 198322) -- Overengineered Sleeve Extenders
lib:AddRecipe(199223, 382318, 198327) -- Needlessly Complex Wristguards
lib:AddRecipe(199224, 382319, 198332) -- Complicated Cuffs
lib:AddRecipe(199225, 382320, 198333) -- Difficult Wrist Protectors
lib:AddRecipe(199226, 382387, 198334) -- P.E.W. x2
lib:AddRecipe(199227, 382321, 198335) -- Ol' Smoky
lib:AddRecipe(199228, 382323, 198292) -- Grease Grenade
lib:AddRecipe(199229, 382324, 198295) -- Tinker: Breath of Neltharion
lib:AddRecipe(199230, 382325, 198313) -- Projectile Propulsion Pinion
lib:AddRecipe(199231, 382326, 198316) -- High Intensity Thermal Scanner
lib:AddRecipe(199232, 382327, 198172) -- Bundle of Fireworks
lib:AddRecipe(199233, 382328, 198275) -- S.A.V.I.O.R.
lib:AddRecipe(199234, 382329, 198226) -- Khaz'gorite Fisherfriend
lib:AddRecipe(199235, 382330, 198239) -- Creature Combustion Canister
lib:AddRecipe(199236, 382331, 198180) -- D.U.C.K.O.Y.
lib:AddRecipe(199238, 382333, 198281) -- Sticky Warp Grenade
lib:AddRecipe(199239, 382334, 198289) -- Tinker: Alarm-O-Turret
lib:AddRecipe(199240, 382335, 198224) -- Green Fireflight
lib:AddRecipe(199241, 382336, 201930) -- H.E.L.P.
lib:AddRecipe(199242, 382338, 198265) -- Portable Alchemist's Lab Bench
lib:AddRecipe(199243, 382337, 198268) -- Portable Tinker's Workbench
lib:AddRecipe(199244, 382341, 198244) -- Khaz'gorite Delver's Helmet
lib:AddRecipe(199245, 382342, 198235) -- Lapidary's Khaz'gorite Clamps
lib:AddRecipe(199246, 382344, 198304) -- Tinker: Grounded Circuitry
lib:AddRecipe(199247, 382346, 198216) -- Haphazardly Tethered Wires
lib:AddRecipe(199248, 382348, 198219) -- Overcharged Overclocker
lib:AddRecipe(199249, 382349, 198259) -- Critical Failure Prevention Unit
lib:AddRecipe(199250, 382350, 198253) -- Calibrated Safety Switch
lib:AddRecipe(199251, 382351, 198256) -- Magazine of Healing Darts
lib:AddRecipe(199252, 382353, 198157) -- I.W.I.N. Button Mk10
lib:AddRecipe(199253, 382354, 198166) -- Suspiciously Ticking Crate
lib:AddRecipe(199254, 382355, 198207) -- EZ-Thro Creature Combustion Canister
lib:AddRecipe(199255, 382356, 198213) -- EZ-Thro Gravitational Displacer
lib:AddRecipe(199256, 382357, 198210) -- EZ-Thro Primal Deconstruction Charge
lib:AddRecipe(199257, 382358, 198169) -- Suspiciously Silent Crate
lib:AddRecipe(199258, 382359, 198301) -- Tinker: Supercollide-O-Tron
lib:AddRecipe(199259, 382361, 198174) -- Razor-Sharp Gear
lib:AddRecipe(199260, 382362, 198231) -- Rapidly Ticking Gear
lib:AddRecipe(199261, 382363, 198236) -- Meticulously-Tuned Gear
lib:AddRecipe(199262, 382364, 198307) -- One-Size-Fits-All Gear
lib:AddRecipe(199263, 382365, 198160) -- Completely Safe Rockets
lib:AddRecipe(199264, 382366, 198163) -- Endless Stack of Needles
lib:AddRecipe(199265, 382367, 198156) -- Wyrmhole Generator: Dragon Isles
lib:AddRecipe(199266, 382368, 198264) -- Centralized Precipitation Emitter
lib:AddRecipe(199267, 382369, 198206) -- Environmental Emulator
lib:AddRecipe(199268, 382370, 198227) -- Giggle Goggles
lib:AddRecipe(199270, 382383, 198328) -- Quality-Assured Optics
lib:AddRecipe(199271, 382384, 198329) -- Milestone Magnifiers
lib:AddRecipe(199272, 382385, 198330) -- Deadline Deadeyes
lib:AddRecipe(199273, 382386, 198331) -- Sentry's Stabilized Specs
lib:AddRecipe(199274, 382388, 198323) -- Lightweight Ocular Lenses
lib:AddRecipe(199275, 382389, 198324) -- Peripheral Vision Projectors
lib:AddRecipe(199276, 382390, 198325) -- Oscillating Wilderness Opticals
lib:AddRecipe(199277, 382391, 198326) -- Battle-Ready Binoculars
lib:AddRecipe(199278, 382392, 198243) -- Draconium Delver's Helmet
lib:AddRecipe(199279, 382393, 198262) -- Bottomless Stonecrust Ore Satchel
lib:AddRecipe(199280, 382394, 198225) -- Draconium Fisherfriend
lib:AddRecipe(199281, 382395, 198234) -- Lapidary's Draconium Clamps
lib:AddRecipe(199282, 382396, 194125) -- Spring-Loaded Draconium Fabric Cutters
lib:AddRecipe(199283, 382397, 198245) -- Draconium Encased Samophlange
lib:AddRecipe(199284, 382398, 198204) -- Draconium Brainwave Amplifier
lib:AddRecipe(199285, 382399, 198246) -- Khaz'gorite Encased Samophlange
lib:AddRecipe(199286, 382400, 198205) -- Khaz'gorite Brainwave Amplifier
lib:AddRecipe(199287, 382401, 198298) -- Tinker: Plane Displacer
lib:AddRecipe(199288, 382402, 198310) -- Gyroscopic Kaleidoscope
lib:AddRecipe(199289, 382403, 198222) -- Blue Fireflight
lib:AddRecipe(199290, 382404, 198223) -- Red Fireflight
lib:AddRecipe(199293, 382407, 198247) -- Neural Silencer Mk3
lib:AddRecipe(199294, 382408, 198173) -- Atomic Recalibrator
lib:AddRecipe(199295, 384313, 198549) -- Black Fireflight
lib:AddRecipe(199296, 384314, 198550) -- Bronze Fireflight
lib:AddRecipe(199297, 384491, 198619) -- Spring-Loaded Capacitor Casing
lib:AddRecipe(199299, 386667, 199188) -- Tinker: Polarity Amplifier
lib:AddRecipe(199300, 386670, 199193) -- EZ-Thro Grease Grenade
lib:AddRecipe(199415, 387246, 199414) -- Zapthrottle Soul Inhaler
lib:AddRecipe(201794, 26011, 21277) -- Tranquil Mechanical Yeti
lib:AddRecipe(202228, 397858, 202212) -- Impressive Linkgrease Locksprocket
lib:AddRecipe(202229, 397859, 202213) -- Remarkable Linkgrease Locksprocket
lib:AddRecipe(202230, 397860, 202214) -- Impressive True Iron Trigger
lib:AddRecipe(202231, 397861, 202215) -- Remarkable True Iron Trigger
lib:AddRecipe(203424, 400810, 203411) -- Gnomish Voicebox
lib:AddRecipe(204844, 407005, 204823) -- Polarity Bomb
lib:AddRecipe(205036, 408052, 205014) -- Tinker: Shadowflame Rockets
lib:AddRecipe(205178, 408230, 204818) -- Mallard Mortar
lib:AddRecipe(205282, 409351, 205278) -- Obsidian Combatant's Cloth Goggles
lib:AddRecipe(205283, 409353, 205279) -- Obsidian Combatant's Leather Goggles
lib:AddRecipe(205284, 409355, 205280) -- Obsidian Combatant's Mail Goggles
lib:AddRecipe(205285, 409356, 205281) -- Obsidian Combatant's Plate Goggles
lib:AddRecipe(206559, 413759, 206512) -- Replaced Servo Arm
lib:AddRecipe(207461, 416149, 207092) -- Portable Party Platter
lib:AddRecipe(207574, 416689, 207562) -- Skullstone Bludgeon
lib:AddRecipe(207576, 416691, 207564) -- Refurbished Purifier
lib:AddRecipe(208317, 419042, 208313) -- Verdant Combatant's Cloth Goggles
lib:AddRecipe(208318, 419043, 208314) -- Verdant Combatant's Leather Goggles
lib:AddRecipe(208319, 419044, 208315) -- Verdant Combatant's Mail Goggles
lib:AddRecipe(208320, 419045, 208316) -- Verdant Combatant's Plate Goggles
-- Inscription
lib:AddRecipe(46108, 64051, 45854) -- Rituals of the New Moon
lib:AddRecipe(65649, 86644, 62239) -- Origami Slime
lib:AddRecipe(65650, 86645, 62238) -- Origami Rock
lib:AddRecipe(65651, 86646, 63246) -- Origami Beetle
lib:AddRecipe(102534, 146638, 102483) -- Crafted Malevolent Gladiator's Medallion of Tenacity
lib:AddRecipe(104219, 148266, 104099) -- Glyph of the Skeleton
lib:AddRecipe(104223, 148270, 104104) -- Glyph of the Unbound Elemental
lib:AddRecipe(104224, 148271, 104105) -- Glyph of Evaporation
lib:AddRecipe(104227, 148274, 104108) -- Glyph of Pillar of Light
lib:AddRecipe(104228, 148275, 149755) -- Glyph of Angels
lib:AddRecipe(104229, 148276, 104120) -- Glyph of the Sha
lib:AddRecipe(104231, 148278, 104122) -- Glyph of Inspired Hymns
lib:AddRecipe(104234, 148281, 104126) -- Glyph of Spirit Raptors
lib:AddRecipe(104235, 148282, 104127) -- Glyph of Lingering Ancestors
lib:AddRecipe(104245, 148292, 104138) -- Glyph of the Weaponmaster
lib:AddRecipe(118605, 166356, 113134) -- Crystalfire Spellstaff
lib:AddRecipe(118606, 163294, 112270) -- Darkmoon Card of Draenor
lib:AddRecipe(118607, 166359, 111526) -- Etched-Blade Warstaff
lib:AddRecipe(118613, 166363, 113270) -- Shadowtome
lib:AddRecipe(118614, 166432, 113289) -- Volatile Crystal
lib:AddRecipe(118615, 165804, 113131) -- Warmaster's Firestick
lib:AddRecipe(120136, 177045, 119297) -- Secrets of Draenor Inscription
lib:AddRecipe(122713, 182125, 112377) -- The Spirit of War
lib:AddRecipe(128409, 190381, 114931) -- Mass Mill Frostweed
lib:AddRecipe(128410, 190382, 114931) -- Mass Mill Fireweed
lib:AddRecipe(128411, 190383, 114931) -- Mass Mill Gorgrond Flytrap
lib:AddRecipe(128412, 190384, 114931) -- Mass Mill Starflower
lib:AddRecipe(128413, 190385, 114931) -- Mass Mill Nagrand Arrowbloom
lib:AddRecipe(128414, 190386, 114931) -- Mass Mill Talador Orchid
lib:AddRecipe(136705, 209510, 136692) -- Aqual Mark
lib:AddRecipe(136706, 209511, 136693) -- Straszan Mark
lib:AddRecipe(137728, 192802, 128980) -- Scroll of Forgotten Knowledge
lib:AddRecipe(137729, 226248, 141333) -- Codex of the Tranquil Mind
lib:AddRecipe(137730, 192838, 129017) -- Glyph of Ghostly Fade
lib:AddRecipe(137731, 192839, 129018) -- Grimoire of the Fel Imp
lib:AddRecipe(137732, 192840, 129019) -- Glyph of Sparkles
lib:AddRecipe(137733, 192841, 139358) -- Glyph of Blackout
lib:AddRecipe(137734, 192842, 129021) -- Glyph of the Sentinel
lib:AddRecipe(137735, 192843, 139338) -- Glyph of Crackling Crane Lightning
lib:AddRecipe(137736, 192844, 137287) -- Glyph of the Spectral Raptor
lib:AddRecipe(137737, 192845, 137269) -- Glyph of Stellar Flare
lib:AddRecipe(137738, 192846, 137293) -- Glyph of the Queen
lib:AddRecipe(137741, 192849, 129028) -- Glyph of Fel Touched Souls
lib:AddRecipe(137742, 192850, 129029) -- Glyph of Crackling Flames
lib:AddRecipe(137743, 192851, 139417) -- Glyph of Fallow Wings
lib:AddRecipe(137744, 192852, 139436) -- Glyph of Tattered Wings
lib:AddRecipe(137745, 192855, 128978) -- Prophecy Tarot
lib:AddRecipe(137746, 192856, 128978) -- Prophecy Tarot
lib:AddRecipe(137747, 192860, 128987) -- Vantus Rune: Ursoc
lib:AddRecipe(137748, 192861, 128988) -- Vantus Rune: Nythendra
lib:AddRecipe(137749, 192862, 128989) -- Vantus Rune: Il'gynoth, The Heart of Corruption
lib:AddRecipe(137750, 192863, 128990) -- Vantus Rune: Dragons of Nightmare
lib:AddRecipe(137751, 192864, 128991) -- Vantus Rune: Xavius
lib:AddRecipe(137752, 192865, 128992) -- Vantus Rune: Elerethe Renferal
lib:AddRecipe(137753, 192866, 128993) -- Vantus Rune: Cenarius
lib:AddRecipe(137754, 192867, 128994) -- Vantus Rune: Skorpyron
lib:AddRecipe(137755, 192868, 128995) -- Vantus Rune: Chronomatic Anomaly
lib:AddRecipe(137756, 192869, 128996) -- Vantus Rune: Trilliax
lib:AddRecipe(137757, 192870, 128997) -- Vantus Rune: Spellblade Aluriel
lib:AddRecipe(137758, 192871, 128998) -- Vantus Rune: Tichondrius
lib:AddRecipe(137759, 192872, 128999) -- Vantus Rune: High Botanist Tel'arn
lib:AddRecipe(137760, 192873, 129000) -- Vantus Rune: Krosus
lib:AddRecipe(137761, 192874, 129001) -- Vantus Rune: Star Augur Etraeus
lib:AddRecipe(137762, 192875, 129002) -- Vantus Rune: Grand Magistrix Elisande
lib:AddRecipe(137763, 192876, 129003) -- Vantus Rune: Gul'dan
lib:AddRecipe(137767, 192891, 128987) -- Vantus Rune: Ursoc
lib:AddRecipe(137768, 192892, 128988) -- Vantus Rune: Nythendra
lib:AddRecipe(137769, 192893, 128989) -- Vantus Rune: Il'gynoth, The Heart of Corruption
lib:AddRecipe(137770, 192894, 128990) -- Vantus Rune: Dragons of Nightmare
lib:AddRecipe(137771, 192895, 128991) -- Vantus Rune: Xavius
lib:AddRecipe(137772, 192896, 128992) -- Vantus Rune: Elerethe Renferal
lib:AddRecipe(137773, 192897, 128993) -- Vantus Rune: Cenarius
lib:AddRecipe(137774, 192898, 128994) -- Vantus Rune: Skorpyron
lib:AddRecipe(137775, 192899, 128995) -- Vantus Rune: Chronomatic Anomaly
lib:AddRecipe(137776, 192900, 128996) -- Vantus Rune: Trilliax
lib:AddRecipe(137777, 192901, 128997) -- Vantus Rune: Spellblade Aluriel
lib:AddRecipe(137778, 192902, 128998) -- Vantus Rune: Tichondrius
lib:AddRecipe(137779, 192903, 128999) -- Vantus Rune: High Botanist Tel'arn
lib:AddRecipe(137780, 192904, 129000) -- Vantus Rune: Krosus
lib:AddRecipe(137781, 192905, 129001) -- Vantus Rune: Star Augur Etraeus
lib:AddRecipe(137782, 192906, 129002) -- Vantus Rune: Grand Magistrix Elisande
lib:AddRecipe(137783, 192907, 129003) -- Vantus Rune: Gul'dan
lib:AddRecipe(137787, 210653, 136852) -- Songs of Battle
lib:AddRecipe(137788, 210654, 136856) -- Songs of Peace
lib:AddRecipe(137789, 210656, 136857) -- Songs of the Legion
lib:AddRecipe(137790, 192859, 128712) -- Darkmoon Card of the Legion
lib:AddRecipe(137791, 192890, 128712) -- Darkmoon Card of the Legion
lib:AddRecipe(139635, 192808, 128987) -- Vantus Rune: Ursoc
lib:AddRecipe(139636, 192809, 128988) -- Vantus Rune: Nythendra
lib:AddRecipe(139637, 192810, 128989) -- Vantus Rune: Il'gynoth, The Heart of Corruption
lib:AddRecipe(139638, 192811, 128990) -- Vantus Rune: Dragons of Nightmare
lib:AddRecipe(139639, 192812, 128991) -- Vantus Rune: Xavius
lib:AddRecipe(139640, 192813, 128992) -- Vantus Rune: Elerethe Renferal
lib:AddRecipe(139641, 192814, 128993) -- Vantus Rune: Cenarius
lib:AddRecipe(139642, 192815, 128994) -- Vantus Rune: Skorpyron
lib:AddRecipe(139643, 192816, 128995) -- Vantus Rune: Chronomatic Anomaly
lib:AddRecipe(139644, 192817, 128996) -- Vantus Rune: Trilliax
lib:AddRecipe(139645, 192818, 128997) -- Vantus Rune: Spellblade Aluriel
lib:AddRecipe(139646, 192819, 128998) -- Vantus Rune: Tichondrius
lib:AddRecipe(139647, 192820, 128999) -- Vantus Rune: High Botanist Tel'arn
lib:AddRecipe(139648, 192821, 129000) -- Vantus Rune: Krosus
lib:AddRecipe(139649, 192822, 129001) -- Vantus Rune: Star Augur Etraeus
lib:AddRecipe(139650, 192823, 129002) -- Vantus Rune: Grand Magistrix Elisande
lib:AddRecipe(139651, 192824, 129003) -- Vantus Rune: Gul'dan
lib:AddRecipe(140037, 222408, 128979) -- Unwritten Legend
lib:AddRecipe(140565, 223940, 140567) -- Songs of the Horde
lib:AddRecipe(140566, 223941, 140568) -- Songs of the Alliance
lib:AddRecipe(141030, 225522, 137274) -- Glyph of Cracked Ice
lib:AddRecipe(141032, 225524, 139271) -- Glyph of the Chilled Shell
lib:AddRecipe(141033, 225525, 139270) -- Glyph of the Crimson Shell
lib:AddRecipe(141035, 225527, 139435) -- Glyph of Fel Wings
lib:AddRecipe(141036, 225528, 139437) -- Glyph of Fel-Enemies
lib:AddRecipe(141037, 225529, 139362) -- Glyph of Mana Touched Souls
lib:AddRecipe(141038, 225530, 139438) -- Glyph of Shadow-Enemies
lib:AddRecipe(141039, 225531, 140630) -- Glyph of the Doe
lib:AddRecipe(141040, 225532, 136825) -- Glyph of the Feral Chameleon
lib:AddRecipe(141041, 225533, 139278) -- Glyph of the Forest Path
lib:AddRecipe(141042, 225534, 136826) -- Glyph of Autumnal Bloom
lib:AddRecipe(141043, 225535, 137249) -- Glyph of Arachnophobia
lib:AddRecipe(141044, 225536, 137250) -- Glyph of Nesingwary's Nemeses
lib:AddRecipe(141046, 225538, 139288) -- Glyph of the Dire Stable
lib:AddRecipe(141047, 225539, 137267) -- Glyph of the Goblin Anti-Grav Flare
lib:AddRecipe(141049, 225541, 137239) -- Glyph of the Hook
lib:AddRecipe(141051, 225543, 137238) -- Glyph of the Trident
lib:AddRecipe(141053, 225545, 139352) -- Glyph of Polymorphic Proportions
lib:AddRecipe(141054, 225546, 139348) -- Glyph of Smolder
lib:AddRecipe(141055, 225547, 139339) -- Glyph of Yu'lon's Grace
lib:AddRecipe(141056, 225548, 139442) -- Glyph of Burnout
lib:AddRecipe(141057, 225549, 129020) -- Glyph of Flash Bang
lib:AddRecipe(141058, 225550, 139289) -- Glyph of Critterhex
lib:AddRecipe(141059, 225551, 137289) -- Glyph of Flickering
lib:AddRecipe(141060, 225552, 137288) -- Glyph of Pebbles
lib:AddRecipe(141061, 225553, 139314) -- Grimoire of the Abyssal
lib:AddRecipe(141062, 225554, 137191) -- Glyph of the Inquisitor's Eye
lib:AddRecipe(141064, 225556, 139310) -- Grimoire of the Shivarra
lib:AddRecipe(141066, 225558, 139311) -- Grimoire of the Voidlord
lib:AddRecipe(141067, 225559, 139315) -- Grimoire of the Wrathguard
lib:AddRecipe(141068, 225560, 137188) -- Glyph of the Blazing Savior
lib:AddRecipe(141447, 227043, 141446) -- Tome of the Tranquil Mind
lib:AddRecipe(141591, 227239, 141333) -- Codex of the Tranquil Mind
lib:AddRecipe(141592, 227240, 141333) -- Codex of the Tranquil Mind
lib:AddRecipe(141642, 227561, 141640) -- Tome of the Clear Mind
lib:AddRecipe(141643, 227562, 141641) -- Codex of the Clear Mind
lib:AddRecipe(141900, 228381, 141898) -- Glyph of Falling Thunder
lib:AddRecipe(142104, 229180, 142101) -- Vantus Rune: Odyn
lib:AddRecipe(142105, 229181, 142102) -- Vantus Rune: Guarm
lib:AddRecipe(142106, 229182, 142103) -- Vantus Rune: Helya
lib:AddRecipe(142107, 229183, 142101) -- Vantus Rune: Odyn
lib:AddRecipe(142108, 229184, 142102) -- Vantus Rune: Guarm
lib:AddRecipe(142109, 229185, 142103) -- Vantus Rune: Helya
lib:AddRecipe(142110, 229177, 142101) -- Vantus Rune: Odyn
lib:AddRecipe(142111, 229178, 142102) -- Vantus Rune: Guarm
lib:AddRecipe(142112, 229179, 142103) -- Vantus Rune: Helya
lib:AddRecipe(143615, 232274, 129022) -- Glyph of Crackling Ox Lightning
lib:AddRecipe(143616, 232275, 143588) -- Glyph of the Trusted Steed
lib:AddRecipe(143751, 233278, 143750) -- Glyph of Twilight Bloom
lib:AddRecipe(146411, 238577, 146406) -- Vantus Rune: Tomb of Sargeras
lib:AddRecipe(146412, 238578, 146406) -- Vantus Rune: Tomb of Sargeras
lib:AddRecipe(146413, 238579, 146406) -- Vantus Rune: Tomb of Sargeras
lib:AddRecipe(147120, 240272, 147119) -- Grimoire of the Shadow Succubus
lib:AddRecipe(151539, 246982, 151538) -- Glyph of Ember Shards
lib:AddRecipe(151541, 246984, 151540) -- Glyph of Floating Shards
lib:AddRecipe(151543, 246999, 151542) -- Glyph of Fel-Touched Shards
lib:AddRecipe(151654, 247614, 151610) -- Vantus Rune: Antorus, the Burning Throne
lib:AddRecipe(151655, 247615, 151610) -- Vantus Rune: Antorus, the Burning Throne
lib:AddRecipe(151656, 247616, 151610) -- Vantus Rune: Antorus, the Burning Throne
lib:AddRecipe(152725, 247861, 129034) -- Mass Mill Astral Glory
lib:AddRecipe(153032, 254227, 153031) -- Glyph of the Lightspawn
lib:AddRecipe(153034, 254231, 153033) -- Glyph of the Voidling
lib:AddRecipe(153037, 254238, 153036) -- Glyph of Dark Absolution
lib:AddRecipe(162023, 276059, 162022) -- Glyph of the Dolphin
lib:AddRecipe(162028, 276088, 162027) -- Glyph of the Tideskipper
lib:AddRecipe(162030, 276121, 162029) -- Glyph of the Humble Flyer
lib:AddRecipe(162121, 256303, 153673) -- Vantus Rune: Uldir
lib:AddRecipe(162124, 256304, 153673) -- Vantus Rune: Uldir
lib:AddRecipe(162125, 256305, 153673) -- Vantus Rune: Uldir
lib:AddRecipe(162352, 256249, 153643) -- Inscribed Vessel of Mysticism
lib:AddRecipe(162353, 269741, 159940) -- Honorable Combatant's Etched Vessel
lib:AddRecipe(162354, 269742, 159940) -- Honorable Combatant's Etched Vessel
lib:AddRecipe(162358, 256234, 153646) -- Codex of the Quiet Mind
lib:AddRecipe(162359, 256276, 153661) -- Contract: Proudmoore Admiralty
lib:AddRecipe(162360, 256277, 153661) -- Contract: Proudmoore Admiralty
lib:AddRecipe(162361, 256279, 153662) -- Contract: Order of Embers
lib:AddRecipe(162362, 256280, 153662) -- Contract: Order of Embers
lib:AddRecipe(162363, 256282, 153663) -- Contract: Storm's Wake
lib:AddRecipe(162364, 256283, 153663) -- Contract: Storm's Wake
lib:AddRecipe(162366, 256286, 153664) -- Contract: Zandalari Empire
lib:AddRecipe(162368, 256289, 153665) -- Contract: Talanji's Expedition
lib:AddRecipe(162370, 256293, 153666) -- Contract: Voldunai
lib:AddRecipe(162371, 256295, 153667) -- Contract: Tortollan Seekers
lib:AddRecipe(162372, 256296, 153667) -- Contract: Tortollan Seekers
lib:AddRecipe(162373, 256298, 153668) -- Contract: Champions of Azeroth
lib:AddRecipe(162374, 256299, 153668) -- Contract: Champions of Azeroth
lib:AddRecipe(162376, 256237, 153647) -- Tome of the Quiet Mind
lib:AddRecipe(162377, 256246, 153598) -- Darkmoon Card of War
lib:AddRecipe(162753, 256285, 153664) -- Contract: Zandalari Empire
lib:AddRecipe(162754, 256288, 153665) -- Contract: Talanji's Expedition
lib:AddRecipe(162755, 256291, 153666) -- Contract: Voldunai
lib:AddRecipe(165306, 282804, 164682) -- Sinister Combatant's Etched Vessel
lib:AddRecipe(165307, 282805, 164682) -- Sinister Combatant's Etched Vessel
lib:AddRecipe(165693, 285639, 165692) -- Vantus Rune: Battle of Dazar'alor
lib:AddRecipe(165694, 285640, 165692) -- Vantus Rune: Battle of Dazar'alor
lib:AddRecipe(165695, 285641, 165692) -- Vantus Rune: Battle of Dazar'alor
lib:AddRecipe(165735, 285925, 165733) -- Vantus Rune: Crucible of Storms
lib:AddRecipe(165736, 285926, 165733) -- Vantus Rune: Crucible of Storms
lib:AddRecipe(165737, 285927, 165733) -- Vantus Rune: Crucible of Storms
lib:AddRecipe(166278, 284293, 165016) -- Contract: 7th Legion
lib:AddRecipe(166279, 284294, 165016) -- Contract: 7th Legion
lib:AddRecipe(166310, 284296, 165017) -- Contract: The Honorbound
lib:AddRecipe(166311, 284297, 165017) -- Contract: The Honorbound
lib:AddRecipe(166582, 289313, 166583) -- Glyph of the Tides
lib:AddRecipe(166665, 289356, 166664) -- Glyph of Storm's Wake
lib:AddRecipe(167733, 293801, 167539) -- Glyph of Dalaran Brilliance
lib:AddRecipe(168625, 298625, 168624) -- Vantus Rune: The Eternal Palace
lib:AddRecipe(168626, 298647, 168624) -- Vantus Rune: The Eternal Palace
lib:AddRecipe(168627, 298648, 168624) -- Vantus Rune: The Eternal Palace
lib:AddRecipe(169545, 294791, 167942) -- Notorious Combatant's Etched Vessel
lib:AddRecipe(169546, 294792, 167942) -- Notorious Combatant's Etched Vessel
lib:AddRecipe(169547, 299671, 168960) -- Contract: Rustbolt Resistance
lib:AddRecipe(169548, 299665, 168956) -- Contract: Ankoan
lib:AddRecipe(169549, 299668, 168959) -- Contract: Unshackled
lib:AddRecipe(169696, 302187, 169301) -- Highborne Compendium of Swirling Tides
lib:AddRecipe(169702, 302187, 169301) -- Highborne Compendium of Swirling Tides
lib:AddRecipe(169703, 302187, 169301) -- Highborne Compendium of Swirling Tides
lib:AddRecipe(170163, 304030, 170164) -- Glyph of the Dark Depths
lib:AddRecipe(170166, 304033, 170165) -- Glyph of Steaming Fury
lib:AddRecipe(170169, 304036, 170168) -- Glyph of the Cold Waves
lib:AddRecipe(170175, 304042, 170173) -- Glyph of Dire Bees
lib:AddRecipe(171058, 305954, 170316) -- Uncanny Combatant's Etched Vessel
lib:AddRecipe(171059, 305953, 170316) -- Uncanny Combatant's Etched Vessel
lib:AddRecipe(171200, 306481, 171203) -- Vantus Rune: Ny'alotha, the Waking City
lib:AddRecipe(171201, 306483, 171203) -- Vantus Rune: Ny'alotha, the Waking City
lib:AddRecipe(171202, 306482, 171203) -- Vantus Rune: Ny'alotha, the Waking City
lib:AddRecipe(172009, 299672, 172008) -- Contract: Rajani
lib:AddRecipe(172011, 299673, 172010) -- Contract: Uldum Accord
lib:AddRecipe(172450, 309443, 172449) -- Glyph of Lavish Servings
lib:AddRecipe(173068, 311453, 173067) -- Vantus Rune: Castle Nathria
lib:AddRecipe(180782, 334537, 180755) -- Fae Revel Masque
lib:AddRecipe(183093, 311410, 173053) -- Contract: The Wild Hunt
lib:AddRecipe(183098, 311424, 173048) -- Codex of the Still Mind
lib:AddRecipe(183102, 311412, 173062) -- Contract: Court of Harvesters
lib:AddRecipe(183103, 311409, 173051) -- Contract: The Ascended
lib:AddRecipe(183104, 311411, 175924) -- Contract: The Undying Army
lib:AddRecipe(184095, 344335, 184096) -- Glyph of the Swift Chameleon
lib:AddRecipe(184098, 344340, 184097) -- Glyph of the Aquatic Chameleon
lib:AddRecipe(184099, 344341, 184100) -- Glyph of the Aerial Chameleon
lib:AddRecipe(186671, 354394, 186662) -- Vantus Rune: Sanctum of Domination
lib:AddRecipe(186724, 354000, 186522) -- Contract: Death's Advance
lib:AddRecipe(187797, 359786, 187796) -- Contract: Enlightened Brokers
lib:AddRecipe(187806, 359890, 187805) -- Vantus Rune: Sepulcher of the First Ones
lib:AddRecipe(187883, 360539, 187884) -- Mark of the Twilight Runestag
lib:AddRecipe(187886, 360542, 187887) -- Mark of the Gloomstalker Dredbat
lib:AddRecipe(187930, 360880, 187931) -- Mark of the Regal Dredbat
lib:AddRecipe(187932, 360882, 187933) -- Mark of the Duskwing Raven
lib:AddRecipe(187935, 360885, 187934) -- Mark of the Midnight Runestag
lib:AddRecipe(187937, 360899, 187936) -- Mark of the Sable Ardenmoth
lib:AddRecipe(190379, 367389, 190378) -- Glyph of the Spectral Lupine
lib:AddRecipe(190381, 367393, 190380) -- Glyph of the Spectral Vulpine
lib:AddRecipe(198598, 385197, 197718) -- Scroll of Sales
lib:AddRecipe(198788, 383593, 198506) -- Contract: Dragonscale Expedition
lib:AddRecipe(198874, 383542, 194897) -- Kinetic Pillar of the Isles
lib:AddRecipe(198875, 383541, 194898) -- Illuminating Pillar of the Isles
lib:AddRecipe(198876, 383545, 194894) -- Weathered Explorer's Stave
lib:AddRecipe(198877, 383544, 194892) -- Pioneer's Writhebark Stave
lib:AddRecipe(198878, 383543, 194893) -- Overseer's Writhebark Stave
lib:AddRecipe(198879, 383522, 194697) -- Draconic Treatise on Alchemy
lib:AddRecipe(198880, 383844, 198510) -- Draconic Treatise on Engineering
lib:AddRecipe(198881, 383517, 198454) -- Draconic Treatise on Blacksmithing
lib:AddRecipe(198882, 383512, 194827) -- Bundle O' Cards: Dragon Isles
lib:AddRecipe(198883, 383523, 194702) -- Draconic Treatise on Enchanting
lib:AddRecipe(198884, 383515, 194704) -- Draconic Treatise on Herbalism
lib:AddRecipe(198885, 383759, 194699) -- Draconic Treatise on Inscription
lib:AddRecipe(198886, 383524, 194703) -- Draconic Treatise on Jewelcrafting
lib:AddRecipe(198887, 383519, 194700) -- Draconic Treatise on Leatherworking
lib:AddRecipe(198888, 383516, 194708) -- Draconic Treatise on Mining
lib:AddRecipe(198889, 383520, 194698) -- Draconic Treatise on Tailoring
lib:AddRecipe(198891, 383574, 196981) -- Cliffside Wylderdrake: Conical Head
lib:AddRecipe(198892, 383575, 196988) -- Cliffside Wylderdrake: Red Hair
lib:AddRecipe(198893, 383576, 196980) -- Cliffside Wylderdrake: Triple Head Horns
lib:AddRecipe(198894, 383577, 197117) -- Highland Drake: Black Hair
lib:AddRecipe(198895, 383578, 197108) -- Highland Drake: Spined Head
lib:AddRecipe(198896, 383579, 197154) -- Highland Drake: Spined Neck
lib:AddRecipe(198899, 383580, 197394) -- Renewed Proto-Drake: Predator Pattern
lib:AddRecipe(198901, 383582, 197362) -- Renewed Proto-Drake: Spined Crest
lib:AddRecipe(198902, 383583, 197597) -- Windborne Velocidrake: Black Fur
lib:AddRecipe(198903, 383584, 197592) -- Windborne Velocidrake: Spined Head
lib:AddRecipe(198904, 383585, 197634) -- Windborne Velocidrake: Windswept Pattern
lib:AddRecipe(198905, 383567, 194733) -- Illusion Parchment: Aqua Torrent
lib:AddRecipe(198906, 383570, 194735) -- Illusion Parchment: Arcane Burst
lib:AddRecipe(198907, 383571, 194736) -- Illusion Parchment: Chilling Wind
lib:AddRecipe(198908, 384869, 194732) -- Illusion Parchment: Love Charm
lib:AddRecipe(198909, 383565, 194731) -- Illusion Parchment: Magma Missile
lib:AddRecipe(198910, 383573, 194738) -- Illusion Parchment: Shadow Orb
lib:AddRecipe(198911, 383572, 194737) -- Illusion Parchment: Spell Shield
lib:AddRecipe(198912, 383569, 194734) -- Illusion Parchment: Whirling Breeze
lib:AddRecipe(198913, 383531, 194767) -- Chilled Rune
lib:AddRecipe(198914, 384948, 194829) -- Flourishing Fortune
lib:AddRecipe(198915, 383563, 194829) -- Blazing Fortune
lib:AddRecipe(198916, 384949, 194829) -- Serene Fortune
lib:AddRecipe(198917, 383527, 194821) -- Buzzing Rune
lib:AddRecipe(198918, 383529, 194817) -- Howling Rune
lib:AddRecipe(198919, 383525, 194824) -- Chirping Rune
lib:AddRecipe(198920, 383556, 192552) -- Draconic Missive of the Fireflash
lib:AddRecipe(198921, 383561, 194578) -- Draconic Missive of the Peerless
lib:AddRecipe(198922, 383533, 194871) -- Azurescale Sigil
lib:AddRecipe(198923, 383534, 194869) -- Sagescale Sigil
lib:AddRecipe(198924, 383535, 194868) -- Emberscale Sigil
lib:AddRecipe(198925, 383536, 194870) -- Bronzescale Sigil
lib:AddRecipe(198926, 383538, 198431) -- Jetscale Sigil
lib:AddRecipe(198927, 383562, 194572) -- Draconic Missive of the Quickblade
lib:AddRecipe(198928, 383554, 194569) -- Draconic Missive of the Aurora
lib:AddRecipe(198929, 383560, 194575) -- Draconic Missive of the Harmonious
lib:AddRecipe(198930, 383530, 194862) -- Runed Writhebark
lib:AddRecipe(198931, 383555, 194566) -- Draconic Missive of the Feverflare
lib:AddRecipe(198932, 383791, 194760) -- Burnished Ink
lib:AddRecipe(198933, 383790, 194754) -- Cosmic Ink
lib:AddRecipe(198934, 383786, 194751) -- Blazing Ink
lib:AddRecipe(198935, 383787, 194758) -- Flourishing Ink
lib:AddRecipe(198936, 383788, 194856) -- Serene Ink
lib:AddRecipe(198937, 383591, 198500) -- Contract: Maruuk Centaur
lib:AddRecipe(198938, 383592, 198503) -- Contract: Artisan's Consortium
lib:AddRecipe(198940, 383588, 198494) -- Contract: Iskaara Tuskarr
lib:AddRecipe(198941, 383590, 198497) -- Contract: Valdrakken Accord
lib:AddRecipe(198942, 383549, 191234) -- Alchemist's Sturdy Mixing Rod
lib:AddRecipe(198943, 383550, 191231) -- Alchemist's Brilliant Mixing Rod
lib:AddRecipe(198946, 383551, 191233) -- Chef's Smooth Rolling Pin
lib:AddRecipe(198947, 383552, 191232) -- Chef's Splendid Rolling Pin
lib:AddRecipe(198950, 383547, 194874) -- Scribe's Fastened Quill
lib:AddRecipe(198951, 383548, 194875) -- Scribe's Resplendent Quill
lib:AddRecipe(198952, 383770, 198478) -- Darkmoon Deck Box: Dance
lib:AddRecipe(198953, 383772, 198481) -- Darkmoon Deck Box: Watcher
lib:AddRecipe(198954, 383767, 198477) -- Darkmoon Deck Box: Rime
lib:AddRecipe(198955, 383325, 194872) -- Darkmoon Deck Box: Inferno
lib:AddRecipe(198956, 383546, 198491) -- Vantus Rune: Vault of the Incarnates
lib:AddRecipe(198957, 383540, 194879) -- Crackling Codex of the Isles
lib:AddRecipe(198958, 383539, 194877) -- Core Explorer's Compendium
lib:AddRecipe(200599, 390847, 198534) -- Draconic Missive of Inspiration
lib:AddRecipe(200600, 390848, 200565) -- Draconic Missive of Resourcefulness
lib:AddRecipe(200601, 390849, 200568) -- Draconic Missive of Multicraft
lib:AddRecipe(200602, 390850, 200571) -- Draconic Missive of Crafting Speed
lib:AddRecipe(200603, 390851, 200574) -- Draconic Missive of Finesse
lib:AddRecipe(200604, 390852, 200577) -- Draconic Missive of Perception
lib:AddRecipe(200605, 390853, 200580) -- Draconic Missive of Deftness
lib:AddRecipe(201026, 392944, 201023) -- Draconic Treatise on Skinning
lib:AddRecipe(201734, 391836, 196963) -- Cliffside Wylderdrake: Silver and Blue Armor
lib:AddRecipe(201735, 391834, 197091) -- Highland Drake: Silver and Blue Armor
lib:AddRecipe(201736, 391846, 196968) -- Cliffside Wylderdrake: Steel and Yellow Armor
lib:AddRecipe(201737, 391845, 197096) -- Highland Drake: Steel and Yellow Armor
lib:AddRecipe(201738, 383587, 197352) -- Renewed Proto-Drake: Steel and Yellow Armor
lib:AddRecipe(201739, 391848, 197579) -- Windborne Velocidrake: Steel and Orange Armor
lib:AddRecipe(201741, 383581, 197377) -- Renewed Proto Drake: Bovine Horns
lib:AddRecipe(201742, 383586, 197347) -- Renewed Proto-Drake: Silver and Blue Armor
lib:AddRecipe(201743, 391832, 197578) -- Windborne Velocidrake: Silver and Blue Armor
lib:AddRecipe(202236, 397866, 202220) -- Impressive Weapon Crystal
lib:AddRecipe(202237, 397867, 202221) -- Remarkable Weapon Crystal
lib:AddRecipe(203378, 400026, 203375) -- Crimson Combatant's Medallion
lib:AddRecipe(203379, 400027, 203376) -- Crimson Combatant's Insignia of Alacrity
lib:AddRecipe(203380, 400028, 203377) -- Crimson Combatant's Emblem
lib:AddRecipe(203425, 400811, 203412) -- Arcane Dispelling Rune
lib:AddRecipe(203839, 402140, 203807) -- Gurubashi Hoodoo Stick
lib:AddRecipe(203840, 402141, 203795) -- Judgment of the Gurubashi
lib:AddRecipe(203841, 402142, 203815) -- Gurubashi Ceremonial Staff
lib:AddRecipe(204167, 403166, 204164) -- Obsidian Combatant's Medallion
lib:AddRecipe(204168, 403167, 204165) -- Obsidian Combatant's Insignia of Alacrity
lib:AddRecipe(204169, 403168, 204166) -- Obsidian Combatant's Emblem
lib:AddRecipe(205127, 408218, 203300) -- Winding Slitherdrake: Blue and Silver Armor
lib:AddRecipe(205128, 408220, 203304) -- Winding Slitherdrake: Yellow and Silver Armor
lib:AddRecipe(205129, 408222, 203314) -- Winding Slitherdrake: Curved Chin Horn
lib:AddRecipe(205130, 408221, 203324) -- Winding Slitherdrake: White Hair
lib:AddRecipe(205131, 408223, 203364) -- Winding Slitherdrake: Small Finned Throat
lib:AddRecipe(205132, 408277, 203762) -- Glyph of the Chosen Glaive
lib:AddRecipe(205133, 408273, 203763) -- Glyph of the Heaved Armament
lib:AddRecipe(205134, 408272, 204858) -- Vantus Rune: Aberrus, the Shadowed Crucible
lib:AddRecipe(205135, 408271, 204971) -- Hissing Rune
lib:AddRecipe(205136, 408278, 204991) -- Contract: Loamm Niffen
lib:AddRecipe(206528, 413515, 206481) -- Shifting Sliver
lib:AddRecipe(206532, 413519, 206485) -- Soulscryer
lib:AddRecipe(206548, 413748, 206501) -- Encased Frigid Heart
lib:AddRecipe(207091, 416137, 207088) -- Glyph of the Shath'Yar
lib:AddRecipe(207575, 416690, 207563) -- Wanderer's Guide
lib:AddRecipe(208310, 419039, 208307) -- Verdant Combatant's Medallion
lib:AddRecipe(208311, 419040, 208308) -- Verdant Combatant's Insignia of Alacrity
lib:AddRecipe(208312, 419041, 208309) -- Verdant Combatant's Emblem
lib:AddRecipe(210243, 425263, 210244) -- Contract: Dream Wardens
lib:AddRecipe(210490, 425954, 210247) -- Vantus Rune: Amirdrassil, the Dream's Hope
lib:AddRecipe(210491, 425958, 203311) -- Winding Slitherdrake: Hairy Chin
lib:AddRecipe(210492, 425961, 207761) -- Grotto Netherwing Drake: Chin Tendrils
lib:AddRecipe(210493, 425959, 207773) -- Grotto Netherwing Drake: Spiked Jaw
lib:AddRecipe(211065, 427956, 210735) -- Mark of the Auric Dreamstag
lib:AddRecipe(211399, 429149, 211400) -- Glyph of the Lunar Chameleon
-- Jewelcrafting
lib:AddRecipe(20854, 25339, 20830) -- Amulet of the Moon
lib:AddRecipe(20855, 25323, 20833) -- Wicked Moonstone Ring
lib:AddRecipe(20856, 25320, 20831) -- Heavy Golden Necklace of Battle
lib:AddRecipe(20970, 25610, 20950) -- Pendant of the Agate Shield
lib:AddRecipe(20971, 25612, 20954) -- Heavy Iron Knuckles
lib:AddRecipe(20973, 25617, 20958) -- Blazing Citrine Ring
lib:AddRecipe(20974, 25618, 20966) -- Jade Pendant of Blasting
lib:AddRecipe(20975, 25619, 20959) -- The Jade Eye
lib:AddRecipe(20976, 25622, 20967) -- Citrine Pendant of Golden Healing
lib:AddRecipe(21940, 26873, 21756) -- Figurine - Golden Hare
lib:AddRecipe(21941, 26875, 21758) -- Figurine - Black Pearl Panther
lib:AddRecipe(21942, 26878, 20969) -- Ruby Crown of Restoration
lib:AddRecipe(21943, 26881, 21760) -- Figurine - Truesilver Crab
lib:AddRecipe(21944, 26882, 21763) -- Figurine - Truesilver Boar
lib:AddRecipe(21945, 26887, 21754) -- The Aquamarine Ward
lib:AddRecipe(21947, 26896, 21753) -- Gem Studded Band
lib:AddRecipe(21948, 26897, 21766) -- Opal Necklace of Impact
lib:AddRecipe(21949, 26900, 21769) -- Figurine - Ruby Serpent
lib:AddRecipe(21952, 26906, 21774) -- Emerald Crown of Destruction
lib:AddRecipe(21953, 26909, 21777) -- Figurine - Emerald Owl
lib:AddRecipe(21954, 26910, 21778) -- Ring of Bitter Shadows
lib:AddRecipe(21955, 26912, 21784) -- Figurine - Black Diamond Crab
lib:AddRecipe(21956, 26914, 21789) -- Figurine - Dark Iron Scorpid
lib:AddRecipe(21957, 26915, 21792) -- Necklace of the Diamond Tower
lib:AddRecipe(23131, 28905, 23095) -- Bold Blood Garnet
lib:AddRecipe(23133, 28903, 23094) -- Brilliant Blood Garnet
lib:AddRecipe(23134, 34590, 28595) -- Delicate Blood Garnet
lib:AddRecipe(23135, 28910, 23098) -- Inscribed Flame Spessarite
lib:AddRecipe(23136, 28912, 23099) -- Reckless Flame Spessarite
lib:AddRecipe(23137, 28914, 23100) -- Glinting Shadow Draenite
lib:AddRecipe(23138, 28915, 23101) -- Potent Flame Spessarite
lib:AddRecipe(23140, 28916, 23103) -- Radiant Deep Peridot
lib:AddRecipe(23141, 28917, 23104) -- Jagged Deep Peridot
lib:AddRecipe(23142, 28918, 23105) -- Regal Deep Peridot
lib:AddRecipe(23144, 28925, 23108) -- Timeless Shadow Draenite
lib:AddRecipe(23145, 28927, 23109) -- Purified Shadow Draenite
lib:AddRecipe(23146, 28933, 23110) -- Shifting Shadow Draenite
lib:AddRecipe(23149, 28944, 23114) -- Smooth Golden Draenite
lib:AddRecipe(23150, 28947, 23115) -- Subtle Golden Draenite
lib:AddRecipe(23152, 28950, 23118) -- Solid Azure Moonstone
lib:AddRecipe(23154, 28955, 23120) -- Stormy Azure Moonstone
lib:AddRecipe(23155, 28953, 23119) -- Sparkling Azure Moonstone
lib:AddRecipe(24158, 31053, 24079) -- Khorium Band of Shadows
lib:AddRecipe(24159, 31054, 24080) -- Khorium Band of Frost
lib:AddRecipe(24160, 31055, 24082) -- Khorium Inferno Band
lib:AddRecipe(24161, 31056, 24085) -- Khorium Band of Leaves
lib:AddRecipe(24162, 31057, 24086) -- Arcane Khorium Band
lib:AddRecipe(24163, 31058, 24087) -- Heavy Felsteel Ring
lib:AddRecipe(24164, 31060, 24088) -- Delicate Eternium Ring
lib:AddRecipe(24165, 31061, 24089) -- Blazing Eternium Band
lib:AddRecipe(24166, 31067, 24106) -- Thick Felsteel Necklace
lib:AddRecipe(24167, 31068, 24110) -- Living Ruby Pendant
lib:AddRecipe(24168, 31070, 24114) -- Braided Eternium Chain
lib:AddRecipe(24169, 31071, 24116) -- Eye of the Night
lib:AddRecipe(24170, 31072, 24117) -- Embrace of the Dawn
lib:AddRecipe(24171, 31076, 24121) -- Chain of the Twilight Owl
lib:AddRecipe(24172, 31077, 24122) -- Coronet of Verdant Flame
lib:AddRecipe(24173, 31078, 24123) -- Circlet of Arcane Might
lib:AddRecipe(24174, 31062, 24092) -- Pendant of Frozen Flame
lib:AddRecipe(24175, 31063, 24093) -- Pendant of Thawing
lib:AddRecipe(24176, 31064, 24095) -- Pendant of Withering
lib:AddRecipe(24177, 31065, 24097) -- Pendant of Shadow's End
lib:AddRecipe(24178, 31066, 24098) -- Pendant of the Null Rune
lib:AddRecipe(24179, 31079, 24124) -- Figurine - Felsteel Boar
lib:AddRecipe(24180, 31080, 24125) -- Figurine - Dawnstone Crab
lib:AddRecipe(24181, 31081, 24126) -- Figurine - Living Ruby Serpent
lib:AddRecipe(24182, 31082, 24127) -- Figurine - Talasite Owl
lib:AddRecipe(24183, 31083, 24128) -- Figurine - Nightseye Panther
lib:AddRecipe(24192, 31085, 24028) -- Delicate Living Ruby
lib:AddRecipe(24193, 31084, 24027) -- Bold Living Ruby
lib:AddRecipe(24194, 31085, 24028) -- Delicate Living Ruby
lib:AddRecipe(24196, 31088, 24030) -- Brilliant Living Ruby
lib:AddRecipe(24197, 31090, 24032) -- Subtle Dawnstone
lib:AddRecipe(24198, 31091, 24036) -- Flashing Living Ruby
lib:AddRecipe(24199, 31092, 24033) -- Solid Star of Elune
lib:AddRecipe(24200, 31149, 24035) -- Sparkling Star of Elune
lib:AddRecipe(24201, 31149, 24035) -- Sparkling Star of Elune
lib:AddRecipe(24202, 31095, 24039) -- Stormy Star of Elune
lib:AddRecipe(24203, 31088, 24030) -- Brilliant Living Ruby
lib:AddRecipe(24204, 31097, 24048) -- Smooth Dawnstone
lib:AddRecipe(24205, 31098, 24051) -- Rigid Star of Elune
lib:AddRecipe(24206, 31097, 24048) -- Smooth Dawnstone
lib:AddRecipe(24208, 31101, 24053) -- Mystic Dawnstone
lib:AddRecipe(24209, 31102, 24054) -- Sovereign Nightseye
lib:AddRecipe(24210, 31103, 24055) -- Shifting Nightseye
lib:AddRecipe(24211, 31104, 24056) -- Timeless Nightseye
lib:AddRecipe(24212, 31112, 24065) -- Purified Nightseye
lib:AddRecipe(24213, 31106, 24058) -- Inscribed Noble Topaz
lib:AddRecipe(24214, 31107, 24059) -- Potent Noble Topaz
lib:AddRecipe(24215, 31108, 24060) -- Reckless Noble Topaz
lib:AddRecipe(24216, 31109, 24061) -- Glinting Nightseye
lib:AddRecipe(24217, 46803, 35707) -- Regal Talasite
lib:AddRecipe(24218, 31111, 24066) -- Radiant Talasite
lib:AddRecipe(24219, 31112, 24065) -- Purified Nightseye
lib:AddRecipe(24220, 31113, 24067) -- Jagged Talasite
lib:AddRecipe(25902, 32866, 25896) -- Powerful Earthstorm Diamond
lib:AddRecipe(25903, 32867, 25897) -- Bracing Earthstorm Diamond
lib:AddRecipe(25904, 32870, 25901) -- Insightful Earthstorm Diamond
lib:AddRecipe(25905, 32868, 25898) -- Tenacious Earthstorm Diamond
lib:AddRecipe(25906, 32869, 25899) -- Brutal Earthstorm Diamond
lib:AddRecipe(25907, 32871, 25890) -- Destructive Skyfire Diamond
lib:AddRecipe(25908, 32873, 25894) -- Swift Skyfire Diamond
lib:AddRecipe(25909, 32872, 25893) -- Mystical Skyfire Diamond
lib:AddRecipe(25910, 32874, 25895) -- Enigmatic Skyfire Diamond
lib:AddRecipe(30826, 37855, 30825) -- Ring of Arcane Shielding
lib:AddRecipe(31358, 31080, 24125) -- Figurine - Dawnstone Crab
lib:AddRecipe(31359, 28918, 23105) -- Regal Deep Peridot
lib:AddRecipe(31401, 38503, 31398) -- The Frozen Eye
lib:AddRecipe(31402, 38504, 31399) -- The Natural Ward
lib:AddRecipe(31870, 28948, 23116) -- Rigid Azure Moonstone
lib:AddRecipe(31873, 39466, 31866) -- Veiled Shadow Draenite
lib:AddRecipe(31874, 39467, 31869) -- Deadly Flame Spessarite
lib:AddRecipe(31875, 31098, 24051) -- Rigid Star of Elune
lib:AddRecipe(31876, 31103, 24055) -- Shifting Nightseye
lib:AddRecipe(31877, 31109, 24061) -- Glinting Nightseye
lib:AddRecipe(31878, 39470, 31867) -- Veiled Nightseye
lib:AddRecipe(31879, 39471, 31868) -- Deadly Noble Topaz
lib:AddRecipe(32274, 39705, 32193) -- Bold Crimson Spinel
lib:AddRecipe(32277, 39706, 32194) -- Delicate Crimson Spinel
lib:AddRecipe(32282, 39711, 32196) -- Brilliant Crimson Spinel
lib:AddRecipe(32284, 39713, 32198) -- Subtle Lionseye
lib:AddRecipe(32285, 39714, 32199) -- Flashing Crimson Spinel
lib:AddRecipe(32286, 39715, 32200) -- Solid Empyrean Sapphire
lib:AddRecipe(32287, 39716, 32201) -- Sparkling Empyrean Sapphire
lib:AddRecipe(32289, 39718, 32203) -- Stormy Empyrean Sapphire
lib:AddRecipe(32291, 39720, 32205) -- Smooth Lionseye
lib:AddRecipe(32292, 39721, 32206) -- Rigid Empyrean Sapphire
lib:AddRecipe(32293, 39720, 32205) -- Smooth Lionseye
lib:AddRecipe(32294, 39713, 32198) -- Subtle Lionseye
lib:AddRecipe(32295, 39724, 32209) -- Mystic Lionseye
lib:AddRecipe(32296, 39721, 32206) -- Rigid Empyrean Sapphire
lib:AddRecipe(32297, 39727, 32211) -- Sovereign Shadowsong Amethyst
lib:AddRecipe(32298, 39728, 32212) -- Shifting Shadowsong Amethyst
lib:AddRecipe(32299, 39728, 32212) -- Shifting Shadowsong Amethyst
lib:AddRecipe(32300, 39736, 32220) -- Glinting Shadowsong Amethyst
lib:AddRecipe(32301, 39731, 32215) -- Timeless Shadowsong Amethyst
lib:AddRecipe(32303, 39733, 32217) -- Inscribed Pyrestone
lib:AddRecipe(32304, 39734, 32218) -- Potent Pyrestone
lib:AddRecipe(32305, 47055, 35760) -- Reckless Pyrestone
lib:AddRecipe(32306, 39736, 32220) -- Glinting Shadowsong Amethyst
lib:AddRecipe(32307, 39737, 32221) -- Veiled Shadowsong Amethyst
lib:AddRecipe(32308, 39738, 32222) -- Deadly Pyrestone
lib:AddRecipe(32309, 39739, 32223) -- Regal Seaspray Emerald
lib:AddRecipe(32310, 39740, 32224) -- Radiant Seaspray Emerald
lib:AddRecipe(32311, 39741, 32225) -- Purified Shadowsong Amethyst
lib:AddRecipe(32312, 39742, 32226) -- Jagged Seaspray Emerald
lib:AddRecipe(32411, 39963, 32410) -- Thundering Skyfire Diamond
lib:AddRecipe(33155, 42588, 33134) -- Kailee's Rose
lib:AddRecipe(33156, 42589, 33131) -- Crimson Sun
lib:AddRecipe(33157, 42590, 33135) -- Falling Star
lib:AddRecipe(33158, 42591, 33143) -- Stone of Blades
lib:AddRecipe(33159, 42592, 33140) -- Blood of Amber
lib:AddRecipe(33160, 42593, 33144) -- Facet of Eternity
lib:AddRecipe(33305, 42558, 33133) -- Don Julio's Heart
lib:AddRecipe(33622, 39961, 32409) -- Relentless Earthstorm Diamond
lib:AddRecipe(33783, 43493, 33782) -- Steady Talasite
lib:AddRecipe(34689, 44794, 34220) -- Chaotic Skyfire Diamond
lib:AddRecipe(35198, 46122, 34362) -- Loop of Forged Power
lib:AddRecipe(35199, 46123, 34363) -- Ring of Flowing Life
lib:AddRecipe(35200, 46124, 34361) -- Hard Khorium Band
lib:AddRecipe(35201, 46125, 34359) -- Pendant of Sunfire
lib:AddRecipe(35202, 46126, 34360) -- Amulet of Flowing Life
lib:AddRecipe(35203, 46127, 34358) -- Hard Khorium Choker
lib:AddRecipe(35239, 39731, 32215) -- Timeless Shadowsong Amethyst
lib:AddRecipe(35242, 39728, 32212) -- Shifting Shadowsong Amethyst
lib:AddRecipe(35243, 39727, 32211) -- Sovereign Shadowsong Amethyst
lib:AddRecipe(35244, 39705, 32193) -- Bold Crimson Spinel
lib:AddRecipe(35246, 39706, 32194) -- Delicate Crimson Spinel
lib:AddRecipe(35247, 39714, 32199) -- Flashing Crimson Spinel
lib:AddRecipe(35248, 39711, 32196) -- Brilliant Crimson Spinel
lib:AddRecipe(35249, 39713, 32198) -- Subtle Lionseye
lib:AddRecipe(35251, 39741, 32225) -- Purified Shadowsong Amethyst
lib:AddRecipe(35252, 39739, 32223) -- Regal Seaspray Emerald
lib:AddRecipe(35253, 39742, 32226) -- Jagged Seaspray Emerald
lib:AddRecipe(35254, 39740, 32224) -- Radiant Seaspray Emerald
lib:AddRecipe(35258, 39724, 32209) -- Mystic Lionseye
lib:AddRecipe(35259, 39721, 32206) -- Rigid Empyrean Sapphire
lib:AddRecipe(35260, 39720, 32205) -- Smooth Lionseye
lib:AddRecipe(35263, 39715, 32200) -- Solid Empyrean Sapphire
lib:AddRecipe(35264, 39716, 32201) -- Sparkling Empyrean Sapphire
lib:AddRecipe(35265, 39718, 32203) -- Stormy Empyrean Sapphire
lib:AddRecipe(35266, 39736, 32220) -- Glinting Shadowsong Amethyst
lib:AddRecipe(35267, 39733, 32217) -- Inscribed Pyrestone
lib:AddRecipe(35269, 39734, 32218) -- Potent Pyrestone
lib:AddRecipe(35270, 39737, 32221) -- Veiled Shadowsong Amethyst
lib:AddRecipe(35271, 39738, 32222) -- Deadly Pyrestone
lib:AddRecipe(35304, 31092, 24033) -- Solid Star of Elune
lib:AddRecipe(35305, 31088, 24030) -- Brilliant Living Ruby
lib:AddRecipe(35307, 31098, 24051) -- Rigid Star of Elune
lib:AddRecipe(35322, 46403, 35315) -- Quick Dawnstone
lib:AddRecipe(35323, 31108, 24060) -- Reckless Noble Topaz
lib:AddRecipe(35325, 46405, 35318) -- Forceful Talasite
lib:AddRecipe(35502, 46597, 35501) -- Eternal Earthstorm Diamond
lib:AddRecipe(35505, 46601, 35503) -- Ember Skyfire Diamond
lib:AddRecipe(35695, 46775, 35693) -- Figurine - Empyrean Tortoise
lib:AddRecipe(35696, 46776, 35694) -- Figurine - Khorium Boar
lib:AddRecipe(35697, 46777, 35700) -- Figurine - Crimson Serpent
lib:AddRecipe(35698, 46778, 35702) -- Figurine - Shadowsong Panther
lib:AddRecipe(35699, 46779, 35703) -- Figurine - Seaspray Albatross
lib:AddRecipe(35708, 46803, 35707) -- Regal Talasite
lib:AddRecipe(35762, 47055, 35760) -- Reckless Pyrestone
lib:AddRecipe(35763, 47056, 35761) -- Quick Lionseye
lib:AddRecipe(35764, 47054, 35758) -- Steady Seaspray Emerald
lib:AddRecipe(35765, 47053, 35759) -- Forceful Seaspray Emerald
lib:AddRecipe(35766, 47054, 35758) -- Steady Seaspray Emerald
lib:AddRecipe(35767, 47055, 35760) -- Reckless Pyrestone
lib:AddRecipe(35768, 47056, 35761) -- Quick Lionseye
lib:AddRecipe(35769, 47053, 35759) -- Forceful Seaspray Emerald
lib:AddRecipe(41559, 53857, 39917) -- Mystic Sun Crystal
lib:AddRecipe(41560, 53943, 39932) -- Stormy Chalcedony
lib:AddRecipe(41561, 53885, 39959) -- Reckless Huge Citrine
lib:AddRecipe(41562, 53877, 39952) -- Deadly Huge Citrine
lib:AddRecipe(41563, 53884, 39958) -- Willful Huge Citrine
lib:AddRecipe(41565, 53879, 39954) -- Lucent Huge Citrine
lib:AddRecipe(41566, 53875, 39950) -- Resplendent Huge Citrine
lib:AddRecipe(41567, 53917, 39975) -- Nimble Dark Jade
lib:AddRecipe(41568, 53921, 39979) -- Purified Shadow Crystal
lib:AddRecipe(41569, 53933, 39992) -- Shattered Dark Jade
lib:AddRecipe(41570, 53932, 39991) -- Radiant Dark Jade
lib:AddRecipe(41571, 53924, 39982) -- Turbid Dark Jade
lib:AddRecipe(41572, 53919, 39977) -- Steady Dark Jade
lib:AddRecipe(41574, 53869, 39939) -- Defender's Shadow Crystal
lib:AddRecipe(41575, 53865, 39945) -- Mysterious Shadow Crystal
lib:AddRecipe(41576, 53830, 39996) -- Bold Scarlet Ruby
lib:AddRecipe(41577, 53945, 39997) -- Delicate Scarlet Ruby
lib:AddRecipe(41578, 53949, 40001) -- Flashing Scarlet Ruby
lib:AddRecipe(41579, 53961, 40017) -- Quick Autumn's Glow
lib:AddRecipe(41580, 53958, 40014) -- Rigid Sky Sapphire
lib:AddRecipe(41581, 53954, 40010) -- Sparkling Sky Sapphire
lib:AddRecipe(41582, 53980, 40044) -- Glinting Twilight Opal
lib:AddRecipe(41686, 53984, 40048) -- Potent Monarch Topaz
lib:AddRecipe(41687, 53991, 40055) -- Deft Monarch Topaz
lib:AddRecipe(41688, 53985, 40049) -- Veiled Twilight Opal
lib:AddRecipe(41690, 53987, 40051) -- Reckless Monarch Topaz
lib:AddRecipe(41692, 54011, 40105) -- Energized Forest Emerald
lib:AddRecipe(41693, 54001, 40091) -- Forceful Forest Emerald
lib:AddRecipe(41696, 54009, 40100) -- Lightning Forest Emerald
lib:AddRecipe(41697, 53998, 40089) -- Regal Forest Emerald
lib:AddRecipe(41698, 53997, 40088) -- Nimble Forest Emerald
lib:AddRecipe(41702, 53996, 40086) -- Jagged Forest Emerald
lib:AddRecipe(41704, 55389, 41285) -- Chaotic Skyflare Diamond
lib:AddRecipe(41705, 55384, 41377) -- Shielded Skyflare Diamond
lib:AddRecipe(41706, 55392, 41333) -- Ember Skyflare Diamond
lib:AddRecipe(41707, 55407, 41376) -- Revitalizing Skyflare Diamond
lib:AddRecipe(41708, 55396, 41401) -- Insightful Earthsiege Diamond
lib:AddRecipe(41709, 55404, 41385) -- Invigorating Earthsiege Diamond
lib:AddRecipe(41710, 55400, 41398) -- Relentless Earthsiege Diamond
lib:AddRecipe(41711, 55403, 41382) -- Trenchant Earthsiege Diamond
lib:AddRecipe(41718, 53946, 39998) -- Brilliant Scarlet Ruby
lib:AddRecipe(41719, 53948, 40000) -- Subtle Autumn's Glow
lib:AddRecipe(41720, 53957, 40013) -- Smooth Autumn's Glow
lib:AddRecipe(41721, 53988, 40052) -- Deadly Monarch Topaz
lib:AddRecipe(41722, 53993, 40057) -- Stalwart Monarch Topaz
lib:AddRecipe(41723, 53996, 40086) -- Jagged Forest Emerald
lib:AddRecipe(41724, 54003, 40095) -- Misty Forest Emerald
lib:AddRecipe(41725, 53965, 40025) -- Timeless Twilight Opal
lib:AddRecipe(41726, 53974, 40034) -- Guardian's Twilight Opal
lib:AddRecipe(41727, 53960, 40016) -- Mystic Autumn's Glow
lib:AddRecipe(41728, 53955, 40011) -- Stormy Sky Sapphire
lib:AddRecipe(41730, 53986, 40050) -- Willful Monarch Topaz
lib:AddRecipe(41733, 53981, 40045) -- Lucent Monarch Topaz
lib:AddRecipe(41734, 53978, 40040) -- Resplendent Monarch Topaz
lib:AddRecipe(41735, 54014, 40106) -- Shattered Forest Emerald
lib:AddRecipe(41737, 54005, 40102) -- Turbid Forest Emerald
lib:AddRecipe(41738, 54000, 40090) -- Steady Forest Emerald
lib:AddRecipe(41740, 53968, 40028) -- Mysterious Twilight Opal
lib:AddRecipe(41742, 55393, 41335) -- Enigmatic Skyflare Diamond
lib:AddRecipe(41743, 55387, 41378) -- Forlorn Skyflare Diamond
lib:AddRecipe(41744, 55388, 41379) -- Impassive Skyflare Diamond
lib:AddRecipe(41747, 53963, 40023) -- Shifting Twilight Opal
lib:AddRecipe(41777, 53976, 40038) -- Etched Twilight Opal
lib:AddRecipe(41778, 54023, 40059) -- Resolute Monarch Topaz
lib:AddRecipe(41780, 53977, 40039) -- Champion's Monarch Topaz
lib:AddRecipe(41781, 54003, 40095) -- Misty Forest Emerald
lib:AddRecipe(41782, 54009, 40100) -- Lightning Forest Emerald
lib:AddRecipe(41783, 53966, 40026) -- Purified Twilight Opal
lib:AddRecipe(41784, 53962, 40022) -- Sovereign Twilight Opal
lib:AddRecipe(41786, 55390, 41307) -- Destructive Skyflare Diamond
lib:AddRecipe(41787, 55395, 41400) -- Thundering Skyflare Diamond
lib:AddRecipe(41788, 55405, 41389) -- Beaming Earthsiege Diamond
lib:AddRecipe(41789, 53975, 40037) -- Inscribed Monarch Topaz
lib:AddRecipe(41790, 53951, 40003) -- Precise Scarlet Ruby
lib:AddRecipe(41793, 54019, 40041) -- Fierce Monarch Topaz
lib:AddRecipe(41797, 55401, 41380) -- Austere Earthsiege Diamond
lib:AddRecipe(41798, 55397, 41395) -- Bracing Earthsiege Diamond
lib:AddRecipe(41799, 55398, 41396) -- Eternal Earthsiege Diamond
lib:AddRecipe(41818, 53994, 40058) -- Accurate Twilight Opal
lib:AddRecipe(41819, 54012, 40098) -- Radiant Forest Emerald
lib:AddRecipe(41820, 53972, 40032) -- Defender's Twilight Opal
lib:AddRecipe(42138, 53952, 40008) -- Solid Sky Sapphire
lib:AddRecipe(42298, 56049, 42142) -- Bold Dragon's Eye
lib:AddRecipe(42301, 56052, 42143) -- Delicate Dragon's Eye
lib:AddRecipe(42302, 56056, 42152) -- Flashing Dragon's Eye
lib:AddRecipe(42305, 56079, 42158) -- Mystic Dragon's Eye
lib:AddRecipe(42306, 56081, 42154) -- Precise Dragon's Eye
lib:AddRecipe(42307, 56083, 42150) -- Quick Dragon's Eye
lib:AddRecipe(42308, 56084, 42156) -- Rigid Dragon's Eye
lib:AddRecipe(42309, 56053, 42144) -- Brilliant Dragon's Eye
lib:AddRecipe(42310, 56085, 42149) -- Smooth Dragon's Eye
lib:AddRecipe(42311, 56086, 36767) -- Solid Dragon's Eye
lib:AddRecipe(42312, 56087, 42145) -- Sparkling Dragon's Eye
lib:AddRecipe(42313, 56088, 42155) -- Stormy Dragon's Eye
lib:AddRecipe(42314, 56055, 42151) -- Subtle Dragon's Eye
lib:AddRecipe(42648, 56496, 42642) -- Titanium Impact Band
lib:AddRecipe(42649, 56497, 42643) -- Titanium Earthguard Ring
lib:AddRecipe(42650, 56498, 42644) -- Titanium Spellshock Ring
lib:AddRecipe(42651, 56499, 42645) -- Titanium Impact Choker
lib:AddRecipe(42652, 56500, 42646) -- Titanium Earthguard Chain
lib:AddRecipe(42653, 56501, 42647) -- Titanium Spellshock Necklace
lib:AddRecipe(43317, 58147, 43250) -- Ring of Earthen Might
lib:AddRecipe(43318, 58148, 43251) -- Ring of Scarlet Shadows
lib:AddRecipe(43319, 58149, 43252) -- Windfire Band
lib:AddRecipe(43320, 58150, 43253) -- Ring of Northern Tears
lib:AddRecipe(43485, 58492, 43482) -- Savage Titanium Ring
lib:AddRecipe(43497, 58507, 43498) -- Savage Titanium Band
lib:AddRecipe(43597, 58954, 43582) -- Titanium Frostguard Ring
lib:AddRecipe(46897, 66338, 40167) -- Regal Eye of Zul
lib:AddRecipe(46898, 66428, 40168) -- Steady Eye of Zul
lib:AddRecipe(46899, 66429, 40166) -- Nimble Eye of Zul
lib:AddRecipe(46901, 66431, 40165) -- Jagged Eye of Zul
lib:AddRecipe(46902, 66432, 40164) -- Timeless Dreadstone
lib:AddRecipe(46904, 66434, 40169) -- Forceful Eye of Zul
lib:AddRecipe(46905, 66435, 40171) -- Misty Eye of Zul
lib:AddRecipe(46909, 66439, 40177) -- Lightning Eye of Zul
lib:AddRecipe(46911, 66441, 40180) -- Radiant Eye of Zul
lib:AddRecipe(46912, 66442, 40179) -- Energized Eye of Zul
lib:AddRecipe(46913, 66443, 40182) -- Shattered Eye of Zul
lib:AddRecipe(46915, 66445, 40173) -- Turbid Eye of Zul
lib:AddRecipe(46916, 66446, 40113) -- Brilliant Cardinal Ruby
lib:AddRecipe(46917, 66447, 40111) -- Bold Cardinal Ruby
lib:AddRecipe(46918, 66448, 40112) -- Delicate Cardinal Ruby
lib:AddRecipe(46920, 66450, 40118) -- Precise Cardinal Ruby
lib:AddRecipe(46922, 66452, 40115) -- Subtle King's Amber
lib:AddRecipe(46923, 66453, 40116) -- Flashing Cardinal Ruby
lib:AddRecipe(46924, 66497, 40119) -- Solid Majestic Zircon
lib:AddRecipe(46925, 66498, 40120) -- Sparkling Majestic Zircon
lib:AddRecipe(46926, 66499, 40122) -- Stormy Majestic Zircon
lib:AddRecipe(46928, 66501, 40125) -- Rigid Majestic Zircon
lib:AddRecipe(46929, 66502, 40124) -- Smooth King's Amber
lib:AddRecipe(46932, 66505, 40127) -- Mystic King's Amber
lib:AddRecipe(46933, 66506, 40128) -- Quick King's Amber
lib:AddRecipe(46935, 66554, 40129) -- Sovereign Dreadstone
lib:AddRecipe(46937, 66556, 40133) -- Purified Dreadstone
lib:AddRecipe(46938, 66557, 40130) -- Shifting Dreadstone
lib:AddRecipe(46940, 66338, 40167) -- Regal Eye of Zul
lib:AddRecipe(46941, 66560, 40139) -- Defender's Dreadstone
lib:AddRecipe(46942, 66561, 40141) -- Guardian's Dreadstone
lib:AddRecipe(46943, 66562, 40135) -- Mysterious Dreadstone
lib:AddRecipe(46944, 66431, 40165) -- Jagged Eye of Zul
lib:AddRecipe(46948, 66567, 40142) -- Inscribed Ametrine
lib:AddRecipe(46949, 66568, 40147) -- Deadly Ametrine
lib:AddRecipe(46950, 66569, 40152) -- Potent Ametrine
lib:AddRecipe(46951, 66570, 40153) -- Veiled Dreadstone
lib:AddRecipe(46952, 66571, 40154) -- Willful Ametrine
lib:AddRecipe(46953, 66572, 40143) -- Etched Dreadstone
lib:AddRecipe(46956, 66573, 40157) -- Glinting Dreadstone
lib:AddRecipe(47007, 66574, 40155) -- Reckless Ametrine
lib:AddRecipe(47010, 66576, 40162) -- Accurate Dreadstone
lib:AddRecipe(47015, 66579, 40144) -- Champion's Ametrine
lib:AddRecipe(47017, 66581, 40160) -- Stalwart Ametrine
lib:AddRecipe(47018, 66582, 40145) -- Resplendent Ametrine
lib:AddRecipe(47019, 66583, 40146) -- Fierce Ametrine
lib:AddRecipe(47020, 66584, 40150) -- Deft Ametrine
lib:AddRecipe(47021, 66585, 40149) -- Lucent Ametrine
lib:AddRecipe(47022, 66586, 40163) -- Resolute Ametrine
lib:AddRecipe(49112, 68253, 49110) -- Nightmare Tear
lib:AddRecipe(52362, 73335, 52206) -- Bold Inferno Ruby
lib:AddRecipe(52363, 73224, 52083) -- Flashing Carnelian
lib:AddRecipe(52364, 73229, 52088) -- Stormy Zephyrite
lib:AddRecipe(52365, 73231, 52090) -- Subtle Alicite
lib:AddRecipe(52366, 73242, 52097) -- Defender's Nightstone
lib:AddRecipe(52367, 73244, 52099) -- Guardian's Nightstone
lib:AddRecipe(52368, 73245, 52100) -- Purified Nightstone
lib:AddRecipe(52369, 73248, 52103) -- Retaliating Nightstone
lib:AddRecipe(52370, 73258, 52106) -- Polished Hessonite
lib:AddRecipe(52371, 73260, 52108) -- Inscribed Hessonite
lib:AddRecipe(52372, 73262, 52109) -- Deadly Hessonite
lib:AddRecipe(52373, 73263, 52110) -- Potent Hessonite
lib:AddRecipe(52374, 73264, 52111) -- Fierce Hessonite
lib:AddRecipe(52375, 73265, 52112) -- Deft Hessonite
lib:AddRecipe(52376, 73269, 52116) -- Fine Hessonite
lib:AddRecipe(52377, 73271, 52118) -- Keen Hessonite
lib:AddRecipe(52378, 73272, 52119) -- Regal Jasper
lib:AddRecipe(52379, 73273, 52120) -- Nimble Jasper
lib:AddRecipe(52380, 73336, 52212) -- Delicate Inferno Ruby
lib:AddRecipe(52381, 73396, 52255) -- Bold Chimera's Eye
lib:AddRecipe(52382, 73275, 52122) -- Piercing Jasper
lib:AddRecipe(52383, 73276, 52123) -- Steady Jasper
lib:AddRecipe(52384, 73337, 52216) -- Flashing Inferno Ruby
lib:AddRecipe(52385, 73277, 52124) -- Forceful Jasper
lib:AddRecipe(52386, 73278, 52125) -- Lightning Jasper
lib:AddRecipe(52387, 73338, 52207) -- Brilliant Inferno Ruby
lib:AddRecipe(52388, 73280, 52127) -- Zen Jasper
lib:AddRecipe(52389, 73339, 52230) -- Precise Inferno Ruby
lib:AddRecipe(52390, 73340, 52242) -- Solid Ocean Sapphire
lib:AddRecipe(52391, 73341, 52244) -- Sparkling Ocean Sapphire
lib:AddRecipe(52392, 73343, 52246) -- Stormy Ocean Sapphire
lib:AddRecipe(52393, 73344, 52235) -- Rigid Ocean Sapphire
lib:AddRecipe(52394, 73345, 52247) -- Subtle Amberjewel
lib:AddRecipe(52395, 73346, 52241) -- Smooth Amberjewel
lib:AddRecipe(52396, 73347, 52226) -- Mystic Amberjewel
lib:AddRecipe(52397, 73348, 52232) -- Quick Amberjewel
lib:AddRecipe(52398, 73349, 52219) -- Fractured Amberjewel
lib:AddRecipe(52399, 73350, 52243) -- Sovereign Demonseye
lib:AddRecipe(52400, 73351, 52238) -- Shifting Demonseye
lib:AddRecipe(52401, 73352, 52210) -- Defender's Demonseye
lib:AddRecipe(52402, 73353, 52248) -- Timeless Demonseye
lib:AddRecipe(52403, 73354, 52221) -- Guardian's Demonseye
lib:AddRecipe(52404, 73355, 52236) -- Purified Demonseye
lib:AddRecipe(52405, 73356, 52213) -- Etched Demonseye
lib:AddRecipe(52406, 73357, 52220) -- Glinting Demonseye
lib:AddRecipe(52407, 73358, 52234) -- Retaliating Demonseye
lib:AddRecipe(52408, 73359, 52217) -- Veiled Demonseye
lib:AddRecipe(52409, 73360, 52203) -- Accurate Demonseye
lib:AddRecipe(52410, 73361, 52229) -- Polished Ember Topaz
lib:AddRecipe(52411, 73362, 52249) -- Resolute Ember Topaz
lib:AddRecipe(52412, 73364, 52222) -- Inscribed Ember Topaz
lib:AddRecipe(52413, 73365, 52209) -- Deadly Ember Topaz
lib:AddRecipe(52414, 73366, 52239) -- Potent Ember Topaz
lib:AddRecipe(52415, 73367, 52214) -- Fierce Ember Topaz
lib:AddRecipe(52416, 73368, 52211) -- Deft Ember Topaz
lib:AddRecipe(52417, 73369, 52208) -- Reckless Ember Topaz
lib:AddRecipe(52418, 73370, 52240) -- Skillful Ember Topaz
lib:AddRecipe(52419, 73371, 52204) -- Adept Ember Topaz
lib:AddRecipe(52420, 73372, 52215) -- Fine Ember Topaz
lib:AddRecipe(52421, 73373, 52205) -- Artful Ember Topaz
lib:AddRecipe(52422, 73374, 52224) -- Keen Ember Topaz
lib:AddRecipe(52423, 73375, 52233) -- Regal Dream Emerald
lib:AddRecipe(52424, 73376, 52227) -- Nimble Dream Emerald
lib:AddRecipe(52425, 73377, 52223) -- Jagged Dream Emerald
lib:AddRecipe(52426, 73378, 52228) -- Piercing Dream Emerald
lib:AddRecipe(52427, 73379, 52245) -- Steady Dream Emerald
lib:AddRecipe(52428, 73380, 52218) -- Forceful Dream Emerald
lib:AddRecipe(52429, 73381, 52225) -- Lightning Dream Emerald
lib:AddRecipe(52430, 73382, 52231) -- Puissant Dream Emerald
lib:AddRecipe(52431, 73383, 52250) -- Zen Dream Emerald
lib:AddRecipe(52432, 73384, 52237) -- Sensei's Dream Emerald
lib:AddRecipe(52433, 73464, 52289) -- Fleet Shadowspirit Diamond
lib:AddRecipe(52434, 73465, 52291) -- Chaotic Shadowspirit Diamond
lib:AddRecipe(52435, 73466, 52292) -- Bracing Shadowspirit Diamond
lib:AddRecipe(52436, 73467, 52293) -- Eternal Shadowspirit Diamond
lib:AddRecipe(52437, 73468, 52294) -- Austere Shadowspirit Diamond
lib:AddRecipe(52438, 73469, 52295) -- Effulgent Shadowspirit Diamond
lib:AddRecipe(52439, 73470, 52296) -- Ember Shadowspirit Diamond
lib:AddRecipe(52440, 73471, 52297) -- Revitalizing Shadowspirit Diamond
lib:AddRecipe(52441, 73472, 52298) -- Destructive Shadowspirit Diamond
lib:AddRecipe(52442, 73473, 52299) -- Powerful Shadowspirit Diamond
lib:AddRecipe(52443, 73474, 52300) -- Enigmatic Shadowspirit Diamond
lib:AddRecipe(52444, 73475, 52301) -- Impassive Shadowspirit Diamond
lib:AddRecipe(52445, 73476, 52302) -- Forlorn Shadowspirit Diamond
lib:AddRecipe(52447, 73397, 52258) -- Delicate Chimera's Eye
lib:AddRecipe(52448, 73398, 52259) -- Flashing Chimera's Eye
lib:AddRecipe(52449, 73399, 52257) -- Brilliant Chimera's Eye
lib:AddRecipe(52450, 73400, 52260) -- Precise Chimera's Eye
lib:AddRecipe(52451, 73401, 52261) -- Solid Chimera's Eye
lib:AddRecipe(52452, 73402, 52262) -- Sparkling Chimera's Eye
lib:AddRecipe(52453, 73403, 52263) -- Stormy Chimera's Eye
lib:AddRecipe(52454, 73404, 52264) -- Rigid Chimera's Eye
lib:AddRecipe(52455, 73405, 52265) -- Subtle Chimera's Eye
lib:AddRecipe(52456, 73406, 52266) -- Smooth Chimera's Eye
lib:AddRecipe(52457, 73407, 52267) -- Mystic Chimera's Eye
lib:AddRecipe(52458, 73408, 52268) -- Quick Chimera's Eye
lib:AddRecipe(52459, 73409, 52269) -- Fractured Chimera's Eye
lib:AddRecipe(52460, 73520, 52348) -- Elementium Destroyer's Ring
lib:AddRecipe(52461, 73498, 52318) -- Band of Blades
lib:AddRecipe(52462, 73502, 52319) -- Ring of Warring Elements
lib:AddRecipe(52463, 73503, 52320) -- Elementium Moebius Band
lib:AddRecipe(52464, 73521, 52350) -- Brazen Elementium Medallion
lib:AddRecipe(52465, 73504, 52321) -- Entwined Elementium Choker
lib:AddRecipe(52466, 73505, 52322) -- Eye of Many Deaths
lib:AddRecipe(52467, 73506, 52323) -- Elementium Guardian
lib:AddRecipe(52494, 73625, 52485) -- Jeweler's Ruby Monocle
lib:AddRecipe(52495, 73626, 52486) -- Jeweler's Sapphire Monocle
lib:AddRecipe(52496, 73627, 52487) -- Jeweler's Amber Monocle
lib:AddRecipe(68359, 95754, 68356) -- Willful Ember Topaz
lib:AddRecipe(68360, 95755, 68357) -- Lucent Ember Topaz
lib:AddRecipe(68361, 95756, 68358) -- Resplendent Ember Topaz
lib:AddRecipe(68742, 96226, 68741) -- Vivid Dream Emerald
lib:AddRecipe(68781, 96255, 68778) -- Agile Shadowspirit Diamond
lib:AddRecipe(68782, 96256, 68779) -- Reverberating Shadowspirit Diamond
lib:AddRecipe(68783, 96257, 68780) -- Burning Shadowspirit Diamond
lib:AddRecipe(69820, 73266, 52113) -- Reckless Hessonite
lib:AddRecipe(69853, 98921, 69852) -- Punisher's Band
lib:AddRecipe(71821, 101735, 71817) -- Rigid Deepholm Iolite
lib:AddRecipe(71884, 101740, 71818) -- Stormy Deepholm Iolite
lib:AddRecipe(71885, 101741, 71819) -- Sparkling Deepholm Iolite
lib:AddRecipe(71886, 101742, 71820) -- Solid Deepholm Iolite
lib:AddRecipe(71887, 101743, 71822) -- Misty Elven Peridot
lib:AddRecipe(71888, 101744, 71823) -- Piercing Elven Peridot
lib:AddRecipe(71889, 101745, 71824) -- Lightning Elven Peridot
lib:AddRecipe(71890, 101746, 71825) -- Sensei's Elven Peridot
lib:AddRecipe(71891, 101747, 71826) -- Infused Elven Peridot
lib:AddRecipe(71892, 101748, 71827) -- Zen Elven Peridot
lib:AddRecipe(71893, 101749, 71828) -- Balanced Elven Peridot
lib:AddRecipe(71894, 101750, 71829) -- Vivid Elven Peridot
lib:AddRecipe(71895, 101751, 71830) -- Turbid Elven Peridot
lib:AddRecipe(71896, 101752, 71831) -- Radiant Elven Peridot
lib:AddRecipe(71897, 101753, 71832) -- Shattered Elven Peridot
lib:AddRecipe(71898, 101754, 71833) -- Energized Elven Peridot
lib:AddRecipe(71899, 101755, 71834) -- Jagged Elven Peridot
lib:AddRecipe(71900, 101756, 71835) -- Regal Elven Peridot
lib:AddRecipe(71901, 101757, 71836) -- Forceful Elven Peridot
lib:AddRecipe(71902, 101758, 71837) -- Nimble Elven Peridot
lib:AddRecipe(71903, 101759, 71838) -- Puissant Elven Peridot
lib:AddRecipe(71904, 101760, 71839) -- Steady Elven Peridot
lib:AddRecipe(71905, 101761, 71840) -- Deadly Lava Coral
lib:AddRecipe(71906, 101762, 71841) -- Crafty Lava Coral
lib:AddRecipe(71907, 101763, 71842) -- Potent Lava Coral
lib:AddRecipe(71908, 101764, 71843) -- Inscribed Lava Coral
lib:AddRecipe(71909, 101765, 71844) -- Polished Lava Coral
lib:AddRecipe(71910, 101766, 71845) -- Resolute Lava Coral
lib:AddRecipe(71911, 101767, 71846) -- Stalwart Lava Coral
lib:AddRecipe(71912, 101768, 71847) -- Champion's Lava Coral
lib:AddRecipe(71913, 101769, 71848) -- Deft Lava Coral
lib:AddRecipe(71914, 101770, 71849) -- Wicked Lava Coral
lib:AddRecipe(71915, 101771, 71850) -- Reckless Lava Coral
lib:AddRecipe(71916, 101772, 71851) -- Fierce Lava Coral
lib:AddRecipe(71917, 101773, 71852) -- Adept Lava Coral
lib:AddRecipe(71918, 101774, 71853) -- Keen Lava Coral
lib:AddRecipe(71919, 101775, 71854) -- Artful Lava Coral
lib:AddRecipe(71920, 101776, 71855) -- Fine Lava Coral
lib:AddRecipe(71921, 101777, 71856) -- Skillful Lava Coral
lib:AddRecipe(71922, 101778, 71857) -- Lucent Lava Coral
lib:AddRecipe(71923, 101779, 71858) -- Tenuous Lava Coral
lib:AddRecipe(71924, 101780, 71859) -- Willful Lava Coral
lib:AddRecipe(71925, 101781, 71860) -- Splendid Lava Coral
lib:AddRecipe(71926, 101782, 71861) -- Resplendent Lava Coral
lib:AddRecipe(71927, 101783, 71862) -- Glinting Shadow Spinel
lib:AddRecipe(71928, 101784, 71863) -- Accurate Shadow Spinel
lib:AddRecipe(71929, 101785, 71864) -- Veiled Shadow Spinel
lib:AddRecipe(71930, 101786, 71865) -- Retaliating Shadow Spinel
lib:AddRecipe(71931, 101787, 71866) -- Etched Shadow Spinel
lib:AddRecipe(71932, 101788, 71867) -- Mysterious Shadow Spinel
lib:AddRecipe(71933, 101789, 71868) -- Purified Shadow Spinel
lib:AddRecipe(71934, 101790, 71869) -- Shifting Shadow Spinel
lib:AddRecipe(71935, 101791, 71870) -- Guardian's Shadow Spinel
lib:AddRecipe(71936, 101792, 71871) -- Timeless Shadow Spinel
lib:AddRecipe(71937, 101793, 71872) -- Defender's Shadow Spinel
lib:AddRecipe(71938, 101794, 71873) -- Sovereign Shadow Spinel
lib:AddRecipe(71939, 101795, 71879) -- Delicate Queen's Garnet
lib:AddRecipe(71940, 101796, 71880) -- Precise Queen's Garnet
lib:AddRecipe(71941, 101797, 71881) -- Brilliant Queen's Garnet
lib:AddRecipe(71942, 101798, 71882) -- Flashing Queen's Garnet
lib:AddRecipe(71943, 101799, 71883) -- Bold Queen's Garnet
lib:AddRecipe(71944, 101800, 71874) -- Smooth Lightstone
lib:AddRecipe(71945, 101801, 71875) -- Subtle Lightstone
lib:AddRecipe(71946, 101802, 71876) -- Quick Lightstone
lib:AddRecipe(71947, 101803, 71877) -- Fractured Lightstone
lib:AddRecipe(71948, 101804, 71878) -- Mystic Lightstone
lib:AddRecipe(71965, 73623, 52489) -- Rhinestone Sunglasses
lib:AddRecipe(83811, 107753, 76884) -- Agile Primal Diamond
lib:AddRecipe(83815, 107754, 76895) -- Austere Primal Diamond
lib:AddRecipe(83825, 107756, 76885) -- Burning Primal Diamond
lib:AddRecipe(83830, 121843, 83089) -- Sunstone Panther
lib:AddRecipe(83840, 107757, 76890) -- Destructive Primal Diamond
lib:AddRecipe(83842, 107758, 76897) -- Effulgent Primal Diamond
lib:AddRecipe(83844, 107759, 76879) -- Ember Primal Diamond
lib:AddRecipe(83845, 121844, 83088) -- Jade Panther
lib:AddRecipe(83848, 107760, 76892) -- Enigmatic Primal Diamond
lib:AddRecipe(83851, 107762, 76896) -- Eternal Primal Diamond
lib:AddRecipe(83859, 107763, 76887) -- Fleet Primal Diamond
lib:AddRecipe(83862, 107764, 76894) -- Forlorn Primal Diamond
lib:AddRecipe(83872, 107765, 76893) -- Impassive Primal Diamond
lib:AddRecipe(83877, 120045, 82453) -- Jeweled Onyx Panther
lib:AddRecipe(83901, 107766, 76891) -- Powerful Primal Diamond
lib:AddRecipe(83925, 107767, 76886) -- Reverberating Primal Diamond
lib:AddRecipe(83926, 107768, 76888) -- Revitalizing Primal Diamond
lib:AddRecipe(83931, 121841, 83087) -- Ruby Panther
lib:AddRecipe(83932, 121842, 83090) -- Sapphire Panther
lib:AddRecipe(90470, 131897, 82774) -- Jade Owl
lib:AddRecipe(90471, 131898, 82775) -- Sapphire Cub
lib:AddRecipe(95470, 140050, 95469) -- Serpent's Heart
lib:AddRecipe(95471, 140060, 76132) -- Primal Diamond
lib:AddRecipe(116078, 170701, 115526) -- Taladite Recrystalizer
lib:AddRecipe(116081, 170704, 115987) -- Glowing Iron Band
lib:AddRecipe(116082, 170705, 115988) -- Shifting Iron Band
lib:AddRecipe(116083, 170706, 115989) -- Whispering Iron Band
lib:AddRecipe(116084, 170707, 115990) -- Glowing Iron Choker
lib:AddRecipe(116085, 170708, 115991) -- Shifting Iron Choker
lib:AddRecipe(116086, 170709, 115992) -- Whispering Iron Choker
lib:AddRecipe(116087, 170710, 115993) -- Glowing Blackrock Band
lib:AddRecipe(116088, 170711, 115994) -- Shifting Blackrock Band
lib:AddRecipe(116089, 170712, 115995) -- Whispering Blackrock Band
lib:AddRecipe(116090, 170713, 115794) -- Glowing Taladite Ring
lib:AddRecipe(116091, 170714, 115796) -- Shifting Taladite Ring
lib:AddRecipe(116092, 170715, 115798) -- Whispering Taladite Ring
lib:AddRecipe(116093, 170716, 115799) -- Glowing Taladite Pendant
lib:AddRecipe(116094, 170717, 115800) -- Shifting Taladite Pendant
lib:AddRecipe(116095, 170718, 115801) -- Whispering Taladite Pendant
lib:AddRecipe(116096, 170719, 115803) -- Critical Strike Taladite
lib:AddRecipe(116097, 170720, 115804) -- Haste Taladite
lib:AddRecipe(116098, 170721, 115805) -- Mastery Taladite
lib:AddRecipe(116100, 170723, 115807) -- Versatility Taladite
lib:AddRecipe(116101, 170724, 115808) -- Stamina Taladite
lib:AddRecipe(116102, 170725, 115809) -- Greater Critical Strike Taladite
lib:AddRecipe(116103, 170726, 115811) -- Greater Haste Taladite
lib:AddRecipe(116104, 170727, 115812) -- Greater Mastery Taladite
lib:AddRecipe(116106, 170729, 115814) -- Greater Versatility Taladite
lib:AddRecipe(116107, 170730, 115815) -- Greater Stamina Taladite
lib:AddRecipe(116108, 170731, 112384) -- Reflecting Prism
lib:AddRecipe(116109, 170732, 112498) -- Prismatic Focusing Lens
lib:AddRecipe(120131, 176087, 118723) -- Secrets of Draenor Jewelcrafting
lib:AddRecipe(122714, 182127, 115524) -- Primal Gemcutting
lib:AddRecipe(132467, 195860, 130227) -- Skystone Pendant
lib:AddRecipe(132468, 195859, 130226) -- Deep Amber Pendant
lib:AddRecipe(132469, 195861, 130228) -- Azsunite Pendant
lib:AddRecipe(137792, 195856, 130223) -- Deep Amber Loop
lib:AddRecipe(137793, 195857, 130224) -- Skystone Loop
lib:AddRecipe(137794, 195858, 130225) -- Azsunite Loop
lib:AddRecipe(137795, 195859, 130226) -- Deep Amber Pendant
lib:AddRecipe(137796, 195860, 130227) -- Skystone Pendant
lib:AddRecipe(137797, 195861, 130228) -- Azsunite Pendant
lib:AddRecipe(137798, 195862, 130229) -- Prophetic Band
lib:AddRecipe(137799, 195863, 130230) -- Maelstrom Band
lib:AddRecipe(137800, 195864, 130231) -- Dawnlight Band
lib:AddRecipe(137801, 195865, 130233) -- Sorcerous Shadowruby Pendant
lib:AddRecipe(137802, 195866, 130234) -- Blessed Dawnlight Medallion
lib:AddRecipe(137803, 195867, 130235) -- Twisted Pandemonite Choker
lib:AddRecipe(137804, 195868, 130236) -- Subtle Shadowruby Pendant
lib:AddRecipe(137805, 195869, 130237) -- Tranquil Necklace of Prophecy
lib:AddRecipe(137806, 195870, 130238) -- Vindictive Pandemonite Choker
lib:AddRecipe(137807, 195871, 130239) -- Sylvan Maelstrom Amulet
lib:AddRecipe(137808, 195872, 130240) -- Intrepid Necklace of Prophecy
lib:AddRecipe(137809, 195873, 130241) -- Ancient Maelstrom Amulet
lib:AddRecipe(137810, 195874, 130242) -- Righteous Dawnlight Medallion
lib:AddRecipe(137811, 195875, 130243) -- Raging Furystone Gorget
lib:AddRecipe(137812, 195876, 130244) -- Grim Furystone Gorget
lib:AddRecipe(137813, 195877, 130245) -- Saber's Eye
lib:AddRecipe(137814, 195878, 130246) -- Saber's Eye of Strength
lib:AddRecipe(137815, 195879, 130247) -- Saber's Eye of Agility
lib:AddRecipe(137816, 195880, 130248) -- Saber's Eye of Intellect
lib:AddRecipe(137817, 195902, 130223) -- Deep Amber Loop
lib:AddRecipe(137818, 195903, 130224) -- Skystone Loop
lib:AddRecipe(137819, 195904, 130225) -- Azsunite Loop
lib:AddRecipe(137820, 195905, 130226) -- Deep Amber Pendant
lib:AddRecipe(137821, 195906, 130227) -- Skystone Pendant
lib:AddRecipe(137822, 195907, 130228) -- Azsunite Pendant
lib:AddRecipe(137823, 195908, 130229) -- Prophetic Band
lib:AddRecipe(137824, 195909, 130230) -- Maelstrom Band
lib:AddRecipe(137825, 195910, 130231) -- Dawnlight Band
lib:AddRecipe(137826, 195911, 130233) -- Sorcerous Shadowruby Pendant
lib:AddRecipe(137827, 195912, 130234) -- Blessed Dawnlight Medallion
lib:AddRecipe(137828, 195913, 130235) -- Twisted Pandemonite Choker
lib:AddRecipe(137829, 195914, 130236) -- Subtle Shadowruby Pendant
lib:AddRecipe(137830, 195915, 130237) -- Tranquil Necklace of Prophecy
lib:AddRecipe(137831, 195916, 130238) -- Vindictive Pandemonite Choker
lib:AddRecipe(137832, 195917, 130239) -- Sylvan Maelstrom Amulet
lib:AddRecipe(137833, 195918, 130240) -- Intrepid Necklace of Prophecy
lib:AddRecipe(137834, 195919, 130241) -- Ancient Maelstrom Amulet
lib:AddRecipe(137835, 195920, 130242) -- Righteous Dawnlight Medallion
lib:AddRecipe(137836, 195921, 130243) -- Raging Furystone Gorget
lib:AddRecipe(137837, 195922, 130244) -- Grim Furystone Gorget
lib:AddRecipe(137838, 195923, 130223) -- Deep Amber Loop
lib:AddRecipe(137839, 195924, 130224) -- Skystone Loop
lib:AddRecipe(137840, 195925, 130225) -- Azsunite Loop
lib:AddRecipe(137841, 195926, 130226) -- Deep Amber Pendant
lib:AddRecipe(137842, 195927, 130227) -- Skystone Pendant
lib:AddRecipe(137843, 195928, 130228) -- Azsunite Pendant
lib:AddRecipe(137844, 195929, 130229) -- Prophetic Band
lib:AddRecipe(137845, 195930, 130230) -- Maelstrom Band
lib:AddRecipe(137846, 195931, 130231) -- Dawnlight Band
lib:AddRecipe(137847, 195932, 130233) -- Sorcerous Shadowruby Pendant
lib:AddRecipe(137848, 195933, 130234) -- Blessed Dawnlight Medallion
lib:AddRecipe(137849, 195934, 130235) -- Twisted Pandemonite Choker
lib:AddRecipe(137850, 195935, 130236) -- Subtle Shadowruby Pendant
lib:AddRecipe(137851, 195936, 130237) -- Tranquil Necklace of Prophecy
lib:AddRecipe(137852, 195937, 130238) -- Vindictive Pandemonite Choker
lib:AddRecipe(137853, 195938, 130239) -- Sylvan Maelstrom Amulet
lib:AddRecipe(137854, 195939, 130240) -- Intrepid Necklace of Prophecy
lib:AddRecipe(137855, 195940, 130241) -- Ancient Maelstrom Amulet
lib:AddRecipe(137856, 195941, 130242) -- Righteous Dawnlight Medallion
lib:AddRecipe(137857, 195942, 130243) -- Raging Furystone Gorget
lib:AddRecipe(137858, 195943, 130244) -- Grim Furystone Gorget
lib:AddRecipe(137859, 209603, 136711) -- Queen's Opal Loop
lib:AddRecipe(137860, 209604, 136712) -- Queen's Opal Pendant
lib:AddRecipe(137861, 209605, 136713) -- Shadowruby Band
lib:AddRecipe(137862, 209606, 136711) -- Queen's Opal Loop
lib:AddRecipe(137863, 209607, 136712) -- Queen's Opal Pendant
lib:AddRecipe(137864, 209608, 136713) -- Shadowruby Band
lib:AddRecipe(137865, 209609, 136711) -- Queen's Opal Loop
lib:AddRecipe(137866, 209610, 136712) -- Queen's Opal Pendant
lib:AddRecipe(137867, 209611, 136713) -- Shadowruby Band
lib:AddRecipe(138451, 195848, 130215) -- Deadly Deep Amber
lib:AddRecipe(138452, 195849, 130216) -- Quick Azsunite
lib:AddRecipe(138453, 195851, 130218) -- Masterful Queen's Opal
lib:AddRecipe(138454, 195852, 130219) -- Deadly Eye of Prophecy
lib:AddRecipe(138455, 195853, 130220) -- Quick Dawnlight
lib:AddRecipe(138456, 195855, 130222) -- Masterful Shadowruby
lib:AddRecipe(141311, 225902, 123918) -- Mass Prospect Leystone
lib:AddRecipe(141312, 225904, 123919) -- Mass Prospect Felslate
lib:AddRecipe(151724, 247751, 151587) -- Empyrial Cosmic Crown
lib:AddRecipe(151725, 247754, 151587) -- Empyrial Cosmic Crown
lib:AddRecipe(151726, 247755, 151587) -- Empyrial Cosmic Crown
lib:AddRecipe(151727, 247756, 151588) -- Empyrial Deep Crown
lib:AddRecipe(151728, 247757, 151588) -- Empyrial Deep Crown
lib:AddRecipe(151729, 247758, 151588) -- Empyrial Deep Crown
lib:AddRecipe(151730, 247762, 151589) -- Empyrial Elemental Crown
lib:AddRecipe(151731, 247763, 151589) -- Empyrial Elemental Crown
lib:AddRecipe(151732, 247764, 151589) -- Empyrial Elemental Crown
lib:AddRecipe(151733, 247765, 151590) -- Empyrial Titan Crown
lib:AddRecipe(151734, 247766, 151590) -- Empyrial Titan Crown
lib:AddRecipe(151735, 247767, 151590) -- Empyrial Titan Crown
lib:AddRecipe(151736, 247771, 151580) -- Deadly Deep Chemirine
lib:AddRecipe(151737, 247772, 151583) -- Quick Lightsphene
lib:AddRecipe(151738, 247773, 151584) -- Masterful Argulite
lib:AddRecipe(151739, 247774, 151585) -- Versatile Labradorite
lib:AddRecipe(152726, 247761, 151564) -- Mass Prospect Empyrium
lib:AddRecipe(162378, 256515, 153686) -- Amberblaze Loop
lib:AddRecipe(162379, 256517, 153685) -- Owlseye Loop
lib:AddRecipe(162380, 256519, 153684) -- Tidal Amethyst Loop
lib:AddRecipe(162381, 256521, 153683) -- Royal Quartz Loop
lib:AddRecipe(162382, 256257, 153639) -- Laribole Staff of Alacrity
lib:AddRecipe(162385, 256260, 153640) -- Scarlet Diamond Staff of Intuition
lib:AddRecipe(162760, 256515, 153686) -- Amberblaze Loop
lib:AddRecipe(162761, 256517, 153685) -- Owlseye Loop
lib:AddRecipe(162762, 256519, 153684) -- Tidal Amethyst Loop
lib:AddRecipe(162763, 256521, 153683) -- Royal Quartz Loop
lib:AddRecipe(162764, 256257, 153639) -- Laribole Staff of Alacrity
lib:AddRecipe(162765, 256260, 153640) -- Scarlet Diamond Staff of Intuition
lib:AddRecipe(163024, 269735, 159939) -- Honorable Combatant's Intuitive Staff
lib:AddRecipe(163025, 269736, 159939) -- Honorable Combatant's Intuitive Staff
lib:AddRecipe(165308, 282344, 164681) -- Sinister Combatant's Intuitive Staff
lib:AddRecipe(165309, 282345, 164681) -- Sinister Combatant's Intuitive Staff
lib:AddRecipe(166540, 289174, 166520) -- Imbued Kraken's Eye Loop
lib:AddRecipe(166541, 289175, 166521) -- Emblazoned Kraken's Eye Loop
lib:AddRecipe(166542, 289180, 166523) -- Spirited Kraken's Eye Loop
lib:AddRecipe(166543, 289181, 166524) -- Eternal Kraken's Eye Loop
lib:AddRecipe(168027, 256703, 153716) -- Jewelhammer's Focus
lib:AddRecipe(168771, 299017, 168702) -- Crushing Leviathan's Eye Loop
lib:AddRecipe(168772, 299018, 168703) -- Ascended Leviathan's Eye Loop
lib:AddRecipe(169551, 294794, 167943) -- Notorious Combatant's Intuitive Staff
lib:AddRecipe(169552, 294795, 167943) -- Notorious Combatant's Intuitive Staff
lib:AddRecipe(171082, 305980, 171075) -- Peerless Leviathan's Eye Loop
lib:AddRecipe(171083, 305981, 171076) -- Awakened Leviathan's Eye Loop
lib:AddRecipe(171158, 305171, 170318) -- Uncanny Combatant's Intuitive Staff
lib:AddRecipe(171159, 305170, 170318) -- Uncanny Combatant's Intuitive Staff
lib:AddRecipe(174365, 305982, 171077) -- Unbound Leviathan's Eye Loop
lib:AddRecipe(180783, 334548, 180760) -- Crown of the Righteous
lib:AddRecipe(183099, 311870, 173125) -- Revitalizing Jewel Doublet
lib:AddRecipe(186993, 355187, 186981) -- Porous Stone Statue
lib:AddRecipe(186994, 355189, 186982) -- Shaded Stone Statue
lib:AddRecipe(187830, 360016, 187829) -- Aealic Harmonizing Stone
lib:AddRecipe(187847, 360317, 187849) -- Devourer Essence Stone
lib:AddRecipe(194596, 374437, 192900) -- Crafty Queen's Ruby
lib:AddRecipe(194597, 374438, 192903) -- Zen Mystic Sapphire
lib:AddRecipe(194598, 374439, 192906) -- Energized Vibrant Emerald
lib:AddRecipe(194599, 374440, 192910) -- Sensei's Sundered Onyx
lib:AddRecipe(194600, 374441, 192913) -- Solid Eternity Amber
lib:AddRecipe(194601, 374442, 192917) -- Crafty Alexstraszite
lib:AddRecipe(194602, 374443, 192920) -- Sensei's Alexstraszite
lib:AddRecipe(194603, 374444, 192923) -- Radiant Alexstraszite
lib:AddRecipe(194604, 374445, 192926) -- Deadly Alexstraszite
lib:AddRecipe(194605, 374446, 192929) -- Radiant Malygite
lib:AddRecipe(194606, 374447, 192933) -- Energized Malygite
lib:AddRecipe(194607, 374448, 192936) -- Zen Malygite
lib:AddRecipe(194608, 374449, 192940) -- Stormy Malygite
lib:AddRecipe(194609, 374450, 192943) -- Crafty Ysemerald
lib:AddRecipe(194610, 374453, 192946) -- Keen Ysemerald
lib:AddRecipe(194611, 374454, 192950) -- Energized Ysemerald
lib:AddRecipe(194612, 374455, 192953) -- Quick Ysemerald
lib:AddRecipe(194613, 374456, 192956) -- Sensei's Neltharite
lib:AddRecipe(194614, 374457, 192959) -- Keen Neltharite
lib:AddRecipe(194615, 374458, 192962) -- Zen Neltharite
lib:AddRecipe(194616, 374459, 192965) -- Fractured Neltharite
lib:AddRecipe(194617, 374460, 192968) -- Jagged Nozdorite
lib:AddRecipe(194618, 374461, 192971) -- Forceful Nozdorite
lib:AddRecipe(194619, 374462, 192974) -- Puissant Nozdorite
lib:AddRecipe(194620, 374463, 192977) -- Steady Nozdorite
lib:AddRecipe(194621, 374465, 192980) -- Inscribed Illimited Diamond
lib:AddRecipe(194622, 374467, 192983) -- Fierce Illimited Diamond
lib:AddRecipe(194623, 374468, 192986) -- Skillful Illimited Diamond
lib:AddRecipe(194624, 374470, 192989) -- Resplendent Illimited Diamond
lib:AddRecipe(194625, 374472, 192992) -- Tiered Medallion Setting
lib:AddRecipe(194626, 374475, 192834) -- Shimmering Clasp
lib:AddRecipe(194627, 374477, 191474) -- Draconic Vial
lib:AddRecipe(194628, 374478, 192876) -- Frameless Lens
lib:AddRecipe(194629, 374480, 192883) -- Glossy Stone
lib:AddRecipe(194630, 374483, 192894) -- Blotting Sand
lib:AddRecipe(194631, 374484, 192897) -- Pounce
lib:AddRecipe(194632, 374486, 193003) -- Idol of the Life-Binder
lib:AddRecipe(194633, 374488, 193004) -- Idol of the Spell-Weaver
lib:AddRecipe(194634, 374490, 193005) -- Idol of the Dreamer
lib:AddRecipe(194635, 374493, 193006) -- Idol of the Earth-Warder
lib:AddRecipe(194636, 374494, 192996) -- Pendant of Impending Perils
lib:AddRecipe(194637, 374495, 192998) -- Crimson Combatant's Jeweled Amulet
lib:AddRecipe(194638, 374496, 192997) -- Crimson Combatant's Jeweled Signet
lib:AddRecipe(194639, 374497, 192999) -- Signet of Titanic Insight
lib:AddRecipe(194640, 374498, 193000) -- Ring-Bound Hourglass
lib:AddRecipe(194641, 374499, 193001) -- Elemental Lariat
lib:AddRecipe(194642, 374501, 193002) -- Choker of Shielding
lib:AddRecipe(194643, 374502, 193007) -- Narcissist's Sculpture
lib:AddRecipe(194644, 374506, 193011) -- Revitalizing Red Carving
lib:AddRecipe(194645, 374508, 193015) -- Statue of Tyr's Herald
lib:AddRecipe(194646, 374509, 193019) -- Djaradin's "Pinata"
lib:AddRecipe(194647, 374510, 193887) -- Jeweled Ruby Whelpling
lib:AddRecipe(194648, 374511, 193888) -- Jeweled Emerald Whelpling
lib:AddRecipe(194649, 374512, 193886) -- Jeweled Sapphire Whelpling
lib:AddRecipe(194650, 374514, 193889) -- Jeweled Onyx Whelpling
lib:AddRecipe(194651, 374516, 193885) -- Jeweled Amber Whelpling
lib:AddRecipe(194652, 374518, 193029) -- Projection Prism
lib:AddRecipe(194653, 374522, 193032) -- Jeweled Offering
lib:AddRecipe(194654, 374525, 193033) -- Convergent Prism
lib:AddRecipe(194656, 374530, 193035) -- Bold-Print Bifocals
lib:AddRecipe(194657, 374531, 193036) -- Left-Handed Magnifying Glass
lib:AddRecipe(194658, 374532, 193037) -- Sundered Onyx Loupe
lib:AddRecipe(194659, 374537, 193038) -- Chromatic Focus
lib:AddRecipe(194660, 374538, 193039) -- Fine-Print Trifocals
lib:AddRecipe(194661, 374540, 193040) -- Magnificent Margin Magnifier
lib:AddRecipe(194662, 374542, 193041) -- Alexstraszite Loupes
lib:AddRecipe(194663, 374543, 193042) -- Resonant Focus
lib:AddRecipe(194664, 374546, 192888) -- Queen's Gift
lib:AddRecipe(194665, 374547, 192889) -- Dreamer's Vision
lib:AddRecipe(194666, 374548, 192890) -- Keeper's Glory
lib:AddRecipe(194667, 374549, 192891) -- Earthwarden's Prize
lib:AddRecipe(194668, 374550, 192892) -- Timewatcher's Patience
lib:AddRecipe(194669, 374551, 192893) -- Jeweled Dragon's Heart
lib:AddRecipe(194670, 374553, 192887) -- Elemental Harmony
lib:AddRecipe(194671, 375063, 193371) -- "Rhinestone" Sunglasses
lib:AddRecipe(194672, 376233, 194082) -- Band of New Beginnings
lib:AddRecipe(194726, 377804, 194723) -- Kalu'ak Figurine
lib:AddRecipe(194749, 377960, 194748) -- Split-Lens Specs
lib:AddRecipe(198839, 374497, 192999) -- Signet of Titanic Insight
lib:AddRecipe(203426, 400812, 203413) -- Crystal Tuning Fork
lib:AddRecipe(204146, 403131, 204095) -- Obsidian Combatant's Jeweled Amulet
lib:AddRecipe(204147, 403132, 204094) -- Obsidian Combatant's Jeweled Signet
lib:AddRecipe(204219, 403483, 204217) -- Unstable Elementium
lib:AddRecipe(204406, 405205, 204404) -- Square Holders
lib:AddRecipe(205174, 408231, 205045) -- B.B.F. Fist
lib:AddRecipe(205175, 408397, 204909) -- Statuette of Foreseen Power
lib:AddRecipe(205176, 408398, 205171) -- Figurine of the Gathering Storm
lib:AddRecipe(206543, 413743, 206496) -- Gem of the Nerubians
lib:AddRecipe(206551, 413751, 206504) -- Frostwyrm's Icy Gaze
lib:AddRecipe(206552, 413752, 206505) -- Frostwyrm's Frigid Stare
lib:AddRecipe(208289, 419004, 208238) -- Verdant Combatant's Jeweled Amulet
lib:AddRecipe(208290, 419005, 208237) -- Verdant Combatant's Jeweled Signet
lib:AddRecipe(210170, 420740, 208746) -- Dreamtender's Charm
-- Leatherworking
lib:AddRecipe(2406, 2158, 2307) -- Fine Leather Boots
lib:AddRecipe(2407, 2163, 2311) -- White Leather Jerkin
lib:AddRecipe(2408, 2164, 2312) -- Fine Leather Gloves
lib:AddRecipe(2409, 2169, 2317) -- Dark Leather Tunic
lib:AddRecipe(4293, 3762, 4244) -- Hillman's Leather Vest
lib:AddRecipe(4294, 3767, 4250) -- Hillman's Belt
lib:AddRecipe(4296, 3769, 4252) -- Dark Leather Shoulders
lib:AddRecipe(4297, 3771, 4254) -- Barbaric Gloves
lib:AddRecipe(4298, 3775, 4258) -- Guardian Belt
lib:AddRecipe(4299, 3773, 4256) -- Guardian Armor
lib:AddRecipe(4300, 3777, 4260) -- Guardian Leather Bracers
lib:AddRecipe(4301, 3779, 4264) -- Barbaric Belt
lib:AddRecipe(5083, 5244, 5081) -- Kodo Hide Bag
lib:AddRecipe(5786, 6702, 5780) -- Murloc Scale Belt
lib:AddRecipe(5787, 6703, 5781) -- Murloc Scale Breastplate
lib:AddRecipe(5788, 6704, 5782) -- Thick Murloc Armor
lib:AddRecipe(5789, 6705, 5783) -- Murloc Scale Bracers
lib:AddRecipe(5972, 7133, 5958) -- Fine Leather Pants
lib:AddRecipe(5973, 7149, 5963) -- Barbaric Leggings
lib:AddRecipe(5974, 7153, 5965) -- Guardian Cloak
lib:AddRecipe(6474, 7953, 6466) -- Deviate Scale Cloak
lib:AddRecipe(6475, 7954, 6467) -- Deviate Scale Gloves
lib:AddRecipe(6476, 7955, 6468) -- Deviate Scale Belt
lib:AddRecipe(6710, 8322, 6709) -- Moonglow Vest
lib:AddRecipe(7288, 9064, 7280) -- Rugged Leather Pants
lib:AddRecipe(7289, 9070, 7283) -- Black Whelp Cloak
lib:AddRecipe(7290, 9072, 7284) -- Red Whelp Gloves
lib:AddRecipe(7360, 3765, 4248) -- Dark Leather Gloves
lib:AddRecipe(7361, 9146, 7349) -- Herbalist's Gloves
lib:AddRecipe(7362, 9147, 7352) -- Earthen Leather Shoulders
lib:AddRecipe(7363, 9148, 7358) -- Pilferer's Gloves
lib:AddRecipe(7364, 9149, 7359) -- Heavy Earthen Gloves
lib:AddRecipe(7449, 9195, 7373) -- Dusky Leather Leggings
lib:AddRecipe(7450, 9197, 7375) -- Green Whelp Armor
lib:AddRecipe(7451, 9202, 7386) -- Green Whelp Bracers
lib:AddRecipe(7452, 9207, 7390) -- Dusky Boots
lib:AddRecipe(7453, 9208, 7391) -- Swift Boots
lib:AddRecipe(7613, 3772, 4255) -- Green Leather Armor
lib:AddRecipe(8384, 10490, 8174) -- Comfortable Leather Hat
lib:AddRecipe(8385, 10509, 8187) -- Turtle Scale Gloves
lib:AddRecipe(8386, 10520, 8200) -- Big Voodoo Robe
lib:AddRecipe(8387, 10531, 8201) -- Big Voodoo Mask
lib:AddRecipe(8389, 10560, 8202) -- Big Voodoo Pants
lib:AddRecipe(8390, 10562, 8216) -- Big Voodoo Cloak
lib:AddRecipe(8395, 10525, 8203) -- Tough Scorpid Breastplate
lib:AddRecipe(8397, 10533, 8205) -- Tough Scorpid Bracers
lib:AddRecipe(8398, 10542, 8204) -- Tough Scorpid Gloves
lib:AddRecipe(8399, 10554, 8209) -- Tough Scorpid Boots
lib:AddRecipe(8400, 10564, 8207) -- Tough Scorpid Shoulders
lib:AddRecipe(8401, 10568, 8206) -- Tough Scorpid Leggings
lib:AddRecipe(8402, 10570, 8208) -- Tough Scorpid Helm
lib:AddRecipe(8403, 10529, 8210) -- Wild Leather Shoulders
lib:AddRecipe(8404, 10544, 8211) -- Wild Leather Vest
lib:AddRecipe(8405, 10546, 8214) -- Wild Leather Helmet
lib:AddRecipe(8406, 10566, 8213) -- Wild Leather Boots
lib:AddRecipe(8407, 10572, 8212) -- Wild Leather Leggings
lib:AddRecipe(8408, 10574, 8215) -- Wild Leather Cloak
lib:AddRecipe(8409, 10516, 8192) -- Nightscape Shoulders
lib:AddRecipe(13287, 4096, 4455) -- Raptor Hide Harness
lib:AddRecipe(13288, 4097, 4456) -- Raptor Hide Belt
lib:AddRecipe(14635, 3778, 4262) -- Gem-studded Leather Belt
lib:AddRecipe(15724, 19048, 15077) -- Heavy Scorpid Bracers
lib:AddRecipe(15725, 19049, 15083) -- Wicked Leather Gauntlets
lib:AddRecipe(15727, 19051, 15076) -- Heavy Scorpid Vest
lib:AddRecipe(15728, 19052, 15084) -- Wicked Leather Bracers
lib:AddRecipe(15729, 19053, 15074) -- Chimeric Gloves
lib:AddRecipe(15730, 19054, 15047) -- Red Dragonscale Breastplate
lib:AddRecipe(15731, 19055, 15091) -- Runic Leather Gauntlets
lib:AddRecipe(15732, 19059, 15054) -- Volcanic Leggings
lib:AddRecipe(15734, 19061, 15061) -- Living Shoulders
lib:AddRecipe(15735, 19062, 15067) -- Ironfeather Shoulders
lib:AddRecipe(15737, 19063, 15073) -- Chimeric Boots
lib:AddRecipe(15738, 19064, 15078) -- Heavy Scorpid Gauntlets
lib:AddRecipe(15739, 19065, 15092) -- Runic Leather Bracers
lib:AddRecipe(15740, 19066, 15071) -- Frostsaber Boots
lib:AddRecipe(15741, 19067, 15057) -- Stormshroud Pants
lib:AddRecipe(15742, 19068, 15064) -- Warbear Harness
lib:AddRecipe(15743, 19070, 15082) -- Heavy Scorpid Belt
lib:AddRecipe(15744, 19071, 15086) -- Wicked Leather Headband
lib:AddRecipe(15745, 19072, 15093) -- Runic Leather Belt
lib:AddRecipe(15746, 19073, 15072) -- Chimeric Leggings
lib:AddRecipe(15747, 19074, 15069) -- Frostsaber Leggings
lib:AddRecipe(15748, 19075, 15079) -- Heavy Scorpid Leggings
lib:AddRecipe(15749, 19076, 15053) -- Volcanic Breastplate
lib:AddRecipe(15751, 19077, 15048) -- Blue Dragonscale Breastplate
lib:AddRecipe(15752, 19078, 15060) -- Living Leggings
lib:AddRecipe(15753, 19079, 15056) -- Stormshroud Armor
lib:AddRecipe(15754, 19080, 15065) -- Warbear Woolies
lib:AddRecipe(15755, 19081, 15075) -- Chimeric Vest
lib:AddRecipe(15756, 19082, 15094) -- Runic Leather Headband
lib:AddRecipe(15757, 19083, 15087) -- Wicked Leather Pants
lib:AddRecipe(15758, 19084, 15063) -- Devilsaur Gauntlets
lib:AddRecipe(15759, 19085, 15050) -- Black Dragonscale Breastplate
lib:AddRecipe(15760, 19086, 15066) -- Ironfeather Breastplate
lib:AddRecipe(15761, 19087, 15070) -- Frostsaber Gloves
lib:AddRecipe(15762, 19088, 15080) -- Heavy Scorpid Helm
lib:AddRecipe(15763, 19089, 15049) -- Blue Dragonscale Shoulders
lib:AddRecipe(15764, 19090, 15058) -- Stormshroud Shoulders
lib:AddRecipe(15765, 19091, 15095) -- Runic Leather Pants
lib:AddRecipe(15768, 19092, 15088) -- Wicked Leather Belt
lib:AddRecipe(15770, 19094, 15051) -- Black Dragonscale Shoulders
lib:AddRecipe(15771, 19095, 15059) -- Living Breastplate
lib:AddRecipe(15772, 19097, 15062) -- Devilsaur Leggings
lib:AddRecipe(15773, 19098, 15085) -- Wicked Leather Armor
lib:AddRecipe(15774, 19100, 15081) -- Heavy Scorpid Shoulders
lib:AddRecipe(15775, 19101, 15055) -- Volcanic Shoulders
lib:AddRecipe(15776, 19102, 15090) -- Runic Leather Armor
lib:AddRecipe(15777, 19103, 15096) -- Runic Leather Shoulders
lib:AddRecipe(15779, 19104, 15068) -- Frostsaber Tunic
lib:AddRecipe(15781, 19107, 15052) -- Black Dragonscale Leggings
lib:AddRecipe(17022, 20853, 16982) -- Corehound Boots
lib:AddRecipe(17023, 20854, 16983) -- Molten Helm
lib:AddRecipe(17025, 20855, 16984) -- Black Dragonscale Boots
lib:AddRecipe(17722, 21943, 17721) -- Gloves of the Greatfather
lib:AddRecipe(18239, 22711, 18238) -- Shadowskin Gloves
lib:AddRecipe(18252, 22727, 18251) -- Core Armor Kit
lib:AddRecipe(18514, 22921, 18504) -- Girdle of Insight
lib:AddRecipe(18515, 22922, 18506) -- Mongoose Boots
lib:AddRecipe(18516, 22923, 18508) -- Swift Flight Bracers
lib:AddRecipe(18517, 22926, 18509) -- Chromatic Cloak
lib:AddRecipe(18518, 22927, 18510) -- Hide of the Wild
lib:AddRecipe(18519, 22928, 18511) -- Shifting Cloak
lib:AddRecipe(18731, 23190, 18662) -- Heavy Leather Ball
lib:AddRecipe(18949, 23399, 18948) -- Barbaric Bracers
lib:AddRecipe(19326, 23703, 19044) -- Might of the Timbermaw
lib:AddRecipe(19327, 23704, 19049) -- Timbermaw Brawlers
lib:AddRecipe(19328, 23705, 19052) -- Dawn Treaders
lib:AddRecipe(19329, 23706, 19058) -- Golden Mantle of the Dawn
lib:AddRecipe(19330, 23707, 19149) -- Lava Belt
lib:AddRecipe(19331, 23708, 19157) -- Chromatic Gauntlets
lib:AddRecipe(19332, 23709, 19162) -- Corehound Belt
lib:AddRecipe(19333, 23710, 19163) -- Molten Belt
lib:AddRecipe(19769, 24121, 19685) -- Primal Batskin Jerkin
lib:AddRecipe(19770, 24122, 19686) -- Primal Batskin Gloves
lib:AddRecipe(19771, 24123, 19687) -- Primal Batskin Bracers
lib:AddRecipe(19772, 24124, 19688) -- Blood Tiger Breastplate
lib:AddRecipe(19773, 24125, 19689) -- Blood Tiger Shoulders
lib:AddRecipe(20253, 19068, 15064) -- Warbear Harness
lib:AddRecipe(20254, 19080, 15065) -- Warbear Woolies
lib:AddRecipe(20382, 24703, 20380) -- Dreamscale Breastplate
lib:AddRecipe(20506, 24846, 20481) -- Spitfire Bracers
lib:AddRecipe(20507, 24847, 20480) -- Spitfire Gauntlets
lib:AddRecipe(20508, 24848, 20479) -- Spitfire Breastplate
lib:AddRecipe(20509, 24849, 20476) -- Sandstalker Bracers
lib:AddRecipe(20510, 24850, 20477) -- Sandstalker Gauntlets
lib:AddRecipe(20511, 24851, 20478) -- Sandstalker Breastplate
lib:AddRecipe(20576, 24940, 20575) -- Black Whelp Tunic
lib:AddRecipe(21548, 26279, 21278) -- Stormshroud Gloves
lib:AddRecipe(22769, 28474, 22761) -- Bramblewood Belt
lib:AddRecipe(22770, 28473, 22760) -- Bramblewood Boots
lib:AddRecipe(22771, 28472, 22759) -- Bramblewood Helm
lib:AddRecipe(25720, 32455, 23793) -- Heavy Knothide Leather
lib:AddRecipe(25721, 32457, 25651) -- Vindicator's Armor Kit
lib:AddRecipe(25722, 32458, 25652) -- Magister's Armor Kit
lib:AddRecipe(25725, 32461, 25653) -- Riding Crop
lib:AddRecipe(25726, 32482, 25679) -- Comfortable Insoles
lib:AddRecipe(25728, 32485, 25680) -- Stylin' Purple Hat
lib:AddRecipe(25729, 32487, 25681) -- Stylin' Adventure Hat
lib:AddRecipe(25730, 32489, 25682) -- Stylin' Jungle Hat
lib:AddRecipe(25731, 32488, 25683) -- Stylin' Crimson Hat
lib:AddRecipe(25732, 32490, 25685) -- Fel Leather Gloves
lib:AddRecipe(25733, 32493, 25686) -- Fel Leather Boots
lib:AddRecipe(25734, 32494, 25687) -- Fel Leather Leggings
lib:AddRecipe(25735, 32495, 25689) -- Heavy Clefthoof Vest
lib:AddRecipe(25736, 32496, 25690) -- Heavy Clefthoof Leggings
lib:AddRecipe(25737, 32497, 25691) -- Heavy Clefthoof Boots
lib:AddRecipe(25738, 32498, 25695) -- Felstalker Belt
lib:AddRecipe(25739, 32499, 25697) -- Felstalker Bracers
lib:AddRecipe(25740, 32500, 25696) -- Felstalker Breastplate
lib:AddRecipe(25741, 32501, 25694) -- Netherfury Belt
lib:AddRecipe(25742, 32502, 25692) -- Netherfury Leggings
lib:AddRecipe(25743, 32503, 25693) -- Netherfury Boots
lib:AddRecipe(29213, 32498, 25695) -- Felstalker Belt
lib:AddRecipe(29214, 32499, 25697) -- Felstalker Bracers
lib:AddRecipe(29215, 32500, 25696) -- Felstalker Breastplate
lib:AddRecipe(29217, 32501, 25694) -- Netherfury Belt
lib:AddRecipe(29218, 32503, 25693) -- Netherfury Boots
lib:AddRecipe(29219, 32502, 25692) -- Netherfury Leggings
lib:AddRecipe(29664, 35530, 29540) -- Reinforced Mining Bag
lib:AddRecipe(29677, 35525, 29489) -- Enchanted Felscale Leggings
lib:AddRecipe(29682, 35526, 29490) -- Enchanted Felscale Gloves
lib:AddRecipe(29684, 35527, 29491) -- Enchanted Felscale Boots
lib:AddRecipe(29689, 35529, 29492) -- Flamescale Leggings
lib:AddRecipe(29691, 35528, 29493) -- Flamescale Boots
lib:AddRecipe(29693, 35531, 29494) -- Flamescale Belt
lib:AddRecipe(29698, 35532, 29495) -- Enchanted Clefthoof Leggings
lib:AddRecipe(29700, 35533, 29496) -- Enchanted Clefthoof Gloves
lib:AddRecipe(29701, 35534, 29497) -- Enchanted Clefthoof Boots
lib:AddRecipe(29702, 35535, 29498) -- Blastguard Pants
lib:AddRecipe(29703, 35536, 29499) -- Blastguard Boots
lib:AddRecipe(29704, 35537, 29500) -- Blastguard Belt
lib:AddRecipe(29713, 35538, 29532) -- Drums of Panic
lib:AddRecipe(29714, 35539, 29531) -- Drums of Restoration
lib:AddRecipe(29717, 35543, 29529) -- Drums of Battle
lib:AddRecipe(29718, 35544, 29530) -- Drums of Speed
lib:AddRecipe(29719, 35549, 29533) -- Cobrahide Leg Armor
lib:AddRecipe(29720, 35555, 29534) -- Clefthide Leg Armor
lib:AddRecipe(29721, 35557, 29536) -- Nethercleft Leg Armor
lib:AddRecipe(29722, 35554, 29535) -- Nethercobra Leg Armor
lib:AddRecipe(29723, 35558, 29502) -- Cobrascale Hood
lib:AddRecipe(29724, 35559, 29503) -- Cobrascale Gloves
lib:AddRecipe(29725, 35560, 29504) -- Windscale Hood
lib:AddRecipe(29726, 35561, 29505) -- Hood of Primal Life
lib:AddRecipe(29727, 35562, 29506) -- Gloves of the Living Touch
lib:AddRecipe(29728, 35563, 29507) -- Windslayer Wraps
lib:AddRecipe(29729, 35564, 29508) -- Living Dragonscale Helm
lib:AddRecipe(29730, 35567, 29512) -- Earthen Netherscale Boots
lib:AddRecipe(29731, 35568, 29509) -- Windstrike Gloves
lib:AddRecipe(29732, 35572, 29510) -- Netherdrake Helm
lib:AddRecipe(29733, 35573, 29511) -- Netherdrake Gloves
lib:AddRecipe(29734, 35574, 29514) -- Thick Netherscale Breastplate
lib:AddRecipe(30301, 36349, 30042) -- Belt of Natural Power
lib:AddRecipe(30302, 36351, 30040) -- Belt of Deep Shadow
lib:AddRecipe(30303, 36352, 30046) -- Belt of the Black Eagle
lib:AddRecipe(30304, 36353, 30044) -- Monsoon Belt
lib:AddRecipe(30305, 36355, 30041) -- Boots of Natural Grace
lib:AddRecipe(30306, 36357, 30039) -- Boots of Utter Darkness
lib:AddRecipe(30307, 36358, 30045) -- Boots of the Crimson Hawk
lib:AddRecipe(30308, 36359, 30043) -- Hurricane Boots
lib:AddRecipe(30444, 35530, 29540) -- Reinforced Mining Bag
lib:AddRecipe(31361, 35549, 29533) -- Cobrahide Leg Armor
lib:AddRecipe(31362, 35554, 29535) -- Nethercobra Leg Armor
lib:AddRecipe(32429, 39997, 32398) -- Boots of Shackled Souls
lib:AddRecipe(32430, 52733, 32399) -- Bracers of Shackled Souls
lib:AddRecipe(32431, 40001, 32400) -- Greaves of Shackled Souls
lib:AddRecipe(32432, 40002, 32397) -- Waistguard of Shackled Souls
lib:AddRecipe(32433, 40003, 32394) -- Redeemed Soul Moccasins
lib:AddRecipe(32434, 40004, 32395) -- Redeemed Soul Wristguards
lib:AddRecipe(32435, 40005, 32396) -- Redeemed Soul Legguards
lib:AddRecipe(32436, 40006, 32393) -- Redeemed Soul Cinch
lib:AddRecipe(32744, 41156, 32582) -- Bracers of Renewed Life
lib:AddRecipe(32745, 41157, 32583) -- Shoulderpads of Renewed Life
lib:AddRecipe(32746, 41158, 32580) -- Swiftstrike Bracers
lib:AddRecipe(32747, 41160, 32581) -- Swiftstrike Shoulders
lib:AddRecipe(32748, 41161, 32574) -- Bindings of Lightning Reflexes
lib:AddRecipe(32749, 41162, 32575) -- Shoulders of Lightning Reflexes
lib:AddRecipe(32750, 41163, 32577) -- Living Earth Bindings
lib:AddRecipe(32751, 41164, 32579) -- Living Earth Shoulders
lib:AddRecipe(33124, 42546, 33122) -- Cloak of Darkness
lib:AddRecipe(33205, 42731, 33204) -- Shadowprowler's Chestguard
lib:AddRecipe(34172, 35544, 29530) -- Drums of Speed
lib:AddRecipe(34173, 35544, 29530) -- Drums of Speed
lib:AddRecipe(34174, 35539, 29531) -- Drums of Restoration
lib:AddRecipe(34175, 35539, 29531) -- Drums of Restoration
lib:AddRecipe(34262, 44953, 151791) -- Winter Boots
lib:AddRecipe(34491, 45117, 34490) -- Bag of Many Hides
lib:AddRecipe(35212, 46132, 34372) -- Leather Gauntlets of the Sun
lib:AddRecipe(35213, 46133, 34374) -- Fletcher's Gloves of the Phoenix
lib:AddRecipe(35214, 46134, 34370) -- Gloves of Immortal Dusk
lib:AddRecipe(35215, 46135, 34376) -- Sun-Drenched Scale Gloves
lib:AddRecipe(35216, 46136, 34371) -- Leather Chestguard of the Sun
lib:AddRecipe(35217, 46137, 34373) -- Embrace of the Phoenix
lib:AddRecipe(35218, 46138, 34369) -- Carapace of Sun and Shadow
lib:AddRecipe(35219, 46139, 34375) -- Sun-Drenched Scale Chestguard
lib:AddRecipe(35300, 35568, 29509) -- Windstrike Gloves
lib:AddRecipe(35301, 35573, 29511) -- Netherdrake Gloves
lib:AddRecipe(35302, 35559, 29503) -- Cobrascale Gloves
lib:AddRecipe(35303, 35562, 29506) -- Gloves of the Living Touch
lib:AddRecipe(44509, 50970, 38399) -- Trapper's Traveling Pack
lib:AddRecipe(44510, 50971, 38347) -- Mammoth Mining Bag
lib:AddRecipe(44513, 60697, 43260) -- Eviscerator's Facemask
lib:AddRecipe(44514, 60702, 43433) -- Eviscerator's Shoulderpads
lib:AddRecipe(44515, 60703, 43434) -- Eviscerator's Chestguard
lib:AddRecipe(44516, 60704, 43435) -- Eviscerator's Bindings
lib:AddRecipe(44517, 60705, 43436) -- Eviscerator's Gauntlets
lib:AddRecipe(44518, 60706, 43437) -- Eviscerator's Waistguard
lib:AddRecipe(44519, 60711, 43438) -- Eviscerator's Legguards
lib:AddRecipe(44520, 60712, 43439) -- Eviscerator's Treads
lib:AddRecipe(44521, 60715, 43261) -- Overcast Headguard
lib:AddRecipe(44522, 60716, 43262) -- Overcast Spaulders
lib:AddRecipe(44523, 60718, 43263) -- Overcast Chestguard
lib:AddRecipe(44524, 60720, 43264) -- Overcast Bracers
lib:AddRecipe(44525, 60721, 43265) -- Overcast Handwraps
lib:AddRecipe(44526, 60723, 43266) -- Overcast Belt
lib:AddRecipe(44527, 60725, 43271) -- Overcast Leggings
lib:AddRecipe(44528, 60727, 43273) -- Overcast Boots
lib:AddRecipe(44530, 60728, 43447) -- Swiftarrow Helm
lib:AddRecipe(44531, 60729, 43449) -- Swiftarrow Shoulderguards
lib:AddRecipe(44532, 60730, 43445) -- Swiftarrow Hauberk
lib:AddRecipe(44533, 60731, 43444) -- Swiftarrow Bracers
lib:AddRecipe(44534, 60732, 43446) -- Swiftarrow Gauntlets
lib:AddRecipe(44535, 60734, 43442) -- Swiftarrow Belt
lib:AddRecipe(44536, 60735, 43448) -- Swiftarrow Leggings
lib:AddRecipe(44537, 60737, 43443) -- Swiftarrow Boots
lib:AddRecipe(44538, 60743, 43455) -- Stormhide Crown
lib:AddRecipe(44539, 60746, 43457) -- Stormhide Shoulders
lib:AddRecipe(44540, 60747, 43453) -- Stormhide Hauberk
lib:AddRecipe(44541, 60748, 43452) -- Stormhide Wristguards
lib:AddRecipe(44542, 60749, 43454) -- Stormhide Grips
lib:AddRecipe(44543, 60750, 43450) -- Stormhide Belt
lib:AddRecipe(44544, 60751, 43456) -- Stormhide Legguards
lib:AddRecipe(44545, 60752, 43451) -- Stormhide Stompers
lib:AddRecipe(44546, 60754, 43458) -- Giantmaim Legguards
lib:AddRecipe(44547, 60755, 43459) -- Giantmaim Bracers
lib:AddRecipe(44548, 60756, 43461) -- Revenant's Breastplate
lib:AddRecipe(44549, 60757, 43469) -- Revenant's Treads
lib:AddRecipe(44550, 60758, 43481) -- Trollwoven Spaulders
lib:AddRecipe(44551, 60759, 43484) -- Trollwoven Girdle
lib:AddRecipe(44552, 60760, 43495) -- Earthgiving Legguards
lib:AddRecipe(44553, 60761, 43502) -- Earthgiving Boots
lib:AddRecipe(44584, 60996, 43590) -- Polar Vest
lib:AddRecipe(44585, 60997, 43591) -- Polar Cord
lib:AddRecipe(44586, 60998, 43592) -- Polar Boots
lib:AddRecipe(44587, 60999, 43593) -- Icy Scale Chestguard
lib:AddRecipe(44588, 61000, 43594) -- Icy Scale Belt
lib:AddRecipe(44589, 61002, 43595) -- Icy Scale Boots
lib:AddRecipe(44932, 62176, 44930) -- Windripper Boots
lib:AddRecipe(44933, 62177, 44931) -- Windripper Leggings
lib:AddRecipe(45094, 63194, 45553) -- Belt of Dragons
lib:AddRecipe(45095, 63195, 45562) -- Boots of Living Scale
lib:AddRecipe(45096, 63196, 45554) -- Blue Belt of Chaos
lib:AddRecipe(45097, 63197, 45563) -- Lightning Grounded Boots
lib:AddRecipe(45098, 63198, 45555) -- Death-warmed Belt
lib:AddRecipe(45099, 63199, 45564) -- Footpads of Silence
lib:AddRecipe(45100, 63200, 45556) -- Belt of Arctic Life
lib:AddRecipe(45101, 63201, 45565) -- Boots of Wintry Endurance
lib:AddRecipe(47628, 67080, 47597) -- Ensorcelled Nerubian Breastplate
lib:AddRecipe(47629, 67081, 47579) -- Black Chitin Bracers
lib:AddRecipe(47630, 67082, 47595) -- Crusader's Dragonscale Breastplate
lib:AddRecipe(47631, 67083, 47576) -- Crusader's Dragonscale Bracers
lib:AddRecipe(47632, 67084, 47602) -- Lunar Eclipse Robes
lib:AddRecipe(47633, 67085, 47583) -- Moonshadow Armguards
lib:AddRecipe(47634, 67086, 47599) -- Knightbane Carapace
lib:AddRecipe(47635, 67087, 47581) -- Bracers of Swift Death
lib:AddRecipe(47646, 67137, 47580) -- Black Chitin Bracers
lib:AddRecipe(47647, 67139, 47582) -- Bracers of Swift Death
lib:AddRecipe(47648, 67143, 47577) -- Crusader's Dragonscale Bracers
lib:AddRecipe(47649, 67138, 47596) -- Crusader's Dragonscale Breastplate
lib:AddRecipe(47650, 67136, 47598) -- Ensorcelled Nerubian Breastplate
lib:AddRecipe(47651, 67142, 47600) -- Knightbane Carapace
lib:AddRecipe(47652, 67140, 47601) -- Lunar Eclipse Robes
lib:AddRecipe(47653, 67141, 47584) -- Moonshadow Armguards
lib:AddRecipe(49957, 70554, 49898) -- Legwraps of Unleashed Nature
lib:AddRecipe(49958, 70555, 49894) -- Blessed Cenarion Boots
lib:AddRecipe(49959, 70556, 49899) -- Bladeborn Leggings
lib:AddRecipe(49961, 70557, 49895) -- Footpads of Impending Death
lib:AddRecipe(49962, 70558, 49900) -- Lightning-Infused Leggings
lib:AddRecipe(49963, 70559, 49896) -- Earthsoul Boots
lib:AddRecipe(49965, 70560, 49901) -- Draconic Bonesplinter Legguards
lib:AddRecipe(49966, 70561, 49897) -- Rock-Steady Treads
lib:AddRecipe(67042, 78444, 75106) -- Vicious Wyrmhide Bracers
lib:AddRecipe(67044, 78445, 75117) -- Vicious Wyrmhide Belt
lib:AddRecipe(67046, 78446, 75131) -- Vicious Leather Bracers
lib:AddRecipe(67048, 78447, 75104) -- Vicious Leather Gloves
lib:AddRecipe(67049, 78448, 75094) -- Vicious Charscale Bracers
lib:AddRecipe(67053, 78449, 75085) -- Vicious Charscale Gloves
lib:AddRecipe(67054, 78450, 75114) -- Vicious Dragonscale Bracers
lib:AddRecipe(67055, 78451, 75116) -- Vicious Dragonscale Shoulders
lib:AddRecipe(67056, 78452, 75109) -- Vicious Wyrmhide Gloves
lib:AddRecipe(67058, 78453, 75101) -- Vicious Wyrmhide Boots
lib:AddRecipe(67060, 78454, 75130) -- Vicious Leather Boots
lib:AddRecipe(67062, 78455, 75113) -- Vicious Leather Shoulders
lib:AddRecipe(67063, 78456, 75092) -- Vicious Charscale Boots
lib:AddRecipe(67064, 78457, 75083) -- Vicious Charscale Belt
lib:AddRecipe(67065, 78458, 75110) -- Vicious Dragonscale Boots
lib:AddRecipe(67066, 78459, 75081) -- Vicious Dragonscale Gloves
lib:AddRecipe(67068, 78460, 56536) -- Lightning Lash
lib:AddRecipe(67070, 78461, 56537) -- Belt of Nefarious Whispers
lib:AddRecipe(67072, 78462, 56538) -- Stormleather Sash
lib:AddRecipe(67073, 78463, 56539) -- Corded Viper Belt
lib:AddRecipe(67074, 78464, 75099) -- Vicious Wyrmhide Shoulders
lib:AddRecipe(67075, 78467, 75107) -- Vicious Wyrmhide Chest
lib:AddRecipe(67076, 78468, 75127) -- Vicious Leather Belt
lib:AddRecipe(67077, 78469, 75105) -- Vicious Leather Helm
lib:AddRecipe(67078, 78470, 75061) -- Vicious Charscale Shoulders
lib:AddRecipe(67079, 78471, 75097) -- Vicious Charscale Legs
lib:AddRecipe(67080, 78473, 75100) -- Vicious Dragonscale Belt
lib:AddRecipe(67081, 78474, 75102) -- Vicious Dragonscale Helm
lib:AddRecipe(67082, 78475, 56548) -- Razor-Edged Cloak
lib:AddRecipe(67083, 78476, 56549) -- Twilight Dragonscale Cloak
lib:AddRecipe(67084, 78478, 56551) -- Charscale Leg Armor
lib:AddRecipe(67085, 78479, 75080) -- Vicious Wyrmhide Legs
lib:AddRecipe(67086, 78480, 75111) -- Vicious Wyrmhide Helm
lib:AddRecipe(67087, 78481, 75103) -- Vicious Leather Chest
lib:AddRecipe(67089, 78482, 75112) -- Vicious Leather Legs
lib:AddRecipe(67090, 78483, 75084) -- Vicious Charscale Chest
lib:AddRecipe(67091, 78484, 75090) -- Vicious Charscale Helm
lib:AddRecipe(67092, 78485, 75108) -- Vicious Dragonscale Legs
lib:AddRecipe(67093, 78486, 75115) -- Vicious Dragonscale Chest
lib:AddRecipe(67094, 78487, 56561) -- Chestguard of Nature's Fury
lib:AddRecipe(67095, 78488, 56562) -- Assassin's Chestplate
lib:AddRecipe(67096, 78489, 56563) -- Twilight Scale Chestguard
lib:AddRecipe(67100, 78490, 56564) -- Dragonkiller Tunic
lib:AddRecipe(68193, 78477, 56550) -- Dragonscale Leg Armor
lib:AddRecipe(69960, 99443, 69939) -- Dragonfire Gloves
lib:AddRecipe(69961, 99445, 69941) -- Gloves of Unforgiving Flame
lib:AddRecipe(69962, 99446, 69942) -- Clutches of Evil
lib:AddRecipe(69963, 99447, 69943) -- Heavenly Gloves of the Moon
lib:AddRecipe(69971, 99455, 69949) -- Earthen Scale Sabatons
lib:AddRecipe(69972, 99456, 69950) -- Footwraps of Quenched Fire
lib:AddRecipe(69973, 99457, 69951) -- Treads of the Craft
lib:AddRecipe(69974, 99458, 69952) -- Ethereal Footfalls
lib:AddRecipe(70174, 100583, 70136) -- Royal Scribe's Satchel
lib:AddRecipe(70175, 100586, 70137) -- Triple-Reinforced Mining Bag
lib:AddRecipe(71721, 101599, 71720) -- Drakehide Leg Armor
lib:AddRecipe(71999, 101933, 71986) -- Leggings of Nature's Champion
lib:AddRecipe(72005, 101934, 71988) -- Deathscale Leggings
lib:AddRecipe(72006, 101935, 71985) -- Bladeshadow Leggings
lib:AddRecipe(72007, 101936, 71987) -- Rended Earth Leggings
lib:AddRecipe(72008, 101937, 71995) -- Bracers of Flowing Serenity
lib:AddRecipe(72009, 101939, 71997) -- Thundering Deathscale Wristguards
lib:AddRecipe(72010, 101940, 71994) -- Bladeshadow Wristguards
lib:AddRecipe(72011, 101941, 71996) -- Bracers of the Hunter-Killer
lib:AddRecipe(72025, 10542, 8204) -- Tough Scorpid Gloves
lib:AddRecipe(72026, 10533, 8205) -- Tough Scorpid Bracers
lib:AddRecipe(72027, 10564, 8207) -- Tough Scorpid Shoulders
lib:AddRecipe(72028, 10554, 8209) -- Tough Scorpid Boots
lib:AddRecipe(72029, 10525, 8203) -- Tough Scorpid Breastplate
lib:AddRecipe(72030, 10568, 8206) -- Tough Scorpid Leggings
lib:AddRecipe(72033, 10570, 8208) -- Tough Scorpid Helm
lib:AddRecipe(78345, 19060, 15046) -- Green Dragonscale Leggings
lib:AddRecipe(78346, 19050, 15045) -- Green Dragonscale Breastplate
lib:AddRecipe(86235, 124127, 83765) -- Angerhide Leg Armor
lib:AddRecipe(86237, 124625, 85787) -- Chestguard of Earthen Harmony
lib:AddRecipe(86238, 124638, 85788) -- Chestguard of Nemeses
lib:AddRecipe(86240, 124618, 85789) -- Contender's Dragonscale Belt
lib:AddRecipe(86241, 124617, 85790) -- Contender's Dragonscale Boots
lib:AddRecipe(86242, 124616, 85791) -- Contender's Dragonscale Bracers
lib:AddRecipe(86243, 124613, 85792) -- Contender's Dragonscale Chestguard
lib:AddRecipe(86244, 124614, 85793) -- Contender's Dragonscale Gloves
lib:AddRecipe(86245, 124611, 85794) -- Contender's Dragonscale Helm
lib:AddRecipe(86246, 124615, 85795) -- Contender's Dragonscale Leggings
lib:AddRecipe(86247, 124612, 85796) -- Contender's Dragonscale Shoulders
lib:AddRecipe(86248, 124610, 85797) -- Contender's Leather Belt
lib:AddRecipe(86249, 124609, 85798) -- Contender's Leather Boots
lib:AddRecipe(86250, 124608, 85799) -- Contender's Leather Bracers
lib:AddRecipe(86251, 124605, 85800) -- Contender's Leather Chestguard
lib:AddRecipe(86252, 124606, 85801) -- Contender's Leather Gloves
lib:AddRecipe(86253, 124603, 85802) -- Contender's Leather Helm
lib:AddRecipe(86254, 124607, 85803) -- Contender's Leather Leggings
lib:AddRecipe(86255, 124604, 85804) -- Contender's Leather Shoulders
lib:AddRecipe(86256, 124602, 85805) -- Contender's Scale Belt
lib:AddRecipe(86257, 124601, 85806) -- Contender's Scale Boots
lib:AddRecipe(86258, 124600, 85807) -- Contender's Scale Bracers
lib:AddRecipe(86259, 124597, 85808) -- Contender's Scale Chestguard
lib:AddRecipe(86260, 124598, 85809) -- Contender's Scale Gloves
lib:AddRecipe(86261, 124595, 85810) -- Contender's Scale Helm
lib:AddRecipe(86262, 124599, 85811) -- Contender's Scale Leggings
lib:AddRecipe(86263, 124596, 85812) -- Contender's Scale Shoulders
lib:AddRecipe(86264, 124594, 85813) -- Contender's Wyrmhide Belt
lib:AddRecipe(86265, 124593, 85814) -- Contender's Wyrmhide Boots
lib:AddRecipe(86266, 124592, 85815) -- Contender's Wyrmhide Bracers
lib:AddRecipe(86267, 124589, 85816) -- Contender's Wyrmhide Chestguard
lib:AddRecipe(86268, 124590, 85817) -- Contender's Wyrmhide Gloves
lib:AddRecipe(86269, 124587, 85818) -- Contender's Wyrmhide Helm
lib:AddRecipe(86270, 124591, 85819) -- Contender's Wyrmhide Leggings
lib:AddRecipe(86271, 124588, 85820) -- Contender's Wyrmhide Shoulders
lib:AddRecipe(86272, 124643, 85821) -- Fists of Lightning
lib:AddRecipe(86273, 124626, 85822) -- Gloves of Earthen Harmony
lib:AddRecipe(86274, 124619, 85823) -- Greyshadow Chestguard
lib:AddRecipe(86275, 124620, 85824) -- Greyshadow Gloves
lib:AddRecipe(86276, 124128, 83763) -- Ironscale Leg Armor
lib:AddRecipe(86277, 124624, 85825) -- Lifekeeper's Gloves
lib:AddRecipe(86278, 124623, 85826) -- Lifekeeper's Robe
lib:AddRecipe(86279, 124641, 85827) -- Liferuned Leather Gloves
lib:AddRecipe(86280, 124639, 85828) -- Murderer's Gloves
lib:AddRecipe(86281, 124640, 85829) -- Nightfire Robe
lib:AddRecipe(86283, 124644, 85830) -- Raiment of Blood and Bone
lib:AddRecipe(86284, 124645, 85831) -- Raven Lord's Gloves
lib:AddRecipe(86295, 124129, 83764) -- Shadowleather Leg Armor
lib:AddRecipe(86297, 124642, 85840) -- Stormbreaker Chestguard
lib:AddRecipe(86308, 124622, 85849) -- Wildblood Gloves
lib:AddRecipe(86309, 124621, 85850) -- Wildblood Vest
lib:AddRecipe(95467, 140040, 72163) -- Magnificence of Leather
lib:AddRecipe(95468, 140041, 72163) -- Magnificence of Scales
lib:AddRecipe(102513, 146613, 102351) -- Drums of Rage
lib:AddRecipe(116319, 171260, 116164) -- Journeying Helm
lib:AddRecipe(116320, 171261, 116165) -- Journeying Robes
lib:AddRecipe(116321, 171262, 116166) -- Journeying Slacks
lib:AddRecipe(116322, 171263, 116167) -- Traveling Helm
lib:AddRecipe(116323, 171264, 116168) -- Traveling Tunic
lib:AddRecipe(116324, 171265, 116169) -- Traveling Leggings
lib:AddRecipe(116325, 171266, 116170) -- Leather Refurbishing Kit
lib:AddRecipe(116326, 171267, 116171) -- Powerful Burnished Cloak
lib:AddRecipe(116327, 171268, 116174) -- Nimble Burnished Cloak
lib:AddRecipe(116328, 171269, 116175) -- Brilliant Burnished Cloak
lib:AddRecipe(116329, 171270, 116176) -- Supple Shoulderguards
lib:AddRecipe(116330, 171271, 116177) -- Supple Helm
lib:AddRecipe(116331, 171272, 116178) -- Supple Leggings
lib:AddRecipe(116332, 171273, 116179) -- Supple Gloves
lib:AddRecipe(116333, 171274, 116180) -- Supple Vest
lib:AddRecipe(116334, 171275, 116181) -- Supple Bracers
lib:AddRecipe(116335, 171276, 116182) -- Supple Boots
lib:AddRecipe(116336, 171277, 116183) -- Supple Waistguard
lib:AddRecipe(116337, 171278, 116187) -- Wayfaring Shoulderguards
lib:AddRecipe(116338, 171279, 116188) -- Wayfaring Helm
lib:AddRecipe(116339, 171280, 116189) -- Wayfaring Leggings
lib:AddRecipe(116340, 171281, 116190) -- Wayfaring Gloves
lib:AddRecipe(116341, 171282, 116191) -- Wayfaring Tunic
lib:AddRecipe(116342, 171283, 116192) -- Wayfaring Bracers
lib:AddRecipe(116343, 171284, 116193) -- Wayfaring Boots
lib:AddRecipe(116344, 171285, 116194) -- Wayfaring Belt
lib:AddRecipe(116347, 171288, 116259) -- Burnished Leather Bag
lib:AddRecipe(116348, 171289, 116260) -- Burnished Mining Bag
lib:AddRecipe(116349, 171290, 116261) -- Burnished Inscription Bag
lib:AddRecipe(116350, 171291, 108883) -- Riding Harness
lib:AddRecipe(120130, 176089, 118721) -- Secrets of Draenor Leatherworking
lib:AddRecipe(120258, 178208, 120257) -- Drums of Fury
lib:AddRecipe(122715, 182121, 110611) -- Spiritual Leathercraft
lib:AddRecipe(132123, 194739, 128895) -- Battlebound Warhelm
lib:AddRecipe(132124, 194741, 128893) -- Battlebound Treads
lib:AddRecipe(137868, 194703, 128883) -- Warhide Bindings
lib:AddRecipe(137869, 194704, 128882) -- Warhide Belt
lib:AddRecipe(137870, 194705, 128881) -- Warhide Shoulderguard
lib:AddRecipe(137871, 194706, 128880) -- Warhide Pants
lib:AddRecipe(137872, 194707, 128879) -- Warhide Mask
lib:AddRecipe(137873, 194708, 128878) -- Warhide Gloves
lib:AddRecipe(137874, 194709, 128877) -- Warhide Footpads
lib:AddRecipe(137875, 194710, 128876) -- Warhide Jerkin
lib:AddRecipe(137876, 194711, 128883) -- Warhide Bindings
lib:AddRecipe(137877, 194712, 128880) -- Warhide Pants
lib:AddRecipe(137878, 194713, 128879) -- Warhide Mask
lib:AddRecipe(137879, 194714, 128878) -- Warhide Gloves
lib:AddRecipe(137880, 194715, 128877) -- Warhide Footpads
lib:AddRecipe(137881, 194716, 128882) -- Warhide Belt
lib:AddRecipe(137882, 194717, 128881) -- Warhide Shoulderguard
lib:AddRecipe(137883, 194718, 128876) -- Warhide Jerkin
lib:AddRecipe(137884, 194719, 128891) -- Dreadleather Bindings
lib:AddRecipe(137885, 194720, 128890) -- Dreadleather Belt
lib:AddRecipe(137886, 194721, 128889) -- Dreadleather Shoulderguard
lib:AddRecipe(137887, 194722, 128888) -- Dreadleather Pants
lib:AddRecipe(137888, 194723, 128887) -- Dreadleather Mask
lib:AddRecipe(137889, 194724, 128886) -- Dreadleather Gloves
lib:AddRecipe(137890, 194725, 128885) -- Dreadleather Footpads
lib:AddRecipe(137891, 194726, 128884) -- Dreadleather Jerkin
lib:AddRecipe(137892, 194727, 128891) -- Dreadleather Bindings
lib:AddRecipe(137893, 194728, 128890) -- Dreadleather Belt
lib:AddRecipe(137894, 194729, 128889) -- Dreadleather Shoulderguard
lib:AddRecipe(137895, 194730, 128888) -- Dreadleather Pants
lib:AddRecipe(137896, 194731, 128887) -- Dreadleather Mask
lib:AddRecipe(137897, 194732, 128886) -- Dreadleather Gloves
lib:AddRecipe(137898, 194733, 128885) -- Dreadleather Footpads
lib:AddRecipe(137899, 194734, 128884) -- Dreadleather Jerkin
lib:AddRecipe(137900, 194743, 128899) -- Battlebound Armbands
lib:AddRecipe(137901, 194744, 128898) -- Battlebound Girdle
lib:AddRecipe(137902, 194745, 128897) -- Battlebound Spaulders
lib:AddRecipe(137903, 194746, 128896) -- Battlebound Leggings
lib:AddRecipe(137904, 194747, 128895) -- Battlebound Warhelm
lib:AddRecipe(137905, 194748, 128894) -- Battlebound Grips
lib:AddRecipe(137906, 194749, 128893) -- Battlebound Treads
lib:AddRecipe(137907, 194750, 128892) -- Battlebound Hauberk
lib:AddRecipe(137908, 194751, 128899) -- Battlebound Armbands
lib:AddRecipe(137909, 194752, 128896) -- Battlebound Leggings
lib:AddRecipe(137910, 194753, 128895) -- Battlebound Warhelm
lib:AddRecipe(137911, 194754, 128894) -- Battlebound Grips
lib:AddRecipe(137912, 194755, 128893) -- Battlebound Treads
lib:AddRecipe(137913, 194756, 128898) -- Battlebound Girdle
lib:AddRecipe(137914, 194757, 128897) -- Battlebound Spaulders
lib:AddRecipe(137915, 194758, 128892) -- Battlebound Hauberk
lib:AddRecipe(137916, 194759, 128907) -- Gravenscale Armbands
lib:AddRecipe(137917, 194760, 128906) -- Gravenscale Girdle
lib:AddRecipe(137918, 194761, 128905) -- Gravenscale Spaulders
lib:AddRecipe(137919, 194762, 128904) -- Gravenscale Leggings
lib:AddRecipe(137920, 194763, 128903) -- Gravenscale Warhelm
lib:AddRecipe(137921, 194764, 128902) -- Gravenscale Grips
lib:AddRecipe(137922, 194765, 128901) -- Gravenscale Treads
lib:AddRecipe(137923, 194766, 128900) -- Gravenscale Hauberk
lib:AddRecipe(137924, 194767, 128907) -- Gravenscale Armbands
lib:AddRecipe(137925, 194768, 128906) -- Gravenscale Girdle
lib:AddRecipe(137926, 194769, 128905) -- Gravenscale Spaulders
lib:AddRecipe(137927, 194770, 128904) -- Gravenscale Leggings
lib:AddRecipe(137928, 194771, 128903) -- Gravenscale Warhelm
lib:AddRecipe(137929, 194772, 128902) -- Gravenscale Grips
lib:AddRecipe(137930, 194773, 128901) -- Gravenscale Treads
lib:AddRecipe(137931, 194774, 128900) -- Gravenscale Hauberk
lib:AddRecipe(137932, 194775, 129961) -- Flaming Hoop
lib:AddRecipe(137933, 194776, 129960) -- Leather Pet Bed
lib:AddRecipe(137934, 194778, 129958) -- Leather Pet Leash
lib:AddRecipe(137935, 194779, 129956) -- Leather Love Seat
lib:AddRecipe(137952, 196648, 131746) -- Stonehide Leather Barding
lib:AddRecipe(140636, 194787, 128891) -- Dreadleather Bindings
lib:AddRecipe(140637, 194788, 128890) -- Dreadleather Belt
lib:AddRecipe(140638, 194789, 128889) -- Dreadleather Shoulderguard
lib:AddRecipe(140639, 194786, 128888) -- Dreadleather Pants
lib:AddRecipe(140640, 194784, 128887) -- Dreadleather Mask
lib:AddRecipe(140641, 194790, 128886) -- Dreadleather Gloves
lib:AddRecipe(140642, 194785, 128885) -- Dreadleather Footpads
lib:AddRecipe(140643, 194791, 128884) -- Dreadleather Jerkin
lib:AddRecipe(140644, 194796, 128907) -- Gravenscale Armbands
lib:AddRecipe(140645, 194797, 128906) -- Gravenscale Girdle
lib:AddRecipe(140646, 194798, 128905) -- Gravenscale Spaulders
lib:AddRecipe(140647, 194792, 128904) -- Gravenscale Leggings
lib:AddRecipe(140648, 194794, 128903) -- Gravenscale Warhelm
lib:AddRecipe(140649, 194799, 128902) -- Gravenscale Grips
lib:AddRecipe(140650, 194793, 128901) -- Gravenscale Treads
lib:AddRecipe(140651, 194795, 128900) -- Gravenscale Hauberk
lib:AddRecipe(141850, 194780, 129962) -- Elderhorn Riding Harness
lib:AddRecipe(142407, 230936, 142406) -- Drums of the Mountain
lib:AddRecipe(142408, 230954, 142406) -- Drums of the Mountain
lib:AddRecipe(142409, 230955, 142406) -- Drums of the Mountain
lib:AddRecipe(151740, 247800, 151577) -- Fiendish Shoulderguards
lib:AddRecipe(151741, 247801, 151577) -- Fiendish Shoulderguards
lib:AddRecipe(151742, 247802, 151577) -- Fiendish Shoulderguards
lib:AddRecipe(151743, 247803, 151578) -- Fiendish Spaulders
lib:AddRecipe(151744, 247804, 151578) -- Fiendish Spaulders
lib:AddRecipe(151745, 247805, 151578) -- Fiendish Spaulders
lib:AddRecipe(162388, 256767, 162468) -- Emblazoned Tempest Boots
lib:AddRecipe(162389, 256770, 162470) -- Emblazoned Tempest Leggings
lib:AddRecipe(162390, 269517, 159884) -- Honorable Combatant's Leather Treads
lib:AddRecipe(162391, 269518, 159884) -- Honorable Combatant's Leather Treads
lib:AddRecipe(162392, 269520, 159885) -- Honorable Combatant's Leather Gauntlets
lib:AddRecipe(162393, 269521, 159885) -- Honorable Combatant's Leather Gauntlets
lib:AddRecipe(162394, 269523, 159886) -- Honorable Combatant's Leather Leggings
lib:AddRecipe(162395, 269524, 159886) -- Honorable Combatant's Leather Leggings
lib:AddRecipe(162396, 269526, 159887) -- Honorable Combatant's Leather Waistguard
lib:AddRecipe(162397, 269527, 159887) -- Honorable Combatant's Leather Waistguard
lib:AddRecipe(162398, 269529, 159888) -- Honorable Combatant's Leather Armguards
lib:AddRecipe(162399, 269530, 159888) -- Honorable Combatant's Leather Armguards
lib:AddRecipe(162400, 256773, 162472) -- Emblazoned Mistscale Boots
lib:AddRecipe(162401, 256776, 162474) -- Emblazoned Mistscale Leggings
lib:AddRecipe(162402, 269532, 159889) -- Honorable Combatant's Mail Treads
lib:AddRecipe(162403, 269533, 159889) -- Honorable Combatant's Mail Treads
lib:AddRecipe(162404, 269535, 159890) -- Honorable Combatant's Mail Gauntlets
lib:AddRecipe(162405, 269536, 159890) -- Honorable Combatant's Mail Gauntlets
lib:AddRecipe(162406, 269538, 159891) -- Honorable Combatant's Mail Leggings
lib:AddRecipe(162407, 269539, 159891) -- Honorable Combatant's Mail Leggings
lib:AddRecipe(162408, 269541, 159892) -- Honorable Combatant's Mail Waistguard
lib:AddRecipe(162409, 269542, 159892) -- Honorable Combatant's Mail Waistguard
lib:AddRecipe(162410, 269544, 159893) -- Honorable Combatant's Mail Armguards
lib:AddRecipe(162411, 269545, 159893) -- Honorable Combatant's Mail Armguards
lib:AddRecipe(162412, 256789, 154159) -- Recurve Bow of the Strands
lib:AddRecipe(162413, 256781, 154162) -- Mistscale Knuckles
lib:AddRecipe(162414, 256784, 154163) -- Hardened Tempest Knuckles
lib:AddRecipe(162417, 269553, 159896) -- Honorable Combatant's Bow
lib:AddRecipe(162418, 269554, 159896) -- Honorable Combatant's Bow
lib:AddRecipe(162499, 256766, 162493) -- Imbued Tempest Boots
lib:AddRecipe(162500, 256767, 162468) -- Emblazoned Tempest Boots
lib:AddRecipe(162501, 256769, 162494) -- Imbued Tempest Leggings
lib:AddRecipe(162502, 256770, 162470) -- Emblazoned Tempest Leggings
lib:AddRecipe(162503, 256772, 162489) -- Imbued Mistscale Boots
lib:AddRecipe(162504, 256773, 162472) -- Emblazoned Mistscale Boots
lib:AddRecipe(162505, 256775, 162490) -- Imbued Mistscale Leggings
lib:AddRecipe(162506, 256776, 162474) -- Emblazoned Mistscale Leggings
lib:AddRecipe(162766, 256789, 154159) -- Recurve Bow of the Strands
lib:AddRecipe(162767, 256781, 154162) -- Mistscale Knuckles
lib:AddRecipe(162768, 256784, 154163) -- Hardened Tempest Knuckles
lib:AddRecipe(165310, 282328, 164658) -- Sinister Combatant's Leather Treads
lib:AddRecipe(165311, 282329, 164658) -- Sinister Combatant's Leather Treads
lib:AddRecipe(165312, 282325, 164659) -- Sinister Combatant's Leather Gauntlets
lib:AddRecipe(165313, 282326, 164659) -- Sinister Combatant's Leather Gauntlets
lib:AddRecipe(165314, 282322, 164660) -- Sinister Combatant's Leather Leggings
lib:AddRecipe(165315, 282323, 164660) -- Sinister Combatant's Leather Leggings
lib:AddRecipe(165316, 282319, 164661) -- Sinister Combatant's Leather Waistguard
lib:AddRecipe(165317, 282320, 164661) -- Sinister Combatant's Leather Waistguard
lib:AddRecipe(165318, 282313, 164662) -- Sinister Combatant's Leather Armguards
lib:AddRecipe(165319, 282314, 164662) -- Sinister Combatant's Leather Armguards
lib:AddRecipe(165320, 282310, 164663) -- Sinister Combatant's Mail Treads
lib:AddRecipe(165321, 282311, 164663) -- Sinister Combatant's Mail Treads
lib:AddRecipe(165322, 282307, 164664) -- Sinister Combatant's Mail Gauntlets
lib:AddRecipe(165323, 282308, 164664) -- Sinister Combatant's Mail Gauntlets
lib:AddRecipe(165324, 282303, 164665) -- Sinister Combatant's Mail Leggings
lib:AddRecipe(165325, 282305, 164665) -- Sinister Combatant's Mail Leggings
lib:AddRecipe(165326, 282291, 164666) -- Sinister Combatant's Mail Waistguard
lib:AddRecipe(165327, 282292, 164666) -- Sinister Combatant's Mail Waistguard
lib:AddRecipe(165328, 282288, 164667) -- Sinister Combatant's Mail Armguards
lib:AddRecipe(165329, 282289, 164667) -- Sinister Combatant's Mail Armguards
lib:AddRecipe(165330, 282278, 164670) -- Sinister Combatant's Bow
lib:AddRecipe(165331, 282281, 164670) -- Sinister Combatant's Bow
lib:AddRecipe(165644, 285091, 165416) -- Fortified Tempest Boots
lib:AddRecipe(165645, 285099, 165424) -- Tempered Tempest Boots
lib:AddRecipe(165646, 285092, 165391) -- Fortified Tempest Leggings
lib:AddRecipe(165647, 285100, 165399) -- Tempered Tempest Leggings
lib:AddRecipe(165648, 285087, 165412) -- Fortified Mistscale Boots
lib:AddRecipe(165649, 285095, 165420) -- Tempered Mistscale Boots
lib:AddRecipe(165650, 285088, 165388) -- Fortified Mistscale Greaves
lib:AddRecipe(165651, 285096, 165396) -- Tempered Mistscale Greaves
lib:AddRecipe(166312, 286019, 154166) -- Coarse Leather Barding
lib:AddRecipe(166313, 286021, 154166) -- Coarse Leather Barding
lib:AddRecipe(168028, 293076, 164978) -- Mallet of Thunderous Skins
lib:AddRecipe(168773, 299020, 168705) -- Reinforced Dredged Boots
lib:AddRecipe(168774, 299021, 168706) -- Banded Dredged Boots
lib:AddRecipe(168775, 299023, 168708) -- Reinforced Dredged Leggings
lib:AddRecipe(168776, 299024, 168709) -- Banded Dredged Leggings
lib:AddRecipe(168777, 299026, 168717) -- Reinforced Cragscale Boots
lib:AddRecipe(168778, 299027, 168718) -- Banded Cragscale Boots
lib:AddRecipe(168779, 299029, 168720) -- Reinforced Cragscale Greaves
lib:AddRecipe(168780, 299030, 168721) -- Banded Cragscale Greaves
lib:AddRecipe(169553, 294797, 167951) -- Notorious Combatant's Leather Treads
lib:AddRecipe(169554, 294798, 167951) -- Notorious Combatant's Leather Treads
lib:AddRecipe(169555, 294800, 167947) -- Notorious Combatant's Leather Gauntlets
lib:AddRecipe(169556, 294801, 167947) -- Notorious Combatant's Leather Gauntlets
lib:AddRecipe(169557, 294809, 167945) -- Notorious Combatant's Leather Armguards
lib:AddRecipe(169558, 294810, 167945) -- Notorious Combatant's Leather Armguards
lib:AddRecipe(169559, 294806, 167953) -- Notorious Combatant's Leather Waistguard
lib:AddRecipe(169560, 294807, 167953) -- Notorious Combatant's Leather Waistguard
lib:AddRecipe(169561, 294803, 167949) -- Notorious Combatant's Leather Leggings
lib:AddRecipe(169562, 294804, 167949) -- Notorious Combatant's Leather Leggings
lib:AddRecipe(169563, 294815, 167957) -- Notorious Combatant's Mail Gauntlets
lib:AddRecipe(169564, 294816, 167957) -- Notorious Combatant's Mail Gauntlets
lib:AddRecipe(169565, 294824, 167955) -- Notorious Combatant's Mail Armguards
lib:AddRecipe(169566, 294825, 167955) -- Notorious Combatant's Mail Armguards
lib:AddRecipe(169567, 294821, 167963) -- Notorious Combatant's Mail Waistguard
lib:AddRecipe(169568, 294822, 167963) -- Notorious Combatant's Mail Waistguard
lib:AddRecipe(169569, 294812, 167961) -- Notorious Combatant's Mail Treads
lib:AddRecipe(169570, 294813, 167961) -- Notorious Combatant's Mail Treads
lib:AddRecipe(169571, 294818, 167959) -- Notorious Combatant's Mail Leggings
lib:AddRecipe(169572, 294819, 167959) -- Notorious Combatant's Mail Leggings
lib:AddRecipe(169573, 294827, 167935) -- Notorious Combatant's Bow
lib:AddRecipe(169574, 294828, 167935) -- Notorious Combatant's Bow
lib:AddRecipe(170412, 304413, 170345) -- Uncanny Combatant's Leather Treads
lib:AddRecipe(170413, 304414, 170345) -- Uncanny Combatant's Leather Treads
lib:AddRecipe(170414, 304416, 170342) -- Uncanny Combatant's Leather Gauntlets
lib:AddRecipe(170415, 304417, 170342) -- Uncanny Combatant's Leather Gauntlets
lib:AddRecipe(170416, 304419, 170344) -- Uncanny Combatant's Leather Leggings
lib:AddRecipe(170417, 304420, 170344) -- Uncanny Combatant's Leather Leggings
lib:AddRecipe(170418, 304422, 170346) -- Uncanny Combatant's Leather Waistguard
lib:AddRecipe(170419, 304423, 170346) -- Uncanny Combatant's Leather Waistguard
lib:AddRecipe(170420, 304425, 170343) -- Uncanny Combatant's Leather Armguards
lib:AddRecipe(170421, 304426, 170343) -- Uncanny Combatant's Leather Armguards
lib:AddRecipe(170422, 304428, 170355) -- Uncanny Combatant's Mail Treads
lib:AddRecipe(170423, 304429, 170355) -- Uncanny Combatant's Mail Treads
lib:AddRecipe(170424, 304431, 170353) -- Uncanny Combatant's Mail Gauntlets
lib:AddRecipe(170425, 304432, 170353) -- Uncanny Combatant's Mail Gauntlets
lib:AddRecipe(170426, 304434, 170354) -- Uncanny Combatant's Mail Leggings
lib:AddRecipe(170427, 304435, 170354) -- Uncanny Combatant's Mail Leggings
lib:AddRecipe(170428, 304437, 170356) -- Uncanny Combatant's Mail Waistguard
lib:AddRecipe(170429, 304438, 170356) -- Uncanny Combatant's Mail Waistguard
lib:AddRecipe(170430, 304440, 170352) -- Uncanny Combatant's Mail Armguards
lib:AddRecipe(170431, 304441, 170352) -- Uncanny Combatant's Mail Armguards
lib:AddRecipe(170586, 304443, 170362) -- Uncanny Combatant's Bow
lib:AddRecipe(170587, 304444, 170362) -- Uncanny Combatant's Bow
lib:AddRecipe(171118, 305807, 170443) -- Eldritch Cragscale Greaves
lib:AddRecipe(171122, 305801, 170440) -- Eldritch Cragscale Boots
lib:AddRecipe(171123, 305802, 170439) -- Maddening Cragscale Boots
lib:AddRecipe(171124, 305799, 170437) -- Eldritch Dredged Leather Leggings
lib:AddRecipe(171125, 305798, 170436) -- Maddening Dredged Leather Leggings
lib:AddRecipe(171126, 305805, 170434) -- Eldritch Dredged Leather Boots
lib:AddRecipe(171127, 305795, 170433) -- Maddening Dredged Leather Boots
lib:AddRecipe(171128, 305806, 170442) -- Maddening Cragscale Greaves
lib:AddRecipe(174366, 305796, 170432) -- Unsettling Dredged Leather Boots
lib:AddRecipe(174367, 305804, 170435) -- Unsettling Dredged Leather Leggings
lib:AddRecipe(174368, 305803, 170438) -- Unsettling Cragscale Boots
lib:AddRecipe(174369, 305800, 170441) -- Unsettling Cragscale Greaves
lib:AddRecipe(183100, 324088, 172347) -- Heavy Desolate Armor Kit
lib:AddRecipe(183839, 308897, 172097) -- Heavy Callous Hide
lib:AddRecipe(183869, 343192, 173383) -- Crafter's Mark III
lib:AddRecipe(186998, 354797, 186686) -- Pallid Oracle Bones
lib:AddRecipe(186999, 354800, 186702) -- Pallid Bone Flute
lib:AddRecipe(187000, 355354, 186985) -- Elusive Pet Treat
lib:AddRecipe(193868, 375142, 193451) -- Slimy Expulsion Boots
lib:AddRecipe(193869, 375143, 193452) -- Toxic Thorn Footwraps
lib:AddRecipe(193870, 375157, 193464) -- Allied Legguards of Sansok Khan
lib:AddRecipe(193871, 375148, 193456) -- Infurious Spirit's Hood
lib:AddRecipe(193872, 375147, 193457) -- String of Spiritual Knick-Knacks
lib:AddRecipe(193873, 375145, 193454) -- Old Spirit's Wristwraps
lib:AddRecipe(193875, 375144, 193453) -- Allied Heartwarming Fur Coat
lib:AddRecipe(193876, 375146, 193458) -- Snowball Makers
lib:AddRecipe(193877, 375155, 193461) -- Infurious Boots of Reprieve
lib:AddRecipe(193878, 375153, 193459) -- Ancestor's Dew Drippers
lib:AddRecipe(193879, 375149, 193455) -- Infurious Footwraps of Indemnity
lib:AddRecipe(193880, 375152, 193463) -- Wind Spirit's Lasso
lib:AddRecipe(193881, 375154, 193465) -- Scale Rein Grips
lib:AddRecipe(193882, 375151, 193466) -- Acidic Hailstone Treads
lib:AddRecipe(193883, 375150, 193460) -- Venom-Steeped Stompers
lib:AddRecipe(193884, 375156, 193462) -- Infurious Chainhelm Protector
lib:AddRecipe(194311, 375172, 193478) -- Tuskarr Beanbag
lib:AddRecipe(194312, 375171, 193476) -- Gnoll Tent
lib:AddRecipe(197964, 375126, 193432) -- Crimson Combatant's Resilient Mask
lib:AddRecipe(197965, 375127, 193431) -- Crimson Combatant's Resilient Chestpiece
lib:AddRecipe(197966, 375128, 193435) -- Crimson Combatant's Resilient Trousers
lib:AddRecipe(197967, 375129, 193433) -- Crimson Combatant's Resilient Shoulderpads
lib:AddRecipe(197968, 375131, 193430) -- Crimson Combatant's Resilient Boots
lib:AddRecipe(197969, 375130, 193436) -- Crimson Combatant's Resilient Gloves
lib:AddRecipe(197970, 375132, 193437) -- Crimson Combatant's Resilient Wristwraps
lib:AddRecipe(197971, 375133, 193434) -- Crimson Combatant's Resilient Belt
lib:AddRecipe(197972, 375134, 193441) -- Crimson Combatant's Adamant Cowl
lib:AddRecipe(197973, 375135, 193440) -- Crimson Combatant's Adamant Chainmail
lib:AddRecipe(197974, 375136, 193444) -- Crimson Combatant's Adamant Leggings
lib:AddRecipe(197975, 375137, 193442) -- Crimson Combatant's Adamant Epaulets
lib:AddRecipe(197976, 375139, 193439) -- Crimson Combatant's Adamant Treads
lib:AddRecipe(197977, 375138, 193445) -- Crimson Combatant's Adamant Gauntlets
lib:AddRecipe(197978, 375140, 193446) -- Crimson Combatant's Adamant Cuffs
lib:AddRecipe(197979, 375141, 193443) -- Crimson Combatant's Adamant Girdle
lib:AddRecipe(197981, 381848, 197736) -- Finished Prototype Regal Barding
lib:AddRecipe(197982, 381849, 197735) -- Finished Prototype Explorer's Barding
lib:AddRecipe(198457, 375194, 193492) -- Masterwork Smock
lib:AddRecipe(198458, 375192, 193616) -- Resplendent Cover
lib:AddRecipe(198459, 375189, 193488) -- Lavish Floral Pack
lib:AddRecipe(198461, 375193, 193491) -- Shockproof Gloves
lib:AddRecipe(198462, 375195, 193613) -- Flameproof Apron
lib:AddRecipe(198463, 375196, 193493) -- Expert Alchemist's Hat
lib:AddRecipe(198464, 375190, 193489) -- Reinforced Pack
lib:AddRecipe(198465, 375191, 193490) -- Expert Skinner's Cap
lib:AddRecipe(198618, 381547, 197719) -- Artisan's Sign
lib:AddRecipe(200103, 375176, 193236) -- Infurious Hide
lib:AddRecipe(200104, 375180, 193248) -- Infurious Scales
lib:AddRecipe(201257, 375176, 193236) -- Infurious Hide
lib:AddRecipe(201259, 375180, 193248) -- Infurious Scales
lib:AddRecipe(201732, 375162, 193557) -- Fierce Armor Kit
lib:AddRecipe(201733, 375161, 193556) -- Frosted Armor Kit
lib:AddRecipe(202232, 397862, 202216) -- Impressive Burnished Essence
lib:AddRecipe(202233, 397863, 202217) -- Remarkable Burnished Essence
lib:AddRecipe(203427, 400814, 203414) -- Reinforced Pristine Leather
lib:AddRecipe(203842, 402143, 203799) -- Animist's Footwraps
lib:AddRecipe(203843, 402144, 203794) -- Animist's Legguards
lib:AddRecipe(203844, 402146, 203819) -- Gloves of the Tormentor
lib:AddRecipe(203845, 402147, 203814) -- Junglefury Gauntlets
lib:AddRecipe(203846, 402148, 203816) -- Junglefury Leggings
lib:AddRecipe(203847, 402150, 203805) -- Gurubashi's Grasp
lib:AddRecipe(203968, 402615, 203966) -- Cord of Shriveled Heads
lib:AddRecipe(204148, 403133, 204098) -- Obsidian Combatant's Resilient Mask
lib:AddRecipe(204149, 403134, 204097) -- Obsidian Combatant's Resilient Chestpiece
lib:AddRecipe(204150, 403135, 204101) -- Obsidian Combatant's Resilient Trousers
lib:AddRecipe(204151, 403136, 204099) -- Obsidian Combatant's Resilient Shoulderpads
lib:AddRecipe(204152, 403138, 204096) -- Obsidian Combatant's Resilient Boots
lib:AddRecipe(204153, 403137, 204102) -- Obsidian Combatant's Resilient Gloves
lib:AddRecipe(204154, 403139, 204103) -- Obsidian Combatant's Resilient Wristwraps
lib:AddRecipe(204155, 403140, 204100) -- Obsidian Combatant's Resilient Belt
lib:AddRecipe(204156, 403141, 204106) -- Obsidian Combatant's Adamant Cowl
lib:AddRecipe(204157, 403142, 204105) -- Obsidian Combatant's Adamant Chainmail
lib:AddRecipe(204158, 403143, 204109) -- Obsidian Combatant's Adamant Leggings
lib:AddRecipe(204159, 403144, 204107) -- Obsidian Combatant's Adamant Epaulets
lib:AddRecipe(204160, 403146, 204104) -- Obsidian Combatant's Adamant Treads
lib:AddRecipe(204161, 403145, 204110) -- Obsidian Combatant's Adamant Gauntlets
lib:AddRecipe(204162, 403147, 204111) -- Obsidian Combatant's Adamant Cuffs
lib:AddRecipe(204163, 403148, 204108) -- Obsidian Combatant's Adamant Girdle
lib:AddRecipe(204968, 406275, 204708) -- Shadowflame-Tempered Armor Patch
lib:AddRecipe(204969, 406266, 204706) -- Spore Colony Shoulderguards
lib:AddRecipe(204970, 406267, 204704) -- Adaptive Dracothyst Armguards
lib:AddRecipe(204974, 406214, 204700) -- Lambent Armor Kit
lib:AddRecipe(206403, 413496, 206434) -- Polar Helm
lib:AddRecipe(206404, 413497, 206433) -- Polar Spaulders
lib:AddRecipe(206405, 28219, 22661) -- Polar Tunic
lib:AddRecipe(206406, 28221, 22663) -- Polar Bracers
lib:AddRecipe(206407, 28220, 22662) -- Polar Gloves
lib:AddRecipe(206408, 413498, 206435) -- Polar Belt
lib:AddRecipe(206409, 413499, 206432) -- Polar Leggings
lib:AddRecipe(206410, 413500, 206436) -- Polar Footwarmers
lib:AddRecipe(206411, 413501, 206439) -- Icy Scale Crown
lib:AddRecipe(206412, 413502, 206438) -- Icy Scale Shoulderpads
lib:AddRecipe(206413, 28222, 22664) -- Icy Scale Breastplate
lib:AddRecipe(206414, 28224, 22665) -- Icy Scale Bracers
lib:AddRecipe(206415, 28223, 22666) -- Icy Scale Gauntlets
lib:AddRecipe(206416, 413503, 206440) -- Icy Scale Waistwrap
lib:AddRecipe(206417, 413504, 206437) -- Icy Scale Leggings
lib:AddRecipe(206418, 413505, 206441) -- Icy Scale Stompers
lib:AddRecipe(206529, 413516, 206482) -- Helm of Lingering Power
lib:AddRecipe(206530, 413517, 206483) -- Skyfury Headdress
lib:AddRecipe(206538, 413738, 206491) -- Nerubian Persuader
lib:AddRecipe(206556, 413756, 206509) -- Displacement Boots
lib:AddRecipe(206561, 413761, 206514) -- Lucien's Lost Soles
lib:AddRecipe(206772, 414565, 206646) -- Languished Leather
lib:AddRecipe(206773, 414566, 206647) -- Scourged Scales
lib:AddRecipe(207577, 416692, 207565) -- Sanctified Leather Hat
lib:AddRecipe(208291, 419006, 208241) -- Verdant Combatant's Resilient Mask
lib:AddRecipe(208292, 419007, 208240) -- Verdant Combatant's Resilient Chestpiece
lib:AddRecipe(208293, 419008, 208244) -- Verdant Combatant's Resilient Trousers
lib:AddRecipe(208294, 419009, 208242) -- Verdant Combatant's Resilient Shoulderpads
lib:AddRecipe(208295, 419011, 208239) -- Verdant Combatant's Resilient Boots
lib:AddRecipe(208296, 419010, 208245) -- Verdant Combatant's Resilient Gloves
lib:AddRecipe(208297, 419012, 208246) -- Verdant Combatant's Resilient Wristwraps
lib:AddRecipe(208298, 419013, 208243) -- Verdant Combatant's Resilient Belt
lib:AddRecipe(208299, 419014, 208249) -- Verdant Combatant's Adamant Cowl
lib:AddRecipe(208300, 419015, 208248) -- Verdant Combatant's Adamant Chainmail
lib:AddRecipe(208301, 419016, 208252) -- Verdant Combatant's Adamant Leggings
lib:AddRecipe(208302, 419017, 208250) -- Verdant Combatant's Adamant Epaulets
lib:AddRecipe(208303, 419019, 208247) -- Verdant Combatant's Adamant Treads
lib:AddRecipe(208304, 419018, 208253) -- Verdant Combatant's Adamant Gauntlets
lib:AddRecipe(208305, 419020, 208254) -- Verdant Combatant's Adamant Cuffs
lib:AddRecipe(208306, 419021, 208251) -- Verdant Combatant's Adamant Girdle
lib:AddRecipe(210169, 418579, 208187) -- Verdant Conduit
-- Mining
lib:AddRecipe(35273, 46353, 35128) -- Smelt Hardened Khorium
lib:AddRecipe(44956, 22967, 17771) -- Smelt Enchanted Elementium
-- Tailoring
lib:AddRecipe(2598, 2389, 2572) -- Red Linen Robe
lib:AddRecipe(2601, 2403, 2585) -- Gray Woolen Robe
lib:AddRecipe(4292, 3758, 4241) -- Green Woolen Bag
lib:AddRecipe(4345, 3847, 4313) -- Red Woolen Boots
lib:AddRecipe(4346, 3844, 4311) -- Heavy Woolen Cloak
lib:AddRecipe(4347, 3849, 4315) -- Reinforced Woolen Shoulders
lib:AddRecipe(4348, 3868, 4331) -- Phoenix Gloves
lib:AddRecipe(4349, 3851, 4317) -- Phoenix Pants
lib:AddRecipe(4350, 3856, 4321) -- Spider Silk Slippers
lib:AddRecipe(4351, 3858, 4323) -- Shadow Hood
lib:AddRecipe(4352, 3860, 4325) -- Boots of the Enchanter
lib:AddRecipe(4353, 3863, 4328) -- Spider Belt
lib:AddRecipe(4354, 3872, 4335) -- Rich Purple Silk Shirt
lib:AddRecipe(4355, 3862, 4327) -- Icy Cloak
lib:AddRecipe(4356, 3864, 4329) -- Star Belt
lib:AddRecipe(5771, 6686, 5762) -- Red Linen Bag
lib:AddRecipe(5772, 6688, 5763) -- Red Woolen Bag
lib:AddRecipe(5773, 6692, 5770) -- Robes of Arcana
lib:AddRecipe(5774, 6693, 5764) -- Green Silk Pack
lib:AddRecipe(5775, 6695, 5765) -- Black Silk Pack
lib:AddRecipe(6270, 7630, 6240) -- Blue Linen Vest
lib:AddRecipe(6271, 7629, 6239) -- Red Linen Vest
lib:AddRecipe(6272, 7633, 6242) -- Blue Linen Robe
lib:AddRecipe(6274, 7639, 6263) -- Blue Overalls
lib:AddRecipe(6275, 7643, 6264) -- Greater Adept's Robe
lib:AddRecipe(6390, 7892, 6384) -- Stylish Blue Shirt
lib:AddRecipe(6391, 7893, 6385) -- Stylish Green Shirt
lib:AddRecipe(6401, 3870, 4333) -- Dark Silk Shirt
lib:AddRecipe(7084, 8793, 7059) -- Crimson Silk Shoulders
lib:AddRecipe(7085, 8795, 7060) -- Azure Shoulders
lib:AddRecipe(7086, 8797, 7061) -- Earthen Silk Belt
lib:AddRecipe(7087, 8789, 7056) -- Crimson Silk Cloak
lib:AddRecipe(7088, 8802, 7063) -- Crimson Silk Robe
lib:AddRecipe(7089, 8786, 7053) -- Azure Silk Cloak
lib:AddRecipe(7090, 8784, 7065) -- Green Silk Armor
lib:AddRecipe(7091, 8782, 7049) -- Truefaith Gloves
lib:AddRecipe(7092, 8780, 7047) -- Hands of Darkness
lib:AddRecipe(7114, 3854, 4319) -- Azure Silk Gloves
lib:AddRecipe(10300, 12056, 10007) -- Red Mageweave Vest
lib:AddRecipe(10301, 12059, 10008) -- White Bandit Mask
lib:AddRecipe(10302, 12060, 10009) -- Red Mageweave Pants
lib:AddRecipe(10311, 12064, 10052) -- Orange Martial Shirt
lib:AddRecipe(10312, 12066, 10018) -- Red Mageweave Gloves
lib:AddRecipe(10314, 12075, 10054) -- Lavender Mageweave Shirt
lib:AddRecipe(10315, 12078, 10029) -- Red Mageweave Shoulders
lib:AddRecipe(10316, 12047, 10048) -- Colorful Kilt
lib:AddRecipe(10317, 12080, 10055) -- Pink Mageweave Shirt
lib:AddRecipe(10318, 12081, 10030) -- Admiral's Hat
lib:AddRecipe(10320, 12084, 10033) -- Red Mageweave Headband
lib:AddRecipe(10321, 12085, 10034) -- Tuxedo Shirt
lib:AddRecipe(10323, 12089, 10035) -- Tuxedo Pants
lib:AddRecipe(10325, 12091, 10040) -- White Wedding Dress
lib:AddRecipe(10326, 12093, 10036) -- Tuxedo Jacket
lib:AddRecipe(10463, 12086, 10025) -- Shadoweave Mask
lib:AddRecipe(10728, 3873, 4336) -- Black Swashbuckler's Shirt
lib:AddRecipe(14466, 18403, 13869) -- Frostweave Tunic
lib:AddRecipe(14467, 18404, 13868) -- Frostweave Robe
lib:AddRecipe(14468, 18405, 14046) -- Runecloth Bag
lib:AddRecipe(14470, 18407, 13857) -- Runecloth Tunic
lib:AddRecipe(14471, 18408, 14042) -- Cindercloth Vest
lib:AddRecipe(14474, 18411, 13870) -- Frostweave Gloves
lib:AddRecipe(14476, 18412, 14043) -- Cindercloth Gloves
lib:AddRecipe(14482, 18418, 14044) -- Cindercloth Cloak
lib:AddRecipe(14483, 18419, 14107) -- Felcloth Pants
lib:AddRecipe(14486, 18422, 14134) -- Cloak of Fire
lib:AddRecipe(14488, 18423, 13864) -- Runecloth Boots
lib:AddRecipe(14489, 18424, 13871) -- Frostweave Pants
lib:AddRecipe(14490, 18434, 14045) -- Cindercloth Pants
lib:AddRecipe(14492, 18437, 14108) -- Felcloth Boots
lib:AddRecipe(14493, 18436, 14136) -- Robe of Winter Night
lib:AddRecipe(14494, 18439, 14104) -- Brightcloth Pants
lib:AddRecipe(14496, 18442, 14111) -- Felcloth Hood
lib:AddRecipe(14497, 18440, 14137) -- Mooncloth Leggings
lib:AddRecipe(14499, 18445, 14155) -- Mooncloth Bag
lib:AddRecipe(14501, 18447, 14138) -- Mooncloth Vest
lib:AddRecipe(14506, 18451, 14106) -- Felcloth Robe
lib:AddRecipe(14507, 18448, 14139) -- Mooncloth Shoulders
lib:AddRecipe(14508, 18453, 14112) -- Felcloth Shoulders
lib:AddRecipe(14509, 18452, 14140) -- Mooncloth Circlet
lib:AddRecipe(14510, 18455, 14156) -- Bottomless Bag
lib:AddRecipe(14511, 18454, 14146) -- Gloves of Spell Mastery
lib:AddRecipe(14512, 18456, 14154) -- Truefaith Vestments
lib:AddRecipe(14513, 18457, 14152) -- Robe of the Archmage
lib:AddRecipe(14514, 18458, 14153) -- Robe of the Void
lib:AddRecipe(14526, 18560, 14342) -- Mooncloth
lib:AddRecipe(14627, 3869, 4332) -- Bright Yellow Shirt
lib:AddRecipe(14630, 3857, 4322) -- Enchanter's Cowl
lib:AddRecipe(16112, 7929, 6451) -- Heavy Silk Bandage
lib:AddRecipe(16113, 10840, 8544) -- Mageweave Bandage
lib:AddRecipe(17017, 20848, 16980) -- Flarecore Mantle
lib:AddRecipe(17018, 20849, 16979) -- Flarecore Gloves
lib:AddRecipe(17724, 21945, 17723) -- Green Holiday Shirt
lib:AddRecipe(18265, 22759, 18263) -- Flarecore Wraps
lib:AddRecipe(18414, 22866, 18405) -- Belt of the Archmage
lib:AddRecipe(18415, 22867, 18407) -- Felcloth Gloves
lib:AddRecipe(18416, 22868, 18408) -- Inferno Gloves
lib:AddRecipe(18417, 22869, 18409) -- Mooncloth Gloves
lib:AddRecipe(18418, 22870, 18413) -- Cloak of Warding
lib:AddRecipe(18487, 22902, 18486) -- Mooncloth Robe
lib:AddRecipe(19215, 23662, 19047) -- Wisdom of the Timbermaw
lib:AddRecipe(19216, 23664, 19056) -- Argent Boots
lib:AddRecipe(19217, 23665, 19059) -- Argent Shoulders
lib:AddRecipe(19218, 23663, 19050) -- Mantle of the Timbermaw
lib:AddRecipe(19219, 23666, 19156) -- Flarecore Robe
lib:AddRecipe(19220, 23667, 19165) -- Flarecore Leggings
lib:AddRecipe(19764, 24091, 19682) -- Bloodvine Vest
lib:AddRecipe(19765, 24092, 19683) -- Bloodvine Leggings
lib:AddRecipe(19766, 24093, 19684) -- Bloodvine Boots
lib:AddRecipe(20546, 24901, 20538) -- Runed Stygian Leggings
lib:AddRecipe(20547, 24903, 20537) -- Runed Stygian Boots
lib:AddRecipe(20548, 24902, 20539) -- Runed Stygian Belt
lib:AddRecipe(21358, 26085, 21340) -- Soul Pouch
lib:AddRecipe(21371, 26087, 21342) -- Core Felcloth Bag
lib:AddRecipe(21722, 26403, 151771) -- Festival Dress
lib:AddRecipe(21723, 26407, 151772) -- Festival Suit
lib:AddRecipe(21892, 26747, 21842) -- Bolt of Imbued Netherweave
lib:AddRecipe(21893, 26749, 21843) -- Imbued Netherweave Bag
lib:AddRecipe(21894, 26750, 21844) -- Bolt of Soulcloth
lib:AddRecipe(21895, 26751, 21845) -- Primal Mooncloth
lib:AddRecipe(21896, 26773, 21854) -- Netherweave Robe
lib:AddRecipe(21897, 26774, 21855) -- Netherweave Tunic
lib:AddRecipe(21898, 26775, 21859) -- Imbued Netherweave Pants
lib:AddRecipe(21899, 26776, 21860) -- Imbued Netherweave Boots
lib:AddRecipe(21900, 26777, 21861) -- Imbued Netherweave Robe
lib:AddRecipe(21901, 26778, 21862) -- Imbued Netherweave Tunic
lib:AddRecipe(21902, 26779, 21863) -- Soulcloth Gloves
lib:AddRecipe(21903, 26780, 21864) -- Soulcloth Shoulders
lib:AddRecipe(21904, 26781, 21865) -- Soulcloth Vest
lib:AddRecipe(21905, 26782, 21866) -- Arcanoweave Bracers
lib:AddRecipe(21906, 26783, 21867) -- Arcanoweave Boots
lib:AddRecipe(21907, 26784, 21868) -- Arcanoweave Robe
lib:AddRecipe(21908, 26752, 21846) -- Spellfire Belt
lib:AddRecipe(21909, 26753, 21847) -- Spellfire Gloves
lib:AddRecipe(21910, 26754, 21848) -- Spellfire Robe
lib:AddRecipe(21911, 26755, 21858) -- Spellfire Bag
lib:AddRecipe(21912, 26756, 21869) -- Frozen Shadoweave Shoulders
lib:AddRecipe(21913, 26758, 21871) -- Frozen Shadoweave Robe
lib:AddRecipe(21914, 26757, 21870) -- Frozen Shadoweave Boots
lib:AddRecipe(21915, 26759, 21872) -- Ebon Shadowbag
lib:AddRecipe(21916, 26760, 21873) -- Primal Mooncloth Belt
lib:AddRecipe(21917, 26762, 21875) -- Primal Mooncloth Robe
lib:AddRecipe(21918, 26761, 21874) -- Primal Mooncloth Shoulders
lib:AddRecipe(21919, 26763, 21876) -- Primal Mooncloth Bag
lib:AddRecipe(21992, 27032, 21990) -- Netherweave Bandage
lib:AddRecipe(21993, 27033, 21991) -- Heavy Netherweave Bandage
lib:AddRecipe(22307, 27658, 22246) -- Enchanted Mageweave Pouch
lib:AddRecipe(22308, 27659, 22248) -- Enchanted Runecloth Bag
lib:AddRecipe(22309, 27660, 22249) -- Big Bag of Enchantment
lib:AddRecipe(22310, 27724, 22251) -- Cenarion Herb Bag
lib:AddRecipe(22312, 27725, 22252) -- Satchel of Cenarius
lib:AddRecipe(22683, 28210, 22660) -- Gaea's Embrace
lib:AddRecipe(22772, 28482, 22758) -- Sylvan Shoulders
lib:AddRecipe(22773, 28481, 22757) -- Sylvan Crown
lib:AddRecipe(22774, 28480, 22756) -- Sylvan Vest
lib:AddRecipe(24292, 31430, 24273) -- Mystic Spellthread
lib:AddRecipe(24293, 31431, 24275) -- Silver Spellthread
lib:AddRecipe(24294, 31432, 24274) -- Runic Spellthread
lib:AddRecipe(24295, 31433, 24276) -- Golden Spellthread
lib:AddRecipe(24296, 31434, 24249) -- Unyielding Bracers
lib:AddRecipe(24297, 31435, 24250) -- Bracers of Havok
lib:AddRecipe(24298, 31437, 24251) -- Blackstrike Bracers
lib:AddRecipe(24299, 31438, 24252) -- Cloak of the Black Void
lib:AddRecipe(24300, 31440, 24253) -- Cloak of Eternity
lib:AddRecipe(24301, 31441, 24254) -- White Remedy Cape
lib:AddRecipe(24302, 31442, 24255) -- Unyielding Girdle
lib:AddRecipe(24303, 31443, 24256) -- Girdle of Ruination
lib:AddRecipe(24304, 31444, 24257) -- Black Belt of Knowledge
lib:AddRecipe(24305, 31448, 24258) -- Resolute Cape
lib:AddRecipe(24306, 31449, 24259) -- Vengeance Wrap
lib:AddRecipe(24307, 31450, 24260) -- Manaweave Cloak
lib:AddRecipe(24308, 31451, 24261) -- Whitemend Pants
lib:AddRecipe(24309, 31452, 24262) -- Spellstrike Pants
lib:AddRecipe(24310, 31453, 24263) -- Battlecast Pants
lib:AddRecipe(24311, 31454, 24264) -- Whitemend Hood
lib:AddRecipe(24312, 31455, 24266) -- Spellstrike Hood
lib:AddRecipe(24313, 31456, 24267) -- Battlecast Hood
lib:AddRecipe(24314, 31459, 24270) -- Bag of Jewels
lib:AddRecipe(24316, 31373, 24271) -- Spellcloth
lib:AddRecipe(30280, 36315, 30038) -- Belt of Blasting
lib:AddRecipe(30281, 36316, 30036) -- Belt of the Long Road
lib:AddRecipe(30282, 36317, 30037) -- Boots of Blasting
lib:AddRecipe(30283, 36318, 30035) -- Boots of the Long Road
lib:AddRecipe(30483, 36686, 24272) -- Shadowcloth
lib:AddRecipe(30833, 37873, 30831) -- Cloak of Arcane Evasion
lib:AddRecipe(30842, 37882, 30837) -- Flameheart Bracers
lib:AddRecipe(30843, 37883, 30838) -- Flameheart Gloves
lib:AddRecipe(30844, 37884, 30839) -- Flameheart Vest
lib:AddRecipe(32437, 40020, 32391) -- Soulguard Slippers
lib:AddRecipe(32438, 40021, 32392) -- Soulguard Bracers
lib:AddRecipe(32439, 40023, 32389) -- Soulguard Leggings
lib:AddRecipe(32440, 40024, 32390) -- Soulguard Girdle
lib:AddRecipe(32447, 40060, 32420) -- Night's End
lib:AddRecipe(32752, 41207, 32584) -- Swiftheal Wraps
lib:AddRecipe(32753, 41208, 32585) -- Swiftheal Mantle
lib:AddRecipe(32754, 41205, 32586) -- Bracers of Nimble Thought
lib:AddRecipe(32755, 41206, 32587) -- Mantle of Nimble Thought
lib:AddRecipe(34261, 44950, 151792) -- Green Winter Clothes
lib:AddRecipe(34319, 44958, 151790) -- Red Winter Clothes
lib:AddRecipe(35204, 46128, 34366) -- Sunfire Handwraps
lib:AddRecipe(35205, 46129, 34367) -- Hands of Eternal Light
lib:AddRecipe(35206, 46130, 34364) -- Sunfire Robe
lib:AddRecipe(35207, 46131, 34365) -- Robe of Eternal Light
lib:AddRecipe(35308, 31434, 24249) -- Unyielding Bracers
lib:AddRecipe(35309, 31442, 24255) -- Unyielding Girdle
lib:AddRecipe(37915, 49677, 6836) -- Dress Shoes
lib:AddRecipe(38229, 50194, 38225) -- Mycah's Botanical Bag
lib:AddRecipe(38327, 50644, 38277) -- Haliscan Jacket
lib:AddRecipe(38328, 50647, 38278) -- Haliscan Pantaloons
lib:AddRecipe(39152, 45546, 34722) -- Heavy Frostweave Bandage
lib:AddRecipe(42172, 55993, 41248) -- Red Lumberjack Shirt
lib:AddRecipe(42173, 55994, 41249) -- Blue Lumberjack Shirt
lib:AddRecipe(42175, 55996, 41250) -- Green Lumberjack Shirt
lib:AddRecipe(42176, 55998, 41253) -- Blue Workman's Shirt
lib:AddRecipe(42177, 55997, 41252) -- Red Workman's Shirt
lib:AddRecipe(42178, 55999, 41254) -- Rustic Workman's Shirt
lib:AddRecipe(42183, 56004, 41597) -- Abyssal Bag
lib:AddRecipe(42184, 56005, 41600) -- Glacial Bag
lib:AddRecipe(42185, 56006, 41598) -- Mysterious Bag
lib:AddRecipe(42187, 56009, 41602) -- Brilliant Spellthread
lib:AddRecipe(42188, 56011, 41604) -- Sapphire Spellthread
lib:AddRecipe(44916, 26403, 151771) -- Festival Dress
lib:AddRecipe(44917, 26407, 151772) -- Festival Suit
lib:AddRecipe(45102, 63203, 45557) -- Sash of Ancient Power
lib:AddRecipe(45103, 63204, 45566) -- Spellslinger's Slippers
lib:AddRecipe(45104, 63205, 45558) -- Cord of the White Dawn
lib:AddRecipe(45105, 63206, 45567) -- Savior's Slippers
lib:AddRecipe(45774, 63924, 45773) -- Emerald Bag
lib:AddRecipe(47636, 67144, 47606) -- Royal Moonshroud Robe
lib:AddRecipe(47637, 67147, 47588) -- Royal Moonshroud Bracers
lib:AddRecipe(47638, 67146, 47604) -- Merlin's Robe
lib:AddRecipe(47639, 67145, 47586) -- Bejeweled Wizard's Bracers
lib:AddRecipe(47654, 67079, 47585) -- Bejeweled Wizard's Bracers
lib:AddRecipe(47655, 67066, 47603) -- Merlin's Robe
lib:AddRecipe(47656, 67065, 47587) -- Royal Moonshroud Bracers
lib:AddRecipe(47657, 67064, 47605) -- Royal Moonshroud Robe
lib:AddRecipe(49953, 70550, 49891) -- Leggings of Woven Death
lib:AddRecipe(49954, 70551, 49890) -- Deathfrost Boots
lib:AddRecipe(49955, 70552, 49892) -- Lightweave Leggings
lib:AddRecipe(49956, 70553, 49893) -- Sandals of Consecration
lib:AddRecipe(54593, 75306, 75073) -- Vicious Embersilk Cowl
lib:AddRecipe(54594, 75307, 75072) -- Vicious Embersilk Pants
lib:AddRecipe(54595, 75305, 75093) -- Vicious Embersilk Robe
lib:AddRecipe(54596, 75304, 75062) -- Vicious Fireweave Cowl
lib:AddRecipe(54597, 75302, 75082) -- Vicious Fireweave Pants
lib:AddRecipe(54598, 75303, 75088) -- Vicious Fireweave Robe
lib:AddRecipe(54599, 75309, 54448) -- Powerful Enchanted Spellthread
lib:AddRecipe(54600, 75310, 54450) -- Powerful Ghostly Spellthread
lib:AddRecipe(54601, 75298, 54504) -- Belt of the Depths
lib:AddRecipe(54602, 75299, 54503) -- Dreamless Belt
lib:AddRecipe(54603, 75300, 54505) -- Breeches of Mended Nightmares
lib:AddRecipe(54604, 75301, 54506) -- Flame-Ascended Pantaloons
lib:AddRecipe(54605, 75308, 54444) -- Illusionary Bag
lib:AddRecipe(54798, 75597, 54797) -- Frosty Flying Carpet
lib:AddRecipe(67541, 75289, 54451) -- High Society Top Hat
lib:AddRecipe(68199, 75288, 54441) -- Black Embersilk Gown
lib:AddRecipe(69965, 99448, 69944) -- Grips of Altered Reality
lib:AddRecipe(69966, 99449, 69945) -- Don Tayo's Inferno Mittens
lib:AddRecipe(69975, 99459, 69953) -- Endless Dream Walkers
lib:AddRecipe(69976, 99460, 69954) -- Boots of the Black Flame
lib:AddRecipe(70176, 100585, 70138) -- Luxurious Silk Gem Bag
lib:AddRecipe(72000, 101920, 71981) -- World Mender's Pants
lib:AddRecipe(72002, 101921, 71980) -- Lavaquake Legwraps
lib:AddRecipe(72003, 101922, 71990) -- Dreamwraps of the Light
lib:AddRecipe(72004, 101923, 71989) -- Bracers of Unconquered Power
lib:AddRecipe(86352, 125531, 82421) -- Contender's Silk Cowl
lib:AddRecipe(86353, 125532, 82422) -- Contender's Silk Amice
lib:AddRecipe(86354, 125533, 82423) -- Contender's Silk Raiment
lib:AddRecipe(86355, 125534, 82424) -- Contender's Silk Handwraps
lib:AddRecipe(86356, 125535, 82425) -- Contender's Silk Pants
lib:AddRecipe(86357, 125536, 82426) -- Contender's Silk Cuffs
lib:AddRecipe(86358, 125537, 82427) -- Contender's Silk Footwraps
lib:AddRecipe(86359, 125538, 82428) -- Contender's Silk Belt
lib:AddRecipe(86360, 125539, 82429) -- Contender's Satin Cowl
lib:AddRecipe(86361, 125540, 82430) -- Contender's Satin Amice
lib:AddRecipe(86362, 125541, 82431) -- Contender's Satin Raiment
lib:AddRecipe(86363, 125542, 82432) -- Contender's Satin Handwraps
lib:AddRecipe(86364, 125543, 82433) -- Contender's Satin Pants
lib:AddRecipe(86365, 125544, 82434) -- Contender's Satin Cuffs
lib:AddRecipe(86366, 125545, 82435) -- Contender's Satin Footwraps
lib:AddRecipe(86367, 125546, 82436) -- Contender's Satin Belt
lib:AddRecipe(86368, 125547, 82437) -- Spelltwister's Grand Robe
lib:AddRecipe(86369, 125548, 82438) -- Spelltwister's Gloves
lib:AddRecipe(86370, 125549, 82439) -- Robes of Creation
lib:AddRecipe(86371, 125550, 82440) -- Gloves of Creation
lib:AddRecipe(86375, 125554, 82444) -- Greater Pearlescent Spellthread
lib:AddRecipe(86376, 125555, 82445) -- Greater Cerulean Spellthread
lib:AddRecipe(86377, 125556, 82446) -- Royal Satchel
lib:AddRecipe(86379, 125558, 86311) -- Robe of Eternal Rule
lib:AddRecipe(86380, 125559, 86313) -- Imperial Silk Gloves
lib:AddRecipe(86381, 125560, 86312) -- Legacy of the Emperor
lib:AddRecipe(86382, 125561, 86314) -- Touch of the Light
lib:AddRecipe(114851, 168835, 111556) -- Hexweave Cloth
lib:AddRecipe(114852, 168836, 114836) -- Hexweave Embroidery
lib:AddRecipe(114853, 168837, 114809) -- Hexweave Mantle
lib:AddRecipe(114854, 168838, 114810) -- Hexweave Cowl
lib:AddRecipe(114855, 168839, 114811) -- Hexweave Leggings
lib:AddRecipe(114856, 168840, 114812) -- Hexweave Gloves
lib:AddRecipe(114857, 168841, 114813) -- Hexweave Robe
lib:AddRecipe(114858, 168842, 114814) -- Hexweave Bracers
lib:AddRecipe(114859, 168843, 114815) -- Hexweave Slippers
lib:AddRecipe(114860, 168844, 114816) -- Hexweave Belt
lib:AddRecipe(114861, 168845, 114817) -- Powerful Hexweave Cloak
lib:AddRecipe(114862, 168846, 114818) -- Nimble Hexweave Cloak
lib:AddRecipe(114863, 168847, 114819) -- Brilliant Hexweave Cloak
lib:AddRecipe(114864, 168848, 114821) -- Hexweave Bag
lib:AddRecipe(114865, 168849, 113216) -- Elekk Plushie
lib:AddRecipe(114866, 168850, 115363) -- Creeping Carpet
lib:AddRecipe(114868, 168852, 114828) -- Sumptuous Cowl
lib:AddRecipe(114869, 168853, 114829) -- Sumptuous Robes
lib:AddRecipe(114870, 168854, 114831) -- Sumptuous Leggings
lib:AddRecipe(120128, 176058, 118722) -- Secrets of Draenor Tailoring
lib:AddRecipe(122716, 182123, 111556) -- Primal Weaving
lib:AddRecipe(127022, 185927, 127001) -- Imbued Silkweave Cinch
lib:AddRecipe(127023, 185928, 127000) -- Imbued Silkweave Epaulets
lib:AddRecipe(127024, 185929, 126999) -- Imbued Silkweave Pantaloons
lib:AddRecipe(127025, 185930, 126998) -- Imbued Silkweave Hood
lib:AddRecipe(127026, 185931, 126997) -- Imbued Silkweave Gloves
lib:AddRecipe(127027, 185932, 126996) -- Imbued Silkweave Slippers
lib:AddRecipe(127028, 185933, 126995) -- Imbued Silkweave Robe
lib:AddRecipe(127277, 186112, 127019) -- Imbued Silkweave Cover
lib:AddRecipe(127278, 186115, 127020) -- Imbued Silkweave Drape
lib:AddRecipe(127279, 186106, 127033) -- Imbued Silkweave Shade
lib:AddRecipe(127280, 186109, 127034) -- Imbued Silkweave Flourish
lib:AddRecipe(137681, 220511, 139503) -- Bloodtotem Saddle Blanket
lib:AddRecipe(137953, 185934, 126994) -- Silkweave Bracers
lib:AddRecipe(137954, 185935, 126993) -- Silkweave Cinch
lib:AddRecipe(137955, 185936, 126992) -- Silkweave Epaulets
lib:AddRecipe(137956, 185937, 126991) -- Silkweave Pantaloons
lib:AddRecipe(137957, 185938, 126990) -- Silkweave Hood
lib:AddRecipe(137958, 185939, 126989) -- Silkweave Gloves
lib:AddRecipe(137959, 185940, 126988) -- Silkweave Slippers
lib:AddRecipe(137960, 185941, 126987) -- Silkweave Robe
lib:AddRecipe(137961, 185942, 126994) -- Silkweave Bracers
lib:AddRecipe(137962, 185943, 126993) -- Silkweave Cinch
lib:AddRecipe(137963, 185944, 126992) -- Silkweave Epaulets
lib:AddRecipe(137964, 185945, 126987) -- Silkweave Robe
lib:AddRecipe(137965, 185946, 127002) -- Imbued Silkweave Bracers
lib:AddRecipe(137966, 185947, 127001) -- Imbued Silkweave Cinch
lib:AddRecipe(137967, 185948, 127000) -- Imbued Silkweave Epaulets
lib:AddRecipe(137968, 185949, 126999) -- Imbued Silkweave Pantaloons
lib:AddRecipe(137969, 185950, 126998) -- Imbued Silkweave Hood
lib:AddRecipe(137970, 185951, 126997) -- Imbued Silkweave Gloves
lib:AddRecipe(137971, 185952, 126996) -- Imbued Silkweave Slippers
lib:AddRecipe(137972, 185953, 126995) -- Imbued Silkweave Robe
lib:AddRecipe(137973, 185954, 127002) -- Imbued Silkweave Bracers
lib:AddRecipe(137974, 185955, 127001) -- Imbued Silkweave Cinch
lib:AddRecipe(137975, 185956, 127000) -- Imbued Silkweave Epaulets
lib:AddRecipe(137976, 185957, 126999) -- Imbued Silkweave Pantaloons
lib:AddRecipe(137977, 185958, 126998) -- Imbued Silkweave Hood
lib:AddRecipe(137978, 185959, 126997) -- Imbued Silkweave Gloves
lib:AddRecipe(137979, 185960, 126996) -- Imbued Silkweave Slippers
lib:AddRecipe(137980, 185961, 126995) -- Imbued Silkweave Robe
lib:AddRecipe(137984, 186091, 127031) -- Silkweave Shade
lib:AddRecipe(137987, 186094, 127032) -- Silkweave Flourish
lib:AddRecipe(137990, 186097, 127016) -- Silkweave Cover
lib:AddRecipe(137993, 186100, 127017) -- Silkweave Drape
lib:AddRecipe(138000, 186107, 127033) -- Imbued Silkweave Shade
lib:AddRecipe(138001, 186108, 127033) -- Imbued Silkweave Shade
lib:AddRecipe(138003, 186110, 127034) -- Imbued Silkweave Flourish
lib:AddRecipe(138004, 186111, 127034) -- Imbued Silkweave Flourish
lib:AddRecipe(138006, 186113, 127019) -- Imbued Silkweave Cover
lib:AddRecipe(138007, 186114, 127019) -- Imbued Silkweave Cover
lib:AddRecipe(138009, 186116, 127020) -- Imbued Silkweave Drape
lib:AddRecipe(138010, 186117, 127020) -- Imbued Silkweave Drape
lib:AddRecipe(138011, 186388, 127035) -- Silkweave Satchel
lib:AddRecipe(138012, 208350, 126989) -- Silkweave Gloves
lib:AddRecipe(138013, 208351, 126990) -- Silkweave Hood
lib:AddRecipe(138014, 208352, 126988) -- Silkweave Slippers
lib:AddRecipe(138015, 208353, 126991) -- Silkweave Pantaloons
lib:AddRecipe(138016, 213035, 137556) -- Clothes Chest: Dalaran Citizens
lib:AddRecipe(138017, 213036, 137557) -- Clothes Chest: Karazhan Opera House
lib:AddRecipe(138018, 213037, 137558) -- Clothes Chest: Molten Core
lib:AddRecipe(142076, 229041, 142075) -- Imbued Silkweave Bag
lib:AddRecipe(142077, 229043, 142075) -- Imbued Silkweave Bag
lib:AddRecipe(142078, 229045, 142075) -- Imbued Silkweave Bag
lib:AddRecipe(142333, 230047, 142332) -- Feathered Luffa
lib:AddRecipe(151746, 247807, 151571) -- Lightweave Breeches
lib:AddRecipe(151747, 247808, 151571) -- Lightweave Breeches
lib:AddRecipe(151748, 247809, 151571) -- Lightweave Breeches
lib:AddRecipe(162421, 257127, 154695) -- Deep Sea Bag
lib:AddRecipe(162422, 257130, 154696) -- Embroidered Deep Sea Bag
lib:AddRecipe(162427, 257116, 154700) -- Embroidered Deep Sea Cloak
lib:AddRecipe(162428, 257121, 162476) -- Emblazoned Deep Sea Gloves
lib:AddRecipe(162430, 257124, 162478) -- Emblazoned Deep Sea Breeches
lib:AddRecipe(162431, 269597, 159917) -- Honorable Combatant's Satin Cloak
lib:AddRecipe(162432, 269598, 159917) -- Honorable Combatant's Satin Cloak
lib:AddRecipe(162433, 269600, 159912) -- Honorable Combatant's Satin Boots
lib:AddRecipe(162434, 269601, 159912) -- Honorable Combatant's Satin Boots
lib:AddRecipe(162435, 269603, 159913) -- Honorable Combatant's Satin Mittens
lib:AddRecipe(162436, 269604, 159913) -- Honorable Combatant's Satin Mittens
lib:AddRecipe(162437, 269606, 159914) -- Honorable Combatant's Satin Pants
lib:AddRecipe(162438, 269607, 159914) -- Honorable Combatant's Satin Pants
lib:AddRecipe(162439, 269609, 159915) -- Honorable Combatant's Satin Belt
lib:AddRecipe(162440, 269610, 159915) -- Honorable Combatant's Satin Belt
lib:AddRecipe(162441, 269612, 159916) -- Honorable Combatant's Satin Bracers
lib:AddRecipe(162442, 269613, 159916) -- Honorable Combatant's Satin Bracers
lib:AddRecipe(162443, 257133, 154707) -- Battle Flag: Spirit of Freedom
lib:AddRecipe(162444, 257136, 154706) -- Battle Flag: Phalanx Defense
lib:AddRecipe(162445, 257139, 154705) -- Battle Flag: Rallying Swiftness
lib:AddRecipe(162507, 257120, 162487) -- Imbued Deep Sea Gloves
lib:AddRecipe(162508, 257121, 162476) -- Emblazoned Deep Sea Gloves
lib:AddRecipe(162509, 257123, 162488) -- Imbued Deep Sea Breeches
lib:AddRecipe(162510, 257124, 162478) -- Emblazoned Deep Sea Breeches
lib:AddRecipe(162769, 257127, 154695) -- Deep Sea Bag
lib:AddRecipe(162772, 257116, 154700) -- Embroidered Deep Sea Cloak
lib:AddRecipe(163026, 257129, 154696) -- Embroidered Deep Sea Bag
lib:AddRecipe(163027, 257128, 154696) -- Embroidered Deep Sea Bag
lib:AddRecipe(165332, 282275, 164676) -- Sinister Combatant's Satin Cloak
lib:AddRecipe(165333, 282276, 164676) -- Sinister Combatant's Satin Cloak
lib:AddRecipe(165334, 282195, 164671) -- Sinister Combatant's Satin Boots
lib:AddRecipe(165335, 282196, 164671) -- Sinister Combatant's Satin Boots
lib:AddRecipe(165336, 282192, 164672) -- Sinister Combatant's Satin Mittens
lib:AddRecipe(165337, 282193, 164672) -- Sinister Combatant's Satin Mittens
lib:AddRecipe(165338, 282176, 164673) -- Sinister Combatant's Satin Pants
lib:AddRecipe(165339, 282177, 164673) -- Sinister Combatant's Satin Pants
lib:AddRecipe(165340, 282169, 164674) -- Sinister Combatant's Satin Belt
lib:AddRecipe(165341, 282170, 164674) -- Sinister Combatant's Satin Belt
lib:AddRecipe(165342, 282165, 164675) -- Sinister Combatant's Satin Bracers
lib:AddRecipe(165343, 282166, 164675) -- Sinister Combatant's Satin Bracers
lib:AddRecipe(165652, 285086, 165410) -- Fortified Deep Sea Gloves
lib:AddRecipe(165653, 285094, 165418) -- Tempered Deep Sea Gloves
lib:AddRecipe(165654, 285093, 165393) -- Tempered Deep Sea Breeches
lib:AddRecipe(165655, 285085, 165385) -- Fortified Deep Sea Breeches
lib:AddRecipe(167880, 6692, 5770) -- Robes of Arcana
lib:AddRecipe(167881, 22866, 18405) -- Belt of the Archmage
lib:AddRecipe(167882, 22870, 18413) -- Cloak of Warding
lib:AddRecipe(167883, 22867, 18407) -- Felcloth Gloves
lib:AddRecipe(167884, 22868, 18408) -- Inferno Gloves
lib:AddRecipe(167885, 22869, 18409) -- Mooncloth Gloves
lib:AddRecipe(167886, 18408, 14042) -- Cindercloth Vest
lib:AddRecipe(167887, 18412, 14043) -- Cindercloth Gloves
lib:AddRecipe(167888, 18436, 14136) -- Robe of Winter Night
lib:AddRecipe(167889, 8786, 7053) -- Azure Silk Cloak
lib:AddRecipe(167890, 3862, 4327) -- Icy Cloak
lib:AddRecipe(168029, 292946, 164733) -- Synchronous Thread
lib:AddRecipe(168781, 299032, 168729) -- Reinforced Seaweave Gloves
lib:AddRecipe(168782, 299033, 168730) -- Banded Seaweave Gloves
lib:AddRecipe(168783, 299035, 168732) -- Reinforced Seaweave Breeches
lib:AddRecipe(168784, 299036, 168733) -- Banded Seaweave Breeches
lib:AddRecipe(169576, 294842, 167977) -- Notorious Combatant's Satin Belt
lib:AddRecipe(169577, 294843, 167977) -- Notorious Combatant's Satin Belt
lib:AddRecipe(169578, 294833, 167979) -- Notorious Combatant's Satin Boots
lib:AddRecipe(169579, 294834, 167979) -- Notorious Combatant's Satin Boots
lib:AddRecipe(169580, 294836, 167985) -- Notorious Combatant's Satin Mittens
lib:AddRecipe(169581, 294837, 167985) -- Notorious Combatant's Satin Mittens
lib:AddRecipe(169582, 294845, 167981) -- Notorious Combatant's Satin Bracers
lib:AddRecipe(169583, 294846, 167981) -- Notorious Combatant's Satin Bracers
lib:AddRecipe(169584, 294839, 167987) -- Notorious Combatant's Satin Pants
lib:AddRecipe(169585, 294840, 167987) -- Notorious Combatant's Satin Pants
lib:AddRecipe(169586, 294830, 167983) -- Notorious Combatant's Satin Cloak
lib:AddRecipe(169587, 294831, 167983) -- Notorious Combatant's Satin Cloak
lib:AddRecipe(170444, 304566, 170320) -- Uncanny Combatant's Satin Cloak
lib:AddRecipe(170445, 304578, 170324) -- Uncanny Combatant's Satin Belt
lib:AddRecipe(170446, 304579, 170324) -- Uncanny Combatant's Satin Belt
lib:AddRecipe(170447, 304567, 170320) -- Uncanny Combatant's Satin Cloak
lib:AddRecipe(170448, 304569, 170327) -- Uncanny Combatant's Satin Boots
lib:AddRecipe(170449, 304570, 170327) -- Uncanny Combatant's Satin Boots
lib:AddRecipe(170450, 304572, 170340) -- Uncanny Combatant's Satin Mittens
lib:AddRecipe(170451, 304573, 170340) -- Uncanny Combatant's Satin Mittens
lib:AddRecipe(170452, 304575, 170325) -- Uncanny Combatant's Satin Pants
lib:AddRecipe(170453, 304576, 170325) -- Uncanny Combatant's Satin Pants
lib:AddRecipe(170454, 304581, 170323) -- Uncanny Combatant's Satin Bracers
lib:AddRecipe(170455, 304582, 170323) -- Uncanny Combatant's Satin Bracers
lib:AddRecipe(171147, 304564, 170461) -- Eldritch Seaweave Breeches
lib:AddRecipe(171148, 304563, 170460) -- Maddening Seaweave Breeches
lib:AddRecipe(171149, 304561, 170458) -- Eldritch Seaweave Gloves
lib:AddRecipe(171150, 304560, 170457) -- Maddening Seaweave Gloves
lib:AddRecipe(174370, 304559, 170456) -- Unsettling Seaweave Gloves
lib:AddRecipe(174371, 304562, 170459) -- Unsettling Seaweave Breeches
lib:AddRecipe(180781, 334499, 180752) -- Pink Party Hat
lib:AddRecipe(183101, 310898, 173215) -- Shadowlace Cloak
lib:AddRecipe(183871, 343201, 173383) -- Crafter's Mark III
lib:AddRecipe(186995, 355183, 186975) -- Shrouded Hand Towel
lib:AddRecipe(194255, 376493, 193526) -- Amice of the Blue
lib:AddRecipe(194256, 376492, 193521) -- Hood of Surging Time
lib:AddRecipe(194257, 376494, 193513) -- Infurious Binding of Gesticulation
lib:AddRecipe(194258, 376495, 193524) -- Infurious Legwraps of Possibility
lib:AddRecipe(194259, 376497, 193530) -- Allied Wristguards of Time Dilation
lib:AddRecipe(194260, 376496, 193532) -- Blue Dragon Soles
lib:AddRecipe(194261, 376539, 194011) -- Frozen Spellthread
lib:AddRecipe(194262, 376540, 194014) -- Temporal Spellthread
lib:AddRecipe(194265, 376541, 193944) -- Blue Silken Lining
lib:AddRecipe(194266, 376542, 193941) -- Bronzed Grip Wrappings
lib:AddRecipe(194267, 376537, 193962) -- Shimmering Embroidery Thread
lib:AddRecipe(194268, 376570, 194060) -- Dragonscale Expedition's Expedition Tent
lib:AddRecipe(194269, 376559, 193932) -- Infurious Wildercloth Bolt
lib:AddRecipe(194270, 376527, 193505) -- Crimson Combatant's Wildercloth Bands
lib:AddRecipe(194271, 376519, 193522) -- Crimson Combatant's Wildercloth Cloak
lib:AddRecipe(194272, 376522, 193507) -- Crimson Combatant's Wildercloth Gloves
lib:AddRecipe(194273, 376523, 193506) -- Crimson Combatant's Wildercloth Hood
lib:AddRecipe(194274, 376524, 193501) -- Crimson Combatant's Wildercloth Leggings
lib:AddRecipe(194275, 376526, 193517) -- Crimson Combatant's Wildercloth Sash
lib:AddRecipe(194276, 376525, 193502) -- Crimson Combatant's Wildercloth Shoulderpads
lib:AddRecipe(194277, 376521, 193503) -- Crimson Combatant's Wildercloth Treads
lib:AddRecipe(194278, 376520, 193514) -- Crimson Combatant's Wildercloth Tunic
lib:AddRecipe(194279, 376501, 193525) -- Azureweave Slippers
lib:AddRecipe(194280, 376505, 193512) -- Chronocloth Sash
lib:AddRecipe(194281, 376568, 194058) -- Cold Cushion
lib:AddRecipe(194282, 376567, 194057) -- Cushion of Time Travel
lib:AddRecipe(194283, 376565, 194056) -- Duck-Stuffed Duck Lovie
lib:AddRecipe(194285, 376529, 194018) -- Azureweave Expedition Pack
lib:AddRecipe(194286, 376536, 193959) -- Chromatic Embroidery Thread
lib:AddRecipe(194287, 376561, 194020) -- Chronocloth Reagent Bag
lib:AddRecipe(194288, 376544, 193544) -- Master's Wildercloth Alchemist's Robe
lib:AddRecipe(194289, 376548, 193545) -- Master's Wildercloth Chef's Hat
lib:AddRecipe(194290, 376550, 193533) -- Master's Wildercloth Enchanter's Hat
lib:AddRecipe(194291, 376552, 193543) -- Master's Wildercloth Fishing Cap
lib:AddRecipe(194292, 376554, 193542) -- Master's Wildercloth Gardening Hat
lib:AddRecipe(194293, 376534, 193953) -- Vibrant Polishing Cloth
lib:AddRecipe(194294, 376531, 194042) -- Explorer's Banner of Herbology
lib:AddRecipe(194295, 376532, 194045) -- Explorer's Banner of Geology
lib:AddRecipe(194296, 376563, nil) -- Fiddle with Draconium Fabric Cutters
lib:AddRecipe(194297, 376564, nil) -- Fiddle with Khaz'gorite Fabric Cutters
lib:AddRecipe(194298, 376566, 194052) -- Forlorn Funeral Pall
lib:AddRecipe(201258, 376559, 193932) -- Infurious Wildercloth Bolt
lib:AddRecipe(202234, 397864, 202218) -- Impressive Hexweave Essence
lib:AddRecipe(202235, 397865, 202219) -- Remarkable Hexweave Essence
lib:AddRecipe(203428, 400815, 203415) -- Traditional Morqut Kite
lib:AddRecipe(203848, 402151, 203796) -- Bloodlord's Embrace
lib:AddRecipe(203849, 402152, 203803) -- Gurubashi Tigerhide Cloak
lib:AddRecipe(203850, 402155, 203820) -- Gurubashi Headdress
lib:AddRecipe(203851, 402156, 203800) -- Ritualistic Legwarmers
lib:AddRecipe(204129, 403157, 204115) -- Obsidian Combatant's Wildercloth Bands
lib:AddRecipe(204130, 403149, 204120) -- Obsidian Combatant's Wildercloth Cloak
lib:AddRecipe(204131, 403152, 204117) -- Obsidian Combatant's Wildercloth Gloves
lib:AddRecipe(204132, 403153, 204116) -- Obsidian Combatant's Wildercloth Hood
lib:AddRecipe(204133, 403154, 204112) -- Obsidian Combatant's Wildercloth Leggings
lib:AddRecipe(204134, 403156, 204119) -- Obsidian Combatant's Wildercloth Sash
lib:AddRecipe(204135, 403155, 204113) -- Obsidian Combatant's Wildercloth Shoulderpads
lib:AddRecipe(204136, 403151, 204114) -- Obsidian Combatant's Wildercloth Treads
lib:AddRecipe(204137, 403150, 204118) -- Obsidian Combatant's Wildercloth Tunic
lib:AddRecipe(204678, 405974, 202287) -- Paw-Made Winterpelt Reagent Bag
lib:AddRecipe(205138, 409839, 205411) -- Medical Wrap Kit
lib:AddRecipe(205139, 408304, 205012) -- Reserve Parachute
lib:AddRecipe(205140, 408318, 205025) -- Undulating Sporecloak
lib:AddRecipe(206393, 28208, 22658) -- Glacial Cloak
lib:AddRecipe(206395, 413490, 206429) -- Glacial Chapeau
lib:AddRecipe(206396, 413491, 206428) -- Glacial Epaulets
lib:AddRecipe(206397, 28207, 22652) -- Glacial Vest
lib:AddRecipe(206398, 28209, 22655) -- Glacial Wrists
lib:AddRecipe(206399, 28205, 22654) -- Glacial Gloves
lib:AddRecipe(206400, 413492, 206430) -- Glacial Tether
lib:AddRecipe(206401, 413494, 206427) -- Glacial Leggings
lib:AddRecipe(206402, 413495, 206431) -- Glacial Footwear
lib:AddRecipe(206547, 413747, 206500) -- Bindings of the Harvested Soul
lib:AddRecipe(206554, 413754, 206507) -- Necrotic Gown
lib:AddRecipe(206563, 413788, 206562) -- Shroud of Forbidden Magic
lib:AddRecipe(206583, 413903, 206582) -- Peculiar Glacial Mantle
lib:AddRecipe(206771, 414564, 206645) -- Cursed Cloth
lib:AddRecipe(208272, 419030, 208258) -- Verdant Combatant's Wildercloth Bands
lib:AddRecipe(208273, 419022, 208263) -- Verdant Combatant's Wildercloth Cloak
lib:AddRecipe(208274, 419025, 208260) -- Verdant Combatant's Wildercloth Gloves
lib:AddRecipe(208275, 419026, 208259) -- Verdant Combatant's Wildercloth Hood
lib:AddRecipe(208276, 419027, 208255) -- Verdant Combatant's Wildercloth Leggings
lib:AddRecipe(208277, 419029, 208262) -- Verdant Combatant's Wildercloth Sash
lib:AddRecipe(208278, 419028, 208256) -- Verdant Combatant's Wildercloth Shoulderpads
lib:AddRecipe(208279, 419024, 208257) -- Verdant Combatant's Wildercloth Treads
lib:AddRecipe(208280, 419023, 208261) -- Verdant Combatant's Wildercloth Tunic
lib:AddRecipe(210670, 426434, 210671) -- Verdant Tether

--------------------------------------------------------------------------------
-- End Retail Data                                                            --
end                                                                           --
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Classic Data (don't forget to increase MINOR when updated)                 --
if lib.IsClassic then                                                         --
--------------------------------------------------------------------------------

-- Alchemy
lib:AddRecipe(2553, 3230, 2457) -- Elixir of Minor Agility
lib:AddRecipe(2555, 2335, 2459) -- Swiftness Potion
lib:AddRecipe(2556, 2336, 2460) -- Elixir of Tongues
lib:AddRecipe(3393, 3172, 3384) -- Minor Magic Resistance Potion
lib:AddRecipe(3394, 3174, 3386) -- Elixir of Poison Resistance
lib:AddRecipe(3395, 3175, 3387) -- Limited Invulnerability Potion
lib:AddRecipe(3396, 2333, 3390) -- Elixir of Lesser Agility
lib:AddRecipe(3830, 3450, 3825) -- Elixir of Fortitude
lib:AddRecipe(3831, 3451, 3826) -- Mighty Troll's Blood Potion
lib:AddRecipe(3832, 3453, 3828) -- Elixir of Detect Lesser Invisibility
lib:AddRecipe(4597, 4508, 4596) -- Discolored Healing Potion
lib:AddRecipe(4624, 4942, 4623) -- Lesser Stoneshield Potion
lib:AddRecipe(5640, 6617, 5631) -- Rage Potion
lib:AddRecipe(5641, 6619, 5632) -- Cowardly Flight Potion
lib:AddRecipe(5642, 6624, 5634) -- Free Action Potion
lib:AddRecipe(5643, 6618, 5633) -- Great Rage Potion
lib:AddRecipe(6053, 7255, 6051) -- Holy Protection Potion
lib:AddRecipe(6054, 7256, 6048) -- Shadow Protection Potion
lib:AddRecipe(6055, 7257, 6049) -- Fire Protection Potion
lib:AddRecipe(6056, 7258, 6050) -- Frost Protection Potion
lib:AddRecipe(6057, 7259, 6052) -- Nature Protection Potion
lib:AddRecipe(6068, 3449, 3824) -- Shadow Oil
lib:AddRecipe(6211, 3188, 3391) -- Elixir of Ogre's Strength
lib:AddRecipe(6663, 8240, 6662) -- Elixir of Giant Growth
lib:AddRecipe(9293, 11453, 9036) -- Magic Resistance Potion
lib:AddRecipe(9294, 11458, 9144) -- Wildvine Potion
lib:AddRecipe(9295, 11464, 9172) -- Invisibility Potion
lib:AddRecipe(9296, 11466, 9088) -- Gift of Arthas
lib:AddRecipe(9297, 11468, 9197) -- Elixir of Dream Vision
lib:AddRecipe(9298, 11472, 9206) -- Elixir of Giants
lib:AddRecipe(9300, 11477, 9224) -- Elixir of Demonslaying
lib:AddRecipe(9301, 11476, 9264) -- Elixir of Shadow Power
lib:AddRecipe(9302, 11473, 9210) -- Ghost Dye
lib:AddRecipe(9303, 11459, 9149) -- Philosophers' Stone
lib:AddRecipe(9304, 11479, 3577) -- Transmute: Iron to Gold
lib:AddRecipe(9305, 11480, 6037) -- Transmute: Mithril to Truesilver
lib:AddRecipe(10644, 11456, 9061) -- Goblin Rocket Fuel
lib:AddRecipe(12958, 17187, 12360) -- Transmute: Arcanite
lib:AddRecipe(13476, 17552, 13442) -- Mighty Rage Potion
lib:AddRecipe(13477, 17553, 13443) -- Superior Mana Potion
lib:AddRecipe(13478, 17554, 13445) -- Elixir of Superior Defense
lib:AddRecipe(13479, 17555, 13447) -- Elixir of the Sages
lib:AddRecipe(13480, 17556, 13446) -- Major Healing Potion
lib:AddRecipe(13481, 17557, 13453) -- Elixir of Brute Force
lib:AddRecipe(13482, 17559, 7078) -- Transmute: Air to Fire
lib:AddRecipe(13483, 17560, 7076) -- Transmute: Fire to Earth
lib:AddRecipe(13484, 17561, 7080) -- Transmute: Earth to Water
lib:AddRecipe(13485, 17562, 7082) -- Transmute: Water to Air
lib:AddRecipe(13486, 17563, 7080) -- Transmute: Undeath to Water
lib:AddRecipe(13487, 17564, 12808) -- Transmute: Water to Undeath
lib:AddRecipe(13488, 17565, 7076) -- Transmute: Life to Earth
lib:AddRecipe(13489, 17566, 12803) -- Transmute: Earth to Life
lib:AddRecipe(13490, 17570, 13455) -- Greater Stoneshield Potion
lib:AddRecipe(13491, 17571, 13452) -- Elixir of the Mongoose
lib:AddRecipe(13492, 17572, 13462) -- Purification Potion
lib:AddRecipe(13493, 17573, 13454) -- Greater Arcane Elixir
lib:AddRecipe(13494, 17574, 13457) -- Greater Fire Protection Potion
lib:AddRecipe(13495, 17575, 13456) -- Greater Frost Protection Potion
lib:AddRecipe(13496, 17576, 13458) -- Greater Nature Protection Potion
lib:AddRecipe(13497, 17577, 13461) -- Greater Arcane Protection Potion
lib:AddRecipe(13499, 17578, 13459) -- Greater Shadow Protection Potion
lib:AddRecipe(13500, 17579, 13460) -- Greater Holy Protection Potion
lib:AddRecipe(13501, 17580, 13444) -- Major Mana Potion
lib:AddRecipe(13517, 17632, 13503) -- Alchemist's Stone
lib:AddRecipe(13518, 17634, 13506) -- Flask of Petrification
lib:AddRecipe(13519, 17635, 13510) -- Flask of the Titans
lib:AddRecipe(13520, 17636, 13511) -- Flask of Distilled Wisdom
lib:AddRecipe(13521, 17637, 13512) -- Flask of Supreme Power
lib:AddRecipe(13522, 17638, 13513) -- Flask of Chromatic Resistance
lib:AddRecipe(14634, 3454, 3829) -- Frost Oil
lib:AddRecipe(17709, 21923, 17708) -- Elixir of Frost Power
lib:AddRecipe(18257, 22732, 18253) -- Major Rejuvenation Potion
lib:AddRecipe(20011, 24365, 20007) -- Mageblood Potion
lib:AddRecipe(20012, 24366, 20002) -- Greater Dreamless Sleep Potion
lib:AddRecipe(20013, 24367, 20008) -- Living Action Potion
lib:AddRecipe(20014, 24368, 20004) -- Major Troll's Blood Potion
lib:AddRecipe(20761, 25146, 7068) -- Transmute: Elemental Fire
lib:AddRecipe(21547, 26277, 21546) -- Elixir of Greater Firepower
-- Blacksmithing
lib:AddRecipe(2881, 2667, 2864) -- Runed Copper Breastplate
lib:AddRecipe(2882, 3330, 3481) -- Silvered Bronze Shoulders
lib:AddRecipe(2883, 3295, 3490) -- Deadly Bronze Poniard
lib:AddRecipe(3608, 3297, 3492) -- Mighty Iron Hammer
lib:AddRecipe(3609, 3321, 3471) -- Copper Chain Vest
lib:AddRecipe(3610, 3325, 3474) -- Gemmed Copper Gauntlets
lib:AddRecipe(3611, 3334, 3484) -- Green Iron Boots
lib:AddRecipe(3612, 3336, 3485) -- Green Iron Gauntlets
lib:AddRecipe(3866, 3493, 3850) -- Jade Serpentblade
lib:AddRecipe(3867, 3495, 3852) -- Golden Iron Destroyer
lib:AddRecipe(3868, 3497, 3854) -- Frost Tiger Blade
lib:AddRecipe(3869, 3500, 3856) -- Shadow Crescent Axe
lib:AddRecipe(3870, 3504, 3840) -- Green Iron Shoulders
lib:AddRecipe(3871, 3505, 3841) -- Golden Scale Shoulders
lib:AddRecipe(3872, 3507, 3843) -- Golden Scale Leggings
lib:AddRecipe(3873, 3511, 3845) -- Golden Scale Cuirass
lib:AddRecipe(3874, 3513, 3846) -- Polished Steel Boots
lib:AddRecipe(3875, 3515, 3847) -- Golden Scale Boots
lib:AddRecipe(5543, 6518, 5541) -- Iridescent Hammer
lib:AddRecipe(5577, 2671, 2867) -- Rough Bronze Bracers
lib:AddRecipe(5578, 2673, 2869) -- Silvered Bronze Breastplate
lib:AddRecipe(6044, 7221, 6042) -- Iron Shield Spike
lib:AddRecipe(6045, 7222, 6043) -- Iron Counterweight
lib:AddRecipe(6046, 7224, 6041) -- Steel Weapon Chain
lib:AddRecipe(6047, 3503, 3837) -- Golden Scale Coif
lib:AddRecipe(6734, 8366, 6730) -- Ironforge Chain
lib:AddRecipe(6735, 8367, 6731) -- Ironforge Breastplate
lib:AddRecipe(6736, 8368, 6733) -- Ironforge Gauntlets
lib:AddRecipe(7975, 9933, 7921) -- Heavy Mithril Pants
lib:AddRecipe(7976, 9939, 7967) -- Mithril Shield Spike
lib:AddRecipe(7977, 9942, 7925) -- Mithril Scale Gloves
lib:AddRecipe(7978, 9811, 7913) -- Barbaric Iron Shoulders
lib:AddRecipe(7979, 9813, 7914) -- Barbaric Iron Breastplate
lib:AddRecipe(7980, 9814, 7915) -- Barbaric Iron Helm
lib:AddRecipe(7981, 9818, 7916) -- Barbaric Iron Boots
lib:AddRecipe(7982, 9820, 7917) -- Barbaric Iron Gloves
lib:AddRecipe(7983, 9945, 7926) -- Ornate Mithril Pants
lib:AddRecipe(7984, 9950, 7927) -- Ornate Mithril Gloves
lib:AddRecipe(7985, 9952, 7928) -- Ornate Mithril Shoulders
lib:AddRecipe(7986, 9972, 7935) -- Ornate Mithril Breastplate
lib:AddRecipe(7987, 9980, 7937) -- Ornate Mithril Helm
lib:AddRecipe(7988, 9979, 7936) -- Ornate Mithril Boots
lib:AddRecipe(7989, 9964, 7969) -- Mithril Spurs
lib:AddRecipe(7990, 9970, 7934) -- Heavy Mithril Helm
lib:AddRecipe(7991, 9966, 7932) -- Mithril Scale Shoulders
lib:AddRecipe(7992, 9995, 7942) -- Blue Glittering Axe
lib:AddRecipe(7993, 10005, 7944) -- Dazzling Mithril Rapier
lib:AddRecipe(7994, 9957, 7929) -- Orcish War Leggings
lib:AddRecipe(7995, 9937, 7924) -- Mithril Scale Bracers
lib:AddRecipe(8028, 10009, 7946) -- Runed Mithril Hammer
lib:AddRecipe(8029, 9997, 7943) -- Wicked Mithril Blade
lib:AddRecipe(8030, 10013, 7947) -- Ebon Shiv
lib:AddRecipe(9367, 11643, 9366) -- Golden Scale Gauntlets
lib:AddRecipe(10424, 12259, 10423) -- Silvered Bronze Leggings
lib:AddRecipe(10713, 11454, 9060) -- Inlaid Mithril Cylinder
lib:AddRecipe(10858, 3494, 3851) -- Solid Iron Maul
lib:AddRecipe(11610, 15292, 11608) -- Dark Iron Pulverizer
lib:AddRecipe(11611, 15294, 11607) -- Dark Iron Sunderer
lib:AddRecipe(11612, 15296, 11604) -- Dark Iron Plate
lib:AddRecipe(11614, 15293, 11606) -- Dark Iron Mail
lib:AddRecipe(11615, 15295, 11605) -- Dark Iron Shoulders
lib:AddRecipe(12162, 3492, 3849) -- Hardened Iron Shortsword
lib:AddRecipe(12163, 3496, 3853) -- Moonsteel Broadsword
lib:AddRecipe(12164, 3498, 3855) -- Massive Iron Axe
lib:AddRecipe(12261, 15973, 12260) -- Searing Golden Blade
lib:AddRecipe(12682, 16642, 12405) -- Thorium Armor
lib:AddRecipe(12683, 16643, 12406) -- Thorium Belt
lib:AddRecipe(12684, 16644, 12408) -- Thorium Bracers
lib:AddRecipe(12685, 16645, 12416) -- Radiant Belt
lib:AddRecipe(12687, 16646, 12428) -- Imperial Plate Shoulders
lib:AddRecipe(12688, 16647, 12424) -- Imperial Plate Belt
lib:AddRecipe(12689, 16648, 12415) -- Radiant Breastplate
lib:AddRecipe(12690, 16649, 12425) -- Imperial Plate Bracers
lib:AddRecipe(12691, 16650, 12624) -- Wildthorn Mail
lib:AddRecipe(12692, 16651, 12645) -- Thorium Shield Spike
lib:AddRecipe(12693, 16652, 12409) -- Thorium Boots
lib:AddRecipe(12694, 16653, 12410) -- Thorium Helm
lib:AddRecipe(12695, 16654, 12418) -- Radiant Gloves
lib:AddRecipe(12696, 16667, 12628) -- Demon Forged Breastplate
lib:AddRecipe(12697, 16656, 12419) -- Radiant Boots
lib:AddRecipe(12698, 16660, 12625) -- Dawnbringer Shoulders
lib:AddRecipe(12699, 16655, 12631) -- Fiery Plate Gauntlets
lib:AddRecipe(12700, 16657, 12426) -- Imperial Plate Boots
lib:AddRecipe(12701, 16658, 12427) -- Imperial Plate Helm
lib:AddRecipe(12702, 16659, 12417) -- Radiant Circlet
lib:AddRecipe(12703, 16661, 12632) -- Storm Gauntlets
lib:AddRecipe(12704, 16662, 12414) -- Thorium Leggings
lib:AddRecipe(12705, 16663, 12422) -- Imperial Plate Chest
lib:AddRecipe(12706, 16664, 12610) -- Runic Plate Shoulders
lib:AddRecipe(12707, 16665, 12611) -- Runic Plate Boots
lib:AddRecipe(12711, 16724, 12633) -- Whitesoul Helm
lib:AddRecipe(12713, 16725, 12420) -- Radiant Leggings
lib:AddRecipe(12714, 16726, 12612) -- Runic Plate Helm
lib:AddRecipe(12715, 16730, 12429) -- Imperial Plate Leggings
lib:AddRecipe(12716, 16728, 12636) -- Helm of the Great Chief
lib:AddRecipe(12717, 16729, 12640) -- Lionheart Helm
lib:AddRecipe(12718, 16731, 12613) -- Runic Breastplate
lib:AddRecipe(12719, 16732, 12614) -- Runic Plate Leggings
lib:AddRecipe(12720, 16741, 12639) -- Stronghold Gauntlets
lib:AddRecipe(12725, 16742, 12620) -- Enchanted Thorium Helm
lib:AddRecipe(12726, 16744, 12619) -- Enchanted Thorium Leggings
lib:AddRecipe(12727, 16745, 12618) -- Enchanted Thorium Breastplate
lib:AddRecipe(12728, 16746, 12641) -- Invulnerable Mail
lib:AddRecipe(12816, 16960, 12764) -- Thorium Greatsword
lib:AddRecipe(12817, 16965, 12769) -- Bleakwood Hew
lib:AddRecipe(12818, 16967, 12772) -- Inlaid Thorium Hammer
lib:AddRecipe(12819, 16969, 12773) -- Ornate Thorium Handaxe
lib:AddRecipe(12821, 16970, 12774) -- Dawn's Edge
lib:AddRecipe(12823, 16971, 12775) -- Huge Thorium Battleaxe
lib:AddRecipe(12824, 16973, 12776) -- Enchanted Battlehammer
lib:AddRecipe(12825, 16978, 12777) -- Blazing Rapier
lib:AddRecipe(12826, 16980, 12779) -- Rune Edge
lib:AddRecipe(12827, 16983, 12781) -- Serenity
lib:AddRecipe(12828, 16984, 12792) -- Volcanic Hammer
lib:AddRecipe(12830, 16985, 12782) -- Corruption
lib:AddRecipe(12831, 16986, 12795) -- Blood Talon
lib:AddRecipe(12832, 16987, 12802) -- Darkspear
lib:AddRecipe(12833, 16988, 12796) -- Hammer of the Titans
lib:AddRecipe(12834, 16990, 12790) -- Arcanite Champion
lib:AddRecipe(12835, 16991, 12798) -- Annihilator
lib:AddRecipe(12836, 16992, 12797) -- Frostguard
lib:AddRecipe(12837, 16993, 12794) -- Masterwork Stormhammer
lib:AddRecipe(12838, 16994, 12784) -- Arcanite Reaper
lib:AddRecipe(12839, 16995, 12783) -- Heartseeker
lib:AddRecipe(17049, 20872, 16989) -- Fiery Chain Girdle
lib:AddRecipe(17051, 20874, 17014) -- Dark Iron Bracers
lib:AddRecipe(17052, 20876, 17013) -- Dark Iron Leggings
lib:AddRecipe(17053, 20873, 16988) -- Fiery Chain Shoulders
lib:AddRecipe(17059, 20890, 17015) -- Dark Iron Reaver
lib:AddRecipe(17060, 20897, 17016) -- Dark Iron Destroyer
lib:AddRecipe(17706, 21913, 17704) -- Edge of Winter
lib:AddRecipe(18264, 22757, 18262) -- Elemental Sharpening Stone
lib:AddRecipe(18592, 21161, 17193) -- Sulfuron Hammer
lib:AddRecipe(19202, 23628, 19043) -- Heavy Timbermaw Belt
lib:AddRecipe(19203, 23632, 19051) -- Girdle of the Dawn
lib:AddRecipe(19204, 23629, 19048) -- Heavy Timbermaw Boots
lib:AddRecipe(19205, 23633, 19057) -- Gloves of the Dawn
lib:AddRecipe(19206, 23636, 19148) -- Dark Iron Helm
lib:AddRecipe(19207, 23637, 19164) -- Dark Iron Gauntlets
lib:AddRecipe(19208, 23638, 19166) -- Black Amnesty
lib:AddRecipe(19209, 23639, 19167) -- Blackfury
lib:AddRecipe(19210, 23650, 19170) -- Ebon Hand
lib:AddRecipe(19211, 23652, 19168) -- Blackguard
lib:AddRecipe(19212, 23653, 19169) -- Nightfall
lib:AddRecipe(19776, 24136, 19690) -- Bloodsoul Breastplate
lib:AddRecipe(19777, 24137, 19691) -- Bloodsoul Shoulders
lib:AddRecipe(19778, 24138, 19692) -- Bloodsoul Gauntlets
lib:AddRecipe(19779, 24139, 19693) -- Darksoul Breastplate
lib:AddRecipe(19780, 24140, 19694) -- Darksoul Leggings
lib:AddRecipe(19781, 24141, 19695) -- Darksoul Shoulders
lib:AddRecipe(20040, 24399, 20039) -- Dark Iron Boots
lib:AddRecipe(20553, 24912, 20549) -- Darkrune Gauntlets
lib:AddRecipe(20554, 24914, 20550) -- Darkrune Breastplate
lib:AddRecipe(20555, 24913, 20551) -- Darkrune Helm
lib:AddRecipe(22209, 27585, 22197) -- Heavy Obsidian Belt
lib:AddRecipe(22214, 27588, 22195) -- Light Obsidian Belt
lib:AddRecipe(22219, 27586, 22198) -- Jagged Obsidian Shield
lib:AddRecipe(22220, 27589, 22194) -- Black Grasp of the Destroyer
lib:AddRecipe(22221, 27590, 22191) -- Obsidian Mail Tunic
lib:AddRecipe(22222, 27587, 22196) -- Thick Obsidian Breastplate
lib:AddRecipe(22388, 27829, 22385) -- Titanic Leggings
lib:AddRecipe(22389, 27832, 22383) -- Sageblade
lib:AddRecipe(22390, 27830, 22384) -- Persuader
lib:AddRecipe(22703, 28242, 22669) -- Icebane Breastplate
lib:AddRecipe(22704, 28243, 22670) -- Icebane Gauntlets
lib:AddRecipe(22705, 28244, 22671) -- Icebane Bracers
lib:AddRecipe(22766, 28461, 22762) -- Ironvine Breastplate
lib:AddRecipe(22767, 28462, 22763) -- Ironvine Gloves
lib:AddRecipe(22768, 28463, 22764) -- Ironvine Belt
-- Cooking
lib:AddRecipe(728, 2543, 733) -- Westfall Stew
lib:AddRecipe(2697, 2542, 724) -- Goretusk Liver Pie
lib:AddRecipe(2698, 2545, 2682) -- Cooked Crab Claw
lib:AddRecipe(2699, 2547, 1082) -- Redridge Goulash
lib:AddRecipe(2700, 2548, 2685) -- Succulent Pork Ribs
lib:AddRecipe(2701, 2549, 1017) -- Seasoned Wolf Kabob
lib:AddRecipe(2889, 2795, 2888) -- Beer Basted Boar Ribs
lib:AddRecipe(3678, 3370, 3662) -- Crocolisk Steak
lib:AddRecipe(3679, 3371, 3220) -- Blood Sausage
lib:AddRecipe(3680, 3372, 3663) -- Murloc Fin Soup
lib:AddRecipe(3681, 3373, 3664) -- Crocolisk Gumbo
lib:AddRecipe(3682, 3376, 3665) -- Curiously Tasty Omelet
lib:AddRecipe(3683, 3377, 3666) -- Gooey Spider Cake
lib:AddRecipe(3734, 3397, 3726) -- Big Bear Steak
lib:AddRecipe(3735, 3398, 3727) -- Hot Lion Chops
lib:AddRecipe(3736, 3399, 3728) -- Tasty Lion Steak
lib:AddRecipe(3737, 3400, 3729) -- Soothing Turtle Bisque
lib:AddRecipe(4609, 4094, 4457) -- Barbecued Buzzard Wing
lib:AddRecipe(5482, 6412, 5472) -- Kaldorei Spider Kabob
lib:AddRecipe(5483, 6413, 5473) -- Scorpid Surprise
lib:AddRecipe(5484, 6414, 5474) -- Roasted Kodo Meat
lib:AddRecipe(5485, 6415, 5476) -- Fillet of Frenzy
lib:AddRecipe(5486, 6416, 5477) -- Strider Stew
lib:AddRecipe(5487, 6417, 5478) -- Dig Rat Stew
lib:AddRecipe(5488, 6418, 5479) -- Crispy Lizard Tail
lib:AddRecipe(5489, 6419, 5480) -- Lean Venison
lib:AddRecipe(5528, 6501, 5526) -- Clam Chowder
lib:AddRecipe(6039, 7213, 6038) -- Giant Clam Scorcho
lib:AddRecipe(6325, 7751, 6290) -- Brilliant Smallfish
lib:AddRecipe(6326, 7752, 787) -- Slitherskin Mackerel
lib:AddRecipe(6328, 7753, 4592) -- Longjaw Mud Snapper
lib:AddRecipe(6329, 7754, 6316) -- Loch Frenzy Delight
lib:AddRecipe(6330, 7755, 4593) -- Bristle Whisker Catfish
lib:AddRecipe(6368, 7827, 5095) -- Rainbow Fin Albacore
lib:AddRecipe(6369, 7828, 4594) -- Rockscale Cod
lib:AddRecipe(6661, 8238, 6657) -- Savory Deviate Delight
lib:AddRecipe(6891, 8604, 6888) -- Herb Baked Egg
lib:AddRecipe(6892, 8607, 6890) -- Smoked Bear Meat
lib:AddRecipe(7678, 9513, 7676) -- Thistle Tea
lib:AddRecipe(12226, 15935, 12224) -- Crispy Bat Wing
lib:AddRecipe(12227, 15853, 12209) -- Lean Wolf Steak
lib:AddRecipe(12228, 15855, 12210) -- Roast Raptor
lib:AddRecipe(12229, 15856, 13851) -- Hot Wolf Ribs
lib:AddRecipe(12231, 15861, 12212) -- Jungle Stew
lib:AddRecipe(12232, 15863, 12213) -- Carrion Surprise
lib:AddRecipe(12233, 15865, 12214) -- Mystery Stew
lib:AddRecipe(12239, 15906, 12217) -- Dragonbreath Chili
lib:AddRecipe(12240, 15910, 12215) -- Heavy Kodo Stew
lib:AddRecipe(13939, 18238, 6887) -- Spotted Yellowtail
lib:AddRecipe(13940, 18239, 13927) -- Cooked Glossy Mightfish
lib:AddRecipe(13941, 18241, 13930) -- Filet of Redgill
lib:AddRecipe(13942, 18240, 13928) -- Grilled Squid
lib:AddRecipe(13943, 18242, 13929) -- Hot Smoked Bass
lib:AddRecipe(13945, 18243, 13931) -- Nightfin Soup
lib:AddRecipe(13946, 18244, 13932) -- Poached Sunscale Salmon
lib:AddRecipe(13947, 18245, 13933) -- Lobster Stew
lib:AddRecipe(13948, 18246, 13934) -- Mightfish Steak
lib:AddRecipe(13949, 18247, 13935) -- Baked Salmon
lib:AddRecipe(16110, 15933, 12218) -- Monster Omelet
lib:AddRecipe(16111, 15915, 12216) -- Spiced Chili Crab
lib:AddRecipe(16767, 20626, 16766) -- Undermine Clam Chowder
lib:AddRecipe(17062, 20916, 8364) -- Mithril Headed Trout
lib:AddRecipe(17200, 21143, 17197) -- Gingerbread Cookie
lib:AddRecipe(17201, 21144, 17198) -- Egg Nog
lib:AddRecipe(18046, 22480, 18045) -- Tender Wolf Steak
lib:AddRecipe(18160, 9513, 7676) -- Thistle Tea
lib:AddRecipe(18267, 22761, 18254) -- Runn Tum Tuber Surprise
lib:AddRecipe(20075, 24418, 20074) -- Heavy Crocolisk Stew
lib:AddRecipe(21025, 25659, 21023) -- Dirge's Kickin' Chimaerok Chops
lib:AddRecipe(21099, 25704, 21072) -- Smoked Sagefish
lib:AddRecipe(21219, 25954, 21217) -- Sagefish Delight
lib:AddRecipe(23690, 30047, 23683) -- Crystal Throat Lozenge
-- Enchanting
lib:AddRecipe(6342, 7443, nil) -- Enchant Chest - Minor Mana
lib:AddRecipe(6344, 7766, nil) -- Enchant Bracer - Minor Spirit
lib:AddRecipe(6345, 7771, nil) -- Enchant Cloak - Minor Protection
lib:AddRecipe(6346, 7776, nil) -- Enchant Chest - Lesser Mana
lib:AddRecipe(6347, 7782, nil) -- Enchant Bracer - Minor Strength
lib:AddRecipe(6348, 7786, nil) -- Enchant Weapon - Minor Beastslayer
lib:AddRecipe(6349, 7793, nil) -- Enchant 2H Weapon - Lesser Intellect
lib:AddRecipe(6375, 7859, nil) -- Enchant Bracer - Lesser Spirit
lib:AddRecipe(6376, 7863, nil) -- Enchant Boots - Minor Stamina
lib:AddRecipe(6377, 7867, nil) -- Enchant Boots - Minor Agility
lib:AddRecipe(11038, 13380, nil) -- Enchant 2H Weapon - Lesser Spirit
lib:AddRecipe(11039, 13419, nil) -- Enchant Cloak - Minor Agility
lib:AddRecipe(11081, 13464, nil) -- Enchant Shield - Lesser Protection
lib:AddRecipe(11098, 13522, nil) -- Enchant Cloak - Lesser Shadow Resistance
lib:AddRecipe(11101, 13536, nil) -- Enchant Bracer - Lesser Strength
lib:AddRecipe(11150, 13612, nil) -- Enchant Gloves - Mining
lib:AddRecipe(11151, 13617, nil) -- Enchant Gloves - Herbalism
lib:AddRecipe(11152, 13620, nil) -- Enchant Gloves - Fishing
lib:AddRecipe(11163, 13646, nil) -- Enchant Bracer - Lesser Deflection
lib:AddRecipe(11164, 13653, nil) -- Enchant Weapon - Lesser Beastslayer
lib:AddRecipe(11165, 13655, nil) -- Enchant Weapon - Lesser Elemental Slayer
lib:AddRecipe(11166, 13698, nil) -- Enchant Gloves - Skinning
lib:AddRecipe(11167, 13687, nil) -- Enchant Boots - Lesser Spirit
lib:AddRecipe(11168, 13689, nil) -- Enchant Shield - Lesser Block
lib:AddRecipe(11202, 13817, nil) -- Enchant Shield - Stamina
lib:AddRecipe(11203, 13841, nil) -- Enchant Gloves - Advanced Mining
lib:AddRecipe(11204, 13846, nil) -- Enchant Bracer - Greater Spirit
lib:AddRecipe(11205, 13868, nil) -- Enchant Gloves - Advanced Herbalism
lib:AddRecipe(11206, 13882, nil) -- Enchant Cloak - Lesser Agility
lib:AddRecipe(11207, 13898, nil) -- Enchant Weapon - Fiery Weapon
lib:AddRecipe(11208, 13915, nil) -- Enchant Weapon - Demonslaying
lib:AddRecipe(11223, 13931, nil) -- Enchant Bracer - Deflection
lib:AddRecipe(11224, 13933, nil) -- Enchant Shield - Frost Resistance
lib:AddRecipe(11225, 13945, nil) -- Enchant Bracer - Greater Stamina
lib:AddRecipe(11226, 13947, nil) -- Enchant Gloves - Riding Skill
lib:AddRecipe(11813, 15596, 11811) -- Smoking Heart of the Mountain
lib:AddRecipe(16214, 20008, nil) -- Enchant Bracer - Greater Intellect
lib:AddRecipe(16215, 20020, nil) -- Enchant Boots - Greater Stamina
lib:AddRecipe(16216, 20014, nil) -- Enchant Cloak - Greater Resistance
lib:AddRecipe(16217, 20017, nil) -- Enchant Shield - Greater Stamina
lib:AddRecipe(16218, 20009, nil) -- Enchant Bracer - Superior Spirit
lib:AddRecipe(16219, 20012, nil) -- Enchant Gloves - Greater Agility
lib:AddRecipe(16220, 20024, nil) -- Enchant Boots - Spirit
lib:AddRecipe(16221, 20026, nil) -- Enchant Chest - Major Health
lib:AddRecipe(16222, 20016, nil) -- Enchant Shield - Superior Spirit
lib:AddRecipe(16223, 20029, nil) -- Enchant Weapon - Icy Chill
lib:AddRecipe(16224, 20015, nil) -- Enchant Cloak - Superior Defense
lib:AddRecipe(16242, 20028, nil) -- Enchant Chest - Major Mana
lib:AddRecipe(16243, 20051, 16207) -- Runed Arcanite Rod
lib:AddRecipe(16244, 20013, nil) -- Enchant Gloves - Greater Strength
lib:AddRecipe(16245, 20023, nil) -- Enchant Boots - Greater Agility
lib:AddRecipe(16246, 20010, nil) -- Enchant Bracer - Superior Strength
lib:AddRecipe(16247, 20030, nil) -- Enchant 2H Weapon - Superior Impact
lib:AddRecipe(16248, 20033, nil) -- Enchant Weapon - Unholy Weapon
lib:AddRecipe(16249, 20036, nil) -- Enchant 2H Weapon - Major Intellect
lib:AddRecipe(16250, 20031, nil) -- Enchant Weapon - Superior Striking
lib:AddRecipe(16251, 20011, nil) -- Enchant Bracer - Superior Stamina
lib:AddRecipe(16252, 20034, nil) -- Enchant Weapon - Crusader
lib:AddRecipe(16253, 20025, nil) -- Enchant Chest - Greater Stats
lib:AddRecipe(16254, 20032, nil) -- Enchant Weapon - Lifestealing
lib:AddRecipe(16255, 20035, nil) -- Enchant 2H Weapon - Major Spirit
lib:AddRecipe(17725, 21931, nil) -- Enchant Weapon - Winter's Might
lib:AddRecipe(18259, 22749, nil) -- Enchant Weapon - Spell Power
lib:AddRecipe(18260, 22750, nil) -- Enchant Weapon - Healing Power
lib:AddRecipe(19444, 23799, nil) -- Enchant Weapon - Strength
lib:AddRecipe(19445, 23800, nil) -- Enchant Weapon - Agility
lib:AddRecipe(19446, 23801, nil) -- Enchant Bracer - Mana Regeneration
lib:AddRecipe(19447, 23802, nil) -- Enchant Bracer - Healing Power
lib:AddRecipe(19448, 23803, nil) -- Enchant Weapon - Mighty Spirit
lib:AddRecipe(19449, 23804, nil) -- Enchant Weapon - Mighty Intellect
lib:AddRecipe(20726, 25072, nil) -- Enchant Gloves - Threat
lib:AddRecipe(20727, 25073, nil) -- Enchant Gloves - Shadow Power
lib:AddRecipe(20728, 25074, nil) -- Enchant Gloves - Frost Power
lib:AddRecipe(20729, 25078, nil) -- Enchant Gloves - Fire Power
lib:AddRecipe(20730, 25079, nil) -- Enchant Gloves - Healing Power
lib:AddRecipe(20731, 25080, nil) -- Enchant Gloves - Superior Agility
lib:AddRecipe(20732, 25081, nil) -- Enchant Cloak - Greater Fire Resistance
lib:AddRecipe(20733, 25082, nil) -- Enchant Cloak - Greater Nature Resistance
lib:AddRecipe(20734, 25083, nil) -- Enchant Cloak - Stealth
lib:AddRecipe(20735, 25084, nil) -- Enchant Cloak - Subtlety
lib:AddRecipe(20736, 25086, nil) -- Enchant Cloak - Dodge
lib:AddRecipe(20752, 25125, 20745) -- Minor Mana Oil
lib:AddRecipe(20753, 25126, 20746) -- Lesser Wizard Oil
lib:AddRecipe(20754, 25127, 20747) -- Lesser Mana Oil
lib:AddRecipe(20755, 25128, 20750) -- Wizard Oil
lib:AddRecipe(20756, 25129, 20749) -- Brilliant Wizard Oil
lib:AddRecipe(20757, 25130, 20748) -- Brilliant Mana Oil
lib:AddRecipe(20758, 25124, 20744) -- Minor Wizard Oil
lib:AddRecipe(22392, 27837, nil) -- Enchant 2H Weapon - Agility
-- Engineering
lib:AddRecipe(4408, 3928, 4401) -- Mechanical Squirrel
lib:AddRecipe(4409, 3933, 4367) -- Small Seaforium Charge
lib:AddRecipe(4410, 3940, 4373) -- Shadow Goggles
lib:AddRecipe(4411, 3944, 4376) -- Flame Deflector
lib:AddRecipe(4412, 3954, 4383) -- Moonsight Rifle
lib:AddRecipe(4413, 3959, 4388) -- Discombobulator Ray
lib:AddRecipe(4414, 3960, 4403) -- Portable Bronze Mortar
lib:AddRecipe(4415, 3966, 4393) -- Craftsman's Monocle
lib:AddRecipe(4416, 3968, 4395) -- Goblin Land Mine
lib:AddRecipe(4417, 3972, 4398) -- Large Seaforium Charge
lib:AddRecipe(6672, 8243, 4852) -- Flash Bomb
lib:AddRecipe(6716, 8339, 6714) -- EZ-Thro Dynamite
lib:AddRecipe(7192, 8895, 7189) -- Goblin Rocket Boots
lib:AddRecipe(7560, 9269, 7506) -- Gnomish Universal Remote
lib:AddRecipe(7561, 9273, 7148) -- Goblin Jumper Cables
lib:AddRecipe(7742, 3971, 4397) -- Gnomish Cloaking Device
lib:AddRecipe(10601, 12587, 10499) -- Bright-Eye Goggles
lib:AddRecipe(10602, 12597, 10546) -- Deadly Scope
lib:AddRecipe(10603, 12607, 10501) -- Catseye Ultra Goggles
lib:AddRecipe(10604, 12614, 10510) -- Mithril Heavy-bore Rifle
lib:AddRecipe(10605, 12615, 10502) -- Spellpower Goggles Xtreme
lib:AddRecipe(10606, 12616, 10518) -- Parachute Cloak
lib:AddRecipe(10607, 12617, 10506) -- Deepdive Helmet
lib:AddRecipe(10608, 12620, 10548) -- Sniper Scope
lib:AddRecipe(10609, 12624, 10576) -- Mithril Mechanical Dragonling
lib:AddRecipe(11827, 15633, 11826) -- Lil' Smoky
lib:AddRecipe(11828, 15628, 11825) -- Pet Bombling
lib:AddRecipe(13308, 3957, 4386) -- Ice Deflector
lib:AddRecipe(13309, 3939, 4372) -- Lovingly Crafted Boomstick
lib:AddRecipe(13310, 3979, 4407) -- Accurate Scope
lib:AddRecipe(13311, 3969, 4396) -- Mechanical Dragonling
lib:AddRecipe(14639, 3952, 4381) -- Minor Recombobulator
lib:AddRecipe(16041, 19790, 15993) -- Thorium Grenade
lib:AddRecipe(16042, 19791, 15994) -- Thorium Widget
lib:AddRecipe(16043, 19792, 15995) -- Thorium Rifle
lib:AddRecipe(16044, 19793, 15996) -- Lifelike Mechanical Toad
lib:AddRecipe(16045, 19794, 15999) -- Spellpower Goggles Xtreme Plus
lib:AddRecipe(16046, 19814, 16023) -- Masterwork Target Dummy
lib:AddRecipe(16047, 19795, 16000) -- Thorium Tube
lib:AddRecipe(16048, 19796, 16004) -- Dark Iron Rifle
lib:AddRecipe(16049, 19799, 16005) -- Dark Iron Bomb
lib:AddRecipe(16050, 19815, 16006) -- Delicate Arcanite Converter
lib:AddRecipe(16051, 19800, 15997) -- Thorium Shells
lib:AddRecipe(16052, 19819, 16009) -- Voice Amplification Modulator
lib:AddRecipe(16053, 19825, 16008) -- Master Engineer's Goggles
lib:AddRecipe(16054, 19830, 16022) -- Arcanite Dragonling
lib:AddRecipe(16055, 19831, 16040) -- Arcane Bomb
lib:AddRecipe(16056, 19833, 16007) -- Flawless Arcanite Rifle
lib:AddRecipe(17720, 21940, 17716) -- SnowMaster 9000
lib:AddRecipe(18235, 22704, 18232) -- Field Repair Bot 74A
lib:AddRecipe(18290, 22793, 18283) -- Biznicks 247x128 Accurascope
lib:AddRecipe(18291, 22797, 18168) -- Force Reactive Disk
lib:AddRecipe(18292, 22795, 18282) -- Core Marksman Rifle
lib:AddRecipe(18647, 23066, 9318) -- Red Firework
lib:AddRecipe(18648, 23068, 9313) -- Green Firework
lib:AddRecipe(18649, 23067, 9312) -- Blue Firework
lib:AddRecipe(18650, 23069, 18588) -- EZ-Thro Dynamite II
lib:AddRecipe(18651, 23071, 18631) -- Truesilver Transformer
lib:AddRecipe(18652, 23077, 18634) -- Gyrofreeze Ice Reflector
lib:AddRecipe(18653, 23078, 18587) -- Goblin Jumper Cables XL
lib:AddRecipe(18654, 23096, 18645) -- Alarm-O-Bot
lib:AddRecipe(18655, 23079, 18637) -- Major Recombobulator
lib:AddRecipe(18656, 23080, 18594) -- Powerful Seaforium Charge
lib:AddRecipe(18657, 23081, 18638) -- Hyper-Radiant Flame Reflector
lib:AddRecipe(18658, 23082, 18639) -- Ultra-Flash Shadow Reflector
lib:AddRecipe(18661, 23129, 18660) -- World Enlarger
lib:AddRecipe(19027, 23507, 19026) -- Snake Burst Firework
lib:AddRecipe(20000, 24356, 19999) -- Bloodvine Goggles
lib:AddRecipe(20001, 24357, 19998) -- Bloodvine Lens
lib:AddRecipe(21724, 26416, 21558) -- Small Blue Rocket
lib:AddRecipe(21725, 26417, 21559) -- Small Green Rocket
lib:AddRecipe(21726, 26418, 21557) -- Small Red Rocket
lib:AddRecipe(21727, 26420, 21589) -- Large Blue Rocket
lib:AddRecipe(21728, 26421, 21590) -- Large Green Rocket
lib:AddRecipe(21729, 26422, 21592) -- Large Red Rocket
lib:AddRecipe(21730, 26423, 21571) -- Blue Rocket Cluster
lib:AddRecipe(21731, 26424, 21574) -- Green Rocket Cluster
lib:AddRecipe(21732, 26425, 21576) -- Red Rocket Cluster
lib:AddRecipe(21733, 26426, 21714) -- Large Blue Rocket Cluster
lib:AddRecipe(21734, 26427, 21716) -- Large Green Rocket Cluster
lib:AddRecipe(21735, 26428, 21718) -- Large Red Rocket Cluster
lib:AddRecipe(21737, 26443, 21570) -- Firework Cluster Launcher
lib:AddRecipe(21738, 26442, 21569) -- Firework Launcher
lib:AddRecipe(22729, 28327, 22728) -- Steam Tonk Controller
-- First Aid
lib:AddRecipe(6454, 7935, 6453) -- Strong Anti-Venom
lib:AddRecipe(16112, 7929, 6451) -- Heavy Silk Bandage
lib:AddRecipe(16113, 10840, 8544) -- Mageweave Bandage
lib:AddRecipe(19442, 23787, 19440) -- Powerful Anti-Venom
lib:AddRecipe(23689, 30021, 23684) -- Crystal Infused Bandage
-- Leatherworking
lib:AddRecipe(2406, 2158, 2307) -- Fine Leather Boots
lib:AddRecipe(2407, 2163, 2311) -- White Leather Jerkin
lib:AddRecipe(2408, 2164, 2312) -- Fine Leather Gloves
lib:AddRecipe(2409, 2169, 2317) -- Dark Leather Tunic
lib:AddRecipe(4293, 3762, 4244) -- Hillman's Leather Vest
lib:AddRecipe(4294, 3767, 4250) -- Hillman's Belt
lib:AddRecipe(4295, 7153, 5965) -- Guardian Cloak
lib:AddRecipe(4296, 3769, 4252) -- Dark Leather Shoulders
lib:AddRecipe(4297, 3771, 4254) -- Barbaric Gloves
lib:AddRecipe(4298, 3775, 4258) -- Guardian Belt
lib:AddRecipe(4299, 3773, 4256) -- Guardian Armor
lib:AddRecipe(4300, 3777, 4260) -- Guardian Leather Bracers
lib:AddRecipe(4301, 3779, 4264) -- Barbaric Belt
lib:AddRecipe(5083, 5244, 5081) -- Kodo Hide Bag
lib:AddRecipe(5786, 6702, 5780) -- Murloc Scale Belt
lib:AddRecipe(5787, 6703, 5781) -- Murloc Scale Breastplate
lib:AddRecipe(5788, 6704, 5782) -- Thick Murloc Armor
lib:AddRecipe(5789, 6705, 5783) -- Murloc Scale Bracers
lib:AddRecipe(5972, 7133, 5958) -- Fine Leather Pants
lib:AddRecipe(5973, 7149, 5963) -- Barbaric Leggings
lib:AddRecipe(5974, 7153, 5965) -- Guardian Cloak
lib:AddRecipe(6474, 7953, 6466) -- Deviate Scale Cloak
lib:AddRecipe(6475, 7954, 6467) -- Deviate Scale Gloves
lib:AddRecipe(6476, 7955, 6468) -- Deviate Scale Belt
lib:AddRecipe(6710, 8322, 6709) -- Moonglow Vest
lib:AddRecipe(7288, 9064, 7280) -- Rugged Leather Pants
lib:AddRecipe(7289, 9070, 7283) -- Black Whelp Cloak
lib:AddRecipe(7290, 9072, 7284) -- Red Whelp Gloves
lib:AddRecipe(7360, 3765, 4248) -- Dark Leather Gloves
lib:AddRecipe(7361, 9146, 7349) -- Herbalist's Gloves
lib:AddRecipe(7362, 9147, 7352) -- Earthen Leather Shoulders
lib:AddRecipe(7363, 9148, 7358) -- Pilferer's Gloves
lib:AddRecipe(7364, 9149, 7359) -- Heavy Earthen Gloves
lib:AddRecipe(7449, 9195, 7373) -- Dusky Leather Leggings
lib:AddRecipe(7450, 9197, 7375) -- Green Whelp Armor
lib:AddRecipe(7451, 9202, 7386) -- Green Whelp Bracers
lib:AddRecipe(7452, 9207, 7390) -- Dusky Boots
lib:AddRecipe(7453, 9208, 7391) -- Swift Boots
lib:AddRecipe(7613, 3772, 4255) -- Green Leather Armor
lib:AddRecipe(8384, 10490, 8174) -- Comfortable Leather Hat
lib:AddRecipe(8385, 10509, 8187) -- Turtle Scale Gloves
lib:AddRecipe(8386, 10520, 8200) -- Big Voodoo Robe
lib:AddRecipe(8387, 10531, 8201) -- Big Voodoo Mask
lib:AddRecipe(8388, 10550, 8195) -- Nightscape Cloak
lib:AddRecipe(8389, 10560, 8202) -- Big Voodoo Pants
lib:AddRecipe(8390, 10562, 8216) -- Big Voodoo Cloak
lib:AddRecipe(8395, 10525, 8203) -- Tough Scorpid Breastplate
lib:AddRecipe(8397, 10533, 8205) -- Tough Scorpid Bracers
lib:AddRecipe(8398, 10542, 8204) -- Tough Scorpid Gloves
lib:AddRecipe(8399, 10554, 8209) -- Tough Scorpid Boots
lib:AddRecipe(8400, 10564, 8207) -- Tough Scorpid Shoulders
lib:AddRecipe(8401, 10568, 8206) -- Tough Scorpid Leggings
lib:AddRecipe(8402, 10570, 8208) -- Tough Scorpid Helm
lib:AddRecipe(8403, 10529, 8210) -- Wild Leather Shoulders
lib:AddRecipe(8404, 10544, 8211) -- Wild Leather Vest
lib:AddRecipe(8405, 10546, 8214) -- Wild Leather Helmet
lib:AddRecipe(8406, 10566, 8213) -- Wild Leather Boots
lib:AddRecipe(8407, 10572, 8212) -- Wild Leather Leggings
lib:AddRecipe(8408, 10574, 8215) -- Wild Leather Cloak
lib:AddRecipe(8409, 10516, 8192) -- Nightscape Shoulders
lib:AddRecipe(13287, 4096, 4455) -- Raptor Hide Harness
lib:AddRecipe(13288, 4097, 4456) -- Raptor Hide Belt
lib:AddRecipe(14635, 3778, 4262) -- Gem-studded Leather Belt
lib:AddRecipe(15724, 19048, 15077) -- Heavy Scorpid Bracers
lib:AddRecipe(15725, 19049, 15083) -- Wicked Leather Gauntlets
lib:AddRecipe(15726, 19050, 15045) -- Green Dragonscale Breastplate
lib:AddRecipe(15727, 19051, 15076) -- Heavy Scorpid Vest
lib:AddRecipe(15728, 19052, 15084) -- Wicked Leather Bracers
lib:AddRecipe(15729, 19053, 15074) -- Chimeric Gloves
lib:AddRecipe(15730, 19054, 15047) -- Red Dragonscale Breastplate
lib:AddRecipe(15731, 19055, 15091) -- Runic Leather Gauntlets
lib:AddRecipe(15732, 19059, 15054) -- Volcanic Leggings
lib:AddRecipe(15733, 19060, 15046) -- Green Dragonscale Leggings
lib:AddRecipe(15734, 19061, 15061) -- Living Shoulders
lib:AddRecipe(15735, 19062, 15067) -- Ironfeather Shoulders
lib:AddRecipe(15737, 19063, 15073) -- Chimeric Boots
lib:AddRecipe(15738, 19064, 15078) -- Heavy Scorpid Gauntlets
lib:AddRecipe(15739, 19065, 15092) -- Runic Leather Bracers
lib:AddRecipe(15740, 19066, 15071) -- Frostsaber Boots
lib:AddRecipe(15741, 19067, 15057) -- Stormshroud Pants
lib:AddRecipe(15742, 19068, 15064) -- Warbear Harness
lib:AddRecipe(15743, 19070, 15082) -- Heavy Scorpid Belt
lib:AddRecipe(15744, 19071, 15086) -- Wicked Leather Headband
lib:AddRecipe(15745, 19072, 15093) -- Runic Leather Belt
lib:AddRecipe(15746, 19073, 15072) -- Chimeric Leggings
lib:AddRecipe(15747, 19074, 15069) -- Frostsaber Leggings
lib:AddRecipe(15748, 19075, 15079) -- Heavy Scorpid Leggings
lib:AddRecipe(15749, 19076, 15053) -- Volcanic Breastplate
lib:AddRecipe(15751, 19077, 15048) -- Blue Dragonscale Breastplate
lib:AddRecipe(15752, 19078, 15060) -- Living Leggings
lib:AddRecipe(15753, 19079, 15056) -- Stormshroud Armor
lib:AddRecipe(15754, 19080, 15065) -- Warbear Woolies
lib:AddRecipe(15755, 19081, 15075) -- Chimeric Vest
lib:AddRecipe(15756, 19082, 15094) -- Runic Leather Headband
lib:AddRecipe(15757, 19083, 15087) -- Wicked Leather Pants
lib:AddRecipe(15758, 19084, 15063) -- Devilsaur Gauntlets
lib:AddRecipe(15759, 19085, 15050) -- Black Dragonscale Breastplate
lib:AddRecipe(15760, 19086, 15066) -- Ironfeather Breastplate
lib:AddRecipe(15761, 19087, 15070) -- Frostsaber Gloves
lib:AddRecipe(15762, 19088, 15080) -- Heavy Scorpid Helm
lib:AddRecipe(15763, 19089, 15049) -- Blue Dragonscale Shoulders
lib:AddRecipe(15764, 19090, 15058) -- Stormshroud Shoulders
lib:AddRecipe(15765, 19091, 15095) -- Runic Leather Pants
lib:AddRecipe(15768, 19092, 15088) -- Wicked Leather Belt
lib:AddRecipe(15769, 19093, 15138) -- Onyxia Scale Cloak
lib:AddRecipe(15770, 19094, 15051) -- Black Dragonscale Shoulders
lib:AddRecipe(15771, 19095, 15059) -- Living Breastplate
lib:AddRecipe(15772, 19097, 15062) -- Devilsaur Leggings
lib:AddRecipe(15773, 19098, 15085) -- Wicked Leather Armor
lib:AddRecipe(15774, 19100, 15081) -- Heavy Scorpid Shoulders
lib:AddRecipe(15775, 19101, 15055) -- Volcanic Shoulders
lib:AddRecipe(15776, 19102, 15090) -- Runic Leather Armor
lib:AddRecipe(15777, 19103, 15096) -- Runic Leather Shoulders
lib:AddRecipe(15779, 19104, 15068) -- Frostsaber Tunic
lib:AddRecipe(15781, 19107, 15052) -- Black Dragonscale Leggings
lib:AddRecipe(17022, 20853, 16982) -- Corehound Boots
lib:AddRecipe(17023, 20854, 16983) -- Molten Helm
lib:AddRecipe(17025, 20855, 16984) -- Black Dragonscale Boots
lib:AddRecipe(17722, 21943, 17721) -- Gloves of the Greatfather
lib:AddRecipe(18239, 22711, 18238) -- Shadowskin Gloves
lib:AddRecipe(18252, 22727, 18251) -- Core Armor Kit
lib:AddRecipe(18514, 22921, 18504) -- Girdle of Insight
lib:AddRecipe(18515, 22922, 18506) -- Mongoose Boots
lib:AddRecipe(18516, 22923, 18508) -- Swift Flight Bracers
lib:AddRecipe(18517, 22926, 18509) -- Chromatic Cloak
lib:AddRecipe(18518, 22927, 18510) -- Hide of the Wild
lib:AddRecipe(18519, 22928, 18511) -- Shifting Cloak
lib:AddRecipe(18731, 23190, 18662) -- Heavy Leather Ball
lib:AddRecipe(18949, 23399, 18948) -- Barbaric Bracers
lib:AddRecipe(19326, 23703, 19044) -- Might of the Timbermaw
lib:AddRecipe(19327, 23704, 19049) -- Timbermaw Brawlers
lib:AddRecipe(19328, 23705, 19052) -- Dawn Treaders
lib:AddRecipe(19329, 23706, 19058) -- Golden Mantle of the Dawn
lib:AddRecipe(19330, 23707, 19149) -- Lava Belt
lib:AddRecipe(19331, 23708, 19157) -- Chromatic Gauntlets
lib:AddRecipe(19332, 23709, 19162) -- Corehound Belt
lib:AddRecipe(19333, 23710, 19163) -- Molten Belt
lib:AddRecipe(19769, 24121, 19685) -- Primal Batskin Jerkin
lib:AddRecipe(19770, 24122, 19686) -- Primal Batskin Gloves
lib:AddRecipe(19771, 24123, 19687) -- Primal Batskin Bracers
lib:AddRecipe(19772, 24124, 19688) -- Blood Tiger Breastplate
lib:AddRecipe(19773, 24125, 19689) -- Blood Tiger Shoulders
lib:AddRecipe(20253, 19068, 15064) -- Warbear Harness
lib:AddRecipe(20254, 19080, 15065) -- Warbear Woolies
lib:AddRecipe(20382, 24703, 20380) -- Dreamscale Breastplate
lib:AddRecipe(20506, 24846, 20481) -- Spitfire Bracers
lib:AddRecipe(20507, 24847, 20480) -- Spitfire Gauntlets
lib:AddRecipe(20508, 24848, 20479) -- Spitfire Breastplate
lib:AddRecipe(20509, 24849, 20476) -- Sandstalker Bracers
lib:AddRecipe(20510, 24850, 20477) -- Sandstalker Gauntlets
lib:AddRecipe(20511, 24851, 20478) -- Sandstalker Breastplate
lib:AddRecipe(20576, 24940, 20575) -- Black Whelp Tunic
lib:AddRecipe(21548, 26279, 21278) -- Stormshroud Gloves
lib:AddRecipe(22692, 28219, 22661) -- Polar Tunic
lib:AddRecipe(22694, 28220, 22662) -- Polar Gloves
lib:AddRecipe(22695, 28221, 22663) -- Polar Bracers
lib:AddRecipe(22696, 28222, 22664) -- Icy Scale Breastplate
lib:AddRecipe(22697, 28223, 22666) -- Icy Scale Gauntlets
lib:AddRecipe(22698, 28224, 22665) -- Icy Scale Bracers
lib:AddRecipe(22769, 28474, 22761) -- Bramblewood Belt
lib:AddRecipe(22770, 28473, 22760) -- Bramblewood Boots
lib:AddRecipe(22771, 28472, 22759) -- Bramblewood Helm
-- Mining
-- Tailoring
lib:AddRecipe(2598, 2389, 2572) -- Red Linen Robe
lib:AddRecipe(2601, 2403, 2585) -- Gray Woolen Robe
lib:AddRecipe(4292, 3758, 4241) -- Green Woolen Bag
lib:AddRecipe(4345, 3847, 4313) -- Red Woolen Boots
lib:AddRecipe(4346, 3844, 4311) -- Heavy Woolen Cloak
lib:AddRecipe(4347, 3849, 4315) -- Reinforced Woolen Shoulders
lib:AddRecipe(4348, 3868, 4331) -- Phoenix Gloves
lib:AddRecipe(4349, 3851, 4317) -- Phoenix Pants
lib:AddRecipe(4350, 3856, 4321) -- Spider Silk Slippers
lib:AddRecipe(4351, 3858, 4323) -- Shadow Hood
lib:AddRecipe(4352, 3860, 4325) -- Boots of the Enchanter
lib:AddRecipe(4353, 3863, 4328) -- Spider Belt
lib:AddRecipe(4354, 3872, 4335) -- Rich Purple Silk Shirt
lib:AddRecipe(4355, 3862, 4327) -- Icy Cloak
lib:AddRecipe(4356, 3864, 4329) -- Star Belt
lib:AddRecipe(5771, 6686, 5762) -- Red Linen Bag
lib:AddRecipe(5772, 6688, 5763) -- Red Woolen Bag
lib:AddRecipe(5773, 6692, 5770) -- Robes of Arcana
lib:AddRecipe(5774, 6693, 5764) -- Green Silk Pack
lib:AddRecipe(5775, 6695, 5765) -- Black Silk Pack
lib:AddRecipe(6270, 7630, 6240) -- Blue Linen Vest
lib:AddRecipe(6271, 7629, 6239) -- Red Linen Vest
lib:AddRecipe(6272, 7633, 6242) -- Blue Linen Robe
lib:AddRecipe(6273, 7636, 6243) -- Green Woolen Robe
lib:AddRecipe(6274, 7639, 6263) -- Blue Overalls
lib:AddRecipe(6275, 7643, 6264) -- Greater Adept's Robe
lib:AddRecipe(6390, 7892, 6384) -- Stylish Blue Shirt
lib:AddRecipe(6391, 7893, 6385) -- Stylish Green Shirt
lib:AddRecipe(6401, 3870, 4333) -- Dark Silk Shirt
lib:AddRecipe(7084, 8793, 7059) -- Crimson Silk Shoulders
lib:AddRecipe(7085, 8795, 7060) -- Azure Shoulders
lib:AddRecipe(7086, 8797, 7061) -- Earthen Silk Belt
lib:AddRecipe(7087, 8789, 7056) -- Crimson Silk Cloak
lib:AddRecipe(7088, 8802, 7063) -- Crimson Silk Robe
lib:AddRecipe(7089, 8786, 7053) -- Azure Silk Cloak
lib:AddRecipe(7090, 8784, 7065) -- Green Silk Armor
lib:AddRecipe(7091, 8782, 7049) -- Truefaith Gloves
lib:AddRecipe(7092, 8780, 7047) -- Hands of Darkness
lib:AddRecipe(7093, 8778, 7027) -- Boots of Darkness
lib:AddRecipe(7114, 3854, 4319) -- Azure Silk Gloves
lib:AddRecipe(10300, 12056, 10007) -- Red Mageweave Vest
lib:AddRecipe(10301, 12059, 10008) -- White Bandit Mask
lib:AddRecipe(10302, 12060, 10009) -- Red Mageweave Pants
lib:AddRecipe(10303, 12062, 10010) -- Stormcloth Pants
lib:AddRecipe(10304, 12063, 10011) -- Stormcloth Gloves
lib:AddRecipe(10311, 12064, 10052) -- Orange Martial Shirt
lib:AddRecipe(10312, 12066, 10018) -- Red Mageweave Gloves
lib:AddRecipe(10313, 12068, 10020) -- Stormcloth Vest
lib:AddRecipe(10314, 12075, 10054) -- Lavender Mageweave Shirt
lib:AddRecipe(10315, 12078, 10029) -- Red Mageweave Shoulders
lib:AddRecipe(10316, 12047, 10048) -- Colorful Kilt
lib:AddRecipe(10317, 12080, 10055) -- Pink Mageweave Shirt
lib:AddRecipe(10318, 12081, 10030) -- Admiral's Hat
lib:AddRecipe(10319, 12083, 10032) -- Stormcloth Headband
lib:AddRecipe(10320, 12084, 10033) -- Red Mageweave Headband
lib:AddRecipe(10321, 12085, 10034) -- Tuxedo Shirt
lib:AddRecipe(10322, 12087, 10038) -- Stormcloth Shoulders
lib:AddRecipe(10323, 12089, 10035) -- Tuxedo Pants
lib:AddRecipe(10324, 12090, 10039) -- Stormcloth Boots
lib:AddRecipe(10325, 12091, 10040) -- White Wedding Dress
lib:AddRecipe(10326, 12093, 10036) -- Tuxedo Jacket
lib:AddRecipe(10463, 12086, 10025) -- Shadoweave Mask
lib:AddRecipe(10728, 3873, 4336) -- Black Swashbuckler's Shirt
lib:AddRecipe(14466, 18403, 13869) -- Frostweave Tunic
lib:AddRecipe(14467, 18404, 13868) -- Frostweave Robe
lib:AddRecipe(14468, 18405, 14046) -- Runecloth Bag
lib:AddRecipe(14469, 18406, 13858) -- Runecloth Robe
lib:AddRecipe(14470, 18407, 13857) -- Runecloth Tunic
lib:AddRecipe(14471, 18408, 14042) -- Cindercloth Vest
lib:AddRecipe(14472, 18409, 13860) -- Runecloth Cloak
lib:AddRecipe(14473, 18410, 14143) -- Ghostweave Belt
lib:AddRecipe(14474, 18411, 13870) -- Frostweave Gloves
lib:AddRecipe(14476, 18412, 14043) -- Cindercloth Gloves
lib:AddRecipe(14477, 18413, 14142) -- Ghostweave Gloves
lib:AddRecipe(14478, 18414, 14100) -- Brightcloth Robe
lib:AddRecipe(14479, 18415, 14101) -- Brightcloth Gloves
lib:AddRecipe(14480, 18416, 14141) -- Ghostweave Vest
lib:AddRecipe(14481, 18417, 13863) -- Runecloth Gloves
lib:AddRecipe(14482, 18418, 14044) -- Cindercloth Cloak
lib:AddRecipe(14483, 18419, 14107) -- Felcloth Pants
lib:AddRecipe(14484, 18420, 14103) -- Brightcloth Cloak
lib:AddRecipe(14485, 18421, 14132) -- Wizardweave Leggings
lib:AddRecipe(14486, 18422, 14134) -- Cloak of Fire
lib:AddRecipe(14488, 18423, 13864) -- Runecloth Boots
lib:AddRecipe(14489, 18424, 13871) -- Frostweave Pants
lib:AddRecipe(14490, 18434, 14045) -- Cindercloth Pants
lib:AddRecipe(14491, 18438, 13865) -- Runecloth Pants
lib:AddRecipe(14492, 18437, 14108) -- Felcloth Boots
lib:AddRecipe(14493, 18436, 14136) -- Robe of Winter Night
lib:AddRecipe(14494, 18439, 14104) -- Brightcloth Pants
lib:AddRecipe(14495, 18441, 14144) -- Ghostweave Pants
lib:AddRecipe(14496, 18442, 14111) -- Felcloth Hood
lib:AddRecipe(14497, 18440, 14137) -- Mooncloth Leggings
lib:AddRecipe(14498, 18444, 13866) -- Runecloth Headband
lib:AddRecipe(14499, 18445, 14155) -- Mooncloth Bag
lib:AddRecipe(14500, 18446, 14128) -- Wizardweave Robe
lib:AddRecipe(14501, 18447, 14138) -- Mooncloth Vest
lib:AddRecipe(14504, 18449, 13867) -- Runecloth Shoulders
lib:AddRecipe(14505, 18450, 14130) -- Wizardweave Turban
lib:AddRecipe(14506, 18451, 14106) -- Felcloth Robe
lib:AddRecipe(14507, 18448, 14139) -- Mooncloth Shoulders
lib:AddRecipe(14508, 18453, 14112) -- Felcloth Shoulders
lib:AddRecipe(14509, 18452, 14140) -- Mooncloth Circlet
lib:AddRecipe(14510, 18455, 14156) -- Bottomless Bag
lib:AddRecipe(14511, 18454, 14146) -- Gloves of Spell Mastery
lib:AddRecipe(14512, 18456, 14154) -- Truefaith Vestments
lib:AddRecipe(14513, 18457, 14152) -- Robe of the Archmage
lib:AddRecipe(14514, 18458, 14153) -- Robe of the Void
lib:AddRecipe(14526, 18560, 14342) -- Mooncloth
lib:AddRecipe(14627, 3869, 4332) -- Bright Yellow Shirt
lib:AddRecipe(14630, 3857, 4322) -- Enchanter's Cowl
lib:AddRecipe(17017, 20848, 16980) -- Flarecore Mantle
lib:AddRecipe(17018, 20849, 16979) -- Flarecore Gloves
lib:AddRecipe(17724, 21945, 17723) -- Green Holiday Shirt
lib:AddRecipe(18265, 22759, 18263) -- Flarecore Wraps
lib:AddRecipe(18414, 22866, 18405) -- Belt of the Archmage
lib:AddRecipe(18415, 22867, 18407) -- Felcloth Gloves
lib:AddRecipe(18416, 22868, 18408) -- Inferno Gloves
lib:AddRecipe(18417, 22869, 18409) -- Mooncloth Gloves
lib:AddRecipe(18418, 22870, 18413) -- Cloak of Warding
lib:AddRecipe(18487, 22902, 18486) -- Mooncloth Robe
lib:AddRecipe(19215, 23662, 19047) -- Wisdom of the Timbermaw
lib:AddRecipe(19216, 23664, 19056) -- Argent Boots
lib:AddRecipe(19217, 23665, 19059) -- Argent Shoulders
lib:AddRecipe(19218, 23663, 19050) -- Mantle of the Timbermaw
lib:AddRecipe(19219, 23666, 19156) -- Flarecore Robe
lib:AddRecipe(19220, 23667, 19165) -- Flarecore Leggings
lib:AddRecipe(19764, 24091, 19682) -- Bloodvine Vest
lib:AddRecipe(19765, 24092, 19683) -- Bloodvine Leggings
lib:AddRecipe(19766, 24093, 19684) -- Bloodvine Boots
lib:AddRecipe(20546, 24901, 20538) -- Runed Stygian Leggings
lib:AddRecipe(20547, 24903, 20537) -- Runed Stygian Boots
lib:AddRecipe(20548, 24902, 20539) -- Runed Stygian Belt
lib:AddRecipe(21358, 26085, 21340) -- Soul Pouch
lib:AddRecipe(21369, 26086, 21341) -- Felcloth Bag
lib:AddRecipe(21371, 26087, 21342) -- Core Felcloth Bag
lib:AddRecipe(21722, 26403, 21154) -- Festive Red Dress
lib:AddRecipe(21723, 26407, 21542) -- Festive Red Pant Suit
lib:AddRecipe(22307, 27658, 22246) -- Enchanted Mageweave Pouch
lib:AddRecipe(22308, 27659, 22248) -- Enchanted Runecloth Bag
lib:AddRecipe(22309, 27660, 22249) -- Big Bag of Enchantment
lib:AddRecipe(22310, 27724, 22251) -- Cenarion Herb Bag
lib:AddRecipe(22312, 27725, 22252) -- Satchel of Cenarius
lib:AddRecipe(22683, 28210, 22660) -- Gaea's Embrace
lib:AddRecipe(22684, 28205, 22654) -- Glacial Gloves
lib:AddRecipe(22685, 28208, 22658) -- Glacial Cloak
lib:AddRecipe(22686, 28207, 22652) -- Glacial Vest
lib:AddRecipe(22687, 28209, 22655) -- Glacial Wrists
lib:AddRecipe(22772, 28482, 22758) -- Sylvan Shoulders
lib:AddRecipe(22773, 28481, 22757) -- Sylvan Crown
lib:AddRecipe(22774, 28480, 22756) -- Sylvan Vest

--------------------------------------------------------------------------------
-- End Classic Data                                                           --
end                                                                           --
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Burning Crusade Classic Data (don't forget to increase MINOR when updated) --
if lib.IsBCC then                                                             --
--------------------------------------------------------------------------------

-- Alchemy
lib:AddRecipe(2553, 3230, 2457) -- Elixir of Minor Agility
lib:AddRecipe(2555, 2335, 2459) -- Swiftness Potion
lib:AddRecipe(2556, 2336, 2460) -- Elixir of Tongues
lib:AddRecipe(3393, 3172, 3384) -- Minor Magic Resistance Potion
lib:AddRecipe(3394, 3174, 3386) -- Potion of Curing
lib:AddRecipe(3395, 3175, 3387) -- Limited Invulnerability Potion
lib:AddRecipe(3396, 2333, 3390) -- Elixir of Lesser Agility
lib:AddRecipe(3830, 3450, 3825) -- Elixir of Fortitude
lib:AddRecipe(3831, 3451, 3826) -- Mighty Troll's Blood Potion
lib:AddRecipe(3832, 3453, 3828) -- Elixir of Detect Lesser Invisibility
lib:AddRecipe(4597, 4508, 4596) -- Discolored Healing Potion
lib:AddRecipe(4624, 4942, 4623) -- Lesser Stoneshield Potion
lib:AddRecipe(5640, 6617, 5631) -- Rage Potion
lib:AddRecipe(5641, 6619, 5632) -- Cowardly Flight Potion
lib:AddRecipe(5642, 6624, 5634) -- Free Action Potion
lib:AddRecipe(5643, 6618, 5633) -- Great Rage Potion
lib:AddRecipe(6053, 7255, 6051) -- Holy Protection Potion
lib:AddRecipe(6054, 7256, 6048) -- Shadow Protection Potion
lib:AddRecipe(6055, 7257, 6049) -- Fire Protection Potion
lib:AddRecipe(6056, 7258, 6050) -- Frost Protection Potion
lib:AddRecipe(6057, 7259, 6052) -- Nature Protection Potion
lib:AddRecipe(6068, 3449, 3824) -- Shadow Oil
lib:AddRecipe(6211, 3188, 3391) -- Elixir of Ogre's Strength
lib:AddRecipe(6663, 8240, 6662) -- Elixir of Giant Growth
lib:AddRecipe(9293, 11453, 9036) -- Magic Resistance Potion
lib:AddRecipe(9294, 11458, 9144) -- Wildvine Potion
lib:AddRecipe(9295, 11464, 9172) -- Invisibility Potion
lib:AddRecipe(9296, 11466, 9088) -- Gift of Arthas
lib:AddRecipe(9297, 11468, 9197) -- Elixir of Dream Vision
lib:AddRecipe(9298, 11472, 9206) -- Elixir of Giants
lib:AddRecipe(9300, 11477, 9224) -- Elixir of Demonslaying
lib:AddRecipe(9301, 11476, 9264) -- Elixir of Shadow Power
lib:AddRecipe(9302, 11473, 9210) -- Ghost Dye
lib:AddRecipe(9303, 11459, 9149) -- Philosopher's Stone
lib:AddRecipe(9304, 11479, 3577) -- Transmute: Iron to Gold
lib:AddRecipe(9305, 11480, 6037) -- Transmute: Mithril to Truesilver
lib:AddRecipe(10644, 11456, 9061) -- Goblin Rocket Fuel
lib:AddRecipe(12958, 17187, 12360) -- Transmute: Arcanite
lib:AddRecipe(13476, 17552, 13442) -- Mighty Rage Potion
lib:AddRecipe(13477, 17553, 13443) -- Superior Mana Potion
lib:AddRecipe(13478, 17554, 13445) -- Elixir of Superior Defense
lib:AddRecipe(13479, 17555, 13447) -- Elixir of the Sages
lib:AddRecipe(13480, 17556, 13446) -- Major Healing Potion
lib:AddRecipe(13481, 17557, 13453) -- Elixir of Brute Force
lib:AddRecipe(13482, 17559, 7078) -- Transmute: Air to Fire
lib:AddRecipe(13483, 17560, 7076) -- Transmute: Fire to Earth
lib:AddRecipe(13484, 17561, 7080) -- Transmute: Earth to Water
lib:AddRecipe(13485, 17562, 7082) -- Transmute: Water to Air
lib:AddRecipe(13486, 17563, 7080) -- Transmute: Undeath to Water
lib:AddRecipe(13487, 17564, 12808) -- Transmute: Water to Undeath
lib:AddRecipe(13488, 17565, 7076) -- Transmute: Life to Earth
lib:AddRecipe(13489, 17566, 12803) -- Transmute: Earth to Life
lib:AddRecipe(13490, 17570, 13455) -- Greater Stoneshield Potion
lib:AddRecipe(13491, 17571, 13452) -- Elixir of the Mongoose
lib:AddRecipe(13492, 17572, 13462) -- Purification Potion
lib:AddRecipe(13493, 17573, 13454) -- Greater Arcane Elixir
lib:AddRecipe(13494, 17574, 13457) -- Greater Fire Protection Potion
lib:AddRecipe(13495, 17575, 13456) -- Greater Frost Protection Potion
lib:AddRecipe(13496, 17576, 13458) -- Greater Nature Protection Potion
lib:AddRecipe(13497, 17577, 13461) -- Greater Arcane Protection Potion
lib:AddRecipe(13499, 17578, 13459) -- Greater Shadow Protection Potion
lib:AddRecipe(13500, 17579, 13460) -- Greater Holy Protection Potion
lib:AddRecipe(13501, 17580, 13444) -- Major Mana Potion
lib:AddRecipe(13517, 17632, 13503) -- Alchemist's Stone
lib:AddRecipe(13518, 17634, 13506) -- Flask of Petrification
lib:AddRecipe(13519, 17635, 13510) -- Flask of the Titans
lib:AddRecipe(13520, 17636, 13511) -- Flask of Distilled Wisdom
lib:AddRecipe(13521, 17637, 13512) -- Flask of Supreme Power
lib:AddRecipe(13522, 17638, 13513) -- Flask of Chromatic Resistance
lib:AddRecipe(14634, 3454, 3829) -- Frost Oil
lib:AddRecipe(17709, 21923, 17708) -- Elixir of Frost Power
lib:AddRecipe(18257, 22732, 18253) -- Major Rejuvenation Potion
lib:AddRecipe(20011, 24365, 20007) -- Mageblood Potion
lib:AddRecipe(20012, 24366, 20002) -- Greater Dreamless Sleep Potion
lib:AddRecipe(20013, 24367, 20008) -- Living Action Potion
lib:AddRecipe(20014, 24368, 20004) -- Major Troll's Blood Potion
lib:AddRecipe(20761, 25146, 7068) -- Transmute: Elemental Fire
lib:AddRecipe(21547, 26277, 21546) -- Elixir of Greater Firepower
lib:AddRecipe(22900, 28543, 22823) -- Elixir of Camouflage
lib:AddRecipe(22901, 28546, 22826) -- Sneaking Potion
lib:AddRecipe(22902, 28549, 22827) -- Elixir of Major Frost Power
lib:AddRecipe(22903, 28550, 22828) -- Insane Strength Potion
lib:AddRecipe(22904, 28552, 22830) -- Elixir of the Searching Eye
lib:AddRecipe(22905, 28553, 22831) -- Elixir of Major Agility
lib:AddRecipe(22906, 28554, 22871) -- Shrouding Potion
lib:AddRecipe(22907, 28555, 22832) -- Super Mana Potion
lib:AddRecipe(22908, 28556, 22833) -- Elixir of Major Firepower
lib:AddRecipe(22909, 28557, 22834) -- Elixir of Major Defense
lib:AddRecipe(22910, 28558, 22835) -- Elixir of Major Shadow Power
lib:AddRecipe(22911, 28562, 22836) -- Major Dreamless Sleep Potion
lib:AddRecipe(22912, 28563, 22837) -- Heroic Potion
lib:AddRecipe(22913, 28564, 22838) -- Haste Potion
lib:AddRecipe(22914, 28565, 22839) -- Destruction Potion
lib:AddRecipe(22915, 28566, 21884) -- Transmute: Primal Air to Fire
lib:AddRecipe(22916, 28567, 21885) -- Transmute: Primal Earth to Water
lib:AddRecipe(22917, 28568, 22452) -- Transmute: Primal Fire to Earth
lib:AddRecipe(22918, 28569, 22451) -- Transmute: Primal Water to Air
lib:AddRecipe(22919, 28570, 22840) -- Elixir of Major Mageblood
lib:AddRecipe(22920, 28571, 22841) -- Major Fire Protection Potion
lib:AddRecipe(22921, 28572, 22842) -- Major Frost Protection Potion
lib:AddRecipe(22922, 28573, 22844) -- Major Nature Protection Potion
lib:AddRecipe(22923, 28575, 22845) -- Major Arcane Protection Potion
lib:AddRecipe(22924, 28576, 22846) -- Major Shadow Protection Potion
lib:AddRecipe(22925, 28577, 22847) -- Major Holy Protection Potion
lib:AddRecipe(22926, 28578, 22848) -- Elixir of Empowerment
lib:AddRecipe(22927, 28579, 22849) -- Ironshield Potion
lib:AddRecipe(23574, 29688, 23571) -- Transmute: Primal Might
lib:AddRecipe(24001, 28553, 22831) -- Elixir of Major Agility
lib:AddRecipe(25869, 32765, 25867) -- Transmute: Earthstorm Diamond
lib:AddRecipe(25870, 32766, 25868) -- Transmute: Skyfire Diamond
lib:AddRecipe(29232, 32766, 25868) -- Transmute: Skyfire Diamond
lib:AddRecipe(30443, 28568, 22452) -- Transmute: Primal Fire to Earth
lib:AddRecipe(31354, 17635, 13510) -- Flask of the Titans
lib:AddRecipe(31355, 17637, 13512) -- Flask of Supreme Power
lib:AddRecipe(31356, 17636, 13511) -- Flask of Distilled Wisdom
lib:AddRecipe(31357, 17638, 13513) -- Flask of Chromatic Resistance
lib:AddRecipe(31680, 38960, 31679) -- Fel Strength Elixir
lib:AddRecipe(31681, 38962, 31676) -- Fel Regeneration Potion
lib:AddRecipe(31682, 38961, 31677) -- Fel Mana Potion
lib:AddRecipe(32070, 39637, 32063) -- Earthen Elixir
lib:AddRecipe(32071, 39639, 32068) -- Elixir of Ironskin
lib:AddRecipe(33209, 42736, 33208) -- Flask of Chromatic Wonder
lib:AddRecipe(34481, 45061, 34440) -- Mad Alchemist's Potion
lib:AddRecipe(35294, 28578, 22848) -- Elixir of Empowerment
lib:AddRecipe(35295, 28564, 22838) -- Haste Potion
lib:AddRecipe(35752, 47046, 35748) -- Guardian's Alchemist Stone
lib:AddRecipe(35753, 47048, 35749) -- Sorcerer's Alchemist Stone
lib:AddRecipe(35754, 47049, 35750) -- Redeemer's Alchemist Stone
lib:AddRecipe(35755, 47050, 35751) -- Assassin's Alchemist Stone
-- Blacksmithing
lib:AddRecipe(2881, 2667, 2864) -- Runed Copper Breastplate
lib:AddRecipe(2882, 3330, 3481) -- Silvered Bronze Shoulders
lib:AddRecipe(2883, 3295, 3490) -- Deadly Bronze Poniard
lib:AddRecipe(3608, 3297, 3492) -- Mighty Iron Hammer
lib:AddRecipe(3609, 3321, 3471) -- Copper Chain Vest
lib:AddRecipe(3610, 3325, 3474) -- Gemmed Copper Gauntlets
lib:AddRecipe(3611, 3334, 3484) -- Green Iron Boots
lib:AddRecipe(3612, 3336, 3485) -- Green Iron Gauntlets
lib:AddRecipe(3866, 3493, 3850) -- Jade Serpentblade
lib:AddRecipe(3867, 3495, 3852) -- Golden Iron Destroyer
lib:AddRecipe(3868, 3497, 3854) -- Frost Tiger Blade
lib:AddRecipe(3869, 3500, 3856) -- Shadow Crescent Axe
lib:AddRecipe(3870, 3504, 3840) -- Green Iron Shoulders
lib:AddRecipe(3871, 3505, 3841) -- Golden Scale Shoulders
lib:AddRecipe(3872, 3507, 3843) -- Golden Scale Leggings
lib:AddRecipe(3873, 3511, 3845) -- Golden Scale Cuirass
lib:AddRecipe(3874, 3513, 3846) -- Polished Steel Boots
lib:AddRecipe(3875, 3515, 3847) -- Golden Scale Boots
lib:AddRecipe(5543, 6518, 5541) -- Iridescent Hammer
lib:AddRecipe(5577, 2671, 2867) -- Rough Bronze Bracers
lib:AddRecipe(5578, 2673, 2869) -- Silvered Bronze Breastplate
lib:AddRecipe(6044, 7221, 6042) -- Iron Shield Spike
lib:AddRecipe(6045, 7222, 6043) -- Iron Counterweight
lib:AddRecipe(6046, 7224, 6041) -- Steel Weapon Chain
lib:AddRecipe(6047, 3503, 3837) -- Golden Scale Coif
lib:AddRecipe(6734, 8366, 6730) -- Ironforge Chain
lib:AddRecipe(6735, 8367, 6731) -- Ironforge Breastplate
lib:AddRecipe(6736, 8368, 6733) -- Ironforge Gauntlets
lib:AddRecipe(7975, 9933, 7921) -- Heavy Mithril Pants
lib:AddRecipe(7976, 9939, 7967) -- Mithril Shield Spike
lib:AddRecipe(7977, 9942, 7925) -- Mithril Scale Gloves
lib:AddRecipe(7978, 9811, 7913) -- Barbaric Iron Shoulders
lib:AddRecipe(7979, 9813, 7914) -- Barbaric Iron Breastplate
lib:AddRecipe(7980, 9814, 7915) -- Barbaric Iron Helm
lib:AddRecipe(7981, 9818, 7916) -- Barbaric Iron Boots
lib:AddRecipe(7982, 9820, 7917) -- Barbaric Iron Gloves
lib:AddRecipe(7983, 9945, 7926) -- Ornate Mithril Pants
lib:AddRecipe(7984, 9950, 7927) -- Ornate Mithril Gloves
lib:AddRecipe(7985, 9952, 7928) -- Ornate Mithril Shoulder
lib:AddRecipe(7986, 9972, 7935) -- Ornate Mithril Breastplate
lib:AddRecipe(7987, 9980, 7937) -- Ornate Mithril Helm
lib:AddRecipe(7988, 9979, 7936) -- Ornate Mithril Boots
lib:AddRecipe(7989, 9964, 7969) -- Mithril Spurs
lib:AddRecipe(7990, 9970, 7934) -- Heavy Mithril Helm
lib:AddRecipe(7991, 9966, 7932) -- Mithril Scale Shoulders
lib:AddRecipe(7992, 9995, 7942) -- Blue Glittering Axe
lib:AddRecipe(7993, 10005, 7944) -- Dazzling Mithril Rapier
lib:AddRecipe(7994, 9957, 7929) -- Orcish War Leggings
lib:AddRecipe(7995, 9937, 7924) -- Mithril Scale Bracers
lib:AddRecipe(8028, 10009, 7946) -- Runed Mithril Hammer
lib:AddRecipe(8029, 9997, 7943) -- Wicked Mithril Blade
lib:AddRecipe(8030, 10013, 7947) -- Ebon Shiv
lib:AddRecipe(9367, 11643, 9366) -- Golden Scale Gauntlets
lib:AddRecipe(10424, 12259, 10423) -- Silvered Bronze Leggings
lib:AddRecipe(10713, 11454, 9060) -- Inlaid Mithril Cylinder
lib:AddRecipe(10858, 3494, 3851) -- Solid Iron Maul
lib:AddRecipe(11610, 15292, 11608) -- Dark Iron Pulverizer
lib:AddRecipe(11611, 15294, 11607) -- Dark Iron Sunderer
lib:AddRecipe(11612, 15296, 11604) -- Dark Iron Plate
lib:AddRecipe(11614, 15293, 11606) -- Dark Iron Mail
lib:AddRecipe(11615, 15295, 11605) -- Dark Iron Shoulders
lib:AddRecipe(12162, 3492, 3849) -- Hardened Iron Shortsword
lib:AddRecipe(12163, 3496, 3853) -- Moonsteel Broadsword
lib:AddRecipe(12164, 3498, 3855) -- Massive Iron Axe
lib:AddRecipe(12261, 15973, 12260) -- Searing Golden Blade
lib:AddRecipe(12682, 16642, 12405) -- Thorium Armor
lib:AddRecipe(12683, 16643, 12406) -- Thorium Belt
lib:AddRecipe(12684, 16644, 12408) -- Thorium Bracers
lib:AddRecipe(12685, 16645, 12416) -- Radiant Belt
lib:AddRecipe(12687, 16646, 12428) -- Imperial Plate Shoulders
lib:AddRecipe(12688, 16647, 12424) -- Imperial Plate Belt
lib:AddRecipe(12689, 16648, 12415) -- Radiant Breastplate
lib:AddRecipe(12690, 16649, 12425) -- Imperial Plate Bracers
lib:AddRecipe(12691, 16650, 12624) -- Wildthorn Mail
lib:AddRecipe(12692, 16651, 12645) -- Thorium Shield Spike
lib:AddRecipe(12693, 16652, 12409) -- Thorium Boots
lib:AddRecipe(12694, 16653, 12410) -- Thorium Helm
lib:AddRecipe(12695, 16654, 12418) -- Radiant Gloves
lib:AddRecipe(12696, 16667, 12628) -- Demon Forged Breastplate
lib:AddRecipe(12697, 16656, 12419) -- Radiant Boots
lib:AddRecipe(12698, 16660, 12625) -- Dawnbringer Shoulders
lib:AddRecipe(12699, 16655, 12631) -- Fiery Plate Gauntlets
lib:AddRecipe(12700, 16657, 12426) -- Imperial Plate Boots
lib:AddRecipe(12701, 16658, 12427) -- Imperial Plate Helm
lib:AddRecipe(12702, 16659, 12417) -- Radiant Circlet
lib:AddRecipe(12703, 16661, 12632) -- Storm Gauntlets
lib:AddRecipe(12704, 16662, 12414) -- Thorium Leggings
lib:AddRecipe(12705, 16663, 12422) -- Imperial Plate Chest
lib:AddRecipe(12706, 16664, 12610) -- Runic Plate Shoulders
lib:AddRecipe(12707, 16665, 12611) -- Runic Plate Boots
lib:AddRecipe(12711, 16724, 12633) -- Whitesoul Helm
lib:AddRecipe(12713, 16725, 12420) -- Radiant Leggings
lib:AddRecipe(12714, 16726, 12612) -- Runic Plate Helm
lib:AddRecipe(12715, 16730, 12429) -- Imperial Plate Leggings
lib:AddRecipe(12716, 16728, 12636) -- Helm of the Great Chief
lib:AddRecipe(12717, 16729, 12640) -- Lionheart Helm
lib:AddRecipe(12718, 16731, 12613) -- Runic Breastplate
lib:AddRecipe(12719, 16732, 12614) -- Runic Plate Leggings
lib:AddRecipe(12720, 16741, 12639) -- Stronghold Gauntlets
lib:AddRecipe(12725, 16742, 12620) -- Enchanted Thorium Helm
lib:AddRecipe(12726, 16744, 12619) -- Enchanted Thorium Leggings
lib:AddRecipe(12727, 16745, 12618) -- Enchanted Thorium Breastplate
lib:AddRecipe(12728, 16746, 12641) -- Invulnerable Mail
lib:AddRecipe(12816, 16960, 12764) -- Thorium Greatsword
lib:AddRecipe(12817, 16965, 12769) -- Bleakwood Hew
lib:AddRecipe(12818, 16967, 12772) -- Inlaid Thorium Hammer
lib:AddRecipe(12819, 16969, 12773) -- Ornate Thorium Handaxe
lib:AddRecipe(12821, 16970, 12774) -- Dawn's Edge
lib:AddRecipe(12823, 16971, 12775) -- Huge Thorium Battleaxe
lib:AddRecipe(12824, 16973, 12776) -- Enchanted Battlehammer
lib:AddRecipe(12825, 16978, 12777) -- Blazing Rapier
lib:AddRecipe(12826, 16980, 12779) -- Rune Edge
lib:AddRecipe(12827, 16983, 12781) -- Serenity
lib:AddRecipe(12828, 16984, 12792) -- Volcanic Hammer
lib:AddRecipe(12830, 16985, 12782) -- Corruption
lib:AddRecipe(12831, 16986, 12795) -- Blood Talon
lib:AddRecipe(12832, 16987, 12802) -- Darkspear
lib:AddRecipe(12833, 16988, 12796) -- Hammer of the Titans
lib:AddRecipe(12834, 16990, 12790) -- Arcanite Champion
lib:AddRecipe(12835, 16991, 12798) -- Annihilator
lib:AddRecipe(12836, 16992, 12797) -- Frostguard
lib:AddRecipe(12837, 16993, 12794) -- Masterwork Stormhammer
lib:AddRecipe(12838, 16994, 12784) -- Arcanite Reaper
lib:AddRecipe(12839, 16995, 12783) -- Heartseeker
lib:AddRecipe(17049, 20872, 16989) -- Fiery Chain Girdle
lib:AddRecipe(17051, 20874, 17014) -- Dark Iron Bracers
lib:AddRecipe(17052, 20876, 17013) -- Dark Iron Leggings
lib:AddRecipe(17053, 20873, 16988) -- Fiery Chain Shoulders
lib:AddRecipe(17059, 20890, 17015) -- Dark Iron Reaver
lib:AddRecipe(17060, 20897, 17016) -- Dark Iron Destroyer
lib:AddRecipe(17706, 21913, 17704) -- Edge of Winter
lib:AddRecipe(18264, 22757, 18262) -- Elemental Sharpening Stone
lib:AddRecipe(18592, 21161, 17193) -- Sulfuron Hammer
lib:AddRecipe(19202, 23628, 19043) -- Heavy Timbermaw Belt
lib:AddRecipe(19203, 23632, 19051) -- Girdle of the Dawn
lib:AddRecipe(19204, 23629, 19048) -- Heavy Timbermaw Boots
lib:AddRecipe(19205, 23633, 19057) -- Gloves of the Dawn
lib:AddRecipe(19206, 23636, 19148) -- Dark Iron Helm
lib:AddRecipe(19207, 23637, 19164) -- Dark Iron Gauntlets
lib:AddRecipe(19208, 23638, 19166) -- Black Amnesty
lib:AddRecipe(19209, 23639, 19167) -- Blackfury
lib:AddRecipe(19210, 23650, 19170) -- Ebon Hand
lib:AddRecipe(19211, 23652, 19168) -- Blackguard
lib:AddRecipe(19212, 23653, 19169) -- Nightfall
lib:AddRecipe(19776, 24136, 19690) -- Bloodsoul Breastplate
lib:AddRecipe(19777, 24137, 19691) -- Bloodsoul Shoulders
lib:AddRecipe(19778, 24138, 19692) -- Bloodsoul Gauntlets
lib:AddRecipe(19779, 24139, 19693) -- Darksoul Breastplate
lib:AddRecipe(19780, 24140, 19694) -- Darksoul Leggings
lib:AddRecipe(19781, 24141, 19695) -- Darksoul Shoulders
lib:AddRecipe(20040, 24399, 20039) -- Dark Iron Boots
lib:AddRecipe(20553, 24912, 20549) -- Darkrune Gauntlets
lib:AddRecipe(20554, 24914, 20550) -- Darkrune Breastplate
lib:AddRecipe(20555, 24913, 20551) -- Darkrune Helm
lib:AddRecipe(22209, 27585, 22197) -- Heavy Obsidian Belt
lib:AddRecipe(22214, 27588, 22195) -- Light Obsidian Belt
lib:AddRecipe(22219, 27586, 22198) -- Jagged Obsidian Shield
lib:AddRecipe(22220, 27589, 22194) -- Black Grasp of the Destroyer
lib:AddRecipe(22221, 27590, 22191) -- Obsidian Mail Tunic
lib:AddRecipe(22222, 27587, 22196) -- Thick Obsidian Breastplate
lib:AddRecipe(22388, 27829, 22385) -- Titanic Leggings
lib:AddRecipe(22389, 27832, 22383) -- Sageblade
lib:AddRecipe(22390, 27830, 22384) -- Persuader
lib:AddRecipe(22703, 28242, 22669) -- Icebane Breastplate
lib:AddRecipe(22704, 28243, 22670) -- Icebane Gauntlets
lib:AddRecipe(22705, 28244, 22671) -- Icebane Bracers
lib:AddRecipe(22766, 28461, 22762) -- Ironvine Breastplate
lib:AddRecipe(22767, 28462, 22763) -- Ironvine Gloves
lib:AddRecipe(22768, 28463, 22764) -- Ironvine Belt
lib:AddRecipe(23590, 29566, 23502) -- Adamantite Maul
lib:AddRecipe(23591, 29568, 23503) -- Adamantite Cleaver
lib:AddRecipe(23592, 29569, 23504) -- Adamantite Dagger
lib:AddRecipe(23593, 29571, 23505) -- Adamantite Rapier
lib:AddRecipe(23594, 29603, 23506) -- Adamantite Plate Bracers
lib:AddRecipe(23595, 29605, 23508) -- Adamantite Plate Gloves
lib:AddRecipe(23596, 29606, 23507) -- Adamantite Breastplate
lib:AddRecipe(23597, 29608, 23510) -- Enchanted Adamantite Belt
lib:AddRecipe(23598, 29611, 23511) -- Enchanted Adamantite Boots
lib:AddRecipe(23599, 29610, 23509) -- Enchanted Adamantite Breastplate
lib:AddRecipe(23600, 29613, 23512) -- Enchanted Adamantite Leggings
lib:AddRecipe(23601, 29614, 23515) -- Flamebane Bracers
lib:AddRecipe(23602, 29615, 23516) -- Flamebane Helm
lib:AddRecipe(23603, 29616, 23514) -- Flamebane Gloves
lib:AddRecipe(23604, 29617, 23513) -- Flamebane Breastplate
lib:AddRecipe(23605, 29619, 23517) -- Felsteel Gloves
lib:AddRecipe(23606, 29620, 23518) -- Felsteel Leggings
lib:AddRecipe(23607, 29621, 23519) -- Felsteel Helm
lib:AddRecipe(23608, 29628, 23524) -- Khorium Belt
lib:AddRecipe(23609, 29629, 23523) -- Khorium Pants
lib:AddRecipe(23610, 29630, 23525) -- Khorium Boots
lib:AddRecipe(23611, 29642, 23520) -- Ragesteel Gloves
lib:AddRecipe(23612, 29643, 23521) -- Ragesteel Helm
lib:AddRecipe(23613, 29645, 23522) -- Ragesteel Breastplate
lib:AddRecipe(23615, 29648, 23526) -- Swiftsteel Gloves
lib:AddRecipe(23617, 29649, 23527) -- Earthpeace Breastplate
lib:AddRecipe(23618, 29656, 23529) -- Adamantite Sharpening Stone
lib:AddRecipe(23619, 29657, 23530) -- Felsteel Shield Spike
lib:AddRecipe(23620, 29658, 23531) -- Felfury Gauntlets
lib:AddRecipe(23621, 29622, 23532) -- Gauntlets of the Iron Tower
lib:AddRecipe(23622, 29662, 23533) -- Steelgrip Gauntlets
lib:AddRecipe(23623, 29663, 23534) -- Storm Helm
lib:AddRecipe(23624, 29664, 23535) -- Helm of the Stalwart Defender
lib:AddRecipe(23625, 29668, 23536) -- Oathkeeper's Helm
lib:AddRecipe(23626, 29669, 23537) -- Black Felsteel Bracers
lib:AddRecipe(23627, 29671, 23538) -- Bracers of the Green Fortress
lib:AddRecipe(23628, 29672, 23539) -- Blessed Bracers
lib:AddRecipe(23629, 29692, 23540) -- Felsteel Longblade
lib:AddRecipe(23630, 29693, 23541) -- Khorium Champion
lib:AddRecipe(23631, 29694, 23542) -- Fel Edged Battleaxe
lib:AddRecipe(23632, 29695, 23543) -- Felsteel Reaper
lib:AddRecipe(23633, 29696, 23544) -- Runic Hammer
lib:AddRecipe(23634, 29697, 23546) -- Fel Hardened Maul
lib:AddRecipe(23635, 29698, 23554) -- Eternium Runed Blade
lib:AddRecipe(23636, 29699, 23555) -- Dirge
lib:AddRecipe(23637, 29700, 23556) -- Hand of Eternity
lib:AddRecipe(23638, 29728, 23575) -- Lesser Ward of Shielding
lib:AddRecipe(23639, 29729, 23576) -- Greater Ward of Shielding
lib:AddRecipe(24002, 29657, 23530) -- Felsteel Shield Spike
lib:AddRecipe(25526, 32285, 25521) -- Greater Rune of Warding
lib:AddRecipe(25846, 32656, 25844) -- Adamantite Rod
lib:AddRecipe(25847, 32657, 25845) -- Eternium Rod
lib:AddRecipe(28632, 34608, 28421) -- Adamantite Weightstone
lib:AddRecipe(30321, 36389, 30034) -- Belt of the Guardian
lib:AddRecipe(30322, 36390, 30032) -- Red Belt of Battle
lib:AddRecipe(30323, 36391, 30033) -- Boots of the Protector
lib:AddRecipe(30324, 36392, 30031) -- Red Havoc Boots
lib:AddRecipe(31390, 38473, 31364) -- Wildguard Breastplate
lib:AddRecipe(31391, 38475, 31367) -- Wildguard Leggings
lib:AddRecipe(31392, 38476, 31368) -- Wildguard Helm
lib:AddRecipe(31393, 38477, 31369) -- Iceguard Breastplate
lib:AddRecipe(31394, 38478, 31370) -- Iceguard Leggings
lib:AddRecipe(31395, 38479, 31371) -- Iceguard Helm
lib:AddRecipe(32441, 40033, 32402) -- Shadesteel Sabots
lib:AddRecipe(32442, 40034, 32403) -- Shadesteel Bracers
lib:AddRecipe(32443, 40035, 32404) -- Shadesteel Greaves
lib:AddRecipe(32444, 40036, 32401) -- Shadesteel Girdle
lib:AddRecipe(32736, 41132, 32568) -- Swiftsteel Bracers
lib:AddRecipe(32737, 41133, 32570) -- Swiftsteel Shoulders
lib:AddRecipe(32738, 41134, 32571) -- Dawnsteel Bracers
lib:AddRecipe(32739, 41135, 32573) -- Dawnsteel Shoulders
lib:AddRecipe(33174, 42662, 33173) -- Ragesteel Shoulders
lib:AddRecipe(33186, 42688, 33185) -- Adamantite Weapon Chain
lib:AddRecipe(33792, 43549, 33791) -- Heavy Copper Longsword
lib:AddRecipe(33954, 43846, 32854) -- Hammer of Righteous Might
lib:AddRecipe(35208, 46140, 34380) -- Sunblessed Gauntlets
lib:AddRecipe(35209, 46141, 34378) -- Hard Khorium Battlefists
lib:AddRecipe(35210, 46142, 34379) -- Sunblessed Breastplate
lib:AddRecipe(35211, 46144, 34377) -- Hard Khorium Battleplate
lib:AddRecipe(35296, 42688, 33185) -- Adamantite Weapon Chain
lib:AddRecipe(35529, 41134, 32571) -- Dawnsteel Bracers
lib:AddRecipe(35530, 41135, 32573) -- Dawnsteel Shoulders
lib:AddRecipe(35531, 41132, 32568) -- Swiftsteel Bracers
lib:AddRecipe(35532, 41133, 32570) -- Swiftsteel Shoulders
lib:AddRecipe(35553, 46141, 34378) -- Hard Khorium Battlefists
lib:AddRecipe(35554, 46144, 34377) -- Hard Khorium Battleplate
lib:AddRecipe(35555, 46142, 34379) -- Sunblessed Breastplate
lib:AddRecipe(35556, 46140, 34380) -- Sunblessed Gauntlets
-- Cooking
lib:AddRecipe(728, 2543, 733) -- Westfall Stew
lib:AddRecipe(2697, 2542, 724) -- Goretusk Liver Pie
lib:AddRecipe(2698, 2545, 2682) -- Cooked Crab Claw
lib:AddRecipe(2699, 2547, 1082) -- Redridge Goulash
lib:AddRecipe(2700, 2548, 2685) -- Succulent Pork Ribs
lib:AddRecipe(2701, 2549, 1017) -- Seasoned Wolf Kabob
lib:AddRecipe(2889, 2795, 2888) -- Beer Basted Boar Ribs
lib:AddRecipe(3678, 3370, 3662) -- Crocolisk Steak
lib:AddRecipe(3679, 3371, 3220) -- Blood Sausage
lib:AddRecipe(3680, 3372, 3663) -- Murloc Fin Soup
lib:AddRecipe(3681, 3373, 3664) -- Crocolisk Gumbo
lib:AddRecipe(3682, 3376, 3665) -- Curiously Tasty Omelet
lib:AddRecipe(3683, 3377, 3666) -- Gooey Spider Cake
lib:AddRecipe(3734, 3397, 3726) -- Big Bear Steak
lib:AddRecipe(3735, 3398, 3727) -- Hot Lion Chops
lib:AddRecipe(3736, 3399, 3728) -- Tasty Lion Steak
lib:AddRecipe(3737, 3400, 3729) -- Soothing Turtle Bisque
lib:AddRecipe(4609, 4094, 4457) -- Barbecued Buzzard Wing
lib:AddRecipe(5482, 6412, 5472) -- Kaldorei Spider Kabob
lib:AddRecipe(5483, 6413, 5473) -- Scorpid Surprise
lib:AddRecipe(5484, 6414, 5474) -- Roasted Kodo Meat
lib:AddRecipe(5485, 6415, 5476) -- Fillet of Frenzy
lib:AddRecipe(5486, 6416, 5477) -- Strider Stew
lib:AddRecipe(5487, 6417, 5478) -- Dig Rat Stew
lib:AddRecipe(5488, 6418, 5479) -- Crispy Lizard Tail
lib:AddRecipe(5489, 6419, 5480) -- Lean Venison
lib:AddRecipe(5528, 6501, 5526) -- Clam Chowder
lib:AddRecipe(6039, 7213, 6038) -- Giant Clam Scorcho
lib:AddRecipe(6325, 7751, 6290) -- Brilliant Smallfish
lib:AddRecipe(6326, 7752, 787) -- Slitherskin Mackerel
lib:AddRecipe(6328, 7753, 4592) -- Longjaw Mud Snapper
lib:AddRecipe(6329, 7754, 6316) -- Loch Frenzy Delight
lib:AddRecipe(6330, 7755, 4593) -- Bristle Whisker Catfish
lib:AddRecipe(6368, 7827, 5095) -- Rainbow Fin Albacore
lib:AddRecipe(6369, 7828, 4594) -- Rockscale Cod
lib:AddRecipe(6661, 8238, 6657) -- Savory Deviate Delight
lib:AddRecipe(6891, 8604, 6888) -- Herb Baked Egg
lib:AddRecipe(6892, 8607, 6890) -- Smoked Bear Meat
lib:AddRecipe(7678, 9513, 7676) -- Thistle Tea
lib:AddRecipe(12226, 15935, 12224) -- Crispy Bat Wing
lib:AddRecipe(12227, 15853, 12209) -- Lean Wolf Steak
lib:AddRecipe(12228, 15855, 12210) -- Roast Raptor
lib:AddRecipe(12229, 15856, 13851) -- Hot Wolf Ribs
lib:AddRecipe(12231, 15861, 12212) -- Jungle Stew
lib:AddRecipe(12232, 15863, 12213) -- Carrion Surprise
lib:AddRecipe(12233, 15865, 12214) -- Mystery Stew
lib:AddRecipe(12239, 15906, 12217) -- Dragonbreath Chili
lib:AddRecipe(12240, 15910, 12215) -- Heavy Kodo Stew
lib:AddRecipe(13939, 18238, 6887) -- Spotted Yellowtail
lib:AddRecipe(13940, 18239, 13927) -- Cooked Glossy Mightfish
lib:AddRecipe(13941, 18241, 13930) -- Filet of Redgill
lib:AddRecipe(13942, 18240, 13928) -- Grilled Squid
lib:AddRecipe(13943, 18242, 13929) -- Hot Smoked Bass
lib:AddRecipe(13945, 18243, 13931) -- Nightfin Soup
lib:AddRecipe(13946, 18244, 13932) -- Poached Sunscale Salmon
lib:AddRecipe(13947, 18245, 13933) -- Lobster Stew
lib:AddRecipe(13948, 18246, 13934) -- Mightfish Steak
lib:AddRecipe(13949, 18247, 13935) -- Baked Salmon
lib:AddRecipe(16110, 15933, 12218) -- Monster Omelet
lib:AddRecipe(16111, 15915, 12216) -- Spiced Chili Crab
lib:AddRecipe(16767, 20626, 16766) -- Undermine Clam Chowder
lib:AddRecipe(17062, 20916, 8364) -- Mithril Headed Trout
lib:AddRecipe(17200, 21143, 17197) -- Gingerbread Cookie
lib:AddRecipe(17201, 21144, 17198) -- Egg Nog
lib:AddRecipe(18046, 22480, 18045) -- Tender Wolf Steak
lib:AddRecipe(18160, 9513, 7676) -- Thistle Tea
lib:AddRecipe(18267, 22761, 18254) -- Runn Tum Tuber Surprise
lib:AddRecipe(20075, 24418, 20074) -- Heavy Crocolisk Stew
lib:AddRecipe(21025, 25659, 21023) -- Dirge's Kickin' Chimaerok Chops
lib:AddRecipe(21099, 25704, 21072) -- Smoked Sagefish
lib:AddRecipe(21219, 25954, 21217) -- Sagefish Delight
lib:AddRecipe(22647, 28267, 22645) -- Crunchy Spider Surprise
lib:AddRecipe(27684, 33279, 27651) -- Buzzard Bites
lib:AddRecipe(27685, 33276, 27635) -- Lynx Steak
lib:AddRecipe(27686, 33277, 24105) -- Roasted Moongraze Tenderloin
lib:AddRecipe(27687, 33278, 27636) -- Bat Bites
lib:AddRecipe(27688, 33284, 27655) -- Ravager Dog
lib:AddRecipe(27689, 33285, 27656) -- Sporeling Snack
lib:AddRecipe(27690, 33286, 27657) -- Blackened Basilisk
lib:AddRecipe(27691, 33287, 27658) -- Roasted Clefthoof
lib:AddRecipe(27692, 33288, 27659) -- Warp Burger
lib:AddRecipe(27693, 33289, 27660) -- Talbuk Steak
lib:AddRecipe(27694, 33290, 27661) -- Blackened Trout
lib:AddRecipe(27695, 33291, 27662) -- Feltail Delight
lib:AddRecipe(27696, 33292, 27663) -- Blackened Sporefish
lib:AddRecipe(27697, 33293, 27664) -- Grilled Mudfish
lib:AddRecipe(27698, 33294, 27665) -- Poached Bluefish
lib:AddRecipe(27699, 33295, 27666) -- Golden Fish Sticks
lib:AddRecipe(27700, 33296, 27667) -- Spicy Crawdad
lib:AddRecipe(30156, 36210, 30155) -- Clam Bar
lib:AddRecipe(31674, 38868, 31673) -- Crunchy Serpent
lib:AddRecipe(31675, 38867, 31672) -- Mok'Nathal Shortribs
lib:AddRecipe(33869, 43761, 33867) -- Broiled Bloodfin
lib:AddRecipe(33870, 43707, 33825) -- Skullfish Soup
lib:AddRecipe(33871, 43758, 33866) -- Stormchops
lib:AddRecipe(33873, 43765, 33872) -- Spicy Hot Talbuk
lib:AddRecipe(33875, 43772, 33874) -- Kibler's Bits
lib:AddRecipe(33925, 43779, 33924) -- Delicious Chocolate Cake
lib:AddRecipe(34413, 45022, 34411) -- Hot Apple Cider
lib:AddRecipe(34834, 45695, 34832) -- Captain Rumsey's Lager
lib:AddRecipe(35564, 46684, 35563) -- Charred Bear Kabobs
lib:AddRecipe(35566, 46688, 35565) -- Juicy Bear Burger
-- Enchanting
lib:AddRecipe(6342, 7443, nil) -- Enchant Chest - Minor Mana
lib:AddRecipe(6344, 7766, nil) -- Enchant Bracer - Minor Spirit
lib:AddRecipe(6345, 7771, nil) -- Enchant Cloak - Minor Protection
lib:AddRecipe(6346, 7776, nil) -- Enchant Chest - Lesser Mana
lib:AddRecipe(6347, 7782, nil) -- Enchant Bracer - Minor Strength
lib:AddRecipe(6348, 7786, nil) -- Enchant Weapon - Minor Beastslayer
lib:AddRecipe(6349, 7793, nil) -- Enchant 2H Weapon - Lesser Intellect
lib:AddRecipe(6375, 7859, nil) -- Enchant Bracer - Lesser Spirit
lib:AddRecipe(6376, 7863, nil) -- Enchant Boots - Minor Stamina
lib:AddRecipe(6377, 7867, nil) -- Enchant Boots - Minor Agility
lib:AddRecipe(11038, 13380, nil) -- Enchant 2H Weapon - Lesser Spirit
lib:AddRecipe(11039, 13419, nil) -- Enchant Cloak - Minor Agility
lib:AddRecipe(11081, 13464, nil) -- Enchant Shield - Lesser Protection
lib:AddRecipe(11098, 13522, nil) -- Enchant Cloak - Lesser Shadow Resistance
lib:AddRecipe(11101, 13536, nil) -- Enchant Bracer - Lesser Strength
lib:AddRecipe(11150, 13612, nil) -- Enchant Gloves - Mining
lib:AddRecipe(11151, 13617, nil) -- Enchant Gloves - Herbalism
lib:AddRecipe(11152, 13620, nil) -- Enchant Gloves - Fishing
lib:AddRecipe(11163, 13646, nil) -- Enchant Bracer - Lesser Deflection
lib:AddRecipe(11164, 13653, nil) -- Enchant Weapon - Lesser Beastslayer
lib:AddRecipe(11165, 13655, nil) -- Enchant Weapon - Lesser Elemental Slayer
lib:AddRecipe(11166, 13698, nil) -- Enchant Gloves - Skinning
lib:AddRecipe(11167, 13687, nil) -- Enchant Boots - Lesser Spirit
lib:AddRecipe(11168, 13689, nil) -- Enchant Shield - Lesser Block
lib:AddRecipe(11202, 13817, nil) -- Enchant Shield - Stamina
lib:AddRecipe(11203, 13841, nil) -- Enchant Gloves - Advanced Mining
lib:AddRecipe(11204, 13846, nil) -- Enchant Bracer - Greater Spirit
lib:AddRecipe(11205, 13868, nil) -- Enchant Gloves - Advanced Herbalism
lib:AddRecipe(11206, 13882, nil) -- Enchant Cloak - Lesser Agility
lib:AddRecipe(11207, 13898, nil) -- Enchant Weapon - Fiery Weapon
lib:AddRecipe(11208, 13915, nil) -- Enchant Weapon - Demonslaying
lib:AddRecipe(11223, 13931, nil) -- Enchant Bracer - Deflection
lib:AddRecipe(11224, 13933, nil) -- Enchant Shield - Frost Resistance
lib:AddRecipe(11225, 13945, nil) -- Enchant Bracer - Greater Stamina
lib:AddRecipe(11226, 13947, nil) -- Enchant Gloves - Riding Skill
lib:AddRecipe(11813, 15596, 11811) -- Smoking Heart of the Mountain
lib:AddRecipe(16214, 20008, nil) -- Enchant Bracer - Greater Intellect
lib:AddRecipe(16215, 20020, nil) -- Enchant Boots - Greater Stamina
lib:AddRecipe(16216, 20014, nil) -- Enchant Cloak - Greater Resistance
lib:AddRecipe(16217, 20017, nil) -- Enchant Shield - Greater Stamina
lib:AddRecipe(16218, 20009, nil) -- Enchant Bracer - Superior Spirit
lib:AddRecipe(16219, 20012, nil) -- Enchant Gloves - Greater Agility
lib:AddRecipe(16220, 20024, nil) -- Enchant Boots - Spirit
lib:AddRecipe(16221, 20026, nil) -- Enchant Chest - Major Health
lib:AddRecipe(16222, 20016, nil) -- Enchant Shield - Superior Spirit
lib:AddRecipe(16223, 20029, nil) -- Enchant Weapon - Icy Chill
lib:AddRecipe(16224, 20015, nil) -- Enchant Cloak - Superior Defense
lib:AddRecipe(16242, 20028, nil) -- Enchant Chest - Major Mana
lib:AddRecipe(16243, 20051, 16207) -- Runed Arcanite Rod
lib:AddRecipe(16244, 20013, nil) -- Enchant Gloves - Greater Strength
lib:AddRecipe(16245, 20023, nil) -- Enchant Boots - Greater Agility
lib:AddRecipe(16246, 20010, nil) -- Enchant Bracer - Superior Strength
lib:AddRecipe(16247, 20030, nil) -- Enchant 2H Weapon - Superior Impact
lib:AddRecipe(16248, 20033, nil) -- Enchant Weapon - Unholy Weapon
lib:AddRecipe(16249, 20036, nil) -- Enchant 2H Weapon - Major Intellect
lib:AddRecipe(16250, 20031, nil) -- Enchant Weapon - Superior Striking
lib:AddRecipe(16251, 20011, nil) -- Enchant Bracer - Superior Stamina
lib:AddRecipe(16252, 20034, nil) -- Enchant Weapon - Crusader
lib:AddRecipe(16253, 20025, nil) -- Enchant Chest - Greater Stats
lib:AddRecipe(16254, 20032, nil) -- Enchant Weapon - Lifestealing
lib:AddRecipe(16255, 20035, nil) -- Enchant 2H Weapon - Major Spirit
lib:AddRecipe(17725, 21931, nil) -- Enchant Weapon - Winter's Might
lib:AddRecipe(18259, 22749, nil) -- Enchant Weapon - Spell Power
lib:AddRecipe(18260, 22750, nil) -- Enchant Weapon - Healing Power
lib:AddRecipe(19444, 23799, nil) -- Enchant Weapon - Strength
lib:AddRecipe(19445, 23800, nil) -- Enchant Weapon - Agility
lib:AddRecipe(19446, 23801, nil) -- Enchant Bracer - Mana Regeneration
lib:AddRecipe(19447, 23802, nil) -- Enchant Bracer - Healing Power
lib:AddRecipe(19448, 23803, nil) -- Enchant Weapon - Mighty Spirit
lib:AddRecipe(19449, 23804, nil) -- Enchant Weapon - Mighty Intellect
lib:AddRecipe(20726, 25072, nil) -- Enchant Gloves - Threat
lib:AddRecipe(20727, 25073, nil) -- Enchant Gloves - Shadow Power
lib:AddRecipe(20728, 25074, nil) -- Enchant Gloves - Frost Power
lib:AddRecipe(20729, 25078, nil) -- Enchant Gloves - Fire Power
lib:AddRecipe(20730, 25079, nil) -- Enchant Gloves - Healing Power
lib:AddRecipe(20731, 25080, nil) -- Enchant Gloves - Superior Agility
lib:AddRecipe(20732, 25081, nil) -- Enchant Cloak - Greater Fire Resistance
lib:AddRecipe(20733, 25082, nil) -- Enchant Cloak - Greater Nature Resistance
lib:AddRecipe(20734, 25083, nil) -- Enchant Cloak - Stealth
lib:AddRecipe(20735, 25084, nil) -- Enchant Cloak - Subtlety
lib:AddRecipe(20736, 25086, nil) -- Enchant Cloak - Dodge
lib:AddRecipe(20752, 25125, 20745) -- Minor Mana Oil
lib:AddRecipe(20753, 25126, 20746) -- Lesser Wizard Oil
lib:AddRecipe(20754, 25127, 20747) -- Lesser Mana Oil
lib:AddRecipe(20755, 25128, 20750) -- Wizard Oil
lib:AddRecipe(20756, 25129, 20749) -- Brilliant Wizard Oil
lib:AddRecipe(20757, 25130, 20748) -- Brilliant Mana Oil
lib:AddRecipe(20758, 25124, 20744) -- Minor Wizard Oil
lib:AddRecipe(22392, 27837, nil) -- Enchant 2H Weapon - Agility
lib:AddRecipe(22530, 27906, nil) -- Enchant Bracer - Major Defense
lib:AddRecipe(22531, 27911, nil) -- Enchant Bracer - Superior Healing
lib:AddRecipe(22532, 27913, nil) -- Enchant Bracer - Restore Mana Prime
lib:AddRecipe(22533, 27914, nil) -- Enchant Bracer - Fortitude
lib:AddRecipe(22534, 27917, nil) -- Enchant Bracer - Spellpower
lib:AddRecipe(22535, 27920, nil) -- Enchant Ring - Striking
lib:AddRecipe(22536, 27924, nil) -- Enchant Ring - Spellpower
lib:AddRecipe(22537, 27926, nil) -- Enchant Ring - Healing Power
lib:AddRecipe(22538, 27927, nil) -- Enchant Ring - Stats
lib:AddRecipe(22539, 27945, nil) -- Enchant Shield - Intellect
lib:AddRecipe(22540, 27946, nil) -- Enchant Shield - Shield Block
lib:AddRecipe(22541, 27947, nil) -- Enchant Shield - Resistance
lib:AddRecipe(22542, 27948, nil) -- Enchant Boots - Vitality
lib:AddRecipe(22543, 27950, nil) -- Enchant Boots - Fortitude
lib:AddRecipe(22544, 27951, nil) -- Enchant Boots - Dexterity
lib:AddRecipe(22545, 27954, nil) -- Enchant Boots - Surefooted
lib:AddRecipe(22546, 27958, nil) -- Enchant Chest - Exceptional Mana
lib:AddRecipe(22547, 27960, nil) -- Enchant Chest - Exceptional Stats
lib:AddRecipe(22548, 27962, nil) -- Enchant Cloak - Major Resistance
lib:AddRecipe(22551, 27968, nil) -- Enchant Weapon - Major Intellect
lib:AddRecipe(22552, 27967, nil) -- Enchant Weapon - Major Striking
lib:AddRecipe(22553, 27972, nil) -- Enchant Weapon - Potency
lib:AddRecipe(22554, 27971, nil) -- Enchant 2H Weapon - Savagery
lib:AddRecipe(22555, 27975, nil) -- Enchant Weapon - Major Spellpower
lib:AddRecipe(22556, 27977, nil) -- Enchant 2H Weapon - Major Agility
lib:AddRecipe(22557, 28004, nil) -- Enchant Weapon - Battlemaster
lib:AddRecipe(22558, 28003, nil) -- Enchant Weapon - Spellsurge
lib:AddRecipe(22559, 27984, nil) -- Enchant Weapon - Mongoose
lib:AddRecipe(22560, 27981, nil) -- Enchant Weapon - Sunfire
lib:AddRecipe(22561, 27982, nil) -- Enchant Weapon - Soulfrost
lib:AddRecipe(22562, 28016, 22521) -- Superior Mana Oil
lib:AddRecipe(22563, 28019, 22522) -- Superior Wizard Oil
lib:AddRecipe(22564, 28021, 22445) -- Arcane Dust
lib:AddRecipe(22565, 28022, 22449) -- Large Prismatic Shard
lib:AddRecipe(24000, 27911, nil) -- Enchant Bracer - Superior Healing
lib:AddRecipe(24003, 27960, nil) -- Enchant Chest - Exceptional Stats
lib:AddRecipe(25848, 32665, 22462) -- Runed Adamantite Rod
lib:AddRecipe(25849, 32667, 22463) -- Runed Eternium Rod
lib:AddRecipe(28270, 33992, nil) -- Enchant Chest - Major Resilience
lib:AddRecipe(28271, 33994, nil) -- Enchant Gloves - Spell Strike
lib:AddRecipe(28272, 33997, nil) -- Enchant Gloves - Major Spellpower
lib:AddRecipe(28273, 33999, nil) -- Enchant Gloves - Major Healing
lib:AddRecipe(28274, 34003, nil) -- Enchant Cloak - Spell Penetration
lib:AddRecipe(28276, 34005, nil) -- Enchant Cloak - Greater Arcane Resistance
lib:AddRecipe(28277, 34006, nil) -- Enchant Cloak - Greater Shadow Resistance
lib:AddRecipe(28279, 34007, nil) -- Enchant Boots - Cat's Swiftness
lib:AddRecipe(28280, 34008, nil) -- Enchant Boots - Boar's Speed
lib:AddRecipe(28281, 34010, nil) -- Enchant Weapon - Major Healing
lib:AddRecipe(28282, 34009, nil) -- Enchant Shield - Major Stamina
lib:AddRecipe(33148, 25086, nil) -- Enchant Cloak - Dodge
lib:AddRecipe(33149, 25083, nil) -- Enchant Cloak - Stealth
lib:AddRecipe(33150, 25084, nil) -- Enchant Cloak - Subtlety
lib:AddRecipe(33151, 25084, nil) -- Enchant Cloak - Subtlety
lib:AddRecipe(33152, 25080, nil) -- Enchant Gloves - Superior Agility
lib:AddRecipe(33153, 25072, nil) -- Enchant Gloves - Threat
lib:AddRecipe(33165, 42620, nil) -- Enchant Weapon - Greater Agility
lib:AddRecipe(33307, 42974, nil) -- Enchant Weapon - Executioner
lib:AddRecipe(34872, 45765, 22449) -- Void Shatter
lib:AddRecipe(35297, 34008, nil) -- Enchant Boots - Boar's Speed
lib:AddRecipe(35298, 27948, nil) -- Enchant Boots - Vitality
lib:AddRecipe(35299, 34007, nil) -- Enchant Boots - Cat's Swiftness
lib:AddRecipe(35498, 46578, nil) -- Enchant Weapon - Deathfrost
lib:AddRecipe(35500, 46594, nil) -- Enchant Chest - Defense
lib:AddRecipe(35756, 47051, nil) -- Enchant Cloak - Steelweave
lib:AddRecipe(186683, 27927, nil) -- Enchant Ring - Stats
-- Engineering
lib:AddRecipe(4408, 3928, 4401) -- Mechanical Squirrel
lib:AddRecipe(4409, 3933, 4367) -- Small Seaforium Charge
lib:AddRecipe(4410, 3940, 4373) -- Shadow Goggles
lib:AddRecipe(4411, 3944, 4376) -- Flame Deflector
lib:AddRecipe(4412, 3954, 4383) -- Moonsight Rifle
lib:AddRecipe(4413, 3959, 4388) -- Discombobulator Ray
lib:AddRecipe(4414, 3960, 4403) -- Portable Bronze Mortar
lib:AddRecipe(4415, 3966, 4393) -- Craftsman's Monocle
lib:AddRecipe(4416, 3968, 4395) -- Goblin Land Mine
lib:AddRecipe(4417, 3972, 4398) -- Large Seaforium Charge
lib:AddRecipe(6672, 8243, 4852) -- Flash Bomb
lib:AddRecipe(6716, 8339, 6714) -- EZ-Thro Dynamite
lib:AddRecipe(7192, 8895, 7189) -- Goblin Rocket Boots
lib:AddRecipe(7560, 9269, 7506) -- Gnomish Universal Remote
lib:AddRecipe(7561, 9273, 7148) -- Goblin Jumper Cables
lib:AddRecipe(7742, 3971, 4397) -- Gnomish Cloaking Device
lib:AddRecipe(10601, 12587, 10499) -- Bright-Eye Goggles
lib:AddRecipe(10602, 12597, 10546) -- Deadly Scope
lib:AddRecipe(10603, 12607, 10501) -- Catseye Ultra Goggles
lib:AddRecipe(10604, 12614, 10510) -- Mithril Heavy-bore Rifle
lib:AddRecipe(10605, 12615, 10502) -- Spellpower Goggles Xtreme
lib:AddRecipe(10606, 12616, 10518) -- Parachute Cloak
lib:AddRecipe(10607, 12617, 10506) -- Deepdive Helmet
lib:AddRecipe(10608, 12620, 10548) -- Sniper Scope
lib:AddRecipe(10609, 12624, 10576) -- Mithril Mechanical Dragonling
lib:AddRecipe(11827, 15633, 11826) -- Lil' Smoky
lib:AddRecipe(11828, 15628, 11825) -- Pet Bombling
lib:AddRecipe(13308, 3957, 4386) -- Ice Deflector
lib:AddRecipe(13309, 3939, 4372) -- Lovingly Crafted Boomstick
lib:AddRecipe(13310, 3979, 4407) -- Accurate Scope
lib:AddRecipe(13311, 3969, 4396) -- Mechanical Dragonling
lib:AddRecipe(14639, 3952, 4381) -- Minor Recombobulator
lib:AddRecipe(16041, 19790, 15993) -- Thorium Grenade
lib:AddRecipe(16042, 19791, 15994) -- Thorium Widget
lib:AddRecipe(16043, 19792, 15995) -- Thorium Rifle
lib:AddRecipe(16044, 19793, 15996) -- Lifelike Mechanical Toad
lib:AddRecipe(16045, 19794, 15999) -- Spellpower Goggles Xtreme Plus
lib:AddRecipe(16046, 19814, 16023) -- Masterwork Target Dummy
lib:AddRecipe(16047, 19795, 16000) -- Thorium Tube
lib:AddRecipe(16048, 19796, 16004) -- Dark Iron Rifle
lib:AddRecipe(16049, 19799, 16005) -- Dark Iron Bomb
lib:AddRecipe(16050, 19815, 16006) -- Delicate Arcanite Converter
lib:AddRecipe(16051, 19800, 15997) -- Thorium Shells
lib:AddRecipe(16052, 19819, 16009) -- Voice Amplification Modulator
lib:AddRecipe(16053, 19825, 16008) -- Master Engineer's Goggles
lib:AddRecipe(16054, 19830, 16022) -- Arcanite Dragonling
lib:AddRecipe(16055, 19831, 16040) -- Arcane Bomb
lib:AddRecipe(16056, 19833, 16007) -- Flawless Arcanite Rifle
lib:AddRecipe(17720, 21940, 17716) -- Snowmaster 9000
lib:AddRecipe(18235, 22704, 18232) -- Field Repair Bot 74A
lib:AddRecipe(18290, 22793, 18283) -- Biznicks 247x128 Accurascope
lib:AddRecipe(18291, 22797, 18168) -- Force Reactive Disk
lib:AddRecipe(18292, 22795, 18282) -- Core Marksman Rifle
lib:AddRecipe(18647, 23066, 9318) -- Red Firework
lib:AddRecipe(18648, 23068, 9313) -- Green Firework
lib:AddRecipe(18649, 23067, 9312) -- Blue Firework
lib:AddRecipe(18650, 23069, 18588) -- EZ-Thro Dynamite II
lib:AddRecipe(18651, 23071, 18631) -- Truesilver Transformer
lib:AddRecipe(18652, 23077, 18634) -- Gyrofreeze Ice Reflector
lib:AddRecipe(18653, 23078, 18587) -- Goblin Jumper Cables XL
lib:AddRecipe(18654, 23096, 18645) -- Alarm-O-Bot
lib:AddRecipe(18655, 23079, 18637) -- Major Recombobulator
lib:AddRecipe(18656, 23080, 18594) -- Powerful Seaforium Charge
lib:AddRecipe(18657, 23081, 18638) -- Hyper-Radiant Flame Reflector
lib:AddRecipe(18658, 23082, 18639) -- Ultra-Flash Shadow Reflector
lib:AddRecipe(18661, 23129, 18660) -- World Enlarger
lib:AddRecipe(19027, 23507, 19026) -- Snake Burst Firework
lib:AddRecipe(20000, 24356, 19999) -- Bloodvine Goggles
lib:AddRecipe(20001, 24357, 19998) -- Bloodvine Lens
lib:AddRecipe(21724, 26416, 21558) -- Small Blue Rocket
lib:AddRecipe(21725, 26417, 21559) -- Small Green Rocket
lib:AddRecipe(21726, 26418, 21557) -- Small Red Rocket
lib:AddRecipe(21727, 26420, 21589) -- Large Blue Rocket
lib:AddRecipe(21728, 26421, 21590) -- Large Green Rocket
lib:AddRecipe(21729, 26422, 21592) -- Large Red Rocket
lib:AddRecipe(21730, 26423, 21571) -- Blue Rocket Cluster
lib:AddRecipe(21731, 26424, 21574) -- Green Rocket Cluster
lib:AddRecipe(21732, 26425, 21576) -- Red Rocket Cluster
lib:AddRecipe(21733, 26426, 21714) -- Large Blue Rocket Cluster
lib:AddRecipe(21734, 26427, 21716) -- Large Green Rocket Cluster
lib:AddRecipe(21735, 26428, 21718) -- Large Red Rocket Cluster
lib:AddRecipe(21737, 26443, 21570) -- Firework Cluster Launcher
lib:AddRecipe(21738, 26442, 21569) -- Firework Launcher
lib:AddRecipe(22729, 28327, 22728) -- Steam Tonk Controller
lib:AddRecipe(23799, 30313, 23746) -- Adamantite Rifle
lib:AddRecipe(23800, 30314, 23747) -- Felsteel Boomstick
lib:AddRecipe(23802, 30315, 23748) -- Ornate Khorium Rifle
lib:AddRecipe(23803, 30316, 23758) -- Cogspinner Goggles
lib:AddRecipe(23804, 30317, 23761) -- Power Amplification Goggles
lib:AddRecipe(23805, 30318, 23762) -- Ultra-Spectropic Detection Goggles
lib:AddRecipe(23806, 30325, 23763) -- Hyper-Vision Goggles
lib:AddRecipe(23807, 30329, 23764) -- Adamantite Scope
lib:AddRecipe(23808, 30332, 23765) -- Khorium Scope
lib:AddRecipe(23809, 30334, 23766) -- Stabilized Eternium Scope
lib:AddRecipe(23810, 30337, 23767) -- Crashin' Thrashin' Robot
lib:AddRecipe(23811, 30341, 23768) -- White Smoke Flare
lib:AddRecipe(23812, 30342, 23769) -- Red Smoke Flare
lib:AddRecipe(23813, 30343, 23770) -- Blue Smoke Flare
lib:AddRecipe(23814, 30344, 23771) -- Green Smoke Flare
lib:AddRecipe(23815, 30347, 34504) -- Adamantite Shell Machine
lib:AddRecipe(23816, 30348, 23774) -- Fel Iron Toolbox
lib:AddRecipe(23817, 30349, 23775) -- Khorium Toolbox
lib:AddRecipe(23874, 30547, 23819) -- Elemental Seaforium Charge
lib:AddRecipe(23882, 30549, 23820) -- Critter Enlarger
lib:AddRecipe(23883, 30551, 33092) -- Healing Potion Injector
lib:AddRecipe(23884, 30552, 33093) -- Mana Potion Injector
lib:AddRecipe(23887, 30556, 23824) -- Rocket Boots Xtreme
lib:AddRecipe(23888, 30548, 23821) -- Zapthrottle Mote Extractor
lib:AddRecipe(25887, 32814, 25886) -- Purple Smoke Flare
lib:AddRecipe(32381, 39895, 7191) -- Fused Wiring
lib:AddRecipe(33804, 43676, 20475) -- Adamantite Arrow Maker
lib:AddRecipe(34114, 44391, 34113) -- Field Repair Bot 110G
lib:AddRecipe(35186, 46111, 34847) -- Annihilator Holo-Gogs
lib:AddRecipe(35187, 46107, 35185) -- Justicebringer 3000 Specs
lib:AddRecipe(35189, 46108, 35181) -- Powerheal 9000 Lens
lib:AddRecipe(35190, 46109, 35182) -- Hyper-Magnified Moon Specs
lib:AddRecipe(35191, 46106, 35183) -- Wonderheal XT68 Shades
lib:AddRecipe(35192, 46110, 35184) -- Primal-Attuned Goggles
lib:AddRecipe(35193, 46112, 34355) -- Lightning Etched Specs
lib:AddRecipe(35194, 46113, 34356) -- Surestrike Goggles v3.0
lib:AddRecipe(35195, 46114, 34354) -- Mayhem Projection Goggles
lib:AddRecipe(35196, 46115, 34357) -- Hard Khorium Goggles
lib:AddRecipe(35197, 46116, 34353) -- Quad Deathblow X44 Goggles
lib:AddRecipe(35310, 30551, 33092) -- Healing Potion Injector
lib:AddRecipe(35311, 30552, 33093) -- Mana Potion Injector
lib:AddRecipe(35582, 46697, 35581) -- Rocket Boots Xtreme Lite
-- First Aid
lib:AddRecipe(6454, 7935, 6453) -- Strong Anti-Venom
lib:AddRecipe(16112, 7929, 6451) -- Heavy Silk Bandage
lib:AddRecipe(16113, 10840, 8544) -- Mageweave Bandage
lib:AddRecipe(19442, 23787, 19440) -- Powerful Anti-Venom
lib:AddRecipe(21992, 27032, 21990) -- Netherweave Bandage
lib:AddRecipe(21993, 27033, 21991) -- Heavy Netherweave Bandage
lib:AddRecipe(23689, 30021, 23684) -- Crystal Infused Bandage
-- Jewelcrafting
lib:AddRecipe(20854, 25339, 20830) -- Amulet of the Moon
lib:AddRecipe(20855, 25323, 20833) -- Wicked Moonstone Ring
lib:AddRecipe(20856, 25320, 20831) -- Heavy Golden Necklace of Battle
lib:AddRecipe(20970, 25610, 20950) -- Pendant of the Agate Shield
lib:AddRecipe(20971, 25612, 20954) -- Heavy Iron Knuckles
lib:AddRecipe(20972, 25614, 20956) -- Silver Rose Pendant
lib:AddRecipe(20973, 25617, 20958) -- Blazing Citrine Ring
lib:AddRecipe(20974, 25618, 20966) -- Jade Pendant of Blasting
lib:AddRecipe(20975, 25619, 20959) -- The Jade Eye
lib:AddRecipe(20976, 25622, 20967) -- Citrine Pendant of Golden Healing
lib:AddRecipe(21940, 26873, 21756) -- Figurine - Golden Hare
lib:AddRecipe(21941, 26875, 21758) -- Figurine - Black Pearl Panther
lib:AddRecipe(21942, 26878, 20969) -- Ruby Crown of Restoration
lib:AddRecipe(21943, 26881, 21760) -- Figurine - Truesilver Crab
lib:AddRecipe(21944, 26882, 21763) -- Figurine - Truesilver Boar
lib:AddRecipe(21945, 26887, 21754) -- The Aquamarine Ward
lib:AddRecipe(21947, 26896, 21753) -- Gem Studded Band
lib:AddRecipe(21948, 26897, 21766) -- Opal Necklace of Impact
lib:AddRecipe(21949, 26900, 21769) -- Figurine - Ruby Serpent
lib:AddRecipe(21952, 26906, 21774) -- Emerald Crown of Destruction
lib:AddRecipe(21953, 26909, 21777) -- Figurine - Emerald Owl
lib:AddRecipe(21954, 26910, 21778) -- Ring of Bitter Shadows
lib:AddRecipe(21955, 26912, 21784) -- Figurine - Black Diamond Crab
lib:AddRecipe(21956, 26914, 21789) -- Figurine - Dark Iron Scorpid
lib:AddRecipe(21957, 26915, 21792) -- Necklace of the Diamond Tower
lib:AddRecipe(21958, 26918, 21793) -- Arcanite Sword Pendant
lib:AddRecipe(21959, 26920, 21780) -- Blood Crown
lib:AddRecipe(23130, 28903, 23094) -- Teardrop Blood Garnet
lib:AddRecipe(23131, 28905, 23095) -- Bold Blood Garnet
lib:AddRecipe(23133, 28906, 23096) -- Runed Blood Garnet
lib:AddRecipe(23134, 28907, 23097) -- Delicate Blood Garnet
lib:AddRecipe(23135, 28910, 23098) -- Inscribed Flame Spessarite
lib:AddRecipe(23136, 28912, 23099) -- Luminous Flame Spessarite
lib:AddRecipe(23137, 28914, 23100) -- Glinting Flame Spessarite
lib:AddRecipe(23138, 28915, 23101) -- Potent Flame Spessarite
lib:AddRecipe(23140, 28916, 23103) -- Radiant Deep Peridot
lib:AddRecipe(23141, 28917, 23104) -- Jagged Deep Peridot
lib:AddRecipe(23142, 28918, 23105) -- Enduring Deep Peridot
lib:AddRecipe(23143, 28924, 23106) -- Dazzling Deep Peridot
lib:AddRecipe(23144, 28925, 23108) -- Glowing Shadow Draenite
lib:AddRecipe(23145, 28927, 23109) -- Royal Shadow Draenite
lib:AddRecipe(23146, 28933, 23110) -- Shifting Shadow Draenite
lib:AddRecipe(23147, 28936, 23111) -- Sovereign Shadow Draenite
lib:AddRecipe(23148, 28938, 23113) -- Brilliant Golden Draenite
lib:AddRecipe(23149, 28944, 23114) -- Gleaming Golden Draenite
lib:AddRecipe(23150, 28947, 23115) -- Thick Golden Draenite
lib:AddRecipe(23151, 28948, 23116) -- Rigid Golden Draenite
lib:AddRecipe(23152, 28950, 23118) -- Solid Azure Moonstone
lib:AddRecipe(23153, 28953, 23119) -- Sparkling Azure Moonstone
lib:AddRecipe(23154, 28955, 23120) -- Stormy Azure Moonstone
lib:AddRecipe(23155, 28957, 23121) -- Lustrous Azure Moonstone
lib:AddRecipe(24158, 31053, 24079) -- Khorium Band of Shadows
lib:AddRecipe(24159, 31054, 24080) -- Khorium Band of Frost
lib:AddRecipe(24160, 31055, 24082) -- Khorium Inferno Band
lib:AddRecipe(24161, 31056, 24085) -- Khorium Band of Leaves
lib:AddRecipe(24162, 31057, 24086) -- Arcane Khorium Band
lib:AddRecipe(24163, 31058, 24087) -- Heavy Felsteel Ring
lib:AddRecipe(24164, 31060, 24088) -- Delicate Eternium Ring
lib:AddRecipe(24165, 31061, 24089) -- Blazing Eternium Band
lib:AddRecipe(24166, 31067, 24106) -- Thick Felsteel Necklace
lib:AddRecipe(24167, 31068, 24110) -- Living Ruby Pendant
lib:AddRecipe(24168, 31070, 24114) -- Braided Eternium Chain
lib:AddRecipe(24169, 31071, 24116) -- Eye of the Night
lib:AddRecipe(24170, 31072, 24117) -- Embrace of the Dawn
lib:AddRecipe(24171, 31076, 24121) -- Chain of the Twilight Owl
lib:AddRecipe(24172, 31077, 24122) -- Coronet of the Verdant Flame
lib:AddRecipe(24173, 31078, 24123) -- Circlet of Arcane Might
lib:AddRecipe(24174, 31062, 24092) -- Pendant of Frozen Flame
lib:AddRecipe(24175, 31063, 24093) -- Pendant of Thawing
lib:AddRecipe(24176, 31064, 24095) -- Pendant of Withering
lib:AddRecipe(24177, 31065, 24097) -- Pendant of Shadow's End
lib:AddRecipe(24178, 31066, 24098) -- Pendant of the Null Rune
lib:AddRecipe(24179, 31079, 24124) -- Figurine - Felsteel Boar
lib:AddRecipe(24180, 31080, 24125) -- Figurine - Dawnstone Crab
lib:AddRecipe(24181, 31081, 24126) -- Figurine - Living Ruby Serpent
lib:AddRecipe(24182, 31082, 24127) -- Figurine - Talasite Owl
lib:AddRecipe(24183, 31083, 24128) -- Figurine - Nightseye Panther
lib:AddRecipe(24192, 31089, 24031) -- Bright Living Ruby
lib:AddRecipe(24193, 31084, 24027) -- Bold Living Ruby
lib:AddRecipe(24194, 31085, 24028) -- Delicate Living Ruby
lib:AddRecipe(24195, 31087, 24029) -- Teardrop Living Ruby
lib:AddRecipe(24196, 31088, 24030) -- Runed Living Ruby
lib:AddRecipe(24197, 31090, 24032) -- Subtle Living Ruby
lib:AddRecipe(24198, 31091, 24036) -- Flashing Living Ruby
lib:AddRecipe(24199, 31092, 24033) -- Solid Star of Elune
lib:AddRecipe(24200, 31149, 24035) -- Sparkling Star of Elune
lib:AddRecipe(24201, 31094, 24037) -- Lustrous Star of Elune
lib:AddRecipe(24202, 31095, 24039) -- Stormy Star of Elune
lib:AddRecipe(24203, 31096, 24047) -- Brilliant Dawnstone
lib:AddRecipe(24204, 31097, 24048) -- Smooth Dawnstone
lib:AddRecipe(24205, 31098, 24051) -- Rigid Dawnstone
lib:AddRecipe(24206, 31099, 24050) -- Gleaming Dawnstone
lib:AddRecipe(24207, 31100, 24052) -- Thick Dawnstone
lib:AddRecipe(24208, 31101, 24053) -- Mystic Dawnstone
lib:AddRecipe(24209, 31102, 24054) -- Sovereign Nightseye
lib:AddRecipe(24210, 31103, 24055) -- Shifting Nightseye
lib:AddRecipe(24211, 31104, 24056) -- Glowing Nightseye
lib:AddRecipe(24212, 31105, 24057) -- Royal Nightseye
lib:AddRecipe(24213, 31106, 24058) -- Inscribed Noble Topaz
lib:AddRecipe(24214, 31107, 24059) -- Potent Noble Topaz
lib:AddRecipe(24215, 31108, 24060) -- Luminous Noble Topaz
lib:AddRecipe(24216, 31109, 24061) -- Glinting Noble Topaz
lib:AddRecipe(24217, 31110, 24062) -- Enduring Talasite
lib:AddRecipe(24218, 31111, 24066) -- Radiant Talasite
lib:AddRecipe(24219, 31112, 24065) -- Dazzling Talasite
lib:AddRecipe(24220, 31113, 24067) -- Jagged Talasite
lib:AddRecipe(25888, 32810, 25884) -- Primal Stone Statue
lib:AddRecipe(25902, 32866, 25896) -- Powerful Earthstorm Diamond
lib:AddRecipe(25903, 32867, 25897) -- Bracing Earthstorm Diamond
lib:AddRecipe(25904, 32870, 25901) -- Insightful Earthstorm Diamond
lib:AddRecipe(25905, 32868, 25898) -- Tenacious Earthstorm Diamond
lib:AddRecipe(25906, 32869, 25899) -- Brutal Earthstorm Diamond
lib:AddRecipe(25907, 32871, 25890) -- Destructive Skyfire Diamond
lib:AddRecipe(25908, 32873, 25894) -- Swift Skyfire Diamond
lib:AddRecipe(25909, 32872, 25893) -- Mystical Skyfire Diamond
lib:AddRecipe(25910, 32874, 25895) -- Enigmatic Skyfire Diamond
lib:AddRecipe(28291, 34069, 28290) -- Smooth Golden Draenite
lib:AddRecipe(28596, 34590, 28595) -- Bright Blood Garnet
lib:AddRecipe(30826, 37855, 30825) -- Ring of Arcane Shielding
lib:AddRecipe(31358, 31080, 24125) -- Figurine - Dawnstone Crab
lib:AddRecipe(31359, 28918, 23105) -- Enduring Deep Peridot
lib:AddRecipe(31401, 38503, 31398) -- The Frozen Eye
lib:AddRecipe(31402, 38504, 31399) -- The Natural Ward
lib:AddRecipe(31870, 39451, 31860) -- Great Golden Draenite
lib:AddRecipe(31871, 39455, 31862) -- Balanced Shadow Draenite
lib:AddRecipe(31872, 39458, 31864) -- Infused Shadow Draenite
lib:AddRecipe(31873, 39466, 31866) -- Veiled Flame Spessarite
lib:AddRecipe(31874, 39467, 31869) -- Wicked Flame Spessarite
lib:AddRecipe(31875, 39452, 31861) -- Great Dawnstone
lib:AddRecipe(31876, 39463, 31863) -- Balanced Nightseye
lib:AddRecipe(31877, 39462, 31865) -- Infused Nightseye
lib:AddRecipe(31878, 39470, 31867) -- Veiled Noble Topaz
lib:AddRecipe(31879, 39471, 31868) -- Wicked Noble Topaz
lib:AddRecipe(32274, 39705, 32193) -- Bold Crimson Spinel
lib:AddRecipe(32277, 39706, 32194) -- Delicate Crimson Spinel
lib:AddRecipe(32281, 39710, 32195) -- Teardrop Crimson Spinel
lib:AddRecipe(32282, 39711, 32196) -- Runed Crimson Spinel
lib:AddRecipe(32283, 39712, 32197) -- Bright Crimson Spinel
lib:AddRecipe(32284, 39713, 32198) -- Subtle Crimson Spinel
lib:AddRecipe(32285, 39714, 32199) -- Flashing Crimson Spinel
lib:AddRecipe(32286, 39715, 32200) -- Solid Empyrean Sapphire
lib:AddRecipe(32287, 39716, 32201) -- Sparkling Empyrean Sapphire
lib:AddRecipe(32288, 39717, 32202) -- Lustrous Empyrean Sapphire
lib:AddRecipe(32289, 39718, 32203) -- Stormy Empyrean Sapphire
lib:AddRecipe(32290, 39719, 32204) -- Brilliant Lionseye
lib:AddRecipe(32291, 39720, 32205) -- Smooth Lionseye
lib:AddRecipe(32292, 39721, 32206) -- Rigid Lionseye
lib:AddRecipe(32293, 39722, 32207) -- Gleaming Lionseye
lib:AddRecipe(32294, 39723, 32208) -- Thick Lionseye
lib:AddRecipe(32295, 39724, 32209) -- Mystic Lionseye
lib:AddRecipe(32296, 39725, 32210) -- Great Lionseye
lib:AddRecipe(32297, 39727, 32211) -- Sovereign Shadowsong Amethyst
lib:AddRecipe(32298, 39728, 32212) -- Shifting Shadowsong Amethyst
lib:AddRecipe(32299, 39729, 32213) -- Balanced Shadowsong Amethyst
lib:AddRecipe(32300, 39730, 32214) -- Infused Shadowsong Amethyst
lib:AddRecipe(32301, 39731, 32215) -- Glowing Shadowsong Amethyst
lib:AddRecipe(32302, 39732, 32216) -- Royal Shadowsong Amethyst
lib:AddRecipe(32303, 39733, 32217) -- Inscribed Pyrestone
lib:AddRecipe(32304, 39734, 32218) -- Potent Pyrestone
lib:AddRecipe(32305, 39735, 32219) -- Luminous Pyrestone
lib:AddRecipe(32306, 39736, 32220) -- Glinting Pyrestone
lib:AddRecipe(32307, 39737, 32221) -- Veiled Pyrestone
lib:AddRecipe(32308, 39738, 32222) -- Wicked Pyrestone
lib:AddRecipe(32309, 39739, 32223) -- Enduring Seaspray Emerald
lib:AddRecipe(32310, 39740, 32224) -- Radiant Seaspray Emerald
lib:AddRecipe(32311, 39741, 32225) -- Dazzling Seaspray Emerald
lib:AddRecipe(32312, 39742, 32226) -- Jagged Seaspray Emerald
lib:AddRecipe(32411, 39963, 32410) -- Thundering Skyfire Diamond
lib:AddRecipe(32412, 39961, 32409) -- Relentless Earthstorm Diamond
lib:AddRecipe(33155, 42588, 33134) -- Kailee's Rose
lib:AddRecipe(33156, 42589, 33131) -- Crimson Sun
lib:AddRecipe(33157, 42590, 33135) -- Falling Star
lib:AddRecipe(33158, 42591, 33143) -- Stone of Blades
lib:AddRecipe(33159, 42592, 33140) -- Blood of Amber
lib:AddRecipe(33160, 42593, 33144) -- Facet of Eternity
lib:AddRecipe(33305, 42558, 33133) -- Don Julio's Heart
lib:AddRecipe(33622, 39961, 32409) -- Relentless Earthstorm Diamond
lib:AddRecipe(33783, 43493, 33782) -- Steady Talasite
lib:AddRecipe(34221, 44794, 34220) -- Chaotic Skyfire Diamond
lib:AddRecipe(34689, 44794, 34220) -- Chaotic Skyfire Diamond
lib:AddRecipe(35198, 46122, 34362) -- Loop of Forged Power
lib:AddRecipe(35199, 46123, 34363) -- Ring of Flowing Life
lib:AddRecipe(35200, 46124, 34361) -- Hard Khorium Band
lib:AddRecipe(35201, 46125, 34359) -- Pendant of Sunfire
lib:AddRecipe(35202, 46126, 34360) -- Amulet of Flowing Life
lib:AddRecipe(35203, 46127, 34358) -- Hard Khorium Choker
lib:AddRecipe(35238, 39729, 32213) -- Balanced Shadowsong Amethyst
lib:AddRecipe(35239, 39731, 32215) -- Glowing Shadowsong Amethyst
lib:AddRecipe(35240, 39730, 32214) -- Infused Shadowsong Amethyst
lib:AddRecipe(35241, 39732, 32216) -- Royal Shadowsong Amethyst
lib:AddRecipe(35242, 39728, 32212) -- Shifting Shadowsong Amethyst
lib:AddRecipe(35243, 39727, 32211) -- Sovereign Shadowsong Amethyst
lib:AddRecipe(35244, 39705, 32193) -- Bold Crimson Spinel
lib:AddRecipe(35245, 39712, 32197) -- Bright Crimson Spinel
lib:AddRecipe(35246, 39706, 32194) -- Delicate Crimson Spinel
lib:AddRecipe(35247, 39714, 32199) -- Flashing Crimson Spinel
lib:AddRecipe(35248, 39711, 32196) -- Runed Crimson Spinel
lib:AddRecipe(35249, 39713, 32198) -- Subtle Crimson Spinel
lib:AddRecipe(35250, 39710, 32195) -- Teardrop Crimson Spinel
lib:AddRecipe(35251, 39741, 32225) -- Dazzling Seaspray Emerald
lib:AddRecipe(35252, 39739, 32223) -- Enduring Seaspray Emerald
lib:AddRecipe(35253, 39742, 32226) -- Jagged Seaspray Emerald
lib:AddRecipe(35254, 39740, 32224) -- Radiant Seaspray Emerald
lib:AddRecipe(35255, 39719, 32204) -- Brilliant Lionseye
lib:AddRecipe(35256, 39722, 32207) -- Gleaming Lionseye
lib:AddRecipe(35257, 39725, 32210) -- Great Lionseye
lib:AddRecipe(35258, 39724, 32209) -- Mystic Lionseye
lib:AddRecipe(35259, 39721, 32206) -- Rigid Lionseye
lib:AddRecipe(35260, 39720, 32205) -- Smooth Lionseye
lib:AddRecipe(35261, 39723, 32208) -- Thick Lionseye
lib:AddRecipe(35262, 39717, 32202) -- Lustrous Empyrean Sapphire
lib:AddRecipe(35263, 39715, 32200) -- Solid Empyrean Sapphire
lib:AddRecipe(35264, 39716, 32201) -- Sparkling Empyrean Sapphire
lib:AddRecipe(35265, 39718, 32203) -- Stormy Empyrean Sapphire
lib:AddRecipe(35266, 39736, 32220) -- Glinting Pyrestone
lib:AddRecipe(35267, 39733, 32217) -- Inscribed Pyrestone
lib:AddRecipe(35268, 39735, 32219) -- Luminous Pyrestone
lib:AddRecipe(35269, 39734, 32218) -- Potent Pyrestone
lib:AddRecipe(35270, 39737, 32221) -- Veiled Pyrestone
lib:AddRecipe(35271, 39738, 32222) -- Wicked Pyrestone
lib:AddRecipe(35304, 31092, 24033) -- Solid Star of Elune
lib:AddRecipe(35305, 31088, 24030) -- Runed Living Ruby
lib:AddRecipe(35306, 31089, 24031) -- Bright Living Ruby
lib:AddRecipe(35307, 31098, 24051) -- Rigid Dawnstone
lib:AddRecipe(35322, 46403, 35315) -- Quick Dawnstone
lib:AddRecipe(35323, 46404, 35316) -- Reckless Noble Topaz
lib:AddRecipe(35325, 46405, 35318) -- Forceful Talasite
lib:AddRecipe(35502, 46597, 35501) -- Eternal Earthstorm Diamond
lib:AddRecipe(35505, 46601, 35503) -- Ember Skyfire Diamond
lib:AddRecipe(35533, 46126, 34360) -- Amulet of Flowing Life
lib:AddRecipe(35534, 46124, 34361) -- Hard Khorium Band
lib:AddRecipe(35535, 46127, 34358) -- Hard Khorium Choker
lib:AddRecipe(35536, 46122, 34362) -- Loop of Forged Power
lib:AddRecipe(35537, 46125, 34359) -- Pendant of Sunfire
lib:AddRecipe(35538, 46123, 34363) -- Ring of Flowing Life
lib:AddRecipe(35695, 46775, 35693) -- Figurine - Empyrean Tortoise
lib:AddRecipe(35696, 46776, 35694) -- Figurine - Khorium Boar
lib:AddRecipe(35697, 46777, 35700) -- Figurine - Crimson Serpent
lib:AddRecipe(35698, 46778, 35702) -- Figurine - Shadowsong Panther
lib:AddRecipe(35699, 46779, 35703) -- Figurine - Seaspray Albatross
lib:AddRecipe(35708, 46803, 35707) -- Regal Nightseye
lib:AddRecipe(35762, 47055, 35760) -- Reckless Pyrestone
lib:AddRecipe(35763, 47056, 35761) -- Quick Lionseye
lib:AddRecipe(35764, 47054, 35758) -- Steady Seaspray Emerald
lib:AddRecipe(35765, 47053, 35759) -- Forceful Seaspray Emerald
lib:AddRecipe(35766, 47054, 35758) -- Steady Seaspray Emerald
lib:AddRecipe(35767, 47055, 35760) -- Reckless Pyrestone
lib:AddRecipe(35768, 47056, 35761) -- Quick Lionseye
lib:AddRecipe(35769, 47053, 35759) -- Forceful Seaspray Emerald
lib:AddRecipe(37504, 48789, 37503) -- Purified Shadowsong Amethyst
-- Leatherworking
lib:AddRecipe(2406, 2158, 2307) -- Fine Leather Boots
lib:AddRecipe(2407, 2163, 2311) -- White Leather Jerkin
lib:AddRecipe(2408, 2164, 2312) -- Fine Leather Gloves
lib:AddRecipe(2409, 2169, 2317) -- Dark Leather Tunic
lib:AddRecipe(4293, 3762, 4244) -- Hillman's Leather Vest
lib:AddRecipe(4294, 3767, 4250) -- Hillman's Belt
lib:AddRecipe(4295, 7153, 5965) -- Guardian Cloak
lib:AddRecipe(4296, 3769, 4252) -- Dark Leather Shoulders
lib:AddRecipe(4297, 3771, 4254) -- Barbaric Gloves
lib:AddRecipe(4298, 3775, 4258) -- Guardian Belt
lib:AddRecipe(4299, 3773, 4256) -- Guardian Armor
lib:AddRecipe(4300, 3777, 4260) -- Guardian Leather Bracers
lib:AddRecipe(4301, 3779, 4264) -- Barbaric Belt
lib:AddRecipe(5083, 5244, 5081) -- Kodo Hide Bag
lib:AddRecipe(5786, 6702, 5780) -- Murloc Scale Belt
lib:AddRecipe(5787, 6703, 5781) -- Murloc Scale Breastplate
lib:AddRecipe(5788, 6704, 5782) -- Thick Murloc Armor
lib:AddRecipe(5789, 6705, 5783) -- Murloc Scale Bracers
lib:AddRecipe(5972, 7133, 5958) -- Fine Leather Pants
lib:AddRecipe(5973, 7149, 5963) -- Barbaric Leggings
lib:AddRecipe(5974, 7153, 5965) -- Guardian Cloak
lib:AddRecipe(6474, 7953, 6466) -- Deviate Scale Cloak
lib:AddRecipe(6475, 7954, 6467) -- Deviate Scale Gloves
lib:AddRecipe(6476, 7955, 6468) -- Deviate Scale Belt
lib:AddRecipe(6710, 8322, 6709) -- Moonglow Vest
lib:AddRecipe(7288, 9064, 7280) -- Rugged Leather Pants
lib:AddRecipe(7289, 9070, 7283) -- Black Whelp Cloak
lib:AddRecipe(7290, 9072, 7284) -- Red Whelp Gloves
lib:AddRecipe(7360, 3765, 4248) -- Dark Leather Gloves
lib:AddRecipe(7361, 9146, 7349) -- Herbalist's Gloves
lib:AddRecipe(7362, 9147, 7352) -- Earthen Leather Shoulders
lib:AddRecipe(7363, 9148, 7358) -- Pilferer's Gloves
lib:AddRecipe(7364, 9149, 7359) -- Heavy Earthen Gloves
lib:AddRecipe(7449, 9195, 7373) -- Dusky Leather Leggings
lib:AddRecipe(7450, 9197, 7375) -- Green Whelp Armor
lib:AddRecipe(7451, 9202, 7386) -- Green Whelp Bracers
lib:AddRecipe(7452, 9207, 7390) -- Dusky Boots
lib:AddRecipe(7453, 9208, 7391) -- Swift Boots
lib:AddRecipe(7613, 3772, 4255) -- Green Leather Armor
lib:AddRecipe(8384, 10490, 8174) -- Comfortable Leather Hat
lib:AddRecipe(8385, 10509, 8187) -- Turtle Scale Gloves
lib:AddRecipe(8386, 10520, 8200) -- Big Voodoo Robe
lib:AddRecipe(8387, 10531, 8201) -- Big Voodoo Mask
lib:AddRecipe(8388, 10550, 8195) -- Nightscape Cloak
lib:AddRecipe(8389, 10560, 8202) -- Big Voodoo Pants
lib:AddRecipe(8390, 10562, 8216) -- Big Voodoo Cloak
lib:AddRecipe(8395, 10525, 8203) -- Tough Scorpid Breastplate
lib:AddRecipe(8397, 10533, 8205) -- Tough Scorpid Bracers
lib:AddRecipe(8398, 10542, 8204) -- Tough Scorpid Gloves
lib:AddRecipe(8399, 10554, 8209) -- Tough Scorpid Boots
lib:AddRecipe(8400, 10564, 8207) -- Tough Scorpid Shoulders
lib:AddRecipe(8401, 10568, 8206) -- Tough Scorpid Leggings
lib:AddRecipe(8402, 10570, 8208) -- Tough Scorpid Helm
lib:AddRecipe(8403, 10529, 8210) -- Wild Leather Shoulders
lib:AddRecipe(8404, 10544, 8211) -- Wild Leather Vest
lib:AddRecipe(8405, 10546, 8214) -- Wild Leather Helmet
lib:AddRecipe(8406, 10566, 8213) -- Wild Leather Boots
lib:AddRecipe(8407, 10572, 8212) -- Wild Leather Leggings
lib:AddRecipe(8408, 10574, 8215) -- Wild Leather Cloak
lib:AddRecipe(8409, 10516, 8192) -- Nightscape Shoulders
lib:AddRecipe(13287, 4096, 4455) -- Raptor Hide Harness
lib:AddRecipe(13288, 4097, 4456) -- Raptor Hide Belt
lib:AddRecipe(14635, 3778, 4262) -- Gem-studded Leather Belt
lib:AddRecipe(15724, 19048, 15077) -- Heavy Scorpid Bracers
lib:AddRecipe(15725, 19049, 15083) -- Wicked Leather Gauntlets
lib:AddRecipe(15726, 19050, 15045) -- Green Dragonscale Breastplate
lib:AddRecipe(15727, 19051, 15076) -- Heavy Scorpid Vest
lib:AddRecipe(15728, 19052, 15084) -- Wicked Leather Bracers
lib:AddRecipe(15729, 19053, 15074) -- Chimeric Gloves
lib:AddRecipe(15730, 19054, 15047) -- Red Dragonscale Breastplate
lib:AddRecipe(15731, 19055, 15091) -- Runic Leather Gauntlets
lib:AddRecipe(15732, 19059, 15054) -- Volcanic Leggings
lib:AddRecipe(15733, 19060, 15046) -- Green Dragonscale Leggings
lib:AddRecipe(15734, 19061, 15061) -- Living Shoulders
lib:AddRecipe(15735, 19062, 15067) -- Ironfeather Shoulders
lib:AddRecipe(15737, 19063, 15073) -- Chimeric Boots
lib:AddRecipe(15738, 19064, 15078) -- Heavy Scorpid Gauntlets
lib:AddRecipe(15739, 19065, 15092) -- Runic Leather Bracers
lib:AddRecipe(15740, 19066, 15071) -- Frostsaber Boots
lib:AddRecipe(15741, 19067, 15057) -- Stormshroud Pants
lib:AddRecipe(15742, 19068, 15064) -- Warbear Harness
lib:AddRecipe(15743, 19070, 15082) -- Heavy Scorpid Belt
lib:AddRecipe(15744, 19071, 15086) -- Wicked Leather Headband
lib:AddRecipe(15745, 19072, 15093) -- Runic Leather Belt
lib:AddRecipe(15746, 19073, 15072) -- Chimeric Leggings
lib:AddRecipe(15747, 19074, 15069) -- Frostsaber Leggings
lib:AddRecipe(15748, 19075, 15079) -- Heavy Scorpid Leggings
lib:AddRecipe(15749, 19076, 15053) -- Volcanic Breastplate
lib:AddRecipe(15751, 19077, 15048) -- Blue Dragonscale Breastplate
lib:AddRecipe(15752, 19078, 15060) -- Living Leggings
lib:AddRecipe(15753, 19079, 15056) -- Stormshroud Armor
lib:AddRecipe(15754, 19080, 15065) -- Warbear Woolies
lib:AddRecipe(15755, 19081, 15075) -- Chimeric Vest
lib:AddRecipe(15756, 19082, 15094) -- Runic Leather Headband
lib:AddRecipe(15757, 19083, 15087) -- Wicked Leather Pants
lib:AddRecipe(15758, 19084, 15063) -- Devilsaur Gauntlets
lib:AddRecipe(15759, 19085, 15050) -- Black Dragonscale Breastplate
lib:AddRecipe(15760, 19086, 15066) -- Ironfeather Breastplate
lib:AddRecipe(15761, 19087, 15070) -- Frostsaber Gloves
lib:AddRecipe(15762, 19088, 15080) -- Heavy Scorpid Helm
lib:AddRecipe(15763, 19089, 15049) -- Blue Dragonscale Shoulders
lib:AddRecipe(15764, 19090, 15058) -- Stormshroud Shoulders
lib:AddRecipe(15765, 19091, 15095) -- Runic Leather Pants
lib:AddRecipe(15768, 19092, 15088) -- Wicked Leather Belt
lib:AddRecipe(15769, 19093, 15138) -- Onyxia Scale Cloak
lib:AddRecipe(15770, 19094, 15051) -- Black Dragonscale Shoulders
lib:AddRecipe(15771, 19095, 15059) -- Living Breastplate
lib:AddRecipe(15772, 19097, 15062) -- Devilsaur Leggings
lib:AddRecipe(15773, 19098, 15085) -- Wicked Leather Armor
lib:AddRecipe(15774, 19100, 15081) -- Heavy Scorpid Shoulders
lib:AddRecipe(15775, 19101, 15055) -- Volcanic Shoulders
lib:AddRecipe(15776, 19102, 15090) -- Runic Leather Armor
lib:AddRecipe(15777, 19103, 15096) -- Runic Leather Shoulders
lib:AddRecipe(15779, 19104, 15068) -- Frostsaber Tunic
lib:AddRecipe(15781, 19107, 15052) -- Black Dragonscale Leggings
lib:AddRecipe(17022, 20853, 16982) -- Corehound Boots
lib:AddRecipe(17023, 20854, 16983) -- Molten Helm
lib:AddRecipe(17025, 20855, 16984) -- Black Dragonscale Boots
lib:AddRecipe(17722, 21943, 17721) -- Gloves of the Greatfather
lib:AddRecipe(18239, 22711, 18238) -- Shadowskin Gloves
lib:AddRecipe(18252, 22727, 18251) -- Core Armor Kit
lib:AddRecipe(18514, 22921, 18504) -- Girdle of Insight
lib:AddRecipe(18515, 22922, 18506) -- Mongoose Boots
lib:AddRecipe(18516, 22923, 18508) -- Swift Flight Bracers
lib:AddRecipe(18517, 22926, 18509) -- Chromatic Cloak
lib:AddRecipe(18518, 22927, 18510) -- Hide of the Wild
lib:AddRecipe(18519, 22928, 18511) -- Shifting Cloak
lib:AddRecipe(18731, 23190, 18662) -- Heavy Leather Ball
lib:AddRecipe(18949, 23399, 18948) -- Barbaric Bracers
lib:AddRecipe(19326, 23703, 19044) -- Might of the Timbermaw
lib:AddRecipe(19327, 23704, 19049) -- Timbermaw Brawlers
lib:AddRecipe(19328, 23705, 19052) -- Dawn Treaders
lib:AddRecipe(19329, 23706, 19058) -- Golden Mantle of the Dawn
lib:AddRecipe(19330, 23707, 19149) -- Lava Belt
lib:AddRecipe(19331, 23708, 19157) -- Chromatic Gauntlets
lib:AddRecipe(19332, 23709, 19162) -- Corehound Belt
lib:AddRecipe(19333, 23710, 19163) -- Molten Belt
lib:AddRecipe(19769, 24121, 19685) -- Primal Batskin Jerkin
lib:AddRecipe(19770, 24122, 19686) -- Primal Batskin Gloves
lib:AddRecipe(19771, 24123, 19687) -- Primal Batskin Bracers
lib:AddRecipe(19772, 24124, 19688) -- Blood Tiger Breastplate
lib:AddRecipe(19773, 24125, 19689) -- Blood Tiger Shoulders
lib:AddRecipe(20253, 19068, 15064) -- Warbear Harness
lib:AddRecipe(20254, 19080, 15065) -- Warbear Woolies
lib:AddRecipe(20382, 24703, 20380) -- Dreamscale Breastplate
lib:AddRecipe(20506, 24846, 20481) -- Spitfire Bracers
lib:AddRecipe(20507, 24847, 20480) -- Spitfire Gauntlets
lib:AddRecipe(20508, 24848, 20479) -- Spitfire Breastplate
lib:AddRecipe(20509, 24849, 20476) -- Sandstalker Bracers
lib:AddRecipe(20510, 24850, 20477) -- Sandstalker Gauntlets
lib:AddRecipe(20511, 24851, 20478) -- Sandstalker Breastplate
lib:AddRecipe(20576, 24940, 20575) -- Black Whelp Tunic
lib:AddRecipe(21548, 26279, 21278) -- Stormshroud Gloves
lib:AddRecipe(22692, 28219, 22661) -- Polar Tunic
lib:AddRecipe(22694, 28220, 22662) -- Polar Gloves
lib:AddRecipe(22695, 28221, 22663) -- Polar Bracers
lib:AddRecipe(22696, 28222, 22664) -- Icy Scale Breastplate
lib:AddRecipe(22697, 28223, 22666) -- Icy Scale Gauntlets
lib:AddRecipe(22698, 28224, 22665) -- Icy Scale Bracers
lib:AddRecipe(22769, 28474, 22761) -- Bramblewood Belt
lib:AddRecipe(22770, 28473, 22760) -- Bramblewood Boots
lib:AddRecipe(22771, 28472, 22759) -- Bramblewood Helm
lib:AddRecipe(25720, 32455, 23793) -- Heavy Knothide Leather
lib:AddRecipe(25721, 32457, 25651) -- Vindicator's Armor Kit
lib:AddRecipe(25722, 32458, 25652) -- Magister's Armor Kit
lib:AddRecipe(25725, 32461, 25653) -- Riding Crop
lib:AddRecipe(25726, 32482, 25679) -- Comfortable Insoles
lib:AddRecipe(25728, 32485, 25680) -- Stylin' Purple Hat
lib:AddRecipe(25729, 32487, 25681) -- Stylin' Adventure Hat
lib:AddRecipe(25730, 32489, 25682) -- Stylin' Jungle Hat
lib:AddRecipe(25731, 32488, 25683) -- Stylin' Crimson Hat
lib:AddRecipe(25732, 32490, 25685) -- Fel Leather Gloves
lib:AddRecipe(25733, 32493, 25686) -- Fel Leather Boots
lib:AddRecipe(25734, 32494, 25687) -- Fel Leather Leggings
lib:AddRecipe(25735, 32495, 25689) -- Heavy Clefthoof Vest
lib:AddRecipe(25736, 32496, 25690) -- Heavy Clefthoof Leggings
lib:AddRecipe(25737, 32497, 25691) -- Heavy Clefthoof Boots
lib:AddRecipe(25738, 32498, 25695) -- Felstalker Belt
lib:AddRecipe(25739, 32499, 25697) -- Felstalker Bracer
lib:AddRecipe(25740, 32500, 25696) -- Felstalker Breastplate
lib:AddRecipe(25741, 32501, 25694) -- Netherfury Belt
lib:AddRecipe(25742, 32502, 25692) -- Netherfury Leggings
lib:AddRecipe(25743, 32503, 25693) -- Netherfury Boots
lib:AddRecipe(29213, 32498, 25695) -- Felstalker Belt
lib:AddRecipe(29214, 32499, 25697) -- Felstalker Bracer
lib:AddRecipe(29215, 32500, 25696) -- Felstalker Breastplate
lib:AddRecipe(29217, 32501, 25694) -- Netherfury Belt
lib:AddRecipe(29218, 32503, 25693) -- Netherfury Boots
lib:AddRecipe(29219, 32502, 25692) -- Netherfury Leggings
lib:AddRecipe(29664, 35530, 29540) -- Reinforced Mining Bag
lib:AddRecipe(29669, 35520, 29483) -- Shadow Armor Kit
lib:AddRecipe(29672, 35521, 29485) -- Flame Armor Kit
lib:AddRecipe(29673, 35522, 29486) -- Frost Armor Kit
lib:AddRecipe(29674, 35523, 29487) -- Nature Armor Kit
lib:AddRecipe(29675, 35524, 29488) -- Arcane Armor Kit
lib:AddRecipe(29677, 35525, 29489) -- Enchanted Felscale Leggings
lib:AddRecipe(29682, 35526, 29490) -- Enchanted Felscale Gloves
lib:AddRecipe(29684, 35527, 29491) -- Enchanted Felscale Boots
lib:AddRecipe(29689, 35529, 29492) -- Flamescale Leggings
lib:AddRecipe(29691, 35528, 29493) -- Flamescale Boots
lib:AddRecipe(29693, 35531, 29494) -- Flamescale Belt
lib:AddRecipe(29698, 35532, 29495) -- Enchanted Clefthoof Leggings
lib:AddRecipe(29700, 35533, 29496) -- Enchanted Clefthoof Gloves
lib:AddRecipe(29701, 35534, 29497) -- Enchanted Clefthoof Boots
lib:AddRecipe(29702, 35535, 29498) -- Blastguard Pants
lib:AddRecipe(29703, 35536, 29499) -- Blastguard Boots
lib:AddRecipe(29704, 35537, 29500) -- Blastguard Belt
lib:AddRecipe(29713, 35538, 29532) -- Drums of Panic
lib:AddRecipe(29714, 35539, 29531) -- Drums of Restoration
lib:AddRecipe(29717, 35543, 29529) -- Drums of Battle
lib:AddRecipe(29718, 35544, 29530) -- Drums of Speed
lib:AddRecipe(29719, 35549, 29533) -- Cobrahide Leg Armor
lib:AddRecipe(29720, 35555, 29534) -- Clefthide Leg Armor
lib:AddRecipe(29721, 35557, 29536) -- Nethercleft Leg Armor
lib:AddRecipe(29722, 35554, 29535) -- Nethercobra Leg Armor
lib:AddRecipe(29723, 35558, 29502) -- Cobrascale Hood
lib:AddRecipe(29724, 35559, 29503) -- Cobrascale Gloves
lib:AddRecipe(29725, 35560, 29504) -- Windscale Hood
lib:AddRecipe(29726, 35561, 29505) -- Hood of Primal Life
lib:AddRecipe(29727, 35562, 29506) -- Gloves of the Living Touch
lib:AddRecipe(29728, 35563, 29507) -- Windslayer Wraps
lib:AddRecipe(29729, 35564, 29508) -- Living Dragonscale Helm
lib:AddRecipe(29730, 35567, 29512) -- Earthen Netherscale Boots
lib:AddRecipe(29731, 35568, 29509) -- Windstrike Gloves
lib:AddRecipe(29732, 35572, 29510) -- Netherdrake Helm
lib:AddRecipe(29733, 35573, 29511) -- Netherdrake Gloves
lib:AddRecipe(29734, 35574, 29514) -- Thick Netherscale Breastplate
lib:AddRecipe(30301, 36349, 30042) -- Belt of Natural Power
lib:AddRecipe(30302, 36351, 30040) -- Belt of Deep Shadow
lib:AddRecipe(30303, 36352, 30046) -- Belt of the Black Eagle
lib:AddRecipe(30304, 36353, 30044) -- Monsoon Belt
lib:AddRecipe(30305, 36355, 30041) -- Boots of Natural Grace
lib:AddRecipe(30306, 36357, 30039) -- Boots of Utter Darkness
lib:AddRecipe(30307, 36358, 30045) -- Boots of the Crimson Hawk
lib:AddRecipe(30308, 36359, 30043) -- Hurricane Boots
lib:AddRecipe(30444, 35530, 29540) -- Reinforced Mining Bag
lib:AddRecipe(31361, 35549, 29533) -- Cobrahide Leg Armor
lib:AddRecipe(31362, 35554, 29535) -- Nethercobra Leg Armor
lib:AddRecipe(32429, 39997, 32398) -- Boots of Shackled Souls
lib:AddRecipe(32430, 40000, 32399) -- Bracers of Shackled Souls
lib:AddRecipe(32431, 40001, 32400) -- Greaves of Shackled Souls
lib:AddRecipe(32432, 40002, 32397) -- Waistguard of Shackled Souls
lib:AddRecipe(32433, 40003, 32394) -- Redeemed Soul Moccasins
lib:AddRecipe(32434, 40004, 32395) -- Redeemed Soul Wristguards
lib:AddRecipe(32435, 40005, 32396) -- Redeemed Soul Legguards
lib:AddRecipe(32436, 40006, 32393) -- Redeemed Soul Cinch
lib:AddRecipe(32744, 41156, 32582) -- Bracers of Renewed Life
lib:AddRecipe(32745, 41157, 32583) -- Shoulderpads of Renewed Life
lib:AddRecipe(32746, 41158, 32580) -- Swiftstrike Bracers
lib:AddRecipe(32747, 41160, 32581) -- Swiftstrike Shoulders
lib:AddRecipe(32748, 41161, 32574) -- Bindings of Lightning Reflexes
lib:AddRecipe(32749, 41162, 32575) -- Shoulders of Lightning Reflexes
lib:AddRecipe(32750, 41163, 32577) -- Living Earth Bindings
lib:AddRecipe(32751, 41164, 32579) -- Living Earth Shoulders
lib:AddRecipe(33124, 42546, 33122) -- Cloak of Darkness
lib:AddRecipe(33205, 42731, 33204) -- Shadowprowler's Chestguard
lib:AddRecipe(34172, 35544, 29530) -- Drums of Speed
lib:AddRecipe(34173, 35544, 29530) -- Drums of Speed
lib:AddRecipe(34174, 35539, 29531) -- Drums of Restoration
lib:AddRecipe(34175, 35539, 29531) -- Drums of Restoration
lib:AddRecipe(34200, 44359, 34105) -- Quiver of a Thousand Feathers
lib:AddRecipe(34201, 44768, 34106) -- Netherscale Ammo Pouch
lib:AddRecipe(34218, 44768, 34106) -- Netherscale Ammo Pouch
lib:AddRecipe(34262, 44953, 34086) -- Winter Boots
lib:AddRecipe(34491, 45117, 34490) -- Bag of Many Hides
lib:AddRecipe(35212, 46132, 34372) -- Leather Gauntlets of the Sun
lib:AddRecipe(35213, 46133, 34374) -- Fletcher's Gloves of the Phoenix
lib:AddRecipe(35214, 46134, 34370) -- Gloves of Immortal Dusk
lib:AddRecipe(35215, 46135, 34376) -- Sun-Drenched Scale Gloves
lib:AddRecipe(35216, 46136, 34371) -- Leather Chestguard of the Sun
lib:AddRecipe(35217, 46137, 34373) -- Embrace of the Phoenix
lib:AddRecipe(35218, 46138, 34369) -- Carapace of Sun and Shadow
lib:AddRecipe(35219, 46139, 34375) -- Sun-Drenched Scale Chestguard
lib:AddRecipe(35300, 35568, 29509) -- Windstrike Gloves
lib:AddRecipe(35301, 35573, 29511) -- Netherdrake Gloves
lib:AddRecipe(35302, 35559, 29503) -- Cobrascale Gloves
lib:AddRecipe(35303, 35562, 29506) -- Gloves of the Living Touch
lib:AddRecipe(35517, 41161, 32574) -- Bindings of Lightning Reflexes
lib:AddRecipe(35519, 41156, 32582) -- Bracers of Renewed Life
lib:AddRecipe(35520, 41163, 32577) -- Living Earth Bindings
lib:AddRecipe(35521, 41164, 32579) -- Living Earth Shoulders
lib:AddRecipe(35523, 41157, 32583) -- Shoulderpads of Renewed Life
lib:AddRecipe(35524, 41162, 32575) -- Shoulders of Lightning Reflexes
lib:AddRecipe(35527, 41158, 32580) -- Swiftstrike Bracers
lib:AddRecipe(35528, 41160, 32581) -- Swiftstrike Shoulders
lib:AddRecipe(35539, 46138, 34369) -- Carapace of Sun and Shadow
lib:AddRecipe(35540, 46137, 34373) -- Embrace of the Phoenix
lib:AddRecipe(35541, 46133, 34374) -- Fletcher's Gloves of the Phoenix
lib:AddRecipe(35542, 46134, 34370) -- Gloves of Immortal Dusk
lib:AddRecipe(35545, 46136, 34371) -- Leather Chestguard of the Sun
lib:AddRecipe(35546, 46132, 34372) -- Leather Gauntlets of the Sun
lib:AddRecipe(35549, 46139, 34375) -- Sun-Drenched Scale Chestguard
lib:AddRecipe(35550, 46135, 34376) -- Sun-Drenched Scale Gloves
lib:AddRecipe(185922, 351766, 185852) -- Greater Drums of War
lib:AddRecipe(185923, 351768, 185851) -- Greater Drums of Speed
lib:AddRecipe(185924, 351769, 185850) -- Greater Drums of Restoration
lib:AddRecipe(185925, 351770, 185849) -- Greater Drums of Panic
lib:AddRecipe(185926, 351771, 185848) -- Greater Drums of Battle
lib:AddRecipe(187048, 351769, 185850) -- Greater Drums of Restoration
lib:AddRecipe(187049, 351768, 185851) -- Greater Drums of Speed
-- Mining
lib:AddRecipe(35273, 46353, 35128) -- Smelt Hardened Khorium
-- Tailoring
lib:AddRecipe(2598, 2389, 2572) -- Red Linen Robe
lib:AddRecipe(2601, 2403, 2585) -- Gray Woolen Robe
lib:AddRecipe(4292, 3758, 4241) -- Green Woolen Bag
lib:AddRecipe(4345, 3847, 4313) -- Red Woolen Boots
lib:AddRecipe(4346, 3844, 4311) -- Heavy Woolen Cloak
lib:AddRecipe(4347, 3849, 4315) -- Reinforced Woolen Shoulders
lib:AddRecipe(4348, 3868, 4331) -- Phoenix Gloves
lib:AddRecipe(4349, 3851, 4317) -- Phoenix Pants
lib:AddRecipe(4350, 3856, 4321) -- Spider Silk Slippers
lib:AddRecipe(4351, 3858, 4323) -- Shadow Hood
lib:AddRecipe(4352, 3860, 4325) -- Boots of the Enchanter
lib:AddRecipe(4353, 3863, 4328) -- Spider Belt
lib:AddRecipe(4354, 3872, 4335) -- Rich Purple Silk Shirt
lib:AddRecipe(4355, 3862, 4327) -- Icy Cloak
lib:AddRecipe(4356, 3864, 4329) -- Star Belt
lib:AddRecipe(5771, 6686, 5762) -- Red Linen Bag
lib:AddRecipe(5772, 6688, 5763) -- Red Woolen Bag
lib:AddRecipe(5773, 6692, 5770) -- Robes of Arcana
lib:AddRecipe(5774, 6693, 5764) -- Green Silk Pack
lib:AddRecipe(5775, 6695, 5765) -- Black Silk Pack
lib:AddRecipe(6270, 7630, 6240) -- Blue Linen Vest
lib:AddRecipe(6271, 7629, 6239) -- Red Linen Vest
lib:AddRecipe(6272, 7633, 6242) -- Blue Linen Robe
lib:AddRecipe(6273, 7636, 6243) -- Green Woolen Robe
lib:AddRecipe(6274, 7639, 6263) -- Blue Overalls
lib:AddRecipe(6275, 7643, 6264) -- Greater Adept's Robe
lib:AddRecipe(6390, 7892, 6384) -- Stylish Blue Shirt
lib:AddRecipe(6391, 7893, 6385) -- Stylish Green Shirt
lib:AddRecipe(6401, 3870, 4333) -- Dark Silk Shirt
lib:AddRecipe(7084, 8793, 7059) -- Crimson Silk Shoulders
lib:AddRecipe(7085, 8795, 7060) -- Azure Shoulders
lib:AddRecipe(7086, 8797, 7061) -- Earthen Silk Belt
lib:AddRecipe(7087, 8789, 7056) -- Crimson Silk Cloak
lib:AddRecipe(7088, 8802, 7063) -- Crimson Silk Robe
lib:AddRecipe(7089, 8786, 7053) -- Azure Silk Cloak
lib:AddRecipe(7090, 8784, 7065) -- Green Silk Armor
lib:AddRecipe(7091, 8782, 7049) -- Truefaith Gloves
lib:AddRecipe(7092, 8780, 7047) -- Hands of Darkness
lib:AddRecipe(7093, 8778, 7027) -- Boots of Darkness
lib:AddRecipe(7114, 3854, 4319) -- Azure Silk Gloves
lib:AddRecipe(10300, 12056, 10007) -- Red Mageweave Vest
lib:AddRecipe(10301, 12059, 10008) -- White Bandit Mask
lib:AddRecipe(10302, 12060, 10009) -- Red Mageweave Pants
lib:AddRecipe(10303, 12062, 10010) -- Stormcloth Pants
lib:AddRecipe(10304, 12063, 10011) -- Stormcloth Gloves
lib:AddRecipe(10311, 12064, 10052) -- Orange Martial Shirt
lib:AddRecipe(10312, 12066, 10018) -- Red Mageweave Gloves
lib:AddRecipe(10313, 12068, 10020) -- Stormcloth Vest
lib:AddRecipe(10314, 12075, 10054) -- Lavender Mageweave Shirt
lib:AddRecipe(10315, 12078, 10029) -- Red Mageweave Shoulders
lib:AddRecipe(10316, 12047, 10048) -- Colorful Kilt
lib:AddRecipe(10317, 12080, 10055) -- Pink Mageweave Shirt
lib:AddRecipe(10318, 12081, 10030) -- Admiral's Hat
lib:AddRecipe(10319, 12083, 10032) -- Stormcloth Headband
lib:AddRecipe(10320, 12084, 10033) -- Red Mageweave Headband
lib:AddRecipe(10321, 12085, 10034) -- Tuxedo Shirt
lib:AddRecipe(10322, 12087, 10038) -- Stormcloth Shoulders
lib:AddRecipe(10323, 12089, 10035) -- Tuxedo Pants
lib:AddRecipe(10324, 12090, 10039) -- Stormcloth Boots
lib:AddRecipe(10325, 12091, 10040) -- White Wedding Dress
lib:AddRecipe(10326, 12093, 10036) -- Tuxedo Jacket
lib:AddRecipe(10463, 12086, 10025) -- Shadoweave Mask
lib:AddRecipe(10728, 3873, 4336) -- Black Swashbuckler's Shirt
lib:AddRecipe(14466, 18403, 13869) -- Frostweave Tunic
lib:AddRecipe(14467, 18404, 13868) -- Frostweave Robe
lib:AddRecipe(14468, 18405, 14046) -- Runecloth Bag
lib:AddRecipe(14469, 18406, 13858) -- Runecloth Robe
lib:AddRecipe(14470, 18407, 13857) -- Runecloth Tunic
lib:AddRecipe(14471, 18408, 14042) -- Cindercloth Vest
lib:AddRecipe(14472, 18409, 13860) -- Runecloth Cloak
lib:AddRecipe(14473, 18410, 14143) -- Ghostweave Belt
lib:AddRecipe(14474, 18411, 13870) -- Frostweave Gloves
lib:AddRecipe(14476, 18412, 14043) -- Cindercloth Gloves
lib:AddRecipe(14477, 18413, 14142) -- Ghostweave Gloves
lib:AddRecipe(14478, 18414, 14100) -- Brightcloth Robe
lib:AddRecipe(14479, 18415, 14101) -- Brightcloth Gloves
lib:AddRecipe(14480, 18416, 14141) -- Ghostweave Vest
lib:AddRecipe(14481, 18417, 13863) -- Runecloth Gloves
lib:AddRecipe(14482, 18418, 14044) -- Cindercloth Cloak
lib:AddRecipe(14483, 18419, 14107) -- Felcloth Pants
lib:AddRecipe(14484, 18420, 14103) -- Brightcloth Cloak
lib:AddRecipe(14485, 18421, 14132) -- Wizardweave Leggings
lib:AddRecipe(14486, 18422, 14134) -- Cloak of Fire
lib:AddRecipe(14488, 18423, 13864) -- Runecloth Boots
lib:AddRecipe(14489, 18424, 13871) -- Frostweave Pants
lib:AddRecipe(14490, 18434, 14045) -- Cindercloth Pants
lib:AddRecipe(14491, 18438, 13865) -- Runecloth Pants
lib:AddRecipe(14492, 18437, 14108) -- Felcloth Boots
lib:AddRecipe(14493, 18436, 14136) -- Robe of Winter Night
lib:AddRecipe(14494, 18439, 14104) -- Brightcloth Pants
lib:AddRecipe(14495, 18441, 14144) -- Ghostweave Pants
lib:AddRecipe(14496, 18442, 14111) -- Felcloth Hood
lib:AddRecipe(14497, 18440, 14137) -- Mooncloth Leggings
lib:AddRecipe(14498, 18444, 13866) -- Runecloth Headband
lib:AddRecipe(14499, 18445, 14155) -- Mooncloth Bag
lib:AddRecipe(14500, 18446, 14128) -- Wizardweave Robe
lib:AddRecipe(14501, 18447, 14138) -- Mooncloth Vest
lib:AddRecipe(14504, 18449, 13867) -- Runecloth Shoulders
lib:AddRecipe(14505, 18450, 14130) -- Wizardweave Turban
lib:AddRecipe(14506, 18451, 14106) -- Felcloth Robe
lib:AddRecipe(14507, 18448, 14139) -- Mooncloth Shoulders
lib:AddRecipe(14508, 18453, 14112) -- Felcloth Shoulders
lib:AddRecipe(14509, 18452, 14140) -- Mooncloth Circlet
lib:AddRecipe(14510, 18455, 14156) -- Bottomless Bag
lib:AddRecipe(14511, 18454, 14146) -- Gloves of Spell Mastery
lib:AddRecipe(14512, 18456, 14154) -- Truefaith Vestments
lib:AddRecipe(14513, 18457, 14152) -- Robe of the Archmage
lib:AddRecipe(14514, 18458, 14153) -- Robe of the Void
lib:AddRecipe(14526, 18560, 14342) -- Mooncloth
lib:AddRecipe(14627, 3869, 4332) -- Bright Yellow Shirt
lib:AddRecipe(14630, 3857, 4322) -- Enchanter's Cowl
lib:AddRecipe(17017, 20848, 16980) -- Flarecore Mantle
lib:AddRecipe(17018, 20849, 16979) -- Flarecore Gloves
lib:AddRecipe(17724, 21945, 17723) -- Green Holiday Shirt
lib:AddRecipe(18265, 22759, 18263) -- Flarecore Wraps
lib:AddRecipe(18414, 22866, 18405) -- Belt of the Archmage
lib:AddRecipe(18415, 22867, 18407) -- Felcloth Gloves
lib:AddRecipe(18416, 22868, 18408) -- Inferno Gloves
lib:AddRecipe(18417, 22869, 18409) -- Mooncloth Gloves
lib:AddRecipe(18418, 22870, 18413) -- Cloak of Warding
lib:AddRecipe(18487, 22902, 18486) -- Mooncloth Robe
lib:AddRecipe(19215, 23662, 19047) -- Wisdom of the Timbermaw
lib:AddRecipe(19216, 23664, 19056) -- Argent Boots
lib:AddRecipe(19217, 23665, 19059) -- Argent Shoulders
lib:AddRecipe(19218, 23663, 19050) -- Mantle of the Timbermaw
lib:AddRecipe(19219, 23666, 19156) -- Flarecore Robe
lib:AddRecipe(19220, 23667, 19165) -- Flarecore Leggings
lib:AddRecipe(19764, 24091, 19682) -- Bloodvine Vest
lib:AddRecipe(19765, 24092, 19683) -- Bloodvine Leggings
lib:AddRecipe(19766, 24093, 19684) -- Bloodvine Boots
lib:AddRecipe(20546, 24901, 20538) -- Runed Stygian Leggings
lib:AddRecipe(20547, 24903, 20537) -- Runed Stygian Boots
lib:AddRecipe(20548, 24902, 20539) -- Runed Stygian Belt
lib:AddRecipe(21358, 26085, 21340) -- Soul Pouch
lib:AddRecipe(21369, 26086, 21341) -- Felcloth Bag
lib:AddRecipe(21371, 26087, 21342) -- Core Felcloth Bag
lib:AddRecipe(21722, 26403, 21154) -- Festival Dress
lib:AddRecipe(21723, 26407, 21542) -- Festive Red Pant Suit
lib:AddRecipe(21892, 26747, 21842) -- Bolt of Imbued Netherweave
lib:AddRecipe(21893, 26749, 21843) -- Imbued Netherweave Bag
lib:AddRecipe(21894, 26750, 21844) -- Bolt of Soulcloth
lib:AddRecipe(21895, 26751, 21845) -- Primal Mooncloth
lib:AddRecipe(21896, 26773, 21854) -- Netherweave Robe
lib:AddRecipe(21897, 26774, 21855) -- Netherweave Tunic
lib:AddRecipe(21898, 26775, 21859) -- Imbued Netherweave Pants
lib:AddRecipe(21899, 26776, 21860) -- Imbued Netherweave Boots
lib:AddRecipe(21900, 26777, 21861) -- Imbued Netherweave Robe
lib:AddRecipe(21901, 26778, 21862) -- Imbued Netherweave Tunic
lib:AddRecipe(21902, 26779, 21863) -- Soulcloth Gloves
lib:AddRecipe(21903, 26780, 21864) -- Soulcloth Shoulders
lib:AddRecipe(21904, 26781, 21865) -- Soulcloth Vest
lib:AddRecipe(21905, 26782, 21866) -- Arcanoweave Bracers
lib:AddRecipe(21906, 26783, 21867) -- Arcanoweave Boots
lib:AddRecipe(21907, 26784, 21868) -- Arcanoweave Robe
lib:AddRecipe(21908, 26752, 21846) -- Spellfire Belt
lib:AddRecipe(21909, 26753, 21847) -- Spellfire Gloves
lib:AddRecipe(21910, 26754, 21848) -- Spellfire Robe
lib:AddRecipe(21911, 26755, 21858) -- Spellfire Bag
lib:AddRecipe(21912, 26756, 21869) -- Frozen Shadoweave Shoulders
lib:AddRecipe(21913, 26758, 21871) -- Frozen Shadoweave Robe
lib:AddRecipe(21914, 26757, 21870) -- Frozen Shadoweave Boots
lib:AddRecipe(21915, 26759, 21872) -- Ebon Shadowbag
lib:AddRecipe(21916, 26760, 21873) -- Primal Mooncloth Belt
lib:AddRecipe(21917, 26762, 21875) -- Primal Mooncloth Robe
lib:AddRecipe(21918, 26761, 21874) -- Primal Mooncloth Shoulders
lib:AddRecipe(21919, 26763, 21876) -- Primal Mooncloth Bag
lib:AddRecipe(21924, 18406, 13858) -- Runecloth Robe
lib:AddRecipe(22307, 27658, 22246) -- Enchanted Mageweave Pouch
lib:AddRecipe(22308, 27659, 22248) -- Enchanted Runecloth Bag
lib:AddRecipe(22309, 27660, 22249) -- Big Bag of Enchantment
lib:AddRecipe(22310, 27724, 22251) -- Cenarion Herb Bag
lib:AddRecipe(22312, 27725, 22252) -- Satchel of Cenarius
lib:AddRecipe(22683, 28210, 22660) -- Gaea's Embrace
lib:AddRecipe(22684, 28205, 22654) -- Glacial Gloves
lib:AddRecipe(22685, 28208, 22658) -- Glacial Cloak
lib:AddRecipe(22686, 28207, 22652) -- Glacial Vest
lib:AddRecipe(22687, 28209, 22655) -- Glacial Wrists
lib:AddRecipe(22772, 28482, 22758) -- Sylvan Shoulders
lib:AddRecipe(22773, 28481, 22757) -- Sylvan Crown
lib:AddRecipe(22774, 28480, 22756) -- Sylvan Vest
lib:AddRecipe(24292, 31430, 24273) -- Mystic Spellthread
lib:AddRecipe(24293, 31431, 24275) -- Silver Spellthread
lib:AddRecipe(24294, 31432, 24274) -- Runic Spellthread
lib:AddRecipe(24295, 31433, 24276) -- Golden Spellthread
lib:AddRecipe(24296, 31434, 24249) -- Unyielding Bracers
lib:AddRecipe(24297, 31435, 24250) -- Bracers of Havok
lib:AddRecipe(24298, 31437, 24251) -- Blackstrike Bracers
lib:AddRecipe(24299, 31438, 24252) -- Cloak of the Black Void
lib:AddRecipe(24300, 31440, 24253) -- Cloak of Eternity
lib:AddRecipe(24301, 31441, 24254) -- White Remedy Cape
lib:AddRecipe(24302, 31442, 24255) -- Unyielding Girdle
lib:AddRecipe(24303, 31443, 24256) -- Girdle of Ruination
lib:AddRecipe(24304, 31444, 24257) -- Black Belt of Knowledge
lib:AddRecipe(24305, 31448, 24258) -- Resolute Cape
lib:AddRecipe(24306, 31449, 24259) -- Vengeance Wrap
lib:AddRecipe(24307, 31450, 24260) -- Manaweave Cloak
lib:AddRecipe(24308, 31451, 24261) -- Whitemend Pants
lib:AddRecipe(24309, 31452, 24262) -- Spellstrike Pants
lib:AddRecipe(24310, 31453, 24263) -- Battlecast Pants
lib:AddRecipe(24311, 31454, 24264) -- Whitemend Hood
lib:AddRecipe(24312, 31455, 24266) -- Spellstrike Hood
lib:AddRecipe(24313, 31456, 24267) -- Battlecast Hood
lib:AddRecipe(24314, 31459, 24270) -- Bag of Jewels
lib:AddRecipe(24315, 31461, 24269) -- Heavy Netherweave Net
lib:AddRecipe(24316, 31373, 24271) -- Spellcloth
lib:AddRecipe(29120, 18456, 14154) -- Truefaith Vestments
lib:AddRecipe(30280, 36315, 30038) -- Belt of Blasting
lib:AddRecipe(30281, 36316, 30036) -- Belt of the Long Road
lib:AddRecipe(30282, 36317, 30037) -- Boots of Blasting
lib:AddRecipe(30283, 36318, 30035) -- Boots of the Long Road
lib:AddRecipe(30469, 36665, 30459) -- Netherflame Robe
lib:AddRecipe(30470, 36667, 30460) -- Netherflame Belt
lib:AddRecipe(30471, 36668, 30461) -- Netherflame Boots
lib:AddRecipe(30472, 36669, 30465) -- Lifeblood Leggings
lib:AddRecipe(30473, 36670, 30463) -- Lifeblood Belt
lib:AddRecipe(30474, 36672, 30464) -- Lifeblood Bracers
lib:AddRecipe(30483, 36686, 24272) -- Shadowcloth
lib:AddRecipe(30833, 37873, 30831) -- Cloak of Arcane Evasion
lib:AddRecipe(30842, 37882, 30837) -- Flameheart Bracers
lib:AddRecipe(30843, 37883, 30838) -- Flameheart Gloves
lib:AddRecipe(30844, 37884, 30839) -- Flameheart Vest
lib:AddRecipe(32437, 40020, 32391) -- Soulguard Slippers
lib:AddRecipe(32438, 40021, 32392) -- Soulguard Bracers
lib:AddRecipe(32439, 40023, 32389) -- Soulguard Leggings
lib:AddRecipe(32440, 40024, 32390) -- Soulguard Girdle
lib:AddRecipe(32447, 40060, 32420) -- Night's End
lib:AddRecipe(32752, 41207, 32584) -- Swiftheal Wraps
lib:AddRecipe(32753, 41208, 32585) -- Swiftheal Mantle
lib:AddRecipe(32754, 41205, 32586) -- Bracers of Nimble Thought
lib:AddRecipe(32755, 41206, 32587) -- Mantle of Nimble Thought
lib:AddRecipe(34261, 44950, 34087) -- Green Winter Clothes
lib:AddRecipe(34319, 44958, 34085) -- Red Winter Clothes
lib:AddRecipe(35204, 46128, 34366) -- Sunfire Handwraps
lib:AddRecipe(35205, 46129, 34367) -- Hands of Eternal Light
lib:AddRecipe(35206, 46130, 34364) -- Sunfire Robe
lib:AddRecipe(35207, 46131, 34365) -- Robe of Eternal Light
lib:AddRecipe(35308, 31434, 24249) -- Unyielding Bracers
lib:AddRecipe(35309, 31442, 24255) -- Unyielding Girdle
lib:AddRecipe(35518, 41205, 32586) -- Bracers of Nimble Thought
lib:AddRecipe(35522, 41206, 32587) -- Mantle of Nimble Thought
lib:AddRecipe(35525, 41208, 32585) -- Swiftheal Mantle
lib:AddRecipe(35526, 41207, 32584) -- Swiftheal Wraps
lib:AddRecipe(35544, 46129, 34367) -- Hands of Eternal Light
lib:AddRecipe(35548, 46131, 34365) -- Robe of Eternal Light
lib:AddRecipe(35551, 46128, 34366) -- Sunfire Handwraps
lib:AddRecipe(35552, 46130, 34364) -- Sunfire Robe
lib:AddRecipe(37915, 49677, 6836) -- Dress Shoes
lib:AddRecipe(38229, 50194, 38225) -- Mycah's Botanical Bag
lib:AddRecipe(38327, 50644, 38277) -- Haliscan Jacket
lib:AddRecipe(38328, 50647, 38278) -- Haliscan Pantaloons

--------------------------------------------------------------------------------
--  End Burning Crusade Classic Data                                          --
end                                                                           --
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Wrath of the Lich King Data (don't forget to increase MINOR when updated)  --
if lib.IsWOTLKC then                                                          --
--------------------------------------------------------------------------------

-- Alchemy
lib:AddRecipe(2553, 3230, 2457) -- Elixir of Minor Agility
lib:AddRecipe(2555, 2335, 2459) -- Swiftness Potion
lib:AddRecipe(2556, 2336, 2460) -- Elixir of Tongues
lib:AddRecipe(3393, 3172, 3384) -- Minor Magic Resistance Potion
lib:AddRecipe(3394, 3174, 3386) -- Potion of Curing
lib:AddRecipe(3395, 3175, 3387) -- Limited Invulnerability Potion
lib:AddRecipe(3396, 2333, 3390) -- Elixir of Lesser Agility
lib:AddRecipe(3830, 3450, 3825) -- Elixir of Fortitude
lib:AddRecipe(3831, 3451, 3826) -- Major Troll's Blood Elixir
lib:AddRecipe(3832, 3453, 3828) -- Elixir of Detect Lesser Invisibility
lib:AddRecipe(4597, 4508, 4596) -- Discolored Healing Potion
lib:AddRecipe(4624, 4942, 4623) -- Lesser Stoneshield Potion
lib:AddRecipe(5640, 6617, 5631) -- Rage Potion
lib:AddRecipe(5642, 6624, 5634) -- Free Action Potion
lib:AddRecipe(5643, 6618, 5633) -- Great Rage Potion
lib:AddRecipe(6053, 7255, 6051) -- Holy Protection Potion
lib:AddRecipe(6054, 7256, 6048) -- Shadow Protection Potion
lib:AddRecipe(6055, 7257, 6049) -- Fire Protection Potion
lib:AddRecipe(6056, 7258, 6050) -- Frost Protection Potion
lib:AddRecipe(6057, 7259, 6052) -- Nature Protection Potion
lib:AddRecipe(6068, 3449, 3824) -- Shadow Oil
lib:AddRecipe(6211, 3188, 3391) -- Elixir of Ogre's Strength
lib:AddRecipe(6663, 8240, 6662) -- Elixir of Giant Growth
lib:AddRecipe(9293, 11453, 9036) -- Magic Resistance Potion
lib:AddRecipe(9294, 11458, 9144) -- Wildvine Potion
lib:AddRecipe(9295, 11464, 9172) -- Invisibility Potion
lib:AddRecipe(9296, 11466, 9088) -- Gift of Arthas
lib:AddRecipe(9297, 11468, 9197) -- Elixir of Dream Vision
lib:AddRecipe(9298, 11472, 9206) -- Elixir of Giants
lib:AddRecipe(9300, 11477, 9224) -- Elixir of Demonslaying
lib:AddRecipe(9301, 11476, 9264) -- Elixir of Shadow Power
lib:AddRecipe(9302, 11473, 9210) -- Ghost Dye
lib:AddRecipe(9303, 11459, 9149) -- Philosopher's Stone
lib:AddRecipe(9304, 11479, 3577) -- Transmute: Iron to Gold
lib:AddRecipe(9305, 11480, 6037) -- Transmute: Mithril to Truesilver
lib:AddRecipe(10644, 11456, 9061) -- Goblin Rocket Fuel
lib:AddRecipe(12958, 17187, 12360) -- Transmute: Arcanite
lib:AddRecipe(13476, 17552, 13442) -- Mighty Rage Potion
lib:AddRecipe(13477, 17553, 13443) -- Superior Mana Potion
lib:AddRecipe(13478, 17554, 13445) -- Elixir of Superior Defense
lib:AddRecipe(13479, 17555, 13447) -- Elixir of the Sages
lib:AddRecipe(13480, 17556, 13446) -- Major Healing Potion
lib:AddRecipe(13481, 17557, 13453) -- Elixir of Brute Force
lib:AddRecipe(13482, 17559, 7078) -- Transmute: Air to Fire
lib:AddRecipe(13483, 17560, 7076) -- Transmute: Fire to Earth
lib:AddRecipe(13484, 17561, 7080) -- Transmute: Earth to Water
lib:AddRecipe(13485, 17562, 7082) -- Transmute: Water to Air
lib:AddRecipe(13486, 17563, 7080) -- Transmute: Undeath to Water
lib:AddRecipe(13487, 17564, 12808) -- Transmute: Water to Undeath
lib:AddRecipe(13488, 17565, 7076) -- Transmute: Life to Earth
lib:AddRecipe(13489, 17566, 12803) -- Transmute: Earth to Life
lib:AddRecipe(13490, 17570, 13455) -- Greater Stoneshield Potion
lib:AddRecipe(13491, 17571, 13452) -- Elixir of the Mongoose
lib:AddRecipe(13492, 17572, 13462) -- Purification Potion
lib:AddRecipe(13493, 17573, 13454) -- Greater Arcane Elixir
lib:AddRecipe(13494, 17574, 13457) -- Greater Fire Protection Potion
lib:AddRecipe(13495, 17575, 13456) -- Greater Frost Protection Potion
lib:AddRecipe(13496, 17576, 13458) -- Greater Nature Protection Potion
lib:AddRecipe(13497, 17577, 13461) -- Greater Arcane Protection Potion
lib:AddRecipe(13499, 17578, 13459) -- Greater Shadow Protection Potion
lib:AddRecipe(13500, 17579, 13460) -- Greater Holy Protection Potion
lib:AddRecipe(13501, 17580, 13444) -- Major Mana Potion
lib:AddRecipe(13517, 17632, 13503) -- Alchemist's Stone
lib:AddRecipe(13518, 17634, 13506) -- Potion of Petrification
lib:AddRecipe(13519, 17635, 13510) -- Flask of the Titans
lib:AddRecipe(13520, 17636, 13511) -- Flask of Distilled Wisdom
lib:AddRecipe(13521, 17637, 13512) -- Flask of Supreme Power
lib:AddRecipe(13522, 17638, 13513) -- Flask of Chromatic Resistance
lib:AddRecipe(14634, 3454, 3829) -- Frost Oil
lib:AddRecipe(17709, 21923, 17708) -- Elixir of Frost Power
lib:AddRecipe(18257, 22732, 18253) -- Major Rejuvenation Potion
lib:AddRecipe(20011, 24365, 20007) -- Mageblood Elixir
lib:AddRecipe(20012, 24366, 20002) -- Greater Dreamless Sleep Potion
lib:AddRecipe(20013, 24367, 20008) -- Living Action Potion
lib:AddRecipe(20014, 24368, 20004) -- Mighty Troll's Blood Elixir
lib:AddRecipe(20761, 25146, 7068) -- Transmute: Elemental Fire
lib:AddRecipe(21547, 26277, 21546) -- Elixir of Greater Firepower
lib:AddRecipe(22900, 28543, 22823) -- Elixir of Camouflage
lib:AddRecipe(22901, 28546, 22826) -- Sneaking Potion
lib:AddRecipe(22902, 28549, 22827) -- Elixir of Major Frost Power
lib:AddRecipe(22903, 28550, 22828) -- Insane Strength Potion
lib:AddRecipe(22904, 28552, 22830) -- Elixir of the Searching Eye
lib:AddRecipe(22905, 28553, 22831) -- Elixir of Major Agility
lib:AddRecipe(22906, 28554, 22871) -- Shrouding Potion
lib:AddRecipe(22907, 28555, 22832) -- Super Mana Potion
lib:AddRecipe(22908, 28556, 22833) -- Elixir of Major Firepower
lib:AddRecipe(22909, 28557, 22834) -- Elixir of Major Defense
lib:AddRecipe(22910, 28558, 22835) -- Elixir of Major Shadow Power
lib:AddRecipe(22911, 28562, 22836) -- Major Dreamless Sleep Potion
lib:AddRecipe(22912, 28563, 22837) -- Heroic Potion
lib:AddRecipe(22913, 28564, 22838) -- Haste Potion
lib:AddRecipe(22914, 28565, 22839) -- Destruction Potion
lib:AddRecipe(22915, 28566, 21884) -- Transmute: Primal Air to Fire
lib:AddRecipe(22916, 28567, 21885) -- Transmute: Primal Earth to Water
lib:AddRecipe(22917, 28568, 22452) -- Transmute: Primal Fire to Earth
lib:AddRecipe(22918, 28569, 22451) -- Transmute: Primal Water to Air
lib:AddRecipe(22919, 28570, 22840) -- Elixir of Major Mageblood
lib:AddRecipe(22920, 28571, 22841) -- Major Fire Protection Potion
lib:AddRecipe(22921, 28572, 22842) -- Major Frost Protection Potion
lib:AddRecipe(22922, 28573, 22844) -- Major Nature Protection Potion
lib:AddRecipe(22923, 28575, 22845) -- Major Arcane Protection Potion
lib:AddRecipe(22924, 28576, 22846) -- Major Shadow Protection Potion
lib:AddRecipe(22925, 28577, 22847) -- Major Holy Protection Potion
lib:AddRecipe(22926, 28578, 22848) -- Elixir of Empowerment
lib:AddRecipe(22927, 28579, 22849) -- Ironshield Potion
lib:AddRecipe(23574, 29688, 23571) -- Transmute: Primal Might
lib:AddRecipe(24001, 28553, 22831) -- Elixir of Major Agility
lib:AddRecipe(25869, 32765, 25867) -- Transmute: Earthstorm Diamond
lib:AddRecipe(25870, 32766, 25868) -- Transmute: Skyfire Diamond
lib:AddRecipe(29232, 32766, 25868) -- Transmute: Skyfire Diamond
lib:AddRecipe(30443, 28568, 22452) -- Transmute: Primal Fire to Earth
lib:AddRecipe(31354, 17635, 13510) -- Flask of the Titans
lib:AddRecipe(31355, 17637, 13512) -- Flask of Supreme Power
lib:AddRecipe(31356, 17636, 13511) -- Flask of Distilled Wisdom
lib:AddRecipe(31357, 17638, 13513) -- Flask of Chromatic Resistance
lib:AddRecipe(31680, 38960, 31679) -- Fel Strength Elixir
lib:AddRecipe(31681, 38962, 31676) -- Fel Regeneration Potion
lib:AddRecipe(31682, 38961, 31677) -- Fel Mana Potion
lib:AddRecipe(32070, 39637, 32063) -- Earthen Elixir
lib:AddRecipe(32071, 39639, 32068) -- Elixir of Ironskin
lib:AddRecipe(33209, 42736, 33208) -- Flask of Chromatic Wonder
lib:AddRecipe(34481, 45061, 34440) -- Mad Alchemist's Potion
lib:AddRecipe(35294, 28578, 22848) -- Elixir of Empowerment
lib:AddRecipe(35295, 28564, 22838) -- Haste Potion
lib:AddRecipe(35752, 47046, 35748) -- Guardian's Alchemist Stone
lib:AddRecipe(35753, 47048, 35749) -- Sorcerer's Alchemist Stone
lib:AddRecipe(35754, 47049, 35750) -- Redeemer's Alchemist Stone
lib:AddRecipe(35755, 47050, 35751) -- Assassin's Alchemist Stone
lib:AddRecipe(36841, 17557, 13453) -- Elixir of Brute Force
lib:AddRecipe(36842, 17557, 13453) -- Elixir of Brute Force
lib:AddRecipe(36843, 17557, 13453) -- Elixir of Brute Force
lib:AddRecipe(36844, 17557, 13453) -- Elixir of Brute Force
lib:AddRecipe(44564, 53936, 40213) -- Mighty Arcane Protection Potion
lib:AddRecipe(44565, 53939, 40214) -- Mighty Fire Protection Potion
lib:AddRecipe(44566, 53937, 40215) -- Mighty Frost Protection Potion
lib:AddRecipe(44567, 53942, 40216) -- Mighty Nature Protection Potion
lib:AddRecipe(44568, 53938, 40217) -- Mighty Shadow Protection Potion
lib:AddRecipe(47507, 67025, 47499) -- Flask of the North
-- Blacksmithing
lib:AddRecipe(2881, 2667, 2864) -- Runed Copper Breastplate
lib:AddRecipe(2882, 3330, 3481) -- Silvered Bronze Shoulders
lib:AddRecipe(2883, 3295, 3490) -- Deadly Bronze Poniard
lib:AddRecipe(3608, 3297, 3492) -- Mighty Iron Hammer
lib:AddRecipe(3609, 3321, 3471) -- Copper Chain Vest
lib:AddRecipe(3610, 3325, 3474) -- Gemmed Copper Gauntlets
lib:AddRecipe(3611, 3334, 3484) -- Green Iron Boots
lib:AddRecipe(3612, 3336, 3485) -- Green Iron Gauntlets
lib:AddRecipe(3866, 3493, 3850) -- Jade Serpentblade
lib:AddRecipe(3867, 3495, 3852) -- Golden Iron Destroyer
lib:AddRecipe(3868, 3497, 3854) -- Frost Tiger Blade
lib:AddRecipe(3869, 3500, 3856) -- Shadow Crescent Axe
lib:AddRecipe(3870, 3504, 3840) -- Green Iron Shoulders
lib:AddRecipe(3871, 3505, 3841) -- Golden Scale Shoulders
lib:AddRecipe(3872, 3507, 3843) -- Golden Scale Leggings
lib:AddRecipe(3873, 3511, 3845) -- Golden Scale Cuirass
lib:AddRecipe(3874, 3513, 3846) -- Polished Steel Boots
lib:AddRecipe(3875, 3515, 3847) -- Golden Scale Boots
lib:AddRecipe(5543, 6518, 5541) -- Iridescent Hammer
lib:AddRecipe(5577, 2671, 2867) -- Rough Bronze Bracers
lib:AddRecipe(5578, 2673, 2869) -- Silvered Bronze Breastplate
lib:AddRecipe(6044, 7221, 6042) -- Iron Shield Spike
lib:AddRecipe(6045, 7222, 6043) -- Iron Counterweight
lib:AddRecipe(6046, 7224, 6041) -- Steel Weapon Chain
lib:AddRecipe(6047, 3503, 3837) -- Golden Scale Coif
lib:AddRecipe(6734, 8366, 6730) -- Ironforge Chain
lib:AddRecipe(6735, 8367, 6731) -- Ironforge Breastplate
lib:AddRecipe(6736, 8368, 6733) -- Ironforge Gauntlets
lib:AddRecipe(7975, 9933, 7921) -- Heavy Mithril Pants
lib:AddRecipe(7976, 9939, 7967) -- Mithril Shield Spike
lib:AddRecipe(7977, 9942, 7925) -- Mithril Scale Gloves
lib:AddRecipe(7978, 9811, 7913) -- Barbaric Iron Shoulders
lib:AddRecipe(7979, 9813, 7914) -- Barbaric Iron Breastplate
lib:AddRecipe(7980, 9814, 7915) -- Barbaric Iron Helm
lib:AddRecipe(7981, 9818, 7916) -- Barbaric Iron Boots
lib:AddRecipe(7982, 9820, 7917) -- Barbaric Iron Gloves
lib:AddRecipe(7983, 9945, 7926) -- Ornate Mithril Pants
lib:AddRecipe(7984, 9950, 7927) -- Ornate Mithril Gloves
lib:AddRecipe(7985, 9952, 7928) -- Ornate Mithril Shoulder
lib:AddRecipe(7986, 9972, 7935) -- Ornate Mithril Breastplate
lib:AddRecipe(7987, 9980, 7937) -- Ornate Mithril Helm
lib:AddRecipe(7988, 9979, 7936) -- Ornate Mithril Boots
lib:AddRecipe(7989, 9964, 7969) -- Mithril Spurs
lib:AddRecipe(7990, 9970, 7934) -- Heavy Mithril Helm
lib:AddRecipe(7991, 9966, 7932) -- Mithril Scale Shoulders
lib:AddRecipe(7992, 9995, 7942) -- Blue Glittering Axe
lib:AddRecipe(7993, 10005, 7944) -- Dazzling Mithril Rapier
lib:AddRecipe(7994, 9957, 7929) -- Orcish War Leggings
lib:AddRecipe(7995, 9937, 7924) -- Mithril Scale Bracers
lib:AddRecipe(8028, 10009, 7946) -- Runed Mithril Hammer
lib:AddRecipe(8029, 9997, 7943) -- Wicked Mithril Blade
lib:AddRecipe(8030, 10013, 7947) -- Ebon Shiv
lib:AddRecipe(9367, 11643, 9366) -- Golden Scale Gauntlets
lib:AddRecipe(10424, 12259, 10423) -- Silvered Bronze Leggings
lib:AddRecipe(10713, 11454, 9060) -- Inlaid Mithril Cylinder
lib:AddRecipe(10858, 3494, 3851) -- Solid Iron Maul
lib:AddRecipe(11610, 15292, 11608) -- Dark Iron Pulverizer
lib:AddRecipe(11611, 15294, 11607) -- Dark Iron Sunderer
lib:AddRecipe(11612, 15296, 11604) -- Dark Iron Plate
lib:AddRecipe(11614, 15293, 11606) -- Dark Iron Mail
lib:AddRecipe(11615, 15295, 11605) -- Dark Iron Shoulders
lib:AddRecipe(12162, 3492, 3849) -- Hardened Iron Shortsword
lib:AddRecipe(12163, 3496, 3853) -- Moonsteel Broadsword
lib:AddRecipe(12164, 3498, 3855) -- Massive Iron Axe
lib:AddRecipe(12261, 15973, 12260) -- Searing Golden Blade
lib:AddRecipe(12682, 16642, 12405) -- Thorium Armor
lib:AddRecipe(12683, 16643, 12406) -- Thorium Belt
lib:AddRecipe(12684, 16644, 12408) -- Thorium Bracers
lib:AddRecipe(12685, 16645, 12416) -- Radiant Belt
lib:AddRecipe(12687, 16646, 12428) -- Imperial Plate Shoulders
lib:AddRecipe(12688, 16647, 12424) -- Imperial Plate Belt
lib:AddRecipe(12689, 16648, 12415) -- Radiant Breastplate
lib:AddRecipe(12690, 16649, 12425) -- Imperial Plate Bracers
lib:AddRecipe(12691, 16650, 12624) -- Wildthorn Mail
lib:AddRecipe(12692, 16651, 12645) -- Thorium Shield Spike
lib:AddRecipe(12693, 16652, 12409) -- Thorium Boots
lib:AddRecipe(12694, 16653, 12410) -- Thorium Helm
lib:AddRecipe(12695, 16654, 12418) -- Radiant Gloves
lib:AddRecipe(12696, 16667, 12628) -- Demon Forged Breastplate
lib:AddRecipe(12697, 16656, 12419) -- Radiant Boots
lib:AddRecipe(12698, 16660, 12625) -- Dawnbringer Shoulders
lib:AddRecipe(12699, 16655, 12631) -- Fiery Plate Gauntlets
lib:AddRecipe(12700, 16657, 12426) -- Imperial Plate Boots
lib:AddRecipe(12701, 16658, 12427) -- Imperial Plate Helm
lib:AddRecipe(12702, 16659, 12417) -- Radiant Circlet
lib:AddRecipe(12703, 16661, 12632) -- Storm Gauntlets
lib:AddRecipe(12704, 16662, 12414) -- Thorium Leggings
lib:AddRecipe(12705, 16663, 12422) -- Imperial Plate Chest
lib:AddRecipe(12706, 16664, 12610) -- Runic Plate Shoulders
lib:AddRecipe(12707, 16665, 12611) -- Runic Plate Boots
lib:AddRecipe(12711, 16724, 12633) -- Whitesoul Helm
lib:AddRecipe(12713, 16725, 12420) -- Radiant Leggings
lib:AddRecipe(12714, 16726, 12612) -- Runic Plate Helm
lib:AddRecipe(12715, 16730, 12429) -- Imperial Plate Leggings
lib:AddRecipe(12716, 16728, 12636) -- Helm of the Great Chief
lib:AddRecipe(12717, 16729, 12640) -- Lionheart Helm
lib:AddRecipe(12718, 16731, 12613) -- Runic Breastplate
lib:AddRecipe(12719, 16732, 12614) -- Runic Plate Leggings
lib:AddRecipe(12720, 16741, 12639) -- Stronghold Gauntlets
lib:AddRecipe(12725, 16742, 12620) -- Enchanted Thorium Helm
lib:AddRecipe(12726, 16744, 12619) -- Enchanted Thorium Leggings
lib:AddRecipe(12727, 16745, 12618) -- Enchanted Thorium Breastplate
lib:AddRecipe(12728, 16746, 12641) -- Invulnerable Mail
lib:AddRecipe(12816, 16960, 12764) -- Thorium Greatsword
lib:AddRecipe(12817, 16965, 12769) -- Bleakwood Hew
lib:AddRecipe(12818, 16967, 12772) -- Inlaid Thorium Hammer
lib:AddRecipe(12819, 16969, 12773) -- Ornate Thorium Handaxe
lib:AddRecipe(12821, 16970, 12774) -- Dawn's Edge
lib:AddRecipe(12823, 16971, 12775) -- Huge Thorium Battleaxe
lib:AddRecipe(12824, 16973, 12776) -- Enchanted Battlehammer
lib:AddRecipe(12825, 16978, 12777) -- Blazing Rapier
lib:AddRecipe(12826, 16980, 12779) -- Rune Edge
lib:AddRecipe(12827, 16983, 12781) -- Serenity
lib:AddRecipe(12828, 16984, 12792) -- Volcanic Hammer
lib:AddRecipe(12830, 16985, 12782) -- Corruption
lib:AddRecipe(12831, 16986, 12795) -- Blood Talon
lib:AddRecipe(12832, 16987, 12802) -- Darkspear
lib:AddRecipe(12833, 16988, 12796) -- Hammer of the Titans
lib:AddRecipe(12834, 16990, 12790) -- Arcanite Champion
lib:AddRecipe(12835, 16991, 12798) -- Annihilator
lib:AddRecipe(12836, 16992, 12797) -- Frostguard
lib:AddRecipe(12837, 16993, 12794) -- Masterwork Stormhammer
lib:AddRecipe(12838, 16994, 12784) -- Arcanite Reaper
lib:AddRecipe(12839, 16995, 12783) -- Heartseeker
lib:AddRecipe(17049, 20872, 16989) -- Fiery Chain Girdle
lib:AddRecipe(17051, 20874, 17014) -- Dark Iron Bracers
lib:AddRecipe(17052, 20876, 17013) -- Dark Iron Leggings
lib:AddRecipe(17053, 20873, 16988) -- Fiery Chain Shoulders
lib:AddRecipe(17059, 20890, 17015) -- Dark Iron Reaver
lib:AddRecipe(17060, 20897, 17016) -- Dark Iron Destroyer
lib:AddRecipe(17706, 21913, 17704) -- Edge of Winter
lib:AddRecipe(18264, 22757, 18262) -- Elemental Sharpening Stone
lib:AddRecipe(18592, 21161, 17193) -- Sulfuron Hammer
lib:AddRecipe(19202, 23628, 19043) -- Heavy Timbermaw Belt
lib:AddRecipe(19203, 23632, 19051) -- Girdle of the Dawn
lib:AddRecipe(19204, 23629, 19048) -- Heavy Timbermaw Boots
lib:AddRecipe(19205, 23633, 19057) -- Gloves of the Dawn
lib:AddRecipe(19206, 23636, 19148) -- Dark Iron Helm
lib:AddRecipe(19207, 23637, 19164) -- Dark Iron Gauntlets
lib:AddRecipe(19208, 23638, 19166) -- Black Amnesty
lib:AddRecipe(19209, 23639, 19167) -- Blackfury
lib:AddRecipe(19210, 23650, 19170) -- Ebon Hand
lib:AddRecipe(19211, 23652, 19168) -- Blackguard
lib:AddRecipe(19212, 23653, 19169) -- Nightfall
lib:AddRecipe(19776, 24136, 19690) -- Bloodsoul Breastplate
lib:AddRecipe(19777, 24137, 19691) -- Bloodsoul Shoulders
lib:AddRecipe(19778, 24138, 19692) -- Bloodsoul Gauntlets
lib:AddRecipe(19779, 24139, 19693) -- Darksoul Breastplate
lib:AddRecipe(19780, 24140, 19694) -- Darksoul Leggings
lib:AddRecipe(19781, 24141, 19695) -- Darksoul Shoulders
lib:AddRecipe(20040, 24399, 20039) -- Dark Iron Boots
lib:AddRecipe(20553, 24912, 20549) -- Darkrune Gauntlets
lib:AddRecipe(20554, 24914, 20550) -- Darkrune Breastplate
lib:AddRecipe(20555, 24913, 20551) -- Darkrune Helm
lib:AddRecipe(22209, 27585, 22197) -- Heavy Obsidian Belt
lib:AddRecipe(22214, 27588, 22195) -- Light Obsidian Belt
lib:AddRecipe(22219, 27586, 22198) -- Jagged Obsidian Shield
lib:AddRecipe(22220, 27589, 22194) -- Black Grasp of the Destroyer
lib:AddRecipe(22221, 27590, 22191) -- Obsidian Mail Tunic
lib:AddRecipe(22222, 27587, 22196) -- Thick Obsidian Breastplate
lib:AddRecipe(22388, 27829, 22385) -- Titanic Leggings
lib:AddRecipe(22389, 27832, 22383) -- Sageblade
lib:AddRecipe(22390, 27830, 22384) -- Persuader
lib:AddRecipe(22703, 28242, 22669) -- Icebane Breastplate
lib:AddRecipe(22704, 28243, 22670) -- Icebane Gauntlets
lib:AddRecipe(22705, 28244, 22671) -- Icebane Bracers
lib:AddRecipe(22766, 28461, 22762) -- Ironvine Breastplate
lib:AddRecipe(22767, 28462, 22763) -- Ironvine Gloves
lib:AddRecipe(22768, 28463, 22764) -- Ironvine Belt
lib:AddRecipe(23590, 29566, 23502) -- Adamantite Maul
lib:AddRecipe(23591, 29568, 23503) -- Adamantite Cleaver
lib:AddRecipe(23592, 29569, 23504) -- Adamantite Dagger
lib:AddRecipe(23593, 29571, 23505) -- Adamantite Rapier
lib:AddRecipe(23594, 29603, 23506) -- Adamantite Plate Bracers
lib:AddRecipe(23595, 29605, 23508) -- Adamantite Plate Gloves
lib:AddRecipe(23596, 29606, 23507) -- Adamantite Breastplate
lib:AddRecipe(23597, 29608, 23510) -- Enchanted Adamantite Belt
lib:AddRecipe(23598, 29611, 23511) -- Enchanted Adamantite Boots
lib:AddRecipe(23599, 29610, 23509) -- Enchanted Adamantite Breastplate
lib:AddRecipe(23600, 29613, 23512) -- Enchanted Adamantite Leggings
lib:AddRecipe(23601, 29614, 23515) -- Flamebane Bracers
lib:AddRecipe(23602, 29615, 23516) -- Flamebane Helm
lib:AddRecipe(23603, 29616, 23514) -- Flamebane Gloves
lib:AddRecipe(23604, 29617, 23513) -- Flamebane Breastplate
lib:AddRecipe(23605, 29619, 23517) -- Felsteel Gloves
lib:AddRecipe(23606, 29620, 23518) -- Felsteel Leggings
lib:AddRecipe(23607, 29621, 23519) -- Felsteel Helm
lib:AddRecipe(23608, 29628, 23524) -- Khorium Belt
lib:AddRecipe(23609, 29629, 23523) -- Khorium Pants
lib:AddRecipe(23610, 29630, 23525) -- Khorium Boots
lib:AddRecipe(23611, 29642, 23520) -- Ragesteel Gloves
lib:AddRecipe(23612, 29643, 23521) -- Ragesteel Helm
lib:AddRecipe(23613, 29645, 23522) -- Ragesteel Breastplate
lib:AddRecipe(23615, 29648, 23526) -- Swiftsteel Gloves
lib:AddRecipe(23617, 29649, 23527) -- Earthpeace Breastplate
lib:AddRecipe(23618, 29656, 23529) -- Adamantite Sharpening Stone
lib:AddRecipe(23619, 29657, 23530) -- Felsteel Shield Spike
lib:AddRecipe(23620, 29658, 23531) -- Felfury Gauntlets
lib:AddRecipe(23621, 29622, 23532) -- Gauntlets of the Iron Tower
lib:AddRecipe(23622, 29662, 23533) -- Steelgrip Gauntlets
lib:AddRecipe(23623, 29663, 23534) -- Storm Helm
lib:AddRecipe(23624, 29664, 23535) -- Helm of the Stalwart Defender
lib:AddRecipe(23625, 29668, 23536) -- Oathkeeper's Helm
lib:AddRecipe(23626, 29669, 23537) -- Black Felsteel Bracers
lib:AddRecipe(23627, 29671, 23538) -- Bracers of the Green Fortress
lib:AddRecipe(23628, 29672, 23539) -- Blessed Bracers
lib:AddRecipe(23629, 29692, 23540) -- Felsteel Longblade
lib:AddRecipe(23630, 29693, 23541) -- Khorium Champion
lib:AddRecipe(23631, 29694, 23542) -- Fel Edged Battleaxe
lib:AddRecipe(23632, 29695, 23543) -- Felsteel Reaper
lib:AddRecipe(23633, 29696, 23544) -- Runic Hammer
lib:AddRecipe(23634, 29697, 23546) -- Fel Hardened Maul
lib:AddRecipe(23635, 29698, 23554) -- Eternium Runed Blade
lib:AddRecipe(23636, 29699, 23555) -- Dirge
lib:AddRecipe(23637, 29700, 23556) -- Hand of Eternity
lib:AddRecipe(23638, 29728, 23575) -- Lesser Ward of Shielding
lib:AddRecipe(23639, 29729, 23576) -- Greater Ward of Shielding
lib:AddRecipe(24002, 29657, 23530) -- Felsteel Shield Spike
lib:AddRecipe(25526, 32285, 25521) -- Greater Rune of Warding
lib:AddRecipe(25846, 32656, 25844) -- Adamantite Rod
lib:AddRecipe(25847, 32657, 25845) -- Eternium Rod
lib:AddRecipe(28632, 34608, 28421) -- Adamantite Weightstone
lib:AddRecipe(30321, 36389, 30034) -- Belt of the Guardian
lib:AddRecipe(30322, 36390, 30032) -- Red Belt of Battle
lib:AddRecipe(30323, 36391, 30033) -- Boots of the Protector
lib:AddRecipe(30324, 36392, 30031) -- Red Havoc Boots
lib:AddRecipe(31390, 38473, 31364) -- Wildguard Breastplate
lib:AddRecipe(31391, 38475, 31367) -- Wildguard Leggings
lib:AddRecipe(31392, 38476, 31368) -- Wildguard Helm
lib:AddRecipe(31393, 38477, 31369) -- Iceguard Breastplate
lib:AddRecipe(31394, 38478, 31370) -- Iceguard Leggings
lib:AddRecipe(31395, 38479, 31371) -- Iceguard Helm
lib:AddRecipe(32441, 40033, 32402) -- Shadesteel Sabots
lib:AddRecipe(32442, 40034, 32403) -- Shadesteel Bracers
lib:AddRecipe(32443, 40035, 32404) -- Shadesteel Greaves
lib:AddRecipe(32444, 40036, 32401) -- Shadesteel Girdle
lib:AddRecipe(32736, 41132, 32568) -- Swiftsteel Bracers
lib:AddRecipe(32737, 41133, 32570) -- Swiftsteel Shoulders
lib:AddRecipe(32738, 41134, 32571) -- Dawnsteel Bracers
lib:AddRecipe(32739, 41135, 32573) -- Dawnsteel Shoulders
lib:AddRecipe(33174, 42662, 33173) -- Ragesteel Shoulders
lib:AddRecipe(33186, 42688, 33185) -- Adamantite Weapon Chain
lib:AddRecipe(33792, 43549, 33791) -- Heavy Copper Longsword
lib:AddRecipe(33954, 43846, 32854) -- Hammer of Righteous Might
lib:AddRecipe(35208, 46140, 34380) -- Sunblessed Gauntlets
lib:AddRecipe(35209, 46141, 34378) -- Hard Khorium Battlefists
lib:AddRecipe(35210, 46142, 34379) -- Sunblessed Breastplate
lib:AddRecipe(35211, 46144, 34377) -- Hard Khorium Battleplate
lib:AddRecipe(35296, 42688, 33185) -- Adamantite Weapon Chain
lib:AddRecipe(35529, 41134, 32571) -- Dawnsteel Bracers
lib:AddRecipe(35530, 41135, 32573) -- Dawnsteel Shoulders
lib:AddRecipe(35531, 41132, 32568) -- Swiftsteel Bracers
lib:AddRecipe(35532, 41133, 32570) -- Swiftsteel Shoulders
lib:AddRecipe(35553, 46141, 34378) -- Hard Khorium Battlefists
lib:AddRecipe(35554, 46144, 34377) -- Hard Khorium Battleplate
lib:AddRecipe(35555, 46142, 34379) -- Sunblessed Breastplate
lib:AddRecipe(35556, 46140, 34380) -- Sunblessed Gauntlets
lib:AddRecipe(41120, 54980, 40958) -- Reinforced Cobalt Legplates
lib:AddRecipe(41122, 54981, 40959) -- Reinforced Cobalt Chestpiece
lib:AddRecipe(41123, 54979, 40957) -- Reinforced Cobalt Helm
lib:AddRecipe(41124, 54978, 40956) -- Reinforced Cobalt Shoulders
lib:AddRecipe(44937, 62202, 44936) -- Titanium Plating
lib:AddRecipe(44938, 62202, 44936) -- Titanium Plating
lib:AddRecipe(45088, 63187, 45550) -- Belt of the Titans
lib:AddRecipe(45089, 63188, 45559) -- Battlelord's Plate Boots
lib:AddRecipe(45090, 63189, 45552) -- Plate Girdle of Righteousness
lib:AddRecipe(45091, 63190, 45561) -- Treads of Destiny
lib:AddRecipe(45092, 63191, 45551) -- Indestructible Plate Girdle
lib:AddRecipe(45093, 63192, 45560) -- Spiked Deathdealers
lib:AddRecipe(47622, 67091, 47591) -- Breastplate of the White Knight
lib:AddRecipe(47623, 67092, 47570) -- Saronite Swordbreakers
lib:AddRecipe(47624, 67093, 47589) -- Titanium Razorplate
lib:AddRecipe(47625, 67094, 47572) -- Titanium Spikeguards
lib:AddRecipe(47626, 67095, 47593) -- Sunforged Breastplate
lib:AddRecipe(47627, 67096, 47574) -- Sunforged Bracers
lib:AddRecipe(47640, 67130, 47592) -- Breastplate of the White Knight
lib:AddRecipe(47641, 67131, 47571) -- Saronite Swordbreakers
lib:AddRecipe(47642, 67135, 47575) -- Sunforged Bracers
lib:AddRecipe(47643, 67134, 47594) -- Sunforged Breastplate
lib:AddRecipe(47644, 67132, 47590) -- Titanium Razorplate
lib:AddRecipe(47645, 67133, 47573) -- Titanium Spikeguards
lib:AddRecipe(49969, 70562, 49902) -- Puresteel Legplates
lib:AddRecipe(49970, 70563, 49905) -- Protectors of Life
lib:AddRecipe(49971, 70565, 49903) -- Legplates of Painful Death
lib:AddRecipe(49972, 70566, 49906) -- Hellfrozen Bonegrinders
lib:AddRecipe(49973, 70567, 49904) -- Pillars of Might
lib:AddRecipe(49974, 70568, 49907) -- Boots of Kingly Upheaval
-- Cooking
lib:AddRecipe(728, 2543, 733) -- Westfall Stew
lib:AddRecipe(2697, 2542, 724) -- Goretusk Liver Pie
lib:AddRecipe(2698, 2545, 2682) -- Cooked Crab Claw
lib:AddRecipe(2699, 2547, 1082) -- Redridge Goulash
lib:AddRecipe(2700, 2548, 2685) -- Succulent Pork Ribs
lib:AddRecipe(2701, 2549, 1017) -- Seasoned Wolf Kabob
lib:AddRecipe(2889, 2795, 2888) -- Beer Basted Boar Ribs
lib:AddRecipe(3678, 3370, 3662) -- Crocolisk Steak
lib:AddRecipe(3679, 3371, 3220) -- Blood Sausage
lib:AddRecipe(3680, 3372, 3663) -- Murloc Fin Soup
lib:AddRecipe(3681, 3373, 3664) -- Crocolisk Gumbo
lib:AddRecipe(3682, 3376, 3665) -- Curiously Tasty Omelet
lib:AddRecipe(3683, 3377, 3666) -- Gooey Spider Cake
lib:AddRecipe(3734, 3397, 3726) -- Big Bear Steak
lib:AddRecipe(3735, 3398, 3727) -- Hot Lion Chops
lib:AddRecipe(3736, 3399, 3728) -- Tasty Lion Steak
lib:AddRecipe(3737, 3400, 3729) -- Soothing Turtle Bisque
lib:AddRecipe(4609, 4094, 4457) -- Barbecued Buzzard Wing
lib:AddRecipe(5482, 6412, 5472) -- Kaldorei Spider Kabob
lib:AddRecipe(5483, 6413, 5473) -- Scorpid Surprise
lib:AddRecipe(5484, 6414, 5474) -- Roasted Kodo Meat
lib:AddRecipe(5485, 6415, 5476) -- Fillet of Frenzy
lib:AddRecipe(5486, 6416, 5477) -- Strider Stew
lib:AddRecipe(5487, 6417, 5478) -- Dig Rat Stew
lib:AddRecipe(5488, 6418, 5479) -- Crispy Lizard Tail
lib:AddRecipe(5489, 6419, 5480) -- Lean Venison
lib:AddRecipe(5528, 6501, 5526) -- Clam Chowder
lib:AddRecipe(6039, 7213, 6038) -- Giant Clam Scorcho
lib:AddRecipe(6325, 7751, 6290) -- Brilliant Smallfish
lib:AddRecipe(6326, 7752, 787) -- Slitherskin Mackerel
lib:AddRecipe(6328, 7753, 4592) -- Longjaw Mud Snapper
lib:AddRecipe(6329, 7754, 6316) -- Loch Frenzy Delight
lib:AddRecipe(6330, 7755, 4593) -- Bristle Whisker Catfish
lib:AddRecipe(6368, 7827, 5095) -- Rainbow Fin Albacore
lib:AddRecipe(6369, 7828, 4594) -- Rockscale Cod
lib:AddRecipe(6661, 8238, 6657) -- Savory Deviate Delight
lib:AddRecipe(6891, 8604, 6888) -- Herb Baked Egg
lib:AddRecipe(6892, 8607, 6890) -- Smoked Bear Meat
lib:AddRecipe(7678, 9513, 7676) -- Thistle Tea
lib:AddRecipe(12226, 15935, 12224) -- Crispy Bat Wing
lib:AddRecipe(12227, 15853, 12209) -- Lean Wolf Steak
lib:AddRecipe(12228, 15855, 12210) -- Roast Raptor
lib:AddRecipe(12229, 15856, 13851) -- Hot Wolf Ribs
lib:AddRecipe(12231, 15861, 12212) -- Jungle Stew
lib:AddRecipe(12232, 15863, 12213) -- Carrion Surprise
lib:AddRecipe(12233, 15865, 12214) -- Mystery Stew
lib:AddRecipe(12239, 15906, 12217) -- Dragonbreath Chili
lib:AddRecipe(12240, 15910, 12215) -- Heavy Kodo Stew
lib:AddRecipe(13939, 18238, 6887) -- Spotted Yellowtail
lib:AddRecipe(13940, 18239, 13927) -- Cooked Glossy Mightfish
lib:AddRecipe(13941, 18241, 13930) -- Filet of Redgill
lib:AddRecipe(13942, 18240, 13928) -- Grilled Squid
lib:AddRecipe(13943, 18242, 13929) -- Hot Smoked Bass
lib:AddRecipe(13945, 18243, 13931) -- Nightfin Soup
lib:AddRecipe(13946, 18244, 13932) -- Poached Sunscale Salmon
lib:AddRecipe(13947, 18245, 13933) -- Lobster Stew
lib:AddRecipe(13948, 18246, 13934) -- Mightfish Steak
lib:AddRecipe(13949, 18247, 13935) -- Baked Salmon
lib:AddRecipe(16110, 15933, 12218) -- Monster Omelet
lib:AddRecipe(16111, 15915, 12216) -- Spiced Chili Crab
lib:AddRecipe(16767, 20626, 16766) -- Undermine Clam Chowder
lib:AddRecipe(17062, 20916, 8364) -- Mithril Head Trout
lib:AddRecipe(17200, 21143, 17197) -- Gingerbread Cookie
lib:AddRecipe(17201, 21144, 17198) -- Egg Nog
lib:AddRecipe(18046, 22480, 18045) -- Tender Wolf Steak
lib:AddRecipe(18160, 9513, 7676) -- Thistle Tea
lib:AddRecipe(18267, 22761, 18254) -- Runn Tum Tuber Surprise
lib:AddRecipe(20075, 24418, 20074) -- Heavy Crocolisk Stew
lib:AddRecipe(21025, 25659, 21023) -- Dirge's Kickin' Chimaerok Chops
lib:AddRecipe(21099, 25704, 21072) -- Smoked Sagefish
lib:AddRecipe(21219, 25954, 21217) -- Sagefish Delight
lib:AddRecipe(22647, 28267, 22645) -- Crunchy Spider Surprise
lib:AddRecipe(27684, 33279, 27651) -- Buzzard Bites
lib:AddRecipe(27685, 33276, 27635) -- Lynx Steak
lib:AddRecipe(27686, 33277, 24105) -- Roasted Moongraze Tenderloin
lib:AddRecipe(27687, 33278, 27636) -- Bat Bites
lib:AddRecipe(27688, 33284, 27655) -- Ravager Dog
lib:AddRecipe(27689, 33285, 27656) -- Sporeling Snack
lib:AddRecipe(27690, 33286, 27657) -- Blackened Basilisk
lib:AddRecipe(27691, 33287, 27658) -- Roasted Clefthoof
lib:AddRecipe(27692, 33288, 27659) -- Warp Burger
lib:AddRecipe(27693, 33289, 27660) -- Talbuk Steak
lib:AddRecipe(27694, 33290, 27661) -- Blackened Trout
lib:AddRecipe(27695, 33291, 27662) -- Feltail Delight
lib:AddRecipe(27696, 33292, 27663) -- Blackened Sporefish
lib:AddRecipe(27697, 33293, 27664) -- Grilled Mudfish
lib:AddRecipe(27698, 33294, 27665) -- Poached Bluefish
lib:AddRecipe(27699, 33295, 27666) -- Golden Fish Sticks
lib:AddRecipe(27700, 33296, 27667) -- Spicy Crawdad
lib:AddRecipe(30156, 36210, 30155) -- Clam Bar
lib:AddRecipe(31674, 38868, 31673) -- Crunchy Serpent
lib:AddRecipe(31675, 38867, 31672) -- Mok'Nathal Shortribs
lib:AddRecipe(33869, 43761, 33867) -- Broiled Bloodfin
lib:AddRecipe(33870, 43707, 33825) -- Skullfish Soup
lib:AddRecipe(33871, 43758, 33866) -- Stormchops
lib:AddRecipe(33873, 43765, 33872) -- Spicy Hot Talbuk
lib:AddRecipe(33875, 43772, 33874) -- Kibler's Bits
lib:AddRecipe(33925, 43779, 33924) -- Delicious Chocolate Cake
lib:AddRecipe(34413, 45022, 34411) -- Hot Apple Cider
lib:AddRecipe(34834, 45695, 34832) -- Captain Rumsey's Lager
lib:AddRecipe(35564, 46684, 35563) -- Charred Bear Kabobs
lib:AddRecipe(35566, 46688, 35565) -- Juicy Bear Burger
lib:AddRecipe(39644, 53056, 39520) -- Kungaloosh
lib:AddRecipe(43017, 57423, 43015) -- Fish Feast
lib:AddRecipe(43018, 45555, 34754) -- Mega Mammoth Meal
lib:AddRecipe(43019, 45556, 34755) -- Tender Shoveltusk Steak
lib:AddRecipe(43020, 45557, 34756) -- Spiced Worm Burger
lib:AddRecipe(43021, 45558, 34757) -- Very Burnt Worg
lib:AddRecipe(43022, 45559, 34758) -- Mighty Rhino Dogs
lib:AddRecipe(43023, 45567, 34766) -- Poached Northern Sculpin
lib:AddRecipe(43024, 45568, 34767) -- Firecracker Salmon
lib:AddRecipe(43025, 45571, 34768) -- Spicy Blue Nettlefish
lib:AddRecipe(43026, 45570, 34769) -- Imperial Manta Steak
lib:AddRecipe(43027, 57433, 42993) -- Spicy Fried Herring
lib:AddRecipe(43028, 57434, 42994) -- Rhinolicious Wormsteak
lib:AddRecipe(43029, 57435, 43004) -- Critter Bites
lib:AddRecipe(43030, 57436, 42995) -- Hearty Rhino
lib:AddRecipe(43031, 57437, 42996) -- Snapper Extreme
lib:AddRecipe(43032, 57438, 42997) -- Blackened Worg Steak
lib:AddRecipe(43033, 57439, 42998) -- Cuttlesteak
lib:AddRecipe(43034, 57440, 43005) -- Spiced Mammoth Treats
lib:AddRecipe(43035, 57441, 42999) -- Blackened Dragonfin
lib:AddRecipe(43036, 57442, 43000) -- Dragonfin Filet
lib:AddRecipe(43037, 57443, 43001) -- Tracker Snacks
lib:AddRecipe(43505, 58527, 43478) -- Gigantic Feast
lib:AddRecipe(43506, 58528, 43480) -- Small Feast
lib:AddRecipe(43507, 58512, 43490) -- Tasty Cupcake
lib:AddRecipe(43508, 58521, 43488) -- Last Week's Mammoth
lib:AddRecipe(43509, 58523, 43491) -- Bad Clams
lib:AddRecipe(43510, 58525, 43492) -- Haunted Herring
lib:AddRecipe(44851, 15856, 13851) -- Hot Wolf Ribs
lib:AddRecipe(44858, 62049, 44840) -- Cranberry Chutney
lib:AddRecipe(44859, 62051, 44839) -- Candied Sweet Potato
lib:AddRecipe(44860, 62050, 44837) -- Spice Bread Stuffing
lib:AddRecipe(44861, 62045, 44838) -- Slow-Roasted Turkey
lib:AddRecipe(44862, 62044, 44836) -- Pumpkin Pie
lib:AddRecipe(44954, 62350, 44953) -- Worg Tartare
lib:AddRecipe(44977, 6417, 5478) -- Dig Rat Stew
lib:AddRecipe(46710, 65454, 46691) -- Bread of the Dead
lib:AddRecipe(46803, 66038, 44837) -- Spice Bread Stuffing
lib:AddRecipe(46804, 66036, 44836) -- Pumpkin Pie
lib:AddRecipe(46805, 66035, 44840) -- Cranberry Chutney
lib:AddRecipe(46806, 66034, 44839) -- Candied Sweet Potato
lib:AddRecipe(46807, 66037, 44838) -- Slow-Roasted Turkey
-- Enchanting
lib:AddRecipe(6342, 7443, nil) -- Enchant Chest - Minor Mana
lib:AddRecipe(6344, 7766, nil) -- Enchant Bracer - Minor Spirit
lib:AddRecipe(6345, 7771, nil) -- Enchant Cloak - Minor Protection
lib:AddRecipe(6346, 7776, nil) -- Enchant Chest - Lesser Mana
lib:AddRecipe(6347, 7782, nil) -- Enchant Bracer - Minor Strength
lib:AddRecipe(6348, 7786, nil) -- Enchant Weapon - Minor Beastslayer
lib:AddRecipe(6349, 7793, nil) -- Enchant 2H Weapon - Lesser Intellect
lib:AddRecipe(6375, 7859, nil) -- Enchant Bracer - Lesser Spirit
lib:AddRecipe(6376, 7863, nil) -- Enchant Boots - Minor Stamina
lib:AddRecipe(6377, 7867, nil) -- Enchant Boots - Minor Agility
lib:AddRecipe(11038, 13380, nil) -- Enchant 2H Weapon - Lesser Spirit
lib:AddRecipe(11039, 13419, nil) -- Enchant Cloak - Minor Agility
lib:AddRecipe(11081, 13464, nil) -- Enchant Shield - Lesser Protection
lib:AddRecipe(11098, 13522, nil) -- Enchant Cloak - Lesser Shadow Resistance
lib:AddRecipe(11101, 13536, nil) -- Enchant Bracer - Lesser Strength
lib:AddRecipe(11150, 13612, nil) -- Enchant Gloves - Mining
lib:AddRecipe(11151, 13617, nil) -- Enchant Gloves - Herbalism
lib:AddRecipe(11152, 13620, nil) -- Enchant Gloves - Fishing
lib:AddRecipe(11163, 13646, nil) -- Enchant Bracer - Lesser Deflection
lib:AddRecipe(11164, 13653, nil) -- Enchant Weapon - Lesser Beastslayer
lib:AddRecipe(11165, 13655, nil) -- Enchant Weapon - Lesser Elemental Slayer
lib:AddRecipe(11166, 13698, nil) -- Enchant Gloves - Skinning
lib:AddRecipe(11167, 13687, nil) -- Enchant Boots - Lesser Spirit
lib:AddRecipe(11168, 13689, nil) -- Enchant Shield - Lesser Block
lib:AddRecipe(11202, 13817, nil) -- Enchant Shield - Stamina
lib:AddRecipe(11203, 13841, nil) -- Enchant Gloves - Advanced Mining
lib:AddRecipe(11204, 13846, nil) -- Enchant Bracer - Greater Spirit
lib:AddRecipe(11205, 13868, nil) -- Enchant Gloves - Advanced Herbalism
lib:AddRecipe(11206, 13882, nil) -- Enchant Cloak - Lesser Agility
lib:AddRecipe(11207, 13898, nil) -- Enchant Weapon - Fiery Weapon
lib:AddRecipe(11208, 13915, nil) -- Enchant Weapon - Demonslaying
lib:AddRecipe(11223, 13931, nil) -- Enchant Bracer - Deflection
lib:AddRecipe(11224, 13933, nil) -- Enchant Shield - Frost Resistance
lib:AddRecipe(11225, 13945, nil) -- Enchant Bracer - Greater Stamina
lib:AddRecipe(11226, 13947, nil) -- Enchant Gloves - Riding Skill
lib:AddRecipe(11813, 15596, 11811) -- Smoking Heart of the Mountain
lib:AddRecipe(16214, 20008, nil) -- Enchant Bracer - Greater Intellect
lib:AddRecipe(16215, 20020, nil) -- Enchant Boots - Greater Stamina
lib:AddRecipe(16216, 20014, nil) -- Enchant Cloak - Greater Resistance
lib:AddRecipe(16217, 20017, nil) -- Enchant Shield - Greater Stamina
lib:AddRecipe(16218, 20009, nil) -- Enchant Bracer - Superior Spirit
lib:AddRecipe(16219, 20012, nil) -- Enchant Gloves - Greater Agility
lib:AddRecipe(16220, 20024, nil) -- Enchant Boots - Spirit
lib:AddRecipe(16221, 20026, nil) -- Enchant Chest - Major Health
lib:AddRecipe(16222, 20016, nil) -- Enchant Shield - Vitality
lib:AddRecipe(16223, 20029, nil) -- Enchant Weapon - Icy Chill
lib:AddRecipe(16224, 20015, nil) -- Enchant Cloak - Superior Defense
lib:AddRecipe(16242, 20028, nil) -- Enchant Chest - Major Mana
lib:AddRecipe(16243, 20051, 16207) -- Runed Arcanite Rod
lib:AddRecipe(16244, 20013, nil) -- Enchant Gloves - Greater Strength
lib:AddRecipe(16245, 20023, nil) -- Enchant Boots - Greater Agility
lib:AddRecipe(16246, 20010, nil) -- Enchant Bracer - Superior Strength
lib:AddRecipe(16247, 20030, nil) -- Enchant 2H Weapon - Superior Impact
lib:AddRecipe(16248, 20033, nil) -- Enchant Weapon - Unholy Weapon
lib:AddRecipe(16249, 20036, nil) -- Enchant 2H Weapon - Major Intellect
lib:AddRecipe(16250, 20031, nil) -- Enchant Weapon - Superior Striking
lib:AddRecipe(16251, 20011, nil) -- Enchant Bracer - Superior Stamina
lib:AddRecipe(16252, 20034, nil) -- Enchant Weapon - Crusader
lib:AddRecipe(16253, 20025, nil) -- Enchant Chest - Greater Stats
lib:AddRecipe(16254, 20032, nil) -- Enchant Weapon - Lifestealing
lib:AddRecipe(16255, 20035, nil) -- Enchant 2H Weapon - Major Spirit
lib:AddRecipe(17725, 21931, nil) -- Enchant Weapon - Winter's Might
lib:AddRecipe(18259, 22749, nil) -- Enchant Weapon - Spellpower
lib:AddRecipe(18260, 22750, nil) -- Enchant Weapon - Healing Power
lib:AddRecipe(19444, 23799, nil) -- Enchant Weapon - Strength
lib:AddRecipe(19445, 23800, nil) -- Enchant Weapon - Agility
lib:AddRecipe(19446, 23801, nil) -- Enchant Bracer - Mana Regeneration
lib:AddRecipe(19447, 23802, nil) -- Enchant Bracer - Healing Power
lib:AddRecipe(19448, 23803, nil) -- Enchant Weapon - Mighty Spirit
lib:AddRecipe(19449, 23804, nil) -- Enchant Weapon - Mighty Intellect
lib:AddRecipe(20726, 25072, nil) -- Enchant Gloves - Threat
lib:AddRecipe(20727, 25073, nil) -- Enchant Gloves - Shadow Power
lib:AddRecipe(20728, 25074, nil) -- Enchant Gloves - Frost Power
lib:AddRecipe(20729, 25078, nil) -- Enchant Gloves - Fire Power
lib:AddRecipe(20730, 25079, nil) -- Enchant Gloves - Healing Power
lib:AddRecipe(20731, 25080, nil) -- Enchant Gloves - Superior Agility
lib:AddRecipe(20732, 25081, nil) -- Enchant Cloak - Greater Fire Resistance
lib:AddRecipe(20733, 25082, nil) -- Enchant Cloak - Greater Nature Resistance
lib:AddRecipe(20734, 25083, nil) -- Enchant Cloak - Stealth
lib:AddRecipe(20735, 25084, nil) -- Enchant Cloak - Subtlety
lib:AddRecipe(20736, 25086, nil) -- Enchant Cloak - Dodge
lib:AddRecipe(20752, 25125, 20745) -- Minor Mana Oil
lib:AddRecipe(20753, 25126, 20746) -- Lesser Wizard Oil
lib:AddRecipe(20754, 25127, 20747) -- Lesser Mana Oil
lib:AddRecipe(20755, 25128, 20750) -- Wizard Oil
lib:AddRecipe(20756, 25129, 20749) -- Brilliant Wizard Oil
lib:AddRecipe(20757, 25130, 20748) -- Brilliant Mana Oil
lib:AddRecipe(20758, 25124, 20744) -- Minor Wizard Oil
lib:AddRecipe(22392, 27837, nil) -- Enchant 2H Weapon - Agility
lib:AddRecipe(22530, 27906, nil) -- Enchant Bracer - Major Defense
lib:AddRecipe(22531, 27911, nil) -- Enchant Bracer - Superior Healing
lib:AddRecipe(22532, 27913, nil) -- Enchant Bracer - Restore Mana Prime
lib:AddRecipe(22533, 27914, nil) -- Enchant Bracer - Fortitude
lib:AddRecipe(22534, 27917, nil) -- Enchant Bracer - Spellpower
lib:AddRecipe(22535, 27920, nil) -- Enchant Ring - Striking
lib:AddRecipe(22536, 27924, nil) -- Enchant Ring - Spellpower
lib:AddRecipe(22537, 27926, nil) -- Enchant Ring - Healing Power
lib:AddRecipe(22538, 27927, nil) -- Enchant Ring - Stats
lib:AddRecipe(22539, 27945, nil) -- Enchant Shield - Intellect
lib:AddRecipe(22540, 27946, nil) -- Enchant Shield - Shield Block
lib:AddRecipe(22541, 27947, nil) -- Enchant Shield - Resistance
lib:AddRecipe(22542, 27948, nil) -- Enchant Boots - Vitality
lib:AddRecipe(22543, 27950, nil) -- Enchant Boots - Fortitude
lib:AddRecipe(22544, 27951, nil) -- Enchant Boots - Dexterity
lib:AddRecipe(22545, 27954, nil) -- Enchant Boots - Surefooted
lib:AddRecipe(22547, 27960, nil) -- Enchant Chest - Exceptional Stats
lib:AddRecipe(22548, 27962, nil) -- Enchant Cloak - Major Resistance
lib:AddRecipe(22551, 27968, nil) -- Enchant Weapon - Major Intellect
lib:AddRecipe(22552, 27967, nil) -- Enchant Weapon - Major Striking
lib:AddRecipe(22553, 27972, nil) -- Enchant Weapon - Potency
lib:AddRecipe(22554, 27971, nil) -- Enchant 2H Weapon - Savagery
lib:AddRecipe(22555, 27975, nil) -- Enchant Weapon - Major Spellpower
lib:AddRecipe(22556, 27977, nil) -- Enchant 2H Weapon - Major Agility
lib:AddRecipe(22557, 28004, nil) -- Enchant Weapon - Battlemaster
lib:AddRecipe(22558, 28003, nil) -- Enchant Weapon - Spellsurge
lib:AddRecipe(22559, 27984, nil) -- Enchant Weapon - Mongoose
lib:AddRecipe(22560, 27981, nil) -- Enchant Weapon - Sunfire
lib:AddRecipe(22561, 27982, nil) -- Enchant Weapon - Soulfrost
lib:AddRecipe(22562, 28016, 22521) -- Superior Mana Oil
lib:AddRecipe(22563, 28019, 22522) -- Superior Wizard Oil
lib:AddRecipe(22564, 28021, 22445) -- Arcane Dust
lib:AddRecipe(22565, 28022, 22449) -- Large Prismatic Shard
lib:AddRecipe(24000, 27911, nil) -- Enchant Bracer - Superior Healing
lib:AddRecipe(24003, 27960, nil) -- Enchant Chest - Exceptional Stats
lib:AddRecipe(25848, 32665, 22462) -- Runed Adamantite Rod
lib:AddRecipe(25849, 32667, 22463) -- Runed Eternium Rod
lib:AddRecipe(28270, 33992, nil) -- Enchant Chest - Major Resilience
lib:AddRecipe(28271, 33994, nil) -- Enchant Gloves - Precise Strikes
lib:AddRecipe(28272, 33997, nil) -- Enchant Gloves - Major Spellpower
lib:AddRecipe(28273, 33999, nil) -- Enchant Gloves - Major Healing
lib:AddRecipe(28274, 34003, nil) -- Enchant Cloak - Spell Penetration
lib:AddRecipe(28276, 34005, nil) -- Enchant Cloak - Greater Arcane Resistance
lib:AddRecipe(28277, 34006, nil) -- Enchant Cloak - Greater Shadow Resistance
lib:AddRecipe(28279, 34007, nil) -- Enchant Boots - Cat's Swiftness
lib:AddRecipe(28280, 34008, nil) -- Enchant Boots - Boar's Speed
lib:AddRecipe(28281, 34010, nil) -- Enchant Weapon - Major Healing
lib:AddRecipe(28282, 34009, nil) -- Enchant Shield - Major Stamina
lib:AddRecipe(33148, 25086, nil) -- Enchant Cloak - Dodge
lib:AddRecipe(33149, 25083, nil) -- Enchant Cloak - Stealth
lib:AddRecipe(33150, 25084, nil) -- Enchant Cloak - Subtlety
lib:AddRecipe(33151, 25084, nil) -- Enchant Cloak - Subtlety
lib:AddRecipe(33152, 25080, nil) -- Enchant Gloves - Superior Agility
lib:AddRecipe(33153, 25072, nil) -- Enchant Gloves - Threat
lib:AddRecipe(33165, 42620, nil) -- Enchant Weapon - Greater Agility
lib:AddRecipe(33307, 42974, nil) -- Enchant Weapon - Executioner
lib:AddRecipe(34872, 45765, 22449) -- Void Shatter
lib:AddRecipe(35297, 34008, nil) -- Enchant Boots - Boar's Speed
lib:AddRecipe(35298, 27948, nil) -- Enchant Boots - Vitality
lib:AddRecipe(35299, 34007, nil) -- Enchant Boots - Cat's Swiftness
lib:AddRecipe(35420, 27899, nil) -- Enchant Bracer - Brawn
lib:AddRecipe(35423, 34001, nil) -- Enchant Bracer - Major Intellect
lib:AddRecipe(35426, 27905, nil) -- Enchant Bracer - Stats
lib:AddRecipe(35428, 27957, nil) -- Enchant Chest - Exceptional Health
lib:AddRecipe(35431, 33990, nil) -- Enchant Chest - Major Spirit
lib:AddRecipe(35432, 34004, nil) -- Enchant Cloak - Greater Agility
lib:AddRecipe(35437, 27961, nil) -- Enchant Cloak - Major Armor
lib:AddRecipe(35438, 33996, nil) -- Enchant Gloves - Assault
lib:AddRecipe(35439, 33993, nil) -- Enchant Gloves - Blasting
lib:AddRecipe(35442, 33995, nil) -- Enchant Gloves - Major Strength
lib:AddRecipe(35498, 46578, nil) -- Enchant Weapon - Deathfrost
lib:AddRecipe(35500, 46594, nil) -- Enchant Chest - Defense
lib:AddRecipe(35756, 47051, nil) -- Enchant Cloak - Steelweave
lib:AddRecipe(36837, 7867, nil) -- Enchant Boots - Minor Agility
lib:AddRecipe(36838, 7867, nil) -- Enchant Boots - Minor Agility
lib:AddRecipe(36839, 7867, nil) -- Enchant Boots - Minor Agility
lib:AddRecipe(36840, 7867, nil) -- Enchant Boots - Minor Agility
lib:AddRecipe(37326, 44593, nil) -- Enchant Bracers - Major Spirit
lib:AddRecipe(37329, 44510, nil) -- Enchant Weapon - Exceptional Spirit
lib:AddRecipe(37330, 44596, nil) -- Enchant Cloak - Superior Arcane Resistance
lib:AddRecipe(37331, 44556, nil) -- Enchant Cloak - Superior Fire Resistance
lib:AddRecipe(37332, 44483, nil) -- Enchant Cloak - Superior Frost Resistance
lib:AddRecipe(37333, 44494, nil) -- Enchant Cloak - Superior Nature Resistance
lib:AddRecipe(37334, 44590, nil) -- Enchant Cloak - Superior Shadow Resistance
lib:AddRecipe(37335, 44500, nil) -- Enchant Cloak - Superior Agility
lib:AddRecipe(37336, 47766, nil) -- Enchant Chest - Greater Defense
lib:AddRecipe(37337, 44616, nil) -- Enchant Bracers - Greater Stats
lib:AddRecipe(37338, 44630, nil) -- Enchant 2H Weapon - Greater Savagery
lib:AddRecipe(37339, 44621, nil) -- Enchant Weapon - Giant Slayer
lib:AddRecipe(37340, 44588, nil) -- Enchant Chest - Exceptional Resilience
lib:AddRecipe(37341, 44589, nil) -- Enchant Boots - Superior Agility
lib:AddRecipe(37342, 44612, nil) -- Enchant Gloves - Greater Blasting
lib:AddRecipe(37343, 44633, nil) -- Enchant Weapon - Exceptional Agility
lib:AddRecipe(37344, 44524, nil) -- Enchant Weapon - Icebreaker
lib:AddRecipe(37345, 44513, nil) -- Enchant Gloves - Greater Assault
lib:AddRecipe(37346, 44598, nil) -- Enchant Bracers - Expertise
lib:AddRecipe(37347, 44591, nil) -- Enchant Cloak - Titanweave
lib:AddRecipe(37348, 47898, nil) -- Enchant Cloak - Greater Speed
lib:AddRecipe(37349, 44631, nil) -- Enchant Cloak - Shadow Armor
lib:AddRecipe(38679, 7418, nil) -- Enchant Bracer - Minor Health
lib:AddRecipe(38766, 7420, nil) -- Enchant Chest - Minor Health
lib:AddRecipe(38767, 7426, nil) -- Enchant Chest - Minor Absorption
lib:AddRecipe(38768, 7428, nil) -- Enchant Bracer - Minor Deflection
lib:AddRecipe(38770, 7454, nil) -- Enchant Cloak - Minor Resistance
lib:AddRecipe(38771, 7457, nil) -- Enchant Bracer - Minor Stamina
lib:AddRecipe(38772, 7745, nil) -- Enchant 2H Weapon - Minor Impact
lib:AddRecipe(38773, 7748, nil) -- Enchant Chest - Lesser Health
lib:AddRecipe(38777, 7779, nil) -- Enchant Bracer - Minor Agility
lib:AddRecipe(38780, 7788, nil) -- Enchant Weapon - Minor Striking
lib:AddRecipe(38782, 7857, nil) -- Enchant Chest - Health
lib:AddRecipe(38784, 7861, nil) -- Enchant Cloak - Lesser Fire Resistance
lib:AddRecipe(38787, 13378, nil) -- Enchant Shield - Minor Stamina
lib:AddRecipe(38790, 13421, nil) -- Enchant Cloak - Lesser Protection
lib:AddRecipe(38792, 13485, nil) -- Enchant Shield - Lesser Spirit
lib:AddRecipe(38793, 13501, nil) -- Enchant Bracer - Lesser Stamina
lib:AddRecipe(38794, 13503, nil) -- Enchant Weapon - Lesser Striking
lib:AddRecipe(38796, 13529, nil) -- Enchant 2H Weapon - Lesser Impact
lib:AddRecipe(38798, 13538, nil) -- Enchant Chest - Lesser Absorption
lib:AddRecipe(38799, 13607, nil) -- Enchant Chest - Mana
lib:AddRecipe(38803, 13622, nil) -- Enchant Bracer - Lesser Intellect
lib:AddRecipe(38804, 13626, nil) -- Enchant Chest - Minor Stats
lib:AddRecipe(38805, 13631, nil) -- Enchant Shield - Lesser Stamina
lib:AddRecipe(38806, 13635, nil) -- Enchant Cloak - Defense
lib:AddRecipe(38807, 13637, nil) -- Enchant Boots - Lesser Agility
lib:AddRecipe(38808, 13640, nil) -- Enchant Chest - Greater Health
lib:AddRecipe(38809, 13642, nil) -- Enchant Bracer - Spirit
lib:AddRecipe(38810, 13644, nil) -- Enchant Boots - Lesser Stamina
lib:AddRecipe(38812, 13648, nil) -- Enchant Bracer - Stamina
lib:AddRecipe(38815, 13657, nil) -- Enchant Cloak - Fire Resistance
lib:AddRecipe(38816, 13659, nil) -- Enchant Shield - Spirit
lib:AddRecipe(38817, 13661, nil) -- Enchant Bracer - Strength
lib:AddRecipe(38818, 13663, nil) -- Enchant Chest - Greater Mana
lib:AddRecipe(38821, 13693, nil) -- Enchant Weapon - Striking
lib:AddRecipe(38822, 13695, nil) -- Enchant 2H Weapon - Impact
lib:AddRecipe(38824, 13700, nil) -- Enchant Chest - Lesser Stats
lib:AddRecipe(38825, 13746, nil) -- Enchant Cloak - Greater Defense
lib:AddRecipe(38826, 13794, nil) -- Enchant Cloak - Resistance
lib:AddRecipe(38827, 13815, nil) -- Enchant Gloves - Agility
lib:AddRecipe(38829, 13822, nil) -- Enchant Bracer - Intellect
lib:AddRecipe(38830, 13836, nil) -- Enchant Boots - Stamina
lib:AddRecipe(38833, 13858, nil) -- Enchant Chest - Superior Health
lib:AddRecipe(38836, 13887, nil) -- Enchant Gloves - Strength
lib:AddRecipe(38837, 13890, nil) -- Enchant Boots - Minor Speed
lib:AddRecipe(38839, 13905, nil) -- Enchant Shield - Greater Spirit
lib:AddRecipe(38841, 13917, nil) -- Enchant Chest - Superior Mana
lib:AddRecipe(38844, 13935, nil) -- Enchant Boots - Agility
lib:AddRecipe(38845, 13937, nil) -- Enchant 2H Weapon - Greater Impact
lib:AddRecipe(38846, 13939, nil) -- Enchant Bracer - Greater Strength
lib:AddRecipe(38847, 13941, nil) -- Enchant Chest - Stats
lib:AddRecipe(38848, 13943, nil) -- Enchant Weapon - Greater Striking
lib:AddRecipe(38851, 13948, nil) -- Enchant Gloves - Minor Haste
lib:AddRecipe(38897, 27899, nil) -- Enchant Bracer - Brawn
lib:AddRecipe(38898, 27905, nil) -- Enchant Bracer - Stats
lib:AddRecipe(38904, 27944, nil) -- Enchant Shield - Tough Shield
lib:AddRecipe(38911, 27957, nil) -- Enchant Chest - Exceptional Health
lib:AddRecipe(38912, 27958, nil) -- Enchant Chest - Exceptional Mana
lib:AddRecipe(38914, 27961, nil) -- Enchant Cloak - Major Armor
lib:AddRecipe(38928, 33990, nil) -- Enchant Chest - Major Spirit
lib:AddRecipe(38929, 33991, nil) -- Enchant Chest - Restore Mana Prime
lib:AddRecipe(38931, 33993, nil) -- Enchant Gloves - Blasting
lib:AddRecipe(38933, 33995, nil) -- Enchant Gloves - Major Strength
lib:AddRecipe(38934, 33996, nil) -- Enchant Gloves - Assault
lib:AddRecipe(38937, 34001, nil) -- Enchant Bracer - Major Intellect
lib:AddRecipe(38938, 34002, nil) -- Enchant Bracer - Assault
lib:AddRecipe(38940, 34004, nil) -- Enchant Cloak - Greater Agility
lib:AddRecipe(38949, 44383, nil) -- Enchant Shield - Resilience
lib:AddRecipe(38951, 44484, nil) -- Enchant Gloves - Expertise
lib:AddRecipe(38953, 44488, nil) -- Enchant Gloves - Precision
lib:AddRecipe(38954, 44489, nil) -- Enchant Shield - Defense
lib:AddRecipe(38955, 44492, nil) -- Enchant Chest - Mighty Health
lib:AddRecipe(38960, 44506, nil) -- Enchant Gloves - Gatherer
lib:AddRecipe(38961, 44508, nil) -- Enchant Boots - Greater Spirit
lib:AddRecipe(38962, 44509, nil) -- Enchant Chest - Greater Mana Restoration
lib:AddRecipe(38966, 44528, nil) -- Enchant Boots - Greater Fortitude
lib:AddRecipe(38967, 44529, nil) -- Enchant Gloves - Major Agility
lib:AddRecipe(38968, 44555, nil) -- Enchant Bracers - Exceptional Intellect
lib:AddRecipe(38971, 60616, nil) -- Enchant Bracers - Striking
lib:AddRecipe(38973, 44582, nil) -- Enchant Cloak - Spell Piercing
lib:AddRecipe(38974, 44584, nil) -- Enchant Boots - Greater Vitality
lib:AddRecipe(38979, 44592, nil) -- Enchant Gloves - Exceptional Spellpower
lib:AddRecipe(38986, 60623, nil) -- Enchant Boots - Icewalker
lib:AddRecipe(38989, 44623, nil) -- Enchant Chest - Super Stats
lib:AddRecipe(38991, 44629, nil) -- Enchant Weapon - Exceptional Spellpower
lib:AddRecipe(38997, 44635, nil) -- Enchant Bracers - Greater Spellpower
lib:AddRecipe(39005, 47900, nil) -- Enchant Chest - Super Health
lib:AddRecipe(44449, 60606, nil) -- Enchant Boots - Assault
lib:AddRecipe(44453, 60621, nil) -- Enchant Weapon - Greater Potency
lib:AddRecipe(44455, 60653, nil) -- Enchant Shield - Greater Intellect
lib:AddRecipe(44456, 60609, nil) -- Enchant Cloak - Speed
lib:AddRecipe(44457, 60663, nil) -- Enchant Cloak - Major Agility
lib:AddRecipe(44458, 60668, nil) -- Enchant Gloves - Crusher
lib:AddRecipe(44471, 47672, nil) -- Enchant Cloak - Mighty Armor
lib:AddRecipe(44472, 47898, nil) -- Enchant Cloak - Greater Speed
lib:AddRecipe(44473, 44595, nil) -- Enchant 2H Weapon - Scourgebane
lib:AddRecipe(44483, 60691, nil) -- Enchant 2H Weapon - Massacre
lib:AddRecipe(44484, 44575, nil) -- Enchant Bracers - Greater Assault
lib:AddRecipe(44485, 44625, nil) -- Enchant Gloves - Armsman
lib:AddRecipe(44486, 60707, nil) -- Enchant Weapon - Superior Potency
lib:AddRecipe(44487, 60714, nil) -- Enchant Weapon - Mighty Spellpower
lib:AddRecipe(44488, 47899, nil) -- Enchant Cloak - Wisdom
lib:AddRecipe(44489, 60692, nil) -- Enchant Chest - Powerful Stats
lib:AddRecipe(44490, 60763, nil) -- Enchant Boots - Greater Assault
lib:AddRecipe(44491, 47901, nil) -- Enchant Boots - Tuskarr's Vitality
lib:AddRecipe(44492, 59621, nil) -- Enchant Weapon - Berserking
lib:AddRecipe(44494, 44576, nil) -- Enchant Weapon - Lifeward
lib:AddRecipe(44495, 59625, nil) -- Enchant Weapon - Black Magic
lib:AddRecipe(44496, 59619, nil) -- Enchant Weapon - Accuracy
lib:AddRecipe(44498, 60767, nil) -- Enchant Bracers - Superior Spellpower
lib:AddRecipe(44944, 62256, nil) -- Enchant Bracers - Major Stamina
lib:AddRecipe(44945, 62257, nil) -- Enchant Weapon - Titanguard
lib:AddRecipe(45050, 15596, 11811) -- Smoking Heart of the Mountain
lib:AddRecipe(45059, 62948, nil) -- Enchant Staff - Greater Spellpower
lib:AddRecipe(45060, 62959, nil) -- Enchant Staff - Spellpower
lib:AddRecipe(45628, 63746, nil) -- Enchant Boots - Lesser Accuracy
lib:AddRecipe(46027, 64441, nil) -- Enchant Weapon - Blade Ward
lib:AddRecipe(46348, 64579, nil) -- Enchant Weapon - Blood Draining
lib:AddRecipe(50406, 71692, nil) -- Enchant Gloves - Angler
lib:AddRecipe(186683, 27927, nil) -- Enchant Ring - Stats
-- Engineering
lib:AddRecipe(4408, 3928, 4401) -- Mechanical Squirrel Box
lib:AddRecipe(4409, 3933, 4367) -- Small Seaforium Charge
lib:AddRecipe(4410, 3940, 4373) -- Shadow Goggles
lib:AddRecipe(4411, 3944, 4376) -- Flame Deflector
lib:AddRecipe(4412, 3954, 4383) -- Moonsight Rifle
lib:AddRecipe(4413, 3959, 4388) -- Discombobulator Ray
lib:AddRecipe(4414, 3960, 4403) -- Portable Bronze Mortar
lib:AddRecipe(4415, 3966, 4393) -- Craftsman's Monocle
lib:AddRecipe(4416, 3968, 4395) -- Goblin Land Mine
lib:AddRecipe(4417, 3972, 4398) -- Large Seaforium Charge
lib:AddRecipe(6672, 8243, 4852) -- Flash Bomb
lib:AddRecipe(6716, 8339, 6714) -- EZ-Thro Dynamite
lib:AddRecipe(7192, 8895, 7189) -- Goblin Rocket Boots
lib:AddRecipe(7560, 9269, 7506) -- Gnomish Universal Remote
lib:AddRecipe(7561, 9273, 7148) -- Goblin Jumper Cables
lib:AddRecipe(7742, 3971, 4397) -- Gnomish Cloaking Device
lib:AddRecipe(10601, 12587, 10499) -- Bright-Eye Goggles
lib:AddRecipe(10602, 12597, 10546) -- Deadly Scope
lib:AddRecipe(10603, 12607, 10501) -- Catseye Ultra Goggles
lib:AddRecipe(10604, 12614, 10510) -- Mithril Heavy-bore Rifle
lib:AddRecipe(10605, 12615, 10502) -- Spellpower Goggles Xtreme
lib:AddRecipe(10606, 12616, 10518) -- Parachute Cloak
lib:AddRecipe(10607, 12617, 10506) -- Deepdive Helmet
lib:AddRecipe(10608, 12620, 10548) -- Sniper Scope
lib:AddRecipe(10609, 12624, 10576) -- Mithril Mechanical Dragonling
lib:AddRecipe(11827, 15633, 11826) -- Lil' Smoky
lib:AddRecipe(11828, 15628, 11825) -- Pet Bombling
lib:AddRecipe(13308, 3957, 4386) -- Ice Deflector
lib:AddRecipe(13309, 3939, 4372) -- Lovingly Crafted Boomstick
lib:AddRecipe(13310, 3979, 4407) -- Accurate Scope
lib:AddRecipe(13311, 3969, 4396) -- Mechanical Dragonling
lib:AddRecipe(14639, 3952, 4381) -- Minor Recombobulator
lib:AddRecipe(16041, 19790, 15993) -- Thorium Grenade
lib:AddRecipe(16042, 19791, 15994) -- Thorium Widget
lib:AddRecipe(16043, 19792, 15995) -- Thorium Rifle
lib:AddRecipe(16044, 19793, 15996) -- Lifelike Mechanical Toad
lib:AddRecipe(16045, 19794, 15999) -- Spellpower Goggles Xtreme Plus
lib:AddRecipe(16046, 19814, 16023) -- Masterwork Target Dummy
lib:AddRecipe(16047, 19795, 16000) -- Thorium Tube
lib:AddRecipe(16048, 19796, 16004) -- Dark Iron Rifle
lib:AddRecipe(16049, 19799, 16005) -- Dark Iron Bomb
lib:AddRecipe(16050, 19815, 16006) -- Delicate Arcanite Converter
lib:AddRecipe(16051, 19800, 15997) -- Thorium Shells
lib:AddRecipe(16052, 19819, 16009) -- Voice Amplification Modulator
lib:AddRecipe(16053, 19825, 16008) -- Master Engineer's Goggles
lib:AddRecipe(16054, 19830, 16022) -- Arcanite Dragonling
lib:AddRecipe(16055, 19831, 16040) -- Arcane Bomb
lib:AddRecipe(16056, 19833, 16007) -- Flawless Arcanite Rifle
lib:AddRecipe(17720, 21940, 17716) -- Snowmaster 9000
lib:AddRecipe(18235, 22704, 18232) -- Field Repair Bot 74A
lib:AddRecipe(18290, 22793, 18283) -- Biznicks 247x128 Accurascope
lib:AddRecipe(18291, 22797, 18168) -- Force Reactive Disk
lib:AddRecipe(18292, 22795, 18282) -- Core Marksman Rifle
lib:AddRecipe(18647, 23066, 9318) -- Red Firework
lib:AddRecipe(18648, 23068, 9313) -- Green Firework
lib:AddRecipe(18649, 23067, 9312) -- Blue Firework
lib:AddRecipe(18650, 23069, 18588) -- EZ-Thro Dynamite II
lib:AddRecipe(18651, 23071, 18631) -- Truesilver Transformer
lib:AddRecipe(18652, 23077, 18634) -- Gyrofreeze Ice Reflector
lib:AddRecipe(18653, 23078, 18587) -- Goblin Jumper Cables XL
lib:AddRecipe(18654, 23096, 18645) -- Gnomish Alarm-o-Bot
lib:AddRecipe(18655, 23079, 18637) -- Major Recombobulator
lib:AddRecipe(18656, 23080, 18594) -- Powerful Seaforium Charge
lib:AddRecipe(18657, 23081, 18638) -- Hyper-Radiant Flame Reflector
lib:AddRecipe(18658, 23082, 18639) -- Ultra-Flash Shadow Reflector
lib:AddRecipe(18661, 23129, 18660) -- World Enlarger
lib:AddRecipe(19027, 23507, 19026) -- Snake Burst Firework
lib:AddRecipe(20000, 24356, 19999) -- Bloodvine Goggles
lib:AddRecipe(20001, 24357, 19998) -- Bloodvine Lens
lib:AddRecipe(21724, 26416, 21558) -- Small Blue Rocket
lib:AddRecipe(21725, 26417, 21559) -- Small Green Rocket
lib:AddRecipe(21726, 26418, 21557) -- Small Red Rocket
lib:AddRecipe(21727, 26420, 21589) -- Large Blue Rocket
lib:AddRecipe(21728, 26421, 21590) -- Large Green Rocket
lib:AddRecipe(21729, 26422, 21592) -- Large Red Rocket
lib:AddRecipe(21730, 26423, 21571) -- Blue Rocket Cluster
lib:AddRecipe(21731, 26424, 21574) -- Green Rocket Cluster
lib:AddRecipe(21732, 26425, 21576) -- Red Rocket Cluster
lib:AddRecipe(21733, 26426, 21714) -- Large Blue Rocket Cluster
lib:AddRecipe(21734, 26427, 21716) -- Large Green Rocket Cluster
lib:AddRecipe(21735, 26428, 21718) -- Large Red Rocket Cluster
lib:AddRecipe(21737, 26443, 21570) -- Firework Cluster Launcher
lib:AddRecipe(21738, 26442, 21569) -- Firework Launcher
lib:AddRecipe(22729, 28327, 22728) -- Steam Tonk Controller
lib:AddRecipe(23799, 30313, 23746) -- Adamantite Rifle
lib:AddRecipe(23800, 30314, 23747) -- Felsteel Boomstick
lib:AddRecipe(23802, 30315, 23748) -- Ornate Khorium Rifle
lib:AddRecipe(23803, 30316, 23758) -- Cogspinner Goggles
lib:AddRecipe(23804, 30317, 23761) -- Power Amplification Goggles
lib:AddRecipe(23805, 30318, 23762) -- Ultra-Spectropic Detection Goggles
lib:AddRecipe(23806, 30325, 23763) -- Hyper-Vision Goggles
lib:AddRecipe(23807, 30329, 23764) -- Adamantite Scope
lib:AddRecipe(23808, 30332, 23765) -- Khorium Scope
lib:AddRecipe(23809, 30334, 23766) -- Stabilized Eternium Scope
lib:AddRecipe(23810, 30337, 23767) -- Crashin' Thrashin' Robot
lib:AddRecipe(23811, 30341, 23768) -- White Smoke Flare
lib:AddRecipe(23812, 30342, 23769) -- Red Smoke Flare
lib:AddRecipe(23813, 30343, 23770) -- Blue Smoke Flare
lib:AddRecipe(23814, 30344, 23771) -- Green Smoke Flare
lib:AddRecipe(23815, 30347, 34504) -- Adamantite Shell Machine
lib:AddRecipe(23816, 30348, 23774) -- Fel Iron Toolbox
lib:AddRecipe(23817, 30349, 23775) -- Titanium Toolbox
lib:AddRecipe(23874, 30547, 23819) -- Elemental Seaforium Charge
lib:AddRecipe(23882, 30549, 23820) -- Critter Enlarger
lib:AddRecipe(23883, 30551, 33092) -- Healing Potion Injector
lib:AddRecipe(23884, 30552, 33093) -- Mana Potion Injector
lib:AddRecipe(23887, 30556, 23824) -- Rocket Boots Xtreme
lib:AddRecipe(23888, 30548, 23821) -- Zapthrottle Mote Extractor
lib:AddRecipe(25887, 32814, 25886) -- Purple Smoke Flare
lib:AddRecipe(32381, 39895, 7191) -- Fused Wiring
lib:AddRecipe(33804, 43676, 20475) -- Adamantite Arrow Maker
lib:AddRecipe(34114, 44391, 34113) -- Field Repair Bot 110G
lib:AddRecipe(35186, 46111, 34847) -- Annihilator Holo-Gogs
lib:AddRecipe(35187, 46107, 35185) -- Justicebringer 3000 Specs
lib:AddRecipe(35189, 46108, 35181) -- Powerheal 9000 Lens
lib:AddRecipe(35190, 46109, 35182) -- Hyper-Magnified Moon Specs
lib:AddRecipe(35191, 46106, 35183) -- Wonderheal XT68 Shades
lib:AddRecipe(35192, 46110, 35184) -- Primal-Attuned Goggles
lib:AddRecipe(35193, 46112, 34355) -- Lightning Etched Specs
lib:AddRecipe(35194, 46113, 34356) -- Surestrike Goggles v3.0
lib:AddRecipe(35195, 46114, 34354) -- Mayhem Projection Goggles
lib:AddRecipe(35196, 46115, 34357) -- Hard Khorium Goggles
lib:AddRecipe(35197, 46116, 34353) -- Quad Deathblow X44 Goggles
lib:AddRecipe(35310, 30551, 33092) -- Healing Potion Injector
lib:AddRecipe(35311, 30552, 33093) -- Mana Potion Injector
lib:AddRecipe(35582, 46697, 35581) -- Rocket Boots Xtreme Lite
lib:AddRecipe(40776, 54736, nil) -- Personal Electromagnetic Pulse Generator
lib:AddRecipe(41091, 54998, nil) -- Hand-Mounted Pyro Rocket
lib:AddRecipe(41111, 55002, nil) -- Flexweave Underlay
lib:AddRecipe(41118, 55016, nil) -- Nitro Boosts
lib:AddRecipe(44502, 60866, 41508) -- Mechano-hog
lib:AddRecipe(44503, 60867, 44413) -- Mekgineer's Chopper
lib:AddRecipe(44918, 26443, 21570) -- Firework Cluster Launcher
lib:AddRecipe(44919, 26442, 21569) -- Firework Launcher
lib:AddRecipe(49050, 68067, 49040) -- Jeeves
lib:AddRecipe(52022, 72952, 52020) -- Shatter Rounds
lib:AddRecipe(52023, 72953, 52021) -- Iceblade Arrow
-- First Aid
lib:AddRecipe(6454, 7935, 6453) -- Strong Anti-Venom
lib:AddRecipe(16112, 7929, 6451) -- Heavy Silk Bandage
lib:AddRecipe(16113, 10840, 8544) -- Mageweave Bandage
lib:AddRecipe(19442, 23787, 19440) -- Powerful Anti-Venom
lib:AddRecipe(21992, 27032, 21990) -- Netherweave Bandage
lib:AddRecipe(21993, 27033, 21991) -- Heavy Netherweave Bandage
lib:AddRecipe(39152, 45546, 34722) -- Heavy Frostweave Bandage
-- Inscription
lib:AddRecipe(46108, 64051, 45854) -- Rituals of the New Moon
lib:AddRecipe(50166, 71101, 50045) -- Glyph of Eternal Water
lib:AddRecipe(50167, 71015, 50125) -- Glyph of Rapid Rejuvenation
lib:AddRecipe(50168, 71102, 50077) -- Glyph of Quick Decay
-- Jewelcrafting
lib:AddRecipe(20854, 25339, 20830) -- Amulet of the Moon
lib:AddRecipe(20855, 25323, 20833) -- Wicked Moonstone Ring
lib:AddRecipe(20856, 25320, 20831) -- Heavy Golden Necklace of Battle
lib:AddRecipe(20970, 25610, 20950) -- Pendant of the Agate Shield
lib:AddRecipe(20971, 25612, 20954) -- Heavy Iron Knuckles
lib:AddRecipe(20972, 25614, 20956) -- Silver Rose Pendant
lib:AddRecipe(20973, 25617, 20958) -- Blazing Citrine Ring
lib:AddRecipe(20974, 25618, 20966) -- Jade Pendant of Blasting
lib:AddRecipe(20975, 25619, 20959) -- The Jade Eye
lib:AddRecipe(20976, 25622, 20967) -- Citrine Pendant of Golden Healing
lib:AddRecipe(21940, 26873, 21756) -- Figurine - Golden Hare
lib:AddRecipe(21941, 26875, 21758) -- Figurine - Black Pearl Panther
lib:AddRecipe(21942, 26878, 20969) -- Ruby Crown of Restoration
lib:AddRecipe(21943, 26881, 21760) -- Figurine - Truesilver Crab
lib:AddRecipe(21944, 26882, 21763) -- Figurine - Truesilver Boar
lib:AddRecipe(21945, 26887, 21754) -- The Aquamarine Ward
lib:AddRecipe(21947, 26896, 21753) -- Gem Studded Band
lib:AddRecipe(21948, 26897, 21766) -- Opal Necklace of Impact
lib:AddRecipe(21949, 26900, 21769) -- Figurine - Ruby Serpent
lib:AddRecipe(21952, 26906, 21774) -- Emerald Crown of Destruction
lib:AddRecipe(21953, 26909, 21777) -- Figurine - Emerald Owl
lib:AddRecipe(21954, 26910, 21778) -- Ring of Bitter Shadows
lib:AddRecipe(21955, 26912, 21784) -- Figurine - Black Diamond Crab
lib:AddRecipe(21956, 26914, 21789) -- Figurine - Dark Iron Scorpid
lib:AddRecipe(21957, 26915, 21792) -- Necklace of the Diamond Tower
lib:AddRecipe(21958, 26918, 21793) -- Arcanite Sword Pendant
lib:AddRecipe(21959, 26920, 21780) -- Blood Crown
lib:AddRecipe(23130, 28903, 23094) -- Teardrop Blood Garnet
lib:AddRecipe(23131, 28905, 23095) -- Bold Blood Garnet
lib:AddRecipe(23133, 28906, 23096) -- Runed Blood Garnet
lib:AddRecipe(23134, 28907, 23097) -- Delicate Blood Garnet
lib:AddRecipe(23135, 28910, 23098) -- Inscribed Flame Spessarite
lib:AddRecipe(23136, 28912, 23099) -- Luminous Flame Spessarite
lib:AddRecipe(23137, 28914, 23100) -- Glinting Flame Spessarite
lib:AddRecipe(23138, 28915, 23101) -- Potent Flame Spessarite
lib:AddRecipe(23140, 28916, 23103) -- Radiant Deep Peridot
lib:AddRecipe(23141, 28917, 23104) -- Jagged Deep Peridot
lib:AddRecipe(23142, 28918, 23105) -- Enduring Deep Peridot
lib:AddRecipe(23143, 28924, 23106) -- Dazzling Deep Peridot
lib:AddRecipe(23144, 28925, 23108) -- Glowing Shadow Draenite
lib:AddRecipe(23145, 28927, 23109) -- Royal Shadow Draenite
lib:AddRecipe(23146, 28933, 23110) -- Shifting Shadow Draenite
lib:AddRecipe(23147, 28936, 23111) -- Sovereign Shadow Draenite
lib:AddRecipe(23148, 28938, 23113) -- Brilliant Golden Draenite
lib:AddRecipe(23149, 28944, 23114) -- Gleaming Golden Draenite
lib:AddRecipe(23150, 28947, 23115) -- Thick Golden Draenite
lib:AddRecipe(23151, 28948, 23116) -- Rigid Golden Draenite
lib:AddRecipe(23152, 28950, 23118) -- Solid Azure Moonstone
lib:AddRecipe(23153, 28953, 23119) -- Sparkling Azure Moonstone
lib:AddRecipe(23154, 28955, 23120) -- Stormy Azure Moonstone
lib:AddRecipe(23155, 28957, 23121) -- Lustrous Azure Moonstone
lib:AddRecipe(24158, 31053, 24079) -- Khorium Band of Shadows
lib:AddRecipe(24159, 31054, 24080) -- Khorium Band of Frost
lib:AddRecipe(24160, 31055, 24082) -- Khorium Inferno Band
lib:AddRecipe(24161, 31056, 24085) -- Khorium Band of Leaves
lib:AddRecipe(24162, 31057, 24086) -- Arcane Khorium Band
lib:AddRecipe(24163, 31058, 24087) -- Heavy Felsteel Ring
lib:AddRecipe(24164, 31060, 24088) -- Delicate Eternium Ring
lib:AddRecipe(24165, 31061, 24089) -- Blazing Eternium Band
lib:AddRecipe(24166, 31067, 24106) -- Thick Felsteel Necklace
lib:AddRecipe(24167, 31068, 24110) -- Living Ruby Pendant
lib:AddRecipe(24168, 31070, 24114) -- Braided Eternium Chain
lib:AddRecipe(24169, 31071, 24116) -- Eye of the Night
lib:AddRecipe(24170, 31072, 24117) -- Embrace of the Dawn
lib:AddRecipe(24171, 31076, 24121) -- Chain of the Twilight Owl
lib:AddRecipe(24172, 31077, 24122) -- Coronet of Verdant Flame
lib:AddRecipe(24173, 31078, 24123) -- Circlet of Arcane Might
lib:AddRecipe(24174, 31062, 24092) -- Pendant of Frozen Flame
lib:AddRecipe(24175, 31063, 24093) -- Pendant of Thawing
lib:AddRecipe(24176, 31064, 24095) -- Pendant of Withering
lib:AddRecipe(24177, 31065, 24097) -- Pendant of Shadow's End
lib:AddRecipe(24178, 31066, 24098) -- Pendant of the Null Rune
lib:AddRecipe(24179, 31079, 24124) -- Figurine - Felsteel Boar
lib:AddRecipe(24180, 31080, 24125) -- Figurine - Dawnstone Crab
lib:AddRecipe(24181, 31081, 24126) -- Figurine - Living Ruby Serpent
lib:AddRecipe(24182, 31082, 24127) -- Figurine - Talasite Owl
lib:AddRecipe(24183, 31083, 24128) -- Figurine - Nightseye Panther
lib:AddRecipe(24192, 31089, 24031) -- Bright Living Ruby
lib:AddRecipe(24193, 31084, 24027) -- Bold Living Ruby
lib:AddRecipe(24194, 31085, 24028) -- Delicate Living Ruby
lib:AddRecipe(24195, 31087, 24029) -- Teardrop Living Ruby
lib:AddRecipe(24196, 31088, 24030) -- Runed Living Ruby
lib:AddRecipe(24197, 31090, 24032) -- Subtle Living Ruby
lib:AddRecipe(24198, 31091, 24036) -- Flashing Living Ruby
lib:AddRecipe(24199, 31092, 24033) -- Solid Star of Elune
lib:AddRecipe(24200, 31149, 24035) -- Sparkling Star of Elune
lib:AddRecipe(24201, 31094, 24037) -- Lustrous Star of Elune
lib:AddRecipe(24202, 31095, 24039) -- Stormy Star of Elune
lib:AddRecipe(24203, 31096, 24047) -- Brilliant Dawnstone
lib:AddRecipe(24204, 31097, 24048) -- Smooth Dawnstone
lib:AddRecipe(24205, 31098, 24051) -- Rigid Dawnstone
lib:AddRecipe(24206, 31099, 24050) -- Gleaming Dawnstone
lib:AddRecipe(24207, 31100, 24052) -- Thick Dawnstone
lib:AddRecipe(24208, 31101, 24053) -- Mystic Dawnstone
lib:AddRecipe(24209, 31102, 24054) -- Sovereign Nightseye
lib:AddRecipe(24210, 31103, 24055) -- Shifting Nightseye
lib:AddRecipe(24211, 31104, 24056) -- Glowing Nightseye
lib:AddRecipe(24212, 31105, 24057) -- Royal Nightseye
lib:AddRecipe(24213, 31106, 24058) -- Inscribed Noble Topaz
lib:AddRecipe(24214, 31107, 24059) -- Potent Noble Topaz
lib:AddRecipe(24215, 31108, 24060) -- Luminous Noble Topaz
lib:AddRecipe(24216, 31109, 24061) -- Glinting Noble Topaz
lib:AddRecipe(24217, 31110, 24062) -- Enduring Talasite
lib:AddRecipe(24218, 31111, 24066) -- Radiant Talasite
lib:AddRecipe(24219, 31112, 24065) -- Dazzling Talasite
lib:AddRecipe(24220, 31113, 24067) -- Jagged Talasite
lib:AddRecipe(25888, 32810, 25884) -- Primal Stone Statue
lib:AddRecipe(25902, 32866, 25896) -- Powerful Earthstorm Diamond
lib:AddRecipe(25903, 32867, 25897) -- Bracing Earthstorm Diamond
lib:AddRecipe(25904, 32870, 25901) -- Insightful Earthstorm Diamond
lib:AddRecipe(25905, 32868, 25898) -- Tenacious Earthstorm Diamond
lib:AddRecipe(25906, 32869, 25899) -- Brutal Earthstorm Diamond
lib:AddRecipe(25907, 32871, 25890) -- Destructive Skyfire Diamond
lib:AddRecipe(25908, 32873, 25894) -- Swift Skyfire Diamond
lib:AddRecipe(25909, 32872, 25893) -- Mystical Skyfire Diamond
lib:AddRecipe(25910, 32874, 25895) -- Enigmatic Skyfire Diamond
lib:AddRecipe(28291, 34069, 28290) -- Smooth Golden Draenite
lib:AddRecipe(28596, 34590, 28595) -- Bright Blood Garnet
lib:AddRecipe(30826, 37855, 30825) -- Ring of Arcane Shielding
lib:AddRecipe(31358, 31080, 24125) -- Figurine - Dawnstone Crab
lib:AddRecipe(31359, 28918, 23105) -- Enduring Deep Peridot
lib:AddRecipe(31401, 38503, 31398) -- The Frozen Eye
lib:AddRecipe(31402, 38504, 31399) -- The Natural Ward
lib:AddRecipe(31870, 39451, 31860) -- Great Golden Draenite
lib:AddRecipe(31871, 39455, 31862) -- Balanced Shadow Draenite
lib:AddRecipe(31872, 39458, 31864) -- Infused Shadow Draenite
lib:AddRecipe(31873, 39466, 31866) -- Veiled Flame Spessarite
lib:AddRecipe(31874, 39467, 31869) -- Wicked Flame Spessarite
lib:AddRecipe(31875, 39452, 31861) -- Great Dawnstone
lib:AddRecipe(31876, 39463, 31863) -- Balanced Nightseye
lib:AddRecipe(31877, 39462, 31865) -- Infused Nightseye
lib:AddRecipe(31878, 39470, 31867) -- Veiled Noble Topaz
lib:AddRecipe(31879, 39471, 31868) -- Wicked Noble Topaz
lib:AddRecipe(32274, 39705, 32193) -- Bold Crimson Spinel
lib:AddRecipe(32277, 39706, 32194) -- Delicate Crimson Spinel
lib:AddRecipe(32281, 39710, 32195) -- Teardrop Crimson Spinel
lib:AddRecipe(32282, 39711, 32196) -- Runed Crimson Spinel
lib:AddRecipe(32283, 39712, 32197) -- Bright Crimson Spinel
lib:AddRecipe(32284, 39713, 32198) -- Subtle Crimson Spinel
lib:AddRecipe(32285, 39714, 32199) -- Flashing Crimson Spinel
lib:AddRecipe(32286, 39715, 32200) -- Solid Empyrean Sapphire
lib:AddRecipe(32287, 39716, 32201) -- Sparkling Empyrean Sapphire
lib:AddRecipe(32288, 39717, 32202) -- Lustrous Empyrean Sapphire
lib:AddRecipe(32289, 39718, 32203) -- Stormy Empyrean Sapphire
lib:AddRecipe(32290, 39719, 32204) -- Brilliant Lionseye
lib:AddRecipe(32291, 39720, 32205) -- Smooth Lionseye
lib:AddRecipe(32292, 39721, 32206) -- Rigid Lionseye
lib:AddRecipe(32293, 39722, 32207) -- Gleaming Lionseye
lib:AddRecipe(32294, 39723, 32208) -- Thick Lionseye
lib:AddRecipe(32295, 39724, 32209) -- Mystic Lionseye
lib:AddRecipe(32296, 39725, 32210) -- Great Lionseye
lib:AddRecipe(32297, 39727, 32211) -- Sovereign Shadowsong Amethyst
lib:AddRecipe(32298, 39728, 32212) -- Shifting Shadowsong Amethyst
lib:AddRecipe(32299, 39729, 32213) -- Balanced Shadowsong Amethyst
lib:AddRecipe(32300, 39730, 32214) -- Infused Shadowsong Amethyst
lib:AddRecipe(32301, 39731, 32215) -- Glowing Shadowsong Amethyst
lib:AddRecipe(32302, 39732, 32216) -- Royal Shadowsong Amethyst
lib:AddRecipe(32303, 39733, 32217) -- Inscribed Pyrestone
lib:AddRecipe(32304, 39734, 32218) -- Potent Pyrestone
lib:AddRecipe(32305, 39735, 32219) -- Luminous Pyrestone
lib:AddRecipe(32306, 39736, 32220) -- Glinting Pyrestone
lib:AddRecipe(32307, 39737, 32221) -- Veiled Pyrestone
lib:AddRecipe(32308, 39738, 32222) -- Wicked Pyrestone
lib:AddRecipe(32309, 39739, 32223) -- Enduring Seaspray Emerald
lib:AddRecipe(32310, 39740, 32224) -- Radiant Seaspray Emerald
lib:AddRecipe(32311, 39741, 32225) -- Dazzling Seaspray Emerald
lib:AddRecipe(32312, 39742, 32226) -- Jagged Seaspray Emerald
lib:AddRecipe(32411, 39963, 32410) -- Thundering Skyfire Diamond
lib:AddRecipe(32412, 39961, 32409) -- Relentless Earthstorm Diamond
lib:AddRecipe(33155, 42588, 33134) -- Kailee's Rose
lib:AddRecipe(33156, 42589, 33131) -- Crimson Sun
lib:AddRecipe(33157, 42590, 33135) -- Falling Star
lib:AddRecipe(33158, 42591, 33143) -- Stone of Blades
lib:AddRecipe(33159, 42592, 33140) -- Blood of Amber
lib:AddRecipe(33160, 42593, 33144) -- Facet of Eternity
lib:AddRecipe(33305, 42558, 33133) -- Don Julio's Heart
lib:AddRecipe(33622, 39961, 32409) -- Relentless Earthstorm Diamond
lib:AddRecipe(33783, 43493, 33782) -- Steady Talasite
lib:AddRecipe(34221, 44794, 34220) -- Chaotic Skyfire Diamond
lib:AddRecipe(34689, 44794, 34220) -- Chaotic Skyfire Diamond
lib:AddRecipe(35198, 46122, 34362) -- Loop of Forged Power
lib:AddRecipe(35199, 46123, 34363) -- Ring of Flowing Life
lib:AddRecipe(35200, 46124, 34361) -- Hard Khorium Band
lib:AddRecipe(35201, 46125, 34359) -- Pendant of Sunfire
lib:AddRecipe(35202, 46126, 34360) -- Amulet of Flowing Life
lib:AddRecipe(35203, 46127, 34358) -- Hard Khorium Choker
lib:AddRecipe(35238, 39729, 32213) -- Balanced Shadowsong Amethyst
lib:AddRecipe(35239, 39731, 32215) -- Glowing Shadowsong Amethyst
lib:AddRecipe(35240, 39730, 32214) -- Infused Shadowsong Amethyst
lib:AddRecipe(35241, 39732, 32216) -- Royal Shadowsong Amethyst
lib:AddRecipe(35242, 39728, 32212) -- Shifting Shadowsong Amethyst
lib:AddRecipe(35243, 39727, 32211) -- Sovereign Shadowsong Amethyst
lib:AddRecipe(35244, 39705, 32193) -- Bold Crimson Spinel
lib:AddRecipe(35245, 39712, 32197) -- Bright Crimson Spinel
lib:AddRecipe(35246, 39706, 32194) -- Delicate Crimson Spinel
lib:AddRecipe(35247, 39714, 32199) -- Flashing Crimson Spinel
lib:AddRecipe(35248, 39711, 32196) -- Runed Crimson Spinel
lib:AddRecipe(35249, 39713, 32198) -- Subtle Crimson Spinel
lib:AddRecipe(35250, 39710, 32195) -- Teardrop Crimson Spinel
lib:AddRecipe(35251, 39741, 32225) -- Dazzling Seaspray Emerald
lib:AddRecipe(35252, 39739, 32223) -- Enduring Seaspray Emerald
lib:AddRecipe(35253, 39742, 32226) -- Jagged Seaspray Emerald
lib:AddRecipe(35254, 39740, 32224) -- Radiant Seaspray Emerald
lib:AddRecipe(35255, 39719, 32204) -- Brilliant Lionseye
lib:AddRecipe(35256, 39722, 32207) -- Gleaming Lionseye
lib:AddRecipe(35257, 39725, 32210) -- Great Lionseye
lib:AddRecipe(35258, 39724, 32209) -- Mystic Lionseye
lib:AddRecipe(35259, 39721, 32206) -- Rigid Lionseye
lib:AddRecipe(35260, 39720, 32205) -- Smooth Lionseye
lib:AddRecipe(35261, 39723, 32208) -- Thick Lionseye
lib:AddRecipe(35262, 39717, 32202) -- Lustrous Empyrean Sapphire
lib:AddRecipe(35263, 39715, 32200) -- Solid Empyrean Sapphire
lib:AddRecipe(35264, 39716, 32201) -- Sparkling Empyrean Sapphire
lib:AddRecipe(35265, 39718, 32203) -- Stormy Empyrean Sapphire
lib:AddRecipe(35266, 39736, 32220) -- Glinting Pyrestone
lib:AddRecipe(35267, 39733, 32217) -- Inscribed Pyrestone
lib:AddRecipe(35268, 39735, 32219) -- Luminous Pyrestone
lib:AddRecipe(35269, 39734, 32218) -- Potent Pyrestone
lib:AddRecipe(35270, 39737, 32221) -- Veiled Pyrestone
lib:AddRecipe(35271, 39738, 32222) -- Wicked Pyrestone
lib:AddRecipe(35304, 31092, 24033) -- Solid Star of Elune
lib:AddRecipe(35305, 31088, 24030) -- Runed Living Ruby
lib:AddRecipe(35306, 31089, 24031) -- Bright Living Ruby
lib:AddRecipe(35307, 31098, 24051) -- Rigid Dawnstone
lib:AddRecipe(35322, 46403, 35315) -- Quick Dawnstone
lib:AddRecipe(35323, 46404, 35316) -- Reckless Noble Topaz
lib:AddRecipe(35325, 46405, 35318) -- Forceful Talasite
lib:AddRecipe(35502, 46597, 35501) -- Eternal Earthstorm Diamond
lib:AddRecipe(35505, 46601, 35503) -- Ember Skyfire Diamond
lib:AddRecipe(35533, 46126, 34360) -- Amulet of Flowing Life
lib:AddRecipe(35534, 46124, 34361) -- Hard Khorium Band
lib:AddRecipe(35535, 46127, 34358) -- Hard Khorium Choker
lib:AddRecipe(35536, 46122, 34362) -- Loop of Forged Power
lib:AddRecipe(35537, 46125, 34359) -- Pendant of Sunfire
lib:AddRecipe(35538, 46123, 34363) -- Ring of Flowing Life
lib:AddRecipe(35695, 46775, 35693) -- Figurine - Empyrean Tortoise
lib:AddRecipe(35696, 46776, 35694) -- Figurine - Khorium Boar
lib:AddRecipe(35697, 46777, 35700) -- Figurine - Crimson Serpent
lib:AddRecipe(35698, 46778, 35702) -- Figurine - Shadowsong Panther
lib:AddRecipe(35699, 46779, 35703) -- Figurine - Seaspray Albatross
lib:AddRecipe(35708, 46803, 35707) -- Regal Nightseye
lib:AddRecipe(35762, 47055, 35760) -- Reckless Pyrestone
lib:AddRecipe(35763, 47056, 35761) -- Quick Lionseye
lib:AddRecipe(35764, 47054, 35758) -- Steady Seaspray Emerald
lib:AddRecipe(35765, 47053, 35759) -- Forceful Seaspray Emerald
lib:AddRecipe(35766, 47054, 35758) -- Steady Seaspray Emerald
lib:AddRecipe(35767, 47055, 35760) -- Reckless Pyrestone
lib:AddRecipe(35768, 47056, 35761) -- Quick Lionseye
lib:AddRecipe(35769, 47053, 35759) -- Forceful Seaspray Emerald
lib:AddRecipe(37504, 48789, 37503) -- Purified Shadowsong Amethyst
lib:AddRecipe(41403, 55396, 41401) -- Insightful Earthsiege Diamond
lib:AddRecipe(41404, 55397, 41395) -- Bracing Earthsiege Diamond
lib:AddRecipe(41405, 55398, 41396) -- Eternal Earthsiege Diamond
lib:AddRecipe(41406, 55399, 41397) -- Powerful Earthsiege Diamond
lib:AddRecipe(41407, 55400, 41398) -- Relentless Earthsiege Diamond
lib:AddRecipe(41408, 55401, 41380) -- Austere Earthsiege Diamond
lib:AddRecipe(41409, 55402, 41381) -- Persistent Earthsiege Diamond
lib:AddRecipe(41410, 55403, 41382) -- Trenchant Earthsiege Diamond
lib:AddRecipe(41411, 55404, 41385) -- Invigorating Earthsiege Diamond
lib:AddRecipe(41412, 55405, 41389) -- Beaming Earthsiege Diamond
lib:AddRecipe(41413, 55407, 41376) -- Revitalizing Skyflare Diamond
lib:AddRecipe(41414, 55384, 41377) -- Effulgent Skyflare Diamond
lib:AddRecipe(41415, 55386, 41375) -- Tireless Skyflare Diamond
lib:AddRecipe(41416, 55387, 41378) -- Forlorn Skyflare Diamond
lib:AddRecipe(41417, 55388, 41379) -- Impassive Skyflare Diamond
lib:AddRecipe(41418, 55389, 41285) -- Chaotic Skyflare Diamond
lib:AddRecipe(41419, 55390, 41307) -- Destructive Skyflare Diamond
lib:AddRecipe(41420, 55392, 41333) -- Ember Skyflare Diamond
lib:AddRecipe(41421, 55393, 41335) -- Enigmatic Skyflare Diamond
lib:AddRecipe(41422, 55394, 41339) -- Swift Skyflare Diamond
lib:AddRecipe(41423, 55395, 41400) -- Thundering Skyflare Diamond
lib:AddRecipe(41559, 53857, 39917) -- Mystic Sun Crystal
lib:AddRecipe(41560, 53943, 39932) -- Stormy Chalcedony
lib:AddRecipe(41561, 53885, 39959) -- Reckless Huge Citrine
lib:AddRecipe(41562, 53877, 39952) -- Deadly Huge Citrine
lib:AddRecipe(41563, 53884, 39958) -- Durable Huge Citrine
lib:AddRecipe(41564, 53888, 39962) -- Empowered Huge Citrine
lib:AddRecipe(41565, 53879, 39954) -- Lucent Huge Citrine
lib:AddRecipe(41566, 53875, 39950) -- Resplendent Huge Citrine
lib:AddRecipe(41567, 53917, 39975) -- Vivid Dark Jade
lib:AddRecipe(41568, 53921, 39979) -- Seer's Dark Jade
lib:AddRecipe(41569, 53933, 39992) -- Shattered Dark Jade
lib:AddRecipe(41570, 53932, 39991) -- Tense Dark Jade
lib:AddRecipe(41571, 53924, 39982) -- Turbid Dark Jade
lib:AddRecipe(41572, 53919, 39977) -- Steady Dark Jade
lib:AddRecipe(41573, 53929, 39988) -- Opaque Dark Jade
lib:AddRecipe(41574, 53869, 39939) -- Defender's Shadow Crystal
lib:AddRecipe(41575, 53865, 39945) -- Mysterious Shadow Crystal
lib:AddRecipe(41576, 53830, 39996) -- Bold Scarlet Ruby
lib:AddRecipe(41577, 53945, 39997) -- Delicate Scarlet Ruby
lib:AddRecipe(41578, 53949, 40001) -- Flashing Scarlet Ruby
lib:AddRecipe(41579, 53961, 40017) -- Quick Autumn's Glow
lib:AddRecipe(41580, 53958, 40014) -- Rigid Autumn's Glow
lib:AddRecipe(41581, 53954, 40010) -- Lustrous Sky Sapphire
lib:AddRecipe(41582, 53980, 40044) -- Glinting Monarch Topaz
lib:AddRecipe(41686, 53984, 40048) -- Potent Monarch Topaz
lib:AddRecipe(41687, 53991, 40055) -- Stark Monarch Topaz
lib:AddRecipe(41688, 53985, 40049) -- Veiled Monarch Topaz
lib:AddRecipe(41689, 53983, 40047) -- Luminous Monarch Topaz
lib:AddRecipe(41690, 53987, 40051) -- Reckless Monarch Topaz
lib:AddRecipe(41692, 54011, 40105) -- Energized Forest Emerald
lib:AddRecipe(41693, 54001, 40091) -- Forceful Forest Emerald
lib:AddRecipe(41694, 54006, 40104) -- Intricate Forest Emerald
lib:AddRecipe(41696, 54009, 40100) -- Lambent Forest Emerald
lib:AddRecipe(41697, 53998, 40089) -- Enduring Forest Emerald
lib:AddRecipe(41698, 53997, 40088) -- Vivid Forest Emerald
lib:AddRecipe(41699, 54002, 40092) -- Seer's Forest Emerald
lib:AddRecipe(41701, 53967, 40027) -- Royal Twilight Opal
lib:AddRecipe(41702, 53973, 40033) -- Puissant Twilight Opal
lib:AddRecipe(41703, 53971, 40031) -- Regal Twilight Opal
lib:AddRecipe(41704, 55389, 41285) -- Chaotic Skyflare Diamond
lib:AddRecipe(41705, 55384, 41377) -- Effulgent Skyflare Diamond
lib:AddRecipe(41706, 55392, 41333) -- Ember Skyflare Diamond
lib:AddRecipe(41707, 55407, 41376) -- Revitalizing Skyflare Diamond
lib:AddRecipe(41708, 55396, 41401) -- Insightful Earthsiege Diamond
lib:AddRecipe(41709, 55404, 41385) -- Invigorating Earthsiege Diamond
lib:AddRecipe(41710, 55400, 41398) -- Relentless Earthsiege Diamond
lib:AddRecipe(41711, 55403, 41382) -- Trenchant Earthsiege Diamond
lib:AddRecipe(41718, 53946, 39998) -- Runed Scarlet Ruby
lib:AddRecipe(41719, 53948, 40000) -- Subtle Scarlet Ruby
lib:AddRecipe(41720, 53957, 40013) -- Smooth Autumn's Glow
lib:AddRecipe(41721, 53988, 40052) -- Wicked Monarch Topaz
lib:AddRecipe(41722, 53993, 40057) -- Glimmering Monarch Topaz
lib:AddRecipe(41723, 53996, 40086) -- Jagged Forest Emerald
lib:AddRecipe(41724, 54008, 40096) -- Sundered Forest Emerald
lib:AddRecipe(41725, 53965, 40025) -- Glowing Twilight Opal
lib:AddRecipe(41726, 53974, 40034) -- Guardian's Twilight Opal
lib:AddRecipe(41727, 53960, 40016) -- Mystic Autumn's Glow
lib:AddRecipe(41728, 53955, 40011) -- Stormy Sky Sapphire
lib:AddRecipe(41730, 53986, 40050) -- Durable Monarch Topaz
lib:AddRecipe(41732, 53990, 40054) -- Empowered Monarch Topaz
lib:AddRecipe(41733, 53981, 40045) -- Lucent Monarch Topaz
lib:AddRecipe(41734, 53978, 40040) -- Resplendent Monarch Topaz
lib:AddRecipe(41735, 54014, 40106) -- Shattered Forest Emerald
lib:AddRecipe(41736, 54013, 40101) -- Tense Forest Emerald
lib:AddRecipe(41737, 54005, 40102) -- Turbid Forest Emerald
lib:AddRecipe(41738, 54000, 40090) -- Steady Forest Emerald
lib:AddRecipe(41739, 54010, 40103) -- Opaque Forest Emerald
lib:AddRecipe(41740, 53968, 40028) -- Mysterious Twilight Opal
lib:AddRecipe(41742, 55393, 41335) -- Enigmatic Skyflare Diamond
lib:AddRecipe(41743, 55387, 41378) -- Forlorn Skyflare Diamond
lib:AddRecipe(41744, 55388, 41379) -- Impassive Skyflare Diamond
lib:AddRecipe(41747, 53963, 40023) -- Shifting Twilight Opal
lib:AddRecipe(41777, 53976, 40038) -- Etched Monarch Topaz
lib:AddRecipe(41778, 54023, 40059) -- Resolute Monarch Topaz
lib:AddRecipe(41779, 53992, 40056) -- Stalwart Monarch Topaz
lib:AddRecipe(41780, 53977, 40039) -- Champion's Monarch Topaz
lib:AddRecipe(41781, 54003, 40095) -- Misty Forest Emerald
lib:AddRecipe(41782, 54004, 40099) -- Shining Forest Emerald
lib:AddRecipe(41783, 53966, 40026) -- Purified Twilight Opal
lib:AddRecipe(41784, 53962, 40022) -- Sovereign Twilight Opal
lib:AddRecipe(41785, 53964, 40024) -- Tenuous Twilight Opal
lib:AddRecipe(41786, 55390, 41307) -- Destructive Skyflare Diamond
lib:AddRecipe(41787, 55395, 41400) -- Thundering Skyflare Diamond
lib:AddRecipe(41788, 55405, 41389) -- Beaming Earthsiege Diamond
lib:AddRecipe(41789, 53975, 40037) -- Inscribed Monarch Topaz
lib:AddRecipe(41790, 53951, 40003) -- Precise Scarlet Ruby
lib:AddRecipe(41791, 53959, 40015) -- Thick Autumn's Glow
lib:AddRecipe(41792, 53982, 40046) -- Deft Monarch Topaz
lib:AddRecipe(41793, 54019, 40041) -- Fierce Monarch Topaz
lib:AddRecipe(41794, 53979, 40043) -- Deadly Monarch Topaz
lib:AddRecipe(41795, 53995, 40085) -- Timeless Forest Emerald
lib:AddRecipe(41796, 53970, 40030) -- Infused Twilight Opal
lib:AddRecipe(41797, 55401, 41380) -- Austere Earthsiege Diamond
lib:AddRecipe(41798, 55397, 41395) -- Bracing Earthsiege Diamond
lib:AddRecipe(41799, 55398, 41396) -- Eternal Earthsiege Diamond
lib:AddRecipe(41817, 53950, 40002) -- Fractured Scarlet Ruby
lib:AddRecipe(41818, 53994, 40058) -- Accurate Monarch Topaz
lib:AddRecipe(41819, 54012, 40098) -- Radiant Forest Emerald
lib:AddRecipe(41820, 53972, 40032) -- Defender's Twilight Opal
lib:AddRecipe(42138, 53952, 40008) -- Solid Sky Sapphire
lib:AddRecipe(42298, 56049, 42142) -- Bold Dragon's Eye
lib:AddRecipe(42299, 56054, 36766) -- Bright Dragon's Eye
lib:AddRecipe(42300, 56074, 42148) -- Brilliant Dragon's Eye
lib:AddRecipe(42301, 56052, 42143) -- Delicate Dragon's Eye
lib:AddRecipe(42302, 56056, 42152) -- Flashing Dragon's Eye
lib:AddRecipe(42303, 56076, 42153) -- Fractured Dragon's Eye
lib:AddRecipe(42304, 56077, 42146) -- Lustrous Dragon's Eye
lib:AddRecipe(42305, 56079, 42158) -- Mystic Dragon's Eye
lib:AddRecipe(42306, 56081, 42154) -- Precise Dragon's Eye
lib:AddRecipe(42307, 56083, 42150) -- Quick Dragon's Eye
lib:AddRecipe(42308, 56084, 42156) -- Rigid Dragon's Eye
lib:AddRecipe(42309, 56053, 42144) -- Runed Dragon's Eye
lib:AddRecipe(42310, 56085, 42149) -- Smooth Dragon's Eye
lib:AddRecipe(42311, 56086, 36767) -- Solid Dragon's Eye
lib:AddRecipe(42312, 56087, 42145) -- Sparkling Dragon's Eye
lib:AddRecipe(42313, 56088, 42155) -- Stormy Dragon's Eye
lib:AddRecipe(42314, 56055, 42151) -- Subtle Dragon's Eye
lib:AddRecipe(42315, 56089, 42157) -- Thick Dragon's Eye
lib:AddRecipe(42648, 56496, 42642) -- Titanium Impact Band
lib:AddRecipe(42649, 56497, 42643) -- Titanium Earthguard Ring
lib:AddRecipe(42650, 56498, 42644) -- Titanium Spellshock Ring
lib:AddRecipe(42651, 56499, 42645) -- Titanium Impact Choker
lib:AddRecipe(42652, 56500, 42646) -- Titanium Earthguard Chain
lib:AddRecipe(42653, 56501, 42647) -- Titanium Spellshock Necklace
lib:AddRecipe(43317, 58147, 43250) -- Ring of Earthen Might
lib:AddRecipe(43318, 58148, 43251) -- Ring of Scarlet Shadows
lib:AddRecipe(43319, 58149, 43252) -- Windfire Band
lib:AddRecipe(43320, 58150, 43253) -- Ring of Northern Tears
lib:AddRecipe(43485, 58492, 43482) -- Savage Titanium Ring
lib:AddRecipe(43497, 58507, 43498) -- Savage Titanium Band
lib:AddRecipe(43597, 58954, 43582) -- Titanium Frostguard Ring
lib:AddRecipe(46897, 66338, 40167) -- Enduring Eye of Zul
lib:AddRecipe(46898, 66428, 40168) -- Steady Eye of Zul
lib:AddRecipe(46899, 66429, 40166) -- Vivid Eye of Zul
lib:AddRecipe(46900, 66430, 40175) -- Dazzling Eye of Zul
lib:AddRecipe(46901, 66431, 40165) -- Jagged Eye of Zul
lib:AddRecipe(46902, 66432, 40164) -- Timeless Eye of Zul
lib:AddRecipe(46903, 66433, 40170) -- Seer's Eye of Zul
lib:AddRecipe(46904, 66434, 40169) -- Forceful Eye of Zul
lib:AddRecipe(46905, 66435, 40171) -- Misty Eye of Zul
lib:AddRecipe(46906, 66436, 40176) -- Sundered Eye of Zul
lib:AddRecipe(46907, 66437, 40172) -- Shining Eye of Zul
lib:AddRecipe(46908, 66438, 40181) -- Tense Eye of Zul
lib:AddRecipe(46909, 66439, 40177) -- Lambent Eye of Zul
lib:AddRecipe(46910, 66440, 40174) -- Intricate Eye of Zul
lib:AddRecipe(46911, 66441, 40180) -- Radiant Eye of Zul
lib:AddRecipe(46912, 66442, 40179) -- Energized Eye of Zul
lib:AddRecipe(46913, 66443, 40182) -- Shattered Eye of Zul
lib:AddRecipe(46914, 66444, 40178) -- Opaque Eye of Zul
lib:AddRecipe(46915, 66445, 40173) -- Turbid Eye of Zul
lib:AddRecipe(46916, 66446, 40113) -- Runed Cardinal Ruby
lib:AddRecipe(46917, 66447, 40111) -- Bold Cardinal Ruby
lib:AddRecipe(46918, 66448, 40112) -- Delicate Cardinal Ruby
lib:AddRecipe(46919, 66449, 40114) -- Bright Cardinal Ruby
lib:AddRecipe(46920, 66450, 40118) -- Precise Cardinal Ruby
lib:AddRecipe(46921, 66451, 40117) -- Fractured Cardinal Ruby
lib:AddRecipe(46922, 66452, 40115) -- Subtle Cardinal Ruby
lib:AddRecipe(46923, 66453, 40116) -- Flashing Cardinal Ruby
lib:AddRecipe(46924, 66497, 40119) -- Solid Majestic Zircon
lib:AddRecipe(46925, 66498, 40120) -- Sparkling Majestic Zircon
lib:AddRecipe(46926, 66499, 40122) -- Stormy Majestic Zircon
lib:AddRecipe(46927, 66500, 40121) -- Lustrous Majestic Zircon
lib:AddRecipe(46928, 66501, 40125) -- Rigid King's Amber
lib:AddRecipe(46929, 66502, 40124) -- Smooth King's Amber
lib:AddRecipe(46930, 66503, 40123) -- Brilliant King's Amber
lib:AddRecipe(46931, 66504, 40126) -- Thick King's Amber
lib:AddRecipe(46932, 66505, 40127) -- Mystic King's Amber
lib:AddRecipe(46933, 66506, 40128) -- Quick King's Amber
lib:AddRecipe(46934, 66553, 40136) -- Balanced Dreadstone
lib:AddRecipe(46935, 66554, 40129) -- Sovereign Dreadstone
lib:AddRecipe(46936, 66555, 40132) -- Glowing Dreadstone
lib:AddRecipe(46937, 66556, 40133) -- Purified Dreadstone
lib:AddRecipe(46938, 66557, 40130) -- Shifting Dreadstone
lib:AddRecipe(46939, 66558, 40134) -- Royal Dreadstone
lib:AddRecipe(46940, 66559, 40138) -- Regal Dreadstone
lib:AddRecipe(46941, 66560, 40139) -- Defender's Dreadstone
lib:AddRecipe(46942, 66561, 40141) -- Guardian's Dreadstone
lib:AddRecipe(46943, 66562, 40135) -- Mysterious Dreadstone
lib:AddRecipe(46944, 66563, 40140) -- Puissant Dreadstone
lib:AddRecipe(46945, 66564, 40137) -- Infused Dreadstone
lib:AddRecipe(46946, 66565, 40131) -- Tenuous Dreadstone
lib:AddRecipe(46947, 66566, 40151) -- Luminous Ametrine
lib:AddRecipe(46948, 66567, 40142) -- Inscribed Ametrine
lib:AddRecipe(46949, 66568, 40147) -- Deadly Ametrine
lib:AddRecipe(46950, 66569, 40152) -- Potent Ametrine
lib:AddRecipe(46951, 66570, 40153) -- Veiled Ametrine
lib:AddRecipe(46952, 66571, 40154) -- Durable Ametrine
lib:AddRecipe(46953, 66572, 40143) -- Etched Ametrine
lib:AddRecipe(46956, 66573, 40157) -- Pristine Ametrine
lib:AddRecipe(47007, 66574, 40155) -- Reckless Ametrine
lib:AddRecipe(47008, 66575, 40148) -- Glinting Ametrine
lib:AddRecipe(47010, 66576, 40162) -- Accurate Ametrine
lib:AddRecipe(47011, 66577, 40156) -- Wicked Ametrine
lib:AddRecipe(47012, 66578, 40161) -- Glimmering Ametrine
lib:AddRecipe(47015, 66579, 40144) -- Champion's Ametrine
lib:AddRecipe(47016, 66580, 40158) -- Empowered Ametrine
lib:AddRecipe(47017, 66581, 40160) -- Stalwart Ametrine
lib:AddRecipe(47018, 66582, 40145) -- Resplendent Ametrine
lib:AddRecipe(47019, 66583, 40146) -- Fierce Ametrine
lib:AddRecipe(47020, 66584, 40150) -- Deft Ametrine
lib:AddRecipe(47021, 66585, 40149) -- Lucent Ametrine
lib:AddRecipe(47022, 66586, 40163) -- Resolute Ametrine
lib:AddRecipe(47023, 66587, 40159) -- Stark Ametrine
lib:AddRecipe(49112, 68253, 49110) -- Nightmare Tear
-- Leatherworking
lib:AddRecipe(2406, 2158, 2307) -- Fine Leather Boots
lib:AddRecipe(2407, 2163, 2311) -- White Leather Jerkin
lib:AddRecipe(2408, 2164, 2312) -- Fine Leather Gloves
lib:AddRecipe(2409, 2169, 2317) -- Dark Leather Tunic
lib:AddRecipe(4293, 3762, 4244) -- Hillman's Leather Vest
lib:AddRecipe(4294, 3767, 4250) -- Hillman's Belt
lib:AddRecipe(4295, 7153, 5965) -- Guardian Cloak
lib:AddRecipe(4296, 3769, 4252) -- Dark Leather Shoulders
lib:AddRecipe(4297, 3771, 4254) -- Barbaric Gloves
lib:AddRecipe(4298, 3775, 4258) -- Guardian Belt
lib:AddRecipe(4299, 3773, 4256) -- Guardian Armor
lib:AddRecipe(4300, 3777, 4260) -- Guardian Leather Bracers
lib:AddRecipe(4301, 3779, 4264) -- Barbaric Belt
lib:AddRecipe(5083, 5244, 5081) -- Kodo Hide Bag
lib:AddRecipe(5786, 6702, 5780) -- Murloc Scale Belt
lib:AddRecipe(5787, 6703, 5781) -- Murloc Scale Breastplate
lib:AddRecipe(5788, 6704, 5782) -- Thick Murloc Armor
lib:AddRecipe(5789, 6705, 5783) -- Murloc Scale Bracers
lib:AddRecipe(5972, 7133, 5958) -- Fine Leather Pants
lib:AddRecipe(5973, 7149, 5963) -- Barbaric Leggings
lib:AddRecipe(5974, 7153, 5965) -- Guardian Cloak
lib:AddRecipe(6474, 7953, 6466) -- Deviate Scale Cloak
lib:AddRecipe(6475, 7954, 6467) -- Deviate Scale Gloves
lib:AddRecipe(6476, 7955, 6468) -- Deviate Scale Belt
lib:AddRecipe(6710, 8322, 6709) -- Moonglow Vest
lib:AddRecipe(7288, 9064, 7280) -- Rugged Leather Pants
lib:AddRecipe(7289, 9070, 7283) -- Black Whelp Cloak
lib:AddRecipe(7290, 9072, 7284) -- Red Whelp Gloves
lib:AddRecipe(7360, 3765, 4248) -- Dark Leather Gloves
lib:AddRecipe(7361, 9146, 7349) -- Herbalist's Gloves
lib:AddRecipe(7362, 9147, 7352) -- Earthen Leather Shoulders
lib:AddRecipe(7363, 9148, 7358) -- Pilferer's Gloves
lib:AddRecipe(7364, 9149, 7359) -- Heavy Earthen Gloves
lib:AddRecipe(7449, 9195, 7373) -- Dusky Leather Leggings
lib:AddRecipe(7450, 9197, 7375) -- Green Whelp Armor
lib:AddRecipe(7451, 9202, 7386) -- Green Whelp Bracers
lib:AddRecipe(7452, 9207, 7390) -- Dusky Boots
lib:AddRecipe(7453, 9208, 7391) -- Swift Boots
lib:AddRecipe(7613, 3772, 4255) -- Green Leather Armor
lib:AddRecipe(8384, 10490, 8174) -- Comfortable Leather Hat
lib:AddRecipe(8385, 10509, 8187) -- Turtle Scale Gloves
lib:AddRecipe(8386, 10520, 8200) -- Big Voodoo Robe
lib:AddRecipe(8387, 10531, 8201) -- Big Voodoo Mask
lib:AddRecipe(8388, 10550, 8195) -- Nightscape Cloak
lib:AddRecipe(8389, 10560, 8202) -- Big Voodoo Pants
lib:AddRecipe(8390, 10562, 8216) -- Big Voodoo Cloak
lib:AddRecipe(8395, 10525, 8203) -- Tough Scorpid Breastplate
lib:AddRecipe(8397, 10533, 8205) -- Tough Scorpid Bracers
lib:AddRecipe(8398, 10542, 8204) -- Tough Scorpid Gloves
lib:AddRecipe(8399, 10554, 8209) -- Tough Scorpid Boots
lib:AddRecipe(8400, 10564, 8207) -- Tough Scorpid Shoulders
lib:AddRecipe(8401, 10568, 8206) -- Tough Scorpid Leggings
lib:AddRecipe(8402, 10570, 8208) -- Tough Scorpid Helm
lib:AddRecipe(8403, 10529, 8210) -- Wild Leather Shoulders
lib:AddRecipe(8404, 10544, 8211) -- Wild Leather Vest
lib:AddRecipe(8405, 10546, 8214) -- Wild Leather Helmet
lib:AddRecipe(8406, 10566, 8213) -- Wild Leather Boots
lib:AddRecipe(8407, 10572, 8212) -- Wild Leather Leggings
lib:AddRecipe(8408, 10574, 8215) -- Wild Leather Cloak
lib:AddRecipe(8409, 10516, 8192) -- Nightscape Shoulders
lib:AddRecipe(13287, 4096, 4455) -- Raptor Hide Harness
lib:AddRecipe(13288, 4097, 4456) -- Raptor Hide Belt
lib:AddRecipe(14635, 3778, 4262) -- Gem-studded Leather Belt
lib:AddRecipe(15724, 19048, 15077) -- Heavy Scorpid Bracers
lib:AddRecipe(15725, 19049, 15083) -- Wicked Leather Gauntlets
lib:AddRecipe(15726, 19050, 15045) -- Green Dragonscale Breastplate
lib:AddRecipe(15727, 19051, 15076) -- Heavy Scorpid Vest
lib:AddRecipe(15728, 19052, 15084) -- Wicked Leather Bracers
lib:AddRecipe(15729, 19053, 15074) -- Chimeric Gloves
lib:AddRecipe(15730, 19054, 15047) -- Red Dragonscale Breastplate
lib:AddRecipe(15731, 19055, 15091) -- Runic Leather Gauntlets
lib:AddRecipe(15732, 19059, 15054) -- Volcanic Leggings
lib:AddRecipe(15733, 19060, 15046) -- Green Dragonscale Leggings
lib:AddRecipe(15734, 19061, 15061) -- Living Shoulders
lib:AddRecipe(15735, 19062, 15067) -- Ironfeather Shoulders
lib:AddRecipe(15737, 19063, 15073) -- Chimeric Boots
lib:AddRecipe(15738, 19064, 15078) -- Heavy Scorpid Gauntlets
lib:AddRecipe(15739, 19065, 15092) -- Runic Leather Bracers
lib:AddRecipe(15740, 19066, 15071) -- Frostsaber Boots
lib:AddRecipe(15741, 19067, 15057) -- Stormshroud Pants
lib:AddRecipe(15742, 19068, 15064) -- Warbear Harness
lib:AddRecipe(15743, 19070, 15082) -- Heavy Scorpid Belt
lib:AddRecipe(15744, 19071, 15086) -- Wicked Leather Headband
lib:AddRecipe(15745, 19072, 15093) -- Runic Leather Belt
lib:AddRecipe(15746, 19073, 15072) -- Chimeric Leggings
lib:AddRecipe(15747, 19074, 15069) -- Frostsaber Leggings
lib:AddRecipe(15748, 19075, 15079) -- Heavy Scorpid Leggings
lib:AddRecipe(15749, 19076, 15053) -- Volcanic Breastplate
lib:AddRecipe(15751, 19077, 15048) -- Blue Dragonscale Breastplate
lib:AddRecipe(15752, 19078, 15060) -- Living Leggings
lib:AddRecipe(15753, 19079, 15056) -- Stormshroud Armor
lib:AddRecipe(15754, 19080, 15065) -- Warbear Woolies
lib:AddRecipe(15755, 19081, 15075) -- Chimeric Vest
lib:AddRecipe(15756, 19082, 15094) -- Runic Leather Headband
lib:AddRecipe(15757, 19083, 15087) -- Wicked Leather Pants
lib:AddRecipe(15758, 19084, 15063) -- Devilsaur Gauntlets
lib:AddRecipe(15759, 19085, 15050) -- Black Dragonscale Breastplate
lib:AddRecipe(15760, 19086, 15066) -- Ironfeather Breastplate
lib:AddRecipe(15761, 19087, 15070) -- Frostsaber Gloves
lib:AddRecipe(15762, 19088, 15080) -- Heavy Scorpid Helm
lib:AddRecipe(15763, 19089, 15049) -- Blue Dragonscale Shoulders
lib:AddRecipe(15764, 19090, 15058) -- Stormshroud Shoulders
lib:AddRecipe(15765, 19091, 15095) -- Runic Leather Pants
lib:AddRecipe(15768, 19092, 15088) -- Wicked Leather Belt
lib:AddRecipe(15769, 19093, 15138) -- Onyxia Scale Cloak
lib:AddRecipe(15770, 19094, 15051) -- Black Dragonscale Shoulders
lib:AddRecipe(15771, 19095, 15059) -- Living Breastplate
lib:AddRecipe(15772, 19097, 15062) -- Devilsaur Leggings
lib:AddRecipe(15773, 19098, 15085) -- Wicked Leather Armor
lib:AddRecipe(15774, 19100, 15081) -- Heavy Scorpid Shoulders
lib:AddRecipe(15775, 19101, 15055) -- Volcanic Shoulders
lib:AddRecipe(15776, 19102, 15090) -- Runic Leather Armor
lib:AddRecipe(15777, 19103, 15096) -- Runic Leather Shoulders
lib:AddRecipe(15779, 19104, 15068) -- Frostsaber Tunic
lib:AddRecipe(15781, 19107, 15052) -- Black Dragonscale Leggings
lib:AddRecipe(17022, 20853, 16982) -- Corehound Boots
lib:AddRecipe(17023, 20854, 16983) -- Molten Helm
lib:AddRecipe(17025, 20855, 16984) -- Black Dragonscale Boots
lib:AddRecipe(17722, 21943, 17721) -- Gloves of the Greatfather
lib:AddRecipe(18239, 22711, 18238) -- Shadowskin Gloves
lib:AddRecipe(18252, 22727, 18251) -- Core Armor Kit
lib:AddRecipe(18514, 22921, 18504) -- Girdle of Insight
lib:AddRecipe(18515, 22922, 18506) -- Mongoose Boots
lib:AddRecipe(18516, 22923, 18508) -- Swift Flight Bracers
lib:AddRecipe(18517, 22926, 18509) -- Chromatic Cloak
lib:AddRecipe(18518, 22927, 18510) -- Hide of the Wild
lib:AddRecipe(18519, 22928, 18511) -- Shifting Cloak
lib:AddRecipe(18731, 23190, 18662) -- Heavy Leather Ball
lib:AddRecipe(18949, 23399, 18948) -- Barbaric Bracers
lib:AddRecipe(19326, 23703, 19044) -- Might of the Timbermaw
lib:AddRecipe(19327, 23704, 19049) -- Timbermaw Brawlers
lib:AddRecipe(19328, 23705, 19052) -- Dawn Treaders
lib:AddRecipe(19329, 23706, 19058) -- Golden Mantle of the Dawn
lib:AddRecipe(19330, 23707, 19149) -- Lava Belt
lib:AddRecipe(19331, 23708, 19157) -- Chromatic Gauntlets
lib:AddRecipe(19332, 23709, 19162) -- Corehound Belt
lib:AddRecipe(19333, 23710, 19163) -- Molten Belt
lib:AddRecipe(19769, 24121, 19685) -- Primal Batskin Jerkin
lib:AddRecipe(19770, 24122, 19686) -- Primal Batskin Gloves
lib:AddRecipe(19771, 24123, 19687) -- Primal Batskin Bracers
lib:AddRecipe(19772, 24124, 19688) -- Blood Tiger Breastplate
lib:AddRecipe(19773, 24125, 19689) -- Blood Tiger Shoulders
lib:AddRecipe(20253, 19068, 15064) -- Warbear Harness
lib:AddRecipe(20254, 19080, 15065) -- Warbear Woolies
lib:AddRecipe(20382, 24703, 20380) -- Dreamscale Breastplate
lib:AddRecipe(20506, 24846, 20481) -- Spitfire Bracers
lib:AddRecipe(20507, 24847, 20480) -- Spitfire Gauntlets
lib:AddRecipe(20508, 24848, 20479) -- Spitfire Breastplate
lib:AddRecipe(20509, 24849, 20476) -- Sandstalker Bracers
lib:AddRecipe(20510, 24850, 20477) -- Sandstalker Gauntlets
lib:AddRecipe(20511, 24851, 20478) -- Sandstalker Breastplate
lib:AddRecipe(20576, 24940, 20575) -- Black Whelp Tunic
lib:AddRecipe(21548, 26279, 21278) -- Stormshroud Gloves
lib:AddRecipe(22692, 28219, 22661) -- Polar Tunic
lib:AddRecipe(22694, 28220, 22662) -- Polar Gloves
lib:AddRecipe(22695, 28221, 22663) -- Polar Bracers
lib:AddRecipe(22696, 28222, 22664) -- Icy Scale Breastplate
lib:AddRecipe(22697, 28223, 22666) -- Icy Scale Gauntlets
lib:AddRecipe(22698, 28224, 22665) -- Icy Scale Bracers
lib:AddRecipe(22769, 28474, 22761) -- Bramblewood Belt
lib:AddRecipe(22770, 28473, 22760) -- Bramblewood Boots
lib:AddRecipe(22771, 28472, 22759) -- Bramblewood Helm
lib:AddRecipe(25720, 32455, 23793) -- Heavy Knothide Leather
lib:AddRecipe(25721, 32457, 25651) -- Vindicator's Armor Kit
lib:AddRecipe(25722, 32458, 25652) -- Magister's Armor Kit
lib:AddRecipe(25725, 32461, 25653) -- Riding Crop
lib:AddRecipe(25726, 32482, 25679) -- Comfortable Insoles
lib:AddRecipe(25728, 32485, 25680) -- Stylin' Purple Hat
lib:AddRecipe(25729, 32487, 25681) -- Stylin' Adventure Hat
lib:AddRecipe(25730, 32489, 25682) -- Stylin' Jungle Hat
lib:AddRecipe(25731, 32488, 25683) -- Stylin' Crimson Hat
lib:AddRecipe(25732, 32490, 25685) -- Fel Leather Gloves
lib:AddRecipe(25733, 32493, 25686) -- Fel Leather Boots
lib:AddRecipe(25734, 32494, 25687) -- Fel Leather Leggings
lib:AddRecipe(25735, 32495, 25689) -- Heavy Clefthoof Vest
lib:AddRecipe(25736, 32496, 25690) -- Heavy Clefthoof Leggings
lib:AddRecipe(25737, 32497, 25691) -- Heavy Clefthoof Boots
lib:AddRecipe(25738, 32498, 25695) -- Felstalker Belt
lib:AddRecipe(25739, 32499, 25697) -- Felstalker Bracer
lib:AddRecipe(25740, 32500, 25696) -- Felstalker Breastplate
lib:AddRecipe(25741, 32501, 25694) -- Netherfury Belt
lib:AddRecipe(25742, 32502, 25692) -- Netherfury Leggings
lib:AddRecipe(25743, 32503, 25693) -- Netherfury Boots
lib:AddRecipe(29213, 32498, 25695) -- Felstalker Belt
lib:AddRecipe(29214, 32499, 25697) -- Felstalker Bracer
lib:AddRecipe(29215, 32500, 25696) -- Felstalker Breastplate
lib:AddRecipe(29217, 32501, 25694) -- Netherfury Belt
lib:AddRecipe(29218, 32503, 25693) -- Netherfury Boots
lib:AddRecipe(29219, 32502, 25692) -- Netherfury Leggings
lib:AddRecipe(29664, 35530, 29540) -- Reinforced Mining Bag
lib:AddRecipe(29669, 35520, 29483) -- Shadow Armor Kit
lib:AddRecipe(29672, 35521, 29485) -- Flame Armor Kit
lib:AddRecipe(29673, 35522, 29486) -- Frost Armor Kit
lib:AddRecipe(29674, 35523, 29487) -- Nature Armor Kit
lib:AddRecipe(29675, 35524, 29488) -- Arcane Armor Kit
lib:AddRecipe(29677, 35525, 29489) -- Enchanted Felscale Leggings
lib:AddRecipe(29682, 35526, 29490) -- Enchanted Felscale Gloves
lib:AddRecipe(29684, 35527, 29491) -- Enchanted Felscale Boots
lib:AddRecipe(29689, 35529, 29492) -- Flamescale Leggings
lib:AddRecipe(29691, 35528, 29493) -- Flamescale Boots
lib:AddRecipe(29693, 35531, 29494) -- Flamescale Belt
lib:AddRecipe(29698, 35532, 29495) -- Enchanted Clefthoof Leggings
lib:AddRecipe(29700, 35533, 29496) -- Enchanted Clefthoof Gloves
lib:AddRecipe(29701, 35534, 29497) -- Enchanted Clefthoof Boots
lib:AddRecipe(29702, 35535, 29498) -- Blastguard Pants
lib:AddRecipe(29703, 35536, 29499) -- Blastguard Boots
lib:AddRecipe(29704, 35537, 29500) -- Blastguard Belt
lib:AddRecipe(29713, 35538, 29532) -- Drums of Panic
lib:AddRecipe(29714, 35539, 29531) -- Drums of Restoration
lib:AddRecipe(29717, 35543, 29529) -- Drums of Battle
lib:AddRecipe(29718, 35544, 29530) -- Drums of Speed
lib:AddRecipe(29719, 35549, 29533) -- Cobrahide Leg Armor
lib:AddRecipe(29720, 35555, 29534) -- Clefthide Leg Armor
lib:AddRecipe(29721, 35557, 29536) -- Nethercleft Leg Armor
lib:AddRecipe(29722, 35554, 29535) -- Nethercobra Leg Armor
lib:AddRecipe(29723, 35558, 29502) -- Cobrascale Hood
lib:AddRecipe(29724, 35559, 29503) -- Cobrascale Gloves
lib:AddRecipe(29725, 35560, 29504) -- Windscale Hood
lib:AddRecipe(29726, 35561, 29505) -- Hood of Primal Life
lib:AddRecipe(29727, 35562, 29506) -- Gloves of the Living Touch
lib:AddRecipe(29728, 35563, 29507) -- Windslayer Wraps
lib:AddRecipe(29729, 35564, 29508) -- Living Dragonscale Helm
lib:AddRecipe(29730, 35567, 29512) -- Earthen Netherscale Boots
lib:AddRecipe(29731, 35568, 29509) -- Windstrike Gloves
lib:AddRecipe(29732, 35572, 29510) -- Netherdrake Helm
lib:AddRecipe(29733, 35573, 29511) -- Netherdrake Gloves
lib:AddRecipe(29734, 35574, 29514) -- Thick Netherscale Breastplate
lib:AddRecipe(30301, 36349, 30042) -- Belt of Natural Power
lib:AddRecipe(30302, 36351, 30040) -- Belt of Deep Shadow
lib:AddRecipe(30303, 36352, 30046) -- Belt of the Black Eagle
lib:AddRecipe(30304, 36353, 30044) -- Monsoon Belt
lib:AddRecipe(30305, 36355, 30041) -- Boots of Natural Grace
lib:AddRecipe(30306, 36357, 30039) -- Boots of Utter Darkness
lib:AddRecipe(30307, 36358, 30045) -- Boots of the Crimson Hawk
lib:AddRecipe(30308, 36359, 30043) -- Hurricane Boots
lib:AddRecipe(30444, 35530, 29540) -- Reinforced Mining Bag
lib:AddRecipe(31361, 35549, 29533) -- Cobrahide Leg Armor
lib:AddRecipe(31362, 35554, 29535) -- Nethercobra Leg Armor
lib:AddRecipe(32429, 39997, 32398) -- Boots of Shackled Souls
lib:AddRecipe(32430, 52733, 32399) -- Bracers of Shackled Souls
lib:AddRecipe(32431, 40001, 32400) -- Greaves of Shackled Souls
lib:AddRecipe(32432, 40002, 32397) -- Waistguard of Shackled Souls
lib:AddRecipe(32433, 40003, 32394) -- Redeemed Soul Moccasins
lib:AddRecipe(32434, 40004, 32395) -- Redeemed Soul Wristguards
lib:AddRecipe(32435, 40005, 32396) -- Redeemed Soul Legguards
lib:AddRecipe(32436, 40006, 32393) -- Redeemed Soul Cinch
lib:AddRecipe(32744, 41156, 32582) -- Bracers of Renewed Life
lib:AddRecipe(32745, 41157, 32583) -- Shoulderpads of Renewed Life
lib:AddRecipe(32746, 41158, 32580) -- Swiftstrike Bracers
lib:AddRecipe(32747, 41160, 32581) -- Swiftstrike Shoulders
lib:AddRecipe(32748, 41161, 32574) -- Bindings of Lightning Reflexes
lib:AddRecipe(32749, 41162, 32575) -- Shoulders of Lightning Reflexes
lib:AddRecipe(32750, 41163, 32577) -- Living Earth Bindings
lib:AddRecipe(32751, 41164, 32579) -- Living Earth Shoulders
lib:AddRecipe(33124, 42546, 33122) -- Cloak of Darkness
lib:AddRecipe(33205, 42731, 33204) -- Shadowprowler's Chestguard
lib:AddRecipe(34172, 35544, 29530) -- Drums of Speed
lib:AddRecipe(34173, 35544, 29530) -- Drums of Speed
lib:AddRecipe(34174, 35539, 29531) -- Drums of Restoration
lib:AddRecipe(34175, 35539, 29531) -- Drums of Restoration
lib:AddRecipe(34200, 44359, 34105) -- Quiver of a Thousand Feathers
lib:AddRecipe(34201, 44768, 34106) -- Netherscale Ammo Pouch
lib:AddRecipe(34218, 44768, 34106) -- Netherscale Ammo Pouch
lib:AddRecipe(34262, 44953, 34086) -- Winter Boots
lib:AddRecipe(34491, 45117, 34490) -- Bag of Many Hides
lib:AddRecipe(35212, 46132, 34372) -- Leather Gauntlets of the Sun
lib:AddRecipe(35213, 46133, 34374) -- Fletcher's Gloves of the Phoenix
lib:AddRecipe(35214, 46134, 34370) -- Gloves of Immortal Dusk
lib:AddRecipe(35215, 46135, 34376) -- Sun-Drenched Scale Gloves
lib:AddRecipe(35216, 46136, 34371) -- Leather Chestguard of the Sun
lib:AddRecipe(35217, 46137, 34373) -- Embrace of the Phoenix
lib:AddRecipe(35218, 46138, 34369) -- Carapace of Sun and Shadow
lib:AddRecipe(35219, 46139, 34375) -- Sun-Drenched Scale Chestguard
lib:AddRecipe(35300, 35568, 29509) -- Windstrike Gloves
lib:AddRecipe(35301, 35573, 29511) -- Netherdrake Gloves
lib:AddRecipe(35302, 35559, 29503) -- Cobrascale Gloves
lib:AddRecipe(35303, 35562, 29506) -- Gloves of the Living Touch
lib:AddRecipe(35517, 41161, 32574) -- Bindings of Lightning Reflexes
lib:AddRecipe(35519, 41156, 32582) -- Bracers of Renewed Life
lib:AddRecipe(35520, 41163, 32577) -- Living Earth Bindings
lib:AddRecipe(35521, 41164, 32579) -- Living Earth Shoulders
lib:AddRecipe(35523, 41157, 32583) -- Shoulderpads of Renewed Life
lib:AddRecipe(35524, 41162, 32575) -- Shoulders of Lightning Reflexes
lib:AddRecipe(35527, 41158, 32580) -- Swiftstrike Bracers
lib:AddRecipe(35528, 41160, 32581) -- Swiftstrike Shoulders
lib:AddRecipe(35539, 46138, 34369) -- Carapace of Sun and Shadow
lib:AddRecipe(35540, 46137, 34373) -- Embrace of the Phoenix
lib:AddRecipe(35541, 46133, 34374) -- Fletcher's Gloves of the Phoenix
lib:AddRecipe(35542, 46134, 34370) -- Gloves of Immortal Dusk
lib:AddRecipe(35545, 46136, 34371) -- Leather Chestguard of the Sun
lib:AddRecipe(35546, 46132, 34372) -- Leather Gauntlets of the Sun
lib:AddRecipe(35549, 46139, 34375) -- Sun-Drenched Scale Chestguard
lib:AddRecipe(35550, 46135, 34376) -- Sun-Drenched Scale Gloves
lib:AddRecipe(38593, 45117, 34490) -- Bag of Many Hides
lib:AddRecipe(38594, 45117, 34490) -- Bag of Many Hides
lib:AddRecipe(38595, 45117, 34490) -- Bag of Many Hides
lib:AddRecipe(38596, 45117, 34490) -- Bag of Many Hides
lib:AddRecipe(38597, 51568, 38590) -- Black Chitinguard Boots
lib:AddRecipe(38598, 51569, 38591) -- Dark Arctic Leggings
lib:AddRecipe(38599, 51570, 38592) -- Dark Arctic Chestpiece
lib:AddRecipe(43097, 57683, nil) -- Fur Lining - Attack Power
lib:AddRecipe(44509, 50970, 38399) -- Trapper's Traveling Pack
lib:AddRecipe(44510, 50971, 38347) -- Mammoth Mining Bag
lib:AddRecipe(44511, 60645, 44447) -- Dragonscale Ammo Pouch
lib:AddRecipe(44512, 60647, 44448) -- Nerubian Reinforced Quiver
lib:AddRecipe(44513, 60697, 43260) -- Eviscerator's Facemask
lib:AddRecipe(44514, 60702, 43433) -- Eviscerator's Shoulderpads
lib:AddRecipe(44515, 60703, 43434) -- Eviscerator's Chestguard
lib:AddRecipe(44516, 60704, 43435) -- Eviscerator's Bindings
lib:AddRecipe(44517, 60705, 43436) -- Eviscerator's Gauntlets
lib:AddRecipe(44518, 60706, 43437) -- Eviscerator's Waistguard
lib:AddRecipe(44519, 60711, 43438) -- Eviscerator's Legguards
lib:AddRecipe(44520, 60712, 43439) -- Eviscerator's Treads
lib:AddRecipe(44521, 60715, 43261) -- Overcast Headguard
lib:AddRecipe(44522, 60716, 43262) -- Overcast Spaulders
lib:AddRecipe(44523, 60718, 43263) -- Overcast Chestguard
lib:AddRecipe(44524, 60720, 43264) -- Overcast Bracers
lib:AddRecipe(44525, 60721, 43265) -- Overcast Handwraps
lib:AddRecipe(44526, 60723, 43266) -- Overcast Belt
lib:AddRecipe(44527, 60725, 43271) -- Overcast Leggings
lib:AddRecipe(44528, 60727, 43273) -- Overcast Boots
lib:AddRecipe(44530, 60728, 43447) -- Swiftarrow Helm
lib:AddRecipe(44531, 60729, 43449) -- Swiftarrow Shoulderguards
lib:AddRecipe(44532, 60730, 43445) -- Swiftarrow Hauberk
lib:AddRecipe(44533, 60731, 43444) -- Swiftarrow Bracers
lib:AddRecipe(44534, 60732, 43446) -- Swiftarrow Gauntlets
lib:AddRecipe(44535, 60734, 43442) -- Swiftarrow Belt
lib:AddRecipe(44536, 60735, 43448) -- Swiftarrow Leggings
lib:AddRecipe(44537, 60737, 43443) -- Swiftarrow Boots
lib:AddRecipe(44538, 60743, 43455) -- Stormhide Crown
lib:AddRecipe(44539, 60746, 43457) -- Stormhide Shoulders
lib:AddRecipe(44540, 60747, 43453) -- Stormhide Hauberk
lib:AddRecipe(44541, 60748, 43452) -- Stormhide Wristguards
lib:AddRecipe(44542, 60749, 43454) -- Stormhide Grips
lib:AddRecipe(44543, 60750, 43450) -- Stormhide Belt
lib:AddRecipe(44544, 60751, 43456) -- Stormhide Legguards
lib:AddRecipe(44545, 60752, 43451) -- Stormhide Stompers
lib:AddRecipe(44546, 60754, 43458) -- Giantmaim Legguards
lib:AddRecipe(44547, 60755, 43459) -- Giantmaim Bracers
lib:AddRecipe(44548, 60756, 43461) -- Revenant's Breastplate
lib:AddRecipe(44549, 60757, 43469) -- Revenant's Treads
lib:AddRecipe(44550, 60758, 43481) -- Trollwoven Spaulders
lib:AddRecipe(44551, 60759, 43484) -- Trollwoven Girdle
lib:AddRecipe(44552, 60760, 43495) -- Earthgiving Legguards
lib:AddRecipe(44553, 60761, 43502) -- Earthgiving Boots
lib:AddRecipe(44559, 57692, nil) -- Fur Lining - Fire Resist
lib:AddRecipe(44560, 57694, nil) -- Fur Lining - Frost Resist
lib:AddRecipe(44561, 57696, nil) -- Fur Lining - Shadow Resist
lib:AddRecipe(44562, 57699, nil) -- Fur Lining - Nature Resist
lib:AddRecipe(44563, 57701, nil) -- Fur Lining - Arcane Resist
lib:AddRecipe(44584, 60996, 43590) -- Polar Vest
lib:AddRecipe(44585, 60997, 43591) -- Polar Cord
lib:AddRecipe(44586, 60998, 43592) -- Polar Boots
lib:AddRecipe(44587, 60999, 43593) -- Icy Scale Chestguard
lib:AddRecipe(44588, 61000, 43594) -- Icy Scale Belt
lib:AddRecipe(44589, 61002, 43595) -- Icy Scale Boots
lib:AddRecipe(44932, 62176, 44930) -- Windripper Boots
lib:AddRecipe(44933, 62177, 44931) -- Windripper Leggings
lib:AddRecipe(45094, 63194, 45553) -- Belt of Dragons
lib:AddRecipe(45095, 63195, 45562) -- Boots of Living Scale
lib:AddRecipe(45096, 63196, 45554) -- Blue Belt of Chaos
lib:AddRecipe(45097, 63197, 45563) -- Lightning Grounded Boots
lib:AddRecipe(45098, 63198, 45555) -- Death-warmed Belt
lib:AddRecipe(45099, 63199, 45564) -- Footpads of Silence
lib:AddRecipe(45100, 63200, 45556) -- Belt of Arctic Life
lib:AddRecipe(45101, 63201, 45565) -- Boots of Wintry Endurance
lib:AddRecipe(47628, 67080, 47597) -- Ensorcelled Nerubian Breastplate
lib:AddRecipe(47629, 67081, 47579) -- Black Chitin Bracers
lib:AddRecipe(47630, 67082, 47595) -- Crusader's Dragonscale Breastplate
lib:AddRecipe(47631, 67083, 47576) -- Crusader's Dragonscale Bracers
lib:AddRecipe(47632, 67084, 47602) -- Lunar Eclipse Robes
lib:AddRecipe(47633, 67085, 47583) -- Moonshadow Armguards
lib:AddRecipe(47634, 67086, 47599) -- Knightbane Carapace
lib:AddRecipe(47635, 67087, 47581) -- Bracers of Swift Death
lib:AddRecipe(47646, 67137, 47580) -- Black Chitin Bracers
lib:AddRecipe(47647, 67139, 47582) -- Bracers of Swift Death
lib:AddRecipe(47648, 67143, 47577) -- Crusader's Dragonscale Bracers
lib:AddRecipe(47649, 67138, 47596) -- Crusader's Dragonscale Breastplate
lib:AddRecipe(47650, 67136, 47598) -- Ensorcelled Nerubian Breastplate
lib:AddRecipe(47651, 67142, 47600) -- Knightbane Carapace
lib:AddRecipe(47652, 67140, 47601) -- Lunar Eclipse Robes
lib:AddRecipe(47653, 67141, 47584) -- Moonshadow Armguards
lib:AddRecipe(49957, 70554, 49898) -- Legwraps of Unleashed Nature
lib:AddRecipe(49958, 70555, 49894) -- Blessed Cenarion Boots
lib:AddRecipe(49959, 70556, 49899) -- Bladeborn Leggings
lib:AddRecipe(49961, 70557, 49895) -- Footpads of Impending Death
lib:AddRecipe(49962, 70558, 49900) -- Lightning-Infused Leggings
lib:AddRecipe(49963, 70559, 49896) -- Earthsoul Boots
lib:AddRecipe(49965, 70560, 49901) -- Draconic Bonesplinter Legguards
lib:AddRecipe(49966, 70561, 49897) -- Rock-Steady Treads
lib:AddRecipe(185922, 351766, 185852) -- Greater Drums of War
lib:AddRecipe(185923, 351768, 185851) -- Greater Drums of Speed
lib:AddRecipe(185924, 351769, 185850) -- Greater Drums of Restoration
lib:AddRecipe(185925, 351770, 185849) -- Greater Drums of Panic
lib:AddRecipe(185926, 351771, 185848) -- Greater Drums of Battle
lib:AddRecipe(187048, 351769, 185850) -- Greater Drums of Restoration
lib:AddRecipe(187049, 351768, 185851) -- Greater Drums of Speed
-- Mining
lib:AddRecipe(35273, 46353, 35128) -- Smelt Hardened Khorium
lib:AddRecipe(44956, 22967, 17771) -- Smelt Elementium
-- Tailoring
lib:AddRecipe(2598, 2389, 2572) -- Red Linen Robe
lib:AddRecipe(2601, 2403, 2585) -- Gray Woolen Robe
lib:AddRecipe(4292, 3758, 4241) -- Green Woolen Bag
lib:AddRecipe(4345, 3847, 4313) -- Red Woolen Boots
lib:AddRecipe(4346, 3844, 4311) -- Heavy Woolen Cloak
lib:AddRecipe(4347, 3849, 4315) -- Reinforced Woolen Shoulders
lib:AddRecipe(4348, 3868, 4331) -- Phoenix Gloves
lib:AddRecipe(4349, 3851, 4317) -- Phoenix Pants
lib:AddRecipe(4350, 3856, 4321) -- Spider Silk Slippers
lib:AddRecipe(4351, 3858, 4323) -- Shadow Hood
lib:AddRecipe(4352, 3860, 4325) -- Boots of the Enchanter
lib:AddRecipe(4353, 3863, 4328) -- Spider Belt
lib:AddRecipe(4354, 3872, 4335) -- Rich Purple Silk Shirt
lib:AddRecipe(4355, 3862, 4327) -- Icy Cloak
lib:AddRecipe(4356, 3864, 4329) -- Star Belt
lib:AddRecipe(5771, 6686, 5762) -- Red Linen Bag
lib:AddRecipe(5772, 6688, 5763) -- Red Woolen Bag
lib:AddRecipe(5773, 6692, 5770) -- Robes of Arcana
lib:AddRecipe(5774, 6693, 5764) -- Green Silk Pack
lib:AddRecipe(5775, 6695, 5765) -- Black Silk Pack
lib:AddRecipe(6270, 7630, 6240) -- Blue Linen Vest
lib:AddRecipe(6271, 7629, 6239) -- Red Linen Vest
lib:AddRecipe(6272, 7633, 6242) -- Blue Linen Robe
lib:AddRecipe(6273, 7636, 6243) -- Green Woolen Robe
lib:AddRecipe(6274, 7639, 6263) -- Blue Overalls
lib:AddRecipe(6275, 7643, 6264) -- Greater Adept's Robe
lib:AddRecipe(6390, 7892, 6384) -- Stylish Blue Shirt
lib:AddRecipe(6391, 7893, 6385) -- Stylish Green Shirt
lib:AddRecipe(6401, 3870, 4333) -- Dark Silk Shirt
lib:AddRecipe(7084, 8793, 7059) -- Crimson Silk Shoulders
lib:AddRecipe(7085, 8795, 7060) -- Azure Shoulders
lib:AddRecipe(7086, 8797, 7061) -- Earthen Silk Belt
lib:AddRecipe(7087, 8789, 7056) -- Crimson Silk Cloak
lib:AddRecipe(7088, 8802, 7063) -- Crimson Silk Robe
lib:AddRecipe(7089, 8786, 7053) -- Azure Silk Cloak
lib:AddRecipe(7090, 8784, 7065) -- Green Silk Armor
lib:AddRecipe(7091, 8782, 7049) -- Truefaith Gloves
lib:AddRecipe(7092, 8780, 7047) -- Hands of Darkness
lib:AddRecipe(7093, 8778, 7027) -- Boots of Darkness
lib:AddRecipe(7114, 3854, 4319) -- Azure Silk Gloves
lib:AddRecipe(10300, 12056, 10007) -- Red Mageweave Vest
lib:AddRecipe(10301, 12059, 10008) -- White Bandit Mask
lib:AddRecipe(10302, 12060, 10009) -- Red Mageweave Pants
lib:AddRecipe(10303, 12062, 10010) -- Stormcloth Pants
lib:AddRecipe(10304, 12063, 10011) -- Stormcloth Gloves
lib:AddRecipe(10311, 12064, 10052) -- Orange Martial Shirt
lib:AddRecipe(10312, 12066, 10018) -- Red Mageweave Gloves
lib:AddRecipe(10313, 12068, 10020) -- Stormcloth Vest
lib:AddRecipe(10314, 12075, 10054) -- Lavender Mageweave Shirt
lib:AddRecipe(10315, 12078, 10029) -- Red Mageweave Shoulders
lib:AddRecipe(10316, 12047, 10048) -- Colorful Kilt
lib:AddRecipe(10317, 12080, 10055) -- Pink Mageweave Shirt
lib:AddRecipe(10318, 12081, 10030) -- Admiral's Hat
lib:AddRecipe(10319, 12083, 10032) -- Stormcloth Headband
lib:AddRecipe(10320, 12084, 10033) -- Red Mageweave Headband
lib:AddRecipe(10321, 12085, 10034) -- Tuxedo Shirt
lib:AddRecipe(10322, 12087, 10038) -- Stormcloth Shoulders
lib:AddRecipe(10323, 12089, 10035) -- Tuxedo Pants
lib:AddRecipe(10324, 12090, 10039) -- Stormcloth Boots
lib:AddRecipe(10325, 12091, 10040) -- White Wedding Dress
lib:AddRecipe(10326, 12093, 10036) -- Tuxedo Jacket
lib:AddRecipe(10463, 12086, 10025) -- Shadoweave Mask
lib:AddRecipe(10728, 3873, 4336) -- Black Swashbuckler's Shirt
lib:AddRecipe(14466, 18403, 13869) -- Frostweave Tunic
lib:AddRecipe(14467, 18404, 13868) -- Frostweave Robe
lib:AddRecipe(14468, 18405, 14046) -- Runecloth Bag
lib:AddRecipe(14469, 18406, 13858) -- Runecloth Robe
lib:AddRecipe(14470, 18407, 13857) -- Runecloth Tunic
lib:AddRecipe(14471, 18408, 14042) -- Cindercloth Vest
lib:AddRecipe(14472, 18409, 13860) -- Runecloth Cloak
lib:AddRecipe(14473, 18410, 14143) -- Ghostweave Belt
lib:AddRecipe(14474, 18411, 13870) -- Frostweave Gloves
lib:AddRecipe(14476, 18412, 14043) -- Cindercloth Gloves
lib:AddRecipe(14477, 18413, 14142) -- Ghostweave Gloves
lib:AddRecipe(14478, 18414, 14100) -- Brightcloth Robe
lib:AddRecipe(14479, 18415, 14101) -- Brightcloth Gloves
lib:AddRecipe(14480, 18416, 14141) -- Ghostweave Vest
lib:AddRecipe(14481, 18417, 13863) -- Runecloth Gloves
lib:AddRecipe(14482, 18418, 14044) -- Cindercloth Cloak
lib:AddRecipe(14483, 18419, 14107) -- Felcloth Pants
lib:AddRecipe(14484, 18420, 14103) -- Brightcloth Cloak
lib:AddRecipe(14485, 18421, 14132) -- Wizardweave Leggings
lib:AddRecipe(14486, 18422, 14134) -- Cloak of Fire
lib:AddRecipe(14488, 18423, 13864) -- Runecloth Boots
lib:AddRecipe(14489, 18424, 13871) -- Frostweave Pants
lib:AddRecipe(14490, 18434, 14045) -- Cindercloth Pants
lib:AddRecipe(14491, 18438, 13865) -- Runecloth Pants
lib:AddRecipe(14492, 18437, 14108) -- Felcloth Boots
lib:AddRecipe(14493, 18436, 14136) -- Robe of Winter Night
lib:AddRecipe(14494, 18439, 14104) -- Brightcloth Pants
lib:AddRecipe(14495, 18441, 14144) -- Ghostweave Pants
lib:AddRecipe(14496, 18442, 14111) -- Felcloth Hood
lib:AddRecipe(14497, 18440, 14137) -- Mooncloth Leggings
lib:AddRecipe(14498, 18444, 13866) -- Runecloth Headband
lib:AddRecipe(14499, 18445, 14155) -- Mooncloth Bag
lib:AddRecipe(14500, 18446, 14128) -- Wizardweave Robe
lib:AddRecipe(14501, 18447, 14138) -- Mooncloth Vest
lib:AddRecipe(14504, 18449, 13867) -- Runecloth Shoulders
lib:AddRecipe(14505, 18450, 14130) -- Wizardweave Turban
lib:AddRecipe(14506, 18451, 14106) -- Felcloth Robe
lib:AddRecipe(14507, 18448, 14139) -- Mooncloth Shoulders
lib:AddRecipe(14508, 18453, 14112) -- Felcloth Shoulders
lib:AddRecipe(14509, 18452, 14140) -- Mooncloth Circlet
lib:AddRecipe(14510, 18455, 14156) -- Bottomless Bag
lib:AddRecipe(14511, 18454, 14146) -- Gloves of Spell Mastery
lib:AddRecipe(14512, 18456, 14154) -- Truefaith Vestments
lib:AddRecipe(14513, 18457, 14152) -- Robe of the Archmage
lib:AddRecipe(14514, 18458, 14153) -- Robe of the Void
lib:AddRecipe(14526, 18560, 14342) -- Mooncloth
lib:AddRecipe(14627, 3869, 4332) -- Bright Yellow Shirt
lib:AddRecipe(14630, 3857, 4322) -- Enchanter's Cowl
lib:AddRecipe(17017, 20848, 16980) -- Flarecore Mantle
lib:AddRecipe(17018, 20849, 16979) -- Flarecore Gloves
lib:AddRecipe(17724, 21945, 17723) -- Green Holiday Shirt
lib:AddRecipe(18265, 22759, 18263) -- Flarecore Wraps
lib:AddRecipe(18414, 22866, 18405) -- Belt of the Archmage
lib:AddRecipe(18415, 22867, 18407) -- Felcloth Gloves
lib:AddRecipe(18416, 22868, 18408) -- Inferno Gloves
lib:AddRecipe(18417, 22869, 18409) -- Mooncloth Gloves
lib:AddRecipe(18418, 22870, 18413) -- Cloak of Warding
lib:AddRecipe(18487, 22902, 18486) -- Mooncloth Robe
lib:AddRecipe(19215, 23662, 19047) -- Wisdom of the Timbermaw
lib:AddRecipe(19216, 23664, 19056) -- Argent Boots
lib:AddRecipe(19217, 23665, 19059) -- Argent Shoulders
lib:AddRecipe(19218, 23663, 19050) -- Mantle of the Timbermaw
lib:AddRecipe(19219, 23666, 19156) -- Flarecore Robe
lib:AddRecipe(19220, 23667, 19165) -- Flarecore Leggings
lib:AddRecipe(19764, 24091, 19682) -- Bloodvine Vest
lib:AddRecipe(19765, 24092, 19683) -- Bloodvine Leggings
lib:AddRecipe(19766, 24093, 19684) -- Bloodvine Boots
lib:AddRecipe(20546, 24901, 20538) -- Runed Stygian Leggings
lib:AddRecipe(20547, 24903, 20537) -- Runed Stygian Boots
lib:AddRecipe(20548, 24902, 20539) -- Runed Stygian Belt
lib:AddRecipe(21358, 26085, 21340) -- Soul Pouch
lib:AddRecipe(21369, 26086, 21341) -- Felcloth Bag
lib:AddRecipe(21371, 26087, 21342) -- Core Felcloth Bag
lib:AddRecipe(21722, 26403, 21154) -- Festival Dress
lib:AddRecipe(21723, 26407, 21542) -- Festive Red Pant Suit
lib:AddRecipe(21892, 26747, 21842) -- Bolt of Imbued Netherweave
lib:AddRecipe(21893, 26749, 21843) -- Imbued Netherweave Bag
lib:AddRecipe(21894, 26750, 21844) -- Bolt of Soulcloth
lib:AddRecipe(21895, 26751, 21845) -- Primal Mooncloth
lib:AddRecipe(21896, 26773, 21854) -- Netherweave Robe
lib:AddRecipe(21897, 26774, 21855) -- Netherweave Tunic
lib:AddRecipe(21898, 26775, 21859) -- Imbued Netherweave Pants
lib:AddRecipe(21899, 26776, 21860) -- Imbued Netherweave Boots
lib:AddRecipe(21900, 26777, 21861) -- Imbued Netherweave Robe
lib:AddRecipe(21901, 26778, 21862) -- Imbued Netherweave Tunic
lib:AddRecipe(21902, 26779, 21863) -- Soulcloth Gloves
lib:AddRecipe(21903, 26780, 21864) -- Soulcloth Shoulders
lib:AddRecipe(21904, 26781, 21865) -- Soulcloth Vest
lib:AddRecipe(21905, 26782, 21866) -- Arcanoweave Bracers
lib:AddRecipe(21906, 26783, 21867) -- Arcanoweave Boots
lib:AddRecipe(21907, 26784, 21868) -- Arcanoweave Robe
lib:AddRecipe(21908, 26752, 21846) -- Spellfire Belt
lib:AddRecipe(21909, 26753, 21847) -- Spellfire Gloves
lib:AddRecipe(21910, 26754, 21848) -- Spellfire Robe
lib:AddRecipe(21911, 26755, 21858) -- Spellfire Bag
lib:AddRecipe(21912, 26756, 21869) -- Frozen Shadoweave Shoulders
lib:AddRecipe(21913, 26758, 21871) -- Frozen Shadoweave Robe
lib:AddRecipe(21914, 26757, 21870) -- Frozen Shadoweave Boots
lib:AddRecipe(21915, 26759, 21872) -- Ebon Shadowbag
lib:AddRecipe(21916, 26760, 21873) -- Primal Mooncloth Belt
lib:AddRecipe(21917, 26762, 21875) -- Primal Mooncloth Robe
lib:AddRecipe(21918, 26761, 21874) -- Primal Mooncloth Shoulders
lib:AddRecipe(21919, 26763, 21876) -- Primal Mooncloth Bag
lib:AddRecipe(21924, 18406, 13858) -- Runecloth Robe
lib:AddRecipe(22307, 27658, 22246) -- Enchanted Mageweave Pouch
lib:AddRecipe(22308, 27659, 22248) -- Enchanted Runecloth Bag
lib:AddRecipe(22309, 27660, 22249) -- Big Bag of Enchantment
lib:AddRecipe(22310, 27724, 22251) -- Cenarion Herb Bag
lib:AddRecipe(22312, 27725, 22252) -- Satchel of Cenarius
lib:AddRecipe(22683, 28210, 22660) -- Gaea's Embrace
lib:AddRecipe(22684, 28205, 22654) -- Glacial Gloves
lib:AddRecipe(22685, 28208, 22658) -- Glacial Cloak
lib:AddRecipe(22686, 28207, 22652) -- Glacial Vest
lib:AddRecipe(22687, 28209, 22655) -- Glacial Wrists
lib:AddRecipe(22772, 28482, 22758) -- Sylvan Shoulders
lib:AddRecipe(22773, 28481, 22757) -- Sylvan Crown
lib:AddRecipe(22774, 28480, 22756) -- Sylvan Vest
lib:AddRecipe(24292, 31430, 24273) -- Mystic Spellthread
lib:AddRecipe(24293, 31431, 24275) -- Silver Spellthread
lib:AddRecipe(24294, 31432, 24274) -- Runic Spellthread
lib:AddRecipe(24295, 31433, 24276) -- Golden Spellthread
lib:AddRecipe(24296, 31434, 24249) -- Unyielding Bracers
lib:AddRecipe(24297, 31435, 24250) -- Bracers of Havok
lib:AddRecipe(24298, 31437, 24251) -- Blackstrike Bracers
lib:AddRecipe(24299, 31438, 24252) -- Cloak of the Black Void
lib:AddRecipe(24300, 31440, 24253) -- Cloak of Eternity
lib:AddRecipe(24301, 31441, 24254) -- White Remedy Cape
lib:AddRecipe(24302, 31442, 24255) -- Unyielding Girdle
lib:AddRecipe(24303, 31443, 24256) -- Girdle of Ruination
lib:AddRecipe(24304, 31444, 24257) -- Black Belt of Knowledge
lib:AddRecipe(24305, 31448, 24258) -- Resolute Cape
lib:AddRecipe(24306, 31449, 24259) -- Vengeance Wrap
lib:AddRecipe(24307, 31450, 24260) -- Manaweave Cloak
lib:AddRecipe(24308, 31451, 24261) -- Whitemend Pants
lib:AddRecipe(24309, 31452, 24262) -- Spellstrike Pants
lib:AddRecipe(24310, 31453, 24263) -- Battlecast Pants
lib:AddRecipe(24311, 31454, 24264) -- Whitemend Hood
lib:AddRecipe(24312, 31455, 24266) -- Spellstrike Hood
lib:AddRecipe(24313, 31456, 24267) -- Battlecast Hood
lib:AddRecipe(24314, 31459, 24270) -- Bag of Jewels
lib:AddRecipe(24315, 31461, 24269) -- Heavy Netherweave Net
lib:AddRecipe(24316, 31373, 24271) -- Spellcloth
lib:AddRecipe(29120, 18456, 14154) -- Truefaith Vestments
lib:AddRecipe(30280, 36315, 30038) -- Belt of Blasting
lib:AddRecipe(30281, 36316, 30036) -- Belt of the Long Road
lib:AddRecipe(30282, 36317, 30037) -- Boots of Blasting
lib:AddRecipe(30283, 36318, 30035) -- Boots of the Long Road
lib:AddRecipe(30469, 36665, 30459) -- Netherflame Robe
lib:AddRecipe(30470, 36667, 30460) -- Netherflame Belt
lib:AddRecipe(30471, 36668, 30461) -- Netherflame Boots
lib:AddRecipe(30472, 36669, 30465) -- Lifeblood Leggings
lib:AddRecipe(30473, 36670, 30463) -- Lifeblood Belt
lib:AddRecipe(30474, 36672, 30464) -- Lifeblood Bracers
lib:AddRecipe(30483, 36686, 24272) -- Shadowcloth
lib:AddRecipe(30833, 37873, 30831) -- Cloak of Arcane Evasion
lib:AddRecipe(30842, 37882, 30837) -- Flameheart Bracers
lib:AddRecipe(30843, 37883, 30838) -- Flameheart Gloves
lib:AddRecipe(30844, 37884, 30839) -- Flameheart Vest
lib:AddRecipe(32437, 40020, 32391) -- Soulguard Slippers
lib:AddRecipe(32438, 40021, 32392) -- Soulguard Bracers
lib:AddRecipe(32439, 40023, 32389) -- Soulguard Leggings
lib:AddRecipe(32440, 40024, 32390) -- Soulguard Girdle
lib:AddRecipe(32447, 40060, 32420) -- Night's End
lib:AddRecipe(32752, 41207, 32584) -- Swiftheal Wraps
lib:AddRecipe(32753, 41208, 32585) -- Swiftheal Mantle
lib:AddRecipe(32754, 41205, 32586) -- Bracers of Nimble Thought
lib:AddRecipe(32755, 41206, 32587) -- Mantle of Nimble Thought
lib:AddRecipe(34261, 44950, 34087) -- Green Winter Clothes
lib:AddRecipe(34319, 44958, 34085) -- Red Winter Clothes
lib:AddRecipe(35204, 46128, 34366) -- Sunfire Handwraps
lib:AddRecipe(35205, 46129, 34367) -- Hands of Eternal Light
lib:AddRecipe(35206, 46130, 34364) -- Sunfire Robe
lib:AddRecipe(35207, 46131, 34365) -- Robe of Eternal Light
lib:AddRecipe(35308, 31434, 24249) -- Unyielding Bracers
lib:AddRecipe(35309, 31442, 24255) -- Unyielding Girdle
lib:AddRecipe(35518, 41205, 32586) -- Bracers of Nimble Thought
lib:AddRecipe(35522, 41206, 32587) -- Mantle of Nimble Thought
lib:AddRecipe(35525, 41208, 32585) -- Swiftheal Mantle
lib:AddRecipe(35526, 41207, 32584) -- Swiftheal Wraps
lib:AddRecipe(35544, 46129, 34367) -- Hands of Eternal Light
lib:AddRecipe(35548, 46131, 34365) -- Robe of Eternal Light
lib:AddRecipe(35551, 46128, 34366) -- Sunfire Handwraps
lib:AddRecipe(35552, 46130, 34364) -- Sunfire Robe
lib:AddRecipe(37915, 49677, 6836) -- Dress Shoes
lib:AddRecipe(38229, 50194, 38225) -- Mycah's Botanical Bag
lib:AddRecipe(38327, 50644, 38277) -- Haliscan Jacket
lib:AddRecipe(38328, 50647, 38278) -- Haliscan Pantaloons
lib:AddRecipe(42172, 55993, 41248) -- Red Lumberjack Shirt
lib:AddRecipe(42173, 55994, 41249) -- Blue Lumberjack Shirt
lib:AddRecipe(42174, 55995, 41251) -- Yellow Lumberjack Shirt
lib:AddRecipe(42175, 55996, 41250) -- Green Lumberjack Shirt
lib:AddRecipe(42176, 55998, 41253) -- Blue Workman's Shirt
lib:AddRecipe(42177, 55997, 41252) -- Red Workman's Shirt
lib:AddRecipe(42178, 55999, 41254) -- Rustic Workman's Shirt
lib:AddRecipe(42179, 56000, 41255) -- Green Workman's Shirt
lib:AddRecipe(42180, 56002, 41593) -- Ebonweave
lib:AddRecipe(42181, 56001, 41594) -- Moonshroud
lib:AddRecipe(42182, 56003, 41595) -- Spellweave
lib:AddRecipe(42183, 56004, 41597) -- Abyssal Bag
lib:AddRecipe(42184, 56005, 41600) -- Glacial Bag
lib:AddRecipe(42185, 56006, 41598) -- Mysterious Bag
lib:AddRecipe(42186, 56007, 41599) -- Frostweave Bag
lib:AddRecipe(42187, 56009, 41602) -- Brilliant Spellthread
lib:AddRecipe(42188, 56011, 41604) -- Sapphire Spellthread
lib:AddRecipe(42189, 56016, 41609) -- Wispcloak
lib:AddRecipe(42190, 56017, 41610) -- Deathchill Cloak
lib:AddRecipe(42191, 56018, 41984) -- Hat of Wintry Doom
lib:AddRecipe(42192, 56019, 41985) -- Silky Iceshard Boots
lib:AddRecipe(42193, 56020, 41986) -- Deep Frozen Cord
lib:AddRecipe(42194, 56021, 42093) -- Frostmoon Pants
lib:AddRecipe(42195, 56022, 42095) -- Light Blessed Mittens
lib:AddRecipe(42196, 56023, 42096) -- Aurora Slippers
lib:AddRecipe(42197, 56024, 42100) -- Moonshroud Robe
lib:AddRecipe(42198, 56025, 42103) -- Moonshroud Gloves
lib:AddRecipe(42199, 56026, 42101) -- Ebonweave Robe
lib:AddRecipe(42200, 56027, 42111) -- Ebonweave Gloves
lib:AddRecipe(42201, 56028, 42102) -- Spellweave Robe
lib:AddRecipe(42202, 56029, 42113) -- Spellweave Gloves
lib:AddRecipe(44916, 26403, 21154) -- Festival Dress
lib:AddRecipe(44917, 26407, 21542) -- Festive Red Pant Suit
lib:AddRecipe(45102, 63203, 45557) -- Sash of Ancient Power
lib:AddRecipe(45103, 63204, 45566) -- Spellslinger's Slippers
lib:AddRecipe(45104, 63205, 45558) -- Cord of the White Dawn
lib:AddRecipe(45105, 63206, 45567) -- Savior's Slippers
lib:AddRecipe(45774, 63924, 45773) -- Emerald Bag
lib:AddRecipe(47636, 67144, 47606) -- Royal Moonshroud Robe
lib:AddRecipe(47637, 67147, 47588) -- Royal Moonshroud Bracers
lib:AddRecipe(47638, 67146, 47604) -- Merlin's Robe
lib:AddRecipe(47639, 67145, 47586) -- Bejeweled Wizard's Bracers
lib:AddRecipe(47654, 67079, 47585) -- Bejeweled Wizard's Bracers
lib:AddRecipe(47655, 67066, 47603) -- Merlin's Robe
lib:AddRecipe(47656, 67065, 47587) -- Royal Moonshroud Bracers
lib:AddRecipe(47657, 67064, 47605) -- Royal Moonshroud Robe
lib:AddRecipe(49953, 70550, 49891) -- Leggings of Woven Death
lib:AddRecipe(49954, 70551, 49890) -- Deathfrost Boots
lib:AddRecipe(49955, 70552, 49892) -- Lightweave Leggings
lib:AddRecipe(49956, 70553, 49893) -- Sandals of Consecration
lib:AddRecipe(54798, 75597, 54797) -- Frosty Flying Carpet

--------------------------------------------------------------------------------
--  End Wrath of the Lich King Classic Data                                   --
end                                                                           --
--------------------------------------------------------------------------------

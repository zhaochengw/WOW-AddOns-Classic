_G['BMUtils'] = {}
_G['BMUtils-v1.10'] = _G['BMUtils']
---@class BMUtils
local lib = _G['BMUtils']
local version = 'v1.10'
local v_major, v_minor = _G['BMUtils-Version'].parse_version(version)
if _G.LibStub then
    lib = _G.LibStub:NewLibrary("BM-utils-" .. v_major, v_minor)
end

if not lib then
    -- luacov: disable
    return    -- already loaded and no upgrade necessary
    -- luacov: enable
end
lib.version = version
lib.v_major, lib.v_minor = v_major, v_minor

---@type BMGettext
lib.gettext = _G['BMUtils-gettext-@version@']
---@type BMUtilsContainer
lib.container = _G['BMUtils-container-@version@']
---@type BMUtilBasic
lib.basic = _G['BMUtils-basic-@version@']

function lib:printf(str, ...)
    return _G.DEFAULT_CHAT_FRAME:AddMessage(string.format(str, ...))
end

function lib:sprintf(str, ...)
    return string.format(str, ...)
end

local next = _G.next
--- Check if a value if empty
function lib:empty(value)
    if value == nil then
        return true
    elseif type(value) == 'table' then
        return next(value) == nil
    elseif type(value) == 'string' then
        return value == ''
    elseif type(value) == 'boolean' then
        return not value
    end
    return false
end

--/run print(LibStub('BM-utils-1.0'):colorize('red', 'ffff0000'))
--/run print(LibStub('BM-utils-1.0'):colorize('green', 'FF00FF00'))
--- Add the specified color to a string
--- @param str string Text to be colorized
--- @param r number|string Red or RGB string
--- @param g number Green
--- @param b number Blue
---@return string String with color
function lib:colorize(str, r, g, b)
    local rgb
    assert(str, 'Empty string')
    if type(r) == type(g) and type(g) == type(b) and type(r) == 'number' then
        rgb = self:GenerateHexColor(r, g, b)
    elseif type(r) == 'string' and g == nil and b == nil then
        rgb = r
    else
        error('Invalid arguments')
    end

    --[==[@debug@
    self:printf('RGB: %s', rgb)
    --@end-debug@]==]
    return string.format('|c%s%s|r', rgb, str)
end

lib.DEFAULT_FONT_COLOR = { ["R"] = 1, ["G"] = 1, ["B"] = 1 }
function lib:SetDefaultFontColor(r, g, b)
    self.DEFAULT_FONT_COLOR = { ["R"] = r, ["G"] = g, ["B"] = b }
end

--/run LibStub('BM-utils-1.0'):cprint('red', 1, 0, 0)
--- Add a message to chat frame with colors
--- @param message string Message text
--- @param r number Red
--- @param g number Green
--- @param b number Blue
function lib:cprint(message, r, g, b)
    return _G.DEFAULT_CHAT_FRAME:AddMessage(message,
            (r or self.DEFAULT_FONT_COLOR["R"]),
            (g or self.DEFAULT_FONT_COLOR["G"]),
            (b or self.DEFAULT_FONT_COLOR["B"]));
end

function lib:IsWoWClassic(allow_tbc, allow_wrath)
    if (allow_wrath == nil or allow_wrath == true) and (allow_tbc == nil or allow_tbc == true) then
        return select(4, _G.GetBuildInfo()) < 40000
    elseif allow_tbc == nil or allow_tbc == true then
        return select(4, _G.GetBuildInfo()) < 30000
    else
        return select(4, _G.GetBuildInfo()) < 20000
    end
end

--- Add a message to chat frame with red color
--- @param message string Message text
function lib:error(message)
    return self:cprint(message, 1, 0, 0)
end

--- Get character name and realm, fall back to current player if character not specified
function lib:GetCharacterInfo(character, realm)
    if not character or character == "" then
        character = _G.UnitName("player")
    end
    if not realm then
        realm = _G.GetRealmName()
    end
    return character, realm
end

--- Get character name and realm as a string
function lib:GetCharacterString(character, realm)
    character, realm = self:GetCharacterInfo(character, realm)
    return string.format('%s-%s', character, realm)
end

function lib:SplitCharacterString(name)
    return string.match(name, "(.+)-(.+)")
end

--- Convert a color table with 0.0-1.0 floats to a 0-255 RGB int
--- @param r number|table Red or table with r, g and b as keys
--- @param g number Green
--- @param b number Blue
---@return number, number, number
function lib:ColorToRGB(r, g, b)
    local color
    if type(r) == 'table' then
        color = r
    else
        color = { r = r, g = g, b = b }
    end

    return 255 * color['r'], 255 * color['g'], 255 * color['b']
end

function lib:GenerateHexColor(r, g, b)
    return ("ff%.2x%.2x%.2x"):format(r, g, b);
    -- return string.format('%02X%02X%02X', r, g, b)
end

-- Convert a color table with 0.0-1.0 floats to a RGB hex string
function lib:ColorToHex(color)
    local r, g, b = self:ColorToRGB(color)
    return self:GenerateHexColor(r, g, b)
end

--/dump LibStub("BM-utils-1.0"):DifficultyToNum("medium")
function lib:DifficultyToNum(difficulty)
    local difficulties = {
        ["optimal"]	= 4,
        ["orange"]	= 4,
        ["medium"]	= 3,
        ["yellow"]	= 3,
        ["easy"]	= 2,
        ["green"]	= 2,
        ["trivial"]	= 1,
        ["gray"]	= 1,
        ["grey"]	= 1,
    }
    return difficulties[difficulty]
end

--/dump LibStub("BM-utils-1.0"):DifficultyColor("medium")
function lib:DifficultyColor(difficulty, return_ColorMixin)
    local TradeSkillTypeColor = {}
    TradeSkillTypeColor["optimal"]	= { r = 1.00, g = 0.50, b = 0.25, font = "GameFontNormalLeftOrange" };
    TradeSkillTypeColor["medium"]	= { r = 1.00, g = 1.00, b = 0.00, font = "GameFontNormalLeftYellow" };
    TradeSkillTypeColor["easy"]		= { r = 0.25, g = 0.75, b = 0.25, font = "GameFontNormalLeftLightGreen" };
    TradeSkillTypeColor["trivial"]	= { r = 0.50, g = 0.50, b = 0.50, font = "GameFontNormalLeftGrey" };
    TradeSkillTypeColor["header"]	= { r = 1.00, g = 0.82, b = 0,    font = "GameFontNormalLeft" };

    if return_ColorMixin then
        local colors = TradeSkillTypeColor[difficulty]
        return _G.CreateColor(colors['r'], colors['g'], colors['b'], 255)
    else
        return TradeSkillTypeColor[difficulty]
    end
end

function lib:DifficultyColorText(text, difficulty)
    local color = self:DifficultyColor(difficulty, true)
    --text = CreateColor(colors['r'], colors['g'], colors['b'], 255):WrapTextInColorCode(text)
    return color:WrapTextInColorCode(text)
end

--Reference:
--https://wowwiki.fandom.com/wiki/UI_escape_sequences
--https://wow.gamepedia.com/ItemLink
--https://wowwiki.fandom.com/wiki/ItemLink

--- Extract itemId from a link
--- @param itemLink string Item link
--- @return number Item ID
function lib:ItemIdFromLink(itemLink)
    if itemLink == nil then
        return nil
    end
    return tonumber(string.match(itemLink, "item:(%d+)"))
end

--- Get item name from item link
--- @param itemLink string Item link
--- @return string Item name
function lib:ItemNameFromLink(itemLink)
    return string.match(itemLink, "%[(.-)%]")
end

--- Localization safe method to cast spells
--- @param spellId number The ID of the spell to cast
function lib:CastSpellById(spellId)
    local spellName = _G.GetSpellInfo(spellId)
    return _G.CastSpellByName(spellName)
end
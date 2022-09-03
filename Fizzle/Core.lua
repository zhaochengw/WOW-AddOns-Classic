-- Create the addon
Fizzle = LibStub("AceAddon-3.0"):NewAddon("Fizzle", "AceEvent-3.0", "AceBucket-3.0", "AceHook-3.0", "AceConsole-3.0")
local Fizzle = Fizzle
local defaults = {
    profile = {
        Percent = true,
        Border = true,
        Invert = false,
        HideText = false,
        DisplayWhenFull = true,
        modules = {
            ["Inspect"] = true,
        },
        showiLevel = true,
        inspectiLevel = false,
    },
}

local L = LibStub("AceLocale-3.0"):GetLocale("Fizzle")
local fontSize = 12
local _G = _G
local sformat = string.format
local ipairs = ipairs
local db -- We'll put our saved vars here later

-- Make some of the inventory functions more local (ordered by string length!)
local GetAddOnMetadata = GetAddOnMetadata
local GetItemQualityColor = GetItemQualityColor
local GetInventorySlotInfo = GetInventorySlotInfo
local GetInventoryItemLink = GetInventoryItemLink
local GetInventoryItemQuality = GetInventoryItemQuality
local GetDetailedItemLevelInfo = GetDetailedItemLevelInfo
local GetInventoryItemDurability = GetInventoryItemDurability

-- Flag to check if the borders were created or not
local bordersCreated = false
local items, nditems -- our item slot tables

-- Return an options table full of goodies!
local function getOptions()
    local options = {
        type = "group",
        name = GetAddOnMetadata("Fizzle", "Title"),
        args = {
            fizzledesc = {
                type = "description",
                order = 0,
                name = GetAddOnMetadata("Fizzle", "Notes"),
            },
            percent = {
                name = L["Percent"],
                desc = L["Toggle percentage display."],
                type = "toggle",
                order = 100,
                width = "full",
                get = function() return db.Percent end,
                set = function()
                    db.Percent = not db.Percent
                    Fizzle:UpdateItems()
                end,
            },
            border = {
                name = L["Border"],
                desc = L["Toggle quality borders."],
                type = "toggle",
                order = 200,
                width = "full",
                get = function() return db.Border end,
                set = function()
                    db.Border = not db.Border
                    Fizzle:BorderToggle()
                end,
            },
            invert = {
                name = L["Invert"],
                desc = L["Show numbers the other way around. Eg. 0% = full durability , 100 = no durability."],
                type = "toggle",
                order = 300,
                width = "full",
                get = function() return db.Invert end,
                set = function()
                    db.Invert = not db.Invert
                    Fizzle:UpdateItems()
                end,
            },
            hidetext = {
                name = L["Hide Text"],
                desc = L["Hide durability text."],
                type = "toggle",
                order = 400,
                width = "full",
                get = function() return db.HideText end,
                set = function()
                    db.HideText = not db.HideText
                    Fizzle:UpdateItems()
                end,
            },
            showfull = {
                name = L["Show Full"],
                desc = L["Show durability when full."],
                type = "toggle",
                order = 500,
                width = "full",
                get = function() return db.DisplayWhenFull end,
                set = function()
                    db.DisplayWhenFull = not db.DisplayWhenFull
                    Fizzle:UpdateItems()
                end,
            },
            showilevel = {
                name = "Show iLevel",
                desc = "Show items' iLevel",
                type = "toggle",
                order = 510,
                width = "full",
                get = function() return db.showiLevel end,
                set = function()
                    db.showiLevel = not db.showiLevel
                    Fizzle:UpdateItems()
                end,
            },
            -- Inspect module toggle
            inspect = {
                name = L["Inspect"],
                desc = L["Show item quality when inspecting people."],
                type = "toggle",
                order = 600,
                width = "full",
                get = function() return db.modules["Inspect"] end,
                set = function(info, v)
                    db.modules["Inspect"] = v
                    if v then
                        Fizzle:EnableModule("Inspect")
                    else
                        Fizzle:DisableModule("Inspect")
                    end
                end,
            },
            inspectilevel = {
                name = "Inspect iLevels",
                desc = "Show the iLevel on an inspected characters items.",
                type = "toggle",
                disabled = function() return not db.modules["Inspect"] end,
                order = 610,
                width = "full",
                get = function() return db.inspectiLevel end,
                set = function()
                    db.inspectiLevel = not db.inspectiLevel
                end,
            },
        }
    }
    return options
end

-- Detect if we're running in the Classic client
local IsClassic
do
    local is_retail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
    local is_classic = not is_retail

    -- Returns true on a Classic client or nil at other times.
    IsClassic = function()
        return is_classic
    end
end

function Fizzle:OnInitialize()
    -- Grab our db
    self.db = LibStub("AceDB-3.0"):New("FizzleDB", defaults)
    db = self.db.profile

    -- Get the addon title.
    local title = GetAddOnMetadata("Fizzle", "Title")

    -- Register our options
    LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("Fizzle", getOptions)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Fizzle", title)

    -- Register chat command to open options dialog
    self:RegisterChatCommand("fizzle", function()
        InterfaceOptionsFrame_OpenToCategory(title)
    end)

    self:RegisterChatCommand("fizz", function()
        InterfaceOptionsFrame_OpenToCategory(title)
    end)
end

function Fizzle:OnEnable()
    self:SecureHookScript(CharacterFrame, "OnShow", "CharacterFrame_OnShow")
    self:SecureHookScript(CharacterFrame, "OnHide", "CharacterFrame_OnHide")

    if not bordersCreated then
        self:MakeTypeTable()
    end
end

function Fizzle:OnDisable()
    for _, item in ipairs(items) do
        _G[item .. "FizzleS"]:SetText("")
    end

    self:HideBorders()
end

function Fizzle:CreateBorder(slottype, slot, name, hasText)
    local gslot = _G[slottype..slot.."Slot"]
    local height = 68
    local width = 68

    -- Ammo slot is smaller than the rest.
    if slot == "Ammo" then
        height = 58
        width = 58
    end

    if gslot then
        -- Create border
        local border = gslot:CreateTexture(slot .. name .. "B", "OVERLAY")
        border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
        border:SetBlendMode("ADD")
        border:SetAlpha(0.75)
        border:SetHeight(height)
        border:SetWidth(width)
        border:SetPoint("CENTER", gslot, "CENTER", 0, 1)
        border:Hide()

        -- Check if we need a text field creating
        if hasText then
            local str = gslot:CreateFontString(slot .. name .. "S", "OVERLAY")
            local font, _, flags = NumberFontNormal:GetFont()
            str:SetFont(font, fontSize, flags)
            str:SetPoint("CENTER", gslot, "BOTTOM", 0, 8)
        end

        -- Strings for iLevels
        local iLevelStr = gslot:CreateFontString(slot .. name .. "iLevel", "OVERLAY")
        local font, _, flags = NumberFontNormal:GetFont()
        iLevelStr:SetFont(font, fontSize, flags)
        iLevelStr:SetPoint("CENTER", gslot, "TOP", 0, -5)
    end
end

function Fizzle:MakeTypeTable()
    -- Table of item types and slots.  Thanks Tekkub.
    items = {
        "Head",
        "Shoulder",
        "Chest",
        "Waist",
        "Legs",
        "Feet",
        "Wrist",
        "Hands",
        "MainHand",
        "SecondaryHand",
    }

    -- Items without durability but with some quality, needed for border colouring.
    nditems = {
        "Neck",
        "Back",
        "Finger0",
        "Finger1",
        "Trinket0",
        "Trinket1",
        "Tabard",
        "Shirt",
    }

    if IsClassic() then
        -- Ranged slot exists in Classic.
        items[#items + 1] = "Ranged"

        -- Ammo and Relic slots exist in Classic
        nditems[#items + 1] = "Ammo"
        nditems[#items + 1] = "Relic"
    end

    for _, item in ipairs(items) do
        self:CreateBorder("Character", item, "Fizzle", true)
    end

    -- Same again, but for ND items, and only creating a border
    for _, nditem in ipairs(nditems) do
        self:CreateBorder("Character", nditem, "Fizzle", false)
    end
end

local function GetThresholdColour(percent)
    if percent < 0 then
        return 1, 0, 0
    elseif percent <= 0.5 then
        return 1, percent * 2, 0
    elseif percent >= 1 then
        return 0, 1, 0
    else
        return 2 - percent * 2, 1, 0
    end
end

-- Returns: current, max, percent
local function GetDurabilityNumbers(slotId)
    local cur, max = GetInventoryItemDurability(slotId)
    cur, max = tonumber(cur) or 0, tonumber(max) or 0

    local percent = cur / max * 100

    return cur, max, percent
end

-- Returns: ilevel
local function GetiLevel(slotId)
    local link = GetInventoryItemLink("player", slotId)

    if link then
        local iLevel = GetDetailedItemLevelInfo(link)
        if iLevel then
            return iLevel
        end
    end
    return nil
end

function Fizzle:UpdateItems()
    -- Don't update unless the charframe is open.
    -- No point updating what we can't see.
    if CharacterFrame:IsVisible() then
        -- Go and set the durability string for each slot that has an item equipped that has durability.
        -- Thanks Tekkub again for the base of this code.
        for _, item in ipairs(items) do
            local id, _ = GetInventorySlotInfo(item .. "Slot")
            local str = _G[item.."FizzleS"]

            local cur, max, percent = GetDurabilityNumbers(id)

            if (((max ~= 0) and ((percent ~= 100) or db.DisplayWhenFull)) and not db.HideText) then
                local text

                -- Colour our string depending on current durability percentage
                str:SetTextColor(GetThresholdColour(cur / max))

                if db.Invert then
                    cur = max - cur
                    percent = 100 - percent
                end

                -- Are we showing the % or raw cur/max
                if db.Percent then
                    text = sformat("%d%%", percent)
                else
                    text = cur.."/"..max
                end

                str:SetText(text)
            else
                -- No durability in slot, so hide the text.
                str:SetText("")
            end

            -- display item levels
            self:ShowiLevel(item, id)

            --Finally, colour the borders
            self:ColourBorders(id, item)
        end

        for _, item in ipairs(nditems) do
            local id, _ = GetInventorySlotInfo(item .. "Slot")

            self:ShowiLevel(item, id)
            self:ColourBorders(id, item)
        end
    end
end

function Fizzle:CharacterFrame_OnShow()
    self:RegisterEvent("UNIT_INVENTORY_CHANGED", "UpdateItems")
    self:RegisterBucketEvent("UPDATE_INVENTORY_DURABILITY", 0.5, "UpdateItems")
    self:UpdateItems()
end

function Fizzle:CharacterFrame_OnHide()
    self:UnregisterEvent("UNIT_INVENTORY_CHANGED")
    self:UnregisterBucket("UPDATE_INVENTORY_DURABILITY")
end


-- Fetch and display iLevel if appropriate
function Fizzle:ShowiLevel(item, id)
    -- add the ilevel if desired
    local istr = _G[item .. "FizzleiLevel"]
    if not istr then return end

    if db.showiLevel then
        istr:SetText(GetiLevel(id))
        istr:Show()
    else
        istr:Hide()
    end
end

function Fizzle:ColourBorders(slotID, rawslot)
    local slot = _G[rawslot.."FizzleB"]
    if not (slot and db.Border) then return end

    local quality = GetInventoryItemQuality("player", slotID)

    if quality then
        local r, g, b, _ = GetItemQualityColor(quality)
        slot:SetVertexColor(r, g, b)
        slot:Show()
    else
        slot:Hide()
    end
end

-- Toggle the border colouring
function Fizzle:BorderToggle()
    if not db.Border then
        self:HideBorders()
    else
        self:UpdateItems()
    end
end

-- Hide quality borders
function Fizzle:HideBorders()
    for _, item in ipairs(items) do
        local border = _G[item.."FizzleB"]
        if border then
            border:Hide()
        end
    end

    for _, nditem in ipairs(nditems) do
        local border = _G[nditem.."FizzleB"]
        if border then
            border:Hide()
        end
    end
end

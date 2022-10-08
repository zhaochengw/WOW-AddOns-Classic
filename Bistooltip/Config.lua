local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local db_defaults = {
    char = {
        class_index = 1,
        spec_index = 1,
        phase_index = 1,
        filter_specs = {},
        highlight_spec = {}
    }
}

local configTable = {
    type = "group",
    args = {
        filter_class_names = {
            name = "Filter class names",
            desc = "Removes class name separators from item tooltips",
            type = "toggle",
            set = function(info, val)
                BistooltipAddon.db.char.filter_class_names = val
            end,
            get = function(info)
                return BistooltipAddon.db.char.filter_class_names
            end
        },
        filter_specs = {
            name = "Filter specs",
            desc = "Removes unselected specs from item tooltips",
            type = "multiselect",
            values = nil,
            set = function(info, key, val)
                local ci, si = strsplit(":", key)
                ci = tonumber(ci)
                si = tonumber(si)
                local class_name = Bistooltip_classes[ci].name
                local spec_name = Bistooltip_classes[ci].specs[si]
                BistooltipAddon.db.char.filter_specs[class_name][spec_name] = val
            end,
            get = function(info, key)
                local ci, si = strsplit(":", key)
                ci = tonumber(ci)
                si = tonumber(si)
                local class_name = Bistooltip_classes[ci].name
                local spec_name = Bistooltip_classes[ci].specs[si]
                if (not BistooltipAddon.db.char.filter_specs[class_name]) then
                    BistooltipAddon.db.char.filter_specs[class_name] = {}
                end
                if (BistooltipAddon.db.char.filter_specs[class_name][spec_name] == nil) then
                    BistooltipAddon.db.char.filter_specs[class_name][spec_name] = true
                end
                return BistooltipAddon.db.char.filter_specs[class_name][spec_name]
            end
        },
        highlight_spec = {
            name = "Highlight spec",
            desc = "Highlights selected spec in item tooltips",
            type = "multiselect",
            values = nil,
            set = function(info, key, val)
                if val then
                    local ci, si = strsplit(":", key)
                    ci = tonumber(ci)
                    si = tonumber(si)
                    local class_name = Bistooltip_classes[ci].name
                    local spec_name = Bistooltip_classes[ci].specs[si]
                    BistooltipAddon.db.char.highlight_spec = {
                        key = key,
                        class_name = class_name,
                        spec_name = spec_name
                    }
                else
                    BistooltipAddon.db.char.highlight_spec = {
                    }
                end

            end,
            get = function(info, key)
                return BistooltipAddon.db.char.highlight_spec.key == key
            end
        }
    }
}

local function buildFilterSpecOptions()
    local filter_specs_options = {}
    for ci, class in ipairs(Bistooltip_classes) do
        for si, spec in ipairs(Bistooltip_classes[ci].specs) do
            local option_val = "|T" .. Bistooltip_spec_icons[class.name][spec] .. ":16|t " .. class.name .. " " .. spec
            local option_key = ci .. ":" .. si
            filter_specs_options[option_key] = option_val
        end
    end
    configTable.args.filter_specs.values = filter_specs_options
    configTable.args.highlight_spec.values = filter_specs_options
end

local function migrateAddonDB()
    if not BistooltipAddon.db.char["version"] then
        BistooltipAddon.db.char.version = 6.1
        BistooltipAddon.db.char.highlight_spec = {}
        BistooltipAddon.db.char.filter_specs = {}
        BistooltipAddon.db.char.class_index = 1
        BistooltipAddon.db.char.spec_index = 1
        BistooltipAddon.db.char.phase_index = 1
    end
end

local config_shown = false
function BistooltipAddon:openConfigDialog()
    if config_shown then
        InterfaceOptionsFrame_Show()
    else
        InterfaceOptionsFrame_OpenToCategory(BistooltipAddon.AceAddonName)
        InterfaceOptionsFrame_OpenToCategory(BistooltipAddon.AceAddonName)
    end
    config_shown = not (config_shown)
end

function BistooltipAddon:initConfig()
    BistooltipAddon.db = LibStub("AceDB-3.0"):New("BisTooltipDB", db_defaults, true)

    buildFilterSpecOptions()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(BistooltipAddon.AceAddonName, configTable)
    AceConfigDialog:AddToBlizOptions(BistooltipAddon.AceAddonName, BistooltipAddon.AceAddonName)
    migrateAddonDB()
end
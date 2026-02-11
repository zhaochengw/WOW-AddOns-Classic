-- Author      : generalwrex (Natop)
-- Create Date : 1/28/2022 9:30:08 AM
--
-- Update Date : 2023-04-16 Riotdog-GehennasEU: v2.5 - exporting bag items for bulk sim, fixes use of legacy APIs in libs and corrects link order (LibStub must come first).
-- Update Date : 2024-02-04 coolmodi(FelixPflaum) v2.6 - Added rune exporting and split the addon for classic/wotlk
-- Update Date : 2024-02-04 generalwrex (Natop on Old Blanchy) v2.6 - Minor fixes and version change
-- Update Date : 2025-07-03 Polynomix & generalwrex v2.7
-- Update Date : 2025-07-06 RaiN v2.8 - Added support for saving exported characters data in SavedVariables and added auto-save functionality.

local addonName, Env = ...

local LibParse = LibStub("LibParse")

local WowSimsExporter = LibStub("AceAddon-3.0"):NewAddon("WowSimsExporter", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0", "AceComm-3.0")

local defaults = {
    profile = Env.SavedDataManager.defaults,
}

local options = {
    name = addonName,
    handler = WowSimsExporter,
    type = "group",
    args = {
        openExporterButton = {
            type = "execute",
            name = Env.L("Open Exporter Window"),
            desc = Env.L("Opens the exporter window"),
            func = function() WowSimsExporter:OpenWindow() end
        },
    },
}

function WowSimsExporter:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("WSEDB", defaults, true)

    LibStub("AceConfig-3.0"):RegisterOptionsTable("WowSimsExporter", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("WowSimsExporter", "WowSimsExporter")

    local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("WowSimsExporter_Profiles", profiles)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("WowSimsExporter_Profiles", "Profiles", "WowSimsExporter")

    -- Initialize the SavedDataManager
    Env.SavedDataManager:Initialize(self.db, self)

    self:RegisterChatCommand("wse", "OpenWindow")
    self:RegisterChatCommand("wowsimsexporter", "OpenWindow")
    self:RegisterChatCommand("wsexporter", "OpenWindow")

    -- Register events for automatic character saving
    self:RegisterEvent("PLAYER_ENTERING_WORLD", function (event, isInitialLogin, isReloadingUI)
        if isInitialLogin then
            self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", "OnCharacterChanged")
            self:RegisterEvent("CHARACTER_POINTS_CHANGED", "OnCharacterChanged") 
            self:RegisterEvent("PLAYER_TALENT_UPDATE", "OnCharacterChanged")
            self:RegisterEvent("ENCHANT_SPELL_COMPLETED", "OnCharacterChanged")
            if Env.IS_CLASSIC_ERA_SOD then
                self:RegisterEvent("RUNE_UPDATED", "OnCharacterChanged")
            end
            if not Env.IS_CLASSIC_ERA then
                self:RegisterEvent("GLYPH_ADDED", "OnCharacterChanged")
                self:RegisterEvent("GLYPH_REMOVED", "OnCharacterChanged")
                self:RegisterEvent("GLYPH_UPDATED", "OnCharacterChanged")
            end
        end
    end)

    if Env.IS_CLASSIC_MISTS then
        self:SecureHook("InspectFrame_LoadUI", function()
            C_Timer.After(0.1, function()
                Env.UI:CreateInspectButton(function ()
                    self:CreateWindow(true, true)
                end)
                self:Unhook("InspectFrame_LoadUI")
            end)
        end)
        self:SecureHook("InspectUnit", function (unit)
            Env.inspectUnit=unit
            local name = UnitName(unit)
            if Env.profInspectTable[name] == nil then
                self:SendCommMessage("WSEProfession", "request", "WHISPER", name)
            end
        end)
        function self:OnCommReceived(prefix, text, sender, name)
            self:handleAddonMessage(prefix, text, sender, name)
        end
        self:RegisterComm("WSEProfession")
    end

    Env.UI:CreateCharacterPanelButton(options.args.openExporterButton.func)

    self:Print(addonName .. " " .. Env.VERSION .. " " .. Env.L("Initialized. Commands:") .. "\n" ..
        Env.L("/wse - Open window") .. "\n" ..
        Env.L("/wse export - Export character (auto-saves)") .. "\n" ..
        Env.L("Auto-save:") .. " " .. (self.db.profile.autoSaveEnabled and Env.L("ENABLED") or Env.L("DISABLED")) .. "\n" ..
        "\124cff008000" .. Env.L("Credits go to %s"):format(Env.AUTHORS) .. "\124r")

    if not Env.IS_CLIENT_SUPPORTED then
        self:Print(Env.L("WARNING: Sim does not support your game version! Supported versions are:") .. "\n" ..
            table.concat(Env.supportedClientNames, "\n"))
    end
end

function WowSimsExporter:handleAddonMessage(prefix, text, type, name)
    if text == "request" then
        local entry = Env.CreateProfessionEntry(false)
        local msg = ""
        for _, prof in pairs(entry) do
            msg = msg..prof.name.."="..prof.level..", "
        end
        self:SendCommMessage("WSEProfession", msg, "WHISPER", name)
    else -- received professions info
        local entry = {}
        for k, v in text:gmatch("(%w+)=(%w+)") do
            table.insert(entry, {
                name = k,
                level = tonumber(v),
            })
        end
        Env.AddInspectedProfessions(name, entry)
    end
end

function WowSimsExporter:OpenWindow(input)
    if not input or input:trim() == "" then
        self:CreateWindow(false, false)
    elseif (input == "export") then
        self:CreateWindow(true, false)
    elseif (input == "options") then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    end
end

local function GenerateOutput(character, isInspect, exportBags)
    character:FillForExport(isInspect)
    local jsonExport = LibParse:JSONEncode(character)
    
    if not isInspect and character.level == GetMaxPlayerLevel() then
        -- Automatically save to database using SavedDataManager
        Env.SavedDataManager:SaveCharacterData(jsonExport)
    end

    return jsonExport
end

local function GenerateOutputBags()
    local equipmentSpecBags = Env.CreateEquipmentSpec()
    equipmentSpecBags:FillFromBagItems()
    DEFAULT_CHAT_FRAME:AddMessage(("[|cffFFFF00WowSimsExporter|r] " .. Env.L("Exported %d items from bags.")):format(#
        equipmentSpecBags.items))
    return LibParse:JSONEncode(equipmentSpecBags)
end

function WowSimsExporter:CreateWindow(generate, isInspect)
    local character = Env.CreateCharacter()
    local unit = isInspect and Env.inspectUnit or "player"
    character:SetUnit(unit)
    local classIsSupported = table.contains(Env.supportedClasses, character.class)
    local linkToSim = Env.prelink .. select(2, Env.GetSpec("player"))

    Env.UI:CreateMainWindow(classIsSupported, linkToSim)
    if not classIsSupported then return end
    if generate then Env.UI:SetOutput(GenerateOutput(character, isInspect)) end
end

Env.UI:SetOutputGenerator(function()
    local character = Env.CreateCharacter()
    character:SetUnit("player")
    local output = GenerateOutput(character, false)
    return output
end)

Env.UI:SetOutputGeneratorBags(function()
    local character = Env.CreateCharacter()
    character:SetUnit("player")
    local output = GenerateOutputBags()
    return output
end)

-- Wrapper functions that delegate to SavedDataManager
-- All saved data functionality has been moved to SavedDataManager.lua for better organization
function WowSimsExporter:SaveCharacterData(characterData, characterName, isAutoSave)
    return Env.SavedDataManager:SaveCharacterData(characterData, characterName, isAutoSave)
end

function WowSimsExporter:OnCharacterChanged(event, ...)
    Env.SavedDataManager:OnCharacterChanged(event)
end

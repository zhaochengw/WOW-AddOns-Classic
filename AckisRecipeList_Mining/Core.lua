
-- Constants
local MODULE_NAME = "Mining"
local MODULE_VERSION = 4

-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon("Ackis Recipe List")
local constants = addon.constants

if MODULE_VERSION ~= addon.SUPPORTED_MODULE_VERSION then
	addon:SpawnModuleWrongVersionDialog({
		moduleName = MODULE_NAME,
		moduleVersion = MODULE_VERSION
	})

	return
end

private.addon = addon
private.module_name = MODULE_NAME

local module = addon:NewModule(MODULE_NAME)

-------------------------------------------------------------------------------
-- Setup.
-------------------------------------------------------------------------------
function module:OnInitialize()
	-- Load
	local smeltingName = _G.GetSpellInfo(2656) -- Smelting
	if smeltingName then
		self.ActivationSpellID = 2656
	else
		self.ActivationSpellID = constants and constants.PROFESSION_SPELL_IDS and constants.PROFESSION_SPELL_IDS.MINING or 2575
	end
	self.ModuleName = MODULE_NAME
	self.Name = FOLDER_NAME
	self.Version = MODULE_VERSION
end

function module:OnEnable()
	addon.CreateProfessionFromModule(self)

	self:InitializeMobDrops()
	self:InitializeQuests()
	self:InitializeTrainers()
	self:InitializeRecipes()
end

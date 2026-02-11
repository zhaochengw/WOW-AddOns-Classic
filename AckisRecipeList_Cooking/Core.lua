-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
local MODULE_NAME = "Cooking"
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
	self.ModuleName = MODULE_NAME
	self.Name = FOLDER_NAME
	self.Version = MODULE_VERSION
	-- MoP Classic Load
	self.ActivationSpellID = constants and constants.PROFESSION_SPELL_IDS and constants.PROFESSION_SPELL_IDS.COOKING or 2550
end

function module:OnEnable()
	addon.CreateProfessionFromModule(self)
	if self.InitializeDiscoveries then self:InitializeDiscoveries() end
	if self.InitializeMobDrops then self:InitializeMobDrops() end
	if self.InitializeQuests then self:InitializeQuests() end
	if self.InitializeTrainers then self:InitializeTrainers() end
	if self.InitializeVendors then self:InitializeVendors() end
	if self.InitializeRecipes then self:InitializeRecipes() end
end

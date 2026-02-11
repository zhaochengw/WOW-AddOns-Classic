-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
local MODULE_NAME = "Engineering"
local MODULE_VERSION = 4

-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...
private.module_name = MODULE_NAME

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

local module = addon:NewModule(MODULE_NAME)

-------------------------------------------------------------------------------
-- Setup.
-------------------------------------------------------------------------------
function module:OnInitialize()
	self.ModuleName = MODULE_NAME
	self.Name = FOLDER_NAME
	self.Version = MODULE_VERSION
	-- MoP Classic Load
	self.ActivationSpellID = constants and constants.PROFESSION_SPELL_IDS and constants.PROFESSION_SPELL_IDS.ENGINEERING or 4036
end

function module:OnEnable()
	addon.CreateProfessionFromModule(self)

	self:InitializeDiscoveries()
	self:InitializeMobDrops()
	self:InitializeQuests()
	self:InitializeTrainers()
	self:InitializeVendors()
	self:InitializeRecipes()
end

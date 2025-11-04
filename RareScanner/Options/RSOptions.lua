-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub

local RareScanner = LibStub("AceAddon-3.0"):GetAddon("RareScanner")
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)

-- RareScanner options
local RSGeneralOptions = private.ImportLib("RareScannerGeneralOptions")
local RSSoundOptions = private.ImportLib("RareScannerSoundOptions")
local RSDisplayOptions = private.ImportLib("RareScannerDisplayOptions")
local RSCustomNpcsOptions = private.ImportLib("RareScannerCustomNpcsOptions")
local RSNpcFiltersOptions = private.ImportLib("RareScannerNpcFiltersOptions")
local RSContainerFiltersOptions = private.ImportLib("RareScannerContainerFiltersOptions")
local RSEventFiltersOptions = private.ImportLib("RareScannerEventFiltersOptions")
local RSZoneFiltersOptions = private.ImportLib("RareScannerZoneFiltersOptions")
local RSLootOptions = private.ImportLib("RareScannerLootOptions")
local RSMapOptions = private.ImportLib("RareScannerMapOptions")
local RSChatOptions = private.ImportLib("RareScannerChatOptions")

-----------------------------------------------------------------------
-- Tooltip positions
-----------------------------------------------------------------------

private.TOOLTIP_POSITIONS = {
	["ANCHOR_LEFT"] = AL["TOOLTIP_LEFT"],
	["ANCHOR_TOPLEFT"] = AL["TOOLTIP_TOPLEFT"],
	["ANCHOR_BOTTOMLEFT"] = AL["TOOLTIP_BOTTOMLEFT"],
	["ANCHOR_RIGHT"] = AL["TOOLTIP_RIGHT"],
	["ANCHOR_TOPRIGHT"] = AL["TOOLTIP_TOPRIGHT"],
	["ANCHOR_BOTTOMRIGHT"] = AL["TOOLTIP_BOTTOMRIGHT"],
	["ANCHOR_CURSOR"] = AL["TOOLTIP_CURSOR"],
	["ANCHOR_TOP"] = AL["TOOLTIP_TOP"],
	["ANCHOR_BOTTOM"] = AL["TOOLTIP_BOTTOM"],
}

function RareScanner:RefreshOptions(event, database, newProfileKey)
	private.db = database.profile
end

function RareScanner:SetupOptions()
	local RSAC = LibStub("AceConfig-3.0")
	RSAC:RegisterOptionsTable("RareScanner General", RSGeneralOptions.GetGeneralOptions())
	RSAC:RegisterOptionsTable("RareScanner Sound", RSSoundOptions.GetSoundOptions())
	RSAC:RegisterOptionsTable("RareScanner Display", RSDisplayOptions.GetDisplayOptions())
	RSAC:RegisterOptionsTable("RareScanner Custom NPCs", RSCustomNpcsOptions.GetCustomNpcsOptions)
	RSAC:RegisterOptionsTable("RareScanner NPC Filter", RSNpcFiltersOptions.GetNpcFiltersOptions())
	RSAC:RegisterOptionsTable("RareScanner Container Filter", RSContainerFiltersOptions.GetContainerFiltersOptions())
	RSAC:RegisterOptionsTable("RareScanner Event Filter", RSEventFiltersOptions.GetEventFiltersOptions())
	RSAC:RegisterOptionsTable("RareScanner Zone Filter", RSZoneFiltersOptions.GetZoneFiltersOptions())
	RSAC:RegisterOptionsTable("RareScanner Loot Options", RSLootOptions.GetLootOptions())
	RSAC:RegisterOptionsTable("RareScanner Map", RSMapOptions.GetMapOptions())
	RSAC:RegisterOptionsTable("RareScanner Chat", RSChatOptions.GetChatOptions())
	RSAC:RegisterOptionsTable("RareScanner Profiles", RareScanner:GetOptionsTable())

	local RSACD = LibStub("AceConfigDialog-3.0")
	RSACD:AddToBlizOptions("RareScanner General", _G.GENERAL_LABEL, "RareScanner")
	RSACD:AddToBlizOptions("RareScanner Sound", AL["SOUND"], "RareScanner")
	RSACD:AddToBlizOptions("RareScanner Display", AL["DISPLAY"], "RareScanner")
	RSACD:AddToBlizOptions("RareScanner Custom NPCs", AL["CUSTOM_NPCS"], "RareScanner")
	RSACD:AddToBlizOptions("RareScanner NPC Filter", AL["FILTER"], "RareScanner")
	RSACD:AddToBlizOptions("RareScanner Container Filter", AL["CONTAINER_FILTER"], "RareScanner")
	RSACD:AddToBlizOptions("RareScanner Event Filter", AL["EVENT_FILTER"], "RareScanner")
	RSACD:AddToBlizOptions("RareScanner Zone Filter", AL["ZONES_FILTER"], "RareScanner")
	RSACD:AddToBlizOptions("RareScanner Loot Options", AL["LOOT_OPTIONS"], "RareScanner")
	RSACD:AddToBlizOptions("RareScanner Map", AL["MAP_OPTIONS"], "RareScanner")
	RSACD:AddToBlizOptions("RareScanner Chat", AL["CHAT_OPTIONS"], "RareScanner")
	RSACD:AddToBlizOptions("RareScanner Profiles", AL["PROFILES"], "RareScanner")
end

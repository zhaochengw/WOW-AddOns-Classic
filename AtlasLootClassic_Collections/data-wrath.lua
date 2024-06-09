-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local function C_Map_GetAreaInfo(id)
	local d = C_Map.GetAreaInfo(id)
	return d or "GetAreaInfo"..id
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.WRATH_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local GetForVersion = AtlasLoot.ReturnForGameVersion

local NORMAL_DIFF = data:AddDifficulty("NORMAL", nil, nil, nil, true)
local HEROIC_DIFF = data:AddDifficulty("HEROIC", nil, nil, nil, true)
local RAID10_DIFF = data:AddDifficulty("10RAID")
local RAID10H_DIFF = data:AddDifficulty("10RAIDH")
local RAID25_DIFF = data:AddDifficulty("25RAID")
local RAID25H_DIFF = data:AddDifficulty("25RAIDH")

local VENDOR_DIFF = data:AddDifficulty(AL["Vendor"], "vendor", 0)
local T10_1_DIFF = data:AddDifficulty(AL["10H / 25 / 25H"], "T10_1", 0)
local T10_2_DIFF = data:AddDifficulty(AL["25 Raid Heroic"], "T10_2", 0)

local ALLIANCE_DIFF, HORDE_DIFF, LOAD_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	LOAD_DIFF = HORDE_DIFF
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	LOAD_DIFF = ALLIANCE_DIFF
end

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")
local AC_ITTYPE = data:AddItemTableType("Item", "Achievement")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local VENDOR_CONTENT = data:AddContentType(AL["Vendor"], ATLASLOOT_DUNGEON_COLOR)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)
--local WORLD_BOSS_CONTENT = data:AddContentType(AL["World Bosses"], ATLASLOOT_WORLD_BOSS_COLOR)
local COLLECTIONS_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTIONS_COLOR)
local WORLD_EVENT_CONTENT = data:AddContentType(AL["World Events"], ATLASLOOT_SEASONALEVENTS_COLOR)

-- colors
local BLUE = "|cff6666ff%s|r"
--local GREY = "|cff999999%s|r"
local GREEN = "|cff66cc33%s|r"
local _RED = "|cffcc6666%s|r"
local PURPLE = "|cff9900ff%s|r"
--local WHIT = "|cffffffff%s|r"

data["DalaranVendor"] = {
	name = format(AL["'%s' Vendor"], C_Map.GetAreaInfo(4395)),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	items = {
		{
			name = ALIL["Finger - /w Exalted Gold Discount"],
			[NORMAL_DIFF] = {
				{ 1, "f1090rep8" },
				-- caster
				{ 2, 40585}, 		  --Signet of the Kirin Tor
				{ 3, 45691, 40585},   --Inscribed Signet of the Kirin Tor
				{ 4, 48957, 45691},   --Etched Signet of the Kirin Tor
				{ 5, 51557, 48954},   --Runed Signet of the Kirin Tor
				-- healer
				{ 10, 44934 }, 		  --Loop of the Kirin Tor
				{ 11, 45689, 44934 }, --Inscribed Loop of the Kirin Tor
				{ 12, 48955, 45689 }, --Etched Loop of the Kirin Tor
				{ 13, 51558, 48955 }, --Runed Loop of the Kirin Tor
				-- agi
				{ 17, 40586 }, 		  --Band of the Kirin Tor
				{ 18, 45688, 40586 }, --Inscribed Band of the Kirin Tor
				{ 19, 48954, 45688 }, --Etched Band of the Kirin Tor
				{ 20, 51560, 48957 }, --Runed Band of the Kirin Tor
				-- str
				{ 25, 44935 }, 		  --Ring of the Kirin Tor
				{ 26, 45690, 44935 }, --Inscribed Ring of the Kirin Tor
				{ 27, 48956, 45690 }, --Etched Ring of the Kirin Tor
				{ 28, 51559, 48956 }, --Runed Ring of the Kirin Tor
			},
		},
		{
			name = ALIL["Gems"],
			[NORMAL_DIFF] = {
				{ 1, 36919 }, -- Cardinal Ruby
				{ 2, 36922 }, -- King's Amber
				{ 3, 36925 }, -- Majestic Zircon
				{ 4, 36931 }, -- Ametrine
				{ 5, 36928 }, -- Dreadstone
				{ 6, 36934 }, -- Eye of Zul
			},
		},
	}
}

data["CookingVendorWrath"] = {
	name = format(AL["'%s' Vendor"], ALIL["Cooking"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	items = {
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 46349 }, -- Chef's Hat
				{ 16, 43007 }, -- Northern Spices
			},
		},
		{
			name = AL["Recipe"],
			[NORMAL_DIFF] = {
				{ 1, 43035 }, -- Recipe: Blackened Dragonfin
				{ 2, 43032 }, -- Recipe: Blackened Worg Steak
				{ 3, 43029 }, -- Recipe: Critter Bites
				{ 4, 43033 }, -- Recipe: Cuttlesteak
				{ 5, 43036 }, -- Recipe: Dragonfin Filet
				{ 6, 43024 }, -- Recipe: Firecracker Salmon
				{ 7, 43017 }, -- Recipe: Fish Feast
				{ 8, 43505 }, -- Recipe: Gigantic Feast
				{ 9, 43030 }, -- Recipe: Hearty Rhino
				{ 10, 43026 }, -- Recipe: Imperial Manta Steak
				{ 11, 43018 }, -- Recipe: Mega Mammoth Meal
				{ 12, 43022 }, -- Recipe: Mighty Rhino Dogs
				{ 13, 43023 }, -- Recipe: Poached Northern Sculpin
				{ 14, 43028 }, -- Recipe: Rhinolicious Wormsteak
				{ 15, 43506 }, -- Recipe: Small Feast
				{ 16, 43031 }, -- Recipe: Snapper Extreme
				{ 17, 43034 }, -- Recipe: Spiced Mammoth Treats
				{ 18, 43020 }, -- Recipe: Spiced Worm Burger
				{ 19, 43025 }, -- Recipe: Spicy Blue Nettlefish
				{ 20, 43027 }, -- Recipe: Spicy Fried Herring
				{ 21, 43019 }, -- Recipe: Tender Shoveltusk Steak
				{ 22, 43037 }, -- Recipe: Tracker Snacks
				{ 23, 43021 }, -- Recipe: Very Burnt Worg
				{ 24, 44954 }, -- Recipe: Worg Tartare
			},
		},
	}
}

data["EmblemofHeroism"] = {
	name = format(AL["'%s' Vendor"], AL["Emblem of Heroism"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"],
			[NORMAL_DIFF] = {
				{ 1, 40697 }, -- Elegant Temple Gardens' Girdle
				{ 2, 40696 }, -- Plush Sash of Guzbah

				{ 4, 40694 }, -- Jorach's Crocolisk Skin Belt
				{ 5, 40695 }, -- Vine Belt of the Woodland Dryad

				{ 16, 40693 }, -- Beadwork Belt of Shamanic Vision
				{ 17, 40692 }, -- Vereesa's Silver Chain Belt

				{ 19, 40691 }, -- Magroth's Meditative Cincture
				{ 20, 40688 }, -- Verdungo's Barbarian Cord
				{ 21, 40689 }, -- Waistguard of Living Iron
			},
		},
		{
			name = ALIL["Weapon"],
			[NORMAL_DIFF] = {
				{ 1, 40704 }, -- Pride
				{ 2, 40702 }, -- Rolfsen's Ripper
				{ 3, 40703 }, -- Grasscutter
				{ 16, 40716 }, -- Lillehoff's Winged Blades
			},
		},
		{
			name = ALIL["Shield"],
			[NORMAL_DIFF] = {
				{ 1, 40701 }, -- Crygil's Discarded Plate Panel
				{ 2, 40700 }, -- Protective Barricade of the Light
			},
		},
		{
			name = ALIL["Off Hand"],
			[NORMAL_DIFF] = {
				{ 1, 40699 }, -- Handbook of Obscure Remedies
				{ 2, 40698 }, -- Ward of the Violet Citadel
			},
		},
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 40679 }, -- Chained Military Gorget
				{ 2, 40680 }, -- Encircling Burnished Gold Chains
				{ 3, 40681 }, -- Lattice Choker of Light
				{ 4, 40678 }, -- Pendant of the Outcast Hero
			},
		},
		{
			name = ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 40684 }, -- Mirror of Truth
				{ 2, 40682 }, -- Sundial of the Exiled
				{ 3, 40685 }, -- The Egg of Mortal Essence
				{ 4, 40683 }, -- Valor Medal of the First War
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 40711 }, -- Idol of Lush Moss
				{ 2, 40712 }, -- Idol of Steadfast Renewal
				{ 3, 40713 }, -- Idol of the Ravenous Beast
				{ 5, 40707 }, -- Libram of Obstruction
				{ 6, 40706 }, -- Libram of Reciprocation
				{ 7, 40705 }, -- Libram of Renewal
				{ 16, 40709 }, -- Totem of Forest Growth
				{ 17, 40710 }, -- Totem of Splintering
				{ 18, 40708 }, -- Totem of the Elemental Plane
				{ 20, 40715 }, -- Sigil of Haunted Dreams
				{ 21, 40714 }, -- Sigil of the Unfaltering Knight
			},
		},
		{
			name = AL["Token"],
			[NORMAL_DIFF] = {
				{ 1, 40610 }, -- Chestguard of the Lost Conqueror
				{ 2, 40611 }, -- Chestguard of the Lost Protector
				{ 3, 40612 }, -- Chestguard of the Lost Vanquisher
				{ 16, 40613 }, -- Gloves of the Lost Conqueror
				{ 17, 40614 }, -- Gloves of the Lost Protector
				{ 18, 40615 }, -- Gloves of the Lost Vanquisher
			},
		},
		{
			name = ALIL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, AtlasLoot:GetRetByFaction(44231,44230) }, -- Reins of the Wooly Mammoth
				{ 3, 43102 }, -- Frozen Orb
				{ 16, 36919 }, -- Cardinal Ruby
				{ 17, 36922 }, -- King's Amber
				{ 18, 36925 }, -- Majestic Zircon
				{ 19, 36931 }, -- Ametrine
				{ 20, 36928 }, -- Dreadstone
				{ 21, 36934 }, -- Eye of Zul
			},
		},
	}
}

data["EmblemofValor"] = {
	name = format(AL["'%s' Vendor"], AL["Emblem of Valor"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"],
			[NORMAL_DIFF] = {
				{ 1, 40741 }, -- Cuffs of the Shadow Ascendant
				{ 2, 40740 }, -- Wraps of the Astral Traveler
				{ 16, 40751 }, -- Slippers of the Holy Light
				{ 17, 40750 }, -- Xintor's Expeditionary Boots

				{ 4, 40739 }, -- Bands of the Great Tree
				{ 5, 40738 }, -- Wristwraps of the Cutthroat
				{ 19, 40748 }, -- Boots of Captain Ellis
				{ 20, 40749 }, -- Rainey's Chewed Boots

				{ 7, 40736 }, -- Armguard of the Tower Archer
				{ 8, 40737 }, -- Pigmented Clan Bindings
				{ 22, 40746 }, -- Pack-Ice Striders
				{ 23, 40747 }, -- Treads of Coastal Wandering

				{ 10, 40734 }, -- Bracers of Dalaran's Parapets
				{ 11, 40733 }, -- Wristbands of the Sentinel Huntress
				{ 12, 40735 }, -- Zartson's Jungle Vambraces
				{ 25, 40742 }, -- Bladed Steelboots
				{ 26, 40743 }, -- Kyzoc's Ground Stompers
				{ 27, 40745 }, -- Sabatons of Rapid Recovery
			},
		},
		{
			name = ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 40724 }, -- Cloak of Kea Feathers
				{ 2, 40723 }, -- Disguise of the Kumiho
				{ 3, 40722 }, -- Platinum Mesh Cloak
				{ 4, 40721 }, -- Hammerhead Sharkskin Cloak
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{ 1, 40719 }, -- Band of Channeled Magic
				{ 2, 40720 }, -- Renewal of Life
				{ 3, 40717 }, -- Ring of Invincibility
				{ 4, 40718 }, -- Signet of the Impregnable Fortress
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 40342 }, -- Idol of Awakening
				{ 2, 40321 }, -- Idol of the Shooting Star
				{ 3, 39757 }, -- Idol of Worship
				{ 5, 40191 }, -- Libram of Radiance
				{ 6, 40337 }, -- Libram of Resurgence
				{ 7, 40268 }, -- Libram of Tolerance
				{ 16, 40322 }, -- Totem of Dueling
				{ 17, 40267 }, -- Totem of Hex
				{ 18, 39728 }, -- Totem of Misery
				{ 20, 40207 }, -- Sigil of Awareness
			},
		},
		{
			name = AL["Token"],
			[NORMAL_DIFF] = {
				{ 1, 40637 }, -- Mantle of the Lost Conqueror
				{ 2, 40638 }, -- Mantle of the Lost Protector
				{ 3, 40639 }, -- Mantle of the Lost Vanquisher
				{ 16, 40634 }, -- Legplates of the Lost Conqueror
				{ 17, 40635 }, -- Legplates of the Lost Protector
				{ 18, 40636 }, -- Legplates of the Lost Vanquisher
			},
		},
	}
}

data["EmblemofConquest"] = {
	name = format(AL["'%s' Vendor"], AL["Emblem of Conquest"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"].." - "..ALIL["Cloth"],
			[NORMAL_DIFF] = {
				{ 1, 45840 }, -- Touch of the Occult
				{ 3, 45831 }, -- Sash of Potent Incantations
				{ 16, 45848 }, -- Legwraps of the Master Conjurer
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Leather"],
			[NORMAL_DIFF] = {
				{ 1, 45838 }, -- Gloves of the Blind Stalker
				{ 2, 45839 }, -- Grips of the Secret Grove
				{ 4, 45830 }, -- Belt of the Living Thicket
				{ 5, 45829 }, -- Belt of the Twilight Assassin
				{ 16, 45846 }, -- Leggings of Wavering Shadow
				{ 17, 45847 }, -- Wildstrider Legguards
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Mail"],
			[NORMAL_DIFF] = {
				{ 1, 45837 }, -- Gloves of Augury
				{ 2, 45836 }, -- Gloves of Unerring Aim
				{ 4, 45827 }, -- Belt of the Ardent Marksman
				{ 5, 45828 }, -- Windchill Binding
				{ 16, 45844 }, -- Leggings of the Tireless Sentry
				{ 17, 45845 }, -- Leggings of the Weary Mystic
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Plate"],
			[NORMAL_DIFF] = {
				{ 1, 45833 }, -- Bladebreaker Gauntlets
				{ 2, 45835 }, -- Gauntlets of Serene Blessing
				{ 3, 45834 }, -- Gauntlets of the Royal Watch
				{ 5, 45824 }, -- Belt of the Singing Blade
				{ 6, 45826 }, -- Girdle of Unyielding Trust
				{ 7, 45825 }, -- Shieldwarder Girdle
				{ 16, 45843 }, -- Legguards of the Peaceful Covenant
				{ 17, 45841 }, -- Legplates of the Violet Champion
				{ 18, 45842 }, -- Wyrmguard Legplates
			},
		},
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 45820 }, -- Broach of the Wailing Night
				{ 2, 45822 }, -- Evoker's Charm
				{ 3, 45823 }, -- Frozen Tear of Elune
				{ 4, 45821 }, -- Shard of the Crystal Forest
				{ 5, 45819 }, -- Spiked Battleguard Choker
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 45509 }, -- Idol of the Corruptor
				{ 2, 45270 }, -- Idol of the Crying Wind
				{ 3, 46138 }, -- Idol of the Flourishing Life
				{ 5, 45510 }, -- Libram of Discord
				{ 6, 45436 }, -- Libram of the Resolute
				{ 7, 45145 }, -- Libram of the Sacred Shield

				{ 16, 45114 }, -- Steamcaller's Totem
				{ 17, 45255 }, -- Thunderfall Totem
				{ 18, 45169 }, -- Totem of the Dancing Flame
				{ 20, 45144 }, -- Sigil of Deflection
				{ 21, 45254 }, -- Sigil of the Vengeful Heart
			},
		},
		{
			name = AL["Token"],
			[NORMAL_DIFF] = {
				{ 1, 45638 }, -- Crown of the Wayward Conqueror
				{ 2, 45639 }, -- Crown of the Wayward Protector
				{ 3, 45640 }, -- Crown of the Wayward Vanquisher
				{ 16, 45632 }, -- Breastplate of the Wayward Conqueror
				{ 17, 45633 }, -- Breastplate of the Wayward Protector
				{ 18, 45634 }, -- Breastplate of the Wayward Vanquisher
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 45087 }, -- Runed Orb
			},
		},
	}
}

data["EmblemofTriumph"] = {
	name = format(AL["'%s' Vendor"], AL["Emblem of Triumph"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"].." - "..ALIL["Cloth"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					{ 1, 47695 }, -- Hood of Clouded Sight
					{ 2, 47692 }, -- Hood of Smoldering Aftermath
					{ 16, 47714 }, -- Pauldrons of Catastrophic Emanation
					{ 17, 47716 }, -- Mantle of Revered Mortality
				},
				{ -- alliance
					{ 1, 47694 }, -- Helm of Clouded Sight
					{ 2, 47693 }, -- Hood of Fiery Aftermath
					{ 16, 47713 }, -- Mantle of Catastrophic Emanation
					{ 17, 47715 }, -- Pauldrons of Revered Mortality
				}
			)

		},
		{
			name = ALIL["Armor"].." - "..ALIL["Leather"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					{ 1, 47691 }, -- Mask of Abundant Growth
					{ 2, 47688 }, -- Mask of Lethal Intent
					{ 16, 47709 }, -- Duskstalker Pauldrons
					{ 17, 47710 }, -- Epaulets of the Fateful Accord
				},
				{ -- alliance
					{ 1, 47690 }, -- Helm of Abundant Growth
					{ 2, 47689 }, -- Hood of Lethal Intent
					{ 16, 47708 }, -- Duskstalker Shoulderpads
					{ 17, 47712 }, -- Shoulders of the Fateful Accord
				}
			)
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Mail"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					{ 1, 47687 }, -- Headguard of Inner Warmth
					{ 2, 47684 }, -- Coif of the Brooding Dragon
					{ 16, 47705 }, -- Pauldrons of the Devourer
					{ 17, 47706 }, -- Shoulders of the Groundbreaker
				},
				{ -- alliance
					{ 1, 47686 }, -- Helm of Inner Warmth
					{ 2, 47685 }, -- Helm of the Brooding Dragon
					{ 16, 47704 }, -- Epaulets of the Devourer
					{ 17, 47707 }, -- Mantle of the Groundbreaker
				}
			)
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Plate"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					{ 1, 47678 }, -- Headplate of the Honorbound
					{ 2, 47682 }, -- Helm of the Restless Watch
					{ 3, 47675 }, -- Faceplate of Thunderous Rampage
					{ 16, 47701 }, -- Shoulderplates of the Cavalier
					{ 17, 47696 }, -- Shoulderplates of Trembling Rage
					{ 18, 47699 }, -- Shoulderguards of Enduring Order
				},
				{ -- alliance
					{ 1, 47677 }, -- Faceplate of the Honorbound
					{ 2, 47681 }, -- Heaume of the Restless Watch
					{ 3, 47674 }, -- Helm of Thunderous Rampage
					{ 16, 47702 }, -- Pauldrons of the Cavalier
					{ 17, 47697 }, -- Pauldrons of Trembling Rage
					{ 18, 47698 }, -- Shoulderplates of Enduring Order
				}
			)
		},
		{
			name = ALIL["Weapon"],
			[NORMAL_DIFF] = {
			{ 1, 47659 }, -- Crimson Star
			{ 2, 47660 }, -- Blades of the Sable Cross
			{ 16, 47658 }, -- Brimstone Igniter
			},
		},
		{
			name = ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 47735 }, -- Glyph of Indomitability
				{ 2, 47734 }, -- Mark of Supremacy
				{ 3, 48722 }, -- Shard of the Crystal Heart
				{ 4, 48724 }, -- Talisman of Resurgence
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{ 1, 47732 }, -- Band of the Invoker
				{ 2, 47729 }, -- Bloodshed Band
				{ 3, 47731 }, -- Clutch of Fortification
				{ 4, 47730 }, -- Dexterous Brightstone Ring
				{ 5, 47733 }, -- Heartmender Circle
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 47671 }, -- Idol of Flaring Growth
				{ 2, 47670 }, -- Idol of Lunar Fury
				{ 3, 47668 }, -- Idol of Mutilation
				{ 5, 47664 }, -- Libram of Defiance
				{ 6, 47661 }, -- Libram of Valiance
				{ 7, 47662 }, -- Libram of Veracity
				{ 16, 47665 }, -- Totem of Calming Tides
				{ 17, 47666 }, -- Totem of Electrifying Wind
				{ 18, 47667 }, -- Totem of Quaking Earth
				{ 20, 47672 }, -- Sigil of Insolence
				{ 21, 47673 }, -- Sigil of Virulence
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 47556 }, -- Crusader Orb
				{ 2, 44713 }, -- Ebon Blade Commendation Badge
				{ 3, 44711 }, -- Argent Crusade Commendation Badge
				{ 4, 44710 }, -- Wyrmrest Commendation Badge
				{ 5, 43950 }, -- Kirin Tor Commendation Badge
				{ 6, 49702 }, -- Sons of Hodir Commendation Badge
			},
		},
	}
}



data["EmblemofFrost"] = {
	name = format(AL["'%s' Vendor"], AL["Emblem of Frost"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"].." - "..ALIL["Cloth"],
			[NORMAL_DIFF] = {
				{ 1, 50975 }, -- Ermine Coronation Robes
				{ 2, 50974 }, -- Meteor Chaser's Raiment
				{ 4, 50984 }, -- Gloves of Ambivalence
				{ 5, 50983 }, -- Gloves of False Gestures
				{ 16, 50996 }, -- Belt of Omission
				{ 17, 50997 }, -- Circle of Ossus
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Leather"],
			[NORMAL_DIFF] = {
				{ 1, 50972 }, -- Shadow Seeker's Tunic
				{ 2, 50973 }, -- Vestments of Spruce and Fir
				{ 4, 50982 }, -- Cat Burglar's Grips
				{ 5, 50981 }, -- Gloves of the Great Horned Owl
				{ 16, 50994 }, -- Belt of Petrified Ivy
				{ 17, 50995 }, -- Vengeful Noose
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Mail"],
			[NORMAL_DIFF] = {
				{ 1, 50970 }, -- Longstrider's Vest
				{ 2, 50971 }, -- Mail of the Geyser
				{ 4, 50980 }, -- Blizzard Keeper's Mitts
				{ 5, 50979 }, -- Logsplitters
				{ 16, 50993 }, -- Band of the Night Raven
				{ 17, 50992 }, -- Waistband of Despair
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Plate"],
			[NORMAL_DIFF] = {
				{ 1, 50965 }, -- Castle Breaker's Battleplate
				{ 2, 50969 }, -- Chestplate of Unspoken Truths
				{ 3, 50968 }, -- Cataclysmic Chestguard
				{ 5, 50977 }, -- Gatecrasher's Gauntlets
				{ 6, 50976 }, -- Gauntlets of Overexposure
				{ 7, 50978 }, -- Gauntlets of the Kraken
				{ 16, 50989 }, -- Lich Killer's Lanyard
				{ 17, 50987 }, -- Malevolant Girdle
				{ 18, 50991 }, -- Verdigris Chain Belt
			},
		},
		{
			name = ALIL["Back"],
			[NORMAL_DIFF] = {
				{ 1, 50468 }, -- Drape of the Violet Tower
				{ 2, 50467 }, -- Might of the Ocean Serpent
				{ 3, 50470 }, -- Recovered Scarlet Onslaught Cape
				{ 4, 50466 }, -- Sentinel's Winter Cloak
				{ 5, 50469 }, -- Volde's Cloak of the Night Sky
			},
		},
		{
			name = ALIL["Weapon"],
			[NORMAL_DIFF] = {
				{ 1, 50474 }, -- Shrapnel Star
			},
		},
		{
			name = ALIL["Relic"],
			[NORMAL_DIFF] = {
				{ 1, 50456 }, -- Idol of the Crying Moon
				{ 2, 50457 }, -- Idol of the Lunar Eclipse
				{ 3, 50454 }, -- Idol of the Black Willow
				{ 5, 50460 }, -- Libram of Blinding Light
				{ 6, 50461 }, -- Libram of the Eternal Tower
				{ 7, 50455 }, -- Libram of Three Truths
				{ 16, 50458 }, -- Bizuri's Totem of Shattered Ice
				{ 17, 50463 }, -- Totem of the Avalanche
				{ 18, 50464 }, -- Totem of the Surging Sea
				{ 20, 50462 }, -- Sigil of the Bone Gryphon
				{ 21, 50459 }, -- Sigil of the Hanged Man
			},
		},
		{
			name = ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 50356 }, -- Corroded Skeleton Key
				{ 2, 50355 }, -- Herkuml War Token
				{ 3, 50357 }, -- Maghia's Misguided Quill
				{ 4, 50358 }, -- Purified Lunar Dust
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 49908 }, -- Primordial Saronite
			},
		},
	}
}

data["SiderealEssence"] = {
	name = format(AL["'%s' Vendor"], AL["Sidereal Essence"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"].." - "..ALIL["Cloth"],
			[NORMAL_DIFF] = {
				{ 1, 46068 }, -- Amice of Inconceivable Horror
				{ 2, 46045 }, -- Pulsar Gloves
				{ 3, 46034 }, -- Leggings of Profound Darkness
				{ 4, 46050 }, -- Starlight Treads
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Leather"],
			[NORMAL_DIFF] = {
				{ 1, 45993 }, -- Mimiron's Flight Goggles
				{ 2, 45869 }, -- Fluxing Energy Coils
				{ 3, 46043 }, -- Gloves of the Endless Dark
				{ 4, 46095 }, -- Soul-Devouring Cinch
				{ 16, 45293 }, -- Handguards of Potent Cures
				{ 17, 45455 }, -- Belt of the Crystal Tree
				{ 18, 46049 }, -- Zodiac Leggings
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Mail"],
			[NORMAL_DIFF] = {
				{ 1, 45300 }, -- Mantle of Fiery Vengaence
				{ 2, 45989 }, -- Tempered Murcury Greaves
				{ 16, 46044 }, -- Observer's Mantle
				{ 17, 45867 }, -- Breastplate of the Stoneshaper
				{ 18, 45943 }, -- Gloves of Whispering Winds
			},
		},
		{
			name = ALIL["Armor"].." - "..ALIL["Plate"],
			[NORMAL_DIFF] = {
				{ 1, 46037 }, -- Shoulderplates of the Celestial Watch
				{ 2, 45888 }, -- Bitter Cold Armguards
				{ 3, 46041 }, -- Starfall Girdle
				{ 4, 45982 }, -- Fused Alloy Legplates
				{ 6, 46039 }, -- Breastplate of the Timeless
				{ 7, 45988 }, -- Greaves of the Iron Army
				{ 8, 45295 }, -- Gilded Steel Legplates
				{ 16, 45928 }, -- Gauntlets of the Thunder God
			},
		},
		{
			name = ALIL["Back"],
			[NORMAL_DIFF] = {
				{ 1, 46032 }, -- Drape of the Faceless General
				{ 16, 46042 }, -- Drape of the Messenger
			},
		},
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 46040 }, -- Strength of the Heavens
				{ 3, 45945 }, -- Seed of Budding Carnage
				{ 16, 45933 }, -- Pendant of the Shallow Grave
				{ 17, 45447 }, -- Watchful Eye of Hate
				{ 18, 46047 }, -- Pendant of the Somber Witness
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = {
				{ 1, 46048 }, -- Band of Lights
				{ 2, 45456 }, -- Loop of the Agile
				{ 4, 45871 }, -- Seal of Ulduar
				{ 16, 46046 }, -- Nebula Band
				{ 17, 45297 }, -- Shimmering Seal
				{ 18, 46096 }, -- Signet of Soft Lament
				{ 19, 45946 }, -- Fire Orchid Signet
			},
		},
		{
			name = ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 45931 }, -- Mjolnir Runestone
				{ 2, 46038 }, -- Dark Matter
				{ 16, 46051 }, -- Meteorite Crystal
				{ 17, 45929 }, -- Sif's Remembrance
			},
		},


		{
			name = ALIL["Weapon"],
			[NORMAL_DIFF] = {
				{ 1, 46067 }, -- Hammer of Crushing Whispers
				{ 16, 45868 }, -- Aesir's Edge

				{ 3, 46033 }, -- Tortured Earth

				{ 5, 45449 }, -- The Masticator
				{ 20, 46097 }, -- Caress of Insanity
				{ 6, 45947 }, -- Serilas, Blood Blade of Invar One-Arm
				{ 21, 46036 }, -- Void Sabre
				{ 7, 45448 }, -- Perilous Bite
				{ 22, 45930 }, -- Combatant's Bootblade

				{ 9, 45876 }, -- Shiver

				{ 11, 45870 }, -- Magnetized Projectile Emitter
				{ 26, 45296 }, -- Twirling Blades

				{ 13, 45990 }, -- Fusion Blade
				{ 28, 46035 }, -- Aesuga, Hand of the Ardent Champion
				{ 14, 45886 }, -- Icecore Staff
				{ 29, 45294 }, -- Petrified Ivy Sprig

			},
		},
		{
			name = ALIL["Shield"],
			[NORMAL_DIFF] = {
				{ 1, 45877 }, -- The Boreal Guard
				{ 16, 45887 }, -- Ice Layered Barrier
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 47556 }, -- Crusader Orb
			},
		},
	}
}

data["DefilersScourgestone"] = {
	name = format(AL["'%s' Vendor"], AL["Defiler's Scourgestone"]),
	ContentType = VENDOR_CONTENT,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"] .. " - " .. ALIL["Cloth"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					-- spirit/haste
					{ 1, 47321 }, --Boots of the Icy Floe
					{ 2, 47286 }, --Belt of Biting Cold
					{ 3, 47306 }, --Dark Essence Bindings
					-- hit/crit
					{ 16, 47293 }, --Sandals of the Mourning Widow
					{ 17, 47258 }, --Belt of the Tenebrous Mist
					{ 18, 47324 }, --Bindings of the Ashen Saint
				},
				{ -- alliance
					-- spirit/haste
					{ 1, 47194 }, --Footpads of the Icy Floe
					{ 2, 47081 }, --Cord of Biting Cold
					{ 3, 47141 }, --Bindings of Dark Essence
					-- hit/crit
					{ 9, 47092 }, --Boots of the Mourning Widow
					{ 10, 46972 }, --Cord of the Tenebrous Mist
					{ 11, 47203 }, --Armbands of the Ashen Saint
				}
			)
		},
		{
			name = ALIL["Armor"] .. " - " .. ALIL["Leather"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					-- caster
					{ 1, 47262 }, --Boots of the Harsh Winter
					{ 2, 47308 }, --Belt of Pale Thorns
					{ 3, 47277 }, --Bindings of the Autumn Willow
					-- agi
					{ 16, 47284 }, --Icewalker Treads
					{ 17, 47299 }, --Belt of the Pitiless Killer
					{ 18, 47313 }, --Armbands of Dark Determination
				},
				{ -- alliance
					-- caster
					{ 1, 47262 }, --Boots of the Harsh Winter
					{ 2, 47308 }, --Belt of Pale Thorns
					{ 3, 47277 }, --Bindings of the Autumn Willow
					-- agi
					{ 16, 47284 }, --Icewalker Treads
					{ 17, 47299 }, --Belt of the Pitiless Killer
					{ 18, 47313 }, --Armbands of Dark Determination
				}
			)
		},
		{
			name = ALIL["Armor"] .. " - " .. ALIL["Mail"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					-- caster
					{ 1, 47295 }, --Sabatons of Tremoring Earth
					{ 3, 47265 }, --Binding of the Ice Burrower
					{ 4, 47280 }, --Wristwraps of Cloudy Omen
					-- agi
					{ 16, 47296 }, --Greaves of Ruthless Judgment
					{ 17, 47311 }, --Waistguard of Deathly Dominion
					{ 18, 47281 }, --Bracers of the Silent Massacre
				},
				{ -- alliance
					-- caster
					{ 1, 47090 }, --Boots of Tremoring Earth
					{ 3, 46990 }, --Belt of the Ice Burrower
					{ 4, 47056 }, --Bracers of Cloudy Omen
					-- agi
					{ 16, 47106 }, --Sabatons of Ruthless Judgment
					{ 17, 47152 }, --Belt of Deathly Dominion
					{ 18, 47073 }, --Bracers of the Untold Massacre
				}
			)
		},
		{
			name = ALIL["Armor"] .. " - " .. ALIL["Plate"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					-- caster
					{ 1, 47263 }, --Sabatons of the Courageous
					{ 2, 47323 }, --Girdle of the Forgotten Martyr
					{ 3, 47294 }, --Bracers of the Broken Bond
					-- str
					{ 16, 47312 }, --Greaves of the Saronite Citadel
					{ 17, 47268 }, --Bloodbath Girdle
					{ 18, 47253 }, --Boneshatter Vambraces
					-- tank
					{ 24, 47269 }, --Dawnbreaker Sabatons
					{ 25, 47283 }, --Belt of Bloodied Scars
					{ 26, 47298 }, --Armguards of the Shieldmaiden
				},
				{ -- alliance
					-- caster
					{ 1, 46985 }, --Boots of the Courageous
					{ 2, 47195 }, --Belt of the Forgotten Martyr
					{ 3, 47093 }, --Vambraces of the Broken Bond
					-- str
					{ 16, 47150 }, --Greaves of the 7th Legion
					{ 17, 46999 }, --Bloodbath Belt
					{ 18, 46961 }, --Boneshatter Armplates
					-- tank
					{ 24, 46997 }, --Dawnbreaker Greaves
					{ 25, 47072 }, --Girdle of Bloodied Scars
					{ 26, 47108 }, --Bracers of the Shieldmaiden
				}
			)
		},
		{
			name = ALIL["Back"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					-- caster
					{ 1, 47291 }, --Shroud of Displacement
					{ 2, 47256 }, --Drape of the Refreshing Winds
					{ 3, 45242 }, --Drape of Mortal Downfall
					-- healer
					{ 5, 47328 }, --Maiden's Adoration
					{ 6, 45486 }, --Drape of the Sullen Goddess
					-- agi
					{ 16, 47257 }, --Cloak of the Untamed Predator
					{ 17, 45461 }, --Drape of Icy Intent
					-- str
					{ 20, 47320 }, --Might of the Nerub
					-- tank
					{ 24, 47275 }, --Pride of the Demon Lord
					{ 25, 45496 }, --Titanskin Cloak
				},
				{ -- alliance
					-- caster
					{ 1, 47089 }, --Cloak of Displacement
					{ 2, 46976 }, --Shawl of the Refreshing Winds
					{ 3, 45242 }, --Drape of Mortal Downfall
					-- healer
					{ 5, 47225 }, --Maiden's Favor
					{ 6, 45486 }, --Drape of the Sullen Goddess
					-- agi
					{ 16, 46970 }, --Drape of the Untamed Predator
					{ 17, 45461 }, --Drape of Icy Intent
					-- str
					{ 20, 47183 }, --Strength of the Nerub
					-- tank
					{ 24, 47042 }, --Pride of the Eredar
					{ 25, 45496 }, --Titanskin Cloak
				}
			)
		},
		{
			name = ALIL["Neck"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					-- caster
					{ 1, 47307 }, --Cry of the Val'kyr
					{ 2, 45133 }, --Pendant of Fiery Havoc
					{ 3, 45243 }, --Sapphire Amulet of Renewal
					-- healer
					{ 5, 45443 }, --Charm of Meticulous Timing
					-- agi
					{ 16, 47272 }, --Charge of the Eredar
					{ 17, 45517 }, --Pendulum of Infinity
					-- str
					{ 20, 47297 }, --The Executioner's Vice
					{ 21, 45459 }, --Frigid Strength of Hodir
					-- tank
					{ 24, 47305 }, --Legionnaire's Gorget
					{ 25, 45485 }, --Bronze Pendant of the Vanir
				},
				{ -- alliance
					-- caster
					{ 1, 47139 }, --Wail of the Val'kyr
					{ 2, 45133 }, --Pendant of Fiery Havoc
					{ 3, 45243 }, --Sapphire Amulet of Renewal
					-- healer
					{ 5, 45443 }, --Charm of Meticulous Timing
					-- agi
					{ 16, 47043 }, --Charge of the Demon Lord
					{ 17, 45517 }, --Pendulum of Infinity
					-- str
					{ 20, 47105 }, --The Executioner's Malice
					{ 21, 45459 }, --Frigid Strength of Hodir
					-- tank
					{ 24, 47116 }, --The Arbiter's Muse
					{ 25, 45485 }, --Bronze Pendant of the Vanir
				}
			)
		},
		{
			name = ALIL["Finger"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					-- caster
					{ 1, 47327 }, --Lurid Manifestation
					{ 2, 45495 }, --Conductive Seal
					-- healer
					{ 5, 47278 }, --Circle of the Darkmender
					-- agi
					{ 16, 47282 }, --Band of Callous Aggression
					-- str
					{ 19, 46959 }, --Band of the Violent Temperment
					{ 20, 45534 }, --Seal of the Betrayed King
					-- tank
					{ 24, 47315 }, --Band of the Traitor King
					{ 25, 45471 }, --Fate's Clutch
				},
				{ -- alliance
					-- caster
					{ 1, 47054 }, --Band of Deplorable Violence
					{ 2, 45495 }, --Conductive Seal
					-- healer
					{ 9, 47223 }, --Ring of the Darkmender
					-- agi
					{ 16, 47070 }, --Ring of Callous Aggression
					-- str
					{ 19, 47252 }, --Ring of the Violent Temperament
					{ 20, 45534 }, --Seal of the Betrayed King
					-- tank
					{ 24, 47149 }, --Signet of the Traitor King
					{ 25, 45471 }, --Fate's Clutch
				}
			)
		},
		{
			name = ALIL["Trinket"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					-- caster
					{ 1, 47316 }, --Reign of the Dead
					{ 2, 45518 }, --Flare of the Heavens
					-- healer
					{ 9, 47271 }, --Solace of the Fallen
					{ 10, 45535 }, --Show of Faith
					-- melee
					{ 16, 47303 }, --Death's Choice
					{ 17, 45609 }, --Comet's Trail
					-- tank
					{ 24, 47290 }, --Juggernaut's Vitality
				},
				{ -- alliance
					-- caster
					{ 1, 47182 }, --Reign of the Unliving
					{ 2, 45518 }, --Flare of the Heavens
					-- healer
					{ 9, 47041 }, --Solace of the Defeated
					{ 10, 45535 }, --Show of Faith
					-- melee
					{ 16, 47115 }, --Death's Verdict
					{ 17, 45609 }, --Comet's Trail
					-- tank
					{ 24, 47080 }, --Satrina's Impeding Scarab
				}
			)
		},
		{
			name = ALIL["Weapon"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					-- mainhand
					{ 1, 47261 }, --Barb of Tarasque
					{ 3, 47322 }, --Suffering's End
					-- offhand
					{ 5, 47276 }, --Talisman of Heedless Sins
					{ 7, 47309 }, --Mystifying Charm
					-- dagger
					{ 16, 47255 }, --Stygian Bladebreaker
					{ 17, 47300 }, --Gouge of the Frigid Heart
					-- axe
					{ 19, 47314 }, --Hellscream Slicer
					{ 20, 47266 }, --Blood Fury
					-- 2h-str
					{ 22, 47285 }, --Dual-blade Butcher
					-- 2h-agi
					{ 24, 47302 }, --Twin's Pact
					{ 26, 47329 }, --Hellion Glaive
					-- ranged
					{ 28, 47267 }, --Death's Head Crossbow
				},
				{ -- alliance
					-- mainhand
					{ 1, 46979 }, --Blade of Tarasque
					{ 3, 47193 }, --Misery's End
					-- offhand
					{ 5, 47053 }, --Symbol of Transgression
					{ 7, 47138 }, --Chalice of Searing Light
					-- agi dagger
					{ 16, 46958 }, --Steel Bladebreaker
					{ 17, 47104 }, --Twin Spike
					-- axe
					{ 19, 47148 }, --Stormpike Cleaver
					{ 20, 46996 }, --Lionhead Slasher
					-- 2h-str
					{ 22, 47069 }, --Justicebringer
					-- 2h-agi
					{ 24, 47114 }, --Lupine Longstaff
					{ 26, 47233 }, --Archon Glaive
					-- ranged
					{ 28, 46994 }, --Talonstrike
				}
			)
		},
		{
			name = ALIL["Shield"],
			[NORMAL_DIFF] = AtlasLoot:GetRetByFaction(
				{ -- horde
					-- caster
					{ 1, 47287 }, --Bastion of Resolve
					-- tank
					{ 16, 47260 }, --Forlorn Barrier
				},
				{ -- alliance
					-- caster
					{ 1, 47079 }, --Bastion of Purity
					-- tank
					{ 16, 46963 }, --Crystal Plated Vanguard
				}
			)
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Sidereal Essence: 1 for 1"], nil },
				{ 2, 49908 }, -- Primordial Saronite
				{ 3, 47242 }, -- Trophy of the Crusade
			},
		},
	}
}

-- shared!
data["WorldEpicsWrath"] = {
	name = AL["World Epics"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	CorrespondingFields = private.WORLD_EPICS,
	items = {
		{
			name = AL["World Epics"],
			[NORMAL_ITTYPE] = {
			{ 1, 44309 },	-- Sash of Jordan
			{ 2, 44312 },	-- Wapach's Spaulders of Solidarity
			{ 4, 44308 },	-- Signet of Edward the Odd
			{ 5, 37835 },	-- Je'Tze's Bell
			{ 16, 44310 },	-- Namlak's Supernumerary Sticker
			{ 17, 44311 },	-- Avool's Sword of Jin
			{ 18, 44313 },	-- Zom's Crackling Bulwark
			{ 20, 43575, nil, nil, GetSpellInfo(921) },	-- Reinforced Junkbox
			{ 21, 43613 },	-- The Dusk Blade
			{ 22, 43611 },	-- Krol Cleaver
			},
		},
	},
}

data["MountsWrath"] = {
	name = ALIL["Mounts"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.MOUNTS,
	items = {
		{
			name = AL["PvP"],
			[NORMAL_DIFF] = {
				{ 1,  46708 }, -- Deadly Gladiator's Frost Wyrm
				{ 2,  46171 }, -- Furious  Gladiator's Frost Wyrm
				{ 3,  47840 }, -- Relentless Gladiator's Frost Wyrm
				{ 4,  50435 }, -- Wrathful Gladiator's Frost Wyrm
			},
		},
		{ -- Drops
			name = AL["Drops"],
			[NORMAL_DIFF] = {
				{ 1, 50818 }, -- Invincible's Reins
				{ 3, 45693 }, -- Mimiron's Head
				{ 5, 50250 }, -- X-45 Heartbreaker
				{ 7, 43986 }, -- Reins of the Black Drake
				{ 8, 43954 }, -- Reins of the Twilight Drake
				{ 9, 43952 }, -- Reins of the Azure Drake
				{ 10, 43951 }, -- Reins of the Bronze Drake
				{ 16, 44168 }, -- Reins of the Time-Lost Proto-Drake
				{ 17, 44151 }, -- Reins of the Blue Proto-Drake
				{ 19, 43959 }, -- Reins of the Grand Black War Mammoth
				{ 20, 44083 }, -- Reins of the Grand Black War Mammoth
			},
		},
		{
			name = AL["Crafting"],
			[NORMAL_DIFF] = {
				{ 1, 54797 }, -- Frosty Flying Carpet
				{ 2, 44558 }, -- Magnificent Flying Carpet
				{ 3, 44554 }, -- Flying Carpet
				AtlasLoot:GetRetByFaction({ 16, 41508 }, { 16, 44413 }), -- Mechano-hog / Mekgineer's Chopper
			},
		},
		{
			name = ALIL["Fishing"],
			[NORMAL_DIFF] = {
				{ 1, 46109 }, -- Sea Turtle
			},
		},
		{
			name = AL["Quest"],
			[NORMAL_DIFF] = {
				{ 1, 46102 }, -- Whistle of the Venomhide Ravasaur
			},
		},
		{
			name = ALIL["Achievements"] ,
			TableType = AC_ITTYPE,
			[NORMAL_DIFF] = {
				AtlasLoot:GetRetByFaction({ 1, 44177, 2145 }, { 1, 44177, 2144 }), -- Reins of the Violet Proto-Drake
				{ 3, 44178, 2143 }, -- Reins of the Albino Drake
				AtlasLoot:GetRetByFaction({ 4, 44842, 2537 }, { 4, 44843, 2536 }), -- Red Dragonhawk Mount / Blue Dragonhawk Mount
				AtlasLoot:GetRetByFaction({ 6, 44224, 619 }, { 6, 44223, 614 }), -- Reins of the Black War Bear / Reins of the Black War Bear
				{ 8, 44160, 2136 }, -- Reins of the Red Proto-Drake
				{ 16, 45802, 2957 }, -- Reins of the Rusted Proto-Drake
				{ 17, 45801, 2958 }, -- Reins of the Ironbound Proto-Drake
				AtlasLoot:GetRetByFaction({ 19, 49098, 4079 }, { 19, 49096, 4156 }), -- Crusader's Black Warhorse / Crusader's White Warhorse
				{ 21, 51954, 4602 }, -- Reins of the Bloodbathed Frostbrood Vanquisher
				{ 22, 51955, 4603 }, -- Reins of the Icebound Frostbrood Vanquisher
			},
		},
	},
}

data["CompanionsWrath"] = {
	name = ALIL["Companions"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	CorrespondingFields = private.COMPANIONS,
	items = {
		{
			name = AL["Drops"],
			[NORMAL_DIFF] = {
				{ 1, 48126 }, --  Razzashi Hatchling
				{ 2, 48124 }, --  Razormaw Hatchling
				{ 3, 48122 }, --  Ravasaur Hatchling
				{ 4, 48120 }, --  Obsidian Hatchling
				{ 5, 48116 }, --  Gundrak Hatchling
				{ 6, 48114 }, --  Deviate Hatchling
				{ 7, 48112 }, --  Darting Hatchling
			},
		},
		{
			name = AL["Vendor"],
			[NORMAL_DIFF] = {
				{ 1, 44723 }, --  Nurtured Penguin Egg
				{ 2, 39973 }, --  Ghostly Skull
				{ 3, 54436 }, --  Blue Clockwork Rocket Bot
				{ 4, 46398 }, --  Calico Cat
				{ 5, 44822 }, --  Albino Snake
			},
		},
		{
			name = AL["World Events"],
			[NORMAL_DIFF] = {
				{ 1, 50446 }, -- Toxic Wasteling
				{ 3, 44794 }, --  Spring Rabbit's Foot
				{ 5, 53641 }, --  Ice Chip
				{ 7, 46707 }, --  Pint-Sized Pink Pachyderm
				{ 9, 46831 }, --  Macabre Marionette
				{ 16, 46544 }, --  Curious Wolvar Pup
				{ 17, 46545 }, --  Curious Oracle Hatchling
			},
		},
		{
			name = ALIL["Achievements"],
			TableType = AC_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1, 44810, AtlasLoot:GetRetByFaction(3656,3478) }, --  Turkey Cage
				{ 2, 44738, 1956 }, --  Kirin Tor Familiar
				{ 16, 40653, 1250 }, --  Reeking Pet Carrier
				{ 17, 44841, 2516 }, --  Little Fawn's Salt Lick
			},
		},
		{
			name = AL["Argent Tournament"],
			[HORDE_DIFF] = {
				{ 1, 44971 }, --  Tirisfal Batling
				{ 2, 44973 }, --  Durotar Scorpion
				{ 3, 44980 }, --  Mulgore Hatchling
				{ 4, 45606 }, --  Sen'jin Fetish
				{ 5, 44974 }, -- Enchanted Broom -- { 50, 44982 }, --  Enchanted Broom
				{ 6, 45022 }, --  Argent Gruntling
				{ 16, 46821 }, --  Shimmering Wyrmling
			},
			[ALLIANCE_DIFF] = {
				{ 1, 44965 }, --  Teldrassil Sproutling
				{ 2, 44970 }, --  Dun Morogh Cub
				{ 3, 44974 }, --  Elwynn Lamb
				{ 4, 45002 }, --  Mechanopeep
				{ 5, 44984 }, --  Ammen Vale Lashling
				{ 6, 44998 }, --  Argent Squire
				{ 16, 46820 }, --  Shimmering Wyrmling
			},
		},
		{
			name = ALIL["Fishing"],
			[NORMAL_DIFF] = {
				{ 1, 43698 }, --  Giant Sewer Rat
				{ 16, 44983 }, --  Strand Crawler
			},
		},
		{ -- Unobtainable
			name = AL["Unobtainable"],
			[NORMAL_DIFF] = {
				{ 1, 39286 }, --  Frosty's Collar
				{ 3, 38658 }, -- Vampiric Batling
				{ 5, 49663 }, -- Wind Rider Cub / Shop
				{ 6, 54847 }, -- Lil' XT / Shop
				{ 7, 49693 }, --  Lil' Phylactery / Shop
				{ 8, 49665 }, --  Pandaren Monk / Shop
				{ 9, 49662 }, --  Gryphon Hatchling / Shop
				{ 11, 49362 }, --  Onyxian Whelpling
				{ 12, 46802 }, --  Heavy Murloc Egg
				{ 16, 198636 }, -- Hippogryph Hatchling
				{ 17, 198635 }, -- Dragon Kite
				{ 18, 46767 }, -- Warbot Ignition Key
				{ 19, 41133 }, -- Unhatched Mr. Chilly

				{ 20, 46892 }, --  Murkimus' Tiny Spear
				{ 21, 45180 }, --  Murkimus' Little Spear
				{ 22, 54857 }, --  Murkimus' Little Spear
				{ 23, 56806 }, --  Mini Thor
				{ 24, 198634 }, --  Banana Charm
				{ 25, 49343 }, --  Spectral Tiger Cub
				{ 26, 44819 }, --  Baby Blizzard Bear
				--{ 19, 198639 }, --  Spectral Tiger Cub
				--{ 20, 198638 }, --  Soul-Trader Beacon
				--{ 24, 198637 }, -- Rocket Chicken
				--{ 47, 49664 }, --  Enchanted Purple Jade
				--{ 48, 48527 }, --  Enchanted Onyx
				--{ 49, 46894 }, --  Enchanted Jade
				--{ 57, 54810 }, --  Celestial Dragon
				--{ 60, 40355 }, --  Azure Whelpling
				--{ 64, 44972 }, --  Alarming Clockbot (NOT IN USE)
				--{ 65, 45942 }, --  XS-001 Constructor Bot
			},
		},
		{ -- Unobtainable
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 49287 }, -- Tuskarr Kite
				{ 2, 198640 }, -- Tuskarr Kite
				{ 3, 198665 }, -- Pebble's Pebble
				{ 5, 49912 }, --  Perky Pug
				{ 6, 49646 }, --  Core Hound Pup

				{ 16, 39878 }, --  Mysterious Egg
				{ 17, 39899 }, --  White Tickbird Hatchling
				{ 18, 39896 }, --  Tickbird Hatchling
				{ 19, 44721 }, --  Proto-Drake Whelp
				{ 20, 39898 }, --  Cobra Hatchling
				--{ 5, 198647 }, -- Fishspeaker's Lucky Lure
			},
		},
	},
}

data["TabardsWrath"] = {
	name = ALIL["Tabard"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.TABARDS,
	items = {
		{
			name = AL["Factions"],
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, 43155 },	-- Tabard of the Ebon Blade
				{ 2, 43157 },	-- Tabard of the Kirin Tor
				{ 3, 43156 },	-- Tabard of the Wyrmrest Accord
			},
		},
	},
}

data["LegendarysWrath"] = {
	name = AL["Legendarys"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	CorrespondingFields = private.LEGENDARYS,
	items = {
		{
			name = AL["Legendarys"],
			[NORMAL_ITTYPE] = {
				{ 1, 49623, "ac4623" },	-- Shadowmourne
				{ 16, 46017, "ac3142" },	-- Val'anyr, Hammer of Ancient Kings
			},
		},
	},
}

data["HeirloomWrath"] = {
	name = AL["Heirloom"],
	ContentType = COLLECTIONS_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	items = {
		{
			name = ALIL["Armor"],
			[NORMAL_ITTYPE] = {
				{ 1, 42985 }, -- Tattered Dreadmist Mantle
				{ 2, 44107 }, -- Exquisite Sunderseer Mantle
				{ 16, 48691 }, -- Tattered Dreadmist Robe

				{ 4, 42952 }, -- Stained Shadowcraft Spaulders
				{ 5, 42984 }, -- Preened Ironfeather Shoulders
				{ 6, 44103 }, -- Exceptional Stormshroud Shoulders
				{ 7, 44105 }, -- Lasting Feralheart Spaulders
				{ 19, 48689 }, -- Stained Shadowcraft Tunic
				{ 20, 48687 }, -- Preened Ironfeather Breastplate

				{ 9, 42950 }, -- Champion Herod's Shoulder
				{ 10, 42951 }, -- Mystical Pauldrons of Elements
				{ 11, 44102 }, -- Aged Pauldrons of The Five Thunders
				{ 12, 44101 }, -- Prized Beastmaster's Mantle
				{ 24, 48677 }, -- Champion's Deathdealer Breastplate
				{ 25, 48683 }, -- Mystical Vest of Elements

				{ 14, 42949 }, -- Polished Spaulders of Valor
				{ 15, 44100 }, -- Pristine Lightforge Spaulders
				{ 29, 48685 }, -- Polished Breastplate of Valor
				{ 30, 44099 }, -- Strengthened Stockade Pauldrons
			},
		},
		{
			name = ALIL["Weapon"],
			[NORMAL_ITTYPE] = {
				{ 1, 44096 }, -- Battleworn Thrash Blade
				{ 2, 48716 }, -- Venerable Mass of McGowan
				{ 3, 42944 }, -- Balanced Heartseeker
				{ 4, 44091 }, -- Sharpened Scarlet Kris

				{ 16, 42945 }, -- Venerable Dal'Rend's Sacred Charge
				{ 17, 42948 }, -- Devout Aurastone Hammer
				{ 18, 44094 }, -- The Blessed Hammer of Grace

				{ 6, 42947 }, -- Dignified Headmaster's Charge
				{ 7, 44095 }, -- Grand Staff of Jordan

				{ 21, 42946 }, -- Charmed Ancient Bone Bow
				{ 22, 44093 }, -- Upgraded Dwarven Hand Cannon

				{ 9, 42943 }, -- Bloodied Arcanite Reaper
				{ 11, 48718 }, -- Repurposed Lava Dredger

				{ 24, 44092 }, -- Reforged Truesilver Champion
				{ 25, 38691 }, -- Ancestral Claymore
			},
		},
		{
			name = ALIL["Trinket"],
			[NORMAL_ITTYPE] = {
				{ 1, 42992 }, -- Discerning Eye of the Beast
				{ 2, 42991 }, -- Swift Hand of Justice
			},
		},
		{
			name = ALIL["Finger"],
			[NORMAL_ITTYPE] = {
				{ 1, 50255 }, -- Dread Pirate Ring
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_ITTYPE] = {
				{ 1, 49177 }, -- Tome of Cold Weather Flight
			},
		},
	},
}

data["ValentinedayWrath"] = {
	name = AL["Love is in the Air"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	items = {
		{ -- Valentineday
			name = AL["Love is in the Air"],
			[NORMAL_DIFF] = {
				{ 1,  22206 }, -- Bouquet of Red Roses
				{ 3, "INV_ValentinesBoxOfChocolates02", nil, AL["Gift of Adoration"] },
				{ 4,  22279 }, -- Lovely Black Dress
				{ 5,  22235 }, -- Truesilver Shafted Arrow
				{ 6,  22200 }, -- Silver Shafted Arrow
				{ 7,  22261 }, -- Love Fool
				{ 8,  22218 }, -- Handful of Rose Petals
				{ 9,  21813 }, -- Bag of Candies
				{ 11, "INV_Box_02", nil, AL["Box of Chocolates"] },
				{ 12, 22237 }, -- Dark Desire
				{ 13, 22238 }, -- Very Berry Cream
				{ 14, 22236 }, -- Buttermilk Delight
				{ 15, 22239 }, -- Sweet Surprise
				{ 16, 22276 }, -- Lovely Red Dress
				{ 17, 22278 }, -- Lovely Blue Dress
				{ 18, 22280 }, -- Lovely Purple Dress
				{ 19, 22277 }, -- Red Dinner Suit
				{ 20, 22281 }, -- Blue Dinner Suit
				{ 21, 22282 }, -- Purple Dinner Suit
			},
		},
		{ -- SFKApothecaryH
			name = C_Map_GetAreaInfo(209).." - "..AL["Apothecary Hummel"],
			[NORMAL_DIFF] = {
				{ 1,  51804 }, -- Winking Eye of Love
				{ 2,  51805 }, -- Heartbreak Charm
				{ 3,  51806 }, -- Shard of Pirouetting Happiness
				{ 4,  51807 }, -- Sweet Perfume Broach
				{ 5,  51808 }, -- Choker of the Pure Heart
				{ 7,  49641 }, -- Faded Lovely Greeting Card
				{ 8,  49715 }, -- Forever-Lovely Rose
				{ 9,  50250 }, -- X-45 Heartbreaker
				{ 10,  50446 }, -- Toxic Wasteling
				{ 11,  50471 }, -- The Heartbreaker
				{ 12,  50741 }, -- Vile Fumigator's Mask
			},
		},
	},
}

data["ChildrensWeekWrath"] = {
	name = AL["Childrens Week"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	CorrespondingFields = private.CHILDRENS_WEEK,
	items = {
		{ -- ChildrensWeek
			name = AL["Childrens Week"],
			[NORMAL_DIFF] = {
				{ 1,  23007 }, -- Piglet's Collar
				{ 2,  23015 }, -- Rat Cage
				{ 3,  23002 }, -- Turtle Box
				{ 4,  23022 }, -- Curmudgeon's Payoff
				{ 6,  32616 }, -- Egbert's Egg
				{ 7,  32617 }, -- Sleepy Willy
				{ 8,  32622 }, -- Elekk Training Collar
				{ 10,  46544 }, -- Curious Wolvar Pup
				{ 11,  46545 }, -- Curious Oracle Hatchling
			},
		},
	},
}

data["MidsummerFestivalWrath"] = {
	name = AL["Midsummer Festival"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	CorrespondingFields = private.MIDSUMMER_FESTIVAL,
	items = {
		{ -- MidsummerFestivalWrath
			name = AL["Midsummer Festival"],
			[NORMAL_DIFF] = {
				{ 1,  23083 }, -- Captured Flame
				{ 2,  34686 }, -- Brazier of Dancing Flames
				{ 4,  23324 }, -- Mantle of the Fire Festival
				{ 5,  23323 }, -- Crown of the Fire Festival
				{ 6,  34683 }, -- Sandals of Summer
				{ 7,  34685 }, -- Vestment of Summer
				{ 9,  23247 }, -- Burning Blossom
				{ 10,  34599 }, -- Juggling Torch
				{ 11,  34684 }, -- Handful of Summer Petals
				{ 12,  23246 }, -- Fiery Festival Brew
				{ 16, 23215 }, -- Bag of Smorc Ingredients
				{ 17, 23211 }, -- Toasted Smorc
				{ 18,  23435 }, -- Elderberry Pie
				{ 19, 23327 }, -- Fire-toasted Bun
				{ 20, 23326 }, -- Midsummer Sausage
			},
		},
		{ -- CFRSlaveAhune
			name = C_Map_GetAreaInfo(3717).." - "..AL["Ahune"],
			[NORMAL_DIFF] = {
                { 1, 54806 }, -- Frostscythe of Lord Ahune
                { 2, 54804 }, -- Shroud of Winter's Chill
                { 3, 54802 }, -- The Frost Lord's War Cloak
                { 4, 54801 }, -- Icebound Cloak
                { 5, 54805 }, -- Cloak of the Frigid Winds
                { 6, 54803 }, -- The Frost Lord's Battle Shroud
                { 8, 35723 }, -- Shards of Ahune
                { 16, 35498 }, -- Formula: Enchant Weapon - Deathfrost
                { 18, 34955 }, -- Scorched Stone
                { 19, 53641 }, --  Ice Chip
                { 21, 35557 }, -- Huge Snowball
			},
		},
	},
}

data["BrewfestWrath"] = {
	name = AL["Brewfest"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	items = {
		{ -- Brewfest
			name = AL["Brewfest"],
			[NORMAL_DIFF] = {
				{ 1,  33968 }, -- Blue Brewfest Hat
				{ 2,  33864 }, -- Brown Brewfest Hat
				{ 3,  33967 }, -- Green Brewfest Hat
				{ 4,  33969 }, -- Purple Brewfest Hat
				{ 5,  33863 }, -- Brewfest Dress
				{ 6,  33862 }, -- Brewfest Regalia
				{ 7,  33966 }, -- Brewfest Slippers
				{ 8,  33868 }, -- Brewfest Boots
				{ 10,  33047 }, -- Belbi's Eyesight Enhancing Romance Goggles (Alliance)
				{ 11,  34008 }, -- Blix's Eyesight Enhancing Romance Goggles (Horde)
				{ 13,  33016 }, -- Blue Brewfest Stein
				{ 15,  37829 }, -- Brewfest Prize Token
				{ 16,  33976 }, -- Brewfest Ram
				{ 17,  33977 }, -- Swift Brewfest Ram
				{ 19,  32233 }, -- Wolpertinger's Tankard
				{ 21,  34028 }, -- "Honorary Brewer" Hand Stamp
				{ 22,  37599 }, -- "Brew of the Month" Club Membership Form
				{ 24,  33927 }, -- Brewfest Pony Keg
				{ 26,  37750 }, -- Fresh Brewfest Hops
				{ 27,  39477 }, -- Fresh Dwarven Brewfest Hops
				{ 28,  39476 }, -- Fresh Goblin Brewfest Hops
				{ 29,  37816 }, -- Preserved Brewfest Hops
			},
		},
		{
			name = AL["Food"],
			[NORMAL_DIFF] = {
				{ 1,  33043 }, -- The Essential Brewfest Pretzel
				{ 3,  34017 }, -- Small Step Brew
				{ 4,  34018 }, -- long Stride Brew
				{ 5,  34019 }, -- Path of Brew
				{ 6,  34020 }, -- Jungle River Water
				{ 7,  34021 }, -- Brewdoo Magic
				{ 8,  34022 }, -- Stout Shrunken Head
				{ 9,  33034 }, -- Gordok Grog
				{ 10,  33035 }, -- Ogre Mead
				{ 11,  33036 }, -- Mudder's Milk
			},
		},
		{
			name = C_Map_GetAreaInfo(1584).." - "..AL["Coren Direbrew"],
			[NORMAL_DIFF] = {
				{ 1,  49116 }, -- Bitter Balebrew Charm
				{ 2,  49118 }, -- Bubbling Brightbrew Charm
				{ 3,  49074 }, -- Coren's Chromium Coaster
				{ 4,  49076 }, -- Mithril Pocketwatch
				{ 5,  49078 }, -- Ancient Pickled Egg
				{ 6,  49080 }, -- Brawler's Souvenir
				{ 8,  49120 }, -- Direbrew's Bloody Shanker
				{ 9,  48663 }, -- Tankard O' Terror
				{ 16,  33977 }, -- Swift Brewfest Ram
				{ 17,  37828 }, -- Great Brewfest Kodo
				{ 19,  37863 }, -- Direbrew's Remote
				{ 21,  38280 }, -- Direbrew's Dire Brew
			},
		},
	},
}

data["HalloweenWrath"] = {
	name = AL["Hallow's End"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	CorrespondingFields = private.HALLOWEEN,
	items = {
		{ -- Halloween1
			name = AL["Hallow's End"].." - "..AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1,  20400 }, -- Pumpkin Bag
				{ 3,  18633 }, -- Styleen's Sour Suckerpop
				{ 4,  18632 }, -- Moonbrook Riot Taffy
				{ 5,  18635 }, -- Bellara's Nutterbar
				{ 6,  20557 }, -- Hallow's End Pumpkin Treat
				{ 8,  20389 }, -- Candy Corn
				{ 9,  20388 }, -- Lollipop
				{ 10, 20390 }, -- Candy Bar
			},
		},
		{ -- Halloween1
			name = AL["Hallow's End"].." - "..AL["Wands"],
			[NORMAL_DIFF] = {
				{ 1, 20410 }, -- Hallowed Wand - Bat
				{ 2, 20409 }, -- Hallowed Wand - Ghost
				{ 3, 20399 }, -- Hallowed Wand - Leper Gnome
				{ 4, 20398 }, -- Hallowed Wand - Ninja
				{ 5, 20397 }, -- Hallowed Wand - Pirate
				{ 6, 20413 }, -- Hallowed Wand - Random
				{ 7, 20411 }, -- Hallowed Wand - Skeleton
				{ 8, 20414 }, -- Hallowed Wand - Wisp
			},
		},
		{ -- Halloween3
			name = AL["Hallow's End"].." - "..AL["Masks"],
			[NORMAL_DIFF] = {
				{ 1,  20561 }, -- Flimsy Male Dwarf Mask
				{ 2,  20391 }, -- Flimsy Male Gnome Mask
				{ 3,  20566 }, -- Flimsy Male Human Mask
				{ 4,  20564 }, -- Flimsy Male Nightelf Mask
				{ 5,  20570 }, -- Flimsy Male Orc Mask
				{ 6,  20572 }, -- Flimsy Male Tauren Mask
				{ 7,  20568 }, -- Flimsy Male Troll Mask
				{ 8,  20573 }, -- Flimsy Male Undead Mask
				{ 16, 20562 }, -- Flimsy Female Dwarf Mask
				{ 17, 20392 }, -- Flimsy Female Gnome Mask
				{ 18, 20565 }, -- Flimsy Female Human Mask
				{ 19, 20563 }, -- Flimsy Female Nightelf Mask
				{ 20, 20569 }, -- Flimsy Female Orc Mask
				{ 21, 20571 }, -- Flimsy Female Tauren Mask
				{ 22, 20567 }, -- Flimsy Female Troll Mask
				{ 23, 20574 }, -- Flimsy Female Undead Mask
			},
		},
		{ -- SMHeadlessHorseman
			name = C_Map_GetAreaInfo(796).." - "..AL["Headless Horseman"],
			[NORMAL_DIFF] = {
                { 1, 211817 }, -- Ring of Ghoulish Glee
                { 2, 211844 }, -- The Horseman's Seal
                { 3, 211847 }, -- Wicked Witch's Band
                { 5, 211850 }, -- The Horseman's Horrific Helm
                { 6, 211851 }, -- The Horseman's Baleful Blade
                { 8, 33292 }, -- Hallowed Helm
                { 10, 34068 }, -- Weighted Jack-o'-Lantern
                { 12, 33277 }, -- Tome of Thomas Thomson
                { 16, 37012 }, -- The Horseman's Reins
                { 18, 33182 }, -- Swift Flying Broom        280% flying
                { 19, 33176 }, -- Flying Broom              60% flying
                { 21, 33184 }, -- Swift Magic Broom         100% ground
                { 22, 37011 }, -- Magic Broom               60% ground
                { 24, 33154 }, -- Sinister Squashling
			},
		},
	},
}

data["DayoftheDead"] = {
	name = AL["Day of the Dead"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	CorrespondingFields = private.DAY_OF_THE_DEAD,
	items = {
		{ -- DayoftheDead
			name = AL["Day of the Dead"],
			[NORMAL_DIFF] = {
				{ 1,  46690 }, -- Candy Skull
				{ 2,  46710 }, -- Recipe: Bread of the Dead
				{ 3,  46711 }, -- Spirit Candle
				{ 4,  46718 }, -- Orange Marigold
				{ 5,  46831 }, -- Macabre Marionette
				{ 6,  46860 }, -- Whimsical Skull Mask
				{ 7,  46861 }, -- Bouquet of Orange Marigolds
			},
		},
	},
}

data["PilgrimsBounty"] = {
	name = AL["Pilgrim's Bounty"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	CorrespondingFields = private.PILGRIMS_BOUNTY,
	items = {
		{ -- Pilgrim's Bounty
			name = AL["Pilgrim's Bounty"],
			[NORMAL_DIFF] = {
				{ 1,  44860 }, -- Recipe: Spice Bread Stuffing
				{ 2,  46803 }, -- Recipe: Spice Bread Stuffing
				{ 3,  44862 }, -- Recipe: Pumpkin Pie
				{ 4,  46804 }, -- Recipe: Pumpkin Pie
				{ 5,  44858 }, -- Recipe: Cranberry Chutney
				{ 6,  46805 }, -- Recipe: Cranberry Chutney
				{ 7,  44859 }, -- Recipe: Candied Sweet Potato
				{ 8,  46806 }, -- Recipe: Candied Sweet Potato
				{ 9,  44861 }, -- Recipe: Slow-Roasted Turkey
				{ 10,  46807 }, -- Recipe: Slow-Roasted Turkey
				{ 12,  44837 }, -- Spice Bread Stuffing
				{ 13,  44836 }, -- Pumpkin Pie
				{ 14,  44840 }, -- Cranberry Chutney
				{ 15,  44839 }, -- Candied Sweet Potato
				{ 16,  44838 }, -- Slow-Roasted Turkey
				{ 17,  46887 }, -- Bountiful Feast
				{ 19,  44812 }, -- Turkey Shooter
				{ 20,  44844 }, -- Turkey Caller
				{ 22,  46723 }, -- Pilgrim's Hat
				{ 23,  46800 }, -- Pilgrim's Attire
				{ 24,  44785 }, -- Pilgrim's Dress
				{ 25,  46824 }, -- Pilgrim's Robe
				{ 26,  44788 }, -- Pilgrim's Boots
			},
		},
	},
}

data["ScourgeInvasionWrath"] = {
	name = AL["Scourge Invasion"],
	ContentType = WORLD_EVENT_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	gameVersion = AtlasLoot.WRATH_VERSION_NUM,
	CorrespondingFields = private.SCOURGE_INVASION,
	items = {
		{ -- ScourgeInvasionEvent1
			name = AL["Vendor"],
			[NORMAL_DIFF] = {
				{ 1, 40492 }, --  Argent War Horn
				{ 2, 40593 }, --  Argent Tome
				{ 3, 40601 }, --  Argent Dawn Banner
				{ 5, 23122 }, --  Consecrated Sharpening Stone
				{ 6, 23123 }, --  Blessed Wizard Oil
				{ 8, 22999 }, --  Tabard of the Argent Dawn
				{ 10, 43530 }, --  Argent Mana Potion
				{ 11, 43531 }, --  Argent Healing Potion
				{ 16, 43074 }, --  Blessed Mantle of Undead Cleansing
				{ 17, 43073 }, --  Blessed Gloves of Undead Cleansing
				{ 19, 43077 }, --  Blessed Shoulderpads of Undead Slaying
				{ 20, 43078 }, --  Blessed Grips of Undead Slaying
				{ 22, 43081 }, --  Blessed Pauldrons of Undead Slaying
				{ 23, 43082 }, --  Blessed Handguards of Undead Slaying
				{ 25, 43070 }, --  Blessed Gauntlets of Undead Slaying
				{ 26, 43068 }, -- Blessed Spaulders of Undead Slaying
			},
		},
		{ -- ScourgeInvasionEvent1
			name = AL["Sets"],
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1,  781 }, -- Blessed Regalia of Undead Cleansing
				{ 3,  782 }, -- Undead Slayer's Blessed Armor
				{ 16,  783 }, -- Blessed Garb of the Undead Slayer
				{ 18,  784 }, -- Blessed Battlegear of Undead Slaying
			},
		},
		{
			name = C_Map_GetAreaInfo(3457).." - "..AL["Prince Tenris Mirkblood"],
			[NORMAL_DIFF] = {
				{ 1,  38658 }, -- Vampiric Batling
				{ 2,  39769 }, -- Arcanite Ripper
			}
		},
	},
}

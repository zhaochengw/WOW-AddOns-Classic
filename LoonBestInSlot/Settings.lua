LBISSettingsDefault =
{
	SelectedSpec = "", 
	SelectedSlot = LBIS.L["All"], 
	SelectedPhase = LBIS.L["All"], 
	SelectedRank = LBIS.L["All"], 
	SelectedSourceType = LBIS.L["All"], 
	SelectedZone = LBIS.L["All"], 
	SelectedZoneNumber = LBIS.L["All"],
	ShowCustom = false,
	OpenTab = "ItemList",
	minimap = {
		hide = false,
		minimapPos = 180
	},
	Tooltip = {
		[LBIS.L["Blood"]..LBIS.L["Death Knight"]] = true,
		[LBIS.L["Frost"]..LBIS.L["Death Knight"]] = true,
		[LBIS.L["Unholy"]..LBIS.L["Death Knight"]] = true,
		[LBIS.L["Balance"]..LBIS.L["Druid"]] = true,
		[LBIS.L["Bear"]..LBIS.L["Druid"]] = true,
		[LBIS.L["Cat"]..LBIS.L["Druid"]] = true,
		[LBIS.L["Restoration"]..LBIS.L["Druid"]] = true,
		[LBIS.L["Beast Mastery"]..LBIS.L["Hunter"]] = true,
		[LBIS.L["Marksmanship"]..LBIS.L["Hunter"]] = true,
		[LBIS.L["Survival"]..LBIS.L["Hunter"]] = true,
		[LBIS.L["Arcane"]..LBIS.L["Mage"]] = true,
		[LBIS.L["Fire"]..LBIS.L["Mage"]] = true,
		[LBIS.L["Frost"]..LBIS.L["Mage"]] = true,
		[LBIS.L["Holy"]..LBIS.L["Paladin"]] = true,
		[LBIS.L["Protection"]..LBIS.L["Paladin"]] = true,
		[LBIS.L["Retribution"]..LBIS.L["Paladin"]] = true,
		[LBIS.L["Discipline"]..LBIS.L["Priest"]] = true,
		[LBIS.L["Holy"]..LBIS.L["Priest"]] = true,
		[LBIS.L["Shadow"]..LBIS.L["Priest"]] = true,
		[LBIS.L["Assassination"]..LBIS.L["Rogue"]] = true,
		[LBIS.L["Combat"]..LBIS.L["Rogue"]] = true,
		[LBIS.L["Subtlety"]..LBIS.L["Rogue"]] = true,
		[LBIS.L["Elemental"]..LBIS.L["Shaman"]] = true,
		[LBIS.L["Enhancement"]..LBIS.L["Shaman"]] = true,
		[LBIS.L["Restoration"]..LBIS.L["Shaman"]] = true,
		[LBIS.L["Affliction"]..LBIS.L["Warlock"]] = true,
		[LBIS.L["Demonology"]..LBIS.L["Warlock"]] = true,
		[LBIS.L["Destruction"]..LBIS.L["Warlock"]] = true,
		[LBIS.L["Arms"]..LBIS.L["Warrior"]] = true,
		[LBIS.L["Fury"]..LBIS.L["Warrior"]] = true,
		[LBIS.L["Protection"]..LBIS.L["Warrior"]] = true
	},
	PhaseTooltip = {
		[LBIS.L["PreRaid"]] = true,
		[LBIS.L["Phase 1"]] = true,
		[LBIS.L["Phase 2"]] = true,
		--[LBIS.L["Phase 3"]] = true,
		--[LBIS.L["Phase 4"]] = true,
		--[LBIS.L["Phase 5"]] = true
	}
};

LBISServerSettingsDefault = 
{
	ItemCache = {},
	CustomList = {},
	LastCacheDate = nil,
}

local lbis_options = {
	name = "Loon Best In Slot",
    handler = LBIS,
    type = "group",
    args = {		
		spacer0 = {
			type = "header",
			name = LBIS.L["Settings"],
			width = "full",
			order = 1,
		},
		showMinimapButton = {
			type = "toggle",
			name = LBIS.L["Show Minimap Button"],
			desc = LBIS.L["Show Minimap Button"],
			get = function(info) return not LBISSettings.minimap.hide end,
			set = function(info, val)
					LBIS:ShowHideMiniMap(not val)
				end,
			width = 2.5,
			order = 2,
		},
		spacer1 = {
			type = "header",
			name = LBIS.L["Show Tooltip"],
			width = "full",
			order = 3,
		},
		showBloodDk = {
			type = "toggle",
			name = LBIS.L["Death Knight"]..": "..LBIS.L["Blood"],
			desc = LBIS.L["Death Knight"]..": "..LBIS.L["Blood"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Blood"]..LBIS.L["Death Knight"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Blood"]..LBIS.L["Death Knight"]] = val end,
			width = 1.1,
			order = 4,
		},
		showFrostDk = {
			type = "toggle",
			name = LBIS.L["Death Knight"]..": "..LBIS.L["Frost"],
			desc = LBIS.L["Death Knight"]..": "..LBIS.L["Frost"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Frost"]..LBIS.L["Death Knight"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Frost"]..LBIS.L["Death Knight"]] = val end,
			width = 1.1,
			order = 5,
		},
		showUnholyDk = {
			type = "toggle",
			name = LBIS.L["Death Knight"]..": "..LBIS.L["Unholy"],
			desc = LBIS.L["Death Knight"]..": "..LBIS.L["Unholy"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Unholy"]..LBIS.L["Death Knight"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Unholy"]..LBIS.L["Death Knight"]] = val end,
			width = 1.1,
			order = 6,
		},
		showBalanceDruid = {
			type = "toggle",
			name = LBIS.L["Druid"]..": "..LBIS.L["Balance"],
			desc = LBIS.L["Druid"]..": "..LBIS.L["Balance"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Balance"]..LBIS.L["Druid"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Balance"]..LBIS.L["Druid"]] = val end,
			width = .825,
			order = 7,
		},
		showBearDruid = {
			type = "toggle",
			name = LBIS.L["Druid"]..": "..LBIS.L["Bear"],
			desc = LBIS.L["Druid"]..": "..LBIS.L["Bear"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Bear"]..LBIS.L["Druid"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Bear"]..LBIS.L["Druid"]] = val end,
			width = .825,
			order = 8,
		},
		showCatDruid = {
			type = "toggle",
			name = LBIS.L["Druid"]..": "..LBIS.L["Cat"],
			desc = LBIS.L["Druid"]..": "..LBIS.L["Cat"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Cat"]..LBIS.L["Druid"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Cat"]..LBIS.L["Druid"]] = val end,
			width = .825,
			order = 9,
		},
		showRestorationDruid = {
			type = "toggle",
			name = LBIS.L["Druid"]..": "..LBIS.L["Restoration"],
			desc = LBIS.L["Druid"]..": "..LBIS.L["Restoration"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Restoration"]..LBIS.L["Druid"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Restoration"]..LBIS.L["Druid"]] = val end,
			width = .825,
			order = 10,
		},
		showBmHunter = {
			type = "toggle",
			name = LBIS.L["Hunter"]..": "..LBIS.L["Beast Mastery"],
			desc = LBIS.L["Hunter"]..": "..LBIS.L["Beast Mastery"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Beast Mastery"]..LBIS.L["Hunter"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Beast Mastery"]..LBIS.L["Hunter"]] = val end,
			width = 1.1,
			order = 11,
		},
		showMarksHunter = {
			type = "toggle",
			name = LBIS.L["Hunter"]..": "..LBIS.L["Marksmanship"],
			desc = LBIS.L["Hunter"]..": "..LBIS.L["Marksmanship"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Marksmanship"]..LBIS.L["Hunter"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Marksmanship"]..LBIS.L["Hunter"]] = val end,
			width = 1.1,
			order = 12,
		},
		showSurvivalHunter = {
			type = "toggle",
			name = LBIS.L["Hunter"]..": "..LBIS.L["Survival"],
			desc = LBIS.L["Hunter"]..": "..LBIS.L["Survival"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Survival"]..LBIS.L["Hunter"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Survival"]..LBIS.L["Hunter"]] = val end,
			width = 1.1,
			order = 13,
		},
		showArcaneMage = {
			type = "toggle",
			name = LBIS.L["Mage"]..": "..LBIS.L["Arcane"],
			desc = LBIS.L["Mage"]..": "..LBIS.L["Arcane"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Arcane"]..LBIS.L["Mage"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Arcane"]..LBIS.L["Mage"]] = val end,
			width = 1.1,
			order = 14,
		},
		showFireMage = {
			type = "toggle",
			name = LBIS.L["Mage"]..": "..LBIS.L["Fire"],
			desc = LBIS.L["Mage"]..": "..LBIS.L["Fire"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Fire"]..LBIS.L["Mage"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Fire"]..LBIS.L["Mage"]] = val end,
			width = 1.1,
			order = 15,
		},
		showFrostMage = {
			type = "toggle",
			name = LBIS.L["Mage"]..": "..LBIS.L["Frost"],
			desc = LBIS.L["Mage"]..": "..LBIS.L["Frost"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Frost"]..LBIS.L["Mage"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Frost"]..LBIS.L["Mage"]] = val end,
			width = 1.1,
			order = 16,
		},
		showHolyPaladin = {
			type = "toggle",
			name = LBIS.L["Paladin"]..": "..LBIS.L["Holy"],
			desc = LBIS.L["Paladin"]..": "..LBIS.L["Holy"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Holy"]..LBIS.L["Paladin"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Holy"]..LBIS.L["Paladin"]] = val end,
			width = 1.1,
			order = 17,
		},
		showProtPaladin = {
			type = "toggle",
			name = LBIS.L["Paladin"]..": "..LBIS.L["Protection"],
			desc = LBIS.L["Paladin"]..": "..LBIS.L["Protection"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Protection"]..LBIS.L["Paladin"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Protection"]..LBIS.L["Paladin"]] = val end,
			width = 1.1,
			order = 18,
		},
		showRetPaladin = {
			type = "toggle",
			name = LBIS.L["Paladin"].." "..LBIS.L["Retribution"],
			desc = LBIS.L["Paladin"].." "..LBIS.L["Retribution"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Retribution"]..LBIS.L["Paladin"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Retribution"]..LBIS.L["Paladin"]] = val end,
			width = 1.1,
			order = 19,
		},
		showDiscPriest = {
			type = "toggle",
			name = LBIS.L["Priest"]..": "..LBIS.L["Discipline"],
			desc = LBIS.L["Priest"]..": "..LBIS.L["Discipline"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Discipline"]..LBIS.L["Priest"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Discipline"]..LBIS.L["Priest"]] = val end,
			width = 1.1,
			order = 20,
		},
		showHolyPriest = {
			type = "toggle",
			name = LBIS.L["Priest"]..": "..LBIS.L["Holy"],
			desc = LBIS.L["Priest"]..": "..LBIS.L["Holy"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Holy"]..LBIS.L["Priest"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Holy"]..LBIS.L["Priest"]] = val end,
			width = 1.1,
			order = 21,
		},
		showShadowPriest = {
			type = "toggle",
			name = LBIS.L["Priest"]..": "..LBIS.L["Shadow"],
			desc = LBIS.L["Priest"]..": "..LBIS.L["Shadow"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Shadow"]..LBIS.L["Priest"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Shadow"]..LBIS.L["Priest"]] = val end,
			width = 1.1,
			order = 22,
		},
		showAssRogue = {
			type = "toggle",
			name = LBIS.L["Rogue"]..": "..LBIS.L["Assassination"],
			desc = LBIS.L["Rogue"]..": "..LBIS.L["Assassination"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Assassination"]..LBIS.L["Rogue"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Assassination"]..LBIS.L["Rogue"]] = val end,
			width = 1.1,
			order = 23,
		},
		showCombatRogue = {
			type = "toggle",
			name = LBIS.L["Rogue"]..": "..LBIS.L["Combat"],
			desc = LBIS.L["Rogue"]..": "..LBIS.L["Combat"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Combat"]..LBIS.L["Rogue"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Combat"]..LBIS.L["Rogue"]] = val end,
			width = 1.1,
			order = 24,
		},
		showSubtletyRogue = {
			type = "toggle",
			name = LBIS.L["Rogue"]..": "..LBIS.L["Subtlety"],
			desc = LBIS.L["Rogue"]..": "..LBIS.L["Subtlety"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Subtlety"]..LBIS.L["Rogue"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Subtlety"]..LBIS.L["Rogue"]] = val end,
			width = 1.1,
			order = 25,
		},
		showEleShaman = {
			type = "toggle",
			name = LBIS.L["Shaman"]..": "..LBIS.L["Elemental"],
			desc = LBIS.L["Shaman"]..": "..LBIS.L["Elemental"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Elemental"]..LBIS.L["Shaman"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Elemental"]..LBIS.L["Shaman"]] = val end,
			width = 1.1,
			order = 26,
		},
		showEnhShaman = {
			type = "toggle",
			name = LBIS.L["Shaman"]..": "..LBIS.L["Enhancement"],
			desc = LBIS.L["Shaman"]..": "..LBIS.L["Enhancement"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Enhancement"]..LBIS.L["Shaman"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Enhancement"]..LBIS.L["Shaman"]] = val end,
			width = 1.1,
			order = 27,
		},
		showRestShaman = {
			type = "toggle",
			name = LBIS.L["Shaman"]..": "..LBIS.L["Restoration"],
			desc = LBIS.L["Shaman"]..": "..LBIS.L["Restoration"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Restoration"]..LBIS.L["Shaman"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Restoration"]..LBIS.L["Shaman"]] = val end,
			width = 1.1,
			order = 28,
		},
		showAfflicWarlock = {
			type = "toggle",
			name = LBIS.L["Warlock"]..": "..LBIS.L["Affliction"],
			desc = LBIS.L["Warlock"]..": "..LBIS.L["Affliction"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Affliction"]..LBIS.L["Warlock"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Affliction"]..LBIS.L["Warlock"]] = val end,
			width = 1.1,
			order = 29,
		},
		showDemonWarlock = {
			type = "toggle",
			name = LBIS.L["Warlock"]..": "..LBIS.L["Demonology"],
			desc = LBIS.L["Warlock"]..": "..LBIS.L["Demonology"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Demonology"]..LBIS.L["Warlock"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Demonology"]..LBIS.L["Warlock"]] = val end,
			width = 1.1,
			order = 30,
		},
		showDestWarlock = {
			type = "toggle",
			name = LBIS.L["Warlock"]..": "..LBIS.L["Destruction"],
			desc = LBIS.L["Warlock"]..": "..LBIS.L["Destruction"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Destruction"]..LBIS.L["Warlock"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Destruction"]..LBIS.L["Warlock"]] = val end,
			width = 1.1,
			order = 31,
		},
		showArmsWarrior = {
			type = "toggle",
			name = LBIS.L["Warrior"]..": "..LBIS.L["Arms"],
			desc = LBIS.L["Warrior"]..": "..LBIS.L["Arms"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Arms"]..LBIS.L["Warrior"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Arms"]..LBIS.L["Warrior"]] = val end,
			width = 1.1,
			order = 32,
		},
		showFuryWarrior = {
			type = "toggle",
			name = LBIS.L["Warrior"]..": "..LBIS.L["Fury"],
			desc = LBIS.L["Warrior"]..": "..LBIS.L["Fury"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Fury"]..LBIS.L["Warrior"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Fury"]..LBIS.L["Warrior"]] = val end,
			width = 1.1,
			order = 33,
		},
		showProtWarrior = {
			type = "toggle",
			name = LBIS.L["Warrior"]..": "..LBIS.L["Protection"],
			desc = LBIS.L["Warrior"]..": "..LBIS.L["Protection"],
			get = function(info) return LBISSettings.Tooltip[LBIS.L["Protection"]..LBIS.L["Warrior"]] end,
			set = function(info, val) LBISSettings.Tooltip[LBIS.L["Protection"]..LBIS.L["Warrior"]] = val end,
			width = 1.1,
			order = 34,
		},
		selectAll = {
			type = "execute",
			name = LBIS.L["Select"].." "..LBIS.L["All"],
			desc = LBIS.L["Select"].." "..LBIS.L["All"],
			confirm = false,
			func = function(info, val)
				LBISSettings.Tooltip[LBIS.L["Blood"]..LBIS.L["Death Knight"]] = true;
				LBISSettings.Tooltip[LBIS.L["Frost"]..LBIS.L["Death Knight"]] = true;
				LBISSettings.Tooltip[LBIS.L["Unholy"]..LBIS.L["Death Knight"]] = true;
				LBISSettings.Tooltip[LBIS.L["Balance"]..LBIS.L["Druid"]] = true;
				LBISSettings.Tooltip[LBIS.L["Bear"]..LBIS.L["Druid"]] = true;
				LBISSettings.Tooltip[LBIS.L["Cat"]..LBIS.L["Druid"]] = true;
				LBISSettings.Tooltip[LBIS.L["Restoration"]..LBIS.L["Druid"]] = true;
				LBISSettings.Tooltip[LBIS.L["Beast Mastery"]..LBIS.L["Hunter"]] = true;
				LBISSettings.Tooltip[LBIS.L["Marksmanship"]..LBIS.L["Hunter"]] = true;
				LBISSettings.Tooltip[LBIS.L["Survival"]..LBIS.L["Hunter"]] = true;
				LBISSettings.Tooltip[LBIS.L["Arcane"]..LBIS.L["Mage"]] = true;
				LBISSettings.Tooltip[LBIS.L["Fire"]..LBIS.L["Mage"]] = true;
				LBISSettings.Tooltip[LBIS.L["Frost"]..LBIS.L["Mage"]] = true;
				LBISSettings.Tooltip[LBIS.L["Holy"]..LBIS.L["Paladin"]] = true;
				LBISSettings.Tooltip[LBIS.L["Protection"]..LBIS.L["Paladin"]] = true;
				LBISSettings.Tooltip[LBIS.L["Retribution"]..LBIS.L["Paladin"]] = true;
				LBISSettings.Tooltip[LBIS.L["Discipline"]..LBIS.L["Priest"]] = true;
				LBISSettings.Tooltip[LBIS.L["Holy"]..LBIS.L["Priest"]] = true;
				LBISSettings.Tooltip[LBIS.L["Shadow"]..LBIS.L["Priest"]] = true;
				LBISSettings.Tooltip[LBIS.L["Assassination"]..LBIS.L["Rogue"]] = true;
				LBISSettings.Tooltip[LBIS.L["Combat"]..LBIS.L["Rogue"]] = true;
				LBISSettings.Tooltip[LBIS.L["Subtlety"]..LBIS.L["Rogue"]] = true;
				LBISSettings.Tooltip[LBIS.L["Elemental"]..LBIS.L["Shaman"]] = true;
				LBISSettings.Tooltip[LBIS.L["Enhancement"]..LBIS.L["Shaman"]] = true;
				LBISSettings.Tooltip[LBIS.L["Restoration"]..LBIS.L["Shaman"]] = true;
				LBISSettings.Tooltip[LBIS.L["Affliction"]..LBIS.L["Warlock"]] = true;
				LBISSettings.Tooltip[LBIS.L["Demonology"]..LBIS.L["Warlock"]] = true;
				LBISSettings.Tooltip[LBIS.L["Destruction"]..LBIS.L["Warlock"]] = true;
				LBISSettings.Tooltip[LBIS.L["Arms"]..LBIS.L["Warrior"]] = true;
				LBISSettings.Tooltip[LBIS.L["Fury"]..LBIS.L["Warrior"]] = true;
				LBISSettings.Tooltip[LBIS.L["Protection"]..LBIS.L["Warrior"]] = true;
			end,
			width = 1.6,
			order = 37,
		},
		deSelectAll = {
			type = "execute",
			name = LBIS.L["Deselect"].." "..LBIS.L["All"],
			desc = LBIS.L["Deselect"].." "..LBIS.L["All"],
			confirm = false,
			func = function(info, val)
				LBISSettings.Tooltip[LBIS.L["Blood"]..LBIS.L["Death Knight"]] = false;
				LBISSettings.Tooltip[LBIS.L["Frost"]..LBIS.L["Death Knight"]] = false;
				LBISSettings.Tooltip[LBIS.L["Unholy"]..LBIS.L["Death Knight"]] = false;
				LBISSettings.Tooltip[LBIS.L["Balance"]..LBIS.L["Druid"]] = false;
				LBISSettings.Tooltip[LBIS.L["Bear"]..LBIS.L["Druid"]] = false;
				LBISSettings.Tooltip[LBIS.L["Cat"]..LBIS.L["Druid"]] = false;
				LBISSettings.Tooltip[LBIS.L["Restoration"]..LBIS.L["Druid"]] = false;
				LBISSettings.Tooltip[LBIS.L["Beast Mastery"]..LBIS.L["Hunter"]] = false;
				LBISSettings.Tooltip[LBIS.L["Marksmanship"]..LBIS.L["Hunter"]] = false;
				LBISSettings.Tooltip[LBIS.L["Survival"]..LBIS.L["Hunter"]] = false;
				LBISSettings.Tooltip[LBIS.L["Arcane"]..LBIS.L["Mage"]] = false;
				LBISSettings.Tooltip[LBIS.L["Fire"]..LBIS.L["Mage"]] = false;
				LBISSettings.Tooltip[LBIS.L["Frost"]..LBIS.L["Mage"]] = false;
				LBISSettings.Tooltip[LBIS.L["Holy"]..LBIS.L["Paladin"]] = false;
				LBISSettings.Tooltip[LBIS.L["Protection"]..LBIS.L["Paladin"]] = false;
				LBISSettings.Tooltip[LBIS.L["Retribution"]..LBIS.L["Paladin"]] = false;
				LBISSettings.Tooltip[LBIS.L["Discipline"]..LBIS.L["Priest"]] = false;
				LBISSettings.Tooltip[LBIS.L["Holy"]..LBIS.L["Priest"]] = false;
				LBISSettings.Tooltip[LBIS.L["Shadow"]..LBIS.L["Priest"]] = false;
				LBISSettings.Tooltip[LBIS.L["Assassination"]..LBIS.L["Rogue"]] = false;
				LBISSettings.Tooltip[LBIS.L["Combat"]..LBIS.L["Rogue"]] = false;
				LBISSettings.Tooltip[LBIS.L["Subtlety"]..LBIS.L["Rogue"]] = false;
				LBISSettings.Tooltip[LBIS.L["Elemental"]..LBIS.L["Shaman"]] = false;
				LBISSettings.Tooltip[LBIS.L["Enhancement"]..LBIS.L["Shaman"]] = false;
				LBISSettings.Tooltip[LBIS.L["Restoration"]..LBIS.L["Shaman"]] = false;
				LBISSettings.Tooltip[LBIS.L["Affliction"]..LBIS.L["Warlock"]] = false;
				LBISSettings.Tooltip[LBIS.L["Demonology"]..LBIS.L["Warlock"]] = false;
				LBISSettings.Tooltip[LBIS.L["Destruction"]..LBIS.L["Warlock"]] = false;
				LBISSettings.Tooltip[LBIS.L["Arms"]..LBIS.L["Warrior"]] = false;
				LBISSettings.Tooltip[LBIS.L["Fury"]..LBIS.L["Warrior"]] = false;
				LBISSettings.Tooltip[LBIS.L["Protection"]..LBIS.L["Warrior"]] = false;
			end,
			width = 1.6,
			order = 38,
		},
		spacer2 = {
			type = "header",
			name = "",
			width = "full",
			order = 39,
		},
		showPreRaid = {
			type = "toggle",
			name = LBIS.L["PreRaid"],
			desc = LBIS.L["PreRaid"],
			get = function(info) return LBISSettings.PhaseTooltip[LBIS.L["PreRaid"]] end,
			set = function(info, val) LBISSettings.PhaseTooltip[LBIS.L["PreRaid"]] = val end,
			width = 1.1,
			order = 40,
		},
		showPhase1 = {
			type = "toggle",
			name = LBIS.L["Phase 1"],
			desc = LBIS.L["Phase 1"],
			get = function(info) return LBISSettings.PhaseTooltip[LBIS.L["Phase 1"]] end,
			set = function(info, val) LBISSettings.PhaseTooltip[LBIS.L["Phase 1"]] = val end,
			width = 1.1,
			order = 41,
		},
		 showPhase2 = {
		 	type = "toggle",
		 	name = LBIS.L["Phase 2"],
		 	desc = LBIS.L["Phase 2"],
		 	get = function(info) return LBISSettings.PhaseTooltip[LBIS.L["Phase 2"]] end,
		 	set = function(info, val) LBISSettings.PhaseTooltip[LBIS.L["Phase 2"]] = val end,
		 	width = 1.1,
		 	order = 42,
		 },
		-- showPhase3 = {
		-- 	type = "toggle",
		-- 	name = LBIS.L["Phase 3"],
		-- 	desc = LBIS.L["Phase 3"],
		-- 	get = function(info) return LBISSettings.PhaseTooltip[LBIS.L["Phase 3"]] end,
		-- 	set = function(info, val) LBISSettings.PhaseTooltip[LBIS.L["Phase 3"]] = val end,
		-- 	width = 1.1,
		-- 	order = 43,
		-- },
		-- showPhase4 = {
		-- 	type = "toggle",
		-- 	name = LBIS.L["Phase 4"],
		-- 	desc = LBIS.L["Phase 4"],
		-- 	get = function(info) return LBISSettings.PhaseTooltip[LBIS.L["Phase 4"]] end,
		-- 	set = function(info, val) LBISSettings.PhaseTooltip[LBIS.L["Phase 4"]] = val end,
		-- 	width = 1.1,
		-- 	order = 44,
		-- },
		-- showPhase5 = {
		-- 	type = "toggle",
		-- 	name = LBIS.L["Phase 5"],
		-- 	desc = LBIS.L["Phase 5"],
		-- 	get = function(info) return LBISSettings.PhaseTooltip[LBIS.L["Phase 5"]] end,
		-- 	set = function(info, val) LBISSettings.PhaseTooltip[LBIS.L["Phase 5"]] = val end,
		-- 	width = 1.1,
		-- 	order = 45,
		-- },
		spacer2 = {
			type = "header",
			name = "",
			width = "full",
			order = 46,
		},
		show = {
			type = "toggle",
			name = LBIS.L["Show Custom"],
			desc = LBIS.L["Show Custom"],
			get = function(info) return LBISSettings.ShowCustom end,
			set = function(info, val) LBISSettings.ShowCustom = val end,
			width = 1.1,
			order = 47,
		},
	}
};

function LBIS:CreateSettings()

	LBISSettings = LBIS:DeepCopy(LBISSettingsDefault, LBISSettings);
	LBISServerSettings = LBIS:DeepCopy(LBISServerSettingsDefault, LBISServerSettings);

	if strfind(LBISSettings.SelectedSpec, ":") == nil then
		LBISSettings.SelectedSpec = "";
	end

	LibStub("AceConfig-3.0"):RegisterOptionsTable("Loon Best In Slot", lbis_options, nil)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Loon Best In Slot"):SetParent(InterfaceOptionsFramePanelContainer)
end
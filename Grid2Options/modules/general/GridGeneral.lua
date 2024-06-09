local L = Grid2Options.L

--==========================================================================
-- Multiple Themes Support
--==========================================================================

Grid2Options:AddGeneralOptions( "General", "Themes", {
	themes = {
		type = "toggle",
		name = L["Enable Themes"],
		desc = L["Enable support for multiple themes, allowing to define different visual styles for the Grid2 frames. General options will change and a new Themes section will be displayed."],
		width = "full",
		order = 5,
		get = function ()
			 return Grid2Frame.dba.profile.extraThemes ~= nil
		end,
		set = function (_, v)
			if v then
				Grid2Layout.dba.profile.extraThemes = {}
				Grid2Frame.dba.profile.extraThemes  = {}
			elseif #Grid2Frame.dba.profile.extraThemes==0 then
				Grid2Layout.dba.profile.extraThemes = nil
				Grid2Frame.dba.profile.extraThemes  = nil
			else
				Grid2Options:MessageDialog(L["Error: this option cannot be disabled because extra themes have been created. Remove the extra themes first."])
			end
		end,
	},
})

--==========================================================================
-- Icons Zoom
--==========================================================================

Grid2Options:AddGeneralOptions( "General", "Icon Textures Zoom", {
	displayZoomedIcons = {
		type = "toggle",
		name = L["Zoom In buffs and debuffs icon textures"],
		desc = L["Enable this option to hide the default blizzard border of buffs and debuffs Icons."],
		width = "full",
		order = 10,
		get = function ()
			return Grid2Frame.db.shared.displayZoomedIcons
		end,
		set = function (_, v)
			Grid2Frame.db.shared.displayZoomedIcons = v or nil
			Grid2:SetupStatusPrototype()
			Grid2Options:UpdateIndicators()
		end,
	},
})

--==========================================================================
-- Raid Size calculation
--==========================================================================

Grid2Options:AddGeneralOptions( "General", "Raid Size", {
	raidSizeType = {
		type = "select",
		name = L["Choose the Raid Size calculation method"],
		desc = L["This setting is used to setup different layouts, frame sizes or themes depending of the raid size."],
		width = "double",
		order = 5,
		get = function()
			return Grid2.db.profile.raidSizeType or 0
		end,
		set = function(_,v)
			Grid2.db.profile.raidSizeType = (v~=0) and v or nil
			Grid2:GroupChanged()
		end,
		values = Grid2Options.raidSizeValues,
	},
})

--==========================================================================
-- Text formatting
--==========================================================================

--[[
	Text formatting options for indicators durations&stacks
	General -> Misc Tab -> Text Formatting section

	Text formatting database variables and default values:
	Grid2.db.profile.formatting = {
		longDecimalFormat        = "%.1f",
		shortDecimalFormat       = "%.0f",
		longDurationStackFormat  = "%.1f:%d",
		shortDurationStackFormat = "%.0f:%d",
		invertDurationStack      = false,
		secondsElapsedFormat     = "%ds",
		minutesElapsedFormat     = "%dm",
		percentFormat            = "%.0f%%",
	}
	shortFormat = used when duration >= 1 sec
	longFormat  = used when duration <  1 sec
	The database formats are translated to/from a more user friendly format, examples:
		"%.1f" <=> "%d"     "%.1f/%d"  <=> "%d/%s"
	User friendly format tokens:
		"%d" = represents duration, becomes translated to/from: "%.0f" or "%.1f" (floating point number)
		"%s" = represents stacks,   becomes translated to/from: "%d" (integer number)
		"%p" = represents a percent value
--]]

-- Posible values for "Display tenths of a second" options
local tenthsValues = { L["Never"], L["Always"] , L["When duration<1sec"] }

-- Retrieve a formatting mask from database.
-- The mask is converted to a user friendly format
-- formatType = "DecimalFormat" | "DurationStackFormat"
local function GetFormat(formatType)
	local dbx = Grid2.db.profile.formatting
	local mask = dbx[ "long".. formatType ]
	return mask:gsub("%%d","%%s"):gsub("%%.0f","%%d"):gsub("%%.1f","%%d")
end

-- Calculates tenths display mode examining format masks saved in database, returns:
-- 1 => Never display tenths  ( both shortFormat and longFormat containing a "%.0f" token )
-- 2 => Always display tenths ( both shortFormat and longFormat containing a "%.1f" token )
-- 3 => Display tenths when duraction<1sec (shortFormat contains "%.1f" and longFormat contains "%.0f")
local function GetTenths(formatType)
	local dbx   = Grid2.db.profile.formatting
	local short = dbx[ "short".. formatType ]
	local long  = dbx[ "long" .. formatType ]
	return (long:find("%%.0f") and 1) or (short:find("%%.1f") and 2) or 3
end

-- SetFormat(formatType, mask, tenths)
-- Generate a short and long format mask according to the user selections saving the masks in database
local SetFormat
do
	-- converts a user friendly mask to the database format
	local function ToDbFormat(formatType, mask, tenths)
		if formatType == "DecimalFormat" then
			local short = tenths==2 and "%%.1f" or "%%.0f"
			local long  = tenths==1 and "%%.0f" or "%%.1f"
			return (mask:gsub("%%d", short)), (mask:gsub("%%d", long))
		elseif formatType == "DurationStackFormat" then
			local i1 = mask:find("%%d")
			local i2 = mask:find("%%s")
			if i1 and i2 then
				local short, long = ToDbFormat("DecimalFormat", mask, tenths)
				return (short:gsub("%%s","%%d")), (long:gsub("%%s","%%d")), i1>i2
			end
		end
	end
	function SetFormat(formatType, mask, tenths)
		mask   = mask   or GetFormat(formatType)
		tenths = tenths or GetTenths(formatType)
		local short, long, inverted = ToDbFormat(formatType, mask, tenths)
		if short then
			-- sanity sheck, string.format will crash if format is wrong, and nothing is saved
			string.format(short, 1, 1); string.format(long , 1, 1)
			local dbx = Grid2.db.profile.formatting
			dbx["short"..formatType] = short
			dbx["long" ..formatType] = long
			if inverted ~= nil then	dbx.invertDurationStack = inverted end
			Grid2Options:UpdateIndicators('text')
		end
	end
end

Grid2Options:AddGeneralOptions( "General", "Text Formatting", {
	dFormat = {
		type = "input",
		order = 1,
		name = L["Duration Format"],
		desc = L["Examples:\n(%d)\n%d seconds"],
		get = function() return GetFormat("DecimalFormat") end,
		set = function(_,v)	SetFormat("DecimalFormat", v, nil) end,
	},
	dTenths = {
		type = "select",
		order = 2,
		name = L["Display tenths of a second"],
		desc = L["Display tenths of a second"],
		get = function () return GetTenths("DecimalFormat") end,
		set = function (_, v) SetFormat("DecimalFormat", nil, v) end,
		values = tenthsValues,
	},
	separator1 = { type = "description", name = "", order = 3 },
	dsFormat = {
		type = "input",
		order = 4,
		name = L["Duration+Stacks Format"],
		desc = L["Examples:\n%d/%s\n%s(%d)"],
		get = function() return GetFormat("DurationStackFormat") end,
		set = function(_,v)	SetFormat("DurationStackFormat", v, nil) end,
	},
	dsTenths = {
		type = "select",
		order = 5,
		name = L["Display tenths of a second"],
		desc = L["Display tenths of a second"],
		get = function ()  return GetTenths("DurationStackFormat") end,
		set = function (_, v) SetFormat("DurationStackFormat", nil, v) end,
		values = tenthsValues
	},
	separator2 = { type = "description", name = "", order = 6 },
	secFormat = {
		type = "input",
		order = 7,
		name = L["Seconds Format"],
		desc = L["Examples:\n%ds\n%d seconds"],
		get = function()
			return Grid2.db.profile.formatting.secondsElapsedFormat
		end,
		set = function(_,v)
			string.format(v, 1) -- sanity check, crash if v is not a correct format mask
			Grid2.db.profile.formatting.secondsElapsedFormat  = v
			Grid2Options:UpdateIndicators('text')
		end,
	},
	minFormat = {
		type = "input",
		order = 8,
		name = L["Minutes Format"],
		desc = L["Examples:\n%dm\n%d minutes"],
		get = function()
			return Grid2.db.profile.formatting.minutesElapsedFormat
		end,
		set = function(_,v)
			string.format(v, 1) -- sanity check, crash if v is not a correct format mask
			Grid2.db.profile.formatting.minutesElapsedFormat  = v
			Grid2Options:UpdateIndicators('text')
		end,
	},
	separator3 = { type = "description", name = "", order = 9 },
	percentFormat = {
		type = "input",
		order = 10,
		width = "double",
		name = L["Percent Format"],
		desc = L["Examples:\n%p\n%p percent"],
		get = function()
			return Grid2.db.profile.formatting.percentFormat:gsub("%%.0f","%%p"):gsub("%%%%","%%")
		end,
		set = function(_,v)
			v= (v=='') and "%.0f%%" or v:gsub("%%p","$p"):gsub("%%","%%%%"):gsub("$p","%%.0f")
			string.format(v, 1) -- sanity check, crash if v is not a correct format mask
			Grid2.db.profile.formatting.percentFormat  = v
			Grid2:GetStatusByName('health-current'):UpdateDB()
			Grid2Options:UpdateIndicators('text')
		end,
	},
})

--==========================================================================
-- Classic Auras Duration
--==========================================================================

if Grid2.isVanilla then
	Grid2Options:AddGeneralOptions( "General", "Auras", {
		classicDurations = {
			type = "toggle",
			name = L["Enable Durations"],
			desc = L["Check this option to be able to display auras duration & expiration time."],
			width = "full",
			order = 115,
			get = function () return not Grid2.db.global.disableDurations end,
			set = function (_, v)
				Grid2.db.global.disableDurations = (not v) or nil
				ReloadUI()
			end,
			confirm = function() return L["UI must be reloaded to change this option. Are you sure?"] end,
		},
	})
end

--==========================================================================
-- Target on mouse down
--==========================================================================

Grid2Options:AddGeneralOptions( "General", "Click Targeting", {
	downClick = {
		type = "toggle",
		name = L["Trigger targeting on the down portion of the mouse click"],
		desc = L["Trigger targeting on the down portion of the mouse click"],
		width = "full",
		order = 119,
		get = function () return Grid2.db.global.clickOnMouseDown end,
		set = function (_, v)
			Grid2.db.global.clickOnMouseDown = v or nil
			Grid2Frame.mouseClickType = v and "AnyDown" or "AnyUp"
			for _, frame in next, Grid2Frame.registeredFrames do
				frame:RegisterForClicks( Grid2Frame.mouseClickType )
			end
		end,
		disabled = InCombatLockdown
	},
})

--==========================================================================
-- Minimap
--==========================================================================

if Grid2Layout.minimapIcon then -- checks if Grid2LDB addon was loaded
	Grid2Options:AddGeneralOptions( "General", "Minimap Icon", {
		showMinimapIcon = {
			type = "toggle",
			name = L["Show Minimap Icon"],
			desc = L["Show Minimap Icon"],
			width = "full",
			order = 119,
			get = function () return Grid2:SetMinimapIcon('query') end,
			set = function (_, v) Grid2:SetMinimapIcon(v) end,
		},
	})
end

--==========================================================================
-- Hide blizzard raid frames
--==========================================================================

do
	local order = 0
	local function Fix(k,v)
		if k=='party' and GetCVar("useCompactPartyFrames") then
			SetCVar("useCompactPartyFrames", v and '1' or '0') -- special case for parties in classic because PartyFrame does not exist
		end
		if not IsAddOnLoaded("Blizzard_CompactRaidFrames") then
			EnableAddOn("Blizzard_CompactRaidFrames") -- reenabling CompactRaidFrames addon because in dragonflight it cannot be disabled
			EnableAddOn("Blizzard_CUFProfiles")
		end
	end
	local function Reload()
		Grid2Options:ConfirmDialog(L['Changes will take effect on next UI reload. Do you want to reload the UI now ?'], ReloadUI)
	end
	local function Get(key)
		local v = Grid2.db.profile.hideBlizzard
		return v and v[key]
	end
	local function Set(key)
		local dbx = Grid2.db.profile
		dbx.hideBlizzard = dbx.hideBlizzard or {}
		dbx.hideBlizzard[key] = not dbx.hideBlizzard[key] or nil
		if not next(dbx.hideBlizzard) then dbx.hideBlizzard = nil end
	end
	local function Create(key, text, disabled)
		if disabled then return end
		order = order + 1
		return {
			type = "toggle",
			width = 0.43,
			order = order,
			name = L[text],
			desc = L[text],
			get = function () return Get(key) end,
			set = function (_, v) Fix(key,v); Set(key,v); Reload(); end,
		}
	end
	Grid2Options:AddGeneralOptions( "General", "Hide Blizzard Frames", {
		raid   = Create( 'raid',   "Raid"    ),
		party  = Create( 'party',  "Party"   ),
		player = Create( 'player', "Player"  ),
		target = Create( 'target', "Target"  ),
		focus  = Create( 'focus',  "Focus",  _G.FocusFrame==nil),
		pet    = Create( 'pet',    "Pet"     ),
	})
end

--==========================================================================
-- Load on demand
--==========================================================================
--[[
Grid2Options:AddGeneralOptions( "General", "Options management", {
	loadOnDemand = {
		type = "toggle",
		name = L["Load options on demand (requires UI reload)"],
		desc = L["OPTIONS_ONDEMAND_DESC"],
		width = "full",
		order = 150,
		get = function () return not Grid2.db.global.LoadOnDemandDisabled end,
		set = function (_, v)
			Grid2.db.global.LoadOnDemandDisabled = (not v) or nil
		end,
	},
})
--]]

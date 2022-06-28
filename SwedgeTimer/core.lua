local addon_name, st = ...
local SwedgeTimer = LibStub("AceAddon-3.0"):NewAddon(addon_name, "AceConsole-3.0")
local SML = LibStub("LibSharedMedia-3.0")
local print = st.utils.print_msg
-- print(type(SML.DefaultMedia.statusbar))
-- print(SML.DefaultMedia.statusbar)

function SwedgeTimer:OnInitialize()
	-- uses the "Default" profile instead of character-specific profiles
	-- https://www.wowace.com/projects/ace3/pages/api/ace-db-3-0



	local AC = LibStub("AceConfig-3.0")
	local ACD = LibStub("AceConfigDialog-3.0")

	local SwedgeTimerDB = LibStub("AceDB-3.0"):New("SwedgeTimerDB", self.defaults, true)
	self.db = SwedgeTimerDB

	-- registers an options table and adds it to the Blizzard options window
	-- https://www.wowace.com/projects/ace3/pages/api/ace-config-3-0
	AC:RegisterOptionsTable("SwedgeTimer_Options", self.options)
	self.optionsFrame = ACD:AddToBlizOptions("SwedgeTimer_Options", "SwedgeTimer")

	-- adds a child options table, in this case our profiles panel
	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	AC:RegisterOptionsTable("SwedgeTimer_Profiles", profiles)
	ACD:AddToBlizOptions("SwedgeTimer_Profiles", "Profiles", "SwedgeTimer")

	
	-- if the player is not a paladin, replace the command to open the menu with a dummy printout
	local register_func_string = "SlashCommand"
	if not st.utils.player_is_paladin() then
		register_func_string = "NotPaladinSlashCommand"
	end
	self:RegisterChatCommand("st", register_func_string)
	self:RegisterChatCommand("swedgetimer", register_func_string)

end

function SwedgeTimer:OnEnable()

	-- only load if player is a paladin
	if not st.utils.player_is_paladin() then return end

	-- Sort out character information
	st.player.get_twohand_spec_points()
	st.player.guid = UnitGUID("player")
	st.player.weapon_id = GetInventoryItemID("player", 16)
	st.player.reset_swing_timer()
end

function SwedgeTimer:NotPaladinSlashCommand(input, editbox)
	print('SwedgeTimer is disabled when the player character is not a Paladin.')
end

function SwedgeTimer:SlashCommand(input, editbox)
	local ACD = LibStub("AceConfigDialog-3.0")
	ACD:Open("SwedgeTimer_Options")
end

local bar_visibility_values = {
	always = "Always show",
	in_combat = "In combat",
	active_seal = "Seal active",
	in_combat_or_active_seal = "In combat or seal active",
}

local bar_vis_ordering = {
	"always", "in_combat", "active_seal", "in_combat_or_active_seal",
}

------------------------------------------------------------------------------------
-- Default settings for the addon.
SwedgeTimer.defaults = {
    profile = {

		-- Top level
		welcome_message = true,
		bar_enabled = true,

		-- Behaviour toggles
		lag_detection_enabled = true,
		judgement_marker_enabled = true,
        bar_twist_color_enabled = false,
		hide_when_not_ret = true,
		enable_deadzone = true,

		-- Auto-hide setting
		visibility_key = "always",

		-- Lag calibration
		lag_multiplier = 1.4,
		lag_offset = 15,

		-- Marker position settings
		gcd_padding_mode = "Dynamic",
		gcd_static_padding_ms = 100,
		twist_padding_mode = "None",
		twist_window_padding_ms = 0,

		-- Bar dimensions
		bar_height = 32,
		bar_width = 345,

		-- Bar positioning
		bar_locked = true,
		bar_x_offset = 0,
		bar_y_offset = -180,
		bar_point = "CENTER",
		bar_rel_point = "CENTER",

		-- Frame strata/draw level
		frame_strata = "MEDIUM",
		draw_level = 10,

		-- Bar textures
		bar_texture_key = "Solid",
        gcd_texture_key = "Solid",
        backplane_texture_key = "Solid",
        border_texture_key = "None",
		deadzone_texture_key = "Solid",
		backplane_alpha = 0.85,

		-- Deadzone scaling
		deadzone_scale_factor = 1.0,

		-- Border settings
		border_mode_key = "Solid",
		backplane_outline_width = 2,

		-- Font settings
		font_size = 16,
		font_color = {1.0, 1.0, 1.0, 1.0},
		text_font = SML.DefaultMedia.font,
		font_outline_key = "outline",
        left_text = "attack_speed",
        right_text = "swing_timer",

		-- Marker settings
		marker_width = 3,
		gcd1_enabled = true,
		gcd2_enabled = true,
		gcd_marker_color = {0.9, 0.9, 0.9, 1.0},
		twist_marker_color = {0.9,0.9,0.9,1.0},
		judgement_marker_color = {0.9,0.9,0.01,1.0},

		-- Seal color settings

		bar_color_command = {0.14, 0.66, 0.14, 1.0},
		bar_color_righteousness = {0.14, 0.66, 0.14, 1.0},
        bar_color_blood = {0.86, 0.38, 0.11, 1.0},
		bar_color_vengeance = {0.8, 0.5, 0.4, 1.0},
		bar_color_wisdom = {0., 0.4, 0.7, 1.0},
		bar_color_light = {0.67, 0.92, 0.859, 1.0},
		bar_color_justice = {0.77, 0.31, 0.48, 1.0},
		bar_color_crusader = {0.9, 0.75, 0.42, 1.0},


		-- Special bar colors
        bar_color_cant_twist = {0.83, 0.83, 0.01, 1.0},
        bar_color_warning = {1.0, 0.0, 0.0, 1.0}, -- when if you cast SoC, you can't twist out of it that swing
        bar_color_twisting = {0.7,0.1,0.6,1.0},
		bar_color_default = {0.53, 0.43, 0.53, 1.0},

		-- GCD underlay bar colors
		bar_color_gcd = {0.48, 0.48, 0.48, 1.0},

		-- Deadzone bar colors
		bar_color_deadzone = {0.72, 0.05, 0.05, 0.72},

    },

}

local outline_map = {
	_none="",
	outline="OUTLINE",
	thick_outline="THICKOUTLINE",
}

local bar_border_modes = {
	Solid="Solid",
	Texture="Texture",
	None="None",
}

local outlines = {
	_none="None",
	outline="Outline",
	thick_outline="Thick Outline",
}

local texts = {
	_none="Not shown",
	attack_speed="Attack speed",
	swing_timer="Swing timer",
}

local gcd_padding_modes = {
	Dynamic="Dynamic",
	Fixed="Fixed",
	None="None",
}

local valid_anchor_points = {
	TOPLEFT="TOPLEFT",
    TOPRIGHT="TOPRIGHT",
    BOTTOMLEFT="BOTTOMLEFT",
    BOTTOMRIGHT="BOTTOMRIGHT",
    TOP="TOP",
    BOTTOM="BOTTOM",
    LEFT="LEFT",
    RIGHT="RIGHT",
    CENTER="CENTER",
}

------------------------------------------------------------------------------------
-- Functions to apply settings to the UI elements.
local set_bar_position = function()
	local db = SwedgeTimer.db.profile
	local frame = st.bar.frame
	frame:ClearAllPoints()
	frame:SetPoint(db.bar_point, UIParent, db.bar_rel_point, db.bar_x_offset, db.bar_y_offset)
	frame.bar:SetPoint("TOPLEFT", 0, 0)
	frame.bar:SetPoint("TOPLEFT", 0, 0)
	frame.gcd_bar:SetPoint("TOPLEFT", 0, 0)
	frame.deadzone:SetPoint("TOPRIGHT", 0, 0)
	frame.left_text:SetPoint("TOPLEFT", 3, -(db.bar_height / 2) + (db.font_size / 2))
	frame.right_text:SetPoint("TOPRIGHT", -3, -(db.bar_height / 2) + (db.font_size / 2))
	st.configure_bar_outline()
end
st.set_bar_position = set_bar_position

local set_fonts = function()
	local db = SwedgeTimer.db.profile
	local frame = st.bar.frame
	local font_path = SML:Fetch('font', db.text_font)

	local opt_string = outline_map[db.font_outline_key]
	frame.left_text:SetFont(font_path, db.font_size, opt_string)
	frame.right_text:SetFont(font_path, db.font_size, opt_string)
	frame.left_text:SetPoint("TOPLEFT", 3, -(db.bar_height / 2) + (db.font_size / 2))
	frame.right_text:SetPoint("TOPRIGHT", -3, -(db.bar_height / 2) + (db.font_size / 2))
	frame.left_text:SetTextColor(unpack(db.font_color))
	frame.right_text:SetTextColor(unpack(db.font_color))
end
st.set_fonts = set_fonts

local set_bar_size = function()
	local db = SwedgeTimer.db.profile
	local frame = st.bar.frame
	frame:SetWidth(db.bar_width)
	frame:SetHeight(db.bar_height)
	frame.bar:SetWidth(db.bar_width)
	frame.bar:SetHeight(db.bar_height)
	-- frame.gcd_bar:SetWidth(db.bar_width)
	frame.gcd_bar:SetHeight(db.bar_height)
	set_fonts()
	st.set_markers()
end

local set_marker_widths = function()
	local frame = st.bar.frame
	local db = SwedgeTimer.db.profile
	frame.twist_line:SetThickness(db.marker_width)
	frame.gcd1_line:SetThickness(db.marker_width)
	frame.gcd2_line:SetThickness(db.marker_width)
	frame.judgement_line:SetThickness(db.marker_width)
end
st.set_marker_widths = set_marker_widths

local set_marker_colors = function()
	local frame = st.bar.frame
	local db = SwedgeTimer.db.profile
	frame.twist_line:SetColorTexture(unpack(SwedgeTimer.db.profile.twist_marker_color))
	frame.gcd1_line:SetColorTexture(unpack(SwedgeTimer.db.profile.gcd_marker_color))
	frame.gcd2_line:SetColorTexture(unpack(SwedgeTimer.db.profile.gcd_marker_color))
	frame.judgement_line:SetColorTexture(unpack(SwedgeTimer.db.profile.judgement_marker_color))
end
st.set_marker_colors = set_marker_colors

st.set_markers = function()
	st.set_marker_colors()
	st.set_marker_widths()
	st.bar.set_marker_offsets()
end

-- Function to be called whenever the state of the backdrop or texture
-- outline are changed.
st.configure_bar_outline = function()
	local db = SwedgeTimer.db.profile
	local mode = db.border_mode_key
	local frame = st.bar.frame
	local texture_key = db.border_texture_key
    local tv = db.backplane_outline_width
	-- 8 corresponds to no border
	tv = tv + 8

	-- Switch settings based on mode
	if mode == "None" then
		texture_key = "None"
		tv = 8
	elseif mode == "Texture" then
		tv = 8
	elseif mode == "Solid" then
		texture_key = "None"
	end

    frame.backplane.backdropInfo = {
        bgFile = SML:Fetch('statusbar', db.backplane_texture_key),
		edgeFile = SML:Fetch('border', texture_key),
        tile = true, tileSize = 16, edgeSize = 16, 
        insets = { left = 6, right = 6, top = 6, bottom = 6}
    }
    frame.backplane:ApplyBackdrop()

	tv = tv - 2
    frame.backplane:SetPoint('TOPLEFT', -1*tv, tv)
    frame.backplane:SetPoint('BOTTOMRIGHT', tv, -1*tv)
	frame.backplane:SetBackdropColor(0,0,0, db.backplane_alpha)

end

st.set_deadzone = function()
	local db = SwedgeTimer.db.profile
	local f = st.bar.frame.deadzone
    f:SetTexture(SML:Fetch('statusbar', db.deadzone_texture_key))
	f:SetVertexColor(unpack(db.bar_color_deadzone))
end

------------------------------------------------------------------------------------
-- Now configure the option table for our settings interface.
SwedgeTimer.options = {
	type = "group",
	name = "SwedgeTimer",
	handler = SwedgeTimer,
	args = {

		------------------------------------------------------------------------------------
		-- top-level settings
		welcome_message = {
			type = "toggle",
			order = 1.1,
			name = "Welcome message",
			desc = "Displays a login message showing the addon version on player login or reload.",
			get = "GetValue",
			set = "SetValue",
		},
		bar_enabled = {
			type = "toggle",
			order = 1,
			name = "Enabled",
			desc = "Enables or disables SwedgeTimer.",
			get = "GetValue",
			set = "SetValue",
		},

		------------------------------------------------------------------------------------
		-- addon feature behaviour
		bar_behaviour = {
			type = "group",
			name = "Behaviour",
			handler = SwedgeTimer,
			order = 1,
			args = {
				features_header = {
					type = "header",
					name = "Features",
					order = 0.1,
				},
				hide_when_not_ret = {
					type = "toggle",
					order = 1,
					name = "Hide when not Ret",
					desc = "When enabled, hides the bar when the player is not specced as retribution (determined by the presence of any "..
					"points in the Two-handed Weapon Specialization talent).",
					get = "GetValue",
					set = "SetValue",
				},
				judgement_marker_enabled = {
					type = "toggle",
					order = 2,
					name = "Judgement marker",
					desc = "When enabled, indicates where on the swing timer judgement will come off cooldown (if in "..
					"a high value spell to judge like Seal of Blood).",
					get = "GetValue",
					set = "SetValue",
				},
				bar_twist_color_enabled = {
					type="toggle",
					order=4,
					name="Twist color",
					desc="When the player is actively twisting, and two seals are active, the bar will turn a special color "..
					"dictated in the Appearance settings.",
					get = "GetValue",
					set = "SetValue",
				},
				enable_deadzone = {
					type = "toggle",
					order = 3,
					name = "Enable deadzone",
					desc = "When enabled, will display a shaded region at the end of the bar corresponding to the \"Deadzone\", where "..
					"the player is locked into their current seal for this swing due to latency.",
					get = "GetValue",
					set = function(self, value)
						SwedgeTimer.db.profile.enable_deadzone = value
						if value then
							st.bar.frame.deadzone:Show()
						else
							st.bar.frame.deadzone:Hide()
						end
					end,
				},
				
				------------------------------------------------------------------------------------
				-- Visibility options, when to show the bar.
				autohide_header = {
					type="header",
					order=5.0,
					name="Bar visibility",
				},
				autohide_desc = {
					type="description",
					order=5.01,
					name="Determines under what conditions the bar should be shown.",
				},
				visibility_key = {
					type="select",
					order=5.1,
					name="Visibility",
					desc="The visibility setting to use.",
					values=bar_visibility_values,
					sorting=bar_vis_ordering,
					get = "GetValue",
					set = "SetValue",
				},

				------------------------------------------------------------------------------------
				-- Deadzone scaling.
				deadzone_header = {
					type="header",
					order = 5.5,
					name = "Deadzone scaling"					,
				},
				deadzone_desc = {
					type="description",
					order = 5.51,
					name="The deadzone can be adjusted by a scale factor to better suit the unique"..
					" properties of a player's connection to the game world. Decrease this value if you are able "..
					"to twist inside your deadzone, or increase this value if you cannot twist when just "..
					"outside the deadzone.",
				},
				deadzone_scale_factor = {
					type = "range",
					order = 5.52,
					name="Deadzone scale factor",
					desc="This multiplier will be applied to the player's latency to the game world"..
					" to determine the size of the deadzone.",
					min=0.1, max=2.0,
					step=0.05,
					get="GetValue",
					set="SetValue",
					disabled = function()
						return SwedgeTimer.db.profile.enable_deadzone == false
					end,
				},

				------------------------------------------------------------------------------------
				-- marker options
				marker_settings = {
					order=6,
					type="header",
					name="Marker settings",
				},
				marker_descriptions = {
					order=7,
					type="description",
					name="When GCD offset mode is Dynamic or Fixed, the GCD markers are pushed back "..
					"from the end of the swing to account for player input/lag. When the mode is set to Dynamic, this uses the calibrated lag "..
					"described in Lag Compensation."
				},
				gcd_padding_mode = {
					order=8,
					type="select",
					values=gcd_padding_modes,
					style="dropdown",
					desc="The type of GCD offset, if any, to use.",
					name="GCD offset mode",
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.gcd_padding_mode=key
						st.bar.set_gcd_marker_offsets()
					end,
				},
				gcd_static_padding_ms = {
					type = "range",
					order = 9,
					name = "Fixed GCD offset (ms)",
					desc = "The GCD markers are set at one and two standard GCDs before the swing ends, plus this offset.",
					min = 0, max = 400,
					step = 1,
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.gcd_static_padding_ms = key
						st.bar.set_gcd_marker_offsets()
					end,
					disabled = function()
						return SwedgeTimer.db.profile.gcd_padding_mode ~= "Fixed"
					end,
				},

				twist_window_descriptions = {
					order=10.1,
					type="description",
					name="When Twist window offset mode is Dynamic or Fixed, the twist window marker is pushed back "..
					"from the end of the swing to account for player input/lag. When the mode is set to Dynamic, this uses the calibrated lag "..
					"described in Lag Compensation."
				},
				twist_padding_mode = {
					order=10.2,
					type="select",
					values=gcd_padding_modes,
					style="dropdown",
					desc="The type of twist window offset, if any, to use.",
					name="Twist window offset mode",
					get = "GetValue",
					-- set = "SetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.twist_padding_mode = key
						st.bar.set_twist_tick_offset()
					end,

				},
				twist_window_padding_ms = {
					type = "range",
					order = 10.3,
					name = "Fixed twist offset (ms)",
					desc = "The twist window indicator is placed (400ms plus the offset value) before the end of the swing. Players with high "..
					"latency may wish to increase this value.",
					min = 0, max=400,
					step=1,
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.twist_window_padding_ms = key
						st.bar.set_twist_tick_offset()
					end
					,
					disabled = function()
						return SwedgeTimer.db.profile.twist_padding_mode ~= "Fixed"
					end,
				},
			},
		},

		------------------------------------------------------------------------------------
		-- Lag detection
		lag_detection_section= {
			type = "group",
			name = "Lag Compensation",
			handler = SwedgeTimer,
			order = 9,			
			args = {
				lag_settings = {
					order=5.01,
					type="header",
					name="What is lag compensation?",
				},
				lag_descriptions1 = {
					order=5.02,
					type="description",
					name="Many Ret players are familiar with attempting a close twist after a GCD, only to swing in command.",
				},
				lag_descriptions101 = {
					order=5.03,
					type="description",
					image="Interface/AddOns/SwedgeTimer/Images/close_twist4.blp",
					imageWidth=350,
					imageHeight=350*0.2,
					imageCoords={0.00,1.0,0.4,0.6},
					name="",
				},
				lag_descriptions1001 = {
					order=5.031,
					type="description",
					name="In the above image, the player is in SoC, and has a small amount of time after their GCD ends to cast SoB."..
					" Even with spell queueing, if the player's lag is high enough, the SoB cast can be pushed into the next swing.",
				},
				lag_descriptions102 = {
					order=5.04,
					type="description",
					name="SwedgeTimer includes a lag compensation suite, that detects instances where the player will not be "..
					"able to twist before their swing goes off due to latency.",
				},
				lag_descriptions103 = {
					order=5.05,
					type="description",
					name="",
					image="Interface/AddOns/SwedgeTimer/Images/dont_twist1.blp",
					imageWidth=350,
					imageHeight=350*0.2,
					imageCoords={0.00,1.0,0.4,0.6},
				},
				lag_descriptions104 = {
					order=5.06,
					type="description",
					name="If you see the bar turn the color specified above, don't try to twist; either ride the command swing and cast "..
					"a filler spell like Consecration, or momentarily stopattack before SoB/startattacking.",
				},

				lag_detection_enabled = {
					type = "toggle",
					order = 4.1,
					name = "Lag compensation",
					desc = "Enables the lag compensation suite.",
					get = "GetValue",
					set = "SetValue",
					},
				bar_color_cant_twist = {
					order=4.2,
					type="color",
					name="Bar color",
					desc="The color the bar turns when the player is in a good seal to twist from, but "..
					"their GCD combined with their lag will mean they cannot twist this swing unless they stopattack.",
					hasAlpha=false,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_cant_twist
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_cant_twist = {r,g,b,a}
					end
				},
				lag_descriptions2001 = {
					order=5.20,
					type="header",
					name="How it works",
				},
				lag_descriptions_20002 = {
					order=5.201,
					type="description",
					name="To detect impossible twists, we compare the time left on the player's swing after the GCD expires to some value representing "..
					"the lag. If the time left after GCD is lower than this lag value, the lag compensation is triggered.",
				},
				lag_descriptions_2002 = {
					order=5.21,
					type="description",
					name="The player's raw latency is often not the most accurate predictor of impossible twists. Instead of using the raw latency, we "..
					"adjust the lag according to the settings below for the best result. SwedgeTimer is pre-calibrated, but everyone's connection is different, "..
					"and optimal settings may vary among players."
				},

				lag_descriptions3001 = {
					order=6.0,
					type="header",
					name="Do I need to calibrate?",
				},
				lag_descriptions_3002 = {
					order=6.22,
					type="description",
					name="To see if you require calibration, simply try some close twists on a target. Cast any spell when the bar is approaching the middle GCD marker, and try to twist your swing."..
					" if the special bar color triggers only when you get command swings, and you are able to twist all swings where the bar color does not trigger, you are calibrated correctly."..
					" If not, you may need to change the settings below.",
				},
				lag_descriptions4001 = {
					order=7.0,
					type="header",
					name="Calibration settings",
				},
				lag_descriptions_2 = {
					order=7.22,
					type="description",
					name="The figure compared to the swing time remaining after GCD is equal to (ax + b), where x is the raw latency, a is the multipler, and b is the offset.",
				},
				lag_descriptions_22 = {
					order=7.23,
					type="description",
					name="If the special bar color is not triggering when you're forced into command swings, increase the multiplier or the threshold a small amount and try again.",
				},
				lag_descriptions_23 = {
					order=7.24,
					type="description",
					name="If the special bar color is triggering when you are able to twist, reduce the multipler or the threshold by a small amount and try again.",
				},
				-- lag_descriptions_2 = {
				-- 	order=7.23,
				-- 	type="description",
				-- 	name=""
				-- },
				lag_multiplier = {
					type = "range",
					order = 7.3,
					name = "Lag multiplier",
					desc = "The player's world trip latency is multiplied by this value in the lag detection calibration.",
					min = 0, max = 2.0,
					step = 0.05,
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.lag_multiplier = key
						st.bar.set_gcd_marker_offsets()
						st.bar.set_twist_tick_offset()
					end,
				},
				lag_offset = {
					type = "range",
					order = 7.3,
					name = "Lag offset (ms)",
					desc = "The player's world trip latency has this value added to it in the lag detection calibration.",
					min = 0, max = 200,
					step = 1,
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.lag_offset = key
						st.bar.set_gcd_marker_offsets()
						st.bar.set_twist_tick_offset()
					end,
				},
			},
		},

		------------------------------------------------------------------------------------
		-- Size/position options
		positioning = {
			type = "group",
			name = "Size and Position",
			handler = SwedgeTimer,
			order = 2,
			args = {

				------------------------------------------------------------------------------------
				-- size options
				size_header = {
					type='header',
					name='Size',
					order=1,
				},

				bar_width = {
					type = "range",
					order = 2,
					name = "Width",
					desc = "The width of the swing timer bar.",
					min = 100, max = 600,
					step = 1,
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.bar_width = key
						set_bar_size()
					end,
				},

				bar_height = {
					type = "range",
					order = 3,
					name = "Height",
					desc = "The height of the swing timer bar.",
					min = 6, max = 60,
					step = 1,
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.bar_height = key
						set_bar_size()
					end,
				},

				------------------------------------------------------------------------------------
				-- position options
				position_header = {
					type = 'header',
					name = 'Position',
					order = 4,
				},
				position_description = {
					order=4.1,
					type="description",
					name="When the bar is not locked, it can be clicked and dragged with the mouse.",
				},
				position_description2 = {
					order=4.2,
					type="description",
					name="If you don't understand how UI frames anchor, then either keep both anchors on "..
					"CENTER and enter offsets manually, or position the bar with the mouse.",
				},
				bar_x_offset = {
					type = "input",
					order = 5,
					name = "Bar x offset",
					desc = "The x position of the bar.",
					get = function()
						return tostring(SwedgeTimer.db.profile.bar_x_offset)
					end,
					set = function(self, input)
						SwedgeTimer.db.profile.bar_x_offset = input
						set_bar_position()
					end			
				},
				bar_y_offset = {
					type = "input",
					order = 6,
					name = "Bar y offset",
					desc = "The y position of the bar.",
					get = function()
						return tostring(SwedgeTimer.db.profile.bar_y_offset)
					end,
					set = function(self, input)
						SwedgeTimer.db.profile.bar_y_offset = input
						set_bar_position()
					end			
				},

				bar_point = {
					order = 6.1,
					type="select",
					name = "Anchor",
					desc = "One of the region's anchors.",
					values = valid_anchor_points,
					get = "GetValue",
					set = function(self, input)
						SwedgeTimer.db.profile.bar_point = input
						set_bar_position()
					end,
				},
				bar_rel_point = {
					order = 6.2,
					type="select",
					name = "Relative anchor",
					desc = "Anchor point on region to align against.",
					values = valid_anchor_points,
					get = "GetValue",
					set = function(self, input)
						SwedgeTimer.db.profile.bar_rel_point = input
						set_bar_position()
					end,
				},
				bar_locked = {
					type = "toggle",
					order = 4.15,
					name = "Bar locked",
					desc = "Prevents the swing bar from being dragged with the mouse.",
					get = "GetValue",
					set = function(self, input)
						SwedgeTimer.db.profile.bar_locked = input
						st.bar.frame:SetMovable(not input)
						st.bar.frame:EnableMouse(not input)
					end,
				},

				------------------------------------------------------------------------------------
				-- strata/draw level options
				strata_header = {
					type = 'header',
					name = 'Frame Strata',
					order = 7.0,
				},
				strata_description = {
					type = 'description',
					name = 'The frame strata the addon should be drawn at. Anything higher than MEDIUM will be drawn over some in-game menus, so this is the highest strata allowed.',
					order = 7.1,
				},
				frame_strata = {
					order = 7.2,
					type="select",
					name = "Frame strata",
					desc = "The frame strata the addon should be drawn at.",
					values = {
						BACKGROUND = "BACKGROUND",
						LOW = "LOW",
						MEDIUM = "MEDIUM",
					},
					get = "GetValue",
					set = function(self, input)
						SwedgeTimer.db.profile.frame_strata = input
						st.bar.frame:SetFrameStrata(input)
						st.bar.frame.backplane:SetFrameStrata(input)
					end,
				},
				draw_level = {
					type = "range",
					order = 7.3,
					name = "Draw level",
					desc = "The bar's draw level within the frame strata.",
					min = 1, max=100,
					step=1,
					get = "GetValue",
					set = function(self, input)
						SwedgeTimer.db.profile.draw_level = input
						st.bar.frame:SetFrameLevel(input+1)
						st.bar.frame.backplane:SetFrameLevel(input)
					end
				},

			},
		},

		------------------------------------------------------------------------------------
		-- All appearance options
		bar_appearance = {
			type = "group",
			name = "Appearance",
			handler = SwedgeTimer,
			order = 3,
			args = {

				------------------------------------------------------------------------------------
				-- texture options
				texture_header = {
					order=1,
					type="header",
					name="Textures",
				},
				bar_texture_key = {
					order = 2,
					type = "select",
					name = "Bar",
					desc = "The texture of the swing bar.",
					dialogControl = "LSM30_Statusbar",
					values = SML:HashTable("statusbar"),
					get = function(info) return SwedgeTimer.db.profile.bar_texture_key or SML.DefaultMedia.statusbar end,
					set = function(self, key)
						SwedgeTimer.db.profile.bar_texture_key = key
						st.bar.frame.bar:SetTexture(SML:Fetch('statusbar', key))
					end
				},
				
				gcd_texture_key = {
					order = 2.1,
					type = "select",
					name = "GCD underlay",
					desc = "The texture of the GCD underlay bar.",
					dialogControl = "LSM30_Statusbar",
					values = SML:HashTable("statusbar"),
					get = function(info) return SwedgeTimer.db.profile.gcd_texture_key or SML.DefaultMedia.statusbar end,
					set = function(self, key)
						SwedgeTimer.db.profile.gcd_texture_key = key
						st.bar.frame.gcd_bar:SetTexture(SML:Fetch('statusbar', key))
						st.bar.set_gcd_bar_width()
					end
				},

				backplane_texture_key = {
					order = 2.2,
					type = "select",
					name = "Backplane",
					desc = "The texture of the bar's backplane.",
					dialogControl = "LSM30_Statusbar",
					values = SML:HashTable("statusbar"),
					get = function(info) return SwedgeTimer.db.profile.backplane_texture_key or SML.DefaultMedia.statusbar end,
					set = function(self, key)
						SwedgeTimer.db.profile.backplane_texture_key = key
						st.bar.frame.backplane.backdropInfo.bgFile = SML:Fetch('statusbar', key)
						st.bar.frame.backplane:ApplyBackdrop()
						st.bar.frame.backplane:SetBackdropColor(0,0,0, SwedgeTimer.db.profile.backplane_alpha)
					end
				},

				backplane_alpha = {
					type = "range",
					order = 2.3,
					name = "Backplane alpha",
					desc = "The opacity of the swing bar's backplane.",
					min = 0.0, max = 1.0,
					step = 0.05,
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.backplane_alpha = key
						st.bar.frame.backplane:SetBackdropColor(0, 0, 0, key)
					end,
				},


				------------------------------------------------------------------------------------
				-- Border options
				bar_border_header = {
					order=3.5,
					type="header",
					name="Bar border",
				},
				bar_border_description = {
					order=3.51,
					type="description",
					name="The bar border can either be set to a solid color, a texture, or disabled.",
				},

				border_mode_key = {
					order=3.6,
					type="select",
					values=bar_border_modes,
					style="dropdown",
					desc="The outline mode to use for the bar border, if any.",
					name="Border mode",
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.border_mode_key = key
						st.configure_bar_outline()
				
					end,
				},

				placeholder_1 = {
					type="description",
					order = 3.8,
					name = "",
				},

				backplane_outline_width = {
					type = "range",
					order = 5.1,
					name = "Solid outline thickness",
					desc = "The thickness of the outline around the swing timer bar, if in Solid border mode.",
					min = 0, max = 5,
					step = 0.2,
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.backplane_outline_width = key
						st.configure_bar_outline()
					end,
					disabled = function()
						return SwedgeTimer.db.profile.border_mode_key ~= "Solid"
					end,
				},

				border_texture_key = {
					order = 6,
					type = "select",
					name = "Border",
					desc = "The border texture of the swing bar.",
					dialogControl = "LSM30_Border",
					values = SML:HashTable("border"),
					get = function(info) return SwedgeTimer.db.profile.border_texture_key or SML.DefaultMedia.border end,
					set = function(self, key)
						SwedgeTimer.db.profile.border_texture_key = key
						st.configure_bar_outline()
					end,
					disabled = function()
						return SwedgeTimer.db.profile.border_mode_key ~= "Texture"
					end,
				},

				------------------------------------------------------------------------------------
				-- deadzone settings
				deadzone_header = {
					order = 7.0,
					type = "header",
					name = "Deadzone",
				},
				deadzone_desc = {
					order = 7.01,
					type = "description",
					name = "The deadzone is the shaded region at the end of the bar indicating where the player cannot "..
					"change seals before their swing due to latency. "..
					"The deadzone must be enabled to be adjusted."
				},
				deadzone_texture_key = {
					order = 7.1,
					type = "select",
					name = "Deadzone texture",
					desc = "The texture of the deadzone bar.",
					dialogControl = "LSM30_Statusbar",
					values = SML:HashTable("statusbar"),
					get = function(info) return SwedgeTimer.db.profile.deadzone_texture_key or SML.DefaultMedia.statusbar end,
					set = function(self, key)
						SwedgeTimer.db.profile.deadzone_texture_key = key
						st.set_deadzone()
					end,
					disabled = function()
						return SwedgeTimer.db.profile.enable_deadzone ~= true
					end,
				},

				bar_color_deadzone = {
					order=7.2,
					type="color",
					name="Bar color",
					desc="The color of the deadzone bar",
					hasAlpha=true,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_deadzone
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_deadzone = {r,g,b,a}
						st.set_deadzone()
					end,
					disabled = function()
						return SwedgeTimer.db.profile.enable_deadzone ~= true
					end,
				},

				------------------------------------------------------------------------------------
				-- font settings
				fonts_header = {
					order=9,
					type="header",
					name="Fonts",
				},
				font_size = {
					type = "range",
					order = 9.03,
					name = "Font size",
					desc = "The size of the swing timer and attack speed fonts.",
					min = 10, max = 40, softMin = 8, softMax = 24,
					step = 1,
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.font_size = key
						set_fonts()
					end,
				},
				font_color = {
					order=9.04,
					type="color",
					name="Font color",
					desc="The color of the addon texts.",
					hasAlpha=false,
					get = function()
						return unpack(SwedgeTimer.db.profile.font_color)
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.font_color = {r,g,b,a}
						set_fonts()
					end
				},
				text_font = {
					order = 9.01,
					type = "select",
					name = "Font",
					desc = "The font to use in the swing timer and attack speed text.",
					dialogControl = "LSM30_Font",
					values = SML:HashTable("font"),
					get = function(info) return SwedgeTimer.db.profile.text_font or SML.DefaultMedia.font end,
					set = function(self, key)
						SwedgeTimer.db.profile.text_font = key
						set_fonts()
					end
				},
				font_outline_key = {
					order=9.02,
					type="select",
					values=outlines,
					style="dropdown",
					desc="The outline type to use with the font.",
					name="Font outline",
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.font_outline_key = key
						set_fonts()
					end,
				},
				left_text = {
					type="select",
					order = 9.1,
					values=texts,
					style="dropdown",
					name = "Left text",
					desc = "What to shows on the left of the swing timer bar.",
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.left_text = key
						set_texts()
					end
				},
				right_text = {
					type="select",
					order = 9.1,
					values=texts,
					style="dropdown",
					name = "Right text",
					desc = "What to shows on the right of the swing timer bar.",
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.right_text = key
						set_texts()
					end,
				},
				
				------------------------------------------------------------------------------------
				-- Contextual color settings
				context_colors_header = {
					type="header",
					order = 10,
					name = "Contextual bar colors",
				},
				bar_color_default = {
					order=11,
					type="color",
					name="No seal",
					desc="No seal active on the player.",
					hasAlpha=false,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_default
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_default = {r,g,b,a}
						st.bar.set_bar_color()
					end
				},
				bar_color_twisting = {
					order=12,
					type="color",
					name="Active twist",
					desc="The player is mid-twist and has multiple seals active. Only is used if the relevant option is checked in the Behaviour settings.",
					hasAlpha=false,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_twisting
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_twisting = {r,g,b,a}
						st.bar.set_bar_color()
					end
				},
				bar_color_warning = {
					order=13,
					type="color",
					name="Don't cast",
					desc="The color the bar turns when the player is in a good seal to twist from, but "..
					"does not have time to incur a GCD before their swing completes.",
					hasAlpha=false,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_warning
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_warning = {r,g,b,a}
					end
				},

				------------------------------------------------------------------------------------
				-- Seal color settings
				seal_colors_header = {
					order=20,
					type="header",
					name="Seal colors",
				},



				bar_color_command = {
					order=21,
					type="color",
					name="Command",
					desc="Seal of Command (will turn the \"Don\'t Cast\" color when the player should not cast and wait to twist).",
					hasAlpha=false,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_command
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_command = {r,g,b,a}
						st.bar.set_bar_color()
					end
				},
				bar_color_righteousness = {
					order=22,
					type="color",
					name="Righteousness",
					desc="Seal of Righteousness (will turn the \"Don\'t Cast\" color when the player should not cast and wait to twist)",
					hasAlpha=false,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_righteousness
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_righteousness = {r,g,b,a}
						st.bar.set_bar_color()
					end
				},				
				bar_color_blood = {
					order=23,
					type="color",
					name="Blood",
					desc="Seal of Blood/Seal of the Martyr",
					hasAlpha=false,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_blood
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_blood = {r,g,b,a}
						st.bar.set_bar_color()
					end
				},
				bar_color_wisdom = {
					order=25,
					type="color",
					name="Wisdom",
					desc="Seal of Wisdom",
					hasAlpha=false,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_wisdom
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_wisdom = {r,g,b,a}
						st.bar.set_bar_color()
					end
				},

				bar_color_light = {
					order=26,
					type="color",
					name="Light",
					desc="Seal of Light",
					hasAlpha=false,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_light
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_light = {r,g,b,a}
						st.bar.set_bar_color()
					end
				},

				bar_color_justice = {
					order=27,
					type="color",
					name="Justice",
					desc="Seal of Justice",
					hasAlpha=false,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_justice
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_justice = {r,g,b,a}
						st.bar.set_bar_color()
					end
				},
				bar_color_crusader = {
					order=27.1,
					type="color",
					name="Crusader",
					desc="Seal of the Crusader",
					hasAlpha=false,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_crusader
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_crusader = {r,g,b,a}
						st.bar.set_bar_color()
					end
				},
				bar_color_vengeance = {
					order=24,
					type="color",
					name="Vengeance",
					desc="Seal of Vengeance/Seal of Corruption",
					hasAlpha=false,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_vengeance
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_vengeance = {r,g,b,a}
						st.bar.set_bar_color()
					end
				},

				------------------------------------------------------------------------------------
				-- GCD settings
				gcd_header = {
					order=30,
					type="header",
					name="GCD underlay",
				},
				bar_color_gcd = {
					order=31,
					type="color",
					name="Underlay color",
					desc="The color of the GCD underlay.",
					hasAlpha=true,
					get = function()
						local tab = SwedgeTimer.db.profile.bar_color_gcd
						return tab[1], tab[2], tab[3], tab[4]
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.bar_color_gcd = {r,g,b,a}
						st.bar.frame.gcd_bar:SetVertexColor(unpack(SwedgeTimer.db.profile.bar_color_gcd))
					end
				},

				------------------------------------------------------------------------------------
				-- Marker appearance settings
				markers_header = {
					order=50,
					type="header",
					name="Markers",
				},
				gcd1_enabled = {
					type = "toggle",
					order = 50.1,
					name = "Enable GCD marker 1",
					desc = "Toggles drawing the first GCD marker on the bar.",
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.gcd1_enabled = key
						st.bar.show_or_hide_ticks()
					end,
				},
				gcd2_enabled = {
					type = "toggle",
					order = 50.2,
					name = "Enable GCD marker 2",
					desc = "Toggles drawing the second GCD marker on the bar.",
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.gcd2_enabled = key
						st.bar.show_or_hide_ticks()
					end,
				},
				-- marker_colors_header = {
				-- 	order=50.5,
				-- 	type="description",
				-- 	name="The GCD and twist window colors can be changed below.",
				-- },
				marker_width = {
					type = "range",
					order = 55,
					name = "Marker width",
					desc = "The width of the twist window GCD, and judgement markers.",
					min = 1, max = 6,
					step = 1,
					get = "GetValue",
					set = function(self, key)
						SwedgeTimer.db.profile.marker_width = key
						set_marker_widths()
					end,
				},
				gcd_marker_color = {
					order=53,
					type="color",
					name="GCD color",
					desc="The color of the GCD markers.",
					hasAlpha=false,
					get = function()
						return unpack(SwedgeTimer.db.profile.gcd_marker_color)
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.gcd_marker_color = {r,g,b,a}
						set_marker_colors()
					end
				},
				twist_marker_color = {
					order=52,
					type="color",
					name="Twist window color",
					desc="The color of the twist window marker.",
					hasAlpha=false,
					get = function()
						return unpack(SwedgeTimer.db.profile.twist_marker_color)
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.twist_marker_color = {r,g,b,a}
						set_marker_colors()
					end
				},
				judgement_marker_color = {
					order=54,
					type="color",
					name="Judgement indicator",
					desc="The color of the judgement indicator marker, which shows when judgement will come off cooldown"..
					" on the player's swing timer. This marker only shows when the player is in a high-value spell to judge, "..
					"e.g. Blood, Vengeance, Justice.",
					hasAlpha=false,
					get = function()
						return unpack(SwedgeTimer.db.profile.judgement_marker_color)
					end,
					set = function(self,r,g,b,a)
						SwedgeTimer.db.profile.judgement_marker_color = {r,g,b,a}
						set_marker_colors()
					end
				},
			}
		},
	}
}

-- -- https://www.wowace.com/projects/ace3/pages/ace-config-3-0-options-tables#title-4-1
function SwedgeTimer:GetValue(info)
    -- print(info)
	return self.db.profile[info[#info]]
end

function SwedgeTimer:SetValue(info, value)
	self.db.profile[info[#info]] = value
end

--=========================================================================================
-- End, if debug verify module was read.
--=========================================================================================
if st.debug then print('-- Parsed core.lua module correctly') end

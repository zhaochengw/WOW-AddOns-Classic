--[[--
	by ALA
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

-->		constant
	CT.TUISTYLE = {
		FrameBorderSize = 8,

		FrameXSizeMin_Style1 = 250,
		FrameYSizeMin_Style1 = 165,
		FrameXSizeMin_Style2 = 100,
		FrameYSizeMin_Style2 = 180,
		FrameHeaderYSize = 20,
		FrameFooterYSize = 24,

		FrameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		FrameFontSizeLarge = 16,
		FrameFontSize = 14,
		FrameFontSizeMedium = 13,
		FrameFontSizeSmall = 10,
		FrameFontOutline = "OUTLINE",

		TreeFrameXToBorder = 1,
		TreeFrameYToBorder = 0,
		TreeFrameHeaderYSize = 0,
		TreeFrameFooterYSize = 0,
		TreeFrameSeqWidth = 1,
		TreeFrameLabelBackgroundTexCoord = { 0.05, 0.95, 0.05, 0.95, },
		TreeNodeXSize = 120,
		TreeNodeYSize = 36,
		TreeNodeXGap = 12,
		TreeNodeYGap = 12,
		TreeNodeXToBorder = 12,
		TreeNodeYToTop = 12,
		TreeNodeYToBottom = 10,
		TreeNodeNameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		TreeNodeNameFontSize = 16,
		TreeNodeNameFontOutline = "OUTLINE",
		TreeNodeNumberFont = NumberFont_Shadow_Med:GetFont(),--=[[Fonts\ARHei.ttf]]--[[Fonts\FRIZQT__.TTF]],
		TreeNodeNumberFontSize = 16,
		TreeNodeNumberFontOutline = "OUTLINE",

		TalentDepArrowXSize = 16,
		TalentDepArrowYSize = 20,
		TalentDepBranchXSize = 8,

		SpecSpellFrameXToBorder = 1,
		SpecSpellFrameYToBorder = 12,
		SpecSpellFrameHeaderYSize = 0,
		SpecSpellFrameFooterYSize = 0,
		SpecSpellFrameSeqWidth = 4,
		SpecSpellNodeXSize = 120,
		SpecSpellNodeYSize = 36,
		SpecSpellNodeXGap = 12,
		SpecSpellNodeYGap = 12,
		SpecSpellNodeXToBorder = 12,
		SpecSpellNodeYToTop = 0,
		SpecSpellNodeYToBottom = 0,
		SpecSpellNodeNameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		SpecSpellNodeNameFontSize = 16,
		SpecSpellNodeNameFontOutline = "OUTLINE",
		SpecSpellNodeNumberFont = NumberFont_Shadow_Med:GetFont(),--=[[Fonts\ARHei.ttf]]--[[Fonts\FRIZQT__.TTF]],
		SpecSpellNodeNumberFontSize = 16,
		SpecSpellNodeNumberFontOutline = "OUTLINE",

		SpellListFrameXSize = 200,
		SpellListFrameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		SpellListFrameFontSize = 14,
		SpellListFrameFontOutline = "OUTLINE",
		SpellListFrameXToBorder = 2,
		SpellListFrameYToTop = 20,
		SpellListFrameYToBottom = 24,
		SpellListNodeHeight = 24,
		SpellListNodeIconTexCoord = { 0.05, 0.95, 0.05, 0.95, },
		SpellListSearchEditYSize = 16,
		SpellListSearchEditOkayXSize = 32,

		EquipmentFrameXSize = CT.TOCVERSION < 20000 and 280 or 340,
		EquipmentFrameXMaxSize = CT.TOCVERSION < 20000 and 640 or 765,
		EquipmentNodeSize = CT.TOCVERSION < 20000 and 36 or (CT.TOCVERSION < 50000 and 38 or 42),
		EquipmentNodeGap = CT.TOCVERSION < 20000 and 4 or (CT.TOCVERSION < 50000 and 6 or 8),
		EquipmentNodeXToBorder = 8,
		EquipmentNodeYToBorder = 8,
		EquipmentNodeTextGap = 4,
		EquipmentNodeLayout = {
			L = {  1,  2,  3, 15,  5, 19,  4,  9, },
			R = { 10,  6,  7,  8, 11, 12, 13, 14, },
			B = { 16, 17, },
			H = { 18,  0, },
		},
		EngravingNodeSize = 16;

		GlyphFrameSize = 200,
		PrimeGlyphNodeSize = 62,
		MajorGlyphNodeSize = 48,
		MinorGlyphNodeSize = 36,

		ControlButtonSize = 18,
		SideButtonSize = 23,
		SideButtonGap = 2,
		EditBoxXSize = 240,
		EditBoxYSize = 24,
		CurClassIndicatorSize = 34,

		TreeButtonsBarYSize = 24,
		TreeButtonXSize = 90,
		TreeButtonYSize = 22,
		TreeButtonGap = 8,
		TreeButtonsFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		TreeButtonsFontSize = 16,
		TreeButtonsFontOutline = "OUTLINE",


		IconTextDisabledColor = { 1.0, 1.0, 1.0, 1.0, },
		IconTextAvailableColor = { 0.0, 1.0, 0.0, 1.0, },
		IconTextMaxRankColor = { 1.0, 1.0, 0.0, 1.0, },
		IconToolTipCurRankColor = { 0.0, 1.0, 0.0, 1.0, },
		IconToolTipNextRankColor = { 0.0, 0.5, 1.0, 1.0, },
		IconToolTipNextRankDisabledColor = { 1.0, 0.0, 0.0, 1.0, },
		IconToolTipMaxRankColor = { 1.0, 0.5, 0.0, 1.0, },

	};
	CT.TTEXTURESET = {
		LIBDBICON = CT.TEXTUREICON,
		UNK = CT.TEXTUREUNK,
		SQUARE_HIGHLIGHT = CT.TEXTUREPATH .. [[CheckButtonHighlight]],
		NORMAL_HIGHLIGHT = CT.TEXTUREPATH .. [[UI-Panel-MinimizeButton-Highlight]],

		SEP_HORIZONTAL = {
			Path = CT.TEXTUREPATH .. [[UI-ChatFrame-BorderLeft]],
			Coord = { 0.25, 0.3125, 0.0, 1.0, },
		},
		SEP_VERTICAL = {
			Path = CT.TEXTUREPATH .. [[UI-ChatFrame-BorderTop]],
			Coord = { 0.0, 1.0, 0.25, 0.3125, },
		},

		CONTROL = {
			NORMAL_COLOR = { 0.75, 0.75, 0.75, 1.0, },
			PUSHED_COLOR = { 0.25, 0.25, 0.25, 1.0, },
			DISABLED_COLOR = { 0.25, 0.25, 0.25, 1.0, },
			HIGHLIGHT_COLOR = { 0.25, 0.25, 0.5, 1.0, },
			CHECKED_COLOR = { 0.75, 0.75, 0.75, 1.0, },
			CHECKEDDISABLED_COLOR = { 0.25, 0.25, 0.25, 1.0, },
		},

		CHECK = {
			Normal = {
				Path = CT.TEXTUREPATH .. [[CheckButtonBorder]],
			},
			Pushed = {
				Path = CT.TEXTUREPATH .. [[CheckButtonBorder]],
			},
			Highlight = {
				Path = CT.TEXTUREPATH .. [[CheckButtonBorder]],
			},
			Disabled = {
				Path = CT.TEXTUREPATH .. [[CheckButtonBorder]],
			},
			Checked = {
				Path = CT.TEXTUREPATH .. [[CheckButtonCenter]],
			},
			CheckedDisabled = {
				Path = CT.TEXTUREPATH .. [[CheckButtonCenter]],
			},
		},

		ARROW = CT.TEXTUREPATH .. [[UI-TalentArrows]],
		ARROW_COORD = {
			[1] = {  8 / 64, 24 / 64, 40 / 64, 56 / 64, },	--vertical disable
			[2] = {  8 / 64, 24 / 64, 08 / 64, 26 / 64, },	--vertical enable
			[3] = { 40 / 64, 56 / 64, 40 / 64, 56 / 64, },	--horizontal disable
			[4] = { 40 / 64, 56 / 64,  8 / 64, 24 / 64, },	--horizontal enable
		},
		BRANCH = CT.TEXTUREPATH .. [[UI-TalentBranches]],
		BRANCH_COORD = {
			[1] = { 44 / 256, 54 / 256, 0.5, 1.0, },		--vertical disable
			[2] = { 44 / 256, 54 / 256, 0.0, 0.5, },		--vertical enable
			[3] = { 66 / 256, 98 / 256, 43 / 64, 53 / 64, },--horizontal disable
			[4] = { 66 / 256, 98 / 256, 11 / 64, 21 / 64, },--horizontal enable
			[5] = { 143 / 256, 153 / 256, 43 / 64, 53 / 64, },
			[6] = { 143 / 256, 153 / 256, 11 / 64, 21 / 64, },
		},

		ICON_LIGHT_COLOR = { 1.0, 1.0, 1.0, 1.0, },
		ICON_UNLIGHT_COLOR = { 0.250, 0.250, 0.250, 1.0, },
		ICON_HIGHLIGHT = {
			Coord = { 0.08, 0.92, 0.08, 0.92, },
			Color = { 0.0, 1.0, 1.0, },
			Blend = "ADD",
		},

		RESETTREE = {
			Backgroud = {
				Path = CT.TEXTUREPATH .. [[Arcane_Circular_Frame]],
				Coord = { 12 / 128, 118 / 128, 12 / 128, 118 / 128, },
				Color = { 0.25, 0.25, 0.25, },
			},
			Highlight = {
				Path = CT.TEXTUREPATH .. [[Arcane_Circular_Flash]],
				Coord = { 12 / 128, 118 / 128, 12 / 128, 118 / 128, },
			},
		},

		CLOSE = {
			Path = CT.TEXTUREPATH .. [[Close]],
		},
		RESETTOEMU = {
			Path = CT.TEXTUREPATH .. [[Close]],
		},
		RESETTOSET = {
			Path = CT.TEXTUREPATH .. [[Reset]],
		},
		EXPAND = {
			Path = CT.TEXTUREPATH .. [[Expand]],
		},
		SHRINK = {
			Path = CT.TEXTUREPATH .. [[Shrink]],
		},
		DROP = {
			Path = CT.TEXTUREPATH .. [[ArrowDown]],
		},
		RESETALL = {
			Path = CT.TEXTUREPATH .. [[Reset]],
		},

		TREEBUTTON = {
			Normal = {
				Path = CT.TEXTUREUNK,
				Coord = { 0.05, 0.95, 0.40, 0.70, },
				Color = { 1.0, 1.0, 1.0, 0.5 },
			},
			Pushed = {
				Path = CT.TEXTUREUNK,
				Coord = { 0.05, 0.95, 0.40, 0.70, },
				Color = { 1.0, 1.0, 1.0, 0.25 },
			},
			Highlight = {
				-- Path = CT.TEXTUREUNK,
				Coord = { 0.05, 0.95, 0.40, 0.70, },
				Color = { 1.0, 1.0, 1.0, 0.15 },
			},
			Indicator = {
				Coord = { 0.10, 0.90, 0.08, 0.92, },
				Color = { 0.0, 1.0, 1.0, },
			},
		},

		SPELLTAB = {
			Path = CT.TEXTUREPATH .. [[SpellList]],
		},
		APPLY = {
			Path = CT.TEXTUREPATH .. [[Apply]],
		},
		SETTING = {
			Path = CT.TEXTUREPATH .. [[Config]],
		},
		IMPORT = {
			Path = CT.TEXTUREPATH .. [[Import]],
		},
		EXPORT = {
			Path = CT.TEXTUREPATH .. [[Export]],
		},
		SAVE = {
			Path = CT.TEXTUREPATH .. [[Save]],
		},
		SEND = {
			Path = CT.TEXTUREPATH .. [[Send]],
		},
		EDIT_OKAY = {
			Path = CT.TEXTUREPATH .. [[Apply]],
		},

		CLASS = {
			Normal = {
				Path = CT.TEXTUREPATH .. [[UI-Classes-Circles]],
			},
			Pushed = {
				Path = CT.TEXTUREPATH .. [[UI-Classes-Circles]],
			},
			Highlight = {
				Path = CT.TEXTUREPATH .. [[UI-Calendar-Button-Glow]],
				Coord = { 6 / 64, 57 / 64, 6 / 64, 57 / 64, },
				Color = { 0.0, 1.0, 0.0, 1.0, },
			},
			Indicator = {
				Path = CT.TEXTUREPATH .. [[EventNotificationGlow]],
				Coord = { 4 / 64, 60 / 64, 5 / 64, 61 / 64, },
				Color = { 0.0, 1.0, 0.0, 1.0, },
			},
		},

		EQUIPMENTTOGGLE = {
			Path = CT.TEXTUREPATH .. [[Equipment]],
		},
		EQUIPMENT = {
			Glow = {
				Path = [[Interface\Buttons\UI-ActionButton-Border]],
				Coord = { 0.25, 0.75, 0.25, 0.75, },
			},
			Highlight = {
				Path = [[Interface\Buttons\ActionbarFlyoutButton-FlyoutMidLeft]],
				Coord = { 8 / 32, 24 / 32, 8 / 64, 24 / 64, },
			},
			Empty = {
				[0] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Ammo]],
				[1] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Head]],
				[2] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Neck]],
				[3] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Shoulder]],
				[4] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Shirt]],
				[5] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Chest]],
				[6] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Waist]],
				[7] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Legs]],
				[8] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Feet]],
				[9] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Wrists]],
				[10] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Hands]],
				[11] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Finger]],
				[12] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Rfinger]],
				[13] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Trinket]],
				[14] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Trinket]],
				[15] = [[Interface\Paperdoll\UI-Backpack-EmptySlot]],
				[16] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Mainhand]],
				[17] = [[Interface\Paperdoll\UI-PaperDoll-Slot-SecondaryHand]],
				[18] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Ranged]],
				[19] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Tabard]],
			},
		},
		ENGRAVING = {
			Normal = {
				Path = CT.TEXTUREUNK,
			},
			Highlight = {
				Path = [[Interface\Buttons\ActionbarFlyoutButton-FlyoutMidLeft]],
				Coord = { 8 / 32, 24 / 32, 8 / 64, 24 / 64, },
			},
		},
	};

-->

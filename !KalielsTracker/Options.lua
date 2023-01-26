--- Kaliel's Tracker
--- Copyright (c) 2012-2023, Marouan Sabbagh <mar.sabbagh@gmail.com>
--- All Rights Reserved.
---
--- This file is part of addon Kaliel's Tracker.

local addonName, KT = ...
KT.forcedUpdate = false

local ACD = LibStub("MSA-AceConfigDialog-3.0")
local ACR = LibStub("AceConfigRegistry-3.0")
local LSM = LibStub("LibSharedMedia-3.0")
local WidgetLists = AceGUIWidgetLSMlists
local _DBG = function(...) if _DBG then _DBG("KT", ...) end end

-- Lua API
local floor = math.floor
local fmod = math.fmod
local format = string.format
local ipairs = ipairs
local pairs = pairs
local strlen = string.len
local strsub = string.sub

local db, dbChar
local mediaPath = "Interface\\AddOns\\"..addonName.."\\Media\\"
local anchors = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT" }
local strata = { "LOW", "MEDIUM", "HIGH" }
local flags = { [""] = "None", ["OUTLINE"] = "Outline", ["OUTLINE, MONOCHROME"] = "Outline Monochrome" }
local textures = { "None", "Default (Blizzard)", "One line", "Two lines" }
local modifiers = { [""] = "None", ["ALT"] = "Alt", ["CTRL"] = "Ctrl", ["ALT-CTRL"] = "Alt + Ctrl" }

local cTitle = " "..NORMAL_FONT_COLOR_CODE
local cBold = "|cff00ffe3"
local cWarning = "|cffff7f00"
local beta = "|cffff7fff[Beta]|r"
local warning = cWarning.."Warning:|r UI will be re-loaded!"

local KTF = KT.frame
local OTF = ObjectiveTrackerFrame

local overlay
local overlayShown = false

local _, numQuests = GetNumQuestLogEntries()

local OverlayFrameUpdate, OverlayFrameHide, GetModulesOptionsTable, MoveModule, SetSharedColor, IsSpecialLocale	-- functions

local defaults = {
	profile = {
		anchorPoint = "TOPRIGHT",
		xOffset = -85,
		yOffset = -200,
		maxHeight = 400,
		frameScrollbar = true,
		frameStrata = "LOW",
		
		bgr = "Solid",
		bgrColor = { r = 0, g = 0, b = 0, a = 0.7 },
		border = "None",
		borderColor = { r = 1, g = 0.82, b = 0 },
		classBorder = false,
		borderAlpha = 1,
		borderThickness = 16,
		bgrInset = 4,
		progressBar = "Blizzard",

		font = LSM:GetDefault("font"),
		fontSize = 12,
		fontFlag = "",
		fontShadow = 1,
		colorDifficulty = false,
		textWordWrap = false,

		headerBgr = 2,
		headerBgrColor = { r = 1, g = 0.82, b = 0 },
		headerBgrColorShare = false,
		headerTxtColor = { r = 1, g = 0.82, b = 0 },
		headerTxtColorShare = false,
		headerBtnColor = { r = 1, g = 0.82, b = 0 },
		headerBtnColorShare = false,
		headerCollapsedTxt = 3,
		headerOtherButtons = true,
		keyBindMinimize = "",
		
		qiBgrBorder = false,
		qiXOffset = -5,

		hideEmptyTracker = false,
		collapseInInstance = false,
		expandTrackerAfterTrack = true,
		menuWowheadURL = true,
        menuWowheadURLModifier = "ALT",

		messageQuest = true,
		messageAchievement = true,
		sink20OutputSink = "UIErrorsFrame",
		sink20Sticky = false,
		soundQuest = true,
		soundQuestComplete = "KT - Default",

		questsHeaderTitleAppend = true,
		questsShowLevels = true,
		questsShowTags = true,
		questsShowZones = true,
		questsObjectiveNumSwitch = true,

		achievementsHeaderTitleAppend = true,

		tooltipShow = true,
		tooltipShowRewards = true,
		tooltipShowID = true,

		modulesOrder = KT.BLIZZARD_MODULES,

		addonQuestie = false,
	},
	char = {
		collapsed = false,
		trackedQuests = {},
	}
}

local options = {
	name = "|T"..mediaPath.."KT_logo:22:22:-1:7|t"..KT.title,
	type = "group",
	get = function(info) return db[info[#info]] end,
	args = {
		general = {
			name = "Options",
			type = "group",
			args = {
				sec0 = {
					name = "Info",
					type = "group",
					inline = true,
					order = 0,
					args = {
						version = {
							name = " |cffffd100Version:|r  "..KT.version,
							type = "description",
							width = "normal",
							fontSize = "medium",
							order = 0.11,
						},
						build = {
							name = " |cffffd100Build:|r  WotLK Classic",
							type = "description",
							width = "normal",
							fontSize = "medium",
							order = 0.12,
						},
						slashCmd = {
							name = cBold.." /kt|r  |cff808080...............|r  Toggle (expand/collapse) the tracker\n"..
									cBold.." /kt config|r  |cff808080...|r  Show this config window\n",
							type = "description",
							width = "double",
							order = 0.3,
						},
						news = {
							name = "What's New",
							type = "execute",
							disabled = function()
								return not KT.Help:IsEnabled()
							end,
							func = function()
								KT.Help:ShowHelp(true)
							end,
							order = 0.2,
						},
						help = {
							name = "Help",
							type = "execute",
							disabled = function()
								return not KT.Help:IsEnabled()
							end,
							func = function()
								KT.Help:ShowHelp()
							end,
							order = 0.4,
						},
						supportersSpacer = {
							name = " ",
							type = "description",
							width = "normal",
							order = 0.51,
						},
						supportersLabel = {
							name = "                |cff00ff00Become a Patron",
							type = "description",
							width = "normal",
							fontSize = "medium",
							order = 0.52,
						},
						supporters = {
							name = "Supporters",
							type = "execute",
							disabled = function()
								return not KT.Help:IsEnabled()
							end,
							func = function()
								KT.Help:ShowSupporters()
							end,
							order = 0.53,
						},
					},
				},
				sec1 = {
					name = "Position / Size",
					type = "group",
					inline = true,
					order = 1,
					args = {
						anchorPoint = {
							name = "Anchor point",
							desc = "- Default: "..defaults.profile.anchorPoint,
							type = "select",
							values = anchors,
							get = function()
								for k, v in ipairs(anchors) do
									if db.anchorPoint == v then
										return k
									end
								end
							end,
							set = function(_, value)
								db.anchorPoint = anchors[value]
								db.xOffset = 0
								db.yOffset = 0
								KT:MoveTracker()
								OverlayFrameUpdate()
							end,
							order = 1.1,
						},
						xOffset = {
							name = "X offset",
							desc = "- Default: "..defaults.profile.xOffset.."\n- Step: 1",
							type = "range",
							min = 0,
							max = 0,
							step = 1,
							set = function(_, value)
								db.xOffset = value
								KT:MoveTracker()
							end,
							order = 1.2,
						},
						yOffset = {
							name = "Y offset",
							desc = "- Default: "..defaults.profile.yOffset.."\n- Step: 2",
							type = "range",
							min = 0,
							max = 0,
							step = 2,
							set = function(_, value)
								db.yOffset = value
								KT:MoveTracker()
								KT:SetSize()
								OverlayFrameUpdate()
							end,
							order = 1.3,
						},
						maxHeight = {
							name = "Max. height",
							desc = "- Default: "..defaults.profile.maxHeight.."\n- Step: 2",
							type = "range",
							min = 100,
							max = 100,
							step = 2,
							set = function(_, value)
								db.maxHeight = value
								KT:SetSize()
								OverlayFrameUpdate()
							end,
							order = 1.4,
						},
						maxHeightShowOverlay = {
							name = "Show Max. height overlay",
							desc = "Show overlay, for better visualisation Max. height value.",
							type = "toggle",
							width = 1.3,
							get = function()
								return overlayShown
							end,
							set = function()
								overlayShown = not overlayShown
								if overlayShown and not overlay then
									overlay = CreateFrame("Frame", KTF:GetName().."Overlay", KTF)
									overlay:SetFrameLevel(KTF:GetFrameLevel() + 11)
									overlay.texture = overlay:CreateTexture(nil, "BACKGROUND")
									overlay.texture:SetAllPoints()
									overlay.texture:SetColorTexture(0, 1, 0, 0.3)
									OverlayFrameUpdate()
								end
								overlay:SetShown(overlayShown)
							end,
							order = 1.5,
						},
						maxHeightNote = {
							name = cBold.."\n Max. height is related with value Y offset.\n"..
								" Content is lesser ... tracker height is automatically increases.\n"..
								" Content is greater ... tracker enables scrolling.",
							type = "description",
							order = 1.6,
						},
						frameScrollbar = {
							name = "Show scroll indicator",
							desc = "Show scroll indicator when srolling is enabled. Color is shared with border.",
							type = "toggle",
							set = function()
								db.frameScrollbar = not db.frameScrollbar
								KTF.Bar:SetShown(db.frameScrollbar)
								KT:SetSize()
							end,
							order = 1.7,
						},
						frameStrata = {
							name = "Strata",
							desc = "- Default: "..defaults.profile.frameStrata,
							type = "select",
							values = strata,
							get = function()
								for k, v in ipairs(strata) do
									if db.frameStrata == v then
										return k
									end
								end
							end,
							set = function(_, value)
								db.frameStrata = strata[value]
								KTF:SetFrameStrata(strata[value])
								KTF.Buttons:SetFrameStrata(strata[value])
							end,
							order = 1.8,
						},
					},
				},
				sec2 = {
					name = "Background / Border",
					type = "group",
					inline = true,
					order = 2,
					args = {
						bgr = {
							name = "Background texture",
							type = "select",
							dialogControl = "LSM30_Background",
							values = WidgetLists.background,
							set = function(_, value)
								db.bgr = value
								KT:SetBackground()
							end,
							order = 2.1,
						},
						bgrColor = {
							name = "Background color",
							type = "color",
							hasAlpha = true,
							get = function()
								return db.bgrColor.r, db.bgrColor.g, db.bgrColor.b, db.bgrColor.a
							end,
							set = function(_, r, g, b, a)
								db.bgrColor.r = r
								db.bgrColor.g = g
								db.bgrColor.b = b
								db.bgrColor.a = a
								KT:SetBackground()
							end,
							order = 2.2,
						},
						bgrNote = {
							name = cBold.." For a custom background\n texture set white color.",
							type = "description",
							width = "normal",
							order = 2.21,
						},
						border = {
							name = "Border texture",
							type = "select",
							dialogControl = "LSM30_Border",
							values = WidgetLists.border,
							set = function(_, value)
								db.border = value
								KT:SetBackground()
								KT:MoveButtons()
							end,
							order = 2.3,
						},
						borderColor = {
							name = "Border color",
							type = "color",
							disabled = function()
								return db.classBorder
							end,
							get = function()
								if not db.classBorder then
									SetSharedColor(db.borderColor)
								end
								return db.borderColor.r, db.borderColor.g, db.borderColor.b
							end,
							set = function(_, r, g, b)
								db.borderColor.r = r
								db.borderColor.g = g
								db.borderColor.b = b
								KT:SetBackground()
								KT:SetText()
								SetSharedColor(db.borderColor)
							end,
							order = 2.4,
						},
						classBorder = {
							name = "Border color by |cff%sClass|r",
							type = "toggle",
							get = function(info)
								if db[info[#info]] then
									SetSharedColor(KT.classColor)
								end
								return db[info[#info]]
							end,
							set = function()
								db.classBorder = not db.classBorder
								KT:SetBackground()
								KT:SetText()
							end,
							order = 2.5,
						},
						borderAlpha = {
							name = "Border transparency",
							desc = "- Default: "..defaults.profile.borderAlpha.."\n- Step: 0.05",
							type = "range",
							min = 0.1,
							max = 1,
							step = 0.05,
							set = function(_, value)
								db.borderAlpha = value
								KT:SetBackground()
							end,
							order = 2.6,
						},
						borderThickness = {
							name = "Border thickness",
							desc = "- Default: "..defaults.profile.borderThickness.."\n- Step: 0.5",
							type = "range",
							min = 1,
							max = 24,
							step = 0.5,
							set = function(_, value)
								db.borderThickness = value
								KT:SetBackground()
							end,
							order = 2.7,
						},
						bgrInset = {
							name = "Background inset",
							desc = "- Default: "..defaults.profile.bgrInset.."\n- Step: 0.5",
							type = "range",
							min = 0,
							max = 10,
							step = 0.5,
							set = function(_, value)
								db.bgrInset = value
								KT:SetBackground()
								KT:MoveButtons()
							end,
							order = 2.8,
						},
						progressBar = {
							name = "Progress bar texture",
							type = "select",
							dialogControl = "LSM30_Statusbar",
							values = WidgetLists.statusbar,
							set = function(_, value)
								db.progressBar = value
								KT.forcedUpdate = true
								ObjectiveTracker_Update()
								KT.forcedUpdate = false
							end,
							order = 2.9,
						},
					},
				},
				sec3 = {
					name = "Texts",
					type = "group",
					inline = true,
					order = 3,
					args = {
						font = {
							name = "Font",
							type = "select",
							dialogControl = "LSM30_Font",
							values = WidgetLists.font,
							set = function(_, value)
								db.font = value
								KT.forcedUpdate = true
								KT:SetText()
								ObjectiveTracker_Update()
								KT.forcedUpdate = false
							end,
							order = 3.1,
						},
						fontSize = {
							name = "Font size",
							type = "range",
							min = 8,
							max = 24,
							step = 1,
							set = function(_, value)
								db.fontSize = value
								KT.forcedUpdate = true
								KT:SetText()
								ObjectiveTracker_Update()
								KT.forcedUpdate = false
							end,
							order = 3.2,
						},
						fontFlag = {
							name = "Font flag",
							type = "select",
							values = flags,
							get = function()
								for k, v in pairs(flags) do
									if db.fontFlag == k then
										return k
									end
								end
							end,
							set = function(_, value)
								db.fontFlag = value
								KT.forcedUpdate = true
								KT:SetText()
								ObjectiveTracker_Update()
								KT.forcedUpdate = false
							end,
							order = 3.3,
						},
						fontShadow = {
							name = "Font shadow",
							desc = warning,
							type = "toggle",
							confirm = true,
							confirmText = warning,
							get = function()
								return (db.fontShadow == 1)
							end,
							set = function(_, value)
								db.fontShadow = value and 1 or 0
								ReloadUI()	-- WTF
							end,
							order = 3.4,
						},
						colorDifficulty = {
							name = "Color by difficulty",
							desc = "Quest titles color by difficulty.",
							type = "toggle",
							set = function()
								db.colorDifficulty = not db.colorDifficulty
								ObjectiveTracker_Update()
							end,
							order = 3.5,
						},
						textWordWrap = {
							name = "Wrap long texts",
							desc = "Long texts shows on two lines or on one line with ellipsis (...).",
							type = "toggle",
							set = function()
								db.textWordWrap = not db.textWordWrap
								KT.forcedUpdate = true
								ObjectiveTracker_Update()
								ObjectiveTracker_Update()
								KT.forcedUpdate = false
							end,
							order = 3.6,
						},
					},
				},
				sec4 = {
					name = "Headers",
					type = "group",
					inline = true,
					order = 4,
					args = {
						headerBgrLabel = {
							name = " Texture",
							type = "description",
							width = "half",
							fontSize = "medium",
							order = 4.1,
						},
						headerBgr = {
							name = "",
							type = "select",
							values = textures,
							get = function()
								for k, v in ipairs(textures) do
									if db.headerBgr == k then
										return k
									end
								end
							end,
							set = function(_, value)
								db.headerBgr = value
								KT:SetBackground()
							end,
							order = 4.11,
						},
						headerBgrColor = {
							name = "Color",
							desc = "Sets the color to texture of the header.",
							type = "color",
							width = "half",
							disabled = function()
								return (db.headerBgr < 3 or db.headerBgrColorShare)
							end,
							get = function()
								return db.headerBgrColor.r, db.headerBgrColor.g, db.headerBgrColor.b
							end,
							set = function(_, r, g, b)
								db.headerBgrColor.r = r
								db.headerBgrColor.g = g
								db.headerBgrColor.b = b
								KT:SetBackground()
							end,
							order = 4.12,
						},
						headerBgrColorShare = {
							name = "Use border color",
							desc = "The color of texture is shared with the border color.",
							type = "toggle",
							disabled = function()
								return (db.headerBgr < 3)
							end,
							set = function()
								db.headerBgrColorShare = not db.headerBgrColorShare
								KT:SetBackground()
							end,
							order = 4.13,
						},
						headerTxtLabel = {
							name = " Text",
							type = "description",
							width = "half",
							fontSize = "medium",
							order = 4.2,
						},
						headerTxtColor = {
							name = "Color",
							desc = "Sets the color to header texts.",
							type = "color",
							width = "half",
							disabled = function()
								KT:SetText()
								return (db.headerBgr == 2 or db.headerTxtColorShare)
							end,
							get = function()
								return db.headerTxtColor.r, db.headerTxtColor.g, db.headerTxtColor.b
							end,
							set = function(_, r, g, b)
								db.headerTxtColor.r = r
								db.headerTxtColor.g = g
								db.headerTxtColor.b = b
								KT:SetText()
							end,
							order = 4.21,
						},
						headerTxtColorShare = {
							name = "Use border color",
							desc = "The color of header texts is shared with the border color.",
							type = "toggle",
							disabled = function()
								return (db.headerBgr == 2)
							end,
							set = function()
								db.headerTxtColorShare = not db.headerTxtColorShare
								KT:SetText()
							end,
							order = 4.22,
						},
						headerTxtSpacer = {
							name = " ",
							type = "description",
							width = "normal",
							order = 4.23,
						},
						headerBtnLabel = {
							name = " Buttons",
							type = "description",
							width = "half",
							fontSize = "medium",
							order = 4.3,
						},
						headerBtnColor = {
							name = "Color",
							desc = "Sets the color to all header buttons.",
							type = "color",
							width = "half",
							disabled = function()
								return db.headerBtnColorShare
							end,
							get = function()
								return db.headerBtnColor.r, db.headerBtnColor.g, db.headerBtnColor.b
							end,
							set = function(_, r, g, b)
								db.headerBtnColor.r = r
								db.headerBtnColor.g = g
								db.headerBtnColor.b = b
								KT:SetBackground()
							end,
							order = 4.31,
						},
						headerBtnColorShare = {
							name = "Use border color",
							desc = "The color of all header buttons is shared with the border color.",
							type = "toggle",
							set = function()
								db.headerBtnColorShare = not db.headerBtnColorShare
								KT:SetBackground()
							end,
							order = 4.32,
						},
						headerBtnSpacer = {
							name = " ",
							type = "description",
							width = "normal",
							order = 4.33,
						},
						sec4SpacerMid1 = {
							name = " ",
							type = "description",
							order = 4.34,
						},
						headerCollapsedTxtLabel = {
							name = " Collapsed tracker text",
							type = "description",
							width = "normal",
							fontSize = "medium",
							order = 4.4,
						},
						headerCollapsedTxt1 = {
							name = "None",
							desc = "Reduces the tracker width when minimized.",
							type = "toggle",
							width = "half",
							get = function()
								return (db.headerCollapsedTxt == 1)
							end,
							set = function()
								db.headerCollapsedTxt = 1
								ObjectiveTracker_Update()
							end,
							order = 4.41,
						},
						headerCollapsedTxt2 = {
							name = ("%d/%d"):format(numQuests, MAX_QUESTLOG_QUESTS),
							type = "toggle",
							width = "half",
							get = function()
								return (db.headerCollapsedTxt == 2)
							end,
							set = function()
								db.headerCollapsedTxt = 2
								ObjectiveTracker_Update()
							end,
							order = 4.42,
						},
						headerCollapsedTxt3 = {
							name = ("%d/%d Quests"):format(numQuests, MAX_QUESTLOG_QUESTS),
							type = "toggle",
							get = function()
								return (db.headerCollapsedTxt == 3)
							end,
							set = function()
								db.headerCollapsedTxt = 3
								ObjectiveTracker_Update()
							end,
							order = 4.43,
						},
						headerOtherButtons = {
							name = "Show Quest Log and Achievements buttons",
							type = "toggle",
							width = "double",
							set = function()
								db.headerOtherButtons = not db.headerOtherButtons
								KT:ToggleOtherButtons()
								KT:SetBackground()
								ObjectiveTracker_Update()
							end,
							order = 4.5,
						},
						keyBindMinimize = {
							name = "Key - Minimize button",
							type = "keybinding",
							set = function(_, value)
								SetOverrideBinding(KTF, false, db.keyBindMinimize, nil)
								if value ~= "" then
									local key = GetBindingKey("EXTRAACTIONBUTTON1")
									if key == value then
										SetBinding(key)
										SaveBindings(GetCurrentBindingSet())
									end
									SetOverrideBindingClick(KTF, false, value, KTF.MinimizeButton:GetName())
								end
								db.keyBindMinimize = value
							end,
							order = 4.6,
						},
					},
				},
				sec5 = {
					name = "Quest item buttons",
					type = "group",
					inline = true,
					order = 5,
					args = {
						qiBgrBorder = {
							name = "Show buttons block background and border",
							type = "toggle",
							width = "double",
							set = function()
								db.qiBgrBorder = not db.qiBgrBorder
								KT:SetBackground()
								KT:MoveButtons()
							end,
							order = 5.1,
						},
						qiXOffset = {
							name = "X offset",
							type = "range",
							min = -10,
							max = 10,
							step = 1,
							set = function(_, value)
								db.qiXOffset = value
								KT:MoveButtons()
							end,
							order = 5.2,
						},
						--[[addonMasqueLabel = {
							name = " Skin options - for Quest item buttons or Active button",
							type = "description",
							width = "double",
							fontSize = "medium",
							order = 5.3,
						},
						addonMasqueOptions = {
							name = "Masque",
							type = "execute",
							disabled = function()
								return (not IsAddOnLoaded("Masque") or not db.addonMasque or not KT.AddonOthers:IsEnabled())
							end,
							func = function()
								SlashCmdList["MASQUE"]()
							end,
							order = 5.31,
						},]]
					},
				},
				sec6 = {
					name = "Other options",
					type = "group",
					inline = true,
					order = 6,
					args = {
						trackerTitle = {
							name = cTitle.."Tracker",
							type = "description",
							fontSize = "medium",
							order = 6.1,
						},
						hideEmptyTracker = {
							name = "Hide empty tracker",
							type = "toggle",
							set = function()
								db.hideEmptyTracker = not db.hideEmptyTracker
								KT:ToggleEmptyTracker()
							end,
							order = 6.11,
						},
						collapseInInstance = {
							name = "Collapse in instance",
							desc = "Collapses the tracker when entering an instance. Note: Enabled Auto filtering can expand the tracker.",
							type = "toggle",
							set = function()
								db.collapseInInstance = not db.collapseInInstance
							end,
							order = 6.12,
						},
						expandTrackerAfterTrack = {
							name = "Expand after track",
							desc = "The tracker will expand when it starts watching something new (Quest, Achievement, etc.).",
							type = "toggle",
							set = function()
								db.expandTrackerAfterTrack = not db.expandTrackerAfterTrack
							end,
							order = 6.13,
						},
						menuTitle = {
							name = "\n"..cTitle.."Menu items",
							type = "description",
							fontSize = "medium",
							order = 6.3,
						},
                        menuWowheadURL = {
							name = "Wowhead URL",
							desc = "Show Wowhead URL menu item inside the tracker.",
							type = "toggle",
							set = function()
								db.menuWowheadURL = not db.menuWowheadURL
							end,
							order = 6.31,
						},
                        menuWowheadURLModifier = {
							name = "Wowhead URL click modifier",
							type = "select",
							values = modifiers,
							get = function()
								for k, v in pairs(modifiers) do
									if db.menuWowheadURLModifier == k then
										return k
									end
								end
							end,
							set = function(_, value)
								db.menuWowheadURLModifier = value
							end,
							order = 6.32,
						},
					},
				},
				sec7 = {
					name = "Notification messages",
					type = "group",
					inline = true,
					order = 7,
					args = {
						messageQuest = {
							name = "Quest messages",
							type = "toggle",
							set = function()
								db.messageQuest = not db.messageQuest
							end,
							order = 7.1,
						},
						messageAchievement = {
							name = "Achievement messages",
							width = 1.1,
							type = "toggle",
							set = function()
								db.messageAchievement = not db.messageAchievement
							end,
							order = 7.2,
						},
						-- LibSink
					},
				},
				sec8 = {
					name = "Notification sounds",
					type = "group",
					inline = true,
					order = 8,
					args = {
						soundQuest = {
							name = "Quest sounds",
							type = "toggle",
							set = function()
								db.soundQuest = not db.soundQuest
							end,
							order = 8.1,
						},
						soundQuestComplete = {
							name = "Complete Sound",
							desc = "Addon sounds are prefixed \"KT - \".",
							type = "select",
							width = 1.2,
							disabled = function()
								return not db.soundQuest
							end,
							dialogControl = "LSM30_Sound",
							values = WidgetLists.sound,
							set = function(_, value)
								db.soundQuestComplete = value
							end,
							order = 8.11,
						},
					},
				},
			},
		},
		content = {
			name = "Content",
			type = "group",
			args = {
				sec1 = {
					name = "Quests",
					type = "group",
					inline = true,
					order = 1,
					args = {
						questsHeaderTitleAppend = {
							name = "Show number of Quests",
							desc = "Show number of Quests inside the Quests module header.",
							type = "toggle",
							width = "normal+half",
							set = function()
								db.questsHeaderTitleAppend = not db.questsHeaderTitleAppend
								KT:SetQuestsHeaderText(true)
							end,
							order = 1.1,
						},
						questsAutoTrack = {
							name = "Auto Quest tracking",
							desc = "Quests are automatically watched when accepted. Uses Blizzard's value \"autoQuestWatch\".",
							type = "toggle",
							get = function()
								return (GetCVar("autoQuestWatch") == "1")
							end,
							set = function(_, value)
								InterfaceOptionsDisplayPanelAutoQuestWatch:SetChecked(value)
								InterfaceOptionsDisplayPanelAutoQuestWatch:SetValue(value)
							end,
							order = 1.2,
						},
						questsShowLevels = {
							name = "Show Quest Levels",
							desc = "Show / Hide Quest levels inside the tracker.",
							type = "toggle",
							set = function()
								db.questsShowLevels = not db.questsShowLevels
								ObjectiveTracker_Update()
							end,
							order = 1.3,
						},
						questsShowTags = {
							name = "Show Quest Tags",
							desc = "Show / Hide Quest tags (type, frequency) inside the tracker.",
							type = "toggle",
							set = function()
								db.questsShowTags = not db.questsShowTags
								ObjectiveTracker_Update()
							end,
							order = 1.4,
						},
						questsShowZones = {
							name = "Show Quest Zones",
							desc = "Show / Hide Quest Zones inside the tracker.",
							type = "toggle",
							set = function()
								db.questsShowZones = not db.questsShowZones
								ObjectiveTracker_Update()
							end,
							order = 1.5,
						},
						questsObjectiveNumSwitch = {
							name = "Objective numbers at the beginning of a line",
							desc = "Toggling position of objective numbers, between begin / end of objective line.\n\n"..
									cBold.."- 0/10 Scarlet Zealot slain\n"..
									"- Scarlet Zealot slain: 0/10|r ... Blizzard default",
							descStyle = "inline",
							type = "toggle",
							width = "full",
							set = function()
								db.questsObjectiveNumSwitch = not db.questsObjectiveNumSwitch
								ObjectiveTracker_Update()
							end,
							order = 1.6,
						},
					},
				},
				sec2 = {
					name = "Achievements",
					type = "group",
					inline = true,
					order = 2,
					args = {
						achievementsHeaderTitleAppend = {
							name = "Show Achievement points",
							desc = "Show Achievement points inside the Achievements module header.",
							type = "toggle",
							width = "normal+half",
							set = function()
								db.achievementsHeaderTitleAppend = not db.achievementsHeaderTitleAppend
								KT:SetAchievementsHeaderText(true)
							end,
							order = 2.1,
						},
					},
				},
				sec3 = {
					name = "Tooltips",
					type = "group",
					inline = true,
					order = 3,
					args = {
						tooltipShow = {
							name = "Show tooltips",
							desc = "Show Quest / Achievement tooltips.",
							type = "toggle",
							set = function()
								db.tooltipShow = not db.tooltipShow
							end,
							order = 3.1,
						},
						tooltipShowRewards = {
							name = "Show Rewards",
							desc = "Show Quest Rewards inside tooltips - Artifact Power, Order Resources, Money, Equipment etc.",
							type = "toggle",
							disabled = function()
								return not db.tooltipShow
							end,
							set = function()
								db.tooltipShowRewards = not db.tooltipShowRewards
							end,
							order = 3.2,
						},
						tooltipShowID = {
							name = "Show ID",
							desc = "Show Quest / Achievement ID inside tooltips.",
							type = "toggle",
							disabled = function()
								return not db.tooltipShow
							end,
							set = function()
								db.tooltipShowID = not db.tooltipShowID
							end,
							order = 3.3,
						},
					},
				},
			},
		},
		modules = {
			name = "Modules",
			type = "group",
			args = {
				sec1 = {
					name = "Order of Modules",
					type = "group",
					inline = true,
					order = 1,
				},
			},
		},
		addons = {
			name = "Supported addons",
			type = "group",
			args = {
				desc = {
					name = "|cff00d200Green|r - compatible version - this version was tested and support is inserted.\n"..
							"|cffff0000Red|r - incompatible version - this version wasn't tested, maybe will need some code changes.\n"..
							"Please report all problems.",
					type = "description",
					order = 0,
				},
				sec1 = {
					name = "Addons",
					type = "group",
					inline = true,
					order = 1,
					args = {
						addonQuestie = {
							name = "Questie",
							desc = "Version: %s",
							descStyle = "inline",
							type = "toggle",
							width = 1.05,
							confirm = true,
							confirmText = warning,
							disabled = function()
								return not IsAddOnLoaded("Questie")
							end,
							set = function()
								db.addonQuestie = not db.addonQuestie
								ReloadUI()
							end,
							order = 1.11,
						},
						addonQuestieDesc = {
							name = "Questie support adds:\n"..
									"- context options "..cBold.."Show on Map|r and "..cBold.."Set TomTom Waypoint|r,\n"..
									"- "..cBold.."Quest Item buttons|r for quests with usable items.",
							type = "description",
							width = "double",
							order = 1.12,
						},
					},
				},
				sec2 = {
					name = "User Interfaces",
					type = "group",
					inline = true,
					order = 2,
					args = {
						elvui = {
							name = "ElvUI",
							type = "toggle",
							disabled = true,
							order = 2.1,
						},
						tukui = {
							name = "Tukui",
							type = "toggle",
							disabled = true,
							order = 2.2,
						},
					},
				},
			},
		},
	},
}

local general = options.args.general.args
local content = options.args.content.args
local modules = options.args.modules.args
local addons = options.args.addons.args

function KT:CheckAddOn(addon, version, isUI)
	local name = strsplit("_", addon)
	local ver = isUI and "" or "---"
	local result = false
	local path
	if IsAddOnLoaded(addon) then
		local actualVersion = GetAddOnMetadata(addon, "Version") or "unknown"
		ver = isUI and "  -  " or ""
		ver = (ver.."|cff%s"..actualVersion.."|r"):format(actualVersion == version and "00d200" or "ff0000")
		result = true
	end
	if not isUI then
		path =  addons.sec1.args["addon"..name]
		path.desc = path.desc:format(ver)
	else
		local path =  addons.sec2.args[strlower(name)]
		path.name = path.name..ver
		path.disabled = not result
		path.get = function() return result end
	end
	return result
end

function KT:OpenOptions()
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame.profiles)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame.profiles)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame.general)
end

function KT:InitProfile(event, database, profile)
	ReloadUI()
end

function KT:SetupOptions()
	self.db = LibStub("AceDB-3.0"):New(strsub(addonName, 2).."DB", defaults, true)
	self.options = options
	db = self.db.profile
	dbChar = self.db.char

	general.sec2.args.classBorder.name = general.sec2.args.classBorder.name:format(self.RgbToHex(self.classColor))

	general.sec7.args.messageOutput = self:GetSinkAce3OptionsDataTable()
	general.sec7.args.messageOutput.inline = true
	general.sec7.args.messageOutput.disabled = function() return not (db.messageQuest or db.messageAchievement) end
	self:SetSinkStorage(db)

	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.profiles.confirm = true
	options.args.profiles.args.reset.confirmText = warning
	options.args.profiles.args.new.confirmText = warning
	options.args.profiles.args.choose.confirmText = warning
	options.args.profiles.args.copyfrom.confirmText = warning
	if not options.args.profiles.plugins then
		options.args.profiles.plugins = {}
	end
	options.args.profiles.plugins[addonName] = {
		clearTrackerDataDesc1 = {
			name = "Clear the data (no settings) of the tracked content (Quests, Achievements etc.) for current character.",
			type = "description",
			order = 0.1,
		},
		clearTrackerData = {
			name = "Clear Tracker Data",
			desc = "Clear the data of the tracked content.",
			type = "execute",
			confirm = true,
			confirmText = "Clear Tracker Data - "..cBold..self.playerName,
			func = function()
				self.stopUpdate = true
				dbChar.trackedQuests = {}
				local trackedAchievements = { GetTrackedAchievements() }
				for i = 1, #trackedAchievements do
					RemoveTrackedAchievement(trackedAchievements[i])
				end
				for i = 1, #db.filterAuto do
					db.filterAuto[i] = nil
				end
				self.stopUpdate = false
				ReloadUI()
			end,
			order = 0.2,
		},
		clearTrackerDataDesc2 = {
			name = "Current character: "..cBold..self.playerName,
			type = "description",
			width = "double",
			order = 0.3,
		},
		clearTrackerDataDesc4 = {
			name = "",
			type = "description",
			order = 0.4,
		}
	}

	ACR:RegisterOptionsTable(addonName, options, nil)
	
	self.optionsFrame = {}
	self.optionsFrame.general = ACD:AddToBlizOptions(addonName, self.title, nil, "general")
	self.optionsFrame.content = ACD:AddToBlizOptions(addonName, options.args.content.name, self.title, "content")
	self.optionsFrame.modules = ACD:AddToBlizOptions(addonName, options.args.modules.name, self.title, "modules")
	self.optionsFrame.addons = ACD:AddToBlizOptions(addonName, options.args.addons.name, self.title, "addons")
	self.optionsFrame.profiles = ACD:AddToBlizOptions(addonName, options.args.profiles.name, self.title, "profiles")

	self.db.RegisterCallback(self, "OnProfileChanged", "InitProfile")
	self.db.RegisterCallback(self, "OnProfileCopied", "InitProfile")
	self.db.RegisterCallback(self, "OnProfileReset", "InitProfile")
end

KT.settings = {}
InterfaceOptionsFrame:HookScript("OnHide", function(self)
	for k, v in pairs(KT.settings) do
		if strfind(k, "Save") then
			KT.settings[k] = false
		else
			db[k] = v
		end
	end
	ACR:NotifyChange(addonName)

	OverlayFrameHide()
end)

hooksecurefunc("OptionsList_SelectButton", function(listFrame, button)
	OverlayFrameHide()
end)

function OverlayFrameUpdate()
	if overlay then
		overlay:SetSize(280, db.maxHeight)
		overlay:ClearAllPoints()
		overlay:SetPoint(db.anchorPoint, 0, 0)
	end
end

function OverlayFrameHide()
	if overlayShown then
		overlay:Hide()
		overlayShown = false
	end
end

function GetModulesOptionsTable()
	local numModules = #db.modulesOrder
	local text
	local defaultModule, defaultText
	local args = {
		descCurOrder = {
			name = cTitle.."Current Order",
			type = "description",
			width = "double",
			fontSize = "medium",
			order = 0.1,
		},
		descDefOrder = {
			name = "|T:1:42|t"..cTitle.."Default Order",
			type = "description",
			width = "normal",
			fontSize = "medium",
			order = 0.2,
		},
	}

	for i, module in ipairs(db.modulesOrder) do
		text = _G[module].Header.Text:GetText()

		defaultModule = OTF.MODULES_UI_ORDER[i]
		defaultText = defaultModule.Header.Text:GetText()

		args["pos"..i] = {
			name = " "..text,
			type = "description",
			width = "normal",
			fontSize = "medium",
			order = i,
		}
		args["pos"..i.."up"] = {
			name = (i > 1) and "Up" or " ",
			desc = text,
			type = (i > 1) and "execute" or "description",
			width = "half",
			func = function()
				MoveModule(i, "up")
			end,
			order = i + 0.1,
		}
		args["pos"..i.."down"] = {
			name = (i < numModules) and "Down" or " ",
			desc = text,
			type = (i < numModules) and "execute" or "description",
			width = "half",
			func = function()
				MoveModule(i)
			end,
			order = i + 0.2,
		}
		args["pos"..i.."default"] = {
			name = "|T:1:55|t|cff808080"..defaultText,
			type = "description",
			width = "normal",
			order = i + 0.3,
		}
	end
	return args
end

function MoveModule(idx, direction)
	local text = strsub(modules.sec1.args["pos"..idx].name, 2)
	local tmpIdx = (direction == "up") and idx-1 or idx+1
	local tmpText = strsub(modules.sec1.args["pos"..tmpIdx].name, 2)
	modules.sec1.args["pos"..tmpIdx].name = " "..text
	modules.sec1.args["pos"..tmpIdx.."up"].desc = text
	modules.sec1.args["pos"..tmpIdx.."down"].desc = text
	modules.sec1.args["pos"..idx].name = " "..tmpText
	modules.sec1.args["pos"..idx.."up"].desc = tmpText
	modules.sec1.args["pos"..idx.."down"].desc = tmpText

	local module = tremove(db.modulesOrder, idx)
	tinsert(db.modulesOrder, tmpIdx, module)

	module = tremove(OTF.MODULES_UI_ORDER, idx)
	tinsert(OTF.MODULES_UI_ORDER, tmpIdx, module)
	ObjectiveTracker_Update()
end

function SetSharedColor(color)
	local name = "Use border |cff"..KT.RgbToHex(color).."color|r"
	local sec4 = general.sec4.args
	sec4.headerBgrColorShare.name = name
	sec4.headerTxtColorShare.name = name
	sec4.headerBtnColorShare.name = name
end

function IsSpecialLocale()
	return (KT.locale == "deDE" or
			KT.locale == "esES" or
			KT.locale == "frFR" or
			KT.locale == "ruRU")
end

-- Init
OTF:HookScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" and not KT.initialized then
		modules.sec1.args = GetModulesOptionsTable()
	end
end)
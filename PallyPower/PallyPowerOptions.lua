local L = LibStub("AceLocale-3.0"):GetLocale("PallyPower")

local isPally = select(2, UnitClass("player")) == "PALADIN"

-------------------------------------------------------------------
-- AceConfig
-------------------------------------------------------------------
PallyPower.options = {
	name = "  " .. L["PallyPower Classic"],
	type = "group",
	childGroups = "tab",
	args = {
		settings = {
			order = 1,
			name = _G.SETTINGS,
			desc = L["Change global settings"],
			type = "group",
			cmdHidden = true,
			args = {
				settings_show = {
					order = 1,
					name = L["Main PallyPower Settings"],
					type = "group",
					inline = true,
					args = {
						globally = {
							order = 1,
							name = L["Enable PallyPower"],
							desc = L["[Enable/Disable] PallyPower"],
							type = "toggle",
							width = 1.0,
							get = function(info)
								return PallyPower.opt.enabled
							end,
							set = function(info, val)
								PallyPower.opt.enabled = val
								if PallyPower.opt.enabled then
									PallyPower:OnEnable()
								else
									PallyPower:OnDisable()
								end
							end
						},
						showparty = {
							order = 2,
							name = L["Use in Party"],
							desc = L["[Enable/Disable] PallyPower in Party"],
							type = "toggle",
							width = 1.0,
							disabled = function(info)
								return PallyPower.opt.enabled == false
							end,
							get = function(info)
								return PallyPower.opt.ShowInParty
							end,
							set = function(info, val)
								PallyPower.opt.ShowInParty = val
								PallyPower:UpdateRoster()
							end
						},
						showminimapicon = {
							order = 3,
							name = L["Show Minimap Icon"],
							desc = L["[Show/Hide] Minimap Icon"],
							type = "toggle",
							width = 1.0,
							get = function(info)
								return PallyPower.opt.minimap.show
							end,
							set = function(info, val)
								PallyPower.opt.minimap.show = val
								PallyPowerMinimapIcon_Toggle()
							end
						},
						showsingle = {
							order = 4,
							name = L["Use when Solo"],
							desc = L["[Enable/Disable] PallyPower while Solo"],
							type = "toggle",
							width = 1.0,
							disabled = function(info)
								return PallyPower.opt.enabled == false
							end,
							get = function(info)
								return PallyPower.opt.ShowWhenSolo
							end,
							set = function(info, val)
								PallyPower.opt.ShowWhenSolo = val
								PallyPower:UpdateRoster()
							end
						},
						showtooltips = {
							order = 5,
							name = L["Show Tooltips"],
							desc = L["[Show/Hide] The PallyPower Tooltips"],
							type = "toggle",
							width = 1.0,
							disabled = function(info)
								return PallyPower.opt.enabled == false
							end,
							get = function(info)
								return PallyPower.opt.ShowTooltips
							end,
							set = function(info, val)
								PallyPower.opt.ShowTooltips = val
								PallyPower:UpdateRoster()
							end
						},
						reportchannel = {
							order = 6,
							type = "select",
							name = L["Blessings Report Channel"],
							desc = L["REPORT_CHANNEL_OPTION_TOOLTIP"],
							width = 1.0,
							values = function()
								return PallyPower:ReportChannels()
							end,
							disabled = function(info)
								return PallyPower.opt.enabled == false
							end,
							get = function(info)
								return PallyPower.opt.ReportChannel
							end,
							set = function(info, val)
								PallyPower.opt.ReportChannel = val
							end
						}
					}
				},
				settings_buffs = {
					order = 2,
					name = L["What to buff with PallyPower"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false or not isPally
					end,
					args = {
						smart_buff = {
							order = 1,
							type = "toggle",
							name = L["Smart Buffs"],
							desc = PallyPower.isWrath and L["If you enable this option, you will not be allowed to assign Blessing of Wisdom to Warriors, Rogues, or Death Knights and Blessing of Might to Mages, Warlocks, or Hunters."] or L["If you enable this option, you will not be allowed to assign Blessing of Wisdom to Warriors or Rogues, and Blessing of Might to Mages, Warlocks, or Hunters."],
							width = 1.0,
							get = function(info)
								return PallyPower.opt.SmartBuffs
							end,
							set = function(info, val)
								PallyPower.opt.SmartBuffs = val
								PallyPower:UpdateRoster()
							end
						},
						showpets_buff = {
							order = 2,
							type = "toggle",
							name = L["Show Pets"],
							desc = PallyPower.petsShareBaseClass and L["SHOWPETS_OPTION_TOOLTIP_BCC"] or L["SHOWPETS_OPTION_TOOLTIP_VANILLA"],
							width = 1.0,
							get = function(info)
								return PallyPower.opt.ShowPets
							end,
							set = function(info, val)
								PallyPower.opt.ShowPets = val
								PallyPower:UpdateRoster()
							end
						},
						salvation_incombat = {
							order = 3,
							type = "toggle",
							name = L["Salv in Combat"],
							desc = L["SALVCOMBAT_OPTION_TOOLTIP"],
							width = 1.0,
							get = function(info)
								return PallyPower.opt.SalvInCombat
							end,
							set = function(_, val)
								PallyPower.opt.SalvInCombat = val
								PallyPower:UpdateRoster()
							end,
							hidden = PallyPower.isWrath
						}
					}
				},
				settings_frames = {
					order = 3,
					name = L["Change the way PallyPower looks"],
					type = "group",
					inline = true,
					args = {
						buffscale = {
							order = 1,
							name = L["PallyPower Buttons Scale"],
							desc = L["This allows you to adjust the overall size of the PallyPower Buttons"],
							type = "range",
							width = 1.5,
							min = 0.4,
							max = 1.5,
							step = 0.05,
							disabled = function(info)
								return PallyPower.opt.enabled == false or not isPally
							end,
							get = function(info)
								return PallyPower.opt.buffscale
							end,
							set = function(info, val)
								PallyPower.opt.buffscale = val
								PallyPower:UpdateLayout()
								PallyPower:UpdateRoster()
							end
						},
						padding1 = {
							order = 2,
							name = "",
							type = "description",
							width = .2
						},
						layout = {
							order = 3,
							type = "select",
							width = 1.4,
							name = L["Buff Button | Player Button Layout"],
							desc = L["LAYOUT_TOOLTIP"],
							disabled = function(info)
								return PallyPower.opt.enabled == false or not isPally
							end,
							get = function(info)
								return PallyPower.opt.layout
							end,
							set = function(info, val)
								PallyPower.opt.layout = val
								PallyPower:UpdateLayout()
								PallyPower:UpdateRoster()
							end,
							values = {
								["Layout 1"] = L["Vertical Down | Right"],
								["Layout 2"] = L["Vertical Down | Left"],
								["Layout 3"] = L["Vertical Up | Right"],
								["Layout 4"] = L["Vertical Up | Left"],
								["Layout 5"] = L["Horizontal Right | Down"],
								["Layout 6"] = L["Horizontal Right | Up"],
								["Layout 7"] = L["Horizontal Left | Down"],
								["Layout 8"] = L["Horizontal Left | Up"]
							}
						},
						skin = {
							order = 4,
							name = L["Background Textures"],
							desc = L["Change the Button Background Textures"],
							type = "select",
							width = 1.5,
							dialogControl = "LSM30_Background",
							values = AceGUIWidgetLSMlists.background,
							disabled = function(info)
								return PallyPower.opt.enabled == false or not isPally
							end,
							get = function(info)
								return PallyPower.opt.skin
							end,
							set = function(info, val)
								PallyPower.opt.skin = val
								PallyPower:ApplySkin()
								PallyPower:UpdateRoster()
							end
						},
						padding2 = {
							order = 5,
							name = "",
							type = "description",
							width = .2
						},
						edges = {
							order = 6,
							name = L["Borders"],
							desc = L["Change the Button Borders"],
							type = "select",
							width = 1.4,
							dialogControl = "LSM30_Border",
							values = AceGUIWidgetLSMlists.border,
							disabled = function(info)
								return PallyPower.opt.enabled == false or not isPally
							end,
							get = function(info)
								return PallyPower.opt.border
							end,
							set = function(info, val)
								PallyPower.opt.border = val
								PallyPower:ApplySkin()
								PallyPower:UpdateRoster()
							end
						},
						assignmentsscale = {
							order = 7,
							name = L["Blessing Assignments Scale"],
							desc = L["This allows you to adjust the overall size of the Blessing Assignments Panel"],
							type = "range",
							width = 1.5,
							min = 0.4,
							max = 1.5,
							step = 0.05,
							disabled = function(info)
								return PallyPower.opt.enabled == false or not isPally
							end,
							get = function(info)
								return PallyPower.opt.configscale
							end,
							set = function(info, val)
								PallyPower.opt.configscale = val
								PallyPower:UpdateLayout()
								PallyPower:UpdateRoster()
							end
						},
						padding3 = {
							order = 8,
							name = "",
							type = "description",
							width = .2
						},
						reset = {
							order = 9,
							name = L["Reset Frames"],
							desc = L["Reset all PallyPower frames back to center"],
							type = "execute",
							disabled = function(info)
								return PallyPower.opt.enabled == false
							end,
							func = function()
								PallyPower:Reset()
								PallyPower:UpdateRoster()
							end
						}
					}
				},
				settings_color = {
					order = 4,
					name = L["Change the status colors of the buff buttons"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false or not isPally
					end,
					args = {
						color_good = {
							order = 1,
							name = L["Fully Buffed"],
							type = "color",
							get = function()
								return PallyPower.opt.cBuffGood.r, PallyPower.opt.cBuffGood.g, PallyPower.opt.cBuffGood.b, PallyPower.opt.cBuffGood.t
							end,
							set = function(info, r, g, b, t)
								PallyPower.opt.cBuffGood.r = r
								PallyPower.opt.cBuffGood.g = g
								PallyPower.opt.cBuffGood.b = b
								PallyPower.opt.cBuffGood.t = t
							end,
							hasAlpha = true
						},
						color_partial = {
							order = 2,
							name = L["Partially Buffed"],
							type = "color",
							width = 1.1,
							get = function()
								return PallyPower.opt.cBuffNeedSome.r, PallyPower.opt.cBuffNeedSome.g, PallyPower.opt.cBuffNeedSome.b, PallyPower.opt.cBuffNeedSome.t
							end,
							set = function(info, r, g, b, t)
								PallyPower.opt.cBuffNeedSome.r = r
								PallyPower.opt.cBuffNeedSome.g = g
								PallyPower.opt.cBuffNeedSome.b = b
								PallyPower.opt.cBuffNeedSome.t = t
							end,
							hasAlpha = true
						},
						color_missing = {
							order = 3,
							name = L["None Buffed"],
							type = "color",
							get = function()
								return PallyPower.opt.cBuffNeedAll.r, PallyPower.opt.cBuffNeedAll.g, PallyPower.opt.cBuffNeedAll.b, PallyPower.opt.cBuffNeedAll.t
							end,
							set = function(info, r, g, b, t)
								PallyPower.opt.cBuffNeedAll.r = r
								PallyPower.opt.cBuffNeedAll.g = g
								PallyPower.opt.cBuffNeedAll.b = b
								PallyPower.opt.cBuffNeedAll.t = t
							end,
							hasAlpha = true
						}
					}
				}
			}
		},
		buttons = {
			order = 2,
			name = L["Buttons"],
			desc = L["Change the button settings"],
			type = "group",
			cmdHidden = true,
			disabled = function(info)
				return PallyPower.opt.enabled == false
			end,
			args = {
				aura_button = {
					order = 1,
					name = L["Aura Button"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false or not isPally
					end,
					args = {
						aura_desc = {
							order = 0,
							type = "description",
							name = L["[|cffffd200Enable|r/|cffffd200Disable|r] The Aura Button or select the Aura you want to track."]
						},
						aura_enable = {
							order = 1,
							type = "toggle",
							name = L["Aura Button"],
							desc = L["[Enable/Disable] The Aura Button"],
							width = 1.1,
							get = function(info)
								return PallyPower.opt.auras
							end,
							set = function(info, val)
								PallyPower.opt.auras = val
								PallyPower:RFAssign(PallyPower.opt.auras)
								PallyPower:UpdateRoster()
							end
						},
						aura = {
							order = 2,
							type = "select",
							name = L["Aura Tracker"],
							desc = L["Select the Aura you want to track"],
							get = function(info)
								return PallyPower_AuraAssignments[PallyPower.player]
							end,
							set = function(info, val)
								PallyPower_AuraAssignments[PallyPower.player] = val
							end,
							values = PallyPower.isWrath and {
								[0] = L["None"],
								[1] = PallyPower.Auras[1], -- Devotion Aura
								[2] = PallyPower.Auras[2], -- Retribution Aura
								[3] = PallyPower.Auras[3], -- Concentration Aura
								[4] = PallyPower.Auras[4], -- Shadow Resistance Aura
								[5] = PallyPower.Auras[5], -- Frost Resistance Aura
								[6] = PallyPower.Auras[6], -- Fire Resistance Aura
								[7] = PallyPower.Auras[8] -- Crusader Aura
							} or {
								[0] = L["None"],
								[1] = PallyPower.Auras[1], -- Devotion Aura
								[2] = PallyPower.Auras[2], -- Retribution Aura
								[3] = PallyPower.Auras[3], -- Concentration Aura
								[4] = PallyPower.Auras[4], -- Shadow Resistance Aura
								[5] = PallyPower.Auras[5], -- Frost Resistance Aura
								[6] = PallyPower.Auras[6], -- Fire Resistance Aura
								[7] = PallyPower.Auras[7], -- Sanctity Aura
								[8] = PallyPower.Auras[8] -- Crusader Aura
							}
						}
					}
				},
				seal_button = {
					order = 2,
					name = L["Seal Button"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false or not isPally
					end,
					args = {
						seal_desc = {
							order = 0,
							type = "description",
							name = L["[|cffffd200Enable|r/|cffffd200Disable|r] The Seal Button, Enable/Disable Righteous Fury or select the Seal you want to track."]
						},
						seal_enable = {
							order = 1,
							type = "toggle",
							name = L["Seal Button"],
							desc = L["[Enable/Disable] The Seal Button"],
							width = 1.1,
							get = function(info)
								return PallyPower.opt.rfbuff
							end,
							set = function(info, val)
								PallyPower.opt.rfbuff = val
								if not PallyPower.opt.rfbuff then
									PallyPower.opt.rf = false
								end
								PallyPower:UpdateRoster()
							end
						},
						rfury = {
							order = 2,
							type = "toggle",
							name = L["Righteous Fury"],
							desc = L["[Enable/Disable] Righteous Fury"],
							width = 1.1,
							disabled = function(info)
								return PallyPower.opt.rfbuff == false or PallyPower.opt.enabled == false or not isPally
							end,
							get = function(info)
								return PallyPower.opt.rf
							end,
							set = function(info, val)
								PallyPower.opt.rf = val
								PallyPower:RFAssign(PallyPower.opt.rf)
							end
						},
						seal = {
							order = 3,
							type = "select",
							name = L["Seal Tracker"],
							desc = L["Select the Seal you want to track"],
							width = .9,
							get = function(info)
								return PallyPower.opt.seal
							end,
							set = function(info, val)
								PallyPower.opt.seal = val
								PallyPower:SealAssign(PallyPower.opt.seal)
							end,
							values = PallyPower.isWrath and {
								[0] = L["None"],
								[1] = PallyPower.Seals[1], -- Seal of Justice
								[2] = PallyPower.Seals[2], -- Seal of Light
								[3] = PallyPower.Seals[3], -- Seal of Wisdom
								[4] = PallyPower.Seals[4], -- Seal of Righteousness
								[5] = PallyPower.Seals[5], -- Seal of Command
								[6] = PallyPower.Seals[6], -- Seal of Vengeance (Alliance)
								[7] = PallyPower.Seals[7], -- Seal of Blood (Horde)
								[8] = PallyPower.Seals[8], -- Seal of the Martyr (Alliance)
								[9] = PallyPower.Seals[9] -- Seal of Corruption (Horde)
							} or {
								[0] = L["None"],
								[1] = PallyPower.Seals[1], -- Seal of Justice
								[2] = PallyPower.Seals[2], -- Seal of Light
								[3] = PallyPower.Seals[3], -- Seal of Wisdom
								[4] = PallyPower.Seals[4], -- Seal of Righteousness
								[5] = PallyPower.Seals[5], -- Seal of the Crusader
								[6] = PallyPower.Seals[6], -- Seal of Command
								[7] = PallyPower.Seals[7], -- Seal of Vengeance (Alliance)
								[8] = PallyPower.Seals[8], -- Seal of Blood (Horde)
								[9] = PallyPower.Seals[9], -- Seal of the Martyr (Alliance)
								[10] = PallyPower.Seals[10] -- Seal of Corruption (Horde)
							}
						}
					}
				},
				auto_button = {
					order = 3,
					name = L["Auto Buff Button"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false or not isPally
					end,
					args = {
						auto_desc = {
							order = 0,
							type = "description",
							name = L["[|cffffd200Enable|r/|cffffd200Disable|r] The Auto Buff Button or [|cffffd200Enable|r/|cffffd200Disable|r] Wait for Players."]
						},
						auto_enable = {
							order = 1,
							type = "toggle",
							name = L["Auto Buff Button"],
							desc = L["[Enable/Disable] The Auto Buff Button"],
							width = 1.1,
							get = function(info)
								return PallyPower.opt.autobuff.autobutton
							end,
							set = function(info, val)
								PallyPower.opt.autobuff.autobutton = val
								PallyPower:UpdateRoster()
							end
						},
						auto_wait = {
							order = 2,
							type = "toggle",
							name = L["Wait for Players"],
							desc = L["If this option is enabled then the Auto Buff Button and the Class Buff Button(s) will not auto buff a Greater Blessing if recipient(s) are not within the Paladins range (100yds). This range check excludes AFK, Dead and Offline players."],
							get = function(info)
								return PallyPower.opt.autobuff.waitforpeople
							end,
							set = function(info, val)
								PallyPower.opt.autobuff.waitforpeople = val
								PallyPower:UpdateRoster()
							end
						}
					}
				},
				cp_button = {
					order = 4,
					name = L["Class & Player Buttons"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false or not isPally
					end,
					args = {
						cp_desc = {
							order = 0,
							type = "description",
							name = L["[|cffffd200Enable|r/|cffffd200Disable|r] The Player(s) or Class Buttons."]
						},
						class_enable = {
							order = 1,
							type = "toggle",
							name = L["Class Buttons"],
							desc = L["[Enable/Disable] Class Buttons"],
							width = 1.1,
							get = function(info)
								return PallyPower.opt.display.showClassButtons
							end,
							set = function(info, val)
								PallyPower.opt.display.showClassButtons = val
								PallyPower:UpdateRoster()
							end
						},
						player_enable = {
							order = 2,
							type = "toggle",
							name = L["Player Buttons"],
							desc = L["If this option is disabled then you will no longer see the pop out buttons showing individual players and you will not be able to reapply Normal Blessings while in combat."],
							disabled = function(info)
								return PallyPower.opt.enabled == false or not isPally
							end,
							get = function(info)
								return PallyPower.opt.display.showPlayerButtons
							end,
							set = function(info, val)
								PallyPower.opt.display.showPlayerButtons = val
								PallyPower:UpdateRoster()
							end
						},
						buff_Duration = {
							order = 3,
							type = "toggle",
							name = L["Buff Duration"],
							desc = L["If this option is disabled then Class and Player buttons will ignore buffs' duration, allowing buffs to be reapplied at will. This is especially useful for Protection Paladins when they spam Greater Blessings to generate more threat."],
							disabled = function(info)
								return PallyPower.opt.enabled == false or not isPally
							end,
							get = function(info)
								return PallyPower.opt.display.buffDuration
							end,
							set = function(info, val)
								PallyPower.opt.display.buffDuration = val
								PallyPower:UpdateRoster()
							end
						}
					}
				},
				drag_button = {
					order = 5,
					name = L["Drag Handle Button"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false
					end,
					args = {
						misc_desc = {
							order = 0,
							type = "description",
							name = L["[|cffffd200Enable|r/|cffffd200Disable|r] The Drag Handle Button."]
						},
						drag_enable = {
							order = 1,
							type = "toggle",
							name = L["Drag Handle"],
							desc = L["[Enable/Disable] The Drag Handle"],
							width = 1.1,
							get = function(info)
								return PallyPower.opt.display.enableDragHandle
							end,
							set = function(info, val)
								PallyPower.opt.display.enableDragHandle = val
								PallyPower:UpdateRoster()
							end
						}
					}
				}
			}
		},
		raids = {
			order = 3,
			name = _G.RAID,
			desc = L["Raid only options"],
			type = "group",
			cmdHidden = true,
			disabled = function(info)
				return PallyPower.opt.enabled == false or not isPally
			end,
			args = {
				visibility = {
					order = 1,
					name = L["Visibility Settings"],
					type = "group",
					inline = true,
					args = {
						hide_high = {
							order = 1,
							type = "toggle",
							name = L["Hide Bench (by Subgroup)"],
							desc = L["While you are in a Raid dungeon, hide any players outside of the usual subgroups for that dungeon. For example, if you are in a 10-player dungeon, any players in Group 3 or higher will be hidden."],
							width = "full",
							get = function()
								return PallyPower.opt.hideHighGroups
							end,
							set = function(info, val)
								PallyPower.opt.hideHighGroups = val
								PallyPower:UpdateRoster()
							end
						},
					},
				},
				mainroles = {
					order = 2,
					name = L["Main Tank / Main Assist Roles"],
					type = "group",
					inline = true,
					args = {
						mainroles_desc = {
							order = 0,
							type = "description",
							name = PallyPower.isWrath and L["MAIN_ROLES_DESCRIPTION_WRATH"] or L["MAIN_ROLES_DESCRIPTION"]
						},
						maintank_buff = {
							order = 1,
							type = "toggle",
							name = L["Auto-Buff Main Tank"],
							desc = PallyPower.isWrath and L["If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Tank|r role in the Blizzard Raid Panel. This is useful for spot buffing the |cffffd200Main Tank|r role with Blessing of Sanctuary."] or L["If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Tank|r role in the Blizzard Raid Panel. This is useful to avoid blessing the |cffffd200Main Tank|r role with a Greater Blessing of Salvation."],
							width = "full",
							get = function(info)
								return PallyPower.opt.mainTank
							end,
							set = function(info, val)
								PallyPower.opt.mainTank = val
								PallyPower:UpdateRoster()
							end
						},
						maintank_GBWarriorPDeathKnight = {
							order = 2,
							type = "select",
							name = PallyPower.isWrath and L["Override Warriors / Death Knights..."] or L["Override Warriors..."],
							desc = PallyPower.isWrath and L["Select the Greater Blessing assignment you wish to over-write on Main Tank: Warriors / Death Knights."] or L["Select the Greater Blessing assignment you wish to over-write on Main Tank: Warriors."],
							width = 1.2,
							disabled = function(info)
								return (not (PallyPower.opt.mainTank))
							end,
							get = function(info)
								return PallyPower.opt.mainTankGSpellsW
							end,
							set = function(info, val)
								PallyPower.opt.mainTankGSpellsW = val
								PallyPower:UpdateRoster()
							end,
							values = PallyPower.isWrath and {
								[0] = L["None"],
								[1] = PallyPower.GSpells[1], -- Greater Blessing of Wisdom
								[2] = PallyPower.GSpells[2], -- Greater Blessing of Might
								[3] = PallyPower.GSpells[3], -- Greater Blessing of Kings
								[4] = PallyPower.GSpells[4] -- Greater Blessing of Sanctuary
							} or {
								[0] = L["None"],
								[1] = PallyPower.GSpells[1], -- Greater Blessing of Wisdom
								[2] = PallyPower.GSpells[2], -- Greater Blessing of Might
								[3] = PallyPower.GSpells[3], -- Greater Blessing of Kings
								[4] = PallyPower.GSpells[4], -- Greater Blessing of Salvation
								[5] = PallyPower.GSpells[5], -- Greater Blessing of Light
								[6] = PallyPower.GSpells[6] -- Greater Blessing of Sanctuary
							}
						},
						maintank_NBWarriorPDeathKnight = {
							order = 3,
							type = "select",
							name = L["...with Normal..."],
							desc = PallyPower.isWrath and L["Select the Normal Blessing you wish to use to over-write the Main Tank: Warriors / Death Knights."] or L["Select the Normal Blessing you wish to use to over-write the Main Tank: Warriors."],
							width = 0.9,
							disabled = function(info)
								return (not (PallyPower.opt.mainTank))
							end,
							get = function(info)
								return PallyPower.opt.mainTankSpellsW
							end,
							set = function(info, val)
								PallyPower.opt.mainTankSpellsW = val
								PallyPower:UpdateRoster()
							end,
							values = PallyPower.isWrath and {
								[0] = L["None"],
								[1] = PallyPower.Spells[1], -- Blessing of Wisdom
								[2] = PallyPower.Spells[2], -- Blessing of Might
								[3] = PallyPower.Spells[3], -- Blessing of Kings
								[4] = PallyPower.Spells[4] -- Blessing of Sanctuary
							} or {
								[0] = L["None"],
								[1] = PallyPower.Spells[1], -- Blessing of Wisdom
								[2] = PallyPower.Spells[2], -- Blessing of Might
								[3] = PallyPower.Spells[3], -- Blessing of Kings
								[4] = PallyPower.Spells[4], -- Blessing of Salvation
								[5] = PallyPower.Spells[5], -- Blessing of Light
								[6] = PallyPower.Spells[6], -- Blessing of Sanctuary
								[7] = PallyPower.Spells[7] -- Blessing of Sacrifice
							}
						},
						maintank_GBDruidPPaladin = {
							order = 4,
							type = "select",
							name = L["Override Druids / Paladins..."],
							desc = L["Select the Greater Blessing assignment you wish to over-write on Main Tank: Druids / Paladins."],
							width = 1.2,
							disabled = function(info)
								return (not (PallyPower.opt.mainTank))
							end,
							get = function(info)
								return PallyPower.opt.mainTankGSpellsDP
							end,
							set = function(info, val)
								PallyPower.opt.mainTankGSpellsDP = val
								PallyPower:UpdateRoster()
							end,
							values = PallyPower.isWrath and {
								[0] = L["None"],
								[1] = PallyPower.GSpells[1], -- Greater Blessing of Wisdom
								[2] = PallyPower.GSpells[2], -- Greater Blessing of Might
								[3] = PallyPower.GSpells[3], -- Greater Blessing of Kings
								[4] = PallyPower.GSpells[4] -- Greater Blessing of Sanctuary
							} or {
								[0] = L["None"],
								[1] = PallyPower.GSpells[1], -- Greater Blessing of Wisdom
								[2] = PallyPower.GSpells[2], -- Greater Blessing of Might
								[3] = PallyPower.GSpells[3], -- Greater Blessing of Kings
								[4] = PallyPower.GSpells[4], -- Greater Blessing of Salvation
								[5] = PallyPower.GSpells[5], -- Greater Blessing of Light
								[6] = PallyPower.GSpells[6] -- Greater Blessing of Sanctuary
							}
						},
						maintank_NBDruidPPaladin = {
							order = 5,
							type = "select",
							name = L["...with Normal..."],
							desc = L["Select the Normal Blessing you wish to use to over-write the Main Tank: Druids / Paladins."],
							width = 0.9,
							disabled = function(info)
								return (not (PallyPower.opt.mainTank))
							end,
							get = function(info)
								return PallyPower.opt.mainTankSpellsDP
							end,
							set = function(info, val)
								PallyPower.opt.mainTankSpellsDP = val
								PallyPower:UpdateRoster()
							end,
							values = PallyPower.isWrath and {
								[0] = L["None"],
								[1] = PallyPower.Spells[1], -- Blessing of Wisdom
								[2] = PallyPower.Spells[2], -- Blessing of Might
								[3] = PallyPower.Spells[3], -- Blessing of Kings
								[4] = PallyPower.Spells[4] -- Blessing of Sanctuary
							} or {
								[0] = L["None"],
								[1] = PallyPower.Spells[1], -- Blessing of Wisdom
								[2] = PallyPower.Spells[2], -- Blessing of Might
								[3] = PallyPower.Spells[3], -- Blessing of Kings
								[4] = PallyPower.Spells[4], -- Blessing of Salvation
								[5] = PallyPower.Spells[5], -- Blessing of Light
								[6] = PallyPower.Spells[6], -- Blessing of Sanctuary
								[7] = PallyPower.Spells[7] -- Blessing of Sacrifice
							}
						},
						mainassist_buff = {
							order = 6,
							type = "toggle",
							name = L["Auto-Buff Main Assistant"],
							desc = PallyPower.isWrath and L["If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Assistant|r role in the Blizzard Raid Panel. This is useful for spot buffing the |cffffd200Main Assistant|r role with Blessing of Sanctuary."] or L["If you enable this option PallyPower will automatically over-write a Greater Blessing with a Normal Blessing on players marked with the |cffffd200Main Assistant|r role in the Blizzard Raid Panel. This is useful to avoid blessing the |cffffd200Main Assistant|r role with a Greater Blessing of Salvation."],
							width = "full",
							get = function(info)
								return PallyPower.opt.mainAssist
							end,
							set = function(info, val)
								PallyPower.opt.mainAssist = val
								PallyPower:UpdateRoster()
							end
						},
						mainassist_GBWarriorPDeathKnight = {
							order = 7,
							type = "select",
							name = PallyPower.isWrath and L["Override Warriors / Death Knights..."] or L["Override Warriors..."],
							desc = PallyPower.isWrath and L["Select the Greater Blessing assignment you wish to over-write on Main Assist: Warriors / Death Knights."] or L["Select the Greater Blessing assignment you wish to over-write on Main Assist: Warriors."],
							width = 1.2,
							disabled = function(info)
								return (not (PallyPower.opt.mainAssist))
							end,
							get = function(info)
								return PallyPower.opt.mainAssistGSpellsW
							end,
							set = function(info, val)
								PallyPower.opt.mainAssistGSpellsW = val
								PallyPower:UpdateRoster()
							end,
							values = PallyPower.isWrath and {
								[0] = L["None"],
								[1] = PallyPower.GSpells[1], -- Greater Blessing of Wisdom
								[2] = PallyPower.GSpells[2], -- Greater Blessing of Might
								[3] = PallyPower.GSpells[3], -- Greater Blessing of Kings
								[4] = PallyPower.GSpells[4] -- Greater Blessing of Sanctuary
							} or {
								[0] = L["None"],
								[1] = PallyPower.GSpells[1], -- Greater Blessing of Wisdom
								[2] = PallyPower.GSpells[2], -- Greater Blessing of Might
								[3] = PallyPower.GSpells[3], -- Greater Blessing of Kings
								[4] = PallyPower.GSpells[4], -- Greater Blessing of Salvation
								[5] = PallyPower.GSpells[5], -- Greater Blessing of Light
								[6] = PallyPower.GSpells[6] -- Greater Blessing of Sanctuary
							}
						},
						mainassist_NBWarriorPDeathKnight = {
							order = 8,
							type = "select",
							name = L["...with Normal..."],
							desc = PallyPower.isWrath and L["Select the Normal Blessing you wish to use to over-write the Main Assist: Warriors / Death Knights."] or L["Select the Normal Blessing you wish to use to over-write the Main Assist: Warriors."],
							width = 0.9,
							disabled = function(info)
								return (not (PallyPower.opt.mainAssist))
							end,
							get = function(info)
								return PallyPower.opt.mainAssistSpellsW
							end,
							set = function(info, val)
								PallyPower.opt.mainAssistSpellsW = val
								PallyPower:UpdateRoster()
							end,
							values = PallyPower.isWrath and {
								[0] = L["None"],
								[1] = PallyPower.Spells[1], -- Blessing of Wisdom
								[2] = PallyPower.Spells[2], -- Blessing of Might
								[3] = PallyPower.Spells[3], -- Blessing of Kings
								[4] = PallyPower.Spells[4] -- Blessing of Sanctuary
							} or {
								[0] = L["None"],
								[1] = PallyPower.Spells[1], -- Blessing of Wisdom
								[2] = PallyPower.Spells[2], -- Blessing of Might
								[3] = PallyPower.Spells[3], -- Blessing of Kings
								[4] = PallyPower.Spells[4], -- Blessing of Salvation
								[5] = PallyPower.Spells[5], -- Blessing of Light
								[6] = PallyPower.Spells[6], -- Blessing of Sanctuary
								[7] = PallyPower.Spells[7] -- Blessing of Sacrifice
							}
						},
						mainassist_GBDruidPaladin = {
							order = 9,
							type = "select",
							name = L["Override Druids / Paladins..."],
							desc = L["Select the Greater Blessing assignment you wish to over-write on Main Assist: Druids / Paladins."],
							width = 1.2,
							disabled = function(info)
								return (not (PallyPower.opt.mainAssist))
							end,
							get = function(info)
								return PallyPower.opt.mainAssistGSpellsDP
							end,
							set = function(info, val)
								PallyPower.opt.mainAssistGSpellsDP = val
								PallyPower:UpdateRoster()
							end,
							values = PallyPower.isWrath and {
								[0] = L["None"],
								[1] = PallyPower.GSpells[1], -- Greater Blessing of Wisdom
								[2] = PallyPower.GSpells[2], -- Greater Blessing of Might
								[3] = PallyPower.GSpells[3], -- Greater Blessing of Kings
								[4] = PallyPower.GSpells[4] -- Greater Blessing of Sanctuary
							} or {
								[0] = L["None"],
								[1] = PallyPower.GSpells[1], -- Greater Blessing of Wisdom
								[2] = PallyPower.GSpells[2], -- Greater Blessing of Might
								[3] = PallyPower.GSpells[3], -- Greater Blessing of Kings
								[4] = PallyPower.GSpells[4], -- Greater Blessing of Salvation
								[5] = PallyPower.GSpells[5], -- Greater Blessing of Light
								[6] = PallyPower.GSpells[6] -- Greater Blessing of Sanctuary
							}
						},
						mainassist_NBDruidPaladin = {
							order = 10,
							type = "select",
							name = L["...with Normal..."],
							desc = L["Select the Normal Blessing you wish to use to over-write the Main Assist: Druids / Paladins."],
							width = 0.9,
							disabled = function(info)
								return (not (PallyPower.opt.mainAssist))
							end,
							get = function(info)
								return PallyPower.opt.mainAssistSpellsDP
							end,
							set = function(info, val)
								PallyPower.opt.mainAssistSpellsDP = val
								PallyPower:UpdateRoster()
							end,
							values = PallyPower.isWrath and {
								[0] = L["None"],
								[1] = PallyPower.Spells[1], -- Blessing of Wisdom
								[2] = PallyPower.Spells[2], -- Blessing of Might
								[3] = PallyPower.Spells[3], -- Blessing of Kings
								[4] = PallyPower.Spells[4] -- Blessing of Sanctuary
							} or {
								[0] = L["None"],
								[1] = PallyPower.Spells[1], -- Blessing of Wisdom
								[2] = PallyPower.Spells[2], -- Blessing of Might
								[3] = PallyPower.Spells[3], -- Blessing of Kings
								[4] = PallyPower.Spells[4], -- Blessing of Salvation
								[5] = PallyPower.Spells[5], -- Blessing of Light
								[6] = PallyPower.Spells[6], -- Blessing of Sanctuary
								[7] = PallyPower.Spells[7] -- Blessing of Sacrifice
							}
						}
					}
				}
			}
		},
		blessings = {
			order = 4,
			name = "Blessing Assignements",
			type = "execute",
			guiHidden = true,
			func = function()
				if not (UnitAffectingCombat("player")) then
					PallyPowerBlessings_Toggle()
				end
			end
		},
		options = {
			order = 5,
			name = "PallyPower Options",
			type = "execute",
			guiHidden = true,
			func = function()
				if not (UnitAffectingCombat("player")) then
					PallyPower:OpenConfigWindow()
				end
			end
		}
	}
}

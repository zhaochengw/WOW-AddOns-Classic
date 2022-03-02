local L = LibStub("AceLocale-3.0"):GetLocale("PallyPower")

local isPally = select(2, UnitClass("player")) == "PALADIN"

-------------------------------------------------------------------
-- AceConfig
-------------------------------------------------------------------
PallyPower.options = {
	name = "  " .. L["PP_NAME"],
	type = "group",
	childGroups = "tab",
	args = {
		settings = {
			order = 1,
			name = L["SETTINGS"],
			desc = L["SETTINGS_DESC"],
			type = "group",
			cmdHidden = true,
			args = {
				settings_show = {
					order = 1,
					name = L["PP_MAIN"],
					type = "group",
					inline = true,
					args = {
						globally = {
							order = 1,
							name = L["ENABLEPP"],
							desc = L["ENABLEPP_DESC"],
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
							name = L["USEPARTY"],
							desc = L["USEPARTY_DESC"],
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
							name = L["SHOWMINIMAPICON"],
							desc = L["SHOWMINIMAPICON_DESC"],
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
							name = L["USESOLO"],
							desc = L["USESOLO_DESC"],
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
							name = L["SHOWTIPS"],
							desc = L["SHOWTIPS_DESC"],
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
							name = L["REPORTCHANNEL"],
							desc = L["REPORTCHANNEL_DESC"],
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
					name = L["SETTINGSBUFF"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false or not isPally
					end,
					args = {
						smart_buff = {
							order = 1,
							type = "toggle",
							name = L["SMARTBUFF"],
							desc = L["SMARTBUFF_DESC"],
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
							name = L["SHOWPETS"],
							desc = L["SHOWPETS_DESC"],
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
							name = L["SALVCOMBAT"],
							desc = L["SALVCOMBAT_DESC"],
							width = 1.0,
							get = function(info)
								return PallyPower.opt.SalvInCombat
							end,
							set = function(info, val)
								PallyPower.opt.SalvInCombat = val
								PallyPower:UpdateRoster()
							end
						}
					}
				},
				settings_frames = {
					order = 3,
					name = L["PP_LOOKS"],
					type = "group",
					inline = true,
					args = {
						buffscale = {
							order = 1,
							name = L["BSC"],
							desc = L["BSC_DESC"],
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
							name = L["LAYOUT"],
							desc = L["LAYOUT_DESC"],
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
								["Layout 1"] = L["VERDOWNRIGHT"],
								["Layout 2"] = L["VERDOWNLEFT"],
								["Layout 3"] = L["VERUPRIGHT"],
								["Layout 4"] = L["VERUPLEFT"],
								["Layout 5"] = L["HORRIGHTDOWN"],
								["Layout 6"] = L["HORRIGHTUP"],
								["Layout 7"] = L["HORLEFTDOWN"],
								["Layout 8"] = L["HORLEFTUP"]
							}
						},
						skin = {
							order = 4,
							name = L["SKIN"],
							desc = L["SKIN_DESC"],
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
							name = L["DISPEDGES"],
							desc = L["DISPEDGES_DESC"],
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
							name = L["BAP"],
							desc = L["BAP_DESC"],
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
							name = L["RESET"],
							desc = L["RESET_DESC"],
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
					name = L["PP_COLOR"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false or not isPally
					end,
					args = {
						color_good = {
							order = 1,
							name = L["FULLY_BUFFED"],
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
							name = L["PARTIALLY_BUFFED"],
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
							name = L["NONE_BUFFED"],
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
			name = L["BUTTONS"],
			desc = L["BUTTONS_DESC"],
			type = "group",
			cmdHidden = true,
			disabled = function(info)
				return PallyPower.opt.enabled == false
			end,
			args = {
				aura_button = {
					order = 1,
					name = L["AURA"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false or not isPally
					end,
					args = {
						aura_desc = {
							order = 0,
							type = "description",
							name = L["AURA_DESC"]
						},
						aura_enable = {
							order = 1,
							type = "toggle",
							name = L["AURABTN"],
							desc = L["AURABTN_DESC"],
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
							name = L["AURATRACKER"],
							desc = L["AURATRACKER_DESC"],
							get = function(info)
								return PallyPower_AuraAssignments[PallyPower.player]
							end,
							set = function(info, val)
								PallyPower_AuraAssignments[PallyPower.player] = val
							end,
							values = {
								[0] = L["NONE"],
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
					name = L["SEAL"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false or not isPally
					end,
					args = {
						seal_desc = {
							order = 0,
							type = "description",
							name = L["SEAL_DESC"]
						},
						seal_enable = {
							order = 1,
							type = "toggle",
							name = L["SEALBTN"],
							desc = L["SEALBTN_DESC"],
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
							name = L["RFM"],
							desc = L["RFM_DESC"],
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
							name = L["SEALTRACKER"],
							desc = L["SEALTRACKER_DESC"],
							width = .9,
							get = function(info)
								return PallyPower.opt.seal
							end,
							set = function(info, val)
								PallyPower.opt.seal = val
								PallyPower:SealAssign(PallyPower.opt.seal)
							end,
							values = {
								[0] = L["NONE"],
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
					name = L["AUTO"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false or not isPally
					end,
					args = {
						auto_desc = {
							order = 0,
							type = "description",
							name = L["AUTO_DESC"]
						},
						auto_enable = {
							order = 1,
							type = "toggle",
							name = L["AUTOBTN"],
							desc = L["AUTOBTN_DESC"],
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
							name = L["WAIT"],
							desc = L["WAIT_DESC"],
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
					name = L["CPBTNS"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false or not isPally
					end,
					args = {
						cp_desc = {
							order = 0,
							type = "description",
							name = L["CPBTNS_DESC"]
						},
						class_enable = {
							order = 1,
							type = "toggle",
							name = L["CLASSBTN"],
							desc = L["CLASSBTN_DESC"],
							width = 1.1,
							get = function(info)
								return PallyPower.opt.display.showClassButtons
							end,
							set = function(info, val)
								PallyPower.opt.display.showClassButtons = val
								if not PallyPower.opt.display.showClassButtons then
									PallyPower.opt.display.showPlayerButtons = false
									PallyPower.opt.display.buffDuration = false
								end
								PallyPower:UpdateRoster()
							end
						},
						player_enable = {
							order = 2,
							type = "toggle",
							name = L["PLAYERBTNS"],
							desc = L["PLAYERBTNS_DESC"],
							disabled = function(info)
								return PallyPower.opt.display.showClassButtons == false or PallyPower.opt.enabled == false or not isPally
							end,
							get = function(info)
								return PallyPower.opt.display.showPlayerButtons
							end,
							set = function(info, val)
								PallyPower.opt.display.showPlayerButtons = val
								if not PallyPower.opt.display.showClassButtons then
									PallyPower.opt.display.showPlayerButtons = false
								end
								PallyPower:UpdateRoster()
							end
						},
						buff_Duration = {
							order = 3,
							type = "toggle",
							name = L["BUFFDURATION"],
							desc = L["BUFFDURATION_DESC"],
							disabled = function(info)
								return PallyPower.opt.display.showClassButtons == false or PallyPower.opt.enabled == false or not isPally
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
					name = L["DRAG"],
					type = "group",
					inline = true,
					disabled = function(info)
						return PallyPower.opt.enabled == false
					end,
					args = {
						misc_desc = {
							order = 0,
							type = "description",
							name = L["DRAG_DESC"]
						},
						drag_enable = {
							order = 1,
							type = "toggle",
							name = L["DRAGHANDLE_ENABLED"],
							desc = L["DRAGHANDLE_ENABLED_DESC"],
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
			name = L["RAID"],
			desc = L["RAID_DESC"],
			type = "group",
			cmdHidden = true,
			disabled = function(info)
				return PallyPower.opt.enabled == false or not isPally
			end,
			args = {
				mainroles = {
					order = 1,
					name = L["MAINROLES"],
					type = "group",
					inline = true,
					args = {
						mainroles_desc = {
							order = 0,
							type = "description",
							name = L["MAINROLES_DESC"]
						},
						maintank_buff = {
							order = 1,
							type = "toggle",
							name = L["PPMAINTANK"],
							desc = L["PPMAINTANK_DESC"],
							width = "full",
							get = function(info)
								return PallyPower.opt.mainTank
							end,
							set = function(info, val)
								PallyPower.opt.mainTank = val
								PallyPower:UpdateRoster()
							end
						},
						maintank_GBWarrior = {
							order = 2,
							type = "select",
							name = L["MAINTANKGBUFFW"],
							desc = L["MAINTANKGBUFFW_DESC"],
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
							values = {
								[0] = L["NONE"],
								[1] = PallyPower.GSpells[1], -- Greater Blessing of Wisdom
								[2] = PallyPower.GSpells[2], -- Greater Blessing of Might
								[3] = PallyPower.GSpells[3], -- Greater Blessing of Kings
								[4] = PallyPower.GSpells[4], -- Greater Blessing of Salvation
								[5] = PallyPower.GSpells[5], -- Greater Blessing of Light
								[6] = PallyPower.GSpells[6] -- Greater Blessing of Sanctuary
							}
						},
						maintank_NBWarrior = {
							order = 3,
							type = "select",
							name = L["MAINTANKNBUFFW"],
							desc = L["MAINTANKNBUFFW_DESC"],
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
							values = {
								[0] = L["NONE"],
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
							name = L["MAINTANKGBUFFDP"],
							desc = L["MAINTANKGBUFFDP_DESC"],
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
							values = {
								[0] = L["NONE"],
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
							name = L["MAINTANKNBUFFDP"],
							desc = L["MAINTANKNBUFFDP_DESC"],
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
							values = {
								[0] = L["NONE"],
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
							name = L["MAINASSISTANT"],
							desc = L["MAINASSISTANT_DESC"],
							width = "full",
							get = function(info)
								return PallyPower.opt.mainAssist
							end,
							set = function(info, val)
								PallyPower.opt.mainAssist = val
								PallyPower:UpdateRoster()
							end
						},
						mainassist_GBWarrior = {
							order = 7,
							type = "select",
							name = L["MAINASSISTANTGBUFFW"],
							desc = L["MAINASSISTANTGBUFFW_DESC"],
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
							values = {
								[0] = L["NONE"],
								[1] = PallyPower.GSpells[1], -- Greater Blessing of Wisdom
								[2] = PallyPower.GSpells[2], -- Greater Blessing of Might
								[3] = PallyPower.GSpells[3], -- Greater Blessing of Kings
								[4] = PallyPower.GSpells[4], -- Greater Blessing of Salvation
								[5] = PallyPower.GSpells[5], -- Greater Blessing of Light
								[6] = PallyPower.GSpells[6] -- Greater Blessing of Sanctuary
							}
						},
						mainassist_NBWarrior = {
							order = 8,
							type = "select",
							name = L["MAINASSISTANTNBUFFW"],
							desc = L["MAINASSISTANTNBUFFW_DESC"],
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
							values = {
								[0] = L["NONE"],
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
							name = L["MAINASSISTANTGBUFFDP"],
							desc = L["MAINASSISTANTGBUFFDP_DESC"],
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
							values = {
								[0] = L["NONE"],
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
							name = L["MAINASSISTANTNBUFFDP"],
							desc = L["MAINASSISTANTNBUFFDP_DESC"],
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
							values = {
								[0] = L["NONE"],
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

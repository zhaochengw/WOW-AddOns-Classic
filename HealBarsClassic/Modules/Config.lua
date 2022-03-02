--[[
	Function: CreateConfigs
	Purpose: Create and attach options page
	Notes: 
		For convenience, order is incremented in steps of two so new options can be squeezed between them.
]]--
function HealBarsClassic:CreateConfigs()

	HBCdb = HealBarsClassic.HBCdb
	local options = {
		name = 'HealBarsClassic-3.1.2 汉化@俏俏',
		type = 'group',
		childGroups = 'tab',
		args = {
			desc2 = {
				order = 10,
				type = 'description',
				width = 'full',
				name = '暴雪框架显示预估治疗\n'
			},
			button0 = {
				order = 20,
				type = 'execute',
				name = '重置为默认值',
				confirm = true,
				func = function() HBCdb:ResetDB() end
			}
		},
	}
	options.args['basicFeatures'] = {
		name = '基础功能',
		type = 'group',
		order = 10,
		args = {
			header0 = {
				order = 10,
				type = 'header',
				name = '基础设置',
			},
			overheal = {
				order = 30,
				type = 'range',
				name = '过量显示百分比',
				desc = '设置显示过量治疗的百分比',
				min = 0,
				max = 0.5,
				step = 0.01,
				isPercent = true,
				get = function() return HBCdb.global.overhealPercent / 100 end,
				set = function(_,value) HBCdb.global.overhealPercent = value * 100 end,
			},
			spacer0 = {
				order = 34,
				type = 'description',
				name = '\n', 
			},
			seperateOwnHeal = {
				order = 40,
				type = 'toggle',
				name = '为自己的治疗单独着色（智能顺序）',
				desc = '治疗按施法顺序显示。 \n持续治疗法术总是最后显示。',
				width = 'full',
				get = function() return HBCdb.global.seperateOwnColor end,
				set = function(_, value) HBCdb.global.seperateOwnColor = value; HealBarsClassic:ResetHealBars() end,
			},
			spacer1 = {
				order = 41,
				type = 'description',
				name = '\n',
			},
			hotToggle = {
				order = 60,
				type = 'toggle',
				name = '显示HoTs',
				desc = '在治疗预估中显示持续治疗。',
				width = 'full',
				get = function() return HBCdb.global.showHots end,
				set = function(_, value) HBCdb.global.showHots = value; HealBarsClassic:ResetHealBars() end,
			},
			seperateHot = {
				order = 130,
				type = 'toggle',
				name = 'HoTs单独着色',
				disabled = function() return not HBCdb.global.showHots end,
				desc = '持续治疗单独着色',
				width = 'full',
				get = function() return HBCdb.global.showHots and HBCdb.global.seperateHots end,
				set = function(_, value) HBCdb.global.seperateHots = value
										 HealBarsClassic:ResetHealBars() end,
			},
			spacer2 = {
				order = 131,
				type = 'description',
				name = '\n',
			},
			shieldGlow = {
				order = 140,
				type = 'toggle',
				name = '护盾闪光 (Beta)',
				desc = '在受保护的玩家的血条末端添加光晕\n\n'
					..'目前支持的法术\n'
					..'真言术:盾\n'
					..'寒冰护体\n'
					..'法力护盾\n'
					..'牺牲(虚空行者)\n',
				width = 'full',
				get = function() return HBCdb.global.shieldGlow end,
				set = function(_,value) 
					if not value then
						HealBarsClassic:ClearAllShields()
					end
						HBCdb.global.shieldGlow = value 
				end
			},
			raidCheckInfo = {
				order = 150,
				type = 'description',
				fontSize = 'medium',
				name = '\n\n\n|cFFFFD100聊天框指令|r \n'..
						'/HBC-打开设置面板\n'..
                                                '/HealBarsClassic help-显示帮助\n'..
						'/hbc help-显示帮助\n\n',
				descStyle = 'inline',
				desc = 'test'
			}
		},
	}	
	options.args['advancedFeatures'] = {
		name = '高级功能',
		type = 'group',
		order = 15,
		args = {
			header0 = {
				order = 10,
				type = 'header',
				name = '高级设置',
			},
			timeframeGroup = {
				order = 10,
				type = 'group',
				name = '时间量度',
				args = {
					description = {
						order = 11,
						type = 'description',
						name = '计算预估治疗的时间范围。\n',
					},
					headerSpacer = {
						order = 12,
						type = 'description',
						name = '\n',
					},
					healTimeframe = {
						order = 35,
						type = 'range',
						name = '常规治疗时间量度',
						desc = '预估常规治疗的时间范围。',
						min = 0.5,
						max = 18,
						step = 0.5,
						get = function() return HBCdb.global.healTimeframe end,
						set = function(info,value) HBCdb.global.healTimeframe = value end,
					},
					spacer3 = {
						order = 40,
						type = 'description',
						name = '\n',
					},
					channelTimeframe = {
						order = 50,
						type = 'range',
						name = 'HoT治疗时间量度',
						desc = '预估HoT治疗的时间范围。',
						min = 3,
						max = 18,
						step = 1,
						get = function() return HBCdb.global.channelTimeframe end,
						set = function(info,value) HBCdb.global.channelTimeframe = value end,
					},
					spacer4 = {
						order = 51,
						type = 'description',
						name = '\n',
					},
					timeframe = {
						order = 70,
						type = 'range',
						name = 'HoT治疗时间量度',
						desc = '预估HoT治疗的时间范围。',
						min = 3,
						max = 18,
						step = 1,
						get = function() return HBCdb.global.timeframe end,
						set = function(info,value) HBCdb.global.timeframe = value end,
					}
				}
			},
			textureGroup = {
				name = '材质',
				type = 'group',
				order = 15,
				args = {
					unitFrameTextures = {
						order = 140,
						type = 'toggle',
						name = '更换治疗显示纹理。',
						desc = '需要 /reload才可生效',
						descStyle = 'inline',
						width = 'full',
						get = function() return HBCdb.global.alternativeTexture end,
						set = function(_,value) HBCdb.global.alternativeTexture = value end
					},
				}
			},
			statusTextGroup = {
				name = '状态文本',
				type = 'group',
				order = 20,
				args = {
					defensiveToggle = {
						order = 10,
						type = 'toggle',
						name = '启用',
						desc = '启用自定义状态文本显示。',
						get = function() return HBCdb.global.defensiveIndicator end,
						set = function(_, value) HBCdb.global.defensiveIndicator = value end,
					},
					invulDefensiveToggles = {
						order = 20,
						type = 'multiselect',
						name = '无敌状态显示',
						width = 'full',
						disabled = function() return not HBCdb.global.defensiveIndicator end,
						values = HealBarsClassic.invulStatusTextConfigList,
						get = function(_,key) return HBCdb.global.enabledStatusTexts[key] end,
						set = function(_,key,state) HBCdb.global.enabledStatusTexts[key] = state end,
					},
					strongDefensiveToggles = {
						order = 25,
						type = 'multiselect',
						name = '强减伤状态显示',
						width = 'full',
						disabled = function() return not HBCdb.global.defensiveIndicator end,
						values = HealBarsClassic.strongMitStatusTextConfigList,
						get = function(_,key) return HBCdb.global.enabledStatusTexts[key] end,
						set = function(_,key,state) HBCdb.global.enabledStatusTexts[key] = state end,
					},
					weakDefensiveToggles = {
						order = 25,
						type = 'multiselect',
						name = '弱减伤状态显示',
						width = 'full',
						disabled = function() return not HBCdb.global.defensiveIndicator end,
						values = HealBarsClassic.softMitStatusTextConfigList,
						get = function(_,key) return HBCdb.global.enabledStatusTexts[key] end,
						set = function(_,key,state) HBCdb.global.enabledStatusTexts[key] = state end,
					},
					miscToggles = {
						order = 40,
						type = 'multiselect',
						name = '其他显示',
						width = 'full',
						disabled = function() return not HBCdb.global.defensiveIndicator end,
						values = HealBarsClassic.miscStatusTextConfigList,
						get = function(_,key) return HBCdb.global.enabledStatusTexts[key] end,
						set = function(_,key,state) HBCdb.global.enabledStatusTexts[key] = state end,
					}
				},
			},
			healthTextGroup = {
				name = '血量文本',
				type = 'group',
				order = 30,
				args = {
					predictiveHealthLostToggle = {
						order = 60,
						type = 'toggle',
						name = '预测血量损失',
						desc = '\n显示预估治疗后的生命值损失\n指的是在开启暴雪自带显示损失生命值功能时计算预估治疗后损失的生命值',
						descStyle = 'inline',
						width = 'full',
						get = function() return HBCdb.global.predictiveHealthLost end,
						set = function(_, value) HBCdb.global.predictiveHealthLost = value end,
					}
				}
			},
			miscGroup = {
				name = '其他',
				type = 'group',
				order = 40,
				args = {
					fastUpdate = {
						order = 20,
						type = 'toggle',
						name = '快速团队血量刷新',
						desc = '\n每秒钟刷新预估治疗值。\n若启用，可能会占用资源导致卡顿。',
						descStyle = 'inline',
						width = 'full',
						get = function() return HBCdb.global.fastUpdate end,
						set = function(_, value) HBCdb.global.fastUpdate = value;  end,
					},
				}
			}
		}
	}
	options.args['colorSettings'] = {
		name = '颜色设置',
		type = 'group',
		order = 30,
		args = {
			header0 = {
				order = 10,
				type = 'header',
				name = '颜色设置',
			},
			desc1 = {
				order = 100,
				type = 'description',
				name = '滑动模块可以调整颜色透明度'
			},
			spacer0 = {
				order = 101,
				type = 'description',
				name = '\n',
			},
			healColor = { 
				order = 110,
				type = 'color',
				name = '常规治疗颜色',
				hasAlpha = true,
				get = function() return unpack(HBCdb.global.healColor) end,
				set = function (_, r, g, b, a) HBCdb.global.healColor = {r,g,b,a}; 
												HealBarsClassic.UpdateColors() end,
			},
			spacer1 = {
				order = 111,
				type = 'description',
				name = '\n',
			},
			hotColor = { 
				order = 140,
				type = 'color',
				name = 'HoT持续治疗颜色',
				hasAlpha = true,
				get = function() return unpack(HBCdb.global.hotColor) end,
				set = function (_,r, g, b, a) HBCdb.global.hotColor = {r,g,b,a}; 
											HealBarsClassic.UpdateColors() end,
			},
			spacer2 = {
				order = 141,
				type = 'description',
				name = '\n',
			},
			ownHealColor = { 
				order = 150,
				type = 'color',
				name = '自己的常规治疗颜色',
				hasAlpha = true,
				get = function() return unpack(HBCdb.global.ownHealColor) end,
				set = function (_, r, g, b, a) HBCdb.global.ownHealColor = {r,g,b,a}; 
												HealBarsClassic.UpdateColors() end,
			},
			spacer3 = {
				order = 151,
				type = 'description',
				name = '\n',
			},
			ownHotColor = { 
				order = 160,
				type = 'color',
				name = '自己的HoT治疗颜色',
				hasAlpha = true,
				get = function() return unpack(HBCdb.global.ownHotColor) end,
				set = function (_, r, g, b, a) HBCdb.global.ownHotColor = {r,g,b,a}; 
												HealBarsClassic.UpdateColors() end,
			},
			spacer4 = {
				order = 161,
				type = 'description',
				name = '\n',
			},
			flipColors = {
				order = 170,
				type = 'execute',
				name = '反转颜色',
				desc = '反转常规和自己的治疗颜色。',
				func = function() 
					HBCdb.global.healColor, HBCdb.global.ownHealColor = HBCdb.global.ownHealColor, HBCdb.global.healColor
					HBCdb.global.hotColor, HBCdb.global.ownHotColor = HBCdb.global.ownHotColor, HBCdb.global.hotColor
					HealBarsClassic.UpdateColors()
				end,
			},
			spacer5 = {
				order = 171,
				type = 'description',
				name = '\n',
			},
			resetColors = {
				order = 180,
				type = 'execute',
				confirm = true,
				name = '重置颜色',
				desc = '重置颜色为默认值。',
				func = function() 
					HBCdb.global.healColor = HBCDefaultColors.flat
					HBCdb.global.hotColor = HBCDefaultColors.hot 
					HBCdb.global.ownHealColor = HBCDefaultColors.ownFlat 
					HBCdb.global.ownHotColor = HBCDefaultColors.ownHot
					HealBarsClassic.UpdateColors()
				end,
			},
			spacer6 = {
				order = 181,
				type = 'description',
				name = '\n',
			},
			--[[
			resetHighContrastColors = {
				order = 190,
				type = 'execute',
				confirm = true,
				name = 'Reset Colors (Contrast)',
				desc = 'Resets colors back to the high contrast defaults.',
				func = function() 
					HBCdb.global.healColor = HBCHighContrastDefaultColors.flat
					HBCdb.global.hotColor = HBCHighContrastDefaultColors.hot 
					HBCdb.global.ownHealColor = HBCHighContrastDefaultColors.ownFlat 
					HBCdb.global.ownHotColor = HBCHighContrastDefaultColors.ownHot
					HealBarsClassic.UpdateColors()
				end,
			},--]]
		}
	}

	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("HBCOptions", options)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("HBCOptions","HealBarsClassic")

end
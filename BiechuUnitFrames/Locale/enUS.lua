local addonName = ...
_G[addonName .. 'Locale'] = {}
local L = _G[addonName .. 'Locale']

L.player = 'Player Frame'
L.pet = 'Pet Frame'
L.pettarget = 'Pet Target Frame'
L.target = 'Target Frame'
L.targettarget = 'Target Target Frame'
L.focus = 'Focus Frame'
L.focustarget = 'Focus Target Frame'
L.party = 'Party Frame'
L.partypet = 'Party Pet Frame'
L.partytarget = 'Party Target Frame'
L.info = 'Email: ' .. GetAddOnMetadata(addonName, 'X-eMail')
L.cantSaveInCombat = 'Cant save in combat!'
L.confirmResetDefault = 'Confirm reset default?'
L.reset = 'Reset'
L.config = 'Select config options'
L.public = 'Use common profile'
L.dark = 'Dark themes'
L.newClassIcon = 'New style class icon'
L.healthBarColor = 'Life bar color changes according to life value'
L.nameClassColor = 'Name color class color (player)'
L.dragSystemFarmes = 'Freely drag the system frame'
L.incomingHeals = 'Show alert heals'
L.alwaysCompareItems = 'Enable equipment comparison'
L.autoTab = 'PVP automatic TAB selects players'
L.dalaran = 'Dalaran'
L.autoDalaran = 'Dalaran automatically closes nameboard'
L.carry = 'Numeric carry'
L.carryW = 'Wan/Yi'
L.wan = 'Wan'
L.yi = 'Yi'
L.carryK = 'K/M'
L.nameFont = 'First name font'
L.fontList = {
	[1] = {
		text = 'Friz Quadrata TT',
		value = [[Fonts\FRIZQT__.ttf]]
	},
	[2] = {
		text = '2002',
		value = [[Fonts\2002.ttf]]
	},
	[3] = {
		text = '2002 Bold',
		value = [[Fonts\2002B.ttf]]
	},
	[4] = {
		text = 'AR CrystalzcuheiGBK Demibold',
		value = [[Fonts\ARHei.ttf]]
	},
	[5] = {
		text = 'AR ZhongkaiGBK Medium (Combat)',
		value = [[Fonts\ARKai_C.ttf]]
	},
	[6] = {
		text = 'AR ZhongkaiGBK Medium',
		value = [[Fonts\ARKai_T.ttf]]
	},
	[7] = {
		text = 'Arial Narrow',
		value = [[Fonts\ARIALN.ttf]]
	},
	[8] = {
		text = 'MoK',
		value = [[Fonts\K_Pagetext.ttf]]
	},
	[9] = {
		text = 'Morpheus',
		value = [[Fonts\MORPHEUS_CYR.ttf]]
	},
	[10] = {
		text = 'Nimrod MT',
		value = [[Fonts\NIM_____.ttf]]
	},
	[11] = {
		text = 'Skurri',
		value = [[Fonts\SKURRI_CYR.ttf]]
	}
}
L.fontFlags = 'Font Outline'
L.fontFlagsList = {
	[1] = {
		text = 'None',
		value = 'NONE'
	},
	[2] = {
		text = 'Thin',
		value = 'OUTLINE'
	},
	[3] = {
		text = 'Thick',
		value = 'THICKOUTLINE'
	},
	[4] = {
		text = 'Monochrome',
		value = 'MONOCHROME'
	}
}
L.portraitCombat = 'Display combat information on the avatar'
L.valueFont = 'Value Font'
L.combatFlash = 'Combat Red Flash'
L.threatLeft = 'Display threat value on the left'
L.statusBarClass = 'Status bar background professional color'
L.statusBarAlpha = 'Status bar alpha'
L.healthBarClass = 'Health bar background class color'
L.fiveSecondRule = 'Mana bar five second recovery rule'
L.border = 'Border'
L.borderList = {
	[1] = 'Normal',
	[2] = 'Rare',
	[3] = 'RareElite',
	[4] = 'Elite'
}
L.portrait = 'Portrait'
L.portraitList = {
	[0] = 'Default',
	[1] = 'Class Icon',
	[2] = 'Cat',
	[3] = 'Dog',
	[4] = 'Panda',
	[5] = 'Moonkin',
	[6] = 'CoolFace'
}
L.nameFontSize = 'Name Font Size'
L.valueFontSize = 'Value Font Size'
L.valueStyle = 'Value Style'
L.valueStyleList = {
	[1] = 'Current value and percentage on both sides',
	[2] = 'Middle percent',
	[3] = 'Middle current value',
	[4] = 'Current/Max',
	[5] = 'Current Side percentage',
	[6] = 'Current/Max Side percentage',
	[7] = 'Side percentage',
	[8] = 'Side current value',
	[9] = 'Side current/maximum',
	[10] = 'None'
}
L.druidBar = 'Show custom druid mana bars'
L.hideName = 'Hide Name'
L.scale = 'Scale'
L.hideFrame = 'Hide Frame'
L.drag = 'Hold down Shift and drag when not in combat'
L.anchor = 'Anchor player frame'
L.pointDefault = 'Restore default point'
L.pointTargetLeftTop = 'Position on top left'
L.pointTargetCenter = 'Horizontally centered'
L.pointPlayerAlignment = 'Horizontal alignment'
L.pointPlayerCenter = 'Horizontally centered'
L.pointPlayerVertical = 'Vertical alignment'
L.portraitClass = 'The avatar shows the class icon'
L.selfCooldown = 'Only show the CD of the Aura I cast'
L.dispelCooldown = 'Only show CD for Aura that can be dispelled'
L.dispelStealable = 'Highlight Aura that you can dispel'
L.buffCooldown = 'Only display the CD of Buffs I cast'
L.debuffCooldown = 'Only display Debuff CD that can be dispelled'
L.debuffStealable = 'Highlight Debuffs that can be dispelled'
L.auraSize = 'Aura icon size'
L.auraPercent = 'Percentage of others casting Aura'
L.auraRows = 'Number of Aura per Line'
L.auraX = 'Buff/Debuf X-axis position'
L.auraY = 'Buff/Debuf Y-axis position'
L.raidShowParty = 'Raid show party frame'
L.showLevel = 'Show level'
L.outRange = 'Translucent beyond range'
L.showCastBar = 'Show cast bar'
L.talentIcon = 'Show mini icon (click to switch talents)'
L.autoTalentEquip = 'Automatic talent name equipment set'
L.equipmentIcon = 'Show equipment icon'
L.hidePartyNumber = 'In raid hide party number'
L.miniIcon = 'Show mini icons (creature/class)'
L.creatureList = {
	['Beast'] = 1,
	['Humanoid'] = 2,
	['Dragonkin'] = 3,
	['Mechanical'] = 4,
	['Demon'] = 5,
	['Elemental'] = 6,
	['Giant'] = 7,
	['Undead'] = 8,
	['Totem'] = 9,
	['Aberration'] = 10,
	['Critter'] = 11,
	['Gas Cloud'] = 12,
	['Non-combat Pet'] = 13,
	['Not specified'] = 14
}

L.playerClass = 'Player class:'
L.creatureType = 'Creature type:'
L.altKeyDown = 'Alt-Click:'
L.invite = 'Invite'
L.ctrlKeyDown = 'Ctrl-Click:'
L.trade = ' Trade'
L.shiftKeyDown = 'Shift-Click:'
L.copyName = 'Copy name'
L.leftButton = 'Left mouse click:'
L.inspect = 'Inspect target'
L.rightButton = 'Right mouse click'
L.followUnit = 'Follow unit'
L.middleButton = 'Middle mouse button'
L.sendTell = 'Send tell'
L.primary = 'Primary talent'
L.secondary = 'Secondary talent'
L.switch = 'Switch'
L.switchAfter = 'Switch equipment after talent'
L.nude = 'One click to undress'
L.click = 'Mouse click'
L.clickEquipment = 'Click equipment'
L.saveEquipment = 'Save equipment'

local gcdEnd, autoEnd, msEnd, asEnd, ssEnd, lastActionEnd, active, castingEndTime, lastPrint, autoStart
local msName, asName, ssName, autoName

--hardcoding for now until I can code in looking up the actual speed
local quiverSpeed = 1.15

local L = AceLibrary("AceLocale-2.2"):new("ShotAssist")


local surface = AceLibrary("Surface-1.0")

surface:Register("Perl", "Interface\\AddOns\\ShotAssist\\textures\\perl")
surface:Register("Smooth", "Interface\\AddOns\\ShotAssist\\textures\\smooth")
surface:Register("Glaze", "Interface\\AddOns\\ShotAssist\\textures\\glaze")
surface:Register("BantoBar", "Interface\\AddOns\\ShotAssist\\textures\\BantoBar")
surface:Register("Gloss", "Interface\\AddOns\\ShotAssist\\textures\\Gloss")

ShotAssist = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")

ShotAssist.defaults = {
	width		= 255,
	height		= 25,
	timeSize	= 12,
	spellSize	= 12,
	fontName	= "Fonts\\FRIZQT__.TTF",
	delaySize	= 14,
	borderStyle = "Classic",
	texture		= "BantoBar",
	pos			= {},
	delay   	= 0.2,
	soon 	    = 0.4,
	now			= 0.2,
	icon        = true,
	autoBar     = true,
	autoHeight  = 15,
	colors = 
	{
		wait 			= {r=1, g=0, b=0, a=1},
		soon	    	= {r=1, g=.7, b=0, a=1},
		now				= {r=0, g=1, b=0, a=1},
		move			= {r=0, g=1, b=0, a=0.5},
		stop			= {r=1, g=0, b=0, a=0.5},
		stopBackground  = {r=1, g=0, b=0, a=0.3},
	}
}

ShotAssist.options = {
	type = "group",
	args = {
		[L["lock"]] = {
			name = L["lock"],
			type = "toggle",
			desc = L["Lock/Unlock the casting bar."],
			get = function() return ShotAssist.locked end,
			set = function(v)
				ShotAssist.locked = v
				if( not v and not ( ShotAssist.active)) then
					ShotAssist.master:SetScript( "OnUpdate", nil )
					ShotAssist.master:Show()
					ShotAssist.master.Bar:SetStatusBarColor(.3, .3, .3)
					ShotAssist.master.Time:SetText("1.3")
					ShotAssist.master.Spell:SetText(L["Test Spell"])
					ShotAssist.master.AutoBar:SetStatusBarColor(.3, .3, .3)
					ShotAssist.master.AutoTime:SetText("1.3")
					ShotAssist.master.AutoSpell:SetText(L["Test Spell"])
					-- ShotAssist.master.GCDBar:SetStatusBarColor(.3, .3, .3)
					-- ShotAssist.master.GCDTime:SetText("1.3")
					-- ShotAssist.master.GCDSpell:SetText(L["Test Spell"])
				else
					ShotAssist.master:SetScript( "OnUpdate", ShotAssist.OnCasting )
				end
			end,
			map = {[false] = L["Unlocked"], [true] = L["Locked"]},
			guiNameIsMap = true,
		},
		[L["texture"]] = {
			name = L["texture"], 
			type = "text",
			desc = L["Set the texture."],
			get = function() return ShotAssist.db.profile.texture end,
			set = function(v)
				ShotAssist.db.profile.texture = v
				ShotAssist:Layout()
			end,
			validate = surface:List(),
		},
		[L["border"]] = {
			name = L["border"],
			type = "text",
			desc = L["Set the border for the bar."],
			get = function() return ShotAssist.db.profile.borderStyle end,
			set = function(v)
				ShotAssist.db.profile.borderStyle = v 
				ShotAssist:Layout()
			end,
			validate = {"Classic", "Black", "Hidden"},
		},
		[L["width"]] = {
			name = L["width"], 
			type = "range", 
			min = 10, 
			max = 5000, 
			step = 1,
			desc = L["Set the width of the casting bar."],
			get = function() return ShotAssist.db.profile.width end,
			set = function(v)
				ShotAssist.db.profile.width = v
				ShotAssist:Layout()
			end,
		},
		[L["height"]] = {
			name = L["height"], 
			type = "range", 
			min = 5, 
			max = 50, 
			step = 1,
			desc = L["Set the height of the casting bar."],
			get = function() return ShotAssist.db.profile.height end,
			set = function(v)
				ShotAssist.db.profile.height = v
				ShotAssist:Layout()
			end,
		},
		[L["autoHeight"]] = {
			name = L["autoHeight"], 
			type = "range", 
			min = 5, 
			max = 50, 
			step = 1,
			desc = L["Set the height of the auto shot bar."],
			get = function() return ShotAssist.db.profile.autoHeight end,
			set = function(v)
				ShotAssist.db.profile.autoHeight = v
				ShotAssist:Layout()
			end,
		},
		[L["delay"]] = {
			name = L["delay"], 
			type = "range", 
			min = 0, 
			max = 1000, 
			step = .01,
			desc = L["The acceptable amount of time to delay an autoshot."],
			get = function() return ShotAssist.db.profile.delay end,
			set = function(v)
				ShotAssist.db.profile.delay = v
			end,
		},
		[L["delay"]] = {
			name = L["delay"], 
			type = "range", 
			min = 0, 
			max = 1, 
			step = .01,
			desc = L["The acceptable amount of time to delay an autoshot."],
			get = function() return ShotAssist.db.profile.delay end,
			set = function(v)
				ShotAssist.db.profile.delay = v
			end,
		},
		[L["soon"]] = {
			name = L["soon"], 
			type = "range", 
			min = 0, 
			max = 1, 
			step = .01,
			desc = L["When should the bar change to the soon color."],
			get = function() return ShotAssist.db.profile.soon end,
			set = function(v)
				ShotAssist.db.profile.soon = v
			end,
		},
		[L["now"]] = {
			name = L["now"], 
			type = "range", 
			min = 0, 
			max = 1, 
			step = .01,
			desc = L["When should the bar change to the now color."],
			get = function() return ShotAssist.db.profile.now end,
			set = function(v)
				ShotAssist.db.profile.now = v
			end,
		},
		[L["icon"]] = {
			name = L["icon"], 
			type = "toggle", 
			desc = L["Display the icon of the next shot."],
			get = function() return ShotAssist.db.profile.icon end,
			set = function(v)
				ShotAssist.db.profile.icon = v
				ShotAssist:Layout()
			end,
		},
		[L["autoBar"]] = {
			name = L["autoBar"], 
			type = "toggle", 
			desc = L["Display the autoshot timer bar."],
			get = function() return ShotAssist.db.profile.autoBar end,
			set = function(v)
				ShotAssist.db.profile.autoBar = v
				ShotAssist:Layout()
			end,
		},
		[L["font"]] = {
			name = L["font"],
			type = "group",
			desc = L["Set the font size of different elements."],
			args = {
				[L["name"]] = {
					name = L["name"], 
					type = "text", 
					desc = L["Set the font of different elements."],
					usage = "fontName",
					get = function() return ShotAssist.db.profile.fontName end,
					set = function(v)
						ShotAssist.db.profile.fontName = v
						ShotAssist:Layout()
					end,
				},
				[L["spell"]] = {
					name = L["spell"], 
					type = "range", 
					min = 6,
					max = 32,
					step = 1,
					desc = L["Set the font size of the spellname."],
					get = function() return ShotAssist.db.profile.spellSize end,
					set = function(v)
						ShotAssist.db.profile.spellSize = v
						ShotAssist:Layout()
					end,
				},
				[L["time"]] = {
					name = L["time"], 
					type = "range", 
					min = 6, 
					max = 32, 
					step = 1,
					desc = L["Set the font size of the spell time."],
					get = function() return ShotAssist.db.profile.timeSize end,
					set = function(v)
						ShotAssist.db.profile.timeSize = v
						ShotAssist:Layout()
					end,
				}
			}
		},
		[L["color"]] = {
			name = L["color"], 
			type = 'group',
			desc = L["Set the color of the bar."],
			args = {
				[L["wait"]] = {
					name = L["wait"],
					type = 'color',
					desc = L["Set the color of the bar when there is no upcoming shot."],
					-- hasAlpha = true,
					get = function()
						local v = ShotAssist.db.profile.colors.wait
						return v.r, v.g, v.b, v.a
					end,
					set = function(r,g,b,a) 
						ShotAssist.db.profile.colors.wait = {r=r,g=g,b=b,a=a}
					end
				},
				[L["soon"]] = {
					name = L["soon"], 
					type = 'color',
					desc = L["Set the color of the bar when you should be casting soon."],
					-- hasAlpha = true,
					get = function()
						local v = ShotAssist.db.profile.colors.soon
						return v.r, v.g, v.b, v.a
					end,
					set = function(r,g,b,a) 
						ShotAssist.db.profile.colors.soon = {r=r,g=g,b=b,a=a} 
					end
				},
				[L["now"]] = {
					name = L["now"], 
					type = 'color',
					desc = L["Set the color of the bar when you should be casting."],
					-- hasAlpha = true,
					get = function()
						local v = ShotAssist.db.profile.colors.now
						return v.r, v.g, v.b, v.a
					end,
					set = function(r,g,b,a) 
						ShotAssist.db.profile.colors.now = {r=r,g=g,b=b,a=a} 
					end
				},
				[L["move"]] = {
					name = L["move"], 
					type = 'color',
					desc = L["Set the color of the auto shot bar when you can move."],
					hasAlpha = true,
					get = function()
						local v = ShotAssist.db.profile.colors.move
						return v.r, v.g, v.b, v.a
					end,
					set = function(r,g,b,a) 
						ShotAssist.db.profile.colors.move = {r=r,g=g,b=b,a=a} 
					end
				},
				[L["stop"]] = {
					name = L["stop"], 
					type = 'color',
					desc = L["Set the color of the auto shot bar when you cannot move."],
					hasAlpha = true,
					get = function()
						local v = ShotAssist.db.profile.colors.stop
						return v.r, v.g, v.b, v.a
					end,
					set = function(r,g,b,a) 
						ShotAssist.db.profile.colors.stop = {r=r,g=g,b=b,a=a} 
					end
				},
				[L["stopBackground"]] = {
					name = L["stopBackground"], 
					type = 'color',
					desc = L["Set the background color of the auto shot bar when you cannot move."],
					hasAlpha = true,
					get = function()
						local v = ShotAssist.db.profile.colors.stopBackground
						return v.r, v.g, v.b, v.a
					end,
					set = function(r,g,b,a) 
						ShotAssist.db.profile.colors.stopBackground = {r=r,g=g,b=b,a=a} 
					end
				}
			}
		}
	}
}

ShotAssist.Borders = {
	["Classic"]		= {
		["texture"] = "Interface\\Tooltips\\UI-Tooltip-Border",["size"] = 16,["insets"] = 5,
		["bc"] = {r=0,g=0,b=0,a=1},
		["bbc"] = {r=TOOLTIP_DEFAULT_COLOR.r,g=TOOLTIP_DEFAULT_COLOR.g,b=TOOLTIP_DEFAULT_COLOR.b,a=1},
	},
	["Black"]		= {
		["texture"] = "Interface\\Tooltips\\UI-Tooltip-Border",["size"] = 4,["insets"] = 0,
		["bc"] = {r=0,g=0,b=0,a=1},
		["bbc"] = {r=0,g=0,b=0,a=1},
	},
	["Hidden"]		= {
		["texture"] = "",["size"] = 0,["insets"] = 4,
		["bc"] = {r=0,g=0,b=0,a=1},
		["bbc"] = {r=0,g=0,b=0,a=1},
	},
}


ShotAssist:RegisterDB("ShotAssistDB")
ShotAssist:RegisterDefaults('profile', ShotAssist.defaults)
ShotAssist:RegisterChatCommand( {"/shotassist"}, ShotAssist.options )

function ShotAssist:OnInitialize()
	self.locked = true
	local currentTime = GetTime()
	msEnd = currentTime
	autoStart = currentTime
	autoEnd = currentTime
	asEnd = currentTime
	gcdEnd = currentTime
	lastActionEnd = currentTime
	active = false
	castingEndTime = nil
	lastPrint = 0

	msName   = GetSpellInfo( 2643)
	asName   = GetSpellInfo( 3044)
	ssName   = GetSpellInfo(34120)
	autoName = GetSpellInfo(   75)
end

function ShotAssist:OnEnable()
	self:CreateFrameWork()

	self:RegisterEvent("START_AUTOREPEAT_SPELL", "StartAutoRepeat")
	self:RegisterEvent("UNIT_SPELLCAST_START", "SpellCastStart")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "SpellCastSucceeded")
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL", "StopAutoRepeat")

	--to find MS cast starts
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "CheckUnfiltered")
end

function ShotAssist:CheckUnfiltered() 
	local timestamp, combatEvent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, _, spellId, spellName = CombatLogGetCurrentEventInfo()

	local fromPlayer
	if (sourceName and not CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_NONE) ) then
		fromPlayer = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE);
	end

	--ms doesn't show up as a true cast so we have to fake it here
	if (fromPlayer and spellName == msName and combatEvent == "SPELL_CAST_START") then
		lastActionEnd = GetTime()
		ShotAssist.master.Bar:SetValue( 0 )

		--todo is multi cast shot hasted?
		castingEndTime = lastActionEnd + 0.5
		gcdEnd = lastActionEnd + 1.5

		--when does 10 seconds start from?
		--when I set this to 10  it felt like I was trying to multi before it was off CD. extended it to include the MS cast tiem
		msEnd = lastActionEnd + 10 + ( 0.5 *  ( 1 / (1 + GetRangedHaste() / 100) / quiverSpeed ))

		-- DEFAULT_CHAT_FRAME:AddMessage(GetTime() .. " Casting MS - start: " .. string.format( "%.1f", lastActionEnd - GetTime()) .. " end: " .. string.format( "%.1f", castingEndTime - GetTime()))
	end
end

function ShotAssist:StartAutoRepeat()
	local currentTime = GetTime()
	lastActionEnd = currentTime
	ShotAssist.master.Bar:SetValue( 0 )
	
	if not active then
		active = true

		self.master.Bar:SetMinMaxValues(0, 1)
		self.master.Bar:SetValue(1)

		local color = self.db.profile.colors.now
		self.master.Bar:SetStatusBarColor( color.r, color.g, color.b )

		self.master.Spell:SetText("shoot")
		self.master.Time:SetText("0.0")

		self.thresHold = nil
	
		self.master:SetAlpha(1)
		self.master:Show()
		
		self.master.Spark:Show()
		self.master.Time:Show()
	end
end

function ShotAssist:SpellCastStart( unit, castGUID, spellID )
	if( unit ~= "player" ) then return end
	
	local name, text, _, startTime, endTime = CastingInfo()

	--todo since we can't use checkgcd should we do this for other spellnames
	if ( name == ssName ) then
		castingEndTime = endTime / 1000
		lastActionEnd = startTime / 1000
		ShotAssist.master.Bar:SetValue( 0 )

		gcdEnd = lastActionEnd + 1.5

		-- DEFAULT_CHAT_FRAME:AddMessage(GetTime() .. " Casting SS - start: " .. string.format( "%.1f", lastActionEnd - GetTime()) .. " end: " .. string.format( "%.1f", castingEndTime - GetTime()))
	else
		-- DEFAULT_CHAT_FRAME:AddMessage(GetTime() .. " Casting " .. name .. " withID " .. spellID )
	end
end

function ShotAssist:SpellCastSucceeded( unit, castGUID, spellID )
	if unit ~= "player" then return end

	local currentTime = GetTime()
	local spellName = GetSpellInfo(spellID)

	castingEndTime = nil

	if (spellName == msName) then 
		-- DEFAULT_CHAT_FRAME:AddMessage(GetTime() .. " Fired MS")
	elseif (spellName == asName) then 
		-- DEFAULT_CHAT_FRAME:AddMessage(GetTime() .. " Fired AS")
		asEnd = currentTime + 6 
		lastActionEnd = currentTime
		gcdEnd = currentTime + 1.5
		ShotAssist.master.Bar:SetValue( 0 )
	elseif (spellID == 75)then
		-- DEFAULT_CHAT_FRAME:AddMessage(GetTime() .. " Fired auto")
		local shotTime = UnitRangedDamage("player")
		ShotAssist.master.AutoSpell:SetText(string.format( "%.2f", shotTime))
		ShotAssist.master.AutoBar:SetStatusBarColor( ShotAssist.db.profile.colors.move.r, ShotAssist.db.profile.colors.move.g, ShotAssist.db.profile.colors.move.b, ShotAssist.db.profile.colors.move.a ) 
		ShotAssist.master.AutoRedBar:SetWidth( (.5 * ShotAssist.master.AutoBar:GetWidth()  ) / shotTime )
		autoStart = currentTime
		autoEnd = currentTime + shotTime
	elseif (spellName == ssName) then 
		-- DEFAULT_CHAT_FRAME:AddMessage(GetTime() .. " Fired SS")
	end

	--DEFAULT_CHAT_FRAME:AddMessage(GetTime() .. " Fired " .. spellID)
end

function ShotAssist:StopAutoRepeat()
	active = false
	self.master:Hide()
end


function ShotAssist:SavePosition()
	local x, y = self.master:GetLeft(), self.master:GetTop()
	local s = self.master:GetEffectiveScale()

	self.db.profile.pos.x = x * s
	self.db.profile.pos.y = y * s
end

function ShotAssist:SetPosition()
	if self.db.profile.pos.x then
		local x = self.db.profile.pos.x
		local y = self.db.profile.pos.y
	
		local s = self.master:GetEffectiveScale()

		self.master:ClearAllPoints()
		self.master:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / s, y / s)
	else
		self.master:ClearAllPoints()
		self.master:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
end

function ShotAssist:CreateFrameWork()
	self.master = CreateFrame("Frame", "ShotAssistFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
	self.master:Hide()
	
	self.master:SetScript( "OnUpdate", self.OnCasting )
	self.master:SetMovable(true)
	self.master:EnableMouse(true)
	self.master:RegisterForDrag("LeftButton")
	self.master:SetScript("OnDragStart", function() if not self.locked then self["master"]:StartMoving() end end)
	self.master:SetScript("OnDragStop", function() self["master"]:StopMovingOrSizing() self:SavePosition() end)

	self.master.Bar	  = CreateFrame("StatusBar", nil, self.master)

	self.master.Spark = self.master.Bar:CreateTexture(nil, "OVERLAY")
	self.master.Time  = self.master.Bar:CreateFontString(nil, "OVERLAY")
	self.master.Spell = self.master.Bar:CreateFontString(nil, "OVERLAY")
	
	self.master.Icon  = self.master.Bar:CreateTexture("nil", "OVERLAY")

	self.master.AutoBar	  = CreateFrame("StatusBar", nil, self.master)
	self.master.AutoRedBar= CreateFrame("StatusBar", nil, self.master)

	self.master.AutoSpark = self.master.AutoBar:CreateTexture(nil, "OVERLAY")
	self.master.AutoTime  = self.master.AutoBar:CreateFontString(nil, "OVERLAY")
	self.master.AutoSpell = self.master.AutoBar:CreateFontString(nil, "OVERLAY")

	-- self.master.GCDBar	  = CreateFrame("StatusBar", nil, self.master)

	-- self.master.GCDSpark = self.master.GCDBar:CreateTexture(nil, "OVERLAY")
	-- self.master.GCDTime  = self.master.GCDBar:CreateFontString(nil, "OVERLAY")
	-- self.master.GCDSpell = self.master.GCDBar:CreateFontString(nil, "OVERLAY")
	
	self:Layout()
end

function ShotAssist:Layout()
	-- local gameFont, _, _ = GameFontHighlightSmall:GetFont()

	local db = self.db.profile

	local borderWidth = self.Borders[db.borderStyle].size

	local gap = 5
	-- local gcdHeight = 10

	self.master:SetWidth( db.width + borderWidth )

	if(db.autoBar) then
		self.master:SetHeight( db.height + borderWidth + db.autoHeight + gap)
	else
		self.master:SetHeight( db.height + borderWidth)
	end

	self:BorderBackground()

	self.master.Bar:ClearAllPoints()
	self.master.Bar:SetPoint("TOPLEFT", self.master, "TOPLEFT", borderWidth / 2 , borderWidth / -2)
	self.master.Bar:SetWidth( db.width )
	self.master.Bar:SetHeight( db.height )
	self.master.Bar:SetStatusBarTexture( surface:Fetch( db.texture ))

	self.master.Icon:ClearAllPoints()
	self.master.Icon:SetPoint("TOPLEFT", self.master, "TOPLEFT", borderWidth / 2, borderWidth / -2)
	self.master.Icon:SetWidth( db.height )
	self.master.Icon:SetHeight( db.height )
	self.master.Icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

	if ( db.icon ) then self.master.Icon:Show() else self.master.Icon:Hide() end

	self.master.AutoBar:ClearAllPoints()
	self.master.AutoBar:SetPoint("TOPLEFT", self.master.Bar, "BOTTOMLEFT", 0, -1 * gap)
	self.master.AutoBar:SetWidth( db.width  )
	self.master.AutoBar:SetHeight( db.autoHeight )
	self.master.AutoBar:SetStatusBarTexture( surface:Fetch( db.texture ))
	self.master.AutoBar:SetMinMaxValues(0, 1)
	self.master.AutoBar:SetValue(0)

	self.master.AutoRedBar:ClearAllPoints()
	self.master.AutoRedBar:SetPoint("RIGHT", self.master.AutoBar, "RIGHT", 0, 0)
	self.master.AutoRedBar:SetWidth(0)
	self.master.AutoRedBar:SetHeight( db.autoHeight )
	self.master.AutoRedBar:SetStatusBarTexture( surface:Fetch( self.db.profile.texture ))
	self.master.AutoRedBar:SetStatusBarColor(db.colors.stopBackground.r, db.colors.stopBackground.g, db.colors.stopBackground.b, db.colors.stopBackground.a)
	self.master.AutoRedBar:SetMinMaxValues(0, 1)
	self.master.AutoRedBar:SetValue(1)

	-- self.master.GCDBar:ClearAllPoints()
	-- self.master.GCDBar:SetPoint("TOPLEFT", self.master.AutoBar, "BOTTOMLEFT", 0, 0)
	-- self.master.GCDBar:SetWidth( db.width )
	-- self.master.GCDBar:SetHeight( gcdHeight )
	-- self.master.GCDBar:SetStatusBarTexture( surface:Fetch( db.texture ))
	-- self.master.GCDBar:SetMinMaxValues(0, 1)
	-- self.master.GCDBar:SetValue(0)


	self.master.Spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	self.master.Spark:SetWidth(16)
	self.master.Spark:SetHeight( db.height*2.44 )
	self.master.Spark:SetBlendMode("ADD")

	self.master.Time:SetJustifyH("RIGHT")
	self.master.Time:SetFont( db.fontName, db.timeSize )
	self.master.Time:SetText("X.Y")
	self.master.Time:ClearAllPoints()
	self.master.Time:SetPoint("RIGHT", self.master.Bar, "RIGHT",-10,0)
	self.master.Time:SetShadowOffset(.8, -.8)
	self.master.Time:SetShadowColor(0, 0, 0, 1)

	self.master.Spell:SetJustifyH("CENTER")
	self.master.Spell:SetWidth( db.width - self.master.Time:GetWidth() )
	self.master.Spell:SetFont( db.fontName, db.spellSize )
	self.master.Spell:ClearAllPoints()
	self.master.Spell:SetPoint("LEFT", self.master.Bar, "LEFT",10,0)
	self.master.Spell:SetShadowOffset(.8, -.8)
	self.master.Spell:SetShadowColor(0, 0, 0, 1)

	self.master.AutoSpark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	self.master.AutoSpark:SetWidth(16)
	self.master.AutoSpark:SetHeight( db.autoHeight*2.44 )
	self.master.AutoSpark:SetBlendMode("ADD")

	self.master.AutoTime:SetJustifyH("RIGHT")
	self.master.AutoTime:SetFont( db.fontName, db.timeSize -2 )
	self.master.AutoTime:SetText("X.Y")
	self.master.AutoTime:ClearAllPoints()
	self.master.AutoTime:SetPoint("RIGHT", self.master.AutoBar, "RIGHT",-10,0)
	self.master.AutoTime:SetShadowOffset(.8, -.8)
	self.master.AutoTime:SetShadowColor(0, 0, 0, 1)

	self.master.AutoSpell:SetJustifyH("LEFT")
	self.master.AutoSpell:SetWidth( db.width - self.master.AutoTime:GetWidth() )
	self.master.AutoSpell:SetFont( db.fontName, db.spellSize - 2 )
	self.master.AutoSpell:ClearAllPoints()
	self.master.AutoSpell:SetPoint("LEFT", self.master.AutoBar, "LEFT",10,0)
	self.master.AutoSpell:SetShadowOffset(.8, -.8)
	self.master.AutoSpell:SetShadowColor(0, 0, 0, 1)

	-- self.master.GCDSpark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	-- self.master.GCDSpark:SetWidth(16)
	-- self.master.GCDSpark:SetHeight( gcdHeight*2.44 )
	-- self.master.GCDSpark:SetBlendMode("ADD")

	-- self.master.GCDTime:SetJustifyH("RIGHT")
	-- self.master.GCDTime:SetFont( db.fontName, db.timeSize - 4 )
	-- self.master.GCDTime:SetText("X.Y")
	-- self.master.GCDTime:ClearAllPoints()
	-- self.master.GCDTime:SetPoint("RIGHT", self.master.GCDBar, "RIGHT",-10,0)
	-- self.master.GCDTime:SetShadowOffset(.8, -.8)
	-- self.master.GCDTime:SetShadowColor(0, 0, 0, 1)

	-- self.master.GCDSpell:SetJustifyH("CENTER")
	-- self.master.GCDSpell:SetWidth( db.width - self.master.GCDTime:GetWidth() )
	-- self.master.GCDSpell:SetFont( db.fontName, db.spellSize - 4)
	-- self.master.GCDSpell:ClearAllPoints()
	-- self.master.GCDSpell:SetPoint("LEFT", self.master.GCDBar, "LEFT",10,0)
	-- self.master.GCDSpell:SetShadowOffset(.8, -.8)
	-- self.master.GCDSpell:SetShadowColor(0, 0, 0, 1)
	-- self.master.GCDSpell:SetText("GCD")

	if(db.autoBar) then
		self.master.AutoBar:Show()
		self.master.AutoRedBar:Show()
	else
		self.master.AutoBar:Hide()
		self.master.AutoRedBar:Hide()
	end

	self:SetPosition()
end

function ShotAssist:BorderBackground()
	local borderstyle = self.db.profile.borderStyle
	local color = self.Borders[borderstyle]
	
	self.master:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground", 
		tile = true, 
		tileSize = 16,
		edgeFile = self.Borders[borderstyle].texture,
		edgeSize = self.Borders[borderstyle].size,
		insets = {
			left = self.Borders[borderstyle].insets, 
			right = self.Borders[borderstyle].insets, 
			top = self.Borders[borderstyle].insets, 
			bottom = self.Borders[borderstyle].insets
		},
	})
	
	self.master:SetBackdropColor(color.bc.r,color.bc.g,color.bc.b,color.bc.a)
	self.master:SetBackdropBorderColor(color.bbc.r,color.bbc.g,color.bbc.b,color.bbc.a)
end

function ShotAssist:OnCasting()
	if active then
		local currentTime = GetTime()
		local autoRemain = autoEnd - currentTime
	
		if (gcdEnd < currentTime) then gcdEnd = currentTime end
		if ( msEnd < currentTime) then  msEnd = currentTime end
		if ( asEnd < currentTime) then  asEnd = currentTime end
		if (autoEnd < currentTime) then  autoEnd = currentTime end
	
		-- todo hardcoding in quiver bonus since that doesn't show up in ranged haste
		local hasteMultiplier = 1 / (1 + GetRangedHaste() / 100) / quiverSpeed
		local ssCastTime =  1.5 * hasteMultiplier
	
		-- current hasted auto timer
		local autoCastTime = UnitRangedDamage("player")
		
		local nextAction = ""
		local nextActionTime = 0
		local nextIcon = 0

		local autoIcon = 132369
		local asIcon = 132218
		local msIcon = 132330
		local ssIcon = 132213

		local acceptableDelay = ShotAssist.db.profile.delay

		--todo is ms cast time actually affected by haste?
		local msCastTime = 0.5 * hasteMultiplier
		local asCastTime = 0.1
	
		-- above 1.83 - french 5:5:1:1
		-- above 1.63 - 5:6:1:!
		-- above 1.24 - 1:1 substitue MS > SS 
		-- above 1.06: 5:9:1:1
		-- above .85 2:3
		-- above .69 1:2
		-- else 2:5 
	
		local msOrGCD, asOrGCD 
		if (msEnd < gcdEnd) then msOrGCD = gcdEnd else msOrGCD = msEnd end
		if (asEnd < gcdEnd) then asOrGCD = gcdEnd else asOrGCD = asEnd end
	
		
		--to use the same shot recommendation logic we can't use what's passed in
		local currentTimeInt
	
		if castingEndTime then
			--if we are currently casting, switch the display to start thinking about your next action
			currentTimeInt = castingEndTime
		else
			currentTimeInt = currentTime
		end 
	
		--main shot recommendation engine
		-- if (gcdEnd <= currentTimeInt) then
		-- 	--we're off gcd and could fire now
		-- 	if( autoRemain > ssCastTime - acceptableDelay) then
		-- 		-- we have time to cast SS
		-- 		nextAction = ssName
		-- 		nextActionTime = currentTimeInt
		-- 	else
		-- 		if( autoEnd > msOrGCD + msCastTime - acceptableDelay) then
		-- 			--when multi is off CD we can fire without delaying auto appreciably
		-- 			nextAction = msName
		-- 			nextActionTime = msOrGCD
		-- 		elseif( autoEnd > asOrGCD + asCastTime - acceptableDelay) then
		-- 			nextAction = asName
		-- 			nextActionTime = asOrGCD
		-- 		else
		-- 			-- either nothing off CD or we are just about to auto
		-- 			nextAction = ssName
		-- 			nextActionTime = autoEnd
		-- 		end
		-- 	end
		--else
		if (gcdEnd < autoEnd) then
			--we'll be able to fire something before auto shot
			local windowToFire = 0
			if (gcdEnd <= currentTimeInt) then
				windowToFire = autoRemain
			else
				windowToFire = autoEnd - gcdEnd
			end

			if ( windowToFire > ssCastTime - acceptableDelay ) then
				-- we can fire a SS with only minimal delays
				if( (autoCastTime <= 1.63) and ( autoEnd > msOrGCD + msCastTime - acceptableDelay) ) then
					-- we are hasted and should be prio'ing MS
					nextAction = msName
					nextActionTime = msOrGCD
					nextIcon = msIcon
				else
					nextAction = ssName
					nextActionTime = gcdEnd
					nextIcon = ssIcon
				end
			else
				if( autoEnd > msOrGCD + msCastTime - acceptableDelay) then
					--when multi is off CD and we are out of GCD we can fire without delaying auto appreciably
					nextAction = msName
					nextActionTime = msOrGCD
					nextIcon = msIcon
				elseif( autoEnd > asOrGCD + asCastTime - acceptableDelay) then
					nextAction = asName
					nextActionTime = asOrGCD
					nextIcon = asIcon
				else
					-- either nothing off CD or we are just about to auto
					nextAction = ssName
					nextActionTime = autoEnd 
					nextIcon = ssIcon
				end
			end
		else
			--no time to fire before next auto
			local nextAutoEnd = autoEnd + autoCastTime
			-- is my gcd going to encompass next auto as well? ie extreme haste
			if (gcdEnd < nextAutoEnd) then
				--no, can potentially cast before the following auto
				local windowToFire = autoEnd + autoCastTime - gcdEnd
				if ( windowToFire > ssCastTime - acceptableDelay ) then
					if( (autoCastTime <= 1.63) and ( nextAutoEnd > msOrGCD + msCastTime - acceptableDelay) ) then
						nextAction = msName
						nextActionTime = msOrGCD
						nextIcon = msIcon
					else
						nextAction = ssName
						nextActionTime = gcdEnd
						nextIcon = ssIcon
					end
				else
					if( nextAutoEnd > msOrGCD + msCastTime - acceptableDelay) then
						--when multi is off CD and we are out of GCD we can fire without delaying auto appreciably
						nextAction = msName
						nextActionTime = msOrGCD
						nextIcon = msIcon
					elseif( nextAutoEnd > asOrGCD + asCastTime - acceptableDelay) then
						nextAction = asName
						nextActionTime = asOrGCD
						nextIcon = asIcon
					else
						-- either nothing off CD or we are just about to auto
						nextAction = ssName
						nextActionTime = nextAutoEnd
						nextIcon = ssIcon
					end
				end
	
			else 
				-- extreme haste going to be double auto
				--todo perhaps allow for some delay here?
	
				nextAction = autoName
				nextActionTime = autoEnd + autoCastTime
				nextIcon = autoIcon
			end
		end


	
		-- cheat to print once every 100 ms
		if ( currentTime - lastPrint > 0.1) then
			lastPrint = currentTime
			-- DEFAULT_CHAT_FRAME:AddMessage("gcd " .. string.format( "%.1f", gcdEnd - currentTime) .. " ms " .. string.format( "%.1f", msEnd - currentTime) .. " as "  .. string.format( "%.1f", asEnd - currentTime)  .. " auto "  .. string.format( "%.1f", autoEnd - currentTime) .. " last "  .. string.format( "%.1f", lastActionEnd - currentTime))
		end
	
		local timeToAction = nextActionTime - currentTime
		local color

		if (nextActionTime < currentTime) then  nextActionTime = currentTime end
	
		if (timeToAction <= ShotAssist.db.profile.now ) then
			color = ShotAssist.db.profile.colors.now
		elseif (timeToAction <= ShotAssist.db.profile.soon) then
			color = ShotAssist.db.profile.colors.soon
		else
			color = ShotAssist.db.profile.colors.wait
		end
	
		ShotAssist.master.Bar:SetStatusBarColor( color.r, color.g, color.b ) 
	
	
		--bar runs from 0 -> 1.  0 = lastActionEnd, 1 = nextActionTime
		local barProgPercent
		
		if (nextActionTime == lastActionEnd) then
			barProgPercent = 1
		else
			barProgPercent = (( currentTime - lastActionEnd ) / ( nextActionTime - lastActionEnd )) 
		end

		if barProgPercent > 1 then barProgPercent = 1 elseif barProgPercent < 0 then barProgPercent = 0 end
	
		ShotAssist.master.Bar:SetValue( barProgPercent )	
		ShotAssist.master.Spark:SetPoint("CENTER", ShotAssist.master.Bar, "LEFT", barProgPercent * ShotAssist.db.profile.width, 0)
		ShotAssist.master.Spell:SetText(nextAction)
		ShotAssist.master.Icon:SetTexture(nextIcon)
	
		ShotAssist.master.Time:SetText(string.format( "%.1f", ( nextActionTime - currentTime )) )
		
		local autoProgPercent = (( currentTime - autoStart ) / ( autoEnd - autoStart )) 
	
		if autoProgPercent > 1 then autoProgPercent = 1 elseif autoProgPercent < 0 then autoProgPercent = 0 end
	
		ShotAssist.master.AutoBar:SetValue( autoProgPercent )	
		ShotAssist.master.AutoSpark:SetPoint("CENTER", ShotAssist.master.AutoBar, "LEFT", autoProgPercent * ShotAssist.db.profile.width, 0)
		ShotAssist.master.AutoTime:SetText(string.format( "%.1f", ( autoEnd - currentTime )) )
	

		if ( autoEnd - currentTime ) < .5 then 
			ShotAssist.master.AutoBar:SetStatusBarColor( ShotAssist.db.profile.colors.stop.r, ShotAssist.db.profile.colors.stop.g, ShotAssist.db.profile.colors.stop.b, ShotAssist.db.profile.colors.stop.a ) 
 		end	

		-- local gcdProgPercent = ( 1.5 - (gcdEnd - currentTime) ) / 1.5
	
		-- if gcdProgPercent > 1 then gcdProgPercent = 1 elseif gcdProgPercent < 0 then gcdProgPercent = 0 end
	
		-- if gcdProgPercent == 1 then 
		-- 	ShotAssist.master.GCDBar:SetStatusBarColor( ShotAssist.db.profile.colors.now.r, ShotAssist.db.profile.colors.now.g, ShotAssist.db.profile.colors.now.b, 0.5 ) 
		-- else
		-- 	ShotAssist.master.GCDBar:SetStatusBarColor( ShotAssist.db.profile.colors.wait.r, ShotAssist.db.profile.colors.wait.g, ShotAssist.db.profile.colors.wait.b, 0.5 ) 
 		-- end	

		-- ShotAssist.master.GCDBar:SetValue( gcdProgPercent )	
		-- ShotAssist.master.GCDSpark:SetPoint("CENTER", ShotAssist.master.GCDBar, "LEFT", gcdProgPercent * ShotAssist.db.profile.width, 0)
		-- ShotAssist.master.GCDTime:SetText(string.format( "%.1f", ( gcdEnd - currentTime )) )
	else
		ShotAssist.master:Hide()
	end
end
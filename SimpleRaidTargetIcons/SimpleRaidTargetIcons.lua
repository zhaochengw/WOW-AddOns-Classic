-- Simple Raid Target Icons
--
--------------------------------
--                            --
-- Concept originally by Qzot --
--                            --
--------------------------------

local addonName, srti = ...
srti.version = GetAddOnMetadata("simpleraidtargeticons","version")
local L = srti.L
local is_classic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
local is_classic_bc = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)
local is_classic_wrath = (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC)
local SRTI_TITLE = addonName

local SRTI_HEADER = SRTI_TITLE .. " " .. srti.version
local SRTI_MSG_HELP_TEXT = SRTI_HEADER .. L[" - %0/srti\n no command opens the options menu\n commands to set icon on target"]
BINDING_HEADER_SRTI_TITLE = SRTI_TITLE
BINDING_NAME_SRTI_SHOW = L["Show Radial Menu"]
BINDING_NAME_SRTI_MOUSEOVER = L["Mouseover Mark CC"]
BINDING_NAME_SRTI_MOUSEOVER_CLEAR = L["Mouseover Clear Marks"]
BINDING_NAME_SRTI_MARKORDER = L["CC TargetBar"]
BINDING_NAME_SRTI_STAR = L["Yellow Star Icon"]
BINDING_NAME_SRTI_CIRCLE = L["Orange Circle Icon"]
BINDING_NAME_SRTI_DIAMOND = L["Purple Diamond Icon"]
BINDING_NAME_SRTI_TRIANGLE = L["Green Triangle Icon"]
BINDING_NAME_SRTI_MOON = L["Silver Moon Icon"]
BINDING_NAME_SRTI_SQUARE = L["Blue Square Icon"]
BINDING_NAME_SRTI_CROSS = L["Red Cross Icon"]
BINDING_NAME_SRTI_SKULL = L["White Skull Icon"]
BINDING_NAME_SRTI_TARSTAR = L["Target Star"]
BINDING_NAME_SRTI_TARCIRCLE = L["Target Circle"]
BINDING_NAME_SRTI_TARDIAMOND = L["Target Diamond"]
BINDING_NAME_SRTI_TARTRIANGLE = L["Target Triangle"]
BINDING_NAME_SRTI_TARMOON = L["Target Moon"]
BINDING_NAME_SRTI_TARSQUARE = L["Target Square"]
BINDING_NAME_SRTI_TARCROSS = L["Target Cross"]
BINDING_NAME_SRTI_TARSKULL = L["Target Skull"]
BINDING_NAME_SRTI_CLEAR = L["Remove Icon"]

local iconStrings = {
	none = 0,
	clear = 0,
	remove = 0,
	yellow = 1,
	star = 1,
	orange = 2,
	circle = 2,
	purple = 3,
	diamond = 3,
	green = 4,
	triangle = 4,
	silver = 5,
	moon = 5,
	blue = 6,
	square = 6,
	red = 7,
	x = 7,
	cross = 7,
	white = 8,
	skull = 8,
}

local iconCStrings = {
	[iconStrings.skull] 		= L["%s|cffffffffSkull|r"],
	[iconStrings.cross] 		= L["%s|cffFF4500Cross|r"],
	[iconStrings.square] 		= L["%s|cff00BFFFSquare|r"],
	[iconStrings.moon] 			= L["%s|cffc7c7cfMoon|r"],
	[iconStrings.triangle] 	= L["%s|cff7CFC00Triangle|r"],
	[iconStrings.diamond] 	= L["%s|cffff00ffDiamond|r"],
	[iconStrings.circle] 		= L["%s|cffff8000Circle|r"],
	[iconStrings.star] 			= L["%s|cffffff00Star|r"],
}

local iconNames = {
	L["remove icon"],
	L["yellow star"],
	L["orange circle"],
	L["purple diamond"],
	L["green triangle"],
	L["silver moon"],
	L["blue square"],
	L["red cross"],
	L["white skull"],
}

local thirdParty = {
	"PugLax",
}
local thirdPartyFrameScripts = {}

local marksCol = {
	{1},{1,2},{1,2,3},{1,2,3,4},
	{1,2,3,4,5},{1,2,3,4,5,6},{1,2,3,4,5,6,7},
	{1,2,3,4,5,6,7,8},
	{8},{8,7},{8,7,6},{8,7,6,5},
	{8,7,6,5,4},{8,7,6,5,4,3},{8,7,6,5,4,3,2},
	{8,7,6,5,4,3,2,1}
}

local party, raid = {}, {}
local playerName = (UnitName("player"))
local CC_ClassCount = {}
do
	for i=1,MAX_PARTY_MEMBERS do
		party[i] = {}
		party[i].unit = "party"..i
		party[i].target = "party"..i.."target"
	end
	for i=1,MAX_RAID_MEMBERS do
		raid[i] = {}
		raid[i].unit = "raid"..i
		raid[i].target = "raid"..i.."target"
	end
end

local clickFrameScripts = {}
local clickFrames
if is_classic then
	clickFrames = {
	"WorldFrame",
	"TargetFrame",
	"PartyMemberFrame1",
	"PartyMemberFrame2",
	"PartyMemberFrame3",
	"PartyMemberFrame4"}
else
	clickFrames = {
	"WorldFrame",
	"TargetFrame",
	"FocusFrame",
	"Boss1TargetFrame",
	"Boss2TargetFrame",
	"Boss3TargetFrame",
	"Boss4TargetFrame",
	"Boss5TargetFrame",}
end

function srti.Print(msg)
	for text in string.gmatch(msg, "[^\n]+") do
		text = string.gsub(text,"%%1","|cffffcc00")
		text = string.gsub(text,"%%0(%S+)","|cff9999ff%1|r")
		DEFAULT_CHAT_FRAME:AddMessage(text,0.7,0.7,0.7)
	end
end

local function print(msg)
	srti.Print(msg)
end

local function camelCase(word)
  return string.gsub(word,"(%a)([%w_']*)",function(head,tail)
    return string.format("%s%s",string.upper(head),string.lower(tail))
    end)
end

function srti.PrintHelp()
	print(SRTI_MSG_HELP_TEXT)
	for i=0, 8 do
		local text = ""
		for string, index in pairs(iconStrings) do
			if ( index == i ) then
				text = text.." / %0"..string
			end
		end

		print("  %0"..i..text.." - %1"..iconNames[i+1])
	end
end

srti.defaults = {
	["ctrl"] = true,
	["alt"] = false,
	["shift"] = false,
	["singlehover"] = false,

	["double"] = true,
	["speed"] = 0.25,
	["radialscale"] = 1.0,
	["doublehover"] = false,

	["bindinghover"] = false,

	["hovertime"] = 0.2,
}

-- srti.frame
-- the main menu frame and event catcher

srti.frame = CreateFrame("button", "SRTIRadialMenu", UIParent)

srti.frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
srti.frame:RegisterEvent("ADDON_LOADED")
srti.frame:RegisterEvent("PLAYER_LOGIN")
srti.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
srti.frame:RegisterEvent("GROUP_ROSTER_UPDATE")
srti.frame:RegisterEvent("RAID_ROSTER_UPDATE")
srti.frame:RegisterEvent("PLAYER_TARGET_CHANGED")
srti.frame:RegisterEvent("NAME_PLATE_CREATED")
srti.frame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
srti.frame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
local GetNamePlateForUnit = C_NamePlate.GetNamePlateForUnit
srti.frame.plate_cache = {}
srti.frame.plateunit_cache = {}

srti.frame:SetFrameStrata("DIALOG")

srti.frame:SetWidth(100)
srti.frame:SetHeight(100)
srti.frame:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", 0, 0 )
srti.frame:SetClampedToScreen(true)

srti.frame:Hide()
srti.frame.origShow = srti.frame.Show

srti.cursorFrame = CreateFrame("Frame","SRTICursorCompanionFrame",UIParent)
srti.cursorFrame:SetWidth(24)
srti.cursorFrame:SetHeight(24)
srti.cursorFrame.tex = srti.cursorFrame:CreateTexture("SRTICursorCompanionFrameTex","OVERLAY")
srti.cursorFrame.tex:SetWidth(24)
srti.cursorFrame.tex:SetHeight(24)
srti.cursorFrame.tex:SetPoint("CENTER",srti.cursorFrame,"CENTER",0,0)
srti.cursorFrame.tex:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
srti.cursorFrame.text = srti.cursorFrame:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
srti.cursorFrame.text:SetPoint("TOP",srti.cursorFrame,"BOTTOM",0,-2)
srti.cursorFrame:Hide()
srti.cursorFrame._lastUpdate = 0
srti.cursorFrame:SetScript("OnUpdate",function(self,elapsed)
		self._lastUpdate = self._lastUpdate + elapsed
		self._lastUpdate = 0
		local x,y = GetCursorPosition()
		local s = UIParent:GetEffectiveScale()
		self:ClearAllPoints()
		self:SetPoint("CENTER",UIParent,"BOTTOMLEFT",(x/s)+24,(y/s)-24)
	end)
function srti.ShowCursorCompanion(mark,mode)
	if (mark) then
		if mode == "mark" then
			srti.cursorFrame.text:SetText(string.format(iconCStrings[mark],L["Mark "]))
		elseif mode == "target" then
			srti.cursorFrame.text:SetText(string.format(iconCStrings[mark],L["Target "]))
		else
			srti.cursorFrame.text:SetText("")
		end
		SetRaidTargetIconTexture(srti.cursorFrame.tex,mark)
		srti.cursorFrame:Show()
	else
		srti.cursorFrame:Hide()
	end
end

srti.barFrame = CreateFrame("frame", "SRTIBarFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
srti.barFrame:SetWidth(182)
srti.barFrame:SetHeight(30)
srti.barFrame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 5, right = 3, top = 3, bottom = 5 }
		})
srti.barFrame:SetBackdropBorderColor(0, 0, 0)
srti.barFrame:SetBackdropColor(0.15, 0.15, 0.15)
srti.barFrame:SetClampedToScreen(true)
for i=8,1,-1 do
	local btnName = "SRTIBarFrameBtn"..i
	local btn = CreateFrame("CheckButton", btnName, srti.barFrame, "ActionButtonTemplate")
	btn:SetID(i)
	--btn:RegisterForClicks()
	btn.tex = _G[btnName.."Icon"]
	btn.border = _G[btnName.."Border"]
	btn.name = _G[btnName.."Name"]
	local fontpath--[[,fontheight,fontflags]] = btn.name:GetFont()
	btn.name:SetFont(fontpath,12,"THICKOUTLINE")
	btn.tex:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	SetRaidTargetIconTexture(btn.tex,i)
	btn.border:SetTexture("")
	btn:SetNormalTexture("")
	btn:SetCheckedTexture("")
	--btn:SetHighlightTexture("")
	btn.name:SetText(i)
	btn:SetScript("OnMouseDown", function(self,button)
			srti.barFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
			local mark = self:GetID()
			srti.TargetScan(mark)
			srti.ShowCursorCompanion(mark,"target")
		end)
	btn:SetScript("OnMouseUp", function(self,button)
			srti.barFrame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
			srti.scanTarget = nil
			srti.ShowCursorCompanion()
		end)
	btn:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self,"ANCHOR_BOTTOMRIGHT")
			GameTooltip:SetText(addonName)
			local markName = getglobal("RAID_TARGET_"..self:GetID())
			GameTooltip:AddDoubleLine(string.format(L["Click to target %s"],markName),L["Group Target Scan"],0,1,0,0.5,0.5,0.5)
			GameTooltip:AddDoubleLine(L["Drag icon over units."],string.format(L["Targets %s"],markName),0,1,0,0.5,0.5,0.5)
			GameTooltip:Show()
		end)
	btn:SetScript("OnLeave", function(self)
			if GameTooltip:IsOwned(self) then
				GameTooltip:ClearLines()
				GameTooltip:Hide()
			end
		end)
	btn:SetScript("OnHide", function(self)
			if GameTooltip:IsOwned(self) then
				GameTooltip:ClearLines()
				GameTooltip:Hide()
			end
			srti.ShowCursorCompanion()
		end)
	btn:SetWidth(20)
	btn:SetHeight(20)
	srti.barFrame[i] = btn
	if i == 8 then
		btn:SetPoint("LEFT",4,0)
	else
		btn:SetPoint("LEFT",srti.barFrame[(i+1)],"RIGHT",2,0)
	end
end
srti.barFrame:SetScript("OnEvent",function(self,event,...)
	if event == "UPDATE_MOUSEOVER_UNIT" and srti.scanTarget ~= nil then
		if UnitExists("mouseover") then
			local mark = GetRaidTargetIndex("mouseover")
			if mark and (mark == srti.scanTarget) then
				srti.Target("mouseover")
			end
		end
	end
end)
srti.barFrame:SetScript("OnHide", function(self)
	srti.scanTarget = nil
	srti.barFrame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
end)
srti.barFrame:Hide()

function srti.frame:Show()
	srti.frame.p = srti.frame:CreateTexture("SRTIRadialMenuPortrait","BORDER")
	srti.frame.p:SetWidth(40)
	srti.frame.p:SetHeight(40)
	srti.frame.p:SetPoint("CENTER", srti.frame, "CENTER", 0, 0 )
	srti.frame.b = srti.frame:CreateTexture("SRTIRadialMenuBorder", "BACKGROUND")
	srti.frame.b:SetTexture("Interface\\Minimap\\UI-TOD-Indicator")
	srti.frame.b:SetWidth(80)
	srti.frame.b:SetHeight(80)
	srti.frame:SetScale(SRTISaved.radialscale or 1.0)
	srti.frame.b:SetTexCoord(0.5,1,0,1)
	srti.frame.b:SetPoint("CENTER", srti.frame, "CENTER", 10, -10 )
	for i=1, 8 do
		srti.frame[i] = srti.frame:CreateTexture("SRTIRadialMenu"..i,"OVERLAY")
	end

	srti.frame:origShow()
	srti.frame.Show = srti.frame.origShow
	srti.frame.origShow = nil

	srti.frame:SetScript("OnUpdate",
		function(self, arg1)
			local portrait = srti.frame.portrait
			srti.frame.portrait = nil
			local saved, index = self.index, GetRaidTargetIndex("target")
			self.index = nil
			if ( self.test ) then
				index = srti.menu.test.index or 0
			end
			local curtime = GetTime()
			if ( not self.hiding ) then
				if ( self.test ) then
					SetPortraitTexture( srti.frame.p, "player" )
				elseif ( not UnitExists("target") or ( not UnitPlayerOrPetInRaid("target") and UnitIsDeadOrGhost("target") ) ) then
					if ( portrait ) then
						self:Hide()
						return
					else
						self.hiding = curtime
					end
				elseif ( portrait ) then
					if ( portrait == 0 and not (srti.mouseover or srti.nameplate) ) then
						self:Hide()
						return
					end
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
					SetPortraitTexture( srti.frame.p, "target" )
				end

				local x, y = GetCursorPosition()
				local s = srti.frame:GetEffectiveScale()
				local mx, my = srti.frame:GetCenter()
				x = x / s
				y = y / s

				local a, b = y - my, x - mx

				local dist = floor(math.sqrt( a*a + b*b ))

				if ( dist > 60 ) then
					if ( dist > 200 ) then
						self.lingering = nil
						self.hiding = curtime
						self.showinghowing = nil
						PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF, "SFX")
					elseif ( not self.lingering ) then
						self.lingering = curtime
					end
				else
					self.lingering = nil

					if ( dist > 20 and dist < 50 ) then
						local pos = math.deg(math.atan2( a, b )) + 27.5
						self.index = mod(11-ceil(pos/45),8)+1
					end
				end

				for i=1, 8 do
					local t = self[i]
					if ( index == i ) then
						t:SetTexCoord(0,1,0,1)
						t:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
					else
						-- check 3rd party modifications first
						local PugLax = IsAddOnLoaded("PugLax")
						if (PugLax and _G["PugLax"].CreateRaidIcon) and SRTISaved.PugLax then
							_G["PugLax"]:CreateRaidIcon(t,i)
						else
							t:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
							SetRaidTargetIconTexture(t,i)
						end
					end
				end

				if ( self.hovering ) then
					if ( self.index and ( not saved or saved == self.index ) ) then
						self.hovering = self.hovering + arg1
						if ( self.hovering > ( SRTISaved.hovertime or 0.2 ) ) then
							self:Click()
						end
					else
						self.hovering = 0
					end
				end
			end

			if ( self.showing ) then
				local status = curtime - self.showing
				if ( status > 0.1 ) then
					srti.frame.p:SetAlpha(1)
					srti.frame.b:SetAlpha(1)
					for i=1, 8 do
						local t, radians = self[i], (0.375 - i/8) * 360
						t:SetPoint("CENTER", self, "CENTER", 36*cos(radians), 36*sin(radians) )
						t:SetAlpha(0.5)
						t:SetWidth(18)
						t:SetHeight(18)
					end
					self.showing = nil
				else
					status = status / 0.1
					srti.frame.p:SetAlpha(status)
					srti.frame.b:SetAlpha(status)
					for i=1, 8 do
						local t, radians = self[i], (0.375 - i/8) * 360
						t:SetPoint("CENTER", self, "CENTER", (20*status + 16)*cos(radians), (20*status + 16)*sin(radians) )
						if ( i == index ) then
							t:SetAlpha(status)
						else
							t:SetAlpha(0.5*status)
						end
						t:SetWidth(9*status + 9)
						t:SetHeight(9*status + 9)
					end
				end
			elseif ( self.hiding ) then
				local status = curtime - self.hiding
				if ( status > 0.1 ) then
					self.hiding = nil
					self:Hide()
				else
					status = 1 - status / 0.1
					srti.frame.p:SetAlpha(status)
					srti.frame.b:SetAlpha(status)
					for i=1, 8 do
						local t, radians = self[i], (0.375 - i/8) * 360
						if ( self.index == i ) then
							t:SetWidth(36-18*status)
							t:SetHeight(36-18*status)
							t:SetAlpha(min(4*status,1))
						else
							t:SetPoint("CENTER", self, "CENTER", (20*status + 16)*cos(radians), (20*status + 16)*sin(radians) )
							t:SetAlpha(0.75*status)
							t:SetWidth(18*status)
							t:SetHeight(18*status)
						end
					end
				end
			else
				for i=1, 8 do
					local t = self[i]
					if ( i == index ) then
						t:SetAlpha(1)
					else
						t:SetAlpha(0.75)
					end
					t:SetWidth(18)
					t:SetHeight(18)
				end
			end

			if ( self.index ) then
				local t = self[self.index]
				local alpha, width = t:GetAlpha(), t:GetWidth()

				if ( not self.time or saved ~= self.index ) then
					self.time = curtime
				end
				local s = 1 + min( (curtime - self.time)/0.05, 1 )

				t:SetAlpha(min(alpha+0.125*s,1))
				t:SetWidth(width*s)
				t:SetHeight(width*s)
			end

			if ( self.lingering ) then
				local status = curtime - self.lingering
				if ( status > 0.75 ) then
					self.hiding = curtime
					self.lingering = nil
					self.showing = nil
					self.index = nil
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF, "SFX")
				end
			end
		end)

	srti.frame:SetScript("OnClick", function(self,arg1)
			if ( not self.hiding ) then
				local index = GetRaidTargetIndex("target")
				if ( self.test ) then
					index = srti.menu.test.index
				end
				if ( ( arg1 == "RightButton" and index and index > 0 ) or ( self.index and self.index > 0 and self.index == index ) ) then
					self.index = index
					PlaySound(SOUNDKIT.IG_MINIMAP_ZOOM_OUT, "SFX")
					srti.SetRaidTarget(0)
				elseif ( self.index ) then
					PlaySound(SOUNDKIT.IG_MINIMAP_ZOOM_IN, "SFX")
					srti.SetRaidTarget(self.index)
				else
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF, "SFX")
				end
				self.showing = nil
				self.hiding = GetTime()
			end
		end
		)
end

function srti.UpdateSaved()
	if ( not SRTISaved ) then
		SRTISaved = {}
	end
	for k, v in pairs(srti.defaults) do
		if ( SRTISaved[k] == nil ) then
			SRTISaved[k] = v
		end
	end
	if SRTISaved.thirdPartyFrames and next(SRTISaved.thirdPartyFrames) then -- clean up v1.2 structure if found
		SRTISaved.thirdPartyFrames = nil
	end
	SRTIExternalUF = SRTIExternalUF or {}
	srti.Options()
	srti.saved = SRTISaved
end

local thirdPartyUF
if is_classic or is_classic_bc or is_classic_wrath then
	thirdPartyUF = {
		["Blizzard_CompactRaidFrames"] = {},
		["PitBull4"] = {"PitBull4_Frames_Target","PitBull4_Frames_Target's target"}, -- OK
		["Aptechka"] = {}, -- OK
		["ElvUI"] = {"ElvUF_Target"}, -- OK
		["Grid2"] = {}, -- OK, needs testing for non-group layouts
		["IGAS_UI"] = {"IGAS_UI_PlayerFrame","IGAS_UI_TargetFrame"}, -- OK
		["KkthnxUI"] = {"oUF_Target"}, -- OK, missing raid
		["LunaUnitFrames"] = {"LUFUnittarget"}, -- OK
		["Perl_Config"] = {"Perl_Target_Frame"}, -- OK
		["Plexus"] = {}, -- OK
		["RUF"] = {"oUF_RUF_Target"}, -- OK
		["ShadowedUnitFrames"] = {"SUFUnittarget"}, -- OK
		["Tukui"] = {"TukuiTargetFrame"}, -- OK
		["ZPerl"] = {"XPerl_Target"}, -- OK
	}
	for i=1,MAX_PARTY_MEMBERS do
		local uf_pitbull = "PitBull4_Groups_PartyUnitButton"..i
		local uf_pitbull_target = "PitBull4_Groups_Party TargetsUnitButton"..i
		table.insert(thirdPartyUF.PitBull4,uf_pitbull)
		table.insert(thirdPartyUF.PitBull4,uf_pitbull_target)
		local uf_igasui = "IGAS_UI_PartyMemberFrame"..i
		table.insert(thirdPartyUF.IGAS_UI,uf_igasui)
		local uf_kkthx = "oUF_PartyUnitButton"..i
		table.insert(thirdPartyUF.KkthnxUI,uf_kkthx)
		local uf_luf = "LUFHeaderpartyUnitButton"..i
		table.insert(thirdPartyUF.LunaUnitFrames,uf_luf)
		local uf_perl = "Perl_Party_MemberFrame"..i
		table.insert(thirdPartyUF.Perl_Config,uf_perl)
		local uf_ruf = "oUF_RUF_PartyUnitButton"..i
		table.insert(thirdPartyUF.RUF,uf_ruf)
		local uf_shadowed = "SUFHeaderpartyUnitButton"..i
		table.insert(thirdPartyUF.ShadowedUnitFrames,uf_shadowed)
		local uf_zperl = "XPerl_party"..i
		table.insert(thirdPartyUF.ZPerl,uf_zperl)
		local uf_elvui = "ElvUF_PartyGroup1UnitButton"..i
		table.insert(thirdPartyUF.ElvUI,uf_elvui)
	end
	for i=1,MAX_RAID_MEMBERS do
		local uf_pitbull = "PitBull4_Groups_RaidUnitButton"..i
		table.insert(thirdPartyUF.PitBull4,uf_pitbull)
		local uf_igasui = "iRaidUnitFrame"..i
		table.insert(thirdPartyUF.IGAS_UI,uf_igasui)
		local uf_blizzard = "CompactRaidFrame"..i
		table.insert(thirdPartyUF.Blizzard_CompactRaidFrames,uf_blizzard)
		local uf_tukui = "TukuiRaidUnitButton"..i
		table.insert(thirdPartyUF.Tukui,uf_tukui)
	end
	for i=1,10 do
		local uf_pitbull = "PitBull4_Groups_TankUnitButton"..i
		local uf_pitbull_target = "PitBull4_Groups_Tank TargetsUnitButton"..i
		table.insert(thirdPartyUF.PitBull4,uf_pitbull)
		table.insert(thirdPartyUF.PitBull4,uf_pitbull_target)
	end
	for i=1,8 do
		for k=1,5 do
			local uf_aptechka = "NugRaid"..i.."UnitButton"..k
			table.insert(thirdPartyUF.Aptechka,uf_aptechka)
			local uf_blizzard = "CompactRaidGroup"..i.."Member"..k
			table.insert(thirdPartyUF.Blizzard_CompactRaidFrames,uf_blizzard)
			local uf_grid2 = "Grid2LayoutHeader"..i.."UnitButton"..k
			table.insert(thirdPartyUF.Grid2,uf_grid2)
			local uf_luf = "LUFHeaderraid"..i.."UnitButton"..k
			table.insert(thirdPartyUF.LunaUnitFrames,uf_luf)
			local uf_plexus = "PlexusLayoutHeader"..i.."UnitButton"..k
			table.insert(thirdPartyUF.Plexus,uf_plexus)
			local uf_zperl = "XPerl_Raid_Grp"..i.."UnitButton"..k
			table.insert(thirdPartyUF.ZPerl,uf_zperl)
			local uf_elvui = "ElvUF_RaidGroup"..i.."UnitButton"..k
			table.insert(thirdPartyUF.ElvUI,uf_elvui)
			local uf_elvui40 = "ElvUF_Raid40Group"..i.."UnitButton"..k
			table.insert(thirdPartyUF.ElvUI,uf_elvui40)
		end
	end
else
	thirdPartyUF = {
	["XPerl"] = {"XPerl_Target","XPerl_Focus","XPerl_TargetTarget"},
	["Perl_Config"] = {"Perl_Target_NameFrame_CastClickOverlay","Perl_Target_StatsFrame_CastClickOverlay","Perl_Focus_NameFrame_CastClickOverlay",
		"Perl_Focus_StatsFrame_CastClickOverlay","Perl_Target_Target_StatsFrame_CastClickOverlay","Perl_Target_Target_NameFrame_CastClickOverlay"},
	["PitBull4"] = {"PitBull4_Frames_Target","PitBull4_Frames_Target's target","PitBull4_Frames_focus","PitBull4_Frames_focustarget"},
	["ShadowedUnitFrames"] = {"SUFUnittarget","SUFUnittargettarget","SUFUnitfocus","SUFUnitfocustarget"},
	["Stuf"] = {"Stuf.units.target","Stuf.units.focus","Stuf.units.targettarget"},
}
end
srti.frame:SetScript("OnEvent", function(self,event,...)
	if ( event == "ADDON_LOADED" ) then
		local addon = ...
		if addon == addonName then
			srti.UpdateSaved()
		end
		if thirdPartyUF[addon] then
			srti.RegisterExternalUFPrebuilt()
		end
		if SRTIExternalUF[strlower(addon)] then
			srti.AddExternalFrameScripts()
		end
	elseif ( event == "PLAYER_LOGIN" or event == "PLAYER_ENTERING_WORLD" ) then
		srti.RegisterExternalUFPrebuilt()
		srti.AddExternalFrameScripts()
		srti.UpdateClassCount()
		self:UnregisterEvent("PLAYER_LOGIN")
	elseif ( event == "GROUP_ROSTER_UPDATE" or event == "RAID_ROSTER_UPDATE" ) then
		srti.UpdateClassCount()
		srti.RegisterExternalUFPrebuilt()
	elseif ( event == "UPDATE_MOUSEOVER_UNIT" ) then
		srti.MassMark()
	elseif ( event == "NAME_PLATE_CREATED" ) then
		local plate = ...
		local unitid = plate:GetName()
		self.plate_cache[plate] = unitid
		self.plateunit_cache[unitid] = plate
	elseif ( event == "NAME_PLATE_UNIT_ADDED" ) then
		local unitid = ...
		local plate = GetNamePlateForUnit(unitid)
		self.plate_cache[plate] = unitid
		self.plateunit_cache[unitid] = plate
	elseif ( event == "NAME_PLATE_UNIT_REMOVED" ) then
		local unitid = ...
		local cached_plate = self.plateunit_cache[unitid]
		if cached_plate then
			self.plate_cache[cached_plate] = nil
			self.plateunit_cache[unitid] = nil
		end
	else
		if ( self:IsVisible() and not self.exists and not self.hiding ) then
			self.index = nil
			self.showing = nil
			self.hiding = GetTime()
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF, "SFX")
			self.exists = nil
		elseif ( self.exists ) then
			self.exists = nil
		end
	end
end
)

function srti.ShowFromBinding()
	if ( not srti.frame:IsVisible() ) then
		local hovering = nil
		if ( SRTISaved.bindinghover ) then
			hovering = 0
		end
		if ( srti.menu and srti.menu:IsVisible() ) then
			srti.menu.test.ShowRadial(hovering)
		else
			srti.frame.hovering = hovering
			srti.Show(1)
		end
	end
end

function srti.Show(frombinding)
	if SRTISaved.debug == nil then
		if IsInRaid() and not (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or IsEveryoneAssistant()) then
			return
		end
	end

	srti.frame.showing = GetTime()
	srti.frame.hiding = nil
	srti.frame.index = nil
	srti.frame.lingering = nil
	srti.frame.test = nil

  if ( UnitExists("target") ) then
    if ( frombinding ) then
		  srti.frame.exists = nil
	  else
      srti.frame.exists = 1
    end
  else
	  return
	end
	srti.frame.portrait = frombinding or 0
	local x,y = GetCursorPosition()
	local s = srti.frame:GetEffectiveScale()
	srti.frame:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", x/s, y/s )
	srti.frame:Show()
end

function srti.IsNameplateUnderMouse()
	if not srti.plate_cache then return end
	for plate,status in pairs(srti.plate_cache) do
		if status and MouseIsOver(plate) then
			return true
		end
	end
	return nil
end

function srti.AreModifiersDown()
	if ( not SRTISaved.ctrl and not SRTISaved.alt and not SRTISaved.shift ) then
		return
	elseif ( SRTISaved.ctrl and IsControlKeyDown() ) then
		return 1
	elseif ( SRTISaved.alt and IsAltKeyDown() ) then
		return 1
	elseif ( SRTISaved.shift and IsShiftKeyDown() ) then
		return 1
	end
	return false
end

local origSetRaidTarget = SetRaidTarget
function srti.SetRaidTarget(index,unit,fromBinding)
	index = index or 0
	if ( srti.frame.test ) then
		if ( index == 0 ) then
			srti.menu.test.icon:Hide()
			srti.menu.test.index = nil
		else
			srti.menu.test.icon:Show()
			srti.menu.test.index = index
			SetRaidTargetIconTexture(srti.menu.test.icon,index)
		end
		return
	end

	if ( srti.frame:IsVisible() ) then
		srti.frame.i = index
		srti.frame:Click()
	end
	if ( not fromBinding ) then
		origSetRaidTarget("target", index)
	end
end
hooksecurefunc("SetRaidTarget",function(unit,index) srti.SetRaidTarget(index,unit,1) end)

do
	for _,frameName in pairs(clickFrames) do
		clickFrameScripts[frameName] = _G[frameName]:GetScript("OnMouseUp")
		if not clickFrameScripts[frameName] and _G[frameName]:IsObjectType("Button") then
			_G[frameName]:RegisterForClicks("AnyUp")
		end
		_G[frameName]:SetScript("OnMouseUp", function(self,arg1) srti.OnMouseUp(self,arg1) end)
	end
end

do
	for _,frameName in pairs(clickFrames) do
		clickFrameScripts[frameName] = _G[frameName]:GetScript("OnMouseDown")
		if not clickFrameScripts[frameName] and _G[frameName]:IsObjectType("Button") then
			_G[frameName]:RegisterForClicks("AnyDown")
		end
		_G[frameName]:SetScript("OnMouseDown", function(self,arg1) srti.OnMouseDown(self,arg1) end)
	end
end

function srti.AddExternalFrameScripts()
	SRTIExternalUF = SRTIExternalUF or {}
	for addon, frames in pairs(SRTIExternalUF) do
		for i,frameName in ipairs(frames) do
			if _G[frameName] then
				if not thirdPartyFrameScripts[frameName] then
					local mouseUp = _G[frameName]:GetScript("OnMouseUp")
					if not mouseUp and _G[frameName]:IsObjectType("Button") then
						_G[frameName]:RegisterForClicks("AnyUp")
					end
					local mouseDown = _G[frameName]:GetScript("OnMouseDown")
					if not mouseDown and _G[frameName]:IsObjectType("Button") then
						_G[frameName]:RegisterForClicks("AnyDown")
					end
					_G[frameName]:SetScript("OnMouseUp", function(self,arg1) srti.OnMouseUp(self,arg1) end)
					_G[frameName]:SetScript("OnMouseDown", function(self,arg1) srti.OnMouseDown(self,arg1) end)
					thirdPartyFrameScripts[frameName] = true
					clickFrameScripts[frameName] = mouseUp
				end
			end
		end
	end
end

function srti.RegisterExternalUFPrebuilt()
	SRTIExternalUF = SRTIExternalUF or {}
	for addon, frames in pairs(thirdPartyUF) do
		for i, frameName in ipairs(frames) do
			srti.RegisterExternalFrame(frameName,addon,true)
		end
	end
end

function srti.RegisterExternalFrame(frameName, addon, prebuilt)
	-- validate
	local frameName = frameName or GetMouseFocus():GetName()
	if not frameName or not _G[frameName] or not _G[frameName]:IsMouseEnabled() then return end -- no frame, not a global frame or not mouse enabled
	if tContains(clickFrames,frameName) then return end
	if (not prebuilt) and (not UnitExists("mouseover")) then return end -- no mouseover unit, so probably not a unitframe at all
	-- check if already stored
	SRTIExternalUF = SRTIExternalUF or {}
	local found
	for addon, frames in pairs(SRTIExternalUF) do
		for i,frame in ipairs(frames) do
			if frame == frameName then
				found = true
				break
			end
		end
	end
	if found then return end
	-- check if addon to save frames under is loaded
	if addon and IsAddOnLoaded(strlower(addon)) then
		SRTIExternalUF[strlower(addon)] = SRTIExternalUF[strlower(addon)] or {}
		tinsert(SRTIExternalUF[strlower(addon)], frameName)
		srti.AddExternalFrameScripts()
		return
	end
	if not addon then
		-- static dialog to ask user to enter addonName
		StaticPopupDialogs["SRTI_GET_ADDON_NAME"] = StaticPopupDialogs["SRTI_GET_ADDON_NAME"] or {
			preferredIndex = 3,
			text = YELLOW_FONT_COLOR_CODE.."SRTI"..FONT_COLOR_CODE_CLOSE.."\nSelect the addon "..GREEN_FONT_COLOR_CODE.."%s"..FONT_COLOR_CODE_CLOSE.." belongs to.\nNavigate to your \\Interface\\AddOns\\ folder and check for Addon Name.",
			button1 = ACCEPT,
			button2 = CANCEL,
			hasEditBox = true,
			EditBoxOnEnterPressed = function(self) return self:GetParent().button1:Click() end,
			EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
			whileDead = true,
			hideOnEscape = true,
			timeout = 0,
			OnAccept = function(self,data)
				local addon = self.editBox:GetText()
				if addon and not IsAddOnLoaded(strlower(addon)) then
					srti.Print("No "..RED_FONT_COLOR_CODE..addon..FONT_COLOR_CODE_CLOSE.." addon found!")
					return true
				end
				if frameName and addon then
 					srti.RegisterExternalFrame(frameName, addon)
 				end
			end,
			OnShow = function(self,data)
				self.editBox:SetText(frameName)
			end,
		}
 		StaticPopup_Show("SRTI_GET_ADDON_NAME", frameName)
	end
end

function srti.OnMouseUp(frame, btn)
	local frameName = frame.GetName and frame:GetName() or ""
	if ( btn == "LeftButton" ) then
		local curtime = GetTime()
		local x, y = GetCursorPosition()
		local modifiers = srti.AreModifiersDown()
 		srti.nameplate = srti.IsNameplateUnderMouse()
		local double = ( SRTISaved.double and srti.click and curtime - srti.click < (SRTISaved.speed or 0.25) and abs(x-srti.clickX) < 20 and abs(y-srti.clickY) < 20 )
		if ( modifiers or double ) then
			if ( ( modifiers and SRTISaved.singlehover ) or ( double and SRTISaved.doublehover ) ) then
				srti.frame.hovering = 0
			else
				srti.frame.hovering = nil
			end
			srti.click = nil
			srti.Show()
		else
			srti.click = curtime
		end
		srti.clickX, srti.clickY = x, y
	end
	if clickFrameScripts[frameName] then
		clickFrameScripts[frameName](frame,btn)
	end
end

function srti.OnMouseDown(frame, btn)
	local frameName = frame.GetName and frame:GetName() or ""
	if ( btn == "LeftButton" ) then
		srti.mouseover = UnitIsUnit("target", "mouseover")
	end
	if clickFrameScripts[frameName] then
		clickFrameScripts[frameName](frame,btn)
	end
end

SlashCmdList["SRTI"] = function(msg)
	msg = msg:lower()
	local num = tonumber(msg)
	if ( msg == "" ) then
		srti.Options()
	elseif ( num and num < 9 ) then
		srti.SetRaidTarget(num)
	elseif ( msg == "debug" ) then
		if ( SRTISaved.debug ) then
			SRTISaved.debug = nil
		else
			SRTISaved.debug = 1
		end
	else
		for string, index in pairs(iconStrings) do
			if ( msg == string ) then
				srti.SetRaidTarget(index)
				return
			end
		end

		srti.PrintHelp()
	end
end

SLASH_SRTI1 = "/srti"

-- ugly quick hack to make old UIOptions style check box
local function CreateCheckBox(name, parent)
	local f = CreateFrame("CheckButton", name, parent, "OptionsCheckButtonTemplate")
	f:SetWidth(26)
	f:SetHeight(26)
	return f
end


function srti.Options()
	srti.menu = CreateFrame("Frame","SRTIMenu",UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
	srti.menu.name = addonName

	srti.menu:SetWidth(460)
	srti.menu:SetHeight(31)
	srti.menu:SetPoint("TOP",UIParent,"TOP",0,-100)
	srti.menu:EnableMouse(true)
	srti.menu:SetMovable(true)
	srti.menu:RegisterForDrag("LeftButton")
	srti.menu:SetScript("OnDragStart", srti.menu.StartMoving)
	srti.menu:SetScript("OnDragStop", srti.menu.StopMovingOrSizing)
	srti.menu:SetScript("OnHide", srti.menu.StopMovingOrSizing)
	srti.menu.closebutton = CreateFrame("Button",nil,srti.menu,"UIPanelCloseButton")
	srti.menu.closebutton:SetPoint("RIGHT",srti.menu,"RIGHT",0,0)
	srti.menu.closebutton:HookScript("OnShow",function(self)
		if srti.menu:GetParent():GetName()=="UIParent" then
			self:Show()
		else
			self:Hide()
		end
	end)
	tinsert(UISpecialFrames,"SRTIMenu")

	InterfaceOptions_AddCategory(srti.menu)

	srti.menu:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 5, right = 3, top = 3, bottom = 5 }
		})
	srti.menu:SetBackdropBorderColor(0.4, 0.4, 0.4)
	srti.menu:SetBackdropColor(0.15, 0.15, 0.15)

	srti.menu.title = srti.menu:CreateFontString(nil,"ARTWORK","GameFontHighlight")
	srti.menu.title:SetText(SRTI_HEADER)
	srti.menu.title:SetPoint("TOPLEFT",srti.menu,"TOPLEFT",8,-8)

	srti.menu.options = CreateFrame("Frame","SRTIMenuOptions",srti.menu, BackdropTemplateMixin and "BackdropTemplate" or nil)
	srti.menu.options:SetWidth(292)
	srti.menu.options:SetHeight(488)
	srti.menu.options:SetPoint("TOPLEFT",srti.menu,"TOPLEFT",5,-30)
	srti.menu.options:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 5, right = 3, top = 3, bottom = 5 }
		})
	srti.menu.options:SetBackdropBorderColor(0.4, 0.4, 0.4)
	srti.menu.options:SetBackdropColor(0.15, 0.15, 0.15)

	srti.menu.optionheader = srti.menu.options:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	srti.menu.optionheader:SetText(L["Radial Menu Options"])
	srti.menu.optionheader:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",8,-8)


	srti.menu.options.singleframe = CreateFrame("Frame",nil,srti.menu.options, BackdropTemplateMixin and "BackdropTemplate" or nil)
	srti.menu.options.singleframe:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT", 8, -40)
	srti.menu.options.singleframe:SetPoint("BOTTOMRIGHT",srti.menu.options,"TOPRIGHT", -8, -94)
	srti.menu.options.singleframe:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	srti.menu.options.singleframe:SetBackdropBorderColor(0, 0, 0)
	srti.menu.options.singleframe:SetBackdropColor(0.1, 0.1, 0.1)

	srti.menu.singletext = srti.menu.options:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	srti.menu.singletext:SetText(L["Left Click"])
	srti.menu.singletext:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-25)

	srti.menu.modifiertext = srti.menu.options.singleframe:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	srti.menu.modifiertext:SetText(L["Modifiers"])
	srti.menu.modifiertext:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-49)

	srti.menu.shift = CreateCheckBox("SRTIcb3",srti.menu.options.singleframe)
	srti.menu.shift:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",82,-42)
	srti.menu.shift:SetHitRectInsets(0,-30,5,5)
	srti.menu.shift.option = "shift"
	SRTIcb3Text:SetText(L["Shift"])

	srti.menu.ctrl = CreateCheckBox("SRTIcb1",srti.menu.options.singleframe)
	srti.menu.ctrl:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",142,-42)
	srti.menu.ctrl:SetHitRectInsets(0,-30,5,5)
	srti.menu.ctrl.option = "ctrl"
	SRTIcb1Text:SetText(L["Ctrl"])

	srti.menu.alt = CreateCheckBox("SRTIcb2",srti.menu.options.singleframe)
	srti.menu.alt:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",202,-42)
	srti.menu.alt:SetHitRectInsets(0,-30,5,5)
	srti.menu.alt.option = "alt"
	SRTIcb2Text:SetText(L["Alt"])

	srti.menu.singlehover = CreateCheckBox("SRTIcb4",srti.menu.options.singleframe)
	srti.menu.singlehover:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",16,-66)
	srti.menu.singlehover:SetHitRectInsets(0,-130,5,5)
	srti.menu.singlehover.option = "singlehover"
	SRTIcb4Text:SetText(L["Select Icon on Hover"])


	srti.menu.options.doubleframe = CreateFrame("Frame",nil,srti.menu.options, BackdropTemplateMixin and "BackdropTemplate" or nil)
	srti.menu.options.doubleframe:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT", 8, -113)
	srti.menu.options.doubleframe:SetPoint("BOTTOMRIGHT",srti.menu.options,"TOPRIGHT", -8, -194)
	srti.menu.options.doubleframe:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	srti.menu.options.doubleframe:SetBackdropBorderColor(0, 0, 0)
	srti.menu.options.doubleframe:SetBackdropColor(0.1, 0.1, 0.1)

	srti.menu.doubletext = srti.menu.options:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	srti.menu.doubletext:SetText(L["Double Left Click"])
	srti.menu.doubletext:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-98)

	srti.menu.doublecb = CreateCheckBox("SRTIcb5",srti.menu.options.doubleframe)
	srti.menu.doublecb:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",16,-115)
	srti.menu.doublecb:SetHitRectInsets(0,-30,5,5)
	SRTIcb5Text:SetText(L["Enable"])

	srti.menu.doublehover = CreateCheckBox("SRTIcb6",srti.menu.options.doubleframe)
	srti.menu.doublehover:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",90,-115)
	srti.menu.doublehover:SetHitRectInsets(0,-130,5,5)
	srti.menu.doublehover.option = "doublehover"
	SRTIcb6Text:SetText(L["Select Icon on Hover"])

	srti.menu.doublespeed = CreateFrame("Slider","SRTIslider1",srti.menu.options.doubleframe,"OptionsSliderTemplate")
	srti.menu.doublespeed:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-160)
	srti.menu.doublespeed:SetPoint("TOPRIGHT",srti.menu.options,"TOPRIGHT",-18,-160)
	srti.menu.doublespeed:SetMinMaxValues(0.15,0.5)
	srti.menu.doublespeed:SetValueStep(0.01)
	srti.menu.doublespeed.option = "speed"
	SRTIslider1Low:SetText(L["Slow"])
	SRTIslider1High:SetText(L["Quick"])


	srti.menu.options.bindingframe = CreateFrame("Frame",nil,srti.menu.options, BackdropTemplateMixin and "BackdropTemplate" or nil)
	srti.menu.options.bindingframe:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT", 8, -213)
	srti.menu.options.bindingframe:SetPoint("BOTTOMRIGHT",srti.menu.options,"TOPRIGHT", -8, -296)
	srti.menu.options.bindingframe:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	srti.menu.options.bindingframe:SetBackdropBorderColor(0, 0, 0)
	srti.menu.options.bindingframe:SetBackdropColor(0.1, 0.1, 0.1)

	srti.menu.bindingtext = srti.menu.options:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	srti.menu.bindingtext:SetText(L["Key Bindings"])
	srti.menu.bindingtext:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-198)

	srti.menu.bindingkey1 = CreateFrame("Button","SRTIkb1",srti.menu.options.bindingframe,"UIPanelButtonTemplate")
	srti.menu.bindingkey1:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",16,-219)
	srti.menu.bindingkey1:SetWidth(220)
	srti.menu.bindingkey1:SetNormalFontObject(GameFontHighlightSmall)
	srti.menu.bindingkey1:SetHighlightFontObject(GameFontHighlightSmall)
	srti.menu.bindingkey1:SetScript("OnClick",function(self,arg1) srti.SetKeyBinding(arg1,"SRTI_SHOW",1) end)
	srti.menu.bindingkey1:RegisterForClicks("AnyUp")

	srti.menu.unbindingkey1 = CreateFrame("Button",nil,srti.menu.options.bindingframe)
	srti.menu.unbindingkey1:SetPoint("LEFT",srti.menu.bindingkey1,"RIGHT",-6,-1.5)
	srti.menu.unbindingkey1:SetWidth(32)
	srti.menu.unbindingkey1:SetHeight(32)
	srti.menu.unbindingkey1:SetNormalTexture("Interface\\Buttons\\CancelButton-Up")
	srti.menu.unbindingkey1:SetPushedTexture("Interface\\Buttons\\CancelButton-Down")
	local h = srti.menu.unbindingkey1:CreateTexture(nil,"HIGHLIGHT")
	h:SetTexture("Interface\\Buttons\\CancelButton-Highlight")
	h:SetAllPoints()
	h:SetBlendMode("ADD")
	srti.menu.unbindingkey1:SetHighlightTexture(h)
	srti.menu.unbindingkey1:SetScript("OnClick",function(self, arg1) srti.SetKeyBinding(arg1,"SRTI_SHOW",1,1) end)

	srti.menu.bindingkey2 = CreateFrame("Button","SRTIkb2",srti.menu.options.bindingframe,"UIPanelButtonTemplate")
	srti.menu.bindingkey2:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",16,-242)
	srti.menu.bindingkey2:SetWidth(220)
	srti.menu.bindingkey2:SetNormalFontObject(GameFontHighlightSmall)
	srti.menu.bindingkey2:SetHighlightFontObject(GameFontHighlightSmall)
	srti.menu.bindingkey2:SetScript("OnClick",function(self, arg1) srti.SetKeyBinding(arg1,"SRTI_SHOW",2) end)
	srti.menu.bindingkey2:RegisterForClicks("AnyUp")

	srti.menu.unbindingkey2 = CreateFrame("Button",nil,srti.menu.options.bindingframe)
	srti.menu.unbindingkey2:SetPoint("LEFT",srti.menu.bindingkey2,"RIGHT",-6,-1.5)
	srti.menu.unbindingkey2:SetWidth(32)
	srti.menu.unbindingkey2:SetHeight(32)
	srti.menu.unbindingkey2:SetNormalTexture("Interface\\Buttons\\CancelButton-Up")
	srti.menu.unbindingkey2:SetPushedTexture("Interface\\Buttons\\CancelButton-Down")
	h = srti.menu.unbindingkey2:CreateTexture(nil,"HIGHLIGHT")
	h:SetTexture("Interface\\Buttons\\CancelButton-Highlight")
	h:SetAllPoints()
	h:SetBlendMode("ADD")
	srti.menu.unbindingkey2:SetHighlightTexture(h)
	srti.menu.unbindingkey2:SetScript("OnClick",function(self, arg1) srti.SetKeyBinding(arg1,"SRTI_SHOW",2,1) end)

	srti.menu.bindinghover = CreateCheckBox("SRTIcb7",srti.menu.options.bindingframe)
	srti.menu.bindinghover:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",16,-268)
	srti.menu.bindinghover:SetHitRectInsets(0,-130,5,5)
	srti.menu.bindinghover.option = "bindinghover"
	SRTIcb7Text:SetText(L["Select Icon on Hover"])


	srti.menu.options.hoverframe = CreateFrame("Frame",nil,srti.menu.options, BackdropTemplateMixin and "BackdropTemplate" or nil)
	srti.menu.options.hoverframe:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT", 8, -298)
	srti.menu.options.hoverframe:SetPoint("BOTTOMRIGHT",srti.menu.options,"TOPRIGHT", -8, -372)
	srti.menu.options.hoverframe:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	srti.menu.options.hoverframe:SetBackdropBorderColor(0, 0, 0)
	srti.menu.options.hoverframe:SetBackdropColor(0.1, 0.1, 0.1)

	srti.menu.hovertime = CreateFrame("Slider","SRTIslider2",srti.menu.options,"OptionsSliderTemplate")
	srti.menu.hovertime:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-312)
	srti.menu.hovertime:SetPoint("TOPRIGHT",srti.menu.options,"TOPRIGHT",-18,-312)
	srti.menu.hovertime:SetMinMaxValues(0.0,0.5)
	srti.menu.hovertime:SetValueStep(0.05)
	srti.menu.hovertime.option = "hovertime"
	SRTIslider2Low:SetText(L["Slow"])
	SRTIslider2High:SetText(L["Quick"])

	srti.menu.radialscale = CreateFrame("Slider","SRTIsliderScale",srti.menu.options.doubleframe,"OptionsSliderTemplate")
	srti.menu.radialscale:SetPoint("TOPLEFT",srti.menu.options,"TOPLEFT",18,-340)
	srti.menu.radialscale:SetPoint("TOPRIGHT",srti.menu.options,"TOPRIGHT",-18,-340)
	srti.menu.radialscale:SetMinMaxValues(0.5,2.5)
	srti.menu.radialscale:SetValueStep(0.1)
	srti.menu.radialscale.option = "radialscale"
	SRTIsliderScaleLow:SetText(("%d%%"):format(0.5*100))
	SRTIsliderScaleHigh:SetText(("%d%%"):format(2.5*100))

	srti.menu.test = CreateFrame("Frame",nil,srti.menu, BackdropTemplateMixin and "BackdropTemplate" or nil)
	srti.menu.test:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 5, right = 3, top = 3, bottom = 5 }
		})
	srti.menu.test:SetBackdropBorderColor(0.4, 0.4, 0.4)
	srti.menu.test:SetBackdropColor(0.15, 0.15, 0.15)
	srti.menu.test:SetPoint("TOPRIGHT",srti.menu,"TOPRIGHT",-5,-30)
	srti.menu.test:SetPoint("BOTTOMLEFT",srti.menu.options,"BOTTOMRIGHT",0,0)


	srti.menu.test.model = CreateFrame("PLAYERMODEL",nil,srti.menu.test)
	srti.menu.test.model:SetPoint("TOPRIGHT",srti.menu.test,"TOPRIGHT",-6,-6)
	srti.menu.test.model:SetPoint("BOTTOMLEFT",srti.menu.test,"BOTTOMLEFT",6,6)
	srti.menu.test.model:SetRotation(0.61)
	srti.menu.test.model:SetScript("OnShow", function(self)
			srti.menu.test.model:SetPosition(0,0,0)
			srti.menu.test.model:SetUnit("player")
			srti.menu.test.model:SetPosition(0,0,-0.2)
		end
		)
	srti.menu.test.model:GetScript("OnShow")()

	srti.menu.test.icon = srti.menu.test.model:CreateTexture(nil,"OVERLAY")
	srti.menu.test.icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	srti.menu.test.icon:SetWidth(42)
	srti.menu.test.icon:SetHeight(42)
	srti.menu.test.icon:SetPoint("TOP",srti.menu.test.model,"TOP",0,-2)
	srti.menu.test.icon:Hide()

	srti.menu.test.text = srti.menu.test.model:CreateFontString(nil,"OVERLAY","NumberFontNormal")
	srti.menu.test.text:SetText(L["Test Me"])
	srti.menu.test.text:SetPoint("TOP",srti.menu.test.icon,"BOTTOM")

	srti.menu.test.help = srti.menu.test:CreateFontString(nil,"ARTWORK","GameFontDisable")
	srti.menu.test.help:SetText(L["Click above to test settings"])
	srti.menu.test.help:SetPoint("BOTTOM",srti.menu.test,"BOTTOM",0,8)
	srti.menu.test.help:SetPoint("LEFT",srti.menu.test,"LEFT",0,8)
	srti.menu.test.help:SetPoint("RIGHT",srti.menu.test,"RIGHT",0,-8)


	srti.menu.test.ShowRadial = function(hovering)
		srti.frame.hovering = hovering
		srti.frame.showing = GetTime()
		srti.frame.hiding = nil
		srti.frame.index = nil
		srti.frame.lingering = nil
		srti.frame.test = 1
		srti.frame.portrait = nil

		local x,y = GetCursorPosition()
		local s = srti.frame:GetEffectiveScale()
		srti.frame:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", x/s, y/s )
		srti.frame:Show()
	end

	srti.menu.test:SetScript("OnMouseUp",function(self, arg1)
		if ( arg1 == "LeftButton" ) then
			local time = GetTime()
			local x, y = GetCursorPosition()
			local modifiers = srti.AreModifiersDown()
			local double = ( SRTISaved.double and srti.click and time - srti.click < (SRTISaved.speed or 0.25) and abs(x-srti.clickX) < 20 and abs(y-srti.clickY) < 20 )
			if ( modifiers or double ) then
				if ( ( modifiers and SRTISaved.singlehover ) or ( double and SRTISaved.doublehover ) ) then
					srti.menu.test.ShowRadial(0)
				else
					srti.menu.test.ShowRadial()
				end
			else
				srti.click = time
			end
			srti.clickX, srti.clickY = x, y
		end
	end
	)

	-- prune addons that we support but are not actually loaded.
	-- DEBUG: addons with spaces in the name will create problems.
	-- revisit this part to add support for those at a later date.
	for i,addonname in ipairs(thirdParty) do
		if not IsAddOnLoaded(addonname) then
			tremove(thirdParty,i)
		end
	end
	-- add integration options for those that are.
	if next(thirdParty) then
		srti.menu.Modifer3RDCB = function(self)
			SRTISaved[self.option] = self:GetChecked() == 1
		end
		srti.menu.thirdparty = CreateFrame("Frame",nil,srti.menu, BackdropTemplateMixin and "BackdropTemplate" or nil)
		srti.menu.thirdparty:EnableMouse(1)
		srti.menu.thirdparty:SetMovable(1)
		srti.menu.thirdparty:SetBackdrop({
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile = true, tileSize = 16, edgeSize = 16,
			insets = { left = 5, right = 3, top = 3, bottom = 5 }
			})
		srti.menu.thirdparty:SetBackdropBorderColor(0.4, 0.4, 0.4)
		srti.menu.thirdparty:SetBackdropColor(0.15, 0.15, 0.15)
		srti.menu.thirdparty:SetHeight(50)
		srti.menu.thirdparty:SetPoint("TOPLEFT",srti.menu.options,"BOTTOMLEFT",0,0)
		srti.menu.thirdparty:SetPoint("TOPRIGHT",srti.menu.test,"BOTTOMRIGHT",0,0)
		srti.menu.thirdpartytext = srti.menu.thirdparty:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
		srti.menu.thirdpartytext:SetText(L["3rd Party Addon Integration"])
		srti.menu.thirdpartytext:SetPoint("TOPLEFT",srti.menu.thirdparty,"TOPLEFT",8,-8)
		-- todo: horizontal scrollframe this section
		for i,addonname in ipairs(thirdParty) do
			srti.menu.thirdparty.addonname = CreateCheckBox("SRTIcb"..addonname,srti.menu.thirdparty)
			if i == 1 then
				srti.menu.thirdparty.addonname:SetPoint("BOTTOMLEFT",srti.menu.thirdparty,"BOTTOMLEFT",8,5)
			else
				srti.menu.thirdparty.addonname:SetPoint("LEFT",srti.menu.thirdparty[thirdParty[i-1]],"RIGHT",(_G["SRTIcb"..thirdParty[i-1].."Text"]:GetStringWidth()+5),0)
			end
			srti.menu.thirdparty.addonname:SetHitRectInsets(0,-30,5,5)
			srti.menu.thirdparty.addonname.option = addonname
			_G["SRTIcb"..addonname.."Text"]:SetText(addonname)
			srti.menu.thirdparty.addonname:SetScript("OnClick", srti.menu.Modifer3RDCB)
		end
	end

	srti.menu.UpdateCB = function()
		if ( SRTISaved.ctrl or SRTISaved.alt or SRTISaved.shift ) then
			srti.menu.singletext:SetFontObject("GameFontHighlightSmall")
			srti.menu.modifiertext:SetFontObject("GameFontHighlightSmall")
			SRTIcb4Text:SetFontObject("GameFontNormalSmall")
		else
			srti.menu.singletext:SetFontObject("GameFontDisableSmall")
			srti.menu.modifiertext:SetFontObject("GameFontDisableSmall")
			SRTIcb4Text:SetFontObject("GameFontDisableSmall")
		end
	end

	srti.menu.ModiferCB = function(self)
    if (self:GetChecked()) then
      SRTISaved[self.option] = true
    else
      SRTISaved[self.option] = false
    end
		srti.menu.UpdateCB()
	end

	srti.menu.UpdateDouble = function()
		if ( SRTISaved.double ) then
			srti.menu.doubletext:SetFontObject("GameFontHighlightSmall")
			SRTIslider1Text:SetFontObject("GameFontNormalSmall")
			SRTIslider1Low:SetFontObject("GameFontHighlightSmall")
			SRTIslider1High:SetFontObject("GameFontHighlightSmall")
			SRTIcb6Text:SetFontObject("GameFontNormalSmall")
		else
			srti.menu.doubletext:SetFontObject("GameFontDisableSmall")
			SRTIslider1Text:SetFontObject("GameFontDisableSmall")
			SRTIslider1Low:SetFontObject("GameFontDisableSmall")
			SRTIslider1High:SetFontObject("GameFontDisableSmall")
			SRTIcb6Text:SetFontObject("GameFontDisableSmall")
		end
	end

	srti.menu.DoubleCB = function(self)
    if (self:GetChecked()) then
      SRTISaved.double = true
    else
      SRTISaved.double = false
    end
		srti.menu.UpdateDouble()
	end

	srti.menu.UpdateSlider = function()
		SRTIslider1Text:SetText(L["Double Click Speed - %s sec"]:format(string.sub(SRTISaved.speed,1,4) or 0.25))
		SRTIslider2Text:SetText(L["Hover Wait Time - %s sec"]:format(string.sub(SRTISaved.hovertime,1,4) or 0.2))
		SRTIsliderScaleText:SetText(L["Radial Menu Scale - %d%%"]:format(SRTISaved.radialscale and SRTISaved.radialscale*100 or 100))
	end

	srti.menu.DoubleSlider = function(self)
		SRTISaved[self.option] = self:GetValue()
		srti.menu.UpdateSlider()
	end

	srti.menu.ScaleSlider = function(self)
		SRTISaved[self.option] = self:GetValue()
		srti.frame:SetScale(SRTISaved[self.option] or 1.0)
		srti.menu.UpdateSlider()
	end

	srti.menu.ctrl:SetScript("OnClick",srti.menu.ModiferCB)
	srti.menu.alt:SetScript("OnClick",srti.menu.ModiferCB)
	srti.menu.shift:SetScript("OnClick",srti.menu.ModiferCB)
	srti.menu.singlehover:SetScript("OnClick",srti.menu.ModiferCB)

	srti.menu.doublecb:SetScript("OnClick",srti.menu.DoubleCB)
	srti.menu.doublehover:SetScript("OnClick",srti.menu.ModiferCB)
	srti.menu.doublespeed:SetScript("OnValueChanged",srti.menu.DoubleSlider)
	srti.menu.hovertime:SetScript("OnValueChanged",srti.menu.DoubleSlider)
	srti.menu.radialscale:SetScript("OnValueChanged",srti.menu.ScaleSlider)

	srti.menu.bindinghover:SetScript("OnClick",srti.menu.ModiferCB)

	srti.menu.UpdateBindings = function()
		local binding1, binding2 = GetBindingKey("SRTI_SHOW")

		if ( binding1 ) then
			srti.menu.bindingkey1:SetText(GetBindingText(binding1, "KEY_"))
			srti.menu.bindingkey1:SetAlpha(1)
		else
			srti.menu.bindingkey1:SetText(NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE)
			srti.menu.bindingkey1:SetAlpha(0.8)
		end
		if ( binding2 ) then
			srti.menu.bindingkey2:SetText(GetBindingText(binding2, "KEY_"))
			srti.menu.bindingkey2:SetAlpha(1)
		else
			srti.menu.bindingkey2:SetText(NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE)
			srti.menu.bindingkey2:SetAlpha(0.8)
		end
	end

	srti.menu.Update = function()
		srti.menu.ctrl:SetChecked(SRTISaved.ctrl)
		srti.menu.alt:SetChecked(SRTISaved.alt)
		srti.menu.shift:SetChecked(SRTISaved.shift)
		srti.menu.singlehover:SetChecked(SRTISaved.singlehover)

		srti.menu.doublespeed:SetValue(SRTISaved.speed)
		srti.menu.hovertime:SetValue(SRTISaved.hovertime)
		srti.menu.radialscale:SetValue(SRTISaved.radialscale)
		srti.menu.doublecb:SetChecked(SRTISaved.double)
		srti.menu.doublehover:SetChecked(SRTISaved.doublehover)
                srti.menu.bindinghover:SetChecked(SRTISaved.bindinghover)

		if next(thirdParty) then
			for i,addonname in pairs(thirdParty) do
				local checkbox = _G["SRTIcb"..addonname]
				if checkbox then
					checkbox:SetChecked(SRTISaved[checkbox.option] )
				end
			end
		end

		srti.menu.UpdateCB()
		srti.menu.UpdateSlider()
		srti.menu.UpdateDouble()
		srti.menu.UpdateBindings()
	end

	srti.menu:SetScript("OnShow", srti.menu.Update)

	srti.menu.Update()

	srti.Options = function()
		local parentName = srti.menu:GetParent():GetName()
		if parentName == "UIParent" then
			if ( srti.menu:IsVisible() ) then
				srti.menu:Hide()
			else
				srti.menu:Show()
			end
		else
			srti.menu:Show()
			InterfaceOptionsFrame_OpenToCategory(srti.menu)
			InterfaceOptionsFrame_OpenToCategory(srti.menu)
		end
	end
end

function srti.SetKeyBinding(button,binding,index,mode)
	srti.keybindings = CreateFrame("Frame","SRTIKeyBindingsFrame",UIParent)
	srti.keybindings:EnableKeyboard(1)
	srti.keybindings:EnableMouse(1)
	srti.keybindings:EnableMouseWheel(1)
	srti.keybindings:SetFrameStrata("FULLSCREEN_DIALOG")
	srti.keybindings:SetAllPoints()

	srti.keybindings.bg = srti.keybindings:CreateTexture(nil,"BACKGROUND")
	srti.keybindings.bg:SetTexture(0.15,0.15,0.15)
	srti.keybindings.bg:SetAlpha(0.75)
	srti.keybindings.bg:SetAllPoints()

	srti.keybindings.frame = CreateFrame("Frame",nil,srti.keybindings, BackdropTemplateMixin and "BackdropTemplate" or nil)
	srti.keybindings.frame:SetPoint("CENTER",srti.keybindings,"CENTER", 0, 50)
	srti.keybindings.frame:SetWidth(400)
	srti.keybindings.frame:SetHeight(100)
	srti.keybindings.frame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	srti.keybindings.frame:SetBackdropBorderColor(0, 0, 0)
	srti.keybindings.frame:SetBackdropColor(0.1, 0.1, 0.1)

	srti.keybindings.keytext = srti.keybindings.frame:CreateFontString(nil,"ARTWORK","GameFontHighlightLarge")
	srti.keybindings.keytext:SetPoint("CENTER")

	srti.keybindings.helptext = srti.keybindings.frame:CreateFontString(nil,"ARTWORK","GameFontNormal")
	srti.keybindings.helptext:SetPoint("TOP",srti.keybindings.frame,"TOP",0,-4)

	srti.keybindings.warntext = srti.keybindings.frame:CreateFontString(nil,"ARTWORK","GameFontNormal")
	srti.keybindings.warntext:SetPoint("BOTTOM",srti.keybindings.frame,"BOTTOM",0,4)

	srti.keybindings.acceptframe = CreateFrame("Frame",nil,srti.keybindings.frame, BackdropTemplateMixin and "BackdropTemplate" or nil)
	srti.keybindings.acceptframe:SetPoint("TOP",srti.keybindings.frame,"BOTTOM", 0, 0)
	srti.keybindings.acceptframe:SetWidth(400)
	srti.keybindings.acceptframe:SetHeight(28)
	srti.keybindings.acceptframe:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
		})
	srti.keybindings.acceptframe:SetBackdropBorderColor(0, 0, 0)
	srti.keybindings.acceptframe:SetBackdropColor(0.1, 0.1, 0.1)

	srti.keybindings.esctext = srti.keybindings.acceptframe:CreateFontString(nil,"ARTWORK","GameFontHighlight")
	srti.keybindings.esctext:SetPoint("CENTER",srti.keybindings.acceptframe,"CENTER",0)
	srti.keybindings.esctext:SetText(L["Press |cffffffffEsc|r to cancel"])

	srti.keybindings.accept = CreateFrame("BUTTON",nil,srti.keybindings.acceptframe,"UIPanelButtonTemplate")
	srti.keybindings.accept:SetPoint("RIGHT",srti.keybindings.acceptframe,"RIGHT",-2,0)
	srti.keybindings.accept:SetText(ACCEPT)
	srti.keybindings.accept:SetWidth(80)
	srti.keybindings.accept:SetHeight(22)
	srti.keybindings.accept:Disable()

	srti.keybindings.accept:SetScript("OnClick", function(self,arg1)
			srti.keybindings:Hide()
			if ( srti.keybindings.mode ) then
				if ( srti.keybindings.key ) then
					SetBinding(srti.keybindings.key)
				end
			elseif ( srti.keybindings.key and srti.keybindings.binding ) then
				local key1, key2 = GetBindingKey(srti.keybindings.binding)
				if ( key1 ) then
					SetBinding(key1)
				end
				if ( key2 ) then
					SetBinding(key2)
				end
				if ( srti.keybindings.index == 1 ) then
					SetBinding(srti.keybindings.key, srti.keybindings.binding)
					if ( key2 ) then
						SetBinding(key2, srti.keybindings.binding)
					end
				else
					if ( key1 ) then
						SetBinding(key1, srti.keybindings.binding)
					end
					SetBinding(srti.keybindings.key, srti.keybindings.binding)
				end
			end
			if is_classic then
				AttemptToSaveBindings(GetCurrentBindingSet())
			else
				SaveBindings(GetCurrentBindingSet())
			end
			srti.menu.UpdateBindings()
		end)

	function srti.keybindings.OnShow(self)
		if ( srti.keybindings.mode ) then
			if ( not srti.keybindings.key ) then
				srti.keybindings:Hide()
			end
			srti.keybindings.helptext:SetText(format(L["|cffff0000You are about to unbind key from |r%s"], GetBindingText(binding, "BINDING_NAME_")))
			srti.keybindings.keytext:SetText(srti.keybindings.key)
			srti.keybindings.warntext:SetText("")
			srti.keybindings.accept:Enable()
		else
			srti.keybindings.helptext:SetText(format(L["|cffffffffPress a key to bind |r%s"], GetBindingText(binding, "BINDING_NAME_")))
			srti.keybindings.keytext:SetText(srti.keybindings.key or NOT_BOUND)
			srti.keybindings.warntext:SetText("")
			if ( srti.keybindings.key ) then
				srti.keybindings.accept:Enable()
			else
				srti.keybindings.accept:Disable()
			end
		end
	end

	function srti.keybindings.OnKeyDown(key)
		local screenshotKey = GetBindingKey("SCREENSHOT")
		if ( screenshotKey and key == screenshotKey ) then
			Screenshot()
			return
		end
		if ( key=="ESCAPE" ) then
			srti.keybindings:Hide()
		elseif ( not srti.keybindings.mode and key ~= "LeftButton" and key ~= "RightButton" and key ~= "SHIFT" and key ~= "ALT" and key ~= "CTRL" and key ~= "UNKNOWN" ) then
			srti.keybindings.OnShow()
			if ( key == "MiddleButton" ) then
				key = "BUTTON3"
			elseif ( key == "Button4" ) then
				key = "BUTTON4"
			elseif ( key == "Button5" ) then
				key = "BUTTON5"
			end
			if ( srti.keybindings.modifier ) then
				if IsLeftShiftKeyDown() then
					key = "LSHIFT-"..key
				end
				if IsLeftAltKeyDown() then
					key = "LALT-"..key
				end
				if IsLeftControlKeyDown() then
					key = "LCTRL-"..key
				end
				if IsRightShiftKeyDown() then
					key = "RSHIFT-"..key
				end
				if IsRightAltKeyDown() then
					key = "RALT-"..key
				end
				if IsRightControlKeyDown() then
					key = "RCTRL-"..key
				end
			else
				if IsShiftKeyDown() then
					key = "SHIFT-"..key
				end
				if IsAltKeyDown() then
					key = "ALT-"..key
				end
				if IsControlKeyDown() then
					key = "CTRL-"..key
				end
			end

			srti.keybindings.keytext:SetText( key )
			srti.keybindings.key = key
			srti.keybindings.accept:Enable()

			local oldAction = GetBindingAction(key)
			if ( oldAction ~= "" and oldAction ~= srti.keybindings.binding ) then
				local oldkeys = select("#",GetBindingKey(oldAction))
				if ( oldkeys > 1 ) then
					srti.keybindings.warntext:SetText(format(L["|cffff0000%s Function will be Unbound from this Key!"], GetBindingText(oldAction, "BINDING_NAME_")))
				else
					srti.keybindings.warntext:SetText(format(L["|cffff0000%s Function will be Unbound!"], GetBindingText(oldAction, "BINDING_NAME_")))
				end
			end
		end
	end

	srti.keybindings:SetScript("OnKeyDown", function(self, arg1) srti.keybindings.OnKeyDown(arg1) end)
	srti.keybindings:SetScript("OnMouseUp", function(self, arg1) srti.keybindings.OnKeyDown(arg1) end)
	srti.keybindings:SetScript("OnMouseWheel", function(self, arg1)
			if ( arg1 > 0 ) then
				srti.keybindings.OnKeyDown("MOUSEWHEELUP")
			else
				srti.keybindings.OnKeyDown("MOUSEWHEELDOWN")
			end
		end)

	srti.SetKeyBinding = function(button,binding,index,mode)
		srti.keybindings.binding = binding or "SRTI_SHOW"
		srti.keybindings.index = index or 1
		srti.keybindings.key = select(srti.keybindings.index,GetBindingKey(srti.keybindings.binding))
		srti.keybindings.mode = mode

		srti.keybindings.accept:Disable()
		srti.keybindings:Show()
		srti.keybindings.OnShow()
		srti.keybindings.OnKeyDown(button)
	end

	srti.SetKeyBinding(button, binding, index, mode)
end

local cc_marks = {
	["MAGE"] = {5,6,2,1}, 	-- "moon", "square", "circle", "star"
	["WARLOCK"] = {3,6}, 	-- "diamond", "square"
	["HUNTER"] = {4,6},	-- "triangle", "square"
	["PRIEST"] = {1,2,3},		-- "star", "circle", "diamond"
	["DRUID"] = {2,4},		-- "circle", "triangle"
	["SHAMAN"] = {6,4}		-- "square", "triangle"
}
local cc_type_class = {
	[L["Humanoid"]] = {"MAGE","HUNTER","WARLOCK","PRIEST"},
	[L["Giant"]] = {"HUNTER","WARLOCK"},
	[L["Beast"]] = {"MAGE","HUNTER","DRUID"},
	[L["Dragonkin"]] = {"HUNTER","DRUID"},
	[L["Demon"]] = {"WARLOCK","HUNTER"},
	[L["Elemental"]] = {"WARLOCK","HUNTER"},
	[L["Undead"]] = {"PRIEST","HUNTER"},
	[L["Mechanical"]] = {"HUNTER"}
}
local cc_immune = { -- individual npc exclusions
	-- ZG
  [L["Gurubashi Champion"]] = true,
  [L["Gurubashi Berserker"]] = true,
  -- MC
  [L["Ancient Core Hound"]] = true,
  [L["Firelord"]] = true,
  [L["Flameguard"]] = true,
  [L["Firewalker"]] = true,
  -- BWL
  [L["Death Talon Captain"]] = true,
  [L["Death Talon Wyrmguard"]] = true,
  [L["Death Talon Flamescale"]] = true,
  [L["Death Talon Seether"]] = true,
  [L["Death Talon Overseer"]] = true,
  [L["Blackwing Spellbinder"]] = true,
  [L["Blackwing Technician"]] = true,
  [L["Blackwing Warlock"]] = true,
  -- Naxx
  [L["Surgical Assistant"]] = true,
}
function srti.UpdateClassCount()
	CC_ClassCount = {}
	local inRaid = UnitInRaid("player")
	if inRaid then
		for i=1,GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) do
			inRaid = true
			local _, class = UnitClass(raid[i].unit)
			if cc_marks[class] then
				CC_ClassCount[class] = (CC_ClassCount[class]~=nil) and (CC_ClassCount[class]+1) or 1
			end
		end
	else
		local _,class = UnitClass("player")
		if cc_marks[class] then
			CC_ClassCount[class] = (CC_ClassCount[class]~=nil) and (CC_ClassCount[class]+1) or 1
		end
		for i=1,GetNumSubgroupMembers(LE_PARTY_CATEGORY_HOME) do
			_,class = UnitClass(party[i].unit)
			if cc_marks[class] then
				CC_ClassCount[class] = (CC_ClassCount[class]~=nil) and (CC_ClassCount[class]+1) or 1
			end
		end
	end
end

local lastMarkAction = 0
function srti.MouseOverMark(mark)
	local unit = UnitExists("mouseover") and "mouseover"
	if not (unit) then return false end
	local now = GetTime()
	if (now - lastMarkAction) >= TOOLTIP_UPDATE_TIME then
		lastMarkAction = now
		SetRaidTarget(unit,mark)
		return true
	end
	return false
end

local assigned_cc_class, assigned_cc_marks, assigned_mark_class = {},{},{}
function srti.MassMark()
	if UnitExists("mouseover") then
		-- don't clobber existing marks
		local alreadyMarked = GetRaidTargetIndex("mouseover")
		if (alreadyMarked) then
			if not (assigned_cc_marks[alreadyMarked]) then
				assigned_cc_marks[alreadyMarked] = true
			end
			return
		end
    -- don't cc mark bosses
		if (UnitClassification("mouseover") == "worldboss") or (UnitLevel("mouseover")==-1) then return end
		-- only mark enemies we can attack
		if not UnitCanAttack("player","mouseover") then return end
		local unitName = (UnitName("mouseover"))
		-- pass the name to our kill marker
		if srti.KillMark(unitName) then return end
		-- pass the name to our special pack marker
		if srti.PackMark(unitName) then return end
		-- don't try cc known immune mobs
		if cc_immune[unitName] then return end
		-- do we have another CCer we haven't assigned?
    if not next(CC_ClassCount) then return end
		local creatureType = UnitCreatureType("mouseover")
		local ccers = cc_type_class[creatureType]
		if (ccers) then -- is it a type that can be cc
			for _, class in ipairs(ccers) do
				if (CC_ClassCount[class] ~= nil) and (CC_ClassCount[class] > 0) and CC_ClassCount[class] > (assigned_cc_class[class] or 0) then -- do we have the class that can cc it
					local marks = cc_marks[class]
					for _, mark in ipairs(marks) do
						if not (assigned_cc_marks[mark]) and srti.MouseOverMark(mark) then
							assigned_cc_marks[mark]=true
							assigned_cc_class[class] = (assigned_cc_class[class] ~= nil) and (assigned_cc_class[class]+1) or 1
							assigned_mark_class[getglobal("RAID_TARGET_"..mark)] = class
							return
						end
					end
				end
			end
		end
	end
end

local kill_targets = { -- self will have specific kill prio npcs
	-- Molten Core
	[L["Firewalker"]] = 8,
	[L["Flameguard"]] = 7,
	[L["Lava Elemental"]] = 6,
	[L["Lava Reaver"]] = 5,
	-- ZG
	[L["Gurubashi Berserker"]] = 8,
	-- AQ20
	[L["Swarmguard Needler"]] = 8,
	[L["Qiraji Warrior"]] = 7,
	[L["Qiraji Swarmguard"]] = 8,
	-- AQ40
	[L["Qiraji Lasher"]] = 5,
	-- [L["Vekniss Stinger"]] = 6,
	[L["Vekniss Soldier"]] = 8,
	[L["Qiraji Brainwasher"]] = 8,
	[L["Qiraji Champion"]] = 4,
	-- Naxx
	[L["Venom Stalker"]] = 8,
	[L["Dread Creeper"]] = 7,
	[L["Carrion Spinner"]] = 6,
	[L["Living Monstrosity"]] = 8,
	[L["Mad Scientist"]] = 7,
	[L["Frenzied Bat"]] = 5,
	[L["Plague Beast"]] = 7,

}
function srti.KillMark(name)
	local kill = kill_targets[name]
	if kill ~= nil then
    if not (assigned_cc_marks[kill]) and srti.MouseOverMark(kill) then
      assigned_cc_marks[kill] = true
      return true
    end
	end
	return false
end

local pack_marks = { -- negative index does reverse order, eg -1 marks skull, -2 marks skull>cross etc
	[L["Slavering Ghoul"]] = 8, -- just for debug
	[L["Dust Stormer"]] = 8, -- debug
	[L["Firesworn"]] = 8,
	[L["Core Hound"]] = 5,
	-- mixed group Majordomo adds
	[L["Flamewaker Healer"]] = 4,
	[L["Flamewaker Elite"]] = -4,
	[L["Flamewaker Priest"]] = -4,
	-- Buru Eggs
	[L["Buru Egg"]] = 8,
	-- Fankriss adds
	[L["Spawn of Fankriss"]] = -3,
	-- AQ40
	[L["Vekniss Warrior"]] = 3,
	[L["Vekniss Wasp"]] = -3,
	[L["Vekniss Guardian"]] = -6,
	[L["Qiraji Mindslayer"]] = -4,
	[L["Qiraji Slayer"]] = 3,
  [L["Anubisath Sentinel"]] = 4,
  -- Naxx
  [L["Naxxramas Follower"]] = -2,
  [L["Naxxramas Worshipper"]] = 4,
  [L["Naxxramas Acolyte"]] = -4,
  [L["Naxxramas Cultist"]] = 4,
  [L["Mad Scientist"]] = 4,
  [L["Necro Stalker"]] = -2,
}
function srti.PackMark(name)
	local pack = pack_marks[name]
	if pack ~= nil then
		if pack < 0 then
			pack = 8-pack
		end
    for _, mark in ipairs(marksCol[pack]) do
      if not (assigned_cc_marks[mark]) and srti.MouseOverMark(mark) then
        assigned_cc_marks[mark] = true
        return true
      end
    end
	end
  return false
end

function srti.StartMouseoverMark()
	srti.frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
end

function srti.StopMouseoverMark()
	srti.frame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
	assigned_cc_class,assigned_cc_marks = {}, {}
	for mark,class in pairs(assigned_mark_class) do
		print(camelCase(class).."> "..mark)
	end
	assigned_mark_class = {}
end

srti.clearFrame = CreateFrame("Frame")
srti.clearFrame:SetScript("OnEvent",function(self,event,...)
	if event == "UPDATE_MOUSEOVER_UNIT" then
		if UnitExists("mouseover") then
			if (GetRaidTargetIndex("mouseover")) then
				SetRaidTarget("mouseover",0)
				return
			end
		end
	end
end)
function srti.StartMouseoverClear()
	srti.clearFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
end

function srti.StopMouseoverClear()
	srti.clearFrame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
end

function srti.Target(unit)
	--TargetUnit(unit) -- Probably not possible in Classic
	srti.scanTarget = nil
	PlaySound(SOUNDKIT.IG_CHARACTER_NPC_SELECT)
	srti.ShowCursorCompanion()
end

function srti.TargetScan(icon,fromBinding)
	if not (icon) then return end
	local inRaid = UnitInRaid("player")
	local numMembers = GetNumSubgroupMembers(LE_PARTY_CATEGORY_HOME)
	local inParty = not (inRaid) and (numMembers > 0)
	if not (inParty or inRaid) then return end
	srti.scanTarget = icon
	if (inParty) then
		for i=1,numMembers do
			if UnitExists(party[i].target) then
				local mark = GetRaidTargetIndex(party[i].target)
				if mark and mark == icon then
					srti.Target(party[i].target)
					break
				end
			end
		end
		return
	else
		local numRaidMembers = GetNumGroupMembers(LE_PARTY_CATEGORY_HOME)
		for i=1,numRaidMembers do
			if not UnitIsUnit("player", raid[i].unit) then
				if UnitExists(raid[i].target) then
					local mark = GetRaidTargetIndex(raid[i].target)
					if mark and mark == icon then
						srti.Target(raid[i].target)
						break
					end
				end
			end
		end
		return
	end
end

function srti.ShowMarkOrderBar(show)
	if (show) then
		local x,y = GetCursorPosition()
		local s = srti.barFrame:GetEffectiveScale()
		srti.barFrame:ClearAllPoints()
		srti.barFrame:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", (x/s)+75, (y/s)-30 )
		srti.barFrame:Show()
	else
		srti.barFrame:Hide()
	end
end

SRTI = srti
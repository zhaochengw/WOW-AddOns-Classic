----------------------------------------------
--	The codes are based on ElvUI	    --
----------------------------------------------

local AFKS = CreateFrame("Frame")

local wowVersion
local UIscale = 1
local panelheight = GetScreenHeight() * 0.1

if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	wowVersion = "classic"
elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
	wowVersion = "wrath" -- CN only
elseif WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC then
	wowVersion = "cata"
elseif WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
	wowVersion = "retail"
end

local eastasian = false

if GetLocale() == "koKR" or GetLocale() == "zhCN" or GetLocale() == "zhTW" then
	eastasian = true
end

--Cache global variables
--Lua functions
local _G = _G
local floor = math.floor
local type, select = type, select
local tonumber, tostring = tonumber, tostring
local pairs = pairs
local GetTime = GetTime
--WoW API / Variables
local CreateFrame = CreateFrame
local GetBattlefieldStatus = GetBattlefieldStatus
local GetGuildInfo = GetGuildInfo
local GetZonePVPInfo = _G.C_PvP.GetZonePVPInfo
local InCombatLockdown = InCombatLockdown
local IsInGuild = IsInGuild
local UnitFactionGroup = UnitFactionGroup
local UnitIsPVP = UnitIsPVP
local UnitIsAFK = UnitIsAFK
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitInParty = UnitInParty
local UnitInRaid = UnitInRaid
local UnitOnTaxi = UnitOnTaxi
local WantsAlteredForm = _G.C_UnitAuras.WantsAlteredForm
local GetShapeshiftFormID = GetShapeshiftFormID
local GetExpansionDisplayInfo = GetExpansionDisplayInfo
local GetClientDisplayExpansionLevel = GetClientDisplayExpansionLevel
local MoveViewLeftStart = MoveViewLeftStart
local MoveViewLeftStop = MoveViewLeftStop
local NewTicker, NewTimer, TimerAfter = _G.C_Timer.NewTicker, _G.C_Timer.NewTimer, _G.C_Timer.After

local RAID_CLASS_COLORS = RAID_CLASS_COLORS

--Retail only API
local GetAtlasInfo
local GetSpecializationInfo
local GetSpecialization
local PetBattles_IsInBattle
local IsRecipeRepeating
local GetStreamInfo
local GetClubInfo
local GetGlidingInfo

--Retail and Cata API
local GetNumDayEvents
local GetDayEvent

--Cata and Wrath API
local GetNumTalentTabs
local GetTalentTabInfo

--Classic only API
local CastingInfo
local GetCurrentGameModeRecordID
local GetGameModeDisplayInfo

if wowVersion == "retail" or wowVersion == "cata" then
	GetNumDayEvents = _G.C_Calendar.GetNumDayEvents
	GetDayEvent = _G.C_Calendar.GetDayEvent
end

if wowVersion == "cata" then
	GetNumTalentTabs = _G.GetNumTalentTabs
	GetTalentTabInfo = _G.GetTalentTabInfo
end

if wowVersion == "retail" then
	GetAtlasInfo = _G.C_Texture.GetAtlasInfo
	GetSpecializationInfo = _G.GetSpecializationInfo
	GetSpecialization = _G.GetSpecialization
	IsRecipeRepeating = _G.C_TradeSkillUI.IsRecipeRepeating
	PetBattles_IsInBattle = _G.C_PetBattles.IsInBattle
	GetStreamInfo = _G.C_Club.GetStreamInfo
	GetClubInfo = _G.C_Club.GetClubInfo
	GetGlidingInfo = _G.C_PlayerInfo.GetGlidingInfo
else
	CastingInfo = _G.CastingInfo
	GetCurrentGameModeRecordID = _G.C_GameRules.GetCurrentGameModeRecordID
	GetGameModeDisplayInfoByRecordID = _G.C_GameRules.GetGameModeDisplayInfoByRecordID
end

local UIParent = _G.UIParent

local ignoreKeys = {
	LALT = true,
	LSHIFT = true,
	RSHIFT = true,
}
local printKeys = {
	PRINTSCREEN = true,
}

if IsMacClient() then
	printKeys[_G.KEY_PRINTSCREEN_MAC] = true
end

local isCamp = false

SLASH_AFKSCampToggle1 = "/AFKCAMP"
function SlashCmdList.AFKSCampToggle()
	if isCamp then
		isCamp = false
		print(AFKS_CAMPOFF)
	else
		isCamp = true
		print(AFKS_CAMPON)
	end
end

local public_channels = {
	["retail"] = {26, 42},
	["cata"] = {23, 25, 26},
	["classic"] = {23, 24, 25},
}

local default_options = {
	enabled = true,
	hidechat = true,  --lnui
	group = false,
}

function AFKS:OnEvent(event, ...)
	if event == "VARIABLES_LOADED" then
		AFKS_DB = AFKS_DB or CopyTable(default_options)
		self.options = AFKS_DB

		self:Toggle()
		self:RenderOptions()
		if wowVersion == "classic" and C_GameRules.IsHardcoreActive() then
			self.isHardcore = true
		end
	end

	if event == "PLAYER_REGEN_DISABLED" or event == "LFG_PROPOSAL_SHOW" or event == "UPDATE_BATTLEFIELD_STATUS" or event == "PARTY_INVITE_REQUEST" then
		if event == "UPDATE_BATTLEFIELD_STATUS" then
			local status = GetBattlefieldStatus(...)
			if status == "confirm" then
				self:SetAFK(false)
			end
		else
			self:SetAFK(false)
		end

		if event == "PLAYER_REGEN_DISABLED" then
			self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEvent")
			if self.isAFK then
				self.isInterrupted = true
			end
		end
		return
	end

	if event == "PLAY_MOVIE" then
		self.isCinematic = true
	end

	if event == "TALKINGHEAD_REQUESTED" and self.isAFK then
		self:SetAFK(false)
	end

	if event == "PLAYER_REGEN_ENABLED" then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		if self.isInterrupted then
			TimerAfter(0.5, function() self:SetAFK(false) end)
			self.isInterrupted = false
		end
	end
	if event == "PLAYER_CONTROL_GAINED" and UnitOnTaxi("player") and UnitIsPVP("player") then
		self:SetAFK(false)
	end

	if not self.options.enabled then
		return
	end

	if self.isCinematic then
		if MovieFrame:IsShown() then
			return
		else
			if not UnitIsAFK("player") then
				self.isCinematic = false
			end
		end
	end

	if self.isHardcore then
		return
	end

	if not self.options.group and (IsInGroup() or (wowVersion == "retail" and PetBattles_IsInBattle())) then
		return
	end

	if wowVersion == "retail" and GetGlidingInfo() then
		return
	end

	if UnitIsPVP("player") and (GetZonePVPInfo() == "combat" or GetZonePVPInfo() == "contested" or GetZonePVPInfo() == "hostile") then
		return
	end
	if UnitIsDeadOrGhost("player") or InCombatLockdown() then
		return
	end
	if wowVersion == "retail" then
		if IsRecipeRepeating() then
			 --Don't activate afk if player is crafting stuff, check back in 30 seconds
			TimerAfter(30, function() self:OnEvent() end)
			return
		elseif ( ProfessionsFrame and ProfessionsFrame:IsShown() ) or ( ProfessionsCustomerOrdersFrame and ProfessionsCustomerOrdersFrame:IsShown() ) then
			return
		end
	else
		if CastingInfo() then
			 --Don't activate afk if player is crafting stuff, check back in 30 seconds
			TimerAfter(30, function() self:OnEvent() end)
			return
		end
	end
	
	if UnitIsAFK("player") and not self.isAFK then
		if wowVersion == "retail" and PVEFrame and PVEFrame:IsShown() or isCamp then return end
		self:SetAFK(true)
	elseif not UnitIsAFK("player") then
		self:SetAFK(false)
	end
end

function AFKS:Toggle()
	if(self.options.enabled) then
		self:RegisterEvent("PLAYER_FLAGS_CHANGED", "OnEvent")
		self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnEvent")
		self:RegisterEvent("PLAYER_CONTROL_GAINED", "OnEvent")
		self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS", "OnEvent")
		self:RegisterEvent("PLAY_MOVIE", "OnEvent")
		if wowVersion == "retail" then
			self:RegisterEvent("LFG_PROPOSAL_SHOW", "OnEvent")
			self:RegisterEvent("PARTY_INVITE_REQUEST", "OnEvent")
			self:RegisterEvent("TALKINGHEAD_REQUESTED", "OnEvent")
		end
		SetCVar("autoClearAFK", "1")
	else
		self:UnregisterEvent("PLAYER_FLAGS_CHANGED")
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		self:UnregisterEvent("PLAYER_CONTROL_GAINED")
		self:UnregisterEvent("UPDATE_BATTLEFIELD_STATUS")
		self:UnregisterEvent("PLAY_MOVIE")
		if wowVersion == "retail" then
			self:UnregisterEvent("LFG_PROPOSAL_SHOW")
			self:UnregisterEvent("PARTY_INVITE_REQUEST")
			self:UnregisterEvent("TALKINGHEAD_REQUESTED")
		end
	end
end

local function OnKeyDown(self, key)
	if(ignoreKeys[key]) then return end
	if printKeys[key] then
		Screenshot()
	else
		if InCombatLockdown() then return end
		AFKS:SetAFK(false)
		TimerAfter(60, function() AFKS:OnEvent() end)
	end
end

local function Chat_MouseDown(self, button)
	if button == "RightButton" then
		AFKS.AFKMode.chatminbar.minimized = true
		AFKS.AFKMode.chatminbar.unreadwhisper = 0
		AFKS.AFKMode.chatminbar.unreadbnet = 0
		AFKS.AFKMode.chatminbar.unreadchannel = 0
		AFKS.AFKMode.chatminbar.unreadguild = 0

		local text = format(AFKS_CHATBAR_TEXT, AFKS.AFKMode.chatminbar.unreadwhisper, AFKS.AFKMode.chatminbar.unreadbnet, AFKS.AFKMode.chatminbar.unreadchannel)
		if IsInGuild() then
			text = text.." "..format(AFKS_CHATBAR_GUILD, AFKS.AFKMode.chatminbar.unreadguild)
		end
		AFKS.AFKMode.chatminbar.title:SetText(text)
		AFKS.AFKMode.chatminbar.title:Show()
		AFKS.AFKMode.chatminbar:SetBackdropColor(.2, .2, .2, .8)
		self:Hide()
	elseif button == "LeftButton" and IsShiftKeyDown() then
		self:ClearAllPoints()
		self:SetPoint("BOTTOMLEFT", AFKSFrame, "BOTTOMLEFT", 4, 120)
	end
end

local function Chat_OnMouseWheel(self, delta)
	if delta == 1 then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		else
			self:ScrollUp()
		end
	elseif delta == -1 then
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		else
			self:ScrollDown()
		end
	end
end

local function ChatMinBar_MouseDown(self, button)
	if button == "LeftButton" or button == "RightButton" then
		AFKS.AFKMode.chatminbar.minimized = false
		AFKS.AFKMode.chatminbar.title:Hide()
		AFKS.AFKMode.chatminbar:SetBackdropColor(.2, .2, .2, 0)
		AFKS.AFKMode.chat:Show()
	end
end

local function TruncateToMaxLength(text, maxLength)
	local length = strlenutf8(text)
	if ( length > maxLength ) then
		return text:sub(1, maxLength - 2).."..."
	end
	return text
end

local function GetCommunityName(clubId, streamId)
	local communityName = ""
	local streamInfo = GetStreamInfo(clubId, streamId)
	if streamInfo and streamInfo.streamType == 0 then
		local clubInfo = GetClubInfo(clubId)
		communityName = clubInfo and TruncateToMaxLength(clubInfo.shortName or clubInfo.name, 12) or ""
	end
	
	return communityName
end

local function Chat_OnEvent(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
	local coloredName = GetColoredName(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
	local type = strsub(event, 10)
	local info = _G.ChatTypeInfo[type]

	arg1 = RemoveExtraSpaces(arg1)

	local chatGroup = _G.Chat_GetChatCategory(type)
	local chatTarget, body
	if ( chatGroup == "BN_CONVERSATION" ) then
		chatTarget = tostring(arg8)
	elseif ( chatGroup == "WHISPER" or chatGroup == "BN_WHISPER" ) then
		if(not(strsub(arg2, 1, 2) == "|K")) then
			chatTarget = arg2:upper()
		else
			chatTarget = arg2
		end
	end

	local playerLink
	local texture = ""
	if type == "BN_WHISPER" then
		local accountInfo = _G.C_BattleNet.GetAccountInfoByID(arg13)
		if accountInfo and accountInfo.gameAccountInfo.clientProgram ~= "" then
			texture = BNet_GetClientEmbeddedAtlas(accountInfo.gameAccountInfo.clientProgram, 14, 14)
		end
		playerLink = texture.."|HBNplayer:"..arg2..":"..arg13..":"..arg11..":"..chatGroup..(chatTarget and ":"..chatTarget or "").."|h"
		if AFKS.AFKMode.chatminbar.minimized then
			AFKS.AFKMode.chatminbar.unreadbnet = AFKS.AFKMode.chatminbar.unreadbnet + 1
			--print("bnet:"..AFKS.AFKMode.chatminbar.unreadbnet)
		end
	else
		playerLink = "|Hplayer:"..arg2..":"..arg11..":"..chatGroup..(chatTarget and ":"..chatTarget or "").."|h"
	end

	local message = arg1
	if ( arg14 ) then	--isMobile
		message = _G.ChatFrame_GetMobileEmbeddedTexture(info.r, info.g, info.b)..message
	end
	
	--Escape any % characters, as it may otherwise cause an "invalid option in format" error in the next step
	message = gsub(message, "%%", "%%%%")

	local success
	success, body = pcall(format, _G["CHAT_"..type.."_GET"]..message, playerLink.."["..coloredName.."]".."|h")
	if not success then
		print("Error:", type, message, _G["CHAT_"..type.."_GET"])
	end
	if type == "COMMUNITIES_CHANNEL" then
		local prefix, channelCode = arg4:match("(%d+. )(.*)")
		local clubId, streamId = channelCode:match("(%d+)%:(%d+)")
		clubId = tonumber(clubId)
		streamId = tonumber(streamId)

		type = _G.Chat_GetCommunitiesChannel(clubId, streamId)
		info = _G.ChatTypeInfo[type]
		body = "[" .. prefix .. GetCommunityName(clubId, streamId) .. "] " .. body
		if AFKS.AFKMode.chatminbar.minimized then
			AFKS.AFKMode.chatminbar.unreadchannel = AFKS.AFKMode.chatminbar.unreadchannel + 1
		end
	elseif type == "CHANNEL" then
		if arg7 == 1 or arg7 == 2 or arg7 == 22 then
			return
		end
		for k, v in pairs(public_channels[wowVersion]) do
			if arg7 == v then
				return
			end
		end
		info = _G.ChatTypeInfo[type..arg8]
		body = "[" .. arg4 .. "]" .. body
		if AFKS.AFKMode.chatminbar.minimized then
			AFKS.AFKMode.chatminbar.unreadchannel = AFKS.AFKMode.chatminbar.unreadchannel + 1
		end
	end

	local accessID = _G.ChatHistory_GetAccessID(chatGroup, chatTarget)
	local typeID = _G.ChatHistory_GetAccessID(type, chatTarget, arg12 == "" and arg13 or arg12)

	if AFKS.AFKMode.chatminbar.minimized then
		if type == "WHISPER" then
			AFKS.AFKMode.chatminbar.unreadwhisper = AFKS.AFKMode.chatminbar.unreadwhisper + 1
			--print("whisper:"..AFKS.AFKMode.chatminbar.unreadwhisper)
		elseif type == "GUILD" then
			AFKS.AFKMode.chatminbar.unreadguild = AFKS.AFKMode.chatminbar.unreadguild + 1
		end
		local unreadwhisper, unreadbnet, unreadchannel = AFKS.AFKMode.chatminbar.unreadwhisper, AFKS.AFKMode.chatminbar.unreadbnet, AFKS.AFKMode.chatminbar.unreadchannel
		if unreadwhisper > 0 then
			unreadwhisper = "|cffffffff"..unreadwhisper.."|r"
		end
		if unreadbnet > 0 then
			unreadbnet = "|cffffffff"..unreadbnet.."|r"
		end
		if unreadchannel > 0 then
			unreadchannel = "|cffffffff"..unreadchannel.."|r"
		end
		local text = format(AFKS_CHATBAR_TEXT, unreadwhisper, unreadbnet, unreadchannel)
		if IsInGuild() then
			local unreadguild = AFKS.AFKMode.chatminbar.unreadguild
			if unreadguild > 0 then
				unreadguild = "|cffffffff"..unreadguild.."|r"
			end
			text = text.." "..format(AFKS_CHATBAR_GUILD, unreadguild)
		end

		AFKS.AFKMode.chatminbar.title:SetText(text)
	end

	self:AddMessage(body, info.r, info.g, info.b, info.id, false, accessID, typeID)
end

local function LoopAnimations()
	if(AFKSPlayerModel.curAnimation == "wave") then
		AFKSPlayerModel:SetAnimation(69)
		AFKSPlayerModel.curAnimation = "dance"
		AFKSPlayerModel.startTime = GetTime()
		AFKSPlayerModel.duration = 300
		AFKSPlayerModel.isIdle = false
		AFKSPlayerModel.idleDuration = 120
	end
end

local function FontTemplate(fs, fontSize, outline)
	fontSize = fontSize or 12

	if not outline then
		outline = ""
	end
	fs:SetFont(_G.STANDARD_TEXT_FONT, fontSize, outline)
	fs:SetShadowColor(0, 0, 0, 1)
	fs:SetShadowOffset(1, -1)
end

local function SetTemplate(Frame)
	local blank = "Interface/BUTTONS/WHITE8X8"

	Frame:SetBackdrop({
		bgFile = blank,
		edgeFile = blank,
		tile = false, tileSize = 0, edgeSize = 1,
		insets = { left = -1, right = -1, top = -1, bottom = -1},
	})

	if not Frame.isInsetDone then
		Frame.InsetTop = Frame:CreateTexture(nil, "BORDER")
		Frame.InsetTop:SetPoint("TOPLEFT", Frame, "TOPLEFT", -1, 1)
		Frame.InsetTop:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", 1, -1)
		Frame.InsetTop:SetHeight(1)
		Frame.InsetTop:SetColorTexture(0,0,0)
		Frame.InsetTop:SetDrawLayer("BORDER", -7)

		Frame.InsetBottom = Frame:CreateTexture(nil, "BORDER")
		Frame.InsetBottom:SetPoint("BOTTOMLEFT", Frame, "BOTTOMLEFT", -1, -1)
		Frame.InsetBottom:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", 1, -1)
		Frame.InsetBottom:SetHeight(1)
		Frame.InsetBottom:SetColorTexture(0,0,0)
		Frame.InsetBottom:SetDrawLayer("BORDER", -7)

		Frame.InsetLeft = Frame:CreateTexture(nil, "BORDER")
		Frame.InsetLeft:SetPoint("TOPLEFT", Frame, "TOPLEFT", -1, 1)
		Frame.InsetLeft:SetPoint("BOTTOMLEFT", Frame, "BOTTOMLEFT", 1, -1)
		Frame.InsetLeft:SetWidth(1)
		Frame.InsetLeft:SetColorTexture(0,0,0)
		Frame.InsetLeft:SetDrawLayer("BORDER", -7)

		Frame.InsetRight = Frame:CreateTexture(nil, "BORDER")
		Frame.InsetRight:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", 1, 1)
		Frame.InsetRight:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", -1, -1)
		Frame.InsetRight:SetWidth(1)
		Frame.InsetRight:SetColorTexture(0,0,0)
		Frame.InsetRight:SetDrawLayer("BORDER", -7)

		Frame.InsetInsideTop = Frame:CreateTexture(nil, "BORDER")
		Frame.InsetInsideTop:SetPoint("TOPLEFT", Frame, "TOPLEFT", 1, -1)
		Frame.InsetInsideTop:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -1, 1)
		Frame.InsetInsideTop:SetHeight(1)
		Frame.InsetInsideTop:SetColorTexture(0,0,0)
		Frame.InsetInsideTop:SetDrawLayer("BORDER", -7)

		Frame.InsetInsideBottom = Frame:CreateTexture(nil, "BORDER")
		Frame.InsetInsideBottom:SetPoint("BOTTOMLEFT", Frame, "BOTTOMLEFT", 1, 1)
		Frame.InsetInsideBottom:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", -1, 1)
		Frame.InsetInsideBottom:SetHeight(1)
		Frame.InsetInsideBottom:SetColorTexture(0,0,0)
		Frame.InsetInsideBottom:SetDrawLayer("BORDER", -7)

		Frame.InsetInsideLeft = Frame:CreateTexture(nil, "BORDER")
		Frame.InsetInsideLeft:SetPoint("TOPLEFT", Frame, "TOPLEFT", 1, -1)
		Frame.InsetInsideLeft:SetPoint("BOTTOMLEFT", Frame, "BOTTOMLEFT", -1, 1)
		Frame.InsetInsideLeft:SetWidth(1)
		Frame.InsetInsideLeft:SetColorTexture(0,0,0)
		Frame.InsetInsideLeft:SetDrawLayer("BORDER", -7)

		Frame.InsetInsideRight = Frame:CreateTexture(nil, "BORDER")
		Frame.InsetInsideRight:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -1, -1)
		Frame.InsetInsideRight:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", 1, 1)
		Frame.InsetInsideRight:SetWidth(1)
		Frame.InsetInsideRight:SetColorTexture(0,0,0)
		Frame.InsetInsideRight:SetDrawLayer("BORDER", -7)

		Frame.isInsetDone = true
	end

	Frame:SetBackdropBorderColor(.31, .31, .31)
	if wowVersion == "retail" then
		Frame:SetBackdropColor(.06, .06, .06, 0)
	else
		Frame:SetBackdropColor(.06, .06, .06, .8)
	end
end

local function SetSpecPanel()
	local function SetLeftEndColor(specid)
		local ColorBySpecID = {
			-- Death Knight
			[250] = {0.082, 0.078, 0.078},
			[251] = {0.019, 0.11, 0.176},
			[252] = {0.07, 0.082, 0.027},

			-- Demon Hunter
			[577] = {0.043, 0.1, 0.078},
			[581] = {0.07, 0.055, 0.18},

			-- Druid
			[102] = {0.086, 0.1, 0.243},
			[103] = {0.082, 0.129, 0.188},
			[104] = {0.172, 0.086, 0.002},
			[105] = {0.058, 0.086, 0.002},

			-- Evoker
			[1467] = {0.1, 0.063, 0.1},
			[1468] = {0.062, 0.121, 0.105},
			[1473] = {0.1, 0.1, 0.067},

			-- Hunter
			[253] = {0.082, 0.098, 0.235},
			[254] = {0.066, 0.09, 0.043},
			[255] = {0.176, 0.152, 0.137},

			-- Mage
			[62] = {0.066, 0.023, 0.141},
			[63] = {0.1, 0.059, 0.035},
			[64] = {0.062, 0.078, 0.145},

			-- Monk
			[268] = {0.082, 0.09, 0},
			[269] = {0.125, 0.1, 0.16},
			[270] = {0.118, 0.149, 0.255},

			-- Paladin
			[65] = {0.1, 0.067, 0.047},
			[66] = {0.176, 0.067, 0.129},
			[70] = {0.184, 0.145, 0.047},

			-- Priest
			[256] = {0.066, 0.086, 0.1},
			[257] = {0.18, 0.145, 0.122},
			[258] = {0.113, 0.07, 0.086},

			-- Rogue
			[259] = {0.113, 0.066, 0.003},
			[260] = {0.043, 0.086, 0.082},
			[261] = {0.075, 0.043, 0.075},

			-- Shaman
			[262] = {0.003, 0.078, 0.149},
			[263] = {0.074, 0.07, 0.156},
			[264] = {0.082, 0.086, 0.121},

			-- Warlock
			[265] = {0.07, 0.063, 0.22},
			[266] = {0.078, 0.078, 0.074},
			[267] = {0.1, 0.055, 0.031},

			-- Warrior
			[71] = {0.05, 0.078, 0.082},
			[72] = {0.066, 0.07, 0.074},
			[73] = {0.1, 0.078, 0.071},
		}

		local r, g, b = unpack(ColorBySpecID[specid])
		AFKS.AFKMode.bottom.leftendtex:SetColorTexture(r, g, b)
		AFKS.AFKMode.bottom.leftendtex:SetSize(GetScreenWidth() - 1567, panelheight - 3)
		AFKS.AFKMode.bottom.leftendtex:Show()
	end

	local SpecIDToBackgroundAtlas = {
		-- Death Knight
		[250] = "talents-background-deathknight-blood",
		[251] = "talents-background-deathknight-frost",
		[252] = "talents-background-deathknight-unholy",

		-- Demon Hunter
		[577] = "talents-background-demonhunter-havoc",
		[581] = "talents-background-demonhunter-vengeance",

		-- Druid
		[102] = "talents-background-druid-balance",
		[103] = "talents-background-druid-feral",
		[104] = "talents-background-druid-guardian",
		[105] = "talents-background-druid-restoration",

		-- Evoker
		[1467] = "talents-background-evoker-devastation",
		[1468] = "talents-background-evoker-preservation",
		[1473] = "talents-background-evoker-augmentation",

		-- Hunter
		[253] = "talents-background-hunter-beastmastery",
		[254] = "talents-background-hunter-marksmanship",
		[255] = "talents-background-hunter-survival",

		-- Mage
		[62] = "talents-background-mage-arcane",
		[63] = "talents-background-mage-fire",
		[64] = "talents-background-mage-frost",

		-- Monk
		[268] = "talents-background-monk-brewmaster",
		[269] = "talents-background-monk-windwalker",
		[270] = "talents-background-monk-mistweaver",

		-- Paladin
		[65] = "talents-background-paladin-holy",
		[66] = "talents-background-paladin-protection",
		[70] = "talents-background-paladin-retribution",

		-- Priest
		[256] = "talents-background-priest-discipline",
		[257] = "talents-background-priest-holy",
		[258] = "talents-background-priest-shadow",

		-- Rogue
		[259] = "talents-background-rogue-assassination",
		[260] = "talents-background-rogue-outlaw",
		[261] =  "talents-background-rogue-subtlety",

		-- Shaman
		[262] = "talents-background-shaman-elemental",
		[263] = "talents-background-shaman-enhancement",
		[264] = "talents-background-shaman-restoration",

		-- Warlock
		[265] = "talents-background-warlock-affliction",
		[266] = "talents-background-warlock-demonology",
		[267] = "talents-background-warlock-destruction",

		-- Warrior
		[71] = "talents-background-warrior-arms",
		[72] = "talents-background-warrior-fury",
		[73] = "talents-background-warrior-protection",
	}

	local panel_offset = { -- 0.049 + offset to toptexcoord
		[63] = 0.01, -- Fire Mage
		[64] = 0.05, -- Frost Mage
		[65] = -0.015, -- Holy Paladin
		[66] = 0.01, -- Protect Paladin
		[70] = 0.075, -- Ret Paladin
		[71] = 0.042, -- Arms Warrior
		[72] = 0.005, -- Fury Warrior
		[73] = 0.037, -- Protect Warrior
		[102] = 0.006, -- Balance Druid
		[103] = 0.037, -- Feral Druid
		[104] = 0.025, -- Guardian Druid
		[105] = 0.01, -- Resto Druid
		[250] = -0.02, -- Blood DK
		[251] = -0.01, -- Frost DK
		[252] = 0.117, -- Unholy DK
		[253] = -0.01, -- Beast Hunter
		[254] = 0.005, -- Marksmanship Hunter
		[255] = 0.057, -- Survival Hunter
		[256] = 0.012, -- Discipline Priest
		[259] = 0.02, -- Assassination Rogue
		[261] = 0.064, -- Subtlety Rogue
		[262] = 0.037, -- Elemental Shaman
		[263] = -0.01, -- Enhancement Shaman
		[264] = 0.037, -- Resto Shaman
		[265] = 0.02, -- Affl Warlock
		[266] = -0.035, -- Demon Warlock
		[267] = 0.03, -- Dest Warlock
		[268] = 0.025, -- Brew Monk
		[269] = 0.015, -- Wind Monk
		[577] = 0.012, -- Havoc DH
		[581] = 0.022, -- Vengeance DH
		[1467] = 0.014, -- Devast Evoker
		[1468] = 0.023, -- Preserv Evoker
		[1473] = 0.023, -- Augment Evoker
	}

	local model_yoffset = {
		[1] = 30, -- Human
		[2] = -15, -- Orc
		[3] = -10, -- Dwarf
		[5] = 10, -- Undead
		[6] = 35, -- Tauren
		[8] = 10, -- Troll
		[9] = -10, -- Goblin
		[11] = 8, -- Draenei
		[24] = 0, -- Pandaren (Neutral)
		[25] = 0, -- Pandaren (Alliance)
		[26] = 0, -- Pandaren (Horde)
		[28] = 25, -- Highmountain
		[30] = 20, -- Lightforged
		[31] = 5, -- Zandalari
		[32] = 15, -- Kul Tiran
		[34] = -20, -- Dark Iron Dwarf
		[85] = 10, -- Earthen
	}

	local needs_to_resize = {
		[3] = 1.6,
		[8] = 1.8,
		[9] = 1.7,
		[24] = 1.5,
		[25] = 1.5,
		[26] = 1.5,
		[28] = 1.8,
		[32] = 1.8,
		[34] = 1.6
	}

	local yoffset = GetScreenHeight() * 0.1 - 102.4
	if yoffset < 0 then
		yoffset = yoffset * 2.3
	else
		yoffset = yoffset * 3.5
	end
	
	local raceid = select(3, UnitRace("player"))

	if needs_to_resize[raceid] then
		AFKS.AFKMode.bottom.model:SetSize(GetScreenWidth() * needs_to_resize[raceid], GetScreenHeight() * needs_to_resize[raceid])
	end

	if raceid == 22 then -- Worgen
		if WantsAlteredForm("player") then
			AFKS.AFKMode.bottom.model:SetSize(GetScreenWidth() * 1.8, GetScreenHeight() * 1.8)
			yoffset = yoffset + 30
		else
			AFKS.AFKMode.bottom.model:SetSize(GetScreenWidth() * 2, GetScreenHeight() * 2)
			yoffset = yoffset + -7
		end
	elseif raceid == 52 or raceid == 70 then -- Dracthyr
		if WantsAlteredForm("player") then
			AFKS.AFKMode.bottom.model:SetSize(GetScreenWidth() * 1.7, GetScreenHeight() * 1.7)
			yoffset = yoffset + 30
		else
			AFKS.AFKMode.bottom.model:SetSize(GetScreenWidth() * 2, GetScreenHeight() * 2)
			yoffset = yoffset + -7
		end
	else
		if model_yoffset[raceid] then
			yoffset = yoffset + model_yoffset[raceid]
		end
	end

	if select(2, UnitClass("player")) == "DRUID" then
		if GetShapeshiftFormID() == 5 then -- Bear form
			AFKS.AFKMode.bottom.model:SetSize(GetScreenWidth() * 1, GetScreenHeight() * 1)
			yoffset = yoffset + -120
		elseif GetShapeshiftFormID() == 1 then -- Cat form
			AFKS.AFKMode.bottom.model:SetSize(GetScreenWidth() * 2, GetScreenHeight() * 2)
			yoffset = yoffset - 135
		elseif GetShapeshiftFormID() == 27 or GetShapeshiftFormID() == 29 then -- Flying form
			AFKS.AFKMode.bottom.model:SetSize(GetScreenWidth() * 1.4, GetScreenHeight() * 1.4)
			yoffset = yoffset + -10
		elseif GetShapeshiftFormID() == 31 or GetShapeshiftFormID() == 35 then -- Moonkin form
			AFKS.AFKMode.bottom.model:SetSize(GetScreenWidth() * 2, GetScreenHeight() * 2)
			yoffset = yoffset + -55
		elseif GetShapeshiftFormID() == 36 then -- Treant form
			AFKS.AFKMode.bottom.model:SetSize(GetScreenWidth() * 1.2, GetScreenHeight() * 1.2)
			yoffset = yoffset + -30
		else
			if needs_to_resize[raceid] then
				AFKS.AFKMode.bottom.model:SetSize(GetScreenWidth() * needs_to_resize[raceid], GetScreenHeight() * needs_to_resize[raceid])
			else
				AFKS.AFKMode.bottom.model:SetSize(GetScreenWidth() * 2, GetScreenHeight() * 2)
			end
		end
	end
	AFKS.AFKMode.bottom.modelHolder:ClearAllPoints()
	AFKS.AFKMode.bottom.modelHolder:SetPoint("BOTTOMRIGHT", AFKS.AFKMode.bottom, "BOTTOMRIGHT", -220, 265 + yoffset)

	local specid = select(1, GetSpecializationInfo(GetSpecialization())) 
	local atlasinfo = specid and SpecIDToBackgroundAtlas[specid]
	local offset = panel_offset[specid] or 0
	local info = atlasinfo and GetAtlasInfo(atlasinfo)

	if info then
		AFKS.AFKMode.bottom:SetBackdropColor(.06, .06, .06, 0)
		AFKS.AFKMode.bottom.specpanel:Show()
		AFKS.AFKMode.bottom.specpanel:SetTexture(info.file)
		AFKS.AFKMode.bottom.specpanel:SetTexCoord(info.leftTexCoord, info.rightTexCoord, info.topTexCoord+0.049+offset, info.bottomTexCoord)
		if GetScreenWidth() - 1567 > 0 then
			SetLeftEndColor(specid)
		else
			AFKS.AFKMode.bottom.leftendtex:Hide()
		end
	else
		AFKS.AFKMode.bottom:SetBackdropColor(.06, .06, .06, .8)
		AFKS.AFKMode.bottom.specpanel:Hide()
		AFKS.AFKMode.bottom.leftendtex:Hide()
	end
end

local function SetSpecIcon()
	if UnitLevel("player") >= 10 then
		if wowVersion == "retail" then
			local _, _, _, specicon = select(1, GetSpecializationInfo(GetSpecialization())) 
			if specicon then
				AFKS.AFKMode.bottom.specicon:SetTexture(specicon)
				AFKS.AFKMode.bottom.specicon:Show()
			else
				AFKS.AFKMode.bottom.specicon:Hide()
			end
		else
			if wowVersion == "cata" then
				local talent_points = {}
				local spent = 0
				local specicon

				for i=1, GetNumTalentTabs() do
					talent_points[i] = {}
					talent_points[i]["icon"] = select(4, GetTalentTabInfo(i))
					talent_points[i]["spent"] = select(5, GetTalentTabInfo(i))
				end
				for k, v in pairs(talent_points) do
					if k == 1 then
						spent = v["spent"]
						specicon = v["icon"]
					else
						if v["spent"] > spent then
							specicon = v["icon"]
							spent = v["spent"]
						end
					end
				end
				if specicon then
					AFKS.AFKMode.bottom.specicon:SetTexture(specicon)
					AFKS.AFKMode.bottom.specicon:Show()
				else
					AFKS.AFKMode.bottom.specicon:Hide()
				end
			else
				local primaryTalent
				local talent_tree = {}

				for i=1, GetNumTalentTabs() do
					talent_tree[i] = select(3, GetTalentTabInfo(i))
				end
				for k, v in pairs(talent_tree) do
					if k > 1 and v > talent_tree[k-1] then
						primaryTalent = k
					else
						primaryTalent = 1
					end
				end
				if primaryTalent == 1 and talent_tree[1] == 0 then
					AFKS.AFKMode.bottom.specicon:Hide()
					return
				end

				local specicon = select(2, GetTalentTabInfo(primaryTalent))
				if specicon then
					AFKS.AFKMode.bottom.specicon:SetTexture(specicon)
					AFKS.AFKMode.bottom.specicon:Show()
				else
					AFKS.AFKMode.bottom.specicon:Hide()
				end
			end
		end
	else
		AFKS.AFKMode.bottom.specicon:Hide()
	end
end

local function SetDate(weekday_str, weekday_num)
	local weekday
	if eastasian then
		local localized_weekday = {
			_G.WEEKDAY_SUNDAY,
			_G.WEEKDAY_MONDAY,
			_G.WEEKDAY_TUESDAY,
			_G.WEEKDAY_WEDNESDAY,
			_G.WEEKDAY_THURSDAY,
			_G.WEEKDAY_FRIDAY,
			_G.WEEKDAY_SATURDAY,
		}

		weekday = localized_weekday[weekday_num+1]
	else
		weekday = weekday_str
	end

	if weekday_num == 6 then -- Sat
		weekday = "|cFF2b59FF"..weekday.."|r"
	elseif weekday_num == 0 then -- Sun
		weekday = "|cFFFF2b2b"..weekday.."|r"
	end

	if eastasian then -- East Asian date format check
		AFKS.AFKMode.bottom.date:SetText(format(AFKS_DATEFORMAT, date("%Y"), date("%m"), date("%d"), weekday))
	else
		AFKS.AFKMode.bottom.date:SetText(format(AFKS_DATEFORMAT, date("%b"), date("%d"), date("%Y"), weekday))
	end
end

local function GetCalendarSchedule(day, hour)
	for i = 1, GetNumDayEvents(0, day) do
		local event = GetDayEvent(0, day, i)
		if event and event.calendarType == "PLAYER" and event.startTime.hour > hour then
			if event.inviteStatus == 2 or event.inviteStatus == 4 then
				return
			end

			if event.inviteStatus == 1 then
				AFKS.AFKMode.bottom.schedule:SetTextColor(0, 1, 0)
			end
			AFKS.AFKMode.bottom.calendaricon:SetTexture(event.iconTexture)
			local minute = event.startTime.minute
			if event.startTime.minute < 10 then
				minute = "0"..minute
			end

			local ampm
			if event.startTime.hour < 12 then
				ampm = _G.TIMEMANAGER_AM
			else
				ampm = _G.TIMEMANAGER_PM
				if event.startTime.hour > 12 then
					event.startTime.hour = event.startTime.hour - 12
				end
			end

			if eastasian then
				AFKS.AFKMode.bottom.schedule:SetText("("..ampm.." "..event.startTime.hour..":"..minute..") "..event.title)
			else
				AFKS.AFKMode.bottom.schedule:SetText(event.title.." in "..event.startTime.hour..":"..minute.." "..ampm)
			end
			break
		end
	end                   
end

local function GetWoWLogo()
	local expansion
	if wowVersion == "retail" then
		expansion = GetExpansionDisplayInfo(GetClientDisplayExpansionLevel())
	elseif wowVersion == "wrath" or wowVersion == "cata" then
		expansion = GetExpansionDisplayInfo(GetClientDisplayExpansionLevel(), _G.LE_RELEASE_TYPE_CLASSIC)
	else
		local gameModeRecordID = GetCurrentGameModeRecordID()
		expansion = GetGameModeDisplayInfoByRecordID(gameModeRecordID)
	end
	return expansion and expansion.logo
end

function AFKS:RenderOptions()
	local panel = CreateFrame("Frame", "AFKS_OptionPanel")
	panel.name = "AFKS"

	local title = panel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 10, -10)
	title:SetText("AFKS")

	local enable = CreateFrame("CheckButton", nil, panel, "ChatConfigCheckButtonTemplate")
	enable:SetPoint("TOPLEFT", 10, -35)
	enable.Text:SetText(AFKS_ENABLED_TEXT)
	enable.tooltip = AFKS_ENABLED_TOOLTIP
	enable:HookScript("OnClick", function(_, btn, down)
		self.options.enabled = enable:GetChecked()
		self:Toggle()
	end)
	enable:SetChecked(self.options.enabled)

	local hidechat = CreateFrame("CheckButton", nil, panel, "ChatConfigCheckButtonTemplate")
	hidechat:SetPoint("TOPLEFT", 10, -65)
	hidechat.Text:SetText(AFKS_HIDECHAT_TEXT)
	hidechat.tooltip = AFKS_HIDECHAT_TOOLTIP
	hidechat:HookScript("OnClick", function(_, btn, down)
		self.options.hidechat = hidechat:GetChecked()
	end)
	hidechat:SetChecked(self.options.hidechat)

	local group = CreateFrame("CheckButton", nil, panel, "ChatConfigCheckButtonTemplate")
	group:SetPoint("TOPLEFT", 10, -95)
	group.Text:SetText(AFKS_GROUP_TEXT)
	group.tooltip = AFKS_GROUP_TOOLTIP
	group:HookScript("OnClick", function(_, btn, down)
		self.options.group = group:GetChecked()
	end)
	group:SetChecked(self.options.group)

	local category, layout = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
	Settings.RegisterAddOnCategory(category)
	category.ID = panel.name
end

function AFKS:Init()
	local logo = GetWoWLogo()
	local class = select(2, UnitClass("player"))

	UIscale = UIParent:GetScale()
	if panelheight < 102 then -- Adjust to 102.4 in small resolution
		panelheight = 102.4
	end

	self.AFKMode = CreateFrame("Frame", "AFKSFrame")
	self.AFKMode:SetFrameLevel(1)
	self.AFKMode:SetScale(UIscale)
	self.AFKMode:SetAllPoints(UIParent)
	self.AFKMode:Hide()
	self.AFKMode:EnableKeyboard(true)
	self.AFKMode:SetScript("OnKeyDown", OnKeyDown)

	self.AFKMode.exitpanel = CreateFrame("Frame", nil, self.AFKMode)
	self.AFKMode.exitpanel:SetSize(30, 30)
	self.AFKMode.exitpanel:SetPoint("TOPRIGHT", self.AFKMode, "TOPRIGHT", 0, 0)
	self.AFKMode.exitbutton = CreateFrame("Button", nil, self.AFKMode.exitpanel, "UIPanelCloseButton")
	self.AFKMode.exitbutton:SetSize(25, 25)
	self.AFKMode.exitbutton:SetPoint("CENTER", self.AFKMode.exitpanel, 0, 0)
	self.AFKMode.exitbutton:Hide()
	self.AFKMode.exitbutton:SetScript("OnClick", function()
		UIParent:Show()
		AFKS.AFKMode:Hide()
		MoveViewLeftStop()

		AFKS.timer:Cancel()
		if AFKS.animTimer then
			AFKS.animTimer:Cancel()
		end
		AFKS.AFKMode.bottom.timer:SetText("00:00")

		AFKS.AFKMode.exitbutton:Hide()
		AFKS.AFKMode.chat:UnregisterAllEvents()
		AFKS.AFKMode.chat:Clear()

		AFKS.isAFK = false
		AFKS.isCinematic = false
	end)
	self.AFKMode.exitpanel:SetScript("OnMouseDown", function() AFKS.AFKMode.exitbutton:Show() end)

	self.AFKMode.chat = CreateFrame("ScrollingMessageFrame", nil, self.AFKMode)
	self.AFKMode.chat:SetSize(500, 300)
	self.AFKMode.chat:SetPoint("BOTTOMLEFT", self.AFKMode, "BOTTOMLEFT", 4, 120)
	FontTemplate(self.AFKMode.chat, 18)
	self.AFKMode.chat:SetJustifyH("LEFT")
	self.AFKMode.chat:SetMaxLines(500)
	self.AFKMode.chat:SetClampedToScreen(true)
	self.AFKMode.chat:EnableMouseWheel(true)
	self.AFKMode.chat:SetFading(false)
	self.AFKMode.chat:SetMovable(true)
	self.AFKMode.chat:EnableMouse(true)
	self.AFKMode.chat:RegisterForDrag("LeftButton")
	self.AFKMode.chat:SetScript("OnDragStart", self.AFKMode.chat.StartMoving)
	self.AFKMode.chat:SetScript("OnDragStop", self.AFKMode.chat.StopMovingOrSizing)
	self.AFKMode.chat:SetScript("OnMouseDown", Chat_MouseDown)
	self.AFKMode.chat:SetScript("OnMouseWheel", Chat_OnMouseWheel)
	self.AFKMode.chat:SetScript("OnEvent", Chat_OnEvent)

	self.AFKMode.bottom = CreateFrame("Frame", nil, self.AFKMode, BackdropTemplateMixin and "BackdropTemplate")
	self.AFKMode.bottom:SetFrameLevel(0)
	SetTemplate(self.AFKMode.bottom)
	self.AFKMode.bottom:SetPoint("BOTTOM", self.AFKMode, "BOTTOM", 0, -2)
	self.AFKMode.bottom:SetWidth(GetScreenWidth() + 4)
	self.AFKMode.bottom:SetHeight(panelheight)

	self.AFKMode.bottom.logo = self.AFKMode:CreateTexture(nil, "OVERLAY")
	self.AFKMode.bottom.logo:SetSize(192, 192)  --lnui
	self.AFKMode.bottom.logo:SetPoint("CENTER", self.AFKMode.bottom, "CENTER", 0, 40)  --lnui
	self.AFKMode.bottom.logo:SetTexture("Interface/AddOns/!!!163UI!!!/Textures/UI2-logo")  --lnui

	self.AFKMode.chatminbar = CreateFrame("Frame", nil, self.AFKMode, BackdropTemplateMixin and "BackdropTemplate")
	self.AFKMode.chatminbar:SetPoint("BOTTOMLEFT", self.AFKMode.bottom, "TOPLEFT", 0, 2)
	self.AFKMode.chatminbar:SetSize(350, 20)
	self.AFKMode.chatminbar:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = nil,
		tile = false, tileSize = 0, edgeSize = 0,
	})
	self.AFKMode.chatminbar:SetBackdropColor(.2, .2, .2, .0)
	self.AFKMode.chatminbar:SetScript("OnMouseDown", ChatMinBar_MouseDown)

	self.AFKMode.chatminbar.title = self.AFKMode.chatminbar:CreateFontString(nil, "OVERLAY")
	self.AFKMode.chatminbar.title:SetPoint("CENTER", self.AFKMode.chatminbar, "CENTER", 0, 0)
	FontTemplate(self.AFKMode.chatminbar.title, 20, "OUTLINE")

	local text = format(AFKS_CHATBAR_TEXT, 0, 0, 0)
	if IsInGuild() then
		text = text.." "..format(AFKS_CHATBAR_GUILD, 0)
	end
	self.AFKMode.chatminbar.title:SetText(text)
	self.AFKMode.chatminbar.title:SetTextColor(.6, .6, .6)
	self.AFKMode.chatminbar.title:Hide()

	if wowVersion == "retail" then
		local yoffset = panelheight - 102.4
		if yoffset < 0 then
			yoffset = 0
		end

		self.AFKMode.bottom.specpanel = self.AFKMode.bottom:CreateTexture(nil, "BACKGROUND")
		self.AFKMode.bottom.specpanel:SetSize(1, 1)--lnui,去掉天赋背景
		self.AFKMode.bottom.leftend = CreateFrame("Frame", nil, self.AFKMode.bottom)
		self.AFKMode.bottom.leftendtex = self.AFKMode.bottom.leftend:CreateTexture(nil, "BACKGROUND")
	end

	if wowVersion == "retail" or wowVersion == "cata" then
		self.AFKMode.bottom.schedule = self.AFKMode.bottom:CreateFontString(nil, "OVERLAY")
		FontTemplate(self.AFKMode.bottom.schedule, 20, "OUTLINE")
		self.AFKMode.bottom.schedule:SetPoint("BOTTOMLEFT", self.AFKMode.bottom.logo, "BOTTOMRIGHT", 200, 0)
		self.AFKMode.bottom.schedule:SetTextColor(1, 1, 1)
		self.AFKMode.bottom.calendaricon = self.AFKMode.bottom:CreateTexture(nil, "OVERLAY")
		self.AFKMode.bottom.calendaricon:SetPoint("RIGHT", self.AFKMode.bottom.schedule, "LEFT", 0, 0)
		self.AFKMode.bottom.calendaricon:SetSize(40, 40)
	end

	local factionGroup = UnitFactionGroup("player")
	local size, offsetX, offsetY = 140, -20, -16
	local nameOffsetX, nameOffsetY = -10, -28
	local ratio = tonumber(strsub(GetMonitorAspectRatio(), 0, 3))
	if ratio == 1.6 then
		nameOffsetY = -45 -- 16:10 monitor ratio fix
	end
	if factionGroup == "Neutral" then
		factionGroup = "Panda"
		size, offsetX, offsetY = 90, 15, 10
		nameOffsetX, nameOffsetY = 20, -5
		if ratio == 1.6 then
			nameOffsetY = -22 -- a chinese font size is bigger than others
		end
	end

	if wowVersion == "retail" then
		self.AFKMode.bottom.faction = self.AFKMode.bottom.leftend:CreateTexture(nil, "OVERLAY")
	else
		self.AFKMode.bottom.faction = self.AFKMode.bottom:CreateTexture(nil, "OVERLAY")
	end
	self.AFKMode.bottom.faction:SetPoint("BOTTOMLEFT", self.AFKMode.bottom, "BOTTOMLEFT", offsetX, offsetY)
	self.AFKMode.bottom.faction:SetTexture("Interface\\Timer\\"..factionGroup.."-Logo")
	self.AFKMode.bottom.faction:SetSize(size, size)

	if wowVersion == "retail" then
		self.AFKMode.bottom.name = self.AFKMode.bottom.leftend:CreateFontString(nil, "OVERLAY")
	else
		self.AFKMode.bottom.name = self.AFKMode.bottom:CreateFontString(nil, "OVERLAY")
	end
	FontTemplate(self.AFKMode.bottom.name, 20, "OUTLINE")
	self.AFKMode.bottom.name:SetText(format("%s-%s", UnitName("player"), GetRealmName()))
	self.AFKMode.bottom.name:SetPoint("TOPLEFT", self.AFKMode.bottom.faction, "TOPRIGHT", nameOffsetX, nameOffsetY)
	self.AFKMode.bottom.name:SetTextColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

	if wowVersion ~= "classic" then
		if wowVersion == "retail" then
			self.AFKMode.bottom.specicon = self.AFKMode.bottom.leftend:CreateTexture(nil, "OVERLAY")
		else
			self.AFKMode.bottom.specicon = self.AFKMode.bottom:CreateTexture(nil, "OVERLAY")
		end
		self.AFKMode.bottom.specicon:SetPoint("CENTER", self.AFKMode.bottom.name, "RIGHT", 15, -2)
		self.AFKMode.bottom.specicon:SetSize(25, 25)
		self.AFKMode.bottom.specicon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end

	if wowVersion == "retail" then
		self.AFKMode.bottom.guild = self.AFKMode.bottom.leftend:CreateFontString(nil, "OVERLAY")
	else
		self.AFKMode.bottom.guild = self.AFKMode.bottom:CreateFontString(nil, "OVERLAY")
	end
	FontTemplate(self.AFKMode.bottom.guild, 20, "OUTLINE")
	self.AFKMode.bottom.guild:SetText(AFKS_NOGUILD)
	self.AFKMode.bottom.guild:SetPoint("TOPLEFT", self.AFKMode.bottom.name, "BOTTOMLEFT", 0, -6)
	self.AFKMode.bottom.guild:SetTextColor(0.7, 0.7, 0.7)

	if wowVersion == "retail" then
		self.AFKMode.bottom.timer = self.AFKMode.bottom.leftend:CreateFontString(nil, "OVERLAY")
	else
		self.AFKMode.bottom.timer = self.AFKMode.bottom:CreateFontString(nil, "OVERLAY")
	end
	FontTemplate(self.AFKMode.bottom.timer, 20, "OUTLINE")
	self.AFKMode.bottom.timer:SetText("00:00")
	self.AFKMode.bottom.timer:SetPoint("TOPLEFT", self.AFKMode.bottom.guild, "BOTTOMLEFT", 0, -6)
	self.AFKMode.bottom.timer:SetTextColor(0.7, 0.7, 0.7)

	self.AFKMode.bottom.date = self.AFKMode.bottom:CreateFontString(nil, "OVERLAY")
	FontTemplate(self.AFKMode.bottom.date, 20, "OUTLINE")
	self.AFKMode.bottom.date:SetPoint("RIGHT", self.AFKMode.bottom, "RIGHT", -10, 25)
	self.AFKMode.bottom.date:SetTextColor(0.7, 0.7, 0.7)

	self.AFKMode.bottom.time = self.AFKMode.bottom:CreateFontString(nil, "OVERLAY")
	FontTemplate(self.AFKMode.bottom.time, 20, "OUTLINE")
	self.AFKMode.bottom.time:SetPoint("CENTER", self.AFKMode.bottom.date, "CENTER", 0, -50)
	self.AFKMode.bottom.time:SetTextColor(0.7, 0.7, 0.7)

	--Use this frame to control position of the model
	self.AFKMode.bottom.modelHolder = CreateFrame("Frame", nil, self.AFKMode.bottom)
	self.AFKMode.bottom.modelHolder:SetSize(150, 150)
	if wowVersion == "retail" then
		self.AFKMode.bottom.modelHolder:SetPoint("BOTTOMRIGHT", self.AFKMode.bottom, "BOTTOMRIGHT", -220, 265)
	else
		self.AFKMode.bottom.modelHolder:SetPoint("BOTTOMRIGHT", self.AFKMode.bottom, "BOTTOMRIGHT", -220, 220)
	end

	self.AFKMode.bottom.model = CreateFrame("PlayerModel", "AFKSPlayerModel", self.AFKMode.bottom.modelHolder)
	self.AFKMode.bottom.model:SetPoint("CENTER", self.AFKMode.bottom.modelHolder, "CENTER")
	self.AFKMode.bottom.model:SetSize(GetScreenWidth() * 2, GetScreenHeight() * 2)
	self.AFKMode.bottom.model:SetCamDistanceScale(4.5) --Since the model frame is huge, we need to zoom out quite a bit.
	self.AFKMode.bottom.model:SetFacing(6)
	self.AFKMode.bottom.model:SetScript("OnUpdate", function(self)
		local timePassed = GetTime() - self.startTime
		if(timePassed > self.duration) and self.isIdle ~= true then
			self:SetAnimation(0)
			self.isIdle = true
			AFKS.animTimer = NewTimer(self.idleDuration, LoopAnimations)
		end
	end)

	self.isInterrupted = false
	self.isCinematic = false

	self:SetScript("OnEvent", function(event, ...)
		self:OnEvent(...)
	end)
end

do
	AFKS:RegisterEvent("VARIABLES_LOADED")

	AFKS:Init()

	if LFGListInviteDialog_Show then
		hooksecurefunc ("LFGListInviteDialog_Show", function()
			if not InCombatLockdown() then
				AFKS:SetAFK(false)
			end
		end)
	end

	if wowVersion == "retail" then
		AddonCompartmentFrame:RegisterAddon({
			text = "AFKS",
			icon = "Interface\\AddOns\\AFKS\\AFKS-icon.tga",
			notCheckable = true,
			func = function()
				_G.Settings.OpenToCategory("AFKS")
			end,
		})
	end
end

function AFKS:UpdateTimer()
	self.AFKMode.bottom.time:SetText(format("%s", GameTime_GetLocalTime(true)))

	local curtime = GetTime() - self.startTime
	self.AFKMode.bottom.timer:SetText(format("%02d:%02d", floor(curtime/60), curtime % 60))

	if date("%H") == "23" and date("%M") == "59" and tonumber(date("%S")) >= 55 then
		SetDate(date("%a"), tonumber(date("%w")))
		if wowVersion == "retail" or wowVersion == "cata" then
			GetCalendarSchedule(tonumber(date("%d")), tonumber(date("%H")))
		end
	end
end

function AFKS:SetAFK(status)
	if status then
		local currUIscale = UIParent:GetScale()

		if UIscale ~= currUIscale then
			UIscale = currUIscale
			panelheight = GetScreenHeight() * 0.1
			if panelheight < 102 then -- Adjust to 102.4 in small resolution
				panelheight = 102.4
			end

			local yoffset = panelheight - 102.4

			self.AFKMode:SetScale(UIscale)
			self.AFKMode.bottom:SetWidth(GetScreenWidth() + 4)
			self.AFKMode.bottom:SetHeight(panelheight)
			self.AFKMode.bottom.model:SetSize(GetScreenWidth() * 2, GetScreenHeight() * 2)

			if wowVersion == "retail" then
				if yoffset < 0 then
					yoffset = 0
				end
				self.AFKMode.bottom.specpanel:SetPoint("RIGHT", self.AFKMode.bottom, "BOTTOMRIGHT", 0, -285 + yoffset)
			else
				if yoffset > 0 then
					yoffset = yoffset + 30
				else
					yoffset = yoffset - 30
				end
				self.AFKMode.bottom.modelHolder:ClearAllPoints()
				self.AFKMode.bottom.modelHolder:SetPoint("BOTTOMRIGHT", self.AFKMode.bottom, "BOTTOMRIGHT", -220, 220 + yoffset)
			end
		end

		MoveViewLeftStart(0.035)
		self.AFKMode:Show()
		CloseAllWindows()
		UIParent:Hide()

		SetDate(date("%a"), tonumber(date("%w")))
		self.AFKMode.bottom.time:SetText(format("%s", GameTime_GetLocalTime(true)))

		if IsInGuild() then
			local guildName, guildRankName = GetGuildInfo("player")
			self.AFKMode.bottom.guild:SetText(format("%s-%s", guildName, guildRankName))
		else
			self.AFKMode.bottom.guild:SetText(AFKS_NOGUILD)
		end

		if wowVersion ~= "classic" then
			SetSpecIcon()
		end

		if wowVersion == "retail" then
			SetSpecPanel()
		end

		if wowVersion == "retail" or wowVersion == "cata" then
			GetCalendarSchedule(tonumber(date("%d")), tonumber(date("%H")))
		end

		self.AFKMode.bottom.model.curAnimation = "wave"
		self.AFKMode.bottom.model.startTime = GetTime()
		self.AFKMode.bottom.model.duration = 2.3
		self.AFKMode.bottom.model:SetUnit("player")
		self.AFKMode.bottom.model.isIdle = nil
		self.AFKMode.bottom.model:SetAnimation(67)
		self.AFKMode.bottom.model.idleDuration = 40
		self.startTime = GetTime()
		self.timer = NewTicker(1, function() self:UpdateTimer() end)

		if self.AFKMode.chatminbar.minimized then
			self.AFKMode.chatminbar.unreadwhisper = 0
			self.AFKMode.chatminbar.unreadbnet = 0
			self.AFKMode.chatminbar.unreadchannel = 0
			self.AFKMode.chatminbar.unreadguild = 0

			local text = format(AFKS_CHATBAR_TEXT, AFKS.AFKMode.chatminbar.unreadwhisper, AFKS.AFKMode.chatminbar.unreadbnet, AFKS.AFKMode.chatminbar.unreadchannel)
			if IsInGuild() then
				text = text.." "..format(AFKS_CHATBAR_GUILD, AFKS.AFKMode.chatminbar.unreadguild)
			end
		end

		if self.options.hidechat then
			self.AFKMode.chat:UnregisterAllEvents()
			self.AFKMode.chat:Clear()
		else
			self.AFKMode.chat:RegisterEvent("CHAT_MSG_WHISPER")
			self.AFKMode.chat:RegisterEvent("CHAT_MSG_BN_WHISPER")
			self.AFKMode.chat:RegisterEvent("CHAT_MSG_GUILD")
			self.AFKMode.chat:RegisterEvent("CHAT_MSG_CHANNEL")

			if wowVersion == "retail" then
				self.AFKMode.chat:RegisterEvent("CHAT_MSG_COMMUNITIES_CHANNEL")
			end
		end

		self.isAFK = true
	elseif not status and self.isAFK then
		UIParent:Show()
		self.AFKMode:Hide()
		MoveViewLeftStop()

		self.timer:Cancel()
		if self.animTimer then
			self.animTimer:Cancel()
		end
		self.AFKMode.bottom.timer:SetText("00:00")

		self.AFKMode.exitbutton:Hide()
		self.AFKMode.chat:UnregisterAllEvents()
		self.AFKMode.chat:Clear()

		self.isAFK = false
		self.isCinematic = false
	end
end
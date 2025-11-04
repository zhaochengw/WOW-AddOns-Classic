----------------------------------------------------------------------
-- 	Leatrix Plus 5.1.07 (29th October 2025)
----------------------------------------------------------------------

--	01:Functions 02:Locks   03:Restart 40:Player   45:Rest
--  60:Events    62:Profile 70:Logout  80:Commands 90:Panel

----------------------------------------------------------------------
-- 	Leatrix Plus
----------------------------------------------------------------------

	-- Create global table
	_G.LeaPlusDB = _G.LeaPlusDB or {}

	-- Create locals
	local LeaPlusLC, LeaPlusCB, LeaDropList, LeaConfigList, LeaLockList = {}, {}, {}, {}, {}
	local ClientVersion = GetBuildInfo()
	local GameLocale = GetLocale()
	local void

	-- Version
	LeaPlusLC["AddonVer"] = "5.1.07"

	-- Get locale table
	local void, Leatrix_Plus = ...
	local L = Leatrix_Plus.L

	-- Check Wow version is valid
	do
		local gameversion, gamebuild, gamedate, gametocversion = GetBuildInfo()
		if gametocversion and gametocversion < 50000 or gametocversion > 59999 then
			-- Game client is not Mists of Pandaria Classic
			C_Timer.After(2, function()
				print(L["LEATRIX PLUS: WRONG VERSION INSTALLED!"])
			end)
			return
		end
		if gametocversion and gametocversion == 50500 then -- 5.5.0
			LeaPlusLC.NewPatch = true
		end
	end

	-- Check for ElvUI
	if C_AddOns.IsAddOnLoaded("ElvUI") then LeaPlusLC.ElvUI = unpack(ElvUI) end

----------------------------------------------------------------------
--	L00: Leatrix Plus
----------------------------------------------------------------------

	-- Initialise variables
	LeaPlusLC["ShowErrorsFlag"] = 1
	LeaPlusLC["NumberOfPages"] = 9
	LeaPlusLC["MainPanelHeight"] = 370

	-- Class colors
	do
		local void, playerClass = UnitClass("player")
		if CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[playerClass] then
			LeaPlusLC["RaidColors"] = CUSTOM_CLASS_COLORS
		else
			LeaPlusLC["RaidColors"] = RAID_CLASS_COLORS
		end
	end

	-- Create event frame
	local LpEvt = CreateFrame("FRAME")
	LpEvt:RegisterEvent("ADDON_LOADED")
	LpEvt:RegisterEvent("PLAYER_LOGIN")

	-- Set bindings translations
	_G.BINDING_NAME_LEATRIX_PLUS_GLOBAL_TOGGLE = L["Toggle panel"]
	_G.BINDING_NAME_LEATRIX_PLUS_GLOBAL_WEBLINK = L["Show web link"]
	_G.BINDING_NAME_LEATRIX_PLUS_GLOBAL_RARE = L["Announce rare"]

	-- Slash command taint
	-- Enter combat, enter any addon slash command, open quest log with L, toggle tracking on a quest 4 times,
	-- click the tracked quest in the objective tracker, taint and objective tracker no longer functions

----------------------------------------------------------------------
--	L01: Functions
----------------------------------------------------------------------

	-- Print text
	function LeaPlusLC:Print(text)
		DEFAULT_CHAT_FRAME:AddMessage(L[text], 1.0, 0.85, 0.0)
	end

	-- Lock and unlock an item
	function LeaPlusLC:LockItem(item, lock)
		if lock then
			item:Disable()
			item:SetAlpha(0.3)
		else
			item:Enable()
			item:SetAlpha(1.0)
		end
	end

	-- Hide configuration panels
	function LeaPlusLC:HideConfigPanels()
		for k, v in pairs(LeaConfigList) do
			v:Hide()
		end
	end

	-- Decline a shared quest if needed
	function LeaPlusLC:CheckIfQuestIsSharedAndShouldBeDeclined()
		if LeaPlusLC["NoSharedQuests"] == "On" then
			local npcName = UnitName("questnpc")
			if npcName and UnitIsPlayer(npcName) then
				if UnitInParty(npcName) or UnitInRaid(npcName) then
					if not LeaPlusLC:FriendCheck(npcName) then
						DeclineQuest()
						return
					end
				end
			end
		end
	end

	-- Show a single line prefilled editbox with copy functionality
	function LeaPlusLC:ShowSystemEditBox(word, focuschat)
		if not LeaPlusLC.FactoryEditBox then
			-- Create frame for first time
			local eFrame = CreateFrame("FRAME", nil, UIParent)
			LeaPlusLC.FactoryEditBox = eFrame
			eFrame:SetSize(700, 110)
			eFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 150)
			eFrame:SetFrameStrata("FULLSCREEN_DIALOG")
			eFrame:SetFrameLevel(5000)
			eFrame:SetScript("OnMouseDown", function(self, btn)
				if btn == "RightButton" then
					eFrame:Hide()
				end
			end)
			-- Add background color
			eFrame.t = eFrame:CreateTexture(nil, "BACKGROUND")
			eFrame.t:SetAllPoints()
			eFrame.t:SetColorTexture(0.05, 0.05, 0.05, 0.9)
			-- Add copy title
			eFrame.f = eFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			eFrame.f:SetPoint("TOPLEFT", x, y)
			eFrame.f:SetPoint("TOPLEFT", eFrame, "TOPLEFT", 12, -52)
			eFrame.f:SetWidth(676)
			eFrame.f:SetJustifyH("LEFT")
			eFrame.f:SetWordWrap(false)
			-- Add copy label
			eFrame.c = eFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			eFrame.c:SetPoint("TOPLEFT", x, y)
			eFrame.c:SetText(L["Press CTRL/C to copy"])
			eFrame.c:SetPoint("TOPLEFT", eFrame, "TOPLEFT", 12, -82)
			-- Add cancel label
			eFrame.x = eFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			eFrame.x:SetPoint("TOPRIGHT", x, y)
			eFrame.x:SetText(L["Right-click to close"])
			eFrame.x:SetPoint("TOPRIGHT", eFrame, "TOPRIGHT", -12, -82)
			-- Create editbox
			eFrame.b = CreateFrame("EditBox", nil, eFrame, "InputBoxTemplate")
			eFrame.b:ClearAllPoints()
			eFrame.b:SetPoint("TOPLEFT", eFrame, "TOPLEFT", 16, -12)
			eFrame.b:SetSize(672, 24)
			eFrame.b:SetFontObject("GameFontNormalLarge")
			eFrame.b:SetTextColor(1.0, 1.0, 1.0, 1)
			eFrame.b:SetBlinkSpeed(0)
			eFrame.b:SetHitRectInsets(99, 99, 99, 99)
			eFrame.b:SetAutoFocus(true)
			eFrame.b:SetAltArrowKeyMode(true)
			-- Editbox texture
			eFrame.t = CreateFrame("FRAME", nil, eFrame.b, "BackdropTemplate")
			eFrame.t:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = false, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }})
			eFrame.t:SetPoint("LEFT", -6, 0)
			eFrame.t:SetWidth(eFrame.b:GetWidth() + 6)
			eFrame.t:SetHeight(eFrame.b:GetHeight())
			eFrame.t:SetBackdropColor(1.0, 1.0, 1.0, 0.3)
			-- Handler
			eFrame.b:SetScript("OnKeyDown", function(void, key)
				if key == "C" and IsControlKeyDown() then
					C_Timer.After(0.1, function()
						eFrame:Hide()
						ActionStatus_DisplayMessage(L["Copied to clipboard."], true)
						if LeaPlusLC.FactoryEditBoxFocusChat then
							local eBox = ChatEdit_ChooseBoxForSend()
							ChatEdit_ActivateChat(eBox)
						end
					end)
				end
			end)
			-- Prevent changes
			eFrame.b:SetScript("OnEscapePressed", function() eFrame:Hide() end)
			eFrame.b:SetScript("OnEnterPressed", eFrame.b.HighlightText)
			eFrame.b:SetScript("OnMouseDown", eFrame.b.ClearFocus)
			eFrame.b:SetScript("OnMouseUp", eFrame.b.HighlightText)
			eFrame.b:SetFocus(true)
			eFrame.b:HighlightText()
			eFrame:Show()
		end
		if focuschat then LeaPlusLC.FactoryEditBoxFocusChat = true else LeaPlusLC.FactoryEditBoxFocusChat = nil end
		LeaPlusLC.FactoryEditBox:Show()
		LeaPlusLC.FactoryEditBox.b:SetText(word)
		LeaPlusLC.FactoryEditBox.b:HighlightText()
		LeaPlusLC.FactoryEditBox.b:SetScript("OnChar", function() LeaPlusLC.FactoryEditBox.b:SetFocus(true) LeaPlusLC.FactoryEditBox.b:SetText(word) LeaPlusLC.FactoryEditBox.b:HighlightText() end)
		LeaPlusLC.FactoryEditBox.b:SetScript("OnKeyUp", function() LeaPlusLC.FactoryEditBox.b:SetFocus(true) LeaPlusLC.FactoryEditBox.b:SetText(word) LeaPlusLC.FactoryEditBox.b:HighlightText() end)
	end

	-- Load a string variable or set it to default if it's not set to "On" or "Off"
	function LeaPlusLC:LoadVarChk(var, def)
		if LeaPlusDB[var] and type(LeaPlusDB[var]) == "string" and LeaPlusDB[var] == "On" or LeaPlusDB[var] == "Off" then
			LeaPlusLC[var] = LeaPlusDB[var]
		else
			LeaPlusLC[var] = def
			LeaPlusDB[var] = def
		end
	end

	-- Load a numeric variable and set it to default if it's not within a given range
	function LeaPlusLC:LoadVarNum(var, def, valmin, valmax)
		if LeaPlusDB[var] and type(LeaPlusDB[var]) == "number" and LeaPlusDB[var] >= valmin and LeaPlusDB[var] <= valmax then
			LeaPlusLC[var] = LeaPlusDB[var]
		else
			LeaPlusLC[var] = def
			LeaPlusDB[var] = def
		end
	end

	-- Load an anchor point variable and set it to default if the anchor point is invalid
	function LeaPlusLC:LoadVarAnc(var, def)
		if LeaPlusDB[var] and type(LeaPlusDB[var]) == "string" and LeaPlusDB[var] == "CENTER" or LeaPlusDB[var] == "TOP" or LeaPlusDB[var] == "BOTTOM" or LeaPlusDB[var] == "LEFT" or LeaPlusDB[var] == "RIGHT" or LeaPlusDB[var] == "TOPLEFT" or LeaPlusDB[var] == "TOPRIGHT" or LeaPlusDB[var] == "BOTTOMLEFT" or LeaPlusDB[var] == "BOTTOMRIGHT" then
			LeaPlusLC[var] = LeaPlusDB[var]
		else
			LeaPlusLC[var] = def
			LeaPlusDB[var] = def
		end
	end

	-- Load a string variable and set it to default if it is not a string (used with minimap exclude list)
	function LeaPlusLC:LoadVarStr(var, def)
		if LeaPlusDB[var] and type(LeaPlusDB[var]) == "string" then
			LeaPlusLC[var] = LeaPlusDB[var]
		else
			LeaPlusLC[var] = def
			LeaPlusDB[var] = def
		end
	end

	-- Show tooltips for checkboxes
	function LeaPlusLC:TipSee()
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		local parent = self:GetParent()
		if parent:GetParent() and parent:GetParent():GetObjectType() == "ScrollFrame" then
			-- Scrolling frame tooltips have different parent
			parent = self:GetParent():GetParent():GetParent():GetParent()
		end
		local pscale = parent:GetEffectiveScale()
		local gscale = UIParent:GetEffectiveScale()
		local tscale = GameTooltip:GetEffectiveScale()
		local gap = ((UIParent:GetRight() * gscale) - (parent:GetRight() * pscale))
		if gap < (250 * tscale) then
			GameTooltip:SetPoint("TOPRIGHT", parent, "TOPLEFT", 0, 0)
		else
			GameTooltip:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0, 0)
		end
		GameTooltip:SetText(self.tiptext, nil, nil, nil, nil, true)
	end

	-- Show tooltips for dropdown menu tooltips
	function LeaPlusLC:ShowDropTip()
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		local parent = self:GetParent():GetParent():GetParent()
		local pscale = parent:GetEffectiveScale()
		local gscale = UIParent:GetEffectiveScale()
		local tscale = GameTooltip:GetEffectiveScale()
		local gap = ((UIParent:GetRight() * gscale) - (parent:GetRight() * pscale))
		if gap < (250 * tscale) then
			GameTooltip:SetPoint("TOPRIGHT", parent, "TOPLEFT", 0, 0)
		else
			GameTooltip:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0, 0)
		end
		GameTooltip:SetText(self.tiptext, nil, nil, nil, nil, true)
	end

	-- Show tooltips for configuration buttons and dropdown menus
	function LeaPlusLC:ShowTooltip()
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		local parent = LeaPlusLC["PageF"]
		local pscale = parent:GetEffectiveScale()
		local gscale = UIParent:GetEffectiveScale()
		local tscale = GameTooltip:GetEffectiveScale()
		local gap = ((UIParent:GetRight() * gscale) - (LeaPlusLC["PageF"]:GetRight() * pscale))
		if gap < (250 * tscale) then
			GameTooltip:SetPoint("TOPRIGHT", parent, "TOPLEFT", 0, 0)
		else
			GameTooltip:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0, 0)
		end
		GameTooltip:SetText(self.tiptext, nil, nil, nil, nil, true)
	end

	-- Create configuration button
	function LeaPlusLC:CfgBtn(name, parent)
		local CfgBtn = CreateFrame("BUTTON", nil, parent)
		LeaPlusCB[name] = CfgBtn
		CfgBtn:SetWidth(20)
		CfgBtn:SetHeight(20)
		CfgBtn:SetPoint("LEFT", parent.f, "RIGHT", 0, 0)

		CfgBtn.t = CfgBtn:CreateTexture(nil, "BORDER")
		CfgBtn.t:SetAllPoints()
		CfgBtn.t:SetTexture("Interface\\WorldMap\\Gear_64.png")
		CfgBtn.t:SetTexCoord(0, 0.50, 0, 0.50);
		CfgBtn.t:SetVertexColor(1.0, 0.82, 0, 1.0)

		CfgBtn:SetHighlightTexture("Interface\\WorldMap\\Gear_64.png")
		CfgBtn:GetHighlightTexture():SetTexCoord(0, 0.50, 0, 0.50);

		CfgBtn.tiptext = L["Click to configure the settings for this option."]
		CfgBtn:SetScript("OnEnter", LeaPlusLC.ShowTooltip)
		CfgBtn:SetScript("OnLeave", GameTooltip_Hide)
	end

	-- Create a help button to the right of a fontstring
	function LeaPlusLC:CreateHelpButton(frame, panel, parent, tip)
		LeaPlusLC:CfgBtn(frame, panel)
		LeaPlusCB[frame]:ClearAllPoints()
		LeaPlusCB[frame]:SetPoint("LEFT", parent, "RIGHT", -parent:GetWidth() + parent:GetStringWidth(), 0)
		LeaPlusCB[frame]:SetSize(25, 25)
		LeaPlusCB[frame].t:SetTexture("Interface\\COMMON\\help-i.blp")
		LeaPlusCB[frame].t:SetTexCoord(0, 1, 0, 1)
		LeaPlusCB[frame].t:SetVertexColor(0.9, 0.8, 0.0)
		LeaPlusCB[frame]:SetHighlightTexture("Interface\\COMMON\\help-i.blp")
		LeaPlusCB[frame]:GetHighlightTexture():SetTexCoord(0, 1, 0, 1)
		LeaPlusCB[frame].tiptext = L[tip]
		LeaPlusCB[frame]:SetScript("OnEnter", LeaPlusLC.TipSee)
	end

	-- Show a footer
	function LeaPlusLC:MakeFT(frame, text, left, width)
		local footer = LeaPlusLC:MakeTx(frame, text, left, 96)
		footer:SetWidth(width); footer:SetJustifyH("LEFT"); footer:SetWordWrap(true); footer:ClearAllPoints()
		footer:SetPoint("BOTTOMLEFT", left, 96)
		return footer
	end

	-- Capitalise first character in a string
	function LeaPlusLC:CapFirst(str)
		return gsub(string.lower(str), "^%l", strupper)
	end

	-- Toggle Zygor addon
	function LeaPlusLC:ZygorToggle()
		if select(2, C_AddOns.GetAddOnInfo("ZygorGuidesViewerClassicTBC")) then
			if not C_AddOns.IsAddOnLoaded("ZygorGuidesViewerClassicTBC") then
				if LeaPlusLC:PlayerInCombat() then
					return
				else
					C_AddOns.EnableAddOn("ZygorGuidesViewerClassicTBC")
					ReloadUI();
				end
			else
				C_AddOns.DisableAddOn("ZygorGuidesViewerClassicTBC")
				ReloadUI();
			end
		else
			-- Zygor cannot be found
			LeaPlusLC:Print("Zygor addon not found.");
		end
		return
	end

	-- Show memory usage stat
	function LeaPlusLC:ShowMemoryUsage(frame, anchor, x, y)

		-- Create frame
		local memframe = CreateFrame("FRAME", nil, frame)
		memframe:ClearAllPoints()
		memframe:SetPoint(anchor, x, y)
		memframe:SetWidth(100)
		memframe:SetHeight(20)

		-- Create labels
		local pretext = memframe:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		pretext:SetPoint("TOPLEFT", 0, 0)
		pretext:SetText(L["Memory Usage"])

		local memtext = memframe:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		memtext:SetPoint("TOPLEFT", 0, 0 - 30)

		-- Create stat
		local memstat = memframe:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		memstat:SetPoint("BOTTOMLEFT", memtext, "BOTTOMRIGHT")
		memstat:SetText("(calculating...)")

		-- Create update script
		local memtime = -1
		memframe:SetScript("OnUpdate", function(self, elapsed)
			if memtime > 2 or memtime == -1 then
				UpdateAddOnMemoryUsage();
				memtext = GetAddOnMemoryUsage("Leatrix_Plus")
				memtext = math.floor(memtext + .5) .. " KB"
				memstat:SetText(memtext);
				memtime = 0;
			end
			memtime = memtime + elapsed;
		end)

		-- Release memory
		LeaPlusLC.ShowMemoryUsage = nil

	end

	-- Check if player is in LFG queue (battleground)
	function LeaPlusLC:IsInLFGQueue()
		for i = 1, GetMaxBattlefieldID() do
			local status = GetBattlefieldStatus(i)
			if status == "queued" or status == "confirmed" then
				return true
			end
		end
	end

	-- Check if player is in combat
	function LeaPlusLC:PlayerInCombat()
		if (UnitAffectingCombat("player")) then
			LeaPlusLC:Print("You cannot do that in combat.")
			return true
		end
	end

	--  Hide panel and pages
	function LeaPlusLC:HideFrames()

		-- Hide option pages
		for i = 0, LeaPlusLC["NumberOfPages"] do
			if LeaPlusLC["Page"..i] then
				LeaPlusLC["Page"..i]:Hide();
			end;
		end

		-- Hide options panel
		LeaPlusLC["PageF"]:Hide();

	end

	-- Find out if Leatrix Plus is showing (main panel or config panel)
	function LeaPlusLC:IsPlusShowing()
		if LeaPlusLC["PageF"]:IsShown() then return true end
		for k, v in pairs(LeaConfigList) do
			if v:IsShown() then
				return true
			end
		end
	end

	-- Check if a name is in your friends list or guild (does not check realm as realm is unknown for some checks)
	function LeaPlusLC:FriendCheck(name, guid)

		-- Do nothing if name is empty (such as whispering from the Battle.net app)
		if not name then return end

		-- Update friends list
		C_FriendList.ShowFriends()

		-- Remove realm (since we have GUID checking)
		name = strsplit("-", name, 2)

		-- Check character friends
		for i = 1, C_FriendList.GetNumFriends() do
			-- Return true is character name matches and GUID matches if there is one (realm is not checked)
			local friendInfo = C_FriendList.GetFriendInfoByIndex(i)
			local charFriendName = C_FriendList.GetFriendInfoByIndex(i).name
			charFriendName = strsplit("-", charFriendName, 2)
			if (name == charFriendName) and (guid and (guid == friendInfo.guid) or true) then
				return true
			end
		end

		-- Check Battle.net friends
		local numfriends = BNGetNumFriends()
		for i = 1, numfriends do
			local numtoons = C_BattleNet.GetFriendNumGameAccounts(i)
			for j = 1, numtoons do
				local gameAccountInfo = C_BattleNet.GetFriendGameAccountInfo(i, j)
				local characterName = gameAccountInfo.characterName
				local client = gameAccountInfo.clientProgram
				if client == "WoW" and characterName == name then
					return true
				end
			end
		end

		-- Check guild members if guild is enabled (new members may need to press J to refresh roster)
		if LeaPlusLC["FriendlyGuild"] == "On" then
			local gCount = GetNumGuildMembers()
			for i = 1, gCount do
				local gName, void, void, void, void, void, void, void, gOnline, void, void, void, void, gMobile, void, void, gGUID = GetGuildRosterInfo(i)
				if gOnline and not gMobile then
					gName = strsplit("-", gName, 2)
					-- Return true if character name matches including GUID if there is one
					if (name == gName) and (guid and (guid == gGUID) or true) then
						return true
					end
				end
			end
		end

	end

----------------------------------------------------------------------
--	L02: Locks
----------------------------------------------------------------------

	-- Function to set lock state for configuration buttons
	function LeaPlusLC:LockOption(option, item, reloadreq)
		if reloadreq then
			-- Option change requires UI reload
			if LeaPlusLC[option] ~= LeaPlusDB[option] or LeaPlusLC[option] == "Off" then
				LeaPlusLC:LockItem(LeaPlusCB[item], true)
			else
				LeaPlusLC:LockItem(LeaPlusCB[item], false)
			end
		else
			-- Option change does not require UI reload
			if LeaPlusLC[option] == "Off" then
				LeaPlusLC:LockItem(LeaPlusCB[item], true)
			else
				LeaPlusLC:LockItem(LeaPlusCB[item], false)
			end
		end
	end

--	Set lock state for configuration buttons
	function LeaPlusLC:SetDim()
		LeaPlusLC:LockOption("AutomateQuests", "AutomateQuestsBtn", false)			-- Automate quests
		LeaPlusLC:LockOption("AutoAcceptRes", "AutoAcceptResBtn", false)			-- Accept resurrection
		LeaPlusLC:LockOption("AutoReleasePvP", "AutoReleasePvPBtn", false)			-- Release in PvP
		LeaPlusLC:LockOption("AutoSellJunk", "AutoSellJunkBtn", false)				-- Sell junk automatically
		LeaPlusLC:LockOption("AutoRepairGear", "AutoRepairBtn", false)				-- Repair automatically
		LeaPlusLC:LockOption("InviteFromWhisper", "InvWhisperBtn", false)			-- Invite from whispers
		LeaPlusLC:LockOption("FilterChatMessages", "FilterChatMessagesBtn", true)	-- Filter chat messages
		LeaPlusLC:LockOption("MailFontChange", "MailTextBtn", true)					-- Resize mail text
		LeaPlusLC:LockOption("QuestFontChange", "QuestTextBtn", true)				-- Resize quest text
		LeaPlusLC:LockOption("BookFontChange", "BookTextBtn", true)					-- Resize book text
		LeaPlusLC:LockOption("MinimapModder", "ModMinimapBtn", true)				-- Enhance minimap
		LeaPlusLC:LockOption("TipModEnable", "MoveTooltipButton", true)				-- Enhance tooltip
		LeaPlusLC:LockOption("EnhanceDressup", "EnhanceDressupBtn", true)			-- Enhance dressup
		LeaPlusLC:LockOption("EnhanceQuestLog", "EnhanceQuestLogBtn", true)			-- Enhance quest log
		LeaPlusLC:LockOption("EnhanceTrainers", "EnhanceTrainersBtn", true)			-- Enhance trainers
		LeaPlusLC:LockOption("EnhanceFlightMap", "EnhanceFlightMapBtn", true)		-- Enhance flight map
		LeaPlusLC:LockOption("ShowCooldowns", "CooldownsButton", true)				-- Show cooldowns
		LeaPlusLC:LockOption("ShowBorders", "ModBordersBtn", true)					-- Show borders
		LeaPlusLC:LockOption("ShowPlayerChain", "ModPlayerChain", true)				-- Show player chain
		LeaPlusLC:LockOption("ShowWowheadLinks", "ShowWowheadLinksBtn", true)		-- Show Wowhead links
		LeaPlusLC:LockOption("FrmEnabled", "MoveFramesButton", true)				-- Manage frames
		LeaPlusLC:LockOption("ManageBuffs", "ManageBuffsButton", true)				-- Manage buffs
		LeaPlusLC:LockOption("ManageWidget", "ManageWidgetButton", true)			-- Manage widget
		LeaPlusLC:LockOption("ManageFocus", "ManageFocusButton", true)				-- Manage focus
		LeaPlusLC:LockOption("ManageTimer", "ManageTimerButton", true)				-- Manage timer
		LeaPlusLC:LockOption("ManageDurability", "ManageDurabilityButton", true)	-- Manage durability
		LeaPlusLC:LockOption("ManageVehicle", "ManageVehicleButton", true)			-- Manage vehicle
		LeaPlusLC:LockOption("ClassColFrames", "ClassColFramesBtn", true)			-- Class colored frames
		LeaPlusLC:LockOption("SetWeatherDensity", "SetWeatherDensityBtn", false)	-- Set weather density
		LeaPlusLC:LockOption("MuteGameSounds", "MuteGameSoundsBtn", false)			-- Mute game sounds
		LeaPlusLC:LockOption("MuteMountSounds", "MuteMountSoundsBtn", false)		-- Mute mount sounds
		LeaPlusLC:LockOption("MuteCustomSounds", "MuteCustomSoundsBtn", false)		-- Mute custom sounds
		LeaPlusLC:LockOption("NoTransforms", "NoTransformsBtn", false)				-- Remove transforms
		LeaPlusLC:LockOption("StandAndDismount", "DismountBtn", true)				-- Dismount me
	end

----------------------------------------------------------------------
--	L03: Restarts
----------------------------------------------------------------------

	-- Set the reload button state
	function LeaPlusLC:ReloadCheck()

		-- Chat
		if	(LeaPlusLC["UseEasyChatResizing"]	~= LeaPlusDB["UseEasyChatResizing"])	-- Use easy resizing
		or	(LeaPlusLC["NoCombatLogTab"]		~= LeaPlusDB["NoCombatLogTab"])			-- Hide the combat log
		or	(LeaPlusLC["NoChatButtons"]			~= LeaPlusDB["NoChatButtons"])			-- Hide chat buttons
		or	(LeaPlusLC["UnclampChat"]			~= LeaPlusDB["UnclampChat"])			-- Unclamp chat frame
		or	(LeaPlusLC["MoveChatEditBoxToTop"]	~= LeaPlusDB["MoveChatEditBoxToTop"])	-- Move editbox to top
		or	(LeaPlusLC["MoreFontSizes"]			~= LeaPlusDB["MoreFontSizes"])			-- More font sizes
		or	(LeaPlusLC["NoStickyChat"]			~= LeaPlusDB["NoStickyChat"])			-- Disable sticky chat
		or	(LeaPlusLC["UseArrowKeysInChat"]	~= LeaPlusDB["UseArrowKeysInChat"])		-- Use arrow keys in chat
		or	(LeaPlusLC["NoChatFade"]			~= LeaPlusDB["NoChatFade"])				-- Disable chat fade
		or	(LeaPlusLC["ClassColorsInChat"]		~= LeaPlusDB["ClassColorsInChat"])		-- Use class colors in chat
		or	(LeaPlusLC["RecentChatWindow"]		~= LeaPlusDB["RecentChatWindow"])		-- Recent chat window
		or	(LeaPlusLC["MaxChatHstory"]			~= LeaPlusDB["MaxChatHstory"])			-- Increase chat history
		or	(LeaPlusLC["FilterChatMessages"]	~= LeaPlusDB["FilterChatMessages"])		-- Filter chat messages
		or	(LeaPlusLC["RestoreChatMessages"]	~= LeaPlusDB["RestoreChatMessages"])	-- Restore chat messages

		-- Text
		or	(LeaPlusLC["HideErrorMessages"]		~= LeaPlusDB["HideErrorMessages"])		-- Hide error messages
		or	(LeaPlusLC["NoHitIndicators"]		~= LeaPlusDB["NoHitIndicators"])		-- Hide portrait text
		or	(LeaPlusLC["HideZoneText"]			~= LeaPlusDB["HideZoneText"])			-- Hide zone text
		or	(LeaPlusLC["HideKeybindText"]		~= LeaPlusDB["HideKeybindText"])		-- Hide keybind text
		or	(LeaPlusLC["HideMacroText"]			~= LeaPlusDB["HideMacroText"])			-- Hide macro text
		or	(LeaPlusLC["HideRaidGroupLabels"]	~= LeaPlusDB["HideRaidGroupLabels"])	-- Hide raid group labels

		or	(LeaPlusLC["MailFontChange"]		~= LeaPlusDB["MailFontChange"])			-- Resize mail text
		or	(LeaPlusLC["QuestFontChange"]		~= LeaPlusDB["QuestFontChange"])		-- Resize quest text
		or	(LeaPlusLC["BookFontChange"]		~= LeaPlusDB["BookFontChange"])			-- Resize book text

		-- Interface
		or	(LeaPlusLC["MinimapModder"]			~= LeaPlusDB["MinimapModder"])			-- Enhance minimap
		or	(LeaPlusLC["SquareMinimap"]			~= LeaPlusDB["SquareMinimap"])			-- Square minimap
		or	(LeaPlusLC["CombineAddonButtons"]	~= LeaPlusDB["CombineAddonButtons"])	-- Combine addon buttons
		or	(LeaPlusLC["HideMiniTracking"]		~= LeaPlusDB["HideMiniTracking"])		-- Hide tracking button
		or	(LeaPlusLC["MiniExcludeList"]		~= LeaPlusDB["MiniExcludeList"])		-- Minimap exclude list
		or	(LeaPlusLC["TipModEnable"]			~= LeaPlusDB["TipModEnable"])			-- Enhance tooltip
		or	(LeaPlusLC["TipNoHealthBar"]		~= LeaPlusDB["TipNoHealthBar"])			-- Tooltip hide health bar
		or	(LeaPlusLC["EnhanceDressup"]		~= LeaPlusDB["EnhanceDressup"])			-- Enhance dressup
		or	(LeaPlusLC["DressupWiderPreview"]	~= LeaPlusDB["DressupWiderPreview"])	-- Enhance dressup wider character preview
		or	(LeaPlusLC["EnhanceQuestLog"]		~= LeaPlusDB["EnhanceQuestLog"])		-- Enhance quest log
		or	(LeaPlusLC["EnhanceProfessions"]	~= LeaPlusDB["EnhanceProfessions"])		-- Enhance professions
		or	(LeaPlusLC["EnhanceTrainers"]		~= LeaPlusDB["EnhanceTrainers"])		-- Enhance trainers
		or	(LeaPlusLC["EnhanceFlightMap"]		~= LeaPlusDB["EnhanceFlightMap"])		-- Enhance flight map
		or	(LeaPlusLC["ShowVolume"]			~= LeaPlusDB["ShowVolume"])				-- Show volume slider
		or	(LeaPlusLC["ShowCooldowns"]			~= LeaPlusDB["ShowCooldowns"])			-- Show cooldowns
		or	(LeaPlusLC["DurabilityStatus"]		~= LeaPlusDB["DurabilityStatus"])		-- Show durability status
		or	(LeaPlusLC["ShowPetSaveBtn"]		~= LeaPlusDB["ShowPetSaveBtn"])			-- Show pet save button
		or	(LeaPlusLC["ShowVanityControls"]	~= LeaPlusDB["ShowVanityControls"])		-- Show vanity controls
		or	(LeaPlusLC["ShowRaidToggle"]		~= LeaPlusDB["ShowRaidToggle"])			-- Show raid button
		or	(LeaPlusLC["ShowBorders"]			~= LeaPlusDB["ShowBorders"])			-- Show borders
		or	(LeaPlusLC["ShowPlayerChain"]		~= LeaPlusDB["ShowPlayerChain"])		-- Show player chain
		or	(LeaPlusLC["ShowReadyTimer"]		~= LeaPlusDB["ShowReadyTimer"])			-- Show ready timer
		or	(LeaPlusLC["ShowWowheadLinks"]		~= LeaPlusDB["ShowWowheadLinks"])		-- Show Wowhead links

		-- Frames
		or	(LeaPlusLC["FrmEnabled"]			~= LeaPlusDB["FrmEnabled"])				-- Manage frames
		or	(LeaPlusLC["ManageBuffs"]			~= LeaPlusDB["ManageBuffs"])			-- Manage buffs
		or	(LeaPlusLC["ManageWidget"]			~= LeaPlusDB["ManageWidget"])			-- Manage widget
		or	(LeaPlusLC["ManageFocus"]			~= LeaPlusDB["ManageFocus"])			-- Manage focus
		or	(LeaPlusLC["ManageTimer"]			~= LeaPlusDB["ManageTimer"])			-- Manage timer
		or	(LeaPlusLC["ManageDurability"]		~= LeaPlusDB["ManageDurability"])		-- Manage durability
		or	(LeaPlusLC["ManageVehicle"]			~= LeaPlusDB["ManageVehicle"])			-- Manage vehicle
		or	(LeaPlusLC["ClassColFrames"]		~= LeaPlusDB["ClassColFrames"])			-- Class colored frames
		or	(LeaPlusLC["NoAlerts"]				~= LeaPlusDB["NoAlerts"])				-- Hide alerts
		or	(LeaPlusLC["NoGryphons"]			~= LeaPlusDB["NoGryphons"])				-- Hide gryphons
		or	(LeaPlusLC["HideEventToasts"]		~= LeaPlusDB["HideEventToasts"])		-- Hide event toasts
		or	(LeaPlusLC["NoClassBar"]			~= LeaPlusDB["NoClassBar"])				-- Hide stance bar

		-- System
		or	(LeaPlusLC["NoRestedEmotes"]		~= LeaPlusDB["NoRestedEmotes"])			-- Silence rested emotes
		or	(LeaPlusLC["KeepAudioSynced"]		~= LeaPlusDB["KeepAudioSynced"])		-- Keep audio synced
		or	(LeaPlusLC["NoBagAutomation"]		~= LeaPlusDB["NoBagAutomation"])		-- Disable bag automation
		or	(LeaPlusLC["NoPetAutomation"]		~= LeaPlusDB["NoPetAutomation"])		-- Disable pet automation
		or	(LeaPlusLC["CharAddonList"]			~= LeaPlusDB["CharAddonList"])			-- Show character addons
		or	(LeaPlusLC["FasterLooting"]			~= LeaPlusDB["FasterLooting"])			-- Faster auto loot
		or	(LeaPlusLC["FasterMovieSkip"]		~= LeaPlusDB["FasterMovieSkip"])		-- Faster movie skip
		or	(LeaPlusLC["StandAndDismount"]		~= LeaPlusDB["StandAndDismount"])		-- Dismount me
		or	(LeaPlusLC["ExpandVendorPrice"]		~= LeaPlusDB["ExpandVendorPrice"])		-- Expand vendor price
		or	(LeaPlusLC["CombatPlates"]			~= LeaPlusDB["CombatPlates"])			-- Combat plates
		or	(LeaPlusLC["EasyItemDestroy"]		~= LeaPlusDB["EasyItemDestroy"])		-- Easy item destroy

		-- Settings
		or	(LeaPlusLC["UseEnglishLanguage"]	~= LeaPlusDB["UseEnglishLanguage"])		-- Use English language

		then
			-- Enable the reload button
			LeaPlusLC:LockItem(LeaPlusCB["ReloadUIButton"], false)
			LeaPlusCB["ReloadUIButton"].f:Show()
		else
			-- Disable the reload button
			LeaPlusLC:LockItem(LeaPlusCB["ReloadUIButton"], true)
			LeaPlusCB["ReloadUIButton"].f:Hide()
		end

	end

----------------------------------------------------------------------
--	L40: Player
----------------------------------------------------------------------

	function LeaPlusLC:Player()

		----------------------------------------------------------------------
		-- Hide raid group labels
		----------------------------------------------------------------------

		if LeaPlusLC["HideRaidGroupLabels"] == "On" then

			-- Hide player frame group indiciator labels
			hooksecurefunc("PlayerFrame_UpdateGroupIndicator", function()
				if PlayerFrameGroupIndicator:IsShown() then
					PlayerFrameGroupIndicator:Hide()
				end
			end)

			EventUtil.ContinueOnAddOnLoaded("Blizzard_RaidUI", function()
				-- Hide raid pullout frame labels
				hooksecurefunc("RaidPullout_Update", function(frame)
					if frame then
						local frameName = frame:GetName()
						if frameName then
							local title = _G[frameName .. "Name"]
							if title and title:IsShown() then
								title:Hide()
							end
						end
					end
				end)

				-- Hide raid container group titles
				local function HideRaidContainerGroupTitles(groupIndex)
					if groupIndex then
						local frame = _G["CompactRaidGroup" .. groupIndex]
						if frame then
							frame.title:Hide()
						end
					end
				end

				hooksecurefunc("CompactRaidGroup_GenerateForGroup", function(index)
					HideRaidContainerGroupTitles(index)
				end)

				for index = 1, 8 do
					HideRaidContainerGroupTitles(index)
				end

			end)

			-- Hide compact party frame title
			if CompactPartyFrame and CompactPartyFrame.title and CompactPartyFrame.title:IsShown() then CompactPartyFrame.title:Hide() end
			hooksecurefunc("CompactPartyFrame_Generate", function()
				if CompactPartyFrame and CompactPartyFrame.title and CompactPartyFrame.title:IsShown() then
					CompactPartyFrame.title:Hide()
				end
			end)

		end

		----------------------------------------------------------------------
		-- Block requested invites (no reload required)
		----------------------------------------------------------------------

		do

			local frame = CreateFrame("FRAME")
			frame:SetScript("OnEvent", function()
				if LeaPlusLC["NoRequestedInvites"] == "On" then
					local groupInvitePopUp = StaticPopup_FindVisible("GROUP_INVITE_CONFIRMATION")
					if groupInvitePopUp and groupInvitePopUp.data then
						local void, name, guid = GetInviteConfirmationInfo(groupInvitePopUp.data)
						if LeaPlusLC:FriendCheck(name, guid) then
							return
						else
							-- If not a friend, decline
							RespondToInviteConfirmation(groupInvitePopUp.data, false)
							StaticPopup_Hide("GROUP_INVITE_CONFIRMATION")
						end
					end
				end
			end)

			-- Function to set event
			local function SetEvent()
				if LeaPlusLC["NoRequestedInvites"] == "On" then
					frame:RegisterEvent("GROUP_INVITE_CONFIRMATION")
				else
					frame:UnregisterEvent("GROUP_INVITE_CONFIRMATION")
				end
			end

			-- Set event on startup if enabled and when option is clicked
			if LeaPlusLC["NoRequestedInvites"] == "On" then SetEvent() end
			LeaPlusCB["NoRequestedInvites"]:HookScript("OnClick", SetEvent)

		end

		----------------------------------------------------------------------
		-- Block friend requests
		----------------------------------------------------------------------

		do

			-- Function to decline friend requests
			local function DeclineReqs()
				if LeaPlusLC["NoFriendRequests"] == "On" then
					for i = BNGetNumFriendInvites(), 1, -1 do
						local id, player = BNGetFriendInviteInfo(i)
						if id and player then
							BNDeclineFriendInvite(id)
							C_Timer.After(0.1, function()
								LeaPlusLC:Print(L["A friend request from"] .. " " .. player .. " " .. L["was automatically declined."])
							end)
						end
					end
				end
			end

			-- Event frame for incoming friend requests
			local DecEvt = CreateFrame("FRAME")
			DecEvt:SetScript("OnEvent", DeclineReqs)

			-- Function to register or unregister the event
			local function ControlEvent()
				if LeaPlusLC["NoFriendRequests"] == "On" then
					DecEvt:RegisterEvent("BN_FRIEND_INVITE_ADDED")
					DeclineReqs()
				else
					DecEvt:UnregisterEvent("BN_FRIEND_INVITE_ADDED")
				end
			end

			-- Set event status when option is clicked and on startup
			LeaPlusCB["NoFriendRequests"]:HookScript("OnClick", ControlEvent)
			ControlEvent()

		end

		----------------------------------------------------------------------
		--	Block duels (no reload required)
		----------------------------------------------------------------------

		do

			-- Handler for event
			local frame = CreateFrame("FRAME")
			frame:SetScript("OnEvent", function(self, event, arg1)
				if event == "DUEL_REQUESTED" and not LeaPlusLC:FriendCheck(arg1) then
					CancelDuel()
					StaticPopup_Hide("DUEL_REQUESTED")
					return
				end
			end)

			-- Function to set event
			local function SetEvent()
				if LeaPlusLC["NoDuelRequests"] == "On" then
					frame:RegisterEvent("DUEL_REQUESTED")
				else
					frame:UnregisterEvent("DUEL_REQUESTED")
				end
			end

			-- Set event on startup if enabled and when option is clicked
			if LeaPlusLC["NoDuelRequests"] == "On" then SetEvent() end
			LeaPlusCB["NoDuelRequests"]:HookScript("OnClick", SetEvent)

		end

		----------------------------------------------------------------------
		--	Block pet battle duels (no reload required)
		----------------------------------------------------------------------

		do

			-- Handler for event
			local frame = CreateFrame("FRAME")
			frame:SetScript("OnEvent", function(self, event, arg1)
				if not LeaPlusLC:FriendCheck(arg1) then
					C_PetBattles.CancelPVPDuel()
					return
				end
			end)

			-- Function to set event
			local function SetEvent()
				if LeaPlusLC["NoPetDuels"] == "On" then
					frame:RegisterEvent("PET_BATTLE_PVP_DUEL_REQUESTED")
				else
					frame:UnregisterEvent("PET_BATTLE_PVP_DUEL_REQUESTED")
				end
			end

			-- Set event on startup if enabled and when option is clicked
			if LeaPlusLC["NoPetDuels"] == "On" then SetEvent() end
			LeaPlusCB["NoPetDuels"]:HookScript("OnClick", SetEvent)

		end

		----------------------------------------------------------------------
		--	Queue from friends (no reload required)
		----------------------------------------------------------------------

		do

			-- Function to set option
			local function RoleFunc()
				if LeaPlusLC["AutoConfirmRole"] == "On" then
					LFDRoleCheckPopupAcceptButton:SetScript("OnShow", function()
						local leader, leaderGUID  = "", ""
						for i = 1, GetNumSubgroupMembers() do
							if UnitIsGroupLeader("party" .. i) then
								leader = UnitName("party" .. i)
								leaderGUID = UnitGUID("party" .. i)
								break
							end
						end
						if LeaPlusLC:FriendCheck(leader, leaderGUID) then
							LFDRoleCheckPopupAcceptButton:Click()
						end
					end)
				else
					LFDRoleCheckPopupAcceptButton:SetScript("OnShow", nil)
				end
			end

			-- Set option on startup if enabled and when option is clicked
			if LeaPlusLC["AutoConfirmRole"] == "On" then RoleFunc() end
			LeaPlusCB["AutoConfirmRole"]:HookScript("OnClick", RoleFunc)

		end

		----------------------------------------------------------------------
		--	Invite from whispers (no reload required)
		----------------------------------------------------------------------

		do

			local frame = CreateFrame("FRAME")
			frame:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
				if (not UnitExists("party1") or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) and strlower(strtrim(arg1)) == strlower(LeaPlusLC["InvKey"]) then
					if not LeaPlusLC:IsInLFGQueue() then
						if event == "CHAT_MSG_WHISPER" then
							local void, void, void, void, viod, void, void, void, void, guid = ...
							if LeaPlusLC:FriendCheck(arg2, guid) or LeaPlusLC["InviteFriendsOnly"] == "Off" then
								-- If whisper name is same realm, remove realm name
								local theWhisperName, theWhisperRealm = strsplit("-", arg2, 2)
								if theWhisperRealm then
									local void, theCharRealm = UnitFullName("player")
									if theCharRealm then
										if theWhisperRealm == theCharRealm then arg2 = theWhisperName end
									end
								end

								-- Invite whisper player
								C_PartyInfo.InviteUnit(arg2)
							end
						elseif event == "CHAT_MSG_BN_WHISPER" then
							local presenceID = select(11, ...)
							if presenceID and BNIsFriend(presenceID) then
								local index = BNGetFriendIndex(presenceID)
								if index then
									local accountInfo = C_BattleNet.GetFriendAccountInfo(index)
									local gameAccountInfo = accountInfo.gameAccountInfo
									local gameAccountID = gameAccountInfo.gameAccountID
									if gameAccountID then
										BNInviteFriend(gameAccountID)
									end
								end
							end
						end
					end
				end
				return
			end)

			-- Function to set event
			local function SetEvent()
				if LeaPlusLC["InviteFromWhisper"] == "On" then
					frame:RegisterEvent("CHAT_MSG_WHISPER")
					frame:RegisterEvent("CHAT_MSG_BN_WHISPER")
				else
					frame:UnregisterEvent("CHAT_MSG_WHISPER")
					frame:UnregisterEvent("CHAT_MSG_BN_WHISPER")
				end
			end

			-- Set event on startup if enabled and when option is clicked
			if LeaPlusLC["InviteFromWhisper"] == "On" then SetEvent() end
			LeaPlusCB["InviteFromWhisper"]:HookScript("OnClick", SetEvent)

			-- Create configuration panel
			local InvPanel = LeaPlusLC:CreatePanel("Invite from whispers", "InvPanel")

			-- Add editbox
			LeaPlusLC:MakeTx(InvPanel, "Settings", 16, -72)
			LeaPlusLC:MakeCB(InvPanel, "InviteFriendsOnly", "Restrict to friends", 16, -92, false, "If checked, group invites will only be sent to friends.|n|nIf unchecked, group invites will be sent to everyone.")

			LeaPlusLC:MakeTx(InvPanel, "Keyword", 356, -72)
			local KeyBox = LeaPlusLC:CreateEditBox("KeyBox", InvPanel, 140, 10, "TOPLEFT", 356, -92, "KeyBox", "KeyBox")

			-- Function to show the keyword in the option tooltip
			local function SetKeywordTip()
				LeaPlusCB["InviteFromWhisper"].tiptext = gsub(LeaPlusCB["InviteFromWhisper"].tiptext, "(|cffffffff)[^|]*(|r)",  "%1" .. LeaPlusLC["InvKey"] .. "%2")
			end

			-- Function to save the keyword
			local function SetInvKey()
				local keytext = KeyBox:GetText()
				if keytext and keytext ~= "" then
					LeaPlusLC["InvKey"] = strtrim(KeyBox:GetText())
				else
					LeaPlusLC["InvKey"] = "inv"
				end
				-- Show the keyword in the option tooltip
				SetKeywordTip()
			end

			-- Show the keyword in the option tooltip on startup
			SetKeywordTip()

			-- Save the keyword when it changes
			KeyBox:SetScript("OnTextChanged", SetInvKey)

			-- Refresh editbox with trimmed keyword when edit focus is lost (removes additional spaces)
			KeyBox:SetScript("OnEditFocusLost", function()
				KeyBox:SetText(LeaPlusLC["InvKey"])
			end)

			-- Help button hidden
			InvPanel.h:Hide()

			-- Back button handler
			InvPanel.b:SetScript("OnClick", function()
				-- Save the keyword
				SetInvKey()
				-- Show the options panel
				InvPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page2"]:Show()
				return
			end)

			-- Add reset button
			InvPanel.r:SetScript("OnClick", function()
				-- Settings
				LeaPlusLC["InviteFriendsOnly"] = "Off"
				-- Reset the keyword to default
				LeaPlusLC["InvKey"] = "inv"
				-- Set the editbox to default
				KeyBox:SetText("inv")
				-- Save the keyword
				SetInvKey()
				-- Refresh panel
				InvPanel:Hide(); InvPanel:Show()
			end)

			-- Ensure keyword is a string on startup
			LeaPlusLC["InvKey"] = tostring(LeaPlusLC["InvKey"]) or "inv"

			-- Set editbox value when shown
			KeyBox:HookScript("OnShow", function()
				KeyBox:SetText(LeaPlusLC["InvKey"])
			end)

			-- Configuration button handler
			LeaPlusCB["InvWhisperBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["InviteFriendsOnly"] = "On"
					LeaPlusLC["InvKey"] = "inv"
					KeyBox:SetText(LeaPlusLC["InvKey"])
					SetInvKey()
				else
					-- Show panel
					InvPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

		end

		----------------------------------------------------------------------
		--	Party from friends (no reload required)
		----------------------------------------------------------------------

		do

			local frame = CreateFrame("FRAME")
			frame:SetScript("OnEvent", function(self, event, arg1, ...)

				-- If a friend, accept if you're accepting friends and not queued
				local void, void, void, void, guid = ...
				if (LeaPlusLC["AcceptPartyFriends"] == "On" and LeaPlusLC:FriendCheck(arg1, guid)) then
					if not LeaPlusLC:IsInLFGQueue() then
						AcceptGroup()
						for i=1, STATICPOPUP_NUMDIALOGS do
							if _G["StaticPopup"..i].which == "PARTY_INVITE" then
								_G["StaticPopup"..i].inviteAccepted = 1
								StaticPopup_Hide("PARTY_INVITE")
								break
							elseif _G["StaticPopup"..i].which == "PARTY_INVITE_XREALM" then
								_G["StaticPopup"..i].inviteAccepted = 1
								StaticPopup_Hide("PARTY_INVITE_XREALM")
								break
							end
						end
						return
					end
				end
			end)

			-- Function to set event
			local function SetEvent()
				if LeaPlusLC["AcceptPartyFriends"] == "On" then
					frame:RegisterEvent("PARTY_INVITE_REQUEST")
				else
					frame:UnregisterEvent("PARTY_INVITE_REQUEST")
				end
			end

			-- Set event on startup if enabled and when option is clicked
			if LeaPlusLC["AcceptPartyFriends"] == "On" then SetEvent() end
			LeaPlusCB["AcceptPartyFriends"]:HookScript("OnClick", SetEvent)

		end

		----------------------------------------------------------------------
		--	Block party invites (no reload required)
		----------------------------------------------------------------------

		do

			local frame = CreateFrame("FRAME")
			frame:SetScript("OnEvent", function(self, event, arg1, ...)

				-- If not a friend and you're blocking invites, decline
				local void, void, void, void, void, guid = ...
				if LeaPlusLC["NoPartyInvites"] == "On" then
					if LeaPlusLC:FriendCheck(arg1, guid) then
						return
					else
						DeclineGroup()
						StaticPopup_Hide("PARTY_INVITE")
						StaticPopup_Hide("PARTY_INVITE_XREALM")
						return
					end
				end

			end)

			-- Function to set event
			local function SetEvent()
				if LeaPlusLC["NoPartyInvites"] == "On" then
					frame:RegisterEvent("PARTY_INVITE_REQUEST")
				else
					frame:UnregisterEvent("PARTY_INVITE_REQUEST")
				end
			end

			-- Set event on startup if enabled and when option is clicked
			if LeaPlusLC["NoPartyInvites"] == "On" then SetEvent() end
			LeaPlusCB["NoPartyInvites"]:HookScript("OnClick", SetEvent)

		end

		----------------------------------------------------------------------
		--	Automatic summon (no reload required)
		----------------------------------------------------------------------

		do

			-- Event function
			local frame = CreateFrame("FRAME")
			frame:SetScript("OnEvent", function(self, event, arg1)
				if not UnitAffectingCombat("player") then
					local sName = C_SummonInfo.GetSummonConfirmSummoner()
					local sLocation = C_SummonInfo.GetSummonConfirmAreaName()
					LeaPlusLC:Print(L["The summon from"] .. " " .. sName .. " (" .. sLocation .. ") " .. L["will be automatically accepted in 10 seconds unless cancelled."])
					C_Timer.After(10, function()
						local sNameNew = C_SummonInfo.GetSummonConfirmSummoner()
						local sLocationNew = C_SummonInfo.GetSummonConfirmAreaName()
						if sName == sNameNew and sLocation == sLocationNew then
							-- Automatically accept summon after 10 seconds if summoner name and location have not changed
							C_SummonInfo.ConfirmSummon()
							StaticPopup_Hide("CONFIRM_SUMMON")
						end
					end)
				end
			end)

			-- Function to set event
			local function SetEvent()
				if LeaPlusLC["AutoAcceptSummon"] == "On" then
					frame:RegisterEvent("CONFIRM_SUMMON")
				else
					frame:UnregisterEvent("CONFIRM_SUMMON")
				end
			end

			-- Set event on startup if enabled and when option is clicked
			if LeaPlusLC["AutoAcceptSummon"] == "On" then SetEvent() end
			LeaPlusCB["AutoAcceptSummon"]:HookScript("OnClick", SetEvent)

		end

		----------------------------------------------------------------------
		--	Disable loot warnings (no reload required)
		----------------------------------------------------------------------

		do

			local frame = CreateFrame("FRAME")
			frame:SetScript("OnEvent", function(self, event, arg1, arg2, ...)

				-- Disable warnings for attempting to roll Need on loot
				if event == "CONFIRM_LOOT_ROLL" then
					ConfirmLootRoll(arg1, arg2)
					StaticPopup_Hide("CONFIRM_LOOT_ROLL")
					return
				end

				-- Disable warning for attempting to loot a Bind on Pickup item
				if event == "LOOT_BIND_CONFIRM" then
					ConfirmLootSlot(arg1, arg2)
					StaticPopup_Hide("LOOT_BIND",...)
					return
				end

				-- Disable warning for attempting to vendor an item within its refund window
				if event == "MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL" then
					SellCursorItem()
					return
				end

				-- Disable warning for attempting to mail an item within its refund window
				if event == "MAIL_LOCK_SEND_ITEMS" then
					RespondMailLockSendItem(arg1, true)
					return
				end

			end)

			-- Function to set event
			local function SetEvent()
				if LeaPlusLC["NoConfirmLoot"] == "On" then
					frame:RegisterEvent("CONFIRM_LOOT_ROLL")
					frame:RegisterEvent("LOOT_BIND_CONFIRM")
					frame:RegisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL")
					frame:RegisterEvent("MAIL_LOCK_SEND_ITEMS")
				else
					frame:UnregisterEvent("CONFIRM_LOOT_ROLL")
					frame:UnregisterEvent("LOOT_BIND_CONFIRM")
					frame:UnregisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL")
					frame:UnregisterEvent("MAIL_LOCK_SEND_ITEMS")
				end
			end

			-- Set event on startup if enabled and when option is clicked
			if LeaPlusLC["NoConfirmLoot"] == "On" then SetEvent() end
			LeaPlusCB["NoConfirmLoot"]:HookScript("OnClick", SetEvent)

		end

		----------------------------------------------------------------------
		-- Mute mount sounds (no reload required)
		----------------------------------------------------------------------

		do

			-- Get mute table
			local mountTable = Leatrix_Plus["mountTable"]

			-- Give table file level scope (its used during logout and for wipe and admin commands)
			LeaPlusLC["mountTable"] = mountTable

			-- Load saved settings or set default values
			for k, v in pairs(mountTable) do
				if LeaPlusDB[k] and type(LeaPlusDB[k]) == "string" and LeaPlusDB[k] == "On" or LeaPlusDB[k] == "Off" then
					LeaPlusLC[k] = LeaPlusDB[k]
				else
					LeaPlusLC[k] = "Off"
					LeaPlusDB[k] = "Off"
				end
			end

			-- Create configuration panel
			local MountPanel = LeaPlusLC:CreatePanel("Mute mount sounds", "MountPanel")

			-- Add checkboxes
			LeaPlusLC:MakeTx(MountPanel, "Mounts", 16, -72)
			LeaPlusLC:MakeCB(MountPanel, "MuteBikes", "Bikes", 16, -92, false, "If checked, bike mount sounds will be muted.|n|nThis applies to Mekgineer's Chopper and Mechano-hog.")
			LeaPlusLC:MakeCB(MountPanel, "MuteBrooms", "Brooms", 16, -112, false, "If checked, broom mounts will be muted.")
			LeaPlusLC:MakeCB(MountPanel, "MuteGyrocopters", "Gyrocopters", 16, -132, false, "If checked, gyrocopters will be muted.|n|nThis applies to the engineering flying machine mounts.")
			LeaPlusLC:MakeCB(MountPanel, "MuteHorsesteps", "Horsesteps", 16, -152, false, "If checked, footsteps for horse mounts will be muted.")
			LeaPlusLC:MakeCB(MountPanel, "MuteMechSteps", "Mechsteps", 16, -172, false, "If checked, footsteps for mechanical mounts will be muted.")
			LeaPlusLC:MakeCB(MountPanel, "MuteStriders", "Mechstriders", 16, -192, false, "If checked, mechanostriders will be quieter.")
			LeaPlusLC:MakeCB(MountPanel, "MuteNetherdrakes", "Netherdrakes", 16, -212, false, "If checked, netherdrakes will be quieter.")
			LeaPlusLC:MakeCB(MountPanel, "MutePanthers", "Panthers", 16, -232, false, "If checked, the jewelcrafting panther mounts will be quieter.")

			LeaPlusLC:MakeCB(MountPanel, "MuteRockets", "Rockets", 150, -92, false, "If checked, rockets will be muted.")
			LeaPlusLC:MakeCB(MountPanel, "MuteTravelers", "Travelers", 150, -112, false, "If checked, traveling merchant greetings and farewells will be muted.|n|nThis applies to Traveler's Tundra Mammoth and Grand Expedition Yak.")

			-- Set click width for sounds checkboxes
			for k, v in pairs(mountTable) do
				LeaPlusCB[k].f:SetWidth(90)
				if LeaPlusCB[k].f:GetStringWidth() > 90 then
					LeaPlusCB[k]:SetHitRectInsets(0, -80, 0, 0)
				else
					LeaPlusCB[k]:SetHitRectInsets(0, -LeaPlusCB[k].f:GetStringWidth() + 4, 0, 0)
				end
			end

			-- Function to mute and unmute sounds
			local function SetupMute()
				for k, v in pairs(mountTable) do
					if LeaPlusLC["MuteMountSounds"] == "On" and LeaPlusLC[k] == "On" then
						for i, e in pairs(v) do
							local file, soundID = e:match("([^,]+)%#([^,]+)")
							MuteSoundFile(soundID)
						end
					else
						for i, e in pairs(v) do
							local file, soundID = e:match("([^,]+)%#([^,]+)")
							UnmuteSoundFile(soundID)
						end
					end
				end
				-- Handle special cases where sounds overlap
				if LeaPlusLC["MuteMountSounds"] == "On" and (LeaPlusLC["MuteTravelers"] == "On" or LeaPlusLC["MuteStriders"] == "On") then
					-- Mute travelers and mute striders share same sounds
					MuteSoundFile(555128) -- mechastriderwounda
					MuteSoundFile(555129) -- mechastriderwoundb
					MuteSoundFile(555130) -- mechastriderwoundc
				else
					-- Mute travelers and mute striders share same sounds
					UnmuteSoundFile(555128) -- mechastriderwounda
					UnmuteSoundFile(555129) -- mechastriderwoundb
					UnmuteSoundFile(555130) -- mechastriderwoundc
				end
			end

			-- Setup mute on startup if option is enabled
			if LeaPlusLC["MuteMountSounds"] == "On" then SetupMute() end

			-- Setup mute when options are clicked
			for k, v in pairs(mountTable) do
				LeaPlusCB[k]:HookScript("OnClick", SetupMute)
			end
			LeaPlusCB["MuteMountSounds"]:HookScript("OnClick", SetupMute)

			-- Help button hidden
			MountPanel.h:Hide()

			-- Back button handler
			MountPanel.b:SetScript("OnClick", function()
				MountPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page7"]:Show()
				return
			end)

			-- Reset button handler
			MountPanel.r:SetScript("OnClick", function()

				-- Reset checkboxes
				for k, v in pairs(mountTable) do
					LeaPlusLC[k] = "Off"
				end
				SetupMute()

				-- Refresh panel
				MountPanel:Hide(); MountPanel:Show()

			end)

			-- Show panal when options panel button is clicked
			LeaPlusCB["MuteMountSoundsBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					for k, v in pairs(mountTable) do
						LeaPlusLC[k] = "On"
					end
					SetupMute()
				else
					MountPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

		end

		----------------------------------------------------------------------
		-- Mute game sounds (no reload required)
		----------------------------------------------------------------------

		do

			-- Get mute table
			local muteTable = Leatrix_Plus["muteTable"]

			-- Give table file level scope (its used during logout and for wipe and admin commands)
			LeaPlusLC["muteTable"] = muteTable

			-- Load saved settings or set default values
			for k, v in pairs(muteTable) do
				if LeaPlusDB[k] and type(LeaPlusDB[k]) == "string" and LeaPlusDB[k] == "On" or LeaPlusDB[k] == "Off" then
					LeaPlusLC[k] = LeaPlusDB[k]
				else
					LeaPlusLC[k] = "Off"
					LeaPlusDB[k] = "Off"
				end
			end

			-- Create configuration panel
			local SoundPanel = LeaPlusLC:CreatePanel("Mute game sounds", "SoundPanel")

			-- Add checkboxes
			LeaPlusLC:MakeTx(SoundPanel, "General", 16, -72)
			LeaPlusLC:MakeCB(SoundPanel, "MuteChimes", "Chimes", 16, -92, false, "If checked, clock hourly chimes will be muted.")
			LeaPlusLC:MakeCB(SoundPanel, "MuteEvents", "Events", 16, -112, false, "If checked, holiday event sounds will be muted.|n|nThis applies to Headless Horseman.")
			LeaPlusLC:MakeCB(SoundPanel, "MuteFizzle", "Fizzle", 16, -132, false, "If checked, the spell fizzle sounds will be muted.")
			LeaPlusLC:MakeCB(SoundPanel, "MuteInterface", "Interface", 16, -152, false, "If checked, the interface button sound, the chat frame tab click sound and the game menu toggle sound will be muted.")
			LeaPlusLC:MakeCB(SoundPanel, "MuteLogin", "Login", 16, -172, false, "If checked, the login screen music will be muted when you logout of the game.|n|nNote that the login screen music will not be muted when you initially launch the game.|n|nIt will only be muted when you logout of the game.  This includes manually logging out as well as being forcefully logged out by the game server for reasons such as being away for an extended period of time.")
			LeaPlusLC:MakeCB(SoundPanel, "MuteReady", "Ready", 16, -192, false, "If checked, the ready check sound will be muted.")
			LeaPlusLC:MakeCB(SoundPanel, "MuteSniffing", "Sniffing", 16, -212, false, "If checked, the worgen sniffing sounds will be muted.")
			LeaPlusLC:MakeCB(SoundPanel, "MuteTrains", "Trains", 16, -232, false, "If checked, train sounds will be muted.")

			LeaPlusLC:MakeTx(SoundPanel, "General", 150, -72)
			LeaPlusLC:MakeCB(SoundPanel, "MuteVaults", "Vaults", 150, -92, false, "If checked, the mechanical guild vault idle sound will be muted.")

			LeaPlusLC:MakeTx(SoundPanel, "Hunter", 150, -132)
			LeaPlusLC:MakeCB(SoundPanel, "MuteScreech", "Screech", 150, -152, false, "If checked, Screech will be muted.|n|nThis is a spell used by some flying pets.")
			LeaPlusLC:MakeCB(SoundPanel, "MuteYawns", "Yawns", 150, -172, false, "If checked, yawns from hunter pet cats will be muted.")

			LeaPlusLC:MakeTx(SoundPanel, "Pets", 284, -72)
			LeaPlusLC:MakeCB(SoundPanel, "MuteSunflower", "Sunflower", 284, -92, false, "If checked, the Singing Sunflower pet will be muted.")
			LeaPlusLC:MakeCB(SoundPanel, "MutePierre", "Pierre", 284, -112, false, "If checked, Pierre will be quieter.")

			LeaPlusLC:MakeTx(SoundPanel, "Toys", 284, -152)
			LeaPlusLC:MakeCB(SoundPanel, "MuteBalls", "Balls", 284, -172, false, "If checked, the Foot Ball sounds will be muted.")

			LeaPlusLC:MakeTx(SoundPanel, "Misc", 418, -72)
			LeaPlusLC:MakeCB(SoundPanel, "MuteAdal", "A'dal", 418, -92, false, "If checked, A'dal in Shattrath City will be muted.")
			LeaPlusLC:MakeCB(SoundPanel, "MuteRipper", "Ripper", 418, -112, false, "If checked, the Arcanite Ripper guitar sound will be muted.")
			LeaPlusLC:MakeCB(SoundPanel, "MuteRhonin", "Rhonin", 418, -132, false, "If checked, Rhonin will be muted.")
			LeaPlusLC:MakeCB(SoundPanel, "MuteKalecgos", "Kalecgos", 418, -152, false, "If checked, the speech made by Kalecgos at the Dragonwrath ceremony will be muted.")

			-- Set click width for sounds checkboxes
			for k, v in pairs(muteTable) do
				LeaPlusCB[k].f:SetWidth(90)
				if LeaPlusCB[k].f:GetStringWidth() > 90 then
					LeaPlusCB[k]:SetHitRectInsets(0, -80, 0, 0)
				else
					LeaPlusCB[k]:SetHitRectInsets(0, -LeaPlusCB[k].f:GetStringWidth() + 4, 0, 0)
				end
			end

			-- Function to mute and unmute sounds
			local function SetupMute()
				for k, v in pairs(muteTable) do
					if LeaPlusLC["MuteGameSounds"] == "On" and LeaPlusLC[k] == "On" then
						for i, e in pairs(v) do
							local file, soundID = e:match("([^,]+)%#([^,]+)")
							MuteSoundFile(soundID)
						end
					else
						for i, e in pairs(v) do
							local file, soundID = e:match("([^,]+)%#([^,]+)")
							UnmuteSoundFile(soundID)
						end
					end
				end
			end

			-- Setup mute on startup if option is enabled
			if LeaPlusLC["MuteGameSounds"] == "On" then SetupMute() end

			-- Setup mute when options are clicked
			for k, v in pairs(muteTable) do
				LeaPlusCB[k]:HookScript("OnClick", SetupMute)
			end
			LeaPlusCB["MuteGameSounds"]:HookScript("OnClick", SetupMute)

			-- Help button hidden
			SoundPanel.h:Hide()

			-- Back button handler
			SoundPanel.b:SetScript("OnClick", function()
				SoundPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page7"]:Show()
				return
			end)

			-- Reset button handler
			SoundPanel.r:SetScript("OnClick", function()

				-- Reset checkboxes
				for k, v in pairs(muteTable) do
					LeaPlusLC[k] = "Off"
				end
				SetupMute()

				-- Refresh panel
				SoundPanel:Hide(); SoundPanel:Show()

			end)

			-- Show panal when options panel button is clicked
			LeaPlusCB["MuteGameSoundsBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					for k, v in pairs(muteTable) do
						LeaPlusLC[k] = "On"
					end
					LeaPlusLC["MuteReady"] = "Off"
					SetupMute()
				else
					SoundPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

			----------------------------------------------------------------------
			-- Login setting
			----------------------------------------------------------------------

			-- Create soundtable for PLAYER_LOGOUT (these sounds are only muted or unmuted when logging out
			local muteLogoutTable = {
				-- Game music (sound/music/pandaria/mus_50_heartofpandaria_01.mp3#625753)
				"625753",
			}

			-- Handle sounds that get muted or unmuted when logging out
			local logoutEvent = CreateFrame("FRAME")
			logoutEvent:RegisterEvent("PLAYER_LOGOUT")

			-- Mute or unmute sounds when logging out
			logoutEvent:SetScript("OnEvent", function()
				if LeaPlusLC["MuteGameSounds"] == "On" and LeaPlusLC["MuteLogin"] == "On" then
					-- Mute logout table sounds on logout
					for void, soundID in pairs(muteLogoutTable) do
						MuteSoundFile(soundID)
					end
				else
					-- Unmute logout table sounds on logout
					for void, soundID in pairs(muteLogoutTable) do
						UnmuteSoundFile(soundID)
					end
				end
			end)

			-- Unmute sounds when logging in
			for void, soundID in pairs(muteLogoutTable) do
				UnmuteSoundFile(soundID)
			end

		end

		----------------------------------------------------------------------
		-- Faster movie skip
		----------------------------------------------------------------------

		if LeaPlusLC["FasterMovieSkip"] == "On" then

			-- Allow space bar, escape key and enter key to cancel cinematic without confirmation
			CinematicFrame:HookScript("OnKeyDown", function(self, key)
				if key == "ESCAPE" then
					if CinematicFrame:IsShown() and CinematicFrame.closeDialog and CinematicFrameCloseDialogConfirmButton then
						CinematicFrameCloseDialog:Hide()
					end
				end
			end)
			CinematicFrame:HookScript("OnKeyUp", function(self, key)
				if key == "SPACE" or key == "ESCAPE" or key == "ENTER" then
					if CinematicFrame:IsShown() and CinematicFrame.closeDialog and CinematicFrameCloseDialogConfirmButton then
						CinematicFrameCloseDialogConfirmButton:Click()
					end
				end
			end)
			MovieFrame:HookScript("OnKeyUp", function(self, key)
				if key == "SPACE" or key == "ESCAPE" or key == "ENTER" then
					if MovieFrame:IsShown() and MovieFrame.CloseDialog and MovieFrame.CloseDialog.ConfirmButton then
						MovieFrame.CloseDialog.ConfirmButton:Click()
					end
				end
			end)

		end

		----------------------------------------------------------------------
		-- Wowhead Links
		----------------------------------------------------------------------

		if LeaPlusLC["ShowWowheadLinks"] == "On" then

			-- Create configuration panel
			local WowheadPanel = LeaPlusLC:CreatePanel("Show Wowhead links", "WowheadPanel")

			LeaPlusLC:MakeTx(WowheadPanel, "Settings", 16, -72)
			LeaPlusLC:MakeCB(WowheadPanel, "WowheadLinkComments", "Links go directly to the comments section", 16, -92, false, "If checked, Wowhead links will go directly to the comments section.")

			-- Help button hidden
			WowheadPanel.h:Hide()

			-- Back button handler
			WowheadPanel.b:SetScript("OnClick", function()
				WowheadPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page5"]:Show()
				return
			end)

			-- Reset button handler
			WowheadPanel.r:SetScript("OnClick", function()

				-- Reset controls
				LeaPlusLC["WowheadLinkComments"] = "Off"

				-- Refresh configuration panel
				WowheadPanel:Hide(); WowheadPanel:Show()

			end)

			-- Show configuration panal when options panel button is clicked
			LeaPlusCB["ShowWowheadLinksBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["WowheadLinkComments"] = "Off"
				else
					WowheadPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

			-- Get localised Wowhead URL
			local wowheadLoc
			if 	   GameLocale == "deDE" then wowheadLoc = "wowhead.com/mop-classic/de"
			elseif GameLocale == "esMX" then wowheadLoc = "wowhead.com/mop-classic/mx"
			elseif GameLocale == "esES" then wowheadLoc = "wowhead.com/mop-classic/es"
			elseif GameLocale == "frFR" then wowheadLoc = "wowhead.com/mop-classic/fr"
			elseif GameLocale == "itIT" then wowheadLoc = "wowhead.com/mop-classic/it"
			elseif GameLocale == "ptBR" then wowheadLoc = "wowhead.com/mop-classic/pt"
			elseif GameLocale == "ruRU" then wowheadLoc = "wowhead.com/mop-classic/ru"
			elseif GameLocale == "koKR" then wowheadLoc = "wowhead.com/mop-classic/ko"
			elseif GameLocale == "zhCN" then wowheadLoc = "wowhead.com/mop-classic/cn"
			elseif GameLocale == "zhTW" then wowheadLoc = "wowhead.com/mop-classic/tw"
			else							 wowheadLoc = "wowhead.com/mop-classic"
			end

			----------------------------------------------------------------------
			-- Achievements frame
			----------------------------------------------------------------------

			-- Achievement link function
			EventUtil.ContinueOnAddOnLoaded("Blizzard_AchievementUI",function()

				-- Create editbox
				local aEB = CreateFrame("EditBox", nil, AchievementFrame)
				aEB:ClearAllPoints()
				aEB:SetPoint("BOTTOMRIGHT", -50, 1)
				aEB:SetHeight(16)
				aEB:SetFontObject("GameFontNormalSmall")
				aEB:SetBlinkSpeed(0)
				aEB:SetJustifyH("RIGHT")
				aEB:SetAutoFocus(false)
				aEB:EnableKeyboard(false)
				aEB:SetHitRectInsets(90, 0, 0, 0)
				aEB:SetScript("OnKeyDown", function() end)
				aEB:SetScript("OnMouseUp", function()
					if aEB:IsMouseOver() then
						aEB:HighlightText()
					else
						aEB:HighlightText(0, 0)
					end
				end)

				-- Create hidden font string (used for setting width of editbox)
				aEB.z = aEB:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
				aEB.z:Hide()

				-- Store last link in case editbox is cleared
				local lastAchievementLink

				-- Function to set editbox value
				hooksecurefunc("AchievementFrameAchievements_SelectButton", function(self)
					local achievementID = self.id or nil
					if achievementID then
						-- Set editbox text
						if LeaPlusLC["WowheadLinkComments"] == "On" then
							aEB:SetText("https://" .. wowheadLoc .. "/achievement=" .. achievementID .. "#comments")
						else
							aEB:SetText("https://" .. wowheadLoc .. "/achievement=" .. achievementID)
						end
						lastAchievementLink = aEB:GetText()
						-- Set hidden fontstring then resize editbox to match
						aEB.z:SetText(aEB:GetText())
						aEB:SetWidth(aEB.z:GetStringWidth() + 90)
						-- Get achievement title for tooltip
						local achievementLink = GetAchievementLink(self.id)
						if achievementLink then
							aEB.tiptext = achievementLink:match("%[(.-)%]") .. "|n" .. L["Press CTRL/C to copy."]
						end
						-- Show the editbox
						aEB:Show()
					end
				end)

				-- Create tooltip
				aEB:HookScript("OnEnter", function()
					aEB:HighlightText()
					aEB:SetFocus()
					GameTooltip:SetOwner(aEB, "ANCHOR_TOP", 0, 10)
					GameTooltip:SetText(aEB.tiptext, nil, nil, nil, nil, true)
					GameTooltip:Show()
				end)

				aEB:HookScript("OnLeave", function()
					-- Set link text again if it's changed since it was set
					if aEB:GetText() ~= lastAchievementLink then aEB:SetText(lastAchievementLink) end
					aEB:HighlightText(0, 0)
					aEB:ClearFocus()
					GameTooltip:Hide()
				end)

				-- Hide editbox when achievement is deselected
				hooksecurefunc("AchievementFrameAchievements_ClearSelection", function(self) aEB:Hide()	end)
				hooksecurefunc("AchievementCategoryButton_OnClick", function(self) aEB:Hide() end)

			end)

			----------------------------------------------------------------------
			-- Quest log frame
			----------------------------------------------------------------------

			-- Create editbox
			local mEB
			mEB = CreateFrame("EditBox", nil, QuestLogFrame.TitleContainer)
			mEB:ClearAllPoints()
			mEB:SetPoint("TOPLEFT", 8, -2)
			QuestLogTitleText:Hide()
			mEB:SetHeight(16)
			mEB:SetFontObject("GameFontNormal")
			mEB:SetBlinkSpeed(0)
			mEB:SetAutoFocus(false)
			mEB:EnableKeyboard(false)
			mEB:SetHitRectInsets(0, 90, 0, 0)
			mEB:SetScript("OnKeyDown", function() end)
			mEB:SetScript("OnMouseUp", function()
				if mEB:IsMouseOver() then
					mEB:HighlightText()
				else
					mEB:HighlightText(0, 0)
				end
			end)

			-- Set the background color
			mEB.t = mEB:CreateTexture(nil, "BACKGROUND")
			mEB.t:SetPoint(mEB:GetPoint())
			mEB.t:SetSize(mEB:GetSize())
			mEB.t:SetColorTexture(0.05, 0.05, 0.05, 1.0)

			-- Create hidden font string (used for setting width of editbox)
			mEB.z = mEB:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			mEB.z:Hide()

			-- Function to set editbox value
			local function SetQuestInBox(questListID)

				local questTitle, void, void, isHeader, void, void, void, questID = GetQuestLogTitle(questListID)
				if questID and not isHeader then

					-- Hide editbox if quest ID is invalid
					if questID == 0 then mEB:Hide() else mEB:Show() end

					-- Set editbox text
					if LeaPlusLC["WowheadLinkComments"] == "On" then
						mEB:SetText("https://" .. wowheadLoc .. "/quest=" .. questID .. "#comments")
					else
						mEB:SetText("https://" .. wowheadLoc .. "/quest=" .. questID)
					end

					-- Set hidden fontstring then resize editbox to match
					mEB.z:SetText(mEB:GetText())
					mEB:SetWidth(mEB.z:GetStringWidth() + 90)
					mEB.t:SetWidth(mEB.z:GetStringWidth())

					-- Get quest title for tooltip
					if questTitle then
						mEB.tiptext = questTitle .. "|n" .. L["Press CTRL/C to copy."]
					else
						mEB.tiptext = ""
						if mEB:IsMouseOver() and GameTooltip:IsShown() then GameTooltip:Hide() end
					end

				end
			end

			-- Set URL when quest is selected (this works with Questie, old method used QuestLog_SetSelection)
			hooksecurefunc("SelectQuestLogEntry", function(questListID)
				SetQuestInBox(questListID)
			end)

			-- Create tooltip
			mEB:HookScript("OnEnter", function()
				mEB:HighlightText()
				mEB:SetFocus()
				GameTooltip:SetOwner(mEB, "ANCHOR_BOTTOM", 0, -10)
				GameTooltip:SetText(mEB.tiptext, nil, nil, nil, nil, true)
				GameTooltip:Show()
			end)

			mEB:HookScript("OnLeave", function()
				mEB:HighlightText(0, 0)
				mEB:ClearFocus()
				GameTooltip:Hide()
			end)

			-- ElvUI fix to move Wowhead link inside the quest log frame
			if LeaPlusLC.ElvUI then
				C_Timer.After(0.1, function()
					QuestLogTitleText:ClearAllPoints()
					QuestLogTitleText:SetPoint("TOPLEFT", QuestLogFrame, "TOPLEFT", 32, -18)
					if QuestLogTitleText:GetStringWidth() > 200 then
						QuestLogTitleText:SetWidth(200)
					else
						QuestLogTitleText:SetWidth(QuestLogTitleText:GetStringWidth())
					end
					mEB:ClearAllPoints()
					mEB:SetPoint("LEFT", QuestLogTitleText, "RIGHT", 10, 0)
					mEB.t:Hide()
				end)
			end

		end

		----------------------------------------------------------------------
		-- Automate gossip (no reload required)
		----------------------------------------------------------------------

		do

			-- Function to skip gossip
			local function SkipGossip(skipAltKeyRequirement)
				if not skipAltKeyRequirement and not IsAltKeyDown() then return end
				local gossipInfoTable = C_GossipInfo.GetOptions()
				if gossipInfoTable and #gossipInfoTable == 1 and C_GossipInfo.GetNumAvailableQuests() == 0 and C_GossipInfo.GetNumActiveQuests() == 0 and gossipInfoTable[1] and gossipInfoTable[1].gossipOptionID then
					C_GossipInfo.SelectOption(gossipInfoTable[1].gossipOptionID)
				end
			end

			-- Create gossip event frame
			local gossipFrame = CreateFrame("FRAME")

			-- Function to setup events
			local function SetupEvents()
				if LeaPlusLC["AutomateGossip"] == "On" then
					gossipFrame:RegisterEvent("GOSSIP_SHOW")
				else
					gossipFrame:UnregisterEvent("GOSSIP_SHOW")
				end
			end

			-- Setup events when option is clicked and on startup (if option is enabled)
			LeaPlusCB["AutomateGossip"]:HookScript("OnClick", SetupEvents)
			if LeaPlusLC["AutomateGossip"] == "On" then SetupEvents() end

			-- Create tables for specific NPC IDs (these are automatically selected with no alt key requirement)
			local npcTable = {

				-- Auctioneers (https://www.wowhead.com/mop-classic/npcs?filter=18;1;0)
				44865, 44866, 8719, 44868, 9857, 46639, 8723, 15677, 16627, 50139, 8672, 50140, 8720, 15686, 8661, 50145, 8671, 16628, 15682, 15679, 8670, 18761, 46637, 16707, 8721, 18348, 45659, 17629, 43842, 9856, 8722, 43690, 18349, 50143, 15659, 17627, 9858, 46640, 43841, 9859, 15683, 15681, 44867, 15678, 44787, 8674, 15675, 16629, 8673, 8669, 15684, 46638, 17628, 8724, 15676, 45082, 35594, 35607,

				-- Banker (https://www.wowhead.com/mop-classic/npcs?filter=19;1;0)
				35642, 30606, 8356, 50560, 64023, 50563, 2461, 19246, 43840, 2457, 72554, 43820, 45661, 43824, 8357, 2460, 46619, 29530, 44853, 50559, 50566, 17631, 50557, 43725, 16617, 17632, 50556, 46618, 36284, 3496, 4209, 7799, 50569, 36186, 38746, 39201, 19318, 17633, 4155, 13917, 18350, 43723, 50568, 3309, 31420, 21733, 16710, 43819, 44854, 3318, 31421, 43692, 19338, 4208, 43724, 43823, 45081, 50252, 28343, 19034, 44851, 50558, 2459, 21732, 2456, 16615, 45662, 2455, 4550, 17773, 46621, 29282, 30608, 29283, 5083, 16616, 44856, 8124, 2458, 8123, 44852, 36351, 5099, 3320, 31422, 50554, 44770, 30604, 28676, 28680, 28679, 30605, 28678, 28677, 30607, 28675, 43822, 2996, 36352, 63969, 63965, 63971, 63964, 63970, 63967, 63966, 64024, 63968, 46620, 2625, 46622, 43825, 50555, 4549, 5060, 8119, 21734, 38919, 38920, 38921,

				-- Battlemaster (https://www.wowhead.com/mop-classic/npcs?filter=20;1;0)
				15008, 34952, 34973, 3890, 20273, 44004, 19907, 35007, 19915, 34998, 14990, 20271, 14942, 14991, 35000, 32330, 34978, 35001, 19908, 20276, 19912, 21235, 32333, 19858, 29568, 2302, 40413, 29669, 29674, 20385, 29668, 29673, 35002, 19911, 19923, 34991, 34983, 34997, 15006, 18895, 14981, 22013, 22015, 29670, 29675, 20497, 20499, 15106, 19910, 12197, 16695, 34987, 34953, 34999, 20381, 20374, 49573, 34955, 20274, 25991, 16696, 2804, 34988, 14982, 20386, 12198, 19859, 19925, 34985, 20269, 30231, 32332, 19909, 34989, 34976, 35008, 29533, 15102, 15007, 15103, 30566, 30567, 29676, 29671, 19905, 19906, 30610, 15105, 29672, 29667, 20384,

				-- Flightmaster (https://www.wowhead.com/mop-classic/npcs?filter=21;1;0)
				44407, 28574, 8018, 43328, 3310, 47927, 26876, 18931, 28618, 523, 48321, 41383, 47655, 352, 37888, 2861, 19583, 28623, 42406, 12617, 26560, 10378, 40966, 47155, 8609, 35137, 43549, 28674, 47121, 30869, 16587, 12596, 39212, 11900, 6026, 43220, 43225, 18939, 41325, 24032, 43043, 4267, 33253, 47154, 40358, 41861, 18789, 8019, 32571, 48318, 30870, 43053, 12577, 26845, 43573, 48275, 2941, 26853, 35481, 44409, 26851, 26881, 43121, 23736, 54392, 43052, 43104, 46004, 44230, 21107, 26878, 20234, 43295, 44408, 10897, 16189, 41214, 40852, 2995, 28037, 42426, 24155, 40473, 2851, 47875, 44233, 43088, 27344, 30433, 21766, 18937, 19558, 11901, 43124, 931, 43371, 41580, 4321, 28615, 6706, 42983, 45479, 44825, 7823, 28195, 2299, 16227, 47156, 29950, 43570, 43701, 7824, 41140, 2835, 35138, 43079, 28196, 15177, 39330, 41323, 2432, 47644, 47661, 26877, 47118, 44231, 3615, 43481, 50084, 43085, 43702, 31078, 19317, 18791, 41332, 41321, 41860, 53783, 48273, 29750, 47147, 12740, 2409, 22216, 40553, 41240, 16822, 39175, 41246, 43290, 50463, 37005, 18809, 30271, 40558, 12636, 46006, 47119, 4314, 22931, 34927, 47174, 43000, 43107, 28621, 23859, 29480, 2858, 3305, 10583, 1573, 20762, 18808, 2859, 41322, 22485, 43073, 41142, 20515, 47061, 33849, 29762, 18942, 44410, 24061, 43045, 44232, 48274, 39210, 43697, 29757, 35136, 26602, 2226, 18807, 26848, 28197, 24851, 35140, 35562, 26852, 18938, 8610, 36728, 18785, 17554, 35478, 40552, 26844, 52060, 28624, 19581, 11138, 46011, 41605, 4551, 12578, 30314, 18788, 34378, 44399, 35315, 26566, 24366, 43072, 26850, 18940, 26847, 35141, 43087, 31069, 47665, 30569, 41215, 54393, 43042, 15178, 43114, 47133, 40367, 11899, 29951, 1571, 39898, 43086, 29721, 22455, 30269, 44036, 44244, 16192, 34374, 17555, 39211, 46552, 22935, 24795, 40851, 40866, 40867, 40871, 40873, 43216, 43287, 43289, 43293, 40809, 3841, 4407, 6726, 4312, 1572, 34429, 35556, 40827, 1387, 40768, 37915, 47116, 26879, 25288, 39340, 18953, 13177, 26880, 3838, 12616, 18930, 27046, 34943, 11139, 43991, 2389, 40769, 35139, 4317, 4319,

				-- Flightmaster (non-Flightmaster NPCs with <Flight Master> in the description) (https://www.wowhead.com/mop-classic/npcs/name-extended:%3CFlight+Master%3E?filter=21;2;0)
				60231, 59727, 50686, 61512, 59046, 59735, 59049, 59733, 62658, 60416, 60232, 63501, 61473, 11798, 59048, 63498, 29749, 60441, 11800, 59812, 65865, 58843, 65511, 67785, 61759, 64310, 61118, 61511, 68226, 54898, 54788, 65189, 50367, 43576, 43398, 43389, 31690, 59732, 63500, 61474, 50072, 59186, 61504, 33254, 33345, 63497, 65863, 59047, 52983, 29137, 61380, 61745, 59736, 61744, 66227, 66023, 35480, 26842,

				-- Stable masters (https://www.wowhead.com/mop-classic/npcs?filter=27;1;0)
				28047, 26044, 44252, 9986, 26504, 9988, 16586, 21517, 18250, 16824, 21518, 15131, 29948, 29740, 19368, 22469, 10049, 10063, 10051, 9980, 9976, 10057, 18984, 11105, 43408, 10056, 16185, 29959, 10059, 10053, 16764, 30039, 17666, 11117, 11119, 10046, 45789, 10054, 27010, 29658, 48887, 16094, 6749, 17485, 28790, 28057, 21336, 10048, 10058, 10060, 26721, 29906, 23733, 14741, 10085, 11069, 17896, 30008, 49790, 9983, 18244, 10061, 10045, 9985, 24905, 53780, 9989, 24974, 47866, 44788, 19476, 19019, 24067, 10052, 27068, 10047, 35291, 10055, 47764, 22468, 50069, 16665, 9982, 27948, 24350, 9979, 10050, 25037, 16656, 11104, 9987, 9981, 23392, 26944, 15722, 26377, 35290, 10062, 13617, 9977, 28690, 41903, 33854, 26597, 27183, 9984, 9978, 19018,

				-- Stable masters (non-Stable master NPCs with <Stable Master> in the description) (https://www.wowhead.com/mop-classic/npcs/name-extended:%3CStable+Master%3E?filter=27;2;0)
				68993, 66241, 66244, 44346, 45298, 66230, 66245, 63986, 68989, 73632, 47761, 63988, 62935, 27056, 47337, 66247, 45498, 66266, 59509, 68986, 66243, 27236, 44382, 19491, 19492, 43021, 44378, 49431, 24066, 49577, 19325, 45297, 66717, 35344, 49689, 27065, 25519, 44348, 43988, 42966, 59413, 48055, 43630, 44123, 43017, 49408, 43877, 44191, 13616, 41893, 44330, 44354, 43979, 66250, 66251, 48216, 30304, 47368, 49554, 47934, 48095, 49803, 29251, 44310, 42911, 43379, 43617, 24154, 49600, 42875, 44349, 543, 43494, 69252, 27385, 43766, 66249, 49767, 43994, 49395, 44007, 43151, 44384, 28683, 28555, 27429, 43773, 49593, 70184, 43770, 43019, 9567, 59310, 66246, 66248, 29250, 27194, 27150, 29967, 43982, 43634, 44347, 44335, 9896, 49755, 27040,

				-- Trainer but NOT Class Trainer (they are useful in MoP) (https://www.wowhead.com/mop-classic/npcs?filter=28:24;1:2;0:0)
				3347, 1215, 33603, 45709, 28696, 25580, 47418, 18018, 26977, 16588, 47571, 33611, 6251, 45545, 30715, 5513, 45286, 46716, 30713, 33588, 29505, 30706, 4752, 13476, 53436, 5518, 45137, 16280, 11017, 34693, 26960, 3365, 28703, 7868, 4160, 29631, 31238, 4576, 11557, 17434, 3605, 28701, 6291, 3355, 18774, 48619, 33619, 17441, 18772, 5153, 28705, 7406, 31247, 5564, 17844, 42323, 3606, 26997, 11870, 16669, 4258, 43769, 27001, 43693, 5127, 31084, 35874, 18751, 16640, 47419, 19052, 28706, 26972, 375, 7867, 3494, 47396, 35135, 4900, 2836, 26905, 18990, 18749, 28693, 26987, 32474, 51638, 26982, 5157, 1231, 4193, 5164, 11098, 19063, 16773, 25099, 17634, 33637, 3703, 18775, 17637, 12025, 1292, 2834, 377, 5174, 3706, 5177, 4773, 33996, 18802, 4215, 50002, 7869, 11865, 7870, 4941, 28699, 25277, 3290, 4611, 3181, 2704, 44783, 50497, 33615, 19185, 9584, 7948, 2485, 38244, 49959, 3363, 35133, 28742, 44919, 54232, 52657, 18993, 29509, 34713, 28702, 16583, 52640, 28697, 4772, 11867, 17246, 3967, 33630, 16728, 33674, 26964, 49870, 11869, 2390, 16161, 1232, 17514, 26911, 42331, 13084, 8140, 26909, 2129, 12939, 17005, 4165, 52651, 1676, 38514, 3594, 3060, 1346, 49786, 21087, 44238, 53437, 20511, 11866, 50020, 4596, 4753, 33614, 55684, 198, 33681, 19186, 26903, 5499, 50498, 16160, 4591, 44465, 45559, 20500, 33675, 3067, 16277, 33591, 1386, 17480, 47421, 11868, 33638, 33677, 26953, 7944, 8738, 35869, 28956, 1683, 49902, 38911, 27703, 49760, 39206, 1632, 52645, 16646, 16658, 15501, 16662, 26990, 34785, 23734, 29508, 11073, 29156, 3373, 46709, 43278, 16501, 3009, 46983, 33587, 33586, 5957, 33609, 11178, 26564, 3523, 50022, 8736, 34708, 35873, 38799, 3136, 4894, 33635, 4211, 10930, 47579, 48618, 2399, 43010, 50007, 28700, 36615, 39718, 2367, 11097, 459, 33580, 49720, 4552, 49895, 50128, 17089, 908, 33682, 3153, 1470, 19341, 3557, 52586, 986, 1218, 11074, 19252, 38467, 16621, 2124, 50247, 26955, 3154, 11037, 18773, 33589, 4578, 51639, 5501, 3602, 1473, 45548, 16499, 7231, 45540, 33581, 3964, 50732, 4616, 36630, 16723, 43011, 50505, 3357, 29507, 3597, 48612, 2130, 26958, 34711, 36521, 3062, 26916, 33617, 33636, 50137, 16719, 46741, 38465, 8153, 30722, 24868, 7866, 30709, 49946, 15513, 33679, 16729, 43006, 18776, 26998, 3155, 17481, 16366, 7230, 3549, 3157, 34692, 35805, 514, 26991, 49791, 56068, 33613, 4213, 52636, 16279, 5566, 50032, 43429, 3011, 47405, 53415, 44582, 30716, 5958, 26986, 3007, 5938, 47431, 5695, 36525, 38518, 33684, 50570, 35093, 7953, 5392, 6286, 38243, 23896, 53409, 20914, 17110, 47382, 49964, 460, 28694, 50010, 33608, 4210, 8308, 34600, 34786, 53403, 49789, 812, 43009, 3593, 28474, 50574, 16703, 22477, 17214, 17424, 49962, 3607, 56796, 26957, 2856, 39116, 43795, 27023, 27029, 15400, 18991, 26988, 4573, 5493, 26975, 4588, 17222, 19540, 3026, 4156, 4090, 2131, 26996, 3596, 16761, 23534, 50136, 49894, 34673, 35758, 36518, 38122, 33631, 18754, 18988, 49718, 49806, 44129, 16663, 50504, 26914, 45019, 7954, 17245, 50012, 47575, 26959, 7232, 33639, 16644, 16367, 29924, 7946, 837, 4898, 50025, 1385, 3001, 1681, 4598, 926, 1702, 925, 927, 18771, 26976, 26992, 6094, 16756, 2128, 23566, 16642, 8141, 2132, 36628, 44459, 19369, 16266, 16736, 3069, 50028, 5690, 50011, 1355, 26981, 3087, 3965, 3603, 17215, 1701, 45713, 3963, 2119, 16667, 50019, 50729, 52335, 50027, 48614, 2123, 49715, 19187, 5159, 2122, 3601, 49769, 39100, 43881, 49957, 6299, 49997, 49952, 23103, 16738, 3172, 29513, 17101, 47570, 49879, 28704, 6387, 16780, 33683, 42324, 52292, 8306, 49942, 17488, 3174, 50714, 50029, 6292, 16685, 1103, 30717, 26906, 34710, 47346, 26954, 17105, 33610, 33633, 19251, 33634, 26980, 16774, 17487, 4214, 34696, 35778, 36519, 38513, 33583, 53421, 43428, 6707, 47576, 49793, 19778, 2114, 26910, 18753, 26999, 19478, 50567, 29514, 4204, 33621, 33623, 34689, 35780, 36520, 49896, 52642, 11031, 26913, 49782, 16269, 18987, 3064, 4254, 47574, 16661, 5612, 50033, 52170, 3345, 9465, 46357, 1229, 2627, 1699, 49781, 49808, 5161, 26912, 26961, 49998, 17482, 43464, 47569, 33640, 16270, 16655, 35100, 49954, 3179, 3059, 6306, 33616, 17983, 17519, 1234, 27704, 47578, 16823, 45023, 44461, 36629, 38798, 18779, 1411, 47568, 5388, 20791, 47420, 33641, 49940, 11146, 43005, 17510, 44380, 50004, 3404, 3599, 8142, 2837, 6288, 19539, 28698, 4138, 18777, 4892, 43883, 28958, 15280, 33678, 3555, 26962, 915, 27034, 15279, 18911, 3028, 19775, 49736, 16272, 3170, 3690, 48616, 2998, 39214, 988, 14740, 17121, 17504, 45720, 42366, 3707, 49939, 50723, 917, 3484, 12961, 7087, 26994, 11072, 3013, 16503, 20124, 1404, 3063, 26952, 18747, 3175, 49885, 8144, 6297, 3598, 28471, 49963, 50720, 51640, 3061, 49927, 48613, 49968, 5941, 3600, 33612, 1651, 49955, 2492, 47384, 47577, 53410, 911, 28472, 35871, 38796, 44464, 27705, 43012, 1317, 46675, 12032, 3332, 16755, 16688, 913, 50715, 1228, 52317, 3704, 34714, 5884, 52319, 5506, 3604, 985, 12030, 30711, 4888, 944, 4614, 16253, 16273, 15284, 50013, 49950, 49958, 3137, 1680, 1226, 906, 2126, 34695, 35786, 38515, 49900, 4159, 19340, 16724, 3184, 30721, 2329, 19184, 2489, 3185, 7089, 17442, 18755, 43892, 16752, 1382, 11025, 50015, 50034, 50499, 35872, 36631, 38794, 16725, 11397, 16654, 3066, 3156, 50609, 47400, 38242, 52587, 33680, 16686, 45095, 5150, 5146, 8126, 38037, 29233, 5759, 16731, 16726, 987, 11177, 26993, 44975, 33590, 44781, 50023, 29506, 38247, 47572, 26915, 2798, 50001, 50016, 15285, 49949, 50158, 1700, 43431, 8128, 28746, 16276, 49784, 49749, 18804, 6287, 53405, 26969, 50021, 6289, 4732, 5943, 53404, 16763, 44782, 48513, 5137, 34712, 26963, 37072, 26989, 26904, 18748, 35281, 47253, 2127, 8146, 50024, 26956, 53407, 43455, 44128, 16278, 7871, 16633, 43015, 43870, 37724, 49923, 2391, 35839, 36651, 38793, 44455, 50500, 49745, 19180, 2327, 16721, 3595, 49966, 48615, 5502, 47573, 44468, 50501, 35870, 36632, 38466, 38795, 49741, 49901, 36523, 38516, 33618, 2818, 35806, 36524, 38517, 916, 38246, 51997, 5482, 49909, 50017, 49945, 15283, 37737, 43013, 50035, 43001, 8664, 3173, 16676, 43796, 50506, 26974, 50690, 51637, 50018, 3169, 37121, 4212, 1458, 37115, 3004, 2326, 32712, 5141, 5511, 49716, 895, 3171, 912, 7088, 11052, 26995, 26907, 1241, 1430, 27000, 3478, 17483, 17212, 38245, 10993, 16692, 5880, 45138, 3048, 16500, 50507, 49961, 5939, 45717, 44469, 50502, 36652, 38797, 42618, 5784, 34697, 35807, 26951, 6295, 50127, 45029, 7949, 19576, 3065, 50006, 6290, 328, 16502, 3399, 30710, 45550, 18752, 16684, 45139, 20125, 50031, 33676,

				-- Vendor (https://www.wowhead.com/mop-classic/npcs?filter=29;1;0) (split into expansion brackets)
				-- Added in expansion: NONE (https://www.wowhead.com/mop-classic/npcs?filter=29:39;1:1;0:0)
				3934, 14450, 5594, 7947, 12788, 12919, 1263, 6367, 14481, 3159, 8118, 3008, 12799, 15127, 4561, 8665, 2622, 13476, 9179, 15353, 12778, 15179, 3532, 14480, 4255, 14753, 12944, 11278, 14847, 13217, 9499, 3962, 340, 12792, 14921, 1261, 2806, 5611, 2697, 2672, 5175, 5103, 3323, 11557, 12796, 3314, 16015, 1156, 6496, 8125, 14828, 8401, 14846, 12245, 10857, 10667, 16376, 233, 12795, 3881, 8139, 8403, 1684, 8666, 3073, 4217, 12785, 14581, 3366, 11056, 15351, 3556, 2805, 10216, 6746, 3346, 3134, 3958, 1313, 2381, 3027, 3014, 3362, 2626, 15354, 5193, 5124, 12246, 66, 2118, 7683, 4191, 16786, 4981, 151, 12782, 5081, 4182, 1669, 1289, 8358, 6740, 5814, 7744, 8679, 4305, 15471, 11186, 13434, 2394, 4186, 2685, 13429, 10118, 7852, 3955, 2669, 9986, 4221, 6568, 15011, 8404, 2670, 3409, 4878, 14322, 1321, 16787, 5519, 7978, 3364, 4941, 4585, 5188, 8137, 3956, 4307, 7854, 1311, 3322, 8122, 12783, 5757, 3970, 4229, 3017, 4879, 8363, 14737, 3413, 7976, 2819, 3960, 13433, 9988, 4731, 6548, 829, 1347, 3578, 777, 4234, 8158, 5514, 5570, 2393, 734, 1304, 4165, 4587, 3091, 3003, 13216, 16543, 4184, 6567, 2848, 2687, 1692, 14437, 1273, 3316, 6731, 9501, 295, 5111, 6736, 6741, 5688, 6735, 11118, 1305, 1325, 3542, 6382, 1301, 5783, 13418, 1697, 1299, 8157, 12022, 15898, 14624, 8878, 3012, 15131, 11189, 1327, 3334, 2688, 3319, 13432, 3342, 8145, 5178, 14845, 12794, 3953, 4226, 15176, 3534, 2491, 8117, 12033, 1309, 11137, 10364, 6777, 7952, 1316, 3562, 1294, 1315, 2816, 2113, 4602, 3097, 12957, 9549, 1450, 5120, 2480, 5106, 2365, 5163, 1291, 9548, 4216, 4894, 4164, 4220, 3954, 2668, 15197, 7940, 4167, 1453, 956, 1250, 1286, 483, 8360, 4168, 5160, 1296, 1698, 12097, 3705, 2698, 3090, 4232, 3085, 3493, 1348, 12807, 13436, 3335, 2810, 14964, 10049, 3133, 2264, 15350, 3490, 1247, 6930, 6737, 2388, 4169, 4877, 3590, 1471, 3164, 12941, 1318, 16256, 4590, 4589, 8678, 2997, 4615, 2401, 3589, 5121, 2664, 3078, 5748, 6027, 4883, 12043, 5139, 14731, 12784, 5049, 3351, 12031, 5848, 3135, 7564, 3550, 11874, 1339, 7955, 5819, 14961, 226, 3321, 4571, 959, 1461, 14739, 12029, 1448, 2364, 8178, 8160, 13018, 3317, 3539, 1308, 8364, 3551, 13420, 5132, 3528, 491, 11536, 10063, 15126, 4581, 4599, 10051, 9980, 3361, 5122, 3052, 6779, 1407, 3022, 3500, 3482, 1650, 9976, 10057, 6030, 9676, 3313, 4899, 14522, 4086, 4222, 2679, 12943, 3081, 1685, 12956, 3572, 2225, 6576, 2135, 4604, 11105, 15293, 3952, 1349, 8359, 10056, 3608, 1214, 5173, 3552, 4610, 10379, 1673, 3577, 4172, 3592, 3554, 2046, 10059, 844, 10053, 11057, 1312, 10856, 4203, 3350, 12384, 228, 11119, 11287, 989, 3481, 5110, 465, 274, 2366, 4893, 5620, 9087, 1302, 3546, 10046, 3951, 5152, 2116, 2846, 11183, 8131, 2481, 5128, 1240, 3368, 1441, 12040, 3611, 12793, 5123, 14301, 3075, 1351, 152, 1319, 5101, 10054, 3162, 6028, 7714, 15174, 12777, 3096, 11038, 5494, 4240, 4896, 4569, 1307, 8361, 12960, 8934, 4084, 1687, 3522, 54, 2838, 3166, 6374, 4236, 12021, 6373, 4266, 6328, 12019, 3180, 958, 3019, 6091, 3411, 2397, 190, 15006, 14962, 5125, 5102, 1465, 2812, 10293, 1314, 3158, 16094, 836, 4891, 4180, 5140, 2140, 1462, 5503, 4555, 6300, 2137, 4170, 1328, 5483, 6749, 3020, 1310, 11188, 3969, 1463, 7942, 2845, 15909, 3095, 4775, 1303, 3367, 8416, 14337, 5100, 5569, 3168, 14860, 2682, 4601, 1298, 3591, 4223, 4181, 3298, 3495, 4043, 1238, 14963, 225, 4600, 1333, 8176, 3165, 3000, 12958, 5820, 5750, 843, 5151, 1213, 4256, 6301, 10666, 4556, 3358, 11555, 1362, 3369, 2820, 11703, 2908, 4082, 7775, 4885, 3291, 3343, 12036, 3086, 10058, 8508, 10060, 980, 3093, 3443, 1452, 3708, 1104, 13218, 10361, 960, 5112, 5138, 5886, 12045, 3933, 3540, 3486, 3547, 4575, 4886, 3080, 3685, 2839, 8161, 5133, 7943, 4187, 5940, 8152, 2117, 981, 15165, 1243, 5119, 1324, 4897, 3088, 2265, 11187, 5170, 3018, 894, 3948, 1147, 3477, 12776, 3160, 2844, 4188, 5388, 5155, 2352, 6739, 6727, 16458, 7733, 7737, 6928, 6929, 6734, 8931, 1464, 6272, 7731, 6747, 12196, 6738, 11103, 9356, 7736, 11106, 6807, 6790, 6791, 1686, 3491, 3700, 10085, 3483, 8150, 78, 2847, 2483, 3544, 15012, 8121, 13430, 3498, 4083, 3610, 1454, 11069, 4892, 3884, 5565, 3410, 5698, 5134, 13219, 2115, 258, 6574, 2843, 3186, 3025, 5512, 7772, 3487, 15419, 793, 3021, 790, 3331, 372, 954, 5509, 384, 5816, 14740, 3072, 5749, 1237, 2821, 1257, 14754, 1456, 3588, 12023, 13435, 15175, 4231, 3683, 3497, 789, 3937, 9636, 10045, 3359, 8305, 2840, 3348, 3329, 3360, 15125, 1381, 1691, 5411, 3536, 5870, 3015, 5815, 3621, 3002, 74, 8362, 4190, 1275, 3561, 3689, 12028, 4200, 1671, 4257, 4173, 1295, 5871, 4558, 9985, 4730, 5758, 12942, 9989, 1297, 2383, 791, 5129, 4574, 3658, 1672, 8143, 1694, 4557, 4580, 3587, 2303, 227, 5156, 3077, 3005, 3961, 10052, 2803, 5107, 3010, 1287, 7941, 4888, 5753, 12781, 1322, 4177, 12024, 4171, 3613, 2357, 5190, 10047, 1670, 3044, 4577, 3883, 3529, 3533, 3531, 3480, 3076, 10055, 167, 2134, 9555, 3330, 12026, 4241, 15315, 5109, 4233, 9553, 1459, 543, 2683, 2380, 3959, 4183, 3479, 7485, 2814, 2663, 3614, 4592, 2084, 12959, 1148, 4603, 222, 11182, 2832, 4085, 4265, 12805, 8398, 2136, 5126, 3312, 1323, 14738, 8681, 9982, 4890, 3684, 5154, 3392, 3530, 2849, 1645, 1249, 7879, 5108, 1198, 3499, 1474, 3161, 3625, 8177, 17598, 2699, 10618, 2684, 3543, 277, 4553, 945, 4225, 1457, 4597, 10380, 9979, 3541, 7945, 3138, 3553, 10050, 3548, 1320, 955, 15199, 3029, 4185, 3609, 5191, 3333, 5821, 11104, 14371, 3089, 5817, 9987, 10367, 9981, 3612, 1326, 5520, 9099, 10062, 12096, 5508, 3178, 3356, 3023, 5135, 4570, 14844, 3779, 3092, 3187, 4192, 3016, 5162, 8307, 15124, 2999, 4554, 4617, 6298, 1350, 3518, 4562, 984, 1690, 5189, 5510, 982, 983, 4259, 1285, 5158, 4559, 4195, 3935, 3315, 4889, 10369, 4782, 12027, 5812, 4875, 4235, 3177, 5169, 3163, 3349, 9984, 4194, 1460, 1149, 3488, 4954, 4228, 15864, 4189, 3079, 3074, 896, 1678, 3492, 1146, 2808, 4175, 3682, 1469, 4560, 13431, 2842, 12962, 1341, 1668, 11184, 8159, 3485, 6376, 8129, 3167, 3400, 11185, 1682, 4230, 5944, 9544, 9552, 5754, 5942, 2482, 3489, 3405, 8116, 3537, 3882, 14637, 4884, 11116, 4876, 6730, 1695, 6495, 9551, 3053, 4453,
				-- Added in expansion: Burning Crusade (https://www.wowhead.com/mop-classic/npcs?filter=29:39;1:2;0:0)
				18926, 19662, 18018, 16588, 23208, 20240, 16264, 21643, 27722, 21019, 19773, 19038, 21905, 20980, 20097, 20096, 21432, 23489, 19213, 18756, 16388, 23244, 17904, 18525, 16766, 18382, 21655, 27668, 18774, 16442, 23245, 18542, 19383, 17553, 19227, 18772, 23428, 26089, 21906, 23263, 16638, 27721, 24501, 19678, 23437, 18751, 23396, 26123, 27711, 25976, 18266, 18484, 16782, 18011, 23243, 18664, 21485, 20463, 18990, 18749, 25010, 24780, 20080, 18957, 18775, 23112, 19664, 26091, 19011, 16528, 18954, 24934, 23533, 23381, 20916, 25977, 19679, 18802, 18255, 23522, 18267, 17421, 16585, 21474, 19196, 19536, 26398, 25179, 19223, 28225, 16747, 26124, 18993, 20915, 18006, 18278, 16583, 20278, 23010, 23897, 17246, 22212, 23521, 20613, 20616, 26352, 19017, 23525, 19837, 20028, 24510, 16268, 17490, 24396, 16624, 19333, 19561, 16586, 21517, 18250, 26090, 19186, 16262, 17657, 18010, 16824, 22208, 19370, 21183, 21518, 24468, 19575, 19331, 16224, 19182, 25046, 23606, 25035, 22099, 16750, 17518, 23604, 18581, 19932, 27667, 23483, 17512, 19521, 23482, 19617, 27806, 27810, 27818, 20510, 16739, 19056, 21487, 19368, 20494, 16683, 20194, 20092, 25178, 25032, 19197, 19194, 18898, 19531, 20121, 16602, 19470, 22213, 23144, 23484, 16618, 19195, 18773, 23748, 19047, 18243, 19373, 25195, 19015, 19857, 25051, 16751, 19836, 23373, 16706, 19243, 19014, 22266, 22270, 16613, 19321, 21085, 16690, 23571, 18960, 23724, 21172, 16261, 20808, 16366, 25043, 16259, 20890, 19074, 19498, 18672, 24545, 18019, 18984, 23603, 17486, 23896, 18897, 24208, 19043, 19517, 19625, 16705, 23157, 19235, 16185, 16631, 15400, 25196, 18991, 16260, 16713, 16764, 17222, 19540, 17666, 22476, 16917, 16715, 23995, 21488, 18962, 18754, 20377, 18988, 17667, 23710, 21111, 23009, 16757, 16650, 17245, 17655, 28344, 24495, 20081, 21112, 16367, 21084, 27811, 27812, 27813, 27814, 27815, 27816, 27817, 27819, 27820, 23605, 18771, 19499, 19497, 26393, 26394, 18251, 16553, 25036, 18914, 18906, 21746, 16619, 20378, 16709, 20249, 16267, 19351, 19371, 19435, 19530, 19573, 19533, 19534, 19537, 20981, 20989, 19538, 20986, 19535, 19532, 16708, 17101, 18959, 19649, 19352, 19526, 23064, 16722, 16765, 21484, 24843, 25082, 16670, 18951, 21083, 17485, 25177, 19053, 18997, 15292, 16258, 18427, 16657, 18753, 16666, 19518, 21110, 25020, 25012, 24834, 25052, 24993, 25089, 18015, 19572, 19050, 18987, 16257, 23511, 16716, 16753, 23367, 25176, 24408, 18005, 16748, 16444, 17656, 18564, 23143, 19879, 23012, 16823, 19065, 18905, 19296, 18907, 15433, 19232, 17630, 16542, 18908, 19495, 15291, 19539, 16918, 16860, 18911, 25039, 19345, 17896, 20242, 19474, 19049, 16625, 23481, 22491, 23699, 18244, 18277, 17929, 19574, 19339, 16610, 19342, 23573, 21082, 24409, 18929, 27478, 24905, 19042, 24392, 19520, 26395, 19330, 21145, 24974, 17489, 19694, 19476, 19560, 18998, 16635, 19663, 16829, 19239, 24975, 22227, 15397, 16253, 23535, 16620, 19020, 18913, 16641, 18245, 24995, 25019, 18811, 19559, 23011, 20893, 16735, 19722, 16919, 17930, 19021, 19528, 16274, 16767, 16691, 16768, 23110, 22264, 22271, 22468, 23159, 19471, 18347, 23065, 19045, 16732, 27666, 19372, 19479, 16632, 18810, 16263, 17446, 23007, 19562, 17412, 16718, 19450, 23560, 16798, 20241, 19718, 17277, 18009, 18822, 19452, 19451, 18821, 16187, 17585, 19236, 16677, 15289, 16678, 19473, 20250, 27489, 22225, 21744, 21086, 23145, 20892, 16920, 22479, 23363, 19374, 21113, 16191, 20807, 18017, 19240, 25037, 25950, 16656, 15287, 16826, 20891, 23392, 18947, 26092, 19012, 19772, 19436, 19315, 20231, 19314, 19001, 19348, 21483, 18426, 19472, 23510, 17584, 16649, 19244, 25034, 16762, 19343, 16626, 19238, 19013, 16186, 16612, 16714, 24935, 19661, 19245, 19004, 16637, 20112, 16693, 20082, 15494, 19234, 16443, 16611, 16689, 16636, 18752, 16664, 20917, 16623,
				-- Added in expansion: Wrath of the Lich King (https://www.wowhead.com/mop-classic/npcs?filter=29:39;1:3;0:0)
				28715, 32509, 33027, 32538, 40213, 26977, 35507, 35508, 32287, 32216, 30730, 34885, 31032, 35642, 211340, 32382, 37941, 30257, 29548, 35494, 31238, 34881, 28701, 35577, 40160, 27053, 30431, 27088, 37687, 29547, 29716, 27943, 33555, 29688, 28047, 35826, 33963, 30244, 31247, 35132, 33964, 28951, 29537, 32641, 27038, 32360, 29288, 32413, 27176, 32836, 32296, 24347, 24291, 35573, 31580, 35099, 35576, 199387, 27051, 32385, 31910, 28997, 35101, 29538, 27042, 24333, 33637, 27039, 35574, 31582, 35495, 28347, 30472, 29744, 27057, 32774, 25736, 31911, 35578, 33996, 29261, 37997, 30255, 31579, 30885, 32515, 34382, 35498, 211332, 32564, 28742, 27054, 29529, 35497, 27089, 33557, 32514, 30006, 30723, 31865, 24539, 33630, 37999, 30239, 33674, 207128, 29049, 27062, 32381, 39173, 29922, 33307, 37696, 29277, 33553, 32565, 32172, 33018, 29478, 33681, 27140, 37674, 31581, 32642, 32837, 29495, 33675, 28995, 28038, 28512, 33026, 33638, 27056, 30309, 28872, 31916, 33677, 28992, 26596, 28692, 28989, 27022, 25206, 29535, 29203, 30098, 29947, 27031, 28796, 27149, 29275, 29270, 31781, 29948, 37904, 24343, 27011, 33853, 24313, 28827, 32426, 23737, 29740, 33635, 28726, 34252, 30434, 33601, 33644, 32362, 26934, 28943, 33682, 28589, 26938, 32638, 28797, 32415, 26908, 24053, 26484, 34681, 37991, 30069, 29244, 29496, 32356, 32294, 32834, 27058, 32424, 32354, 27940, 27143, 32540, 29510, 32773, 29035, 29714, 29963, 26916, 33636, 31031, 37936, 31805, 27052, 30572, 29527, 26709, 26868, 27181, 28718, 33679, 32763, 33554, 29703, 29037, 32416, 26697, 26229, 26901, 30488, 27146, 38841, 29971, 33684, 31864, 28831, 27760, 25248, 28994, 26567, 28993, 28800, 29512, 26680, 29532, 33866, 28799, 32631, 27193, 26569, 28807, 26474, 28687, 29959, 29628, 28707, 28828, 28990, 33602, 37935, 27137, 27138, 37942, 25314, 32359, 25274, 24066, 30039, 35579, 35580, 28855, 24054, 26382, 33631, 24341, 27125, 23735, 29499, 24149, 27012, 27071, 32355, 30306, 32832, 35344, 30310, 26959, 24033, 33639, 35337, 35338, 35340, 35341, 35342, 35343, 27030, 28811, 29523, 29961, 27065, 31024, 26941, 33599, 28722, 32594, 32379, 27148, 27174, 27187, 27010, 33600, 28806, 29702, 35575, 26936, 29658, 32477, 30345, 30825, 26600, 28832, 32337, 24057, 32533, 28798, 28870, 29205, 28866, 199649, 37688, 30437, 29476, 29923, 34685, 29970, 26720, 29964, 24148, 28869, 29528, 27950, 33669, 27151, 33310, 28728, 33556, 29587, 33683, 27067, 26968, 35131, 28727, 24052, 34645, 28813, 28776, 33633, 33634, 40214, 28790, 33598, 27041, 30253, 27935, 29208, 29715, 23862, 194795, 33594, 31776, 30010, 30346, 29291, 29207, 28057, 31022, 37993, 24356, 32639, 38858, 29014, 29905, 29926, 29636, 30436, 26721, 33640, 29968, 38181, 28760, 27025, 29906, 27037, 26081, 31101, 29962, 30729, 28714, 30731, 30304, 27184, 30067, 30070, 23937, 23731, 28682, 33641, 33657, 25245, 29493, 29252, 38840, 33645, 27066, 24349, 30734, 23908, 33678, 34787, 33871, 29491, 28794, 29253, 28046, 26939, 27185, 30735, 32253, 34684, 29511, 30241, 28812, 28723, 31027, 30727, 28810, 27147, 27141, 27142, 26110, 27139, 33597, 32380, 27070, 26707, 30005, 27032, 24357, 26374, 24067, 33865, 31017, 38283, 30311, 32421, 28040, 30254, 28791, 29945, 39172, 28500, 27045, 35500, 32412, 27069, 27068, 33019, 33596, 33595, 30724, 32420, 26598, 35291, 30489, 27027, 28868, 31863, 28685, 33680, 38182, 29909, 32334, 27144, 28792, 29969, 27186, 27044, 38316, 24330, 28716, 29583, 28725, 24348, 29944, 29908, 27730, 31804, 27267, 26375, 31115, 28830, 34783, 29122, 33650, 27948, 24350, 31025, 27026, 27385, 33653, 34683, 35496, 30336, 29925, 24188, 32403, 27132, 26950, 28829, 30307, 28871, 38054, 30256, 29561, 27133, 27055, 32383, 30732, 29015, 37903, 29494, 27019, 30011, 30439, 32478, 29904, 27134, 29121, 31021, 31051, 23732, 28867, 35290, 26984, 31019, 24141, 30438, 28691, 27182, 37998, 24028, 24147, 27195, 28690, 30733, 33854, 28721, 24342, 33868, 26995, 26900, 27145, 26597, 27188, 33872, 33869, 37992, 26718, 27021, 34087, 27194, 27183, 27043, 27938, 26898, 27190, 31557, 29967, 32419, 30827, 38284, 28991, 34772, 26388, 28809, 27063, 29497, 25278, 26599, 34682, 23802, 29907, 26568, 26945, 33676,
				-- Added in expansion: Cataclysm (https://www.wowhead.com/mop-classic/npcs?filter=29:39;1:4;0:0)
				52809, 52027, 46602, 52036, 47328, 49701, 52358, 46572, 43645, 49884, 49406, 53881, 49387, 241467, 52037, 228668, 45286, 49893, 53882, 225965, 50484, 53436, 234135, 49525, 48617, 53214, 54402, 54401, 50483, 49703, 46556, 56335, 42028, 51502, 50146, 46595, 44245, 45417, 50305, 219980, 55072, 58153, 43565, 40572, 56041, 44346, 50304, 42497, 45298, 51988, 48531, 50324, 52033, 50134, 43418, 44235, 33980, 57983, 42953, 49386, 52914, 43563, 50480, 44252, 44246, 51503, 50488, 36365, 48060, 45489, 48235, 55305, 53757, 45408, 53728, 50307, 52830, 46718, 54232, 41493, 40226, 50314, 52818, 52497, 52028, 52822, 45497, 50433, 52420, 44299, 54659, 55278, 46742, 50309, 42676, 219977, 43972, 50129, 50669, 45553, 40589, 36915, 46555, 49754, 47761, 48858, 48555, 55684, 48510, 51496, 44083, 46358, 44325, 50482, 49788, 48064, 45148, 44236, 49723, 44196, 44417, 52268, 44972, 52031, 54658, 47337, 46995, 44178, 48861, 49409, 41135, 45498, 47856, 48125, 45491, 44027, 49733, 55285, 43424, 50092, 49917, 43997, 47383, 50382, 47267, 50477, 36432, 53528, 40832, 47864, 47166, 43568, 36378, 54654, 218747, 41618, 49433, 52542, 56925, 40815, 47937, 47721, 49702, 50323, 49763, 46659, 42709, 55729, 43964, 48735, 50456, 44177, 44190, 49394, 52092, 43493, 50306, 45551, 43694, 43154, 45558, 49579, 49751, 42332, 50308, 43547, 51512, 44785, 43771, 44186, 40474, 219981, 44286, 48607, 46512, 43495, 51501, 43439, 49707, 45149, 52655, 50045, 42910, 58155, 41053, 50386, 55264, 44280, 52549, 49737, 45086, 52032, 53702, 43768, 45566, 56069, 36375, 53415, 58154, 46994, 44382, 51504, 47942, 37500, 44114, 241468, 50460, 47343, 49756, 53409, 48096, 49410, 228374, 40467, 43021, 44341, 40967, 43408, 47858, 49714, 47719, 40898, 49789, 53641, 39144, 41623, 40968, 47104, 45490, 38978, 44381, 45451, 48057, 44047, 49577, 41890, 45008, 45297, 43708, 43619, 49599, 47717, 43548, 49594, 45789, 43739, 52536, 44192, 49689, 43887, 49800, 36427, 36466, 37762, 49876, 47167, 49605, 47545, 40826, 50457, 49918, 47340, 48058, 47153, 49592, 44283, 47334, 49877, 39884, 39878, 44348, 38714, 49575, 46966, 43988, 47165, 49581, 44001, 43436, 49506, 47756, 48573, 43980, 42966, 36464, 36465, 39063, 43140, 44312, 49785, 49435, 42488, 41274, 44376, 44125, 47106, 48868, 48577, 219976, 44386, 43034, 49920, 45496, 44307, 44385, 49601, 44181, 47532, 53756, 48551, 43998, 48887, 48055, 58036, 50458, 48580, 49805, 50462, 41490, 44334, 44279, 47148, 49695, 44030, 44918, 38561, 43630, 47059, 43899, 45294, 41128, 44183, 43951, 52535, 34624, 33231, 42622, 48552, 44115, 42335, 44123, 43149, 47938, 41341, 49704, 54655, 41275, 53421, 49408, 53760, 43774, 43709, 48574, 41892, 43877, 44191, 41435, 44022, 47338, 44034, 43957, 42876, 49547, 48056, 49887, 44277, 47939, 43705, 47757, 47139, 36717, 44330, 48067, 42909, 49578, 39032, 32979, 49401, 38873, 44354, 43979, 50165, 38847, 57262, 44194, 44182, 47758, 47288, 48885, 48860, 52421, 47712, 34601, 51709, 44179, 45361, 52820, 43880, 52637, 45093, 46702, 48216, 49802, 48856, 43554, 43633, 44006, 43606, 49430, 49688, 44270, 43699, 43946, 43945, 44276, 43624, 49498, 46642, 44391, 48599, 49686, 48215, 43550, 53075, 44780, 48093, 46996, 48884, 43380, 53782, 47164, 50070, 44340, 43748, 48553, 45094, 49549, 51142, 47368, 47863, 49787, 48608, 49554, 42853, 47934, 48356, 49403, 47149, 48095, 48886, 44268, 49803, 49397, 44324, 44377, 48228, 48251, 43646, 47530, 44040, 44310, 49885, 50375, 44297, 52584, 49766, 42911, 52641, 49705, 43711, 43411, 43379, 53780, 52278, 53410, 44019, 49519, 44219, 44267, 43956, 44788, 49919, 44379, 47897, 43617, 41286, 49729, 44237, 45289, 43564, 47105, 49404, 44333, 43405, 36779, 38783, 38853, 43558, 44193, 43637, 43949, 43750, 50126, 49600, 44337, 43710, 45567, 42875, 41891, 50381, 47347, 48587, 43384, 48857, 43555, 46269, 44349, 47764, 48236, 49768, 43955, 44313, 43551, 53076, 49603, 47854, 48581, 43953, 50071, 41054, 44975, 43494, 50069, 44311, 44779, 52658, 49434, 47144, 44187, 45552, 46182, 43948, 45484, 46271, 49775, 40914, 46359, 44397, 44344, 44343, 44300, 44304, 44294, 42967, 44303, 44302, 53991, 47142, 48122, 44285, 49765, 47363, 44383, 49752, 43419, 49726, 52643, 45293, 44301, 43766, 49767, 44339, 42878, 36430, 36467, 37761, 38511, 48054, 43994, 41508, 48853, 36695, 45565, 52588, 44321, 40843, 48123, 46594, 43152, 44970, 49395, 43625, 44007, 43151, 47547, 46184, 49596, 44195, 44398, 44384, 39033, 47345, 48238, 41452, 51495, 43772, 43773, 44336, 43882, 46708, 43425, 49888, 51648, 43155, 41674, 52644, 49593, 48098, 57922, 43770, 44005, 43019, 41903, 44287, 44583, 50172, 43485, 45563, 52034, 33381, 43381, 53781, 44322, 43615, 39031, 43410, 44305, 50094, 50524, 55339, 44296, 50248, 45500, 42626, 41491, 33265, 45290, 53040, 47367, 41675, 48090, 43982, 50459, 41622, 47286, 33209, 45546, 43634, 47860, 228379, 44347, 44335, 48258, 49595, 42972, 41676, 45843, 43139, 52093, 49755, 45549, 55266, 43776,
				-- Added in expansion: Mists of Pandaria (https://www.wowhead.com/mop-classic/npcs?filter=29:39;1:5;0:0)
				63596, 63626, 60977, 57620, 247423, 69333, 69334, 246142, 68402, 248108, 63061, 57623, 57622, 57619, 67185, 65053, 54943, 65052, 65087, 57621, 57618, 57617, 67186,

			}

			-- Event handler
			gossipFrame:SetScript("OnEvent", function()
				-- Special treatment for specific NPCs
				local npcGuid = UnitGUID("npc") or nil -- target does not work with soft targeting
				if npcGuid and not IsShiftKeyDown() then
					local void, void, void, void, void, npcID = strsplit("-", npcGuid)
					if npcID then
						-- Open rogue doors in Dalaran (Broken Isles) automatically
						if npcID == "96782"		-- Lucian Trias
						or npcID == "93188"		-- Mongar
						or npcID == "97004"		-- "Red" Jack Findle
						then
							SkipGossip()
							return
						end
						-- Skip gossip with no alt key requirement
						if npcID == "132969"	-- Katy Stampwhistle (toy)
						or npcID == "104201"	-- Katy Stampwhistle (npc)
						or tContains(npcTable, tonumber(npcID))
						then
							SkipGossip(true) 	-- true means skip alt key requirement
							return
						end
					end
				end
				-- Process gossip
				SkipGossip()
			end)

		end

		----------------------------------------------------------------------
		--	Disable pet automation
		----------------------------------------------------------------------

		if LeaPlusLC["NoPetAutomation"] == "On" and not LeaLockList["NoPetAutomation"] then

			-- Create frame to watch for combat
			local petCombat = CreateFrame("FRAME")
			local petTicker

			-- Function to dismiss pet
			local function DismissPetTimerFunc()
				if UnitAffectingCombat("player") then
					-- Player is in combat so cancel ticker and schedule it for when combat ends
					if petTicker then petTicker:Cancel() end
					petCombat:RegisterEvent("PLAYER_REGEN_ENABLED")
				else
					-- Player is not in combat so attempt to dismiss pet
					local summonedPet = C_PetJournal.GetSummonedPetGUID()
					if summonedPet then
						C_PetJournal.SummonPetByGUID(summonedPet)
					end
				end
			end

			hooksecurefunc(C_PetJournal, "SetPetLoadOutInfo", function()
				-- Cancel existing ticker if one already exists
				if petTicker then petTicker:Cancel() end
				-- Check for combat
				if UnitAffectingCombat("player") then
					-- Player is in combat so schedule ticker for when combat ends
					petCombat:RegisterEvent("PLAYER_REGEN_ENABLED")
				else
					-- Player is not in combat so run ticker now
					petTicker = C_Timer.NewTicker(0.5, DismissPetTimerFunc, 15)
				end
			end)

			-- Script for when combat ends
			petCombat:SetScript("OnEvent", function()
				-- Combat has ended so run ticker now
				petTicker = C_Timer.NewTicker(0.5, DismissPetTimerFunc, 15)
				petCombat:UnregisterEvent("PLAYER_REGEN_ENABLED")
			end)

		end

		----------------------------------------------------------------------
		--	Show pet save button
		----------------------------------------------------------------------

		if LeaPlusLC["ShowPetSaveBtn"] == "On" and not LeaLockList["ShowPetSaveBtn"] then

			EventUtil.ContinueOnAddOnLoaded("Blizzard_Collections",function()

				-- Create panel
				local pFrame = CreateFrame("Frame", nil, PetJournal)
				pFrame:ClearAllPoints()
				pFrame:SetPoint("TOPLEFT", PetJournalLoadoutBorder, "TOPLEFT", 4, 40)
				pFrame:SetSize(PetJournalLoadoutBorder:GetWidth() -10, 16)
				pFrame:Hide()
				pFrame:SetFrameLevel(5000)

				-- Add background color
				pFrame.t = pFrame:CreateTexture(nil, "BACKGROUND")
				pFrame.t:SetAllPoints()
				pFrame.t:SetColorTexture(0.05, 0.05, 0.05, 0.7)

				-- Create editbox
				local petEB = CreateFrame("EditBox", nil, pFrame)
				petEB:SetAllPoints()
				petEB:SetTextInsets(2, 2, 2, 2)
				petEB:SetFontObject("GameFontNormal")
				petEB:SetTextColor(1.0, 1.0, 1.0, 1)
				petEB:SetBlinkSpeed(0)
				petEB:SetAltArrowKeyMode(true)

				-- Prevent changes
				petEB:SetScript("OnEscapePressed", function() pFrame:Hide() end)
				petEB:SetScript("OnEnterPressed", function() petEB:HighlightText() end)
				petEB:SetScript("OnMouseDown", function() petEB:ClearFocus() end)
				petEB:SetScript("OnMouseUp", function() petEB:HighlightText() end)

				-- Create tooltip
				petEB.tiptext = L["This command will assign your current pet team and selected abilities.|n|nPress CTRL/C to copy the command then paste it into a macro or chat window with CTRL/V."]
				petEB:HookScript("OnEnter", function()
					GameTooltip:SetOwner(petEB, "ANCHOR_TOP")
					GameTooltip:SetText(petEB.tiptext, nil, nil, nil, nil, true)
				end)
				petEB:HookScript("OnLeave", GameTooltip_Hide)

				-- Function to get pet data and build macro
				local function RefreshPets()
					-- Get pet data
					local p1, p1a, p1b, p1c = C_PetJournal.GetPetLoadOutInfo(1)
					local p2, p2a, p2b, p2c = C_PetJournal.GetPetLoadOutInfo(2)
					local p3, p3a, p3b, p3c = C_PetJournal.GetPetLoadOutInfo(3)
					if p1 and p1a and p1b and p1c and p2 and p2a and p2b and p2c and p3 and p3a and p3b and p3c then
						-- Build macro string and show it in editbox
						local comTeam = "/ltp team "
						comTeam = comTeam .. p1 .. ',' .. p1a .. ',' .. p1b .. ',' .. p1c .. ","
						comTeam = comTeam .. p2 .. ',' .. p2a .. ',' .. p2b .. ',' .. p2c .. ","
						comTeam = comTeam .. p3 .. ',' .. p3a .. ',' .. p3b .. ',' .. p3c
						petEB:SetText(comTeam)
						petEB:HighlightText()
						petEB:SetFocus()
					end
				end

				-- Prevent changes to editbox value
				petEB:SetScript("OnChar", RefreshPets)
				petEB:SetScript("OnKeyUp", RefreshPets)

				-- Refresh pet data when slots are changed
				hooksecurefunc(C_PetJournal, "SetPetLoadOutInfo", RefreshPets)

				-- Add macro button
				local macroBtn = LeaPlusLC:CreateButton("PetMacroBtn", _G["PetJournalLoadoutPet1"], "", "TOPRIGHT", 0, 0, 32, 32, false, "")
				macroBtn:SetFrameLevel(5000)
				macroBtn:SetNormalTexture("Interface\\BUTTONS\\AdventureGuideMicrobuttonAlert")
				macroBtn:SetScript("OnClick", function()
					if C_PetJournal.GetPetLoadOutInfo(1) and C_PetJournal.GetPetLoadOutInfo(2) and C_PetJournal.GetPetLoadOutInfo(3) then
						if pFrame:IsShown() then
							-- Frame is already showing so hide it
							pFrame:Hide()
						else
							-- Show macro panel
							pFrame:Show()
							RefreshPets()
						end
					else
						LeaPlusLC:Print("You need a battle pet team.")
					end
				end)
				macroBtn:HookScript("OnHide", function() pFrame:Hide() end)

			end)

		end

		----------------------------------------------------------------------
		--	Faster looting
		----------------------------------------------------------------------

		if LeaPlusLC["FasterLooting"] == "On" then

			-- Time delay
			local tDelay = 0

			-- Fast loot function
			local function FastLoot()
				if GetTime() - tDelay >= 0.3 then
					tDelay = GetTime()
					if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
						if TSMDestroyBtn and TSMDestroyBtn:IsShown() and TSMDestroyBtn:GetButtonState() == "DISABLED" then tDelay = GetTime() return end
						local lootMethod = C_PartyInfo.GetLootMethod()
						if lootMethod == 2 then
							-- Master loot is enabled so fast loot if item should be auto looted
							local lootThreshold = GetLootThreshold()
							for i = GetNumLootItems(), 1, -1 do
								local lootIcon, lootName, lootQuantity, currencyID, lootQuality = GetLootSlotInfo(i)
								if lootQuality and lootThreshold and lootQuality < lootThreshold then
									LootSlot(i)
								end
							end
						else
							-- Master loot is disabled so fast loot regardless
							local grouped = IsInGroup()
							for i = GetNumLootItems(), 1, -1 do
								local lootIcon, lootName, lootQuantity, currencyID, lootQuality, locked = GetLootSlotInfo(i)
								local slotType = GetLootSlotType(i)
								if lootName and not locked then
									if not grouped then
										LootSlot(i)
									else
										if lootMethod == 0 then -- Free for all
											if slotType == LOOT_SLOT_ITEM then
												LootSlot(i)
											end
										else
											LootSlot(i)
										end
									end
								end
							end
						end
						tDelay = GetTime()
					end
				end
			end

			-- Event frame
			local faster = CreateFrame("Frame")
			faster:RegisterEvent("LOOT_READY")
			faster:SetScript("OnEvent", FastLoot)

		end

		----------------------------------------------------------------------
		--	Hide event toasts
		----------------------------------------------------------------------

		if LeaPlusLC["HideEventToasts"] == "On" and not LeaLockList["HideEventToasts"] then

			-- Create holder
			local LevelUpDisplayHolder = CreateFrame("Frame", nil, UIParent)

			-- Move LevelUpDisplay
			LevelUpDisplay:ClearAllPoints()
			if not LeaPlusLC.ElvUI then
				LevelUpDisplay:SetPoint("TOP", LevelUpDisplayHolder)
			end

			-- Maintain position of LevelUpDisplay
			hooksecurefunc(LevelUpDisplay, "SetPoint", function(frame, void, anchor)
				if anchor ~= LevelUpDisplayHolder then
					frame:ClearAllPoints()
					if not LeaPlusLC.ElvUI then
						frame:SetPoint("TOP", LevelUpDisplayHolder)
					end
				end
			end)

			-- Force zone text to show while LevelUpDisplay is showing
			ZoneTextFrame:HookScript("OnEvent", function(self, event)
				if LevelUpDisplay:IsShown() then
					if event == "ZONE_CHANGED_NEW_AREA" and not ZoneTextFrame:IsShown() then
						FadingFrame_Show(ZoneTextFrame)
					elseif event == "ZONE_CHANGED_INDOORS" and not SubZoneTextFrame:IsShown() then
						FadingFrame_Show(SubZoneTextFrame)
					end
				end
			end)

		end

		----------------------------------------------------------------------
		--	Disable bag automation
		----------------------------------------------------------------------

		if LeaPlusLC["NoBagAutomation"] == "On" and not LeaLockList["NoBagAutomation"] then
			RunScript("hooksecurefunc('OpenAllBags', CloseAllBags)")
		end

		----------------------------------------------------------------------
		--	Automate quests (no reload required)
		----------------------------------------------------------------------

		do

			-- Create configuration panel
			local QuestPanel = LeaPlusLC:CreatePanel("Automate quests", "QuestPanel")

			LeaPlusLC:MakeTx(QuestPanel, "Settings", 16, -72)
			LeaPlusLC:MakeCB(QuestPanel, "AutoQuestAvailable", "Accept available quests automatically", 16, -92, false, "If checked, available quests will be accepted automatically.")
			LeaPlusLC:MakeCB(QuestPanel, "AutoQuestCompleted", "Turn-in completed quests automatically", 16, -112, false, "If checked, completed quests will be turned-in automatically.")
			LeaPlusLC:MakeCB(QuestPanel, "AutoQuestShift", "Require override key for quest automation", 16, -132, false, "If checked, you will need to hold the override key down for quests to be automated.|n|nIf unchecked, holding the override key will prevent quests from being automated.")

			LeaPlusLC:CreateDropdown("AutoQuestKeyMenu", "Override key", 146, "TOPLEFT", QuestPanel, "TOPLEFT", 356, -92, {{L["SHIFT"], 1}, {L["ALT"], 2}, {L["CONTROL"], 3}, {L["CMD (MAC)"], 4}})

			-- Help button hidden
			QuestPanel.h:Hide()

			-- Back button handler
			QuestPanel.b:SetScript("OnClick", function()
				QuestPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page1"]:Show();
				return
			end)

			-- Reset button handler
			QuestPanel.r:SetScript("OnClick", function()

				-- Reset checkboxes
				LeaPlusLC["AutoQuestShift"] = "Off"
				LeaPlusLC["AutoQuestAvailable"] = "On"
				LeaPlusLC["AutoQuestCompleted"] = "On"
				LeaPlusLC["AutoQuestKeyMenu"] = 1

				-- Refresh panel
				QuestPanel:Hide(); QuestPanel:Show()

			end)

			-- Show panal when options panel button is clicked
			LeaPlusCB["AutomateQuestsBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["AutoQuestShift"] = "Off"
					LeaPlusLC["AutoQuestAvailable"] = "On"
					LeaPlusLC["AutoQuestCompleted"] = "On"
					LeaPlusLC["AutoQuestKeyMenu"] = 1
				else
					QuestPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

			-- Function to determine if override key is being held
			local function IsOverrideKeyDown()
				if LeaPlusLC["AutoQuestKeyMenu"] == 1 and IsShiftKeyDown()
				or LeaPlusLC["AutoQuestKeyMenu"] == 2 and IsAltKeyDown()
				or LeaPlusLC["AutoQuestKeyMenu"] == 3 and IsControlKeyDown()
				or LeaPlusLC["AutoQuestKeyMenu"] == 4 and IsMetaKeyDown()
				then
					return true
				end
			end

			-- Funcion to ignore specific NPCs
			local function isNpcBlocked(actionType)
				local npcGuid = UnitGUID("npc") or nil -- works when cvar SoftTargetInteract set to 3
				if npcGuid then
					local void, void, void, void, void, npcID = strsplit("-", npcGuid)
					if npcID then
						-- Ignore specific NPCs for selecting, accepting and turning-in quests (required if automation has consequences)
						if npcID == "15192"	-- Anachronos (Caverns of Time)
						or npcID == "19935" -- Soridormi (The Scale of Sands, Caverns of Time)
						or npcID == "19936" -- Arazmodu (The Scale of Sands, Caverns of Time)
						or npcID == "3430" 	-- Mangletooth (Blood Shard quests, Barrens)
						or npcID == "14828" -- Gelvas Grimegate (Darkmoon Faire Ticket Redemption, Elwynn Forest and Mulgore)
						or npcID == "14921" -- Rin'wosho the Trader (Zul'Gurub Isle, Stranglethorn Vale)
						or npcID == "18166" -- Khadgar (Allegiance to Aldor/Scryer, Shattrath)
						or npcID == "18253" -- Archmage Leryda (Violet Signet, Karazhan)
						or npcID == "15864" -- Valadar Starsong (Coin of Ancestry Collector, Moonglade)
						or npcID == "15909" -- Fariel Starsong (Coin of Ancestry Collector, Moonglade)
						then
							return true
						end
						-- Same but for specific NPCs with special requirements
						if npcID == "32540" then -- Lillehoff (The Sons of Hodir Quartermaster, The Storm Peaks)
							local name, description, standingID = GetFactionInfoByID(1119)
							if standingID and standingID >= 8 then -- Dont automate quests if exalted
								return true
							end
						end
						-- Ignore specific NPCs for accepting quests only
						if actionType == "Accept" then
							-- Classic escort quests
							if npcID == "467" -- The Defias Traitor (The Defias Brotherhood)
							or npcID == "349" -- Corporal Keeshan (Missing In Action)
							or npcID == "1379" -- Miran (Protecting the Shipment)
							or npcID == "7766" -- Tyrion (The Attack!)
							or npcID == "1978" -- Deathstalker Erland (Escorting Erland)
							or npcID == "7784" -- Homing Robot OOX-17/TN (Rescue OOX-17/TN!)
							or npcID == "2713" -- Kinelory (Hints of a New Plague?)
							or npcID == "2768" -- Professor Phizzlethorpe (Sunken Treasure)
							or npcID == "2610" -- Shakes O'Breen (Death From Below)
							or npcID == "2917" -- Prospector Remtravel (The Absent Minded Prospector)
							or npcID == "7806" -- Homing Robot OOX-09/HL (Rescue OOX-09/HL!)
							or npcID == "3439" -- Wizzlecrank's Shredder (The Escape)
							or npcID == "3465" -- Gilthares Firebough (Free From the Hold)
							or npcID == "3568" -- Mist (Mist)
							or npcID == "3584" -- Therylune (Therylune's Escape)
							or npcID == "4484" -- Feero Ironhand (Supplies to Auberdine)
							or npcID == "3692" -- Volcor (Escape Through Force)
							or npcID == "4508" -- Willix the Importer (Willix the Importer)
							or npcID == "4880" -- "Stinky" Ignatz (Stinky's Escape)
							or npcID == "4983" -- Ogron (Questioning Reethe)
							or npcID == "5391" -- Galen Goodward (Galen's Escape)
							or npcID == "5644" -- Dalinda Malem (Return to Vahlarriel)
							or npcID == "5955" -- Tooga (Tooga's Quest)
							or npcID == "7780" -- Rin'ji (Rin'ji is Trapped!)
							or npcID == "7807" -- Homing Robot OOX-22/FE (Rescue OOX-22/FE!)
							or npcID == "7774" -- Shay Leafrunner (Wandering Shay)
							or npcID == "7850" -- Kernobee (A Fine Mess)
							or npcID == "8284" -- Dorius Stonetender (Suntara Stones)
							or npcID == "8380" -- Captain Vanessa Beltis (A Crew Under Fire)
							or npcID == "8516" -- Belnistrasz (Extinguishing the Idol)
							or npcID == "9020" -- Commander Gor'shak (What Is Going On?)
							or npcID == "9520" -- Grark Lorkrub (Precarious Predicament)
							or npcID == "9623" -- A-Me 01 (Chasing A-Me 01)
							or npcID == "9598" -- Arei (Ancient Spirit)
							or npcID == "9023" -- Marshal Windsor (Jail Break!)
							or npcID == "9999" -- Ringo (A Little Help From My Friends)
							or npcID == "10427" -- Pao'ka Swiftmountain (Homeward Bound)
							or npcID == "10300" -- Ranshalla (Guardians of the Altar)
							or npcID == "10646" -- Lakota Windsong (Free at Last)
							or npcID == "10638" -- Kanati Greycloud (Protect Kanati Greycloud)
							or npcID == "11016" -- Captured Arko'narin (Rescue From Jaedenar)
							or npcID == "11218" -- Kerlonian Evershade (The Sleeper Has Awakened)
							or npcID == "11711" -- Sentinel Aynasha (One Shot. One Kill.)
							or npcID == "11625" -- Cork Gizelton (Bodyguard for Hire)
							or npcID == "11626" -- Rigger Gizelton (Gizelton Caravan)
							or npcID == "1842" -- Highlord Taelan Fordring (In Dreams)
							or npcID == "12277" -- Melizza Brimbuzzle (Get Me Out of Here!)
							or npcID == "12580" -- Reginald Windsor (The Great Masquerade)
							or npcID == "12818" -- Ruul Snowhoof (Freedom to Ruul)
							or npcID == "11856" -- Kaya Flathoof (Protect Kaya)
							or npcID == "12858" -- Torek (Torek's Assault)
							or npcID == "12717" -- Muglash (Vorsha the Lasher)
							or npcID == "13716" -- Celebras the Redeemed (The Scepter of Celebras)
							or npcID == "19401" -- Wing Commander Brack (Return to the Abyssal Shelf) (Horde)
							or npcID == "20235" -- Gryphoneer Windbellow (Return to the Abyssal Shelf) (Alliance)
							-- BCC escort quests
							or npcID == "16295" -- Ranger Lilatha (Escape from the Catacombs)
							or npcID == "17238" -- Anchorite Truuen (Tomb of the Lightbringer)
							or npcID == "17312" -- Magwin (A Cry For Help)
							or npcID == "17877" -- Fhwoor (Fhwoor Smash!)
							or npcID == "17969" -- Kayra Longmane (Escape from Umbrafen)
							or npcID == "18210" -- Mag'har Captive (The Totem of Kar'dash, Horde)
							or npcID == "18209" -- Kurenai Captive (The Totem of Kar'dash, Alliance)
							or npcID == "18760" -- Isla Starmane (Escape from Firewing Point!)
							or npcID == "19589" -- Maxx A. Million Mk. V (Mark V is Alive!)
							or npcID == "19671" -- Cryo-Engineer Sha'heen (Someone Else's Hard Work Pays Off)
							or npcID == "20281" -- Drijya (Sabotage the Warp-Gate!)
							or npcID == "20415" -- Bessy (When the Cows Come Home)
							or npcID == "20482" -- Image of Commander Ameer (Delivering the Message)
							or npcID == "20763" -- Captured Protectorate Vanguard (Escape from the Staging Grounds)
							or npcID == "21027" -- Earthmender Wilda (Escape from Coilskar Cistern)
							or npcID == "22424" -- Skywing (Skywing)
							or npcID == "22458" -- Chief Archaeologist Letoll (Digging Through Bones)
							or npcID == "23383" -- Skyguard Prisoner (Escape from Skettis)
							then
								return true
							end
						end
						-- Ignore specific NPCs for selecting quests only (only used for items that have no other purpose)
						if actionType == "Select" then
							if npcID == "12944" -- Lokhtos Darkbargainer (Thorium Brotherhood, Blackrock Depths)
							or npcID == "19401" -- Wing Commander Brack (Return to the Abyssal Shelf) (Horde)
							or npcID == "20235" -- Gryphoneer Windbellow (Return to the Abyssal Shelf) (Alliance)
							or npcID == "10307" -- Witch Doctor Mau'ari (E'Ko quests, Winterspring)
							-- Ahn'Qiraj War Effort (Alliance, Ironforge)
							or npcID == "15446" -- Bonnie Stoneflayer (Light Leather Collector)
							or npcID == "15458" -- Commander Stronghammer (Alliance Ambassador)
							or npcID == "15431" -- Corporal Carnes (Iron Bar Collector)
							or npcID == "15432" -- Dame Twinbraid (Thorium Bar Collector)
							or npcID == "15453" -- Keeper Moonshade (Runecloth Bandage Collector)
							or npcID == "15457" -- Huntress Swiftriver (Spotted Yellowtail Collector)
							or npcID == "15450" -- Marta Finespindle (Thick Leather Collector)
							or npcID == "15437" -- Master Nightsong (Purple Lotus Collector)
							or npcID == "15452" -- Nurse Stonefield (Silk Bandage Collector)
							or npcID == "15434" -- Private Draxlegauge (Stranglekelp Collector)
							or npcID == "15448" -- Private Porter (Medium Leather Collector)
							or npcID == "15456" -- Sarah Sadwhistle (Roast Raptor Collector)
							or npcID == "15451" -- Sentinel Silversky (Linen Bandage Collector)
							or npcID == "15445" -- Sergeant Major Germaine (Arthas' Tears Collector)
							or npcID == "15383" -- Sergeant Stonebrow (Copper Bar Collector)
							or npcID == "15455" -- Slicky Gastronome (Rainbow Fin Albacore Collector)
							-- Ahn'Qiraj War Effort (Horde, Orgrimmar)
							or npcID == "15512" -- Apothecary Jezel (Purple Lotus Collector)
							or npcID == "15508" -- Batrider Pele'keiki (Firebloom Collector)
							or npcID == "15533" -- Bloodguard Rawtar (Lean Wolf Steak Collector)
							or npcID == "15535" -- Chief Sharpclaw (Baked Salmon Collector)
							or npcID == "15525" -- Doctor Serratus (Rugged Leather Collector)
							or npcID == "15534" -- Fisherman Lin'do (Spotted Yellowtail Collector)
							or npcID == "15539" -- General Zog (Horde Ambassador)
							or npcID == "15460" -- Grunt Maug (Tin Bar Collector)
							or npcID == "15528" -- Healer Longrunner (Wool Bandage Collector)
							or npcID == "15477" -- Herbalist Proudfeather (Peacebloom Collector)
							or npcID == "15529" -- Lady Callow (Mageweave Bandage Collector)
							or npcID == "15459" -- Miner Cromwell (Copper Bar Collector)
							or npcID == "15469" -- Senior Sergeant T'kelah (Mithril Bar Collector)
							or npcID == "15522" -- Sergeant Umala (Thick Leather Collector)
							or npcID == "15515" -- Skinner Jamani (Heavy Leather Collector)
							or npcID == "15532" -- Stoneguard Clayhoof (Runecloth Bandage Collector)
							-- Alliance Commendations
							or npcID == "15764" -- Officer Ironbeard (Ironforge Commendations)
							or npcID == "15762" -- Officer Lunalight (Darnassus Commendations)
							or npcID == "15766" -- Officer Maloof (Stormwind Commendations)
							or npcID == "15763" -- Officer Porterhouse (Gnomeregan Commendations)
							-- Horde Commendations
							or npcID == "15768" -- Officer Gothena (Undercity Commendations)
							or npcID == "15765" -- Officer Redblade (Orgrimmar Commendations)
							or npcID == "15767" -- Officer Thunderstrider (Thunder Bluff Commendations)
							or npcID == "15761" -- Officer Vu'Shalay (Darkspear Commendations)
							-- Battlegrounds (Alliance)
							or npcID == "13442" -- Arch Druid Renferal (Storm Crystal, Alterac Valley)
							-- Battlegrounds (Horde)
							or npcID == "13236" -- Primalist Thurloga (Stormpike Soldier's Blood, Alterac Valley)
							-- Scourgestones
							or npcID == "11039" -- Duke Nicholas Zverenhoff (Eastern Plaguelands)
							-- Un'Goro crystals
							or npcID == "9117" 	-- J. D. Collie (Un'Goro Crater)
							then
								return true
							end
						end
					end
				end
			end

			-- Function to check if quest requires a blocked item
			local function QuestRequiresBlockedItem()
				for i = 1, 6 do
					local progItem = _G["QuestProgressItem" ..i] or nil
					if progItem and progItem:IsShown() and progItem.type == "required" then
						if progItem.objectType == "item" then
							local name, texture, numItems = GetQuestItemInfo("required", i)
							if name then
								local itemID = C_Item.GetItemInfoInstant(name)
								if itemID then
									if itemID == 9999999999 then -- Reserved for future use
										return true
									end
								end
							end
						end
					end
				end
			end

			-- Function to check if quest requires gold
			local function QuestRequiresGold()
				local goldRequiredAmount = GetQuestMoneyToGet()
				if goldRequiredAmount and goldRequiredAmount > 0 then
					return true
				end
			end

			-- Function to check if quest title has requirements met
			local function DoesQuestHaveRequirementsMet(title)
				if title and title ~= "" then

					if not title then

					-- Battlemasters
					elseif title == L["Concerted Efforts"] or title == L["For Great Honor"] then
						-- Requires 3 Alterac Valley Mark of Honor, 3 Arathi Basin Mark of Honor, 3 Warsong Gulch Mark of Honor (must be before other Mark of Honor quests)
						if C_Item.GetItemCount(20560) >= 3 and C_Item.GetItemCount(20559) >= 3 and C_Item.GetItemCount(20558) >= 3 then return true end
					elseif title == L["Remember Alterac Valley!"] or title == L["Invaders of Alterac Valley"] then
						-- Requires 3 Alterac Valley Mark of Honor
						if C_Item.GetItemCount(20560) >= 3 then return true end
					elseif title == L["Claiming Arathi Basin"] or title == L["Conquering Arathi Basin"] then
						-- Requires 3 Arathi Basin Mark of Honor
						if C_Item.GetItemCount(20559) >= 3 then return true end
					elseif title == L["Fight for Warsong Gulch"] or title == L["Battle of Warsong Gulch"] then
						-- Requires 3 Warsong Gulch Mark of Honor
						if C_Item.GetItemCount(20558) >= 3 then return true end

					-- Cloth quartermasters
					elseif title == L["A Donation of Wool"] then
						-- Requires 60 Wool Cloth
						if C_Item.GetItemCount(2592) >= 60 then return true end
					elseif title == L["A Donation of Silk"] then
						-- Requires 60 Silk Cloth
						if C_Item.GetItemCount(4306) >= 60 then return true end
					elseif title == L["A Donation of Mageweave"] then
						-- Requires 60 Mageweave
						if C_Item.GetItemCount(4338) >= 60 then return true end
					elseif title == L["A Donation of Runecloth"] then
						-- Requires 60 Runecloth
						if C_Item.GetItemCount(14047) >= 60 then return true end
					elseif title == L["Additional Runecloth"] then
						-- Requires 20 Runecloth
						if C_Item.GetItemCount(14047) >= 20 then return true end
					elseif title == L["Gurubashi, Vilebranch, and Witherbark Coins"] then
						-- Requires 1 Gurubashi Coin, 1 Vilebranch Coin, 1 Witherbark Coin
						if C_Item.GetItemCount(19701) >= 1 and C_Item.GetItemCount(19702) >= 1 and C_Item.GetItemCount(19703) >= 1 then return true end
					elseif title == L["Sandfury, Skullsplitter, and Bloodscalp Coins"] then
						-- Requires 1 Sandfury Coin, 1 Skullsplitter Coin, 1 Bloodscalp Coin
						if C_Item.GetItemCount(19704) >= 1 and C_Item.GetItemCount(19705) >= 1 and C_Item.GetItemCount(19706) >= 1 then return true end
					elseif title == L["Zulian, Razzashi, and Hakkari Coins"] then
						-- Requires 1 Zulian Coin, 1 Razzashi Coin, 1 Hakkari Coin
						if C_Item.GetItemCount(19698) >= 1 and C_Item.GetItemCount(19699) >= 1 and C_Item.GetItemCount(19700) >= 1 then return true end
					elseif title == L["Frostsaber E'ko"] then
						-- Requires 3 Frostsaber E'ko
						if C_Item.GetItemCount(12430) >= 3 then return true end
					elseif title == L["Winterfall E'ko"] then
						-- Requires 3 Winterfall E'ko
						if C_Item.GetItemCount(12431) >= 3 then return true end
					elseif title == L["Shardtooth E'ko"] then
						-- Requires 3 Shardtooth E'ko
						if C_Item.GetItemCount(12432) >= 3 then return true end
					elseif title == L["Wildkin E'ko"] then
						-- Requires 3 Wildkin E'ko
						if C_Item.GetItemCount(12433) >= 3 then return true end
					elseif title == L["Chillwind E'ko"] then
						-- Requires 3 Chillwind E'ko
						if C_Item.GetItemCount(12434) >= 3 then return true end
					elseif title == L["Ice Thistle E'ko"] then
						-- Requires 3 Ice Thistle E'ko
						if C_Item.GetItemCount(12435) >= 3 then return true end
					elseif title == L["Frostmaul E'ko"] then
						-- Requires 3 Ice Thistle E'ko
						if C_Item.GetItemCount(12436) >= 3 then return true end
					elseif title == L["Marks of Kil'jaeden"] or title == L["More Marks of Kil'jaeden"] then
						-- Requires 10 More Marks of Kil'jaeden
						if C_Item.GetItemCount(29425) >= 10 then return true end
					elseif title == L["Single Mark of Sargeras"] then
						-- Requires 1 Marks of Sargeras (if more than 10, leave for More Marks of Sargeras)
						if C_Item.GetItemCount(30809) >= 1 and C_Item.GetItemCount(30809) < 10 then return true end
					elseif title == L["More Marks of Sargeras"] then
						-- Requires 10 Marks of Sargeras
						if C_Item.GetItemCount(30809) >= 10 then return true end
					elseif title == L["Firewing Signets"] or title == L["More Firewing Signets"] then
						-- Requires 10 Firewing Signets
						if C_Item.GetItemCount(29426) >= 10 then return true end
					elseif title == L["Single Sunfury Signet"] then
						-- Requires 1 Sunfury Signet (if more than 10, leave for More Sunfury Signets)
						if C_Item.GetItemCount(30810) >= 1 and C_Item.GetItemCount(30810) < 10 then return true end
					elseif title == L["More Sunfury Signets"] then
						-- Requires 10 Sunfury Signets
						if C_Item.GetItemCount(30810) >= 10 then return true end

					-- Darkmoon Faire (Rinling)
					elseif title == L["Copper Modulator"] then
						if C_Item.GetItemCount(4363) >= 5 then return true end
					elseif title == L["Whirring Bronze Gizmo"] then
						if C_Item.GetItemCount(4375) >= 7 then return true end
					elseif title == L["Green Fireworks"] then
						if C_Item.GetItemCount(9313) >= 36 then return true end
					elseif title == L["Mechanical Repair Kits"] then
						if C_Item.GetItemCount(11590) >= 6 then return true end
					elseif title == L["Thorium Widget"] then
						if C_Item.GetItemCount(15994) >= 6 then return true end
					elseif title == L["More Thorium Widgets"] then
						if C_Item.GetItemCount(15994) >= 6 then return true end

					-- Darkmoon Faire (Yebb Neblegear)
					elseif title == L["Small Furry Paws"] then
						if C_Item.GetItemCount(5134) >= 5 then return true end
					elseif title == L["Evil Bat Eyes"] then
						if C_Item.GetItemCount(11404) >= 10 then return true end
					elseif title == L["Glowing Scorpid Blood"] then
						if C_Item.GetItemCount(19933) >= 10 then return true end
					elseif title == L["More Bat Eyes"] then
						if C_Item.GetItemCount(11404) >= 10 then return true end
					elseif title == L["More Glowing Scorpid Blood"] then
						if C_Item.GetItemCount(19933) >= 10 then return true end
					elseif title == L["Soft Bushy Tails"] then
						if C_Item.GetItemCount(4582) >= 5 then return true end
					elseif title == L["Torn Bear Pelts"] then
						if C_Item.GetItemCount(11407) >= 5 then return true end
					elseif title == L["Vibrant Plumes"] then
						if C_Item.GetItemCount(5117) >= 5 then return true end

					-- Darkmoon Faire (Chronos)
					elseif title == L["Armor Kits"] then
						if C_Item.GetItemCount(15564) >= 8 then return true end
					elseif title == L["Carnival Boots"] then
						if C_Item.GetItemCount(2309) >= 3 then return true end
					elseif title == L["Carnival Jerkins"] then
						if C_Item.GetItemCount(2314) >= 3 then return true end
					elseif title == L["Crocolisk Boy and the Bearded Murloc"] then
						if C_Item.GetItemCount(8185) >= 1 then return true end
					elseif title == L["More Armor Kits"] then
						if C_Item.GetItemCount(15564) >= 8 then return true end
					elseif title == L["The World's Largest Gnome!"] then
						if C_Item.GetItemCount(5739) >= 3 then return true end

					-- Darkmoon Faire (Kerri Hicks)
					elseif title == L["Big Black Mace"] then
						if C_Item.GetItemCount(7945) >= 1 then return true end
					elseif title == L["Coarse Weightstone"] then
						if C_Item.GetItemCount(3240) >= 10 then return true end
					elseif title == L["Green Iron Bracers"] then
						if C_Item.GetItemCount(3835) >= 3 then return true end
					elseif title == L["Heavy Grinding Stone"] then
						if C_Item.GetItemCount(3486) >= 7 then return true end
					elseif title == L["More Dense Grinding Stones"] then
						if C_Item.GetItemCount(12644) >= 8 then return true end
					elseif title == L["Rituals of Strength"] then
						if C_Item.GetItemCount(12644) >= 8 then return true end

					else return true
					end
				end
			end

			-- Create event frame
			local qFrame = CreateFrame("FRAME")

			-- Function to setup events
			local function SetupEvents()
				if LeaPlusLC["AutomateQuests"] == "On" then
					qFrame:RegisterEvent("QUEST_DETAIL")
					qFrame:RegisterEvent("QUEST_ACCEPT_CONFIRM")
					qFrame:RegisterEvent("QUEST_PROGRESS")
					qFrame:RegisterEvent("QUEST_COMPLETE")
					qFrame:RegisterEvent("QUEST_GREETING")
					qFrame:RegisterEvent("QUEST_AUTOCOMPLETE")
					qFrame:RegisterEvent("GOSSIP_SHOW")
					qFrame:RegisterEvent("QUEST_FINISHED")
				else
					qFrame:UnregisterAllEvents()
				end
			end

			-- Setup events when option is clicked and on startup (if option is enabled)
			LeaPlusCB["AutomateQuests"]:HookScript("OnClick", SetupEvents)
			if LeaPlusLC["AutomateQuests"] == "On" then SetupEvents() end

			-- Event handler
			qFrame:SetScript("OnEvent", function(self, event, arg1)

				-- Block shared quests if option is enabled
				if event == "QUEST_DETAIL" then
					LeaPlusLC:CheckIfQuestIsSharedAndShouldBeDeclined()
				end

				-- Clear progress items when quest interaction has ceased
				if event == "QUEST_FINISHED" then
					for i = 1, 6 do
						local progItem = _G["QuestProgressItem" ..i] or nil
						if progItem and progItem:IsShown() then
							progItem:Hide()
						end
					end
					return
				end

				-- Check for SHIFT key modifier
				if LeaPlusLC["AutoQuestShift"] == "On" and not IsOverrideKeyDown() then return
				elseif LeaPlusLC["AutoQuestShift"] == "Off" and IsOverrideKeyDown() then return
				end

				----------------------------------------------------------------------
				-- Accept quests automatically
				----------------------------------------------------------------------

				-- Accept quests with a quest detail window
				if event == "QUEST_DETAIL" then
					if LeaPlusLC["AutoQuestAvailable"] == "On" then
						-- Don't accept blocked quests
						if isNpcBlocked("Accept") then return end
						-- Accept quest
						AcceptQuest()
					end
				end

				-- Accept quests which require confirmation (such as sharing escort quests)
				if event == "QUEST_ACCEPT_CONFIRM" then
					if LeaPlusLC["AutoQuestAvailable"] == "On" then
						ConfirmAcceptQuest()
						StaticPopup_Hide("QUEST_ACCEPT")
					end
				end

				----------------------------------------------------------------------
				-- Turn-in quests automatically
				----------------------------------------------------------------------

				-- Turn-in progression quests
				if event == "QUEST_PROGRESS" and IsQuestCompletable() then
					if LeaPlusLC["AutoQuestCompleted"] == "On" then
						-- Don't continue quests for blocked NPCs
						if isNpcBlocked("Complete") then return end
						-- Don't continue if quest requires blocked item
						if QuestRequiresBlockedItem() then return end
						-- Don't continue if quest requires gold
						if QuestRequiresGold() then return end
						-- Continue quest
						CompleteQuest()
					end
				end

				-- Turn in completed quests if only one reward item is being offered
				if event == "QUEST_COMPLETE" then
					if LeaPlusLC["AutoQuestCompleted"] == "On" then
						-- Don't complete quests for blocked NPCs
						if isNpcBlocked("Complete") then return end
						-- Don't complete if quest requires blocked item
						if QuestRequiresBlockedItem() then return end
						-- Don't complete if quest requires gold
						if QuestRequiresGold() then return end
						-- Complete quest
						if GetNumQuestChoices() <= 1 then
							GetQuestReward(GetNumQuestChoices())
						end
					end
				end

				-- Show quest dialog for quests that use the objective tracker (it will be completed automatically)
				if event == "QUEST_AUTOCOMPLETE" then
					if LeaPlusLC["AutoQuestCompleted"] == "On" then
						local index = GetQuestLogIndexByID(arg1)
						if GetQuestLogIsAutoComplete(index) then
							ShowQuestComplete(index)
						end
					end
				end

				----------------------------------------------------------------------
				-- Select quests automatically
				----------------------------------------------------------------------

				if event == "GOSSIP_SHOW" or event == "QUEST_GREETING" then

					-- Select quests
					if UnitExists("npc") or QuestFrameGreetingPanel:IsShown() or GossipFrame.GreetingPanel:IsShown() then

						-- Don't select quests for blocked NPCs
						if isNpcBlocked("Select") then return end

						if event == "QUEST_GREETING" then
							-- Select quest greeting completed quests
							if LeaPlusLC["AutoQuestCompleted"] == "On" then
								for i = 1, GetNumActiveQuests() do
									local title, isComplete = GetActiveTitle(i)
									if title and isComplete then
										return SelectActiveQuest(i)
									end
								end
							end
							-- Select quest greeting available quests
							if LeaPlusLC["AutoQuestAvailable"] == "On" then
								for i = 1, GetNumAvailableQuests() do
									local title, isComplete = GetAvailableTitle(i)
									if title and not isComplete then
										return SelectAvailableQuest(i)
									end
								end
							end
						else
							-- Select gossip completed quests
							if LeaPlusLC["AutoQuestCompleted"] == "On" then
								local gossipQuests = C_GossipInfo.GetActiveQuests()
								for titleIndex, questInfo in ipairs(gossipQuests) do
									if questInfo.title and questInfo.isComplete then
										if questInfo.questID then
											return C_GossipInfo.SelectActiveQuest(questInfo.questID)
										end
									end
								end
							end
							-- Select gossip available quests
							if LeaPlusLC["AutoQuestAvailable"] == "On" then
								local GossipQuests = C_GossipInfo.GetAvailableQuests()
								for titleIndex, questInfo in ipairs(GossipQuests) do
									if questInfo.questID and DoesQuestHaveRequirementsMet(questInfo.questID) then
										return C_GossipInfo.SelectAvailableQuest(questInfo.questID)
									end
								end
							end
						end
					end
				end

			end)

		end

		----------------------------------------------------------------------
		--	Sort game options addon list
		----------------------------------------------------------------------

		if LeaPlusLC["CharAddonList"] == "On" then
			-- Set the addon list to character by default
			hooksecurefunc(AddonList.Dropdown, "SetupMenu", function(self)
				local nextRadio
				MenuUtil.TraverseMenu(self:GetMenuDescription(), function(description)
					nextRadio = description
				end)
				self:Pick(nextRadio, MenuInputContext.MouseWheel)
			end)
		end

		----------------------------------------------------------------------
		--	Sell junk automatically (no reload required)
		----------------------------------------------------------------------

		do

			-- Create sell junk banner
			local StartMsg = CreateFrame("FRAME", nil, MerchantFrame)
			StartMsg:ClearAllPoints()
			StartMsg:SetPoint("BOTTOMLEFT", 4, 4)
			StartMsg:SetSize(160, 22)
			StartMsg:SetToplevel(true)
			StartMsg:Hide()

			StartMsg.s = StartMsg:CreateTexture(nil, "BACKGROUND")
			StartMsg.s:SetAllPoints()
			StartMsg.s:SetColorTexture(0.1, 0.1, 0.1, 1.0)

			StartMsg.f = StartMsg:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			StartMsg.f:SetAllPoints();
			StartMsg.f:SetText(L["SELLING JUNK"])

			-- Declarations
			local IterationCount, totalPrice = 500, 0
			local SellJunkTicker

			-- Create custom NewTicker function (from Wrath)
			local function LeaPlusNewTicker(duration, callback, iterations)
				local ticker = setmetatable({}, TickerMetatable)
				ticker._remainingIterations = iterations
				ticker._callback = function()
					if (not ticker._cancelled) then
						callback(ticker)
						--Make sure we weren't cancelled during the callback
						if (not ticker._cancelled) then
							if (ticker._remainingIterations) then
								ticker._remainingIterations = ticker._remainingIterations - 1
							end
							if (not ticker._remainingIterations or ticker._remainingIterations > 0) then
								C_Timer.After(duration, ticker._callback)
							end
						end
					end
				end
				C_Timer.After(duration, ticker._callback)
				return ticker
			end



			-- Create configuration panel
			local SellJunkFrame = LeaPlusLC:CreatePanel("Sell junk automatically", "SellJunkFrame")
			LeaPlusLC:MakeTx(SellJunkFrame, "Settings", 16, -72)
			LeaPlusLC:MakeCB(SellJunkFrame, "AutoSellShowSummary", "Show vendor summary in chat", 16, -92, false, "If checked, a vendor summary will be shown in chat when junk is automatically sold.")

			-- Help button hidden
			SellJunkFrame.h:Hide()

			-- Back button handler
			SellJunkFrame.b:SetScript("OnClick", function()
				SellJunkFrame:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page1"]:Show();
				return
			end)

			-- Reset button handler
			SellJunkFrame.r.tiptext = SellJunkFrame.r.tiptext .. "|n|n" .. L["Note that this will not reset your exclusions list."]
			SellJunkFrame.r:SetScript("OnClick", function()

				-- Reset checkboxes
				LeaPlusLC["AutoSellShowSummary"] = "On"

				-- Refresh panel
				SellJunkFrame:Hide(); SellJunkFrame:Show()

			end)

			-- Show panal when options panel button is clicked
			LeaPlusCB["AutoSellJunkBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["AutoSellShowSummary"] = "On"
				else
					SellJunkFrame:Show()
					LeaPlusLC:HideFrames()
				end
			end)

			-- Function to stop selling
			local function StopSelling()
				if SellJunkTicker then SellJunkTicker._cancelled = true; end
				StartMsg:Hide()
				SellJunkFrame:UnregisterEvent("ITEM_LOCKED")
				SellJunkFrame:UnregisterEvent("UI_ERROR_MESSAGE")
			end

			-- Create excluded box
			local titleTX = LeaPlusLC:MakeTx(SellJunkFrame, "Exclusions", 356, -72)
			titleTX:SetWidth(200)
			titleTX:SetWordWrap(false)
			titleTX:SetJustifyH("LEFT")

			-- Show help button for exclusions
			LeaPlusLC:CreateHelpButton("SellJunkExcludeHelpButton", SellJunkFrame, titleTX, "Enter item IDs separated by commas.  Item IDs can be found in item tooltips while this panel is showing.|n|nJunk items entered here will not be sold automatically.|n|nWhite items entered here will be sold automatically.|n|nThe editbox tooltip will show you more information about the items you have entered.")

			local eb = CreateFrame("Frame", nil, SellJunkFrame, "BackdropTemplate")
			eb:SetSize(200, LeaPlusLC.MainPanelHeight - 180)
			eb:SetPoint("TOPLEFT", 350, -92)
			eb:SetBackdrop({
				bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
				edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight",
				edgeSize = 16,
				insets = {left = 8, right = 6, top = 8, bottom = 8},
			})
			eb:SetBackdropBorderColor(1.0, 0.85, 0.0, 0.5)

			eb.scroll = CreateFrame("ScrollFrame", nil, eb, "LeaPlusSellJunkScrollFrameTemplate")
			eb.scroll:SetPoint("TOPLEFT", eb, 12, -10)
			eb.scroll:SetPoint("BOTTOMRIGHT", eb, -30, 10)
			eb.scroll:SetPanExtent(16)

			-- Create character count
			eb.scroll.CharCount = eb.scroll:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			eb.scroll.CharCount:Hide()

			eb.Text = eb.scroll.EditBox
			eb.Text:SetWidth(150)
			eb.Text:SetPoint("TOPLEFT", eb.scroll)
			eb.Text:SetPoint("BOTTOMRIGHT", eb.scroll, -12, 0)
			eb.Text:SetMaxLetters(2000)
			eb.Text:SetFontObject(GameFontNormalLarge)
			eb.Text:SetAutoFocus(false)
			eb.scroll:SetScrollChild(eb.Text)

			-- Set focus on the editbox text when clicking the editbox
			eb:SetScript("OnMouseDown", function()
				eb.Text:SetFocus()
				eb.Text:SetCursorPosition(eb.Text:GetMaxLetters())
			end)

			-- Function to create whitelist
			local whiteList = {}
			local function UpdateWhiteList()
				wipe(whiteList)

				local whiteString = eb.Text:GetText()
				if whiteString and whiteString ~= "" then
					whiteString = whiteString:gsub("[^,%d]", "")
					local tList = {strsplit(",", whiteString)}
					for i = 1, #tList do
						if tList[i] then
							tList[i] = tonumber(tList[i])
							if tList[i] then
								whiteList[tList[i]] = true
							end
						end
					end
				end

				LeaPlusLC["AutoSellExcludeList"] = whiteString
				eb.Text:SetText(LeaPlusLC["AutoSellExcludeList"])

			end

			-- Save the excluded list when it changes and at startup
			eb.Text:SetScript("OnTextChanged", UpdateWhiteList)
			eb.Text:SetText(LeaPlusLC["AutoSellExcludeList"])
			UpdateWhiteList()

			-- Create whitelist on startup and option or preset is clicked
			UpdateWhiteList()
			LeaPlusCB["AutoSellJunkBtn"]:HookScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					UpdateWhiteList()
				end
			end)

			-- Function to make tooltip string
			local function MakeTooltipString()

				local keepMsg = ""
				local sellMsg = ""
				local dupMsg = ""
				local novalueMsg = ""
				local incompatMsg = ""

				local tipString = eb.Text:GetText()
				if tipString and tipString ~= "" then
					tipString = tipString:gsub("[^,%d]", "")
					local tipList = {strsplit(",", tipString)}
					for i = 1, #tipList do
						if tipList[i] then
							tipList[i] = tonumber(tipList[i])
							if tipList[i] and tipList[i] > 0 and tipList[i] < 999999999 then
								local void, tLink, Rarity, void, void, void, void, void, void, void, ItemPrice = C_Item.GetItemInfo(tipList[i])
								if tLink and tLink ~= "" then
									local linkCol = string.sub(tLink, 1, 10)
									if linkCol then
										local linkName = tLink:match("%[(.-)%]")
										if linkName and ItemPrice then
											if ItemPrice > 0 then
												if Rarity == 0 then
													-- Junk item
													if string.find(keepMsg, "%(" .. tipList[i] .. "%)") then
														-- Duplicate (ID appears more than once in list)
														dupMsg = dupMsg .. linkCol .. linkName .. " (" .. tipList[i] .. ")" .. "|r|n"
													else
														-- Add junk item to keep list
														keepMsg = keepMsg .. linkCol .. linkName .. " (" .. tipList[i] .. ")" .. "|r|n"
													end
												elseif Rarity == 1 then
													-- White item
													if string.find(sellMsg, "%(" .. tipList[i] .. "%)") then
														-- Duplicate (ID appears more than once in list)
														dupMsg = dupMsg .. linkCol .. linkName .. " (" .. tipList[i] .. ")" .. "|r|n"
													else
														-- Add non-junk item to sell list
														sellMsg = sellMsg .. linkCol .. linkName .. " (" .. tipList[i] .. ")" .. "|r|n"
													end
												else
													-- Incompatible item (not junk or white)
													if string.find(incompatMsg, "%(" .. tipList[i] .. "%)") then
														-- Duplicate (ID appears more than once in list)
														dupMsg = dupMsg .. linkCol .. linkName .. " (" .. tipList[i] .. ")" .. "|r|n"
													else
														-- Add item to incompatible list
														incompatMsg = incompatMsg .. linkCol .. linkName .. " (" .. tipList[i] .. ")" .. "|r|n"
													end
												end
											else
												-- Item has no sell price so cannot be sold
												if string.find(novalueMsg, "%(" .. tipList[i] .. "%)") then
													-- Duplicate (ID appears more than once in list)
													dupMsg = dupMsg .. linkCol .. linkName .. " (" .. tipList[i] .. ")" .. "|r|n"
												else
													-- Add item to cannot be sold list
													novalueMsg = novalueMsg .. linkCol .. linkName .. " (" .. tipList[i] .. ")" .. "|r|n"
												end
											end
										end
									end
								end
							end
						end
					end
				end

				if keepMsg ~= "" then keepMsg = "|n" .. L["Keep"] .. "|n" .. keepMsg end
				if sellMsg ~= "" then sellMsg = "|n" .. L["Sell"] .. "|n" .. sellMsg end
				if dupMsg ~= "" then dupMsg = "|n" .. L["Duplicates"] .. "|n" .. dupMsg end
				if novalueMsg ~= "" then novalueMsg = "|n" .. L["Cannot be sold"] .. "|n" .. novalueMsg end
				if incompatMsg ~= "" then incompatMsg = "|n" .. L["Incompatible"] .. "|n" .. incompatMsg end

				eb.tiptext = L["Exclusions"] .. "|n" .. keepMsg .. sellMsg .. dupMsg .. novalueMsg .. incompatMsg
				eb.Text.tiptext = L["Exclusions"] .. "|n" .. keepMsg .. sellMsg .. dupMsg .. novalueMsg .. incompatMsg
				if eb.tiptext == L["Exclusions"] .. "|n" then eb.tiptext = eb.tiptext .. "|n" .. L["Nothing to see here."] end
				if eb.Text.tiptext == L["Exclusions"] .. "|n" then eb.Text.tiptext = "-" end

				if GameTooltip:IsShown() then
					if MouseIsOver(eb) or MouseIsOver(eb.Text) then
						GameTooltip:SetText(eb.tiptext, nil, nil, nil, nil, false)
					end
				end

			end

			eb.Text:HookScript("OnTextChanged", MakeTooltipString)
			eb.Text:HookScript("OnTextChanged", function()
				C_Timer.After(0.1, function()
					MakeTooltipString()
				end)
			end)

			-- Show the button tooltip for the editbox
			eb:SetScript("OnEnter", MakeTooltipString)
			eb:HookScript("OnEnter", LeaPlusLC.TipSee)
			eb:HookScript("OnEnter", function() GameTooltip:SetText(eb.tiptext, nil, nil, nil, nil, false) end)
			eb:SetScript("OnLeave", GameTooltip_Hide)
			eb.Text:SetScript("OnEnter", MakeTooltipString)
			eb.Text:HookScript("OnEnter", LeaPlusLC.ShowDropTip)
			eb.Text:HookScript("OnEnter", function() GameTooltip:SetText(eb.tiptext, nil, nil, nil, nil, false) end)
			eb.Text:SetScript("OnLeave", GameTooltip_Hide)

			-- Show item ID in item tooltips while configuration panel is showing
			GameTooltip:HookScript("OnTooltipSetItem", function(self)
				if SellJunkFrame:IsShown() then
					local void, itemLink = self:GetItem()
					if itemLink then
						local itemID = GetItemInfoFromHyperlink(itemLink)
						if itemID then self:AddLine(L["Item ID"] .. ": " .. itemID) end
					end
				end
			end)

			-- Vendor function
			local function SellJunkFunc()

				-- Variables
				local SoldCount, Rarity, ItemPrice = 0, 0, 0
				local CurrentItemLink, void

				-- Traverse bags and sell grey items
				for BagID = 0, 4 do
					for BagSlot = 1, C_Container.GetContainerNumSlots(BagID) do
						CurrentItemLink = C_Container.GetContainerItemLink(BagID, BagSlot)
						if CurrentItemLink then
							void, void, Rarity, void, void, void, void, void, void, void, ItemPrice = C_Item.GetItemInfo(CurrentItemLink)
							-- Don't sell whitelisted items
							local itemID = GetItemInfoFromHyperlink(CurrentItemLink)
							if itemID and whiteList[itemID] then
								if Rarity == 0 then
									-- Junk item to keep
									Rarity = 3
									ItemPrice = 0
								elseif Rarity == 1 then
									-- White item to sell
									Rarity = 0
								end
							end
							-- Continue
							local cInfo = C_Container.GetContainerItemInfo(BagID, BagSlot)
							local itemCount = cInfo.stackCount
							if Rarity == 0 and ItemPrice ~= 0 then
								SoldCount = SoldCount + 1
								if MerchantFrame:IsShown() then
									-- If merchant frame is open, vendor the item
									C_Container.UseContainerItem(BagID, BagSlot)
									-- Perform actions on first iteration
									if SellJunkTicker._remainingIterations == IterationCount then
										-- Calculate total price
										totalPrice = totalPrice + (ItemPrice * itemCount)
									end
								else
									-- If merchant frame is not open, stop selling
									StopSelling()
									return
								end
							end
						end
					end

				end

				-- Stop selling if no items were sold for this iteration or iteration limit was reached
				if SoldCount == 0 or SellJunkTicker and SellJunkTicker._remainingIterations == 1 then
					StopSelling()
					if totalPrice > 0 and LeaPlusLC["AutoSellShowSummary"] == "On" then
						LeaPlusLC:Print(L["Sold junk for"] .. " " .. C_CurrencyInfo.GetCoinText(totalPrice) .. ".")
					end
				end

			end

			-- Function to setup events
			local function SetupEvents()
				if LeaPlusLC["AutoSellJunk"] == "On" then
					SellJunkFrame:RegisterEvent("MERCHANT_SHOW");
					SellJunkFrame:RegisterEvent("MERCHANT_CLOSED");
				else
					SellJunkFrame:UnregisterEvent("MERCHANT_SHOW")
					SellJunkFrame:UnregisterEvent("MERCHANT_CLOSED")
				end
			end

			-- Setup events when option is clicked and on startup (if option is enabled)
			LeaPlusCB["AutoSellJunk"]:HookScript("OnClick", SetupEvents)
			if LeaPlusLC["AutoSellJunk"] == "On" then SetupEvents() end

			-- Event handler
			SellJunkFrame:SetScript("OnEvent", function(self, event, arg1, arg2)
				if event == "MERCHANT_SHOW" then
					-- Check for vendors that refuse to buy items
					SellJunkFrame:RegisterEvent("UI_ERROR_MESSAGE")
					-- Reset variable
					totalPrice = 0
					-- Do nothing if shift key is held down
					if IsShiftKeyDown() then return end
					-- Cancel existing ticker if present
					if SellJunkTicker then SellJunkTicker._cancelled = true; end
					-- Sell grey items using ticker (ends when all grey items are sold or iteration count reached)
					SellJunkTicker = LeaPlusNewTicker(0.2, SellJunkFunc, IterationCount)
					SellJunkFrame:RegisterEvent("ITEM_LOCKED")
				elseif event == "ITEM_LOCKED" then
					StartMsg:Show()
					SellJunkFrame:UnregisterEvent("ITEM_LOCKED")
				elseif event == "MERCHANT_CLOSED" then
					-- If merchant frame is closed, stop selling
					StopSelling()
				elseif event == "UI_ERROR_MESSAGE" then
					if arg2 and (arg2 == ERR_VENDOR_DOESNT_BUY or arg2 == ERR_TOO_MUCH_GOLD) then
						-- Vendor refuses to buy items or player at gold limit
						StopSelling()
					end
				end
			end)

		end

		----------------------------------------------------------------------
		--	Repair automatically (no reload required)
		----------------------------------------------------------------------

		do

			-- Repair when suitable merchant frame is shown
			local function RepairFunc()
				if IsShiftKeyDown() then return end
				if CanMerchantRepair() then -- If merchant is capable of repair
					-- Process repair
					local RepairCost, CanRepair = GetRepairAllCost()
					if CanRepair then -- If merchant is offering repair
						if LeaPlusLC["AutoRepairGuildFunds"] == "On" and IsInGuild() then
							-- Guilded character and guild repair option is enabled
							if CanGuildBankRepair() then
								-- Character has permission to repair so try guild funds but fallback on character funds (if daily gold limit is reached)
								RepairAllItems(1)
								RepairAllItems()
							else
								-- Character does not have permission to repair so use character funds
								RepairAllItems()
							end
						else
							-- Unguilded character or guild repair option is disabled
							RepairAllItems()
						end
						-- Show cost summary
						if LeaPlusLC["AutoRepairShowSummary"] == "On" then
							LeaPlusLC:Print(L["Repaired for"] .. " " .. C_CurrencyInfo.GetCoinText(RepairCost) .. ".")
						end
					end
				end
			end

			-- Create event frame
			local RepairFrame = CreateFrame("FRAME")

			-- Function to setup event
			local function SetupEvent()
				if LeaPlusLC["AutoRepairGear"] == "On" then
					RepairFrame:RegisterEvent("MERCHANT_SHOW")
				else
					RepairFrame:UnregisterEvent("MERCHANT_SHOW")
				end
			end

			-- Setup event when option is clicked and on startup (if option is enabled)
			LeaPlusCB["AutoRepairGear"]:HookScript("OnClick", SetupEvent)
			if LeaPlusLC["AutoRepairGear"] == "On" then SetupEvent() end

			-- Event handler
			RepairFrame:SetScript("OnEvent", RepairFunc)

			-- Create configuration panel
			local RepairPanel = LeaPlusLC:CreatePanel("Repair automatically", "RepairPanel")

			LeaPlusLC:MakeTx(RepairPanel, "Settings", 16, -72)
			LeaPlusLC:MakeCB(RepairPanel, "AutoRepairGuildFunds", "Repair using guild funds if available", 16, -92, false, "If checked, repair costs will be taken from guild funds for characters that are guilded and have permission to repair.")
			LeaPlusLC:MakeCB(RepairPanel, "AutoRepairShowSummary", "Show repair summary in chat", 16, -112, false, "If checked, a repair summary will be shown in chat when your gear is automatically repaired.")

			-- Help button hidden
			RepairPanel.h:Hide()

			-- Back button handler
			RepairPanel.b:SetScript("OnClick", function()
				RepairPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page1"]:Show();
				return
			end)

			-- Reset button handler
			RepairPanel.r:SetScript("OnClick", function()

				-- Reset checkboxes
				LeaPlusLC["AutoRepairGuildFunds"] = "On"
				LeaPlusLC["AutoRepairShowSummary"] = "On"

				-- Refresh panel
				RepairPanel:Hide(); RepairPanel:Show()

			end)

			-- Show panal when options panel button is clicked
			LeaPlusCB["AutoRepairBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["AutoRepairGuildFunds"] = "On"
					LeaPlusLC["AutoRepairShowSummary"] = "On"
				else
					RepairPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

		end

		----------------------------------------------------------------------
		-- Hide the combat log
		----------------------------------------------------------------------

		if LeaPlusLC["NoCombatLogTab"] == "On" and not LeaLockList["NoCombatLogTab"] then

			-- Function to setup the combat log tab
			local function SetupCombatLogTab()
				ChatFrame2Tab:EnableMouse(false)
				ChatFrame2Tab:SetText(" ") -- Needs to be something for chat settings to function
				ChatFrame2Tab:SetScale(0.01)
				ChatFrame2Tab:SetWidth(0.01)
				ChatFrame2Tab:SetHeight(0.01)
			end

			local frame = CreateFrame("FRAME")
			frame:SetScript("OnEvent", SetupCombatLogTab)

			-- Ensure combat log is docked
			if ChatFrame2.isDocked then
				-- Set combat log attributes when chat windows are updated
				frame:RegisterEvent("UPDATE_CHAT_WINDOWS")
				-- Set combat log tab placement when tabs are assigned by the client
				hooksecurefunc("FCF_SetTabPosition", function()
					ChatFrame2Tab:SetPoint("BOTTOMLEFT", ChatFrame1Tab, "BOTTOMRIGHT", 0, 0)
				end)
				SetupCombatLogTab()
			else
				-- If combat log is undocked, do nothing but show warning
				C_Timer.After(1, function()
					LeaPlusLC:Print("Combat log cannot be hidden while undocked.")
				end)
			end

		end

		----------------------------------------------------------------------
		--	Show player chain
		----------------------------------------------------------------------

		if LeaPlusLC["ShowPlayerChain"] == "On" and not LeaLockList["ShowPlayerChain"] then

			-- Ensure chain doesnt clip through pet portrait
			PetPortrait:GetParent():SetFrameLevel(4)

			-- Create configuration panel
			local ChainPanel = LeaPlusLC:CreatePanel("Show player chain", "ChainPanel")

			-- Add dropdown menu
			LeaPlusLC:CreateDropdown("PlayerChainMenu", "Chain style", 146, "TOPLEFT", ChainPanel, "TOPLEFT", 16, -92, {{L["RARE"], 1}, {L["ELITE"], 2}, {L["RARE ELITE"], 3}})

			-- Set chain style
			local function SetChainStyle()

				-- If EasyFrames is installed, get the EasyFrames light texture setting
				local EasyFramesLightTexture
				if EasyFramesDB and EasyFramesDB.profiles and EasyFramesDB.profiles.Default and EasyFramesDB.profiles.Default.general and EasyFramesDB.profiles.Default.general.lightTexture then
					EasyFramesLightTexture = true
				end

				-- Get dropdown menu value
				local chain = LeaPlusLC["PlayerChainMenu"] -- Numeric value
				-- Set chain style according to value
				if chain == 1 then -- Rare
					if C_AddOns.IsAddOnLoaded("EasyFrames") then
						PlayerFrameTexture:SetTexture("Interface\\AddOns\\Leatrix_Plus\\Leatrix_Plus.blp")
						if EasyFramesLightTexture then
							PlayerFrameTexture:SetTexCoord(0, 0.2265, 0.875, 0.9726)
						else
							PlayerFrameTexture:SetTexCoord(0, 0.2265, 0.75, 0.8476)
						end
					else
						PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare.blp")
						PlayerFrameTexture:SetTexCoord(1, .09375, 0, .78125)
					end
				elseif chain == 2 then -- Elite
					if C_AddOns.IsAddOnLoaded("EasyFrames") then
						PlayerFrameTexture:SetTexture("Interface\\AddOns\\Leatrix_Plus\\Leatrix_Plus.blp")
						if EasyFramesLightTexture then
							PlayerFrameTexture:SetTexCoord(0.5, 0.7265, 0.875, 0.9726)
						else
							PlayerFrameTexture:SetTexCoord(0.5, 0.7265, 0.75, 0.8476)
						end
					else
						PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite.blp")
						PlayerFrameTexture:SetTexCoord(1, .09375, 0, .78125)
					end
				elseif chain == 3 then -- Rare Elite
					if C_AddOns.IsAddOnLoaded("EasyFrames") then
						PlayerFrameTexture:SetTexture("Interface\\AddOns\\Leatrix_Plus\\Leatrix_Plus.blp")
						if EasyFramesLightTexture then
							PlayerFrameTexture:SetTexCoord(0.25, 0.4765, 0.875, 0.9726)
						else
							PlayerFrameTexture:SetTexCoord(0.25, 0.4765, 0.75, 0.8476)
						end
					else
						PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare-Elite.blp")
						PlayerFrameTexture:SetTexCoord(1, .09375, 0, .78125)
					end
				end

			end

			-- Set style on startup
			SetChainStyle()

			-- If Easy Frames is installed, set chain style when Easy Frames has loaded
			EventUtil.ContinueOnAddOnLoaded("EasyFrames", function()
				local EasyFrames = LibStub("AceAddon-3.0"):GetAddon("EasyFrames", true)
				if EasyFrames then
					local General = EasyFrames:GetModule("General", true)
					if General then
						-- Set chain style when Easy Frames use a light texture checkbox is toggled
						local SetLightTextureFunc = General.SetLightTexture
						if SetLightTextureFunc then
							hooksecurefunc(General, "SetLightTexture", SetChainStyle)
						end
					end
				end
				-- Set chain style after Easy Frames has loaded
				SetChainStyle()
			end)

			-- Set style when a drop menu is selected (procs when the list is hidden)
			LeaPlusCB["PlayerChainMenu"]:RegisterCallback("OnMenuClose", SetChainStyle)

			-- Help button hidden
			ChainPanel.h:Hide()

			-- Back button handler
			ChainPanel.b:SetScript("OnClick", function()
				ChainPanel:Hide()
				LeaPlusLC["PageF"]:Show()
				LeaPlusLC["Page5"]:Show()
				return
			end)

			-- Reset button handler
			ChainPanel.r:SetScript("OnClick", function()
				LeaPlusLC["PlayerChainMenu"] = 2
				ChainPanel:Hide(); ChainPanel:Show()
				SetChainStyle()
			end)

			-- Show the panel when the configuration button is clicked
			LeaPlusCB["ModPlayerChain"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					LeaPlusLC["PlayerChainMenu"] = 3
					SetChainStyle()
				else
					LeaPlusLC:HideFrames()
					ChainPanel:Show()
				end
			end)

		end

		----------------------------------------------------------------------
		-- Show raid frame toggle button
		----------------------------------------------------------------------

		if LeaPlusLC["ShowRaidToggle"] == "On" and not LeaLockList["ShowRaidToggle"] then

			-- Check to make sure raid toggle button exists
			if CompactRaidFrameManagerDisplayFrameHiddenModeToggle then

				-- Create a border for the button
				local cBackdrop = CreateFrame("Frame", nil, CompactRaidFrameManagerDisplayFrameHiddenModeToggle, "BackdropTemplate")
				cBackdrop:SetAllPoints()
				cBackdrop.backdropInfo = {edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 16, insets = {left = 0, right = 0, top = 0, bottom = 0}}
				cBackdrop:ApplyBackdrop()

				-- Move the button (function runs after PLAYER_ENTERING_WORLD and PARTY_LEADER_CHANGED)
				hooksecurefunc("CompactRaidFrameManager_UpdateOptionsFlowContainer", function()
					if CompactRaidFrameManager and CompactRaidFrameManagerDisplayFrameHiddenModeToggle then
						local void, void, void, void, y = CompactRaidFrameManager:GetPoint()
						CompactRaidFrameManagerDisplayFrameHiddenModeToggle:SetWidth(40)
						CompactRaidFrameManagerDisplayFrameHiddenModeToggle:ClearAllPoints()
						CompactRaidFrameManagerDisplayFrameHiddenModeToggle:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, y + 22)
						CompactRaidFrameManagerDisplayFrameHiddenModeToggle:SetParent(UIParent)
					end
				end)

			end

		end

		----------------------------------------------------------------------
		-- Hide hit indicators (portrait text)
		----------------------------------------------------------------------

		if LeaPlusLC["NoHitIndicators"] == "On" and not LeaLockList["NoHitIndicators"] then
			hooksecurefunc(PlayerHitIndicator, "Show", PlayerHitIndicator.Hide)
			hooksecurefunc(PetHitIndicator, "Show", PetHitIndicator.Hide)
		end

		----------------------------------------------------------------------
		-- Class colored frames
		----------------------------------------------------------------------

		if LeaPlusLC["ClassColFrames"] == "On" and not LeaLockList["ClassColFrames"] then

			-- Create background frame for player frame
			local PlayFN = CreateFrame("FRAME", nil, PlayerFrame)
			PlayFN:Hide()

			PlayFN:SetWidth(TargetFrameNameBackground:GetWidth())
			PlayFN:SetHeight(TargetFrameNameBackground:GetHeight())

			local void, void, void, x, y = TargetFrameNameBackground:GetPoint()
			PlayFN:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -x, y)

			PlayFN.t = PlayFN:CreateTexture(nil, "BORDER")
			PlayFN.t:SetAllPoints()
			PlayFN.t:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-LevelBackground")

			local c = LeaPlusLC["RaidColors"][select(2, UnitClass("player"))]
			if c then PlayFN.t:SetVertexColor(c.r, c.g, c.b) end

			-- Create color function for target and focus frames
			local function TargetFrameCol()
				if UnitIsPlayer("target") then
					local c = LeaPlusLC["RaidColors"][select(2, UnitClass("target"))]
					if c then TargetFrameNameBackground:SetVertexColor(c.r, c.g, c.b) end
				end
				if UnitIsPlayer("focus") then
					local c = LeaPlusLC["RaidColors"][select(2, UnitClass("focus"))]
					if c then FocusFrameNameBackground:SetVertexColor(c.r, c.g, c.b) end
				end
			end

			local ColTar = CreateFrame("FRAME")
			ColTar:SetScript("OnEvent", TargetFrameCol) -- Events are registered if target option is enabled

			-- Refresh color if focus frame size changes
			hooksecurefunc(FocusFrame, "SetSmallSize", function()
				if LeaPlusLC["ClassColTarget"] == "On" then
					TargetFrameCol()
				end
			end)

			-- Create configuration panel
			local ClassFrame = LeaPlusLC:CreatePanel("Class colored frames", "ClassFrame")

			LeaPlusLC:MakeTx(ClassFrame, "Settings", 16, -72)
			LeaPlusLC:MakeCB(ClassFrame, "ClassColPlayer", "Show player frame in class color", 16, -92, false, "If checked, the player frame background will be shown in class color.")
			LeaPlusLC:MakeCB(ClassFrame, "ClassColTarget", "Show target frame and focus frame in class color", 16, -112, false, "If checked, the target frame background and focus frame background will be shown in class color.")

			-- Help button hidden
			ClassFrame.h:Hide()

			-- Back button handler
			ClassFrame.b:SetScript("OnClick", function()
				ClassFrame:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page6"]:Show()
				return
			end)

			-- Function to set class colored frames
			local function SetClassColFrames()
				-- Player frame
				if LeaPlusLC["ClassColPlayer"] == "On" then
					PlayFN:Show()
				else
					PlayFN:Hide()
				end
				-- Target and focus frames
				if LeaPlusLC["ClassColTarget"] == "On" then
					ColTar:RegisterEvent("GROUP_ROSTER_UPDATE")
					ColTar:RegisterEvent("PLAYER_TARGET_CHANGED")
					ColTar:RegisterEvent("PLAYER_FOCUS_CHANGED")
					ColTar:RegisterEvent("UNIT_FACTION")
					TargetFrameCol()
				else
					ColTar:UnregisterAllEvents()
					TargetFrame_CheckFaction(TargetFrame) -- Reset target frame colors
					TargetFrame_CheckFaction(FocusFrame) -- Reset focus frame colors
				end
			end

			-- Run function when options are clicked and on startup
			LeaPlusCB["ClassColPlayer"]:HookScript("OnClick", SetClassColFrames)
			LeaPlusCB["ClassColTarget"]:HookScript("OnClick", SetClassColFrames)
			SetClassColFrames()

			-- Reset button handler
			ClassFrame.r:SetScript("OnClick", function()

				-- Reset checkboxes
				LeaPlusLC["ClassColPlayer"] = "On"
				LeaPlusLC["ClassColTarget"] = "On"

				-- Update colors and refresh configuration panel
				SetClassColFrames()
				ClassFrame:Hide(); ClassFrame:Show()

			end)

			-- Show configuration panal when options panel button is clicked
			LeaPlusCB["ClassColFramesBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["ClassColPlayer"] = "On"
					LeaPlusLC["ClassColTarget"] = "On"
					SetClassColFrames()
				else
					ClassFrame:Show()
					LeaPlusLC:HideFrames()
				end
			end)

		end

		----------------------------------------------------------------------
		--	Quest text size
		----------------------------------------------------------------------

		if LeaPlusLC["QuestFontChange"] == "On" and not LeaLockList["QuestFontChange"] then

			-- Set gossip frame scroll box layout (fix for game patch 3.4.1)
			GossipFrame.GreetingPanel.ScrollBox:SetHeight(320)
			GossipFrame.GreetingPanel.ScrollBar:ClearAllPoints()
			GossipFrame.GreetingPanel.ScrollBar:SetPoint("TOPLEFT", GossipFrame.GreetingPanel.ScrollBox, "TOPRIGHT", 4, 9)
			GossipFrame.GreetingPanel.ScrollBar:SetPoint("BOTTOMLEFT", GossipFrame.GreetingPanel.ScrollBox, "BOTTOMRIGHT", 4, -14)

			-- Create configuration panel
			local QuestTextPanel = LeaPlusLC:CreatePanel("Resize quest text", "QuestTextPanel")

			LeaPlusLC:MakeTx(QuestTextPanel, "Text size", 16, -72)
			LeaPlusLC:MakeSL(QuestTextPanel, "LeaPlusQuestFontSize", "Drag to set the font size of quest text.", 10, 30, 1, 16, -92, "%.0f")

			-- Function to update the font size
			local function QuestSizeUpdate()
				local a, b, c = QuestFont:GetFont()
				QuestTitleFont:SetFont(a, LeaPlusLC["LeaPlusQuestFontSize"] + 3, c)
				QuestFont:SetFont(a, LeaPlusLC["LeaPlusQuestFontSize"] + 1, c)
				local d, e, f = QuestFontNormalSmall:GetFont()
				QuestFontNormalSmall:SetFont(d, LeaPlusLC["LeaPlusQuestFontSize"], f)
			end

			-- Set text size when slider changes and on startup
			LeaPlusCB["LeaPlusQuestFontSize"]:HookScript("OnValueChanged", QuestSizeUpdate)
			QuestSizeUpdate()

			-- Help button hidden
			QuestTextPanel.h:Hide()

			-- Back button handler
			QuestTextPanel.b:SetScript("OnClick", function()
				QuestTextPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page4"]:Show()
				return
			end)

			-- Reset button handler
			QuestTextPanel.r:SetScript("OnClick", function()

				-- Reset slider
				LeaPlusLC["LeaPlusQuestFontSize"] = 12
				QuestSizeUpdate()

				-- Refresh side panel
				QuestTextPanel:Hide(); QuestTextPanel:Show()

			end)

			-- Show configuration panal when options panel button is clicked
			LeaPlusCB["QuestTextBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["LeaPlusQuestFontSize"] = 18
					QuestSizeUpdate()
				else
					QuestTextPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

		end

		----------------------------------------------------------------------
		--	Resize mail text
		----------------------------------------------------------------------

		if LeaPlusLC["MailFontChange"] == "On" then

			-- Create configuration panel
			local MailTextPanel = LeaPlusLC:CreatePanel("Resize mail text", "MailTextPanel")

			LeaPlusLC:MakeTx(MailTextPanel, "Text size", 16, -72)
			LeaPlusLC:MakeSL(MailTextPanel, "LeaPlusMailFontSize", "Drag to set the font size of mail text.", 10, 30, 1, 16, -92, "%.0f")

			-- Function to set the text size
			local function MailSizeUpdate()
				local MailFont, void, flags = QuestFont:GetFont()
				OpenMailBodyText:SetFont("h1", MailFont, LeaPlusLC["LeaPlusMailFontSize"], flags)
				OpenMailBodyText:SetFont("h2", MailFont, LeaPlusLC["LeaPlusMailFontSize"], flags)
				OpenMailBodyText:SetFont("h3", MailFont, LeaPlusLC["LeaPlusMailFontSize"], flags)
				OpenMailBodyText:SetFont("p", MailFont, LeaPlusLC["LeaPlusMailFontSize"], flags)
				MailEditBox:GetEditBox():SetFont(MailFont, LeaPlusLC["LeaPlusMailFontSize"], flags) -- in DF, this is replaced with SendMailBodyEditBox
			end

			-- Set text size after changing slider and on startup
			LeaPlusCB["LeaPlusMailFontSize"]:HookScript("OnValueChanged", MailSizeUpdate)
			MailSizeUpdate()

			-- Help button hidden
			MailTextPanel.h:Hide()

			-- Back button handler
			MailTextPanel.b:SetScript("OnClick", function()
				MailTextPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page4"]:Show()
				return
			end)

			-- Reset button handler
			MailTextPanel.r:SetScript("OnClick", function()

				-- Reset slider
				LeaPlusLC["LeaPlusMailFontSize"] = 15

				-- Refresh side panel
				MailTextPanel:Hide(); MailTextPanel:Show()

			end)

			-- Show configuration panal when options panel button is clicked
			LeaPlusCB["MailTextBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["LeaPlusMailFontSize"] = 22
					MailSizeUpdate()
				else
					MailTextPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

		end

		----------------------------------------------------------------------
		--	Resize book text
		----------------------------------------------------------------------

		if LeaPlusLC["BookFontChange"] == "On" then

			-- Create configuration panel
			local BookTextPanel = LeaPlusLC:CreatePanel("Resize book text", "BookTextPanel")

			LeaPlusLC:MakeTx(BookTextPanel, "Text size", 16, -72)
			LeaPlusLC:MakeSL(BookTextPanel, "LeaPlusBookFontSize", "Drag to set the font size of book text.", 10, 30, 1, 16, -92, "%.0f")

			-- Function to set the text size
			local function BookSizeUpdate()
				local BookFont, void, flags = QuestFont:GetFont()
				ItemTextFontNormal:SetFont(BookFont, LeaPlusLC["LeaPlusBookFontSize"], flags)
			end

			-- Set text size after changing slider and on startup
			LeaPlusCB["LeaPlusBookFontSize"]:HookScript("OnValueChanged", BookSizeUpdate)
			BookSizeUpdate()

			-- Help button hidden
			BookTextPanel.h:Hide()

			-- Back button handler
			BookTextPanel.b:SetScript("OnClick", function()
				BookTextPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page4"]:Show()
				return
			end)

			-- Reset button handler
			BookTextPanel.r:SetScript("OnClick", function()

				-- Reset slider
				LeaPlusLC["LeaPlusBookFontSize"] = 15

				-- Refresh side panel
				BookTextPanel:Hide(); BookTextPanel:Show()

			end)

			-- Show configuration panal when options panel button is clicked
			LeaPlusCB["BookTextBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["LeaPlusBookFontSize"] = 22
					BookSizeUpdate()
				else
					BookTextPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

		end

		----------------------------------------------------------------------
		--	Show durability status
		----------------------------------------------------------------------

		if LeaPlusLC["DurabilityStatus"] == "On" then

			-- Create durability button
			local cButton = CreateFrame("BUTTON", nil, PaperDollFrame)
			cButton:ClearAllPoints()
			cButton:SetPoint("BOTTOMRIGHT", CharacterFrame, "BOTTOMRIGHT", -40, 80)
			cButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
			cButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
			cButton:SetSize(32, 32)

			-- Hide expand button
			cButton:Hide()
			cButton = CharacterFrameExpandButton

			-- Create durability tables
			local Slots = {"HeadSlot", "ShoulderSlot", "ChestSlot", "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "MainHandSlot", "SecondaryHandSlot"}
			local SlotsFriendly = {INVTYPE_HEAD, INVTYPE_SHOULDER, INVTYPE_CHEST, INVTYPE_WRIST, INVTYPE_HAND, INVTYPE_WAIST, INVTYPE_LEGS, INVTYPE_FEET, INVTYPE_WEAPONMAINHAND, INVTYPE_WEAPONOFFHAND}

			-- Show durability status in tooltip or status line (tip or status)
			local function ShowDuraStats(where)

				local duravaltotal, duramaxtotal, durapercent = 0, 0, 0
				local valcol, id, duraval, duramax

				if where == "tip" then
					-- Creare layout
					GameTooltip:AddLine("|cffffffff")
					GameTooltip:AddLine("|cffffffff")
					GameTooltip:AddLine("|cffffffff")
					_G["GameTooltipTextLeft1"]:SetText("|cffffffff"); _G["GameTooltipTextRight1"]:SetText("|cffffffff")
					_G["GameTooltipTextLeft2"]:SetText("|cffffffff"); _G["GameTooltipTextRight2"]:SetText("|cffffffff")
					_G["GameTooltipTextLeft3"]:SetText("|cffffffff"); _G["GameTooltipTextRight3"]:SetText("|cffffffff")
				end

				local validItems = false

				-- Traverse equipment slots
				for k, slotName in ipairs(Slots) do
					if GetInventorySlotInfo(slotName) then
						id = GetInventorySlotInfo(slotName)
						duraval, duramax = GetInventoryItemDurability(id)
						if duraval ~= nil then

							-- At least one item has durability stat
							validItems = true

							-- Add to tooltip
							if where == "tip" then
								durapercent = tonumber(format("%.0f", duraval / duramax * 100))
								valcol = (durapercent >= 80 and "|cff00FF00") or (durapercent >= 60 and "|cff99FF00") or (durapercent >= 40 and "|cffFFFF00") or (durapercent >= 20 and "|cffFF9900") or (durapercent >= 0 and "|cffFF2000") or ("|cffFFFFFF")
								_G["GameTooltipTextLeft1"]:SetText(L["Durability"])
								_G["GameTooltipTextLeft2"]:SetText(_G["GameTooltipTextLeft2"]:GetText() .. SlotsFriendly[k] .. "|n")
								_G["GameTooltipTextRight2"]:SetText(_G["GameTooltipTextRight2"]:GetText() ..  valcol .. durapercent .. "%" .. "|n")
							end

							duravaltotal = duravaltotal + duraval
							duramaxtotal = duramaxtotal + duramax
						end
					end
				end
				if duravaltotal > 0 and duramaxtotal > 0 then
					durapercent = duravaltotal / duramaxtotal * 100
				else
					durapercent = 0
				end

				if where == "tip" then

					if validItems == true then
						-- Show overall durability in the tooltip
						if durapercent >= 80 then valcol = "|cff00FF00"	elseif durapercent >= 60 then valcol = "|cff99FF00"	elseif durapercent >= 40 then valcol = "|cffFFFF00"	elseif durapercent >= 20 then valcol = "|cffFF9900"	elseif durapercent >= 0 then valcol = "|cffFF2000" else return end
						_G["GameTooltipTextLeft3"]:SetText(L["Overall"] .. " " .. valcol)
						_G["GameTooltipTextRight3"]:SetText(valcol .. string.format("%.0f", durapercent) .. "%")

						-- Show lines of the tooltip
						GameTooltipTextLeft1:Show(); GameTooltipTextRight1:Show()
						GameTooltipTextLeft2:Show(); GameTooltipTextRight2:Show()
						GameTooltipTextLeft3:Show(); GameTooltipTextRight3:Show()
						GameTooltipTextRight2:SetJustifyH"RIGHT";
						GameTooltipTextRight3:SetJustifyH"RIGHT";
						GameTooltip:Show()
					else
						-- No items have durability stat
						GameTooltip:ClearLines()
						GameTooltip:AddLine("" .. L["Durability"],1.0, 0.85, 0.0)
						GameTooltip:AddLine("" .. L["No items with durability equipped."], 1, 1, 1)
						GameTooltip:Show()
					end

				elseif where == "status" then
					if validItems == true then
						-- Show simple status line instead
						if tonumber(durapercent) >= 0 then -- Ensure character has some durability items equipped
							LeaPlusLC:Print(L["You have"] .. " " .. string.format("%.0f", durapercent) .. "%" .. " " .. L["durability"] .. ".")
						end
					end

				end
			end

			-- Hover over the durability button to show the durability tooltip
			cButton:SetScript("OnEnter", function()
				GameTooltip:SetOwner(cButton, "ANCHOR_RIGHT")
				GameTooltip:SetMinimumWidth(0) -- Needed due to mage reset specialisation and choose frost
				ShowDuraStats("tip")
			end)
			cButton:SetScript("OnLeave", GameTooltip_Hide)

			-- Create frame to watch events
			local DeathDura = CreateFrame("FRAME")
			DeathDura:RegisterEvent("PLAYER_DEAD")
			DeathDura:SetScript("OnEvent", function(self, event)
				ShowDuraStats("status")
				DeathDura:UnregisterEvent("PLAYER_DEAD")
				C_Timer.After(2, function()
					DeathDura:RegisterEvent("PLAYER_DEAD")
				end)
			end)

			hooksecurefunc("AcceptResurrect", function()
				-- Player has ressed without releasing
				ShowDuraStats("status")
			end)

		end

		----------------------------------------------------------------------
		--	Hide zone text
		----------------------------------------------------------------------

		if LeaPlusLC["HideZoneText"] == "On" then
			ZoneTextFrame:SetScript("OnShow", ZoneTextFrame.Hide);
			SubZoneTextFrame:SetScript("OnShow", SubZoneTextFrame.Hide);
		end

		----------------------------------------------------------------------
		--	Disable sticky chat
		----------------------------------------------------------------------

		if LeaPlusLC["NoStickyChat"] == "On" and not LeaLockList["NoStickyChat"] then
			-- These taint if set to anything other than nil
			ChatTypeInfo.WHISPER.sticky = nil
			ChatTypeInfo.BN_WHISPER.sticky = nil
			ChatTypeInfo.CHANNEL.sticky = nil
		end

		----------------------------------------------------------------------
		--	Hide stance bar
		----------------------------------------------------------------------

		if LeaPlusLC["NoClassBar"] == "On" and not LeaLockList["NoClassBar"] then
			local stancebar = CreateFrame("FRAME", nil, UIParent)
			stancebar:Hide()
			StanceBarFrame:UnregisterAllEvents()
			StanceBarFrame:SetParent(stancebar)
		end

		----------------------------------------------------------------------
		--	Hide gryphons
		----------------------------------------------------------------------

		if LeaPlusLC["NoGryphons"] == "On" and not LeaLockList["NoGryphons"] then
			MainMenuBarLeftEndCap:Hide()
			MainMenuBarRightEndCap:Hide()
		end

		----------------------------------------------------------------------
		--	Disable chat fade
		----------------------------------------------------------------------

		if LeaPlusLC["NoChatFade"] == "On" and not LeaLockList["NoChatFade"] then
			-- Process normal and existing chat frames
			for i = 1, 50 do
				if _G["ChatFrame" .. i] then
					_G["ChatFrame" .. i]:SetFading(false)
				end
			end
			-- Process temporary frames
			hooksecurefunc("FCF_OpenTemporaryWindow", function()
				local cf = FCF_GetCurrentChatFrame():GetName() or nil
				if cf then
					_G[cf]:SetFading(false)
				end
			end)
		end

		----------------------------------------------------------------------
		--	Use easy chat frame resizing
		----------------------------------------------------------------------

		if LeaPlusLC["UseEasyChatResizing"] == "On" and not LeaLockList["UseEasyChatResizing"] then
			ChatFrame1Tab:HookScript("OnMouseDown", function(self,arg1)
				if arg1 == "LeftButton" then
					if select(8, GetChatWindowInfo(1)) then
						ChatFrame1:StartSizing("TOP")
					end
				end
			end)
			ChatFrame1Tab:SetScript("OnMouseUp", function(self,arg1)
				if arg1 == "LeftButton" then
					ChatFrame1:StopMovingOrSizing()
					FCF_SavePositionAndDimensions(ChatFrame1)
				end
			end)
		end

		----------------------------------------------------------------------
		--	Increase chat history
		----------------------------------------------------------------------

		if LeaPlusLC["MaxChatHstory"] == "On" and not LeaLockList["MaxChatHstory"] then
			-- Process normal and existing chat frames
			for i = 1, 50 do
				if _G["ChatFrame" .. i] and _G["ChatFrame" .. i]:GetMaxLines() ~= 4096 then
					_G["ChatFrame" .. i]:SetMaxLines(4096)
				end
			end
			-- Process temporary chat frames
			hooksecurefunc("FCF_OpenTemporaryWindow", function()
				local cf = FCF_GetCurrentChatFrame():GetName() or nil
				if cf then
					if (_G[cf]:GetMaxLines() ~= 4096) then
						_G[cf]:SetMaxLines(4096)
					end
				end
			end)
		end

		----------------------------------------------------------------------
		--	Hide error messages
		----------------------------------------------------------------------

		if LeaPlusLC["HideErrorMessages"] == "On" then

			--	Error message events
			local OrigErrHandler = UIErrorsFrame:GetScript('OnEvent')
			UIErrorsFrame:SetScript('OnEvent', function (self, event, id, err, ...)
				if event == "UI_ERROR_MESSAGE" then
					-- Hide error messages
					if LeaPlusLC["ShowErrorsFlag"] == 1 then
						if 	err == ERR_INV_FULL or
							err == ERR_QUEST_LOG_FULL or
							err == ERR_RAID_GROUP_ONLY or
							err == ERR_PET_SPELL_DEAD or
							err == ERR_PLAYER_DEAD or
							err == ERR_FEIGN_DEATH_RESISTED or
							err == SPELL_FAILED_TARGET_NO_POCKETS or
							err == ERR_ALREADY_PICKPOCKETED then
							return OrigErrHandler(self, event, id, err, ...)
						end
					else
						return OrigErrHandler(self, event, id, err, ...)
					end
				elseif event == 'UI_INFO_MESSAGE'  then
					-- Show information messages
					return OrigErrHandler(self, event, id, err, ...)
				end
			end)

		end

		----------------------------------------------------------------------
		-- Easy item destroy
		----------------------------------------------------------------------

		if LeaPlusLC["EasyItemDestroy"] == "On" then

			-- Get the type "DELETE" into the field to confirm text
			local TypeDeleteLine = gsub(DELETE_GOOD_ITEM, "[\r\n]", "@")
			local void, TypeDeleteLine = strsplit("@", TypeDeleteLine, 2)

			-- Add hyperlinks to regular item destroy
			RunScript('StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter = function(self, link, text, region, boundsLeft, boundsBottom, boundsWidth, boundsHeight) GameTooltip:SetOwner(self, "ANCHOR_PRESERVE") GameTooltip:ClearAllPoints() local cursorClearance = 30 GameTooltip:SetPoint("TOPLEFT", region, "BOTTOMLEFT", boundsLeft, boundsBottom - cursorClearance) GameTooltip:SetHyperlink(link) end')
			RunScript('StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave = function(self) GameTooltip:Hide() end')
			RunScript('StaticPopupDialogs["DELETE_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter')
			RunScript('StaticPopupDialogs["DELETE_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave')
			RunScript('StaticPopupDialogs["DELETE_QUEST_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter')
			RunScript('StaticPopupDialogs["DELETE_QUEST_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave')
			RunScript('StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"].OnHyperlinkEnter = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkEnter')
			RunScript('StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"].OnHyperlinkLeave = StaticPopupDialogs["DELETE_GOOD_ITEM"].OnHyperlinkLeave')

			-- Hide editbox and set item link
			local easyDelFrame = CreateFrame("FRAME")
			easyDelFrame:RegisterEvent("DELETE_ITEM_CONFIRM")
			easyDelFrame:SetScript("OnEvent", function()
				if StaticPopup1EditBox:IsShown() then
					-- Item requires player to type delete so hide editbox and show link
					StaticPopup1:SetHeight(StaticPopup1:GetHeight() - 10)
					StaticPopup1EditBox:Hide()
					StaticPopup1Button1:Enable()
					local link = select(3, GetCursorInfo())
					if link then
						-- Custom link for battle pets
						local linkType, linkOptions, name = LinkUtil.ExtractLink(link)
						if linkType == "battlepet" then
							local speciesID, level, breedQuality = strsplit(":", linkOptions)
							local qualityColor = BAG_ITEM_QUALITY_COLORS[tonumber(breedQuality)]
							link = qualityColor:WrapTextInColorCode(name .. " |n" .. L["Level"] .. " " .. level .. L["Battle Pet"])
						end
						StaticPopup1Text:SetText(gsub(StaticPopup1Text:GetText(), gsub(TypeDeleteLine, "@", ""), "") .. "|n" .. link)
					end
				else
					-- Item does not require player to type delete so just show item link
					StaticPopup1:SetHeight(StaticPopup1:GetHeight() + 40)
					StaticPopup1EditBox:Hide()
					StaticPopup1Button1:Enable()
					local link = select(3, GetCursorInfo())
					if link then
						-- Custom link for battle pets
						local linkType, linkOptions, name = LinkUtil.ExtractLink(link)
						if linkType == "battlepet" then
							local speciesID, level, breedQuality = strsplit(":", linkOptions)
							local qualityColor = BAG_ITEM_QUALITY_COLORS[tonumber(breedQuality)]
							link = qualityColor:WrapTextInColorCode(name .. " |n" .. L["Level"] .. " " .. level .. L["Battle Pet"])
						end
						StaticPopup1Text:SetText(gsub(StaticPopup1Text:GetText(), gsub(TypeDeleteLine, "@", ""), "") .. "|n|n" .. link)
					end
				end
			end)

		end

		----------------------------------------------------------------------
		-- Unclamp chat frame
		----------------------------------------------------------------------

		if LeaPlusLC["UnclampChat"] == "On" and not LeaLockList["UnclampChat"] then

			-- Process normal and existing chat frames on startup
			for i = 1, 50 do
				if _G["ChatFrame" .. i] then
					_G["ChatFrame" .. i]:SetClampedToScreen(false)
					_G["ChatFrame" .. i]:SetClampRectInsets(0, 0, 0, 0)
				end
			end

			-- Process new chat frames and combat log
			hooksecurefunc("FloatingChatFrame_UpdateBackgroundAnchors", function(self)
				self:SetClampRectInsets(0, 0, 0, 0)
			end)

			-- Process temporary chat frames
			hooksecurefunc("FCF_OpenTemporaryWindow", function()
				local cf = FCF_GetCurrentChatFrame():GetName() or nil
				if cf then
					_G[cf]:SetClampRectInsets(0, 0, 0, 0)
				end
			end)

		end


		----------------------------------------------------------------------
		-- Enhance flight map
		----------------------------------------------------------------------

		if LeaPlusLC["EnhanceFlightMap"] == "On" then

			-- Set flight map properties
			TaxiFrame:SetFrameStrata("FULLSCREEN_DIALOG")
			TaxiFrame:SetHitRectInsets(18, 45, 73, 83)
			TaxiFrame:SetClampedToScreen(true)
			TaxiFrame:SetClampRectInsets(200, -200, -300, 300)

			-- Position flight map when shown
			hooksecurefunc(TaxiFrame, "SetPoint", function(self, ...)
				local a, void, r, x, y = TaxiFrame:GetPoint()
				x = tonumber(string.format("%.2f", x))
				y = tonumber(string.format("%.2f", y))
				local xb = tonumber(string.format("%.2f", LeaPlusLC["FlightMapX"]))
				local yb = tonumber(string.format("%.2f", LeaPlusLC["FlightMapY"]))
				if a ~= LeaPlusLC["FlightMapA"] or r ~= LeaPlusLC["FlightMapR"] or x ~= xb or y ~= yb then
					TaxiFrame:ClearAllPoints()
					TaxiFrame:SetPoint(LeaPlusLC["FlightMapA"], UIParent, LeaPlusLC["FlightMapR"], LeaPlusLC["FlightMapX"], LeaPlusLC["FlightMapY"])
				end
			end)

			-- Set flight point buttons size
			TaxiFrame:HookScript("OnShow", function()
				for i = 1, NUM_TAXI_BUTTONS do
					local button = _G["TaxiButton"..i]
					if button and button:IsVisible() then
						_G["TaxiButton" .. i]:SetSize(LeaPlusLC["LeaPlusTaxiIconSize"], LeaPlusLC["LeaPlusTaxiIconSize"])
						if button:GetHighlightTexture() then button:GetHighlightTexture():SetSize(LeaPlusLC["LeaPlusTaxiIconSize"] * 2, LeaPlusLC["LeaPlusTaxiIconSize"] * 2) end
						if button:GetPushedTexture() then button:GetPushedTexture():SetSize(LeaPlusLC["LeaPlusTaxiIconSize"] * 2, LeaPlusLC["LeaPlusTaxiIconSize"] * 2) end
				   end
				end
			end)

			-- Create configuration panel
			local TaxiPanel = LeaPlusLC:CreatePanel("Enhance flight map", "TaxiPanel")

			LeaPlusLC:MakeTx(TaxiPanel, "Map scale", 356, -72)
			LeaPlusLC:MakeSL(TaxiPanel, "LeaPlusTaxiMapScale", "Drag to set the scale of the flight map.", 1, 3, 0.05, 356, -92, "%.0f")

			LeaPlusLC:MakeTx(TaxiPanel, "Icon size", 356, -132)
			LeaPlusLC:MakeSL(TaxiPanel, "LeaPlusTaxiIconSize", "Drag to set the size of the icons.", 8, 48, 1, 356, -152, "%.0f")

			LeaPlusLC:MakeTx(TaxiPanel, "Position", 16, -72)
			TaxiPanel.txt = LeaPlusLC:MakeWD(TaxiPanel, "Hold ALT and drag the flight map to move it.", 16, -92, 500)
			TaxiPanel.txt:SetWordWrap(true)
			TaxiPanel.txt:SetWidth(300)

			-- Function to set flight map scale
			local function SetFlightMapScale()
				TaxiFrame:SetScale(LeaPlusLC["LeaPlusTaxiMapScale"])
				LeaPlusCB["LeaPlusTaxiMapScale"].f:SetFormattedText("%.0f%%", LeaPlusLC["LeaPlusTaxiMapScale"] * 100)
			end

			-- Function to set icon size (used for reset and when slider changes)
			local function SetFlightMapIconSize()
				for i = 1, NUM_TAXI_BUTTONS do
					local button = _G["TaxiButton"..i]
					if button and button:IsVisible() then
						_G["TaxiButton" .. i]:SetSize(LeaPlusLC["LeaPlusTaxiIconSize"], LeaPlusLC["LeaPlusTaxiIconSize"])
						if button:GetHighlightTexture() then button:GetHighlightTexture():SetSize(LeaPlusLC["LeaPlusTaxiIconSize"] * 2, LeaPlusLC["LeaPlusTaxiIconSize"] * 2) end
						if button:GetPushedTexture() then button:GetPushedTexture():SetSize(LeaPlusLC["LeaPlusTaxiIconSize"] * 2, LeaPlusLC["LeaPlusTaxiIconSize"] * 2) end
				   end
				end
				LeaPlusCB["LeaPlusTaxiIconSize"].f:SetFormattedText("%.0f%%", (LeaPlusLC["LeaPlusTaxiIconSize"] / 16) * 100)
			end

			-- Set flight map scale when slider changes and on startup
			LeaPlusCB["LeaPlusTaxiMapScale"]:HookScript("OnValueChanged", SetFlightMapScale)
			LeaPlusCB["LeaPlusTaxiIconSize"]:HookScript("OnValueChanged", SetFlightMapIconSize)
			SetFlightMapScale()

			-- Help button tooltip
			TaxiPanel.h.tiptext = L["This panel will close automatically if you enter combat."]

			-- Back button handler
			TaxiPanel.b:SetScript("OnClick", function()
				TaxiPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page5"]:Show()
				return
			end)

			-- Reset button handler
			TaxiPanel.r:SetScript("OnClick", function()

				-- Reset slider
				LeaPlusLC["LeaPlusTaxiMapScale"] = 1.0
				LeaPlusLC["LeaPlusTaxiIconSize"] = 16
				SetFlightMapScale()
				LeaPlusLC["FlightMapA"] = "TOPLEFT"
				LeaPlusLC["FlightMapR"] = "TOPLEFT"
				LeaPlusLC["FlightMapX"] = 16
				LeaPlusLC["FlightMapY"] = -48
				TaxiFrame:ClearAllPoints()
				TaxiFrame:SetPoint(LeaPlusLC["FlightMapA"], UIParent, LeaPlusLC["FlightMapR"], LeaPlusLC["FlightMapX"], LeaPlusLC["FlightMapY"])

				-- Refresh side panel
				TaxiPanel:Hide(); TaxiPanel:Show()

			end)

			-- Show configuration panal when options panel button is clicked
			LeaPlusCB["EnhanceFlightMapBtn"]:SetScript("OnClick", function()
				if LeaPlusLC:PlayerInCombat() then
					return
				else
					if IsShiftKeyDown() and IsControlKeyDown() then
						-- Preset profile
						LeaPlusLC["LeaPlusTaxiMapScale"] = 1.0
						LeaPlusLC["LeaPlusTaxiIconSize"] = 16
						LeaPlusLC["FlightMapA"] = "TOPLEFT"
						LeaPlusLC["FlightMapR"] = "TOPLEFT"
						LeaPlusLC["FlightMapX"] = 16
						LeaPlusLC["FlightMapY"] = -48
						SetFlightMapScale()
						SetFlightMapIconSize()
					else
						TaxiPanel:Show()
						LeaPlusLC:HideFrames()
					end
				end
			end)

			-- Hide the configuration panel if combat starts
			TaxiPanel:SetScript("OnUpdate", function()
				if UnitAffectingCombat("player") then
					TaxiPanel:Hide()
				end
			end)

			-- Move the flight map
			TaxiFrame:SetMovable(true)
			TaxiFrame:RegisterForDrag("LeftButton")
			TaxiFrame:SetScript("OnDragStart", function()
				if IsAltKeyDown() then
					TaxiFrame:StartMoving()
				end
			end)
			TaxiFrame:SetScript("OnDragStop", function()
				TaxiFrame:StopMovingOrSizing()
				TaxiFrame:SetUserPlaced(false)
				LeaPlusLC["FlightMapA"], void, LeaPlusLC["FlightMapR"], LeaPlusLC["FlightMapX"], LeaPlusLC["FlightMapY"] = TaxiFrame:GetPoint()
			end)

			-- ElvUI fixes
			if LeaPlusLC.ElvUI then
				if TaxiFrame.backdrop then
					TaxiFrame:SetHitRectInsets(22, 44, 70, 88)
					TaxiFrame.backdrop:SetAlpha(0)
				end
			end

		end

		----------------------------------------------------------------------
		-- Keep audio synced
		----------------------------------------------------------------------

		if LeaPlusLC["KeepAudioSynced"] == "On" then

			SetCVar("Sound_OutputDriverIndex", "0")
			local event = CreateFrame("FRAME")
			event:RegisterEvent("VOICE_CHAT_OUTPUT_DEVICES_UPDATED")
			event:SetScript("OnEvent", function()
				if not CinematicFrame:IsShown() and not MovieFrame:IsShown() then -- Dont restart sound system during cinematic
					SetCVar("Sound_OutputDriverIndex", "0")
					Sound_GameSystem_RestartSoundSystem()
				end
			end)

		end

		----------------------------------------------------------------------
		-- Mute custom sounds (no reload required)
		----------------------------------------------------------------------

		do

			-- Create configuration panel
			local MuteCustomPanel = LeaPlusLC:CreatePanel("Mute custom sounds", "MuteCustomPanel")

			local titleTX = LeaPlusLC:MakeTx(MuteCustomPanel, "Editor", 16, -72)
			titleTX:SetWidth(534)
			titleTX:SetWordWrap(false)
			titleTX:SetJustifyH("LEFT")

			-- Show help button for title
			LeaPlusLC:CreateHelpButton("MuteGameSoundsCustomHelpButton", MuteCustomPanel, titleTX, "Enter sound file IDs separated by comma then click the Mute button.|n|nIf you wish, you can enter a brief note for each file ID but do not include numbers in your notes.|n|nFor example, you can enter 'DevAura 569679, RetAura 568744' to mute the Devotion Aura and Retribution Aura spells.|n|nUse Leatrix Sounds to find, test and play sound file IDs.")

			-- Add large editbox
			local eb = CreateFrame("Frame", nil, MuteCustomPanel, "BackdropTemplate")
			eb:SetSize(548, LeaPlusLC.MainPanelHeight - 180)
			eb:SetPoint("TOPLEFT", 10, -92)
			eb:SetBackdrop({
				bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
				edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight",
				edgeSize = 16,
				insets = { left = 8, right = 6, top = 8, bottom = 8 },
			})
			eb:SetBackdropBorderColor(1.0, 0.85, 0.0, 0.5)

			eb.scroll = CreateFrame("ScrollFrame", nil, eb, "LeaPlusMuteCustomSoundsScrollFrameTemplate")
			eb.scroll:SetPoint("TOPLEFT", eb, 12, -10)
			eb.scroll:SetPoint("BOTTOMRIGHT", eb, -30, 10)
			eb.scroll:SetPanExtent(16)

			-- Create character count
			eb.scroll.CharCount = eb.scroll:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			eb.scroll.CharCount:Hide()

			eb.Text = eb.scroll.EditBox
			eb.Text:SetWidth(494)
			eb.Text:SetHeight(230)
			eb.Text:SetPoint("TOPLEFT", eb.scroll)
			eb.Text:SetPoint("BOTTOMRIGHT", eb.scroll, -12, 0)
			eb.Text:SetMaxLetters(2000)
			eb.Text:SetFontObject(GameFontNormalLarge)
			eb.Text:SetAutoFocus(false)
			eb.scroll:SetScrollChild(eb.Text)

			-- Set focus on the editbox text when clicking the editbox
			eb:SetScript("OnMouseDown", function()
				eb.Text:SetFocus()
				eb.Text:SetCursorPosition(eb.Text:GetMaxLetters())
			end)

			-- Function to save the custom sound list
			local function SaveString(self, userInput)
				local keytext = eb.Text:GetText()
				if keytext and keytext ~= "" then
					LeaPlusLC["MuteCustomList"] = strtrim(eb.Text:GetText())
				else
					LeaPlusLC["MuteCustomList"] = ""
				end
			end

			-- Save the custom sound list when it changes and at startup
			eb.Text:SetScript("OnTextChanged", SaveString)
			eb.Text:SetText(LeaPlusLC["MuteCustomList"])
			SaveString()

			-- Help button hidden
			MuteCustomPanel.h:Hide()

			-- Back button handler
			MuteCustomPanel.b:SetScript("OnClick", function()
				MuteCustomPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page7"]:Show()
				return
			end)

			-- Reset button hidden
			MuteCustomPanel.r:Hide()

			-- Show configuration panal when options panel button is clicked
			LeaPlusCB["MuteCustomSoundsBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["MuteCustomList"] = "Devotion Aura 569679, Retribution Aura 568744"
					eb.Text:SetText(LeaPlusLC["MuteCustomList"])
				else
					MuteCustomPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

			-- Function to mute custom sound list
			local function MuteCustomListFunc(unmute, userInput)
				-- local mutedebug = true -- Debug
				local counter = 0
				local muteString = LeaPlusLC["MuteCustomList"]
				if muteString and muteString ~= "" then
					muteString = muteString:gsub("%s", ",")
					muteString = muteString:gsub("[\n]", ",")
					muteString = muteString:gsub("[^,%d]", "")
					if mutedebug then print(muteString) end
					local tList = {strsplit(",", muteString)}
					if mutedebug then ChatFrame1:Clear() end
					for i = 1, #tList do
						if tList[i] then
							tList[i] = tonumber(tList[i])
							if tList[i] and tList[i] < 20000000 then
								if mutedebug then print(tList[i]) end
								if unmute then
									UnmuteSoundFile(tList[i])
								else
									MuteSoundFile(tList[i])
								end
								counter = counter + 1
							end
						end
					end
					if userInput then
						if unmute then
							if counter == 1 then
								LeaPlusLC:Print(L["Unmuted"] .. " " .. counter .. " " .. L["sound"] .. ".")
							else
								LeaPlusLC:Print(L["Unmuted"] .. " " .. counter .. " " .. L["sounds"] .. ".")
							end
						else
							if counter == 1 then
								LeaPlusLC:Print(L["Muted"] .. " " .. counter .. " " .. L["sound"] .. ".")
							else
								LeaPlusLC:Print(L["Muted"] .. " " .. counter .. " " .. L["sounds"] .. ".")
							end
						end
					end
				end
			end

			-- Mute custom list on startup if option is enabled
			if LeaPlusLC["MuteCustomSounds"] == "On" then
				MuteCustomListFunc()
			end

			-- Mute or unmute when option is clicked
			LeaPlusCB["MuteCustomSounds"]:HookScript("OnClick", function()
				if LeaPlusLC["MuteCustomSounds"] == "On" then
					MuteCustomListFunc(false, false)
				else
					MuteCustomListFunc(true, false)
				end
			end)

			-- Add mute button
			local MuteCustomNowButton = LeaPlusLC:CreateButton("MuteCustomNowButton", MuteCustomPanel, "Mute", "BOTTOMLEFT", 16, 53, 0, 25, true, "Click to mute sounds in the list.")
			LeaPlusCB["MuteCustomNowButton"]:SetScript("OnClick", function() MuteCustomListFunc(false, true) end)

			-- Add unmute button
			local UnmuteCustomNowButton = LeaPlusLC:CreateButton("UnmuteCustomNowButton", MuteCustomPanel, "Unmute", "BOTTOMLEFT", 16, 53, 0, 25, true, "Click to unmute sounds in the list.")
			LeaPlusCB["UnmuteCustomNowButton"]:ClearAllPoints()
			LeaPlusCB["UnmuteCustomNowButton"]:SetPoint("LEFT", MuteCustomNowButton, "RIGHT", 10, 0)
			LeaPlusCB["UnmuteCustomNowButton"]:SetScript("OnClick", function() MuteCustomListFunc(true, true) end)

			-- Add play sound file editbox
			local willPlay, musicHandle
			local MuteCustomSoundsStopButton = LeaPlusLC:CreateButton("MuteCustomSoundsStopButton", MuteCustomPanel, "Stop", "TOPRIGHT", -18, -66, 0, 25, true, "")
			MuteCustomSoundsStopButton:SetScript("OnClick", function()
				if musicHandle then StopSound(musicHandle) end
			end)

			local MuteCustomSoundsPlayButton = LeaPlusLC:CreateButton("MuteCustomSoundsPlayButton", MuteCustomPanel, "Play", "TOPRIGHT", -18, -66, 0, 25, true, "")
			MuteCustomSoundsPlayButton:ClearAllPoints()
			MuteCustomSoundsPlayButton:SetPoint("RIGHT", MuteCustomSoundsStopButton, "LEFT", -10, 0)

			local MuteCustomSoundsSoundBox = LeaPlusLC:CreateEditBox("MuteCustomSoundsSoundBox", eb, 80, 8, "TOPRIGHT", -10, 20, "PlaySoundBox", "PlaySoundBox")
			MuteCustomSoundsSoundBox:SetNumeric(true)
			MuteCustomSoundsSoundBox:ClearAllPoints()
			MuteCustomSoundsSoundBox:SetPoint("RIGHT", MuteCustomSoundsPlayButton, "LEFT", -10, 0)
			MuteCustomSoundsPlayButton:SetScript("OnClick", function()
				MuteCustomSoundsSoundBox:GetText()
				if musicHandle then StopSound(musicHandle) end
				willPlay, musicHandle = PlaySoundFile(MuteCustomSoundsSoundBox:GetText(), "Master")
			end)

			-- Add mousewheel support to the editbox
			MuteCustomSoundsSoundBox:SetScript("OnMouseWheel", function(self, delta)
				local endSound = tonumber(MuteCustomSoundsSoundBox:GetText())
				if endSound then
					if delta == 1 then endSound = endSound + 1 else endSound = endSound - 1 end
					if endSound < 1 then endSound = 1 elseif endSound >= 10000000 then endSound = 10000000 end
					MuteCustomSoundsSoundBox:SetText(endSound)
					MuteCustomSoundsPlayButton:Click()
				end
			end)

			local titlePlayer = LeaPlusLC:MakeTx(MuteCustomPanel, "Player", 16, -72)
			titlePlayer:ClearAllPoints()
			titlePlayer:SetPoint("TOPLEFT", MuteCustomSoundsSoundBox, "TOPLEFT", -4, 16)
			LeaPlusLC:CreateHelpButton("MuteGameSoundsCustomPlayHelpButton", MuteCustomPanel, titlePlayer, "If you want to listen to a sound file, enter the sound file ID into the editbox and click the play button.|n|nYou can scroll the mousewheel over the editbox to play neighbouring sound files.")
		end

		----------------------------------------------------------------------
		-- Manage vehicle
		----------------------------------------------------------------------

		if LeaPlusLC["ManageVehicle"] == "On" and not LeaLockList["ManageVehicle"] then

			-- Create and manage container for VehicleSeatIndicator
			local vehicleHolder = CreateFrame("Frame", nil, UIParent)
			vehicleHolder:SetPoint("TOP", UIParent, "TOP", 0, -15)
			vehicleHolder:SetSize(128, 128)

			local vehicleContainer = _G.VehicleSeatIndicator
			vehicleContainer:ClearAllPoints()
			vehicleContainer:SetPoint('CENTER', vehicleHolder)
			vehicleContainer:SetIgnoreParentScale(true) -- Needed to keep drag frame position when scaled

			hooksecurefunc(vehicleContainer, 'SetPoint', function(self, void, b)
				if b and (b ~= vehicleHolder) then
					-- Reset parent if it changes from vehicleHolder
					self:ClearAllPoints()
					self:SetPoint('TOPRIGHT', vehicleHolder) -- Has to be TOPRIGHT (drag frame while moving between subzones)
					self:SetParent(vehicleHolder)
				end
			end)

			-- Allow vehicle frame to be moved
			vehicleHolder:SetMovable(true)
			vehicleHolder:SetUserPlaced(true)
			vehicleHolder:SetDontSavePosition(true)
			vehicleHolder:SetClampedToScreen(false)

			-- Set vehicle frame position at startup
			vehicleHolder:ClearAllPoints()
			vehicleHolder:SetPoint(LeaPlusLC["VehicleA"], UIParent, LeaPlusLC["VehicleR"], LeaPlusLC["VehicleX"], LeaPlusLC["VehicleY"])
			vehicleHolder:SetScale(LeaPlusLC["VehicleScale"])
			VehicleSeatIndicator:SetScale(LeaPlusLC["VehicleScale"])

			-- Create drag frame
			local dragframe = CreateFrame("FRAME", nil, nil, "BackdropTemplate")
			dragframe:SetPoint("CENTER", vehicleHolder, "CENTER", 0, 1)
			dragframe:SetBackdropColor(0.0, 0.5, 1.0)
			dragframe:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 16, insets = { left = 0, right = 0, top = 0, bottom = 0}})
			dragframe:SetToplevel(true)
			dragframe:Hide()
			dragframe:SetScale(LeaPlusLC["VehicleScale"])

			dragframe.t = dragframe:CreateTexture()
			dragframe.t:SetAllPoints()
			dragframe.t:SetColorTexture(0.0, 1.0, 0.0, 0.5)
			dragframe.t:SetAlpha(0.5)

			dragframe.f = dragframe:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			dragframe.f:SetPoint('CENTER', 0, 0)
			dragframe.f:SetText(L["Vehicle"])

			-- Click handler
			dragframe:SetScript("OnMouseDown", function(self, btn)
				-- Start dragging if left clicked
				if btn == "LeftButton" then
					vehicleHolder:StartMoving()
				end
			end)

			dragframe:SetScript("OnMouseUp", function()
				-- Save frame position
				vehicleHolder:StopMovingOrSizing()
				LeaPlusLC["VehicleA"], void, LeaPlusLC["VehicleR"], LeaPlusLC["VehicleX"], LeaPlusLC["VehicleY"] = vehicleHolder:GetPoint()
				vehicleHolder:SetMovable(true)
				vehicleHolder:ClearAllPoints()
				vehicleHolder:SetPoint(LeaPlusLC["VehicleA"], UIParent, LeaPlusLC["VehicleR"], LeaPlusLC["VehicleX"], LeaPlusLC["VehicleY"])
			end)

			-- Snap-to-grid
			do
				local frame, grid = dragframe, 10
				local w, h = 120, 128
				local xpos, ypos, scale, uiscale
				frame:RegisterForDrag("RightButton")
				frame:HookScript("OnDragStart", function()
					frame:SetScript("OnUpdate", function()
						scale, uiscale = frame:GetScale(), UIParent:GetScale()
						xpos, ypos = GetCursorPosition()
						xpos = floor((xpos / scale / uiscale) / grid) * grid - w / 2
						ypos = ceil((ypos / scale / uiscale) / grid) * grid + h / 2
						vehicleHolder:ClearAllPoints()
						vehicleHolder:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", xpos, ypos)
					end)
				end)
				frame:HookScript("OnDragStop", function()
					frame:SetScript("OnUpdate", nil)
					frame:GetScript("OnMouseUp")()
				end)
			end

			-- Create configuration panel
			local VehiclePanel = LeaPlusLC:CreatePanel("Manage vehicle", "VehiclePanel")

			LeaPlusLC:MakeTx(VehiclePanel, "Scale", 16, -72)
			LeaPlusLC:MakeSL(VehiclePanel, "VehicleScale", "Drag to set the vehicle seat indicator frame scale.", 0.5, 2, 0.05, 16, -92, "%.2f")

			-- Set scale when slider is changed
			LeaPlusCB["VehicleScale"]:HookScript("OnValueChanged", function()
				vehicleHolder:SetScale(LeaPlusLC["VehicleScale"])
				VehicleSeatIndicator:SetScale(LeaPlusLC["VehicleScale"])
				dragframe:SetScale(LeaPlusLC["VehicleScale"])
				-- Show formatted slider value
				LeaPlusCB["VehicleScale"].f:SetFormattedText("%.0f%%", LeaPlusLC["VehicleScale"] * 100)
			end)

			-- Hide frame alignment grid with panel
			VehiclePanel:HookScript("OnHide", function()
				LeaPlusLC.grid:Hide()
			end)

			-- Toggle grid button
			local VehicleToggleGridButton = LeaPlusLC:CreateButton("VehicleToggleGridButton", VehiclePanel, "Toggle Grid", "TOPLEFT", 16, -72, 0, 25, true, "Click to toggle the frame alignment grid.")
			LeaPlusCB["VehicleToggleGridButton"]:ClearAllPoints()
			LeaPlusCB["VehicleToggleGridButton"]:SetPoint("LEFT", VehiclePanel.h, "RIGHT", 10, 0)
			LeaPlusCB["VehicleToggleGridButton"]:SetScript("OnClick", function()
				if LeaPlusLC.grid:IsShown() then LeaPlusLC.grid:Hide() else LeaPlusLC.grid:Show() end
			end)
			VehiclePanel:HookScript("OnHide", function()
				if LeaPlusLC.grid then LeaPlusLC.grid:Hide() end
			end)

			-- Help button tooltip
			VehiclePanel.h.tiptext = L["Drag the frame overlay with the left button to position it freely or with the right button to position it using snap-to-grid."]

			-- Back button handler
			VehiclePanel.b:SetScript("OnClick", function()
				VehiclePanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page6"]:Show()
				return
			end)

			-- Reset button handler
			VehiclePanel.r:SetScript("OnClick", function()

				-- Reset position and scale
				LeaPlusLC["VehicleA"] = "TOPRIGHT"
				LeaPlusLC["VehicleR"] = "TOPRIGHT"
				LeaPlusLC["VehicleX"] = -100
				LeaPlusLC["VehicleY"] = -192
				LeaPlusLC["VehicleScale"] = 1
				vehicleHolder:ClearAllPoints()
				vehicleHolder:SetPoint(LeaPlusLC["VehicleA"], UIParent, LeaPlusLC["VehicleR"], LeaPlusLC["VehicleX"], LeaPlusLC["VehicleY"])

				-- Refresh configuration panel
				VehiclePanel:Hide(); VehiclePanel:Show()
				dragframe:Show()

				-- Show frame alignment grid
				LeaPlusLC.grid:Show()

			end)

			-- Show configuration panel when options panel button is clicked
			LeaPlusCB["ManageVehicleButton"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["VehicleA"] = "TOPRIGHT"
					LeaPlusLC["VehicleR"] = "TOPRIGHT"
					LeaPlusLC["VehicleX"] = -100
					LeaPlusLC["VehicleY"] = -192
					LeaPlusLC["VehicleScale"] = 1
					vehicleHolder:ClearAllPoints()
					vehicleHolder:SetPoint(LeaPlusLC["VehicleA"], UIParent, LeaPlusLC["VehicleR"], LeaPlusLC["VehicleX"], LeaPlusLC["VehicleY"])
					vehicleHolder:SetScale(LeaPlusLC["VehicleScale"])
					VehicleSeatIndicator:SetScale(LeaPlusLC["VehicleScale"])
				else
					-- Find out if the UI has a non-standard scale
					if GetCVar("useuiscale") == "1" then
						LeaPlusLC["gscale"] = GetCVar("uiscale")
					else
						LeaPlusLC["gscale"] = 1
					end

					-- Set drag frame size according to UI scale
					dragframe:SetWidth(128 * LeaPlusLC["gscale"])
					dragframe:SetHeight(128 * LeaPlusLC["gscale"])

					-- Show configuration panel
					VehiclePanel:Show()
					LeaPlusLC:HideFrames()
					dragframe:Show()

					-- Show frame alignment grid
					LeaPlusLC.grid:Show()
				end
			end)

			-- Hide drag frame when configuration panel is closed
			VehiclePanel:HookScript("OnHide", function() dragframe:Hide() end)

		end

		----------------------------------------------------------------------
		-- Block shared quests (no reload needed)
		----------------------------------------------------------------------

		do

			local eFrame = CreateFrame("FRAME")
			eFrame:SetScript("OnEvent", LeaPlusLC.CheckIfQuestIsSharedAndShouldBeDeclined)

			-- Function to set event
			local function SetSharedQuestsFunc()
				if LeaPlusLC["NoSharedQuests"] == "On" then
					eFrame:RegisterEvent("QUEST_DETAIL")
				else
					eFrame:UnregisterEvent("QUEST_DETAIL")
				end
			end

			-- Set event when option is clicked and on startup
			LeaPlusCB["NoSharedQuests"]:HookScript("OnClick", SetSharedQuestsFunc)
			SetSharedQuestsFunc()

		end

		----------------------------------------------------------------------
		-- Restore chat messages
		----------------------------------------------------------------------

		if LeaPlusLC["RestoreChatMessages"] == "On" and not LeaLockList["RestoreChatMessages"] then

			local historyFrame = CreateFrame("FRAME")
			historyFrame:RegisterEvent("PLAYER_LOGIN")
			historyFrame:RegisterEvent("PLAYER_LOGOUT")

			local FCF_IsChatWindowIndexActive = FCF_IsChatWindowIndexActive
			local GetMessageInfo = GetMessageInfo
			local GetNumMessages = GetNumMessages

			-- Use function from Dragonflight
			local function FCF_IsChatWindowIndexActive(chatWindowIndex)
				local shown = select(7, FCF_GetChatWindowInfo(chatWindowIndex))
				if shown then
					return true
				end
				local chatFrame = _G["ChatFrame" .. chatWindowIndex]
				return (chatFrame and chatFrame.isDocked)
			end

			-- Save chat messages on logout
			historyFrame:SetScript("OnEvent", function(self, event)
				if event == "PLAYER_LOGOUT" then
					local name, realm = UnitFullName("player")
					if not realm then realm = GetNormalizedRealmName() end
					if name and realm then
						LeaPlusDB["ChatHistoryName"] = name .. "-" .. realm
						LeaPlusDB["ChatHistoryTime"] = GetServerTime()
						for i = 1, 50 do
							if i ~= 2 and _G["ChatFrame" .. i] then
								if FCF_IsChatWindowIndexActive(i) then
									LeaPlusDB["ChatHistory" .. i] = {}
									local chtfrm = _G["ChatFrame" .. i]
									local NumMsg = chtfrm:GetNumMessages()
									local StartMsg = 1
									if NumMsg > 256 then StartMsg = NumMsg - 255 end
									for iMsg = StartMsg, NumMsg do
										local chatMessage, r, g, b, chatTypeID = chtfrm:GetMessageInfo(iMsg)
										if chatMessage then
											if r and g and b then
												local colorCode = RGBToColorCode(r, g, b)
												chatMessage = colorCode .. chatMessage
											end
											tinsert(LeaPlusDB["ChatHistory" .. i], chatMessage)
										end
									end
								end
							end
						end
					end
				end
			end)

			-- Restore chat messages on login
			local name, realm = UnitFullName("player")
			if not realm then realm = GetNormalizedRealmName() end
			if name and realm then
				if LeaPlusDB["ChatHistoryName"] and LeaPlusDB["ChatHistoryTime"] then
					local timeDiff = GetServerTime() - LeaPlusDB["ChatHistoryTime"]
					if LeaPlusDB["ChatHistoryName"] == name .. "-" .. realm and timeDiff and timeDiff < 10 then -- reload must be done within 15 seconds

						-- Store chat messages from current session and clear chat
						for i = 1, 50 do
							if i ~= 2 and _G["ChatFrame" .. i] and FCF_IsChatWindowIndexActive(i) then
								LeaPlusDB["ChatTemp" .. i] = {}
								local chtfrm = _G["ChatFrame" .. i]
								local NumMsg = chtfrm:GetNumMessages()
								for iMsg = 1, NumMsg do
									local chatMessage, r, g, b, chatTypeID = chtfrm:GetMessageInfo(iMsg)
									if chatMessage then
										if r and g and b then
											local colorCode = RGBToColorCode(r, g, b)
											chatMessage = colorCode .. chatMessage
										end
										tinsert(LeaPlusDB["ChatTemp" .. i], chatMessage)
									end
								end
								chtfrm:Clear()
							end
						end

						-- Restore chat messages from previous session
						for i = 1, 50 do
							if i ~= 2 and _G["ChatFrame" .. i] and LeaPlusDB["ChatHistory" .. i] and FCF_IsChatWindowIndexActive(i) then
								LeaPlusDB["ChatHistory" .. i .. "Count"] = 0
								-- Add previous session messages to chat
								for k = 1, #LeaPlusDB["ChatHistory" .. i] do
									if LeaPlusDB["ChatHistory" .. i][k] ~= string.match(LeaPlusDB["ChatHistory" .. i][k], "|cffffd800" .. L["Restored"] .. " " .. ".*" .. " " .. L["message"] .. ".*.|r") then
										_G["ChatFrame" .. i]:AddMessage(LeaPlusDB["ChatHistory" .. i][k])
										LeaPlusDB["ChatHistory" .. i .. "Count"] = LeaPlusDB["ChatHistory" .. i .. "Count"] + 1
									end
								end
								-- Show how many messages were restored
								if LeaPlusDB["ChatHistory" .. i .. "Count"] == 1 then
									_G["ChatFrame" .. i]:AddMessage("|cffffd800" .. L["Restored"] .. " " .. LeaPlusDB["ChatHistory" .. i .. "Count"] .. " " .. L["message from previous session"] .. ".|r")
								else
									_G["ChatFrame" .. i]:AddMessage("|cffffd800" .. L["Restored"] .. " " .. LeaPlusDB["ChatHistory" .. i .. "Count"] .. " " .. L["messages from previous session"] .. ".|r")
								end
							else
								-- No messages to restore
								LeaPlusDB["ChatHistory" .. i] = nil
							end
						end

						-- Restore chat messages from this session
						for i = 1, 50 do
							if i ~= 2 and _G["ChatFrame" .. i] and LeaPlusDB["ChatTemp" .. i] and FCF_IsChatWindowIndexActive(i) then
								for k = 1, #LeaPlusDB["ChatTemp" .. i] do
									_G["ChatFrame" .. i]:AddMessage(LeaPlusDB["ChatTemp" .. i][k])
								end
							end
						end

					end
				end
			end

		else

			-- Option is disabled so clear any messages from saved variables
			LeaPlusDB["ChatHistoryName"] = nil
			LeaPlusDB["ChatHistoryTime"] = nil
			for i = 1, 50 do
				LeaPlusDB["ChatHistory" .. i] = nil
				LeaPlusDB["ChatTemp" .. i] = nil
				LeaPlusDB["ChatHistory" .. i .. "Count"] = nil
			end

		end

		----------------------------------------------------------------------
		-- Enhance minimap
		----------------------------------------------------------------------

		if LeaPlusLC["MinimapModder"] == "On" and not LeaLockList["MinimapModder"] then

			local miniFrame = CreateFrame("FRAME")
			local LibDBIconStub = LibStub("LibDBIcon-1.0")

			-- Function to set button radius
			local function SetButtonRad()
				if LeaPlusLC["SquareMinimap"] == "On" then
					LibDBIconStub:SetButtonRadius(26 + ((LeaPlusLC["MinimapSize"] - 140) * 0.165))
				else
					LibDBIconStub:SetButtonRadius(1)
				end
			end

			-- Disable mouse on invisible minimap cluster
			MinimapCluster:EnableMouse(false)

			-- Ensure consolidated buffs frame is not over minimap or buttons
			ConsolidatedBuffs:SetFrameStrata("LOW") -- Same as BuffFrame

			----------------------------------------------------------------------
			-- Configuration panel
			----------------------------------------------------------------------

			-- Create configuration panel
			local SideMinimap = LeaPlusLC:CreatePanel("Enhance minimap", "SideMinimap")

			-- Hide panel during combat
			SideMinimap:SetScript("OnUpdate", function()
				if UnitAffectingCombat("player") then
					SideMinimap:Hide()
				end
			end)

			-- Add checkboxes
			LeaPlusLC:MakeTx(SideMinimap, "Settings", 16, -72)
			LeaPlusLC:MakeCB(SideMinimap, "HideMiniZoomBtns", "Hide the zoom buttons", 16, -92, false, "If checked, the zoom buttons will be hidden.  You can use the mousewheel to zoom regardless of this setting.")
			LeaPlusLC:MakeCB(SideMinimap, "HideMiniZoneText", "Hide the zone text bar", 16, -112, false, "If checked, the zone text bar will be hidden.")
			LeaPlusLC:MakeCB(SideMinimap, "HideMiniMapButton", "Hide the world map button", 16, -132, false, "If checked, the world map button will be hidden.")
			LeaPlusLC:MakeCB(SideMinimap, "HideMiniTracking", "Hide the tracking button", 16, -152, true, "If checked, the tracking button will be hidden while the pointer is not over the minimap.")
			LeaPlusLC:MakeCB(SideMinimap, "HideMiniAddonButtons", "Hide addon buttons", 16, -172, false, "If checked, addon buttons will be hidden while the pointer is not over the minimap.")
			LeaPlusLC:MakeCB(SideMinimap, "CombineAddonButtons", "Combine addon buttons", 16, -192, true, "If checked, addon buttons will be combined into a single button frame which you can toggle by right-clicking the minimap.|n|nNote that enabling this option will lock out the 'Hide addon buttons' setting.")
			LeaPlusLC:MakeCB(SideMinimap, "SquareMinimap", "Square minimap", 16, -212, true, "If checked, the minimap shape will be square.")
			LeaPlusLC:MakeCB(SideMinimap, "ShowWhoPinged", "Show who pinged", 16, -232, false, "If checked, when someone pings the minimap, their name will be shown.  This does not apply to your pings.")

			-- Add excluded button
			local MiniExcludedButton = LeaPlusLC:CreateButton("MiniExcludedButton", SideMinimap, "Buttons", "TOPLEFT", 16, -72, 0, 25, true, "Click to toggle the addon buttons editor.")
			LeaPlusCB["MiniExcludedButton"]:ClearAllPoints()
			LeaPlusCB["MiniExcludedButton"]:SetPoint("LEFT", SideMinimap.h, "RIGHT", 10, 0)

			-- Set exclude button visibility
			local function SetExcludeButtonsFunc()
				if LeaPlusLC["HideMiniAddonButtons"] == "On" or LeaPlusLC["CombineAddonButtons"] == "On" then
					LeaPlusLC:LockItem(LeaPlusCB["MiniExcludedButton"], false)
				else
					LeaPlusLC:LockItem(LeaPlusCB["MiniExcludedButton"], true)
				end
			end
			LeaPlusCB["HideMiniAddonButtons"]:HookScript("OnClick", SetExcludeButtonsFunc)
			SetExcludeButtonsFunc()

			-- Add slider controls
			LeaPlusLC:MakeTx(SideMinimap, "Scale", 356, -72)
			LeaPlusLC:MakeSL(SideMinimap, "MinimapScale", "Drag to set the minimap scale.|n|nAdjusting this slider makes the minimap and all the elements bigger.", 0.5, 4, 0.1, 356, -82, "%.2f")

			LeaPlusLC:MakeTx(SideMinimap, "Square size", 356, -122)
			LeaPlusLC:MakeSL(SideMinimap, "MinimapSize", "Drag to set the square minimap size.|n|nAdjusting this slider makes the minimap bigger but keeps the elements the same size.", 140, 560, 1, 356, -132, "%.0f")

			LeaPlusLC:MakeTx(SideMinimap, "Border width", 356, -172)
			LeaPlusLC:MakeSL(SideMinimap, "MinimapBorderWidth", "Drag to set the square minimap border width.", 1, 10, 1, 356, -182, "%.0f")

			LeaPlusLC:MakeTx(SideMinimap, "Cluster scale", 356, -222)
			LeaPlusLC:MakeSL(SideMinimap, "MiniClusterScale", "Drag to set the cluster scale.|n|nNote: Adjusting the cluster scale affects the entire cluster including frames attached to it such as the quest watch frame.|n|nIt will also cause the default UI right-side action bars to scale when you login.  If you use the default UI right-side action bars, you may want to leave this at 100%.", 1, 2, 0.1, 356, -232, "%.2f")

			LeaPlusLC:MakeCB(SideMinimap, "MinimapNoScale", "Not minimap", 356, -252, false, "If checked, adjusting the cluster scale will not affect the minimap scale.")

			----------------------------------------------------------------------
			-- Addon buttons editor
			----------------------------------------------------------------------

			do

				-- Create configuration panel
				local ExcludedButtonsPanel = LeaPlusLC:CreatePanel("Enhance minimap", "ExcludedButtonsPanel")

				local titleTX = LeaPlusLC:MakeTx(ExcludedButtonsPanel, "Buttons for the addons listed below will remain visible.", 16, -72)
				titleTX:SetWidth(534)
				titleTX:SetWordWrap(false)
				titleTX:SetJustifyH("LEFT")

				-- Add second excluded button
				local MiniExcludedButton2 = LeaPlusLC:CreateButton("MiniExcludedButton2", ExcludedButtonsPanel, "Buttons", "TOPLEFT", 16, -72, 0, 25, true, "Click to toggle the addon buttons editor.")
				LeaPlusCB["MiniExcludedButton2"]:ClearAllPoints()
				LeaPlusCB["MiniExcludedButton2"]:SetPoint("LEFT", ExcludedButtonsPanel.h, "RIGHT", 10, 0)
				LeaPlusCB["MiniExcludedButton2"]:SetScript("OnClick", function()
					ExcludedButtonsPanel:Hide(); SideMinimap:Show()
					return
				end)

				-- Add large editbox
				local eb = CreateFrame("Frame", nil, ExcludedButtonsPanel, "BackdropTemplate")
				eb:SetSize(548, LeaPlusLC.MainPanelHeight - 180)
				eb:SetPoint("TOPLEFT", 10, -92)
				eb:SetBackdrop({
					bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
					edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight",
					edgeSize = 16,
					insets = { left = 8, right = 6, top = 8, bottom = 8 },
				})
				eb:SetBackdropBorderColor(1.0, 0.85, 0.0, 0.5)

				eb.scroll = CreateFrame("ScrollFrame", nil, eb, "LeaPlusEnhanceMinimapExcludeButtonsScrollFrameTemplate")
				eb.scroll:SetPoint("TOPLEFT", eb, 12, -10)
				eb.scroll:SetPoint("BOTTOMRIGHT", eb, -30, 10)
				eb.scroll:SetPanExtent(16)

				-- Create character count
				eb.scroll.CharCount = eb.scroll:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
				eb.scroll.CharCount:Hide()

				eb.Text = eb.scroll.EditBox
				eb.Text:SetWidth(494)
				eb.Text:SetHeight(230)
				eb.Text:SetPoint("TOPLEFT", eb.scroll)
				eb.Text:SetPoint("BOTTOMRIGHT", eb.scroll, -12, 0)
				eb.Text:SetMaxLetters(1200)
				eb.Text:SetFontObject(GameFontNormalLarge)
				eb.Text:SetAutoFocus(false)
				eb.scroll:SetScrollChild(eb.Text)

				-- Set focus on the editbox text when clicking the editbox
				eb:SetScript("OnMouseDown", function()
					eb.Text:SetFocus()
					eb.Text:SetCursorPosition(eb.Text:GetMaxLetters())
				end)

				-- Debug
				-- eb.Text:SetText("Leatrix_Plus\nLeatrix_Maps\nBugSack\nLeatrix_Plus\nLeatrix_Maps\nBugSack\nLeatrix_Plus\nLeatrix_Maps\nBugSack\nLeatrix_Plus\nLeatrix_Maps\nBugSack\nLeatrix_Plus\nLeatrix_Maps\nBugSack")

				-- Function to save the excluded list
				local function SaveString(self, userInput)
					local keytext = eb.Text:GetText()
					if keytext and keytext ~= "" then
						LeaPlusLC["MiniExcludeList"] = strtrim(eb.Text:GetText())
					else
						LeaPlusLC["MiniExcludeList"] = ""
					end
					if userInput then
						LeaPlusLC:ReloadCheck()
					end
				end

				-- Save the excluded list when it changes and at startup
				eb.Text:SetScript("OnTextChanged", SaveString)
				eb.Text:SetText(LeaPlusLC["MiniExcludeList"])
				SaveString()

				-- Help button tooltip
				ExcludedButtonsPanel.h.tiptext = L["If you use the 'Hide addon buttons' or 'Combine addon buttons' settings but you want some addon buttons to remain visible around the minimap, enter the addon names into the editbox separated by a comma.|n|nThe editbox tooltip shows the addon names that you can enter.  The names must match exactly with the names shown in the editbox tooltip though case does not matter.|n|nChanges to the list will require a UI reload to take effect."]

				-- Back button handler
				ExcludedButtonsPanel.b:SetScript("OnClick", function()
					ExcludedButtonsPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page5"]:Show()
					return
				end)

				-- Reset button handler
				ExcludedButtonsPanel.r:SetScript("OnClick", function()

					-- Reset controls
					LeaPlusLC["MiniExcludeList"] = ""
					eb.Text:SetText(LeaPlusLC["MiniExcludeList"])

					-- Refresh configuration panel
					ExcludedButtonsPanel:Hide(); ExcludedButtonsPanel:Show()
					LeaPlusLC:ReloadCheck()

				end)

				-- Show configuration panal when options panel button is clicked
				LeaPlusCB["MiniExcludedButton"]:SetScript("OnClick", function()
					if IsShiftKeyDown() and IsControlKeyDown() then
						-- Preset profile
						LeaPlusLC["MiniExcludeList"] = "BugSack, Leatrix_Plus"
						LeaPlusLC:ReloadCheck()
					else
						ExcludedButtonsPanel:Show()
						LeaPlusGlobalPanel_SideMinimap:Hide()
					end
				end)

				-- Function to make tooltip string with list of addons
				local function MakeAddonString()
					local msg = ""
					local numAddons = C_AddOns.GetNumAddOns()
					for i = 1, numAddons do
						if C_AddOns.IsAddOnLoaded(i) then
							local name = C_AddOns.GetAddOnInfo(i)
							if name and _G["LibDBIcon10_" .. name] then -- Only list LibDBIcon buttons
								msg = msg .. name .. ", "
							end
						end
					end
					if msg ~= "" then
						msg = L["Supported Addons"] .. "|n|n" .. msg:sub(1, (strlen(msg) - 2)) .. "."
					else
						msg = L["No supported addons."]
					end
					eb.tiptext = msg
					eb.Text.tiptext = msg
				end

				-- Show the help button tooltip for the editbox too
				eb:SetScript("OnEnter", MakeAddonString)
				eb:HookScript("OnEnter", LeaPlusLC.TipSee)
				eb:SetScript("OnLeave", GameTooltip_Hide)
				eb.Text:SetScript("OnEnter", MakeAddonString)
				eb.Text:HookScript("OnEnter", LeaPlusLC.ShowDropTip)
				eb.Text:SetScript("OnLeave", GameTooltip_Hide)

			end

			----------------------------------------------------------------------
			-- Show who pinged
			----------------------------------------------------------------------

			do

				-- Create frame
				local pFrame = CreateFrame("FRAME", nil, Minimap, "BackdropTemplate")
				pFrame:SetSize(100, 20)

				-- Set position
				if LeaPlusLC["SquareMinimap"] == "On" then
					pFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 0, -3)
				else
					pFrame:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 2)
				end

				-- Set backdrop
				pFrame.bg = {
					bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
					edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
					insets = {left = 4, top = 4, right = 4, bottom = 4},
					edgeSize = 16,
					tile = true,
				}

				pFrame:SetBackdrop(pFrame.bg)
				pFrame:SetBackdropColor(0, 0, 0, 0.7)
				pFrame:SetBackdropBorderColor(0, 0, 0, 0)

				-- Create fontstring
				pFrame.f = pFrame:CreateFontString(nil, nil, "GameFontNormalSmall")
				pFrame.f:SetAllPoints()
				pFrame:Hide()

				-- Set variables
				local pingTime
				local lastUnit, lastX, lastY = "player", 0, 0

				-- Show who pinged
				pFrame:SetScript("OnEvent", function(void, void, unit, x, y)

					-- Do nothing if unit has not changed
					if UnitIsUnit(unit, "player") or UnitIsUnit(unit, lastUnit) and x == lastX and y == lastY then return end
					lastUnit, lastX, lastY = unit, x, y

					-- Show name in class color
					local void, class = UnitClass(unit)
					if class then
						local color = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
						if color then

							-- Set frame details
							pFrame.f:SetFormattedText("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, UnitName(unit))
							pFrame:SetSize(pFrame.f:GetUnboundedStringWidth() + 12, 20)

							-- Hide frame after 5 seconds
							pFrame:Show()
							pingTime = GetTime()
							C_Timer.After(5, function()
								if GetTime() - pingTime >= 5 then
								pFrame:Hide()
								end
							end)

						end
					end

				end)

				-- Set event when option is clicked and on startup
				local function SetPingFunc()
					if LeaPlusLC["ShowWhoPinged"] == "On" then
						pFrame:RegisterEvent("MINIMAP_PING")
					else
						pFrame:UnregisterEvent("MINIMAP_PING")
						if pFrame:IsShown() then pFrame:Hide() end
					end
				end

				LeaPlusCB["ShowWhoPinged"]:HookScript("OnClick", SetPingFunc)
				SetPingFunc()

			end

			----------------------------------------------------------------------
			-- Minimap scale
			----------------------------------------------------------------------

			-- Function to set the minimap cluster scale
			local function SetClusterScale()
				MinimapCluster:SetScale(LeaPlusLC["MiniClusterScale"])
				-- Set slider formatted text
				LeaPlusCB["MiniClusterScale"].f:SetFormattedText("%.0f%%", LeaPlusLC["MiniClusterScale"] * 100)
			end

			-- Set minimap scale when slider is changed and on startup
			LeaPlusCB["MiniClusterScale"]:HookScript("OnValueChanged", SetClusterScale)
			SetClusterScale()

			----------------------------------------------------------------------
			-- Minimap size
			----------------------------------------------------------------------

			if LeaPlusLC["SquareMinimap"] == "On" then

				-- Function to set minimap size
				local function SetMinimapSize()
					-- Set minimap size
					Minimap:SetSize(LeaPlusLC["MinimapSize"], LeaPlusLC["MinimapSize"])
					-- Refresh minimap
					if Minimap:GetZoom() ~= 5 then
						Minimap:SetZoom(Minimap:GetZoom() + 1)
						Minimap:SetZoom(Minimap:GetZoom() - 1)
					else
						Minimap:SetZoom(Minimap:GetZoom() - 1)
						Minimap:SetZoom(Minimap:GetZoom() + 1)
					end
					-- Refresh addon button radius
					SetButtonRad()
					-- Update slider text
					LeaPlusCB["MinimapSize"].f:SetFormattedText("%.0f%%", (LeaPlusLC["MinimapSize"] / 140) * 100)
				end

				-- Set minimap size when slider is changed and on startup
				LeaPlusCB["MinimapSize"]:HookScript("OnValueChanged", SetMinimapSize)
				SetMinimapSize()

				-- Assign file level scope (for reset and preset)
				LeaPlusLC.SetMinimapSize = SetMinimapSize

			else

				-- Square minimap is disabled so lock the size slider
				LeaPlusLC:LockItem(LeaPlusCB["MinimapSize"], true)
				LeaPlusCB["MinimapSize"].tiptext = LeaPlusCB["MinimapSize"].tiptext .. "|cff00AAFF|n|n" .. L["This slider requires 'Square minimap' to be enabled."] .. "|r"

			end

			----------------------------------------------------------------------
			-- Combine addon buttons
			----------------------------------------------------------------------

			if LeaPlusLC["CombineAddonButtons"] == "On" then

				-- Lock out hide minimap buttons
				LeaPlusLC:LockItem(LeaPlusCB["HideMiniAddonButtons"], true)
				LeaPlusCB["HideMiniAddonButtons"].tiptext = LeaPlusCB["HideMiniAddonButtons"].tiptext .. "|n|n|cff00AAFF" .. L["Cannot be used with Combine addon buttons."]

				-- Create button frame (parenting to cluster ensures bFrame scales correctly)
				local bFrame = CreateFrame("FRAME", nil, MinimapCluster, "BackdropTemplate")
				bFrame:ClearAllPoints()
				bFrame:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 4, 4)
				bFrame:Hide()
				bFrame:SetFrameLevel(8)

				LeaPlusLC.bFrame = bFrame -- Used in LibDBIcon callback
				_G["LeaPlusGlobalMinimapCombinedButtonFrame"] = bFrame -- For third party addons

				-- Hide button frame automatically
				local ButtonFrameTicker
				bFrame:HookScript("OnShow", function()
					if ButtonFrameTicker then ButtonFrameTicker:Cancel() end
					ButtonFrameTicker = C_Timer.NewTicker(2, function()
						if ItemRackMenuFrame and ItemRackMenuFrame:IsShown() and ItemRackMenuFrame:IsMouseOver() then return end
						if not bFrame:IsMouseOver() and not Minimap:IsMouseOver() then
							bFrame:Hide()
							if ButtonFrameTicker then ButtonFrameTicker:Cancel() end
						end
					end, 15)
				end)

				-- Match scale with minimap
				if LeaPlusLC["SquareMinimap"] == "On" then
					bFrame:SetScale(LeaPlusLC["MinimapScale"] * 0.75)
				else
					bFrame:SetScale(LeaPlusLC["MinimapScale"])
				end
				LeaPlusCB["MinimapScale"]:HookScript("OnValueChanged", function()
					if LeaPlusLC["SquareMinimap"] == "On" then
						bFrame:SetScale(LeaPlusLC["MinimapScale"] * 0.75)
					else
						bFrame:SetScale(LeaPlusLC["MinimapScale"])
					end
				end)

				-- Position LibDBIcon tooltips when shown
				LibDBIconTooltip:HookScript("OnShow", function()
					GameTooltip:Hide()
					LibDBIconTooltip:ClearAllPoints()
					if bFrame:GetPoint() == "BOTTOMLEFT" then
						LibDBIconTooltip:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, -6)
					else
						LibDBIconTooltip:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -6)
					end
				end)

				-- Function to position GameTooltip below the minimap
				local function SetButtonTooltip()
					GameTooltip:ClearAllPoints()
					if bFrame:GetPoint() == "BOTTOMLEFT" then
						GameTooltip:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, -6)
					else
						GameTooltip:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -6)
					end
				end

				LeaPlusLC.SetButtonTooltip = SetButtonTooltip -- Used in LibDBIcon callback

				-- Hide existing LibDBIcon icons
				local buttons = LibDBIconStub:GetButtonList()
				for i = 1, #buttons do
					local button = LibDBIconStub:GetMinimapButton(buttons[i])
					local buttonName = strlower(buttons[i])
					if not strfind(strlower(LeaPlusDB["MiniExcludeList"]), buttonName) then
						button:Hide()
						button:SetScript("OnShow", function() if not bFrame:IsShown() then button:Hide() end end)
						-- Create background texture
						local bFrameBg = button:CreateTexture(nil, "BACKGROUND")
						bFrameBg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
						bFrameBg:SetPoint("CENTER")
						bFrameBg:SetSize(30, 30)
						bFrameBg:SetVertexColor(0, 0, 0, 0.5)
					elseif strfind(strlower(LeaPlusDB["MiniExcludeList"]), buttonName) and LeaPlusLC["SquareMinimap"] == "On" then
						button:SetScale(0.75)
					end
					-- Move GameTooltip to below the minimap in case the button uses it
					button:HookScript("OnEnter", SetButtonTooltip)
					-- Special case for MoveAny because it doesn't have button.db
					if buttonName == "moveany" then
						button.db = button.db or {}
						if not button.db.hide then button.db.hide = false end
					end
				end

				-- Hide new LibDBIcon icons
				-- LibDBIcon_IconCreated: Done in LibDBIcon callback function

				-- Toggle button frame
				Minimap:SetScript("OnMouseUp", function(frame, button)
					if button == "RightButton" then
						if bFrame:IsShown() then
							bFrame:Hide()
						else bFrame:Show()
							-- Position button frame
							local side
							local m = Minimap:GetCenter()
							local b = Minimap:GetEffectiveScale()
							local w = GetScreenWidth()
							local s = UIParent:GetEffectiveScale()
							bFrame:ClearAllPoints()
							if m * b > (w * s / 2) then
								side = "Right"
								bFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMLEFT", -10, -0)
							else
								side = "Left"
								bFrame:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMRIGHT", 10, 0)
							end
							-- Show button frame
							local x, y, row, col = 0, 0, 0, 0
							local buttons = LibDBIconStub:GetButtonList()
							-- Sort the button table
							table.sort(buttons, function(a, b)
								if string.find(a, "LeaPlusCustomIcon_") then
									a = string.gsub(a, "LeaPlusCustomIcon_", "")
								end
								if string.find(b, "LeaPlusCustomIcon_") then
									b = string.gsub(b, "LeaPlusCustomIcon_", "")
								end
								return a:lower() < b:lower()
							end)
							-- Calculate buttons per row
							local buttonsPerRow
							local totalButtons = #buttons
								if totalButtons > 36 then buttonsPerRow = 10
							elseif totalButtons > 32 then buttonsPerRow = 9
							elseif totalButtons > 28 then buttonsPerRow = 8
							elseif totalButtons > 24 then buttonsPerRow = 7
							elseif totalButtons > 20 then buttonsPerRow = 6
							elseif totalButtons > 16 then buttonsPerRow = 5
							elseif totalButtons > 12 then buttonsPerRow = 4
							elseif totalButtons > 8 then buttonsPerRow = 3
							elseif totalButtons > 4 then buttonsPerRow = 2
							else
								buttonsPerRow = 1
							end
							-- Build button grid
							for i = 1, totalButtons do
								local buttonName = strlower(buttons[i])
								if not strfind(strlower(LeaPlusDB["MiniExcludeList"]), buttonName) then
									local button = LibDBIconStub:GetMinimapButton(buttons[i])
									if button.db then
										if buttonName == "armory" then button.db.hide = false end -- Armory addon sets hidden to true
										if not button.db.hide then
											button:SetParent(bFrame)
											button:ClearAllPoints()
											if side == "Left" then
												-- Minimap is on left side of screen
												button:SetPoint("TOPLEFT", bFrame, "TOPLEFT", x, y)
												col = col + 1; if col >= buttonsPerRow then col = 0; row = row + 1; x = 0; y = y - 30 else x = x + 30 end
											else
												-- Minimap is on right side of screen (changed from TOPRIGHT to TOPLEFT and x - 30 to x + 30 to make sorting work)
												button:SetPoint("TOPLEFT", bFrame, "TOPLEFT", x, y)
												col = col + 1; if col >= buttonsPerRow then col = 0; row = row + 1; x = 0; y = y - 30 else x = x + 30 end
											end
											if totalButtons <= buttonsPerRow then
												bFrame:SetWidth(totalButtons * 30)
											else
												bFrame:SetWidth(buttonsPerRow * 30)
											end
											local void, void, void, void, e = button:GetPoint()
											bFrame:SetHeight(0 - e + 30)
											LibDBIconStub:Show(buttons[i])
										end
									end
								end
							end
						end
					else
						Minimap_OnClick(frame, button)
					end
				end)

			end

			----------------------------------------------------------------------
			-- Square minimap
			----------------------------------------------------------------------

			if LeaPlusLC["SquareMinimap"] == "On" then

				-- Set minimap shape
				_G.GetMinimapShape = function() return "SQUARE" end

				-- Create black border around map
				local miniBorder = CreateFrame("Frame", nil, Minimap, "BackdropTemplate")
				miniBorder:SetAlpha(0.8)

				-- Adjust border width using slider control
				local function SetMinimapBorderWidth()
					miniBorder:ClearAllPoints()
					miniBorder:SetPoint("TOPLEFT", -LeaPlusLC["MinimapBorderWidth"], LeaPlusLC["MinimapBorderWidth"])
					miniBorder:SetPoint("BOTTOMRIGHT", LeaPlusLC["MinimapBorderWidth"], -LeaPlusLC["MinimapBorderWidth"])
					miniBorder:SetBackdrop({
						edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
						edgeSize = LeaPlusLC["MinimapBorderWidth"],
					})
				end

				-- Set border width when slider is changed and on startup
				LeaPlusCB["MinimapBorderWidth"]:HookScript("OnValueChanged", SetMinimapBorderWidth)
				SetMinimapBorderWidth()

				-- Hide the default border
				MinimapBorder:Hide()

				-- Mask texture
				Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

				-- Hide the North tag
				hooksecurefunc(MinimapNorthTag, "Show", function()
					MinimapNorthTag:Hide()
				end)
				MinimapNorthTag:Hide()

				-- Tracking button
				MiniMapTracking:SetScale(0.75)
				miniFrame.ClearAllPoints(MiniMapTracking)
				MiniMapTracking:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -20, -40)

				-- Mail button
				MiniMapMailFrame:SetScale(0.75)
				miniFrame.ClearAllPoints(MiniMapMailFrame)
				MiniMapMailFrame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -19, -75)

				-- Battleground queue button
				MiniMapBattlefieldFrame:SetScale(0.75)
				miniFrame.ClearAllPoints(MiniMapBattlefieldFrame)
				MiniMapBattlefieldFrame:SetPoint("TOP", MiniMapMailFrame, "BOTTOM", 0, 0)

				-- Looking For Group button
				MiniMapLFGFrame:SetScale(0.75)
				MiniMapLFGFrame:ClearAllPoints()
				MiniMapLFGFrame:SetPoint("TOP", MiniMapBattlefieldFrame, "BOTTOM", 0, 0)

				-- World map button
				MiniMapWorldMapButton:SetScale(0.75)
				MiniMapWorldMapButton:ClearAllPoints()
				MiniMapWorldMapButton:SetPoint("BOTTOM", MinimapZoomIn, "TOP", 0, 0)

				-- Zoom in button
				MinimapZoomIn:SetScale(0.75)
				miniFrame.ClearAllPoints(MinimapZoomIn)
				MinimapZoomIn:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 19, -120)

				-- Zoom out button
				MinimapZoomOut:SetScale(0.75)
				miniFrame.ClearAllPoints(MinimapZoomOut)
				MinimapZoomOut:SetPoint("TOP", MinimapZoomIn, "BOTTOM", 0, 0)

				-- Calendar button
				miniFrame.ClearAllPoints(GameTimeFrame)
				GameTimeFrame:SetPoint("BOTTOM", MiniMapWorldMapButton, "TOP", 0, 2)
				GameTimeFrame:SetParent(MinimapBackdrop)
				GameTimeFrame:SetScale(0.75)
				GameTimeFrame:SetSize(32, 32)

				-- Debug buttons
				local LeaPlusMiniMapDebug = nil
				if LeaPlusMiniMapDebug then
					C_Timer.After(2, function()
						MiniMapMailFrame:Show()
						MiniMapBattlefieldFrame:Show()
						MiniMapWorldMapButton:Show()
						-- GameTimeFrame:Show()
						MiniMapLFGFrame:Show()
					end)
				end

				-- Rescale addon buttons if combine addon buttons is disabled
				if LeaPlusLC["CombineAddonButtons"] == "Off" then
					-- Scale existing buttons
					local buttons = LibDBIconStub:GetButtonList()
					for i = 1, #buttons do
						local button = LibDBIconStub:GetMinimapButton(buttons[i])
						button:SetScale(0.75)
					end
					-- Scale new buttons
					-- LibDBIcon_IconCreated: Done in LiBDBIcon callback function
				end

				-- Refresh buttons
				C_Timer.After(0.1, SetButtonRad)

			else

				-- Square minimap is disabled so use round shape
				_G.GetMinimapShape = function() return "ROUND" end
				Minimap:SetMaskTexture([[Interface\CharacterFrame\TempPortraitAlphaMask]])

				-- Calendar button
				miniFrame.ClearAllPoints(GameTimeFrame)
				GameTimeFrame:SetPoint("TOPRIGHT", MinimapBackdrop, "TOPRIGHT", -11, 4)
				GameTimeFrame:SetParent(MinimapBackdrop)

				-- World map button
				miniFrame.ClearAllPoints(MiniMapWorldMapButton)
				LibDBIconStub:SetButtonToPosition(MiniMapWorldMapButton, 20)

				-- Square minimap is disabled so disable border width slider
				LeaPlusLC:LockItem(LeaPlusCB["MinimapBorderWidth"], true)
				LeaPlusCB["MinimapBorderWidth"].tiptext = LeaPlusCB["MinimapBorderWidth"].tiptext .. "|cff00AAFF|n|n" .. L["This slider requires 'Square minimap' to be enabled."] .. "|r"

			end

			----------------------------------------------------------------------
			-- Replace non-standard buttons
			----------------------------------------------------------------------

			-- Replace non-standard buttons for addons that don't use the standard LibDBIcon library
			do

				-- Make custom LibDBIcon buttons for addons that don't use LibDBIcon
				local CustomAddonTable = {}
				LeaPlusDB["CustomAddonButtons"] = LeaPlusDB["CustomAddonButtons"] or {}

				-- Function to create a LibDBIcon button
				local function CreateBadButton(name)

					-- Get non-standard button texture
					local finalTex = "Interface\\HELPFRAME\\HelpIcon-KnowledgeBase"

					if _G[name .. "Icon"] then
						if _G[name .. "Icon"]:GetObjectType() == "Texture" then
							local gTex = _G[name .. "Icon"]:GetTexture()
							if gTex then
								finalTex = gTex
							end
						end
					else
						for i = 1, select('#', _G[name]:GetRegions()) do
							local region = select(i, _G[name]:GetRegions())
							if region.GetTexture then
								local x, y = region:GetSize()
								if x and x < 30 then
									finalTex = region:GetTexture()
								end
							end
						end
					end

					if not finalTex then finalTex = "Interface\\HELPFRAME\\HelpIcon-KnowledgeBase" end

					-- Function to anchor the tooltip to the custom button or the minimap
					local function ReanchorTooltip(tip, myButton)
						tip:ClearAllPoints()
						if LeaPlusLC["CombineAddonButtons"] == "On" then
							if LeaPlusLC.bFrame and LeaPlusLC.bFrame:GetPoint() == "BOTTOMLEFT" then
								tip:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, -6)
							else
								tip:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -6)
							end
						else
							if Minimap:GetCenter() * Minimap:GetEffectiveScale() > (GetScreenWidth() * UIParent:GetEffectiveScale() / 2) then
								tip:SetPoint("TOPRIGHT", myButton, "BOTTOMRIGHT", 0, -6)
							else
								tip:SetPoint("TOPLEFT", myButton, "BOTTOMLEFT", 0, -6)
							end
						end
					end

					local zeroButton = LibStub("LibDataBroker-1.1"):NewDataObject("LeaPlusCustomIcon_" .. name, {
						type = "data source",
						text = name,
						icon = finalTex,
						OnClick = function(self, btn)
							if _G[name] then
								if string.find(name, "LibDBIcon") then
									-- It's a fake LibDBIcon
									local mouseUp = _G[name]:GetScript("OnMouseUp")
									if mouseUp then
										mouseUp(self, btn)
									end
								else
									-- It's a genuine LibDBIcon
									local clickUp = _G[name]:GetScript("OnClick")
									if clickUp then
										_G[name]:Click(btn)
									end
								end
							end
						end,
					})
					LeaPlusDB["CustomAddonButtons"][name] = LeaPlusDB["CustomAddonButtons"][name] or {}
					LeaPlusDB["CustomAddonButtons"][name].hide = false
					CustomAddonTable[name] = name
					local icon = LibStub("LibDBIcon-1.0", true)
					icon:Register("LeaPlusCustomIcon_" .. name, zeroButton, LeaPlusDB["CustomAddonButtons"][name])
					-- Custom buttons
					if name == "AllTheThings-Minimap" then
						-- AllTheThings
						local myButton = LibStub("LibDBIcon-1.0"):GetMinimapButton("LeaPlusCustomIcon_" .. name)
						myButton.icon:SetTexture("Interface\\AddOns\\AllTheThings\\assets\\logo_tiny")
						myButton:HookScript("OnEnter", function()
							_G[name]:GetScript("OnEnter")(_G[name], true)
							ReanchorTooltip(GameTooltip, myButton)
						end)
						myButton:HookScript("OnLeave", function()
							_G[name]:GetScript("OnLeave")()
						end)
					elseif name == "AltoholicMinimapButton" then
						-- Altoholic
						local myButton = LibStub("LibDBIcon-1.0"):GetMinimapButton("LeaPlusCustomIcon_" .. name)
						myButton.icon:SetTexture("Interface\\Icons\\INV_Drink_13")
						myButton:HookScript("OnEnter", function()
							_G[name]:GetScript("OnEnter")(_G[name], true)
							ReanchorTooltip(AltoTooltip, myButton)
						end)
						myButton:HookScript("OnLeave", function()
							_G[name]:GetScript("OnLeave")()
						end)
					elseif name == "Narci_MinimapButton" then
						-- Narcissus
						local myButton = LibStub("LibDBIcon-1.0"):GetMinimapButton("LeaPlusCustomIcon_" .. name)
						myButton.icon:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Minimap\\LOGO-Dragonflight")
						myButton:HookScript("OnEnter", function()
							_G[name]:GetScript("OnEnter")(_G[name], true)
						end)
						hooksecurefunc(myButton.icon, "UpdateCoord", function()
							myButton.icon:SetTexCoord(0, 0.25, 0.75, 1)
						end)
						myButton.icon:SetTexCoord(0, 0.25, 0.75, 1)
					elseif name == "WIM3MinimapButton" then
						-- WIM
						local myButton = LibStub("LibDBIcon-1.0"):GetMinimapButton("LeaPlusCustomIcon_" .. name)
						myButton:HookScript("OnEnter", function()
							_G[name]:GetScript("OnEnter")(_G[name], true)
							GameTooltip:SetOwner(myButton, "ANCHOR_TOP")
							GameTooltip:AddLine(name)
							GameTooltip:Show()
							ReanchorTooltip(GameTooltip, myButton)
						end)
						myButton:HookScript("OnLeave", function()
							_G[name]:GetScript("OnLeave")()
							GameTooltip:Hide()
						end)
					elseif name == "ZygorGuidesViewerMapIcon" then
						-- Zygor (uses LibDBIcon10_LeaPlusCustomIcon_ZygorGuidesViewerMapIcon)
						local myButton = LibStub("LibDBIcon-1.0"):GetMinimapButton("LeaPlusCustomIcon_" .. name)
						myButton.icon:SetTexture("Interface\\AddOns\\ZygorGuidesViewerClassicTBC\\Skins\\minimap-icon.tga")
						hooksecurefunc(myButton.icon, "UpdateCoord", function()
							myButton.icon:SetTexCoord(0, 0.5, 0, 0.25)
						end)
						myButton.icon:SetTexCoord(0, 0.5, 0, 0.25)
						myButton:HookScript("OnEnter", function()
							_G[name]:GetScript("OnEnter")(_G[name], true)
							ReanchorTooltip(GameTooltip, myButton)
						end)
						myButton:HookScript("OnLeave", function()
							GameTooltip:Hide()
						end)
						if ZGV_Notification_Entry_Template_Mixin then
							-- Fix notification system entry height
							hooksecurefunc(ZGV_Notification_Entry_Template_Mixin, "UpdateHeight", function(self)
								self:Show()
								local height = 46
								if ZGV and ZGV.db and ZGV.db.profile and ZGV.db.profile.nc_size and ZGV.db.profile.nc_size == 1 then height = 36 end
								height = height + (self.time:IsVisible() and self.time:GetStringHeight()+0 or 0)
								height = height + (self.title:IsVisible() and self.title:GetStringHeight()+3 or 0)
								height = height + (self.text:IsVisible() and self.text:GetStringHeight()+3 or 0)
								height = height + (self.SpecialButton and self.SpecialButton:IsVisible() and self.SpecialButton:GetHeight()+8 or 0)
								if (self.single or self.special) then height = max(height,25) end
								self:SetHeight(height)
								self:Hide()
							end)
						end
					elseif name == "BtWQuestsMinimapButton"				-- BtWQuests
						or name == "TomCats-MinimapButton"				-- TomCat's Tours
						or name == "LibDBIcon10_MethodRaidTools"		-- Method Raid Tools
						or name == "Lib_GPI_Minimap_LFGBulletinBoard"	-- LFG Bulletin Board
						or name == "wlMinimapButton"					-- Wowhead Looter (part of Wowhead client)
						then
						local myButton = LibStub("LibDBIcon-1.0"):GetMinimapButton("LeaPlusCustomIcon_" .. name)
						myButton:HookScript("OnEnter", function()
							_G[name]:GetScript("OnEnter")(_G[name], true)
							ReanchorTooltip(GameTooltip, myButton)
						end)
						myButton:HookScript("OnLeave", function()
							GameTooltip:Hide()
						end)
					else
						-- Unknown custom buttons
						local myButton = LibStub("LibDBIcon-1.0"):GetMinimapButton("LeaPlusCustomIcon_" .. name)
						myButton:HookScript("OnEnter", function()
							GameTooltip:SetOwner(myButton, "ANCHOR_TOP")
							GameTooltip:AddLine(name)
							GameTooltip:AddLine(L["This is a custom button.  Please ask the addon author to use the standard LibDBIcon library instead."], 1, 1, 1, true)
							GameTooltip:Show()
							ReanchorTooltip(GameTooltip, myButton)
						end)
						myButton:HookScript("OnLeave", function()
							GameTooltip:Hide()
						end)
					end
				end

				-- Create LibDBIcon buttons for these addons that have LibDBIcon prefixes
				local customButtonTable = {
					"LibDBIcon10_MethodRaidTools", -- Method Raid Tools
				}

				-- Do not create LibDBIcon buttons for these special case buttons
				local BypassButtonTable = {
					"SexyMapZoneTextButton", -- SexyMap
				}

				-- Some buttons have less than 3 regions.  These need to be manually defined below.
				local LowRegionCountButtons = {
					"AllTheThings-Minimap", -- AllTheThings
				}

				-- Function to loop through minimap children to find custom addon buttons
				local function MakeButtons()
					local temp = {Minimap:GetChildren()}
					for i = 1, #temp do
						if temp[i] then
							local btn = temp[i]
							local name = btn:GetName()
							local btype = btn:GetObjectType()
							if name and btype == "Button" and not CustomAddonTable[name] and (btn:GetNumRegions() >= 3 or tContains(LowRegionCountButtons, name)) and not issecurevariable(name) and btn:IsShown() then
								if not strfind(strlower(LeaPlusDB["MiniExcludeList"]), strlower("##" .. name)) then
									if not string.find(name, "LibDBIcon") and not tContains(BypassButtonTable, name) or tContains(customButtonTable, name) then
										CreateBadButton(name)
										btn:Hide()
										btn:SetScript("OnShow", function() btn:Hide() end)
									end
								end
							end
						end
					end
				end

				-- Run the function a few times on startup
				C_Timer.NewTicker(2, MakeButtons, 8)
				C_Timer.After(0.1, MakeButtons)

			end

			----------------------------------------------------------------------
			-- Hide addon buttons
			----------------------------------------------------------------------

			if LeaPlusLC["CombineAddonButtons"] == "Off" then

				-- Function to set button state
				local function SetHideButtons()
					if LeaPlusLC["HideMiniAddonButtons"] == "On" then
						-- Hide existing buttons
						local buttons = LibDBIconStub:GetButtonList()
						for i = 1, #buttons do
							local buttonName = strlower(buttons[i])
							if not strfind(strlower(LeaPlusDB["MiniExcludeList"]), buttonName) then
								LibDBIconStub:ShowOnEnter(buttons[i], true)
							end
						end
						-- Hide new buttons
						-- LibDBIcon_IconCreated: Done in LibDBIcon callback function
					else
						-- Show existing buttons
						local buttons = LibDBIconStub:GetButtonList()
						for i = 1, #buttons do
							local buttonName = strlower(buttons[i])
							if not strfind(strlower(LeaPlusDB["MiniExcludeList"]), buttonName) then
								LibDBIconStub:ShowOnEnter(buttons[i], false)
							end
						end
						-- Show new buttons
						-- LibDBIcon_IconCreated: Done in LibDBIcon callback function
					end
				end

				-- Assign file level scope (it's used in reset and preset)
				LeaPlusLC.SetHideButtons = SetHideButtons

				-- Set buttons when option is clicked and on startup
				LeaPlusCB["HideMiniAddonButtons"]:HookScript("OnClick", SetHideButtons)
				SetHideButtons()

			end

			----------------------------------------------------------------------
			-- Hide the world map button
			----------------------------------------------------------------------

			-- Function to set world map button
			local function SetWorldMapButton()
				if LeaPlusLC["HideMiniMapButton"] == "On" then
					MiniMapWorldMapButton:Hide()
				else
					MiniMapWorldMapButton:Show()
				end
			end

			-- Set map button when option is clicked and on startup
			LeaPlusCB["HideMiniMapButton"]:HookScript("OnClick", SetWorldMapButton)
			SetWorldMapButton()

			-- Hide world map button when it's shown
			hooksecurefunc(MiniMapWorldMapButton, "Show", function()
				if LeaPlusLC["HideMiniMapButton"] == "On" then
					MiniMapWorldMapButton:Hide()
				end
			end)

			----------------------------------------------------------------------
			-- Unlock the minimap
			----------------------------------------------------------------------

			-- Raise the frame in case it's hidden
			Minimap:Raise()

			-- Enable minimap movement
			Minimap:SetMovable(true)
			Minimap:SetUserPlaced(true)
			Minimap:SetDontSavePosition(true)
			Minimap:SetClampedToScreen(true)
			if LeaPlusLC["SquareMinimap"] == "On" then
				Minimap:SetClampRectInsets(-3, 3, 3, -3)
			else
				Minimap:SetClampRectInsets(-2, 0, 2, -2)
			end
			MinimapBackdrop:ClearAllPoints()
			MinimapBackdrop:SetPoint("TOP", Minimap, "TOP", -9, 2)
			Minimap:RegisterForDrag("LeftButton")

			-- Set minimap position on startup
			Minimap:ClearAllPoints()
			Minimap:SetPoint(LeaPlusLC["MinimapA"], UIParent, LeaPlusLC["MinimapR"], LeaPlusLC["MinimapX"], LeaPlusLC["MinimapY"])

			-- Drag functions
			Minimap:SetScript("OnDragStart", function(self, btn)
				-- Start dragging if left clicked
				if IsAltKeyDown() and btn == "LeftButton" then
					Minimap:StartMoving()
				end
			end)

			Minimap:SetScript("OnDragStop", function(self, btn)
				-- Save minimap position
				Minimap:StopMovingOrSizing()
				LeaPlusLC["MinimapA"], void, LeaPlusLC["MinimapR"], LeaPlusLC["MinimapX"], LeaPlusLC["MinimapY"] = Minimap:GetPoint()
				Minimap:SetMovable(true)
				Minimap:ClearAllPoints()
				Minimap:SetPoint(LeaPlusLC["MinimapA"], UIParent, LeaPlusLC["MinimapR"], LeaPlusLC["MinimapX"], LeaPlusLC["MinimapY"])
			end)

			----------------------------------------------------------------------
			-- Hide the zone text bar, time of day button and toggle button
			----------------------------------------------------------------------

			-- Reparent MinimapCluster elements
			MinimapBorderTop:SetParent(Minimap)
			MinimapZoneTextButton:SetParent(MinimapBackdrop)

			-- Instance difficulty
			miniFrame.SetParent(MiniMapInstanceDifficulty, Minimap)
			miniFrame.ClearAllPoints(MiniMapInstanceDifficulty)
			if LeaPlusLC["SquareMinimap"] == "On" then
				MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -21, 10)
				MiniMapInstanceDifficulty:SetScale(0.75)
			else
				MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -13, 5)
			end
			MiniMapInstanceDifficulty:SetFrameLevel(4)

			-- Anchor border top to MinimapBackdrop
			MinimapBorderTop:ClearAllPoints()
			MinimapBorderTop:SetPoint("TOP", MinimapBackdrop, "TOP", 0, 20)

			-- Refresh buttons
			C_Timer.After(0.1, SetButtonRad)

			-- Function to set zone text bar
			local function SetZoneTextBar()
				if LeaPlusLC["HideMiniZoneText"] == "On" then
					MinimapBorderTop:Hide()
					MinimapZoneTextButton:Hide()
				else
					MinimapZoneTextButton:ClearAllPoints()
					MinimapZoneTextButton:SetPoint("CENTER", MinimapBorderTop, "CENTER", -1, 3)
					MinimapBorderTop:Show()
					MinimapZoneTextButton:Show()
					if LeaPlusDB["SquareMinimap"] == "On" then
						MinimapBorderTop:Hide()
						MinimapZoneTextButton:ClearAllPoints()
						MinimapZoneTextButton:SetPoint("TOP", Minimap, "TOP", 0, 0)
						MinimapZoneTextButton:SetFrameLevel(100)
					end
				end
			end

			-- Set the zone text bar when option is clicked and on startup
			LeaPlusCB["HideMiniZoneText"]:HookScript("OnClick", SetZoneTextBar)
			SetZoneTextBar()

			----------------------------------------------------------------------
			-- Hide the zoom buttons
			----------------------------------------------------------------------

			-- Function to toggle the zoom buttons
			local function ToggleZoomButtons()
				if LeaPlusLC["HideMiniZoomBtns"] == "On" then
					MinimapZoomIn:Hide()
					MinimapZoomOut:Hide()
				else
					MinimapZoomIn:Show()
					MinimapZoomOut:Show()
				end
			end

			-- Set the zoom buttons when the option is clicked and on startup
			LeaPlusCB["HideMiniZoomBtns"]:HookScript("OnClick", ToggleZoomButtons)
			ToggleZoomButtons()

			----------------------------------------------------------------------
			-- Style and position the clock
			----------------------------------------------------------------------

			-- Function to style and position the clock
			EventUtil.ContinueOnAddOnLoaded("Blizzard_TimeManager",function()
				if LeaPlusLC["SquareMinimap"] == "On" then
					local regions = {TimeManagerClockButton:GetRegions()}
					regions[1]:Hide()
					TimeManagerClockButton:ClearAllPoints()
					TimeManagerClockButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", -15, -8)
					TimeManagerClockButton:SetHitRectInsets(15, 10, 5, 8)
					TimeManagerClockButton:SetFrameLevel(100)
					local timeBG = TimeManagerClockButton:CreateTexture(nil, "BACKGROUND")
					timeBG:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
					timeBG:SetPoint("TOPLEFT", 15, -5)
					timeBG:SetPoint("BOTTOMRIGHT", -10, 8)
					timeBG:SetVertexColor(0, 0, 0, 0.6)
				end
			end)

			----------------------------------------------------------------------
			-- Enable mousewheel zoom
			----------------------------------------------------------------------

			-- Function to control mousewheel zoom
			local function MiniZoom(self, arg1)
				if arg1 > 0 and self:GetZoom() < 5 then
					-- Zoom in
					MinimapZoomOut:Enable()
					self:SetZoom(self:GetZoom() + 1)
					if(Minimap:GetZoom() == (Minimap:GetZoomLevels() - 1)) then
						MinimapZoomIn:Disable()
					end
				elseif arg1 < 0 and self:GetZoom() > 0 then
					-- Zoom out
					MinimapZoomIn:Enable()
					self:SetZoom(self:GetZoom() - 1)
					if(Minimap:GetZoom() == 0) then
						MinimapZoomOut:Disable()
					end
				end
			end

			-- Enable mousewheel zoom
			Minimap:EnableMouseWheel(true)
			Minimap:SetScript("OnMouseWheel", MiniZoom)

			----------------------------------------------------------------------
			-- Minimap scale
			----------------------------------------------------------------------

			-- Function to set the minimap scale and not minimap checkbox
			local function SetMiniScale()
				Minimap:SetScale(LeaPlusLC["MinimapScale"])
				-- Set slider formatted text
				LeaPlusCB["MinimapScale"].f:SetFormattedText("%.0f%%", LeaPlusLC["MinimapScale"] * 100)
				-- Set Not minimap
				if LeaPlusLC["MinimapNoScale"] == "On" then
					Minimap:SetIgnoreParentScale(true)
				else
					Minimap:SetIgnoreParentScale(false)
				end
			end

			-- Set minimap scale when slider is changed and on startup
			LeaPlusCB["MinimapScale"]:HookScript("OnValueChanged", SetMiniScale)
			LeaPlusCB["MinimapNoScale"]:HookScript("OnClick", SetMiniScale)
			SetMiniScale()

			----------------------------------------------------------------------
			-- Buttons
			----------------------------------------------------------------------

			-- Help button tooltip
			SideMinimap.h.tiptext = L["To move the minimap, hold down the alt key and drag it.|n|nIf you toggle an addon minimap button, you may need to reload your UI for the change to take effect.  This only affects a few addons that use custom buttons.|n|nThis panel will close automatically if you enter combat."]

			-- Back button handler
			SideMinimap.b:SetScript("OnClick", function()
				SideMinimap:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page5"]:Show()
				return
			end)

			-- Reset button handler
			SideMinimap.r.tiptext = SideMinimap.r.tiptext .. "|n|n" .. L["Note that this will not reset settings that require a UI reload."]
			SideMinimap.r:HookScript("OnClick", function()
				LeaPlusLC["HideMiniZoomBtns"] = "Off"; ToggleZoomButtons()
				LeaPlusLC["HideMiniZoneText"] = "Off"; SetZoneTextBar()
				LeaPlusLC["HideMiniAddonButtons"] = "On"; if LeaPlusLC.SetHideButtons then LeaPlusLC.SetHideButtons() end
				LeaPlusLC["MinimapScale"] = 1
				LeaPlusLC["MinimapSize"] = 140; if LeaPlusLC.SetMinimapSize then LeaPlusLC:SetMinimapSize() end
				LeaPlusLC["MiniClusterScale"] = 1; LeaPlusLC["MinimapNoScale"] = "Off"; SetClusterScale()
				LeaPlusLC["MinimapBorderWidth"] = 3
				Minimap:SetScale(1)
				SetMiniScale()
				-- Reset map position
				LeaPlusLC["MinimapA"], LeaPlusLC["MinimapR"], LeaPlusLC["MinimapX"], LeaPlusLC["MinimapY"] = "TOPRIGHT", "TOPRIGHT", -17, -22
				Minimap:ClearAllPoints()
				Minimap:SetPoint(LeaPlusLC["MinimapA"], UIParent, LeaPlusLC["MinimapR"], LeaPlusLC["MinimapX"], LeaPlusLC["MinimapY"])
				-- Hide world map button
				LeaPlusLC["HideMiniMapButton"] = "On"; SetWorldMapButton()
				-- Refresh panel
				SideMinimap:Hide(); SideMinimap:Show()
			end)

			-- Configuration button handler
			LeaPlusCB["ModMinimapBtn"]:HookScript("OnClick", function()
				if LeaPlusLC:PlayerInCombat() then
					return
				else
					if IsShiftKeyDown() and IsControlKeyDown() then
						-- Preset profile
						LeaPlusLC["HideMiniZoomBtns"] = "Off"; ToggleZoomButtons()
						LeaPlusLC["HideMiniZoneText"] = "On"; SetZoneTextBar()
						LeaPlusLC["HideMiniAddonButtons"] = "On"; if LeaPlusLC.SetHideButtons then LeaPlusLC.SetHideButtons() end
						LeaPlusLC["MinimapScale"] = 1.40
						LeaPlusLC["MinimapSize"] = 180; if LeaPlusLC.SetMinimapSize then LeaPlusLC:SetMinimapSize() end
						LeaPlusLC["MiniClusterScale"] = 1; LeaPlusLC["MinimapNoScale"] = "Off"; SetClusterScale()
						LeaPlusLC["MinimapBorderWidth"] = 3
						Minimap:SetScale(1)
						SetMiniScale()
						-- Hide world map button
						LeaPlusLC["HideMiniMapButton"] = "On"; SetWorldMapButton()
						-- Map position
						LeaPlusLC["MinimapA"], LeaPlusLC["MinimapR"], LeaPlusLC["MinimapX"], LeaPlusLC["MinimapY"] = "TOPRIGHT", "TOPRIGHT", 0, 0
						Minimap:SetMovable(true)
						Minimap:ClearAllPoints()
						Minimap:SetPoint(LeaPlusLC["MinimapA"], UIParent, LeaPlusLC["MinimapR"], LeaPlusLC["MinimapX"], LeaPlusLC["MinimapY"])
						LeaPlusLC:ReloadCheck() -- Special reload check
					else
						-- Show configuration panel
						SideMinimap:Show()
						LeaPlusLC:HideFrames()
					end
				end
			end)

			-- Hide tracking button
			if LeaPlusLC["HideMiniTracking"] == "On" then

				-- Hide tracking button initially
				MiniMapTracking:SetAlpha(0)
				MiniMapTracking:Hide()

				-- Create tracking button fade out animation
				MiniMapTracking.fadeOut = MiniMapTracking:CreateAnimationGroup()
				local animOut = MiniMapTracking.fadeOut:CreateAnimation("Alpha")
				animOut:SetOrder(1)
				animOut:SetDuration(0.2)
				animOut:SetFromAlpha(1)
				animOut:SetToAlpha(0)
				animOut:SetStartDelay(1)
				MiniMapTracking.fadeOut:SetToFinalAlpha(true)

				-- Show tracking button when entering minimap
				Minimap:HookScript("OnEnter", function()
					MiniMapTracking.fadeOut:Stop()
					MiniMapTracking:SetAlpha(1)
				end)

				-- Hide tracking button when leaving minimap if pointer is not over tracking button
				Minimap:HookScript("OnLeave", function()
					if not MouseIsOver(MiniMapTracking) then
						MiniMapTracking.fadeOut:Play()
					end
				end)

				-- Hide tracking button when leaving tracking button
				MiniMapTracking:HookScript("OnLeave", function()
					MiniMapTracking.fadeOut:Play()
				end)

				-- Hook existing LibDBIcon buttons to include tracking button
				local buttons = LibDBIconStub:GetButtonList()
				for i = 1, #buttons do
					local button = LibDBIconStub:GetMinimapButton(buttons[i])
					if button then
						button:HookScript("OnEnter", function()
							MiniMapTracking.fadeOut:Stop()
							MiniMapTracking:SetAlpha(1)
						end)
						button:HookScript("OnLeave", function()
							MiniMapTracking.fadeOut:Play()
						end)
					end
				end

				-- Hook new LibDBIcon buttons to include tracking button
				-- LibDBIcon_IconCreated: Done in LibDBIcon callback function

				-- Show tracking button when button alpha is set to 1
				hooksecurefunc(MiniMapTracking, "SetAlpha", function(self, alphavalue)
					if alphavalue and alphavalue == 1 then
						MiniMapTracking:Show()
					end
				end)

				-- Hide tracking button when fadeout animation has finished
				MiniMapTracking.fadeOut:HookScript("OnFinished", function()
					MiniMapTracking:Hide()
				end)

			end

			-- LibDBIcon callback (search LibDBIcon_IconCreated to find calls to this)
			LibDBIconStub.RegisterCallback(miniFrame, "LibDBIcon_IconCreated", function(self, button, name)

				-- Combine addon buttons: Hide new LibDBIcon icons
				if LeaPlusLC["CombineAddonButtons"] == "On" then
					--C_Timer.After(0.1, function() -- Removed for now
						local buttonName = strlower(name)

						-- Special case for MoveAny because it doesn't have button.db
						if buttonName == "moveany" then
							button.db = button.db or {}
							if not button.db.hide then button.db.hide = false end
						end

						if not strfind(strlower(LeaPlusDB["MiniExcludeList"]), buttonName) then
							if button.db and not button.db.hide then
								button:Hide()
								button:SetScript("OnShow", function() if not LeaPlusLC.bFrame:IsShown() then button:Hide() end end)
							end
							-- Create background texture
							local bFrameBg = button:CreateTexture(nil, "BACKGROUND")
							bFrameBg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
							bFrameBg:SetPoint("CENTER")
							bFrameBg:SetSize(30, 30)
							bFrameBg:SetVertexColor(0, 0, 0, 0.5)
						elseif strfind(strlower(LeaPlusDB["MiniExcludeList"]), buttonName) and LeaPlusLC["SquareMinimap"] == "On" then
							button:SetScale(0.75)
						end
						-- Move GameTooltip to below the minimap in case the button uses it
						button:HookScript("OnEnter", LeaPlusLC.SetButtonTooltip)
					--end)
				end

				-- Square minimap: Set scale of new LibDBIcon icons
				if LeaPlusLC["SquareMinimap"] == "On" and LeaPlusLC["CombineAddonButtons"] == "Off" then
					button:SetScale(0.75)
				end

				-- Hide addon buttons: Hide new LibDBIcon icons
				if LeaPlusLC["CombineAddonButtons"] == "Off" then
					local buttonName = strlower(name)
					if LeaPlusLC["HideMiniAddonButtons"] == "On" then
						-- Hide addon buttons is enabled
						if not strfind(strlower(LeaPlusDB["MiniExcludeList"]), buttonName) then
							LibDBIconStub:ShowOnEnter(name, true)
						end
					else
						-- Hide addon buttons is disabled
						if not strfind(strlower(LeaPlusDB["MiniExcludeList"]), buttonName) then
							LibDBIconStub:ShowOnEnter(name, false)
						end
					end
				end

				-- Hide tracking button
				if LeaPlusLC["HideMiniTracking"] == "On" then
					button:HookScript("OnEnter", function()
						-- Show tracking button when entering LibDBIcon button
						MiniMapTracking.fadeOut:Stop()
						MiniMapTracking:SetAlpha(1)
					end)
					button:HookScript("OnLeave", function()
						-- Hide tracking button when leaving LibDBIcon button
						MiniMapTracking.fadeOut:Play()
					end)
				end

			end)

		end

		----------------------------------------------------------------------
		-- Manage durability
		----------------------------------------------------------------------

		if LeaPlusLC["ManageDurability"] == "On" and not LeaLockList["ManageDurability"] then

			-- Create and manage container for DurabilityFrame
			local durabilityHolder = CreateFrame("Frame", nil, UIParent)
			durabilityHolder:SetPoint("TOP", UIParent, "TOP", 0, -15)
			durabilityHolder:SetSize(92, 75)

			local durabilityContainer = _G.DurabilityFrame
			durabilityContainer:ClearAllPoints()
			durabilityContainer:SetPoint('CENTER', durabilityHolder)
			durabilityContainer:SetIgnoreParentScale(true) -- Needed to keep drag frame position when scaled

			hooksecurefunc(durabilityContainer, 'SetPoint', function(self, void, b)
				if b and (b ~= durabilityHolder) then
					-- Reset parent if it changes from durabilityHolder
					self:ClearAllPoints()
					self:SetPoint('TOPRIGHT', durabilityHolder) -- Has to be TOPRIGHT (drag frame while moving between subzones)
					self:SetParent(durabilityHolder)
				end
			end)

			-- Allow durability frame to be moved
			durabilityHolder:SetMovable(true)
			durabilityHolder:SetUserPlaced(true)
			durabilityHolder:SetDontSavePosition(true)
			durabilityHolder:SetClampedToScreen(false)

			-- Set durability frame position at startup
			durabilityHolder:ClearAllPoints()
			durabilityHolder:SetPoint(LeaPlusLC["DurabilityA"], UIParent, LeaPlusLC["DurabilityR"], LeaPlusLC["DurabilityX"], LeaPlusLC["DurabilityY"])
			durabilityHolder:SetScale(LeaPlusLC["DurabilityScale"])
			DurabilityFrame:SetScale(LeaPlusLC["DurabilityScale"])

			-- Create drag frame
			local dragframe = CreateFrame("FRAME", nil, nil, "BackdropTemplate")
			dragframe:SetPoint("CENTER", durabilityHolder, "CENTER", 0, 1)
			dragframe:SetBackdropColor(0.0, 0.5, 1.0)
			dragframe:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 16, insets = { left = 0, right = 0, top = 0, bottom = 0}})
			dragframe:SetToplevel(true)
			dragframe:Hide()
			dragframe:SetScale(LeaPlusLC["DurabilityScale"])

			dragframe.t = dragframe:CreateTexture()
			dragframe.t:SetAllPoints()
			dragframe.t:SetColorTexture(0.0, 1.0, 0.0, 0.5)
			dragframe.t:SetAlpha(0.5)

			dragframe.f = dragframe:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			dragframe.f:SetPoint('CENTER', 0, 0)
			dragframe.f:SetText(L["Durability"])

			-- Click handler
			dragframe:SetScript("OnMouseDown", function(self, btn)
				-- Start dragging if left clicked
				if btn == "LeftButton" then
					durabilityHolder:StartMoving()
				end
			end)

			dragframe:SetScript("OnMouseUp", function()
				-- Save frame position
				durabilityHolder:StopMovingOrSizing()
				LeaPlusLC["DurabilityA"], void, LeaPlusLC["DurabilityR"], LeaPlusLC["DurabilityX"], LeaPlusLC["DurabilityY"] = durabilityHolder:GetPoint()
				durabilityHolder:SetMovable(true)
				durabilityHolder:ClearAllPoints()
				durabilityHolder:SetPoint(LeaPlusLC["DurabilityA"], UIParent, LeaPlusLC["DurabilityR"], LeaPlusLC["DurabilityX"], LeaPlusLC["DurabilityY"])
			end)

			-- Snap-to-grid
			do
				local frame, grid = dragframe, 10
				local w, h = 65, 75
				local xpos, ypos, scale, uiscale
				frame:RegisterForDrag("RightButton")
				frame:HookScript("OnDragStart", function()
					frame:SetScript("OnUpdate", function()
						scale, uiscale = frame:GetScale(), UIParent:GetScale()
						xpos, ypos = GetCursorPosition()
						xpos = floor((xpos / scale / uiscale) / grid) * grid - w / 2
						ypos = ceil((ypos / scale / uiscale) / grid) * grid + h / 2
						durabilityHolder:ClearAllPoints()
						durabilityHolder:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", xpos, ypos)
					end)
				end)
				frame:HookScript("OnDragStop", function()
					frame:SetScript("OnUpdate", nil)
					frame:GetScript("OnMouseUp")()
				end)
			end

			-- Create configuration panel
			local DurabilityPanel = LeaPlusLC:CreatePanel("Manage durability", "DurabilityPanel")

			LeaPlusLC:MakeTx(DurabilityPanel, "Scale", 16, -72)
			LeaPlusLC:MakeSL(DurabilityPanel, "DurabilityScale", "Drag to set the durability frame scale.", 0.5, 2, 0.05, 16, -92, "%.2f")

			-- Set scale when slider is changed
			LeaPlusCB["DurabilityScale"]:HookScript("OnValueChanged", function()
				durabilityHolder:SetScale(LeaPlusLC["DurabilityScale"])
				DurabilityFrame:SetScale(LeaPlusLC["DurabilityScale"])
				dragframe:SetScale(LeaPlusLC["DurabilityScale"])
				-- Show formatted slider value
				LeaPlusCB["DurabilityScale"].f:SetFormattedText("%.0f%%", LeaPlusLC["DurabilityScale"] * 100)
			end)

			-- Hide frame alignment grid with panel
			DurabilityPanel:HookScript("OnHide", function()
				LeaPlusLC.grid:Hide()
			end)

			-- Toggle grid button
			local DurabilityToggleGridButton = LeaPlusLC:CreateButton("DurabilityToggleGridButton", DurabilityPanel, "Toggle Grid", "TOPLEFT", 16, -72, 0, 25, true, "Click to toggle the frame alignment grid.")
			LeaPlusCB["DurabilityToggleGridButton"]:ClearAllPoints()
			LeaPlusCB["DurabilityToggleGridButton"]:SetPoint("LEFT", DurabilityPanel.h, "RIGHT", 10, 0)
			LeaPlusCB["DurabilityToggleGridButton"]:SetScript("OnClick", function()
				if LeaPlusLC.grid:IsShown() then LeaPlusLC.grid:Hide() else LeaPlusLC.grid:Show() end
			end)
			DurabilityPanel:HookScript("OnHide", function()
				if LeaPlusLC.grid then LeaPlusLC.grid:Hide() end
			end)

			-- Help button tooltip
			DurabilityPanel.h.tiptext = L["Drag the frame overlay with the left button to position it freely or with the right button to position it using snap-to-grid."]

			-- Back button handler
			DurabilityPanel.b:SetScript("OnClick", function()
				DurabilityPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page6"]:Show()
				return
			end)

			-- Reset button handler
			DurabilityPanel.r:SetScript("OnClick", function()

				-- Reset position and scale
				LeaPlusLC["DurabilityA"] = "TOPRIGHT"
				LeaPlusLC["DurabilityR"] = "TOPRIGHT"
				LeaPlusLC["DurabilityX"] = 0
				LeaPlusLC["DurabilityY"] = -192
				LeaPlusLC["DurabilityScale"] = 1
				durabilityHolder:ClearAllPoints()
				durabilityHolder:SetPoint(LeaPlusLC["DurabilityA"], UIParent, LeaPlusLC["DurabilityR"], LeaPlusLC["DurabilityX"], LeaPlusLC["DurabilityY"])

				-- Refresh configuration panel
				DurabilityPanel:Hide(); DurabilityPanel:Show()
				dragframe:Show()

				-- Show frame alignment grid
				LeaPlusLC.grid:Show()

			end)

			-- Show configuration panel when options panel button is clicked
			LeaPlusCB["ManageDurabilityButton"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["DurabilityA"] = "TOPRIGHT"
					LeaPlusLC["DurabilityR"] = "TOPRIGHT"
					LeaPlusLC["DurabilityX"] = 0
					LeaPlusLC["DurabilityY"] = -192
					LeaPlusLC["DurabilityScale"] = 1
					durabilityHolder:ClearAllPoints()
					durabilityHolder:SetPoint(LeaPlusLC["DurabilityA"], UIParent, LeaPlusLC["DurabilityR"], LeaPlusLC["DurabilityX"], LeaPlusLC["DurabilityY"])
					durabilityHolder:SetScale(LeaPlusLC["DurabilityScale"])
					DurabilityFrame:SetScale(LeaPlusLC["DurabilityScale"])
				else
					-- Find out if the UI has a non-standard scale
					if GetCVar("useuiscale") == "1" then
						LeaPlusLC["gscale"] = GetCVar("uiscale")
					else
						LeaPlusLC["gscale"] = 1
					end

					-- Set drag frame size according to UI scale
					dragframe:SetWidth(92 * LeaPlusLC["gscale"])
					dragframe:SetHeight(75 * LeaPlusLC["gscale"])

					-- Show configuration panel
					DurabilityPanel:Show()
					LeaPlusLC:HideFrames()
					dragframe:Show()

					-- Show frame alignment grid
					LeaPlusLC.grid:Show()
				end
			end)

			-- Hide drag frame when configuration panel is closed
			DurabilityPanel:HookScript("OnHide", function() dragframe:Hide() end)

		end

		----------------------------------------------------------------------
		-- Manage timer
		----------------------------------------------------------------------

		if LeaPlusLC["ManageTimer"] == "On" and not LeaLockList["ManageTimer"] then

			-- Allow timer frame to be moved
			MirrorTimer1:SetMovable(true)
			MirrorTimer1:SetUserPlaced(true)
			MirrorTimer1:SetDontSavePosition(true)
			MirrorTimer1:SetClampedToScreen(true)

			-- Set timer frame position at startup
			MirrorTimer1:ClearAllPoints()
			MirrorTimer1:SetPoint(LeaPlusLC["TimerA"], UIParent, LeaPlusLC["TimerR"], LeaPlusLC["TimerX"], LeaPlusLC["TimerY"])
			MirrorTimer1:SetScale(LeaPlusLC["TimerScale"])

			-- Create drag frame
			local dragframe = CreateFrame("FRAME", nil, nil, "BackdropTemplate")
			dragframe:SetPoint("TOPRIGHT", MirrorTimer1, "TOPRIGHT", 0, 2.5)
			dragframe:SetBackdropColor(0.0, 0.5, 1.0)
			dragframe:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 16, insets = { left = 0, right = 0, top = 0, bottom = 0 }})
			dragframe:SetToplevel(true)
			dragframe:Hide()
			dragframe:SetScale(LeaPlusLC["TimerScale"])

			dragframe.t = dragframe:CreateTexture()
			dragframe.t:SetAllPoints()
			dragframe.t:SetColorTexture(0.0, 1.0, 0.0, 0.5)
			dragframe.t:SetAlpha(0.5)

			dragframe.f = dragframe:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			dragframe.f:SetPoint('CENTER', 0, 0)
			dragframe.f:SetText(L["Timer"])

			-- Click handler
			dragframe:SetScript("OnMouseDown", function(self, btn)
				-- Start dragging if left clicked
				if btn == "LeftButton" then
					MirrorTimer1:StartMoving()
				end
			end)

			dragframe:SetScript("OnMouseUp", function()
				-- Save frame positions
				MirrorTimer1:StopMovingOrSizing()
				LeaPlusLC["TimerA"], void, LeaPlusLC["TimerR"], LeaPlusLC["TimerX"], LeaPlusLC["TimerY"] = MirrorTimer1:GetPoint()
				MirrorTimer1:SetMovable(true)
				MirrorTimer1:ClearAllPoints()
				MirrorTimer1:SetPoint(LeaPlusLC["TimerA"], UIParent, LeaPlusLC["TimerR"], LeaPlusLC["TimerX"], LeaPlusLC["TimerY"])
			end)

			-- Snap-to-grid
			do
				local frame, grid = dragframe, 10
				local w, h = 180, 20
				local xpos, ypos, scale, uiscale
				frame:RegisterForDrag("RightButton")
				frame:HookScript("OnDragStart", function()
					frame:SetScript("OnUpdate", function()
						scale, uiscale = frame:GetScale(), UIParent:GetScale()
						xpos, ypos = GetCursorPosition()
						xpos = floor((xpos / scale / uiscale) / grid) * grid - w / 2
						ypos = ceil((ypos / scale / uiscale) / grid) * grid + h / 2
						MirrorTimer1:ClearAllPoints()
						MirrorTimer1:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", xpos, ypos)
					end)
				end)
				frame:HookScript("OnDragStop", function()
					frame:SetScript("OnUpdate", nil)
					frame:GetScript("OnMouseUp")()
				end)
			end

			-- Create configuration panel
			local TimerPanel = LeaPlusLC:CreatePanel("Manage timer", "TimerPanel")

			LeaPlusLC:MakeTx(TimerPanel, "Scale", 16, -72)
			LeaPlusLC:MakeSL(TimerPanel, "TimerScale", "Drag to set the timer bar scale.", 0.5, 2, 0.05, 16, -92, "%.2f")

			-- Set scale when slider is changed
			LeaPlusCB["TimerScale"]:HookScript("OnValueChanged", function()
				MirrorTimer1:SetScale(LeaPlusLC["TimerScale"])
				dragframe:SetScale(LeaPlusLC["TimerScale"])
				-- Show formatted slider value
				LeaPlusCB["TimerScale"].f:SetFormattedText("%.0f%%", LeaPlusLC["TimerScale"] * 100)
			end)

			-- Hide frame alignment grid with panel
			TimerPanel:HookScript("OnHide", function()
				LeaPlusLC.grid:Hide()
			end)

			-- Toggle grid button
			local TimerToggleGridButton = LeaPlusLC:CreateButton("TimerToggleGridButton", TimerPanel, "Toggle Grid", "TOPLEFT", 16, -72, 0, 25, true, "Click to toggle the frame alignment grid.")
			LeaPlusCB["TimerToggleGridButton"]:ClearAllPoints()
			LeaPlusCB["TimerToggleGridButton"]:SetPoint("LEFT", TimerPanel.h, "RIGHT", 10, 0)
			LeaPlusCB["TimerToggleGridButton"]:SetScript("OnClick", function()
				if LeaPlusLC.grid:IsShown() then LeaPlusLC.grid:Hide() else LeaPlusLC.grid:Show() end
			end)
			TimerPanel:HookScript("OnHide", function()
				if LeaPlusLC.grid then LeaPlusLC.grid:Hide() end
			end)

			-- Help button tooltip
			TimerPanel.h.tiptext = L["Drag the frame overlay with the left button to position it freely or with the right button to position it using snap-to-grid."]

			-- Back button handler
			TimerPanel.b:SetScript("OnClick", function()
				TimerPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page6"]:Show()
				return
			end)

			-- Reset button handler
			TimerPanel.r:SetScript("OnClick", function()

				-- Reset position and scale
				LeaPlusLC["TimerA"] = "TOP"
				LeaPlusLC["TimerR"] = "TOP"
				LeaPlusLC["TimerX"] = -5
				LeaPlusLC["TimerY"] = -96
				LeaPlusLC["TimerScale"] = 1
				MirrorTimer1:ClearAllPoints()
				MirrorTimer1:SetPoint(LeaPlusLC["TimerA"], UIParent, LeaPlusLC["TimerR"], LeaPlusLC["TimerX"], LeaPlusLC["TimerY"])

				-- Refresh configuration panel
				TimerPanel:Hide(); TimerPanel:Show()
				dragframe:Show()

				-- Show frame alignment grid
				LeaPlusLC.grid:Show()

			end)

			-- Show configuration panel when options panel button is clicked
			LeaPlusCB["ManageTimerButton"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["TimerA"] = "TOP"
					LeaPlusLC["TimerR"] = "TOP"
					LeaPlusLC["TimerX"] = 0
					LeaPlusLC["TimerY"] = -120
					LeaPlusLC["TimerScale"] = 1
					MirrorTimer1:ClearAllPoints()
					MirrorTimer1:SetPoint(LeaPlusLC["TimerA"], UIParent, LeaPlusLC["TimerR"], LeaPlusLC["TimerX"], LeaPlusLC["TimerY"])
					MirrorTimer1:SetScale(LeaPlusLC["TimerScale"])
				else
					-- Find out if the UI has a non-standard scale
					if GetCVar("useuiscale") == "1" then
						LeaPlusLC["gscale"] = GetCVar("uiscale")
					else
						LeaPlusLC["gscale"] = 1
					end

					-- Set drag frame size according to UI scale
					dragframe:SetWidth(206 * LeaPlusLC["gscale"])
					dragframe:SetHeight(20 * LeaPlusLC["gscale"])
					dragframe:SetFrameStrata("HIGH") -- MirrorTimer is medium

					-- Show configuration panel
					TimerPanel:Show()
					LeaPlusLC:HideFrames()
					dragframe:Show()

					-- Show frame alignment grid
					LeaPlusLC.grid:Show()
				end
			end)

			-- Hide drag frame when configuration panel is closed
			TimerPanel:HookScript("OnHide", function() dragframe:Hide() end)

		end

		----------------------------------------------------------------------
		-- Hide alerts
		----------------------------------------------------------------------

		if LeaPlusLC["NoAlerts"] == "On" then

			-- Unregister alert events
			hooksecurefunc(AlertFrame, "RegisterEvent", function(self, event)
				AlertFrame:UnregisterEvent(event)
			end)
			AlertFrame:UnregisterAllEvents()

			-- Show chat message and play sound for achievement alerts
			local frame = CreateFrame("FRAME")
			frame:RegisterEvent("ACHIEVEMENT_EARNED")
			frame:SetScript("OnEvent", function(self, event, arg1)
				if arg1 then
					local alink = GetAchievementLink(arg1)
					if alink then
						LeaPlusLC:Print(string.format(NEW_ACHIEVEMENT_EARNED:gsub("'", ""), alink))
						PlaySoundFile(569143)
					end
				end
			end)

		end

		----------------------------------------------------------------------
		-- Show ready timer
		----------------------------------------------------------------------

		if LeaPlusLC["ShowReadyTimer"] == "On" then

			-- Dungeons and Raids
			do

				-- Declare variables
				local duration, barTime = 40, -1
				local t = duration

				-- Create status bar below dungeon ready popup
				local bar = CreateFrame("StatusBar", nil, LFGDungeonReadyPopup)
				bar:SetPoint("TOPLEFT", LFGDungeonReadyPopup, "BOTTOMLEFT", 0, -5)
				bar:SetPoint("TOPRIGHT", LFGDungeonReadyPopup, "BOTTOMRIGHT", 0, -5)
				bar:SetHeight(5)
				bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
				bar:SetStatusBarColor(1.0, 0.85, 0.0)
				bar:SetMinMaxValues(0, duration)

				-- Create status bar text
				local text = bar:CreateFontString(nil, "ARTWORK")
				text:SetFontObject("GameFontNormalLarge")
				text:SetTextColor(1.0, 0.85, 0.0)
				text:SetPoint("TOP", 0, -10)

				-- Update bar as timer counts down
				bar:SetScript("OnUpdate", function(self, elapsed)
					t = t - elapsed
					if barTime >= 1 or barTime == -1 then
						self:SetValue(t)
						text:SetText(SecondsToTime(floor(t + 0.5)))
						barTime = 0
					end
					barTime = barTime + elapsed
				end)

				-- Show frame when dungeon ready frame shows
				local frame = CreateFrame("FRAME")
				frame:RegisterEvent("LFG_PROPOSAL_SHOW")
				frame:RegisterEvent("LFG_PROPOSAL_FAILED")
				frame:RegisterEvent("LFG_PROPOSAL_SUCCEEDED")
				frame:SetScript("OnEvent", function(self, event)
					if event == "LFG_PROPOSAL_SHOW" then
						t = duration
						barTime = -1
						bar:Show()
						-- Hide existing timer bars (such as BigWigs)
						local children = {LFGDungeonReadyPopup:GetChildren()}
						if children then
							for i, child in ipairs(children) do
								if child ~= bar then
									local objType = child:GetObjectType()
									if objType and objType == "StatusBar" then
										child:Hide()
									end
								end
							end
						end
					else
						bar:Hide()
					end
				end)

			end

			-- Player vs Player
			do

				-- Declare variables
				local t, barTime = -1, -1

				-- Create status bar below dungeon ready popup
				local bar = CreateFrame("StatusBar", nil, PVPReadyDialog)
				bar:SetPoint("TOPLEFT", PVPReadyDialog, "BOTTOMLEFT", 0, -5)
				bar:SetPoint("TOPRIGHT", PVPReadyDialog, "BOTTOMRIGHT", 0, -5)
				bar:SetHeight(5)
				bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
				bar:SetStatusBarColor(1.0, 0.85, 0.0)

				-- Create status bar text
				local text = bar:CreateFontString(nil, "ARTWORK")
				text:SetFontObject("GameFontNormalLarge")
				text:SetTextColor(1.0, 0.85, 0.0)
				text:SetPoint("TOP", 0, -10)

				-- Update bar as timer counts down
				bar:SetScript("OnUpdate", function(self, elapsed)
					t = t - elapsed
					if barTime >= 1 or barTime == -1 then
						self:SetValue(t)
						text:SetText(SecondsToTime(floor(t + 0.5)))
						barTime = 0
					end
					barTime = barTime + elapsed
				end)

				-- Show frame when PvP ready frame shows
				hooksecurefunc("PVPReadyDialog_Display", function(self, id)
					t = GetBattlefieldPortExpiration(id) + 1
					-- t = 89; -- debug
					if t and t > 1 then
						bar:SetMinMaxValues(0, t)
						barTime = -1
						bar:Show()
					else
						bar:Hide()
					end
				end)

				PVPReadyDialog:HookScript("OnHide", function()
					bar:Hide()
				end)

				-- Debug
				-- C_Timer.After(2, function() PVPReadyDialog_Display(self, 1, "Warsong Gulch", 0, "BATTLEGROUND", "", "DAMAGER"); bar:Show() end)

			end

		end

		----------------------------------------------------------------------
		-- Remove transforms (no reload required)
		----------------------------------------------------------------------

		do

			local transTable = {

				-- Single spell IDs
				["TransLantern"] = {44212}, -- Weighted Jack-o'-Lantern
				["TransTurkey"] = {61781}, -- Turkey (Pilgrim's Bounty)

				-- Noblegarden: Noblegarden Bunny
				["TransNobleBunny"] = {
					--[[Noblegarden Bunny]] 61734,
					--[[Rabbit Costume]] 61716,
				},

				-- Hallowed Wand costumes
				["TransHallowed"] = {
					--[[Bat]] 24732,
					--[[Ghost]] 24735, 24736,
					--[[Leper Gnome]] 24712, 24713,
					--[[Ninja]] 24710, 24711,
					--[[Pirate]] 24708, 24709,
					--[[Skeleton]] 24723,
					--[[Wisp]] 24740,
				},

			}

			-- Give table file level scope (its used during logout and for admin command)
			LeaPlusLC["transTable"] = transTable

			-- Create local table for storing spell IDs that need to be removed
			local cTable = {}

			-- Load saved settings or set default values
			for k, v in pairs(transTable) do
				if LeaPlusDB[k] and type(LeaPlusDB[k]) == "string" and LeaPlusDB[k] == "On" or LeaPlusDB[k] == "Off" then
					LeaPlusLC[k] = LeaPlusDB[k]
				else
					LeaPlusLC[k] = "Off"
					LeaPlusDB[k] = "Off"
				end
			end

			-- Create scrolling configuration panel
			local transPanel = LeaPlusLC:CreatePanel("Remove transforms", "transPanel", true)

			-- Initialise row count
			local row = -1

			-- Add checkboxes
			row = row + 2; LeaPlusLC:MakeTx(transPanel.scrollChild, "Events", 16,  -(row - 1) * 20 - 2)
			row = row + 1; LeaPlusLC:MakeCB(transPanel.scrollChild, "TransHallowed", "Hallow's End: Hallowed Wand", 16,  -((row - 1) * 20) - 2, false, "If checked, the Hallowed Wand transforms will be removed when applied.")
			row = row + 1; LeaPlusLC:MakeCB(transPanel.scrollChild, "TransLantern", "Hallow's End: Weighted Jack-o'-Lantern", 16,  -((row - 1) * 20) - 2, false, "If checked, the Weighted Jack-o'-Lantern transform will be removed when applied.")
			row = row + 1; LeaPlusLC:MakeCB(transPanel.scrollChild, "TransNobleBunny", "Noblegarden: Noblegarden Bunny", 16,  -((row - 1) * 20) - 2, false, "If checked, the Noblegarden bunny transforms will be removed when applied.")
			row = row + 1; LeaPlusLC:MakeCB(transPanel.scrollChild, "TransTurkey", "Pilgrim's Bounty: Turkey Shooter", 16,  -((row - 1) * 20) - 2, false, "If checked, the Turkey Shooter transform will be removed when applied.")

			-- Debug
			-- RemoveCommentToEnableDebug = true
			if RemoveCommentToEnableDebug then
				row = row + 2; LeaPlusLC:MakeTx(transPanel.scrollChild, "Debug", 16,  -(row - 1) * 20 - 2)
				row = row + 1; LeaPlusLC:MakeCB(transPanel.scrollChild, "CancelDevotion", "Devotion Aura", 16, -((row - 1) * 20) - 2, false, "")
				transTable["CancelDevotion"] = {465}
				LeaPlusLC["CancelDevotion"] = "On"

				row = row + 1; LeaPlusLC:MakeCB(transPanel.scrollChild, "CancelStealth", "Stealth", 16, -((row - 1) * 20) - 2, false, "")
				transTable["CancelStealth"] = {1784}
				LeaPlusLC["CancelStealth"] = "On"

				row = row + 1; LeaPlusLC:MakeCB(transPanel.scrollChild, "CancelIntel", "Intellect", 16, -((row - 1) * 20) - 2, false, "")
				transTable["CancelIntel"] = {1459}
				LeaPlusLC["CancelIntel"] = "On"
			end

			-- Function to populate cTable with spell IDs for settings that are enabled
			local function UpdateList()
				for k, v in pairs(transTable) do
					for j, spellID in pairs(v) do
						if LeaPlusLC[k] == "On" then
							cTable[spellID] = true
						else
							cTable[spellID] = nil
						end
					end
				end
			end

			-- Populate cTable on startup
			UpdateList()

			-- Create frame for events
			local spellFrame = CreateFrame("FRAME")

			-- Function to cancel buffs
			local function eventFunc()
				for i = 1, 40 do
					local BuffData = C_UnitAuras.GetBuffDataByIndex("player", i)
					if BuffData then
						local spellID = BuffData.spellId
						if spellID and cTable[spellID] then
							if UnitAffectingCombat("player") then
								spellFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
							else
								CancelUnitBuff("player", i)
							end
						end
					end
				end
			end

			-- Check for buffs
			spellFrame:SetScript("OnEvent", function(self, event, unit, updatedAuras)
				if event == "UNIT_AURA" then
					if updatedAuras then
						if updatedAuras.isFullUpdate then
							eventFunc()
						elseif updatedAuras.addedAuras then
							for void, aura in ipairs(updatedAuras.addedAuras) do
								if aura.spellId and cTable[aura.spellId] then
									eventFunc()
								end
							end
						end
					end
				elseif event == "PLAYER_REGEN_ENABLED" then

					-- Traverse buffs (will only run spell was found in cTable previously)
					for i = 1, 40 do
						local BuffData = C_UnitAuras.GetBuffDataByIndex("player", i)
						if BuffData then
							local spellID = BuffData.spellId
							if spellID and cTable[spellID] then
								spellFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
								CancelUnitBuff("player", i)
							end
						end
					end

				end
			end)

			-- Function to set event
			local function SetTransformFunc()
				if LeaPlusLC["NoTransforms"] == "On" then
					eventFunc()
					spellFrame:RegisterUnitEvent("UNIT_AURA", "player")
				else
					spellFrame:UnregisterEvent("UNIT_AURA")
					spellFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
				end
			end

			-- Run set event function when option is clicked and on startup
			LeaPlusCB["NoTransforms"]:HookScript("OnClick", SetTransformFunc)
			if LeaPlusLC["NoTransforms"] == "On" then SetTransformFunc() end

			-- Set click width for checkboxes and run update when checkboxes are clicked
			for k, v in pairs(transTable) do
				LeaPlusCB[k]:HookScript("OnClick", function()
					UpdateList()
					eventFunc()
				end)
			end

			-- Help button hidden
			transPanel.h:Hide()

			-- Back button handler
			transPanel.b:SetScript("OnClick", function()
				transPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page7"]:Show()
				return
			end)

			-- Reset button handler
			transPanel.r:SetScript("OnClick", function()

				-- Reset checkboxes
				for k, v in pairs(transTable) do
					LeaPlusLC[k] = "Off"
				end
				UpdateList()
				eventFunc()

				-- Refresh panel
				transPanel:Hide(); transPanel:Show()

			end)

			-- Show panal when options panel button is clicked
			LeaPlusCB["NoTransformsBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					for k, v in pairs(transTable) do
						LeaPlusLC[k] = "On"
					end
					UpdateList()
					eventFunc()
				else
					transPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

		end

		----------------------------------------------------------------------
		-- Filter chat messages
		----------------------------------------------------------------------

		if LeaPlusLC["FilterChatMessages"] == "On" then

			-- Load LibChatAnims
			Leatrix_Plus:LeaPlusLCA()

			-- Create configuration panel
			local ChatFilterPanel = LeaPlusLC:CreatePanel("Filter chat messages", "ChatFilterPanel")

			LeaPlusLC:MakeTx(ChatFilterPanel, "Settings", 16, -72)
			LeaPlusLC:MakeCB(ChatFilterPanel, "BlockSpellLinks", "Block spell links during combat", 16, -92, false, "If checked, messages containing spell links will be blocked while you are in combat.|n|nThis is useful for blocking spell interrupt spam.|n|nThis applies to the say, party, raid, emote and yell channels.")
			LeaPlusLC:MakeCB(ChatFilterPanel, "BlockDrunkenSpam", "Block drunken spam", 16, -112, false, "If checked, drunken messages will be blocked unless they apply to your character.|n|nThis applies to the system channel.")
			LeaPlusLC:MakeCB(ChatFilterPanel, "BlockDuelSpam", "Block duel spam", 16, -132, false, "If checked, duel victory and retreat messages will be blocked unless your character took part in the duel.|n|nThis applies to the system channel.")
			LeaPlusLC:MakeCB(ChatFilterPanel, "BlockGuildAnnounce", "Block guild announcements", 16, -152, false, "If checked, guild announcements will be blocked.|n|nThis applies to the guild channel.")

			-- Lock block drunken spam option for zhTW
			if GameLocale == "zhTW" then
				LeaPlusLC:LockItem(LeaPlusCB["BlockDrunkenSpam"], true)
				LeaPlusLC["BlockDrunkenSpam"] = "Off"
				LeaPlusDB["BlockDrunkenSpam"] = "Off"
				LeaPlusCB["BlockDrunkenSpam"].tiptext = LeaPlusCB["BlockDrunkenSpam"].tiptext .. "|n|n|cff00AAFF" .. L["Cannot use this with your locale."]
			end

			-- Help button hidden
			ChatFilterPanel.h:Hide()

			-- Back button handler
			ChatFilterPanel.b:SetScript("OnClick", function()
				ChatFilterPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page3"]:Show()
				return
			end)

			local charName = GetUnitName("player")
			local charRealm = GetNormalizedRealmName()
			local nameRealm = charName .. "%%-" .. charRealm

			-- Chat filter to block specific messages sent to specific channels
			local function ChatFilterFunc(self, event, msg)
				-- Block duel spam
				if LeaPlusLC["BlockDuelSpam"] == "On" then
					-- Block duel messages unless you are part of the duel
					if msg:match(DUEL_WINNER_KNOCKOUT:gsub("%%1$s", "%.+"):gsub("%%2$s", "%.+")) or msg:match(DUEL_WINNER_RETREAT:gsub("%%1$s", "%.+"):gsub("%%2$s", "%.+")) then
						-- Player has defeated player in a duel.
						if msg:match(DUEL_WINNER_KNOCKOUT:gsub("%%1$s", charName):gsub("%%2$s", "%.+")) then return false end
						if msg:match(DUEL_WINNER_KNOCKOUT:gsub("%%1$s", nameRealm):gsub("%%2$s", "%.+")) then return false end
						if msg:match(DUEL_WINNER_KNOCKOUT:gsub("%%1$s", "%.+"):gsub("%%2$s", charName)) then return false end
						if msg:match(DUEL_WINNER_KNOCKOUT:gsub("%%1$s", "%.+"):gsub("%%2$s", nameRealm)) then return false end
						-- Player has fled from player in a duel.
						if msg:match(DUEL_WINNER_RETREAT:gsub("%%1$s", charName):gsub("%%2$s", "%.+")) then return false end
						if msg:match(DUEL_WINNER_RETREAT:gsub("%%1$s", nameRealm):gsub("%%2$s", "%.+")) then return false end
						if msg:match(DUEL_WINNER_RETREAT:gsub("%%1$s", "%.+"):gsub("%%2$s", charName)) then return false end
						if msg:match(DUEL_WINNER_RETREAT:gsub("%%1$s", "%.+"):gsub("%%2$s", nameRealm)) then return false end
						-- Block all duel messages not involving player
						return true
					end
				end
				-- Block spell links
				if LeaPlusLC["BlockSpellLinks"] == "On" and UnitAffectingCombat("player") then
					if msg:find("|Hspell") then return true end
				end
				-- Block drunken spam
				if LeaPlusLC["BlockDrunkenSpam"] == "On" then
					for i = 1, 4 do
						local drunk1 = _G["DRUNK_MESSAGE_ITEM_OTHER"..i]:gsub("%%s", "%s-")
						local drunk2 = _G["DRUNK_MESSAGE_OTHER"..i]:gsub("%%s", "%s-")
						if msg:match(drunk1) or msg:match(drunk2) then
							return true
						end
					end
				end
			end

			-- Chat filter to block all messages sent to specific channels
			local function ChatFilterBlockAllFunc()
				return true
			end

			-- Enable or disable chat filter settings
			local function SetChatFilter()
				if LeaPlusLC["BlockSpellLinks"] == "On" then
					ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ChatFilterFunc)
					ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChatFilterFunc)
					ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChatFilterFunc)
					ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ChatFilterFunc)
					ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ChatFilterFunc)
					ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", ChatFilterFunc)
					ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ChatFilterFunc)
				else
					ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SAY", ChatFilterFunc)
					ChatFrame_RemoveMessageEventFilter("CHAT_MSG_PARTY", ChatFilterFunc)
					ChatFrame_RemoveMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChatFilterFunc)
					ChatFrame_RemoveMessageEventFilter("CHAT_MSG_RAID", ChatFilterFunc)
					ChatFrame_RemoveMessageEventFilter("CHAT_MSG_RAID_LEADER", ChatFilterFunc)
					ChatFrame_RemoveMessageEventFilter("CHAT_MSG_EMOTE", ChatFilterFunc)
					ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", ChatFilterFunc)
				end
				if LeaPlusLC["BlockDrunkenSpam"] == "On" or LeaPlusLC["BlockDuelSpam"] == "On" then
					ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", ChatFilterFunc)
				else
					ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", ChatFilterFunc)
				end
				if LeaPlusLC["BlockGuildAnnounce"] == "On" then
					ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD_ACHIEVEMENT", ChatFilterBlockAllFunc)
					ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD_ITEM_LOOTED", ChatFilterBlockAllFunc)
				else
					ChatFrame_RemoveMessageEventFilter("CHAT_MSG_GUILD_ACHIEVEMENT", ChatFilterBlockAllFunc)
					ChatFrame_RemoveMessageEventFilter("CHAT_MSG_GUILD_ITEM_LOOTED", ChatFilterBlockAllFunc)
				end
			end

			-- Set chat filter when settings are clicked and on startup
			LeaPlusCB["BlockSpellLinks"]:HookScript("OnClick", SetChatFilter)
			LeaPlusCB["BlockDrunkenSpam"]:HookScript("OnClick", SetChatFilter)
			LeaPlusCB["BlockDuelSpam"]:HookScript("OnClick", SetChatFilter)
			LeaPlusCB["BlockGuildAnnounce"]:HookScript("OnClick", SetChatFilter)
			SetChatFilter()

			-- Reset button handler
			ChatFilterPanel.r:SetScript("OnClick", function()

				-- Reset controls
				LeaPlusLC["BlockSpellLinks"] = "Off"
				LeaPlusLC["BlockDrunkenSpam"] = "Off"
				LeaPlusLC["BlockDuelSpam"] = "Off"
				LeaPlusLC["BlockGuildAnnounce"] = "Off"
				SetChatFilter()

				-- Refresh configuration panel
				ChatFilterPanel:Hide(); ChatFilterPanel:Show()

			end)

			-- Show configuration panal when options panel button is clicked
			LeaPlusCB["FilterChatMessagesBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["BlockSpellLinks"] = "On"
					LeaPlusLC["BlockDrunkenSpam"] = "On"
					LeaPlusLC["BlockDuelSpam"] = "On"
					LeaPlusLC["BlockGuildAnnounce"] = "On"
					SetChatFilter()
				else
					ChatFilterPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

		end

		----------------------------------------------------------------------
		-- Automatically accept resurrection requests (no reload required)
		----------------------------------------------------------------------

		do

			-- Create configuration panel
			local AcceptResPanel = LeaPlusLC:CreatePanel("Accept resurrection", "AcceptResPanel")

			LeaPlusLC:MakeTx(AcceptResPanel, "Settings", 16, -72)
			LeaPlusLC:MakeCB(AcceptResPanel, "AutoResNoCombat", "Exclude combat resurrection", 16, -92, false, "If checked, resurrection requests will not be automatically accepted if the player resurrecting you is in combat.")

			-- Help button hidden
			AcceptResPanel.h:Hide()

			-- Back button handler
			AcceptResPanel.b:SetScript("OnClick", function()
				AcceptResPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page1"]:Show();
				return
			end)

			-- Reset button handler
			AcceptResPanel.r:SetScript("OnClick", function()

				-- Reset checkboxes
				LeaPlusLC["AutoResNoCombat"] = "On"

				-- Refresh panel
				AcceptResPanel:Hide(); AcceptResPanel:Show()

			end)

			-- Show panal when options panel button is clicked
			LeaPlusCB["AutoAcceptResBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["AutoResNoCombat"] = "On"
				else
					AcceptResPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

			-- Function to set resurrect event
			local function SetResEvent()
				if LeaPlusLC["AutoAcceptRes"] == "On" then
					AcceptResPanel:RegisterEvent("RESURRECT_REQUEST")
				else
					AcceptResPanel:UnregisterEvent("RESURRECT_REQUEST")
				end
			end

			-- Run function when option is clicked and on startup if option is enabled
			LeaPlusCB["AutoAcceptRes"]:HookScript("OnClick", SetResEvent)
			if LeaPlusLC["AutoAcceptRes"] == "On" then SetResEvent() end

			-- Function to not accept resurrection based on certain conditions
			local function DoNotAcceptResurrect()
				local mapID = C_Map.GetBestMapForUnit("player") or nil
				if mapID and mapID == 162 then -- Naxxramas Construct Quarter
					-- Check party or raid for debuffs
					local group = IsInRaid() and "raid" or "party"
					for i = 1, GetNumGroupMembers() do
						local unit = group .. i
						if unit and UnitExists(unit) then
							for j = 1, 40 do
								local void, void, void, void, void, void, void, void, void, spellID = UnitDebuff(unit, j)
								if spellID then
									if spellID == 28059 or spellID == 28084 then
										-- Thaddius positive and negative charge debuffs
										LeaPlusLC:Print("Resurrection not accepted.  Someone in your group has a charge debuff.")
										return true
									end
								end
							end
						end
					end
				end
			end

			-- Handle event
			AcceptResPanel:SetScript("OnEvent", function(self, event, arg1)
				if event == "RESURRECT_REQUEST" then

					-- Exclude Chained Spirit (Zul'Gurub)
					local chainLoc

					-- Exclude Chained Spirit (Zul'Gurub)
					chainLoc = "Chained Spirit"
					if 	   GameLocale == "zhCN" then chainLoc = "被禁锢的灵魂"
					elseif GameLocale == "zhTW" then chainLoc = "禁錮之魂"
					elseif GameLocale == "ruRU" then chainLoc = "Скованный дух"
					elseif GameLocale == "koKR" then chainLoc = "구속된 영혼"
					elseif GameLocale == "esMX" then chainLoc = "Espíritu encadenado"
					elseif GameLocale == "ptBR" then chainLoc = "Espírito Acorrentado"
					elseif GameLocale == "deDE" then chainLoc = "Angeketteter Geist"
					elseif GameLocale == "esES" then chainLoc = "Espíritu encadenado"
					elseif GameLocale == "frFR" then chainLoc = "Esprit enchaîné"
					elseif GameLocale == "itIT" then chainLoc = "Spirito Incatenato"
					end
					if arg1 == chainLoc then return	end

					-- Resurrect
					local resTimer = GetCorpseRecoveryDelay()
					if resTimer and resTimer > 0 then
						-- Resurrect has a delay so wait before resurrecting
						C_Timer.After(resTimer + 1, function()
							if not UnitAffectingCombat(arg1) or LeaPlusLC["AutoResNoCombat"] == "Off" then
								if LeaPlusLC["AutoAcceptRes"] == "On" then
									if not DoNotAcceptResurrect() then
										AcceptResurrect()
										StaticPopup_Hide("RESURRECT_NO_TIMER")
									end
								end
							end
						end)
					else
						-- Resurrect has no delay so resurrect now
						if not UnitAffectingCombat(arg1) or LeaPlusLC["AutoResNoCombat"] == "Off" then
							if not DoNotAcceptResurrect() then
								AcceptResurrect()
								StaticPopup_Hide("RESURRECT_NO_TIMER")
							end
						end
					end

					return

				end
			end)

		end

		----------------------------------------------------------------------
		-- Hide keybind text
		----------------------------------------------------------------------

		if LeaPlusLC["HideKeybindText"] == "On" and not LeaLockList["HideKeybindText"] then

			-- Hide keybind text
			for i = 1, 12 do
				_G["ActionButton"..i.."HotKey"]:SetAlpha(0) -- Main bar
				_G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(0) -- Bottom right bar
				_G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(0) -- Bottom left bar
				_G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(0) -- Right bar
				_G["MultiBarLeftButton"..i.."HotKey"]:SetAlpha(0) -- Left bar
			end

		end

		----------------------------------------------------------------------
		-- Hide macro text
		----------------------------------------------------------------------

		if LeaPlusLC["HideMacroText"] == "On" and not LeaLockList["HideMacroText"] then

			-- Hide marco text
			for i = 1, 12 do
				_G["ActionButton"..i.."Name"]:SetAlpha(0) -- Main bar
				_G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(0) -- Bottom right bar
				_G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(0) -- Bottom left bar
				_G["MultiBarRightButton"..i.."Name"]:SetAlpha(0) -- Right bar
				_G["MultiBarLeftButton"..i.."Name"]:SetAlpha(0) -- Left bar
			end

		end

		----------------------------------------------------------------------
		-- More font sizes
		----------------------------------------------------------------------

		if LeaPlusLC["MoreFontSizes"] == "On" and not LeaLockList["MoreFontSizes"] then
			RunScript('CHAT_FONT_HEIGHTS = {[1] = 10, [2] = 12, [3] = 14, [4] = 16, [5] = 18, [6] = 20, [7] = 22, [8] = 24, [9] = 26, [10] = 28}')
		end

		----------------------------------------------------------------------
		--	Show vanity controls (must be before Enhance dressup)
		----------------------------------------------------------------------

		if LeaPlusLC["ShowVanityControls"] == "On" then

			-- Create checkboxes
			LeaPlusLC:MakeCB(PaperDollFrame, "ShowHelm", L["Helm"], 2, -192, false, "")
			LeaPlusLC:MakeCB(PaperDollFrame, "ShowCloak", L["Cloak"], 281, -192, false, "")
			LeaPlusCB["ShowHelm"]:SetFrameStrata("HIGH")
			LeaPlusCB["ShowCloak"]:SetFrameStrata("HIGH")

			-- Function to set vanity controls layout
			local function SetVanityControlsLayout()

				-- ElvUI_WrathArmory: Position helm and cloak checkboxes
				if LeaPlusLC.ElvUI then
					local E = LeaPlusLC.ElvUI:GetModule("ElvUI_WrathArmory", true)
					if E then
						LeaPlusCB["ShowHelm"].f:SetText(L["H"])
						LeaPlusCB["ShowHelm"].f:ClearAllPoints()
						LeaPlusCB["ShowHelm"].f:SetPoint("RIGHT", LeaPlusCB["ShowHelm"], "LEFT", 4, 0)
						LeaPlusCB["ShowHelm"]:ClearAllPoints()
						LeaPlusCB["ShowHelm"]:SetPoint("BOTTOMLEFT", CharacterFrame, "BOTTOMLEFT", 80, 110)
						LeaPlusCB["ShowHelm"]:SetHitRectInsets(-LeaPlusCB["ShowHelm"].f:GetStringWidth() + 4, 3, 0, 0)
						LeaPlusCB["ShowCloak"].f:SetText(L["C"])
						LeaPlusCB["ShowCloak"].f:ClearAllPoints()
						LeaPlusCB["ShowCloak"].f:SetPoint("RIGHT", LeaPlusCB["ShowCloak"], "LEFT", 4, 0)
						LeaPlusCB["ShowCloak"]:ClearAllPoints()
						LeaPlusCB["ShowCloak"]:SetPoint("LEFT", LeaPlusCB["ShowHelm"], "RIGHT", 4, 0)
						LeaPlusCB["ShowCloak"]:SetHitRectInsets(-LeaPlusCB["ShowCloak"].f:GetStringWidth() + 4, 3, 0, 0)
						return
					end
				end

				-- Position helm and cloak checkboxes
				if LeaPlusLC["VanityAltLayout"] == "On" then
					-- Alternative layout
					LeaPlusCB["ShowHelm"].f:SetText(L["H"])
					LeaPlusCB["ShowHelm"]:ClearAllPoints()
					LeaPlusCB["ShowHelm"]:SetPoint("TOPLEFT", 264, -348)
					LeaPlusCB["ShowHelm"]:SetHitRectInsets(-LeaPlusCB["ShowHelm"].f:GetStringWidth() + 4, 3, 0, 0)
					LeaPlusCB["ShowHelm"].f:ClearAllPoints()
					LeaPlusCB["ShowHelm"].f:SetPoint("RIGHT", LeaPlusCB["ShowHelm"], "LEFT", 4, 0)

					LeaPlusCB["ShowCloak"].f:SetText(L["C"])
					LeaPlusCB["ShowCloak"]:ClearAllPoints()
					LeaPlusCB["ShowCloak"]:SetPoint("TOP", LeaPlusCB["ShowHelm"], "BOTTOM", 0, 6)
					LeaPlusCB["ShowCloak"].f:ClearAllPoints()
					LeaPlusCB["ShowCloak"].f:SetPoint("RIGHT", LeaPlusCB["ShowCloak"], "LEFT", 4, 0)
					LeaPlusCB["ShowCloak"]:SetHitRectInsets(-LeaPlusCB["ShowCloak"].f:GetStringWidth() + 4, 3, 0, 0)
				else
					-- Default layout
					LeaPlusCB["ShowHelm"].f:SetText(L["H"])
					LeaPlusCB["ShowHelm"]:ClearAllPoints()
					LeaPlusCB["ShowHelm"]:SetPoint("TOPLEFT", 52, -366)
					LeaPlusCB["ShowHelm"]:SetHitRectInsets(3, -LeaPlusCB["ShowHelm"].f:GetStringWidth(), 0, 0)
					LeaPlusCB["ShowHelm"].f:ClearAllPoints()
					LeaPlusCB["ShowHelm"].f:SetPoint("LEFT", LeaPlusCB["ShowHelm"], "RIGHT", 0, 0)
					LeaPlusCB["ShowCloak"].f:SetText(L["C"])
					LeaPlusCB["ShowCloak"]:ClearAllPoints()
					LeaPlusCB["ShowCloak"]:SetPoint("LEFT", LeaPlusCB["ShowHelm"].f, "RIGHT", 10, 0)
					LeaPlusCB["ShowCloak"]:SetHitRectInsets(-LeaPlusCB["ShowCloak"].f:GetStringWidth(), 3, 0, 0)
					LeaPlusCB["ShowCloak"].f:ClearAllPoints()
					LeaPlusCB["ShowCloak"].f:SetPoint("RIGHT", LeaPlusCB["ShowCloak"], "LEFT", 0, 0)
				end
			end

			-- Set position when controls are shift/right-clicked
			LeaPlusCB["ShowHelm"]:SetScript('OnMouseDown', function(self, btn)
				if btn == "RightButton" and IsShiftKeyDown() then
					if LeaPlusLC["VanityAltLayout"] == "On" then LeaPlusLC["VanityAltLayout"] = "Off" else LeaPlusLC["VanityAltLayout"] = "On" end
					SetVanityControlsLayout()
				end
			end)

			LeaPlusCB["ShowCloak"]:SetScript('OnMouseDown', function(self, btn)
				if btn == "RightButton" and IsShiftKeyDown() then
					if LeaPlusLC["VanityAltLayout"] == "On" then LeaPlusLC["VanityAltLayout"] = "Off" else LeaPlusLC["VanityAltLayout"] = "On" end
					SetVanityControlsLayout()
				end
			end)

			-- Set controls on startup
			SetVanityControlsLayout()

			-- Manage alpha
			LeaPlusCB["ShowHelm"]:SetAlpha(0.3)
			LeaPlusCB["ShowCloak"]:SetAlpha(0.3)
			LeaPlusCB["ShowHelm"]:HookScript("OnEnter", function() LeaPlusCB["ShowHelm"]:SetAlpha(1.0) end)
			LeaPlusCB["ShowHelm"]:HookScript("OnLeave", function() LeaPlusCB["ShowHelm"]:SetAlpha(0.3) end)
			LeaPlusCB["ShowCloak"]:HookScript("OnEnter", function()	LeaPlusCB["ShowCloak"]:SetAlpha(1.0) end)
			LeaPlusCB["ShowCloak"]:HookScript("OnLeave", function()	LeaPlusCB["ShowCloak"]:SetAlpha(0.3) end)

			-- Toggle helm with click
			LeaPlusCB["ShowHelm"]:HookScript("OnClick", function()
				LeaPlusCB["ShowHelm"]:Disable()
				LeaPlusCB["ShowHelm"]:SetAlpha(1.0)
				C_Timer.After(0.5, function()
					if ShowingHelm() then
						ShowHelm(false)
					else
						ShowHelm(true)
					end
					LeaPlusCB["ShowHelm"]:Enable()
					if not LeaPlusCB["ShowHelm"]:IsMouseOver() then
						LeaPlusCB["ShowHelm"]:SetAlpha(0.3)
					end
				end)
			end)

			-- Toggle cloak with click
			LeaPlusCB["ShowCloak"]:HookScript("OnClick", function()
				LeaPlusCB["ShowCloak"]:Disable()
				LeaPlusCB["ShowCloak"]:SetAlpha(1.0)
				C_Timer.After(0.5, function()
					if ShowingCloak() then
						ShowCloak(false)
					else
						ShowCloak(true)
					end
					LeaPlusCB["ShowCloak"]:Enable()
					if not LeaPlusCB["ShowCloak"]:IsMouseOver() then
						LeaPlusCB["ShowCloak"]:SetAlpha(0.3)
					end
				end)
			end)

			-- Set checkbox state when checkboxes are shown
			LeaPlusCB["ShowCloak"]:HookScript("OnShow", function()
				if ShowingHelm() then
					LeaPlusCB["ShowHelm"]:SetChecked(true)
				else
					LeaPlusCB["ShowHelm"]:SetChecked(false)
				end
				if ShowingCloak() then
					LeaPlusCB["ShowCloak"]:SetChecked(true)
				else
					LeaPlusCB["ShowCloak"]:SetChecked(false)
				end
			end)

		end

		----------------------------------------------------------------------
		-- Enhance dressup
		----------------------------------------------------------------------

		if LeaPlusLC["EnhanceDressup"] == "On" then

			-- Create configuration panel
			local DressupPanel = LeaPlusLC:CreatePanel("Enhance dressup", "DressupPanel")

			LeaPlusLC:MakeTx(DressupPanel, "Settings", 16, -72)
			LeaPlusLC:MakeCB(DressupPanel, "DressupItemButtons", "Show item buttons", 16, -92, false, "If checked, item buttons will be shown in the dressing room.  You can click the item buttons to remove individual items from the model.")
			LeaPlusLC:MakeCB(DressupPanel, "DressupAnimControl", "Show animation slider", 16, -112, false, "If checked, an animation slider will be shown in the dressing room.")

			LeaPlusLC:MakeTx(DressupPanel, "Transmogrify character preview", 16, -152)
			LeaPlusLC:MakeCB(DressupPanel, "DressupWiderPreview", "Wider character preview", 16, -172, true, "If checked, the transmogrify character preview will be wider.")
			LeaPlusLC:MakeCB(DressupPanel, "DressupTransmogAnim", "Show animation slider", 16, -192, false, "If checked, an animation slider will be shown in the transmogrify character preview.")

			LeaPlusLC:MakeTx(DressupPanel, "Zoom speed", 356, -72)
			LeaPlusLC:MakeSL(DressupPanel, "DressupFasterZoom", "Drag to set the character model zoom speed.", 1, 10, 1, 356, -92, "%.0f")

			-- Refresh zoom speed slider when changed
			LeaPlusCB["DressupFasterZoom"]:HookScript("OnValueChanged", function()
				LeaPlusCB["DressupFasterZoom"].f:SetFormattedText("%.0f%%", LeaPlusLC["DressupFasterZoom"] * 100)
			end)

			-- Set zoom speed when character frame model is zoomed
			CharacterModelScene:SetScript("OnMouseWheel", function(self, delta)
				for i = 1, LeaPlusLC["DressupFasterZoom"] do
					if CharacterModelScene.activeCamera then
						CharacterModelScene.activeCamera:OnMouseWheel(delta)
					end
				end
			end)

			-- Help button hidden
			DressupPanel.h:Hide()

			-- Back button handler
			DressupPanel.b:SetScript("OnClick", function()
				DressupPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page5"]:Show()
				return
			end)

			-- Reset button handler
			DressupPanel.r:SetScript("OnClick", function()

				-- Reset controls
				LeaPlusLC["DressupFasterZoom"] = 3

				-- Refresh configuration panel
				DressupPanel:Hide(); DressupPanel:Show()

			end)

			-- Show configuration panal when options panel button is clicked
			LeaPlusCB["EnhanceDressupBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["DressupFasterZoom"] = 3
				else
					DressupPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

			----------------------------------------------------------------------
			-- Item buttons
			----------------------------------------------------------------------

			do

				local buttons = {}
				local slotTable = {"HeadSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "MainHandSlot", "SecondaryHandSlot"}
				local texTable = {"INV_Misc_Desecrated_ClothHelm", "INV_Misc_Desecrated_ClothShoulder", "INV_Misc_Cape_01", "INV_Misc_Desecrated_ClothChest", "INV_Shirt_01", "INV_Shirt_GuildTabard_01", "INV_Misc_Desecrated_ClothBracer", "INV_Misc_Desecrated_ClothGlove", "INV_Misc_Desecrated_ClothBelt", "INV_Misc_Desecrated_ClothPants", "INV_Misc_Desecrated_ClothBoots", "INV_Sword_01", "INV_Shield_01"}

				local function MakeSlotButton(number, slot, anchor, x, y)

					-- Create slot button
					local slotBtn = CreateFrame("Button", nil, DressUpFrame)
					slotBtn:SetFrameStrata("HIGH")
					slotBtn:SetSize(30, 30)
					slotBtn.slot = slot
					slotBtn:ClearAllPoints()
					slotBtn:SetPoint(anchor, x, y)
					slotBtn:RegisterForClicks("LeftButtonUp")
					slotBtn:SetMotionScriptsWhileDisabled(true)

					-- Slot button click
					slotBtn:SetScript("OnClick", function(self, btn)
						if btn == "LeftButton" then
							local slotID = GetInventorySlotInfo(self.slot)
							DressUpFrame.DressUpModel:UndressSlot(slotID)
						end
					end)

					-- Slot button tooltip
					slotBtn:SetScript("OnEnter", function(self)
						GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
						if self.item then
							GameTooltip:SetHyperlink(self.item)
						else
							if self.slot then
								GameTooltip:SetText(_G[string.upper(self.slot)])
							end
						end
					end)
					slotBtn:SetScript("OnLeave", GameTooltip_Hide)

					-- Slot button textures
					slotBtn.t = slotBtn:CreateTexture(nil, "BACKGROUND")
					slotBtn.t:SetSize(30, 30)
					slotBtn.t:SetPoint("CENTER")
					slotBtn.t:SetDesaturated(true)
					slotBtn.t:SetTexture("interface\\icons\\" .. texTable[number])

					slotBtn.h = slotBtn:CreateTexture()
					slotBtn.h:SetSize(30, 30)
					slotBtn.h:SetPoint("CENTER")
					slotBtn.h:SetAtlas("bags-glow-white")
					slotBtn.h:SetBlendMode("ADD")
					slotBtn:SetHighlightTexture(slotBtn.h)

					-- Add slot button to table
					tinsert(buttons, slotBtn)

				end

				-- Show left column slot buttons
				for i = 1, 7 do
					MakeSlotButton(i, slotTable[i], "TOPLEFT", 12, -68 + -35 * (i - 1))
				end

				-- Show right column slot buttons
				for i = 8, 13 do
					MakeSlotButton(i, slotTable[i], "TOPRIGHT", -14, -68 + -35 * (i - 8))
				end

				-- Function to set item buttons
				local function ToggleItemButtons()
					if LeaPlusLC["DressupItemButtons"] == "On" then
						for i = 1, #buttons do buttons[i]:Show() end
					else
						for i = 1, #buttons do buttons[i]:Hide() end
					end
				end
				LeaPlusLC.ToggleItemButtons = ToggleItemButtons

				-- Set item buttons for option click, startup, reset click and preset click
				LeaPlusCB["DressupItemButtons"]:HookScript("OnClick", ToggleItemButtons)
				ToggleItemButtons()
				DressupPanel.r:HookScript("OnClick", function()
					LeaPlusLC["DressupItemButtons"] = "On"
					ToggleItemButtons()
					DressupPanel:Hide(); DressupPanel:Show()
				end)
				LeaPlusCB["EnhanceDressupBtn"]:HookScript("OnClick", function()
					if IsShiftKeyDown() and IsControlKeyDown() then
						LeaPlusLC["DressupItemButtons"] = "On"
						ToggleItemButtons()
					end
				end)

			end

			----------------------------------------------------------------------
			-- Animation slider (must be before bottom row buttons)
			----------------------------------------------------------------------

			local animTable = {0, 4, 5, 143, 119, 26, 25, 27, 28, 108, 120, 51, 124, 52, 125, 126, 62, 63, 41, 42, 43, 44, 132, 38, 14, 115, 193, 48, 110, 109, 134, 197, 0}
			local lastSetting

			LeaPlusLC["DressupAnim"] = 0 -- Defined here since the setting is not saved
			LeaPlusLC:MakeSL(DressUpFrame, "DressupAnim", "", 1, #animTable - 1, 1, 356, -92, "%.0f")
			LeaPlusCB["DressupAnim"]:ClearAllPoints()
			LeaPlusCB["DressupAnim"]:SetPoint("BOTTOM", -12, 34)
			LeaPlusCB["DressupAnim"]:SetWidth(226)
			LeaPlusCB["DressupAnim"]:SetFrameLevel(5)
			LeaPlusCB["DressupAnim"]:HookScript("OnValueChanged", function(self, setting)
				local playerActor = DressUpFrame.DressUpModel
				setting = math.floor(setting + 0.5)
				if playerActor and setting ~= lastSetting then
					lastSetting = setting
					DressUpFrame.DressUpModel:SetAnimation(animTable[setting], 0, 1, 1)
					-- print(animTable[setting]) -- Debug
				end
			end)

			-- Function to show animation control
			local function SetAnimationSlider()
				if LeaPlusLC["DressupAnimControl"] == "On" then
					LeaPlusCB["DressupAnim"]:Show()
				else
					LeaPlusCB["DressupAnim"]:Hide()
				end
				LeaPlusCB["DressupAnim"]:SetValue(1)
			end

			-- Set animation control with option, startup, preset and reset
			LeaPlusCB["DressupAnimControl"]:HookScript("OnClick", SetAnimationSlider)
			SetAnimationSlider()
			LeaPlusCB["EnhanceDressupBtn"]:HookScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					LeaPlusLC["DressupAnimControl"] = "On"
					SetAnimationSlider()
				end
			end)
			DressupPanel.r:HookScript("OnClick", function()
				LeaPlusLC["DressupAnimControl"] = "On"
				SetAnimationSlider()
				DressupPanel:Hide(); DressupPanel:Show()
			end)

			-- Reset animation when dressup frame is shown and model is reset
			hooksecurefunc(DressUpFrame, "Show", SetAnimationSlider)
			DressUpFrameResetButton:HookScript("OnClick", SetAnimationSlider)

			-- Skin slider for ElvUI
			if LeaPlusLC.ElvUI then
				_G.LeaPlusGlobalDressupAnim = LeaPlusCB["DressupAnim"]
				LeaPlusLC.ElvUI:GetModule("Skins"):HandleSliderFrame(_G.LeaPlusGlobalDressupAnim, false)
			end

			----------------------------------------------------------------------
			-- Bottom row buttons
			----------------------------------------------------------------------

			-- Function to modify a button
			local function SetButton(where, text, tip)
				if text ~= "" then
					where:SetText(L[text])
					where:SetWidth(where:GetFontString():GetStringWidth() + 20)
				end
				where:HookScript("OnEnter", function()
					GameTooltip:SetOwner(where, "ANCHOR_NONE")
					GameTooltip:SetPoint("BOTTOM", where, "TOP", 0, 10)
					GameTooltip:SetText(L[tip], nil, nil, nil, nil, true)
				end)
				where:HookScript("OnLeave", GameTooltip_Hide)
			end

			-- Close
			SetButton(DressUpFrameCancelButton, "", "Close")
			DressUpFrameCancelButton:ClearAllPoints()
			DressUpFrameCancelButton:SetPoint("BOTTOMRIGHT", DressUpFrame, "BOTTOMRIGHT", -4, 4)

			-- Reset
			SetButton(DressUpFrameResetButton, "R", "Reset")

			-- Nude
			LeaPlusLC:CreateButton("DressUpNudeBtn", DressUpFrameResetButton, "N", "BOTTOMLEFT", 106, 79, 80, 22, false, "")
			LeaPlusCB["DressUpNudeBtn"]:SetFrameLevel(3)
			LeaPlusCB["DressUpNudeBtn"]:ClearAllPoints()
			LeaPlusCB["DressUpNudeBtn"]:SetPoint("RIGHT", DressUpFrameResetButton, "LEFT", 0, 0)
			SetButton(LeaPlusCB["DressUpNudeBtn"], "N", "Remove all items")
			LeaPlusCB["DressUpNudeBtn"]:SetScript("OnClick", function()
				DressUpFrame.DressUpModel:Undress()
			end)

			-- Show me
			LeaPlusLC:CreateButton("DressUpShowMeBtn", DressUpFrameResetButton, "M", "BOTTOMLEFT", 26, 79, 80, 22, false, "")
			LeaPlusCB["DressUpShowMeBtn"]:ClearAllPoints()
			LeaPlusCB["DressUpShowMeBtn"]:SetPoint("RIGHT", LeaPlusCB["DressUpNudeBtn"], "LEFT", 0, 0)
			SetButton(LeaPlusCB["DressUpShowMeBtn"], "M", "Show me")
			LeaPlusCB["DressUpShowMeBtn"]:SetScript("OnClick", function()
				local playerActor = DressUpFrame.DressUpModel
				playerActor:SetUnit("player")
				-- Set animation
				playerActor:SetAnimation(0)
				C_Timer.After(0.1,function()
					playerActor:SetAnimation(animTable[math.floor(LeaPlusCB["DressupAnim"]:GetValue() + 0.5)], 0, 1, 1)
				end)
			end)

			-- Show my outfit on target
			--[[LeaPlusLC:CreateButton("DressUpOutfitOnTargetBtn", DressUpFrameResetButton, "O", "BOTTOMLEFT", 26, 79, 80, 22, false, "")
			LeaPlusCB["DressUpOutfitOnTargetBtn"]:ClearAllPoints()
			LeaPlusCB["DressUpOutfitOnTargetBtn"]:SetPoint("RIGHT", LeaPlusCB["DressUpNudeBtn"], "LEFT", 0, 0)
			SetButton(LeaPlusCB["DressUpOutfitOnTargetBtn"], "O", "Show my outfit on target")
			LeaPlusCB["DressUpOutfitOnTargetBtn"]:SetScript("OnClick", function()
				if UnitIsPlayer("target") then
					DressUpFrame.DressUpModel:SetUnit("target")
					DressUpFrame.DressUpModel:Undress()
					C_Timer.After(0.01, function()
						for i = 1, 19 do
							local itemName = GetInventoryItemID("player", i)
							if itemName then
								DressUpFrame.DressUpModel:TryOn("item:" .. itemName)
							end
						end
					end)
				end
			end)]]

			-- Target
			LeaPlusLC:CreateButton("DressUpTargetBtn", DressUpFrameResetButton, "T", "BOTTOMLEFT", 26, 79, 80, 22, false, "")
			LeaPlusCB["DressUpTargetBtn"]:ClearAllPoints()
			LeaPlusCB["DressUpTargetBtn"]:SetPoint("RIGHT", LeaPlusCB["DressUpShowMeBtn"], "LEFT", 0, 0)
			SetButton(LeaPlusCB["DressUpTargetBtn"], "T", "Show target model")
			LeaPlusCB["DressUpTargetBtn"]:SetScript("OnClick", function()
				if UnitIsPlayer("target") then
					local playerActor = DressUpFrame.DressUpModel
					if playerActor then
						playerActor:SetUnit("target")
						-- Set animation
						playerActor:SetAnimation(0)
						C_Timer.After(0.1,function()
							playerActor:SetAnimation(animTable[math.floor(LeaPlusCB["DressupAnim"]:GetValue() + 0.5)], 0, 1, 1)
						end)
					end
				end
			end)

			-- Toggle buttons
			LeaPlusLC:CreateButton("DressUpButonsBtn", DressUpFrameResetButton, "B", "BOTTOMLEFT", 26, 79, 80, 22, false, "")
			LeaPlusCB["DressUpButonsBtn"]:ClearAllPoints()
			LeaPlusCB["DressUpButonsBtn"]:SetPoint("RIGHT", LeaPlusCB["DressUpTargetBtn"], "LEFT", 0, 0)
			SetButton(LeaPlusCB["DressUpButonsBtn"], "B", "Toggle buttons")
			LeaPlusCB["DressUpButonsBtn"]:SetScript("OnClick", function()
				if LeaPlusLC["DressupItemButtons"] == "On" then LeaPlusLC["DressupItemButtons"] = "Off" else LeaPlusLC["DressupItemButtons"] = "On" end
				LeaPlusLC:ToggleItemButtons()
				if DressupPanel:IsShown() then DressupPanel:Hide(); DressupPanel:Show() end
			end)

			-- Show nearby target outfit on me button
			--[[LeaPlusLC:CreateButton("DressUpTargetSelfBtn", DressUpFrameResetButton, "S", "BOTTOMLEFT", 26, 79, 80, 22, false, "")
			LeaPlusCB["DressUpTargetSelfBtn"]:ClearAllPoints()
			LeaPlusCB["DressUpTargetSelfBtn"]:SetPoint("RIGHT", LeaPlusCB["DressUpTargetBtn"], "LEFT", 0, 0)
			SetButton(LeaPlusCB["DressUpTargetSelfBtn"], "S", "Show nearby target outfit on me")
			LeaPlusCB["DressUpTargetSelfBtn"]:SetScript("OnClick", function()
				if UnitIsPlayer("target") then
					if not CanInspect("target") then
						ActionStatus_DisplayMessage(L["Target out of range."], true)
						return
					end
					NotifyInspect("target")
					LeaPlusCB["DressUpTargetSelfBtn"]:RegisterEvent("INSPECT_READY")
					LeaPlusCB["DressUpTargetSelfBtn"]:SetScript("OnEvent", function()
						DressUpFrame.DressUpModel:SetUnit("player")
						DressUpFrame.DressUpModel:Undress()
						C_Timer.After(0.01, function()
							for i = 1, 19 do
								local itemName = GetInventoryItemID("target", i)
								C_Timer.After(0.01, function()
									if itemName then
										DressUpFrame.DressUpModel:TryOn("item:" .. itemName)
									end
								end)
							end
						end)
						LeaPlusCB["DressUpTargetSelfBtn"]:UnregisterEvent("INSPECT_READY")
					end)
				end
			end)]]

			-- Change player actor to player when reset button is clicked (needed because target button changes it)
			DressUpFrameResetButton:HookScript("OnClick", function()
				DressUpFrame.DressUpModel:SetUnit("player")
			end)

			-- Auction house
			local BtnStrata, BtnLevel = SideDressUpModelResetButton:GetFrameStrata(), SideDressUpModelResetButton:GetFrameLevel()

			-- Add buttons to auction house dressup frame
			LeaPlusLC:CreateButton("DressUpSideBtn", SideDressUpModelResetButton, "Tabard", "BOTTOMLEFT", -36, -31, 60, 22, false, "")
			LeaPlusCB["DressUpSideBtn"]:SetFrameStrata(BtnStrata)
			LeaPlusCB["DressUpSideBtn"]:SetFrameLevel(BtnLevel)
			LeaPlusCB["DressUpSideBtn"]:SetScript("OnClick", function()
				SideDressUpModel:UndressSlot(19)
			end)

			LeaPlusLC:CreateButton("DressUpSideNudeBtn", SideDressUpModelResetButton, "Nude", "BOTTOMRIGHT", 39, -31, 60, 22, false, "")
			LeaPlusCB["DressUpSideNudeBtn"]:SetFrameStrata(BtnStrata)
			LeaPlusCB["DressUpSideNudeBtn"]:SetFrameLevel(BtnLevel)
			LeaPlusCB["DressUpSideNudeBtn"]:SetScript("OnClick", function()
				SideDressUpModel:Undress()
			end)

			-- Skin buttons for ElvUI
			if LeaPlusLC.ElvUI then
				_G.LeaPlusGlobalDressUpButtonsButton = LeaPlusCB["DressUpButonsBtn"]
				LeaPlusLC.ElvUI:GetModule("Skins"):HandleButton(_G.LeaPlusGlobalDressUpButtonsButton)

				_G.LeaPlusGlobalDressUpShowMeButton = LeaPlusCB["DressUpShowMeBtn"]
				LeaPlusLC.ElvUI:GetModule("Skins"):HandleButton(_G.LeaPlusGlobalDressUpShowMeButton)

				_G.LeaPlusGlobalDressUpTargetButton = LeaPlusCB["DressUpTargetBtn"]
				LeaPlusLC.ElvUI:GetModule("Skins"):HandleButton(_G.LeaPlusGlobalDressUpTargetButton)

				_G.LeaPlusGlobalDressUpNudeButton = LeaPlusCB["DressUpNudeBtn"]
				LeaPlusLC.ElvUI:GetModule("Skins"):HandleButton(_G.LeaPlusGlobalDressUpNudeButton)
			end

			----------------------------------------------------------------------
			-- Controls
			----------------------------------------------------------------------

			-- Hide controls for character frame
			CharacterModelScene.ControlFrame:HookScript("OnShow", function()
				CharacterModelScene.ControlFrame:Hide()
			end)

			-- Hide controls for dressing room
			DressUpModelFrameRotateLeftButton:HookScript("OnShow", DressUpModelFrameRotateLeftButton.Hide)
			DressUpModelFrameRotateRightButton:HookScript("OnShow", DressUpModelFrameRotateRightButton.Hide)
			SideDressUpModelControlFrame:HookScript("OnShow", SideDressUpModelControlFrame.Hide)

			-- Hide controls for shop
			ModelPreviewFrame.Display.ModelScene.ControlFrame:HookScript("OnShow", function()
				if StorePreviewFrame and StorePreviewFrame:IsShown() then
					ModelPreviewFrame.Display.ModelScene.ControlFrame:Hide()
				end
			end)

			----------------------------------------------------------------------
			-- Wardrobe and inspect system
			----------------------------------------------------------------------

			-- Wardrobe (used by transmogrifier NPC) and mount journal
			EventUtil.ContinueOnAddOnLoaded("Blizzard_Collections",function()

				-- Hide positioning controls for mount journal
				MountJournal.MountDisplay.ModelScene.RotateLeftButton:Hide()
				MountJournal.MountDisplay.ModelScene.RotateRightButton:Hide()

				-- Hide positioning controls for wardrobe
				WardrobeTransmogFrameControlFrame:HookScript("OnShow", WardrobeTransmogFrameControlFrame.Hide)

				-- Set zoom speed for mount journal
				MountJournal.MountDisplay.ModelScene:SetScript("OnMouseWheel", function(self, delta)
					for i = 1, LeaPlusLC["DressupFasterZoom"] do
						if MountJournal.MountDisplay.ModelScene.activeCamera then
							MountJournal.MountDisplay.ModelScene.activeCamera:OnMouseWheel(delta)
						end
					end
				end)

				-- Set zoom speed for pet journal
				PetJournalPetCard.modelScene:SetScript("OnMouseWheel", function(self, delta)
					for i = 1, LeaPlusLC["DressupFasterZoom"] do
						if PetJournalPetCard.modelScene.activeCamera then
							PetJournalPetCard.modelScene.activeCamera:OnMouseWheel(delta)
						end
					end
				end)

				-- Wider transmogrifier character preview
				if LeaPlusLC["DressupWiderPreview"] == "On" then

					local width = 1200 -- Default is 965
					WardrobeFrame:SetWidth(width)
					WardrobeTransmogFrame:SetWidth(width - 665)
					WardrobeTransmogFrame.Inset.BG:SetWidth(width - 671)
					WardrobeTransmogFrame.Model:SetWidth(width - 671)

					-- Left slots column
					WardrobeTransmogFrame.HeadButton:ClearAllPoints()
					WardrobeTransmogFrame.HeadButton:SetPoint("TOPLEFT", 15, -40)

					-- Right slots column
					WardrobeTransmogFrame.HandsButton:ClearAllPoints()
					WardrobeTransmogFrame.HandsButton:SetPoint("TOPRIGHT", -15, -40)

					-- Weapons
					WardrobeTransmogFrame.MainHandButton:ClearAllPoints()
					WardrobeTransmogFrame.MainHandButton:SetPoint("TOP", WardrobeTransmogFrame.FeetButton, "BOTTOM", 0, -10)
					WardrobeTransmogFrame.SecondaryHandButton:ClearAllPoints()
					WardrobeTransmogFrame.SecondaryHandButton:SetPoint("TOP", WardrobeTransmogFrame.MainHandButton, "BOTTOM", 0, -10)
					WardrobeTransmogFrame.RangedButton:ClearAllPoints()
					WardrobeTransmogFrame.RangedButton:SetPoint("TOP", WardrobeTransmogFrame.SecondaryHandButton, "BOTTOM", 0, -10)

				else

					-- Wider character preview is disabled so move the right column up
					WardrobeTransmogFrame.HandsButton:ClearAllPoints()
					WardrobeTransmogFrame.HandsButton:SetPoint("TOPRIGHT", -6, -40)

					-- Show weapons in the right column
					WardrobeTransmogFrame.MainHandButton:ClearAllPoints()
					WardrobeTransmogFrame.MainHandButton:SetPoint("TOP", WardrobeTransmogFrame.FeetButton, "BOTTOM", 0, -10)
					WardrobeTransmogFrame.SecondaryHandButton:ClearAllPoints()
					WardrobeTransmogFrame.SecondaryHandButton:SetPoint("TOP", WardrobeTransmogFrame.MainHandButton, "BOTTOM", 0, -10)
					WardrobeTransmogFrame.RangedButton:ClearAllPoints()
					WardrobeTransmogFrame.RangedButton:SetPoint("TOP", WardrobeTransmogFrame.SecondaryHandButton, "BOTTOM", 0, -10)

				end

				----------------------------------------------------------------------
				-- Transmogrify animation slider
				----------------------------------------------------------------------

				do

					local transmogAnimTable = {0, 4, 5, 143, 119, 26, 25, 27, 28, 108, 120, 51, 124, 52, 125, 126, 62, 63, 41, 42, 43, 44, 132, 38, 14, 115, 193, 48, 110, 109, 134, 197, 0}
					local transmogLastSetting

					LeaPlusLC["TransmogAnim"] = 0 -- Defined here since the setting is not saved
					LeaPlusLC:MakeSL(WardrobeTransmogFrame, "TransmogAnim", "", 1, #transmogAnimTable - 1, 1, 356, -92, "%.0f")
					LeaPlusCB["TransmogAnim"]:ClearAllPoints()
					LeaPlusCB["TransmogAnim"]:SetPoint("BOTTOM", 0, 6)
					if LeaPlusLC["DressupWiderPreview"] == "On" then
						LeaPlusCB["TransmogAnim"]:SetWidth(240)
					else
						LeaPlusCB["TransmogAnim"]:SetWidth(216)
					end
					LeaPlusCB["TransmogAnim"]:SetFrameLevel(5)
					LeaPlusCB["TransmogAnim"]:HookScript("OnValueChanged", function(self, setting)
						local playerActor = WardrobeTransmogFrame.Model
						setting = math.floor(setting + 0.5)
						if playerActor and setting ~= lastSetting then
							lastSetting = setting
							playerActor:SetAnimation(transmogAnimTable[setting], 0, 1, 1)
						end
					end)

					-- Function to show animation control
					local function SetAnimationSlider()
						if LeaPlusLC["DressupTransmogAnim"] == "On" then
							LeaPlusCB["TransmogAnim"]:Show()
						else
							LeaPlusCB["TransmogAnim"]:Hide()
						end
						LeaPlusCB["TransmogAnim"]:SetValue(1)
					end

					-- Set animation control with option, startup, preset and reset
					LeaPlusCB["DressupTransmogAnim"]:HookScript("OnClick", SetAnimationSlider)
					SetAnimationSlider()
					LeaPlusCB["EnhanceDressupBtn"]:HookScript("OnClick", function()
						if IsShiftKeyDown() and IsControlKeyDown() then
							LeaPlusLC["DressupTransmogAnim"] = "On"
							SetAnimationSlider()
						end
					end)
					DressupPanel.r:HookScript("OnClick", function()
						LeaPlusLC["DressupTransmogAnim"] = "Off"
						SetAnimationSlider()
						DressupPanel:Hide(); DressupPanel:Show()
					end)

					-- Reset animation when slider is shown
					LeaPlusCB["TransmogAnim"]:HookScript("OnShow", SetAnimationSlider)

					-- Skin slider for ElvUI
					if LeaPlusLC.ElvUI then
						_G.LeaPlusGlobalTransmogAnim = LeaPlusCB["TransmogAnim"]
						LeaPlusLC.ElvUI:GetModule("Skins"):HandleSliderFrame(_G.LeaPlusGlobalTransmogAnim, false)
					end

				end

			end)

			----------------------------------------------------------------------
			-- Enable zooming and panning
			----------------------------------------------------------------------

			-- Enable zooming for dressup frame
			DressUpModelFrame:HookScript("OnMouseWheel", Model_OnMouseWheel)

			-- Enable panning for dressup frame
			DressUpModelFrame:HookScript("OnMouseDown", function(self, btn)
				if btn == "RightButton" then
					Model_StartPanning(self)
				end
			end)

			DressUpModelFrame:HookScript("OnMouseUp", function(self, btn)
				Model_StopPanning(self)
			end)

			DressUpModelFrame:ClearAllPoints()
			DressUpModelFrame:SetPoint("TOPLEFT", DressUpFrame, 8, -64)
			DressUpModelFrame:SetPoint("BOTTOMRIGHT", DressUpFrame, -8, 30)

			-- Reset dressup frame when reset button clicked
			DressUpFrameResetButton:HookScript("OnClick", function()
				DressUpModelFrame.rotation = 0
				DressUpModelFrame:SetRotation(0)
				DressUpModelFrame:SetPosition(0, 0, 0)
				DressUpModelFrame.zoomLevel = 0
				DressUpModelFrame:SetPortraitZoom(0)
				DressUpModelFrame:RefreshCamera()
			end)

			-- Reset side dressup when reset button clicked
			SideDressUpModelResetButton:HookScript("OnClick", function()
				SideDressUpModel.rotation = 0
				SideDressUpModel:SetRotation(0)
				SideDressUpModel:SetPosition(0, 0, -0.1)
				SideDressUpModel.zoomLevel = 0
				SideDressUpModel:SetPortraitZoom(0)
				SideDressUpModel:RefreshCamera()
			end)

			----------------------------------------------------------------------
			-- Inspect system
			----------------------------------------------------------------------

			-- Inspect System
			EventUtil.ContinueOnAddOnLoaded("Blizzard_InspectUI",function()

				-- Hide model rotation controls
				InspectModelFrameRotateLeftButton:Hide()
				InspectModelFrameRotateRightButton:Hide()

				-- Enable zooming
				InspectModelFrame:HookScript("OnMouseWheel", Model_OnMouseWheel)

				-- Enable panning
				InspectModelFrame:HookScript("OnMouseDown", function(self, btn)
					if btn == "RightButton" then
						Model_StartPanning(self)
					end
				end)

				InspectModelFrame:HookScript("OnMouseUp", function(self, btn)
					Model_StopPanning(self)
				end)

			end)

		end

		----------------------------------------------------------------------
		-- Automatically release in battlegrounds
		----------------------------------------------------------------------

		do

			-- Create configuration panel
			local ReleasePanel = LeaPlusLC:CreatePanel("Release in PvP", "ReleasePanel")

			LeaPlusLC:MakeTx(ReleasePanel, "Settings", 16, -72)
			LeaPlusLC:MakeCB(ReleasePanel, "AutoReleaseNoAlterac", "Exclude Alterac Valley", 16, -92, false, "If checked, you will not release automatically in Alterac Valley.")
			LeaPlusLC:MakeCB(ReleasePanel, "AutoReleaseGilneas", "Exclude Battle for Gilneas", 16, -112, false, "If checked, you will not release automatically in Battle for Gilneas.")
			LeaPlusLC:MakeCB(ReleasePanel, "AutoReleaseConquest", "Exclude Isle of Conquest", 16, -132, false, "If checked, you will not release automatically in Isle of Conquest.")
			LeaPlusLC:MakeCB(ReleasePanel, "AutoReleaseSilvershard", "Exclude Silvershard Mines", 16, -152, false, "If checked, you will not release automatically in Silvershard Mines.")
			LeaPlusLC:MakeCB(ReleasePanel, "AutoReleaseKotmogu", "Exclude Temple of Kotmogu", 16, -172, false, "If checked, you will not release automatically in Temple of Kotmogu.")
			LeaPlusLC:MakeCB(ReleasePanel, "AutoReleaseNoWintergsp", "Exclude Wintergrasp", 16, -192, false, "If checked, you will not release automatically in Wintergrasp.")

			LeaPlusLC:MakeTx(ReleasePanel, "Delay", 356, -72)
			LeaPlusLC:MakeSL(ReleasePanel, "AutoReleaseDelay", "Drag to set the number of milliseconds before you are automatically released.|n|nYou can hold down shift as the timer is ending to cancel the automatic release.", 200, 3000, 100, 356, -92, "%.0f")

			-- Help button hidden
			ReleasePanel.h:Hide()

			-- Back button handler
			ReleasePanel.b:SetScript("OnClick", function()
				ReleasePanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page1"]:Show();
				return
			end)

			-- Reset button handler
			ReleasePanel.r:SetScript("OnClick", function()

				-- Reset checkboxes
				LeaPlusLC["AutoReleaseNoAlterac"] = "Off"
				LeaPlusLC["AutoReleaseGilneas"] = "Off"
				LeaPlusLC["AutoReleaseConquest"] = "Off"
				LeaPlusLC["AutoReleaseSilvershard"] = "Off"
				LeaPlusLC["AutoReleaseKotmogu"] = "Off"
				LeaPlusLC["AutoReleaseNoWintergsp"] = "Off"
				LeaPlusLC["AutoReleaseDelay"] = 200

				-- Refresh panel
				ReleasePanel:Hide(); ReleasePanel:Show()

			end)

			-- Show panal when options panel button is clicked
			LeaPlusCB["AutoReleasePvPBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["AutoReleaseNoAlterac"] = "Off"
					LeaPlusLC["AutoReleaseGilneas"] = "Off"
					LeaPlusLC["AutoReleaseConquest"] = "Off"
					LeaPlusLC["AutoReleaseSilvershard"] = "Off"
					LeaPlusLC["AutoReleaseKotmogu"] = "Off"
					LeaPlusLC["AutoReleaseNoWintergsp"] = "Off"
					LeaPlusLC["AutoReleaseDelay"] = 200
				else
					ReleasePanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

			-- Release in battlegrounds
			hooksecurefunc("StaticPopup_Show", function(sType)
				if sType and sType == "DEATH" and LeaPlusLC["AutoReleasePvP"] == "On" then
					if C_DeathInfo.GetSelfResurrectOptions() and #C_DeathInfo.GetSelfResurrectOptions() > 0 then return end
					local InstStat, InstType = IsInInstance()
					if InstStat and InstType == "pvp" then
						-- Exclude specific maps
						local mapID = C_Map.GetBestMapForUnit("player") or nil
						if mapID then
							if mapID == 91 and LeaPlusLC["AutoReleaseNoAlterac"] == "On" then return end -- Alterac Valley
							if mapID == 275 and LeaPlusLC["AutoReleaseGilneas"] == "On" then return end -- Battle for Gilneas
							if mapID == 169 and LeaPlusLC["AutoReleaseConquest"] == "On" then return end -- Isle of Conquest
							if mapID == 423 and LeaPlusLC["AutoReleaseSilvershard"] == "On" then return end -- Silvershard Mines
							if mapID == 417 and LeaPlusLC["AutoReleaseKotmogu"] == "On" then return end -- Temple of Kotmogu
							if mapID == 2104 and LeaPlusLC["AutoReleaseNoWintergsp"] == "On" then return end -- Wintergrasp
						end
						-- Release automatically
						local delay = LeaPlusLC["AutoReleaseDelay"] / 1000
						C_Timer.After(delay, function()
							local dialog = StaticPopup_Visible("DEATH")
							if dialog then
								if IsShiftKeyDown() then
									ActionStatus_DisplayMessage(L["Automatic Release Cancelled"], true)
								else
									StaticPopup_OnClick(_G[dialog], 1)
								end
							end
						end)
					end
				end
			end)

		end

		----------------------------------------------------------------------
		--	Enhance trainers
		----------------------------------------------------------------------

		if LeaPlusLC["EnhanceTrainers"] == "On" then

			-- Create configuration panel
			local TrainerPanel = LeaPlusLC:CreatePanel("Enhance trainers", "TrainerPanel")

			LeaPlusLC:MakeTx(TrainerPanel, "Settings", 16, -72)
			LeaPlusLC:MakeCB(TrainerPanel, "ShowTrainAllBtn", "Show train all skills button", 16, -92, false, "If checked, a train all skills button will be shown in the skill trainer frame allowing you to train all available skills instantly.")

			-- Help button hidden
			TrainerPanel.h:Hide()

			-- Back button handler
			TrainerPanel.b:SetScript("OnClick", function()
				TrainerPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page5"]:Show()
				return
			end)

			-- Reset button handler
			TrainerPanel.r:SetScript("OnClick", function()

				-- Reset controls
				LeaPlusLC["ShowTrainAllBtn"] = "On"

				-- Refresh configuration panel
				TrainerPanel:Hide(); TrainerPanel:Show()

			end)

			-- Show configuration panal when options panel button is clicked
			LeaPlusCB["EnhanceTrainersBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["ShowTrainAllBtn"] = "On"
				else
					TrainerPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

			-- Set increased height of skill trainer frame and maximum number of skills listed
			local tall, numTallTrainers = 73, 17

			----------------------------------------------------------------------
			--	Trainers Frame
			----------------------------------------------------------------------

			EventUtil.ContinueOnAddOnLoaded("Blizzard_TrainerUI", function()

				-- Make the frame double-wide
				UIPanelWindows["ClassTrainerFrame"] = {area = "override", pushable = 0, xoffset = -16, yoffset = 12, bottomClampOverride = 140 + 12, width = 685, height = 487, whileDead = 1}

				-- Size the frame
				_G["ClassTrainerFrame"]:SetSize(714, 487 + tall)

				-- Lower title text slightly
				_G["ClassTrainerNameText"]:ClearAllPoints()
				_G["ClassTrainerNameText"]:SetPoint("TOP", _G["ClassTrainerFrame"], "TOP", 0, -18)

				-- Expand the skill list to full height
				_G["ClassTrainerListScrollFrame"]:ClearAllPoints()
				_G["ClassTrainerListScrollFrame"]:SetPoint("TOPLEFT", _G["ClassTrainerFrame"], "TOPLEFT", 25, -75)
				_G["ClassTrainerListScrollFrame"]:SetSize(295, 336 + tall)

				-- Create additional list rows
				do

					local oldSkillsDisplayed = CLASS_TRAINER_SKILLS_DISPLAYED

					-- Position existing buttons
					for i = 1 + 1, CLASS_TRAINER_SKILLS_DISPLAYED do
						_G["ClassTrainerSkill" .. i]:ClearAllPoints()
						_G["ClassTrainerSkill" .. i]:SetPoint("TOPLEFT", _G["ClassTrainerSkill" .. (i - 1)], "BOTTOMLEFT", 0, 1)
					end

					-- Create and position new buttons
					_G.CLASS_TRAINER_SKILLS_DISPLAYED = _G.CLASS_TRAINER_SKILLS_DISPLAYED + numTallTrainers
					for i = oldSkillsDisplayed + 1, CLASS_TRAINER_SKILLS_DISPLAYED do
						local button = CreateFrame("Button", "ClassTrainerSkill" .. i, ClassTrainerFrame, "ClassTrainerSkillButtonTemplate")
						button:SetID(i)
						button:Hide()
						button:ClearAllPoints()
						button:SetPoint("TOPLEFT", _G["ClassTrainerSkill" .. (i - 1)], "BOTTOMLEFT", 0, 1)
					end

					hooksecurefunc("ClassTrainer_SetToTradeSkillTrainer", function()
						_G.CLASS_TRAINER_SKILLS_DISPLAYED = _G.CLASS_TRAINER_SKILLS_DISPLAYED + numTallTrainers
						ClassTrainerListScrollFrame:SetHeight(336 + tall)
						ClassTrainerDetailScrollFrame:SetHeight(336 + tall)
					end)

					hooksecurefunc("ClassTrainer_SetToClassTrainer", function()
						_G.CLASS_TRAINER_SKILLS_DISPLAYED = _G.CLASS_TRAINER_SKILLS_DISPLAYED + numTallTrainers - 1
						ClassTrainerListScrollFrame:SetHeight(336 + tall)
						ClassTrainerDetailScrollFrame:SetHeight(336 + tall)
					end)

				end

				-- Set highlight bar width when shown
				hooksecurefunc(_G["ClassTrainerSkillHighlightFrame"], "Show", function()
					ClassTrainerSkillHighlightFrame:SetWidth(290)
				end)

				-- Move the detail frame to the right and stretch it to full height
				_G["ClassTrainerDetailScrollFrame"]:ClearAllPoints()
				_G["ClassTrainerDetailScrollFrame"]:SetPoint("TOPLEFT", _G["ClassTrainerFrame"], "TOPLEFT", 352, -74)
				_G["ClassTrainerDetailScrollFrame"]:SetSize(296, 336 + tall)
				-- _G["ClassTrainerSkillIcon"]:SetHeight(500) -- Debug

				-- Hide detail scroll frame textures
				_G["ClassTrainerDetailScrollFrameTop"]:SetAlpha(0)
				_G["ClassTrainerDetailScrollFrameBottom"]:SetAlpha(0)

				-- Hide expand tab (left of All button)
				_G["ClassTrainerExpandTabLeft"]:Hide()

				-- Get frame textures
				local regions = {_G["ClassTrainerFrame"]:GetRegions()}

				-- Set top left texture
				regions[2]:SetSize(512, 512)
				regions[2]:SetTexture("Interface\\AddOns\\Leatrix_Plus\\Leatrix_Plus.blp")
				regions[2]:SetTexCoord(0.25, 0.75, 0, 0.5)

				-- Set top right texture
				regions[3]:ClearAllPoints()
				regions[3]:SetPoint("TOPLEFT", regions[2], "TOPRIGHT", 0, 0)
				regions[3]:SetSize(256, 512)
				regions[3]:SetTexture("Interface\\AddOns\\Leatrix_Plus\\Leatrix_Plus.blp")
				regions[3]:SetTexCoord(0.75, 1, 0, 0.5)

				-- Hide bottom left and bottom right textures
				regions[4]:Hide()
				regions[5]:Hide()

				-- Hide skills list dividing bar
				regions[9]:Hide()
				ClassTrainerHorizontalBarLeft:Hide()

				-- Set skills list backdrop
				local RecipeInset = _G["ClassTrainerFrame"]:CreateTexture(nil, "ARTWORK")
				RecipeInset:SetSize(304, 361 + tall)
				RecipeInset:SetPoint("TOPLEFT", _G["ClassTrainerFrame"], "TOPLEFT", 16, -72)
				RecipeInset:SetTexture("Interface\\RAIDFRAME\\UI-RaidFrame-GroupBg")

				-- Set detail frame backdrop
				local DetailsInset = _G["ClassTrainerFrame"]:CreateTexture(nil, "ARTWORK")
				DetailsInset:SetSize(302, 339 + tall)
				DetailsInset:SetPoint("TOPLEFT", _G["ClassTrainerFrame"], "TOPLEFT", 348, -72)
				DetailsInset:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated")

				-- Move bottom button row
				_G["ClassTrainerTrainButton"]:ClearAllPoints()
				_G["ClassTrainerTrainButton"]:SetPoint("RIGHT", _G["ClassTrainerCancelButton"], "LEFT", -1, 0)

				-- Position and size close button
				_G["ClassTrainerCancelButton"]:SetSize(80, 22)
				_G["ClassTrainerCancelButton"]:SetText(CLOSE)
				_G["ClassTrainerCancelButton"]:ClearAllPoints()
				_G["ClassTrainerCancelButton"]:SetPoint("BOTTOMRIGHT", _G["ClassTrainerFrame"], "BOTTOMRIGHT", -42, 54)

				-- Position close box
				_G["ClassTrainerFrameCloseButton"]:ClearAllPoints()
				_G["ClassTrainerFrameCloseButton"]:SetPoint("TOPRIGHT", _G["ClassTrainerFrame"], "TOPRIGHT", -30, -8)

				-- Position dropdown menus
				ClassTrainerFrame.FilterDropdown:ClearAllPoints()
				ClassTrainerFrame.FilterDropdown:SetPoint("TOPLEFT", ClassTrainerFrame, "TOPLEFT", 576, -44)

				-- Position money frame
				ClassTrainerMoneyFrame:ClearAllPoints()
				ClassTrainerMoneyFrame:SetPoint("TOPLEFT", _G["ClassTrainerFrame"], "TOPLEFT", 143, -49)
				ClassTrainerGreetingText:Hide()

				----------------------------------------------------------------------
				--	Train All button
				----------------------------------------------------------------------

				-- Create train all button
				LeaPlusLC:CreateButton("TrainAllButton", ClassTrainerFrame, "Train All", "BOTTOMLEFT", 344, 54, 0, 22, false, "")

				-- Give button global scope (useful for compatibility with other addons and essential for ElvUI)
				_G.LeaPlusGlobalTrainAllButton = LeaPlusCB["TrainAllButton"]

				-- Button tooltip
				LeaPlusCB["TrainAllButton"]:SetScript("OnEnter", function(self)
					-- Get number of available skills and total cost
					local count, cost = 0, 0
					for i = 1, GetNumTrainerServices() do
						local void, void, isAvail = GetTrainerServiceInfo(i)
						if isAvail and isAvail == "available" then
							count = count + 1
							cost = cost + GetTrainerServiceCost(i)
						end
					end
					-- Show tooltip
					if count > 0 then
						GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 4)
						GameTooltip:ClearLines()
						if count > 1 then
							GameTooltip:AddLine(L["Train"] .. " " .. count .. " " .. L["skills for"] .. " " .. C_CurrencyInfo.GetCoinTextureString(cost))
						else
							GameTooltip:AddLine(L["Train"] .. " " .. count .. " " .. L["skill for"] .. " " .. C_CurrencyInfo.GetCoinTextureString(cost))
						end
						GameTooltip:Show()
					end
				end)

				-- Button click handler
				LeaPlusCB["TrainAllButton"]:SetScript("OnClick",function(self)
					for i = 1, GetNumTrainerServices() do
						local void, void, isAvail = GetTrainerServiceInfo(i)
						if isAvail and isAvail == "available" then
							BuyTrainerService(i)
						end
					end
				end)

				-- Enable button only when skills are available
				local skillsAvailable
				hooksecurefunc("ClassTrainerFrame_Update", function()
					skillsAvailable = false
					for i = 1, GetNumTrainerServices() do
						local void, void, isAvail = GetTrainerServiceInfo(i)
						if isAvail and isAvail == "available" then
							skillsAvailable = true
						end
					end
					LeaPlusCB["TrainAllButton"]:SetEnabled(skillsAvailable)
					-- Refresh tooltip
					if LeaPlusCB["TrainAllButton"]:IsMouseOver() and skillsAvailable then
						LeaPlusCB["TrainAllButton"]:GetScript("OnEnter")(LeaPlusCB["TrainAllButton"])
					end
				end)

				-- Function to set train all button
				local function SetTrainAllFunc()
					if LeaPlusLC["ShowTrainAllBtn"] == "On" then
						LeaPlusCB["TrainAllButton"]:Show()
					else
						LeaPlusCB["TrainAllButton"]:Hide()
					end
				end

				-- Run function when option is clicked, reset or preset button is clicked and on startup
				LeaPlusCB["ShowTrainAllBtn"]:HookScript("OnClick", SetTrainAllFunc)
				TrainerPanel.r:HookScript("OnClick", SetTrainAllFunc)
				LeaPlusCB["EnhanceTrainersBtn"]:HookScript("OnClick", function()
					if IsShiftKeyDown() and IsControlKeyDown() then
						-- Preset profile
						LeaPlusLC["ShowTrainAllBtn"] = "On"
						SetTrainAllFunc()
					end
				end)
				SetTrainAllFunc()

				----------------------------------------------------------------------
				--	ElvUI fixes
				----------------------------------------------------------------------

				-- ElvUI fixes
				if LeaPlusLC.ElvUI then
					local E = LeaPlusLC.ElvUI
					if E.private.skins.blizzard.enable and E.private.skins.blizzard.trainer then
						regions[2]:Hide()
						regions[3]:Hide()
						RecipeInset:Hide()
						DetailsInset:Hide()
						_G["ClassTrainerFrame"]:SetHeight(512 + tall)
						_G["ClassTrainerTrainButton"]:ClearAllPoints()
						_G["ClassTrainerTrainButton"]:SetPoint("BOTTOMRIGHT", _G["ClassTrainerFrame"], "BOTTOMRIGHT", -42, 78)
						LeaPlusCB["TrainAllButton"]:ClearAllPoints()
						LeaPlusCB["TrainAllButton"]:SetPoint("BOTTOMLEFT", _G["ClassTrainerFrame"], "BOTTOMLEFT", 344, 78)
						E:GetModule("Skins"):HandleButton(_G.LeaPlusGlobalTrainAllButton)
					end
				end

			end)

		end

		----------------------------------------------------------------------
		--	Set weather density (no reload required)
		----------------------------------------------------------------------

		do

			-- Create configuration panel
			local weatherPanel = LeaPlusLC:CreatePanel("Set weather density", "weatherPanel")
			LeaPlusLC:MakeTx(weatherPanel, "Settings", 16, -72)
			LeaPlusLC:MakeSL(weatherPanel, "WeatherLevel", "Drag to set the density of weather effects.", 0, 3, 1, 16, -92, "%.0f")

			local weatherSliderTable = {L["Very Low"], L["Low"], L["Medium"], L["High"]}

			-- Function to set the weather density
			local function SetWeatherFunc()
				LeaPlusCB["WeatherLevel"].f:SetText(LeaPlusLC["WeatherLevel"] .. "  (" .. weatherSliderTable[LeaPlusLC["WeatherLevel"] + 1] .. ")")
				if LeaPlusLC["SetWeatherDensity"] == "On" then
					SetCVar("WeatherDensity", LeaPlusLC["WeatherLevel"])
					SetCVar("RAIDweatherDensity", LeaPlusLC["WeatherLevel"])
				else
					SetCVar("WeatherDensity", "3")
					SetCVar("RAIDweatherDensity", "3")
				end
			end

			-- Set weather density when options are clicked and on startup if option is enabled
			LeaPlusCB["SetWeatherDensity"]:HookScript("OnClick", SetWeatherFunc)
			LeaPlusCB["WeatherLevel"]:HookScript("OnValueChanged", SetWeatherFunc)
			if LeaPlusLC["SetWeatherDensity"] == "On" then SetWeatherFunc() end

			-- Prevent weather density from being changed when particle density is changed
			hooksecurefunc("SetCVar", function(setting, value)
				if setting and LeaPlusLC["SetWeatherDensity"] == "On" then
					if setting == "graphicsParticleDensity" then
						if GetCVar("WeatherDensity") ~= LeaPlusLC["WeatherLevel"] then
							C_Timer.After(0.1, function()
								SetCVar("WeatherDensity", LeaPlusLC["WeatherLevel"])
							end)
						end
					elseif setting == "raidGraphicsParticleDensity" then
						if GetCVar("RAIDweatherDensity") ~= LeaPlusLC["WeatherLevel"] then
							C_Timer.After(0.1, function()
								SetCVar("RAIDweatherDensity", LeaPlusLC["WeatherLevel"])
							end)
						end
					end
				end
			end)

			-- Help button hidden
			weatherPanel.h:Hide()

			-- Back button handler
			weatherPanel.b:SetScript("OnClick", function()
				weatherPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page7"]:Show()
				return
			end)

			-- Reset button handler
			weatherPanel.r:SetScript("OnClick", function()

				-- Reset slider
				LeaPlusLC["WeatherLevel"] = 3

				-- Refresh side panel
				weatherPanel:Hide(); weatherPanel:Show()

			end)

			-- Show configuration panal when options panel button is clicked
			LeaPlusCB["SetWeatherDensityBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["WeatherLevel"] = 0
					SetWeatherFunc()
				else
					weatherPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

		end

		----------------------------------------------------------------------
		--	Enhance professions
		----------------------------------------------------------------------

		if LeaPlusLC["EnhanceProfessions"] == "On" then

			-- Set increased height of professions frame and maximum number of recipes listed
			local tall, numTallProfs = 73, 19

			----------------------------------------------------------------------
			--	TradeSkill Frame
			----------------------------------------------------------------------

			EventUtil.ContinueOnAddOnLoaded("Blizzard_TradeSkillUI",function()

				-- Make the tradeskill frame double-wide
				UIPanelWindows["TradeSkillFrame"] = {area = "override", pushable = 3, xoffset = -16, yoffset = 12, bottomClampOverride = 140 + 12, width = 685, height = 487, whileDead = 1}

				-- Size the tradeskill frame
				_G["TradeSkillFrame"]:SetWidth(714)
				_G["TradeSkillFrame"]:SetHeight(487 + tall)

				-- Adjust title text
				_G["TradeSkillFrameTitleText"]:ClearAllPoints()
				_G["TradeSkillFrameTitleText"]:SetPoint("TOP", _G["TradeSkillFrame"], "TOP", 0, -18)

				-- Expand the tradeskill list to full height
				_G["TradeSkillListScrollFrame"]:ClearAllPoints()
				_G["TradeSkillListScrollFrame"]:SetPoint("TOPLEFT", _G["TradeSkillFrame"], "TOPLEFT", 25, -75)
				_G["TradeSkillListScrollFrame"]:SetSize(295, 336 + tall)

				-- Create additional list rows
				local oldTradeSkillsDisplayed = TRADE_SKILLS_DISPLAYED

				-- Position existing buttons
				for i = 1 + 1, TRADE_SKILLS_DISPLAYED do
					_G["TradeSkillSkill" .. i]:ClearAllPoints()
					_G["TradeSkillSkill" .. i]:SetPoint("TOPLEFT", _G["TradeSkillSkill" .. (i-1)], "BOTTOMLEFT", 0, 1)
				end

				-- Create and position new buttons
				_G.TRADE_SKILLS_DISPLAYED = _G.TRADE_SKILLS_DISPLAYED + numTallProfs
				for i = oldTradeSkillsDisplayed + 1, TRADE_SKILLS_DISPLAYED do
					local button = CreateFrame("Button", "TradeSkillSkill" .. i, TradeSkillFrame, "TradeSkillSkillButtonTemplate")
					button:SetID(i)
					button:Hide()
					button:ClearAllPoints()
					button:SetPoint("TOPLEFT", _G["TradeSkillSkill" .. (i-1)], "BOTTOMLEFT", 0, 1)
				end

				-- Set highlight bar width when shown
				hooksecurefunc(_G["TradeSkillHighlightFrame"], "Show", function()
					_G["TradeSkillHighlightFrame"]:SetWidth(290)
				end)

				-- Move the tradeskill detail frame to the right and stretch it to full height
				_G["TradeSkillDetailScrollFrame"]:ClearAllPoints()
				_G["TradeSkillDetailScrollFrame"]:SetPoint("TOPLEFT", _G["TradeSkillFrame"], "TOPLEFT", 352, -74)
				_G["TradeSkillDetailScrollFrame"]:SetSize(298, 336 + tall)
				-- _G["TradeSkillReagent1"]:SetHeight(500) -- Debug

				-- Hide detail scroll frame textures
				_G["TradeSkillDetailScrollFrameTop"]:SetAlpha(0)
				_G["TradeSkillDetailScrollFrameBottom"]:SetAlpha(0)

				-- Create texture for skills list
				local RecipeInset = _G["TradeSkillFrame"]:CreateTexture(nil, "ARTWORK")
				RecipeInset:SetSize(304, 361+ tall)
				RecipeInset:SetPoint("TOPLEFT", _G["TradeSkillFrame"], "TOPLEFT", 16, -72)
				RecipeInset:SetTexture("Interface\\RAIDFRAME\\UI-RaidFrame-GroupBg")

				-- Set detail frame backdrop
				local DetailsInset = _G["TradeSkillFrame"]:CreateTexture(nil, "ARTWORK")
				DetailsInset:SetSize(302, 339+ tall)
				DetailsInset:SetPoint("TOPLEFT", _G["TradeSkillFrame"], "TOPLEFT", 348, -72)
				DetailsInset:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated")

				-- Hide expand tab (left of All button)
				_G["TradeSkillExpandTabLeft"]:Hide()

				-- Hide skills list horizontal dividing bar (this hides it behind RecipeInset)
				TradeSkillHorizontalBarLeft:SetSize(1, 1)
				TradeSkillHorizontalBarLeft:Hide()

				-- Get tradeskill frame textures
				local regions = {_G["TradeSkillFrame"]:GetRegions()}

				-- Set top left texture
				regions[3]:SetSize(512, 512)
				regions[3]:SetTexture("Interface\\AddOns\\Leatrix_Plus\\Leatrix_Plus.blp")
				regions[3]:SetTexCoord(0.25, 0.75, 0, 0.5)

				-- Set top right texture
				regions[4]:ClearAllPoints()
				regions[4]:SetPoint("TOPLEFT", regions[3], "TOPRIGHT", 0, 0)
				regions[4]:SetSize(256, 512)
				regions[4]:SetTexture("Interface\\AddOns\\Leatrix_Plus\\Leatrix_Plus.blp")
				regions[4]:SetTexCoord(0.75, 1, 0, 0.5)

				-- Hide bottom left and bottom right textures
				TradeSkillFrameBottomLeftTexture:Hide()
				TradeSkillFrameBottomRightTexture:Hide()

				-- Hide horizonal bar in recipe list
				regions[8]:Hide()
				regions[9]:Hide() -- The shorter pesky horizontal bar that only shows sometimes (texture is 130968)

				-- Move skill rank text
				TradeSkillRankFrameSkillRank:ClearAllPoints()
				TradeSkillRankFrameSkillRank:SetPoint("TOP", TradeSkillRankFrame, "TOP", 0, -1)

				-- Move create button row
				_G["TradeSkillCreateButton"]:ClearAllPoints()
				_G["TradeSkillCreateButton"]:SetPoint("RIGHT", _G["TradeSkillCancelButton"], "LEFT", -1, 0)

				-- Position and size close button
				_G["TradeSkillCancelButton"]:SetSize(80, 22)
				_G["TradeSkillCancelButton"]:SetText(CLOSE)
				_G["TradeSkillCancelButton"]:ClearAllPoints()
				_G["TradeSkillCancelButton"]:SetPoint("BOTTOMRIGHT", _G["TradeSkillFrame"], "BOTTOMRIGHT", -42, 54)

				-- Position close box
				_G["TradeSkillFrameCloseButton"]:ClearAllPoints()
				_G["TradeSkillFrameCloseButton"]:SetPoint("TOPRIGHT", _G["TradeSkillFrame"], "TOPRIGHT", -30, -8)

				-- Move dropdown menu
				TradeSkillFrame.FilterDropdown:ClearAllPoints()
				TradeSkillFrame.FilterDropdown:SetPoint("TOPRIGHT", TradeSkillFrame, "TOPRIGHT", -44, -44)

				-- ElvUI fixes
				if LeaPlusLC.ElvUI then
					local E = LeaPlusLC.ElvUI
					if E.private.skins.blizzard.enable and E.private.skins.blizzard.tradeskill then
						regions[3]:Hide()
						regions[4]:Hide()
						RecipeInset:Hide()
						DetailsInset:Hide()
						_G["TradeSkillFrame"]:SetHeight(512 + tall)
						_G["TradeSkillCancelButton"]:ClearAllPoints()
						_G["TradeSkillCancelButton"]:SetPoint("BOTTOMRIGHT", _G["TradeSkillFrame"], "BOTTOMRIGHT", -42, 78)
						_G["TradeSkillRankFrame"]:ClearAllPoints()
						_G["TradeSkillRankFrame"]:SetPoint("TOPLEFT", _G["TradeSkillFrame"], "TOPLEFT", 24, -44)
					end
				end

			end)

		end

		----------------------------------------------------------------------
		--	Enhance quest log
		----------------------------------------------------------------------

		if LeaPlusLC["EnhanceQuestLog"] == "On" then

			-- Button to toggle quest headers
			LeaPlusLC:CreateButton("ToggleQuestHeaders", QuestLogFrame, "Expand", "BOTTOMLEFT", 344, 54, 0, 22, true, "", false)
			LeaPlusCB["ToggleQuestHeaders"]:ClearAllPoints()
			LeaPlusCB["ToggleQuestHeaders"]:SetPoint("TOPRIGHT", QuestLogFrame, "TOPRIGHT", -360, -33)
			LeaPlusCB["ToggleQuestHeaders"]:GetFontString():SetWordWrap(false)
			LeaPlusCB["ToggleQuestHeaders"].collapsed = true

			local function SetHeadersButton()
				if LeaPlusCB["ToggleQuestHeaders"].collapsed then
					LeaPlusCB["ToggleQuestHeaders"]:SetText(L["Expand"])
				else
					LeaPlusCB["ToggleQuestHeaders"]:SetText(L["Collapse"])
				end
				local headerButtonWidth = LeaPlusCB["ToggleQuestHeaders"]:GetFontString():GetStringWidth() + 13.6
				if headerButtonWidth > 120 then headerButtonWidth = 120 end
				LeaPlusCB["ToggleQuestHeaders"]:GetFontString():SetWidth(headerButtonWidth)
				LeaPlusCB["ToggleQuestHeaders"]:SetWidth(headerButtonWidth)
			end

			LeaPlusCB["ToggleQuestHeaders"]:HookScript("OnMouseUp", function(self, btn)
				if btn == "LeftButton" then
					if self.collapsed then
						self.collapsed = nil
						ExpandQuestHeader(0)
						SetHeadersButton()
					else
						self.collapsed = 1
						QuestLogListScrollFrameScrollBar:SetValue(0)
						CollapseQuestHeader(0)
						SetHeadersButton()
					end
				end
			end)

			-- Translations for quest level suffixes (need to be English so links work in addons such as Questie for non-English locales)
			L["D"] = "D" -- Dungeon quest
			L["R"] = "R" -- Raid quest
			L["P"] = "P" -- PvP quest
			L["+"] = "+" -- Elite or group quest

			-- Show quest level in quest log detail frame (but not when turning in quest)
			hooksecurefunc("QuestLog_UpdateQuestDetails", function()
				if LeaPlusLC["EnhanceQuestLevels"] == "On" then
					local quest = GetQuestLogSelection()
					if quest then
						local title, level, suggestedGroup = GetQuestLogTitle(quest)
						if title and level then
							if suggestedGroup then
								if suggestedGroup == LFG_TYPE_DUNGEON then level = level .. L["D"]
								elseif suggestedGroup == RAID then level = level .. L["R"]
								elseif suggestedGroup == ELITE then level = level .. L["+"]
								elseif suggestedGroup == GROUP then level = level .. L["+"]
								elseif suggestedGroup == PVP then level = level .. L["P"]
								end
							end
							QuestInfoTitleHeader:SetText("[" .. level .. "] " .. title)
						end
					end
				end
			end)

			-- Show quest levels in quest log
			hooksecurefunc("QuestLogTitleButton_Resize", function(questLogTitle)
				if LeaPlusLC["EnhanceQuestLevels"] == "On" and not questLogTitle.isHeader then
					local questIndex = questLogTitle:GetID()
					local title, level, suggestedGroup = GetQuestLogTitle(questIndex)
					local questTitleTag = questLogTitle.tag
					local questNormalText = questLogTitle.normalText
					local questCheck = questLogTitle.check

					if level and level > 0 and level < 10 then level = "0" .. level end

					if suggestedGroup and LeaPlusLC["EnhanceQuestDifficulty"] == "On" then
						if suggestedGroup == LFG_TYPE_DUNGEON then level = level .. L["D"]
						elseif suggestedGroup == RAID then level = level .. L["R"]
						elseif suggestedGroup == ELITE then level = level .. L["+"]
						elseif suggestedGroup == GROUP then level = level .. L["+"]
						elseif suggestedGroup == PVP then level = level .. L["P"]
						end
					end

					questNormalText:SetWidth(0)
					questNormalText:SetText("  [" .. level .. "] " .. title)

					-- Debug
					-- questLogTitle.normalText:SetText("  [80] Learning to Leave and Return The")

					-- From QuestLogTitleButton_Resize
					local rightEdge
					if questTitleTag:IsShown() then
						if questCheck:IsShown() then
							rightEdge = questLogTitle:GetLeft() + questLogTitle:GetWidth() - questTitleTag:GetWidth() - 4 - questCheck:GetWidth() - 2
						else
							rightEdge = questLogTitle:GetLeft() + questLogTitle:GetWidth() - questTitleTag:GetWidth() - 4
						end
					else
						if questCheck:IsShown() then
							rightEdge = questLogTitle:GetLeft() + questLogTitle:GetWidth() - questCheck:GetWidth() - 2
						else
							rightEdge = questLogTitle:GetLeft() + questLogTitle:GetWidth()
						end
					end
					-- subtract from the text width the number of pixels that overrun the right edge
					local questNormalTextWidth = questNormalText:GetWidth() - max(questNormalText:GetRight() - rightEdge, 0)
					questNormalText:SetWidth(questNormalTextWidth)
				end
			end)

			-- Create configuration panel
			local EnhanceQuestPanel = LeaPlusLC:CreatePanel("Enhance quest log", "EnhanceQuestPanel")

			LeaPlusLC:MakeTx(EnhanceQuestPanel, "Settings", 16, -72)
			LeaPlusLC:MakeCB(EnhanceQuestPanel, "EnhanceQuestHeaders", "Show toggle headers button", 16, -92, false, "If checked, the toggle headers button will be shown.")

			LeaPlusLC:MakeTx(EnhanceQuestPanel, "Levels", 16, -132)
			LeaPlusLC:MakeCB(EnhanceQuestPanel, "EnhanceQuestLevels", "Show quest levels", 16, -152, false, "If checked, quest levels will be shown.")
			LeaPlusLC:MakeCB(EnhanceQuestPanel, "EnhanceQuestDifficulty", "Show quest difficulty in quest log list", 16, -172, false, "If checked, the quest difficulty will be shown next to the quest level in the quest log list.|n|nThis will indicate whether the quest requires a group (+), dungeon (D), raid (R) or PvP (P).|n|nThe quest difficulty will always be shown in the quest log detail pane regardless of this setting.")

			-- Disable Show quest difficulty option if Show quest levels is disabled
			LeaPlusCB["EnhanceQuestLevels"]:HookScript("OnClick", function()
				LeaPlusLC:LockOption("EnhanceQuestLevels", "EnhanceQuestDifficulty", false)
			end)
			LeaPlusLC:LockOption("EnhanceQuestLevels", "EnhanceQuestDifficulty", false)

			-- Help button hidden
			EnhanceQuestPanel.h:Hide()

			-- Back button handler
			EnhanceQuestPanel.b:SetScript("OnClick", function()
				EnhanceQuestPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page5"]:Show();
				return
			end)

			-- Function to set toggle headers button
			local function SetQuestHeaderFunc()
				if LeaPlusLC["EnhanceQuestHeaders"] == "On" then
					LeaPlusCB["ToggleQuestHeaders"]:Show()
				else
					LeaPlusCB["ToggleQuestHeaders"]:Hide()
				end
			end

			-- Set toggle headers button when setting is clicked and on startup
			LeaPlusCB["EnhanceQuestHeaders"]:HookScript("OnClick", SetQuestHeaderFunc)
			SetQuestHeaderFunc()

			-- Reset button handler
			EnhanceQuestPanel.r.tiptext = EnhanceQuestPanel.r.tiptext .. "|n|n" .. L["Note that this will not reset settings that require a UI reload."]
			EnhanceQuestPanel.r:SetScript("OnClick", function()

				-- Reset checkboxes
				LeaPlusLC["EnhanceQuestHeaders"] = "On"; SetQuestHeaderFunc()
				LeaPlusLC["EnhanceQuestLevels"] = "On"
				LeaPlusLC["EnhanceQuestDifficulty"] = "On"

				-- Refresh panel
				EnhanceQuestPanel:Hide(); EnhanceQuestPanel:Show()

			end)

			-- Show panal when options panel button is clicked
			LeaPlusCB["EnhanceQuestLogBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["EnhanceQuestHeaders"] = "On"; SetQuestHeaderFunc()
					LeaPlusLC["EnhanceQuestLevels"] = "On"
					LeaPlusLC["EnhanceQuestDifficulty"] = "On"
				else
					EnhanceQuestPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

		end

		----------------------------------------------------------------------
		--	Expand vendor price
		----------------------------------------------------------------------

		if LeaPlusLC["ExpandVendorPrice"] == "On" and not LeaLockList["ExpandVendorPrice"] then

			-- Function to show vendor price
			local function ShowSellPrice(tooltip, tooltipObject)
				if tooltip.shownMoneyFrames then return end
				tooltipObject = tooltipObject or GameTooltip
				-- Get container
				local container = GetMouseFoci()[1]
				if not container then return end
				-- Get item
				local itemName, itemlink = tooltipObject:GetItem()
				if not itemlink then return end
				local void, void, void, void, void, void, void, void, void, void, sellPrice, classID = C_Item.GetItemInfo(itemlink)
				if sellPrice and sellPrice > 0 then
					local count = container and type(container.count) == "number" and container.count or 1
					if sellPrice and count > 0 then
						if classID and classID == 11 then count = 1 end -- Fix for quiver/ammo pouch so ammo is not included
						SetTooltipMoney(tooltip, sellPrice * count, "STATIC", SELL_PRICE .. ":")
					end
				end
				-- Refresh chat tooltips
				if tooltipObject == ItemRefTooltip then ItemRefTooltip:Show() end
			end

			-- Show vendor price when tooltips are shown
			GameTooltip:HookScript("OnTooltipSetItem", ShowSellPrice)
			hooksecurefunc(GameTooltip, "SetHyperlink", function(tip) ShowSellPrice(tip, GameTooltip) end)
			hooksecurefunc(ItemRefTooltip, "SetHyperlink", function(tip) ShowSellPrice(tip, ItemRefTooltip) end)

		end

		----------------------------------------------------------------------
		--	Dismount me
		----------------------------------------------------------------------

		if LeaPlusLC["StandAndDismount"] == "On" then

			local eFrame = CreateFrame("FRAME")
			eFrame:RegisterEvent("UI_ERROR_MESSAGE")
			eFrame:SetScript("OnEvent", function(self, event, messageType, msg)
				-- Auto dismount
				if msg == ERR_OUT_OF_RAGE and LeaPlusLC["DismountNoResource"] == "On"
				or msg == ERR_OUT_OF_MANA and LeaPlusLC["DismountNoResource"] == "On"
				or msg == ERR_OUT_OF_ENERGY and LeaPlusLC["DismountNoResource"] == "On"
				or msg == SPELL_FAILED_MOVING and LeaPlusLC["DismountNoMoving"] == "On"
				or msg == ERR_TAXIPLAYERSHAPESHIFTED
				then
					local void, class = UnitClass("player")
					if class == "SHAMAN" and GetShapeshiftFormID() then
						-- Cancel Ghost Wolf
						RunScript('CancelShapeshiftForm()')
					end
					if IsMounted() then
						Dismount()
						UIErrorsFrame:Clear()
					end
				end
			end)

			-- Dismount when flight point map is opened
			local taxiFrame = CreateFrame("FRAME")
			taxiFrame:RegisterEvent("TAXIMAP_OPENED")
			taxiFrame:SetScript("OnEvent", function()
				local void, class = UnitClass("player")
				if class == "SHAMAN" and GetShapeshiftFormID() then
					-- Cancel Ghost Wolf
					RunScript('CancelShapeshiftForm()')
				end
				if IsMounted() then Dismount() end
			end)

			-- Create configuration panel
			local DismountFrame = LeaPlusLC:CreatePanel("Dismount me", "DismountFrame")

			LeaPlusLC:MakeTx(DismountFrame, "Settings", 16, -72)
			LeaPlusLC:MakeCB(DismountFrame, "DismountNoResource", "Dismount when not enough rage, mana or energy", 16, -92, false, "If checked, you will be dismounted when you attempt to cast a spell but don't have the rage, mana or energy to cast it.")
			LeaPlusLC:MakeCB(DismountFrame, "DismountNoMoving", "Dismount when casting a spell while moving", 16, -112, false, "If checked, you will be dismounted when you attempt to cast a non-instant cast spell while moving.")
			LeaPlusLC:MakeCB(DismountFrame, "DismountNoTaxi", "Dismount when the flight map opens", 16, -132, false, "If checked, you will be dismounted when you instruct a flight master to open the flight map.")
			LeaPlusLC:MakeCB(DismountFrame, "DismountShowFormBtn", "Show cancel form button on flight map", 16, -152, false, "If checked, a cancel form button will be shown on the flight map while you are playing as a shapeshifted druid or shaman.")

			-- Help button hidden
			DismountFrame.h.tiptext = L["The game will dismount you if you successfully cast a spell without addons.  These settings let you set some additional dismount rules."]

			-- Back button handler
			DismountFrame.b:SetScript("OnClick", function()
				DismountFrame:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page7"]:Show()
				return
			end)

			-- Function to set dismount options
			local function SetDismount()
				if LeaPlusLC["DismountNoTaxi"] == "On" then
					taxiFrame:RegisterEvent("TAXIMAP_OPENED")
				else
					taxiFrame:UnregisterEvent("TAXIMAP_OPENED")
				end
			end

			-- Run function when certain options are clicked and on startup
			LeaPlusCB["DismountNoTaxi"]:HookScript("OnClick", SetDismount)
			SetDismount()

			-- Reset button handler
			DismountFrame.r:SetScript("OnClick", function()

				-- Reset checkboxes
				LeaPlusLC["DismountNoResource"] = "On"
				LeaPlusLC["DismountNoMoving"] = "On"
				LeaPlusLC["DismountNoTaxi"] = "On"
				LeaPlusLC["DismountShowFormBtn"] = "On"

				-- Update settings and configuration panel
				SetDismount()
				DismountFrame:Hide(); DismountFrame:Show()

			end)

			-- Show configuration panal when options panel button is clicked
			LeaPlusCB["DismountBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["DismountNoResource"] = "On"
					LeaPlusLC["DismountNoMoving"] = "On"
					LeaPlusLC["DismountNoTaxi"] = "On"
					LeaPlusLC["DismountShowFormBtn"] = "On"
					SetDismount()
				else
					DismountFrame:Show()
					LeaPlusLC:HideFrames()
				end
			end)

			-- Druid cancel form button
			local void, class = UnitClass("player")
			if class == "DRUID" or class == "SHAMAN" then

				-- Create button
				local cancelFormBtn = CreateFrame("Button", nil, TaxiFrame, "InsecureActionButtonTemplate")
				cancelFormBtn:SetAttribute("type", "macro")
				cancelFormBtn:SetAttribute("macrotext", "/cancelform")
				cancelFormBtn:ClearAllPoints()
				cancelFormBtn:SetPoint("TOPRIGHT", TaxiFrame, "TOPRIGHT", -46, -46)
				cancelFormBtn:SetSize(24, 24)
				cancelFormBtn:SetNormalTexture("Interface\\ICONS\\Achievement_Character_Nightelf_Female")
				cancelFormBtn:SetPushedTexture("Interface\\ICONS\\Achievement_Character_Nightelf_Female")
				cancelFormBtn:SetHighlightTexture("Interface\\ICONS\\Achievement_Character_Nightelf_Female")

				-- Button message
				cancelFormBtn.f = cancelFormBtn:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
				cancelFormBtn.f:SetHeight(32)
				cancelFormBtn.f:SetPoint('RIGHT', cancelFormBtn, 'LEFT', -10, 0)
				cancelFormBtn.f:SetText(L["Click to unshift"])

				-- Toggle button when form changes
				cancelFormBtn:SetScript("OnEvent", function()
					local form = GetShapeshiftForm() or 0
					if form ~= 0 then
						if not cancelFormBtn:IsShown() then	cancelFormBtn:Show() end
					else
						cancelFormBtn:Hide()
					end
				end)

				-- Function to set event and button status
				local function SetShiftEvent()
					if LeaPlusLC["DismountShowFormBtn"] == "On" then
						cancelFormBtn:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
						local form = GetShapeshiftForm() or 0
						if form ~= 0 then cancelFormBtn:Show() else cancelFormBtn:Hide() end
					else
						cancelFormBtn:UnregisterEvent("UPDATE_SHAPESHIFT_FORM")
						cancelFormBtn:Hide()
					end
				end

				-- Set button when option is clicked, when reset button is clicked, preset profile and on startup
				LeaPlusCB["DismountShowFormBtn"]:HookScript("OnClick", SetShiftEvent)
				DismountFrame.r:HookScript("OnClick", SetShiftEvent)
				LeaPlusCB["DismountBtn"]:HookScript("OnClick", function()
					if IsShiftKeyDown() and IsControlKeyDown() then	SetShiftEvent() end
				end)
				SetShiftEvent()

			end

		end

		----------------------------------------------------------------------
		--	Use class colors in chat
		----------------------------------------------------------------------

		if LeaPlusLC["ClassColorsInChat"] == "On" and not LeaLockList["ClassColorsInChat"] then

			SetCVar("chatClassColorOverride", "0")

			for void, v in ipairs({"SAY", "EMOTE", "YELL", "GUILD", "OFFICER", "WHISPER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "RAID_WARNING", "INSTANCE_CHAT", "INSTANCE_CHAT_LEADER", "VOICE_TEXT"}) do
				SetChatColorNameByClass(v, true)
			end

			for i = 1, 50 do
				SetChatColorNameByClass("CHANNEL" .. i, true)
			end

		end

		----------------------------------------------------------------------
		-- Disable screen glow (no reload required)
		----------------------------------------------------------------------

		do

			-- Function to set screen glow
			local function SetGlow()
				if LeaPlusLC["NoScreenGlow"] == "On" then
					SetCVar("ffxGlow", "0")
				else
					SetCVar("ffxGlow", "1")
				end
			end

			-- Set screen glow on startup and when option is clicked (if enabled)
			LeaPlusCB["NoScreenGlow"]:HookScript("OnClick", SetGlow)
			if LeaPlusLC["NoScreenGlow"] == "On" then SetGlow() end

		end

		----------------------------------------------------------------------
		-- Disable screen effects (no reload required)
		----------------------------------------------------------------------

		do

			-- Function to set screen effects
			local function SetEffects()
				if LeaPlusLC["NoScreenEffects"] == "On" then
					SetCVar("ffxDeath", "0")
					SetCVar("ffxNether", "0")
				else
					SetCVar("ffxDeath", "1")
					SetCVar("ffxNether", "1")
				end
			end

			-- Set screen effects when option is clicked and on startup (if enabled)
			LeaPlusCB["NoScreenEffects"]:HookScript("OnClick", SetEffects)
			if LeaPlusLC["NoScreenEffects"] == "On" then SetEffects() end

		end

		----------------------------------------------------------------------
		-- Universal group chat color (no reload required)
		----------------------------------------------------------------------

		do

			-- Function to set chat colors
			local function SetCol()
				if LeaPlusLC["UnivGroupColor"] == "On" then
					ChangeChatColor("RAID", 0.67, 0.67, 1)
					ChangeChatColor("RAID_LEADER", 0.46, 0.78, 1)
				else
					ChangeChatColor("RAID", 1, 0.50, 0)
					ChangeChatColor("RAID_LEADER", 1, 0.28, 0.04)
				end
			end

			-- Set chat colors when option is clicked and on startup (if enabled)
			LeaPlusCB["UnivGroupColor"]:HookScript("OnClick", SetCol)
			if LeaPlusLC["UnivGroupColor"] == "On" then	SetCol() end

		end

		----------------------------------------------------------------------
		-- Minimap button (no reload required)
		----------------------------------------------------------------------

		do

			-- Minimap button click function
			local function MiniBtnClickFunc(arg1)
				-- Prevent options panel from showing if Blizzard options panel is showing
				if ChatConfigFrame:IsShown() then return end
				-- Prevent options panel from showing if Blizzard Store is showing
				if StoreFrame and StoreFrame:GetAttribute("isshown") then return end
				-- Left button down
				if arg1 == "LeftButton" then

					-- Shift key toggles music
					if IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown() then
						Sound_ToggleMusic()
						return
					end

					-- Control key toggles target tracking
					if IsControlKeyDown() and not IsShiftKeyDown() and not IsAltKeyDown() then
						for i = 1, C_Minimap.GetNumTrackingTypes() do
							local trackingInfo = C_Minimap.GetTrackingInfo(i)
							if trackingInfo.name and trackingInfo.name == MINIMAP_TRACKING_TARGET then
								if trackingInfo.active then
									C_Minimap.SetTracking(i, false)
									ActionStatus_DisplayMessage(L["Target Tracking Disabled"], true)
								else
									C_Minimap.SetTracking(i, true)
									ActionStatus_DisplayMessage(L["Target Tracking Enabled"], true)
								end
							end
						end
						return
					end

					-- Alt key toggles error messages
					if IsAltKeyDown() and not IsControlKeyDown() and not IsShiftKeyDown() then
						if LeaPlusDB["HideErrorMessages"] == "On" then -- Checks global
							if LeaPlusLC["ShowErrorsFlag"] == 1 then
								LeaPlusLC["ShowErrorsFlag"] = 0
								ActionStatus_DisplayMessage(L["Error messages will be shown"], true)
							else
								LeaPlusLC["ShowErrorsFlag"] = 1
								ActionStatus_DisplayMessage(L["Error messages will be hidden"], true)
							end
							return
						end
						return
					end

					-- Control key and alt key toggles Zygor addon
					if IsControlKeyDown() and IsAltKeyDown() and not IsShiftKeyDown() then
						LeaPlusLC:ZygorToggle()
						return
					end

					-- Control key and shift key toggles maximised window mode
					if IsControlKeyDown() and IsShiftKeyDown() and not IsAltKeyDown() then
						if LeaPlusLC:PlayerInCombat() then
							return
						else
							SetCVar("gxMaximize", tostring(1 - GetCVar("gxMaximize")))
							UpdateWindow()
						end
						return
					end

					-- No modifier key toggles the options panel
					if LeaPlusLC:IsPlusShowing() then
						LeaPlusLC:HideFrames()
						LeaPlusLC:HideConfigPanels()
					else
						LeaPlusLC:HideFrames()
						LeaPlusLC["PageF"]:Show()
					end
					LeaPlusLC["Page"..LeaPlusLC["LeaStartPage"]]:Show()
				end

				-- Right button down
				if arg1 == "RightButton" then

					-- No modifier key toggles the options panel
					if LeaPlusLC:IsPlusShowing() then
						LeaPlusLC:HideFrames()
						LeaPlusLC:HideConfigPanels()
					else
						LeaPlusLC:HideFrames()
						LeaPlusLC["PageF"]:Show()
					end
					LeaPlusLC["Page" .. LeaPlusLC["LeaStartPage"]]:Show()

				end

			end

			-- Create minimap button using LibDBIcon
			local miniButton = LibStub("LibDataBroker-1.1"):NewDataObject("Leatrix_Plus", {
				type = "data source",
				text = "Leatrix Plus",
				icon = "Interface\\HELPFRAME\\ReportLagIcon-Movement",
				OnClick = function(self, btn)
					MiniBtnClickFunc(btn)
				end,
				OnTooltipShow = function(tooltip)
					if not tooltip or not tooltip.AddLine then return end
					tooltip:AddLine("Leatrix Plus")
				end,
			})

			local icon = LibStub("LibDBIcon-1.0", true)
			icon:Register("Leatrix_Plus", miniButton, LeaPlusDB)

			-- Function to toggle LibDBIcon
			local function SetLibDBIconFunc()
				if LeaPlusLC["ShowMinimapIcon"] == "On" then
					LeaPlusDB["hide"] = false
					icon:Show("Leatrix_Plus")
				else
					LeaPlusDB["hide"] = true
					icon:Hide("Leatrix_Plus")
				end
			end

			-- Set LibDBIcon when option is clicked and on startup
			LeaPlusCB["ShowMinimapIcon"]:HookScript("OnClick", SetLibDBIconFunc)
			SetLibDBIconFunc()

		end

		----------------------------------------------------------------------
		-- Show volume control on character frame
		----------------------------------------------------------------------

		if LeaPlusLC["ShowVolume"] == "On" then

			-- Function to update master volume
			local function MasterVolUpdate()
				if LeaPlusLC["ShowVolume"] == "On" then
					-- Set the volume
					SetCVar("Sound_MasterVolume", LeaPlusLC["LeaPlusMaxVol"]);
					-- Format the slider text
					LeaPlusCB["LeaPlusMaxVol"].f:SetFormattedText("%.0f", LeaPlusLC["LeaPlusMaxVol"] * 20)
				end
			end

			-- Create slider control
			LeaPlusLC["LeaPlusMaxVol"] = tonumber(GetCVar("Sound_MasterVolume"))
			LeaPlusLC:MakeSL(CharacterModelScene, "LeaPlusMaxVol", "",	0, 1, 0.05, -42, -328, "%.2f")
			LeaPlusCB["LeaPlusMaxVol"]:SetWidth(64)
			LeaPlusCB["LeaPlusMaxVol"].f:ClearAllPoints()
			LeaPlusCB["LeaPlusMaxVol"].f:SetPoint("LEFT", LeaPlusCB["LeaPlusMaxVol"], "RIGHT", 6, 0)

			-- Set slider control value when shown
			LeaPlusCB["LeaPlusMaxVol"]:SetScript("OnShow", function()
				LeaPlusCB["LeaPlusMaxVol"]:SetValue(GetCVar("Sound_MasterVolume"))
			end)

			-- Update volume when slider control is changed
			LeaPlusCB["LeaPlusMaxVol"]:HookScript("OnValueChanged", function()
				if IsMouseButtonDown("RightButton") and IsShiftKeyDown() then
					-- Dual layout is active so don't adjust slider
					LeaPlusCB["LeaPlusMaxVol"].f:SetFormattedText("%.0f", LeaPlusLC["LeaPlusMaxVol"] * 20)
					LeaPlusCB["LeaPlusMaxVol"]:Hide()
					LeaPlusCB["LeaPlusMaxVol"]:Show()
					return
				else
					-- Set sound level and refresh slider
					MasterVolUpdate()
				end
			end)

			-- ElvUI skin for slider control
			if LeaPlusLC.ElvUI then
				_G.LeaPlusGlobalVolumeButton = LeaPlusCB["LeaPlusMaxVol"]
				LeaPlusLC.ElvUI:GetModule("Skins"):HandleSliderFrame(_G.LeaPlusGlobalVolumeButton, false)
			end

		end

		----------------------------------------------------------------------
		--	Use arrow keys in chat
		----------------------------------------------------------------------

		if LeaPlusLC["UseArrowKeysInChat"] == "On" and not LeaLockList["UseArrowKeysInChat"] then
			-- Enable arrow keys for normal and existing chat frames
			for i = 1, 50 do
				if _G["ChatFrame" .. i] then
					_G["ChatFrame" .. i .. "EditBox"]:SetAltArrowKeyMode(false)
				end
			end
			-- Enable arrow keys for temporary chat frames
			hooksecurefunc("FCF_OpenTemporaryWindow", function()
				local cf = FCF_GetCurrentChatFrame():GetName() or nil
				if cf then
					_G[cf .. "EditBox"]:SetAltArrowKeyMode(false)
				end
			end)
		end

		----------------------------------------------------------------------
		-- L41: Manage buffs
		----------------------------------------------------------------------

		if LeaPlusLC["ManageBuffs"] == "On" and not LeaLockList["ManageBuffs"] then

			-- Allow buff frame to be moved
			BuffFrame:SetMovable(true)
			BuffFrame:SetUserPlaced(true)
			BuffFrame:SetDontSavePosition(true)
			BuffFrame:SetClampedToScreen(true)

			-- Set buff frame position at startup
			BuffFrame:ClearAllPoints()
			BuffFrame:SetPoint(LeaPlusLC["BuffFrameA"], UIParent, LeaPlusLC["BuffFrameR"], LeaPlusLC["BuffFrameX"], LeaPlusLC["BuffFrameY"])
			BuffFrame:SetScale(LeaPlusLC["BuffFrameScale"])
			TemporaryEnchantFrame:SetScale(LeaPlusLC["BuffFrameScale"])
			ConsolidatedBuffs:SetScale(LeaPlusLC["BuffFrameScale"])

			-- Set buff frame position when the game resets it
			hooksecurefunc("UIParent_UpdateTopFramePositions", function()
				BuffFrame:SetMovable(true)
				BuffFrame:ClearAllPoints()
				BuffFrame:SetPoint(LeaPlusLC["BuffFrameA"], UIParent, LeaPlusLC["BuffFrameR"], LeaPlusLC["BuffFrameX"], LeaPlusLC["BuffFrameY"])
			end)

			-- Create drag frame
			local dragframe = CreateFrame("FRAME", nil, nil, "BackdropTemplate")
			dragframe:SetPoint("TOPRIGHT", BuffFrame, "TOPRIGHT", 0, 2.5)
			dragframe:SetBackdropColor(0.0, 0.5, 1.0)
			dragframe:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 16, insets = { left = 0, right = 0, top = 0, bottom = 0 }})
			dragframe:SetToplevel(true)
			dragframe:Hide()
			dragframe:SetScale(LeaPlusLC["BuffFrameScale"])

			dragframe.t = dragframe:CreateTexture()
			dragframe.t:SetAllPoints()
			dragframe.t:SetColorTexture(0.0, 1.0, 0.0, 0.5)
			dragframe.t:SetAlpha(0.5)

			dragframe.f = dragframe:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			dragframe.f:SetPoint('CENTER', 0, 0)
			dragframe.f:SetText(L["Buffs"])

			-- Click handler
			dragframe:SetScript("OnMouseDown", function(self, btn)
				-- Start dragging if left clicked
				if btn == "LeftButton" then
					BuffFrame:StartMoving()
				end
			end)

			dragframe:SetScript("OnMouseUp", function()
				-- Save frame positions
				BuffFrame:StopMovingOrSizing()
				LeaPlusLC["BuffFrameA"], void, LeaPlusLC["BuffFrameR"], LeaPlusLC["BuffFrameX"], LeaPlusLC["BuffFrameY"] = BuffFrame:GetPoint()
				BuffFrame:SetMovable(true)
				BuffFrame:ClearAllPoints()
				BuffFrame:SetPoint(LeaPlusLC["BuffFrameA"], UIParent, LeaPlusLC["BuffFrameR"], LeaPlusLC["BuffFrameX"], LeaPlusLC["BuffFrameY"])
			end)

			-- Snap-to-grid
			do
				local frame, grid = dragframe, 10
				local w, h = -190, 225
				local xpos, ypos, scale, uiscale
				frame:RegisterForDrag("RightButton")
				frame:HookScript("OnDragStart", function()
					frame:SetScript("OnUpdate", function()
						scale, uiscale = frame:GetScale(), UIParent:GetScale()
						xpos, ypos = GetCursorPosition()
						xpos = floor((xpos / scale / uiscale) / grid) * grid - w / 2
						ypos = ceil((ypos / scale / uiscale) / grid) * grid + h / 2
						BuffFrame:ClearAllPoints()
						BuffFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", xpos, ypos)
					end)
				end)
				frame:HookScript("OnDragStop", function()
					frame:SetScript("OnUpdate", nil)
					frame:GetScript("OnMouseUp")()
				end)
			end

			-- Create configuration panel
			local BuffPanel = LeaPlusLC:CreatePanel("Manage buffs", "BuffPanel")

			LeaPlusLC:MakeTx(BuffPanel, "Scale", 16, -72)
			LeaPlusLC:MakeSL(BuffPanel, "BuffFrameScale", "Drag to set the buffs frame scale.", 0.5, 2, 0.05, 16, -92, "%.2f")

			-- Set scale when slider is changed
			LeaPlusCB["BuffFrameScale"]:HookScript("OnValueChanged", function()
				BuffFrame:SetScale(LeaPlusLC["BuffFrameScale"])
				TemporaryEnchantFrame:SetScale(LeaPlusLC["BuffFrameScale"])
				ConsolidatedBuffs:SetScale(LeaPlusLC["BuffFrameScale"])
				dragframe:SetScale(LeaPlusLC["BuffFrameScale"])
				-- Show formatted slider value
				LeaPlusCB["BuffFrameScale"].f:SetFormattedText("%.0f%%", LeaPlusLC["BuffFrameScale"] * 100)
			end)

			-- Hide frame alignment grid with panel
			BuffPanel:HookScript("OnHide", function()
				LeaPlusLC.grid:Hide()
			end)

			-- Toggle grid button
			local BuffsToggleGridButton = LeaPlusLC:CreateButton("BuffsToggleGridButton", BuffPanel, "Toggle Grid", "TOPLEFT", 16, -72, 0, 25, true, "Click to toggle the frame alignment grid.")
			LeaPlusCB["BuffsToggleGridButton"]:ClearAllPoints()
			LeaPlusCB["BuffsToggleGridButton"]:SetPoint("LEFT", BuffPanel.h, "RIGHT", 10, 0)
			LeaPlusCB["BuffsToggleGridButton"]:SetScript("OnClick", function()
				if LeaPlusLC.grid:IsShown() then LeaPlusLC.grid:Hide() else LeaPlusLC.grid:Show() end
			end)
			BuffPanel:HookScript("OnHide", function()
				if LeaPlusLC.grid then LeaPlusLC.grid:Hide() end
			end)

			-- Help button tooltip
			BuffPanel.h.tiptext = L["Drag the frame overlay with the left button to position it freely or with the right button to position it using snap-to-grid."]

			-- Back button handler
			BuffPanel.b:SetScript("OnClick", function()
				BuffPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page6"]:Show()
				return
			end)

			-- Reset button handler
			BuffPanel.r:SetScript("OnClick", function()

				-- Reset position and scale
				LeaPlusLC["BuffFrameA"] = "TOPRIGHT"
				LeaPlusLC["BuffFrameR"] = "TOPRIGHT"
				LeaPlusLC["BuffFrameX"] = -205
				LeaPlusLC["BuffFrameY"] = -13
				LeaPlusLC["BuffFrameScale"] = 1
				BuffFrame:ClearAllPoints()
				BuffFrame:SetPoint(LeaPlusLC["BuffFrameA"], UIParent, LeaPlusLC["BuffFrameR"], LeaPlusLC["BuffFrameX"], LeaPlusLC["BuffFrameY"])

				-- Refresh configuration panel
				BuffPanel:Hide(); BuffPanel:Show()
				dragframe:Show()

				-- Show frame alignment grid
				LeaPlusLC.grid:Show()

			end)

			-- Show configuration panel when options panel button is clicked
			LeaPlusCB["ManageBuffsButton"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["BuffFrameA"] = "TOPRIGHT"
					LeaPlusLC["BuffFrameR"] = "TOPRIGHT"
					LeaPlusLC["BuffFrameX"] = -271
					LeaPlusLC["BuffFrameY"] = 0
					LeaPlusLC["BuffFrameScale"] = 0.80
					BuffFrame:ClearAllPoints()
					BuffFrame:SetPoint(LeaPlusLC["BuffFrameA"], UIParent, LeaPlusLC["BuffFrameR"], LeaPlusLC["BuffFrameX"], LeaPlusLC["BuffFrameY"])
					BuffFrame:SetScale(LeaPlusLC["BuffFrameScale"])
					TemporaryEnchantFrame:SetScale(LeaPlusLC["BuffFrameScale"])
					ConsolidatedBuffs:SetScale(LeaPlusLC["BuffFrameScale"])
				else
					-- Find out if the UI has a non-standard scale
					if GetCVar("useuiscale") == "1" then
						LeaPlusLC["gscale"] = GetCVar("uiscale")
					else
						LeaPlusLC["gscale"] = 1
					end

					-- Set drag frame size according to UI scale
					dragframe:SetWidth(280 * LeaPlusLC["gscale"])
					dragframe:SetHeight(225 * LeaPlusLC["gscale"])

					-- Show configuration panel
					BuffPanel:Show()
					LeaPlusLC:HideFrames()
					dragframe:Show()

					-- Show frame alignment grid
					LeaPlusLC.grid:Show()
				end
			end)

			-- Hide drag frame when configuration panel is closed
			BuffPanel:HookScript("OnHide", function() dragframe:Hide() end)

		end

		----------------------------------------------------------------------
		-- L42: Manage frames
		----------------------------------------------------------------------

		-- Frame Movement
		if LeaPlusLC["FrmEnabled"] == "On" and not LeaLockList["FrmEnabled"] then

			-- Lock the player and target frames
			PlayerFrame:RegisterForDrag()
			TargetFrame:RegisterForDrag()

			-- Remove integrated movement functions to avoid conflicts
			_G.PlayerFrame_ResetUserPlacedPosition = function() end
			_G.TargetFrame_ResetUserPlacedPosition = function() end
			_G.PlayerFrame_SetLocked = function() end
			_G.TargetFrame_SetLocked = function() end

			-- Create frame table (used for local traversal)
			local FrameTable = {DragPlayerFrame = PlayerFrame, DragTargetFrame = TargetFrame}

			-- Create main table structure in saved variables if it doesn't exist
			if (LeaPlusDB["Frames"]) == nil then
				LeaPlusDB["Frames"] = {}
			end

			-- Create frame based table structure in saved variables if it doesn't exist and set initial scales
			for k,v in pairs(FrameTable) do
				local vf = v:GetName()
				-- Create frame table structure if it doesn't exist
				if not LeaPlusDB["Frames"][vf] then
					LeaPlusDB["Frames"][vf] = {}
				end
				-- Set saved scale value to default if it doesn't exist
				if not LeaPlusDB["Frames"][vf]["Scale"] then
					LeaPlusDB["Frames"][vf]["Scale"] = 1.00
				end
				-- Set frame scale to saved value
				_G[vf]:SetScale(LeaPlusDB["Frames"][vf]["Scale"])
				-- Don't save frame position
				_G[vf]:SetMovable(true)
				_G[vf]:SetUserPlaced(true)
				_G[vf]:SetDontSavePosition(true)
			end

			-- Set frames to manual values
			local function LeaFramesSetPos(frame, point, parent, relative, xoff, yoff)
				frame:SetMovable(true)
				frame:ClearAllPoints()
				frame:SetPoint(point, parent, relative, xoff, yoff)
			end

			-- Set frames to default values
			local function LeaPlusFramesDefaults()
				LeaFramesSetPos(PlayerFrame						, "TOPLEFT"	, UIParent, "TOPLEFT"	, -19, -4)
				LeaFramesSetPos(TargetFrame						, "TOPLEFT"	, UIParent, "TOPLEFT"	, 250, -4)
			end

			-- Create configuration panel
			local SideFrames = LeaPlusLC:CreatePanel("Manage frames", "SideFrames")

			-- Variable used to store currently selected frame
			local currentframe

			-- Create scale title
			LeaPlusLC:MakeTx(SideFrames, "Scale", 16, -72)

			-- Set initial slider value (will be changed when drag frames are selected)
			LeaPlusLC["FrameScale"] = 1.00

			-- Create scale slider
			LeaPlusLC:MakeSL(SideFrames, "FrameScale", "Drag to set the scale of the selected frame.", 0.5, 3.0, 0.05, 16, -92, "%.2f")
			LeaPlusCB["FrameScale"]:HookScript("OnValueChanged", function(self, value)
				if currentframe then -- If a frame is selected
					-- Set real and drag frame scale
					LeaPlusDB["Frames"][currentframe]["Scale"] = value
					_G[currentframe]:SetScale(LeaPlusDB["Frames"][currentframe]["Scale"])
					LeaPlusLC["Drag" .. currentframe]:SetScale(LeaPlusDB["Frames"][currentframe]["Scale"])
					-- If target frame scale is changed, also change combo point frame
					if currentframe == "TargetFrame" then
						ComboFrame:SetScale(LeaPlusDB["Frames"]["TargetFrame"]["Scale"])
					end
					-- Set slider formatted text
					LeaPlusCB["FrameScale"].f:SetFormattedText("%.0f%%", LeaPlusLC["FrameScale"] * 100)
				end
			end)

			-- Set initial scale slider state and value
			LeaPlusCB["FrameScale"]:HookScript("OnShow", function()
				if not currentframe then
					-- No frame selected so select the player frame
					currentframe = PlayerFrame:GetName()
					LeaPlusLC["DragPlayerFrame"].t:SetColorTexture(0.0, 1.0, 0.0,0.5)
				end
				-- Set the scale slider value to the selected frame
				LeaPlusCB["FrameScale"]:SetValue(LeaPlusDB["Frames"][currentframe]["Scale"])
				-- Set slider formatted text
				LeaPlusCB["FrameScale"].f:SetFormattedText("%.0f%%", LeaPlusLC["FrameScale"] * 100)
			end)

			-- Hide frame alignment grid with panel
			SideFrames:HookScript("OnHide", function()
				LeaPlusLC.grid:Hide()
			end)

			-- Toggle grid button
			local FramesToggleGridButton = LeaPlusLC:CreateButton("FramesToggleGridButton", SideFrames, "Toggle Grid", "TOPLEFT", 16, -72, 0, 25, true, "Click to toggle the frame alignment grid.")
			LeaPlusCB["FramesToggleGridButton"]:ClearAllPoints()
			LeaPlusCB["FramesToggleGridButton"]:SetPoint("LEFT", SideFrames.h, "RIGHT", 10, 0)
			LeaPlusCB["FramesToggleGridButton"]:SetScript("OnClick", function()
				if LeaPlusLC.grid:IsShown() then LeaPlusLC.grid:Hide() else LeaPlusLC.grid:Show() end
			end)
			SideFrames:HookScript("OnHide", function()
				if LeaPlusLC.grid then LeaPlusLC.grid:Hide() end
			end)

			-- Help button tooltip
			SideFrames.h.tiptext = L["Drag the frame overlays with the left button to position them freely or with the right button to position them using snap-to-grid.|n|nTo change the scale of a frame, click it to select it then adjust the scale slider.|n|nThis panel will close automatically if you enter combat."]

			-- Back button handler
			SideFrames.b:SetScript("OnClick", function()
				-- Hide outer control frame
				SideFrames:Hide()
				-- Hide drag frames
				for k, void in pairs(FrameTable) do
					LeaPlusLC[k]:Hide()
				end
				-- Show options panel at frame section
				LeaPlusLC["PageF"]:Show()
				LeaPlusLC["Page6"]:Show()
			end)

			-- Reset button handler
			SideFrames.r:SetScript("OnClick", function()
				if LeaPlusLC:PlayerInCombat() then
					-- If player is in combat, print error and stop
					return
				else
					-- Set frames to default positions (presets)
					LeaPlusFramesDefaults()
					for k,v in pairs(FrameTable) do
						local vf = v:GetName()
						-- Store frame locations
						LeaPlusDB["Frames"][vf]["Point"], void, LeaPlusDB["Frames"][vf]["Relative"], LeaPlusDB["Frames"][vf]["XOffset"], LeaPlusDB["Frames"][vf]["YOffset"] = _G[vf]:GetPoint()
						-- Reset real frame scales and save them
						LeaPlusDB["Frames"][vf]["Scale"] = 1.00
						_G[vf]:SetScale(LeaPlusDB["Frames"][vf]["Scale"])
						-- Reset drag frame scales
						LeaPlusLC[k]:SetScale(LeaPlusDB["Frames"][vf]["Scale"])
					end
					-- Set combo frame scale to match target frame scale
					ComboFrame:SetScale(LeaPlusDB["Frames"]["TargetFrame"]["Scale"])
					-- Set the scale slider value to the selected frame scale
					LeaPlusCB["FrameScale"]:SetValue(LeaPlusDB["Frames"][currentframe]["Scale"])
					-- Refresh the panel
					SideFrames:Hide(); SideFrames:Show()
					-- Show frame alignment grid
					LeaPlusLC.grid:Show()
				end
			end)

			-- Show drag frames with configuration panel
			SideFrames:HookScript("OnShow", function()
				for k, void in pairs(FrameTable) do
					LeaPlusLC[k]:Show()
				end
			end)
			SideFrames:HookScript("OnHide", function()
				for k, void in pairs(FrameTable) do
					LeaPlusLC[k]:Hide()
				end
			end)

			-- Save frame positions
			local function SaveAllFrames(DoNotSetPoint)
				for k, v in pairs(FrameTable) do
					local vf = v:GetName()
					-- Stop real frames from moving
					v:StopMovingOrSizing()
					-- Save frame positions
					LeaPlusDB["Frames"][vf]["Point"], void, LeaPlusDB["Frames"][vf]["Relative"], LeaPlusDB["Frames"][vf]["XOffset"], LeaPlusDB["Frames"][vf]["YOffset"] = v:GetPoint()
					if not DoNotSetPoint then
						v:SetMovable(true)
						v:ClearAllPoints()
						v:SetPoint(LeaPlusDB["Frames"][vf]["Point"], UIParent, LeaPlusDB["Frames"][vf]["Relative"], LeaPlusDB["Frames"][vf]["XOffset"], LeaPlusDB["Frames"][vf]["YOffset"])
					end
				end
			end

			-- Prevent changes during combat
			SideFrames:SetScript("OnUpdate", function()
				if UnitAffectingCombat("player") then
					-- Hide controls frame
					SideFrames:Hide()
					-- Hide drag frames
					for k,void in pairs(FrameTable) do
						LeaPlusLC[k]:Hide()
					end
					-- Save frame positions without setpoint
					SaveAllFrames(true)
				end
			end)

			-- Create drag frames
			local function LeaPlusMakeDrag(dragframe,realframe)

				local dragframe = CreateFrame("Frame", nil, nil, "BackdropTemplate")
				LeaPlusLC[dragframe] = dragframe
				dragframe:SetSize(realframe:GetSize())
				dragframe:SetPoint("TOP", realframe, "TOP", 0, 2.5)
				dragframe:SetBackdropColor(0.0, 0.5, 1.0)
				dragframe:SetBackdrop({
					edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
					tile = false, tileSize = 0, edgeSize = 16,
					insets = { left = 0, right = 0, top = 0, bottom = 0 }})
				dragframe:SetToplevel(true)
				dragframe:SetFrameStrata("HIGH")

				-- Set frame clamps
				realframe:SetClampedToScreen(false)

				-- Hide the drag frame and make real frame movable
				dragframe:Hide()
				realframe:SetMovable(true)

				-- Click handler
				dragframe:SetScript("OnMouseDown", function(self, btn)

					-- Start dragging if left clicked
					if btn == "LeftButton" then
						realframe:SetMovable(true)
						realframe:StartMoving()
					end

					-- Set all drag frames to blue then tint the selected frame to green
					for k,v in pairs(FrameTable) do
						LeaPlusLC[k].t:SetColorTexture(0.0, 0.5, 1.0, 0.5)
					end
					dragframe.t:SetColorTexture(0.0, 1.0, 0.0, 0.5)

					-- Set currentframe variable to selected frame and set the scale slider value
					currentframe = realframe:GetName()
					LeaPlusCB["FrameScale"]:SetValue(LeaPlusDB["Frames"][currentframe]["Scale"])

				end)

				dragframe:SetScript("OnMouseUp", function()
					-- Save frame positions
					SaveAllFrames()
				end)

				dragframe.t = dragframe:CreateTexture()
				dragframe.t:SetAllPoints()
				dragframe.t:SetColorTexture(0.0, 0.5, 1.0, 0.5)
				dragframe.t:SetAlpha(0.5)

				dragframe.f = dragframe:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
				dragframe.f:SetPoint('CENTER', 0, 0)

				-- Add titles
				if realframe:GetName() == "PlayerFrame" 					then dragframe.f:SetText(L["Player"]) end
				if realframe:GetName() == "TargetFrame" 					then dragframe.f:SetText(L["Target"]) end

				-- Snap-to-grid
				do
					local frame, grid = dragframe, 10
					local w, h = frame:GetWidth(), frame:GetHeight()
					local xpos, ypos, scale, uiscale
					frame:RegisterForDrag("RightButton")
					frame:HookScript("OnDragStart", function()
						frame:SetScript("OnUpdate", function()
							scale, uiscale = frame:GetScale(), UIParent:GetScale()
							xpos, ypos = GetCursorPosition()
							xpos = floor((xpos / scale / uiscale) / grid) * grid - w / 2
							ypos = ceil((ypos / scale / uiscale) / grid) * grid + h / 2
							realframe:ClearAllPoints()
							realframe:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", xpos, ypos)
						end)
					end)
					frame:HookScript("OnDragStop", function()
						frame:SetScript("OnUpdate", nil)
						frame:GetScript("OnMouseUp")()
					end)
				end

				-- Return frame
				return LeaPlusLC[dragframe]

			end

			for k,v in pairs(FrameTable) do
				LeaPlusLC[k] = LeaPlusMakeDrag(k,v)
			end

			-- Set frame scales
			for k,v in pairs(FrameTable) do
				local vf = v:GetName()
				_G[vf]:SetScale(LeaPlusDB["Frames"][vf]["Scale"])
				LeaPlusLC[k]:SetScale(LeaPlusDB["Frames"][vf]["Scale"])
			end
			ComboFrame:SetScale(LeaPlusDB["Frames"]["TargetFrame"]["Scale"])

			-- Load defaults first then overwrite with saved values if they exist
			LeaPlusFramesDefaults()
			if LeaPlusDB["Frames"] then
				for k,v in pairs(FrameTable) do
					local vf = v:GetName()
					if LeaPlusDB["Frames"][vf] then
						if LeaPlusDB["Frames"][vf]["Point"] and LeaPlusDB["Frames"][vf]["Relative"] and LeaPlusDB["Frames"][vf]["XOffset"] and LeaPlusDB["Frames"][vf]["YOffset"] then
							_G[vf]:SetMovable(true)
							_G[vf]:ClearAllPoints()
							_G[vf]:SetPoint(LeaPlusDB["Frames"][vf]["Point"], UIParent, LeaPlusDB["Frames"][vf]["Relative"], LeaPlusDB["Frames"][vf]["XOffset"], LeaPlusDB["Frames"][vf]["YOffset"])
						end
					end
				end
			end

			-- Add move button
			LeaPlusCB["MoveFramesButton"]:SetScript("OnClick", function()
				if LeaPlusLC:PlayerInCombat() then
					return
				else
					if IsShiftKeyDown() and IsControlKeyDown() then
						-- Preset profile
						LeaFramesSetPos(PlayerFrame						, "TOPLEFT"	, UIParent, "TOPLEFT"	,	"-35"	, "-14")
						LeaFramesSetPos(TargetFrame						, "TOPLEFT"	, UIParent, "TOPLEFT"	,	"190"	, "-14")
						-- Player
						LeaPlusDB["Frames"]["PlayerFrame"]["Scale"] = 1.20
						PlayerFrame:SetScale(LeaPlusDB["Frames"]["PlayerFrame"]["Scale"])
						LeaPlusLC["DragPlayerFrame"]:SetScale(LeaPlusDB["Frames"]["PlayerFrame"]["Scale"])
						-- Target
						LeaPlusDB["Frames"]["TargetFrame"]["Scale"] = 1.20
						TargetFrame:SetScale(LeaPlusDB["Frames"]["TargetFrame"]["Scale"])
						LeaPlusLC["DragTargetFrame"]:SetScale(LeaPlusDB["Frames"]["TargetFrame"]["Scale"])
						-- Set the slider to the selected frame (if there is one)
						if currentframe then LeaPlusCB["FrameScale"]:SetValue(LeaPlusDB["Frames"][currentframe]["Scale"]); end
						-- Save locations
						for k,v in pairs(FrameTable) do
							local vf = v:GetName()
							LeaPlusDB["Frames"][vf]["Point"], void, LeaPlusDB["Frames"][vf]["Relative"], LeaPlusDB["Frames"][vf]["XOffset"], LeaPlusDB["Frames"][vf]["YOffset"] = _G[vf]:GetPoint()
						end
					else
						-- Show mover frame
						SideFrames:Show()
						LeaPlusLC:HideFrames()

						-- Find out if the UI has a non-standard scale
						if GetCVar("useuiscale") == "1" then
							LeaPlusLC["gscale"] = GetCVar("uiscale")
						else
							LeaPlusLC["gscale"] = 1
						end

						-- Set all scaled sizes
						for k,v in pairs(FrameTable) do
							LeaPlusLC[k]:SetWidth(v:GetWidth() * LeaPlusLC["gscale"])
							LeaPlusLC[k]:SetHeight(v:GetHeight() * LeaPlusLC["gscale"])
						end

						-- Show frame alignment grid
						LeaPlusLC.grid:Show()
					end
				end
			end)

		end

		----------------------------------------------------------------------
		-- L43: Manage widget
		----------------------------------------------------------------------

		if LeaPlusLC["ManageWidget"] == "On" and not LeaLockList["ManageWidget"] then

			-- Create and manage container for UIWidgetTopCenterContainerFrame
			local topCenterHolder = CreateFrame("Frame", nil, UIParent)
			topCenterHolder:SetPoint("TOP", UIParent, "TOP", 0, -15)
			topCenterHolder:SetSize(10, 58)

			local topCenterContainer = _G.UIWidgetTopCenterContainerFrame
			topCenterContainer:ClearAllPoints()
			topCenterContainer:SetPoint('CENTER', topCenterHolder)

			hooksecurefunc(topCenterContainer, 'SetPoint', function(self, void, b)
				if b and (b ~= topCenterHolder) then
					-- Reset parent if it changes from topCenterHolder
					self:ClearAllPoints()
					self:SetPoint('CENTER', topCenterHolder)
					self:SetParent(topCenterHolder)
				end
			end)

			-- Allow widget frame to be moved
			topCenterHolder:SetMovable(true)
			topCenterHolder:SetUserPlaced(true)
			topCenterHolder:SetDontSavePosition(true)
			topCenterHolder:SetClampedToScreen(false)

			-- Set widget frame position at startup
			topCenterHolder:ClearAllPoints()
			topCenterHolder:SetPoint(LeaPlusLC["WidgetA"], UIParent, LeaPlusLC["WidgetR"], LeaPlusLC["WidgetX"], LeaPlusLC["WidgetY"])
			topCenterHolder:SetScale(LeaPlusLC["WidgetScale"])
			UIWidgetTopCenterContainerFrame:SetScale(LeaPlusLC["WidgetScale"])

			-- Create drag frame
			local dragframe = CreateFrame("FRAME", nil, nil, "BackdropTemplate")
			dragframe:SetPoint("CENTER", topCenterHolder, "CENTER", 0, 1)
			dragframe:SetBackdropColor(0.0, 0.5, 1.0)
			dragframe:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 16, insets = { left = 0, right = 0, top = 0, bottom = 0}})
			dragframe:SetToplevel(true)
			dragframe:Hide()
			dragframe:SetScale(LeaPlusLC["WidgetScale"])

			dragframe.t = dragframe:CreateTexture()
			dragframe.t:SetAllPoints()
			dragframe.t:SetColorTexture(0.0, 1.0, 0.0, 0.5)
			dragframe.t:SetAlpha(0.5)

			dragframe.f = dragframe:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			dragframe.f:SetPoint('CENTER', 0, 0)
			dragframe.f:SetText(L["Widget"])

			-- Click handler
			dragframe:SetScript("OnMouseDown", function(self, btn)
				-- Start dragging if left clicked
				if btn == "LeftButton" then
					topCenterHolder:StartMoving()
				end
			end)

			dragframe:SetScript("OnMouseUp", function()
				-- Save frame position
				topCenterHolder:StopMovingOrSizing()
				LeaPlusLC["WidgetA"], void, LeaPlusLC["WidgetR"], LeaPlusLC["WidgetX"], LeaPlusLC["WidgetY"] = topCenterHolder:GetPoint()
				topCenterHolder:SetMovable(true)
				topCenterHolder:ClearAllPoints()
				topCenterHolder:SetPoint(LeaPlusLC["WidgetA"], UIParent, LeaPlusLC["WidgetR"], LeaPlusLC["WidgetX"], LeaPlusLC["WidgetY"])
			end)

			-- Snap-to-grid
			do
				local frame, grid = dragframe, 10
				local w, h = 0, 60
				local xpos, ypos, scale, uiscale
				frame:RegisterForDrag("RightButton")
				frame:HookScript("OnDragStart", function()
					frame:SetScript("OnUpdate", function()
						scale, uiscale = frame:GetScale(), UIParent:GetScale()
						xpos, ypos = GetCursorPosition()
						xpos = floor((xpos / scale / uiscale) / grid) * grid - w / 2
						ypos = ceil((ypos / scale / uiscale) / grid) * grid + h / 2
						topCenterHolder:ClearAllPoints()
						topCenterHolder:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", xpos, ypos)
					end)
				end)
				frame:HookScript("OnDragStop", function()
					frame:SetScript("OnUpdate", nil)
					frame:GetScript("OnMouseUp")()
				end)
			end

			-- Create configuration panel
			local WidgetPanel = LeaPlusLC:CreatePanel("Manage widget", "WidgetPanel")

			-- Create Titan Panel screen adjust warning
			local titanFrame = CreateFrame("FRAME", nil, WidgetPanel)
			titanFrame:SetAllPoints()
			titanFrame:Hide()
			LeaPlusLC:MakeTx(titanFrame, "Warning", 16, -172)
			titanFrame.txt = LeaPlusLC:MakeWD(titanFrame, "Titan Panel screen adjust needs to be disabled for the frame to be saved correctly.", 16, -192, 500)
			titanFrame.txt:SetWordWrap(false)
			titanFrame.txt:SetWidth(520)
			titanFrame.btn = LeaPlusLC:CreateButton("fixTitanBtn", titanFrame, "Okay, disable screen adjust for me", "TOPLEFT", 16, -212, 0, 25, true, "Click to disable Titan Panel screen adjust.  Your UI will be reloaded.")
			titanFrame.btn:SetScript("OnClick", function()
				TitanPanelSetVar("ScreenAdjust", 1)
				ReloadUI()
			end)

			LeaPlusLC:MakeTx(WidgetPanel, "Scale", 16, -72)
			LeaPlusLC:MakeSL(WidgetPanel, "WidgetScale", "Drag to set the widget scale.", 0.5, 2, 0.05, 16, -92, "%.2f")

			-- Set scale when slider is changed
			LeaPlusCB["WidgetScale"]:HookScript("OnValueChanged", function()
				topCenterHolder:SetScale(LeaPlusLC["WidgetScale"])
				UIWidgetTopCenterContainerFrame:SetScale(LeaPlusLC["WidgetScale"])
				dragframe:SetScale(LeaPlusLC["WidgetScale"])
				-- Show formatted slider value
				LeaPlusCB["WidgetScale"].f:SetFormattedText("%.0f%%", LeaPlusLC["WidgetScale"] * 100)
			end)

			-- Hide frame alignment grid with panel
			WidgetPanel:HookScript("OnHide", function()
				LeaPlusLC.grid:Hide()
			end)

			-- Toggle grid button
			local WidgetToggleGridButton = LeaPlusLC:CreateButton("WidgetToggleGridButton", WidgetPanel, "Toggle Grid", "TOPLEFT", 16, -72, 0, 25, true, "Click to toggle the frame alignment grid.")
			LeaPlusCB["WidgetToggleGridButton"]:ClearAllPoints()
			LeaPlusCB["WidgetToggleGridButton"]:SetPoint("LEFT", WidgetPanel.h, "RIGHT", 10, 0)
			LeaPlusCB["WidgetToggleGridButton"]:SetScript("OnClick", function()
				if LeaPlusLC.grid:IsShown() then LeaPlusLC.grid:Hide() else LeaPlusLC.grid:Show() end
			end)
			WidgetPanel:HookScript("OnHide", function()
				if LeaPlusLC.grid then LeaPlusLC.grid:Hide() end
			end)

			-- Help button tooltip
			WidgetPanel.h.tiptext = L["Drag the frame overlay with the left button to position it freely or with the right button to position it using snap-to-grid."]

			-- Back button handler
			WidgetPanel.b:SetScript("OnClick", function()
				WidgetPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page6"]:Show()
				return
			end)

			-- Reset button handler
			WidgetPanel.r:SetScript("OnClick", function()

				-- Reset position and scale
				LeaPlusLC["WidgetA"] = "TOP"
				LeaPlusLC["WidgetR"] = "TOP"
				LeaPlusLC["WidgetX"] = 0
				LeaPlusLC["WidgetY"] = -15
				LeaPlusLC["WidgetScale"] = 1
				topCenterHolder:ClearAllPoints()
				topCenterHolder:SetPoint(LeaPlusLC["WidgetA"], UIParent, LeaPlusLC["WidgetR"], LeaPlusLC["WidgetX"], LeaPlusLC["WidgetY"])

				-- Refresh configuration panel
				WidgetPanel:Hide(); WidgetPanel:Show()
				dragframe:Show()

				-- Show frame alignment grid
				LeaPlusLC.grid:Show()

			end)

			-- Show configuration panel when options panel button is clicked
			LeaPlusCB["ManageWidgetButton"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["WidgetA"] = "CENTER"
					LeaPlusLC["WidgetR"] = "CENTER"
					LeaPlusLC["WidgetX"] = 0
					LeaPlusLC["WidgetY"] = -160
					LeaPlusLC["WidgetScale"] = 1.25
					topCenterHolder:ClearAllPoints()
					topCenterHolder:SetPoint(LeaPlusLC["WidgetA"], UIParent, LeaPlusLC["WidgetR"], LeaPlusLC["WidgetX"], LeaPlusLC["WidgetY"])
					topCenterHolder:SetScale(LeaPlusLC["WidgetScale"])
					UIWidgetTopCenterContainerFrame:SetScale(LeaPlusLC["WidgetScale"])
				else
					-- Show Titan Panel screen adjust warning if Titan Panel is installed with screen adjust enabled
					if C_AddOns.IsAddOnLoaded("TitanClassic") then
						if TitanPanelSetVar and TitanPanelGetVar then
							if not TitanPanelGetVar("ScreenAdjust") then
								titanFrame:Show()
							end
						end
					end

					-- Find out if the UI has a non-standard scale
					if GetCVar("useuiscale") == "1" then
						LeaPlusLC["gscale"] = GetCVar("uiscale")
					else
						LeaPlusLC["gscale"] = 1
					end

					-- Set drag frame size according to UI scale
					dragframe:SetWidth(160 * LeaPlusLC["gscale"])
					dragframe:SetHeight(79 * LeaPlusLC["gscale"])

					-- Show configuration panel
					WidgetPanel:Show()
					LeaPlusLC:HideFrames()
					dragframe:Show()

					-- Show frame alignment grid
					LeaPlusLC.grid:Show()
				end
			end)

			-- Hide drag frame when configuration panel is closed
			WidgetPanel:HookScript("OnHide", function() dragframe:Hide() end)

		end

		----------------------------------------------------------------------
		-- L44: Manage focus
		----------------------------------------------------------------------

		if LeaPlusLC["ManageFocus"] == "On" and not LeaLockList["ManageFocus"] then

			-- Remove integrated movement function to avoid conflicts
			_G.FocusFrame_SetLock = function() end
			_G.FocusFrame.SetSmallSize = function() end

			-- Allow focus frame to be moved
			FocusFrame:SetMovable(true)
			FocusFrame:SetUserPlaced(true)
			FocusFrame:SetDontSavePosition(true)
			FocusFrame:SetClampedToScreen(true)

			-- Set focus frame position at startup
			FocusFrame:ClearAllPoints()
			FocusFrame:SetPoint(LeaPlusLC["FocusA"], UIParent, LeaPlusLC["FocusR"], LeaPlusLC["FocusX"], LeaPlusLC["FocusY"])
			FocusFrame:SetScale(LeaPlusLC["FocusScale"])

			-- Create drag frame
			local dragframe = CreateFrame("FRAME", nil, nil, "BackdropTemplate")
			dragframe:SetBackdropColor(0.0, 0.5, 1.0)
			dragframe:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 16, insets = { left = 0, right = 0, top = 0, bottom = 0}})
			dragframe:SetToplevel(true)
			dragframe:Hide()
			dragframe:SetScale(LeaPlusLC["FocusScale"])

			dragframe.t = dragframe:CreateTexture()
			dragframe.t:SetAllPoints()
			dragframe.t:SetColorTexture(0.0, 1.0, 0.0, 0.5)
			dragframe.t:SetAlpha(0.5)

			dragframe.f = dragframe:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			dragframe.f:SetPoint('CENTER', 0, 0)
			dragframe.f:SetText(L["Focus"])

			-- Click handler
			dragframe:SetScript("OnMouseDown", function(self, btn)
				-- Start dragging if left clicked
				if btn == "LeftButton" then
					FocusFrame:StartMoving()
				end
			end)

			dragframe:SetScript("OnMouseUp", function()
				-- Save frame positions
				FocusFrame:StopMovingOrSizing()
				LeaPlusLC["FocusA"], void, LeaPlusLC["FocusR"], LeaPlusLC["FocusX"], LeaPlusLC["FocusY"] = FocusFrame:GetPoint()
				FocusFrame:SetMovable(true)
				FocusFrame:ClearAllPoints()
				FocusFrame:SetPoint(LeaPlusLC["FocusA"], UIParent, LeaPlusLC["FocusR"], LeaPlusLC["FocusX"], LeaPlusLC["FocusY"])
			end)

			-- Snap-to-grid
			do
				local frame, grid = dragframe, 10
				local w, h = 196, 86
				local xpos, ypos, scale, uiscale
				frame:RegisterForDrag("RightButton")
				frame:HookScript("OnDragStart", function()
					frame:SetScript("OnUpdate", function()
						scale, uiscale = frame:GetScale(), UIParent:GetScale()
						xpos, ypos = GetCursorPosition()
						xpos = floor((xpos / scale / uiscale) / grid) * grid - w / 2
						ypos = ceil((ypos / scale / uiscale) / grid) * grid + h / 2
						FocusFrame:ClearAllPoints()
						FocusFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", xpos, ypos)
					end)
				end)
				frame:HookScript("OnDragStop", function()
					frame:SetScript("OnUpdate", nil)
					frame:GetScript("OnMouseUp")()
				end)
			end

			-- Create configuration panel
			local FocusPanel = LeaPlusLC:CreatePanel("Manage focus", "FocusPanel")
			LeaPlusLC:MakeTx(FocusPanel, "Scale", 16, -72)
			LeaPlusLC:MakeSL(FocusPanel, "FocusScale", "Drag to set the focus frame scale.", 0.5, 2, 0.05, 16, -92, "%.2f")

			-- Hide panel during combat
			FocusPanel:SetScript("OnUpdate", function()
				if UnitAffectingCombat("player") then
					FocusFrame:StopMovingOrSizing()
					FocusPanel:Hide()
				end
			end)

			-- Set scale when slider is changed
			LeaPlusCB["FocusScale"]:HookScript("OnValueChanged", function()
				FocusFrame:SetScale(LeaPlusLC["FocusScale"])
				dragframe:SetScale(LeaPlusLC["FocusScale"])
				-- Show formatted slider value
				LeaPlusCB["FocusScale"].f:SetFormattedText("%.0f%%", LeaPlusLC["FocusScale"] * 100)
			end)

			-- Hide frame alignment grid with panel
			FocusPanel:HookScript("OnHide", function()
				LeaPlusLC.grid:Hide()
			end)

			-- Toggle grid button
			local WidgetToggleGridButton = LeaPlusLC:CreateButton("FocusToggleGridButton", FocusPanel, "Toggle Grid", "TOPLEFT", 16, -72, 0, 25, true, "Click to toggle the frame alignment grid.")
			LeaPlusCB["FocusToggleGridButton"]:ClearAllPoints()
			LeaPlusCB["FocusToggleGridButton"]:SetPoint("LEFT", FocusPanel.h, "RIGHT", 10, 0)
			LeaPlusCB["FocusToggleGridButton"]:SetScript("OnClick", function()
				if LeaPlusLC.grid:IsShown() then LeaPlusLC.grid:Hide() else LeaPlusLC.grid:Show() end
			end)
			FocusPanel:HookScript("OnHide", function()
				if LeaPlusLC.grid then LeaPlusLC.grid:Hide() end
			end)

			-- Help button tooltip
			FocusPanel.h.tiptext = L["Drag the frame overlay with the left button to position it freely or with the right button to position it using snap-to-grid.|n|nThis panel will close automatically if you enter combat."]

			-- Back button handler
			FocusPanel.b:SetScript("OnClick", function()
				FocusPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page6"]:Show()
				return
			end)

			-- Reset button handler
			FocusPanel.r:SetScript("OnClick", function()

				-- Reset position and scale
				LeaPlusLC["FocusA"] = "CENTER"
				LeaPlusLC["FocusR"] = "CENTER"
				LeaPlusLC["FocusX"] = 0
				LeaPlusLC["FocusY"] = 0
				LeaPlusLC["FocusScale"] = 1
				FocusFrame:ClearAllPoints()
				FocusFrame:SetPoint(LeaPlusLC["FocusA"], UIParent, LeaPlusLC["FocusR"], LeaPlusLC["FocusX"], LeaPlusLC["FocusY"])

				-- Refresh configuration panel
				FocusPanel:Hide(); FocusPanel:Show()
				dragframe:Show()

				-- Show frame alignment grid
				LeaPlusLC.grid:Show()

			end)

			-- Show configuration panel when options panel button is clicked
			LeaPlusCB["ManageFocusButton"]:SetScript("OnClick", function()
				if LeaPlusLC:PlayerInCombat() then
					return
				else
					if IsShiftKeyDown() and IsControlKeyDown() then
						-- Preset profile
						LeaPlusLC["FocusA"] = "TOPLEFT"
						LeaPlusLC["FocusR"] = "TOPLEFT"
						LeaPlusLC["FocusX"] = 250
						LeaPlusLC["FocusY"] = -240
						LeaPlusLC["FocusScale"] = 1.00
						FocusFrame:ClearAllPoints()
						FocusFrame:SetPoint(LeaPlusLC["FocusA"], UIParent, LeaPlusLC["FocusR"], LeaPlusLC["FocusX"], LeaPlusLC["FocusY"])
						FocusFrame:SetScale(LeaPlusLC["FocusScale"])
					else
						-- Find out if the UI has a non-standard scale
						if GetCVar("useuiscale") == "1" then
							LeaPlusLC["gscale"] = GetCVar("uiscale")
						else
							LeaPlusLC["gscale"] = 1
						end

						-- Set drag frame size and position according to UI scale
						dragframe:SetWidth(196 * LeaPlusLC["gscale"])
						dragframe:SetHeight(76 * LeaPlusLC["gscale"])
						dragframe:ClearAllPoints()
						dragframe:SetPoint("CENTER", FocusFrame, "CENTER", -18 * LeaPlusLC["gscale"], 6 * LeaPlusLC["gscale"])

						-- Show configuration panel
						FocusPanel:Show()
						LeaPlusLC:HideFrames()
						dragframe:Show()

						-- Show frame alignment grid
						LeaPlusLC.grid:Show()
					end
				end
			end)

			-- Hide drag frame when configuration panel is closed
			FocusPanel:HookScript("OnHide", function() dragframe:Hide() end)

		end

		----------------------------------------------------------------------
		-- Hide chat buttons
		----------------------------------------------------------------------

		if LeaPlusLC["NoChatButtons"] == "On" and not LeaLockList["NoChatButtons"] then

			-- Create hidden frame to store unwanted frames (more efficient than creating functions)
			local tframe = CreateFrame("FRAME")
			tframe:Hide()

			-- Function to enable mouse scrolling with CTRL and SHIFT key modifiers
			local function AddMouseScroll(chtfrm)
				if _G[chtfrm] then
					_G[chtfrm]:SetScript("OnMouseWheel", function(self, direction)
						if direction == 1 then
							if IsControlKeyDown() then
								self:ScrollToTop()
							elseif IsShiftKeyDown() then
								self:PageUp()
							else
								self:ScrollUp()
							end
						else
							if IsControlKeyDown() then
								self:ScrollToBottom()
							elseif IsShiftKeyDown() then
								self:PageDown()
							else
								self:ScrollDown()
							end
						end
					end)
					_G[chtfrm]:EnableMouseWheel(true)
				end
			end

			-- Function to hide chat buttons
			local function HideButtons(chtfrm)
				_G[chtfrm .. "ButtonFrameUpButton"]:SetParent(tframe)
				_G[chtfrm .. "ButtonFrameDownButton"]:SetParent(tframe)
				_G[chtfrm .. "ButtonFrameUpButton"]:Hide()
				_G[chtfrm .. "ButtonFrameDownButton"]:Hide()
				_G[chtfrm .. "ButtonFrame"]:SetSize(0.1,0.1)
				_G[chtfrm .. "MinimizeButton"]:SetParent(tframe)
			end

			FriendsMicroButton:Hide()

			-- Function to highlight chat tabs and click to scroll to bottom
			local function HighlightTabs(chtfrm)

				-- Hide bottom button
				_G[chtfrm .. "ButtonFrameBottomButton"]:SetSize(0.1, 0.1) -- Positions it away

				-- Remove click from the bottom button
				_G[chtfrm .. "ButtonFrameBottomButton"]:SetScript("OnClick", nil)

				-- Remove textures
				_G[chtfrm .. "ButtonFrameBottomButton"]:SetNormalTexture("")
				_G[chtfrm .. "ButtonFrameBottomButton"]:SetHighlightTexture("")
				_G[chtfrm .. "ButtonFrameBottomButton"]:SetPushedTexture("")
				_G[chtfrm .. "ButtonFrameBottomButton"]:SetDisabledTexture("")

				-- Resize bottom button according to tab size
				_G[chtfrm .. "Tab"]:SetScript("OnSizeChanged", function()
					for j = 1, 50 do
						-- Resize bottom button to tab width
						if _G["ChatFrame" .. j .. "ButtonFrameBottomButton"] then
							_G["ChatFrame" .. j .. "ButtonFrameBottomButton"]:SetWidth(_G["ChatFrame" .. j .. "Tab"]:GetWidth()-10)
						end
					end
					-- If combat log is hidden, resize it's bottom button
					if LeaPlusLC["NoCombatLogTab"] == "On" and not LeaLockList["NoCombatLogTab"] then
						if _G["ChatFrame2ButtonFrameBottomButton"] then
							-- Resize combat log bottom button
							_G["ChatFrame2ButtonFrameBottomButton"]:SetWidth(0.1);
						end
					end
				end)

				-- Remove click from the bottom button
				_G[chtfrm .. "ButtonFrameBottomButton"]:SetScript("OnClick", nil)

				-- Remove textures
				_G[chtfrm .. "ButtonFrameBottomButton"]:SetNormalTexture("")
				_G[chtfrm .. "ButtonFrameBottomButton"]:SetHighlightTexture("")
				_G[chtfrm .. "ButtonFrameBottomButton"]:SetPushedTexture("")

				-- Always scroll to bottom when clicking a tab
				_G[chtfrm .. "Tab"]:HookScript("OnClick", function(self,arg1)
					if arg1 == "LeftButton" then
						_G[chtfrm]:ScrollToBottom();
					end
				end)

				-- Create new bottom button under tab
				_G[chtfrm .. "Tab"].newglow = _G[chtfrm .. "Tab"]:CreateTexture(nil, "BACKGROUND")
				_G[chtfrm .. "Tab"].newglow:ClearAllPoints()
				_G[chtfrm .. "Tab"].newglow:SetPoint("BOTTOMLEFT", _G[chtfrm .. "Tab"], "BOTTOMLEFT", 0, 0)
				_G[chtfrm .. "Tab"].newglow:SetTexture("Interface\\ChatFrame\\ChatFrameTab-NewMessage")
				_G[chtfrm .. "Tab"].newglow:SetWidth(_G[chtfrm .. "Tab"]:GetWidth())
				_G[chtfrm .. "Tab"].newglow:SetVertexColor(0.6, 0.6, 1, 0.7)
				_G[chtfrm .. "Tab"].newglow:SetBlendMode("ADD")
				_G[chtfrm .. "Tab"].newglow:Hide()

				-- Show new bottom button when old one glows
				_G[chtfrm .. "ButtonFrameBottomButtonFlash"]:HookScript("OnShow", function(self,arg1)
					_G[chtfrm .. "Tab"].newglow:Show()
				end)

				_G[chtfrm .. "ButtonFrameBottomButtonFlash"]:HookScript("OnHide", function(self,arg1)
					_G[chtfrm .. "Tab"].newglow:Hide()
				end)

				-- Match new bottom button size to tab
				_G[chtfrm .. "Tab"]:HookScript("OnSizeChanged", function()
					_G[chtfrm .. "Tab"].newglow:SetWidth(_G[chtfrm .. "Tab"]:GetWidth())
				end)

			end

			-- Hide chat menu buttons
			ChatFrameMenuButton:SetParent(tframe)
			ChatFrameChannelButton:SetParent(tframe)

			-- Set options for normal and existing chat frames
			for i = 1, 50 do
				if _G["ChatFrame" .. i] then
					AddMouseScroll("ChatFrame" .. i);
					HideButtons("ChatFrame" .. i);
					HighlightTabs("ChatFrame" .. i)
				end
			end

			-- Do the functions above for temporary chat frames
			hooksecurefunc("FCF_OpenTemporaryWindow", function(chatType)
				local cf = FCF_GetCurrentChatFrame():GetName() or nil
				if cf then
					-- Set options for temporary frame
					AddMouseScroll(cf)
					HideButtons(cf)
					HighlightTabs(cf)
					-- Resize flashing alert to match tab width
					_G[cf .. "Tab"]:SetScript("OnSizeChanged", function()
						_G[cf .. "ButtonFrameBottomButton"]:SetWidth(_G[cf .. "Tab"]:GetWidth()-10)
					end)
				end
			end)

			-- Hide text to speech button
			TextToSpeechButton:SetParent(tframe)

		end

		----------------------------------------------------------------------
		-- Recent chat window
		----------------------------------------------------------------------

		if LeaPlusLC["RecentChatWindow"] == "On" and not LeaLockList["RecentChatWindow"] then

			-- Create recent chat frame
			local editFrame = CreateFrame("ScrollFrame", nil, UIParent, "LeaPlusRecentChatScrollFrameTemplate")

			-- Set frame parameters
			editFrame:ClearAllPoints()
			editFrame:SetPoint("BOTTOM", 0, 130)
			editFrame:SetSize(600, LeaPlusLC["RecentChatSize"])
			editFrame:SetFrameStrata("MEDIUM")
			editFrame:SetToplevel(true)
			editFrame:Hide()

			-- Add background color
			editFrame.t = editFrame:CreateTexture(nil, "BACKGROUND")
			editFrame.t:SetAllPoints()
			editFrame.t:SetColorTexture(0.00, 0.00, 0.0, 0.6)

			-- Create title bar
			local titleFrame = CreateFrame("Frame", nil, editFrame)
			titleFrame:ClearAllPoints()
			titleFrame:SetPoint("TOP", 0, 24)
			titleFrame:SetSize(600, 24)
			titleFrame:SetFrameStrata("MEDIUM")
			titleFrame:SetToplevel(true)
			titleFrame:SetHitRectInsets(-6, -6, -6, -6)
			titleFrame.t = titleFrame:CreateTexture(nil, "BACKGROUND")
			titleFrame.t:SetAllPoints()
			titleFrame.t:SetColorTexture(0.00, 0.00, 0.0, 0.8)

			-- Add message count
			titleFrame.m = titleFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			titleFrame.m:SetPoint("LEFT", 4, 0)
			titleFrame.m:SetText(L["Messages"] .. ": 0")
			titleFrame.m:SetFont(titleFrame.m:GetFont(), 16, nil)

			-- Add right-click to close message
			titleFrame.x = titleFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			titleFrame.x:SetPoint("RIGHT", -4, 0)
			titleFrame.x:SetText(L["Drag to size"] .. " | " .. L["Right-click to close"])
			titleFrame.x:SetFont(titleFrame.x:GetFont(), 16, nil)
			titleFrame.x:SetWidth(600 - titleFrame.m:GetStringWidth() - 30)
			titleFrame.x:SetWordWrap(false)
			titleFrame.x:SetJustifyH("RIGHT")

			-- Drag to resize
			editFrame:SetResizable(true)
			editFrame:SetResizeBounds(600, 170, 600, 560)

			titleFrame:HookScript("OnMouseDown", function(self, btn)
				if btn == "LeftButton" then
					editFrame:StartSizing("TOP")
				end
			end)
			titleFrame:HookScript("OnMouseUp", function(self, btn)
				if btn == "LeftButton" then
					editFrame:StopMovingOrSizing()
					LeaPlusLC["RecentChatSize"] = editFrame:GetHeight()
				elseif btn == "MiddleButton" then
					-- Reset frame size
					LeaPlusLC["RecentChatSize"] = 170
					editFrame:SetSize(600, LeaPlusLC["RecentChatSize"])
					editFrame:ClearAllPoints()
					editFrame:SetPoint("BOTTOM", 0, 130)
				end
			end)

			-- Create character count
			editFrame.CharCount = editFrame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			editFrame.CharCount:Hide()

			-- Create editbox
			local editBox = editFrame.EditBox
			editBox:SetAltArrowKeyMode(false)
			editBox:SetTextInsets(4, 4, 4, 4)
			editBox:SetWidth(editFrame:GetWidth() - 30)
			editBox:SetSecurityDisablePaste()
			editBox:SetMaxLetters(0)

			editFrame:SetScrollChild(editBox)

			-- Manage focus
			editBox:HookScript("OnEditFocusLost", function()
				if MouseIsOver(titleFrame) and IsMouseButtonDown("LeftButton") then
					editBox:SetFocus()
				end
			end)

			-- Close frame with right-click of editframe or editbox
			local function CloseRecentChatWindow()
				editBox:SetText("")
				editBox:ClearFocus()
				editFrame:Hide()
			end

			editFrame:SetScript("OnMouseDown", function(self, btn)
				if btn == "RightButton" then CloseRecentChatWindow() end
			end)

			editBox:SetScript("OnMouseDown", function(self, btn)
				if btn == "RightButton" then CloseRecentChatWindow() end
			end)

			titleFrame:HookScript("OnMouseDown", function(self, btn)
				if btn == "RightButton" then CloseRecentChatWindow() end
			end)

			-- Disable text changes while still allowing editing controls to work
			editBox:EnableKeyboard(false)
			editBox:SetScript("OnKeyDown", function() end)

			-- Populate recent chat frame with chat messages
			local function ShowChatbox(chtfrm)
				editBox:SetText("")
				local NumMsg = chtfrm:GetNumMessages()
				local StartMsg = 1
				if NumMsg > 256 then StartMsg = NumMsg - 255 end
				local totalMsgCount = 0
				for iMsg = StartMsg, NumMsg do
					local chatMessage, r, g, b, chatTypeID = chtfrm:GetMessageInfo(iMsg)
					if chatMessage then

						-- Handle Battle.net messages
						if string.match(chatMessage, "k:(%d+):(%d+):BN_WHISPER:")
						or string.match(chatMessage, "k:(%d+):(%d+):BN_INLINE_TOAST_ALERT:")
						or string.match(chatMessage, "k:(%d+):(%d+):BN_INLINE_TOAST_BROADCAST:")
						then
							local ctype
							if string.match(chatMessage, "k:(%d+):(%d+):BN_WHISPER:") then
								ctype = "BN_WHISPER"
							elseif string.match(chatMessage, "k:(%d+):(%d+):BN_INLINE_TOAST_ALERT:") then
								ctype = "BN_INLINE_TOAST_ALERT"
							elseif string.match(chatMessage, "k:(%d+):(%d+):BN_INLINE_TOAST_BROADCAST:") then
								ctype = "BN_INLINE_TOAST_BROADCAST"
							end
							local id = tonumber(string.match(chatMessage, "k:(%d+):%d+:" .. ctype .. ":"))
							local totalBNFriends = BNGetNumFriends()
							for friendIndex = 1, totalBNFriends do
								local bnetAccountID, void, battleTag = BNGetFriendInfo(friendIndex)
								if id == bnetAccountID then
									battleTag = strsplit("#", battleTag)
									chatMessage = chatMessage:gsub("(|HBNplayer%S-|k)(%d-)(:%S-" .. ctype .. "%S-|h)%[(%S-)%](|?h?)(:?)", "[" .. battleTag .. "]:")
								end
							end
						end

						-- Handle colors
						if r and g and b then
							local colorCode = RGBToColorCode(r, g, b)
							chatMessage = colorCode .. chatMessage
						end

						chatMessage = gsub(chatMessage, "|T.-|t", "") -- Remove textures
						chatMessage = gsub(chatMessage, "|A.-|a", "") -- Remove atlases
						editBox:Insert(chatMessage .. "|r|n")

					end
					totalMsgCount = totalMsgCount + 1
				end
				titleFrame.m:SetText(L["Messages"] .. ": " .. totalMsgCount)
				editFrame:SetVerticalScroll(0)
				editFrame.ScrollBar:ScrollToEnd()
				editFrame:Show()
				editBox:ClearFocus()
			end

			-- Hook normal chat frame tab clicks
			for i = 1, 50 do
				if _G["ChatFrame" .. i] then
					_G["ChatFrame" .. i .. "Tab"]:HookScript("OnClick", function()
						if IsControlKeyDown() then
							editBox:SetFont(_G["ChatFrame" .. i]:GetFont())
							editFrame:SetPanExtent(select(2, _G["ChatFrame" .. i]:GetFont()))
							ShowChatbox(_G["ChatFrame" .. i])
						end
					end)
				end
			end

			-- Hook temporary chat frame tab clicks
			hooksecurefunc("FCF_OpenTemporaryWindow", function()
				local cf = FCF_GetCurrentChatFrame():GetName() or nil
				if cf then
					_G[cf .. "Tab"]:HookScript("OnClick", function()
						if IsControlKeyDown() then
							editBox:SetFont(_G[cf]:GetFont())
							editFrame:SetPanExtent(select(2, _G[cf]:GetFont()))
							ShowChatbox(_G[cf])
						end
					end)
				end
			end)

			-- Add entry to chat menu to show recent chat window
			Menu.ModifyMenu("MENU_FCF_TAB", function(self, rootDescription, contextData)
				rootDescription:CreateDivider()
				rootDescription:CreateTitle(L["Leatrix Plus"])
				local recentChatButton = rootDescription:CreateButton(L["Recent chat window"], function()
					local currentChatFrame = FCF_GetCurrentChatFrame()
					editBox:SetFont(currentChatFrame:GetFont())
					editFrame:SetPanExtent(select(2, currentChatFrame:GetFont()))
					ShowChatbox(currentChatFrame)
				end)
			end)

		end

		----------------------------------------------------------------------
		-- Show cooldowns
		----------------------------------------------------------------------

		if LeaPlusLC["ShowCooldowns"] == "On" and not LeaLockList["ShowCooldowns"] then

			-- Create main table structure in saved variables if it doesn't exist
			if LeaPlusDB["Cooldowns"] == nil then
				LeaPlusDB["Cooldowns"] = {}
			end

			-- Create class tables if they don't exist
			for index = 1, GetNumClasses() do
				local classDisplayName, classTag, classID = GetClassInfo(index)
				if LeaPlusDB["Cooldowns"][classTag] == nil then
					LeaPlusDB["Cooldowns"][classTag] = {}
				end
			end

			-- Get current class and spec
			local PlayerClass = select(2, UnitClass("player"))
			local activeSpec = C_SpecializationInfo.GetSpecialization() or 5 -- 5 is no specialisation

			-- Create local tables to store cooldown frames and editboxes
			local icon = {} -- Used to store cooldown frames
			local SpellEB = {} -- Used to store editbox values
			local iCount = 5 -- Number of cooldowns

			-- Create cooldown frames
			for i = 1, iCount do

				-- Create cooldown frame
				icon[i] = CreateFrame("Frame", nil, UIParent)
				icon[i]:SetFrameStrata("BACKGROUND")
				icon[i]:SetWidth(20)
				icon[i]:SetHeight(20)

				-- Create cooldown icon
				icon[i].c = CreateFrame("Cooldown", nil, icon[i], "CooldownFrameTemplate")
				icon[i].c:SetAllPoints()
				icon[i].c:SetReverse(true)

				-- Create blank texture (will be assigned a cooldown texture later)
				icon[i].t = icon[i]:CreateTexture(nil,"BACKGROUND")
				icon[i].t:SetAllPoints()

				-- Show icon above target frame and set initial scale
				icon[i]:ClearAllPoints()
				icon[i]:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 6 + (22 * (i - 1)), 5)
				icon[i]:SetScale(TargetFrame:GetScale())

				-- Show tooltip
				icon[i]:SetScript("OnEnter", function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 15, -25)
					GameTooltip:SetText(GetSpellInfo(LeaPlusCB["Spell" .. i]:GetText()))
				end)

				-- Hide tooltip
				icon[i]:SetScript("OnLeave", GameTooltip_Hide)

			end

			-- Change cooldown icon scale when player frame scale changes
			PlayerFrame:HookScript("OnSizeChanged", function()
				if LeaPlusLC["CooldownsOnPlayer"] == "On" then
					for i = 1, iCount do
						icon[i]:SetScale(PlayerFrame:GetScale())
					end
				end
			end)

			-- Change cooldown icon scale when target frame scale changes
			TargetFrame:HookScript("OnSizeChanged", function()
				if LeaPlusLC["CooldownsOnPlayer"] == "Off" then
					for i = 1, iCount do
						icon[i]:SetScale(TargetFrame:GetScale())
					end
				end
			end)

			-- Function to show cooldown textures in the cooldown frames (run when icons are loaded or changed)
			local function ShowIcon(i, id, owner)

				local void

				-- Get spell information
				local spell, void, path = GetSpellInfo(id)
				if spell and path then

					-- Set icon texture to the spell texture
					icon[i].t:SetTexture(path)

					-- Set top level and raise frame strata (ensures tooltips show properly)
					icon[i]:SetToplevel(true)
					icon[i]:SetFrameStrata("LOW")

					-- Handle events
					icon[i]:RegisterUnitEvent("UNIT_AURA", owner)
					icon[i]:RegisterUnitEvent("UNIT_PET", "player")
					icon[i]:SetScript("OnEvent", function(self, event, arg1)

						-- If pet was dismissed (or otherwise disappears such as when flying), hide pet cooldowns
						if event == "UNIT_PET" then
							if not UnitExists("pet") then
								if LeaPlusDB["Cooldowns"][PlayerClass]["S" .. activeSpec .. "R" .. i .. "Pet"] then
									icon[i]:Hide()
								end
							end

						-- Ensure cooldown belongs to the owner we are watching (player or pet)
						elseif arg1 == owner then

							-- Hide the cooldown frame (required for cooldowns to disappear after the duration)
							icon[i]:Hide()

							-- If buff matches cooldown we want, start the cooldown
							for q = 1, 40 do
								local void, void, void, void, length, expire, void, void, void, spellID = UnitBuff(owner, q)
								if spellID and id == spellID then
									icon[i]:Show()
									local start = expire - length
									CooldownFrame_Set(icon[i].c, start, length, 1)
								end
							end

						end
					end)

				else

					-- Spell does not exist so stop watching it
					icon[i]:SetScript("OnEvent", nil)
					icon[i]:Hide()

				end

			end

			-- Create configuration panel
			local CooldownPanel = LeaPlusLC:CreatePanel("Show cooldowns", "CooldownPanel")

			-- Function to refresh the editbox tooltip with the spell name
			local function RefSpellTip(self,elapsed)
				local spellinfo, void, icon = GetSpellInfo(self:GetText())
				if spellinfo and spellinfo ~= "" and icon and icon ~= "" then
					GameTooltip:SetOwner(self, "ANCHOR_NONE")
					GameTooltip:ClearAllPoints()
					GameTooltip:SetPoint("RIGHT", self, "LEFT", -10, 0)
					GameTooltip:SetText("|T" .. icon .. ":0|t " .. spellinfo, nil, nil, nil, nil, true)
				else
					GameTooltip:Hide()
				end
			end

			-- Function to create spell ID editboxes and pet checkboxes
			local function MakeSpellEB(num, x, y, tab, shifttab)

				-- Create editbox for spell ID
				SpellEB[num] = LeaPlusLC:CreateEditBox("Spell" .. num, CooldownPanel, 70, 6, "TOPLEFT", x, y - 20, "Spell" .. tab, "Spell" .. shifttab)
				SpellEB[num]:SetNumeric(true)

				-- Set initial value (for current spec)
				SpellEB[num]:SetText(LeaPlusDB["Cooldowns"][PlayerClass]["S" .. activeSpec .. "R" .. num .. "Idn"] or "")

				-- Refresh tooltip when mouse is hovering over the editbox
				SpellEB[num]:SetScript("OnEnter", function()
					SpellEB[num]:SetScript("OnUpdate", RefSpellTip)
				end)
				SpellEB[num]:SetScript("OnLeave", function()
					SpellEB[num]:SetScript("OnUpdate", nil)
					GameTooltip:Hide()
				end)

				-- Create checkbox for pet cooldown
				LeaPlusLC:MakeCB(CooldownPanel, "Spell" .. num .."Pet", "", 462, y - 20, false, "")
				LeaPlusCB["Spell" .. num .."Pet"]:SetHitRectInsets(0, 0, 0, 0)

			end

			-- Add titles
			LeaPlusLC:MakeTx(CooldownPanel, "Spell ID", 384, -92)
			LeaPlusLC:MakeTx(CooldownPanel, "Pet", 462, -92)

			-- Add editboxes and checkboxes
			MakeSpellEB(1, 386, -92, "2", "5")
			MakeSpellEB(2, 386, -122, "3", "1")
			MakeSpellEB(3, 386, -152, "4", "2")
			MakeSpellEB(4, 386, -182, "5", "3")
			MakeSpellEB(5, 386, -212, "1", "4")

			-- Add checkboxes
			LeaPlusLC:MakeTx(CooldownPanel, "Settings", 16, -72)
			LeaPlusLC:MakeCB(CooldownPanel, "ShowCooldownID", "Show the spell ID in buff icon tooltips", 16, -92, false, "If checked, spell IDs will be shown in buff icon tooltips located in the buff frame and under the target frame.");
			LeaPlusLC:MakeCB(CooldownPanel, "NoCooldownDuration", "Hide cooldown duration numbers (if enabled)", 16, -112, false, "If checked, cooldown duration numbers will not be shown over the cooldowns.|n|nIf unchecked, cooldown duration numbers will be shown over the cooldowns if they are enabled in the game options panel ('ActionBars' menu).")
			LeaPlusLC:MakeCB(CooldownPanel, "CooldownsOnPlayer", "Show cooldowns above the player frame", 16, -132, false, "If checked, cooldown icons will be shown above the player frame instead of the target frame.|n|nIf unchecked, cooldown icons will be shown above the target frame.")

			-- Function to save the panel control settings and refresh the cooldown icons
			local function SavePanelControls()
				for i = 1, iCount do

					-- Refresh the cooldown texture
					icon[i].c:SetCooldown(0,0)

					-- Show icons above target or player frame
					icon[i]:ClearAllPoints()
					if LeaPlusLC["CooldownsOnPlayer"] == "On" then
						icon[i]:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 116 + (22 * (i - 1)), 5)
						icon[i]:SetScale(PlayerFrame:GetScale())
					else
						icon[i]:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 6 + (22 * (i - 1)), 5)
						icon[i]:SetScale(TargetFrame:GetScale())
					end

					-- Save control states to globals
					LeaPlusDB["Cooldowns"][PlayerClass]["S" .. activeSpec .. "R" .. i .. "Idn"] = SpellEB[i]:GetText()
					LeaPlusDB["Cooldowns"][PlayerClass]["S" .. activeSpec .. "R" .. i .. "Pet"] = LeaPlusCB["Spell" .. i .."Pet"]:GetChecked()

					-- Set cooldowns
					if LeaPlusCB["Spell" .. i .."Pet"]:GetChecked() then
						ShowIcon(i, tonumber(SpellEB[i]:GetText()), "pet")
					else
						ShowIcon(i, tonumber(SpellEB[i]:GetText()), "player")
					end

					-- Show or hide cooldown duration
					if LeaPlusLC["NoCooldownDuration"] == "On" then
						icon[i].c:SetHideCountdownNumbers(true)
					else
						icon[i].c:SetHideCountdownNumbers(false)
					end

					-- Show or hide cooldown icons depending on current buffs
					local newowner
					local newspell = tonumber(SpellEB[i]:GetText())

					if newspell then
						if LeaPlusDB["Cooldowns"][PlayerClass]["S" .. activeSpec .. "R" .. i .. "Pet"] then
							newowner = "pet"
						else
							newowner = "player"
						end
						-- Hide cooldown icon
						icon[i]:Hide()

						-- If buff matches spell we want, show cooldown icon
						for q = 1, 40 do
							local void, void, void, void, length, expire, void, void, void, spellID = UnitBuff(newowner, q)
							if spellID and newspell == spellID then
								icon[i]:Show()
								-- Set the cooldown to the buff cooldown
								CooldownFrame_Set(icon[i].c, expire - length, length, 1)
							end
						end
					end

				end

			end

			-- Update cooldown icons when checkboxes are clicked
			LeaPlusCB["NoCooldownDuration"]:HookScript("OnClick", SavePanelControls)
			LeaPlusCB["CooldownsOnPlayer"]:HookScript("OnClick", SavePanelControls)

			-- Help button hidden
			CooldownPanel.h:Hide()

			-- Back button handler
			CooldownPanel.b:SetScript("OnClick", function()
				CooldownPanel:Hide(); LeaPlusLC["PageF"]:Show(); LeaPlusLC["Page5"]:Show()
				return
			end)

			-- Reset button handler
			CooldownPanel.r:SetScript("OnClick", function()
				-- Reset the checkboxes
				LeaPlusLC["ShowCooldownID"] = "On"
				LeaPlusLC["NoCooldownDuration"] = "On"
				LeaPlusLC["CooldownsOnPlayer"] = "Off"
				for i = 1, iCount do
					-- Reset the panel controls
					SpellEB[i]:SetText("");
					LeaPlusDB["Cooldowns"][PlayerClass]["S" .. activeSpec .. "R" .. i .. "Pet"] = false
					-- Hide cooldowns and clear scripts
					icon[i]:Hide()
					icon[i]:SetScript("OnEvent", nil)
				end
				CooldownPanel:Hide(); CooldownPanel:Show()
			end)

			-- Save settings when changed
			for i = 1, iCount do
				-- Set initial checkbox states
				LeaPlusCB["Spell" .. i .."Pet"]:SetChecked(LeaPlusDB["Cooldowns"][PlayerClass]["S" .. activeSpec .. "R" .. i .. "Pet"])
				-- Set checkbox states when shown
				LeaPlusCB["Spell" .. i .."Pet"]:SetScript("OnShow", function()
					LeaPlusCB["Spell" .. i .."Pet"]:SetChecked(LeaPlusDB["Cooldowns"][PlayerClass]["S" .. activeSpec .. "R" .. i .. "Pet"])
				end)
				-- Set states when changed
				SpellEB[i]:SetScript("OnTextChanged", SavePanelControls)
				LeaPlusCB["Spell" .. i .."Pet"]:SetScript("OnClick", SavePanelControls)
			end

			-- Show cooldowns on startup
			SavePanelControls()

			-- Show panel when configuration button is clicked
			LeaPlusCB["CooldownsButton"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- No preset profile
				else
					-- Show panel
					CooldownPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

			-- Create spec tag banner fontstring
			local specTagSpecID = C_SpecializationInfo.GetSpecialization() or 5 -- 5 is no specialisation
			local specTagBanner = CooldownPanel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
			specTagBanner:SetPoint("TOPLEFT", 384, -72)

			local void, specTagText = C_SpecializationInfo.GetSpecializationInfo(specTagSpecID)
			if not specTagText or specTagText == "" then specTagText = L["None"] end -- No specialisation
			specTagBanner:SetText(specTagText)

			-- Add help button
			LeaPlusLC:CreateHelpButton("ShowCooldownsHelpButton", CooldownPanel, specTagBanner, "Enter the spell IDs for the cooldown icons that you want to see.|n|nIf a cooldown icon normally appears under the pet frame, check the pet checkbox.|n|nCooldown icons are saved to your class and specialisation.")

			-- Set controls when spec changes
			local swapFrame = CreateFrame("FRAME")
			swapFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
			swapFrame:SetScript("OnEvent", function()
				-- Store new spec
				activeSpec = C_SpecializationInfo.GetSpecialization() or 5 -- 5 is no specialisation
				-- Update controls for new spec
				for i = 1, iCount do
					SpellEB[i]:SetText(LeaPlusDB["Cooldowns"][PlayerClass]["S" .. activeSpec .. "R" .. i .. "Idn"] or "")
					LeaPlusCB["Spell" .. i .. "Pet"]:SetChecked(LeaPlusDB["Cooldowns"][PlayerClass]["S" .. activeSpec .. "R" .. i .. "Pet"] or false)
				end
				-- Update spec tag banner with new spec
				local void, specTagText = C_SpecializationInfo.GetSpecializationInfo(activeSpec)
				if not specTagText or specTagText == "" then specTagText = L["None"] end -- No specialisation
				specTagBanner:SetText(specTagText)
				-- Refresh configuration panel
				if CooldownPanel:IsShown() then
					CooldownPanel:Hide(); CooldownPanel:Show()
				end
				-- Save settings
				SavePanelControls()
			end)

			-- Function to show spell ID in tooltips
			local function CooldownIDFunc(unit, target, index, auratype)
				if LeaPlusLC["ShowCooldownID"] == "On" and auratype ~= "HARMFUL" then
					local AuraData = C_UnitAuras.GetAuraDataByIndex(target, index)
					if AuraData then
						local spellid = AuraData.spellId
						if spellid then
							GameTooltip:AddLine(L["Spell ID"] .. ": " .. spellid)
							GameTooltip:Show()
						end
					end
				end
			end

			-- Add spell ID to tooltip when buff frame buffs are hovered
			hooksecurefunc(GameTooltip, 'SetUnitAura', CooldownIDFunc)

			-- Add spell ID to tooltip when target frame buffs are hovered
			hooksecurefunc(GameTooltip, 'SetUnitBuff', CooldownIDFunc)

		end

		----------------------------------------------------------------------
		-- Combat plates
		----------------------------------------------------------------------

		if LeaPlusLC["CombatPlates"] == "On" then

			-- Toggle nameplates with combat
			local f = CreateFrame("Frame")
			f:RegisterEvent("PLAYER_REGEN_DISABLED")
			f:RegisterEvent("PLAYER_REGEN_ENABLED")
			f:SetScript("OnEvent", function(self, event)
				SetCVar("nameplateShowEnemies", event == "PLAYER_REGEN_DISABLED" and 1 or 0)
			end)

			-- Run combat check on startup
			SetCVar("nameplateShowEnemies", UnitAffectingCombat("player") and 1 or 0)

		end

		----------------------------------------------------------------------
		-- Enhance tooltip
		----------------------------------------------------------------------

		if LeaPlusLC["TipModEnable"] == "On" and not LeaLockList["TipModEnable"] then

			-- Enable mouse hover events for world frame (required for hide tooltips, cursor anchor and maybe other addons)
			WorldFrame:EnableMouseMotion(true)

			----------------------------------------------------------------------
			--	Position the tooltip
			----------------------------------------------------------------------

			hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
				if LeaPlusLC["TooltipAnchorMenu"] ~= 1 then
					if (not tooltip or not parent) then
						return
					end
					if LeaPlusLC["TooltipAnchorMenu"] == 2 or not WorldFrame:IsMouseMotionFocus() then
						local a,b,c,d,e = tooltip:GetPoint()
						if a ~= "BOTTOMRIGHT" or c ~= "BOTTOMRIGHT" then
							tooltip:ClearAllPoints()
						end
						tooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", LeaPlusLC["TipOffsetX"], LeaPlusLC["TipOffsetY"]);
						return
					else
						if LeaPlusLC["TooltipAnchorMenu"] == 3 then
							tooltip:SetOwner(parent, "ANCHOR_CURSOR")
							return
						elseif LeaPlusLC["TooltipAnchorMenu"] == 4 then
							tooltip:SetOwner(parent, "ANCHOR_CURSOR_LEFT", LeaPlusLC["TipCursorX"], LeaPlusLC["TipCursorY"])
							return
						elseif LeaPlusLC["TooltipAnchorMenu"] == 5 then
							tooltip:SetOwner(parent, "ANCHOR_CURSOR_RIGHT", LeaPlusLC["TipCursorX"], LeaPlusLC["TipCursorY"])
							return
						end
					end
				end
			end)

			----------------------------------------------------------------------
			--	Tooltip Configuration
			----------------------------------------------------------------------

			local LT = {}

			-- Create locale specific level string
			LT["LevelLocale"] = strtrim(strtrim(string.gsub(TOOLTIP_UNIT_LEVEL, "%%s", "")))
			if GameLocale == "ruRU" then
				LT["LevelLocale"] = "-ro уровня"
			end

			-- Tooltip
			LT["ColorBlind"] = GetCVar("colorblindMode")

			-- 	Create drag frame
			local TipDrag = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
			TipDrag:SetToplevel(true);
			TipDrag:SetClampedToScreen(false);
			TipDrag:SetSize(130, 64);
			TipDrag:Hide();
			TipDrag:SetFrameStrata("TOOLTIP")
			TipDrag:SetMovable(true)
			TipDrag:SetBackdropColor(0.0, 0.5, 1.0);
			TipDrag:SetBackdrop({
				edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
				tile = false, tileSize = 0, edgeSize = 16,
				insets = { left = 0, right = 0, top = 0, bottom = 0 }});

			-- Show text in drag frame
			TipDrag.f = TipDrag:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
			TipDrag.f:SetPoint("CENTER", 0, 0)
			TipDrag.f:SetText(L["Tooltip"])

			-- Create texture
			TipDrag.t = TipDrag:CreateTexture();
			TipDrag.t:SetAllPoints();
			TipDrag.t:SetColorTexture(0.0, 0.5, 1.0, 0.5);
			TipDrag.t:SetAlpha(0.5);

			---------------------------------------------------------------------------------------------------------
			-- Tooltip movement settings
			---------------------------------------------------------------------------------------------------------

			-- Create tooltip customisation side panel
			local SideTip = LeaPlusLC:CreatePanel("Enhance tooltip", "SideTip")

			-- Add controls
			LeaPlusLC:MakeTx(SideTip, "Settings", 16, -72)
			LeaPlusLC:MakeCB(SideTip, "TipShowRank", "Show guild ranks for your guild", 16, -92, false, "If checked, guild ranks will be shown for players in your guild.")
			LeaPlusLC:MakeCB(SideTip, "TipShowOtherRank", "Show guild ranks for other guilds", 16, -112, false, "If checked, guild ranks will be shown for players who are not in your guild.")
			LeaPlusLC:MakeCB(SideTip, "TipShowTarget", "Show unit targets", 16, -132, false, "If checked, unit targets will be shown.")
			LeaPlusLC:MakeCB(SideTip, "TipNoHealthBar", "Hide the health bar", 16, -152, true, "If checked, the health bar will not be shown.")

			LeaPlusLC:MakeTx(SideTip, "Hide tooltips", 16, -192)
			LeaPlusLC:MakeCB(SideTip, "TipHideInCombat", "Hide tooltips for world units during combat", 16, -212, false, "If checked, tooltips for world units will be hidden during combat.")
			LeaPlusLC:MakeCB(SideTip, "TipHideShiftOverride", "Show tooltips with shift key", 16, -232, false, "If checked, you can hold shift while tooltips are hidden to show them temporarily.")

			-- Handle show tooltips with shift key lock
			local function SetTipHideShiftOverrideFunc()
				if LeaPlusLC["TipHideInCombat"] == "On" then
					LeaPlusLC:LockItem(LeaPlusCB["TipHideShiftOverride"], false)
				else
					LeaPlusLC:LockItem(LeaPlusCB["TipHideShiftOverride"], true)
				end
			end

			LeaPlusCB["TipHideInCombat"]:HookScript("OnClick", SetTipHideShiftOverrideFunc)
			SetTipHideShiftOverrideFunc()

			LeaPlusLC:CreateDropdown("TooltipAnchorMenu", "Anchor", 146, "TOPLEFT", SideTip, "TOPLEFT", 356, -92, {{L["None"], 1}, {L["Overlay"], 2}, {L["Cursor"], 3}, {L["Cursor Left"], 4}, {L["Cursor Right"], 5}})

			local XOffsetHeading = LeaPlusLC:MakeTx(SideTip, "X Offset", 356, -132)
			LeaPlusLC:MakeSL(SideTip, "TipCursorX", "Drag to set the cursor X offset.", -128, 128, 1, 356, -152, "%.0f")

			local YOffsetHeading = LeaPlusLC:MakeTx(SideTip, "Y Offset", 356, -182)
			LeaPlusLC:MakeSL(SideTip, "TipCursorY", "Drag to set the cursor Y offset.", -128, 128, 1, 356, -202, "%.0f")

			LeaPlusLC:MakeTx(SideTip, "Scale", 356, -232)
			LeaPlusLC:MakeSL(SideTip, "LeaPlusTipSize", "Drag to set the tooltip scale.", 0.50, 2.00, 0.05, 356, -252, "%.2f")

			-- Function to enable or disable anchor controls
			local function SetAnchorControls()
				-- Hide overlay if anchor is set to none
				if LeaPlusLC["TooltipAnchorMenu"] == 1 then
					TipDrag:Hide()
				else
					TipDrag:Show()
				end
				-- Set the X and Y sliders
				if LeaPlusLC["TooltipAnchorMenu"] == 1 or LeaPlusLC["TooltipAnchorMenu"] == 2 or LeaPlusLC["TooltipAnchorMenu"] == 3 then
					-- Dropdown is set to screen or cursor so disable X and Y offset sliders
					LeaPlusLC:LockItem(LeaPlusCB["TipCursorX"], true)
					LeaPlusLC:LockItem(LeaPlusCB["TipCursorY"], true)
					XOffsetHeading:SetAlpha(0.3)
					YOffsetHeading:SetAlpha(0.3)
					LeaPlusCB["TipCursorX"]:SetScript("OnEnter", nil)
					LeaPlusCB["TipCursorY"]:SetScript("OnEnter", nil)
				else
					-- Dropdown is set to cursor left or cursor right so enable X and Y offset sliders
					LeaPlusLC:LockItem(LeaPlusCB["TipCursorX"], false)
					LeaPlusLC:LockItem(LeaPlusCB["TipCursorY"], false)
					XOffsetHeading:SetAlpha(1.0)
					YOffsetHeading:SetAlpha(1.0)
					LeaPlusCB["TipCursorX"]:SetScript("OnEnter", LeaPlusLC.TipSee)
					LeaPlusCB["TipCursorY"]:SetScript("OnEnter", LeaPlusLC.TipSee)
				end
			end

			-- Set controls when anchor dropdown menu is changed and on startup
			LeaPlusCB["TooltipAnchorMenu"]:RegisterCallback("OnMenuClose", SetAnchorControls)
			SetAnchorControls()

			-- Help button hidden
			SideTip.h:Hide()

			-- Back button handler
			SideTip.b:SetScript("OnClick", function()
				SideTip:Hide();
				if TipDrag:IsShown() then
					TipDrag:Hide();
				end
				LeaPlusLC["PageF"]:Show();
				LeaPlusLC["Page5"]:Show();
				return
			end)

			-- Reset button handler
			SideTip.r.tiptext = SideTip.r.tiptext .. "|n|n" .. L["Note that this will not reset settings that require a UI reload."]
			SideTip.r:SetScript("OnClick", function()
				LeaPlusLC["TipShowRank"] = "On"
				LeaPlusLC["TipShowOtherRank"] = "Off"
				LeaPlusLC["TipShowTarget"] = "On"
				LeaPlusLC["TipHideInCombat"] = "Off"; SetTipHideShiftOverrideFunc()
				LeaPlusLC["TipHideShiftOverride"] = "On"
				LeaPlusLC["LeaPlusTipSize"] = 1.00
				LeaPlusLC["TipOffsetX"] = -13
				LeaPlusLC["TipOffsetY"] = 94
				LeaPlusLC["TooltipAnchorMenu"] = 1
				LeaPlusLC["TipCursorX"] = 0
				LeaPlusLC["TipCursorY"] = 0
				TipDrag:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", LeaPlusLC["TipOffsetX"], LeaPlusLC["TipOffsetY"]);
				SetAnchorControls()
				LeaPlusLC:SetTipScale()
				SideTip:Hide(); SideTip:Show();
			end)

			-- Show drag frame with configuration panel if anchor is not set to none
			SideTip:HookScript("OnShow", function()
				if LeaPlusLC["TooltipAnchorMenu"] == 1 then
					TipDrag:Hide()
				else
					TipDrag:Show()
				end
			end)
			SideTip:HookScript("OnHide", function() TipDrag:Hide() end)

			-- Control movement functions
			local void, LTax, LTay, LTbx, LTby, LTcx, LTcy
			TipDrag:SetScript("OnMouseDown", function(self, btn)
				if btn == "LeftButton" then
					void, void, void, LTax, LTay = TipDrag:GetPoint()
					TipDrag:StartMoving()
					void, void, void, LTbx, LTby = TipDrag:GetPoint()
				end
			end)
			TipDrag:SetScript("OnMouseUp", function(self, btn)
				if btn == "LeftButton" then
					void, void, void, LTcx, LTcy = TipDrag:GetPoint()
					TipDrag:StopMovingOrSizing();
					LeaPlusLC["TipOffsetX"], LeaPlusLC["TipOffsetY"] = LTcx - LTbx + LTax, LTcy - LTby + LTay
					TipDrag:ClearAllPoints()
					TipDrag:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", LeaPlusLC["TipOffsetX"], LeaPlusLC["TipOffsetY"])
				end
			end)

			--	Move the tooltip
			LeaPlusCB["MoveTooltipButton"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["TipShowRank"] = "On"
					LeaPlusLC["TipShowOtherRank"] = "Off"
					LeaPlusLC["TipShowTarget"] = "On"
					LeaPlusLC["TipHideInCombat"] = "Off"; SetTipHideShiftOverrideFunc()
					LeaPlusLC["TipHideShiftOverride"] = "On"
					LeaPlusLC["LeaPlusTipSize"] = 1.25
					LeaPlusLC["TipOffsetX"] = -13
					LeaPlusLC["TipOffsetY"] = 94
					LeaPlusLC["TooltipAnchorMenu"] = 2
					LeaPlusLC["TipCursorX"] = 0
					LeaPlusLC["TipCursorY"] = 0
					TipDrag:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", LeaPlusLC["TipOffsetX"], LeaPlusLC["TipOffsetY"]);
					SetAnchorControls()
					LeaPlusLC:SetTipScale()
					LeaPlusLC:SetDim();
					LeaPlusLC:ReloadCheck()
					SideTip:Show(); SideTip:Hide(); -- Needed to update tooltip scale
					LeaPlusLC["PageF"]:Hide(); LeaPlusLC["PageF"]:Show()
				else
					-- Show tooltip configuration panel
					LeaPlusLC:HideFrames()
					SideTip:Show()

					-- Set scale
					TipDrag:SetScale(LeaPlusLC["LeaPlusTipSize"])

					-- Set position of the drag frame
					TipDrag:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", LeaPlusLC["TipOffsetX"], LeaPlusLC["TipOffsetY"])
				end

			end)

			-- Hide health bar
			if LeaPlusLC["TipNoHealthBar"] == "On" then
				local tipHide = GameTooltip.Hide
				GameTooltipStatusBar:HookScript("OnShow", tipHide)
				GameTooltipStatusBar:Hide()
			end

			---------------------------------------------------------------------------------------------------------
			-- Tooltip scale settings
			---------------------------------------------------------------------------------------------------------

			-- Function to set the tooltip scale
			local function SetTipScale()

				-- General tooltip
				if GameTooltip then GameTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end

				-- Friends
				if FriendsTooltip then FriendsTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end

				-- AutoCompleteBox
				if AutoCompleteBox then AutoCompleteBox:SetScale(LeaPlusLC["LeaPlusTipSize"]) end

				-- Pet battles and battle pets
				if PetBattlePrimaryAbilityTooltip then PetBattlePrimaryAbilityTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end
				if PetBattlePrimaryUnitTooltip then PetBattlePrimaryUnitTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end
				if BattlePetTooltip then BattlePetTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end
				if FloatingBattlePetTooltip then FloatingBattlePetTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end
				if FloatingPetBattleAbilityTooltip then FloatingPetBattleAbilityTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end

				-- Items (links, comparisons)
				if ItemRefTooltip then ItemRefTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end
				if ItemRefShoppingTooltip1 then ItemRefShoppingTooltip1:SetScale(LeaPlusLC["LeaPlusTipSize"]) end
				if ItemRefShoppingTooltip2 then ItemRefShoppingTooltip2:SetScale(LeaPlusLC["LeaPlusTipSize"]) end
				if ShoppingTooltip1 then ShoppingTooltip1:SetScale(LeaPlusLC["LeaPlusTipSize"]) end
				if ShoppingTooltip2 then ShoppingTooltip2:SetScale(LeaPlusLC["LeaPlusTipSize"]) end

				-- Minimap (PVP queue status)
				if QueueStatusFrame then QueueStatusFrame:SetScale(LeaPlusLC["LeaPlusTipSize"]) end

				-- Embedded item tooltip (as used in PVP UI)
				if EmbeddedItemTooltip then EmbeddedItemTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end

				-- Nameplate tooltip
				if NamePlateTooltip then NamePlateTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end

				-- Game settings panel tooltip
				if SettingsTooltip then SettingsTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end

				-- World map tooltip
				if WorldMapTooltip then WorldMapTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end

				-- LibDBIcon
				if LibDBIconTooltip then LibDBIconTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"]) end

				-- Total RP 3
				if C_AddOns.IsAddOnLoaded("totalRP3") and TRP3_MainTooltip and TRP3_CharacterTooltip then
					TRP3_MainTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"])
					TRP3_CharacterTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"])
				end

				-- Altoholic
				if AltoTooltip then
					AltoTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"])
				end

				-- Leatrix Plus
				TipDrag:SetScale(LeaPlusLC["LeaPlusTipSize"])

				-- Set slider formatted text
				LeaPlusCB["LeaPlusTipSize"].f:SetFormattedText("%.0f%%", LeaPlusLC["LeaPlusTipSize"] * 100)

			end

			-- Give function a file level scope
			LeaPlusLC.SetTipScale = SetTipScale

			-- Set tooltip scale when slider or checkbox changes and on startup
			LeaPlusCB["LeaPlusTipSize"]:HookScript("OnValueChanged", SetTipScale)
			SetTipScale()

			----------------------------------------------------------------------
			-- Pet Journal tooltips
			----------------------------------------------------------------------

			EventUtil.ContinueOnAddOnLoaded("Blizzard_Collections",function()

				-- Function to set tooltip scale
				local function SetPetJournalTipScale()
					PetJournalPrimaryAbilityTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"])
				end

				-- Set tooltip scale when slider changes and on startup
				LeaPlusCB["LeaPlusTipSize"]:HookScript("OnValueChanged", SetPetJournalTipScale)
				SetPetJournalTipScale()

			end)

			----------------------------------------------------------------------
			-- Encounter Journal tooltips
			----------------------------------------------------------------------

			EventUtil.ContinueOnAddOnLoaded("Blizzard_EncounterJournal",function()

				-- Function to set tooltip scale
				local function SetEncounterJournalTipScale()
					EncounterJournalTooltip:SetScale(LeaPlusLC["LeaPlusTipSize"])
				end

				-- Set tooltip scale when slider changes and on startup
				LeaPlusCB["LeaPlusTipSize"]:HookScript("OnValueChanged", SetEncounterJournalTipScale)
				SetEncounterJournalTipScale()

			end)

			---------------------------------------------------------------------------------------------------------
			-- Other tooltip code
			---------------------------------------------------------------------------------------------------------

			-- Colorblind setting change
			TipDrag:RegisterEvent("CVAR_UPDATE")
			TipDrag:SetScript("OnEvent", function(self, event, arg1, arg2)
				if (arg1 == "USE_COLORBLIND_MODE") then
					LT["ColorBlind"] = arg2
				end
			end)

			-- Store locals
			local TipMClass = LOCALIZED_CLASS_NAMES_MALE
			local TipFClass = LOCALIZED_CLASS_NAMES_FEMALE

			-- Level string
			local LevelString, LevelString2
			if GameLocale == "ruRU" then
				-- Level string for ruRU
				LevelString = "уровня"
				LevelString2 = "уровень"
			else
				-- Level string for all other locales
				LevelString = string.lower(TOOLTIP_UNIT_LEVEL:gsub("%%s",".+"))
				LevelString2 = ""
			end

			-- Tag locale (code construction from tiplang)
			local ttYou, ttLevel, ttBoss, ttElite, ttRare, ttRareElite, ttRareBoss, ttTarget
			if 		GameLocale == "zhCN" then 	ttYou = "您"		; ttLevel = "等级"		; ttBoss = "首领"	; ttElite = "精英"	; ttRare = "精良"	; ttRareElite = "精良 精英"		; ttRareBoss = "精良 首领"		; ttTarget = "目标"
			elseif 	GameLocale == "zhTW" then 	ttYou = "您"		; ttLevel = "等級"		; ttBoss = "首領"	; ttElite = "精英"	; ttRare = "精良"	; ttRareElite = "精良 精英"		; ttRareBoss = "精良 首領"		; ttTarget = "目標"
			elseif 	GameLocale == "ruRU" then 	ttYou = "ВЫ"	; ttLevel = "Уровень"	; ttBoss = "босс"	; ttElite = "элита"	; ttRare = "Редкое"	; ttRareElite = "Редкое элита"	; ttRareBoss = "Редкое босс"	; ttTarget = "Цель"
			elseif 	GameLocale == "koKR" then 	ttYou = "당신"	; ttLevel = "레벨"		; ttBoss = "우두머리"	; ttElite = "정예"	; ttRare = "희귀"	; ttRareElite = "희귀 정예"		; ttRareBoss = "희귀 우두머리"		; ttTarget = "대상"
			elseif 	GameLocale == "esMX" then 	ttYou = "TÚ"	; ttLevel = "Nivel"		; ttBoss = "Jefe"	; ttElite = "Élite"	; ttRare = "Raro"	; ttRareElite = "Raro Élite"	; ttRareBoss = "Raro Jefe"		; ttTarget = "Objetivo"
			elseif 	GameLocale == "ptBR" then 	ttYou = "VOCÊ"	; ttLevel = "Nível"		; ttBoss = "Chefe"	; ttElite = "Elite"	; ttRare = "Raro"	; ttRareElite = "Raro Elite"	; ttRareBoss = "Raro Chefe"		; ttTarget = "Alvo"
			elseif 	GameLocale == "deDE" then 	ttYou = "SIE"	; ttLevel = "Stufe"		; ttBoss = "Boss"	; ttElite = "Elite"	; ttRare = "Selten"	; ttRareElite = "Selten Elite"	; ttRareBoss = "Selten Boss"	; ttTarget = "Ziel"
			elseif 	GameLocale == "esES" then	ttYou = "TÚ"	; ttLevel = "Nivel"		; ttBoss = "Jefe"	; ttElite = "Élite"	; ttRare = "Raro"	; ttRareElite = "Raro Élite"	; ttRareBoss = "Raro Jefe"		; ttTarget = "Objetivo"
			elseif 	GameLocale == "frFR" then 	ttYou = "TOI"	; ttLevel = "Niveau"	; ttBoss = "Boss"	; ttElite = "Élite"	; ttRare = "Rare"	; ttRareElite = "Rare Élite"	; ttRareBoss = "Rare Boss"		; ttTarget = "Cible"
			elseif 	GameLocale == "itIT" then 	ttYou = "TU"	; ttLevel = "Livello"	; ttBoss = "Boss"	; ttElite = "Élite"	; ttRare = "Raro"	; ttRareElite = "Raro Élite"	; ttRareBoss = "Raro Boss"		; ttTarget = "Bersaglio"
			else 								ttYou = "YOU"	; ttLevel = "Level"		; ttBoss = "Boss"	; ttElite = "Elite"	; ttRare = "Rare"	; ttRareElite = "Rare Elite"	; ttRareBoss = "Rare Boss"		; ttTarget = "Target"
			end

			-- Show tooltip
			local function ShowTip()

				-- Do nothing if CTRL, SHIFT and ALT are being held
				if IsControlKeyDown() and IsAltKeyDown() and IsShiftKeyDown() then
					return
				end

				-- Get unit information
				if WorldFrame:IsMouseMotionFocus() then
					LT["Unit"] = "mouseover"
					-- Hide and quit if tips should be hidden during combat
					if LeaPlusLC["TipHideInCombat"] == "On" and UnitAffectingCombat("player") then
						if not IsShiftKeyDown() or LeaPlusLC["TipHideShiftOverride"] == "Off" then
							GameTooltip:Hide()
							return
						end
					end
				else
					LT["Unit"] = select(2, GameTooltip:GetUnit())
					if not (LT["Unit"]) then return end
				end

				-- Quit if unit has no reaction to player
				LT["Reaction"] = UnitReaction(LT["Unit"], "player") or nil
				if not LT["Reaction"] then
					return
				end

				-- Quit if unit is a wild pet
				if UnitIsWildBattlePet(LT["Unit"]) then return end

				-- Setup variables
				LT["TipUnitName"], LT["TipUnitRealm"] = UnitName(LT["Unit"])
				LT["TipIsPlayer"] = UnitIsPlayer(LT["Unit"])
				LT["UnitLevel"] = UnitLevel(LT["Unit"])
				LT["UnitClass"] = UnitClassBase(LT["Unit"])
				LT["PlayerControl"] = UnitPlayerControlled(LT["Unit"])
				LT["PlayerRace"] = UnitRace(LT["Unit"])

				-- Get guild information
				if LT["TipIsPlayer"] then
					local unitGuild, unitRank = GetGuildInfo(LT["Unit"])
					if unitGuild and unitRank then
						-- Unit is guilded
						if LT["ColorBlind"] == "1" then
							LT["GuildLine"], LT["InfoLine"] = 2, 4
						else
							LT["GuildLine"], LT["InfoLine"] = 2, 3
						end
						LT["GuildName"], LT["GuildRank"] = unitGuild, unitRank
					else
						-- Unit is not guilded
						LT["GuildName"] = nil
						if LT["ColorBlind"] == "1" then
							LT["GuildLine"], LT["InfoLine"] = 0, 3
						else
							LT["GuildLine"], LT["InfoLine"] = 0, 2
						end
					end
					-- Lower information line if unit is charmed
					if UnitIsCharmed(LT["Unit"]) then
						LT["InfoLine"] = LT["InfoLine"] + 1
					end
				end

				-- Determine class color
				if LT["UnitClass"] then
					-- Define male or female (for certain locales)
					LT["Sex"] = UnitSex(LT["Unit"])
					if LT["Sex"] == 2 then
						LT["Class"] = TipMClass[LT["UnitClass"]]
					else
						LT["Class"] = TipFClass[LT["UnitClass"]]
					end
					-- Define class color
					LT["ClassCol"] = LeaPlusLC["RaidColors"][LT["UnitClass"]]
					LT["LpTipClassColor"] = "|cff" .. string.format("%02x%02x%02x", LT["ClassCol"].r * 255, LT["ClassCol"].g * 255, LT["ClassCol"].b * 255)
				end

				----------------------------------------------------------------------
				-- Name line
				----------------------------------------------------------------------

				if ((LT["TipIsPlayer"]) or (LT["PlayerControl"])) or LT["Reaction"] > 4 then

					-- If it's a player show name in class color
					if LT["TipIsPlayer"] then
						LT["NameColor"] = LT["LpTipClassColor"]
					else
						-- If not, set to green or blue depending on PvP status
						if UnitIsPVP(LT["Unit"]) then
							LT["NameColor"] = "|cff00ff00"
						else
							LT["NameColor"] = "|cff00aaff"
						end
					end

					-- Show name
					LT["NameText"] = UnitPVPName(LT["Unit"]) or LT["TipUnitName"]

					-- Show realm
					if LT["TipUnitRealm"] then
						LT["NameText"] = LT["NameText"] .. " - " .. LT["TipUnitRealm"]
					end

					-- Show dead units in grey
					if UnitIsDeadOrGhost(LT["Unit"]) then
						LT["NameColor"] = "|c88888888"
					end

					-- Show name line
					_G["GameTooltipTextLeft1"]:SetText(LT["NameColor"] .. LT["NameText"] .. "|cffffffff|r")

				elseif UnitIsDeadOrGhost(LT["Unit"]) then

					-- Show grey name for other dead units
					_G["GameTooltipTextLeft1"]:SetText("|c88888888" .. (_G["GameTooltipTextLeft1"]:GetText() or "") .. "|cffffffff|r")
					return

				end

				----------------------------------------------------------------------
				-- Guild line
				----------------------------------------------------------------------

				if LT["TipIsPlayer"] and LT["GuildName"] then

					-- Show guild line
					if UnitIsInMyGuild(LT["Unit"]) then
						if LeaPlusLC["TipShowRank"] == "On" then
							_G["GameTooltipTextLeft" .. LT["GuildLine"]]:SetText("|c00aaaaff" .. LT["GuildName"] .. " - " .. LT["GuildRank"] .. "|r")
						else
							_G["GameTooltipTextLeft" .. LT["GuildLine"]]:SetText("|c00aaaaff" .. LT["GuildName"] .. "|cffffffff|r")
						end
					else
						if LeaPlusLC["TipShowOtherRank"] == "On" then
							_G["GameTooltipTextLeft" .. LT["GuildLine"]]:SetText("|c00aaaaff" .. LT["GuildName"] .. " - " .. LT["GuildRank"] .. "|r")
						else
							_G["GameTooltipTextLeft" .. LT["GuildLine"]]:SetText("|c00aaaaff" .. LT["GuildName"] .. "|cffffffff|r")
						end
					end

				end

				----------------------------------------------------------------------
				-- Information line (level, class, race)
				----------------------------------------------------------------------

				if LT["TipIsPlayer"] then

					if GameLocale == "ruRU" then

						LT["InfoText"] = ""

						-- Show race
						if LT["PlayerRace"] then
							LT["InfoText"] = LT["InfoText"] .. LT["PlayerRace"] .. ","
						end

						-- Show class
						LT["InfoText"] = LT["InfoText"] .. " " .. LT["LpTipClassColor"] .. LT["Class"] .. "|r " or LT["InfoText"] .. "|r "

						-- Show level
						if LT["Reaction"] < 5 then
							if LT["UnitLevel"] == -1 then
								LT["InfoText"] = LT["InfoText"] .. ("|cffff3333" .. "??-ro" .. " " .. ttLevel .. "|cffffffff")
							else
								LT["LevelColor"] = GetCreatureDifficultyColor(LT["UnitLevel"])
								LT["LevelColor"] = string.format('%02x%02x%02x', LT["LevelColor"].r * 255, LT["LevelColor"].g * 255, LT["LevelColor"].b * 255)
								LT["InfoText"] = LT["InfoText"] .. ("|cff" .. LT["LevelColor"] .. LT["UnitLevel"] .. LT["LevelLocale"] .. "|cffffffff")
							end
						else
							LT["InfoText"] = LT["InfoText"] .. LT["UnitLevel"] .. LT["LevelLocale"]
						end

						-- Show information line
						_G["GameTooltipTextLeft" .. LT["InfoLine"]]:SetText(LT["InfoText"] .. "|cffffffff|r")

					else

						-- Show level
						if LT["Reaction"] < 5 then
							if LT["UnitLevel"] == -1 then
								LT["InfoText"] = ("|cffff3333" .. ttLevel .. " ??|cffffffff")
							else
								LT["LevelColor"] = GetCreatureDifficultyColor(LT["UnitLevel"])
								LT["LevelColor"] = string.format('%02x%02x%02x', LT["LevelColor"].r * 255, LT["LevelColor"].g * 255, LT["LevelColor"].b * 255)
								LT["InfoText"] = ("|cff" .. LT["LevelColor"] .. LT["LevelLocale"] .. " " .. LT["UnitLevel"] .. "|cffffffff")
							end
						else
							LT["InfoText"] = LT["LevelLocale"] .. " " .. LT["UnitLevel"]
						end

						-- Show race
						if LT["PlayerRace"] then
							LT["InfoText"] = LT["InfoText"] .. " " .. LT["PlayerRace"]
						end

						-- Show class
						LT["InfoText"] = LT["InfoText"] .. " " .. LT["LpTipClassColor"] .. LT["Class"] or LT["InfoText"]

						-- Show information line
						_G["GameTooltipTextLeft" .. LT["InfoLine"]]:SetText(LT["InfoText"] .. "|cffffffff|r")

					end

				end

				----------------------------------------------------------------------
				-- Mob name in brighter red (alive) and steel blue (tap denied)
				----------------------------------------------------------------------

				if not (LT["TipIsPlayer"]) and LT["Reaction"] < 4 and not (LT["PlayerControl"]) then
					if UnitIsTapDenied(LT["Unit"]) then
						LT["NameText"] = "|c8888bbbb" .. LT["TipUnitName"] .. "|r"
					else
						LT["NameText"] = "|cffff3333" .. LT["TipUnitName"] .. "|r"
					end
					_G["GameTooltipTextLeft1"]:SetText(LT["NameText"])
				end

				----------------------------------------------------------------------
				-- Mob level in color (neutral or lower)
				----------------------------------------------------------------------

				if UnitCanAttack(LT["Unit"], "player") and not (LT["TipIsPlayer"]) and LT["Reaction"] < 5 and not (LT["PlayerControl"]) then

					-- Find the level line
					LT["MobInfoLine"] = 0
					local line2, line3, line4
					if _G["GameTooltipTextLeft2"] then line2 = _G["GameTooltipTextLeft2"]:GetText() end
					if _G["GameTooltipTextLeft3"] then line3 = _G["GameTooltipTextLeft3"]:GetText() end
					if _G["GameTooltipTextLeft4"] then line4 = _G["GameTooltipTextLeft4"]:GetText() end
					if GameLocale == "ruRU" then -- Additional check for ruRU
						if line2 and string.lower(line2):find(LevelString2) then LT["MobInfoLine"] = 2 end
						if line3 and string.lower(line3):find(LevelString2) then LT["MobInfoLine"] = 3 end
						if line4 and string.lower(line4):find(LevelString2) then LT["MobInfoLine"] = 4 end
					end
					if line2 and string.lower(line2):find(LevelString) then LT["MobInfoLine"] = 2 end
					if line3 and string.lower(line3):find(LevelString) then LT["MobInfoLine"] = 3 end
					if line4 and string.lower(line4):find(LevelString) then LT["MobInfoLine"] = 4 end

					-- Show level line
					if LT["MobInfoLine"] > 1 then

						if GameLocale == "ruRU" then

							LT["InfoText"] = ""

							-- Show creature type and classification
							LT["CreatureType"] = UnitCreatureType(LT["Unit"])
							if (LT["CreatureType"]) and not (LT["CreatureType"] == "Not specified") then
								LT["InfoText"] = LT["InfoText"] .. "|cffffffff" .. LT["CreatureType"] .. "|cffffffff "
							end

							-- Level ?? mob
							if LT["UnitLevel"] == -1 then
								LT["InfoText"] = LT["InfoText"] .. "|cffff3333" .. "??-ro " .. ttLevel .. "|cffffffff "

							-- Mobs within level range
							else
								LT["MobColor"] = GetCreatureDifficultyColor(LT["UnitLevel"])
								LT["MobColor"] = string.format('%02x%02x%02x', LT["MobColor"].r * 255, LT["MobColor"].g * 255, LT["MobColor"].b * 255)
								LT["InfoText"] = LT["InfoText"] .. "|cff" .. LT["MobColor"] .. LT["UnitLevel"] .. LT["LevelLocale"] .. "|cffffffff "
							end

						else

							-- Level ?? mob
							if LT["UnitLevel"] == -1 then
								LT["InfoText"] = "|cffff3333" .. ttLevel .. " ??|cffffffff "

							-- Mobs within level range
							else
								LT["MobColor"] = GetCreatureDifficultyColor(LT["UnitLevel"])
								LT["MobColor"] = string.format('%02x%02x%02x', LT["MobColor"].r * 255, LT["MobColor"].g * 255, LT["MobColor"].b * 255)
								LT["InfoText"] = "|cff" .. LT["MobColor"] .. LT["LevelLocale"] .. " " .. LT["UnitLevel"] .. "|cffffffff "
							end

							-- Show creature type and classification
							LT["CreatureType"] = UnitCreatureType(LT["Unit"])
							if (LT["CreatureType"]) and not (LT["CreatureType"] == "Not specified") then
								LT["InfoText"] = LT["InfoText"] .. "|cffffffff" .. LT["CreatureType"] .. "|cffffffff "
							end

						end

						-- Rare, elite and boss mobs
						LT["Special"] = UnitClassification(LT["Unit"])
						if LT["Special"] then
							if LT["Special"] == "elite" then
								if strfind(_G["GameTooltipTextLeft" .. LT["MobInfoLine"]]:GetText(), "(" .. ttBoss .. ")") then
									LT["Special"] = "(" .. ttBoss .. ")"
								else
									LT["Special"] = "(" .. ttElite .. ")"
								end
							elseif LT["Special"] == "rare" then
								LT["Special"] = "|c00e066ff(" .. ttRare .. ")"
							elseif LT["Special"] == "rareelite" then
								if strfind(_G["GameTooltipTextLeft" .. LT["MobInfoLine"]]:GetText(), "(" .. ttBoss .. ")") then
									LT["Special"] = "|c00e066ff(" .. ttRareBoss .. ")"
								else
									LT["Special"] = "|c00e066ff(" .. ttRareElite .. ")"
								end
							elseif LT["Special"] == "worldboss" then
								LT["Special"] = "(" .. ttBoss .. ")"
							elseif LT["UnitLevel"] == -1 and LT["Special"] == "normal" and strfind(_G["GameTooltipTextLeft" .. LT["MobInfoLine"]]:GetText(), "(" .. ttBoss .. ")") then
								LT["Special"] = "(" .. ttBoss .. ")"
							else
								LT["Special"] = nil
							end

							if (LT["Special"]) then
								LT["InfoText"] = LT["InfoText"] .. LT["Special"]
							end
						end

						-- Show mob info line
						_G["GameTooltipTextLeft" .. LT["MobInfoLine"]]:SetText(LT["InfoText"])

					end

				end

				----------------------------------------------------------------------
				--	Show target
				----------------------------------------------------------------------

				if LeaPlusLC["TipShowTarget"] == "On" then

					-- Get target
					LT["Target"] = UnitName(LT["Unit"] .. "target");

					-- If target doesn't exist, quit
					if LT["Target"] == nil or LT["Target"] == "" then return end

					-- If target is you, set target to YOU
					if (UnitIsUnit(LT["Target"], "player")) then
						LT["Target"] = ("|c12ff4400" .. ttYou)

					-- If it's not you, but it's a player, show target in class color
					elseif UnitIsPlayer(LT["Unit"] .. "target") then
						LT["TargetBase"] = UnitClassBase(LT["Unit"] .. "target")
						LT["TargetCol"] = LeaPlusLC["RaidColors"][LT["TargetBase"]]
						LT["TargetCol"] = "|cff" .. string.format('%02x%02x%02x', LT["TargetCol"].r * 255, LT["TargetCol"].g * 255, LT["TargetCol"].b * 255)
						LT["Target"] = (LT["TargetCol"] .. LT["Target"])

					end

					-- Add target line
					GameTooltip:AddLine(ttTarget .. ": " .. LT["Target"])

				end

			end

			GameTooltip:HookScript("OnTooltipSetUnit", ShowTip)

		end

		----------------------------------------------------------------------
		--	Move chat editbox to top
		----------------------------------------------------------------------

		if LeaPlusLC["MoveChatEditBoxToTop"] == "On" and not LeaLockList["MoveChatEditBoxToTop"] then

			-- Set options for normal chat frames
			for i = 1, 50 do
				if _G["ChatFrame" .. i] then
					-- Position the editbox
					_G["ChatFrame" .. i .. "EditBox"]:ClearAllPoints();
					_G["ChatFrame" .. i .. "EditBox"]:SetPoint("TOPLEFT", _G["ChatFrame" .. i], 0, 0);
					_G["ChatFrame" .. i .. "EditBox"]:SetWidth(_G["ChatFrame" .. i]:GetWidth());
					-- Ensure editbox width matches chatframe width
					_G["ChatFrame" .. i]:HookScript("OnSizeChanged", function()
						_G["ChatFrame" .. i .. "EditBox"]:SetWidth(_G["ChatFrame" .. i]:GetWidth())
					end)
				end
			end

			-- Do the functions above for other chat frames (pet battles, whispers, etc)
			hooksecurefunc("FCF_OpenTemporaryWindow", function()

				local cf = FCF_GetCurrentChatFrame():GetName() or nil
				if cf then

					-- Position the editbox
					_G[cf .. "EditBox"]:ClearAllPoints();
					_G[cf .. "EditBox"]:SetPoint("TOPLEFT", cf, "TOPLEFT", 0, 0);
					_G[cf .. "EditBox"]:SetWidth(_G[cf]:GetWidth());

					-- Ensure editbox width matches chatframe width
					_G[cf]:HookScript("OnSizeChanged", function()
						_G[cf .. "EditBox"]:SetWidth(_G[cf]:GetWidth())
					end)

				end
			end)

		end

		----------------------------------------------------------------------
		-- Show borders
		----------------------------------------------------------------------

		if LeaPlusLC["ShowBorders"] == "On" then

			-- Create border textures
			local BordTop = WorldFrame:CreateTexture(nil, "ARTWORK"); BordTop:SetColorTexture(0, 0, 0, 1); BordTop:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0); BordTop:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 0, 0)
			local BordBot = WorldFrame:CreateTexture(nil, "ARTWORK"); BordBot:SetColorTexture(0, 0, 0, 1); BordBot:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0); BordBot:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
			local BordLeft = WorldFrame:CreateTexture(nil, "ARTWORK"); BordLeft:SetColorTexture(0, 0, 0, 1); BordLeft:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0); BordLeft:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0)
			local BordRight = WorldFrame:CreateTexture(nil, "ARTWORK"); BordRight:SetColorTexture(0, 0, 0, 1); BordRight:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 0, 0); BordRight:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)

			-- Create border configuration panel
			local bordersPanel = LeaPlusLC:CreatePanel("Show borders", "bordersPanel")

			-- Function to set border parameters
			local function RefreshBorders()

				-- Set border size and transparency
				BordTop:SetHeight(LeaPlusLC["BordersTop"]); BordTop:SetAlpha(1 - LeaPlusLC["BordersAlpha"])
				BordBot:SetHeight(LeaPlusLC["BordersBottom"]); BordBot:SetAlpha(1 - LeaPlusLC["BordersAlpha"])
				BordLeft:SetWidth(LeaPlusLC["BordersLeft"]); BordLeft:SetAlpha(1 - LeaPlusLC["BordersAlpha"])
				BordRight:SetWidth(LeaPlusLC["BordersRight"]); BordRight:SetAlpha(1 - LeaPlusLC["BordersAlpha"])

				-- Show formatted slider value
				LeaPlusCB["BordersAlpha"].f:SetFormattedText("%.0f%%", LeaPlusLC["BordersAlpha"] * 100)

			end

			-- Create slider controls
			LeaPlusLC:MakeTx(bordersPanel, "Top", 16, -72)
			LeaPlusLC:MakeSL(bordersPanel, "BordersTop", "Drag to set the size of the top border.", 0, 300, 5, 16, -92, "%.0f")
			LeaPlusCB["BordersTop"]:HookScript("OnValueChanged", RefreshBorders)

			LeaPlusLC:MakeTx(bordersPanel, "Bottom", 16, -132)
			LeaPlusLC:MakeSL(bordersPanel, "BordersBottom", "Drag to set the size of the bottom border.", 0, 300, 5, 16, -152, "%.0f")
			LeaPlusCB["BordersBottom"]:HookScript("OnValueChanged", RefreshBorders)

			LeaPlusLC:MakeTx(bordersPanel, "Left", 186, -72)
			LeaPlusLC:MakeSL(bordersPanel, "BordersLeft", "Drag to set the size of the left border.", 0, 300, 5, 186, -92, "%.0f")
			LeaPlusCB["BordersLeft"]:HookScript("OnValueChanged", RefreshBorders)

			LeaPlusLC:MakeTx(bordersPanel, "Right", 186, -132)
			LeaPlusLC:MakeSL(bordersPanel, "BordersRight", "Drag to set the size of the right border.", 0, 300, 5, 186, -152, "%.0f")
			LeaPlusCB["BordersRight"]:HookScript("OnValueChanged", RefreshBorders)

			LeaPlusLC:MakeTx(bordersPanel, "Transparency", 356, -132)
			LeaPlusLC:MakeSL(bordersPanel, "BordersAlpha", "Drag to set the transparency of the borders.", 0, 0.9, 0.1, 356, -152, "%.1f")
			LeaPlusCB["BordersAlpha"]:HookScript("OnValueChanged", RefreshBorders)

			-- Help button hidden
			bordersPanel.h:Hide()

			-- Back button handler
			bordersPanel.b:SetScript("OnClick", function()
				bordersPanel:Hide()
				LeaPlusLC["PageF"]:Show()
				LeaPlusLC["Page5"]:Show()
				return
			end)

			-- Reset button handler
			bordersPanel.r:SetScript("OnClick", function()
				LeaPlusLC["BordersTop"] = 0
				LeaPlusLC["BordersBottom"] = 0
				LeaPlusLC["BordersLeft"] = 0
				LeaPlusLC["BordersRight"] = 0
				LeaPlusLC["BordersAlpha"] = 0
				bordersPanel:Hide(); bordersPanel:Show()
				RefreshBorders()
			end)

			-- Configuration button handler
			LeaPlusCB["ModBordersBtn"]:SetScript("OnClick", function()
				if IsShiftKeyDown() and IsControlKeyDown() then
					-- Preset profile
					LeaPlusLC["BordersTop"] = 0
					LeaPlusLC["BordersBottom"] = 0
					LeaPlusLC["BordersLeft"] = 0
					LeaPlusLC["BordersRight"] = 0
					LeaPlusLC["BordersAlpha"] = 0.7
					RefreshBorders()
				else
					bordersPanel:Show()
					LeaPlusLC:HideFrames()
				end
			end)

			-- Set borders on startup
			RefreshBorders()

			-- Hide borders when cinematic is shown
			hooksecurefunc(CinematicFrame, "Hide", function()
				BordTop:Show(); BordBot:Show(); BordLeft:Show(); BordRight:Show()
			end)
			hooksecurefunc(CinematicFrame, "Show", function()
				BordTop:Hide(); BordBot:Hide(); BordLeft:Hide(); BordRight:Hide()
			end)

		end

		----------------------------------------------------------------------
		-- Silence rested emotes
		----------------------------------------------------------------------

		-- Manage emotes
		if LeaPlusLC["NoRestedEmotes"] == "On" then

			-- Zone table 		English					, French					, German					, Italian						, Russian					, S Chinese	, Spanish					, T Chinese	,
			local zonetable = {	"The Halfhill Market"	, "Marché de Micolline"		, "Der Halbhügelmarkt"		, "Il Mercato di Mezzocolle"	, "Рынок Полугорья"			, "半山市集"	, "El Mercado del Alcor"	, "半丘市集"	,
								"The Grim Guzzler"		, "Le Sinistre écluseur"	, "Zum Grimmigen Säufer"	, "Torvo Beone"					, "Трактир Угрюмый обжора"	, "黑铁酒吧"	, "Tragapenas"				, "黑鐵酒吧"	,
								"The Summer Terrace"	, "La terrasse Estivale"	, "Die Sommerterrasse"		, "Terrazza Estiva"				, "Летняя терраса"			, "夏之台"	, "El Bancal del Verano"	, "夏日露臺"	,
								"The Golden Terrace"	, "La Terrasse Dorée"		, "Die Goldene Terrasse"	, "La Terrazza Dorata"			, "Золотая терраса"			, "金色平台"	, "La Terraza Dorada"		, "金色平台"	,
			}

			-- Function to set rested state
			local function UpdateEmoteSound()

				-- Find character's current zone
				local szone = GetSubZoneText() or "None"

				-- Find out if emote sounds are disabled or enabled
				local emoset = GetCVar("Sound_EnableEmoteSounds")

				if IsResting() then
					-- Character is resting so silence emotes
					if emoset ~= "0" then
						SetCVar("Sound_EnableEmoteSounds", "0")
					end
					return
				end

				-- Traverse zone table and silence emotes if character is in a designated zone
				for k, v in next, zonetable do
					if szone == zonetable[k] then
						if emoset ~= "0" then
							SetCVar("Sound_EnableEmoteSounds", "0")
						end
						return
					end
				end

				-- Silence emotes if character is in a pet battle
				if C_PetBattles.IsInBattle() then
					if emoset ~= "0" then
						SetCVar("Sound_EnableEmoteSounds", "0")
					end
					return
				end

				-- If the above didn't return, emote sounds should be enabled
				if emoset ~= "1" then
					SetCVar("Sound_EnableEmoteSounds", "1")
				end
				return

			end

			-- Set emote sound when pet battles start and end
			hooksecurefunc("PetBattleFrame_Display", UpdateEmoteSound)
			hooksecurefunc("PetBattleFrame_Remove",	UpdateEmoteSound)

			-- Set emote sound when rest state or zone changes
			local RestEvent = CreateFrame("FRAME")
			RestEvent:RegisterEvent("PLAYER_UPDATE_RESTING")
			RestEvent:RegisterEvent("ZONE_CHANGED_NEW_AREA")
			RestEvent:RegisterEvent("ZONE_CHANGED")
			RestEvent:RegisterEvent("ZONE_CHANGED_INDOORS")
			RestEvent:SetScript("OnEvent", UpdateEmoteSound)

			-- Set sound setting at startup
			UpdateEmoteSound()


		end

		----------------------------------------------------------------------
		--	Max camera zoom (no reload required)
		----------------------------------------------------------------------

		do

			-- Create event frame
			local frame = CreateFrame("FRAME")

			-- Function to set camera zoom
			local function SetZoom()
				if LeaPlusLC["MaxCameraZoom"] == "On" then
					SetCVar("cameraDistanceMaxZoomFactor", 4.0)
					frame:RegisterEvent("PLAYER_ENTERING_WORLD")
				else
					SetCVar("cameraDistanceMaxZoomFactor", 1.9)
					frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
				end
			end

			frame:SetScript("OnEvent", SetZoom)

			-- Set camera zoom when option is clicked and on startup (if enabled)
			LeaPlusCB["MaxCameraZoom"]:HookScript("OnClick", SetZoom)
			if LeaPlusLC["MaxCameraZoom"] == "On" then SetZoom() end

		end

		----------------------------------------------------------------------
		-- L45: Frame alignment grid
		----------------------------------------------------------------------

		do

			-- Create frame alignment grid
			local grid = CreateFrame('FRAME')
			LeaPlusLC.grid = grid
			grid:Hide()
			grid:SetAllPoints(UIParent)
			local w, h = GetScreenWidth() * UIParent:GetEffectiveScale(), GetScreenHeight() * UIParent:GetEffectiveScale()
			local ratio = w / h
			local sqsize = w / 20
			local wline = floor(sqsize - (sqsize % 2))
			local hline = floor(sqsize / ratio - ((sqsize / ratio) % 2))
			-- Plot vertical lines
			for i = 0, wline do
				local t = LeaPlusLC.grid:CreateTexture(nil, 'BACKGROUND')
				if i == wline / 2 then t:SetColorTexture(1, 0, 0, 0.5) else t:SetColorTexture(0, 0, 0, 0.5) end
				t:SetPoint('TOPLEFT', grid, 'TOPLEFT', i * w / wline - 1, 0)
				t:SetPoint('BOTTOMRIGHT', grid, 'BOTTOMLEFT', i * w / wline + 1, 0)
			end
			-- Plot horizontal lines
			for i = 0, hline do
				local t = LeaPlusLC.grid:CreateTexture(nil, 'BACKGROUND')
				if i == hline / 2 then	t:SetColorTexture(1, 0, 0, 0.5) else t:SetColorTexture(0, 0, 0, 0.5) end
				t:SetPoint('TOPLEFT', grid, 'TOPLEFT', 0, -i * h / hline + 1)
				t:SetPoint('BOTTOMRIGHT', grid, 'TOPRIGHT', 0, -i * h / hline - 1)
			end

		end

		----------------------------------------------------------------------
		-- Media player
		----------------------------------------------------------------------

		function LeaPlusLC:MediaFunc()

			-- Create tables for list data and zone listing
			local ListData, playlist = {}, {}
			local scrollFrame, willPlay, musicHandle, ZonePage, LastPlayed, LastFolder, TempFolder, HeadingOfClickedTrack, LastMusicHandle
			local numButtons = math.floor((LeaPlusLC.MainPanelHeight - 110) / 16) - 1
			local uframe = CreateFrame("FRAME")

			-- These categories will not appear in random track selections
			local randomBannedList = {L["Narration"], L["Cinematics"]}

			-- Get media table
			local ZoneList = Leatrix_Plus["ZoneList"]

			-- Show relevant list items
			local function UpdateList()
				local offset = max(0, floor(scrollFrame:GetVerticalScroll() + 0.5))
				for i, button in ipairs(scrollFrame.buttons) do
					local index = offset + i
					if index <= #ListData then
						-- Show zone listing or track listing
						button:SetText(ListData[index].zone or ListData[index])
						-- Set width of highlight texture
						if button:GetTextWidth() > 290 then
							button.t:SetSize(290, 16)
						else
							button.t:SetSize(button:GetTextWidth(), 16)
						end
						-- Show the button
						button:Show()
						-- Hide highlight bar texture by default
						button.s:Hide()
						-- Hide highlight bar if the button is a heading
						if strfind(button:GetText(), "|c") then button.t:Hide() end
						-- Show last played track highlight bar texture
						if LastPlayed == button:GetText() then
							local HeadingOfCurrentFolder = ListData[1]
							if HeadingOfCurrentFolder == HeadingOfClickedTrack then
								button.s:Show()
							end
						end
						-- Show last played folder highlight bar texture
						if LastFolder == button:GetText() then
							button.s:Show()
						end
						-- Set width of highlight bar
						if button:GetTextWidth() > 290 then
							button.s:SetSize(290, 16)
						else
							button.s:SetSize(button:GetTextWidth(), 16)
						end
						-- Limit click to label width
						local bWidth = button:GetFontString():GetStringWidth() or 0
						if bWidth > 290 then bWidth = 290 end
						button:SetHitRectInsets(0, 454 - bWidth, 0, 0)
						-- Disable label click movement
						button:SetPushedTextOffset(0, 0)
						-- Disable word wrap and set width
						button:GetFontString():SetWidth(290)
						button:GetFontString():SetWordWrap(false)
					else
						button:Hide()
					end
				end

				local bRoll = ((36 + (LeaPlusLC.MainPanelHeight - 370)) / 16) + 16
				scrollFrame.child:SetSize(200, #ListData + (math.floor(bRoll * 15)))

			end

			-- Give function file level scope (it's used in SetPlusScale to set the highlight bar scale)
			LeaPlusLC.UpdateList = UpdateList

			-- Right-button click to go back
			local function BackClick()
				-- Return to the current zone list (back button)
				if type(ListData[1]) == "string" then
					-- Strip the color code from the list data
					local nocol = string.gsub(ListData[1], "|cffffd800", "")
					-- Strip the zone
					local backzone = strsplit(":", nocol, 2)
					-- Don't go back if random or search category is being shown
					if backzone == L["Random"] or backzone == L["Search"] then return end
					-- Show the tracklist continent
					if ZoneList[backzone] then ListData = ZoneList[backzone] end
					UpdateList()
					scrollFrame:SetVerticalScroll(ZonePage or 0)
				end
			end

			-- Function to make navigation menu buttons
			local function MakeButton(where, y)
				local mbtn = CreateFrame("Button", nil, LeaPlusLC["Page9"])
				mbtn:Show()
				mbtn:SetAlpha(1.0)
				mbtn:SetPoint("TOPLEFT", 146, y)

				-- Create hover texture
				mbtn.t = mbtn:CreateTexture(nil, "BACKGROUND")
				mbtn.t:SetColorTexture(0.3, 0.3, 0.00, 0.8)
				mbtn.t:SetAlpha(0.7)
				mbtn.t:SetAllPoints()
				mbtn.t:Hide()

				-- Create highlight texture
				mbtn.s = mbtn:CreateTexture(nil, "BACKGROUND")
				mbtn.s:SetColorTexture(0.3, 0.3, 0.00, 0.8)
				mbtn.s:SetAlpha(1.0)
				mbtn.s:SetAllPoints()
				mbtn.s:Hide()

				-- Create fontstring
				mbtn.f = mbtn:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
				mbtn.f:SetPoint('LEFT', 1, 0)
				mbtn.f:SetText(L[where])

				mbtn:SetScript("OnEnter", function()
					mbtn.t:Show()
				end)

				mbtn:SetScript("OnLeave", function()
					mbtn.t:Hide()
				end)

				-- Set button size when shown
				mbtn:SetScript("OnShow", function()
					mbtn:SetSize(mbtn.f:GetStringWidth() + 1, 16)
				end)

				mbtn:SetScript("OnClick", function()
					-- Show zone listing for clicked item
					ListData = ZoneList[where]
					UpdateList()
				end)

				return mbtn, mbtn.s

			end

			-- Create a table for each button
			local conbtn = {}
			for q, w in pairs(ZoneList) do
				conbtn[q] = {}
			end

			-- Create buttons
			local function MakeButtonNow(title, anchor)
				conbtn[title], conbtn[title].s = MakeButton(title, height)
				conbtn[title]:ClearAllPoints()
				if title == L["Zones"] then
					-- Set first button position
					conbtn[title]:SetPoint("TOPLEFT", LeaPlusLC["Page9"], "TOPLEFT", 145, -70)
				elseif anchor then
					-- Set subsequent button positions
					conbtn[title]:SetPoint("TOPLEFT", conbtn[anchor], "BOTTOMLEFT", 0, 0)
					conbtn[title].f:SetText(L[title])
				end
			end

			MakeButtonNow(L["Zones"])
			MakeButtonNow(L["Dungeons"], L["Zones"])
			MakeButtonNow(L["Various"], L["Dungeons"])
			MakeButtonNow(L["Movies"], L["Various"])
			MakeButtonNow(L["Random"], L["Movies"])
			MakeButtonNow(L["Search"]) -- Positioned when search editbox is created

			-- Show button highlight for clicked button
			for q, w in pairs(ZoneList) do
				if type(w) == "string" and conbtn[w] then
					conbtn[w]:HookScript("OnClick", function()
						-- Hide all button highlights
						for k, v in pairs(ZoneList) do
							if type(v) == "string" and conbtn[v] then
								conbtn[v].s:Hide()
							end
						end
						-- Show clicked button highlight
						conbtn[w].s:Show()
						LeaPlusDB["MusicContinent"] = w
						scrollFrame:SetVerticalScroll(0)
						-- Set TempFolder for listings without folders
						if w == L["Random"] then TempFolder = L["Random"] end
						if w == L["Search"] then TempFolder = L["Search"] end
					end)
				end
			end

			-- Create scroll bar
			scrollFrame = CreateFrame("ScrollFrame", nil, LeaPlusLC["Page9"], "ScrollFrameTemplate")
			scrollFrame:SetPoint("TOPLEFT", 0, -32)
			scrollFrame:SetPoint("BOTTOMRIGHT", -30, 50)
			scrollFrame:SetPanExtent(1)
			scrollFrame:SetScript("OnVerticalScroll", UpdateList)

			-- Create the scroll child
			scrollFrame.child = CreateFrame("Frame", nil, scrollFrame)
			scrollFrame:SetScrollChild(scrollFrame.child)

			-- Add stop button
			local stopBtn = LeaPlusLC:CreateButton("StopMusicBtn", LeaPlusLC["Page9"], "Stop", "BOTTOMLEFT", 146, 53, 0, 25, true, "")
			stopBtn:Hide(); stopBtn:Show()
			LeaPlusLC:LockItem(stopBtn, true)
			stopBtn:SetScript("OnClick", function()
				if musicHandle then
					StopSound(musicHandle)
					musicHandle = nil
					-- Hide highlight bars
					LastPlayed = ""
					LastFolder = ""
					UpdateList()
				end
				-- Cancel sound file music timer
				if LeaPlusLC.TrackTimer then LeaPlusLC.TrackTimer:Cancel() end
				-- Lock button and unregister next track events
				LeaPlusLC:LockItem(stopBtn, true)
				uframe:UnregisterEvent("SOUNDKIT_FINISHED")
				uframe:UnregisterEvent("LOADING_SCREEN_DISABLED")
			end)

			-- Store currently playing track number
			local tracknumber = 1

			-- Function to play a track and show the static highlight bar
			local function PlayTrack()
				-- Play tracks
				if musicHandle then StopSound(musicHandle) end
				local file, soundID, trackTime
				if playlist[tracknumber]:match("([^,]+)%#([^,]+)%#([^,]+)") then
					-- Music file with track time
					file, soundID, trackTime = playlist[tracknumber]:match("([^,]+)%#([^,]+)%#([^,]+)")
					willPlay, musicHandle = PlaySoundFile(soundID, "Master", false, true)
				else
					-- Sound kit without track time
					file, soundID = playlist[tracknumber]:match("([^,]+)%#([^,]+)")
					willPlay, musicHandle = PlaySound(soundID, "Master", false, true)
				end
				-- Cancel existing music timer for a sound file
				if LeaPlusLC.TrackTimer then LeaPlusLC.TrackTimer:Cancel() end
				if playlist[tracknumber]:match("([^,]+)%#([^,]+)%#([^,]+)") then
					-- Track is a sound file with track time so create track timer
					LeaPlusLC.TrackTimer = C_Timer.NewTimer(trackTime + 1, function()
						if musicHandle then StopSound(musicHandle) end
						if tracknumber == #playlist then
							-- Playlist is at the end, restart from first track
							tracknumber = 1
						end
						PlayTrack()
					end)
				end
				-- Store its handle for later use
				LastMusicHandle = musicHandle
				LastPlayed = playlist[tracknumber]
				tracknumber = tracknumber + 1
				-- Show static highlight bar
				for index = 1, numButtons do
					local button = scrollFrame.buttons[index]
					local item = button:GetText()
					if item then
						if item:match("([^,]+)%#([^,]+)%#([^,]+)") then
							-- Music file with track time
							local item, void, void = item:match("([^,]+)%#([^,]+)%#([^,]+)")
							if item then
								if item == file and LastFolder == TempFolder then
									button.s:Show()
								else
									button.s:Hide()
								end
							end
						else
							-- Sound kit without track time
							local item, void = item:match("([^,]+)%#([^,]+)")
							if item then
								if item == file and LastFolder == TempFolder then
									button.s:Show()
								else
									button.s:Hide()
								end
							end
						end
					end
				end
			end

			-- Create editbox for search
			local sBox = LeaPlusLC:CreateEditBox("MusicSearchBox", LeaPlusLC["Page9"], 78, 10, "TOPLEFT", 150, -(LeaPlusLC.MainPanelHeight - 110), "MusicSearchBox", "MusicSearchBox")
			sBox:SetMaxLetters(50)

			-- Position search button above editbox
			conbtn[L["Search"]]:ClearAllPoints()
			conbtn[L["Search"]]:SetPoint("BOTTOMLEFT", sBox, "TOPLEFT", -4, 0)

			-- Set initial search data
			for q, w in pairs(ZoneList) do
				if conbtn[w] then
					conbtn[w]:HookScript("OnClick", function()
						if w == L["Search"] then
							ListData[1] = "|cffffd800" .. L["Search"]
							if #ListData == 1 then
								ListData[2] = "|cffffffaa{" .. L["enter zone or track name"] .. "}"
							end
							UpdateList()
						else
							sBox:ClearFocus()
						end
					end)
				end
			end

			-- Function to show search results
			local function ShowSearchResults()
				-- Get unescaped editbox text
				local searchText = gsub(strlower(sBox:GetText()), '(['..("%^$().[]*+-?"):gsub("(.)", "%%%1")..'])', "%%%1")
				-- Wipe the track listing
				wipe(ListData)
				-- Set the track list heading
				ListData[1] = "|cffffd800" .. L["Search"]
				-- Show the subheading only if no search results are being shown
				if searchText == "" then
					ListData[2] = "|cffffffaa{" .. L["enter zone or track name"] .. "}"
				else
					ListData[2] = ""
				end
				-- Traverse music listing and populate ListData
				if searchText ~= "" then
					local word1, word2, word3, word4, word5 = strsplit(" ", (strtrim(searchText):gsub("%s+", " ")))
					local hash = {}
					local trackCount = 0
					for i, e in pairs(ZoneList) do
						if ZoneList[e] then
							for a, b in pairs(ZoneList[e]) do
								if b.tracks then
									for k, v in pairs(b.tracks) do
										if (strfind(v, "#") or strfind(v, "|r")) and (strfind(strlower(v), word1) or strfind(strlower(b.zone), word1) or strfind(strlower(b.category), word1)) then
											if not word2 or word2 ~= "" and (strfind(strlower(v), word2) or strfind(strlower(b.zone), word2) or strfind(strlower(b.category), word2)) then
												if not word3 or word3 ~= "" and (strfind(strlower(v), word3) or strfind(strlower(b.zone), word3) or strfind(strlower(b.category), word3)) then
													if not word4 or word4 ~= "" and (strfind(strlower(v), word4) or strfind(strlower(b.zone), word4) or strfind(strlower(b.category), word4)) then
														if not word5 or word5 ~= "" and (strfind(strlower(v), word5) or strfind(strlower(b.zone), word5) or strfind(strlower(b.category), word5)) then
															-- Show category
															if not hash[b.category] then
																tinsert(ListData, "|cffffffff")
																if b.category == e then
																	-- No category so just show ZoneList entry (such as Various)
																	tinsert(ListData, "|cffffd800" .. e)
																else
																	-- Category exists so show that
																	tinsert(ListData, "|cffffd800" .. e .. ": " .. b.category)
																end
																hash[b.category] = true
															end
															-- Show track
															tinsert(ListData, "|Cffffffaa" .. b.zone .. " |r" .. v)
															trackCount = trackCount + 1
															hash[v] = true
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end

					-- Set results tag
					if trackCount == 1 then
						ListData[2] = "|cffffffaa{" .. trackCount .. " " .. L["result"] .. "}"
					else
						ListData[2] = "|cffffffaa{" .. trackCount .. " " .. L["results"] .. "}"
					end
				end
				-- Refresh the track listing
				UpdateList()
				-- Set track listing to top
				scrollFrame:SetVerticalScroll(0)
			end

			-- Populate ListData when editbox is changed by user
			sBox:HookScript("OnTextChanged", function(self, userInput)
				if userInput then
					-- Show search page
					conbtn[L["Search"]]:Click()
					-- If search results are currently playing, stop playback since search results will be changed
					if LastFolder == L["Search"] then stopBtn:Click() end
					-- Show search results
					ShowSearchResults()
				end
			end)

			-- Populate ListData when editbox enter key is pressed
			sBox:HookScript("OnEnterPressed", function()
				-- Show search page
				conbtn[L["Search"]]:Click()
				-- If search results are currently playing, stop playback since search results will be changed
				if LastFolder == L["Search"] then stopBtn:Click() end
				-- Show search results
				ShowSearchResults()
			end)

			-- Function to show random track listing
			local function ShowRandomList()
				-- If random track is currently playing, stop playback since random track list will be changed
				if LastFolder == L["Random"] then
					stopBtn:Click()
				end
				-- Wipe the track listing for random
				wipe(ListData)
				-- Set the track list heading
				ListData[1] = "|cffffd800" .. L["Random"]
				ListData[2] = "|Cffffffaa{" .. L["click here for new selection"] .. "}" -- Must be capital |C
				ListData[3] = "|cffffd800"
				ListData[4] = "|cffffd800" .. L["Selection of music tracks"] -- Must be lower case |c
				-- Populate list data until it contains desired number of tracks
				while #ListData < 50 do
					-- Get random category
					local rCategory = GetRandomArgument(L["Zones"], L["Dungeons"], L["Various"])
					-- Get random zone within category
					local rZone = random(1, #ZoneList[rCategory])
					-- Get random track within zone
					local rTrack = ZoneList[rCategory][rZone].tracks[random(1, #ZoneList[rCategory][rZone].tracks)]
					-- Insert track into ListData if it's not a duplicate or on the banned list
					if rTrack and rTrack ~= "" and strfind(rTrack, "#") and not tContains(ListData, "|Cffffffaa" .. ZoneList[rCategory][rZone].zone .. " |r" .. rTrack) then
						if not tContains(randomBannedList, L[ZoneList[rCategory][rZone].zone]) and not tContains(randomBannedList, rTrack) then
							tinsert(ListData, "|Cffffffaa" .. ZoneList[rCategory][rZone].zone .. " |r" .. rTrack)
						end
					end
				end
				-- Refresh the track listing
				UpdateList()
				-- Set track listing to top
				scrollFrame:SetVerticalScroll(0)
			end

			-- Show random track listing on startup when random button is clicked
			for q, w in pairs(ZoneList) do
				if conbtn[w] then
					conbtn[w]:HookScript("OnClick", function()
						if w == L["Random"] then
							-- Generate initial playlist for first run
							if #ListData == 0 then
								ShowRandomList()
							end
						end
					end)
				end
			end

			-- Create list items
			scrollFrame.buttons = {}
			for i = 1, numButtons do
				scrollFrame.buttons[i] = CreateFrame("Button", nil, LeaPlusLC["Page9"])
				local button = scrollFrame.buttons[i]

				button:SetSize(470 - 14, 16)
				button:SetNormalFontObject("GameFontHighlightLeft")
				button:SetPoint("TOPLEFT", 246, -62+ -(i - 1) * 16 - 8)

				-- Create highlight bar texture
				button.t = button:CreateTexture(nil, "BACKGROUND")
				button.t:SetPoint("TOPLEFT", button, 0, 0)
				button.t:SetSize(516, 16)

				button.t:SetColorTexture(0.3, 0.3, 0.0, 0.8)
				button.t:SetAlpha(0.7)
				button.t:Hide()

				-- Create last playing highlight bar texture
				button.s = button:CreateTexture(nil, "BACKGROUND")
				button.s:SetPoint("TOPLEFT", button, 0, 0)
				button.s:SetSize(516, 16)

				button.s:SetColorTexture(0.3, 0.4, 0.00, 0.6)
				button.s:Hide()

				button:SetScript("OnEnter", function()
					-- Highlight links only
					if not string.match(button:GetText() or "", "|c") then
						button.t:Show()
					end
				end)

				button:SetScript("OnLeave", function()
					button.t:Hide()
				end)

				button:RegisterForClicks("LeftButtonUp", "RightButtonUp")

				-- Handler for playing next SoundKit track in playlist
				uframe:SetScript("OnEvent", function(self, event, stoppedHandle)
					if event == "SOUNDKIT_FINISHED" then
						-- Do nothing if stopped sound kit handle doesnt match last played track handle
						if LastMusicHandle and LastMusicHandle ~= stoppedHandle then return end
						-- Reset track number if playlist has reached the end
						if tracknumber == #playlist then tracknumber = 1 end
						-- Play next track
						PlayTrack()
					elseif event == "LOADING_SCREEN_DISABLED" then
						-- Restart player if it stopped between tracks during loading screen
						if playlist and tracknumber and playlist[tracknumber] and not willPlay and not musicHandle then
							tracknumber = tracknumber - 1
							C_Timer.After(0.1, PlayTrack)
						end
					end
				end)

				-- Click handler for track, zone and back button
				button:SetScript("OnClick", function(self, btn)
					if btn == "LeftButton" then
						-- Remove focus from search box
						sBox:ClearFocus()
						-- Get clicked track text
						local item = self:GetText()
						-- Do nothing if its a blank line or informational heading
						if not item or strfind(item, "|c") then return end
						if item == "|Cffffffaa{" .. L["click here for new selection"] .. "}" then -- must be capital |C
							-- Create new random track listing
							ShowRandomList()
							return
						elseif strfind(item, "#") then
							-- Enable sound if required
							if GetCVar("Sound_EnableAllSound") == "0" then SetCVar("Sound_EnableAllSound", "1") end
							-- Disable music if it's currently enabled
							if GetCVar("Sound_EnableMusic") == "1" then	SetCVar("Sound_EnableMusic", "0") end
							-- Add all tracks to playlist
							wipe(playlist)
							local StartItem = 0
							-- Get item clicked row number
							for index = 1, #ListData do
								local item = ListData[index]
								if self:GetText() == item then StartItem = index end
							end
							-- Add all items from clicked item onwards to playlist
							for index = StartItem, #ListData do
								local item = ListData[index]
								if item then
									if strfind(item, "#") then
										tinsert(playlist, item)
									end
								end
							end
							-- Add all items up to clicked item to playlist
							for index = 1, StartItem do
								local item = ListData[index]
								if item then
									if strfind(item, "#") then
										tinsert(playlist, item)
									end
								end
							end
							-- Enable the stop button
							LeaPlusLC:LockItem(stopBtn, false)
							-- Set Temp Folder to Random if track is in Random
							if ListData[1] == "|cffffd800" .. L["Random"] then TempFolder = L["Random"] end
							-- Set Temp Folder to Search if track is in Search
							if ListData[1] == "|cffffd800" .. L["Search"] then TempFolder = L["Search"] end
							-- Store information about the track we are about to play
							tracknumber = 1
							LastPlayed = item
							LastFolder = TempFolder
							HeadingOfClickedTrack = ListData[1]
							-- Play first track
							PlayTrack()
							-- Play subsequent tracks
							uframe:RegisterEvent("SOUNDKIT_FINISHED")
							uframe:RegisterEvent("LOADING_SCREEN_DISABLED")
							return
						elseif strfind(item, "|r") then
							-- A movie was clicked
							local movieName, movieID = item:match("([^,]+)%|r([^,]+)")
							movieID = strtrim(movieID, "()")
							if IsMoviePlayable(movieID) then
								stopBtn:Click()
								MovieFrame_PlayMovie(MovieFrame, movieID)
							else
								LeaPlusLC:Print("Movie not playable.")
							end
							return
						else
							-- A zone was clicked so show track listing
							ZonePage = scrollFrame:GetVerticalScroll()
							-- Find the track listing for the clicked zone
							for q, w in pairs(ZoneList) do
								for k, v in pairs(ZoneList[w]) do
									if item == v.zone then
										-- Show track listing
										TempFolder = item
										LeaPlusDB["MusicZone"] = item
										ListData = v.tracks
										UpdateList()
										-- Hide hover highlight if track under pointer is a heading
										if strfind(scrollFrame.buttons[i]:GetText(), "|c") then
											scrollFrame.buttons[i].t:Hide()
										end
										-- Show top of track list
										scrollFrame:SetVerticalScroll(0)
										return
									end
								end
							end
						end
					elseif btn == "RightButton" then
						-- Back button was clicked
						BackClick()
					end
				end)

			end

			-- Right-click to go back (from anywhere on the main content area of the panel)
			LeaPlusLC["PageF"]:HookScript("OnMouseUp", function(self, btn)
				if LeaPlusLC["Page9"]:IsShown() and LeaPlusLC["Page9"]:IsMouseOver(0, 0, 0, -440) == false and LeaPlusLC["Page9"]:IsMouseOver(-(LeaPlusLC.MainPanelHeight - 47), 0, 0, 0) == false then
					if btn == "RightButton" then
						BackClick()
					end
				end
			end)

			-- Delete the global scroll frame pointer
			_G.LeaPlusScrollFrame = nil

			-- Set zone listing on startup
			if LeaPlusDB["MusicContinent"] and LeaPlusDB["MusicContinent"] ~= "" then
				-- Saved music continent exists
				if conbtn[LeaPlusDB["MusicContinent"]] then
					-- Saved continent is valid button so click it
					conbtn[LeaPlusDB["MusicContinent"]]:Click()
				else
					-- Saved continent is not valid button so click default button
					conbtn[L["Zones"]]:Click()
				end
			else
				-- Saved music continent does not exist so click default button
				conbtn[L["Zones"]]:Click()
			end
			UpdateList()

			-- Manage events
			LeaPlusLC["Page9"]:RegisterEvent("PLAYER_LOGOUT")
			LeaPlusLC["Page9"]:RegisterEvent("UI_SCALE_CHANGED")
			LeaPlusLC["Page9"]:SetScript("OnEvent", function(self, event)
				if event == "PLAYER_LOGOUT" then
					-- Stop playing at reload or logout
					if musicHandle then
						StopSound(musicHandle)
					end
				elseif event == "UI_SCALE_CHANGED" then
					-- Refresh list
					UpdateList()
				end
			end)

		end

		-- Run on startup
		LeaPlusLC:MediaFunc()

		-- Release memory
		LeaPlusLC.MediaFunc = nil

		----------------------------------------------------------------------
		-- Panel alpha (no reload required)
		----------------------------------------------------------------------

		do

			-- Function to set panel alpha
			local function SetPlusAlpha()
				-- Set panel alpha
				LeaPlusLC["PageF"].t:SetAlpha(1 - LeaPlusLC["PlusPanelAlpha"])
				-- Show formatted value
				LeaPlusCB["PlusPanelAlpha"].f:SetFormattedText("%.0f%%", LeaPlusLC["PlusPanelAlpha"] * 100)
			end

			-- Set alpha on startup
			SetPlusAlpha()

			-- Set alpha after changing slider
			LeaPlusCB["PlusPanelAlpha"]:HookScript("OnValueChanged", SetPlusAlpha)

		end

		----------------------------------------------------------------------
		-- Panel scale (no reload required)
		----------------------------------------------------------------------

		do

			-- Function to set panel scale
			local function SetPlusScale()
				-- Reset panel position
				LeaPlusLC["MainPanelA"], LeaPlusLC["MainPanelR"], LeaPlusLC["MainPanelX"], LeaPlusLC["MainPanelY"] = "CENTER", "CENTER", 0, 0
				if LeaPlusLC["PageF"]:IsShown() then
					LeaPlusLC["PageF"]:Hide()
					LeaPlusLC["PageF"]:Show()
				end
				-- Set panel scale
				LeaPlusLC["PageF"]:SetScale(LeaPlusLC["PlusPanelScale"])
				-- Update music player highlight bar scale
				LeaPlusLC:UpdateList()
			end

			-- Set scale on startup
			LeaPlusLC["PageF"]:SetScale(LeaPlusLC["PlusPanelScale"])

			-- Set scale and reset panel position after changing slider
			LeaPlusCB["PlusPanelScale"]:HookScript("OnMouseUp", SetPlusScale)
			LeaPlusCB["PlusPanelScale"]:HookScript("OnMouseWheel", SetPlusScale)

			-- Show formatted slider value
			LeaPlusCB["PlusPanelScale"]:HookScript("OnValueChanged", function()
				LeaPlusCB["PlusPanelScale"].f:SetFormattedText("%.0f%%", LeaPlusLC["PlusPanelScale"] * 100)
			end)

		end

		----------------------------------------------------------------------
		-- Create panel in game options panel
		----------------------------------------------------------------------

		do

			local interPanel = CreateFrame("FRAME")
			interPanel.name = "Leatrix Plus"

			local maintitle = LeaPlusLC:MakeTx(interPanel, "Leatrix Plus", 0, 0)
			maintitle:SetFont(maintitle:GetFont(), 72)
			maintitle:ClearAllPoints()
			maintitle:SetPoint("TOP", 0, -72)

			local expTitle = LeaPlusLC:MakeTx(interPanel, L["Mists of Pandaria Classic"], 0, 0)
			expTitle:SetFont(expTitle:GetFont(), 32)
			expTitle:ClearAllPoints()
			expTitle:SetPoint("TOP", 0, -152)

			local subTitle = LeaPlusLC:MakeTx(interPanel, "curseforge.com/wow/addons/leatrix-plus", 0, 0)
			subTitle:SetFont(subTitle:GetFont(), 20)
			subTitle:ClearAllPoints()
			subTitle:SetPoint("BOTTOM", 0, 72)

			local slashTitle = LeaPlusLC:MakeTx(interPanel, "/ltp", 0, 0)
			slashTitle:SetFont(slashTitle:GetFont(), 72)
			slashTitle:ClearAllPoints()
			slashTitle:SetPoint("BOTTOM", subTitle, "TOP", 0, 40)
			slashTitle:SetScript("OnMouseUp", function(self, button)
				if button == "LeftButton" then
					SlashCmdList["Leatrix_Plus"]("")
				end
			end)
			slashTitle:SetScript("OnEnter", function()
				slashTitle.r,  slashTitle.g, slashTitle.b = slashTitle:GetTextColor()
				slashTitle:SetTextColor(1, 1, 0)
			end)
			slashTitle:SetScript("OnLeave", function()
				slashTitle:SetTextColor(slashTitle.r, slashTitle.g, slashTitle.b)
			end)

			local pTex = interPanel:CreateTexture(nil, "BACKGROUND")
			pTex:SetAllPoints()
			pTex:SetTexture("Interface\\GLUES\\Models\\UI_MainMenu\\swordgradient2")
			pTex:SetAlpha(0.2)
			pTex:SetTexCoord(0, 1, 1, 0)

			local category = Settings.RegisterCanvasLayoutCategory(interPanel, L["Leatrix Plus"])
			Settings.RegisterAddOnCategory(category)

		end

		----------------------------------------------------------------------
		-- Final code for Player
		----------------------------------------------------------------------

		-- Show first run message
		if not LeaPlusDB["FirstRunMessageSeen"] then
			C_Timer.After(1, function()
				LeaPlusLC:Print(L["Enter"] .. " |cff00ff00" .. "/ltp" .. "|r " .. L["or click the minimap button to open Leatrix Plus."])
				LeaPlusDB["FirstRunMessageSeen"] = true
			end)
		end

		-- Register logout event to save settings
		LpEvt:RegisterEvent("PLAYER_LOGOUT")

		-- Update addon memory usage (speeds up initial value)
		UpdateAddOnMemoryUsage()

		-- Release memory
		LeaPlusLC.Player = nil

	end

----------------------------------------------------------------------
-- 	L60: Default events
----------------------------------------------------------------------

	local function eventHandler(self, event, arg1, arg2, ...)

		----------------------------------------------------------------------
		-- L62: Profile events
		----------------------------------------------------------------------

		if event == "ADDON_LOADED" then
			if arg1 == "Leatrix_Plus" then

				-- Replace old var names with new ones
				local function UpdateVars(oldvar, newvar)
					if LeaPlusDB[oldvar] and not LeaPlusDB[newvar] then LeaPlusDB[newvar] = LeaPlusDB[oldvar]; LeaPlusDB[oldvar] = nil end
				end

				UpdateVars("MuteStriders", "MuteMechSteps")					-- 2.5.108 (1st June 2022)
				UpdateVars("MinimapMod", "MinimapModder")					-- 2.5.120 (24th August 2022)
				UpdateVars("ShowVendorPrice", "ExpandVendorPrice")			-- 4.0.67 (5th May 2025)

				-- Mute game sounds split with Mute mount sounds
				if LeaPlusDB["MuteGameSounds"] == "On" and not LeaPlusDB["MuteMountSounds"] then
					if LeaPlusDB["MuteBikes"] == "On"
					or LeaPlusDB["MuteBrooms"] == "On"
					or LeaPlusDB["MuteGyrocopters"] == "On"
					or LeaPlusDB["MuteHorsesteps"] == "On"
					or LeaPlusDB["MuteMechSteps"] == "On"
					or LeaPlusDB["MuteStriders"] == "On"
					or LeaPlusDB["MuteNetherdrakes"] == "On"
					or LeaPlusDB["MuteTravelers"] == "On"
					then
						LeaPlusLC["MuteMountSounds"] = "On"
						LeaPlusDB["MuteMountSounds"] = "On"
					end
				end

				-- Automation
				LeaPlusLC:LoadVarChk("AutomateQuests", "Off")				-- Automate quests
				LeaPlusLC:LoadVarChk("AutoQuestShift", "Off")				-- Automate quests requires shift
				LeaPlusLC:LoadVarChk("AutoQuestAvailable", "On")			-- Accept available quests
				LeaPlusLC:LoadVarChk("AutoQuestCompleted", "On")			-- Turn-in completed quests
				LeaPlusLC:LoadVarNum("AutoQuestKeyMenu", 1, 1, 4)			-- Automate quests override key
				LeaPlusLC:LoadVarChk("AutomateGossip", "Off")				-- Automate gossip
				LeaPlusLC:LoadVarChk("AutoAcceptSummon", "Off")				-- Accept summon
				LeaPlusLC:LoadVarChk("AutoAcceptRes", "Off")				-- Accept resurrection
				LeaPlusLC:LoadVarChk("AutoResNoCombat", "On")				-- Accept resurrection exclude combat
				LeaPlusLC:LoadVarChk("AutoReleasePvP", "Off")				-- Release in PvP
				LeaPlusLC:LoadVarChk("AutoReleaseNoAlterac", "Off")			-- Release in PvP Exclude Alterac Valley
				LeaPlusLC:LoadVarChk("AutoReleaseGilneas", "Off")			-- Release in PvP Exclude Battle for Gilneas
				LeaPlusLC:LoadVarChk("AutoReleaseConquest", "Off")			-- Release in PvP Exclude Isle of Conquest
				LeaPlusLC:LoadVarChk("AutoReleaseSilvershard", "Off")		-- Release in PvP Exclude Silvershard Mines
				LeaPlusLC:LoadVarChk("AutoReleaseKotmogu", "Off")			-- Release in PvP Exclude Temple of Kotmogu
				LeaPlusLC:LoadVarChk("AutoReleaseNoWintergsp", "Off")		-- Release in PvP Exclude Wintergrasp
				LeaPlusLC:LoadVarNum("AutoReleaseDelay", 200, 200, 3000)	-- Release in PvP Delay

				LeaPlusLC:LoadVarChk("AutoSellJunk", "Off")					-- Sell junk automatically
				LeaPlusLC:LoadVarChk("AutoSellShowSummary", "On")			-- Sell junk summary in chat
				LeaPlusLC:LoadVarStr("AutoSellExcludeList", "")				-- Sell junk exclude list
				LeaPlusLC:LoadVarChk("AutoRepairGear", "Off")				-- Repair automatically
				LeaPlusLC:LoadVarChk("AutoRepairGuildFunds", "On")			-- Repair using guild funds
				LeaPlusLC:LoadVarChk("AutoRepairShowSummary", "On")			-- Repair show summary in chat

				-- Social
				LeaPlusLC:LoadVarChk("NoDuelRequests", "Off")				-- Block duels
				LeaPlusLC:LoadVarChk("NoPetDuels", "Off")					-- Block pet battle duels
				LeaPlusLC:LoadVarChk("NoPartyInvites", "Off")				-- Block party invites
				LeaPlusLC:LoadVarChk("NoRequestedInvites", "Off")			-- Block requested invites
				LeaPlusLC:LoadVarChk("NoFriendRequests", "Off")				-- Block friend requests
				LeaPlusLC:LoadVarChk("NoSharedQuests", "Off")				-- Block shared quests

				LeaPlusLC:LoadVarChk("AcceptPartyFriends", "Off")			-- Party from friends
				LeaPlusLC:LoadVarChk("AutoConfirmRole", "Off")				-- Queue from friends
				LeaPlusLC:LoadVarChk("InviteFromWhisper", "Off")			-- Invite from whispers
				LeaPlusLC:LoadVarChk("InviteFriendsOnly", "Off")			-- Restrict invites to friends
				LeaPlusLC["InvKey"]	= LeaPlusDB["InvKey"] or "inv"			-- Invite from whisper keyword
				LeaPlusLC:LoadVarChk("FriendlyGuild", "On")					-- Friendly guild

				-- Chat
				LeaPlusLC:LoadVarChk("UseEasyChatResizing", "Off")			-- Use easy resizing
				LeaPlusLC:LoadVarChk("NoCombatLogTab", "Off")				-- Hide the combat log
				LeaPlusLC:LoadVarChk("NoChatButtons", "Off")				-- Hide chat buttons
				LeaPlusLC:LoadVarChk("UnclampChat", "Off")					-- Unclamp chat frame
				LeaPlusLC:LoadVarChk("MoveChatEditBoxToTop", "Off")			-- Move editbox to top
				LeaPlusLC:LoadVarChk("MoreFontSizes", "Off")				-- More font sizes

				LeaPlusLC:LoadVarChk("NoStickyChat", "Off")					-- Disable sticky chat
				LeaPlusLC:LoadVarChk("UseArrowKeysInChat", "Off")			-- Use arrow keys in chat
				LeaPlusLC:LoadVarChk("NoChatFade", "Off")					-- Disable chat fade
				LeaPlusLC:LoadVarChk("UnivGroupColor", "Off")				-- Universal group color
				LeaPlusLC:LoadVarChk("ClassColorsInChat", "Off")			-- Use class colors in chat
				LeaPlusLC:LoadVarChk("RecentChatWindow", "Off")				-- Recent chat window
				LeaPlusLC:LoadVarNum("RecentChatSize", 170, 170, 600)		-- Recent chat size
				LeaPlusLC:LoadVarChk("MaxChatHstory", "Off")				-- Increase chat history
				LeaPlusLC:LoadVarChk("FilterChatMessages", "Off")			-- Filter chat messages
				LeaPlusLC:LoadVarChk("BlockSpellLinks", "Off")				-- Block spell links
				LeaPlusLC:LoadVarChk("BlockDrunkenSpam", "Off")				-- Block drunken spam
				LeaPlusLC:LoadVarChk("BlockDuelSpam", "Off")				-- Block duel spam
				LeaPlusLC:LoadVarChk("BlockGuildAnnounce", "Off")			-- Block guild announcements
				LeaPlusLC:LoadVarChk("RestoreChatMessages", "Off")			-- Restore chat messages

				-- Text
				LeaPlusLC:LoadVarChk("HideErrorMessages", "Off")			-- Hide error messages
				LeaPlusLC:LoadVarChk("NoHitIndicators", "Off")				-- Hide portrait text
				LeaPlusLC:LoadVarChk("HideZoneText", "Off")					-- Hide zone text
				LeaPlusLC:LoadVarChk("HideKeybindText", "Off")				-- Hide keybind text
				LeaPlusLC:LoadVarChk("HideMacroText", "Off")				-- Hide macro text
				LeaPlusLC:LoadVarChk("HideRaidGroupLabels", "Off")			-- Hide raid group labels

				LeaPlusLC:LoadVarChk("MailFontChange", "Off")				-- Resize mail text
				LeaPlusLC:LoadVarNum("LeaPlusMailFontSize", 15, 10, 30)		-- Mail text slider

				LeaPlusLC:LoadVarChk("QuestFontChange", "Off")				-- Resize quest text
				LeaPlusLC:LoadVarNum("LeaPlusQuestFontSize", 12, 10, 30)	-- Quest text slider

				LeaPlusLC:LoadVarChk("BookFontChange", "Off")				-- Resize book text
				LeaPlusLC:LoadVarNum("LeaPlusBookFontSize", 15, 10, 30)		-- Book text slider

				-- Interface
				LeaPlusLC:LoadVarChk("MinimapModder", "Off")				-- Enhance minimap
				LeaPlusLC:LoadVarChk("SquareMinimap", "Off")				-- Square minimap
				LeaPlusLC:LoadVarChk("ShowWhoPinged", "On")					-- Show who pinged
				LeaPlusLC:LoadVarChk("CombineAddonButtons", "Off")			-- Combine addon buttons
				LeaPlusLC:LoadVarStr("MiniExcludeList", "")					-- Minimap exclude list
				LeaPlusLC:LoadVarChk("HideMiniZoomBtns", "Off")				-- Hide zoom buttons
				LeaPlusLC:LoadVarChk("HideMiniZoneText", "Off")				-- Hide the zone text bar
				LeaPlusLC:LoadVarChk("HideMiniAddonButtons", "On")			-- Hide addon buttons
				LeaPlusLC:LoadVarChk("HideMiniMapButton", "On")				-- Hide the world map button
				LeaPlusLC:LoadVarChk("HideMiniTracking", "Off")				-- Hide the tracking button
				LeaPlusLC:LoadVarNum("MinimapScale", 1, 0.5, 4)				-- Minimap scale slider
				LeaPlusLC:LoadVarNum("MinimapSize", 140, 140, 560)			-- Minimap size slider
				LeaPlusLC:LoadVarNum("MinimapBorderWidth", 3, 1, 10)		-- Minimap border width
				LeaPlusLC:LoadVarNum("MiniClusterScale", 1, 1, 2)			-- Minimap cluster scale
				LeaPlusLC:LoadVarChk("MinimapNoScale", "Off")				-- Minimap not minimap
				LeaPlusLC:LoadVarAnc("MinimapA", "TOPRIGHT")				-- Minimap anchor
				LeaPlusLC:LoadVarAnc("MinimapR", "TOPRIGHT")				-- Minimap relative
				LeaPlusLC:LoadVarNum("MinimapX", -17, -5000, 5000)			-- Minimap X
				LeaPlusLC:LoadVarNum("MinimapY", -22, -5000, 5000)			-- Minimap Y
				LeaPlusLC:LoadVarChk("TipModEnable", "Off")					-- Enhance tooltip
				LeaPlusLC:LoadVarChk("TipShowRank", "On")					-- Show rank
				LeaPlusLC:LoadVarChk("TipShowOtherRank", "Off")				-- Show rank for other guilds
				LeaPlusLC:LoadVarChk("TipShowTarget", "On")					-- Show target
				LeaPlusLC:LoadVarChk("TipHideInCombat", "Off")				-- Hide tooltips during combat
				LeaPlusLC:LoadVarChk("TipHideShiftOverride", "On")			-- Hide tooltips shift override
				LeaPlusLC:LoadVarChk("TipNoHealthBar", "Off")				-- Hide health bar
				LeaPlusLC:LoadVarNum("LeaPlusTipSize", 1.00, 0.50, 2.00)	-- Tooltip scale slider
				LeaPlusLC:LoadVarNum("TipOffsetX", -13, -5000, 5000)		-- Tooltip X offset
				LeaPlusLC:LoadVarNum("TipOffsetY", 94, -5000, 5000)			-- Tooltip Y offset
				LeaPlusLC:LoadVarNum("TooltipAnchorMenu", 1, 1, 5)			-- Tooltip anchor menu
				LeaPlusLC:LoadVarNum("TipCursorX", 0, -128, 128)			-- Tooltip cursor X offset
				LeaPlusLC:LoadVarNum("TipCursorY", 0, -128, 128)			-- Tooltip cursor Y offset

				LeaPlusLC:LoadVarChk("EnhanceDressup", "Off")				-- Enhance dressup
				LeaPlusLC:LoadVarChk("DressupItemButtons", "On")			-- Dressup item buttons
				LeaPlusLC:LoadVarChk("DressupAnimControl", "On")			-- Dressup animation control
				LeaPlusLC:LoadVarChk("DressupWiderPreview", "On")			-- Dressup wider character preview
				LeaPlusLC:LoadVarChk("DressupTransmogAnim", "Off")			-- Dressup show transmogrify animation control
				LeaPlusLC:LoadVarNum("DressupFasterZoom", 3, 1, 10)			-- Dressup zoom speed
				LeaPlusLC:LoadVarChk("HideDressupStats", "Off")				-- Hide dressup stats
				LeaPlusLC:LoadVarChk("EnhanceQuestLog", "Off")				-- Enhance quest log
				LeaPlusLC:LoadVarChk("EnhanceQuestHeaders", "On")			-- Enhance quest log toggle headers
				LeaPlusLC:LoadVarChk("EnhanceQuestLevels", "On")			-- Enhance quest log quest levels
				LeaPlusLC:LoadVarChk("EnhanceQuestDifficulty", "On")		-- Enhance quest log quest difficulty
				LeaPlusLC:LoadVarChk("EnhanceProfessions", "Off")			-- Enhance professions
				LeaPlusLC:LoadVarChk("EnhanceTrainers", "Off")				-- Enhance trainers
				LeaPlusLC:LoadVarChk("ShowTrainAllBtn", "On")				-- Enhance trainers train all button
				LeaPlusLC:LoadVarChk("EnhanceFlightMap", "Off")				-- Enhance flight map
				LeaPlusLC:LoadVarNum("LeaPlusTaxiMapScale", 1.9, 1, 3)		-- Enhance flight map scale
				LeaPlusLC:LoadVarNum("LeaPlusTaxiIconSize", 16, 8, 48)		-- Enhance flight icon size
				LeaPlusLC:LoadVarAnc("FlightMapA", "TOPLEFT")				-- Enhance flight map anchor
				LeaPlusLC:LoadVarAnc("FlightMapR", "TOPLEFT")				-- Enhance flight map relative
				LeaPlusLC:LoadVarNum("FlightMapX", 0, -5000, 5000)			-- Enhance flight map X
				LeaPlusLC:LoadVarNum("FlightMapY", 61, -5000, 5000)			-- Enhance flight map Y
				LeaPlusLC:LoadVarChk("ShowVolume", "Off")					-- Show volume slider

				LeaPlusLC:LoadVarChk("ShowCooldowns", "Off")				-- Show cooldowns
				LeaPlusLC:LoadVarChk("ShowCooldownID", "On")				-- Show cooldown ID in tips
				LeaPlusLC:LoadVarChk("NoCooldownDuration", "On")			-- Hide cooldown duration
				LeaPlusLC:LoadVarChk("CooldownsOnPlayer", "Off")			-- Anchor to player
				LeaPlusLC:LoadVarChk("DurabilityStatus", "Off")				-- Show durability status
				LeaPlusLC:LoadVarChk("ShowPetSaveBtn", "Off")				-- Show pet save button
				LeaPlusLC:LoadVarChk("ShowVanityControls", "Off")			-- Show vanity controls
				LeaPlusLC:LoadVarChk("VanityAltLayout", "Off")				-- Vanity alternative layout
				LeaPlusLC:LoadVarChk("ShowRaidToggle", "Off")				-- Show raid button
				LeaPlusLC:LoadVarChk("ShowBorders", "Off")					-- Show borders
				LeaPlusLC:LoadVarNum("BordersTop", 0, 0, 300)				-- Top border
				LeaPlusLC:LoadVarNum("BordersBottom", 0, 0, 300)			-- Bottom border
				LeaPlusLC:LoadVarNum("BordersLeft", 0, 0, 300)				-- Left border
				LeaPlusLC:LoadVarNum("BordersRight", 0, 0, 300)				-- Right border
				LeaPlusLC:LoadVarNum("BordersAlpha", 0, 0, 0.9)				-- Border alpha
				LeaPlusLC:LoadVarChk("ShowPlayerChain", "Off")				-- Show player chain
				LeaPlusLC:LoadVarNum("PlayerChainMenu", 2, 1, 3)			-- Player chain dropdown value
				LeaPlusLC:LoadVarChk("ShowReadyTimer", "Off")				-- Show ready timer
				LeaPlusLC:LoadVarChk("ShowWowheadLinks", "Off")				-- Show Wowhead links
				LeaPlusLC:LoadVarChk("WowheadLinkComments", "Off")			-- Show Wowhead links to comments

				-- Frames
				LeaPlusLC:LoadVarChk("FrmEnabled", "Off")					-- Manage frames

				LeaPlusLC:LoadVarChk("ManageBuffs", "Off")					-- Manage buffs
				LeaPlusLC:LoadVarAnc("BuffFrameA", "TOPRIGHT")				-- Manage buffs anchor
				LeaPlusLC:LoadVarAnc("BuffFrameR", "TOPRIGHT")				-- Manage buffs relative
				LeaPlusLC:LoadVarNum("BuffFrameX", -205, -5000, 5000)		-- Manage buffs position X
				LeaPlusLC:LoadVarNum("BuffFrameY", -13, -5000, 5000)		-- Manage buffs position Y
				LeaPlusLC:LoadVarNum("BuffFrameScale", 1, 0.5, 2)			-- Manage buffs scale

				LeaPlusLC:LoadVarChk("ManageWidget", "Off")					-- Manage widget
				LeaPlusLC:LoadVarAnc("WidgetA", "TOP")						-- Manage widget anchor
				LeaPlusLC:LoadVarAnc("WidgetR", "TOP")						-- Manage widget relative
				LeaPlusLC:LoadVarNum("WidgetX", 0, -5000, 5000)				-- Manage widget position X
				LeaPlusLC:LoadVarNum("WidgetY", -15, -5000, 5000)			-- Manage widget position Y
				LeaPlusLC:LoadVarNum("WidgetScale", 1, 0.5, 2)				-- Manage widget scale

				LeaPlusLC:LoadVarChk("ManageFocus", "Off")					-- Manage focus
				LeaPlusLC:LoadVarAnc("FocusA", "CENTER")					-- Manage focus anchor
				LeaPlusLC:LoadVarAnc("FocusR", "CENTER")					-- Manage focus relative
				LeaPlusLC:LoadVarNum("FocusX", 0, -5000, 5000)				-- Manage focus position X
				LeaPlusLC:LoadVarNum("FocusY", 0, -5000, 5000)				-- Manage focus position Y
				LeaPlusLC:LoadVarNum("FocusScale", 1, 0.5, 2)				-- Manage focus scale

				LeaPlusLC:LoadVarChk("ManageTimer", "Off")					-- Manage timer
				LeaPlusLC:LoadVarAnc("TimerA", "TOP")						-- Manage timer anchor
				LeaPlusLC:LoadVarAnc("TimerR", "TOP")						-- Manage timer relative
				LeaPlusLC:LoadVarNum("TimerX", -5, -5000, 5000)				-- Manage timer position X
				LeaPlusLC:LoadVarNum("TimerY", -96, -5000, 5000)			-- Manage timer position Y
				LeaPlusLC:LoadVarNum("TimerScale", 1, 0.5, 2)				-- Manage timer scale

				LeaPlusLC:LoadVarChk("ManageDurability", "Off")				-- Manage durability
				LeaPlusLC:LoadVarAnc("DurabilityA", "TOPRIGHT")				-- Manage durability anchor
				LeaPlusLC:LoadVarAnc("DurabilityR", "TOPRIGHT")				-- Manage durability relative
				LeaPlusLC:LoadVarNum("DurabilityX", 0, -5000, 5000)			-- Manage durability position X
				LeaPlusLC:LoadVarNum("DurabilityY", -192, -5000, 5000)		-- Manage durability position Y
				LeaPlusLC:LoadVarNum("DurabilityScale", 1, 0.5, 2)			-- Manage durability scale

				LeaPlusLC:LoadVarChk("ManageVehicle", "Off")				-- Manage vehicle
				LeaPlusLC:LoadVarAnc("VehicleA", "TOPRIGHT")				-- Manage vehicle anchor
				LeaPlusLC:LoadVarAnc("VehicleR", "TOPRIGHT")				-- Manage vehicle relative
				LeaPlusLC:LoadVarNum("VehicleX", -100, -5000, 5000)			-- Manage vehicle position X
				LeaPlusLC:LoadVarNum("VehicleY", -192, -5000, 5000)			-- Manage vehicle position Y
				LeaPlusLC:LoadVarNum("VehicleScale", 1, 0.5, 2)				-- Manage vehicle scale

				LeaPlusLC:LoadVarChk("ClassColFrames", "Off")				-- Class colored frames
				LeaPlusLC:LoadVarChk("ClassColPlayer", "On")				-- Class colored player frame
				LeaPlusLC:LoadVarChk("ClassColTarget", "On")				-- Class colored target frame

				LeaPlusLC:LoadVarChk("NoAlerts", "Off")						-- Hide alerts
				LeaPlusLC:LoadVarChk("NoGryphons", "Off")					-- Hide gryphons
				LeaPlusLC:LoadVarChk("HideEventToasts", "Off")				-- Hide event toasts
				LeaPlusLC:LoadVarChk("NoClassBar", "Off")					-- Hide stance bar

				-- System
				LeaPlusLC:LoadVarChk("NoScreenGlow", "Off")					-- Disable screen glow
				LeaPlusLC:LoadVarChk("NoScreenEffects", "Off")				-- Disable screen effects
				LeaPlusLC:LoadVarChk("SetWeatherDensity", "Off")			-- Set weather density
				LeaPlusLC:LoadVarNum("WeatherLevel", 3, 0, 3)				-- Weather density level
				LeaPlusLC:LoadVarChk("MaxCameraZoom", "Off")				-- Max camera zoom

				LeaPlusLC:LoadVarChk("NoRestedEmotes", "Off")				-- Silence rested emotes
				LeaPlusLC:LoadVarChk("KeepAudioSynced", "Off")				-- Keep audio synced
				LeaPlusLC:LoadVarChk("MuteGameSounds", "Off")				-- Mute game sounds
				LeaPlusLC:LoadVarChk("MuteMountSounds", "Off")				-- Mute mount sounds
				LeaPlusLC:LoadVarChk("MuteCustomSounds", "Off")				-- Mute custom sounds
				LeaPlusLC:LoadVarStr("MuteCustomList", "")					-- Mute custom sounds list

				LeaPlusLC:LoadVarChk("NoBagAutomation", "Off")				-- Disable bag automation
				LeaPlusLC:LoadVarChk("NoPetAutomation", "Off")				-- Disable pet automation
				LeaPlusLC:LoadVarChk("CharAddonList", "Off")				-- Show character addons
				LeaPlusLC:LoadVarChk("NoConfirmLoot", "Off")				-- Disable loot warnings
				LeaPlusLC:LoadVarChk("FasterLooting", "Off")				-- Faster auto loot
				LeaPlusLC:LoadVarChk("FasterMovieSkip", "Off")				-- Faster movie skip
				LeaPlusLC:LoadVarChk("StandAndDismount", "Off")				-- Dismount me
				LeaPlusLC:LoadVarChk("DismountNoResource", "On")			-- Dismount on resource error
				LeaPlusLC:LoadVarChk("DismountNoMoving", "On")				-- Dismount on moving
				LeaPlusLC:LoadVarChk("DismountNoTaxi", "On")				-- Dismount on flight map open
				LeaPlusLC:LoadVarChk("DismountShowFormBtn", "On")			-- Dismount cancel form button
				LeaPlusLC:LoadVarChk("ExpandVendorPrice", "Off")			-- Expand vendor price
				LeaPlusLC:LoadVarChk("CombatPlates", "Off")					-- Combat plates
				LeaPlusLC:LoadVarChk("EasyItemDestroy", "Off")				-- Easy item destroy
				LeaPlusLC:LoadVarChk("NoTransforms", "Off")					-- Remove transforms

				-- Settings
				LeaPlusLC:LoadVarChk("ShowMinimapIcon", "On")				-- Show minimap button
				LeaPlusLC:LoadVarChk("UseEnglishLanguage", "Off")			-- Use English language
				LeaPlusLC:LoadVarNum("PlusPanelScale", 1, 1, 2)				-- Panel scale
				LeaPlusLC:LoadVarNum("PlusPanelAlpha", 0, 0, 1)				-- Panel alpha

				-- Panel position
				LeaPlusLC:LoadVarAnc("MainPanelA", "CENTER")				-- Panel anchor
				LeaPlusLC:LoadVarAnc("MainPanelR", "CENTER")				-- Panel relative
				LeaPlusLC:LoadVarNum("MainPanelX", 0, -5000, 5000)			-- Panel X axis
				LeaPlusLC:LoadVarNum("MainPanelY", 0, -5000, 5000)			-- Panel Y axis

				-- Start page
				LeaPlusLC:LoadVarNum("LeaStartPage", 0, 0, LeaPlusLC["NumberOfPages"])

				-- Lock conflicting options
				do

					-- Function to disable and lock an option and add a note to the tooltip
					local function Lock(option, reason, optmodule)
						LeaLockList[option] = LeaPlusLC[option]
						LeaPlusLC:LockItem(LeaPlusCB[option], true)
						LeaPlusCB[option].tiptext = LeaPlusCB[option].tiptext .. "|n|n|cff00AAFF" .. reason
						if optmodule then
							LeaPlusCB[option].tiptext = LeaPlusCB[option].tiptext .. " " .. optmodule .. " " .. L["module"]
						end
						LeaPlusCB[option].tiptext = LeaPlusCB[option].tiptext .. "."
						-- Remove hover from configuration button if there is one
						local temp = {LeaPlusCB[option]:GetChildren()}
						if temp and temp[1] and temp[1].t and temp[1].t:GetTexture() == "Interface\\WorldMap\\Gear_64.png" then
							temp[1]:SetHighlightTexture(0)
							temp[1]:SetScript("OnEnter", nil)
						end
					end

					if not LeaPlusLC.NewPatch then
						-- Lock("NoPetDuels", L["This is for Mists of Pandaria Classic"]) -- Block pet battle duels
					end

					-- Disable items that conflict with Easy Frames
					if C_AddOns.IsAddOnLoaded("EasyFrames") then
						Lock("ClassColFrames", L["Cannot be used with Easy Frames"]) -- Class colored frames
					end

					-- Disable items that conflict with Glass
					if C_AddOns.IsAddOnLoaded("Glass") then
						local reason = L["Cannot be used with Glass"]
						Lock("UseEasyChatResizing", reason) -- Use easy resizing
						Lock("NoCombatLogTab", reason) -- Hide the combat log
						Lock("NoChatButtons", reason) -- Hide chat buttons
						Lock("UnclampChat", reason) -- Unclamp chat frame
						Lock("MoveChatEditBoxToTop", reason) -- Move editbox to top
						Lock("MoreFontSizes", reason) --  More font sizes
						Lock("NoChatFade", reason) --  Disable chat fade
						Lock("ClassColorsInChat", reason) -- Use class colors in chat
						Lock("RecentChatWindow", reason) -- Recent chat window
					end

					-- Disable items that conflict with ElvUI
					if LeaPlusLC.ElvUI then
						local E = LeaPlusLC.ElvUI
						if E and E.private then

							local reason = L["Cannot be used with ElvUI"]

							-- Chat
							if E.private.chat.enable then
								Lock("UseEasyChatResizing", reason, "Chat") -- Use easy resizing
								Lock("NoCombatLogTab", reason, "Chat") -- Hide the combat log
								Lock("NoChatButtons", reason, "Chat") -- Hide chat buttons
								Lock("UnclampChat", reason, "Chat") -- Unclamp chat frame
								Lock("MoreFontSizes", reason, "Chat") --  More font sizes
								Lock("NoStickyChat", reason, "Chat") -- Disable sticky chat
								Lock("UseArrowKeysInChat", reason, "Chat") -- Use arrow keys in chat
								Lock("NoChatFade", reason, "Chat") -- Disable chat fade
								Lock("MaxChatHstory", reason, "Chat") -- Increase chat history
								Lock("RestoreChatMessages", reason, "Chat") -- Restore chat messages
							end

							-- Minimap
							if E.private.general.minimap.enable then
								Lock("MinimapModder", reason, "Minimap") -- Enhance minimap
							end

							-- UnitFrames
							if E.private.unitframe.enable then
								Lock("ShowRaidToggle", reason, "UnitFrames") -- Show raid button
							end

							-- ActionBars
							if E.private.actionbar.enable then
								Lock("NoGryphons", reason, "ActionBars") -- Hide gryphons
								Lock("NoClassBar", reason, "ActionBars") -- Hide stance bar
								Lock("HideKeybindText", reason, "ActionBars") -- Hide keybind text
								Lock("HideMacroText", reason, "ActionBars") -- Hide macro text
							end

							-- Bags
							if E.private.bags.enable then
								Lock("NoBagAutomation", reason, "Bags") -- Disable bag automation
							end

							-- Tooltip
							if E.private.tooltip.enable then
								Lock("TipModEnable", reason, "Tooltip") -- Enhance tooltip
							end

							-- Buffs: Disable Blizzard
							if E.private.auras.disableBlizzard then
								Lock("ManageBuffs", reason, "Buffs and Debuffs (Disable Blizzard)") -- Manage buffs
							end

							-- UnitFrames: Disabled Blizzard: Focus
							if E.private.unitframe.disabledBlizzardFrames.focus then
								Lock("ManageFocus", reason, "UnitFrames (Disabled Blizzard Frames Focus)") -- Manage focus
							end

							-- UnitFrames: Disabled Blizzard: Player
							if E.private.unitframe.disabledBlizzardFrames.player then
								Lock("ShowPlayerChain", reason, "UnitFrames (Disabled Blizzard Frames Player)") -- Show player chain
								Lock("NoHitIndicators", reason, "UnitFrames (Disabled Blizzard Frames Player)") -- Hide portrait numbers
							end

							-- UnitFrames: Disabled Blizzard: Player and Target
							if E.private.unitframe.disabledBlizzardFrames.player or E.private.unitframe.disabledBlizzardFrames.target then
								Lock("FrmEnabled", reason, "UnitFrames (Disabled Blizzard Frames Player and Target)") -- Manage frames
							end

							-- UnitFrames: Disabled Blizzard: Player, Target and Focus
							if E.private.unitframe.disabledBlizzardFrames.player or E.private.unitframe.disabledBlizzardFrames.target or E.private.unitframe.disabledBlizzardFrames.focus then
								Lock("ClassColFrames", reason, "UnitFrames (Disabled Blizzard Frames Player, Target and Focus)") -- Class-colored frames
							end

							-- Skins: Blizzard Gossip Frame
							if E.private.skins.blizzard.enable and E.private.skins.blizzard.gossip then
								Lock("QuestFontChange", reason, "Skins (Blizzard Gossip Frame)") -- Resize quest font
							end

							-- Base
							do
								Lock("ManageWidget", reason) -- Manage widget
								Lock("ManageTimer", reason) -- Manage timer
								Lock("ManageDurability", reason) -- Manage durability
								Lock("ManageVehicle", reason) -- Manage vehicle
							end

						end

						C_AddOns.EnableAddOn("Leatrix_Plus")
					end

				end

				-- Run other startup items
				LeaPlusLC:SetDim()

			end
			return
		end

		if event == "PLAYER_LOGIN" then
			LeaPlusLC:Player()
			collectgarbage()
			return
		end

		-- Save locals back to globals on logout
		if event == "PLAYER_LOGOUT" then

			-- Run the logout function without wipe flag
			LeaPlusLC:PlayerLogout(false)

			-- Automation
			LeaPlusDB["AutomateQuests"]			= LeaPlusLC["AutomateQuests"]
			LeaPlusDB["AutoQuestShift"]			= LeaPlusLC["AutoQuestShift"]
			LeaPlusDB["AutoQuestAvailable"]		= LeaPlusLC["AutoQuestAvailable"]
			LeaPlusDB["AutoQuestCompleted"]		= LeaPlusLC["AutoQuestCompleted"]
			LeaPlusDB["AutoQuestKeyMenu"]		= LeaPlusLC["AutoQuestKeyMenu"]
			LeaPlusDB["AutomateGossip"]			= LeaPlusLC["AutomateGossip"]
			LeaPlusDB["AutoAcceptSummon"] 		= LeaPlusLC["AutoAcceptSummon"]
			LeaPlusDB["AutoAcceptRes"] 			= LeaPlusLC["AutoAcceptRes"]
			LeaPlusDB["AutoResNoCombat"] 		= LeaPlusLC["AutoResNoCombat"]
			LeaPlusDB["AutoReleasePvP"] 		= LeaPlusLC["AutoReleasePvP"]
			LeaPlusDB["AutoReleaseNoAlterac"] 	= LeaPlusLC["AutoReleaseNoAlterac"]
			LeaPlusDB["AutoReleaseGilneas"] 	= LeaPlusLC["AutoReleaseGilneas"]
			LeaPlusDB["AutoReleaseConquest"] 	= LeaPlusLC["AutoReleaseConquest"]
			LeaPlusDB["AutoReleaseSilvershard"] = LeaPlusLC["AutoReleaseSilvershard"]
			LeaPlusDB["AutoReleaseKotmogu"] 	= LeaPlusLC["AutoReleaseKotmogu"]
			LeaPlusDB["AutoReleaseNoWintergsp"] = LeaPlusLC["AutoReleaseNoWintergsp"]
			LeaPlusDB["AutoReleaseDelay"] 		= LeaPlusLC["AutoReleaseDelay"]

			LeaPlusDB["AutoSellJunk"] 			= LeaPlusLC["AutoSellJunk"]
			LeaPlusDB["AutoSellShowSummary"] 	= LeaPlusLC["AutoSellShowSummary"]
			LeaPlusDB["AutoSellExcludeList"] 	= LeaPlusLC["AutoSellExcludeList"]
			LeaPlusDB["AutoRepairGear"] 		= LeaPlusLC["AutoRepairGear"]
			LeaPlusDB["AutoRepairGuildFunds"] 	= LeaPlusLC["AutoRepairGuildFunds"]
			LeaPlusDB["AutoRepairShowSummary"] 	= LeaPlusLC["AutoRepairShowSummary"]

			-- Social
			LeaPlusDB["NoDuelRequests"] 		= LeaPlusLC["NoDuelRequests"]
			LeaPlusDB["NoPetDuels"] 			= LeaPlusLC["NoPetDuels"]
			LeaPlusDB["NoPartyInvites"]			= LeaPlusLC["NoPartyInvites"]
			LeaPlusDB["NoRequestedInvites"]		= LeaPlusLC["NoRequestedInvites"]
			LeaPlusDB["NoFriendRequests"]		= LeaPlusLC["NoFriendRequests"]
			LeaPlusDB["NoSharedQuests"]			= LeaPlusLC["NoSharedQuests"]

			LeaPlusDB["AcceptPartyFriends"]		= LeaPlusLC["AcceptPartyFriends"]
			LeaPlusDB["AutoConfirmRole"]		= LeaPlusLC["AutoConfirmRole"]
			LeaPlusDB["InviteFromWhisper"]		= LeaPlusLC["InviteFromWhisper"]
			LeaPlusDB["InviteFriendsOnly"]		= LeaPlusLC["InviteFriendsOnly"]
			LeaPlusDB["InvKey"]					= LeaPlusLC["InvKey"]
			LeaPlusDB["FriendlyGuild"]			= LeaPlusLC["FriendlyGuild"]

			-- Chat
			LeaPlusDB["UseEasyChatResizing"]	= LeaPlusLC["UseEasyChatResizing"]
			LeaPlusDB["NoCombatLogTab"]			= LeaPlusLC["NoCombatLogTab"]
			LeaPlusDB["NoChatButtons"]			= LeaPlusLC["NoChatButtons"]
			LeaPlusDB["UnclampChat"]			= LeaPlusLC["UnclampChat"]
			LeaPlusDB["MoveChatEditBoxToTop"]	= LeaPlusLC["MoveChatEditBoxToTop"]
			LeaPlusDB["MoreFontSizes"]			= LeaPlusLC["MoreFontSizes"]

			LeaPlusDB["NoStickyChat"] 			= LeaPlusLC["NoStickyChat"]
			LeaPlusDB["UseArrowKeysInChat"]		= LeaPlusLC["UseArrowKeysInChat"]
			LeaPlusDB["NoChatFade"]				= LeaPlusLC["NoChatFade"]
			LeaPlusDB["UnivGroupColor"]			= LeaPlusLC["UnivGroupColor"]
			LeaPlusDB["ClassColorsInChat"]		= LeaPlusLC["ClassColorsInChat"]
			LeaPlusDB["RecentChatWindow"]		= LeaPlusLC["RecentChatWindow"]
			LeaPlusDB["RecentChatSize"]			= LeaPlusLC["RecentChatSize"]
			LeaPlusDB["MaxChatHstory"]			= LeaPlusLC["MaxChatHstory"]
			LeaPlusDB["FilterChatMessages"]		= LeaPlusLC["FilterChatMessages"]
			LeaPlusDB["BlockSpellLinks"]		= LeaPlusLC["BlockSpellLinks"]
			LeaPlusDB["BlockDrunkenSpam"]		= LeaPlusLC["BlockDrunkenSpam"]
			LeaPlusDB["BlockDuelSpam"]			= LeaPlusLC["BlockDuelSpam"]
			LeaPlusDB["BlockGuildAnnounce"]		= LeaPlusLC["BlockGuildAnnounce"]
			LeaPlusDB["RestoreChatMessages"]	= LeaPlusLC["RestoreChatMessages"]

			-- Text
			LeaPlusDB["HideErrorMessages"]		= LeaPlusLC["HideErrorMessages"]
			LeaPlusDB["NoHitIndicators"]		= LeaPlusLC["NoHitIndicators"]
			LeaPlusDB["HideZoneText"] 			= LeaPlusLC["HideZoneText"]
			LeaPlusDB["HideKeybindText"] 		= LeaPlusLC["HideKeybindText"]
			LeaPlusDB["HideMacroText"] 			= LeaPlusLC["HideMacroText"]
			LeaPlusDB["HideRaidGroupLabels"] 	= LeaPlusLC["HideRaidGroupLabels"]

			LeaPlusDB["MailFontChange"] 		= LeaPlusLC["MailFontChange"]
			LeaPlusDB["LeaPlusMailFontSize"] 	= LeaPlusLC["LeaPlusMailFontSize"]

			LeaPlusDB["QuestFontChange"] 		= LeaPlusLC["QuestFontChange"]
			LeaPlusDB["LeaPlusQuestFontSize"]	= LeaPlusLC["LeaPlusQuestFontSize"]

			LeaPlusDB["BookFontChange"] 		= LeaPlusLC["BookFontChange"]
			LeaPlusDB["LeaPlusBookFontSize"]	= LeaPlusLC["LeaPlusBookFontSize"]

			-- Interface
			LeaPlusDB["MinimapModder"]			= LeaPlusLC["MinimapModder"]
			LeaPlusDB["SquareMinimap"]			= LeaPlusLC["SquareMinimap"]
			LeaPlusDB["ShowWhoPinged"]			= LeaPlusLC["ShowWhoPinged"]
			LeaPlusDB["CombineAddonButtons"]	= LeaPlusLC["CombineAddonButtons"]
			LeaPlusDB["MiniExcludeList"] 		= LeaPlusLC["MiniExcludeList"]
			LeaPlusDB["HideMiniZoomBtns"]		= LeaPlusLC["HideMiniZoomBtns"]
			LeaPlusDB["HideMiniZoneText"]		= LeaPlusLC["HideMiniZoneText"]
			LeaPlusDB["HideMiniAddonButtons"]	= LeaPlusLC["HideMiniAddonButtons"]
			LeaPlusDB["HideMiniMapButton"]		= LeaPlusLC["HideMiniMapButton"]
			LeaPlusDB["HideMiniTracking"]		= LeaPlusLC["HideMiniTracking"]
			LeaPlusDB["MinimapScale"]			= LeaPlusLC["MinimapScale"]
			LeaPlusDB["MinimapSize"]			= LeaPlusLC["MinimapSize"]
			LeaPlusDB["MinimapBorderWidth"]		= LeaPlusLC["MinimapBorderWidth"]
			LeaPlusDB["MiniClusterScale"]		= LeaPlusLC["MiniClusterScale"]
			LeaPlusDB["MinimapNoScale"]			= LeaPlusLC["MinimapNoScale"]
			LeaPlusDB["MinimapA"]				= LeaPlusLC["MinimapA"]
			LeaPlusDB["MinimapR"]				= LeaPlusLC["MinimapR"]
			LeaPlusDB["MinimapX"]				= LeaPlusLC["MinimapX"]
			LeaPlusDB["MinimapY"]				= LeaPlusLC["MinimapY"]

			LeaPlusDB["TipModEnable"]			= LeaPlusLC["TipModEnable"]
			LeaPlusDB["TipShowRank"]			= LeaPlusLC["TipShowRank"]
			LeaPlusDB["TipShowOtherRank"]		= LeaPlusLC["TipShowOtherRank"]
			LeaPlusDB["TipShowTarget"]			= LeaPlusLC["TipShowTarget"]
			LeaPlusDB["TipHideInCombat"]		= LeaPlusLC["TipHideInCombat"]
			LeaPlusDB["TipHideShiftOverride"]	= LeaPlusLC["TipHideShiftOverride"]
			LeaPlusDB["TipNoHealthBar"]			= LeaPlusLC["TipNoHealthBar"]
			LeaPlusDB["LeaPlusTipSize"]			= LeaPlusLC["LeaPlusTipSize"]
			LeaPlusDB["TipOffsetX"]				= LeaPlusLC["TipOffsetX"]
			LeaPlusDB["TipOffsetY"]				= LeaPlusLC["TipOffsetY"]
			LeaPlusDB["TooltipAnchorMenu"]		= LeaPlusLC["TooltipAnchorMenu"]
			LeaPlusDB["TipCursorX"]				= LeaPlusLC["TipCursorX"]
			LeaPlusDB["TipCursorY"]				= LeaPlusLC["TipCursorY"]

			LeaPlusDB["EnhanceDressup"]			= LeaPlusLC["EnhanceDressup"]
			LeaPlusDB["DressupItemButtons"]		= LeaPlusLC["DressupItemButtons"]
			LeaPlusDB["DressupAnimControl"]		= LeaPlusLC["DressupAnimControl"]
			LeaPlusDB["DressupWiderPreview"]	= LeaPlusLC["DressupWiderPreview"]
			LeaPlusDB["DressupTransmogAnim"]	= LeaPlusLC["DressupTransmogAnim"]
			LeaPlusDB["DressupFasterZoom"]		= LeaPlusLC["DressupFasterZoom"]
			LeaPlusDB["HideDressupStats"]		= LeaPlusLC["HideDressupStats"]
			LeaPlusDB["EnhanceQuestLog"]		= LeaPlusLC["EnhanceQuestLog"]
			LeaPlusDB["EnhanceQuestHeaders"]	= LeaPlusLC["EnhanceQuestHeaders"]
			LeaPlusDB["EnhanceQuestLevels"]		= LeaPlusLC["EnhanceQuestLevels"]
			LeaPlusDB["EnhanceQuestDifficulty"]	= LeaPlusLC["EnhanceQuestDifficulty"]

			LeaPlusDB["EnhanceProfessions"]		= LeaPlusLC["EnhanceProfessions"]
			LeaPlusDB["EnhanceTrainers"]		= LeaPlusLC["EnhanceTrainers"]
			LeaPlusDB["ShowTrainAllBtn"]		= LeaPlusLC["ShowTrainAllBtn"]
			LeaPlusDB["EnhanceFlightMap"]		= LeaPlusLC["EnhanceFlightMap"]
			LeaPlusDB["LeaPlusTaxiMapScale"]	= LeaPlusLC["LeaPlusTaxiMapScale"]
			LeaPlusDB["LeaPlusTaxiIconSize"]	= LeaPlusLC["LeaPlusTaxiIconSize"]
			LeaPlusDB["FlightMapA"]				= LeaPlusLC["FlightMapA"]
			LeaPlusDB["FlightMapR"]				= LeaPlusLC["FlightMapR"]
			LeaPlusDB["FlightMapX"]				= LeaPlusLC["FlightMapX"]
			LeaPlusDB["FlightMapY"]				= LeaPlusLC["FlightMapY"]

			LeaPlusDB["ShowVolume"] 			= LeaPlusLC["ShowVolume"]
			LeaPlusDB["ShowCooldowns"]			= LeaPlusLC["ShowCooldowns"]
			LeaPlusDB["ShowCooldownID"]			= LeaPlusLC["ShowCooldownID"]
			LeaPlusDB["NoCooldownDuration"]		= LeaPlusLC["NoCooldownDuration"]
			LeaPlusDB["CooldownsOnPlayer"]		= LeaPlusLC["CooldownsOnPlayer"]
			LeaPlusDB["DurabilityStatus"]		= LeaPlusLC["DurabilityStatus"]
			LeaPlusDB["ShowPetSaveBtn"]			= LeaPlusLC["ShowPetSaveBtn"]
			LeaPlusDB["ShowVanityControls"]		= LeaPlusLC["ShowVanityControls"]
			LeaPlusDB["VanityAltLayout"]		= LeaPlusLC["VanityAltLayout"]
			LeaPlusDB["ShowRaidToggle"]			= LeaPlusLC["ShowRaidToggle"]
			LeaPlusDB["ShowBorders"]			= LeaPlusLC["ShowBorders"]
			LeaPlusDB["BordersTop"]				= LeaPlusLC["BordersTop"]
			LeaPlusDB["BordersBottom"]			= LeaPlusLC["BordersBottom"]
			LeaPlusDB["BordersLeft"]			= LeaPlusLC["BordersLeft"]
			LeaPlusDB["BordersRight"]			= LeaPlusLC["BordersRight"]
			LeaPlusDB["BordersAlpha"]			= LeaPlusLC["BordersAlpha"]
			LeaPlusDB["ShowPlayerChain"]		= LeaPlusLC["ShowPlayerChain"]
			LeaPlusDB["PlayerChainMenu"]		= LeaPlusLC["PlayerChainMenu"]
			LeaPlusDB["ShowReadyTimer"]			= LeaPlusLC["ShowReadyTimer"]
			LeaPlusDB["ShowWowheadLinks"]		= LeaPlusLC["ShowWowheadLinks"]
			LeaPlusDB["WowheadLinkComments"]	= LeaPlusLC["WowheadLinkComments"]

			-- Frames
			LeaPlusDB["FrmEnabled"]				= LeaPlusLC["FrmEnabled"]

			LeaPlusDB["ManageBuffs"]			= LeaPlusLC["ManageBuffs"]
			LeaPlusDB["BuffFrameA"]				= LeaPlusLC["BuffFrameA"]
			LeaPlusDB["BuffFrameR"]				= LeaPlusLC["BuffFrameR"]
			LeaPlusDB["BuffFrameX"]				= LeaPlusLC["BuffFrameX"]
			LeaPlusDB["BuffFrameY"]				= LeaPlusLC["BuffFrameY"]
			LeaPlusDB["BuffFrameScale"]			= LeaPlusLC["BuffFrameScale"]

			LeaPlusDB["ManageWidget"]			= LeaPlusLC["ManageWidget"]
			LeaPlusDB["WidgetA"]				= LeaPlusLC["WidgetA"]
			LeaPlusDB["WidgetR"]				= LeaPlusLC["WidgetR"]
			LeaPlusDB["WidgetX"]				= LeaPlusLC["WidgetX"]
			LeaPlusDB["WidgetY"]				= LeaPlusLC["WidgetY"]
			LeaPlusDB["WidgetScale"]			= LeaPlusLC["WidgetScale"]

			LeaPlusDB["ManageFocus"]			= LeaPlusLC["ManageFocus"]
			LeaPlusDB["FocusA"]					= LeaPlusLC["FocusA"]
			LeaPlusDB["FocusR"]					= LeaPlusLC["FocusR"]
			LeaPlusDB["FocusX"]					= LeaPlusLC["FocusX"]
			LeaPlusDB["FocusY"]					= LeaPlusLC["FocusY"]
			LeaPlusDB["FocusScale"]				= LeaPlusLC["FocusScale"]

			LeaPlusDB["ManageTimer"]			= LeaPlusLC["ManageTimer"]
			LeaPlusDB["TimerA"]					= LeaPlusLC["TimerA"]
			LeaPlusDB["TimerR"]					= LeaPlusLC["TimerR"]
			LeaPlusDB["TimerX"]					= LeaPlusLC["TimerX"]
			LeaPlusDB["TimerY"]					= LeaPlusLC["TimerY"]
			LeaPlusDB["TimerScale"]				= LeaPlusLC["TimerScale"]

			LeaPlusDB["ManageDurability"]		= LeaPlusLC["ManageDurability"]
			LeaPlusDB["DurabilityA"]			= LeaPlusLC["DurabilityA"]
			LeaPlusDB["DurabilityR"]			= LeaPlusLC["DurabilityR"]
			LeaPlusDB["DurabilityX"]			= LeaPlusLC["DurabilityX"]
			LeaPlusDB["DurabilityY"]			= LeaPlusLC["DurabilityY"]
			LeaPlusDB["DurabilityScale"]		= LeaPlusLC["DurabilityScale"]

			LeaPlusDB["ManageVehicle"]			= LeaPlusLC["ManageVehicle"]
			LeaPlusDB["VehicleA"]				= LeaPlusLC["VehicleA"]
			LeaPlusDB["VehicleR"]				= LeaPlusLC["VehicleR"]
			LeaPlusDB["VehicleX"]				= LeaPlusLC["VehicleX"]
			LeaPlusDB["VehicleY"]				= LeaPlusLC["VehicleY"]
			LeaPlusDB["VehicleScale"]			= LeaPlusLC["VehicleScale"]

			LeaPlusDB["ClassColFrames"]			= LeaPlusLC["ClassColFrames"]
			LeaPlusDB["ClassColPlayer"]			= LeaPlusLC["ClassColPlayer"]
			LeaPlusDB["ClassColTarget"]			= LeaPlusLC["ClassColTarget"]

			LeaPlusDB["NoAlerts"]				= LeaPlusLC["NoAlerts"]
			LeaPlusDB["NoGryphons"]				= LeaPlusLC["NoGryphons"]
			LeaPlusDB["HideEventToasts"]		= LeaPlusLC["HideEventToasts"]
			LeaPlusDB["NoClassBar"]				= LeaPlusLC["NoClassBar"]

			-- System
			LeaPlusDB["NoScreenGlow"] 			= LeaPlusLC["NoScreenGlow"]
			LeaPlusDB["NoScreenEffects"] 		= LeaPlusLC["NoScreenEffects"]
			LeaPlusDB["SetWeatherDensity"] 		= LeaPlusLC["SetWeatherDensity"]
			LeaPlusDB["WeatherLevel"] 			= LeaPlusLC["WeatherLevel"]
			LeaPlusDB["MaxCameraZoom"] 			= LeaPlusLC["MaxCameraZoom"]

			LeaPlusDB["NoRestedEmotes"]			= LeaPlusLC["NoRestedEmotes"]
			LeaPlusDB["KeepAudioSynced"]		= LeaPlusLC["KeepAudioSynced"]
			LeaPlusDB["MuteGameSounds"]			= LeaPlusLC["MuteGameSounds"]
			LeaPlusDB["MuteMountSounds"]		= LeaPlusLC["MuteMountSounds"]
			LeaPlusDB["MuteCustomSounds"]		= LeaPlusLC["MuteCustomSounds"]
			LeaPlusDB["MuteCustomList"]			= LeaPlusLC["MuteCustomList"]

			LeaPlusDB["NoBagAutomation"]		= LeaPlusLC["NoBagAutomation"]
			LeaPlusDB["NoPetAutomation"]		= LeaPlusLC["NoPetAutomation"]
			LeaPlusDB["CharAddonList"]			= LeaPlusLC["CharAddonList"]
			LeaPlusDB["NoConfirmLoot"] 			= LeaPlusLC["NoConfirmLoot"]
			LeaPlusDB["FasterLooting"] 			= LeaPlusLC["FasterLooting"]
			LeaPlusDB["FasterMovieSkip"] 		= LeaPlusLC["FasterMovieSkip"]
			LeaPlusDB["StandAndDismount"] 		= LeaPlusLC["StandAndDismount"]
			LeaPlusDB["DismountNoResource"] 	= LeaPlusLC["DismountNoResource"]
			LeaPlusDB["DismountNoMoving"] 		= LeaPlusLC["DismountNoMoving"]
			LeaPlusDB["DismountNoTaxi"] 		= LeaPlusLC["DismountNoTaxi"]
			LeaPlusDB["DismountShowFormBtn"] 	= LeaPlusLC["DismountShowFormBtn"]
			LeaPlusDB["ExpandVendorPrice"] 		= LeaPlusLC["ExpandVendorPrice"]
			LeaPlusDB["CombatPlates"]			= LeaPlusLC["CombatPlates"]
			LeaPlusDB["EasyItemDestroy"]		= LeaPlusLC["EasyItemDestroy"]
			LeaPlusDB["NoTransforms"] 			= LeaPlusLC["NoTransforms"]

			-- Settings
			LeaPlusDB["ShowMinimapIcon"] 		= LeaPlusLC["ShowMinimapIcon"]
			LeaPlusDB["UseEnglishLanguage"] 	= LeaPlusLC["UseEnglishLanguage"]
			LeaPlusDB["PlusPanelScale"] 		= LeaPlusLC["PlusPanelScale"]
			LeaPlusDB["PlusPanelAlpha"] 		= LeaPlusLC["PlusPanelAlpha"]

			-- Panel position
			LeaPlusDB["MainPanelA"]				= LeaPlusLC["MainPanelA"]
			LeaPlusDB["MainPanelR"]				= LeaPlusLC["MainPanelR"]
			LeaPlusDB["MainPanelX"]				= LeaPlusLC["MainPanelX"]
			LeaPlusDB["MainPanelY"]				= LeaPlusLC["MainPanelY"]

			-- Start page
			LeaPlusDB["LeaStartPage"]			= LeaPlusLC["LeaStartPage"]

			-- Mute game sounds (LeaPlusLC["MuteGameSounds"])
			for k, v in pairs(LeaPlusLC["muteTable"]) do
				LeaPlusDB[k] = LeaPlusLC[k]
			end

			-- Mute mount sounds (LeaPlusLC["MuteMountSounds"])
			for k, v in pairs(LeaPlusLC["mountTable"]) do
				LeaPlusDB[k] = LeaPlusLC[k]
			end

			-- Remove transforms (LeaPlusLC["NoTransforms"])
			for k, v in pairs(LeaPlusLC["transTable"]) do
				LeaPlusDB[k] = LeaPlusLC[k]
			end

		end

	end

--	Register event handler
	LpEvt:SetScript("OnEvent", eventHandler);

----------------------------------------------------------------------
--	L70: Player logout
----------------------------------------------------------------------

	-- Player Logout
	function LeaPlusLC:PlayerLogout(wipe)

		----------------------------------------------------------------------
		-- Restore default values for options that do not require reloads
		----------------------------------------------------------------------

		if wipe then

			-- Disable screen glow (LeaPlusLC["NoScreenGlow"])
			SetCVar("ffxGlow", "1")

			-- Disable screen effects (LeaPlusLC["NoScreenEffects"])
			SetCVar("ffxDeath", "1")
			SetCVar("ffxNether", "1")

			-- Set weather density (LeaPlusLC["SetWeatherDensity"])
			SetCVar("WeatherDensity", "3")
			SetCVar("RAIDweatherDensity", "3")

			-- Max camera zoom (LeaPlusLC["MaxCameraZoom"])
			SetCVar("cameraDistanceMaxZoomFactor", 1.9)

			-- Universal group color (LeaPlusLC["UnivGroupColor"])
			ChangeChatColor("RAID", 1, 0.50, 0)
			ChangeChatColor("RAID_LEADER", 1, 0.28, 0.04)

			-- Mute game sounds (LeaPlusLC["MuteGameSounds"])
			for k, v in pairs(LeaPlusLC["muteTable"]) do
				for i, e in pairs(v) do
					local file, soundID = e:match("([^,]+)%#([^,]+)")
					UnmuteSoundFile(soundID)
				end
			end

			-- Mute mount sounds (LeaPlusLC["MuteMountSounds"])
			for k, v in pairs(LeaPlusLC["mountTable"]) do
				for i, e in pairs(v) do
					local file, soundID = e:match("([^,]+)%#([^,]+)")
					UnmuteSoundFile(soundID)
				end
			end

		end

		----------------------------------------------------------------------
		-- Restore default values for options that require reloads
		----------------------------------------------------------------------

		-- Use class colors in chat
		if LeaPlusDB["ClassColorsInChat"] == "On" and not LeaLockList["ClassColorsInChat"] then
			if wipe or (not wipe and LeaPlusLC["ClassColorsInChat"] == "Off") then
				SetCVar("chatClassColorOverride", "1")
				for void, v in ipairs({"SAY", "EMOTE", "YELL", "GUILD", "OFFICER", "WHISPER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "RAID_WARNING", "INSTANCE_CHAT", "INSTANCE_CHAT_LEADER", "VOICE_TEXT"}) do
					SetChatColorNameByClass(v, false)
				end
				for i = 1, 50 do
					SetChatColorNameByClass("CHANNEL" .. i, false)
				end
			end
		end

		-- Enhance minimap restore round minimap if wipe or enhance minimap is toggled off
		if LeaPlusDB["MinimapModder"] == "On" and LeaPlusDB["SquareMinimap"] == "On" and not LeaLockList["MinimapModder"] then
			if wipe or (not wipe and LeaPlusLC["MinimapModder"] == "Off") then
				Minimap:SetMaskTexture([[Interface\CharacterFrame\TempPortraitAlphaMask]])
			end
		end

		-- Silence rested emotes
		if LeaPlusDB["NoRestedEmotes"] == "On" then
			if wipe or (not wipe and LeaPlusLC["NoRestedEmotes"] == "Off") then
				SetCVar("Sound_EnableEmoteSounds", "1")
			end
		end

		-- More font sizes
		if LeaPlusDB["MoreFontSizes"] == "On" and not LeaLockList["MoreFontSizes"] then
			if wipe or (not wipe and LeaPlusLC["MoreFontSizes"] == "Off") then
				RunScript('for i = 1, 50 do if _G["ChatFrame" .. i] then local void, fontSize = FCF_GetChatWindowInfo(i); if fontSize and fontSize ~= 12 and fontSize ~= 14 and fontSize ~= 16 and fontSize ~= 18 then FCF_SetChatWindowFontSize(self, _G["ChatFrame" .. i], CHAT_FRAME_DEFAULT_FONT_SIZE) end end end')
			end
		end

	end

----------------------------------------------------------------------
-- 	Options panel functions
----------------------------------------------------------------------

	-- Function to add textures to panels
	function LeaPlusLC:CreateBar(name, parent, width, height, anchor, r, g, b, alp, tex)
		local ft = parent:CreateTexture(nil, "BORDER")
		ft:SetTexture(tex)
		ft:SetSize(width, height)
		ft:SetPoint(anchor)
		ft:SetVertexColor(r ,g, b, alp)
		if name == "MainTexture" then
			ft:SetTexCoord(0.09, 1, 0, 1);
		end
	end

	-- Create a configuration panel
	function LeaPlusLC:CreatePanel(title, globref, scrolling)

		-- Create the panel
		local Side = CreateFrame("Frame", nil, UIParent)

		-- Make it a system frame
		_G["LeaPlusGlobalPanel_" .. globref] = Side
		table.insert(UISpecialFrames, "LeaPlusGlobalPanel_" .. globref)

		-- Store it in the configuration panel table
		tinsert(LeaConfigList, Side)

		-- Set frame parameters
		Side:Hide();
		Side:SetSize(570, LeaPlusLC.MainPanelHeight)
		Side:SetClampedToScreen(true)
		Side:SetClampRectInsets(500, -500, -300, 300)
		Side:SetFrameStrata("FULLSCREEN_DIALOG")

		-- Set the background color
		Side.t = Side:CreateTexture(nil, "BACKGROUND")
		Side.t:SetAllPoints()
		Side.t:SetColorTexture(0.05, 0.05, 0.05, 0.9)

		-- Add a close Button
		Side.c = CreateFrame("Button", nil, Side, "UIPanelCloseButton")
		Side.c:SetSize(30, 30)
		Side.c:SetPoint("TOPRIGHT", 0, 0)
		Side.c:SetScript("OnClick", function() Side:Hide() end)

		-- Add reset, help and back buttons
		Side.r = LeaPlusLC:CreateButton("ResetButton", Side, "Reset", "BOTTOMLEFT", 16, 53, 0, 25, true, "Click to reset the settings on this page.")
		Side.h = LeaPlusLC:CreateButton("HelpButton", Side, "Help", "BOTTOMLEFT", 76, 53, 0, 25, true, "No help is available for this page.")
		Side.b = LeaPlusLC:CreateButton("BackButton", Side, "Back to Main Menu", "BOTTOMRIGHT", -16, 53, 0, 25, true, "Click to return to the main menu.")

		-- Reposition help button so it doesn't overlap reset button
		Side.h:ClearAllPoints()
		Side.h:SetPoint("LEFT", Side.r, "RIGHT", 10, 0)

		-- Remove the click texture from the help button
		Side.h:SetPushedTextOffset(0, 0)

		-- Add a reload button and syncronise it with the main panel reload button
		local reloadb = LeaPlusLC:CreateButton("ConfigReload", Side, "Reload", "BOTTOMRIGHT", -16, 10, 0, 25, true, LeaPlusCB["ReloadUIButton"].tiptext)
		LeaPlusLC:LockItem(reloadb,true)
		reloadb:SetScript("OnClick", ReloadUI)

		reloadb.f = reloadb:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
		reloadb.f:SetHeight(32);
		reloadb.f:SetPoint('RIGHT', reloadb, 'LEFT', -10, 0)
		reloadb.f:SetText(LeaPlusCB["ReloadUIButton"].f:GetText())
		reloadb.f:Hide()

		LeaPlusCB["ReloadUIButton"]:HookScript("OnEnable", function()
			LeaPlusLC:LockItem(reloadb, false)
			reloadb.f:Show()
		end)

		LeaPlusCB["ReloadUIButton"]:HookScript("OnDisable", function()
			LeaPlusLC:LockItem(reloadb, true)
			reloadb.f:Hide()
		end)

		-- Set textures
		LeaPlusLC:CreateBar("FootTexture", Side, 570, 48, "BOTTOM", 0.5, 0.5, 0.5, 1.0, "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated.png")
		LeaPlusLC:CreateBar("MainTexture", Side, 570, LeaPlusLC.MainPanelHeight - 47, "TOPRIGHT", 0.7, 0.7, 0.7, 0.7,  "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated.png")

		-- Allow movement
		Side:EnableMouse(true)
		Side:SetMovable(true)
		Side:RegisterForDrag("LeftButton")
		Side:SetScript("OnDragStart", Side.StartMoving)
		Side:SetScript("OnDragStop", function ()
			Side:StopMovingOrSizing();
			Side:SetUserPlaced(false);
			-- Save panel position
			LeaPlusLC["MainPanelA"], void, LeaPlusLC["MainPanelR"], LeaPlusLC["MainPanelX"], LeaPlusLC["MainPanelY"] = Side:GetPoint()
		end)

		-- Set panel attributes when shown
		Side:SetScript("OnShow", function()
			Side:ClearAllPoints()
			Side:SetPoint(LeaPlusLC["MainPanelA"], UIParent, LeaPlusLC["MainPanelR"], LeaPlusLC["MainPanelX"], LeaPlusLC["MainPanelY"])
			Side:SetScale(LeaPlusLC["PlusPanelScale"])
			Side.t:SetAlpha(1 - LeaPlusLC["PlusPanelAlpha"])
		end)

		-- Add title
		Side.f = Side:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
		Side.f:SetPoint('TOPLEFT', 16, -16);
		Side.f:SetText(L[title])

		-- Add description
		Side.v = Side:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
		Side.v:SetHeight(32);
		Side.v:SetPoint('TOPLEFT', Side.f, 'BOTTOMLEFT', 0, -8);
		Side.v:SetPoint('RIGHT', Side, -32, 0)
		Side.v:SetJustifyH('LEFT'); Side.v:SetJustifyV('TOP');
		Side.v:SetText(L["Configuration Panel"])

		-- Prevent options panel from showing while side panel is showing
		LeaPlusLC["PageF"]:HookScript("OnShow", function()
			if Side:IsShown() then LeaPlusLC["PageF"]:Hide(); end
		end)

		-- Create scroll frame if needed
		if scrolling then

			-- Create backdrop
			Side.backFrame = CreateFrame("FRAME", nil, Side, "BackdropTemplate")
			Side.backFrame:SetSize(Side:GetSize())
			Side.backFrame:SetPoint("TOPLEFT", 16, -68)
			Side.backFrame:SetPoint("BOTTOMRIGHT", -16, 98)
			Side.backFrame:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background"})
			Side.backFrame:SetBackdropColor(0, 0, 1, 0.5)

			-- Create scroll frame
			Side.scrollFrame = CreateFrame("ScrollFrame", nil, Side.backFrame, "LeaPlusConfigurationPanelScrollFrameTemplate")
			Side.scrollChild = CreateFrame("Frame", nil, Side.scrollFrame)

			Side.scrollChild:SetSize(1, 1)
			Side.scrollFrame:SetScrollChild(Side.scrollChild)
			Side.scrollFrame:SetPoint("TOPLEFT", -8, -6)
			Side.scrollFrame:SetPoint("BOTTOMRIGHT", -29, 6)
			Side.scrollFrame:SetPanExtent(20)

			-- Set scroll list to top when shown
			Side.scrollFrame:HookScript("OnShow", function()
				Side.scrollFrame:SetVerticalScroll(0)
			end)

			-- Add scroll for more message
			local footMessage = LeaPlusLC:MakeTx(Side, "(scroll the list for more)", 16, 0)
			footMessage:ClearAllPoints()
			footMessage:SetPoint("TOPRIGHT", Side.scrollFrame, "TOPRIGHT", 28, 24)

			-- Give child a file level scope (it's used in LeaPlusLC.TipSee)
			LeaPlusLC[globref .. "ScrollChild"] = Side.scrollChild

		end

		-- Return the frame
		return Side

	end

	-- Define subheadings
	function LeaPlusLC:MakeTx(frame, title, x, y)
		local text = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		text:SetPoint("TOPLEFT", x, y)
		text:SetText(L[title])
		return text
	end

	-- Define text
	function LeaPlusLC:MakeWD(frame, title, x, y)
		local text = frame:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
		text:SetPoint("TOPLEFT", x, y)
		text:SetText(L[title])
		text:SetJustifyH"LEFT";
		return text
	end

	-- Create a slider control (uses standard template)
	function LeaPlusLC:MakeSL(frame, field, caption, low, high, step, x, y, form)

		-- Create slider control
		local Slider = CreateFrame("Slider", "LeaPlusGlobalSlider" .. field, frame, "UISliderTemplate")
		LeaPlusCB[field] = Slider;
		Slider:SetMinMaxValues(low, high)
		Slider:SetValueStep(step)
		Slider:EnableMouseWheel(true)
		Slider:SetPoint('TOPLEFT', x,y)
		Slider:SetWidth(100)
		Slider:SetHeight(20)
		Slider:SetHitRectInsets(0, 0, 0, 0);
		Slider.tiptext = L[caption]
		Slider:SetScript("OnEnter", LeaPlusLC.TipSee)
		Slider:SetScript("OnLeave", GameTooltip_Hide)

		-- Create slider label
		Slider.f = Slider:CreateFontString(nil, 'BACKGROUND')
		Slider.f:SetFontObject('GameFontHighlight')
		Slider.f:SetPoint('LEFT', Slider, 'RIGHT', 12, 0)
		Slider.f:SetFormattedText("%.2f", Slider:GetValue())

		-- Process mousewheel scrolling
		Slider:SetScript("OnMouseWheel", function(self, arg1)
			if Slider:IsEnabled() then
				local step = step * arg1
				local value = self:GetValue()
				if step > 0 then
					self:SetValue(min(value + step, high))
				else
					self:SetValue(max(value + step, low))
				end
			end
		end)

		-- Process value changed
		Slider:SetScript("OnValueChanged", function(self, value)
			local value = floor((value - low) / step + 0.5) * step + low
			Slider.f:SetFormattedText(form, value)
			LeaPlusLC[field] = value
		end)

		-- Set slider value when shown
		Slider:SetScript("OnShow", function(self)
			self:SetValue(LeaPlusLC[field])
		end)

	end

	-- Create a checkbox control (uses standard template)
	function LeaPlusLC:MakeCB(parent, field, caption, x, y, reload, tip, tipstyle)

		-- Create the checkbox
		local Cbox = CreateFrame('CheckButton', nil, parent, "ChatConfigCheckButtonTemplate")
		LeaPlusCB[field] = Cbox
		Cbox:SetPoint("TOPLEFT",x, y)
		Cbox:SetScript("OnEnter", LeaPlusLC.TipSee)
		Cbox:SetScript("OnLeave", GameTooltip_Hide)

		-- Add label and tooltip
		Cbox.f = Cbox:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
		Cbox.f:SetPoint('LEFT', 20, 0)
		if reload then
			-- Checkbox requires UI reload
			Cbox.f:SetText(L[caption] .. "*")
			Cbox.tiptext = L[tip] .. "|n|n* " .. L["Requires UI reload."]
		else
			-- Checkbox does not require UI reload
			Cbox.f:SetText(L[caption])
			Cbox.tiptext = L[tip]
		end

		-- Set label parameters
		Cbox.f:SetJustifyH("LEFT")
		Cbox.f:SetWordWrap(false)

		-- Set maximum label width
		if parent:GetParent() == LeaPlusLC["PageF"] then
			-- Main panel checkbox labels
			if Cbox.f:GetWidth() > 152 then
				Cbox.f:SetWidth(152)
				LeaPlusLC["TruncatedLabelsList"] = LeaPlusLC["TruncatedLabelsList"] or {}
				LeaPlusLC["TruncatedLabelsList"][Cbox.f] = L[caption]
			end
			-- Set checkbox click width
			if Cbox.f:GetStringWidth() > 152 then
				Cbox:SetHitRectInsets(0, -142, 0, 0)
			else
				Cbox:SetHitRectInsets(0, -Cbox.f:GetStringWidth() + 4, 0, 0)
			end
		else
			-- Configuration panel checkbox labels (other checkboxes either have custom functions or blank labels)
			if Cbox.f:GetWidth() > 302 then
				Cbox.f:SetWidth(302)
				LeaPlusLC["TruncatedLabelsList"] = LeaPlusLC["TruncatedLabelsList"] or {}
				LeaPlusLC["TruncatedLabelsList"][Cbox.f] = L[caption]
			end
			-- Set checkbox click width
			if Cbox.f:GetStringWidth() > 302 then
				Cbox:SetHitRectInsets(0, -292, 0, 0)
			else
				Cbox:SetHitRectInsets(0, -Cbox.f:GetStringWidth() + 4, 0, 0)
			end
		end

		-- Set default checkbox state and click area
		Cbox:SetScript('OnShow', function(self)
			if LeaPlusLC[field] == "On" then
				self:SetChecked(true)
			else
				self:SetChecked(false)
			end
		end)

		-- Process clicks
		Cbox:SetScript('OnClick', function()
			if Cbox:GetChecked() then
				LeaPlusLC[field] = "On"
			else
				LeaPlusLC[field] = "Off"
			end
			LeaPlusLC:SetDim(); -- Lock invalid options
			LeaPlusLC:ReloadCheck(); -- Show reload button if needed
		end)
	end

	-- Create an editbox (uses standard template)
	function LeaPlusLC:CreateEditBox(frame, parent, width, maxchars, anchor, x, y, tab, shifttab)

		-- Create editbox
        local eb = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
		LeaPlusCB[frame] = eb
		eb:SetPoint(anchor, x, y)
		eb:SetWidth(width)
		eb:SetHeight(24)
		eb:SetFontObject("GameFontNormal")
		eb:SetTextColor(1.0, 1.0, 1.0)
		eb:SetAutoFocus(false)
		eb:SetMaxLetters(maxchars)
		eb:SetScript("OnEscapePressed", eb.ClearFocus)
		eb:SetScript("OnEnterPressed", eb.ClearFocus)

		-- Add editbox border and backdrop
		eb.f = CreateFrame("FRAME", nil, eb, "BackdropTemplate")
		eb.f:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = false, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }})
		eb.f:SetPoint("LEFT", -6, 0)
		eb.f:SetWidth(eb:GetWidth()+6)
		eb.f:SetHeight(eb:GetHeight())
		eb.f:SetBackdropColor(1.0, 1.0, 1.0, 0.3)

		-- Move onto next editbox when tab key is pressed
		eb:SetScript("OnTabPressed", function(self)
			self:ClearFocus()
			if IsShiftKeyDown() then
				LeaPlusCB[shifttab]:SetFocus()
			else
				LeaPlusCB[tab]:SetFocus()
			end
		end)

		return eb

	end

	-- Create a standard button (using standard button template)
	function LeaPlusLC:CreateButton(name, frame, label, anchor, x, y, width, height, reskin, tip, naked)
		local mbtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
		LeaPlusCB[name] = mbtn
		mbtn:SetSize(width, height)
		mbtn:SetPoint(anchor, x, y)
		mbtn:SetHitRectInsets(0, 0, 0, 0)
		mbtn:SetText(L[label])

		-- Create fontstring so the button can be sized correctly
		mbtn.f = mbtn:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		mbtn.f:SetText(L[label])
		if width > 0 then
			-- Button should have static width
			mbtn:SetWidth(width)
		else
			-- Button should have variable width
			mbtn:SetWidth(mbtn.f:GetStringWidth() + 20)
		end

		-- Tooltip handler
		mbtn.tiptext = L[tip]
		mbtn:SetScript("OnEnter", LeaPlusLC.TipSee)
		mbtn:SetScript("OnLeave", GameTooltip_Hide)

		-- Texture the button
		if reskin then

			-- Set skinned button textures
			if not naked then
				mbtn:SetNormalTexture("Interface\\AddOns\\Leatrix_Plus\\Leatrix_Plus.blp")
				mbtn:GetNormalTexture():SetTexCoord(0.125, 0.25, 0.21875, 0.25)
			end
			mbtn:SetHighlightTexture("Interface\\AddOns\\Leatrix_Plus\\Leatrix_Plus.blp")
			mbtn:GetHighlightTexture():SetTexCoord(0, 0.125, 0.21875, 0.25)

			-- Hide the default textures
			mbtn:HookScript("OnShow", function() mbtn.Left:Hide(); mbtn.Middle:Hide(); mbtn.Right:Hide() end)
			mbtn:HookScript("OnEnable", function() mbtn.Left:Hide(); mbtn.Middle:Hide(); mbtn.Right:Hide() end)
			mbtn:HookScript("OnDisable", function() mbtn.Left:Hide(); mbtn.Middle:Hide(); mbtn.Right:Hide() end)
			mbtn:HookScript("OnMouseDown", function() mbtn.Left:Hide(); mbtn.Middle:Hide(); mbtn.Right:Hide() end)
			mbtn:HookScript("OnMouseUp", function() mbtn.Left:Hide(); mbtn.Middle:Hide(); mbtn.Right:Hide() end)

		end

		return mbtn
	end

	-- Create a dropdown menu (using standard dropdown template)
	function LeaPlusLC:CreateDropdown(frame, label, width, anchor, parent, relative, x, y, items)

		local RadioDropdown = CreateFrame("DropdownButton", nil, parent, "WowStyle1DropdownTemplate")
		LeaPlusCB[frame] = RadioDropdown
		RadioDropdown:SetPoint(anchor, parent, relative, x, y)
		RadioDropdown:SetWidth(width)

		local function IsSelected(value)
			return value == LeaPlusLC[frame]
		end

		local function SetSelected(value)
			LeaPlusLC[frame] = value
		end

		MenuUtil.CreateRadioMenu(RadioDropdown, IsSelected, SetSelected, unpack(items))

		local lf = RadioDropdown:CreateFontString(nil, "OVERLAY", "GameFontNormal"); lf:SetPoint("TOPLEFT", RadioDropdown, 0, 20); lf:SetPoint("TOPRIGHT", RadioDropdown, -5, 20); lf:SetJustifyH("LEFT"); lf:SetText(L[label])

	end

----------------------------------------------------------------------
-- 	Create main options panel frame
----------------------------------------------------------------------

	function LeaPlusLC:CreateMainPanel()

		-- Create the panel
		local PageF = CreateFrame("Frame", nil, UIParent);

		-- Make it a system frame
		_G["LeaPlusGlobalPanel"] = PageF
		table.insert(UISpecialFrames, "LeaPlusGlobalPanel")

		-- Set frame parameters
		LeaPlusLC["PageF"] = PageF
		PageF:SetSize(570, LeaPlusLC.MainPanelHeight)
		PageF:Hide();
		PageF:SetFrameStrata("FULLSCREEN_DIALOG")
		PageF:SetClampedToScreen(true)
		PageF:SetClampRectInsets(500, -500, -300, 300)
		PageF:EnableMouse(true)
		PageF:SetMovable(true)
		PageF:RegisterForDrag("LeftButton")
		PageF:SetScript("OnDragStart", PageF.StartMoving)
		PageF:SetScript("OnDragStop", function ()
			PageF:StopMovingOrSizing();
			PageF:SetUserPlaced(false);
			-- Save panel position
			LeaPlusLC["MainPanelA"], void, LeaPlusLC["MainPanelR"], LeaPlusLC["MainPanelX"], LeaPlusLC["MainPanelY"] = PageF:GetPoint()
		end)

		-- Add background color
		PageF.t = PageF:CreateTexture(nil, "BACKGROUND")
		PageF.t:SetAllPoints()
		PageF.t:SetColorTexture(0.05, 0.05, 0.05, 0.9)

		-- Add textures
		LeaPlusLC:CreateBar("FootTexture", PageF, 570, 48, "BOTTOM", 0.5, 0.5, 0.5, 1.0, "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated.png")
		LeaPlusLC:CreateBar("MainTexture", PageF, 440, LeaPlusLC.MainPanelHeight - 47, "TOPRIGHT", 0.7, 0.7, 0.7, 0.7,  "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated.png")
		LeaPlusLC:CreateBar("MenuTexture", PageF, 130, LeaPlusLC.MainPanelHeight - 47, "TOPLEFT", 0.7, 0.7, 0.7, 0.7, "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated.png")

		-- Set panel position when shown
		PageF:SetScript("OnShow", function()
			PageF:ClearAllPoints()
			PageF:SetPoint(LeaPlusLC["MainPanelA"], UIParent, LeaPlusLC["MainPanelR"], LeaPlusLC["MainPanelX"], LeaPlusLC["MainPanelY"])
		end)

		-- Add main title (shown above menu in the corner)
		PageF.mt = PageF:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
		PageF.mt:SetPoint('TOPLEFT', 16, -16)
		PageF.mt:SetText("Leatrix Plus")

		-- Add version text (shown underneath main title)
		PageF.v = PageF:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
		PageF.v:SetHeight(32);
		PageF.v:SetPoint('TOPLEFT', PageF.mt, 'BOTTOMLEFT', 0, -8);
		PageF.v:SetPoint('RIGHT', PageF, -32, 0)
		PageF.v:SetJustifyH('LEFT'); PageF.v:SetJustifyV('TOP');
		PageF.v:SetNonSpaceWrap(true); PageF.v:SetText(L["MoP"] .. " " .. LeaPlusLC["AddonVer"])

		-- Add reload UI Button
		local reloadb = LeaPlusLC:CreateButton("ReloadUIButton", PageF, "Reload", "BOTTOMRIGHT", -16, 10, 0, 25, true, "Your UI needs to be reloaded for some of the changes to take effect.|n|nYou don't have to click the reload button immediately but you do need to click it when you are done making changes and you want the changes to take effect.")
		LeaPlusLC:LockItem(reloadb,true)
		reloadb:SetScript("OnClick", ReloadUI)

		reloadb.f = reloadb:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
		reloadb.f:SetHeight(32);
		reloadb.f:SetPoint('RIGHT', reloadb, 'LEFT', -10, 0)
		reloadb.f:SetText(L["Your UI needs to be reloaded."])
		reloadb.f:Hide()

		-- Add close Button
		local CloseB = CreateFrame("Button", nil, PageF, "UIPanelCloseButton")
		CloseB:SetSize(30, 30)
		CloseB:SetPoint("TOPRIGHT", 0, 0)
		CloseB:SetScript("OnClick", LeaPlusLC.HideFrames)

		-- Add web link Button
		local PageFAlertButton = LeaPlusLC:CreateButton("PageFAlertButton", PageF, "You should keybind web link!", "BOTTOMLEFT", 16, 10, 0, 25, true, "You should set a keybind for the web link feature.  It's very useful.|n|nOpen the key bindings window (accessible from the game menu) and click Leatrix Plus.|n|nSet a keybind for Show web link.|n|nNow when your pointer is over an item, NPC or spell (and more), press your keybind to get a web link.", true)
		PageFAlertButton:SetPushedTextOffset(0, 0)
		PageF:HookScript("OnShow", function()
			if GetBindingKey("LEATRIX_PLUS_GLOBAL_WEBLINK") then PageFAlertButton:Hide() else PageFAlertButton:Show() end
		end)

		-- Release memory
		LeaPlusLC.CreateMainPanel = nil

	end

	LeaPlusLC:CreateMainPanel();

----------------------------------------------------------------------
-- 	L80: Commands
----------------------------------------------------------------------

	-- Slash command function
	function LeaPlusLC:SlashFunc(str)
		if str and str ~= "" then
			-- Get parameters in lower case with duplicate spaces removed
			local str, arg1, arg2, arg3 = strsplit(" ", string.lower(str:gsub("%s+", " ")))
			-- Traverse parameters
			if str == "wipe" then
				-- Wipe settings
				LeaPlusLC:PlayerLogout(true) -- Run logout function with wipe parameter
				wipe(LeaPlusDB)
				LpEvt:UnregisterAllEvents(); -- Don't save any settings
				ReloadUI();
			elseif str == "nosave" then
				-- Prevent Leatrix Plus from overwriting LeaPlusDB at next logout
				LpEvt:UnregisterEvent("PLAYER_LOGOUT")
				LeaPlusLC:Print("Leatrix Plus will not overwrite LeaPlusDB at next logout.")
				return
			elseif str == "reset" then
				-- Reset panel positions
				LeaPlusLC["MainPanelA"], LeaPlusLC["MainPanelR"], LeaPlusLC["MainPanelX"], LeaPlusLC["MainPanelY"] = "CENTER", "CENTER", 0, 0
				LeaPlusLC["PlusPanelScale"] = 1
				LeaPlusLC["PlusPanelAlpha"] = 0
				LeaPlusLC["PageF"]:SetScale(1)
				LeaPlusLC["PageF"].t:SetAlpha(1 - LeaPlusLC["PlusPanelAlpha"])
				-- Refresh panels
				LeaPlusLC["PageF"]:ClearAllPoints()
				LeaPlusLC["PageF"]:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
				-- Reset currently showing configuration panel
				for k, v in pairs(LeaConfigList) do
					if v:IsShown() then
						v:ClearAllPoints()
						v:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
						v:SetScale(1)
						v.t:SetAlpha(1 - LeaPlusLC["PlusPanelAlpha"])
					end
				end
				-- Refresh Leatrix Plus settings menu only
				if LeaPlusLC["Page8"]:IsShown() then
					LeaPlusLC["Page8"]:Hide()
					LeaPlusLC["Page8"]:Show()
				end
				return
			elseif str == "taint" then
				-- Set taint log level
				if arg1 and arg1 ~= "" then
					arg1 = tonumber(arg1)
					if arg1 and arg1 >= 0 and arg1 <= 2 then
						if arg1 == 0 then
							-- Disable taint log
							ConsoleExec("taintLog 0")
							LeaPlusLC:Print("Taint level: Disabled (0).")
						elseif arg1 == 1 then
							-- Basic taint log
							ConsoleExec("taintLog 1")
							LeaPlusLC:Print("Taint level: Basic (1).")
						elseif arg1 == 2 then
							-- Full taint log
							ConsoleExec("taintLog 2")
							LeaPlusLC:Print("Taint level: Full (2).")
						end
					else
						LeaPlusLC:Print("Invalid taint level.")
					end
				else
					-- Show current taint level
					local taintCurrent = GetCVar("taintLog")
					if taintCurrent == "0" then
						LeaPlusLC:Print("Taint level: Disabled (0).")
					elseif taintCurrent == "1" then
						LeaPlusLC:Print("Taint level: Basic (1).")
					elseif taintCurrent == "2" then
						LeaPlusLC:Print("Taint level: Full (2).")
					end
				end
				return
			elseif str == "quest" then
				-- Show quest completed status
				if arg1 and arg1 ~= "" then
					if arg1 == "wipe" then
						-- Wipe quest log
						for i = 1, GetNumQuestLogEntries() do
							SelectQuestLogEntry(i)
							SetAbandonQuest()
							AbandonQuest()
						end
						LeaPlusLC:Print(L["Quest log wiped."])
						return
					elseif tonumber(arg1) and tonumber(arg1) < 999999999 then
						-- Show quest information
						local questCompleted = C_QuestLog.IsQuestFlaggedCompleted(arg1)
						local questTitle = C_QuestLog.GetQuestInfo(arg1) or L["Unknown"]
						C_Timer.After(0.5, function()
							local questTitle = C_QuestLog.GetQuestInfo(arg1) or L["Unknown"]
							if questCompleted then
								LeaPlusLC:Print(questTitle .. " (" .. arg1 .. "):" .. "|cffffffff " .. L["Completed."])
							else
								LeaPlusLC:Print(questTitle .. " (" .. arg1 .. "):" .. "|cffffffff " .. L["Not completed."])
							end
						end)
					else
						LeaPlusLC:Print("Invalid quest ID.")
					end
				else
					LeaPlusLC:Print("Missing quest ID.")
				end
				return
			elseif str == "rest" then
				-- Show rested bubbles
				LeaPlusLC:Print(L["Rested bubbles"] .. ": |cffffffff" .. (math.floor(20 * (GetXPExhaustion() or 0) / UnitXPMax("player") + 0.5)))
				return
			elseif str == "zygor" then
				-- Toggle Zygor addon
				LeaPlusLC:ZygorToggle()
				return
			elseif str == "npcid" then
				-- Print NPC ID
				local npcName = UnitName("target")
				local npcGuid = UnitGUID("target") or nil
				if npcName and npcGuid then
					local void, void, void, void, void, npcID = strsplit("-", npcGuid)
					if npcID then
						LeaPlusLC:Print(npcName .. ": |cffffffff" .. npcID)
					end
				end
				return
			elseif str == "id" then
				-- Show web link for tooltip
				if not LeaPlusLC.WowheadLock then
					-- Set Wowhead link prefix
						if GameLocale == "deDE" then LeaPlusLC.WowheadLock = "wowhead.com/mop-classic/de"
					elseif GameLocale == "esMX" then LeaPlusLC.WowheadLock = "wowhead.com/mop-classic/mx"
					elseif GameLocale == "esES" then LeaPlusLC.WowheadLock = "wowhead.com/mop-classic/es"
					elseif GameLocale == "frFR" then LeaPlusLC.WowheadLock = "wowhead.com/mop-classic/fr"
					elseif GameLocale == "itIT" then LeaPlusLC.WowheadLock = "wowhead.com/mop-classic/it"
					elseif GameLocale == "ptBR" then LeaPlusLC.WowheadLock = "wowhead.com/mop-classic/pt"
					elseif GameLocale == "ruRU" then LeaPlusLC.WowheadLock = "wowhead.com/mop-classic/ru"
					elseif GameLocale == "koKR" then LeaPlusLC.WowheadLock = "wowhead.com/mop-classic/ko"
					elseif GameLocale == "zhCN" then LeaPlusLC.WowheadLock = "wowhead.com/mop-classic/cn"
					elseif GameLocale == "zhTW" then LeaPlusLC.WowheadLock = "wowhead.com/mop-classic/tw"
					else							 LeaPlusLC.WowheadLock = "wowhead.com/mop-classic"
					end
				end
				-- Store frame under mouse
				local mouseFocus = GetMouseFoci()[1]
				-- Floating battle pet tooltip (linked in chat)
				if FloatingBattlePetTooltip:IsMouseMotionFocus() and FloatingBattlePetTooltip.Name then
					local tipTitle = FloatingBattlePetTooltip.Name:GetText()
					if tipTitle then
						local speciesId, petGUID = C_PetJournal.FindPetIDByName(tipTitle, false)
						if petGUID then
							local speciesID, customName, level, xp, maxXp, displayID, isFavorite, name, icon, petType, creatureID = C_PetJournal.GetPetInfoByPetID(petGUID)
							LeaPlusLC:ShowSystemEditBox("https://" .. LeaPlusLC.WowheadLock .. "/npc=" .. creatureID)
							LeaPlusLC.FactoryEditBox.f:SetText(L["Pet"] .. ": " .. name .. " (" .. creatureID .. ")")
							return
						end
					end
				end
				-- Floating pet battle ability tooltip (linked in chat)
				if FloatingPetBattleAbilityTooltip and FloatingPetBattleAbilityTooltip:IsMouseMotionFocus() and FloatingPetBattleAbilityTooltip.Name then
					local tipTitle = FloatingPetBattleAbilityTooltip.Name:GetText()
					if tipTitle then
						LeaPlusLC:ShowSystemEditBox("https://" .. LeaPlusLC.WowheadLock .. "/search?q=" .. tipTitle, false)
						LeaPlusLC.FactoryEditBox.f:SetText(L["Pet Ability"] .. ": " .. tipTitle)
						return
					end
				end
				-- Pet journal ability tooltip (tooltip in pet journal)
				if PetJournalPrimaryAbilityTooltip and PetJournalPrimaryAbilityTooltip:IsShown() and PetJournalPrimaryAbilityTooltip.Name then
					local tipTitle = PetJournalPrimaryAbilityTooltip.Name:GetText()
					if tipTitle then
						LeaPlusLC:ShowSystemEditBox("https://" .. LeaPlusLC.WowheadLock .. "/search?q=" .. tipTitle, false)
						LeaPlusLC.FactoryEditBox.f:SetText(L["Pet Ability"] .. ": " .. tipTitle)
						return
					end
				end
				-- ItemRefTooltip or GameTooltip
				local tooltip
				if ItemRefTooltip:IsMouseMotionFocus() then tooltip = ItemRefTooltip else tooltip = GameTooltip end
				-- Process tooltip
				if tooltip:IsShown() then
					-- Item
					local void, itemLink = tooltip:GetItem()
					if itemLink then
						local itemID = GetItemInfoFromHyperlink(itemLink)
						if itemID then
							LeaPlusLC:ShowSystemEditBox("https://" .. LeaPlusLC.WowheadLock .. "/item=" .. itemID, false)
							LeaPlusLC.FactoryEditBox.f:SetText(L["Item"] .. ": " .. itemLink .. " (" .. itemID .. ")")
							return
						end
					end
					-- Spell
					local name, spellID = tooltip:GetSpell()
					if name and spellID then
						LeaPlusLC:ShowSystemEditBox("https://" .. LeaPlusLC.WowheadLock .. "/spell=" .. spellID, false)
						LeaPlusLC.FactoryEditBox.f:SetText(L["Spell"] .. ": " .. name .. " (" .. spellID .. ")")
						return
					end
					-- NPC
					local npcName = UnitName("mouseover")
					local npcGuid = UnitGUID("mouseover") or nil
					if npcName and npcGuid then
						local void, void, void, void, void, npcID = strsplit("-", npcGuid)
						if npcID then
							LeaPlusLC:ShowSystemEditBox("https://" .. LeaPlusLC.WowheadLock .. "/npc=" .. npcID, false)
							LeaPlusLC.FactoryEditBox.f:SetText(L["NPC"] .. ": " .. npcName .. " (" .. npcID .. ")")
							return
						end
					end
					-- Buffs and debuffs
					for i = 1, BUFF_MAX_DISPLAY do
						if _G["BuffButton" .. i] and mouseFocus == _G["BuffButton" .. i] then
							local spellName, void, void, void, void, void, void, void, void, spellID = UnitBuff("player", i)
							if spellName and spellID then
								LeaPlusLC:ShowSystemEditBox("https://" .. LeaPlusLC.WowheadLock .. "/spell=" .. spellID, false)
								LeaPlusLC.FactoryEditBox.f:SetText(L["Spell"] .. ": " .. spellName .. " (" .. spellID .. ")")
							end
							return
						end
					end
					for i = 1, DEBUFF_MAX_DISPLAY do
						if _G["DebuffButton" .. i] and mouseFocus == _G["DebuffButton" .. i] then
							local spellName, void, void, void, void, void, void, void, void, spellID = UnitDebuff("player", i)
							if spellName and spellID then
								LeaPlusLC:ShowSystemEditBox("https://" .. LeaPlusLC.WowheadLock .. "/spell=" .. spellID, false)
								LeaPlusLC.FactoryEditBox.f:SetText(L["Spell"] .. ": " .. spellName .. " (" .. spellID .. ")")
							end
							return
						end
					end
					-- Unknown tooltip (this must be last)
					local tipTitle = GameTooltipTextLeft1:GetText()
					if tipTitle then
						local speciesId, petGUID = C_PetJournal.FindPetIDByName(GameTooltipTextLeft1:GetText(), false)
						if petGUID then
							-- Pet
							local speciesID, customName, level, xp, maxXp, displayID, isFavorite, name, icon, petType, creatureID = C_PetJournal.GetPetInfoByPetID(petGUID)
							LeaPlusLC:ShowSystemEditBox("https://" .. LeaPlusLC.WowheadLock .. "/npc=" .. creatureID)
							LeaPlusLC.FactoryEditBox.f:SetText(L["Pet"] .. ": " .. name .. " (" .. creatureID .. ")")
							return
						else
							-- Show unknown link
							local unitFocus
							if mouseFocus == WorldFrame then unitFocus = "mouseover" else unitFocus = select(2, GameTooltip:GetUnit()) end
							if not unitFocus or not UnitIsPlayer(unitFocus) then
								tipTitle = tipTitle:gsub("|c%x%x%x%x%x%x%x%x", "") -- Remove color tag
								LeaPlusLC:ShowSystemEditBox("https://" .. LeaPlusLC.WowheadLock .. "/search?q=" .. tipTitle, false)
								LeaPlusLC.FactoryEditBox.f:SetText("|cffff0000" .. L["Link will search Wowhead"])
								return
							end
						end
					end
				end
				return
			elseif str == "tooltip" then
				-- Print tooltip frame name
				local enumf = EnumerateFrames()
				while enumf do
					if (enumf:GetObjectType() == "GameTooltip" or strfind((enumf:GetName() or ""):lower(),"tip")) and enumf:IsVisible() and enumf:GetPoint() then
						print(enumf:GetName())
					end
					enumf = EnumerateFrames(enumf)
				end
				collectgarbage()
				return
			elseif str == "rsnd" then
				-- Restart sound system
				if LeaPlusCB["StopMusicBtn"] then LeaPlusCB["StopMusicBtn"]:Click() end
				Sound_GameSystem_RestartSoundSystem()
				LeaPlusLC:Print("Sound system restarted.")
				return
			elseif str == "event" then
				-- List events (used for debug)
				LeaPlusLC["DbF"] = LeaPlusLC["DbF"] or CreateFrame("FRAME")
				if not LeaPlusLC["DbF"]:GetScript("OnEvent") then
					LeaPlusLC:Print("Tracing started.")
					LeaPlusLC["DbF"]:RegisterAllEvents()
					LeaPlusLC["DbF"]:SetScript("OnEvent", function(self, event)
						if event == "ACTIONBAR_UPDATE_COOLDOWN"
						or event == "BAG_UPDATE_COOLDOWN"
						or event == "CHAT_MSG_TRADESKILLS"
						or event == "COMBAT_LOG_EVENT_UNFILTERED"
						or event == "SPELL_UPDATE_COOLDOWN"
						or event == "SPELL_UPDATE_USABLE"
						or event == "UNIT_POWER_FREQUENT"
						or event == "UPDATE_INVENTORY_DURABILITY"
						then return
						else
							print(event)
						end
					end)
				else
					LeaPlusLC["DbF"]:UnregisterAllEvents()
					LeaPlusLC["DbF"]:SetScript("OnEvent", nil)
					LeaPlusLC:Print("Tracing stopped.")
				end
				return
			elseif str == "game" then
				-- Show game build
				local version, build, gdate, tocversion = GetBuildInfo()
				LeaPlusLC:Print(L["World of Warcraft"] .. ": |cffffffff" .. version .. "." .. build .. " (" .. gdate .. ") (" .. tocversion .. ")")
				return
			elseif str == "config" then
				-- Show maximum camera distance
				LeaPlusLC:Print(L["Camera distance"] .. ": |cffffffff" .. GetCVar("cameraDistanceMaxZoomFactor"))
				-- Show particle density
				LeaPlusLC:Print(L["Particle density"] .. ": |cffffffff" .. GetCVar("particleDensity"))
				LeaPlusLC:Print(L["Weather density"] .. ": |cffffffff" .. GetCVar("weatherDensity"))
				-- Show config
				LeaPlusLC:Print("SynchroniseConfig: |cffffffff" .. GetCVar("synchronizeConfig"))
				-- Show raid restrictions
				local unRaid = GetAllowLowLevelRaid()
				if unRaid and unRaid == true then
					LeaPlusLC:Print("GetAllowLowLevelRaid: |cffffffff" .. "True")
				else
					LeaPlusLC:Print("GetAllowLowLevelRaid: |cffffffff" .. "False")
				end
				return
			elseif str == "move" then
				-- Move minimap
				MinimapZoneTextButton:Hide()
				MinimapBorderTop:SetTexture("")
				MiniMapWorldMapButton:Hide()
				MinimapBackdrop:ClearAllPoints()
				MinimapBackdrop:SetPoint("CENTER", UIParent, "CENTER", -330, -75)
				Minimap:SetPoint("CENTER", UIParent, "CENTER", -320, -50)
				return
			elseif str == "tipcol" then
				-- Show default tooltip title color
				if GameTooltipTextLeft1:IsShown() then
					local r, g, b, a = GameTooltipTextLeft1:GetTextColor()
					r = r <= 1 and r >= 0 and r or 0
					g = g <= 1 and g >= 0 and g or 0
					b = b <= 1 and b >= 0 and b or 0
					LeaPlusLC:Print(L["Tooltip title color"] .. ": " .. strupper(string.format("%02x%02x%02x", r * 255, g * 255, b * 255) .. "."))
				else
					LeaPlusLC:Print("No tooltip showing.")
				end
				return
			elseif str == "list" then
				-- Enumerate frames
				local frame = EnumerateFrames()
				while frame do
					if (frame:IsVisible() and MouseIsOver(frame)) then
						LeaPlusLC:Print(frame:GetName() or string.format("[Unnamed Frame: %s]", tostring(frame)))
					end
					frame = EnumerateFrames(frame)
				end
				return
			elseif str == "grid" then
				-- Toggle frame alignment grid
				if LeaPlusLC.grid:IsShown() then LeaPlusLC.grid:Hide() else LeaPlusLC.grid:Show() end
				return
			elseif str == "chk" then
				-- List truncated checkbox labels
				if LeaPlusLC["TruncatedLabelsList"] then
					for i, v in pairs(LeaPlusLC["TruncatedLabelsList"]) do
						LeaPlusLC:Print(LeaPlusLC["TruncatedLabelsList"][i])
					end
				else
					LeaPlusLC:Print("Checkbox labels are Ok.")
				end
				return
			elseif str == "cv" then
				-- Print and set console variable setting
				if arg1 and arg1 ~= "" then
					if GetCVar(arg1) then
						if arg2 and arg2 ~= ""  then
							if tonumber(arg2) then
								SetCVar(arg1, arg2)
							else
								LeaPlusLC:Print("Value must be a number.")
								return
							end
						end
						LeaPlusLC:Print(arg1 .. ": |cffffffff" .. GetCVar(arg1))
					else
						LeaPlusLC:Print("Invalid console variable.")
					end
				else
					LeaPlusLC:Print("Missing console variable.")
				end
				return
			elseif str == "play" then
				-- Play sound ID
				if arg1 and arg1 ~= "" then
					if tonumber(arg1) then
						-- Stop last played sound ID
						if LeaPlusLC.SNDcanitHandle then
							StopSound(LeaPlusLC.SNDcanitHandle)
						end
						-- Play sound ID
						LeaPlusLC.SNDcanitPlay, LeaPlusLC.SNDcanitHandle = PlaySound(arg1, "Master", false, false)
						if not LeaPlusLC.SNDcanitPlay then LeaPlusLC:Print(L["Invalid sound ID"] .. ": |cffffffff" .. arg1) end
					else
						LeaPlusLC:Print(L["Invalid sound ID"] .. ": |cffffffff" .. arg1)
					end
				else
					LeaPlusLC:Print("Missing sound ID.")
				end
				return
			elseif str == "stop" then
				-- Stop last played sound ID
				if LeaPlusLC.SNDcanitHandle then
					StopSound(LeaPlusLC.SNDcanitHandle)
				end
				return
			elseif str == "wipecds" then
				-- Wipe cooldowns
				LeaPlusDB["Cooldowns"] = nil
				ReloadUI()
				return
			elseif str == "tipchat" then
				-- Print tooltip contents in chat
				local numLines = GameTooltip:NumLines()
				if numLines then
					for i = 1, numLines do
						print(_G["GameTooltipTextLeft" .. i]:GetText() or "")
					end
				end
				return
			elseif str == "tiplang" then
				-- Tooltip tag locale code constructor
				local msg = ""
				msg = msg .. 'if GameLocale == "' .. GameLocale .. '" then '
				msg = msg .. 'ttLevel = "' .. LEVEL .. '"; '
				msg = msg .. 'ttBoss = "' .. BOSS .. '"; '
				msg = msg .. 'ttElite = "' .. ELITE .. '"; '
				msg = msg .. 'ttRare = "' .. ITEM_QUALITY3_DESC .. '"; '
				msg = msg .. 'ttRareElite = "' .. ITEM_QUALITY3_DESC .. " " .. ELITE .. '"; '
				msg = msg .. 'ttRareBoss = "' .. ITEM_QUALITY3_DESC .. " " .. BOSS .. '"; '
				msg = msg .. 'ttTarget = "' .. TARGET .. '"; '
				msg = msg .. "end"
				print(msg)
				return
			elseif str == "con" then
				-- Show the developer console
				DeveloperConsole:SetFontHeight(28)
				DeveloperConsole:Toggle(true)
				return
			elseif str == "movie" then
				-- Playback movie by ID
				arg1 = tonumber(arg1)
				if arg1 and arg1 ~= "" then
					-- Play movie by ID
					if IsMoviePlayable(arg1) then
						MovieFrame_PlayMovie(MovieFrame, arg1)
					else
						LeaPlusLC:Print("Movie not playable.")
					end
				else
					-- List playable movie IDs
					local count = 0
					for i = 1, 1000 do
						if IsMoviePlayable(i) then
							print(i)
							count = count + 1
						end
					end
					LeaPlusLC:Print("Total movies: |cffffffff" .. count)
				end
				return
			elseif str == "cin" then
				-- Play opening cinematic (only works if character has never gained XP) (used for testing)
				OpeningCinematic()
				return
			elseif str == "skit" then
				-- Play a test sound kit
				PlaySound(1020, "Master", false, true)
				return
			elseif str == "marker" then
				-- Prevent showing raid target markers on self
				if not LeaPlusLC.MarkerFrame then
					LeaPlusLC.MarkerFrame = CreateFrame("FRAME")
					LeaPlusLC.MarkerFrame:RegisterEvent("RAID_TARGET_UPDATE")
				end
				LeaPlusLC.MarkerFrame.Update = true
				if LeaPlusLC.MarkerFrame.Toggle == false then
					-- Show markers
					LeaPlusLC.MarkerFrame:SetScript("OnEvent", nil)
					ActionStatus_DisplayMessage(L["Self Markers Allowed"], true)
					LeaPlusLC.MarkerFrame.Toggle = true
				else
					-- Hide markers
					SetRaidTarget("player", 0)
					LeaPlusLC.MarkerFrame:SetScript("OnEvent", function()
						if LeaPlusLC.MarkerFrame.Update == true then
							LeaPlusLC.MarkerFrame.Update = false
							SetRaidTarget("player", 0)
						end
						LeaPlusLC.MarkerFrame.Update = true
					end)
					ActionStatus_DisplayMessage(L["Self Markers Blocked"], true)
					LeaPlusLC.MarkerFrame.Toggle = false
				end
				return
			elseif str == "pos" then
				-- Map POI code builder
				local mapID = C_Map.GetBestMapForUnit("player") or nil
				local mapName = C_Map.GetMapInfo(mapID).name or nil
				local mapRects = {}
				local tempVec2D = CreateVector2D(0, 0)
				local void
				-- Get player map position
				tempVec2D.x, tempVec2D.y = UnitPosition("player")
				if not tempVec2D.x then return end
				local mapRect = mapRects[mapID]
				if not mapRect then
					mapRect = {}
					void, mapRect[1] = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(0, 0))
					void, mapRect[2] = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(1, 1))
					mapRect[2]:Subtract(mapRect[1])
					mapRects[mapID] = mapRect
				end
				tempVec2D:Subtract(mapRects[mapID][1])
				local pX, pY = tempVec2D.y/mapRects[mapID][2].y, tempVec2D.x/mapRects[mapID][2].x
				pX = string.format("%0.1f", 100 * pX)
				pY = string.format("%0.1f", 100 * pY)
				if mapID and mapName and pX and pY then
					ChatFrame1:Clear()
					local dnType, dnTex = "Dungeon", "dnTex"
					if arg1 == "raid" then dnType, dnTex = "Raid", "rdTex" end
					if arg1 == "portal" then dnType = "Portal" end
					print('[' .. mapID .. '] =  --[[' .. mapName .. ']] {{' .. pX .. ', ' .. pY .. ', L[' .. '"Name"' .. '], L[' .. '"' .. dnType .. '"' .. '], ' .. dnTex .. '},},')
				end
				return
			elseif str == "mapref" then
				-- Print map reveal structure code
				if not WorldMapFrame:IsShown() then
					LeaPlusLC:Print("Open the map first!")
					return
				end
				ChatFrame1:Clear()
				local msg = ""
				local mapID = WorldMapFrame.mapID
				local mapName = C_Map.GetMapInfo(mapID).name
				local mapArt = C_Map.GetMapArtID(mapID)
				msg = msg .. "--[[" .. mapName .. "]] [" .. mapArt .. "] = {"
				local exploredMapTextures = C_MapExplorationInfo.GetExploredMapTextures(mapID);
				if exploredMapTextures then
					for i, exploredTextureInfo in ipairs(exploredMapTextures) do
						local twidth = exploredTextureInfo.textureWidth or 0
						if twidth > 0 then
							local theight = exploredTextureInfo.textureHeight or 0
							local offsetx = exploredTextureInfo.offsetX
							local offsety = exploredTextureInfo.offsetY
							local filedataIDS = exploredTextureInfo.fileDataIDs
							msg = msg .. "[" .. '"' .. twidth .. ":" .. theight .. ":" .. offsetx .. ":" .. offsety .. '"' .. "] = " .. '"'
							for fileData = 1, #filedataIDS do
								msg = msg .. filedataIDS[fileData]
								if fileData < #filedataIDS then
									msg = msg .. ", "
								else
									msg = msg .. '",'
									if i < #exploredMapTextures then
										msg = msg .. " "
									end
								end
							end
						end
					end
					msg = msg .. "},"
					print(msg)
				end
				return
			elseif str == "mk" then
				-- Print a map key
				if not arg1 then LeaPlusLC:Print("Key missing!") return end
				if not tonumber(arg1) then LeaPlusLC:Print("Must be a number!") return end
				local key = arg1
				ChatFrame1:Clear()
				print('"' .. mod(floor(key / 2^36), 2^12) .. ":" .. mod(floor(key / 2^24), 2^12) .. ":" .. mod(floor(key / 2^12), 2^12) .. ":" .. mod(key, 2^12) .. '"')
				return
			elseif str == "map" then
				-- Set map by ID, print currently showing map ID or print character map ID
				if not arg1 then
					-- Print map ID
					if WorldMapFrame:IsShown() then
						-- Show world map ID
						local mapID = WorldMapFrame.mapID or nil
						local artID = C_Map.GetMapArtID(mapID) or nil
						local mapName = C_Map.GetMapInfo(mapID).name or nil
						if mapID and artID and mapName then
							LeaPlusLC:Print(mapID .. " (" .. artID .. "): " .. mapName .. " (map)")
						end
					else
						-- Show character map ID
						local mapID = C_Map.GetBestMapForUnit("player") or nil
						local artID = C_Map.GetMapArtID(mapID) or nil
						local mapName = C_Map.GetMapInfo(mapID).name or nil
						if mapID and artID and mapName then
							LeaPlusLC:Print(mapID .. " (" .. artID .. "): " .. mapName .. " (player)")
						end
					end
					return
				elseif not tonumber(arg1) or not C_Map.GetMapInfo(arg1) then
					-- Invalid map ID
					LeaPlusLC:Print("Invalid map ID.")
				else
					-- Set map by ID
					WorldMapFrame:SetMapID(tonumber(arg1))
				end
				return
			elseif str == "cls" then
				-- Clear chat frame
				ChatFrame1:Clear()
				return
			elseif str == "al" then
				-- Enable auto loot
				SetCVar("autoLootDefault", "1")
				LeaPlusLC:Print("Auto loot is now enabled.")
				return
			elseif str == "realm" then
				-- Show list of connected realms
				local titleRealm = GetRealmName()
				local userRealm = GetNormalizedRealmName()
				local connectedServers = GetAutoCompleteRealms()
				if titleRealm and userRealm and connectedServers then
					LeaPlusLC:Print(L["Connections for"] .. "|cffffffff " .. titleRealm)
					if #connectedServers > 0 then
						local count = 1
						for i = 1, #connectedServers do
							if userRealm ~= connectedServers[i] then
								LeaPlusLC:Print(count .. ".  " .. connectedServers[i])
								count = count + 1
							end
						end
					else
						LeaPlusLC:Print("None")
					end
				end
				return
			elseif str == "dup" then
				-- Print music track duplicates
				local mask, found, badidfound = false, false, false
				for i, e in pairs(Leatrix_Plus["ZoneList"]) do
					if Leatrix_Plus["ZoneList"][e] then
						for a, b in pairs(Leatrix_Plus["ZoneList"][e]) do
							local same = {}
							if b.tracks then
								for k, v in pairs(b.tracks) do
									-- Check for bad sound IDs
									if not strfind(v, "|c") then
										if not v:match("([^,]+)%#([^,]+)%#([^,]+)") then
											local temFile, temSoundID = v:match("([^,]+)%#([^,]+)")
											if temSoundID then
												local temPlay, temHandle = PlaySound(temSoundID, "Master", false, true)
												if temHandle then StopSound(temHandle) end
												temPlay, temHandle = PlaySound(temSoundID, "Master", false, true)
												if not temPlay and not temHandle then
													print("|cffff5400" .. L["Bad ID"] .. ": |r" .. e, v)
													badidfound = true
												else
													if temHandle then StopSound(temHandle) end
												end
											end
										end
										-- Check for duplicate IDs
										if tContains(same, v) and mask == false then
											mask = true
											found = true
											print("|cffec51ff" .. L["Dup ID"] .. ": |r" .. e, v)
										end
										tinsert(same, v)
										mask = false
									end
								end
							end
						end
					end
				end
				if badidfound == false then
					LeaPlusLC:Print("No bad sound IDs found.")
				end
				if found == false then
					LeaPlusLC:Print("No media duplicates found.")
				end
				Sound_GameSystem_RestartSoundSystem()
				collectgarbage()
				return
			elseif str == "help" then
				-- Help panel
				if not LeaPlusLC.HelpFrame then
					local frame = CreateFrame("FRAME", nil, UIParent)
					frame:SetSize(570, 360); frame:SetFrameStrata("FULLSCREEN_DIALOG"); frame:SetFrameLevel(100)
					frame.tex = frame:CreateTexture(nil, "BACKGROUND"); frame.tex:SetAllPoints(); frame.tex:SetColorTexture(0.05, 0.05, 0.05, 0.9)
					frame.close = CreateFrame("Button", nil, frame, "UIPanelCloseButton"); frame.close:SetSize(30, 30); frame.close:SetPoint("TOPRIGHT", 0, 0); frame.close:SetScript("OnClick", function() frame:Hide() end)
					frame:ClearAllPoints(); frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
					frame:SetClampedToScreen(true)
					frame:SetClampRectInsets(450, -450, -300, 300)
					frame:EnableMouse(true)
					frame:SetMovable(true)
					frame:RegisterForDrag("LeftButton")
					frame:SetScript("OnDragStart", frame.StartMoving)
					frame:SetScript("OnDragStop", function() frame:StopMovingOrSizing() frame:SetUserPlaced(false) end)
					frame:Hide()
					LeaPlusLC:CreateBar("HelpPanelMainTexture", frame, 570, 360, "TOPRIGHT", 0.7, 0.7, 0.7, 0.7,  "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated.png")
					-- Panel contents
					local col1, col2, color1 = 10, 120, "|cffffffaa"
					LeaPlusLC:MakeTx(frame, "Leatrix Plus Help", col1, -10)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp", col1, -30)
					LeaPlusLC:MakeWD(frame, "Toggle opttions panel.", col2, -30)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp reset", col1, -50)
					LeaPlusLC:MakeWD(frame, "Reset addon panel position and scale.", col2, -50)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp wipe", col1, -70)
					LeaPlusLC:MakeWD(frame, "Wipe all addon settings (reloads UI).", col2, -70)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp realm", col1, -90)
					LeaPlusLC:MakeWD(frame, "Show realms connected to yours.", col2, -90)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp rest", col1, -110)
					LeaPlusLC:MakeWD(frame, "Show number of rested XP bubbles remaining.", col2, -110)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp quest <id>", col1, -130)
					LeaPlusLC:MakeWD(frame, "Show quest completion status for <quest id>.", col2, -130)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp quest wipe", col1, -150)
					LeaPlusLC:MakeWD(frame, "Wipe your quest log.", col2, -150)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp grid", col1, -170)
					LeaPlusLC:MakeWD(frame, "Toggle a frame alignment grid.", col2, -170)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp id", col1, -190)
					LeaPlusLC:MakeWD(frame, "Show a web link for whatever the pointer is over.", col2, -190)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp zygor", col1, -210)
					LeaPlusLC:MakeWD(frame, "Toggle the Zygor addon (reloads UI).", col2, -210)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp movie <id>", col1, -230)
					LeaPlusLC:MakeWD(frame, "Play a movie by its ID.", col2, -230)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp marker", col1, -250)
					LeaPlusLC:MakeWD(frame, "Block target markers (toggle) (requires assistant or leader in raid).", col2, -250)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp rsnd", col1, -270)
					LeaPlusLC:MakeWD(frame, "Restart the sound system.", col2, -270)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp ra", col1, -290)
					LeaPlusLC:MakeWD(frame, "Announce target in General chat channel (useful for rares).", col2, -290)
					LeaPlusLC:MakeWD(frame, color1 .. "/ltp con", col1, -310)
					LeaPlusLC:MakeWD(frame, "Launch the developer console with a large font.", col2, -310)
					LeaPlusLC:MakeWD(frame, color1 .. "/rl", col1, -330)
					LeaPlusLC:MakeWD(frame, "Reload the UI.", col2, -330)
					LeaPlusLC.HelpFrame = frame
					_G["LeaPlusGlobalHelpPanel"] = frame
					table.insert(UISpecialFrames, "LeaPlusGlobalHelpPanel")
				end
				if LeaPlusLC.HelpFrame:IsShown() then LeaPlusLC.HelpFrame:Hide() else LeaPlusLC.HelpFrame:Show() end
				return
			elseif str == "ra" then
				-- Announce target name, health percentage, coordinates and map pin link in General chat channel
				local genChannel
				if GameLocale == "deDE" 	then genChannel = "Allgemein"
				elseif GameLocale == "esMX" then genChannel = "General"
				elseif GameLocale == "esES" then genChannel = "General"
				elseif GameLocale == "frFR" then genChannel = "Général"
				elseif GameLocale == "itIT" then genChannel = "Generale"
				elseif GameLocale == "ptBR" then genChannel = "Geral"
				elseif GameLocale == "ruRU" then genChannel = "Общий"
				elseif GameLocale == "koKR" then genChannel = "공개"
				elseif GameLocale == "zhCN" then genChannel = "综合"
				elseif GameLocale == "zhTW" then genChannel = "綜合"
				else							 genChannel = "General"
				end
				if genChannel then
					local index = GetChannelName(genChannel)
					if index and index > 0 then
						local mapID = C_Map.GetBestMapForUnit("player")
						local pos = C_Map.GetPlayerMapPosition(mapID, "player")
						if pos.x and pos.x ~= "0" and pos.y and pos.y ~= "0" then
							local uHealth = UnitHealth("target")
							local uHealthMax = UnitHealthMax("target")
							-- Announce in chat
							if uHealth and uHealth > 0 and uHealthMax and uHealthMax > 0 then
								-- Get unit classification (elite, rare, rare elite or boss)
								local unitType, unitTag = UnitClassification("target"), ""
								if unitType then
									if unitType == "rare" or unitType == "rareelite" then unitTag = "(" .. L["Rare"] .. ") " elseif unitType == "worldboss" then unitTag = "(" .. L["Boss"] .. ") " end
								end
								C_ChatInfo.SendChatMessage(format("%%t " .. unitTag .. "(%d%%)%s", uHealth / uHealthMax * 100, " " .. string.format("%.0f", pos.x * 100) .. ":" .. string.format("%.0f", pos.y * 100)), "CHANNEL", nil, index)
								--C_ChatInfo.SendChatMessage(format("%%t " .. unitTag .. "(%d%%)%s", uHealth / uHealthMax * 100, " " .. string.format("%.0f", pos.x * 100) .. ":" .. string.format("%.0f", pos.y * 100)), "WHISPER", nil, GetUnitName("player")) -- Debug
							else
								LeaPlusLC:Print("Invalid target.")
							end
						else
							LeaPlusLC:Print("Cannot announce in this zone.")
						end
					else
						LeaPlusLC:Print("Cannot find General chat channel.")
					end
				end
				return
			elseif str == "perf" then
				-- Average FPS during combat
				local fTab = {}
				if not LeaPlusLC.perf then
					LeaPlusLC.perf = CreateFrame("FRAME")
				end
				local fFrm = LeaPlusLC.perf
				local k, startTime = 0, 0
				if fFrm:IsEventRegistered("PLAYER_REGEN_DISABLED") then
					fFrm:UnregisterAllEvents()
					fFrm:SetScript("OnUpdate", nil)
					LeaPlusLC:Print("PERF unloaded.")
				else
					fFrm:RegisterEvent("PLAYER_REGEN_DISABLED")
					fFrm:RegisterEvent("PLAYER_REGEN_ENABLED")
					LeaPlusLC:Print("Waiting for combat to start...")
				end
				fFrm:SetScript("OnEvent", function(self, event)
					if event == "PLAYER_REGEN_DISABLED" then
						LeaPlusLC:Print("Monitoring FPS during combat...")
						fFrm:SetScript("OnUpdate", function()
							k = k + 1
							fTab[k] = GetFramerate()
						end)
						startTime = GetTime()
					else
						fFrm:SetScript("OnUpdate", nil)
						local tSum = 0
						for i = 1, #fTab do
							tSum = tSum + fTab[i]
						end
						local timeTaken = string.format("%.0f", GetTime() - startTime)
						if tSum > 0 then
							LeaPlusLC:Print("Average FPS for " .. timeTaken .. " seconds of combat: " .. string.format("%.0f", tSum / #fTab))
						end
					end
				end)
				return
			elseif str == "col" then
				-- Convert color values
				LeaPlusLC:Print("|n")
				local r, g, b = tonumber(arg1), tonumber(arg2), tonumber(arg3)
				if r and g and b then
					-- RGB source
					LeaPlusLC:Print("Source: |cffffffff" .. r .. " " .. g .. " " .. b .. " ")
					-- RGB to Hex
					if r > 1 and g > 1 and b > 1 then
						-- RGB to Hex
						LeaPlusLC:Print("Hex: |cffffffff" .. strupper(string.format("%02x%02x%02x", r, g, b)) .. " (from RGB)")
					else
						-- Wow to Hex
						LeaPlusLC:Print("Hex: |cffffffff" .. strupper(string.format("%02x%02x%02x", r * 255, g * 255, b * 255)) .. " (from Wow)")
						-- Wow to RGB
						local rwow = string.format("%.0f", r * 255)
						local gwow = string.format("%.0f", g * 255)
						local bwow = string.format("%.0f", b * 255)
						if rwow ~= "0.0" and gwow ~= "0.0" and bwow ~= "0.0" then
							LeaPlusLC:Print("RGB: |cffffffff" .. rwow .. " " .. gwow .. " " .. bwow .. " (from Wow)")
						end
					end
					-- RGB to Wow
					local rwow = string.format("%.1f", r / 255)
					local gwow = string.format("%.1f", g / 255)
					local bwow = string.format("%.1f", b / 255)
					if rwow ~= "0.0" and gwow ~= "0.0" and bwow ~= "0.0" then
						LeaPlusLC:Print("Wow: |cffffffff" .. rwow .. " " .. gwow .. " " .. bwow)
					end
					LeaPlusLC:Print("|n")
				elseif arg1 and strlen(arg1) == 6 and strmatch(arg1,"%x") and arg2 == nil and arg3 == nil then
					-- Hex source
					local rhex, ghex, bhex = string.sub(arg1, 1, 2), string.sub(arg1, 3, 4), string.sub(arg1, 5, 6)
					if strmatch(rhex,"%x") and strmatch(ghex,"%x") and strmatch(bhex,"%x") then
						LeaPlusLC:Print("Source: |cffffffff" .. strupper(arg1))
						LeaPlusLC:Print("Wow: |cffffffff" .. string.format("%.1f", tonumber(rhex, 16) / 255) ..  "  " .. string.format("%.1f", tonumber(ghex, 16) / 255) .. "  " .. string.format("%.1f", tonumber(bhex, 16) / 255))
						LeaPlusLC:Print("RGB: |cffffffff" .. tonumber(rhex, 16) .. "  " .. tonumber(ghex, 16) .. "  " .. tonumber(bhex, 16))
					else
						LeaPlusLC:Print("Invalid arguments.")
					end
					LeaPlusLC:Print("|n")
				else
					LeaPlusLC:Print("Invalid arguments.")
				end
				return
			elseif str == "click" then
				-- Click a button (optional x number of times)
				local mouseFoci = GetMouseFoci()
				if mouseFoci then
					local frame = mouseFoci[#mouseFoci]
					local ftype = frame:GetObjectType()
					if frame and ftype and ftype == "Button" then
						if arg1 and tonumber(arg1) > 1 and tonumber(arg1) < 1000 then
							for i =1, tonumber(arg1) do C_Timer.After(0.1 * i, function() frame:Click() end) end
						else
							frame:Click()
						end
					else
						LeaPlusLC:Print("Hover the pointer over a button.")
					end
					return
				end
			elseif str == "frame" then
				-- Print frame name under mouse
				local mouseFoci = GetMouseFoci()
				if mouseFoci then
					local frame = mouseFoci[#mouseFoci]
					local ftype = frame:GetObjectType()
					if frame and ftype then
						local fname = frame:GetName()
						local issecure, tainted = issecurevariable(fname)
						if issecure then issecure = "Yes" else issecure = "No" end
						if tainted then tainted = "Yes" else tainted = "No" end
						if fname then
							LeaPlusLC:Print("Name: |cffffffff" .. fname)
							LeaPlusLC:Print("Type: |cffffffff" .. ftype)
							LeaPlusLC:Print("Secure: |cffffffff" .. issecure)
							LeaPlusLC:Print("Tainted: |cffffffff" .. tainted)
						end
					end
				end
				return
			elseif str == "arrow" then
				-- Arrow (left: drag, shift/ctrl: rotate, mouseup: loc, pointer must be on arrow stem)
				local f = CreateFrame("Frame", nil, WorldMapFrame.ScrollContainer)
				f:SetSize(64, 64)
				f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
				f:SetFrameLevel(500)
				f:SetParent(WorldMapFrame.ScrollContainer)
				f:SetScale(0.6)

				f.t = f:CreateTexture(nil, "ARTWORK")
				f.t:SetAtlas("Garr_LevelUpgradeArrow")
				f.t:SetAllPoints()

				f.f = f:CreateFontString(nil, "ARTWORK", "GameFontNormal")
				f.f:SetText("0.0")

				local x = 0
				f:SetScript("OnUpdate", function()
					if IsShiftKeyDown() then
						x = x + 0.01
						if x > 6.3 then x = 0 end
						f.t:SetRotation(x)
						f.f:SetFormattedText("%.1f", x)
					elseif IsControlKeyDown() then
						x = x - 0.01
						if x < 0 then x = 6.3 end
						f.t:SetRotation(x)
						f.f:SetFormattedText("%.1f", x)
					end
					-- Print coordinates when mouse is in right place
					local x, y = WorldMapFrame.ScrollContainer:GetNormalizedCursorPosition()
					if x and y and x > 0 and y > 0 then
						if MouseIsOver(f, -31, 31, 31, -31) then
							ChatFrame1:Clear()
							print(('{"Arrow", ' .. floor(x * 1000 + 0.5) / 10) .. ',', (floor(y * 1000 + 0.5) / 10) .. ', L["Step 1"], L["Start here."], arTex, nil, nil, nil, nil, nil, ' .. f.f:GetText() .. "},")
							PlaySoundFile(567412, "Master", false, true)
						end
					end
				end)

				f:SetMovable(true)
				f:SetScript("OnMouseDown", function(self, btn)
					if btn == "LeftButton" then
						f:StartMoving()
					end
				end)

				f:SetScript("OnMouseUp", function()
					f:StopMovingOrSizing()
					--ChatFrame1:Clear()
					--local x, y = WorldMapFrame.ScrollContainer:GetNormalizedCursorPosition()
					--if x and y and x > 0 and y > 0 and MouseIsOver(f) then
					--	print(('{"Arrow", ' .. floor(x * 1000 + 0.5) / 10) .. ',', (floor(y * 1000 + 0.5) / 10) .. ', L["Step 1"], L["Start here."], ' .. f.f:GetText() .. "},")
					--end
				end)
				return
			elseif str == "dis" then
				-- Disband group
				if not LeaPlusLC:IsInLFGQueue() and not IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
					local x = GetNumGroupMembers() or 0
					for i = x, 1, -1 do
						if GetNumGroupMembers() > 0 then
							local name = GetRaidRosterInfo(i)
							if name and name ~= UnitName("player") then
								UninviteUnit(name)
							end
						end
					end
				else
					LeaPlusLC:Print("You cannot do that while in group finder.")
				end
				return
			elseif str == "reinv" then
				-- Disband and reinvite raid
				if not LeaPlusLC:IsInLFGQueue() then
					if UnitIsGroupLeader("player") then
						-- Disband
						local groupNames = {}
						local x = GetNumGroupMembers() or 0
						for i = x, 1, -1 do
							if GetNumGroupMembers() > 0 then
								local name = GetRaidRosterInfo(i)
								if name and name ~= UnitName("player") then
									UninviteUnit(name)
									tinsert(groupNames, name)
								end
							end
						end
						-- Reinvite
						C_Timer.After(0.1, function()
							for k, v in pairs(groupNames) do
								C_PartyInfo.InviteUnit(v)
							end
						end)
					else
						LeaPlusLC:Print("You need to be group leader.")
					end
				else
					LeaPlusLC:Print("You cannot do that while in group finder.")
				end
				return
			elseif str == "limit" then
				-- Sound Limit
				if not LeaPlusLC.MuteFrame then
					-- Panel frame
					local frame = CreateFrame("FRAME", nil, UIParent)
					frame:SetSize(294, 86); frame:SetFrameStrata("FULLSCREEN_DIALOG"); frame:SetFrameLevel(100); frame:SetScale(2)
					frame.tex = frame:CreateTexture(nil, "BACKGROUND"); frame.tex:SetAllPoints(); frame.tex:SetColorTexture(0.05, 0.05, 0.05, 0.9)
					frame.close = CreateFrame("Button", nil, frame, "UIPanelCloseButton"); frame.close:SetSize(30, 30); frame.close:SetPoint("TOPRIGHT", 0, 0); frame.close:SetScript("OnClick", function() frame:Hide() end)
					frame:ClearAllPoints(); frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
					frame:SetClampedToScreen(true)
					frame:EnableMouse(true)
					frame:SetMovable(true)
					frame:RegisterForDrag("LeftButton")
					frame:SetScript("OnDragStart", frame.StartMoving)
					frame:SetScript("OnDragStop", function() frame:StopMovingOrSizing() frame:SetUserPlaced(false) end)
					frame:Hide()
					LeaPlusLC:CreateBar("MutePanelMainTexture", frame, 294, 86, "TOPRIGHT", 0.7, 0.7, 0.7, 0.7,  "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated.png")
					-- Panel contents
					LeaPlusLC:MakeTx(frame, "Sound Limit", 16, -12)
					local endBox = LeaPlusLC:CreateEditBox("SoundEndBox", frame, 116, 10, "TOPLEFT", 16, -32, "SoundEndBox", "SoundEndBox")
					endBox:SetText(3000000)
					endBox:SetScript("OnMouseWheel", function(self, delta)
						local endSound = tonumber(endBox:GetText())
						if endSound then
							if delta == 1 then endSound = endSound + LeaPlusLC.SoundByte else endSound = endSound - LeaPlusLC.SoundByte end
							if endSound < 1 then endSound = 1 elseif endSound >= 3000000 then endSound = 3000000 end
							endBox:SetText(endSound)
						else
							endSound = 100000
							endBox:SetText(endSound)
						end
					end)
					-- Set limit button
					frame.btn = LeaPlusLC:CreateButton("muteRangeButton", frame, "SET LIMIT", "TOPLEFT", 16, -72, 0, 25, true, "Click to set the sound file limit.  Use the mousewheel on the editbox along with the step buttons below to adjust the sound limit.  Acceptable range is from 1 to 3000000.  Sound files higher than this limit will be muted.")
					frame.btn:ClearAllPoints()
					frame.btn:SetPoint("LEFT", endBox, "RIGHT", 10, 0)
					frame.btn:SetScript("OnClick", function()
						local endSound = tonumber(endBox:GetText())
						if endSound then
							if endSound > 3000000 then endSound = 3000000 endBox:SetText(endSound) end
							frame.btn:SetText("WAIT")
							C_Timer.After(0.1, function()
								for i = 1, 3000000 do
									MuteSoundFile(i)
								end
								for i = 1, endSound do
									UnmuteSoundFile(i)
								end
								Sound_GameSystem_RestartSoundSystem()
								frame.btn:SetText("SET LIMIT")
							end)
						else
							frame.btn:SetText("INVALID")
							frame.btn:EnableMouse(false)
							C_Timer.After(2, function()
								frame.btn:SetText("SET LIMIT")
								frame.btn:EnableMouse(true)
							end)
						end
					end)
					-- Mute all button
					frame.MuteAllBtn = LeaPlusLC:CreateButton("muteMuteAllButton", frame, "MUTE ALL", "TOPLEFT", 16, -92, 0, 25, true, "Click to mute every sound in the game.")
					frame.MuteAllBtn:SetScale(0.5)
					frame.MuteAllBtn:ClearAllPoints()
					frame.MuteAllBtn:SetPoint("TOPLEFT", frame.btn, "TOPRIGHT", 20, 0)
					frame.MuteAllBtn:SetScript("OnClick", function()
						frame.MuteAllBtn:SetText("WAIT")
						C_Timer.After(0.1, function()
							for i = 1, 3000000 do
								MuteSoundFile(i)
							end
							Sound_GameSystem_RestartSoundSystem()
							frame.MuteAllBtn:SetText("MUTE ALL")
						end)
						return
					end)
					-- Unmute all button
					frame.UnmuteAllBtn = LeaPlusLC:CreateButton("muteUnmuteAllButton", frame, "UNMUTE ALL", "TOPLEFT", 16, -92, 0, 25, true, "Click to unmute every sound in the game.")
					frame.UnmuteAllBtn:SetScale(0.5)
					frame.UnmuteAllBtn:ClearAllPoints()
					frame.UnmuteAllBtn:SetPoint("TOPLEFT", frame.MuteAllBtn, "BOTTOMLEFT", 0, -10)
					frame.UnmuteAllBtn:SetScript("OnClick", function()
						frame.UnmuteAllBtn:SetText("WAIT")
						C_Timer.After(0.1, function()
							for i = 1, 3000000 do
								UnmuteSoundFile(i)
							end
							Sound_GameSystem_RestartSoundSystem()
							frame.UnmuteAllBtn:SetText("UNMUTE ALL")
						end)
						return
					end)
					-- Step buttons
					frame.millionBtn = LeaPlusLC:CreateButton("SoundMillionButton", frame, "1000000", "TOPLEFT", 26, -122, 0, 25, true, "Set the editbox step value to 1000000.")
					frame.millionBtn:SetScale(0.5)

					frame.hundredThousandBtn = LeaPlusLC:CreateButton("SoundHundredThousandButton", frame, "100000", "TOPLEFT", 16, -112, 0, 25, true, "Set the editbox step value to 100000.")
					frame.hundredThousandBtn:ClearAllPoints()
					frame.hundredThousandBtn:SetPoint("LEFT", frame.millionBtn, "RIGHT", 10, 0)
					frame.hundredThousandBtn:SetScale(0.5)

					frame.tenThousandBtn = LeaPlusLC:CreateButton("SoundTenThousandButton", frame, "10000", "TOPLEFT", 16, -112, 0, 25, true, "Set the editbox step value to 10000.")
					frame.tenThousandBtn:ClearAllPoints()
					frame.tenThousandBtn:SetPoint("LEFT", frame.hundredThousandBtn, "RIGHT", 10, 0)
					frame.tenThousandBtn:SetScale(0.5)

					frame.thousandBtn = LeaPlusLC:CreateButton("SoundThousandButton", frame, "1000", "TOPLEFT", 16, -112, 0, 25, true, "Set the editbox step value to 1000.")
					frame.thousandBtn:ClearAllPoints()
					frame.thousandBtn:SetPoint("LEFT", frame.tenThousandBtn, "RIGHT", 10, 0)
					frame.thousandBtn:SetScale(0.5)

					frame.hundredBtn = LeaPlusLC:CreateButton("SoundHundredButton", frame, "100", "TOPLEFT", 16, -112, 0, 25, true, "Set the editbox step value to 100.")
					frame.hundredBtn:ClearAllPoints()
					frame.hundredBtn:SetPoint("LEFT", frame.thousandBtn, "RIGHT", 10, 0)
					frame.hundredBtn:SetScale(0.5)

					frame.tenBtn = LeaPlusLC:CreateButton("SoundTenButton", frame, "10", "TOPLEFT", 16, -112, 0, 25, true, "Set the editbox step value to 10.")
					frame.tenBtn:ClearAllPoints()
					frame.tenBtn:SetPoint("LEFT", frame.hundredBtn, "RIGHT", 10, 0)
					frame.tenBtn:SetScale(0.5)

					frame.oneBtn = LeaPlusLC:CreateButton("SoundTenButton", frame, "1", "TOPLEFT", 16, -112, 0, 25, true, "Set the editbox step value to 1.")
					frame.oneBtn:ClearAllPoints()
					frame.oneBtn:SetPoint("LEFT", frame.tenBtn, "RIGHT", 10, 0)
					frame.oneBtn:SetScale(0.5)

					local function DimAllBoxes()
						frame.millionBtn:SetAlpha(0.3)
						frame.hundredThousandBtn:SetAlpha(0.3)
						frame.tenThousandBtn:SetAlpha(0.3)
						frame.thousandBtn:SetAlpha(0.3)
						frame.hundredBtn:SetAlpha(0.3)
						frame.tenBtn:SetAlpha(0.3)
						frame.oneBtn:SetAlpha(0.3)
					end

					LeaPlusLC.SoundByte = 1000000
					DimAllBoxes()
					frame.millionBtn:SetAlpha(1)

					-- Step button handlers
					frame.millionBtn:SetScript("OnClick", function()
						LeaPlusLC.SoundByte = 1000000
						DimAllBoxes()
						frame.millionBtn:SetAlpha(1)
					end)

					frame.hundredThousandBtn:SetScript("OnClick", function()
						LeaPlusLC.SoundByte = 100000
						DimAllBoxes()
						frame.hundredThousandBtn:SetAlpha(1)
					end)

					frame.tenThousandBtn:SetScript("OnClick", function()
						LeaPlusLC.SoundByte = 10000
						DimAllBoxes()
						frame.tenThousandBtn:SetAlpha(1)
					end)

					frame.thousandBtn:SetScript("OnClick", function()
						LeaPlusLC.SoundByte = 1000
						DimAllBoxes()
						frame.thousandBtn:SetAlpha(1)
					end)

					frame.hundredBtn:SetScript("OnClick", function()
						LeaPlusLC.SoundByte = 100
						DimAllBoxes()
						frame.hundredBtn:SetAlpha(1)
					end)

					frame.tenBtn:SetScript("OnClick", function()
						LeaPlusLC.SoundByte = 10
						DimAllBoxes()
						frame.tenBtn:SetAlpha(1)
					end)

					frame.oneBtn:SetScript("OnClick", function()
						LeaPlusLC.SoundByte = 1
						DimAllBoxes()
						frame.oneBtn:SetAlpha(1)
					end)

					-- Final code
					LeaPlusLC.MuteFrame = frame
					_G["LeaPlusGlobalMutePanel"] = frame
					table.insert(UISpecialFrames, "LeaPlusGlobalMutePanel")
				end
				if LeaPlusLC.MuteFrame:IsShown() then LeaPlusLC.MuteFrame:Hide() else LeaPlusLC.MuteFrame:Show() end
				return
			elseif str == "mem" or str == "m" then
				-- Show addon panel with memory usage
				if LeaPlusLC.ShowMemoryUsage then
					LeaPlusLC:ShowMemoryUsage(LeaPlusLC["Page8"], "TOPLEFT", 146, -262)
				end
				-- Prevent options panel from showing if a game options panel is showing
				if ChatConfigFrame:IsShown() then return end
				-- Prevent options panel from showing if Blizzard Store is showing
				if StoreFrame and StoreFrame:GetAttribute("isshown") then return end
				-- Toggle the options panel if game options panel is not showing
				if LeaPlusLC:IsPlusShowing() then
					LeaPlusLC:HideFrames()
					LeaPlusLC:HideConfigPanels()
				else
					LeaPlusLC:HideFrames()
					LeaPlusLC["PageF"]:Show()
				end
				LeaPlusLC["Page"..LeaPlusLC["LeaStartPage"]]:Show()
				return
			elseif str == "gossinfo" then
				-- Print gossip frame information
				if GossipFrame:IsShown() then
					local npcName = UnitName("npc")
					local npcGuid = UnitGUID("npc") or nil
					if npcName and npcGuid then
						local void, void, void, void, void, npcID = strsplit("-", npcGuid)
						if npcID then
							LeaPlusLC:Print(npcName .. ": |cffffffff" .. npcID)
						end
					end
					LeaPlusLC:Print("Available quests: |cffffffff" .. C_GossipInfo.GetNumAvailableQuests())
					LeaPlusLC:Print("Active quests: |cffffffff" .. C_GossipInfo.GetNumActiveQuests())
					local gossipInfoTable = C_GossipInfo.GetOptions()
					if gossipInfoTable and gossipInfoTable[1] and gossipInfoTable[1].name then
						LeaPlusLC:Print("Gossip count: |cffffffff" .. #gossipInfoTable)
						LeaPlusLC:Print("Gossip name: |cffffffff" .. gossipInfoTable[1].name)
					else
						LeaPlusLC:Print("Gossip info: |cffffffff" .. "Nil")
					end
					if GossipTitleButton1 and GossipTitleButton1:GetText() then
						LeaPlusLC:Print("First option: |cffffffff" .. GossipTitleButton1:GetText())
					end
					-- LeaPlusLC:Print("Gossip text: |cffffffff" .. GetGossipText())
					if not IsShiftKeyDown() then
						SelectGossipOption(1)
					end
				else
					LeaPlusLC:Print("Gossip frame not open.")
				end
				return
			elseif str == "svars" then
				-- Print saved variables
				LeaPlusLC:Print(L["Saved Variables"] .. "|n")
				LeaPlusLC:Print(L["The following list shows option label, setting name and currently saved value.  Enable |cffffffffIncrease chat history|r (chat) and |cffffffffRecent chat window|r (chat) to make it easier."] .. "|n")
				LeaPlusLC:Print(L["Modifying saved variables must start with |cffffffff/ltp nosave|r to prevent your changes from being reverted during reload or logout."] .. "|n")
				LeaPlusLC:Print(L['Syntax is |cffffffff/run LeaPlusDB[' .. '"' .. 'setting name' .. '"' .. '] = ' .. '"' .. 'value' .. '" |r(case sensitive).'])
				LeaPlusLC:Print(L["When done, |cffffffff/reload|r to save your changes."] .. "|n")
				-- Checkboxes
				LeaPlusLC:Print(L["Checkboxes"] .. "|n")
				LeaPlusLC:Print(L["Checkboxes can be set to On or Off."] .. "|n")
				for key, value in pairs(LeaPlusDB) do
					if LeaPlusCB[key] and LeaPlusCB[key].f then
						if LeaPlusCB[key]:GetObjectType() ~= "Slider" and LeaPlusCB[key]:GetObjectType() ~= "Button" then
							LeaPlusLC:Print(string.gsub(LeaPlusCB[key].f:GetText(), "%*$", "") .. ": |cffffffff" .. key .. "|r |cff1eff0c(" .. value .. ")|r")
						end
					end
				end
				-- Sliders
				LeaPlusLC:Print("|n" .. L["Sliders"] .. "|n")
				LeaPlusLC:Print(L["Sliders can be set to a numeric value which must be in the range supported by the slider."] .. "|n")
				for key, value in pairs(LeaPlusDB) do
					if LeaPlusCB[key] and LeaPlusCB[key].f then
						if LeaPlusCB[key]:GetObjectType() == "Slider" then
							LeaPlusLC:Print("Slider: " .. "|cffffffff" .. key .. "|r |cff1eff0c(" .. value .. ")|r" .. " (" .. string.gsub(LeaPlusCB[key].f:GetText(), "%*$", "") .. ")" )
						end
					end
				end
				-- Dropdowns
				LeaPlusLC:Print("|n" .. L["Dropdowns"] .. "|n")
				LeaPlusLC:Print(L["Dropdowns can be set to a numeric value which must be in the range supported by the dropdown."] .. "|n")
				for key, value in pairs(LeaPlusDB) do
					if LeaPlusCB[key] and LeaPlusCB[key]:GetObjectType() == "Button" and LeaPlusLC[key] then
						LeaPlusLC:Print("Dropdown: " .. "|cffffffff" .. key .. "|r |cff1eff0c(" .. value .. ")|r")
					end
				end
				return
			elseif str == "taintmap" then
				-- TaintMap
				if LeaPlusLC.TaintMap then
					LeaPlusLC.TaintMap:Cancel()
					LeaPlusLC.TaintMap = nil
					LeaPlusLC:Print("TaintMap stopped.")
					return
				end
				LeaPlusLC.TaintMap = C_Timer.NewTicker(1, function()
					for k,v in pairs(WorldMapFrame) do
						local ok, who = issecurevariable(WorldMapFrame, k)
						if not ok then
							print("Tainted:", k, "by", who or "unknown")
						end
					end
				end)
				LeaPlusLC:Print("TaintMap started.")
				return
			elseif str == "admin" then
				-- Preset profile (used for testing)
				LpEvt:UnregisterAllEvents()						-- Prevent changes
				wipe(LeaPlusDB)									-- Wipe settings
				LeaPlusLC:PlayerLogout(true)					-- Reset permanent settings
				-- Automation
				LeaPlusDB["AutomateQuests"] = "On"				-- Automate quests
				LeaPlusDB["AutoQuestShift"] = "Off"				-- Automate quests requires shift
				LeaPlusDB["AutoQuestAvailable"] = "On"			-- Accept available quests
				LeaPlusDB["AutoQuestCompleted"] = "On"			-- Turn-in completed quests
				LeaPlusDB["AutoQuestKeyMenu"] = 1				-- Automate quests override key
				LeaPlusDB["AutomateGossip"] = "On"				-- Automate gossip
				LeaPlusDB["AutoAcceptSummon"] = "On"			-- Accept summon
				LeaPlusDB["AutoAcceptRes"] = "On"				-- Accept resurrection
				LeaPlusDB["AutoReleasePvP"] = "On"				-- Release in PvP
				LeaPlusDB["AutoSellJunk"] = "On"				-- Sell junk automatically
				LeaPlusDB["AutoSellExcludeList"] = ""			-- Sell junk exclusions list
				LeaPlusDB["AutoRepairGear"] = "On"				-- Repair automatically

				-- Social
				LeaPlusDB["NoDuelRequests"] = "On"				-- Block duels
				LeaPlusDB["NoPetDuels"] = "On"					-- Block pet battle duels
				LeaPlusDB["NoPartyInvites"] = "Off"				-- Block party invites
				LeaPlusDB["NoRequestedInvites"] = "Off"			-- Block requested invites
				LeaPlusDB["NoFriendRequests"] = "Off"			-- Block friend requests
				LeaPlusDB["NoSharedQuests"] = "Off"				-- Block shared quests

				LeaPlusDB["AcceptPartyFriends"] = "On"			-- Party from friends
				LeaPlusDB["AutoConfirmRole"] = "On"				-- Queue from friends
				LeaPlusDB["InviteFromWhisper"] = "On"			-- Invite from whispers
				LeaPlusDB["InviteFriendsOnly"] = "On"			-- Restrict invites to friends
				LeaPlusDB["FriendlyGuild"] = "On"				-- Friendly guild

				-- Chat
				LeaPlusDB["UseEasyChatResizing"] = "On"			-- Use easy resizing
				LeaPlusDB["NoCombatLogTab"] = "On"				-- Hide the combat log
				LeaPlusDB["NoChatButtons"] = "On"				-- Hide chat buttons
				LeaPlusDB["UnclampChat"] = "On"					-- Unclamp chat frame
				LeaPlusDB["MoveChatEditBoxToTop"] = "On"		-- Move editbox to top
				LeaPlusDB["MoreFontSizes"] = "On"				-- More font sizes

				LeaPlusDB["NoStickyChat"] = "On"				-- Disable sticky chat
				LeaPlusDB["UseArrowKeysInChat"] = "On"			-- Use arrow keys in chat
				LeaPlusDB["NoChatFade"] = "On"					-- Disable chat fade
				LeaPlusDB["UnivGroupColor"] = "On"				-- Universal group color
				LeaPlusDB["ClassColorsInChat"] = "On"			-- Use class colors in chat
				LeaPlusDB["RecentChatWindow"] = "On"			-- Recent chat window
				LeaPlusDB["RecentChatSize"] = 170				-- Recent chat size
				LeaPlusDB["MaxChatHstory"] = "Off"				-- Increase chat history
				LeaPlusDB["FilterChatMessages"] = "On"			-- Filter chat messages
				LeaPlusDB["BlockSpellLinks"] = "On"				-- Block spell links
				LeaPlusDB["BlockDrunkenSpam"] = "On"			-- Block drunken spam
				LeaPlusDB["BlockDuelSpam"] = "On"				-- Block duel spam
				LeaPlusDB["BlockGuildAnnounce"] = "On"			-- Block guild announcements
				LeaPlusDB["RestoreChatMessages"] = "On"			-- Restore chat messages

				-- Text
				LeaPlusDB["HideErrorMessages"] = "On"			-- Hide error messages
				LeaPlusDB["NoHitIndicators"] = "On"				-- Hide portrait text
				LeaPlusDB["HideKeybindText"] = "On"				-- Hide keybind text
				LeaPlusDB["HideMacroText"] = "On"				-- Hide macro text
				LeaPlusDB["HideRaidGroupLabels"] = "On"			-- Hide raid group labels

				LeaPlusDB["MailFontChange"] = "On"				-- Resize mail text
				LeaPlusDB["LeaPlusMailFontSize"] = 22			-- Mail font size
				LeaPlusDB["QuestFontChange"] = "On"				-- Resize quest text
				LeaPlusDB["LeaPlusQuestFontSize"] = 18			-- Quest font size
				LeaPlusDB["BookFontChange"] = "On"				-- Resize book text
				LeaPlusDB["LeaPlusBookFontSize"] = 22			-- Book font size

				-- Interface
				LeaPlusDB["MinimapModder"] = "On"				-- Enhance minimap
				LeaPlusDB["SquareMinimap"] = "On"				-- Square minimap
				LeaPlusDB["ShowWhoPinged"] = "On"				-- Show who pinged
				LeaPlusDB["CombineAddonButtons"] = "Off"		-- Combine addon buttons
				LeaPlusDB["MiniExcludeList"] = "BugSack, Leatrix_Plus" -- Excluded addon list
				LeaPlusDB["MinimapScale"] = 1.40				-- Minimap scale slider
				LeaPlusDB["MinimapSize"] = 180					-- Minimap size slider
				LeaPlusDB["MinimapBorderWidth"] = 3				-- Minimap border width
				LeaPlusDB["MiniClusterScale"] = 1				-- Minimap cluster scale
				LeaPlusDB["MinimapNoScale"] = "Off"				-- Minimap not minimap
				LeaPlusDB["HideMiniZoneText"] = "On"			-- Hide zone text bar
				LeaPlusDB["HideMiniMapButton"] = "On"			-- Hide world map button
				LeaPlusDB["HideMiniTracking"] = "On"			-- Hide tracking button
				LeaPlusDB["MinimapA"] = "TOPRIGHT"				-- Minimap anchor
				LeaPlusDB["MinimapR"] = "TOPRIGHT"				-- Minimap relative
				LeaPlusDB["MinimapX"] = 0						-- Minimap X
				LeaPlusDB["MinimapY"] = 0						-- Minimap Y

				LeaPlusDB["TipModEnable"] = "On"				-- Enhance tooltip
				LeaPlusDB["LeaPlusTipSize"] = 1.25				-- Tooltip scale slider
				LeaPlusDB["TooltipAnchorMenu"] = 2				-- Tooltip anchor
				LeaPlusDB["TipCursorX"] = 0						-- X offset
				LeaPlusDB["TipCursorY"] = 0						-- Y offset
				LeaPlusDB["EnhanceDressup"] = "On"				-- Enhance dressup
				LeaPlusDB["DressupWiderPreview"] = "On"			-- Enhance dressup wider character preview
				LeaPlusDB["DressupTransmogAnim"] = "Off"		-- Enhance dressup transmogrify animation control
				LeaPlusDB["DressupFasterZoom"] = 3				-- Dressup zoom speed
				LeaPlusDB["HideDressupStats"] = "On"			-- Hide dressup stats
				LeaPlusDB["EnhanceQuestLog"] = "On"				-- Enhance quest log
				LeaPlusDB["EnhanceQuestHeaders"] = "On"			-- Enhance quest log toggle headers
				LeaPlusDB["EnhanceQuestLevels"] = "On"			-- Enhance quest log quest levels
				LeaPlusDB["EnhanceQuestDifficulty"] = "On"		-- Enhance quest log quest difficulty

				LeaPlusDB["EnhanceProfessions"] = "On"			-- Enhance professions
				LeaPlusDB["EnhanceTrainers"] = "On"				-- Enhance trainers
				LeaPlusDB["ShowTrainAllBtn"] = "On"				-- Show train all button
				LeaPlusDB["EnhanceFlightMap"] = "On"			-- Enhance flight map
				LeaPlusDB["LeaPlusTaxiMapScale"] = 1.9			-- Enhance flight map scale
				LeaPlusDB["LeaPlusTaxiIconSize"] = 16			-- Enhance flight icon size
				LeaPlusDB["FlightMapA"] = "TOPLEFT"				-- Enhance flight map anchor
				LeaPlusDB["FlightMapR"] = "TOPLEFT"				-- Enhance flight map relative
				LeaPlusDB["FlightMapX"] = 0						-- Enhance flight map X
				LeaPlusDB["FlightMapX"] = 61					-- Enhance flight map Y

				LeaPlusDB["ShowVolume"] = "On"					-- Show volume slider
				LeaPlusDB["ShowCooldowns"] = "On"				-- Show cooldowns
				LeaPlusDB["DurabilityStatus"] = "On"			-- Show durability status
				LeaPlusDB["ShowPetSaveBtn"] = "On"				-- Show pet save button
				LeaPlusDB["ShowVanityControls"] = "On"			-- Show vanity controls
				LeaPlusDB["ShowRaidToggle"] = "On"				-- Show raid button
				LeaPlusDB["ShowBorders"] = "On"					-- Show borders
				LeaPlusDB["ShowPlayerChain"] = "On"				-- Show player chain
				LeaPlusDB["PlayerChainMenu"] = 3				-- Player chain style
				LeaPlusDB["ShowReadyTimer"] = "On"				-- Show ready timer
				LeaPlusDB["ShowWowheadLinks"] = "On"			-- Show Wowhead links
				LeaPlusDB["WowheadLinkComments"] = "On"			-- Show Wowhead links to comments

				-- Interface: Manage frames
				LeaPlusDB["FrmEnabled"] = "On"

				LeaPlusDB["Frames"] = {}
				LeaPlusDB["Frames"]["PlayerFrame"] = {}
				LeaPlusDB["Frames"]["PlayerFrame"]["Point"] = "TOPLEFT"
				LeaPlusDB["Frames"]["PlayerFrame"]["Relative"] = "TOPLEFT"
				LeaPlusDB["Frames"]["PlayerFrame"]["XOffset"] = -35
				LeaPlusDB["Frames"]["PlayerFrame"]["YOffset"] = -14
				LeaPlusDB["Frames"]["PlayerFrame"]["Scale"] = 1.20

				LeaPlusDB["Frames"]["TargetFrame"] = {}
				LeaPlusDB["Frames"]["TargetFrame"]["Point"] = "TOPLEFT"
				LeaPlusDB["Frames"]["TargetFrame"]["Relative"] = "TOPLEFT"
				LeaPlusDB["Frames"]["TargetFrame"]["XOffset"] = 190
				LeaPlusDB["Frames"]["TargetFrame"]["YOffset"] = -14
				LeaPlusDB["Frames"]["TargetFrame"]["Scale"] = 1.20

				LeaPlusDB["ManageBuffs"] = "On"					-- Manage buffs
				LeaPlusDB["BuffFrameA"] = "TOPRIGHT"			-- Manage buffs anchor
				LeaPlusDB["BuffFrameR"] = "TOPRIGHT"			-- Manage buffs relative
				LeaPlusDB["BuffFrameX"] = -271					-- Manage buffs position X
				LeaPlusDB["BuffFrameY"] = 0						-- Manage buffs position Y
				LeaPlusDB["BuffFrameScale"] = 0.8				-- Manage buffs scale

				LeaPlusDB["ManageWidget"] = "On"				-- Manage widget
				LeaPlusDB["WidgetA"] = "TOP"					-- Manage widget anchor
				LeaPlusDB["WidgetR"] = "TOP"					-- Manage widget relative
				LeaPlusDB["WidgetX"] = 0						-- Manage widget position X
				LeaPlusDB["WidgetY"] = -432						-- Manage widget position Y
				LeaPlusDB["WidgetScale"] = 1.25					-- Manage widget scale

				LeaPlusDB["ManageFocus"] = "On"					-- Manage focus
				LeaPlusDB["FocusA"] = "TOPLEFT"					-- Manage focus anchor
				LeaPlusDB["FocusR"] = "TOPLEFT"					-- Manage focus relative
				LeaPlusDB["FocusX"] = 250						-- Manage focus position X
				LeaPlusDB["FocusY"] = -240						-- Manage focus position Y
				LeaPlusDB["FocusScale"] = 1.00					-- Manage focus scale

				LeaPlusDB["ManageTimer"] = "On"					-- Manage timer
				LeaPlusDB["TimerA"] = "TOP"						-- Manage timer anchor
				LeaPlusDB["TimerR"] = "TOP"						-- Manage timer relative
				LeaPlusDB["TimerX"] = 0							-- Manage timer position X
				LeaPlusDB["TimerY"] = -120						-- Manage timer position Y
				LeaPlusDB["TimerScale"] = 1.00					-- Manage timer scale

				LeaPlusDB["ManageDurability"] = "On"			-- Manage durability
				LeaPlusDB["DurabilityA"] = "TOPRIGHT"			-- Manage durability anchor
				LeaPlusDB["DurabilityR"] = "TOPRIGHT"			-- Manage durability relative
				LeaPlusDB["DurabilityX"] = 0					-- Manage durability position X
				LeaPlusDB["DurabilityY"] = -192					-- Manage durability position Y
				LeaPlusDB["DurabilityScale"] = 1.00				-- Manage durability scale

				LeaPlusDB["ManageVehicle"] = "On"				-- Manage vehicle
				LeaPlusDB["VehicleA"] = "TOPRIGHT"				-- Manage vehicle anchor
				LeaPlusDB["VehicleR"] = "TOPRIGHT"				-- Manage vehicle relative
				LeaPlusDB["VehicleX"] = -100					-- Manage vehicle position X
				LeaPlusDB["VehicleY"] = -192					-- Manage vehicle position Y
				LeaPlusDB["VehicleScale"] = 1.00				-- Manage vehicle scale

				LeaPlusDB["ClassColFrames"] = "On"				-- Class colored frames

				LeaPlusDB["NoAlerts"] = "On"					-- Hide alerts
				LeaPlusDB["NoGryphons"] = "On"					-- Hide gryphons
				LeaPlusDB["HideEventToasts"] = "On"				-- Hide event toasts
				LeaPlusDB["NoClassBar"] = "On"					-- Hide stance bar

				-- System
				LeaPlusDB["NoScreenGlow"] = "On"				-- Disable screen glow
				LeaPlusDB["NoScreenEffects"] = "On"				-- Disable screen effects
				LeaPlusDB["SetWeatherDensity"] = "On"			-- Set weather density
				LeaPlusDB["WeatherLevel"] = 0					-- Weather density level
				LeaPlusDB["MaxCameraZoom"] = "On"				-- Max camera zoom
				LeaPlusDB["NoRestedEmotes"] = "On"				-- Silence rested emotes
				LeaPlusDB["KeepAudioSynced"] = "On"				-- Keep audio synced
				LeaPlusDB["MuteGameSounds"] = "On"				-- Mute game sounds
				LeaPlusDB["MuteMountSounds"] = "On"				-- Mute mount sounds
				LeaPlusDB["MuteCustomSounds"] = "On"			-- Mute custom sounds
				LeaPlusDB["MuteCustomList"] = ""				-- Mute custom sounds list

				LeaPlusDB["NoBagAutomation"] = "On"				-- Disable bag automation
				LeaPlusDB["NoPetAutomation"] = "On"				-- Disable pet automation
				LeaPlusDB["CharAddonList"] = "On"				-- Show character addons
				LeaPlusDB["NoConfirmLoot"] = "On"				-- Disable loot warnings
				LeaPlusDB["FasterLooting"] = "On"				-- Faster auto loot
				LeaPlusDB["FasterMovieSkip"] = "On"				-- Faster movie skip
				LeaPlusDB["StandAndDismount"] = "On"			-- Dismount me
				LeaPlusDB["ExpandVendorPrice"] = "On"			-- Expand vendor price
				LeaPlusDB["CombatPlates"] = "On"				-- Combat plates
				LeaPlusDB["EasyItemDestroy"] = "On"				-- Easy item destroy
				LeaPlusDB["NoTransforms"] = "On"				-- Remove transforms

				LeaPlusDB["UseEnglishLanguage"] = "On"			-- Use English language

				-- Function to assign cooldowns
				local function setIcon(pclass, pspec, sp1, pt1, sp2, pt2, sp3, pt3, sp4, pt4, sp5, pt5)
					-- Set spell ID
					if sp1 == 0 then LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R1Idn"] = "" else LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R1Idn"] = sp1 end
					if sp2 == 0 then LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R2Idn"] = "" else LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R2Idn"] = sp2 end
					if sp3 == 0 then LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R3Idn"] = "" else LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R3Idn"] = sp3 end
					if sp4 == 0 then LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R4Idn"] = "" else LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R4Idn"] = sp4 end
					if sp5 == 0 then LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R5Idn"] = "" else LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R5Idn"] = sp5 end
					-- Set pet checkbox
					if pt1 == 0 then LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R1Pet"] = false else LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R1Pet"] = true end
					if pt2 == 0 then LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R2Pet"] = false else LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R2Pet"] = true end
					if pt3 == 0 then LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R3Pet"] = false else LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R3Pet"] = true end
					if pt4 == 0 then LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R4Pet"] = false else LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R4Pet"] = true end
					if pt5 == 0 then LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R5Pet"] = false else LeaPlusDB["Cooldowns"][pclass]["S" .. pspec .. "R5Pet"] = true end
				end

				-- Create main table
				LeaPlusDB["Cooldowns"] = {}

				-- Create class tables
				local classList = {"WARRIOR", "PALADIN", "HUNTER", "SHAMAN", "ROGUE", "DRUID", "MAGE", "WARLOCK", "PRIEST"}
				for index = 1, #classList do
					if LeaPlusDB["Cooldowns"][classList[index]] == nil then
						LeaPlusDB["Cooldowns"][classList[index]] = {}
					end
				end

				-- Assign cooldowns
				setIcon("WARRIOR", 		1, --[[1]] 0, 0, 		--[[2]] 0, 0, 		--[[3]] 0, 0, 		--[[4]] 0, 0, 		--[[5]] 0, 0)
				setIcon("PALADIN", 		1, --[[1]] 0, 0, 		--[[2]] 0, 0, 		--[[3]] 0, 0, 		--[[4]] 0, 0, 		--[[5]] 19740, 0) -- nil, nil, nil, nil, Might
				setIcon("HUNTER", 		1, --[[1]] 136, 1, 		--[[2]] 118455, 1, 	--[[3]] 0, 0, 		--[[4]] 0, 0, 		--[[5]] 5384, 0) -- Mend Pet, nil, nil, nil, Feign Death
				setIcon("SHAMAN", 		1, --[[1]] 0, 0, 		--[[2]] 0, 0, 		--[[3]] 0, 0, 		--[[4]] 215864, 0, 	--[[5]] 546, 0) -- nil, nil, nil, Rainfall, Water Walking
				setIcon("ROGUE", 		1, --[[1]] 1784, 0, 	--[[2]] 0, 0, 		--[[3]] 0, 0, 		--[[4]] 2823, 0, 	--[[5]] 3408, 0) -- Stealth, nil, nil, Deadly Poison, Crippling Poison
				setIcon("DRUID", 		1, --[[1]] 0, 0, 		--[[2]] 0, 0, 		--[[3]] 0, 0, 		--[[4]] 0, 0, 		--[[5]] 0, 0)
				setIcon("MAGE", 		1, --[[1]] 235450, 0, 	--[[2]] 0, 0, 		--[[3]] 0, 0, 		--[[4]] 0, 0, 		--[[5]] 0, 0) -- Prismatic Barrier
				setIcon("WARLOCK", 		1, --[[1]] 0, 0, 		--[[2]] 0, 0, 		--[[3]] 0, 0, 		--[[4]] 0, 0, 		--[[5]] 0, 0)
				setIcon("PRIEST", 		1, --[[1]] 17, 0, 		--[[2]] 0, 0, 		--[[3]] 0, 0, 		--[[4]] 0, 0, 		--[[5]] 0, 0) -- Power Word: Shield

				-- Mute game sounds (LeaPlusLC["MuteGameSounds"])
				for k, v in pairs(LeaPlusLC["muteTable"]) do
					LeaPlusDB[k] = "On"
				end
				LeaPlusDB["MuteReady"] = "Off"	-- Mute ready check

				-- Mute mount sounds (LeaPlusLC["MuteMountSounds"])
				for k, v in pairs(LeaPlusLC["mountTable"]) do
					LeaPlusDB[k] = "On"
				end

				-- Remove transforms (LeaPlusLC["NoTransforms"])
				for k, v in pairs(LeaPlusLC["transTable"]) do
					LeaPlusDB[k] = "On"
				end

				-- Set chat font sizes
				RunScript('for i = 1, 50 do if _G["ChatFrame" .. i] then FCF_SetChatWindowFontSize(self, _G["ChatFrame" .. i], 20) end end')

				-- Reload
				ReloadUI()
			else
				LeaPlusLC:Print("Invalid parameter.")
			end
			return
		else
			-- Prevent options panel from showing if a game options panel is showing
			if ChatConfigFrame:IsShown() then return end
			-- Prevent options panel from showing if Blizzard Store is showing
			if StoreFrame and StoreFrame:GetAttribute("isshown") then return end
			-- Toggle the options panel if game options panel is not showing
			if LeaPlusLC:IsPlusShowing() then
				LeaPlusLC:HideFrames()
				LeaPlusLC:HideConfigPanels()
			else
				LeaPlusLC:HideFrames()
				LeaPlusLC["PageF"]:Show()
			end
			LeaPlusLC["Page"..LeaPlusLC["LeaStartPage"]]:Show()
		end
	end

	-- Slash command for global function
	_G.SLASH_Leatrix_Plus1 = "/ltp"
	_G.SLASH_Leatrix_Plus2 = "/leaplus"

	SlashCmdList["Leatrix_Plus"] = function(self)
		-- Run slash command function
		LeaPlusLC:SlashFunc(self)
		-- Redirect tainted variables
		RunScript('ACTIVE_CHAT_EDIT_BOX = ACTIVE_CHAT_EDIT_BOX')
		RunScript('LAST_ACTIVE_CHAT_EDIT_BOX = LAST_ACTIVE_CHAT_EDIT_BOX')
	end

	-- Slash command for UI reload
	_G.SLASH_LEATRIX_PLUS_RL1 = "/rl"
	SlashCmdList["LEATRIX_PLUS_RL"] = function()
		ReloadUI()
	end

	-- There is a slash command bug in the game code.  To reproduce it, enter combat, enter any addon related
	-- slash command, toggle tracking on a quest 4 times then click that quest in the objective tracker.
	-- The bug was originally found in Dragonflight.  Then Blizzard copied a lot of Dragonflight code to Wrath
	-- Classic and the bug was copied along with it.  The bug has since been fixed in Dragonflight but has not
	-- been fixed in Wrath Classic.

----------------------------------------------------------------------
-- 	L90: Create options panel pages (no content yet)
----------------------------------------------------------------------

	-- Function to add menu button
	function LeaPlusLC:MakeMN(name, text, parent, anchor, x, y, width, height)

		local mbtn = CreateFrame("Button", nil, parent)
		LeaPlusLC[name] = mbtn
		mbtn:Show();
		mbtn:SetSize(width, height)
		mbtn:SetAlpha(1.0)
		mbtn:SetPoint(anchor, x, y)

		mbtn.t = mbtn:CreateTexture(nil, "BACKGROUND")
		mbtn.t:SetAllPoints()
		mbtn.t:SetColorTexture(0.3, 0.3, 0.00, 0.8)
		mbtn.t:SetAlpha(0.7)
		mbtn.t:Hide()

		mbtn.s = mbtn:CreateTexture(nil, "BACKGROUND")
		mbtn.s:SetAllPoints()
		mbtn.s:SetColorTexture(0.3, 0.3, 0.00, 0.8)
		mbtn.s:Hide()

		mbtn.f = mbtn:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		mbtn.f:SetPoint('LEFT', 16, 0)
		mbtn.f:SetText(L[text])

		mbtn:SetScript("OnEnter", function()
			mbtn.t:Show()
		end)

		mbtn:SetScript("OnLeave", function()
			mbtn.t:Hide()
		end)

		return mbtn, mbtn.s

	end

	-- Function to create individual options panel pages
	function LeaPlusLC:MakePage(name, title, menu, menuname, menuparent, menuanchor, menux, menuy, menuwidth, menuheight)

		-- Create frame
		local oPage = CreateFrame("Frame", nil, LeaPlusLC["PageF"]);
		LeaPlusLC[name] = oPage
		oPage:SetAllPoints(LeaPlusLC["PageF"])
		oPage:Hide();

		-- Add page title
		oPage.s = oPage:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
		oPage.s:SetPoint('TOPLEFT', 146, -16)
		oPage.s:SetText(L[title])

		-- Add menu item if needed
		if menu then
			LeaPlusLC[menu], LeaPlusLC[menu .. ".s"] = LeaPlusLC:MakeMN(menu, menuname, menuparent, menuanchor, menux, menuy, menuwidth, menuheight)
			LeaPlusLC[name]:SetScript("OnShow", function() LeaPlusLC[menu .. ".s"]:Show(); end)
			LeaPlusLC[name]:SetScript("OnHide", function() LeaPlusLC[menu .. ".s"]:Hide(); end)
		end

		return oPage;

	end

	-- Create options pages
	LeaPlusLC["Page0"] = LeaPlusLC:MakePage("Page0", "Home"			, "LeaPlusNav0", "Home"			, LeaPlusLC["PageF"], "TOPLEFT", 16, -72, 112, 20)
	LeaPlusLC["Page1"] = LeaPlusLC:MakePage("Page1", "Automation"	, "LeaPlusNav1", "Automation"	, LeaPlusLC["PageF"], "TOPLEFT", 16, -112, 112, 20)
	LeaPlusLC["Page2"] = LeaPlusLC:MakePage("Page2", "Social"		, "LeaPlusNav2", "Social"		, LeaPlusLC["PageF"], "TOPLEFT", 16, -132, 112, 20)
	LeaPlusLC["Page3"] = LeaPlusLC:MakePage("Page3", "Chat"			, "LeaPlusNav3", "Chat"			, LeaPlusLC["PageF"], "TOPLEFT", 16, -152, 112, 20)
	LeaPlusLC["Page4"] = LeaPlusLC:MakePage("Page4", "Text"			, "LeaPlusNav4", "Text"			, LeaPlusLC["PageF"], "TOPLEFT", 16, -172, 112, 20)
	LeaPlusLC["Page5"] = LeaPlusLC:MakePage("Page5", "Interface"	, "LeaPlusNav5", "Interface"	, LeaPlusLC["PageF"], "TOPLEFT", 16, -192, 112, 20)
	LeaPlusLC["Page6"] = LeaPlusLC:MakePage("Page6", "Frames"		, "LeaPlusNav6", "Frames"		, LeaPlusLC["PageF"], "TOPLEFT", 16, -212, 112, 20)
	LeaPlusLC["Page7"] = LeaPlusLC:MakePage("Page7", "System"		, "LeaPlusNav7", "System"		, LeaPlusLC["PageF"], "TOPLEFT", 16, -232, 112, 20)
	LeaPlusLC["Page8"] = LeaPlusLC:MakePage("Page8", "Settings"		, "LeaPlusNav8", "Settings"		, LeaPlusLC["PageF"], "TOPLEFT", 16, -272, 112, 20)
	LeaPlusLC["Page9"] = LeaPlusLC:MakePage("Page9", "Media"		, "LeaPlusNav9", "Media"		, LeaPlusLC["PageF"], "TOPLEFT", 16, -292, 112, 20)

	-- Page navigation mechanism
	for i = 0, LeaPlusLC["NumberOfPages"] do
		LeaPlusLC["LeaPlusNav"..i]:SetScript("OnClick", function()
			LeaPlusLC:HideFrames()
			LeaPlusLC["PageF"]:Show();
			LeaPlusLC["Page"..i]:Show();
			LeaPlusLC["LeaStartPage"] = i
		end)
	end

	-- Use a variable to contain the page number (makes it easier to move options around)
	local pg;

----------------------------------------------------------------------
-- 	LC0: Welcome
----------------------------------------------------------------------

	pg = "Page0";

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Welcome to Leatrix Plus.", 146, -72);
	LeaPlusLC:MakeWD(LeaPlusLC[pg], "To begin, choose an options page.", 146, -92);

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Support", 146, -132);
	LeaPlusLC:MakeWD(LeaPlusLC[pg], "curseforge.com/wow/addons/leatrix-plus", 146, -152);

----------------------------------------------------------------------
-- 	LC1: Automation
----------------------------------------------------------------------

	pg = "Page1";

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Character"					, 	146, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "AutomateQuests"			,	"Automate quests"				,	146, -92, 	false,	"If checked, quests will be selected, accepted and turned-in automatically.|n|nQuests which have a gold requirement will not be turned-in automatically.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "AutomateGossip"			,	"Automate gossip"				,	146, -112, 	false,	"If checked, you can hold down the alt key while opening a gossip window to automatically select a single gossip item.|n|nFor many utility NPCs, gossip will be skipped without needing to hold the alt key.  You can hold the shift key down to prevent this.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "AutoAcceptSummon"			,	"Accept summon"					, 	146, -132, 	false,	"If checked, summon requests will be accepted automatically unless you are in combat.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "AutoAcceptRes"				,	"Accept resurrection"			, 	146, -152, 	false,	"If checked, resurrection requests will be accepted automatically.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "AutoReleasePvP"			,	"Release in PvP"				, 	146, -172, 	false,	"If checked, you will release automatically after you die in a battleground.|n|nYou will not release automatically if you have the ability to self-resurrect.")

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Vendors"					, 	340, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "AutoSellJunk"				,	"Sell junk automatically"		,	340, -92, 	false,	"If checked, all grey items in your bags will be sold automatically when you visit a merchant.|n|nYou can hold the shift key down when you talk to a merchant to override this setting.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "AutoRepairGear"			, 	"Repair automatically"			,	340, -112, 	false,	"If checked, your gear will be repaired automatically when you visit a suitable merchant.|n|nYou can hold the shift key down when you talk to a merchant to override this setting.")

	LeaPlusLC:CfgBtn("AutomateQuestsBtn", LeaPlusCB["AutomateQuests"])
	LeaPlusLC:CfgBtn("AutoAcceptResBtn", LeaPlusCB["AutoAcceptRes"])
	LeaPlusLC:CfgBtn("AutoReleasePvPBtn", LeaPlusCB["AutoReleasePvP"])
	LeaPlusLC:CfgBtn("AutoSellJunkBtn", LeaPlusCB["AutoSellJunk"])
	LeaPlusLC:CfgBtn("AutoRepairBtn", LeaPlusCB["AutoRepairGear"])

----------------------------------------------------------------------
-- 	LC2: Social
----------------------------------------------------------------------

	pg = "Page2";

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Blocks"					, 	146, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoDuelRequests"			, 	"Block duels"					,	146, -92, 	false,	"If checked, duel requests will be blocked unless the player requesting the duel is a friend.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoPetDuels"				, 	"Block pet battle duels"		,	146, -112, 	false,	"If checked, pet battle duel requests will be blocked unless the player requesting the duel is a friend.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoPartyInvites"			, 	"Block party invites"			, 	146, -132, 	false,	"If checked, party invitations will be blocked unless the player inviting you is a friend.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoRequestedInvites"		, 	"Block requested invites"		, 	146, -152, 	false,	"If checked, requests to invite a player to your group will be declined unless the player requesting to join is a friend.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoFriendRequests"			, 	"Block friend requests"			, 	146, -172, 	false,	"If checked, BattleTag and Real ID friend requests will be automatically declined.|n|nEnabling this option will automatically decline any pending requests.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoSharedQuests"			, 	"Block shared quests"			, 	146, -192, 	false,	"If checked, shared quests will be declined unless the player sharing the quest is a friend.")

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Groups"					, 	340, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "AcceptPartyFriends"		, 	"Party from friends"			, 	340, -92, 	false,	"If checked, party invitations from friends will be automatically accepted unless you are queued for a battleground.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "AutoConfirmRole"			, 	"Queue from friends"			,	340, -112, 	false,	"If checked, requests initiated by your party leader to join the Dungeon Finder queue will be automatically accepted if the party leader is a friend.|n|nThis option requires that you have selected a role for your character in the Dungeon Finder window.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "InviteFromWhisper"			,   "Invite from whispers"			,	340, -132,	false,	L["If checked, a group invite will be sent to anyone who whispers you with a set keyword as long as you are ungrouped, group leader or raid assistant and not queued for a battleground.|n|nFriends who message the keyword using Battle.net will not be sent a group invite if they are appearing offline.  They need to either change their online status or use character whispers."] .. "|n|n" .. L["Keyword"] .. ": |cffffffff" .. "dummy" .. "|r")

	-- Show footer
	local FriendlyGuildFooter = LeaPlusLC:MakeFT(LeaPlusLC[pg], "For all of the social options above, you can treat guild members and members of your communities as friends too.", 146, 380, 96)
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "FriendlyGuild"				, 	"Guild"							, 	146, -282, 	false,	"If checked, members of your guild will be treated as friends for all of the options on this page.")

	if LeaPlusCB["FriendlyGuild"].f:GetStringWidth() > 90 then
		LeaPlusCB["FriendlyGuild"].f:SetWidth(90)
		LeaPlusCB["FriendlyGuild"]:SetHitRectInsets(0, -84, 0, 0)
	end

	LeaPlusCB["FriendlyGuild"]:ClearAllPoints()
	LeaPlusCB["FriendlyGuild"]:SetPoint("TOPLEFT", FriendlyGuildFooter, "BOTTOMLEFT", 0, -10)

	LeaPlusLC:CfgBtn("InvWhisperBtn", LeaPlusCB["InviteFromWhisper"])

----------------------------------------------------------------------
-- 	LC3: Chat
----------------------------------------------------------------------

	pg = "Page3";

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Chat Frame"				, 	146, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "UseEasyChatResizing"		,	"Use easy resizing"				,	146, -92,	true,	"If checked, dragging the General chat tab while the chat frame is locked will expand the chat frame upwards.|n|nIf the chat frame is unlocked, dragging the General chat tab will move the chat frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoCombatLogTab" 			, 	"Hide the combat log"			, 	146, -112, 	true,	"If checked, the combat log will be hidden.|n|nThe combat log must be docked in order for this option to work.|n|nIf the combat log is undocked, you can dock it by dragging the tab (and reloading your UI) or by resetting the chat windows (from the chat menu).")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoChatButtons"				,	"Hide chat buttons"				,	146, -132,	true,	"If checked, chat frame buttons will be hidden.|n|nClicking chat tabs will automatically show the latest messages.|n|nUse the mouse wheel to scroll through the chat history.  Hold down SHIFT for page jump or CTRL to jump to the top or bottom of the chat history.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "UnclampChat"				,	"Unclamp chat frame"			,	146, -152,	true,	"If checked, you will be able to drag the chat frame to the edge of the screen.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "MoveChatEditBoxToTop" 		, 	"Move editbox to top"			,	146, -172, 	true,	"If checked, the editbox will be moved to the top of the chat frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "MoreFontSizes"		 		, 	"More font sizes"				,	146, -192, 	true,	"If checked, additional font sizes will be available in the chat frame font size menu.")

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Mechanics"					, 	340, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoStickyChat"				, 	"Disable sticky chat"			,	340, -92,	true,	"If checked, sticky chat will be disabled.|n|nNote that this does not apply to temporary chat windows.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "UseArrowKeysInChat"		, 	"Use arrow keys in chat"		, 	340, -112, 	true,	"If checked, you can press the arrow keys to move the insertion point left and right in the chat frame.|n|nIf unchecked, the arrow keys will use the default keybind setting.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoChatFade"				, 	"Disable chat fade"				, 	340, -132, 	true,	"If checked, chat text will not fade out after a time period.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "UnivGroupColor"			,	"Universal group color"			,	340, -152,	false,	"If checked, raid chat will be colored blue (to match the default party chat color).")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ClassColorsInChat"			,	"Use class colors in chat"		,	340, -172,	true,	"If checked, class colors will be used in the chat frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "RecentChatWindow"			,	"Recent chat window"			, 	340, -192, 	true,	"If checked, you can hold down the control key and click a chat tab to view recent chat in a copy-friendly window.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "MaxChatHstory"				,	"Increase chat history"			, 	340, -212, 	true,	"If checked, your chat history will increase to 4096 lines.  If unchecked, the default will be used (128 lines).|n|nEnabling this option may prevent some chat text from showing during login.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "FilterChatMessages"		, 	"Filter chat messages"			,	340, -232, 	true,	"If checked, you can block spell links, drunken spam and duel spam.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "RestoreChatMessages"		, 	"Restore chat messages"			,	340, -252, 	true,	"If checked, recent chat will be restored when you reload your interface.")

	LeaPlusLC:CfgBtn("FilterChatMessagesBtn", LeaPlusCB["FilterChatMessages"])

----------------------------------------------------------------------
-- 	LC4: Text
----------------------------------------------------------------------

	pg = "Page4";

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Visibility"				, 	146, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "HideErrorMessages"			, 	"Hide error messages"			,	146, -92, 	true,	"If checked, most error messages (such as 'Not enough rage') will not be shown.  Some important errors are excluded.|n|nIf you have the minimap button enabled, you can hold down the alt key and click it to toggle error messages without affecting this setting.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoHitIndicators"			, 	"Hide portrait numbers"			,	146, -112, 	true,	"If checked, damage and healing numbers in the player and pet portrait frames will be hidden.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "HideZoneText"				,	"Hide zone text"				,	146, -132, 	true,	"If checked, zone text will not be shown (eg. 'Ironforge').")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "HideKeybindText"			,	"Hide keybind text"				,	146, -152, 	true,	"If checked, keybind text will not be shown on action buttons.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "HideMacroText"				,	"Hide macro text"				,	146, -172, 	true,	"If checked, macro text will not be shown on action buttons.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "HideRaidGroupLabels"		,	"Hide raid group labels"		,	146, -192, 	true,	"If checked, the player frame group indicator and the group labels displayed above the compact raid frames and the pullout raid frames will be hidden.")

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Text Size"					, 	340, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "MailFontChange"			,	"Resize mail text"				, 	340, -92, 	true,	"If checked, you will be able to change the font size of standard mail text.|n|nThis does not affect mail created using templates (such as auction house invoices).")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "QuestFontChange"			,	"Resize quest text"				, 	340, -112, 	true,	"If checked, you will be able to change the font size of quest text.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "BookFontChange"			,	"Resize book text"				, 	340, -132, 	true,	"If checked, you will be able to change the font size of book text.")

	LeaPlusLC:CfgBtn("MailTextBtn", LeaPlusCB["MailFontChange"])
	LeaPlusLC:CfgBtn("QuestTextBtn", LeaPlusCB["QuestFontChange"])
	LeaPlusLC:CfgBtn("BookTextBtn", LeaPlusCB["BookFontChange"])

----------------------------------------------------------------------
-- 	LC5: Interface
----------------------------------------------------------------------

	pg = "Page5";

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Enhancements"				, 	146, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "MinimapModder"				,	"Enhance minimap"				, 	146, -92, 	true,	"If checked, you will be able to customise the minimap.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "TipModEnable"				,	"Enhance tooltip"				,	146, -112, 	true,	"If checked, the tooltip will be color coded and you will be able to modify the tooltip layout and scale.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "EnhanceDressup"			, 	"Enhance dressup"				,	146, -132, 	true,	"If checked, you will be able to pan (right-button) and zoom (mousewheel) in the character frame, dressup frame and inspect frame.|n|nA toggle stats button will be shown in the character frame.  You can also middle-click the character model to toggle stats.|n|nModel rotation controls will be hidden.  Buttons to toggle gear will be added to the dressup frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "EnhanceQuestLog"			, 	"Enhance quest log"				,	146, -152, 	true,	"If checked, you will be able to customise the quest log frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "EnhanceProfessions"		, 	"Enhance professions"			,	146, -172, 	true,	"If checked, the professions frame will be larger.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "EnhanceTrainers"			, 	"Enhance trainers"				,	146, -192, 	true,	"If checked, the skill trainer frame will be larger and feature a train all skills button.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "EnhanceFlightMap"			, 	"Enhance flight map"			,	146, -212, 	true,	"If checked, you will be able to customise the flight map.")

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Extras"					, 	340, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ShowVolume"				, 	"Show volume slider"			, 	340, -92, 	true,	"If checked, a master volume slider will be shown in the character frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ShowCooldowns"				, 	"Show cooldowns"				, 	340, -112, 	true,	"If checked, you will be able to place up to five beneficial cooldown icons above the target frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "DurabilityStatus"			, 	"Show durability status"		, 	340, -132, 	true,	"If checked, a button will be added to the character frame which will show your equipped item durability when you hover the pointer over it.|n|nIn addition, an overall percentage will be shown in the chat frame when you die.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ShowPetSaveBtn"			, 	"Show pet save button"			, 	340, -152, 	true,	"If checked, you will be able to save your current battle pet team (including abilities) to a single command.|n|nA button will be added to the Pet Journal.  Clicking the button will toggle showing the assignment command for your current team.  Pressing CTRL/C will copy the command to memory.|n|nYou can then paste the command (with CTRL/V) into the chat window or a macro to instantly assign your team.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ShowVanityControls"		, 	"Show vanity controls"			, 	340, -172, 	true,	"If checked, helm and cloak toggle checkboxes will be shown in the character frame.|n|nYou can hold shift and right-click the checkboxes to switch layouts.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ShowRaidToggle"			, 	"Show raid button"				,	340, -192, 	true,	"If checked, the button to toggle the raid container frame will be shown just above the raid management frame (left side of the screen) instead of in the raid management frame itself.|n|nThis allows you to toggle the raid container frame without needing to open the raid management frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ShowBorders"				,	"Show borders"					,	340, -212, 	true,	"If checked, you will be able to show customisable borders around the edges of the screen.|n|nThe borders are placed on top of the game world but under the UI so you can place UI elements over them.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ShowPlayerChain"			, 	"Show player chain"				,	340, -232, 	true,	"If checked, you will be able to show a rare, elite or rare elite chain around the player frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ShowReadyTimer"			, 	"Show ready timer"				,	340, -252, 	true,	"If checked, a timer will be shown under the dungeon ready frame and the PvP encounter ready frame so that you know how long you have left to click the enter button.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ShowWowheadLinks"			, 	"Show Wowhead links"			, 	340, -272, 	true,	"If checked, Wowhead links will be shown in the quest log frame and the achievements frame.")

	LeaPlusLC:CfgBtn("ModMinimapBtn", LeaPlusCB["MinimapModder"])
	LeaPlusLC:CfgBtn("MoveTooltipButton", LeaPlusCB["TipModEnable"])
	LeaPlusLC:CfgBtn("EnhanceDressupBtn", LeaPlusCB["EnhanceDressup"])
	LeaPlusLC:CfgBtn("EnhanceQuestLogBtn", LeaPlusCB["EnhanceQuestLog"])
	LeaPlusLC:CfgBtn("EnhanceTrainersBtn", LeaPlusCB["EnhanceTrainers"])
	LeaPlusLC:CfgBtn("EnhanceFlightMapBtn", LeaPlusCB["EnhanceFlightMap"])
	LeaPlusLC:CfgBtn("CooldownsButton", LeaPlusCB["ShowCooldowns"])
	LeaPlusLC:CfgBtn("ModBordersBtn", LeaPlusCB["ShowBorders"])
	LeaPlusLC:CfgBtn("ModPlayerChain", LeaPlusCB["ShowPlayerChain"])
	LeaPlusLC:CfgBtn("ShowWowheadLinksBtn", LeaPlusCB["ShowWowheadLinks"])

----------------------------------------------------------------------
-- 	LC6: Frames
----------------------------------------------------------------------

	pg = "Page6";

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Features"					, 	146, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "FrmEnabled"				,	"Manage frames"					, 	146, -92, 	true,	"If checked, you will be able to change the position and scale of the player frame and target frame.|n|nNote that enabling this option will prevent you from using the default UI to move the player and target frames.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ManageBuffs"				,	"Manage buffs"					, 	146, -112, 	true,	"If checked, you will be able to change the position and scale of the buffs frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ManageWidget"				,	"Manage widget"					, 	146, -132, 	true,	"If checked, you will be able to change the position and scale of the widget frame.|n|nThe widget frame is commonly used for showing PvP scores and tracking objectives.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ManageFocus"				,	"Manage focus"					, 	146, -152, 	true,	"If checked, you will be able to change the position and scale of the focus frame.|n|nNote that enabling this option will prevent you from using the default UI to move the focus frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ManageTimer"				,	"Manage timer"					, 	146, -172, 	true,	"If checked, you will be able to change the position and scale of the timer bar.|n|nThe timer bar is used for showing remaining breath when underwater as well as other things.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ManageDurability"			,	"Manage durability"				, 	146, -192, 	true,	"If checked, you will be able to change the position and scale of the armored man durability frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ManageVehicle"				,	"Manage vehicle"				, 	146, -212, 	true,	"If checked, you will be able to change the position and scale of the vehicle seat indicator frame.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ClassColFrames"			, 	"Class colored frames"			,	146, -232, 	true,	"If checked, class coloring will be used in the player frame, target frame and focus frame.")

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Visibility"				, 	340, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoAlerts"					,	"Hide alerts"					, 	340, -92, 	true,	"If checked, alert frames will not be shown.|n|nWhen you earn an achievement, a message will be shown in chat instead.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoGryphons"				,	"Hide gryphons"					, 	340, -112, 	true,	"If checked, the main bar gryphons will not be shown.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "HideEventToasts"			, 	"Hide event toasts"				, 	340, -132, 	true,	"If checked, event toasts will not be shown.|n|nEvent toasts are used for encounter objectives, level-ups, pet battle rewards, etc.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoClassBar"				,	"Hide stance bar"				, 	340, -152, 	true,	"If checked, the stance bar will not be shown.")

	LeaPlusLC:CfgBtn("MoveFramesButton", LeaPlusCB["FrmEnabled"])
	LeaPlusLC:CfgBtn("ManageBuffsButton", LeaPlusCB["ManageBuffs"])
	LeaPlusLC:CfgBtn("ManageWidgetButton", LeaPlusCB["ManageWidget"])
	LeaPlusLC:CfgBtn("ManageFocusButton", LeaPlusCB["ManageFocus"])
	LeaPlusLC:CfgBtn("ManageTimerButton", LeaPlusCB["ManageTimer"])
	LeaPlusLC:CfgBtn("ManageDurabilityButton", LeaPlusCB["ManageDurability"])
	LeaPlusLC:CfgBtn("ManageVehicleButton", LeaPlusCB["ManageVehicle"])
	LeaPlusLC:CfgBtn("ClassColFramesBtn", LeaPlusCB["ClassColFrames"])

----------------------------------------------------------------------
-- 	LC7: System
----------------------------------------------------------------------

	pg = "Page7";

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Graphics and Sound"		, 	146, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoScreenGlow"				, 	"Disable screen glow"			, 	146, -92, 	false,	"If checked, the screen glow will be disabled.|n|nEnabling this option will also disable the drunken haze effect.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoScreenEffects"			, 	"Disable screen effects"		, 	146, -112, 	false,	"If checked, the grey screen of death and the netherworld effect will be disabled.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "SetWeatherDensity"			, 	"Set weather density"			, 	146, -132, 	false,	"If checked, you will be able to set the density of weather effects.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "MaxCameraZoom"				, 	"Max camera zoom"				, 	146, -152, 	false,	"If checked, you will be able to zoom out to a greater distance.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoRestedEmotes"			, 	"Silence rested emotes"			,	146, -172, 	true,	"If checked, emote sounds will be silenced while your character is resting or at the Grim Guzzler.|n|nEmote sounds will be enabled at all other times.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "KeepAudioSynced"			, 	"Keep audio synced"				,	146, -192, 	true,	"If checked, when you change the audio output device in your operating system, the game audio output device will change automatically as long as a cinematic is not playing at the time.|n|nFor this to work, the game audio output device will be set to system default.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "MuteGameSounds"			, 	"Mute game sounds"				,	146, -212, 	false,	"If checked, you will be able to mute a selection of game sounds.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "MuteMountSounds"			, 	"Mute mount sounds"				,	146, -232, 	false,	"If checked, you will be able to mute a selection of mount sounds.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "MuteCustomSounds"			, 	"Mute custom sounds"			,	146, -252, 	false,	"If checked, you will be able to mute your own choice of sounds.")

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Game Options"				, 	340, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoBagAutomation"			, 	"Disable bag automation"		, 	340, -92, 	true,	"If checked, your bags will not be opened or closed automatically when you interact with a merchant or bank.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoPetAutomation"			, 	"Disable pet automation"		, 	340, -112, 	true, 	"If checked, battle pets which are automatically summoned will be dismissed within a few seconds.|n|nThis includes dragging a pet onto the first team slot in the pet journal and entering a battle pet team save command.|n|nNote that pets which are automatically summoned during combat will be dismissed when combat ends.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "CharAddonList"				, 	"Show character addons"			, 	340, -132, 	true,	"If checked, the addon list (accessible from the game menu) will show character based addons by default.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoConfirmLoot"				, 	"Disable loot warnings"			,	340, -152, 	false,	"If checked, confirmations will no longer appear when you choose a loot roll option or attempt to sell or mail a tradable item.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "FasterLooting"				, 	"Faster auto loot"				,	340, -172, 	true,	"If checked, the amount of time it takes to auto loot creatures will be significantly reduced.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "FasterMovieSkip"			, 	"Faster movie skip"				,	340, -192, 	true,	"If checked, you will be able to cancel cinematics without being prompted for confirmation.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "StandAndDismount"			, 	"Dismount me"					,	340, -212, 	true,	"If checked, you will be able to set some additional rules for when your character is automatically dismounted.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ExpandVendorPrice"			, 	"Expand vendor price"			,	340, -232, 	true,	"If checked, the vendor price will be shown in item tooltips that the default UI does not cover.|n|nThis includes quest reward tooltips, equipped gear tooltips and tooltips for items linked in chat.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "CombatPlates"				, 	"Combat plates"					,	340, -252, 	true,	"If checked, enemy nameplates will be shown during combat and hidden when combat ends.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "EasyItemDestroy"			, 	"Easy item destroy"				,	340, -272, 	true,	"If checked, you will no longer need to type delete when destroying a superior quality item.|n|nIn addition, item links will be shown in all item destroy confirmation windows.")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "NoTransforms"				, 	"Remove transforms"				, 	340, -292, 	false, 	"If checked, you will be able to have certain transforms removed automatically when they are applied to your character.|n|nYou can choose the transforms in the configuration panel.|n|nExamples include Weighted Jack-o'-Lantern and Hallowed Wand.|n|nTransforms applied during combat will be removed when combat ends.")

	LeaPlusLC:CfgBtn("SetWeatherDensityBtn", LeaPlusCB["SetWeatherDensity"])
	LeaPlusLC:CfgBtn("MuteGameSoundsBtn", LeaPlusCB["MuteGameSounds"])
	LeaPlusLC:CfgBtn("MuteMountSoundsBtn", LeaPlusCB["MuteMountSounds"])
	LeaPlusLC:CfgBtn("MuteCustomSoundsBtn", LeaPlusCB["MuteCustomSounds"])
	LeaPlusLC:CfgBtn("DismountBtn", LeaPlusCB["StandAndDismount"])
	LeaPlusLC:CfgBtn("NoTransformsBtn", LeaPlusCB["NoTransforms"])

----------------------------------------------------------------------
-- 	LC8: Settings
----------------------------------------------------------------------

	pg = "Page8";

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Addon"						, 146, -72);
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "ShowMinimapIcon"			, "Show minimap button"				, 146, -92,		false,	"If checked, a minimap button will be available.|n|nClick - Toggle options panel.|n|nSHIFT-click - Toggle music.|n|nALT-click - Toggle errors (if enabled).|n|nCTRL/SHIFT-click - Toggle windowed mode.|n|nCTRL/ALT-click - Toggle Zygor (if installed).")
	LeaPlusLC:MakeCB(LeaPlusLC[pg], "UseEnglishLanguage"		, "Use English language"			, 146, -112,	true,	"If checked, text used throughout the addon will be shown in English regardless of your game locale.")

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Scale", 340, -72);
	LeaPlusLC:MakeSL(LeaPlusLC[pg], "PlusPanelScale", "Drag to set the scale of the Leatrix Plus panel.", 1, 2, 0.1, 340, -92, "%.1f")

	LeaPlusLC:MakeTx(LeaPlusLC[pg], "Transparency", 340, -132);
	LeaPlusLC:MakeSL(LeaPlusLC[pg], "PlusPanelAlpha", "Drag to set the transparency of the Leatrix Plus panel.", 0, 1, 0.1, 340, -152, "%.1f")

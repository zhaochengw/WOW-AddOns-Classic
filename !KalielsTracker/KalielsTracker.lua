--- Kaliel's Tracker
--- Copyright (c) 2012-2023, Marouan Sabbagh <mar.sabbagh@gmail.com>
--- All Rights Reserved.
---
--- This file is part of addon Kaliel's Tracker.

local addonName, addon = ...
local KT = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "LibSink-2.0")
KT:SetDefaultModuleState(false)
KT.title = GetAddOnMetadata(addonName, "Title")
KT.version = GetAddOnMetadata(addonName, "Version")
KT.gameVersion = GetBuildInfo()
KT.locale = GetLocale()

local LSM = LibStub("LibSharedMedia-3.0")
local _DBG = function(...) if _DBG then _DBG("KT", ...) end end

-- Lua API
local abs = math.abs
local floor = math.floor
local fmod = math.fmod
local format = string.format
local gsub = string.gsub
local ipairs = ipairs
local max = math.max
local pairs = pairs
local strfind = string.find
local tonumber = tonumber
local tinsert = table.insert
local tremove = table.remove
local unpack = unpack
local round = function(n) return floor(n + 0.5) end

-- WoW API
local _G = _G
local CreateFrame = CreateFrame
local GameTooltip = GameTooltip
local HaveQuestData = HaveQuestData
local InCombatLockdown = InCombatLockdown
local FormatLargeNumber = FormatLargeNumber
local UIParent = UIParent

local trackerWidth = 280
local paddingBottom = 15
local mediaPath = "Interface\\AddOns\\"..addonName.."\\Media\\"
local questState = {}
local freeTags = {}
local freeButtons = {}
local msgPatterns = {}
local combatLockdown = false
local db, dbChar

-- Main frame
local KTF = CreateFrame("Frame", addonName.."Frame", UIParent, "BackdropTemplate")
KT.frame = KTF

-- Blizzard frame
local OTF = ObjectiveTrackerFrame
local OTFHeader = OTF.HeaderMenu

AUTO_QUEST_WATCH = GetCVar("autoQuestWatch")
DEFAULT_OBJECTIVE_TRACKER_MODULE.blockTemplate = "KT_ObjectiveTrackerBlockTemplate"
DEFAULT_OBJECTIVE_TRACKER_MODULE.lineTemplate = "KT_ObjectiveTrackerLineTemplate"
QUEST_TRACKER_MODULE.buttonOffsets.groupFinder = { 2, 4 }

--------------
-- Internal --
--------------

local function ResetIncompatibleProfiles(version)
	if KT.db.global.version and KT.IsHigherVersion(version, KT.db.global.version) then
		local profile
		for _, v in ipairs(KT.db:GetProfiles()) do
			profile = KT.db.profiles[v]
            for k, _ in pairs(profile) do
                profile[k] = nil
            end
		end
		StaticPopup_Show(addonName.."_Info", nil, "All profiles was reseted, because new version %s is not compatible with the stored settings.", {KT.version})
	end
end

local function ResetIncompatibleData(version)
	if KT.db.global.version and KT.IsHigherVersion(version, KT.db.global.version) then
		for _, char in pairs(KT.db.sv.char) do
			for k, _ in pairs(char) do
				char[k] = nil
			end
		end
	end
end

local function SetHeaders(type)
	local bgrColor = db.headerBgrColorShare and KT.borderColor or db.headerBgrColor
	local txtColor = db.headerTxtColorShare and KT.borderColor or db.headerTxtColor

	if not type or type == "background" then
		for _, header in ipairs(KT.headers) do
			if db.headerBgr == 1 then
				header.Background:Hide()
			elseif db.headerBgr == 2 then
				header.Background:SetAtlas("Objective-Header")
				header.Background:SetVertexColor(1, 1, 1)
				header.Background:ClearAllPoints()
				header.Background:SetPoint("TOPLEFT", -29, 14)
				header.Background:Show()
			elseif db.headerBgr >= 3 then
				header.Background:SetTexture(mediaPath.."UI-KT-HeaderBackground-"..(db.headerBgr - 2))
				header.Background:SetVertexColor(bgrColor.r, bgrColor.g, bgrColor.b)
				header.Background:SetPoint("TOPLEFT", -20, 0)
				header.Background:SetPoint("BOTTOMRIGHT", 17, -7)
				header.Background:Show()
			end
		end
	end
	if not type or type == "text" then
		OTFHeader.Title:SetFont(KT.font, db.fontSize, db.fontFlag)
		OTFHeader.Title:SetTextColor(txtColor.r, txtColor.g, txtColor.b)
		OTFHeader.Title:SetShadowColor(0, 0, 0, db.fontShadow)

		for _, header in ipairs(KT.headers) do
			if type == "text" then
				header.Text:SetFont(KT.font, db.fontSize+1, db.fontFlag)
				if db.headerBgr == 2 then
					header.Text:SetTextColor(1, 0.82, 0)
				else
					header.Text:SetTextColor(txtColor.r, txtColor.g, txtColor.b)
				end
				header.Text:SetShadowColor(0, 0, 0, db.fontShadow)
				header.Text:SetPoint("LEFT", 4, 0.5)
				header.animateReason = 0
			end
		end
	end
end

local function SetMsgPatterns()
	local patterns = {
		-- enUS/frFR/etc. ... "%s: %d/%d"
		-- deDE (only) ...... "%1$s: %2$d/%3$d"
		ERR_QUEST_ADD_FOUND_SII,
		ERR_QUEST_ADD_ITEM_SII,
		ERR_QUEST_ADD_KILL_SII,
		ERR_QUEST_ADD_PLAYER_KILL_SII,
	}
	for _, patt in ipairs(patterns) do
		patt = "^"..patt:gsub("%d+%$", ""):gsub("%%s", ".*"):gsub("%%d", "%%d+").."$"
		tinsert(msgPatterns, patt)
	end
end

local function SlashHandler(msg, editbox)
	local cmd, value = msg:match("^(%S*)%s*(.-)$")
	if cmd == "config" then
		KT:OpenOptions()
	else
		ObjectiveTracker_MinimizeButton_OnClick()
	end
end

local function SetScrollbarPosition()
	KTF.Bar:SetPoint("TOPRIGHT", -5, -round(5+(KTF.Scroll.value*(((db.maxHeight-60)/((OTF.height-db.maxHeight)/KTF.Scroll.step))/KTF.Scroll.step))))
end

local function GetTaskTimeLeftData(questID)
	local timeString = ""
	local timeColor = OBJECTIVE_TRACKER_COLOR["TimeLeft2"]
	local timeLeftMinutes = C_TaskQuest.GetQuestTimeLeftMinutes(questID)
	if timeLeftMinutes and timeLeftMinutes > 0 then
		timeString = SecondsToTime(timeLeftMinutes * 60)
		if timeLeftMinutes <= WORLD_QUESTS_TIME_CRITICAL_MINUTES then
			timeColor = OBJECTIVE_TRACKER_COLOR["TimeLeft"]
		end
	end
	return timeString, timeColor
end

local function ResetScale()
	local parentScale = UIParent:GetScale()
	-- UIParent 0.64 scale correction
	if parentScale > 0.64 and parentScale < 0.65 then
		local scale = KT.ConvertPixelsToUI(1, parentScale)
		KTF:SetScale(scale)
		KTF.Buttons:SetScale(scale)
	end
end

-- Setup ---------------------------------------------------------------------------------------------------------------

local function Init()
	db = KT.db.profile

	if db.keyBindMinimize ~= "" then
		SetOverrideBindingClick(KTF, false, db.keyBindMinimize, KTF.MinimizeButton:GetName())
	end

	for i, module in ipairs(db.modulesOrder) do
		OTF.MODULES_UI_ORDER[i] = _G[module]
		KT:SaveHeader(OTF.MODULES_UI_ORDER[i])
	end

	KT:MoveTracker()
	KT:SetBackground()
	KT:SetText()

	C_Timer.After(0, function()
		KT.stopUpdate = false
		KT.inWorld = true

		if dbChar.collapsed then
			ObjectiveTracker_MinimizeButton_OnClick()
		else
			ObjectiveTracker_Update()
		end

		KT:SetQuestsHeaderText()
		KT:SetAchievementsHeaderText()

		OTF:KTSetPoint("TOPLEFT", 30, -1)
		OTF:KTSetPoint("BOTTOMRIGHT")

		KT.initialized = true
	end)
end

-- Frames --------------------------------------------------------------------------------------------------------------

function KT:Event_QUEST_WATCH_LIST_CHANGED(questID, added)
	if added then
		ObjectiveTracker_Update(OBJECTIVE_TRACKER_UPDATE_QUEST_ADDED, questID)
	else
		if questID and not self.questStateStopUpdate then
			questState[questID] = nil
		end
		ObjectiveTracker_Update(OBJECTIVE_TRACKER_UPDATE_QUEST)
	end
end

local function SetFrames()
	-- Main frame
	KTF:SetWidth(trackerWidth)
	KTF:SetFrameStrata(db.frameStrata)
	KTF:SetFrameLevel(KTF:GetFrameLevel() + 25)

	KTF:SetScript("OnEvent", function(_, event, ...)
		_DBG("Event - "..event)
		if event == "PLAYER_ENTERING_WORLD" and not KT.stopUpdate then
			KT.inWorld = true
			KT.inInstance = IsInInstance()
			if db.collapseInInstance and KT.inInstance and not dbChar.collapsed then
				ObjectiveTracker_MinimizeButton_OnClick()
			end
		elseif event == "PLAYER_LEAVING_WORLD" then
			KT.inWorld = false
		elseif event == "QUEST_WATCH_LIST_CHANGED" then
			local questID, added = ...
            KT:Event_QUEST_WATCH_LIST_CHANGED(questID, added)
		elseif event == "QUEST_AUTOCOMPLETE" then
			KTF.Scroll.value = 0
		elseif event == "QUEST_ACCEPTED" then
			KT:SetQuestsHeaderText()
		elseif event == "QUEST_REMOVED" then
			local questID = ...
			KT:SetQuestsHeaderText()
			KT_RemoveQuestWatch(questID)
		elseif event == "ACHIEVEMENT_EARNED" then
			KT:SetAchievementsHeaderText()
		elseif event == "PLAYER_REGEN_ENABLED" and combatLockdown then
			combatLockdown = false
			KT:RemoveFixedButton()
			ObjectiveTracker_Update()
		elseif event == "ZONE_CHANGED_NEW_AREA" or event == "ZONE_CHANGED" then
			KTF.Buttons.reanchor = (KTF.Buttons.num > 0)
		elseif event == "UPDATE_BINDINGS" then
			KT:UpdateHotkey()
		elseif event == "PLAYER_LEVEL_UP" then
			local level = ...
			KT.playerLevel = level
		elseif event == "CVAR_UPDATE" then
			AUTO_QUEST_WATCH = GetCVar("autoQuestWatch")
		elseif event == "UI_SCALE_CHANGED" then
			ResetScale()
		end
	end)
	KTF:RegisterEvent("PLAYER_ENTERING_WORLD")
	KTF:RegisterEvent("PLAYER_LEAVING_WORLD")
	KTF:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
	KTF:RegisterEvent("QUEST_AUTOCOMPLETE")
	KTF:RegisterEvent("QUEST_ACCEPTED")
	KTF:RegisterEvent("QUEST_REMOVED")
	KTF:RegisterEvent("ACHIEVEMENT_EARNED")
	KTF:RegisterEvent("PLAYER_REGEN_ENABLED")
	KTF:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	KTF:RegisterEvent("ZONE_CHANGED")
	KTF:RegisterEvent("UPDATE_BINDINGS")
	KTF:RegisterEvent("PLAYER_LEVEL_UP")
	KTF:RegisterEvent("CVAR_UPDATE")
	KTF:RegisterEvent("UI_SCALE_CHANGED")

	-- DropDown frame
	KT.DropDown = MSA_DropDownMenu_Create(addonName.."DropDown", KTF)
	MSA_DropDownMenu_Initialize(KT.DropDown, nil, "MENU")

	-- Minimize button
	OTFHeader.MinimizeButton:Hide()
	local button = CreateFrame("Button", addonName.."MinimizeButton", KTF)
	button:SetSize(16, 16)
	button:SetPoint("TOPRIGHT", -10, -8)
	button:SetFrameLevel(KTF:GetFrameLevel() + 10)
	button:SetNormalTexture(mediaPath.."UI-KT-HeaderButtons")
	button:GetNormalTexture():SetTexCoord(0, 0.5, 0.25, 0.5)

	button:RegisterForClicks("AnyDown")
	button:SetScript("OnClick", function(self, btn)
		if IsAltKeyDown() then
			KT:OpenOptions()
		elseif not KT:IsTrackerEmpty() then
			ObjectiveTracker_MinimizeButton_OnClick()
		end
	end)
	button:SetScript("OnEnter", function(self)
		self:GetNormalTexture():SetVertexColor(1, 1, 1)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		local title = (db.keyBindMinimize ~= "") and KT.title.." "..NORMAL_FONT_COLOR_CODE.."("..db.keyBindMinimize..")|r" or KT.title
		GameTooltip:AddLine(title, 1, 1, 1)
		GameTooltip:AddLine("Alt+Click - addon Options", 0.5, 0.5, 0.5)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function(self)
		self:GetNormalTexture():SetVertexColor(KT.headerBtnColor.r, KT.headerBtnColor.g, KT.headerBtnColor.b)
		GameTooltip:Hide()
	end)
	KTF.MinimizeButton = button

	-- Scroll frame
	local Scroll = CreateFrame("ScrollFrame", addonName.."Scroll", KTF)
	Scroll:SetPoint("TOPLEFT", 4, -4)
	Scroll:SetPoint("BOTTOMRIGHT", -4, 4)
    Scroll:SetClipsChildren(true)
	Scroll:EnableMouseWheel(true)
	Scroll.step = 20
	Scroll.value = 0
	Scroll:SetScript("OnMouseWheel", function(self, delta)
		if not dbChar.collapsed and OTF.height > db.maxHeight then
			if delta < 0 then
				self.value = (self.value+self.step < OTF.height-db.maxHeight) and self.value + self.step or OTF.height - db.maxHeight
			else
				self.value = (self.value-self.step > 0) and self.value - self.step or 0
			end
			self:SetVerticalScroll(self.value)
			if db.frameScrollbar then
				SetScrollbarPosition()
			end
			if self.value > 0 and self.value < OTF.height-db.maxHeight then
				MSA_CloseDropDownMenus()
			end
			_DBG("SCROLL ... "..self.value.." ... "..OTF.height.." - "..db.maxHeight)
		end
	end)
	KTF.Scroll = Scroll

	-- Scroll child frame
	local Child = CreateFrame("Frame", addonName.."ScrollChild", KTF.Scroll)
	Child:SetSize(trackerWidth-8, 8000)
	KTF.Scroll:SetScrollChild(Child)

	-- Scroll indicator
	local Bar = CreateFrame("Frame", addonName.."ScrollBar", KTF)
	Bar:SetSize(2, 50)
	Bar:SetPoint("TOPRIGHT", -5, -5)
	Bar:SetFrameLevel(KTF:GetFrameLevel() + 10)
	Bar.texture = Bar:CreateTexture()
	Bar.texture:SetAllPoints()
	Bar:Hide()
	KTF.Bar = Bar

	-- Blizzard frame
	OTF:KTSetPoint("TOPLEFT")
	OTF:KTSetParent(Child)
	OTFHeader:Show()
	OTFHeader.Hide = function() end
	OTFHeader.SetShown = function() end
	OTFHeader:SetSize(10, 21)
	OTFHeader:ClearAllPoints()
	OTFHeader:SetPoint("TOPLEFT", -20, -1)
	OTFHeader.Title:ClearAllPoints()
	OTFHeader.Title:SetPoint("LEFT", -5, -1)
	OTFHeader.Title:SetWidth(trackerWidth - 40)
	OTFHeader.Title:SetJustifyH("LEFT")
	OTFHeader.Title:SetWordWrap(false)

	-- Other buttons
	KT:ToggleOtherButtons()

	-- Buttons frame
	local Buttons = CreateFrame("Frame", addonName.."Buttons", UIParent, "BackdropTemplate")
	Buttons:SetSize(40, 40)
	Buttons:SetPoint("TOPLEFT", 0, 0)
	Buttons:SetFrameStrata(db.frameStrata)
	Buttons:SetFrameLevel(KTF:GetFrameLevel() - 1)
	Buttons:SetAlpha(0)
	Buttons.num = 0
	Buttons.reanchor = false
	KTF.Buttons = Buttons

	ResetScale()
end

-- Hooks ---------------------------------------------------------------------------------------------------------------

local function SetHooks()
	local function SetFixedButton(block, idx, height, yOfs)
		if block.fixedTag and KT.fixedButtons[block.id] then
			idx = idx + 1
			block.fixedTag.text:SetText(idx)
			KT.fixedButtons[block.id].text:SetText(idx)
			KT.fixedButtons[block.id].num = idx
			yOfs = -(height + 7)
			height = height + 26 + 3
			KT.fixedButtons[block.id]:SetPoint("TOP", 0, yOfs)
		end
		return idx, height, yOfs
	end

	local function FixedButtonsReanchor()
		if InCombatLockdown() then
			if KTF.Buttons.num > 0 then
				combatLockdown = true
			end
		else
			if KTF.Buttons.reanchor then
				local questID, block, questLogIndex, yOfs
				local idx = 0
				local contentsHeight = 0
				-- Quest items
				_DBG(" - REANCHOR buttons - Q", true)
				for i = 1, KT_GetNumQuestWatches() do
					questID = KT_GetQuestListInfo(i).id
					block = QUEST_TRACKER_MODULE.usedBlocks[questID]
					if block and block.itemButton then
						idx, contentsHeight, yOfs = SetFixedButton(block, idx, contentsHeight, yOfs)
					end
				end
				if contentsHeight > 0 then
					contentsHeight = contentsHeight + 7 + 4
				end
				KTF.Buttons:SetHeight(contentsHeight)
				KTF.Buttons.num = idx
				KTF.Buttons.reanchor = false
			end
			if dbChar.collapsed or KTF.Buttons.num == 0 then
				KTF.Buttons:Hide()
			else
				KTF.Buttons:Show()
			end
		end
		if dbChar.collapsed or KTF.Buttons.num == 0 then
			KTF.Buttons:SetAlpha(0)
		else
			KTF.Buttons:SetAlpha(1)
		end
	end

	OTF:HookScript("OnEvent", function(self, event)
		if event == "PLAYER_ENTERING_WORLD" and not KT.initialized then
			Init()
		end
	end)

	local bck_ObjectiveTracker_Update = ObjectiveTracker_Update
	ObjectiveTracker_Update = function(reason, id)
		if KT.stopUpdate then return end
		if reason ~= OBJECTIVE_TRACKER_UPDATE_STATIC then
			local dbgReason
			if reason == OBJECTIVE_TRACKER_UPDATE_ALL then
				dbgReason = "FFFFFFFF"
			else
				dbgReason = reason and format("%x", reason) or ""
			end
			_DBG("|cffffff00Update ... "..dbgReason, true)
		end
		bck_ObjectiveTracker_Update(reason, id)
		KT:ToggleEmptyTracker(id)
		FixedButtonsReanchor()
		if dbChar.collapsed then
			local _, numQuests = GetNumQuestLogEntries()
			local title = ""
			if db.headerCollapsedTxt == 2 then
				title = "|T"..mediaPath.."KT_logo:22:22:0:1|t"..("%d/%d"):format(numQuests, MAX_QUESTLOG_QUESTS)
			elseif db.headerCollapsedTxt == 3 then
				title = "|T"..mediaPath.."KT_logo:22:22:0:1|t"..("%d/%d Quests"):format(numQuests, MAX_QUESTLOG_QUESTS)
			end
			OTFHeader.Title:SetText(title)
		end
		if reason == OBJECTIVE_TRACKER_UPDATE_STATIC then
			return
		end
		KT:SetSize()
	end

	function DEFAULT_OBJECTIVE_TRACKER_MODULE:AddObjective(block, objectiveKey, text, lineType, useFullHeight, dashStyle, colorStyle, adjustForNoText, overrideHeight)  -- RO
		if objectiveKey == "TimeLeft" then
			text, colorStyle = GetTaskTimeLeftData(block.id)
			self:FreeProgressBar(block, block.currentLine)	-- fix ProgressBar duplicity
		end
		if self == ACHIEVEMENT_TRACKER_MODULE and text == "" then
			text = "..."	-- fix Blizz bug
		end
		local _, _, leftText, colon, progress, numHave, numNeed, rightText = strfind(text, "(.-)(%s?:?%s?)((%d+)%s?/%s?(%d+))(.*)")
		if progress then
			if tonumber(numHave) > 0 and tonumber(numHave) < tonumber(numNeed) then
				progress = "|cffc8c800" .. progress .. "|r"
			end
			if not db.questsObjectiveNumSwitch then
				text = leftText .. colon .. progress .. rightText
			else
				text = progress
				if rightText ~= " " then
					text = text .. rightText
				end
				if leftText ~= "" then
					text = text .. " " .. leftText
				end
			end
		end

		local line = self:GetLine(block, objectiveKey, lineType);
		-- width
		if ( block.lineWidth ~= line.width ) then
			line.Text:SetWidth(block.lineWidth or self.lineWidth);
			line.width = block.lineWidth;	-- default should be nil
		end
		-- dash
		if ( line.Dash ) then
			if ( not dashStyle ) then
				dashStyle = OBJECTIVE_DASH_STYLE_SHOW;
			end
			if ( line.dashStyle ~= dashStyle ) then
				if ( dashStyle == OBJECTIVE_DASH_STYLE_SHOW ) then
					line.Dash:Show();
					line.Dash:SetText(KT.QUEST_DASH);
				elseif ( dashStyle == OBJECTIVE_DASH_STYLE_HIDE ) then
					line.Dash:Hide();
					line.Dash:SetText(KT.QUEST_DASH);
				elseif ( dashStyle == OBJECTIVE_DASH_STYLE_HIDE_AND_COLLAPSE ) then
					line.Dash:Hide();
					line.Dash:SetText(nil);
				else
					error("Invalid dash style: " .. tostring(dashStyle));
				end
				line.dashStyle = dashStyle;
			end
			if not line.Dash.KTskinned or KT.forcedUpdate then
				line.Dash:SetFont(KT.font, db.fontSize, db.fontFlag)
				line.Dash:SetShadowColor(0, 0, 0, db.fontShadow)
				line.Dash.KTskinned = true
			end
		end
		-- check
		if line.Check and (not line.Check.KTskinned or KT.forcedUpdate) then
			line.Check:SetSize(db.fontSize-2.5, db.fontSize-2.5)
			line.Check:ClearAllPoints()
			line.Check:SetPoint("TOPLEFT", -db.fontSize*0.2+(db.fontFlag == "" and 0 or 1), -2)
			line.Check.KTskinned = true
		end
		-- set the text
		local textHeight = self:SetStringText(line.Text, text, useFullHeight, colorStyle, block.isHighlighted);
		local height = overrideHeight or textHeight;
		line:SetHeight(height);

		local yOffset;

		if ( adjustForNoText and text == "" ) then
			-- don't change the height
			-- move the line up so the next object ends up in the same position as if there had been no line
			yOffset = height;
		else
			block.height = block.height + height + block.module.lineSpacing;
			yOffset = -block.module.lineSpacing;
		end
		-- anchor the line
		local anchor = block.currentLine or block.HeaderText;
		if ( anchor ) then
			line:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, yOffset);
		else
			line:SetPoint("TOPLEFT", 0, yOffset);
		end
		block.currentLine = line;

		-- completion state
		if KT.inWorld and type(objectiveKey) == "string" then
			if strfind(objectiveKey, "QuestComplete") then
				if not questState[block.id] or questState[block.id] ~= "complete" then
					if db.messageQuest then
						KT:SetMessage(block.title, 0, 1, 0, ERR_QUEST_COMPLETE_S, "Interface\\GossipFrame\\ActiveQuestIcon", -2, 0)
					end
					if db.soundQuest then
						KT:PlaySound(db.soundQuestComplete)
					end
					questState[block.id] = "complete"
				end
			elseif strfind(objectiveKey, "QuestFailed") then
				if not questState[block.id] or questState[block.id] ~= "failed" then
					if db.messageQuest then
						KT:SetMessage(block.title, 1, 0, 0, ERR_QUEST_FAILED_S, "Interface\\GossipFrame\\AvailableQuestIcon", -2, 0)
					end
					questState[block.id] = "failed"
				end
			end
		end

		return line;
	end

	function DEFAULT_OBJECTIVE_TRACKER_MODULE:SetStringText(fontString, text, useFullHeight, colorStyle, useHighlight)  -- RO
		if not fontString.KTskinned or KT.forcedUpdate then
			fontString:SetFont(KT.font, db.fontSize, db.fontFlag)
			fontString:SetShadowColor(0, 0, 0, db.fontShadow)
			fontString:SetWordWrap(db.textWordWrap)
			fontString.KTskinned = true
		end
		if self == QUEST_TRACKER_MODULE and not useHighlight then
			useHighlight = fontString:GetParent().isHighlighted		-- Fix Blizz bug
		end
		fontString:SetHeight(0)
		fontString:SetText(text)
		local stringHeight = fontString:GetHeight()
		if ( stringHeight > KT.OBJECTIVE_TRACKER_DOUBLE_LINE_HEIGHT and not useFullHeight ) then
			fontString:SetHeight(KT.OBJECTIVE_TRACKER_DOUBLE_LINE_HEIGHT)
			stringHeight = KT.OBJECTIVE_TRACKER_DOUBLE_LINE_HEIGHT
		end
		colorStyle = colorStyle or OBJECTIVE_TRACKER_COLOR["Normal"]
		if ( useHighlight and colorStyle.reverse ) then
			colorStyle = colorStyle.reverse
		end
		if ( fontString.colorStyle ~= colorStyle ) then
			fontString:SetTextColor(colorStyle.r, colorStyle.g, colorStyle.b)
			fontString.colorStyle = colorStyle
		end
		return stringHeight
	end

	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderEnter", function(self, block)
		local colorStyle, _
		if self == QUEST_TRACKER_MODULE then
			if block.questCompleted then
				colorStyle = OBJECTIVE_TRACKER_COLOR["CompleteHighlight"]
			elseif db.colorDifficulty then
				_, colorStyle = GetQuestDifficultyColor(block.level)
			end
		end
		if colorStyle then
			block.HeaderText:SetTextColor(colorStyle.r, colorStyle.g, colorStyle.b)
			block.HeaderText.colorStyle = colorStyle
		end

		if db.tooltipShow and (self == QUEST_TRACKER_MODULE or self == ACHIEVEMENT_TRACKER_MODULE) then
			GameTooltip:SetOwner(block, "ANCHOR_NONE")
			GameTooltip:ClearAllPoints()
			if KTF.anchorLeft then
				GameTooltip:SetPoint("TOPLEFT", block, "TOPRIGHT", 12, 1)
			else
				GameTooltip:SetPoint("TOPRIGHT", block, "TOPLEFT", -32, 1)
			end
			if self == QUEST_TRACKER_MODULE then
				local questLogIndex = GetQuestLogIndexByID(block.id)
				local questTitle = KT.QuestUtils_GetQuestName(block.id)
				local _, questDescription = GetQuestLogQuestText(questLogIndex)
				local questZone = KT.QuestUtils_GetQuestZone(block.id)
				GameTooltip:AddLine(questTitle, nil, nil, nil, true)
			    if questZone then
				    GameTooltip:AddLine(questZone, OBJECTIVE_TRACKER_COLOR["Zone"].r, OBJECTIVE_TRACKER_COLOR["Zone"].g, OBJECTIVE_TRACKER_COLOR["Zone"].b, true)
				end
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(questDescription, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, true)
				if db.tooltipShowRewards then
					KT.GameTooltip_AddQuestRewardsToTooltip(GameTooltip, block.id)
				end
			else
				GameTooltip:SetHyperlink(GetAchievementLink(block.id))
			end
			if db.tooltipShowID then
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine(" ", "ID: |cffffffff"..block.id)
			end
			GameTooltip:Show()
		end

		if block.fixedTag then
			colorStyle = OBJECTIVE_TRACKER_COLOR["NormalHighlight"]
			block.fixedTag:SetBackdropColor(colorStyle.r, colorStyle.g, colorStyle.b)
			block.fixedTag.text:SetTextColor(colorStyle.r, colorStyle.g, colorStyle.b)
		end
	end)

	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderLeave", function(self, block)
		local colorStyle
		if self == QUEST_TRACKER_MODULE then
			if block.questCompleted then
				colorStyle = OBJECTIVE_TRACKER_COLOR["Complete"]
			elseif db.colorDifficulty then
				colorStyle = GetQuestDifficultyColor(block.level)
			end
		end
		if colorStyle then
			block.HeaderText:SetTextColor(colorStyle.r, colorStyle.g, colorStyle.b)
			block.HeaderText.colorStyle = colorStyle
		end

		if db.tooltipShow then
			GameTooltip:Hide()
		end

		if block.fixedTag then
			colorStyle = OBJECTIVE_TRACKER_COLOR["Normal"]
			block.fixedTag:SetBackdropColor(colorStyle.r, colorStyle.g, colorStyle.b)
			block.fixedTag.text:SetTextColor(colorStyle.r, colorStyle.g, colorStyle.b)
		end
	end)

	hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderClick", function(self, block, mouseButton)
		GameTooltip:Hide()
	end)
	hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderClick", function(self, block, mouseButton)
		GameTooltip:Hide()
	end)

	function KT_ObjectiveTrackerBlock_OnEnter(self)
		self.module:OnBlockHeaderEnter(self)
	end

	function KT_ObjectiveTrackerBlock_OnLeave(self)
		self.module:OnBlockHeaderLeave(self)
	end

	function KT_ObjectiveTrackerBlock_OnClick(self, mouseButton)
		self.module:OnBlockHeaderClick(self, mouseButton)
	end

	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "FreeUnusedLines", function(self, block)
		local colorStyle
		if block.questCompleted then
			colorStyle = OBJECTIVE_TRACKER_COLOR["Complete"]
		elseif db.colorDifficulty and self == QUEST_TRACKER_MODULE then
			colorStyle = GetQuestDifficultyColor(block.level)
		end
		if colorStyle then
			block.HeaderText:SetTextColor(colorStyle.r, colorStyle.g, colorStyle.b)
			block.HeaderText.colorStyle = colorStyle
		end
	end)

	local function CreateFixedTag(block, x, y, anchor)
		local tag = block.fixedTag
		if not tag then
			local numFreeButtons = #freeTags
			if numFreeButtons > 0 then
				tag = freeTags[numFreeButtons]
				tremove(freeTags, numFreeButtons)
				tag:SetParent(block)
				tag:ClearAllPoints()
			else
				tag = CreateFrame("Frame", nil, block, "BackdropTemplate")
				tag:SetSize(32, 32)
				tag:SetBackdrop({ bgFile = mediaPath.."UI-KT-QuestItemTag" })
				tag.text = tag:CreateFontString(nil, "ARTWORK", "GameFontNormalMed1")
				tag.text:SetFont(LSM:Fetch("font", "Arial Narrow"), 13, "")
				tag.text:SetPoint("CENTER", -0.5, 1)
			end
			tag:SetPoint(anchor or "TOPRIGHT", block, x, y)
			tag:Show()
			block.fixedTag = tag
		end

		local colorStyle = OBJECTIVE_TRACKER_COLOR["Normal"]
		if block.isHighlighted and colorStyle.reverse then
			colorStyle = colorStyle.reverse
		end
		tag:SetBackdropColor(colorStyle.r, colorStyle.g, colorStyle.b)
		tag.text:SetTextColor(colorStyle.r, colorStyle.g, colorStyle.b)
	end

	local function CreateFixedButton(block, isSpell)
		local questID = block.id
		local button = KT:GetFixedButton(questID)
		if not button then
			if InCombatLockdown() then
				_DBG(" - STOP Create button")
				combatLockdown = true
				return nil
			end

			local numFreeButtons = #freeButtons
			if numFreeButtons > 0 then
				_DBG(" - USE button "..questID)
				button = freeButtons[numFreeButtons]
				tremove(freeButtons, numFreeButtons)
			else
				_DBG(" - CREATE button "..questID)
				local name = addonName.."Button"..time()..questID
				button = CreateFrame("Button", name, KTF.Buttons, "SecureActionButtonTemplate")		--"KTQuestObjectiveItemButtonTemplate"
				button:SetSize(26, 26)

				button.icon = button:CreateTexture(name.."Icon", "BORDER")
				button.icon:SetAllPoints()
                button.Icon = button.icon   -- for Spell

				button.Count = button:CreateFontString(name.."Count", "BORDER", "NumberFontNormal")
				button.Count:SetJustifyH("RIGHT")
				button.Count:SetPoint("BOTTOMRIGHT", button.icon, -3, 2)

				button.Cooldown = CreateFrame("Cooldown", name.."Cooldown", button, "CooldownFrameTemplate")
				button.Cooldown:SetAllPoints()

				button.HotKey = button:CreateFontString(name.."HotKey", "ARTWORK", "NumberFontNormalSmallGray")
				button.HotKey:SetSize(29, 10)
				button.HotKey:SetJustifyH("RIGHT")
				button.HotKey:SetText(RANGE_INDICATOR)
				button.HotKey:SetPoint("TOPRIGHT", button.icon, 2, -2)

				button.text = button:CreateFontString(name.."Text", "ARTWORK", "NumberFontNormalSmall")
				button.text:SetSize(29, 10)
				button.text:SetJustifyH("LEFT")
				button.text:SetPoint("TOPLEFT", button.icon, 1, -3)

				button:RegisterForClicks("AnyUp")

				button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2")
				do local tex = button:GetNormalTexture()
					tex:ClearAllPoints()
					tex:SetPoint("CENTER")
					tex:SetSize(44, 44)
				end
				button:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
				button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
				button:SetFrameLevel(KTF:GetFrameLevel() + 1)
				button:Hide()	-- Cooldown init

				--KT:Masque_AddButton(button)
            end
            if not isSpell then
				button:SetScript("OnEvent", QuestObjectiveItem_OnEvent)
				button:SetScript("OnUpdate", QuestObjectiveItem_OnUpdate)
				button:SetScript("OnShow", QuestObjectiveItem_OnShow)
				button:SetScript("OnHide", QuestObjectiveItem_OnHide)
				button:SetScript("OnEnter", QuestObjectiveItem_OnEnter)
				button:SetScript("OnLeave", QuestObjectiveItem_OnLeave)
			else
				button.HotKey:Hide()
				button:SetScript("OnEvent", nil)
				button:SetScript("OnUpdate", nil)
				button:SetScript("OnShow", nil)
				button:SetScript("OnHide", nil)
				button:SetScript("OnEnter", ScenarioSpellButton_OnEnter)
				button:SetScript("OnLeave", GameTooltip_Hide)
			end
			button:SetScript("OnMouseDown", QuestObjectiveItem_OnClick)
            button:SetAttribute("type*", isSpell and "spell" or "item")
			button:Show()
			KT.fixedButtons[questID] = button
			KTF.Buttons.reanchor = true
		end
		button.block = block
		button:SetAlpha(1)
		return button
	end

	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "SetBlockHeader", function(self, block, text)
		block.lineWidth = block.lineWidth or self.lineWidth - 8		-- mod default
	end)

	local bck_QUEST_TRACKER_MODULE_SetBlockHeader = QUEST_TRACKER_MODULE.SetBlockHeader
	function QUEST_TRACKER_MODULE:SetBlockHeader(block, text, questLogIndex, isQuestComplete, questID)
		local _, level, suggestedGroup, _, _, _, frequency, _ = GetQuestLogTitle(questLogIndex)
		if db.questsShowLevels then
			text = KT:CreateQuestLevel(level)..text
		end
		block.title = text
		if db.questsShowTags then
			local tagID, _ = GetQuestTagInfo(questID)
			text = text..KT:CreateQuestTag(tagID, frequency, suggestedGroup)
		end
		bck_QUEST_TRACKER_MODULE_SetBlockHeader(self, block, text, questLogIndex, isQuestComplete, questID)
		block.lineWidth = block.lineWidth or self.lineWidth - 8		-- mod default
		block.level = level

		local link, item, charges, showItemWhenComplete = GetQuestLogSpecialItemInfo(questLogIndex)
		if item and (not isQuestComplete or showItemWhenComplete) then
			block.itemButton:Hide()
			CreateFixedTag(block, 3, 4)
			local button = CreateFixedButton(block)
			if not InCombatLockdown() then
				button:SetID(questLogIndex)
				button.charges = charges
				button.rangeTimer = -1
				button.item = item
				button.link = link
				SetItemButtonTexture(button, item)
				SetItemButtonCount(button, charges)
				QuestObjectiveItem_UpdateCooldown(button)
				button:SetAttribute("item", link)
			end
		else
			KT:RemoveFixedButton(block)
		end
	end

	local bck_QUEST_TRACKER_MODULE_OnFreeBlock = QUEST_TRACKER_MODULE.OnFreeBlock
	function QUEST_TRACKER_MODULE:OnFreeBlock(block)
		KT:RemoveFixedButton(block)
		bck_QUEST_TRACKER_MODULE_OnFreeBlock(self, block)
	end

	local function SetProgressBarStyle(progressBar)
		if not progressBar.KTskinned or KT.forcedUpdate then
			local block = progressBar.block
			block.height = block.height - progressBar.height

			progressBar:SetSize(232, 23)
			progressBar.height = 23
			--_C(progressBar, { r = 0, g = 1, b = 0 })

			progressBar.Bar:SetSize(208, 13)
			progressBar.Bar:EnableMouse(false)
			progressBar.Bar:ClearAllPoints()

			if progressBar.Bar.BarFrame then
				-- World Quest
				progressBar.Bar:SetPoint("LEFT", 22, 0)
				progressBar.Bar.BarFrame:Hide()
				progressBar.Bar.BarFrame2:Hide()
				progressBar.Bar.BarFrame3:Hide()
				progressBar.Bar.BarGlow:Hide()
				progressBar.Bar.Sheen:Hide()
				progressBar.Bar.Starburst:Hide()
			else
				-- Default
				progressBar.Bar:SetPoint("LEFT", 2, 0)
				progressBar.Bar.BorderLeft:Hide()
				progressBar.Bar.BorderRight:Hide()
				progressBar.Bar.BorderMid:Hide()
			end

			local border1 = progressBar.Bar:CreateTexture(nil, "BACKGROUND", nil, -2)
			border1:SetPoint("TOPLEFT", -1, 1)
			border1:SetPoint("BOTTOMRIGHT", 1, -1)
			border1:SetColorTexture(0, 0, 0)

			local border2 = progressBar.Bar:CreateTexture(nil, "BACKGROUND", nil, -3)
			border2:SetPoint("TOPLEFT", -2, 2)
			border2:SetPoint("BOTTOMRIGHT", 2, -2)
			border2:SetColorTexture(0.4, 0.4, 0.4)

			progressBar.Bar.Label:SetPoint("CENTER", 0, 0.5)
			progressBar.Bar.Label:SetFont(LSM:Fetch("font", "Arial Narrow"), 13, "")
			progressBar.Bar:SetStatusBarTexture(LSM:Fetch("statusbar", db.progressBar))
			progressBar.KTskinned = true
			progressBar.isSkinned = true	-- ElvUI hack

			block.height = block.height + progressBar.height
		end
	end

	local bck_DEFAULT_OBJECTIVE_TRACKER_MODULE_AddProgressBar = DEFAULT_OBJECTIVE_TRACKER_MODULE.AddProgressBar
	function DEFAULT_OBJECTIVE_TRACKER_MODULE:AddProgressBar(block, line, questID)
		local progressBar = bck_DEFAULT_OBJECTIVE_TRACKER_MODULE_AddProgressBar(self, block, line, questID)
		SetProgressBarStyle(progressBar)
		return progressBar
	end

	hooksecurefunc("ObjectiveTracker_OnSlideBlockUpdate", function(block, elapsed)
		local slideData = block.slideData
		if block.slideTime >= slideData.duration + (slideData.endDelay or 0) then
			ObjectiveTracker_Update()	-- update after expand collapsed tracker
		end
	end)

	function ObjectiveTracker_Collapse()  -- R
		_DBG("--------------------------------")
		_DBG("COLLAPSE")
		OTF.collapsed = true
		dbChar.collapsed = OTF.collapsed
		OTF.BlocksFrame:Hide()
		KTF.MinimizeButton:GetNormalTexture():SetTexCoord(0, 0.5, 0, 0.25)
		OTFHeader.Title:Show()
		MSA_CloseDropDownMenus()
	end

	function ObjectiveTracker_Expand()  -- R
		_DBG("--------------------------------")
		_DBG("EXPAND")
		OTF.collapsed = nil
		dbChar.collapsed = OTF.collapsed
		OTF.BlocksFrame:Show()
		KTF.MinimizeButton:GetNormalTexture():SetTexCoord(0, 0.5, 0.25, 0.5)
		OTFHeader.Title:Hide()
		MSA_CloseDropDownMenus()
	end

	local bck_ObjectiveTracker_ReorderModules = ObjectiveTracker_ReorderModules
	ObjectiveTracker_ReorderModules = function()
		local reorder = false
		for i = 1, #OTF.MODULES do
			if OTF.MODULES[i] ~= OTF.MODULES_UI_ORDER[i] then
				reorder = true
				break
			end
		end
		if reorder then
			bck_ObjectiveTracker_ReorderModules()
		end
	end

	local bck_UIErrorsFrame_OnEvent = UIErrorsFrame:GetScript("OnEvent")
	UIErrorsFrame:SetScript("OnEvent", function(self, event, ...)
		if db.messageQuest and event == "UI_INFO_MESSAGE" then
			local text, _ = ...
			for _, patt in ipairs(msgPatterns) do
				if strfind(text, patt) then
					KT:SetMessage(text, 1, 1, 0, nil, "Interface\\GossipFrame\\AvailableQuestIcon", -2, 0)
					return
				end
			end
		end
		bck_UIErrorsFrame_OnEvent(self, event, ...)
	end)

	function QuestMapFrame_OpenToQuestDetails(questID)	-- R
		local mapID = GetQuestUiMapID(questID);
		if ( mapID == 0 ) then mapID = nil; end
		OpenQuestLog(mapID);	-- fix Blizz bug
		QuestMapFrame_ShowQuestDetails(questID);
	end

	-- Item handler functions
	function QuestObjectiveItem_OnEnter(self)  -- R
		self.block.module:OnBlockHeaderEnter(self.block)
		if KTF.anchorLeft then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 3)
		else
			GameTooltip:SetOwner(self, "ANCHOR_LEFT", -3)
		end
		GameTooltip:SetHyperlink(self.link)
	end

	function QuestObjectiveItem_OnLeave(self)
		self.block.module:OnBlockHeaderLeave(self.block)
		GameTooltip:Hide()
	end

	function QuestObjectiveItem_OnUpdate(self, elapsed)  -- R
		local rangeTimer = self.rangeTimer
		if rangeTimer then
			rangeTimer = rangeTimer - elapsed
			if rangeTimer <= 0 then
				local link, item, charges, showItemWhenComplete = GetQuestLogSpecialItemInfo(self:GetID())
				if charges and charges ~= self.charges then
					ObjectiveTracker_Update(OBJECTIVE_TRACKER_UPDATE_MODULE_QUEST)
					return
				end
				local hotkey = self.HotKey
				local valid = IsQuestLogSpecialItemInRange(self:GetID())
				if hotkey:GetText() == RANGE_INDICATOR then
					if valid == 0 then
						hotkey:Show()
						hotkey:SetVertexColor(1.0, 0.1, 0.1)
					elseif valid == 1 then
						hotkey:Show()
						hotkey:SetVertexColor(0.6, 0.6, 0.6)
					else
						hotkey:Hide()
					end
				else
					if valid == 0 then
						hotkey:SetVertexColor(1.0, 0.1, 0.1)
					else
						hotkey:SetVertexColor(0.6, 0.6, 0.6)
					end
				end
				rangeTimer = TOOLTIP_UPDATE_TIME
			end
			self.rangeTimer = rangeTimer
		end
	end

	-- DropDown
	function ObjectiveTracker_ToggleDropDown(frame, handlerFunc)  -- R
		local dropDown = KT.DropDown;
		if ( dropDown.activeFrame ~= frame ) then
			MSA_CloseDropDownMenus();
		end
		dropDown.activeFrame = frame;
		dropDown.initialize = handlerFunc;
		MSA_ToggleDropDownMenu(1, nil, dropDown, "cursor", 3, -3, nil, nil, MSA_DROPDOWNMENU_SHOW_TIME);
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	end

	function QUEST_TRACKER_MODULE:OnBlockHeaderClick(block, mouseButton)  -- R
		if ( IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() ) then
			local questName = KT.QuestUtils_GetQuestName(block.id);
			ChatEdit_InsertLink("["..gsub(questName, " *(.*)", "%1").." ("..block.id..")]")
		elseif ( mouseButton ~= "RightButton" ) then
			MSA_CloseDropDownMenus();
			if ( IsModifiedClick("QUESTWATCHTOGGLE") ) then
				QuestObjectiveTracker_UntrackQuest(nil, block.id);
			elseif IsModifiedClick(db.menuWowheadURLModifier) then
				KT:ShowPopup("quest", block.id)
			else
				QuestObjectiveTracker_OpenQuestDetails(nil, block.id)
			end
			return;
		else
			ObjectiveTracker_ToggleDropDown(block, QuestObjectiveTracker_OnOpenDropDown);
		end
	end

	function QuestObjectiveTracker_OnOpenDropDown(self)  -- R
		local block = self.activeFrame;
		local questLogIndex = GetQuestLogIndexByID(block.id);

		local info = MSA_DropDownMenu_CreateInfo();
		info.text = GetQuestLogTitle(questLogIndex);
		info.isTitle = 1;
		info.notCheckable = 1;
		MSA_DropDownMenu_AddButton(info, MSA_DROPDOWN_MENU_LEVEL);

		info = MSA_DropDownMenu_CreateInfo();
		info.notCheckable = 1;

		info.text = OBJECTIVES_VIEW_IN_QUESTLOG;
		info.func = QuestObjectiveTracker_OpenQuestDetails;
		info.arg1 = block.id;
		info.noClickSound = 1;
		info.checked = false;
		MSA_DropDownMenu_AddButton(info, MSA_DROPDOWN_MENU_LEVEL);

		if ( GetQuestLogPushable(questLogIndex) and IsInGroup() ) then
			info.text = SHARE_QUEST;
			info.func = QuestObjectiveTracker_ShareQuest;
			info.arg1 = block.id;
			info.checked = false;
			MSA_DropDownMenu_AddButton(info, MSA_DROPDOWN_MENU_LEVEL);
		end

		info.text = OBJECTIVES_STOP_TRACKING;
		info.func = QuestObjectiveTracker_UntrackQuest;
		info.arg1 = block.id;
		info.checked = false;
		info.disabled = (db.filterAuto[1]);
		MSA_DropDownMenu_AddButton(info, MSA_DROPDOWN_MENU_LEVEL);

		info.disabled = false;

		info.text = ABANDON_QUEST;
		info.func = function(_, questID) QuestMapQuestOptions_AbandonQuest(questID) end;
		info.arg1 = block.id;
		MSA_DropDownMenu_AddButton(info, MSA_DROPDOWNMENU_MENU_LEVEL);

		if db.menuWowheadURL then
			info.text = "|cff33ff99Wowhead|r URL";
			info.func = KT.ShowPopup;
			info.arg1 = "quest";
			info.arg2 = block.id;
			info.checked = false;
			MSA_DropDownMenu_AddButton(info, MSA_DROPDOWN_MENU_LEVEL);
		end

		KT.AddonQuestie:CreateMenu(info, block.id)
	end

	function ACHIEVEMENT_TRACKER_MODULE:OnBlockHeaderClick(block, mouseButton)  -- R
		if ( IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() ) then
			local achievementLink = GetAchievementLink(block.id);
			if ( achievementLink ) then
				ChatEdit_InsertLink(achievementLink);
			end
		elseif ( mouseButton ~= "RightButton" ) then
			MSA_CloseDropDownMenus();
			if ( not AchievementFrame ) then
				AchievementFrame_LoadUI();
			end
			if ( IsModifiedClick("QUESTWATCHTOGGLE") ) then
				AchievementObjectiveTracker_UntrackAchievement(_, block.id);
			elseif IsModifiedClick(db.menuWowheadURLModifier) then
				KT:ShowPopup("achievement", block.id)
			elseif ( not AchievementFrame:IsShown() ) then
				AchievementFrame_ToggleAchievementFrame();
				AchievementFrame_SelectAchievement(block.id);
			else
				if ( AchievementFrameAchievements.selection ~= block.id ) then
					AchievementFrame_SelectAchievement(block.id);
				else
					AchievementFrame_ToggleAchievementFrame();
				end
			end
		else
			ObjectiveTracker_ToggleDropDown(block, AchievementObjectiveTracker_OnOpenDropDown);
		end
	end

	function AchievementObjectiveTracker_OnOpenDropDown(self)  -- R
		local block = self.activeFrame;
		local _, achievementName, _, completed, _, _, _, _, _, icon = GetAchievementInfo(block.id);

		local info = MSA_DropDownMenu_CreateInfo();
		info.text = achievementName;
		info.isTitle = 1;
		info.notCheckable = 1;
		MSA_DropDownMenu_AddButton(info, MSA_DROPDOWN_MENU_LEVEL);

		info = MSA_DropDownMenu_CreateInfo();
		info.notCheckable = 1;

		info.text = OBJECTIVES_VIEW_ACHIEVEMENT;
		info.func = function (button, ...) OpenAchievementFrameToAchievement(...); end;
		info.arg1 = block.id;
		info.checked = false;
		MSA_DropDownMenu_AddButton(info, MSA_DROPDOWN_MENU_LEVEL);

		info.text = OBJECTIVES_STOP_TRACKING;
		info.func = AchievementObjectiveTracker_UntrackAchievement;
		info.arg1 = block.id;
		info.checked = false;
		info.disabled = (db.filterAuto[2]);
		MSA_DropDownMenu_AddButton(info, MSA_DROPDOWN_MENU_LEVEL);

		info.disabled = false;

		if db.menuWowheadURL then
			info.text = "|cff33ff99Wowhead|r URL";
			info.func = KT.ShowPopup;
			info.arg1 = "achievement";
			info.arg2 = block.id;
			info.checked = false;
			MSA_DropDownMenu_AddButton(info, MSA_DROPDOWN_MENU_LEVEL);
		end
	end
end

--------------
-- External --
--------------

function KT:SetSize()
	local height = 33
	local mod = 0

	if OTF.BlocksFrame.contentsHeight then
		OTF.BlocksFrame.contentsHeight = round(OTF.BlocksFrame.contentsHeight)
	else
		return
	end

	_DBG(" - height = "..OTF.BlocksFrame.contentsHeight)
	if not dbChar.collapsed and not self:IsTrackerEmpty() then
		-- width
		KTF:SetWidth(trackerWidth)

		-- height
		height = OTF.BlocksFrame.contentsHeight + mod + 10 + paddingBottom
		_DBG(" - "..OTF.BlocksFrame.contentsHeight.." + "..mod.." + 10 + "..paddingBottom.." = "..height, true)
		OTF.height = height

		if height > db.maxHeight then
			_DBG("MOVE ... "..KTF.Scroll.value.." > "..OTF.height.." - "..db.maxHeight)
			if KTF.Scroll.value > OTF.height-db.maxHeight then
				KTF.Scroll.value = OTF.height - db.maxHeight
			end
			KTF.Scroll:SetVerticalScroll(KTF.Scroll.value)
			if db.frameScrollbar then
				SetScrollbarPosition()
				KTF.Bar:Show()
			end
			height = db.maxHeight
		elseif height <= db.maxHeight then
			if KTF.Scroll.value > 0 then
				KTF.Scroll.value = 0
				KTF.Scroll:SetVerticalScroll(0)
			end
			if db.frameScrollbar then
				KTF.Bar:Hide()
			end
		end
		if height ~= KTF.height then
			KTF:SetHeight(height)
			KTF.height = height
		end
		self:MoveButtons()
	else
		-- width
		if db.headerCollapsedTxt == 1 then
			local width = 35
			if KTF.FilterButton then
				width = width + 20
			end
			if db.headerOtherButtons then
				width = width + 40
			end
			KTF:SetWidth(width)
		else
			KTF:SetWidth(trackerWidth)
		end

		-- height
		OTF.height = height - 10
		OTF:SetHeight(OTF.height)
        if OTF.BlocksFrame.contentsHeight == 0 then
            KTF.Scroll.value = 0
        end
		KTF.Scroll:SetVerticalScroll(0)
		if db.frameScrollbar then
			KTF.Bar:Hide()
		end
		if height ~= KTF.height then
			KTF:SetHeight(height)
			KTF.height = height
		end
	end
end

function KT:MoveTracker()
	KTF:ClearAllPoints()
	KTF:SetPoint(db.anchorPoint, UIParent, db.anchorPoint, db.xOffset, db.yOffset)
	KTF.directionUp = (db.anchorPoint == "BOTTOMLEFT" or db.anchorPoint == "BOTTOMRIGHT")
	KTF.anchorLeft = (db.anchorPoint == "TOPLEFT" or db.anchorPoint == "BOTTOMLEFT")

	local options = self.options.args.general.args.sec1.args
	if KTF.anchorLeft then
		options.xOffset.min = 0
		options.xOffset.max = self.screenWidth - trackerWidth
	else
		options.xOffset.min = -(self.screenWidth - trackerWidth)
		options.xOffset.max = 0
	end

	if KTF.directionUp then
		options.yOffset.min = 0
		options.yOffset.max = self.screenHeight - options.maxHeight.min
	else
		options.yOffset.min = -(self.screenHeight - options.maxHeight.min)
		options.yOffset.max = 0
	end

	options.maxHeight.max = self.screenHeight - abs(db.yOffset)
	db.maxHeight = (abs(db.yOffset)+db.maxHeight > self.screenHeight) and options.maxHeight.max or db.maxHeight

	self:MoveButtons()
end

function KT:SetBackground()
	local backdrop = {
		bgFile = LSM:Fetch("background", db.bgr),
		edgeFile = LSM:Fetch("border", db.border),
		edgeSize = db.borderThickness,
		insets = { left=db.bgrInset, right=db.bgrInset, top=db.bgrInset, bottom=db.bgrInset }
	}
	self.borderColor = db.classBorder and self.classColor or db.borderColor

	KTF:SetBackdrop(backdrop)
	KTF:SetBackdropColor(db.bgrColor.r, db.bgrColor.g, db.bgrColor.b, db.bgrColor.a)
	KTF:SetBackdropBorderColor(self.borderColor.r, self.borderColor.g, self.borderColor.b, db.borderAlpha)

	SetHeaders("background")

	self.headerBtnColor = db.headerBtnColorShare and self.borderColor or db.headerBtnColor
	KTF.MinimizeButton:GetNormalTexture():SetVertexColor(self.headerBtnColor.r, self.headerBtnColor.g, self.headerBtnColor.b)
	if self.Filters:IsEnabled() then
		if db.filterAuto[1] or db.filterAuto[2] or db.filterAuto[3] then
			KTF.FilterButton:GetNormalTexture():SetVertexColor(0, 1, 0)
		else
			KTF.FilterButton:GetNormalTexture():SetVertexColor(self.headerBtnColor.r, self.headerBtnColor.g, self.headerBtnColor.b)
		end
	end
	if db.headerOtherButtons then
		KTF.QuestLogButton:GetNormalTexture():SetVertexColor(self.headerBtnColor.r, self.headerBtnColor.g, self.headerBtnColor.b)
		KTF.AchievementsButton:GetNormalTexture():SetVertexColor(self.headerBtnColor.r, self.headerBtnColor.g, self.headerBtnColor.b)
	end

	if db.qiBgrBorder then
		KTF.Buttons:SetBackdrop(backdrop)
		KTF.Buttons:SetBackdropColor(db.bgrColor.r, db.bgrColor.g, db.bgrColor.b, db.bgrColor.a)
		KTF.Buttons:SetBackdropBorderColor(self.borderColor.r, self.borderColor.g, self.borderColor.b, db.borderAlpha)
	else
		KTF.Buttons:SetBackdrop(nil)
	end

	KTF.Bar.texture:SetColorTexture(self.borderColor.r, self.borderColor.g, self.borderColor.b, db.borderAlpha)

	if db.bgr == "None" and db.border == "None" then
		KTF.Scroll:SetHitRectInsets(-150, 0, 0, 0.1)
	else
		KTF.Scroll:SetHitRectInsets(0.1, 0, 0, 0.1)
    end

    OTFHeader.Title:SetJustifyH(db.bgr == "None" and "RIGHT" or "LEFT")
end

function KT:SetText()
	self.font = LSM:Fetch("font", db.font)

	KT.OBJECTIVE_TRACKER_DOUBLE_LINE_HEIGHT = (2 * db.fontSize) + 1

	-- Headers
	SetHeaders("text")
end

function KT:SaveHeader(module)
	module.Header.Text:SetWidth(165)
	module.Header.LineGlow:Hide()
	module.Header.SoftGlow:Hide()
	module.Header.StarBurst:Hide()
	module.Header.LineSheen:Hide()
	tinsert(KT.headers, module.Header)
	module.title = module.Header.Text:GetText()
end

function KT:SetHeaderText(module, append)
	local text = module.title
	if append then
		text = format("%s (%s)", text, append)
	end
	module.Header.Text:SetText(text)
end

function KT:SetQuestsHeaderText(reset)
	if db.questsHeaderTitleAppend then
		local _, numQuests = GetNumQuestLogEntries()
		self:SetHeaderText(QUEST_TRACKER_MODULE, numQuests.."/"..MAX_QUESTLOG_QUESTS)
	elseif reset then
		self:SetHeaderText(QUEST_TRACKER_MODULE)
	end
end

function KT:SetAchievementsHeaderText(reset)
	if db.achievementsHeaderTitleAppend then
		self:SetHeaderText(ACHIEVEMENT_TRACKER_MODULE, GetTotalAchievementPoints())
	elseif reset then
		self:SetHeaderText(ACHIEVEMENT_TRACKER_MODULE)
	end
end

function KT:ToggleOtherButtons()
	if not db.headerOtherButtons then
		if KTF.QuestLogButton then
			KTF.QuestLogButton:Hide()
			KTF.AchievementsButton:Hide()
			OTFHeader.Title:SetWidth(OTFHeader.Title:GetWidth() + 40)
		end
		return
	end
	OTFHeader.Title:SetWidth(OTFHeader.Title:GetWidth() - 40)
	if KTF.QuestLogButton then
		KTF.QuestLogButton:Show()
		KTF.AchievementsButton:Show()
	else
		local button
		-- Achievements button
		button = CreateFrame("Button", addonName.."AchievementsButton", KTF)
		button:SetSize(16, 16)
		button:SetPoint("TOPRIGHT", (KTF.FilterButton or KTF.MinimizeButton), "TOPLEFT", -4, 0)
		button:SetFrameLevel(KTF:GetFrameLevel() + 10)
		button:SetNormalTexture(mediaPath.."UI-KT-HeaderButtons")
		button:GetNormalTexture():SetTexCoord(0.5, 1, 0.25, 0.5)
		button:RegisterForClicks("AnyDown")
		button:SetScript("OnClick", function(self, btn)
			ToggleAchievementFrame()
		end)
		button:SetScript("OnEnter", function(self)
			self:GetNormalTexture():SetVertexColor(1, 1, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:AddLine(AchievementMicroButton.tooltipText, 1, 1, 1)
			GameTooltip:Show()
		end)
		button:SetScript("OnLeave", function(self)
			self:GetNormalTexture():SetVertexColor(KT.headerBtnColor.r, KT.headerBtnColor.g, KT.headerBtnColor.b)
			GameTooltip:Hide()
		end)
		KTF.AchievementsButton = button

		-- Quest Log button
		button = CreateFrame("Button", addonName.."QuestLogButton", KTF)
		button:SetSize(16, 16)
		button:SetPoint("TOPRIGHT", KTF.AchievementsButton, "TOPLEFT", -4, 0)
		button:SetFrameLevel(KTF:GetFrameLevel() + 10)
		button:SetNormalTexture(mediaPath.."UI-KT-HeaderButtons")
		button:GetNormalTexture():SetTexCoord(0.5, 1, 0, 0.25)
		button:RegisterForClicks("AnyDown")
		button:SetScript("OnClick", function(self, btn)
			ToggleQuestLog()
		end)
		button:SetScript("OnEnter", function(self)
			self:GetNormalTexture():SetVertexColor(1, 1, 1)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:AddLine(QuestLogMicroButton.tooltipText, 1, 1, 1)
			GameTooltip:Show()
		end)
		button:SetScript("OnLeave", function(self)
			self:GetNormalTexture():SetVertexColor(KT.headerBtnColor.r, KT.headerBtnColor.g, KT.headerBtnColor.b)
			GameTooltip:Hide()
		end)
		KTF.QuestLogButton = button
	end
end

function KT:MoveButtons()
	if not InCombatLockdown() then
		local point, xOfs, yOfs
		if KTF.anchorLeft then
			point = "LEFT"
			xOfs = KTF:GetRight() and KTF:GetRight() + db.qiXOffset
		else
			point = "RIGHT"
			xOfs = KTF:GetLeft() and KTF:GetLeft() - db.qiXOffset
		end
		local hMod = 2 * (4 - db.bgrInset)
		local yMod = 0
		if not db.qiBgrBorder then
			hMod = hMod + 4
			yMod = 2 + (4 - db.bgrInset)
		end
		if KTF.directionUp and (db.maxHeight+hMod) < KTF.Buttons:GetHeight() then
			point = "BOTTOM"..point
			yOfs = KTF:GetBottom() and KTF:GetBottom() - yMod
		else
			point = "TOP"..point
			yOfs = KTF:GetTop() and KTF:GetTop() + yMod
		end
		if xOfs and yOfs then
			KTF.Buttons:ClearAllPoints()
			KTF.Buttons:SetPoint(point, UIParent, "BOTTOMLEFT", xOfs, yOfs)
		end
	end
end

function KT:RemoveFixedButton(block)
	if block then
		local tag = block.fixedTag
		if tag then
			tinsert(freeTags, tag)
			tag.text:SetText("")
			tag:Hide()
			block.fixedTag = nil
		end
		local questID = block.id
		local button = self:GetFixedButton(questID)
		if button then
			button:SetAlpha(0)
			if InCombatLockdown() then
				_DBG(" - STOP Remove button")
				combatLockdown = true
			else
				_DBG(" - REMOVE button "..questID)
				tinsert(freeButtons, button)
				self.fixedButtons[questID] = nil
				button:Hide()
				KTF.Buttons.reanchor = true
			end
		end
	else
		for questID, button in pairs(self.fixedButtons) do
			_DBG(" - REMOVE button "..questID)
			tinsert(freeButtons, button)
			self.fixedButtons[questID] = nil
			button:Hide()
		end
		KTF.Buttons.reanchor = true
	end
end

function KT:GetFixedButton(questID)
	if self.fixedButtons[questID] then
		return self.fixedButtons[questID]
	else
		return nil
	end
end

function KT:CreateQuestLevel(level)
	if level == -1 then
		level = "*"
	else
		level = tostring(level)
	end
	return format("[%s] ", level)
end

function KT:CreateQuestTag(questTag, frequency, suggestedGroup)
	local tagIcons = ""
	local texCoords
	if questTag then
		if questTag == Enum.QuestTag.Scenario then
			tagIcons = tagIcons.."S"
		elseif questTag == Enum.QuestTag.Legendary then
			tagIcons = tagIcons..self.CreateQuestTagIcon(nil, 7, 12, 2, 0, 0.055, 0.134, 0.28125, 0.5625)
		else
			texCoords = QuestUtils_GetQuestTagTextureCoords(questTag)
			if texCoords then
				tagIcons = tagIcons..self.CreateQuestTagIcon(nil, 12, 12, 0, 0, unpack(texCoords))
			end
		end
	end
	if frequency > 1 then  -- daily
		tagIcons = tagIcons..self.CreateQuestTagIcon(nil, 7, 12, 2, 0, 0.34, 0.425, 0, 0.28125)
		if frequency == 3 then  -- weekly
			tagIcons = tagIcons..self.CreateQuestTagIcon(nil, 7, 12, 0, 0, 0.34, 0.425, 0, 0.28125)
		end
	end
	if tagIcons ~= "" then
		tagIcons = format(" |cff00b3ff%s|r", tagIcons)
	end
	return tagIcons
end

function KT:IsTrackerEmpty(noaddon)
	local result = (KT_GetNumQuestWatches() == 0 and
		GetNumTrackedAchievements() == 0)
	return result
end

function KT:ToggleEmptyTracker(added)
	local alpha, mouse = 1, true
	if self:IsTrackerEmpty() then
		if not dbChar.collapsed then
			ObjectiveTracker_Collapse()
			self.forceExpand = (db.filterAuto[1] or db.filterAuto[2])
		end
		KTF.MinimizeButton:GetNormalTexture():SetTexCoord(0, 0.5, 0.5, 0.75)
		if db.hideEmptyTracker then
			alpha = 0
			mouse = false
		end
	else
		if dbChar.collapsed then
			if self.forceExpand or (db.expandTrackerAfterTrack and added) then
				ObjectiveTracker_Expand()
				self.forceExpand = false
			else
				KTF.MinimizeButton:GetNormalTexture():SetTexCoord(0, 0.5, 0, 0.25)
			end
		else
			KTF.MinimizeButton:GetNormalTexture():SetTexCoord(0, 0.5, 0.25, 0.5)
		end
	end
	KTF:SetAlpha(alpha)
	KTF.MinimizeButton:EnableMouse(mouse)
	if self.Filters:IsEnabled() then
		KTF.FilterButton:EnableMouse(mouse)
	end
	if db.headerOtherButtons then
		KTF.QuestLogButton:EnableMouse(mouse)
		KTF.AchievementsButton:EnableMouse(mouse)
	end
end

function KT:SetMessage(text, r, g, b, pattern, icon, x, y)
	if pattern then
		text = format(pattern, text.." ...")
	end
	if icon then
		x = x or 0
		y = y or 0
		if db.sink20OutputSink == "Blizzard" then
			x = floor(x * 3)
			y = y - 8
		end
		text = format("|T%s:0:0:%d:%d|t%s", icon, x, y, text)
	end
	self:Pour(text, r, g, b)
end

function KT:PlaySound(key)
	PlaySoundFile(LSM:Fetch("sound", key))
end

function KT:UpdateHotkey()
	local key = GetBindingKey("EXTRAACTIONBUTTON1")
	if db.keyBindMinimize == key then
		SetOverrideBinding(KTF, false, db.keyBindMinimize, nil)
		db.keyBindMinimize = ""
	end
end

function KT:MergeTables(source, target)
	if type(target) ~= "table" then target = {} end
	for k, v in pairs(source) do
		if type(v) == "table" then
			target[k] = self:MergeTables(v, target[k])
		elseif target[k] == nil then
			target[k] = v
		end
	end
	return target
end

StaticPopupDialogs[addonName.."_Info"] = {
	text = "|T"..mediaPath.."KT_logo:22:22:0:0|t"..NORMAL_FONT_COLOR_CODE..KT.title.."|r",
	subText = "...",
	button2 = CLOSE,
	OnShow = function(self)
		if self.text.text_arg1 then
			self.text:SetText(self.text:GetText().." - "..self.text.text_arg1)
		end
		self.SubText:SetFormattedText(self.text.text_arg2, unpack(self.data))
		self.SubText:SetTextColor(1, 1, 1)
	end,
	timeout = 0,
	whileDead = 1
}

StaticPopupDialogs[addonName.."_WowheadURL"] = {
	text = "|T"..mediaPath.."KT_logo:22:22:0:-1|t"..NORMAL_FONT_COLOR_CODE..KT.title.."|r - Wowhead URL",
	button2 = CLOSE,
	hasEditBox = 1,
	editBoxWidth = 300,
	EditBoxOnTextChanged = function(self)
		self:SetText(self.text)
		self:HighlightText()
	end,
	EditBoxOnEnterPressed = function(self)
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end,
	OnShow = function(self)
		local name = "..."
		if self.text.text_arg1 == "quest" then
			name = KT.QuestUtils_GetQuestName(self.text.text_arg2)
		elseif self.text.text_arg1 == "achievement" then
			name = select(2, GetAchievementInfo(self.text.text_arg2))
		end
		local lang = KT.locale:sub(1, 2)
		if lang == "en" then
			lang = ""
		else
			if lang == "zh" then lang = "cn" end
			lang = lang.."/"
		end
		self.text:SetText(self.text:GetText().."\n|cffff7f00"..name.."|r")
		self.editBox.text = "https://www.wowhead.com/wotlk/"..lang..self.text.text_arg1.."="..self.text.text_arg2
		self.editBox:SetText(self.editBox.text)
		self.editBox:SetFocus()
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}

function KT:ShowPopup(type, id)
	StaticPopup_Show(addonName.."_WowheadURL", type, id)
end

-- Load ----------------------------------------------------------------------------------------------------------------

function KT:OnInitialize()
	_DBG("|cffffff00Init|r - "..self:GetName(), true)

	SLASH_KALIELSTRACKER1, SLASH_KALIELSTRACKER2 = "/kt", "/kalielstracker"
	SlashCmdList["KALIELSTRACKER"] = SlashHandler

	SetMsgPatterns()

	-- Get character data
	self.playerName = UnitName("player")
	self.playerFaction = UnitFactionGroup("player")
	self.playerLevel = UnitLevel("player")
	local class
	self.playerClass, class = UnitClass("player")
	self.classColor = RAID_CLASS_COLORS[class]

	self.headers = {}
	self.borderColor = {}
	self.headerBtnColor = {}
	self.fixedButtons = {}
	self.inWorld = false
	self.inInstance = IsInInstance()
	self.stopUpdate = true
	self.questStateStopUpdate = false
	self.forceExpand = false
	self.initialized = false

	-- Setup Options
	self:SetupOptions()
	db = self.db.profile
	dbChar = self.db.char
	ResetIncompatibleProfiles("3.1.0")
	ResetIncompatibleData("3.1.0")

	-- Blizzard frame resets
	WatchFrame:Hide()
	WatchFrame.Show = function() end
	OTF.IsUserPlaced = function() return true end
	OTF.KTSetParent = OTF.SetParent
	OTF.SetParent = function() end
	OTF.SetFrameStrata = function() end
	OTF.SetFrameLevel = function() end
	OTF:SetClampedToScreen(false)
	OTF.SetClampedToScreen = function() end
	OTF:EnableMouse(false)
	OTF.EnableMouse = function() end
	OTF:SetMovable(false)
	OTF.SetMovable = function() end
	OTF:ClearAllPoints()
	OTF.ClearAllPoints = function() end
	OTF.SetAllPoints = function() end
	OTF.KTSetPoint = OTF.SetPoint
	OTF.SetPoint = function() end
	OTF:Show()
	OTF.Show = function() end
	OTF.Hide = function() end
	OTF.SetShown = function() end
end

function KT:OnEnable()
	_DBG("|cff00ff00Enable|r - "..self:GetName(), true)
	local resolution = GetCVar("gxFullscreenResolution")
	local windowed = Display_DisplayModeDropDown:windowedmode()
	if not windowed then
		if resolution == "auto" then
			resolution = select(1, GetScreenResolutions())
		end
	else
		resolution = GetCVar("gxWindowedResolution")
	end
	self.screenWidth, self.screenHeight = string.match(resolution, "(%d+)x(%d+)")
	self.screenWidth = tonumber(self.screenWidth)
	self.screenHeight = tonumber(self.screenHeight)

	SetFrames()
	SetHooks()

	self.QuestLog:Enable()
	self.Filters:Enable()
	if self.AddonQuestie.isLoaded then self.AddonQuestie:Enable() end
	self.AddonOthers:Enable()
	self.Help:Enable()

	if self.db.global.version ~= self.version then
		self.db.global.version = self.version
	end

	KT_SanitizeQuestList()
end
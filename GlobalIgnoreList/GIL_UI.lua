---------------------------------------
-- GLOBAL IGNORE LIST USER INTERFACE --
---------------------------------------

-- first : X... - is move left
-- second: Y... - is move down

local addonName, addon 	= ...
local L = addon.L -- localization entries
local V = addon.V -- shared variables
local M = addon.M -- shared methods

V.needSorted					= true
V.nameUI							= ""

local MainFrame				= nil
local Tab1Frame				= nil
local Tab2Frame				= nil
local Tab2FrameState		= 0
local Tab2FrameEdit			= nil
local Tab2FrameBlock		= nil
local Tab2EditDesc			= ""
local Tab2EditFilter		= ""
local Tab2EditActive		= false
local Tab2BlockFilter		= 0
local Tab3Frame				= nil
local columnCount			= 0
local IgnoreScrollFrame		= nil
local IgnoreScrollButtons	= {}
local IgnoreScrollIndex		= {}
local IgnoreScrollType		= 0
local IgnoreScrollSelect	= 0
local FilterScrollFrame		= nil
local FilterScrollButtons	= {}
local FilterScrollSelect	= 0
local BlockScrollPlayer		= {}
local BlockScrollText		= {}
local BlockScrollDate		= {}
local WINDOW_WIDTH			= 734
local WINDOW_HEIGHT			= 400
local WINDOW_OFFSET			= 113
local BUTTON_HEIGHT			= 20
local BUTTON_TOTAL			= math.floor((WINDOW_HEIGHT - WINDOW_OFFSET) / BUTTON_HEIGHT)
local BUTTON_WIDTH			= WINDOW_WIDTH - 44
local COL_NAME				= 130
local COL_SERVER			= 150
local COL_TYPE				= 60
local COL_LISTED			= 53
local COL_EXPIRE			= 56
local COL_NOTES				= 241
local COL_DESC				= 210
local COL_STATE				= 26
local COL_FILTER			= 368
local COL_BLOCKED			= 52
local COL_INFOTEXT			= 400

-------------------------
-- DIALOGS AND BUTTONS --
-------------------------

StaticPopupDialogs["GIL_REASON"] = {

	preferredIndex = STATICPOPUPS_NUMDIALOGS,
	text           = "Edit ignore note for |cffffff00%s:",
	maxLetters     = 128,
	hasEditBox	   = 1,
	whileDead      = 1,
	button1        = L["BOX_3"],
	button2        = L["BOX_5"],
  
	OnShow = function(self)
		self.EditBox:SetText(GlobalIgnoreDB.notes[M.hasAnyIgnored(V.nameUI)])
		self.EditBox:SetFocus()
	end,
	OnAccept = function(self)
		GlobalIgnoreDB.notes[M.hasAnyIgnored(V.nameUI)] = self.EditBox:GetText()
		M.GILUpdateUI()
	end,
	EditBoxOnEnterPressed = function(self)
		GlobalIgnoreDB.notes[M.hasAnyIgnored(V.nameUI)] = self:GetParent().EditBox:GetText()
		self:GetParent():Hide()
		M.GILUpdateUI()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end
}

local function setExpire (text)
	if tonumber(text) then
		GlobalIgnoreDB.expList[M.hasAnyIgnored(V.nameUI)] = tonumber(text)
		M.GILUpdateUI()
	end	
end

StaticPopupDialogs["GIL_CONFIRMPRUNE"] = {
	preferredIndex = STATICPOPUPS_NUMDIALOGS,
	text           = "|cffffff00"..L["BOX_12"].."|cffffffff\n\n"..L["BOX_13"],
	whileDead      = 1,
	button1        = L["BOX_6"],
	button2        = L["BOX_5"],
  
	OnAccept = function(self, data)
		M.PruneIgnoreList(data, true);
	end,
	EditBoxOnEnterPressed = function(self, data)
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self, data)
		self:GetParent():Hide()
	end
}

StaticPopupDialogs["GIL_PRUNE"] = {
	preferredIndex = STATICPOPUPS_NUMDIALOGS,
	text           = "|cffffff00%s|cffffffff\n\n"..L["BOX_11"],
	maxLetters     = 4,
	hasEditBox	   = 1,
	whileDead      = 1,
	button1        = L["BOX_6"],
	button2        = L["BOX_5"],
  
	OnShow = function(self)
		self.EditBox:SetText("365")
		self.EditBox:SetFocus()
	end,
	OnAccept = function(self)
		local d = nil
		d = tonumber(self.EditBox:GetText());
		if (d and d > 0) then
			local c = M.PruneIgnoreList(d, false);
			local f = StaticPopup_Show("GIL_CONFIRMPRUNE", c);
			f.data = d;
		end		
	end,
	EditBoxOnEnterPressed = function(self)
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end
}

StaticPopupDialogs["GIL_EXPIRE"] = {

	preferredIndex = STATICPOPUPS_NUMDIALOGS,
	text           = "|cffffff00%s|cffffffff\n\n"..L["BOX_1"],
	maxLetters     = 4,
	hasEditBox	   = 1,
	whileDead      = 1,
	button1        = L["BOX_3"],
	button2        = L["BOX_5"],
  
	OnShow         = function(self)
		self.EditBox:SetText(GlobalIgnoreDB.expList[M.hasAnyIgnored(V.nameUI)])
		self.EditBox:SetFocus()
	end,
	OnAccept       = function(self)
		setExpire(self.EditBox:GetText())
	end,
	EditBoxOnEnterPressed = function(self)
		setExpire(self:GetParent().EditBox:GetText())
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end
}

StaticPopupDialogs["GIL_FILTERRESET"] = {

	preferredIndex = STATICPOPUPS_NUMDIALOGS,
	text           = "|cffffff00%s|cffffffff\n\n"..L["BOX_2"],
	whileDead      = 1,
	button1        = L["BOX_4"],
	button2        = L["BOX_5"],
	OnAccept       = function(self)
		M.ResetSpamFilters()
		M.FilterListDrawUpdate(FilterScrollFrame)
	end,	
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end
}

StaticPopupDialogs["GIL_FILTERREMOVE"] = {

	preferredIndex = STATICPOPUPS_NUMDIALOGS,
	text           = "|cffffff00%s|cffffffff\n\n"..L["BOX_9"],
	whileDead      = 1,
	button1        = L["BOX_10"],
	button2        = L["BOX_5"],
	OnAccept       = function(self)
		if FilterScrollSelect <= 0 then
			return
		end
		
		M.RemoveChatFilter(FilterScrollSelect)
		M.FilterListDrawUpdate(FilterScrollFrame)
	end,	
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end
}

local function ButtonFilterRemove()

	if FilterScrollSelect <= 0 then
		return
	end
	
	StaticPopup_Show("GIL_FILTERREMOVE", L["BOX_10"])
end

local function ButtonIgnoreRemove()
	
	if IgnoreScrollSelect <= 0 then
		return
	end
	
	local idx     = IgnoreScrollIndex[IgnoreScrollSelect]
	local typeStr = GlobalIgnoreDB.typeList[idx]

	V.needSorted = true

	--print("DEBUG ButtonIgnoreRemove")
	
	if typeStr == "player" then
		C_FriendList.DelIgnore(idx, true)
	elseif typeStr == "npc" then
		M.AddOrDelNPC(idx)
		M.GILUpdateUI()
	elseif typeStr == "server" then
		M.AddOrDelServer(idx)
		M.GILUpdateUI()
	end
end

--------------------------
-- CHAT FILTER SCROLLER --
--------------------------

function M.FilterScrollChangeState (state)
	-- -1 = Refresh currrent  0 = Base  1 = Edit  2 = Block
	
	if (state ~= -1) then
		Tab2FrameState = state
	end

	if Tab2FrameState == 0 then
		Tab2Frame:Show()
		Tab2FrameBlock:Hide()
		Tab2FrameEdit:Hide()
	elseif Tab2FrameState == 1 then
		Tab2Frame:Hide()
		Tab2FrameEdit:Show()	
		Tab2FrameBlock:Hide()
	elseif Tab2FrameState == 2 then
		Tab2Frame:Hide()
		Tab2FrameEdit:Hide()	
		Tab2FrameBlock:Show()
	end
end

function M.FilterListDrawUpdate (self)

	FauxScrollFrame_Update(self, #GlobalIgnoreDB.filterList, BUTTON_TOTAL, BUTTON_HEIGHT)
	
	if FilterScrollSelect > #GlobalIgnoreDB.filterList then
		FilterScrollSelect = #GlobalIgnoreDB.filterList
	end
	
	Tab2Frame.infotext:SetText(format(L["INFO_2"], GlobalIgnoreDB.filterTotal))
	
	local offset = FauxScrollFrame_GetOffset(self)
	local index  = 0
	local pName = ""
	for count = 1, BUTTON_TOTAL do
		index = count + offset
				
		if GlobalIgnoreDB.filterList[index] then
			pName = GlobalIgnoreDB.filterDesc[index]
			
			FilterScrollButtons[count].name:SetText(GlobalIgnoreDB.filterDesc[index])
			FilterScrollButtons[count].filter:SetText(GlobalIgnoreDB.filterList[index])
			
			if GlobalIgnoreDB.filterActive[index] == true then
				FilterScrollButtons[count].state:SetText("|cff33ff99" .. L["ON"]);			
			else
				FilterScrollButtons[count].state:SetText("|cffe60000" .. L["OFF"]);
			end
			
			FilterScrollButtons[count].blocked:SetText(GlobalIgnoreDB.filterCount[index])
			
			FilterScrollButtons[count]:SetID(index)
			
			if FilterScrollSelect == index then
				FilterScrollButtons[count]:LockHighlight()
			else
				FilterScrollButtons[count]:UnlockHighlight()
			end
		
			FilterScrollButtons[count]:Show()
		else
			FilterScrollButtons[count]:Hide()
		end
	end
end

local function CreateFilterButtons()

	FilterScrollButtons = {}
	
	for count = 1, BUTTON_TOTAL do
	
		if V.wowIsClassic == true then
			FilterScrollButtons[count] = CreateFrame("Button", nil, FilterScrollFrame:GetParent(), "FriendsFrameIgnoreButtonTemplate")
		else
			FilterScrollButtons[count] = CreateFrame("Button", nil, FilterScrollFrame:GetParent(), "IgnoreListButtonTemplate")
		end
	
		if count == 1 then
			FilterScrollButtons[count]:SetPoint("TOPLEFT", FilterScrollFrame, -1, 0)
		else
			FilterScrollButtons[count]:SetPoint("TOP", FilterScrollButtons[count - 1], "BOTTOM")
		end

		FilterScrollButtons[count]:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)
		FilterScrollButtons[count]:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		FilterScrollButtons[count]:SetScript("OnClick", M.FilterScrollClick)

		-- set name style
		FilterScrollButtons[count].name:SetWidth(COL_DESC)		

		-- set active style
		FilterScrollButtons[count].state = FilterScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		FilterScrollButtons[count].state:SetPoint("LEFT", FilterScrollButtons[count].name, "RIGHT", 10, 0)
		FilterScrollButtons[count].state:SetWidth(COL_STATE)
		FilterScrollButtons[count].state:SetJustifyH("LEFT")

		-- create blocked style
		FilterScrollButtons[count].blocked = FilterScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		FilterScrollButtons[count].blocked:SetPoint("LEFT", FilterScrollButtons[count].state, "RIGHT", 6, 0)
		FilterScrollButtons[count].blocked:SetWidth(COL_BLOCKED)
		FilterScrollButtons[count].blocked:SetJustifyH("RIGHT")
		FilterScrollButtons[count].blocked:SetWordWrap(false)
		
		-- create filter style
		FilterScrollButtons[count].filter = FilterScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		FilterScrollButtons[count].filter:SetPoint("LEFT", FilterScrollButtons[count].blocked, "RIGHT", 14, 0)
		FilterScrollButtons[count].filter:SetWidth(COL_FILTER)
		FilterScrollButtons[count].filter:SetJustifyH("LEFT")
		FilterScrollButtons[count].filter:SetWordWrap(false)
	end
	
	M.FilterListDrawUpdate(FilterScrollFrame)
end

local function RemoveBlockEntry (filterNum, entry)
	-- adjust "latest" if the removal would shift it
	local filterBlockedLast = GlobalIgnoreDB.filterBlockedLast[filterNum]
	
	if entry <= filterBlockedLast then
		GlobalIgnoreDB.filterBlockedLast[filterNum] = filterBlockedLast - 1
	end
	
	table.remove(GlobalIgnoreDB.filterBlocked[filterNum], entry)
	
	M.GILUpdateBlockHistory(filterNum)
end

local function RemoveBlockEntriesByPlayer (filterNum, name)

	if GlobalIgnoreDB.filterBlocked[filterNum] then
		for index = #GlobalIgnoreDB.filterBlocked[filterNum], 1, -1 do
			if GlobalIgnoreDB.filterBlocked[filterNum][index].s == name then
				-- adjust "latest" if the removal would shift it
				local filterBlockedLast = GlobalIgnoreDB.filterBlockedLast[filterNum]
				if index <= filterBlockedLast then
					GlobalIgnoreDB.filterBlockedLast[filterNum] = filterBlockedLast - 1
				end
				
				table.remove(GlobalIgnoreDB.filterBlocked[filterNum], index)
			end
		end
	end
	
	M.GILUpdateBlockHistory(filterNum)
end

local function UpdateBlockButton(idx, count, winSize)
	-- Fields: m=message, s=source, t=timestamp, c=channelnum, n=channelname, i=filternum
	local text		= GlobalIgnoreDB.filterBlocked[Tab2BlockFilter][count].m
	local player	= GlobalIgnoreDB.filterBlocked[Tab2BlockFilter][count].s
	local tstamp	= GlobalIgnoreDB.filterBlocked[Tab2BlockFilter][count].t
	local channel	= GlobalIgnoreDB.filterBlocked[Tab2BlockFilter][count].n

	if not BlockScrollPlayer[idx] then
		BlockScrollPlayer[idx] = Tab2FrameBlock.Slate:CreateFontString("FontString", "OVERLAY", "GameFontNormal")
	end
	
	BlockScrollPlayer[idx]:Show()
	BlockScrollPlayer[idx]:SetWidth(200)
	BlockScrollPlayer[idx]:SetJustifyH("LEFT");
	BlockScrollPlayer[idx]:SetText(player)
	BlockScrollPlayer[idx]:SetScript("OnMouseUp", function(self,button)
		if button == "RightButton" then
			M.BlockScrollPlayerClick(self, button, count)
		end
	end)

	if not BlockScrollText[idx] then
		BlockScrollText[idx] = Tab2FrameBlock.Slate:CreateFontString("FontString", "OVERLAY", "GameFontNormal")
	end
	
	BlockScrollText[idx]:Show()
	BlockScrollText[idx]:SetPoint("TOPLEFT", BlockScrollPlayer[idx], "TOPRIGHT", 0, 0)
	BlockScrollText[idx]:SetWidth(482)
	BlockScrollText[idx]:SetJustifyH("LEFT");
	BlockScrollText[idx]:SetText("|cFFFFC0C0" .. text)
	BlockScrollText[idx]:SetFont(DEFAULT_CHAT_FRAME:GetFont(), 14)
	BlockScrollText[idx].tooltip = {t=tstamp,c=channel}
	BlockScrollText[idx]:SetScript("OnEnter", M.BlockScrollTextOnEnter)
	BlockScrollText[idx]:SetScript("OnLeave", M.BlockScrollTextOnLeave)
	BlockScrollText[idx]:SetScript("OnHide", M.BlockScrollTextOnLeave)
	BlockScrollText[idx]:SetScript("OnMouseUp",
		function(self,button)
			if button == "RightButton" then
				M.BlockScrollPlayerClick(BlockScrollPlayer[idx], button, count)
			end
		end
	)

	if idx == 1 then
		BlockScrollPlayer[idx]:SetPoint("TOPLEFT", Tab2FrameBlock.Slate, "TOPLEFT", 10, -10)
	else
		BlockScrollPlayer[idx]:SetPoint("TOPLEFT", BlockScrollText[idx - 1], "BOTTOMLEFT", -200, -10)
	end

	local oneSize = math.max(BlockScrollText[idx]:GetStringHeight(), BlockScrollPlayer[idx]:GetStringHeight())
	winSize = winSize + oneSize + 10

	return winSize
end

function M.UpdateBlockButtons()
	local winSize, total, last = 0, 0

	for count = 1, #BlockScrollPlayer do
		BlockScrollPlayer[count]:SetText("")
		BlockScrollText[count]:SetText("")		
		BlockScrollText[count].tooltip = nil
		BlockScrollPlayer[count]:Hide()
		BlockScrollText[count]:Hide()
	end

	if GlobalIgnoreDB.filterBlocked[Tab2BlockFilter] then
		total		= #GlobalIgnoreDB.filterBlocked[Tab2BlockFilter]
		last		= GlobalIgnoreDB.filterBlockedLast[Tab2BlockFilter]
		local idx	= 0
		
		for count = last, 1, -1 do
			idx = idx + 1
			winSize = UpdateBlockButton(idx, count, winSize)
		end
		
		if total > last then
			for count = total, last+1, -1 do
				idx = idx + 1
				winSize = UpdateBlockButton(idx, count, winSize)
			end
		end
	end
	if Tab2BlockFilter and Tab2BlockFilter > 0 then
		Tab2FrameBlock.InfoText:SetText("Block history for |cffffff00" .. GlobalIgnoreDB.filterDesc[Tab2BlockFilter] .. "|cffffffff (" .. total .. ")")
	end
	Tab2FrameBlock.Slate:SetSize(Tab2FrameBlock:GetWidth(), winSize + 10);
end


function M.BlockScrollTextOnEnter (self)
	if self.tooltip then
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:AddDoubleLine(L["COL_12"],L["TIP_3"])
		GameTooltip:AddDoubleLine(self.tooltip.t, self.tooltip.c, 220/255, 220/255, 220/255, 153/255, 153/255, 102/255)
		GameTooltip:Show()
	end
end


function M.BlockScrollTextOnLeave (self)
	if GameTooltip:GetOwner() == self then
		GameTooltip_Hide()
	end
end

function M.BlockScrollPlayerClick(self, button, entry)
	local name = self:GetText()
	name = M.Proper(M.addServer(name))
	if not (name and #name>=2) then return end
	local index = M.hasGlobalIgnored(name)
	local isIgnored = index and index > 0
	MenuUtil.CreateContextMenu(UIParent, function(ownerRegion, root)
		root:CreateTitle(name)
		root:CreateDivider()
		if isIgnored then
			root:CreateButton(L["RCM_4"],
				function()
					C_FriendList.DelIgnore(name)
				end)
		else
			root:CreateButton(L["RCM_6"],
				function()
					C_FriendList.AddOrDelIgnore(name)
				end)
		end
		
		--root:CreateDivider()
		--root:CreateButton("Remove Entry", -- TODO: localization
		--	function()
		--		if GlobalIgnoreDB.filterBlocked[Tab2BlockFilter] and GlobalIgnoreDB.filterBlocked[Tab2BlockFilter][entry] then
		--			RemoveBlockEntry(Tab2BlockFilter, entry)
	 	--		end
		--	end)
		--root:CreateButton("Remove All Entries by Player", -- TODO localization
		--	function()
		--		RemoveBlockEntriesByPlayer(Tab2BlockFilter, name)
		--	end)
		
		root:CreateDivider()
		root:CreateButton(L["RCM_15"],
			function()
				GlobalIgnoreDB.filterBlocked[Tab2BlockFilter] = {}
				GlobalIgnoreDB.filterBlockedLast[Tab2BlockFilter] = 0
				M.GILUpdateBlockHistory(Tab2BlockFilter)
			end)
		root:CreateDivider()
		root:CreateButton(L["RCM_11"],
			function()
				FilterScrollSelect = Tab2BlockFilter
				M.FilterScrollEditMenu()
			end)
		root:CreateDivider()
		root:CreateButton(L["RCM_5"],
			function()
			end)
	end)
end

function M.FilterScrollBlockHistory()
	if GlobalIgnoreDB.filterDesc[FilterScrollSelect] ~= nil then
		Tab2BlockFilter = FilterScrollSelect
		M.FilterScrollChangeState(2)
	else
		if GlobalIgnoreDB.filterDesc[1] ~= nil then
			Tab2BlockFilter = 1
			M.FilterScrollChangeState(2)
		end
	end
end

function M.FilterScrollEditMenu()
	if GlobalIgnoreDB.filterDesc[FilterScrollSelect] ~= nil then
	
		Tab2EditDesc   = GlobalIgnoreDB.filterDesc[FilterScrollSelect]
		Tab2EditFilter = GlobalIgnoreDB.filterList[FilterScrollSelect]
		Tab2EditActive = GlobalIgnoreDB.filterActive[FilterScrollSelect]

		M.FilterScrollChangeState(1)
	end
end

function M.FilterScrollClick(self, button, down)

	if down == true then return end
	
	if FilterScrollSelect == self:GetID() and button == "LeftButton" then
		M.FilterScrollEditMenu()
		return
	elseif FilterScrollSelect ~= self:GetID() then
		FilterScrollSelect = self:GetID()
		M.FilterListDrawUpdate(FilterScrollFrame)
	end
	
	if button == "RightButton" then	
		MenuUtil.CreateContextMenu(UIParent,
			function(ownerRegion, root)
				root:CreateTitle(L["RCM_10"])
				root:CreateDivider()
				root:CreateButton(L["RCM_11"],
					function()
						M.FilterScrollEditMenu()
					end
				)
				root:CreateButton(L["RCM_12"],
					function()
						ButtonFilterRemove()
					end
				)
				root:CreateDivider()				
				root:CreateButton(L["RCM_13"] .. " (" .. #GlobalIgnoreDB.filterBlocked[FilterScrollSelect] .. ")",
					function()
						M.FilterScrollBlockHistory()
					end
				)
				root:CreateDivider()	
				root:CreateButton(L["RCM_14"],
					function()
						GlobalIgnoreDB.filterCount[FilterScrollSelect] = 0
						M.GILUpdateChatCount()
					end
				)
				root:CreateButton(L["RCM_15"],
					function()
						GlobalIgnoreDB.filterBlocked[FilterScrollSelect] = {}
						GlobalIgnoreDB.filterBlockedLast[FilterScrollSelect] = 0
					end
				)				
				root:CreateDivider()			
				root:CreateButton(L["RCM_5"],
					function()
					end)
			end
		)
	end
end

--------------------------
-- IGNORE LIST SCROLLER --
--------------------------

local function IgnoreListDrawUpdate (self)

	FauxScrollFrame_Update(self, #GlobalIgnoreDB.ignoreList, BUTTON_TOTAL, BUTTON_HEIGHT)
	
	if IgnoreScrollSelect > #GlobalIgnoreDB.ignoreList then
		IgnoreScrollSelect = #GlobalIgnoreDB.ignoreList
	end
	
	Tab1Frame.infotext:SetText(format(L["INFO_1"], #GlobalIgnoreDB.ignoreList))
	
	local offset  = FauxScrollFrame_GetOffset(self)
	local index   = 0
	local id      = 0
	local pName   = ""
	local pServer = ""
	local pType   = ""
	local pExpire = ""
	local temp    = 0
	
	for count = 1, BUTTON_TOTAL do
		id = count + offset
		
		if GlobalIgnoreDB.ignoreList[id] then
			index = IgnoreScrollIndex[id] or id
			pName = GlobalIgnoreDB.ignoreList[index]
			temp  = string.find(pName, "-", 1, true)
			
			if temp then
				pServer = M.prettyServer(string.sub(pName, temp + 1, string.len(pName)))
				pName   = string.sub(pName, 1, temp - 1)
			else
				pServer = "All"
			end
			
			if GlobalIgnoreDB.typeList[index] == "player" then
				if GlobalIgnoreDB.factionList[index] == "Alliance" then
					pType = "|cff335effAlliance"
				elseif GlobalIgnoreDB.factionList[index] == "Horde" then
					pType = "|cffe60000Horde"
				else
					pType = "Unknown"
				end				  
			elseif GlobalIgnoreDB.typeList[index] == "npc" then
				pType = "|cffffff99NPC"
			else
				pType = "|cffff66ccServer"
				pServer = M.prettyServer(pName)
				pName = "All"				
			end	
			
			local playerExp = (GlobalIgnoreDB.expList[index] or 0)
			local daysExp   = playerExp - M.daysFromToday(GlobalIgnoreDB.dateList[index])

			if playerExp == 0 then
				pExpire = "|cff808080"..L["EXP_NVR"]
			elseif daysExp <= 0 then
				pExpire = "|cffff6666"..L["EXP_TDY"]
			else
				pExpire = daysExp.."d"
			end

			IgnoreScrollButtons[count].name:SetText(pName)
			IgnoreScrollButtons[count].server:SetText(pServer)
			IgnoreScrollButtons[count].type:SetText(pType)
			IgnoreScrollButtons[count].listed:SetText(M.daysFromToday(GlobalIgnoreDB.dateList[index]) .. "d")
			IgnoreScrollButtons[count].expire:SetText(pExpire)
			IgnoreScrollButtons[count].note:SetText("|cff69CCF0"..GlobalIgnoreDB.notes[index])
			
			IgnoreScrollButtons[count]:SetID(id)
			
			if IgnoreScrollSelect == id then
				IgnoreScrollButtons[count]:LockHighlight()
			else
				IgnoreScrollButtons[count]:UnlockHighlight()
			end
		
			IgnoreScrollButtons[count]:Show()
		else
			IgnoreScrollButtons[count]:Hide()
		end
	end
end

local function CreateIgnoreButtons()

	IgnoreScrollButtons = {}
	
	for count = 1, BUTTON_TOTAL do
	
		if V.wowIsClassic == true then
			IgnoreScrollButtons[count] = CreateFrame("Button", nil, IgnoreScrollFrame:GetParent(), "FriendsFrameIgnoreButtonTemplate")
		else
			IgnoreScrollButtons[count] = CreateFrame("Button", nil, IgnoreScrollFrame:GetParent(), "IgnoreListButtonTemplate")
		end
	
		if count == 1 then
			IgnoreScrollButtons[count]:SetPoint("TOPLEFT", IgnoreScrollFrame, -1, 0)
		else
			IgnoreScrollButtons[count]:SetPoint("TOP", IgnoreScrollButtons[count - 1], "BOTTOM")
		end

		IgnoreScrollButtons[count]:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)
		IgnoreScrollButtons[count]:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		IgnoreScrollButtons[count]:SetScript("OnClick", M.IgnoreScrollClick)

		-- set name style
		IgnoreScrollButtons[count].name:SetWidth(COL_NAME)

		-- create server style		
		IgnoreScrollButtons[count].server = IgnoreScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		IgnoreScrollButtons[count].server:SetPoint("LEFT", IgnoreScrollButtons[count].name, "RIGHT", 0, 0)
		IgnoreScrollButtons[count].server:SetWidth(COL_SERVER)
		IgnoreScrollButtons[count].server:SetJustifyH("LEFT")
		
		-- create type style
		IgnoreScrollButtons[count].type = IgnoreScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		IgnoreScrollButtons[count].type:SetPoint("LEFT", IgnoreScrollButtons[count].server, "RIGHT", 0, 0)
		IgnoreScrollButtons[count].type:SetWidth(COL_TYPE)
		IgnoreScrollButtons[count].type:SetJustifyH("LEFT")
		
		-- create listed style
		IgnoreScrollButtons[count].listed = IgnoreScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		IgnoreScrollButtons[count].listed:SetPoint("LEFT", IgnoreScrollButtons[count].type, "RIGHT", -17, 0)
		IgnoreScrollButtons[count].listed:SetWidth(COL_LISTED)
		IgnoreScrollButtons[count].listed:SetJustifyH("RIGHT")
		
		-- create expire style
		IgnoreScrollButtons[count].expire = IgnoreScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		IgnoreScrollButtons[count].expire:SetPoint("LEFT", IgnoreScrollButtons[count].listed, "RIGHT", 3, 0)
		IgnoreScrollButtons[count].expire:SetWidth(COL_EXPIRE)
		IgnoreScrollButtons[count].expire:SetJustifyH("RIGHT")
		
		-- create note style
		IgnoreScrollButtons[count].note = IgnoreScrollButtons[count]:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
		IgnoreScrollButtons[count].note:SetPoint("LEFT", IgnoreScrollButtons[count].expire, "RIGHT", 13, 0)
		IgnoreScrollButtons[count].note:SetWidth(COL_NOTES)
		IgnoreScrollButtons[count].note:SetJustifyH("LEFT")
		IgnoreScrollButtons[count].note:SetWordWrap(false)
	end
	
	IgnoreListDrawUpdate(IgnoreScrollFrame)
end

function M.IgnoreScrollDoubleClick()
	V.nameUI = GlobalIgnoreDB.ignoreList[IgnoreScrollIndex[IgnoreScrollSelect]]
	StaticPopup_Show("GIL_REASON", V.nameUI)
end

function M.IgnoreScrollClick(self, button, down)

	if down == true then return end
	
	if IgnoreScrollSelect == self:GetID() and button == "LeftButton" then
		M.IgnoreScrollDoubleClick()
		return
	elseif IgnoreScrollSelect ~= self:GetID() then
		IgnoreScrollSelect = self:GetID()
		IgnoreListDrawUpdate(IgnoreScrollFrame)
	end
	
	if button == "RightButton" then	
		V.nameUI = GlobalIgnoreDB.ignoreList[IgnoreScrollIndex[IgnoreScrollSelect]]
		
		MenuUtil.CreateContextMenu(UIParent, function(ownerRegion, root)
			root:CreateTitle(V.nameUI)
			root:CreateDivider()
			root:CreateButton(L["RCM_1"],
				function()
					M.IgnoreScrollDoubleClick()
				end)
			root:CreateDivider()
			root:CreateButton(L["RCM_2"],
				function()
					StaticPopup_Show("GIL_EXPIRE", V.nameUI)
				end)
			root:CreateButton(L["RCM_3"],
				function()
					GlobalIgnoreDB.expList[IgnoreScrollIndex[IgnoreScrollSelect]] = 0
					M.GILUpdateUI()
				end)
			root:CreateDivider()
			root:CreateButton(L["RCM_4"],
				function()
					ButtonIgnoreRemove()
				end)
			root:CreateDivider()
			root:CreateButton(L["RCM_5"],
				function()					
				end)			
		end)
	end
end

------------------------------
-- COLUMN SORTING FUNCTIONS --
------------------------------

local function elementName (num)

	local type = GlobalIgnoreDB.typeList[num]
	
	if type == "player" or type == "npc" then
		return M.removeServer(GlobalIgnoreDB.ignoreList[num], true)
	elseif type == "server" then
		return "All"
	else
		return ""
	end
end

local function elementServer (num)

	local type = GlobalIgnoreDB.typeList[num]

	if type == "player" then
		return M.getServer(GlobalIgnoreDB.ignoreList[num])
	elseif type == "server" then
		return GlobalIgnoreDB.ignoreList[num]
	elseif type == "npc" then
		return "All"
	else
		return ""
	end
end

local function elementType(num)

	local type = GlobalIgnoreDB.typeList[num]
	
	if type == "player" then
		return GlobalIgnoreDB.factionList[num]
	else
		return type
	end
end

local function createSortedIndex (sortType)

	V.needSorted			= false
	IgnoreScrollIndex	= {}
	IgnoreScrollType	= sortType
	
	for count = 1, #GlobalIgnoreDB.ignoreList do
		IgnoreScrollIndex[count] = count
	end
	
	-- should I make one of these for each sortType for performance reasons?
	table.sort(IgnoreScrollIndex,
		function (a,b)		
			if sortType == 1 then 
				-- sort by name column only
				return GlobalIgnoreDB.ignoreList[a] < GlobalIgnoreDB.ignoreList[b]
			elseif sortType == 2 then
				return GlobalIgnoreDB.ignoreList[a] > GlobalIgnoreDB.ignoreList[b]
			elseif sortType == 3 then
				local SA = elementServer(a)
				local SB = elementServer(b)
							
				if SA < SB then
					return true
				elseif SA > SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			elseif sortType == 4 then
				local SA = elementServer(a)
				local SB = elementServer(b)
							
				if SA > SB then
					return true
				elseif SA < SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			elseif sortType == 5 then
				local SA = elementType(a)
				local SB = elementType(b)

				if SA < SB then
					return true
				elseif SA > SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end				
			elseif sortType == 6 then
				local SA = elementType(a)
				local SB = elementType(b)

				if SA > SB then
					return true
				elseif SA < SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			elseif sortType == 7 then
				local SA = M.daysFromToday(GlobalIgnoreDB.dateList[a])
				local SB = M.daysFromToday(GlobalIgnoreDB.dateList[b])
				
				if SA < SB then
					return true
				elseif SA > SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			elseif sortType == 8 then
				local SA = M.daysFromToday(GlobalIgnoreDB.dateList[a])
				local SB = M.daysFromToday(GlobalIgnoreDB.dateList[b])

				if SA > SB then
					return true
				elseif SA < SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
				
			elseif sortType == 9 then
				local SA = GlobalIgnoreDB.expList[a]
				local SB = GlobalIgnoreDB.expList[b]

				if not SA or SA == 0 then
					SA = 100000
				else
					SA = SA - M.daysFromToday(GlobalIgnoreDB.dateList[a])
					if SA < 1 then SA = -1 end
				end
					
				if not SB or SB == 0 then
					SB = 100000
				else
					SB = SB - M.daysFromToday(GlobalIgnoreDB.dateList[b])
					if SB < 1 then SB = -1 end
				end
				
				if SA < SB then
					return true
				elseif SA > SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			elseif sortType == 10 then
				local SA = GlobalIgnoreDB.expList[a]
				local SB = GlobalIgnoreDB.expList[b]
				
				if not SA or SA == 0 then
					SA = -100000
				else
					SA = SA - M.daysFromToday(GlobalIgnoreDB.dateList[a])
					if SA < 1 then SA = -1 end
				end
					
				if not SB or SB == 0 then
					SB = -100000
				else
					SB = SB - M.daysFromToday(GlobalIgnoreDB.dateList[b])
					if SB < 1 then SB = -1 end
				end
				
				if SA  > SB then
					return true
				elseif SA < SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			elseif sortType == 11 then
				local SA = GlobalIgnoreDB.notes[a]
				local SB = GlobalIgnoreDB.notes[b]
				
				if SA == "" then SA = string.char(255) end
				if SB == "" then SB = string.char(255) end
				
				if SA < SB then
					return true
				elseif SA > SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end
			
			elseif sortType == 12 then
				local SA = GlobalIgnoreDB.notes[a]
				local SB = GlobalIgnoreDB.notes[b]
				
				if SA == "" then SA = string.char(255) end
				if SB == "" then SB = string.char(255) end
				
				if SA > SB then
					return true
				elseif SA < SB then
					return false
				elseif SA == SB then
					return elementName(a) < elementName(b)
				end			
			end
		end)
	
	if (IgnoreScrollFrame ~= nil) then	
		IgnoreListDrawUpdate(IgnoreScrollFrame)
	end
end

local function columnClick(self)

	local id = self:GetID()

	if id == 1 then
		if IgnoreScrollType == 1 then
			createSortedIndex(2)
		else
			createSortedIndex(1)
		end
	elseif id == 2 then
		if IgnoreScrollType == 3 then
			createSortedIndex(4)
		else
			createSortedIndex(3)
		end
	elseif id == 3 then
		if IgnoreScrollType == 5 then
			createSortedIndex(6)
		else
			createSortedIndex(5)
		end
	elseif id == 4 then
		if IgnoreScrollType == 7 then
			createSortedIndex(8)
		else
			createSortedIndex(7)
		end		
	elseif id == 5 then
		if IgnoreScrollType == 9 then
			createSortedIndex(10)
		else
			createSortedIndex(9)
		end	
	elseif id == 6 then
		if IgnoreScrollType == 11 then
			createSortedIndex(12)
		else
			createSortedIndex(11)
		end	
	end
end

local function createColumn (text, width, parent)

	local p = _G[parent:GetName() .. "Header1"]
	
	if p == nil then
		columnCount = 0
	end
	
	columnCount = columnCount + 1
	
	local Header = CreateFrame("Button", parent:GetName() .. "Header" .. columnCount, parent, "WhoFrameColumnHeaderTemplate")
	Header:SetWidth(width)
	_G[parent:GetName().."Header"..columnCount.."Middle"]:SetWidth(width - 9)
	Header:SetText(text)
	Header:SetNormalFontObject("GameFontHighlight")
	Header:SetID(columnCount)
	
	if columnCount == 1 then	
		Header:SetPoint("TOPLEFT", parent, "TOPLEFT", 1, 22)
	else
		Header:SetPoint("LEFT", parent:GetName() .."Header"..columnCount - 1, "RIGHT", 0, 0)	
	end
	
	Header:SetScript("OnClick", columnClick)
end

--------------------
-- LINK CONVERTER --
--------------------

local function convertLink (text)

	if text == nil or text == "" then
		return "UNKNOWN"
	end

	local temp = string.match(text, "|Hitem:(%d+)")
	if temp then
		return "[item=".. temp .. "]"
	end

	temp = string.match(text, "|Hspell:(%d+)")
	if temp then
		return "[spell=".. temp.."]"
	end
	
	temp = string.match(text, "|Htalent:(%d+)")
	if temp then
		return "[talent=" .. temp .. "]"
	end

	temp = string.match(text, "|Hachievement:(%d+)")
	if temp then
		return "[achievement=".. temp .. "]"
	end
	
	temp = string.match(text, "|Hbattlepet:(%d+)")
	if temp then
		return "[pet=" .. temp .. "]"
	end
	
	temp = string.match(text, "|Hjournal:(%d+)")
	if temp then
		return "[journal]"
	end
	
	if string.match(text, "|Htrade:") then
		return "[trade]"
	end
	
	if string.match(text, "|Hclubfinder:") then
		return "[guild]"
	end
	
	if string.match(text, "|Hclubticket:") then
		return "[community]"
	end
	
	return "UNKNOWN"
end

---------------------
-- BUILD UI FRAMES --
---------------------

local function CreateUIFrames()

	if MainFrame ~= nil then
		createSortedIndex(IgnoreScrollType)
		MainFrame:Show()
		return
	end

	local function getFrameStrata()
		if GlobalIgnoreDB.frameStrata == 0 then
			return "LOW"
		elseif GlobalIgnoreDB.frameStrata == 1 then
			return "MEDIUM"
		elseif GlobalIgnoreDB.frameStrata == 2 then
			return "HIGH"
		else
			return "DIALOG"
		end
	end

	----------------
	-- MAIN FRAME --
	----------------
	
	MainFrame = CreateFrame("Frame", "GIL", UIParent, "PortraitFrameTemplate")

	MainFrame:Hide()
	
	MainFrame:SetFrameStrata(getFrameStrata())	
	MainFrame:SetWidth(WINDOW_WIDTH)
	MainFrame:SetHeight(WINDOW_HEIGHT)
	MainFrame:SetPoint("CENTER", UIParent)
	MainFrame:SetMovable(true)
	MainFrame:EnableMouse(true)
	MainFrame:RegisterForDrag("LeftButton", "RightButton")
	MainFrame:SetClampedToScreen(true)
	
	MainFrame.title = _G["GILTitleText"]
	MainFrame.title:SetText("Global Ignore List")
	
	MainFrame:SetScript("OnMouseDown",
		function(self)
			self:StartMoving()
    			self.isMoving = true
		end)

	MainFrame:SetScript("OnMouseUp",
		function (self)
			if self.isMoving then
				self:StopMovingOrSizing()
				self.isMoving = false
			end
		end)
		
	MainFrame:SetScript("OnShow",
		function (self)
			if V.GIL_SyncOK == false then
				M.SyncIgnoreList(GlobalIgnoreDB.chatmsg == false)
			end
		end)

	local icon = MainFrame:CreateTexture("$parentIcon", "OVERLAY", nil, -8)
		
	icon:SetSize(60, 60)
	icon:SetPoint("TOPLEFT", -5, 7)
	icon:SetTexture("Interface\\FriendsFrame\\Battlenet-Portrait")
	
	local Tab1Button = CreateFrame("Button", "GILTab1", MainFrame, "CharacterFrameTabButtonTemplate")
	
	Tab1Button:SetPoint("TOPLEFT", MainFrame, "BOTTOMLEFT", 20, 1)
	Tab1Button:SetText(L["TAB_1"])
	Tab1Button:SetID("1")
	
	Tab1Button:SetScript("OnClick",
		function(self)
			Tab3Frame:Hide()
			Tab2Frame:Hide()
			Tab2FrameEdit:Hide()
			Tab2FrameBlock:Hide()
			Tab1Frame:Show()
			PanelTemplates_SetTab(MainFrame, 1)
		end)

	local Tab2Button = CreateFrame("Button", "GILTab2", MainFrame, "CharacterFrameTabButtonTemplate")

	Tab2Button:SetPoint("LEFT", "GILTab1", "RIGHT", -16, 0)
	Tab2Button:SetText(L["TAB_2"])
	Tab2Button:SetID("2")

	Tab2Button:SetScript("OnClick",
		function(self)
			Tab1Frame:Hide()
			Tab3Frame:Hide()
			
			M.FilterScrollChangeState(-1)
					
			PanelTemplates_SetTab(MainFrame, 2)
		end)
		
	local Tab3Button = CreateFrame("Button", "GILTab3", MainFrame, "CharacterFrameTabButtonTemplate")	
	
	Tab3Button:SetPoint("LEFT", "GILTab2", "RIGHT", -16, 0)
	Tab3Button:SetText(L["TAB_3"])
	Tab3Button:SetID("3")

	Tab3Button:SetScript("OnClick",
		function(self)
			Tab1Frame:Hide()
			Tab2Frame:Hide()
			Tab2FrameEdit:Hide()
			Tab2FrameBlock:Hide()
			Tab3Frame:Show()
			PanelTemplates_SetTab(MainFrame, 3)
		end)
		
	------------------
	-- TAB 1 FRAMES --
	------------------
	
	Tab1Frame = CreateFrame("Frame", "GILFrame1", MainFrame, "InsetFrameTemplate")

	Tab1Frame:SetWidth(WINDOW_WIDTH - 19)
	Tab1Frame:SetHeight(WINDOW_HEIGHT - WINDOW_OFFSET)
	Tab1Frame:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 8, -84)

	Tab1Frame:SetScript("OnShow",
		function(self)
			IgnoreListDrawUpdate(IgnoreScrollFrame)
		end)
	
	createColumn(L["COL_1"], COL_NAME, Tab1Frame)
	createColumn(L["COL_2"], COL_SERVER, Tab1Frame)
	createColumn(L["COL_3"], COL_TYPE, Tab1Frame)
	createColumn(L["COL_4"], COL_LISTED, Tab1Frame)
	createColumn(L["COL_5"], COL_EXPIRE, Tab1Frame)
	createColumn(L["COL_6"], COL_NOTES, Tab1Frame)
	--createColumn("Alts", 40, Tab1Frame)

	IgnoreScrollFrame = CreateFrame("ScrollFrame", "GILIgnoreScrollFrame", Tab1Frame, "FauxScrollFrameTemplate")
	
	IgnoreScrollFrame:SetWidth  (WINDOW_WIDTH - 46)
	IgnoreScrollFrame:SetHeight (BUTTON_TOTAL * BUTTON_HEIGHT)
	IgnoreScrollFrame:SetPoint  ("TOPLEFT", 0, -4)
	
	IgnoreScrollFrame:SetScript("OnVerticalScroll",
		function(self, offset)
			FauxScrollFrame_OnVerticalScroll(self, offset, BUTTON_HEIGHT, IgnoreListDrawUpdate)
		end)
	
	Tab1Frame.infotext = Tab1Frame:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
	
	Tab1Frame.infotext:SetWidth(COL_INFOTEXT)
	Tab1Frame.infotext:SetJustifyH("CENTER")
	Tab1Frame.infotext:SetPoint("TOP", 0, 46)
	
	CreateIgnoreButtons()
	
	local Button1 = CreateFrame("Button", "GILFrame1IgnoreButton", Tab1Frame, "UIPanelButtonTemplate")
	
	Button1:SetSize(110, 22)
	Button1:SetText(L["BUT_1"])
	Button1:SetPoint("BOTTOMRIGHT", -1, -24)
	Button1:SetScript("OnClick", function(self) ButtonIgnoreRemove() end)
	
	local Button2 = CreateFrame("Button", "GILFrame1PruneButton", Tab1Frame, "UIPanelButtonTemplate")
	
	Button2:SetSize(110, 22)
	Button2:SetText(L["BUT_8"])
	Button2:SetPoint("RIGHT", "GILFrame1IgnoreButton", "LEFT", 0, 0)	
	Button2:SetScript("OnClick", function(self) StaticPopup_Show("GIL_PRUNE", L["BOX_12"]) end)

	createSortedIndex(1)

	------------------
	-- TAB 2 FRAMES --
	------------------	
	
	Tab2Frame = CreateFrame("Frame", "GILFrame2", MainFrame, "InsetFrameTemplate")
	
	Tab2Frame:SetScript("OnShow",
		function(self)
			M.FilterListDrawUpdate(FilterScrollFrame) -- update filter count display
		end)
	
	Tab2Frame:Hide()

	Tab2Frame:SetWidth(WINDOW_WIDTH - 19)
	Tab2Frame:SetHeight(WINDOW_HEIGHT - WINDOW_OFFSET)
	Tab2Frame:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 8, -84)
	
	Tab2Frame.infotext = Tab2Frame:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
	
	Tab2Frame.infotext:SetWidth(COL_INFOTEXT)
	Tab2Frame.infotext:SetJustifyH("CENTER")
	Tab2Frame.infotext:SetPoint("TOP", 0, 46)
	
	createColumn(L["COL_9"],  COL_DESC + 10,   Tab2Frame)
	createColumn("",          COL_STATE + 12,  Tab2Frame)
	createColumn(L["COL_11"], COL_BLOCKED + 12, Tab2Frame)
	createColumn(L["COL_10"], COL_FILTER, Tab2Frame)
	
	FilterScrollFrame = CreateFrame("ScrollFrame", "GILFilterScrollFrame", Tab2Frame, "FauxScrollFrameTemplate")
	
	FilterScrollFrame:SetWidth  (WINDOW_WIDTH - 46)
	FilterScrollFrame:SetHeight (BUTTON_TOTAL * BUTTON_HEIGHT)
	FilterScrollFrame:SetPoint  ("TOPLEFT", 0, -4)
	
	FilterScrollFrame:SetScript("OnVerticalScroll",
		function(self, offset)
			FauxScrollFrame_OnVerticalScroll(self, offset, BUTTON_HEIGHT, M.FilterListDrawUpdate)
		end)
	
	CreateFilterButtons()

	local Button = CreateFrame("Button", "GILFrame2CreateButton", Tab2Frame, "UIPanelButtonTemplate")
	Button:SetSize(110, 22)
	Button:SetText(L["BUT_5"])
	Button:SetPoint("BOTTOMRIGHT", -1, -24)
	Button:SetScript("OnClick",
		function(self)
			local idx = #GlobalIgnoreDB.filterList + 1
			
			GlobalIgnoreDB.filterList[idx]			= "[word=NewChatFilter]"
			GlobalIgnoreDB.filterDesc[idx]			= "New Chat Filter"
			GlobalIgnoreDB.filterCount[idx]			= 0
			GlobalIgnoreDB.filterActive[idx]		= false
			GlobalIgnoreDB.filterID[idx]			= ""
			GlobalIgnoreDB.filterBlocked[idx]		= {}
			GlobalIgnoreDB.filterBlockedLast[idx]	= 0
			
			M.FilterListDrawUpdate(FilterScrollFrame)
		end)

	local Button = CreateFrame("Button", "GILFrame2RemoveButton", Tab2Frame, "UIPanelButtonTemplate")	
	Button:SetSize(110, 22)
	Button:SetText(L["BUT_6"])
	Button:SetPoint("RIGHT", "GILFrame2CreateButton", "LEFT", 0, 0)	
	Button:SetScript("OnClick",
		function(self)
			ButtonFilterRemove()
		end
	)
	
	local Button = CreateFrame("Button", "GILFrame2BlockButton", Tab2Frame, "UIPanelButtonTemplate")	
	Button:SetSize(110, 22)
	Button:SetText(L["BUT_9"])
	Button:SetPoint("RIGHT", "GILFrame2RemoveButton", "LEFT", 0, 0)
	Button:SetScript("OnClick",
		function(self)
			M.FilterScrollBlockHistory()
		end
	)
	
	local Button = CreateFrame("Button", "GILFrame2ResetButton", Tab2Frame, "UIPanelButtonTemplate")
	Button:SetSize(110, 22)
	Button:SetText(L["BUT_7"])
	--Button:SetPoint("RIGHT", "GILFrame2BlockButton", "LEFT", 0, 0)
	Button:SetPoint("BOTTOMLEFT", -1, -24)	
	Button:SetScript("OnClick",
		function(self)
			StaticPopup_Show("GIL_FILTERRESET", L["BOX_4"])
		end
	)

	-----------------------
	-- TAB 2 EDIT FRAMES --
	-----------------------	

	Tab2FrameEdit = CreateFrame("Frame", "GILFrame2Edit", MainFrame, "InsetFrameTemplate")
	
	Tab2FrameEdit:Hide()

	Tab2FrameEdit:SetWidth(WINDOW_WIDTH - 19)
	Tab2FrameEdit:SetHeight(WINDOW_HEIGHT - WINDOW_OFFSET + 20)
	Tab2FrameEdit:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 8, -64)
	Tab2FrameEdit:SetScript("OnShow",
		function(self)
			self.InfoText:SetText(format(L["INFO_3"], (GlobalIgnoreDB.filterCount[FilterScrollSelect] or 0)))
		end
	)

	-- BOTTOM BUTTONS
	
	local Button = CreateFrame("Button", "GILFrame2EditCancelButton", Tab2FrameEdit, "UIPanelButtonTemplate")
		
	Button:SetSize(110, 22)
	Button:SetText("Cancel")
	Button:SetPoint("BOTTOMRIGHT", -1, -24)
	Button:SetScript("OnClick",
		function(self)
			M.FilterScrollChangeState(0)
		end
	)
	
	Button = CreateFrame("Button", "GILFrame2EditSaveButton", Tab2FrameEdit, "UIPanelButtonTemplate")
	Button:SetSize(110, 22)
	Button:SetText("Save Filter")
	Button:SetPoint("RIGHT", "GILFrame2EditCancelButton", "LEFT", 0, 0)
	Button:SetScript("OnClick",
		function(self)
			Tab2EditDesc   = GILFrame2EditDescField:GetText()
			Tab2EditFilter = GILFrame2EditFilterField.EditBox:GetText()
			
			GlobalIgnoreDB.filterDesc[FilterScrollSelect] = Tab2EditDesc
			GlobalIgnoreDB.filterList[FilterScrollSelect] = Tab2EditFilter
			GlobalIgnoreDB.filterActive[FilterScrollSelect] = Tab2EditActive
			
			M.FilterScrollChangeState(0)
		end
	)
	
	
	-- WIDGETS
	
	local Text = Tab2FrameEdit:CreateFontString("FontString", "OVERLAY", "GameFontNormalLarge")
	Text:SetPoint("TOPLEFT", Tab2FrameEdit, "TOPLEFT", -8, -18)
	Text:SetWidth(200)
	Text:SetText("Chat Filter Editor:")

	Tab2FrameEdit.InfoText = Tab2FrameEdit:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
	
	Tab2FrameEdit.InfoText:SetWidth(250)
	Tab2FrameEdit.InfoText:SetJustifyH("RIGHT")
	Tab2FrameEdit.InfoText:SetPoint("TOPRIGHT", -48 , -24)
	Tab2FrameEdit.InfoText:SetScript("OnMouseUp", function(self, button)
		M.FilterScrollBlockHistory()
	end)

	---

	Button = Tab2FrameEdit:CreateFontString("GILFrame2ActiveText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("TOPLEFT", Text, "BOTTOMLEFT", 50, -14)
	Button:SetText("Active:")
	
	Button = CreateFrame("CheckButton", "GILFrame2Active", Tab2FrameEdit, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame2ActiveText, "BOTTOMLEFT", -4, 2)
	Button:SetScript("OnShow",  function(self) self:SetChecked(Tab2EditActive == true) end)
	Button:SetScript("OnClick" ,function(self) Tab2EditActive = (self:GetChecked() or false) end) 

	Button = Tab2FrameEdit:CreateFontString("GILFrame2EditDescText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("TOPLEFT", Text, "BOTTOMLEFT", 110, -14)
	Button:SetText("Description:")
	
	Button = CreateFrame("EditBox", "GILFrame2EditDescField", Tab2FrameEdit, "InputBoxTemplate")
	Button:SetPoint("TOPLEFT", GILFrame2EditDescText, "BOTTOMLEFT", 6, -4)
	Button:SetWidth(564)
	Button:SetHeight(20)
	Button:SetAutoFocus(false)
	Button:SetScript("OnShow",	    function(self) self:SetText(Tab2EditDesc) end)
	Button:SetScript("OnEnterPressed",  function(self) Tab2EditDesc = self:GetText() self:ClearFocus() end)
	Button:SetScript("OnEscapePressed", function(self) self:SetText(Tab2EditDesc) self:ClearFocus() end)
	
	---

	Button = Tab2FrameEdit:CreateFontString("GILFrame2EditFilterText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("TOPLEFT", GILFrame2EditDescText, "BOTTOMLEFT", -60, -40)
	Button:SetText("Filter:")
		
	Button = CreateFrame("ScrollFrame", "GILFrame2EditFilterField", Tab2FrameEdit, "InputScrollFrameTemplate")
	Button:SetPoint("TOPLEFT", GILFrame2EditFilterText, "BOTTOMLEFT", 6, -8)
	Button:SetSize(618, 60)
	Button.EditBox:SetAutoFocus(false)
	Button.EditBox:SetMaxLetters(1000)
	Button.EditBox:SetWidth(570)
	Button.EditBox:SetFontObject("ChatFontNormal")
	Button.EditBox:SetScript("OnShow",		    function(self) self:SetText(Tab2EditFilter) end)	
	Button.EditBox:SetScript("OnEnterPressed",  function(self) Tab2EditFilter = self:GetText() self:ClearFocus() end)
	Button.EditBox:SetScript("OnEscapePressed", function(self) self:SetText(Tab2EditFilter) self:ClearFocus() end)
	
	Button = CreateFrame("Button", "GILFrame2EditFilterHelp", Tab2FrameEdit, "UIPanelButtonTemplate")
	Button:SetSize(38, 18)
	Button:SetNormalFontObject("GameFontNormalSmall")
	Button:SetText("Help")
	Button:SetPoint("RIGHT", "GILFrame2EditFilterText", "RIGHT", 598, 0)
	Button:SetScript("OnEnter",
		function(self)
		
			GameTooltip:SetOwner(self)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(L["TIP_1"]);
			GameTooltip:Show()
		end)
		
	Button:SetScript("OnLeave",
		function(self)
			GameTooltip:Hide()
		end)

	---
	
	Button = Tab2FrameEdit:CreateFontString("GILFrame2EditTestText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("BOTTOMLEFT", Tab2FrameEdit, "BOTTOMLEFT", 42, 94)
	Button:SetText("Filter Testing:")

	Button = Tab2FrameEdit:CreateFontString("GILFrame2EditTestResult", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("TOPRIGHT", GILFrame2EditTestText, "TOPRIGHT", 104, -1)
	Button:SetWidth(100)
	Button:SetJustifyH("LEFT")	
	Button:SetText("")
	
	Button = CreateFrame("ScrollFrame", "GILFrame2EditTestField", Tab2FrameEdit, "InputScrollFrameTemplate")
	Button:SetPoint("TOPLEFT", GILFrame2EditTestText, "BOTTOMLEFT", 6, -8)
	Button:SetSize(400, 60)
	Button.EditBox:SetAutoFocus(false)
	Button.EditBox:SetMaxLetters(500)
	Button.EditBox:SetWidth(355)
	Button.EditBox:SetFontObject("ChatFontNormal")
	Button.EditBox:SetScript("OnTextChanged", function(self) GILFrame2EditTestResult:SetText("") end)
	
	Button = CreateFrame("Button", "GILFrame2EditTestHelp", Tab2FrameEdit, "UIPanelButtonTemplate")
	Button:SetSize(38, 18)
	Button:SetNormalFontObject("GameFontNormalSmall")
	Button:SetText("Help")
	Button:SetPoint("RIGHT", "GILFrame2EditTestText", "RIGHT", 294, 0)
	Button:SetScript("OnEnter",
		function(self)
		
			GameTooltip:SetOwner(self)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(L["TIP_2"]);
			GameTooltip:Show()
		end)
		
	Button:SetScript("OnLeave",
		function(self)
			GameTooltip:Hide()
		end)

	Button = CreateFrame("Button", "GILFrame2EditTestTest", Tab2FrameEdit, "UIPanelButtonTemplate")
	Button:SetSize(38, 18)
	Button:SetNormalFontObject("GameFontNormalSmall")
	Button:SetText("Test")
	Button:SetPoint("RIGHT", "GILFrame2EditTestHelp", "RIGHT", 40, 0)

	Button:SetScript("OnClick",
		function(self)

			local chatStr   = string.lower(GILFrame2EditTestField.EditBox:GetText())
			local filterStr = GILFrame2EditFilterField.EditBox:GetText()
						
			local res = M.filterComplex (filterStr, chatStr, 1)
			
			if V.lastFilterError == true then
				GILFrame2EditTestResult:SetText("|cffffff00FILTER ERROR")
			elseif res == true then
				GILFrame2EditTestResult:SetText("|cffff5c5cBLOCKED")			
			else
				GILFrame2EditTestResult:SetText("|cff00ff96PASSED")			
			end
		end)

	-- Debating if this will be confusing ie people will view block history without saving their filter and thing its broken
	--Button = CreateFrame("Button", "GILFrame2EditBlockHistory", Tab2FrameEdit, "UIPanelButtonTemplate")
	--Button:SetSize(100, 18)
	--Button:SetNormalFontObject("GameFontNormalSmall")
	--Button:SetText(L["BUT_9"])
	--Button:SetPoint("BOTTOMLEFT", "GILFrame2EditTestField", "BOTTOMRIGHT", 15, -5)
	--Button:SetScript("OnClick",
	--	function(self)
	--		M.FilterScrollBlockHistory()
	--	end)

	---

	Button = Tab2FrameEdit:CreateFontString("GILFrame2EditLinkText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("BOTTOMRIGHT", Tab2FrameEdit, "BOTTOMRIGHT", -130, 94)
	Button:SetText("Chat Link Converter:")
	
	Button = CreateFrame("Button", "GILFrame2EditLinkHelp", Tab2FrameEdit, "UIPanelButtonTemplate")
	Button:SetSize(38, 18)
	Button:SetNormalFontObject("GameFontNormalSmall")
	Button:SetText("Help")
	Button:SetPoint("RIGHT", "GILFrame2EditLinkText", "RIGHT", 86, 0)
	Button:SetScript("OnEnter",
		function(self)
		
			GameTooltip:SetOwner(self)
			GameTooltip:ClearLines()
			GameTooltip:AddLine("|cffffffffChat Link Converter Help\n\n|cffffff00Enter a chat link into the input box, then press the Enter key.  If the link is valid\nit will be converted into a [tag] used by the chat filter system.\n\nConverted text will automatically be selected so it can be copied and pasted\nusing the copy and paste hotkeys.\n\nLinking items directly into the filter editor box will also automatically convert\nthe link to a GIL format [tag] without using this conversion tool.")
			GameTooltip:Show()
		end)
		
	Button:SetScript("OnLeave",
		function(self)
			GameTooltip:Hide()
		end)

	Button = CreateFrame("EditBox", "GILFrame2EditLinkField", Tab2FrameEdit, "InputBoxTemplate")
	Button:SetPoint("TOPLEFT", GILFrame2EditLinkText, "BOTTOMLEFT", 5, -4)
	Button:SetWidth(200)
	Button:SetHeight(20)
	Button:SetAutoFocus(false)
	Button:SetScript("OnEnterPressed",
		function(self)
			self:SetText(convertLink(self:GetText()))
			self:HighlightText()
		end)

	--------------------------------
	-- TAB 2 BLOCK HISTORY FRAMES --
	--------------------------------

	Tab2FrameBlock = CreateFrame("Frame", "GILFrame2Block", MainFrame, "InsetFrameTemplate")
	
	Tab2FrameBlock:Hide()

	Tab2FrameBlock:SetWidth(WINDOW_WIDTH - 19)
	Tab2FrameBlock:SetHeight(WINDOW_HEIGHT - WINDOW_OFFSET)
	Tab2FrameBlock:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 8, -84)
	
	Tab2FrameBlock.InfoText = Tab2FrameBlock:CreateFontString("FontString", "OVERLAY", "GameFontHighlight")
	
	Tab2FrameBlock.InfoText:SetWidth(COL_INFOTEXT)
	Tab2FrameBlock.InfoText:SetJustifyH("CENTER")
	Tab2FrameBlock.InfoText:SetPoint("TOP", 0, 46)
	
	Tab2FrameBlock:SetScript("OnShow",
		function(self)
			M.UpdateBlockButtons()
		end
	)

	--createColumn("Date", 94, Tab2FrameBlock)
	createColumn("Player", 200, Tab2FrameBlock)
	createColumn("Message", 490, Tab2FrameBlock)
	
	-- BOTTOM BUTTONS
	
	local Button = CreateFrame("Button", "GILFrame2BlockCloseButton", Tab2FrameBlock, "UIPanelButtonTemplate")
	Button:SetSize(110, 22)
	Button:SetText(L["BUT_10"])
	Button:SetPoint("BOTTOMRIGHT", -1, -24)
	Button:SetScript("OnClick", function(self)
		M.FilterScrollChangeState(0)
	end)
	
	local Button = CreateFrame("Button", "GILFrame2BlockEdit", Tab2FrameBlock, "UIPanelButtonTemplate")
	Button:SetSize(110, 22)
	Button:SetText(L["BUT_11"])
	Button:SetPoint("RIGHT", "GILFrame2BlockCloseButton", "LEFT", 0, 0)
	Button:SetScript("OnClick",
		function(self)
			FilterScrollSelect = Tab2BlockFilter
			M.FilterScrollEditMenu()
		end
	)
	
	-- SCROLLING SLATE
	
	Tab2FrameBlock.ScrollFrame = CreateFrame("ScrollFrame", "GILBlockScrollFrame", Tab2FrameBlock, "UIPanelScrollFrameTemplate");
	Tab2FrameBlock.Slate = CreateFrame("Frame");
	Tab2FrameBlock.Slate:SetSize(Tab2FrameBlock:GetWidth(), Tab2FrameBlock:GetHeight());
	
	local name					= Tab2FrameBlock.ScrollFrame:GetName();
	Tab2FrameBlock.ScrollBar	= _G[name.."ScrollBar"];
	Tab2FrameBlock.ScrollUp		= _G[name.."ScrollBarScrollUpButton"];
	Tab2FrameBlock.ScrollDown	= _G[name.."ScrollBarScrollDownButton"];
 
	Tab2FrameBlock.ScrollUp:ClearAllPoints();
	Tab2FrameBlock.ScrollUp:SetPoint("TOPRIGHT", Tab2FrameBlock.ScrollFrame, "TOPRIGHT", -2, -2);
 
	Tab2FrameBlock.ScrollDown:ClearAllPoints();
	Tab2FrameBlock.ScrollDown:SetPoint("BOTTOMRIGHT", Tab2FrameBlock.ScrollFrame, "BOTTOMRIGHT", -2, 2);
 
	Tab2FrameBlock.ScrollBar:ClearAllPoints();
	Tab2FrameBlock.ScrollBar:SetPoint("TOP", Tab2FrameBlock.ScrollUp, "BOTTOM", 0, -2);
	Tab2FrameBlock.ScrollBar:SetPoint("BOTTOM", Tab2FrameBlock.ScrollDown, "TOP", 0, 2);
 
	Tab2FrameBlock.ScrollFrame:SetScrollChild(Tab2FrameBlock.Slate);	
	Tab2FrameBlock.ScrollFrame:SetClipsChildren(true)
	Tab2FrameBlock.ScrollFrame:SetAllPoints(Tab2FrameBlock);
	
	M.UpdateBlockButtons()

	------------------
	-- TAB 3 FRAMES --
	------------------	
	
	Tab3Frame = CreateFrame("ScrollFrame", "GILFrame3", MainFrame, "InsetFrameTemplate")
	Tab3Frame:Hide()

	Tab3Frame:SetWidth(WINDOW_WIDTH - 19)
	Tab3Frame:SetHeight(WINDOW_HEIGHT - WINDOW_OFFSET + 20)
	Tab3Frame:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 8, -64)
	
	Tab3Frame.ScrollFrame = CreateFrame("ScrollFrame", "GILSlate3", Tab3Frame, "UIPanelScrollFrameTemplate");
	Tab3Frame.Slate = CreateFrame("Frame");
	
	local name				= Tab3Frame.ScrollFrame:GetName();
	Tab3Frame.ScrollBar		= _G[name.."ScrollBar"];
	Tab3Frame.ScrollUp		= _G[name.."ScrollBarScrollUpButton"];
	Tab3Frame.ScrollDown	= _G[name.."ScrollBarScrollDownButton"];
 
	Tab3Frame.ScrollUp:ClearAllPoints();
	Tab3Frame.ScrollUp:SetPoint("TOPRIGHT", Tab3Frame.ScrollFrame, "TOPRIGHT", -2, -2);
 
	Tab3Frame.ScrollDown:ClearAllPoints();
	Tab3Frame.ScrollDown:SetPoint("BOTTOMRIGHT", Tab3Frame.ScrollFrame, "BOTTOMRIGHT", -2, 2);
 
	Tab3Frame.ScrollBar:ClearAllPoints();
	Tab3Frame.ScrollBar:SetPoint("TOP", Tab3Frame.ScrollUp, "BOTTOM", 0, -2);
	Tab3Frame.ScrollBar:SetPoint("BOTTOM", Tab3Frame.ScrollDown, "TOP", 0, 2);
 
	Tab3Frame.ScrollFrame:SetScrollChild(Tab3Frame.Slate);	
	Tab3Frame.ScrollFrame:SetClipsChildren(true);
	Tab3Frame.ScrollFrame:SetAllPoints(Tab3Frame);
 
	-- Plot options on our scrolling slate
	
	Tab3Frame.Slate:SetSize(Tab3Frame:GetWidth(), (Tab3Frame:GetHeight() + 120));
	
	-- Ignore options
 
	Text = Tab3Frame.Slate:CreateFontString("FontString", "OVERLAY", "GameFontNormalLarge")
	Text:SetPoint("TOPLEFT", Tab3Frame.Slate, "TOPLEFT", 16, -10)
	Text:SetWidth(200)
	Text:SetJustifyH("LEFT");
	Text:SetText(L["OPT_8"])
	
	Button = CreateFrame("CheckButton", "GILFrame3AskNote", Tab3Frame.Slate, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", Text, "BOTTOMLEFT", 14, -10)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_1"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.asknote == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.asknote = (self:GetChecked() or false) end) 
	
	Button = CreateFrame("CheckButton", "GILFrame3SameServer", Tab3Frame.Slate, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame3AskNote, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_4"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.sameserver == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.sameserver = (self:GetChecked() or false) end) 

	Button = CreateFrame("CheckButton", "GILFrame3SameFaction", Tab3Frame.Slate, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame3SameServer, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_27"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.samefaction == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.samefaction = (self:GetChecked() or false) end) 

	Button = CreateFrame("CheckButton", "GILFrame3TrackChanges", Tab3Frame.Slate, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame3SameFaction, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_6"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.trackChanges == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.trackChanges = (self:GetChecked() or false) end) 

	Button = CreateFrame("CheckButton", "GILFrame3SyncMsgs", Tab3Frame.Slate, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame3TrackChanges, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_26"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.chatmsg == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.chatmsg = (self:GetChecked() or false) end) 

	Button = CreateFrame("CheckButton", "GILFrame3ShowDeclines", Tab3Frame.Slate, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame3SyncMsgs, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_28"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.showDeclines == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.showDeclines = (self:GetChecked() or false) end) 
	
	Button = CreateFrame("CheckButton", "GILFrame3SyncWarning", Tab3Frame.Slate, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame3ShowDeclines, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_18"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.showWarning == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.showWarning = (self:GetChecked() or false) end) 

	Button = CreateFrame("CheckButton", "GILFrame3IgnoreResponse", Tab3Frame.Slate, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame3SyncWarning, "BOTTOMLEFT", 0, 4)
	_G[Button:GetName().."Text"]:SetText(L["OPT_24"])
	_G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.ignoreResponse == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.ignoreResponse = (self:GetChecked() or false) end) 	

	Button = Tab3Frame.Slate:CreateFontString("GILFrame3ExpText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("TOPLEFT", GILFrame3IgnoreResponse, "BOTTOMLEFT", 6, -4)
	Button:SetText(L["OPT_5"])

	Button = CreateFrame("EditBox", "GILFrame3Exp", Tab3Frame.Slate, "InputBoxTemplate")
	Button:SetPoint("TOPLEFT", GILFrame3ExpText, "TOPRIGHT", 6, 4)
	Button:SetWidth(50)
	Button:SetHeight(20)
	Button:SetAutoFocus(false)
	Button:SetScript("OnShow",	    function(self) self:SetText(GlobalIgnoreDB.defexpire) end)
	Button:SetScript("OnEnterPressed",  function(self) if tonumber(self:GetText()) then GlobalIgnoreDB.defexpire = tonumber(self:GetText()) end self:ClearFocus() end)
	Button:SetScript("OnEscapePressed", function(self) self:SetText(GlobalIgnoreDB.defexpire) end)

	-- Chat filter options
	
	Text = Tab3Frame.Slate:CreateFontString("FontString", "OVERLAY", "GameFontNormalLarge")
	Text:SetPoint("TOPLEFT", GILFrame3ExpText, "BOTTOMLEFT", -18, -20)
	Text:SetWidth(200)
	Text:SetJustifyH("LEFT");
	Text:SetText(L["OPT_9"]);

	Button = CreateFrame("CheckButton", "GILFrame3EnableFilter", Tab3Frame.Slate, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", Text, "BOTTOMLEFT", 12, -6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_7"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.spamFilter == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.spamFilter = (self:GetChecked() or false) end)

	Button = CreateFrame("CheckButton", "GILFrame3InvertFilter", Tab3Frame.Slate, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", GILFrame3EnableFilter, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_10"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.invertSpam == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.invertSpam = (self:GetChecked() or false) end)

	Button = CreateFrame("CheckButton", "GILFrame3UpdateFilter", Tab3Frame.Slate, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", GILFrame3InvertFilter, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_11"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.autoUpdate == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.autoUpdate = (self:GetChecked() or false) end)

	-- Flood Dropdown 
	
	Button = Tab3Frame.Slate:CreateFontString("GILFrame3FloodText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("TOPLEFT", GILFrame3UpdateFilter, "BOTTOMLEFT", 6, -4)
	Button:SetText(L["OPT_20"])
	
	local function getFloodType()
		if GlobalIgnoreDB.floodFilter == 0 then
			return L["OPT_21"]
		elseif GlobalIgnoreDB.floodFilter == 1 then
			return L["OPT_22"]
		else
			return L["OPT_23"]
		end
	end
	
	local Drop = CreateFrame("DropdownButton", "GILFrame3FloodMenu", Tab3Frame.Slate, "WowStyle1DropdownTemplate")
	Drop:SetDefaultText(getFloodType())
	Drop:SetPoint("TOPLEFT", GILFrame3FloodText, "TOPRIGHT", 0, 6)
	Drop:SetWidth(180)

	Drop:SetupMenu(function(self, root)
		root:CreateButton(L["OPT_21"], function() GlobalIgnoreDB.floodFilter = 0 self:SetDefaultText(getFloodType()) end)
		root:CreateButton(L["OPT_22"], function() GlobalIgnoreDB.floodFilter = 1 self:SetDefaultText(getFloodType()) end)
		root:CreateButton(L["OPT_23"], function() GlobalIgnoreDB.floodFilter = 2 self:SetDefaultText(getFloodType()) end)
	end)

	Button = CreateFrame("CheckButton", "GILFrame3SkipGuild", Tab3Frame.Slate, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", Text, "BOTTOMLEFT", 450, -6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_12"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.skipGuild == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.skipGuild = (self:GetChecked() or false) end)

	Button = CreateFrame("CheckButton", "GILFrame3SkipParty", Tab3Frame.Slate, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", GILFrame3SkipGuild, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_13"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.skipParty == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.skipParty = (self:GetChecked() or false) end)

	Button = CreateFrame("CheckButton", "GILFrame3SkipPrivate", Tab3Frame.Slate, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", GILFrame3SkipParty, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_14"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.skipPrivate == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.skipPrivate = (self:GetChecked() or false) end)

	Button = CreateFrame("CheckButton", "GILFrame3SkipYourself", Tab3Frame.Slate, "UICheckButtonTemplate")
	Button:SetPoint("TOPLEFT", GILFrame3SkipPrivate, "BOTTOMLEFT", 0, 6)
	 _G[Button:GetName().."Text"]:SetText(L["OPT_19"])
	 _G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.skipYourself == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.skipYourself = (self:GetChecked() or false) end)
	
	-- UI Options
	
	Text = Tab3Frame.Slate:CreateFontString("FontString", "OVERLAY", "GameFontNormalLarge")
	Text:SetWidth(200)
	Text:SetPoint("TOPLEFT", GILFrame3UpdateFilter, "BOTTOMLEFT", -10, -40)
	Text:SetJustifyH("LEFT");
	Text:SetText(L["OPT_15"])

	Button = CreateFrame("CheckButton", "GILFrame3OpenUI", Tab3Frame.Slate, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", Text, "BOTTOMLEFT", 12, -4)
	_G[Button:GetName().."Text"]:SetText(L["OPT_2"])
	_G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.openWithFriends == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.openWithFriends = (self:GetChecked() or false) end) 

	Button = CreateFrame("CheckButton", "GILFrame3HackUnit", Tab3Frame.Slate, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame3OpenUI, "BOTTOMLEFT", 0, 4)
	_G[Button:GetName().."Text"]:SetText(L["OPT_16"])
	_G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.useUnitHacks == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.useUnitHacks = (self:GetChecked() or false) end) 

	Button = CreateFrame("CheckButton", "GILFrame3HackLFG", Tab3Frame.Slate, "UICheckButtonTemplate")	
	Button:SetPoint("TOPLEFT", GILFrame3HackUnit, "BOTTOMLEFT", 0, 4)
	_G[Button:GetName().."Text"]:SetText(L["OPT_17"])
	_G[Button:GetName().."Text"]:SetFontObject("GameFontHighlight")
	Button:SetScript("OnShow",  function(self) self:SetChecked(GlobalIgnoreDB.useLFGHacks == true) end)
	Button:SetScript("OnClick" ,function(self) GlobalIgnoreDB.useLFGHacks = (self:GetChecked() or false) end) 
	
	-- Strata dropdown
	
	Button = Tab3Frame.Slate:CreateFontString("GILFrame3StrataText", "OVERLAY", "GameFontHighlight")
	Button:SetPoint("TOPLEFT", GILFrame3HackLFG, "BOTTOMLEFT", 6, -4)
	Button:SetText(L["OPT_25"])
	
	local Drop = CreateFrame("DropdownButton", "GILFrame3StrataMenu", Tab3Frame.Slate, "WowStyle1DropdownTemplate")
	Drop:SetDefaultText(getFrameStrata())
	Drop:SetPoint("TOPLEFT", GILFrame3StrataText, "TOPRIGHT", 0, 6)
	Drop:SetWidth(100)

	Drop:SetupMenu(function(self, root)
		root:CreateButton("LOW", function() GlobalIgnoreDB.frameStrata = 0 self:SetDefaultText(getFrameStrata()) end)
		root:CreateButton("MEDIUM", function() GlobalIgnoreDB.frameStrata = 1 self:SetDefaultText(getFrameStrata()) end)
		root:CreateButton("HIGH", function() GlobalIgnoreDB.frameStrata = 2 self:SetDefaultText(getFrameStrata()) end)
		root:CreateButton("DIALOG", function() GlobalIgnoreDB.frameStrata = 3 self:SetDefaultText(getFrameStrata()) end)
		
	end)

	----------
	-- SHOW --
	----------
	
	PanelTemplates_SetNumTabs(MainFrame, 3)
	PanelTemplates_SetTab(MainFrame, 1)
	
	MainFrame:Show()
end

------------------------------
-- HOOK INTO FRIENDS WINDOW --
------------------------------

local function friendsShow()
	
	if not GlobalIgnoreDB.openWithFriends then
		return
	end
	
	if MainFrame == nil then
		CreateUIFrames()
	end
	
	if MainFrame ~= nil then
		MainFrame:ClearAllPoints()
		MainFrame:SetPoint("TOPLEFT", FriendsFrame, "TOPRIGHT", 12, -10)		
		MainFrame:Show()
	end
end

local function friendsHide()
	if not GlobalIgnoreDB.openWithFriends then
		return
	end

	if MainFrame ~= nil then
		MainFrame:Hide()
	end
end

FriendsFrame:HookScript("OnShow", friendsShow)
FriendsFrame:HookScript("OnHide", friendsHide)

--------------------------
-- HOOK INTO CHAT LINKS --
--------------------------

Blizzard_ChatEdit_InsertLink = ChatEdit_InsertLink

function ChatEdit_InsertLink (text)

	if text and GILFrame2EditLinkField and GILFrame2EditLinkField:HasFocus() then
		GILFrame2EditLinkField:SetText(text)
		GILFrame2EditLinkField:Show()
		
		return true	
	elseif text and GILFrame2EditFilterField and GILFrame2EditFilterField.EditBox:HasFocus() then
		GILFrame2EditFilterField.EditBox:Insert(convertLink(text))
		GILFrame2EditFilterField.EditBox:Show()
		
		return true
	elseif text and GILFrame2EditTestField and GILFrame2EditTestField.EditBox:HasFocus() then
		GILFrame2EditTestField.EditBox:Insert(text)
		GILFrame2EditTestField.EditBox:Show()
		
		return true
	else	
		return Blizzard_ChatEdit_InsertLink(text)
	end
end

---------------------
-- CORE UI GLOBALS --
---------------------

function M.GILUpdateBlockHistory (filterNumber)
	if MainFrame ~= nil and Tab2FrameBlock:IsVisible() and Tab2BlockFilter == filterNumber then
		M.UpdateBlockButtons()
	end
end

function M.GILUpdateChatCount (filterNumber)
	if MainFrame ~= nil and Tab2Frame:IsVisible() then	
		M.FilterListDrawUpdate(FilterScrollFrame)
	end
end

function M.GILUpdateUI (forced)
	if MainFrame ~= nil and Tab1Frame:IsVisible() then	
		if V.needSorted or (forced and forced == true) then
			createSortedIndex(IgnoreScrollType)
		else
			IgnoreListDrawUpdate(IgnoreScrollFrame)
		end
	else
		if V.needSorted or (forced and forced == true) then
			createSortedIndex(IgnoreScrollType)
		end
	end
end

function M.GIL_GUI()
	CreateUIFrames()
end

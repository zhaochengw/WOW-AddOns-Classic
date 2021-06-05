--[[
	Copyright (C) Udorn (Blackhand)

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]

--[[
	Generic table for managing items. May be used to show auctions for example.
--]]
vendor.ItemTable = {}
vendor.ItemTable.prototype = {}
vendor.ItemTable.metatable = {__index = vendor.ItemTable.prototype}

local L = vendor.Locale.GetInstance()
local log = vendor.Debug:new("ItemTable")

local SCROLLER_WIDTH = 20
local SELECT_COL = 76783
local SORT_HEIGHT = 19
local CMD_HEIGHT = 20
local CMD_WIDTH = 90
local FRAME_BACKGROUND = {r = 0, g = 0, b = 0, a = 1}
local CMDS_BACKGROUND = {r = 0.12, g = 0.12, b = 0.12, a = 0.8}
local TOP_INSET = 3
local RIGHT_INSET = 2
local POPUP_BUT_WIDTH = 19
local SELECT_HIGHLIGHT = "Interface\\Addons\\AuctionMaster\\src\\resources\\Highlight1"
local NEUTRAL_HIGHLIGHT = "Interface\\Addons\\AuctionMaster\\src\\resources\\NeutralHighlight"
local GAP = 2

-- Where do they get from?
local function _RemoveDuplicateColumns(self)
	local cols = self.cfg.selected
	local n = #cols
	for i=1,n-1 do
		local val = cols[i]
		for j=n,i+1,-1 do
			if (cols[j] == val) then
				tremove(cols, j)
				n = n - 1
			end 	
		end
	end
end

--[[
	Updates the arrow indicator of the given button.
--]]
local function _UpdateArrow(self, bt, sortId, ascending)
	local arrow = getglobal(bt:GetName().."Arrow");
	if (bt.sortId == sortId) then
		arrow:Show();
		if (not ascending) then
			arrow:SetTexCoord(0, 0.5625, 1.0, 0);
		else
			arrow:SetTexCoord(0, 0.5625, 0, 1.0);
		end
	else
		arrow:Hide();
	end
end

--[[
	Updates the state of the sort buttons.
--]]
local function _UpdateSortButtons(self)
	local sortId, ascending = self.model:GetSortInfo()
	for _,col in pairs(self.cols) do
		if (col.sortButton) then
			_UpdateArrow(self, col.sortButton, sortId, ascending)
		end
	end
end

local function _ResizeSortButtons(self, isScrolling)
	for i=1,#self.cols do
		local col = self.cols[i]
		if (col.sortButton) then
			if (isScrolling) then
				if (i == #self.cols) then
					col.sortButton:SetWidth(col.minWidth + RIGHT_INSET)
				else
					col.sortButton:SetWidth(col.minWidth)
				end
			else
				if (i == #self.cols) then
					col.sortButton:SetWidth(col.maxWidth + RIGHT_INSET - POPUP_BUT_WIDTH)
			 	else
					col.sortButton:SetWidth(col.maxWidth)
				end
			end
		end
	end
end

--[[
	Callback for updating the scroll frame.
--]]
local function _ScrollUpdate(frame)
	local self = frame.obj
	if (not self.numVisibleItems or not self.innerFrame:IsVisible() or #self.rows == 0) then
		-- too early
		return
	end
	_UpdateSortButtons(self)
	local n = self.model:Size()
	log:Debug("_ScrollUpdate name [%s] size: %d", self.name, n or 0)
	local offset = FauxScrollFrame_GetOffset(self.scrollFrame)
	local isScrolling = n > self.numVisibleItems
	_ResizeSortButtons(self, isScrolling)
	for i=1,self.numVisibleItems do
		local index = offset + i
		local rowFrame = self.rows[i]
		if (index > n) then
			rowFrame:Hide()
		else
			rowFrame:Show()
			-- resize background according to existance of scroller
			if (isScrolling) then
				rowFrame.selectHighlight:SetWidth(self.minRowWidth)
				rowFrame.highlight:SetWidth(self.minRowWidth)
				for k,v in pairs(rowFrame.highlights) do
					v:SetWidth(self.minRowWidth)
				end
			else
				rowFrame.selectHighlight:SetWidth(self.maxRowWidth)
				rowFrame.highlight:SetWidth(self.maxRowWidth)
				for k,v in pairs(rowFrame.highlights) do
					v:SetWidth(self.maxRowWidth)
				end
			end
			local selected = self.model:IsSelected(index)
			if (selected) then
				rowFrame.selectHighlight:Show()
			else
				rowFrame.selectHighlight:Hide()
			end
			if (self.model.GetHighlight) then
				local highlight = self.model:GetHighlight(index)
				for k,v in pairs(rowFrame.highlights) do
					if (highlight and highlight == k) then
						v:Show()
					else
						v:Hide()
					end
				end
    		end
			for _,col in pairs(self.cols) do
				local cell = self.cells[i.."-"..col.id]
				if (isScrolling) then
					cell:SetWidth(col.minWidth - self.gapDiff)
				else
					cell:SetWidth(col.maxWidth - self.gapDiff)
				end
        		if (col.type == "texture") then
        			cell:Update(self.model:GetValues(index, col.id))
        		elseif (col.type == "text") then
        			cell:Update(self.model:GetValues(index, col.id))
        		elseif (col.type == "number") then
        			cell:Update(self.model:GetValues(index, col.id))
        		else
        			vendor.Vendor:Error("unknown column type: "..(col.type or "NA"))
        		end
			end
		end
	end
	FauxScrollFrame_Update(self.scrollFrame, n, self.numVisibleItems, self.rowHeight)
end

--[[
	Toggles the sort state for the given type. If it's currently not
	the sorting criteria, then it will be activated and set to ascending.
--]]
local function _ToggleSort(self, bt, id)
	self.model:ToggleSort(id)
	_UpdateSortButtons(self)
	_ScrollUpdate(self.scrollFrame)
end

--[[
	Calculates the columns for the specified model.
--]] 
local function _CreateColumns(self)
	log:Debug("_CreateColumns")
	self.cols = wipe(self.cols or {})
	local width = 0
	local weight = 0
	-- calculate the base widths
	for _,id in pairs(self.cfg.selected) do
		local col = {}
		local desc = self.model:GetColumnDescriptor(id)
		if (not desc) then
			error("missing descriptor for id ["..(id or "???").."] name ["..self.name.."]")
		else
			log:Debug("id %s order %s normalTexture %s", id, order, desc.normalTexture)
    		col.type = desc.type
    		col.title = desc.title
    		col.id = id
    		col.sortable = desc.sortable
    		col.align = desc.align
    		col.order = desc.order or 1000
    		col.normalTexture = desc.normalTexture
    		col.normalTexCoord = desc.normalTexCoord
    		col.pushedTexture = desc.pushedTexture
    		col.pushedTexCoord = desc.pushedTexCoord
    		col.updateCallback = desc.updateCallback
    		col.clickCallback = desc.clickCallback
    		col.tooltip = desc.tooltip
    		col.arg = desc.arg
    		if (col.type == "texture") then
    			col.minWidth = self.rowHeight
    		elseif (col.type == "text") then
    			col.minWidth = desc.minWidth
    			col.weight = desc.weight
    		elseif (col.type == "number") then
    			col.minWidth = desc.minWidth
    			col.weight = desc.weight
    		else
    			error("unknown column type: "..(col.type or "NA"))
    		end
    		col.maxWidth = col.minWidth
    		width = width + col.minWidth
    		weight = weight + (col.weight or 0)
    		table.insert(self.cols, col)
    	end
	end
	table.sort(self.cols, function(a, b) return a.order < b.order end)
	local numGapCols = #self.cols
	self.firstGap = GAP
	if (self.cols[1].type == "texture") then
		numGapCols = #self.cols - 1 
		self.firstGap = 0
	end
	self.gapSum = (numGapCols + 1) * GAP -- sum of all gaps
	self.gapDiff =  self.gapSum / numGapCols -- per column diff according to gap
	-- calculate final widths according to weights
	self.minRowWidth = self.width - SCROLLER_WIDTH
	self.maxRowWidth = self.width
	if (width > self.minRowWidth) then
		error("too large width: "..width)
	end
	local diff = self.minRowWidth - width
	local maxDiff = self.maxRowWidth - width
	local prev = nil
	self.innerWidth = 0
	for _,col in pairs(self.cols) do
		if (col.weight and col.weight > 0) then
			local fraction = col.weight / weight
			local colMinWidth = col.minWidth
			col.minWidth = colMinWidth + (diff * fraction)
			col.maxWidth = colMinWidth + (maxDiff * fraction)
			self.innerWidth = self.innerWidth + col.minWidth
		end
		prev = col
	end
end

local function _SelectedItem(self, row)
	local shiftDown = IsShiftKeyDown()
	local ctrlDown = IsControlKeyDown()
	local button = GetMouseButtonClicked()
	log:Debug("shiftDown [%s] ctrlDown [%s] button [%s]", shiftDown, ctrlDown, button)
	local offset = FauxScrollFrame_GetOffset(self.scrollFrame)
	local idx = offset + row
	local rowFrame = self.rows[row]
	
	if (button == "RightButton") then
		log:Debug("dressing room")
		-- dressing room
		if (self.model.GetItemLink) then
			local itemLink = self.model:GetItemLink(idx)
			log:Debug("itemLink [%s]", itemLink)
			if (not DressUpItemLink(itemLink)) then
				local name, speciesId = vendor.Items:GetBattlePetStats(itemLink)
				if (name and speciesId) then
					-- TODO why 0? It's returned by GetAuctionItemBattlePetInfo
					local creatureId = select(4, C_PetJournal.GetPetInfoBySpeciesID(speciesId))
					DressUpBattlePet(creatureId, 0)
				end
			end
		end
	elseif (button == "LeftButton") then
		if (ctrlDown) then
			-- select this and let the other be also selected
			self.model:SelectItem(idx, not self.model:IsSelected(idx))
		elseif (shiftDown) then
			-- select this up to the last one
			local selectedIndex = self.model:GetSelectedItems()
			local selectedCache = wipe(self.selectedCache)
			-- determine smallest and largest selected item
			log:Debug("selectedIndex size [%s]", #selectedIndex)
			for i=1,#selectedIndex do
				table.insert(selectedCache, selectedIndex[i])
			end
			table.sort(selectedCache)
			local lower, upper
			if (#selectedCache > 0) then
				lower = selectedCache[1]
				upper = selectedCache[#selectedCache]
			end
			-- deselect all items and select the new range
			self:DeselectAll()
			if (lower and upper) then
				log:Debug("lower [%s] upper [%s] idx [%s]", lower, upper, idx)
				local startPos, endPos	
				if (idx < lower) then
	    			startPos, endPos = idx, lower
	    		else
	    			startPos, endPos = upper, idx
	    		end
	    		for i=startPos,endPos do
	    			self.model:SelectItem(i, true)
	    		end
	    	else
	    		self.model:SelectItem(idx, true)
			end
		else
			-- just select this item
			local selected = self.model:IsSelected(idx)
			local deselected = self:DeselectAll()
			if (deselected > 1) then
				self.model:SelectItem(idx, true)
			else
				self.model:SelectItem(idx, not selected)
			end
		end
		self.lastSelected = idx
		_ScrollUpdate(self.scrollFrame)
	end
end

--[[
	Callback for clicks on cells.
--]]
local function _RowDoubleClicked(frame)
	local self = frame.obj
	local offset = FauxScrollFrame_GetOffset(self.scrollFrame)
	local idx = offset + frame.row
	log:Debug("_RowDoubleClicked offset: %d idx: %d", offset, idx)
	if (self.lastSelected and self.lastSelected == idx) then
		-- revert the selection
		self.model:SelectItem(idx, not self.model:IsSelected(idx))
		self.lastSelected = nil
		_ScrollUpdate(self.scrollFrame)
	end 
	if (self.doubleClickFunc) then
		self.doubleClickFunc(idx, self.doubleClickArg1)
	end
end

----[[
--	Shows information if mouse is over the selected item
----]]
--local function _OnEnterItem(but)
--	if (but.item) then
--		GameTooltip:SetOwner(but, "ANCHOR_RIGHT")
--		GameTooltip.itemCount = but.item.count
--		GameTooltip:SetHyperlink(but.item.itemLink)
--	end
--end

local function _PositionCell(self, cell, prev)
	if (prev) then
		cell.frame:SetPoint("TOPLEFT", prev, "TOPRIGHT", GAP, 0)
	else
		cell.frame:SetPoint("TOPLEFT", self.firstGap, 0)
	end
end

local function _CreateRowFrame(self, parent, i)
	local row = CreateFrame("Button", nil, parent)
	table.insert(self.frameCache, row)
	self.rows[i] = row
	row.obj = self
	row.row = i
	row:SetHeight(self.rowHeight)
	row:SetWidth(self.width)
	row:SetPoint("TOPLEFT", 0, -((i - 1) * self.rowHeight + TOP_INSET))
	row:SetScript("OnDoubleClick", _RowDoubleClicked)
	row:SetScript("OnClick", function(but) _SelectedItem(but.obj, but.row) end)
	row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	
	local texture = row:CreateTexture()
	texture:SetTexture(SELECT_HIGHLIGHT)
	texture:SetWidth(self.minRowWidth)
	texture:SetHeight(self.rowHeight)
	texture:SetPoint("TOPLEFT", 0, 0) -- not the checkbox
	texture:SetTexCoord(0, 1.0, 0, 0.578125)
	row.selectHighlight = texture
	
	texture = row:CreateTexture()
	--texture:SetTexture("Interface\\HelpFrame\\HelpFrameButton-Highlight")
	texture:SetWidth(self.minRowWidth)
	texture:SetHeight(self.rowHeight)
	texture:SetPoint("TOPLEFT", 0, 0) -- not the checkbox
	texture:SetTexCoord(0, 1.0, 0, 0.578125)
	row:SetHighlightTexture(texture, "ADD")
	row.highlight = texture

	row.highlights = {}
	for k,v in pairs(self.highlights) do
    	texture = row:CreateTexture()
    	texture:SetTexture(NEUTRAL_HIGHLIGHT)
    	texture:SetWidth(self.minRowWidth)
    	texture:SetHeight(self.rowHeight)
    	texture:SetPoint("TOPLEFT", 0, 0) -- not the checkbox
    	texture:SetTexCoord(0, 1.0, 0, 0.578125)
    	texture:SetVertexColor(v.r, v.g, v.b, v.a)
    	table.insert(row.highlights, texture)
    end
	return row
end

--[[
	Creates the i'th row.
--]]
local function _CreateRow(self, parent, i)
	local prev = nil
	local row = _CreateRowFrame(self, parent, i)
	for _,col in pairs(self.cols) do
		if (col.type == "texture") then
			local cell = vendor.TextureCell:new(row, col.minWidth, self.rowHeight)
			if (col.normalTexture) then
				cell:SetNormalTexture(col.normalTexture)
				if (col.normalTexCoord) then
					cell:GetNormalTexture():SetTexCoord(unpack(col.normalTexCoord))
				end
			end
			if (col.pushedTexture) then
				cell:SetPushedTexture(col.pushedTexture)
				if (col.pushedTexCoord) then
					cell:GetPushedTexture():SetTexCoord(unpack(col.pushedTexCoord))
				end
			end
			cell:SetUpdateCallback(col.updateCallback)
			cell:SetClickCallback(col.clickCallback)
			cell:SetTooltip(col.tooltip)
			cell:SetArg(col.arg)
			table.insert(self.frameCache, cell.frame)
			_PositionCell(self, cell, prev)
			self.cells[i.."-"..col.id] = cell
			prev = cell.frame
		elseif (col.type == "text") then
			local cell = vendor.TextCell:new(row, col.minWidth, self.rowHeight, col.align)
			cell.frame.itemTableObj = self
			cell.frame.itemTableRow = i
			cell.frame.itemTableRowFrame = row
			-- we have to catch the click here
--			cell.frame:SetScript("OnClick", function(but) _SelectedItem(but.itemTableObj, but.itemTableRow) end)
--			cell.frame:SetScript("OnDoubleClick", function(but) _RowDoubleClicked(but.itemTableRowFrame) end)
--			cell.frame:RegisterForClicks("LeftButton", "RightButton")
			cell.frame:EnableMouse(false)
			_PositionCell(self, cell, prev)
			self.cells[i.."-"..col.id] = cell
			prev = cell.frame
		elseif (col.type == "number") then
			local cell = vendor.TextCell:new(row, col.minWidth, self.rowHeight, col.align)
			cell.frame.itemTableObj = self
			cell.frame.itemTableRow = i
			cell.frame.itemTableRowFrame = row
			-- we have to catch the click here
--			cell.frame:SetScript("OnClick", function(but) _SelectedItem(but.itemTableObj, but.itemTableRow) end)
--			cell.frame:SetScript("OnDoubleClick", function(but) _RowDoubleClicked(but.itemTableRowFrame) end)
--			cell.frame:RegisterForClicks("LeftButton", "RightButton")
			cell.frame:EnableMouse(false)
			_PositionCell(self, cell, prev)
			self.cells[i.."-"..col.id] = cell
			prev = cell.frame
		else
			error("unknown column type: "..(col.type or "NA"))
		end
	end
end

--[[
	Creates the sort buttons.
--]]
local function _CreateSortButtons(self, parent)
	log:Debug("_CreateSortButtons parent: %s name: %s", parent, self.name)
   	self.sortFrame = CreateFrame("Frame", nil, parent)
	table.insert(self.frameCache, self.sortFrame)
	-- create a backdrop for the sort buttons
	local noBackground = self.upperList or self.cfg.size == 100
	log:Debug("upperList: %s size: %s noBackground: %s", self.upperList, self.cfg.size, noBackground)
	if (not noBackground) then
		-- create a solid background
		log:Debug("create background")
    	local frame = CreateFrame("Frame", nil, self.sortFrame)
		frame:SetWidth(self.width - SCROLLER_WIDTH)
		frame:SetHeight(SORT_HEIGHT)
		frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 0)
		local texture = frame:CreateTexture()
		texture:SetAllPoints(frame)
		vendor.GuiTools.SetColor(texture, CMDS_BACKGROUND)
		table.insert(self.frameCache, frame)
	end
	
	local prev = nil
	local off = 0
	local id = vendor.GuiTools.GetNextId()
	for idx,col in pairs(self.cols) do
		local name = "AMItmTblSrtBt"..id.."-"..idx
		local but = CreateFrame("Button", name, self.sortFrame, "AuctionSortButtonTemplate")
		table.insert(self.frameCache, but)
		but:SetText(col.title)
		if (prev) then
			but:SetPoint("TOPLEFT", prev, "TOPRIGHT", 0, 0)
		else
			but:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 0)
		end
		but:SetWidth(col.minWidth)
		but:SetHeight(SORT_HEIGHT)
		but.sortId = col.id
		but:SetScript("OnClick", function(but) _ToggleSort(but.obj, but, but.sortId) end)
		
		but.obj = self
		col.sortButton = but
		prev = but
		if (not col.title or not col.sortable) then
			-- it has to be created for correct sizing
			but:Hide()
		end
	end
end

--[[
	Creates the list of cmds in the footer.
--]]
local function _CreateCmds(self)
	log:Debug("_CreateCmds")
	if (#self.cmds > 0) then
    	local frame = CreateFrame("Frame", nil, self.innerFrame)
    	frame:SetWidth(self.width)
    	frame:SetHeight(CMD_HEIGHT)
    	frame:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", 0, 0)
    	frame:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", 0, 0)
    	self.cmdFrame = frame
    	-- create a solid background
    	local texture = frame:CreateTexture()
    	texture:SetAllPoints(frame)
    	vendor.GuiTools.SetColor(texture, CMDS_BACKGROUND)
    	-- calc (right) width
    	local width = 0
    	for k,cmd in pairs(self.cmds) do
    		cmd.width = cmd.width or CMD_WIDTH
    		if (not cmd.alignLeft) then
    			width = width + cmd.width
    		end
    	end
    	-- create buttons
    	for i=1,2 do
    		local off = 0
    		local diffMul = 1
    		if (i == 2) then
    			off = width
    			diffMul = -1
    		end
        	for k,cmd in pairs(self.cmds) do
        		if ((i == 1 and cmd.alignLeft) or (i == 2 and not cmd.alignLeft)) then
            		local but = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
            		but:SetText(cmd.title)
            		but:SetWidth(cmd.width)
            		but:SetHeight(CMD_HEIGHT)
            		but:SetMotionScriptsWhileDisabled(true) -- want to see tooltips, even if disabled
            		if (cmd.alignLeft) then
            			but:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", off, 0)
            		else
            			but:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", -off, 0)
            		end
            		but.func = cmd.func
            		but.arg1 = cmd.arg1
            		but.enabledFunc = cmd.enabledFunc
            		if (cmd.tooltip) then
            			vendor.GuiTools.AddTooltip(but, cmd.tooltip)
            		end
            		but:SetScript("OnClick", function(but) but.func(but.arg1) end)
            		but:SetScript("OnUpdate", function(but)
            				if (but.enabledFunc) then
            					if (but.enabledFunc(but.arg1)) then
            						but:Enable()
            					else
            						but:Disable()
            					end
            				end
            			end)
            		off = off + diffMul * cmd.width
            	end
        	end
        end
	end
end

local function _LayoutScrollFrame(self)
	self.scrollFrame:ClearAllPoints()
	self.scrollFrame:SetWidth(self.width - SCROLLER_WIDTH)
	self.scrollFrame:SetPoint("TOPRIGHT", self.innerFrame, "TOPRIGHT", -SCROLLER_WIDTH - 3, -1)
end

local function _CreateScrollFrame(self)
	local id = vendor.GuiTools.GetNextId()
	local name = "AuctionMasterItemTableScroll"..id
	local scroll = CreateFrame("ScrollFrame", name, self.innerFrame, "FauxScrollFrameTemplate")
	self.scrollFrame = scroll
	scroll.obj = self
	_LayoutScrollFrame(self)
	scroll:SetScript("OnVerticalScroll", function(but, value) FauxScrollFrame_OnVerticalScroll(but, value, but.obj.rowHeight, _ScrollUpdate) end)
	scroll:SetScript("OnShow", function(but) _ScrollUpdate(but) end)
	local scrollbar = getglobal(name.."ScrollBar")
	local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND")
	scrollbg:SetAllPoints(scrollbar)
	vendor.GuiTools.SetColor(scrollbg, CMDS_BACKGROUND)
	self.scrollbar = scrollbar
end

--[[
	Creates the frame of the table, according to the model and config.
--]]
local function _CreateFrame(self)
	local frame = CreateFrame("Frame", nil, self.parent)
	frame:SetWidth(self.width)
	local innerFrame = CreateFrame("Frame", nil, frame)
	innerFrame:SetPoint("TOPLEFT", 0, -SORT_HEIGHT)
	innerFrame:SetWidth(self.width)
	-- adds a solid background
	local texture = innerFrame:CreateTexture()
	texture:SetAllPoints(innerFrame)
	vendor.GuiTools.SetColor(texture, FRAME_BACKGROUND)
	self.statusTextFrame = CreateFrame("Frame", nil, innerFrame)
	self.statusTextFrame:SetWidth(100)
	self.statusTextFrame:SetHeight(16)
	self.statusTextFrame:SetPoint("CENTER")
	self.statusText = self.statusTextFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	self.statusText:SetPoint("CENTER")
	self.frame = frame
	self.innerFrame = innerFrame
	_CreateScrollFrame(self)
end

local function _SetHeight(self)
	self.height = self.totalHeight * (self.cfg.size / 100.0)
	self.frame:SetHeight(self.height)
	local height = self.height - SORT_HEIGHT
	self.innerFrame:SetHeight(height)
	if (#self.cmds > 0) then
		height = self.height - SORT_HEIGHT - CMD_HEIGHT
	end
	self.scrollFrame:SetHeight(height)
--	self.scrollTexture1:SetHeight(height)
--	self.scrollTexture2:SetHeight(height)
end

--[[
	Layouts the table with the current settings.
--]]
local function _Layout(self)
	for _,v in pairs(self.frameCache) do
		vendor.GuiTools.ReleaseFrame(v)
	end
	wipe(self.frameCache)
	wipe(self.rows)
	local numCols = 0
	for id,_ in pairs(self.cfg.selected) do
		numCols = numCols + 1
	end
	if (self.cfg.size == 0) then
		self.frame:Hide()
	else
		self.frame:Show()
		self.frame:SetWidth(self.width)
		self.innerFrame:SetWidth(self.width)
		if (self.cmdFrame) then
			self.cmdFrame:SetWidth(self.width)
		end
		_LayoutScrollFrame(self)
    	_SetHeight(self)
    	if (self.upperList) then
    		self.frame:SetPoint("TOPLEFT", self.xOff, self.yOff)
    	else
    		local diff = self.totalHeight * ((100 - self.cfg.size) / 100.0)
    		self.frame:SetPoint("TOPLEFT", self.xOff, self.yOff - diff)
    	end
    	local height = self.height - SORT_HEIGHT - TOP_INSET
    	if (#self.cmds > 0) then
    		height = self.height - SORT_HEIGHT - CMD_HEIGHT - TOP_INSET
    	end
    	self.numVisibleItems = math.floor(height / self.cfg.rowHeight)
    	self.rowHeight = math.floor(height / self.numVisibleItems)
    	if (numCols > 0) then
    		_CreateColumns(self)
        	_CreateSortButtons(self, self.frame)
        	-- visible rows	
        	self.cells = wipe(self.cells or {})
        	for i=1,self.numVisibleItems do
        		_CreateRow(self, self.innerFrame, i)
        	end
        	_ScrollUpdate(self.scrollFrame)
        end
    end
end

--[[
	Returns the given value for the popup menu
--]]
local function _GetValue(info, key)
	log:Debug("_GetValue arg: %s passValue: %s", info.arg, info.passValue)
	if ("rowHeight" == info.passValue) then
		return info.arg.cfg.rowHeight == key
	elseif ("size" == info.passValue) then
		return info.arg.cfg.size == key
	end
	return nil
end

--[[
	Sets the given value from the popup menu.
--]]
local function _SetValue(info, value, key)
	log:Debug("_SetValue arg: %s passValue: %s value: %s key: %s", info.arg, info.passValue, value, key)
	if ("rowHeight" == info.passValue and value) then
		info.arg.cfg.rowHeight = key
		_Layout(info.arg)
	elseif ("size" == info.passValue) then
		info.arg.cfg.size = key
		if (info.arg.resizeFunc) then
			info.arg.resizeFunc(info.arg, info.arg.resizeArg, key)
		end
		_Layout(info.arg)
	end
end

--[[
	Adds or removes the id info.passValue in the list info.arg.cfg.selected 
	A map id => bool would be simpler, but it doesn't function in SavedVariables!?
--]]
local function _SetColSelection(info, value)
	log:Debug("_SetColSelection value: %s passValue: %s selected: %s", value, info.passValue, info.arg.cfg.selected)
	if (value) then
		for i=1,#info.arg.cfg.selected do
			if (info.arg.cfg.selected[i] == info.passValue) then
				return;
			end
		end
		table.insert(info.arg.cfg.selected, info.passValue)
	else
		for i=1,#info.arg.cfg.selected do
			if (info.arg.cfg.selected[i] == info.passValue) then
				table.remove(info.arg.cfg.selected, i)
				break
			end
		end
	end
	_Layout(info.arg) 
end

local function _GetColSelection(info)
	for i=1,#info.arg.cfg.selected do
		if (info.arg.cfg.selected[i] == info.passValue) then
			return true
		end
	end
	return false
end

--[[
	Creates the popup menu for configuring the table.
--]]
local function _CreatePopupMenu(self, resizeFunc, resizeArg)
    local cmds = {
    	rowHeights = {
    		type = "group",
    		text = "Row height",
    		key = "RowHeight",
			values = {},
			order = 110,
    		args = {
    			rowHeight = {
            		type = "multiselect",
            		get = _GetValue,
            		set = _SetValue,
            		arg = self,
            		passValue = "rowHeight",
            		order = 1,
            		values = {
           				[10] = L["Tiny"],
           				[14] = L["Very small"],
           				[18] = L["Small"],
           				[22] = L["Medium"],
           				[26] = L["Large"],
           				[30] = L["Extra large"]
            		}
            	}
    		}
    	}
    }
    if (self.sizable) then
    	cmds.size = {
    		type = "group",
    		text = L["Size"],
    		key = "Size",
			values = {},
			order = 100,
    		args = {
    			rowHeight = {
            		type = "multiselect",
            		get = _GetValue,
            		set = _SetValue,
            		arg = self,
            		passValue = "size",
            		order = 1,
            		values = {
           				[0] = L["Deactivated"],
           				[30] = "30%",
           				[40] = "40%",
           				[50] = "50%",
           				[60] = "60%",
           				[70] = "70%",
           				[100] = "100%",
            		}
            	}
    		}
    	}
    end
    -- create menus for the possible columns
    cmds.columns = {
   		type = "group",
   		text = L["Columns"],
   		key = "columns",
		values = {},
		order = 99,
		args = {}
	}
    for i=1,30 do
		local desc = self.model:GetColumnDescriptor(i)
		if (desc) then
			local info = {
				type = "toggle",
				text = desc.title,
				order = desc.order,
				get = _GetColSelection,
				set = _SetColSelection,
				arg = self,
				passValue = i
			}
			table.insert(cmds.columns.args, info)
    	end
	end

    for k,v in ipairs(self.menuCmds) do
    	cmds[k] = v
    end
    
	self.menu = vendor.PopupMenu:new("ItemTableMenu"..self.name, cmds, self)
	local menuBut = CreateFrame("Button", nil, self.frame)
	self.menuBut = menuBut
	menuBut.menu = self.menu
	menuBut:SetWidth(POPUP_BUT_WIDTH)
	menuBut:SetHeight(POPUP_BUT_WIDTH)
	menuBut:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", 0, 0)
	menuBut:SetScript("OnClick", function(but) but.menu:Show() end)
	
	-- found this nice texture in "Bagnon"	
	local texture = menuBut:CreateTexture()
	texture:SetTexture("Interface\\Buttons\\UI-Quickslot-Depress")
	texture:SetAllPoints(menuBut)
	menuBut:SetPushedTexture(texture)

	texture = menuBut:CreateTexture()
	texture:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
	texture:SetAllPoints(menuBut)
	menuBut:SetHighlightTexture(texture)

	texture = menuBut:CreateTexture()
	texture:SetAllPoints(menuBut)
	texture:SetTexture("Interface\\Icons\\Trade_Engineering")
end

--[[
	The model has been updated.
--]]
local function _ModelUpdated(self)
	if (self.innerFrame:IsVisible()) then
		_ScrollUpdate(self.scrollFrame)
	end
end

--[[
	Initializes the table.
--]]
local function _Init(self)
	log:Debug("_Init name: %s", self.name)
	self.frameCache = {}
	self.selectedCache = {}
	_CreateFrame(self)
	_CreateCmds(self)
	_Layout(self)
	_CreatePopupMenu(self)
	if (self.model.RegisterUpdateListener) then
		self.model:RegisterUpdateListener(_ModelUpdated, self)
	end
	log:Debug("_Init name: %s exit", self.name)
end

--[[
	Creates a new instance.
--]]
function vendor.ItemTable:new(info)
	log:Debug("new")
	local instance = setmetatable({}, self.metatable)
	instance.parent = info.parent
	instance.rows = {}
	instance.model = info.itemModel
	instance.cfg = info.config
	instance.cfg.size = info.config.size or 100 
	instance.width = info.width
	instance.totalHeight = info.height
	instance.xOff = info.xOff
	instance.yOff = info.yOff
	instance.cmds = info.cmds or {}
	instance.menuCmds = info.menuCmds or {}
	instance.name = info.name
	instance.sizable = info.sizable
	instance.upperList = info.upperList
    instance.resizeFunc = info.resizeFunc
    instance.resizeArg = info.resizeArg
    instance.highlights = {}
    _RemoveDuplicateColumns(instance)
	_Init(instance)
	return instance
end


--[[
	Creates a default config for an ItemTable. The arguments are the column ids to be selected.
--]]
function vendor.ItemTable.CreateConfig(...)
	local config = {}
	config.rowHeight = 15
	config.selected = {}
	for i=1,select('#', ...) do
		local id = select(i, ...)
		vendor.Vendor:Debug("add id %d", id)
		table.insert(config.selected, id) 
	end
	return config
end

function vendor.ItemTable.prototype:IsVisible()
	return self.innerFrame:IsVisible()
end

--[[
	Shows the frame.
--]]
function vendor.ItemTable.prototype:Show()
	self.innerFrame:Show()
	self.menuBut:Show()
	if (self.sortFrame) then
		self.sortFrame:Show()
	end
	if (self.cmdFrame) then
		self.cmdFrame:Show()
	end
	self:Update()
end

--[[
	Updates the frame.
--]]
function vendor.ItemTable.prototype:Update()
	_ScrollUpdate(self.scrollFrame)
end

--[[
	Hides the frame.
--]]
function vendor.ItemTable.prototype:Hide(showMenu)
	self.innerFrame:Hide()
	if (self.sortFrame) then
		self.sortFrame:Hide()
	end
	if (self.cmdFrame) then
		self.cmdFrame:Hide()
	end
	if (not showMenu) then
		self.menuBut:Hide()
	else
		self.menuBut:Show()
	end
end

--[[
	Sets a callback function for doubleclicks. It will receive the index of the double
	clicked row and the given argument.
--]]
function vendor.ItemTable.prototype:SetDoubleClickCallback(func, arg1)
	self.doubleClickFunc = func
	self.doubleClickArg1 = arg1
end

--[[
	Sets a new percentage size from 0 up to 100 for the table.
--]]
function vendor.ItemTable.prototype:SetSize(size)
	self.cfg.size = size
	_Layout(self)
end

--[[
	Sets the desired size and position of the table.
--]]
function vendor.ItemTable.prototype:SetDimensions(width, height, xOff, yOff)
	self.width = width
	self.totalHeight = height
	self.xOff = xOff
	self.yOff = yOff
	_Layout(self)
end

--[[
	Sets a status text, that will fade out.
--]]
function vendor.ItemTable.prototype:SetFadingText(msg, fadeTime)
	self.statusTextFrame:SetAlpha(1)
	self.statusText:SetText(msg)
	UIFrameFadeOut(self.statusTextFrame, fadeTime or 3, 1, 0)
end

--[[
	Deselects all items and returns the number of items involved.
--]]
function vendor.ItemTable.prototype:DeselectAll()
	local deselected = 0
	for i=1,self.model:Size() do
		if (self.model:IsSelected(i)) then
			deselected = deselected + 1
			self.model:SelectItem(i, false)
		end
	end
	return deselected
end

--[[
	Adds a new highlight texture to the table with the given color. The index of the highlight will
	be returned. This is the value that ItemModel:GetHighlight should return, ify any.
--]]
function vendor.ItemTable.prototype:AddHighlight(r, g, b, a)
	table.insert(self.highlights, {r = r, g = g, b = b, a = a})
	_Layout(self)
	return #self.highlights 
end
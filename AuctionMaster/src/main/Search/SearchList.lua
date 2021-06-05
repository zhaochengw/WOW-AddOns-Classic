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

vendor.SearchList = {}
vendor.SearchList.prototype = {}
vendor.SearchList.metatable = {__index = vendor.SearchList.prototype}

local log = vendor.Debug:new("SearchList")
local L = vendor.Locale.GetInstance()

local ROW_WIDTH = 156
local ROW_HEIGHT = 16
local SCROLLBAR_WIDTH = 16
local VISIBLE_ITEMS = 10
local CHECK_SIZE = 22

--local SCROLLBAR_BACKGROUND_COLOR = {r = 0.12, g = 0.12, b = 0.12, a = 0.8}

local SELECT_HIGHLIGHT = "Interface\\Addons\\AuctionMaster\\src\\resources\\Highlight1"

local MAX_ID = 2147483647

StaticPopupDialogs["SearchListAdd"] = {
	text = L["Add a new search"],
  	button1 = ADD,
  	button2 = CANCEL,
  	OnShow = function (self, data)
    	self.editBox:SetText(UNKNOWN)
    	self.editBox:HighlightText()
	end,
  	OnAccept = function(self, data)
    	  --print("Add ["..self.editBox:GetText().."]")
    	  data:Add(self.editBox:GetText())
  	end,
  	timeout = 0,
  	whileDead = true,
  	hideOnEscape = true,
  	hasEditBox = true,
  	enterClicksFirstButton = true,
  	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

StaticPopupDialogs["SearchListRename"] = {
	text = L["Rename a saved search"],
  	button1 = SAVE,
  	button2 = CANCEL,
  	OnShow = function(self, data)
  		log:Debug("OnShow data [%s]", data)
  		local text = UNKNOWN
  		log:Debug("selectedIndex [%s]", data.selectedIndex)
  		if (data.selectedIndex) then
  			local infos = vendor.Scanner.db.factionrealm.searchInfos
    		local info = infos[data.selectedIndex]
    		text = info.saveName or UNKNOWN
  		end
    	self.editBox:SetText(text)
	end,
  	OnAccept = function(self, data)
  		log:Debug("OnAccept")
    	  --print("Add ["..self.editBox:GetText().."]")
    	  if (data.selectedIndex) then
    	  		local infos = vendor.Scanner.db.factionrealm.searchInfos
    	  		local info = infos[data.selectedIndex]
    	  		info.saveName = self.editBox:GetText()
    	  		data:Update()
    	  end
  	end,
  	timeout = 0,
  	whileDead = true,
  	hideOnEscape = true,
  	hasEditBox = true,
  	enterClicksFirstButton = true,
  	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

local function _MigrateSnipes(self)
	if (not vendor.Scanner.db.factionrealm.oldSnipesMigrated) then
		for k, v in pairs(vendor.Sniper:GetSnipes()) do
			if (k and strlen(k) > 0) then
				local maxBidStr, maxBuyoutStr = strsplit(":", v)
				local bid
				local buyout
				local maxPrice
				if (maxBidStr and strlen(maxBidStr) > 0) then
					maxPrice = tonumber(maxBidStr)
					bid = true
				end
				if (maxBuyoutStr and strlen(maxBuyoutStr) > 0) then
					maxPrice = tonumber(maxBuyoutStr)
					buyout = true
				end
				local info = {saveName = k, name = k, maxPrice = maxPrice, bid = bid, buyout = buyout, snipe = true, classIndex = 0, subclassIndex = 0, rarity = 0, minLevel = 0, maxLevel = 0} 
				self:SaveSearchInfo(info)
				log:Debug("migrate [%s] [%s] [%s]", k, maxBidStr, maxBuyoutStr)
			end
		end
		vendor.Scanner.db.factionrealm.oldSnipesMigrated = true
	end
end

local function _GetSearchInfo(infos, index, snipesOnly)
	if (snipesOnly) then
		local snipes = 0
		local n = #infos
		for i = 1, n do
			if (infos[i].snipe) then
				snipes = snipes + 1
				if (snipes == index) then
					return infos[i]
				end
			end
		end
	end
	return infos[index]
end

local function _OnScrollFrameUpdate(scrollFrame)
	log:Debug("_OnScrollFrameUpdate")
	local self = scrollFrame.obj
	
	local infos = vendor.Scanner.db.factionrealm.searchInfos
	local n = #infos
	if (self.snipesOnly) then
		local off = 0
		for i = 1, n do
			if (infos[i].snipe) then
				off = off + 1
			end
		end
		n = off 
	end
	
	local offset = FauxScrollFrame_GetOffset(scrollFrame)
	local isScrolling = n > VISIBLE_ITEMS
	for i = 1, VISIBLE_ITEMS do
		local index = offset + i
		local row = self.rows[i]
		if (index > n) then
			row:Hide()
		else
			row:Show()
			if (isScrolling) then
				row.text:SetWidth(ROW_WIDTH - SCROLLBAR_WIDTH - CHECK_SIZE)
				row.highlight:SetWidth(ROW_WIDTH - SCROLLBAR_WIDTH)
				row.selectHighlight:SetWidth(ROW_WIDTH - SCROLLBAR_WIDTH)
			else
				row.text:SetWidth(ROW_WIDTH - CHECK_SIZE)
				row.highlight:SetWidth(ROW_WIDTH)
				row.selectHighlight:SetWidth(ROW_WIDTH)
			end
			local info = _GetSearchInfo(infos, index, self.snipesOnly)
			if (index == self.selectedIndex) then
				row.selectHighlight:Show()
			else
				row.selectHighlight:Hide()
			end
			if (info.snipe) then
				row.check:SetChecked(true)
			else
				row.check:SetChecked(false)
			end
			row.label:SetText(info.saveName)
		end
	end
	FauxScrollFrame_Update(self.scrollFrame, n, VISIBLE_ITEMS, ROW_HEIGHT)
end

local function _OnCheckClick(check)
	log:Debug("OnCheckClick")
	local self = check.obj
	local offset = FauxScrollFrame_GetOffset(self.scrollFrame) or 0
	local index = check.id + offset
	local infos = vendor.Scanner.db.factionrealm.searchInfos
	if (index >= 1 and index <= #infos) then
		local info = infos[index]
		if (info.snipe) then
			info.snipe = nil
		else
			info.snipe = true
		end
		log:Debug("snipe [%s]", info.snipe)
	end
	log:Debug("update")
	self:Update()
end

local function _OnClick(row, doubleClick)
	local self = row.obj
	
	local offset = FauxScrollFrame_GetOffset(self.scrollFrame) or 0
	local index = row.id + offset
	local infos = vendor.Scanner.db.factionrealm.searchInfos
	if (index >= 1 and index <= #infos) then
		self.searchTab:SelectSearchInfo(infos[index], doubleClick)
	end
	self.selectedIndex = index
	self:Update()
end

local function _OnRowClick(row)
	_OnClick(row)
end

local function _OnRowDoubleClick(row)
	_OnClick(row, true)
end

local function _OnDeleteClick(button)
	local self = button.obj
	if (self.selectedIndex) then 
		local infos = vendor.Scanner.db.factionrealm.searchInfos
		tremove(infos, self.selectedIndex)
		self.selectedIndex = nil
	end
	self:Update()
end

local function _OnUpClick(button)
	local self = button.obj
	if (self.selectedIndex and self.selectedIndex > 1) then
		local infos = vendor.Scanner.db.factionrealm.searchInfos
		local tmp = infos[self.selectedIndex - 1] 
		infos[self.selectedIndex - 1] = infos[self.selectedIndex]
		infos[self.selectedIndex] = tmp
		self.selectedIndex = self.selectedIndex - 1
		self:Update()
	end
end

local function _OnDownClick(button)
	local self = button.obj
	local infos = vendor.Scanner.db.factionrealm.searchInfos
	if (self.selectedIndex and self.selectedIndex < getn(infos)) then
		local tmp = infos[self.selectedIndex + 1] 
		infos[self.selectedIndex + 1] = infos[self.selectedIndex]
		infos[self.selectedIndex] = tmp
		self.selectedIndex = self.selectedIndex + 1
		self:Update()
	end
end

local function _OnAddClick(button)
	local self = button.obj
end

local function _OnUpdateFrame(frame)
	local self = frame.obj
	local infos = vendor.Scanner.db.factionrealm.searchInfos
	local n = getn(infos)
	if (self.selectedIndex) then
		local info = infos[self.selectedIndex]
		self.delete:Enable()
		self.rename:Enable()
		if (self.selectedIndex > 1) then
			self.up:Enable()
		else
			self.up:Disable()
		end
		if (self.selectedIndex < n) then
			self.down:Enable()
		else
			self.down:Disable()
		end
		if (self.searchTab:DiffSearchInfo(info)) then
			self.save:Enable()
		else
			self.save:Disable()
		end
	else
		self.up:Disable()
		self.down:Disable()
		self.delete:Disable()
		self.save:Disable()
		self.rename:Disable()
	end
end

local function _Save(frame)
	local self = frame.obj
	if (self.selectedIndex) then
		local infos = vendor.Scanner.db.factionrealm.searchInfos
		local info = infos[self.selectedIndex]
		self.searchTab:FillSearchInfo(info)
	end
end
local function _InitFrame(self)
	log:Debug("_InitFrame")
	
	local frame = vendor.backdropFrame(CreateFrame("Frame", nil, vendor.SearchTab.frame))
	frame.obj = self
	frame:SetWidth(165)
	frame:SetHeight(170)
	frame:SetPoint("TOPLEFT", 19, -134)
	frame:SetScript("OnUpdate", _OnUpdateFrame)
	
	-- background
	frame:SetBackdrop({bgFile = BACKGROUND_TEXTURE,
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 }})
	frame:SetBackdropColor(0, 0, 0, 1);
	frame:SetBackdropBorderColor(1, 1, 1, 1);
	local texture = frame:CreateTexture(nil, "BACKGROUND")
	texture:SetAllPoints(frame)
	texture:SetTexture(0, 0, 0, 1)

	-- scroll frame
	local name = vendor.GuiTools.EnsureName()
	local scrollFrame = CreateFrame("ScrollFrame", name, frame, "FauxScrollFrameTemplate")
	scrollFrame.obj = self
	--scrollFrame:ClearAllPoints()
	scrollFrame:SetWidth(133)
	scrollFrame:SetHeight(frame:GetHeight() - 7)
	scrollFrame:SetPoint("TOPLEFT", frame, 6, -4)
	scrollFrame:SetScript("OnVerticalScroll", function(this, value) FauxScrollFrame_OnVerticalScroll(this, value, ROW_HEIGHT, _OnScrollFrameUpdate) end)
	scrollFrame:SetScript("OnShow", _OnScrollFrameUpdate)
	
--	local scrollbar = _G[name.."ScrollBar"]
--	local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND")
--	scrollbg:SetAllPoints(scrollbar)
--	vendor.GuiTools.SetColor(scrollbg, SCROLLBAR_BACKGROUND_COLOR)
		
	-- rows
	local rows = {}
	local prev
	for i = 1, VISIBLE_ITEMS do
    	local row = CreateFrame("Frame", nil, frame)
    	row.id = i
    	row.obj = self
    	row:SetWidth(ROW_WIDTH)
    	row:SetHeight(ROW_HEIGHT)
--    	row:SetScript("OnClick", _OnRowClick)
--    	row:SetScript("OnDoubleClick", _OnRowDoubleClick)
    	if (prev) then
    		row:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, 0)
    	else
    		row:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT", 0, 0)
    	end
    	prev = row

    	local text = CreateFrame("Button", vendor.GuiTools.EnsureName(), row)
    	text.id = i
    	text.obj = self
		text:SetWidth(ROW_WIDTH - CHECK_SIZE)
    	text:SetHeight(ROW_HEIGHT)
    	text:SetScript("OnClick", _OnRowClick)
    	text:SetScript("OnDoubleClick", _OnRowDoubleClick)
    	text:SetPoint("TOPLEFT", 0, 0)
    	vendor.GuiTools.AddTooltip(text, L["Double-click for instant search"])
    	row.text = text
    	
    	local check = vendor.GuiTools.CreateCheckButton(nil, row, "UICheckButtonTemplate", CHECK_SIZE, CHECK_SIZE)
    	check.obj = self
    	check.id = i
		check:SetPoint("LEFT", text, "RIGHT", 0, 0)
		check:SetScript("OnClick", _OnCheckClick)
		vendor.GuiTools.AddTooltip(check, L["Activates the saved search for the scan"])
    	row.check = check
    	
    	local texture = text:CreateTexture()
    	texture:SetTexture("Interface\\HelpFrame\\HelpFrameButton-Highlight")
    	texture:SetWidth(ROW_WIDTH)
    	texture:SetHeight(ROW_HEIGHT)
    	texture:SetPoint("TOPLEFT", -4, 0)
    	texture:SetTexCoord(0, 1.0, 0, 0.578125)
    	text:SetHighlightTexture(texture, "ADD")
    	row.highlight = texture

    	local texture = text:CreateTexture()
    	texture:SetTexture(SELECT_HIGHLIGHT)
    	texture:SetWidth(ROW_WIDTH)
    	texture:SetHeight(ROW_HEIGHT)
    	texture:SetPoint("TOPLEFT", -4, 0)
    	texture:SetTexCoord(0, 1.0, 0, 0.578125)
    	texture:Hide()
    	row.selectHighlight = texture

    	local f = row.text:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
		f:SetAllPoints(row.text)
		f:SetJustifyH("LEFT")
		row.label = f
		
    	table.insert(rows, row)
	end

	local save = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	save.obj = self
	save:SetText(SAVE)
	save:SetWidth(70)
	save:SetHeight(20)
	save:SetPoint("TOPLEFT", 2, -frame:GetHeight() + 1)
	save:SetScript("OnClick", _Save)

	local rename = CreateFrame("Button", nil, frame)
	rename.obj = self
	rename:SetWidth(22)
	rename:SetHeight(22)
	rename:SetPoint("LEFT", save, "RIGHT", -2, 0)
	rename:SetScript("OnClick", function(button) local dialog = StaticPopup_Show("SearchListRename", nil, nil, button.obj); dialog.data = button.obj end)
	rename:SetNormalTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\Rename-Up")
	rename:SetPushedTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\Rename-Down")
	rename:SetDisabledTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\Rename-Disabled")
	rename:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight", "ADD")
	vendor.GuiTools.AddTooltip(rename, L["Rename a saved search"])

	local plus = CreateFrame("Button", nil, frame)
	plus.obj = self
	plus:SetWidth(22)
	plus:SetHeight(22)
	plus:SetPoint("LEFT", rename, "RIGHT", -3, 0)
	plus:SetScript("OnClick", function(button) local dialog = StaticPopup_Show("SearchListAdd"); dialog.data = button.obj end)
	plus:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
	plus:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
	plus:SetDisabledTexture("Interface\\Buttons\\UI-PlusButton-Disabled")
	plus:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight", "ADD")
	vendor.GuiTools.AddTooltip(plus, L["Add a new search"])

	local delete = CreateFrame("Button", nil, frame)
	delete.obj = self
	delete:SetWidth(37)
	delete:SetHeight(37)
	delete:SetPoint("LEFT", plus, "RIGHT", -12, -2)
	delete:SetScript("OnClick", _OnDeleteClick)
	delete:SetNormalTexture("Interface\\Buttons\\CancelButton-Up")
	delete:SetPushedTexture("Interface\\Buttons\\CancelButton-Down")
	delete:SetDisabledTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\CancelButton-Disabled")
	delete:SetHighlightTexture("Interface\\Buttons\\CancelButton-Highlight", "ADD")
	delete:SetHitRectInsets(9, 7, -7, 10)
	vendor.GuiTools.AddTooltip(delete, L["Delete a saved search"])
	
	local down = CreateFrame("Button", nil, frame)
	down.obj = self
	down:SetWidth(16)
	down:SetHeight(16)
	down:SetPoint("TOPLEFT", 146, -frame:GetHeight() - 3)
	down:SetScript("OnClick", _OnDownClick)
	down:SetNormalTexture("Interface\\Buttons\\Arrow-Down-Up")
	down:SetPushedTexture("Interface\\Buttons\\Arrow-Down-Down")
	down:SetDisabledTexture("Interface\\Buttons\\Arrow-Down-Disabled")

	local up = CreateFrame("Button", nil, frame)
	up.obj = self
	up:SetWidth(16)
	up:SetHeight(16)
	up:SetPoint("RIGHT", down, "LEFT", 2, 5)
	up:SetScript("OnClick", _OnUpClick)
	up:SetNormalTexture("Interface\\Buttons\\Arrow-Up-Up")
	up:SetPushedTexture("Interface\\Buttons\\Arrow-Up-Down")
	up:SetDisabledTexture("Interface\\Buttons\\Arrow-Up-Disabled")
	
	-- remember objects
	self.scrollFrame = scrollFrame
	self.rows = rows
	
	-- first update
	_OnScrollFrameUpdate(scrollFrame)
	
	self.frame = frame
	self.up = up
	self.down = down
	self.delete = delete
	self.save = save
	self.rename = rename
end

local function _InitClass(info)
	if (info.classIndex > 0) then
		info.class = select(info.classIndex, vendor.Items:GetAuctionItemClasses())
	else
		info.class = nil
	end
	if (info.classIndex > 0 and info.subclassIndex > 0) then
		info.subclass = select(info.subclassIndex, GetAuctionItemSubClasses(info.classIndex))
	else
		info.subclass = nil
	end
end

-- Calculate the fresh localizations of the class indices
local function _InitClasses(self)
	local infos = vendor.Scanner.db.factionrealm.searchInfos
	for i = 1, #infos do
		_InitClass(infos[i])
	end
end

function vendor.SearchList:new()
	local instance = setmetatable({}, self.metatable)
	instance.searchTab = vendor.SearchTab
	_InitClasses(instance)
	_InitFrame(instance)
	_MigrateSnipes(instance)
	return instance
end

function vendor.SearchList.prototype:SaveSearchInfo(info)
	log:Debug("SaveSearchInfo id [%s]", info.id)
	_InitClass(info)
	local infos = vendor.Scanner.db.factionrealm.searchInfos
	local handled
	if (not info.id) then
		info.id = math.random(MAX_ID)
		table.insert(infos, info)
		handled = true
	end
	if (not handled) then
    	for i = 1, #infos do
    		if (infos[i].id == info.id) then
    			infos[i] = info
    			handled = true
    			break
    		end
    	end
	end
	if (not handled) then
		table.insert(infos, info)
	end
	table.sort(vendor.Scanner.db.factionrealm.searchInfos, function(a,b)
			return a.saveName < b.saveName
		end
	)
	self:Update()
end

function vendor.SearchList.prototype:Update()
	_OnScrollFrameUpdate(self.scrollFrame)
end

function vendor.SearchList.prototype:SetSnipesOnly(snipesOnly)
	self.snipesOnly = snipesOnly
	self:Update()
end

function vendor.SearchList.prototype:Add(name)
	if (name and strlen(name) > 0) then
		log:Debug("Add [%s]", name)
		local infos = vendor.Scanner.db.factionrealm.searchInfos
		local info = {}
		info.id = math.random(MAX_ID)
		info.saveName = name
		tinsert(infos, info)
		self.searchTab:FillSearchInfo(info)
		self.selectedIndex = getn(infos)
		self:Update()
		log:Debug("exit")
	end
end
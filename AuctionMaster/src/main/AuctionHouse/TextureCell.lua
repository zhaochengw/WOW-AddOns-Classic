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
	Cell object for rendering textures. Input for the cell is:
	texture, itemLink, count
--]]
vendor.TextureCell = {}
vendor.TextureCell.prototype = {}
vendor.TextureCell.metatable = {__index = vendor.TextureCell.prototype}
setmetatable(vendor.TextureCell.prototype, {__index = vendor.ItemTableCell.prototype})

local log = vendor.Debug:new("TextureCell")

--[[
	Shows information if mouse is over the selected item
--]]
local function _OnEnterItem(but)
	local self = but.obj
	if (BattlePetTooltip and self.item) then
		local itemLink = self.item.itemLink
		-- check if we have a battle pet here
		local name, speciesId, level, breedQuality, maxHealth, power, speed = vendor.Items:GetBattlePetStats(itemLink)
		if (speciesId) then
			BattlePetToolTip_Show(speciesId, level, breedQuality, maxHealth, power, speed, name)
			BattlePetTooltip:ClearAllPoints()
			BattlePetTooltip:SetPoint("TOPLEFT", self.frame, "TOPRIGHT", 0, 0)
		else
			GameTooltip:SetOwner(but, "ANCHOR_RIGHT")
			GameTooltip.itemCount = self.item.count
			if (not vendor.Items:IsBattlePetLink(itemLink)) then
				GameTooltip:SetHyperlink(itemLink)
			end
		end
	elseif (self.tooltip) then
		GameTooltip_SetDefaultAnchor(GameTooltip, but) 
		--GameTooltip:SetOwner(but, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.tooltip, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1, true)
   		GameTooltip:Show()
	end
end

local function _OnClick(button)
	local self = button.obj
	if (self.clickCallback) then
		self.clickCallback(self, self.arg)
	end
end

--[[
	Initializes the cell.
--]]
local function _Init(self)
	local but = CreateFrame("Button", nil, self.parent)
	but.obj = self 
	but:SetScript("OnEnter", _OnEnterItem)
	but:SetScript("OnLeave", function(frame)
		if (BattlePetTooltip) then
			BattlePetTooltip:Hide()
		end
		GameTooltip:Hide()
	end)
	but:SetScript("OnClick", _OnClick)
	but:SetWidth(self.width)
	but:SetHeight(self.height)
	local fontHeight = 10
	if (self.height >= 19) then
		fontHeight = 11
	end
	local f = but:CreateFontString(nil, "OVERLAY")
	f:SetFont("Fonts\\ARIALN.TTF", fontHeight, "OUTLINE")
	f:SetJustifyH("RIGHT")
	f:SetPoint("BOTTOMRIGHT", 0, 2)
	self.frame = but
	self.count = f
end

--[[ 
	Creates a new instance.
--]]
function vendor.TextureCell:new(parent, width, height)
	local instance = setmetatable({}, self.metatable)
	instance.parent = parent
	instance.width = width
	instance.height = height
	_Init(instance)
	return instance
end

--[[
	Updates the cell with the required input parameters of the cell.
--]]
function vendor.TextureCell.prototype:Update(texture, itemLink, count)
	if (self.manual) then
		if (self.updateCallback) then
			self.updateCallback(self, self.arg, texture, itemLink, count)
		end
		return
	end
	assert(itemLink)
	assert(count)
	if (self.height >= 16) then
    	if (count > 1) then
    		self.count:SetText(count)
    	else
    		self.count:SetText(nil)
    	end
    else
    	self.count:SetText(nil)
    end
	self.frame:SetNormalTexture(texture)
	self.item = {count = count, itemLink = itemLink}
end

function vendor.TextureCell.prototype:SetNormalTexture(texture)
	log:Debug("SetNormalTexture %s", texture)
	self.manual = true
	self.frame:SetNormalTexture(texture)
end

function vendor.TextureCell.prototype:GetNormalTexture()
	return self.frame:GetNormalTexture()
end

function vendor.TextureCell.prototype:SetPushedTexture(texture)
	self.manual = true
	self.frame:SetPushedTexture(texture)
end

function vendor.TextureCell.prototype:SetUpdateCallback(updateCallback)
	self.updateCallback = updateCallback
	if (updateCallback) then
		self.manual = true
	end
end

function vendor.TextureCell.prototype:SetClickCallback(clickCallback)
	self.clickCallback = clickCallback
	if (clickCallback) then
		self.manual = true
	end
end

function vendor.TextureCell.prototype:GetPushedTexture()
	return self.frame:GetPushedTexture()
end

function vendor.TextureCell.prototype:SetHighlightTexture(texture, alphaMode)
	self.frame:SetHighlightTexture(texture, alphaMode)
end

function vendor.TextureCell.prototype:GetHighlightTexture()
	return self.frame:GetHighlightTexture()
end

function vendor.TextureCell.prototype:SetTooltip(tooltip)
	self.tooltip = tooltip
end

function vendor.TextureCell.prototype:SetArg(arg)
	self.arg = arg
end

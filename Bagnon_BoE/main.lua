--[[

	The MIT License (MIT)

	Copyright (c) 2025 Lars Norberg

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.

--]]
local Addon, Private =  ...
if (Private.Incompatible) then
	--print("|cffff1111"..Addon.." was auto-disabled.")
	return
end

local Bagnon = Bagnon or Bagnonium
local Module = Bagnon:NewModule(Addon, Private)

-- Lua API
local _G = _G
local ipairs = ipairs
local string_find = string.find

-- WoW API
local C_Container, C_TooltipInfo, TooltipUtil = C_Container, C_TooltipInfo, TooltipUtil
local CreateFrame, GetItemInfo, GetItemQualityColor = CreateFrame, GetItemInfo, GetItemQualityColor

-- Addon cache
local retail = Private.IsRetail
local wrath = Private.IsWrath
local cache = Private.cache
local tooltip = Private.tooltip
local tooltipName = Private.tooltipName

-- Font object
local font_object = NumberFont_Outline_Med or NumberFontNormal

-- Search patterns
local s_item_bound1 = ITEM_SOULBOUND
local s_item_bound2 = ITEM_ACCOUNTBOUND
local s_item_bound3 = ITEM_BNETACCOUNTBOUND

-- Localization.
-- *Just enUS so far.
local L = {
	["BoE"] = "BoE", -- Bind on Equip
	["BoU"] = "BoU"  -- Bind on Use
}

-- Custom color cache
-- Allows us control, gives us speed.
local colors = {
	[0] = { 157/255, 157/255, 157/255 }, -- Poor
	[1] = { 240/255, 240/255, 240/255 }, -- Common
	[2] = { 30/255, 198/255, 0/255 }, -- Uncommon
	[3] = { 0/255, 112/255, 221/255 }, -- Rare
	[4] = { 163/255, 53/255, 238/255 }, -- Epic
	[5] = { 225/255, 96/255, 0/255 }, -- Legendary
	[6] = { 229/255, 204/255, 127/255 }, -- Artifact
	[7] = { 79/255, 196/255, 225/255 }, -- Heirloom
	[8] = { 79/255, 196/255, 225/255 } -- Blizzard
}
for i = 0, (retail and Enum.ItemQualityMeta.NumValues or NUM_LE_ITEM_QUALITYS) - 1 do
	if (not colors[i]) then
		local r, g, b = GetItemQualityColor(i)
		colors[i] = { r, g, b }
	end
end

Module:AddUpdater(function(self)

	local db = BagnonBoE_DB
	local message, color, mult, _

	if (self.hasItem) then

		local quality, bind = self.info.quality, self.info.bind
		if (not bind and self.info.hyperlink) then
			_,_,_,_,_,_,_,_,_,_,_,_,_, bind = GetItemInfo(self.info.hyperlink)
		end

		-- Item is BoE or BoU, has it been bound to the player yet?
		-- *in retail, all items can bind now thanks to transmogs
		if (quality and ((retail and quality >= 0) or quality > 1)) and (bind == 2 or bind == 3) then

				local show = true
			local bag, slot = self:GetBag(), self:GetID()

			-- This has been added to the classics too now.
			local containerInfo = C_Container and C_Container.GetContainerItemInfo(bag,slot)
			if (containerInfo and containerInfo.isBound) then
				show = nil
			end

			-- Scan the tooltip to see if the item is bound.
			if (show) then

				if (retail) then

					local tooltipData = C_TooltipInfo.GetBagItem(bag,slot)
					if (tooltipData) then
						for i = 2,6 do
							local msg = tooltipData.lines[i] and tooltipData.lines[i].leftText
							if (not msg) then break end

							if (string_find(msg, s_item_bound1) or string_find(msg, s_item_bound2) or string_find(msg, s_item_bound3)) then
								show = nil
								break
							end
						end
					end

				else

					if (not tooltip.owner or not tooltip.bag or not tooltip.slot) then
						tooltip.owner, tooltip.bag,tooltip.slot = self, bag, slot
						tooltip:SetOwner(tooltip.owner, "ANCHOR_NONE")
						tooltip:SetBagItem(tooltip.bag, tooltip.slot)
					end

					for i = 2,6 do
						local line = _G[tooltipName.."TextLeft"..i]
						if (not line) then
							break
						end

						local msg = line:GetText() or ""
						if (string_find(msg, s_item_bound1) or string_find(msg, s_item_bound2) or string_find(msg, s_item_bound3)) then
							show = nil
							break
						end
					end

				end

			end

			-- Item isn't bound, decide the label
			if (show) then

				message = bind == 3 and L["BoU"] or L["BoE"]

				if (db.enableRarityColoring) then
					color = quality and colors[quality > 0 and quality or 1]
					mult = (quality ~= 3 and quality ~= 4 and quality ~= 0 and quality ~= 1) and .7
				end
			end

		end
	end

	if (message) then

		local label = cache[self]
		if (not label) then

			-- Only one container per item.
			local name = self:GetName().."ExtraInfoFrame"
			local container = _G[name]
			if (not container) then
				container = CreateFrame("Frame", name, self)
				container:SetAllPoints()
			end

			-- Always move this to the same place.
			local upgrade = self.UpgradeIcon
			if (upgrade) then
				upgrade:ClearAllPoints()
				upgrade:SetPoint("BOTTOMRIGHT", 2, 0)
			end

			-- This is specific to this plugin.
			label = container:CreateFontString()
			label:SetDrawLayer("ARTWORK", 1)
			label:SetPoint("BOTTOMLEFT", 2, 2)
			label:SetFontObject(font_object)
			label:SetFont(label:GetFont(), 12, "OUTLINE")
			label:SetShadowOffset(1, -1)
			label:SetShadowColor(0, 0, 0, .5)

			cache[self] = label
		end

		label:SetText(message)

		if (color) then
			if (mult) then
				label:SetTextColor(color[1] * mult, color[2] * mult, color[3] * mult)
			else
				label:SetTextColor(color[1], color[2], color[3])
			end
		else
			label:SetTextColor(.94, .94, .94)
		end

	elseif (cache[self]) then
		cache[self]:SetText("")
	end

end)

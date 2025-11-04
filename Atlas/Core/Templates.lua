--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert at gmail dot com>
	Copyright 2010 - Lothaer <lothayer at gmail dot com>, Atlas Team
	Copyright 2011 ~ 2023 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

local FOLDER_NAME, private = ...

local Templates = {}
private.Templates = Templates

-- AtlasFrameDropDownTypeTemplate
function Templates.CreateFrameDropDownType(name, parent)
	local f = _G[name] or CreateFrame("DropdownButton", name, parent, "WowStyle1DropdownTemplate")

	f:SetPoint("TOPLEFT", parent, 65, -44)
	f:SetWidth(ATLAS_DROPDOWN_WIDTH)
	f:SetPropagateMouseMotion(true)

	f.Label = f:CreateFontString(name.."Label", "BACKGROUND", "GameFontNormalSmall")
	f.Label:SetText(ATLAS_STRING_SELECT_CAT)
	f.Label:SetPoint("TOPLEFT", f, "TOPLEFT", 3, 14)

	return f
end

-- AtlasFrameDropDownTemplate
function Templates.CreateFrameDropDown(name, parent)
	local f = _G[name] or CreateFrame("DropdownButton", name, parent, "WowStyle1DropdownTemplate")

	local ref = parent and parent:GetName().."DropDownType" or nil

	f:SetPoint("LEFT", ref or nil, "RIGHT", 20, 0)
	f:SetWidth(ATLAS_DROPDOWN_WIDTH)
	f:SetPropagateMouseMotion(true)

	f.Label = f:CreateFontString(name.."Label", "BACKGROUND", "GameFontNormalSmall")
	f.Label:SetText(ATLAS_STRING_SELECT_MAP)
	f.Label:SetPoint("TOPLEFT", f, "TOPLEFT", 3, 14)

	return f
end

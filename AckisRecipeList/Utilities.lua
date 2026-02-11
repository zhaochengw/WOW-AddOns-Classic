--[[
Copyright (c) 2009 - 2012 Ackis <John Pasula>
All rights reserved by the original author Ackis.
]]

-- ----------------------------------------------------------------------------
-- Upvalued Lua API.
-- ----------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs
local tonumber = _G.tonumber
local type = _G.type

-- Libraries
local table = _G.table

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)

-- ----------------------------------------------------------------------------
-- Methods.
-- ----------------------------------------------------------------------------

-- Since GetExpansionLevel during pre-expansion patches will return the previous expansion's ID even though the new data is in...
local function GetEffectiveExpansionID()
    return tonumber(_G.GetBuildInfo():sub(1, 1))
end
private.GetEffectiveExpansionID = GetEffectiveExpansionID

function private.SetExpansionLogo(texture, expansionLevel)
	local logo = private.EXPANSION_LOGOS and private.EXPANSION_LOGOS[expansionLevel]
	if not logo then
		texture:Hide()
		return
	end
	if logo.texture then
		texture:SetTexture(logo.texture)
		texture:Show()
	elseif logo.atlas then
		texture:SetAtlas(logo.atlas)
		texture:Show()
	else
		texture:Hide()
	end
end

function private.SetTextColor(color_code, text)
	-- Guard against nil text and invalid color codes to avoid format errors on some clients
	local cc = "ffffff"
	if type(color_code) == "string" then
		-- keep only hex chars and at most 6 digits
		local hex = color_code:match("^[0-9a-fA-F]{6}") or color_code:gsub("[^0-9a-fA-F]", ""):sub(1, 6)
		if hex and #hex == 6 then
			cc = hex
		end
	end
	return ("|cff%s%s|r"):format(cc, tostring(text or ""))
end

function private.ItemLinkToID(item_link)
	if not item_link then
		return
	end
	return tonumber(item_link:match("item:(%d+)"))
end

-- This wrapper exists primarily because Blizzard keeps changing how NPC ID numbers are extracted from GUIDs, and fixing it in one place is less error-prone.
function private.MobGUIDToIDNum(guid)
	if not guid or type(guid) ~= "string" then
		return
	end
	-- Modern GUID: Creature-0-...-<id>
	if guid:find("-") then
		local _, _, _, _, _, id_num = ("-"):split(guid)
		return tonumber(id_num)
	end
	-- Classic hex GUID fallback (e.g., 0xF13000XXXXYY...)
	local hex = guid:gsub("^0x", "")
	if #hex >= 10 then
		return tonumber(hex:sub(6, 10), 16)
	end
	return tonumber(guid)
end

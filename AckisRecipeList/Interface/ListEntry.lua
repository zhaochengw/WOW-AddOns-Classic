--[[
Copyright (c) 2009 - 2012 Ackis <John Pasula>
All rights reserved by the original author Ackis.
]]

-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------

local string = _G.string

local tonumber = _G.tonumber
local tostring = _G.tostring

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)

-- ----------------------------------------------------------------------------
-- Creation.
-- ----------------------------------------------------------------------------
local list_entry_prototype = {}
local list_entry_meta = {
	__index = list_entry_prototype
}

local VALID_LIST_ENTRY_TYPES = {
	entry = true,
	header = true,
	subentry = true,
	subheader = true,
    title = true,
}

function private.CreateListEntry(listEntryType, parentListEntry, recipe)
	local listEntry = _G.setmetatable(private.AcquireTable(), list_entry_meta)
	listEntry.recipe = recipe

	if listEntryType and VALID_LIST_ENTRY_TYPES[listEntryType] then
		listEntry._type = listEntryType
	else
		addon:Debug("Attempting to set an entry's type to '%s'.", tostring(listEntryType))
		listEntry._type = "entry"
	end

	if parentListEntry then
		if parentListEntry ~= listEntry then
			listEntry.recipe = listEntry.recipe or parentListEntry.recipe
			listEntry.parent = parentListEntry
			listEntry:SetAcquireType(listEntry:AcquireType() or parentListEntry:AcquireType())
			listEntry:SetLocation(listEntry:Location() or parentListEntry:Location())
			listEntry:SetNPCID(listEntry:NPCID() or parentListEntry:NPCID())

			parentListEntry.children = parentListEntry.children or private.AcquireTable()
			parentListEntry.children[#parentListEntry.children + 1] = listEntry
		else
			addon:Debug("Attempting to parent an entry to itself.")
		end
	elseif listEntry._type ~= "header" and listEntry._type ~= "title" then
		addon:Debug("Non-header/title entry without a parent: %s", listEntry._type)
	end

	return listEntry
end

function list_entry_prototype:CollapseChildren()
    if self.children then
        local currentTab = addon.Frame.current_tab

        for index = 1, #self.children do
            local childEntry = self.children[index]
            currentTab:SaveListEntryState(childEntry, false)
            childEntry:CollapseChildren()
            childEntry._discard = true
        end
        private.ReleaseTable(self.children)
        self.children = nil
    end
end

-- ----------------------------------------------------------------------------
-- Methods.
-- ----------------------------------------------------------------------------
function list_entry_prototype:Emphasize(toggle)
	self._emphasized = toggle or nil
end

function list_entry_prototype:IsEmphasized()
	return self._emphasized
end

function list_entry_prototype:SetAcquireType(acquire_type)
	self._acquire_type = acquire_type
end

function list_entry_prototype:AcquireType()
	return self._acquire_type
end

function list_entry_prototype:SetLocation(location)
	self._location = location
end

function list_entry_prototype:Location()
	return self._location
end

function list_entry_prototype:SetNPCID(npc_id)
	self._npc_id = tonumber(npc_id)
end

function list_entry_prototype:NPCID()
	return self._npc_id
end

function list_entry_prototype:SetText(...)
	self._text = string.format(...)
end

function list_entry_prototype:Text()
	return self._text
end

function list_entry_prototype:Type()
	return self._type
end

function list_entry_prototype:IsEntry()
	return self._type == "entry"
end

function list_entry_prototype:IsHeader()
	return self._type == "header"
end

function list_entry_prototype:IsSubEntry()
	return self._type == "subentry"
end

function list_entry_prototype:IsSubHeader()
	return self._type == "subheader"
end

function list_entry_prototype:IsTitle()
    return self._type == "title"
end

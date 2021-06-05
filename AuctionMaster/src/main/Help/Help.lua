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
	Frame presentating the documentation and the release notes of AuctionMaster.
--]]

vendor.Help = vendor.Vendor:NewModule("Help");
local L = vendor.Locale.GetHelpInstance()
local AceGUI = LibStub("AceGUI-3.0")

local HTML_PREFIX = "<html><body>"
local HTML_SUFFIX = "<p/></body></html>"
local DOCUMENTATION = HTML_PREFIX..L["doc_1"]..L["doc_2"]..L["doc_3"]..L["doc_4"]..L["doc_5"]..L["doc_6"]..L["doc_7"]..HTML_SUFFIX

-- constants for the main sections
vendor.Help.DOCUMENTATION = "Documentation"

--[[
	Help group was selected.
--]]
local function _OnGroupSelected(widget, event, value)
	local self = widget.userdata.obj
 	if (value == self.DOCUMENTATION) then
 		self.html:SetText(DOCUMENTATION)
 		self.frame:SetStatusText(L["DocumentationStatus"])
 	else
 		local a, b = string.split("\001", value)
 		vendor.Vendor:Debug("selected %s", b)
 		self.html:SetText(HTML_PREFIX..L[b]..HTML_SUFFIX)
 		self.frame:SetStatusText(L["DocumentationSectionStatus"])
	end
end

--[[
	Creates the main frame for the documentation.
--]]
local function _CreateFrame(self)
	-- create root frame for the help window
	local f = AceGUI:Create("Frame")
	--f:SetCallback("OnClose", function(widget, event) AceGUI:Release(widget) end)
	f:SetTitle("AuctionMaster")
	f:SetLayout("Fill")
	
	-- create tree group for selecting sections
	local tree = { 
    	{value = "Documentation", text = L["Documentation"],
			children = {
    			{value = "doc_1", text = L["doc_1_title"]},
    			{value = "doc_2", text = L["doc_2_title"]},
    			{value = "doc_3", text = L["doc_3_title"]},
    			{value = "doc_4", text = L["doc_4_title"]},
    			{value = "doc_5", text = L["doc_5_title"]},
    			{value = "doc_6", text = L["doc_6_title"]},
    			{value = "doc_7", text = L["doc_7_title"]},
    		}
    	}
    }
	local t = AceGUI:Create("TreeGroup")
	t.userdata.obj = self
	t:SetLayout("Fill")
	t:SetTree(tree)
	t:SetCallback("OnGroupSelected", _OnGroupSelected)	
	local sh = AceGUI:Create("ScrollableSimpleHTML")
--	local text = "<html><body><h1>Lorem ipsum</h1><p>\ndolor sit amet, consectetuer adipiscing elit. Sed quis lacus. Mauris fringilla consequat velit. Aenean dolor libero, placerat nec, feugiat sed, tincidunt ac, leo. In hac habitasse platea dictumst. Aliquam non sem adipiscing massa sagittis suscipit. Pellentesque ultrices nisl at ante. Vestibulum dapibus. Nulla facilisi. Nullam lobortis dictum diam. Donec mollis augue ut nulla. Donec ullamcorper mauris sit amet erat. Vivamus ante augue, rutrum sit amet, iaculis sit amet, congue vel, risus. Sed magna. Sed a eros. Aenean sed orci nec sem dapibus fringilla. Donec id diam. Praesent adipiscing. Sed dignissim pellentesque velit. Aenean blandit sapien a ipsum. Quisque tempus commodo erat."
--	text = text .. "\n\nLorem >|cffffffffipsum|r dolor |cffff3311sit amet|r, consectetuer adipiscing elit. Sed quis lacus. Mauris fringilla consequat velit. Aenean dolor libero, placerat nec, feugiat sed, tincidunt ac, leo. In hac habitasse platea dictumst. Aliquam non sem adipiscing massa sagittis suscipit. Pellentesque ultrices nisl at ante. Vestibulum dapibus. Nulla facilisi. Nullam lobortis dictum diam. Donec mollis augue ut nulla. Donec ullamcorper mauris sit amet erat. Vivamus ante augue, rutrum sit amet, iaculis sit amet, congue vel, risus. Sed magna. Sed a eros. Aenean sed orci nec sem dapibus fringilla. Donec id diam. Praesent adipiscing. Sed dignissim pellentesque velit. Aenean blandit sapien a ipsum. Quisque tempus commodo erat.</p></body></html>"
--	sh:SetText(text)
	t:AddChild(sh)
	self.html = sh
	self.frame = f
	self.tree = t	
	_OnGroupSelected(t, "OnGroupSelected", self.DOCUMENTATION)
	f:AddChild(t)
	f:Hide()
end

--[[
	Initializes the module.
--]]
function vendor.Help:OnEnable()
	_CreateFrame(self)
end

--[[
	Shows the frame with the given section.
--]]
function vendor.Help:Show(section)
	_OnGroupSelected(self.tree, "OnGroupSelected", section)
	self.frame:Show()
end

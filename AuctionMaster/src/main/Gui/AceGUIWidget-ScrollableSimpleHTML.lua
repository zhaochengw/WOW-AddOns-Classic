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

local AceGUI = LibStub("AceGUI-3.0")

--[[
	Scrollable SimpleHTML widget usable by AceGUI. The scrollframe is integrated, because
	the one included in AceGUI doesn't seem to like SimpleHTML.
--]]
do
	local Type = "ScrollableSimpleHTML"
	local Version = 1
	local created = 0
	
	local SCROLLER_WIDTH = 17
	local HTML_OFFSET = SCROLLER_WIDTH + 8
	
	local function OnAcquire(self)
		-- nothing to be done
	end
	
	local function OnRelease(self)
		self.frame:ClearAllPoints()
		self.frame:Hide()
	end
	
	--[[
		Updates the frame, especially the scrollframe.
	--]]
	local function Update(self)
		-- ensure correct scrollbar refresh
		local onVertScroll = self.scrollFrame:GetScript("OnVerticalScroll")
		onVertScroll(self.scrollFrame, FauxScrollFrame_GetOffset(self.scrollFrame))
		-- check whether the scrollbar should be invisible
		local scrollbar = getglobal(self.scrollFrame:GetName().."ScrollBar")
		local min, max = scrollbar:GetMinMaxValues()
		if (max and max == 0) then
			scrollbar:Hide()
		end
	end
	
	local function SetText(self, text)
		self.text = text or ""
		self.html:SetText(self.text)
		Update(self)
	end

	local function OnWidthSet(self, width)
		self.html:SetWidth(width - HTML_OFFSET)
		-- redraw the text
		SetText(self, self.text or "")
	end
	
	local function Constructor()
		local outer = CreateFrame("Frame", nil, UIParent)
		created = created + 1
    	local frame = CreateFrame("ScrollFrame", "ScrollableSimpleHtml"..created, outer, "UIPanelScrollFrameTemplate")
    	frame:SetWidth(285)
    	frame:SetHeight(261)
    	frame:SetPoint("TOPLEFT", outer, "TOPLEFT", 0, 0)
		frame:SetPoint("BOTTOMRIGHT", outer, "BOTTOMRIGHT", -SCROLLER_WIDTH, 0)

   		-- adds a solid background
--		local texture = frame:CreateTexture()
--		texture:SetAllPoints(frame)
--		texture:SetTexture(1, 184 / 255, 91 / 255)

    	local html = CreateFrame("SimpleHTML", nil, frame)
    	html:SetWidth(270)
    	html:SetHeight(251)
    	html:SetPoint("TOPLEFT")
    	
    	html:SetFontObject("h1", GameFontNormalLarge)
    	html:SetFontObject("h2", GameFontNormalLarge)
    	html:SetFontObject("h3", GameFontRed)
    	html:SetFontObject(GameFontWhite)
    	html:SetSpacing("h1", 10)
    	html:SetSpacing("h2", 9)
    	html:SetSpacing("h3", 8)
    	html:SetSpacing("p", 7)

    	frame:SetScrollChild(html)

		local self = {}
		self.type = Type
		
		self.OnRelease = OnRelease
		self.OnAcquire = OnAcquire
		self.OnWidthSet = OnWidthSet
		self.SetText = SetText
		self.frame = outer
		self.scrollFrame = frame
		self.html = html
		self.frame.obj = self
		
		AceGUI:RegisterAsWidget(self)
		return self
	end
	
	AceGUI:RegisterWidgetType(Type, Constructor, Version)
end

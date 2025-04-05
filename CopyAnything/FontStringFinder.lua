local addon = select(2, ...).addon
local L = addon.L

local MouseIsOver, EnumerateFrames = MouseIsOver, EnumerateFrames

--------------------------------------------------------------------------------
-- Special cases for frames that shouldn't be handled normally
--

local specificCases
do
	local function filterVisible(region)
		return region:IsVisible()
	end

	specificCases = {
		function(frame) -- Chat frame
			if frame.GetMessageInfo then -- chat frame
				local messages = {}
				for i = 1, frame:GetNumMessages() do
					messages[i] = frame:GetMessageInfo(i)
				end
				return table.concat(messages, "\n")
			end
		end,
		function(frame) -- Default
			local fontStrings = addon:GetChildFontStrings(frame)
			fontStrings = addon.tableUtils.Filter(fontStrings, filterVisible)
			if #fontStrings > 500 then
				addon:Print(L.tooManyFontStrings:format(500))
				return
			end
			return addon:FontStringsToString(fontStrings)
		end,
	}
end

--------------------------------------------------------------------------------
-- Search by font string
--

do
	-- Iterates through all font strings in existence and returns those meeting a condition.
	-- @param condition Function that returns a truthy value if the font string should be returned.
	-- @return table of font strings that met the condition.
	local function GetGlobalFontStrings(condition)
		local fontStrings = {}
		local frame = EnumerateFrames()
		while frame do
			local regions = { frame:GetRegions() }
			for _, region in next, regions do
				-- much faster to check if GetText than to use GetObjectType and check if FontString
				if region.GetText and condition(region) then
					fontStrings[#fontStrings+1] = region
				end
			end
			frame = EnumerateFrames(frame)
		end
		return fontStrings
	end

	local function filter(fontString)
		if fontString:IsVisible() then
			-- No way of knowing if the region is restricted, so just skip this one
			-- if it is restricted or has any other error.
			local status, isMouseOver = pcall(function()
				return MouseIsOver(fontString)
			end)
			return status and isMouseOver
		end
		return false
	end

	-- Returns all font strings under the cursor.
	-- @return Table of font strings.
	function addon:GetMouseoverFontStrings()
		return GetGlobalFontStrings(filter)
	end
end

-- Returns all text under the cursor.
-- @return string of all text under the cursor.
function addon:GetMouseoverText()
	return self:FontStringsToString(self:GetMouseoverFontStrings())
end

--------------------------------------------------------------------------------
-- Search by frame
--

do
	local function GetGlobalFrames(condition)
		local frames = {}
		local frame = EnumerateFrames()
		while frame do
			if condition(frame) then
				frames[#frames+1] = frame
			end
			frame = EnumerateFrames(frame)
		end
		return frames
	end

	-- Parent frame names that don't contain the word parent
	local blacklist = {
		UIParent = true,
		WorldFrame = true,
		WeakAurasFrame = true,
		DetailsAuraPanel = true,
		ElvUF_PetBattleFrameHider = true,
		TimerTracker = true,
	}
	setmetatable(blacklist, {
		__index = function(t, key)
			return type(key) == "string" and key:lower():find("parent")
		end,
	})

	local function filter(frame)
		local parent = frame:GetParent()
		return frame:IsVisible()
			and MouseIsOver(frame)
			and (parent and blacklist[parent:GetName()] or parent == nil)
			and not blacklist[frame:GetName()]
	end

	-- Returns all top level frames under the cursor.
	-- @return table of frames.
	function addon:GetMouseoverFrames()
		return GetGlobalFrames(filter)
	end
end

-- Returns all text from all frames under the cursor.
-- @return string containing all text from frames under the cursor.
function addon:GetMouseoverFramesText()
	local frames = self:GetMouseoverFrames()
	local texts = {}
	for _, frame in ipairs(frames) do
		texts[#texts+1] = self:GetSpecificFrameText(frame)
	end
	return table.concat(texts, "\n")
end

--------------------------------------------------------------------------------
-- Specific frame
--

-- Returns text from a specific frame and its children.
-- @return string containing text from frames
function addon:GetSpecificFrameText(frame)
	for _, case in ipairs(specificCases) do
		local text = case(frame)
		if text then
			return text
		end
	end
end

--------------------------------------------------------------------------------
-- Helper functions
--

do
	local function getRegions(frame)
		return { frame:GetRegions() }
	end

	local function isFontString(region)
		return region.GetText
	end

	-- Returns font strings that are a direct child of the supplied frames.
	-- @param frames table of frames to search.
	-- @return table of font strings that are direct children of the supplied frames.
	function addon:GetDirectChildFontStrings(frames)
		local regions = self.tableUtils.Map(frames, getRegions)
		regions = self.tableUtils.Flatten(regions, 1)
		regions = self.tableUtils.Filter(regions, isFontString)
		return regions
	end
end

-- Concatenates the text of a table of font strings into one string.
-- font strings are separated with \n.
-- @param fontStrings table of FontStrings.
-- @return concatenated text of all font strings.
function addon:FontStringsToString(fontStrings)
	local texts = {}
	local foundOne = false
	for _, fs in ipairs(fontStrings) do
		local text = fs:GetText()
		if text then
			foundOne = true
			texts[#texts+1] = text
		end
	end
	return foundOne and table.concat(texts, "\n")
end

do
	-- Returns a table containing all children of a frame.
	-- Does not include the frame itself.
	-- @param frame Frame to scan recirsively for children. Will not be included in the returned table.
	-- @return table of all children.
	local function GetAllChildren(frame)
		local children = { frame:GetChildren() }
		local count = #children
		for i = 1, count do
			local child = children[i]
			local subChildren = GetAllChildren(child)
			if subChildren then
				for _, subChild in ipairs(subChildren) do
					children[#children+1] = subChild
				end
			end
		end
		return children
	end

	-- Returns all child font strings of a frame. This includes child of child, etc.
	-- and not just direct children.
	-- @param frame Frame to scan for font strings.
	-- @return table of font strings.
	function addon:GetChildFontStrings(frame)
		local frames = GetAllChildren(frame)
		table.insert(frames, 1, frame)
		local fontStrings = self:GetDirectChildFontStrings(frames)
		return fontStrings
	end
end

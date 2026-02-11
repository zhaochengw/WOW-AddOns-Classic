local addon = select(2, ...).addon
local L = addon.L

local MouseIsOver, EnumerateFrames = MouseIsOver, EnumerateFrames

---@return boolean
local function canAccessValueCompat(value)
	return WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE or canaccessvalue(value)
end

---@return boolean
local function canAccessAllValuesCompat(...)
	return WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE or canaccessallvalues(...)
end

---@param value Frame
---@return boolean
local function isAnchoringSecretCompat(value)
	return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE and value:IsAnchoringSecret()
end

---@param value Frame
---@return boolean
local function hasAnySecretAspectCompat(value)
	return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE and value:HasAnySecretAspect()
end


--------------------------------------------------------------------------------
-- Search by font string
--

---@return string mouseoverText all text under the cursor.
function addon:GetMouseoverText()
	local fontStringsIter = addon:GetDirectChildFontStrings(self:IterateFrames())
	local function mouseoverFontStringsIter()
		local fontString = fontStringsIter()
		while fontString do
			local isVisible = fontString:IsVisible()
			if canAccessValueCompat(isVisible) and isVisible then
				-- No way of knowing if the region is restricted, so just skip this one
				-- if it is restricted or has any other error.
				local status, isMouseOver = pcall(function()
					return MouseIsOver(fontString)
				end)
				if status and canAccessValueCompat(isMouseOver) and isMouseOver then
					return fontString
				end
			end
			fontString = fontStringsIter()
		end
	end
	return self:FontStringsToString(mouseoverFontStringsIter)
end

--------------------------------------------------------------------------------
-- Search by frame
--

do
	-- Parent frame names that don't contain the word parent
	local blacklist = {
		UIParent = true,
		WorldFrame = true,
		WeakAurasFrame = true,
		DetailsAuraPanel = true,
		ElvUF_PetBattleFrameHider = true,
		TimerTracker = true,
		PetFrame = true,
	}

	setmetatable(blacklist, {
		__index = function(t, key)
			return type(key) == "string" and key:lower():find("parent")
		end,
	})

	---Returns all top level frames under the cursor.
	---@return fun(): Frame? iter
	function addon:GetMouseoverFrames()
		local frameIter = self:IterateFrames()
		return function()
			local frame = frameIter()
			while frame do
				-- No way of knowing if the region is restricted, so just skip this one
				-- if it is restricted or has any other error.
				local status, isMouseOver = pcall(function()
					local parent = frame:GetParent()
					local isVisible = frame:IsVisible()
					local isMouseOver = not isAnchoringSecretCompat(frame)
						and not hasAnySecretAspectCompat(frame)
						and MouseIsOver(frame)
					local parentName = parent and parent:GetName()
					local name = frame:GetName()

					if canAccessAllValuesCompat(isVisible, isMouseOver, parentName, name) then
						return isVisible
							and isMouseOver
							and (parentName and blacklist[parentName] or parent == nil)
							and not blacklist[name]
					end
				end)
				if status and isMouseOver then
					return frame
				end
				frame = frameIter()
			end
		end
	end
end

---Returns all text from all frames under the cursor.
---@return string containing all text from frames under the cursor.
function addon:GetMouseoverFramesText()
	local texts = {}
	for frame in self:GetMouseoverFrames() do
		texts[#texts + 1] = self:GetSpecificFrameText(frame)
	end
	return table.concat(texts, "\n")
end

--------------------------------------------------------------------------------
-- Search by mouse focus
--

---@return string
function addon:GetMouseFocusText()
	local frames
	if GetMouseFoci then
		frames = GetMouseFoci()
	else
		frames = { GetMouseFocus() }
	end
	local lines = {}
	for _, frame in next, frames do
		if frame ~= WorldFrame then
			lines[#lines + 1] = self:GetSpecificFrameText(frame)
		end
	end
	return table.concat(lines, "\n")
end

--------------------------------------------------------------------------------
-- Specific frame
--

-- Returns text from a specific frame and its children.
---@param frame Frame
---@return string
function addon:GetSpecificFrameText(frame)
	local fontStringIter = addon:GetChildFontStrings(frame)
	local function visibleFontStrings()
		local fontString = fontStringIter()
		while fontString do
			local isVisible = fontString:IsVisible()
			if canAccessValueCompat(isVisible) and isVisible then
				return fontString
			end

			fontString = fontStringIter()
		end
	end
	return addon:FontStringsToString(visibleFontStrings)
end

--------------------------------------------------------------------------------
-- Helper functions
--

-- Concatenates the text of a table of font strings into one string.
-- font strings are separated with \n.
---@param fontStringsIter fun(): FontString?
---@return string
function addon:FontStringsToString(fontStringsIter)
	local texts = {}
	for fontString in fontStringsIter do
		local text = fontString:GetText()
		if canAccessValueCompat(text) and text then
			texts[#texts + 1] = text
		end
	end
	return texts[1] and table.concat(texts, "\n")
end

do
	---Iterator of all children, grandchildren, etc. Does not include the frame itself.
	---@param frame Frame Frame to scan recirsively for children.
	---@return fun(): Frame? iter
	local function GetChildrenRecursive(frame)
		return coroutine.wrap(function()
			local children = { frame:GetChildren() }
			local count = #children
			for i = 1, count do
				local child = children[i]
				coroutine.yield(child)
				for subChild in GetChildrenRecursive(child) do
					coroutine.yield(subChild)
				end
			end
		end)
	end

	---@param frame Frame to scan for font strings.
	---@return fun(): FontString? iter Iterator of FontStrings
	function addon:GetChildFontStrings(frame)
		local childFramesIter = GetChildrenRecursive(frame)
		local framesIter = coroutine.wrap(function()
			coroutine.yield(frame)
			for childFrame in childFramesIter do
				coroutine.yield(childFrame)
			end
		end)
		local fontStrings = self:GetDirectChildFontStrings(framesIter)
		return fontStrings
	end
end

-- Returns font strings that are a direct child of any of the supplied frames.
---@param framesIter fun(): Frame? frames to search.
---@return fun(): FontString? iter FontStrings that are direct children of the supplied frames.
function addon:GetDirectChildFontStrings(framesIter)
	return coroutine.wrap(function()
		for frame in framesIter do
			local regions = { frame:GetRegions() }
			for _, region in next, regions do
				if region.GetText then
					coroutine.yield(region)
				end
			end
		end
	end)
end

---@return fun(): Frame? iter
function addon:IterateFrames()
	local frame = nil
	return function()
		frame = EnumerateFrames(frame)
		return frame
	end
end

--- Library for enabling users to copy and paste blocks of text
--
-- @module LibCopyPaste
-- @usage local LibCopyPaste = LibStub("LibCopyPaste-1.0")

local LibCopyPaste = LibStub:NewLibrary("LibCopyPaste-1.0", 9)
if not LibCopyPaste then return end

local IsControlKeyDown = IsControlKeyDown

-- CopyPasteFrame Class

local CopyPasteFrame = {}
CopyPasteFrame.__index = CopyPasteFrame

function CopyPasteFrame:Create()
	local obj = {}
	setmetatable(obj, CopyPasteFrame)
	-- Main frame
	local frame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
	frame:SetFrameStrata("DIALOG")
	-- Backdrop
	frame:SetBackdrop({
		bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
		tile = true,
		edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
		edgeSize = 32,
		insets = {
			left = 11,
			right = 12,
			top = 12,
			bottom = 11,
		},
	})
	-- Okay Button
	local button = CreateFrame("Button", nil, frame)
	obj.button = button
	button = button
	button:SetSize(128, 32)
	button:SetPoint("BOTTOM", 0, 16)
	button:SetText(OKAY)
	-- Textures
	button:SetNormalTexture(button:CreateTexture(nil, nil, "DialogButtonNormalTexture"))
	button:SetPushedTexture(button:CreateTexture(nil, nil, "DialogButtonPushedTexture"))
	button:SetHighlightTexture(button:CreateTexture(nil, nil, "DialogButtonPushedTexture"))
	-- Fonts
	button:SetNormalFontObject(DialogButtonNormalText)
	button:SetHighlightFontObject(DialogButtonHighlightText)
	button:SetScript("OnClick", function()
		self:GetParent():Hide()
	end)

	frame:EnableMouse(true)
	frame:EnableKeyboard(true)

	-- Child frames
	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalHugeBlack")
	title:SetPoint("TOP", 0, 0)
	title:SetTextColor(1, 1, 1, 1)
	title:Show()

	local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "ScrollFrameTemplate")
	scrollFrame:SetPoint("TOP", 0, -30)
	scrollFrame:SetSize(650, 370)
	scrollFrame:Show()

	local editBox = CreateFrame("EditBox", nil, scrollFrame)
	editBox:SetMaxLetters(999999)
	editBox:SetSize(630, 350)
	editBox:SetFont(ChatFontNormal:GetFont())
	editBox:SetAutoFocus(true)
	editBox:SetMultiLine(true)
	editBox:Show()
	editBox:SetScript("OnEscapePressed", function()
		obj:Hide()
	end)

	scrollFrame:SetScrollChild(editBox)

	obj.frame = frame
	obj.editBox = editBox
	obj.title = title
	return obj
end

function CopyPasteFrame:ResetPosition()
	self.frame:SetSize(700, 450)
	self.frame:ClearAllPoints()
	self.frame:SetPoint("CENTER", self.frame:GetParent() or UIParent, "CENTER", 0, 0)
end

function CopyPasteFrame:Show()
	self:ResetPosition()
	self.frame:Show()
	self.editBox:SetFocus()
end

function CopyPasteFrame:SetTitle(title)
	self.title:SetText(title)
end

function CopyPasteFrame:SetText(text)
	self.editBox:SetText(text)
	self.editBox:HighlightText()
end

function CopyPasteFrame:SetAutoHide(autoHide)
	if autoHide then
		-- Text doesn't copy if it's hidden OnKeyDown
		local hideQueued = false
		self.editBox:SetScript("OnKeyDown", function(_, key)
			if key == "C" and IsControlKeyDown() then
				hideQueued = true
			end
		end)
		self.editBox:SetScript("OnKeyUp", function(_, key)
			if hideQueued and (key == "C" or key == "LCTRL" or key == "RCTRL") then
				self:Hide()
			end
		end)
	else
		self.editBox:SetScript("OnKeyUp", nil)
		self.editBox:SetScript("OnKeyDown", nil)
	end
end

function CopyPasteFrame:GetTitle()
	return self.title:GetText()
end

function CopyPasteFrame:GetText()
	return self.editBox:GetText()
end

function CopyPasteFrame:IsOpen()
	return self.frame:IsShown()
end

-- Callback runs when Okay is clicked. Does not run when excape is pressed.
function CopyPasteFrame:SetCallback(callback)
	self.button:SetScript("OnClick", function()
		if callback then
			callback(self:GetText())
		end
		self:Hide()
	end)
end

function CopyPasteFrame:SetReadOnly(readOnly)
	self.readOnly = readOnly
	if readOnly then
		local text = self.editBox:GetText()
		self.editBox:SetScript("OnTextChanged", function(editBox)
			editBox:SetText(text)
			editBox:HighlightText()
		end)
	else
		self.editBox:SetScript("OnTextChanged", nil)
	end
end

function CopyPasteFrame:SetOptions(options)
	if options.readOnly ~= nil or self.readOnly ~= nil then
		self:SetReadOnly(options.readOnly)
	end
	self:SetAutoHide(options.autoHide)
end

-- Reset to initial state here
function CopyPasteFrame:Hide()
	self:SetTitle("")
	self:SetText("")
	self:SetCallback(nil)
	self:SetOptions({
		readOnly = false,
		autoHide = false,
	})
	self.frame:Hide()
end

-- Public API
local frame
--- Open a frame containing text for the user to copy
-- @param title Title of the copy window.
-- @param text Text to display in the window. This is what will be copied.
-- @param options Table of options. Keys are: readOnly (boolean)
function LibCopyPaste:Copy(title, text, options)
	assert(type(title) == "string" and type(text) == "string",
		"title and text are required and must be strings. Usage: Copy(title, text)")
	if not frame then frame = CopyPasteFrame:Create() end
	frame:Hide()
	frame:SetTitle(title)
	frame:SetText(text)
	if options then
		frame:SetOptions(options)
	end
	frame:Show()
end

--- Open a frame for the user to paste text into
-- @param title Title of the paste window.
-- @param callback Function that will be run when the paste window is closed. The function will be passed the pasted text as an argument.
-- @param options Table of options. No options exist yet.
function LibCopyPaste:Paste(title, callback, options)
	assert(type(title) == "string" and type(callback) == "function",
		"title and callback are required. title must be a string and callback must be a function. Usage: Copy(title, callback)")
	if not frame then frame = CopyPasteFrame:Create() end
	frame:Hide()
	frame:SetTitle(title)
	frame:SetCallback(callback)
	if options then
		frame:SetOptions(options)
	end
	frame:Show()
end

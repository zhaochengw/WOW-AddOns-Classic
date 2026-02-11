local _, namespace = ...

local AceAddon = LibStub("AceAddon-3.0")
local AceLocale = LibStub("AceLocale-3.0")
local LibCopyPaste = LibStub("LibCopyPaste-1.0")

local addon = AceAddon:NewAddon("CopyAnything", "AceConsole-3.0")
local L = AceLocale:GetLocale("CopyAnything")
namespace.addon = addon
addon.L = L

function addon:OnEnable()
	self:RegisterChatCommand("copy", "SlashCopy")
	self:RegisterChatCommand("copyanything", "SlashCopy")
end

function addon:Copy(text)
	C_Timer.After(0, function()
		local fastCopy = self.db.profile.fastCopy
		LibCopyPaste:Copy(L.copyAnything, text, {
			autoHide = fastCopy,
			readOnly = fastCopy,
		})
	end)
end

do
	function addon:SlashCopy(msg)
		local frame = msg and #msg > 0 and _G[msg]
		if frame and frame.GetChildren then -- Specific frame
			local text = self:GetSpecificFrameText(frame)
			if not text then
				self:Print(L.noTextFound)
				return
			end
			self:Copy(text)
		else -- Mouseover
			local searchType = self.db.profile.searchType
			local text = nil
			if searchType == "fontStrings" then
				text = self:GetMouseoverText()
			elseif searchType == "parentFrames" then
				text = self:GetMouseoverFramesText()
			elseif searchType == "mouseFocus" then
				text = self:GetMouseFocusText()
			else
				self:Print(L.invalidSearchType:format(searchType))
				return
			end
			if not text then
				self:Print(L.noTextFound)
				return
			end
			self:Copy(text)
		end
	end
end

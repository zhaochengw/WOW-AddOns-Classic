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
	Debugging functionallity copied from AceDebug-2.0 for the ACe3 migration.
--]]

vendor.Debug = {}
vendor.Debug.prototype = {}
vendor.Debug.metatable = {__index = vendor.Debug.prototype}

--[[
	Returns whether the given logger is debugging.
--]]
local function _IsDebugging(name)
	if (AuctionMasterMiscDb.debuggers and AuctionMasterMiscDb.debuggers[name]) then
		local msg = "false" 
		return AuctionMasterMiscDb.debuggers[name].debugging
	end
	return false
end

--[[
	Sets the debugging state for the given debugger
--]]
local function _SetDebugging(name, d)
	if (name) then
    	if (not AuctionMasterMiscDb.debuggers) then
    		AuctionMasterMiscDb.debuggers = {}
    	end
    	if (not AuctionMasterMiscDb.debuggers[name]) then
    		AuctionMasterMiscDb.debuggers[name] = {}
    	end
    	AuctionMasterMiscDb.debuggers[name].debugging = d
    end
end

local options = {
	type = "multiselect",
	name = "Debug",
	values = {},
	get = function(info, name)
		return _IsDebugging(name)
	end,
	set = function(info, name, state)
		_SetDebugging(name, state)
	end,
}

local function safecall(func,...)
	local success, err = pcall(func,...)
	if not success then geterrorhandler()(err:find("%.lua:%d+:") and err or (debugstack():match("\n(.-: )in.-\n") or "") .. err) end
end

--[[ 
	Creates a new instance.
--]]
function vendor.Debug:new(name)
	local instance = setmetatable({}, self.metatable)
	instance.name = name
	options.values[name] = name
	return instance
end


local function print(text, r, g, b, frame, delay)
	(frame or DEFAULT_CHAT_FRAME):AddMessage(text, r, g, b, 1, delay or 5)
end

local tmp = {}

function vendor.Debug.prototype:CustomDebug(r, g, b, frame, delay, a1, ...)
	if (not _IsDebugging(self.name))  then
		return
	end

	local output = self:GetDebugPrefix()
	
	a1 = tostring(a1)
	if a1:find("%%") and select('#', ...) >= 1 then
		for i = 1, select('#', ...) do
			tmp[i] = tostring((select(i, ...)))
		end
		output = output .. " " .. a1:format(unpack(tmp))
		for i = 1, select('#', ...) do
			tmp[i] = nil
		end
	else
		-- This block dynamically rebuilds the tmp array stopping on the first nil.
		tmp[1] = output
		tmp[2] = a1
		for i = 1, select('#', ...) do
			tmp[i+2] = tostring((select(i, ...)))
		end
		
		output = table.concat(tmp, " ")
		
		for i = 1, select('#', ...) + 2 do
			tmp[i] = nil
		end
	end

	print(output, r, g, b, frame or self.debugFrame, delay)
end

function vendor.Debug.prototype:Debug(...)
	local logging = getglobal("Logging")
	self:CustomDebug(nil, nil, nil, nil, logging, ...)
end

function vendor.Debug.prototype:IsDebugging()
	return _IsDebugging(self.name)
end

function vendor.Debug.prototype:SetDebugging(d)
	_SetDebugging(self.name, d)
end

function vendor.Debug.prototype:GetDebugPrefix()
	return ("|cff7fff7f(DEBUG) %s:[%s.%3d]|r"):format( self.name, date("%H:%M:%S"), (GetTime() % 1) * 1000)
end

--[[
	Returns an options object for configuring the debigging.
--]]
function vendor.Debug.GetOptions()
	return options
end

--[[
	Offers functionality for the auction house, needed by Vendor.
	This includes the addition of new tabs and specifying the 
	tab to be selected when opening the auction house frame.

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

vendor = vendor or {}
vendor.Locale = {}

--[[
	Returns a handle for localizating messages. This will
	decouple from the concrete implementation.
--]]
function vendor.Locale.GetInstance()
	return LibStub("AceLocale-3.0"):GetLocale("AuctionMaster", true)
end

--[[
	Returns a handle for the release notes and documentation.
--]]
function vendor.Locale.GetHelpInstance()
	return LibStub("AceLocale-3.0"):GetLocale("AuctionMaster-Help", true)
end


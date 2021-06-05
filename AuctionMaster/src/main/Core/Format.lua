--[[
	Some formatting helpers.
	
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

local GOLD_COLOR_CODE   = "|cffffd700"
local SILVER_COLOR_CODE = "|cffc7c7cf"
local COPPER_COLOR_CODE = "|cffeda55f"
local GOLD_ICON_CODE = "|TInterface\\MoneyFrame\\UI-GoldIcon:0|t"
local SILVER_ICON_CODE = "|TInterface\\MoneyFrame\\UI-SilverIcon:0|t"
local COPPER_ICON_CODE = "|TInterface\\MoneyFrame\\UI-CopperIcon:0|t"
local WHITE_COLOR_CODE = "|cffffffff" 

vendor.Format = {};

--[[
	Formats the given amount of copper in a suitable string representation.
	@param short if set to true, no copper will be shown if gold is present.
--]]
function vendor.Format.FormatMoney(copper, short)
	copper = math.floor(math.max(0, copper or 0));
   	local gold   = math.floor(copper / 10000);
   	local silver = math.fmod(math.floor(copper  / 100), 100);
   	local cop = math.fmod(copper, 100)
   	local rtn = ""
   	if (vendor.Vendor.db.profile.moneyIcons) then
    	if (gold > 0) then
    		rtn = rtn..WHITE_COLOR_CODE..gold..GOLD_ICON_CODE
    	end
    	if (silver > 0 and (not short or gold < 100)) then
    		rtn = rtn..WHITE_COLOR_CODE..silver..SILVER_ICON_CODE
    	end
    	if (cop > 0 and (not short or gold < 1)) then
    		rtn = rtn..WHITE_COLOR_CODE..cop..COPPER_ICON_CODE
    	end 
    else
       	if (gold > 0) then
    		rtn = rtn..GOLD_COLOR_CODE..gold.."g";
       	end
       	if (silver > 0 and (not short or gold < 1000)) then
          	rtn = rtn..SILVER_COLOR_CODE..silver.."s";
       	end
       	if (cop > 0 and (not short or gold < 1)) then
          	rtn = rtn..COPPER_COLOR_CODE..cop.."c";
       	end
	end
   	if (string.len(rtn) == 0) then
		rtn = COPPER_COLOR_CODE.."--"
   	end
   	return rtn..FONT_COLOR_CODE_CLOSE
end

--[[
	Formats the given amount of copper in a suitable grayed out string representation.
	@param short if set to true, no copper will be shown if gold is present.
--]]
function vendor.Format.FormatMoneyGrayedOut(copper, short)
	copper = math.floor(math.max(0, copper or 0));
   	local gold   = math.floor(copper / 10000);
   	local silver = math.fmod(math.floor(copper  / 100), 100);
   	copper = math.fmod(copper, 100);
   	local rtn = ""
   	if (gold > 0) then
		rtn = rtn..vendor.OUTDATED_FONT_COLOR_CODE..gold.."g";
   	end
   	if (silver > 0 and (not short or gold < 1000)) then
      	rtn = rtn..vendor.OUTDATED_FONT_COLOR_CODE..silver.."s";
   	end
   	if (copper > 0 and (not short or gold < 1)) then
      	rtn = rtn..vendor.OUTDATED_FONT_COLOR_CODE..copper.."c";
   	end
   	if (string.len(rtn) == 0) then
		rtn = vendor.OUTDATED_FONT_COLOR_CODE.."--"
   	end
   	return rtn..FONT_COLOR_CODE_CLOSE
end

--[[
	Formats the given two amounts of copper in a suitable string representation.
	@param short if set to true, no copper will be shown if gold is present.
--]]
function vendor.Format.FormatMoneyValues(copper1, copper2, short)
	local msg1 = vendor.Format.FormatMoney(copper1, short)
	local msg2 = vendor.Format.FormatMoney(copper2, short)
	local delimiter = " ("
	if (vendor.Vendor.db.profile.moneyIcons) then
		delimiter = "("
	end
	return msg1..delimiter..msg2..")"
end

--[[
	Formats the given two amounts of copper in a suitable grayed out string representation.
	@param short if set to true, no copper will be shown if gold is present.
--]]
function vendor.Format.FormatMoneyValuesGrayedOut(copper1, copper2, short)
	local msg1 = vendor.Format.FormatMoneyGrayedOut(copper1, short)
	local msg2 = vendor.Format.FormatMoneyGrayedOut(copper2, short)
	local delimiter = " ("
	if (vendor.Vendor.db.profile.moneyIcons) then
		delimiter = "("
	end
	return msg1..delimiter..msg2..")"
end

--[[
	Returns the font color string for the given color "struct".
--]]
function vendor.Format.GetFontColorCode(color)
   local r = math.floor(color.r * 255.0);
   local g = math.floor(color.g * 255.0);
   local b = math.floor(color.b * 255.0);
   return string.format("|cff%2x%2x%2x", r, g, b);
end

--[[
	Colorizes the given input string according to the specified quality.
--]]
function vendor.Format.ColorizeQuality(text, quality)
	local color = "|C"..select(4, GetItemQualityColor(quality))
	return color..text..FONT_COLOR_CODE_CLOSE;
end

--[[
	Converts the boolean to a string.
--]]
function vendor.Format.BoolToStr(b)
	if (b) then
		return "true";
	else
		return "false";
	end
end

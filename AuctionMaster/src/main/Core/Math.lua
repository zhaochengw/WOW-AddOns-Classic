--[[
	Some math functions like average.
	
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

vendor.Math = {};
vendor.Math.PHI = 1.6180339887;

local log = vendor.Debug:new("Math")

--[[
	Calculates the arithemetic average from the given numerical values.
--]]
function vendor.Math.GetAverage(vals)
   	local rtn = 0
   	if (vals) then
      	for i=1,#vals do
	 		rtn = rtn + (vals[i] - rtn) / i
      	end
   	end
   	return rtn
end

--[[
	Calculates the median average from the given numerical values.
--]]
function vendor.Math.GetMedian(vals)
   	local rtn = 0;
   	if (vals ~= nil) then
      	local n = table.getn(vals);
      	if (n > 0) then
      		rtn = vals[math.floor(n / 2 + 1)];
      	end
   	end
   	return rtn;
end

--[[
	Adds a new value to an average values.
	avg: the old average value
	avgN: the no. of values into avg.
	val: the val to be added
	valN: the no. of values in val.
--]]
function vendor.Math.UpdateAverage(avg, avgN, val, valN)
   	return math.floor(0.5 + avg + ( (valN * (val - avg)) / (avgN + valN) ));
end

--[[
	Calculates the standard deviation of the given numerical values.
--]]
function vendor.Math.GetStandardDeviation(vals)
   	local rtn = 0;
   	local avg = 0;
   	if (vals ~= nil) then   
      	avg = vendor.Math.GetAverage(vals);
      	local n = table.getn(vals);
      	if (n > 1) then
	 		for i = 1, n do
	    		rtn = rtn + (vals[i] - avg)  ^  2;
	 		end
	 		rtn = math.sqrt(rtn / (n - 1));
      	end
   	end
   	return rtn, avg;
end

--[[
	Removes all entries, that are "mul * standardDeviation" smaller resp. larger
	as the avg value.
--]] 
function vendor.Math.CleanupByStandardDeviation(vals, smallerMul, largerMul)
	if (#vals > 2) then
		local stdDev, avg = vendor.Math.GetStandardDeviation(vals)
		log:Debug("CleanupByStandardDeviation stdDev [%s] avg [%s] smallerMul [%f] largerMul [%f]", stdDev, avg, smallerMul, largerMul)
		if (stdDev >= 1) then
			-- at least 20% are allowed
			stdDev = math.max(stdDev, avg * 0.2)
			local i = 1
			local val
   			for i=#vals,1,-1 do
   				val = vals[i]
				if (val < avg and ((avg - val) > (stdDev * smallerMul))) then
					table.remove(vals, i)
				elseif (val > avg and ((val - avg) > (stdDev * largerMul))) then
					table.remove(vals, i)
				end
   			end
		end
	end
end
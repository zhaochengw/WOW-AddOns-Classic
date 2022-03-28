-- /***********************************************
--  * Lunar Memory Module
--  *********************
--
--  Author	: Moongaze (Twisting Nether)
--  Description	: Handles the management of memory features that LunarSphere uses.
--
--  ***********************************************/

-- /***********************************************
--  * Module Setup
--  *********************

-- Define Lunar and the Lunar Memory objects if they are not already defined

local _G = getfenv(0);

Lunar = Lunar or {};
Lunar.addonName = "LunarSphere";
_G[Lunar.addonName] = Lunar;
setmetatable(Lunar, {__index = _G});
setfenv(1, Lunar);

Lunar.Memory = Lunar.Memory or {}; 

-- Update version tracking

Lunar.Memory.version = 1.52;

-- /***********************************************
--  * Variable Setup
--  *********************

Lunar.Memory.memoryData = {};
local currentID, currentMemory;

-- /***********************************************
--  * Function Setup
--  *********************

function Lunar.Memory:Initialize()

end

function Lunar.Memory:PrepareForCalculation(featureID)

	local db = Lunar.Memory.memoryData;
	db[featureID] = db[featureID] or (0); 

	collectgarbage();
	UpdateAddOnMemoryUsage();

	currentID = featureID;
	currentMemory = GetAddOnMemoryUsage("LunarSphere");

end

function Lunar.Memory:Calculate()

	if (currentID) then

		collectgarbage();
		UpdateAddOnMemoryUsage();

		local db = Lunar.Memory.memoryData;
		db[currentID] = db[currentID] + (GetAddOnMemoryUsage("LunarSphere") - currentMemory);

		local returnValue = db[currentID];

		currentID = nil;
		currentMemory = nil;

		return returnValue;

	end	

end

function Lunar.Memory:CalculateCore()

	collectgarbage();
	UpdateAddOnMemoryUsage();

	local total = GetAddOnMemoryUsage("LunarSphere");
	local db = Lunar.Memory.memoryData;

	local key, value;
	for key, value in pairs(db) do
		total = total - value;
	end

	db["core"] = total;

end
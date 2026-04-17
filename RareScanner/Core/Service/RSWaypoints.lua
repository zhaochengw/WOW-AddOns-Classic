 -----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSWaypoints = private.NewLib("RareScannerWaypoints")

-- RareScanner database libraries
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner general libraries
local RSUtils = private.ImportLib("RareScannerUtils")

-- Addons integrations
local RSTomtom = private.ImportLib("RareScannerTomtom")

function RSWaypoints.AddChatMapWaypoint(mapID, x, y, name)	
	-- Addons waypoints
	RSTomtom.AddChatWaypoint(mapID, x, y, name)
end

function RSWaypoints.AddWorldMapWaypoint(mapID, x, y, name)
	-- Addons waypoints
	RSTomtom.AddWorldMapWaypoint(mapID, x, y, name)
end

function RSWaypoints.AddAutomaticWaypoint(mapID, x, y, name)
	-- Addons waypoints
	RSTomtom.AddAutomaticWaypoint(mapID, x, y, name)
end

function RSWaypoints.AddWaypoint(mapID, x, y, name)
	-- Addons waypoints
	RSTomtom.AddWaypoint(mapID, x, y, name)
end

function RSWaypoints.RemoveCurrentWaypoints()
	-- Addons waypoints
	RSTomtom.RemoveCurrentWaypoints()
end
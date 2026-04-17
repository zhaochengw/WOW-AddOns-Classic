-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSWaypointUI = private.NewLib("RareScannerWaypointUI")

-- RareScanner database libraries
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner general libraries
local RSUtils = private.ImportLib("RareScannerUtils")

---============================================================================
-- WaypointUI integration
---============================================================================

local waypointui_waypoint

local function AddWaypointUIWaypoint(mapID, x, y, name)
	if (WaypointUIAPI and mapID and x and y and name) then
		RSWaypointUI.RemoveCurrentWaypoints()
		
		local fixedX = RSUtils.FixCoord(x)
		local fixedY = RSUtils.FixCoord(y)
		if (fixedX and fixedY) then
			WaypointUIAPI.Navigation.NewUserNavigation(name, tonumber(mapID), fixedX * 100, fixedY * 100)
			waypointui_waypoint = true
		end
	end
end

function RSWaypointUI.AddChatWaypoint(mapID, x, y, name)
	if (not RSConfigDB.IsAddingchatWaypointUIWaypoints()) then
		return
	end
	
	AddWaypointUIWaypoint(mapID, x, y, name)
end

function RSWaypointUI.AddWorldMapWaypoint(mapID, x, y, name)
	if (not RSConfigDB.IsAddingWorldMapWaypointUIWaypoints()) then
		return
	end
	
	AddWaypointUIWaypoint(mapID, x, y, name)
end

function RSWaypointUI.AddAutomaticWaypoint(mapID, x, y, name)
	if (not RSConfigDB.IsWaypointUISupportEnabled() or not RSConfigDB.IsAddingWaypointUIWaypointsAutomatically()) then
		return
	end
	
	AddWaypointUIWaypoint(mapID, x, y, name)
end

function RSWaypointUI.AddWaypoint(mapID, x, y, name)
	-- Ingame waypoints
	if (not RSConfigDB.IsWaypointUISupportEnabled()) then
		return
	end
	
	AddWaypointUIWaypoint(mapID, x, y, name)
end

function RSWaypointUI.RemoveCurrentWaypoints()
	if (WaypointUIAPI and waypointui_waypoint) then
		WaypointUIAPI.Navigation.ClearUserNavigation()
		waypointui_waypoint = nil
	end
end

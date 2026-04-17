-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSTomtom = private.NewLib("RareScannerTomtom")

-- RareScanner database libraries
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner general libraries
local RSUtils = private.ImportLib("RareScannerUtils")

---============================================================================
-- Tomtom integration
---============================================================================

local tomtom_waypoint

local function AddTomtomWaypoint(mapID, x, y, name)
	if (TomTom and mapID and x and y and name) then
		RSTomtom.RemoveCurrentWaypoints()
		
		local fixedX = RSUtils.FixCoord(x)
		local fixedY = RSUtils.FixCoord(y)
		if (fixedX and fixedY) then
			tomtom_waypoint = TomTom:AddWaypoint(tonumber(mapID), fixedX, fixedY, {
				title = name,
				persistent = false,
				minimap = RSConfigDB.IsShowingTomtomMinimapIcon(),
				world = RSConfigDB.IsShowingTomtomWorldmapIcon(),
				cleardistance = 25
			})
		end
	end
end

function RSTomtom.AddChatWaypoint(mapID, x, y, name)
	if (not RSConfigDB.IsAddingchatTomtomWaypoints()) then
		return
	end
	
	AddTomtomWaypoint(mapID, x, y, name)
end

function RSTomtom.AddWorldMapWaypoint(mapID, x, y, name)
	if (not RSConfigDB.IsAddingWorldMapTomtomWaypoints()) then
		return
	end
	
	AddTomtomWaypoint(mapID, x, y, name)
end

function RSTomtom.AddAutomaticWaypoint(mapID, x, y, name)
	if (not RSConfigDB.IsTomtomSupportEnabled() or not RSConfigDB.IsAddingTomtomWaypointsAutomatically()) then
		return
	end
	
	AddTomtomWaypoint(mapID, x, y, name)
end

function RSTomtom.AddWaypoint(mapID, x, y, name)
	-- Ingame waypoints
	if (not RSConfigDB.IsTomtomSupportEnabled()) then
		return
	end
	
	AddTomtomWaypoint(mapID, x, y, name)
end

function RSTomtom.RemoveCurrentWaypoints()
	if (TomTom and tomtom_waypoint) then
		TomTom:RemoveWaypoint(tomtom_waypoint)
		tomtom_waypoint = nil
	end
end

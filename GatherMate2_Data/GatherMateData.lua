-- nearby check yes/no? slowdown may be an isue if someone leaves the mod enabled and always replace node
local GatherMateData = LibStub("AceAddon-3.0"):NewAddon("GatherMate2_Data")
local GatherMate = LibStub("AceAddon-3.0"):GetAddon("GatherMate2")
GatherMateData.generatedVersion = "504"

function GatherMateData:PerformMerge(dbs,style, zoneFilter)
	local filter = nil -- Removed expansion filters
	if dbs["Mines"]    then self:MergeMines(style ~= "Merge",filter) end
	if dbs["Herbs"]    then self:MergeHerbs(style ~= "Merge",filter) end
	if dbs["Fish"]     then self:MergeFish(style ~= "Merge",filter) end
	if dbs["Treasure"] then self:MergeTreasure(style ~= "Merge",filter) end
	self:CleanupImportData()
	GatherMate:SendMessage("GatherMateData2Import")
	--GatherMate:CleanupDB()
end

function GatherMateData:MergeMines(clear,zoneFilter)
	if clear then GatherMate:ClearDB("Mining") end
	for zoneID, node_table in pairs(GatherMateData2MineDB) do
		if not zoneFilter or zoneFilter[zoneID] then
			for coord, nodeID in pairs(node_table) do
				GatherMate:InjectNode2(zoneID,coord,"Mining", nodeID)
			end
		end
	end
end

function GatherMateData:MergeHerbs(clear,zoneFilter)
	if clear then GatherMate:ClearDB("Herb Gathering") end
	for zoneID, node_table in pairs(GatherMateData2HerbDB) do
		if not zoneFilter or zoneFilter[zoneID] then
			for coord, nodeID in pairs(node_table) do
				GatherMate:InjectNode2(zoneID,coord,"Herb Gathering", nodeID)
			end
		end
	end
end

function GatherMateData:MergeFish(clear,zoneFilter)
	if clear then GatherMate:ClearDB("Fishing") end
	for zoneID, node_table in pairs(GatherMateData2FishDB) do
		if not zoneFilter or zoneFilter[zoneID] then
			for coord, nodeID in pairs(node_table) do
				GatherMate:InjectNode2(zoneID,coord,"Fishing", nodeID)
			end
		end
	end
end

function GatherMateData:MergeTreasure(clear,zoneFilter)
	if clear then GatherMate:ClearDB("Treasure") end
	for zoneID, node_table in pairs(GatherMateData2TreasureDB) do
		if not zoneFilter or zoneFilter[zoneID] then
			for coord, nodeID in pairs(node_table) do
				GatherMate:InjectNode2(zoneID,coord,"Treasure", nodeID)
			end
		end
	end
end

function GatherMateData:CleanupImportData()
	GatherMateData2HerbDB = nil
	GatherMateData2MineDB = nil
	GatherMateData2FishDB = nil
	GatherMateData2TreasureDB = nil
end

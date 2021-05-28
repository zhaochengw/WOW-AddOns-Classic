-- profiling support (WIP)

local Plater = _G.Plater
local DF = _G.DetailsFramework

local profData = {}
local profilingEnabled = false

-- helper
local function round(x)
	if not x then return nil end
	return (x + 0.5 - (x + 0.5) % 1)
end

local function roundTime(value)
	if not value then return nil end
	return round(value*100000)/100000
end

local function roundPercent(value)
	if not value then return nil end
	return round(value*10000)/10000
end


-- profiling
function Plater.EnableProfiling(core)
	profilingEnabled = true
	
	profData = {}
	profData.startTime = debugprofilestop()
	profData.endTime = nil
	profData.totalTimeInPlater = 0
	profData.data = {}
	
	Plater.StartLogPerformance = StartLogPerformance
	Plater.EndLogPerformance = EndLogPerformance
	
	if core then
		Plater.StartLogPerformanceCore = StartLogPerformance
		Plater.EndLogPerformanceCore = EndLogPerformance
	end
	
	Plater:Msg("Plater started profiling.")
end

function Plater.DisableProfiling()
	if not profilingEnabled then return end
	profilingEnabled = false
	
	profData.endTime = debugprofilestop()
	
	Plater.StartLogPerformance = function() end
	Plater.EndLogPerformance = function() end
	
	Plater.StartLogPerformanceCore = function() end
	Plater.EndLogPerformanceCore = function() end
	
	Plater.DumpPerformance(true) -- for VDT mainly atm
	Plater:Msg("Plater stopped profiling.")
	
	if PlaterPerformanceProfilingResultPanel and PlaterPerformanceProfilingResultPanel:IsVisible() then
		Plater.ShowPerfData()
	end
end

--pType = profiling type (e.g. hooks)
function Plater.StartLogPerformance()
end
function Plater.StartLogPerformanceCore()
end
function StartLogPerformance(pType, event, subType)
	if not profilingEnabled or not pType or not event or not subType then return end	
	
	local startTime = debugprofilestop()
	
	local data = profData.data[pType]
	if not data then
		profData.data[pType] = {}
		data = profData.data[pType]
	end
	if not data[event] then
		profData.data[pType][event] = {}
		profData.data[pType][event].subTypeData = {}
	end
	if subType and not data[event].subTypeData[subType] then
		data[event].subTypeData[subType] = {}
	end
	
	
	if not profData.curEvent then
		profData.curEvent = event
		profData.curSub = subType
		data[event].curStartTime = startTime
	end
	
	data[event].subTypeData[subType].curStartTime = startTime
end

--pType = profiling type (e.g. hooks)
function Plater.EndLogPerformance()
end
function Plater.EndLogPerformanceCore()
end
function EndLogPerformance(pType, event, subType)
	if not profilingEnabled or not pType or not event or not subType then return end
	
	local eData = profData.data[pType][event]
	local sData = eData.subTypeData[subType]
	local stopTime = debugprofilestop()
	
	eData.count = (eData.count or 0) + 1
	
	if ((profData.curEvent == event) and (profData.curSub == subType)) then
		profData.totalTimeInPlater = profData.totalTimeInPlater + (stopTime - eData.curStartTime)
		eData.totalTime = (eData.totalTime or 0) + (stopTime - eData.curStartTime)
		eData.curStartTime = nil
		
		profData.curEvent = nil
		profData.curSub = nil

	else
		eData.subLogTime = (eData.subLogTime or 0) + (stopTime - sData.curStartTime)
		eData.totalTime = (eData.totalTime or 0) + (stopTime - sData.curStartTime)
	end
	
	-- add to event subType
	sData.totalTime = (sData.totalTime or 0) + (stopTime - sData.curStartTime)
	sData.count = (sData.count or 0) + 1
	sData.curStartTime = nil
	
end

local function getPerfData()
	local perfTable = {}
	local indent = "    "
	local printStr = ""
	
	perfTable.totalGlobalTime = (profData.endTime or debugprofilestop()) - (profData.startTime or debugprofilestop())
	
	local sumTimePTypes = 0
	local sumExecPTypes = 0
	for pType, data in pairs(profData.data or {}) do
		perfTable[pType] = {}
		local pTypeTime = 0
		local pTypeExec = 0
		local pTypeSubLog = 0
		
		local printStrPType = ""
		for event, pData in pairs(data) do
			perfTable[pType][event] = {}
			pData.count = pData.count or 0
			perfTable[pType][event].total = "avg: " .. roundTime(pData.totalTime / pData.count) .. "ms - count: " .. pData.count .. " - total: " .. roundTime(pData.totalTime - (pData.subLogTime or 0)) .. "ms - (as sub-log: " .. roundTime(pData.subLogTime or 0) .. "ms)"
			pTypeTime = pTypeTime + pData.totalTime - (pData.subLogTime or 0)
			pTypeSubLog = pTypeSubLog + (pData.subLogTime or 0)
			pTypeExec = pTypeExec + pData.count
			printStrPType = printStrPType .. indent .. event .. " - " .. perfTable[pType][event].total .. "\n"
			
			perfTable[pType][event]._subTypeData = {}
			local pTypeSufTime = 0
			local pTypeSufExec = 0
			--printStrPType = printStrPType .. indent .. "Sub-Events:" .. "\n"
			for subType, sufData in pairs(pData.subTypeData) do
				if sufData.totalTime then -- sanity check for bad data
					perfTable[pType][event]._subTypeData[subType] = "avg: " .. roundTime(sufData.totalTime / sufData.count) .. "ms - count: " .. sufData.count .. " - total: " .. roundTime(sufData.totalTime) .. "ms"
					pTypeSufTime = pTypeSufTime + sufData.totalTime
					pTypeSufExec = pTypeSufExec + sufData.count
					printStrPType = printStrPType .. indent .. indent .. subType .. " - " .. perfTable[pType][event]._subTypeData[subType] .. "\n"
				else
					printStrPType = printStrPType .. indent .. indent .. subType .. " - ERROR - NO TOTAL LOGGED\n"
				end
			end
			perfTable[pType][event].pTypeSufTime = pTypeSufTime
			perfTable[pType][event].pTypeSufExec = pTypeSufExec
			
			printStrPType = printStrPType .. "\n"
		end
		perfTable[pType].pTypeTime = pTypeTime
		perfTable[pType].pTypeExec = pTypeExec
		perfTable[pType].pTypeSubLog = pTypeSubLog
		perfTable[pType].pTypeGlobalPercent = pTypeTime / perfTable.totalGlobalTime * 100
		sumTimePTypes = sumTimePTypes + pTypeTime
		sumExecPTypes = sumExecPTypes + pTypeExec
		
		printStr = printStr .. pType .. ":" .. "\n" .. "Total -> count: " .. pTypeExec .. " - time: "  .. roundTime(pTypeTime) .. "ms - %global: " .. roundPercent(perfTable[pType].pTypeGlobalPercent) .. "% - (as sub-log: " .. roundTime(pTypeSubLog) .. "ms)" .. "\n\n" .. printStrPType
		
		printStr = printStr .. "\n"
	end
	
	perfTable.timeInPlaterProfile = (profData.totalTimeInPlater or 0) --sumTimePTypes
	perfTable.totalLoggedEvents = sumExecPTypes
	perfTable.totalAveragePerEvent = perfTable.timeInPlaterProfile / sumExecPTypes
	perfTable.percentGlobalInPlater = perfTable.timeInPlaterProfile / perfTable.totalGlobalTime * 100
	local printStrHeader = ""
	--printStrHeader = printStrHeader .. "Plater profiling data:" .. "\n\n"
	printStrHeader = printStrHeader .. "Plater profiling totals:\n"
	printStrHeader = printStrHeader .. indent .. "Profiling time: " .. roundTime(perfTable.totalGlobalTime / 100000)*100 .. "s" .. "\n"
	printStrHeader = printStrHeader .. indent .. "Time in Plater: " .. roundTime(perfTable.timeInPlaterProfile) .. "ms" .. "\n"
	printStrHeader = printStrHeader .. indent .. "Logged events: " .. perfTable.totalLoggedEvents .. "\n"
	printStrHeader = printStrHeader .. indent .. "Average runtimetime of event: " .. roundTime(perfTable.totalAveragePerEvent) .. "ms" .. "\n"
	printStrHeader = printStrHeader .. indent .. "% of global time: " .. roundPercent(perfTable.percentGlobalInPlater) .. "%" .. "\n\n"
	
	printStr = printStrHeader .. printStr
	
	return perfTable, printStr
end

function Plater.DumpPerformance(noPrintOut)

	local perfTable, printStr = getPerfData()

	if ViragDevTool_AddData then
		ViragDevTool_AddData(perfTable,"Plater Profiling")
	end
	if not noPrintOut then
		print(printStr)
	end
	
	return perfTable, printStr

end

function Plater.ShowPerfData()
	local perfTable, printStr = getPerfData()
	
	if (not PlaterPerformanceProfilingResultPanel) then
		local f = CreateFrame ("frame", "PlaterPerformanceProfilingResultPanel", UIParent, "BackdropTemplate") 
		f:SetSize (800, 700)
		f:EnableMouse (true)
		f:SetMovable (true)
		f:RegisterForDrag ("LeftButton")
		f:SetScript ("OnDragStart", function() f:StartMoving() end)
		f:SetScript ("OnDragStop", function() f:StopMovingOrSizing() end)
		f:SetScript ("OnMouseDown", function (self, button) if (button == "RightButton") then f.TextField:ClearFocus() f:Hide() end end)
		f:SetFrameStrata ("DIALOG")
		f:SetPoint ("center", UIParent, "center", 0, 0)
		f:SetBackdrop ({edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1, bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], tileSize = 64, tile = true})
		f:SetBackdropColor (0, 0, 0, 0.8)
		f:SetBackdropBorderColor (0, 0, 0, 1)
		tinsert (UISpecialFrames, "PlaterPerformanceProfilingResultPanel")
		
		DF:CreateTitleBar (f, "Plater Performance Profiling")
		DF:ApplyStandardBackdrop (f)
		
		local luaeditor_backdrop_color = {.2, .2, .2, .5}
		local luaeditor_border_color = {0, 0, 0, 1}
		local textField = DF:NewSpecialLuaEditorEntry (f, 775, 670, "TextField", "$parentTextField", true, false)
		textField.editbox:SetFontObject ("GameFontHighlight")
		textField:SetPoint ("top", f, "top", -10, -25)
		--textField.editbox:SetEnabled(false)
		textField:SetBackdrop ({edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1, bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], tileSize = 64, tile = true})
		textField:SetBackdropBorderColor (unpack (luaeditor_border_color))
		textField:SetBackdropColor (unpack (luaeditor_backdrop_color))
		DF:ReskinSlider (textField.scroll)
		f.TextField = textField
		
		f:Hide()
		Plater.PlaterPerformanceProfilingResultPanel = f
	end
	
	
	Plater.PlaterPerformanceProfilingResultPanel.TextField:SetText (printStr)
	
	Plater.PlaterPerformanceProfilingResultPanel:Show()
	
end
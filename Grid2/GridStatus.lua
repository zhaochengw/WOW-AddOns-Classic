-- Created by Grid2 original authors, modified by Michael

local Grid2 = Grid2
local next = next
local pairs = pairs

Grid2.statuses = {}
Grid2.statusTypes = {}
Grid2.statusPrototype = {}

-- {{ status prototype
local status = Grid2.statusPrototype
status.__index = status
-- constructor
function status:new(name, embed)
	local e = setmetatable({}, self)
	if embed ~= false then LibStub("AceEvent-3.0"):Embed(e)	end
	e.name = name
	e.indicators = {}
	e.priorities = {}
	return e
end
-- shading color: icon indicator
function status:GetVertexColor()
	return 1,1,1,1
end

-- stacks: text, bar indicators
function status:GetCount()
	return 1
end
-- max posible stacks: bar indicator
function status:GetCountMax()
	return 1
end
-- icon, square, text-color, bar-color indicators
function status:GetColor()
	return 0,0,0,1
end
-- texture coords: icon indicator
status.GetTexCoord = Grid2.statusLibrary.GetTexCoord
-- returns~=nil to colorize icon border with status GetColor(): icon indicator
status.GetBorder = Grid2.Dummy
-- text indicator
status.GetText = Grid2.Dummy
-- expiration time in seconds: bar, icon, text indicators
status.GetExpirationTime = Grid2.Dummy
-- duration in seconds: bar, icon, text indicators
status.GetDuration = Grid2.Dummy
-- start time: text indicators
status.GetStartTime = Grid2.Dummy
-- percent value: alpha, bar indicators
status.GetPercent = Grid2.Dummy
-- texture: icon indicator
status.GetIcon = Grid2.Dummy
-- all indicators
status.OnEnable = Grid2.Dummy
-- all indicators
status.OnDisable = Grid2.Dummy
-- all indicators
status.Refresh = Grid2.Dummy
-- all indicators
status.UpdateAllUnits = Grid2.statusLibrary.UpdateAllUnits

function status:UpdateDB(dbx)
	if dbx then	self.dbx = dbx end
end

function status:Inject(data)
	for k,f in next, data do
		self[k] = f
	end
end

function status:UpdateIndicators(unit)
	for parent in next, Grid2:GetUnitFrames(unit) do
		for indicator in pairs(self.indicators) do
			indicator:Update(parent, unit, self)
		end
	end
end

function status:RegisterIndicator(indicator, priority, suspended)
	if not self.indicators[indicator] then
		self.priorities[indicator] = priority or indicator.priorities[self]
		if not suspended and not self.suspended then
			local enabled = next(self.indicators)
			self.indicators[indicator] = true
			if not enabled then
				self.enabled = true
				self:OnEnable()
			end
		end
	end
end

function status:UnregisterIndicator(indicator, priority)
	if self.indicators[indicator] then
		self.indicators[indicator] = nil
		if not priority then
			self.priorities[indicator] = nil
		end
		local enabled = next(self.indicators)
		if not enabled then
			self.enabled = nil
			self:OnDisable()
		end
	end
end

function Grid2:RegisterStatus(status, types, baseKey, dbx)
	local name = status.name
	self.statuses[name] = status
	for _, type in ipairs(types) do
		local t = self.statusTypes[type]
		if not t then
			t = {}
			self.statusTypes[type] = t
		end
		t[#t+1] = status
	end
	status.dbx = dbx
	status:RegisterLoad()
end

function Grid2:UnregisterStatus(status)
    for _, indicator in Grid2:IterateIndicators() do
		if self.indicators[indicator] then
			indicator:UnregisterStatus(status)
		end
	end
	if status.Destroy then
		status:Destroy()
	end
	local name = status.name
	self.statuses[name] = nil
	for type, t in pairs(self.statusTypes) do
		for i=1,#t do
			if t[i]==status then
				table.remove(t,i)
				break
			end
		end
	end
	status:UnregisterLoad()
end

function Grid2:GetStatusByName(name)
	return self.statuses[name]
end

function Grid2:IterateStatuses(type)
	return next, type and self.statusTypes[type] or self.statuses
end

function Grid2:SetupStatusPrototype()
	status.GetTexCoord = Grid2Frame.db.shared.displayZoomedIcons and Grid2.statusLibrary.GetTexCoordZoomed or Grid2.statusLibrary.GetTexCoord
end

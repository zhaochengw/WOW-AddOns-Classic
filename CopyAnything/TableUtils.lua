local addon = select(2, ...).addon
local tableUtils = {}
addon.tableUtils = tableUtils

-- Returns a new table with a transform applied to all values.
-- @param t Table to apply transforms to.
-- @param transform Function to apply to all values.
-- @return New table with transform applied to values.
function tableUtils.Map(t, transform)
	local newTable = {}
	for k, v in next, t do
		newTable[k] = transform(v)
	end
	return newTable
end

-- Returns a new table with only the values in the given table meeting a condition.
-- @param t Table to filter.
-- @param condition Function that returns a truthy value if the value meets the condition.
-- @return New filtered table.
function tableUtils.Filter(t, condition)
	local newTable = {}
	for _, value in ipairs(t) do
		if condition(value) then
			newTable[#newTable+1] = value
		end
	end
	return newTable
end

-- Returns a new table with no tables as values. All table values are unpacked
-- and inserted into the top top level table.
-- @param t Table to flatten.
-- @number depth Maximum depth to flatten. Past this depth, tables will be left as is.
-- @return New flattened table.
function tableUtils.Flatten(t, depth)
	if not depth then depth = -1 end
	local newTable = {}
	for _, value in ipairs(t) do
		if type(value) == "table" and depth ~= 0 then
			local subValues = tableUtils.Flatten(value, depth - 1)
			for _, subValue in ipairs(subValues) do
				newTable[#newTable+1] = subValue
			end
		else
			newTable[#newTable+1] = value
		end
	end
	return newTable
end

-- Reduce all values in a table down to one.
-- @param t Table to reduce.
-- @param reducer function(accumulator, current) to run for every element of the table. Returns the new accumulator value.
-- @return Reduced value.
function tableUtils.Reduce(t, reducer)
	local accumulator = nil
	for _, current in ipairs(t) do
		accumulator = reducer(accumulator, current)
	end
	return accumulator
end

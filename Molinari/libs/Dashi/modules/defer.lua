local _, addon = ...

local queue = {}
local function iterate()
	for _, info in next, queue do
		if info.callback then
			info.callback(unpack(info.args))
		elseif info.object and info.args then
			info.object[info.method](info.object, unpack(info.args))
		end
	end

	table.wipe(queue)

	return true -- unregister event
end

local function defer(info)
	table.insert(queue, info)

	if not addon:IsEventRegistered('PLAYER_REGEN_ENABLED', iterate) then
		addon:RegisterEvent('PLAYER_REGEN_ENABLED', iterate)
	end
end


--[[ namespace:Defer(_callback_[, _..._]) ![](https://img.shields.io/badge/function-blue)
Defers a function `callback` (with optional arguments) until after combat ends.  
Callback can be the global name of a function.  
Triggers immediately if player is not in combat.
--]]
function addon:Defer(callback, ...)
	if type(callback) == 'string' then
		callback = _G[callback]
	end

	if not callback then
		error('callback is nil') -- TODO: pretty this up
	end

	addon:ArgCheck(callback, 1, 'function')

	if InCombatLockdown() then
		defer({
			callback = callback,
			args = {...},
		})
	else
		callback(...)
	end
end

--[[ namespace:DeferMethod(_object_, _method_[, _..._]) ![](https://img.shields.io/badge/function-blue)
Defers a `method` on `object` (with optional arguments) until after combat ends.  
Triggers immediately if player is not in combat.
--]]
function addon:DeferMethod(object, method, ...)
	addon:ArgCheck(object, 1, 'table')
	addon:ArgCheck(method, 2, 'string')
	addon:ArgCheck(object[method], 2, 'function')

	if InCombatLockdown() then
		defer({
			object = object,
			method = method,
			args = {...},
		})
	else
		object[method](object, ...)
	end
end

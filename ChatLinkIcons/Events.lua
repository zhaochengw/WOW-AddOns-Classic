--[[	ChatLinkIcons - Event Handler
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);
local CallbackObjectClosureCache=setmetatable({},{__mode="kv",__index=function(t,k)
	local func=function(...) return k(...); end
	t[k]=func; return func;
end});

function AddOn.Events_RegisterEvent(event,func)
--	CallbackRegistry doesn't like non-function callbacks (ex. tables and userdata with a __call metamethod)
	do	local type=type(func);
		if type~="function" then
			assert(type=="table" or type=="userdata","Invalid callback type: "..type);
			local meta=assert(getmetatable(func),"Callback object doesn't have a metatable");
			assert(meta.__call,"Callback object doesn't have a \"__call\" metamethod");
			func=CallbackObjectClosureCache[func];
		end
	end

	EventRegistry:RegisterFrameEventAndCallback(event,func);
end

function AddOn.Events_UnregisterEvent(owner,event)
--	Owner is an arbitrary value created by CallbackRegistry passed to the callback as Self
	EventRegistry:UnregisterFrameEventAndCallback(event,owner);
end

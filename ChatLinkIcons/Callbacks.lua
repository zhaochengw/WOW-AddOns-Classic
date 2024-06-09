--[[	ChatLinkIcons - Callback Handler
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);

local CallbackMeta={__index={}};

function CallbackMeta.__index:Register(func)
	if not tContains(self,func) then table.insert(self,func); end
end

function CallbackMeta.__index:Unregister(func)
	local index=tIndexOf(self,func); if index then
		table.remove(self,index);
	end
end

function CallbackMeta.__index:Fire(...)
	for _,func in ipairs(self) do
		xpcall(func,CallErrorHandler,...);
	end
end

CallbackMeta.__call=CallbackMeta.__index.Fire;

function AddOn.Callbacks_New() return setmetatable({},CallbackMeta); end

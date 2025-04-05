--[[	ChatLinkIcons - Link Converter
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);
local TextureFunctions={};

function AddOn.LinkConverter_RegisterLinkProcessor(type,func)
	if TextureFunctions[type] then
		table.insert(TextureFunctions[type],func);
	else TextureFunctions[type]={func}; end
end

local ConvertCache={};
local function CallLinkProcessors(type,id,text,...)
	local funclist=TextureFunctions[type];
	if not funclist then return; end

	for _,func in ipairs(funclist) do
		local ok,pre,post=xpcall(func,CallErrorHandler,type,id,text,...);
		if ok and (pre or post) then
			if pre then table.insert(ConvertCache,1,pre); end
			if post then table.insert(ConvertCache,post); end
		end
	end
end

local function LinkConverterCallback(link,type,id,text)
	table.insert(ConvertCache,link);
	CallLinkProcessors(type,id,text,(":"):split(id));

	local replace=(#ConvertCache>1 and table.concat(ConvertCache) or nil);
	table.wipe(ConvertCache);
	return replace;
end

function AddOn.LinkConverter_ConvertLinks(str)
	local fix; str,fix=str:gsub("(|H([^:|]+):([^|]-)|h(.-)|h)",LinkConverterCallback);
	if fix>0 then
--		Fix links with color codes having textures inserted inside them
		repeat str,fix=str:gsub("(|c%x%x%x%x%x%x%x%x)(%s*|T[^|]*|t%s*)","%2%1"); until fix<=0
		repeat str,fix=str:gsub("(%s*|T[^|]*|t%s*)(|r)","%2%1"); until fix<=0
	end
	return str;
end

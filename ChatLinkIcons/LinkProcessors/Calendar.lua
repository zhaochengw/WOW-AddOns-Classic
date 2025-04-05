--[[	ChatLinkIcons - Calendar Link Processor
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);

AddOn.Options.Links_CalendarEvent=true;

AddOn.Options_CreateOptionButton(1,"Links_CalendarEvent");

AddOn.LinkConverter_RegisterLinkProcessor("calendarEvent",function(_,_,_,offset,day,index)--	(type,id,text,...)
	if not AddOn.Options.Links_CalendarEvent then return; end
	local event=C_Calendar.GetDayEvent(tonumber(offset),tonumber(day),tonumber(index));
	return event and AddOn.LinkProcessorTools_CreateTextureMarkup(event.iconTexture);
end);

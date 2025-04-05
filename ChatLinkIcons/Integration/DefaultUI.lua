--[[	ChatLinkIcons - DefaultUI Integration
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);

------------------------------------------
--[[	ScrollingMessageFrame Hooks	]]
------------------------------------------
local FontString_SetText=UIParent:CreateFontString().SetText;

local function ScrollingMessageFrameFontString_SetText(self,str)
	FontString_SetText(self,AddOn.LinkConverter_ConvertLinks(str));
--	getmetatable(self).__index.SetText(self,);
end

local function ScrollingMessageFrameFontString_SetFormattedText(self,fmt,...)
	ScrollingMessageFrameFontString_SetText(self,fmt:format(...));
end

local HookedFontStrings={};
local function ScrollingMessageFrame_AcquireFontString(self)
	for fontstring in self.fontStringPool:EnumerateActive() do
		if not HookedFontStrings[fontstring] then
--			hooksecurefunc(fontstring,"SetText",ScrollingMessageFrameFontString_SetText);
--			hooksecurefunc(fontstring,"SetFormattedText",ScrollingMessageFrameFontString_SetFormattedText);

--			Insecure, but as of 10.1.5, the mainline client is having problems with links becoming uninteractable if :SetText() is called in quick succession
			fontstring.SetText=ScrollingMessageFrameFontString_SetText;
			fontstring.SetFormattedText=ScrollingMessageFrameFontString_SetFormattedText;

			HookedFontStrings[fontstring]=true;
		end
	end
end

local HookedFrames={};
function AddOn.Integration_DefaultUI_HookScrollingMessageFrame(frame)
	if not HookedFrames[frame] then
		hooksecurefunc(frame,"AcquireFontString",ScrollingMessageFrame_AcquireFontString);
		HookedFrames[frame]=true;
	end
end

AddOn.IntegrationTools_MessageUpdateDispatcher:Register(function()
	for frame in pairs(HookedFrames) do frame:MarkDisplayDirty(); end
end);

--------------------------
--[[	ChatFrame Hooks	]]
--------------------------
for i=1,NUM_CHAT_WINDOWS do AddOn.Integration_DefaultUI_HookScrollingMessageFrame(_G["ChatFrame"..i]); end
hooksecurefunc("ChatFrame_OnLoad",AddOn.Integration_DefaultUI_HookScrollingMessageFrame);

local iu = InterfaceUsage;
local poll = iu:CreatePollType("Event Calls");

local eventFrame = CreateFrame("Frame");

local eventList = {};

poll.sortMethod = "rawCount";

-- Columns
poll[1] = { label = "name",				width = 250, align = "LEFT" };
poll[2] = { label = "count",			width = 80, color = { 0.5, 0.75, 1 }, fmt = "%d" };
poll[3] = { label = "rawCount",			width = 80, color = { 0.5, 0.75, 1 }, fmt = "%d" };
poll[4] = { label = "countTotal",		width = -1, color = { 0.5, 0.75, 1 }, fmt = "%d" };

-- returns an existing event data table, or creates a new
local function GetEventDataByName(event)
	local eventData = eventList[event];
	if (not eventData) then
		eventData = { name = event, count = 0, rawCount = 0, countTotal = 0, countLast = 0 };
		eventList[event] = eventData;
		poll.data[#poll.data + 1] = eventData;
	end
	return eventData;
end

-- HOOK: OnEvent
local function OnEventHook(self,event,...)
	local eventData = GetEventDataByName(event);
	eventData.countTotal = (eventData.countTotal + 1);
end

-- Our own OnEvent
local function OnEvent(self,event,...)
	local eventData = GetEventDataByName(event);
	eventData.rawCount = (eventData.rawCount + 1);
end

-- OnInitialize
function poll:OnInitialize()
	local frame = EnumerateFrames();
	while (frame) do
		if (frame:GetScript("OnEvent")) then
			frame:HookScript("OnEvent",OnEventHook);
		end
		frame = EnumerateFrames(frame);
	end
	eventFrame:RegisterAllEvents();
	eventFrame:SetScript("OnEvent",OnEvent);
end

-- OnReset
function poll:OnPoll()
	for event, data in next, eventList do
		data.count = (data.countTotal - data.countLast);
		data.countLast = data.countTotal;
	end
end

-- OnReset
function poll:OnReset()
	for event, data in next, eventList do
		data.countTotal = 0;
		data.rawCount = 0;
	end
end
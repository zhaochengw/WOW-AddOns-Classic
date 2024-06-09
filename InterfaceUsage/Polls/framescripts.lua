local iu = InterfaceUsage;
local onEvent = iu:CreatePollType("Frame OnEvent Usage");
local onUpdate = iu:CreatePollType("Frame OnUpdate Usage");

local debugprofilestart = debugprofilestart;
local debugprofilestop = debugprofilestop;

--------------------------------------------------------------------------------------------------------
--                                           Shared Function                                          --
--------------------------------------------------------------------------------------------------------

-- OnInitialize
local function OnInitialize(self)
	local frame = EnumerateFrames();
	while (frame) do
		self:HookFrame(frame);
		frame = EnumerateFrames(frame);
	end
end

-- OnReset
local function OnReset(self)
	for frame, data in next, self.hookedFrames do
		data.totalTime = 0;
		data.calls = 0;
	end
end

-- hook frame
local function HookFrame(self,frame)
	local scriptFunc = frame:GetScript(self.scriptType);
	if (scriptFunc) then
		frame:SetScript(self.scriptType,self.hookFunc);
		local frameName = frame:GetDebugName();	-- now uses GetDebugName() instead of GetName()
		if (not frameName) or (frameName == "") then
			frameName = "|cffa0a0a0"..tostring(frame);
		end
		self.hookedFrames[frame] = {
			frame = frame,
			name = frameName,
			time = 0,
			totalTime = 0,
			calls = 0,
			scriptFunc = scriptFunc,
		};
		self.data[#self.data + 1] = self.hookedFrames[frame];
	end
end

--------------------------------------------------------------------------------------------------------
--                                           OnEvent Polling                                          --
--------------------------------------------------------------------------------------------------------

onEvent.hookedFrames = {};
onEvent.scriptType = "OnEvent";
onEvent.sortMethod = "totalTime";
onEvent.OnInitialize = OnInitialize;
onEvent.OnReset = OnReset;
onEvent.HookFrame = HookFrame;

-- Columns
onEvent[1] = { label = "name",			width = 260, align = "LEFT" };
onEvent[2] = { label = "time",			width = 80, color = { 0.5, 0.75, 1 }, fmt = "%.4f" };
onEvent[3] = { label = "totalTime",		width = 80, color = { 0.5, 0.75, 1 }, fmt = "%.4f" };
onEvent[4] = { label = "calls",			width = -1, color = { 0.5, 0.75, 1 }, fmt = "%d" };

-- HOOK: OnEvent
function onEvent.hookFunc(self,event,...)
	local data = onEvent.hookedFrames[self];
	debugprofilestart();
	data.scriptFunc(self,event,...);
	data.time = debugprofilestop();
	data.totalTime = (data.totalTime + data.time);
	data.calls = (data.calls + 1);
end

--------------------------------------------------------------------------------------------------------
--                                          OnUpdate Polling                                          --
--------------------------------------------------------------------------------------------------------

onUpdate.hookedFrames = {};
onUpdate.scriptType = "OnUpdate";
onUpdate.sortMethod = "totalTime";
onUpdate.OnInitialize = OnInitialize;
onUpdate.OnReset = OnReset;
onUpdate.HookFrame = HookFrame;

-- Columns
onUpdate[1] = { label = "name",			width = 260, align = "LEFT" };
onUpdate[2] = { label = "time",			width = 80, color = { 0.5, 0.75, 1 }, fmt = "%.4f" };
onUpdate[3] = { label = "totalTime",	width = 80, color = { 0.5, 0.75, 1 }, fmt = "%.4f" };
onUpdate[4] = { label = "calls",		width = -1, color = { 0.5, 0.75, 1 }, fmt = "%d" };

-- HOOK: OnUpdate
function onUpdate.hookFunc(self,event,...)
	local data = onUpdate.hookedFrames[self];
	debugprofilestart();
	data.scriptFunc(self,event,...);
	data.time = debugprofilestop();
	data.totalTime = (data.totalTime + data.time);
	data.calls = (data.calls + 1);
end
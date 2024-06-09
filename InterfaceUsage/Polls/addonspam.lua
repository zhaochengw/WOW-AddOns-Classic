local iu = InterfaceUsage;
local prefixPoll = iu:CreatePollType("Addon Spam by Prefix");
local playerPoll = iu:CreatePollType("Addon Spam by Player");
local channelPoll = iu:CreatePollType("Addon Spam by Channel");

local f = CreateFrame("Frame");

-- OnInitialize
local function OnInitialize(self)
	f:RegisterEvent("CHAT_MSG_ADDON");
	self.hash = {};
end

-- OnReset
--local function OnPoll(self)
--end

-- OnReset
local function OnReset(self)
	for entry, data in next, self.hash do
		data.count = 0;
	end
end

-- Add Spam Entry
local function AddSpamEntry(self,entry)
	local data = self.hash[entry];
	if (not data) then
		data = { name = entry, count = 0 };
		self.hash[entry] = data;
		self.data[#self.data + 1] = data;
	end
	data.count = (data.count + 1);
end

--------------------------------------------------------------------------------------------------------
--                                           Spam By Prefix                                           --
--------------------------------------------------------------------------------------------------------

prefixPoll.sortMethod = "count";
prefixPoll.OnInitialize = OnInitialize;
--prefixPoll.OnPoll = OnPoll;
prefixPoll.OnReset = OnReset;
prefixPoll.AddSpamEntry = AddSpamEntry;

-- Columns
prefixPoll[1] = { label = "name", 		width = 400, align = "LEFT" };
prefixPoll[2] = { label = "count",		width = -1, color = { 0.5, 0.75, 1 }, fmt = "%d" };

--------------------------------------------------------------------------------------------------------
--                                           Spam By Player                                           --
--------------------------------------------------------------------------------------------------------

playerPoll.sortMethod = "count";
playerPoll.OnInitialize = OnInitialize;
--playerPoll.OnPoll = OnPoll;
playerPoll.OnReset = OnReset;
playerPoll.AddSpamEntry = AddSpamEntry;

-- Columns
playerPoll[1] = { label = "name", 		width = 400, align = "LEFT" };
playerPoll[2] = { label = "count",		width = -1, color = { 0.5, 0.75, 1 }, fmt = "%d" };

--------------------------------------------------------------------------------------------------------
--                                           Spam By Channel                                          --
--------------------------------------------------------------------------------------------------------

channelPoll.sortMethod = "count";
channelPoll.OnInitialize = OnInitialize;
--channelPoll.OnPoll = OnPoll;
channelPoll.OnReset = OnReset;
channelPoll.AddSpamEntry = AddSpamEntry;

-- Columns
channelPoll[1] = { label = "name",		width = 400, align = "LEFT" };
channelPoll[2] = { label = "count",		width = -1, color = { 0.5, 0.75, 1 }, fmt = "%d" };

--------------------------------------------------------------------------------------------------------
--                                            Message Frame                                           --
--------------------------------------------------------------------------------------------------------

f:SetScript("OnEvent",function(self,event,prefix,msg,type,sender)
	if (prefixPoll.hash) then
		prefixPoll:AddSpamEntry(prefix);
	end
	if (playerPoll.hash) then
		playerPoll:AddSpamEntry(sender);
	end
	if (channelPoll.hash) then
		channelPoll:AddSpamEntry(type);
	end
end);
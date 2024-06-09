local iu = InterfaceUsage;
local mem = iu:CreatePollType("Addon Memory Usage");
local cpu = iu:CreatePollType("Addon CPU Usage");

local GetAddOnCPUUsage = GetAddOnCPUUsage;
local GetAddOnMemoryUsage = GetAddOnMemoryUsage;

-- Addons OnInitialize
local function OnInitialize(self)
	for i = 1, GetNumAddOns() do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
		self.data[i] = { name = name, title = title, enabled = enabled, loadable = loadable, reason = reason, security = security };
	end
end

--------------------------------------------------------------------------------------------------------
--                                            Memory Module                                           --
--------------------------------------------------------------------------------------------------------

mem.sortMethod = "memUsageGrowth";
mem.OnInitialize = OnInitialize;

-- Columns
mem[1] = { label = "name", 				width = 240, align = "LEFT" };
mem[2] = { label = "memUsage",			width = 70, color = { 0.5, 0.75, 1 }, fmt = "%.2f" };
mem[3] = { label = "memUsageTotal",		width = 90, color = { 0.5, 0.75, 1 }, fmt = "%.2f" };
mem[4] = { label = "memUsageGrowth",	width = -1, color = { 0.5, 0.75, 1 }, fmt = "%.2f" };

-- OnPoll
function mem:OnPoll()
	UpdateAddOnMemoryUsage();
	for index, addon in ipairs(self.data) do
		addon.memUsagePrev = (addon.memUsageTotal or 0);
		addon.memUsageTotal = GetAddOnMemoryUsage(addon.name);
		addon.memUsage = (addon.memUsageTotal - addon.memUsagePrev);
		addon.memUsageGrowth = (addon.memUsageTotal - addon.memUsageStart);
	end
end

-- OnReset
function mem:OnReset()
	UpdateAddOnMemoryUsage();
	for index, addon in ipairs(self.data) do
		addon.memUsageStart = GetAddOnMemoryUsage(addon.name);
	end
end

--------------------------------------------------------------------------------------------------------
--                                             CPU Module                                             --
--------------------------------------------------------------------------------------------------------

cpu.sortMethod = "cpuTimeGrowth";
cpu.OnInitialize = OnInitialize;

-- Columns
cpu[1] = { label = "name", 				width = 240, align = "LEFT" };
cpu[2] = { label = "cpuTime",			width = 70, color = { 0.5, 0.75, 1 }, fmt = "%.3f" };
cpu[3] = { label = "cpuTimeTotal",		width = 90, color = { 0.5, 0.75, 1 }, fmt = "%.2f" };
cpu[4] = { label = "cpuTimeGrowth",		width = -1, color = { 0.5, 0.75, 1 }, fmt = "%.2f" };

-- OnPoll
function cpu:OnPoll()
	UpdateAddOnCPUUsage();
	for index, addon in ipairs(self.data) do
		addon.cpuTimePrev = (addon.cpuTimeTotal or 0);
		addon.cpuTimeTotal = GetAddOnCPUUsage(addon.name);
		addon.cpuTime = (addon.cpuTimeTotal - addon.cpuTimePrev);
		addon.cpuTimeGrowth = (addon.cpuTimeTotal - addon.cpuTimeStart);
	end
end

-- OnReset
function cpu:OnReset()
	UpdateAddOnCPUUsage();
	for index, addon in ipairs(self.data) do
		addon.cpuTimeStart = GetAddOnCPUUsage(addon.name);
	end
end
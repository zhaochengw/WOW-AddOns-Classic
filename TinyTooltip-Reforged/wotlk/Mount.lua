
local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local LibSchedule = LibStub:GetLibrary("LibSchedule.7000")

local addon = TinyTooltipReforged
local mounts = {}

if (not C_MountJournal) then return end

local function GetAllMountSource()
    local mountIDs = C_MountJournal.GetMountIDs()
    local _, spellID, isCollected, source
    for i, mountID in ipairs(mountIDs) do
        _, spellID, _, _, _, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
        _, _, source = C_MountJournal.GetMountInfoExtraByID(mountID)
        mounts[spellID] = {
            source = source,
            isCollected = isCollected,
        }
    end
    if (#mounts > 0) then return true end
end

LibEvent:attachEvent("VARIABLES_LOADED", function()
    LibSchedule:AddTask({
        identity = "GetAllMountSource",
        elasped  = 10,
        begined  = GetTime() + 10,
        expired  = GetTime() + 100,
        override = true,
        onExecute = GetAllMountSource,
    })
end)

hooksecurefunc(GameTooltip, "SetUnitBuff", function(self, ...)
    local spellID = select(10, UnitBuff(...))
    if (mounts[spellID]) then
        self:AddLine(" ")
        if (mounts[spellID].isCollected) then
            self:AddDoubleLine(mounts[spellID].source, COLLECTED, 1, 1, 1, 0.1, 1, 0.1)
        else
            self:AddLine(mounts[spellID].source, 1, 1, 1)
        end
        self:Show()
    end
end)

-- FishingPlans
--
-- Let's make a plan that we can carry through with, allowing us to group
-- item choices instead of handling each item separately.

-- 5.0.4 has a problem with a global "_" (see some for loops below)
local _

local FL = LibStub("LibFishing-1.0");

local GSB = FishingBuddy.GetSettingBool
local CurLoc = GetLocale();

local FishingPlans = {}

function FishingPlans:HaveThing(itemid, info)
    return GetItemCount(itemid) > 0;
end

function FishingPlans:ItemCooldownOn(id)
    local start, duration, enable = GetItemCooldown(id);
    local et = (start + duration) - GetTime();
    if (et > 0) then
        return true;
    end
    -- return false
end

function FishingPlans:AlreadyUsedFishingItem(id, info)
    if (info.spell) then
        return FL:HasBuff(info.spell);
    end
end

function FishingPlans:CanUseFishingItem(id, info)
    if not info.setting or GSB(info.setting) then
        if self:HaveThing(id, info) and (not info.usable or info.usable(info) ) then
            if (not info[CurLoc]) then
                info[CurLoc] = GetItemInfo(id);
            end
            if not (self:AlreadyUsedFishingItem(id, info) or self:ItemCooldownOn(id, info)) then
                return true;
            end
        end
    end
    return false;
end

function FishingPlans:CanUseFishingItems(items)
    for id, info in pairs(items) do
        if self:CanUseFishingItem(id, info) then
            return true, id, info.curLoc, nil;
        end
    end
    return false;
end

FishingPlans.planners = {}
function FishingPlans:RegisterPlan(planner)
    tinsert(self.planners, planner)
end

FishingPlans.planqueue = {}
function FishingPlans:HavePlans()
    return #self.planqueue > 0
end

function FishingPlans:HaveEntry(itemid, name, targetid)
    if itemid then
        for _, plan in ipairs(self.planqueue) do
            if (not itemid or plan.itemid == itemid) and
            (not name or plan.name == name) and
            (not targetid or plan.targetid == targetid) then
                return true
            end
        end
    end
    return nil
end

function FishingPlans:AddEntry(itemid, name, targetid)
    if itemid then
        tinsert(self.planqueue, {
            ["itemid"] = itemid,
            ["name"] = name,
            ["targetid"] = targetid
        })
    end
end

function FishingPlans:GetPlan()
    if self:HavePlans() then
        local head = table.remove(self.planqueue, 1)
        return true, head.itemid, head.name, head.targetid
    end
    -- return nil
end

function FishingPlans:ExecutePlans(force)
    if (force or not self:HavePlans()) then
        self.planqueue = {}
        for _,planner in ipairs(self.planners) do
            planner(self.planqueue)
        end
    end
end

FishingBuddy.FishingPlans = FishingPlans

local PlanEvents = {}
PlanEvents[FBConstants.FISHING_DISABLED_EVT] = function()
    FishingPlans.planqueue = {}
end

FishingBuddy.RegisterHandlers(PlanEvents);


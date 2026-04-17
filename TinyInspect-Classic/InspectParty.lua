
local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local LibSchedule = LibStub:GetLibrary("LibSchedule.7000")

local members, numMembers = {}, 0

local function InspectDone()
    for guid, v in pairs(members) do
        if (not v.done) then
            return false
        end
    end
    return true
end

local function GetMembers(num)
    local unit, guid
    local temp = {}
    for i = 1, num do
        unit = "party"..i
        guid = UnitGUID(unit)
        if (guid) then temp[guid] = unit end
    end
    for guid, v in pairs(members) do
        if (not temp[guid]) then
            members[guid] = nil
        end
    end
    for guid, unit in pairs(temp) do
        if (members[guid]) then
            members[guid].done = false
            members[guid].unit = unit
            members[guid].class = select(2, UnitClass(unit))
        else
            members[guid] = {
                done   = false,
                unit   = unit,
                class  = select(2, UnitClass(unit)),
                ilevel = -1,
            }
        end
        members[guid].name, members[guid].realm = UnitName(unit)
        if (not members[guid].realm) then
            members[guid].realm = GetRealmName()
        end
    end
end

local function SendInspect()
    if (GetInspecting()) then return end
    for guid, v in pairs(members) do
        if ((not v.done or v.ilevel <= 0) and UnitIsConnected(v.unit) and CanInspect(v.unit)) then
            ClearInspectPlayer()
            NotifyInspect(v.unit)
            LibEvent:trigger("PARTY_INSPECT_STARTED", v)
            return v
        end
    end
end

local SendAddonMessage = C_ChatInfo and C_ChatInfo.SendAddonMessage or function() end

local function SendPlayerInfo()
    local ilvl = select(2, GetAverageItemLevel())
    local spec = select(2, GetSpecializationInfoByID(GetInspectSpecialization("player")))
    SendAddonMessage("TinyInspect-Classic", format("%s|%s|%s", "LV", ilvl, spec or ""), "PARTY")
end

LibEvent:attachEvent("CHAT_MSG_ADDON", function(self, prefix, text, channel, sender)
    if (prefix == "TinyInspect-Classic" and channel == "PARTY") then
        local flag, ilvl, spec = strsplit("|", text)
        if (flag ~= "LV") then return end
        local name, realm = strsplit("-", sender)
        for guid, v in pairs(members) do
            if (v.name == name and v.realm == realm) then
                v.slevel = ilvl
                v.done = true
            end
        end
    end
end)

LibEvent:attachTrigger("UNIT_INSPECT_READY", function(self, data)
    local member = members[data.guid]
    if (member) then
        member.ilevel = data.ilevel
        member.spec = data.spec
        member.name = data.name
        member.class = data.class
        member.realm = data.realm
        member.done = true
    end
end)

LibEvent:attachEvent("GROUP_ROSTER_UPDATE", function(self)

	--[[if (TinyInspectClassicDB and IsInGroup() and not TinyInspectClassicDB.EnablePartyItemLevel) then
		if(IsInRaid() and not TinyInspectClassicDB.EnableRaidItemLevel) then
			return TinyInspectRaidFrame:Hide() 
		else
			return
		end
	end]]--
	local cfg = TinyInspectClassicDB or {}
    local f = _G.TinyInspectRaidFrame
	
	if(not TinyInspectClassicDB)then return end
	
	-- => Both options disabled => hide frame and stop
    if not cfg.EnablePartyItemLevel and not cfg.EnableRaidItemLevel then
        if f then f:Hide() end
        return
    end

    -- => Not in any group => hide frame and stop
    if not IsInGroup() then
        if f then f:Hide() end
        return
    end

    -- => In party (not raid)
    if not IsInRaid() then
        -- => Party option disabled => hide frame and stop
        if not cfg.EnablePartyItemLevel then
            if f then f:Hide() end
            return
        end
        -- => Party option enabled => show frame and continue
        if f then f:Show() end

    else
        -- => In raid
        -- => Raid option disabled => hide frame and stop
        if not cfg.EnableRaidItemLevel then
            if f then f:Hide() end
            return
        end
        -- => Raid option enabled => show frame and stop (raid file continues)
        if f then f:Show() end
        return
    end

    local numCurrent = GetNumSubgroupMembers()
	
    if (numCurrent > numMembers) then
        GetMembers(numCurrent)
        members[UnitGUID("player")] = {
            name   = UnitName("player"),
            class  = select(2, UnitClass("player")),
            ilevel = select(2, GetAverageItemLevel()),
            done   = true,
            unit   = "player",
            spec   = select(2, GetSpecializationInfoByID(GetInspectSpecialization("player"))),
        }

        SendPlayerInfo()
        LibSchedule:AddTask({
            override  = true,
            identity  = "InspectParty",
            timer     = 1,
            elasped   = 1,
            begined   = GetTime() + 2,
            expired   = GetTime() + 30,
            onTimeout = function(self)
                if (GetNumSubgroupMembers()==0) then return end
                LibEvent:trigger("PARTY_INSPECT_TIMEOUT", members)
            end,
            onExecute = function(self)
                if (IsInRaid()) then return true end
                if (InspectDone()) then
                    LibEvent:trigger("PARTY_INSPECT_DONE", members)
                    return true
                end
                SendInspect()
            end,
        })
		--TinyInspectRaidFrame:Show()
    end
    numMembers = numCurrent
end)

LibEvent:attachEvent("VARIABLES_LOADED, PLAYER_ENTERING_WORLD", function()
    LibEvent:event("GROUP_ROSTER_UPDATE")
end)

local label = "<" .. (ITEM_LEVEL_ABBR or "ItemLevel") .. ">"

local function GetRoleIcon(unit)
    local role = UnitGroupRolesAssigned(unit)
    if (role == "TANK") then
        return "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES:14:14:0:0:64:64:0:19:22:41|t"
    elseif (role == "HEALER") then
        return "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES:14:14:0:0:64:64:20:39:1:20|t"
    elseif (role == "DAMAGER") then
        return "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES:14:14:0:0:64:64:20:39:22:41|t"
    else
        return ""
    end
end

local function PrintItemLevel(members)
    local num, pattern = 26, "  %s %.1f |c%s%s|r"
    if (TinyInspectClassicDB and TinyInspectClassicDB.ShowPartySpecialization) then
        num, pattern = 32, "  %s %.1f |c%s%s|r |cffcccccc%s|r"
    end
    DEFAULT_CHAT_FRAME:AddMessage(string.rep("-", num), 1, 0.64, 0)
    for _, v in pairs(members) do
        if (v.done or v.slevel or v.ilevel > 0) then
            DEFAULT_CHAT_FRAME:AddMessage(format(pattern,
                GetRoleIcon(v.unit),
                v.slevel or v.ilevel,
                select(4, GetClassColor(v.class)),
                v.name,
                v.spec and "("..v.spec..")" or ""
            ), 1, 0.82, 0)
        end
    end
    DEFAULT_CHAT_FRAME:AddMessage(string.rep("-", num), 1, 0.64, 0)
end

local lastBroadcastTimer = 0
local function filter(self, event, msg, name, ...)
    if (string.find(msg, label)) then
        local uname = UnitName("player") .. "-" .. GetRealmName()
        if (name ~= uname) then
            lastBroadcastTimer = GetTime()
        end
    end
    return false, msg, name, ...
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", filter)

local function SendItemLevel(members)
    if (GetTime() - lastBroadcastTimer < 5) then return end
    local channel = IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or "PARTY"
    local num, pattern = 26, "%s %.1f %s"
    if (TinyInspectClassicDB and TinyInspectClassicDB.ShowPartySpecialization) then
        num, pattern = 30, "%s %.1f %s %s"
    end
    SendChatMessage(string.rep("-", num), channel)
    for _, v in pairs(members) do
        if (v.done or v.slevel or v.ilevel > 0) then
            SendChatMessage(format(pattern, label, v.slevel or v.ilevel, v.name, v.spec and "("..v.spec..")" or ""), channel)
        end
    end
    SendChatMessage(string.rep("-", num), channel)
end

LibEvent:attachTrigger("PARTY_INSPECT_DONE, PARTY_INSPECT_TIMEOUT", function(self, members)
    if (TinyInspectClassicDB and TinyInspectClassicDB.SendPartyItemLevelToSelf) then
        PrintItemLevel(members)
    end
    if (TinyInspectClassicDB and TinyInspectClassicDB.SendPartyItemLevelToParty) then
        SendItemLevel(members)
    end
end)

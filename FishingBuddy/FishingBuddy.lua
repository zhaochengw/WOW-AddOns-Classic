-- FishingBuddy
--
-- Everything you wanted support for in your fishing endeavors

-- 5.0.4 has a problem with a global "_" (see some for loops below)
local _

local FL = LibStub("LibFishing-1.0");
local HBD = FL.HBD;
local LO = LibStub("LibOptionsFrame-1.0");

local CurLoc = GetLocale();
local PLANS = FishingBuddy.FishingPlans;

-- Information for the stylin' fisherman
local POLES = {
    ["Fishing Pole"] = "6256:0:0:0",
    ["Strong Fishing Pole"] = "6365:0:0:0",
    ["Darkwood Fishing Pole"] = "6366:0:0:0",
    ["Big Iron Fishing Pole"] = "6367:0:0:0",
    ["Blump Family Fishing Pole"] = "12225:0:0:0",
    ["Nat Pagle's Extreme Angler FC-5000"] = "19022:0:0:0",
    ["Arcanite Fishing Pole"] = "19970:0:0:0",
    ["Seth's Graphite Fishing Pole"] = "25978:0:0:0",
    ["Nat's Lucky Fishing Pole"] = "45858:0:0:0",
    ["Mastercraft Kalu'ak Fishing Pole"] = "44050:0:0:0",
    ["Bone Fishing Pole"] = "45991:0:0:0",
    ["Jeweled Fishing Pole"] = "45992:0:0:0",
    ["Staats' Fishing Pole"] = "46337:0:0:0",
    ["Pandaren Fishing Pole"] = "84660:0:0:0",
    ["Dragon Fishing Pole"] = "84661:0:0:0",
    ["Ephemeral Fishing Pole"] = "118381:0:0:0",
    ["Savage Fishing Pole"] = "116825:0:0:0",
    ["Draenic Fishing Pole"] = "116826:0:0:0",
    ["Underlight Angler"] = "133755:0:0:0",
-- yeah, so you can't really use these (for now :-)
    ["Dwarven Fishing Pole"] = "3567:0:0:0",
    ["Goblin Fishing Pole"] = "4598:0:0:0",
    ["Nat Pagle's Fish Terminator"] = "19944:0:0:0",
    ["Thruk's Heavy Duty Fishing Pole"] = "120164:0:0:0",
-- one can only hope
    ["Crafty's Pole"] = "43651:0:0:0"
}

local GeneralOptions = {
    ["ShowNewFishies"] = {
        ["text"] = FBConstants.CONFIG_SHOWNEWFISHIES_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_SHOWNEWFISHIES_INFO,
        ["v"] = 1,
        ["default"] = true },
    ["TurnOffPVP"] = {
        ["text"] = FBConstants.CONFIG_TURNOFFPVP_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_TURNOFFPVP_INFO,
        ["v"] = 1,
        ["m"] = 1,
        ["default"] = false },
    ["SortByPercent"] = {
        ["text"] = FBConstants.CONFIG_SORTBYPERCENT_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_SORTBYPERCENT_INFO,
        ["v"] = 1,
        ["default"] = true },
    ["ShowBanner"] = {
        ["text"] = FBConstants.CONFIG_SHOWBANNER_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_SHOWBANNER_INFO,
        ["v"] = 1,
        ["default"] = true, },
    ["EnhanceFishingSounds"] = {
        ["text"] = FBConstants.CONFIG_ENHANCESOUNDS_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_ENHANCESOUNDS_INFO,
        ["v"] = 1,
        ["m"] = 1,
        ["p"] = 1,
        ["default"] = false },
    ["BackgroundSounds"] = {
        ["text"] = FBConstants.CONFIG_BGSOUNDS_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_BGSOUNDS_INFO,
        ["v"] = 1,
        ["m"] = 1,
        ["default"] = false,
        ["parents"] = { ["EnhanceFishingSounds"] = "d" }, },
    ["TurnOnSound"] = {
        ["text"] = FBConstants.CONFIG_TURNONSOUND_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_TURNONSOUND_INFO,
        ["v"] = 1,
        ["m"] = 1,
        ["default"] = false,
        ["parents"] = { ["EnhanceFishingSounds"] = "d", },
    },
    ["MaxSound"] = {
        ["tooltip"] = FBConstants.CONFIG_MAXSOUND_INFO,
        ["parents"] = { ["EnhanceFishingSounds"] = "d", },
        ["button"] = "FishingBuddyOption_MaxVolumeSlider",
        ["margin"] = { 12, 8 }, },
    ["EnhancePools"] = {
        ["text"] = FBConstants.CONFIG_SPARKLIES_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_SPARKLIES_INFO,
        ["v"] = 1,
        ["default"] = false,
        ["parents"] = { ["EnhanceFishingSounds"] = "d" },
    },
    ["TownsfolkTracker"] = {
        ["text"] = FBConstants.CONFIG_TOWNSFOLK_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_TOWNSFOLK_INFO,
        ["v"] = 1,
        ["global"] = true,
        ["default"] = false
    },
};

-- x87bliss has implemented IsFishWardenEnabled as a public function, so
-- we can retire the GUID based check
local function IsWardenEnabled()
    -- local FishWarden = FishWarden_79a6ca19_6666_4759_9b8f_a67708694e5b;
    local doautoloot = 1;
    if ( FiWaAPI_IsFishWardenEnabled and FiWaAPI_IsFishWardenEnabled() ) then
        doautoloot = 0;
    end
    return "d", doautoloot;
end

local function IsFishingAceEnabled()
--	return FishingAce and FishingAce.enabledState;
    if ( FishingAce and FishingAce.enabledState ) then
        return true;
    end
    return false;
end

-- we want to do all the magic stuff even when we didn't equip anything
local autopoleframe = CreateFrame("Frame");
autopoleframe:Hide();

local function AreWeFishing()
    return (FishingBuddy.StartedFishing ~= nil or autopoleframe:IsShown());
end
FishingBuddy.AreWeFishing = AreWeFishing

local EasyCastInit;

local CastingOptions = {
    ["EasyCast"] = {
        ["text"] = FBConstants.CONFIG_EASYCAST_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_EASYCAST_INFO,
        ["tooltipd"] = FBConstants.CONFIG_EASYCAST_INFOD,
        ["enabled"] = function() return (not IsFishingAceEnabled()) and 1 or 0 end,
        ["init"] = function(o, b) EasyCastInit(o, b); end,
        ["v"] = 1,
        ["m"] = 1,
        ["p"] = 1,
        ["default"] = true },
    ["MountedCast"] = {
        ["text"] = FBConstants.CONFIG_MOUNTEDCAST_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_MOUNTEDCAST_INFO,
        ["v"] = 1,
        ["parents"] = { ["EasyCast"] = "d", },
        ["active"] = function(i, s, b) return not IsMounted() or b end,
        ["default"] = false },
    ["AutoLoot"] = {
        ["text"] = FBConstants.CONFIG_AUTOLOOT_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_AUTOLOOT_INFO,
        ["tooltipd"] = function()
                        if ( FiWaAPI_IsFishWardenEnabled and not IsFishingAceEnabled() ) then
                            return FBConstants.CONFIG_AUTOLOOT_INFOD;
                        end
                        -- return nil;
                    end,
        ["v"] = 1,
        ["m"] = 1,
        ["p"] = 1,
        ["parents"] = { ["EasyCast"] = IsWardenEnabled },
        ["default"] = false },
    ["AutoOpen"] = {
        ["text"] = FBConstants.CONFIG_AUTOOPEN_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_AUTOOPEN_INFO,
        ["v"] = 1,
        ["parents"] = { ["EasyCast"] = "d" },
        ["default"] = false },
    ["UseAction"] = {
        ["text"] = FBConstants.CONFIG_USEACTION_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_USEACTION_INFO,
        ["v"] = 1,
        ["parents"] = { ["EasyCast"] = "d" },
        ["default"] = false },
    ["PartialGear"] = {
        ["text"] = FBConstants.CONFIG_PARTIALGEAR_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_PARTIALGEAR_INFO,
        ["v"] = 1,
        ["parents"] = { ["EasyCast"] = "d" },
        ["default"] = false },
    ["WatchBobber"] = {
        ["text"] = FBConstants.CONFIG_WATCHBOBBER_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_WATCHBOBBER_INFO,
        ["v"] = 1,
        ["parents"] = { ["EasyCast"] = "d" },
        ["default"] = true
    },
    ["MouseEvent"] = {
        ["default"] = "RightButtonUp",
        ["button"] = "FBMouseEvent",
        ["tooltipd"] = FBConstants.CONFIG_MOUSEEVENT_INFO,
        ["parents"] = { ["EasyCast"] = "h" },
        ["alone"] = 1,
        ["init"] = function(o, b) b.InitMappedMenu(o,b); end,
        ["setup"] =
            function(button)
                local gs = FishingBuddy.GetSetting;
                FBMouseEvent.menu:SetMappedValue("MouseEvent", gs("MouseEvent"));
            end,
    },
    ["EasyLures"] = {
        ["text"] = FBConstants.CONFIG_EASYLURES_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_EASYLURES_INFO,
        ["v"] = 1,
        ["m"] = 1,
        ["depends"] = { ["EasyCast"] = "d" },
        ["default"] = false },
    ["AlwaysHat"] = {
        ["text"] = FBConstants.CONFIG_ALWAYSHAT_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_ALWAYSHAT_INFO,
        ["v"] = 1,
        ["m"] = 1,
        ["parents"] = { ["EasyLures"] = "d" },
        ["default"] = true },
    ["AlwaysLure"] = {
        ["text"] = FBConstants.CONFIG_ALWAYSLURE_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_ALWAYSLURE_INFO,
        ["v"] = 1,
        ["m"] = 1,
        ["parents"] = { ["EasyLures"] = "d" },
        ["default"] = false },
    ["LastResort"] = {
        ["text"] = FBConstants.CONFIG_LASTRESORT_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_LASTRESORT_INFO,
        ["v"] = 1,
        ["parents"] = { ["EasyLures"] = "d" },
        ["default"] = false
    },
};

local InvisibleOptions = {
    -- options not directly manipulatable from the UI
    ["TooltipInfo"] = {
        ["text"] = FBConstants.CONFIG_TOOLTIPS_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_TOOLTIPS_INFO,
        ["default"] = false },
    ["GroupByLocation"] = {
        ["default"] = true,
    },
    -- bar switching
    ["ClickToSwitch"] = {
        ["default"] = true,
    },
    -- sound enhancement
    ["EnhanceSound_SFXVolume"] = {
        ["default"] = 1.0,
    },
    ["EnhanceSound_MasterVolume"] = {
        ["scale"] = 1,
        ["default"] = 100,
    },
    ["EnhanceSound_MusicVolume"] = {
        ["default"] = 0.0,
    },
    ["EnhanceSound_AmbienceVolume"] = {
        ["default"] = 0.0,
    },
    ["EnhanceMapWaterSounds"] = {
        ["default"] = false,
    },
    ["EnhanceSound_EnableSoundWhenGameIsInBG"] = {
        ["default"] = 1.0,
    },
    ["EnhanceSound_EnableAllSound"] = {
        ["default"] = 1.0,
    },
    ["EnhanceSound_EnableSFX"] = {
        ["default"] = 1.0,
    },
    ["EnhancegraphicsParticleDensity"] = {
        ["default"] = 6.0,
    },
    ["MinimapButtonPosition"] = {
        ["default"] = FBConstants.DEFAULT_MINIMAP_POSITION,
    },
    ["MinimapButtonRadius"] = {
        ["default"] = FBConstants.DEFAULT_MINIMAP_RADIUS,
    },
    ["CaughtSoFar"] = {
        ["default"] = 0,
    },
    ["TotalTimeFishing"] = {
        ["default"] = 1,
    },
    ["FishDebug"] = {
        ["default"] = false,
    },
}

local VolumeSlider =
{
    ["name"] = "FishingBuddyOption_MaxVolumeSlider",
    ["format"] = VOLUME.." - %d%%",
    ["min"] = 0,
    ["max"] = 100,
    ["step"] = 5,
    ["scale"] = 1,
    ["rightextra"] = 32,
    ["setting"] = "EnhanceSound_MasterVolume"
};

local function PrepareVolumeSlider()
    VolumeSlider['getter'] = FishingBuddy.GetSetting;
    VolumeSlider['setter'] = FishingBuddy.SetSetting;
    LO:CreateSlider(VolumeSlider);
end

EasyCastInit = function(option, button)
    -- prettify drop down?
    local check = FBEasyKeys:GetWidth();
    if (FishingBuddy.FitInOptionFrame(check)) then
        CastingOptions["EasyCast"].layoutright = "EasyCastKeys";
    else
        CastingOptions["EasyCastKeys"].alone = 1;
    end
end

local function GetTableSetting(table, setting)
    if not table or not table["Settings"] then
        return;
    end
    local val = table["Settings"][setting];
    if ( val == nil and FishingBuddy.GetDefault ) then
        val = FishingBuddy.GetDefault(setting);
    end
    return val;
end

local function SetTableSetting(table, setting, value)
    if ( table and setting ) then
        local val = nil;
        if ( FishingBuddy.GetDefault ) then
            val = FishingBuddy.GetDefault(setting);
        end
        if not table["Settings"] then
            table["Settings"] = {}
        end
        if ( val == value ) then
            table["Settings"][setting] = nil;
        else
            table["Settings"][setting] = value;
        end
    end
end

-- default FishingBuddy option handlers
FishingBuddy.BaseGetSetting = function(setting)
    return GetTableSetting(FishingBuddy_Player, setting);
end

FishingBuddy.BaseSetSetting = function(setting, value)
    SetTableSetting(FishingBuddy_Player, setting, value)
end

FishingBuddy.GlobalGetSetting = function(setting)
    return GetTableSetting(FishingBuddy_Info, setting);
end

FishingBuddy.GlobalSetSetting = function(setting, value)
    SetTableSetting(FishingBuddy_Info, setting, value)
end

FishingBuddy.ByFishie = nil;
FishingBuddy.SortedFishies = nil;

FishingBuddy.StartedFishing = nil;

local OpenThisFishId = {};
local DoAutoOpenLoot = nil;
local NewLootCheck = true;

FishingBuddy.OpenThisFishId = OpenThisFishId;

-- handle zone markers
local function zmto(zidx, sidx)
    if ( not zidx ) then
        return 0;
    end
    if ( not sidx ) then
        sidx = 0;
    end
    return zidx*1000 + sidx;
end
FishingBuddy.ZoneMarkerTo = zmto;

local function zmex(packed)
    local sidx = math.fmod(packed, 1000);
    return math.floor(packed/1000), sidx;
end
FishingBuddy.ZoneMarkerEx = zmex;

-- event handling
local function IsFakeEvent(evt)
    return (evt == "VARIABLES_LOADED") or FBConstants.FBEvents[evt];
end

-- let's delay bag update when we leave the world
local bagupdateframe = CreateFrame("Frame");
bagupdateframe:Hide();
-- we could watch for UNIT_INVENTORY_CHANGED, if we wanted to check for "player" in the args
local InventoryEvents = {
    ["BAG_UPDATE"] = true,
    ["PLAYER_EQUIPMENT_CHANGED"] = true,
}


function bagupdateframe:StartInventory()
    for event,_ in pairs(InventoryEvents) do
        self.fbframe:RegisterEvent(event)
    end
end

function bagupdateframe:StopInventory()
    for event,_ in pairs(InventoryEvents) do
        self.fbframe:UnregisterEvent(event)
    end
end

local LastCastTime = nil;
local FISHINGSPAN = 60;

local function SetLastCastTime()
    LastCastTime = GetTime();
end

local function ClearLastCastTime()
    LastCastTime = nil
end

local handlerframe = CreateFrame("Frame");
handlerframe:Hide();

local reg_events = {};
local event_handlers = {};

-- allow other parts of the code to watch for events when not fishing
local isunit = "UNIT_";
local function RegisterEvent(event)
    if ( not reg_events[event] ) then
        if (string.sub(event, 1, string.len(isunit)) == isunit) then
            handlerframe:RegisterUnitEvent(event, "player");
        else
            handlerframe:RegisterEvent(event);
        end
        reg_events[event] = 1;
    end
end

local function AddHandler(event, info)
    local func, fake;
    if ( not event_handlers[event] ) then
        event_handlers[event] = {};
    end
    fake = IsFakeEvent(event);
    if ( type(info) == "function" ) then
        func = info;
    else
        func = info.func;
        fake = fake or info.fake;
    end
    tinsert(event_handlers[event], func);
    if ( not fake ) then
        -- register the event, if we haven't already
        RegisterEvent(event);
    end
end

local function RemoveHandler(event, info)
    if ( event_handlers[event] ) then
        local func;
        if ( type(info) == "function" ) then
            func = info;
        else
            func = info.func;
        end
        local jdx = nil;
        for idx,f in ipairs(event_handlers[event]) do
            if ( f == func ) then
                jdx = idx;
            end
        end
        if ( jdx ) then
            table.remove(event_handlers[event], jdx);
        end
        if ( table.getn(event_handlers[event]) == 0 ) then
            event_handlers[event] = nil;
            if (reg_events[event]) then
                reg_events[event] = nil;
                handlerframe:UnregisterEvent(event);
            end
        end
    end
end

local function RegisterHandlers(handlers)
    if (not handlers) then
        return
    end

    for evt,info in pairs(handlers) do
        AddHandler(evt, info)
    end
end
-- these should be internal use only, FBAPI has "constant" interfaces
FishingBuddy.RegisterHandlers = RegisterHandlers;
FishingBuddy.GetHandlers = function(what) return event_handlers[what]; end;

local function RunHandlers(what, ...)
    local eh = event_handlers[what];
    if ( eh ) then
        for idx,func in pairs(eh) do
            func(...);
        end
    end
end
FishingBuddy.RunHandlers = RunHandlers;

-- we want to make sure we handle our registered events for everyone
handlerframe:SetScript("OnEvent", function(self, event, ...)
    RunHandlers(event, ...);
    RunHandlers("*", ...);
end)

-- look at tooltips
local function LastTooltipText()
    return FL:GetLastTooltipText();
end
FishingBuddy.LastTooltipText = LastTooltipText;

local function ClearTooltipText()
    FL:ClearLastTooltipText();
end
FishingBuddy.ClearTooltipText = ClearTooltipText;

-- handle option keys for enabling casting
local key_actions = {
    [FBConstants.KEYS_NONE] = function(mouse) return mouse ~= "RightButtonUp"; end,
    [FBConstants.KEYS_SHIFT] = function(mouse) return IsShiftKeyDown(); end,
    [FBConstants.KEYS_CTRL] = function(mouse) return IsControlKeyDown(); end,
    [FBConstants.KEYS_ALT] = function(mouse) return IsAltKeyDown(); end,
}
local function CastingKeys()
    local setting = FishingBuddy.GetSetting("EasyCastKeys");
    local mouse = FishingBuddy.GetSetting("MouseEvent");
    if ( setting and key_actions[setting] ) then
        return key_actions[setting](mouse);
    else
        return true;
    end
end

local function ReadyForFishing()
    local GSB = FishingBuddy.GetSettingBool;
    local id = FL:GetMainHandItem(true);
    -- if we're holding the spear, assume we're fishing
    return (GSB("UseTuskarrSpear") and (id == 88535)) or FL:IsFishingReady(GSB("PartialGear"));
end
FishingBuddy.ReadyForFishing = ReadyForFishing;

local function CheckCastingKeys()
    return ReadyForFishing();
end

local QuestLures = {};
QuestLures[58788] = {
    ["enUS"] = "Overgrown Earthworm",	-- Diggin' for Worms
    spell = 80534,
};
QuestLures[58949] = {
    ["enUS"] = "Stag Eye",				-- A Staggering Effort
    spell = 80868,
};
QuestLures[45902] = {
    ["enUS"] = "Phantom Ghostfish",
    spell = 45902,
};
QuestLures[69907] = {
    ["enUS"] = "Corpse Worm",
    spell = 99315,
};

local AutoFishingItems = {}
local GOGGLES_ID = 167698;
AutoFishingItems[GOGGLES_ID] = {
    ["enUS"] = "Secret Fishing Goggles",
    spell = 293671,
    setting = "UseSecretGoggles",
    ["tooltip"] = FBConstants.CONFIG_SECRET_FISHING_GOGGLES_INFO,
    ["usable"] = function() return not FishingBuddy.ReadyForFishing(); end,
    ["default"] = false,
}

-- Get an array of all the lures we have in our inventory, sorted by
-- cost, then bonus
-- We'll want to use the cheapest ones we can until our fish don't get
-- away from us

-- Full combat check function
local function CheckCombat()
    return InCombatLockdown() or UnitAffectingCombat("player") or UnitAffectingCombat("pet")
end
FishingBuddy.CheckCombat = CheckCombat;

local function PostCastUpdate()
    local LSM = FishingBuddy.LureStateManager;
    if ( not CheckCombat() ) then
        FL:ResetOverride();
        if ( LSM:LuringComplete() ) then
            FishingBuddy_PostCastUpdateFrame:Hide();
        end
    end
end
FishingBuddy.PostCastUpdate = PostCastUpdate;

local function HideAwayAll(self, button, down)
    FishingBuddy_PostCastUpdateFrame:Show();
end

local function GetFishingItem(itemtable)
    local GSB = FishingBuddy.GetSettingBool;
    for itemid, info in pairs(itemtable) do
        if ( info.always or (PLANS:HaveThing(itemid, info) and (not info.setting or GSB(info.setting))) ) then
            if (not info[CurLoc]) then
                info[CurLoc] = GetItemInfo(itemid);
            end
            if PLANS:CanUseFishingItem(itemid, info) then
                local doit = true;
                local it = nil;
                if ( info.check ) then
                    doit, itemid, it = info.check(info, info.spell, doit, itemid);
                elseif (info.toy) then
                    _, itemid = C_ToyBox.GetToyInfo(itemid);
                end
                if ( doit ) then
                    return doit, itemid, info[CurLoc], it or info.type;
                end
            end
        end
    end
    -- return nil;
end

local function GetFishieRaw(fishid)
    local fi = FishingBuddy_Info["Fishies"][fishid];
    if ( not fi or not fi[CurLoc] ) then
        local _,_,_,_,it,_,_,_,_,_ = FL:GetItemInfo(fishid);
        local color, id, name = FL:SplitLink(fishid, true);

        if (not fi) then
            return fishid, it, color, 1, nil, name, nil;
        else
            fi.texture = it;
            fi.color = color;
            fi.quantity = 1;
            fi[CurLoc] = name;
        end
    end

    return fishid,
            fi.texture,
            fi.color,
            fi.quantity,
            fi.quality,
            fi[CurLoc],
            fi.quest;
end
FishingBuddy.GetFishieRaw = GetFishieRaw;

local function GetUpdateLure()
    local GSB = FishingBuddy.GetSettingBool;
    local LSM = FishingBuddy.LureStateManager;
    local lureinventory, _ = FL:GetLureInventory();

    -- Let's wait a bit so that the enchant can show up before we lure again
    if LSM:LuringCheck() then
        return false, 0, nil
    end

    DoAutoOpenLoot = nil;

    local doit, id, name, it;

    if autopoleframe:IsShown() then
        doit, id, name, it = PLANS:CanUseFishingItems(AutoFishingItems)
        if ( doit ) then
            return doit, id, name, it;
        end
    end

    doit, id, name, it = PLANS:GetPlan()
    if ( doit ) then
        return doit, id, name, it;
    end

    -- look for bonus items, like the Ancient Pandaren Fishing Charm
    if ( FishingBuddy.FishingItems ) then
        doit, id, name, it = GetFishingItem(FishingBuddy.FishingItems);
        if ( doit ) then
            return doit, id, name, it;
        end
    end

    if ( GSB("EasyLures") ) then
        -- Is this a quest fish we should open up?
        if ( GSB("AutoOpen") ) then
            while ( table.getn(OpenThisFishId) > 0 ) do
                local id = OpenThisFishId[1];
                local c = GetItemCount(id);
                if (c < 2) then
                    table.remove(OpenThisFishId, 1);
                end
                if ( c > 0 ) then
                    DoAutoOpenLoot = true;
                    local _,_,_,_,_,name,_ = GetFishieRaw(id);
                    return true, id, name;
                end
            end
        end

        -- look for quest lures
        doit, id, name, it = GetFishingItem(QuestLures);
        if ( doit ) then
            return doit, id, name, it;
        end
    end

    return false;
end
FishingBuddy.GetUpdateLure = GetUpdateLure

local CaptureEvents = {};
local trackedtime = 0;
local TRACKING_DELAY = 0.75;


local function ClearLastLure()
    local LSM = FishingBuddy.LureStateManager;
    LSM:ClearLastLure()
end

-- we don't want to interrupt ourselves if we're casting.
local fishing_buff = 131474;
local fishing_spellid = 131490;
local current_spell_id = nil

CaptureEvents["UNIT_SPELLCAST_CHANNEL_START"] = function(unit, lineid, spellid)
    current_spell_id = spellid
    if current_spell_id == fishing_spellid then
        SetLastCastTime();
    end
end

CaptureEvents["UNIT_SPELLCAST_CHANNEL_STOP"] = function(unit, lineid, spellid)
    -- we may want to wait a bit here for any buff to come back...
    if current_spell_id == fishing_spellid then
        SetLastCastTime();
    end
    current_spell_id = nil
    ClearLastLure()
end

CaptureEvents["UNIT_SPELLCAST_INTERRUPTED"] = function(unit, lineid, spellid)
    if current_spell_id == fishing_spellid then
        SetLastCastTime();
    end
    current_spell_id = nil
    ClearLastLure()
end

CaptureEvents["UNIT_SPELLCAST_FAILED"] = ClearLastLure;
CaptureEvents["UNIT_SPELLCAST_FAILED_QUIET"] = ClearLastLure;

CaptureEvents["ACTIONBAR_SLOT_CHANGED"] = function()
    if ( FishingBuddy.GetSettingBool("UseAction") ) then
        FL:GetFishingActionBarID(true);
    end
end

CaptureEvents["UNIT_AURA"] = function(arg1)
    if ( arg1 == "player" ) then
        local hmhe,_,_,_,_,_ = GetWeaponEnchantInfo();
        if ( not hmhe ) then
            ClearLastLure();
        end
    end
end

CaptureEvents[FBConstants.OPT_UPDATE_EVT] = function()
    FishingBuddyRoot:RegisterEvent("UPDATE_BINDINGS")
end

local function GetCurrentSpell()
    return current_spell_id;
end
FishingBuddy.GetCurrentSpell = GetCurrentSpell

local function NormalHijackCheck()
    local GSB = FishingBuddy.GetSettingBool;
    local GSA = FishingBuddy.ActiveSetting;
    local LSM = FishingBuddy.LureStateManager;
    if ( not LSM:GetLastLure() and
         not CheckCombat() and GSA("FlyingCast") and GSA("MountedCast") and
         not IsFishingAceEnabled() and
         GSB("EasyCast") and CheckCastingKeys() ) then
        return true;
    end
end
FishingBuddy.NormalHijackCheck = NormalHijackCheck;

local HijackCheck = NormalHijackCheck;
local function SetHijackCheck(func)
    if ( not func ) then
        func = NormalHijackCheck;
    end
    HijackCheck = func;
end
FishingBuddy.SetHijackCheck = SetHijackCheck;

local function NormalStealClick()
    -- return nil;
end

local StealClick = NormalStealClick;
local function SetStealClick(func)
    if ( not func ) then
        func = NormalStealClick;
    end
    StealClick = func;
end
FishingBuddy.SetStealClick = SetStealClick;

local function CentralCasting()
    -- put on a lure if we need to
    if ( not StealClick() ) then
        autopoleframe:Show();
        local update, id, n, target = GetUpdateLure();
        if (update and id) then
            FL:InvokeLuring(id, target);
        else
            SetLastCastTime();
            if ( not FL:GetLastTooltipText() or not FL:OnFishingBobber() ) then
                 -- watch for fishing holes
                FL:SaveTooltipText();
            end
            local macrotext = FishingBuddy.CastAndThrow()
            if macrotext then
                FL:InvokeMacro(macrotext)
            else
                FL:InvokeFishing(FishingBuddy.GetSettingBool("UseAction"));
            end
        end
    end
    FL:OverrideClick(HideAwayAll);
end

local SavedWFOnMouseDown;

-- handle mouse up and mouse down in the WorldFrame so that we can steal
-- the hardware events to implement 'Easy Cast'
-- Thanks to the Cosmos team for figuring this one out -- I didn't realize
-- that the mouse handler in the WorldFrame got everything first!
local function WF_OnMouseDown(...)
    -- Only steal 'right clicks' (self is arg #1!)
    local button = select(2, ...);
    if ( HijackCheck() ) then
        PLANS:ExecutePlans()
        if ( FL:CheckForDoubleClick(button) ) then
            -- We're stealing the mouse-up event, make sure we exit MouseLook
            if ( IsMouselooking() ) then
                MouselookStop();
            end
            CentralCasting();
        end
    end
    if ( SavedWFOnMouseDown ) then
        SavedWFOnMouseDown(...);
    end
end

local function SafeHookMethod(object, method, newmethod)
    local oldValue = object[method];
    if ( oldValue ~= _G[newmethod] ) then
        object[method] = newmethod;
        return true;
    end
    return false;
end

local function SafeHookScript(frame, handlername, newscript)
    local oldValue = frame:GetScript(handlername);
    frame:SetScript(handlername, newscript);
    return oldValue;
end

local skip = {};
skip["mods"] = 1;
skip["texture"] = 1;
skip["quest"] = 1;
skip["level"] = 1;
skip["skill"] = 1;
skip["quality"] = 1;
skip["color"] = 1;

FishingBuddy.GetFishie = function(fishid)
    local fi = FishingBuddy_Info["Fishies"][fishid];
    if( fi ) then
        local name = fi[CurLoc];
        if ( not name ) then
            -- try a hyperlink
            local link = "item:"..fishid;
            local n,l,_,_,_,_,_,_ = FL:GetItemInfo(link);
            if ( n and l ) then
                name = n;
                fi[CurLoc] = n;
            else
                -- try for anything we might be able to display
                for k,val in pairs(fi) do
                    if ( not skip[k] and not name ) then
                         name = val;
                    end
                end
            end
        end
        if ( not name ) then
            name = UNKNOWN;
        end
        return string.format("%d:0:0:0:0:0:0:0", fishid),
                 fi.texture,
                 fi.color,
                 fi.quantity,
                 fi.quality,
                 name,
                 fi.quest;
    end
end

local function PushOptionChanges()
    FL:WatchBobber(FishingBuddy.GetSettingBool("WatchBobber"));
    FL:SetSAMouseEvent(FishingBuddy.GetSetting("MouseEvent"));
    FishingBuddy.WatchUpdate();
end

-- do everything we think is necessary when we start fishing
-- even if we didn't do the switch to a fishing pole
local resetClickToMove = nil;
local function StartFishingMode()
    if ( not FishingBuddy.StartedFishing ) then
        -- Disable Click-to-Move if we're fishing
        if ( BlizzardOptionsPanel_GetCVarSafe("autoInteract") == 1 ) then
            resetClickToMove = true;
            BlizzardOptionsPanel_SetCVarSafe("autoInteract", 0);
        end
        FishingBuddy.EnhanceFishingSounds(true);
        handlerframe:Show();
        local pole, lure = FL:GetPoleBonus();
        if ( not lure or lure == 0 ) then
            local LSM = FishingBuddy.LureStateManager;
            LSM:SetLure({["b"] = lure})
        end
        FishingBuddy.StartedFishing = GetTime();
        RunHandlers(FBConstants.FISHING_ENABLED_EVT);
    end
    -- we get invoked when items get equipped as well
    FL:UpdateLureInventory();
end

local function StopFishingMode(logout)
    if ( FishingBuddy.StartedFishing ) then
        if ( not logout ) then
            FishingBuddy.WatchUpdate();
        end
        autopoleframe:Hide();
        handlerframe:Hide();
        local started = FishingBuddy.StartedFishing;
        FishingBuddy.StartedFishing = nil;
        RunHandlers(FBConstants.FISHING_DISABLED_EVT, started, logout);
    end

    -- reset everything that we might have set
    FishingBuddy.EnhanceFishingSounds(false, logout);
    if ( resetClickToMove ) then
        -- Re-enable Click-to-Move if we changed it
        BlizzardOptionsPanel_SetCVarSafe("autoInteract", 1);
        resetClickToMove = nil;
    end

    ClearLastLure();
end

local function FishingMode()
    local ready = ReadyForFishing() or autopoleframe:IsShown();
    if ( ready ) then
        StartFishingMode();
    else
        StopFishingMode();
    end
end
FishingBuddy.FishingMode = FishingMode;

local function SetAutoPoleLocation(clear)
    local a = autopoleframe
    if clear then
        autopoleframe:Hide();
        ClearLastCastTime();
        a.x, a.y, a.zone, a.instanceID = nil, nil, nil
    else
        a.x, a.y, a.zone, a.instanceID = FL:GetPlayerZoneCoords();
    end
end

local function AutoPoleCheck(self, ...)
    if (not CheckCombat() ) then
        if ( not LastCastTime or ReadyForFishing() ) then
            SetAutoPoleLocation(true)
            return;
        end
        local elapsed = (GetTime() - LastCastTime);
        if ( elapsed > FISHINGSPAN ) then
            SetAutoPoleLocation(true)
            StopFishingMode();
        elseif ( not FishingBuddy.StartedFishing ) then
            StartFishingMode();
            SetAutoPoleLocation()
        elseif (self.zone) then
            if (self.moving) then
                local distance = FL:GetDistanceTo(self.zone, self.x, self.y)
                if distance then
                    if distance > 50 or (not FishingBuddy.HaveRafts() and distance > 10) then
                        SetAutoPoleLocation(true)
                        StopFishingMode();
                    end
                end
            elseif (self.stopped) then
                SetAutoPoleLocation()
                self.stopped = nil;
            end
        end
    end
end

local function AutoPoleEvent(self, event, arg1, arg2, arg3, arg4, arg5)
    self.moving = (event == "PLAYER_STARTED_MOVING")
    self.stopped = (event == "PLAYER_STOPPED_MOVING")
    -- print(event, arg1, arg2, arg3, arg4, arg5)
end

autopoleframe:SetScript("OnEvent", AutoPoleEvent)
autopoleframe:SetScript("OnUpdate", AutoPoleCheck);
autopoleframe:RegisterEvent("PLAYER_STARTED_MOVING");
autopoleframe:RegisterEvent("PLAYER_STOPPED_MOVING");
-- autopoleframe:RegisterEvent("VEHICLE_ANGLE_UPDATE");

FishingBuddy.IsSwitchClick = function(setting)
    if ( not setting ) then
        setting = "ClickToSwitch";
    end
    local a = IsShiftKeyDown();
    local b = FishingBuddy.GetSettingBool(setting);
    return ( (a and (not b)) or ((not a) and b) );
end

local function TrapWorldMouse()
    if ( WorldFrame.OnMouseDown ) then
        hooksecurefunc(WorldFrame, "OnMouseDown", WF_OnMouseDown)
    else
        SavedWFOnMouseDown = SafeHookScript(WorldFrame, "OnMouseDown", WF_OnMouseDown);
    end
end
FishingBuddy.TrapWorldMouse = TrapWorldMouse;

FishingBuddy.Commands[FBConstants.FISHINGMODE] = {};
FishingBuddy.Commands[FBConstants.FISHINGMODE].help = FBConstants.FISHINGMODE_HELP;
FishingBuddy.Commands[FBConstants.FISHINGMODE].func =
    function(what)
        if(what and what == "stop") then
            StopFishingMode();
        else
            SetLastCastTime();
            autopoleframe:Show();
        end

        return true;
    end;

FishingBuddy.Commands['macro'] = {};
FishingBuddy.Commands['macro'].help = FBConstants.FBMACRO_HELP;
FishingBuddy.Commands['macro'].func =
    function()
        SetLastCastTime();
        autopoleframe:Show();
        FishingBuddy.FishingMacro();
        return true;
    end;

local function OptionsUpdate(changed, closing)
    PushOptionChanges(changed, closing)
    RunHandlers(FBConstants.OPT_UPDATE_EVT, changed, closing);
end
FishingBuddy.OptionsUpdate = OptionsUpdate;

local function nextarg(msg, pattern)
    if ( not msg or not pattern ) then
        return nil, nil;
    end
    local s,e = string.find(msg, pattern);
    if ( s ) then
        local word = strsub(msg, s, e);
        msg = strsub(msg, e+1);
        return word, msg;
    end
    return nil, msg;
end

FishingBuddy.Command = function(msg)
    if ( not msg ) then
        return;
    end
    if ( FishingBuddy.IsLoaded() ) then
        -- collect arguments (whee, lua string manipulation)
        local cmd;
        cmd, msg = nextarg(msg, "[%w]+");

        -- the empty string gives us no args at all
        if ( not cmd ) then
            -- toggle window
            if ( FishingBuddyFrame:IsVisible() ) then
                HideUIPanel(FishingBuddyFrame);
            else
                ShowUIPanel(FishingBuddyFrame);
            end
        elseif ( cmd == FBConstants.HELP or cmd == "help" ) then
            FishingBuddy.Output(FBConstants.WINDOW_TITLE);
            if ( not FBConstants.HELPMSG ) then
                FBConstants.HELPMSG = { "@PRE_HELP" };
                for cmd,info in pairs(FishingBuddy.Commands) do
                    if ( info.help ) then
                        tinsert(FBConstants.HELPMSG, info.help);
                    end
                end
                tinsert(FBConstants.HELPMSG, "@POST_HELP");
                FL:FixupEntry(FBConstants, "HELPMSG")
            end
            FishingBuddy.PrintHelp(FBConstants.HELPMSG);
        else
            local command = FishingBuddy.Commands[cmd];
            if ( command ) then
                local args = {};
                local goodargs = true;
                if ( command.args ) then
                    for _,pat in pairs(command.args) do
                        local w, msg = nextarg(msg, pat);
                        if ( not w ) then
                            goodargs = false;
                            break;
                        end
                        tinsert(args, w);
                    end
                else
                    local a;
                    while ( msg ) do
                        a, msg = nextarg(msg, "[%w]+");
                        if ( not a ) then
                            break;
                        end
                        tinsert(args, a);
                    end
                end
                if ( not goodargs or not command.func(unpack(args)) ) then
                    if ( command.help ) then
                        FishingBuddy.PrintHelp(command.help);
                    else
                        FishingBuddy.Debug("command failed");
                    end
                end
            else
                FishingBuddy.Command("help");
            end
        end
    else
        FishingBuddy.Error(FBConstants.FAILEDINIT);
    end
end

FishingBuddy.TooltipBody = function(hintcheck)
    local text = FBConstants.DESCRIPTION1.."\n"..FBConstants.DESCRIPTION2;
    if ( hintcheck ) then
        local hint = FBConstants.TOOLTIP_HINT.." ";
        if (FishingBuddy.GetSettingBool(hintcheck)) then
            hint = hint..FBConstants.TOOLTIP_HINTSWITCH;
        else
            hint = hint..FBConstants.TOOLTIP_HINTTOGGLE;
        end
        text = text.."\n"..FL:Green(hint);
    end
    return text;
end

local efsv = nil;
FishingBuddy.EnhanceFishingSounds = function(doit, logout)
    local GSB = FishingBuddy.GetSettingBool;
    local GSO = FishingBuddy.GetSettingOption;
    if ( GSB("EnhanceFishingSounds") ) then
        if ( not efsv and doit ) then
            -- collect the current values
            local mv = BlizzardOptionsPanel_GetCVarSafe("Sound_MasterVolume");
            local mu = BlizzardOptionsPanel_GetCVarSafe("Sound_MusicVolume");
            local av = BlizzardOptionsPanel_GetCVarSafe("Sound_AmbienceVolume");
            local sv = BlizzardOptionsPanel_GetCVarSafe("Sound_SFXVolume");
            local sb = BlizzardOptionsPanel_GetCVarSafe("Sound_EnableSoundWhenGameIsInBG");
            local pd = BlizzardOptionsPanel_GetCVarSafe("graphicsParticleDensity");
            local eas = BlizzardOptionsPanel_GetCVarSafe("Sound_EnableAllSound");
            local esfx = BlizzardOptionsPanel_GetCVarSafe("Sound_EnableSFX");

            efsv = {};
            if (GSB("TurnOnSound")) then
                efsv["Sound_EnableAllSound"] = eas;
                efsv["Sound_EnableSFX"] = esfx;
            end

            efsv["Sound_MasterVolume"] = mv;
            efsv["Sound_MusicVolume"] = mu;
            efsv["Sound_AmbienceVolume"] = av;
            efsv["Sound_SFXVolume"] = sv;
            efsv["Sound_EnableSoundWhenGameIsInBG"] = sb;

            if (GSB("EnhancePools")) then
                efsv["graphicsParticleDensity"] = pd;
            end

            -- if we need to, turn 'em off!
            for setting in pairs(efsv) do
                local optionname = "Enhance"..setting;
                local value = FishingBuddy.GetSetting(optionname);
                value = tonumber(value);
                local info = GSO(optionname);
                if (info and info.scale) then
                    value = value / 100.0;
                end
                BlizzardOptionsPanel_SetCVarSafe(setting, value);
            end
            return; -- fall through and reset everything otherwise
        end
    end
    if ( logout ) then
        FishingBuddy_Player["ResetEnhance"] = efsv;
    end

    if ( efsv ) then
        for setting, value in pairs(efsv) do
            BlizzardOptionsPanel_SetCVarSafe(setting, tonumber(value));
        end
        efsv = nil;
    end
end

local IsZoning;

-- Return true if we might be looting from a barrel.
local function LegionBarrel()
    local continent, _ = FL:GetCurrentMapContinent();
    return (continent == 8 and FL:GetMainHandItem(true) == FBConstants.UNDERLIGHT_ANGLER);
end

FishingBuddy.OnEvent = function(self, event, ...)
--	  local line = event;
--	  for idx=1,select("#",...) do
--		  line = line.." '"..select(idx,...).."'";
--	  end
--	  FishingBuddy.Debug(line);


    if ( event == "PLAYER_EQUIPMENT_CHANGED" or
          event == "WEAR_EQUIPMENT_SET" or
          event == "EQUIPMENT_SWAP_FINISHED") then
        FishingMode();
        RunHandlers(FBConstants.INVENTORY_EVT)
    elseif (event == "BAG_UPDATE" ) then
        local lootcount, lootcheck = FishingBuddy.GetLootState();
        if (lootcheck) then
            if (lootcount > 0) then
                lootcount = lootcount - 1;
            end
            if (lootcount == 0) then
                lootcheck = false;
                FishingBuddy.WatchUpdate();
            end
        end
        FishingMode();
        RunHandlers(FBConstants.INVENTORY_EVT)
    elseif ( event == "LOOT_READY" ) then
        local autoLoot = ...;
        local doautoloot = false;
        if NewLootCheck then
            NewLootCheck = false;
            if autoLoot or (autoLoot == nil and BlizzardOptionsPanel_GetCVarSafeBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE"))  then
                doautoloot = true
            else
                doautoloot = FishingBuddy.GetSettingBool("AutoLoot")
            end

            if ( IsFishingLoot() or LegionBarrel() ) then
                local poolhint = nil;

                -- How long ago did the achievement fire?
                local elapsedtime = GetTime() - trackedtime;
                if ( elapsedtime < TRACKING_DELAY ) then
                    poolhint = true;
                end

                -- if we want to autoloot, and Blizz isn't, let's grab stuff
                local info = GetLootInfo()
                for index, item in ipairs(info) do
                    local link = GetLootSlotLink(index);
                    -- should we track "locked" items we couldn't loot?'
                    FishingBuddy.AddLootCache(item.texture, item.name, item.quantity, item.quality, link, poolhint)
                    if (doautoloot) then
                        LootSlot(index);
                    end
                end
                ClearTooltipText();
                FL:ExtendDoubleClick();
            elseif (DoAutoOpenLoot) then
                DoAutoOpenLoot = nil;
                for index = 1, GetNumLootItems(), 1 do
                    if (doautoloot) then
                        LootSlot(index);
                    end
                end
            end
        end
    elseif ( event == "LOOT_CLOSED" ) then
        -- nothing to do here at the moment
        DoAutoOpenLoot = nil;
        NewLootCheck = true;
    elseif ( event == "PLAYER_LOGIN" ) then
        FL:CreateSAButton();
        FL:SetSAMouseEvent(FishingBuddy.GetSetting("MouseEvent"));
        RunHandlers(FBConstants.LOGIN_EVT);
    elseif ( event == "PLAYER_LOGOUT" ) then
        -- reset the fishing sounds, if we need to
        StopFishingMode(true);
        FishingBuddy.SavePlayerInfo();
        RunHandlers(FBConstants.LOGOUT_EVT);
    elseif ( event == "UPDATE_BINDINGS" ) then
        local key1, key2 = GetBindingKey("FISHINGBUDDY_GOFISHING");
        if key1 or key2 then
            if FishingBuddy.CreateFishingMacro() then
                self:UnregisterEvent(event);
                FishingBuddy.SetupMacroKeyBinding();
                self:RegisterEvent(event);
            end
        end
    elseif ( event == "VARIABLES_LOADED" ) then
        local _, name = FL:GetFishingSpellInfo();
        PLANS = FishingBuddy.FishingPlans;
        FishingBuddy.Initialize();
        PrepareVolumeSlider()
        FishingBuddy.OptionsFrame.HandleOptions(GENERAL, nil, GeneralOptions);
        FishingBuddy.AddSchoolFish();

        FishingBuddy.CreateFBMappedDropDown("FBEasyKeys", "EasyCastKeys", FBConstants.CONFIG_EASYCAST_ONOFF, FBConstants.Keys)
        FishingBuddy.CreateFBMappedDropDown("FBMouseEvent", "MouseEvent", FBConstants.CONFIG_MOUSEEVENT_ONOFF, FBConstants.CastingKeyLabel)

        FishingBuddy.OptionsFrame.HandleOptions(name, "Interface\\Icons\\INV_Fishingpole_02", CastingOptions);
        FishingBuddy.OptionsFrame.HandleOptions(nil, nil, InvisibleOptions);

        -- defaults to true
        if (FishingBuddy_Player and FishingBuddy_Player["Settings"] and FishingBuddy_Player["Settings"]["ShowBanner"] == nil) then
            FishingBuddy.Output(FBConstants.WINDOW_TITLE.." loaded");
        end

        FishingBuddy.SetupSpecialItems(AutoFishingItems, false, true, true)
        FishingBuddy.UpdateFluffOption(GOGGLES_ID, AutoFishingItems[GOGGLES_ID])

        self:UnregisterEvent("VARIABLES_LOADED");
        -- tell all the listeners about this one
        RunHandlers(event, ...);
    elseif ( event == "PLAYER_ENTERING_WORLD" ) then
        IsZoning = nil;
        bagupdateframe:Show();

        if (FishingBuddy.StartedFishing and not handlerframe:IsShown()) then
            handlerframe:Show();
        end

        if (FishingBuddy_Player and FishingBuddy_Player["ResetEnhance"]) then
            efsv = FishingBuddy_Player["ResetEnhance"];
            FishingBuddy.EnhanceFishingSounds(false, false);
            FishingBuddy_Player["ResetEnhance"] = nil;
        end

        -- Default is true, not saved, therefor implicitly nil
        if (FishingBuddy_Player["Settings"]["SetupSkills"] == nil) then
            FL:GetTradeSkillData()
        end
    elseif ( event == "PLAYER_ALIVE" ) then
        FishingMode();
        self:UnregisterEvent("PLAYER_ALIVE");
    elseif ( event == "PLAYER_LEAVING_WORLD") then
        RunHandlers(FBConstants.LEAVING_EVT);
        IsZoning = 1;

-- Don't reenable BAG_UPDATE until we're back
        bagupdateframe:Hide();
        bagupdateframe:StopInventory()

        if (handlerframe:IsShown()) then
            handlerframe:Hide();
        end
    end
    if FishingBuddy.Extravaganza then
        FishingBuddy.Extravaganza.IsTime(true);
    end
end

FishingBuddy.OnLoad = function(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    self:RegisterEvent("PLAYER_LEAVING_WORLD");
    self:RegisterEvent("PLAYER_ALIVE");

    self:RegisterEvent("PLAYER_LOGIN");
    self:RegisterEvent("PLAYER_LOGOUT");
    self:RegisterEvent("VARIABLES_LOADED");

    -- we want to deal with fishing loot windows all the time
    self:RegisterEvent("LOOT_READY");
    self:RegisterEvent("LOOT_CLOSED");

-- Handle item lock separately to reduce churn during world load
    -- self:RegisterEvent("ITEM_LOCK_CHANGED");
    -- self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
    -- self:RegisterEvent("WEAR_EQUIPMENT_SET");

    self:SetScript("OnEvent", FishingBuddy.OnEvent);

    bagupdateframe.fbframe = self;
    bagupdateframe:SetScript("OnUpdate", function(self, ...)
        if (self.fbframe) then
            self:StartInventory()
            self:Hide();
            if not self.firsttime then
                if not FL:IsClassic() then
                    if C_Calendar.OpenCalendar then
                        C_Calendar.OpenCalendar()
                    else
                        OpenCalendar()
                    end
                end
                RunHandlers(FBConstants.FIRST_UPDATE_EVT);
                FishingBuddy.WatchUpdate();
                self.firsttime = true
            end
        end
    end);

    RegisterHandlers(CaptureEvents);

    -- Set up command
    SlashCmdList["fishingbuddy"] = FishingBuddy.Command;
    SLASH_fishingbuddy1 = "/fishingbuddy";
    SLASH_fishingbuddy2 = "/fb";

    FL:RegisterAddonMessagePrefix(FBConstants.MSGID)
end

FishingBuddy.PrintHelp = function(tab)
    if ( tab ) then
        if ( type(tab) == "table" ) then
            for _,line in pairs(tab) do
                FishingBuddy.PrintHelp(line);
            end
        else
            -- check for a reference to another help item
            local _,_,w = string.find(tab, "^@([A-Z0-9_]+)$");
            if ( w and FBConstants[w] ) then
                FishingBuddy.PrintHelp(FBConstants[w]);
            else
                FishingBuddy.Output(tab);
            end
        end
    end
end

FishingBuddy.FishSort = function(tab, forcename)
    if ( forcename or not FishingBuddy.GetSettingBool("SortByPercent") ) then
        table.sort(tab, function(a,b) return (a.index and b.index and a.index<b.index) or
                                                         (a.text and b.text and a.text<b.text); end);
    else
        table.sort(tab, function(a,b) return a.count and b.count and b.count<a.count; end);
    end
end

local function nocase (s)
    s = string.gsub(s, "%a", function (c)
                                         return string.format("[%s%s]", string.lower(c),
                                                 string.upper(c))
                                     end)
    return s
end

FishingBuddy.StripRaw = function(fishie)
    if ( fishie ) then
        local raw = nocase(FBConstants.RAW);
        local s,e = string.find(fishie, raw.." ");
        if ( s ) then
            if ( s > 1 ) then
                fishie = string.sub(fishie, 1, s-1)..string.sub(fishie, e+1);
            else
                fishie = string.sub(fishie, e+1);
            end
        else
            s,e = string.find(fishie, " "..raw);
            if ( s ) then
                fishie = string.sub(fishie, 1, s-1)..string.sub(fishie, e+1);
            end
        end
        return fishie;
    end
    -- this means an import failed somewhere
    return UNKNOWN;
end

FishingBuddy.ToggleDropDownMenu = function(level, value, menu, anchor, xOffset, yOffset)
    ToggleDropDownMenu(level, value, menu, anchor, xOffset, yOffset);
    if (not level) then
        level = 1;
    end
    local anchorName;
    if ( type(anchor) == "string" ) then
        anchorName = anchor;
    else
        anchorName = anchor:GetName();
    end
    local frame = _G["DropDownList"..level];
    local uiScale = UIParent:GetScale()
    if ( frame:GetRight() > ( GetScreenWidth()*uiScale ) ) then
        if ( anchorName == "cursor" ) then
            if ( not xOffset ) then
                xOffset = 0;
            end
            if ( not yOffset ) then
                yOffset = 0;
            end
            local cursorX, cursorY = GetCursorPosition();
            xOffset = -cursorX + xOffset;
            yOffset = cursorY + yOffset;
        else
            if ( not xOffset or not yOffset ) then
                xOffset = 8;
                yOffset = 22;
            end
        end
        frame:ClearAllPoints();
        frame:SetPoint("TOPRIGHT", anchorName, "BOTTOMLEFT", -xOffset, yOffset);
    end
    if ( frame:GetBottom() < 0 ) then
        frame:ClearAllPoints();
        frame:SetPoint("BOTTOMRIGHT", anchorName, "BOTTOMLEFT", -xOffset, yOffset);
    end
end

FishingBuddy.EnglishList = function(list, conjunction)
    if ( list ) then
        local n = table.getn(list);
        local str = "";
        for idx=1,n do
            local name = list[idx];
            if ( idx == 1 ) then
                str = name;
            elseif ( idx == n ) then
                str = str .. ", ";
                if ( conjunction ) then
                    str = str .. conjunction;
                else
                    str = str .. "and";
                end
                str = str .. " " .. name;
            else
                str = str .. ", " .. name;
            end
        end
        return str;
    end
end

FishingBuddy.UIError = function(msg)
    -- Okay, this check is probably not necessary...
    if ( UIErrorsFrame ) then
        UIErrorsFrame:AddMessage(msg, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
    else
        FishingBuddy.Error(msg);
    end
end

FishingBuddy.Testing = function(line)
    if ( not FishingBuddy_Info["Testing"] ) then
        FishingBuddy_Info["Testing"] = {};
    end
    tinsert(FishingBuddy_Info["Testing"], line);
end


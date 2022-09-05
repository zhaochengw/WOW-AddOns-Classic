local addonName, AutoLoot = ...;
local Settings = {};
local internal = {
    _frame = CreateFrame("frame");
    isItemLocked = false,
    isLooting = false,
    isHidden = false,
    ElvUI = false,
    isClassic = (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE),
    audioChannel = "master",
};

function AutoLoot:ProcessLootItem(itemLink, itemQuantity)
    local itemFamily = GetItemFamily(itemLink);
    for i = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
        local free, bagFamily = GetContainerNumFreeSlots(i);
        if (not bagFamily or bagFamily == 0) or (itemFamily and bit.band(itemFamily, bagFamily) > 0) then
            if free > 0 then
                return true;
            end
        end
    end

    local inventoryItemCount = GetItemCount(itemLink);
    if inventoryItemCount > 0 then
        local itemStackSize = select(8, GetItemInfo(itemLink));
        if itemStackSize > 1 then
            local remainingSpace = (itemStackSize - inventoryItemCount) % itemStackSize;
            if remainingSpace >= itemQuantity then
                return true;
            end
        end
    end

    return false;
end

function AutoLoot:LootItems(numItems)
    local lootThreshold = (internal.isClassic and select(2,GetLootMethod()) == 0) and GetLootThreshold() or 10;
    for i = numItems, 1, -1 do
        local itemLink = GetLootSlotLink(i);
        local slotType = GetLootSlotType(i);
        local quantity, _, quality, locked, isQuestItem = select(3, GetLootSlotInfo(i));
        if locked or (quality and quality >= lootThreshold) then
            internal.isItemLocked = true;
        else
            if slotType ~= LOOT_SLOT_ITEM or (not internal.isClassic and isQuestItem) or self:ProcessLootItem(itemLink, quantity) then
                numItems = numItems - 1;
                LootSlot(i);
            end
        end
    end
    if numItems > 0 then
        self:ShowLootFrame(true);
        self:PlayInventoryFullSound();
    end

    if IsFishingLoot() and not Settings.global.fishingSoundDisabled then
        PlaySound(SOUNDKIT.FISHING_REEL_IN, internal.audioChannel);
    end
end

function AutoLoot:OnLootReady(autoLoot)
    if not internal.isLooting then
        internal.isLooting = true;

        local numItems = GetNumLootItems();
        if numItems == 0 then
            return;
        end

        if autoLoot or (autoLoot == nil and GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE")) then
            self:LootItems(numItems);
        else
            self:ShowLootFrame(true);
        end
    end
end

function AutoLoot:OnLootClosed()
    internal.isLooting = false;
    internal.isHidden = false;
    internal.isItemLocked = false;
    self:ShowLootFrame(false);

    -- Workaround for TSM Destroy issue
    if TSMDestroyBtn and TSMDestroyBtn:IsVisible() then
        C_Timer.NewTicker(0, function() SlashCmdList.TSM("destroy") end, 2);
    end
end

function AutoLoot:OnErrorMessage(...)
    if tContains(({ERR_INV_FULL,ERR_ITEM_MAX_COUNT}), select(2,...)) then
        if internal.isLooting and internal.isHidden then
            self:ShowLootFrame(true);
            self:PlayInventoryFullSound();
        end
    end
end

function AutoLoot:OnBindConfirm()
    if internal.isLooting and internal.isHidden then
        self:ShowLootFrame(true);
    end
end

function AutoLoot:PlayInventoryFullSound()
    if Settings.global.enableSound and not internal.isItemLocked then
        PlaySound(Settings.global.InventoryFullSound, internal.audioChannel);
    end
end

local function AddMessage(...) _G.DEFAULT_CHAT_FRAME:AddMessage(strjoin(" ", tostringall(...))) end;
function AutoLoot:Help(msg)
    local fName = "|cffEEE4AESpeedy AutoLoot:|r ";
    local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)");
    if not cmd or cmd == "" or cmd == "help" then
        AddMessage(fName.."   |cff58C6FA/sal    /speedyautoloot    /speedyloot|r");
        AddMessage("  |cff58C6FA/sal auto              -|r  |cffEEE4AEEnable Auto Looting for all characters|r");
        AddMessage("  |cff58C6FA/sal fish              -|r  |cffEEE4AEDisable Fishing reel in sound|r");
        AddMessage("  |cff58C6FA/sal sound            -|r  |cffEEE4AEPlay a Sound when Inventory is full while looting|r");
        if internal.isClassic then
            AddMessage("  |cff58C6FA/sal set (SoundID) -|r  |cffEEE4AESet a Sound (SoundID), Default:  /sal set 139|r");
        else
            AddMessage("  |cff58C6FA/sal set (SoundID) -|r  |cffEEE4AESet a Sound (SoundID), Default:  /sal set 44321|r");
        end
    elseif cmd == "fish" then
        if not Settings.global.fishingSoundDisabled then
            AddMessage(fName.."|cffB6B6B6Fishing reel in sound disabled.");
        else
            AddMessage(fName.."|cff37DB33Fishing reel in sound enabled.");
        end
        Settings.global.fishingSoundDisabled = not Settings.global.fishingSoundDisabled;
    elseif cmd == "auto" then
        if Settings.global.alwaysEnableAutoLoot then
            AddMessage(fName.."|cffB6B6B6Auto Loot for all Characters disabled.");
            SetCVar("autoLootDefault",0);
        else
            AddMessage(fName.."|cff37DB33Auto Loot for all Characters enabled.");
            SetCVar("autoLootDefault",1);
        end
        Settings.global.alwaysEnableAutoLoot = not Settings.global.alwaysEnableAutoLoot;
    elseif cmd == "sound" then
        if Settings.global.enableSound then
            AddMessage(fName.."|cffB6B6B6Don't play a sound when inventory is full.");
        else
            if not Settings.global.InventoryFullSound then
                if internal.isClassic then
                    Settings.global.InventoryFullSound = 139;
                else
                    Settings.global.InventoryFullSound = 44321;
                end
            end
            AddMessage(fName.."|cff37DB33Play a sound when inventory is full.");
        end
        Settings.global.enableSound = not Settings.global.enableSound;
    elseif cmd == "set" and args ~= "" then
        local SoundID = tonumber(args:match("%d+"));
        if SoundID then
            Settings.global.InventoryFullSound = tonumber(args:match("%d+"));
            PlaySound(SoundID, internal.audioChannel);
            AddMessage(fName.."Set Sound|r |cff37DB33"..SoundID.."|r");
        end
    end
end

function AutoLoot:Anchor(frame)
    internal.isHidden = false;

    frame:SetFrameStrata("HIGH");
    if internal.ElvUI then
        frame:SetParent(ElvLootFrameHolder);
    else
        frame:SetParent(UIParent);
    end

    if GetCVarBool("lootUnderMouse") then
        local x, y = GetCursorPosition();
        x = x / frame:GetEffectiveScale();
        y = y / frame:GetEffectiveScale();

        frame:ClearAllPoints();
        frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x - 40, y + 20);
        frame:GetCenter();
        frame:Raise();
    else
        frame:ClearAllPoints();
        if internal.ElvUI then
            frame:SetPoint("TOPLEFT", ElvLootFrameHolder, "TOPLEFT");
        else
            frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20, -125);
        end
    end
end

function AutoLoot:ShowLootFrame(show)
    if internal.ElvUI then
        if show then
            self:Anchor(ElvLootFrame);
        else
            ElvLootFrame:SetParent(internal._frame);
            internal.isHidden = true;
        end
    elseif LootFrame:IsEventRegistered("LOOT_SLOT_CLEARED") then
        if show then
            self:Anchor(LootFrame);
        else
            LootFrame:SetParent(internal._frame);
            internal.isHidden = true;
        end
    end
end

SLASH_SPEEDYAUTOLOOT1, SLASH_SPEEDYAUTOLOOT2  = "/sal", "/speedyautoloot";
function SlashCmdList.SPEEDYAUTOLOOT(...)
    AutoLoot:Help(...);
end

function AutoLoot:OnAddonLoaded(name)
    if name == addonName then
        SpeedyAutoLootDB = SpeedyAutoLootDB or {};
        Settings = SpeedyAutoLootDB;
        Settings.global = Settings.global or {};

        if Settings.global.alwaysEnableAutoLoot then
            SetCVar("autoLootDefault",1);
        end

        C_Timer.After(1, function()
            internal.ElvUI = (ElvUI and ElvUI[1].private.general.loot);
            self:ShowLootFrame(false);
        end)
    end
end

function AutoLoot:RegisterEvent(event, func)
    internal._frame[event] = func;
    internal._frame:RegisterEvent(event);
end

function AutoLoot:OnInit()
    internal._frame:SetToplevel(true);
    internal._frame:Hide();
    self:RegisterEvent("ADDON_LOADED", self.OnAddonLoaded);
    self:RegisterEvent("LOOT_READY", self.OnLootReady);
    self:RegisterEvent("LOOT_OPENED", self.OnLootReady);
    self:RegisterEvent("LOOT_CLOSED", self.OnLootClosed);
    self:RegisterEvent("UI_ERROR_MESSAGE", self.OnErrorMessage);

    if internal.isClassic then
        self:RegisterEvent("LOOT_BIND_CONFIRM", self.OnBindConfirm);
    end

    internal._frame:SetScript("OnEvent", function(_,event,...) internal._frame[event](self, ...) end);
end

AutoLoot:OnInit();
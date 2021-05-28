local addonName = ...
local AutoLoot = CreateFrame("Frame")
local Settings = {}

local BACKPACK_CONTAINER, LOOT_SLOT_ITEM, NUM_BAG_SLOTS = BACKPACK_CONTAINER, LOOT_SLOT_ITEM, NUM_BAG_SLOTS
local GetContainerNumFreeSlots = GetContainerNumFreeSlots
local GetItemCount = GetItemCount
local GetItemInfo = GetItemInfo
local GetLootSlotInfo = GetLootSlotInfo
local GetLootSlotLink = GetLootSlotLink
local GetLootSlotType = GetLootSlotType
local band = bit.band
local select = select

function AutoLoot:ProcessLootItem(itemLink, itemQuantity)
    local itemFamily = GetItemFamily(itemLink)
    for i = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
        local free, bagFamily = GetContainerNumFreeSlots(i)
        if (not bagFamily or bagFamily == 0) or (itemFamily and band(itemFamily, bagFamily) > 0) then
            if free > 0 then
                return true
            end
        end
    end

    local inventoryItemCount = GetItemCount(itemLink)
    if inventoryItemCount and inventoryItemCount > 0 then
        local itemStackSize = select(8, GetItemInfo(itemLink))
        if itemStackSize and itemStackSize > 1 then
            if ( ( itemStackSize - inventoryItemCount ) % itemStackSize ) >= itemQuantity then
                return true
            end
        end
    end

    return false
end

function AutoLoot:LootItems(numItems)
    local lootThreshold = (self.isClassic and select(2,GetLootMethod()) == 0) and GetLootThreshold() or 10
    for i = numItems, 1, -1 do
        local itemLink = GetLootSlotLink(i)
        local slotType = GetLootSlotType(i)
        local quantity, _, quality, locked, isQuestItem = select(3, GetLootSlotInfo(i))
        if locked or (quality and quality >= lootThreshold) then
            self.isItemLocked = true
        else
            if slotType ~= LOOT_SLOT_ITEM or (not self.isClassic and isQuestItem) or self:ProcessLootItem(itemLink, quantity) then
                numItems = numItems - 1
                LootSlot(i)
            end
        end
    end
    if numItems > 0 then
        self:ShowLootFrame(true)
        self:PlayInventoryFullSound()
    end

    if IsFishingLoot() and not Settings.global.fishingSoundDisabled then
        PlaySound(SOUNDKIT.FISHING_REEL_IN, self.audioChannel)
    end
end

function AutoLoot:OnEvent(e, ...)
    if e == "ADDON_LOADED" then
        local name = ...
        if name == addonName then
            SpeedyAutoLootDB = SpeedyAutoLootDB or {}
            Settings = SpeedyAutoLootDB
            Settings.global = Settings.global or {}
        elseif name == "TradeSkillMaster" then
            self.TSMLoaded = true
        end
    elseif e == "PLAYER_LOGIN" then
        if Settings.global.alwaysEnableAutoLoot then
            SetCVar("autoLootDefault",1)
        end

        C_Timer.After(1, function()
            self.ElvUI = (ElvUI and ElvUI[1].private.general.loot)
            self:ShowLootFrame(false)
        end)
    elseif (e == "LOOT_READY" or e == "LOOT_OPENED") and not self.isLooting then
        local aL = ...

        local numItems = GetNumLootItems()
        if numItems == 0 then
            return
        end

        self.isLooting = true
        if aL or (aL == nil and GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE")) then
            self:LootItems(numItems)
        else
            self:ShowLootFrame(true)
        end
    elseif e == "LOOT_CLOSED" then
        self.isLooting = false
        self.isHidden = false
        self.isItemLocked = false

        self:ShowLootFrame(false)

        -- Workaround for TSM Destroy issue
        if self.TSMLoaded and TSMDestroyBtn and TSMDestroyBtn:IsVisible() then
            C_Timer.NewTicker(0, function() SlashCmdList.TSM("destroy") end, 2)
        end
    elseif (e == "UI_ERROR_MESSAGE" and tContains(({ERR_INV_FULL,ERR_ITEM_MAX_COUNT}), select(2,...))) or e == "LOOT_BIND_CONFIRM" then
        if self.isLooting and self.isHidden then
            self:ShowLootFrame(true)
            if e == "UI_ERROR_MESSAGE" then
                self:PlayInventoryFullSound()
            end
        end
    end
end

function AutoLoot:PlayInventoryFullSound()
    if Settings.global.enableSound and not self.isItemLocked then
        PlaySound(Settings.global.InventoryFullSound, self.audioChannel)
    end
end

local function AddMessage(...) _G.DEFAULT_CHAT_FRAME:AddMessage(strjoin(" ", tostringall(...))) end
function AutoLoot:Help(msg)
    local fName = "|cffEEE4AESpeedy AutoLoot:|r "
    local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
    if not cmd or cmd == "" or cmd == "help" then
        AddMessage(fName.."   |cff58C6FA/sal    /speedyautoloot    /speedyloot|r")
        AddMessage("  |cff58C6FA/sal auto              -|r  |cffEEE4AEEnable Auto Looting for all characters|r")
        AddMessage("  |cff58C6FA/sal fish              -|r  |cffEEE4AEDisable Fishing reel in sound|r")
        AddMessage("  |cff58C6FA/sal sound            -|r  |cffEEE4AEPlay a Sound when Inventory is full while looting|r")
        if self.isClassic then
            AddMessage("  |cff58C6FA/sal set (SoundID) -|r  |cffEEE4AESet a Sound (SoundID), Default:  /sal set 139|r")
        else
            AddMessage("  |cff58C6FA/sal set (SoundID) -|r  |cffEEE4AESet a Sound (SoundID), Default:  /sal set 44321|r")
        end
    elseif cmd == "fish" then
        if not Settings.global.fishingSoundDisabled then
            AddMessage(fName.."|cffB6B6B6Fishing reel in sound disabled.")
        else
            AddMessage(fName.."|cff37DB33Fishing reel in sound enabled.")
        end
        Settings.global.fishingSoundDisabled = not Settings.global.fishingSoundDisabled
    elseif cmd == "auto" then
        if Settings.global.alwaysEnableAutoLoot then
            AddMessage(fName.."|cffB6B6B6Auto Loot for all Characters disabled.")
            SetCVar("autoLootDefault",0)
        else
            AddMessage(fName.."|cff37DB33Auto Loot for all Characters enabled.")
            SetCVar("autoLootDefault",1)
        end
        Settings.global.alwaysEnableAutoLoot = not Settings.global.alwaysEnableAutoLoot
    elseif cmd == "sound" then
        if Settings.global.enableSound then
            AddMessage(fName.."|cffB6B6B6Don't play a sound when inventory is full.")
        else
            if not Settings.global.InventoryFullSound then
                if self.isClassic then
                    Settings.global.InventoryFullSound = 139
                else
                    Settings.global.InventoryFullSound = 44321
                end
            end
            AddMessage(fName.."|cff37DB33Play a sound when inventory is full.")
        end
        Settings.global.enableSound = not Settings.global.enableSound
    elseif cmd == "set" and args ~= "" then
        local SoundID = tonumber(args:match("%d+"))
        if SoundID then
            Settings.global.InventoryFullSound = tonumber(args:match("%d+"))
            PlaySound(SoundID, self.audioChannel)
            AddMessage(fName.."Set Sound|r |cff37DB33"..SoundID.."|r")
        end
    end
end

function AutoLoot:OnLoad()
    self:SetToplevel(true)
    self:Hide()
    self:SetScript("OnEvent", self.OnEvent)

    for _, e in pairs({ "ADDON_LOADED", "PLAYER_LOGIN", "LOOT_READY", "LOOT_OPENED", "LOOT_CLOSED", "UI_ERROR_MESSAGE" }) do
        self:RegisterEvent(e)
    end

    self.audioChannel = "master"
    self.isClassic = (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE)

    if self.isClassic then
        self:RegisterEvent("LOOT_BIND_CONFIRM")
        self:RegisterEvent("OPEN_MASTER_LOOT_LIST")
    end

    LootFrame:UnregisterEvent('LOOT_OPENED')
end

function AutoLoot:ShowDefaultLootFrame()
    self = _G.LootFrame
    self.page = 1;
    -- ShowUIPanel inside LootFrame_Show is protected so we need to do some handling for combat, thanks Blizzard.
    if not InCombatLockdown() then
        LootFrame_Show(self)
        return
    end
    self.numLootItems = GetNumLootItems();

    if GetCVarBool("lootUnderMouse") then
        self:Show();
        -- position loot window under mouse cursor
        local x, y = GetCursorPosition();
        x = x / self:GetEffectiveScale();
        y = y / self:GetEffectiveScale();

        local posX = x - 175;
        local posY = y + 25;

        if (self.numLootItems > 0) then
            posX = x - 40;
            posY = y + 55;
            posY = posY + 40;
        end

        if( posY < 350 ) then
            posY = 350;
        end

        self:ClearAllPoints();
        self:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", posX, posY);
        self:GetCenter();
        self:Raise();
    else
        self:Show()
        -- Better than nothing
        self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20, -125);
    end

    LootFrame_Update();
    LootFramePortraitOverlay:SetTexture("Interface\\TargetingFrame\\TargetDead");
end

function AutoLoot:ShowLootFrame(show)
    if self.ElvUI then
        if show then
            ElvLootFrame:SetParent(ElvLootFrameHolder)
            ElvLootFrame:SetFrameStrata("HIGH")
            self.isHidden = false

            if GetCVarBool("lootUnderMouse") then
                local x, y = GetCursorPosition()
                x = x / ElvLootFrame:GetEffectiveScale()
                y = y / ElvLootFrame:GetEffectiveScale()

                ElvLootFrame:ClearAllPoints()
                ElvLootFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x - 40, y + 20)
                ElvLootFrame:GetCenter()
                ElvLootFrame:Raise()
            else
                ElvLootFrame:ClearAllPoints()
                ElvLootFrame:SetPoint("TOPLEFT", ElvLootFrameHolder, "TOPLEFT")
            end
        else
            ElvLootFrame:SetParent(self)
            self.isHidden = true
        end
    elseif LootFrame:IsEventRegistered("LOOT_SLOT_CLEARED") then
        if show then
            self:ShowDefaultLootFrame()
            self.isHidden = false
        else
            self.isHidden = true
        end
    end
end

SLASH_SPEEDYAUTOLOOT1, SLASH_SPEEDYAUTOLOOT2, SLASH_SPEEDYAUTOLOOT3  = "/sal", "/speedyloot", "/speedyautoloot"
function SlashCmdList.SPEEDYAUTOLOOT(...)
    AutoLoot:Help(...)
end

AutoLoot:OnLoad()
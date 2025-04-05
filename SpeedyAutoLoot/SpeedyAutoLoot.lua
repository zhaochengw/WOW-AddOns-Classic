
local addonName = ...; ---@type string addonName
local AutoLoot = select(2, ...); ---@class AutoLoot namespace

local Config = {};
local internal = {
  _frame = CreateFrame("frame", nil, UIParent),
  lootThreshold = 10,
  isAnyItemLocked = false,
  isLooting = false,
  isHidden = true,
  ElvUI = false,
  ShowElvUILootFrame = nop,
  isClassicEra = LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_CLASSIC,
  isClassic = (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE),
  audioChannel = "master",
  Dragonflight = 9,
  slotsLooted = {},
  inventorySoundPlayed = false,
};

local LOOT_SLOT_ITEM = Enum.LootSlotType.Item
local keyRing = Enum.BagIndex.Keyring

---@param itemLink ItemInfo
---@param itemQuantity number
---@return boolean itemFitsInBag
function AutoLoot:ProcessLootItem(itemLink, itemQuantity)
  local itemStackCount, _, _, _, classID, subclassID, _, _, _, isCraftingReagent = select(8, C_Item.GetItemInfo(itemLink));
  local itemFamily = C_Item.GetItemFamily(itemLink);

  if internal.isClassicEra and itemFamily == 256 then
    local freeKeyringSlots = C_Container.GetContainerNumFreeSlots(keyRing)
    if freeKeyringSlots > 0 then
        return true;
    end
  end

  local inventoryItemCount = C_Item.GetItemCount(itemLink);
  if inventoryItemCount > 0 and itemStackCount > 1 then
    if ((itemStackCount - inventoryItemCount) % itemStackCount) >= itemQuantity then
      return true;
    end
  end

  for bagSlot = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS or NUM_BAG_SLOTS do
    local freeSlots, bagFamily = C_Container.GetContainerNumFreeSlots(bagSlot);
    -- unclear if isCraftingReagent is 100% Reagent bag fitable, seems to be.
    if freeSlots > 0 then
      if bagSlot == 5 then
        if isCraftingReagent then
          return true
        else
          return false;
        end
      end
      if not bagFamily or bagFamily == 0 or (itemFamily and bit.band(itemFamily, bagFamily) > 0) then
        return true;
      end
    end
  end

  return false;
end

---@param slot number
---@return boolean success
function AutoLoot:LootSlot(slot)
  local itemLink = GetLootSlotLink(slot);
  local slotType = GetLootSlotType(slot);
  local lootQuantity, _, lootQuality, lootLocked, isQuestItem = select(3, GetLootSlotInfo(slot));
  if lootLocked or (lootQuality and lootQuality >= internal.lootThreshold) then
    internal.isAnyItemLocked = true;
    return false;
  elseif slotType ~= LOOT_SLOT_ITEM or (not internal.isClassic and isQuestItem) or self:ProcessLootItem(itemLink, lootQuantity) then
    LootSlot(slot);
    internal.slotsLooted[slot] = true;
    if internal.isClassic then
      if Config.global.autoConfirm and not (GetNumGroupMembers() > 1) then
        ConfirmLootSlot(slot)
      end
    end
    return true;
  end

  return false
end

---@param autoLoot boolean
function AutoLoot:OnLootReady(autoLoot)
  if internal.isLooting then return end

  internal.isLooting = true;
  self:ResetLootFrame();
  local numItems = GetNumLootItems();
  if numItems == 0 then
    return;
  end

  if IsFishingLoot() and not Config.global.fishingSoundDisabled then
    PlaySound(SOUNDKIT.FISHING_REEL_IN, internal.audioChannel);
  end

  if autoLoot or (autoLoot == nil and GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE")) then
    local lootMethod = GetLootMethod();
    internal.lootThreshold = (internal.isClassic and IsInGroup() and (lootMethod=="group" or lootMethod=="needbeforegreed" or lootMethod=="master")) and GetLootThreshold() or 10;
    for slot = numItems, 1, -1 do
      numItems = self:LootSlot(slot) and numItems - 1 or numItems;
    end

    if numItems > 0 then
      self:ShowLootFrame();
    end
  else
    self:ShowLootFrame();
  end
end

---@param slot number
function AutoLoot:OnBindConfirm(slot)
  if LootSlotHasItem(slot) and internal.isLooting then
    if internal.isClassic then
      if Config.global.autoConfirm and not (GetNumGroupMembers() > 1) then
        ConfirmLootSlot(slot);
      end
    end
    if internal.isHidden then
      self:ShowLootFrame(true);
    end
  end
end

---@param slot number
function AutoLoot:OnSlotChanged(slot)
  -- was a working workaround for bugged stackables in wrath, but might still be useful to keep
  -- Check if we looted the slot internally and loot it again if it still has a item in the slot.
  -- this should block situations where that event fires but there is still something in the slot we previously looted resulting in unlooted stuff
  if internal.isLooting and internal.slotsLooted[slot] and LootSlotHasItem(slot) then
    self:LootSlot(slot);
  end
end
--[[
function AutoLoot:OnSlotCleared(slot)
  if internal.isLooting then
    if internal.slotsLooted[slot] then
      internal.slotsCleared[slot] = true
    end
  end
end
]]
function AutoLoot:OnLootClosed()
  internal.isLooting = false;
  internal.isHidden = true;
  internal.isAnyItemLocked = false;
  internal.inventorySoundPlayed = false;
  if self.isClassic then
    wipe(internal.slotsLooted);
  end
  self:ResetLootFrame();
  -- Workaround for TSM Destroy issue
  if TSMDestroyBtn and TSMDestroyBtn:IsVisible() then
    C_Timer.NewTicker(0, function() SlashCmdList.TSM("destroy") end, 2);
  end
end

---@param gameErrorIndex number
---@param message string
function AutoLoot:OnErrorMessage(gameErrorIndex, message)
  if tContains(({ERR_INV_FULL,ERR_ITEM_MAX_COUNT,ERR_LOOT_ROLL_PENDING}), message) then
    if internal.isLooting and internal.isHidden then
      self:ShowLootFrame(true);
    end
    if internal.isLooting and message ~= ERR_LOOT_ROLL_PENDING then
      self:PlayInventoryFullSound();
    end
  end
end

function AutoLoot:PlayInventoryFullSound()
  if Config.global.enableSound and not internal.inventorySoundPlayed and not internal.isAnyItemLocked then
    internal.inventorySoundPlayed = true;
    PlaySound(Config.global.InventoryFullSound, internal.audioChannel);
  end
end

-- Reanchor on Show to make sure the frame appears where it should on delayed actions.
function AutoLoot:AnchorLootFrame()
  local f = LootFrame
  if GetCVarBool("lootUnderMouse") then
    local x, y = GetCursorPosition();
    f:ClearAllPoints();

    if LE_EXPANSION_LEVEL_CURRENT >= internal.Dragonflight then
      x = x / (f:GetEffectiveScale()) - 30;
      y = math.max((y / f:GetEffectiveScale()) + 50, 350);
      f:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", x, y);
    else
      x = x / f:GetEffectiveScale();
      y = y / f:GetEffectiveScale();
      f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x - 40, y + 20);
      f:GetCenter();
    end
    f:Raise();
  else
    if LE_EXPANSION_LEVEL_CURRENT >= internal.Dragonflight then
      local scale = f:GetScale();
      f:SetPoint(f.systemInfo.anchorInfo.point, f.systemInfo.anchorInfo.relativeTo, f.systemInfo.anchorInfo.relativePoint, f.systemInfo.anchorInfo.offsetX / scale, f.systemInfo.anchorInfo.offsetY / scale);
    else
      f:ClearAllPoints();
      f:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20, -125);
    end
  end
  --f:Show()
end

---@param delayed boolean?
function AutoLoot:ShowLootFrame(delayed)
  internal.isHidden = false;
  if internal.ElvUI then
    internal.ShowElvUILootFrame();
    return;
  elseif LootFrame:IsEventRegistered("LOOT_OPENED") then
      LootFrame:SetParent(UIParent);
      LootFrame:SetFrameStrata("HIGH");
      self:AnchorLootFrame();
      if delayed then
        self:AnchorLootFrame();
      end
  end
end

function AutoLoot:ResetLootFrame()
  if not internal.ElvUI and LootFrame:IsEventRegistered("LOOT_OPENED") then
    LootFrame:SetParent(internal._frame);
  end
end

---@param name string
function AutoLoot:OnAddonLoaded(name)
  if name == addonName then
    SpeedyAutoLootDB = SpeedyAutoLootDB or {};
    Config = SpeedyAutoLootDB;
    Config.global = Config.global or {};

    if internal.isClassic then
      self:InitClassic()
    end

    if Config.global.alwaysEnableAutoLoot then
      C_CVar.SetCVar("autoLootDefault", "1");
    end

    C_Timer.After(1, function()
      if (ElvUI and ElvUI[1].private.general.loot) and ElvUI[1]:GetModule("Misc").LOOT_OPENED then
        internal.ElvUI = true;
        local elvOnLootOpened = ElvUI[1]:GetModule("Misc").LOOT_OPENED;
        ElvUI[1]:GetModule("Misc").LOOT_OPENED = nop;
        internal.ShowElvUILootFrame = function(autoLoot)
          elvOnLootOpened(autoLoot);
        end
      end

      self:ResetLootFrame();
    end)
  end
end

function AutoLoot:RegisterEvent(event, func)
  if not internal._frame:IsEventRegistered(event) then
    internal._frame[event] = func;
    internal._frame:RegisterEvent(event);
  end
end

function AutoLoot:UnregisterEvent(event)
  if internal._frame:IsEventRegistered(event) then
    internal._frame[event] = nil;
    internal._frame:UnregisterEvent(event);
  end
end

function AutoLoot:OnInit()
  internal._frame:SetToplevel(true);
  internal._frame:Hide();

  self:RegisterEvent("ADDON_LOADED", self.OnAddonLoaded);
  self:RegisterEvent("LOOT_READY", self.OnLootReady);
  self:RegisterEvent("LOOT_OPENED", self.OnLootReady);
  self:RegisterEvent("LOOT_CLOSED", self.OnLootClosed);
  self:RegisterEvent("UI_ERROR_MESSAGE", self.OnErrorMessage);

  if not internal.ElvUI and LootFrame:IsEventRegistered("LOOT_OPENED") then
    if LE_EXPANSION_LEVEL_CURRENT >= internal.Dragonflight then
      hooksecurefunc(LootFrame, "UpdateShownState", function(self)
        if self.isInEditMode then
          self:SetParent(UIParent)
        else
          self:SetParent(internal._frame)
        end
      end);
    end
  end

  internal._frame:SetScript("OnEvent", function(_,event,...) internal._frame[event](self, ...) end);
end
AutoLoot:OnInit();

function AutoLoot:OnGroupJoined()
  UIParent:RegisterEvent("LOOT_BIND_CONFIRM");
end
function AutoLoot:OnGroupLeft()
  UIParent:UnregisterEvent("LOOT_BIND_CONFIRM");
end

function AutoLoot:AutoConfirmBop()
  if Config.global.autoConfirm then
    self:RegisterEvent("GROUP_LEFT", self.OnGroupLeft);
    self:RegisterEvent("GROUP_JOINED", self.OnGroupJoined);
    -- group events don't fire on a /reload and probably also not when you login while already in a group
    if GetNumGroupMembers() > 1 then
      self:OnGroupJoined();
    else
      self:OnGroupLeft();
    end
  else
    self:UnregisterEvent("GROUP_LEFT");
    self:UnregisterEvent("GROUP_JOINED");
    self:OnGroupJoined();
  end
end

function AutoLoot:InitClassic()
  self:RegisterEvent("LOOT_SLOT_CHANGED", self.OnSlotChanged);
  self:RegisterEvent("LOOT_BIND_CONFIRM", self.OnBindConfirm);

  self:AutoConfirmBop()
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
      AddMessage("  |cff58C6FA/sal bop         |cffEEE4AEAuto Confirm Bind on Pickups when solo|r");
    else
      AddMessage("  |cff58C6FA/sal set (SoundID) -|r  |cffEEE4AESet a Sound (SoundID), Default:  /sal set 44321|r");
    end
  elseif cmd == "fish" then
    if not Config.global.fishingSoundDisabled then
      AddMessage(fName.."|cffB6B6B6Fishing reel in sound disabled.");
    else
      AddMessage(fName.."|cff37DB33Fishing reel in sound enabled.");
    end
    Config.global.fishingSoundDisabled = not Config.global.fishingSoundDisabled;
  elseif cmd == "auto" then
    if Config.global.alwaysEnableAutoLoot then
      AddMessage(fName.."|cffB6B6B6Auto Loot for all Characters disabled.");
      C_CVar.SetCVar("autoLootDefault", "0");
    else
      AddMessage(fName.."|cff37DB33Auto Loot for all Characters enabled.");
      C_CVar.SetCVar("autoLootDefault", "1");
    end
    Config.global.alwaysEnableAutoLoot = not Config.global.alwaysEnableAutoLoot;
  elseif cmd == "sound" then
    if Config.global.enableSound then
      AddMessage(fName.."|cffB6B6B6Don't play a sound when inventory is full.");
    else
      if not Config.global.InventoryFullSound then
        if internal.isClassic then
          Config.global.InventoryFullSound = 139;
        else
          Config.global.InventoryFullSound = 44321;
        end
      end
      AddMessage(fName.."|cff37DB33Play a sound when inventory is full.");
    end
    Config.global.enableSound = not Config.global.enableSound;
  elseif cmd == "set" and args ~= "" then
    local SoundID = tonumber(args:match("%d+"));
    if SoundID then
      Config.global.InventoryFullSound = tonumber(args:match("%d+"));
      PlaySound(SoundID, internal.audioChannel);
      AddMessage(fName.."Set Sound|r |cff37DB33"..SoundID.."|r");
    end
  elseif internal.isClassic and cmd == "bop" then
    if Config.global.autoConfirm then
      AddMessage(fName.."|cffB6B6B6Automatically confirm loot when solo disabled.");
    else
      AddMessage(fName.."|cff37DB33Automatically confirm loot when solo enabled.");
    end
    Config.global.autoConfirm = not Config.global.autoConfirm
    AutoLoot:AutoConfirmBop()
  end
end

SLASH_SPEEDYAUTOLOOT1, SLASH_SPEEDYAUTOLOOT2  = "/sal", "/speedyautoloot";
function SlashCmdList.SPEEDYAUTOLOOT(...)
  AutoLoot:Help(...);
end
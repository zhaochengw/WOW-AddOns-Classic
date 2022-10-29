local addonName, AutoLoot = ...;

local Settings = {};
local internal = {
  _frame = CreateFrame("frame"),
  lootThreshold = 10,
  isItemLocked = false,
  isLooting = false,
  isHidden = true,
  ElvUI = false,
  ShowElvUILootFrame = nop,
  isClassic = (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE),
  audioChannel = "master",
  Dragonflight = 9,
  slotsLooted = {},
};

-- Compat
local GetContainerNumFreeSlots = GetContainerNumFreeSlots or C_Container.GetContainerNumFreeSlots
local LOOT_SLOT_ITEM = LOOT_SLOT_ITEM or Enum.LootSlotType.Item

function AutoLoot:ProcessLootItem(itemLink, itemQuantity)
  local itemStackSize, _, _, _, itemClassID = select(8, GetItemInfo(itemLink));
  local itemFamily = GetItemFamily(itemLink);

  for i = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS or NUM_BAG_SLOTS do
    local free, bagFamily = GetContainerNumFreeSlots(i);
    if i == 5 then
      if itemClassID == Enum.ItemClass.Tradegoods and free > 0 then
        return true;
      end
      break;
    end
    if (not bagFamily or bagFamily == 0) or (itemFamily and bit.band(itemFamily, bagFamily) > 0) then
      if free > 0 then
        return true;
      end
    end
  end

  local inventoryItemCount = GetItemCount(itemLink);
  if inventoryItemCount > 0 then
    if itemStackSize > 1 then
      local remainingSpace = (itemStackSize - inventoryItemCount) % itemStackSize;
      if remainingSpace >= itemQuantity then
        return true;
      end
    end
  end

  return false;
end

function AutoLoot:LootSlot(slot)
  local itemLink = GetLootSlotLink(slot);
  local slotType = GetLootSlotType(slot);
  local lootQuantity, _, lootQuality, lootLocked, isQuestItem = select(3, GetLootSlotInfo(slot));
  if lootLocked or (lootQuality and lootQuality >= internal.lootThreshold) then
    internal.isItemLocked = true;
  elseif slotType ~= LOOT_SLOT_ITEM or (not internal.isClassic and isQuestItem) or self:ProcessLootItem(itemLink, lootQuantity) then
    LootSlot(slot);
    if internal.isClassic then
      internal.slotsLooted[slot] = true;
    end
    return true;
  end
end

function AutoLoot:OnLootReady(autoLoot)
  if not internal.isLooting then
    internal.isLooting = true;
    self:ResetLootFrame()
    local numItems = GetNumLootItems();
    if numItems == 0 then
      return;
    end

    if IsFishingLoot() and not Settings.global.fishingSoundDisabled then
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
        self:PlayInventoryFullSound();
      end
    else
      self:ShowLootFrame();
    end
  end
end

function AutoLoot:OnSlotChanged(slot)
  -- workaround for bugged stackables in wrath
  -- Check if we attempted to loot the slot internally, i don't actually know in what situations LOOT_SLOT_CHANGED fires
  -- this should block situations where that event fires but the addon never attempted to loot the slot in the first place, should be good enough
  if internal.isLooting and internal.slotsLooted[slot] and LootSlotHasItem(slot) then
    self:LootSlot(slot);
  end
end

function AutoLoot:OnLootClosed()
  internal.isLooting = false;
  internal.isHidden = true;
  internal.isItemLocked = false;
  wipe(internal.slotsLooted);
  self:ResetLootFrame();
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

--[[ function AutoLoot:OnGroupJoined()
	UIParent:RegisterEvent("LOOT_BIND_CONFIRM");
end

function AutoLoot:OnGroupLeft()
	UIParent:UnregisterEvent("LOOT_BIND_CONFIRM");
end ]]

function AutoLoot:PlayInventoryFullSound()
  if Settings.global.enableSound and not internal.isItemLocked then
    PlaySound(Settings.global.InventoryFullSound, internal.audioChannel);
  end
end

-- Reanchor on Show to make sure the frame appears where it should on delayed actions.
function AutoLoot:AnchorLootFrame()
  local f = LootFrame
  if GetCVarBool("lootUnderMouse") then
    local x, y = GetCursorPosition();
    f:ClearAllPoints();
    x = x / f:GetEffectiveScale();
    y = y / f:GetEffectiveScale();
    f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x - 40, y + 20);
    f:GetCenter();
    f:Raise();
  else
      f:ClearAllPoints();
      f:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20, -125);
    end
  f:Show()
end

function AutoLoot:ShowLootFrame(delayed)
  internal.isHidden = false;
  if internal.ElvUI then
    internal.ShowElvUILootFrame();
  elseif LootFrame:IsEventRegistered("LOOT_OPENED") then
    if LE_EXPANSION_LEVEL_CURRENT < internal.Dragonflight then
      LootFrame:SetParent(UIParent);
      LootFrame:SetFrameStrata("HIGH");
      if delayed then
        self:AnchorLootFrame();
      end
    end
  end
end

function AutoLoot:ResetLootFrame()
  if not internal.ElvUI and LootFrame:IsEventRegistered("LOOT_OPENED") then
    if LE_EXPANSION_LEVEL_CURRENT >= internal.Dragonflight then return end
    LootFrame:SetParent(internal._frame);
  end
end

function AutoLoot:OnAddonLoaded(name)
  if name == addonName then
    SpeedyAutoLootDB = SpeedyAutoLootDB or {};
    Settings = SpeedyAutoLootDB;
    Settings.global = Settings.global or {};

    if Settings.global.alwaysEnableAutoLoot then
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
--[[     self:RegisterEvent("GROUP_LEFT", self.OnGroupLeft);
    self:RegisterEvent("GROUP_JOINED", self.OnGroupJoined);
    -- group events don't fire on a /reload and probably also not when you login while already in a group
    if not IsInGroup() then
      self:OnGroupLeft();
    end ]]

    if LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_WRATH_OF_THE_LICH_KING then
      self:RegisterEvent("LOOT_SLOT_CHANGED", self.OnSlotChanged);
    end
  end

  internal._frame:SetScript("OnEvent", function(_,event,...) internal._frame[event](self, ...) end);
end

AutoLoot:OnInit();

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
      C_CVar.SetCVar("autoLootDefault", "0");
    else
      AddMessage(fName.."|cff37DB33Auto Loot for all Characters enabled.");
      C_CVar.SetCVar("autoLootDefault", "1");
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

SLASH_SPEEDYAUTOLOOT1, SLASH_SPEEDYAUTOLOOT2  = "/sal", "/speedyautoloot";
function SlashCmdList.SPEEDYAUTOLOOT(...)
  AutoLoot:Help(...);
end
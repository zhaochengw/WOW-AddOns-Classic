local addonName = ...
local BetterFishing = {}

local internal = {
  -- Defaults
  _frame = CreateFrame("frame"),
  clear_override = false,
  cvarsChanged = false,
  DOUBLECLICK_MIN_SECONDS = 0.04,
  previousClickTime = 0,
  isClassic = WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE,
  isClassicEra = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC,
  isAtLeastMoP = LE_EXPANSION_LEVEL_CURRENT >= 4,
}

local soundCache = {}
local CVarCacheSounds = {
  "Sound_MasterVolume",
  "Sound_SFXVolume",
  "Sound_EnableAmbience",
  "Sound_MusicVolume",
  "Sound_EnableAllSound",
  "Sound_EnablePetSounds",
  "Sound_EnableSoundWhenGameIsInBG",
  "Sound_EnableSFX",
}

BINDING_NAME_BETTERFISHINGKEY = "Cast and Interact"

-- Compat
local IsSpellKnown = IsSpellKnown or C_SpellBook.IsSpellKnown

local FishingIDs = {
  [131474] = true,   -- Live/MoP
  [131490] = true,   -- Cast ID on MoP+ when pole equipped
  [131476] = true,   -- Cast ID on Live, and MoP without pole equipped
  [7620] = true,
  [7731] = true,
  [7732] = true,
  [18248] = true,
  [33095] = true,
  [51294] = true,
  [88868] = true,
  [110410] = true, -- MoP fishing
  [158743] = true, -- WoD Fishing
  [377895] = true, -- Ice Fishing
}

function BetterFishing:GetFishingID()
  if internal.isClassicEra then
    for fishingID, _ in pairs(FishingIDs) do
      if IsSpellKnown(fishingID) then
        return fishingID
      end
    end
  end

  return 131474
end

function BetterFishing:GetFishingName()
  -- technically 7620 exists on every version but still add mainline fallback if for some reason not
  local localizedName = C_Spell.GetSpellName(7620)
  return localizedName or C_Spell.GetSpellName(131474)
end

local function IsTaintable()
  return (InCombatLockdown() or (UnitAffectingCombat("player") or UnitAffectingCombat("pet")))
end

function BetterFishing:GetSecureButton()
  if not self.secureButton then
    local button = CreateFrame("Button", addonName.."Button", nil, "SecureActionButtonTemplate")
    button:RegisterForClicks("AnyDown", "AnyUp")
    button:SetAttribute("type", "spell")
    button:SetAttribute("spell", self:GetFishingID())
    button:SetScript("PostClick", function(self, mouse_button, down)
      MouselookStart()
      if down then return end
      MouselookStop()
    end)
    SecureHandlerWrapScript(button, "PostClick", button,  string.format([[
      local isClassic = %s
      if isClassic == true then
        self:ClearBindings()
      else
        if not down then
          self:ClearBindings()
        end
      end
    ]], tostring(internal.isClassic)))

    self.secureButton = button
  end
  return self.secureButton
end

function BetterFishing:IsFlying()
  if C_UnitAuras and not (C_Secrets and C_Secrets.ShouldSpellAuraBeSecret(125883)) then
    return C_UnitAuras.GetPlayerAuraBySpellID(125883)
  else
    return IsFlying()
  end
end

function BetterFishing_Run()
  if IsTaintable() or BetterFishing:IsFlying() or GetNumLootItems() ~= 0 or BetterFishing:IsFishing() or (not BetterFishingDB.overrideLunker and BetterFishing:IsLunkerActive()) then return end
  local key1, key2 = GetBindingKey("BETTERFISHINGKEY")
  local localizedName = BetterFishing:GetFishingName()
  if key1 then
    SetOverrideBindingSpell(BetterFishing:GetSecureButton(), 1, key1, localizedName)
  end
  if key2 then
    SetOverrideBindingSpell(BetterFishing:GetSecureButton(), 2, key2, localizedName)
  end
end

function BetterFishing:IsFishing()
  local spellID = select(8,UnitChannelInfo("player"))
  if FishingIDs[spellID] then
    return true
  end
  return false
end

function BetterFishing:IsLunkerActive()
  local spellID = select(8,UnitChannelInfo("player"))
  if spellID == 392270 then
    return true
  end
  return false
end

function BetterFishing:IsFishingpoleEquipped()
  local itemID = GetInventoryItemID("player", INVSLOT_MAINHAND)
  if itemID then
    local subclassID = select(7, C_Item.GetItemInfoInstant(itemID))
    if subclassID and subclassID == Enum.ItemWeaponSubclass.Fishingpole then
      return true
    end
  end
  return false
end

function BetterFishing:AllowFishing()
  if not IsSpellKnown(self:GetFishingID())
  or (internal.isClassicEra and not self:IsFishingpoleEquipped())
  or IsPlayerMoving()
  or IsMounted()
  or BetterFishing:IsFlying()
  or IsFalling()
  or IsStealthed()
  or IsSwimming()
  or IsSubmerged()
  or UnitHasVehicleUI("player")
  or not HasFullControl() then
    return false
  end

  if not BetterFishingDB.overrideLunker and self:IsLunkerActive() then
    return false
  end

  if self:IsFishing() then
    return (BetterFishingDB.recastOnDoubleClick and not IsModifierKeyDown()) or (not BetterFishingDB.recastOnDoubleClick and IsModifierKeyDown())
  end

  return true
end

local InteractCVarTable = {
  "SoftTargetInteract",
  "SoftTargetInteractArc",
  "SoftTargetInteractRange",
  "SoftTargetIconGameObject",
  "SoftTargetIconInteract"
}

local InteractCVars = {}

do
  for _, cvar in ipairs(InteractCVarTable) do
    InteractCVars[string.lower(cvar)] = GetCVar(cvar)
  end
end

hooksecurefunc(C_CVar, "SetCVar", function(cvar, value)
	if internal.cvarsChanged then return end
  local cvar_lower = string.lower(cvar)
  if InteractCVars[cvar_lower] then
    InteractCVars[cvar_lower] = value
  end
end)

function BetterFishing:ResetCVars(logout)
  if not logout then
    internal.cvarsChanged = true
  end
  BetterFishing:EnhanceSounds(false)
  for cvar, value in pairs(InteractCVars) do
    SetCVar(cvar, value)
  end
  C_Timer.After(0.2, function() internal.cvarsChanged = false end)
end

function BetterFishing:SetCVars()
  internal.cvarsChanged = true
  BetterFishing:EnhanceSounds(true)
  SetCVar("SoftTargetInteract", 3);
  SetCVar("SoftTargetInteractArc", 2);
  SetCVar("SoftTargetInteractRange", 60);
  SetCVar("SoftTargetIconGameObject", BetterFishingDB.objectIconDisabled and 0 or 1);
  SetCVar("SoftTargetIconInteract", BetterFishingDB.objectIconDisabled and 0 or 1);
  C_Timer.After(0.2, function() internal.cvarsChanged = false end)
end

function BetterFishing:ClearBindings()
  if not IsTaintable() then
    BetterFishing:ResetCVars()
    ClearOverrideBindings(BetterFishing:GetSecureButton());
  else
    internal.clear_override = true;
  end
end

function BetterFishing:OnEvent(event, ...)
  if event == "ADDON_LOADED" and addonName == ... then
    BetterFishingDB = BetterFishingDB or {};
  elseif event == "PLAYER_REGEN_ENABLED" then
    if internal.clear_override then
      ClearOverrideBindings(BetterFishing:GetSecureButton())
      internal.clear_override = false
      BetterFishing:ResetCVars()
    end
  elseif event == "GLOBAL_MOUSE_DOWN" then
    if not BetterFishingDB.doubleClickEnabled then return end
    if ... == "RightButton" and not IsMouseButtonDown("LeftButton")  and not IsTaintable() then
      if GetNumLootItems() == 0 then
        local doubleClickTime = GetTime() - internal.previousClickTime
        if (doubleClickTime >= internal.DOUBLECLICK_MIN_SECONDS and doubleClickTime <= BetterFishingDB.doubleClickSpeed) then
          if BetterFishing:AllowFishing() then

            SetOverrideBindingClick(BetterFishing:GetSecureButton(), true, "BUTTON2", addonName.."Button")
          elseif BetterFishing:IsFishing() then
            internal.isInteractBinding = true
            SetOverrideBinding(BetterFishing:GetSecureButton(), true, "BUTTON2", "INTERACTTARGET")
          end
          internal.previousClickTime = nil
        end
      end
      internal.previousClickTime = GetTime()
    end
  elseif event == "GLOBAL_MOUSE_UP" then
    if internal.isInteractBinding and ... == "RightButton" and not IsMouseButtonDown("LeftButton") and not IsTaintable() then
      internal.isInteractBinding = false
      ClearOverrideBindings(BetterFishing:GetSecureButton())
    end
  elseif event == "UNIT_SPELLCAST_CHANNEL_START" then
    local unit,_,spellID = ...
    if unit == "player" and (FishingIDs[spellID]) then
      BetterFishing:SetCVars()
      if IsTaintable() then return end
      local key1, key2 = GetBindingKey("BETTERFISHINGKEY")
      if key1 then
        SetOverrideBinding(BetterFishing:GetSecureButton(), true, key1, "INTERACTTARGET")
      end
      if key2 then
        SetOverrideBinding(BetterFishing:GetSecureButton(), true, key2, "INTERACTTARGET")
      end
    end
  elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
    local unit,_,spellID = ...
    if unit == "player" and (FishingIDs[spellID]) then
      if not IsTaintable() then
        BetterFishing:ResetCVars()
        ClearOverrideBindings(BetterFishing:GetSecureButton());
      else
        internal.clear_override = true;
      end
    end
  elseif event == "PLAYER_LOGOUT" then
    BetterFishing:ResetCVars(true)
  elseif event == "CVAR_UPDATE" then
    if self:IsFishing() then return end
    for i = 1, #CVarCacheSounds do
      if CVarCacheSounds[i] == ... then
        soundCache[CVarCacheSounds[i]] = GetCVar(...);
      end
    end
  end
end

internal._frame:SetScript("OnEvent", function(self, ...) BetterFishing:OnEvent(...) end)
FrameUtil.RegisterFrameForEvents(internal._frame, {
  "ADDON_LOADED",
  "PLAYER_REGEN_ENABLED",
  "CVAR_UPDATE",
  "PLAYER_LOGOUT",
  "GLOBAL_MOUSE_DOWN",
  "GLOBAL_MOUSE_UP"
})
internal._frame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
internal._frame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")

function BetterFishing:EnhanceSounds(enable)
  if not BetterFishingDB.enhanceSounds then return end

  if not enable then
    for i = 1, #CVarCacheSounds do
      if soundCache[CVarCacheSounds[i]] then
        SetCVar(CVarCacheSounds[i], soundCache[CVarCacheSounds[i]])
      end
    end
  else
    for i = 1, #CVarCacheSounds do
      soundCache[CVarCacheSounds[i]] = GetCVar(CVarCacheSounds[i])
      SetCVar(CVarCacheSounds[i], 0)
    end
    SetCVar("Sound_EnableAmbience", 0)
    SetCVar("Sound_MusicVolume", 0)
    SetCVar("Sound_EnablePetSounds", 0)

    SetCVar("Sound_EnableSFX", 1)
    SetCVar("Sound_EnableSoundWhenGameIsInBG", 1)
    SetCVar("Sound_EnableAllSound", 1)
    BetterFishingDB.enhanceSoundsScale = BetterFishingDB.enhanceSoundsScale or 1
    SetCVar("Sound_SFXVolume", BetterFishingDB.enhanceSoundsScale)
    SetCVar("Sound_MasterVolume", BetterFishingDB.enhanceSoundsScale)
  end
end
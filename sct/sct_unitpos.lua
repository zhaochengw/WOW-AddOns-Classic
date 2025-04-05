SCT.UnitPlates = {};

local UnitGUID = UnitGUID

----------------------
--Add Nameplate to table list
function SCT:NAME_PLATE_UNIT_ADDED(event, ...)
  local unit = ...
  local guid = UnitGUID(unit);
  local nameplate = C_NamePlate.GetNamePlateForUnit(unit);
  if not SCT.UnitPlates[guid] then
    SCT.UnitPlates[guid] = nameplate;
  end
end

----------------------
--Remove Nameplate from table list
function SCT:NAME_PLATE_UNIT_REMOVED(event, ...)
  local unit = ...
  local guid = UnitGUID(unit);
  SCT.UnitPlates[guid] = nil
end

----------------------
--Get namplate if there is one
function SCT:GetNameplate(guid)
  local parent
  if self.UnitPlates[guid] then
    parent = self.UnitPlates[guid];
  end
  return parent;
end

----------------------
--Start Nameplate tracking
function SCT:EnableNameplate()
  SetCVar("nameplateShowFriends", "1")
  self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
  self:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
end

----------------------
--Start Nameplate tracking
function SCT:DisableNameplate()
  SetCVar("nameplateShowFriends", "0")
  self:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
  self:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
end

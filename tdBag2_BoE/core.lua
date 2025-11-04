local addonName, addon = ...
local L = addon.L

if not tdBag2 then
  return
end

if not tdBag2.RegisterPlugin then
  return print(L['You must update tdBag2 to use BoE'])
end

local _G = _G
local UIParent = UIParent
local BankButtonIDToInvSlotID = BankButtonIDToInvSlotID
local GetContainerItemInfo = function(bag, slot)
  if C_Container.GetContainerItemInfo then
    local info = C_Container.GetContainerItemInfo(bag, slot)
    if info then
      return info.iconFileID, info.stackCount, info.isLocked, info.quality, info.isReadable, info.hasLoot, info.hyperlink, info.isFiltered, info.hasNoValue, info.itemID, info.isBound
    end
  else
    return _G.GetContainerItemInfo(bag,slot)
  end
end
local Item = _G.Item
local armor_tokens = {
  [22349]=true,[22350]=true,[22351]=true,[22352]=true,[22353]=true,[22354]=true,[22355]=true,[22356]=true,[22357]=true,
  [22358]=true,[22359]=true,[22360]=true,[22361]=true,[22362]=true,[22363]=true,[22364]=true,[22365]=true,[22366]=true,
  [22367]=true,[22368]=true,[22369]=true,[22370]=true,[22371]=true,[22372]=true,[29753]=true,[29754]=true,[29755]=true,
  [29756]=true,[29757]=true,[29758]=true,[29759]=true,[29760]=true,[29761]=true,[29762]=true,[29763]=true,[29764]=true,
  [29765]=true,[29766]=true,[29767]=true,[30236]=true,[30237]=true,[30238]=true,[30239]=true,[30240]=true,[30241]=true,
  [30242]=true,[30243]=true,[30244]=true,[30245]=true,[30246]=true,[30247]=true,[30248]=true,[30249]=true,[30250]=true,
  [31089]=true,[31090]=true,[31091]=true,[31092]=true,[31093]=true,[31094]=true,[31095]=true,[31096]=true,[31097]=true,
  [31098]=true,[31099]=true,[31100]=true,[31101]=true,[31102]=true,[31103]=true,[34848]=true,[34851]=true,[34852]=true,
  [34853]=true,[34854]=true,[34855]=true,[34856]=true,[34857]=true,[34858]=true,[40610]=true,[40611]=true,[40612]=true,
  [40613]=true,[40614]=true,[40615]=true,[40616]=true,[40617]=true,[40618]=true,[40619]=true,[40620]=true,[40621]=true,
  [40622]=true,[40623]=true,[40624]=true,[40625]=true,[40626]=true,[40627]=true,[40628]=true,[40629]=true,[40630]=true,
  [40631]=true,[40632]=true,[40633]=true,[40634]=true,[40635]=true,[40636]=true,[40637]=true,[40638]=true,[40639]=true,
  [45632]=true,[45633]=true,[45634]=true,[45635]=true,[45636]=true,[45637]=true,[45638]=true,[45639]=true,[45640]=true,
  [45641]=true,[45642]=true,[45643]=true,[45644]=true,[45645]=true,[45646]=true,[45647]=true,[45648]=true,[45649]=true,
  [45650]=true,[45651]=true,[45652]=true,[45653]=true,[45654]=true,[45655]=true,[45656]=true,[45657]=true,[45658]=true,
  [45659]=true,[45660]=true,[45661]=true,[47242]=true,[47557]=true,[47558]=true,[47559]=true,[52025]=true,[52026]=true,
  [52027]=true,[52028]=true,[52029]=true,[52030]=true,[32385]=true,[32386]=true,[32405]=true,[44569]=true,[44577]=true,
  [46052]=true,[46053]=true,[18422]=true,[18423]=true,[49644]=true,[49643]=true,[19003]=true,[19002]=true,[21221]=true,
}
-- You may trade this item with players that were also eligible to loot this item for the next %s.
-- You may sell this item to a vendor within %s for a full refund.
local BIND_TRADE_TIME_REMAINING_CAPTURE = _G.BIND_TRADE_TIME_REMAINING:gsub('%%s', '(.+)')
local REFUND_TIME_REMAINING_CAPTURE = _G.REFUND_TIME_REMAINING:gsub('%%s', '(.+)')
local UNCOMMON = _G.LE_ITEM_QUALITY_UNCOMMON
local UPDATE = _G.TOOLTIP_UPDATE_TIME
local BANK_CONTAINER = _G.BANK_CONTAINER
local ITEM_SOULBOUND_S = _G.ITEM_SOULBOUND
local ITEM_ACCOUNTBOUND_S = _G.ITEM_ACCOUNTBOUND
local ITEM_BNETACCOUNTBOUND_S = _G.ITEM_BNETACCOUNTBOUND

local BindScanner = CreateFrame('GameTooltip', 'tdBag2BoEScaner', nil, 'GameTooltipTemplate')
BindScanner:SetOwner(WorldFrame, 'ANCHOR_NONE')
local TimeScanner = CreateFrame('GameTooltip', 'tdBag2BoEScanner2', nil, 'GameTooltipTemplate')
TimeScanner:SetOwner(WorldFrame, 'ANCHOR_NONE')

local function fmtDuration(s)
  if not type(s)=="string" and #s > 0 then
    return
  end
  s = s:gsub('%s','')
  local amount, denomination = s:match('^(%d+)([^%d]*)')
  if not amount and denomination then return s end
  local b = strbyte(denomination,1)
  if b > 0 and b <= 127 then
    return string.format("%d%s"..L["+"],amount,denomination:sub(1,1))
  elseif b >= 194 then
    return string.format("%d%s"..L["+"],amount,denomination)
  end
  return s
end

local function GetBindTimer(item)
  local bag, slot = item.bag, item.slot
  if bag == BANK_CONTAINER then
    TimeScanner:SetInventoryItem('player', BankButtonIDToInvSlotID(slot))
  else
    TimeScanner:SetBagItem(bag, slot)
  end

  for i = 2, TimeScanner:NumLines() do
    local line = _G['tdBag2BoEScanner2TextLeft' .. i]
    if not line then break end
    local textLeft = line:GetText()
    if not textLeft then break end
    local timeleft = textLeft:match(BIND_TRADE_TIME_REMAINING_CAPTURE)

    if timeleft then
      return fmtDuration(timeleft)
    end
  end
end

local function GetRefundTimer(item)
  local bag, slot = item.bag, item.slot
  if bag == BANK_CONTAINER then
    TimeScanner:SetInventoryItem('player', BankButtonIDToInvSlotID(slot))
  else
    TimeScanner:SetBagItem(bag, slot)
  end

  for i = 2, TimeScanner:NumLines() do
    local line = _G['tdBag2BoEScanner2TextLeft' .. i]
    if not line then break end
    local textLeft = line:GetText()
    if not textLeft then break end
    local timeleft = textLeft:match(REFUND_TIME_REMAINING_CAPTURE)

    if timeleft then
      return fmtDuration(timeleft)
    end
  end
end

local function GetBindInfo(item)
  local bag, slot = item.bag, item.slot
  if bag == BANK_CONTAINER then
    BindScanner:SetInventoryItem('player', BankButtonIDToInvSlotID(slot))
  else
    BindScanner:SetBagItem(bag, slot)
  end

  for i = 2, 6 do
    local line = _G['tdBag2BoEScanerTextLeft' .. i]
    if not line then break end
    local textLeft = line:GetText()
    if not textLeft then break end
    if textLeft:find(ITEM_ACCOUNTBOUND_S) or textLeft:find(ITEM_BNETACCOUNTBOUND_S) then
      return true
    end
    if textLeft:find(ITEM_SOULBOUND_S) then
      local timeleft = GetBindTimer(item)
      if timeleft then
        return false, timeleft
      else
        return true
      end
    end
  end
  return false
end

local timers = {}
local function BindTicker(item)
  timers[item] = true
  if not addon._ticker then
    addon._ticker = C_Timer.NewTicker(10, function()
      for item,v in pairs(timers) do
        local timeleft = GetBindTimer(item)
        if timeleft then
          item.Count:SetText(timeleft)
        else
          item.Count:SetText('')
          item.BindInfo:SetText('')
          timers[item] = nil
        end
      end
    end)
  end
end

local function UpdateItem(item)
  if item.meta:IsCached() then
    return
  end

  if item.BindInfo then
    item.BindInfo:Hide()
  end

  if timers[item] then
    timers[item]=nil
  end

  local _, _, _, quality, _, _, itemLink, _, _, itemID = GetContainerItemInfo(item.bag, item.slot)
  if not itemID then return end
  if not quality or (quality < UNCOMMON) then return end
  local _, _, _, itemEquipLoc, _, _, _ = GetItemInfoInstant(itemID)
  if (itemEquipLoc == nil) or (itemEquipLoc == "") and not armor_tokens[itemID] then return end
  if not item.BindInfo then
    item.BindInfo = item:CreateFontString()
    item.BindInfo:SetDrawLayer("ARTWORK",1)
    item.BindInfo:SetPoint("TOP",0,-2)
    item.BindInfo:SetFontObject(Game13FontShadow or NumberFontNormal)
    item.BindInfo:SetTextColor(1,1,204/255,1)
    item.BindInfo:SetShadowOffset(2,-2)
    item.BindInfo:SetShadowColor(0,0,0,.8)
  end
  C_Timer.After(UPDATE, function()
    local isBound, timeleft = GetBindInfo(item)
    if isBound and not timeleft then return end

    item.BindInfo:SetText((timeleft and L["BoU"] or L["BoE"]))
    if timeleft and item.Count then
      item.Count:SetText(timeleft)
      if not item.Count:IsVisible() then
        item.Count:Show()
      end
      BindTicker(item)
    end
    item.BindInfo:Show()
  end)
end

tdBag2:RegisterPlugin({type = 'Item', update = UpdateItem})
_G[addonName] = addon

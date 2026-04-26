local addonName = ...; ---@type string addonName
local ns = select(2, ...); ---@class (partial) AutoLoot namespace

local LootDisplay = {};
local internal = {
  _frame = CreateFrame("frame", nil, UIParent),
  ICON_SIZE = 32,
  MESSAGE_HEIGHT = 32,
  MIN_WIDTH = 200,
  ITEM_LIFESPAN = 3,
  BUTTON_SPACING = 4,
  MAX_SLOTS = 15,
  BURST_THRESHOLD = 0.05,
  isMovable = false,
  lastMoney = 0,
  lastPostTime = 0.0,
  playerGUID = UnitGUID("player"),
  currentLoots = {},
  activeMessages = {},
  frameReserve = {},
  lastNumLoot = 0,
  poolHead = {},
  activeCount = 0,
  eventTimer = nil,
}

local LootAnchor = CreateFrame("Frame", "SpeedyAutoLoot_LootDisplayAnchor", UIParent)
LootAnchor:SetSize(internal.MIN_WIDTH, 20)
LootAnchor:SetPoint("CENTER")
LootAnchor:SetMovable(true)
LootAnchor:RegisterForDrag("LeftButton")
LootAnchor:SetClampedToScreen(true)
LootAnchor:SetUserPlaced(false)

local LootScrollFrame = CreateFrame("Frame", nil, UIParent)
LootScrollFrame:SetPoint("TOPLEFT", LootAnchor, "TOPLEFT", 0, -20)
LootScrollFrame:SetPoint("TOPRIGHT", LootAnchor, "TOPRIGHT", 0, -20)
LootScrollFrame:SetSize(internal.MIN_WIDTH, 1)
LootScrollFrame:SetFrameStrata("MEDIUM")
LootScrollFrame:SetFrameLevel(10)
LootScrollFrame:EnableMouse(false)

local abg = LootAnchor:CreateTexture(nil, "BACKGROUND")
abg:SetAllPoints()
abg:SetColorTexture(0, 0.8, 1, 0.4)
LootAnchor.text = LootAnchor:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
LootAnchor.text:SetPoint("CENTER")
LootAnchor.text:SetText("Loot Display")
LootAnchor:Hide()

LootAnchor:SetScript("OnDragStart", LootAnchor.StartMoving)
LootAnchor:SetScript("OnDragStop", function(self)
  self:StopMovingOrSizing()
  local point, _, _, x, y = self:GetPoint()
  if SpeedyAutoLootDB and SpeedyAutoLootDB["global"] then
    SpeedyAutoLootDB["global"].uiPoint = { point = point, x = x, y = y }
  end
end)

local function ResetLootFrame(frame)
  frame:Hide()
  frame:SetAlpha(0)
  frame.itemName = nil
  frame.itemLink = nil
  frame.count = 0
  frame.startTime = 0
  frame.updateTime = 0
  frame.flashTime = 0
  frame.readyToRelease = false
  frame.isPermanent = false
  frame.inUse = false
  frame.skipAnimation = false
  if frame.Flash then
    frame.Flash:SetAlpha(0)
    frame.Flash:SetVertexColor(1, 1, 1)
  end
  frame:ClearAllPoints()
end

local function GetAvailableFrame()
  for i = 1, internal.MAX_SLOTS do
    if not internal.frameReserve[i].inUse then
      internal.frameReserve[i].inUse = true
      return internal.frameReserve[i]
    end
  end
  return nil
end

local function ToggleTrackingEvents(enable)
  if enable then
    internal._frame:RegisterEvent("CHAT_MSG_LOOT")
    internal._frame:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
    internal._frame:RegisterEvent("PLAYER_MONEY")
  else
    internal._frame:UnregisterEvent("CHAT_MSG_LOOT")
    internal._frame:UnregisterEvent("CURRENCY_DISPLAY_UPDATE")
    internal._frame:UnregisterEvent("PLAYER_MONEY")
  end
end

function LootDisplay:UpdateAnimations(elapsed)
  local now = GetTime()
  local count = #internal.activeMessages

  if count == 0 and not internal.isMovable then
    LootScrollFrame:SetAlpha(0)
    LootScrollFrame:SetScript("OnUpdate", nil)
    return
  end

  for i, frame in ipairs(internal.activeMessages) do
    local targetY = -( (i - 1) * (internal.MESSAGE_HEIGHT + internal.BUTTON_SPACING) )
    local _, _, _, _, currentY = frame:GetPoint()
    currentY = currentY or targetY

    local newY = currentY + (targetY - currentY) * 0.15

    if frame.flashTime > 0 then
      local flashAge = now - frame.flashTime
      if flashAge < 1 then
        frame.Flash:SetAlpha(1 - (flashAge))
      else
        frame.Flash:SetAlpha(0)
        frame.flashTime = 0
      end
    end

    local remaining = frame.expiration - now
    if remaining < 1.0 and not frame.isPermanent then
      if internal.isHovering then
        frame.expiration = now + internal.ITEM_LIFESPAN
        frame:SetAlpha(1)
      else
        frame:SetAlpha(math.max(0, remaining))
      end
    else
      if frame.skipAnimation then
        frame:SetScale(1)
        frame:SetAlpha(1)
        frame:SetPoint("TOPLEFT", LootScrollFrame, "TOPLEFT", 0, newY)
      else
        frame:SetScale(1)
        local slideIn = math.min(1, (now - frame.startTime) / 0.2)
        frame:SetAlpha(slideIn)
        frame:SetPoint("TOPLEFT", LootScrollFrame, "TOPLEFT", -20 + (20 * slideIn), newY)
      end
    end

    if remaining <= 0 and not frame.isPermanent then
      frame.readyToRelease = true
    end
    frame:Show()
  end

  for i = count, 1, -1 do
    if internal.activeMessages[i].readyToRelease then
      local f = table.remove(internal.activeMessages, i)
      ResetLootFrame(f)
    end
  end

  LootScrollFrame:SetAlpha(1)
  LootScrollFrame:SetHeight(math.max(20, #internal.activeMessages * (internal.MESSAGE_HEIGHT + internal.BUTTON_SPACING)))
end

function ns:ToggleLootDisplay(forceState)
  internal.isMovable = (forceState ~= nil) and forceState or not internal.isMovable
  if internal.isMovable then
    LootAnchor:Show()
    LootAnchor:EnableMouse(true)
    if not LootScrollFrame:GetScript("OnUpdate") then
      LootScrollFrame:SetScript("OnUpdate", function(s, e) LootDisplay:UpdateAnimations(e) end)
    end
    LootDisplay:PostLoot("Epic Test", 132331, 4, 1, false, nil, true)
    LootDisplay:PostLoot("Common Test", 134400, 1, 5, false, nil,  true)
    LootDisplay:PostLoot("Gold", 133784, 1, 12345, true, nil, true)
  else
    LootAnchor:Hide()
    LootAnchor:EnableMouse(false)
    for i = #internal.activeMessages, 1, -1 do
      if internal.activeMessages[i].isPermanent then
        local f = table.remove(internal.activeMessages, i)
        ResetLootFrame(f)
      end
    end
  end
end

local function InitializeFrames()
  for i = 1, internal.MAX_SLOTS do
    local f = CreateFrame("Button", nil, LootScrollFrame)
    f:SetSize(internal.MIN_WIDTH, internal.MESSAGE_HEIGHT)
    f:SetPropagateMouseClicks(true)

    f.Icon = f:CreateTexture(nil, "ARTWORK")
    f.Icon:SetSize(internal.ICON_SIZE, internal.ICON_SIZE)
    f.Icon:SetPoint("LEFT", 0, 0)
    f.Icon:SetCollapsesLayout(true)

    f.Text = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.Text:SetPoint("LEFT", f.Icon, "RIGHT", 10, 0)

    f.bg = f:CreateTexture(nil, "BACKGROUND")
    f.bg:SetAllPoints()
    f.bg:SetColorTexture(0, 0, 0)
    f.bg:SetGradient("HORIZONTAL", CreateColor(0,0,0,0.8), CreateColor(0,0,0,0))

    f.Flash = f:CreateTexture(nil, "OVERLAY", nil, 1)
    f.Flash:SetAllPoints()
    f.Flash:SetColorTexture(1, 1, 1, 0.5)
    f.Flash:SetAlpha(0)

    f.IconBorder = f:CreateTexture(nil, "OVERLAY")
    f.IconBorder:SetAllPoints(f.Icon)
    f.IconBorder:SetTextureSliceMargins(6, 6, 6, 6)
    f.IconBorder:SetTextureSliceMode(Enum.UITextureSliceMode.Stretched)
    f.IconBorder:SetTexture("Interface\\AddOns\\SpeedyAutoLoot\\Art\\LootIconBorder.tga")

    f.IconQuestTexture = f:CreateTexture(nil, "OVERLAY")
    f.IconQuestTexture:SetAllPoints(f.Icon)
    f.IconQuestTexture:SetTexture("Interface\\AddOns\\SpeedyAutoLoot\\Art\\LootQuestIcon.tga")
    f.IconQuestTexture:Hide()

    f:SetScript("OnEnter", function(self)
      if self.itemLink then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink(self.itemLink)
        GameTooltip:Show()
        internal.isHovering = true
      end
    end)

    f:SetScript("OnLeave", function()
      GameTooltip:Hide()
      internal.isHovering = false
    end)

    ResetLootFrame(f)
    internal.frameReserve[i] = f
  end
end

internal._frame:RegisterEvent("PLAYER_LOGIN")
internal._frame:RegisterEvent("ADDON_LOADED")
internal._frame:RegisterEvent("LOOT_READY")
internal._frame:RegisterEvent("LOOT_CLOSED")

local function AcquireData()
  local object = internal.poolHead
  if object then
    internal.poolHead = object.next
    object.next = nil
  else
    object = {
      name = "", texture = 0, quality = 0, quantity = 0,
      locked = false, isQuestItem = false, questID = nil,
      questActive = false, link = nil, next = nil
    }
  end
  return object
end

local function ReleaseData(object)
  object.name, object.texture, object.quality, object.quantity = "", 0, 0, 0
  object.locked, object.isQuestItem, object.questID, object.questActive = false, false, nil, false
  object.link = nil
  object.next = internal.poolHead
  internal.poolHead = object
end

internal._frame:SetScript("OnEvent", function(self, event, ...)
  if event == "ADDON_LOADED" then
    local loadedName = ...
    if loadedName ~= addonName then return end
    if SpeedyAutoLootDB and SpeedyAutoLootDB["global"] then
      SpeedyAutoLootDB["global"].uiPoint = SpeedyAutoLootDB["global"].uiPoint or { point = "CENTER", x = 400, y = 260 }
      local pos = SpeedyAutoLootDB["global"].uiPoint
      LootAnchor:ClearAllPoints()
      LootAnchor:SetPoint(pos.point, UIParent, pos.point, pos.x, pos.y)
    end
    return
  end

  if event == "PLAYER_LOGIN" then
    internal.playerGUID = UnitGUID("player")
    InitializeFrames()
    return
  end

  if not SpeedyAutoLootDB.global.lootDisplayEnabled then return end
  if C_ChatInfo and C_ChatInfo.InChatMessagingLockdown and C_ChatInfo.InChatMessagingLockdown() then return end

  if event == "LOOT_READY" then
    local numItems = GetNumLootItems()
    if numItems == 0 or internal.lastNumLoot == numItems then return end

    if internal.eventTimer then
      internal.eventTimer:Cancel()
    end

    ToggleTrackingEvents(true)
    internal.lastMoney = GetMoney()

    for _, data in pairs(internal.currentLoots) do ReleaseData(data) end
    table.wipe(internal.currentLoots)

    for i = 1, numItems do
      local texture, name, quantity, currencyID, quality, locked, isQuestItem, questID, questActive, isCoin = GetLootSlotInfo(i)
      local lootID
      local lootLink = GetLootSlotLink(i)

      if isCoin then
        lootID = -1
      elseif currencyID then
        lootID = currencyID
        name, texture, quantity, quality = CurrencyContainerUtil.GetCurrencyContainerInfo(lootID, quantity, name, texture, quality)
      else
        lootID = lootLink and C_Item.GetItemInfoInstant(lootLink)
      end

      if lootID and not internal.currentLoots[lootID] then
        local data = AcquireData()
        data.name, data.texture, data.quality, data.quantity = name, texture, quality or 1, quantity
        data.locked, data.isQuestItem, data.questID, data.questActive = locked, isQuestItem, questID, questActive
        data.link = lootLink

        internal.currentLoots[lootID] = data
      end
    end

    internal.lastNumLoot = numItems
  elseif event == "CHAT_MSG_LOOT" or event == "CURRENCY_DISPLAY_UPDATE" then
    local lootID, count, chatLink

    if event == "CHAT_MSG_LOOT" then
      local message = ...
      chatLink = message:match("(|c.-|h|r)")
      lootID = chatLink and C_Item.GetItemInfoInstant(chatLink)
    elseif event == "CURRENCY_DISPLAY_UPDATE" then
      lootID, _, count = ...
    end

    local cachedData = lootID and internal.currentLoots[lootID]
    if cachedData then
      LootDisplay:PostLoot(
        cachedData.name,
        cachedData.texture,
        cachedData.quality,
        count or cachedData.quantity,
        false,
        chatLink or cachedData.link,
        false,
        cachedData.isQuestItem,
        cachedData.questID,
        cachedData.questActive
      )
    end

  elseif event == "PLAYER_MONEY" then
    local cur = GetMoney()
    local diff = cur - (internal.lastMoney or cur)
    internal.lastMoney = cur

    if diff > 0 then
      LootDisplay:PostLoot(nil, nil, 1, diff, true, nil, false, false, nil, false)
    end

  elseif event == "LOOT_CLOSED" then
    internal.lastNumLoot = 0
    if internal.eventTimer then internal.eventTimer:Cancel() end
    internal.eventTimer = C_Timer.NewTimer(2, function()
      ToggleTrackingEvents(false)
    end, 1)
  end
end)

function LootDisplay:PostLoot(name, icon, quality, count, isCoin, itemLink, isTest, isQuestItem, questID, questActive)
  count = (not count or count < 1) and 1 or count
  local lookupName = isCoin and "COMBINED_GOLD" or name
  local now = GetTime()

  local skipAnim = (now - internal.lastPostTime) < internal.BURST_THRESHOLD
  internal.lastPostTime = now

  if not LootScrollFrame:GetScript("OnUpdate") then
    LootScrollFrame:SetScript("OnUpdate", function(s, e) self:UpdateAnimations(e) end)
  end

  for _, frame in ipairs(internal.activeMessages) do
    if not frame.isPermanent then
      frame.expiration = now + internal.ITEM_LIFESPAN
    end
  end

  for _, frame in ipairs(internal.activeMessages) do
    if frame.itemName == lookupName then
      frame.count = frame.count + count
      frame.updateTime = now
      local r, g, b, hex = C_Item.GetItemQualityColor(frame.quality or 1)
      frame.Text:SetText(isCoin and string.format("   |c%s%s|r", hex, C_CurrencyInfo.GetCoinTextureString(frame.count)) or string.format("|cffffffff+%d|r |c%s%s|r", frame.count, hex, name))
      if frame.quality >= 4 then
        frame.flashTime = now
        frame.Flash:SetVertexColor(r, g, b)
        frame.Flash:SetAlpha(1)
      end
      return
    end
  end

  local f = GetAvailableFrame()
  if not f then return end

  f.itemName, f.count, f.quality, f.startTime, f.updateTime = lookupName, count, quality or 1, now, 0
  f.expiration = now + internal.ITEM_LIFESPAN
  f.itemLink = itemLink
  f.isPermanent = isTest
  f.skipAnimation = skipAnim

  local r, g, b, hex = C_Item.GetItemQualityColor(f.quality)

  if f.quality >= 4 then
    f.flashTime = now
    f.Flash:SetVertexColor(r, g, b)
    f.Flash:SetAlpha(1)
  else
    f.flashTime = 0
    f.Flash:SetAlpha(0)
  end

  if questID or isQuestItem then
    f.IconQuestTexture:Show()
  else
    f.IconQuestTexture:Hide()
  end

  if isCoin then
    f.IconBorder:Hide()
    f.Icon:Hide()
  else
    f.IconBorder:Show()
    f.Icon:Show()
    f.Icon:SetTexture(icon or 133784)
    f.Icon:SetTexCoord(0.0625, 0.9375, 0.0625, 0.9375)
    f.IconBorder:SetVertexColor(r, g, b, 1)
  end

  f.Text:SetText(isCoin and string.format("   |c%s%s|r", hex, C_CurrencyInfo.GetCoinTextureString(count)) or string.format("|cffffffff+%d|r |c%s%s|r", count, hex, name))
  table.insert(internal.activeMessages, f)
end
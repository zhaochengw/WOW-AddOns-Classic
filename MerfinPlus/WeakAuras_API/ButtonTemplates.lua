Merfin = Merfin or {}
local expansion = math.floor(select(4, GetBuildInfo()) / 10000)

local UnitAffectingCombat = UnitAffectingCombat
local GetSpellInfo = GetSpellInfo

local SetItemTooltip = function(button, tooltipContextId)
  aura_env.button:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
    GameTooltip:ClearLines()
    GameTooltip:SetItemByID(tooltipContextId)
    GameTooltip:Show()
  end)
  aura_env.button:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end)
end

-- Clickable Reminder
Merfin.SetButtonTemplate = function(aura_env, buttonName, type, context, context2)
  if WeakAuras.IsOptionsOpen() then
    return
  end
  if UnitAffectingCombat("player") then
    return
  end

  if not aura_env.button then
    local r = WeakAuras.GetRegion(aura_env.id)
    aura_env.button = CreateFrame("Button", buttonName, r, "SecureActionButtonTemplate")
  end

  aura_env.button:SetAllPoints()
  if expansion == 2 then
    aura_env.button:RegisterForClicks("AnyUp", "AnyDown") -- TBC is special
  else
    aura_env.button:RegisterForClicks("AnyUp")
  end
  aura_env.button:SetAttribute("type", type)
  if type == "macro" then
    aura_env.button:SetAttribute("macrotext1", context)
  elseif type == "item" then
    aura_env.button:SetAttribute("item", "item:" .. context)
  elseif type == "spell" then
    local spell = (context2 and select(1, GetSpellInfo(context))) or context
    aura_env.button:SetAttribute("spell", spell)
  end
end

-- Sets Tooltip
Merfin.SetButtonTooltipItem = function(aura_env, buttonName, itemId)
  if not aura_env.button then
    local r = WeakAuras.GetRegion(aura_env.id)
    aura_env.button = CreateFrame("Button", buttonName, r, "SecureActionButtonTemplate")
  end

  aura_env.button:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
    GameTooltip:ClearLines()
    GameTooltip:SetItemByID(itemId)
    GameTooltip:Show()
  end)

  aura_env.button:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end)
end

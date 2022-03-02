local ADDON_NAME, Addon = ...
local ThreatPlates = Addon.ThreatPlates

---------------------------------------------------------------------------------------------------
-- Imported functions and constants
---------------------------------------------------------------------------------------------------

-- Lua APIs

-- WoW APIs

-- ThreatPlates APIs
local ANCHOR_POINT_TEXT = Addon.ANCHOR_POINT_TEXT

local Font = {}
Addon.Font = Font

---------------------------------------------------------------------------------------------------
-- Element code
---------------------------------------------------------------------------------------------------

function Font:UpdateTextFont(font, db)
  font:SetFont(Addon.LibSharedMedia:Fetch('font', db.Typeface), db.Size, db.flags)

  if db.Shadow then
    font:SetShadowOffset(1, -1)
    font:SetShadowColor(0, 0, 0, 1)
  else
    font:SetShadowColor(0, 0, 0, 0)
  end

  if db.Color then
    font:SetTextColor(db.Color.r, db.Color.g, db.Color.b, db.Transparency or 1)
  end

  font:SetJustifyH(db.HorizontalAlignment or "CENTER")
  font:SetJustifyV(db.VerticalAlignment or "CENTER")

  -- Set text to nil to enforce text string update, otherwise updates to justification will not take effect
  local text = font:GetText()
  font:SetText(nil)
  font:SetText(text)
end

function Font:UpdateText(parent, font, db)
  self:UpdateTextFont(font, db.Font)

  local anchor = db.Anchor or "CENTER"

  font:ClearAllPoints()
  if db.InsideAnchor == false then
    local anchor_point_text = ANCHOR_POINT_TEXT[anchor]
    font:SetPoint(anchor_point_text[2], parent, anchor_point_text[1], db.HorizontalOffset or 0, db.VerticalOffset or 0)
  else -- db.InsideAnchor not defined in settings or true
    font:SetPoint(anchor, parent, anchor, db.HorizontalOffset or 0, db.VerticalOffset or 0)
  end
end

function Font:UpdateTextSize(parent, font, db)
  local width, height = parent:GetSize()
  if db.AutoSizing == nil or db.AutoSizing then
    font:SetSize(width, height)
    font:SetWordWrap(false)
  else
    font:SetSize(db.Width, font:GetLineHeight() * font:GetMaxLines())
    font:SetWordWrap(db.WordWrap)
    font:SetNonSpaceWrap(true)
  end
end
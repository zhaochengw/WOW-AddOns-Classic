
local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local LibItemInfo = LibStub:GetLibrary("LibItemInfo.7000")

--bliz func
--local IsCorruptedItem = IsCorruptedItem or function(link) return false end

local slots = {
    { index = 1, name = HEADSLOT, },
    { index = 2, name = NECKSLOT, },
    { index = 3, name = SHOULDERSLOT, },
    { index = 5, name = CHESTSLOT, },
    { index = 6, name = WAISTSLOT, },
    { index = 7, name = LEGSSLOT, },
    { index = 8, name = FEETSLOT, },
    { index = 9, name = WRISTSLOT, },
    { index = 10, name = HANDSSLOT, },
    { index = 11, name = FINGER0SLOT, },
    { index = 12, name = FINGER1SLOT, },
    { index = 13, name = TRINKET0SLOT, },
    { index = 14, name = TRINKET1SLOT, },
    { index = 15, name = BACKSLOT, },
    { index = 16, name = MAINHANDSLOT, },
    { index = 17, name = SECONDARYHANDSLOT, },
}

local function GetInspectItemListFrame(parent)
    if (not parent.inspectFrame) then
        local itemfont = "ChatFontNormal"
        local frame = CreateFrame("Frame", nil, parent, "BackdropTemplate")
        local height = parent:GetHeight()
        if (height < 424) then
            height = 424
        end
        frame.backdrop = {
            bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile     = true,
            tileSize = 8,
            edgeSize = 16,
            insets   = {left = 4, right = 4, top = 4, bottom = 4}
        }
        frame:SetSize(160, height)
        frame:SetFrameLevel(0)
        frame:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0, 0)
        frame:SetBackdrop(frame.backdrop)
        frame:SetBackdropColor(0, 0, 0, 0.8)
        frame:SetBackdropBorderColor(0.6, 0.6, 0.6)
        frame.portrait = CreateFrame("Frame", nil, frame)
        frame.portrait:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -16)
        frame.portrait:SetSize(42, 42)
        frame.portrait.icon = frame.portrait:CreateTexture(nil, "ARTWORK")
        frame.portrait.icon:SetAllPoints()
        frame.title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLargeOutline")
        frame.title:SetPoint("TOPLEFT", frame, "TOPLEFT", 66, -18)
        frame.level = frame:CreateFontString(nil, "ARTWORK", itemfont)
        frame.level:SetPoint("TOPLEFT", frame, "TOPLEFT", 66, -42)
        frame.level:SetFont(frame.level:GetFont(), 14, "THINOUTLINE")

        local itemframe
        local fontsize = GetLocale():sub(1,2) == "zh" and 12 or 9
        local backdrop = {
            bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            tile     = true,
            tileSize = 8,
            edgeSize = 1,
            insets   = {left = 1, right = 1, top = 1, bottom = 1}
        }
        for i, v in ipairs(slots) do
            itemframe = CreateFrame("Button", nil, frame, "BackdropTemplate")
            itemframe:SetSize(120, min((height-82)/#slots,28))
            itemframe.index = v.index
            itemframe.backdrop = backdrop
            if (i == 1) then
                itemframe:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -70)
            else
                itemframe:SetPoint("TOPLEFT", frame["item"..(i-1)], "BOTTOMLEFT")
            end
            itemframe.label = CreateFrame("Frame", nil, itemframe, "BackdropTemplate")
            itemframe.label:SetSize(38, 16)
            itemframe.label:SetPoint("LEFT")
            itemframe.label:SetBackdrop(backdrop)
            itemframe.label:SetBackdropBorderColor(0, 0.9, 0.9, 0.2)
            itemframe.label:SetBackdropColor(0, 0.9, 0.9, 0.2)
            itemframe.label.text = itemframe.label:CreateFontString(nil, "ARTWORK")
            itemframe.label.text:SetFont(UNIT_NAME_FONT, fontsize, "THINOUTLINE")
            itemframe.label.text:SetSize(34, 14)
            itemframe.label.text:SetPoint("CENTER", 1, 0)
            itemframe.label.text:SetText(v.name)
            itemframe.label.text:SetTextColor(0, 0.9, 0.9)
            itemframe.levelString = itemframe:CreateFontString(nil, "ARTWORK", itemfont)
            itemframe.levelString:SetPoint("LEFT", itemframe.label, "RIGHT", 4, 0)
            itemframe.levelString:SetJustifyH("RIGHT")
            itemframe.itemString = itemframe:CreateFontString(nil, "ARTWORK", itemfont)
            itemframe.itemString:SetHeight(16)
            itemframe.itemString:SetPoint("LEFT", itemframe.levelString, "RIGHT", 2, 0)
            itemframe:SetScript("OnEnter", function(self)
                local r, g, b, a = self.label:GetBackdropColor()
                if (a) then self.label:SetBackdropColor(r, g, b, a+0.5) end
                if (self.link or (self.level and self.level > 0)) then
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetInventoryItem(self:GetParent().unit, self.index)
                    GameTooltip:Show()
                end
            end)
            itemframe:SetScript("OnLeave", function(self)
                local r, g, b, a = self.label:GetBackdropColor()
                if (a) then self.label:SetBackdropColor(r, g, b, abs(a-0.5)) end
                GameTooltip:Hide()
            end)
            itemframe:SetScript("OnDoubleClick", function(self)
                if (self.link) then
                    ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
                    ChatEdit_InsertLink(self.link)
                end
            end)
            frame["item"..i] = itemframe
            LibEvent:trigger("INSPECT_ITEMFRAME_CREATED", itemframe)
        end
        
        frame.closeButton = CreateFrame("Button", nil, frame)
        frame.closeButton:SetSize(12, 12)
        frame.closeButton:SetScale(0.85)
        frame.closeButton:SetPoint("BOTTOMLEFT", 5, 6)
        frame.closeButton:SetNormalTexture("Interface\\Cursor\\Item")
        frame.closeButton:GetNormalTexture():SetTexCoord(0, 12/32, 12/32, 0)
        frame.closeButton:SetScript("OnClick", function(self)
            self:GetParent():Hide()
        end)

        parent:HookScript("OnHide", function(self) frame:Hide() end)
        parent.inspectFrame = frame
        LibEvent:trigger("INSPECT_FRAME_CREATED", frame, parent)
    end

    return parent.inspectFrame
end

local ItemLevelPattern = gsub(ITEM_LEVEL, "%%d", "%%.1f")  -- %%.2f

-- Count empty Sockets via Itemstats (for Belt)
local function TI_CountSockets(itemLink)
    local stats = (TI_GetItemStats or GetItemStats)(itemLink)
    local n = 0
    if stats then
        for k,v in pairs(stats) do
            if type(k) == "string" and k:find("EMPTY_SOCKET_") then
                n = n + (tonumber(v) or 0)
            end
        end
    end
    return n
end

-- Stats Adding

local stamina = 0
local strength = 0
local agility = 0
local int = 0
local hit = 0
local haste = 0
local crit = 0
local mastery = 0
local expertise = 0
local dodge = 0
local parry = 0
local armor = 0
--[[
local CLASS_PRIMARY_BONUS = {
  MAGE     = "INT", PRIEST   = "INT", WARLOCK  = "INT",
  WARRIOR  = "STR", DEATHKNIGHT = "STR", PALADIN  = "STR",
  HUNTER   = "AGI", ROGUE    = "AGI", SHAMAN   = "AGI",
  DRUID    = "AGI",
}

local RACIAL_BONUS = {
  Human   = { SPIRIT = 0.03 },
  Tauren  = { STA    = 0.05 },
  NightElf= { DODGE  = 0.02 },
  Dwarf   = { EXPERTISE_MACE = 0.01 },
  Orc     = { EXPERTISE_AXE  = 0.01 },
  Gnome   = { EXPERTISE_DAGGER=0.01 },
}

local function applyBonuses(totals, class, race)
  -- Class Boni
  local primary = CLASS_PRIMARY_BONUS[class]
  if primary and totals[primary] then
    totals[primary] = math.floor(totals[primary] * 1.05 + 0.5)
  end

  -- Racial Boni
  local rbonus = RACIAL_BONUS[race]
  if rbonus then
    for stat, bonus in pairs(rbonus) do
      if totals[stat] then
        totals[stat] = math.floor(totals[stat] * (1 + bonus) + 0.5)
      end
    end
  end

  return totals
end
]]--
-- Stats end

function ShowInspectItemListFrame(unit, parent, ilevel, maxLevel)
    if (not parent:IsShown()) then return end
    local frame = GetInspectItemListFrame(parent)
    local class = select(2, UnitClass(unit))
    local color = RAID_CLASS_COLORS[class] or NORMAL_FONT_COLOR
    frame.unit = unit
    -- portrait visuals (MoP Classic friendly)
    local _unitLevel = UnitLevel(unit)
    SetPortraitTexture(frame.portrait.icon, unit)
    -- quality coloring can be applied to frame borders elsewhere if desired

    frame.title:SetTextColor(color.r, color.g, color.b)
    frame.level:SetText(format(ItemLevelPattern, ilevel))
    frame.level:SetTextColor(1, 0.82, 0)
    local _, name, level, link, quality
    local itemframe, mframe, oframe, itemwidth
    local width = 160
    local formats = "%3s"
    if (maxLevel) then
        formats = "%" .. string.len(floor(maxLevel)) .. "s"
    end
    for i, v in ipairs(slots) do
        _, level, name, link, quality = LibItemInfo:GetUnitItemInfo(unit, v.index)
		--[[local stats = LibItemInfo:GetNormalizedItemStats(unit, v.index)
		if stats then
		  stamina   = stamina   + (stats.STA or 0)
		  strength  = strength  + (stats.STR or 0)
		  agility   = agility   + (stats.AGI or 0)
		  int       = int       + (stats.INT or 0)
		  hit       = hit       + (stats.HIT or 0)
		  crit      = crit      + (stats.CRIT or 0)
		  haste     = haste     + (stats.HASTE or 0)
		  mastery   = mastery   + (stats.MASTERY or 0)
		  expertise = expertise + (stats.EXPERTISE or 0)
		  dodge     = dodge     + (stats.DODGE or 0)
		  parry     = parry     + (stats.PARRY or 0)
		  armor     = armor     + (stats.ARMOR or 0)
		end]]--
        itemframe = frame["item"..i]
        itemframe.name = name
        itemframe.link = link
        itemframe.level = level
        itemframe.quality = quality
        itemframe.itemString:SetWidth(0)
        if (level > 0) then
            itemframe.levelString:SetText(format(formats,level))
            itemframe.itemString:SetText(link or name)
        else
            itemframe.levelString:SetText(format(formats,""))
            itemframe.itemString:SetText("")
        end
        --if (link and IsCorruptedItem(link)) then
        --    itemframe.levelString:SetTextColor(0.5, 0.5, 1)
        --else
        --    itemframe.levelString:SetTextColor(1, 1, 1)
        --end
		itemframe.levelString:SetTextColor(1, 1, 1)
        itemwidth = itemframe.itemString:GetWidth()
        if (itemwidth > 208) then
            itemwidth = 208
            itemframe.itemString:SetWidth(itemwidth)
        end
        itemframe.width = itemwidth + max(64, floor(itemframe.label:GetWidth() + itemframe.levelString:GetWidth()) + 4)
        itemframe:SetWidth(itemframe.width)
        if (width < itemframe.width) then
            width = itemframe.width
        end
        if (v.index == 16) then
            mframe = itemframe
            mframe:SetAlpha(1)
        elseif (v.index == 17) then
            oframe = itemframe
            oframe:SetAlpha(1)
        end
        LibEvent:trigger("INSPECT_ITEMFRAME_UPDATED", itemframe)
    end
    if (mframe and oframe and (mframe.quality == 6 or oframe.quality == 6)) then
        level = max(mframe.level, oframe.level)
        if mframe.link then
            mframe.levelString:SetText(format(formats,level))
        end
        if oframe.link then
            oframe.levelString:SetText(format(formats,level))
        end
    end
    if (mframe and mframe.level <= 0) then
        mframe:SetAlpha(0.4)
    end
    if (oframe and oframe.level <= 0) then
        oframe.link = nil
        oframe:SetAlpha(0.4)
    end
    frame:SetWidth(width + 36)
    frame:Show()

    LibEvent:trigger("INSPECT_FRAME_SHOWN", frame, parent, ilevel)
    frame:SetBackdrop(frame.backdrop)
    frame:SetBackdropColor(0, 0, 0, 0.9)
    frame:SetBackdropBorderColor(color.r, color.g, color.b)
	
	
	--local classLocalized, class = UnitClass(unit)
	--local raceLocalized,  race  = UnitRace(unit)
	--local level = UnitLevel(unit)

	-- Basestats OHNE applyBonuses
	--local base = BaseStats.GetBaseStats(class, race, level, { applyBonuses = false })

	-- Auf deine Variablen addieren
	--stamina   = stamina   + (base.STA or 0)
	--strength  = strength  + (base.STR or 0)
	--agility   = agility   + (base.AGI or 0)
	--int       = int       + (base.INT or 0)
		
    return frame
end

LibEvent:attachEvent("UNIT_INVENTORY_CHANGED", function(self, unit)
    if (InspectFrame and InspectFrame.unit and InspectFrame.unit == unit) then
        ReInspect(unit)
    end
end)

LibEvent:attachTrigger("UNIT_INSPECT_READY, UNIT_REINSPECT_READY", function(self, data)
    if (TinyInspectClassicDB and not TinyInspectClassicDB.ShowInspectItemSheet) then return end
    if (InspectFrame and InspectFrame.unit and UnitGUID(InspectFrame.unit) == data.guid) then
        local frame = ShowInspectItemListFrame(InspectFrame.unit, InspectFrame, data.ilevel, data.maxLevel)
        LibEvent:trigger("INSPECT_FRAME_COMPARE", frame)
    end
end)

LibEvent:attachTrigger("INSPECT_FRAME_SHOWN", function(self, frame, parent, ilevel)
    local backdrop = frame:GetBackdrop() or {
            bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile     = true,
            tileSize = 8,
            edgeSize = 16,
            insets   = {left = 4, right = 4, top = 4, bottom = 4}
          }
    if (TinyInspectClassicDB and TinyInspectClassicDB.ShowInspectAngularBorder) then
        backdrop.edgeSize = 1
        backdrop.edgeFile = "Interface\\Buttons\\WHITE8X8"
        backdrop.insets.top = 1
        backdrop.insets.left = 1
        backdrop.insets.right = 1
        backdrop.insets.bottom = 1
        frame.backdrop = backdrop
        frame:SetPoint("TOPLEFT", parent, "TOPRIGHT", 2, 0)
    else
        backdrop.edgeSize = 16
        backdrop.edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border"
        backdrop.insets.top = 4
        backdrop.insets.left = 4
        backdrop.insets.right = 4
        backdrop.insets.bottom = 4
        frame.backdrop = backdrop
        frame:SetPoint("TOPLEFT", parent, "TOPRIGHT", 0, 0)
    end
end)

LibEvent:attachTrigger("INSPECT_ITEMFRAME_UPDATED", function(self, itemframe)
    local r, g, b = 0, 0.9, 0.9
    if (TinyInspectClassicDB and TinyInspectClassicDB.ShowInspectColoredLabel) then
        if (itemframe.quality and itemframe.quality > 4) then
            r, g, b = GetItemQualityColor(itemframe.quality)
        elseif (itemframe.name and not itemframe.link) then
            r, g, b = 0.9, 0.8, 0.4
        elseif (not itemframe.link) then
            r, g, b = 0.5, 0.5, 0.5
        end
    end
    itemframe.label:SetBackdropBorderColor(r, g, b, 0.2)
    itemframe.label:SetBackdropColor(r, g, b, 0.2)
    itemframe.label.text:SetTextColor(r, g, b)
end)

LibEvent:attachTrigger("INSPECT_FRAME_COMPARE", function(self, frame)
    if (not frame) then return end
    if (TinyInspectClassicDB and TinyInspectClassicDB.ShowOwnFrameWhenInspecting) then
        local _, ilevel, _, _, _, maxLevel = LibItemInfo:GetUnitItemLevel("player")
        local playerFrame = ShowInspectItemListFrame("player", frame, ilevel, maxLevel)
        if (frame.statsFrame) then
            frame.statsFrame:SetParent(playerFrame)
        end
    elseif (frame.statsFrame) then
        frame.statsFrame:SetParent(frame)
    end
    if (frame.statsFrame) then
        frame.statsFrame:SetPoint("TOPLEFT", frame.statsFrame:GetParent(), "TOPRIGHT", 1, -1)
    end
end)

PaperDollFrame:HookScript("OnShow", function(self)
    if (TinyInspectClassicDB and not TinyInspectClassicDB.ShowCharacterItemSheet) then return end
    local _, ilevel, _, _, _, maxLevel = LibItemInfo:GetUnitItemLevel("player")
    ShowInspectItemListFrame("player", self, ilevel, maxLevel)
end)

LibEvent:attachEvent("PLAYER_EQUIPMENT_CHANGED", function(self)
    if (CharacterFrame:IsShown() and TinyInspectClassicDB and TinyInspectClassicDB.ShowCharacterItemSheet) then
        local _, ilevel, _, _, _, maxLevel = LibItemInfo:GetUnitItemLevel("player")
        ShowInspectItemListFrame("player", PaperDollFrame, ilevel, maxLevel)
    end
end)
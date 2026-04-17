
local addon, ns = ...

local LibItemGem = LibStub:GetLibrary("LibItemGem.7000")
local LibSchedule = LibStub:GetLibrary("LibSchedule.7000")
local LibItemEnchant = LibStub:GetLibrary("LibItemEnchant.7000")
local LibItemInfo = LibStub and LibStub:GetLibrary("LibItemInfo.7000", true)

ns = ns or {}
local L = ns.L
if not L then
    local ok, ace = pcall(LibStub, "AceLocale-3.0")
    if ok and ace then
        local locale = ace:GetLocale(addon, true) -- true = silent
        if locale then
            L = locale
        end
    end
end
if not L then
    -- Fallback passthrough (returns the key)
    L = setmetatable({}, { __index = function(t, k) return k end })
end
ns.L = L

local function TI_StripColorCodes(s)
    if not s then return s end
    -- remove |cAARRGGBB and |r
    s = s:gsub("|c%x%x%x%x%x%x%x%x", "")
    s = s:gsub("|r", "")
    return s
end

-- Passive tooltip scanner to read item tooltips when LibItemEnchant fails.
local TI_SCAN_TT = CreateFrame("GameTooltip", "TinyInspect_ScanTooltip", UIParent, "GameTooltipTemplate")
TI_SCAN_TT:SetOwner(UIParent, "ANCHOR_NONE")

local function TI_ScanEnchantFromTooltip(itemLink)
    -- Returns: found(boolean), text(string or nil), isLW(boolean)
    if not itemLink then return false, nil, false end
    TI_SCAN_TT:ClearLines()
    TI_SCAN_TT:SetHyperlink(itemLink)

    local foundText, isLW = nil, false
    local n = TI_SCAN_TT:NumLines() or 0
    for i = 2, n do
        local line = _G["TinyInspect_ScanTooltipTextLeft"..i]
        local raw = line and line:GetText()
        if raw and raw ~= "" then
            -- strip WoW color codes
            local cleaned = TI_StripColorCodes(raw)
            local lower = cleaned:lower()

            -- Leatherworking requirement?
            -- L["REQ_LEATHERWORKING_LWR"] must be a lowercase needle (see Locales).
            local lw_need = L["REQ_LEATHERWORKING_LWR"]
            if type(lw_need) == "string" and lw_need ~= "" and lower:find(lw_need, 1, true) then
                isLW = true
            end
			
			local lw_need = L["REQ_LEATHERWORKING_ING"]
            if type(lw_need) == "string" and lw_need ~= "" and lower:find(lw_need, 1, true) then
                isLW = true
            end

            -- Enchant line?
            local m
            -- Patterns come pre-lowercased and should start with ^(
            local p_de = L["ENCHANT_PREFIX_DE_MATCH"]
            local p_en = L["ENCHANT_PREFIX_EN_MATCH"]
            if type(p_de) == "string" and p_de ~= "" then
                m = lower:match(p_de)
            end
            if not m and type(p_en) == "string" and p_en ~= "" then
                m = lower:match(p_en)
            end
            if m then
                -- keep cleaned (but original-cased) text for display
                foundText = cleaned
            end
        end
    end
    return (foundText ~= nil) or isLW, foundText, isLW
end



local ED_BASE_SOCKET_KEYS = {
  "EMPTY_SOCKET_RED",
  "EMPTY_SOCKET_YELLOW",
  "EMPTY_SOCKET_BLUE",
  "EMPTY_SOCKET_META",
}

local function CreateIconFrame(frame, index)
    local icon = CreateFrame("Button", nil, frame)
    icon.index = index
    icon:Hide()
    icon:SetSize(16, 16)
    icon:SetScript("OnEnter", function(self)
        if (self.itemLink) then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(self.itemLink)
            GameTooltip:Show()
        elseif (self.spellID) then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetSpellByID(self.spellID)
            GameTooltip:Show()
        elseif (self.title) then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(self.title)
            GameTooltip:Show()
        end
    end)
    icon:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
    icon:SetScript("OnDoubleClick", function(self)
        if (self.itemLink or self.title) then
            ChatEdit_ActivateChat(ChatEdit_ChooseBoxForSend())
            ChatEdit_InsertLink(self.itemLink or self.title)
        end
    end)
    icon.bg = icon:CreateTexture(nil, "BACKGROUND")
    icon.bg:SetSize(16, 16)
    icon.bg:SetPoint("CENTER")
    icon.bg:SetTexture("Interface\\AddOns\\"..addon.."\\texture\\GemBg")
    icon.texture = icon:CreateTexture(nil, "BORDER")
    icon.texture:SetSize(12, 12)
    icon.texture:SetPoint("CENTER")
    icon.texture:SetMask("Interface\\FriendsFrame\\Battlenet-Portrait")
    frame["xicon"..index] = icon
    return frame["xicon"..index]
end

local function HideAllIconFrame(frame)
    local index = 1 
    while (frame["xicon"..index]) do
        frame["xicon"..index].title = nil
        frame["xicon"..index].itemLink = nil
        frame["xicon"..index].spellID = nil
        frame["xicon"..index]:Hide()
        index = index + 1
    end
    LibSchedule:RemoveTask("InspectGemAndEnchant", true)
end

local function TI_CountSockets(itemLink)
    local stats = (TI_GetItemStats or C_Item.GetItemStats)(itemLink)
    local n = 0
    if stats then
        for k, v in pairs(stats) do
            if type(k) == "string" and k:find("EMPTY_SOCKET_") then
                n = n + (tonumber(v) or 0)
            end
        end
    end
    return n
end

-- Profession specific Enchanting Checks
-- 333 => Enchanting, 164 => Blacksmithing, 202 => Engineering

local function TI_UnitHasEnchanting(unit)
    if unit ~= "player" then
        return false
    end
    local function hasEnchanting(profId)
        if not profId then return false end
        local _, _, _, _, _, _, skillLine = GetProfessionInfo(profId)
        return skillLine == 333
    end
    local p1, p2 = GetProfessions()
    return hasEnchanting(p1) or hasEnchanting(p2)
end


local function TI_UnitHasBlacksmithing(unit)
    if unit ~= "player" then
        return false
    end
    local function hasBS(profId)
        if not profId then return false end
        local _, _, _, _, _, _, skillLine = GetProfessionInfo(profId)
        return skillLine == 164
    end
    local p1, p2 = GetProfessions()
    return hasBS(p1) or hasBS(p2)
end

local function TI_UnitHasEngineering(unit)
    if unit ~= "player" then
        return false
    end
    local function hasEng(profId)
        if not profId then return false end
        local _, _, _, _, _, _, skillLine = GetProfessionInfo(profId)
        return skillLine == 202
    end
    local p1, p2 = GetProfessions()
    return hasEng(p1) or hasEng(p2)
end

-- Profession Enchants End

local PROF_ENCHANTS = {
    Engineering = {
        -- Handschuhe
        [82175] = true, -- Synapse Springs
        [54736] = true, -- Hyperspeed Accelerators (Wrath/Legacy)
        [82200] = true, -- Quickflip Deflection Plates
        -- Gürtel
        [55016] = true, -- Nitro Boosts
        [84425] = true, -- Frag Belt
        -- Rücken
        [55002] = true, -- Flexweave Underlay
    },
    Tailoring = {
        [75175] = true, -- Lightweave Embroidery
        [75172] = true, -- Swordguard Embroidery
        [75170] = true, -- Darkglow Embroidery
    },
    Inscription = {
        [61117] = true, -- Master's Inscription of the Axe
        [61118] = true, -- Master's Inscription of the Crag
        [61119] = true, -- Master's Inscription of the Pinnacle
        [61120] = true, -- Master's Inscription of the Storm
        [86403] = true, -- Inscription: Ox Horn
        [86402] = true, -- Inscription: Crane Wing
    },
}

local function TI_GetProfessionByEnchant(itemLink)
    if not itemLink then return nil end
    local _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, enchantID = strsplit(":", itemLink)

    local eID = tonumber(enchantID)
    if not eID or eID == 0 then return nil end

    for prof, spells in pairs(PROF_ENCHANTS) do
        if spells[eID] then
            return prof, eID
        end
    end
    return nil
end


local function GetIconFrame(frame)
    local index = 1
    while (frame["xicon"..index]) do
        if (not frame["xicon"..index]:IsShown()) then
            return frame["xicon"..index]
        end
        index = index + 1
    end
    return CreateIconFrame(frame, index)
end

local function onExecute(self)
    if (self.dataType == "item") then
        local _, itemLink, quality, _, _, _, _, _, _, texture = GetItemInfo(self.data)
        if (texture) then
            local r, g, b = GetItemQualityColor(quality or 0)
            self.icon.bg:SetVertexColor(r, g, b)
            self.icon.texture:SetTexture(texture)
            if (not self.icon.itemLink) then
                self.icon.itemLink = itemLink
            end
            return true
        end
    elseif (self.dataType == "spell") then
        local _, _, texture = C_Spell.GetSpellInfo(self.data)
        if (texture) then
            self.icon.texture:SetTexture(texture)
            return true
        end
    end
end

local function UpdateIconTexture(icon, texture, data, dataType)
    if (not texture) then
        LibSchedule:AddTask({
            identity  = "InspectGemAndEnchant" .. icon.index,
            timer     = 0.1,
            elasped   = 0.5,
            expired   = GetTime() + 3,
            onExecute = onExecute,
            icon      = icon,
            data      = data,
            dataType  = dataType,
        })
    end
end

local function TI_GetEnchantIdFromItemLink(link)
    if type(link) ~= "string" then return nil end
    -- Extract the colon-separated payload right after "item:"
    local payload = link:match("item:([^|]+)")
    if not payload then return nil end
    -- ENCHANT is the 2nd field in the payload
    local first, enchant = payload:match("^([^:]*):([^:]*)")
    if enchant and enchant ~= "" then
        local eid = tonumber(enchant)
        return eid
    end
    return nil
end

-- Count base sockets (colored/meta) vs TOTAL sockets (all EMPTY_SOCKET_*).
-- A buckle adds exactly +1 socket; even if empty we still see TOTAL > BASE.
local function ED_HasBuckle_ByGems(unit, slot)
  unit = unit or "player"
  slot = slot or INVSLOT_WAIST

  local link = GetInventoryItemLink(unit, slot)
  if not link then
    return false, 0, 0, nil -- hasBuckle, baseCount, lastGemIndex, link
  end

  local stats = GetItemStats(link) or {}
  local baseCount, totalCount = 0, 0

  -- BASE = only the native colored/meta sockets (no buckle)
  for _, key in ipairs(ED_BASE_SOCKET_KEYS) do
    local n = stats[key]
    if n and n > 0 then baseCount = baseCount + n end
  end

  -- TOTAL = every empty socket stat found on the item
  for k, v in pairs(stats) do
    if type(k) == "string" and k:find("^EMPTY_SOCKET_") then
      totalCount = totalCount + (tonumber(v) or 0)
    end
  end

  -- Legacy heuristic: look at gems actually inserted
  local lastGemIndex = 0
  for i = 1, 4 do
    local _, gemLink = GetItemGem(link, i)
    if gemLink then lastGemIndex = i end
  end

  -- Prefer stat-based detection: buckle adds exactly +1 socket on belts
  local hasBuckle = (totalCount > baseCount) or (lastGemIndex > baseCount)

  return hasBuckle, baseCount, lastGemIndex, link
end



local function TI_ResolveUnitFromItemFrame(itemframe)
    -- Inspect path: parent usually has .unit
    if itemframe and itemframe.GetParent then
        local p = itemframe:GetParent()
        if p and p.unit then
            return p.unit
        end
    end
    -- Fallback: InspectFrame knows the inspected unit if open
    if _G.InspectFrame and InspectFrame.unit then
        return InspectFrame.unit
    end
    -- Default to player when nothing else is known (PaperDoll)
    return "player"
end

local function TI_FindItemListFrameFromArgs(...)
    for i = 1, select("#", ...) do
        local arg = select(i, ...)
        if type(arg) == "table" then
            -- Heuristic: TinyInspect list frames expose "item1", "item2", ...
            if rawget(arg, "item1") or rawget(arg, "item2") then
                return arg
            end
            -- Some builds attach it as ".characterFrame" or ".inspectFrame"
            if arg.characterFrame and (rawget(arg.characterFrame, "item1") or rawget(arg.characterFrame, "item2")) then
                return arg.characterFrame
            end
            if arg.inspectFrame and (rawget(arg.inspectFrame, "item1") or rawget(arg.inspectFrame, "item2")) then
                return arg.inspectFrame
            end
        end
    end
    -- Last resort: try well-known globals if present
    if _G.TinyInspectItemListFrame and (rawget(_G.TinyInspectItemListFrame, "item1") or rawget(_G.TinyInspectItemListFrame, "item2")) then
        return _G.TinyInspectItemListFrame
    end
    return nil
end


local function ShowGemAndEnchant(frame, ItemLink, anchorFrame, itemframe)
    -- Link retten (Player-PaperDoll)
    if (not ItemLink) and itemframe then
        local unitX = TI_ResolveUnitFromItemFrame(itemframe)
        if unitX and itemframe.index then
            ItemLink = GetInventoryItemLink(unitX, itemframe.index)
        end
    end
    if not ItemLink then return 0 end
	local alreadyHasProfessionEnchant = false
    local unit = TI_ResolveUnitFromItemFrame(itemframe) or "player"

    -- =========================
    -- 1) GEM ICONS
    -- =========================
    local num, info, qty = LibItemGem:GetItemGemInfo(ItemLink)
    local _, quality, texture, icon, r, g, b
    for i, v in ipairs(info) do
        icon = GetIconFrame(frame)
        if (v.link) then
            _, _, quality, _, _, _, _, _, _, texture = GetItemInfo(v.link)
            r, g, b = GetItemQualityColor(quality or 0)
            icon.bg:SetVertexColor(r, g, b)
            icon.texture:SetTexture(texture or "Interface\\Cursor\\Quest")
            UpdateIconTexture(icon, texture, v.link, "item")
        else
            icon.bg:SetVertexColor(1, 0.82, 0, 0.5)
            icon.texture:SetTexture("Interface\\Cursor\\Quest")
        end
        icon.title = v.name
        icon.itemLink = v.link
        icon:ClearAllPoints()
        icon:SetPoint("LEFT", anchorFrame, "RIGHT", i == 1 and 6 or 1, 0)
        icon:Show()
        anchorFrame = icon
    end

    -- =========================
    -- 2) GÜRTEL-SCHNALLE
    -- =========================
    if itemframe and itemframe.index == INVSLOT_WAIST then
        local hasBuckle = false
        local unitB    = TI_ResolveUnitFromItemFrame(itemframe) or "player"
        local waist    = GetInventoryItemLink(unitB, INVSLOT_WAIST) or ItemLink

        local hb = false
        if unitB and waist then
            hb = select(1, ED_HasBuckle_ByGems(unitB, INVSLOT_WAIST))
        end
        hasBuckle = hb and true or false

        if unitB == "player" and waist and not hasBuckle then
            -- Fallback: Enchant-Info kann Buckle implizieren (ältere Clients)
            local enchantId   = TI_GetEnchantIdFromItemLink(waist)
            local eItemID, eID = LibItemEnchant:GetEnchantItemID(waist)
            local eSpellID     = LibItemEnchant:GetEnchantSpellID(waist)
            local hasEnchant   = (enchantId and enchantId > 0)
                              or (eItemID and eItemID ~= 0)
                              or (eSpellID and eSpellID ~= 0)
                              or (eID and eID ~= 0)
            if hasEnchant then
                hasBuckle = true
            end
        end

        if not hasBuckle then
            num = num + 1
            local iconWarn = GetIconFrame(frame)
            iconWarn.title = (GetLocale():sub(1,2) == "de") and "Gürtelschnalle fehlt" or "Belt Buckle missing"
            iconWarn.bg:SetVertexColor(1, 0.2, 0.2, 0.6)
            iconWarn.texture:SetTexture("Interface\\DialogFrame\\DialogAlertIcon")
            iconWarn.itemLink, iconWarn.spellID = nil, nil
            iconWarn:ClearAllPoints()
            iconWarn:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
            iconWarn:Show()
            anchorFrame = iconWarn
        end
    end

    -- =========================
    -- 3) RING-E N C H A N T  (nur warnen, wenn Spieler Enchanting hat)
    -- =========================
    if itemframe and (itemframe.index == 11 or itemframe.index == 12) then
        if unit == "player" and TI_UnitHasEnchanting(unit) then
            local hasEnchant = LibItemEnchant:GetEnchantSpellID(ItemLink)
            if not hasEnchant then
                num = num + 1
                local iconWarn = GetIconFrame(frame)
                iconWarn.title = (GetLocale():sub(1,2) == "de") and "Ringverzauberung fehlt" or "Ring enchant missing"
                iconWarn.bg:SetVertexColor(1, 0.2, 0.2, 0.6)
                --iconWarn.texture:SetTexture("Interface\\DialogFrame\\DialogAlertIcon")
				iconWarn.texture:SetTexture("Interface\\Icons\\inv_enchant_formulagood_01")
                iconWarn:ClearAllPoints()
                iconWarn:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
                iconWarn:Show()
                anchorFrame = iconWarn
            end
        end
    end

    -- =========================
    -- 4) BS-EXTRA-SOCKEL (Bracers/Gloves)
    -- =========================
    if itemframe and (itemframe.index == 9 or itemframe.index == 10) then
        if TI_UnitHasBlacksmithing(unit) then
            local sockets = TI_CountSockets(ItemLink)
            if sockets == 0 then
                num = num + 1
                local iconWarn = GetIconFrame(frame)
                iconWarn.title = (GetLocale():sub(1,2) == "de")
                    and "Extra-Sockel fehlt (Beruf: Schmiedekunst)"
                    or  "Extra Socket missing (Profession: Blacksmithing)"
                iconWarn.bg:SetVertexColor(1, 0.2, 0.2, 0.6)
                iconWarn.texture:SetTexture("Interface\\DialogFrame\\DialogAlertIcon")
                iconWarn.itemLink, iconWarn.spellID = nil, nil
                iconWarn:ClearAllPoints()
                iconWarn:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
                iconWarn:Show()
                anchorFrame = iconWarn
            end
        end
    end

    -- =========================
	-- 5) ENCHANT-ANZEIGE (Item/Spell/ID)
	-- =========================
	local enchantItemID, enchantID = LibItemEnchant:GetEnchantItemID(ItemLink)
	local enchantSpellID = LibItemEnchant:GetEnchantSpellID(ItemLink)
	local EnchantParts   = TinyInspectClassicDB.EnchantParts or {}

	-- Prüfe, ob der Enchant zu einem Beruf gehört (Engineering, Tailoring, Inscription, Enchanting)
	local profName, profEnchantID = TI_GetProfessionByEnchant(ItemLink)
	
	local isProfessionOnly = false
	if profName then
		-- Es ist ein bekannter Berufs-Enchant (z. B. Tinker oder Stickerei)
		isProfessionOnly = true
	end

	-- =========================
	-- Berufseigene Enchants
	-- =========================
	if profName and (
		profName == "Engineering"
		or profName == "Tailoring"
		or profName == "Inscription"
		or profName == "Enchanting"
	) then
		-- Wenn ein Enchant erkannt wurde (z.B. Ringverzauberung, Tinker, etc.):
		-- NICHT hier anzeigen, da der Berufsteil (#8) ihn bereits korrekt behandelt.
		-- Wir überspringen also einfach die Standard-Enchantanzeige.
		
		-- Ausnahme: Wenn kein EnchantSpellID vorhanden ist UND es sich um den eigenen Char handelt,
		-- darf der Berufsteil später die "fehlend"-Anzeige übernehmen.
		-- Daher KEIN return, sondern nur skip der Anzeige.
		alreadyHasProfessionEnchant = true
	else
		-- =========================
		-- STANDARD-ENCHANT-LOGIK (immer anzeigen, wenn vorhanden)
		-- =========================
		if not isProfessionOnly then
			if enchantItemID then
				num = num + 1
				local iconE = GetIconFrame(frame)
				local _, linkE, qE, _, _, _, _, _, _, texE = GetItemInfo(enchantItemID)
				local rE, gE, bE = GetItemQualityColor(qE or 0)
				iconE.bg:SetVertexColor(rE, gE, bE)
				iconE.texture:SetTexture(texE)
				UpdateIconTexture(iconE, texE, enchantItemID, "item")
				iconE.itemLink = linkE
				iconE:ClearAllPoints()
				iconE:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
				iconE:Show()
				anchorFrame = iconE
				alreadyHasProfessionEnchant = true

			elseif enchantSpellID then
				num = num + 1
				local iconE = GetIconFrame(frame)
				local _, _, _, texS = C_Spell.GetSpellInfo(enchantSpellID)
				iconE.bg:SetVertexColor(0.2, 1.0, 0.2, 0.8)
				iconE.texture:SetTexture("Interface\\Icons\\inv_enchant_formulagood_01")
				UpdateIconTexture(iconE, texS, enchantSpellID, "spell")
				iconE.spellID = enchantSpellID
				iconE:ClearAllPoints()
				iconE:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
				iconE:Show()
				anchorFrame = iconE
				alreadyHasProfessionEnchant = true

			elseif enchantID then
				num = num + 1
				local iconE = GetIconFrame(frame)
				iconE.title = "#" .. enchantID
				iconE.bg:SetVertexColor(0.1, 0.1, 0.1)
				iconE.texture:SetTexture("Interface\\FriendsFrame\\InformationIcon")
				iconE:ClearAllPoints()
				iconE:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
				iconE:Show()
				anchorFrame = iconE

			elseif (not enchantID 
				and EnchantParts[itemframe.index] 
				and EnchantParts[itemframe.index][1]
				and not (
					itemframe.index == INVSLOT_WAIST or  -- Gürtel (Engineering)
					--itemframe.index == 10 or             -- Handschuhe (Engineering)
					--itemframe.index == 15 or             -- Rücken (Tailoring)
					--itemframe.index == 3 or              -- Schultern (Inscription)
					itemframe.index == 11 or itemframe.index == 12  -- Ringe (Enchanting)
				)
			) then
				num = num + 1
				local iconE = GetIconFrame(frame)
				iconE.title = ENCHANTS .. ": " .. (_G[EnchantParts[itemframe.index][2]] or EnchantParts[itemframe.index][2])
				iconE.bg:SetVertexColor(1, 0.2, 0.2, 0.6)
				iconE.texture:SetTexture("Interface\\Cursor\\Quest")
				iconE:ClearAllPoints()
				iconE:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
				iconE:Show()
				anchorFrame = iconE
				alreadyHasProfessionEnchant = true
			end
		end
	end




    -- =========================
    -- 6) TOOLTIP-FALLBACK (language specific)
    -- =========================
    if not (enchantItemID or enchantSpellID or enchantID) then
        local ok, text, isLW = TI_ScanEnchantFromTooltip(ItemLink)
        if ok then
            num = num + 1
            local icon2 = GetIconFrame(frame)
            icon2.itemLink, icon2.spellID = nil, nil

            if isLW then
                icon2.title = ns.L["LW_ENCHANT_DETECTED"]
                icon2.bg:SetVertexColor(0.2, 0.8, 0.2, 0.7)
                icon2.texture:SetTexture("Interface\\ICONS\\Trade_LeatherWorking")
            else
                icon2.title = string.format("%s: %s", ENCHANTS, text or "?")
                icon2.bg:SetVertexColor(1, 0.82, 0, 0.5)
                icon2.texture:SetTexture("Interface\\FriendsFrame\\InformationIcon")
            end

            icon2:ClearAllPoints()
            icon2:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
            icon2:Show()
            anchorFrame = icon2
        end
    end

    -- =========================
    -- 7) BERUFS-ENCHANTS
    -- =========================
    do
        local profName, profSpellId = TI_GetProfessionByEnchant(ItemLink)  -- <== liefert z.B. "Engineering" wenn tinker
        if profName and unit == "player" and profName ~= "Enchanting" then
            local hasProfession = false
            if profName == "Engineering" and TI_UnitHasEngineering(unit) then
                hasProfession = true
            elseif profName == "Tailoring" and (IsSpellKnown(3908) or IsSpellKnown(3910)) then
                hasProfession = true
            elseif profName == "Inscription" and IsSpellKnown(45357) then
                hasProfession = true
            end

            if hasProfession then
                num = num + 1
                local iconP = GetIconFrame(frame)
                iconP.title = profName .. " Enchant (" .. (profSpellId or 0) .. ")"
                --iconP.bg:SetVertexColor(0.2, 0.8, 0.2, 0.6)
                --iconP.texture:SetTexture("Interface\\ICONS\\Trade_" .. profName)
				iconP.bg:SetVertexColor(0.2, 1.0, 0.2, 0.8)
				iconP.texture:SetTexture("Interface\\Icons\\inv_enchant_formulagood_01")
                iconP.itemLink = ItemLink
                iconP.spellID  = profSpellId
                iconP:ClearAllPoints()
                iconP:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
                iconP:Show()
                anchorFrame = iconP
            end
        end
    end
	-- 🔹 UNIVERSAL PROFESSION ENCHANT CHECK
	if itemframe and itemframe.index then
		-- Wenn das Item bereits eine Berufsverzauberung erkannt und angezeigt hat → überspringen
		if alreadyHasProfessionEnchant then
			-- Überspringe diesen Abschnitt, aber fahre mit Upgrades (#8) fort
		else
			local unit = TI_ResolveUnitFromItemFrame(itemframe)
			local isPlayer = (unit == "player")

			-- Profession-Status (nur für eigenen Char ermittelbar)
			local hasEng  = isPlayer and TI_UnitHasEngineering(unit)
			local hasTail = isPlayer and (IsSpellKnown(3908) or IsSpellKnown(3910))  -- Tailoring
			local hasInsc = isPlayer and IsSpellKnown(45357)                         -- Inscription
			local hasEnchanting = isPlayer and TI_UnitHasEnchanting(unit)

			local slot = itemframe.index
			local enchantSpellID = LibItemEnchant:GetEnchantSpellID(ItemLink)
			local prof, profName, iconTex

			-- Slotzuordnung zu Berufs-VZ
			if slot == 11 or slot == 12 then
				prof, profName, iconTex = "Enchanting", "Verzauberung", "Interface\\ICONS\\Trade_Enchanting"
			elseif (slot == INVSLOT_WAIST) or (slot == 10) then
				prof, profName, iconTex = "Engineering", "Ingenieurskunst", "Interface\\ICONS\\Trade_Engineering"
			elseif slot == 15 then
				prof, profName, iconTex = "Tailoring", "Schneiderei", "Interface\\ICONS\\Trade_Tailoring"
			elseif slot == 3 then
				prof, profName, iconTex = "Inscription", "Inschriftenkunde", "Interface\\ICONS\\INV_Inscription_Tradeskill01"
			end

			-- Kein Berufs-Slot? Dann überspringen, aber NICHT returnen!
			if not prof then
				-- einfach nichts tun, restliche Funktion (Upgrade etc.) soll weiterlaufen
			else
				-- Spell-Listen zur Zuordnung
				local EngSpells = {
					[55016] = true, [82175] = true, [82176] = true, [84424] = true,
					[54736] = true, [55002] = true, [55076] = true, [54793] = true
				}
				local TailSpells = {
					[75172] = true, [75175] = true, [75178] = true,
					[55769] = true, [55642] = true
				}
				local InscSpells = {
					[61117] = true, [61118] = true, [61119] = true, [61120] = true
				}

				local isProfessionEnchant = false
				if prof == "Engineering" and enchantSpellID and EngSpells[enchantSpellID] then
					isProfessionEnchant = true
				elseif prof == "Tailoring" and enchantSpellID and TailSpells[enchantSpellID] then
					isProfessionEnchant = true
				elseif prof == "Inscription" and enchantSpellID and InscSpells[enchantSpellID] then
					isProfessionEnchant = true
				elseif prof == "Enchanting" and enchantSpellID and (slot == 11 or slot == 12) then
					isProfessionEnchant = true
				end

				-- Wenn der Berufseffekt auf dem Item ist → immer anzeigen
				if isProfessionEnchant then
					num = num + 1
					local icon = GetIconFrame(frame)
					local _, _, tex = C_Spell.GetSpellInfo(enchantSpellID)
					--icon.bg:SetVertexColor(0.2, 1, 0.2, 0.7)
					--icon.texture:SetTexture(tex or iconTex)
					icon.bg:SetVertexColor(0.2, 1.0, 0.2, 0.8)
					icon.texture:SetTexture("Interface\\Icons\\inv_enchant_formulagood_01")
					icon.spellID = enchantSpellID
					icon.title = (GetLocale():sub(1,2) == "de")
						and (profName .. "-Verzauberung")
						or (prof .. " enchant")
					icon:ClearAllPoints()
					icon:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
					icon:Show()
					anchorFrame = icon

				-- Nur beim Spieler prüfen, wenn Beruf vorhanden, aber kein Spell drauf
				elseif isPlayer and not enchantSpellID and (
					(prof == "Engineering" and hasEng) or
					(prof == "Tailoring" and hasTail) or
					(prof == "Inscription" and hasInsc) or
					(prof == "Enchanting" and hasEnchanting)
				) then
					num = num + 1
					local icon = GetIconFrame(frame)
					icon.bg:SetVertexColor(1, 0.2, 0.2, 0.6)
					--icon.texture:SetTexture("Interface\\DialogFrame\\DialogAlertIcon")
					icon.texture:SetTexture("Interface\\Icons\\inv_enchant_formulagood_01")
					icon.title = (GetLocale():sub(1,2) == "de")
						and (profName .. "-Verzauberung fehlt")
						or (prof .. " enchant missing")
					icon:ClearAllPoints()
					icon:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
					icon:Show()
					anchorFrame = icon
				end
			end
		end
	end



    -- =========================
	-- 8) UPGRADE-STUFE (eigener Frame, eigenes Icon)
	-- =========================
	if itemframe and itemframe.index then
		local stage, maxStage = 0, 0
		if LibItemInfo and unit then
			stage, maxStage = LibItemInfo:GetUnitItemUpgradeInfo(unit, itemframe.index)
		end
		if stage and maxStage and maxStage > 0 then
			num = num + 1
			local iconUp = GetIconFrame(frame)

			-- Farben je nach Fortschritt
			local rU, gU, bU
			if stage == 0 then
				rU, gU, bU = 1, 0, 0          -- rot
			elseif stage < maxStage then
				rU, gU, bU = 1.0, 0.6, 0.1    -- orange
			elseif stage >= maxStage then
				rU, gU, bU = 0.2, 1.0, 0.2    -- grün
			end
			iconUp.bg:SetVertexColor(rU, gU, bU, 0.75)

			iconUp.texture:SetTexture(nil)
			iconUp.title = string.format("Upgrade: %d/%d", stage, maxStage)
			iconUp.itemLink, iconUp.spellID = nil, nil
			iconUp:ClearAllPoints()
			iconUp:SetPoint("LEFT", anchorFrame, "RIGHT", num == 1 and 6 or 1, 0)
			iconUp:Show()
			anchorFrame = iconUp
		end
	end


    return num * 18
end


hooksecurefunc("ShowInspectItemListFrame", function(unit, parent, itemLevel, maxLevel)
    local frame = parent.inspectFrame
    if (not frame) then return end
    if (TinyInspectClassicDB and TinyInspectClassicDB.ShowGemAndEnchant) then
        local i = 1
        local itemframe
        local width, iconWidth = frame:GetWidth(), 0
        HideAllIconFrame(frame)
        while (frame["item"..i]) do
            itemframe = frame["item"..i]
            iconWidth = ShowGemAndEnchant(frame, itemframe.link, itemframe.itemString, itemframe)
            if (width < itemframe.width + iconWidth + 36) then
                width = itemframe.width + iconWidth + 36
            end
            i = i + 1
        end
        if (width > frame:GetWidth()) then
            frame:SetWidth(width)
        end
    else
        HideAllIconFrame(frame)
    end
end)

-- [FALLBACK] When PaperDoll updates, re-decorate the TinyInspect list directly
hooksecurefunc("PaperDollItemSlotButton_Update", function()
    if not (TinyInspectClassicDB and TinyInspectClassicDB.ShowGemAndEnchant) then return end

    -- Try to locate the TinyInspect list frame tied to the character
    local frame = TI_FindItemListFrameFromArgs(CharacterFrame)
                  or (CharacterFrame and CharacterFrame.characterFrame)
                  or (CharacterFrame and CharacterFrame.inspectFrame)

    if not frame then return end

    local i, width = 1, frame:GetWidth()
    HideAllIconFrame(frame)
    while (frame["item"..i]) do
        local itemframe = frame["item"..i]
        local iconWidth = ShowGemAndEnchant(frame, itemframe.link, itemframe.itemString, itemframe)
        if (width < (itemframe.width or 0) + iconWidth + 36) then
            width = (itemframe.width or 0) + iconWidth + 36
        end
        i = i + 1
    end
    if (width > frame:GetWidth()) then
        frame:SetWidth(width)
    end
end)





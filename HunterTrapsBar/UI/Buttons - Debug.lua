------------------------------------------------------------
-- HunterTrapsBar (V2) - UI/Buttons.lua
-- Generic secure spell buttons
-- Trap Launcher uses aura-driven icon swap
------------------------------------------------------------

local HTB = HunterTrapsBar
if not HTB then return end
local HTB_DEBUG = true

------------------------------------------------------------
-- Constants
------------------------------------------------------------

local BUTTON_SIZE = 36
local BUTTON_PADDING = 6

local TRAP_LAUNCHER_SPELL_ID = 77769
local TRAP_LAUNCHER_ACTIVE_ICON = 136116

------------------------------------------------------------
-- Visibility rule (GENERIC)
-- A spell is shown iff Blizzard says it is known
------------------------------------------------------------

local function GetKnownSpellIDs()
    local _, class = UnitClass("player")
    if class ~= "HUNTER" then return {} end

    local list = {}
    local data = HTB.TrapData and HTB.TrapData.HUNTER
    if not data then return list end

    for _, entry in ipairs(data) do
        local spellID = entry.id
        if IsSpellKnown(spellID) then
            table.insert(list, spellID)
        end
    end
------------------------------------------------------------
-- DEBUG p3
------------------------------------------------------------
if HTB_DEBUG then
    for _, entry in ipairs(data) do
        local id = entry.id
        local name = GetSpellInfo(id) or "UNKNOWN"
        print(string.format(
            "|cff00ff00[HTB]|r Spell check: %s (%d) IsSpellKnown=%s",
            name,
            id,
            tostring(IsSpellKnown(id))
        ))
    end
end
------------------------------------------------------------

    return list
end

------------------------------------------------------------
-- Cooldown updater
------------------------------------------------------------

local function UpdateCooldown(btn)
    if not btn.spellID then return end

    local start, duration, enabled = GetSpellCooldown(btn.spellID)
    if enabled == 1 and duration and duration > 0 then
        btn.Cooldown:SetCooldown(start, duration)
    else
        btn.Cooldown:Clear()
    end
end

------------------------------------------------------------
-- Trap Launcher aura detection
------------------------------------------------------------

local function IsTrapLauncherActive()
    for i = 1, 40 do
        local _, _, _, _, _, _, _, _, _, spellId = UnitBuff("player", i)
        if not spellId then break end
        if spellId == TRAP_LAUNCHER_SPELL_ID then
            return true
        end
    end
    return false
end

local function UpdateTrapLauncherIcon(bar)
    if not bar or not bar.TrapButtons then return end

    local active = IsTrapLauncherActive()

    for _, btn in ipairs(bar.TrapButtons) do
        if btn.spellID == TRAP_LAUNCHER_SPELL_ID then
            if active then
                btn.Icon:SetTexture(TRAP_LAUNCHER_ACTIVE_ICON)
            else
                btn.Icon:SetTexture(btn.defaultIcon)
            end
        end
    end
end

------------------------------------------------------------
-- Create secure spell buttons
------------------------------------------------------------

function HTB:CreateTrapButtons()

------------------------------------------------------------
-- DEBUG
------------------------------------------------------------
    if HTB_DEBUG then
    print("|cff00ff00[HTB]|r CreateTrapButtons() called")
end
------------------------------------------------------------

    -- if not self.Bar or self.TrapButtons then return end

------------------------------------------------------------
-- DEBUG p2
------------------------------------------------------------
if not self.Bar then
    if HTB_DEBUG then
        print("|cff00ff00[HTB]|r No bar yet, aborting CreateTrapButtons")
    end
    return
end

if self.TrapButtons then
    if HTB_DEBUG then
        print("|cff00ff00[HTB]|r TrapButtons already exists, skipping creation")
    end
    return
end
------------------------------------------------------------

    -- Secure rule: do not create buttons in combat
    if InCombatLockdown() then
        local f = CreateFrame("Frame")
        f:RegisterEvent("PLAYER_REGEN_ENABLED")
        f:SetScript("OnEvent", function(selfFrame)
            selfFrame:UnregisterAllEvents()
            HTB:CreateTrapButtons()
        end)
        return
    end

    self.TrapButtons = {}

    local spellIDs = GetKnownSpellIDs()
    if #spellIDs == 0 then return end

    for index, spellID in ipairs(spellIDs) do
        local name, _, icon = GetSpellInfo(spellID)
        if name and icon then
            ----------------------------------------------------
            -- Secure button
            ----------------------------------------------------
            local btn = CreateFrame(
                "Button",
                "HunterTrapsBarButton"..index,
                self.Bar,
                "SecureActionButtonTemplate, BackdropTemplate"
            )

            btn.spellID = spellID

            btn:SetSize(BUTTON_SIZE, BUTTON_SIZE)

            if index == 1 then
                btn:SetPoint("LEFT", self.Bar, "LEFT", BUTTON_PADDING, 0)
            else
                btn:SetPoint(
                    "LEFT",
                    self.TrapButtons[index - 1],
                    "RIGHT",
                    BUTTON_PADDING,
                    0
                )
            end

            btn:RegisterForClicks("AnyUp")
            btn:SetAttribute("type1", "spell")
            btn:SetAttribute("spell", name)

            ----------------------------------------------------
            -- Icon
            ----------------------------------------------------
            local tex = btn:CreateTexture(nil, "ARTWORK")
            tex:SetAllPoints()
            tex:SetTexture(icon)
            btn.Icon = tex
            btn.defaultIcon = icon

            ----------------------------------------------------
            -- Border
            ----------------------------------------------------
            btn:SetBackdrop({
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 12,
            })
            btn:SetBackdropBorderColor(1, 1, 1, 1)

            ----------------------------------------------------
            -- Cooldown
            ----------------------------------------------------
            local cd = CreateFrame("Cooldown", nil, btn, "CooldownFrameTemplate")
            cd:SetAllPoints()
            cd:SetDrawEdge(false)
            cd:SetHideCountdownNumbers(false)
            btn.Cooldown = cd

            ----------------------------------------------------
            -- Tooltip
            ----------------------------------------------------
            btn:SetScript("OnEnter", function(selfBtn)
                GameTooltip:SetOwner(selfBtn, "ANCHOR_RIGHT")
                GameTooltip:SetSpellByID(selfBtn.spellID)
                GameTooltip:Show()
            end)

            btn:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)

            btn:Show()
            table.insert(self.TrapButtons, btn)
        end
    end

    ------------------------------------------------------------
    -- Resize bar
    ------------------------------------------------------------
    if HTB.ResizeBarForButtons then
        HTB:ResizeBarForButtons(#self.TrapButtons)
    end

    ------------------------------------------------------------
    -- Cooldown updates
    ------------------------------------------------------------
    local updater = CreateFrame("Frame", nil, self.Bar)
    updater:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    updater:SetScript("OnEvent", function()
        for _, b in ipairs(self.TrapButtons) do
            UpdateCooldown(b)
        end
    end)

    for _, b in ipairs(self.TrapButtons) do
        UpdateCooldown(b)
    end

    ------------------------------------------------------------
    -- Sync Trap Launcher icon immediately
    ------------------------------------------------------------
    UpdateTrapLauncherIcon(self)
end

------------------------------------------------------------
-- Listen for Trap Launcher aura changes
------------------------------------------------------------

local auraFrame = CreateFrame("Frame")
auraFrame:RegisterUnitEvent("UNIT_AURA", "player")
auraFrame:SetScript("OnEvent", function()
    UpdateTrapLauncherIcon(HTB)
end)

------------------------------------------------------------
-- DEBUG p2
------------------------------------------------------------

if HTB_DEBUG then
    local debugEvents = CreateFrame("Frame")
    debugEvents:RegisterEvent("SPELLS_CHANGED")
    debugEvents:RegisterEvent("LEARNED_SPELL_IN_TAB")
    debugEvents:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

    debugEvents:SetScript("OnEvent", function(_, event)
        print("|cff00ff00[HTB]|r Event fired:", event)
    end)
end
------------------------------------------------------------



------------------------------------------------------------
-- Hook into bar creation
------------------------------------------------------------

hooksecurefunc(HTB, "CreateBar", function()
    HTB:CreateTrapButtons()
end)


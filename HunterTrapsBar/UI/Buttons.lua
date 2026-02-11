------------------------------------------------------------
-- HunterTrapsBar V2 - UI/Buttons.lua
-- Secure spell buttons (IsSpellKnown), cooldowns, tooltips,
-- Trap Launcher active icon swap, spell-ready retry.
------------------------------------------------------------

local HTB = HunterTrapsBar
if not HTB then return end

local BUTTON_SIZE = 36
local BUTTON_PADDING = 3
local LEFT_INSET = 6

local TRAP_LAUNCHER_SPELL_ID = 77769
local TRAP_LAUNCHER_ACTIVE_ICON = 136116

local function GetSpellIDs()
    local _, class = UnitClass("player")
    if class ~= "HUNTER" then return {} end

    local list = {}
    local data = HTB.TrapData and HTB.TrapData.HUNTER
    if not data then return list end

    for _, entry in ipairs(data) do
        if IsSpellKnown(entry.id) then
            table.insert(list, entry.id)
        end
    end

    return list
end

local function UpdateCooldown(btn)
    if not btn or not btn.spellID or not btn.Cooldown then return end
    local start, duration, enabled = GetSpellCooldown(btn.spellID)
    if enabled == 1 and duration and duration > 0 then
        btn.Cooldown:SetCooldown(start, duration)
    else
        btn.Cooldown:Clear()
    end
end

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

local function UpdateTrapLauncherIcon()
    if not HTB or not HTB.TrapButtons then return end
    local active = IsTrapLauncherActive()

    for _, btn in ipairs(HTB.TrapButtons) do
        if btn.spellID == TRAP_LAUNCHER_SPELL_ID and btn.Icon and btn.defaultIcon then
            btn.Icon:SetTexture(active and TRAP_LAUNCHER_ACTIVE_ICON or btn.defaultIcon)
        end
    end
end

------------------------------------------------------------
-- Create buttons (supports retry if 0 buttons were created)
------------------------------------------------------------

function HTB:CreateTrapButtons()
    if not self.Bar then return end

    -- If we already have real buttons, don't recreate
    if self.TrapButtons and #self.TrapButtons > 0 then return end

    -- Combat-safe: defer creation
    if InCombatLockdown() then
        self.__pendingButtonCreate = true
        return
    end

    self.TrapButtons = {}

    local spellIDs = GetSpellIDs()
    if #spellIDs == 0 then
        -- leave TrapButtons empty so SPELLS_CHANGED retry can re-attempt
        return
    end

    for i, spellID in ipairs(spellIDs) do
        local name, _, icon = GetSpellInfo(spellID)
        if name and icon then
            local btn = CreateFrame(
                "Button",
                "HunterTrapsBarButton"..i,
                self.Bar,
                "SecureActionButtonTemplate, BackdropTemplate"
            )

            btn.spellID = spellID
            btn:SetSize(BUTTON_SIZE, BUTTON_SIZE)

            if i == 1 then
                btn:SetPoint("LEFT", self.Bar, "LEFT", LEFT_INSET, 0)
            else
                btn:SetPoint("LEFT", self.TrapButtons[i - 1], "RIGHT", BUTTON_PADDING, 0)
            end

            btn:RegisterForClicks("AnyUp")
            btn:SetAttribute("type1", "spell")
            btn:SetAttribute("spell", name)

            -- Icon
            local tex = btn:CreateTexture(nil, "ARTWORK")
            tex:SetAllPoints()
            tex:SetTexture(icon)
            btn.Icon = tex
            btn.defaultIcon = icon

            -- Hover highlight (subtle)
            local hover = btn:CreateTexture(nil, "HIGHLIGHT")
            hover:SetAllPoints()
            hover:SetColorTexture(1, 1, 1, 0.08) -- subtle white overlay
            hover:Hide()
            btn.Hover = hover

            -- Border (button border stays always visible)
            btn:SetBackdrop({
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 12,
            })
            btn:SetBackdropBorderColor(1, 1, 1, 1)

            -- Cooldown swipe + (Blizzard) numbers
            local cd = CreateFrame("Cooldown", nil, btn, "CooldownFrameTemplate")
            cd:SetAllPoints()
            cd:SetDrawEdge(false)
            if cd.SetHideCountdownNumbers then
                cd:SetHideCountdownNumbers(false)
            end
            btn.Cooldown = cd

            -- Tooltip (TRUE Blizzard default tooltip area)
            btn:SetScript("OnEnter", function(selfBtn)
                GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
                GameTooltip:SetSpellByID(selfBtn.spellID)
                GameTooltip:Show()
            end)
            btn:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)

            -- Hover handlers (IMPORTANT: HookScript, not SetScript)
            btn:HookScript("OnEnter", function(selfBtn)
                if selfBtn.Hover then
                    selfBtn.Hover:Show()
                end
            end)

            btn:HookScript("OnLeave", function(selfBtn)
                if selfBtn.Hover then
                    selfBtn.Hover:Hide()
                end
            end)

            btn:Show()
            table.insert(self.TrapButtons, btn)
        end
    end

    -- Resize bar to fit buttons
    if self.ResizeBarForButtons then
        self:ResizeBarForButtons(#self.TrapButtons)
    end

    -- Initial cooldown update
    for _, b in ipairs(self.TrapButtons) do
        UpdateCooldown(b)
    end

    -- Apply Trap Launcher visual state immediately
    UpdateTrapLauncherIcon()

    -- Hook cooldown updates
    if not self.__cooldownUpdater then
        local updater = CreateFrame("Frame", nil, self.Bar)
        updater:RegisterEvent("SPELL_UPDATE_COOLDOWN")
        updater:SetScript("OnEvent", function()
            if not HTB.TrapButtons then return end
            for _, b in ipairs(HTB.TrapButtons) do
                UpdateCooldown(b)
            end
        end)
        self.__cooldownUpdater = updater
    end
end

------------------------------------------------------------
-- Spell-ready retry (fixes cold login + char swap)
------------------------------------------------------------

local spellRetryFrame = CreateFrame("Frame")
spellRetryFrame:RegisterEvent("SPELLS_CHANGED")
spellRetryFrame:RegisterEvent("LEARNED_SPELL_IN_TAB")
spellRetryFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

spellRetryFrame:SetScript("OnEvent", function(_, event)
    if not HTB or not HTB.Bar then return end

    if event == "PLAYER_REGEN_ENABLED" then
        if HTB.__pendingButtonCreate then
            HTB.__pendingButtonCreate = nil
            HTB:CreateTrapButtons()
        end
        return
    end

    if not HTB.TrapButtons or #HTB.TrapButtons == 0 then
        HTB:CreateTrapButtons()
    end
end)

------------------------------------------------------------
-- Trap Launcher aura watcher
------------------------------------------------------------

local auraFrame = CreateFrame("Frame")
auraFrame:RegisterUnitEvent("UNIT_AURA", "player")
auraFrame:SetScript("OnEvent", function()
    UpdateTrapLauncherIcon()
end)

------------------------------------------------------------
-- When the bar is created, create buttons
------------------------------------------------------------

hooksecurefunc(HTB, "CreateBar", function()
    HTB:CreateTrapButtons()
end)

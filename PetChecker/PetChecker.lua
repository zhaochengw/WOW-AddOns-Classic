-- PetChecker.lua
-- v2.9.10.29.2025-STABLE – Locked Baseline Build

local VERSION = "2.9.10.29.2025-STABLE"
local _, playerClass = UnitClass("player")

-------------------------------------------------
-- ✅ Safe SavedVariables Initialization
-------------------------------------------------
PetCheckerDB = PetCheckerDB or {}

if type(PetCheckerDB.settings) ~= "table" then
    PetCheckerDB.settings = {
        enableHUD = true,
        enableVisuals = true,
        showOutOfCombat = false,
        lockHUD = false,
        hudScale = 1.0,
        lowHPThreshold = 30,
        hudColor = {r = 1, g = 0.82, b = 0},  -- gold border
        textColor = {r = 1, g = 1, b = 0.9},  -- light yellow text
    }
    end

    if type(PetCheckerDB.hudPoint) ~= "table" then
        PetCheckerDB.hudPoint = {"CENTER", "CENTER", 0, -200}
        end

        -------------------------------------------------
        -- Utility
        -------------------------------------------------
        local function IsSuppressed()
        return UnitIsDeadOrGhost("player") or IsMounted() or UnitOnTaxi("player")
        end

        local function IsRelevantClass()
        return playerClass == "HUNTER" or playerClass == "WARLOCK"
        end

        local function GetPetHPPercent()
        if not UnitExists("pet") then return 0 end
            local m = UnitHealthMax("pet")
            if m == 0 then return 0 end
                return (UnitHealth("pet") / m) * 100
                end

                local function PetIsDead()
                return UnitExists("pet") and (UnitIsDead("pet") or UnitHealth("pet") <= 0)
                end

                local function PetTauntOn()
                if not IsInInstance() or not UnitExists("pet") or not GetSpellAutocast then return false end
                    local _, g = GetSpellAutocast("Growl")
                    local _, t = GetSpellAutocast("Torment")
                    local _, th = GetSpellAutocast("Threatening Presence")
                    return g or t or th
                    end

                    local function PetPassive()
                    if not InCombatLockdown() or not UnitExists("pet") then return false end
                        if type(GetNumPetActions) ~= "function" then return false end
                            local n = GetNumPetActions()
                            for i = 1, n do
                                local name, _, _, _, active = GetPetActionInfo(i)
                                if name == "Passive" and active then
                                    return true
                                    end
                                    end
                                    return false
                                    end

                                    -------------------------------------------------
                                    -- Warning Frame
                                    -------------------------------------------------
                                    local WARN = CreateFrame("Frame", "PetChecker_Warning", UIParent)
                                    WARN:SetAllPoints(UIParent)
                                    WARN.text = WARN:CreateFontString(nil, "OVERLAY")
                                    WARN.text:SetFont(STANDARD_TEXT_FONT, 48, "OUTLINE")
                                    WARN.text:SetPoint("CENTER", 0, 250)
                                    WARN.text:SetTextColor(1, 1, 0)
                                    WARN:Hide()

                                    local function ShowWarning(msg)
                                    if not PetCheckerDB.settings or not PetCheckerDB.settings.enableVisuals then
                                        WARN:Hide()
                                        return
                                        end
                                        WARN.text:SetText(msg or "")
                                        WARN:Show()
                                        end

                                        local function HideWarning()
                                        WARN:Hide()
                                        WARN.text:SetText("")
                                        end

                                        -------------------------------------------------
                                        -- HUD Frame
                                        -------------------------------------------------
                                        local HUD = CreateFrame("Frame", "PetCheckerHUD", UIParent, "BackdropTemplate")
                                        HUD:SetSize(220, 40)
                                        HUD:SetFrameStrata("HIGH")

                                        HUD:SetBackdrop({
                                            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                                            tile = true, tileSize = 16, edgeSize = 16,
                                            insets = {left = 4, right = 4, top = 4, bottom = 4}
                                        })
                                        HUD:SetBackdropColor(0, 0, 0, 0.7)

                                        HUD.text = HUD:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
                                        HUD.text:SetPoint("CENTER")

                                        HUD:SetMovable(true)
                                        HUD:EnableMouse(true)
                                        HUD:RegisterForDrag("LeftButton")
                                        HUD:SetScript("OnDragStart", function(self)
                                        if not PetCheckerDB.settings.lockHUD then
                                            self:StartMoving()
                                            end
                                            end)
                                        HUD:SetScript("OnDragStop", function(self)
                                        self:StopMovingOrSizing()
                                        local p, _, r, x, y = self:GetPoint()
                                        PetCheckerDB.hudPoint = {p, r, x, y}
                                        end)

                                        -------------------------------------------------
                                        -- ✅ HUD Color Updater (safe)
                                        -------------------------------------------------
                                        function PetChecker_UpdateColors()
                                        if not PetCheckerDB or type(PetCheckerDB.settings) ~= "table" then
                                            return
                                            end

                                            -- Default color safety
                                            if type(PetCheckerDB.settings.hudColor) ~= "table" then
                                                PetCheckerDB.settings.hudColor = {r = 1, g = 0.82, b = 0}
                                                end
                                                if type(PetCheckerDB.settings.textColor) ~= "table" then
                                                    PetCheckerDB.settings.textColor = {r = 1, g = 1, b = 0.9}
                                                    end

                                                    local hc = PetCheckerDB.settings.hudColor
                                                    local tc = PetCheckerDB.settings.textColor

                                                    if HUD and HUD.SetBackdropBorderColor then
                                                        HUD:SetBackdropBorderColor(hc.r, hc.g, hc.b, 1)
                                                        end
                                                        if HUD and HUD.text then
                                                            HUD.text:SetTextColor(tc.r, tc.g, tc.b)
                                                            end
                                                            end

                                                            -------------------------------------------------
                                                            -- ✅ Safe HUD Position Restore
                                                            -------------------------------------------------
                                                            local function RestoreHUDPosition()
                                                            -- Ensure valid SavedVariables
                                                            if not PetCheckerDB then PetCheckerDB = {} end
                                                                if type(PetCheckerDB.hudPoint) ~= "table" or #PetCheckerDB.hudPoint < 4 then
                                                                    PetCheckerDB.hudPoint = { "CENTER", "CENTER", 0, -200 }
                                                                    end

                                                                    local p, r, x, y = unpack(PetCheckerDB.hudPoint)
                                                                    if not p then p = "CENTER" end
                                                                        if not r then r = "CENTER" end
                                                                            if type(x) ~= "number" then x = 0 end
                                                                                if type(y) ~= "number" then y = -200 end

                                                                                    HUD:ClearAllPoints()
                                                                                    HUD:SetPoint(p, UIParent, r, x, y)
                                                                                    end

                                                                                    -------------------------------------------------
                                                                                    -- HUD Visual & Text Updates
                                                                                    -------------------------------------------------
                                                                                    local function UpdateHUDVisual()
                                                                                    if not PetCheckerDB or type(PetCheckerDB.settings) ~= "table" then
                                                                                        HUD:SetScale(1.0)
                                                                                        return
                                                                                        end
                                                                                        HUD:SetScale(PetCheckerDB.settings.hudScale or 1.0)
                                                                                        PetChecker_UpdateColors()
                                                                                        end

                                                                                        local function UpdateHUDText()
                                                                                        if not PetCheckerDB or type(PetCheckerDB.settings) ~= "table" then
                                                                                            HUD:Hide()
                                                                                            return
                                                                                            end
                                                                                            if not PetCheckerDB.settings.enableHUD then
                                                                                                HUD:Hide()
                                                                                                return
                                                                                                end
                                                                                                if IsSuppressed() or (not InCombatLockdown() and not PetCheckerDB.settings.showOutOfCombat) then
                                                                                                    HUD:Hide()
                                                                                                    return
                                                                                                    end

                                                                                                    if not UnitExists("pet") then
                                                                                                        HUD.text:SetText("No Pet Detected")
                                                                                                        else
                                                                                                            local name = UnitName("pet") or "Pet"
                                                                                                            local hp = math.floor(GetPetHPPercent())
                                                                                                            local status = PetIsDead() and "Dead" or "Alive"
                                                                                                            HUD.text:SetText(string.format("%s   HP: %d%%   %s", name, hp, status))
                                                                                                            end

                                                                                                            HUD:SetWidth(HUD.text:GetStringWidth() + 30)
                                                                                                            HUD:Show()
                                                                                                            end

                                                                                                            -------------------------------------------------
                                                                                                            -- Main Scan Loop
                                                                                                            -------------------------------------------------
                                                                                                            local scanFrame = CreateFrame("Frame")
                                                                                                            local accum = 0
                                                                                                            scanFrame:SetScript("OnUpdate", function(_, dt)
                                                                                                            if not PetCheckerDB or not PetCheckerDB.settings then return end
                                                                                                                accum = accum + dt
                                                                                                                if accum < 0.1 then return end
                                                                                                                    accum = 0

                                                                                                                    if not IsRelevantClass() or IsSuppressed() then
                                                                                                                        HideWarning()
                                                                                                                        UpdateHUDText()
                                                                                                                        return
                                                                                                                        end

                                                                                                                        local petExists = UnitExists("pet")
                                                                                                                        local petDead = PetIsDead()
                                                                                                                        local hp = math.floor(GetPetHPPercent())
                                                                                                                        local threshold = PetCheckerDB.settings.lowHPThreshold or 30

                                                                                                                        UpdateHUDText()
                                                                                                                        UpdateHUDVisual()

                                                                                                                        local warningMsg
                                                                                                                        if PetCheckerDB.settings.enableVisuals then
                                                                                                                            if not petExists then
                                                                                                                                warningMsg = "NO PET SUMMONED!"
                                                                                                                                elseif petDead then
                                                                                                                                    warningMsg = "YOUR PET HAS DIED!"
                                                                                                                                    elseif hp > 0 and hp < threshold then
                                                                                                                                        warningMsg = "PET HEALTH LOW (" .. hp .. "%)!"
                                                                                                                                        elseif PetTauntOn() then
                                                                                                                                            warningMsg = "PET TAUNT IS ON – DISABLE IT!"
                                                                                                                                            elseif PetPassive() then
                                                                                                                                                warningMsg = "PET IS PASSIVE – CHANGE STANCE!"
                                                                                                                                                end
                                                                                                                                                end

                                                                                                                                                if warningMsg then ShowWarning(warningMsg) else HideWarning() end
                                                                                                                                                    end)

                                                                                                            -------------------------------------------------
                                                                                                            -- Init + Slash Commands
                                                                                                            -------------------------------------------------
                                                                                                            local init = CreateFrame("Frame")
                                                                                                            init:RegisterEvent("PLAYER_ENTERING_WORLD")
                                                                                                            init:SetScript("OnEvent", function()
                                                                                                            RestoreHUDPosition()
                                                                                                            UpdateHUDVisual()
                                                                                                            print("|cffffd700PetChecker v" .. VERSION .. " loaded – HUD Evolution Stable.|r")
                                                                                                            end)

                                                                                                            PetChecker_UpdateHUDText = UpdateHUDText
                                                                                                            PetChecker_UpdateHUDVisual = UpdateHUDVisual
                                                                                                            PetChecker_RestoreHUDPosition = RestoreHUDPosition
                                                                                                            PetChecker_UpdateColors = PetChecker_UpdateColors

                                                                                                            SLASH_PETCHECKER1, SLASH_PETCHECKER2 = "/petchecker", "/pc"
                                                                                                            SlashCmdList["PETCHECKER"] = function(msg)
                                                                                                            msg = string.lower(msg or "")
                                                                                                            if msg == "reset" then
                                                                                                                PetCheckerDB.hudPoint = {"CENTER", "CENTER", 0, -200}
                                                                                                                RestoreHUDPosition()
                                                                                                                UpdateHUDText()
                                                                                                                print("|cffffd700PetChecker HUD reset.|r")
                                                                                                                elseif msg == "options" then
                                                                                                                    if Settings and Settings.OpenToCategory then
                                                                                                                        Settings.OpenToCategory("PetChecker v2.9.10.29.2025")
                                                                                                                        elseif InterfaceOptionsFrame_OpenToCategory then
                                                                                                                            InterfaceOptionsFrame_OpenToCategory("PetChecker v2.9.10.29.2025")
                                                                                                                            end
                                                                                                                            else
                                                                                                                                print("|cffffd700PetChecker v" .. VERSION .. " running.|r")
                                                                                                                                end
                                                                                                                                end

------------------------------------------------------------
-- HunterTrapsBar V2 - Core/Commands.lua
-- /htb commands
------------------------------------------------------------

local HTB = HunterTrapsBar
if not HTB then return end

StaticPopupDialogs["HTB_CONFIRM_PANIC"] = {
    text = "Do you really want to fully reset HunterTrapsBar?\n\nThis will reset position, scale, all settings, and reload the UI.",
    button1 = YES,
    button2 = NO,
    OnAccept = function()
        -- Reset runtime state
        if HTB.DB then
            HTB.DB.scale = 1.0
            HTB.DB.point = nil
        end

        if HTB.Bar then
            HTB.Bar:SetScale(1.0)
            HTB.Bar:ClearAllPoints()
            HTB.Bar:SetPoint("CENTER", UIParent, "CENTER", 0, -120)
        end

        -- Wipe SavedVariables
        HunterTrapsBarDB = nil
        ReloadUI()
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    preferredIndex = STATICPOPUP_NUMDIALOGS
}

local function IsHunter()
    local _, class = UnitClass("player")
    return class == "HUNTER"
end

local function EnsureDefaults()
    if not HTB.DB then HTB.DB = {} end

    if HTB.DB.locked == nil then HTB.DB.locked = true end
    if HTB.DB.hideBorderWhenLocked == nil then HTB.DB.hideBorderWhenLocked = false end
    if HTB.DB.scale == nil then HTB.DB.scale = 1 end
end

local function Print(msg)
    print("|cff33ff99HTB|r", msg)
end

local function ResetPosition()
    HTB.DB.point = nil
    if HTB.Bar then
        HTB.Bar:ClearAllPoints()
        HTB.Bar:SetPoint("CENTER", UIParent, "CENTER", 0, -120)
    end
end

local function SetScale(arg)
    local n = tonumber(arg)
    if not n or n <= 0 then
        Print("Usage: /htb scale <number>")
        return
    end
    HTB.DB.scale = n
    if HTB.ApplyLayout then HTB:ApplyLayout() end
    Print("Scale set to " .. n)
end

SLASH_HUNTERTRAPSBAR1 = "/huntertrapsbar"
SLASH_HUNTERTRAPSBAR2 = "/htb"

SlashCmdList["HUNTERTRAPSBAR"] = function(msg)
    if not IsHunter() then
        Print("HunterTrapsBar is only available to Hunters.")
        return
    end

    EnsureDefaults()

    msg = (msg or ""):lower()
    local cmd, arg = msg:match("^(%S+)%s*(.-)$")

    if cmd == "lock" then
        HTB.DB.locked = true
        if HTB.ApplyLayout then HTB:ApplyLayout() end
        Print("Locked.")

    elseif cmd == "unlock" then
        HTB.DB.locked = false
        if HTB.ApplyLayout then HTB:ApplyLayout() end
        Print("Unlocked (drag enabled).")

    elseif cmd == "border" then
        HTB.DB.hideBorderWhenLocked = false
        if HTB.UpdateBarBorderVisibility then HTB:UpdateBarBorderVisibility() end
        Print("Bar border will always be shown.")

    elseif cmd == "noborder" then
        HTB.DB.hideBorderWhenLocked = true
        if HTB.UpdateBarBorderVisibility then HTB:UpdateBarBorderVisibility() end
        Print("Bar border will hide when locked.")

    elseif cmd == "reset" then
        ResetPosition()
        if HTB.ApplyLayout then HTB:ApplyLayout() end
        Print("Position reset.")

    elseif cmd == "panic" then
        StaticPopup_Show("HTB_CONFIRM_PANIC")
     
    elseif cmd == "scale" then
        SetScale(arg)

    else
        Print("Commands:")
        Print("/htb lock         - Lock the bar")
        Print("/htb unlock       - Unlock and move the bar")
        Print("/htb border       - Always show borders")
        Print("/htb noborder     - Hide borders when locked")
        Print("/htb scale <n>    - Set bar scale (size)")
        Print("/htb reset        - Reset position to center")
        Print("/htb panic        - Full reset (position, scale, settings, reload UI)")
    end
end

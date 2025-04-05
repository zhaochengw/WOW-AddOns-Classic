if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then return end

local SafeQueue = SafeQueue

local CreateFrame = CreateFrame
local ENTER_BATTLE = ENTER_BATTLE
local GetBattlefieldStatus = GetBattlefieldStatus
local GetMapInfo = C_Map.GetMapInfo
local GetMaxBattlefieldID = GetMaxBattlefieldID
local InCombatLockdown = InCombatLockdown
local PVPReadyDialog = PVPReadyDialog
local PlaySound = PlaySound
local REQUIRES_RELOAD = REQUIRES_RELOAD
local SOUNDKIT = SOUNDKIT
local StaticPopupSpecial_Hide = StaticPopupSpecial_Hide
local StaticPopup_Hide = StaticPopup_Hide
local format = format
local hooksecurefunc = hooksecurefunc
local issecurevariable = issecurevariable

local ALTERAC_VALLEY = GetMapInfo(1459).name
local WARSONG_GULCH = GetMapInfo(1460).name
local ARATHI_BASIN = GetMapInfo(1461).name

local BATTLEGROUND_COLORS = {
    default = "ffd100",
    [ALTERAC_VALLEY] = "007fff",
    [WARSONG_GULCH] = "00ff00",
    [ARATHI_BASIN] = "ffd100",
}

if PVPReadyDialog then
    PVPReadyDialog:SetHeight(120)
    -- add a minimize button
    local hideButton = CreateFrame("Button", nil, PVPReadyDialog, "UIPanelCloseButton")
    hideButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-HideButton-Up")
    hideButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-HideButton-Down")
    hideButton:SetPoint("TOPRIGHT", PVPReadyDialog, "TOPRIGHT", -3, -3)
    hideButton:SetScript("OnHide", function() PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON) end)
else
    -- Classic Era
    hooksecurefunc("StaticPopup_Show", function(name, _,_, i)
        if name ~= "CONFIRM_BATTLEFIELD_ENTRY" then return end
        SafeQueue.battlefieldId = i
        SafeQueue:ShowPopup()
    end)
end

SafeQueue:RegisterEvent("ADDON_ACTION_FORBIDDEN")

function SafeQueue:ADDON_ACTION_FORBIDDEN(_, func)
    if (not self:IsVisible()) then return end
    if func == "AcceptBattlefieldPort()" then self.popupTainted = true end
    if func == "func()" then self.minimapTainted = true end
    if (not self.popupTainted) or (not self.minimapTainted) then return end
    StaticPopup_Hide("ADDON_ACTION_FORBIDDEN")
    self:SetMacroText()
end

function SafeQueue:HideBlizzardPopup()
    if PVPReadyDialog then
        StaticPopupSpecial_Hide(PVPReadyDialog)
    else
        StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY")
    end
end

SafeQueue:SetScript("OnShow", function(self)
    if (not self.battlefieldId) then return end
    if InCombatLockdown() then
        self.showPending = true
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
        return
    end

    local status, battleground = GetBattlefieldStatus(self.battlefieldId)

    if status ~= "confirm" then return end

    self:HideBlizzardPopup()

    self.showPending = nil
    self.hidePending = nil

    self:SetExpiresText()
    self.SubText:SetText(format("|cff%s%s|r", self.color, battleground))
    local color = self.color and self.color.rgb
    if color then self.SubText:SetTextColor(color.r, color.g, color.b) end

    self:SetMacroText()
end)

SafeQueue:SetScript("OnHide", function(self)
    self.battleground = nil
    self.battlefieldId = nil
    self.EnterButton:SetAttribute("macrotext", "")
    self.EnterButton:SetText(ENTER_BATTLE)
end)

function SafeQueue:ShowPopup()
    local battlefieldId = self.battlefieldId
    if (not battlefieldId) then return end
    local status, battleground = GetBattlefieldStatus(battlefieldId)
    if status ~= "confirm" then return end
    self.battleground = battleground
    self.color = BATTLEGROUND_COLORS[battleground] or BATTLEGROUND_COLORS.default
    self:SetExpiresText()
    if InCombatLockdown() then
        self.showPending = true
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
        return
    end
    self:Show()
end

function SafeQueue:HidePopup()
    self:HideBlizzardPopup()
    if InCombatLockdown() then
        self.hidePending = true
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
        return
    end
    self:Hide()
end

function SafeQueue:PLAYER_REGEN_ENABLED()
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
    if self.hidePending then self:Hide() end
    if self.showPending then self:Show() end
end

local function GetDropDownListEnterButton(battlefieldId)
    local index = -1
    for i = 1, GetMaxBattlefieldID() do
        local status = GetBattlefieldStatus(i)
        if status ~= "none" then index = index + 3 end
        if i == battlefieldId then return "DropDownList1Button" .. index end
    end
end

function SafeQueue:SetMacroText()
    if InCombatLockdown() then return end
    if (not self.battlefieldId) then return end
    if (not issecurevariable("CURRENT_BATTLEFIELD_QUEUES")) then self.popupTainted = true end
    if self.popupTainted and self.minimapTainted then
        self.EnterButton:SetText(REQUIRES_RELOAD)
        self.EnterButton:SetAttribute("macrotext", "/reload")
    else
        local macrotext = "/click PVPReadyDialogEnterBattleButton\n"
        local button = GetDropDownListEnterButton(self.battlefieldId)
        if button then
            macrotext = macrotext .. "/click MiniMapBattlefieldFrame RightButton\n/click " .. button
        end
        self.EnterButton:SetAttribute("macrotext", macrotext)
    end
end


-- SafeQueue by Jordon

local addonName, addon = ...

local C_Map = C_Map
local CreateFrame = CreateFrame
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
local ENTER_BATTLE = ENTER_BATTLE
local GetBattlefieldPortExpiration = GetBattlefieldPortExpiration
local GetBattlefieldStatus = GetBattlefieldStatus
local GetBattlefieldTimeWaited = GetBattlefieldTimeWaited
local GetMaxBattlefieldID = GetMaxBattlefieldID
local GetTime = GetTime
local InCombatLockdown = InCombatLockdown
local MiniMapBattlefieldDropDown = MiniMapBattlefieldDropDown
local PLAYER = PLAYER
local PVPReadyDialog = PVPReadyDialog
local SecondsToTime = SecondsToTime
local StaticPopup_Visible = StaticPopup_Visible
local TOOLTIP_UPDATE_TIME = TOOLTIP_UPDATE_TIME
local UnitInBattleground = UnitInBattleground
local hooksecurefunc = hooksecurefunc

local SafeQueue = CreateFrame("Frame", "SafeQueue")
SafeQueue:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
SafeQueue:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
SafeQueue.timer = TOOLTIP_UPDATE_TIME

local EXPIRES_FORMAT = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE and "Expires in " or "SafeQueue expires in ") ..
    "|cf%s%s|r"
local ANNOUNCE_FORMAT = "Queue popped %s"

local function GetTimerText(battlefieldId)
    if (not battlefieldId) then return end
    local secs = GetBattlefieldPortExpiration(battlefieldId)
    if secs <= 0 then secs = 1 end
    local color
    if secs > 20 then
        color = "f20ff20"
    elseif secs > 10 then
        color = "fffff00"
    else
        color = "fff0000"
    end
    return EXPIRES_FORMAT:format(color, SecondsToTime(secs))
end

if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
    SafeQueue:SetScript("OnUpdate", function(self, elapsed)
        if (not PVPReadyDialog:IsShown()) or (not PVPReadyDialog.activeIndex) then return end
        local timer = self.timer
        timer = timer - elapsed
        if timer <= 0 then
            PVPReadyDialog.label:SetText(GetTimerText(PVPReadyDialog.activeIndex))
        end
        self.timer = timer
    end)

    hooksecurefunc("PVPReadyDialog_Display", function(self)
        self.leaveButton:Hide()
        self.enterButton:ClearAllPoints();
        self.enterButton:SetPoint("BOTTOM", self, "BOTTOM", 0, 25)
    end)
else
    local ALTERAC_VALLEY = C_Map.GetMapInfo(1459).name
    local WARSONG_GULCH = C_Map.GetMapInfo(1460).name
    local ARATHI_BASIN = C_Map.GetMapInfo(1461).name
    local COLORS = {
        [ALTERAC_VALLEY] = { r = 0, g = 0.5, b = 1 },
        [WARSONG_GULCH] = { r = 0, g = 1, b = 0 },
        [ARATHI_BASIN] = { r = 1, g = 0.82, b = 0 },
    }
    SafeQueue.popup = SafeQueuePopup
    SafeQueue:RegisterEvent("PLAYER_REGEN_ENABLED")

    function SafeQueue:Create(battlefieldId)
        if SafeQueue:FindPopup(battlefieldId) then return end
        local status, battleground = GetBattlefieldStatus(battlefieldId)
        if status ~= "confirm" then return end
        if InCombatLockdown() then
            self.createPopup = battlefieldId
            return
        end
        if StaticPopup_Visible("CONFIRM_BATTLEFIELD_ENTRY") then
            StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY")
        end
        self.createPopup = nil
        self.popup.hidePopup = nil
        self.popup.battleground = battleground
        self.popup.battlefieldId = battlefieldId
        self.popup.text:SetText(GetTimerText(battlefieldId))
        self.popup.SubText:SetText(battleground)
        local color = COLORS[battleground]
        if color then self.popup.SubText:SetTextColor(color.r, color.g, color.b) end
        self.popup.EnterButton:SetAttribute("macrotext", "/click MiniMapBattlefieldFrame RightButton\n" ..
            "/click DropDownList1Button" .. ((battlefieldId * 3) - 1))
        self.popup:Show()
    end

    function SafeQueue:FindPopup(battlefieldId)
        if self.popup:IsVisible() and self.popup.battlefieldId == battlefieldId then
            return self.popup
        end
    end

    function SafeQueue:PLAYER_REGEN_ENABLED()
        if self.popup.hidePopup then self.popup:Hide() end
        if self.createPopup then self:Create(self.createPopup) end
    end

    SafeQueue:SetScript("OnUpdate", function(self, elapsed)
        local popup = self.popup
        if (not popup:IsVisible()) then return end
        local timer = self.timer
        timer = timer - elapsed
        if timer <= 0 then
            if (not popup.battlefieldId) or GetBattlefieldStatus(popup.battlefieldId) ~= "confirm" then
                popup:Hide()
                return
            end
            popup.text:SetText(GetTimerText(popup.battlefieldId))
        end
        self.timer = timer
    end)

    hooksecurefunc("StaticPopup_Show", function(name, _, _, i)
        if name ~= "CONFIRM_BATTLEFIELD_ENTRY" then return end
        if InCombatLockdown() and (not SafeQueue:FindPopup(i)) then return end
        StaticPopup_Hide(name)
    end)
end

SafeQueue.queues = {}

function SafeQueue:Print(message)
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99SafeQueue|r: " .. message)
end

function SafeQueue:UPDATE_BATTLEFIELD_STATUS()
    for i = 1, GetMaxBattlefieldID() do
        local popup = SafeQueue.FindPopup and SafeQueue:FindPopup(i)
        local status = GetBattlefieldStatus(i)
        if status == "confirm" then
            if self.queues[i] then
                local secs = GetTime() - self.queues[i]
                local message
                if secs <= 0 then
                    message = "instantly!"
                else
                    message = "after " .. SecondsToTime(secs)
                end
                self:Print(ANNOUNCE_FORMAT:format(message))
                self.queues[i] = nil
            end
            if (not popup) and self.Create then
                self:Create(i)
            end
        else
            if status == "queued" then
                self.queues[i] = self.queues[i] or GetTime() - (GetBattlefieldTimeWaited(i) / 1000)
            end
            if popup then
               popup:Hide()
            end
        end
    end
end

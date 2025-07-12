local bgId
local updateFrame
local proposalTimeLeft = 40
local queues = {}
local dungeonQueuedTime
local soundPlayed
local isPveQueueActive

if not BetterBlizzQueueDB then
    BetterBlizzQueueDB = {}
end
if BetterBlizzQueueDB.queueTimerAudio == nil then
    BetterBlizzQueueDB.queueTimerAudio = true
end
if BetterBlizzQueueDB.queueTimerWarning == nil then
    BetterBlizzQueueDB.queueTimerWarning = true
end
if BetterBlizzQueueDB.hideOtherTimers == nil then
    BetterBlizzQueueDB.hideOtherTimers = true
end

local function StopUpdateFrame()
    if updateFrame then
        updateFrame:Hide()
        soundPlayed = false
    end
end

local function CreateCustomFontStrings(dialog)
    if dialog.queueTimerLabels then return end
    local maxWidth
    maxWidth = dialog:GetWidth()
    dialog.customLabel = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    dialog.customLabel:SetPoint("TOP", dialog.label, "TOP", 0, 0)
    dialog.customLabel:SetText("Queue expires in")
    local font, size, outline = dialog.customLabel:GetFont()
    dialog.customLabel:SetFont(font, 15, "OUTLINE")
    dialog.customLabel:SetWidth(maxWidth)

    dialog.timerLabel = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    dialog.timerLabel:SetPoint("TOP", dialog.customLabel, "BOTTOM", 0, -5)
    local font, size, outline = dialog.timerLabel:GetFont()
    dialog.timerLabel:SetFont(font, 24, "OUTLINE")
    dialog.timerLabel:SetWidth(maxWidth)

    dialog.bgLabel = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    dialog.bgLabel:SetPoint("TOP", dialog.timerLabel, "BOTTOM", 0, -4)
    local font, size, outline = dialog.bgLabel:GetFont()
    dialog.bgLabel:SetFont(font, 15, "OUTLINE")
    dialog.bgLabel:SetWidth(maxWidth)

    dialog.statusTextLabel = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    dialog.statusTextLabel:SetPoint("TOP", dialog.bgLabel, "BOTTOM", 0, -3)
    local font, size, outline = dialog.statusTextLabel:GetFont()
    dialog.statusTextLabel:SetFont(font, 11, "OUTLINE")
    dialog.statusTextLabel:SetWidth(maxWidth)

    dialog.queueTimerLabels = true
end

local function SetExpiresText(timeRemaining, dialog, pvp)
    local secs = timeRemaining > 0 and timeRemaining or 1
    local color = secs > 20 and "20ff20" or secs > 10 and "ffff00" or "ff0000"
    local timerText = format("|cff%s%s|r", color, SecondsToTime(secs))

    CreateCustomFontStrings(dialog)
    dialog.label:SetText("")
    dialog.instanceInfo:SetAlpha(0)
    dialog.timerLabel:SetText(timerText)
    if dialog.instanceInfo.name and (dialog.instanceInfo:IsShown() or pvp) then
        dialog.bgLabel:SetText(dialog.instanceInfo.name:GetText())
        dialog.statusTextLabel:SetText(dialog.instanceInfo.statusText:GetText())
    else
        dialog.bgLabel:SetText("")
        dialog.statusTextLabel:SetText("")
    end
end

local function OnUpdate(elapsed)
    if bgId then
        updateFrame.timer = updateFrame.timer - elapsed

        if BetterBlizzQueueDB.queueTimerWarning then
            if GetBattlefieldPortExpiration(bgId) == 6 and not soundPlayed then
                PlaySoundFile(567458, "master")
                C_Timer.After(0.1, function()
                    PlaySoundFile(567458, "master")
                end)
                C_Timer.After(0.2, function()
                    PlaySoundFile(567458, "master")
                end)
                soundPlayed = true
            end
        end

        if updateFrame.timer <= 0 then
            if GetBattlefieldStatus(bgId) ~= "confirm" then
                StopUpdateFrame()
                return
            end
            SetExpiresText(GetBattlefieldPortExpiration(bgId), PVPReadyDialog, true)
            updateFrame.timer = 1
        end
    elseif proposalTimeLeft then
        proposalTimeLeft = proposalTimeLeft - elapsed

        -- Play the sound when the timer reaches 5 seconds
        if BetterBlizzQueueDB.queueTimerWarning then
            if proposalTimeLeft <= 6 and not soundPlayed then
                PlaySoundFile(567458, "master")
                C_Timer.After(0.1, function()
                    PlaySoundFile(567458, "master")
                end)
                C_Timer.After(0.2, function()
                    PlaySoundFile(567458, "master")
                end)
                soundPlayed = true
            end
        end

        if proposalTimeLeft <= 0 then
            proposalTimeLeft = 40
        end

        SetExpiresText(proposalTimeLeft, LFGDungeonReadyDialog)
    end
end

local function StartUpdateFrame()
    if not updateFrame then
        updateFrame = CreateFrame("Frame")
        updateFrame.timer = 1
        updateFrame:SetScript("OnUpdate", function(_, elapsed)
            OnUpdate(elapsed)
        end)
    end
    updateFrame:Show()
end

local function Print(message)
    DEFAULT_CHAT_FRAME:AddMessage("|A:gmchat-icon-blizz:16:16|a |cff00c0ffQueueTimer:|r " .. message)
    if BetterBlizzQueueDB.queueTimerAudio then
        PlaySoundFile(567458, "master")
    end
end

local function CaptureDungeonQueuedTime()
    local hasData, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, queuedTime = GetLFGQueueStats(LE_LFG_CATEGORY_LFD)
    if hasData and queuedTime > 0 then
        dungeonQueuedTime = queuedTime
    end
end

local function SaveQueuePopTime()
    BetterBlizzQueueDB.pveQueuePopTime = GetTime()
end

-- Function to recalculate proposalTimeLeft if the user reloads or crosses a loading screen
local function RecalculateProposalTimeLeft()
    if BetterBlizzQueueDB.pveQueuePopTime then
        -- Calculate how much time has passed since the queue popped
        local timeElapsed = GetTime() - BetterBlizzQueueDB.pveQueuePopTime
        proposalTimeLeft = proposalTimeLeft - timeElapsed

        -- Ensure the timer doesn't go below zero
        if proposalTimeLeft < 0 or proposalTimeLeft > 40 then
            proposalTimeLeft = 40
        end
    end
end

local function HandleDungeonReadyDialog()
    local proposalExists, _, _, _, _, _, _, hasResponded = GetLFGProposal()

    if proposalExists and not hasResponded then
        -- Set initial proposalTimeLeft or recalculate if the UI was reloaded
        if not BetterBlizzQueueDB.pveQueuePopTime then
            proposalTimeLeft = 40
        else
            RecalculateProposalTimeLeft()
        end

        SetExpiresText(proposalTimeLeft, LFGDungeonReadyDialog)
        isPveQueueActive = true
        StartUpdateFrame()

        -- Save the queue pop time and proposal time
        SaveQueuePopTime()

        if dungeonQueuedTime then
            local timeWaited = GetTime() - dungeonQueuedTime
            Print(timeWaited < 1 and "Dungeon queue popped instantly!" or format("Dungeon queue popped after %s", SecondsToTime(timeWaited)))
        else
            Print("Dungeon queue popped, but time could not be determined.")
        end
        dungeonQueuedTime = nil
    end
end

local function UpdateBattlefieldStatus()
    local isConfirm
    for i = 1, GetMaxBattlefieldID() do
        local status = GetBattlefieldStatus(i)
        if status == "queued" then
            queues[i] = queues[i] or GetTime() - (GetBattlefieldTimeWaited(i) / 1000)
        elseif status == "confirm" then
            if queues[i] then
                local secs = GetTime() - queues[i]
                Print(secs < 1 and "Queue popped instantly!" or format("Queue popped after %s", SecondsToTime(secs)))
                queues[i] = nil
            end
            isConfirm = true
        else
            queues[i] = nil
        end
    end

    if not isConfirm and not isPveQueueActive then
        bgId = nil
        StopUpdateFrame()
    end
end

C_Timer.After(2, function()
    if C_AddOns.IsAddOnLoaded("SafeQueue") then
        C_Timer.After(2, function()
            DEFAULT_CHAT_FRAME:AddMessage("|A:gmchat-icon-blizz:16:16|a |cff00c0ffQueueTimer:|r SafeQueue is enabled, turn it off to use BetterBlizzQueue.")
        end)
        return
    elseif BetterBlizzFrames then
        C_Timer.After(2, function()
            DEFAULT_CHAT_FRAME:AddMessage("|A:gmchat-icon-blizz:16:16|a |cff00c0ffQueueTimer:|r BetterBlizzQueue is a part of BetterBlizzFrames. You can disable this addon and instead use it directly in BetterBlizzFrames: /bbf -> Queue Timer.")
        end)
        return
    end
end)

if PVPReadyDialog_Display then
    hooksecurefunc("PVPReadyDialog_Display", function(_, i)
        bgId = i
        StartUpdateFrame()
        SetExpiresText(GetBattlefieldPortExpiration(bgId), PVPReadyDialog, true)
    end)
end

local function HideOtherTimers()
    if not BetterBlizzQueueDB.hideOtherTimers then return end
    -- Hide existing timer bars (such as BigWigs)
    local children = {LFGDungeonReadyPopup:GetChildren()}
    if children then
        for i, child in ipairs(children) do
            local objType = child:GetObjectType()
            if objType and objType == "StatusBar" then
                child:Hide()
            end
        end
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("LFG_PROPOSAL_SHOW")
frame:RegisterEvent("LFG_PROPOSAL_SUCCEEDED")
frame:RegisterEvent("LFG_PROPOSAL_DONE")
frame:RegisterEvent("LFG_PROPOSAL_FAILED")
frame:RegisterEvent("LFG_QUEUE_STATUS_UPDATE")
frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
frame:SetScript("OnEvent", function(_, event)
    if event == "LFG_PROPOSAL_SHOW" then
        HandleDungeonReadyDialog()
        HideOtherTimers()
    elseif event == "LFG_PROPOSAL_SUCCEEDED" or event == "LFG_PROPOSAL_FAILED" or event == "LFG_PROPOSAL_DONE" then
        isPveQueueActive = false
        StopUpdateFrame()
        HideOtherTimers()
        -- Clear saved data once the proposal is accepted or failed
        BetterBlizzQueueDB.pveQueuePopTime = nil
        proposalTimeLeft = 40
    elseif event == "LFG_QUEUE_STATUS_UPDATE" then
        CaptureDungeonQueuedTime()
    elseif event == "UPDATE_BATTLEFIELD_STATUS" then
        UpdateBattlefieldStatus()
    end
end)

local BetterBlizzQueueSettingsFrame
local function CreateSettingsFrame()
    local frame = CreateFrame("Frame", "BetterBlizzQueueSettingsFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(220, 127)
    frame:SetPoint("CENTER", UIParent, "CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:Hide()

    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.title:SetPoint("CENTER", frame.TitleBg, "CENTER", 0, 0)
    frame.title:SetText("|A:gmchat-icon-blizz:16:16|a Better|cff00c0ffBlizz|rQueue Settings")

    local queueTimerAudioCheckBox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    queueTimerAudioCheckBox:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -30)
    queueTimerAudioCheckBox.text:SetText("Enable sound alert")
    queueTimerAudioCheckBox:SetChecked(BetterBlizzQueueDB.queueTimerAudio)

    queueTimerAudioCheckBox:SetScript("OnClick", function(self)
        BetterBlizzQueueDB.queueTimerAudio = self:GetChecked()
    end)

    local queueTimerWarningCheckBox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    queueTimerWarningCheckBox:SetPoint("TOPLEFT", queueTimerAudioCheckBox, "BOTTOMLEFT", 0, 3)
    queueTimerWarningCheckBox.text:SetText("Enable 5 sec warning sound")
    queueTimerWarningCheckBox:SetChecked(BetterBlizzQueueDB.queueTimerWarning)

    queueTimerWarningCheckBox:SetScript("OnClick", function(self)
        BetterBlizzQueueDB.queueTimerWarning = self:GetChecked()
    end)

    local hideOtherTimersCheckBox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    hideOtherTimersCheckBox:SetPoint("TOPLEFT", queueTimerWarningCheckBox, "BOTTOMLEFT", 0, 3)
    hideOtherTimersCheckBox.text:SetText("Hide other timers like BigWigs")
    hideOtherTimersCheckBox:SetChecked(BetterBlizzQueueDB.hideOtherTimers)

    hideOtherTimersCheckBox:SetScript("OnClick", function(self)
        BetterBlizzQueueDB.hideOtherTimers = self:GetChecked()
    end)

    return frame
end

SLASH_BBQ1 = "/bbq"
SlashCmdList["BBQ"] = function()
    if not BetterBlizzQueueSettingsFrame then
        BetterBlizzQueueSettingsFrame = CreateSettingsFrame()
    end
    if BetterBlizzQueueSettingsFrame:IsShown() then
        BetterBlizzQueueSettingsFrame:Hide()
    else
        BetterBlizzQueueSettingsFrame:Show()
    end
end
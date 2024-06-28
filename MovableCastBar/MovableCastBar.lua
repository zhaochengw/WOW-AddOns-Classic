local addonName, addonTable = ...

-- Default language texts
local L = {
    ["LOCK_CAST_BAR"] = "Lock Cast Bar",
    ["CENTER"] = "Center",
    ["RESET"] = "Reset",
}

-- Adjust text based on client language
local locale = GetLocale()
if locale == "zhCN" or locale == "zhTW" then
    L["LOCK_CAST_BAR"] = "锁定施法条"
    L["CENTER"] = "居中"
    L["RESET"] = "重置"
end

-- Default values
local isLocked = true
local bOriginal = true  -- Set to false for a new style
local MovableCastBarPosition = {"BOTTOM", UIParent, "BOTTOM", 0, 200}

-- Create a frame for dragging
local draggableFrame = CreateFrame("Frame", "MovableCastBarFrame", UIParent)
draggableFrame:SetSize(200, 20)  -- Adjust the size as necessary
draggableFrame:ClearAllPoints()
draggableFrame:SetPoint(unpack(MovableCastBarPosition))
draggableFrame:EnableMouse(true)
draggableFrame:SetMovable(true)
draggableFrame:RegisterForDrag("LeftButton")
draggableFrame:SetScript("OnDragStart", function(self)
    if not isLocked then
        self:StartMoving()
    end
end)
draggableFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    -- Save position
    local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
    local relativeToName = relativeTo and relativeTo:GetName() or "UIParent"
    MovableCastBarPosition = {point, relativeToName, relativePoint, xOfs, yOfs}
    --print("Position saved:", point, relativeToName, relativePoint, xOfs, yOfs)
end)

-- Create a background for better visibility (optional)
draggableFrame.bg = draggableFrame:CreateTexture(nil, "BACKGROUND")
draggableFrame.bg:SetAllPoints(true)
draggableFrame.bg:SetColorTexture(0, 0, 0, 0.5)  -- Semi-transparent black

-- Function to properly attach the CastBarFrame to the draggableFrame
local function AttachCastBarFrame()
    CastingBarFrame:SetParent(UIParent)
    CastingBarFrame:ClearAllPoints()
    CastingBarFrame:SetPoint("CENTER", draggableFrame, "CENTER")
end

-- Delayed attachment function using OnUpdate to ensure UI elements are fully loaded
local function DelayedAttachCastBarFrame()
    local frame = CreateFrame("Frame")
    frame:SetScript("OnUpdate", function(self, elapsed)
        if self.timer == nil then self.timer = 0 end
        self.timer = self.timer + elapsed
        if self.timer > 1 then
            AttachCastBarFrame()
            self:SetScript("OnUpdate", nil)
        end
    end)
end

-- Center the cast bar on the screen
local function CenterCastBar(horizontalOnly)
    local yOfs = 0
    if horizontalOnly then
        local top = draggableFrame:GetTop()
        local screenHeight = UIParent:GetHeight()
        yOfs = top - screenHeight / 2 - (draggableFrame:GetHeight() / 2)
    end
    draggableFrame:ClearAllPoints()
    draggableFrame:SetPoint("CENTER", UIParent, "CENTER", 0, yOfs)
    MovableCastBarPosition = {"CENTER", UIParent, "CENTER", 0, yOfs}
    -- Update CastBarFrame position directly on UIParent
    AttachCastBarFrame()
    print("Cast bar centered at screen center.")
end

-- Reset the cast bar to default settings
local function ResetCastBar()
    -- Reset position
    CenterCastBar(false)
    -- Reset lock state
    isLocked = false
    draggableFrame:EnableMouse(true)
    draggableFrame.bg:Show()
    MovableCastBarLocked = false
    print("Cast bar reset to default settings.")
end

-- Restore saved position on login/reload
draggableFrame:RegisterEvent("PLAYER_LOGIN")
draggableFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then

       -- 设置 draggableFrame 的位置
        draggableFrame:ClearAllPoints()
        draggableFrame:SetPoint(unpack(MovableCastBarPosition))

        -- 延迟设置 CastingBarFrame 的位置
        DelayedAttachCastBarFrame()  -- Ensure CastBarFrame is attached after positioning with a delay
        if MovableCastBarLocked ~= nil then
            isLocked = MovableCastBarLocked
            if isLocked then
                draggableFrame:EnableMouse(false)
                draggableFrame.bg:Hide()
            else
                draggableFrame:EnableMouse(true)
                draggableFrame.bg:Show()
            end
        end
    end
end)

-- Function to update lock state based on checkbox
local function UpdateLockState()
    if isLocked then
        draggableFrame:EnableMouse(false)
        draggableFrame.bg:Hide()
        draggableFrame:Hide()  -- 在勾选锁定时隐藏 draggableFrame
    else
        draggableFrame:EnableMouse(true)
        draggableFrame.bg:Show()
        draggableFrame:Show()  -- 取消勾选锁定时显示 draggableFrame
    end
end


-- System Cast Bar Enhancement (from https://bbs.nga.cn/read.php?tid=14573258 by 简繁)
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")

frame:SetScript("OnEvent", function(self, event, ...)
    if type(self[event]) == "function" then return self[event](self, ...) end
end)

function frame:ADDON_LOADED()
    local function CreateFontString(self)
        local parent = self:GetParent()
        if self:IsForbidden() then return end
        self.CooldownText = self:CreateFontString(nil)
        self.CooldownText:SetFont(SystemFont_Outline_Small:GetFont(), 14, "OUTLINE")  -- Cast time text size
        self.CooldownText:SetWidth(100)
        self.CooldownText:SetJustifyH("RIGHT")
        self.CooldownText:SetPoint("TOP", self, "RIGHT", 10, 8)  -- Cast bar time position
        if parent.unit == 'target' or parent.unit == 'focus' then
            self.CooldownText:SetPoint("TOP", self, "RIGHT", 10, 8)  -- Target and focus time position
        end
        local fontFile, fontSize, fontFlags = self.Text:GetFont()
        self.Text:SetFont(fontFile, fontSize - -2, fontFlags)  -- Cast bar spell name size
    end

    -- Modify player cast bar
    if not bOriginal then
        CastingBarFrame:SetHeight(20)  -- Cast bar height
        CastingBarFrame:SetWidth(300)  -- Cast bar width
        CastingBarFrame.Spark:SetHeight(60)  -- Cast bar spark height
        CastingBarFrame.Border:SetTexture(nil)  -- Disable original cast bar border
    else
        CastingBarFrame.Icon:SetPoint("RIGHT", CastingBarFrame, "LEFT", -10, 3)  -- Cast icon position
    end

    CastingBarFrame.Flash:SetTexture(nil)
    CastingBarFrame:SetFrameStrata("HIGH")  -- Cast bar frame strata
    CastingBarFrame.Icon:SetSize(25, 25)  -- Cast bar icon size
    CastingBarFrame.Icon:Show()  -- Show cast bar icon

    local function ShowCastingTimer(self, elapsed)
        if self:IsForbidden() then return end
        if self:GetParent():GetName():find("NamePlate%d") then return end
        if not self.CooldownText then
            CreateFontString(self)
            self.timer = 0
            if self:GetName() == "CastingBarFrame" then
                if not bOriginal then self.Text:SetPoint("TOP", 0, -1) end  -- Cast bar spell name position
            end
        end
        self.timer = self.timer + elapsed
        if self.timer > 0.1 then
            self.timer = 0
            if self.casting then
                self.CooldownText:SetText(format("%.1f/%.1f", max(self.value, 0), self.maxValue))
            elseif self.channeling then
                self.CooldownText:SetText(format("%.1f", max(self.value, 0)))
            else
                self.CooldownText:SetText("")
            end
        end
    end

    hooksecurefunc("CastingBarFrame_OnUpdate", ShowCastingTimer)

    hooksecurefunc("CastingBarFrame_OnEvent", function(self, event, ...)
        if self:IsForbidden() then return end
        if not self.hasRegisterCastingTimer then
            self.hasRegisterCastingTimer = true
            local func = self:GetScript("OnUpdate")
            if func ~= CastingBarFrame_OnUpdate then
                self:SetScript("OnUpdate", CastingBarFrame_OnUpdate)
            end
        end
    end)

    if CastingBarFrame then
        CastingBarFrame:HookScript("OnUpdate", ShowCastingTimer)
    end

    hooksecurefunc("MirrorTimerFrame_OnUpdate", function(self, elapsed)
        if self.paused then return end
        if not self.CooldownText then
            self.CooldownText = self:CreateFontString(nil)
            self.CooldownText:SetFont(SystemFont_Outline_Small:GetFont(), 8, "OUTLINE")
            self.CooldownText:SetWidth(100)
            self.CooldownText:SetJustifyH("RIGHT")
            self.CooldownText:SetPoint("RIGHT", self, "RIGHT", -100, 6)
            self.itimer = 0
        end
        self.itimer = self.itimer + elapsed
        if self.itimer > 0.5 then
            self.itimer = 0
            self.CooldownText:SetText(floor(self.value))
        end
    end)

    -- Cast delay (commented out)
    -- local lagmeter = CastingBarFrame:CreateTexture(nil,"OVERLAYER")
    -- lagmeter:SetHeight(CastingBarFrame:GetHeight())
    -- lagmeter:SetWidth(0)
    -- lagmeter:SetPoint("RIGHT", CastingBarFrame, "RIGHT", 0, 0)
    -- lagmeter:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    -- lagmeter:SetVertexColor(1,0.3,0)  -- red color

    -- hooksecurefunc(CastingBarFrame, "Show", function()
    --     down, up, lag = GetNetStats()
    --     local castingmin, castingmax = CastingBarFrame:GetMinMaxValues()
    --     local lagvalue = ( lag / 1000 ) / ( castingmax - castingmin )
    --     if lagvalue < 0 then
    --         lagvalue = 0
    --     elseif lagvalue > 1 then
    --         lagvalue = 1
    --     end
    --     lagmeter:SetWidth(CastingBarFrame:GetWidth() * lagvalue)
    -- end)
end

-- Create a panel for interface options
local panel = CreateFrame("Frame")
panel.name = "MovableCastBar"

local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("Movable and Enhanced Cast Bar")

-- Create lock/unlock checkbox
local lockCheckbox = CreateFrame("CheckButton", "MovableCastBarLockCheckbox", panel, "UICheckButtonTemplate")
lockCheckbox:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 10, -20)
getglobal(lockCheckbox:GetName() .. "Text"):SetText(L["LOCK_CAST_BAR"])
lockCheckbox:SetScript("OnClick", function(self)
    isLocked = self:GetChecked()
    MovableCastBarLocked = isLocked
    UpdateLockState()
end)

-- Set checkbox state on addon loaded
lockCheckbox:SetChecked(isLocked)

-- Create center button
local centerButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
centerButton:SetPoint("TOPLEFT", lockCheckbox, "BOTTOMLEFT", 0, -10)
centerButton:SetText(L["CENTER"])
centerButton:SetSize(80, 22)
centerButton:SetScript("OnClick", function()
    SlashCmdHandler("center")
end)

-- Create reset button
local resetButton = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
resetButton:SetPoint("LEFT", centerButton, "RIGHT", 10, 0)
resetButton:SetText(L["RESET"])
resetButton:SetSize(80, 22)
resetButton:SetScript("OnClick", function()
    SlashCmdHandler("reset")
end)

-- Register addon loaded event to update checkbox state
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
    if addon == addonName then
        lockCheckbox:SetChecked(isLocked)
        UpdateLockState()
    end
end)

InterfaceOptions_AddCategory(panel)

-- Slash command handler
local function SlashCmdHandler(msg, editBox)
    local command = strlower(msg)
    if command == "lock" then
        isLocked = true
        draggableFrame:EnableMouse(false)
        draggableFrame.bg:Hide()
        MovableCastBarLocked = true
        print("Cast bar position locked.")
    elseif command == "unlock" then
        isLocked = false
        draggableFrame:EnableMouse(true)
        draggableFrame.bg:Show()
        MovableCastBarLocked = false
        print("Cast bar position unlocked.")
    elseif command == "center" then
        CenterCastBar(true)
    elseif command == "reset" then
        ResetCastBar()
    else
        print("Usage: /castbar lock | unlock | center | reset")
    end
end

-- 在注册斜杠命令时使用 SlashCmdList
SLASH_MOVABLECASTBAR1 = "/castbar"
SlashCmdList["MOVABLECASTBAR"] = SlashCmdHandler

local _, ns = ...

-- Variables.
local mainFrame
local CUI
local buttons = {}

-- Constants.
local X_START = 6
local Y_START = -10
local X_SPACING = 220
local Y_SPACING = 20
local BUTTONS_PER_ROW = 3
local DUNGEON_RAID_SPACING = 40

-- Shows or hides the addon.
function ns:ToggleFrame()
    if mainFrame:IsVisible() then
        mainFrame:Hide()
    else
        mainFrame:Show()
    end
end

-- Called when a check button is clicked.
local function CheckButton_OnClick(self)
    ALCOptions.instances[self.instance] = not ALCOptions.instances[self.instance]
    ns:ToggleLogging()
end

-- Called when the close button is clicked.
local function CloseButton_OnClick()
    ns:ToggleFrame()
end

-- Called when the mouse is down on the frame.
local function MainFrame_OnMouseDown(self)
    mainFrame:StartMoving()
end

-- Called when the mouse has been released from the frame.
local function MainFrame_OnMouseUp(self)
    mainFrame:StopMovingOrSizing()
end

-- Called when the main frame hides.
local function MainFrame_OnHide(self)
    PlaySound(SOUNDKIT.IG_MAINMENU_CLOSE)
end

-- Called when the main frame shows.
local function MainFrame_OnShow(self)
    PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
end

-- Initializes all checkboxes.
local function InitCheckButtons()
    local fontInstance = CUI:GetFontNormal()

    local yNext = 0

    local function placeButtons(instanceTable, yStart)
        local index = 1
        for instanceID, instanceName in pairs(instanceTable) do
            -- Checkbuttons.
            local checkButton = CUI:CreateCheckButton(mainFrame, "AutoLoggerClassicCheckButton" .. index, {CheckButton_OnClick},
                                                      "Interface/Addons/AutoLoggerClassic/Media/CheckMark")
            local x = X_START + X_SPACING * ((index - 1) % BUTTONS_PER_ROW)
            local y = yStart - Y_SPACING * math.ceil(index / BUTTONS_PER_ROW)
            checkButton:SetPoint("TOPLEFT", x, y)
            checkButton.instance = instanceID
            checkButton:SetChecked(ALCOptions.instances[instanceID])
            buttons[#buttons + 1] = checkButton
            -- Strings.
            local string = mainFrame:CreateFontString(nil, "ARTWORK", fontInstance:GetName())
            string:SetPoint("LEFT", checkButton, "RIGHT", 5, 0)
            string:SetText(instanceName)
            index = index + 1

            yNext = yStart - Y_SPACING * math.ceil(index / BUTTONS_PER_ROW)
        end
    end

    do
        local raidString = mainFrame:CreateFontString(nil, "ARTWORK", CUI:GetFontBig():GetName())
        raidString:SetText("RAIDS")
        raidString:SetPoint("TOPLEFT", 3, Y_START - 20)
        placeButtons(ns.RAIDS, Y_START - 20)
    end

    if (ns.DUNGEONS) then
        local dungeonString = mainFrame:CreateFontString(nil, "ARTWORK", CUI:GetFontBig():GetName())
        dungeonString:SetText("DUNGEONS")
        dungeonString:SetPoint("TOPLEFT", 3, yNext - DUNGEON_RAID_SPACING)
        placeButtons(ns.DUNGEONS, yNext - DUNGEON_RAID_SPACING)
    end
end

function ns:InitMainFrame()
    CUI = LibStub("CloudUI-1.0")
    mainFrame = CreateFrame("Frame", "AutoLoggerClassicFrame", UIParent)
    mainFrame:SetMovable(true)
    mainFrame:SetPoint("CENTER")
    mainFrame:SetClampedToScreen(true)
    mainFrame:SetFrameStrata("MEDIUM")
    mainFrame:Hide()
    CUI:ApplyTemplate(mainFrame, CUI.templates.BorderedFrameTemplate)
    CUI:ApplyTemplate(mainFrame, CUI.templates.BackgroundFrameTemplate)
    mainFrame:HookScript("OnMouseDown", MainFrame_OnMouseDown)
    mainFrame:HookScript("OnMouseUp", MainFrame_OnMouseUp)
    mainFrame:HookScript("OnHide", MainFrame_OnHide)
    mainFrame:HookScript("OnShow", MainFrame_OnShow)
    tinsert(UISpecialFrames, "AutoLoggerClassicFrame")

    if ns:IsSoD() then
        mainFrame:SetSize(552, 132)
    elseif ns:IsClassic() then
        mainFrame:SetSize(540, 112)
    elseif ns:IsWOTLK() or ns:IsTBC() then
        mainFrame:SetSize(630, 472)
    end

    -- Title mainFrame.
    local titleFrame = CreateFrame("Frame", "AutoLoggerClassicTitleFrame", mainFrame)
    titleFrame:SetPoint("TOPLEFT")
    titleFrame:SetPoint("TOPRIGHT")
    titleFrame:SetSize(1, 20)
    mainFrame.titleFrame = titleFrame

    local fontInstance = CUI:GetFontBig()
    fontInstance:SetJustifyH("LEFT")

    -- Title text.
    local title = titleFrame:CreateFontString(nil, "BACKGROUND", fontInstance:GetName())
    title:SetText("AutoLoggerClassic")
    title:SetPoint("LEFT", 2, 0)
    titleFrame.title = title

    -- Close button.
    local closeButton = CreateFrame("Button", "AutoLoggerClassicCloseButton", titleFrame)
    CUI:ApplyTemplate(closeButton, CUI.templates.HighlightFrameTemplate)
    CUI:ApplyTemplate(closeButton, CUI.templates.PushableFrameTemplate)
    CUI:ApplyTemplate(closeButton, CUI.templates.BorderedFrameTemplate)
    local size = titleFrame:GetHeight() - 6
    closeButton:SetSize(size, size)
    local texture = closeButton:CreateTexture(nil, "ARTWORK")
    texture:SetTexture("Interface/Addons/AutoLoggerClassic/Media/CloseButton")
    texture:SetAllPoints()
    closeButton.texture = texture
    closeButton:SetPoint("TOPRIGHT")
    closeButton:HookScript("OnClick", CloseButton_OnClick)

    InitCheckButtons()
end

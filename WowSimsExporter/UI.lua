local Env = select(2, ...)

local AceGUI = LibStub("AceGUI-3.0")

local UI = {}

-- Helper function to detect and apply UI framework button styles
local function GetUIFramework()
    local IsAddOnLoadedCompat = IsAddOnLoaded or C_AddOns.IsAddOnLoaded
    
    -- Check for NDui
    if IsAddOnLoadedCompat and IsAddOnLoadedCompat("NDui") then
        if _G.NDui and type(_G.NDui) == "table" and _G.NDui[1] then
            local B = _G.NDui[1]
            if B and type(B) == "table" and B.Reskin then
                return "NDui", B
            end
        end
    end
    
    -- Check for ElvUI
    if IsAddOnLoadedCompat and IsAddOnLoadedCompat("ElvUI") then
        if _G.ElvUI and type(_G.ElvUI) == "table" and _G.ElvUI[1] then
            local E = _G.ElvUI[1]
            if E and type(E) == "table" and E.GetModule then
                local ok, S = pcall(function() return E:GetModule("Skins") end)
                if ok and S and type(S) == "table" then
                    return "ElvUI", E, S
                end
            end
        end
    end
    
    return "Default", nil, nil
end

-- Helper function to apply button style based on UI framework
local function SetButtonStyle(button)
    if not button then return end
    
    local uiType, framework, skinsModule = GetUIFramework()
    
    if uiType == "NDui" and framework then
        local B = framework
        if B.Reskin then
            pcall(function() 
                B.Reskin(button)
                -- Apply NDui's SkinAlpha if available
                C_Timer.After(0, function()
                    if button.__bg and _G.NDui and _G.NDui[1] and type(_G.NDui[1]) == "table" then
                        local C = _G.NDui[1][2]
                        if C and C.db and C.db["Skins"] and C.db["Skins"]["SkinAlpha"] then
                            local alpha = C.db["Skins"]["SkinAlpha"]
                            if button.__bg and button.__bg.SetBackdropColor then
                                local r, g, b = button.__bg:GetBackdropColor()
                                if r and g and b then
                                    button.__bg:SetBackdropColor(r, g, b, alpha)
                                end
                            end
                        end
                    end
                end)
            end)
        end
    elseif uiType == "ElvUI" and framework and skinsModule then
        local S = skinsModule
        if S.Reskin then
            pcall(function() S:Reskin(button) end)
        elseif S.HandleButton then
            pcall(function() S:HandleButton(button) end)
        end
    end
end

local _frame
local _jsonbox
local _outputGenerator
local _outputGeneratorBags

local function OnClose(frame)
    AceGUI:Release(frame)
    _frame = nil
    _jsonbox = nil
end

local function CreateCopyDialog(text)
    local frame = AceGUI:Create("Frame")
    frame:SetTitle(Env.L("WSE Copy Dialog"))
    frame:SetStatusText(Env.L("Use CTRL+C to copy link"))
    frame:SetLayout("Flow")
    frame:SetWidth(400)
    frame:SetHeight(100)
    frame:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
    end)

    local editbox = AceGUI:Create("EditBox")
    editbox:SetText(text)
    editbox:SetFullWidth(true)
    editbox:DisableButton(true)
    editbox:SetFocus()
    editbox:HighlightText()
    frame:AddChild(editbox)
end

---Create/show the main window.
---@param classIsSupported boolean If false then show class not supported info instead of export stuff.
---@param simLink string The URL to the (class/spec) sim to display.
function UI:CreateMainWindow(classIsSupported, simLink)
    if _frame then return end

    local frame = AceGUI:Create("Frame")
    frame:SetCallback("OnClose", OnClose)
    frame:SetTitle("WowSimsExporter " .. Env.VERSION .. "")
    frame:SetStatusText(Env.L("Click 'Generate Data' to generate exportable data"))
    frame:SetLayout("Fill")

    -- Add the frame as a global variable under the name `WowSimsExporter`
    _G["WowSimsExporter"] = frame.frame
    -- Register the global variable `WowSimsExporter` as a "special frame"
    -- so that it is closed when the escape key is pressed.
    tinsert(UISpecialFrames, "WowSimsExporter")

    _frame = frame

    local tabGroup = AceGUI:Create("TabGroup")
    tabGroup:SetFullWidth(true)
    tabGroup:SetFullHeight(true)
    tabGroup:SetLayout("Flow")
    tabGroup:SetTabs({
        { text = Env.L("Main"), value = "main" },
        { text = Env.L("Saved Data"), value = "saveddata" },
    })

    local function CreateMainTab(container)
        local icon = AceGUI:Create("Icon")
        icon:SetImage("Interface\\AddOns\\wowsimsexporter\\Skins\\wowsims.tga")
        icon:SetImageSize(32, 32)
        icon:SetFullWidth(true)
        container:AddChild(icon)

        local label = AceGUI:Create("Label")
        label:SetFullWidth(true)
        container:AddChild(label)

        if not classIsSupported then
            label:SetText(Env.L("Your characters class is currently unsupported. The supported classes are currently:") .. "\n" ..
                table.concat(Env.supportedClasses, "\n"))
            return
        end

        label:SetText("\n" .. Env.L("To upload your character to the simuator, click on the url below that leads to the simuator website.") .. "\n\n" ..
            Env.L("You will find an Import button on the top right of the simulator named \"Import\". Click that and select the \"Addon\" tab, paste the data into the provided box and click \"Import\"") .. "\n")

        if simLink then
            local ilabel = AceGUI:Create("InteractiveLabel")
            ilabel:SetText(Env.L("Click to copy:") .. " " .. simLink .. "\r\n")
            ilabel:SetFullWidth(true)
            ilabel:SetCallback("OnClick", function()
                CreateCopyDialog(simLink)
            end)
            container:AddChild(ilabel)
        end

        local button = AceGUI:Create("Button")
        button:SetText(Env.L("Generate Data (Equipped Only)"))
        button:SetWidth(300)
        button:SetCallback("OnClick", function()
            if _outputGenerator then
                UI:SetOutput(_outputGenerator())
            end
        end)
        container:AddChild(button)

        local extraButton = AceGUI:Create("Button")
        extraButton:SetText(Env.L("Batch: Export Bag Items"))
        extraButton:SetWidth(300)
        extraButton:SetCallback("OnClick", function()
            if _outputGeneratorBags then
                UI:SetOutput(_outputGeneratorBags())
            end
        end)
        container:AddChild(extraButton)

        local jsonbox = AceGUI:Create("MultiLineEditBox")
        jsonbox:SetLabel(Env.L("Copy and paste into the websites importer!"))
        jsonbox:SetFullWidth(true)
        jsonbox:SetFullHeight(true)
        jsonbox:DisableButton(true)
        if jsonbox.editBox then
            jsonbox.editBox:SetScript("OnEscapePressed", function(self)
                OnClose(frame)
            end)
        end
        container:AddChild(jsonbox)

        _jsonbox = jsonbox
    end

    local function CreateSavedDataTab(container)
        local scrollFrame = AceGUI:Create("ScrollFrame")
        scrollFrame:SetFullWidth(true)
        scrollFrame:SetFullHeight(true)
        scrollFrame:SetLayout("Flow")
        container:AddChild(scrollFrame)

        local label = AceGUI:Create("Label")
        label:SetText(Env.L("Saved Character Data Management"))
        label:SetFontObject(GameFontNormalLarge)
        label:SetFullWidth(true)
        scrollFrame:AddChild(label)

        local autoSaveGroup = AceGUI:Create("InlineGroup")
        autoSaveGroup:SetTitle(Env.L("Auto-Save Settings"))
        autoSaveGroup:SetFullWidth(true)
        autoSaveGroup:SetLayout("Flow")
        scrollFrame:AddChild(autoSaveGroup)

        local autoSaveCheckbox = AceGUI:Create("CheckBox")
        autoSaveCheckbox:SetLabel(Env.L("Enable Auto-Save"))
        autoSaveCheckbox:SetValue(Env.SavedDataManager.db and Env.SavedDataManager.db.profile.autoSaveEnabled or false)
        autoSaveCheckbox:SetCallback("OnValueChanged", function(widget, event, value)
            if Env.SavedDataManager.db then
                Env.SavedDataManager.db.profile.autoSaveEnabled = value
                local status = value and Env.L("enabled") or Env.L("disabled")
                DEFAULT_CHAT_FRAME:AddMessage("[WowSimsExporter] " .. Env.L("Auto-save %s."):format(status))
            end
        end)
        autoSaveGroup:AddChild(autoSaveCheckbox)

        local messagesCheckbox = AceGUI:Create("CheckBox")
        messagesCheckbox:SetLabel(Env.L("Show Auto-Save Messages"))
        messagesCheckbox:SetValue(Env.SavedDataManager.db and Env.SavedDataManager.db.profile.showAutoSaveMessages or false)
        messagesCheckbox:SetCallback("OnValueChanged", function(widget, event, value)
            if Env.SavedDataManager.db then
                Env.SavedDataManager.db.profile.showAutoSaveMessages = value
                local status = value and Env.L("enabled") or Env.L("disabled")
                DEFAULT_CHAT_FRAME:AddMessage("[WowSimsExporter] " .. Env.L("Auto-save messages %s."):format(status))
            end
        end)
        autoSaveGroup:AddChild(messagesCheckbox)

        local savedCharsGroup = AceGUI:Create("InlineGroup")
        savedCharsGroup:SetTitle(Env.L("Saved Characters"))
        savedCharsGroup:SetFullWidth(true)
        savedCharsGroup:SetLayout("Flow")
        scrollFrame:AddChild(savedCharsGroup)

        local function RefreshSavedCharsList()
            savedCharsGroup:ReleaseChildren()
            
            local savedChars = Env.SavedDataManager:GetSavedCharacters()
            
            if #savedChars == 0 then
                local noDataLabel = AceGUI:Create("Label")
                noDataLabel:SetText(Env.L("No saved characters found."))
                noDataLabel:SetFullWidth(true)
                savedCharsGroup:AddChild(noDataLabel)
                return
            end

            for i, charData in ipairs(savedChars) do
                local charGroup = AceGUI:Create("InlineGroup")
                charGroup:SetTitle(charData.name)
                charGroup:SetFullWidth(true)
                charGroup:SetLayout("Flow")
                savedCharsGroup:AddChild(charGroup)

                local infoLabel = AceGUI:Create("Label")
                infoLabel:SetText(Env.L("Saved:") .. " " .. charData.dateString)
                infoLabel:SetWidth(200)
                charGroup:AddChild(infoLabel)

                local exportButton = AceGUI:Create("Button")
                exportButton:SetText(Env.L("Export"))
                exportButton:SetWidth(80)
                exportButton:SetCallback("OnClick", function()
                    tabGroup:SelectTab("main")
                    UI:SetOutput(charData.data)
                end)
                charGroup:AddChild(exportButton)

                local deleteButton = AceGUI:Create("Button")
                deleteButton:SetText(Env.L("Delete"))
                deleteButton:SetWidth(80)
                deleteButton:SetCallback("OnClick", function()
                    Env.SavedDataManager:DeleteSavedCharacter(i)
                    RefreshSavedCharsList()
                end)
                charGroup:AddChild(deleteButton)
            end
        end

        RefreshSavedCharsList()
    end

    tabGroup:SetCallback("OnGroupSelected", function(self, event, group)
        self:ReleaseChildren()
        if group == "main" then
            CreateMainTab(self)
        elseif group == "saveddata" then
            CreateSavedDataTab(self)
        end
    end)

    frame:AddChild(tabGroup)
    tabGroup:SelectTab("main")
end

---Create a button on the character panel that will call the provided function
---@param onClick fun()
function UI:CreateCharacterPanelButton(onClick)
    local openButton = CreateFrame("Button", nil, CharacterFrame, "UIPanelButtonTemplate")
    openButton:SetPoint("TOP", CharacterFrame, "BOTTOM", 0, 0)
    openButton:SetPoint("RIGHT", CharacterFrame, "RIGHT", 0, 0)
    openButton:Show()
    openButton:SetText(Env.L("WowSims"))
    openButton:SetSize(openButton:GetTextWidth() + 15, openButton:GetTextHeight() + 10)
    openButton:SetScript("OnClick", function(self)
        onClick()
    end)
    openButton:RegisterForClicks("AnyUp")
    
    -- Apply UI framework button style if available
    SetButtonStyle(openButton)
end

function UI:CreateInspectButton(onClick)
    if not InspectFrame then return end

    local inspectButton = CreateFrame("Button", "WSEInspectButton", InspectFrame, "UIPanelButtonTemplate")
    inspectButton:SetSize(50, 24)
    inspectButton:SetText(Env.L("WowSims"))
    inspectButton:SetPoint("BOTTOMRIGHT", InspectFrame, "BOTTOMRIGHT", 0, 0)
    inspectButton:SetSize(inspectButton:GetTextWidth() + 15, inspectButton:GetTextHeight() + 10)
    inspectButton:SetScript("OnClick", function()
        onClick()
    end)
    
    -- Apply UI framework button style if available
    SetButtonStyle(inspectButton)
end

---Sets string in textbox.
---@param outputString string
function UI:SetOutput(outputString)
    if not _frame or not _jsonbox then return end
    _jsonbox:SetText(outputString)
    _jsonbox:HighlightText()
    _jsonbox:SetFocus()
    _frame:SetStatusText("Data Generated!")
end

---Set the function that is used to get the output value when
---pressing the character export button.
---@param func fun():string
function UI:SetOutputGenerator(func)
    _outputGenerator = func
end

---Set the function that is used to get the output value when
---pressing the bag items export button.
---@param func fun():string
function UI:SetOutputGeneratorBags(func)
    _outputGeneratorBags = func
end

Env.UI = UI

local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local ScriptEditor = PetBattleTeams:NewModule("ScriptEditor")
local TeamManager = PetBattleTeams:GetModule("TeamManager")
local GUI = PetBattleTeams:GetModule("GUI")

-- PetBattle Scripts
local PBS_Core, PBS_Director

local _, addon = ...
local L = addon.L


local tinyBackdrop = {
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface\\LFGFRAME\\LFGBorder",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = {
        left = 5,
        right = 5,
        top = 5,
        bottom = 5
    }
}

function ScriptEditor:OnInitialize()
    self.isScriptEditorReady = false

    if C_AddOns.IsAddOnLoaded("tdBattlePetScript") then
        ScriptEditor:Load()
        return
    end
    self:RegisterEvents()
end

-- To be called by RegisterEvents
function ScriptEditor:Load()
    PBS_Core = LibStub("AceAddon-3.0"):GetAddon("PetBattleScripts")
    PBS_Director = PBS_Core:GetModule("Director")
    self:CreateEditor()
    self.isScriptEditorReady = true
end
function ScriptEditor:IsLoaded()
    return self.isScriptEditorReady or false
end

-- Events:
--  - Detect tdBattlePetScript Loading (then Loads itself)
--  - Autolaunch Pet Battle Script (if loaded)
function ScriptEditor:RegisterEvents()
    self.eventsFrame = CreateFrame("Frame", nil, UIParent)
    self.eventsFrame:SetScript("OnEvent", function(self, event, name)
        if event == "ADDON_LOADED" and name == "tdBattlePetScript" then
            self:UnregisterEvent("ADDON_LOADED")
            if ScriptEditor:IsLoaded() then return end
            ScriptEditor:Load()
        end
        if event == "PET_BATTLE_OPENING_START" and ScriptEditor:IsLoaded() then
            ScriptEditor:AutoLoad_PBS_Script()
        end
    end)
    self.eventsFrame:RegisterEvent("ADDON_LOADED")
    self.eventsFrame:RegisterEvent("PET_BATTLE_OPENING_START")
end

function ScriptEditor:CreateEditor()
    self.editor = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    self.editor:SetSize(630, 417)
    self.editor:SetPoint("CENTER", UIParent, "CENTER")
    self.editor:SetFrameStrata("DIALOG")
    self.editor:SetBackdrop(tinyBackdrop)
    self.editor:SetBackdropColor(0.1, 0.1, 0.1, 1)
    self.editor:SetMovable(true)
    self.editor:SetClampedToScreen(true)
    self.editor:EnableMouse(true)
    self.editor:RegisterForDrag("LeftButton")
    self.editor:SetScript("OnDragStart", self.editor.StartMoving)
    self.editor:SetScript("OnDragStop", self.editor.StopMovingOrSizing)
    self.editor:Hide();

    -- Nom de l'équipe (au-dessus de l'EditBox)
    self.editorTitle = self.editor:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    self.editorTitle:SetPoint("TOPLEFT", self.editor, "TOPLEFT", 30, -15)
    self.editorTitle:SetPoint("TOPRIGHT", self.editor, "TOPRIGHT", -30, -15)
    self.editorTitle:SetTextColor(1.0, 0.82, 0.0)
    self.editorTitle:SetJustifyH("LEFT")
    self.editorTitle:SetJustifyV("TOP")

    -- Texte d'information
    local infoTextEditor = self.editor:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    infoTextEditor:SetPoint("TOPLEFT", self.editorTitle, "BOTTOMLEFT", 0, -7)
    infoTextEditor:SetPoint("TOPRIGHT", self.editorTitle, "BOTTOMRIGHT", 0, -7)
    infoTextEditor:SetTextColor(0.7, 0.7, 0.7)
    infoTextEditor:SetText(L["Press Ctrl+Enter to save the script"])
    infoTextEditor:SetJustifyH("LEFT")

    -- Scroll EditBox
    local backdrop = {
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = {
            left = 0,
            right = 0,
            top = 0,
            bottom = 0
        },
    }
    local scrollContainer = CreateFrame("Frame", nil, self.editor,"BackdropTemplate")
    --  noteEditFrame:SetSize(410, 317)
    scrollContainer:SetPoint("TOPLEFT", self.editor, "TOPLEFT", 30, -60)
    scrollContainer:SetPoint("TOPRIGHT", self.editor, "TOPRIGHT", -30, -60)
    scrollContainer:SetPoint("BOTTOM", self.editor, "BOTTOM", 0, 60)
    scrollContainer:SetPoint("CENTER")
    scrollContainer:SetBackdrop(backdrop)
    scrollContainer:SetBackdropColor(0, 0, 0)
    scrollContainer:SetFrameStrata("DIALOG")
    scrollContainer:SetFrameLevel(1000)
    scrollContainer.Scroll = CreateFrame("ScrollFrame", nil, scrollContainer, "ScrollFrameTemplate")
    scrollContainer.Scroll.scrollBarX = 6
    scrollContainer.Scroll.scrollBarTopY = -4
    scrollContainer.Scroll.scrollBarBottomY = 5

    scrollContainer.Scroll:SetPoint("TOPLEFT", 5, -10)
    scrollContainer.Scroll:SetPoint("BOTTOMRIGHT", -25, 5)

    scrollContainer.Text = CreateFrame("EditBox", nil, scrollContainer)
    scrollContainer.Text:SetMultiLine(true)
    scrollContainer.Text:SetSize(scrollContainer.Scroll:GetWidth(), scrollContainer.Scroll:GetHeight())
    scrollContainer.Text:SetPoint("TOPLEFT", scrollContainer.SF)
    scrollContainer.Text:SetPoint("BOTTOMRIGHT", scrollContainer.SF)
    scrollContainer.Text:SetMaxLetters(99999)
    scrollContainer.Text:SetFontObject(GameFontNormal)
    scrollContainer.Text:SetAutoFocus(false)
    scrollContainer.Scroll:SetScrollChild(scrollContainer.Text)
    -- Raccourcis clavier
    scrollContainer.Text:SetScript("OnKeyDown", function(_, key)
        if key == "ENTER" then
            if IsModifierKeyDown() then
                self:SaveEditor()
            end
        elseif key == "ESCAPE" then
            self:HideEditor()
            return
        end
    end)
    self.editBox = scrollContainer.Text
    self.editBox.Scroll = scrollContainer.Scroll
    -- End Scroll EditBox

    local frameInset = 20
    local saveButton = CreateFrame("Button", nil, self.editor, "UIPanelButtonTemplate")
    saveButton:SetSize(150, 20)
    saveButton:SetPoint("BOTTOMLEFT", self.editor, "BOTTOMLEFT", frameInset, frameInset)
    saveButton:SetText(OKAY)
    saveButton:SetFrameStrata("DIALOG")
    saveButton:SetFrameLevel(1001)
    saveButton:SetScript("OnClick", function()
        self:SaveEditor()
    end)

    local cancelButton = CreateFrame("Button", nil, self.editor, "UIPanelButtonTemplate")
    cancelButton:SetSize(150, 20)
    cancelButton:SetPoint("BOTTOMRIGHT", self.editor, "BOTTOMRIGHT", -frameInset, frameInset)
    cancelButton:SetText(CANCEL)
    cancelButton:SetFrameStrata("DIALOG")
    cancelButton:SetFrameLevel(1001)
    cancelButton:SetScript("OnClick", function()
        self:HideEditor()
    end)
end


function ScriptEditor:ShowEditor(teamIndex)
    assert(type(teamIndex) == "number", "ShowEditor: teamIndex doit être un nombre")
    if not teamIndex then return end
    if not self:IsLoaded() then StaticPopup_Show("PBT_SCRIPT_NOTLOADED") return end

    self.currentTeamIndex = teamIndex

    local currentScript = TeamManager:GetTeamScript(teamIndex)
    local name, _, customName = TeamManager:GetTeamName(teamIndex)
    if currentScript ~= self.editBox:GetText() then
        self.editBox:SetText(currentScript or "")
        C_Timer.After(0.1, function()
            local verticalScrollRange = self.editBox.Scroll:GetVerticalScrollRange()
            self.editBox.Scroll:SetVerticalScroll(verticalScrollRange)
        end)
    end
    self.editorTitle:SetText(string.format("|cff00e680"..L["SCRIPT: %s"], "|r"..(customName or name)))

    self.editor:Show()
    self.editBox:SetFocus()
end

function ScriptEditor:HideEditor()
    if not ScriptEditor:IsLoaded() then return end
    self.editor:Hide()
    self.editBox:ClearFocus()
    self.editorTitle:SetText("")

    self.currentTeamIndex = nil
end

function ScriptEditor:SaveEditor()
    if not self.currentTeamIndex then self:HideEditor(); return end

    local newScript = self.editBox:GetText() or ""
    -- isBlank note.trim()
    newScript = string.gsub(newScript, "^%s*(.-)%s*$", "%1")
    if newScript  == "" then
        newScript = nil
    end
    if newScript then
        local isSuccess, err = self:PBS_ValidateScript(newScript)
        if not isSuccess then
            StaticPopup_Show("PBT_SCRIPT_ERROR", err)
            -- STOP ON ERROR
            return
        end
    end

    TeamManager:SetTeamScript(self.currentTeamIndex, newScript)
    local selectedTeamIndex = TeamManager:GetSelected()
    if self.currentTeamIndex == selectedTeamIndex then
        ScriptEditor:AutoLoad_PBS_Script()
    end
    self:HideEditor()
end

local PBSScript = function(code)
    local ScriptClass = PBS_Core:GetClass("Script")
    return ScriptClass:New({ code = code }, nil, nil)
end

function ScriptEditor:PBS_ValidateScript(code)
    assert(type(code) == "string", "PBS_ValidateScript: code doit être une chaine")
    local PBSObject = PBSScript()
    local isSuccess, err = PBSObject:SetCode(code)
    PBSObject = nil
    return isSuccess, err
end

function ScriptEditor:PBS_SetScript(code)
    assert(code == nil or type(code) == "string", "PBS_SetScript: code doit être une chaine")
    if not code then
        PBS_Director:SetScript(nil)
        return
    else
        PBS_Director:SetScript(PBSScript(code))
    end
end


function ScriptEditor:AutoLoad_PBS_Script()
    local teamIndex = TeamManager:GetSelected()
    if not teamIndex or teamIndex <= 0 then return end

    local code = TeamManager:GetTeamScript(teamIndex)
    if code and code ~= "" then
        local teamName = TeamManager:GetTeamName(teamIndex)
        UIErrorsFrame:AddMessage(string.format(L["Team '|cffffd200%s|r': script loaded"], teamName))
        ScriptEditor:PBS_SetScript(code)
    end
end



local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local NoteEditor = PetBattleTeams:NewModule("NoteEditor")
local TeamManager = PetBattleTeams:GetModule("TeamManager")
local GUI = PetBattleTeams:GetModule("GUI")

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

function NoteEditor:OnInitialize()
    self:CreateNoteEditor()
    self:CreateBattleFrame()
    self:RegisterEvents()
end

function NoteEditor:CreateNoteEditor()
    self.editor = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    self.editor:SetSize(430, 317)
    -- self.editor:SetSize(500, 317)
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
    infoTextEditor:SetText(L["Press Ctrl+Enter to save the note"])
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
    --  self.editor:SetSize(410, 317)
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

local function OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_CENTER");
    GameTooltip:ClearLines()
    GameTooltip:AddLine(L["PetBattle Teams"], 1, 1, 1)
    GameTooltip:AddLine(L["Show the team roster"], 0,1,0)
    GameTooltip:Show()
end
local function OnLeave(self)
    GameTooltip:Hide()
end

function NoteEditor:CreateBattleFrame()
    self.battleFrame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
    self.battleFrame:SetSize(380, 200)
    self.battleFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -5, 15)
    if (UIParent:GetWidth() < 1200) then
        self.battleFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -5, 120)
    end
    self.battleFrame:SetFrameStrata("HIGH")
    self.battleFrame:SetFrameLevel(100)
    self.battleFrame:Hide()

    self.battleFrame:SetBackdrop(tinyBackdrop)
    self.battleFrame:SetBackdropColor(0.1, 0.1, 0.1, 1)

    -- Nom de l'équipe (en bas du cadre)
    local teamNameContainer = CreateFrame("Frame", nil, self.battleFrame, BackdropTemplateMixin and "BackdropTemplate")
    teamNameContainer:SetHeight(25)
    teamNameContainer:SetPoint("BOTTOMLEFT", self.battleFrame, "BOTTOMLEFT", 4, -15)
    teamNameContainer:SetPoint("BOTTOMRIGHT", self.battleFrame, "BOTTOMRIGHT", -3, -15)
    teamNameContainer:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = {left = 4, right = 4, top = 4, bottom = 4}
    })
    teamNameContainer:SetBackdropColor(0.1, 0.1, 0.1, 1)
    teamNameContainer:SetFrameStrata("HIGH")
    teamNameContainer:SetFrameLevel(101)

    local teamNameText = teamNameContainer:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    teamNameText:SetPoint("LEFT", teamNameContainer, "LEFT", 10, 0)
    teamNameText:SetPoint("RIGHT", teamNameContainer, "RIGHT", -10, 0)
    teamNameText:SetTextColor(1.0, 0.82, 0.0)
    self.battleFrame.teamNameText = teamNameText

    self.battleFrame.Scroll = CreateFrame("ScrollFrame", nil, self.battleFrame, "ScrollFrameTemplate")
    self.battleFrame.Scroll.scrollBarX = 6
    self.battleFrame.Scroll.scrollBarTopY = -4
    self.battleFrame.Scroll.scrollBarBottomY = 5

    self.battleFrame.Scroll:SetPoint("TOPLEFT", 9, -10)
    self.battleFrame.Scroll:SetPoint("BOTTOMRIGHT", -25, 10)

    local scrollContentFrame = CreateFrame("Frame", nil, self.battleFrame.Scroll)
    scrollContentFrame:SetPoint("TOPLEFT", 0, 0)
    scrollContentFrame:SetWidth(self.battleFrame.Scroll:GetWidth())
    scrollContentFrame:SetHeight(1)
    self.battleFrame.Scroll:SetScrollChild(scrollContentFrame)
    self.battleFrame.ScrollContent = scrollContentFrame

    self.battleFrame.Text = scrollContentFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    self.battleFrame.Text:SetPoint("TOPLEFT", scrollContentFrame, "TOPLEFT", 0, 0)
    self.battleFrame.Text:SetWidth(scrollContentFrame:GetWidth())
    self.battleFrame.Text:SetJustifyH("LEFT")
    self.battleFrame.Text:SetJustifyV("TOP")
    self.battleFrame.Text:SetWordWrap(true)
    self.battleFrame.SetText = function (self, text)
        self.Text:SetText(text or "")
        self.ScrollContent:SetHeight(self.Text:GetHeight()) -- Nécessaire à l'update car FontString
        self.Scroll:SetVerticalScroll(0)
    end

    local button = CreateFrame("BUTTON", nil, self.battleFrame)
    button:SetSize(33,33)
    button:ClearAllPoints()
    button:SetPoint("LEFT", teamNameText, "LEFT", -20, 0)

    button.icon = button:CreateTexture("PetBattleTeambuttonButtonIcon","ARTWORK")
    button.icon:SetTexture("Interface\\Icons\\INV_PET_BATTLEPETTRAINING")
    button.icon:SetSize(25,25)
    button.icon:ClearAllPoints()
    button.icon:SetPoint("TOPLEFT",button,"TOPLEFT",7,-6)

    button.overlay = button:CreateTexture("PetBattleTeambuttonButtonIcon","OVERLAY")
    button.overlay:SetTexture("Interface\\MiniMap\\MiniMap-TrackingBorder")
    button.overlay:SetSize(60,60)
    button.overlay:ClearAllPoints()
    button.overlay:SetPoint("TOPLEFT",button,"TOPLEFT")

    button:SetFrameStrata("HIGH")
    button:SetFrameLevel(self.battleFrame:GetFrameLevel() + 1)

    button:SetHighlightTexture("Interface\\MiniMap\\UI-MiniMap-ZoomButton-Highlight","ADD")
    button:RegisterForClicks("LeftButtonUp","RightButtonUp")
    button:SetScript("OnClick", function(_,_)
        -- GameTooltip:Hide()
        ToggleCollectionsJournal(COLLECTIONS_JOURNAL_TAB_INDEX_PETS)
    end)
    button:SetScript("OnEnter",OnEnter)
    button:SetScript("OnLeave",OnLeave)
end

function NoteEditor:RegisterEvents()
    self.battleFrame:RegisterEvent("PET_BATTLE_OPENING_START")
    self.battleFrame:RegisterEvent("PET_BATTLE_CLOSE")
    self.battleFrame:SetScript("OnEvent", function(_, event, ...)
        if event == "PET_BATTLE_OPENING_START" then
            self:ShowBattleNote()
        elseif event == "PET_BATTLE_CLOSE" then
            self:HideBattleNote()
        end
    end)
end

function NoteEditor:ShowEditor(teamIndex)
    if not teamIndex then return end

    self.currentTeamIndex = teamIndex

    local currentNote = TeamManager:GetTeamNote(teamIndex)
    local name, _, customName = TeamManager:GetTeamName(teamIndex)
    if currentNote ~= self.editBox:GetText() then
        self.editBox:SetText(currentNote or "")
        C_Timer.After(0.1, function()
            local verticalScrollRange = self.editBox.Scroll:GetVerticalScrollRange()
            self.editBox.Scroll:SetVerticalScroll(verticalScrollRange)
        end)
    end
    self.editorTitle:SetText(customName or name)

    self.editor:Show()
    self.editBox:SetFocus()
end

function NoteEditor:HideEditor()
    self.editor:Hide()
    self.editBox:ClearFocus()
    self.editorTitle:SetText("")

    self.currentTeamIndex = nil
end

function NoteEditor:SaveEditor()
    if not self.currentTeamIndex then self:HideEditor(); return end

    local newNote = self.editBox:GetText()
    -- isBlank note.trim()
    if newNote and string.gsub(newNote, "^%s*(.-)%s*$", "%1") == "" then
        newNote = nil
    end

    TeamManager:SetTeamNote(self.currentTeamIndex, newNote)
    local selectedTeamIndex = TeamManager:GetSelected()
    if self.currentTeamIndex == selectedTeamIndex and PetBattleFrame and PetBattleFrame:IsShown() then
        self:ShowBattleNote(selectedTeamIndex)
    end
    self:HideEditor()
end

function NoteEditor:ShowBattleNote(selectedTeam)
    if selectedTeam == nil and not TeamManager:GetShowBattleNote() then
        return
    end

    selectedTeam = selectedTeam or TeamManager:GetSelected()
    if selectedTeam and selectedTeam > 0 then
        local note = TeamManager:GetTeamNote(selectedTeam)
        if note and note ~= "" then
            self.battleFrame.ScrollContent:SetHeight(self.battleFrame.Text:GetHeight())
            self.battleFrame:SetText(note)
            local name, _, customName = TeamManager:GetTeamName(selectedTeam)
            self.battleFrame.teamNameText:SetText(customName or name)
            self.battleFrame:Show()
        else
            self.battleFrame:Hide()
        end
    end
end

function NoteEditor:HideBattleNote()
    self.battleFrame:Hide()
end

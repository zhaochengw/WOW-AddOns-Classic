local PetBattleTeamsFrame = {}

local PETS_PER_TEAM = 3
local PetBattleTeams =  LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local TeamManager = PetBattleTeams:GetModule("TeamManager")
local Cursor =  PetBattleTeams:GetModule("Cursor")
local Embed = PetBattleTeams.Embed
local HEIGHT_WITH_NAME = 55
local HEIGHT = 42
local PetBattleTeamsUnitFrame = PetBattleTeams.PetBattleTeamsUnitFrame

local _, addon = ...
local L = addon.L

local function CalculateTeamHeight(teamIndex)
    local height = HEIGHT
    if TeamManager:GetShowTeamName() then
        height = HEIGHT_WITH_NAME
    end
    return height
end

local function OnEnter(self)
    local operation = Cursor:GetCursorInfo()
    self.helperText:Show()

    local parent = self:GetParent()
    parent:SetHeight(55*1.5)
end

local function OnLeave(self)
    local parent = self:GetParent()
    self.helperText:Hide()
    parent:SetHeight(CalculateTeamHeight(parent.teamIndex))
end

local function OnClickOrDrag(self)
    local parent = self:GetParent()
    local operation, petID, teamIndex, petIndex = Cursor:GetCursorInfo()
    if operation == "MOVE TEAM" then
        TeamManager:MoveTeam(teamIndex,parent.teamIndex)
    end

    parent:SetHeight(CalculateTeamHeight(parent.teamIndex))
    ClearCursor()
end

local function OnEvent(self,event,...)
    if event == "PET_BATTLE_QUEUE_STATUS" or event == "PET_BATTLE_OPENING_START" or event == "PET_BATTLE_CLOSE" then
        self:PET_BATTLE_QUEUE_STATUS(event,...)
    end
end

function PetBattleTeamsFrame:New()
    local petBattleTeamsFrame = CreateFrame("frame")
    Embed(petBattleTeamsFrame, PetBattleTeamsFrame)

    local width = 135
    local height = HEIGHT
    petBattleTeamsFrame:SetSize(width,height)

    petBattleTeamsFrame.unitFrames = {}
    petBattleTeamsFrame.unitFrames[1]= PetBattleTeamsUnitFrame:New()
    petBattleTeamsFrame.unitFrames[1]:SetParent(petBattleTeamsFrame)
    petBattleTeamsFrame.unitFrames[1]:SetPoint("BOTTOMLEFT",petBattleTeamsFrame,"BOTTOMLEFT",15,2)

    for i=2,PETS_PER_TEAM do
        local unitFrame = PetBattleTeamsUnitFrame:New()
        unitFrame:SetParent(petBattleTeamsFrame)
        unitFrame:SetPoint("LEFT",petBattleTeamsFrame.unitFrames[i-1],"RIGHT",1,0)
        petBattleTeamsFrame.unitFrames[i] = unitFrame;
    end

    petBattleTeamsFrame.logicalLeft = petBattleTeamsFrame.unitFrames[1]
    petBattleTeamsFrame.logicalRight = petBattleTeamsFrame.unitFrames[PETS_PER_TEAM]

    local teamMovementFrame = CreateFrame("button")
    petBattleTeamsFrame.teamMovementFrame = teamMovementFrame
    teamMovementFrame:SetParent(petBattleTeamsFrame)
    teamMovementFrame:SetAllPoints(petBattleTeamsFrame)
    teamMovementFrame:SetFrameLevel(10000)
    teamMovementFrame:Hide()

    teamMovementFrame:SetScript("OnEnter",OnEnter)
    teamMovementFrame:SetScript("OnLeave",OnLeave)
    teamMovementFrame:SetScript("OnClick",OnClickOrDrag)
    teamMovementFrame:SetScript("OnReceiveDrag",OnClickOrDrag)

    local helperText = petBattleTeamsFrame:CreateFontString(nil,"OVERLAY","GameFontNormal")
    teamMovementFrame.helperText = helperText
    helperText:SetParent(teamMovementFrame)
    helperText:SetText("Place Team Here")
    helperText:SetPoint("CENTER", teamMovementFrame, "TOP",0,-15)
    helperText:SetJustifyH("CENTER")
    helperText:Hide()

    local teamNameText = petBattleTeamsFrame:CreateFontString(nil,"ARTWORK","GameFontHighlight")
    petBattleTeamsFrame.teamNameText = teamNameText

    teamNameText:SetText("")
    teamNameText:SetPoint("BOTTOMLEFT", petBattleTeamsFrame.unitFrames[1], "TOPLEFT",0,2)
    teamNameText:SetPoint("BOTTOMRIGHT", petBattleTeamsFrame.unitFrames[3], "TOPRIGHT",0,2)
    teamNameText:SetJustifyH("LEFT")
    teamNameText:Hide()

    local teamNoteIcon = petBattleTeamsFrame:CreateTexture(nil, "OVERLAY")
    petBattleTeamsFrame.teamNoteIcon = teamNoteIcon
    teamNoteIcon:SetSize(16, 16)
    -- teamNoteIcon:SetTexture("Interface/Icons/INV_Letter_15")
    teamNoteIcon:SetTexture("Interface/MINIMAP/TRACKING/Mailbox.PNG")
    teamNoteIcon:SetPoint("BOTTOMRIGHT", petBattleTeamsFrame.unitFrames[3], "TOPRIGHT", 0, 0)
    teamNoteIcon:SetAtlas("ui-hud-minimap-mail-up", false)
    teamNoteIcon:SetAlpha(.2)
    teamNoteIcon:SetDesaturated(true)

    local teamNoteButton = CreateFrame("Button", nil, petBattleTeamsFrame)
    petBattleTeamsFrame.teamNoteButton = teamNoteButton
    teamNoteButton:SetSize(16, 16)
    teamNoteButton:SetPoint("CENTER", teamNoteIcon, "CENTER")
    teamNoteButton:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square", "ADD")
    teamNoteButton:SetScript("OnEnter", function(self)
        local teamIndex = self:GetParent().teamIndex
        local note = TeamManager:GetTeamNote(teamIndex)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        local displayName = TeamManager:GetTeamName(teamIndex)
        GameTooltip:AddLine(string.format("|TInterface/MINIMAP/TRACKING/Mailbox.PNG:20|t %s", displayName), 1, 1, 1)
        if note and note ~= "" then
            GameTooltip:AddLine(note, 1, .82, 0, false)
        else
            GameTooltip:AddLine("> "..L["Add Note"].." <")
        end
        GameTooltip:Show()
    end)
    teamNoteButton:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    teamNoteButton:RegisterForClicks("LeftButtonUp","RightButtonUp")
    teamNoteButton:SetScript("OnClick", function(self, mouseButton)
        local parent = self:GetParent()
        if mouseButton == "RightButton" and IsModifierKeyDown() then
            parent:DebugBattleNote()
        else
            parent:ShowNoteEditor()
        end
    end)


    local teamNPCIcon = petBattleTeamsFrame:CreateTexture(nil, "OVERLAY")
    petBattleTeamsFrame.teamNPCIcon = teamNPCIcon
    teamNPCIcon:SetSize(16, 16)
    teamNPCIcon:SetTexture("Interface/MINIMAP/TRACKING/None.PNG")
    teamNPCIcon:SetAtlas("None", false)
    teamNPCIcon:SetPoint("RIGHT", teamNoteIcon, "LEFT", 1)
    teamNPCIcon:SetAlpha(.2)
    teamNPCIcon:SetDesaturated(true)

    local teamNPCButton = CreateFrame("Button", nil, petBattleTeamsFrame)
    petBattleTeamsFrame.teamNPCButton = teamNPCButton
    teamNPCButton:SetSize(16, 16)
    teamNPCButton:SetPoint("RIGHT", teamNoteIcon, "LEFT", 1)
    teamNPCButton:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square", "ADD")
    teamNPCButton:SetScript("OnEnter", function(self)
        local teamIndex = self:GetParent().teamIndex
        local npcID = TeamManager:GetTeamNpcID(teamIndex)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        local displayName = TeamManager:GetTeamName(teamIndex)
        GameTooltip:AddLine(string.format("|TInterface/MINIMAP/TRACKING/None.PNG:20|t %s", displayName), 1, 1, 1)
        if npcID and npcID ~= "" then
            GameTooltip:AddLine(string.format(L["Linked to NPC: %s"], npcID))
            GameTooltip:AddLine(" ")
        end
        local tooltip = L["Click: %s|nRight-click: %s|nCtrl-Right-click: Clear NPC ID"]
        tooltip = string.format(tooltip, L["Edit NPC ID for AutoSwitch"], L["Set NPC ID from current Target"])
        GameTooltip:AddLine(tooltip, 0,1,0)
        GameTooltip:Show()
    end)
    teamNPCButton:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    teamNPCButton:RegisterForClicks("LeftButtonUp","RightButtonUp")
    teamNPCButton:SetScript("OnClick", function(self, mouseButton)
        if mouseButton == "RightButton" then
            local onEnterScript = petBattleTeamsFrame.teamNPCButton:GetScript("OnEnter")
            local teamIndex = self:GetParent().teamIndex
            if IsControlKeyDown() then
                TeamManager:SetTeamNpcID(teamIndex, nil)
                 onEnterScript(petBattleTeamsFrame.teamNPCButton)
                return
            end
            TeamManager:SetNpcFromTarget(teamIndex)
            onEnterScript(petBattleTeamsFrame.teamNPCButton)
            return
        end
        petBattleTeamsFrame:ShowNpcEditor()
    end)


    local ScriptEditor = PetBattleTeams:GetModule("ScriptEditor")
    if ScriptEditor:IsLoaded() then

        local teamScriptIcon = petBattleTeamsFrame:CreateTexture(nil, "OVERLAY")
        petBattleTeamsFrame.teamScriptIcon = teamScriptIcon
        teamScriptIcon:SetSize(16, 16)
        -- teamScriptIcon:SetTexture("Interface/MINIMAP/Vehicle-Trap-Grey.PNG")
        teamScriptIcon:SetTexture("Interface/ICONS/Pet_Type_Dragon.PNG")
        teamScriptIcon:SetPoint("BOTTOMRIGHT", petBattleTeamsFrame.unitFrames[3], "TOPRIGHT", 16, 0)
        -- teamScriptIcon:SetAtlas("WildBattlePetCapturable", false)
        teamScriptIcon:SetAlpha(.2)
        teamScriptIcon:SetDesaturated(true)

        local teamScriptButton = CreateFrame("Button", nil, petBattleTeamsFrame)
        petBattleTeamsFrame.teamScriptButton = teamScriptButton
        teamScriptButton:SetSize(16, 16)
        teamScriptButton:SetPoint("CENTER", teamScriptIcon, "CENTER")
        teamScriptButton:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square", "ADD")
        teamScriptButton:SetScript("OnEnter", function(self)
            local teamIndex = self:GetParent().teamIndex
            local script = TeamManager:GetTeamScript(teamIndex)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:ClearLines()
            local displayName = TeamManager:GetTeamName(teamIndex)
            GameTooltip:AddLine(string.format("|TInterface/ICONS/Pet_Type_Dragon.PNG:20|t %s |TInterface/ICONS/Pet_Type_Dragon.PNG:20|t", displayName), 1, 1, 1)
            if script and script ~= "" then
                GameTooltip:AddLine(script, .0, 0.9, 0.5, false)
            else
                GameTooltip:AddLine("> "..L["Edit Script"].." <")
            end
            GameTooltip:Show()
        end)
        teamScriptButton:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        teamScriptButton:RegisterForClicks("LeftButtonUp","RightButtonUp")
        teamScriptButton:SetScript("OnClick", function(self, mouseButton)
            local parent = self:GetParent()
            parent:ShowScriptEditor()
        end)
    end

    petBattleTeamsFrame.selectedTexture = petBattleTeamsFrame:CreateTexture(nil,"OVERLAY")
    petBattleTeamsFrame.selectedTexture:SetSize(36,36)
    petBattleTeamsFrame.selectedTexture:SetTexture("Interface/PetBattles/PetJournal")
    petBattleTeamsFrame.selectedTexture:SetTexCoord(0.11328125,0.16210938,0.02246094,0.04687500)
    petBattleTeamsFrame.selectedTexture:SetPoint("CENTER",petBattleTeamsFrame.unitFrames[1],"LEFT",0,0)
    petBattleTeamsFrame.selectedTexture:SetParent(petBattleTeamsFrame.unitFrames[1])
    petBattleTeamsFrame.selectedTexture:Hide()

    petBattleTeamsFrame.lockedTexture = petBattleTeamsFrame:CreateTexture(nil,"OVERLAY")
    petBattleTeamsFrame.lockedTexture:SetSize(30,30)
    petBattleTeamsFrame.lockedTexture:SetTexture("Interface/PetBattles/PetBattle-LockIcon")
    petBattleTeamsFrame.lockedTexture:SetPoint("CENTER",petBattleTeamsFrame.unitFrames[1],"LEFT",0,0)
    petBattleTeamsFrame.lockedTexture:SetParent(petBattleTeamsFrame.unitFrames[1])
    petBattleTeamsFrame.lockedTexture:Hide()

    TeamManager.RegisterCallback(petBattleTeamsFrame,"TEAM_UPDATED")
    TeamManager.RegisterCallback(petBattleTeamsFrame,"TEAM_DELETED")
    TeamManager.RegisterCallback(petBattleTeamsFrame,"SELECTED_TEAM_CHANGED")

    Cursor.RegisterCallback(petBattleTeamsFrame,"BATTLE_PET_CURSOR_CHANGED")

    petBattleTeamsFrame:RegisterEvent("PET_BATTLE_QUEUE_STATUS")
    petBattleTeamsFrame:RegisterEvent("PET_BATTLE_OPENING_START")
    petBattleTeamsFrame:RegisterEvent("PET_BATTLE_CLOSE")
    petBattleTeamsFrame:SetScript("OnEvent",OnEvent)

    return petBattleTeamsFrame
end
PetBattleTeams.PetBattleTeamsFrame = PetBattleTeamsFrame

local function toggleIcon(icon, state)
    if state then
        icon:SetAlpha(1)
        icon:SetDesaturated(false)
    else
        icon:SetAlpha(.2)
        icon:SetDesaturated(true)
    end
end

function PetBattleTeamsFrame:ShowNpcEditor()
    if not self.teamIndex then return end

    local displayName = TeamManager:GetTeamName(self.teamIndex)
    StaticPopup_Show("PBT_TEAM_EDITNPCID", displayName, nil, self.teamIndex)
end

function PetBattleTeamsFrame:Update()
    local isSelected = (self.teamIndex == TeamManager:GetSelected())
    local showTeamName = TeamManager:GetShowTeamName()
    local showLocked = TeamManager:IsTeamLocked(self.teamIndex)

    if showTeamName then
        local displayName = TeamManager:GetTeamName(self.teamIndex)
        self.teamNameText:SetText(displayName)

        local note = TeamManager:GetTeamNote(self.teamIndex)
        toggleIcon(self.teamNoteIcon, note and note ~= "")

        if self.teamScriptIcon then
            local script = TeamManager:GetTeamScript(self.teamIndex)
            toggleIcon(self.teamScriptIcon, script and script ~= "")
        end

        local npcID = TeamManager:GetTeamNpcID(self.teamIndex)
        toggleIcon(self.teamNPCIcon, npcID and npcID ~= "")
    end
    self.teamNameText:SetShown(showTeamName)
    self.teamNoteIcon:SetShown(showTeamName)
    self.teamNoteButton:SetShown(showTeamName)
    self.teamNPCIcon:SetShown(showTeamName and TeamManager:GetAutoSwitchOnTarget())
    self.teamNPCButton:SetShown(showTeamName and TeamManager:GetAutoSwitchOnTarget())
    if self.teamScriptIcon then
        self.teamScriptIcon:SetShown(showTeamName)
        self.teamScriptButton:SetShown(showTeamName)
    end

    self:SetHeight(CalculateTeamHeight(self.teamIndex))

    if self.teamIndex and TeamManager:IsTeamLockedByUser(self.teamIndex) then
        self.teamNameText:SetTextColor(.95,1,.2)
    else
        self.teamNameText:SetTextColor(1,1,1)
    end

    if isSelected then
        self.selectedTexture:SetShown(not showLocked)
        self.lockedTexture:SetShown(showLocked)
    else
        self.selectedTexture:Hide()
        self.lockedTexture:Hide()
    end

    for i=1,#self.unitFrames do
        self.unitFrames[i]:UpdateWidget()
    end
end

function PetBattleTeamsFrame:SetTeam(teamIndex)
    assert(type(teamIndex) == "number")
    self.teamIndex = teamIndex

    self:Update()

    for i=1,#self.unitFrames do
        self.unitFrames[i]:SetPet(teamIndex,i)
    end
end

function PetBattleTeamsFrame:TEAM_UPDATED(event,teamIndex)
    if teamIndex == self.teamIndex or teamIndex == nil  then
        self:Update()
    end
end

function PetBattleTeamsFrame:TEAM_DELETED(event,teamIndex)
    if teamIndex <= self.teamIndex then
        self:Update()
    end
end

function PetBattleTeamsFrame:SELECTED_TEAM_CHANGED(event,teamIndex)
    self:Update()
end

function PetBattleTeamsFrame:PET_BATTLE_QUEUE_STATUS(event, status)
    self:Update()
end

function PetBattleTeamsFrame:BATTLE_PET_CURSOR_CHANGED(event,operation , petID, teamIndex, petIndex)
    local show =  operation == "MOVE TEAM"
    self.teamMovementFrame:SetShown(show)
end

function PetBattleTeamsFrame:ShowNoteEditor()
    if not self.teamIndex then return end

    self:HideEditors()
    local noteEditor = PetBattleTeams:GetModule("NoteEditor")
    if noteEditor then
        noteEditor:ShowEditor(self.teamIndex)
    end
end

function PetBattleTeamsFrame:DebugBattleNote()
    DEFAULT_CHAT_FRAME:AddMessage(L["PetBattle Teams"].." - debug note for team #" .. (self.teamIndex or ""), .5, .8, 1)
    if not self.teamIndex then return end

    local noteEditor = PetBattleTeams:GetModule("NoteEditor")
    if noteEditor then
        noteEditor:ShowBattleNote(self.teamIndex)
    end
end

function PetBattleTeamsFrame:ShowScriptEditor()
    if not self.teamIndex then return end

    self:HideEditors()

    local scriptEditor = PetBattleTeams:GetModule("ScriptEditor")
    if scriptEditor then
        scriptEditor:ShowEditor(self.teamIndex)
    end
end


function PetBattleTeamsFrame:HideEditors()
    if not self.teamIndex then return end

    local noteEditor = PetBattleTeams:GetModule("NoteEditor")
    if noteEditor then
        noteEditor:HideEditor(self.teamIndex)
    end
    local scriptEditor = PetBattleTeams:GetModule("ScriptEditor")
    if scriptEditor and scriptEditor:IsLoaded() then
        scriptEditor:HideEditor(self.teamIndex)
    end
end

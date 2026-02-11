local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local TeamManager =  PetBattleTeams:GetModule("TeamManager")
local GUI = PetBattleTeams:GetModule("GUI")
local Embed = PetBattleTeams.Embed
local RosterFrame = {}
local PetBattleTeamsFrame = PetBattleTeams.PetBattleTeamsFrame

local _, addon = ...
local L = addon.L
-- luacheck: globals FauxScrollFrame_Update FauxScrollFrame_GetOffset FauxScrollFrame_OnVerticalScroll

local function Update(self)
    local numToDisplay = self.scrollChild.numToDisplay
    local numTeams = TeamManager:GetNumTeams()
    local offset = FauxScrollFrame_GetOffset(self)
    local teamFrames = self.scrollChild.teamFrames
    local rowHeight = teamFrames[1]:GetHeight()

    FauxScrollFrame_Update(self, numTeams+1, numToDisplay, rowHeight)
    teamFrames = self.scrollChild.teamFrames

    for i=1,#teamFrames do
        teamFrames[i]:SetTeam(i+offset)
        local show = i <= numToDisplay and i+offset <= numTeams
        teamFrames[i]:SetShown(show)
    end
end

local function OnShow(self)
    Update(self)
end

local function OnVerticalScroll(self,offset)
    offset = offset or 0
    local teamFrames = self.scrollChild.teamFrames
    local rowHeight = teamFrames[1]:GetHeight()
    local currOffset =  FauxScrollFrame_GetOffset(self)  * rowHeight;
    local direction = (offset-currOffset)

    FauxScrollFrame_OnVerticalScroll(self, offset, rowHeight, Update);
end

local function OnScrollChildSizeChanged(self)
    local height = self:GetHeight()
    local team = self.teamFrames[1]
    local rowHeight = team:GetHeight()
    local numRows = math.floor(height / rowHeight)
    local numTeams = TeamManager:GetNumTeams()
    local rosterFrame = self:GetParent()
    for i=#self.teamFrames, numRows do
        if not self.teamFrames[i] then
            local team = PetBattleTeamsFrame:New()
            team:SetPoint("TOPLEFT", self.teamFrames[i-1], "BOTTOMLEFT")
            team:SetParent(self)
            team:SetTeam(i)
            self.teamFrames[i] = team
        end
    end

    self.numToDisplay = numRows
    if rosterFrame and rosterFrame.scrollFrame then
        rosterFrame.scrollFrame:SetPoint("BOTTOM", self.teamFrames[numRows], "BOTTOM")
        Update(rosterFrame.scrollFrame)
    end
end

local function CreateScollChild()
    local self  = CreateFrame("frame")
    local team = PetBattleTeamsFrame:New()
    local h, w = team:GetSize()

    self.teamFrames = {}

    team:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0) -- whole row
    team:SetTeam(1)
    team:SetParent(self)
    team:Show()

    self.teamFrames[1] = team
    --self:SetMinResize(h,w)
    self:SetResizeBounds(h,w) -- FIXME ? (widget:GetWidth(), ROW_HEIGHT * 2 + 150, widget:GetWidth(), ROW_HEIGHT * 11 + 150)
    self:SetSize(h,w)
    self.numToDisplay = 1
    self:SetScript("OnSizeChanged",OnScrollChildSizeChanged)
    self:Show()

    return self
end

local function CreateScrollFrame()
    local name = "PetBattleTeamsScrollFrame"
    local self = CreateFrame("ScrollFrame",name,nil,"FauxScrollFrameTemplate")

    self:EnableMouse(true)
    self:SetScript("OnVerticalScroll", OnVerticalScroll)
    self:SetScript("OnShow", OnShow)
    self:Show()
    self.OPTIONS_UPDATE = Update
    GUI.RegisterCallback(self, "OPTIONS_UPDATE")

    return self
end

local function CreateRosterFrame()
    local name = "PetBattleTeamsRosterFrame"
    local self = CreateFrame("frame",name)

    local scrollFrame = CreateScrollFrame()
    local scrollChild = CreateScollChild()
    local rosterText = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")

    self:SetWidth(158)
    self.rosterText = rosterText
    self.scrollChild = scrollChild
    self.scrollFrame = scrollFrame
    self:Show()

    rosterText:SetText(L["Team Roster"])
    rosterText:SetPoint("TOP", self, "TOP", 0, 0)
    rosterText:SetJustifyH("CENTER")
    rosterText:Show()

    scrollChild:SetParent(self)
    scrollChild:SetAllPoints()

    scrollChild:SetPoint("RIGHT", self, "RIGHT", -30, 0)
    scrollChild:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -20)

    scrollFrame.scrollChild = scrollChild
    scrollFrame:SetParent(self)
    scrollFrame:SetAllPoints(scrollChild)

    self.ResetScrollBar = function(self)
        local teamFrames = self.scrollChild.teamFrames
        local rowHeight = teamFrames[1]:GetHeight()
        FauxScrollFrame_OnVerticalScroll(self.scrollFrame, 0, rowHeight, Update);
    end
    return self
end


function RosterFrame:New()
    local rosterFrame = CreateRosterFrame()
    Embed(rosterFrame,RosterFrame)
    Update(rosterFrame.scrollFrame)

    TeamManager.RegisterCallback(rosterFrame,"TEAM_DELETED")
    TeamManager.RegisterCallback(rosterFrame,"TEAM_CREATED")
    TeamManager.RegisterCallback(rosterFrame,"TEAM_UPDATED")
    return rosterFrame
end

function RosterFrame:TEAM_DELETED(event,teamIndex)
    Update(self.scrollFrame)
end

function RosterFrame:TEAM_CREATED(event,teamIndex)
    Update(self.scrollFrame)
end

function RosterFrame:TEAM_UPDATED(event,teamIndex)
    Update(self.scrollFrame)
end

function GUI:CreateScrollBar()
    return RosterFrame:New()
end

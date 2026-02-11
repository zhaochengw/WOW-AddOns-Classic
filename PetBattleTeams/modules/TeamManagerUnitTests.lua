local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local FINISHED = 6

PetBattleTeams.TeamManagerUnitTests = {}
PetBattleTeams.TeamManagerUnitTests.tests = {}

function PetBattleTeams.TeamManagerUnitTests:Setup(teamManager)
    self.TeamManager = {
        callbacks = LibStub("CallbackHandler-1.0"):New(self),
        frame = CreateFrame("frame"),
        db = {
            global = {
                teams = {},
                selected = 0,
                dismissPet = false,
                hasImported = false,
                userLocked = false,
                showTeamName = true,
                showXpInLevel = true,
                showXpInHealthBar = false,
                automaticallySaveTeams = false,
                ignoreEmptyPets = false,
            }
        },
    -- Assuming the .toc says ## SavedVariables: MyAddonDB
    }
    self.TeamManager.frame.step = FINISHED
    self.TeamManager.teams = self.TeamManager.db.global.teams

    for k,v in pairs(teamManager) do
        if type(v) == "function" then
            self.TeamManager[k] = v
        end
    end
end


function PetBattleTeams.TeamManagerUnitTests:TearDown()
    self.TeamManager.db.global = {
        teams = {},
        selected = 0,
        dismissPet = false,
        hasImported = false,
        userLocked = false,
        showTeamName = true,
        showXpInLevel = true,
        showXpInHealthBar = false,
        automaticallySaveTeams = false,
        ignoreEmptyPets = false,
    }
end

--/run TeamManagerUnitTests:Run()
function PetBattleTeams.TeamManagerUnitTests:Run()
    local teamManager = PetBattleTeams:GetModule("TeamManager")
    self:Setup(teamManager)

    for k,v in pairs(self.tests) do
        local status , err = pcall(v,self)
        print(k, status and "passed" or err)
        self:TearDown()
    end
end

function PetBattleTeams.TeamManagerUnitTests.tests:TestCreateTeam_WithRealUnits()
    --select 3 pets that can be put in slots
    self.TeamManager:CreateTeam()
    assert(#self.TeamManager.teams ==1,"Team count "..#self.TeamManager.teams )
    assert(#self.TeamManager.teams[1] == 3, "Team doesnt have enough pets")
    assert(#self.TeamManager.teams[1].enabled == 3, "enabled missing entries")
    assert(self.TeamManager:GetSelected() == 1, "Wrong team selected")
end



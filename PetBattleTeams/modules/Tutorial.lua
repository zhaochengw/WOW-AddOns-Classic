local PetBattleTeams = LibStub("AceAddon-3.0"):GetAddon("PetBattleTeams")
local pbtTutorials = PetBattleTeams:NewModule("Tutorials")
local TutorialsLib = LibStub("CustomTutorials-2.0")

TutorialsLib:Embed(pbtTutorials)

pbtTutorials:RegisterTutorials({
    savedvariable = "PetBattleTeams_TutorialsSavedVariable",
    title = "MyAddons",
    {  -- This is tutorial #1
        text = "Hello",
        image = "Interface\\Addons\\PetBattleTeams\\MoveTeam",
    },
    {  -- Tutorial #2
        text = "Bye",
    }
})


--/run pbtTutorials:TriggerTutorial(1)
















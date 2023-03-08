-- Access the namespace
local _, core = ...;

local CharacterStatsWrathFrame = CreateFrame("Frame");
CharacterStatsWrathFrame:RegisterEvent("UNIT_RESISTANCES");
CharacterStatsWrathFrame:RegisterEvent("UNIT_STATS");
CharacterStatsWrathFrame:RegisterEvent("UNIT_AURA");
CharacterStatsWrathFrame:RegisterUnitEvent("UNIT_MAXHEALTH", "player");
CharacterStatsWrathFrame:RegisterEvent("UNIT_DAMAGE");
CharacterStatsWrathFrame:RegisterEvent("UNIT_RANGEDDAMAGE");
CharacterStatsWrathFrame:RegisterEvent("PLAYER_DAMAGE_DONE_MODS");
CharacterStatsWrathFrame:RegisterEvent("UNIT_ATTACK_SPEED");
CharacterStatsWrathFrame:RegisterEvent("UNIT_ATTACK_POWER");
CharacterStatsWrathFrame:RegisterEvent("UNIT_RANGED_ATTACK_POWER");
CharacterStatsWrathFrame:RegisterEvent("UNIT_ATTACK");
CharacterStatsWrathFrame:RegisterEvent("SKILL_LINES_CHANGED");
CharacterStatsWrathFrame:RegisterEvent("VARIABLES_LOADED");
CharacterStatsWrathFrame:RegisterEvent("COMBAT_RATING_UPDATE");
CharacterStatsWrathFrame:RegisterEvent("GROUP_ROSTER_UPDATE");

CharacterStatsWrathFrame:SetScript("OnEvent",
    function(self, event, ...)

        local args = {...};

        if event == "VARIABLES_LOADED" then
            core.UIConfig:UpdateStats();
            core.UIConfig:UpdateSideStats();
        end

        if not core.UIConfig.CharacterStatsPanel:IsVisible() then
            return;
        end

        if args[1] == "player" then
            if ( event == "UNIT_RESISTANCES" or
                event == "UNIT_STATS" or
                event == "UNIT_AURA" or
                event == "UNIT_MAXHEALTH" or
				event == "UNIT_DAMAGE" or
                event == "UNIT_RANGEDDAMAGE" or
				event == "PLAYER_DAMAGE_DONE_MODS" or
				event == "UNIT_ATTACK_SPEED" or
                event == "UNIT_ATTACK_POWER" or
                event == "UNIT_RANGED_ATTACK_POWER" or
				event == "UNIT_ATTACK" or
				event == "SKILL_LINES_CHANGED" or
                event == "COMBAT_RATING_UPDATE" or
                event == "GROUP_ROSTER_UPDATE") then
                self:SetScript("OnUpdate", CSC_QueuedUpdate);
            end
        end
    end)

function CSC_QueuedUpdate(self)
    self:SetScript("OnUpdate", nil);
    
    if core.UIConfig.CharacterStatsPanel:IsVisible() then
        core.UIConfig:UpdateStats();
    end

    core.UIConfig:UpdateSideStats();
end

-- Exposing global functions for showing/hiding the stats panel. For compatibility with other addons
function CSC_HideStatsPanel()
    core.UIConfig.CharacterStatsPanel:Hide();
    core.UIConfig:SetStatsPanelVisibile(false);
end

function CSC_ShowStatsPanel()
    core.UIConfig.CharacterStatsPanel:Show();
    core.UIConfig:UpdateStats();
    core.UIConfig:UpdateSideStats();
    core.UIConfig:SetStatsPanelVisibile(true);
end

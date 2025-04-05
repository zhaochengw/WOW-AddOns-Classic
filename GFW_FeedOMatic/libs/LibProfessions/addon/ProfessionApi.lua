local addon = _G['LibProfessions-v0.11']
if not addon then
    -- luacov: disable
    return    -- already loaded and no upgrade necessary
    -- luacov: enable
end

---@class LibProfessionAPI A library to make similar profession API calls for classic and BfA
local api = addon.api

function api:IsReady()
    if addon.is_classic then --Professions are always ready in classic
        return true
    elseif not _G.C_TradeSkillUI.IsTradeSkillReady() or _G.C_TradeSkillUI.IsDataSourceChanging() then
        return false
    else
        return true
    end
end

--- Get info about the current profession
--- @return string Profession name
--- @return number Current skill
--- @return number Maximum skill
--- @return number Skill modifier (Not classic)
--- @return number Profession ID (Not classic)
function api:GetInfo()
    if addon.is_classic then
        return _G.GetTradeSkillLine();
    else
        local tradeSkillID, skillLineName, skillLineRank, skillLineMaxRank, skillLineModifier,
        parentSkillLineID, parentSkillLineName = _G.C_TradeSkillUI.GetTradeSkillLine()
        return parentSkillLineName or skillLineName, skillLineRank, skillLineMaxRank, skillLineModifier,
        parentSkillLineID or tradeSkillID
    end
end

--/dump LibStub("LibProfessionAPI-1.0"):GetName()
--- deprecated Use GetInfo
function api:GetName()
    return self:GetInfo()
end

--- Get the number of recipes learned
--- This is currently working only in WoW classic
--- @return number Number of recipes
function api:NumRecipes()
	--TODO: Not working in BfA
    return _G.GetNumTradeSkills()
end

--- Get the number of reagents for a recipe
--- @param recipeID number Recipe ID
--- @return number Number of reagents
function api:NumReagents(recipeID)
    if addon.is_classic then
        return _G.GetTradeSkillNumReagents(recipeID)
    else
        return _G.C_TradeSkillUI.GetRecipeNumReagents(recipeID)
    end
end


--- Get item link for a reagent
--- @param recipeID number Recipe ID
--- @param reagentIndex number Reagent index
function api:GetReagentItemLink(recipeID, reagentIndex)
    if addon.is_classic then
        return _G.GetTradeSkillReagentItemLink(recipeID, reagentIndex);
    else
        return _G.C_TradeSkillUI.GetRecipeReagentItemLink(recipeID, reagentIndex);
    end
end

--/dump LibStub("LibProfessionAPI-1.0"):GetReagentInfo(2,1)
--- Get information about a reagent
--- @param recipeID number Recipe ID (BfA) or recipe index (Classic)
--- @param reagentIndex number Reagent index
function api:GetReagentInfo(recipeID, reagentIndex)
    if addon.is_classic then
        return _G.GetTradeSkillReagentInfo(recipeID, reagentIndex);
    else
        return _G.C_TradeSkillUI.GetRecipeReagentInfo(recipeID, reagentIndex)
    end
end
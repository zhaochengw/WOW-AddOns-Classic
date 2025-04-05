local _, ns = ...

-- Returns true if the game version is classic, false otherwise.
function ns:IsClassic()
    return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

-- Returns true if the game version is TBC, false otherwise.
function ns:IsTBC()
    return WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC
end

-- Returns true if the game version is WotLK, false otherwise.
function ns:IsWOTLK()
    return WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC
end

-- Returns true if the game version is Season of Dicovery.
function ns:IsSoD()
    return Enum.SeasonID.SeasonOfDiscovery and C_Seasons.GetActiveSeason() == Enum.SeasonID.SeasonOfDiscovery
end

if GetLocale() ~= "ptBR" then
	return
end

local L

--------------------
--  World Bosses  --
-------------------------
-- Akma'hat --
-------------------------
L = DBM:GetModLocalization("Akmahat")

L:SetGeneralLocalization{
	name = "Akma'hat"
}

-----------
-- Garr --
----------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "Garr (Cata)"
}

----------------
-- Julak-Doom --
----------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "Julak-Doom"
}

L:SetOptionLocalization{
	SetIconOnMC	= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(93621)
}

-----------
-- Mobus --
-----------
L = DBM:GetModLocalization("Mobus")

L:SetGeneralLocalization{
	name = "Mobus"
}

-----------
-- Xariona --
-----------
L = DBM:GetModLocalization("Xariona")

L:SetGeneralLocalization{
	name = "Xariona"
}

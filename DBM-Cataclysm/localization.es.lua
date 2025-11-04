if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then
	return
end
local L

--------------------
-- Jefes de mundo --
--------------------
--------------
-- Akma'hat --
--------------
L = DBM:GetModLocalization("Akmahat")

L:SetGeneralLocalization{
	name = "Akma'hat"
}

----------
-- Garr --
----------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "Garr"
}

---------------------
-- Julak Fatalidad --
---------------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "Julak Fatalidad"
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

-------------
-- Xariona --
-------------
L = DBM:GetModLocalization("Xariona")

L:SetGeneralLocalization{
	name = "Xariona"
}

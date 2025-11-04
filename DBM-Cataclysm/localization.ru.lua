if GetLocale() ~= "ruRU" then
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
	name = "Акма'хат"
}

-----------
-- Garr --
----------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "Гарр"
}

----------------
-- Julak-Doom --
----------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "Джулак-Рок"
}

-----------
-- Mobus --
-----------
L = DBM:GetModLocalization("Mobus")

L:SetGeneralLocalization{
	name = "Мобус"
}

-----------
-- Xariona --
-----------
L = DBM:GetModLocalization("Xariona")

L:SetGeneralLocalization{
	name = "Зариона"
}

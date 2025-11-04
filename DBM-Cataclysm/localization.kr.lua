if GetLocale() ~= "koKR" then
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
	name = "아크마하트"
}

-----------
-- Garr --
----------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "가르"
}

----------------
-- Julak-Doom --
----------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "줄락둠"
}

-----------
-- Mobus --
-----------
L = DBM:GetModLocalization("Mobus")

L:SetGeneralLocalization{
	name = "모부스"
}

-----------
-- Xariona --
-----------
L = DBM:GetModLocalization("Xariona")

L:SetGeneralLocalization{
	name = "자리오나"
}

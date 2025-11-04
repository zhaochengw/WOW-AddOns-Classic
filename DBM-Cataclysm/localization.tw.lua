if GetLocale() ~= "zhTW" then
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
	name = "阿克瑪哈特"
}

-----------
-- Garr --
----------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "加爾(浩劫與重生)"
}

----------------
-- Julak-Doom --
----------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "毀滅祖拉克"
}

-----------
-- Mobus --
-----------
L = DBM:GetModLocalization("Mobus")

L:SetGeneralLocalization{
	name = "莫比斯"
}

-----------
-- Xariona --
-----------
L = DBM:GetModLocalization("Xariona")

L:SetGeneralLocalization{
	name = "克薩瑞歐納"
}

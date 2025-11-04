if GetLocale() ~= "zhCN" then
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
	name = "阿卡玛哈特"
}

-----------
-- Garr --
----------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "加尔（大地的裂变）"
}

----------------
-- Julak-Doom --
----------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "厄运尤拉克"
}

-----------
-- Mobus --
-----------
L = DBM:GetModLocalization("Mobus")

L:SetGeneralLocalization{
	name = "魔布斯"
}

-------------
-- Xariona --
-------------
L = DBM:GetModLocalization("Xariona")

L:SetGeneralLocalization{
	name = "埃克萨妮奥娜"
}

-- Generated Data : Do Not Modify
if not Talented_Data then return end
do -- default language, check if a name has already been inserted
	local _, v = next(Talented_Data)
	if not v or v[1].info.name then return end
end
local data, tree
data = Talented_Data.HUNTER
if data then
	tree = data[1]
	tree.info.name = "Beast Mastery"
	tree = data[2]
	tree.info.name = "Marksmanship"
	tree = data[3]
	tree.info.name = "Survival"
end
data = Talented_Data.WARRIOR
if data then
	tree = data[1]
	tree.info.name = "Arms"
	tree = data[2]
	tree.info.name = "Fury"
	tree = data[3]
	tree.info.name = "Protection"
end
data = Talented_Data.SHAMAN
if data then
	tree = data[1]
	tree.info.name = "Elemental"
	tree = data[2]
	tree.info.name = "Enhancement"
	tree = data[3]
	tree.info.name = "Restoration"
end
data = Talented_Data.MAGE
if data then
	tree = data[1]
	tree.info.name = "Arcane"
	tree = data[2]
	tree.info.name = "Fire"
	tree = data[3]
	tree.info.name = "Frost"
end
data = Talented_Data.PRIEST
if data then
	tree = data[1]
	tree.info.name = "Discipline"
	tree = data[2]
	tree.info.name = "Holy"
	tree = data[3]
	tree.info.name = "Shadow"
end
data = Talented_Data.WARLOCK
if data then
	tree = data[1]
	tree.info.name = "Affliction"
	tree = data[2]
	tree.info.name = "Demonology"
	tree = data[3]
	tree.info.name = "Destruction"
end
data = Talented_Data.ROGUE
if data then
	tree = data[1]
	tree.info.name = "Assassination"
	tree = data[2]
	tree.info.name = "Combat"
	tree = data[3]
	tree.info.name = "Subtlety"
end
data = Talented_Data.DRUID
if data then
	tree = data[1]
	tree.info.name = "Balance"
	tree = data[2]
	tree.info.name = "Feral Combat"
	tree = data[3]
	tree.info.name = "Restoration"
end
data = Talented_Data.PALADIN
if data then
	tree = data[1]
	tree.info.name = "Holy"
	tree = data[2]
	tree.info.name = "Protection"
	tree = data[3]
	tree.info.name = "Retribution"
end

-- Generated Data : Do Not Modify
if not Talented_Data then return end
if GetLocale() ~= "frFR" then return end
Talented:Print("Localisation for talent tooltips is missing for this language. If you would like to contribute, please visit the Github and use the Talented_Data_Export addon.")
local data, tree
data = Talented_Data.HUNTER
if data then
	tree = data[1]
	tree.info.name = "Maîtrise des bêtes"
	tree = data[2]
	tree.info.name = "Précision"
	tree = data[3]
	tree.info.name = "Survie"
end
data = Talented_Data.WARRIOR
if data then
	tree = data[1]
	tree.info.name = "Armes"
	tree = data[2]
	tree.info.name = "Fureur"
	tree = data[3]
	tree.info.name = "Protection"
end
data = Talented_Data.SHAMAN
if data then
	tree = data[1]
	tree.info.name = "Élémentaire"
	tree = data[2]
	tree.info.name = "Amélioration"
	tree = data[3]
	tree.info.name = "Restauration"
end
data = Talented_Data.MAGE
if data then
	tree = data[1]
	tree.info.name = "Arcanes"
	tree = data[2]
	tree.info.name = "Feu"
	tree = data[3]
	tree.info.name = "Givre"
end
data = Talented_Data.PRIEST
if data then
	tree = data[1]
	tree.info.name = "Discipline"
	tree = data[2]
	tree.info.name = "Sacré"
	tree = data[3]
	tree.info.name = "Ombre"
end
data = Talented_Data.WARLOCK
if data then
	tree = data[1]
	tree.info.name = "Affliction"
	tree = data[2]
	tree.info.name = "Démonologie"
	tree = data[3]
	tree.info.name = "Destruction"
end
data = Talented_Data.ROGUE
if data then
	tree = data[1]
	tree.info.name = "Assassinat"
	tree = data[2]
	tree.info.name = "Combat"
	tree = data[3]
	tree.info.name = "Finesse"
end
data = Talented_Data.DRUID
if data then
	tree = data[1]
	tree.info.name = "Équilibre"
	tree = data[2]
	tree.info.name = "Combat farouche"
	tree = data[3]
	tree.info.name = "Restauration"
end
data = Talented_Data.PALADIN
if data then
	tree = data[1]
	tree.info.name = "Sacré"
	tree = data[2]
	tree.info.name = "Protection"
	tree = data[3]
	tree.info.name = "Vindicte"
end

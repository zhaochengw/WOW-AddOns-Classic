-- Generated Data : Do Not Modify
if not Talented_Data then return end
if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
Talented:Print("Localisation for talent tooltips is missing for this language. If you would like to contribute, please visit the Github and use the Talented_Data_Export addon.")
local data, tree
data = Talented_Data.HUNTER
if data then
	tree = data[1]
	tree.info.name = "Dominio de bestias"
	tree = data[2]
	tree.info.name = "Puntería"
	tree = data[3]
	tree.info.name = "Supervivencia"
end
data = Talented_Data.WARRIOR
if data then
	tree = data[1]
	tree.info.name = "Armas"
	tree = data[2]
	tree.info.name = "Furia"
	tree = data[3]
	tree.info.name = "Protección"
end
data = Talented_Data.SHAMAN
if data then
	tree = data[1]
	tree.info.name = "Elemental"
	tree = data[2]
	tree.info.name = "Mejora"
	tree = data[3]
	tree.info.name = "Restauración"
end
data = Talented_Data.MAGE
if data then
	tree = data[1]
	tree.info.name = "Arcano"
	tree = data[2]
	tree.info.name = "Fuego"
	tree = data[3]
	tree.info.name = "Escarcha"
end
data = Talented_Data.PRIEST
if data then
	tree = data[1]
	tree.info.name = "Disciplina"
	tree = data[2]
	tree.info.name = "Sagrado"
	tree = data[3]
	tree.info.name = "Sombras"
end
data = Talented_Data.WARLOCK
if data then
	tree = data[1]
	tree.info.name = "Aflicción"
	tree = data[2]
	tree.info.name = "Demonología"
	tree = data[3]
	tree.info.name = "Destrucción"
end
data = Talented_Data.ROGUE
if data then
	tree = data[1]
	tree.info.name = "Asesinato"
	tree = data[2]
	tree.info.name = "Combate"
	tree = data[3]
	tree.info.name = "Sutileza"
end
data = Talented_Data.DRUID
if data then
	tree = data[1]
	tree.info.name = "Equilibrio"
	tree = data[2]
	tree.info.name = "Combate feral"
	tree = data[3]
	tree.info.name = "Restauración"
end
data = Talented_Data.PALADIN
if data then
	tree = data[1]
	tree.info.name = "Sagrado"
	tree = data[2]
	tree.info.name = "Protección"
	tree = data[3]
	tree.info.name = "Reprensión"
end

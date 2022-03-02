local select = select
local ipairs = ipairs
local GetTalentInfo = GetTalentInfo
local Talented = Talented

local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

-- function Talented:UpdatePlayerSpecs()
-- 	if GetNumTalentTabs() == 0 then return end
-- 	local class = select(2, UnitClass"player")
-- 	local info = self:UncompressSpellData(class)
-- 	if not self.alternates then self.alternates = {} end
-- 	for talentGroup = 1, GetNumTalentGroups() do
-- 		local template = self.alternates[talentGroup]
-- 		if not template then
-- 			template = {
-- 				talentGroup = talentGroup,
-- 				name = talentGroup == 1 and TALENT_SPEC_PRIMARY or TALENT_SPEC_SECONDARY,
-- 				class = class,
-- 			}
-- 		else
-- 			template.points = nil
-- 		end
-- 		for tab, tree in ipairs(info) do
-- 			local ttab = template[tab]
-- 			if not ttab then
-- 				ttab = {}
-- 				template[tab] = ttab
-- 			end
-- 			for index = 1, #tree do
-- 				ttab[index] = select(5, GetTalentInfo(tab, index, nil, nil, talentGroup))
-- 			end
-- 		end
-- 		self.alternates[talentGroup] = template
-- 		if self.template == template then
-- 			self:UpdateTooltip()
-- 		end
-- 		for _, view in self:IterateTalentViews(template) do
-- 			view:Update()
-- 		end
-- 	end
-- end

function Talented:UpdateCurrentTemplate()
	local class = select(2, UnitClass"player")
	local template = self.current
	local info

	if not template then
		local class = select(2, UnitClass("player"))
		template = {
			name = "Current",
			class = class,
		}
		info = self:GetTalentInfo(class)
		if not info then
			error(("Unable to get talent for class %s, %s"):format(class, "player"))
		end
		for tab, tree in ipairs(info) do
			template[tab] = { talents = {} }
		end
		self.current = template
		
	else
		template.points = nil
		info = self:GetTalentInfo(template.class)
	end

	local total = 0 
	for tab, tree in ipairs(info) do
		for index, info in ipairs(tree.talents) do
			local rank = select(5, GetTalentInfo(tab, index))
			template[tab][index] = rank
			total = total + rank
		end
	end
	self.maxpoints = total + UnitCharacterPoints("player") 

	if self.template == self.current then
		self:UpdateTooltip()
	end

end

-- function Talented:GetActiveSpec()
-- 	if not self.alternates then self:UpdatePlayerSpecs() end
-- 	return self.alternates[GetActiveTalentGroup()]
-- end

function Talented:UpdateView()
	if not self.base then return end
	self.base.view:Update()
end

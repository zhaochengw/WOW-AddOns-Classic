local Talented = Talented
local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

local reset = function(...)
	if select("#", ...) > 0 then
		Talented:Print(...)
	end
	Talented:SetTemplate()
	Talented:EnableUI(true)
end

function Talented:ApplyCurrentTemplate()
	local template = self.template
	if select(2, UnitClass"player") ~= template.class then
		self:Print(L["Sorry, I can't apply this template because it doesn't match your class!"])
		self.mode = "view"
		self:UpdateView()
		return
	end
	local count = 0
	local current = self.current
	-- check if enough talent points are available
	local available = UnitCharacterPoints("player")
	for tab, tree in ipairs(self:GetTalentInfo(template.class)) do
		for index = 1, #tree.talents do
			local delta = template[tab][index] - self.current[tab][index]
			if delta > 0 then
				count = count + delta
			end
		end
	end
	if count == 0 then
		self:Print(L["Nothing to do"])
		self.mode = "view"
		self:UpdateView()
	elseif count > available then
		self:Print(L["Sorry, I can't apply this template because you don't have enough talent points available (need %d)!"], count)
		self.mode = "view"
		self:UpdateView()
	else
		self:EnableUI(false)
		self:ApplyNextTalentPoint()
	end
end

--Interestingly, in the vanilla API, it seems that LearnTalent doesn't return fast enough:
  -- doing GetTalentInfo or UnitCharacterPoints immediately after LearnTalent DOESN'T yield changed values.
  -- Will need to use the old method in TBC, of trying to learn the next talent point after each 
  -- CHARACTER_POINTS_CHANGED -- see core.lua.

-- function Talented:ApplyTalentPoints()
-- 	local template = self.template
-- 	local current = self.current
-- 	local cp = UnitCharacterPoints("player")

-- 	while true do
-- 		local missing, set
-- 		--Loop over all trees and talents, and try to spend a point
-- 		for tab, tree in ipairs(self:GetTalentInfo(template.class)) do
-- 			local ttab = template[tab]
-- 			for index = 1, #tree.talents do
-- 				local rank = select(5, GetTalentInfo(tab, index, nil))
-- 				local delta = ttab[index] - rank

-- 				--If this talent has a higher rank in the template than current talents, then try to increase it
-- 				if delta > 0 then
-- 					self:LearnTalent(tab, index)
-- 					local nrank = select(5, GetTalentInfo(tab, index, nil)) --What is the rank now?
-- 					if nrank < ttab[index] then
-- 						missing = true --Is the new rank less than the tamplet: are there still points to apply?
-- 					elseif nrank > rank then
-- 						set = true --Did we actually do something?
-- 					end
-- 					cp = cp - nrank + rank
-- 				end
-- 			end
-- 		end
-- 		if (not missing) or cp<=0 then break end
-- 		if not set then -- make sure we did something
-- 			Talented:Print(L["Warning - no action was taken, or we ran out of talent points."]) 
-- 			break
-- 		end
-- 	end
-- 	if cp < 0 then
-- 		Talented:Print(L["Error while applying talents! Not enough talent points!"])
-- 	end
-- 	Talented:EnableUI(true)
-- end

function Talented:ApplyNextTalentPoint()
	local cp = UnitCharacterPoints("player")
	
	local found = false
	local current = self.current
	local template = self.template
	local class = template.class
	assert(select(2, UnitClass"player") == template.class, "Player class doesn't match template class")
	for tab, tree in ipairs(self:GetTalentInfo(class)) do
		local ctab = current[tab]
		local ttab = template[tab]
		for index in ipairs(tree.talents) do
			local cvalue = ctab[index]
			if cvalue < ttab[index] then
				if cp == 0 then
					reset(L["Error while applying talents! Not enough talent points!"])
					return
				end
				found = true
				if self:ValidateTalentBranch(current, tab, index, cvalue + 1) then
					LearnTalent(tab, index) --Don't use self:LearnTalent; don't want to confirm learning
					return
				end
			end
		end
	end
	if not found then
		reset(L["Template applied successfully, %d talent points remaining."], cp)
	else
		reset(L["Error while applying talents! Invalid template!"])
	end
end

function Talented:CheckTalentPointsApplied()
	local template = self.template
	local current = self.current
	local failed
	for tab, tree in ipairs(self:GetTalentInfo(template.class)) do
		local ttab = template[tab]
		for index = 1, #tree do
			local delta = ttab[index] - select(5, GetTalentInfo(tab, index, nil))
			if delta > 0 then
				failed = true
				break
			end
		end
	end
	if failed then
		Talented:Print(L["Error while applying talents! some of the request talents were not set!"])
	else
		local cp = UnitCharacterPoints("player")
		Talented:Print(L["Template applied successfully, %d talent points remaining."], cp)
	end
	Talented:OpenTemplate(template)
	Talented:EnableUI(true)

	return not failed
end

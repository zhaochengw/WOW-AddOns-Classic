local Talented = Talented
local ipairs = ipairs
local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

function Talented:IsTemplateAtCap(template)
	local max = RAID_CLASS_COLORS[template.class] and 61 or 20 --Level 70 is max
	return self.db.profile.level_cap and self:GetPointCount(template) >= max
end

function Talented:GetPointCount(template)
	local total = 0
	local info = self:GetTalentInfo(template.class)
	for tab in ipairs(info) do
		total = total + self:GetTalentTabCount(template, tab)
	end
	return total
end

function Talented:GetTalentTabCount(template, tab)
	local total = 0
	for _, value in ipairs(template[tab]) do
		total = total + value
	end
	return total
end

function Talented:ClearTalentTab(tab)
	local template = self.template
	if template and template ~= template.current and self.mode == "edit" then
		local tab = template[tab]
		for index, value in ipairs(tab) do
			tab[index] = 0
		end
	end
	self:UpdateView()
end

function Talented:GetSkillPointsPerTier(class)
	-- Player Tiers are 5 points apart, Pet Tiers are only 3 points apart.
	return RAID_CLASS_COLORS[class] and 5 or 3
end

function Talented:GetTalentState(template, tab, index)
	local s
	local info = self:GetTalentInfo(template.class)[tab].talents[index].info
	local tier = (info.row - 1) * self:GetSkillPointsPerTier(template.class)
	local count = self:GetTalentTabCount(template, tab)

	if count < tier then
		s = false
	else
		s = true
		if info.prereqs and self:GetTalentState(template, tab, info.prereqs[1].source) ~= "full" then
			s = false
		end
	end

	if not s then --or info.inactive 
		s = "unavailable"
	else
		local value = template[tab][index]
		if value == info.ranks then
		-- if value == #info.ranks then TODO: This will be needed when ranks is an array
			s = "full"
		elseif value == 0 then
			s = "empty"
		else
			s = "available"
		end
	end
	return s
end

function Talented:ValidateTalentBranch(template, tab, index, newvalue)
	local count = 0
	local pointsPerTier = self:GetSkillPointsPerTier(template.class)
	local tree = self:GetTalentInfo(template.class)[tab]
	local ttab = template[tab] --n.b. NOT .talents
	for i, talent in ipairs(tree.talents) do
		local value = i == index and newvalue or ttab[i]
		if value > 0 then
			local tier = (talent.info.row - 1) * pointsPerTier
			if count < tier then
				self:Debug("Update refused because of tier")
				return false
			end
			local r = talent.info.prereqs
			if r then
				rs = r[1].source
				local rvalue = rs == index and newvalue or ttab[rs]
				if rvalue < tree.talents[rs].info.ranks then
					self:Debug("Update refused because of prereq")
					return false
				end
			end
			count = count + value
		end
	end
	return true
end

function Talented:ValidateTemplate(template, fix)
	local class = template.class
	if not class then return end
	
	local pointsPerTier = self:GetSkillPointsPerTier(template.class)
	local info = self:GetTalentInfo(class)
	if not info then
		--Couldn't load data, cannot validate template.
		--Returning false here would delete the template, so return true.
		return true
	end
	
	local fixed
	for tab, tree in ipairs(info) do
		local t = template[tab] --NOT .talents
		if not t then return end
		local count = 0
		for i, talent in ipairs(tree.talents) do
			local value = t[i]
			if not value then return end
			if value > 0 then
				if count < (talent.info.row - 1) * pointsPerTier or value > ((talent.inactive and 0) or talent.info.ranks) then 
					if fix then t[i], value, fixed = 0, 0, true else return end
				end
				local r = talent.info.prereqs
				if r then
					rs = r[1].source
					if t[rs] < tree.talents[rs].info.ranks then 
						if fix then t[i], value, fixed = 0, 0, true else return end
					end
				end
				count = count + value
			end
		end
	end
	if fixed then
		self:Print(L["The template '%s' had inconsistencies and has been fixed. Please check it before applying."], template.name)
		template.points = nil
	end
	return true
end

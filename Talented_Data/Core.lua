Talented_Data = LibStub("AceAddon-3.0"):NewAddon("Talented_Data", "AceEvent-3.0")
local G = LibStub("LibGratuity-3.0")

local locale = GetLocale()

function Talented_Data:OnInitialize()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")
end

function Talented_Data:OnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        self:RegisterEvent("CHARACTER_POINTS_CHANGED", "GetData")
    end
end

function Talented_Data:GetData()
	local _, class = UnitClass("player")

	local data = Talented_DataDB
	if not data then
		data = {}
		Talented_DataDB = data
	end
	
	local branches = data[class]
	if not branches then
		branches = {}
		data[class] = branches
	end
		
	for tab = 1, GetNumTalentTabs() do
		local branch = branches[tab]
		if not branch then
			branch = {}
			branches[tab] = branch
		end
		if not branch.info then
			local _, icon, _, background = GetTalentTabInfo(tab)
			branch.info = {
				icon = icon,
				background = background,
				names = {}
			}
		end
		if not branch.info.names[locale] then
			branch.info.names[locale] = GetTalentTabInfo(tab)
		end
		local talents = branch.talents
		if not talents then
			talents = {}
			branch.talents = talents
		end
		for index = 1, GetNumTalents(tab) do
			local talent = talents[index]
			if not talent then
				talent = {}
				talents[index] = talent
			end
			if not talent.info then
				local _, icon, row, column, _, ranks, exceptional = GetTalentInfo(tab, index)
				talent.info = {
					icon = icon,
					row = row,
					column = column,
					ranks = ranks,
					exceptional = exceptional,
					names = {},
					prereqs = {}
				}
				local prereqs = talent.info.prereqs
				local fill = function (...)
					for i = 1, select("#", ...), 3 do
						local row, column = select(i, ...)
						prereqs[#prereqs + 1] = { row = row, column = column }
					end
				end
				fill(GetTalentPrereqs(tab, index))
			end
			if not talent.info.names[locale] then
				talent.info.names[locale] = GetTalentInfo(tab, index)
			end
			local tips = talent.tips
			if not tips then
				tips = {}
				talent.tips = tips
			end
			if not tips[locale] then
				tips[locale] = {}
			end
			tips = tips[locale]
			local _, _, _, _, c = GetTalentInfo(tab, index)
			if not tips[c] then
				G:SetTalent(tab, index)
				for i = G:NumLines(), 1, -1 do
					local l = G:GetLine(i)
					if l then
						tips[c] = l
						break
					end
				end
			end
		end
	end
end

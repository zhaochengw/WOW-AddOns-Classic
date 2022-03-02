local select = select
local ipairs = ipairs
local Talented = Talented

local L = LibStub("AceLocale-3.0"):GetLocale("Talented")
local AceAddon = LibStub("AceAddon-3.0")
local G

local BuildTalentInfo
do
	local GetNumTalentTabs = GetNumTalentTabs
	local GetTalentTabInfo = GetTalentTabInfo
	local GetNumTalents = GetNumTalents
	local GetTalentInfo = GetTalentInfo
	local GetTalentPrereqs = GetTalentPrereqs
	local TOOLTIP_TALENT_LEARN = TOOLTIP_TALENT_LEARN
	
	local function FillPrereqs(...)
		if select("#", ...) < 3 then return end
		local table = {}
		for i = 1, select("#", ...), 3 do
			local row, column = select(i, ...)
			table[#table + 1] = { row = row, column = column }
		end
		return table
	end
	
	function BuildTalentInfo(inspect)
		if not G then
			G = LibStub("LibGratuity-3.0")
		end
		local result = {
		}

		for tab = 1, GetNumTalentTabs(inspect) do
			local name, icon, _, background = GetTalentTabInfo(tab, inspect)
			result[tab] = {
				info = {
					name = name,
					icon = icon,
					background = background,
				},
				talents = {},
				numtalents = 0
			}
			local talents = result[tab].talents
			local count = 0
			for index = 1, GetNumTalents(tab, inspect) do
				local name, icon, row, column, rank, ranks, exceptional = GetTalentInfo(tab, index, inspect)
				G:SetTalent(tab, index, inspect)
				local n = G:NumLines()
				local tips = G:GetLine(n)
				if tips == TOOLTIP_TALENT_LEARN then
					tips = G:GetLine(n - 1)
				elseif tips and tips:sub(1, 4) == "Rank" then
					tips = G:GetLine(n + 1)
				end
				if tips and tips:sub(1, 8) == "Requires" then --Note that the above could be true for line 1 and this for other lines
					tips = G:GetLine(n + 1)
				end

				talents[index] = {
					info = {
						name = name,
						icon = icon,
						row = row,
						column = column,
						ranks = ranks,
						exceptional = exceptional,
						prereqs = FillPrereqs(GetTalentPrereqs(tab, index, inspect)),
						tips = tips,
					},
				}
				count = count+1
			end
			result[tab].numtalents = count
		end

		return result
	end
end

local function GetDataAddOnExpectedBuild()
	local info = GetAddOnMetadata("Talented_Data", "X-ExpectedBuild")
	if info then
		local build = loadstring("return "..info)
		if build then
			return build()
		end
	end
end

local function CanLoadDataAddOn()
	local build = GetDataAddOnExpectedBuild()
	if build then
		local current = strjoin(" - ", GetBuildInfo())
		if build ~= current then
			Talented:Print(L["Talented_Data is outdated. It was created for %q, but current build is %q. Please update."]:format(build, current))
			if Talented.db.profile.force_load then
				Talented:Print(L["Loading outdated data. |cffff1010WARNING:|r Recent changes in talent trees might not be included in this data."])
				return true
			end
		else
			Talented.db.profile.force_load = nil
			return true
		end
	end
	return false
end

local function BuildDataAddOnOption(opt, info)
	if opt.empty.type == "execute" then
		opt.empty = {
				name = L["New empty template"],
				desc = L["Create a new template from scratch."],
				type = "group",
				order = 100,
				args = {},
		}
	end
	
	for name, info in pairs(info) do
		local colour = RAID_CLASS_COLORS[name]
		local cname = ("|cff%.2x%.2x%.2x%s|r"):format(colour.r*255, colour.g*255, colour.b*255, name)
		opt.empty.args[name] = {
			name = cname,
			desc = cname,
			type = "execute",
			order = 100,
			func = function()
				Talented:SetTemplate(Talented:CreateEmptyTemplate(name))
			end,
		}
	end
end

do
	local loaded
	function Talented:ResetDataLoadedStatus()
		if loaded == false and self.db.profile.force_load then
			loaded = nil
			if self.talents and self:DataAddonLoaded() then
				self.talents = Talented_Data
				if self.viewclass then
					self:CreateTalentMatrix(self.viewclass, true)
				end
			end
		end
	end
	
	function Talented:DataAddonLoaded()
		if loaded ~= nil then 
			return loaded
		end
		if not IsAddOnLoaded("Talented_Data") and CanLoadDataAddOn() then
			LoadAddOn("Talented_Data")
		end
		loaded = Talented_Data and true or false
		if loaded then
			-- BuildDataAddOnOption(self.options.args.template.args.new.args, Talented_Data)
			GetDataAddOnExpectedBuild = nil
			CanLoadDataAddOn = nil
			BuildDataAddOnOption = nil
		end
		return loaded
	end
end

local function FindTalentIndex(table, row, column)
	for index, talent in ipairs(table) do
		if talent.info.row == row and talent.info.column == column then
			return index
		end
	end
end


local function FindPrereqsSource(info)
	for tab, tree in ipairs(info) do
		for index, talent in ipairs(tree.talents) do
			local p = talent.info.prereqs
			if p then
				for _, req in ipairs(p) do --look through all requirements in turn
					if req.source then
						return
					else
						req.source = FindTalentIndex(tree.talents, req.row, req.column)
					end
				end
			end
		end
	end
end

function Talented:GetTalentInfo(class, inspect)
	-- class = class or PlayerClass
	if not self.talents then
		if self:DataAddonLoaded() then
			self.talents = Talented_Data --self.talents["DRUID"].talents == {1:, 2:, 3:}
		else
			self.talents = {
				[select(2, UnitClass("player"))] = BuildTalentInfo(), --self.talents["DRUID"] == {1:, 2:, 3:}
			}
		end
	end
	local info = self.talents[class]
	if info then
		FindPrereqsSource(info)
	elseif inspect then
		info = BuildTalentInfo(inspect)
		self.talents[class] = info
		-- BuildDataAddOnOption(self.options.args.template.args.new.args, self.talents)
	else
		self:ReportMissingTalents(class)
	end
	return info
end

function Talented:ReportMissingTalents(class)
	local p = self.db.profile
	if p.report_unavailable or not p.reported_once then
		self:Print(L["Talented cannot perform the required action because it does not have the required talent data available for class %s."]:format(tostring(class)))
		-- if not p.reported_once then
			p.reported_once = true
			self:Print(L["You must enable the Talented_Data helper addon for this action to work."])
			self:Print(L["If Talented_Data is out of date, you must update or you can allow it to load outdated data in the settings."])
		-- end
	end
end

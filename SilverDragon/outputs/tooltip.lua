local myname, ns = ...

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("Tooltip", "AceEvent-3.0")
local Debug = core.Debug

local globaldb
function module:OnInitialize()
	self.db = core.db:RegisterNamespace("Tooltip", {
		profile = {
			achievement = true,
			drop = true,
			id = false,
			combatdrop = false,
		},
	})

	local config = core:GetModule("Config", true)
	if config then
		config.options.args.general.plugins.tooltip = {
			tooltip = {
				type = "group",
				name = "工具提示",
				order = 93,
				get = function(info) return self.db.profile[info[#info]] end,
				set = function(info, v) self.db.profile[info[#info]] = v end,
				args = {
					about = config.desc("SilverDragon可以在怪物的工具提示中添加一些信息。对于稀有怪物，这可以包括你是否需要击杀它们以完成成就", 0),
					achievement = config.toggle("成就", "显示是否需要稀有怪物以完成成就", 1),
					drop = config.toggle("掉落物", "显示是否需要从怪物那里获取掉落物", 2),
					combatdrop = config.toggle("...在战斗中", "在战斗中显示掉落物", 3),
					id = config.toggle("单位ID", "在工具提示中显示怪物ID", 4),
				},
			},
		}
	end
end

function module:OnEnable()
	if _G.C_TooltipInfo then
		-- Cata-classic has TooltipDataProcessor, but doesn't actually use the new tooltips
		TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
			if tooltip ~= GameTooltip then return end
			local name, unit, guid = TooltipUtil.GetDisplayedUnit(tooltip)
			module:UpdateTooltip(ns.IdFromGuid(guid))
		end)
	else
		GameTooltip:HookScript("OnTooltipSetUnit", function(tooltip)
			local name, unit = tooltip:GetUnit()
			if unit then
				module:UpdateTooltip(core:UnitID(unit))
			end
		end)
	end
end

-- This is split out entirely so I can test this without having to actually hunt down a rare:
-- /script SilverDragon:GetModule('Tooltip'):UpdateTooltip(51059)
-- /script SilverDragon:GetModule('Tooltip'):UpdateTooltip(32491)
function module:UpdateTooltip(id, force_achievement, force_drop, force_id)
	if not id then
		return
	end

	if self.db.profile.achievement or force_achievement == true and force_achievement ~= false then
		ns:UpdateTooltipWithCompletion(GameTooltip, id)
	end

	if (self.db.profile.drop and (self.db.profile.combatdrop or not InCombatLockdown())) or force_drop == true and force_drop ~= false then
		ns.Loot.Summary.UpdateTooltip(GameTooltip, id)
	end

	if self.db.profile.id or force_id and force_id ~= false then
		GameTooltip:AddDoubleLine(ID, id, 1, 1, 0, 1, 1, 0)
	end

	GameTooltip:Show()
end

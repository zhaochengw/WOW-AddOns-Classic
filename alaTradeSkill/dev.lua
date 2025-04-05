--[=[
	DEV
--]=]


local ScanTooltip = ScanTooltip or CreateFrame('GAMETOOLTIP', "_TrainerSpellTooltip", UIParent, "GameTooltipTemplate");

local function ScanTrainer(ratio)
	ratio = ratio or 1.0;
	local db = {  };
	local missinglink = 0;
	for index = 1, GetNumTrainerServices() do
		local name, rank, category, expanded = GetTrainerServiceInfo(index);
		if category ~= 'header' then
			ScanTooltip:SetOwner(UIParent, "ANCHOR_RIGHT"); ScanTooltip:SetTrainerService(index); ScanTooltip:Show();
			local sname, sid = ScanTooltip:GetSpell();
			if sid == nil then
				print("MISS", index, sname, sid);
			end
			local link = GetTrainerServiceItemLink(index);
			local reqPlayerLevel = GetTrainerServiceLevelReq(index);
			local skillName, skillLevel, hasReq = GetTrainerServiceSkillReq(index);
			local moneyCost, talentCost, professionCost = GetTrainerServiceCost(index);
			local serviceDescription = GetTrainerServiceDescription(index);
			local icon = GetTrainerServiceIcon(index);
			local tbl = {
	--[[1]]		sid or "_NIL",
	--[[2]]		link and tonumber(strmatch(link, "item:(%d+):")) or "_NIL",
	--[[3]]		link,
	--[[4]]		name,
	--[[5]]		rank,
	--[[6]]		category,
	--[[7]]		expanded,
	--[[8]]		reqPlayerLevel,
	--[[9]]		skillName,
	--[[10]]	skillLevel,
	--[[11]]	hasReq,
	--[[12]]	moneyCost and moneyCost / ratio,
	--[[13]]	talentCost,
	--[[14]]	professionCost,
	--[[15]]	serviceDescription,
	--[[16]]	icon,
			};
			for i = 1, 15 do
				tbl[i] = tbl[i] or "_NIL";
			end
			if link == nil or link == "" then
				print(index, name, link)
				missinglink = missinglink + 1;
			end
			db[#db + 1] = tbl;
		end
	end
	print('misssinglink', missinglink);
	ScanTooltip:Hide();
	local npc = UnitName('npc') or UnitName('target') or (#db + 1);
	_G.alaTradeSkillSV = _G.alaTradeSkillSV or {};
	alaTradeSkillSV.skill = alaTradeSkillSV.skill or {};
	alaTradeSkillSV.skill[npc] = db;
end
_G.ScanTrainer = ScanTrainer;

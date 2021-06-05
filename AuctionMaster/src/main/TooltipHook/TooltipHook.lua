--[[
	Copyright (C) Udorn (Blackhand)
	
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.	
--]]

--[[
	Hooks tooltips to be able to add custom information. Despite the corresponding
	library TipHooker, we are able to tell the count of items.
--]]
vendor.TooltipHook = vendor.Vendor:NewModule("TooltipHook", "AceHook-3.0");
local L = vendor.Locale.GetInstance()
local self = vendor.TooltipHook;

local log = vendor.Debug:new("TooltipHook")

local TOOLTIP_NAMES = {"GameTooltip", "ItemRefTooltip", "ShoppingTooltip", "AtlasLootTooltip"};
local METHOD_NAMES = {"SetHyperlink", "SetBagItem", "SetInventoryItem", "SetAuctionItem",
	"SetAuctionSellItem", "SetLootItem", "SetLootRollItem", "SetCraftSpell", "SetCraftItem",
	"SetTradeSkillItem", "SetSendMailItem", "SetQuestItem",
	"SetTradePlayerItem", "SetTradeTargetItem", "SetMerchantItem",
	"SetBuybackItem", "SetSocketGem", "SetExistingSocketGem", "SetHyperlinkCompareItem",
	"SetGuildBankItem"};
	-- "SetQuestLogItem"
	-- "SetInboxItem" FIXME broken since 7.0.3
local MAP_ENCHANTMENTS = {
	["13915"] = 38840,
["31432"] = 24274,
["31430"] = 24273,
["32458"] = 25652,
["31433"] = 24276,
["44483"] = 38950,
["31431"] = 24275,
["44500"] = 38959,
["13945"] = 38849,
["32457"] = 25651,
["13939"] = 38846,
["44484"] = 38951,
["32456"] = 25650,
["13937"] = 38845,
["44489"] = 38954,
["13943"] = 38848,
["44488"] = 38953,
["13941"] = 38847,
["44494"] = 38956,
["13931"] = 38842,
["44492"] = 38955,
["13917"] = 38841,
["13935"] = 38844,
["13933"] = 38843,
["44506"] = 38960,
["44508"] = 38961,
["56357"] = 42500,
["13905"] = 38839,
["13898"] = 38838,
["44524"] = 38965,
["13890"] = 38837,
["44513"] = 38964,
["13887"] = 38836,
["44510"] = 38963,
["13882"] = 38835,
["44509"] = 38962,
["13868"] = 38834,
["44556"] = 38969,
["13858"] = 38833,
["44555"] = 38968,
["13846"] = 38832,
["44529"] = 38967,
["13841"] = 38831,
["44528"] = 38966,
["13836"] = 38830,
["60616"] = 38971,
["44770"] = 34207,
["44576"] = 38972,
["29657"] = 23530,
["20016"] = 38860,
["20017"] = 38861,
["20020"] = 38862,
["2165"] = 2313,
["44591"] = 38978,
["20024"] = 38864,
["44590"] = 38977,
["20023"] = 38863,
["20026"] = 38866,
["44592"] = 38979,
["20025"] = 38865,
["44584"] = 38974,
["20029"] = 38868,
["44582"] = 38973,
["20028"] = 38867,
["44589"] = 38976,
["44588"] = 38975,
["20030"] = 38869,
["44596"] = 38982,
["44593"] = 38980,
["44595"] = 38981,
["13947"] = 38850,
["13948"] = 38851,
["2152"] = 2304,
["20011"] = 38855,
["20010"] = 38854,
["44623"] = 38989,
["44970"] = 34330,
["20009"] = 38853,
["44621"] = 38988,
["20008"] = 38852,
["44616"] = 38987,
["20015"] = 38859,
["60623"] = 38986,
["20014"] = 38858,
["44612"] = 38985,
["20013"] = 38857,
["44598"] = 38984,
["20012"] = 38856,
["42688"] = 33185,
["7793"] = 38781,
["7788"] = 38780,
["7859"] = 38783,
["7857"] = 38782,
["7863"] = 38785,
["7861"] = 38784,
["23802"] = 38882,
["23801"] = 38881,
["44625"] = 38990,
["23804"] = 38884,
["23803"] = 38883,
["44630"] = 38992,
["44629"] = 38991,
["23800"] = 38880,
["44631"] = 38993,
["44575"] = 44815,
["44633"] = 38995,
["50964"] = 38371,
["25079"] = 38889,
["50966"] = 38372,
["44635"] = 38997,
["50965"] = 38373,
["46578"] = 38998,
["50967"] = 38374,
["46594"] = 38999,
["50962"] = 38375,
["25072"] = 38885,
["50963"] = 38376,
["25073"] = 38886,
["25074"] = 38887,
["25078"] = 38888,
["7867"] = 38786,
["13378"] = 38787,
["13380"] = 38788,
["13419"] = 38789,
["7454"] = 38770,
["7766"] = 38774,
["7748"] = 38773,
["7745"] = 38772,
["7457"] = 38771,
["20034"] = 38873,
["20033"] = 38872,
["20032"] = 38871,
["64579"] = 46098,
["20031"] = 38870,
["3780"] = 4265,
["22750"] = 38878,
["23799"] = 38879,
["21931"] = 38876,
["22749"] = 38877,
["22727"] = 18251,
["20035"] = 38874,
["63746"] = 45628,
["20036"] = 38875,
["7779"] = 38777,
["7782"] = 38778,
["7771"] = 38775,
["7776"] = 38776,
["7786"] = 38779,
["27951"] = 37603,
["56010"] = 41603,
["56011"] = 41604,
["9964"] = 7969,
["56008"] = 41601,
["56009"] = 41602,
["9939"] = 7967,
["62202"] = 44936,
["7428"] = 38768,
["7443"] = 38769,
["7420"] = 38766,
["7426"] = 38767,
["25081"] = 38891,
["25080"] = 38890,
["35557"] = 29536,
["35554"] = 29535,
["25086"] = 38895,
["55656"] = 41611,
["25084"] = 38894,
["25083"] = 38893,
["25082"] = 38892,
["27905"] = 38898,
["27906"] = 38899,
["27837"] = 38896,
["27899"] = 38897,
["35549"] = 29533,
["35555"] = 29534,
["62256"] = 44947,
["62257"] = 44946,
["60767"] = 44470,
["62448"] = 44963,
["59621"] = 44493,
["59625"] = 43987,
["59619"] = 44497,
["27950"] = 38909,
["27948"] = 38908,
["13538"] = 38798,
["27947"] = 38907,
["13536"] = 38797,
["27946"] = 38906,
["27945"] = 38905,
["13607"] = 38799,
["27944"] = 38904,
["27917"] = 38903,
["27914"] = 38902,
["27913"] = 38901,
["27911"] = 38900,
["10487"] = 8173,
["13501"] = 38793,
["13503"] = 38794,
["13522"] = 38795,
["13529"] = 38796,
["13421"] = 38790,
["13464"] = 38791,
["13485"] = 38792,
["47672"] = 39001,
["47051"] = 39000,
["27954"] = 38910,
["47898"] = 39003,
["13659"] = 38816,
["27957"] = 38911,
["64441"] = 46026,
["47766"] = 39002,
["13661"] = 38817,
["27958"] = 38912,
["47900"] = 39005,
["13663"] = 38818,
["27960"] = 38913,
["47899"] = 39004,
["13687"] = 38819,
["27961"] = 38914,
["13648"] = 38812,
["27962"] = 38915,
["13653"] = 38813,
["27967"] = 38917,
["13655"] = 38814,
["27968"] = 38918,
["13657"] = 38815,
["27971"] = 38919,
["13644"] = 38810,
["13646"] = 38811,
["47901"] = 39006,
["19058"] = 15564,
["27972"] = 38920,
["27975"] = 38921,
["27982"] = 38924,
["13822"] = 38829,
["27984"] = 38925,
["27977"] = 38922,
["13815"] = 38827,
["27981"] = 38923,
["13817"] = 38828,
["33990"] = 38928,
["13746"] = 38825,
["33991"] = 38929,
["13794"] = 38826,
["28003"] = 38926,
["35523"] = 29487,
["13698"] = 38823,
["62959"] = 45060,
["28004"] = 38927,
["35524"] = 29488,
["13700"] = 38824,
["35521"] = 29485,
["13693"] = 38821,
["35522"] = 29486,
["13695"] = 38822,
["35520"] = 29483,
["13689"] = 38820,
["60606"] = 44449,
["7418"] = 38679,
["33995"] = 38933,
["33996"] = 38934,
["33997"] = 38935,
["33999"] = 38936,
["55839"] = 41976,
["33992"] = 38930,
["33993"] = 38931,
["33994"] = 38932,
["16651"] = 12645,
["34001"] = 38937,
["34002"] = 38938,
["34003"] = 38939,
["60663"] = 44457,
["7222"] = 6043,
["60668"] = 44458,
["7221"] = 6042,
["60653"] = 44455,
["60609"] = 44456,
["60621"] = 44453,
["62948"] = 45056,
["71692"] = 50816,
["7224"] = 6041,
["34010"] = 38946,
["13637"] = 38807,
["42620"] = 38947,
["13640"] = 38808,
["34008"] = 38944,
["13631"] = 38805,
["34009"] = 38945,
["13635"] = 38806,
["34006"] = 38942,
["34007"] = 38943,
["34004"] = 38940,
["13642"] = 38809,
["34005"] = 38941,
["13612"] = 38800,
["13622"] = 38803,
["13626"] = 38804,
["42974"] = 38948,
["13617"] = 38801,
["44383"] = 38949,
["13620"] = 38802,
["60707"] = 44466,
["60714"] = 44467,
["60763"] = 44469,
["60691"] = 44463,
["60692"] = 44465,

}

--[[
	Callback function for sorting appernders.
--]]
local function _SortAppenderCallback(appender1, appender2) 
	return appender1.prio < appender2.prio;
end
	
--[[
	Handles the tooltip call and notifies the appenders.
--]]
local function _HandleCall(self, tooltip, count, extraLink, extraName, appendSellValue)
	if (not self.db.profile.isActive) then
		log:Debug("I shouldn't be here!") 
		return
	end
	local name, link = extraName, extraLink
	if (not name) then
		if (not tooltip.GetItem) then
			return
		end
		name, link = tooltip:GetItem()
	end
	if (not name or string.len(name) == 0 or not link) then
		return 
	end
	if (not count) then
		count = 1;
	end
	if (self.db.profile.showLabel) then
		-- print the intro
		tooltip:AddLine(" ");
		local msg;
		if (vendor.AuctionHouse:IsNeutral()) then
			msg = "Neutral";
		else
			local _, faction = UnitFactionGroup("player");
			msg = GetRealmName().."-"..faction;
		end
		tooltip:AddDoubleLine(L["AuctionMaster statistics"], "("..msg..")", 1, 1, 1, 1, 1, 1);
	end
	if (appendSellValue) then
		local itemSellPrice = select(11, GetItemInfo(link)) 
		if (itemSellPrice) then
			local msg
			if (count == 1) then
			 	msg = vendor.Format.FormatMoney(itemSellPrice, true)
			else
				msg = vendor.Format.FormatMoneyValues(itemSellPrice, itemSellPrice * count, true)
			end
			tooltip:AddDoubleLine(L["Selling price"], msg)
		end
	end
	if (extraName) then
		tooltip:AddLine(extraName)
	end
	if (self.appenders) then
    	for key, val in ipairs(self.appenders) do
    		val.appender:AppendToGameTooltip(tooltip, link, name, count)
    	end
    end
	tooltip:Show();
end

--[[
	Initializes the module.
--]]
function vendor.TooltipHook:OnInitialize()
	self.db = vendor.Vendor.db:RegisterNamespace("TooltipHook", {
		profile = {
			isActive = true,
			showLabel = false,
			compactMarketPrice = false,
			adjustCurrentPrices = true,
			showDisenchant = true,
			compactColor = {r = 1, g = 0, b = 0},
		}
	});
end

--[[
	Enables the module and hooks all available tooltip functions.
--]]
function vendor.TooltipHook:OnEnable()
	-- hook all known tooltip implementations
	local frame = EnumerateFrames();
	while (frame) do
		if (frame:GetObjectType() == "GameTooltip") then
			local name = frame:GetName();
			if (name) then
				for _, v in ipairs(TOOLTIP_NAMES) do
					if strfind(name, v) then
						for _, methodName in ipairs(METHOD_NAMES) do
							if (type(frame[methodName]) == "function") then
								self:SecureHook(frame, methodName);
							end
						end
						break
					end
				end
			end
		end
		frame = EnumerateFrames(frame);
	end		
end
	
function vendor.TooltipHook:OnDisable()
	self:UnhookAll()
end

--[[
	Registers a new listener for GameTooltip integration.
	The given prio sorts the different modules, when integrating it
	into the tooltip. Low values will be printed first.
	The appenders have to implement the following method:
	AppendToGameTooltip(tooltip, itemLink, itemName, count)
--]]
function vendor.TooltipHook:AddAppender(appender, prio)
	local info = {appender = appender, prio = prio};
	self.appenders = self.appenders or {}
	table.insert(self.appenders, info);
	table.sort(self.appenders, _SortAppenderCallback);
end
	
--[[
	List of all available hooks.
--]]
function vendor.TooltipHook:SetInventoryItem(tooltip, unit, slot)
	local count = GetInventoryItemCount(unit, slot);
	_HandleCall(self, tooltip, count);
end

function vendor.TooltipHook:SetAuctionItem(tooltip, type, index)
	local _, _, count = GetAuctionItemInfo(type, index);
	_HandleCall(self, tooltip, count, nil, nil, true);
end
	
function vendor.TooltipHook:SetAuctionSellItem(tooltip)
	local _, _, count = GetAuctionSellItemInfo();
	_HandleCall(self, tooltip, count);
end
	
function vendor.TooltipHook:SetLootItem(tooltip, slot)
	local _, _, count = GetLootSlotInfo(slot);
	_HandleCall(self, tooltip, count);
end

function vendor.TooltipHook:SetLootRollItem(tooltip, slot)
	local _, _, count = GetLootRollItemInfo(slot);
	_HandleCall(self, tooltip, count);
end
	
function vendor.TooltipHook:SetBagItem(tooltip, bag, slot)
	local  _, count = GetContainerItemInfo(bag, slot);
	_HandleCall(self, tooltip, count);
end
	
function vendor.TooltipHook:SetCraftItem(tooltip, craftItemIndex, reagentIndex)
	local _, _, count = GetCraftReagentInfo(craftItemIndex, reagentIndex);
	_HandleCall(self, tooltip, count);
end

function vendor.TooltipHook:SetCraftSpell(tooltip, craftItemIndex)
	_HandleCall(self, tooltip, 1);
end
	
function vendor.TooltipHook:SetTradeSkillItem(tooltip, tradeSkillIndex, reagentIndex)
	if (reagentIndex) then
		local _, _, reagentCount = GetTradeSkillReagentInfo(tradeSkillIndex, reagentIndex);
		_HandleCall(self, tooltip, reagentCount);
	else
		local skillName = GetTradeSkillInfo(tradeSkillIndex)
		local link = GetTradeSkillItemLink(tradeSkillIndex)
		local found, _, str = string.find(link, "enchant:(%d+)|")
		local handled = false
		if (found) then
			local mappedTo = MAP_ENCHANTMENTS[str]
--			log:Debug("id: [%s]", str)
			if (mappedTo) then
--				log:Debug("mappedTo: %d", mappedTo)
				link = vendor.Items:GetItemLink(mappedTo)
				local name = GetItemInfo(link)
--				log:Debug("name: [%s] link: [%s]", name, link)
				if (name) then
					_HandleCall(self, tooltip, 1, link, name)
					handled = true
				end
			end
		end
		if (not handled) then
			_HandleCall(self, tooltip, 1)
		end
	end
end
	
function vendor.TooltipHook:SetHyperlink(tooltip, link)
	if (tooltip.itemCount) then
		_HandleCall(self, tooltip, tooltip.itemCount);
	else
		_HandleCall(self, tooltip, 1);
	end
end

-- FIXME broken since 7.0.3
--function vendor.TooltipHook:SetInboxItem(tooltip, index, itemIndex)
--	local _, _, count = GetInboxItem(index, itemIndex);
--	_HandleCall(self, tooltip, count);
--end

function vendor.TooltipHook:SetSendMailItem(tooltip, itemIndex)
	local _, _, count = GetSendMailItem(itemIndex);
	_HandleCall(self, tooltip, count);
end

function vendor.TooltipHook:SetQuestItem(tooltip, type, itemIndex)
	local _, _, count = GetQuestItemInfo(type, itemIndex);
	_HandleCall(self, tooltip, count);
end

function vendor.TooltipHook:SetTradePlayerItem(tooltip, itemIndex)
	local _, _, count = GetTradePlayerItemInfo(itemIndex);
	_HandleCall(self, tooltip, count);
end

function vendor.TooltipHook:SetTradeTargetItem(tooltip, itemIndex)
	local _, _, count = GetTradeTargetItemInfo(itemIndex);
	_HandleCall(self, tooltip, count);
end

function vendor.TooltipHook:SetMerchantItem(tooltip, itemIndex)
	local _, _, _, count = GetMerchantItemInfo(itemIndex);
	_HandleCall(self, tooltip, count);
end

function vendor.TooltipHook:SetBuybackItem(tooltip, itemIndex)
	local _, _, _, count = GetBuybackItemInfo(itemIndex);
	_HandleCall(self, tooltip, count);
end

function vendor.TooltipHook:SetSocketGem(tooltip, unit, slot)
	local count = GetInventoryItemCount(unit, slot);
	_HandleCall(self, tooltip, count);
end

function vendor.TooltipHook:SetExistingSocketGem(tooltip, unit, slot)
	local count = GetInventoryItemCount(unit, slot);
	_HandleCall(self, tooltip, count);
end

function vendor.TooltipHook:SetHyperlinkCompareItem(tooltip)
	_HandleCall(self, tooltip, 1);
end

function vendor.TooltipHook:SetGuildBankItem(tooltip, tab, slot)
	local _, count = GetGuildBankItemInfo(tab, slot);
	_HandleCall(self, tooltip, count);
end

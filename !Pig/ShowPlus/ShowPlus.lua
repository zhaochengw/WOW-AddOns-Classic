local _, addonTable = ...;
local gsub = _G.string.gsub
local sub = _G.string.sub 
local find = _G.string.find
local fuFrame=Pig_Options_RF_TAB_5_UI
--============================================
fuFrame.wupinxians1 = fuFrame:CreateLine()
fuFrame.wupinxians1:SetColorTexture(1,1,1,0.4)
fuFrame.wupinxians1:SetThickness(1);
fuFrame.wupinxians1:SetStartPoint("TOPLEFT",3,-180)
fuFrame.wupinxians1:SetEndPoint("TOPRIGHT",-330,-180)
fuFrame.wupinxians2 = fuFrame:CreateLine()
fuFrame.wupinxians2:SetColorTexture(1,1,1,0.4)
fuFrame.wupinxians2:SetThickness(1);
fuFrame.wupinxians2:SetStartPoint("TOPLEFT",330,-180)
fuFrame.wupinxians2:SetEndPoint("TOPRIGHT",-2,-180)
fuFrame.wupinxians3 = fuFrame:CreateFontString();
fuFrame.wupinxians3:SetPoint("LEFT", fuFrame.wupinxians1, "RIGHT", 0, 0);
fuFrame.wupinxians3:SetPoint("RIGHT", fuFrame.wupinxians2, "LEFT", 0, 0);
fuFrame.wupinxians3:SetFontObject(GameFontNormal);
fuFrame.wupinxians3:SetText("鼠标提示");
---------
	-- SetAction = function(tt, slot)

	-- SetAuctionItem = function(tt, auctionType, index)
	-- local _, _, count = GetAuctionItemInfo(auctionType, index)

	-- SetAuctionSellItem = function(tt)
	-- local _, _, count = GetAuctionSellItemInfo()

	-- SetCraftItem = function(tt, index, reagent)
	-- local _, _, count = GetCraftReagentInfo(index, reagent)

	-- SetInboxItem = function(tt, messageIndex, attachIndex)
	-- local count, itemID
	-- if attachIndex then
	-- 	count = select(4, GetInboxItem(messageIndex, attachIndex))
	-- else
	-- 	count, itemID = select(14, GetInboxHeaderInfo(messageIndex))
	-- end
	-- SetInventoryItem = function(tt, unit, slot)
	-- 	local count
	-- 	if not CharacterBags[slot] then
	-- 		count = GetInventoryItemCount(unit, slot)
	-- 	end
	-- SetLootItem = function(tt, slot)
	-- local _, _, count = GetLootSlotInfo(slot)
	-- SetLootRollItem = function(tt, rollID)
	-- local _, _, count = GetLootRollItemInfo(rollID)
	-- SetSendMailItem = function(tt, index)
	-- 	local count = select(4, GetSendMailItem(index))
	-- SetTradePlayerItem = function(tt, index)
	-- 	local _, _, count = GetTradePlayerItemInfo(index)
	-- SetTradeSkillItem = function(tt, index, reagent)
	-- 	local count
	-- 	if reagent then
	-- 		count = select(3, GetTradeSkillReagentInfo(index, reagent))
	-- 	else 
	-- 		count = GetTradeSkillNumMade(index)
	-- 	end
	-- SetTradeTargetItem = function(tt, index)
	-- local _, _, count = GetTradeTargetItemInfo(index)

--==========================================================
fuFrame.ItemSell = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.ItemSell:SetSize(30,32);
fuFrame.ItemSell:SetHitRectInsets(0,-100,0,0);
fuFrame.ItemSell:SetPoint("TOPLEFT",fuFrame.wupinxians1,"TOPLEFT",20,-20);
fuFrame.ItemSell.Text:SetText("显示物品售价");
fuFrame.ItemSell.tooltip = "在鼠标提示上显示物品售价！";
fuFrame.ItemSell:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ShowPlus']['ItemSell']="ON";
		fuFrame.ItemSell.V=true
	else
		PIG['ShowPlus']['ItemSell']="OFF";
		fuFrame.ItemSell.V=false
	end
end);
--全部提示
-- GameTooltip:HookScript("OnTooltipSetItem", function(self)
--	if not fuFrame.ItemSell.V then return end
-- 	local _, link = self:GetItem()
-- 	local itemSellG = select(11, GetItemInfo(link))
-- 	if itemSellG then
-- 		if itemSellG and itemSellG > 0 then
-- 			SetTooltipMoney(self, itemSellG, nil, SELL_PRICE_TEXT)
-- 		end
-- 	end
-- end)
------
hooksecurefunc(GameTooltip, "SetBagItem", function(self, bag, slot)
	if not fuFrame.ItemSell.V then return end
	if not MerchantFrame:IsVisible() then
		local _, link = self:GetItem()
		if link then
			local itemSellG = select(11, GetItemInfo(link))
			if itemSellG then
				local _, count = GetContainerItemInfo(bag, slot)
				if itemSellG and itemSellG > 0 then
					SetTooltipMoney(self, itemSellG*count, nil, SELL_PRICE_TEXT)
				end
				self:Show()
			end
		end
	end
end)
hooksecurefunc(GameTooltip, "SetQuestItem", function(self, questType, index)
	if not fuFrame.ItemSell.V then return end
	local _, link = self:GetItem()
	if link then
		local itemSellG = select(11, GetItemInfo(link))
		if itemSellG then
			local _, _, count = GetQuestItemInfo(questType, index)
			if itemSellG and itemSellG > 0 then
				SetTooltipMoney(self, itemSellG*count, nil, SELL_PRICE_TEXT)
			end
			self:Show()
		end
	end
end)
hooksecurefunc(GameTooltip, "SetQuestLogItem", function(self,  _, index)
	if not fuFrame.ItemSell.V then return end
	local _, link = self:GetItem()
	if link then
		local itemSellG = select(11, GetItemInfo(link))
		if itemSellG then
			local _, _, count = GetQuestLogRewardInfo(index)
			if itemSellG and itemSellG > 0 then
				SetTooltipMoney(self, itemSellG*count, nil, SELL_PRICE_TEXT)
			end
			self:Show()
		end
	end
end)

--------------
fuFrame.ItemLevel = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.ItemLevel:SetSize(30,32);
fuFrame.ItemLevel:SetHitRectInsets(0,-100,0,0);
fuFrame.ItemLevel:SetPoint("TOPLEFT",fuFrame.wupinxians1,"TOPLEFT",300,-20);
fuFrame.ItemLevel.Text:SetText("显示物品等级");
fuFrame.ItemLevel.tooltip = "在鼠标提示上显示物品等级！";
fuFrame.ItemLevel:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ShowPlus']['ItemLevel']="ON";
		fuFrame.ItemLevel.V=true
	else
		PIG['ShowPlus']['ItemLevel']="OFF";
		fuFrame.ItemLevel.V=false
	end
end);
GameTooltip:HookScript("OnTooltipSetItem", function(self)
	if not fuFrame.ItemLevel.V then return end
	local _, link = self:GetItem()
	if link then
		local itemLevel = select(4, GetItemInfo(link))
		if itemLevel then
			self:AddDoubleLine("物品等级:",itemLevel)
			self:Show()
		end
	end
end)

----------------
fuFrame.SpellID = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.SpellID:SetSize(30,32);
fuFrame.SpellID:SetHitRectInsets(0,-100,0,0);
fuFrame.SpellID:SetPoint("TOPLEFT",fuFrame.wupinxians1,"TOPLEFT",20,-60);
fuFrame.SpellID.Text:SetText("显示技能ID/BUFF来源");
fuFrame.SpellID.tooltip = "在鼠标提示上显示技能ID/BUFF来源！";
fuFrame.SpellID:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ShowPlus']['SpellID']="ON";
		fuFrame.SpellID.V=true
	else
		PIG['ShowPlus']['SpellID']="OFF";
		fuFrame.SpellID.V=false
	end
end);
hooksecurefunc(GameTooltip, "SetUnitBuff", function(self, unit, index, filter)
	if not fuFrame.SpellID.V then return end
	local _, icon, count, debuffType, duration, expires, caster,_,_,spellId = UnitBuff(unit, index, filter) 
    if spellId then
    	if caster then
	        local _, class = UnitClass(caster) 
	        local rPerc, gPerc, bPerc, argbHex = GetClassColor(class);
	        local name = GetUnitName(caster, true)
	        self:AddDoubleLine("来自:[\124c"..argbHex..name.."\124r]","SpellID:\124c"..argbHex..spellId.."\124r")
	        self:Show() 
		else
			self:AddDoubleLine("来自:[\124cff48cba0未知\124r]","SpellID:\124cff48cba0"..spellId.."\124r")
	        self:Show() 
		end
    end
end)
hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self, unit, index, filter)
	if not fuFrame.SpellID.V then return end
	local _, icon, count, debuffType, duration, expires, caster,_,_,spellId = UnitDebuff(unit, index, filter) 
    if spellId then
    	if caster then
	        local _, class = UnitClass(caster) 
	        local rPerc, gPerc, bPerc, argbHex = GetClassColor(class);
	        local name = GetUnitName(caster, true)
	        self:AddDoubleLine("来自:[\124c"..argbHex..name.."\124r]","SpellID:\124c"..argbHex..spellId.."\124r")
	        self:Show() 
		else
			self:AddDoubleLine("来自:[\124cff48cba0未知\124r]","SpellID:\124cff48cba0"..spellId.."\124r")
	        self:Show() 
		end
    end
end)
hooksecurefunc(GameTooltip, "SetUnitAura", function(self, unit, index, filter)
	if not fuFrame.SpellID.V then return end
	local _, icon, count, debuffType, duration, expires, caster,_,_,spellId = UnitAura(unit, index, filter) 
    if spellId then
    	if caster then
	        local _, class = UnitClass(caster) 
	        local rPerc, gPerc, bPerc, argbHex = GetClassColor(class);
	        local name = GetUnitName(caster, true)
	        self:AddDoubleLine("来自:[\124c"..argbHex..name.."\124r]","SpellID:\124c"..argbHex..spellId.."\124r")
	        self:Show() 
		else
			self:AddDoubleLine("来自:[\124cff48cba0未知\124r]","SpellID:\124cff48cba0"..spellId.."\124r")
	        self:Show() 
		end
    end 
end)
--处理聊天框物品/技能
hooksecurefunc("SetItemRef", function(link, text, button, chatFrame)
	if not fuFrame.SpellID.V then return end
	if link:find("^spell:") then
		local id = link:gsub(":0","")
		ItemRefTooltip:AddDoubleLine("SpellID:",id)
		ItemRefTooltip:Show()
	end
end)
GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	if not fuFrame.SpellID.V then return end
	local _,spellId = self:GetSpell()
	if spellId then
		self:AddDoubleLine("SpellID:",spellId)
		self:Show()
	end
end)

--加载设置---------------
addonTable.ShowPlus = function()
	PIG["ShowPlus"] = PIG["ShowPlus"] or addonTable.Default["ShowPlus"]
	if PIG['ShowPlus']['ItemSell']=="ON" then
		fuFrame.ItemSell:SetChecked(true);
		fuFrame.ItemSell.V=true
	end
	if PIG['ShowPlus']['ItemLevel']=="ON" then
		fuFrame.ItemLevel:SetChecked(true);
		fuFrame.ItemLevel.V=true
	end
	if PIG['ShowPlus']['SpellID']=="ON" then
		fuFrame.SpellID:SetChecked(true);
		fuFrame.SpellID.V=true
	end
end

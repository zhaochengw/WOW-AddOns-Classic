local _, addonTable = ...;
local gsub = _G.string.gsub
local sub = _G.string.sub 
local find = _G.string.find
local fuFrame=List_R_F_1_5
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--============================================
local ContainerIDToInventoryID = ContainerIDToInventoryID or (C_Container and C_Container.ContainerIDToInventoryID)
local GetContainerItemInfo=GetContainerItemInfo or (C_Container and C_Container.GetContainerItemInfo)
local GetContainerItemID = GetContainerItemID or (C_Container and C_Container.GetContainerItemID)
local GetContainerItemLink = GetContainerItemLink or (C_Container and C_Container.GetContainerItemLink)
local GetContainerNumFreeSlots = GetContainerNumFreeSlots or (C_Container and C_Container.GetContainerNumFreeSlots)
local GetContainerNumSlots = GetContainerNumSlots or (C_Container and C_Container.GetContainerNumSlots)
local PickupContainerItem = PickupContainerItem or (C_Container and C_Container.PickupContainerItem)
local SplitContainerItem = SplitContainerItem or (C_Container and C_Container.SplitContainerItem)
local SortBags = SortBags or (C_Container and C_Container.SortBags)
local SortBankBags = SortBankBags or (C_Container and C_Container.SortBankBags)
local SortReagentBankBags = SortReagentBankBags or (C_Container and C_Container.SortReagentBankBags)
local SetItemSearch = SetItemSearch or (C_Container and C_Container.SetItemSearch)
local GetBagSlotFlag = GetBagSlotFlag or (C_Container and C_Container.GetBagSlotFlag)
local SetBagSlotFlag = SetBagSlotFlag or (C_Container and C_Container.SetBagSlotFlag)
local GetBankBagSlotFlag = GetBankBagSlotFlag or (C_Container and C_Container.GetBankBagSlotFlag)
local SetBankBagSlotFlag = SetBankBagSlotFlag or (C_Container and C_Container.SetBankBagSlotFlag)
local GetBackpackAutosortDisabled = GetBackpackAutosortDisabled or (C_Container and C_Container.GetBackpackAutosortDisabled)
local GetBankAutosortDisabled = GetBankAutosortDisabled or (C_Container and C_Container.GetBankAutosortDisabled)
local GetContainerItemCooldown = GetContainerItemCooldown or (C_Container and C_Container.GetContainerItemCooldown)
local SetBackpackAutosortDisabled = SetBackpackAutosortDisabled or (C_Container and C_Container.SetBackpackAutosortDisabled)
local SetInsertItemsLeftToRight = SetInsertItemsLeftToRight or (C_Container and C_Container.SetInsertItemsLeftToRight)
local GetInsertItemsLeftToRight = GetInsertItemsLeftToRight or (C_Container and C_Container.GetInsertItemsLeftToRight)
local UseContainerItem = UseContainerItem or (C_Container and C_Container.UseContainerItem)
--------
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
--==========================================================
hooksecurefunc(GameTooltip, "SetBagItem", function(self, bag, slot)
	if not fuFrame.ItemSell.V then return end
	if not MerchantFrame:IsVisible() then
		local _, link = self:GetItem()
		if link then
			local itemSellG = select(11, GetItemInfo(link))
			if itemSellG and itemSellG > 0 then
				local _, count = GetContainerItemInfo(bag, slot)
				local count = count or 1
				self:AddDoubleLine("卖店价:",GetMoneyString(itemSellG*count))
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
		if itemSellG and itemSellG > 0 then
			local _, _, count = GetQuestItemInfo(questType, index)
			local count = count or 1
			self:AddDoubleLine("卖店价:",GetMoneyString(itemSellG*count))
			self:Show()
		end
	end
end)
hooksecurefunc(GameTooltip, "SetQuestLogItem", function(self,  questType, index)
	if not fuFrame.ItemSell.V then return end
	local _, link = self:GetItem()
	if link then
		local itemSellG = select(11, GetItemInfo(link))
		if itemSellG and itemSellG > 0 then
			local _, _, count = GetQuestLogRewardInfo(index)
			local count = count or 1
			self:AddDoubleLine("卖店价:",GetMoneyString(itemSellG*count))
			self:Show()
		end
	end
end)

fuFrame.ItemSell = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame.wupinxians1,"TOPLEFT",20,-20,"显示物品售价","在鼠标提示上显示物品售价")
fuFrame.ItemSell:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ShowPlus']['ItemSell']="ON";
		fuFrame.ItemSell.V=true
	else
		PIG['ShowPlus']['ItemSell']="OFF";
		fuFrame.ItemSell.V=false
	end
end);

--------------
fuFrame.ItemLevel = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame.wupinxians1,"TOPLEFT",300,-20,"显示物品ID/版本或LV","在鼠标提示上显示物品ID/版本或LV")
fuFrame.ItemLevel:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ShowPlus']['ItemLevel']="ON";
		fuFrame.ItemLevel.V=true
	else
		PIG['ShowPlus']['ItemLevel']="OFF";
		fuFrame.ItemLevel.V=false
	end
end);
local banbendata = {[0]='版本不明',[1]='燃烧的远征',[2]='巫妖王之怒',[3]='大地的裂变',[4]='熊猫人之谜',[5]='德拉诺之王',[6]='军团再临',[7]='争霸艾泽拉斯',[8]='暗影国度'}
GameTooltip:HookScript("OnTooltipSetItem", function(self)
	if not fuFrame.ItemLevel.V then return end
	local _, link = self:GetItem()
	if link then
		local itemID = GetItemInfoInstant(link)
		if itemID then
			if tocversion>39999 then
		    	local expacID = select(15, GetItemInfo(link))
		    	if expacID then
		    		self:AddDoubleLine("物品ID:"..itemID,banbendata[expacID])
		    	end
			else
				local effectiveILvl = GetDetailedItemLevelInfo(link)
				if effectiveILvl then
					self:AddDoubleLine("物品ID:"..itemID,"物品LV:"..effectiveILvl)
				end
			end	
			self:Show()
		end
	end
end)

----------------
fuFrame.SpellID = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame.wupinxians1,"TOPLEFT",20,-60,"显示技能ID/BUFF来源","在鼠标提示上显示技能ID/BUFF来源")
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
		local id = id:gsub("spell:","")
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
addonTable.ShowPlus_Tooltip = function()
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
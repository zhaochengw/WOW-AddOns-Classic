local _, addonTable = ...;
-----------------------
local fuFrame=List_R_F_1_1
local FrameLevel=addonTable.SellBuyFrameLevel
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local _, _, _, tocversion = GetBuildInfo()
--===========================================================
fuFrame.AutoRepair = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-260,"自动修理", "打开商人界面自动修理身上和背包物品")
fuFrame.AutoRepair:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['AutoSellBuy']['AutoRepair']="ON";
	else
		PIG['AutoSellBuy']['AutoRepair']="OFF";
	end
end);
fuFrame.GonghuiRepair = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",300,-260,"优先使用公会资金(>=TBC)", "修理时优先使用公会资金")
if tocversion<20000 then fuFrame.GonghuiRepair:Disable() fuFrame.GonghuiRepair.Text:SetTextColor(0.4, 0.4, 0.4, 1) end
fuFrame.GonghuiRepair:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['AutoSellBuy']['AutoRepair_GUILD']="ON";
	else
		PIG['AutoSellBuy']['AutoRepair_GUILD']="OFF";
	end
end);

MerchantFrame:HookScript("OnShow",function (self,event)
	if fuFrame.AutoRepair:GetChecked() then
		if CanMerchantRepair() then --NPC是否可以修理
			local cost = GetRepairAllCost()--修理金额
			if cost > 0 then
				if fuFrame.GonghuiRepair:IsEnabled() and fuFrame.GonghuiRepair:GetChecked() and IsInGuild() then
						local PIGguildMoney = GetGuildBankWithdrawMoney()--玩家的公会提取额度
						if PIGguildMoney > GetGuildBankMoney() then --公会金额小于提取金额
							PIGguildMoney = GetGuildBankMoney()
						end
						if PIGguildMoney >= cost and CanGuildBankRepair() then
							RepairAllItems(true);
							print("|cFF00ffff!Pig|r本次[公会]修理花费：" .. GetCoinTextureString(cost));	
							return
						end
				end
				----
				local money = GetMoney()--自身金钱
				if money >= cost then
					RepairAllItems()
					print("|cFF00ffff!Pig|r本次修理花费：" .. GetCoinTextureString(cost));
				else
					print("|cFFff0000!Pig|r自动修理失败：你没有足够的钱");
				end
			end
		end
	end
end)
--===================================================
addonTable.AutoSellBuy_Repair = function()
	if PIG['AutoSellBuy']['AutoRepair']=="ON" then
		fuFrame.AutoRepair:SetChecked(true);
	end
	if PIG['AutoSellBuy']['AutoRepair_GUILD']=="ON" then
		fuFrame.GonghuiRepair:SetChecked(true);
	end
end
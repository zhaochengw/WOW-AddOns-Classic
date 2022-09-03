local _, addonTable = ...;
-----------------------
local fuFrame=List_R_F_1_1
local FrameLevel=addonTable.SellBuyFrameLevel
--===========================================================
fuFrame.AutoRepair = CreateFrame("CheckButton", nil,fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.AutoRepair:SetSize(30,32);
fuFrame.AutoRepair:SetHitRectInsets(0,-100,0,0);
fuFrame.AutoRepair:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-260);
fuFrame.AutoRepair.Text:SetText("自动修理");
fuFrame.AutoRepair.tooltip = "打开商人界面自动修理身上和背包物品！";
fuFrame.AutoRepair:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['AutoSellBuy']['AutoRepair']="ON";
	else
		PIG['AutoSellBuy']['AutoRepair']="OFF";
	end
end);
fuFrame.GonghuiRepair = CreateFrame("CheckButton", nil,fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.GonghuiRepair:SetSize(30,32);
fuFrame.GonghuiRepair:SetHitRectInsets(0,-100,0,0);
fuFrame.GonghuiRepair:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-260);
fuFrame.GonghuiRepair.Text:SetText("优先使用公会资金(>=TBC)");
fuFrame.GonghuiRepair.tooltip = "修理时优先使用公会资金！";
local _, _, _, tocversion = GetBuildInfo()
if tocversion<20000 then fuFrame.GonghuiRepair:Disable() fuFrame.GonghuiRepair.Text:SetTextColor(0.4, 0.4, 0.4, 1) end
fuFrame.GonghuiRepair:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['AutoSellBuy']['AutoRepair_GUILD']="ON";
	else
		PIG['AutoSellBuy']['AutoRepair_GUILD']="OFF";
	end
end);

MerchantFrame:HookScript("OnEvent",function (self,event)
	if event=="MERCHANT_SHOW" then
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
	end
end)
--===================================================
addonTable.AutoSellBuy_Repair = function()
	PIG['AutoSellBuy']["AutoRepair"]=PIG['AutoSellBuy']["AutoRepair"] or addonTable.Default['AutoSellBuy']["AutoRepair"];
	if PIG['AutoSellBuy']['AutoRepair']=="ON" then
		fuFrame.AutoRepair:SetChecked(true);
	end
	PIG['AutoSellBuy']["AutoRepair_GUILD"]=PIG['AutoSellBuy']["AutoRepair_GUILD"] or addonTable.Default['AutoSellBuy']["AutoRepair_GUILD"];
	if PIG['AutoSellBuy']['AutoRepair_GUILD']=="ON" then
		fuFrame.GonghuiRepair:SetChecked(true);
	end
end
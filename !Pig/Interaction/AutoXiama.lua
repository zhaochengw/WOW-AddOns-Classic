local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_1_UI
--////自动站立下马///////////////////////
local errList = {[SPELL_FAILED_NOT_MOUNTED] = true,[ERR_ATTACK_MOUNTED] = true,[ERR_TAXIPLAYERALREADYMOUNTED] = true,	}

local function zidongxiamashijian(self,event, key, state)
	--if state == SPELL_FAILED_NOT_STANDING then
	if state == '你必须处于站立状态下才能进行搜索！' or state == '你必须处于站立状态下才能那么做' or state == '你不能在变形状态下使用空中运输服务！' then
		DoEmote("stand")--站立
	elseif errList[state] or state == '你不能在骑乘状态下那么做。' or state == '你已经上了坐骑！请先下来。' then
		Dismount()	--下马
	-- elseif state == '你不能在变形状态下使用空中运输服务！' then
	-- 	cancelform()
	end
	--print(event,key,state);
end
local zidongxiama = CreateFrame("Frame")
zidongxiama:SetScript("OnEvent", zidongxiamashijian)

fuFrame.AutoDown = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.AutoDown:SetSize(30,32);
fuFrame.AutoDown:SetHitRectInsets(0,-100,0,0);
fuFrame.AutoDown:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-60);
fuFrame.AutoDown.Text:SetText("自动下马/站立");
fuFrame.AutoDown.tooltip = "自动下马/站立！";
fuFrame.AutoDown:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['Interaction']['AutoDown']="ON";
		zidongxiama:RegisterEvent("UI_ERROR_MESSAGE")		
	else
		PIG['Interaction']['AutoDown']="OFF";
		zidongxiama:UnregisterEvent("UI_ERROR_MESSAGE")
	end

end);

--------------------
addonTable.Interaction_AutoDown = function()
	if PIG['Interaction']['AutoDown']=="ON" then
		fuFrame.AutoDown:SetChecked(true);
		zidongxiama:RegisterEvent("UI_ERROR_MESSAGE")
	end
end
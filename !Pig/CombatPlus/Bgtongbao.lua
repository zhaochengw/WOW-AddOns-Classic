local _, addonTable = ...;
----------
local fuFrame=List_R_F_1_3
local ADD_Checkbutton=addonTable.ADD_Checkbutton
----------战场通报按钮
local function CombatPlus_BGtongbao_Open()
	if BGanniuUI==nil then
		local BGanniu = CreateFrame("Button","BGanniuUI",UIParent, "UIPanelButtonTemplate");  
		BGanniu:SetSize(80,30);
		BGanniu:SetPoint("BOTTOM",UIParent,"BOTTOM",100,260);
		BGanniu:SetText("战情通报");
		BGanniu:SetMovable(true)
		BGanniu:SetClampedToScreen(true)
		BGanniu:RegisterForDrag("LeftButton")
		BGanniu:SetScript("OnDragStart",function()
			BGanniu:StartMoving()
		end)
		BGanniu:SetScript("OnDragStop",function()
			BGanniu:StopMovingOrSizing()
		end)
		BGanniu:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		BGanniu:SetScript("OnClick", function (self, event)
			if event=="RightButton" then
				SendChatMessage( GetMinimapZoneText().."已安全，机动人员请机动支援！", "instance_chat") 
			else
				if not direnshuliangpig or not hanhuaTimejiange or GetTime()-hanhuaTimejiange>10 then
					direnshuliangpig=0;
				end;
				hanhuaTimejiange=GetTime(); direnshuliangpig=direnshuliangpig+1; SendChatMessage( GetMinimapZoneText().."有"..direnshuliangpig.."个敌人来袭，请求支援！", "instance_chat"); 
			end
		end);
		BGanniu:RegisterEvent("PLAYER_ENTERING_WORLD");
		BGanniu:RegisterEvent("ZONE_CHANGED_NEW_AREA");
		BGanniu:SetScript("OnEvent", function ()		
			local inInstance, instanceType =IsInInstance()
			if inInstance and instanceType=="pvp" then
				BGanniu:Show()
			else
				BGanniu:Hide()
			end
		end);
	end
end
---------------------
local BGtooltip = "在动作条上方增加战场快捷通报按钮,点击可以通报当前位置来犯人数，对方来了三个人攻击，就点击三次。右键报告位置安全。注意战场外不显示"
fuFrame.BGtongbao = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",20,-80,"战场快捷通报按钮",BGtooltip)
fuFrame.BGtongbao:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['CombatPlus']['BGtongbao']="ON";
		CombatPlus_BGtongbao_Open();
	else
		PIG['CombatPlus']['BGtongbao']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
---重置位置
fuFrame.CZPoint = CreateFrame("Button",nil,fuFrame);
fuFrame.CZPoint:SetSize(22,22);
fuFrame.CZPoint:SetPoint("LEFT",fuFrame.BGtongbao.Text,"RIGHT",16,-1);
fuFrame.CZPoint.highlight = fuFrame.CZPoint:CreateTexture(nil, "HIGHLIGHT");
fuFrame.CZPoint.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
fuFrame.CZPoint.highlight:SetBlendMode("ADD")
fuFrame.CZPoint.highlight:SetPoint("CENTER", fuFrame.CZPoint, "CENTER", 0,0);
fuFrame.CZPoint.highlight:SetSize(30,30);
fuFrame.CZPoint.Normal = fuFrame.CZPoint:CreateTexture(nil, "BORDER");
fuFrame.CZPoint.Normal:SetTexture("interface/buttons/ui-refreshbutton.blp");
fuFrame.CZPoint.Normal:SetBlendMode("ADD")
fuFrame.CZPoint.Normal:SetPoint("CENTER", fuFrame.CZPoint, "CENTER", 0,0);
fuFrame.CZPoint.Normal:SetSize(18,18);
fuFrame.CZPoint:HookScript("OnMouseDown", function (self)
	fuFrame.CZPoint.Normal:SetPoint("CENTER", fuFrame.CZPoint, "CENTER", -1.5,-1.5);
end);
fuFrame.CZPoint:HookScript("OnMouseUp", function (self)
	fuFrame.CZPoint.Normal:SetPoint("CENTER", fuFrame.CZPoint, "CENTER", 0,0);
end);
fuFrame.CZPoint:SetScript("OnEnter", function ()
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(fuFrame.CZPoint, "ANCHOR_TOPLEFT",0,0);
	GameTooltip:AddLine("提示：")
	GameTooltip:AddLine("\124cff00ff00重置通报按钮的位置\124r")
	GameTooltip:Show();
end);
fuFrame.CZPoint:SetScript("OnLeave", function ()
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end);
fuFrame.CZPoint:SetScript("OnClick", function ()
	if BGanniuUI then
		BGanniuUI:ClearAllPoints();
		BGanniuUI:SetPoint("BOTTOM",UIParent,"BOTTOM",100,260);
	end
end)
--=====================================
addonTable.CombatPlus_BGtongbao = function()
	if PIG['CombatPlus']['BGtongbao']=="ON" then
		fuFrame.BGtongbao:SetChecked(true);
		CombatPlus_BGtongbao_Open();
	end
end
local _, addonTable = ...;
local Width,Height,jiangejuli = 24,24,0;
-------------------------------------------
local function ADD_QuickBut_jiuwei()
	local fuFrame=QuickChatFFF_UI
	local ziframe = {fuFrame:GetChildren()}
	if PIG["ChatFrame"]["QuickChat_style"]==1 then
		fuFrame.jiuweidaojishi = CreateFrame("Button",nil,fuFrame, "TruncatedButtonTemplate"); 
	elseif PIG["ChatFrame"]["QuickChat_style"]==2 then
		fuFrame.jiuweidaojishi = CreateFrame("Button",nil,fuFrame, "UIMenuButtonStretchTemplate"); 
	end
	fuFrame.jiuweidaojishi:SetSize(Width,Height);
	fuFrame.jiuweidaojishi:SetFrameStrata("LOW")
	fuFrame.jiuweidaojishi:SetPoint("LEFT",fuFrame,"LEFT",#ziframe*Width,0);
	fuFrame.jiuweidaojishi:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	fuFrame.jiuweidaojishi.Tex = fuFrame.jiuweidaojishi:CreateTexture(nil, "BORDER");
	fuFrame.jiuweidaojishi.Tex:SetTexture("interface/pvpframe/icon-combat.blp");
	fuFrame.jiuweidaojishi.Tex:SetPoint("CENTER",fuFrame.jiuweidaojishi,"CENTER",-0,1);
	fuFrame.jiuweidaojishi.Tex:SetSize(Width-7,Height-5);
	fuFrame.jiuweidaojishi:SetScript("OnMouseDown", function (self)
		self.Tex:SetPoint("CENTER",1,0);
	end);
	fuFrame.jiuweidaojishi:SetScript("OnMouseUp", function (self)
		self.Tex:SetPoint("CENTER",0,1);
	end);
	fuFrame.jiuweidaojishi:SetScript("OnEnter", function (self)	
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:SetText("|cff00FFff左键-|r|cffFFFF00就位确认\n|cff00FFff右键-|r|cffFFFF00开怪倒计时|r");
		GameTooltip:Show();
		GameTooltip:FadeOut()
	end);
	fuFrame.jiuweidaojishi:SetScript("OnLeave", function (self)
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	fuFrame.kaiguaidaojishi=5
	local function daojishikaiguai()
		local IsInRaid=IsInRaid();
		if IsInRaid then
			if fuFrame.kaiguaidaojishi==0 then
				SendChatMessage("***开始攻击***", "RAID_WARNING", nil);
			else
				SendChatMessage("***开怪倒计时："..fuFrame.kaiguaidaojishi.."***", "RAID_WARNING", nil);
			end
		else
			if fuFrame.kaiguaidaojishi==0 then
				SendChatMessage("***开始攻击***", "PARTY", nil);
			else
				SendChatMessage("***开怪倒计时："..fuFrame.kaiguaidaojishi.."***", "PARTY", nil);
			end
		end
		if fuFrame.kaiguaidaojishi>0 then
			fuFrame.kaiguaidaojishi=fuFrame.kaiguaidaojishi-1
			C_Timer.After(1,daojishikaiguai)
		else
			fuFrame.kaiguaidaojishi=5
		end
	end
	fuFrame.jiuweidaojishi:SetScript("OnClick", function(self, event)
		if event=="LeftButton" then
			DoReadyCheck()
		else
			local inGroup = IsInGroup();
			if inGroup then
				if fuFrame.kaiguaidaojishi==5 then
					daojishikaiguai()
				end
			end
		end
	end);
end
--=====================================
addonTable.ADD_QuickBut_jiuwei = ADD_QuickBut_jiuwei
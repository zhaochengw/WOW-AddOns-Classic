local _, addonTable = ...;
local fuFrame=List_R_F_1_5
local ADD_Checkbutton=addonTable.ADD_Checkbutton
---BUFF/DEBUFF框架精确时间=======================
local function BuffTimeFrame_Open()
	local function Buff_OnUpdate(self)
		local Duration=self.duration
		local timeLeft=self.timeLeft
		local d, h, m, s = ChatFrame_TimeBreakDown(timeLeft);
		if( timeLeft <= 0 ) then
			Duration:SetText("");
		elseif( timeLeft < 30 ) then 
			--Duration:SetFormattedText("|c00FF8050%d|r", s); --小于30秒
			Duration:SetFormattedText("|c00FF8050%.1f|r", s);--秒带小数点
		elseif( timeLeft < 60 ) then
			Duration:SetFormattedText("|c00FFAF60%d|r", s); --30秒-1分钟			
		elseif( timeLeft < 600 ) then
			Duration:SetFormattedText("|c00FFFF40%d:%02d|r", m, s); --1-10分钟
		elseif( timeLeft <= 3600 ) then
			Duration:SetFormattedText("|c0000FF00%dm|r", m);--10分钟-60分钟
		elseif( timeLeft <= 86400 ) then 
			Duration:SetFormattedText("|c0000FF00%1dH:%02d|r", h, m);--1小时-1天
		else
			Duration:SetFormattedText("|cff00FF00%dd%02dh|r",d,h);--大于一天
		end
	end

	local function Buff_Update(self)
		local zongbuffs = {self.AuraContainer:GetChildren()}
		for i=1,#zongbuffs do 
			local buffUI = zongbuffs[i].duration		
			buffUI:Show();
			buffUI:SetFormattedText("|cff00ff00N/A|r");
			hooksecurefunc(zongbuffs[i], "UpdateDuration", function(self)
				Buff_OnUpdate(self)
			end)
		end
	end
	hooksecurefunc(BuffFrame, "Update", function(self)
		Buff_Update(self)
	end)
	local function Debuff_OnUpdate(self)
		local Duration=self.duration
		local timeLeft=self.timeLeft
		local d, h, m, s = ChatFrame_TimeBreakDown(timeLeft);
		if( timeLeft < 30 ) then
			Duration:SetFormattedText("|cffFF4500%.1f|r", s);--秒带小数点
			--Duration:SetFormattedText("|cffFF4500%d|r", s); --小于30秒
		elseif( timeLeft < 60 ) then
			Duration:SetFormattedText("|cffFF8050%d|r", s); --30秒-1分钟
		elseif( timeLeft < 600 ) then
			Duration:SetFormattedText("|cffFFAF60%d:%02d|r", m, s); --1-10分钟
		elseif( timeLeft <= 3600 ) then
			Duration:SetFormattedText("|cffFFFF40%dm|r", m);--10分钟-60分钟
		elseif( timeLeft <= 86400 ) then 
			Duration:SetFormattedText("|cffFFFF40%1dH:%02d|r", h, m);--1小时-1天
		else
			Duration:SetFormattedText("|cffFFFF40%dd%02dh|r",d,h);--大于一天
		end
	end
	local function Debuff_Update(self)
		local zongbuffs = {self.AuraContainer:GetChildren()}
		for i=1,#zongbuffs do 
			local buffUI = zongbuffs[i].duration		
			buffUI:Show();
			buffUI:SetFormattedText("|cffFFFF40N/A|r");
			hooksecurefunc(zongbuffs[i], "UpdateDuration", function(self)
				Debuff_OnUpdate(self)
			end)
		end
	end
	hooksecurefunc(DebuffFrame, "Update", function(self)
		Debuff_Update(self)
	end)
end

fuFrame.BuffTime = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",20,-60,"BUFF时间增强","增强自身BUFF/DEBUFF时间效果，精确到分秒")
fuFrame.BuffTime:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['BuffTime']="ON";
		BuffTimeFrame_Open();
	else
		PIG['FramePlus']['BuffTime']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);

--=====================================
addonTable.CombatPlus_BuffTime = function()
	if PIG['FramePlus']['BuffTime']=="ON" then
		fuFrame.BuffTime:SetChecked(true);
		BuffTimeFrame_Open();
	end
end
local _, addonTable = ...;
local fuFrame=List_R_F_1_5
local ADD_Checkbutton=addonTable.ADD_Checkbutton
---BUFF/DEBUFF框架精确时间=======================
local function BuffTimeFrame_Open()
	local function zijiBUFF()
		for i=1,40 do  	
			local name,_,_,_,duration,expirationTime = UnitBuff("player",i)
			local buffUI = _G["BuffButton"..i..'Duration'];
			if not name then
				break
			else			
				if buffUI then		
					if ( duration == 0 ) then
						buffUI:SetFormattedText("|cff00ff00N/A|r");
						buffUI:SetFont("Fonts\\ARHei.TTF", 13)
						buffUI:Show();
					else
						local time=expirationTime-GetTime()
						if( time <= 0 ) then
							buffUI:SetText("");
						elseif( time < 30 ) then 
							local d, h, m, s = ChatFrame_TimeBreakDown(time); 
							buffUI:SetFormattedText("|c00FF8050%d|r", s); --小于30秒
							--buffUI:SetFormattedText("|c00FF0000%.1f|r", s);--秒带小数点
						elseif( time < 60 ) then
							local d, h, m, s = ChatFrame_TimeBreakDown(time);
							buffUI:SetFormattedText("|c00FFAF60%d|r", s); --30秒-1分钟			
						elseif( time < 600 ) then
							local d, h, m, s = ChatFrame_TimeBreakDown(time);
							buffUI:SetFormattedText("|c00FFFF40%d:%02d|r", m, s); --1-10分钟
							buffUI:SetFont("Fonts\\ARHei.TTF", 12) 
						elseif( time <= 3600 ) then
							local d, h, m, s = ChatFrame_TimeBreakDown(time);
							buffUI:SetFormattedText("|c0000FF00%dm|r", m);--10分钟-60分钟
							buffUI:SetFont("Fonts\\ARHei.TTF", 12) 
						elseif( time <= 86400 ) then 
							local d, h, m, s = ChatFrame_TimeBreakDown(time);
							buffUI:SetFormattedText("|c0000FF00%1dH:%02d|r", h, m);--1小时-1天
							buffUI:SetFont("Fonts\\ARHei.TTF", 12)
						else
							local d, h, m, s = ChatFrame_TimeBreakDown(time); 
							buffUI:SetFormattedText("|cff00FF00%dd%02dh|r",d,h);--大于一天
							buffUI:SetFont("Fonts\\ARHei.TTF", 12)
						end
					end
				end
			end
		end
	end
	hooksecurefunc("AuraButton_Update", zijiBUFF);
	hooksecurefunc("AuraButton_UpdateDuration", zijiBUFF);
	local function zijiDEBUFF()--自己DEBUFF
		for i=1,40 do  		
			local name,_,_,_,_,expirationTime = UnitDebuff("player",i)
			local buffUI = _G["DebuffButton"..i..'Duration'];
			if not name then
				break
			else			
				if buffUI then	
					local time=expirationTime-GetTime()
					if( time < 30 ) then 
						local d, h, m, s = ChatFrame_TimeBreakDown(time); 
						buffUI:SetFormattedText("|cffFF4500%d|r", s); --小于30秒
					elseif( time < 60 ) then
						local d, h, m, s = ChatFrame_TimeBreakDown(time);
						buffUI:SetFormattedText("|cffFF8050%d|r", s); --30秒-1分钟
					elseif( time < 600 ) then
						local d, h, m, s = ChatFrame_TimeBreakDown(time);
						buffUI:SetFormattedText("|cffFFAF60%d:%02d|r", m, s); --1-10分钟
					elseif( time <= 3600 ) then
						local d, h, m, s = ChatFrame_TimeBreakDown(time);
						buffUI:SetFormattedText("|cffFFFF40%dm|r", m);--10分钟-60分钟
					elseif( time <= 86400 ) then 
						local d, h, m, s = ChatFrame_TimeBreakDown(time);
						buffUI:SetFormattedText("|cffFFFF40%1dH:%02d|r", h, m);--1小时-1天
					else
						local d, h, m, s = ChatFrame_TimeBreakDown(time); 
						buffUI:SetFormattedText("|cffFFFF40%dd%02dh|r",d,h);--大于一天
					end
				end
			end
		end
	end
	hooksecurefunc("AuraButton_Update", zijiDEBUFF);
	hooksecurefunc("AuraButton_UpdateDuration", zijiDEBUFF);
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
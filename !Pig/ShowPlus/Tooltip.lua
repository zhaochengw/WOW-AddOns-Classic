local _, addonTable = ...;
local gsub = _G.string.gsub
local sub = _G.string.sub 
local find = _G.string.find
local fuFrame=List_R_F_1_5
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
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
--==============================
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
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
	if not fuFrame.ItemLevel.V then return end
	if tooltip == GameTooltip then
		local ItemID = data["id"]
		if ItemID then	
			if tocversion>39999 then
		    	local expacID = select(15, GetItemInfo(ItemID))
		    	if expacID then
		    		tooltip:AddDoubleLine("物品ID:"..ItemID,banbendata[expacID])
		    	end
			else
				local effectiveILvl = GetDetailedItemLevelInfo(ItemID)
				if effectiveILvl then
					tooltip:AddDoubleLine("物品ID:"..ItemID,"物品LV:"..effectiveILvl)
				end
			end
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
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function(self)
	if not fuFrame.SpellID.V then return end
	local _,spellId = self:GetSpell()
	if spellId then
		self:AddDoubleLine("SpellID:",spellId)
		self:Show()
	end
end)

--加载设置---------------
addonTable.ShowPlus_Tooltip = function()
	if PIG['ShowPlus']['ItemLevel']=="ON" then
		fuFrame.ItemLevel:SetChecked(true);
		fuFrame.ItemLevel.V=true
	end
	if PIG['ShowPlus']['SpellID']=="ON" then
		fuFrame.SpellID:SetChecked(true);
		fuFrame.SpellID.V=true
	end
end
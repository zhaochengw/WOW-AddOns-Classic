local _, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--=======================================
local fuFrame=List_R_F_1_3
----开关宠物嘲讽技能提示-进入副本提示关宠物嘲讽技能低吼
local function CombatPlus_PetTishi()
	if PETchaofengtishiUI==nil then
		local _, classId = UnitClassBase("player");
		--职业编号1战士/2圣骑士/3猎人/4盗贼/5牧师/6死亡骑士/7萨满祭司/8法师/9术士/10武僧/11德鲁伊/12恶魔猎手
		if classId==3 or  classId==9 then
			local chaofengjinengName=""
			if classId==3 then
			 	chaofengjinengName="低吼"
			elseif classId==9 then
				if tocversion<80000 then
					chaofengjinengName="受难"
				else
					chaofengjinengName="胁迫气场"
				end
			end

			local Width,Height = 30,30;
			local PETchaofengtishi = CreateFrame("Frame", "PETchaofengtishiUI", PetActionBarFrame);
			PETchaofengtishi:SetSize(Width,Height);
			PETchaofengtishi:SetPoint("BOTTOM", PetActionBarFrame, "TOP", 0, 10);
			PETchaofengtishi.Icon = PETchaofengtishi:CreateTexture(nil, "ARTWORK");
			PETchaofengtishi.Icon:SetTexture("interface/common/help-i.blp");
			PETchaofengtishi.Icon:SetSize(Width*1.6,Height*1.6);
			PETchaofengtishi.Icon:SetPoint("CENTER");
			PETchaofengtishi:Hide()
			-----------
			local function PetTishizhhixing()
				local inInstance = IsInInstance();
				local tishibiaoti,tishineirong="|cff00FFFF猪猪加油提示：","";
				local hasPetSpells, _ = HasPetSpells()
				if hasPetSpells then
					for i=1, hasPetSpells do
						local spellName = GetSpellBookItemName(i, BOOKTYPE_PET)
				 		yizhaodaoPETspell=false
						if spellName==chaofengjinengName then
							yizhaodaoPETspell=true 
							local autocastable, autostate = GetSpellAutocast(i, BOOKTYPE_PET)
							if inInstance then
								if autostate then
									tishineirong="|cffFFFF00副本内开启宠物嘲讽可能干扰坦克仇恨！|r";
									PETchaofengtishi:Show()
								else
									PETchaofengtishi:Hide()
								end
							else
								if autostate then
									PETchaofengtishi:Hide()
								else
									PETchaofengtishi:Show()
									tishineirong="|cffFFFF00野外关闭宠物嘲讽可能造成宠物仇恨匮乏！|r";
								end
							end
							break
						end
					end
				end
				for ii=4, 7 do
					local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(ii);
					if name=="低吼" then
						PETchaofengtishi:SetPoint("BOTTOM", _G['PetActionButton'..ii], "TOP", 0, 0);
					end
				end
				PETchaofengtishi:SetScript("OnEnter", function ()
					GameTooltip:ClearLines();
					GameTooltip:SetOwner(PETchaofengtishi, "ANCHOR_TOPLEFT",2,4);
					GameTooltip:AddLine(tishibiaoti)
					GameTooltip:AddLine(tishineirong)
					GameTooltip:Show();
				end);
				PETchaofengtishi:SetScript("OnLeave", function ()
					GameTooltip:ClearLines();
					GameTooltip:Hide() 
				end);
			end
			----------
			local PETchaofeng= CreateFrame("Frame");
			PETchaofeng:RegisterEvent("PET_BAR_UPDATE")
			PETchaofeng:SetScript("OnEvent",PetTishizhhixing)
			PetTishizhhixing()
		end
	end
end
----------
local Pettooltip = "在宠物嘲讽技能上方增加一个提示按钮，副本内提示关闭宠物嘲讽/副本外提示开启！\r|cffFFff00（只对有宠物职业生效）|r";
fuFrame.PetTishi = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",300,-140,"宠物嘲讽开关提示",Pettooltip)
fuFrame.PetTishi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['CombatPlus']['PetTishi']="ON";
		CombatPlus_PetTishi()
	else
		PIG['CombatPlus']['PetTishi']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
addonTable.CombatPlus_PetTishi = function()
	if PIG['CombatPlus']['PetTishi']=="ON" then
		fuFrame.PetTishi:SetChecked(true);
		CombatPlus_PetTishi()
	end
end
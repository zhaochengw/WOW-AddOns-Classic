--隐藏宠物头像伤害治疗量
PetHitIndicator:SetText(nil)
PetHitIndicator.SetText = function() end

-- 水元素持续时间
local pet = CreateFrame("frame")
pet:SetFrameLevel(99)
pet:SetSize(28,28)
pet:SetPoint("CENTER","PetPortrait")

local cd = CreateFrame("Cooldown", nil, pet, "CooldownFrameTemplate")
cd:SetAllPoints()
cd:SetSwipeTexture("Interface\\CHARACTERFRAME\\TempPortraitAlphaMaskSmall")
cd:SetReverse(true)
cd:SetUseCircularEdge(true)

pet:RegisterEvent("UNIT_PET", "player")
pet:SetScript("OnEvent", function()
	if UnitExists('pet') and not UnitIsDead('pet') then
		local guid = (UnitGUID('pet')):reverse():sub(12)
		local hep = guid:find('-')
		local npc_id = tonumber(guid:sub(1, hep - 1):reverse())
		if npc_id ==510 then
			cd:Show()
			cd:SetCooldownDuration(44.5,1) 
		end
	else
		cd:Hide()
	end
end)
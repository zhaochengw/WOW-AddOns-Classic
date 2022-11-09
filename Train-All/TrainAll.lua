local event= CreateFrame("frame")
event:RegisterEvent("ADDON_LOADED")
local spot=0
local Cost, Bt_TrainAll
local done=false


local Classic = WOW_PROJECT_ID  == WOW_PROJECT_CLASSIC
local BC =  WOW_PROJECT_ID  == WOW_PROJECT_BURNING_CRUSADE_CLASSIC
local Wrath = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC 

local function GetServiceInfo(index)
	local status
	if Classic or BC or Wrath then
		_, _, status = GetTrainerServiceInfo(index)
		return status
	else
		_, status =  GetTrainerServiceInfo(index)
		return status
	end
end

local function pauseit()
	spot = 0
	Bt_TrainAll()
end

function Bt_TrainAll()
	if done == true then
		spot = 0
		return
	end
	local Numskills = GetNumTrainerServices()
	local found = false
	while found == false do
		spot = spot + 1
		local status = GetServiceInfo(spot)
		if status == "available" then
			BuyTrainerService(spot)
			C_Timer.After(0.3, pauseit)
			found = true
		end
		if spot >= Numskills then
			done = true
			break
		end
	end
end

local function createit()
	local TrainAllButton = CreateFrame("Button", "TrainAllButton", ClassTrainerFrame, "MagicButtonTemplate")
	TrainAllButton:SetText("Train All")
	if Classic or BC or Wrath then
		TrainAllButton:SetPoint("LEFT",ClassTrainerTrainButton,"RIGHT")
		ClassTrainerCancelButton:Hide()
	else
		TrainAllButton:SetPoint("RIGHT",ClassTrainerTrainButton,"LEFT")
	end
	TrainAllButton:SetScript("OnEnter", function()
		GameTooltip:SetOwner(TrainAllButton, "ANCHOR_RIGHT")
		GameTooltip:SetText("Train All available skills\nHold Shift to train all skills Instantly\nTotal cost is "..GetMoneyString(Cost))
	end)
	TrainAllButton:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	TrainAllButton:SetScript("OnClick", function()
		if IsShiftKeyDown() then
			BuyTrainerService(0)
		else
			spot = 0
			done = false
			Bt_TrainAll()
		end
	end)
	if IsAddOnLoaded("ElvUI") then
		local E, _, _, _, _ = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
		local S = E:GetModule('Skins')
		S:HandleButton(TrainAllButton, 1)
	end
	hooksecurefunc("ClassTrainerFrame_Update", function()
		Cost = 0
		local Enable = false
		for i=1, GetNumTrainerServices() do
			local status = GetServiceInfo(i)
			if status == "available" then
				Cost = Cost + GetTrainerServiceCost(i)
				TrainAllButton:Enable()
				Enable = true
			end
		end
		if Enable == false then
			TrainAllButton:Disable()
		end
	end)
end

local function eventHandler(_,_,name)
	if name == "TrainAll" then
		if IsAddOnLoaded("Blizzard_TrainerUI") then
			createit()
			event:UnregisterEvent("ADDON_LOADED")
		end
	elseif name == "Blizzard_TrainerUI" then
		createit()
		event:UnregisterEvent("ADDON_LOADED")
	end
end

event:SetScript("OnEvent", eventHandler)

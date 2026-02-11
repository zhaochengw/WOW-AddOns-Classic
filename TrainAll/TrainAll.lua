--[[	TrainAll
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

--------------------------
--[[	Constants	]]
--------------------------
--[[	WOW_PROJECT_ID contains either of the following constants
	WOW_PROJECT_MAINLINE = 1
	WOW_PROJECT_CLASSIC = 2
	WOW_PROJECT_BURNING_CRUSADE_CLASSIC = 5
--]]
local IsMainline=(WOW_PROJECT_ID==WOW_PROJECT_MAINLINE);
local TrainerServiceInfo_CategoryIndex=(IsMainline and 2 or 3);

local function OnLoad()
	------------------
	--[[	Layout	]]
	------------------
	local btn; if IsMainline then
		btn=CreateFrame("Button","ClassTrainerTrainAllButton",ClassTrainerFrame,"MagicButtonTemplate");
		btn:SetPoint("TOPRIGHT",ClassTrainerTrainButton,"TOPLEFT");
	else
		btn=CreateFrame("Button","ClassTrainerTrainAllButton",ClassTrainerFrame,"UIPanelButtonTemplate");
		btn:SetPoint("TOPLEFT",72,-72);
		btn:SetSize(80,22);
	end
	btn:SetText("Train All");

	--------------------------
	--[[	Scripts & Hooks	]]
	--------------------------
	function btn:UpdateTooltip()--	GameTooltip_OnUpdate() runs self:GetOwner():UpdateTooltip()
		GameTooltip:ClearLines();
		GameTooltip:AddLine("Click to train all available skills.");
		GameTooltip:AddLine(("%d skills available for %s"):format(self.Count,GetCoinTextureString(self.Cost)));
	end

	btn:SetScript("OnEnter",function(self)
		GameTooltip:SetOwner(self,"ANCHOR_BOTTOMLEFT");
		self:UpdateTooltip();
		GameTooltip:Show();
	end);

	btn:SetScript("OnLeave",function(self) if GameTooltip:IsOwned(self) then GameTooltip:Hide(); end end);

	btn:SetScript("OnClick",function(self)
		for i=1,GetNumTrainerServices() do
			if select(TrainerServiceInfo_CategoryIndex,GetTrainerServiceInfo(i))=="available" then BuyTrainerService(i); end
		end
	end);

	hooksecurefunc("ClassTrainerFrame_Update",function()
		local sum,total=0,0;
		for i=1,GetNumTrainerServices() do
			if select(TrainerServiceInfo_CategoryIndex,GetTrainerServiceInfo(i))=="available" then
				sum,total=sum+1,total+GetTrainerServiceCost(i);
			end
		end
		btn:SetEnabled(sum>0);
		btn.Count,btn.Cost=sum,total;
	end);
end

--------------------------
--[[	Hook Loader	]]
--------------------------
--	BCC and Classic currently have a bug with the LoadWith tag no longer working
EventUtil.ContinueOnAddOnLoaded("Blizzard_TrainerUI",OnLoad);

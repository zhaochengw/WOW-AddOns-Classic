local _, addonTable = ...;
local fuFrame=List_R_F_1_3
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
----快速标记按钮------
local biaojiW=20;
local biaojiH=20;
local beijing = {bgFile = "Interface\\Tooltips\\UI-Tooltip-Background"}
local beijing_yidong = {
	bgFile = "Interface/DialogFrame/UI-DialogBox-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 0, edgeSize = 6,insets = { left = 0, right = 0, top = 0, bottom = 0 }
}
local biaoji_icon = "interface\\targetingframe\\ui-raidtargetingicons"
local biaoji_iconID = {
	{0.75,1,0.25,0.5},{0.5,0.75,0.25,0.5},{0.25,0.5,0.25,0.5},
	{0,0.25,0.25,0.5},{0.75,1,0,0.25},{0.5,0.75,0,0.25},
	{0.25,0.5,0,0.25},{0,0.25,0,0.25}
}

local function Mubiaokuaisubiaoji_Open()
	if mubiaobiaoji_UI then return end
	mubiaobiaoji = CreateFrame("Frame", "mubiaobiaoji_UI", TargetFrame,"BackdropTemplate")
	mubiaobiaoji:SetBackdrop(beijing)
	mubiaobiaoji:SetBackdropColor(0.1,0.1,0.1,0.5)
	mubiaobiaoji:SetSize((biaojiW+3)*8+3,biaojiH+2)
	local wzinfo = PIG.CombatPlus.Biaoji.Point
	if wzinfo then
		mubiaobiaoji:SetPoint(wzinfo[1],UIParent,wzinfo[2],wzinfo[3], wzinfo[4]);
	else
		mubiaobiaoji:SetPoint("TOPLEFT", TargetFrame, "TOPRIGHT", -10, -10);
	end
	mubiaobiaoji:SetMovable(true)
	mubiaobiaoji:SetClampedToScreen(true)
	if tocversion>40000 then mubiaobiaoji:SetFrameLevel(505) end
	mubiaobiaoji.yidong = CreateFrame("Frame", nil, mubiaobiaoji,"BackdropTemplate")
	mubiaobiaoji.yidong:SetBackdrop(beijing_yidong)
	mubiaobiaoji.yidong:SetBackdropBorderColor(0, 1, 1, 0.8);
	mubiaobiaoji.yidong:SetSize(8,biaojiH+2)
	mubiaobiaoji.yidong:SetPoint("RIGHT", mubiaobiaoji, "LEFT", 0, 0);
	mubiaobiaoji.yidong:EnableMouse(true)
	mubiaobiaoji.yidong:RegisterForDrag("LeftButton")
	mubiaobiaoji.yidong:SetScript("OnDragStart",function()
		mubiaobiaoji:StartMoving()
	end)
	mubiaobiaoji.yidong:SetScript("OnDragStop",function()
		mubiaobiaoji:StopMovingOrSizing()
		local point, relativeTo, relativePoint, xOfs, yOfs = mubiaobiaoji:GetPoint()
		PIG.CombatPlus.Biaoji.Point={point, relativePoint, xOfs, yOfs};
	end)
	for i=1,#biaoji_iconID do
		mubiaobiaoji.list = CreateFrame("Button", "mubiaobiaoji_list"..i, mubiaobiaoji)
		mubiaobiaoji.list:SetSize(biaojiW,biaojiH)
		if i==1 then
			mubiaobiaoji.list:SetPoint("LEFT", mubiaobiaoji, "LEFT",3,0)
		else
			mubiaobiaoji.list:SetPoint("LEFT", _G["mubiaobiaoji_list"..(i-1)], "RIGHT",3,0)
		end
		mubiaobiaoji.list:SetNormalTexture(biaoji_icon)
		mubiaobiaoji.list:GetNormalTexture():SetTexCoord(biaoji_iconID[i][1],biaoji_iconID[i][2],biaoji_iconID[i][3],biaoji_iconID[i][4])
		mubiaobiaoji.list:EnableMouse(true)
		mubiaobiaoji.list:SetScript("OnClick", function(self) SetRaidTargetIcon("target", 9-i) end)
	end
	--
	mubiaobiaoji:SetScript("OnEvent", function(self,event)
		if CanBeRaidTarget("target") then
			if IsInRaid("LE_PARTY_CATEGORY_HOME") then
				local isLeader = UnitIsGroupLeader("player");
				if isLeader or UnitIsGroupAssistant("player") then
					mubiaobiaoji:Show()
				else
					mubiaobiaoji:Hide()
				end
			else
				mubiaobiaoji:Show()
			end
		end
	end);
end
----------------------------
fuFrame.Biaojiline = fuFrame:CreateLine()
fuFrame.Biaojiline:SetColorTexture(1,1,1,0.2)
fuFrame.Biaojiline:SetThickness(1);
fuFrame.Biaojiline:SetStartPoint("TOPLEFT",3,-340)
fuFrame.Biaojiline:SetEndPoint("TOPRIGHT",-3,-340)

fuFrame.Biaoji = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame.Biaojiline,"TOPLEFT",17,-10,"快速标记按钮","在屏幕上显示快速标记按钮")

fuFrame.BiaojiYD =ADD_Checkbutton(nil,fuFrame,-80,"LEFT",fuFrame.Biaoji,"RIGHT",150,0,"锁定位置","锁定快速标记按钮位置，使其无法移动")
fuFrame.BiaojiYD:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.CombatPlus.Biaoji.Yidong=true;
		mubiaobiaoji.yidong:Hide()
	else
		PIG.CombatPlus.Biaoji.Yidong=false;
		mubiaobiaoji.yidong:Show()
	end
end);
fuFrame.AUTOSHOW= ADD_Checkbutton(nil,fuFrame,-80,"LEFT",fuFrame.BiaojiYD,"RIGHT",150,0,"智能显示/隐藏","当你没有标记权限时隐藏快捷标记按钮")
fuFrame.AUTOSHOW:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.CombatPlus.Biaoji.AutoShow=true;
		mubiaobiaoji_UI:RegisterEvent("PLAYER_TARGET_CHANGED");
	else
		PIG.CombatPlus.Biaoji.AutoShow=false;
		mubiaobiaoji_UI:UnregisterEvent("PLAYER_TARGET_CHANGED");
	end
end);
---
fuFrame.Biaoji:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG.CombatPlus.Biaoji.Open=true;
		fuFrame.BiaojiYD:Enable();
		fuFrame.AUTOSHOW:Enable();
		Mubiaokuaisubiaoji_Open();
	else
		PIG.CombatPlus.Biaoji.Open=false;
		fuFrame.BiaojiYD:Disable();
		fuFrame.AUTOSHOW:Disable();
		Pig_Options_RLtishi_UI:Show()
	end
end);
---
fuFrame:HookScript("OnShow", function (self)
	if PIG.CombatPlus.Biaoji.Open then
		fuFrame.Biaoji:SetChecked(true);
	end
	if PIG.CombatPlus.Biaoji.Yidong then
		fuFrame.BiaojiYD:SetChecked(true);
	end
	if PIG.CombatPlus.Biaoji.AutoShow then
		fuFrame.AUTOSHOW:SetChecked(true); 
	end
end);
--=====================================
addonTable.CombatPlus_Biaoji = function()
	if PIG.CombatPlus.Biaoji.Open then
		Mubiaokuaisubiaoji_Open();
		if PIG.CombatPlus.Biaoji.Yidong then
			mubiaobiaoji.yidong:Hide()
		end
		if PIG.CombatPlus.Biaoji.AutoShow then
			mubiaobiaoji_UI:RegisterEvent("PLAYER_TARGET_CHANGED");
		end
	else
		fuFrame.BiaojiYD:Disable();
		fuFrame.AUTOSHOW:Disable();
	end
end
local _, addonTable = ...;
-- local gsub = _G.string.gsub 
-- local find = _G.string.find
-- local sub = _G.string.sub
-- local fuFrame=List_R_F_2_3
-- local ADD_Checkbutton=addonTable.ADD_Checkbutton
-- ---==============================================
-- local function jieguanxitongR()
-- 	local PIGRaidF = CreateFrame("Frame", "PIGRaidF_UI", UIParent, "SecureFrameTemplate,BackdropTemplate")
-- 	PIGRaidF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 6,})
-- 	PIGRaidF:SetSize(30,10);
-- 	PIGRaidF:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",500,500);
-- 	PIGRaidF:EnableMouse(true)
-- 	PIGRaidF:RegisterForDrag("LeftButton")
-- 	PIGRaidF:SetScript("OnDragStart",function(self)
-- 		self:StartMoving()
-- 	end)
-- 	PIGRaidF:SetScript("OnDragStop",function(self)
-- 		self:StopMovingOrSizing()
-- 	end)

-- 	local RaidP = CreateFrame("Frame", "RaidP", PIGRaidF, "SecureGroupHeaderTemplate")
-- 	--RaidP:Hide()
-- 	RaidP:SetPoint("TOPLEFT", PIGRaidF, "TOPLEFT")
-- 		RaidP:SetWidth(64)
-- 		RaidP:SetHeight(36)
-- 	-- RaidP:SetAttribute("initialConfigFunction", [[
-- 	-- 	local parent = self:GetParent()
-- 	-- 	self:SetWidth(parent:GetAttribute("unitwidth") or 64)
-- 	-- 	self:SetHeight(parent:GetAttribute("unitheight") or 36)
-- 	-- ]])

-- 	RaidP:SetAttribute("template", "SecureUnitButtonTemplate")
-- 	RaidP:SetAttribute("point", "TOP")
-- 	RaidP:SetAttribute("xOffset", 0)
-- 	RaidP:SetAttribute("yOffset", -1)
-- 	RaidP:SetAttribute("unitsPerColumn", 5)
-- 	RaidP:SetAttribute("columnAnchorPoint", "LEFT")
-- 	RaidP:SetAttribute("columnSpacing", 1)
-- 	RaidP:SetAttribute("maxColumns", 40 / 5)
-- 	RaidP:SetAttribute("showRaid", 1)
-- 	--创建队伍角色框架
-- 	-- for p=1,8 do
-- 	-- 	local RaidP = CreateFrame("Frame", "RaidP_"..p, PIGRaidF,"SecureRaidGroupHeaderTemplate");
-- 	-- 	RaidP:SetPoint("TOPLEFT", PIGRaidF, "TOPLEFT")

-- 	-- 	RaidP:SetAttribute("initialConfigFunction", [[
-- 	-- 		local parent = self:GetParent()
-- 	-- 		self:SetWidth(parent:GetAttribute("unitwidth") or 64)
-- 	-- 		self:SetHeight(parent:GetAttribute("unitheight") or 36)
-- 	-- 	]])
-- 	-- 	RaidP:SetAttribute("groupFilter", i)
-- 	-- 	--PIGRaidF:SetFrameRef("subgroup"..i, RaidP)
-- 	-- end
-- end

------------------------------------------------
-- fuFrame.RaidFrame = ADD_Checkbutton(nil,fuFrame,-80,"TOPLEFT",fuFrame,"TOPLEFT",20,-20,"修复系统团队框架","修复系统团队框架人员变动框架无法正常点击问题")
-- fuFrame.RaidFrame:Disable();fuFrame.RaidFrame.Text:SetTextColor(0.4, 0.4, 0.4, 1) 
-- fuFrame.RaidFrame:SetScript("OnClick", function (self)
-- 	if self:GetChecked() then
-- 		PIG["RaidFrame"]["xiufu"]="ON";
-- 		jieguanxitongR()
-- 	else
-- 		PIG["RaidFrame"]["xiufu"]="OFF";
-- 		Pig_Options_RLtishi_UI:Show()
-- 	end
-- end);

--=====================================
addonTable.PIGRaidFrame = function()
	-- PIG["RaidFrame"]=PIG["RaidFrame"] or addonTable.Default["RaidFrame"]
	-- if PIG["RaidFrame"]["xiufu"]=="ON" then
	-- 	fuFrame.RaidFrame:SetChecked(true);
	-- 	jieguanxitongR()
	-- end
end
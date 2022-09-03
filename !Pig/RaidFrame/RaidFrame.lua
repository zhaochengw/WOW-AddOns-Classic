local _, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local sub = _G.string.sub
local fuFrame=List_R_F_2_3
---==============================================
local function jieguanxitongR()
	local PIGRaidF = CreateFrame("Frame", "PIGRaidF_UI", UIParent, "SecureFrameTemplate,BackdropTemplate")
	PIGRaidF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 6,})
	PIGRaidF:SetSize(30,10);
	PIGRaidF:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",500,500);
	PIGRaidF:EnableMouse(true)
	PIGRaidF:RegisterForDrag("LeftButton")
	PIGRaidF:SetScript("OnDragStart",function(self)
		self:StartMoving()
	end)
	PIGRaidF:SetScript("OnDragStop",function(self)
		self:StopMovingOrSizing()
	end)

	local RaidP = CreateFrame("Frame", "RaidP", PIGRaidF, "SecureGroupHeaderTemplate")
	--RaidP:Hide()
	RaidP:SetPoint("TOPLEFT", PIGRaidF, "TOPLEFT")
		RaidP:SetWidth(64)
		RaidP:SetHeight(36)
	-- RaidP:SetAttribute("initialConfigFunction", [[
	-- 	local parent = self:GetParent()
	-- 	self:SetWidth(parent:GetAttribute("unitwidth") or 64)
	-- 	self:SetHeight(parent:GetAttribute("unitheight") or 36)
	-- ]])

	RaidP:SetAttribute("template", "SecureUnitButtonTemplate")
	RaidP:SetAttribute("point", "TOP")
	RaidP:SetAttribute("xOffset", 0)
	RaidP:SetAttribute("yOffset", -1)
	RaidP:SetAttribute("unitsPerColumn", 5)
	RaidP:SetAttribute("columnAnchorPoint", "LEFT")
	RaidP:SetAttribute("columnSpacing", 1)
	RaidP:SetAttribute("maxColumns", 40 / 5)
	RaidP:SetAttribute("showRaid", 1)
	--创建队伍角色框架
	-- for p=1,8 do
	-- 	local RaidP = CreateFrame("Frame", "RaidP_"..p, PIGRaidF,"SecureRaidGroupHeaderTemplate");
	-- 	RaidP:SetPoint("TOPLEFT", PIGRaidF, "TOPLEFT")

	-- 	RaidP:SetAttribute("initialConfigFunction", [[
	-- 		local parent = self:GetParent()
	-- 		self:SetWidth(parent:GetAttribute("unitwidth") or 64)
	-- 		self:SetHeight(parent:GetAttribute("unitheight") or 36)
	-- 	]])
	-- 	RaidP:SetAttribute("groupFilter", i)
	-- 	--PIGRaidF:SetFrameRef("subgroup"..i, RaidP)
	-- end
end
---hooksecurefunc("CompactRaidFrameContainer_AddUnitFrame",function(...)
-- 	-- print(...)
-- 	-- local fff = ...
-- 	-- print(fff:GetName())

-- end)
-- 	local RaidiDuiwu = CreateFrame("Frame", "RaidiDuiwu_"..p.."_UI", TablistFrame_5_UI);
-- 	RaidiDuiwu:SetSize(duiwu_Width,duiwu_Height*5+24);
-- 	if p==1 then
-- 		RaidiDuiwu:SetPoint("TOPLEFT",TablistFrame_5_UI,"TOPLEFT",26,-54);
-- 	end
-- 	if p>1 and p<5 then
-- 		RaidiDuiwu:SetPoint("LEFT",_G["RaidiDuiwu_"..(p-1).."_UI"],"RIGHT",jiangeW,jiangeH);
-- 	end
-- 	if p==5 then
-- 		RaidiDuiwu:SetPoint("TOP",_G["RaidiDuiwu_1_UI"],"BOTTOM",0,-20);
-- 	end
-- 	if p>5 then
-- 		RaidiDuiwu:SetPoint("LEFT",_G["RaidiDuiwu_"..(p-1).."_UI"],"RIGHT",jiangeW,jiangeH);
-- 	end
-- 	for pp=1,5 do
-- 		local RaidiDuiwu = CreateFrame("Frame", "RaidiDuiwu_"..p.."_"..pp, _G["RaidiDuiwu_"..p.."_UI"]);
-- 		RaidiDuiwu:SetSize(duiwu_Width,duiwu_Height);
-- 		if pp==1 then
-- 			RaidiDuiwu:SetPoint("TOP",_G["RaidiDuiwu_"..p.."_UI"],"TOP",0,0);
-- 		else
-- 			RaidiDuiwu:SetPoint("TOP",_G["RaidiDuiwu_"..p.."_"..(pp-1)],"BOTTOM",0,-6);
-- 		end
-- 		local RaidiDuiwu_HP = RaidiDuiwu:CreateTexture("RaidiDuiwu_HP_"..p.."_"..pp, "BORDER");
-- 		RaidiDuiwu_HP:SetTexture("Interface/DialogFrame/UI-DialogBox-Background");
-- 		RaidiDuiwu_HP:SetColorTexture(1, 1, 1, 0.1)
-- 		RaidiDuiwu_HP:SetSize(duiwu_Width,duiwu_Height);
-- 		RaidiDuiwu_HP:SetPoint("CENTER");
-- 		local RaidiDuiwu_zhizeIcon = RaidiDuiwu:CreateTexture("RaidiDuiwu_zhizeIcon_"..p.."_"..pp, "ARTWORK");
-- 		RaidiDuiwu_zhizeIcon:SetTexture("interface/lfgframe/ui-lfg-icon-roles.blp");
-- 		RaidiDuiwu_zhizeIcon:SetSize(duiwu_Height-6,duiwu_Height-6);
-- 		RaidiDuiwu_zhizeIcon:SetPoint("LEFT", RaidiDuiwu, "LEFT", 2,0);
-- 		local RaidiDuiwu_Name = RaidiDuiwu:CreateFontString("RaidiDuiwu_Name_"..p.."_"..pp);
-- 		RaidiDuiwu_Name:SetPoint("CENTER",RaidiDuiwu,"CENTER",0,1);
-- 		RaidiDuiwu_Name:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
-- 		RaidiDuiwu_Name:SetText()
-- 		RaidiDuiwu_Name:Hide()
-- 		local RaidiDuiwu_Name_XS = RaidiDuiwu:CreateFontString("RaidiDuiwu_Name_XS_"..p.."_"..pp);
-- 		RaidiDuiwu_Name_XS:SetPoint("CENTER",RaidiDuiwu,"CENTER",0,1);
-- 		RaidiDuiwu_Name_XS:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
-- 		RaidiDuiwu_Name_XS:SetText()
-- 		local RaidiDuiwu_fenGbili = RaidiDuiwu:CreateTexture("RaidiDuiwu_fenGbili_"..p.."_"..pp, "ARTWORK");
-- 		RaidiDuiwu_fenGbili:SetTexture(fenGbiliIcon[1]);
-- 		RaidiDuiwu_fenGbili:SetSize(duiwu_Height-7,duiwu_Height-7);
-- 		RaidiDuiwu_fenGbili:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -2,-0.6);
-- 		local RaidiDuiwu_fenGbili_1 = RaidiDuiwu:CreateTexture("RaidiDuiwu_fenGbili_1_"..p.."_"..pp, "ARTWORK");
-- 		RaidiDuiwu_fenGbili_1:SetTexture(fenGbiliIcon[2]);
-- 		RaidiDuiwu_fenGbili_1:SetTexCoord(fenGbiliIconCaiqie[2][1],fenGbiliIconCaiqie[2][2],fenGbiliIconCaiqie[2][3],fenGbiliIconCaiqie[2][4]);
-- 		RaidiDuiwu_fenGbili_1:SetSize(duiwu_Height-10,duiwu_Height-10);
-- 		RaidiDuiwu_fenGbili_1:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -2,0);
-- 		local RaidiDuiwu_fenGbili_2 = RaidiDuiwu:CreateTexture("RaidiDuiwu_fenGbili_2_"..p.."_"..pp, "ARTWORK");
-- 		RaidiDuiwu_fenGbili_2:SetTexture(fenGbiliIcon[3]);
-- 		RaidiDuiwu_fenGbili_2:SetTexCoord(fenGbiliIconCaiqie[3][1],fenGbiliIconCaiqie[3][2],fenGbiliIconCaiqie[3][3],fenGbiliIconCaiqie[3][4]);
-- 		RaidiDuiwu_fenGbili_2:SetSize(duiwu_Height-10,duiwu_Height-10);
-- 		RaidiDuiwu_fenGbili_2:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -2,0);
-- 		_G["RaidiDuiwu_"..p.."_"..pp]:SetScript("OnMouseDown", function (self)
-- 			_G["RaidiDuiwu_zhizeIcon_"..p.."_"..pp]:SetPoint("LEFT",self,"LEFT",3,-1);
-- 			_G["RaidiDuiwu_fenGbili_"..p.."_"..pp]:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -0.5,-2.1);
-- 			_G["RaidiDuiwu_fenGbili_1_"..p.."_"..pp]:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -0.5,-1.5);
-- 			_G["RaidiDuiwu_fenGbili_2_"..p.."_"..pp]:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -0.5,-1.5);
-- 			_G["RaidiDuiwu_Name_XS_"..p.."_"..pp]:SetPoint("CENTER",self,"CENTER",1.5,-0.5);
-- 		end);
-- 		_G["RaidiDuiwu_"..p.."_"..pp]:SetScript("OnMouseUp", function (self,button)
-- 			_G["RaidiDuiwu_zhizeIcon_"..p.."_"..pp]:SetPoint("LEFT",self,"LEFT",2,0);
-- 			_G["RaidiDuiwu_fenGbili_"..p.."_"..pp]:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -2,-0.6);
-- 			_G["RaidiDuiwu_fenGbili_1_"..p.."_"..pp]:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -2,0);
-- 			_G["RaidiDuiwu_fenGbili_2_"..p.."_"..pp]:SetPoint("RIGHT", RaidiDuiwu, "RIGHT", -2,0);
-- 			_G["RaidiDuiwu_Name_XS_"..p.."_"..pp]:SetPoint("CENTER",self,"CENTER",0,1);
-- 			if button=="LeftButton" then
-- 				playersRight_UI:Hide();
-- 				playersLeft_UI:ClearAllPoints();
-- 				playersLeft_UI:SetPoint("TOP",self,"BOTTOM",0,4);
-- 				if playersLeft_UI:IsShown() then
-- 					playersLeft_UI:Hide();
-- 				else
-- 					playersLeft_UI:Show();
-- 					playersLeft.xiaoshidaojishi = 1.5;
-- 					playersLeft.zhengzaixianshi = true;
-- 				end
-- 				playersLeft_Name_UI:SetText(_G["RaidiDuiwu_Name_"..p.."_"..pp]:GetText());
-- 				playersLeft_ID_UI:SetText(p);playersLeft_ID1_UI:SetText(pp);
-- 				if playersLeft_Name_UI:GetWidth()>120 then
-- 					playersLeft_UI:SetWidth(playersLeft_Name_UI:GetWidth()+20)
-- 				end
-- 			elseif button=="RightButton" then
-- 				playersLeft_UI:Hide();
-- 				playersRight_UI:ClearAllPoints();
-- 				playersRight_UI:SetPoint("TOP",self,"BOTTOM",0,4);
-- 				if playersRight_UI:IsShown() then
-- 					playersRight_UI:Hide();
-- 				else
-- 					playersRight_UI:Show();
-- 					playersRight.xiaoshidaojishi = 1.5;
-- 					playersRight.zhengzaixianshi = true;
-- 				end
-- 				playersRight_Name_UI:SetText(_G["RaidiDuiwu_Name_"..p.."_"..pp]:GetText());
-- 				playersRight_ID_UI:SetText(p);playersRight_ID1_UI:SetText(pp);
-- 				if playersRight_Name_UI:GetWidth()>120 then
-- 					playersRight_UI:SetWidth(playersRight_Name_UI:GetWidth()+20)
-- 				end
-- 			end
-- 		end);
-- 	end
--end
-- 
-- local OLD_CompactRaidFrameContainer_LayoutFrames= CompactRaidFrameContainer_LayoutFrames
-- local OLD_CompactRaidFrameContainer_UpdateDisplayedUnits=CompactRaidFrameContainer_UpdateDisplayedUnits
-- local OLD_CompactRaidFrameContainer_AddPlayers=CompactRaidFrameContainer_AddPlayers
-- local OLD_CompactRaidFrameContainer_AddUnitFrame=CompactRaidFrameContainer_AddUnitFrame
-- CompactRaidFrameContainer_AddUnitFrame= function(self, unit, frameType)
-- 	local frame = CompactRaidFrameContainer_GetUnitFrame(self, unit, frameType);
-- 	print(frame:GetName())
-- 	-- CompactUnitFrame_SetUnit(frame, unit);
-- 	-- FlowContainer_AddObject(self, frame);
	
-- 	return frame;
-- end
-- CompactRaidFrameContainer_AddPlayers= function(self)
-- 	--print(self:GetName())
-- 	assert(self.flowSortFunc);	--No sort function defined! Call CompactRaidFrameContainer_SetFlowSortFunction.
-- 	assert(self.flowFilterFunc);	--No filter function defined! Call CompactRaidFrameContainer_SetFlowFilterFunction.
	
-- 	table.sort(self.units, self.flowSortFunc);
	
-- 	for i=1, #self.units do
-- 		local unit = self.units[i];
-- 		if ( self.flowFilterFunc(unit) ) then
-- 			CompactRaidFrameContainer_AddUnitFrame(self, unit, "raid");
-- 		end
-- 	end
	
-- 	FlowContainer_SetOrientation(self, "vertical")
-- end
-- CompactRaidFrameContainer_LayoutFrames= function(self)
-- 	--print("0000")
-- 	--OLD_CompactRaidFrameContainer_LayoutFrames(self);
-- 	--CompactRaidFrameContainer_UpdateDisplayedUnits(self);
-- 	--C_Timer.After(0.1,OLD_CompactRaidFrameContainer_LayoutFrames)
-- 	for i=1, #self.flowFrames do
-- 		if ( type(self.flowFrames[i]) == "table" and self.flowFrames[i].unusedFunc ) then
-- 			self.flowFrames[i]:unusedFunc();
-- 		end
-- 	end
-- 	FlowContainer_RemoveAllObjects(self);
	
-- 	FlowContainer_PauseUpdates(self);	--We don't want to update it every time we add an item.
	
	
-- 	if ( self.displayFlaggedMembers ) then
-- 		CompactRaidFrameContainer_AddFlaggedUnits(self);
-- 		FlowContainer_AddLineBreak(self);
-- 	end
	
-- 	if ( self.groupMode == "discrete" ) then
-- 		print("111")
-- 	-- 	CompactRaidFrameContainer_AddGroups(self);
-- 	elseif ( self.groupMode == "flush" ) then
-- 		print("222")
-- 		CompactRaidFrameContainer_AddPlayers(self);
-- 	else
-- 		print("333")
-- 	-- 	error("Unknown group mode");
-- 	end
	
-- 	if ( self.displayPets ) then
-- 		CompactRaidFrameContainer_AddPets(self);
-- 	end

-- 	FlowContainer_ResumeUpdates(self);
	
-- 	CompactRaidFrameContainer_UpdateBorder(self);
	
-- 	CompactRaidFrameContainer_ReleaseAllReservedFrames(self);
-- end


---以下部分代码借用自BlizzardRaidFramesFix，如有侵权，请联系删除
-- local resolveUnitID

-- do
--     local unitPrefix = {}
--     local unitSuffix = {}

--     do
--         local unit, pet = "player", "pet"
--         unitPrefix[unit] = unit
--         unitPrefix[unit .. "target"] = unit
--         unitPrefix[unit .. "targettarget"] = unit
--         unitSuffix[unit] = ""
--         unitSuffix[unit .. "target"] = "-target"
--         unitSuffix[unit .. "targettarget"] = "-target-target"
--         unitPrefix[pet] = unit
--         unitSuffix[pet] = "-pet"
--     end

--     for i = 1, MAX_PARTY_MEMBERS do
--         local unit, pet = "party" .. i, "partypet" .. i
--         unitPrefix[unit] = unit
--         unitPrefix[unit .. "target"] = unit
--         unitPrefix[unit .. "targettarget"] = unit
--         unitSuffix[unit] = ""
--         unitSuffix[unit .. "target"] = "-target"
--         unitSuffix[unit .. "targettarget"] = "-target-target"
--         unitPrefix[pet] = unit
--         unitSuffix[pet] = "-pet"
--     end

--     for i = 1, MAX_RAID_MEMBERS do
--         local unit, pet = "raid" .. i, "raidpet" .. i
--         unitPrefix[unit] = unit
--         unitPrefix[unit .. "target"] = unit
--         unitPrefix[unit .. "targettarget"] = unit
--         unitSuffix[unit] = ""
--         unitSuffix[unit .. "target"] = "-target"
--         unitSuffix[unit .. "targettarget"] = "-target-target"
--         unitPrefix[pet] = unit
--         unitSuffix[pet] = "-pet"
--     end

--     function resolveUnitID(unit)
--         if not unit then
--             return nil
--         end

--         local prefix, suffix = unitPrefix[unit], unitSuffix[unit]

--         if not UnitExists(prefix) or not UnitGUID(prefix) or not select(6, GetPlayerInfoByGUID(UnitGUID(prefix))) then
--             return nil, prefix, suffix
--         end

--         return GetUnitName(prefix, true) .. suffix, prefix, suffix
--     end
-- end

-- local groupNone = {"player"}
-- local groupParty = {"player"}
-- local groupRaid = {}

-- for i = 1, MAX_PARTY_MEMBERS do
--     tinsert(groupParty, "party" .. i)
-- end

-- for i = 1, MAX_RAID_MEMBERS do
--     tinsert(groupRaid, "raid" .. i)
-- end

-- local petIDs = {["player"] = "pet"}

-- for i = 1, MAX_PARTY_MEMBERS do
--     petIDs["party" .. i] = "partypet" .. i
-- end

-- for i = 1, MAX_RAID_MEMBERS do
--     petIDs["raid" .. i] = "raidpet" .. i
-- end

-- local frames = {}
-- setmetatable(frames, {__mode = "k"})

-- local hooks_CompactUnitFrame_UpdateAll = {}
-- local hooks_CompactUnitFrame_UpdateVisible = {}
-- local hooks_CompactUnitFrame_SetUnit = {}
-- local hooks_CastingBarFrame_SetUnit = {}

-- local FuturePrototype = {}
-- local FutureMetatable = {
--     __index = FuturePrototype,
--     __metatable = true
-- }

-- function FuturePrototype:Run()
--     if self._future then
--         return self._future:Run()
--     else
--         return self._run(self)
--     end
-- end

-- function FuturePrototype:Continue(future)
--     if not self:IsCancelled() and not self:IsDone() then
--         self:Cancel()
--     end

--     self._event = nil
--     self._future = future
-- end

-- function FuturePrototype:Cancel()
--     if self._future then
--         self._future:Cancel()
--     else
--         self._cancelled = true
--     end
-- end

-- function FuturePrototype:IsCancelled()
--     if self._future then
--         return self._future:IsCancelled()
--     else
--         return self._cancelled
--     end
-- end

-- function FuturePrototype:IsDone()
--     if self._future then
--         return self._future:IsDone()
--     else
--         return self._done
--     end
-- end

-- function FuturePrototype:Get()
--     if self._future then
--         return self._future:Get()
--     else
--         return self._result
--     end
-- end

-- local continueOnGroupRosterLoaded
-- local continueOnNotInCombatLockdown
-- local continueOnGroupRosterLoadedAndNotInCombatLockdown

-- do
--     local futures = {}
--     local futureFrame = CreateFrame("Frame")
--     futureFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
--     futureFrame:RegisterEvent("UNIT_NAME_UPDATE")
--     futureFrame:SetScript("OnEvent",function(self, event)
--         for _, future in ipairs(futures) do
--             if future._event == true or future._event == event then
--                 future:Run()
--             end
--         end

--         for i, future in pairs(futures) do
--             if future._event == nil or future:IsCancelled() or future:IsDone() then
--                 futures[i] = nil
--             end
--         end
--     end)

--     local function isGroupRosterLoaded()
--         local group

--         if GetNumGroupMembers() == 0 then
--             group = groupNone
--         elseif not IsInRaid() then
--             group = groupParty
--         else
--             group = groupRaid
--         end

--         for i = 1, #group do
--             local unit = group[i]

--             if UnitExists(unit) then
--                 local unitGUID = UnitGUID(unit)

--                 if not unitGUID or not select(6, GetPlayerInfoByGUID(unitGUID)) then
--                     return false
--                 end
--             end
--         end

--         return true
--     end

--     local function continueOn(event, condition, timeout, callback)
--         local future = setmetatable({}, FutureMetatable)
--         future._cancelled = false
--         future._done = false
--         future._event = event
--         future._run = function()
--             if future._cancelled or future._done then
--                 return future._result
--             end

--             if condition and not condition() then
--                 if timeout then
--                     C_Timer.After(timeout, future._run)
--                 end

--                 return future._result
--             end

--             future._result = callback(future)
--             future._done = true
--             return future._result
--         end

--         C_Timer.After(0, future._run)
--         tinsert(futures, future)
--         return future
--     end

--     function continueOnGroupRosterLoaded(callback)
--         return continueOn("UNIT_NAME_UPDATE", isGroupRosterLoaded, 1.0, callback)
--     end

--     local notInCombatLockdown = function()
--         return not InCombatLockdown()
--     end

--     function continueOnNotInCombatLockdown(callback)
--         return continueOn("PLAYER_REGEN_ENABLED", notInCombatLockdown, nil, callback)
--     end

--     function continueOnGroupRosterLoadedAndNotInCombatLockdown(callback, callback2)
--         local time = GetTime()
--         local future =continueOnGroupRosterLoaded(
-- 	            function(self)
-- 	                self:Continue(continueOnNotInCombatLockdown(callback))

-- 	                if callback2 and not self:IsDone() and time < GetTime() then
-- 	                    callback2()
-- 	                end
-- 	            end
--             )

--         if callback2 and not future:IsDone() then
--             callback2()
--         end

--         return future
--     end
-- end

-- local function CompactUnitFrame_Hide(frame)
--     frame.background:Hide()

--     frame.healthBar:SetMinMaxValues(0, 0)
--     frame.healthBar:SetValue(0)

--     if frame.powerBar then
--         frame.powerBar:SetMinMaxValues(0, 0)
--         frame.powerBar:SetValue(0)
--         frame.powerBar.background:Hide()
--     end

--     frame.name:Hide()

--     frame.selectionHighlight:Hide()

--     if frame.aggroHighlight then
--         frame.aggroHighlight:Hide()
--     end

--     if frame.LoseAggroAnim then
--         frame.LoseAggroAnim:Stop()
--     end

--     if frame.statusText then
--         frame.statusText:Hide()
--     end

--     if frame.myHealPrediction then
--         frame.myHealPrediction:Hide()
--     end

--     if frame.otherHealPrediction then
--         frame.otherHealPrediction:Hide()
--     end

--     if frame.totalAbsorb then
--         frame.totalAbsorb:Hide()
--     end

--     if frame.totalAbsorbOverlay then
--         frame.totalAbsorbOverlay:Hide()
--     end

--     if frame.overAbsorbGlow then
--         frame.overAbsorbGlow:Hide()
--     end

--     if frame.myHealAbsorb then
--         frame.myHealAbsorb:Hide()
--     end

--     if frame.myHealAbsorbLeftShadow then
--         frame.myHealAbsorbLeftShadow:Hide()
--     end

--     if frame.myHealAbsorbRightShadow then
--         frame.myHealAbsorbRightShadow:Hide()
--     end

--     if frame.overHealAbsorbGlow then
--         frame.overHealAbsorbGlow:Hide()
--     end

--     if frame.roleIcon then
--         frame.roleIcon:Hide()
--     end

--     if frame.roleIcon then
--         frame.roleIcon:Hide()
--     end

--     if frame.readyCheckIcon then
--         frame.readyCheckIcon:Hide()
--     end

--     CompactUnitFrame_HideAllBuffs(frame)
--     CompactUnitFrame_HideAllDebuffs(frame)
--     CompactUnitFrame_HideAllDispelDebuffs(frame)

--     if frame.centerStatusIcon then
--         frame.centerStatusIcon:Hide()
--     end

--     if frame.classificationIndicator then
--         frame.classificationIndicator:Hide()
--     end

--     if frame.LevelFrame then
--         if frame.LevelFrame.levelText then
--             frame.LevelFrame.levelText:Hide()
--         end

--         if frame.LevelFrame.highLevelTexture then
--             frame.LevelFrame.highLevelTexture:Hide()
--         end
--     end

--     if frame.WidgetContainer then
--         frame.WidgetContainer:UnregisterForWidgetSet()
--     end

--     if frame.castBar then
--         frame.castBar:Hide()
--     end
-- end

-- local function CompactUnitFrame_UpdateAllSecure(frame)
--     if not InCombatLockdown() then
--         if CompactUnitFrame_UpdateInVehicle then
--             CompactUnitFrame_UpdateInVehicle(frame)
--         end

--         CompactUnitFrame_UpdateVisible(frame)
--     else
--         if UnitExists(frame.displayedUnit) then
--             if not frame.unitExists then
--                 frame.newUnit = true
--             end

--             frame.unitExists = true

--             frame.background:Show()

--             if frame.powerBar then
--                 frame.powerBar.background:Show()
--             end
--         else
--             if CompactUnitFrame_ClearWidgetSet then
--                 CompactUnitFrame_ClearWidgetSet(frame)
--             end

--             CompactUnitFrame_Hide(frame)

--             frame.unitExists = false
--         end

--         for _, hookfunc in ipairs(hooks_CompactUnitFrame_UpdateVisible) do
--             hookfunc(frame)
--         end
--     end

--     if frame.unitExists then
--         CompactUnitFrame_UpdateMaxHealth(frame)
--         CompactUnitFrame_UpdateHealth(frame)
--         CompactUnitFrame_UpdateHealthColor(frame)
--         CompactUnitFrame_UpdateMaxPower(frame)
--         CompactUnitFrame_UpdatePower(frame)
--         CompactUnitFrame_UpdatePowerColor(frame)
--         CompactUnitFrame_UpdateName(frame)
--         CompactUnitFrame_UpdateSelectionHighlight(frame)

--         if CompactUnitFrame_UpdateAggroHighlight then
--             CompactUnitFrame_UpdateAggroHighlight(frame)
--         end

--         if CompactUnitFrame_UpdateAggroFlash then
--             CompactUnitFrame_UpdateAggroFlash(frame)
--         end

--         CompactUnitFrame_UpdateHealthBorder(frame)
--         CompactUnitFrame_UpdateInRange(frame)
--         CompactUnitFrame_UpdateStatusText(frame)

--         if CompactUnitFrame_UpdateHealPrediction then
--             CompactUnitFrame_UpdateHealPrediction(frame)
--         end

--         CompactUnitFrame_UpdateRoleIcon(frame)
--         CompactUnitFrame_UpdateReadyCheck(frame)
--         CompactUnitFrame_UpdateAuras(frame)
--         CompactUnitFrame_UpdateCenterStatusIcon(frame)
--         CompactUnitFrame_UpdateClassificationIndicator(frame)

--         if CompactUnitFrame_UpdateLevel then
--             CompactUnitFrame_UpdateLevel(frame)
--         end

--         if CompactUnitFrame_UpdateWidgetSet then
--             CompactUnitFrame_UpdateWidgetSet(frame)
--         end
--     end

--     for _, hookfunc in ipairs(hooks_CompactUnitFrame_UpdateAll) do
--         hookfunc(frame)
--     end
-- end

-- if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then
--     if CompactUnitFrame_UpdateInVehicle then
--         hooksecurefunc("CompactUnitFrame_UpdateInVehicle",function(frame)
--             if frames[frame] == nil then
--                 return
--             end

--             local unit = frame:GetAttribute("unit")
--             local unitTarget = resolveUnitID(unit)

--             if unitTarget then
--                 frame:SetAttribute("unit", unitTarget)
--             end
--         end)
--     end
-- end

-- hooksecurefunc("CompactUnitFrame_UpdateVisible",function(frame)
--     if frames[frame] == nil then
--         return
--     end

--     if resolveUnitID(frame.unit) then
--         frame.unitExists = UnitExists(frame.displayedUnit)

--         if frame.unitExists then
--             frame.background:Show()

--             if frame.powerBar then
--                 frame.powerBar.background:Show()
--             end
--         else
--             if UnitExists(frame.unit) then
--                 if CompactUnitFrame_ClearWidgetSet then
--                     CompactUnitFrame_ClearWidgetSet(frame)
--                 end
--             end

--             frame:Show()

--             CompactUnitFrame_Hide(frame)
--         end
--     else
--         frame.background:Show()

--         if frame.powerBar then
--             frame.powerBar.background:Show()
--         end
--     end
-- end)

-- if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
--     hooksecurefunc("CompactUnitFrame_UpdateRoleIcon",function(frame)
--         if frames[frame] == nil then
--             return
--         end

--         if not frame.roleIcon then
--             return
--         end

--         local raidID = UnitInRaid(frame.unit)

--         if not (frame.optionTable.displayRaidRoleIcon and raidID and select(10, GetRaidRosterInfo(raidID))) then
--             local size = frame.roleIcon:GetHeight()
--             frame.roleIcon:Hide()
--             frame.roleIcon:SetSize(1, size)
--         end
--     end)
-- end

-- do
--     local future

--     hooksecurefunc("CompactUnitFrame_SetUnit",function(frame, unit)
--         if frames[frame] == nil then
--             if frame:IsForbidden() or not frame:GetName() or not frame:GetName():find("^Compact") then
--                 return
--             end
--         end

--         assert(not InCombatLockdown())

--         local unitTarget, parentUnit = resolveUnitID(unit)
--         assert(not unit or parentUnit)

--         local updateAll = frames[frame] ~= unitTarget

--         if unitTarget then
--             if frame:GetAttribute("unit") == unit then
--                 if not frame.onUpdateFrame then
--                     frame.onUpdateFrame = CreateFrame("Frame")
--                 end

--                 frame.onUpdateFrame.func = function(updateFrame, elapsed)
--                     if frame.displayedUnit then
--                         CompactUnitFrame_UpdateAllSecure(frame)
--                     end
--                 end

--                 frame.onUpdateFrame.func2 = function(updateFrame, event, unit)
--                     if event == "GROUP_ROSTER_UPDATE" then
--                         CompactUnitFrame_UpdateAllSecure(frame)
--                     elseif event == "PLAYER_ENTERING_WORLD" then
--                         CompactUnitFrame_UpdateAllSecure(frame)
--                     elseif event == "PLAYER_REGEN_ENABLED" then
--                         CompactUnitFrame_UpdateAllSecure(frame)
--                     elseif event == "UNIT_CONNECTION" then
--                         local pet = petIDs[unit]

--                         if unit == frame.unit or unit == frame.displayedUnit or pet == frame.unit or pet == frame.displayedUnit then
--                             CompactUnitFrame_UpdateAllSecure(frame)
--                         end
--                     elseif event == "UNIT_PET" then
--                         local pet = petIDs[unit]

--                         if unit == frame.unit or unit == frame.displayedUnit or pet == frame.unit or pet == frame.displayedUnit then
--                             CompactUnitFrame_UpdateAllSecure(frame)
--                         end
--                     elseif event == "UNIT_NAME_UPDATE" then
--                         local pet = petIDs[unit]

--                         if unit == frame.unit or unit == frame.displayedUnit or pet == frame.unit or pet == frame.displayedUnit then
--                             if frames[frame] ~= resolveUnitID(frame.unit) then
--                                 if future then
--                                     future:Cancel()
--                                 end

--                                 future =
--                                     continueOnGroupRosterLoadedAndNotInCombatLockdown(
--                                     function()
--                                         CompactRaidFrameContainer_UpdateDisplayedUnits(CompactRaidFrameContainer)
--                                         CompactRaidFrameContainer_TryUpdate(CompactRaidFrameContainer)

--                                         future = nil
--                                     end
--                                 )
--                             end
--                         end
--                     elseif event == "UNIT_ENTERED_VEHICLE" or event == "UNIT_EXITED_VEHICLE" then
--                         if unit == frame.unit or unit == frame.displayedUnit or unit == "player" then
--                             CompactUnitFrame_UpdateAllSecure(frame)
--                         end
--                     end
--                 end

--                 if frame.onUpdateFrame.doUpdate then
--                     frame.onUpdateFrame:SetScript("OnUpdate", frame.onUpdateFrame.func)
--                 else
--                     frame.onUpdateFrame:SetScript("OnUpdate", nil)
--                 end

--                 frame.onUpdateFrame:SetScript("OnEvent", frame.onUpdateFrame.func2)

--                 frame.onUpdateFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
--                 frame.onUpdateFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
--                 frame.onUpdateFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
--                 frame.onUpdateFrame:RegisterEvent("UNIT_CONNECTION")
--                 frame.onUpdateFrame:RegisterEvent("UNIT_NAME_UPDATE")
--                 frame.onUpdateFrame:RegisterEvent("UNIT_PET")

--                 frame:UnregisterEvent("GROUP_ROSTER_UPDATE")
--                 frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
--                 frame:UnregisterEvent("PLAYER_REGEN_ENABLED")
--                 frame:UnregisterEvent("UNIT_CONNECTION")
--                 frame:UnregisterEvent("UNIT_PET")

--                 if UnitHasVehicleUI then
--                     frame:UnregisterEvent("UNIT_ENTERED_VEHICLE")
--                     frame:UnregisterEvent("UNIT_EXITED_VEHICLE")

--                     frame.onUpdateFrame:RegisterEvent("UNIT_ENTERED_VEHICLE")
--                     frame.onUpdateFrame:RegisterEvent("UNIT_EXITED_VEHICLE")
--                 end

--                 CompactUnitFrame_RegisterEvents(frame)

--                 updateAll = frames[frame] == nil
--             end

--             frame:SetAttribute("unit", unitTarget)
--         else
--             if unit then
--                 frame.unit = nil
--                 frame.displayedUnit = nil
--                 frame.inVehicle = false
--                 frame.readyCheckStatus = nil
--                 frame.readyCheckDecay = nil
--                 frame.isTanking = nil
--                 frame.hideCastbar = frame.optionTable.hideCastbar
--                 frame.healthBar.healthBackground = nil
--                 frame.hasValidVehicleDisplay = nil

--                 frame:SetAttribute("unit", nil)

--                 CompactUnitFrame_UnregisterEvents(frame)

--                 if frame.castBar then
--                     CastingBarFrame_SetUnit(frame.castBar, nil, nil, nil)
--                 end

--                 updateAll = true
--             end

--             if frame.onUpdateFrame then
--                 frame.onUpdateFrame.doUpdate = nil
--                 frame.onUpdateFrame:UnregisterAllEvents()
--                 frame.onUpdateFrame:SetScript("OnEvent", nil)
--                 frame.onUpdateFrame:SetScript("OnUpdate", nil)
--             end

--             frame.background:Show()

--             if frame.powerBar then
--                 frame.powerBar.background:Show()
--             end

--             if UnitExists(parentUnit) then
--                 if future then
--                     future:Cancel()
--                 end

--                 future =
--                     continueOnGroupRosterLoadedAndNotInCombatLockdown(
--                     function()
--                         CompactRaidFrameContainer_UpdateDisplayedUnits(CompactRaidFrameContainer)
--                         CompactRaidFrameContainer_TryUpdate(CompactRaidFrameContainer)

--                         future = nil
--                     end
--                 )
--             end
--         end

--         frame:SetScript("OnEnter", UnitFrame_OnEnter)

--         frames[frame] = unitTarget

--         if updateAll then
--             CompactUnitFrame_UpdateAllSecure(frame)
--         end
--     end)
-- end

-- hooksecurefunc("CompactUnitFrame_SetUpdateAllEvent",function(frame, updateAllEvent, updateAllFilter)
--     if frames[frame] == nil then
--         if frame:IsForbidden() or not frame:GetName() or not frame:GetName():find("^Compact") then
--             return
--         end
--     end

--     frame.updateAllEvent = nil
--     frame.updateAllFilter = nil

--     if updateAllEvent == "GROUP_ROSTER_UPDATE" then
--         frame:UnregisterEvent(updateAllEvent)
--     end
-- end)

-- hooksecurefunc("CompactUnitFrame_SetUpdateAllOnUpdate",function(frame, doUpdate)
--     if frames[frame] == nil then
--         if frame:IsForbidden() or not frame:GetName() or not frame:GetName():find("^Compact") then
--             return
--         end
--     end

--     if frame.onUpdateFrame then
--         frame.onUpdateFrame.doUpdate = doUpdate
--     end
-- end)

-- local function updateAllFrames()
--     local group

--     if GetNumGroupMembers() == 0 then
--         group = groupNone
--     elseif not IsInRaid() then
--         group = groupParty
--     else
--         group = groupRaid
--     end

--     local unitIDs = {}

--     for i = 1, #group do
--         local unit = group[i]
--         local unitName = resolveUnitID(unit)

--         if unitName then
--             unitIDs[unitName] = unit
--             unitIDs[unitName .. "-target"] = unit .. "target"
--             unitIDs[unitName .. "-target-target"] = unit .. "targettarget"
--             unitIDs[unitName .. "-pet"] = petIDs[unit]
--         end
--     end

--     for frame, unitTarget in pairs(frames) do
--         local unit = unitIDs[unitTarget]
--         local currentUnit = frame.unit

--         if currentUnit ~= unit then
--             local displayedUnit = frame.displayedUnit

--             if not unit or currentUnit == displayedUnit then
--                 displayedUnit = unit
--             end

--             frame.unit = unit
--             frame.displayedUnit = displayedUnit

--             if not unit or not currentUnit then
--                 frame.inVehicle = false
--                 frame.readyCheckStatus = nil
--                 frame.readyCheckDecay = nil
--                 frame.isTanking = nil
--                 frame.hideCastbar = frame.optionTable.hideCastbar
--                 frame.healthBar.healthBackground = nil
--             end

--             if unit then
--                 local displayUnitTarget = frame:GetAttribute("unit")
--                 frame.displayedUnit = unitTarget == displayUnitTarget and unit or unitIDs[displayUnitTarget]
--             end

--             frame.hasValidVehicleDisplay = frame.unit ~= frame.displayedUnit

--             if unit then
--                 CompactUnitFrame_RegisterEvents(frame)
--             else
--                 CompactUnitFrame_UnregisterEvents(frame)
--             end

--             if not unit then
--                 if frame.onUpdateFrame then
--                     frame.onUpdateFrame:SetScript("OnEvent", nil)
--                     frame.onUpdateFrame:SetScript("OnUpdate", nil)
--                 end
--             elseif not currentUnit then
--                 if frame.onUpdateFrame then
--                     if frame.onUpdateFrame.doUpdate then
--                         frame.onUpdateFrame:SetScript("OnUpdate", frame.onUpdateFrame.func)
--                     else
--                         frame.onUpdateFrame:SetScript("OnUpdate", nil)
--                     end

--                     frame.onUpdateFrame:SetScript("OnEvent", frame.onUpdateFrame.func2)
--                 end
--             end

--             if unit and not frame.hideCastbar then
--                 if not currentUnit then
--                     if frame.castBar then
--                         CastingBarFrame_SetUnit(frame.castBar, unit, false, true)
--                     end
--                 else
--                     if frame.castBar then
--                         frame.castBar.unit = unit
--                         frame.castBar:RegisterUnitEvent("UNIT_SPELLCAST_START", unit)
--                         frame.castBar:RegisterUnitEvent("UNIT_SPELLCAST_STOP", unit)
--                         frame.castBar:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", unit)

--                         for _, hookfunc in ipairs(hooks_CastingBarFrame_SetUnit) do
--                             hookfunc(frame, unit, frame.castBar.showTradeSkills, frame.castBar.showShield)
--                         end
--                     end
--                 end
--             else
--                 if frame.castBar then
--                     CastingBarFrame_SetUnit(frame.castBar, nil, nil, nil)
--                 end
--             end

--             if unit then
--                 frame:SetScript("OnEnter", UnitFrame_OnEnter)
--             else
--                 frame:SetScript("OnEnter", nil)
--             end

--             CompactUnitFrame_UpdateAllSecure(frame)

--             for _, hookfunc in ipairs(hooks_CompactUnitFrame_SetUnit) do
--                 hookfunc(frame, unit)
--             end
--         end
--     end
-- end

-- do
--     local function CompactPartyFrame_UpdateUnits(self)
--         local name = self:GetName()

--         do
--             local unitFrame = _G[name .. "Member1"]

--             CompactUnitFrame_SetUnit(unitFrame, nil)
--             CompactUnitFrame_SetUnit(unitFrame, "player")
--         end

--         for i = 1, MEMBERS_PER_RAID_GROUP do
--             if i > 1 then
--                 local unit = "party" .. (i - 1)
--                 local unitFrame = _G[name .. "Member" .. i]

--                 CompactUnitFrame_SetUnit(unitFrame, nil)

--                 if UnitExists(unit) then
--                     CompactUnitFrame_SetUnit(unitFrame, unit)
--                 end
--             end
--         end
--     end

--     local future

--     local function CompactPartyFrame_OnEvent(self, event)
--         if event == "GROUP_ROSTER_UPDATE" then
--             if future then
--                 future:Cancel()
--             end

--             future =
--                 continueOnGroupRosterLoadedAndNotInCombatLockdown(
--                 function()
--                     CompactPartyFrame_UpdateUnits(self)

--                     future = nil
--                 end,
--                 updateAllFrames
--             )
--         end
--     end

--     local _CompactPartyFrame_Generate = CompactPartyFrame_Generate

--     function CompactPartyFrame_Generate()
--         local frame, didCreate = _CompactPartyFrame_Generate()

--         if didCreate then
--             frame:RegisterEvent("GROUP_ROSTER_UPDATE")
--             frame:SetScript("OnEvent", CompactPartyFrame_OnEvent)
--             CompactPartyFrame_UpdateUnits(frame)
--         end

--         return frame, didCreate
--     end
-- end

-- do
--     function CompactRaidGroup_UpdateUnits(frame)
--         local groupIndex = frame:GetID()
--         local frameIndex = 1

--         for i = 1, MAX_RAID_MEMBERS do
--             local unit = "raid" .. i
--             local raidID = UnitInRaid(unit)

--             if raidID then
--                 local name, rank, subgroup = GetRaidRosterInfo(raidID)

--                 if subgroup == groupIndex and frameIndex <= MEMBERS_PER_RAID_GROUP then
--                     local unitFrame = _G[frame:GetName() .. "Member" .. frameIndex]

--                     CompactUnitFrame_SetUnit(unitFrame, nil)

--                     if UnitExists(unit) then
--                         CompactUnitFrame_SetUnit(unitFrame, unit)
--                     end

--                     frameIndex = frameIndex + 1
--                 end
--             end
--         end

--         for i = frameIndex, MEMBERS_PER_RAID_GROUP do
--             local unitFrame = _G[frame:GetName() .. "Member" .. i]
--             CompactUnitFrame_SetUnit(unitFrame, nil)
--         end
--     end

--     local future = {}

--     function CompactRaidGroup_OnEvent(self, event)
--         if event == "GROUP_ROSTER_UPDATE" then
--             local groupIndex = self:GetID()

--             if future[groupIndex] then
--                 future[groupIndex]:Cancel()
--             end

--             future[groupIndex] =
--                 continueOnGroupRosterLoadedAndNotInCombatLockdown(
--                 function()
--                     CompactRaidGroup_UpdateUnits(self)

--                     future[groupIndex] = nil
--                 end,
--                 updateAllFrames
--             )
--         end
--     end
-- end

-- do
--     local eventHandlers = {}

--     function CompactRaidFrameContainer_OnEvent(self, event, ...)
--         local eventHandler = eventHandlers[event]

--         if eventHandler then
--             eventHandler(self, ...)
--         end
--     end

--     CompactRaidFrameContainer:RegisterEvent("PLAYER_ENTERING_WORLD")
--     CompactRaidFrameContainer:RegisterEvent("UNIT_CONNECTION")
--     CompactRaidFrameContainer:SetScript("OnEvent", CompactRaidFrameContainer_OnEvent)

--     local future

--     function eventHandlers.GROUP_ROSTER_UPDATE(self)
--         if future then
--             future:Cancel()
--         end

--         future =
--             continueOnGroupRosterLoadedAndNotInCombatLockdown(
--             function()
--                 CompactRaidFrameContainer_UpdateDisplayedUnits(self)
--                 CompactRaidFrameContainer_TryUpdate(self)

--                 future = nil
--             end,
--             updateAllFrames
--         )
--     end

--     eventHandlers.PLAYER_ENTERING_WORLD = eventHandlers.GROUP_ROSTER_UPDATE

--     function eventHandlers.UNIT_PET(self, unit)
--         if self._displayPets then
--             if strsub(unit, 1, 4) == "raid" or strsub(unit, 1, 5) == "party" or unit == "player" then
--                 eventHandlers.GROUP_ROSTER_UPDATE(self)
--             end
--         end
--     end

--     eventHandlers.UNIT_CONNECTION = eventHandlers.UNIT_PET
-- end

-- do
--     local _CompactRaidFrameContainer_OnSizeChanged = CompactRaidFrameContainer_OnSizeChanged

--     local future

--     function CompactRaidFrameContainer_OnSizeChanged(self)
--         if future then
--             future:Cancel()
--         end

--         future =
--             continueOnGroupRosterLoadedAndNotInCombatLockdown(
--             function()
--                 _CompactRaidFrameContainer_OnSizeChanged(self)

--                 future = nil
--             end
--         )
--     end

--     CompactRaidFrameContainer:SetScript("OnSizeChanged", CompactRaidFrameContainer_OnSizeChanged)
-- end

-- do
--     local _CompactRaidFrameContainer_ReadyToUpdate = CompactRaidFrameContainer_ReadyToUpdate

--     function CompactRaidFrameContainer_ReadyToUpdate(self)
--         return _CompactRaidFrameContainer_ReadyToUpdate(self) and not InCombatLockdown()
--     end
-- end

-- do
--     local _CompactRaidFrameContainer_LayoutFrames = CompactRaidFrameContainer_LayoutFrames

--     function CompactRaidFrameContainer_LayoutFrames(self)
--         self._displayPets = self.displayPets
--         return _CompactRaidFrameContainer_LayoutFrames(self)
--     end
-- end

-- do
--     local _CompactUnitFrameProfiles_ApplyProfile = CompactUnitFrameProfiles_ApplyProfile

--     local future

--     function CompactUnitFrameProfiles_ApplyProfile(profile)
--         if future then
--             future:Cancel()
--         end

--         future =
--             continueOnGroupRosterLoadedAndNotInCombatLockdown(
--             function()
--                 _CompactUnitFrameProfiles_ApplyProfile(profile)

--                 future = nil
--             end
--         )
--     end
-- end

-- hooksecurefunc("hooksecurefunc",function(table, functionName, hookfunc)
--     if type(table) ~= "table" then
--         hookfunc = functionName
--         functionName = table
--         table = _G
--     end

--     if table == _G then
--         if functionName == "CompactUnitFrame_UpdateAll" then
--             tinsert(hooks_CompactUnitFrame_UpdateAll, hookfunc)
--         elseif functionName == "CompactUnitFrame_UpdateVisible" then
--             tinsert(hooks_CompactUnitFrame_UpdateVisible, hookfunc)
--         elseif functionName == "CompactUnitFrame_SetUnit" then
--             tinsert(hooks_CompactUnitFrame_SetUnit, hookfunc)
--         elseif functionName == "CastingBarFrame_SetUnit" then
--             tinsert(hooks_CastingBarFrame_SetUnit, hookfunc)
--         end
--     end
-- end)
------------------------------------------------
-- fuFrame.RaidFrame = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
-- fuFrame.RaidFrame:SetSize(30,30);
-- fuFrame.RaidFrame:SetHitRectInsets(0,-80,0,0);
-- fuFrame.RaidFrame:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-20);
-- --fuFrame.RaidFrame.Text:SetText("修复系统团队框架");
-- fuFrame.RaidFrame.Text:SetText("团队框架");
-- fuFrame.RaidFrame.tooltip = "修复系统团队框架人员变动框架无法正常点击问题。";
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
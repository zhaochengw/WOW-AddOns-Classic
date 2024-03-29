local _, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
--------
local fuFrame = List_R_F_1_7
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local ADD_QuickButton=addonTable.ADD_QuickButton
local ADD_Frame=addonTable.ADD_Frame
--=======================================
local zhuangbeixilieID={
	{1,"Head",true},
	{2,"Neck",false},
	{3,"Shoulder",true},
	{4,"Shirt",false},
	{5,"Chest",true},
	{6,"Waist",true},
	{7,"Legs",true},
	{8,"Feet",true},
	{9,"Wrist",true},
	{10,"Hands",true},
	{11,"Finger0",false},
	{12,"Finger1",false},
	{13,"Trinket0",false},
	{14,"Trinket1",false},
	{15,"Back",false},
	{16,"MainHand",true},
	{17,"SecondaryHand",true},
	{18,"Ranged",true},
	{19,"Tabard",false},
}
--创建快捷按钮
local function ADD_QuickButton_AutoEquip()
	if PIG['QuickButton']['Open'] then
		fuFrame.AutoEquip:Enable()
		if PIG['QuickButton']['AutoEquip'] then
			local GnUI = "AutoEquip_UI"
			if _G[GnUI] then return end
			local FrameOnUpdate = CreateFrame("Frame");
			FrameOnUpdate:Hide()
			local Icon=133122
			local Tooltip = "左击-|cff00FFFF展开切换按钮(左键切换/右键保存/Shift+左键删除)|r\n右击-|cff00FFFF卸下身上有耐久装备|r"
			local AutoEquip=ADD_QuickButton(GnUI,Tooltip,Icon)
			-- AutoEquip.BGtex = AutoEquip:CreateTexture(nil, "BACKGROUND", nil, -1);
			-- AutoEquip.BGtex:SetTexture("interface/buttons/ui-emptyslot-white.blp");
			-- AutoEquip.BGtex:SetPoint("TOPLEFT", -10, 10);
			-- AutoEquip.BGtex:SetPoint("BOTTOMRIGHT", 10, -10);
			-- AutoEquip.iconx = AutoEquip:CreateTexture(nil, "ARTWORK");
			-- AutoEquip.iconx:SetTexture(514608);
			-- AutoEquip.iconx:SetTexCoord(0.04,0.50,0.48,0.60);
			-- AutoEquip.iconx:SetPoint("TOPLEFT", 0, 0);
			-- AutoEquip.iconx:SetPoint("BOTTOMRIGHT", 0, 0);
			--
			local butW = QuickButtonUI.nr:GetHeight()
			local anniushu=10
			local AutoEquipList = ADD_Frame("AutoEquipList_UI",AutoEquip,butW, (butW+6)*anniushu,"BOTTOM",AutoEquip,"TOP",0,0,false,false,false,false,true)
			
			for i=1,anniushu do
				local AutoEquip_but = CreateFrame("Button", "AutoEquip_but"..i, AutoEquipList)
				AutoEquip_but:SetHighlightTexture(130718);
				AutoEquip_but:SetSize(butW, butW)

				AutoEquip_but.BGtex = AutoEquip_but:CreateTexture(nil, "BACKGROUND", nil, -1);
				AutoEquip_but.BGtex:SetTexture("Interface/Buttons/UI-Quickslot");
				AutoEquip_but.BGtex:SetAlpha(0.4);
				AutoEquip_but.BGtex:SetPoint("TOPLEFT", -15, 15);
				AutoEquip_but.BGtex:SetPoint("BOTTOMRIGHT", 15, -15);
		
				AutoEquip_but.Tex = AutoEquip_but:CreateTexture(nil, "BORDER");
				AutoEquip_but.Tex:SetPoint("TOPLEFT", 0, 0);
				AutoEquip_but.Tex:SetPoint("BOTTOMRIGHT", 0, 0);

				AutoEquip_but.name = AutoEquip_but:CreateFontString();
				AutoEquip_but.name:SetPoint("BOTTOM", AutoEquip_but, "BOTTOM", 0, 0);
				AutoEquip_but.name:SetFont(ChatFontNormal:GetFont(), 16,"OUTLINE")

				AutoEquip_but:RegisterForClicks("AnyUp");
				AutoEquip_but.Down = AutoEquip_but:CreateTexture(nil, "OVERLAY");
				AutoEquip_but.Down:SetTexture(130839);
				AutoEquip_but.Down:SetAllPoints(AutoEquip_but)
				AutoEquip_but.Down:Hide();
				AutoEquip_but:SetScript("OnMouseDown", function (self)
					self.Down:Show();
					GameTooltip:ClearLines();
					GameTooltip:Hide() 
				end);
				AutoEquip_but:SetScript("OnMouseUp", function (self)
					self.Down:Hide();
				end);

				AutoEquip_but:SetScript("OnClick", function(self,button)
					if button=="LeftButton" then
						if IsShiftKeyDown() then
							C_EquipmentSet.DeleteEquipmentSet(i-1)
							for i=1,anniushu do
								local fujikj = _G["AutoEquip_but"..i]
								local name, iconFileID, setID, isEquipped, numItems, numEquipped, numInInventory, numLost, numIgnored = C_EquipmentSet.GetEquipmentSetInfo(i-1)
								fujikj.Tex:SetTexture(iconFileID);
								fujikj.name:SetText(name);
							end
						else
							C_EquipmentSet.UseEquipmentSet(i-1)
						end
					else
						--C_EquipmentSet.UnassignEquipmentSetSpec(i-1)
						C_EquipmentSet.SaveEquipmentSet(i-1)
					end
				end)
			end
			--
			AutoEquip:SetScript("OnClick", function(self,button)
				local kaiqiq=GetCVar("equipmentManager")
				if kaiqiq=="0" then PIG_print("请先打开系统的装备管理功能") return end
				if button=="LeftButton" then
					if AutoEquipList:IsShown() then
						AutoEquipList:Hide()
					else
						local WowHeight=GetScreenHeight();
						local offset1 = self:GetBottom();
						AutoEquipList:ClearAllPoints();
						if offset1>(WowHeight*0.5) then
							for i=1,anniushu do
								local fujikj = _G["AutoEquip_but"..i]
								fujikj:ClearAllPoints();
								if i==1 then
									fujikj:SetPoint("TOP",AutoEquipList,"TOP",0,0);
								else
									local fujikj_1 = _G["AutoEquip_but"..(i-1)]
									fujikj:SetPoint("TOP",fujikj_1,"BOTTOM",0,-6);
								end
							end
							AutoEquipList:SetPoint("TOP",self,"BOTTOM",0,-6);
						else
							for i=1,anniushu do
								local fujikj = _G["AutoEquip_but"..i]
								fujikj:ClearAllPoints();
								if i==1 then
									fujikj:SetPoint("BOTTOM",AutoEquipList,"BOTTOM",0,0);
								else
									local fujikj_1 = _G["AutoEquip_but"..(i-1)]
									fujikj:SetPoint("BOTTOM",fujikj_1,"TOP",0,6);
								end
							end
							AutoEquipList:SetPoint("BOTTOM",self,"TOP",0,6);
						end
						for i=1,anniushu do
							local fujikj = _G["AutoEquip_but"..i]
							local name, iconFileID, setID, isEquipped, numItems, numEquipped, numInInventory, numLost, numIgnored = C_EquipmentSet.GetEquipmentSetInfo(i-1)
							fujikj.Tex:SetTexture(iconFileID);
							fujikj.name:SetText(name);
						end
						AutoEquipList:Show()
					end
				else
					if InCombatLockdown() then return end
					FrameOnUpdate.hejilist={}
					for inv = 1, #zhuangbeixilieID do
						if zhuangbeixilieID[inv][3] then
							if GetInventoryItemID("player",zhuangbeixilieID[inv][1]) then
								table.insert(FrameOnUpdate.hejilist,zhuangbeixilieID[inv][1])
							end
						end
					end
					FrameOnUpdate.konggekaishi=0
					FrameOnUpdate.konggelist={}
					if tocversion<100000 then
						for bagID=0,4 do
							local numberOfFreeSlots, bagType = GetContainerNumFreeSlots(bagID)
							if numberOfFreeSlots>0 and bagType==0 then
								for ff=1,GetContainerNumSlots(bagID) do
									if GetContainerItemID(bagID, ff) then
									else
										table.insert(FrameOnUpdate.konggelist,{bagID,ff})
										FrameOnUpdate.konggekaishi=FrameOnUpdate.konggekaishi+1
										if FrameOnUpdate.konggekaishi==#FrameOnUpdate.hejilist then
											break
										end
									end
								end
							end
							if FrameOnUpdate.konggekaishi==#FrameOnUpdate.hejilist then
								break
							end
						end
					else
						for bagID=0,4 do
							local numberOfFreeSlots, bagType = C_Container.GetContainerNumFreeSlots(bagID)
							if numberOfFreeSlots>0 and bagType==0 then
								for ff=1,C_Container.GetContainerNumSlots(bagID) do
									if C_Container.GetContainerItemID(bagID, ff) then
									else
										table.insert(FrameOnUpdate.konggelist,{bagID,ff})
										FrameOnUpdate.konggekaishi=FrameOnUpdate.konggekaishi+1
										if FrameOnUpdate.konggekaishi==#FrameOnUpdate.hejilist then
											break
										end
									end
								end
							end
							if FrameOnUpdate.konggekaishi==#FrameOnUpdate.hejilist then
								break
							end
						end
					end
					if #FrameOnUpdate.hejilist>0 then
						if #FrameOnUpdate.konggelist<#FrameOnUpdate.hejilist then
							print("\124cff00FFFF!Pig：\124cffffFF00背包剩余空间不足，无法全部卸下！\124r");
						end
						for inv = 1, #FrameOnUpdate.konggelist do
							local isLocked2 = IsInventoryItemLocked(FrameOnUpdate.hejilist[inv])
							if not isLocked2 then
								PickupInventoryItem(FrameOnUpdate.hejilist[inv])
								if tocversion<100000 then
									PickupContainerItem(FrameOnUpdate.konggelist[inv][1], FrameOnUpdate.konggelist[inv][2])
								else
									C_Container.PickupContainerItem(FrameOnUpdate.konggelist[inv][1], FrameOnUpdate.konggelist[inv][2])
								end
							end
						end
					end
				end
			end);
		end
	else
		fuFrame.AutoEquip:Disable()
	end
end
addonTable.ADD_QuickButton_AutoEquip = ADD_QuickButton_AutoEquip

fuFrame.AutoEquip=ADD_Checkbutton(nil,fuFrame.anniuF,-60,"TOPLEFT",fuFrame.anniuF,"TOPLEFT",20,-100,"添加<装备管理>到快捷按钮栏","在快捷按钮栏显示装备管理按钮")
fuFrame.AutoEquip:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['QuickButton']['AutoEquip']=true;
		ADD_QuickButton_AutoEquip()
	else
		PIG['QuickButton']['AutoEquip']=false;
		Pig_Options_RLtishi_UI:Show()
	end
end);
-- -----------------------------
fuFrame:HookScript("OnShow", function(self)
	if PIG['QuickButton']['AutoEquip'] then
		self.AutoEquip:SetChecked(true);
	end
end)
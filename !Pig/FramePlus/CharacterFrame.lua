local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_5_UI
local _, _, _, tocversion = GetBuildInfo()
--================================================
if tocversion<20000 then
	zhuangbeishunxuID = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19}
	zhuangbeiCaoID ={"Ammo","Head","Neck","Shoulder","Shirt","Chest","Waist","Legs","Feet","Wrist","Hands","Finger0","Finger1","Trinket0","Trinket1","Back","MainHand","SecondaryHand","Ranged","Tabard"}
elseif tocversion<30000 then
	zhuangbeishunxuID = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19}
	zhuangbeiCaoID ={"Ammo","Head","Neck","Shoulder","Shirt","Chest","Waist","Legs","Feet","Wrist","Hands","Finger0","Finger1","Trinket0","Trinket1","Back","MainHand","SecondaryHand","Ranged","Tabard"}
else
	zhuangbeishunxuID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19}
	zhuangbeiCaoID ={"Head","Neck","Shoulder","Shirt","Chest","Waist","Legs","Feet","Wrist","Hands","Finger0","Finger1","Trinket0","Trinket1","Back","MainHand","SecondaryHand","Tabard"}
end
----
local pingbiweizhi = {0,2,4,11,12,13,14,15,19}--无耐久
local NJ_zhuangbeishunxuID={}
local NJ_zhuangbeiCaoID={}
for inv =1,#zhuangbeishunxuID,1 do
	NJ_zhuangbeishunxuID.cunzai=true
	for i=1,#pingbiweizhi do
		if zhuangbeishunxuID[inv]==pingbiweizhi[i] then
			NJ_zhuangbeishunxuID.cunzai=false
			break
		end
	end
	if NJ_zhuangbeishunxuID.cunzai then
		table.insert(NJ_zhuangbeishunxuID, zhuangbeishunxuID[inv]);
		table.insert(NJ_zhuangbeiCaoID, zhuangbeiCaoID[inv]);
	end
end
-----------------------
fuFrame.juesexinxikz1 = fuFrame:CreateLine()
fuFrame.juesexinxikz1:SetColorTexture(1,1,1,0.4)
fuFrame.juesexinxikz1:SetThickness(1);
fuFrame.juesexinxikz1:SetStartPoint("TOPLEFT",3,-290)
fuFrame.juesexinxikz1:SetEndPoint("TOPRIGHT",-330,-290)
fuFrame.juesexinxikz2 = fuFrame:CreateLine()
fuFrame.juesexinxikz2:SetColorTexture(1,1,1,0.4)
fuFrame.juesexinxikz2:SetThickness(1);
fuFrame.juesexinxikz2:SetStartPoint("TOPLEFT",330,-290)
fuFrame.juesexinxikz2:SetEndPoint("TOPRIGHT",-2,-290)
fuFrame.juesexinxikz3 = fuFrame:CreateFontString();
fuFrame.juesexinxikz3:SetPoint("LEFT", fuFrame.juesexinxikz1, "RIGHT", 0, 0);
fuFrame.juesexinxikz3:SetPoint("RIGHT", fuFrame.juesexinxikz2, "LEFT", 0, 0);
fuFrame.juesexinxikz3:SetFontObject(GameFontNormal);
fuFrame.juesexinxikz3:SetText("角色面板");

--////人物C界面右边显示属性///////////===========
local function shuxingFrame_Open()
	--//////命中说明-物理//////
	if tocversion<30000 then
		if shuxing_HELP1_UI==nil then
			--帮助按钮
			local mingzhongHELP = CreateFrame("Button","mingzhongHELP_UI",PaperDollItemsFrame, "UIPanelInfoButton");  
			mingzhongHELP:SetSize(16,16);
			mingzhongHELP:SetPoint("RIGHT", PaperDollItemsFrame, "RIGHT", -90, 0);
			mingzhongHELP:SetFrameLevel(6)
			mingzhongHELP.texture:SetPoint("BOTTOMRIGHT", mingzhongHELP, "BOTTOMRIGHT", 0, 0);
			mingzhongHELP.Wl = CreateFrame("Frame", nil, mingzhongHELP,"BackdropTemplate");
			mingzhongHELP.Wl:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
			tile = true, tileSize = 0, edgeSize = 16, 
			insets = { left = 3, right = 3, top = 3, bottom = 3 }});
			mingzhongHELP.Wl:SetBackdropBorderColor(0.6, 0.6, 0.6, 1);
			mingzhongHELP.Wl:SetBackdropColor(0, 0, 0, 0.7);
			mingzhongHELP.Wl:SetPoint("TOPLEFT", PaperDollItemsFrame, "TOPRIGHT", -30, -13);
			mingzhongHELP.Wl:SetPoint("BOTTOMRIGHT", PaperDollItemsFrame, "BOTTOMRIGHT", 222, 75);
			mingzhongHELP.Wl:Hide()

			mingzhongHELP.Wl.title1 = mingzhongHELP.Wl:CreateFontString();
			mingzhongHELP.Wl.title1:SetPoint("TOPLEFT", mingzhongHELP.Wl, "TOPLEFT", 6, -6);
			mingzhongHELP.Wl.title1:SetFontObject(GameFontNormal);
			mingzhongHELP.Wl.title1:SetText('关于物理命中')
			mingzhongHELP.Wl.title2 = mingzhongHELP.Wl:CreateFontString();
			mingzhongHELP.Wl.title2:SetPoint("TOPLEFT", mingzhongHELP.Wl.title1, "BOTTOMLEFT", 0, 0);
			mingzhongHELP.Wl.title2:SetFontObject(CombatLogFont);
			mingzhongHELP.Wl.title2:SetWidth(240);
			mingzhongHELP.Wl.title2:SetText(
			'同级:基础命中率95%(5%)\r高1级:基础命中率93.8%(7%)\r高2级:基础命中率92.8%(8%)\r高3级:基础命中率91.4%(9%)\r'..
			'双持惩罚:基础命中率减去19%\r'..
			'|cffFFD700命中等级：|r\r'..
			'|cffFF8C00TBC1%命中≈15.8命中等级。|r\r'..
			'9%命中：9*15.8≈143命中等级\r'..
			'双持职业\n需要28*15.8≈443点命中等级\r'..
			'|cffFFD700职业差异：|r\r'..
			'猎人，武器战以及猫德这些DPS职业都只需要9%的命中，就可以保证技能和平A全部命中\n'..
			'盗贼/狂暴战/增强萨,天赋自带5%/5%/6%的命中，双持的时候需要23%/23%/22%的命中\n'..
			"不过狂暴战/增强萨达到9%命中之后，暴击收益更高，只需堆到9%保证技能命中后尽量堆暴击，盗贼因为天赋回能尽量堆满命中\n"..
			"坦克:达到9%技能全命中后优先考虑生存属性")

			mingzhongHELP.Wl.title3 = mingzhongHELP.Wl:CreateFontString();
			mingzhongHELP.Wl.title3:SetPoint("TOPLEFT", mingzhongHELP.Wl.title2, "BOTTOMLEFT", 0, -6);
			mingzhongHELP.Wl.title3:SetFontObject(CombatLogFont);
			mingzhongHELP.Wl.title3:SetText('骷髅BOSS默认高玩家3级\r命中统计不包含天赋加成\r')

			--//////命中说明-法术//////
			mingzhongHELP.Fs = CreateFrame("Frame", nil,mingzhongHELP,"BackdropTemplate");
			mingzhongHELP.Fs:SetSize(250,424);
			mingzhongHELP.Fs:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
			tile = true, tileSize = 0, edgeSize = 16, 
			insets = { left = 3, right = 3, top = 3, bottom = 3 }});
			mingzhongHELP.Fs:SetBackdropBorderColor(0.6, 0.6, 0.6, 1);
			mingzhongHELP.Fs:SetBackdropColor(0, 0, 0, 0.7);
			mingzhongHELP.Fs:SetPoint("TOPLEFT", mingzhongHELP.Wl, "TOPRIGHT", 0, -0);
			mingzhongHELP.Fs:SetPoint("BOTTOMRIGHT", mingzhongHELP.Wl, "BOTTOMRIGHT", 200, 0);
			mingzhongHELP.Fs:Hide()

			mingzhongHELP.Fs.title1 = mingzhongHELP.Fs:CreateFontString();--
			mingzhongHELP.Fs.title1:SetPoint("TOPLEFT", mingzhongHELP.Fs, "TOPLEFT", 6, -6);
			mingzhongHELP.Fs.title1:SetFontObject(GameFontNormal);
			mingzhongHELP.Fs.title1:SetText('关于法系命中（抵抗）')
			mingzhongHELP.Fs.title10 = mingzhongHELP.Fs:CreateFontString();--
			mingzhongHELP.Fs.title10:SetPoint("TOPLEFT", mingzhongHELP.Fs.title1, "BOTTOMLEFT", 0, 0);
			mingzhongHELP.Fs.title10:SetFontObject(CombatLogFont);
			mingzhongHELP.Fs.title10:SetText(
			'|cffFF8C00注意:法术命中上限是99%|r\r同级:基础命中率96%(3%)\r高1级:基础命中率95%(4%)\r高2级:基础命中率94%(5%)\r'..
			'高3级:基础命中率83%(16%)\r'..
			'TBC法系命中率\r1%≈12.6法系命中等级')

			mingzhongHELP.Fs.title3 = mingzhongHELP.Fs:CreateFontString();--
			mingzhongHELP.Fs.title3:SetPoint("TOPLEFT", mingzhongHELP.Fs.title10, "BOTTOMLEFT", 0, -6);
			mingzhongHELP.Fs.title3:SetFontObject(CombatLogFont);
			mingzhongHELP.Fs.title3:SetText('骷髅BOSS默认高玩家3级\r命中统计不包含天赋加成\r')

			mingzhongHELP:SetScript("OnEnter", function() mingzhongHELP.Wl:Show() mingzhongHELP.Fs:Show() end );
			mingzhongHELP:SetScript("OnLeave", function() mingzhongHELP.Wl:Hide() mingzhongHELP.Fs:Hide() end );
			--修理费用
			PaperDollItemsFrame.xiuli = CreateFrame("Frame",nil,PaperDollItemsFrame);  
			PaperDollItemsFrame.xiuli:SetSize(110,20);
			PaperDollItemsFrame.xiuli:SetPoint("LEFT", PaperDollItemsFrame, "LEFT", 66, 0);
			PaperDollItemsFrame.xiuli:SetFrameLevel(6)
			PaperDollItemsFrame.xiuli.ICON = PaperDollItemsFrame:CreateTexture(nil, "OVERLAY");
			PaperDollItemsFrame.xiuli.ICON:SetTexture("interface/minimap/tracking/repair.blp");
			PaperDollItemsFrame.xiuli.ICON:SetSize(20,20);
			PaperDollItemsFrame.xiuli.ICON:SetPoint("LEFT", PaperDollItemsFrame.xiuli, "LEFT", 0, 0);
			PaperDollItemsFrame.xiuli.G = PaperDollItemsFrame:CreateFontString();
			PaperDollItemsFrame.xiuli.G:SetPoint("LEFT", PaperDollItemsFrame.xiuli.ICON, "RIGHT", 0, 0);
			PaperDollItemsFrame.xiuli.G:SetFont(ChatFontNormal:GetFont(), 13);
			--
			PaperDollItemsFrame:HookScript("OnShow",function (self,event)
				 	local xiulifeiyongheji = 0
				 	local hujialeixing = {
				 		["武器"]={
				 			["匕首"]=0.5,
				 			["拳套"]=0.5,
				 			["枪械"]=0.5,
				 			["单手剑"]=0.5,
				 			["单手斧"]=0.5,
				 			["单手锤"]=0.5,
				 			---
				 			["长柄武器"]=0.5,
				 			["法杖"]=0.5,
				 			["双手剑"]=0.5,
				 			["双手斧"]=0.5,
				 			["双手锤"]=0.5,
				 			--
				 			["弓"]=0.5,
				 			["弩"]=0.5,
				 			["枪械"]=0.5,
				 			["魔杖"]=0.5,
				 		},
				 		["护甲"]={
					 		["布甲"]=0.207,
					 		["皮甲"]=0.307,
					 		["锁甲"]=0.407,
					 		["板甲"]=0.507,
					 		["盾牌"]=0.507,
					 	}
				 	}
					for inv = 1, #NJ_zhuangbeishunxuID do
						local itemID = GetInventoryItemID ("player", NJ_zhuangbeishunxuID[inv])
						if itemID then
							local itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, sellPrice = select(6,GetItemInfo(itemID))
							local current, maximum = GetInventoryItemDurability(NJ_zhuangbeishunxuID[inv]);
							if maximum then
								local sunshibili= (maximum-current)/maximum
								local neishebili= hujialeixing[itemType][itemSubType] or 0.207
								local xiulifei= sunshibili*sellPrice*neishebili
								xiulifeiyongheji=xiulifeiyongheji+xiulifei
							end
						end
					end
					PaperDollItemsFrame.xiuli.G:SetText(GetCoinTextureString(xiulifeiyongheji))
			end)
		end
	end
end
------
fuFrame.Juese = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.Juese:SetSize(30,32);
fuFrame.Juese:SetPoint("TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",20,-20);
fuFrame.Juese.Text:SetText("显示修理费用/命中说明");
fuFrame.Juese.tooltip = "角色面板显示修理费用/命中说明";
fuFrame.Juese:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['CharacterFrame_Juese']="ON";
		shuxingFrame_Open()
	else
		PIG['FramePlus']['CharacterFrame_Juese']="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--=====================================================
----耐久
local function Update_aijiuV()
	for inv = 1, #NJ_zhuangbeishunxuID do
			local current, maximum = GetInventoryItemDurability(NJ_zhuangbeishunxuID[inv]);
			local Frameu=_G["Character"..NJ_zhuangbeiCaoID[inv].."Slot"].naijiuV
			if maximum then
				local naijiubaifenbi=floor(current/maximum*100);
				Frameu:SetText(naijiubaifenbi.."%");
				if naijiubaifenbi>79 then
					Frameu:SetTextColor(0,1,0, 1);
				elseif  naijiubaifenbi>59 then
					Frameu:SetTextColor(1,215/255,0, 1);
				elseif  naijiubaifenbi>39 then
					Frameu:SetTextColor(1,140/255,0, 1);
				elseif  naijiubaifenbi>19 then
					Frameu:SetTextColor(1,69/255,0, 1);
				else
					Frameu:SetTextColor(1,0,0, 1);
				end
			else
				Frameu:SetText();
			end
	end
end
local function ADD_naijiuV()
	for inv = 1, #NJ_zhuangbeiCaoID do
		local Frameu=_G["Character"..NJ_zhuangbeiCaoID[inv].."Slot"]
		if Frameu.naijiuV then return end
		Frameu.naijiuV = Frameu:CreateFontString();
		Frameu.naijiuV:SetPoint("BOTTOMLEFT", Frameu, "BOTTOMLEFT", 0, 0);
		Frameu.naijiuV:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
	end
	Update_aijiuV()
	PaperDollItemsFrame:HookScript("OnShow",function (self,event)
		Update_aijiuV()
	end)
end
-----------------------
fuFrame.naijiuzhi = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.naijiuzhi:SetSize(30,32);
fuFrame.naijiuzhi:SetPoint("TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",300,-20);
fuFrame.naijiuzhi.Text:SetText("显示装备耐久");
fuFrame.naijiuzhi.tooltip = "角色面板显示装备耐久剩余值";
fuFrame.naijiuzhi:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']["CharacterFrame_naijiu"]="ON";
		ADD_naijiuV()
	else
		PIG['FramePlus']["CharacterFrame_naijiu"]="OFF";
		Pig_Options_RLtishi_UI:Show()
	end
end);
--显示装备等级==================================================================================================
--自身装备LV
local function Character_LV()
	for inv = 1, #zhuangbeishunxuID do
		if zhuangbeishunxuID[inv]~=0 and zhuangbeishunxuID[inv]~=4 and zhuangbeishunxuID[inv]~=19 then
			local itemID=GetInventoryItemID("player", zhuangbeishunxuID[inv])
			local Frameu=_G["Character"..zhuangbeiCaoID[inv].."Slot"]
			if itemID then
				local itemName,itemLink,itemQuality,itemLevel = GetItemInfo(itemID);
				Frameu.ZLV:SetText(itemLevel);
				if itemQuality==0 then
					Frameu.ZLV:SetTextColor(157/255,157/255,157/255, 1);
				elseif itemQuality==1 then
					Frameu.ZLV:SetTextColor(1, 1, 1, 1);
				elseif itemQuality==2 then
					Frameu.ZLV:SetTextColor(30/255, 1, 0, 1);
				elseif itemQuality==3 then
					Frameu.ZLV:SetTextColor(0,112/255,221/255, 1);
				elseif itemQuality==4 then
					Frameu.ZLV:SetTextColor(163/255,53/255,238/255, 1);
				elseif itemQuality==5 then
					Frameu.ZLV:SetTextColor(1,128/255,0, 1);
				elseif itemQuality==6 then
					Frameu.ZLV:SetTextColor(230/255,204/255,128/255, 1);
				elseif itemQuality==7 then
					Frameu.ZLV:SetTextColor(0,204/255,1, 1);
				end
			else
				Frameu.ZLV:SetText("");
			end
		end
	end
end
PaperDollItemsFrame:SetScript("OnShow", function()
	if PIG['ShowPlus']['zhuangbeiLV']=="ON" then
		Character_LV();
	end
end)

--观察对象装备LV
local function Inspect_LV()
	for inv = 2, #zhuangbeishunxuID do
		if zhuangbeishunxuID[inv]~=0 and zhuangbeishunxuID[inv]~=4 and zhuangbeishunxuID[inv]~=19 then
			local itemID=GetInventoryItemID("target", zhuangbeishunxuID[inv])
			local Frameu=_G["Inspect"..zhuangbeiCaoID[inv].."Slot"]
			if Frameu then
				if itemID then
					local itemName,itemLink,itemQuality,itemLevel = GetItemInfo(itemID);
					Frameu.ZLV:SetText(itemLevel);
					if itemQuality==0 then
						Frameu.ZLV:SetTextColor(157/255,157/255,157/255, 1);
					elseif itemQuality==1 then
						Frameu.ZLV:SetTextColor(1, 1, 1, 1);
					elseif itemQuality==2 then
						Frameu.ZLV:SetTextColor(30/255, 1, 0, 1);
					elseif itemQuality==3 then
						Frameu.ZLV:SetTextColor(0,112/255,221/255, 1);
					elseif itemQuality==4 then
						Frameu.ZLV:SetTextColor(163/255,53/255,238/255, 1);
					elseif itemQuality==5 then
						Frameu.ZLV:SetTextColor(1,128/255,0, 1);
					elseif itemQuality==6 then
						Frameu.ZLV:SetTextColor(230/255,204/255,128/255, 1);
					elseif itemQuality==7 then
						Frameu.ZLV:SetTextColor(0,204/255,1, 1);
					end
				else
					Frameu.ZLV:SetText();
				end
			end
		end
	end
end

---------------------

local function ADD_LVT()
	--装备栏
	for inv = 1, #zhuangbeiCaoID do
		local Frameu=_G["Character"..zhuangbeiCaoID[inv].."Slot"]
		if Frameu.ZLV then return end
		Frameu.ZLV = Frameu:CreateFontString();
		Frameu.ZLV:SetPoint("TOPRIGHT", Frameu, "TOPRIGHT", 0, 0);
		Frameu.ZLV:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	end
	Character_LV()
end
--观察
local PIG_BagshengyuFFFF = CreateFrame("Frame");

local function ADD_guancha()
	for inv = 2, #zhuangbeiCaoID do
		local Frameu=_G["Inspect"..zhuangbeiCaoID[inv].."Slot"]
		if Frameu.ZLV then return end
		Frameu.ZLV = Frameu:CreateFontString();
		Frameu.ZLV:SetPoint("TOPRIGHT", Frameu, "TOPRIGHT", 0, 0);
		Frameu.ZLV:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	end
	PIG_BagshengyuFFFF:UnregisterEvent("ADDON_LOADED");
	C_Timer.After(0.4,Inspect_LV)
end   

------------
fuFrame.zhuangbeiLV = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.zhuangbeiLV:SetSize(30,32);
fuFrame.zhuangbeiLV:SetHitRectInsets(0,-100,0,0);
fuFrame.zhuangbeiLV:SetPoint("TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",20,-60);
fuFrame.zhuangbeiLV.Text:SetText("显示装等");
fuFrame.zhuangbeiLV.tooltip = "显示装备等级，背包银行物品需要显示装等请在背包内设置！";
fuFrame.zhuangbeiLV:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['ShowPlus']['zhuangbeiLV']="ON";
		ADD_LVT()
		PIG_BagshengyuFFFF:RegisterEvent("UNIT_MODEL_CHANGED");
		PIG_BagshengyuFFFF:RegisterEvent("INSPECT_READY");
		PIG_BagshengyuFFFF:RegisterEvent("ADDON_LOADED")
	else
		PIG['ShowPlus']['zhuangbeiLV']="OFF";
		PIG_BagshengyuFFFF:UnregisterEvent("UNIT_MODEL_CHANGED");
		PIG_BagshengyuFFFF:UnregisterEvent("INSPECT_READY");
		PIG_BagshengyuFFFF:UnregisterEvent("ADDON_LOADED");
		Pig_Options_RLtishi_UI:Show();
	end
end);
--根据品质染色=========================================
local XWidth, XHeight =CharacterHeadSlot:GetWidth(),CharacterHeadSlot:GetHeight()
local function shuaxin_Border()
	for inv = 1, #zhuangbeishunxuID do
		local fakui=_G["Character"..zhuangbeiCaoID[inv].."Slot"]
		local itemID=GetInventoryItemID("player", zhuangbeishunxuID[inv])
	    if itemID then
	    	local quality = GetInventoryItemQuality("player", zhuangbeishunxuID[inv])
	    	if quality and quality>1 then
		            local r, g, b = GetItemQualityColor(quality);
		            fakui.ranse:SetVertexColor(r, g, b);
		            if zhuangbeishunxuID[inv]==0 then
					   	if HasWandEquipped() then
							fakui.ranse:Hide()
						else
							fakui.ranse:Show()
						end
					else
						fakui.ranse:Show()
					end
	   		else
	   			fakui.ranse:Hide()
	    	end	   
	    else
	    	fakui.ranse:Hide()
	    end
	end
end

local function add_ranseUI()
	for inv = 1, #zhuangbeiCaoID do
		local fakui=_G["Character"..zhuangbeiCaoID[inv].."Slot"]
		if fakui.ranse then return end
	    fakui.ranse = fakui:CreateTexture(nil, 'OVERLAY');
	    fakui.ranse:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
	    fakui.ranse:SetBlendMode('ADD');
	    if zhuangbeishunxuID[inv]==0 then
	    	fakui.ranse:SetSize(XWidth*1.4, XHeight*1.4);
	    else
	    	fakui.ranse:SetSize(XWidth*1.8, XHeight*1.8);
	    end
	    fakui.ranse:SetPoint('CENTER', fakui, 'CENTER', 0, 0);
	    fakui.ranse:Hide()
	end
	shuaxin_Border()
	PaperDollItemsFrame:HookScript("OnShow",function (self,event)
		shuaxin_Border()
	end)
end
---
local function shuaxin_guancha()
	for inv = 2, #zhuangbeishunxuID do
		local fakui=_G["Inspect"..zhuangbeiCaoID[inv].."Slot"]
		local itemID=GetInventoryItemID("target", zhuangbeishunxuID[inv])
	    if fakui then
		    if itemID then
		    	local quality = GetInventoryItemQuality("target", zhuangbeishunxuID[inv])
		    	if quality and quality>1 then
		            local r, g, b = GetItemQualityColor(quality);
		            fakui.ranse:SetVertexColor(r, g, b);
		        	fakui.ranse:Show()
		   		else
		   			fakui.ranse:Hide()
		    	end
		    else
		    	fakui.ranse:Hide()
		    end
		end
	end
end
local function ADD_guancha_ranse()
	for inv = 2, #zhuangbeiCaoID do
		local fakui=_G["Inspect"..zhuangbeiCaoID[inv].."Slot"]
		if fakui.ranse then return end
	    fakui.ranse = fakui:CreateTexture(nil, 'OVERLAY');
	    fakui.ranse:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
	    fakui.ranse:SetBlendMode('ADD');
	    fakui.ranse:SetSize(XWidth*1.8, XHeight*1.8);
	    fakui.ranse:SetPoint('CENTER', fakui, 'CENTER', 0, 0);
	    fakui.ranse:Hide()
	end
	PIG_BagshengyuFFFF:UnregisterEvent("ADDON_LOADED");
	C_Timer.After(0.4,shuaxin_guancha)
end 
------------------
fuFrame.pinzhiranse = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.pinzhiranse:SetSize(30,32);
fuFrame.pinzhiranse:SetHitRectInsets(0,-100,0,0);
fuFrame.pinzhiranse:SetPoint("TOPLEFT",fuFrame.juesexinxikz1,"TOPLEFT",300,-60);
fuFrame.pinzhiranse.Text:SetText("根据品质染色");
fuFrame.pinzhiranse.tooltip = "根据品质染色";
fuFrame.pinzhiranse:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIG['FramePlus']['CharacterFrame_ranse']="ON";
		add_ranseUI()
		PIG_BagshengyuFFFF:RegisterEvent("UNIT_MODEL_CHANGED");
		PIG_BagshengyuFFFF:RegisterEvent("INSPECT_READY");
		PIG_BagshengyuFFFF:RegisterEvent("ADDON_LOADED")
	else
		PIG['FramePlus']['CharacterFrame_ranse']="OFF";
		PIG_BagshengyuFFFF:UnregisterEvent("UNIT_MODEL_CHANGED");
		PIG_BagshengyuFFFF:UnregisterEvent("INSPECT_READY");
		PIG_BagshengyuFFFF:UnregisterEvent("ADDON_LOADED");
		Pig_Options_RLtishi_UI:Show();
	end
end);
--------------------
PIG_BagshengyuFFFF:SetScript("OnEvent", function(self,event,arg1)
	if event=="ADDON_LOADED" and arg1=="Blizzard_InspectUI" then
		if PIG['ShowPlus']['zhuangbeiLV']=="ON" then ADD_guancha()  end
		if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then ADD_guancha_ranse() end
	end
	if event=="INSPECT_READY" then
		if PIG['ShowPlus']['zhuangbeiLV']=="ON" then 
			C_Timer.After(0.4,Inspect_LV)
		end
		if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then
			C_Timer.After(0.4,shuaxin_guancha)
		end
	end

	if event=="UNIT_MODEL_CHANGED" then
		if PaperDollItemsFrame:IsShown() then
			if PIG['FramePlus']["CharacterFrame_naijiu"]=="ON" then Update_aijiuV() end
			if PIG['ShowPlus']['zhuangbeiLV']=="ON" then Character_LV() end
			if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then shuaxin_Border() end
		end
	end
end);
--=====================================
addonTable.FramePlus_CharacterFrame = function()
	if PIG['FramePlus']['CharacterFrame_Juese']=="ON" then
		fuFrame.Juese:SetChecked(true);
		shuxingFrame_Open()
	end
	if PIG['FramePlus']["CharacterFrame_naijiu"]=="ON" then
		fuFrame.naijiuzhi:SetChecked(true);
		ADD_naijiuV()
		PIG_BagshengyuFFFF:RegisterEvent("UNIT_MODEL_CHANGED");
	end

	PIG["ShowPlus"] = PIG["ShowPlus"] or addonTable.Default["ShowPlus"]
	PIG['ShowPlus']['zhuangbeiLV']=PIG['ShowPlus']['zhuangbeiLV'] or addonTable.Default['ShowPlus']['zhuangbeiLV']
	if PIG['ShowPlus']['zhuangbeiLV']=="ON" then
		fuFrame.zhuangbeiLV:SetChecked(true);
		ADD_LVT()
		PIG_BagshengyuFFFF:RegisterEvent("UNIT_MODEL_CHANGED");
		PIG_BagshengyuFFFF:RegisterEvent("INSPECT_READY");
		PIG_BagshengyuFFFF:RegisterEvent("ADDON_LOADED")
	end
	if PIG['FramePlus']['CharacterFrame_ranse']=="ON" then
		fuFrame.pinzhiranse:SetChecked(true);
		add_ranseUI()
		PIG_BagshengyuFFFF:RegisterEvent("UNIT_MODEL_CHANGED");
		PIG_BagshengyuFFFF:RegisterEvent("INSPECT_READY");
		PIG_BagshengyuFFFF:RegisterEvent("ADDON_LOADED")
	end
end
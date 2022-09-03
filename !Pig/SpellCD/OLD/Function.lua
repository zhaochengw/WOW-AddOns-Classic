local _, addonTable = ...;

---------------
local function ADD_CheckBut(fujiF,Width,Left,Top,tjID)
	local ckbut = CreateFrame("CheckButton", nil, fujiF, "ChatConfigCheckButtonTemplate");
	ckbut:SetSize(28,28);
	ckbut:SetPoint("TOPLEFT", fujiF, "TOPLEFT", Left,-Top);
	ckbut.Text:SetText("激活条件"..tjID);
	ckbut.tooltip = "激活条件"..tjID.."的中的判断条件";
	ckbut:SetScript("OnClick", function (self)
		local bianjiID = fujiF.bianjiID
		if self:GetChecked() then
			PIG_Per.CombatCycle.SpellList[bianjiID][4][tjID].Open=true
		else
			PIG_Per.CombatCycle.SpellList[bianjiID][4][tjID].Open=false;
		end
		if CombatCycle_UI then 
			local CombatCycle_event=addonTable.CombatCycle_event
			CombatCycle_event() 
		end
	end);
	return ckbut
end
addonTable.ADD_CheckBut=ADD_CheckBut
local function ADD_FontString(fujiF,Width,Height,point,relativeTo,relativePoint,XX,YY,tjID,FontSize,FontText)
	local FontS = fujiF:CreateFontString();
	FontS:SetPoint(point,relativeTo,relativePoint,XX,YY);
	FontS:SetFont(ChatFontNormal:GetFont(), FontSize, "OUTLINE");
	FontS:SetTextColor(0, 1, 0, 1);
	FontS:SetText(FontText);
	return FontS
end
addonTable.ADD_FontString=ADD_FontString
local function ADD_DropDownMenu(fujiF,Width,Height,point,relativeTo,relativePoint,XX,YY,tjID,nrID,list)
	local DDMF = CreateFrame("Frame", nil, fujiF,"BackdropTemplate");
	DDMF:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 12});
	DDMF:SetSize(Width,26);
	DDMF:SetBackdropBorderColor(0, 1, 1, 0.8);
	DDMF:SetPoint(point,relativeTo,relativePoint,XX,YY);
	DDMF.DD = CreateFrame("FRAME", nil, DDMF, "UIDropDownMenuTemplate")
	DDMF.DD:SetPoint("RIGHT", DDMF, "RIGHT", 16,-2.4)
	UIDropDownMenu_SetWidth(DDMF.DD, Width)
	DDMF.DD.Left:Hide();
	DDMF.DD.Middle:Hide();
	DDMF.DD.Right:Hide();
	function DDMF.DD:SetValue(Value1,Value2)
		local bianjiID = fujiF.bianjiID
		UIDropDownMenu_SetText(DDMF.DD, Value2)
		PIG_Per.CombatCycle.SpellList[bianjiID][4][tjID]["tj"][nrID] = Value1;
		CloseDropDownMenus()
	end
	return DDMF
end
addonTable.ADD_DropDownMenu=ADD_DropDownMenu
--Show
local function Showbianji_E(Frame1,Frame2,data1,data2,data3)
	Frame1:SetTextColor(1, 1, 1, 1);
	Frame2:Show(); 
end
--ESC
local function ESCbianji_E(Frame1,Frame2,data1,data2,data3)
	Frame1:ClearFocus();Frame2:Hide();
	Frame1:SetTextColor(200/255, 200/255, 200/255, 0.8);
	local shubv = PIG_Per.CombatCycle.SpellList[data1][4][data2]["tj"][data3] or ""
	Frame1:SetText(shubv);
end
--save
local function baocunbianji_E(Frame1,Frame2,data1,data2,data3,Button)
	local tianjianV = Frame1:GetNumber()
	PIG_Per.CombatCycle.SpellList[data1][4][data2]["tj"][data3]=tianjianV
	Frame1:ClearFocus()
	Frame1:SetTextColor(200/255, 200/255, 200/255, 0.8);
	Frame2:Hide();
	if Button then
		Button:Hide()
		if tianjianV>0 then
			local cunzai = GetSpellTexture(tianjianV)
			if cunzai then
				Button:Show()
				Button:SetNormalTexture(GetSpellTexture(tianjianV))
				Button:SetID(tianjianV)
			end
		end
	end
end
local function ADD_EditBox(fujiF,Width,Height,point,relativeTo,relativePoint,XX,YY,tjID,nrID,maxl,Button)
	local EditB = CreateFrame('EditBox', nil, fujiF, "InputBoxInstructionsTemplate");
	EditB:SetSize(Width,22);
	EditB:SetPoint(point,relativeTo,relativePoint,XX,YY);
	EditB:SetFontObject(ChatFontNormal);
	EditB:SetTextColor(200/255, 200/255, 200/255, 0.8); 
	EditB:SetAutoFocus(false);
	EditB:EnableMouse(true)
	EditB:SetMaxLetters(maxl)
	EditB:SetNumeric(true)
	EditB:SetScript("OnEditFocusGained", function(self)
		Showbianji_E(self,EditB.S)
	end);
	EditB:SetScript("OnEscapePressed", function(self)
		local bianjiID = fujiF.bianjiID
		ESCbianji_E(self,EditB.S,bianjiID,tjID,nrID)
	end);
	EditB:SetScript("OnEnterPressed", function(self)
		local bianjiID = fujiF.bianjiID
		baocunbianji_E(self,EditB.S,bianjiID,tjID,nrID,Button)
	end);
	EditB.S = CreateFrame("Button",nil,EditB, "UIPanelButtonTemplate");  
	EditB.S:SetSize(40,20);
	EditB.S:SetPoint("RIGHT",EditB,"RIGHT",-1,0);
	EditB.S:SetText("确定");
	EditB.S:Hide();
	EditB.S:SetScript("OnClick", function (self)
		local bianjiID = fujiF.bianjiID
		baocunbianji_E(EditB,self,bianjiID,tjID,nrID,Button)
	end);
	fujiF:HookScript("OnShow", function(self)
		local bianjiID = fujiF.bianjiID
		ESCbianji_E(EditB,EditB.S,bianjiID,tjID,nrID)
	end);
	return EditB
end
addonTable.ADD_EditBox=ADD_EditBox
local function ADD_Button(fujiF,Width,Height,point,relativeTo,relativePoint,XX,YY)
	local Button = CreateFrame('Button', nil, fujiF);
	Button:SetSize(Width,Height);
	Button:SetPoint(point,relativeTo,relativePoint,XX,YY);
	Button:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:SetSpellByID(self:GetID());
		GameTooltip:Show();
	end)
	Button:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	return Button
end
addonTable.ADD_Button=ADD_Button

-- function()
-- 	local count1 = 0
-- 	local count2 = 0
-- 	for i = 1, 40 do
-- 	local unit = "nameplate"..i
-- 	if UnitCanAttack("player", unit) and WeakAuras.CheckRange(unit, 8, "<=") then
-- 		count1 = count1 + 1
-- 	end
-- end
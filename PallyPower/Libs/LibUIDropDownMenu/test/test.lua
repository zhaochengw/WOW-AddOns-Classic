

do
	local function onMouseDown(self, buttonName)    
		if (buttonName == "LeftButton") then
			-- Hide tooltip while draging
			--self:StartMoving()
			ToggleDropDownMenu(1, nil, self, self, 0, -5)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		end
	end

	local function onMouseUp(self, buttonName)
		--self:StopMovingOrSizing()
	end

	local function onClick(self)
		ToggleDropDownMenu(1, nil, self.DropDown, self, 0, -5)
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	end
	local function dropDown_Initialize(self, level)
		local function OnSelection(button)
			onSelection(button.value, button.checked)
		end
		if not level then level = 1 end
		local info = UIDropDownMenu_CreateInfo()

		if (level == 1) then
			info.isTitle = true
			info.notCheckable = true
			info.text = "Menu 1"
			UIDropDownMenu_AddButton(info)

			info.isTitle = nil
			info.disabled = nil
			info.notCheckable = nil
			info.isNotRadio = true
			info.keepShownOnClick = true
			info.func = OnSelection

			info.text = "Menu 2"
			info.value = "Menu 2"
			UIDropDownMenu_AddButton(info)

			info.text = "Menu 3"
			info.value = "Menu 3"
			UIDropDownMenu_AddButton(info)
			
			UIDropDownMenu_AddSeparator(1)
			
			info.text = "Menu 4"
			info.value = "Menu 4"
			UIDropDownMenu_AddButton(info)
		elseif (level == 2) then
			if (L_UIDROPDOWNMENU_MENU_VALUE == "Menu 2") then
				info.text = "Menu 2.1"
				info.value = "Menu 2.1"
				UIDropDownMenu_AddButton(info, 2)

				info.text = "Menu 2.2"
				info.value = "Menu 2.2"
				UIDropDownMenu_AddButton(info, 2)

				info.text = "Menu 2.3"
				info.value = "Menu 2.3"
				UIDropDownMenu_AddButton(info, 2)

				info.text = "Menu 2.4"
				info.value = "Menu 2.4"
				UIDropDownMenu_AddButton(info, 2)
			elseif (L_UIDROPDOWNMENU_MENU_VALUE == "Menu 3") then
				info.text = "Menu 3.1"
				info.value = "Menu 3.1"
				UIDropDownMenu_AddButton(info, 2)

				info.text = "Menu 3.2"
				info.value = "Menu 3.2"
				UIDropDownMenu_AddButton(info, 2)

				info.text = "Menu 3.3"
				info.value = "Menu 3.3"
				UIDropDownMenu_AddButton(info, 2)

				info.text = "Menu 3.4"
				info.value = "Menu 3.4"
				UIDropDownMenu_AddButton(info, 2)
			end
		end
	end
	
	local name = "MyTestDropDownMenu"
	local f = CreateFrame("Frame", name.."Frame", UIParent, "UIDropDownMenuTemplate")
	f:SetWidth(300)
	f:SetHeight(28)
	f:ClearAllPoints()
	f:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -300, -100)
	f.Background = f:CreateTexture(name.."Background", "BACKGROUND")
	f.Background:SetVertexColor(1, 1, 1, 1)
	f.Border = CreateFrame("Frame", name.."Border", f, BackdropTemplateMixin and "BackdropTemplate" or nil)
	
	f.Text = f:CreateFontString(name.."Text", "OVERLAY", "NumberFontNormal")
	f.Text:SetPoint("CENTER", 0, 0)
	f.Text:SetText("Test Frame")
	
	--f:RegisterForDrag("LeftButton")
	f:SetClampedToScreen(true)
	f:SetMovable(true)
	f:EnableMouse(true)

	f.displayMode = "MENU"
	f:SetScript("OnLoad", function(self) 
		UIDropDownMenu_Initialize(self, dropDown_Initialize, "MENU")
	end)
	--f:SetScript("OnClick", onClick)
	f:SetScript("OnMouseDown", onMouseDown)
	f:SetScript("OnMouseUp", onMouseUp)
	f:Show()
end
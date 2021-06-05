-- Original taken from AceGUIWidget-DropDown.lua and enhanced by EditBox

local AceGUI = LibStub("AceGUI-3.0")

-- Lua APIs
local min, max, floor = math.min, math.max, math.floor
local select, pairs, ipairs, type = select, pairs, ipairs, type
local tsort = table.sort

-- WoW APIs
local PlaySound = PlaySound
local UIParent, CreateFrame = UIParent, CreateFrame
local _G = _G

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS: CLOSE

local function fixlevels(parent,...)
	local i = 1
	local child = select(i, ...)
	while child do
		child:SetFrameLevel(parent:GetFrameLevel()+1)
		fixlevels(child, child:GetChildren())
		i = i + 1
		child = select(i, ...)
	end
end

do
	local widgetType = "EditDropdown"
	local widgetVersion = 26
	
	--[[ Static data ]]--
	
	--[[ UI event handler ]]--
	
	local function Control_OnEnter(this)
		this.obj:Fire("OnEnter")
	end
	
	local function Control_OnLeave(this)
		this.obj:Fire("OnLeave")
	end

	local function Dropdown_OnHide(this)
		local self = this.obj
		if self.open then
			self.pullout:Close()
		end
	end
	
	-- Colorizes title according to validation
	local function _UpdateTitleColor(self)
		if (self.title) then
			if (self.valid or not self.validating) then
				self.title:SetTextColor(1, 1, 1, 1)
			else
				self.title:SetTextColor(1, 0, 0, 1)
			end
		end
	end
	
	-- Checks whether the current value is in range, and adapts it, if not.
	local function _CheckRange(self)
		if (self.numeric) then
			local txt = self.editBox:GetText()
			if (vendor.isnumber(txt)) then
				local val = tonumber(txt)
				self.valid = true
				if (self.minNumeric and self.minNumeric > val) then
					self.valid = false
				end
				if (self.maxNumeric and self.maxNumeric < val) then
					self.valid = false
				end
			end
			_UpdateTitleColor(self)
		end
	end
	
	local function Dropdown_TogglePullout(this)
		local self = this.obj
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) -- missleading name, but the Blizzard code uses this sound
		if self.open then
			self.open = nil
			self.pullout:Close()
			AceGUI:ClearFocus()
		else
			self.open = true
			self.pullout:SetWidth(self.frame:GetWidth())
			self.pullout:Open("TOPLEFT", self.frame, "BOTTOMLEFT", 0, self.label:IsShown() and -2 or 0)
			AceGUI:SetFocus(self)
		end
	end
	
	local function OnPulloutOpen(this)
		local self = this.userdata.obj
		local value = self.value
		
		if not self.multiselect then
			for i, item in this:IterateItems() do
				item:SetValue(item.userdata.value == value)
			end
		end
		
		self.open = true
	end

	local function OnPulloutClose(this)
		local self = this.userdata.obj
		self.open = nil
		self:Fire("OnClosed")
	end
	
	local function ShowMultiText(self)
		local text
		for i, widget in self.pullout:IterateItems() do
			if widget.type == "Dropdown-Item-Toggle" then
				if widget:GetValue() then
					if text then
						text = text..", "..widget:GetText()
					else
						text = widget:GetText()
					end
				end
			end
		end
		self:SetText(text)
	end
	
	local function OnItemValueChanged(this, event, checked)
		local self = this.userdata.obj
		
		if self.multiselect then
			self:Fire("OnValueChanged", this.userdata.value, checked)
			ShowMultiText(self)
		else
			if checked then
				self:SetValue(this.userdata.value)
				self:Fire("OnValueChanged", this.userdata.value)
			else
				this:SetValue(true)
			end
			if self.open then	
				self.pullout:Close()
			end
		end
	end
	
	-- A new value has been typed.
	local function _OnEditBoxUpdate(self)
		local val = self:GetValue()
		if (val) then
			if (self.numeric) then
				if (vendor.isnumber(val)) then
					_CheckRange(self)
				end
			end
			if (self.valid) then
				self:Fire("OnValueChanged", val)
			end
		end
	end

	-- Set new focus.
	local function _OnEditBoxTabPressed(self)
		self.editBox:ClearFocus()
		if (IsShiftKeyDown()) then
			if (self.prevFocus and self.prevFocus.SetFocus) then
				self.prevFocus:SetFocus()
			end
		elseif (self.nextFocus and self.nextFocus.SetFocus) then
			self.nextFocus:SetFocus()
		end
	end

	-- Select all, if the focus has been gained.
	local function _OnEditFocusGained(self)
		self.editBox:HighlightText()
	end
	
	--[[ Exported methods ]]--
	
	-- exported, AceGUI callback
	local function OnAcquire(self)
		local pullout = AceGUI:Create("Dropdown-Pullout")
		self.pullout = pullout
		pullout.userdata.obj = self
		pullout:SetCallback("OnClose", OnPulloutClose)
		pullout:SetCallback("OnOpen", OnPulloutOpen)
		self.pullout.frame:SetFrameLevel(self.frame:GetFrameLevel() + 1)
		fixlevels(self.pullout.frame, self.pullout.frame:GetChildren())
		
		self:SetHeight(44)
		self:SetWidth(200)
		self:SetLabel()
	end
	
	-- exported, AceGUI callback
	local function OnRelease(self)
		if self.open then
			self.pullout:Close()
		end
		AceGUI:Release(self.pullout)
		self.pullout = nil
		
		self:SetText("")
		self:SetDisabled(false)
		self:SetMultiselect(false)
		
		self.value = nil
		self.list = nil
		self.open = nil
		self.hasClose = nil
		
		self.frame:ClearAllPoints()
		self.frame:Hide()
	end
	
	-- exported
	local function SetDisabled(self, disabled)
		self.disabled = disabled
		if disabled then
			self.editBox:SetTextColor(0.5,0.5,0.5)
			self.button:Disable()
			self.label:SetTextColor(0.5,0.5,0.5)
		else
			self.button:Enable()
			self.label:SetTextColor(1,.82,0)
			self.editBox:SetTextColor(1,1,1)
		end
	end
	
	-- exported
	local function ClearFocus(self)
		if self.open then
			self.pullout:Close()
		end
	end
	
	-- exported
	local function SetText(self, text)
		self.editBox:SetText(text or "")
	end
	
	-- exported
	local function SetLabel(self, text)
		if text and text ~= "" then
			self.label:SetText(text)
			self.label:Show()
			self.dropdown:SetPoint("TOPLEFT",self.frame,"TOPLEFT",-15,-18)
			self:SetHeight(44)
			self.alignoffset = 30
		else
			self.label:SetText("")
			self.label:Hide()
			self.dropdown:SetPoint("TOPLEFT",self.frame,"TOPLEFT",-15,0)
			self:SetHeight(26)
			self.alignoffset = 12
		end
	end
	
	-- exported
	local function SetValue(self, value)
		if self.list then
			self:SetText(self.list[value] or "")
		else
			self:SetText(value or "")
		end
	end
	
	-- exported
	local function GetValue(self)
		local txt = self.editBox:GetText()
		if (self.numeric) then
			return tonumber(txt)
		end
		return txt
	end
	
	-- selects whether the editbox should be numeric
	local function SetNumeric(self, numeric)
		self.numeric = numeric
		self.minNumeric = nil
		self.maxNumeric = nil
		self.editBox:SetNumeric(numeric)
	end

	-- Sets an optional range for numerical values.
	local function SetRange(self, min, max)
		self.minNumeric = min
		self.maxNumeric = max
		self.editBox:SetNumeric(true)
		_CheckRange(self)
	end

	-- Returns whether the currentvalue seems to be valid.
	local function IsValid(self)
		return self.valid
	end

	-- Selects whether the dropdown should validate the values. Needed for the startup
	-- where the value is still empty.
	local function SetValidating(self, validating)
		self.validating = validating
	end

	-- Next EditBox to be focused.
	local function SetNextFocus(self, nextFocus)
		self.nextFocus = nextFocus
	end

	-- Previous EditBox to be focused.
	local function SetPrevFocus(self, prevFocus)
		self.prevFocus = prevFocus
	end

	-- Clears the focus of the edit box.
	local function ClearFocus(self)
		self.editBox:ClearFocus()
	end
	
	-- exported
	local function SetItemValue(self, item, value)
		if not self.multiselect then return end
		for i, widget in self.pullout:IterateItems() do
			if widget.userdata.value == item then
				if widget.SetValue then
					widget:SetValue(value)
				end
			end
		end
		ShowMultiText(self)
	end
	
	-- exported
	local function SetItemDisabled(self, item, disabled)
		for i, widget in self.pullout:IterateItems() do
			if widget.userdata.value == item then
				widget:SetDisabled(disabled)
			end
		end
	end
	
	local function AddListItem(self, value, text, itemType)
		if not itemType then itemType = "Dropdown-Item-Toggle" end
		local exists = AceGUI:GetWidgetVersion(itemType)
		if not exists then error(("The given item type, %q, does not exist within AceGUI-3.0"):format(tostring(itemType)), 2) end

		local item = AceGUI:Create(itemType)
		item:SetText(text)
		item.userdata.obj = self
		item.userdata.value = value
		item:SetCallback("OnValueChanged", OnItemValueChanged)
		self.pullout:AddItem(item)
	end
	
	local function AddCloseButton(self)
		if not self.hasClose then
			local close = AceGUI:Create("Dropdown-Item-Execute")
			close:SetText(CLOSE)
			self.pullout:AddItem(close)
			self.hasClose = true
		end
	end
	
	-- exported
	local sortlist = {}
	local function SetList(self, list, order, itemType)
		self.list = list
		self.pullout:Clear()
		self.hasClose = nil
		if not list then return end
		
		if type(order) ~= "table" then
			for v in pairs(list) do
				sortlist[#sortlist + 1] = v
			end
			tsort(sortlist)
			
			for i, key in ipairs(sortlist) do
				AddListItem(self, key, list[key], itemType)
				sortlist[i] = nil
			end
		else
			for i, key in ipairs(order) do
				AddListItem(self, key, list[key], itemType)
			end
		end
		if self.multiselect then
			ShowMultiText(self)
			AddCloseButton(self)
		end
	end
	
	-- exported
	local function AddItem(self, value, text, itemType)
		if self.list then
			self.list[value] = text
			AddListItem(self, value, text, itemType)
		end
	end
	
	-- exported
	local function SetMultiselect(self, multi)
		self.multiselect = multi
		if multi then
			ShowMultiText(self)
			AddCloseButton(self)
		end
	end
	
	-- exported
	local function GetMultiselect(self)
		return self.multiselect
	end
	
	--[[ Constructor ]]--
	
	local function Constructor()
		local count = AceGUI:GetNextWidgetNum(widgetType)
		local frame = CreateFrame("Frame", nil, UIParent)
		local name = "AceGUI30EditDropDown"..count
		local dropdown = CreateFrame("Frame", name, frame, "UIDropDownMenuTemplate")
		
		local self = {}
		self.type = widgetType
		self.frame = frame
		self.dropdown = dropdown
		self.count = count
		frame.obj = self
		dropdown.obj = self
		
		self.OnRelease   = OnRelease
		self.OnAcquire   = OnAcquire
		
		self.ClearFocus  = ClearFocus

		self.SetText     = SetText
		self.SetValue    = SetValue
		self.GetValue    = GetValue
		self.SetList     = SetList
		self.SetLabel    = SetLabel
		self.SetDisabled = SetDisabled
		self.AddItem     = AddItem
		self.SetMultiselect = SetMultiselect
		self.GetMultiselect = GetMultiselect
		self.SetItemValue = SetItemValue
		self.SetItemDisabled = SetItemDisabled
		
		self.SetNumeric = SetNumeric
		self.SetRange = SetRange
		self.IsValid = IsValid
		self.SetValidating = SetValidating
		self.SetNextFocus = SetNextFocus
		self.SetPrevFocus = SetPrevFocus
		self.ClearFocus = ClearFocus
	
		self.alignoffset = 30
		
		frame:SetScript("OnHide",Dropdown_OnHide)
		dropdown:SetScript("OnHide", nil)

		local left = _G[name .. "Left"]
		local middle = _G[name .. "Middle"]
		local right = _G[name .. "Right"]
		
		left:Hide()
		middle:Hide()
		right:Hide()
		
		local button = _G[name .. "Button"]
		self.button = button
		button.obj = self
		button:SetScript("OnEnter",Control_OnEnter)
		button:SetScript("OnLeave",Control_OnLeave)
		button:SetScript("OnClick",Dropdown_TogglePullout)
		
		local text = _G[dropdown:GetName() .. "Text"]
		text:Hide()
		
		local label = frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
		label:Hide()
		self.label = label

		local editBox = CreateFrame("EditBox", name.."EditBox", frame, "InputBoxTemplate")
		editBox.obj = self
		editBox:SetAutoFocus(false)
		editBox:SetJustifyH("LEFT")
		editBox:SetHeight(12)
		editBox:SetPoint("LEFT", frame, "LEFT", 8, 2)
		editBox:SetPoint("RIGHT", frame, "RIGHT", -8, 2)
		editBox:SetScript("OnTextChanged", function(but) _OnEditBoxUpdate(but.obj) end)
		editBox:SetScript("OnTabPressed", function(but) _OnEditBoxTabPressed(but.obj) end)
		editBox:SetScript("OnEditFocusGained", function(but) _OnEditFocusGained(but.obj) end)
		button:ClearAllPoints()
		button:SetPoint("LEFT", editBox, "RIGHT", -2, 0)
		self.editBox = editBox

		AceGUI:RegisterAsWidget(self)
		return self
	end
	
	AceGUI:RegisterWidgetType(widgetType, Constructor, widgetVersion)
end	

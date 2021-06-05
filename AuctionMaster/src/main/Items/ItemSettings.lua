--[[
	Copyright (C) Udorn (Blackhand)
	
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.	
--]]

--[[
	Manages the settings of specific items or item categories. Available settings are:
    info.stacksize
    info.rememberStacksize
    info.amount
    info.rememberAmount
    info.duration
	info.rememberDuration
	info.autoPricingModel
	info.pricingModel
	info.rememberPricingModel
--]]

vendor.ItemSettings = vendor.Vendor:NewModule("ItemSettings", "AceEvent-3.0")

local AceGUI = LibStub("AceGUI-3.0")
local L = vendor.Locale.GetInstance()
local log = vendor.Debug:new("ItemSettings")

local B = LibStub("LibBabble-Inventory-3.0")
local BL = B:GetLookupTable()
	
local VERSION = 1

local FRAME_WIDTH = 310
local FRAME_HEIGHT = 360
local ICON_SIZE = 70
local DURATIONS = {1, 2, 3}
local DISABLED_ALPHA = 0.4

local GENERAL_ID = 1
local PRICE_MODEL_ID = 2

local MODEL_DROP = 1
local MODIFIER_DROP = 2


local DEFAULT_SETTINGS = {
	index = {
		["default"] = {
        	general = {
        		duration = 3
        	},
        	pricingModel = {
        		pricingModifier = {
        			[tostring(vendor.Seller.PRIZE_MODEL_FIX)] = {
        				modifier = vendor.BuyoutModifier.NONE 
        			},
        			[tostring(vendor.Seller.PRIZE_MODEL_MARKET)] = {
        				modifier = vendor.BuyoutModifier.ADD_PERCENT,
        				percent = 150
        			},
        			[tostring(vendor.Seller.PRIZE_MODEL_CURRENT)] = {
        				modifier = vendor.BuyoutModifier.SUBTRACT_MONEY,
        				copper = 1
        			},
        			[tostring(vendor.Seller.PRIZE_MODEL_UNDERCUT)] = {
        				modifier = vendor.BuyoutModifier.SUBTRACT_MONEY,
        				copper = 1
        			},
        			[tostring(vendor.Seller.PRIZE_MODEL_MULTIPLIER)] = {
        				modifier = vendor.BuyoutModifier.ADD_PERCENT,
        				percent = 150
        			},
        			[tostring(vendor.Seller.PRIZE_MODEL_LOWER)] = {
        				modifier = vendor.BuyoutModifier.SUBTRACT_MONEY,
        				copper = 1
        			},
        		}
        	}
        },
        [BL["Glyph"] or "Glyph"] = {
        	general = {
        		stacksize = 1,
        		amount = 3
        	}
        },
        [BL["Gem"] or "Gem"] = {
        	general = {
        		stacksize = 1,
        		amount = 2,
        		duration = 1
        	}
        }
	}
}

local function _MigrateDb(self)
	self.db.factionrealm.version = VERSION
	self.db.realm.version = VERSION
end

local function _OnUpdate(frame)
	local self = frame.obj
	for i=1,4 do
		if (self.selected and self.selected == i) then
			self.types[i].selectHighlight:Show()
		else
			self.types[i].selectHighlight:Hide()
		end
	end
end

--local function _InitSettings(self)
--	self.settingsFrames[GENERAL_ID].revert:Show()
--	self.settingsFrames[GENERAL_ID].edit:Hide()
--	self.settingsFrames[PRICE_MODEL_ID].revert:Show()
--	self.settingsFrames[PRICE_MODEL_ID].edit:Hide()
--end

local function _OnEnterIcon(but)
	local self = but.obj
	if (self.itemLink) then
		local itemLink = self.itemLink
		-- check if we have a battle pet here
		local name, speciesId, level, breedQuality, maxHealth, power, speed = vendor.Items:GetBattlePetStats(itemLink)
		if (BattlePetTooltip and speciesId) then
			BattlePetToolTip_Show(speciesId, level, breedQuality, maxHealth, power, speed, name)
			BattlePetTooltip:ClearAllPoints()
			BattlePetTooltip:SetPoint("TOPLEFT", self.frame, "TOPRIGHT", 0, 0)
		else
			GameTooltip:SetOwner(but, "ANCHOR_RIGHT")
			GameTooltip:SetHyperlink(itemLink)
		end	
	end
end

local function _SetEditBoxEnabled(editbox, enabled)
	if (enabled) then
		editbox:EnableMouse(true)
		editbox:SetTextColor(1,1,1)
	else
		editbox:EnableMouse(false)
		editbox:ClearFocus()
		editbox:SetTextColor(0.5,0.5,0.5)
	end
end

--local function _OnChecked(frame)
--	local self = frame.obj
--	if (self) then
--		local frame = self.settingsFrames[PRICE_MODEL_ID]
--		if (frame.autoPricingModel:GetChecked()) then
--			frame.nonAutoFrame:SetAlpha(DISABLED_ALPHA)
--			frame.autoFrame:SetAlpha(1)
--			frame.pricingModel:Disable()
--			frame.rememberPricingModel:Disable()
--		else
--			frame.nonAutoFrame:SetAlpha(1)
--			frame.autoFrame:SetAlpha(DISABLED_ALPHA)
--			frame.pricingModel:Enable()
--			frame.rememberPricingModel:Enable()
--		end
--	end
--end

local function _SetEnabled(frame, enabled, defaultMode)
	frame.enabled = enabled
	if (enabled) then
		if (defaultMode) then
			frame.revert:Hide()
		else
			frame.revert:Show()
		end
		frame.edit:Hide()
		frame:SetAlpha(1)
		if (frame.id == GENERAL_ID) then
			frame.rememberStacksize:Enable()
			frame.rememberAmount:Enable()
			frame.rememberDuration:Enable()
			_SetEditBoxEnabled(frame.stacksize, true)
			_SetEditBoxEnabled(frame.amount, true)
			frame.duration:Enable()
		elseif (frame.id == PRICE_MODEL_ID) then
--			frame.autoPricingModel:Enable()
--			_OnChecked(frame.autoPricingModel)
			frame.pricingModel:Enable()
			frame.rememberPricingModel:Enable()
		end
	else
		frame.revert:Hide()
		frame.edit:Show()
		frame:SetAlpha(DISABLED_ALPHA)
		if (frame.id == GENERAL_ID) then
			frame.rememberStacksize:Disable()
			frame.rememberAmount:Disable()
			frame.rememberDuration:Disable()
			_SetEditBoxEnabled(frame.stacksize, false)
			_SetEditBoxEnabled(frame.amount, false)
			frame.duration:Disable()
		elseif (frame.id == PRICE_MODEL_ID) then
--			frame.autoPricingModel:Disable()
			frame.pricingModel:Disable()
			frame.rememberPricingModel:Disable()
		end
	end
end

local function _GetItemInfo(self, key, doCreate)
	local neutral = vendor.AuctionHouse:IsNeutral()
	local index
	if (neutral) then
		index = self.db.realm.index
	else
		index = self.db.factionrealm.index
	end
	local info = index[key]
	if (not info and doCreate) then
		info = {}
		index[key] = info
	end
	log:Debug("_GetItemInfo key [%s] rtn [%s]", key, info)
	return info
end

local function _CopySettings(a, b)
	if (b) then
		for k,v in pairs(b) do
			a[k] = v
		end
	end
	return a
end

local function _RemoveItemInfo(self, key)
	local neutral = vendor.AuctionHouse:IsNeutral()
	local index
	if (neutral) then
		index = self.db.realm.index
	else
		index = self.db.factionrealm.index
	end
	index[key] = nil
end

local function _SetNumber(frame, num)
	 	if (not num or num == 0) then
			frame:SetText("")
		else
			frame:SetNumber(num)
		end 
end

local function _SelectPricingModifier(self, value, select)
	log:Debug("_SelectPricingModifier value [%s]", value)
	local money = self.settingsFrames[PRICE_MODEL_ID].money
	local percent = self.settingsFrames[PRICE_MODEL_ID].percent
	if (select) then
		local frame = self.settingsFrames[PRICE_MODEL_ID]
		frame.pricingModifier:SetValue(value or 0)
	end
	if (value == vendor.BuyoutModifier.SUBTRACT_MONEY) then
		money:Show()
		percent:Hide()
	elseif (value == vendor.BuyoutModifier.SUBTRACT_PERCENT) then
		money:Hide()
		percent:Show()
	elseif (value == vendor.BuyoutModifier.ADD_MONEY) then
		money:Show()
		percent:Hide()
	elseif (value == vendor.BuyoutModifier.ADD_PERCENT) then
		money:Hide()
		percent:Show()
	else
		money:Hide()
		percent:Hide()
	end
end

local function _SelectPricingModel(self, value, info)
	log:Debug("_SelectPricingModel value [%s]", value)
	local frame = self.settingsFrames[PRICE_MODEL_ID]
	MoneyInputFrame_SetCopper(frame.money, 0)
	frame.percent:SetText("")
	if (not info) then
		local key = self.keys[self.selected]
		info = _GetItemInfo(self, key)
	end
	if (info and info.pricingModel and info.pricingModel.pricingModifier) then
		local pmod = info.pricingModel.pricingModifier[tostring(value)]
		if (pmod) then
			log:Debug("_SelectPricingModel found modifier [%s] for model [%s] copper [%s]", pmod.modifier, value, pmod.copper)
			_SelectPricingModifier(self, pmod.modifier or 0, true)
			if (pmod.modifier == vendor.BuyoutModifier.SUBTRACT_MONEY or pmod.modifier == vendor.BuyoutModifier.ADD_MONEY) then
				if (pmod.copper) then
					MoneyInputFrame_SetCopper(frame.money, pmod.copper)
				end
        	elseif (pmod.modifier == vendor.BuyoutModifier.SUBTRACT_PERCENT or pmod.modifier == vendor.BuyoutModifier.ADD_PERCENT) then
        	    if (pmod.percent) then
        	    	frame.percent:SetNumber(pmod.percent)
        	    end
        	end
        else
        	_SelectPricingModifier(self, 0, true)
        end
    else
    	_SelectPricingModifier(self, 0, true)
    end
end

local function _Load(self)
	log:Debug("Load enter")
	for i=1,self.selected do
		local key = self.keys[i]
		local info = _GetItemInfo(self, key)
		if (info) then
			log:Debug("found info for i [%s]", i)
			local frame = self.settingsFrames[GENERAL_ID]
			if (info.general) then
				log:Debug("load stacksize [%s]", info.general.stacksize)
    			_SetNumber(frame.stacksize, info.general.stacksize)
    		 	frame.rememberStacksize:SetChecked(info.general.rememberStacksize)
    		 	_SetNumber(frame.amount, info.general.amount)
    			frame.rememberAmount:SetChecked(info.general.rememberAmount or 0)
    			frame.duration:SetValue(info.general.duration or 3)
    			frame.rememberDuration:SetChecked(info.general.rememberDuration)
    			if (i == self.selected) then
    				_SetEnabled(self.settingsFrames[GENERAL_ID], true, i == 1)
    			end
    		else
    			_SetEnabled(frame, false)
    		end
    		local frame = self.settingsFrames[PRICE_MODEL_ID]
    		if (info.pricingModel) then
--				frame.autoPricingModel:SetChecked(info.autoPricingModel)
				frame.pricingModel:SetValue(info.pricingModel.pricingModel or vendor.Seller.PRIZE_MODEL_UNDERCUT)
				frame.rememberPricingModel:SetChecked(info.pricingModel.rememberPricingModel)
				_SelectPricingModel(self, info.pricingModel.pricingModel or vendor.Seller.PRIZE_MODEL_UNDERCUT, info)
    			if (i == self.selected) then
    				_SetEnabled(self.settingsFrames[PRICE_MODEL_ID], true, i == 1)
    			end
    		else
    			_SetEnabled(frame, false)
    		end
		elseif (i == self.selected) then
			_SetEnabled(self.settingsFrames[GENERAL_ID], false)
			_SetEnabled(self.settingsFrames[PRICE_MODEL_ID], false)
		end
	end
	log:Debug("Load exit")
end

local function _Save(self)
	log:Debug("Save enter")
	local key = self.keys[self.selected]
	log:Debug("key [%s]", key)
	local enabled = 0
	if (self.settingsFrames[GENERAL_ID].enabled or self.settingsFrames[PRICE_MODEL_ID].enabled) then
		local info = _GetItemInfo(self, key, true)
		if (self.settingsFrames[GENERAL_ID].enabled) then
    		log:Debug("general enabled")
    		local frame = self.settingsFrames[GENERAL_ID]
    		info.general = info.general or {}
    		info.general.stacksize = frame.stacksize:GetNumber()
    		log:Debug("Save stacksize [%s]", info.general.stacksize)
    		info.general.rememberStacksize = frame.rememberStacksize:GetChecked()
    		info.general.amount = frame.amount:GetNumber() 
    		info.general.rememberAmount = frame.rememberAmount:GetChecked()
    		info.general.duration = frame.duration:GetValue()
    		info.general.rememberDuration = frame.rememberDuration:GetChecked()
		else
			info.general = nil
		end
		if (self.settingsFrames[PRICE_MODEL_ID].enabled) then
			local frame = self.settingsFrames[PRICE_MODEL_ID]
			info.pricingModel = info.pricingModel or {}
--			info.autoPricingModel = frame.autoPricingModel:GetChecked()
			info.pricingModel.pricingModel = frame.pricingModel:GetValue()
			info.pricingModel.rememberPricingModel = frame.rememberPricingModel:GetChecked()
			if (not info.pricingModel.pricingModifier) then
				info.pricingModel.pricingModifier = {}
			end
			log:Debug("Save pricingModel [%s]", info.pricingModel)
			local pricingModifier = frame.pricingModifier:GetValue()
			log:Debug("Save pricingModel [%s] modifier [%s]", info.pricingModel.pricingModel, pricingModifier)
			local pmod = info.pricingModel.pricingModifier[tostring(info.pricingModel.pricingModel)]
			if (not pmod) then
				pmod = {}
				info.pricingModel.pricingModifier[tostring(info.pricingModel.pricingModel)] = pmod
			end
			pmod.modifier = pricingModifier
			if (pricingModifier == vendor.BuyoutModifier.SUBTRACT_MONEY or pricingModifier == vendor.BuyoutModifier.ADD_MONEY) then
				pmod.copper = MoneyInputFrame_GetCopper(frame.money)
				pmod.percent = nil
        	elseif (pricingModifier == vendor.BuyoutModifier.SUBTRACT_PERCENT or pricingModifier == vendor.BuyoutModifier.ADD_PERCENT) then
				pmod.copper = nil
				pmod.percent = frame.percent:GetNumber()
        	else
				pmod.copper = nil
				pmod.percent = nil
        	end
		else
			info.pricingModel = nil
		end
	else
		_RemoveItemInfo(self, key)
	end
	self:SendMessage("ITEM_SETTINGS_UPDATE")
	log:Debug("Save exit")
end

local function _OnTypeClick(but)
	log:Debug("OnTypeClick enter")
	local self = but.obj
	_Save(self)
	self.selected = but.id
	_Load(self)
	log:Debug("OnTypeClick exit")
end

local function _OnRevert(but)
	local frame = but.frame
	local self = frame.obj
	self.settingsFrames[frame.id].edit:Show()	
	self.settingsFrames[frame.id].revert:Hide()
	_SetEnabled(frame, false)
end

local function _OnEdit(but)
	local frame = but.frame
	local self = frame.obj
	self.settingsFrames[frame.id].edit:Hide()	
	self.settingsFrames[frame.id].revert:Show()
	_SetEnabled(frame, true)
end

local function _OnClose(but)
	local frame = but:GetParent()
	local self = frame.obj
	self:Hide()
end

local function _CreateTypeRow(self, typeFrame, prevType)
	local width = typeFrame:GetWidth() - 10
	local height = 14
	
	local frame = CreateFrame("Button", nil, typeFrame)
	frame.obj = self
	frame:EnableMouse(true)
	frame:SetWidth(width, 5)
	frame:SetHeight(height)
	frame:SetScript("OnClick", _OnTypeClick)

	-- mouseover highlight
	local texture = frame:CreateTexture()
	texture:SetTexture("Interface\\HelpFrame\\HelpFrameButton-Highlight")
	texture:SetWidth(width)
	texture:SetHeight(height)
	texture:SetPoint("TOPLEFT", 0, 0)
	texture:SetTexCoord(0, 1.0, 0, 0.578125)
	frame:SetHighlightTexture(texture, "ADD")
	frame.highlight = texture
	
	-- select texture
	texture = frame:CreateTexture()
	texture:SetTexture("Interface\\Addons\\AuctionMaster\\src\\resources\\Highlight1")
	texture:SetWidth(width)
	texture:SetHeight(height)
	texture:SetPoint("TOPLEFT", 0, 0)
	texture:SetTexCoord(0, 1.0, 0, 0.578125)
	texture:Hide()
	frame.selectHighlight = texture
	
	local f = frame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
	frame.text = f
	f:SetAllPoints(frame)
	f:SetJustifyH("RIGHT")
	if (prevType) then
		frame:SetPoint("TOPLEFT", prevType, "BOTTOMLEFT", 0, -2)
		frame.id = prevType.id + 1
	else
		frame:SetPoint("TOPLEFT", typeFrame, "TOPLEFT", 5, -5)
		frame.id = 1
	end
	return frame
end

local function _CreateSettingsGroup(self, id, title, parent, width, height)
	local frame =  vendor.backdropFrame(CreateFrame("Frame", nil, parent))
	frame.obj = self
	frame.id = id
	frame:SetWidth(width)
	frame:SetHeight(height)
	frame:SetBackdrop({
  		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 16,
  		insets = {left = 2, right = 2, top = 2, bottom = 2}
	})
	frame:SetBackdropBorderColor(1, 0.675, 0.125)
	local f = parent:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
	f:SetText(title)
	f:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, 14)
	-- revert button
	local revert = vendor.GuiTools.CreateButton(parent, "UIPanelButtonTemplate", 100, 16, L["Revert"], nil)
	revert.frame = frame
	revert:SetPoint("LEFT", f, "RIGHT", 10, 0)
	revert:SetScript("OnClick", _OnRevert)
	-- edit button
	local edit = vendor.GuiTools.CreateButton(parent, "UIPanelButtonTemplate", 100, 16, L["Edit"], nil)
	edit.frame = frame
	edit:SetPoint("LEFT", revert)
	edit:SetScript("OnClick", _OnEdit)
	
	-- remember objs
	frame.revert = revert
	frame.edit = edit
	return frame
end

local function _OnPercentUpdate(but)
	_Save(but.obj)
end

local function _OnMoneyUpdate(self)
	log:Debug("_OnMoneyUpdate")
	_Save(self)
end

local function _CreatePricingModelFrame(self, parent)
	local frame = _CreateSettingsGroup(self, PRICE_MODEL_ID, L["Price calculation"], parent, FRAME_WIDTH - 10, 100)
	-- auto pricing model
--	local autoPricingModel = vendor.GuiTools.CreateCheckButton(nil, frame, "UICheckButtonTemplate", 24, 24, false, L["Activates the automatic selection mode for the appropriate pricing model."])
--	autoPricingModel.obj = self
--	autoPricingModel:SetPoint("TOPLEFT", 5, -13)
--	autoPricingModel:SetScript("OnClick", _OnChecked)
--	local autoPricingModelF = frame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
--	autoPricingModelF:SetText(L["Automatic"])
--	autoPricingModelF:SetPoint("LEFT", autoPricingModel, "RIGHT", 0, 0)
	-- dummy frame for checked auto
	local autoFrame = CreateFrame("Frame", nil, frame)
	autoFrame:SetWidth(FRAME_WIDTH)
	autoFrame:SetHeight(100)
--	-- max undercut
--	local maxUndercut = vendor.GuiTools.CreateCheckButton(nil, autoFrame, "UICheckButtonTemplate", 24, 24, false, nil)
--	maxUndercut:SetPoint("LEFT", autoPricingModelF, "RIGHT", 0, 0)
--	local maxUndercutF = autoFrame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
--	maxUndercutF:SetText(L["Max undercut"])
--	maxUndercutF:SetPoint("LEFT", maxUndercut, "RIGHT", 0, 0)
	-- dummy frame for unchecked auto
	local nonAutoFrame = CreateFrame("Frame", nil, frame)
	nonAutoFrame:SetWidth(FRAME_WIDTH)
	nonAutoFrame:SetHeight(100)
	nonAutoFrame:SetPoint("TOPLEFT", 0, -13)
	
	-- pricing model
	local prizeModels = {}
	prizeModels[vendor.Seller.PRIZE_MODEL_FIX] = L["Fixed price"]
	prizeModels[vendor.Seller.PRIZE_MODEL_CURRENT] = L["Current price"]
	prizeModels[vendor.Seller.PRIZE_MODEL_UNDERCUT] = L["Undercut"]
	prizeModels[vendor.Seller.PRIZE_MODEL_LOWER] = L["Lower market threshold"]
	prizeModels[vendor.Seller.PRIZE_MODEL_MULTIPLIER] = L["Selling price"]
	prizeModels[vendor.Seller.PRIZE_MODEL_MARKET] = L["Market price"]
	
--	local pricingModel = vendor.DropDownButton:new(nil, nonAutoFrame, 85, L["Price calculation"], L["Selects the mode for calculating the sell prices.\nThe default mode Fixed price just select the last sell price."]);
--	pricingModel:SetPoint("TOPLEFT", -10, -8)
--	pricingModel:SetId(MODEL_DROP)
--	pricingModel:SetItems(prizeModels, vendor.Seller.PRIZE_MODEL_FIX)
--	pricingModel:SetListener(self)
	local pricingModel = vendor.GuiTools.CreateDropDown(nonAutoFrame, 100, L["Price calculation"], L["Selects the mode for calculating the sell prices.\nThe default mode Fixed price just select the last sell price."])
	pricingModel.obj = self
	pricingModel:SetPoint("TOPLEFT", 6, -8)
	pricingModel:SetList(prizeModels)
	pricingModel:SetValue(vendor.Seller.PRIZE_MODEL_FIX)
	pricingModel:SetCallback("OnValueChanged", function(widget, event, value)
		_SelectPricingModel(widget.obj, value)
	end)
	
	-- remember pricing model
	local rememberPricingModel = vendor.GuiTools.CreateCheckButton(nil, nonAutoFrame, "UICheckButtonTemplate", 24, 24, false, L["Automatically selects the price model used the last time for a given item."])
	rememberPricingModel:SetPoint("LEFT", pricingModel.frame, "RIGHT", 10, 0)
	local rememberPricingModelF = nonAutoFrame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
	rememberPricingModelF:SetText(L["Remember price model"])
	rememberPricingModelF:SetPoint("LEFT", rememberPricingModel, "RIGHT", 0, 0)
	
	-- pricing modifier
    local pricingModifiers = {}
    pricingModifiers[vendor.BuyoutModifier.NONE] = L["None"]
	pricingModifiers[vendor.BuyoutModifier.SUBTRACT_MONEY] = L["Sub. money"]
	pricingModifiers[vendor.BuyoutModifier.SUBTRACT_PERCENT] = L["Sub. percent"]
	pricingModifiers[vendor.BuyoutModifier.ADD_MONEY] = L["Add money"]
	pricingModifiers[vendor.BuyoutModifier.ADD_PERCENT] = L["Add percent"]
	
	local pricingModifier = vendor.GuiTools.CreateDropDown(nonAutoFrame, 100, L["Pricing modifier"], L["Specifies a modification to be done on the calculated prices, before starting an auctions."])
	pricingModifier.obj = self
	pricingModifier:SetPoint("TOPLEFT", pricingModel.frame, "BOTTOMLEFT", 0, -20)
	pricingModifier:SetList(pricingModifiers)
	pricingModifier:SetValue(vendor.BuyoutModifier.NONE)
	pricingModifier:SetCallback("OnValueChanged", function(widget, event, value)
		_SelectPricingModifier(widget.obj, value)
	end)
--	local pricingModifier = vendor.DropDownButton:new(nil, nonAutoFrame, 100, L["Pricing modifier"], L["Specifies a modification to be done on the calculated prices, before starting an auctions."]);
--	pricingModifier:SetPoint("TOPLEFT", pricingModel.button, "BOTTOMLEFT", 2, -13)
--	pricingModifier:SetId(MODIFIER_DROP)
--	pricingModifier:SetItems(pricingModifiers, vendor.BuyoutModifier.NONE)
--	pricingModifier:SetListener(self)
	
	-- money modifier
	local money = CreateFrame("Frame", "ItemSettingsMoney", nonAutoFrame, "MoneyInputFrameTemplate")
	money.obj = self
	money:SetPoint("LEFT", pricingModifier.frame, "RIGHT", 10, 4)
	MoneyInputFrame_SetOnValueChangedFunc(money, function() _OnMoneyUpdate(self) end)
	ItemSettingsMoneyGold:SetMaxLetters(2)
	ItemSettingsMoneyGold:SetWidth(20)
	money:Hide()
	
	-- percent modifier
	local percent = vendor.GuiTools.CreateWidget("EditBox", nil, nonAutoFrame, "InputBoxTemplate", 30, 16, L["Percentage to be multiplied with the buyout price."])
	percent:SetPoint("LEFT", pricingModifier.frame, "RIGHT", 10, 2)
	percent.obj = self
	percent:SetNumeric(true)
	percent:SetAutoFocus(false)
	percent:SetMaxLetters(3)
	percent:SetScript("OnTextChanged", _OnPercentUpdate)
	local percentFont = percent:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
	percentFont:SetText("%")
	percentFont:SetPoint("LEFT", percent, "RIGHT", 0, 0)
	
	-- remember objs
--	frame.autoPricingModel = autoPricingModel
	frame.autoFrame = autoFrame
	frame.nonAutoFrame = nonAutoFrame
--	frame.maxUndercut = maxUndercut
	frame.pricingModel = pricingModel
	frame.rememberPricingModel = rememberPricingModel
	frame.pricingModifier = pricingModifier
	frame.money = money
	frame.percent = percent
	return frame
end

local function _CreateGeneralFrame(self, parent)
	local frame = _CreateSettingsGroup(self, GENERAL_ID, L["General"], parent, FRAME_WIDTH - 10, 110)
	-- stacksize
	local stacksizeLabel = frame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
	stacksizeLabel:SetText(L["Stacksize"])
	stacksizeLabel:SetPoint("TOPLEFT", 10, -12)
	local stacksize = vendor.GuiTools.CreateWidget("Editbox", nil, frame, "InputBoxTemplate", 50, 12, nil)
	stacksize:SetAutoFocus(false)
	stacksize:SetNumeric(true)
	stacksize:SetPoint("LEFT", stacksizeLabel, "RIGHT", 10, 0)
	
	-- remember stacksize
	local rememberStacksize = vendor.GuiTools.CreateCheckButton(nil, frame, "UICheckButtonTemplate", 24, 24, false, nil)
	rememberStacksize:SetPoint("LEFT", stacksize, "RIGHT", 10, 0)
	local f = frame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
	f:SetText(L["Remember stacksize"])
	f:SetPoint("LEFT", rememberStacksize, "RIGHT", 0, 0)
	
	-- amount
	local amountLabel = frame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
	amountLabel:SetText(L["Amount"])
	amountLabel:SetPoint("TOPLEFT", stacksizeLabel, "BOTTOMLEFT", 0, -18)
	local amount = vendor.GuiTools.CreateWidget("Editbox", nil, frame, "InputBoxTemplate", 50, 12, nil)
	amount:SetAutoFocus(false)
	amount:SetNumeric(true)
	amount:SetPoint("LEFT", amountLabel, "RIGHT", 10, 0)
	
	-- remember stacksize
	local rememberAmount = vendor.GuiTools.CreateCheckButton(nil, frame, "UICheckButtonTemplate", 24, 24, false, nil)
	rememberAmount:SetPoint("LEFT", amount, "RIGHT", 5, 0)
	f = frame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
	f:SetText(L["Remember amount"])
	f:SetPoint("LEFT", rememberAmount, "RIGHT", 0, 0)
	
	-- duration
    local durations = {}
	durations[1] = "12 "..GetText("HOURS", nil, 12)
	durations[2] = "24 "..GetText("HOURS", nil, 24)
	durations[3] = "48 "..GetText("HOURS", nil, 48)
--	local duration = vendor.DropDownButton:new(nil, frame, 85, L["Auction Duration"], nil)
--	duration:SetPoint("LEFT", amountLabel, "RIGHT", -60, -42)
--	duration:SetListener(self)
--	duration:SetItems(durations, 3)
	local duration = vendor.GuiTools.CreateDropDown(frame, 100, L["Auction Duration"])
	duration.obj = self
	duration:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, -74)
	duration:SetList(durations)
	duration:SetValue(3)
	
	-- remember duration
	local rememberDuration = vendor.GuiTools.CreateCheckButton(nil, frame, "UICheckButtonTemplate", 24, 24, false, nil)
	rememberDuration:SetPoint("LEFT", duration.frame, "RIGHT", 10, 3)
	f = frame:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
	f:SetText(L["Remember duration"])
	f:SetPoint("LEFT", rememberDuration, "RIGHT", 0, 0)
	-- remember objs
	frame.stacksize = stacksize
	frame.rememberStacksize = rememberStacksize
	frame.amount = amount
	frame.rememberAmount = rememberAmount
	frame.duration = duration
	frame.rememberDuration = rememberDuration
	return frame
end

local function _CreateFrame(self)
	-- base frame
	local frame = CreateFrame("Frame", nil, UIParent, "ItemSettingsFrameTemplate")
	frame:Hide()
	frame.obj = self
	frame:SetWidth(FRAME_WIDTH)
	frame:SetHeight(FRAME_HEIGHT)
	frame:SetPoint("CENTER")
	frame:SetFrameStrata("DIALOG")
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetToplevel(true)
	frame:SetClampedToScreen(true)
	frame:SetScript("OnMouseDown", function(this) this:StartMoving() end)
	frame:SetScript("OnMouseUp", function(this) this:StopMovingOrSizing() end)
	frame:SetScript("OnUpdate", _OnUpdate)
	
	-- frame title
	local text = frame:CreateFontString(nil, "OVERLAY")
	text:SetPoint("TOP", frame, "TOP", 0, -10)
	text:SetFontObject("GameFontHighlightLarge")
	text:SetText(L["Item Settings"])
	
	-- close but
	local closeBut = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	closeBut:SetPoint("TOPRIGHT", 3, -3)
	closeBut:SetScript("OnClick", _OnClose)

	-- item icon
	local icon = CreateFrame("Button", nil, frame)
	icon.obj = self
	icon:SetWidth(ICON_SIZE)
	icon:SetHeight(ICON_SIZE)
	icon:SetPoint("TOPLEFT", 5, -30)
	icon:SetScript("OnEnter", _OnEnterIcon)
	icon:SetScript("OnLeave", function()
		if (BattlePetTooltip) then
			BattlePetTooltip:Hide()
		end
		GameTooltip:Hide()
	end)
	icon:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")

	-- type frame
	local typeFrame = CreateFrame("Frame", nil, frame, "ItemSettingsTypesTemplate")
	typeFrame:SetWidth(FRAME_WIDTH - 10 - ICON_SIZE)
	typeFrame:SetHeight(73)
	typeFrame:SetPoint("TOPLEFT", 5 + ICON_SIZE, -30)
	local types = {}
	local typeRow = _CreateTypeRow(self, typeFrame)
	table.insert(types, typeRow)
	typeRow = _CreateTypeRow(self, typeFrame, typeRow)
	table.insert(types, typeRow)
	typeRow = _CreateTypeRow(self, typeFrame, typeRow)
	table.insert(types, typeRow)
	typeRow = _CreateTypeRow(self, typeFrame, typeRow)
	table.insert(types, typeRow)
	
	-- settings groups
	local generalFrame = _CreateGeneralFrame(self, frame)
	generalFrame:SetPoint("TOPLEFT", 5, -120)
	local priceModelFrame = _CreatePricingModelFrame(self, frame)
	priceModelFrame:SetPoint("TOPLEFT", generalFrame, "BOTTOMLEFT", 0, -20)
		
	-- remember objects
	self.frame = frame
	self.types = types
	self.icon = icon
	self.settingsFrames = {
		[GENERAL_ID] = generalFrame,
		[PRICE_MODEL_ID] = priceModelFrame
	}
end

-- returns itemName, itemType, itemSubType, itemStackCount, itemTexture
local function _GetItemStats(itemLink)
	local name, speciesId, level, breedQuality, maxHealth, power, speed = vendor.Items:GetBattlePetStats(itemLink)
	local _
	local itemName, itemType, itemSubType, itemStackCount, itemTexture 
	if (name) then
		-- extra handling for battle pets
		itemName = name
		local name, icon, petType = C_PetJournal.GetPetInfoBySpeciesID(speciesId)
		itemTexture = icon
		itemType = select(11, vendor.Items:GetAuctionItemClasses())
		itemSubType = _G["BATTLE_PET_NAME_"..petType] 
	else
		itemName, _, _, _, _, itemType, itemSubType, itemStackCount, _, itemTexture = GetItemInfo(itemLink)
	end
	return itemName, itemType, itemSubType, itemStackCount, itemTexture
end

local function _SelectItem(self, itemLink)
	local handled
	if (itemLink) then
		local itemName, itemType, itemSubType, itemStackCount, itemTexture = _GetItemStats(itemLink)
		if (itemName) then
    		self.types[1].text:SetText(L["Default"])
    		self.types[2].text:SetText(itemType)
    		self.types[3].text:SetText(itemSubType)
    		self.types[4].text:SetText(itemName)
    		self.itemLink = itemLink
    		self.icon:SetNormalTexture(itemTexture)
    		-- select the default entry, many people have problems to understand that
    		-- they are changing a special item
    		self.selected = 1
    		-- self.selected = 4
    		self.keys[1] = "default"
    		self.keys[2] = itemType
    		self.keys[3] = itemType.."-"..itemSubType 
    		self.keys[4] = vendor.Items:GetItemLinkKey(itemLink)
    		handled = true
    	end
    end
	if (not handled) then
		self.types[1].text:SetText(L["Default"])
		self.types[2].text:SetText("")
		self.types[3].text:SetText("")
		self.types[4].text:SetText("")
		self.itemLink = nil
		self.icon:SetNormalTexture(nil)
		self.selected = 1
		self.keys[1] = "default"
		self.keys[2] = "empty"
		self.keys[3] = "empty" 
		self.keys[4] = "empty"
	end
	_Load(self)
end

--[[
	Initializes the module.
--]]
function vendor.ItemSettings:OnInitialize()
	self.db = vendor.Vendor.db:RegisterNamespace("ItemSettings", {
		factionrealm = DEFAULT_SETTINGS,
		realm = DEFAULT_SETTINGS
	})
	_MigrateDb(self)
	self.keys = {}
	_CreateFrame(self)
	--_SelectItem(self, vendor.Items:GetItemLink(4306))
end

function vendor.ItemSettings:OnEnable()
	self:RegisterEvent("AUCTION_HOUSE_CLOSED")
end

function vendor.ItemSettings:SelectItem(itemLink)
	_SelectItem(self, itemLink)
end

function vendor.ItemSettings:Show(...)
	self.frame:ClearAllPoints()
	if (select('#', ...) > 0) then
		self.frame:SetPoint(...)
	else
		self.frame:SetPoint("CENTER")
	end
	self.frame:Show()
end

function vendor.ItemSettings:Toggle(...)
	if (self.frame:IsVisible()) then
		self:Hide()
	else
		self:Show(...)
	end
end

function vendor.ItemSettings:Hide()
	if (self.frame:IsVisible()) then
    	_Save(self)
    	self.frame:Hide()
    	self:SendMessage("ITEM_SETTINGS_UPDATED")
    end
end

function vendor.ItemSettings:GetItemSettings(itemLink, itemSettings)
	local rtn = wipe(itemSettings or {})
	local itemName, itemType, itemSubType, itemStackCount, itemTexture = _GetItemStats(itemLink)
	if (itemName) then
		rtn = _CopySettings(rtn, _GetItemInfo(self, "default"))
		rtn = _CopySettings(rtn, _GetItemInfo(self, itemType))
		rtn = _CopySettings(rtn, _GetItemInfo(self, itemType.."-"..itemSubType))
		rtn = _CopySettings(rtn, _GetItemInfo(self, vendor.Items:GetItemLinkKey(itemLink)))
	end
	if (not itemSettings.general) then
		itemSettings.general = {}
	end
	if (not itemSettings.pricingModel) then
		itemSettings.pricingModel = {}
	end
	return rtn
end

function vendor.ItemSettings:AUCTION_HOUSE_CLOSED()
	self:Hide()
end

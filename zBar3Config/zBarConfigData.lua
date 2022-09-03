
--[[ Datas ]]
zBarConfig.labels = {
	-- font, color-red, color-green, color-blue, pos, offset-x, offset-y
	["Title"] = {"GameFontNormalLarge",0.12,0.66,1,"TOP",0,-10},
	["SelectBar"] = {"GameFontNormalLarge",1.0,0.7,0.1,"TOPLEFT",10,-30},
	["Attribute"] = {"GameFontNormalLarge",1.0,0.7,0.1,"TOPLEFT",10,-135},
	["Layout"] = {"GameFontNormalLarge",1.0,0.7,0.1,"TOPLEFT",120,-135},
	["InCombat"] = {"GameFontNormalLarge",1.0,0.7,0.1,"TOPLEFT",10,-243},
	["Commons"] = {"GameFontNormalLarge",1.0,0.7,0.1,"TOPLEFT",10,-280},
}
zBarConfig.bars = { --[[ bar name and order ]]
	"zMultiBL", "zMultiBR", "zMultiR2", "zMultiR1",
	"zMainBar", "zPetBar", "zStanceBar", "zBagBar",
	"zMicroBar", "zXPBar", "zCastBar", "zPossessBar",
	"zExBar1", "zShadow1", "zExBar2", "zShadow2",
	"zExBar3", "zShadow3", "zExBar4", "zShadow4",
}
zBarConfig.buttons = { --[[ Check Buttons - for attribute setting ]]
	--[[{-- switch full/lite mode
		name="FullMode",var='fullmode',common=true,
		pos={'TOPRIGHT','zBarConfig','TOPRIGHT',-88,-30},
		OnChecked=ReloadUI,
		UnChecked=ReloadUI,
	},]]
	{-- show / hide bar
		name="Hide",var="hide",pos={"TOPLEFT","zBarConfigAttribute","BOTTOMLEFT",0,0},
		OnChecked=function() zBarConfig.bar:UpdateVisibility() end,
		UnChecked=function()
			zBarConfig.bar:UpdateVisibility()
			zBarConfig.bar:UpdateButtons()
			zBarConfig.bar:UpdateLayouts()
		end,
	},
	{-- show / hide name label
		name="Label",var="label",pos={"TOP","zBarConfigHide","BOTTOM",0,0},
		OnChecked=function() zBarConfig.bar:GetLabel():Show() end,
		UnChecked=function() zBarConfig.bar:GetLabel():Hide() end,
	},
	{-- show / hide tab
		name="Lock",var="hideTab",pos={"TOP","zBarConfigLabel","BOTTOM",0,0},
		OnChecked=function() zBarConfig.bar:UpdateVisibility() end,
		UnChecked=function() zBarConfig.bar:UpdateVisibility() end,
	},
	{-- show / hide hotkeys
		name="HotKey",var="hideHotkey",pos={"TOP","zBarConfigLock","BOTTOM",0,0},
		OnChecked=function() zBarConfig.bar:UpdateHotkeys() end,
		UnChecked=function() zBarConfig.bar:UpdateHotkeys() end,
	},
	{-- auto-pop mode
		name="AutoPop",var="inCombat",value="autoPop",radio = true,
		pos={"TOPLEFT","zBarConfigInCombat","BOTTOMLEFT",0,0},
		OnChecked=function()
			zBarConfigAutoHide:SetChecked(false)
			zBarConfig.bar:UpdateAutoPop()
		end,
		UnChecked=function() zBarConfig.bar:UpdateAutoPop() end,
	},
	{-- auto-hide mode
		name="AutoHide",var="inCombat",value="autoHide",radio = true,
		pos={"TOPLEFT","zBarConfigInCombat","BOTTOMLEFT",100,0},
		OnChecked=function()
			zBarConfigAutoPop:SetChecked(false)
			zBarConfig.bar:UpdateAutoPop()
		end,
		UnChecked=function() zBarConfig.bar:UpdateAutoPop() end,
	},
	{
		name="Suite1",var="layout",value="suite1",radio = true,
		pos={"TOPLEFT","zBarConfigLayout","BOTTOMLEFT",0,0},
		OnChecked=function()
			zBarConfigSuite2:SetChecked(false)
			zBarConfigCircle:SetChecked(false)
			zBarConfigFree:SetChecked(false)
			zBarConfig.bar:UpdateLayouts()
		end,
		UnChecked=function() zBarConfigSlider2:SetValue(2) zBarConfigSlider2:SetValue(1) end,
	},
	{
		name="Suite2",var="layout",value="suite2",radio = true,
		pos={"TOP","zBarConfigSuite1","BOTTOM",0,-2},
		OnChecked=function()
			zBarConfigSuite1:SetChecked(false)
			zBarConfigCircle:SetChecked(false)
			zBarConfigFree:SetChecked(false)
			zBarConfig.bar:UpdateLayouts()
		end,
		UnChecked=function() zBarConfigSlider2:SetValue(2) zBarConfigSlider2:SetValue(1) end,
	},
	{
		name="Circle",var="layout",value="circle",radio = true,
		pos={"TOP","zBarConfigSuite2","BOTTOM",0,-2},
		OnChecked=function()
			zBarConfigSuite1:SetChecked(false)
			zBarConfigSuite2:SetChecked(false)
			zBarConfigFree:SetChecked(false)
			zBarConfig.bar:UpdateLayouts()
		end,
		UnChecked=function() zBarConfigSlider2:SetValue(2) zBarConfigSlider2:SetValue(1) end,
	},
	{
		name="Free",var="layout",value="free",radio = true,
		pos={"TOP","zBarConfigCircle","BOTTOM",0,-2},
		OnChecked=function()
			zBarConfigSuite1:SetChecked(false)
			zBarConfigSuite2:SetChecked(false)
			zBarConfigCircle:SetChecked(false)
			if not zBar3.buttons[zBarConfig.bar:GetName().."1"] then return end
			local saves = zBar3Data[zBarConfig.bar:GetName()]
			for i = 1, saves.num do
				local button = _G[zBar3.buttons[zBarConfig.bar:GetName()..i]]
				if not button:IsMovable() then
					button:SetMovable(true)
				end
			end
			zTab:SaveAllPoints(zBarConfig.bar)
		end,
		UnChecked=function() zBarConfigSlider2:SetValue(2) zBarConfigSlider2:SetValue(1) end,
	},
	{
		name="Invert",var="invert",
		pos={"TOP","zBarConfigFree","BOTTOM",0,-2},
		OnChecked=function() zBarConfig.bar:UpdateLayouts() end,
		UnChecked=function() zBarConfig.bar:UpdateLayouts() end,
	},
	--[[ commons ]]
	{-- show / hide button tips
		name="HideTip",var="hideTip",common=true,
		pos={"TOPLEFT","zBarConfigCommons","BOTTOMLEFT",0,0},
		OnChecked=function() end,
		UnChecked=function() end,
	},
	{-- lock / unlock all buttons
		name="LockButtons",
		pos={"TOP","zBarConfigHideTip","BOTTOM",0,0},
		IsChecked=function() return LOCK_ACTIONBAR == "1" end,
		OnChecked=function() LOCK_ACTIONBAR = "1" SetCVar("lockActionBars", "1") end,
		UnChecked=function() LOCK_ACTIONBAR = nil SetCVar("lockActionBars", nil) end,
	},
	{-- show / hide grid
		name="HideGrid",
		pos={"TOP","zBarConfigLockButtons","BOTTOM",0,0},
		IsChecked=function()
			return not (ALWAYS_SHOW_MULTIBARS == "1" or ALWAYS_SHOW_MULTIBARS == 1)
		end,
		OnChecked=function()
			ALWAYS_SHOW_MULTIBARS = nil
			SetCVar("alwaysShowActionBars", nil)
			zBarConfig:Befor_HideGrid()
			MultiActionBar_UpdateGridVisibility()
		end,
		UnChecked=function()
			ALWAYS_SHOW_MULTIBARS = "1"
			SetCVar("alwaysShowActionBars", "1")
			zBarConfig:Befor_ShowGrid()
			MultiActionBar_UpdateGridVisibility()
		end,
	},
	{-- auto page
		name="PageTrigger",var="pageTrigger",common=true,
		pos={"TOP","zBarConfigHideGrid","BOTTOM",0,0},
		IsEnabled=function() return (zMainBar and true) end,
		OnChecked=function() zMainBar:UpdateStateHeader() end,
		UnChecked=function() zMainBar:UpdateStateHeader() end,
	},
	{-- Duid cat form, page change when stealth
		name="CatStealth",var="catStealth",common=true,
		pos={"TOP","zBarConfigPageTrigger","BOTTOM",0,0},
		IsEnabled=function() return (zMainBar and zBar3.class == "DRUID") end,
		OnChecked=function() zMainBar:UpdateStateHeader() end,
		UnChecked=function() zMainBar:UpdateStateHeader() end,
	},
}
zBarConfig.sliders = { --[[ Sliders ]]
	[1] = {-- num of buttons
		name="Num",
		var="num", min=1, max=12, step=1,
		pos={"TOPRIGHT","zBarConfig","TOPRIGHT",-10,-185},
		setFunc = function(this)
			zBar3Data[zBarConfig.bar:GetName()].num = this:GetValue()
			zBarConfig.bar:UpdateButtons()
			zBarConfig.bar:UpdateLayouts()
		end
	},
	[2] = {-- num per line
		name="NumPerLine",
		var="linenum", min=1, max=12, step=1,
		pos={"TOP","zBarConfigSlider1","BOTTOM",0,-25},
		setFunc = function(this)
			local saves = zBar3Data[zBarConfig.bar:GetName()]

			if zBarConfig.loading and saves.layout ~= "line" then return end

			-- uncheck layout radio buttons
			zBarConfigSuite1:SetChecked(false)
			zBarConfigSuite2:SetChecked(false)
			zBarConfigCircle:SetChecked(false)
			zBarConfigFree:SetChecked(false)

			-- linenum can't be greater than num
			local num = this:GetValue()
			if num > saves.num then
				this:SetValue(saves.num)
				return -- return to prevent dead loop
			end
			-- update
			saves.layout = "line"
			saves.linenum = this:GetValue()
			zBarConfig.bar:UpdateLayouts()
		end
	},
	[3] = {-- scale
		name="Scale",
		var="scale", min=0.2, max=1.8, step=0.001, factor=100,
		pos={"TOP","zBarConfigSlider2","BOTTOM",0,-30},
		setFunc = function(this)
			local value = this:GetValue()
			zBar3Data[zBarConfig.bar:GetName()].scale = value
			zBarConfig.bar:SetScale(value)
			zBarConfig.bar:GetTab():SetScale(value)
			-- set edit box text
			local tmp = _G[this:GetName().."EditBox"]
			tmp:SetText(floor(100 * value))
			tmp:HighlightText()
		end
	},
	[4] = {-- button spacing
		name="Inset",
		var="inset", min=-10, max=30, step=1,
		pos={"TOP","zBarConfigSlider3","BOTTOM",0,-25},
		setFunc = function(this)
			zBar3Data[zBarConfig.bar:GetName()].inset = this:GetValue()
			zBarConfig.bar:UpdateLayouts()
			this.text:SetText(zBar3.loc.Option.Inset.." |cff00FF00"..this:GetValue().."|r")
		end
	},
	[5] = {-- alpha
		name="Alpha",
		var="alpha", min=0, max = 1, step=0.1, factor=100,
		pos={"TOP","zBarConfigSlider4","BOTTOM",0,-25},
		setFunc = function(this)
			zBar3Data[zBarConfig.bar:GetName()].alpha = this:GetValue()
			zBarConfig.bar:SetAlpha(this:GetValue())
		end
	},
}
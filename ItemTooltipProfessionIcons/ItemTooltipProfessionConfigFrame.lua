local _, ItemProfConstants = ...

local frame = CreateFrame( "Frame" )
frame.name = "ItemTooltipIconConfig"

local NUM_PROFS_TRACKED = ItemProfConstants.NUM_PROF_FLAGS
local NUM_QUEST_FILTERS = ItemProfConstants.NUM_QUEST_FLAGS

local profsCheck
local questCheck
local vendorCheck
local dmfCheck
local classQuestLabel
local profQuestLabel
local iconSizeSlider
local iconSizeLabel
local iconDemoTexture

local PROF_CHECK = {}
local QUEST_CHECK = {}

local configDefaultShowProfs = true
local configDefaultShowQuests = true
local configDefaultProfFlags = 0x1FF
local configDefaultQuestFlags = 0x3FFFFF
local configDefaultIncludeVendor = false
local configDefaultIconSize = 16
local configDefaultShowDMF = true

local userVariables



local function SaveAndQuit() 

	local profFlags = 0
	-- Ignore the profession flags if master profession checkbox is unchecked
	for i=0, NUM_PROFS_TRACKED-1 do
		local bitMask = bit.lshift( 1, i )
		local isChecked = PROF_CHECK[ bitMask ]:GetChecked()
		if isChecked then
			profFlags = profFlags + bitMask
		end
	end
	
	local questFlags = 1		-- Normal quests flag
	for i=1, NUM_QUEST_FILTERS do
		local bitMask = bit.lshift( 1, i )
		local isChecked = QUEST_CHECK[ bitMask ]:GetChecked()
		if isChecked then
			questFlags = questFlags + bitMask
		end
	end
	
	
	userVariables.showProfs = profsCheck:GetChecked()
	userVariables.showQuests = questCheck:GetChecked()
	userVariables.profFlags = profFlags
	userVariables.questFlags = questFlags
	userVariables.includeVendor = vendorCheck:GetChecked()
	userVariables.iconSize = iconSizeSlider:GetValue()
	userVariables.showDMF = dmfCheck:GetChecked()

	ItemProfConstants:ConfigChanged()
end



local function ToggleProfCheckbox() 

	local isChecked = profsCheck:GetChecked()
	-- How do I call as a stored function CheckButton:Enable()?
	for k,v in pairs( PROF_CHECK ) do
		if isChecked then
			v:Enable()
		else
			v:Disable()
		end
	end
	
end


local function ToggleQuestCheckbox() 

	local isChecked = questCheck:GetChecked()
	if isChecked then
		for k,v in pairs( QUEST_CHECK ) do
			v:Enable()
		end
	else
		for k,v in pairs( QUEST_CHECK ) do
			v:Disable()
		end
	end
	
end


local function RefreshWidgets()

	-- Sync the widgets state with the config variables
	profsCheck:SetChecked( userVariables.showProfs )
	questCheck:SetChecked( userVariables.showQuests )
	vendorCheck:SetChecked( userVariables.includeVendor )
	dmfCheck:SetChecked( userVariables.showDMF )
	local profFlags = userVariables.profFlags
	local questFlags = userVariables.questFlags
	iconSizeSlider:SetValue( userVariables.iconSize )
	
	-- Update the profession checkboxes
	for i=0, NUM_PROFS_TRACKED-1 do
		local bitMask = bit.lshift( 1, i )
		local isSet = bit.band( profFlags, bitMask )
		PROF_CHECK[ bitMask ]:SetChecked( isSet ~= 0 )
	end

	-- Update the quest checkboxes
	for i=1, NUM_QUEST_FILTERS do
		local bitMask = bit.lshift( 1, i )
		local isSet = bit.band( questFlags, bitMask )
		QUEST_CHECK[ bitMask ]:SetChecked( isSet ~= 0 )
	end
	
	-- Set checkboxes enabled/disabled
	ToggleProfCheckbox()
	ToggleQuestCheckbox()
end


local function IconSizeChanged( self, value ) 

	-- Called when the icon slider widget changes value
	iconDemoTexture:SetSize( value, value )
	iconSizeLabel:SetText( value )
end


local function InitVariables()
	
	local configRealm = ItemProfConstants.configTooltipIconsRealm
	local configChar = ItemProfConstants.configTooltipIconsChar
	
	
	if not ItemTooltipIconsConfig then
		ItemTooltipIconsConfig = {}
	end
	
	if not ItemTooltipIconsConfig[ configRealm ] then
		ItemTooltipIconsConfig[ configRealm ] = {}
	end
	
	if not ItemTooltipIconsConfig[ configRealm ][ configChar ] then
		ItemTooltipIconsConfig[ configRealm ][ configChar ] = {}
	end
	
	userVariables = ItemTooltipIconsConfig[ configRealm ][ configChar ]
	
	if userVariables.showProfs == nil then
		userVariables.showProfs = configDefaultShowProfs
	end
	
	if userVariables.showQuests == nil then
		userVariables.showQuests = configDefaultShowQuests
	end
	
	if userVariables.profFlags == nil then
		userVariables.profFlags = configDefaultProfFlags
	end
	
	if userVariables.questFlags == nil then
		userVariables.questFlags = configDefaultQuestFlags
	end
	
	if userVariables.includeVendor == nil then
		userVariables.includeVendor = configDefaultIncludeVendor
	end
	
	if userVariables.iconSize == nil then
		userVariables.iconSize = configDefaultIconSize
	end
	
	if userVariables.showDMF == nil then
		userVariables.showDMF = configDefaultShowDMF
	end
	
	
	RefreshWidgets()
	ItemProfConstants:ConfigChanged()
end


local function CreateCheckbox( name, x, y, label, tooltip )

	local check = CreateFrame( "CheckButton", name, frame, "ChatConfigCheckButtonTemplate" ) --"OptionsCheckButtonTemplate" )
	_G[ name .. "Text" ]:SetText( label )
	check.tooltip = tooltip
	check:SetPoint( "TOPLEFT", x, y )

	return check
end


local function CreateProfessionWidgets() 

	profsCheck = CreateCheckbox( "ItemTooltipIconsConfigCheck0", 20, -50, " Enable Profession Icons", "If enabled profession icons will be displayed on items that are crafting materials" )
	profsCheck:SetScript( "OnClick", ToggleProfCheckbox )

	-- Checkbox alignment offsets
	local x0 = 45
	local x1 = 245
	local x2 = 445
	local y0 = -70
	local dy = -20

	PROF_CHECK[ 1 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0a", x0, y0+(2*dy), " Cooking", nil )
	PROF_CHECK[ 2 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0b", x1, y0+(2*dy), " First Aid", nil )
	PROF_CHECK[ 4 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0c", x0, y0, " Alchemy", nil )
	PROF_CHECK[ 8 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0d", x0, y0+dy, " Blacksmithing", nil )
	PROF_CHECK[ 16 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0e", x1, y0, " Enchanting", nil )
	PROF_CHECK[ 32 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0f", x1, y0+dy, " Engineering", nil )
	PROF_CHECK[ 64 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0g", x2, y0+dy, " Leatherworking", nil )
	PROF_CHECK[ 128 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0h", x2, y0+(2*dy), " Tailoring", nil )
	PROF_CHECK[ 256 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck0i", x2, y0, " Jewelcrafting", nil )
end

local function CreateQuestWidgets() 
	
	questCheck = CreateCheckbox( "ItemTooltipIconsConfigCheck1", 20, -180, " Enable Quest Icons", "If enabled quest icons will be displayed on items that are needed by quests" )
	questCheck:SetScript( "OnClick", ToggleQuestCheckbox )

	local x0 = 45
	local x1 = 245
	local x2 = 445
	local y0 = -200
	local dy = -20
	
	QUEST_CHECK[ 0x00002 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1b", x0, y0, " Alliance", nil )
	QUEST_CHECK[ 0x00004 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1c", x0, y0+dy, " Horde", nil )


	classQuestLabel = frame:CreateFontString( "ClassQuestLabel", "OVERLAY", "GameTooltipText" )
	classQuestLabel:SetFont( "Fonts\\FRIZQT__.TTF", 14, "THINOUTLINE" )
	classQuestLabel:SetPoint( "TOPLEFT", x0, -255 )
	classQuestLabel:SetTextColor( 1, 0.85, 0.15 )
	classQuestLabel:SetText( "Class Quests" )

	y0 = -270
	
	QUEST_CHECK[ 0x00008 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1d1", x0, y0, " Druid", nil )
	QUEST_CHECK[ 0x00010 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1d2", x0, y0+dy, " Hunter", nil )
	QUEST_CHECK[ 0x00020 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1d3", x0, y0+(2*dy), " Mage", nil )
	QUEST_CHECK[ 0x00040 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1d4", x1, y0, " Paladin", nil )
	QUEST_CHECK[ 0x00080 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1d5", x1, y0+dy, " Priest", nil )
	QUEST_CHECK[ 0x00100 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1d6", x1, y0+(2*dy), " Rogue", nil )
	QUEST_CHECK[ 0x00200 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1d7", x2, y0, " Shaman", nil )
	QUEST_CHECK[ 0x00400 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1d8", x2, y0+dy, " Warlock", nil )
	QUEST_CHECK[ 0x00800 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1d9", x2, y0+(2*dy), " Warrior", nil )



	profQuestLabel = frame:CreateFontString( "ProfQuestLabel", "OVERLAY", "GameTooltipText" )
	profQuestLabel:SetFont( "Fonts\\FRIZQT__.TTF", 14, "THINOUTLINE" )
	profQuestLabel:SetPoint( "TOPLEFT", x0, -345 )
	profQuestLabel:SetTextColor( 1, 0.85, 0.15 )
	profQuestLabel:SetText( "Profession Quests" )

	
	y0 = -360
	
	QUEST_CHECK[ 0x001000 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1e1", x0, y0+(2*dy), " Cooking", nil )
	QUEST_CHECK[ 0x002000 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1e2", x1, y0+(2*dy), " First Aid", nil )
	QUEST_CHECK[ 0x004000 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1e3", x0, y0, " Alchemy", nil )
	QUEST_CHECK[ 0x008000 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1e4", x0, y0+dy, " Blacksmithing", nil )
	QUEST_CHECK[ 0x010000 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1e5", x1, y0, " Enchanting", nil )
	QUEST_CHECK[ 0x020000 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1e6", x1, y0+dy, " Engineering", nil )
	QUEST_CHECK[ 0x040000 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1e7", x2, y0+dy, " Leatherworking", nil )
	QUEST_CHECK[ 0x080000 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1e8", x2, y0+(2*dy), " Tailoring", nil )
	QUEST_CHECK[ 0x100000 ] = CreateCheckbox( "ItemTooltipIconsConfigCheck1e9", x2, y0, " Jewelcrafting", nil )
end

local function CreateIconResizeWidgets()

	iconSizeSlider = CreateFrame( "Slider", "ItemTooltipIconsConfigSlider0", frame, "OptionsSliderTemplate" )
	iconSizeSlider:SetPoint( "TOPLEFT", 20, -540 )
	iconSizeSlider:SetMinMaxValues( 8, 32 )
	iconSizeSlider:SetValueStep( 1 )
	iconSizeSlider:SetStepsPerPage( 1 )
	iconSizeSlider:SetWidth( 200 )
	iconSizeSlider:SetObeyStepOnDrag( true )
	iconSizeSlider:SetScript( "OnValueChanged", IconSizeChanged )
	_G[ "ItemTooltipIconsConfigSlider0Text" ]:SetText( "Icon Size" )
	_G[ "ItemTooltipIconsConfigSlider0Low" ]:SetText( nil )
	_G[ "ItemTooltipIconsConfigSlider0High" ]:SetText( nil )

	iconSizeLabel = frame:CreateFontString( nil, "OVERLAY", "GameTooltipText" )
	iconSizeLabel:SetFont( "Fonts\\FRIZQT__.TTF", 12, "THINOUTLINE" )
	iconSizeLabel:SetPoint( "TOPLEFT", 225, -542 )

	iconDemoTexture = frame:CreateTexture( nil, "OVERLAY" )
	iconDemoTexture:SetPoint( "TOPLEFT", 300, -540 )
	iconDemoTexture:SetTexture( GetSpellTexture( 4036 ) )
end


local dialogHeader = frame:CreateFontString( nil, "OVERLAY", "GameTooltipText" )
dialogHeader:SetFont( "Fonts\\FRIZQT__.TTF", 10, "THINOUTLINE" )
dialogHeader:SetPoint( "TOPLEFT", 20, -20 )
dialogHeader:SetText( "These options allow you control which icons are displayed on the item tooltips.\nThe quest icon can be filtered to display on items needed for quests of specific class/profession." )


CreateProfessionWidgets()
CreateQuestWidgets()
vendorCheck = CreateCheckbox( "ItemTooltipIconsConfigCheck2", 20, -470, " Vendor Items", "Display icons on items sold by vendors" )
dmfCheck = CreateCheckbox( "ItemTooltipIconsConfigCheck3", 20, -490, " Darkmoon Faire Ticket Items", "Display a ticket icon if the item can be exchanged for Darkmoon Faire tickets" )
CreateIconResizeWidgets()



frame.okay = SaveAndQuit
frame:SetScript( "OnShow", RefreshWidgets )
frame:SetScript( "OnEvent", InitVariables )
frame:RegisterEvent( "VARIABLES_LOADED" )


InterfaceOptions_AddCategory( frame )
local _, ItemProfConstants = ...

local frame = CreateFrame( "Frame" )

local previousItemID = -1
local itemIcons = ""
local iconSize

local ITEM_VENDOR_FLAG = ItemProfConstants.VENDOR_ITEM_FLAG
local ITEM_DMF_FLAG = ItemProfConstants.DMF_ITEM_FLAG
local ITEM_PROF_FLAGS = ItemProfConstants.ITEM_PROF_FLAGS
local QUEST_FLAG = ItemProfConstants.QUEST_FLAG
local NUM_PROFS_TRACKED = ItemProfConstants.NUM_PROF_FLAGS
local PROF_TEXTURES = ItemProfConstants.PROF_TEXTURES

local showProfs
local showQuests
local profFilter
local questFilter
local includeVendor
local showDMF

ItemProfConstants.configTooltipIconsRealm = GetRealmName()
ItemProfConstants.configTooltipIconsChar = UnitName( "player" )



local function CreateItemIcons( itemFlags )

	
	if not includeVendor then
		-- Return if the item has the vendor flag
		local isVendor = bit.band( itemFlags, ITEM_VENDOR_FLAG )
		if isVendor ~= 0 then
			return nil
		end
	end
	
	
	local t = {}
	
	if showProfs then
	
		local enabledFlags = bit.band( itemFlags, profFilter )
		for i=0, NUM_PROFS_TRACKED-1 do
			local bitMask = bit.lshift( 1, i )
			local isSet = bit.band( enabledFlags, bitMask )
			if isSet ~= 0 then
				t[ #t+1 ] = "|T"
				t[ #t+1 ] = PROF_TEXTURES[ bitMask ]
				t[ #t+1 ] = ":"
				t[ #t+1 ] = iconSize
				t[ #t+1 ] = "|t "
			end
		end
	end
	
	if showDMF then
	
		local isTicketItem = bit.band( itemFlags, ITEM_DMF_FLAG )
		if isTicketItem ~= 0 then
			t[ #t+1 ] = "|T"
			t[ #t+1 ] = PROF_TEXTURES[ ITEM_DMF_FLAG ]
			t[ #t+1 ] = ":"
			t[ #t+1 ] = iconSize
			t[ #t+1 ] = "|t "
		end
	end
	
	if showQuests then
		-- Quest filter flags start at 0x400, shift to bit 0 will align with config filter
		local questFlags = bit.rshift( itemFlags, 10 )
		local isSet = bit.band( questFlags, questFilter )
		
		-- Check if the quest is faction exclusive
		local isFactionQuest = bit.band( questFlags, 0x06 )
		if isFactionQuest ~= 0 then
			-- Ignore the quest if the configuration isnt tracking this faction
			local isFactionEnabled = bit.band( isFactionQuest, questFilter )
			local showFaction = bit.band( isFactionQuest, isFactionEnabled )
			if showFaction == 0 then
				isSet = 0
			end
			
			-- Both flags must be set if the faction quest was for a specific class/profession
			if isSet < 0x08 and questFlags >= 0x08 then
				isSet = 0
			end
		end
		
		if isSet ~= 0 then
			t[ #t+1 ] = "|T"
			t[ #t+1 ] = PROF_TEXTURES[ QUEST_FLAG ]
			t[ #t+1 ] = ":"
			t[ #t+1 ] = iconSize
			t[ #t+1 ] = "|t "
		end
	end

	return table.concat( t )
end


local function ModifyItemTooltip( tt ) 
		
	local itemName, itemLink = tt:GetItem() 
	if not itemName then return end
	local itemID = select( 1, GetItemInfoInstant( itemName ) )
	
	if itemID == nil then
		-- Extract ID from link: GetItemInfoInstant unreliable with AH items (uncached on client?)
		itemID = tonumber( string.match( itemLink, "item:?(%d+):" ) )
		if itemID == nil then
			-- The item link doesn't contain the item ID field
			return
		end
	end
	
	-- Reuse the texture state if the item hasn't changed
	if previousItemID == itemID then
		tt:AddLine( itemIcons )
		return
	end
	
	-- Check if the item is a profession reagent
	local itemFlags = ITEM_PROF_FLAGS[ itemID ]
	if itemFlags == nil then
		-- Don't modify the tooltip
		return
	end
	
	-- Convert the flags into texture icons
	previousItemID = itemID
	itemIcons = CreateItemIcons( itemFlags )
	
	tt:AddLine( itemIcons )
end


function ItemProfConstants:ConfigChanged()

	showProfs = ItemTooltipIconsConfig[ ItemProfConstants.configTooltipIconsRealm ][ ItemProfConstants.configTooltipIconsChar ].showProfs
	showQuests = ItemTooltipIconsConfig[ ItemProfConstants.configTooltipIconsRealm ][ ItemProfConstants.configTooltipIconsChar ].showQuests
	profFilter = ItemTooltipIconsConfig[ ItemProfConstants.configTooltipIconsRealm ][ ItemProfConstants.configTooltipIconsChar ].profFlags
	questFilter = ItemTooltipIconsConfig[ ItemProfConstants.configTooltipIconsRealm ][ ItemProfConstants.configTooltipIconsChar ].questFlags
	includeVendor = ItemTooltipIconsConfig[ ItemProfConstants.configTooltipIconsRealm ][ ItemProfConstants.configTooltipIconsChar ].includeVendor
	iconSize = ItemTooltipIconsConfig[ ItemProfConstants.configTooltipIconsRealm ][ ItemProfConstants.configTooltipIconsChar ].iconSize
	showDMF = ItemTooltipIconsConfig[ ItemProfConstants.configTooltipIconsRealm ][ ItemProfConstants.configTooltipIconsChar ].showDMF
	
	previousItemID = -1		-- Reset line
end


local function InitFrame()

	GameTooltip:HookScript( "OnTooltipSetItem", ModifyItemTooltip )
	--ItemRefTooltip:HookScript( "OnTooltipSetItem", ModifyItemTooltip )
end


InitFrame()

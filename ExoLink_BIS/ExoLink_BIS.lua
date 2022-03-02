local LibExtraTip = LibStub("LibExtraTip-1")
ExoLink.BIS = {}
ExoLink.Items = {}

local addonName, addonTable = ...
local iconpath = "Interface\\GLUES\\CHARACTERCREATE\\UI-CharacterCreate-Classes"
local iconCutoff = 6

--[[
local ICON_TEXTURE_BASE = "Interface\\ICONS\\";

local TALENT_BRANCH_TEXTURES = {
	DRUIDBALANCE = "Spell_Nature_StarFall",
	DRUIDFERAL = "Ability_Racial_BearForm",
	DRUIDRESTORATION = "Spell_Nature_HealingTouch",
	MAGEFIRE = "Spell_Fire_FireBolt02",
	MAGEFROST = "Spell_Frost_FrostBolt02",
	PALADINHOLY = "Spell_Holy_HolyBolt",
	PALADINPROTECTION = "Spell_Holy_DevotionAura",
	PALADINRETRIBUTION = "Spell_Holy_AuraOfLight",
	PRIESTHOLY = "Spell_Holy_HolyBolt",
	PRIESTSHADOW = "Spell_Shadow_ShadowWordPain",
	ROGUEDAGGER = "Ability_BackStab",
	SHAMANRESTORATION = "Spell_Nature_MagicImmunity",
	SHAMANENHANCEMENT = "Spell_Nature_LightningShield",
	WARRIORPROTECTION = "INV_Shield_06",
	WARRIORFURY = "Ability_Warrior_InnerRage"
}
]]--

local function iconOffset(col, row)
	local offsetString = (col * 64 + iconCutoff) .. ":" .. ((col + 1) * 64 - iconCutoff)
	return offsetString .. ":" .. (row * 64 + iconCutoff) .. ":" .. ((row + 1) * 64 - iconCutoff)
end

local function buildExtraTip(tooltip, entry)
    local r,g,b = .9,.8,.5
    LibExtraTip:AddLine(tooltip," ",r,g,b,true)
	LibExtraTip:AddLine(tooltip,"# BIS:",r,g,b,true)

	
	for k, v in pairs(entry) do
		local entry = ExoLink.BIS[k]
		local class = entry.class:upper()
		local color = RAID_CLASS_COLORS[class]
		local coords = CLASS_ICON_TCOORDS[class]
		local classfontstring = "|T" .. iconpath .. ":14:14:::256:256:" .. iconOffset(coords[1] * 4, coords[3] * 4) .. "|t"
		
		LibExtraTip:AddDoubleLine(tooltip, classfontstring .. " " .. entry.class .. " " .. entry.spec .. " " .. entry.comment, v, color.r, color.g, color.b, color.r, color.g, color.b, true)
	end
	
	LibExtraTip:AddLine(tooltip," ",r,g,b,true)
end

local function onTooltipSetItem(tooltip, itemLink, quantity)
    if not itemLink then return end
    
	local itemString = string.match(itemLink, "item[%-?%d:]+")
	local itemId = ({ string.split(":", itemString) })[2]

	if ExoLink.Items[itemId] then
		buildExtraTip(tooltip, ExoLink.Items[itemId])
	end
end

local eventframe = CreateFrame("FRAME",addonName.."Events")

local function onEvent(self,event,arg)
    if event == "PLAYER_ENTERING_WORLD" then
        eventframe:UnregisterEvent("PLAYER_ENTERING_WORLD")
        LibExtraTip:AddCallback({type = "item", callback = onTooltipSetItem, allevents = true})
        LibExtraTip:RegisterTooltip(GameTooltip)
        LibExtraTip:RegisterTooltip(ItemRefTooltip)
    end
end

eventframe:RegisterEvent("PLAYER_ENTERING_WORLD")
eventframe:SetScript("OnEvent", onEvent)

function ExoLink:RegisterBIS(class, spec, comment)
	if not spec then spec = "" end
	if not comment then comment = "" end
	
    local bis = {
		class = class,
		spec = spec,
		comment = comment
	}
	
	bis.ID = class..spec..comment

    ExoLink.BIS[bis.ID] = bis
    return bis
end

function ExoLink:BISitem(bisEntry, id, slot, description, phase)
	if not ExoLink.Items[id] then
		ExoLink.Items[id] = {}
	end

	ExoLink.Items[id][bisEntry.ID] = phase
end
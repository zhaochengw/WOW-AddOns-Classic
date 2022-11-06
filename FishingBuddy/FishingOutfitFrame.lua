-- Wrap OutfitDisplayFrame with our "improvements"

local FL = LibStub("LibFishing-1.0");

local DEFAULTUPDATE_WAIT = 0.1;

local _;

local FBAPI = LibStub("FishingBuddyApi-1.0");

-- Temporary, until we're pretty sure everyone has upgraded
local function RegisterHandlers(...)
	if (FBAPI) then
		return FBAPI:RegisterHandlers(...);
	else
		return FishingBuddy.API.RegisterHandlers(...);
	end
end

-- set up
FB_ODFConstants = {};
FL:Translate("FB_OutfitDisplayFrame", FB_ODFTranslations, FB_ODFConstants);

FishingBuddy.FB_ODFConstants = FB_ODFConstants;

-- have to do this after we've done our translations
local OutfitOptions = {};
OutfitOptions["OutfitDisplay"] = {
	["text"] = FB_ODFConstants.CONFIG_OUTFITDISPLAY_ONOFF,
	["tooltip"] = FB_ODFConstants.CONFIG_OUTFITDISPLAY_INFO,
	["v"] = 1,
	["default"] = true };
OutfitOptions["AnyPole"] = {
	["text"] = FB_ODFConstants.CONFIG_ANYPOLE_ONOFF,
	["tooltip"] = FB_ODFConstants.CONFIG_ANYPOLE_INFO,
	["v"] = 1,
	["parents"] = { ["OutfitDisplay"] = "d" },
	["default"] = true };
OutfitOptions["UseTabard"] = {
	["text"] = FB_ODFConstants.CONFIG_TABARD_ONOFF,
	["tooltip"] = FB_ODFConstants.CONFIG_TABARD_INFO,
	["v"] = 1,
	["parents"] = { ["OutfitDisplay"] = "d" },
	["default"] = true };
-- This doesn't really work anymore, Blizz has broken it
OutfitOptions["CombatSwitch"] = {
	["text"] = FB_ODFConstants.CONFIG_COMBATSWITCH_ONOFF,
	["tooltip"] = FB_ODFConstants.CONFIG_COMBATSWITCH_INFO,
	["v"] = 1,
	["parents"] = { ["OutfitDisplay"] = "d" },
	["default"] = false };

-- free up the space
FB_ODFTranslations = nil;

FB_OutfitFrame = {};

local IgnoredItems = {};

local function StylePoints(outfit)
	local isp = FishingBuddy.OutfitManager.ItemStylePoints;
	local points = 0;
	if ( outfit )then
		for slot in pairs(outfit) do
			if ( outfit[slot].item ) then
				local _,_,check, enchant = string.find(outfit[slot].item, "^(%d+):(%d+)");
				points = points + isp(check, enchant);
			end
		end
	end
	return points;
end

local function BonusPoints(outfit)
	local ibp = function(link) return FL:FishingBonusPoints(link); end;
	local points = 0;
	if ( outfit )then
		for slot in pairs(outfit) do
			points = points + ibp(outfit[slot].item);
		end
	end
	return points;
end

local GSB = FishingBuddy.GetSettingBool;
local function GetSettingBool(setting)
	if (GSB("OutfitDisplay")) then
		return GSB(setting);
	end
	-- return nil;
end

local function UpdateSwitchButton(outfit)
	if ( outfit ) then
		local msg = FishingOutfitFrameTab.Outfit:SwitchWillFail(outfit);
		if ( not msg ) then
			FishingOutfitFrameTab.Switch:Enable();
		end
	else
		FishingOutfitFrameTab.Switch:Disable();
	end
end

-- outfit support functions
local function GetWasWearing()
	if FBODF_PlayerInfo["WasWearing"] then
		return FBODF_PlayerInfo["WasWearing"];
	end
end

local mainhandslot = GetInventorySlotInfo("MainHandSlot");
local offhandslot = GetInventorySlotInfo("SecondaryHandSlot");

local a_offhands = {}
a_offhands[133959] = {
    ["name"] = "Heart of the Phoenix"
};
a_offhands[128293] = {
    ["name"] = "Blades of the Fallen Prince"
};
a_offhands[127830] = {
    ["name"] = "Twinblades of the Deceiver"
};
a_offhands[128831] = {
    ["name"] = "Aldrachi Warblades"
};
a_offhands[128859] = {
    ["name"] = "Fangs of Ashamane"
};
a_offhands[128822] = {
    ["name"] = "Claws of Ursoc"
};
a_offhands[133948] = {
    ["name"] = "Fists of the Heavens"
};
a_offhands[128866] = {
    ["name"] = "Truthguard",
	["main"] = 1
}; -- the main hand is the fake (Oathbreaker)
a_offhands[133958] = {
    ["name"] = "Secrets of the Void"
};
a_offhands[128869] = {
    ["name"] = "The Kingslayers"
};
a_offhands[134552] = {
    ["name"] = "The Dreadblades"
};
a_offhands[128479] = {
    ["name"] = "Fangs of the Devourer"
};
a_offhands[128936] = {
    ["name"] = "The Highkeeper's Ward"
};
a_offhands[128873] = {
    ["name"] = "Fury of the Stonemother"
};
a_offhands[128934] = {
    ["name"] = "Shield of the Sea Queen"
};
a_offhands[128943] = {
    ["name"] = "Skull of the Man'ari",
	["main"] = 1
};
a_offhands[128908] = {
    ["name"] = "Odyn's Fury"
}; -- not sure which one of these is off-hand
a_offhands[134553] = {
    ["name"] = "Helya's Wrath"
}; -- not sure which one of these is off-hand
a_offhands[128289] = {
    ["name"] = "Scale of the Earth-Warder",
	["main"] = 1
};

local function SetWasWearing(outfit)
	if (outfit) then
		local offhand = outfit["SecondaryHandSlot"];

		if (offhand) then
			local _,_, check, enchant = string.find(offhand.item, "^(%d+):(%d+)");
			check = tonumber(check)
			for id,data in pairs(a_offhands) do
				if (check == id) then
					if (data.main) then
						outfit["MainHandSlot"] = nil;
					else
						outfit["SecondaryHandSlot"] = nil;
					end
				end
			end
		end
	end

	FBODF_PlayerInfo["WasWearing"] = outfit;
end

local function MakeFishingOutfit()
	 local fo = FL:GetFishingOutfitItems(nil, nil, IgnoredItems);
	 local outfit = {};
	 if (fo) then
		 for id,info in pairs(fo) do
			-- Don't build an outfit with funny hats or the ephemeral fishng pole
			local color, item, name = FL:SplitLink(info.link);
			local slotName = info.slotname;
			outfit[slotName] = {};
			outfit[slotName].item = item;
			_, _, _, _, _, _, _, _, _, outfit[slotName].texture, _ = GetItemInfo(info.link);
			outfit[slotName].color = color;
			outfit[slotName].name = name;
			outfit[slotName].link = info.link;
			outfit[slotName].slotid = info.slot;
			outfit[slotName].used = true;
		end
		-- check for two-handed weapon
		local mainhand = outfit["MainHandSlot"];
		if ( mainhand and not FL:IsItemOneHanded(mainhand.link) ) then
			outfit["SecondaryHandSlot"] = {};
			outfit["SecondaryHandSlot"].forced = true;
			outfit["SecondaryHandSlot"].empty = true;
			outfit["SecondaryHandSlot"].used = true;
		end
	end
	
	return outfit;
end

local saved_outfit;
local function KeepOutfit(outfit)
	saved_outfit = outfit;
	FBODF_PlayerInfo["Outfit"] = outfit;
end

local function GetFishingOutfit()
	local outfit = FBODF_PlayerInfo["Outfit"];
	if ( not outfit or not next(outfit) ) then
		outfit = MakeFishingOutfit();
		KeepOutfit(outfit);
	end

	if (GetItemCount(89401) == 0 or not GetSettingBool("UseTabard")) then
		outfit["TabardSlot"] = nil;
	end
	 
	return outfit;
end

local function StyleString(long, points)
  local pstring = FBConstants.POINTS;
  if ( points == 1 ) then
	 pstring = FBConstants.POINT;
  end
  if ( long ) then
	  return FB_ODFConstants.STYLEPOINTS..points.." "..pstring;
  else
	  return FB_ODFConstants.CONFIG_STYLISH_TEXT..points.." "..pstring;
  end
end

local function UpdateStyleInfo(outfit)
	local points = BonusPoints(outfit);
	if ( points >= 0 ) then
		points = "+"..points;
	else
		points = 0 - points;
		points = "-"..points;
	end
	FishingOutfitSkill:SetText(FB_ODFConstants.CONFIG_SKILL_TEXT..points);
	points = StylePoints(outfit);
	FishingOutfitStyle:SetText(StyleString(false, points));
end

local function MakeOutfitInfo(link)
	local nm,_,_,_,_,_,_,_,tx,_ = FL:GetItemInfo(link);
	local color, item, _ = FL:SplitLink(link);
	return { name=nm, color=color, item=item, texture=tx, used=true };
end

local function FindFishingPoles()
	local poles = {};
	if ( FL:IsFishingPole() ) then
		local link = GetInventoryItemLink("player", mainhandslot);
		tinsert(poles, MakeOutfitInfo(link));
	end
	for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		local numSlots = GetContainerNumSlots(bag);
		if (numSlots > 0) then
			-- check each slot in the bag
			for slot=1, numSlots do
				local link = GetContainerItemLink(bag, slot);
				if ( link ) then
					if ( FL:IsFishingPole(link) ) then
						tinsert(poles, MakeOutfitInfo(link));
					end
				end
			end
		end
	end
	return poles;
end

local function ODF_Initialize()
	IgnoredItems = {};
	IgnoredItems[118381] = true;
	for item,_ in pairs(FishingBuddy.FishingHats) do
		IgnoredItems[item] = true;
	end

	saved_outfit = GetFishingOutfit();
	FishingOutfitFrameTab.Outfit:SetOutfit(saved_outfit);
end

-- the user has chosen us, make sure everything is set up the way we need
local function ODF_Choose(useme)
	if ( useme ) then
		FishingBuddy.EnableSubFrame("ManagedOutfits");
		FishingBuddy.ShowOptionsTab(FB_ODFConstants.OUTFITS_TAB);
	else
		FishingBuddy.DisableSubFrame("ManagedOutfits");
		FishingBuddy.HideOptionsTab(FB_ODFConstants.OUTFITS_TAB);
	end
end
FB_OutfitFrame.Choose = ODF_Choose;

local combatswitch = false;
local wasfishing = false;

-- only have one outfit at the moment
-- don't switch if
-- we can't find everything in the outfit
-- we have saved stuff but we're not wearing everything in the outfit
-- We don't have the outfit display frame!
local function ODF_Switch()
	if (CursorHasItem()) then
		FishingBuddy.UIError(FB_ODFConstants.CURSORBUSYMSG);
		return false;
	end
	if ( FishingOutfitFrameTab.Outfit:IsSwapping() ) then
		FishingBuddy.UIError(OUTFITDISPLAYFRAME_TOOFASTMSG);
		return false;
	end
	
	local isfishing = FL:IsFishingPole();
	local outfit = GetFishingOutfit();
	local waswearing = GetWasWearing();
	if ( waswearing ) then
		local msg;
		
		if ( isfishing or combatswitch) then
			msg = FishingOutfitFrameTab.Outfit:SwitchWillFail(waswearing);
		else
			msg = FB_ODFConstants.CANTSWITCHBACK;
			SetWasWearing(nil);
		end
		
		if ( msg ) then
			FishingBuddy.UIError(msg);
			return isfishing;
		end
		combatswitch = false;

		local check = FishingOutfitFrameTab.Outfit:SwitchOutfit(waswearing);
		if ( check ) then
			SetWasWearing(nil);
		end
		return false; -- expect no pole
	elseif ( outfit ) then
		local msg;

		if ( not isfishing ) then
			msg = FishingOutfitFrameTab.Outfit:SwitchWillFail(outfit);
		elseif ( FishingOutfitFrameTab.Outfit:IsWearing(outfit) ) then
			msg = FB_ODFConstants.POLEALREADYEQUIPPED;
		end

		if ( msg ) then
			FishingBuddy.UIError(msg);
			return isfishing;
		end
		
		-- we don't want to update the original table
		outfit = FL:copytable(outfit);

		-- do we have an Ephemeral Pole?
		if (GetItemCount(118381) > 0) then
			local _, link, _, _, _, _, _, _, _, _, _ = GetItemInfo(118381) 
			outfit["MainHandSlot"] = MakeOutfitInfo(link);
			outfit["SecondaryHandSlot"] = { used=true, forced=true, empty=true };
		-- do we need to pick a random pole this time?
		elseif (GetSettingBool("AnyPole")) then
			local poles = FindFishingPoles();
			if ( #poles > 0 ) then
				local pick = random(1,#poles);
				outfit["MainHandSlot"] = poles[pick];
				outfit["SecondaryHandSlot"] = { used=true, forced=true, empty=true };
			end
		end

		-- 89401 Angler's Tabard
		if (GetItemCount(89401) > 0 and GetSettingBool("UseTabard")) then
			local _, link, _, _, _, _, _, _, _, _, _ = GetItemInfo(89401) 
			outfit["TabardSlot"] = MakeOutfitInfo(link);
		else
			outfit["TabardSlot"] = nil;
		end
		
		local waswearing = FishingOutfitFrameTab.Outfit:SwitchOutfit(outfit);
		if ( waswearing ) then
			SetWasWearing(waswearing);
		end
		return true; -- expect a fishing pole
	else
		FishingBuddy.UIError(FB_ODFConstants.NOOUTFITDEFINED);
		return isfishing; -- expect whatever we had before
	end
end

local updateWait = DEFAULTUPDATE_WAIT;
FB_OutfitFrame.Update = function(self, elapsed)
	updateWait = updateWait - elapsed;
	if ( updateWait <= 0 ) then
		UpdateSwitchButton(saved_outfit);
		UpdateStyleInfo(saved_outfit);
		FishingOutfitFrameTab.Update:Hide();
	end
end

local function CustomTooltip(button)
  if ( button and button.item ) then
	 local _,_, check, enchant = string.find(button.item, "^(%d+):(%d+)");
	 local points = FishingBuddy.OutfitManager.ItemStylePoints(check, enchant);
	 if ( points > 0 ) then
		 GameTooltip:AddLine(StyleString(true, points));
	 end
  end
end

local function OutfitChanged(button)
	local outfit = FishingOutfitFrameTab.Outfit:GetOutfit();
	if ( outfit ) then
		KeepOutfit(outfit);
	end
	updateWait = DEFAULTUPDATE_WAIT;
	FishingOutfitFrameTab.Update:Show();
end

local function EquipOutfitItem(outfit, item, slot)
	if (outfit[item] and outfit[item].item) then
		EquipItemByName("item:"..outfit[item].item, slot)
	end
end

local FishingEvents = {};
FishingEvents["VARIABLES_LOADED"] = function()
	if ( not FBODF_PlayerInfo ) then
		FBODF_PlayerInfo = {};
		FBODF_PlayerInfo["Outfit"] = {};
	end
	if ( FishingBuddy_Player and FishingBuddy_Player["Outfit"] ) then
		for k,v in pairs(FishingBuddy_Player["Outfit"]) do
			FBODF_PlayerInfo["Outfit"][k] = v;
		end
		FishingBuddy_Player["Outfit"] = nil;
		for k,v in pairs(FBODF_PlayerInfo["Outfit"]) do
			if (v.item) then
				local _,_, id, item = string.find(v.item, "(%d+)(:%d+)");
				FBODF_PlayerInfo["Outfit"][k].item = id..item;
			end
		end
	end
	-- Handle the override
	LibStub("OutfitDisplay-1.0"):InitFrame(FishingOutfitFrameTab.Outfit);

	FishingBuddy.OutfitManager.RegisterManager("OutfitDisplayFrame",
												ODF_Initialize,
												ODF_Choose,
												ODF_Switch);

	local groups = {}
	tinsert(groups, {
		["name"] = FB_ODFConstants.OUTFITS_TAB,
		["icon"] = "Interface\\Icons\\INV_Shirt_14",
		["frame"] = FishingOutfitFrameTab
	})
	-- Need to do this after we handle the translations
	local optionstab = {
		["name"] = FBConstants.OPTIONS_TAB,
		["tooltip"] = FBConstants.OPTIONS_INFO,
		["icon"] = 133153,
		["options"] = OutfitOptions
	}
	FishingBuddy.CreateManagedFrameGroup(FB_ODFConstants.OUTFITS_TAB,
										FB_ODFConstants.OUTFITS_INFO,
										"_OUT",
										groups,
										optionstab);
end

FishingEvents["PLAYER_REGEN_DISABLED"] = function(event, ...)
	if ( not combatswitch and FL:IsFishingPole() ) then
		-- okay, bad guys -- switch in weapons
		local waswearing = GetWasWearing();
		if ( waswearing ) then
			combatswitch = true;
			EquipOutfitItem(waswearing, "MainHandSlot", mainhandslot);
			EquipOutfitItem(waswearing, "SecondaryHandSlot", offhandslot);
		end
		combatswitch = true;
	end
end
	
FishingEvents["PLAYER_REGEN_ENABLED"] = function()
	if ( combatswitch and not FL:IsFishingPole()) then
		-- go back to fishing
		local fishing = GetFishingOutfit();
		EquipOutfitItem(fishing, "MainHandSlot", mainhandslot);
		EquipOutfitItem(fishing, "SecondaryHandSlot", offhandslot);
	end
	combatswitch = nil;
end

FB_OutfitFrame.OnShow = function(self)
	ODF_Initialize();
	FishingOutfitFrameTab.Outfit:SwitchWillFail(saved_outfit);
	UpdateSwitchButton(saved_outfit);
end

FB_OutfitFrame.OnLoad = function(self)
	FishingOutfitSkill.tooltip = FB_ODFConstants.CONFIG_SKILL_INFO;
	FishingOutfitStyle.tooltip = FB_ODFConstants.CONFIG_STYLISH_INFO;
	FishingOutfitFrameTab.Switch:SetText(FB_ODFConstants.SWITCHOUTFIT);
	FishingOutfitFrameTab.Switch.tooltip = FB_ODFConstants.SWITCHOUTFIT_INFO;
	self.CustomTooltip = CustomTooltip;
	RegisterHandlers(FishingEvents);

	FishingOutfitFrameTab.Outfit.OutfitChanged = OutfitChanged;
	FishingBuddyFrameCloseButton:SetFrameLevel(self:GetFrameLevel()+4)
end

FB_OutfitFrame.OnHide = function()
	-- OutfitChanged();
end

FB_OutfitFrame.Button_OnClick = function()
	-- make sure we have the current state
	KeepOutfit(FishingOutfitFrameTab.Outfit:GetOutfit());
	ODF_Switch();
end

if ( FishingBuddy.Debugging ) then
	-- outfit debugging functions
	FishingBuddy.Commands["outfit"] = {};
	FishingBuddy.Commands["outfit"].func =
		function(what)
		  if ( what and LibStub("OutfitDisplay-1.0") ) then
			 if ( what == FBConstants.RESET ) then
				SetWasWearing(nil);
				KeepOutfit(nil);
				FishingOutfitFrameTab.Outfit:SetOutfit({});
			 elseif ( what == "wearing" ) then
			 	FishingBuddy.Debug("===============");
				FishingBuddy.Dump(GetWasWearing());
			 elseif ( what == "dump" ) then
				FishingBuddy.Debug("Outfit");
				FishingBuddy.Dump(GetFishingOutfit());
				FishingBuddy.Debug("Was Wearing");
				FishingBuddy.Dump(GetWasWearing());
				FishingBuddy.Debug("Outfit");
				FishingBuddy.Dump(GetFishingOutfit());
				FishingBuddy.Debug("Saved");
				FishingBuddy.Dump(saved_outfit);
			 end
		  end
		  return true;
		end;

	-- DEBUG
	FB_OutfitFrame.GetFishingOutfit = GetFishingOutfit;
	-- Debugging
	FB_OutfitFrame.MakeFishingOutfit = MakeFishingOutfit;
end

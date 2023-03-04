--[[
Name: OutfitDisplay-1.0
Author(s): Sutorix <sutorix@hotmail.com>
Description: Use LibStub to lower namespace pollution and add some encapsulation
--]]

local MAJOR_VERSION = "OutfitDisplay-1.0"
local MINOR_VERSION = 1

if not LibStub then error(MAJOR_VERSION .. " requires LibStub") end

local ODFLib, oldLib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not ODFLib then
	return
end

local FL = LibStub("LibFishing-1.0");

local SavedPickupContainerItem = nil;
local SavedPickupInventoryItem = nil;

local LastOffSource = nil;

local function tonil(val)
	if ( not val ) then
		return "nil";
	else
		return val;
	end
end

local function Print(msg, r, g, b)
	if ( DEFAULT_CHAT_FRAME ) then
		if ( not r ) then
			DEFAULT_CHAT_FRAME:AddMessage(msg);
		else
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
		end
	end
end

-- Based on code in QuickMountEquip
local hooked_functions = {}
local function SafeHookFunction(func, newfunc)
	if ( type(newfunc) == "string" ) then
		newfunc = _G[newfunc];
	end
	if ( C_Container[func] ) then
		if ( C_Container[func] ~= newfunc ) then
			hooksecurefunc(C_Container, func, newfunc);
			return true;
		end
	elseif _G[func] ~= newfunc then
		hooksecurefunc(func, newfunc);
		return true;
	end
	return false;
end

local function GetSlotButton(button, slotName)
	local parent = button:GetParent();
	return parent[slotName];
end

local function IsBodySlotOneHanded(bodyslot)
	if ( bodyslot == "INVTYPE_2HWEAPON" or bodyslot == INVTYPE_2HWEAPON ) then
		return false;
	end
	return true;
end

local function IsItemOneHanded(item)
	if ( item ) then
		local _, _, _, _, _, _, _, _, bodySlot, _ = GetItemInfo("item:"..item);
		return IsBodySlotOneHanded(bodyslot);
	end
	return true;
end

local function SmartCursorCanGoInSlot(button)
	if ( button.forced or not button.slotid or not CursorCanGoInSlot(button.slotid)) then
		return false;
	end
	local secondary = GetSlotButton(button, "SecondaryHandSlot");
	local mainbutton = GetSlotButton(button, "MainHandSlot");
	if ( button == secondary and mainbutton and mainbutton.item ) then
		return IsItemOneHanded(mainbutton.item);
	end
	return CursorCanGoInSlot(button:GetID())
end

-- much hackery to know what actually is in the cursor when somebody drops it on us
local OD_Track_Bag = nil;
local OD_Track_Slot = nil;

-- whatever we think the user picked up, apply it to our stuff
local function AcceptCursorItem(button)
	local parent = button:GetParent();
	local _,_,slotnames = FL:GetSlotInfo();
	if ( not SmartCursorCanGoInSlot(button) ) then
		button = nil;
		for _,si in ipairs(slotnames) do
			local temp = parent[si.name];
			if ( temp and SmartCursorCanGoInSlot(temp) ) then
				button = temp;
			end
		end
	end
	if ( button ) then
		local link, texture;
		if ( OD_Track_Bag ) then
			link = C_Container.GetContainerItemLink(OD_Track_Bag, OD_Track_Slot);
			texture = C_Container.GetContainerItemInfo(OD_Track_Bag, OD_Track_Slot).iconFileID;
		else
			link = GetInventoryItemLink("player", OD_Track_Slot);
			texture = GetInventoryItemTexture("player", OD_Track_Slot);
		end
		button.link = link;
		button.color, button.item, button.name = FL:SplitLink(link);
		button.texture = texture;
		button.used = true;
		button.empty = nil;
		button.missing = nil;
		OutfitDisplayItemButton_Change(button);
	end

	-- clear the cursor item
	if ( OD_Track_Bag ) then
		SavedPickupContainerItem(OD_Track_Bag, OD_Track_Slot);
	elseif ( OD_Track_Slot ) then
		SavedPickupInventoryItem(OD_Track_Slot);
	end
	OD_Track_Bag = nil;
	OD_Track_Slot = nil;
end

-- figure out what the user picked up, so that if they drop it on us we can deal with it
local function ODF_PickupContainerItem(bag, slot)
	OD_Track_Bag = bag;
	OD_Track_Slot = slot;
end

local function ODF_PickupInventoryItem(slot)
	OD_Track_Bag = bag;
	OD_Track_Slot = slot;
end

local function UpdateModel_ThisSlot(parent, model, idx)
	local _,_,slotnames = FL:GetSlotInfo();
	local slotName = slotnames[idx].name;
	local slotID = slotnames[idx].id;
	local what = parent[slotName];
	local link = nil;
	if ( what and what.used ) then
		if ( not what.empty ) then
			link = "item:"..what.item;
			model:TryOn(link, slotName);
		end
	else
		local link = GetInventoryItemLink("player", slotID)
		if ( link ) then
			model:TryOn(link);
		end
	end
end

-- look for the outfit anywhere we can find it
-- we should look in the bank someday
local function FindOutfit(self, outfit)
	-- look for every item, if we find everything return a table of locations
	-- otherwise don't return anything
	if ( not outfit ) then
		return nil;
    end
    local dups = {};
	for slotName in pairs(outfit) do
        if ( outfit[slotName].used and not outfit[slotName].empty ) then
            if dups[outfit[slotName].item] == nil then
                dups[outfit[slotName].item] = 0;
            else
                dups[outfit[slotName].item] = dups[outfit[slotName].item] + 1;
            end
        end
    end

	local spots = { };
	for slotName in pairs(outfit) do
        if ( outfit[slotName].used and not outfit[slotName].empty ) then
			if outfit[slotName].item then
				local skipcount = dups[outfit[slotName].item];
				local bag, slot = FL:FindThisItem( outfit[slotName].item, skipcount );
				if ( not bag and not slot ) then
					spots = nil;
					return nil;
				else
					spots[slotName] = { };
					spots[slotName].bag = bag;
					spots[slotName].slot = slot;
				end
				if skipcount > 0 then
					dups[outfit[slotName].item] = skipcount - 1;
				end
			end
		end
	end
	return spots;
end

local function FreespaceCheck(bagtype)
	local totalFree = 0;
	for i = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		freeSlots, bagFamily = C_Container.GetContainerNumFreeSlots(i);
		if ( bagFamily == 0 or (bagtype and bagFamily == bagtype)) then
			totalFree = totalFree + freeSlots;
		end
	end
	return totalFree;
end

local function CheckSwitchWillFail(outfit)
	local nospace = false;
	local missing = false;
	local _,_,slotnames = FL:GetSlotInfo();
	for _,si in ipairs(slotnames) do
		local slotName = si.name;
		local slotempty = (GetInventoryItemLink("player", si.slotID) == nil);
		local check;
		if ( outfit ) then
			check = outfit[slotName];
		else
			check = nil;
		end
		if ( check and check.used ) then
			if ( not check.empty and check.item ) then
				local bag, slot = FL:FindThisItem( check.item );
				if ( not bag and not slot ) then
					missing = true;
					check.missing = true;
				else
					check.missing = nil;
				end
			else
				if ( not slotempty ) then
					local bagtype = GetItemFamily( check.item );
					if ( FreespaceCheck(bagtype) == 0 ) then
						nospace = true;
					end
				end
			end
		end
	end
	if ( missing ) then
		return OUTFITDISPLAYFRAME_ITEMSNOTFOUND;
	end
	if ( nospace ) then
		return OUTFITDISPLAYFRAME_NOTENOUGHFREESPACE;
	end
	return nil;
end

local function GetSlotContents(slotName, returnEmpty)
	if ( slotName ~= "Options" ) then
		local slot = GetInventorySlotInfo(slotName);
		local link = GetInventoryItemLink("player", slot);
		if ( link ) then
			local contents = {};
			local color, item, name = FL:SplitLink(link);
			contents.item = item;
			contents.name = name;
			contents.color = color;
			contents.texture = texture;
			contents.used = true;
			return contents;
		end
	end
	-- return nil;
end

local function MatchWornItems(check)
	local wearing = {};
	if ( check ) then
		-- lets put the bag and slot we're getting the replacement items from
		-- this means fishing gear will go back where it was (in a fishing bag, say)
		local spots = FindOutfit(nil, check);
		for slotName in pairs(check) do
			wearing[slotName] = GetSlotContents(slotName);
			if ( wearing[slotName] and spots[slotName] ) then
				 wearing[slotName].bag = spots[slotName].bag;
				 wearing[slotName].slot = spots[slotName].slot;
			end
		end
		-- make sure we pick up the off hand if we're going to put something
		-- two-handed in the main hand slot
		local mainhand = check["MainHandSlot"];
		local offhand = wearing["SecondaryHandSlot"];
		if ( not offhand and mainhand and not IsItemOneHanded(mainhand.item) ) then
			wearing["SecondaryHandSlot"] = GetSlotContents("SecondaryHandSlot");
		end
	else
		local _,_,slotnames = FL:GetSlotInfo();
		for _,si in ipairs(slotnames) do
			local slotName = si.name;
			wearing[slotName] = GetSlotContents(slotName);
		end
	end

	return wearing;
end

local function FindEmptyBagSlot(family, skipbag, skipcount)
	-- no affinity, check all bags
	for i=NUM_BAG_SLOTS,BACKPACK_CONTAINER,-1 do
		-- but skip any bag we already have affinity for (because it might have
		-- already modified skipcount)
		if ( not skipbag or skipbag ~= i ) then
			-- Make sure this bag can hold what we need
			local freeSlots, bagType = C_Container.GetContainerNumFreeSlots(i);
			if bagType and ( (family == 0) or (bit.band(bagType, family) > 0) ) then
				if ( freeSlots > skipcount ) then
					for j=C_Container.GetContainerNumSlots(i),1,-1 do
						if not C_Container.GetContainerItemInfo(i,j) then
							 if skipcount == 0 then return i, j, skipcount; end
							 skipcount = skipcount - 1;
						 end  -- if empty
					 end  -- for slots
				else
					skipcount = skipcount - freeSlots;
				end -- free slots
			end -- if this is a bag than can hold anything
		end -- if not affinity bag
	end  -- for bags
	return nil, nil, skipcount;
end

local function FindLastEmptyBagSlot(link, skipcount, bag_affinity, slot_affinity)
	local prefbag = 0;
	if ( link ) then
		prefbag = GetItemFamily( link );
	end

	skipcount = skipcount or 0;

	-- try to put the item in the requested affinity, if possible
	if bag_affinity and slot_affinity and
			not C_Container.GetContainerItemInfo(bag_affinity, slot_affinity) then
		return bag_affinity, slot_affinity;
	end

	-- if we couldn't get the bag and slot we wanted, just try the same bag
	if ( bag_affinity ) then
		local freeSlots, bagType = C_Container.GetContainerNumFreeSlots(bag_affinity);
		if ( ((prefbag > 0) and (bit.band(prefbag, bagType) > 0)) or bagType == 0 ) then
			if freeSlots > skipcount then
				for j=C_Container.GetContainerNumSlots(bag_affinity),1,-1 do
					if not C_Container.GetContainerItemInfo(bag_affinity,j) then
						if skipcount == 0 then return bag_affinity,j; end
						skipcount = skipcount - 1;
					end -- if free space
				end -- for slots
			else
				skipcount = skipcount - freeSlots;
			end -- free slots
		end
	end

	-- look for preferred bags first
	if ( prefbag ~= 0 ) then
		local i,j,s = FindEmptyBagSlot(prefbag, bag_affinity, skipcount);
		if ( i ) then
			return i,j;
		end
		skipcount = s;
	end

	-- didn't find anything, or no preference, look for general bags
	return FindEmptyBagSlot(0, bag_affinity, skipcount);
end

-- okay, let's switch to the specified outfit
-- code liberally borrowed from "WeaponQuickSwap - by CapnBry"

-- list functions
local function swapentry_print(entry)
	if ( DEFAULT_CHAT_FRAME ) then
		local msg = "Entry "..tonil(entry.sb)..","..tonil(entry.si)..","..tonil(entry.db)..","..tonil(entry.di);
		DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0,0,0);
	end
end

local function swaplist_print(list)
	while ( list ) do
		swapentry_print(list);
		list = list.next;
	end
end

local function swaplist_push(list, sb, si, db, di)
	list = { next = list, sb = sb, si = si, db = db, di = di };
	return list;
end

local function swaplist_popfirst(list)
	if not list then return; end
	list = list.next;
	return list;
end

-- Unit variable to hold the stack of swaps
local outfitswap = nil;

local function IsItemLocked(bag, slot)
	if not bag and not slot then
		return false;
	end

	if not bag then
		return IsInventoryItemLocked(slot);
	else
		local _,_,locked = C_Container.GetContainerItemInfo(bag,slot);
		return locked;
	end
end

local function IsAnyItemLocked()
-- Checks all the bags and the equipped slots to see if any are still locked
	for i = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		for j=1,C_Container.GetContainerNumSlots(i) do
			local _,_,locked = C_Container.GetContainerItemInfo(i,j);
			if ( locked ) then
				return true;
			end
		end
	end
	local _,_,slotnames = FL:GetSlotInfo();
	for _,si in ipairs(slotnames) do
		if ( IsInventoryItemLocked(si.id) ) then
			return true;
		end
	end
	return false;
end

local swapframe = CreateFrame("FRAME");
swapframe:Hide();

local function IsSwapping(self)
	if ( outfitswap or IsAnyItemLocked() ) then
		return true;
	else
		return false;
	end
end

local function ExecuteSwapIteration()
	if not outfitswap then
		return;
	end

	if ( IsItemLocked(outfitswap.sb, outfitswap.si) or
		  IsItemLocked(outfitswap.db, outfitswap.di) ) then
		swapframe:Show();
		return;
	end

	if not outfitswap.sb then
		SavedPickupInventoryItem(outfitswap.si);
	else
		SavedPickupContainerItem(outfitswap.sb, outfitswap.si);
	end

	if not outfitswap.db then
		if not outfitswap.di then
			PutItemInBackpack();
		else
			SavedPickupInventoryItem(outfitswap.di);
		end
	else
		SavedPickupContainerItem(outfitswap.db, outfitswap.di);
	end

	local beslow = outfitswap.slowdown;
	outfitswap = swaplist_popfirst(outfitswap);
	if ( outfitswap ) then
		if ( not beslow ) then
			return ExecuteSwapIteration();
		else
			swapframe:Show();
		end
	end
end

swapframe:SetScript("OnUpdate",
	function(self)
		if ( not outfitswap or not outfitswap.slowdown ) then
			self:Hide();
		end

		if ( not outfitswap ) then
			return;
		end

		 ExecuteSwapIteration();
	end)

local PerformSlowerSwap = false;
local function SwitchToBag(outfit, slotName, invslot, skipcount)
    local bag_affinity = outfit[slotName].bag;
	if ( bag_affinity ) then
		local slot_affinity = outfit[slotName].slot;
		-- we need to put these somewhere special, if it's empty, or there's one in the same bag
		local link = GetInventoryItemLink("player", invslot);
		local dbag, dslot = FindLastEmptyBagSlot(link, skipcount, bag_affinity, slot_affinity);
		if ( dbag and dbag == bag_affinity ) then
			outfitswap = swaplist_push(outfitswap, nil, invslot, dbag, dslot);
			outfitswap.slowdown = true;
			PerformSlowerSwap = true
			skipcount = skipcount + 1;
		end
	end
	return skipcount;
end

local function SwitchOneItem(outfit, index, skipcount)
	local _,_,slotnames = FL:GetSlotInfo();
	local slotName = slotnames[index].name;
	if ( outfit and outfit[slotName] ) then
		local invslot = GetInventorySlotInfo(slotName);
		if ( outfit[slotName].empty ) then
			local link = GetInventoryItemLink("player", invslot);
			-- if they're both empty, we don't have to do anything
			if (link) then
				local bag, slot = FindLastEmptyBagSlot(link, skipcount, outfit[slotName].bag, outfit[slotName].slot);
				outfitswap = swaplist_push(outfitswap, nil, invslot, bag, slot);
				skipcount = skipcount + 1;
			end
		else
			local bag, slot = FL:FindThisItem( outfit[slotName].item );
			-- either we couldn't find it, or it's where it should be
			if ( bag ~= nil or slot ~= invslot ) then
				outfitswap = swaplist_push(outfitswap, bag, slot, nil, invslot);

				-- remember things are backwards, we want to move out first, so push it on the top of the stack
				skipcount = SwitchToBag(outfit, slotName, invslot, skipcount);
			end
		end
	end
	return skipcount;
end

local function OnSwapError(error)
	outfitswap = nil;
	if ( UIErrorsFrame ) then
		UIErrorsFrame:AddMessage(error, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
	end
	return;
end

local mainhandslot = GetInventorySlotInfo("MainHandSlot");
local secondaryslot = GetInventorySlotInfo("SecondaryHandSlot");
local function SwitchOutfit(self, outfit)
	if ( CursorHasItem() or IsSwapping() ) then
		return OnSwapError(OUTFITDISPLAYFRAME_TOOFASTMSG);
	end
	local msg = CheckSwitchWillFail(outfit);
	if ( msg ) then
		return OnSwapError(msg);
	end

	local name, _, _, _, _, _, notInterruptible, spellId = UnitChannelInfo("player")
	if name then
		return OnSwapError(OUTFITDISPLAYFRAME_CASTINGMSG);
	end

	-- need to check to see that we have enough room
    local old = MatchWornItems(outfit);

	PerformSlowerSwap = false;

	-- do everything except weapon slots
	local skipcount = 0;
	for i=1,16,1 do
		skipcount = SwitchOneItem(outfit, i, skipcount);
	end

	if ( not outfit["MainHandSlot"] and not outfit["SecondaryHandSlot"] ) then
		ExecuteSwapIteration();
		return old;
	end

	local mainitem = GetInventoryItemLink("player", mainhandslot);
	local offitem = GetInventoryItemLink("player", secondaryslot);

	local mainhand = outfit["MainHandSlot"];
	local offhand = outfit["SecondaryHandSlot"];

	-- now do hands
	local m_sb;
	local m_si;
	local o_sb;
	local o_si;
	local m_ok = not mainhand or not mainhand.item;
	local o_ok = not offhand or not offhand.item;

	if ( mainhand and mainhand.item ) then
		m_sb, m_si = FL:FindThisItem(mainhand.item);
		m_ok = ( not m_sb and m_si == mainhandslot );
	end
	if ( offhand and offhand.item ) then
		local multiples = 0;
		if ( mainhand and mainhand.item == offhand.item ) then
			multiples = 1;
		end
		o_sb, o_si = FL:FindThisItem( offhand.item, multiples);
		o_ok = ( not o_sb and o_si == secondaryslot );
	end

	if ( not m_ok ) then
		-- do we need two of these?
		if ( o_ok and not m_sb and m_si == secondaryslot ) then
			m_sb, m_si = FL:FindThisItem( mainhand.item, 1);
		end
	end

	-- moving from bags
	if ( m_sb and o_sb ) then
		-- insert them backwards, since they get popped off
		-- main hand has to get done first in case it's currently
		-- a two hander
		outfitswap = swaplist_push(outfitswap, o_sb, o_si, nil, secondaryslot);
		-- remember things are backwards, we want to move out first, so push it on the top of the stack
		skipcount = SwitchToBag(outfit, "SecondaryHandSlot", secondaryslot, skipcount);
		outfitswap = swaplist_push(outfitswap, m_sb, m_si, nil, mainhandslot);
		skipcount = SwitchToBag(outfit, "MainHandSlot", mainhandslot, skipcount);
	elseif ( not m_sb and m_si == secondaryslot and not o_sb and o_si == mainhandslot ) then
		outfitswap = swaplist_push(outfitswap, nil, mainhandslot, nil, secondaryslot);
		skipcount = SwitchToBag(outfit, "SecondaryHandSlot", secondaryslot, skipcount);
	else
		-- Install main hand
		if not m_ok then
			-- if nothing going to the main hand
			if ( not m_sb and not m_si ) then
				-- and the main is not going to the off: put it in a bag
				if not ( not o_sb and o_si == mainhandslot) then
					local bb, bi = FindLastEmptyBagSlot(mainhand.item, skipcount);
					skipcount = skipcount + 1;
					outfitswap = swaplist_push(outfitswap, nil, mainhandslot, bb, bi);
                    skipcount = SwitchToBag(outfit, "MainHandSlot", mainhandslot, skipcount);
					-- when moving A,"" -> "",B where A is a 2h, the offhand
					-- doesn't lock properly, so work around it by swapping
					-- slowly (only one swap per lock notify)
					PerformSlowerSwap = PerformSlowerSwap or not IsItemOneHanded(mainhand.item);
					outfitswap.slowdown = PerformSlowerSwap;
				end
			else
				outfitswap = swaplist_push(outfitswap, m_sb, m_si, nil, mainhandslot);
                skipcount = SwitchToBag(outfit, "MainHandSlot", mainhandslot, skipcount);
				if (not IsItemOneHanded(mainhand.item) and IsItemOneHanded(mainitem)) then
					-- empty the offhand slot first
					local eb, ei = FindLastEmptyBagSlot(offhand.item, skipcount);
					skipcount = skipcount + 1;
					outfitswap = swaplist_push(outfitswap, nil, secondaryslot, eb, ei);
                    skipcount = SwitchToBag(outfit, "SecondaryHandSlot", secondaryslot, skipcount);
				end
			end
		end

		-- Load offhand if not already there
		if not o_ok then
			if ( not o_sb and not o_si ) then
				if not (not m_sb and m_si == secondaryslot) then
					local bb, bi;
					if LastOffSource then
						bb, bi = FindLastEmptyBagSlot(offhand.item, skipcount,
																LastOffSource.bag, LastOffSource.slot);
					else
						bb, bi = FindLastEmptyBagSlot(offhand.item, skipcount);
					end
					skipcount = skipcount + 1;
					outfitswap = swaplist_push(outfitswap, nil, secondaryslot, bb, bi);
                    skipcount = SwitchToBag(outfit, "SecondaryHandSlot", secondaryslot, skipcount);
				end
			else
				-- if the main hand weapon is coming from the offhand slot
				-- we need to fix up its source to be where the offhand is
				-- GOING to be after the bag->off swap
				if outfitswap and ( not m_sb and m_si == secondaryslot) then
					outfitswap.sb = o_sb;
					outfitswap.si = o_si;
					-- don't set o_sb, o_si they're tested later
				end

				outfitswap = swaplist_push(outfitswap, o_sb, o_si, nil, secondaryslot);
                skipcount = SwitchToBag(outfit, "MainHandSlot", mainhandslot, skipcount);
			end
		end

-- Special Case: Moving off to main, and not main to off
-- This is because maybe the main hand weapon is main only
		if (not m_sb and m_si == secondaryslot) and not ( not o_sb and o_si == mainhandslot) then
			local bb, bi = FindLastEmptyBagSlot(mainhand.item, skipcount);
			skipcount = skipcount + 1;
			outfitswap = swaplist_push(outfitswap, nil, mainhandslot, bb, bi);
            skipcount = SwitchToBag(outfit, "MainHandSlot", mainhandslot, skipcount);
		end

		-- Same thing for off hand
		if (not o_sb and o_si == mainhandslot) and not (not m_sb and m_si == secondaryslot) then
			local bb, bi = FindLastEmptyBagSlot(offhand.item, skipcount);
			skipcount = skipcount + 1;
			outfitswap = swaplist_push(outfitswap, nil, mainhandslot, bb, bi);
            skipcount = SwitchToBag(outfit, "MainHandSlot", mainhandslot, skipcount);
		end

		if o_sb then
			LastOffSource = { bag = o_sb, slot = o_si };
		end
	end

	-- Start moving
	if ( PerformSlowerSwap ) then
		swapframe:Show();
	else
		ExecuteSwapIteration();
	end
	return old;
end

-- handle making the items in the outfit pane do nice things
local function ClearODFButton(button, empty, used)
	button.name = nil;
	button.item = nil;
	button.texture = nil;
	button.color = nil;
	button.missing = nil;
	button.forced = nil;
	button.empty = empty;
	button.used = used or empty;
end

function OutfitDisplayItemButton_OnEnter(self)
	if ( GameTooltip.finished ) then
		return;
	end
	GameTooltip.finished = 1;
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if (self.item) then
		local link = "item:"..self.item;
		if ( GetItemInfo(link) ) then
			GameTooltip:SetHyperlink(link);
		elseif ( self.name ) then
			GameTooltip:SetText(self.name);
		elseif ( self.tooltip ) then
			GameTooltip:SetText(self.tooltip);
		else
			GameTooltip:SetText("<unlinkable item>", 1, 0, 0);
		end
	elseif ( self.tooltip ) then
		GameTooltip:AddLine(self.tooltip);
	else
		local slotName = self.slotname;
		self.tooltip = slotName;
		GameTooltip:AddLine(self.tooltip);
	end
	local parent = self:GetParent();
	if ( parent.CustomTooltip ) then
		parent.CustomTooltip(self);
	end
	GameTooltip:AddLine(OUTFITDISPLAYFRAME_ALTCLICK,.8,.8,.8,1);
	GameTooltip:Show();
end

function OutfitDisplayItemButton_OnEvent(self, event)
	if ( event == "CURSOR_UPDATE" or event == "CURSOR_CHANGED" ) then
		if ( not self.forced ) then
			if (SmartCursorCanGoInSlot(self)) then
				self:LockHighlight();
			else
				self:UnlockHighlight();
			end
		end
	end
end

function OutfitDisplayItemButton_OnClick(self, clicked, ignoreModifiers)
	if ( clicked == "LeftButton" ) then
		if( not ignoreModifiers or ignoreModifiers == 0 ) then
			if ( IsShiftKeyDown() ) then
				if ( self.item ) then
					local color = self.color;
					if ( not color ) then
						color = "ffffffff";
					end
					local link = "|c"..color.."|Hitem"..self.item.."|h["..self.name.."]|h|r";
					ChatEdit_InsertLink(link);
					return;
				end
			elseif ( IsAltKeyDown() ) then
				ClearODFButton(self, false, false);
				OutfitDisplayItemButton_Change(self);
				return;
			end
		end
		-- fall through for drags and non-modified clicks
		if ( CursorHasItem() ) then
			AcceptCursorItem(self);
		end
	end
end

function OutfitDisplayItemButton_OnLoad(self)
	local parentlen = string.len(self:GetParent():GetName())+1;
	local slotName = strsub(self:GetName(), parentlen);
	local id;
    local textureName;

	id, textureName = GetInventorySlotInfo(slotName);
	self:SetID(id);
	self.backgroundTextureName = textureName;
	SetItemButtonTexture(self, self.backgroundTextureName);
	self:RegisterForDrag("LeftButton");
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");

	if FL:IsVanilla() then
		self:RegisterEvent("CURSOR_UPDATE");
	else
		self:RegisterEvent("CURSOR_CHANGED");
	end
	self:SetFrameLevel(self:GetFrameLevel()+3);
end

function OutfitDisplayItemButton_Draw(button)
	if ( button.texture ) then
		SetItemButtonTexture(button, button.texture);
	else
		SetItemButtonTexture(button, button.backgroundTextureName);
	end
	if ( button.missing ) then
		SetItemButtonTextureVertexColor(button, 1.0, 0.1, 0.1);
	else
		SetItemButtonTextureVertexColor(button, 1.0, 1.0, 1.0);
	end
	local checkbox = _G[button:GetName().."CheckBox"];
	if (checkbox) then
		local pname = button:GetParent():GetName();
		local showhelm = _G[pname.."ShowHelm"];
		local showcloak = _G[pname.."ShowCloak"];
		if ( button.forced ) then
			checkbox:SetChecked(true);
			checkbox:Disable();
			checkbox:Show();
		elseif ( button.empty or not button.used ) then
			if ( checkbox.slotName == "HeadSlot" ) then
				showhelm:Hide();
				showhelm:SetChecked(false);
			elseif ( checkbox.slotName == "BackSlot" ) then
				showcloak:Hide();
				showcloak:SetChecked(false);
			end
			checkbox:Enable();
			checkbox:SetChecked(button.empty);
			checkbox:Show();
		elseif ( button.used ) then
			checkbox:Hide();
			if ( checkbox.slotName == "HeadSlot" ) then
				showhelm:Show();
			elseif ( checkbox.slotName == "BackSlot" ) then
				showcloak:Show();
			end
		end
	end
end

function OutfitDisplayItemButton_Change(button)
	OutfitDisplayItemButton_Draw(button);
	-- handle two handed weapons
	local parent = button:GetParent();
	local slotName = button.slotname;
	if ( slotName == "MainHandSlot" ) then
		local secondary = parent["SecondaryHandSlot"];
		if ( not button.used and secondary.forced ) then
			ClearODFButton(secondary, false, false);
		elseif ( button.used and not IsItemOneHanded(button.item) ) then
			ClearODFButton(secondary, true);
			secondary.forced = true;
		end
		OutfitDisplayItemButton_Draw(secondary);
	end
	parent:UpdateMessage();
	parent:UpdateModel(button);
	if( parent.OutfitChanged ) then
		parent.OutfitChanged( button );
	end
end

-- override ShowHelm and ShowCloak
function OutfitDisplayOverrideBox_OnLoad(self)
	self.slotName = self:GetParent():GetName();
end

function OutfitDisplayOverrideBox_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	local text;
	if ( self.slotName == "ShowHelm" ) then
		text = OUTFITDISPLAYFRAME_OVERRIDEHELM;
	else
		text = OUTFITDISPLAYFRAME_OVERRIDECLOAK;
	end
	GameTooltip:SetText(text, nil, nil, nil, nil, 1);
	GameTooltip:Show();
end

function OutfitDisplayOverrideCheckBox_OnClick(self)
	local parent = self:GetParent();
	if( parent.OutfitChanged ) then
		parent.OutfitChanged( self );
	end
end

-- check box handling
function OutfitDisplayCheckBox_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(OUTFITDISPLAYFRAME_USECHECKBOX, nil, nil, nil, nil, 1);
	GameTooltip:Show();
end

function OutfitDisplayCheckBox_OnLoad(self)
	self.slotName = self:GetParent():GetName()
end

function OutfitDisplayCheckBox_OnClick(self)
	local button = self:GetParent();
	ClearODFButton(button, self:GetChecked());
	OutfitDisplayItemButton_Change(button);
end

-- client functions
local function SwitchWillFail(self, outfit)
	if ( InCombatLockdown() ) then
		return ERR_NOT_IN_COMBAT;
	end

	if ( not outfit ) then
		return OUTFITDISPLAYFRAME_INVALIDOUTFIT;
	end
	if ( not next(outfit) ) then
		return OUTFITDISPLAYFRAME_EMPTYOUTFIT;
	end
	-- if we're swapping, fail early
	if ( IsSwapping() ) then
		return OUTFITDISPLAYFRAME_TOOFASTMSG;
	end
	return CheckSwitchWillFail(outfit);
end

local function IsWearing(self, outfit)
	if ( not outfit ) then
		return false;
	end
	for slotName in pairs(outfit) do
		if ( outfit[slotName].used and not outfit[slotName].empty ) then
			local slot = GetInventorySlotInfo(slotName);
			local link = GetInventoryItemLink("player", slot);
			local foundit = false;
			if ( link ) then
				local color, item, name = FL:SplitLink(link);
				if ( item == outfit[slotName].item ) then
					foundit = true;
				end
			end
			if ( not foundit ) then
				return false;
			end
		end
	end
	return true;
end

local function UpdateMessage(self, outfit)
	if ( self ) then
		local msg;
		if ( outfit ) then
			msg = CheckSwitchWillFail(outfit);
		end
		local messages = _G[self:GetName().."Message"];
		if not messages then
			return
		end
		if ( msg ) then
			messages:SetText(msg);
			messages:Show();
		else
			messages:SetText("");
			messages:Hide();
		end
	end
end

local function UpdateModel(self, button)
	local model = self.Model;
	local empty = false;
	if ( not model ) then
		return;
	end
	if ( button and button.used ) then
		if ( button.empty and not button.forced ) then
			empty = true;
		end
	else
		local _,_,slotnames = FL:GetSlotInfo();
		for _,si in ipairs(slotnames) do
			local what = self[si.name];
			if ( what and what.empty ) then
				empty = true;
			end
		end
	end
	if ( empty ) then
		model:Undress();
	end
	for i=18,1,-1 do
		UpdateModel_ThisSlot(self, model, i);
	end
end

local function SetOutfit(self, outfit)
	if not outfit then
		return;
	end
	local pname = self:GetName();
	local _,_,slotnames = FL:GetSlotInfo();
	for _,si in ipairs(slotnames) do
		local slotName = si.name;
		local button = _G[pname..slotName];
		if ( button and outfit[slotName] and outfit[slotName].used ) then
			ClearODFButton(button);
			if ( outfit[slotName].used ) then
				button.name = outfit[slotName].name;
				button.item = outfit[slotName].item;
				button.texture = outfit[slotName].texture;
				button.color = outfit[slotName].color;
				button.missing = outfit[slotName].missing;
				button.forced = outfit[slotName].forced;
				button.empty = outfit[slotName].empty;
				button.used = true;
			else
				ClearODFButton(button, true, true);
			end
			OutfitDisplayItemButton_Draw(button);
		end
	end
	if ( outfit["Options"] ) then
		local showhelm = _G[pname.."ShowHelm"];
		local showcloak = _G[pname.."ShowCloak"];
		showhelm:SetChecked(outfit["Options"].helm);
		showcloak:SetChecked(outfit["Options"].cloak);
	end
	self:UpdateModel();
	self:UpdateMessage(outfit);
end

local function GetOutfit(self, puthere)
	local pname = self:GetName();
	local outfit = puthere or {};

	local _,_,slotnames = FL:GetSlotInfo();
	for _,si in ipairs(slotnames) do
		local slotName = si.name;
		local button = _G[pname..slotName];

		if ( button and button.used ) then
			outfit[slotName] = {};
			if ( not button.empty ) then
				outfit[slotName].name = button.name;
				outfit[slotName].item = button.item;
				outfit[slotName].texture = button.texture;
				outfit[slotName].color = button.color;
				outfit[slotName].missing = button.missing;
				outfit[slotName].forced = button.forced;
				outfit[slotName].link = button.link;
				outfit[slotName].slotid = button.slotid;
			end
			outfit[slotName].empty = button.empty;
			outfit[slotName].used = true;
		else
			outfit[slotName] = nil;
		end
	end

	if ( outfit ) then
		-- check for two-handed weapon
		local mainhand = outfit["MainHandSlot"];
		if ( mainhand and not IsItemOneHanded(mainhand.item) ) then
			outfit["SecondaryHandSlot"] = {};
			outfit["SecondaryHandSlot"].forced = true;
			outfit["SecondaryHandSlot"].empty = true;
			outfit["SecondaryHandSlot"].used = true;
		end
	end
	return outfit;
end

local function OutfitDisplayFrameModel_OnLoad(parent)
	local model = parent.Model;
	if (model) then
		Model_OnLoad(model);
		local race, fileName = UnitRace("player");
		local texture = DressUpTexturePath(fileName);
		model.BackgroundTopLeft:SetTexture(texture..1);
		model.BackgroundTopLeft:SetDesaturated(true);
		model.BackgroundTopRight:SetTexture(texture..2);
		model.BackgroundTopRight:SetDesaturated(true);
		model.BackgroundBotLeft:SetTexture(texture..3);
		model.BackgroundBotLeft:SetDesaturated(true);
		model.BackgroundBotRight:SetTexture(texture..4);
		model.BackgroundBotRight:SetDesaturated(true);

		-- HACK - Adjust background brightness for different races
		if ( strupper(fileName) == "BLOODELF") then
			model.BackgroundOverlay:SetAlpha(0.8);
		elseif (strupper(fileName) == "NIGHTELF") then
			model.BackgroundOverlay:SetAlpha(0.6);
		elseif ( strupper(fileName) == "SCOURGE") then
			model.BackgroundOverlay:SetAlpha(0.3);
		elseif ( strupper(fileName) == "TROLL" or strupper(fileName) == "ORC") then
			model.BackgroundOverlay:SetAlpha(0.6);
		elseif ( strupper(fileName) == "WORGEN" ) then
			model.BackgroundOverlay:SetAlpha(0.5);
		elseif ( strupper(fileName) == "GOBLIN" ) then
			model.BackgroundOverlay:SetAlpha(0.6);
		else
			model.BackgroundOverlay:SetAlpha(0.7);
		end

		model:RegisterEvent("DISPLAY_SIZE_CHANGED");
		model:RegisterEvent("UNIT_MODEL_CHANGED");
		model:RegisterEvent("PLAYER_ENTERING_WORLD");
	end
end

local function OutfitDisplayFrame_OnEvent(self, event, ...)
	local arg1 = ...;
	if (event == "ITEM_LOCK_CHANGED") and not arg1 then
		ExecuteSwapIteration();
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		self:RegisterEvent("ITEM_LOCK_CHANGED");
	elseif ( event == "PLAYER_LEAVING_WORLD" ) then
		self:UnregisterEvent("ITEM_LOCK_CHANGED");
	end
end

local function OutfitDisplayFrame_OnLoad(self)
	local temp = C_Container.PickupContainerItem;
	if ( SafeHookFunction("PickupContainerItem", ODF_PickupContainerItem) ) then
		SavedPickupContainerItem = temp;
	end

	temp = PickupInventoryItem;
	if ( SafeHookFunction("PickupInventoryItem", ODF_PickupInventoryItem) ) then
		SavedPickupInventoryItem = temp;
	end

	local _,_,slotinfo = FL:GetSlotInfo();
	for _, si in ipairs(slotinfo) do
		local button = self[si.name]
		if button then
			button.tooltip = si.tooltip;
			button.slotid = si.id;
			button.slotname = si.name;
			OutfitDisplayItemButton_Draw(button);
		end
	end

	-- ITEM_LOCK_CHANGED gets invoked a lot -- let's optimize it
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("PLAYER_LEAVING_WORLD");

--	Print(OUTFITDISPLAYFRAME_TITLE.." loaded.");
end

-- make self be the frame, add the external interface
function ODFLib:InitFrame(frame)
	-- we need to do the OnLoad stuff for this frame, since it didn't happen
	OutfitDisplayFrame_OnLoad(frame);
	OutfitDisplayFrameModel_OnLoad(frame);

	-- called by clients
	frame.SwitchWillFail = SwitchWillFail;
	frame.GetOutfit = GetOutfit;
	frame.SetOutfit = SetOutfit;
	frame.FindOufit = FindOutfit;
	frame.SwitchOutfit = SwitchOutfit;
	frame.IsSwapping = IsSwapping;
	frame.IsWearing = IsWearing;
	frame.UpdateMessage = UpdateMessage;

	-- called from ODF frame
	frame.UpdateModel = UpdateModel;
	frame:SetScript("OnEvent", OutfitDisplayFrame_OnEvent);

	return frame;
end

DressUpModelFrameMixin = {};
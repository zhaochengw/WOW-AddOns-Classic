--[[--
	by ALA @ 163UI
--]]--


--	Howto
--[==[
	local __addon, __private = ...;
	local MT = __private.MT;
	local CT = __private.CT;
	local VT = __private.VT;
	local DT = __private.DT;


	local mod = {  };
	--****	Define methods.

	MT.RegisterOnAddOnLoaded(ADDON_NAME, function()
		--****	Define other methods of mod. Those to do after addon loaded. (hot-plug)
		MT.FireCallback("AUCTION_MOD_LOADED", mod);
	end);
--]==]

--[==[
	MT.FireCallback("USER_EVENT_SPELL_DATA_LOADED");	--	Fire when data of all spells is cached.
	MT.FireCallback("USER_EVENT_ITEM_DATA_LOADED");		--	Fire when data of all items is cached.
	MT.FireCallback("USER_EVENT_RECIPE_LIST_UPDATE");	--	Fire when skill list updated or changed.

	MT.FireCallback(
		"AUCTION_MOD_LOADED",
		{
		--	must
			function F_QueryPriceByID(id, num)				return AHPrice;			--	nilable			--	must
			alias	query_ah_price_by_id

		--	optional.
			function F_OnDBUpdate(callback)					--	callback when price of new item add or refresh
			alias	add_cache_callback

			function F_QueryPriceByName(name, num)			return AHPrice;			--	nilable			--	not used actually
			alias	query_ah_price_by_name

		--	optional. built-in alternative method declared in AuctionBase.lua. Define here will override the build-in methods.
			function F_QueryVendorPriceByLink(link, num)	return VendorPrice;		--	nilable
			alias	get_material_vendor_price_by_link

			function F_QueryVendorPriceByID(id, num)		return VendorPrice;		--	nilable
			alias	get_material_vendor_price_by_id

			function F_QueryVendorPriceByName(name, num)	return VendorPrice;		--	nilable
			alias	get_material_vendor_price_by_name

			function F_QueryNameByID(id)					return name;			--	nilable
			alias	query_name_by_id

			function F_QueryQualityByID(id)					return quality;			--	nilable
			alias	query_quality_by_id
		}
	);
	MT.FireCallback(
		"UI_MOD_LOADED",
		{
			function Skin(addon, frame),
		}
	);
	MT.FireCallback(
		"RECIPESOURCE_MOD_LOADED",
		{
			function Tip(Tip, SpellID),
			function SetItem (Tip, pid, itemID, label, stack_size),
			function SetUnit(Tip, pid, unitID, label, isAlliance, prefix, suffix, stack_size),
			function SetObject(Tip, pid, objectID, label, stack_size),
			function SetQuest(Tip, pid, questID, label, stack_size),
		}
	);
--]==]

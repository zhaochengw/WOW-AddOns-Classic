--[[--
	by ALA 
--]]--


--	Howto
--	实际并不需要放进alaTradeSkill的文件夹中，在哪儿都行
--	Actually, the file doesn't have to be placed under the folder alaTradeSkill. Put it whereever u want.
--	
--	使用 `name = mod.F_QueryNameByID(ItemID)` 而不是 `GetItemInfo(ItemID)` 以保证结果	模块注册时，会自动添加 `mod.F_QueryNameByID` 函数
--	alaTradeSkill会缓存所有商业技能涉及到的物品信息，而 `GetItemInfo` 在密集获取时会返回nil，即使曾经访问过的物品
--	using `name = mod.F_QueryNameByID(ItemID)` instead of `GetItemInfo(ItemID)`		`mod.F_QueryNameByID` is implemented by alaTradeSkill automatically.
--	alaTradeSkill manages a cache table that contains all related items. `GetItemInfo` may return nil when busy.
--[==[
	local __addon, __private = ...;				--	放入alaTradeSkill
	-- local __private = __ala_meta__.prof;		--	外部
	local MT = __private.MT;
	local CT = __private.CT;
	local VT = __private.VT;
	local DT = __private.DT;


	local mod = {  };
	--****	Define methods.
		--	must
			function mod.F_QueryPriceByID(id, num)				return AHPrice;			--	nilable			--	must

		--	optional.
			-- function mod.F_OnDBUpdate(callback)					--	callback when price of new item add or refresh	--	当拍卖插件的价格数据更新
			-- function mod.F_QueryPriceByName(name, num)			return AHPrice;			--	nilable			--	not used actually

		--	optional. built-in alternative method declared in AuctionBase.lua. Define here will override the build-in methods.
		--	可选。 alaTradeSkill内置以下函数。在此定义将覆盖内置函数
			function mod.F_QueryVendorPriceByLink(link, num)	return VendorPrice;		--	nilable
			function mod.F_QueryVendorPriceByID(id, num)		return VendorPrice;		--	nilable
			function mod.F_QueryVendorPriceByName(name, num)	return VendorPrice;		--	nilable
			function mod.F_QueryNameByID(id)					return name;			--	nilable
			function mod.F_QueryQualityByID(id)					return quality;			--	nilable

	MT.RegisterOnAddOnLoaded(ADDON_NAME, function()
		--****	Define other methods of mod. Those to do after addon loaded. (hot-plug)
		--	拍卖插件加载后的行为		
		MT.FireCallback("AUCTION_MOD_LOADED", mod);
	end);
--]==]

--[==[
	MT.FireCallback("USER_EVENT_SPELL_DATA_LOADED");	--	Fire when data of all spells is cached.		--	所有商业技能相关的技能信息缓存完成后触发
	MT.FireCallback("USER_EVENT_ITEM_DATA_LOADED");		--	Fire when data of all items is cached.		--	所有商业技能相关的物品信息缓存完成后触发
	MT.FireCallback("USER_EVENT_RECIPE_LIST_UPDATE");	--	Fire when skill list updated or changed.	--	配方列表更新后触发

	MT.FireCallback(
		"AUCTION_MOD_LOADED",
		mod
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

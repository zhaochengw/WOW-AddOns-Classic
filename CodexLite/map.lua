--[[--
	by ALA @ 163UI/网易有爱, http://wowui.w.163.com/163ui/
	CREDIT shagu/pfQuest(MIT LICENSE) @ https://github.com/shagu
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __ns = ...;

local _G = _G;
local _ = nil;
----------------------------------------------------------------------------------------------------
--[=[dev]=]	if __ns.__is_dev then __ns._F_devDebugProfileStart('module.map'); end

-->		variables
	local hooksecurefunc = hooksecurefunc;
	local next = next;
	local tremove, wipe = table.remove, table.wipe;
	local _radius_sin, _radius_cos = math.cos, math.sin;
	local GetCVar = GetCVar;
	local GetTime = GetTime;
	local IsShiftKeyDown, IsControlKeyDown, IsAltKeyDown = IsShiftKeyDown, IsControlKeyDown, IsAltKeyDown;
	local GetPlayerFacing = GetPlayerFacing;
	local C_Map = C_Map;
	local CreateFrame = CreateFrame;
	local WorldMapFrame = WorldMapFrame;	-->		WorldMapFrame:WorldMapFrameTemplate	interiting	MapCanvasFrameTemplate:MapCanvasMixin
	local mapCanvas = WorldMapFrame:GetCanvas();	-->		equal WorldMapFrame.ScrollContainer.Child	--	not implementation of MapCanvasMixin!!!
	local CreateFromMixins, MapCanvasDataProviderMixin = CreateFromMixins, MapCanvasDataProviderMixin;
	local Minimap = Minimap;
	local GameTooltip = GameTooltip;

	local __db = __ns.db;
	local __db_quest = __db.quest;
	local __db_unit = __db.unit;
	local __db_item = __db.item;
	local __db_object = __db.object;
	local __db_refloot = __db.refloot;
	local __db_event = __db.event;

	local __loc = __ns.L;
	local __loc_quest = __loc.quest;
	local __loc_unit = __loc.unit;
	local __loc_item = __loc.item;
	local __loc_object = __loc.object;
	local __loc_profession = __loc.profession;
	local __UILOC = __ns.UILOC;

	local __core = __ns.core;
	local _F_SafeCall = __core._F_SafeCall;
	local __eventHandler = __core.__eventHandler;
	local __const = __core.__const;
	local IMG_INDEX = __core.IMG_INDEX;
	local IMG_PATH_PIN = __core.IMG_PATH_PIN;
	local IMG_LIST = __core.IMG_LIST;
	local ContinentMapID = __core.ContinentMapID;
	local GetUnitPosition = __core.GetUnitPosition;

	local __core_meta = __ns.__core_meta;

	local _log_ = __ns._log_;

	-- local pinFrameLevel = WorldMapFrame:GetPinFrameLevelsManager():GetValidFrameLevel("PIN_FRAME_LEVEL_AREA_POI");
	local wm_wrap = CreateFrame('FRAME', nil, mapCanvas);
		wm_wrap:SetSize(1, 1);
		wm_wrap:SetPoint("CENTER");
	local mm_wrap = CreateFrame('FRAME', nil, Minimap);
		mm_wrap:SetSize(1, 1);
		mm_wrap:SetPoint("CENTER");
	local CommonPinFrameLevel, LargePinFrameLevel = 1, 1;
	local function ReCalcFrameLevel(pinFrameLevelsManager)
		local base = pinFrameLevelsManager:GetValidFrameLevel("PIN_FRAME_LEVEL_AREA_POI", 9999);
		wm_wrap:SetFrameLevel(base);
		mm_wrap:SetFrameLevel(base);
		CommonPinFrameLevel = base;
		LargePinFrameLevel = base + 1;
		for index, texture in next, IMG_LIST do
			texture[7] = base + texture[6];
		end
	end
	local pinFrameLevelsManager = WorldMapFrame:GetPinFrameLevelsManager();	--	WorldMapFrame.pinFrameLevelsManager;
	hooksecurefunc(pinFrameLevelsManager, "AddFrameLevel", ReCalcFrameLevel);
	ReCalcFrameLevel(pinFrameLevelsManager);

	local SET = nil;
-->
if __ns.__is_dev then
	__ns:BuildEnv("map");
end
-->		MAIN
	-->		--	count
		local __popt = { 0, 0, 0, 0, };
		local function __opt_prompt()
			__ns.__opt_log('map.opt', __popt[1], __popt[2], __popt[3], __popt[4]);
		end
		function __popt:count(index, count)
			__popt[index] = __popt[index] + count;
			if __ns.__is_dev then __eventHandler:run_on_next_tick(__opt_prompt); end
		end
		function __popt:reset(index)
			__popt[index] = 0;
			if __ns.__is_dev then __eventHandler:run_on_next_tick(__opt_prompt); end
		end
		function __popt:echo(index)
			return __popt[index];
		end
	-->
	local wm_map = WorldMapFrame:GetMapID();
	local mm_map = C_Map.GetBestMapForUnit('player');
	local map_canvas_scale = mapCanvas:GetScale();
	local pin_size, large_size, varied_size = nil, nil, nil;
	local minimap_node_inset = false;
	local hide_node_modifier = IsShiftKeyDown;
	local META_COMMON = {  };				-->		[map] =	{ [uuid] = { 1{ coord }, 2{ pin }, 3nil, 4nil, }, }
	local META_LARGE = {  };				-->		[map] =	{ [uuid] = { 1{ coord }, 2{ pin }, 3nil, 4nil, }, }
	local META_VARIED = {  };				-->		[map] =	{ [uuid] = { 1{ coord }, 2{ pin }, 3nil, 4nil, }, }
	local MM_COMMON_PINS = {  };			-->		[map] = { coord = pin, }
	local MM_LARGE_PINS = {  };				-->		[map] = { coord = pin, }
	local MM_VARIED_PINS = {  };			-->		[map] = { coord = pin, }
	__ns.__map_meta = { META_COMMON, META_LARGE, META_VARIED, };
	local QUEST_TEMPORARILY_BLOCKED = {  };
	local QUEST_PERMANENTLY_BLOCKED = {  };
	local QUEST_PERMANENTLY_BL_LIST = {  };
	-->		function predef
		local Pin_OnEnter, Pin_OnClick;
		local NewWorldMapPin, RelWorldMapCommonPin, AddWorldMapCommonPin, RelWorldMapLargePin, AddWorldMapLargePin, RelWorldMapVariedPin, AddWorldMapVariedPin;
		local IterateWorldMapPinSetSize, ResetWMPin;
		local WorldMap_HideCommonNodesMapUUID, WorldMap_HideLargeNodesMapUUID, WorldMap_HideVariedNodesMapUUID;
		local WorldMap_ChangeCommonLargeNodesMapUUID, WorldMap_ChangeVariedNodesMapUUID;
		local WorldMap_ShowNodesQuest, WorldMap_HideNodesQuest;
		local WorldMap_DrawNodesMap, WorldMap_HideNodesMap;
		local NewMinimapPin, RelMinimapPin, AddMinimapPin, ResetMMPin;
		local Minimap_HideCommonNodesMapUUID, Minimap_HideLargeNodesMapUUID, Minimap_HideVariedNodesMapUUID;
		local Minimap_ChangeCommonLargeNodesMapUUID, Minimap_ChangeVariedNodesMapUUID;
		local Minimap_ShowNodesMapQuest, Minimap_HideNodesQuest;
		local Minimap_DrawNodesMap, Minimap_HideNodes, Minimap_OnUpdate;
		local MapAddCommonNodes, MapDelCommonNodes, MapUpdCommonNodes;
		local MapAddLargeNodes, MapDelLargeNodes, MapUpdLargeNodes;
		local MapAddVariedNodes, MapDelVariedNodes, MapUpdVariedNodes;
		local MapTemporarilyShowQuestNodes, MapTemporarilyHideQuestNodes, MapResetTemporarilyQuestNodesFilter;
		local MapPermanentlyShowQuestNodes, MapPermanentlyHideQuestNodes, MapPermanentlyToggleQuestNodes;
		local MapHideNodes, MapDrawNodes;
		--	setting
		local SetShowPinInContinent;
		local SetWorldmapAlpha, SetMinimapAlpha;
		local SetCommonPinSize, SetLargePinSize, SetVariedPinSize;
		local SetHideNodeModifier, SetMinimapNodeInset, SetMinimapPlayerArrowOnTop;
	-->
	-->		--	Pin Handler
		function Pin_OnEnter(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			local uuid = self.uuid;
			local _type = uuid[1];
			local _id = uuid[2];
			__ns.GameTooltipSetInfo(_type, _id);
			GameTooltip:Show();
		end
		function Pin_OnClick(self)
			local uuid = self.uuid;
			if uuid ~= nil then
				if hide_node_modifier() then
					if __ns.NodeOnModifiedClick(self, uuid) then
						return;
					end
				end
				__ns.RelColor3(uuid[3]);
				uuid[3], uuid[6] = __ns.GetColor3NextIndex(uuid[6]);
				WorldMap_ChangeCommonLargeNodesMapUUID(wm_map, uuid);
				Minimap_ChangeCommonLargeNodesMapUUID(mm_map, uuid);
			end
		end
	-->
	-->		--	WorldMapFrame Pin
		function NewWorldMapPin(__PIN_TAG, pool_inuse, pool_unused, size, Release, frameLevel)
			local pin = next(pool_unused);
			if pin == nil then
				pin = CreateFrame('FRAME', nil, wm_wrap);
				pin:SetScript("OnEnter", Pin_OnEnter);
				pin:SetScript("OnLeave", __ns.OnLeave);
				pin:SetScript("OnMouseUp", Pin_OnClick);
				pin:SetFrameLevel(frameLevel or CommonPinFrameLevel);
				pin.Release = Release;
				pin.__PIN_TAG = __PIN_TAG;
				local icon = pin:CreateTexture(nil, "ARTWORK");
				icon:SetAllPoints();
				icon:SetTexture(IMG_PATH_PIN);
				pin.icon = icon;
			else
				pool_unused[pin] = nil;
			end
			pin:SetSize(size, size);
			pool_inuse[pin] = 1;
			return pin;
		end
		--
		local pool_worldmap_common_pin_inuse = {  };
		local pool_worldmap_common_pin_unused = {  };
		function RelWorldMapCommonPin(pin)
			pool_worldmap_common_pin_unused[pin] = 1;
			pool_worldmap_common_pin_inuse[pin] = nil;
			pin:Hide();
		end
		function AddWorldMapCommonPin(x, y, color3)
			local pin = NewWorldMapPin(__const.TAG_WM_COMMON, pool_worldmap_common_pin_inuse, pool_worldmap_common_pin_unused, pin_size, RelWorldMapCommonPin, CommonPinFrameLevel);
			--		MapCanvasPinMixin:SetPosition(x, y)
			--	>>	MapCanvasMixin:SetPinPosition(pin, x, y)
			--	>>	MapCanvasMixin:ApplyPinPosition(pin, x, y) mainly implemented below
			--	and lots of bullshit about 'nudge'
			local rscale = 0.01 / pin:GetScale();
			pin:SetPoint("CENTER", mapCanvas, "TOPLEFT", mapCanvas:GetWidth() * x * rscale, -mapCanvas:GetHeight() * y * rscale);
			pin.icon:SetVertexColor(color3[1], color3[2], color3[3]);
			pin:Show();
			return pin;
		end
		--
		local pool_worldmap_large_pin_inuse = {  };
		local pool_worldmap_large_pin_unused = {  };
		function RelWorldMapLargePin(pin)
			pool_worldmap_large_pin_unused[pin] = 1;
			pool_worldmap_large_pin_inuse[pin] = nil;
			pin:Hide();
		end
		function AddWorldMapLargePin(x, y, color3)
			local pin = NewWorldMapPin(__const.TAG_WM_LARGE, pool_worldmap_large_pin_inuse, pool_worldmap_large_pin_unused, large_size, RelWorldMapLargePin, LargePinFrameLevel);
			--		MapCanvasPinMixin:SetPosition(x, y)
			--	>>	MapCanvasMixin:SetPinPosition(pin, x, y)
			--	>>	MapCanvasMixin:ApplyPinPosition(pin, x, y) mainly implemented below
			--	and lots of bullshit about 'nudge'
			local rscale = 0.01 / pin:GetScale();
			pin:SetPoint("CENTER", mapCanvas, "TOPLEFT", mapCanvas:GetWidth() * x * rscale, -mapCanvas:GetHeight() * y * rscale);
			pin.icon:SetVertexColor(color3[1], color3[2], color3[3]);
			pin:Show();
			return pin;
		end
		--
		local pool_worldmap_varied_pin_inuse = {  };
		local pool_worldmap_varied_pin_unused = {  };
		function RelWorldMapVariedPin(pin)
			pool_worldmap_varied_pin_unused[pin] = 1;
			pool_worldmap_varied_pin_inuse[pin] = nil;
			pin:Hide();
		end
		function AddWorldMapVariedPin(x, y, color3, TEXTURE)
			local texture = IMG_LIST[TEXTURE] or IMG_LIST[IMG_INDEX.IMG_DEF];
			local pin = NewWorldMapPin(__const.TAG_WM_VARIED, pool_worldmap_varied_pin_inuse, pool_worldmap_varied_pin_unused, varied_size, RelWorldMapVariedPin, texture[7]);
			pin:SetFrameLevel(texture[7]);
			--		MapCanvasPinMixin:SetPosition(x, y)
			--	>>	MapCanvasMixin:SetPinPosition(pin, x, y)
			--	>>	MapCanvasMixin:ApplyPinPosition(pin, x, y) mainly implemented below
			--	and lots of bullshit about 'nudge'
			local rscale = 0.01 / pin:GetScale();
			pin:SetPoint("CENTER", mapCanvas, "TOPLEFT", mapCanvas:GetWidth() * x * rscale, -mapCanvas:GetHeight() * y * rscale);
			pin.icon:SetTexture(texture[1]);
			pin.icon:SetVertexColor(texture[2] or color3[1] or 1.0, texture[3] or color3[2] or 1.0, texture[4] or color3[3] or 1.0);
			-- if color3 ~= nil then
			-- 	pin.icon:SetVertexColor(color3[1] or 1.0, color3[2] or 1.0, color3[3] or 1.0);
			-- else
			-- 	pin.icon:SetVertexColor(texture[2] or 1.0, texture[3] or 1.0, texture[4] or 1.0);
			-- end
			pin:Show();
			return pin;
		end
		--
		function IterateWorldMapPinSetSize()
			for pin, _ in next, pool_worldmap_common_pin_inuse do
				pin:SetSize(pin_size, pin_size);
			end
			for pin, _ in next, pool_worldmap_large_pin_inuse do
				pin:SetSize(large_size, large_size);
			end
			for pin, _ in next, pool_worldmap_varied_pin_inuse do
				pin:SetSize(varied_size, varied_size);
			end
		end
		--
		function ResetWMPin()
			for pin, _ in next, pool_worldmap_common_pin_inuse do
				pin:Release();
			end
			for pin, _ in next, pool_worldmap_large_pin_inuse do
				pin:Release();
			end
			for pin, _ in next, pool_worldmap_varied_pin_inuse do
				pin:Release();
			end
			__popt:reset(1);
			__popt:reset(2);
			__popt:reset(3);
		end
	-->
	local function UUIDCheckState(uuid, val)
		for quest, refs in next, uuid[4] do
			local meta = __core_meta[quest];
			if meta ~= nil and meta.completed ~= 1 and meta.completed ~= -1 and QUEST_TEMPORARILY_BLOCKED[quest] ~= true and QUEST_PERMANENTLY_BLOCKED[quest] ~= true then
				for line, texture in next, refs do
					if line == 'event' then
						return true;
					end
					local meta_line = meta[line];
					if meta_line ~= nil and not meta_line[5] and texture == val then
						return true;
					end
				end
			end
		end
		return false;
	end
	local function UUIDCheckStateVaried(uuid)
		for quest, refs in next, uuid[4] do
			if QUEST_TEMPORARILY_BLOCKED[quest] ~= true and QUEST_PERMANENTLY_BLOCKED[quest] ~= true then
				if refs['start'] ~= nil or refs['end'] ~= nil then
					return true;
				end
			end
		end
		return false;
	end
	-->		--	draw on WorldMap		--	当前地图每个点都要显示，所以大地图标记表存储为为数据元表的子表与coord一一对应
		function WorldMap_HideCommonNodesMapUUID(map, uuid)
			local meta = META_COMMON[map];
			if meta ~= nil then
				local data = meta[uuid];
				if data ~= nil then
					local pins = data[2];
					local num_pins = #pins;
					if num_pins > 0 then
						for index = 1, num_pins do
							pins[index]:Release();
						end
						data[2] = {  };
						__popt:count(1, -num_pins);
					end
				end
			end
		end
		function WorldMap_HideLargeNodesMapUUID(map, uuid)
			local large = META_LARGE[map];
			if large ~= nil then
				local data = large[uuid];
				if data ~= nil then
					local pins = data[2];
					local num_pins = #pins;
					if num_pins > 0 then
						for index = 1, num_pins do
							pins[index]:Release();
						end
						data[2] = {  };
						__popt:count(2, -num_pins);
					end
				end
			end
		end
		function WorldMap_HideVariedNodesMapUUID(map, uuid)
			local varied = META_VARIED[map];
			if varied ~= nil then
				local data = varied[uuid];
				if data ~= nil then
					local pins = data[2];
					local num_pins = #pins;
					if num_pins > 0 then
						for index = 1, num_pins do
							pins[index]:Release();
						end
						data[2] = {  };
						__popt:count(3, -num_pins);
					end
				end
			end
		end
		function WorldMap_ChangeCommonLargeNodesMapUUID(map, uuid)
			local color3 = uuid[3];
			local meta = META_COMMON[map];
			if meta ~= nil then
				local data = meta[uuid];
				if data ~= nil then
					local pins = data[2];
					local num_pins = #pins;
					if num_pins > 0 then
						for index = 1, num_pins do
							pins[index].icon:SetVertexColor(color3[1], color3[2], color3[3]);
						end
					end
				end
			end
			local large = META_LARGE[map];
			if large ~= nil then
				local data = large[uuid];
				if data ~= nil then
					local pins = data[2];
					local num_pins = #pins;
					if num_pins > 0 then
						for index = 1, num_pins do
							pins[index].icon:SetVertexColor(color3[1], color3[2], color3[3]);
						end
					end
				end
			end
		end
		function WorldMap_ChangeVariedNodesMapUUID(map, uuid)
			local varied = META_VARIED[map];
			if varied ~= nil then
				local data = varied[uuid];
				if data ~= nil then
					local TEXTURE = uuid[5];
					local pins = data[2];
					for index = 1, #pins do
						local pin = pins[index];
						local texture = IMG_LIST[TEXTURE] or IMG_LIST[IMG_INDEX.IMG_DEF];
						pin.icon:SetTexture(texture[1]);
						pin.icon:SetVertexColor(texture[2], texture[3], texture[4]);
						pin:SetFrameLevel(texture[7]);
					end
				end
			end
		end
		function WorldMap_ShowNodesQuest(map, quest)
			local meta = META_COMMON[map];
			if meta ~= nil then
				for uuid, data in next, meta do
					if uuid[4][quest] ~= nil then
						local coords = data[1];
						local pins = data[2];
						local color3 = uuid[3];
						local num_coords = #coords;
						local num_pins = #pins;
						if num_pins < num_coords then
							for index = num_pins + 1, num_coords do
								local val = coords[index];
								local pin = AddWorldMapCommonPin(val[1], val[2], color3);
								pins[index] = pin;
								pin.uuid = uuid;
							end
							__popt:count(1, num_coords - num_pins);
						end
					end
				end
			end
			local large = META_LARGE[map];
			if large ~= nil then
				for uuid, data in next, large do
					if uuid[4][quest] ~= nil then
						local coords = data[1];
						local pins = data[2];
						local color3 = uuid[3];
						local num_coords = #coords;
						local num_pins = #pins;
						if num_pins < num_coords then
							for index = num_pins + 1, num_coords do
								local val = coords[index];
								local pin = AddWorldMapLargePin(val[1], val[2], color3);
								pins[index] = pin;
								pin.uuid = uuid;
							end
							__popt:count(2, num_coords - num_pins);
						end
					end
				end
			end
			local varied = META_VARIED[map];
			if varied ~= nil then
				for uuid, data in next, varied do
					if uuid[4][quest] ~= nil then
						local coords = data[1];
						local pins = data[2];
						local color3 = uuid[3];
						local TEXTURE = uuid[5];
						local num_coords = #coords;
						local num_pins = #pins;
						if num_pins < num_coords then
							for index = num_pins + 1, num_coords do
								local val = coords[index];
								local pin = AddWorldMapVariedPin(val[1], val[2], color3, TEXTURE);
								pins[index] = pin;
								pin.uuid = uuid;
							end
							__popt:count(3, num_coords - num_pins);
						end
					end
				end
			end
		end
		function WorldMap_HideNodesQuest(map, quest)
			local meta = META_COMMON[map];
			if meta ~= nil then
				for uuid, data in next, meta do
					if not UUIDCheckState(uuid, -9998) then
						local pins = data[2];
						local num_pins = #pins;
						if num_pins > 0 then
							for index = 1, num_pins do
								pins[index]:Release();
							end
							data[2] = {  };
							__popt:count(1, -num_pins);
						end
					end
				end
			end
			local large = META_LARGE[map];
			if large ~= nil then
				for uuid, data in next, large do
					if not UUIDCheckState(uuid, -9999) then
						local pins = data[2];
						local num_pins = #pins;
						if num_pins > 0 then
							for index = 1, num_pins do
								pins[index]:Release();
							end
							data[2] = {  };
							__popt:count(2, -num_pins);
						end
					end
				end
			end
			local varied = META_VARIED[map];
			if varied ~= nil then
				for uuid, data in next, varied do
					if not UUIDCheckStateVaried(uuid) then
						local pins = data[2];
						local num_pins = #pins;
						if num_pins > 0 then
							for index = 1, num_pins do
								pins[index]:Release();
							end
							data[2] = {  };
							__popt:count(3, -num_pins);
						end
					end
				end
			end
		end
		function WorldMap_DrawNodesMap(map)
			if not SET.show_in_continent and ContinentMapID[map] ~= nil then
				return;
			end
			local meta = META_COMMON[map];
			if meta ~= nil then
				for uuid, data in next, meta do
					if UUIDCheckState(uuid, -9998) then
						local coords = data[1];
						local pins = data[2];
						local color3 = uuid[3];
						local num_coords = #coords;
						local num_pins = #pins;
						if num_pins < num_coords then
							for index = num_pins + 1, num_coords do
								local val = coords[index];
								local pin = AddWorldMapCommonPin(val[1], val[2], color3);
								pins[index] = pin;
								pin.uuid = uuid;
							end
							__popt:count(1, num_coords - num_pins);
						end
					end
				end
			end
			local large = META_LARGE[map];
			if large ~= nil then
				for uuid, data in next, large do
					if UUIDCheckState(uuid, -9999) then
						local coords = data[1];
						local pins = data[2];
						local color3 = uuid[3];
						local num_coords = #coords;
						local num_pins = #pins;
						if num_pins < num_coords then
							for index = num_pins + 1, num_coords do
								local val = coords[index];
								local pin = AddWorldMapLargePin(val[1], val[2], color3);
								pins[index] = pin;
								pin.uuid = uuid;
							end
							__popt:count(2, num_coords - num_pins);
						end
					end
				end
			end
			local varied = META_VARIED[map];
			if varied ~= nil then
				for uuid, data in next, varied do
					if UUIDCheckStateVaried(uuid) then
						local coords = data[1];
						local pins = data[2];
						local color3 = uuid[3];
						local TEXTURE = uuid[5];
						local num_coords = #coords;
						local num_pins = #pins;
						if num_pins < num_coords then
							for index = num_pins + 1, num_coords do
								local val = coords[index];
								local pin = AddWorldMapVariedPin(val[1], val[2], color3, TEXTURE);
								pins[index] = pin;
								pin.uuid = uuid;
							end
							__popt:count(3, num_coords - num_pins);
						end
					end
				end
			end
		end
		function WorldMap_HideNodesMap(map)
			local meta = META_COMMON[map];
			if meta ~= nil then
				for uuid, data in next, meta do
					local pins = data[2];
					local num_pins = #pins;
					if num_pins > 0 then
						for index = 1, num_pins do
							pins[index]:Release();
						end
						data[2] = {  };
						__popt:count(1, -num_pins);
					end
				end
			end
			local large = META_LARGE[map];
			if large ~= nil then
				for uuid, data in next, large do
					local pins = data[2];
					local num_pins = #pins;
					if num_pins > 0 then
						for index = 1, num_pins do
							pins[index]:Release();
						end
						data[2] = {  };
						__popt:count(2, -num_pins);
					end
				end
			end
			local varied = META_VARIED[map];
			if varied ~= nil then
				for uuid, data in next, varied do
					local pins = data[2];
					local num_pins = #pins;
					if num_pins > 0 then
						for index = 1, num_pins do
							pins[index]:Release();
						end
						data[2] = {  };
						__popt:count(3, -num_pins);
					end
				end
			end
		end
	-->
	-->		--	Minimap Pin
		function NewMinimapPin(__PIN_TAG, pool_inuse, pool_unused, size, Release, frameLevel)
			local pin = next(pool_unused);
			if pin == nil then
				pin = CreateFrame('FRAME', nil, mm_wrap);
				pin:SetScript("OnEnter", Pin_OnEnter);
				pin:SetScript("OnLeave", __ns.OnLeave);
				pin:SetScript("OnMouseUp", Pin_OnClick);
				pin.Release = Release;
				pin.__PIN_TAG = __PIN_TAG;
				local icon = pin:CreateTexture(nil, "ARTWORK");
				icon:SetAllPoints();
				icon:SetTexture(IMG_PATH_PIN);
				pin.icon = icon;
			else
				pool_unused[pin] = nil;
			end
			pin:SetSize(size, size);
			pin:SetFrameLevel(frameLevel or CommonPinFrameLevel);
			pool_inuse[pin] = 1;
			return pin;
		end
		--
		local pool_minimap_pin_inuse = {  };
		local pool_minimap_pin_unused = {  };
		function RelMinimapPin(pin)
			pool_minimap_pin_unused[pin] = 1;
			pool_minimap_pin_inuse[pin] = nil;
			pin:Hide();
		end
		function AddMinimapPin(__PIN_TAG, img, r, g, b, size, frameLevel)
			local pin = NewMinimapPin(__PIN_TAG, pool_minimap_pin_inuse, pool_minimap_pin_unused, size, RelMinimapPin, frameLevel);
			--		MapCanvasPinMixin:SetPosition(x, y)
			--	>>	MapCanvasMixin:SetPinPosition(pin, x, y)
			--	>>	MapCanvasMixin:ApplyPinPosition(pin, x, y) mainly implemented below
			--	and lots of bullshit about 'nudge'
			pin.icon:SetTexture(img);
			pin.icon:SetVertexColor(r, g, b);
			pin:Show();
			return pin;
		end
		--
		function ResetMMPin()
			for pin, _ in next, pool_minimap_pin_inuse do
				pin:Release();
			end
			__popt:reset(4);
		end
	-->
	-->		--	draw on Minimap			--	只有少部分点显示在小地图，所以单独建表
		--	variables
			local minimap_size = {
				indoor = {
					[0] = 300, -- scale
					[1] = 240, -- 1.25
					[2] = 180, -- 5/3
					[3] = 120, -- 2.5
					[4] = 80,  -- 3.75
					[5] = 50,  -- 6
				},
				outdoor = {
					[0] = 466 + 2/3, -- scale
					[1] = 400,       -- 7/6
					[2] = 333 + 1/3, -- 1.4
					[3] = 266 + 2/6, -- 1.75
					[4] = 200,       -- 7/3
					[5] = 133 + 1/3, -- 3.5
				},
			};
			local mm_check_func_table = {
				CIRCLE = function(dx, dy, range)
					return dx * dx + dy * dy < range * range;
				end,
			};
			local mm_shape = "CIRCLE";
			local GetMinimapShape = _G.GetMinimapShape;
			if GetMinimapShape ~= nil then
				mm_shape = GetMinimapShape() or "CIRCLE";
			else
				mm_shape = "CIRCLE";
			end
			local mm_indoor = GetCVar("minimapZoom") + 0 == Minimap:GetZoom() and "outdoor" or "indoor";
			local mm_zoom = Minimap:GetZoom();
			local mm_hsize = minimap_size[mm_indoor][mm_zoom] * 0.5;
			local mm_hheight = Minimap:GetHeight() * 0.5;
			local mm_hwidth = Minimap:GetWidth() * 0.5;
			local mm_is_rotate = GetCVar("rotateMinimap") == "1";
			local mm_rotate = GetPlayerFacing();
			local mm_rotate_sin = mm_rotate ~= nil and _radius_sin(mm_rotate) or nil;
			local mm_rotate_cos = mm_rotate ~= nil and _radius_cos(mm_rotate) or nil;
			local mm_check_func = mm_check_func_table[mm_shape];
			local mm_force_update = false;
			local mm_player_map, mm_player_x, mm_player_y = GetUnitPosition('player');
			if mm_player_y == nil then mm_player_y = 0.0; end
			if mm_player_x == nil then mm_player_x = 0.0; end
			local mm_dynamic_update_interval = 0.05;
		--
		local mm_arrow_wrap = CreateFrame('FRAME', nil, Minimap);
			mm_arrow_wrap:SetSize(1, 1);
			mm_arrow_wrap:SetPoint("CENTER");
			mm_arrow_wrap:EnableMouse(false);
			mm_arrow_wrap:SetFrameLevel(9999);
		local mm_arrow = mm_arrow_wrap:CreateTexture(nil, "OVERLAY", nil, 7);
			mm_arrow:SetSize(24, 24);
			mm_arrow:SetPoint("CENTER");
			mm_arrow:SetTexture([[Interface\Minimap\MinimapArrow]]);
			hooksecurefunc(Minimap, "SetPlayerTexture", function(_, Texture)
				mm_arrow:SetTexture(Texture);
			end);
		mm_arrow_wrap:SetScript("OnUpdate", function()
			if mm_is_rotate then
				mm_arrow:SetTexCoord(0.0, 1.0, 0.0, 1.0);
			else
				local facing = GetPlayerFacing();
				if facing ~= nil then
					mm_arrow:Show();
					local r = facing - 0.78539816339745;			--	rad(45)
					local c = _radius_cos(r) * 0.70710678118655;	--	sqrt(0.5)
					local s = _radius_sin(r) * 0.70710678118655;	--	sqrt(0.5)
					mm_arrow:SetTexCoord(
						0.5 + c, 0.5 - s,
						0.5 - s, 0.5 - c,
						0.5 + s, 0.5 + c,
						0.5 - c, 0.5 + s
					);
				else
					mm_arrow:Hide();
				end
			end
		end);
		function Minimap_HideCommonNodesMapUUID(map, uuid)
			local num_changed = 0;
			local meta = META_COMMON[map];
			if meta ~= nil then
				local data = meta[uuid];
				if data ~= nil then
					local coords = data[1];
					for index = 1, #coords do
						local coord = coords[index];
						local pin = MM_COMMON_PINS[coord];
						if pin ~= nil then
							pin:Release();
							MM_COMMON_PINS[coord] = nil;
							num_changed = num_changed - 1;
						end
					end
				end
			end
			if num_changed ~= 0 then
				__popt:count(4, num_changed);
			end
		end
		function Minimap_HideLargeNodesMapUUID(map, uuid)
			local num_changed = 0;
			local large = META_LARGE[map];
			if large ~= nil then
				local data = large[uuid];
				if data ~= nil then
					local coords = data[1];
					for index = 1, #coords do
						local coord = coords[index];
						local pin = MM_LARGE_PINS[coord];
						if pin ~= nil then
							pin:Release();
							MM_LARGE_PINS[coord] = nil;
							num_changed = num_changed - 1;
						end
					end
				end
			end
			if num_changed ~= 0 then
				__popt:count(4, num_changed);
			end
		end
		function Minimap_HideVariedNodesMapUUID(map, uuid)
			local num_changed = 0;
			local varied = META_VARIED[map];
			if varied ~= nil then
				local data = varied[uuid];
				if data ~= nil then
					local coords = data[1];
					for index = 1, #coords do
						local coord = coords[index];
						local pin = MM_VARIED_PINS[coord];
						if pin ~= nil then
							pin:Release();
							MM_VARIED_PINS[coord] = nil;
							num_changed = num_changed - 1;
						end
					end
				end
			end
			if num_changed ~= 0 then
				__popt:count(4, num_changed);
			end
		end
		function Minimap_ChangeCommonLargeNodesMapUUID(map, uuid)
			local color3 = uuid[3];
			local meta = META_COMMON[map];
			if meta ~= nil then
				local data = meta[uuid];
				if data ~= nil then
					local coords = data[1];
					for index = 1, #coords do
						local pin = MM_COMMON_PINS[coords[index]];
						if pin ~= nil then
							pin.icon:SetVertexColor(color3[1], color3[2], color3[3]);
						end
					end
				end
			end
			local large = META_LARGE[map];
			if large ~= nil then
				local data = large[uuid];
				if data ~= nil then
					local coords = data[1];
					for index = 1, #coords do
						local pin = MM_LARGE_PINS[coords[index]];
						if pin ~= nil then
							pin.icon:SetVertexColor(color3[1], color3[2], color3[3]);
						end
					end
				end
			end
		end
		function Minimap_ChangeVariedNodesMapUUID(map, uuid)
			local varied = META_VARIED[mm_map];
			if varied ~= nil then
				local data = varied[uuid];
				if data ~= nil then
					local TEXTURE = uuid[5];
					local coords = data[1];
					for index = 1, #coords do
						local coord = coords[index];
						local texture = IMG_LIST[TEXTURE] or IMG_LIST[IMG_INDEX.IMG_DEF];
						local pin = MM_VARIED_PINS[coord];
						if pin ~= nil then
							pin.icon:SetTexture(texture[1]);
							pin.icon:SetVertexColor(texture[2], texture[3], texture[4]);
							pin:SetFrameLevel(texture[7]);
						end
					end
				end
			end
		end
		function Minimap_ShowNodesMapQuest(map, quest)
			__ns._F_devDebugProfileStart('module.map.Minimap_DrawNodesMap');
			local num_changed = 0;
			local meta = META_COMMON[map];
			if meta ~= nil then
				for uuid, data in next, meta do
					if uuid[4][quest] ~= nil then
						local color3 = uuid[3];
						local coords = data[1];
						for index = 1, #coords do
							local coord = coords[index];
							local val = coord[5];	--	world
							local dx = val[1] - mm_player_x;
							local dy = val[2] - mm_player_y;
							if dx > -mm_hsize and dx < mm_hsize and dy > -mm_hsize and dy < mm_hsize and (mm_check_func == nil or mm_check_func(dx, dy, mm_hsize)) then
								local pin = MM_COMMON_PINS[coord];
								if pin == nil then
									pin = AddMinimapPin(__const.TAG_MM_COMMON, IMG_PATH_PIN, color3[1], color3[2], color3[3], SET.pin_size, CommonPinFrameLevel);
									MM_COMMON_PINS[coord] = pin;
									num_changed = num_changed + 1;
								else
									pin.icon:SetTexture(IMG_PATH_PIN);
									pin.icon:SetVertexColor(color3[1], color3[2], color3[3]);
								end
								pin:ClearAllPoints();
								if mm_is_rotate then
									dx, dy = dx * mm_rotate_sin - dy * mm_rotate_cos, dx * mm_rotate_cos + dy * mm_rotate_sin;
								end
								pin:SetPoint("CENTER", Minimap, "CENTER", - mm_hwidth * dx / mm_hsize, mm_hheight * dy / mm_hsize);
								--	transform from world-coord[bottomleft->topright] to UI-coord[bottomleft->topright]
								pin.uuid = uuid;
							else
								local pin = MM_COMMON_PINS[coord];
								if pin ~= nil then
									pin:Release();
									MM_COMMON_PINS[coord] = nil;
									num_changed = num_changed - 1;
								end
							end
						end
					end
				end
			end
			local large = META_LARGE[map];
			if large ~= nil then
				for uuid, data in next, large do
					if uuid[4][quest] ~= nil then
						local color3 = uuid[3];
						local coords = data[1];
						for index = 1, #coords do
							local coord = coords[index];
							local val = coord[5];	--	world
							local dx = val[1] - mm_player_x;
							local dy = val[2] - mm_player_y;
							if dx > -mm_hsize and dx < mm_hsize and dy > -mm_hsize and dy < mm_hsize and (mm_check_func == nil or mm_check_func(dx, dy, mm_hsize)) then
								local pin = MM_LARGE_PINS[coord];
								if pin == nil then
									pin = AddMinimapPin(__const.TAG_MM_LARGE, IMG_PATH_PIN, color3[1], color3[2], color3[3], SET.large_size, LargePinFrameLevel);
									MM_LARGE_PINS[coord] = pin;
									num_changed = num_changed + 1;
								else
									pin.icon:SetTexture(IMG_PATH_PIN);
									pin.icon:SetVertexColor(color3[1], color3[2], color3[3]);
								end
								pin:ClearAllPoints();
								if mm_is_rotate then
									dx, dy = dx * mm_rotate_sin - dy * mm_rotate_cos, dx * mm_rotate_cos + dy * mm_rotate_sin;
								end
								pin:SetPoint("CENTER", Minimap, "CENTER", - mm_hwidth * dx / mm_hsize, mm_hheight * dy / mm_hsize);
								--	transform from world-coord[bottomleft->topright] to UI-coord[bottomleft->topright]
								pin.uuid = uuid;
							else
								local pin = MM_LARGE_PINS[coord];
								if pin ~= nil then
									pin:Release();
									MM_LARGE_PINS[coord] = nil;
									num_changed = num_changed - 1;
								end
							end
						end
					end
				end
			end
			local varied = META_VARIED[map];
			if varied ~= nil then
				for uuid, data in next, varied do
					if uuid[4][quest] ~= nil then
						local color3 = uuid[3];
						local TEXTURE = uuid[5];
						local coords = data[1];
						for index = 1, #coords do
							local coord = coords[index];
							local val = coord[5];	--	world
							local dx = val[1] - mm_player_x;
							local dy = val[2] - mm_player_y;
							if dx > -mm_hsize and dx < mm_hsize and dy > -mm_hsize and dy < mm_hsize and (mm_check_func == nil or mm_check_func(dx, dy, mm_hsize)) then
								local pin = MM_VARIED_PINS[coord];
								local texture = IMG_LIST[TEXTURE] or IMG_LIST[IMG_INDEX.IMG_DEF];
								if pin == nil then
									pin = AddMinimapPin(__const.TAG_MM_VARIED, texture[1], texture[2] or color3[1], texture[3] or color3[2], texture[4] or color3[3], SET.pin_size, texture[7]);
									MM_VARIED_PINS[coord] = pin;
									num_changed = num_changed + 1;
								else
									pin.icon:SetTexture(texture[1]);
									pin.icon:SetVertexColor(texture[2], texture[3], texture[4]);
								end
								pin:ClearAllPoints();
								if mm_is_rotate then
									dx, dy = dx * mm_rotate_sin - dy * mm_rotate_cos, dx * mm_rotate_cos + dy * mm_rotate_sin;
								end
								pin:SetPoint("CENTER", Minimap, "CENTER", - mm_hwidth * dx / mm_hsize, mm_hheight * dy / mm_hsize);
								--	transform from world-coord[bottomleft->topright] to UI-coord[bottomleft->topright]
								pin.uuid = uuid;
							else
								local pin = MM_VARIED_PINS[coord];
								if pin ~= nil then
									pin:Release();
									MM_VARIED_PINS[coord] = nil;
									num_changed = num_changed - 1;
								end
							end
						end
					end
				end
			end
			if num_changed ~= 0 then
				__popt:count(4, num_changed);
			end
			local cost = __ns._F_devDebugProfileTick('module.map.Minimap_DrawNodesMap');
			mm_dynamic_update_interval = cost * 0.2;
			--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.map.Minimap_DrawNodesMap', mm_dynamic_update_interval); end
		end
		function Minimap_HideNodesQuest(quest)
			local num_pins = 0;
			for coord, pin in next, MM_COMMON_PINS do
				if not UUIDCheckState(pin.uuid, -9998) then
					pin:Release();
					MM_COMMON_PINS[coord] = nil;
					num_pins = num_pins - 1;
				end
			end
			for coord, pin in next, MM_LARGE_PINS do
				if not UUIDCheckState(pin.uuid, -9999) then
					pin:Release();
					MM_LARGE_PINS[coord] = nil;
					num_pins = num_pins - 1;
				end
			end
			for coord, pin in next, MM_VARIED_PINS do
				if not UUIDCheckStateVaried(pin.uuid) then
					pin:Release();
					MM_VARIED_PINS[coord] = nil;
					num_pins = num_pins - 1;
				end
			end
			__popt:count(4, num_pins);
		end
		function Minimap_DrawNodesMap(map)
			__ns._F_devDebugProfileStart('module.map.Minimap_DrawNodesMap');
			local mm_check_range = minimap_node_inset and mm_hsize * 0.9 or mm_hsize;
			local num_changed = 0;
			local meta = META_COMMON[map];
			if meta ~= nil then
				for uuid, data in next, meta do
					if UUIDCheckState(uuid, -9998) then
						local color3 = uuid[3];
						local coords = data[1];
						for index = 1, #coords do
							local coord = coords[index];
							local val = coord[5];	--	world
							local dx = val[1] - mm_player_x;
							local dy = val[2] - mm_player_y;
							if dx > -mm_check_range and dx < mm_check_range and dy > -mm_check_range and dy < mm_check_range and (mm_check_func == nil or mm_check_func(dx, dy, mm_check_range)) then
								local pin = MM_COMMON_PINS[coord];
								if pin == nil then
									pin = AddMinimapPin(__const.TAG_MM_COMMON, IMG_PATH_PIN, color3[1], color3[2], color3[3], SET.pin_size, CommonPinFrameLevel);
									MM_COMMON_PINS[coord] = pin;
									num_changed = num_changed + 1;
								else
									pin.icon:SetTexture(IMG_PATH_PIN);
									pin.icon:SetVertexColor(color3[1], color3[2], color3[3]);
								end
								pin:ClearAllPoints();
								if mm_is_rotate then
									dx, dy = dx * mm_rotate_sin - dy * mm_rotate_cos, dx * mm_rotate_cos + dy * mm_rotate_sin;
								end
								pin:SetPoint("CENTER", Minimap, "CENTER", - mm_hwidth * dx / mm_hsize, mm_hheight * dy / mm_hsize);
								--	transform from world-coord[bottomleft->topright] to UI-coord[bottomleft->topright]
								pin.uuid = uuid;
							else
								local pin = MM_COMMON_PINS[coord];
								if pin ~= nil then
									pin:Release();
									MM_COMMON_PINS[coord] = nil;
									num_changed = num_changed - 1;
								end
							end
						end
					end
				end
			end
			local large = META_LARGE[map];
			if large ~= nil then
				for uuid, data in next, large do
					if UUIDCheckState(uuid, -9999) then
						local color3 = uuid[3];
						local coords = data[1];
						for index = 1, #coords do
							local coord = coords[index];
							local val = coord[5];	--	world
							local dx = val[1] - mm_player_x;
							local dy = val[2] - mm_player_y;
							if dx > -mm_check_range and dx < mm_check_range and dy > -mm_check_range and dy < mm_check_range and (mm_check_func == nil or mm_check_func(dx, dy, mm_check_range)) then
								local pin = MM_LARGE_PINS[coord];
								if pin == nil then
									pin = AddMinimapPin(__const.TAG_MM_LARGE, IMG_PATH_PIN, color3[1], color3[2], color3[3], SET.large_size, LargePinFrameLevel);
									MM_LARGE_PINS[coord] = pin;
									num_changed = num_changed + 1;
								else
									pin.icon:SetTexture(IMG_PATH_PIN);
									pin.icon:SetVertexColor(color3[1], color3[2], color3[3]);
								end
								pin:ClearAllPoints();
								if mm_is_rotate then
									dx, dy = dx * mm_rotate_sin - dy * mm_rotate_cos, dx * mm_rotate_cos + dy * mm_rotate_sin;
								end
								pin:SetPoint("CENTER", Minimap, "CENTER", - mm_hwidth * dx / mm_hsize, mm_hheight * dy / mm_hsize);
								--	transform from world-coord[bottomleft->topright] to UI-coord[bottomleft->topright]
								pin.uuid = uuid;
							else
								local pin = MM_LARGE_PINS[coord];
								if pin ~= nil then
									pin:Release();
									MM_LARGE_PINS[coord] = nil;
									num_changed = num_changed - 1;
								end
							end
						end
					end
				end
			end
			local varied = META_VARIED[map];
			if varied ~= nil then
				for uuid, data in next, varied do
					if UUIDCheckStateVaried(uuid) then
						local color3 = uuid[3];
						local TEXTURE = uuid[5];
						local coords = data[1];
						for index = 1, #coords do
							local coord = coords[index];
							local val = coord[5];	--	world
							local dx = val[1] - mm_player_x;
							local dy = val[2] - mm_player_y;
							if dx > -mm_check_range and dx < mm_check_range and dy > -mm_check_range and dy < mm_check_range and (mm_check_func == nil or mm_check_func(dx, dy, mm_check_range)) then
								local pin = MM_VARIED_PINS[coord];
								local texture = IMG_LIST[TEXTURE] or IMG_LIST[IMG_INDEX.IMG_DEF];
								if pin == nil then
									pin = AddMinimapPin(__const.TAG_MM_VARIED, texture[1], texture[2] or color3[1], texture[3] or color3[2], texture[4] or color3[3], SET.pin_size, texture[7]);
									MM_VARIED_PINS[coord] = pin;
									num_changed = num_changed + 1;
								else
									pin.icon:SetTexture(texture[1]);
									pin.icon:SetVertexColor(texture[2], texture[3], texture[4]);
								end
								pin:ClearAllPoints();
								if mm_is_rotate then
									dx, dy = dx * mm_rotate_sin - dy * mm_rotate_cos, dx * mm_rotate_cos + dy * mm_rotate_sin;
								end
								pin:SetPoint("CENTER", Minimap, "CENTER", - mm_hwidth * dx / mm_hsize, mm_hheight * dy / mm_hsize);
								--	transform from world-coord[bottomleft->topright] to UI-coord[bottomleft->topright]
								pin.uuid = uuid;
							else
								local pin = MM_VARIED_PINS[coord];
								if pin ~= nil then
									pin:Release();
									MM_VARIED_PINS[coord] = nil;
									num_changed = num_changed - 1;
								end
							end
						end
					end
				end
			end
			if num_changed ~= 0 then
				__popt:count(4, num_changed);
			end
			local cost = __ns._F_devDebugProfileTick('module.map.Minimap_DrawNodesMap');
			mm_dynamic_update_interval = cost * 0.2;
			--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.map.Minimap_DrawNodesMap', mm_dynamic_update_interval); end
		end
		function Minimap_HideNodes()
			local num_pins = 0;
			for coord, pin in next, MM_COMMON_PINS do
				pin:Release();
				MM_COMMON_PINS[coord] = nil;
				num_pins = num_pins - 1;
			end
			for coord, pin in next, MM_LARGE_PINS do
				pin:Release();
				MM_LARGE_PINS[coord] = nil;
				num_pins = num_pins - 1;
			end
			for coord, pin in next, MM_VARIED_PINS do
				pin:Release();
				MM_VARIED_PINS[coord] = nil;
				num_pins = num_pins - 1;
			end
			__popt:count(4, num_pins);
		end
		local __mm_prev_update = GetTime();
		function Minimap_OnUpdate(self, elasped)
			if mm_map ~= nil then
				local facing = GetPlayerFacing();
				if facing ~= nil then
					local now = GetTime();
					if __mm_prev_update + mm_dynamic_update_interval <= now then
						local GetMinimapShape = _G.GetMinimapShape;
						if GetMinimapShape ~= nil then
							local shape = GetMinimapShape() or "CIRCLE";
							if mm_shape ~= shape then
								mm_shape = shape;
								mm_force_update = true;
							end
						else
							if mm_shape ~= "CIRCLE" then
								mm_shape = "CIRCLE";
								mm_force_update = true;
							end
						end
						local zoom = Minimap:GetZoom();
						if GetCVar("minimapZoom") == GetCVar("minimapInsideZoom") then
							Minimap:SetZoom(zoom < 2 and zoom + 1 or zoom - 1);
						end
						local indoor = GetCVar("minimapZoom") + 0 == Minimap:GetZoom() and "outdoor" or "indoor";
						Minimap:SetZoom(zoom);
						local map, x, y = GetUnitPosition('player');
						if mm_force_update or (mm_player_x ~= x or mm_player_y ~= y or zoom ~= mm_zoom or indoor ~= mm_indoor or (mm_is_rotate and facing ~= mm_rotate)) then
							mm_player_x = x;
							mm_player_y = y;
							mm_indoor = indoor;
							mm_zoom = zoom;
							mm_rotate = facing;
							mm_rotate_sin = _radius_sin(facing);
							mm_rotate_cos = _radius_cos(facing);
							mm_hsize = minimap_size[indoor][zoom] * 0.5;
							mm_hheight = Minimap:GetHeight() * 0.5;
							mm_hwidth = Minimap:GetWidth() * 0.5;
							Minimap_DrawNodesMap(mm_map);
							mm_force_update = false;
						end
						__mm_prev_update = now;
					end
					return;
				end
			end
			mm_arrow:Hide();
		end
		function __ns.MINIMAP_UPDATE_ZOOM()
			-- __eventHandler:run_on_next_tick(Minimap_DrawNodes);
			-- _log_('MINIMAP_UPDATE_ZOOM', GetCVar("minimapZoom") + 0 == Minimap:GetZoom(), GetCVar("minimapZoom") == Minimap:GetZoom(), GetCVar("minimapZoom"), Minimap:GetZoom())
		end
		function __ns.CVAR_UPDATE()
			local is_rotate = GetCVar("rotateMinimap") == "1";
			if mm_is_rotate ~= is_rotate then
				mm_is_rotate = is_rotate;
				mm_force_update = true;
			end
		end
	-->
	-->		--	interface
		--	common_objective pin
		function MapAddCommonNodes(uuid, coords_table)
			if coords_table ~= nil then
				for index = 1, #coords_table do
					local coord = coords_table[index];
					local map = coord[3];
					local meta = META_COMMON[map];
					if meta == nil then
						meta = {  };
						META_COMMON[map] = meta;
					end
					local data = meta[uuid];
					if data == nil then
						data = { {  }, {  }, };
						meta[uuid] = data;
					end
					local coords = data[1];
					coords[#coords + 1] = coord;
					if map == mm_map then
						mm_force_update = true;
					end
				end
			end
		end
		function MapDelCommonNodes(uuid)
			WorldMap_HideCommonNodesMapUUID(wm_map, uuid);
			Minimap_HideCommonNodesMapUUID(mm_map, uuid);
			for map, meta in next, META_COMMON do
				meta[uuid] = nil;
			end
		end
		function MapUpdCommonNodes(uuid)
			if not UUIDCheckState(uuid, -9998) then
				WorldMap_HideCommonNodesMapUUID(wm_map, uuid);
				Minimap_HideCommonNodesMapUUID(mm_map, uuid);
			end
		end
		--	large_objective pin
		function MapAddLargeNodes(uuid, coords_table)
			if coords_table ~= nil then
				for index = 1, #coords_table do
					local coord = coords_table[index];
					local map = coord[3];
					local meta = META_LARGE[map];
					if meta == nil then
						meta = {  };
						META_LARGE[map] = meta;
					end
					local data = meta[uuid];
					if data == nil then
						data = { {  }, {  }, };
						meta[uuid] = data;
					end
					local coords = data[1];
					coords[#coords + 1] = coord;
					if map == mm_map then
						mm_force_update = true;
					end
				end
			end
		end
		function MapDelLargeNodes(uuid)
			WorldMap_HideLargeNodesMapUUID(wm_map, uuid);
			Minimap_HideLargeNodesMapUUID(mm_map, uuid);
			for map, meta in next, META_LARGE do
				meta[uuid] = nil;
			end
		end
		function MapUpdLargeNodes(uuid)
			if not UUIDCheckState(uuid, -9999) then
				WorldMap_HideLargeNodesMapUUID(wm_map, uuid);
				Minimap_HideLargeNodesMapUUID(mm_map, uuid);
			end
		end
		--	varied_objective pin
		function MapAddVariedNodes(uuid, coords_table, flag)
			if flag == nil then
				if coords_table ~= nil then
					for index = 1, #coords_table do
						local coord = coords_table[index];
						local map = coord[3];
						local varied = META_VARIED[map];
						if varied == nil then
							varied = {  };
							META_VARIED[map] = varied;
						end
						local data = varied[uuid];
						if data == nil then
							data = { {  }, {  }, };
							varied[uuid] = data;
						end
						local coords = data[1];
						coords[#coords + 1] = coord;
						if map == mm_map then
							mm_force_update = true;
						end
					end
				end
			else
				if UUIDCheckStateVaried(uuid) then
					WorldMap_ChangeVariedNodesMapUUID(wm_map, uuid);
					Minimap_ChangeVariedNodesMapUUID(mm_map, uuid);
				else
					WorldMap_HideVariedNodesMapUUID(wm_map, uuid);
					Minimap_HideVariedNodesMapUUID(mm_map, uuid);
				end
			end
		end
		function MapDelVariedNodes(uuid, del, flag)
			WorldMap_HideVariedNodesMapUUID(wm_map, uuid);
			Minimap_HideVariedNodesMapUUID(mm_map, uuid);
			for map, varied in next, META_VARIED do
				local data = varied[uuid];
				if data ~= nil then
					varied[uuid] = nil;
				end
			end
		end
		function MapUpdVariedNodes(uuid)
			if not UUIDCheckStateVaried(uuid) then
				WorldMap_HideVariedNodesMapUUID(wm_map, uuid);
				Minimap_HideVariedNodesMapUUID(mm_map, uuid);
			end
		end
		--
		function MapTemporarilyShowQuestNodes(quest)
			if QUEST_TEMPORARILY_BLOCKED[quest] == true then
				QUEST_TEMPORARILY_BLOCKED[quest] = nil;
				WorldMap_ShowNodesQuest(wm_map, quest);
				Minimap_ShowNodesMapQuest(mm_map, quest);
			end
		end
		function MapTemporarilyHideQuestNodes(quest)
			if QUEST_TEMPORARILY_BLOCKED[quest] ~= true then
				QUEST_TEMPORARILY_BLOCKED[quest] = true;
				WorldMap_HideNodesQuest(wm_map, quest);
				Minimap_HideNodesQuest(quest);
			end
		end
		function MapResetTemporarilyQuestNodesFilter()
			wipe(QUEST_TEMPORARILY_BLOCKED);
			MapDrawNodes();
		end
		function MapPermanentlyShowQuestNodes(quest)
			if QUEST_PERMANENTLY_BLOCKED[quest] == true then
				QUEST_PERMANENTLY_BLOCKED[quest] = nil;
				for index = #QUEST_PERMANENTLY_BL_LIST, 1, -1 do
					if QUEST_PERMANENTLY_BL_LIST[index] == quest then
						tremove(QUEST_PERMANENTLY_BL_LIST, index);
						break;
					end
				end
				WorldMap_ShowNodesQuest(wm_map, quest);
				Minimap_ShowNodesMapQuest(mm_map, quest);
				__ns.RefreshBlockedList();
			end
		end
		function MapPermanentlyHideQuestNodes(quest)
			if QUEST_PERMANENTLY_BLOCKED[quest] ~= true then
				QUEST_PERMANENTLY_BLOCKED[quest] = true;
				QUEST_PERMANENTLY_BL_LIST[#QUEST_PERMANENTLY_BL_LIST + 1] = quest;
				WorldMap_HideNodesQuest(wm_map, quest);
				Minimap_HideNodesQuest(quest);
				__ns.RefreshBlockedList();
			end
		end
		function MapPermanentlyToggleQuestNodes(quest)
			if QUEST_PERMANENTLY_BLOCKED[quest] == true then
				QUEST_PERMANENTLY_BLOCKED[quest] = nil;
				for index = #QUEST_PERMANENTLY_BL_LIST, 1, -1 do
					if QUEST_PERMANENTLY_BL_LIST[index] == quest then
						tremove(QUEST_PERMANENTLY_BL_LIST, index);
						break;
					end
				end
				WorldMap_ShowNodesQuest(wm_map, quest);
				Minimap_ShowNodesMapQuest(mm_map, quest);
			else
				QUEST_PERMANENTLY_BLOCKED[quest] = true;
				QUEST_PERMANENTLY_BL_LIST[#QUEST_PERMANENTLY_BL_LIST + 1] = quest;
				WorldMap_HideNodesQuest(wm_map, quest);
				Minimap_HideNodesQuest(quest);
			end
			__ns.RefreshBlockedList();
		end
		--
		function MapDrawNodes()
			WorldMap_DrawNodesMap(wm_map);
			Minimap_DrawNodesMap(mm_map);
		end
		function MapHideNodes()
			WorldMap_HideNodesMap(wm_map);
			Minimap_HideNodes();
		end
		--
	-->
	-->		--	setting
		--	set pin
		function SetShowPinInContinent()
			if ContinentMapID[wm_map] ~= nil then
				if SET.show_in_continent then
					WorldMap_DrawNodesMap(wm_map);
				else
					WorldMap_HideNodesMap(wm_map);
				end
			end
		end
		function SetWorldmapAlpha()
			wm_wrap:SetAlpha(SET.worldmap_alpha);
		end
		function SetMinimapAlpha()
			mm_wrap:SetAlpha(SET.minimap_alpha);
		end
		function SetCommonPinSize()
			--	pool_worldmap_common_pin_inuse, pool_worldmap_common_pin_unused, MM_COMMON_PINS
			pin_size = SET.pin_size;
			for _, pin in next, MM_COMMON_PINS do
				pin:SetSize(pin_size, pin_size);
			end
			local scale = map_canvas_scale;
			local pin_scale_max = SET.pin_scale_max;
			if scale > pin_scale_max then
				pin_size = pin_size * pin_scale_max / scale;
			end
			for pin, _ in next, pool_worldmap_common_pin_inuse do
				pin:SetSize(pin_size, pin_size);
			end
		end
		function SetLargePinSize()
			--	pool_worldmap_large_pin_inuse, pool_worldmap_large_pin_unused, MM_LARGE_PINS
			large_size = SET.large_size;
			for _, pin in next, MM_LARGE_PINS do
				pin:SetSize(large_size, large_size);
			end
			local scale = map_canvas_scale;
			local pin_scale_max = SET.pin_scale_max;
			if scale > pin_scale_max then
				large_size = large_size * pin_scale_max / scale;
			end
			for pin, _ in next, pool_worldmap_large_pin_inuse do
				pin:SetSize(large_size, large_size);
			end
		end
		function SetVariedPinSize()
			--	pool_worldmap_varied_pin_inuse, pool_worldmap_varied_pin_unused, MM_VARIED_PINS
			varied_size = SET.varied_size;
			for _, pin in next, MM_VARIED_PINS do
				pin:SetSize(varied_size, varied_size);
			end
			local scale = map_canvas_scale;
			local pin_scale_max = SET.pin_scale_max;
			if scale > pin_scale_max then
				varied_size = varied_size * pin_scale_max / scale;
			end
			for pin, _ in next, pool_worldmap_varied_pin_inuse do
				pin:SetSize(varied_size, varied_size);
			end
		end
		function SetHideNodeModifier()
			local modifier = SET.hide_node_modifier;
			if modifier == "SHIFT" then
				hide_node_modifier = IsShiftKeyDown;
			elseif modifier == "CTRL" then
				hide_node_modifier = IsControlKeyDown;
			elseif modifier == "ALT" then
				hide_node_modifier = IsAltKeyDown;
			end
		end
		function SetMinimapNodeInset()
			minimap_node_inset = SET.minimap_node_inset;
			Minimap_HideNodes();
			Minimap_DrawNodesMap(mm_map);
		end
		function SetMinimapPlayerArrowOnTop()
			mm_arrow_wrap:SetShown(SET.minimap_player_arrow_on_top);
		end
	-->
	-->		--	extern method
		--
		__ns.SetShowPinInContinent = SetShowPinInContinent;
		__ns.SetWorldmapAlpha = SetWorldmapAlpha;
		__ns.SetMinimapAlpha = SetMinimapAlpha;
		__ns.SetCommonPinSize = SetCommonPinSize;
		__ns.SetLargePinSize = SetLargePinSize;
		__ns.SetVariedPinSize = SetVariedPinSize;
		__ns.SetHideNodeModifier = SetHideNodeModifier;
		__ns.SetMinimapNodeInset = SetMinimapNodeInset;
		__ns.SetMinimapPlayerArrowOnTop = SetMinimapPlayerArrowOnTop;
		--
		__ns.MapAddCommonNodes = MapAddCommonNodes;
		__ns.MapDelCommonNodes = MapDelCommonNodes;
		__ns.MapUpdCommonNodes = MapUpdCommonNodes;
		__ns.MapAddLargeNodes = MapAddLargeNodes;
		__ns.MapDelLargeNodes = MapDelLargeNodes;
		__ns.MapUpdLargeNodes = MapUpdLargeNodes;
		__ns.MapAddVariedNodes = MapAddVariedNodes;
		__ns.MapDelVariedNodes = MapDelVariedNodes;
		__ns.MapUpdVariedNodes = MapUpdVariedNodes;
		__ns.MapTemporarilyShowQuestNodes = MapTemporarilyShowQuestNodes;
		__ns.MapTemporarilyHideQuestNodes = MapTemporarilyHideQuestNodes;
		__ns.MapResetTemporarilyQuestNodesFilter = MapResetTemporarilyQuestNodesFilter;
		__ns.MapPermanentlyShowQuestNodes = MapPermanentlyShowQuestNodes;
		__ns.MapPermanentlyHideQuestNodes = MapPermanentlyHideQuestNodes;
		__ns.MapPermanentlyToggleQuestNodes = MapPermanentlyToggleQuestNodes;
		--
		__ns.MapDrawNodes = MapDrawNodes;
		__ns.MapHideNodes = MapHideNodes;
		__ns.Pin_OnEnter = Pin_OnEnter;
		--
		function __ns.map_reset()
			wipe(META_COMMON);
			wipe(META_LARGE);
			wipe(META_VARIED);
			ResetWMPin();
			wipe(MM_COMMON_PINS);
			wipe(MM_LARGE_PINS);
			wipe(MM_VARIED_PINS);
			ResetMMPin();
		end
		function __ns.map_ToggleWorldMapPin(shown)
			wm_wrap:SetShown(shown ~= false);
		end
		function __ns.map_ToggleMinimapPin(shown)
			mm_wrap:SetShown(shown ~= false);
		end
	-->
	-->		--	events and hooks
		-->		--	MapCanvasDataProvider
			local mapCallback = CreateFromMixins(MapCanvasDataProviderMixin);
			function mapCallback:RemoveAllData()
				-- Override in your mixin, this method should remove everything that has been added to the map
			end
			function mapCallback:RefreshAllData(fromOnShow)
				-- Override in your mixin, this method should assume the map is completely blank, and refresh any data necessary on the map
			end
			function mapCallback:OnShow()
				-- Override in your mixin, called when the map canvas is shown
			end
			function mapCallback:OnHide()
				-- Override in your mixin, called when the map canvas is closed
			end
			function mapCallback:OnMapChanged()
				--  Optionally override in your mixin, called when map ID changes
				-- self:RefreshAllData();
				--[=[dev]=]	if __ns.__is_dev then __ns._F_devDebugProfileStart('module.map.mapCallback:OnMapChanged'); end
				local uiMapID = WorldMapFrame:GetMapID();
				if uiMapID ~= wm_map then
					WorldMap_HideNodesMap(wm_map);
					wm_map = uiMapID;
					WorldMap_DrawNodesMap(uiMapID);
				end
				--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.map.mapCallback:OnMapChanged'); end
			end
			function mapCallback:OnCanvasScaleChanged()
				local scale = mapCanvas:GetScale();
				if map_canvas_scale ~= scale then
					--[=[dev]=]	if __ns.__is_dev then __ns._F_devDebugProfileStart('module.map.mapCallback:OnCanvasScaleChanged'); end
					map_canvas_scale = scale;
					local pin_scale_max = SET.pin_scale_max;
					--
					pin_size = SET.pin_size;
					if scale > pin_scale_max then
						pin_size = pin_size * pin_scale_max / scale;
					end
					--
					large_size = SET.large_size;
					if scale > pin_scale_max then
						large_size = large_size * pin_scale_max / scale;
					end
					--
					varied_size = SET.varied_size;
					if scale > pin_scale_max then
						varied_size = varied_size * pin_scale_max / scale;
					end
					IterateWorldMapPinSetSize();
					--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.map.mapCallback:OnCanvasScaleChanged'); end
				end
			end
			function mapCallback:OnCanvasSizeChanged()
			end
		-->
		function __ns.__PLAYER_ZONE_CHANGED(map)
			mm_map = map;
			Minimap_HideNodes();
			Minimap_DrawNodesMap(map);
		end
	-->
	function __ns.map_setup()
		SET = __ns.__setting;
		QUEST_TEMPORARILY_BLOCKED = __ns.__quest_temporarily_blocked;
		QUEST_PERMANENTLY_BLOCKED = __ns.__quest_permanently_blocked;
		QUEST_PERMANENTLY_BL_LIST = __ns.__quest_permanently_bl_list;
		-- local HBD = LibStub("HereBeDragons-2.0");
		-- local mapData = HBD.mapData;
		-- --	{ width, height, left, top, instance = instance, name = name, mapType = mapType, parent = parent }
		-- for id, data in next, mapData do
		-- 	if data[1] == 0 or data[2] == 0 then
		-- 		local newData = {  };
		-- 		for id, data in next, mapData do
		-- 			if data[1] ~= 0 and data[2] ~= 0 then
		-- 				newData[id] = data;
		-- 			end
		-- 		end
		-- 		mapData = newData;
		-- 		_log_("rehash map");
		-- 		break;
		-- 	end
		-- end
		-- __ns.HDB = HDB;
		-- __ns.mapData = mapData;
		-- function __ns.GetWorldCoordinatesFromZone(zone, x, y)
		-- 	local data = mapData[zone];
		-- 	if data then
		-- 		x, y = data[3] - data[1] * x, data[4] - data[2] * y;
		-- 		return x, y, data.instance;
		-- 	end
		-- end
		WorldMapFrame:AddDataProvider(mapCallback);
		wm_map = -1;
		mapCallback:OnMapChanged();
		__eventHandler:RegEvent("MINIMAP_UPDATE_ZOOM");
		__eventHandler:RegEvent("CVAR_UPDATE");
		mm_is_rotate = GetCVar("rotateMinimap") == "1";
		Minimap:HookScript("OnUpdate", Minimap_OnUpdate);
		--
		SetWorldmapAlpha();
		SetMinimapAlpha();
		local pin_scale_max = SET.pin_scale_max;
		pin_size = SET.pin_size;
		if map_canvas_scale > pin_scale_max then
			pin_size = pin_size * pin_scale_max / map_canvas_scale;
		end
		large_size = SET.large_size;
		if map_canvas_scale > pin_scale_max then
			large_size = large_size * pin_scale_max / map_canvas_scale;
		end
		varied_size = SET.varied_size;
		if map_canvas_scale > pin_scale_max then
			varied_size = varied_size * pin_scale_max / map_canvas_scale;
		end
		SetHideNodeModifier();
		minimap_node_inset = SET.minimap_node_inset;
		SetMinimapPlayerArrowOnTop();
	end
-->

-->		dev
-->

--[=[dev]=]	if __ns.__is_dev then __ns.__performance_log_tick('module.map'); end

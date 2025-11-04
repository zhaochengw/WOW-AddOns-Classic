local _, addon = ...

--[[ namespace:CreateFrame(_..._) ![](https://img.shields.io/badge/function-blue)
A wrapper for [`CreateFrame`](https://warcraft.wiki.gg/wiki/API_CreateFrame), mixed in with `namespace.eventMixin`.
--]]
function addon:CreateFrame(...)
	return Mixin(CreateFrame(...), addon.eventMixin)
end

local KEY_DIRECTION_CVAR = 'ActionButtonUseKeyDown'

local function updateKeyDirection(self)
	if C_CVar.GetCVarBool(KEY_DIRECTION_CVAR) then
		self:RegisterForClicks('AnyDown')
	else
		self:RegisterForClicks('AnyUp')
	end
end

local function onCVarUpdate(self, cvar)
	if cvar == KEY_DIRECTION_CVAR then
		addon:Defer(updateKeyDirection, self)
	end
end

--[[ namespace:CreateButton(...) ![](https://img.shields.io/badge/function-blue)
A wrapper for `namespace:CreateFrame(...)`, but will handle key direction preferences of the client.  
Use this specifically to create clickable buttons.
--]]
function addon:CreateButton(...)
	local button = addon:CreateFrame(...)
	button:RegisterEvent('CVAR_UPDATE', onCVarUpdate)

	-- the CVar doesn't trigger during login, so we'll have to trigger the handlers ourselves
	onCVarUpdate(button, KEY_DIRECTION_CVAR)

	return button
end

do -- scrollbox
	local function defaultSort(a, b)
		-- convert to string first so we can sort mixed types
		return tostring(a) > tostring(b)
	end

	local function initialize(scroll)
		if scroll._provider then
			return
		end

		-- TODO: assertions

		local view
		if scroll.kind == 'list' then
			view = CreateScrollBoxListLinearView(scroll._insetTop or 0, scroll._insetBottom or 0, scroll._insetLeft or 0, scroll._insetRight or 0, scroll._spacingHorizontal or 0)
			view:SetElementExtentCalculator(function()
				return scroll._elementHeight
			end)
		elseif scroll.kind == 'grid' then
			local width = scroll:GetWidth() - scroll.bar:GetWidth() - (scroll._insetLeft or 0) - (scroll._insetRight or 0)
			local stride = math.floor((width - (scroll._spacingHorizontal or 0)) / (scroll._elementWidth + (scroll._spacingHorizontal or 0)))
			view = CreateScrollBoxListGridView(stride or 1, scroll._insetTop or 0, scroll._insetBottom or 0, scroll._insetLeft or 0, scroll._insetRight or 0, scroll._spacingHorizontal or 0, scroll._spacingVertical or 0)
			view:SetStrideExtent(scroll._elementWidth)
			view:SetElementSizeCalculator(function()
				return scroll._elementWidth, scroll._elementHeight
			end)
		end

		view:SetElementInitializer(scroll._elementType, function(element, data)
			if scroll._elementWidth and scroll.kind == 'grid' then
				element:SetWidth(scroll._elementWidth)
			end
			if scroll._elementHeight then
				element:SetHeight(scroll._elementHeight)
			end

			if not element._initialized then
				element._initialized = true

				if scroll._scripts then
					for script, callback in next, scroll._scripts do
						element:SetScript(script, callback)

						if script == 'OnEnter' and not scroll._scripts.OnLeave then
							element:SetScript('OnLeave', GameTooltip_Hide)
						end
					end
				end

				if scroll._onLoad then
					local successful, err = pcall(scroll._onLoad, element)
					if not successful then
						error(err)
					end
				end
			end

			element.data = data

			if scroll._onUpdate then
				local successful, err = pcall(scroll._onUpdate, element, data)
				if not successful then
					error(err)
				end
			end
		end)

		if scroll._onReset then
			scroll:HookScript('OnHide', function()
				for _, element in next, view:GetFrames() do
					local successful, err = pcall(scroll._onReset, element)
					if not successful then
						error(err)
					end
				end
			end)
		end

		ScrollUtil.InitScrollBoxListWithScrollBar(scroll, scroll.bar, view)
		ScrollUtil.AddManagedScrollBarVisibilityBehavior(scroll, scroll.bar) -- auto-hide the scroll bar

		local provider = CreateDataProvider()
		provider:SetSortComparator(scroll._sort or defaultSort, true)
		view:SetDataProvider(provider)
		scroll._provider = provider
	end

	local scrollMixin = {}
	function scrollMixin:SetInsets(top, bottom, left, right)
		self._insetTop = top
		self._insetBottom = bottom
		self._insetLeft = left
		self._insetRight = right
	end
	function scrollMixin:SetElementType(kind)
		self._elementType = kind
	end
	function scrollMixin:SetElementHeight(height)
		self._elementHeight = height
	end
	function scrollMixin:SetElementWidth(width)
		self._elementWidth = width
	end
	function scrollMixin:SetElementSize(width, height)
		self:SetElementWidth(width)
		self:SetElementHeight(height or width)
	end
	function scrollMixin:SetElementSpacing(horizontal, vertical)
		self._spacingHorizontal = horizontal
		self._spacingVertical = vertical or horizontal
	end
	function scrollMixin:SetElementSortingMethod(callback)
		self._sort = callback
	end
	function scrollMixin:SetElementOnLoad(callback)
		self._onLoad = callback
	end
	function scrollMixin:SetElementOnScript(script, callback)
		self._scripts = self._scripts or {}
		self._scripts[script] = callback
	end
	function scrollMixin:SetElementOnUpdate(callback)
		self._onUpdate = callback
	end
	function scrollMixin:SetElementOnReset(callback)
		self._onReset = callback
	end
	function scrollMixin:AddData(...)
		initialize(self)
		self._provider:Insert(...)
	end
	function scrollMixin:AddDataByKeys(data)
		for key, value in next, data do
			if value then -- must be truthy
				self:AddData(key)
			end
		end
	end
	function scrollMixin:RemoveData(...)
		self._provider:Remove(...)
	end
	function scrollMixin:ResetData()
		self._provider:Flush()
	end

	local function createScrollWidget(parent, kind)
		local box = CreateFrame('Frame', nil, parent, 'WowScrollBoxList')
		box:SetPoint('TOPLEFT')
		box:SetPoint('BOTTOMRIGHT', -8, 0) -- offset to not overlap scrollbar
		box.kind = kind

		local bar = CreateFrame('EventFrame', nil, parent, 'MinimalScrollBar')
		bar:SetPoint('TOPLEFT', box, 'TOPRIGHT')
		bar:SetPoint('BOTTOMLEFT', box, 'BOTTOMRIGHT')
		box.bar = bar

		return Mixin(box, scrollMixin)
	end

	--[[ namespace:CreateScrollList(_parent_) ![](https://img.shields.io/badge/function-blue)
	Creates and returns a scroll box with scroll bar and a data provider in a list representation.  
	It gets automatically sized to fill the space of the parent.

	It provides the following methods, and is initialized whenever data is provided, so do that last.

	* `list:SetInsets([top], [bottom], [left], [right])` - sets scroll box insets (all optional)
	* `list:SetElementType(kind)` - sets the element type or template (required)
	* `list:SetElementHeight(height)` - sets the element height (required)
	* `list:SetElementSpacing(spacing)` - sets the spacing between elements (optional)
	* `list:SetElementSortingMethod(callback)` - sets the sort method for element data (optional)
	* `list:SetElementOnLoad(callback)` - sets the OnLoad method for each element (optional)
	    * the callback signature is `(element)`
	* `list:SetElementOnUpdate(callback)` - sets the callback for element data updates (optional)
	    * the callback signature is `(element, data)`
	* `list:SetElementOnScript(script, callback)` - sets the script handler for an element (optional)
	* `list:AddData(...)`
	* `list:AddDataByKeys(table)`
	* `list:RemoveData(...)`
	* `list:ResetData()`
	--]]
	function addon:CreateScrollList(parent)
		return createScrollWidget(parent, 'list')
	end

	--[[ namespace:CreateScrollGrid(_parent_) ![](https://img.shields.io/badge/function-blue)
	Creates and returns a scroll box with scroll bar and a data provider in a grid representation.  
	It gets automatically sized to fill the space of the parent.

	It provides the following methods, and is initialized whenever data is provided, so do that last.

	* `grid:SetInsets([top], [bottom], [left], [right])` - sets scroll box insets (all optional)
	* `grid:SetElementType(kind)` - sets the element type or template (required)
	* `grid:SetElementHeight(height)` - sets the element height (required)
	* `grid:SetElementWidth(width)` - sets the element width (required)
	* `grid:SetElementSize(width[, height])` - sets the element width and height, shorthand for the two above, height falls back to width if not provided
	* `grid:SetElementSpacing(horizontal[, vertical])` - sets the spacing between elements, vertical falls back to horizontal if not provided  (optional)
	* `grid:SetElementSortingMethod(callback)` - sets the sort method for element data (optional)
	* `grid:SetElementOnLoad(callback)` - sets the OnLoad method for each element (optional)
	    * the callback signature is `(element)`
	* `grid:SetElementOnUpdate(callback)` - sets the callback for element data updates (optional)
	    * the callback signature is `(element, data)`
	* `grid:SetElementOnScript(script, callback)` - sets the script handler for an element (optional)
	* `grid:AddData(...)`
	* `grid:AddDataByKeys(table)`
	* `grid:RemoveData(...)`
	* `grid:ResetData()`
	--]]
	function addon:CreateScrollGrid(parent)
		return createScrollWidget(parent, 'grid')
	end
end

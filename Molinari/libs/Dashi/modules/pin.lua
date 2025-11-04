local addonName, addon = ...

do
	local function resetPin(_, pin)
		pin:Hide()
		pin:ClearAllPoints()
		pin:OnReleased()

		if pin.highlightTexture then
			pin.highlightTexture:Hide()
		end
	end

	local mixin = CreateFromMixins(MapCanvasPinMixin)
	function mixin:SetPassThroughButtons()
		-- don't let the protected method be called willy-nilly
		-- https://github.com/Stanzilla/WoWUIBugs/issues/453
	end

	local function getOrCreateTexture(parent, layer, key)
		if not parent[key] then
			parent[key] = parent:CreateTexture(nil, layer)
			parent[key]:SetAllPoints()
		end
		return parent[key]
	end

	-- replicate Button methods
	function mixin:SetNormalTexture(...)
		getOrCreateTexture(self, 'ARTWORK', 'normalTexture'):SetTexture(...)
	end

	function mixin:GetNormalTexture()
		return getOrCreateTexture(self, 'ARTWORK', 'normalTexture')
	end

	function mixin:SetNormalAtlas(...)
		getOrCreateTexture(self, 'ARTWORK', 'normalTexture'):SetAtlas(...)
	end

	function mixin:SetHighlightTexture(textureFile, blendMode)
		local texture = getOrCreateTexture(self, 'OVERLAY', 'highlightTexture')
		texture:Hide()
		texture:SetTexture(textureFile)
		texture:SetBlendMode(blendMode or 'BLEND')
	end

	function mixin:SetHighlightAtlas(atlas, blendMode)
		local texture = getOrCreateTexture(self, 'OVERLAY', 'highlightTexture')
		texture:Hide()
		texture:SetAtlas(atlas)
		texture:SetBlendMode(blendMode or 'BLEND')
	end

	function mixin:GetHighlightTexture()
		return getOrCreateTexture(self, 'OVERLAY', 'highlightTexture')
	end

	-- mouse event handling
	local mouseMixin = {}
	function mouseMixin:OnClick(...)
		if self.parent.OnPinClick then
			pcall(self.parent.OnPinClick, self.parent, ...)
		end
	end

	function mouseMixin:OnEnter()
		if self.parent.OnPinEnter then
			pcall(self.parent.OnPinEnter, self.parent)
		end
		if self.parent.highlightTexture then
			self.parent.highlightTexture:Show()
		end
	end

	function mouseMixin:OnLeave()
		if self.parent.OnPinLeave then
			pcall(self.parent.OnPinLeave, self.parent)
		end
		if self.parent.highlightTexture then
			self.parent.highlightTexture:Hide()
		end
	end

	--[[ namespace:CreateMapPinTemplate(_name_[, _pinMixin_]) ![](https://img.shields.io/badge/function-blue)
	Creates and returns a world map pin template and pool with safe passthrough button support.  
	The `pinMixin` inherits `MapCanvasPinMixin`.
	--]]
	function addon:CreateMapPinTemplate(name, pinMixin)
		-- TODO: assertions
		pinMixin = pinMixin or {}

		local templateName = addonName .. name .. 'PinTemplate'
		local pool = CreateUnsecuredRegionPoolInstance(templateName)
		pool.resetFunc = resetPin
		pool.createFunc = function()
			local pin = Mixin(CreateFrame('Frame', nil, WorldMapFrame:GetCanvas()), mixin, pinMixin)
			pin:SetSize(1, 1) -- needs a size to even show up

			-- instead of using a Button frame type for the pin (to avoid a shitload of taint) we
			-- add our own mouse region on top of a normal frame, then do some tricks to make the
			-- pin act like a Button
			local mouseRegion = CreateFrame('Button', nil, pin)
			mouseRegion:SetAllPoints()
			mouseRegion:SetScript('OnClick', mouseMixin.OnClick)
			mouseRegion:SetScript('OnEnter', mouseMixin.OnEnter)
			mouseRegion:SetScript('OnLeave', mouseMixin.OnLeave)
			mouseRegion:RegisterForClicks('AnyUp') -- maybe too generous
			mouseRegion.parent = pin

			return pin
		end

		return templateName, pool
	end
end

do
	local mixin = {}
	function mixin:SetPinTemplate(templateName)
		self.pinTemplateName = templateName
	end

	function mixin:GetPinTemplate()
		return self.pinTemplateName
	end

	-- shorthands for pin handling
	function mixin:AcquirePin(...)
		return self:GetMap():AcquirePin(self:GetPinTemplate(), ...)
	end

	function mixin:RemoveAllPins()
		return self:GetMap():RemoveAllPinsByTemplate(self:GetPinTemplate())
	end

	function mixin:EnumeratePins()
		return self:GetMap():EnumeratePinsByTemplate(self:GetPinTemplate())
	end

	function mixin:GetNumPins()
		local template = self:GetPinTemplate()
		return template and self:GetMap():GetNumActivePinsByTemplate(template) or 0
	end

	function mixin:HasPins()
		return self:GetNumPins() > 0
	end

	-- taint-safe event handling
	function mixin:RegisterEvent(event)
		if not self.frameEvents then
			self.frameEvents = {}
		end

		if not self.frameEventsHandler then
			self.frameEventsHandler = CreateFrame('Frame')
			self.frameEventsHandler:SetScript('OnEvent', function(_, ...)
				self:OnEvent(...)
			end)
		end

		if not self.frameEvents[event] then
			self.frameEventsHandler:RegisterEvent(event)
			self.frameEvents[event] = true
		end
	end

	function mixin:UnregisterEvent(event)
		if not self.frameEvents then
			return
		end

		if self.frameEvents[event] then
			self.frameEvents[event] = nil
			self.frameEventsHandler:UnregisterEvent(event)
		end
	end

	--[=[ namespace:AddMapPinProvider(_name_[, _pinMixin_[, _providerMixin_]]) ![](https://img.shields.io/badge/function-blue)
	Creates, registers, and returns a world map pin provider (and pins) with a few features:

	* taint-safe passthrough right button for the pins (see [namespace:CreateMapPinTemplate()](#namespacecreatemappintemplate-name-pinmixin-))
	* taint-safe event handler (same API as `MapCanvasDataProviderMixin` which it inherits)
	* short-hands for pin management:
	  * `self:AcquirePin([...])`
	  * `self:RemoveAllPins()`
	  * `self:EnumeratePins()`
	  * `self:GetNumPins()`
	  * `self:HasPins()`
	--]=]
	function addon:AddMapPinProvider(name, providerMixin, pinMixin)
		-- TODO: assertions
		providerMixin = providerMixin or {}
		pinMixin = pinMixin or {}

		-- wrap super calls
		if providerMixin.OnAdded then
			local providerMixinOnAdded = providerMixin.OnAdded
			providerMixin.OnAdded = function(provider, ...)
				MapCanvasDataProviderMixin.OnAdded(provider, ...)
				providerMixinOnAdded(provider, ...)
			end
		end
		if providerMixin.OnRemoved then
			local providerMixinOnRemoved = providerMixin.OnRemoved
			providerMixin.OnRemoved = function(provider, ...)
				providerMixinOnRemoved(provider, ...)
				MapCanvasDataProviderMixin.OnRemoved(provider, ...)
			end
		end

		local provider = CreateFromMixins(MapCanvasDataProviderMixin, mixin, providerMixin)

		local pinTemplate, pinPool = addon:CreateMapPinTemplate(name, pinMixin)
		provider:SetPinTemplate(pinTemplate)

		if WorldMapFrame.pinPools[pinTemplate] then
			error('pinTemplate must be unique')
		end
		WorldMapFrame.pinPools[pinTemplate] = pinPool
		WorldMapFrame:AddDataProvider(provider)

		return provider
	end
end

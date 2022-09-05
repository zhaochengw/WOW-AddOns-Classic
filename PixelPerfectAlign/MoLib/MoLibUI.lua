--[[
  MoLib (GUI part) -- (c) 2019 moorea@ymail.com (MooreaTv)
  Covered by the GNU Lesser General Public License v3.0 (LGPLv3)
  NO WARRANTY
  (contact the author if you need a different license)
]] --
-- our name, our empty default (and unused) anonymous ns
local addonName, _ns = ...

local ML = _G[addonName]

if ML.isLegacy then
  function GetPhysicalScreenSize()
    local width, height = strmatch(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x(%d+)")
	  return tonumber(width), tonumber(height)
  end
end

ML.id = 0
function ML:NextId()
  self.id = self.id + 1
  return self.id
end

-- use 2 or 4 for sizes so there are 1/2, 1/4 points
-- can also be used for numbers passing .1, .01 etc for n digits precision
function ML:round(x, precision)
  precision = precision or 1
  if precision < 1 then
    -- when called with .1, .01 ... and we turn it into 1/10 1/100 ...
    local p = math.floor(1 / precision + 0.5)
    return math.floor(x * p + 0.5) / p
  end
  local i = math.floor(x / precision + 0.5) * precision
  return i
end

-- for sizes, don't shrink but also... 0.9 because floating pt math
-- also works symmetrically for negative numbers (ie round up -1.3 -> -2)
function ML:roundUp(x, precision)
  precision = precision or 1
  local sign = 1
  if x < 0 then
    sign = -1
    x = -x
  end
  local i = math.ceil(x / precision - 0.1) * precision
  return sign * i
end

function ML:scale(x, s, precision)
  return ML:round(x * s, precision) / s
end

function ML:scaleUp(x, s, precision)
  return ML:roundUp(x * s, precision) / s
end

-- Makes sure the frame has the right pixel alignment and same padding with respect to
-- bottom right corner that it has on top left with its children objects.
-- returns a new scale to potentially be used if not recalculating the bottom right margins
function ML:SnapFrame(f)
  return self:PixelPerfectSnap(f, 2, true) -- 2 so we get dividable by 2 dimensions, true = from top and not bottom corner
end

function ML:NormalizeFont(font)
  if not font then
    self:Debug(4, "leaving unspecified font %", font)
    return font
  end
  local fontObj = font
  if type(font) == "string" then
    if _G[font] then
      fontObj = _G[font]
    else
      ML:DebugStack("Invalid font name %", font)
      return nil
    end
  end
  return fontObj
end

-- WARNING, Y axis is such as positive is down, unlike rest of the wow api which has + offset going up
-- but all the negative numbers all over, just for Y axis, got to me

-- physical screen based attached frame (used to be WorldFrame but that can be moved)
function ML.ScreenFrame(addon)
  return addon:Frame(nil, nil, nil, addon:PixelPerfectFrame(true))
end

if ML.isLegacy and C_Timer == nil then
  C_Timer = {}
  C_Timer.timers = {}
  local timerFrame = CreateFrame("Frame", "C_TimerFrame")
  function ML.TimerOnUpdate(_self, elapsed)
    ML:Debug(9, "C_TimerOnUpdate elapsed %", elapsed)
    for i, v in ipairs(C_Timer.timers) do
      ML:Debug(9, "C_TimerOnUpdate timer %: %", i, v)
      if v.cancelled then
        table.remove(C_Timer.timers, i)
        break
      end
      if v.timeLeft < 0 then
        v.callback()
        if v.iterations ~= nil then
          v.iterations = v.iterations - 1
          if v.iterations <= 0 then
            table.remove(C_Timer.timers, i)
          end
        end
        v.timeLeft = v.duration
      else
        v.timeLeft = v.timeLeft - elapsed
      end
    end
  end
  timerFrame:SetScript("OnUpdate",ML.TimerOnUpdate)
  function C_Timer.NewTicker(duration, callback, iterations)
    local t = {
      duration = duration,
      timeLeft = duration,
      callback = callback,
      iterations = iterations,
      cancelled = false,
      Cancel = function(self)
        self.cancelled = true
      end,
      IsCancelled = function(self)
        return self.cancelled
      end
    }
    table.insert(C_Timer.timers, t)
    return t
  end
  function C_Timer.NewTimer(duration, callback)
    C_Timer.NewTicker(duration, callback, 1)
  end
  function C_Timer.After(duration, callback)
    C_Timer.NewTicker(duration, callback, 1)
  end
  function GetServerTime()
    return time()
  end
end

function ML:SetDebugBackground(f, alpha, ...)
  f.bg = f:CreateTexture(nil, "BACKGROUND")
  if ML.isLegacy then
    f.bg:SetTexture(...)
  else
    f.bg:SetColorTexture(...)
    f.bg:SetIgnoreParentAlpha(true)
  end
  f.bg:SetAlpha(alpha)
  f.bg:SetAllPoints()
end

-- parent should be null or a child or grandchild of a pixelPerfectFrame()
function ML.Frame(addon, name, global, template, parent, typ) -- to not shadow self below but really call with Addon:Frame(name)
  local f = CreateFrame(typ or "Frame", global, parent or addon:PixelPerfectFrame(), template)
  f:SetSize(1, 1) -- need a starting size for most operations
  local ct = f.CreateTexture
  f.CreateTexture = function(w,...)
    local t = ct(w,...)
    if t.SetColorTexture == nil then
      t.SetColorTexture = t.SetTexture
    end
    return t
  end
  if addon.debug and addon.debug >= 8 then
    addon:Debug(8, "Debug level 8 is on, putting debug background on frame %", name)
    addon:SetDebugBackground(f, 0.2, .1, .2, .7)
  end
  f.name = name
  f.children = {}
  f.numObjects = 0

  -- either a font name or a font object, convert to object
  f.SetDefaultFont = function(w, font)
    w.defaultFont = addon:NormalizeFont(font)
  end

  f.Snap = function(w)
    addon:GridUpdateHeader(w)
    w:setSizeToChildren()
    addon:SnapFrame(w)
  end

  f.Scale = function(w, ...)
    w:setScale(...)
  end

  f.ChangeScale = function(w, newScale)
    addon:ChangeScale(w, newScale)
  end

  f.Init = function(self)
    addon:Debug("Calling Init() on all % children", #self.children)
    for _, v in ipairs(self.children) do
      v:Init()
    end
  end

  -- returns opposite corners 4 coordinates:
  -- BottomRight(x,y) , TopLeft(x,y)
  f.calcCorners = function(self)
    local minX = 99999999
    local maxX = 0
    local minY = 99999999
    local maxY = 0
    local numChildren = 0
    local fx = self:GetLeft()
    local fy = self:GetTop()
    for _, v in ipairs(self.children) do
      local x = v:GetRight() or 0
      local l = v:GetLeft() or 0
      local y = v:GetBottom() or 0
      local t = v:GetTop() or 0
      local extraW = v.extraWidth or 0
      local extraH = v.extraHeight or 0
      -- ignore nil strings (which have wild width somehow)
      local validChildren = (v.GetText == nil) or (v:GetText() ~= nil and #v:GetText() > 0)
      if v.GetStringWidth and validChildren then
        -- recover from the ... truncation
        local curW = ML:round(x - l, 0.001)
        local strWextra = ML:round(v:GetStringWidth() + extraW, 0.001)
        if strWextra ~= curW then
          local nx = l + v:GetStringWidth() + extraW -- not rounding here
          addon:Debug(4, "changing font coords for % % to % because of str width % vs cur w %", v:GetText(), x, nx,
                      strWextra, curW)
          x = nx
          -- We need to ignore/fix the height as it's also wrong and GetStringHeight() is also not 1 line...
          local _, fh = v:GetFont()
          y = t - fh
        else
          addon:Debug(8, "not changing % w % strW %", v:GetText(), curW, strWextra)
        end
        extraW = 0
      end
      if validChildren then
        maxX = math.max(maxX, x + extraW)
        minX = math.min(minX, l)
        maxY = math.max(maxY, t)
        minY = math.min(minY, y - extraH)
        numChildren = numChildren + 1
        if v.mirror then
          v.mirror:SetSize(x-l, y-t)
          v.mirror:SetPoint("BOTTOMLEFT", self, "TOPLEFT", l-fx, t-fy)
        end
      end
    end
    addon:Debug(6, "Found corners for % children to be topleft % , % to bottomright %, %", numChildren, maxX, minY,
                minX, maxY)
    return maxX, minY, minX, maxY
  end

  f.setSizeToChildren = function(self)
    local mx, my, l, t = self:calcCorners()
    local x = self:GetLeft()
    local y = self:GetTop()
    if not x or not y then
      addon:Warning("Frame has no left or top! % %", x, y)
      return
    end
    local w = mx - l
    local h = t - my
    local paddingX = 2 * (l - x)
    local paddingY = 2 * (y - t)
    addon:Debug(4, "Calculated bottom right x % y % -> w % h % padding % x %", x, y, w, h, paddingX, paddingY)
    self:SetWidth(w + paddingX)
    self:SetHeight(h + paddingY)
  end

  -- Scales a frame so the children objects fill up the frame in width or height
  -- (aspect ratio isn't changed)
  -- This is used for the dbox full screen splash for instance.
  -- TODO: combine scale change with pixel perfect to do change directly right
  f.setScale = function(self, overridePadding)
    local mx, my, l, t = self:calcCorners()
    local x = self:GetLeft()
    local y = self:GetTop()
    if not x or not y then
      addon:DebugStack("Frame has no left or top! % % in setScale", x, y)
    end
    local w = mx - l
    local h = t - my
    local paddingX = 2 * (l - x)
    local paddingY = 2 * (y - t)
    addon:Debug(6, "setScale bottom right x % y % -> w % h % padding % x %", x, y, w, h, paddingX, paddingY)
    local nw = w
    local nh = h
    if overridePadding ~= nil then
      --[[       local firstChild = self.children[1]
      local pt1, _, pt2, x, y = firstChild:GetPoint()
      if pt1:match("TOP") then
        addon:Debug("Adjusting first child top y anchor from % to %", y, overridePadding)
        y = -overridePadding
        firstChild:SetPoint(pt1, self, pt2, x, y)
      end
      if pt1:match("LEFT") then
        addon:Debug("Adjusting first child left x anchor from % to %", x, overridePadding)
        firstChild:SetPoint(pt1, self, pt2, overridePadding, y) -- use the adjusted y for TOPLEFT
      end
 ]]
      paddingX = 2 * overridePadding
      paddingY = 2 * overridePadding
    end
    nw = nw + paddingX
    nh = nh + paddingY
    local cw = self:GetWidth() -- current
    local ch = self:GetHeight()
    local sX = cw / nw
    local sY = ch / nh
    local scale = math.min(sX, sY)
    if addon.NO_SNAPSCALE then
      addon:DebugStack("NO_SNAPSCALE: not changing SCALE to % (sx % sy %)", scale, sX, sY)
      return
    end
    self:ChangeScale(self:GetScale() * scale)
    addon:Debug(5, "calculated scale x % scale y % for nw % nh % -> % -> %", sX, sY, nw, nh, scale, self:GetScale())
  end

  -- Used instead of SetPoint directly to move 2 linked object (eg textures for animation group) together
  local setPoint = function(sf, pt, ...)
    addon:Debug(8, "setting point %", pt)
    sf:SetPoint(pt, ...)
    if sf.linked then
      sf.linked:SetPoint(pt, ...)
    end
  end

  -- place inside the parent at offset x,y from corner of parent
  local placeInside = function(sf, x, y, point)
    point = point or "TOPLEFT"
    x = x or 16
    y = y or 16
    sf:setPoint(point, x, -y)
    return sf
  end
  -- place below (previously placed item typically)
  local placeBelow = function(sf, below, x, y, point1, point2)
    x = x or 0
    y = y or 8
    sf:setPoint(point1 or "TOPLEFT", below, point2 or "BOTTOMLEFT", x, -y)
    return sf
  end
  -- place to the right of last widget
  local placeRight = function(sf, nextTo, x, y, point1, point2)
    x = x or 16
    y = y or 0
    sf:setPoint(point1 or "TOPLEFT", nextTo, point2 or "TOPRIGHT", x, -y)
    return sf
  end
  -- place to the left of last widget
  local placeLeft = function(sf, nextTo, x, y, point1, point2)
    x = x or -16
    y = y or 0
    sf:setPoint(point1 or "TOPRIGHT", nextTo, point2 or "TOPLEFT", x, -y)
    return sf
  end

  -- Place (below) relative to previous one. optOffsetX is relative to the left margin
  -- established by first widget placed (placeInside)
  -- such as changing the order of widgets doesn't change the left/right offset
  -- in other words, offsetX is absolute to the left margin instead of relative to the previously placed object
  f.Place = function(self, object, optOffsetX, optOffsetY, point1, point2)
    self.numObjects = self.numObjects + 1
    addon:Debug(7, "called Place % n % o %", self.name, self.numObjects, self.leftMargin)
    if self.numObjects == 1 then
      -- first object: place inside
      object:placeInside(optOffsetX, optOffsetY, point1)
      self.leftMargin = 0
    else
      optOffsetX = optOffsetX or 0
      local y = (optOffsetY or 8) + (self.lastAdded.extraHeight or 0)
      -- subsequent, place after the previous one but relative to initial left margin
      object:placeBelow(self.lastAdded, optOffsetX - self.leftMargin, y, point1, point2)
      self.leftMargin = optOffsetX
    end
    self.lastAdded = object
    self.lastLeft = object
    return object
  end

  f.PlaceRight = function(self, object, optOffsetX, optOffsetY, point1, point2)
    self.numObjects = self.numObjects + 1
    if self.numObjects == 1 then
      addon:ErrorAndThrow("PlaceRight() should not be the first call, Place() should")
    end
    -- place to the right of previous one on the left
    -- if the previous widget has text, add the text length (eg for check buttons)
    local x = (optOffsetX or 16) + (self.lastLeft.extraWidth or 0)
    object:placeRight(self.lastLeft, x, optOffsetY, point1, point2)
    self.lastLeft = object
    return object
  end

  -- doesn't change lastLeft, meant to be called to put 1 thing to the left of a centered object atm
  f.PlaceLeft = function(self, object, optOffsetX, optOffsetY, point1, point2)
    self.numObjects = self.numObjects + 1
    if self.numObjects == 1 then
      addon:ErrorAndThrow("PlaceLeft() should not be the first call, Place() should")
    end
    -- place to the left of previous one
    -- if the previous widget has text, add the text length (eg for check buttons)
    local x = (optOffsetX or -16)
    object:placeLeft(self.lastLeft, x, optOffsetY, point1, point2)
    -- self.lastLeft = object
    return object
  end

  f.PlaceGrid = function(self, object, x, y, optOffsetX, optOffsetY)
    if not self.grid then
      self.grid = {}
    end
    if not self.grid[x] then
      self.grid[x] = {}
    end
    self.grid[x][y] = object
    object.inGrid = {x, y}
    if x == 1 then
      if y == 1 then
        object:Place(optOffsetX, optOffsetY)
      else
        self.numObjects = self.numObjects + 1
        local prev = self.grid[1][y - 1]
        local yO = (optOffsetY or 8) + (prev.extraHeight or 0)
        object:placeBelow(prev, optOffsetX, yO)
      end
    else
      self.numObjects = self.numObjects + 1
      if y == 1 then
        local prev = self.grid[x - 1][1]
        object:placeRight(prev, optOffsetX, optOffsetY)
      else
        local leftAnchor = self.grid[x][1]
        object:setPoint("LEFT", leftAnchor, "LEFT", optOffsetX, 0)
        local topAnchor = self.grid[1][y]
        local yAdjustment = addon:WidgetHeightAdjustment(object) - addon:WidgetHeightAdjustment(topAnchor)
        object:setPoint("BOTTOM", topAnchor, "BOTTOM", 0, (optOffsetY or 0) + yAdjustment)
      end
    end
  end

  -- To be used by the various factories/sub widget creation to add common methods to them
  -- (learned after coming up with this pattern on my own that that this seems to be
  -- called Mixins in blizzard code, though that doesn't cover forwarding or children tracking)
  function f:addMethods(widget)
    widget.setPoint = setPoint
    widget.placeInside = placeInside
    widget.placeBelow = placeBelow
    widget.placeRight = placeRight
    widget.placeLeft = placeLeft
    widget.parent = self
    widget.Place = function(...)
      -- add missing parent as first arg
      widget.parent:Place(...)
      return widget -- because :Place is typically last, so don't return parent/self but the widget
    end
    widget.PlaceRight = function(...)
      widget.parent:PlaceRight(...)
      return widget
    end
    widget.PlaceLeft = function(...)
      widget.parent:PlaceLeft(...)
      return widget
    end
    widget.PlaceGrid = function(...)
      widget.parent:PlaceGrid(...)
      return widget
    end
    if not widget.Init then
      widget.Init = function(w)
        addon:Debug(7, "Nothing special to init in %", w:GetObjectType())
      end
    end
    -- piggy back on 1 to decide both as it doesn't make sense to only define one of the two
    if not widget.DoDisable then
      widget.DoDisable = widget.Disable
      widget.DoEnable = widget.Enable
    end
    widget.Snap = function(w)
      w:setSizeToChildren()
      addon:SnapFrame(w)
    end
    table.insert(self.children, widget) -- keep track of children objects
  end

  f.addText = function(self, text, font)
    local fontObj = addon:NormalizeFont(font) or self.defaultFont or GameFontHighlightSmall -- different default?
    local t = self:CreateFontString(nil, "ARTWORK", nil)
    t:SetFontObject(fontObj)
    if self.defaultTextColor then
      t:SetTextColor(unpack(self.defaultTextColor))
    end
    t:SetText(text)
    t:SetJustifyH("LEFT")
    t:SetJustifyV("TOP")
    self:addMethods(t)
    if t.SetMaxLines == nil then
      t.SetMaxLines = function (...) end -- isLegacy case
    end
    return t
  end

  f.addTextFrame = function(self, text, font, tfTemplate)
    local t = self:addText(text, font)
    local cf = CreateFrame("Frame", nil, self, tfTemplate)
    cf.name = "textframe"
    cf:SetAllPoints(t)
    cf:Show()
    if addon.debug then
      addon:Debug("Debug level is on, putting debug background on text frame %", text)
      addon:SetDebugBackground(cf, 0.5, .2, .7, .7)
    end
    t.frame = cf
    return t
  end

  f.addTextButton = function(self, text, font, tooltipText, cb, bTemplate)
    local t = self:addText(text, font)
    local cf = CreateFrame("Button", nil, self, bTemplate)
    cf.name = "textbutton"
    if addon.debug then
      addon:Debug("Debug level is on, putting debug background on text frame %", text)
      addon:SetDebugBackground(cf, 0.5, .7, .2, .7)
    end
    self:addButtonBehavior(cf, text, tooltipText, cb)
    t.button = cf
    t.mirror = cf
    return t
  end

  --[[   f.drawRectangle = function(self, layer)
    local r = self:CreateTexture(nil, layer or "BACKGROUND")
    self:addMethods(r)
    return r
  end
 ]]

  -- adds a line of given thickness and color
  f.addLine = function(self, thickness, r, g, b, a, layer, dontaddtochildren)
    if addon.isLegacy then
      -- TODO support at least horizontal and vertical lines
      return {}
    end
    local l = self:CreateLine(nil, layer or "BACKGROUND")
    l.originalThickness = thickness or 1
    l:SetThickness(l.originalThickness)
    l:SetColorTexture(r or 1, g or 1, b or 1, a or 1)
    if not dontaddtochildren then
      self:addMethods(l)
    end
    return l
  end

  -- adds a border, thickness is in pixels (will be altered based on scale)
  -- the border isn't added to regular children
  f.addBorder = function(self, padX, padY, thickness, r, g, b, alpha, layer)
    if addon.isLegacy then
      -- TODO support at least horizontal and vertical lines
      return {}
    end
    padX = padX or 0.5
    padY = padY or 0.5
    layer = layer or "BACKGROUND"
    r = r or 1
    g = g or 1
    b = b or 1
    alpha = alpha or 1
    thickness = thickness or 1
    if not f.border then
      f.border = {}
    end
    -- true argument to addLine == only store the line in the border list, so it doesn't get wiped/handled like regular children
    local top = self:addLine(thickness, r, g, b, alpha, layer, true)
    top:SetStartPoint("TOPLEFT", padX, -padY)
    top:SetEndPoint("TOPRIGHT", -padX, -padY)
    top:SetIgnoreParentAlpha(true)
    table.insert(f.border, top)
    local left = self:addLine(thickness, r, g, b, alpha, layer, true)
    left:SetStartPoint("TOPLEFT", padX, -padY)
    left:SetEndPoint("BOTTOMLEFT", padX, padY)
    left:SetIgnoreParentAlpha(true)
    table.insert(f.border, left)
    local bottom = self:addLine(thickness, r, g, b, alpha, layer, true)
    bottom:SetStartPoint("BOTTOMLEFT", padX, padY)
    bottom:SetEndPoint("BOTTOMRIGHT", -padX, padY)
    bottom:SetIgnoreParentAlpha(true)
    table.insert(f.border, bottom)
    local right = self:addLine(thickness, r, g, b, alpha, layer, true)
    right:SetStartPoint("BOTTOMRIGHT", -padX, padY)
    right:SetEndPoint("TOPRIGHT", -padX, -padY)
    right:SetIgnoreParentAlpha(true)
    table.insert(f.border, right)
    self:updateBorder()
  end

  f.updateBorder = function(self)
    if not self.border or #self.border == 0 then
      return
    end
    local s = self:GetScale()
    for _, b in ipairs(self.border) do
      b:SetThickness(b.originalThickness / s)
    end
  end

  -- creates a texture so it can be placed
  -- (arguments are optional)
  f.addTexture = function(self, layer)
    local t = self:CreateTexture(nil, layer or "BACKGROUND")
    addon:Debug(8, "textures starts with % points", t:GetNumPoints())
    self:addMethods(t)
    return t
  end

  -- Add an animation of 2 textures (typically glow)
  f.addAnimatedTexture = function(self, baseId, glowId, duration, glowAlpha, looping, layer)
    local base = self:addTexture(layer)
    base:SetTexture(baseId)
    if not addon.isLegacy and not base:IsObjectLoaded() then
      addon:Warning("Texture % not loaded yet... use ML:PreloadTextures()...", baseId)
      base:SetSize(64, 64)
    end
    addon:Debug(1, "Setting base texture % - height = %", baseId, base:GetHeight())
    local glow = self:CreateTexture(nil, layer or "BACKGROUND")
    glow:SetTexture(glowId)
    glow:SetBlendMode("ADD")
    glow:SetAlpha(0) -- start with no change
    if not addon.isLegacy then
      glow:SetIgnoreParentAlpha(true)
    end
    local ag = glow:CreateAnimationGroup()
    base.animationGroup = ag
    local anim = ag:CreateAnimation("Alpha")
    if not addon.isLegacy then
      anim:SetFromAlpha(0)
      anim:SetToAlpha(glowAlpha or 0.2)
    end
    ag:SetLooping(looping or "BOUNCE")
    anim:SetDuration(duration or 2)
    base.linked = glow
    ag:Play()
    return base
  end

  f.addCheckBox = function(self, text, tooltip, optCallback)
    local name= nil
    if addon.isLegacy then
      name = "MoLib" .. self.name .. "ChkBox".. tostring(addon:NextId())
    end
    local c = CreateFrame("CheckButton", name, self, "InterfaceOptionsCheckButtonTemplate")
    addon:Debug(8, "check box starts with % points", c:GetNumPoints())
    if c.Text == nil then
      c.Text = _G[c:GetName().."Text"]
    end
    c.Text:SetText(text)
    if tooltip then
      c.tooltipText = tooltip
    end
    self:addMethods(c)
    c.extraWidth = c.Text:GetWidth()
    if optCallback then
      c:SetScript("OnClick", optCallback)
    else
      -- Work around bug in 9.0.2 where non existent SetValue is called through OnClick
      c:SetScript("OnClick", nil)
    end
--    if not c.SetValue then
--      c.SetValue = function()
--      end
--    end
    return c
  end

  -- create a slider with the range [minV...maxV] and optional step, low/high labels and optional
  -- strings to print in parenthesis after the text title
  f.addSlider = function(self, text, tooltip, minV, maxV, step, lowL, highL, valueLabels)
    minV = minV or 0
    maxV = maxV or 10
    step = step or 1
    lowL = lowL or tostring(minV)
    highL = highL or tostring(maxV)
    local name= nil
    if addon.isLegacy then
      name = "MoLib" .. self.name .. "Slider".. tostring(addon:NextId())
    end
    local s = CreateFrame("Slider", name, self, "OptionsSliderTemplate")
    if s.Text == nil then
      s.Text = _G[name.."Text"]
      s.Low = _G[name.."Low"]
      s.High = _G[name.."High"]
    end
    s.DoDisable = BlizzardOptionsPanel_Slider_Disable -- what does enable/disable do ? seems we need to call these
    s.DoEnable = BlizzardOptionsPanel_Slider_Enable
    s:SetValueStep(step)
    if s.SetStepsPerPage ~= nil then -- doesn't exist in isLegacy
      s:SetStepsPerPage(step)
      s:SetObeyStepOnDrag(true)
    end
    s:SetMinMaxValues(minV, maxV)
    s.Text:SetFontObject(GameFontNormal)
    -- not centered, so changing (value) doesn't wobble the whole thing
    -- (justifyH left alone didn't work because the point is also centered)
    s.Text:SetPoint("LEFT", s, "TOPLEFT", 6, 0)
    s.Text:SetJustifyH("LEFT")
    s.Text:SetText(text)
    if tooltip then
      s.tooltipText = tooltip
    end
    s.Low:SetText(lowL)
    s.High:SetText(highL)
    s:SetScript("OnValueChanged", function(w, value)
      local sVal = tostring(ML:round(value, 0.001))
      if valueLabels and valueLabels[value] then
        sVal = valueLabels[value]
      elseif valueLabels and valueLabels[sVal] then
        sVal = valueLabels[sVal]
      else
        if value == minV then
          sVal = lowL
        elseif value == maxV then
          sVal = highL
        end
      end
      w.Text:SetText(text .. ": " .. sVal)
      if w.callBack then
        w:callBack(value)
      end
    end)
    self:addMethods(s)
    return s
  end

  f.addButtonBehavior = function(_self, c, text, tooltip, cb)
    if tooltip then
      c.tooltipText = tooltip -- TODO: style/font of tooltip for button is wrong
    end
    local callback = cb
    if type(cb) == "string" then
      addon:Debug(4, "Setting callback for % to call Slash(%)", text, cb)
      callback = function()
        addon.Slash(cb)
      end
      addon:Debug(4, "Keeping original function for %", text)
    end
    if callback then
      c:SetScript("OnClick", callback)
    end
    c:SetScript("OnEnter", function()
      addon:Debug(7, "Show button tool tip...")
      addon:ShowToolTip(c)
    end)
    c:SetScript("OnLeave", function()
      addon:Debug(7, "Hide button tool tip...")
      GameTooltip:Hide()
    end)
  end

  -- the call back is either a function or a command to send to addon.Slash
  f.addButton = function(self, text, tooltip, cb)
    local name= nil
    if addon.isLegacy then
      name = "MoLib" .. self.name .. "Button".. tostring(addon:NextId())
    end
    local c = CreateFrame("Button", name, self, "UIPanelButtonTemplate")
    if c.Text == nil then
      c.Text = _G[c:GetName().."Text"]
    end
    c.Text:SetText(text)
    c:SetWidth(c.Text:GetStringWidth() + 20) -- need some extra spaces for corners
    self:addButtonBehavior(c, text, tooltip, cb)
    self:addMethods(c)
    return c
  end

  f.addEditBox = function(self)
    local e = CreateFrame("EditBox", nil, self)
    e:SetFontObject(GameFontNormal)
    if self.defaultTextColor then
      e:SetTextColor(unpack(self.defaultTextColor))
    end
    self:addMethods(e)
    return e
  end

  f.addScrollingFrame = function(self, width, height, noInset)
    width = width or 400
    height = height or 300
    local s = CreateFrame("ScrollFrame", nil, self, "UIPanelScrollFrameTemplate")
    s:SetSize(width, height)
    if not noInset then
      local inset = CreateFrame("Frame", nil, s, "InsetFrameTemplate")
      inset:SetPoint("BOTTOMLEFT", -4, -4)
      inset:SetPoint("TOPRIGHT", 4, 4)
      s.extraHeight = 8 -- inset is 4+4 outside
      s.inset = inset
    end
    s.extraWidth = 24 -- scrollbar is outside
    s.setScrollChild = function(p, c) -- set scroll child relationship and fix the frame level (classic)
      if p.inset then
        c:SetFrameLevel(p.inset:GetFrameLevel() + 1)
      end
      p:SetScrollChild(c)
    end
    s.addScrollChild = function(p, frameType) -- nil frameType for our container frame
      local c
      if frameType then
        c = CreateFrame(frameType, nil, s)
      else
        c = addon:Frame(nil, nil, nil, p)
      end
      p:setScrollChild(c)
      return c
    end
    self:addMethods(s)
    return s
  end

  f.addScrollEditFrame = function(self, width, height, font, noInset)
    local s = self:addScrollingFrame(width, height, noInset)
    local e = s:addScrollChild("EditBox")
    e:SetWidth(width)
    e:SetFontObject(font or f.defaultFont or ChatFontNormal)
    if self.defaultTextColor then
      e:SetTextColor(unpack(self.defaultTextColor))
    end
    e:SetMultiLine(true)
    --    e:GetRegions():SetNonSpaceWrap(false)
    --    e:GetRegions():SetWordWrap(false)
    s.editBox = e
    return s
  end

  local function dropdownInit(d)
    addon:Debug(5, "drop down init called initDone=%", d.initDone)
    if d.initDone then
      return
    end
    addon:Debug(5, "drop down first time init called")
    d.initDone = true
    UIDropDownMenu_JustifyText(d, "CENTER")
    UIDropDownMenu_Initialize(d, function(_w, _level, _menuList)
      for _, v in ipairs(d.options) do
        addon:Debug(5, "Creating dropdown entry %", v)
        local info = UIDropDownMenu_CreateInfo() -- don't put it outside the loop!
        info.tooltipOnButton = true
        info.text = v.text
        info.tooltipTitle = v.text
        info.tooltipText = v.tooltip
        info.value = v.value
        info.func = function(entry)
          if d.cb then
            d.cb(entry.value)
          end
          UIDropDownMenu_SetSelectedID(d, entry:GetID())
        end
        UIDropDownMenu_AddButton(info)
      end
    end)
    UIDropDownMenu_SetText(d, d.text)
    -- Uh? one global for all dropdowns?? also possible taint issues
    local width = _G["DropDownList1"] and _G["DropDownList1"].maxWidth or 0
    addon:Debug(4, "Found dropdown width to be %", width)
    if width > 0 then
      UIDropDownMenu_SetWidth(d, width)
    end
  end

  -- Note that trying to reuse the blizzard dropdown code instead of duplicating it cause some tainting
  -- because said code uses a bunch of globals notably UIDROPDOWNMENU_MENU_LEVEL
  -- create/show those widgets as late as possible
  f.addDrop = function(self, text, tooltip, cb, options)
    -- local name = self.name .. "drop" .. self.numObjects
    local d = CreateFrame("Frame", nil, self, "UIDropDownMenuTemplate")
    d.tooltipTitle = "Testing dropdown tooltip 1" -- not working/showing (so far)
    d.tooltipText = tooltip
    d.options = options
    d.cb = cb
    d.text = text
    d.tooltipOnButton = true
    d.Init = dropdownInit
    self:addMethods(d)
    self.lastDropDown = d
    return d
  end

  if ML.widgetDemo then
    f:addText("Testing 1 2 3... demo widgets:"):Place(50, 20)
    local _cb1 = f:addCheckBox("A test checkbox", "A sample tooltip"):Place(0, 20) -- A: not here
    local cb2 = f:addCheckBox("Another checkbox", "Another tooltip"):Place()
    cb2:SetChecked(true)
    local s2 = f:addSlider("Test slider", "Test slide tooltip", 1, 4, 1, "Test low", "Test high",
                           {"Value 1", "Value 2", "Third one", "4th value"}):Place(16, 30)
    s2:SetValue(4)
    f:addText("Real UI:"):Place(50, 40)
  end

  return f
end

function ML:Table(f, data)
  for y, l in ipairs(data) do
    for x, c in ipairs(l) do
      self:Debug("adding at % %: %", x, y, c)
      if type(c) == "string" then
        c = f:addText(c)
      end
      c:PlaceGrid(x, y)
    end
  end
end

function ML:GetFullWidth(w)
  return (w.GetStringWidth and w:GetStringWidth() or w:GetWidth()) + (w.extraWidth or 0)
end

-- todo: make up my mind about widget/frame/toplevel(addon) functions...

function ML:GridUpdateHeader(f)
  if not f.grid then
    return
  end
  for x, c in ipairs(f.grid) do
    local header, headerWidth
    for y, l in ipairs(c) do
      if y == 1 then
        header = l
        headerWidth = self:GetFullWidth(l)
      else
        local thisWidth = self:GetFullWidth(l)
        if thisWidth > headerWidth then
          self:Debug("Found wider at % % : %", x, y, thisWidth)
          header.extraWidth = (header.extraWidth or 0) + (thisWidth - headerWidth)
          headerWidth = thisWidth
          header:SetWidth(thisWidth)
        end
      end
    end
  end
end

function ML:WidgetHeightAdjustment(object)
  local yAdjustment = 0
  local oType = object:GetObjectType()
  if oType == "CheckButton" then
    yAdjustment = -7
  elseif oType == "Button" then
    yAdjustment = -4
  end
  return yAdjustment
end

function ML:TableDemo(n, onlyText)
  local f = self:StandardFrame("TableDemo", "Table Demo")
  local s = f:addScrollingFrame()
  s:Place(5, 14) -- because of inset
  local g = s:addScrollChild()
  local t = {{"Hdr1", "H2", "Header 3"}}
  n = n or 20
  for i = 1, n do
    local t1 = tostring(i)
    local t2 = self:RandomId(1, 6)
    local t3 = self:RandomId(3, 15)
    if not onlyText then
      t1 = g:addButton(t1)
      t2 = g:addCheckBox(t2)
    end
    table.insert(t, {t1, t2, t3})
  end
  self:Table(g, t)
  f.grid = g.grid
  f:Snap()
  local cell = f.grid[2][3]
  C_Timer.After(2, function()
    local tt = cell
    if cell.Text then
      tt = cell.Text
    end
    tt:SetText("updated now...")
    if cell.Text then
      cell.extraWidth = tt:GetStringWidth()
    end
    f:Snap()
  end)
  return f
end

---
function ML:ScaleAdjustment()
  if not self.useUIScale then
    return 1
  end
  local sw, _= GetPhysicalScreenSize()
  local ui = UIParent:GetWidth()
  return sw/ui
end

function ML:AdjustScale(newScale)
  if not newScale then
    newScale = 1
  end
  if not self.useUIScale then
    return newScale
  end
  local adj = self:ScaleAdjustment()
  local ns = newScale * adj
  self:Debug(2, "Using UI scale for Scale % x % -> ", newScale, adj, ns)
  return ns
end


-- Changes the scale without changing the anchor
function ML:ChangeScale(f, newScale)
  local pt1, parent, pt2, x, y = f:GetPoint()
  local oldScale = f:GetScale()
  newScale = self:AdjustScale(newScale)
  local ptMult = oldScale / newScale -- correction for point
  self:Debug(7, "Changing scale from % to % for pt % / % x % y % - point multiplier %", oldScale, newScale, pt1, pt2, x,
             y, ptMult)
  f:SetScale(newScale)
  f:SetPoint(pt1, parent, pt2, x * ptMult, y * ptMult)
  f:updateBorder()
  f:Snap()
  return oldScale
end

-- Frame to attach all textures for (async) preloading: TODO actually wait for them to be loaded
ML.MoLibTexturesPreLoadFrame = CreateFrame("Frame")

-- ML.debug = 1
function ML:PreloadTextures(texture, ...)
  local t = ML.MoLibTexturesPreLoadFrame:CreateTexture(texture)
  local ret = t:SetTexture(texture)
  ML:Debug(1, "Preloading % : %", texture, ret)
  if not ret then
    error("Can't create texture %", texture)
  end
  if select("#", ...) == 0 then
    return
  end
  ML:PreloadTextures(...)
end

-- Wipes a frame and it's children to reduce memory usage to a minimum
-- (note this is not a pool but could be modified to do resetting of object in pool)
function ML:WipeFrame(f, ...)
  if not f then
    return nil -- nothing to wipe
  end
  if f.isMinimapButton then
    -- Do nothing so older addon code used to wipe and recreate on resize work without creating
    -- errors for other minimap handling addons
    f:Hide()
    return f
  end
  if f.isldbi then
    f.isldbi:Hide()
    return f
  end
  if f.Hide then
    f:Hide() -- first hide before we change children etc
  else
    return nil -- not a frame?
  end
  if f.UnregisterAllEvents then
    f:UnregisterAllEvents()
  end
  local oType = f:GetObjectType()
  local name = f:GetName() -- likely nil for our stuff
  self:Debug(6, "Wiping % name %", oType, name)
  -- depth first: children then us then siblings
  if f.GetChildren then
    self:WipeFrame(f:GetChildren())
  else
    assert(not f.children)
  end
  if f.mirror then
    f.mirror = self:WipeFrame(f.mirror)
  end
  if f.linked then
    f.linked = self:WipeFrame(f.linked)
  end
  if name then
    _G[name] = nil
  end
  if f.SetScale then
    f:SetScale(1)
  end
  f:ClearAllPoints()
  local status, err = pcall(function()
    f:SetParent(nil)
  end)
  if not status then
    self:Debug(7, "(Expected) Error clearing Parent on % %: %", oType, name, err)
  end
  wipe(f)
  self:WipeFrame(...)
  return nil
end

--- Test / debug functions

-- classic compatible
function ML:GetCVar(...)
  local f
  if C_CVar then
    f = C_CVar.GetCVar
  else
    f = GetCVar
  end
  return f(...)
end

function ML:DisplayInfo(x, y, scale)
  local f = ML:Frame()
  f.defaultTextColor = {.5, .6, 1, 1}
  f:SetDefaultFont("Game13FontShadow")
  f:SetFrameStrata("FULLSCREEN")
  f:SetPoint("CENTER", x, -y)
  local p = f:GetParent()
  local ps = 1
  if p then
    ps = p:GetScale()
  end
  f:SetScale((scale or 1) / ps)
  f:SetAlpha(0.95)
  f:addText("Dimensions snapshot by MoLib:"):Place()
  f:addText(string.format("UI parent: %.3f x %.3f (scale %.5f eff.scale %.5f)", UIParent:GetWidth(),
                          UIParent:GetHeight(), UIParent:GetScale(), UIParent:GetEffectiveScale())):Place()
  f:addText(string.format("WorldFrame: %.3f x %.3f (scale %.5f eff.scale %.5f)", WorldFrame:GetWidth(),
                          WorldFrame:GetHeight(), WorldFrame:GetScale(), WorldFrame:GetEffectiveScale())):Place()
  local w, h = GetPhysicalScreenSize()
  f:addText(ML:format("Actual pixels % x %", w, h)):Place()
  f:addText(ML:format("Renderscale % uiScale %", self:GetCVar("RenderScale"), self:GetCVar("uiScale"))):Place()
  local aX = 16
  local aY, aYi = self:AspectRatio(aX)
  f:addText(ML:format("Aspect ratio is ~ %:% (%:%)", aX, aY, aX, aYi)):Place()
  --[[   f:addText(
    string.format("This pos: %.3f x %.3f (scale %.5f eff.scale %.5f)", x, y, f:GetScale(), f:GetEffectiveScale()))
    :Place()
 ]]
  f:Show()
  self:Debug(1, "Info display done with % % %", x, y, scale)
  return f
end

--- Grid demo for pixel perfect (used by PixelPerfectAlign)

-- Todo: Check effects of
-- Texture:SetSnapToPixelGrid()
-- Texture:SetTexelSnappingBias()
-- IsSnappingToPixelGrid, GetTexelSnappingBias

ML.drawn = 0

function ML:DrawPixel(f, x, y, color, layer)
  local t = f:CreateTexture(nil, layer or "BACKGROUND")
  x = math.floor(x)
  y = math.floor(y)
  t:SetSize(1, 1)
  t:SetColorTexture(unpack(color))
  t:SetPoint("BOTTOMLEFT", x, y)
  self.drawn = self.drawn + 1
  return t
end

-- Draws 2 line crossing in center x,y either vertical/horizontal if off2 is 0
-- or diagonally if off2 is == off1
function ML:DrawCross(f, x, y, off1, off2, thickness, color)
  if off1 < 1 and thickness <= 1 then
    ML:DrawPixel(f, x, y, color)
    return
  end
  local l = f:CreateLine(nil, "BACKGROUND")
  l:SetThickness(thickness)
  l:SetColorTexture(unpack(color))
  l:SetStartPoint("BOTTOMLEFT", x - off1, y - off2)
  l:SetEndPoint("BOTTOMLEFT", x + off1, y + off2)
  l = f:CreateLine(nil, "BACKGROUND")
  l:SetThickness(thickness)
  l:SetColorTexture(unpack(color))
  l:SetStartPoint("BOTTOMLEFT", x + off2, y - off1)
  l:SetEndPoint("BOTTOMLEFT", x - off2, y + off1)
  self.drawn = self.drawn + 2
end

ML.gold = {1, 0.8, 0.05, 0.5}
ML.red = {1, .1, .1, .8}

function ML:FineGrid(numX, numY, length, name, parent)
  local pp = self:pixelPerfectFrame(name, parent) -- potentially a shiny new frame
  local f = pp
  if name then
    -- if parent is one of the named one then make a new child, otherwise use the one we just made
    f = CreateFrame("Frame", nil, pp)
  end
  f:SetFlattensRenderLayers(true)
  f:SetPoint("BOTTOMLEFT", 0, 0) -- BOTTOMLEFT is where 0,0 is
  -- consider change offset for odd vs even for the center cross
  local w, h = GetPhysicalScreenSize()
  f:SetSize(w, h)
  local th = 1 -- thickness
  length = length or 16
  -- we round up most cases except for special 1 pixel request
  local off1 = math.ceil(length / 2) + 0.5
  if length == 1 then
    off1 = 0.5
  end
  local color
  local seenCenter = false
  self:Debug(1, "Making % x % (+1) crosses of length %", numX, numY, off1)
  for i = 0, numX do
    for j = 0, numY do
      local x = math.floor(i * (w - 1) / numX) + 0.5
      local y = math.floor(j * (h - 1) / numY) + 0.5
      color = self.gold
      local off2 = 0
      if i == numX / 2 and j == numY / 2 then
        -- center, make a red side cross instead
        seenCenter = true
        color = self.red
        if length ~= 1 then -- special case for 1 pixel in center
          off2 = off1 + 0.5
          x = x - 0.5
          y = y - 0.5
        end
      end
      self:DrawCross(f, x, y, off1, off2, th, color)
    end
  end
  if not seenCenter then
    local x = math.floor(w / 2)
    local y = math.floor(h / 2)
    local off2 = off1 + 0.5
    if length == 1 then -- another special case for 1 pixel long center
      x = x - 0.5
      y = y - 0.5
      off2 = 0
    end
    self:DrawCross(f, x, y, off1, off2, th, self.red)
  end
  return f
end

function ML:Demo()
  local sum = 0
  local num = 0
  local before = self.drawn
  for i = 96, 126 do
    ML:FineGrid(i, i, 1, "MoLib_PP_Demo", nil)
    sum = sum + ((i + 1) * (i + 1) + math.fmod(i, 2))
    num = num + 1
  end
  local msg = self:format("created % (%, % total) textures across % frames", sum, self.drawn - before, self.drawn, num)
  self:PrintDefault(msg)
  return msg
end

-- Returns nY closest int in proportion to aspect ratio
-- eg on a 16:9 screen passing in 16 will return 9
-- also returns the not rounded one
function ML:AspectRatio(nX)
  local w, h = GetPhysicalScreenSize()
  local nY = self:round(h / w * nX, 0.01)
  local nYi = self:round(nY, 1)
  self:Debug(2, "Aspect ratio %:% - rounded to %:%", nX, nY, nX, nYi)
  return nYi, nY
end

-- Sets the scale to match physical pixels
function ML:PixelPerfectScale(f)
  local w, h = GetPhysicalScreenSize()
  local p = f:GetParent()
  if not p then -- special case for the Screen base frame
    f:SetScale(1) -- important
    f:SetAllPoints()
    p = f
  else
    f:SetSize(w, h)
  end
  -- use width as divisor as that's (typically) the largest numbers so better precision
  local sx = p:GetWidth() / w
  local sy = p:GetHeight() / h
  f:SetScale(sx)
  self:Debug(1, "Set Pixel Perfect w % h % scale sx % (sy %) rect %", w, h, sx, sy, {f:GetRect()})
end

function ML.OnPPEvent(frame, event, ...)
  ML:Debug(1, "frame % got %: %", frame:GetName(), event, {...})
  ML:PixelPerfectScale(frame)
end

-- Creates/Returns a frame taking the whole screen and for which every whole coordinate is a physical pixel
-- Thus any children frame of this one is always pixel perfect/aligned when using whole numbers + 0.5
-- Makes 2 frames, on child of UIParent for most UI and one, if passed true, of a ScreenFrame (which
-- is like WorldFrame except some viewport addons can change WorldFrame) so it can be shown always.
function ML:PixelPerfectFrame(screenFrame)
  local name = "MoLibPixelPerfect"
  local parent = UIParent
  if screenFrame then
    name = name .. "Screen"
    parent = nil
  end
  name = name .. "Frame"
  return self:pixelPerfectFrame(name, parent)
end

function ML:pixelPerfectFrame(name, parent)
  if name and _G[name] then
    self:Debug(8, "ppf returning existing % whose parent is %", name, _G[name]:GetParent())
    return _G[name]
  end
  local f = CreateFrame("Frame", name, parent)
  f:SetPoint("BOTTOMLEFT", 0, 0) -- BOTTOMLEFT is where 0,0 is/starts
  self:PixelPerfectScale(f)
  f:Show()
  f:SetScript("OnEvent", self.OnPPEvent)
  f:RegisterEvent("DISPLAY_SIZE_CHANGED")
  if parent ~= nil and parent ~= WorldFrame then
    -- nil and world ppf are based of fixed x768 parent so they don't need UI scale changed events
    f:RegisterEvent("UI_SCALE_CHANGED")
  end
  return f -- same as _G[name]
end

-- Moves a frame to have pixel perfect alignment. Doesn't fix the scale, only the boundaries
-- if dontChangeSize is true it will return instead of setting the size
-- returns the size with UI scale, the scale and the pixel size
function ML:PixelPerfectSnap(f, resolution, top, dontChangeSize)
  resolution = resolution or 1 -- should be 2, 1 or 0.5
  local fs = f:GetEffectiveScale()
  local ps = self:PixelPerfectFrame():GetEffectiveScale()
  -- get the rect in pixel perfect coordinates
  local ppx, ppy, ppw, pph = self:Map(function(v)
    return v * fs / ps
  end, f:GetRect())
  local point1 = "BOTTOMLEFT" -- natural point with 0,0 bottom left
  if top then
    -- switch which point is calculated/rounded
    ppy = ppy + pph
    point1 = "TOPLEFT"
  end
  -- round the bottom corner to nearest 1/2 pixel
  ppx = self:round(ppx, resolution)
  ppy = self:round(ppy, resolution)
  -- round the width/heigh up to 1/2 pixel dimension
  -- (not that 0.55 still rounds "up" to 0.5 and 0.56 is the first to round to 1.0)
  ppw = self:roundUp(ppw, resolution)
  pph = self:roundUp(pph, resolution)
  -- change the frame
  self:Debug(6, "About to change from x % y % w % h %", f:GetRect())
  self:Debug(6, "ps % fs % to x % y % w % h % -> scaled back to wf x % y % - new w % h %", ps, fs, ppx, ppy, ppw, pph,
             ppx * ps, ppy * ps, ppw * ps, pph * ps)
  self:Debug(6, "size before % %", f:GetSize())
  f:ClearAllPoints()
  local mult = ps / fs -- put back in screen+frame's scale/coordinate
  f:SetPoint(point1, nil, "BOTTOMLEFT", ppx * mult, ppy * mult)
  local newWidth, newHeight = ppw * mult, pph * mult
  if not dontChangeSize then
    f:SetSize(newWidth, newHeight)
    self:Debug(6, "scale after %, size after % %", f:GetScale(), f:GetSize())
  end
  -- f:SetPoint(point2, nil, "BOTTOMLEFT", (ppx + ppw) * mult, (ppy + pph) * mult)
  return newWidth, newHeight, ps, ppw, pph
end
---
-- C_Timer.After(1, function()
--  ML:FineGrid(16, 8)
-- end)
---

function ML:onCircle(angle, distance)
  local x = distance * cos(angle)
  local y = distance * sin(angle)
  return x, y
end

ML.allowLDBI = true -- set to false to use our own code even if LDBI is detected (better rendering)
ML.minimapButtonAngle = 154 -- Make sure this is unique to your addon

-- made it noop to call again
function ML:minimapButton(pos, name, icon)
  name = name or (self.name .. "minimapButton")
  local ldbi = _G.LibStub and _G.LibStub:GetLibrary("LibDBIcon-1.0", true)
  if ldbi and icon and self.allowLDBI and ldbi.GetMinimapButton ~= nil then
    if _G[name] and _G[name].isldbi then
      _G[name].isldbi:Show()
      return _G[name]
    end
    local b = {}
    b.isldbi = true
    b.SetScript = function(w, sname, fn)
      w[sname] = fn
    end
    b.icon = icon
    self:Debug("Handle SexyMap/other map using LDBI instead of our code")
    if not self.savedVar.ldbi then
      self.savedVar.ldbi = {}
    end
    -- kinda stupid you can't "replace" or remove
    if ldbi:GetMinimapButton(name) then
      ldbi.objects[name] = nil
    end
    ldbi:Register(name, b, self.savedVar.ldbi)
    b.isldbi = ldbi:GetMinimapButton(name)
    b.isldbi.icon:SetSize(18, 18) -- fix up the 17,17 default in LDBI to more closely match ours
    return b
  end
  local b = _G[name] or CreateFrame("Button", name, Minimap)
  b.name = name
  b.isMinimapButton = true
  b:ClearAllPoints()
  b:SetFrameStrata("HIGH")
  if pos then
    local pt, xOff, yOff = unpack(pos)
    b:SetPoint("TOPLEFT", nil, pt, xOff, yOff) -- dragging gives position from nil (screen)
  else
    local distance = 80
    local x, y = self:onCircle(self.minimapButtonAngle, distance)
    self:Debug("x = %, y = %", x, y)
    -- b:SetPoint("CENTER", -71, 37)
    b:SetPoint("CENTER", x, y)
    --[[     C_Timer.NewTicker(.05, function()
      angle = (angle + 5) % 360
      b:ClearAllPoints()
      b:SetPoint("CENTER", self:onCircle(angle, distance))
    end)
 ]]
  end
  b:SetSize(32, 32)
  -- b:SetFrameLevel(8)
  b:RegisterForClicks("AnyUp")
  b:RegisterForDrag("LeftButton")
  if self.isLegacy then
    b:SetHighlightTexture("Interface\\Minimap\\UI-MiniMap-ZoomButton-Highlight")
  else
    b:SetHighlightTexture(136477) -- interface/minimap/ui-minimap-zoombutton-highlight
  end
  if not b.bgTextures then
    local bg = b:CreateTexture(nil, "BACKGROUND")
    b.bgTextures= bg
    bg:SetSize(24, 24)
    local o = b:CreateTexture(nil, "OVERLAY")
    if self.isLegacy then
      bg:SetTexture("Interface\\Minimap\\UI-MiniMap-Background")
      o:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    else
      bg:SetTexture(136467) -- interface/minimap/ui-minimap-background
      o:SetTexture(136430) -- interface/minimap/minimap-trackingborder
    end
    bg:SetPoint("CENTER", 1, 1)
    o:SetSize(54, 54)
    o:SetPoint("TOPLEFT")
    if icon then
      local t = b:CreateTexture(nil, "ARTWORK")
      t:SetSize(19, 19)
      t:SetTexture(icon)
      t:SetPoint("TOPLEFT", 7, -6)
      b.icon = t
    end
  end
  self:Debug("[Re]Created minimap button % %", name, b)
  b:Show()
  return b
end

-- initially from DynamicBoxer DBoxUI.lua

function ML:ShowToolTip(f, anchor)
  self:Debug(3, "Show tool tip...")
  if f.tooltipText then
    GameTooltip:SetOwner(f.isldbi or f, anchor or "ANCHOR_RIGHT")
    GameTooltip:SetText(f.tooltipText, 0.9, 0.9, 0.9, 1, false)
  else
    self:Debug(2, "No .tooltipText set on %", f:GetName())
  end
end

-- callback will be called with (f, pos, scale)
function ML:MakeMoveable(f, callback, dragButton)
  if f.isldbi then
    return
  end
  f.afterMoveCallBack = callback
  f:EnableMouse(true) -- hard to drag without clicking
  f:SetClampedToScreen(true)
  f:SetMovable(true)
  f:RegisterForDrag(dragButton or "LeftButton")
  f:SetScript("OnDragStart", function(w)
    w:StartMoving()
    w:SetUserPlaced(false) -- TODO consider using that mechanism to save our pos?
  end)
  f:SetScript("OnDragStop", function(w, ...)
    w:StopMovingOrSizing(...)
    if w.isCombatFrame and InCombatLockdown() then
      self:Debug(2,"Not snaping in combat frame")
      return
    end
    if w.Snap then
      w:Snap()
    else
      self:PixelPerfectSnap(w) -- snap for perfect pixels though doesn't seem really needed?
    end
    self:SavePosition(w) -- save
  end)
end

-- doesn't move a frame, just changes it's anchor to top left (from bottom left coord or whichever the anchor was)
function ML:SetTopLeft(f)
  local x, y, w, h = f:GetRect()
  f:ClearAllPoints()
  f:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", x, y + h)
  f:SetSize(w, h)
end

function ML:SavePosition(f)
  --[[
  -- we used to extract the position before snap changes the anchor point,
  -- to get pos "closest to correct part of the screen" but that doesn't work with
  -- restore of widgets that don't yet have their full height like the dbox status
  -- so we just use screen coordinates and rely on SetClampedToScreen to not loose
  -- the window (doesn't work as well when resizing though)
  f:StartMoving()
  f:SetUserPlaced(false)
  f:StopMovingOrSizing()
]]
  -- change point to TOPLEFT
  self:SetTopLeft(f)
  local point, relTo, relativePoint, xOfs, yOfs = f:GetPoint()
  local scale = f:GetScale() / self:ScaleAdjustment()
  self:Debug(2, "SavePosition: Stopped moving/scaling widget % % % % relative to % % - scale %", point, relativePoint,
             xOfs, yOfs, relTo, relTo and relTo:GetName(), scale)
  local pos = {relativePoint, xOfs, yOfs} -- relativePoint seems to always be same as point, when called at the right time
  if f.afterMoveCallBack then
    f:afterMoveCallBack(pos, scale)
  else
    self:Debug(3, "No after move callback for %", f:GetName())
  end
end

function ML:RestorePosition(f, pos, scale)
  self:Debug("# Restoring % %", pos, scale)
  if f.isCombatFrame and InCombatLockdown() then
    self:Debug(2, "Not restoring combat sensitive frame")
    return
  end
  f:SetScale(self:AdjustScale(scale))
  f:ClearAllPoints()
  f:SetPoint("TOPLEFT", nil, unpack(pos))
  -- if our widget we use the widget function, otherwise the generic snap
  -- todo: why is the outcome different for dbox ?
  if f.Snap then
    f:Snap()
  else
    self:SnapFrame(f)
  end
end

-- Returns coordinates (pixelX, pixelY, uicoordX, uicoordY)
-- in actual pixels and in UIParent's coordinates
function ML:GetCursorCoordinates()
  local pw = GetPhysicalScreenSize()
  local sw = WorldFrame:GetWidth() / pw
  local uis = UIParent:GetScale()
  local x, y = GetCursorPosition()
  return ML:round(x / sw), ML:round(y / sw), x / uis, y / uis, x, y
end

-- sets an editbox such as the text can't be changed, only copied
function ML:SetReadOnly(e, text)
  local f = function(w)
    w:SetText(text)
    w:SetCursorPosition(0)
    w:HighlightText()
    w:SetCursorPosition(0)
  end
  f(e)
  e:SetFocus()
  e:SetScript("OnTextChanged", f)
  e:SetScript("OnMouseUp", f)
end

function ML:StandardFrame(frameName, title, parent)
  local f = self:Frame(frameName, frameName, "BasicFrameTemplate", parent)
  self:MakeMoveable(f)
  f:SetAlpha(0.9)
  f.TitleText:SetText(title)
  f.defaultFont = ChatFontNormal
  f.defaultTextColor = {.9, .9, .9, 1}
  f:addText(" "):Place(10, 10) -- title placeholder and defines default padding
  f:SetFrameStrata("DIALOG")
  f:SetPoint("TOP", 0, -120)
  return f
end

ML.bugReportMaxLines = 225
ML.bugReportKeepFirst = 25
ML.bugReportMaxEntryLen = 600

--- (De)Bug report frame
function ML:BugReport(subtitle, text)
  local f = self.bugReportFrame
  local title = "|cFFFF1010Bug|r Report for " .. addonName
  if not f then
    local frameName = "MoLib" .. self.name .. "BugReport"
    f = self:StandardFrame(frameName, title)
    self.bugReportFrame = f
    f.subTitle = f:addText(subtitle):Place()
    f:addText("Copy (Ctrl-C) and Paste in the report, adding any additional context\n" ..
                "and a screenshot if possible and then close this."):Place()
    local font = self:NormalizeFont("Tooltip_Small")
    local _, h = font:GetFont()
    f.seb = f:addScrollEditFrame(400, h * 8, font) -- 8 lines
    f.seb:Place(5, 14) -- 4 is inset
    local eb = f.seb.editBox
    eb:SetTextColor(0, 0, 0, 1)
    f:addButton("Take a Screenshot", "Make a screenshot, find it in your\n" ..
                  "Wow Screenshots folder and paste online\nalong the text copied above.", function()
      Screenshot()
    end):Place(0, 14)
  else
    f.TitleText:SetText(title)
    f.subTitle:SetText(subtitle)
  end
  local eb = f.seb.editBox
  local fullText = title .. " " .. self.manifestVersion .. "\n" .. date("%Y/%m/%d %T %z") .. " " .. text ..
                     "\nSession messages log:\n"
  local numEntries = #self.sessionLog
  local skipped = 0
  local maxLines = self.bugReportMaxLines
  local keepFirst = self.bugReportKeepFirst
  local keepRecent = maxLines - keepFirst
  local maxEntryLen = self.bugReportMaxEntryLen
  local truncated = 0
  local utf8 = 0
  local pipes = 0
  for i = numEntries, 1, -1 do
    if numEntries < maxLines or i <= keepFirst or i > numEntries - keepRecent then
      local l = self.sessionLog[i]
      if #l > maxEntryLen then
        l = l:sub(1, maxEntryLen)
        truncated = truncated + 1
        -- if we cut right mid ||, this assumes there is no actual valid escape in the sessionLog
        if l:sub(-1) == "|" then
          l = l:sub(1, -2)
          pipes = pipes + 1
        end
        while (string.byte(l:sub(-1)) > 127) and #l >= 0 do
          l = l:sub(1, -2)
          utf8 = utf8 + 1
        end
        l = l .. "..."
      end
      fullText = fullText .. l .. "\n"
    else
      if skipped == 0 then
        fullText = fullText .. "[...skipped " .. tostring(numEntries - maxLines) .. " lines...]\n"
      end
      skipped = skipped + 1
    end
  end
  self:Debug(1, "Size of bug report text is % bytes and ~ % lines, skipped % middle lines, " ..
               "truncated % entries, utf8 shortening %, % pipes", #fullText, #self.sessionLog + 3, skipped, truncated,
             utf8, pipes)
  self:SetReadOnly(eb, fullText)
  f:Snap()
  f:Show()
  return f
end

---
ML:Debug(1, "MoLib UI file loaded")

--[[
   PixelPerfectAlign by MooreaTV moorea@ymail.com (c) 2019 All rights reserved
   Licensed under LGPLv3 - No Warranty
   (contact the author if you need a different license)

   Demonstrates pixel perfect handling from MoLib.

   Feel free to embed/use MoLib according to the license but not
   just copy paste what you want from it into your addon.
   https://github.com/mooreatv/MoLib

   Please contact the author if you're interested in doing more/using it.

   Get this addon binary release using curse/twitch client or on wowinterface
   The source of the addon resides on https://github.com/mooreatv/PixelPerfectAlign
   (and the MoLib library at https://github.com/mooreatv/MoLib)

   Releases detail/changes are on https://github.com/mooreatv/PixelPerfectAlign/releases
   ]] --
--
-- our name, our empty default (and unused) anonymous ns
local addon, _ns = ...

-- Table and base functions created by MoLib
local PPA = _G[addon]
-- localization
PPA.L = PPA:GetLocalization()
local L = PPA.L

PPA.showSplash = 0 -- how long to show splash at start
PPA.startWithGridOn = false -- start with grid showing?
PPA.lineLength = 16
PPA.numX = 16 -- 0 is auto is 16 / aspect ratio
PPA.numY = 0 -- 0 is auto / aspect ratio
PPA.showMinimapIcon = true

-- PPA.debug = 9 -- to debug before saved variables are loaded

function PPA:ShowGrid()
  PPA:Debug(2, "Show grid called")
  if not PPA.grid then
    PPA:Debug(1, "Creating the grid")
    local nX = PPA.numX
    local nY = PPA.numY
    if nY == 0 then
      nY = PPA:AspectRatio(nX)
    end
    PPA.grid = PPA:FineGrid(nX, nY, PPA.lineLength, "PPA_Grid")
  end
  PPA.grid:Show()
  PPA.gridShown = true
end

function PPA:HideGrid()
  PPA:Debug(2, "Hide grid called")
  if PPA.gridShown and PPA.grid then
    PPA:Debug(1, "Hiding the grid")
    PPA.grid:Hide()
  end
  PPA.gridShown = false
end

function PPA:ToggleGrid()
  if PPA.gridShown then
    PPA:HideGrid()
  else
    PPA:ShowGrid()
  end
end

function PPA:ShowDisplayInfo(seconds)
  PPA:WipeFrame(PPA.displayInfo)
  PPA.displayInfo = PPA:DisplayInfo(-250, -300, 1.5)
  C_Timer.After(seconds, function()
    PPA.displayInfo:Hide()
  end)
end

function PPA:SetupMenu()
  PPA:WipeFrame(PPA.mmb)
  if not PPA.showMinimapIcon then
    PPA:Debug("Not showing minimap icon per config")
    return
  end
  local b = PPA:minimapButton(PPA.buttonPos)
  local _nw, _nh, s, w, h = PPA:PixelPerfectSnap(b)
  self:Debug("new w % h %", w, h)
  if b.icon then
    PPA:WipeFrame(b.icon)
  end
  local icon = CreateFrame("Frame", nil, b)
  b.icon = icon
  -- set scale to be pixels
  icon:SetScale(s / icon:GetEffectiveScale())
  PPA:Debug("Scale is now % es % ppf es %", icon:GetScale(), icon:GetEffectiveScale(), s)
  local delta = math.floor((w - 32) / 2)
  icon:SetPoint("BOTTOMLEFT", delta, delta)
  icon:SetFlattensRenderLayers(true)
  icon:SetSize(48, 48)
  icon:SetIgnoreParentAlpha(true)
  -- based on 32x32
  local start = 11.5
  local off = 4
  self:Debug("off is %", off)
  if delta >= 1 then
    off = off + PPA:round((w - 32) / 4)
  end
  local len = .75
  local width = .75
  local other = start + 2 * off
  PPA:DrawCross(icon, start, start, len, 0, width, PPA.gold)
  PPA:DrawCross(icon, start, other, len, 0, width, PPA.gold)
  PPA:DrawCross(icon, start + off, start + off, len, 0, width, PPA.red) -- 1 red pixel
  PPA:DrawCross(icon, other, start, len, 0, width, PPA.gold)
  PPA:DrawCross(icon, other, other, len, 0, width, PPA.gold)
  b:SetScript("OnClick", function(_w, button, _down)
    if button == "RightButton" then
      PPA.Slash("config")
    else
      if IsShiftKeyDown() then
        PPA.Slash("info")
      elseif IsControlKeyDown() then
        PPA:ToggleCoordinates(0)
      else
        PPA.Slash("toggle")
      end
    end
  end)
  b.tooltipText = "|cFFF2D80CPixel Perfect Align|r:\n" ..
                    L["|cFF99E5FFLeft|r click to toggle grid\n" .. "|cFF99E5FFShift|r click for info display\n" ..
                      "|cFF99E5FFControl|r click for cursor coordinates\nand distance measurements\n" ..
                      "|cFF99E5FFRight|r click for options\n\n" .. "Drag to move this button."]
  b:SetScript("OnEnter", function()
    PPA:ShowToolTip(b, "ANCHOR_LEFT")
    PPA.inButton = true
  end)
  b:SetScript("OnLeave", function()
    GameTooltip:Hide()
    PPA.inButton = false
    PPA:Debug("Hide tool tip...")
  end)
  PPA:MakeMoveable(b, PPA.SavePositionCB)
  PPA.mmb = b
  PPA.mmb.icon = icon
end

function PPA.SavePositionCB(_f, pos, _scale)
  PPA:SetSaved("buttonPos", pos)
end

function PPA:CoordCorner(f, cy, cx, padding) -- "BOTTOM" , "LEFT"
  padding = padding or 4
  local pt = cy .. cx
  local opposite
  local xsign
  local ysign
  if cy == "BOTTOM" then
    ysign = 1
    opposite = "TOP"
  else
    ysign = -1
    opposite = "BOTTOM"
  end
  local offy = ysign * padding
  if cx == "LEFT" then
    xsign = 1
    opposite = opposite .. "RIGHT"
  else
    xsign = -1
    opposite = opposite .. "LEFT"
  end
  local offx = xsign * padding
  local pad = 1 / 32
  local len = 10 + pad
  f.bottom:SetStartPoint(pt, xsign * (1 + pad), ysign * pad)
  f.bottom:SetEndPoint(pt, xsign * len, ysign * pad)
  f.right:SetStartPoint(pt, xsign * pad, ysign * (1 + pad))
  f.right:SetEndPoint(pt, xsign * pad, ysign * len)
  f.txt:SetJustifyV(cy)
  f.txt:SetJustifyH(cx)
  f.txt:ClearAllPoints()
  f.txt:SetPoint(pt, offx, offy)
  f.cx = cx
  f.cy = cy
  f.point = pt
  f.opposite = opposite
end

function PPA:CreateMeasureBox()
  local f = PPA:Frame(nil, nil, nil, PPA.coordParentFrame)
  f:SetFrameStrata("TOOLTIP")
  f:SetFrameLevel(8)
  f.bg = f:CreateTexture(nil, "BACKGROUND")
  f.bg:SetAllPoints()
  f.bg:SetColorTexture(0, 0.2, 0, .3)
  f.txt = f:addText("Dimensions", "NumberFont_Outline_Large")
  f.txt:SetJustifyH("CENTER")
  f.txt:SetPoint("CENTER")
  f:Show()
  return f
end

function PPA:CreateCoordFrame(...)
  -- create parent frame for all 3 frames that handles the always visible part for all at once
  if not PPA.coordParentFrame then
    local pf = PPA:Frame()
    PPA.coordParentFrame = pf
    pf:SetAllPoints()
    pf:SetScript("OnHide", function(w)
      if not PPA.coordinateShown then
        return
      end
      -- Switch to WorldFrame based pp so we stay visible
      PPA:PrintDefault("PPA: Switching coordinates to be attached to WorldFrame")
      w:SetParent(PPA:PixelPerfectFrame(true))
      w.onWF = true
    end)
    PPA.tape = PPA:StandardFrame("PPAtape", L["Pixel Perfect Align tape"], pf)
    PPA.tape:addText(L["|cFF99E5FFLeft click|r to set one point, left click again to record dimensions here\n" ..
                       "and set a new point. Right click to erase current point."]):Place(4)
    local font = PPA:NormalizeFont("ChatFontNormal")
    local _, h = font:GetFont()
    PPA.tape.defaultTextColor = {0.1, .9, .1, 1}
    PPA.tape.seb = PPA.tape:addScrollEditFrame(400, h * 16, font) -- 12 lines
    PPA.tape.lineHeight = h * 3
    PPA.tape.seb:Place(5, 14) -- 4 is inset
    PPA.tape.editBox = PPA.tape.seb.editBox
    PPA.tape.editBox:SetAutoFocus(false)
    local fnOutside = function()
      PPA.tape.inside = nil
    end
    PPA.tape:SetScript("OnLeave", fnOutside)
    PPA.tape:SetScript("OnHide", fnOutside)
    local fn = function()
      PPA.tape.inside = true
    end
    PPA.tape.editBox:SetScript("OnSizeChanged", function(w, _, nh)
      if w:HasFocus() then
        return
      end
      local sh = w:GetParent():GetHeight()
      if nh > sh then
        -- despite what the wiki used to say, this is actually required to make it work
        PPA.tape.seb:UpdateScrollChildRect()
        PPA.tape.seb:SetVerticalScroll(nh - sh)
      end
    end)
    PPA.tape:SetScript("OnEnter", fn)
    -- somehow the containing frame is left to enter these - TODO find something less ugly than explictly coding 5 extra frames
    PPA.tape.editBox:SetScript("OnEnter", fn)
    PPA.tape.seb.ScrollBar:SetScript("OnEnter", fn)
    PPA.tape.seb.ScrollBar.ScrollDownButton:SetScript("OnEnter", fn)
    PPA.tape.seb.ScrollBar.ScrollUpButton:SetScript("OnEnter", fn)
    PPA.tape.CloseButton:SetScript("OnEnter", fn)
    --[[     PPA.tape.editBox:SetScript("OnCursorChanged", function(w, _x, _y, _u, lh)
      local sf = w:GetParent()
      sf:SetVerticalScroll(w:GetHeight() - sf:GetHeight() + 2 * lh)
    end)
 ]]
    PPA.tape:Snap()
  end
  local f = PPA:Frame(nil, nil, nil, PPA.coordParentFrame)
  f:SetFrameStrata("TOOLTIP")
  f.bg = f:CreateTexture(nil, "BACKGROUND")
  f.bg:SetAllPoints()
  f.bg:SetColorTexture(...)
  local r, g, b, alpha = 1, .8, .4, 0.95
  f.txt = f:addText("Coordinates", "NumberFont_Outline_Large")
  f.txt:SetTextColor(r, g, b, alpha)
  local thickness = 1
  local layer = "BACKGROUND"
  -- f:SetSize(2 * len, 2 * len) -- initial size for placing the lines
  f.bottom = f:addLine(thickness, r, g, b, alpha, layer, true)
  f.right = f:addLine(thickness, r, g, b, alpha, layer, true)
  return f
end

function PPA:UpdateCoordFrame(c, reverse)
  local px, py, ux, uy, rx, ry = PPA:GetCursorCoordinates()
  if px == c.px and py == c.py then
    return false
  end
  c.px = px
  c.py = py
  c.txt:SetText(string.format("Raw %.2f , %.2f\nUI %.2f , %.2f\nPixel %d , %d", rx, ry, ux, uy, px, py))
  local w, h = c:GetSize()
  local sw = c.txt:GetStringWidth()
  local sh = c.txt:GetStringHeight()
  if c.debugCount and c.debugCount > 0 then
    PPA:Debug(8, "coordf is % x % - string is % x % - cursor is % , % - pts % / %", w, h, sw, sh, px, py, c.point,
              c.opposite)
    c.debugCount = c.debugCount - 1
  end
  c:SetSize(sw + 4, sh + 8)
  c:ClearAllPoints()
  -- opposite side of std cursor most times except top and left
  local cx, cy
  if reverse then
    if (c:GetParent():GetWidth() - px) < sw then
      cx = "RIGHT"
    else
      cx = "LEFT"
    end
    if py > sh then
      cy = "TOP"
    else
      cy = "BOTTOM"
    end
  else
    if px < sw then
      cx = "LEFT"
    else
      cx = "RIGHT"
    end
    if (c:GetParent():GetHeight() - py) < sh then
      cy = "TOP"
    else
      cy = "BOTTOM"
    end
  end
  PPA:CoordCorner(c, cy, cx)
  c:SetPoint(c.point, nil, "BOTTOMLEFT", px + (cx == "LEFT" and 0 or 1), py - (cy == "BOTTOM" and 1 or 0))
  return true
end

function PPA:ShowCoordinates()
  if PPA.coordinateShown then
    return -- already shown, nothing to do
  end
  if PPA.hideTimer then
    PPA.hideTimer:Cancel()
    PPA.hideTimer = nil
  end
  PPA.coordinateShown = true
  local f = PPA.coordinateFrame
  if not f then
    f = PPA:CreateCoordFrame(0, 0, 0.2, .3)
    PPA.coordinateFrame = f
  end
  PPA.tape:Show()
  f.debugCount = 4
  f:SetScript("OnUpdate", function(c)
    local pf = c:GetParent()
    if pf.onWF and UIParent:IsVisible() then
      -- back to UIParent based pp base (so we and other coord windows are on top)
      PPA:PrintDefault("PPA: Switching coordinates to be attached back to UIParent")
      pf.onWF = nil
      pf:SetParent(PPA:PixelPerfectFrame())
      pf:SetFrameStrata("TOOLTIP")
    end
    if PPA.tape.inside then
      return
    end
    PPA:UpdateCoordFrame(c)
    if IsMouseButtonDown("RightButton") and c.secondFrame then
      c.secondFrame:Hide()
      c.measureBox:Hide()
      return
    end
    if IsMouseButtonDown("LeftButton") then
      if not c.secondFrame then
        c.secondFrame = PPA:CreateCoordFrame(0.2, 0, 0, .3)
        c.measureBox = PPA:CreateMeasureBox(c, c.secondFrame)
      elseif c.measureBox.w ~= 0 and c.measureBox.h ~= 0 then
        PPA.tape.editBox:HighlightText(0, 0)
        PPA.tape.editBox:SetCursorPosition(#PPA.tape.editBox:GetText())
        PPA.tape.editBox:Insert("|cFFE04010A:|r " .. c.secondFrame.txt:GetText():gsub("\n", "; ") .. "\n")
        PPA.tape.editBox:Insert("|cFF3030FFB:|r " .. c.txt:GetText():gsub("\n", "; ") .. "\n")
        PPA.tape.editBox:Insert("|cFFFFFF00->|r |cFFF0F0F0" .. c.measureBox.txt:GetText():gsub("\n", "; ") .. "|r\n\n")
        PPA.tape.editBox:SetCursorPosition(#PPA.tape.editBox:GetText())
      end
      PPA:UpdateCoordFrame(c.secondFrame, true) -- prefer the opposite edge
      c.secondFrame:Show()
      c.measureBox:Show()
    end
    if c.measureBox and c.measureBox:IsVisible() then
      c.measureBox:SetPoint("BOTTOMRIGHT", nil, "BOTTOMLEFT", c.secondFrame.px, c.secondFrame.py)
      c.measureBox:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", c.px, c.py)
      local w = math.abs(c.px - c.secondFrame.px)
      local h = math.abs(c.py - c.secondFrame.py)
      c.measureBox.w = w
      c.measureBox.h = h
      c.measureBox.txt:SetText(string.format("%d x %d\nΔ %.1f", w, h, math.sqrt(w * w + h * h)))
    end
  end)
  f:Show()
  PPA:Debug("Showing coordinates")
end

function PPA:HideCoordinates(linger)
  if not PPA.coordinateShown then
    return -- already hidden, nothing to do
  end
  PPA.coordinateShown = nil
  local f = PPA.coordinateFrame
  f:SetScript("OnUpdate", nil)
  local fn = function()
    f:ClearAllPoints()
    f:Hide()
    if f.secondFrame then
      f.secondFrame:Hide()
      f.measureBox:Hide()
    end
  end
  if linger < 1 then
    fn()
  else
    if PPA.hideTimer then
      PPA.hideTimer:Cancel()
    end
    PPA.hideTimer = C_Timer.NewTimer(linger, fn)
  end
  PPA:Debug("Hiding coordinates (in 4 sec)")
end

function PPA:ToggleCoordinates(linger)
  linger = linger or 5
  if PPA.coordinateShown then
    PPA:PrintDefault("PixelPerfectAlign coordinates update OFF" ..
                       (linger > 0 and ", keeping visible for a few seconds." or "."))
    PPA:HideCoordinates(linger)
  else
    PPA:PrintDefault("PixelPerfectAlign coordinates ON.")
    PPA:ShowCoordinates()
  end
end

PPA.EventHdlrs = {

  --[[   MODIFIER_STATE_CHANGED = function(_self, ...)
    PPA:DebugEvCall(1, ...)
    if IsControlKeyDown() then
      if PPA.inButton then
        GameTooltip:Hide()
        PPA:ShowCoordinates()
      end
    else
      if not PPA.coordinateKeep then
        PPA:HideCoordinates(5)
      end
    end
  end,
 ]]

  PLAYER_ENTERING_WORLD = function(_self, ...)
    PPA:Debug("OnPlayerEnteringWorld " .. PPA:Dump(...))
    PPA:CreateOptionsPanel()
    if PPA.startWithGridOn then
      PPA:ShowGrid()
    end
    if PPA.showSplash > 0 then
      PPA:ShowDisplayInfo(PPA.showSplash)
    end
    PPA:SetupMenu()
  end,

  UPDATE_BINDINGS = function(_self, ...)
    PPA:DebugEvCall(1, ...)
  end,

  DISPLAY_SIZE_CHANGED = function(_self)
    -- Always wipe (fast the 2nd time) so when showing again next it's built correctly.
    PPA.grid = PPA:WipeFrame(PPA.grid)
    if PPA.gridShown then
      PPA:Debug("Grid is shown and we are resizing so re-drawing the grid")
      -- TODO consider buffering as there is often 2+ events, or checking for actual change
      PPA:ShowGrid()
    end
    if PPA.mmb then
      PPA:SetupMenu() -- should be able to just RestorePosition() but...
    end
  end,

  UI_SCALE_CHANGED = function(_self, ...)
    PPA:DebugEvCall(1, ...)
    if PPA.mmb then
      PPA:SetupMenu() -- buffer with the one above?
    end
  end,

  ADDON_LOADED = function(_self, _event, name)
    PPA:Debug(9, "Addon % loaded", name)
    if name ~= addon then
      return -- not us, return
    end
    -- check for dev version (need to split the tags or they get substituted)
    if PPA.manifestVersion == "@" .. "project-version" .. "@" then
      PPA.manifestVersion = "vX.YY.ZZ"
    end
    PPA:PrintDefault("PixelPerfectAlign " .. PPA.manifestVersion .. " by MooreaTv: type /ppa for command list/help.")
    if pixelPerfectAlignSaved == nil then
      PPA:Debug("Initialized empty saved vars")
      pixelPerfectAlignSaved = {}
    end
    pixelPerfectAlignSaved.addonVersion = PPA.manifestVersion
    pixelPerfectAlignSaved.addonHash = "9a6a4e5"
    PPA:deepmerge(PPA, nil, pixelPerfectAlignSaved)
    PPA:Debug(3, "Merged in saved variables.")
    PPA.savedVar = pixelPerfectAlignSaved -- by ref, for SetSaved,...
  end
}

function PPA:Help(msg)
  PPA:PrintDefault("PixelPerfectAlign: " .. msg .. "\n" .. "/ppa show -- shows the grid\n" ..
                     "/ppa hide -- hides the grid\n" .. "/ppa toggle -- toggles show/hide\n" ..
                     "/ppa info -- displays info about screen and resolution for a few seconds\n" ..
                     "/ppa coord -- toggle pixel coordinates\n" .. "/ppa config -- open addon config\n" ..
                     "/ppa bug -- report a bug\n" .. "/ppa debug on/off/level -- for debugging on at level or off.\n" ..
                     "/ppa version -- shows addon version")
end

function PPA.Slash(arg) -- can't be a : because used directly as slash command
  PPA:Debug("Got slash cmd: %", arg)
  if #arg == 0 then
    PPA:Help("commands, you can use the first letter of each:")
    return
  end
  local cmd = string.lower(string.sub(arg, 1, 1))
  local posRest = string.find(arg, " ")
  local rest = ""
  if not (posRest == nil) then
    rest = string.sub(arg, posRest + 1)
  end
  if cmd == "s" then
    -- show
    PPA:ShowGrid()
  elseif cmd == "h" then
    PPA:HideGrid()
  elseif cmd == "b" then
    local subText = L["Please submit on discord or on https://|cFF99E5FFbit.ly/ppabug|r or email"]
    PPA:PrintDefault(L["PixelPerfectAddon bug report open: "] .. subText)
    -- base molib will add version and date/timne
    PPA:BugReport(subText, "9a6a4e5\n\n" .. L["Bug report from slash command"])
  elseif cmd == "t" then
    PPA:ToggleGrid()
  elseif cmd == "i" then
    local sec = 8
    PPA:PrintDefault("PixelPerfectAlign showing display (debug) info for % seconds", sec)
    PPA:ShowDisplayInfo(sec)
  elseif cmd == "v" then
    -- version
    PPA:PrintDefault("PixelPerfectAlign " .. PPA.manifestVersion ..
                       " (9a6a4e5) by MooreaTv (moorea@ymail.com)")
  elseif PPA:StartsWith(arg, "coord") then
    PPA:ToggleCoordinates()
  elseif cmd == "c" then
    -- Show config panel
    -- InterfaceOptionsList_DisplayPanel(PPA.optionsPanel)
    InterfaceOptionsFrame:Show() -- onshow will clear the category if not already displayed
    InterfaceOptionsFrame_OpenToCategory(PPA.optionsPanel) -- gets our name selected
  elseif cmd == "e" then
    -- copied from PixelPerfectAlign, as augment on event trace
    UIParentLoadAddOn("Blizzard_DebugTools")
    -- hook our code, only once/if there are no other hooks
    if EventTraceFrame:GetScript("OnShow") == EventTraceFrame_OnShow then
      EventTraceFrame:HookScript("OnShow", function()
        EventTraceFrame.ignoredEvents = PPA:CloneTable(PPA.etraceIgnored)
        PPA:PrintDefault("Restored ignored etrace events: %", PPA.etraceIgnored)
      end)
    else
      PPA:Debug(3, "EventTraceFrame:OnShow already hooked, hopefully to ours")
    end
    -- save or anything starting with s that isn't the start/stop commands of actual eventtrace
    if PPA:StartsWith(rest, "s") and rest ~= "start" and rest ~= "stop" then
      PPA:SetSaved("etraceIgnored", PPA:CloneTable(EventTraceFrame.ignoredEvents))
      PPA:PrintDefault("Saved ignored etrace events: %", PPA.etraceIgnored)
    elseif PPA:StartsWith(rest, "c") then
      EventTraceFrame.ignoredEvents = {}
      PPA:PrintDefault("Cleared the current event filters")
    else -- leave the other sub commands unchanged, like start/stop and n
      PPA:Debug("Calling  EventTraceFrame_HandleSlashCmd(%)", rest)
      EventTraceFrame_HandleSlashCmd(rest)
    end
  elseif PPA:StartsWith(arg, "debug") then
    -- debug
    if rest == "on" then
      PPA:SetSaved("debug", 1)
    elseif rest == "off" then
      PPA:SetSaved("debug", nil)
    else
      PPA:SetSaved("debug", tonumber(rest))
    end
    PPA:PrintDefault("PixelPerfectAlign debug now %", PPA.debug)
  else
    PPA:Help('unknown command "' .. arg .. '", usage:')
  end
end

-- Run/set at load time:

-- Slash

SlashCmdList["PixelPerfectAlign_Slash_Command"] = PPA.Slash

SLASH_PixelPerfectAlign_Slash_Command1 = "/ppa"
SLASH_PixelPerfectAlign_Slash_Command2 = "/align"

-- Events handling
PPA:RegisterEventHandlers()

-- Options panel

function PPA:CreateOptionsPanel()
  if PPA.optionsPanel then
    PPA:Debug("Options Panel already setup")
    return
  end
  PPA:Debug("Creating Options Panel")

  local p = PPA:Frame(L["PixelPerfectAlign"])
  PPA.optionsPanel = p
  p:addText(L["PixelPerfectAlign options"], "GameFontNormalLarge"):Place()
  p:addText(L["These options let you control the behavior of PixelPerfectAlign"] .. " " .. PPA.manifestVersion ..
              " 9a6a4e5"):Place()

  local lineLengthSlider = p:addSlider(L["Grid line length"], L["How many pixels for the lines/crosses drawn"], 1, 128,
                                       1):Place(8, 24)

  local startWithGrid = p:addCheckBox(L["Show Grid from start"], L["Whether we should start with the Grid shown"])
                          :Place(4, 12)

  -- we can't put more than 16k textures at a time in our frame so limit the sliders accordingly
  local numXSlider = p:addSlider(L["Horizontal grid intervals"], L["How many intervals horizontally."], 2, 92, 1):Place(
                       8, 24)

  local numYSlider = p:addSlider(L["Vertical grid intervals"],
                                 L["How many intervals vertically.\nWill be based on aspect ratio when set to Auto"], 0,
                                 84, 1, L["Auto"])
  numYSlider:Place(8, 24)

  p:addButton(L["Toggle Grid"],
              L["Toggles the grid between shown and hidden"] .. "\n|cFF99E5FF/ppa toggle|r " .. L["or Key Binding"],
              "toggle"):Place(4, 20)

  p:addButton(L["Display Info"], L["Displays screen/resolution information for a few seconds"] ..
                "\n|cFF99E5FF/ppa info|r " .. L["or Key Binding"], "info"):PlaceRight()

  p:addButton(L["Toggle Coordinates/Measurement mode"],
              L["Toggles the display of cursor pixel coordinates."] .. "\n" ..
                L["In that mode click to start measuring between 2 points,"] .. "\n" ..
                L["and right click to stop measuring"] .. "\n|cFF99E5FF/ppa coords|r " .. L["or Key Binding"],
              function()
    PPA:ToggleCoordinates(0)
  end):PlaceRight()

  local showSplash = p:addSlider(L["Show Info at login"],
                                 L["How long if at all to show the grid and information at login"], 0, 9, 3, L["Off"],
                                 L["9 seconds"], {[3] = "3 s", [6] = "6 s", [9] = "9 s"}):Place(8, 24)


  local showMinimapIcon = p:addCheckBox("Show minimap icon",
    "Show/Hide the minimap button"):Place(4,20)

  p:addText(L["Development, troubleshooting and advanced options:"]):Place(40, 20)

  p:addButton("Bug Report", L["Get Information to submit a bug."] .. "\n|cFF99E5FF/ppa bug|r", "bug"):Place(4, 20)

  p:addButton(L["Reset minimap button"], L["Resets the minimap button to back to initial default location"], function()
    PPA:SetSaved("buttonPos", nil)
    PPA:SetupMenu()
  end):Place(4, 20)

  local debugLevel = p:addSlider(L["Debug level"], L["Sets the debug level"] .. "\n|cFF99E5FF/ppa debug X|r", 0, 9, 1,
                                 "Off"):Place(16, 30)

  p:addButton(L["Event Trace"], L["Starts the blizzard Event Trace with saved filters"] .. "\n|cFF99E5FF/ppa event|r",
              "event"):Place(0, 20)

  p:addButton(L["Save Filters"], L["Saves the set of currently filtered Events"] .. "\n|cFF99E5FF/ppa event save|r",
              "event save"):PlaceRight()

  p:addButton(L["Clear Filters"], L["Clear saved filtered Events"] .. "\n|cFF99E5FF/ppa event clear|r", "event clear")
    :PlaceRight()

  function p:refresh()
    PPA:Debug("Options Panel refresh!")
    if PPA.debug then
      -- expose errors
      xpcall(function()
        self:HandleRefresh()
      end, geterrorhandler())
    else
      -- normal behavior for interface option panel: errors swallowed by caller
      self:HandleRefresh()
    end
  end

  function p:HandleRefresh()
    p:Init()
    debugLevel:SetValue(PPA.debug or 0)
    showSplash:SetValue(PPA.showSplash)
    startWithGrid:SetChecked(PPA.startWithGridOn)
    lineLengthSlider:SetValue(PPA.lineLength)
    numXSlider:SetValue(PPA.numX)
    numYSlider:SetValue(PPA.numY)
    showMinimapIcon:SetChecked(PPA.showMinimapIcon)
    p.oldStart = PPA.startWithGridOn
  end

  function p:HandleOk()
    PPA:Debug(1, "PPA.optionsPanel.okay() internal")
    local changes = 0
    changes = changes + PPA:SetSaved("lineLength", lineLengthSlider:GetValue())
    changes = changes + PPA:SetSaved("numX", numXSlider:GetValue())
    changes = changes + PPA:SetSaved("numY", numYSlider:GetValue())
    if changes > 0 then
      PPA:PrintDefault("PPA: % change(s) made to grid config", changes)
      PPA.grid = PPA:WipeFrame(PPA.grid) -- be ready for next show
      if PPA.gridShown then
        PPA:ShowGrid()
      end
    end
    local sliderVal = debugLevel:GetValue()
    if sliderVal == 0 then
      sliderVal = nil
      if PPA.debug then
        PPA:PrintDefault("Options setting debug level changed from % to OFF.", PPA.debug)
      end
    else
      if PPA.debug ~= sliderVal then
        PPA:PrintDefault("Options setting debug level changed from % to %.", PPA.debug, sliderVal)
      end
    end
    PPA:SetSaved("debug", sliderVal)
    PPA:SetSaved("showSplash", showSplash:GetValue())
    PPA:SetSaved("startWithGridOn", startWithGrid:GetChecked())
    if PPA:SetSaved("showMinimapIcon", showMinimapIcon:GetChecked()) then
      PPA:SetupMenu()
    end
    if p.oldStart ~= PPA.startWithGridOn then
      PPA:PrintDefault("PPA: Changed start with grid to " .. (PPA.startWithGridOn and "ON" or "OFF"))
      if PPA.startWithGridOn then
        PPA:ShowGrid()
      else
        PPA:HideGrid()
      end
    end
  end

  function p:cancel()
    PPA:Warning("Options screen cancelled, not making any changes.")
  end

  function p:okay()
    PPA:Debug(3, "PPA.optionsPanel.okay() wrapper")
    if PPA.debug then
      -- expose errors
      xpcall(function()
        self:HandleOk()
      end, geterrorhandler())
    else
      -- normal behavior for interface option panel: errors swallowed by caller
      self:HandleOk()
    end
  end
  -- Add the panel to the Interface Options
  InterfaceOptions_AddCategory(PPA.optionsPanel)
end

-- bindings / localization
_G.PIXELPERFECTALIGN = "PixelPerfectAlign"
_G.BINDING_HEADER_PPA = L["Pixel Perfect Align addon key bindings"]
_G.BINDING_NAME_PPA_TOGGLE = L["Toggle Grid"] .. " |cFF99E5FF/ppa toggle|r"
_G.BINDING_NAME_PPA_INFO = L["Show Display Info"] .. " |cFF99E5FF/ppa info|r"
_G.BINDING_NAME_PPA_COORDS = L["Toogle screen coordinates"] .. " |cFF99E5FF/ppa coords|r"

-- PPA.debug = 2
PPA:Debug("ppa main file loaded")

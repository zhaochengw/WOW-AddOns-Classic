local SCT = SCT
local db

local sct_CRIT_FADEINTIME = 0.3
local sct_CRIT_HOLDTIME = 2.0
local sct_CRIT_FADEOUTTIME = 0.5
local sct_CRIT_Y_OFFSET = 10
local sct_CRIT_SIZE_PERCENT = 1.25
local sct_CRIT_FLASH_SIZE_PERCENT = 2
local sct_CRIT_MAX_COUNT = 7
local sct_MAX_SPEED = .025
local sct_MIN_UPDATE_SPEED = .01
local sct_SIDE_POINT = 210
local sct_MAX_DISTANCE = 150
local sct_HUD_DIST = 50
local sct_DIRECTION = 1
local sct_SPRINKLER_START = 18
local sct_SPRINKLER_STEP = -3
local sct_SPRINKLER_RADIUS = 20
local sct_SPRINKLER = sct_SPRINKLER_START

--Animation System variables
local sct_TEXTCOUNT = 50        -- Number of text that can animate
local arrAlign = {[1] = "LEFT", [2] = "CENTER", [3] = "RIGHT"}
local animations                -- animation mapping table
local arrFrameTexts = {}
SCT.ArrayAniData = {
  [SCT.FRAME1] = {},
  [SCT.FRAME2] = {},
}
SCT.ArrayAniCritData = {
  [SCT.FRAME1] = {},
  [SCT.FRAME2] = {},
}

for i=1, sct_TEXTCOUNT do
  arrFrameTexts[i] = SCT_ANIMATION_FRAME:CreateFontString(string.format("SCTaniData%d",i),"OVERLAY", "GameFontNormal")
end

--LUA calls
local pairs = pairs
local math_sqrt = math.sqrt
local math_abs = math.abs
local math_fmod = math.fmod
local math_ceil = math.ceil
local random = random
local tremove = tremove
local tinsert = function(t,v)
  t[#t+1] = v
end

----------------------
--Calculate Circle X pos based on current settings
local function CalculateCircleCordX(adat)
  local max = (adat.toppoint - adat.bottompoint)/2
  local top =  adat.toppoint - max
  local cY = adat.posY - top
  local cX = math_ceil(math_sqrt(math_abs((max ^ 2) - math_abs(cY ^ 2))))
  return math_ceil(adat.offsetX - (adat.sidedir * (cX + adat.gap)))
end

----------------------
--Calculate Angled X pos based on current settings
local function CalculateAngleCordX(adat)
  local max = adat.toppoint - adat.bottompoint
  local cY = adat.posY - adat.toppoint
  local cX = max + math_ceil(cY*.3)
  return math_ceil(adat.offsetX - (adat.sidedir * (cX + adat.gap)))
end

----------------------
--Display the Text
function SCT:DisplayText(msg, color, iscrit, etype, frame, anitype, parent, icon)
  --Set up  text animation
  local adat = self:GetNextAniObj(frame)

  --set override animation
  adat.anitype = anitype or adat.anitype

  --set parent and properties
  if (parent) then
    self:NameplateAnimation(adat, parent)
  else
    adat.parent = UIParent
  end

  --If its a crit hit, increase the size
  if (iscrit) then
    self:CritInit(adat)
  end

  --if its not a sticky critm set up normal text start position
  if (adat.crit ~= true) then
    --get direction type
    self:SideInit(adat, etype)
    --perform init function
    adat.anim = animations[adat.anitype].anim
    adat.init = animations[adat.anitype].init
    adat.init(self, adat)
  end

  --set default color if none
  color = color or {r = 1.0, g = 1.0, b = 1.0}

  --set up text
  self:SetFontSize(adat, adat.font, adat.textsize, adat.fontshadow)
  adat:SetTextColor(color.r, color.g, color.b)
  adat:SetAlpha(adat.alpha)
  adat:SetPoint(arrAlign[adat.align], adat.parent, "CENTER", adat.posX, adat.posY)
  adat:SetText(msg)
  adat:Show()
  tinsert(self.ArrayAniData[adat.frame], adat)

  --setup icon
  if (db["ICON"] and icon) then
    self:IconInit(adat, icon)
  end

  --Start up onUpdate
  if (not SCT_ANIMATION_FRAME:IsVisible()) then
    SCT_ANIMATION_FRAME:Show()
  end
end

----------------------
-- setup animation for nameplates
function SCT:NameplateAnimation(adat, parent)
  if parent and parent.GetTop then
    adat.parent = parent
    adat.anitype = 1
    --make position show on screen
    -- if (WorldFrame:GetTop() - parent:GetTop()) < sct_MAX_DISTANCE then -- parent:GetTop() is now a restricted function
      -- adat.posY = (WorldFrame:GetTop() - parent:GetTop()) - sct_MAX_DISTANCE + parent:GetHeight() -- parent:GetTop() is now a restricted function
    -- else
      adat.posY = parent:GetHeight()
    -- end
    adat.posX = 0
    adat.offsetY = 0
    adat.offsetX = 0
    adat.bottompoint = adat.posY
    adat.toppoint = adat.posY + sct_MAX_DISTANCE
    adat.direction = nil
  else
    adat.parent = UIParent
  end
end

----------------------
-- Update animations that are being used
function SCT:UpdateAnimation(aniframe, elapsed)
  local anyActive = false
  local i, key, value
  for i = 1, #self.ArrayAniData do
    for key, value in pairs(self.ArrayAniData[i]) do
      if (value:IsShown()) then
        anyActive = true
        self:DoAnimation(value, elapsed)
      end
    end
  end
  --if none are active, stop onUpdate
  if ((anyActive ~= true) and (SCT_ANIMATION_FRAME:IsVisible())) then
    SCT_ANIMATION_FRAME:Hide()
  end
end

----------------------
--Move text to get the animation
function SCT:DoAnimation(adat, elapsed)
  local speed = db["ANIMATIONSPEED"] / 1000
  --If a crit
  adat.lastupdate = adat.lastupdate + elapsed
  if (adat.crit) then
    self:CritAnimation(adat,speed)
  --else normal text or event text
  else
    --if its time to update, move the text step positions
    while (adat.lastupdate > speed) do
      --do animation
      adat.anim(self, adat)
      adat.lastupdate = adat.lastupdate - speed
      --move text
      adat:SetAlpha(adat.alpha)
      adat:SetPoint(arrAlign[adat.align], adat.parent, "CENTER", adat.posX, adat.posY)
      --update icon
      if adat.icon then adat.icon:SetAlpha(adat.alpha) end
      --reset when alpha is 0
      if (adat.alpha <= 0) then
        self:AniReset(adat)
      end
    end
  end
end

----------------------
--Initialize Side Type
function SCT:SideInit(adat, etype)
  local curDir
  if adat.anitype ~= 1 then
    if (adat.sidedir == 1) then
      sct_DIRECTION = sct_DIRECTION * -1
      curDir = sct_DIRECTION
    elseif (adat.sidedir == 2) then
      if (etype=="event") then curDir = -1 else curDir = 1 end
    elseif (adat.sidedir == 3) then
      if (etype=="event") then curDir = 1 else curDir = -1 end
    elseif (adat.sidedir == 4) then
      curDir = 1
    elseif (adat.sidedir == 5) then
      curDir = -1
    end
    adat.sidedir = curDir
  end
  if (adat.align == 4) then
    if (adat.anitype == 7 or adat.anitype == 8) then
      adat.align = 2 + adat.sidedir
    else
      adat.align = 2
    end
  end
end

----------------------
--Initialize Crit Animation
function SCT:CritInit(adat)
  adat.textsize = adat.textsize * sct_CRIT_SIZE_PERCENT
  if (db["STICKYCRIT"]) then
    adat.crit = true
    adat.align = 2
    adat.posY = (adat.toppoint + adat.posY)/2
    adat.randomposy = self:GetNextCritLoc(adat)
    adat.posY = adat.posY + (adat.randomposy*(sct_CRIT_Y_OFFSET+adat.textsize))
    --if flash crits are on
    if (db["FLASHCRIT"]) then
      adat.critsize = adat.textsize * sct_CRIT_FLASH_SIZE_PERCENT
      if (adat.textsize > 32) then adat.textsize = 32 end
    end
  end
end

----------------------
--Do Crit Animation
function SCT:CritAnimation(adat,speed)
  local elapsedTime = adat.lastupdate
  local fadeInTime = sct_CRIT_FADEINTIME
  if ( elapsedTime < fadeInTime ) then
    local alpha = (elapsedTime / fadeInTime)
    adat:SetAlpha(alpha)
    --update icon
    if adat.icon then adat.icon:SetAlpha(alpha) end
    --if flash crits are on
    if (adat.critsize) then
      local critsize = floor(adat.critsize - ((adat.critsize - adat.textsize)*(elapsedTime/sct_CRIT_FADEINTIME)))
      adat:SetTextHeight(critsize)
    end
    return
  end
  --if flash crits are on, reset size to make sure its clean for display
  if (adat.critsize) then
    adat:SetTextHeight(adat.textsize)
    adat.critsize = nil
  end
  local holdTime = (sct_CRIT_HOLDTIME * (speed/sct_MAX_SPEED))
  if ( elapsedTime < (fadeInTime + holdTime) ) then
    adat:SetAlpha(adat.alpha)
    --update icon
    if adat.icon then adat.icon:SetAlpha(adat.alpha) end
    return
  end
  local fadeOutTime = sct_CRIT_FADEOUTTIME
  if ( elapsedTime < (fadeInTime + holdTime + fadeOutTime) ) then
    local alpha = 1 - ((elapsedTime - holdTime - fadeInTime) / fadeOutTime)
    adat:SetAlpha(alpha)
    --update icon
    if adat.icon then adat.icon:SetAlpha(alpha) end
    return
  end
  --reset crit
  self:AniReset(adat)
end

----------------------
--Initialize Vertical Animation
function SCT:VerticalInit(adat)
  --get the last known point of active items
  local lastpos = self:MinPoint(adat, 0, adat.anitype, adat.sidedir)
  if (not adat.direction) then
    --move the position down
    if ((lastpos - adat.posY) <= adat.textsize) then
      adat.posY = adat.posY - (adat.textsize - (lastpos - adat.posY))
    end
    --if its gone too far down, stop and move all events up
    if (adat.posY < (adat.bottompoint - sct_MAX_DISTANCE)) then
      adat.posY = (adat.bottompoint - sct_MAX_DISTANCE)
      self:MoveFrameUp(adat.frame, adat.textsize, adat.sidedir )
    end
    adat.addY = db["MOVEMENT"]
  else
    adat.posY = adat.toppoint
    --move the position up
    if ((adat.posY - lastpos) <= adat.textsize) then
      adat.posY = adat.posY + (adat.textsize - (adat.posY - lastpos))
    end
    --if its gone too far up, stop and move all events down
    if (adat.posY > (adat.toppoint + sct_MAX_DISTANCE)) then
      adat.posY = (adat.toppoint + sct_MAX_DISTANCE)
      self:MoveFrameDown(adat.frame, adat.textsize, adat.sidedir )
    end
    adat.addY = -1*db["MOVEMENT"]
  end
end

----------------------
--Do Vertical Animation
function SCT:VerticalAnimation(adat)
  local step = math_abs(adat.addY)
  local alphastep = 0.01 * step
  local max = sct_MAX_DISTANCE*.5
  adat.delay = adat.delay + 1
  if (adat.delay > (max/step)) then
    adat.alpha = math.max(0, adat.alpha - alphastep)
  end
  adat.posY = adat.posY + adat.addY
end

----------------------
--Initialize Rainbow Animation
function SCT:RainbowInit(adat)
  adat.addY = random(3,6)
  adat.posX = adat.posX - (20 * adat.sidedir)
end

----------------------
--Do Rainbow Animation
function SCT:RainbowAnimation(adat)
  if (adat.addY > 0) then
      adat.addY = adat.addY - 0.22
  else
      adat.addY = adat.addY - (0.18 * (db["MOVEMENT"]/2))
  end
  if adat.addY < -7 then adat.addY = -7 end
  adat.posY = adat.posY + adat.addY
  adat.posX = adat.posX - 2.2 * adat.sidedir
  if ( adat.posY < (adat.bottompoint - sct_MAX_DISTANCE) ) then
    adat.alpha = math.max(0, adat.alpha - 0.05)
  end
end

----------------------
--Initialize Horizontal Animation
function SCT:HorizontalInit(adat)
  adat.posX = adat.posX - (55 * adat.sidedir)
  adat.posY = adat.bottompoint + (random(0,200) - 100)
  adat.addX = db["MOVEMENT"]
end

----------------------
--Do Horizontal Animation
function SCT:HorizontalAnimation(adat)
  local step = math_abs(adat.addX)
  local alphastep = 0.01 * step
  local max = sct_SIDE_POINT*.5
  adat.delay = adat.delay + 1
  if (adat.delay > (max/step)) then
    adat.alpha = math.max(0, adat.alpha - alphastep)
  end
  adat.posX = adat.posX - (adat.addX * adat.sidedir)
end

----------------------
--Initialize Angled Down Animation
function SCT:AngledDownInit(adat)
  adat.posX = adat.posX - (20 * adat.sidedir)
  adat.addY = random(8,13)
  adat.addX = random(8,13)
end

----------------------
--Do Angled Down Animation
function SCT:AngledDownAnimation(adat)
  if (adat.delay <= 13) then
      adat.delay = adat.delay + 1
      adat.posY = adat.posY - adat.addY
      adat.posX = adat.posX - adat.addX * adat.sidedir
  elseif (adat.delay <= 35) then
      adat.delay = adat.delay + 1
      adat.posY = adat.posY + (random(0,70) - 35) * 0.02
      adat.posX = adat.posX + (random(0,70) - 35) * 0.02
  elseif (adat.delay <= 50) then
      adat.delay = adat.delay + 1
  else
      adat.posY = adat.posY + db["MOVEMENT"]
      adat.posX = adat.posX - db["MOVEMENT"] * adat.sidedir
      adat.alpha = math.max(0, adat.alpha - 0.02)
  end
end

----------------------
--Initialize Angled Up Animation
function SCT:AngledUpInit(adat)
  adat.posX = adat.posX - (20 * adat.sidedir)
  adat.addY = random(10,15)
  adat.addX = random(10,15)
end

----------------------
--Do Angled Up Animation
function SCT:AngledUpAnimation(adat)
  if (adat.delay <= 13) then
      adat.delay = adat.delay + 1
      adat.posY = adat.posY + adat.addY
      adat.posX = adat.posX - adat.addX * adat.sidedir
  elseif (adat.delay <= 35) then
      adat.delay = adat.delay + 1
      adat.posY = adat.posY + (random(0,70) - 35) * 0.02
      adat.posX = adat.posX + (random(0,70) - 35) * 0.02
  elseif (adat.delay <= 50) then
      adat.delay = adat.delay + 1
  else
      adat.posY = adat.posY + db["MOVEMENT"]
      adat.alpha = math.max(0, adat.alpha - 0.02)
  end
end

----------------------
--Initialize Sprinkler Animation
function SCT:SprinklerInit(adat)
  adat.addX = sct_SPRINKLER
  adat.addY = math_sqrt((sct_SPRINKLER_RADIUS ^ 2) - math_abs((sct_SPRINKLER ^ 2)))
  if ( adat.direction) then
    adat.addY = adat.addY * -1
  end
  sct_SPRINKLER = sct_SPRINKLER + sct_SPRINKLER_STEP
  if (sct_SPRINKLER < (sct_SPRINKLER_START * -1)) then
    sct_SPRINKLER = sct_SPRINKLER_START
  end
end

----------------------
--Do Sprinkler Animation
function SCT:SprinklerAnimation(adat)
  if (adat.delay <= (db["MOVEMENT"] + 10)) then
      adat.delay = adat.delay + 1
      adat.posY = adat.posY + adat.addY
      adat.posX = adat.posX + adat.addX
  elseif (adat.delay <= 35) then
      adat.delay = adat.delay + 1
      adat.posY = adat.posY + (random(0,70) - 35) * 0.02
      adat.posX = adat.posX + (random(0,70) - 35) * 0.02
  elseif (adat.delay <= 55) then
      adat.delay = adat.delay + 1
  else
      adat.posY = adat.posY + (adat.addY * .1)
      adat.posX = adat.posX + (adat.addX * .1)
      adat.alpha = math.max(0, adat.alpha - 0.02)
  end
end

----------------------
--Initialize Curved Animation
function SCT:HUDInit(adat)
  local lastpos = self:MinPoint(adat, sct_HUD_DIST, adat.anitype, adat.sidedir)
  --move toppoint to hud length
  adat.toppoint = adat.toppoint + sct_HUD_DIST
  if (not adat.direction) then
    --if overlap, move the whole frame events up
    if ((lastpos - adat.posY) <= adat.textsize) then
      self:MoveFrameUp(adat.frame, adat.textsize, adat.sidedir)
    end
    adat.addY = db["MOVEMENT"]
  else
    adat.posY = adat.toppoint
    --if overlap, move the whole frame events down
    if ((adat.posY - lastpos) <= adat.textsize) then
      self:MoveFrameDown(adat.frame, adat.textsize, adat.sidedir)
    end
    adat.addY = -1*db["MOVEMENT"]
  end
  if (adat.anitype == 7) then
    adat.posX = CalculateCircleCordX(adat)
  else
    adat.posX = CalculateAngleCordX(adat)
  end
end

----------------------
--Do HUD Curved Animation
function SCT:HUDCurvedAnimation(adat)
  local step = math_abs(adat.addY)
  local alphastep = 0.01 * step
  local max = (adat.toppoint - adat.bottompoint)/2
  adat.delay = adat.delay + 1
  if (adat.delay > (max/step)) then
    adat.alpha = math.max(0, adat.alpha - alphastep)
  end
  adat.posY = adat.posY + adat.addY
  adat.posX = CalculateCircleCordX(adat)
end

----------------------
--Do HUD Angled Animation
function SCT:HUDAngledAnimation(adat)
  local step = math_abs(adat.addY)
  local alphastep = 0.01 * step
  local max = (adat.toppoint - adat.bottompoint)/2
  adat.delay = adat.delay + 1
  if (adat.delay > (max/step)) then
    adat.alpha = math.max(0, adat.alpha - alphastep)
  end
  adat.posY = adat.posY + adat.addY
  adat.posX = CalculateAngleCordX(adat)
end

----------------------
--Initialize Icon
function SCT:IconInit(adat, icon)
  --create icon if none
  if not adat.icon then
    adat.icon = SCT_ANIMATION_FRAME:CreateTexture(nil, "ARTWORK")
    adat.icon:ClearAllPoints()
    adat.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
  end
  --adjust/fix alignment HUD alignments
  if (adat.iconside == 3) then
    adat.iconside = -adat.sidedir
  elseif (adat.iconside == 4) then
    adat.iconside = adat.sidedir
  end
  if adat.iconside == 1 then
    adat.icon:SetPoint("RIGHT",adat,"LEFT", -adat.textsize / 4, 0)
  else
    adat.icon:SetPoint("LEFT",adat,"RIGHT", adat.textsize / 4, 0)
  end
  adat.icon:SetHeight(adat.textsize)
  adat.icon:SetWidth(adat.textsize)
  adat.icon:SetTexture(icon)
  adat.icon:SetAlpha(adat.alpha)
end

----------------------
--set Y pos by finding what crits spots are available
function SCT:GetNextCritLoc(adat)
  local randomposy, critspot = 0,-1
  local array = self.ArrayAniCritData[adat.frame]
  for i = 0, sct_CRIT_MAX_COUNT do
    if array[i] ~= true then
      array[i] = true
      critspot = i
      break
    end
  end
  --if none availble, get overflow
  if (critspot == -1) then
    critspot = array.Overflow or 0
    array.Overflow = math_fmod(critspot + 1,sct_CRIT_MAX_COUNT)
  end
  --set pos
  randomposy = math_ceil(critspot/2)
  if (math_fmod(critspot,2) == 0) then
    randomposy = randomposy * -1
  end
  return randomposy
end

----------------------
--see if a skill notification is already being shown
function SCT:CheckSkill(skill)
  local i, key, value
  for i = 1, #self.ArrayAniData do
    for key, value in pairs(self.ArrayAniData[i]) do
      if (value:GetText() == skill) and (value:IsShown()) then
        return true
      end
    end
  end
  return false
end

----------------------
--move all animations up
function SCT:MoveFrameUp(frame, textsize, sidedir)
  for key, value in pairs(self.ArrayAniData[frame]) do
    if (value:IsShown() and value.addY ~= 0 and value.sidedir == sidedir) then
      value.delay = value.delay + math_ceil(value.textsize/math_abs(value.addY))
      value.posY = value.posY + textsize
    end
  end
end

----------------------
--move all animations up
function SCT:MoveFrameDown(frame, textsize, sidedir)
  for key, value in pairs(self.ArrayAniData[frame]) do
    if (value:IsShown() and value.addY ~= 0 and value.sidedir == sidedir) then
      value.delay = value.delay + math_ceil(value.textsize/math_abs(value.addY))
      value.posY = value.posY - textsize
    end
  end
end

----------------------
--get the min current min point
function SCT:MinPoint(adat, offset, anitype, sidedir)
  local posY, key, value
  if (not adat.direction) then
    posY = adat.offsetY + sct_MAX_DISTANCE - offset
    for key, value in pairs(self.ArrayAniData[adat.frame]) do
      if ((value:IsShown()) and (value.posY < posY) and (value.anitype == anitype) and (not value.crit) and (value.sidedir == sidedir)) then
        posY = value.posY
      end
    end
  else
    posY = adat.offsetY + offset
    for key, value in pairs(self.ArrayAniData[adat.frame]) do
      if ((value:IsShown()) and (value.posY > posY) and (value.anitype == anitype) and (not value.crit) and (value.sidedir == sidedir)) then
        posY = value.posY
      end
    end
  end
  return posY
end

-------------------------
--gets the next available animation object
--can be used by SCT addons since public
function SCT:GetNextAniObj(frame)
  local adat, i
  local anyAvail = false
  --get first now shown
  for i=1, sct_TEXTCOUNT do
    adat = arrFrameTexts[i]
    if ( not adat:IsShown() ) then
      anyAvail = true
      break
    end
  end
  --if none availble, get oldest
  if (not anyAvail) then
    for i = 1, #self.ArrayAniData do
      adat = self.ArrayAniData[i][1]
      if (adat) then break end
    end
    self:AniReset(adat)
  end
  --set defaults based on frame
  adat.frame = frame
  adat.posY = db[self.FRAMES_DATA_TABLE][frame]["YOFFSET"]
  adat.posX = db[self.FRAMES_DATA_TABLE][frame]["XOFFSET"]
  adat.offsetY = db[self.FRAMES_DATA_TABLE][frame]["YOFFSET"]
  adat.offsetX = db[self.FRAMES_DATA_TABLE][frame]["XOFFSET"]
  adat.gap = db[self.FRAMES_DATA_TABLE][frame]["GAPDIST"]
  adat.align = db[self.FRAMES_DATA_TABLE][frame]["ALIGN"]
  adat.bottompoint = adat.posY
  adat.toppoint = adat.posY + sct_MAX_DISTANCE
  adat.randomposy = nil
  adat.font = db[self.FRAMES_DATA_TABLE][frame]["FONT"]
  adat.fontshadow = db[self.FRAMES_DATA_TABLE][frame]["FONTSHADOW"]
  adat.textsize = db[self.FRAMES_DATA_TABLE][frame]["TEXTSIZE"]
  adat.alpha = db[self.FRAMES_DATA_TABLE][frame]["ALPHA"]/100
  adat.anitype = db[self.FRAMES_DATA_TABLE][frame]["ANITYPE"]
  adat.anisidetype = db[self.FRAMES_DATA_TABLE][frame]["ANISIDETYPE"]
  adat.direction = db[self.FRAMES_DATA_TABLE][frame]["DIRECTION"]
  adat.sidedir = db[self.FRAMES_DATA_TABLE][frame]["ANISIDETYPE"]
  adat.iconside = db[self.FRAMES_DATA_TABLE][frame]["ICONSIDE"]
  adat.anim = nil
  adat.init = nil
  return adat
end

----------------------
--Rest the text animation
function SCT:AniReset(adat)
  local i, key, value
  --remove it from display table
  for i = 1, #self.ArrayAniData do
    for key, value in pairs(self.ArrayAniData[i]) do
      if ( value == adat ) then
        tremove(self.ArrayAniData[i], key)
        break
      end
    end
  end
  --reset random crit spot
  if adat.frame and adat.randomposy ~= nil then
    adat.randomposy = adat.randomposy * 2
    if adat.randomposy > 0 then
      adat.randomposy = adat.randomposy - 1
    end
    self.ArrayAniCritData[adat.frame][math_abs(adat.randomposy)] = false
  end
  --reset all setings
  adat.crit = false
  adat.critsize = nil
  adat.posY = 0
  adat.posX = 0
  adat.addY = 0
  adat.addX = 0
  adat.alpha = 0
  adat.lastupdate = 0
  adat.delay = 0
  adat.align = 2
  adat:SetAlpha(adat.alpha)
  adat:Hide()
  adat:ClearAllPoints()
  if adat.icon then
    adat.icon:ClearAllPoints()
    adat.icon:SetTexture(nil)
  end
end

----------------------
--Rest all the text animations
function SCT:AniResetAll()
  for i=1, sct_TEXTCOUNT do
    self:AniReset(arrFrameTexts[i])
  end
end

------------------------
--Initial animation settings
function SCT:AniInit()
  --local the profile table
  db = self.db.profile
  --setup all animations
  animations = {
    [1] = {
      init = self.VerticalInit,
      anim = self.VerticalAnimation,
    },
    [2] = {
      init = self.RainbowInit,
      anim = self.RainbowAnimation,
    },
    [3] = {
      init = self.HorizontalInit,
      anim = self.HorizontalAnimation,
    },
    [4] = {
      init = self.AngledDownInit,
      anim = self.AngledDownAnimation,
    },
    [5] = {
      init = self.AngledUpInit,
      anim = self.AngledUpAnimation,
    },
    [6] = {
      init = self.SprinklerInit,
      anim = self.SprinklerAnimation,
    },
    [7] = {
      init = self.HUDInit,
      anim = self.HUDCurvedAnimation,
    },
    [8] = {
      init = self.HUDInit,
      anim = self.HUDAngledAnimation,
    },
  }
  --setup all animation objects
  self:AniResetAll()
  self:SetMsgFont(SCT_MSG_FRAME)
  --reset size of allow 3 messages
  SCT_MSG_FRAME:SetHeight(db[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGSIZE"] * 4)
  --Set Fade Duration
  SCT_MSG_FRAME:SetFadeDuration(1)
  --Set Position
  SCT_MSG_FRAME:SetPoint("CENTER", "UIParent", "CENTER",
                         db[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGXOFFSET"],
                         db[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGYOFFSET"])
  SCT_MSG_FRAME:SetTimeVisible(db[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGFADE"])
  self:SetDmgFont()
end

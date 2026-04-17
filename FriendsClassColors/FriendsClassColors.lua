local LMale, LFemale = LOCALIZED_CLASS_NAMES_MALE or {}, LOCALIZED_CLASS_NAMES_FEMALE or {}
local LOCAL2TOKEN = {}
for token, name in pairs(LMale)   do LOCAL2TOKEN[name] = token end
for token, name in pairs(LFemale) do LOCAL2TOKEN[name] = token end

local function tokenFromLocalized(loc) return loc and LOCAL2TOKEN[loc] end
local function rgbhex(c) return ("|cff%02x%02x%02x"):format((c.r or 1)*255, (c.g or 1)*255, (c.b or 1)*255) end
local function stripColors(s) return (s or ""):gsub("|c%x%x%x%x%x%x%x%x",""):gsub("|r","") end
local function stripLinks(s)  return (s or ""):gsub("|H.-|h",""):gsub("|h","") end

local function colorParensOnly(fontString, classToken)
  local c = classToken and RAID_CLASS_COLORS[classToken]; if not (fontString and c) then return end
  local txt = fontString:GetText() or ""
  txt = stripLinks(stripColors(txt))
  local l, r = txt:find("%b()")
  if not (l and r) then fontString:SetText(rgbhex(c)..txt.."|r"); return end
  local inner = txt:sub(l+1, r-1)
  fontString:SetText(txt:sub(1, l) .. rgbhex(c) .. inner .. "|r" .. txt:sub(r))
end

local function colorWhole(fontString, classToken)
  local c = classToken and RAID_CLASS_COLORS[classToken]; if not (fontString and c) then return end
  fontString:SetText(rgbhex(c)..(fontString:GetText() or "").."|r")
end

local function recolorButton(btn)
  if not (btn and btn.buttonType and btn.name) then return end

  if btn.buttonType == FRIENDS_BUTTON_TYPE_WOW then
    if C_FriendList and C_FriendList.GetFriendInfoByIndex then
      local info = C_FriendList.GetFriendInfoByIndex(btn.id)
      if info and info.connected then
        colorWhole(btn.name, tokenFromLocalized(info.className))
      end
    elseif GetFriendInfo then
      local _, _, classLoc, _, connected = GetFriendInfo(btn.id)
      if connected then colorWhole(btn.name, tokenFromLocalized(classLoc)) end
    end

  elseif btn.buttonType == FRIENDS_BUTTON_TYPE_BNET then
    local token
    if C_BattleNet and C_BattleNet.GetFriendAccountInfo then
      local acc = C_BattleNet.GetFriendAccountInfo(btn.id)
      local ga  = acc and acc.gameAccountInfo
      if ga and ga.clientProgram == "WoW" then
        token = tokenFromLocalized(ga.className)
      end
    elseif BNGetFriendInfo then
      local _, _, _, _, _, toonID, client = BNGetFriendInfo(btn.id)
      if toonID and client == "WoW" and BNGetToonInfo then
        local info = { BNGetToonInfo(toonID) }
        for i=1,#info do local t = tokenFromLocalized(info[i]); if t then token = t; break end end
      end
    end
    if token then colorParensOnly(btn.name, token) end
  end
end

hooksecurefunc("FriendsFrame_UpdateFriendButton", recolorButton)

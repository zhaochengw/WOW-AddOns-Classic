
-- --------------------------
-- Improved Loot Frame
-- By Cybeloras of Detheroc/Mal'Ganis
-- --------------------------

local LovelyLootLoaded = IsAddOnLoaded("LovelyLoot")

-- LOOTFRAME_AUTOLOOT_DELAY = 0.5;
-- LOOTFRAME_AUTOLOOT_RATE = 0.1;

if not LovelyLootLoaded then

	-- Woah, nice coding, blizz.
	-- Anchor something positioned at the top of the frame to the center of the frame instead,
	-- and make it an anonymous font string so I have to work to find it
	local i = 1

	while true do
		local r = select(i, LootFrame:GetRegions())
		if not r then break end
		if r.GetText and r:GetText() == ITEMS then
			r:ClearAllPoints()
			r:SetPoint("TOP", 12, -5)
		end
		i = i + 1
	end
end

-- Calculate base height of the loot frame
local p, r, x, y = "TOP", "BOTTOM", 0, -4
local buttonHeight = LootButton1:GetHeight() + abs(y)
local baseHeight = LootFrame:GetHeight() - (buttonHeight * LOOTFRAME_NUMBUTTONS)
if not LovelyLootLoaded then
	baseHeight = baseHeight - 5
end

LootFrame.OverflowText = LootFrame:CreateFontString(nil, "OVERLAY", "GameFontRedSmall")
local OverflowText = LootFrame.OverflowText

OverflowText:SetPoint("TOP", LootFrame, "TOP", 0, -26)
OverflowText:SetPoint("LEFT", LootFrame, "LEFT", 60, 0)
OverflowText:SetPoint("RIGHT", LootFrame, "RIGHT", -8, 0)
OverflowText:SetPoint("BOTTOM", LootFrame, "TOP", 0, -65)

if LovelyLootLoaded then
	OverflowText:SetPoint("LEFT", LootFrame, "RIGHT", 10, 0)
	OverflowText:SetPoint("RIGHT", LootFrame, "RIGHT", -10 + LootFrame:GetWidth(), 0)
end

OverflowText:SetSize(1, 1)
OverflowText:SetJustifyH("LEFT")
OverflowText:SetJustifyV("TOP")
OverflowText:SetText("Hit 50-mob limit! Take some, then re-loot for more.")
OverflowText:Hide()

local t = {}
local function CalculateNumMobsLooted()
	wipe(t)

	for i = 1, GetNumLootItems() do
		for n = 1, select("#", GetLootSourceInfo(i)), 2 do
			local GUID, num = select(n, GetLootSourceInfo(i))
			t[GUID] = true
		end
	end

	local n = 0
	for k, v in pairs(t) do
		n = n + 1
	end

	return n
end

hooksecurefunc("LootFrame_Show", function(self, ...)
	local maxButtons = floor(UIParent:GetHeight()/LootButton1:GetHeight() * 0.7)
	
	local num = GetNumLootItems()

	if self.AutoLootTable then
		num = #self.AutoLootTable
	end

	self.AutoLootDelay = 0.4 + (num * 0.05)
	
	num = min(num, maxButtons)
	
	LootFrame:SetHeight(baseHeight + (num * buttonHeight))
	for i = 1, num do
		if i > LOOTFRAME_NUMBUTTONS then
			local button = _G["LootButton"..i]
			if not button then
				button = CreateFrame(ItemButtonMixin and "ItemButton" or "Button", "LootButton"..i, LootFrame, "LootButtonTemplate", i, BackdropTemplateMixin and "BackdropTemplate")
			end
			LOOTFRAME_NUMBUTTONS = i
		end
		if i > 1 then
			local button = _G["LootButton"..i]
			button:ClearAllPoints()
			button:SetPoint(p, "LootButton"..(i-1), r, x, y)
		end
	end

	if CalculateNumMobsLooted() >= 50 then
		OverflowText:Show()
	else
		OverflowText:Hide()
	end
	
	LootFrame_Update();
end)

MasterLooterFrame:HookScript("OnShow", function(self)
		--local color = DB.QualityColors[LootFrame.selectedQuality or 1]
		--self.Item.bg:SetBackdropBorderColor(color.r, color.g, color.b)
		LootFrame:SetAlpha(.4)			
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", LootFrame.selectedLootButton, "BOTTOMLEFT", 0, 0)
		
end)
MasterLooterFrame:HookScript("OnHide", function()
		LootFrame:SetAlpha(1)
end)


local chn = { "say", "party", "guild", "raid"}
local chnc = {
	{1, 1, 1, .7},
	{.1, .5, .7, .7},
	{0, .8, 0, .7},
	{.85, .2, .1, .7},
}
local pos = {
{"TOPRIGHT", LootFrame, "TOP", 0, -35},
{"TOPRIGHT", LootFrame, "TOP", 24, -35},
{"TOPLEFT", LootFrame, "TOP", 26, -35},
{"TOPLEFT", LootFrame, "TOP", 50, -35},
}
local config = {
	font = { "FONTS\\ARIALN.ttf", 14, "OUTLINE" }, --普通字体
	bigfont = { "FONTS\\ARIALN.ttf", 18, "OUTLINE" },  --标题字体
	iconsize = 32, --图标大小
	framescale = 1, --缩放
	point = { "CENTER", },  --坐标
	bcolor = { r = 0, g = 0, b = 0, a = 1 },  --边框颜色
	bdcolor = { r = 0, g = 0, b = 0, a = 0.75 }, --背景颜色
}

local function CreateBackdropBorder(f)
	f:SetBackdrop({
		edgeFile = "Interface\\Addons\\ImprovedLootFrame\\TGA\\blank", 
		edgeSize = 1,
		insets = { left = 1, right = 1, top = 1, bottom = 1 }
	})
	f:SetBackdropBorderColor(config.bcolor.r, config.bcolor.g, config.bcolor.b, config.bcolor.a)
end

local function CreateShadow(f, b, a)
	if f.shadow then return end
	f:SetFrameLevel(f:GetFrameLevel()+1)
	local a = ( b and a or config.bdcolor.a ) or 0
	local shadow = CreateFrame("Frame", nil, f, BackdropTemplateMixin and "BackdropTemplate")
	shadow:SetPoint("TOPLEFT", -4, 4)
	shadow:SetPoint("BOTTOMRIGHT", 4, -4)
	shadow:SetFrameLevel(f:GetFrameLevel()-1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetBackdrop( { 
		bgFile =   "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\Addons\\ImprovedLootFrame\\TGA\\Shadow",
		edgeSize = 4,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	shadow:SetBackdropColor(config.bdcolor.r, config.bdcolor.g, config.bdcolor.b, a)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end

local function SetTemplate(f, b, a)
	CreateBackdropBorder(f)
	CreateShadow(f, b, a)
end

local function Announce(chn)
		local nums = GetNumLootItems()
		if(nums == 0) then return end
		if UnitIsPlayer("target") or not UnitExists("target") then -- Chests are hard to identify!
			SendChatMessage(format("*** %s ***", "箱子中的战利品"), chn)
		else
			SendChatMessage(format("*** %s%s ***", UnitName("target"), "的战利品"), chn)
		end
		for i = 1, GetNumLootItems() do
			local link
			if(LootSlotHasItem(i)) then     --判断，只发送物品
				link = GetLootSlotLink(i)
			else
				_, link = GetLootSlotInfo(i)
			end
			if link then
				local messlink = "- %s"
				SendChatMessage(format(messlink, link), chn)
			end
		end
	end

local AnnounceButton = {}
for i = 1, #chn do
	AnnounceButton[i] = CreateFrame("Button", "AnnounceButton"..i, LootFrame, BackdropTemplateMixin and "BackdropTemplate")
	AnnounceButton[i]:SetSize(22, 14)
	AnnounceButton[i]:SetPoint(unpack(pos[i]))
	AnnounceButton[i]:SetScript("OnClick", function() Announce(chn[i]) end)
	AnnounceButton[i]:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 5)
			GameTooltip:ClearLines()
			GameTooltip:AddLine("通报到".._G[chn[i]:upper()])
			GameTooltip:Show()
		end)
	AnnounceButton[i]:SetScript("OnLeave", GameTooltip_Hide)
    SetTemplate(AnnounceButton[i], true)
	AnnounceButton[i].shadow:SetBackdropColor(unpack(chnc[i]))
end



-- It seems the the taint is no longer an issue, so this code has been commented out.

-- the following is inspired by http://us.battle.net/wow/en/forum/topic/2353268564 and is hacktastic
-- local framesRegistered = {}
-- local function populateframesRegistered(...)
-- 	wipe(framesRegistered)
-- 	for i = 1, select("#", ...) do
-- 		framesRegistered[i] = select(i, ...)
-- 	end
-- end

-- local old_LootButton_OnClick = LootButton_OnClick
-- function LootButton_OnClick(self, ...)
-- 	populateframesRegistered(GetFramesRegisteredForEvent("ADDON_ACTION_BLOCKED"))
	
-- 	-- Blizzard throws a false taint error when attemping to loot
-- 	-- coins from a mob when the coins are the only loot on the mob
-- 	for i, frame in pairs(framesRegistered) do
-- 		frame:UnregisterEvent("ADDON_ACTION_BLOCKED") 
-- 	end
	
-- 	old_LootButton_OnClick(self, ...)
	
-- 	for i, frame in pairs(framesRegistered) do
-- 		frame:RegisterEvent("ADDON_ACTION_BLOCKED")
-- 	end
-- end

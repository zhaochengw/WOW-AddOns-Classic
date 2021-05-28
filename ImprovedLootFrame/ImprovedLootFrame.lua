
-- --------------------------
-- Improved Loot Frame
-- By Cybeloras of Detheroc/Mal'Ganis
-- --------------------------

local LovelyLootLoaded = IsAddOnLoaded("LovelyLoot")

local wow_classic = WOW_PROJECT_ID and WOW_PROJECT_ID == WOW_PROJECT_CLASSIC

-- LOOTFRAME_AUTOLOOT_DELAY = 0.5
-- LOOTFRAME_AUTOLOOT_RATE = 0.1

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
	if ImprovedLootFrameDB["oneloot"] == 1 then
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
					button = CreateFrame(wow_classic and "Button" or "ItemButton", "LootButton"..i, LootFrame, "LootButtonTemplate", i)
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
		
		LootFrame_Update()
	end
end)

local chn = { "say", "party", "guild", "raid"}
local chnc = {
	{1, 1, 1, .7},
	{.1, .5, .7, .7},
	{0, .8, 0, .7},
	{.85, .2, .1, .7},
}
local pos = {
	{"TOPRIGHT", LootFrame, "BOTTOM", -40, -8},
	{"TOPRIGHT", LootFrame, "BOTTOM", -6, -8},
	{"TOPLEFT", LootFrame, "BOTTOM", 6, -8},
	{"TOPLEFT", LootFrame, "BOTTOM", 40, -8},
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
		edgeFile = "Interface\\Addons\\ImprovedLootFrame\\Media\\blank", 
		edgeSize = 1,
		insets = { left = 1, right = 1, top = 1, bottom = 1 }
	})
	f:SetBackdropBorderColor(config.bcolor.r, config.bcolor.g, config.bcolor.b, config.bcolor.a)
end

local function CreateShadow(f, b, a)
	if f.shadow then return end
	f:SetFrameLevel(f:GetFrameLevel()+1)
	local a = ( b and a or config.bdcolor.a ) or 0
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetPoint("TOPLEFT", -4, 4)
	shadow:SetPoint("BOTTOMRIGHT", 4, -4)
	shadow:SetFrameLevel(f:GetFrameLevel()-1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetBackdrop( { 
		-- bgFile =   "Interface\\Buttons\\WHITE8x8",
		bgFile =   "Interface\\TargetingFrame\\UI-StatusBar",
		edgeFile = "Interface\\Addons\\ImprovedLootFrame\\Media\\Shadow",
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

local lootsourcename = ""
hooksecurefunc("LootFrame_Show", function(self, ...)
	local targetguid = UnitExists("target") and UnitGUID("target") or 0
	local sourceguid = GetLootSourceInfo(1) or 1
	if targetguid == sourceguid then
		lootsourcename = UnitName("target")
	else
		lootsourcename = ""
	end
end)

local function Announce(chn)
	local nums = GetNumLootItems()
	if (nums == 0) then return end
	if (nums == 1 and GetLootSlotType(1) == 2 and ImprovedLootFrameDB["coin"] ~= 1) then return end

	if lootsourcename == "" then
		SendChatMessage("*** "..LOOT.." ***", chn)
	else
		SendChatMessage("*** "..format(TEXT_MODE_A_STRING_POSSESSIVE, lootsourcename)..LOOT.." ***", chn)
	end

	local link
	for i = 1, GetNumLootItems() do
		local _, lootName, lootQuantity, _, lootQuality = GetLootSlotInfo(i)
		if lootName then
			link = GetLootSlotLink(i)
			if link then
				local quantity = ""
				local _, _, _, _, _, _, _, itemStackCount = GetItemInfo(link)
				if itemStackCount > 1 then
					quantity = " × "..lootQuantity
				end
				if lootQuality > 3 or ImprovedLootFrameDB["filter"] == 0 then
					SendChatMessage("+ "..link..quantity, chn)
				end
			elseif GetLootSlotType(i) == 2 then
				if ImprovedLootFrameDB["coin"] == 1 then
					SendChatMessage("+ "..string.gsub(lootName, "\n", ""), chn)
				end
			end
		end
	end
end

local AnnounceButton = {}
for i = 1, #chn do
	AnnounceButton[i] = CreateFrame("Button", "AnnounceButton"..i, LootFrame)
	AnnounceButton[i]:SetSize(22, 14)
	AnnounceButton[i]:SetPoint(unpack(pos[i]))
	AnnounceButton[i]:SetScript("OnClick", function() Announce(chn[i]) end)
	AnnounceButton[i]:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 5)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(format(BATTLE_PET_VARIANCE_STR, BATTLENET_BROADCAST, _G[chn[i]:upper()]))
		GameTooltip:Show()
	end)
	AnnounceButton[i]:SetScript("OnLeave", GameTooltip_Hide)
	SetTemplate(AnnounceButton[i], true)
	AnnounceButton[i].shadow:SetBackdropColor(unpack(chnc[i]))
end

function ImprovedLootFrame_Announce()
	if ImprovedLootFrameDB["announce"] == 1 then
		for i = 1, #chn do
			AnnounceButton[i]:Show()
		end
	else
		for i = 1, #chn do
			AnnounceButton[i]:Hide()
		end
	end
end

function ImprovedLootFrame_Options_Init()
	if not ImprovedLootFrameDB then ImprovedLootFrameDB = {} end
	if not ImprovedLootFrameDB["oneloot"] then ImprovedLootFrameDB["oneloot"] = 1 end
	if not ImprovedLootFrameDB["announce"] then ImprovedLootFrameDB["announce"] = 1 end
	if not ImprovedLootFrameDB["coin"] then ImprovedLootFrameDB["coin"] = 0 end
	if not ImprovedLootFrameDB["filter"] then ImprovedLootFrameDB["filter"] = 0 end
end

local ilf = CreateFrame("Frame");
ilf:RegisterEvent("ADDON_LOADED");
ilf:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		ImprovedLootFrame_Options_Init();
		ImprovedLootFrame_Announce();
		ImprovedLootFrame_OptionPanel_OnShow();
		ilf:UnregisterEvent("ADDON_LOADED");
	end
end)

if GetLocale() == "zhCN" then
	ImprovedLootFrameOPT_Oneloot  = "启用单页拾取";
	ImprovedLootFrameOPT_Announce = "显示掉落通报按钮";
	ImprovedLootFrameOPT_Coins    = "通报金币";
	ImprovedLootFrameOPT_Filter   = "仅通报史诗及以上";
elseif GetLocale() == "zhTW" then
	ImprovedLootFrameOPT_Oneloot  = "启用单页拾取";
	ImprovedLootFrameOPT_Announce = "显示掉落通报按钮";
	ImprovedLootFrameOPT_Coins    = "通报金币";
	ImprovedLootFrameOPT_Filter   = "僅通報史詩及以上";
else
	ImprovedLootFrameOPT_Oneloot  = "Enable one page loot frame";
	ImprovedLootFrameOPT_Announce = "Show loot announce button";
	ImprovedLootFrameOPT_Coins    = "Announce coins";
	ImprovedLootFrameOPT_Filter   = "Announce epic and above only";
end

--option panel
ImprovedLootFrame_OptionsFrame = CreateFrame("Frame", "ImprovedLootFrame_OptionsFrame", UIParent);
ImprovedLootFrame_OptionsFrame.name = "ImprovedLootFrame";
InterfaceOptions_AddCategory(ImprovedLootFrame_OptionsFrame);
ImprovedLootFrame_OptionsFrame:SetScript("OnShow", function()
	ImprovedLootFrame_OptionPanel_OnShow();
end)

do
	local ImprovedLootFrameTitle = ImprovedLootFrame_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	ImprovedLootFrameTitle:ClearAllPoints();
	ImprovedLootFrameTitle:SetPoint("TOPLEFT", 16, -16);
	ImprovedLootFrameTitle:SetText(SETTINGS);

	local ImprovedLootFrameOneloot = CreateFrame("CheckButton", "ImprovedLootFrameOneloot", ImprovedLootFrame_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	ImprovedLootFrameOneloot:ClearAllPoints();
	ImprovedLootFrameOneloot:SetPoint("TOPLEFT", ImprovedLootFrameTitle, "TOPLEFT", 0, -40);
	ImprovedLootFrameOneloot:SetHitRectInsets(0, -100, 0, 0);
	ImprovedLootFrameOnelootText:SetText(ImprovedLootFrameOPT_Oneloot);
	ImprovedLootFrameOneloot:SetScript("OnClick", function(self)
		ImprovedLootFrameDB["oneloot"] = 1 - ImprovedLootFrameDB["oneloot"];
		if ImprovedLootFrameDB["oneloot"] == 0 then
			LootFrame:SetHeight(240);

			LOOTFRAME_NUMBUTTONS = 4;

			local id = 4;
			while true do
				id = id + 1;
				if _G["LootButton"..id] then 
					_G["LootButton"..id]:Hide();
				else
					break;
				end
			end

			LootButton1:ClearAllPoints();
			LootButton1:SetPoint("TOPLEFT", "LootFrame", "TOPLEFT", 9, -68);
			LootButton2:ClearAllPoints();
			LootButton2:SetPoint("TOPLEFT", "LootFrame", "TOPLEFT", 9, -109);
			LootButton3:ClearAllPoints();
			LootButton3:SetPoint("TOPLEFT", "LootFrame", "TOPLEFT", 9, -150);
			LootButton4:ClearAllPoints();
			LootButton4:SetPoint("TOPLEFT", "LootFrame", "TOPLEFT", 9, -193);
		end
		self:SetChecked(ImprovedLootFrameDB["oneloot"]==1);
	end)

	local ImprovedLootFrameAnnounce = CreateFrame("CheckButton", "ImprovedLootFrameAnnounce", ImprovedLootFrame_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	ImprovedLootFrameAnnounce:ClearAllPoints();
	ImprovedLootFrameAnnounce:SetPoint("TOPLEFT", ImprovedLootFrameOneloot, "TOPLEFT", 0, -30);
	ImprovedLootFrameAnnounce:SetHitRectInsets(0, -100, 0, 0);
	ImprovedLootFrameAnnounceText:SetText(ImprovedLootFrameOPT_Announce);
	ImprovedLootFrameAnnounce:SetScript("OnClick", function(self)
		ImprovedLootFrameDB["announce"] = 1 - ImprovedLootFrameDB["announce"];
		ImprovedLootFrame_Announce();
		self:SetChecked(ImprovedLootFrameDB["announce"]==1);
	end)

	local ImprovedLootFrameCoins = CreateFrame("CheckButton", "ImprovedLootFrameCoins", ImprovedLootFrame_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	ImprovedLootFrameCoins:ClearAllPoints();
	ImprovedLootFrameCoins:SetPoint("TOPLEFT", ImprovedLootFrameAnnounce, "TOPLEFT", 0, -30);
	ImprovedLootFrameCoins:SetHitRectInsets(0, -100, 0, 0);
	ImprovedLootFrameCoinsText:SetText(ImprovedLootFrameOPT_Coins);
	ImprovedLootFrameCoins:SetScript("OnClick", function(self)
		ImprovedLootFrameDB["coin"] = 1 - ImprovedLootFrameDB["coin"];
		self:SetChecked(ImprovedLootFrameDB["coin"]==1);
	end)

	local ImprovedLootFrameFilter = CreateFrame("CheckButton", "ImprovedLootFrameFilter", ImprovedLootFrame_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
	ImprovedLootFrameFilter:ClearAllPoints();
	ImprovedLootFrameFilter:SetPoint("TOPLEFT", ImprovedLootFrameCoins, "TOPLEFT", 0, -30);
	ImprovedLootFrameFilter:SetHitRectInsets(0, -100, 0, 0);
	ImprovedLootFrameFilterText:SetText(ImprovedLootFrameOPT_Filter);
	ImprovedLootFrameFilter:SetScript("OnClick", function(self)
		ImprovedLootFrameDB["filter"] = 1 - ImprovedLootFrameDB["filter"];
		self:SetChecked(ImprovedLootFrameDB["filter"]==1);
	end)
end

function ImprovedLootFrame_OptionPanel_OnShow()
	ImprovedLootFrameOneloot:SetChecked(ImprovedLootFrameDB["oneloot"]==1);
	ImprovedLootFrameAnnounce:SetChecked(ImprovedLootFrameDB["announce"]==1);
	ImprovedLootFrameCoins:SetChecked(ImprovedLootFrameDB["coin"]==1);
	ImprovedLootFrameFilter:SetChecked(ImprovedLootFrameDB["filter"]==1);
end

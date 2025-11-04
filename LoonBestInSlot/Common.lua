LBIS.ReCacheDate = time({year=2024, month=05, day=22, hour=00})
LBIS.SpellCache = {};

function LBIS:PreCacheItems()
    if LBIS.AllItemsCached then return LBIS.AllItemsCached; end

    LBIS.AllItemsCached = true;
    --If cache date is updated (because of cache changing) reset the cache
    if (not LBISServerSettings.LastCacheDate or LBISServerSettings.LastCacheDate < LBIS.ReCacheDate) then
        print("LBIS: Clearing Cache");
        LBISServerSettings.ItemCache = {};
        LBISServerSettings.LastCacheDate = time();
    end

    --If language is switched between logins, reset cache
    if (GetLocale() ~= LBISServerSettings.CurrentLocale) then
        LBISServerSettings.CurrentLocale = GetLocale();
        LBISServerSettings.ItemCache = {};
        LBISServerSettings.LastCacheDate = time();
    end

    for prioSpec in pairs(LBISServerSettings.CustomList) do
        for prioSlot in pairs(LBISServerSettings.CustomList[prioSpec]) do
            local itemCount = 1;

            LBIS:ConvertCustomList(LBISServerSettings.CustomList[prioSpec][prioSlot]);

            for _, item in pairs(LBISServerSettings.CustomList[prioSpec][prioSlot]) do

                if LBIS.CustomEditList.Items[item.ItemId] == nil then
                    LBIS.CustomEditList.Items[item.ItemId] = {};
                end

                LBIS.CustomEditList.Items[item.ItemId][prioSpec] = item;

                itemCount = itemCount + 1;
            end
        end
    end

    for itemId, _ in pairs(LBIS.ItemSources) do
        if itemId and itemId ~= 0 then
            LBIS:CacheItem(itemId);
        end
    end
    return LBIS.AllItemsCached;
end

--TODO: Remove this after a few months ?
function LBIS:ConvertCustomList(list)

    local itemCount = 1;
    --Loop through all items in list
    for _, item in pairs(list) do
        if type(item) == "number" then
            local itemId = item;
            item = { ItemId = itemId, TooltipText = "Custom #"..itemCount }
        end

        list[itemCount] = item;

        itemCount = itemCount + 1;
    end

end

function LBIS:CacheItem(itemId)
    LBIS:GetItemInfo(itemId, function(cacheItem)
        if not cacheItem or cacheItem.Name == nil then
            LBIS:ReCacheItem(itemId)
        end
    end);
end

function LBIS:ReCacheItem(itemId)
    LBIS:GetItemInfo(itemId, function(cacheItem)
        if not cacheItem or cacheItem.Name == nil then
            LBIS:Error("Failed to cache ("..itemId.."): ", cacheItem);
        end
    end);
end

function LBIS:GetPhaseNumbers(phaseText)
    local firstNumber, lastNumber = strsplit(">", phaseText);

    if firstNumber == nil then
        firstNumber = 0;
    end
    if lastNumber == nil then
        lastNumber = firstNumber;
    end

    return firstNumber, lastNumber;
end

function LBIS:FindInPhase(phaseText, phase)

    local phaseNumber = tonumber(phase);

    local firstNumber, lastNumber = LBIS:GetPhaseNumbers(phaseText);

    if firstNumber == nil then
        return false;
    end

    return tonumber(firstNumber) <= phaseNumber and tonumber(lastNumber) >= phaseNumber;
end

function LBIS:TableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local itemSlots = {};
itemSlots["INVTYPE_NON_EQUIP"] = LBIS.L["None"];
itemSlots["INVTYPE_HEAD"] = LBIS.L["Head"];
itemSlots["INVTYPE_NECK"] = LBIS.L["Neck"];
itemSlots["INVTYPE_SHOULDER"] = LBIS.L["Shoulder"];
itemSlots["INVTYPE_BODY"] = LBIS.L["Shirt"];
itemSlots["INVTYPE_CHEST"] = LBIS.L["Chest"];
itemSlots["INVTYPE_WAIST"] = LBIS.L["Waist"];
itemSlots["INVTYPE_LEGS"] = LBIS.L["Legs"];
itemSlots["INVTYPE_FEET"] = LBIS.L["Feet"];
itemSlots["INVTYPE_WRIST"] = LBIS.L["Wrist"];
itemSlots["INVTYPE_HAND"] = LBIS.L["Hands"];
itemSlots["INVTYPE_FINGER"] = LBIS.L["Ring"];
itemSlots["INVTYPE_TRINKET"] = LBIS.L["Trinket"];
itemSlots["INVTYPE_WEAPON"] = LBIS.L["Main Hand"].."/"..LBIS.L["Off Hand"];
itemSlots["INVTYPE_SHIELD"] = LBIS.L["Off Hand"];
itemSlots["INVTYPE_RANGED"] = LBIS.L["Ranged/Relic"];
itemSlots["INVTYPE_CLOAK"] = LBIS.L["Back"];
itemSlots["INVTYPE_BAG"] = LBIS.L["Bag"];
itemSlots["INVTYPE_TABARD"] = LBIS.L["Tabard"];
itemSlots["INVTYPE_ROBE"] = LBIS.L["Chest"];
itemSlots["INVTYPE_WEAPONMAINHAND"] = LBIS.L["Main Hand"];
itemSlots["INVTYPE_WEAPONOFFHAND"] = LBIS.L["Off Hand"];
itemSlots["INVTYPE_HOLDABLE"] = LBIS.L["Off Hand"];
itemSlots["INVTYPE_AMMO"] = LBIS.L["Ammo"];
itemSlots["INVTYPE_THROWN"] = LBIS.L["Ranged/Relic"];
itemSlots["INVTYPE_RANGEDRIGHT"] = LBIS.L["Ranged/Relic"];
itemSlots["INVTYPE_QUIVER"] = LBIS.L["Quiver"];
itemSlots["INVTYPE_RELIC"] = LBIS.L["Ranged/Relic"];
function LBIS:GetItemInfo(itemId, returnFunc)

    if itemId == nil or not itemId or itemId <= 0 then
        returnFunc({ Name = nil, Link = nil, Quality = nil, Type = nil, SubType = nil, Texture = nil, Class = nil, Slot = nil });
        return;
    end

    local cachedItem = LBISServerSettings.ItemCache[itemId];

    if cachedItem then
        returnFunc(cachedItem);
    else
        local itemCache = Item:CreateFromItemID(itemId)

        itemCache:ContinueOnItemLoad(function()
            local itemId, itemType, subType, itemSlot, _, classId = C_Item.GetItemInfoInstant(itemId);
            local name = itemCache:GetItemName();

            local newItem = {
                Id = itemId,
                Name = name,
                Link = itemCache:GetItemLink(),
                Quality = itemCache:GetItemQuality(),
                Type = itemType,
                SubType = subType,                
                Texture = itemCache:GetItemIcon(),
                Class = classId,
                Slot = itemSlots[itemSlot]
            };

            if name and LBIS.ItemSources[itemId] ~= nil then
                LBISServerSettings.ItemCache[itemId] = newItem;
            end

            returnFunc(newItem);
        end);
    end
end

function LBIS:GetSpellInfo(spellId, returnFunc)

    if not spellId or spellId <= 0 then
        returnFunc({ Name = nil, Link = nil, Quality = nil, Type = nil, SubType = nil, Texture = nil });
    end

    local cachedSpell = LBIS.SpellCache[spellId];

    if cachedSpell then
        returnFunc(cachedSpell);
    else
        local spellCache = Spell:CreateFromSpellID(spellId)

        spellCache:ContinueOnSpellLoad(function()
            local name = spellCache:GetSpellName();

            local newSpell = {
                Id = spellId,
                Name = name,
                SubText = spellCache:GetSpellSubtext(),
                Texture = C_Spell.GetSpellTexture(spellId)
            };

            if name then
                LBIS.SpellCache[spellId] = newSpell;
            end

            returnFunc(newSpell);
        end);
    end
end

local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
--- Opts:
---     name (string): Name of the dropdown (lowercase)
---     parent (Frame): Parent frame of the dropdown.
---     items (Table): String table of the dropdown options.
---     defaultVal (String): String value for the dropdown to default to (empty otherwise).
---     changeFunc (Function): A custom function to be called, after selecting a dropdown option.
function LBIS:CreateDropdown(opts, width)
    local dropdown_name = '$parent_' .. opts['name'] .. '_dropdown'
    local menu_items = opts['items'] or {}
    local title_text = opts['title'] or ''
    local default_val = opts['defaultVal'] or ''
    local change_func = opts['changeFunc'] or function (dropdown_frame, dropdown_val) end

---@diagnostic disable-next-line: undefined-field
    local dropdown = LibDD:Create_UIDropDownMenu(dropdown_name, opts['parent'])

---@diagnostic disable-next-line: undefined-field
    LibDD:UIDropDownMenu_Initialize(dropdown, function(self, level, _)
        ---@diagnostic disable-next-line: undefined-field
        local info = LibDD:UIDropDownMenu_CreateInfo()
        for key, val in pairs(menu_items) do
            info.text = val;
            info.checked = false
            info.isNotRadio = true;
            info.noClickSound = true
            info.func = function(b)
                ---@diagnostic disable-next-line: undefined-field
                LibDD:UIDropDownMenu_SetSelectedValue(dropdown, b.value, b.value)
                ---@diagnostic disable-next-line: undefined-field
                LibDD:UIDropDownMenu_SetText(dropdown, b.value)
                info.checked = true
                change_func(dropdown, b.value)
            end
            ---@diagnostic disable-next-line: undefined-field
            LibDD:UIDropDownMenu_AddButton(info)
        end
    end)

---@diagnostic disable-next-line: undefined-field
    LibDD:UIDropDownMenu_SetText(dropdown, default_val)
    ---@diagnostic disable-next-line: undefined-field
    LibDD:UIDropDownMenu_SetWidth(dropdown, width, 0)

    local dd_title = dropdown:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
    dd_title:SetText(title_text)
    dd_title:SetPoint("TOPLEFT", (-1 * dd_title:GetStringWidth()) + 20, -8)

    return dropdown
end

local itemIsOnEnter = nil;
function LBIS:SetTooltipOnButton(b, item, isSpell)

    b.ItemId = item.Id;
    b.ItemLink = item.Link;

    b.ShowTooltip = function ()
        GameTooltip:SetOwner(b, "ANCHOR_RIGHT");
        GameTooltip:SetItemByID(b.ItemId);
        GameTooltip:Show();
    end

    b.HideTooltip = function ()
        GameTooltip:Hide();
    end

    b:SetScript("OnClick", 
        function(self, button)
            if button == "LeftButton" then
                if isSpell then
                    HandleModifiedItemClick(GetSpellLink(b.ItemId));
                else
                    HandleModifiedItemClick(b.ItemLink);
                end
            end
        end
    );

    b:SetScript("OnEnter",
        function(self)
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            if isSpell == nil or isSpell == false then
                GameTooltip:SetItemByID(b.ItemId);
            else
                GameTooltip:SetSpellByID(b.ItemId);
            end
            GameTooltip:Show();
            itemIsOnEnter = GameTooltip;

            if IsShiftKeyDown() and itemIsOnEnter then
                GameTooltip_ShowCompareItem(GameTooltip)
            end
        end
    );

    b:SetScript("OnLeave", 
        function(self)
            itemIsOnEnter = nil;
            GameTooltip:SetOwner(UIParent, "ANCHOR_NONE");
            GameTooltip:Hide();
        end
    );
end

function LBIS:RegisterTooltip()
    LBIS:RegisterEvent("MODIFIER_STATE_CHANGED", function(key, down)
        if itemIsOnEnter then
            if IsShiftKeyDown() then
                GameTooltip_ShowCompareItem(itemIsOnEnter)
            else
                ShoppingTooltip1:Hide()
                ShoppingTooltip2:Hide()
            end
        end
    end);
end

function LBIS:spairs(t, order)

    -- collect the keys
    local keys = {}

    if t ~= nil then
        for k in pairs(t) do keys[#keys+1] = k end

        -- if order function given, sort by it by passing the table and keys a, b,
        -- otherwise just sort the keys 
        if order then
            table.sort(keys, function(a,b) return order(t, a, b) end)
        else
            table.sort(keys)
        end
    end
    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function LBIS:Dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. LBIS:Dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

local function stringify(object)
    local objectType = type(object);
    local debugString = "";

    if objectType == "table" then
        debugString = LBIS:Dump(object);
    elseif objectType == "number" or objectType == "boolean" then
        debugString = tostring(object);
    elseif objectType == "nil" then
        debugString = "nil";
    elseif objectType == "string" then
        debugString = object;
    else
        debugString = "Tried to debug an unknown type: "..objectType;
    end
    return debugString
end

function LBIS:Debug(startString, object)
    if LBIS.Debugging then
        print("LBIS:"..startString..stringify(object));
    end
end

function LBIS:Error(startString, object)
    if object == nil then
        print("LoonBestInSlot ERROR:"..startString);
    else
        print("LoonBestInSlot ERROR:"..startString..stringify(object));
    end
end

function LBIS:GetItemIdFromLink(itemLink)

    local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4,
    Suffix, Unique, LinkLvl, Name = string.find(itemLink,
    "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")

    return Id;
end

function LBIS:DeepCopy(src, dst)
	if type(src) ~= "table" then return {} end
	if type(dst) ~= "table" then dst = {} end
	for k, v in pairs(src) do
		if type(v) == "table" then
			dst[k] = LBIS:DeepCopy(v, dst[k])
		elseif type(v) ~= type(dst[k]) then
			dst[k] = v
		end
	end
	return dst
end


local function printItemSource(itemId, specItemSource, dl, printNumber, printLocation)

    local text = "";

    if printNumber == nil then
        printNumber = true;
    end
    if printLocation == nil then
        printLocation = true;
    end
    local sourceText = specItemSource.Source;
    local sourceNumberText = specItemSource.SourceNumber;
    local sourceLocationText = specItemSource.SourceLocation;

    local sourceText1, sourceText2, sourceText3 = strsplit("~", sourceText);
    local sourceNumberText1, sourceNumberText2, sourceNumberText3 = strsplit("~", sourceNumberText);
    local sourceLocationText1, sourceLocationText2, sourceLocationText3 = strsplit("~", sourceLocationText);

    local function printSourceText(sourceText, sourceNumberText, sourceLocationText, firstRow)
        if not firstRow then
            text = text.."\n"
        end

        local sourceSplit = { strsplit("&", sourceText) };
        local sourceNumberSplit = { strsplit("&", sourceNumberText) };

		local first = false;
        for index, source in pairs(sourceSplit) do		
			if first then
				text = text.." & ";
			else
				first = true;
			end
            text = text..strtrim(source);
			if sourceNumberSplit[index] ~= nil and printNumber then
				local trimNumber = strtrim(sourceNumberSplit[index]);
				if trimNumber ~= "" and trimNumber ~= "0" and trimNumber ~= "1" then
					text = text.." ("..trimNumber..")";
				end
			end
        end

        if sourceLocationText ~= nil and sourceLocationText ~= "" and printLocation then
            text = text.." - "..sourceLocationText;
        end
    end

    if sourceText1 ~= nil and sourceText1 ~= "" then
        printSourceText(sourceText1, sourceNumberText1, sourceLocationText1, true);
    end

    if sourceText2 ~= nil and sourceText2 ~= "" then
        printSourceText(sourceText2, sourceNumberText2, sourceLocationText2, false);       	
    end

    if sourceText3 ~= nil and sourceText3 ~= "" then
		printSourceText(sourceText3, sourceNumberText3, sourceLocationText3, false);
    end

    dl:SetText(text);
end

local function createSourceTypeText(specItemSource)

    local function getSourceColor(sourceType)
        if sourceType == LBIS.L["Profession"] then
            return "|cFF33ADFF";
        elseif sourceType == LBIS.L["Reputation"] then
            return "|cFF23E4C4";
        elseif sourceType == LBIS.L["Quest"] then
            return "|cFFFFEF27";
        elseif sourceType == LBIS.L["Dungeon Token"] then
            return "|cFFFF276D";
        elseif sourceType == LBIS.L["Tier Token"] then
            return "|cFFFC6A03";
        elseif sourceType == LBIS.L["Vendor"] then
            return "|cFF43DC00";
        elseif sourceType == LBIS.L["PvP"] then
            return "|cFFE52AED";
        elseif sourceType == LBIS.L["Drop"] then
            return "|cFF7727FF";
        else
            return "|cFFFFFFFF";
        end
    end

    local sourceType1, sourceType2 = strsplit("~", specItemSource.SourceType)    

    --Create Drop Text
    local dtColor = getSourceColor(sourceType1);
    local text = dtColor..sourceType1;

    if sourceType2 ~= nil then
        dtColor = getSourceColor(sourceType2);
        text = text.."|cFFFFD100/"..dtColor..sourceType2;
    end
	return text;
end

function LBIS.CreateItemRow(f, specItem, specItemSource)

    LBIS:GetItemInfo(specItem.Id, function(item)
        local window = LBIS.BrowserWindow.Window;

        if item == nil or item.Id == nil or item.Link == nil or item.Type == nil then
            LBIS:Error("Failed Load: "..specItem.Id);
        end
        --Create Item Button and Text

        local b = CreateFrame("Button", nil, f);
        b:SetSize(32, 32);
        local bt = b:CreateTexture();
        bt:SetAllPoints();
        bt:SetTexture(item.Texture);
        b:SetPoint("TOPLEFT", f, 2, -5);

        LBIS:SetTooltipOnButton(b, item);

        local t = f:CreateFontString(nil, nil, "GameFontNormal");
        t:SetText((item.Link or item.Name):gsub("[%[%]]", ""));
        t:SetPoint("TOPLEFT", b, "TOPRIGHT", 2, -2);

        local type = item.Type;
        if item.Subtype and item.Type ~= item.Subtype then
            type = item.Type .. ", " .. item.Subtype;
        end
        type = type.. ", "..specItem.Slot;
        local st = f:CreateFontString(nil, nil,"GameFontNormalSmall");
        st:SetTextColor(.6, .6, .6);
        st:SetText(type:gsub("~", "/"));
        st:SetPoint("BOTTOMLEFT", b, "BOTTOMRIGHT", 2, 2);

        local pt = f:CreateFontString(nil, nil, "GameFontNormal");
        if specItem.Phase == nil or specItem.Phase == "0" or specItem.Phase == "99" then
            pt:SetText("("..specItem.Bis..")");
        else
            pt:SetText("("..specItem.Bis.." "..string.gsub(specItem.Phase, "0", "PreRaid")..")");
        end
        pt:SetPoint("TOPLEFT", t, "TOPRIGHT", 4, 0);

		local d = f:CreateFontString(nil, nil, "GameFontNormal");
		d:SetText(createSourceTypeText(specItemSource));
		d:SetJustifyH("LEFT");
		d:SetWidth(window.ScrollFrame:GetWidth() / 2);
		d:SetPoint("TOPLEFT", (window.ScrollFrame:GetWidth() / 2), -5);

        local dl = f:CreateFontString(nil, nil, "GameFontNormalSmall");

        local function showSourceButton(item, item2, text, isSpell)
			
			local itemSize = 28;
			if item2 ~= nil then
				itemSize = 22;
			end
		
            local tb = CreateFrame("Button", nil, f);
            tb:SetSize(itemSize, itemSize);
            local bt = tb:CreateTexture();
            bt:SetAllPoints();
            bt:SetTexture(item.Texture);
            tb:SetPoint("TOPRIGHT", -40, -16);
            LBIS:SetTooltipOnButton(tb, item, isSpell);

            if item2 ~= nil then                
                local ft = f:CreateFontString(nil, nil, "GameFontNormalSmall")
                ft:SetText("+");
                ft:SetPoint("RIGHT", tb, "LEFT", -1, 0);

                local tb2 = CreateFrame("Button", nil, f);
                tb2:SetSize(itemSize, itemSize);
                local bt2 = tb2:CreateTexture();
                bt2:SetAllPoints();
                bt2:SetTexture(item2.Texture);
                tb2:SetPoint("RIGHT", ft, "LEFT", -1, 0);
                LBIS:SetTooltipOnButton(tb2, item2, isSpell);

                local ft2 = f:CreateFontString(nil, nil, "GameFontNormalSmall")
                ft2:SetText(text);
                ft2:SetPoint("BOTTOMLEFT", tb2, "TOPLEFT", 0, 3);
            else
                local ft = f:CreateFontString(nil, nil, "GameFontNormalSmall")
                ft:SetText(text);
                ft:SetPoint("BOTTOMLEFT", tb, "TOPLEFT", 0, 3);
            end
        end

        if specItemSource.SourceType == LBIS.L["Tier Token"] then
            local tokenNumber, tokenNumber2 = strsplit('~', specItemSource.SourceNumber);
            LBIS:GetItemInfo(tonumber(tokenNumber), function(tierToken)
                if tokenNumber2 ~= nil and tokenNumber2 ~= tokenNumber then
                    LBIS:GetItemInfo(tonumber(tokenNumber2), function(tierToken2)
                        showSourceButton(tierToken, tierToken2, "Token:", false);
                    end);
                else 
                    showSourceButton(tierToken, nil, "Token:", false);
                end
            end);
            printItemSource(specItem.Id, specItemSource, dl, false, true)
            dl:SetPoint("TOPLEFT", d, "BOTTOMLEFT", 0, -5);
        elseif specItemSource.SourceType == LBIS.L["Profession"] and tonumber(specItemSource.SourceLocation) ~= nil then
            LBIS:GetSpellInfo(tonumber(specItemSource.SourceLocation), function(professionSpell)
                showSourceButton(professionSpell, nil, "Skill:", true);
            end);
            printItemSource(specItem.Id, specItemSource, dl, false, false)
            dl:SetPoint("TOPLEFT", d, "BOTTOMLEFT", 0, -5);
        else
            printItemSource(specItem.Id, specItemSource, dl)
            dl:SetPoint("TOPLEFT", d, "BOTTOMLEFT", 0, -5);
        end
        dl:SetJustifyH("LEFT");

        local userItemCache = LBIS.UserItems[item.Id];
        if userItemCache then
            local ot = f:CreateTexture(nil,"BACKGROUND")
            ot:SetSize(24, 24);
            if userItemCache == "player" then
                ot:SetTexture("Interface/AddOns/LoonBestInSlot/Icons/checkmark.tga")
            elseif userItemCache == "bag" then
                ot:SetTexture("Interface/AddOns/LoonBestInSlot/Icons/bag.tga")
            elseif userItemCache == "bank" then
                ot:SetTexture("Interface/AddOns/LoonBestInSlot/Icons/bank.tga")
            end
            ot:SetPoint("TOPRIGHT", -2, -6);
        end
    end);

    -- even if we are reusing, it may not be in the same order
    local _, count = string.gsub(specItemSource.Source, "~", "")
    if count > 1 then
        count = count - 1;
    else 
        count = 0;
    end
    return (46 + (count * 10));
end

function LBIS:IsInZone(specItem)
    local zone, _ = gsub(gsub(specItem.SourceLocation, "%(25H%)", "(25)"), "%(10H%)", "(10)")

    if LBISSettings.SelectedZone == LBIS.L["All"] then
        return true;
    elseif strfind(zone, gsub(gsub(LBISSettings.SelectedZone, "%(", "%%%("), "%)", "%%%)")) ~= nil then
        return true;
    end
    return false;
end

function LBIS:IsInSlot(specItem)
    if LBISSettings.SelectedSlot == LBIS.L["All"] then
        return true;
    elseif strfind(specItem.Slot, LBISSettings.SelectedSlot) ~= nil then
        return true;
    end
    return false;
end

function LBIS:IsInSource(specItem)
    if LBISSettings.SelectedSourceType == LBIS.L["All"] then
        return true;
    elseif strfind(specItem.SourceType, LBISSettings.SelectedSourceType) ~= nil then
        return true;
    end
    return false;
end

function LBIS:MeasureCode(codeName, func)

    --local startTime = time();

    func();

    --print(codeName.." took "..time() - startTime);

end
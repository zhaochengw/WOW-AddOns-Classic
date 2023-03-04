LBIS.ReCacheDate = time({year=2022, month=12, day=22, hour=22})

function LBIS:PreCacheItems()
    if LBIS.AllItemsCached then return LBIS.AllItemsCached; end

    LBIS.AllItemsCached = true;
    --If cache date is updated (because of cache changing) reset the cache
    if (not LBISServerSettings.LastCacheDate or LBISServerSettings.LastCacheDate < LBIS.ReCacheDate) then
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
itemSlots["INVTYPE_2HWEAPON"] = LBIS.L["Two Hand"];
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

    if not itemId or itemId <= 0 then
        returnFunc({ Name = nil, Link = nil, Quality = nil, Type = nil, SubType = nil, Texture = nil, Class = nil, Slot = nil });
    end

    local cachedItem = LBISServerSettings.ItemCache[itemId];

    if cachedItem then
        returnFunc(cachedItem);
    else
        local itemCache = Item:CreateFromItemID(itemId)

        itemCache:ContinueOnItemLoad(function()
            local itemId, itemType, subType, itemSlot, _, classId = GetItemInfoInstant(itemId);
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
                Texture = GetSpellTexture(spellId)
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
    local change_func = opts['changeFunc'] or function (dropdown_val) end

    local dropdown = LibDD:Create_UIDropDownMenu(dropdown_name, opts['parent'])

    LibDD:UIDropDownMenu_Initialize(dropdown, function(self, level, _)
        local info = LibDD:UIDropDownMenu_CreateInfo()
        for key, val in pairs(menu_items) do
            info.text = val;
            info.checked = false
            info.isNotRadio = true;
            info.noClickSound = true
            info.func = function(b)
                LibDD:UIDropDownMenu_SetSelectedValue(dropdown, b.value, b.value)
                LibDD:UIDropDownMenu_SetText(dropdown, b.value)
                info.checked = true
                change_func(dropdown, b.value)
            end
            LibDD:UIDropDownMenu_AddButton(info)
        end
    end)

    LibDD:UIDropDownMenu_SetText(dropdown, default_val)
    LibDD:UIDropDownMenu_SetWidth(dropdown, width, 0)

    local dd_title = dropdown:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
    dd_title:SetText(title_text)
    dd_title:SetPoint("TOPLEFT", (-1 * dd_title:GetStringWidth()) + 20, -8)

    return dropdown
end

local itemIsOnEnter = false;
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
    ChatFrame6:AddMessage("LBIS:"..startString..stringify(object));
end

function LBIS:Error(startString, object)
    print("LoonBestInSlot ERROR:"..startString..stringify(object));
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
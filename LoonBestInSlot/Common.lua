function LBIS:PreCacheItems()
    if LBIS.AllItemsCached then return LBIS.AllItemsCached; end

    LBIS.AllItemsCached = true;

    for itemId, _ in pairs(LBIS.Items) do

        if itemId and itemId ~= 0 then
            LBIS:CacheItem(itemId);
        end
    end
    return LBIS.AllItemsCached;
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

function LBIS:TableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function LBIS:GetItemInfo(itemIdString, returnFunc)

    local itemId = tonumber(itemIdString);

    if not itemId or itemId <= 0 then
        returnFunc({ Name = nil, Link = nil, Quality = nil, Type = nil, SubType = nil, Texture = nil });
    end

    local cachedItem = LBIS.WowItemCache[itemId];

    if cachedItem then
        returnFunc(cachedItem);
    else
        local itemCache = Item:CreateFromItemID(itemId)

        itemCache:ContinueOnItemLoad(function()
            local itemId, itemType, subType = GetItemInfoInstant(itemId)

            local name = itemCache:GetItemName();
            
            local newItem = {
                Id = itemId,
                Name = name,
                Link = itemCache:GetItemLink(),
                Quality = itemCache:GetItemQuality(),
                Type = itemType,
                SubType = subType,
                Texture = itemCache:GetItemIcon(),
            };

            if name then
                LBIS.WowItemCache[itemId] = newItem;
            end
            
            returnFunc(newItem);            
        end);
    end           
end


function LBIS:GetSpellInfo(spellIdString, returnFunc)

    local spellId = tonumber(spellIdString);

    if not spellId or spellId <= 0 then
        returnFunc({ Name = nil, Link = nil, Quality = nil, Type = nil, SubType = nil, Texture = nil });
    end

    local cachedSpell = LBIS.WowSpellCache[spellId];

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
                LBIS.WowSpellCache[spellId] = newSpell;
            end
            
            returnFunc(newSpell);
        end);
    end           
end

local itemIsOnEnter = false;
--- Opts:
---     name (string): Name of the dropdown (lowercase)
---     parent (Frame): Parent frame of the dropdown.
---     items (Table): String table of the dropdown options.
---     defaultVal (String): String value for the dropdown to default to (empty otherwise).
---     changeFunc (Function): A custom function to be called, after selecting a dropdown option.
function LBIS:CreateDropdown(opts)
    local dropdown_name = '$parent_' .. opts['name'] .. '_dropdown'
    local menu_items = opts['items'] or {}
    local title_text = opts['title'] or ''
    local dropdown_width = 0
    local default_val = opts['defaultVal'] or ''
    local change_func = opts['changeFunc'] or function (dropdown_val) end

    local dropdown = CreateFrame("Frame", dropdown_name, opts['parent'], 'UIDropDownMenuTemplate')
    local dd_title = dropdown:CreateFontString(dropdown, 'OVERLAY', 'GameFontNormalSmall')

    for _, item in pairs(menu_items) do -- Sets the dropdown width to the largest item string width.
        dd_title:SetText(item)
        local text_width = dd_title:GetStringWidth() + 20
        if text_width > dropdown_width then
            dropdown_width = text_width
        end
    end

    UIDropDownMenu_SetWidth(dropdown, dropdown_width)
    UIDropDownMenu_SetText(dropdown, default_val)
    dd_title:SetText(title_text)
    dd_title:SetPoint("TOPLEFT", (-1 * dd_title:GetStringWidth()) + 20, -8)

    UIDropDownMenu_Initialize(dropdown, function(self, level, _)
        local info = UIDropDownMenu_CreateInfo()
        for key, val in pairs(menu_items) do
            info.text = val;
            info.checked = false
            info.menuList= key
            info.hasArrow = false
            info.func = function(b)
                UIDropDownMenu_SetSelectedValue(dropdown, b.value, b.value)
                UIDropDownMenu_SetText(dropdown, b.value)
                b.checked = true
                change_func(dropdown, b.value)
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    return dropdown
end

function LBIS:SetTooltipOnButton(b, item, isSpell)
    
    b:SetScript("OnClick", 
        function(self, button)
            if button == "LeftButton" then
                if isSpell then
                    HandleModifiedItemClick(GetSpellLink(item.Id));
                else
                    HandleModifiedItemClick(item.Link);
                end
            end
        end
    );

    b:SetScript("OnEnter", 
        function(self)
            GameTooltip:SetOwner(self, "ANCHOR_LEFT");
            if isSpell == nil or isSpell == false then
                GameTooltip:SetItemByID(item.Id);
            else
                GameTooltip:SetSpellByID(item.Id);
            end
            GameTooltip:Show();
            itemIsOnEnter = true;
                
            if IsShiftKeyDown() and itemIsOnEnter then
                GameTooltip_ShowCompareItem(tooltip)
            end
        end
    );

    b:SetScript("OnLeave", 
        function(self)
            itemIsOnEnter = false;
            GameTooltip:SetOwner(UIParent, "ANCHOR_NONE");
            GameTooltip:Hide();
        end
    );
end

function LBIS:RegisterTooltip()
	LBIS:RegisterEvent("MODIFIER_STATE_CHANGED", function()
        if IsShiftKeyDown() and itemIsOnEnter then
            GameTooltip_ShowCompareItem()
        else
            ShoppingTooltip1:Hide()
            ShoppingTooltip2:Hide()
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
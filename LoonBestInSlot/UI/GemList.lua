LBIS.GemList = {};

local function itemSortFunction(table, k1, k2)

    local item1 = table[k1];
    local item2 = table[k2];

    local item1Score = 0;
    local item2Score = 0;

    if item1.IsMeta == "True" then
        item1Score = item1Score + 100;
    end
    if item2.IsMeta == "True" then
        item2Score = item2Score + 100;
    end

    item1Score = item1Score + tonumber(item1.Quality);
    item2Score = item2Score + tonumber(item2.Quality);

    if item1Score == item2Score then
        return item1.Id > item2.Id;
    else
        return item1Score > item2Score
    end
end

local function createItemRow(f, specGem, specGemSource)
    
    LBIS:GetItemInfo(specGem.Id, function(item)
        local window = LBIS.BrowserWindow.Window;

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
        
        if tonumber(specGemSource.DesignId) > 0 and tonumber(specGemSource.DesignId) < 99999 then
            LBIS:GetItemInfo(tonumber(specGemSource.DesignId), function(designItem)

                if designItem.Name == nil then
                    return;
                end

                local b2 = CreateFrame("Button", nil, f);
                b2:SetSize(32, 32);
                local bt2 = b2:CreateTexture();
                bt2:SetAllPoints();
                bt2:SetTexture(designItem.Texture);                                        
                b2:SetPoint("TOPLEFT", (window.ScrollFrame:GetWidth() / 2), -5);

                LBIS:SetTooltipOnButton(b2, designItem);

                local d = f:CreateFontString(nil, nil, "GameFontNormal");
                d:SetText(specGemSource.Source);
                d:SetJustifyH("LEFT");
                d:SetPoint("TOPLEFT", b2, "TOPRIGHT", 2, -2);

                local dl = f:CreateFontString(nil, nil, "GameFontNormalSmall");
                dl:SetText(specGemSource.SourceLocation);
                dl:SetPoint("TOPLEFT", d, "BOTTOMLEFT", 0, -5);
            end); 
        else
            local d = f:CreateFontString(nil, nil, "GameFontNormal");
            d:SetText(specGemSource.Source);
            d:SetJustifyH("LEFT");
            d:SetWidth(window.ScrollFrame:GetWidth() / 2);
            d:SetPoint("TOPLEFT", (window.ScrollFrame:GetWidth() / 2), -5);

            local dl = f:CreateFontString(nil, nil, "GameFontNormalSmall");
            dl:SetText(specGemSource.SourceLocation);
            dl:SetPoint("TOPLEFT", d, "BOTTOMLEFT", 0, -5);            
        end
    end);
    
    -- even if we are reusing, it may not be in the same order
    local _, count = string.gsub(specGemSource.Source, "/", "")
    if count > 1 then
        count = count - 1;
    else 
        count = 0;
    end
    return (46 + (count * 10));
end

function LBIS.GemList:UpdateItems()

    LBIS.BrowserWindow.Window.SlotDropDown:Hide();
    LBIS.BrowserWindow.Window.PhaseDropDown:Hide();
    LBIS.BrowserWindow.Window.RankDropDown:Hide();
    LBIS.BrowserWindow.Window.SourceDropDown:Hide();
    LBIS.BrowserWindow.Window.RaidDropDown:Hide();

    LBIS.BrowserWindow:UpdateItemsForSpec(function(point)

        local specGems = LBIS.GemsBySpecAndId[LBIS.NameToSpecId[LBISSettings.SelectedSpec]];
        
        if specGems == nil then
            LBIS.BrowserWindow.Window.ShowUnavailable();
        end

        for gemId, specGem in LBIS:spairs(specGems, itemSortFunction) do
        
            local specGemSource = LBIS.GemSources[specGem.Id];
    
            if specGemSource == nil then
                LBIS:Error("Missing gem source: ", specGem);
            else
                point = LBIS.BrowserWindow:CreateItemRow(specGem, specGemSource, LBISSettings.SelectedSpec.."_"..specGemSource.Name.."_"..specGem.Id, point, createItemRow)
            end
        end
    end);
end
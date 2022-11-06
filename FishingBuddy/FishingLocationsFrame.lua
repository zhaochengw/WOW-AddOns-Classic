-- Handle displaying all the fish in their habitats

FishingBuddy.Locations = {};

local FL = LibStub("LibFishing-1.0");

-- 5.0.4 has a problem with a global "_" (see some for loops below)
local _

local NUM_THINGIES_DISPLAYED = 22;
local FRAME_THINGIEHEIGHT = 16;
FishingBuddy.Locations.FRAME_THINGIEHEIGHT = FRAME_THINGIEHEIGHT;

local Collapsed = 0;
local LocationLineSelected = 0;
local LocationLines = {};
local LocationLastLine = 1;

local zmto = FishingBuddy.ZoneMarkerTo;
local zmex = FishingBuddy.ZoneMarkerEx;

--
-- #####	  X	 X		 X
--							level
--				 expanded
--		 collapsible
--
-- number * 1000
--		 negative --> zone marker
--		 positive --> fish

-- level is 0 for zones
-- level is 1 for subzones, or 0 if not showing zones
-- level is 2 for fish, or 1 if not showing zones

local function pack(zonemarker, id, collapsible, expanded, level)
    local val;
    if ( zonemarker > 0 ) then
        val = zonemarker;
    else
        val = id;
    end
    val = val * 10 + level;
    val = val * 10 + collapsible;
    val = val * 10 + expanded;		 -- expanded
    if ( zonemarker > 0 ) then
        val = val * -1;
    end
    return val;
end

local function unpack(marker)
    if ( not marker ) then
        return 0, 0, 0, 0, 0;
    end
    local val = marker;
    if ( val < 0 ) then
        val = val * -1;
    end
    local subzone, id, collapsible, expanded, level;
    local mod = math.fmod;
    expanded = mod(val, 10);
    val = floor(val / 10);
    collapsible = mod(val, 10);
    val = floor(val / 10);
    level = mod(val, 10);
    val = floor(val / 10);
    if ( marker < 0 ) then
        return val, 0, collapsible, expanded, level;
    else
        return 0, val, collapsible, expanded, level;
    end
end

local function toggle(marker)
    local z,i,c,e,l = unpack(marker);
    e = 1 - e;
    return pack(z,i,c,e,l);
end

local function MakeInfo(line, zid, fid, collapsible, level)
    LocationLines[line] = pack(zid, fid, collapsible, collapsible, level);
end

local function CountLocationLines()
    local linecount = 0;
    local j = 1;
    for odx=1,LocationLastLine do
        local check = LocationLines[j];
        j = j + 1;
        if ( check and check ~= 0 ) then
            linecount = linecount + 1;
            local c,e,level;
            _,_,c,e,level = unpack(check);
            if ( c == 1 and e == 0 ) then
                local l;
                _,_,_,_,l = unpack(LocationLines[j]);
                while ( l > level ) do
                    j = j + 1;
                    _,_,_,_,l = unpack(LocationLines[j]);
                end
            end
        end
    end
    return linecount;
end

local function FishCount(idx)
    local count = 0;
    local total = 0;
    local fh = FishingBuddy_Info["FishingHoles"];
    if ( fh[idx] ) then
        for fishie,val in pairs(fh[idx]) do
            count = count + 1;
            total = total + val;
        end
    end
    return count, total;
end
FishingBuddy.FishCount = FishCount;

local function FishiesChanged()
    local fishcount = table.getn(FishingBuddy.SortedFishies);
    local line = 1;

    for i=1,fishcount,1 do
        local fishid = FishingBuddy.SortedFishies[i].id;
        local locsort = {};
        for idx,count in pairs(FishingBuddy.ByFishie[fishid]) do
            local info = {};
            info.marker = idx;
            info.count = count;
            tinsert(locsort, info);
        end
        MakeInfo(line, 0, fishid, 1, 0);
        line = line + 1;
        FishingBuddy.FishSort(locsort);
        for j=1,table.getn(locsort),1 do
            MakeInfo(line, locsort[j].marker, 0, 0, 1);
            line = line + 1;
        end
    end
    LocationLastLine = line;
end

local function BothLocationsChanged()
    local loc = GetLocale();
    local fh = FishingBuddy_Info["FishingHoles"];
    local ff = FishingBuddy_Info["Fishies"];
    local sorted = FishingBuddy.SortedZones;
    local line = 1;
    local zonecount = table.getn(sorted);
    for i=1,zonecount,1 do
        local zone = sorted[i];
        local mapId = FishingBuddy.MappedZones[zone];
        if ( mapId ) then
            local addedzone = false;
            local subsorted = FishingBuddy.SortedByZone[zone];
            local subcount = table.getn(subsorted);
            for s=1,subcount,1 do
                local subzone = subsorted[s];
                local where = FishingBuddy.GetZoneIndex(mapId, subzone, true);
                local count, total = FishCount(where);
                if ( total > 0 ) then
                    if ( not addedzone ) then
                        MakeInfo(line, zmto(mapId, 0), 0, 1, 0);
                        line = line + 1;
                        addedzone = true;
                    end
                    if ( fh[where] ) then
                        MakeInfo(line, where, 0, 1, 1);
                        line = line + 1;
                        local fishsort = {};
                        for fishid,count in pairs(fh[where]) do
                            local info = {};
                            info.id = fishid;
                            _, _, _, _, _, info.text, _ = FishingBuddy.GetFishie(fishid, 1);
                            info.count = count;
                            tinsert(fishsort, info);
                        end
                        FishingBuddy.FishSort(fishsort);
                        for j=1,table.getn(fishsort),1 do
                            local id = fishsort[j].id;
                            MakeInfo(line, 0, id, 0, 2);
                            line = line + 1;
                        end
                    end
                end
            end
        end
    end
    LocationLastLine = line;
end

local function SubZonesChanged()
    local loc = GetLocale();
    local fh = FishingBuddy_Info["FishingHoles"];
    local ff = FishingBuddy_Info["Fishies"];
    local line = 1;
    local zonecount = table.getn(FishingBuddy.SortedSubZones);
    for i=1,zonecount,1 do
        local subzone = FishingBuddy.SortedSubZones[i];
        local ztab = FishingBuddy.SubZoneMap[subzone];
        if ( ztab ) then
            local oneidx;
            local uniquify = {};
            local fishsort = {};
            for idx,_ in pairs(ztab) do
                if ( fh[idx] ) then
                    oneidx = idx;
                    for fishid,count in pairs(fh[idx]) do
                        if ( not uniquify[fishid] ) then
                            local _, _, _, _, _, name, _ = FishingBuddy.GetFishie(fishid, 1);
                            tinsert(fishsort, { id=fishid, text=name });
                            uniquify[fishid] = 1;
                        end
                    end
                end
            end
            if ( oneidx ) then
                MakeInfo(line, oneidx, 0, 1, 0);
                line = line + 1;
                FishingBuddy.FishSort(fishsort);
                for j=1,table.getn(fishsort),1 do
                    local id = fishsort[j].id;
                    MakeInfo(line, 0, id, 0, 1);
                    line = line + 1;
                end
            end
        end
    end
    LocationLastLine = line;
end

local function LinesChanged()
    if ( FishingBuddy.GetSettingBool("GroupByLocation") ) then
        if ( FishingBuddy.GetSettingBool("ShowLocationZones") ) then
            BothLocationsChanged();
        else
            SubZonesChanged();
        end
    else
        FishiesChanged();
    end
    for i=LocationLastLine,table.getn(LocationLines) do
        LocationLines[i] = 0;
    end
    FishingLocationsFrame.valid = true;
end

-- local MOUSEWHEEL_DELAY = 0.1;
-- local lastScrollTime = nil;
-- function FishingLocationsFrame_OnMouseWheel(value)
--		local now = GetTime();
--		if ( not lastScrollTime ) then
--			lastScrollTime = now - 0.2;
--		end
--		if ( (now - lastScrollTime) > MOUSEWHEEL_DELAY ) then
--			-- call the old mouse wheel function somehow?
--		end
-- end

local function UpdateLocationScrollPosition()
    local linecount = CountLocationLines();
    local offset = FauxScrollFrame_GetOffset(FishingLocsScrollFrame);
    if ( offset + NUM_THINGIES_DISPLAYED > linecount ) then
        offset = linecount - NUM_THINGIES_DISPLAYED;
        if ( offset < 0 ) then
            offset = 0;
        end
        FishingLocsScrollFrameScrollBar:SetValue(offset);
    end
    FauxScrollFrame_Update( FishingLocsScrollFrame, linecount,
                                  NUM_THINGIES_DISPLAYED,
                                  FRAME_THINGIEHEIGHT,
                                  nil, nil, nil,
                                  FishingLocationHighlightFrame,
                                  230, 230
                              );
end

local function SetSelectedLocLine(id, line)
    local info = LocationLines[line];
    FishingLocationHighlightFrame:Hide();
    if ( info ~= 0 ) then
        local z,i,c,e,l = unpack(info);
        if ( c == 1 ) then
            LocationLines[line] = toggle(info);
            UpdateLocationScrollPosition();
        else
            LocationLineSelected = line;
            FishingLocationHighlightFrame:SetPoint ("TOPLEFT" , _G["FishingLocations"..id]:GetName() , "TOPLEFT" , 5 , 0 )
            FishingLocationHighlightFrame:Show()
        end
    end
end

local function UpdateLocLine(id, line, leveloffset, c, e, text, append, texture)
    local locButton = _G["FishingLocations"..id];
    local locButtonFS = _G["FishingLocations"..id.."NormalText"];
    local locHilite = _G["FishingLocations"..id.."Highlight"];
    local icon = _G["FishingLocations"..id.."Icon"];
    local icontex = _G["FishingLocations"..id.."IconTexture"];
    locButton.id = id;
    locButton.line = line;
    if ( id == 1 ) then
        locButton:SetPoint("TOPLEFT", FishingBuddyFrameInset, "TOPLEFT", leveloffset+8, -4);
    else
        local t = id - 1;
        locButton:SetPoint("TOPLEFT", "FishingLocations"..t, "BOTTOMLEFT", leveloffset, 0);
    end
    icon:ClearAllPoints();
    locButton:GetNormalFontObject():SetTextColor( 1, 0.82, 0 );
    local offset = 0;
    if ( c == 1 ) then
        offset = 21;
        icon:SetPoint("LEFT", locButton, "LEFT", 21, 0);
        if ( e == 1 ) then
            locButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
        else
            locButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
        end
        locHilite:SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
        locButton:UnlockHighlight();
    else
        icon:SetPoint("LEFT", locButton, "LEFT", 0, 0);
        locButton:SetNormalTexture("");
        locHilite:SetTexture("");
        -- Place the highlight and lock the highlight state
        if ( LocationLineSelected == line ) then
            FishingLocationHighlightFrame:SetPoint("TOPLEFT", locButton,
                                                                "TOPLEFT", 21, 0);
            FishingLocationHighlightFrame:Show();
            locButton:LockHighlight();
        else
            locButton:UnlockHighlight();
        end
    end
    if( texture ) then
        offset = offset + 18;
        icontex:SetTexture(texture);
        icon:Show();
        icontex:Show();
    else
        icontex:SetTexture("");
        icontex:Hide();
        icon:Hide();
    end

    local textfield = _G["FishingLocations"..id.."NormalText"];
    if ( textfield ~= nil ) then
         textfield:SetPoint("LEFT", offset, 0);
    end

    FL:EllipsizeText(locButtonFS, text, FishingLocsScrollFrameScrollChildFrame:GetWidth() - leveloffset - 4, append)
    locButton:Show();
end

FishingBuddy.Locations.Update = function(self, forced)
    if ( not FishingLocationsFrame:IsVisible() ) then
        return;
    end

    if ( forced or not FishingLocationsFrame.valid ) then
        LinesChanged();
    end

    local IsQuestFish = FishingBuddy.IsQuestFish;
    local offset = FauxScrollFrame_GetOffset(self);
    local lastlevel = 0;
    FishingLocationHighlightFrame:Hide();
    UpdateLocationScrollPosition();

    local append = ""
    local j = 1;
    local i = 1;
    local limit = offset + NUM_THINGIES_DISPLAYED;
    local totals = {};
    local lastzid, lastfid;
    local fh = FishingBuddy_Info["FishingHoles"];
    local bf = FishingBuddy.ByFishie;
    local ft = FishingBuddy_Info["FishTotals"];

    local green = "ff"..FL.COLOR_HEX_GREEN;
    local white = "ff"..FL.COLOR_HEX_WHITE;
    for odx=0,LocationLastLine,1 do
        local info = LocationLines[j];
        if ( info and info ~= 0 ) then
            local zid,fid,c,e,level = unpack(info);
            local percent = nil;
            local zidx, sidx;
            if ( zid > 0 ) then
                lastzid = zid;
                zidx, sidx = zmex(zid);
                if ( sidx > 0 ) then
                    local sz = FishingBuddy_Info["SubZones"][zid];
                    local ztab = FishingBuddy.SubZoneMap[sz];
                    if ( ztab ) then
                        local count = 0;
                        for idx,_ in pairs(ztab) do
                            local n = FishingBuddy_Info["FishTotals"][idx];
                            if ( n ) then
                                count = count + n;
                            end
                        end
                        totals[level] = count;
                    end
                else
                    totals[level] = FishingBuddy_Info["FishTotals"][zid];
                end
            else
                if ( level == 0 ) then
                    lastfid = fid;
                else
                    lastfid = nil;
                end
            end
            if ( odx >= offset and odx < limit ) then
                local locButton = _G["FishingLocations"..i];
                if ( zid > 0 or fid > 0 ) then
                    local text, texture;
                    locButton.tooltip = {};
                    if ( fid > 0 ) then
                        local item;
                        item, texture, _, _, _, text, _ = FishingBuddy.GetFishie(fid, 1);
                        locButton.item = item;
                        locButton.fishid = fid;
                        locButton.name = text;
                        if ( IsQuestFish(fid) ) then
                            tinsert(locButton.tooltip, ITEM_BIND_QUEST);
                        end
                        if ( level > 0 ) then
                            local zidx, sidx = zmex(lastzid);
                            local sz = FishingBuddy_Info["SubZones"][lastzid];
                            local ztab = FishingBuddy.SubZoneMap[sz];
                            local count = 0;
                            if ( ztab ) then
                                for idx,_ in pairs(ztab) do
                                    if ( fh[idx] and fh[idx][fid] ) then
                                        count = count + fh[idx][fid];
                                    end
                                end
                            end
                            if ( count > 0 ) then
                                tinsert(locButton.tooltip,
                                          { { FBConstants.CAUGHTTHISMANY, green },
                                              { count, white } } );
                                if ( totals[level-1] ) then
                                    tinsert(locButton.tooltip,
                                              { { FBConstants.CAUGHTTHISTOTAL, green },
                                                  { totals[level-1], white } } );
                                    percent = count/totals[level-1];
                                end
                            end
                        else
                            local total = 0;
                            for idx,count in pairs(bf[fid]) do
                                total = total + count;
                            end
                            totals[0] = total;
                            tinsert(locButton.tooltip,
                                      { { FBConstants.CAUGHTTHISTOTAL, green },
                                         { total, white } } );
                        end
                    else
                        if ( sidx > 0 ) then
                            text = FL:GetLocSubZone(FishingBuddy_Info["SubZones"][zid], 1);
                            tinsert(locButton.tooltip, text);
                            local ztab = FishingBuddy.SubZoneMap[text];
                            if ( ztab ) then
                                local inz = {};
                                for idx,_ in pairs(ztab) do
                                    local tz,ts = zmex(idx);
                                    -- need a non-ordered list of zone names
                                    local n = FL:GetLocZone(tz)
                                    tinsert(inz, n);
                                end
                                table.sort(inz);
                                tinsert(locButton.tooltip,
                                          FL:Green(ZONE_COLON.." ")..FL:White(FishingBuddy.EnglishList(inz)));
                            end
                            if ( lastfid ) then
                                if ( bf[lastfid][zid] ) then
                                    tinsert(locButton.tooltip,
                                              { { FBConstants.CAUGHTTHISTOTAL, green },
                                                  { bf[lastfid][zid], white } } );
                                    if ( level > 0 and totals[level-1] ) then
                                        percent = bf[lastfid][zid]/totals[level-1];
                                    end
                                end
                            elseif ( ft[zid] ) then
                                tinsert(locButton.tooltip,
                                              { { FBConstants.CAUGHTTHISTOTAL, green },
                                                 { ft[zid], white } } );
                                if ( level > 0 and totals[level-1] ) then
                                     percent = ft[zid]/totals[level-1];
                                end
                            end
                        else
                            text = FL:GetLocZone(zidx);
                            tinsert(locButton.tooltip, text);
                            local subsorted = FishingBuddy.SortedByZone[text];
                            local subcount = table.getn(subsorted or {});
                            local ins = {};
                            for s=1,subcount,1 do
                                tinsert(ins, subsorted[s]);
                            end
                            tinsert(locButton.tooltip,
                                      FL:Green("Subzones: ")..FL:White(FishingBuddy.EnglishList(ins)));
                            tinsert(locButton.tooltip,
                                          { { FBConstants.CAUGHTTHISTOTAL, green },
                                             { totals[level], white } } );
                            if ( level > 0 and lastfid and bf[lastfid][zid] ) then
                                percent = bf[lastfid][zid]/totals[level-1];
                            end
                        end
                        locButton.item = nil;
                        locButton.fishid = nil;
                        locButton.name = nil;
                        texture = nil;
                    end
                    local leveloffset = (level - lastlevel)*16;
                    if ( percent ) then
                        percent = math.floor(percent*100);
                        append = " ("..percent.."%)";
                        percent = nil;
                    else
                        append = ""
                    end
                    UpdateLocLine(i, j, leveloffset, c, e, text, append, texture);
                    lastlevel = level;
                else
                    locButton:Hide();
                    locButton.id = nil;
                    locButton.line = nil;
                end
                i = i + 1;
            end
            j = j + 1;
            if ( c == 1 and e == 0 ) then
                local i2 = LocationLines[j];
                if ( i2 and i2 ~= 0 ) then
                    local l;
                    _,_,_,_,l = unpack(i2)
                    while ( i2 and i2 ~= 0 and l > level ) do
                        j = j + 1;
                        i2 = LocationLines[j];
                        _,_,_,_,l = unpack(i2)
                    end
                end
            end
        end
    end

    while ( i <= NUM_THINGIES_DISPLAYED ) do
        local locButton = _G["FishingLocations"..i];
        locButton:Hide();
        locButton.id = nil;
        locButton.line = nil;
        i = i + 1;
    end

    if ( LocationLines ) then
        -- Set the expand/collapse all button texture
        local numHeaders = 0;
        local notExpanded = 0;
        for j=1,table.getn(LocationLines),1 do
            local info = LocationLines[j];
            local _,_,c,e,_ = unpack(info);
            if ( info and info ~= 0 and c == 1 ) then
                numHeaders = numHeaders + 1;
                if ( e == 0 ) then
                    notExpanded = notExpanded + 1;
                end
            end
        end
        FishingLocationsCollapseAllButton:Show();
        -- If all headers are not expanded then show collapse button, otherwise show the expand button
        if ( notExpanded ~= numHeaders ) then
            Collapsed = 0;
            FishingLocationsCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
        else
            Collapsed = 1;
            FishingLocationsCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
        end
    else
        FishingLocationsCollapseAllButton:Hide();
    end
end

local OptionHandlers = {};
local function FishOptionsInitialize()
    local menu = _G["FishingBuddyLocationsMenu"];
    if ( menu.fishid ) then
        local fishid = menu.fishid;
        local info = {};
        info.text = FBConstants.HIDEINWATCHER;
        info.func = FishingBuddy.WatchFrame.MakeToggle(fishid);
        info.checked = ( not FishingBuddy_Info["HiddenFishies"][fishid] );
        UIDropDownMenu_AddButton(info);

        for idx,handler in pairs(OptionHandlers) do
            handler(fishid);
        end
    end
end

FishingBuddy.Locations.Button_OnClick = function(self, button, down)
    if ( button == "LeftButton" ) then
        if( IsShiftKeyDown() and self.item ) then
            FL:ChatLink(self.item, self.name, self.color);
        elseif ( self.id and self.line ) then
            SetSelectedLocLine(self.id, self.line);
            FishingBuddy.Locations.Update(FishingLocsScrollFrame);
        end
    elseif ( self.fishid and button == "RightButton" ) then
        local menu = _G["FishingBuddyLocationsMenu"];
        menu.fishid = self.fishid;
        UIDropDownMenu_Initialize(menu, FishOptionsInitialize, "MENU");
        FishingBuddy.ToggleDropDownMenu(1, nil, menu, self, 0, 0);
    end
end

function FishingLocationsCollapseAllButton_OnClick()
    if ( Collapsed == 0 ) then
        FishingLocsScrollFrameScrollBar:SetValue(0);
        LocationLineSelected = 1;
    end

    for j=1,table.getn(LocationLines) do
        local check = LocationLines[j];
        if ( check ~= 0 ) then
            local z,i,c,e,l = unpack(check);
            e = Collapsed;
            LocationLines[j] = pack(z,i,c,e,l);
--			  FishingBuddy.Debug(" j "..j.." pack "..check.." unpack "..LocationLines[j]);
        end
    end
    Collapsed = 1 - Collapsed;
    UpdateLocationScrollPosition();
    FishingBuddy.Locations.Update(FishingLocsScrollFrame);
end

FishingBuddy.Locations.Button_OnEnter = function(self)
    if( GameTooltip.locbutfini ) then
        return;
    end
    if ( self.item or self.tooltip ) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    end
    local gottitle;
    if( self.item or self.tooltip ) then
        gottitle = true;
        if ( self.item and self.item ~= "" ) then
            if ( FL:IsLinkableItem(self.item) ) then
                GameTooltip:SetHyperlink("item:"..self.item);
            else
                local tip = {};
                tip[1] = self.name;
                tip[2] = { FBConstants.NOTLINKABLE, "ff"..FL.COLOR_HEX_RED };
                if ( self.tooltip ) then
                    if ( type(self.tooltip) == "table" ) then
                        for _,l in pairs(self.tooltip) do
                            tinsert(tip, l);
                        end
                    else
                        tinsert(tip, self.tooltip);
                    end
                end
                self.tooltip = tip;
                self.item = nil;
            end
        end
        if ( self.tooltip ) then
            FL:AddTooltip(self.tooltip);
        end
    end
    if ( self.item or self.tooltip or self.tipinfo ) then
        GameTooltip.locbutfini = 1;
        GameTooltip:Show();
    end
end

FishingBuddy.Locations.Button_OnLeave = function(self)
    if( self.item or self.tooltip ) then
        GameTooltip:Hide();
    end
    GameTooltip.locbutfini = nil;
end

local function DisplayChanged()
    FishingLocsScrollFrameScrollBar:SetValue(0);
    LocationLineSelected = 1;
    FishingBuddy.Locations.Update(FishingLocsScrollFrame, true);
end

local function UpdateButtonDisplay()
    if ( FishingBuddy.GetSettingBool("GroupByLocation") ) then
        FishingLocationsSwitchButton:SetText(FBConstants.SHOWFISHIES);
        FishingBuddyOptionSLZ:Show();
    else
        FishingLocationsSwitchButton:SetText(FBConstants.SHOWLOCATIONS);
        FishingBuddyOptionSLZ:Hide();
    end
end

FishingBuddy.Locations.SwitchDisplay = function()
    -- backwards logic check, we're about to change...
    local setting = FishingBuddy.GetSetting("GroupByLocation");
    setting = not setting;
    FishingBuddy.SetSetting("GroupByLocation", setting);
    UpdateButtonDisplay();
    DisplayChanged();
end

FishingBuddy.Locations.SwitchButton_OnEnter = function()
    if ( FishingBuddy.GetSettingBool("GroupByLocation") ) then
        GameTooltip:SetText(FBConstants.SHOWFISHIES_INFO);
    else
        GameTooltip:SetText(FBConstants.SHOWLOCATIONS_INFO);
    end
    GameTooltip:Show();
end

local LocationEvents = {};
LocationEvents[FBConstants.ADD_FISHIE_EVT] = function()
    FishingLocationsFrame.valid = false;
end

LocationEvents[FBConstants.RESET_FISHDATA_EVT] = function()
    FishingLocationsFrame.valid = false;
end

local LocOptions = {
    ["ShowLocationZones"] = {
        ["text"] = FBConstants.CONFIG_SHOWLOCATIONZONES_ONOFF,
        ["tooltip"] = FBConstants.CONFIG_SHOWLOCATIONZONES_INFO,
        ["button"] = "FishingBuddyOptionSLZ",
        ["v"] = 1,	-- process it as if it was displayed in the options frame
        ["update"] = DisplayChanged,
        ["setup"] = function(self)
                        self:SetPoint("TOPLEFT", "FishingLocationsSwitchButton", "BOTTOMLEFT", 0, 4);
                    end,
        ["default"] = true, },
};

FishingBuddy.Locations.OnLoad = function(self)
    self:RegisterEvent("VARIABLES_LOADED");
    FishingLocationsSwitchButton:SetText(FBConstants.SHOWFISHIES);
    -- Set up checkbox
    FishingBuddy.EmbeddedOptions(FishingLocationsFrame);
    FishingBuddy.OptionsFrame.HandleOptions(nil, nil, LocOptions);
    FishingBuddy.RegisterHandlers(LocationEvents);
    FishingLocationsFrame:SetScript("OnHide", function(self) FishingBuddyOptionSLZ:Hide(); end)
end

FishingBuddy.Locations.OnShow = function(self)
    if ( FishingBuddy.IsLoaded() ) then
        FishingLocationsFrame:InitializeOptions(LocOptions)
        FishingBuddy.Locations.Update(FishingLocsScrollFrame);
        UpdateButtonDisplay();
    end
end

FishingBuddy.Locations.OnEvent = function(self, event, ...)
    -- this crashes the client when enabled
    -- self:EnableMouseWheel(0);
    if event == "VARIABLES_LOADED" then
        local groups = {}
        tinsert(groups, {
            ["name"] = FBConstants.LOCATIONS_TAB,
            ["icon"] = "Interface\\Icons\\INV_Misc_Note_01",
            ["frame"] = "FishingLocationsFrame"
        })
        local frame = FishingBuddy.CreateManagedFrameGroup(FBConstants.LOCATIONS_TAB,
                                                            FBConstants.LOCATIONS_INFO,
                                                            "_LOC",
                                                            groups);
        FishingBuddyFrame:MakePrimary(frame);
    end
end

FishingBuddy.Locations.DataChanged = function(zone, subzone, fishie)
    FishingLocationsFrame.valid = false;
end

FishingBuddy.ShowLocLine = function(j)
    FishingBuddy.Dump(LocationLines[j]);
end

FishingBuddy.Locations.PerFishOptions = function(handler)
    local found = false;
    for idx,h in pairs(OptionHandlers) do
        if ( h == handler ) then
            found = true;
        end
    end
    if ( not found ) then
        table.insert(OptionHandlers, handler);
    end
end

FishingBuddy.DumpLocationLines = function()
    FishingBuddy.Dump(LocationLines);
end

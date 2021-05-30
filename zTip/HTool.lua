local format, GetItemInfo= format, GetItemInfo

HTool = {}

HTool.GameTooltipFrame = CreateFrame ("GameTooltip", "zTipGameTooltipFrame", nil, "GameTooltipTemplate")

HTool.TalentColor = function(point, maxValue)
    local g,r,b = 0,0,18
    local Per = point/maxValue
    if(Per > 0.5) then
        g = 0.1 + (((1-Per) * 2)* (1-(0.1)))
        r = 0.9
    else
        g = 1.0
        r = (0.9) - (0.5 - Per)* 2 * (0.9)
    end
    return ("|cff%2x%2x%2x%s|r"):format(r*255,g*255,b,point)
end

HTool.GetTalentStr = function(table_talent)
    local result = "";
    local first, second, third, name, text, point
    if table_talent[1].p >= table_talent[2].p then
        if table_talent[1].p >= table_talent[3].p then
            first = 1
            if table_talent[2].p >= table_talent[3].p then second = 2 third = 3 else second = 3	third = 2 end
        else
            first = 3 second = 1 third = 2
        end
    else
        if table_talent[2].p >= table_talent[3].p then
            first = 2
            if table_talent[1].p >= table_talent[3].p then second = 1 third = 3 else second = 3 third = 1 end
        else
            first = 3 second = 2 third = 1
        end
    end
    if table_talent[first].p*3/4 < table_talent[second].p then
        result = table_talent[first].n.."/".. table_talent[second].n;
    else
        result = table_talent[first].n;
    end
    result = result .." |cc8c8c8c8(".. HTool.TalentColor(table_talent[1].p,50).."|cc8c8c8c8/"..HTool.TalentColor(table_talent[2].p,50).."|cc8c8c8c8/"..HTool.TalentColor(table_talent[3].p,50)..")"
    return result
end

---------返回值level,solt,needAgain
---------level 装等
---------needAgain 是否需要再次查询,特殊情况下,itemLink的装等信息是错误的，需要再次查询才能成功(例如神器武器，每把武器进入游戏的第一次查询，都无法获的正确link)
HTool.GetItemInfoByItemLink = function(itemLink,nocheck)
    local needAgain = false;
    local _, _, quality, level, _, _, _, _, slot, texture = GetItemInfo(itemLink)
    if not nocheck then
        if not texture then
            print("Error:No texture By GetItemInfoByItemLink");
            needAgain = true
        end
        if not level then
            print("Error:No level By GetItemInfoByItemLink");
            needAgain = true
        end
    end
    return level, needAgain
end

local itemLevelPattern = _G.ITEM_LEVEL:gsub("%%d", "(%%d+)")
HTool.RewardRealItemLevelByInsID = function(unit,index)
    HTool.GameTooltipFrame:SetOwner (WorldFrame, "ANCHOR_NONE")
    HTool.GameTooltipFrame:ClearLines()
    if (HTool.GameTooltipFrame:SetInventoryItem(unit,index)) then
        local itemlevel = nil
        for i = 2, 6 do
            local label, text = _G["zTipGameTooltipFrameTextLeft"..i], nil
            if label then text=label:GetText() end
            if text then
                if itemlevel==nil then itemlevel = tonumber(text:match(itemLevelPattern)) end
            end
        end
        return itemlevel, select(2,HTool.GameTooltipFrame:GetItem())
    end
end
HTool.GetItemInfoByIndex = function(unit,index)
    -- print("Error:No GetItemInfoByIndex");
    return HTool.RewardRealItemLevelByInsID(unit,index);
end

HTool.GetUnit = function(guid)
    if not guid then return end
    if( UnitGUID("player") == guid )then
        return "player";
    elseif( UnitGUID("mouseover") == guid) then
        return "mouseover";
    elseif( UnitGUID("target") == guid) then
        return "target";
    else
        if IsInGroup() then
            for i=1,5 do
                if( UnitGUID("party"..i) == guid) then
                    return "party"..i;
                end
            end
        end
        if IsInRaid() then
            for i=1,40 do
                if( UnitGUID("raid"..i) == guid) then
                    return "raid"..i;
                end
            end
        end
    end
end

HTool.GetClassIcon=function(class,size)
	if not class then return end
	local  classiconCoord = CLASS_ICON_TCOORDS[class]
	if classiconCoord then
		local a1,a2,a3,a4 = classiconCoord[1]*100,classiconCoord[2]*100,classiconCoord[3]*100,classiconCoord[4]*100
		local ed
		if size and tonumber(size) < 0 then
			ed = a2..":"..a1..":"..a3..":"..a4.."|t "
		else
			ed = a1..":"..a2..":"..a3..":"..a4.."|t "
		end
		return "|TInterface\\WorldStateFrame\\Icons-Classes:"..(size or 12)..":"..(size or 12)..":0:0:100:100:"..ed
	end
end

---内置函数:GetQuestDifficultyColor(level,mode)
HTool.GetDifficultyColor=function(level)
    return ConvertRGBtoColorString(GetQuestDifficultyColor(level))
    -- local lDiff = level - UnitLevel("player");
	-- local lRange = GetQuestGreenRange()
    -- local r,g,b;
	-- if (lDiff >= 0) then
	-- 	r = 1.00; b = 0.00;
	-- 	if lDiff < 10 then
	-- 		g = 1 - (lDiff*0.10)
	-- 	else
	-- 		g = 0.00
	-- 	end
	-- elseif ( -lDiff < lRange) then
	-- 	g = 1.00; b = 0.00;
	-- 	r = 1 - (-1.0*lDiff)/lRange
	-- elseif ( -lDiff == lRange ) then
	-- 	r = 0.50; g = 1.00; b = 0.50;
	-- else
	-- 	r = 0.75; g = 0.75; b = 0.75;
	-- end
	-- return format("%2x%2x%2x",r*255,g*255,b*255);
end
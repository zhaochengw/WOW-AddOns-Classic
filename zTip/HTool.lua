local format, GetItemInfo = format, GetItemInfo

HTool = {}

local GameVer = select(4, GetBuildInfo())
HTool.CreateEventTable = function(_table)
    local resultTable = _table or {}
    resultTable.eventframe = CreateFrame("Frame")
    resultTable.RegisterEvent = function(_, event)
        resultTable.eventframe:RegisterEvent(event)
    end
    resultTable.eventframe:SetScript(
        "OnEvent",
        function(self, event, ...)
            if resultTable[event] then
                return resultTable[event](resultTable, ...)
            end
        end
    )
    resultTable.eventframe:SetScript(
        "OnUpdate",
        function(self, elapsed)
            if resultTable.Update then
                resultTable.Update(resultTable, elapsed)
            end
        end
    )
    resultTable.eventframe:Show()
    return resultTable
end

HTool.GameTooltipFrame = CreateFrame("GameTooltip", "zTipGameTooltipFrame", nil, "GameTooltipTemplate")

HTool.TalentColor = function(point, maxValue)
    local g, r, b = 0, 0, 18
    local Per = point / maxValue
    if (Per > 0.5) then
        g = 0.1 + (((1 - Per) * 2) * (1 - (0.1)))
        r = 0.9
    else
        g = 1.0
        r = (0.9) - (0.5 - Per) * 2 * (0.9)
    end
    return ("|cff%2x%2x%2x%s|r"):format(r * 255, g * 255, b, point)
end
local MaxPoint = 61
if GameVer >= 20000 and GameVer < 40000 then
    MaxPoint = 71
end
HTool.GetTalentStr = function(table_talent)
    local result = ""
    local first, second, third, name, text, point
    if table_talent[1].p >= table_talent[2].p then
        if table_talent[1].p >= table_talent[3].p then
            first = 1
            if table_talent[2].p >= table_talent[3].p then
                second = 2
                third = 3
            else
                second = 3
                third = 2
            end
        else
            first = 3
            second = 1
            third = 2
        end
    else
        if table_talent[2].p >= table_talent[3].p then
            first = 2
            if table_talent[1].p >= table_talent[3].p then
                second = 1
                third = 3
            else
                second = 3
                third = 1
            end
        else
            first = 3
            second = 2
            third = 1
        end
    end
    if table_talent[first].p * 3 / 4 < table_talent[second].p then
        result = table_talent[first].n .. "/" .. table_talent[second].n
    else
        result = table_talent[first].n
    end
    -- result =
    --     result ..
    --     " |cc8c8c8c8(" ..
    --         HTool.TalentColor(table_talent[1].p, 61) ..
    --             "|cc8c8c8c8/" ..
    --                 HTool.TalentColor(table_talent[2].p, 61) ..
    --                     "|cc8c8c8c8/" .. HTool.TalentColor(table_talent[3].p, 61) .. ")"
    result = result ..
        " |cc8c8c8c8(" ..
        HTool.TalentColor(table_talent[1].p, MaxPoint) ..
        "|cc8c8c8c8/" ..
        HTool.TalentColor(table_talent[2].p, MaxPoint) ..
        "|cc8c8c8c8/" .. HTool.TalentColor(table_talent[3].p, MaxPoint) .. ")"
    return result
end

---------返回值level,solt,needAgain
---------level 装等
---------needAgain 是否需要再次查询,特殊情况下,itemLink的装等信息是错误的，需要再次查询才能成功(例如神器武器，每把武器进入游戏的第一次查询，都无法获的正确link)
HTool.GetItemInfoByItemLink = function(itemLink, nocheck)
    local needAgain = false
    local _, _, quality, level, _, _, _, _, invType, texture = GetItemInfo(itemLink)
    if not nocheck then
        if not texture then
            print("Error:No texture By GetItemInfoByItemLink")
            needAgain = true
        end
        if not level then
            print("Error:No level By GetItemInfoByItemLink")
            needAgain = true
        end
    end
    return level, needAgain, invType == "INVTYPE_2HWEAPON" or invType == "INVTYPE_RANGED" or
        invType == "INVTYPE_RANGEDRIGHT" or invType == "INVTYPE_THROWN";
end

local itemLevelPattern = _G.ITEM_LEVEL:gsub("%%d", "(%%d+)")
HTool.RewardRealItemLevelByInsID = function(unit, index)
    HTool.GameTooltipFrame:SetOwner(WorldFrame, "ANCHOR_NONE")
    HTool.GameTooltipFrame:ClearLines()
    if (HTool.GameTooltipFrame:SetInventoryItem(unit, index)) then
        local itemlevel = nil
        for i = 2, 6 do
            local label, text = _G["zTipGameTooltipFrameTextLeft" .. i], nil
            if label then
                text = label:GetText()
            end
            if text then
                if itemlevel == nil then
                    itemlevel = tonumber(text:match(itemLevelPattern))
                end
            end
        end
        return itemlevel, select(2, HTool.GameTooltipFrame:GetItem())
    end
end
HTool.GetItemInfoByIndex = function(unit, index)
    -- print("Error:No GetItemInfoByIndex");
    local level, itemLink = HTool.RewardRealItemLevelByInsID(unit, index)
    if not itemLink then return end
    local invType = select(9, GetItemInfo(itemLink))
    local isTwoHandWeapon = invType == "INVTYPE_2HWEAPON" or invType == "INVTYPE_RANGED" or
        invType == "INVTYPE_RANGEDRIGHT" or invType == "INVTYPE_THROWN";
    return level, itemLink, isTwoHandWeapon
end

HTool.GetUnit = function(guid)
    if not guid then
        return
    end
    if (UnitGUID("player") == guid) then
        return "player"
    elseif (UnitGUID("mouseover") == guid) then
        return "mouseover"
    elseif (UnitGUID("target") == guid) then
        return "target"
    else
        if IsInGroup() then
            for i = 1, 5 do
                if (UnitGUID("party" .. i) == guid) then
                    return "party" .. i, i + 1
                end
            end
        end
        if IsInRaid() then
            for i = 1, 40 do
                if (UnitGUID("raid" .. i) == guid) then
                    return "raid" .. i, i
                end
            end
        end
    end
end

HTool.GetClassIcon = function(class, size)
    if not class then
        return
    end
    local classiconCoord = CLASS_ICON_TCOORDS[class]
    if classiconCoord then
        local a1, a2, a3, a4 = classiconCoord[1] * 100, classiconCoord[2] * 100, classiconCoord[3] * 100,
            classiconCoord[4] * 100
        local ed
        if size and tonumber(size) < 0 then
            ed = a2 .. ":" .. a1 .. ":" .. a3 .. ":" .. a4 .. "|t "
        else
            ed = a1 .. ":" .. a2 .. ":" .. a3 .. ":" .. a4 .. "|t "
        end
        return "|TInterface\\WorldStateFrame\\Icons-Classes:" ..
            (size or 12) .. ":" .. (size or 12) .. ":0:0:100:100:" .. ed
    end
end
HTool.GetPetClassIcon = function(petType)
    return "|TInterface\\Icons\\Pet_TYPE_" .. PET_TYPE_SUFFIX[petType] .. ":12:12:0:0:10:10:0:10:0:10|t "
end

---内置函数:GetQuestDifficultyColor(level,mode)
HTool.GetDifficultyColor = function(level)
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

local InCombatLockdownRestriction = function(unit) return InCombatLockdown() and not UnitCanAttack("player", unit) end
HTool.CheckCanInspect = function(unit, raidIndex)
    -- if UnitCanAttack("player", unit) then
    --     return false
    -- end                                            --目标不可否攻击(用于排除敌对状态的敌对玩家)

    if not UnitIsVisible(unit) then
        if raidIndex and (GameVer > 90000 and unit:find("party")) then --客户端缓存检测？？(小队除外？？)
            local name, rank, subgroup, level, class, fileName, zone, online, isDead, role = GetRaidRosterInfo(raidIndex)
            if not online then
                return
            else
                --可以观察
            end
        else
            -- -- self:SetState(guid, "不存在")
            -- print("不存在/已离线")
            return
        end
    end
    
    --某些战斗中不允许调用距离检测,为了避免麻烦,直接禁止观察
    --如果什么时候我考虑玩这些有限制的怀旧服,再考虑别的优化方案
    if GameVer < 90000 then                                                             --正式服观察没有距离限制了？？？
        if InCombatLockdownRestriction(unit) or not CheckInteractDistance(unit, 1) then --观察距离判断/注意 貌似某些版本 队友可以无视该距离？
            -- self:SetState(self.CurrentInfo.GUID,"过远")
            return false
        end
    end

    if UnitIsDead("player") then
        return
    end --你死亡
    if UnitOnTaxi("player") then
        return
    end --你在飞机上
    if InspectFrame and InspectFrame:IsShown() then
        return
    end --你正在观察其他单位(如果同时调用观察指令，正在观察的单位信息会变动)

    if not CanInspect(unit) then
        return
    end --可否观察,理论上这个方法应该包括上述所有检测,但是该方法会弹出提示，甚至导致自动下坐骑(待确认)
    return true
end


HTool.GetItemLevelByIndex = function(unit, index)
    local itemLink = GetInventoryItemLink(unit, index) --会因为延迟原因导致这里获取为空
    if itemLink then
        local level, NeedAgain, isTwoHandWeapon = HTool.GetItemInfoByItemLink(itemLink)
        if NeedAgain then
            -- 链接也有了，但是结果还是不对，再来一次（一般是军团神器）
            -- print("zTip:itemLink false")
        end
        return level, isTwoHandWeapon;
    else
        -- print("通过id查询")
        --通过id查询
        local level, _, isTwoHandWeapon = HTool.GetItemInfoByIndex(unit, index)
        if not level then
            -- print("zTip:Index false")
        end
        return level, isTwoHandWeapon;
    end
end
HTool.InventorySlot = {
    -- INVSLOT_AMMO = 0,
    INVSLOT_HEAD     = 1,
    INVSLOT_NECK     = 2,
    INVSLOT_SHOULDER = 3,
    -- INVSLOT_BODY     = 4,
    INVSLOT_CHEST    = 5,
    INVSLOT_WAIST    = 6,
    INVSLOT_LEGS     = 7,
    INVSLOT_FEET     = 8,
    INVSLOT_WRIST    = 9,
    INVSLOT_HAND     = 10,
    INVSLOT_FINGER1  = 11,
    INVSLOT_FINGER2  = 12,
    INVSLOT_TRINKET1 = 13,
    INVSLOT_TRINKET2 = 14,
    INVSLOT_BACK     = 15,
    INVSLOT_MAINHAND = 16,
    INVSLOT_OFFHAND  = 17,
    INVSLOT_RANGED   = 18,
}
if not CharacterRangedSlot then
    HTool.InventorySlot.INVSLOT_RANGED = nil
end


---@return ColorMixin
HTool.UnitColor = function(unitInfo)
    if unitInfo.isTapped or unitInfo.isDead then
        return CreateColor(0.55, 0.55, 0.55)
    elseif unitInfo.IsBattlePet then
        return CreateColor(0.8, 0.5, 0.8)
    elseif unitInfo.isPlayer or UnitPlayerControlled(unitInfo.unit) then
        if (UnitCanAttack(unitInfo.unit, "player")) then
            if (not UnitCanAttack("player", unitInfo.unit)) then --purple, caution, only they can attack
                return CreateColor(1.0, 0.4, 1.0)
            else                                                 -- Hostile players are red
                return CreateColor(1.0, 0.0, 0.0)
            end
        elseif (UnitCanAttack("player", unitInfo.unit)) then
            -- elseif (UnitIsPVP(unit) and not UnitIsPVPSanctuary(unit) and not UnitIsPVPSanctuary("player")) then
            -- -- Players we can assist but are PvP flagged are green
            -- r = 0.0;g = 1.0;b = 0.0
            -- Players we can attack but which are not hostile are yellow
            return CreateColor(1.0, 1.0, 0.0)
        else
            local color = unitInfo.isPlayer and RAID_CLASS_COLORS[select(2, UnitClass(unitInfo.unit))] or
                CreateColor(0.5, 0.5, 1)
            return color
        end
    elseif unitInfo.reaction then
        -- mob/npc
        if unitInfo.reaction < 4 then     -- harm
            return CreateColor(1, 0.3, 0.22)
        elseif unitInfo.reaction > 4 then -- friendly
            return CreateColor(0, 1, 0)
        else                              -- nature
            return CreateColor(1, 1, 0)
        end
    else -- normal
        return CreateColor(1, 1, 1)
    end
end

-- local _temp = GetTalentTabInfo;
-- GetTalentTabInfo = function(...)
--     local _, name, _, texture, points, fileName = _temp(...)
--     return name, texture, points, fileName
-- end
---- wlk 双天赋相关
HTool.TalentMsg = function(group, isInspect)
    local table_talent = {}
    for i = 1, 3 do
        local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = GetTalentTabInfo(i, isInspect, false, group)
        if type(arg1) == "number" then
            table_talent[i] = { n = arg2 or NONE, p = arg5 or 0 }
        elseif type(arg1) == "string" then
            table_talent[i] = { n = arg1 or NONE, p = arg3 or 0 }
        else
            table_talent[i] = { n = NONE, p = 0 }
        end
    end
    return HTool.GetTalentStr(table_talent)
end


HTool.FindLineByTooltips = function(tooltip, ...)
    local result = {}
    for i = tooltip:NumLines(), 3, -1 do
        local line = _G[tooltip:GetName() .. "TextLeft" .. i]
        local text = line:GetText()
        for key, value in pairs({ ... }) do
            if (line.Flag == value) or (text and strfind(text, value)) then
                line.Flag = value
                result[value] = line
            end
        end
    end
    return result
end
HTool.FindLineByTooltip = function(tooltip, str)
    for i = tooltip:NumLines(), 3, -1 do
        local line = _G[tooltip:GetName() .. "TextLeft" .. i]
        local text = line:GetText()
        if (line.Flag == str) or (text and strfind(text, str)) then
            line.Flag = str
            return line
        end
    end
end

---返回unit是否已经改变,同时修改target内的数据
---@param target {guid:string?,msg:string?}
---@return boolean unit是否已经改变
HTool.GetTarget = function(unit, target, isTT)
    local unittarget = unit .. "target"

    local temp_guid = target.guid

    target.guid = UnitGUID(unittarget);


    if temp_guid == target.guid then
        return false
    end

    local tname = UnitName(unittarget) or UNKNOWNOBJECT
    --~ 		local punit = gsub(unit,"target","")
    --~ 		if not (punit~="target" and UnitExists(punit)) then punit = nil end

    local tip = format("|cffFFFF00%s [|r", isTT and "-->" or TARGET) -- '['
    -->>>
    -- 指向我自己
    if UnitIsUnit(unittarget, "player") then
        -- 指向他自己
        tip = format("%s |c00FF0000%s|r", tip, ">> 你 <<")
    elseif unit and UnitIsUnit(unittarget, unit) then
        -- 指向其它玩家
        tip = format("%s |cffFFFFFF%s|r", tip, "自己")
    elseif UnitIsPlayer(unittarget) then
        local _, tmp2 = UnitClass(unittarget)
        if tmp2 then
            if UnitIsEnemy(unittarget, "player") then
                -- red enemy player
                tip = format("%s |cffFF0000%s|r |c%s(%s)|r", tip, tname,
                    RAID_CLASS_COLORS[(tmp2 or "")].colorStr, HTool.GetClassIcon(tmp2, -1) or nil)
            else
                -- white friend player
                tip = format("%s |c%s%s|r |cffFFFFFF(%s)|r", tip, RAID_CLASS_COLORS[(tmp2 or "")].colorStr,
                    tname, HTool.GetClassIcon(tmp2, -1) or nil)
            end
        end
    else
        tip = format("%s |cffFFFFFF%s|r", tip, tname)
    end
    -->>>
    tip = format("%s |cffFFFF00]|r", tip) -- ']'


    target.msg = tip
    return true
end

---@param unitInfo unitInfo
HTool.GetClassificationStrLine = function(unitInfo)
    -- 标志 玩家/稀有
    if not unitInfo.isPlayerControlled then
        local tmp = UnitClassification(unitInfo.unit) -- Elite status
        --if tmp and tmp ~= "normal" and UnitHealth(unit) > 0 then
        if tmp and tmp ~= "normal" then
            if tmp == "elite" then
                return format("|cffFFFF33(%s)|r", ELITE)
            elseif tmp == "worldboss" then
                return format("|cffFF0000(%s)|r", BOSS)
            elseif tmp == "rare" then
                return format("|cffFF66FF(%s)|r", "稀有")
            elseif tmp == "rareelite" then
                return format("|cffFFAAFF(%s%s)|r", "稀有", ELITE)
            else
                return format("(%s)", tmp) -- unknown type
            end
        end
    end
    return ""
end

HTool.GetUnitInfo = function(unit)
    ---@class unitInfo
    local unitInfo = {
        unit = unit,
        isBattlePet = (UnitIsWildBattlePet and (UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit))),
        isPlayerControlled = UnitPlayerControlled(unit),
        isPlayer = UnitIsPlayer(unit),
        isTapped = UnitIsTapDenied(unit),
        reaction = UnitReaction(unit, "player"),
        unitRace = UnitRace(unit),
        isAfk = UnitIsAFK(unit),
        unitCreatureType = UnitCreatureType(unit),
        TitleIcon = ""
    }
    unitInfo.unitClassName, unitInfo.unitClassFlag, unitInfo.unitClassIndex = UnitClass(unit)
    unitInfo.classColor = RAID_CLASS_COLORS[unitInfo.unitClassFlag]
    unitInfo.isDead = (UnitHealth(unit) <= 0 and (not unitInfo.isPlayer or UnitIsDeadOrGhost(unit)))
    unitInfo.level = unitInfo.isBattlePet and UnitBattlePetLevel(unit) or UnitLevel(unit)
    unitInfo.nameColor = HTool.UnitColor(unitInfo)
    unitInfo.petType = unitInfo.isBattlePet and UnitBattlePetType(unit) or nil
    if (unitInfo.petType) then
        unitInfo.TitleIcon = HTool.GetPetClassIcon(unitInfo.petType)
    elseif unitInfo.unitRace and unitInfo.isPlayer then
        unitInfo.TitleIcon = HTool.GetClassIcon(unitInfo.unitClassFlag) or ""
    end
    return unitInfo
end

HTool.GetLevelStrLine = function(unitInfo)
    local prefix = unitInfo.isBattlePet and format(TOOLTIP_WILDBATTLEPET_LEVEL_CLASS, "", "") or ""
    if unitInfo.isDead then
        return format("|cff888888%d %s|r", unitInfo.level > 0 and unitInfo.level or "??", CORPSE)
    else
        if (unitInfo.level > 0) then
            -- Color level number
            if UnitCanAttack("player", unitInfo.unit) or UnitCanAttack(unitInfo.unit, "player") then
                return format("%s%d|r", HTool.GetDifficultyColor(unitInfo.level), unitInfo.level)
            else
                -- normal color
                return format("%s|cff3377CC%d|r", prefix, unitInfo.level)
            end
        else
            -- Target is too high level to tell
            return "|cffFF0000 ??|r"
        end
    end
end


---@param unitInfo unitInfo
HTool.GetClassStrLine = function(unitInfo, classinfo)
    -- 种族, 职业/ creature type/ creature family(pet)
    if unitInfo.unitRace and unitInfo.isPlayer then
        --race, it is a player
        local msg = UnitFactionGroup(unitInfo.unit) == UnitFactionGroup("player") and "00FF33" or "FF3300" -- 敌对阵营种族为暗红
        -- 种族
        msg = format(" |cff%s%s|r", msg, unitInfo.unitRace)

        -- 职业
        if classinfo then
            local spec, class = strsplit(' ', classinfo);
            if class then
                for i = 1, 4, 1 do
                    local _, name, _, icon = GetSpecializationInfoForClassID(unitInfo.unitClassIndex, i)
                    if name == spec then
                        spec = spec .. "|T" .. icon .. ":12:12:0:0:10:10:0:10:0:10|t "
                    end
                end
                msg = msg .. format(" %s |c%s%s|r", spec, unitInfo.classColor.colorStr, unitInfo.unitClassName)
                return msg
            end
        end
        msg = msg .. format(" |c%s%s|r", unitInfo.classColor.colorStr, unitInfo.unitClassName)
        return msg
    elseif unitInfo.isPlayerControlled or unitInfo.isBattlePet then
        --creature family, its is a pet
        if unitInfo.isBattlePet then --判断是否是战斗宠物
            -- petType
            local petTypeName = unitInfo.petType and _G["BATTLE_PET_NAME_" .. unitInfo.petType]
            return format(" %s", petTypeName or "??")
        else --其他宠物/或者被玩家控制的单位
            return format(" %s", (UnitCreatureFamily(unitInfo.unit) or unitInfo.unitCreatureType or ""))
        end
    elseif unitInfo.unitCreatureType then
        -- 类型(种族)
        local msg = format(" |cffFFFFFF%s|r", unitInfo.unitCreatureType)

        -- 职业
        msg = msg .. format(" |c%s%s|r", unitInfo.classColor.colorStr,
            C_CreatureInfo.GetClassInfo(unitInfo.unitClassIndex).className)

        -- 声望
        if unitInfo.reaction and unitInfo.reaction > 0 then
            msg = msg .. format(" %s", HTool.GetUnitFaction(unitInfo.unit, unitInfo.reaction))
        end
        return msg
    else
        return format(" %s", UKNOWNBEING)
    end
end

--返回声望级别
HTool.GetUnitFaction = function(unit, reaction)
    reaction = reaction or UnitReaction(unit, "player")
    if not reaction then
        return ""
    end

    ---为什么要这么复杂，为什么要记录自己的声望列表
    -- if reaction == 7 then
    --     for i = GameTooltip:NumLines(), 3, -1 do
    --         label = _G["GameTooltipTextLeft" .. i]:GetText()
    --         if label and label ~= PVP and self.factions[label] then
    --             reaction = self.factions[label]
    --             break
    --         end
    --     end
    -- end
    local str = GetText("FACTION_STANDING_LABEL" .. reaction, UnitSex("player"))
    if reaction == 5 then
        str = format("|cff33CC33%s|r", str)
    elseif reaction == 6 then
        str = format("|cff33CCCC%s|r", str)
    elseif reaction == 7 then
        str = format("|cffFF6633%s|r", str)
    elseif reaction == 8 then
        str = format("|cffDD33DD%s|r", str)
    elseif reaction == 1 then
        str = format("|cffFF4444%s|r", str)
    elseif reaction == 2 then
        str = format("|cffFF0000%s|r", str)
    elseif reaction == 3 then
        str = format("|cffFF7744%s|r", str)
    elseif reaction == 4 then
        str = format("|cffFFCC00%s|r", str)
    end

    return str
end

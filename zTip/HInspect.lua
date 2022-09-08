--[[
    上官晓雾
    2022-09-06 22:25
    
    修正wlk版本下天赋观察无效的情况
    并添加双天赋支持
]]
local i, _
local GetTalentTabInfo, GetInventoryItemTexture, GetInventoryItemLink = GetTalentTabInfo, GetInventoryItemTexture, GetInventoryItemLink
--暴雪大部分API的查询流程:
--发送查询指令，返回信息并缓存在本地，之后调用其他指令读取缓存信息)
--部分指令只有单个缓存，例如观察目标时候，目标的天赋，成就等
--部分指令会有多个缓存，根据Unit来分别储存，一般是储存队友信息

local GameVer = select(4, GetBuildInfo())
--0.25天缓存,0.5天清除
local CUSTOM_DELAY_FLAG = 21600
local CUSTOM_DELAY_DELETE = 43200
--鼠标停滞目标并且长按shift.5秒后重写查询该目标
local CUSTOM_DELAY_IN_SHIFT = 0.5
--观察操作的强制间隔频率(频率过高会导致服务器停滞相应观察操作)
local CUSTOM_DELAY_INSPECT = 1.5
--INSPECT_READY相应后，立刻使用Get之类的方法获取装备信息会出现nil的情况，需要一点点延迟才能有效（某些装备需要的延迟可能更长，例如7.0神器）
--经过测试，这个参数可以改成0,改成0的实际效果也是0.01(可能是电脑性能决定的)
local CUSTOM_DELAY_NEXT_GEAR = 0.01

local print = function(...)
    if (false) then
        if HDebugPrint then
            HDebugPrint(GetTime(), ...)
        else
            -- print(GetTime(), ...)
        end
    end
end
function LowMixin(object, ...)
    for i = 1, select("#", ...) do
        local mixin = select(i, ...)
        for k, v in pairs(mixin) do
            if (not object[k] and type(object[k]) ~= type(v)) then
                object[k] = v
            end
        end
    end
    return object
end
local InsInfoMsg = {
    Msg = nil,
    -- IsFlag = false,
    DelayTime_Flag = 0,
    DelayTime_Delete = 0,
    StateInfo = nil, --具体:查询中/距离太远/载具中...
    error = 0,
    NeedAgain = false,
    set_IsFlag = function(self, value)
        self._IsFlag = value
        if self._IsFlag then
            self.DelayTime_Flag = time() + CUSTOM_DELAY_FLAG
            self.DelayTime_Delete = time() + CUSTOM_DELAY_DELETE
        end
    end,
    get_IsFlag = function(self)
        if self._IsFlag then
            return self.DelayTime_Flag > time()
        else
            return false
        end
    end,
    Init = function(self, alldelete)
        if alldelete or self.DelayTime_Delete < time() then
            self:Clear()
        end
        setmetatable(
            self,
            {
                __index = function(t, key) --get
                    if rawget(t, "get_" .. key) then
                        return rawget(t, "get_" .. key)(t)
                    end
                    return rawget(t, key)
                end,
                __newindex = function(t, key, value) --set
                    if rawget(t, "set_" .. key) then
                        rawget(t, "set_" .. key)(t, value)
                        return
                    end
                    rawset(t, key, value)
                end
            }
        )
        return self
    end,
    Clear = function(self)
        self.Msg = nil
        self._IsFlag = nil
        self.DelayTime_Flag = 0
        self.DelayTime_Delete = 0
        self.NeedAgain = false
    end
}
local InsInfo = {
    Guid = nil,
    GearInfo = nil,
    SpecInfo = nil,
    Init = function(self, guid)
        self.Guid = guid or self.Guid
        self.GearInfo = self.GearInfo or {}
        self.SpecInfo = self.SpecInfo or {}
        LowMixin(self.GearInfo, InsInfoMsg):Init()
        LowMixin(self.SpecInfo, InsInfoMsg):Init()
        return self
    end
}
--------------------------------HInspectMixin--------------------------------

HInspectMixin = {}

function HInspectMixin:GetInsInfo(guid)
    if not self.cacheUnitDB[guid] then
        self.cacheUnitDB[guid] = CreateFromMixins(InsInfo):Init(guid)
    elseif not self.cacheUnitDB[guid].Init then
        return LowMixin(self.cacheUnitDB[guid], InsInfo):Init()
    end
    return self.cacheUnitDB[guid]
end
function HInspectMixin:Init(cacheData, gear_Str, spec_Str, func)
    self.GearStr = gear_Str and (gear_Str .. " : ") or ("装等" .. " : ")
    if GameVer >= 60000 then
        self.TalentStr = spec_Str and (spec_Str .. " : ") or (SPECIALIZATION .. " : ")
    else
        self.TalentStr = spec_Str and (spec_Str .. " : ") or (TALENT .. " : ")
    end
    self.SetTooltip = func or self.SetTooltip

    self.Lag_Shift = 0
    self.InsLag = CUSTOM_DELAY_INSPECT
    self.cacheUnitDB = cacheData or {}
    self.InventoryInfo = {
        Doing = false,
        LastGuid = nil
    }
    self.CurrentInfo = {
        GUID = nil,
        Unit = nil,
        LastTime = 0
    }

    self:RegisterEvent("UNIT_INVENTORY_CHANGED")
    self:RegisterEvent("INSPECT_READY")
    self.IsHookScript = {}
    self:SetScript("OnUpdate", self.OnInsUpdate)
    self:SetScript(
        "OnEvent",
        function(self, event, ...)
            if event == "UNIT_INVENTORY_CHANGED" then
                self:OnInventoryChanged(...)
            elseif event == "INSPECT_READY" then
                self:OnInspectReady(...)
            end
        end
    )
    hooksecurefunc(
        self,
        "SetScript",
        function(self, script, func)
            if not self.IsHookScript[script] then
                self.IsHookScript[script] = true
                self:HookScript("OnUpdate", self.OnInsUpdate)
                self:HookScript(
                    "OnEvent",
                    function(self, event, ...)
                        if event == "UNIT_INVENTORY_CHANGED" then
                            self:OnInventoryChanged(...)
                        elseif event == "INSPECT_READY" then
                            self:OnInspectReady(...)
                        end
                    end
                )
            end
        end
    )
    GameTooltip:HookScript(
        "OnTooltipSetUnit",
        function(self) --可以考虑全自动，等于单独一个插件？
        end
    )
    GameTooltip:HookScript(
        "OnTooltipCleared",
        function()
            -- print("OnTooltipCleared")
            self:StopInspect()
        end
    )
    self:Hide()
    return self
end
function HInspectMixin:SetAllInitFlag(guid, flag)
    local user = self:GetInsInfo(guid)
    user.GearInfo.IsFlag = flag
    user.SpecInfo.IsFlag = flag
end
function HInspectMixin:SetState(guid, flag)
    local user = self:GetInsInfo(guid)
    print(flag)
    if user.GearInfo.StateInfo == flag and user.SpecInfo.StateInfo == flag then
        self:SetTooltipInspect(guid)
    end
    user.GearInfo.StateInfo = flag
    user.SpecInfo.StateInfo = flag
end

function HInspectMixin:CheckState(guid)
    local user = self:GetInsInfo(guid)
    return user.GearInfo.IsFlag and user.SpecInfo.IsFlag
end

function HInspectMixin:OnInsUpdate(elapsed)
    if not self.CurrentInfo.GUID then
        return
    end
    -- self:SetState(self.CurrentInfo.GUID,"等待延迟")

    if self:CheckState(self.CurrentInfo.GUID) then
        -- print("等待shift长按判断",self.Lag_Shift)
        if not IsShiftKeyDown() then
            self:Hide()
        else
            self.Lag_Shift = self.Lag_Shift - elapsed
            if self.Lag_Shift > 0 then
                return
            else
                print("shift长按.5秒，重写检测:", self.CurrentInfo.GUID)
                self:SetAllInitFlag(self.CurrentInfo.GUID, false)
            end
        end
        return
    else
        -- print("-----------")
        -- print(self.CurrentInfo.GUID == UnitGUID("mouseover"),self.CurrentInfo.GUID ,UnitGUID("mouseover"))
        -- print(self:CheckState(self.CurrentInfo.GUID) )
        -- print("-----------")
    end

    if GetTime() > self.CurrentInfo.LastTime then --观察延迟,1.5秒
        print("OnInsUpdate", self.CurrentInfo.Unit, self.CurrentInfo.GUID)
        self:BeginIns(self.CurrentInfo.Unit, self.CurrentInfo.GUID)
    end
end

function HInspectMixin:BeginIns(...)
    local unit, guid = ...
    if not guid then
        return
    end
    local raidindex = nil
    if not unit or guid ~= UnitGUID(unit) then
        unit, raidindex = HTool.GetUnit(guid)
    else
        _, raidindex = HTool.GetUnit(guid)
    end
    if (not unit) then --客户端缓存检测？？(小队除外？？)
        -- self:SetState(guid,"不存在");
        print("不存在unit")
        return
    end
    if not UnitIsVisible(unit) then
        if raidindex and (GameVer > 90000 and unit:find("party")) then --客户端缓存检测？？(小队除外？？)
            local name, rank, subgroup, level, class, fileName, zone, online, isDead, role = GetRaidRosterInfo(raidindex)
            if not online then
                print("已离线")
                self:StopInspect()
                return
            else
                --可以观察
            end
        else
            -- self:SetState(guid, "不存在")
            print("不存在/已离线")
            self:StopInspect()
            return
        end
    end

    if GameVer < 90000 then
        if not CheckInteractDistance(unit, 1) then
            self:StopInspect()
            return
        end
    end

    -- if UnitIsDeadOrGhost('player') then	self:SetState(guid,"死亡");return end		--你死亡
    if UnitIsDead("player") then
        self:SetState(guid, "你已死亡")
        self:StopInspect()
        return
    end --你死亡
    if UnitOnTaxi("player") then
        self:SetState(guid, "InTaxi")
        self:StopInspect()
        return
    end --你在飞机上
    if InspectFrame and InspectFrame:IsShown() then
        self:SetState(guid, "观察中")
        self:StopInspect()
        return
    end --你正在观察其他单位(如果同时调用观察指令，正在观察的单位信息会变动)

    -- if HDebugPrint then
    --     HDebugPrint(GetTime(), "CanInspect一次")
    -- end

    if not CanInspect(unit) then
        self:SetState(guid, "不可观察")
        self:StopInspect()
        return
    end --可否观察,理论上这个方法应该包括上述所有检测,但是该方法会弹出提示，甚至导致自动下坐骑(待确认)

    self.CurrentInfo.LastTime = GetTime() + self.InsLag
    print(GREEN_FONT_COLOR_CODE .. "BeginIns:OK", self.CurrentInfo.LastTime, self.CurrentInfo.GUID, unit)
    self:StopInspect()
    -- self:SetTooltipInspect(guid);
    NotifyInspect(unit)
end

function HInspectMixin:Inspect(unit, guid)
    print(RED_FONT_COLOR_CODE .. "Inspect New :", unit, guid)
    self.CurrentInfo.GUID = guid or self.CurrentInfo.GUID
    self.CurrentInfo.Unit = unit or self.CurrentInfo.Unit
    self.Lag_Shift = CUSTOM_DELAY_IN_SHIFT
    self:Show()
end
function HInspectMixin:StopInspect()
    if self:IsShown() then
        print("stop ins")
        -- self.CurrentInfo.GUID = nil;
        -- self.CurrentInfo.Unit = nil;
        self:Hide()
    end
end
----UNIT_INVENTORY_CHANGED 事件，表示该目标的外观发生变化，可能存在装备变化/专精天赋变化
----该方法会在切换地图/载入游戏时多次触发,导致卡蓝条
function HInspectMixin:OnInventoryChanged(unit, ...)
    if unit == "player" then
    -- return
    end
    local guid = UnitGUID(unit)
    ----这里可能存在其他根据具体的变动(观察下其他插件在这里的操作，以及该事件的详细信息)
    if guid then
        print(guid, "UNIT_INVENTORY_CHANGED")
        self:SetAllInitFlag(guid, false) --没有生效
    end
end
----INSPECT_READY事件下执行的方法，用于获取目标信息
function HInspectMixin:OnInspectReady(guid)
    print(RED_FONT_COLOR_CODE .. "INSPECT_READY:STAR " .. guid)
    if self.InventoryInfo.Doing then --正在查询上一个目标，所以将上一个目标的状态改成需要再次查询
        print("INSPECT_READY IsDoing:" .. self.InventoryInfo.LastGuid)
        self:SetAllInitFlag(self.InventoryInfo.LastGuid, false)
    end
    self.InventoryInfo.Doing = true
    self.InventoryInfo.LastGuid = guid

    local user = self:GetInsInfo(guid)
    print("INSPECT_READY:DO ", user.SpecInfo.IsFlag, "/", user.GearInfo.IsFlag)
    -- if not user.SpecInfo.IsFlag then     --缓存速度够快，只要ins了，就获取一次
    if GameVer > 20000 then --classic不能观察天赋
        self:ScanInspectSpec(user.Guid, user.SpecInfo)
    end
    -- end

    if not user.GearInfo.IsFlag then
        self:ScanInspectGear(user.Guid, user.GearInfo)
        if user.GearInfo.NeedAgain then
            print("needAgain " .. guid)
            user.GearInfo.NeedAgain = false
            C_Timer.After(
                CUSTOM_DELAY_NEXT_GEAR,
                function()
                    print("Again Scan", guid)
                    self:ScanInspectGear(user.Guid, user.GearInfo)
                    if user.GearInfo.NeedAgain then
                        print(RED_FONT_COLOR_CODE .. "***Again Scan NeedAgain", guid)
                    end
                    user.GearInfo.NeedAgain = false
                    self:SetTooltipInspect(guid)
                end
            )
            if self.CurrentInfo.GUID == guid then
            -- print("needAgain OK "..guid)
            -- self:Inspect(nil,nil);
            end
        end
    end

    self.IsInventorying = false
    self:SetTooltipInspect(guid)
    self.InventoryInfo.Doing = false
    print("INSPECT_READY:END " .. guid)
end

---------装等
function HInspectMixin:ScanInspectGear(guid, info)
    local unit = HTool.GetUnit(guid)
    if not unit then
        print("太快了，unit丢失了")
        return
    end
    info.StateInfo = "查询中"
    info.IsFlag = true
    local total, offhandlevel = 0, 0 --记录副手武器装等,若双持状态，让副手装等=主手
    local hasreclic = false
    if GameVer > 90000 then
        hasreclic = false
    else
        hasreclic = true
    end
    for i = 1, hasreclic and 18 or 17 do --圣物版本18，其他版本17
        if (i ~= 4) then --排除无效
            local level, NeedAgain, itemLink = 0, false, nil
            local itemTexture = GetInventoryItemTexture(unit, i) --用于判断物品是否存在，因为延迟情况，其他Get方法可能会返回nil,但是这个不会/错误，该方法也会放回nil
            if itemTexture then
                if GameVer < 50000 then
                    itemLink = GetInventoryItemLink(unit, i)
                end
                if not itemLink then
                    print("通过id查询")
                    --通过id查询
                    level, itemLink = HTool.GetItemInfoByIndex(unit, i)
                    if not info.NeedAgain and not level then
                        print("zTip:Index false")
                        info.StateInfo = "正在查询"
                        info.NeedAgain = true
                        info.IsFlag = false
                        info.error = info.error + 1
                    end
                    if not level then
                        level = 0
                    end
                else
                    --通过itemlink获取物品等级，拥有浮动物品的等级的版本，不适用
                    level, NeedAgain = HTool.GetItemInfoByItemLink(itemLink)
                    if not info.NeedAgain and NeedAgain then
                        -- 链接也有了，但是结果还是不对，再来一次（一般是军团神器）
                        print("zTip:itemLink false")
                        info.StateInfo = "正在查询"
                        info.NeedAgain = true
                        info.IsFlag = false
                        info.error = info.error + 1
                    end
                    if not level then
                        -- 如果等级有了，那就继续读完
                        -- print("ag:",info.IsFlag,info.needAgain)
                        level = 0
                    end
                end
                if not level or not itemLink then
                    print("没有level???")
                end
                if (i == 16) then
                    local slot = select(9, GetItemInfo(itemLink))
                    --并且16主手使用的是双手武器
                    if (slot == "INVTYPE_2HWEAPON") or (slot == "INVTYPE_RANGED") or ((slot == "INVTYPE_RANGEDRIGHT") and (select(2, UnitClass(unit)) == "HUNTER")) then
                        --使用双手武器中,副手武器装等设置为主手武器装等
                        offhandlevel = level
                    end
                elseif (i == 17) then
                    offhandlevel = 0
                end
                total = total + level
            else
                -- print("GetInventoryItemTexture返回了nil")
                -- info.NeedAgain = true
                -- info.IsFlag = false
            end
            print(itemTexture, itemLink, level, i)
        end
    end
    if not info.NeedAgain then
        if (offhandlevel) then
            total = total + offhandlevel
        end
        print("totalinfo:", total, offhandlevel)
        local ilvl = total / (hasreclic and 17 or 16)
        if (ilvl > 0) then
            ilvl = string.format("%.1f", ilvl)
        end
        info.Msg = ilvl
        if info.Msg and info.Msg ~= 0 then
            info.LastUpdateTime = GetTime()
            info.StateInfo = "查询完成"
        else
            info.StateInfo = "查询失败"
            info.IsFlag = false
        end
    else
        info.StateInfo = "再次"
    end
    print("ag:", info.IsFlag, info.NeedAgain)
end
---- wlk 双天赋相关
local function TalentMsg(group)
    local table_talent = {}
    for i = 1, 3 do
        local name, _, points = GetTalentTabInfo(i, true, false, group)
        print(name, points, i)
        table_talent[i] = {n = name or NONE, p = points or 0}
    end
    return HTool.GetTalentStr(table_talent)
end

---------天赋/专精
function HInspectMixin:ScanInspectSpec(guid, info)
    print("查询天赋:", guid)
    info.StateInfo = "查询中"
    info.IsFlag = true

    if GameVer < 20000 then
        info.Msg = "不支持"
    elseif GameVer >= 20000 and GameVer < 40000 then
        local activeTalentGroup, numTalentGroups = GetActiveTalentGroup(true, false), GetNumTalentGroups(true, false)
        local msgTable = {}
        for i = 1, numTalentGroups do
            msgTable[activeTalentGroup == i and 1 or 2] = TalentMsg(i)
        end
        info.Msg = TALENT_SPEC_PRIMARY .. " : " .. msgTable[1]
        if msgTable[2] then
            info.Msg = info.Msg .. "\r\n" .. TALENT_SPEC_SECONDARY .. " : " .. msgTable[2]
        end
    else
        local unit = HTool.GetUnit(guid)
        if not unit then
            print("太快了，unit丢失了")
            return
        end
        if (unit == "player") then
            local specID = GetSpecialization()
            local specName, _, icon = select(2, GetSpecializationInfo(specID))
            if specName then
                info.Msg = self.TalentStr .. "|T" .. icon .. ":12:12:0:0:10:10:0:10:0:10|t " .. "|cff00ff00[" .. specName .. "]|r"
            else
                info.Msg = "|cff00ff00[" .. NONE .. "]|r"
            end
        else
            local specID = GetInspectSpecialization(unit)
            print(specID)
            local specName, _, icon = select(2, GetSpecializationInfoByID(specID))
            print(specName)
            if specName then
                info.Msg = self.TalentStr .. "|T" .. icon .. ":12:12:0:0:10:10:0:10:0:10|t " .. "|cff00ff00[" .. specName .. "]|r"
            else
                info.Msg = "|cff00ff00[" .. NONE .. "]|r"
            end
        end
    end

    if info.Msg then
        info.StateInfo = "查询完成"
    else
        info.StateInfo = "查询失败"
        info.IsFlag = false
    end
end

function HInspectMixin:SetTooltipInspect(guid, flag)
    local user = self:GetInsInfo(guid)
    local gearstr = user.GearInfo.Msg and (user.GearInfo.Msg .. (user.GearInfo.IsFlag and "" or "*")) or user.GearInfo.StateInfo
    local specstr = user.SpecInfo.Msg and (user.SpecInfo.Msg .. (user.SpecInfo.IsFlag and "" or "*")) or user.SpecInfo.StateInfo

    if self.SetTooltip then
        self.SetTooltip(guid, gearstr, specstr, flag)
    end
end

function HInspectMixin:ScanIns(unit)
    local guid = UnitGUID(unit)
    self:SetTooltipInspect(guid, true)

    if UnitCanAttack("player", unit) then
        return
    end --目标不可否攻击(用于排除敌对状态的敌对玩家)

    if GameVer < 90000 then --正式服观察没有距离限制了？？？
        if not CheckInteractDistance(unit, 1) then --观察距离判断/注意 貌似某些版本 队友可以无视该距离？
            -- self:SetState(self.CurrentInfo.GUID,"过远")
            return
        end
    end

    if IsShiftKeyDown() then
        -- guid.IsFlag = false;
        print("ScanIns: ShiftOn")
    elseif self:CheckState(guid) then
        -- printX(zTipSaves.CacheData[guid])
        return --已有数据，并且没按shift
    else
        print("ScanIns: NoData")
    end

    -- if UnitGUID("player") == guid then

    -- else
    self:Inspect(unit, guid)
    -- end
end

function HInspectMixin:SetTooltip(guid, gear, spec)
    local unit = select(2, GameTooltip:GetUnit())
    if not unit or UnitGUID(unit) ~= guid then
        return
    end
    local gearLine, specLine
    for i = 2, GameTooltip:NumLines() do
        local line = _G["GameTooltipTextLeft" .. i]
        local text = line:GetText()
        if text and strfind(text, self.GearStr) then
            gearLine = line
        elseif text and strfind(text, self.TalentStr) then
            specLine = line
        end
    end
    if gear then
        if gearLine then
            gearLine:SetText(self.GearStr .. gear)
        else
            if specLine then
                specLine:SetText(self.GearStr .. gear)
                specLine = nil
            else
                GameTooltip:AddLine(self.GearStr .. gear)
            end
        end
    end
    if spec then
        if specLine then
            specLine:SetText(spec)
        else
            GameTooltip:AddLine(spec)
        end
    end
    GameTooltip:Show()
end

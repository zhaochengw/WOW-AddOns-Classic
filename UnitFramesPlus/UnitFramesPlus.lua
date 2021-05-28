--变量
local print = print;
local floor = math.floor;
local tonumber = tonumber;
local type = type;
local pairs = pairs;
local UnitName = UnitName;
local IsAddOnLoaded = IsAddOnLoaded;
local GetLocale = GetLocale;
local GetAddOnMetadata = GetAddOnMetadata;
local GetAddOnEnableState = GetAddOnEnableState;
local EnableAddOn = EnableAddOn;
local LoadAddOn = LoadAddOn;
local ReloadUI = ReloadUI;
local InterfaceOptionsFrame_OpenToCategory = InterfaceOptionsFrame_OpenToCategory;
local hooksecurefunc = hooksecurefunc;

--默认设置
UnitFramesPlusDefaultDB = {
    global = {
        movable = 1,        --Shift拖动头像
        indicator = 1,      --头像内战斗信息
        portrait = 1,       --更改头像显示
        portraittype = 1,   --头像类型：1为3D，2为职业图标
        portrait3dbg = 1,   --3D头像背景
        portraitnpcno = 1,  --NPC不显示职业图标
        mouseshow = 0,      --鼠标滑过时才显示数值
        colorhp = 1,        --生命条染色
        colortype = 2,      --生命条染色类型：1职业，2生命值百分比
        -- textunit = 1,    --状态条数值显示为万亿
        builtincd = 1,      --内置冷却计时
        cdtext = 1,         --内置冷却计时数字
        exacthp = 1,        --内置敌人精确生命值
    },

    player = {
        scale = 1,          --玩家头像缩放比例
        dragonborder = 1,   --精英头像
        bordertype = 1,     --精英头像类型：1精英头像，2银英头像，3稀有头像
        extrabar = 1,       --扩展框
        hpmp = 1,           --不显示扩展框时增加生命值和法力值(百分比)显示
        hpmppartone = 1,    --生命值和法力值第一部分：1当前值，2最大值，3損失值，4百分比
        hpmpparttwo = 2,    --生命值和法力值第二部分：1当前值，2最大值，3損失值，4百分比，4不显示
        hpmpunit = 1,       --生命值和法力值进位
        unittype = 2,       --1为千进制(k/m)，2为万进位(万/亿)
        colorhp = 1,        --生命条染色
        colortype = 2,      --生命条染色类型：1职业，2生命值百分比
        movable = 1,        --Shift拖动头像
        indicator = 1,      --头像内战斗信息
        portrait = 1,       --更改头像显示
        portraittype = 1,   --头像类型：1为3D，2为职业图标
        portrait3dbg = 1,   --3D头像背景
        coord = 1,          --坐标
        coordpct = 1,       --副本战场内显示为百分比
        autohide = 0,       --玩家头像自动隐藏
        mouseshow = 0,      --鼠标滑过时才显示数值
        fontsize = 12,      --扩展显示的数字大小
    },

    pet = {
        movable = 0,        --Shift拖动头像
        indicator = 1,      --头像内战斗信息
        target = 0,         --宠物目标
        targettmp = 0,      --宠物目标临时显示
        targetmovable = 0,  --Shift拖动宠物目标头像
        scale = 0.8,        --宠物目标缩放比例
        hppct = 1,          --宠物目标生命值百分比
        mouseshow = 0,      --鼠标滑过时才显示数值
    },

    target = {
        scale = 1,          --目标头像缩放比例
        classicon = 1,      --职业图标
        moreaction = 1,     --职业图标左键观察，右键交易，中键密语，4键跟随
        race = 1,           --种族和类型
        colorhp = 1,        --生命条染色
        colortype = 2,      --生命条染色类型：1职业，2生命值百分比
        indicator = 1,      --头像内战斗信息
        buffsize = 1,       --调节目标buff/debuff图标大小
        mysize = 24,        --自己施放的buff/debuff大小，默认 21
        othersize = 18,     --其他人施放的buff/debuff大小，默认 17，OmniCC默认 18
        movable = 1,        --Shift拖动目标头像
        portrait = 1,       --更改头像显示
        portraittype = 1,   --头像类型：1为3D，2为职业图标
        portrait3dbg = 1,   --3D头像背景
        portraitnpcno = 1,  --NPC不显示职业图标
        mouseshow = 0,      --鼠标滑过时才显示数值
        extrabar = 0,       --扩展框
        bartext = 1,        --目标血条数值
        hpmp = 1,           --不显示扩展框时增加生命值和法力值(百分比)显示
        hpmppartone = 4,    --生命值和法力值第一部分：1当前值，2最大值，3損失值，4百分比
        hpmpparttwo = 5,    --生命值和法力值第二部分：1当前值，2最大值，3損失值，4百分比，5不显示
        hpmpunit = 1,       --生命值和法力值进位
        unittype = 2,       --1为千进制(k/m)，2为万进位(万/亿)
        threat = 1,         --仇恨高亮
        threattext = 1,     --仇恨百分比
        fontsize = 12,      --扩展显示的数字大小
    },

    targettarget = {
        systot = 1,         --在进入游戏时自动关闭系统ToT
        showtot = 1,        --额外的ToT
        showtotot = 1,      --额外的ToToT
        scale = 0.9,        --额外的ToT缩放比例
        colorname = 1,      --额外的ToT职业名字染色
        colornamenpcno = 1, --NPC不显示职业图标
        -- shortname = 1,   --额外的ToT名字服务器显示为(*)
        debuff = 1,         --额外的ToT debuff
        cooldown = 1,       --额外的ToT debuff冷却
        hppct = 1,          --额外的ToT生命值百分比
        movable = 1,        --Shift拖动ToT头像
        portrait = 0,       --更改头像显示
        portraitnpcno = 1,  --NPC不显示职业图标
        enemycheck = 1,     --敌友检测
    },

    party = {
        origin = 1,         --关闭团队风格小队界面
        always = 0,         --团队中显示小队
        level = 1,          --队友等级
        colorname = 1,      --队友名字染色
        shortname = 1,      --队友名字服务器显示为(*)
        bartext = 1,        --队友血条数值
        hp = 1,             --队友生命值
        hppct = 1,          --队友生命值显示为百分比
        movable = 1,        --Shift拖动头像
        portrait = 0,       --更改队友头像
        portraittype = 1,   --头像类型：1为3D，2为职业图标
        portrait3dbg = 1,   --3D头像背景
        onoff = 1,          --队友离线检测
        indicator = 1,      --头像内战斗信息
        buff = 1,           --队友buff
        filter = 1,         --buff filter
        filtertype = 1,     --buff filter选项
        cooldown = 1,       --队友buff冷却
        hidetip = 0,        --隐藏队友buff鼠标提示
        -- castbar = 1,     --队友施法条
        scale = 1,          --队友头像缩放比例
        colorhp = 1,        --生命条染色
        colortype = 1,      --生命条染色类型：1职业，2生命值百分比
        death = 1,          --队友死亡/鬼魂状态
        mouseshow = 0,      --鼠标滑过时才显示数值
        hpmpunit = 1,       --生命值和法力值进位
        unittype = 2,       --1为千进制(k/m)，2为万进位(万/亿)
        hideraid = 0,       --隐藏团队工具
        fontsize = 10,      --扩展显示的数字大小
        pet = 1,            --显示队友宠物
    },

    partytarget = {
        show = 1,           --队友目标
        lite = 0,           --简易模式
        hppct = 1,          --队友目标生命值百分比
        colorname = 1,      --队友目标职业名字染色
        colornamenpcno = 1, --NPC不显示职业图标
        shortname = 1,      --队友目标名字服务器显示为(*)
        debuff = 1,         --队友目标debuff
        cooldown = 1,       --队友目标debuff冷却
        -- highlight = 1,   --队友目标与玩家目标相同时高亮队友目标
        portrait = 0,       --更改头像显示
        portraitnpcno = 1,  --NPC不显示职业图标
        enemycheck = 1,     --敌友检测
    },

    extra = {
        -- bosshppct = 1,   --BOSS生命值百分比
        rangecheck = 1,     --治疗职业距离检测
        instanceonly = 1,   --治疗职业距离检测仅在副本内生效
        -- pvpmouseshow = 0,--PVP鼠标滑过时才显示数值
        -- pvphppct = 1,    --PVP目标生命值百分比
    },

    minimap = {             --地图按钮
        button = 1,
        radius = 78,
        position = 348,
    },
}

UnitFramesPlusDefaultVar = {
    player = {
        moving = 0,         --玩家拖动状态
        moved = 0,          --玩家已被拖动
        x = 0,              --玩家位置
        y = 0,              --玩家位置
    },

    pet = {
        moving = 0,         --玩家宠物拖动状态
        moved = 0,          --玩家宠物已被拖动
        x = 0,              --玩家宠物位置
        y = 0,              --玩家宠物位置
        targetmoving = 0,   --玩家宠物目标拖动状态
        targetmoved = 0,    --玩家宠物目标已被拖动
        targetx = 0,        --玩家宠物目标位置
        targety = 0,        --玩家宠物目标位置
    },

    target = {
        moving = 0,         --目标拖动状态
        moved = 0,          --目标已被拖动
        x = 0,              --目标位置
        y = 0,              --目标位置
    },

    targettarget = {
        moving = 0,         --ToT拖动状态
        moved = 0,          --ToT已被拖动
        x = 0,              --ToT位置
        y = 0,              --ToT位置
    },

    party = {
        moving = 0,         --队友拖动状态
        moved = 0,          --队友已被拖动
        x = 0,              --队友位置
        y = 0,              --队友位置
    },

    rangecheck = {
        enable = 0,         --治疗距离检测
    },

    version = tonumber(GetAddOnMetadata("UnitFramesPlus", "Version")),
    reset = 0,              --重置设置标记
}

--设置初始化
local function UnitFramesPlus_Options_Init()
    if (not UnitFramesPlusDB) then
        UnitFramesPlusDB = UnitFramesPlusDefaultDB;
    end

    if (not UnitFramesPlusVar) then
        UnitFramesPlusVar = UnitFramesPlusDefaultVar;
    end

    if (UnitFramesPlusVar["reset"] == 1) then
        UnitFramesPlusDB = UnitFramesPlusDefaultDB;
        UnitFramesPlusVar = UnitFramesPlusDefaultVar;
        UnitFramesPlusVar["reset"] = 0;
    end

    local Version = tonumber(GetAddOnMetadata("UnitFramesPlus", "Version"));
    if (not UnitFramesPlusVar["version"]) or (UnitFramesPlusVar["version"] ~= Version) then
        local k, v, x, y;
        for k, v in pairs(UnitFramesPlusDefaultDB) do
            if type(v) == "table" then
                for x, y in pairs(UnitFramesPlusDefaultDB[k]) do
                    if not UnitFramesPlusDB[k] then UnitFramesPlusDB[k] = {} end
                    UnitFramesPlusDB[k][x] = UnitFramesPlusDB[k][x] or UnitFramesPlusDefaultDB[k][x];
                end
            else
                UnitFramesPlusDB[k] = UnitFramesPlusDB[k] or UnitFramesPlusDefaultDB[k];
            end
        end
        for k, v in pairs(UnitFramesPlusDefaultVar) do
            if type(v) == "table" then
                for x, y in pairs(UnitFramesPlusDefaultVar[k]) do
                    if not UnitFramesPlusVar[k] then UnitFramesPlusVar[k] = {} end
                    UnitFramesPlusVar[k][x] = UnitFramesPlusVar[k][x] or UnitFramesPlusDefaultVar[k][x];
                end
            else
                UnitFramesPlusVar[k] = UnitFramesPlusVar[k] or UnitFramesPlusDefaultVar[k];
            end
        end
        UnitFramesPlusVar["version"] = UnitFramesPlusDefaultVar["version"];
    end

    -- 检测团队插件
    if IsAddOnLoaded("Blizzard_CompactRaidFrames") then
        UnitFramesPlusDB["party"]["hideraid"] = 0;
    else
        UnitFramesPlusDB["party"]["hideraid"] = 1;
    end
end

--模块初始化
local function UnitFramesPlus_Init()
    if UnitFramesPlus_PlayerInit then
        UnitFramesPlus_PlayerInit();
    end
    if UnitFramesPlus_PetInit then
        UnitFramesPlus_PetInit();
    end
    if UnitFramesPlus_PetTargetInit then
        UnitFramesPlus_PetTargetInit();
    end
    if UnitFramesPlus_TargetInit then
        UnitFramesPlus_TargetInit();
    end
    if UnitFramesPlus_TargetTargetInit then
        UnitFramesPlus_TargetTargetInit();
    end
    if UnitFramesPlus_PartyInit then
        UnitFramesPlus_PartyInit();
    end
    if UnitFramesPlus_PartyTargetInit then
        UnitFramesPlus_PartyTargetInit();
    end
    -- if UnitFramesPlus_PartyCastbarInit then
    --     UnitFramesPlus_PartyCastbarInit();
    -- end
    if UnitFramesPlus_ExtraInit then
        UnitFramesPlus_ExtraInit();
    end
    if UnitFramesPlus_MinimapButtonInit then
        UnitFramesPlus_MinimapButtonInit();
    end
end

local function UnitFramesPlus_CVar()
    if UnitFramesPlus_TargetCvar then
        UnitFramesPlus_TargetCvar();
    end
    if UnitFramesPlus_PartyCvar then
        UnitFramesPlus_PartyCvar();
    end
end

local function UnitFramesPlus_Layout()
    if UnitFramesPlus_PlayerLayout then
        UnitFramesPlus_PlayerLayout();
    end
    if UnitFramesPlus_PetLayout then
        UnitFramesPlus_PetLayout();
    end
    if UnitFramesPlus_PetTargetLayout then
        UnitFramesPlus_PetTargetLayout();
    end
    if UnitFramesPlus_TargetLayout then
        UnitFramesPlus_TargetLayout();
    end
    if UnitFramesPlus_TargetTargetLayout then
        UnitFramesPlus_TargetTargetLayout();
    end
    if UnitFramesPlus_PartyTargetLayout then
        UnitFramesPlus_PartyTargetLayout();
    end
    if UnitFramesPlus_MinimapButtonLayout then
        UnitFramesPlus_MinimapButtonLayout();
    end
end

--退出战斗后再执行
local ufpcbl = {};
function UnitFramesPlus_WaitforCall(func)
    local id = 1;
    while (ufpcbl[id]) do
        if ufpcbl[id].name ~= func.name then
            id = id + 1;
        else
            ufpcbl[id].callback = func.callback;
            return;
        end
    end

    local newfunc = {};
    newfunc.name = func.name;
    newfunc.callback = func.callback;
    ufpcbl[id] = newfunc;
end

--[[--样例
    local func = {};
    func.name = "print";
    func.callback = function() print("test.") end;
    UnitFramesPlus_WaitforCall(func);
--]]

local function UnitFramesPlus_Call()
    local id = 1;
    while (ufpcbl[id]) do
        ufpcbl[id].callback();
        id = id + 1;
    end
    ufpcbl = {};
end

local ufpcb = CreateFrame("Frame");
ufpcb:RegisterEvent("PLAYER_REGEN_ENABLED");
ufpcb:SetScript("OnEvent", function(self, event)
    UnitFramesPlus_Call();
end)

--设置面板载入
local function UnitFramesPlus_LoadOptionPanel()
    if not IsAddOnLoaded("UnitFramesPlus_Options") then
        local playerName = UnitName("player");
        local enabled = GetAddOnEnableState(playerName, "UnitFramesPlus_Options")
        if enabled == 0 then
            EnableAddOn("UnitFramesPlus_Options");
        end
        local loaded = LoadAddOn("UnitFramesPlus_Options");
        if not loaded then
            print(UFPLocal_OptionFailed);
            return false;
        end
    end
end

--命令行
function UnitFramesPlus_SlashHandler(arg)
    if arg == "reset" then
        UnitFramesPlusVar["reset"] = 1;
        ReloadUI();
    end
    local result = UnitFramesPlus_LoadOptionPanel();
    if result == false then return end
    InterfaceOptionsFrame_OpenToCategory(UnitFramesPlus_OptionsFrame);
    InterfaceOptionsFrame_OpenToCategory(UnitFramesPlus_OptionsFrame);
end
SlashCmdList["UnitFramesPlus"] = UnitFramesPlus_SlashHandler;
SLASH_UnitFramesPlus1 = "/unitframesplus";
SLASH_UnitFramesPlus2 = "/ufp";

function UnitFramesPlus_GetRGB(minv, maxv, reverse)
    local r, g, b = 0, 1, 0;
    local pct = floor(100*minv/maxv)/100;
    if pct > 0.5 then
        r = (1.0-pct)*2;
        g = 1.0;
    else
        r = 1.0;
        g = pct*2;
    end
    if r < 0 then r = 0 end
    if g < 0 then g = 0 end
    if r > 1 then r = 1 end
    if g > 1 then g = 1 end
    if reverse and reverse == 1 then 
        return g, r, b;
    else
        return r, g, b;
    end
end

--格式化数值显示
function UnitFramesPlus_GetValueFix(valueCurr, valueMax, valueunit, unittype)
    local valueCurrfix, valueMaxfix, valueLossfix, unitbig, unitsmall;
    local valueLoss = valueMax - valueCurr;
    if valueunit == 0 then
        valueCurrfix = valueCurr;
        valueMaxfix = valueMax;
        valueLossfix = valueLoss;
    elseif valueunit == 1 and unittype == 2 and (GetLocale() == "zhCN" or GetLocale() == "zhTW") then
        if GetLocale() == "zhCN" then
            unitsuper = "兆";
            unitbig = "亿";
            unitsmall = "万";
        elseif GetLocale() == "zhTW" then
            unitsuper = "兆";
            unitbig = "億";
            unitsmall = "萬";
        end
        if valueCurr >= 1000000000000 then
            valueCurrfix = (floor(valueCurr/100000000000)/10)..unitsuper;
        elseif valueCurr >= 100000000 then
            valueCurrfix = (floor(valueCurr/10000000)/10)..unitbig;
        elseif valueCurr >= 10000 then
            valueCurrfix = (floor(valueCurr/1000)/10)..unitsmall;
        else
            valueCurrfix = valueCurr;
        end

        if valueMax >= 1000000000000 then
            valueMaxfix = (floor(valueMax/100000000000)/10)..unitsuper;
        elseif valueMax >= 100000000 then
            valueMaxfix = (floor(valueMax/10000000)/10)..unitbig;
        elseif valueMax >= 10000 then
            valueMaxfix = (floor(valueMax/1000)/10)..unitsmall;
        else
            valueMaxfix = valueMax;
        end

        if valueLoss >= 1000000000000 then
            valueLossfix = (floor(valueLoss/100000000000)/10)..unitsuper;
        elseif valueLoss >= 100000000 then
            valueLossfix = (floor(valueLoss/10000000)/10)..unitbig;
        elseif valueMax >= 10000 then
            valueLossfix = (floor(valueLoss/1000)/10)..unitsmall;
        else
            valueLossfix = valueLoss;
        end
    else
        unitsuper = "G";
        unitbig = "M";
        unitsmall = "K";
        if valueCurr >= 1000000000 then
            valueCurrfix = (floor(valueCurr/100000000)/10)..unitsuper;
        elseif valueCurr >= 1000000 then
            valueCurrfix = (floor(valueCurr/100000)/10)..unitbig;
        elseif valueCurr >= 1000 then
            valueCurrfix = (floor(valueCurr/100)/10)..unitsmall;
        else
            valueCurrfix = valueCurr;
        end

        if valueMax >= 1000000000 then
            valueMaxfix = (floor(valueMax/100000000)/10)..unitsuper;
        elseif valueMax >= 1000000 then
            valueMaxfix = (floor(valueMax/100000)/10)..unitbig;
        elseif valueMax >= 1000 then
            valueMaxfix = (floor(valueMax/100)/10)..unitsmall;
        else
            valueMaxfix = valueMax;
        end

        if valueLoss >= 1000000000 then
            valueLossfix = (floor(valueLoss/100000000)/10)..unitsuper;
        elseif valueLoss >= 1000000 then
            valueLossfix = (floor(valueLoss/100000)/10)..unitbig;
        elseif valueMax >= 1000 then
            valueLossfix = (floor(valueLoss/100)/10)..unitsmall;
        else
            valueLossfix = valueLoss;
        end
    end
    return valueCurrfix, valueMaxfix, valueLossfix;
end

--插件初始化
local ufp = CreateFrame("Frame");
ufp:RegisterEvent("ADDON_LOADED");
ufp:RegisterEvent("VARIABLES_LOADED");
-- ufp:RegisterEvent("PLAYER_LOGIN");
ufp:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...;
        if name == "UnitFramesPlus" then
            UnitFramesPlus_Options_Init();
            UnitFramesPlus_Init();
            ufp:UnregisterEvent("ADDON_LOADED");
            print(UFPLocal_Loaded);

            if TitanPanel_AdjustFrames then
                hooksecurefunc("TitanPanel_AdjustFrames", function()
                    if not InCombatLockdown() then
                        UnitFramesPlus_PlayerPosition();
                        UnitFramesPlus_TargetPosition();
                        UnitFramesPlus_PartyPosition();
                    end
                end);
            end
        end
    elseif event == "VARIABLES_LOADED" then
        UnitFramesPlus_CVar();
        UnitFramesPlus_Layout();
        ufp:UnregisterEvent("VARIABLES_LOADED");
    -- elseif event == "PLAYER_LOGIN" then
    end
end)

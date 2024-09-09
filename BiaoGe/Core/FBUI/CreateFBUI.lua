local _, ns = ...

local Size = ns.Size
local RGB = ns.RGB
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local TongBao = ns.TongBao
local XiaoFei = ns.XiaoFei
local Classpx = ns.Classpx
local WCLpm = ns.WCLpm
local WCLcolor = ns.WCLcolor
local Trade = ns.Trade
local Maxt = ns.Maxt
local Maxb = ns.Maxb
local Maxi = ns.Maxi
local BossNum = ns.BossNum
local FrameHide = ns.FrameHide

local pt = print

BG.zaxiang = {} -- 杂项如果太多，则需要换行

local buttonCount = {}
if BG.IsVanilla_Sod then
    buttonCount.MCsod = { 5, 5, 5, 5, 5, 5, 5, 5, 6, 8, 6, 11, 10, 10, 11, 6, }
    buttonCount.UBRS = { 5, 5, 5, 5, 5, 5, 5, 5, 10, 12, }
    buttonCount.Temple = { 5, 5, 5, 4, 4, 4, 4, 6, 25, 9, }
    BG.zaxiang.Temple = { i = 20 }
    buttonCount.Gno = { 5, 5, 5, 5, 5, 10, 8, 8, }
    buttonCount.BD = { 5, 5, 5, 5, 5, 5, 5, 5, 10, }
elseif BG.IsVanilla_60 then
    buttonCount.MC = { 3, 3, 3, 4, 3, 3, 3, 4, 4, 5, 8, 11, 15, }
    buttonCount.BWL = { 5, 5, 5, 5, 5, 5, 5, 6, 9, 12, }
    buttonCount.ZUG = { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 9, 10, }
    buttonCount.AQL = { 5, 5, 5, 5, 5, 5, 10, 11, }
    buttonCount.TAQ = { 4, 4, 4, 4, 4, 4, 4, 4, 5, 12, 12, }
    buttonCount.NAXX = { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 12, 12, }
elseif BG.IsWLK then
    buttonCount.ICC = { 3, 3, 3, 5, 3, 3, 5, 3, 5, 3, 5, 8, 3, 8, 7, }
    buttonCount.TOC = { 5, 5, 5, 5, 5, 7, 8, 12, 14, }
    buttonCount.ULD = { 4, 3, 3, 4, 5, 3, 3, 4, 4, 4, 4, 4, 6, 4, 8, 5, }
    buttonCount.NAXX = { 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 14, 5, 7, 5, }
elseif BG.IsCTM then
    buttonCount.BOT = { 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 8, 24, 5, }
    BG.zaxiang.BOT = { i = 12 }
end

function BG.GetBossButtonCount(FB, bossNum)
    return buttonCount[FB][bossNum]
end

local function GetMaxScrollGeZi(FB, bossNum)
    if bossNum == Maxb[FB] + 2 then
        return 5
    elseif bossNum == Maxb[FB] + 1 then
        return 20
    elseif bossNum == Maxb[FB]  then
        return 30
    end
end

local function GetFunctionName(frameName)
    if frameName == "Frame" then
        return "FB"
    elseif frameName == "HistoryFrame" then
        return "History"
    elseif frameName == "ReceiveFrame" then
        return "Receive"
    end
end


function BG.CreateFBUI(FB)
    -- 复原之前拆分表格导致的问题
    local wow
    if BG.IsWLK then
        -- BiaoGe.options.SearchHistory["WLKFB240703"] = nil
        -- /run BiaoGe.History.TOC={}
        wow = "WLK"
        BG.Once(wow .. "FB", 240703, function()
            local FB = "NAXX"
            BiaoGe[FB]["boss" .. Maxb[FB] - 1] = {} -- 支出
            BiaoGe[FB]["boss" .. Maxb[FB]] = {}     -- 总览
            for DT in pairs(BiaoGe.History[FB]) do
                for k in pairs(BiaoGe.History[FB][DT]) do
                    for b = 1, Maxb[FB] + 2 do
                        BiaoGe.History[FB][DT]["boss" .. b] = BiaoGe.History[FB][DT]["boss" .. b] or {}
                        BiaoGe.History[FB][DT]["boss" .. Maxb[FB] - 1] = {} -- 支出
                        BiaoGe.History[FB][DT]["boss" .. Maxb[FB]] = {}     -- 总览
                    end
                end
            end
            local FB = "TOC"
            BiaoGe[FB]["boss" .. Maxb[FB]] = {}     -- 支出
            BiaoGe[FB]["boss" .. Maxb[FB] + 1] = {} -- 总览
            for DT in pairs(BiaoGe.History[FB]) do
                for k in pairs(BiaoGe.History[FB][DT]) do
                    for b = 1, Maxb[FB] + 2 do
                        BiaoGe.History[FB][DT]["boss" .. b] = BiaoGe.History[FB][DT]["boss" .. b] or {}
                        BiaoGe.History[FB][DT]["boss" .. Maxb[FB]] = {}     -- 支出
                        BiaoGe.History[FB][DT]["boss" .. Maxb[FB] + 1] = {} -- 总览
                    end
                end
            end
            local FB = "ICC"
            BiaoGe[FB]["boss" .. Maxb[FB]] = {}     -- 支出
            BiaoGe[FB]["boss" .. Maxb[FB] + 1] = {} -- 总览
            for DT in pairs(BiaoGe.History[FB]) do
                for k in pairs(BiaoGe.History[FB][DT]) do
                    for b = 1, Maxb[FB] + 2 do
                        BiaoGe.History[FB][DT]["boss" .. b] = BiaoGe.History[FB][DT]["boss" .. b] or {}
                        BiaoGe.History[FB][DT]["boss" .. Maxb[FB]] = {}     -- 支出
                        BiaoGe.History[FB][DT]["boss" .. Maxb[FB] + 1] = {} -- 总览
                    end
                end
            end

            local tbl = { "OS", "EOE", "OL", "RS" }
            for i, FB in ipairs(tbl) do
                BiaoGe[FB] = nil
                BiaoGe.History[FB] = nil
                BiaoGe.HistoryList[FB] = nil
                BiaoGe.BossFrame[FB] = nil

                for realmID in pairs(BiaoGe.Hope) do
                    for player in pairs(BiaoGe.Hope[realmID]) do
                        for _ in pairs(BiaoGe.Hope[realmID][player]) do
                            BiaoGe.Hope[realmID][player][FB] = nil
                        end
                    end
                end
            end
        end)
    elseif BG.IsVanilla_60 then
        wow = "60"
        BG.Once(wow .. "FB", 240703, function()
            local FB = "MC"
            BiaoGe[FB]["boss" .. Maxb[FB]] = {}     -- 支出
            BiaoGe[FB]["boss" .. Maxb[FB] + 1] = {} -- 总览
            for DT in pairs(BiaoGe.History[FB]) do
                for k in pairs(BiaoGe.History[FB][DT]) do
                    for b = 1, Maxb[FB] + 2 do
                        BiaoGe.History[FB][DT]["boss" .. b] = BiaoGe.History[FB][DT]["boss" .. b] or {}
                        BiaoGe.History[FB][DT]["boss" .. Maxb[FB] - 1] = {} -- 支出
                        BiaoGe.History[FB][DT]["boss" .. Maxb[FB]] = {}     -- 总览
                    end
                end
            end

            -- local tbl = { "BWD", "TOF",  }
            -- for i, FB in ipairs(tbl) do
            --     BiaoGe[FB] = nil
            --     BiaoGe.History[FB] = nil
            --     BiaoGe.HistoryList[FB] = nil
            --     BiaoGe.BossFrame[FB] = nil
            --     for realmID in pairs(BiaoGe.Hope) do
            --         for player in pairs(BiaoGe.Hope[realmID]) do
            --             for _ in pairs(BiaoGe.Hope[realmID][player]) do
            --                 BiaoGe.Hope[realmID][player][FB] = nil
            --             end
            --         end
            --     end
            -- end
        end)
    elseif BG.IsCTM then
        wow = "CTM"
        BG.Once(wow .. "FB", 240703, function()
            local FB = "BOT"
            BiaoGe[FB]["boss" .. 8] = {} -- 支出
            BiaoGe[FB]["boss" .. 9] = {} -- 总览
            for DT in pairs(BiaoGe.History[FB]) do
                for k in pairs(BiaoGe.History[FB][DT]) do
                    for b = 1, Maxb[FB] + 2 do
                        BiaoGe.History[FB][DT]["boss" .. b] = BiaoGe.History[FB][DT]["boss" .. b] or {}
                        BiaoGe.History[FB][DT]["boss" .. 8] = {} -- 支出
                        BiaoGe.History[FB][DT]["boss" .. 9] = {} -- 总览
                    end
                end
            end

            local FB = "OL"
            BiaoGe[FB] = nil
            BiaoGe.History[FB] = nil
            BiaoGe.HistoryList[FB] = nil
            BiaoGe.BossFrame[FB] = nil
            for realmID in pairs(BiaoGe.Hope) do
                for player in pairs(BiaoGe.Hope[realmID]) do
                    for _ in pairs(BiaoGe.Hope[realmID][player]) do
                        BiaoGe.Hope[realmID][player][FB] = nil
                    end
                end
            end
        end)
    end

    if not buttonCount[FB] then return end
    if FB == "ULD" then
        tinsert(buttonCount[FB], 5) -- 设置支出格子为x个
    else
        tinsert(buttonCount[FB], 8) -- 设置支出格子为x个
    end
    tinsert(buttonCount[FB], 5) -- 设置总览工资格子为x个


    -- 正常格子
    for t = 1, Maxt[FB] do
        BG.FBBiaoTiUI(FB, t)
        BG.HistoryBiaoTiUI(FB, t)
        BG.ReceiveBiaoTiUI(FB, t)

        local _, bb = BossNum(FB, 0, t)
        for b = 1, bb do
            if BossNum(FB, b, t) > Maxb[FB] - 1 then
                break
            end
            local ii = buttonCount[FB][BossNum(FB, b, t)]
            for i = 1, ii do
                BG.FBZhuangBeiUI(FB, t, b, bb, i, ii)
                BG.HistoryZhuangBeiUI(FB, t, b, bb, i, ii)
                BG.ReceiveZhuangBeiUI(FB, t, b, bb, i, ii)

                BG.FBMaiJiaUI(FB, t, b, bb, i, ii)
                BG.HistoryMaiJiaUI(FB, t, b, bb, i, ii)
                BG.ReceiveMaiJiaUI(FB, t, b, bb, i, ii)

                BG.FBJinEUI(FB, t, b, bb, i, ii)
                BG.HistoryJinEUI(FB, t, b, bb, i, ii)
                BG.ReceiveJinEUI(FB, t, b, bb, i, ii)

                BG.FBDiSeUI(FB, t, b, bb, i, ii)
                BG.HistoryDiSeUI(FB, t, b, bb, i, ii)
                BG.ReceiveDiSeUI(FB, t, b, bb, i, ii)
            end


            BG.FBBossNameUI(FB, t, b, bb, nil, ii)
            BG.HistoryBossNameUI(FB, t, b, bb, nil, ii)
            BG.ReceiveBossNameUI(FB, t, b, bb, nil, ii)

            BG.FBJiShaUI(FB, t, b, bb, nil, ii)
            BG.HistoryJiShaUI(FB, t, b, bb, nil, ii)
            BG.ReceiveJiShaUI(FB, t, b, bb, nil, ii)
        end

        -- 对账
        for b = 1, bb do
            if BossNum(FB, b, t) > Maxb[FB] + 1 then
                break
            end

            local ii = buttonCount[FB][BossNum(FB, b, t)]
            for i = 1, ii do
                BG.DuiZhangBiaoTiUI(FB, t, b, bb, i, ii)
                if BossNum(FB, b, t) <= Maxb[FB] then
                    BG.DuiZhangZhuangBeiUI(FB, t, b, bb, i, ii)
                    BG.DuiZhangMyJinEUI(FB, t, b, bb, i, ii)
                    BG.DuiZhangOtherJinEUI(FB, t, b, bb, i, ii)
                    BG.DuiZhangDiSeUI(FB, t, b, bb, i, ii)
                end
            end

            if BossNum(FB, b, t) == Maxb[FB] + 1 then
                local ii = 2
                for i = 1, ii do
                    BG.DuiZhangZhuangBeiUI(FB, t, b, bb, i, ii)
                    BG.DuiZhangMyJinEUI(FB, t, b, bb, i, ii)
                    BG.DuiZhangOtherJinEUI(FB, t, b, bb, i, ii)
                    BG.DuiZhangDiSeUI(FB, t, b, bb, i, ii)
                end
            end
            BG.DuiZhangBossNameUI(FB, t, b, bb, nil, ii)
        end
    end

    -- 滚动框
    local frameTbl = { "Frame", "HistoryFrame", "ReceiveFrame" }
    for i, frameName in ipairs(frameTbl) do
        for bossNum = Maxb[FB], Maxb[FB] + 2 do
            BG.CreateFBScrollFrame(frameName, FB, bossNum)

            local t, b = BG.GetBossNumInfo(FB, bossNum)
            local ii = GetMaxScrollGeZi(FB, bossNum)
            for i = 1, ii do
                BG[GetFunctionName(frameName) .. "ZhuangBeiUI"](FB, t, b, nil, i, ii, BG[frameName .. FB]["scrollFrame" .. bossNum])
                BG[GetFunctionName(frameName) .. "MaiJiaUI"](FB, t, b, nil, i, ii)
                BG[GetFunctionName(frameName) .. "JinEUI"](FB, t, b, nil, i, ii)
                BG[GetFunctionName(frameName) .. "DiSeUI"](FB, t, b, nil, i, ii)
            end
            BG[GetFunctionName(frameName) .. "BossNameUI"](FB, t, b, nil, i, ii, frameName)
        end
    end


    BG.FBZhiChuZongLanGongZiUI(FB)
    BG.HistoryZhiChuZongLanGongZiUI(FB)
    BG.ReceiveZhiChuZongLanGongZiUI(FB)
end

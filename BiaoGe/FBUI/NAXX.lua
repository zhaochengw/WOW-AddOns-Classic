local _, ADDONSELF = ...

local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local Sumjine = ADDONSELF.Sumjine
local SumZC = ADDONSELF.SumZC
local SumJ = ADDONSELF.SumJ
local SumGZ = ADDONSELF.SumGZ
local TongBao = ADDONSELF.TongBao
local XiaoFei = ADDONSELF.XiaoFei
local Classpx = ADDONSELF.Classpx
local WCLpm = ADDONSELF.WCLpm
local WCLcolor = ADDONSELF.WCLcolor
local Trade = ADDONSELF.Trade
local Listzhuangbei = ADDONSELF.Listzhuangbei
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local Listjine = ADDONSELF.Listjine
local BossNum = ADDONSELF.BossNum
local FrameHide = ADDONSELF.FrameHide

local pt = print

local FB = FB
local p = {}
local preWidget
local framedown
local frameright
local red,greed,blue = 1,1,1
local touming1,touming2 = 0.2,0.4

function BG.NAXXUI(FB)

    for t=1,4 do

        local bb
        if t == 1 then
            bb = 6      -- 第1列boss有6个
        elseif t == 2 then
            bb = 6     -- 每2列boss有6个
        elseif t == 3 then
            bb = 4      -- 每3列boss有4个
        else
            bb = 8
        end
        -- pt(bb)
        for b=1,bb do

            if t == 4 and b == 6 then       -- 第4列第6个boss就不再创建
                break
            end

            local ii
            if BossNum(FB,b,t) == 14 or BossNum(FB,b,t) == 15 or BossNum(FB,b,t) == 18 or BossNum(FB,b,t) == 19 then
                ii = 6
            elseif BossNum(FB,b,t) == 16 then
                ii = Maxi[FB]
            else
                ii = 5
            end
            for i=1,ii do
                BG.FBBiaoTiUI(FB,t,b,bb,i,ii)
                BG.HistoryBiaoTiUI(FB,t,b,bb,i,ii)
                BG.ReceiveBiaoTiUI(FB,t,b,bb,i,ii)

                BG.FBDiSsUI(FB,t,b,bb,i,ii)
                BG.HistoryDiSsUI(FB,t,b,bb,i,ii)
                BG.ReceiveDiSsUI(FB,t,b,bb,i,ii)

                BG.FBZhuangBeiUI(FB,t,b,bb,i,ii)
                BG.HistoryZhuangBeiUI(FB,t,b,bb,i,ii)
                BG.ReceiveZhuangBeiUI(FB,t,b,bb,i,ii)

                BG.FBGuanZhuUI(FB,t,b,bb,i,ii)

                BG.FBMaiJiaUI(FB,t,b,bb,i,ii)
                BG.HistoryMaiJiaUI(FB,t,b,bb,i,ii)
                BG.ReceiveMaiJiaUI(FB,t,b,bb,i,ii)
                
                BG.FBJinEUI(FB,t,b,bb,i,ii)
                BG.HistoryJinEUI(FB,t,b,bb,i,ii)
                BG.ReceiveJinEUI(FB,t,b,bb,i,ii)

                BG.FBQianKuanUI(FB,t,b,bb,i,ii)
            end
            BG.FBBossNameUI(FB,t,b,bb,i,ii)
            BG.HistoryBossNameUI(FB,t,b,bb,i,ii)
            BG.ReceiveBossNameUI(FB,t,b,bb,i,ii)

            BG.FBJiShaUI(FB,t,b,bb,i,ii)
            BG.HistoryJiShaUI(FB,t,b,bb,i,ii)
            BG.ReceiveJiShaUI(FB,t,b,bb,i,ii)
        end
    end
    BG.FBZhiChuZongLanGongZiUI(FB)
    BG.HistoryZhiChuZongLanGongZiUI(FB)
    BG.ReceiveZhiChuZongLanGongZiUI(FB)

end
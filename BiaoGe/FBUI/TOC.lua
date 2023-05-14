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

local p = {}
local preWidget
local framedown
local frameright
local red,greed,blue = 1,1,1
local touming1,touming2 = 0.2,0.4

function BG.TOCUI(FB)

    for t=1,3 do

        local bb
        if t == 2 then
            bb = 3      -- 第二列boss有3个
        else
            bb = 5      -- 第一列boss有5个
        end
        for b=1,bb do

            if t == 3 and b == 4 then       -- 第三列第四个boss就不再创建
                break
            end

            local ii
            if BossNum(FB,b,t) == 6 or BossNum(FB,b,t) == 7 then      -- 第6、7个boss有10个格子
                ii = 10
            elseif BossNum(FB,b,t) == 9 then      -- 第9个boss有15个格子
                    ii = Maxi[FB]
            else 
                ii = 5      -- 其他boss是5个格子
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
    
    -- BOSS模型
    do
        local model = CreateFrame("PlayerModel", nil, BG["Frame"..FB])
        model:SetWidth(200)
        model:SetHeight(250)
        model:SetPoint("TOP", BG.Frame[FB].boss5.zhuangbei1, "TOPLEFT", -15, 70)
        model:SetFrameLevel(101)
        model:SetAlpha(0.5)
        model:SetPortraitZoom(-0.2)
        model:SetDisplayInfo(29268)
        model:SetHitRectInsets(50,70,60,100)

        local time = GetTime()
        local c = 1
        local s = 1
        local ss = {16234,16235,16236,16237,16238}
        model:SetScript("OnMouseUp",function ()
            if c == 1 then
                PlaySound(ss[s],"Master")
                if s == #ss then
                    s = 1
                else
                    s = s +1
                end
                time = GetTime()
                c = 2
            elseif GetTime() - time >= 4 then
                PlaySound(ss[s],"Master")
                if s == #ss then
                    s = 1
                else
                    s = s +1
                end
                time = GetTime()
            end
        end)
    end
end
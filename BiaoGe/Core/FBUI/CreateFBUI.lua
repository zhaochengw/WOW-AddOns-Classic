local _, ns = ...
if BG.IsBlackListPlayer then return end

local Size = ns.Size
local RGB = ns.RGB
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local Classpx = ns.Classpx
local Trade = ns.Trade
local Maxt = ns.Maxt
local Maxb = ns.Maxb
local BossNum = ns.BossNum

local pt = print

local function GetFrameName(type)
    if type == "FB" then
        return "Frame"
    elseif type == "History" then
        return "HistoryFrame"
    elseif type == "Receive" then
        return "ReceiveFrame"
    end
end

-- 滚动框
function BG.CreateFBScrollFrame(frameName, FB, bossNum)
    local _, b = BG.GetBossNumInfo(FB, bossNum)
    local pointFrame, pointX, pointY
    if b == 1 then
        if BG.zaxiang[FB] and bossNum == Maxb[FB] then
            pointFrame = BG[frameName][FB]["boss" .. bossNum - 1]["zhuangbei" .. BG.GetMaxi(FB, bossNum - 1, true)]
            pointX, pointY = -5, -20
        else
            pointFrame = BG[frameName].p["preWidget" .. 0]
            pointX, pointY = -5, -3
        end
    elseif BG[frameName .. FB]["scrollFrame" .. bossNum - 1] then
        pointFrame = BG[frameName .. FB]["scrollFrame" .. bossNum - 1].owner
        pointX, pointY = 0, -18
    else
        pointFrame = BG[frameName][FB]["boss" .. bossNum - 1]["zhuangbei" .. BG.GetMaxi(FB, bossNum - 1, true)]
        pointX, pointY = -5, -20
    end

    local parent = BG[frameName .. FB]
    local scroll = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate") -- 滚动
    scroll:SetWidth(350)
    scroll:SetHeight(BG.GetMaxi(FB, bossNum, true) * (20 + (BG.IsBigFB(FB) and 0 or 3)))
    scroll:SetPoint("TOPLEFT", pointFrame, "BOTTOMLEFT", pointX, pointY)
    BG.CreateSrollBarBackdrop(scroll.ScrollBar)
    BG.HookScrollBarShowOrHide(scroll)

    local child = CreateFrame("Frame", nil, scroll) -- 子框架
    child:SetSize(1, 1)
    child.owner = scroll
    scroll:SetScrollChild(child)
    BG[frameName .. FB]["scrollFrame" .. bossNum] = child
    if bossNum == Maxb[FB] + 2 then
        scroll.ScrollBar:Hide()
    end
end

function BG.CreateFBUI(FB, type)
    if BG[FB..type.."IsRoadUI"] then return end
    BG[FB .. type .. "IsRoadUI"]=true
    if type == "FB" then
        -- 对账
        for t = 1, Maxt[FB] do
            local _, bb = BossNum(FB, 0, t)
            for b = 1, bb do
                if BossNum(FB, b, t) > Maxb[FB] + 1 then
                    break
                end

                local ii = BG.GetMaxi(FB, BossNum(FB, b, t))
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
    end

    -- 正常格子
    for t = 1, Maxt[FB] do
        BG[type .. "TitleUI"](FB, t)
        local _, bb = BossNum(FB, 0, t)
        for b = 1, bb do
            if BossNum(FB, b, t) > Maxb[FB] - 1 then
                break
            end
            local ii = BG.GetMaxi(FB, BossNum(FB, b, t))
            for i = 1, ii do
                BG[type .. "ZhuangBeiUI"](FB, t, b, bb, i, ii)
                BG[type .. "MaiJiaUI"](FB, t, b, bb, i, ii)
                BG[type .. "JinEUI"](FB, t, b, bb, i, ii)
                BG[type .. "DiSeUI"](FB, t, b, bb, i, ii)
            end
            BG[type .. "BossNameUI"](FB, t, b, bb, nil, ii)
            BG[type .. "JiShaUI"](FB, t, b, bb, nil, ii)
        end
    end

    -- 滚动框
    for bossNum = Maxb[FB], Maxb[FB] + 2 do
        BG.CreateFBScrollFrame(GetFrameName(type), FB, bossNum)
        local t, b = BG.GetBossNumInfo(FB, bossNum)
        local ii = BG.GetMaxi(FB, bossNum)
        for i = 1, ii do
            BG[type .. "ZhuangBeiUI"](FB, t, b, nil, i, ii, BG[GetFrameName(type) .. FB]["scrollFrame" .. bossNum])
            BG[type .. "MaiJiaUI"](FB, t, b, nil, i, ii)
            BG[type .. "JinEUI"](FB, t, b, nil, i, ii)
            BG[type .. "DiSeUI"](FB, t, b, nil, i, ii)
        end
        BG[type .. "BossNameUI"](FB, t, b, nil, nil, nil, GetFrameName(type))
    end

    BG[type .. "ZhiChuZongLanGongZiUI"](FB)
end

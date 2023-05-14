local _, ADDONSELF = ...

local Size = ADDONSELF.Size
local RGB = ADDONSELF.RGB
local RGB_16 = ADDONSELF.RGB_16
local GetClassRGB = ADDONSELF.GetClassRGB
local SetClassCFF = ADDONSELF.SetClassCFF
local FrameDongHua = ADDONSELF.FrameDongHua
local FrameHide = ADDONSELF.FrameHide

local Width = ADDONSELF.Width
local Height = ADDONSELF.Height
local Maxb = ADDONSELF.Maxb
local Maxi = ADDONSELF.Maxi
local HopeMaxn = ADDONSELF.HopeMaxn
local HopeMaxb = ADDONSELF.HopeMaxb
local HopeMaxi = ADDONSELF.HopeMaxi

local pt = print

local function BiaoGeUI()

    BG.Ver = "v1.2.6"
    ------------------主界面------------------
    do
        BG.MainFrame = CreateFrame("Frame", "BG.MainFrame", UIParent, "BasicFrameTemplate")
        BG.MainFrame:SetWidth(Width["BG.MainFrame"])
        BG.MainFrame:SetHeight(Height["BG.MainFrame"])
        BG.MainFrame:SetFrameStrata("HIGH")
        BG.MainFrame:SetPoint("CENTER")
        BG.MainFrame:SetFrameLevel(100)
        BG.MainFrame:SetMovable(true)
        BG.MainFrame:SetScript("OnMouseUp", function(self)
            self:StopMovingOrSizing()
        end)
        BG.MainFrame:SetScript("OnMouseDown", function(self)
            FrameHide(0)
            self:StartMoving()
        end)
        BG.MainFrame:SetScript("OnShow", function(self)
        end)
        tinsert(UISpecialFrames, "BG.MainFrame")     -- 按ESC可关闭插件        

        local TitleText = BG.MainFrame:CreateFontString()
        TitleText:SetPoint("TOP", BG.MainFrame, "TOP", 0, -4)
        TitleText:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")
        TitleText:SetText("|cff".."00BFFF".."< BiaoGe > 金 团 表 格")
        TitleText:Show()
        BG.Title = TitleText

        -- 说明书
        local frame = CreateFrame("Frame",nil,BG.MainFrame)
        frame:SetSize(250, 30)
        frame:SetPoint("TOPLEFT", BG.MainFrame, "TOPLEFT", 5, 4)
        frame:SetHitRectInsets(0,50,0,0)
        local fontString = frame:CreateFontString()
        fontString:SetAllPoints()
        fontString:SetFont(STANDARD_TEXT_FONT,15,"OUTLINE")
        fontString:SetJustifyH("LEFT")
        fontString:SetText("<说明书与更新记录> "..BG.STC_g1(BG.Ver))
        fontString:Show()
        BG.ShuoMingShu = frame
        BG.ShuoMingShuText = fontString
        local text = "|cffFFFFFF< 我是说明书 >|r\n\n1、金团表格命令：|cff00BFFF/biaoge 或 /gbg|r，团减助手命令：|cff00BFFF/rbg|r。可以做成宏，方便打开。或者点小地图图标（星星）也行\n2、按Tab可横跳光标，按Enter可下跳光标，点空白处可取消光标，右键输入框可清除内容\n3、SHIFT+点击装备可把装备发到聊天框。相反点聊天里的装备也可添加到表格\n4、ALT+点击装备可关注装备，团长拍卖此装备时会提醒\n5、CTRL+点击装备可通报历史价格，这个功能需要你的历史表格曾记录过该装备的金额\n6、当团长贴出装备开始拍卖时，会自动高亮表格里相应的装备\n\n刚学做插件，做得不好请见谅。\nBUG可反馈到：buick_hbj@163.com\n\n|cff00BFFF< 主要更新记录 >|r\n\n"
        text = text.."|cff00FF005月11日更新1.2.6版本|r\n1、增加功能：团减助手（打开命令：/rbg。按钮在表格界面右边）\n    便于团长安排团减技能的顺序，还有一些团队BUFF的分配\n2、现在交易双方都给出装备时，但其中一方有输入金额，也可以记账成功\n    （像买了套装需要退货散件的情况，一次交易就可以完成了）\n3、记账效果预览框现在可移动位置\n4、修复过滤装备的一些BUG\n5、修复查询心愿竞争的一些BUG\n\n"
        text = text.."|cff00FF005月4日更新1.2.5版本|r\n1、增加功能：导出表格。把表格导出为文本\n2、进本的清空表格提醒现在变大了一点\n3、修复查看团本进度的一些BUG\n\n"
        text = text.."|cff00FF004月30日更新1.2.4版本|r\n1、增加功能：查看团本进度。能看到全部角色的CD情况\n2、猎人的过滤装备现在会过滤力量和精准的装备\n3、修复BUG：奶骑/奶萨的过滤装备会错误地把奶盾也过滤掉\n4、修复一个老BUG：掉线有时没有保存数据到本地\n\n"
        text = text.."|cff00FF004月26日更新1.2.3版本|r\n1、增加功能：过滤装备。过滤掉表格里不适合你的装备。例如物理DPS会过滤加法伤、加防等的装备\n2、增加功能：记账效果预览。如果这次的交易记账可能失败（例如表格里没有该装备），你可以手动选择记账到哪个BOSS\n3、修复分钱人数不能写0.5、修复欠款通报失效\n\n"
        text = text.."|cff00FF004月22日更新1.2.2版本|r\n1、增加功能：分享当前表格/历史表格，类似发WA那样。你可以把你的表格发给别人，别人可以接收你的表格并保存起来\n2、增加功能：应用历史表格到当前表格。因为历史表格是不能再次编辑的，如果你需要重新编辑某个历史表格，可以使用该功能\n3、增加功能：通报历史价格（CTRL+点击装备）\n4、现在交易多件装备时，不再显示记账失败，而是会记录匹配成功的第一件装备到表格\n5、杂项的装备下拉列表里增加[深渊水晶]和[符文宝珠]\n\n"
        frame:SetScript("OnEnter",function (self)
            GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT",-250*BiaoGe.Scale,0)
            GameTooltip:ClearLines()
            GameTooltip:SetText(text)
        end)
        frame:SetScript("OnLeave",function (self)
            GameTooltip:Hide()
        end)

        -- 副本选择初始化
        if BiaoGe.FB then
            BG.FB1 = BiaoGe.FB
        else
            BG.FB1 = "ULD"
            BiaoGe.FB = BG.FB1
        end
        BG.MainFrame:SetHeight(Height[BG.FB1])
        BG.MainFrame:SetWidth(Width[BG.FB1])
    end
    ------------------接收表格主界面------------------
    do
        BG.ReceiveMainFrame = CreateFrame("Frame", "BG.ReceiveFrame", UIParent, "BackdropTemplate")
        BG.ReceiveMainFrame:SetBackdrop({
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            -- edgeFile = "	interface/friendsframe/ui-toast-border",
            -- edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 30
        })
        BG.ReceiveMainFrame:SetBackdropBorderColor(RGB("00BFFF"))
        BG.ReceiveMainFrame:SetWidth(Width["BG.MainFrame"])
        BG.ReceiveMainFrame:SetHeight(Height["BG.MainFrame"]-20)
        BG.ReceiveMainFrame:SetFrameStrata("DIALOG")
        BG.ReceiveMainFrame:SetPoint("CENTER")
        BG.ReceiveMainFrame:SetFrameLevel(100)
        BG.ReceiveMainFrame:SetScale(0.9)
        BG.ReceiveMainFrame:SetMovable(true)
        BG.ReceiveMainFrame:SetScript("OnMouseUp", function(self)
            self:StopMovingOrSizing()
        end)
        BG.ReceiveMainFrame:SetScript("OnMouseDown", function(self)
            FrameHide(0)
            self:StartMoving()
        end)
        tinsert(UISpecialFrames, "BG.ReceiveFrame")     -- 按ESC可关闭插件

        local t = BG.ReceiveMainFrame:CreateTexture(nil, "BACKGROUND")
        t:SetColorTexture(0,0,0,0.9)
        t:SetPoint("TOPLEFT",BG.ReceiveMainFrame,"TOPLEFT",5,-5)
        t:SetPoint("BOTTOMRIGHT",BG.ReceiveMainFrame,"BOTTOMRIGHT",-5,5)

        BG.ReceiveMainFrame.CloseButton = CreateFrame("Button",nil,BG.ReceiveMainFrame,"UIPanelCloseButton")
        BG.ReceiveMainFrame.CloseButton:SetPoint("TOPRIGHT",BG.ReceiveMainFrame,"TOPRIGHT",0,0)
        BG.ReceiveMainFrame.CloseButton:SetSize(40,40)

        local TitleText = BG.ReceiveMainFrame:CreateFontString()
        TitleText:SetPoint("TOP", BG.ReceiveMainFrame, "TOP", 0, -10)
        TitleText:SetFont(STANDARD_TEXT_FONT,16,"OUTLINE")
        TitleText:SetText("哈哈哈")
        TitleText:Show()
        BG.ReceiveMainFrameTitle = TitleText

        local bt = CreateFrame("Button",nil,BG.ReceiveMainFrame,"UIPanelButtonTemplate")
        bt:SetSize(120, 30)
        bt:SetPoint("BOTTOM",BG.ReceiveMainFrame,"BOTTOM",0,30)
        bt:SetText("保存至历史表格")
        bt:Show()
        -- 单击触发
        bt:SetScript("OnClick", function(self)
            local FB = BG.ReceiveBiaoGe.FB
            local DT = BG.ReceiveBiaoGe.DT
            local BiaoTi = BG.ReceiveBiaoGe.BiaoTi
            for key, value in pairs(BiaoGe.History[FB]) do
                if tonumber(DT) == key then
                    BG.ReceiveMainFrametext:SetText(BG.STC_r1("该表格已在你历史表格里"))
                    return
                end
            end

            BiaoGe.History[FB][DT] = {}
            for b=1,Maxb[FB]+2 do
                BiaoGe.History[FB][DT]["boss"..b] = {}
                for i=1,Maxi[FB] do
                    if BG.Frame[FB]["boss"..b]["zhuangbei"..i] then
                        BiaoGe.History[FB][DT]["boss"..b]["zhuangbei"..i] = BG.ReceiveBiaoGe["boss"..b]["zhuangbei"..i]
                        BiaoGe.History[FB][DT]["boss"..b]["maijia"..i] = BG.ReceiveBiaoGe["boss"..b]["maijia"..i]
                        BiaoGe.History[FB][DT]["boss"..b]["color"..i] = {BG.ReceiveBiaoGe["boss"..b]["color"..i][1],BG.ReceiveBiaoGe["boss"..b]["color"..i][2],BG.ReceiveBiaoGe["boss"..b]["color"..i][3]}
                        BiaoGe.History[FB][DT]["boss"..b]["jine"..i] = BG.ReceiveBiaoGe["boss"..b]["jine"..i]
                    end
                end
                if BG.Frame[FB]["boss"..b]["time"] then
                    BiaoGe.History[FB][DT]["boss"..b]["time"] = BG.ReceiveBiaoGe["boss"..b]["time"]
                end
            end
            local d = {DT,BiaoTi}
            table.insert(BiaoGe.HistoryList[FB],1,d)
            BG.History.HistoryButton:SetText("历史表格（共"..#BiaoGe.HistoryList[FB].."个）")
            BG.CreatHistoryListButton(FB)
            BG.ReceiveMainFrametext:SetText(BG.STC_b1("已保存至历史表格1"))

            PlaySoundFile(BG.sound2,"Master")
        end)

        local text = BG.ReceiveMainFrame:CreateFontString()
        text:SetPoint("LEFT", bt, "RIGHT", 10, 0)
        text:SetFont(STANDARD_TEXT_FONT,16,"OUTLINE")
        text:Show()
        BG.ReceiveMainFrametext = text
    end
    ------------------设置------------------
    do
        local bt = CreateFrame("Button", nil, BG.MainFrame, "UIPanelButtonTemplate")
        bt:SetSize(100, 25)
        bt:SetPoint("BOTTOMRIGHT", BG.MainFrame, "BOTTOMRIGHT", -40, 30)
        bt:SetText("设置")
        bt:Show()
        BG.ButtonSheZhi = bt

        local f = CreateFrame("Frame",nil,BG.ButtonSheZhi,"BackdropTemplate")
        f:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16
        })
        f:SetBackdropColor(0,0,0.1,1)
        f:SetSize(155, 260)
        f:SetPoint("CENTER",nil,"CENTER",0,0)
        -- f:SetFrameStrata("HIGH")
        f:SetFrameLevel(121)
        f:Hide()
        BG.FrameSheZhi = f
        f:SetScript("OnMouseUp", function(self)
        end)

        bt:SetScript("OnClick", function(self)
            BG.FrameSheZhi:ClearAllPoints()
            BG.FrameSheZhi:SetPoint("BOTTOMLEFT",BG.ButtonSheZhi,"TOPLEFT")
            if BG.FrameSheZhi and not BG.FrameSheZhi:IsVisible() then
                BG.FrameSheZhi:Show()
            else
                BG.FrameSheZhi:Hide()
            end
            PlaySound(BG.sound1,"Master")
        end)
    end
    ------------------难度选择菜单------------------
    do
        local nandu 
        local nanduID
        C_Timer.After(1,function ()
            nanduID = GetRaidDifficultyID()
            if nanduID == 3 or nanduID == 175 then
                nandu = "10人|cff00BFFF普通|r"
            elseif nanduID == 4 or nanduID == 176 then
                nandu = "25人|cff00BFFF普通|r"
            elseif nanduID == 5 or nanduID == 193 then
                nandu = "10人|cffFF0000英雄|r"
            elseif nanduID == 6 or nanduID == 194 then
                nandu = "25人|cffFF0000英雄|r"
            end
            -- pt(GetRaidDifficultyID())
        end)
        BG.NanDuDropDown = {}
        local dropDown = CreateFrame("Frame", nil, BG.MainFrame, "UIDropDownMenuTemplate")
        dropDown:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT",220,23)
        UIDropDownMenu_SetWidth(dropDown, 95)
        C_Timer.After(1,function ()
            UIDropDownMenu_SetText(dropDown, nandu)
        end)
        BG.NanDuDropDown.DropDown = dropDown
        local text = dropDown:CreateFontString()
        text:SetPoint("RIGHT", dropDown, "LEFT",10,3)
        text:SetFontObject(GameFontNormal)
        text:SetText("当前难度:")
        text:Show()
        BG.NanDuDropDown.BiaoTi = text
        UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
            FrameHide(0)
            PlaySound(BG.sound1,"Master")
            local info = UIDropDownMenu_CreateInfo()
                info.text, info.func = "10人|cff00BFFF普通|r", function ()
                    SetRaidDifficultyID(3)
                    FrameHide(0)
                    PlaySound(12880,"Master")        -- 冰霜灵气的声音
                end 
            UIDropDownMenu_AddButton(info)
            local info = UIDropDownMenu_CreateInfo()
                info.text, info.func = "25人|cff00BFFF普通|r", function ()
                    SetRaidDifficultyID(4)
                    FrameHide(0)
                    PlaySound(12880,"Master")        -- 冰霜灵气的声音
                end 
                UIDropDownMenu_AddButton(info)
            local info = UIDropDownMenu_CreateInfo()
                info.text, info.func = "10人|cffFF0000英雄|r", function ()
                    SetRaidDifficultyID(5)
                    FrameHide(0)
                    PlaySound(12873,"Master")        -- 鲜血灵气的声音
                end 
                UIDropDownMenu_AddButton(info)
            local info = UIDropDownMenu_CreateInfo()
                info.text, info.func = "25人|cffFF0000英雄|r", function ()
                    SetRaidDifficultyID(6)
                    FrameHide(0)
                    PlaySound(12873,"Master")        -- 鲜血灵气的声音
                end 
                UIDropDownMenu_AddButton(info)
        end)
        local f=CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_SYSTEM")
        f:SetScript("OnEvent", function(self,even,text,...)
            if string.find(text,"团队副本难度设置为") then
                local nandu 
                local nanduID = GetRaidDifficultyID()
                if nanduID == 3 or nanduID == 175 then
                    nandu = "10人|cff00BFFF普通|r"
                elseif nanduID == 4 or nanduID == 176 then
                    nandu = "25人|cff00BFFF普通|r"
                elseif nanduID == 5 or nanduID == 193 then
                    nandu = "10人|cffFF0000英雄|r"
                elseif nanduID == 6 or nanduID == 194 then
                    nandu = "25人|cffFF0000英雄|r"
                end
                UIDropDownMenu_SetText(dropDown, nandu)
            end
        end)
    end
    ------------------副本切换按钮------------------
    do
        -- 窗口
        do
            BG.FrameNAXX = CreateFrame("Frame", "BG.FrameNAXX", BG.MainFrame)   -- 当前表格
            BG.FrameULD = CreateFrame("Frame", "BG.FrameULD", BG.MainFrame)
            BG.FrameTOC = CreateFrame("Frame", "BG.FrameTOC", BG.MainFrame)
            BG.FrameICC = CreateFrame("Frame", "BG.FrameICC", BG.MainFrame)

            BG.FrameNAXX:Hide()
            BG.FrameULD:Hide()
            BG.FrameTOC:Hide()
            BG.FrameICC:Hide()

            BG.HopeFrameNAXX = CreateFrame("Frame", "BG.HopeFrameNAXX", BG.MainFrame)   -- 心愿清单
            BG.HopeFrameULD = CreateFrame("Frame", "BG.HopeFrameULD", BG.MainFrame)
            BG.HopeFrameTOC = CreateFrame("Frame", "BG.HopeFrameTOC", BG.MainFrame)
            BG.HopeFrameICC = CreateFrame("Frame", "BG.HopeFrameICC", BG.MainFrame)

            BG.HopeFrameNAXX:Hide()
            BG.HopeFrameULD:Hide()
            BG.HopeFrameTOC:Hide()
            BG.HopeFrameICC:Hide()

            BG.HistoryFrameNAXX = CreateFrame("Frame", "BG.HistoryFrameNAXX", BG.MainFrame)   -- 历史表格
            BG.HistoryFrameULD = CreateFrame("Frame", "BG.HistoryFrameULD", BG.MainFrame)
            BG.HistoryFrameTOC = CreateFrame("Frame", "BG.HistoryFrameTOC", BG.MainFrame)
            BG.HistoryFrameICC = CreateFrame("Frame", "BG.HistoryFrameICC", BG.MainFrame)

            BG.HistoryFrameNAXX:Hide()
            BG.HistoryFrameULD:Hide()
            BG.HistoryFrameTOC:Hide()
            BG.HistoryFrameICC:Hide()

            BG.ReceiveFrameNAXX = CreateFrame("Frame", "BG.ReceiveFrameNAXX", BG.ReceiveMainFrame)   -- 接收表格
            BG.ReceiveFrameULD = CreateFrame("Frame", "BG.ReceiveFrameULD", BG.ReceiveMainFrame)
            BG.ReceiveFrameTOC = CreateFrame("Frame", "BG.ReceiveFrameTOC", BG.ReceiveMainFrame)
            BG.ReceiveFrameICC = CreateFrame("Frame", "BG.ReceiveFrameICC", BG.ReceiveMainFrame)

            BG.ReceiveFrameNAXX:Hide()
            BG.ReceiveFrameULD:Hide()
            BG.ReceiveFrameTOC:Hide()
            BG.ReceiveFrameICC:Hide()
        end

        -- 按钮
        do
            local w = 60
            local h = 32
            local bt = CreateFrame("Button", nil, BG.MainFrame, "UIPanelButtonTemplate")
            bt:SetSize(w,h)
            bt:SetPoint("TOPLEFT", BG.MainFrame, "TOPRIGHT", -8, -50)
            bt:SetFrameStrata("HIGH")
            bt:SetFrameLevel(95)
            bt:SetText("ICC")
            local fb = bt   -- 创建后续按钮对齐用
            BG.ButtonICC = bt

            local bt = CreateFrame("Button", nil, BG.MainFrame, "UIPanelButtonTemplate")
            bt:SetSize(w,h)
            bt:SetPoint("TOP", fb, "BOTTOM", 0, -3)
            bt:SetFrameStrata("HIGH")
            bt:SetFrameLevel(95)
            bt:SetText("TOC")
            local fb = bt
            BG.ButtonTOC = bt

            local bt = CreateFrame("Button", nil, BG.MainFrame, "UIPanelButtonTemplate")
            bt:SetSize(w,h)
            bt:SetPoint("TOP", fb, "BOTTOM", 0, -3)
            bt:SetFrameStrata("HIGH")
            bt:SetFrameLevel(95)
            bt:SetText("ULD")
            local fb = bt
            BG.ButtonULD = bt

            local bt = CreateFrame("Button", nil, BG.MainFrame, "UIPanelButtonTemplate")
            bt:SetSize(w,h)
            bt:SetPoint("TOP", fb, "BOTTOM", 0, -3)
            bt:SetFrameStrata("HIGH")
            bt:SetFrameLevel(95)
            bt:SetText("NAXX")
            local fb = bt
            BG.ButtonNAXX = bt
        end

        -- 副本切换单击触发
        do
            BG.ButtonICC:SetScript("OnClick", function(self)       -- ICC
                FrameHide(0)
                if BG["Frame"..BG.FB1] and BG["Frame"..BG.FB1]:IsVisible() then
                    BG.FrameICC:Show()
                    BG.FrameTOC:Hide()
                    BG.FrameULD:Hide()
                    BG.FrameNAXX:Hide()
                else
                    BG.HopeFrameICC:Show()
                    BG.HopeFrameTOC:Hide()
                    BG.HopeFrameULD:Hide()
                    BG.HopeFrameNAXX:Hide()
                end

                BG.ButtonICC:SetEnabled(false)
                BG.ButtonTOC:SetEnabled(false)
                BG.ButtonULD:SetEnabled(false)
                BG.ButtonNAXX:SetEnabled(false)
                C_Timer.After(0.5,function ()
                    BG.ButtonTOC:SetEnabled(true)
                    BG.ButtonULD:SetEnabled(true)
                    BG.ButtonNAXX:SetEnabled(true)
                end)
                BG.FB1 = "ICC"
                BiaoGe.FB = BG.FB1
                BG.History.HistoryButton:SetText("历史表格（共"..#BiaoGe.HistoryList[BG.FB1].."个）")
                BG.CreatHistoryListButton(BG.FB1)
                FrameDongHua(BG.MainFrame,Height[BG.FB1],Width[BG.FB1])

                BG.FBfilter()

                PlaySound(BG.sound1,"Master")
            end)

            BG.ButtonTOC:SetScript("OnClick", function(self)       -- TOC
                FrameHide(0)
                if BG["Frame"..BG.FB1] and BG["Frame"..BG.FB1]:IsVisible() then
                    BG.FrameICC:Hide()
                    BG.FrameTOC:Show()
                    BG.FrameULD:Hide()
                    BG.FrameNAXX:Hide()
                else
                    BG.HopeFrameICC:Hide()
                    BG.HopeFrameTOC:Show()
                    BG.HopeFrameULD:Hide()
                    BG.HopeFrameNAXX:Hide()
                end
                BG.ButtonICC:SetEnabled(false)
                BG.ButtonTOC:SetEnabled(false)
                BG.ButtonULD:SetEnabled(false)
                BG.ButtonNAXX:SetEnabled(false)
                C_Timer.After(0.5,function ()
                    BG.ButtonICC:SetEnabled(true)
                    BG.ButtonULD:SetEnabled(true)
                    BG.ButtonNAXX:SetEnabled(true)
                end)
                BG.FB1 = "TOC"
                BiaoGe.FB = BG.FB1
                BG.History.HistoryButton:SetText("历史表格（共"..#BiaoGe.HistoryList[BG.FB1].."个）")
                BG.CreatHistoryListButton(BG.FB1)
                FrameDongHua(BG.MainFrame,Height[BG.FB1],Width[BG.FB1],BG.Frame[BG.FB1],Maxb[BG.FB1],Maxi[BG.FB1])

                BG.FBfilter()

                PlaySound(BG.sound1,"Master")
            end)

            BG.ButtonULD:SetScript("OnClick", function(self)       -- ULD
                FrameHide(0)
                if BG["Frame"..BG.FB1] and BG["Frame"..BG.FB1]:IsVisible() then
                    BG.FrameICC:Hide()
                    BG.FrameTOC:Hide()
                    BG.FrameULD:Show()
                    BG.FrameNAXX:Hide()
                else
                    BG.HopeFrameICC:Hide()
                    BG.HopeFrameTOC:Hide()
                    BG.HopeFrameULD:Show()
                    BG.HopeFrameNAXX:Hide()
                end
                BG.ButtonICC:SetEnabled(false)
                BG.ButtonTOC:SetEnabled(false)
                BG.ButtonULD:SetEnabled(false)
                BG.ButtonNAXX:SetEnabled(false)
                C_Timer.After(0.5,function ()
                    BG.ButtonICC:SetEnabled(true)
                    BG.ButtonTOC:SetEnabled(true)
                    BG.ButtonNAXX:SetEnabled(true)
                end)
                BG.FB1 = "ULD"
                BiaoGe.FB = BG.FB1
                BG.History.HistoryButton:SetText("历史表格（共"..#BiaoGe.HistoryList[BG.FB1].."个）")
                BG.CreatHistoryListButton(BG.FB1)
                FrameDongHua(BG.MainFrame,Height[BG.FB1],Width[BG.FB1],BG.Frame[BG.FB1],Maxb[BG.FB1],Maxi[BG.FB1])
                
                BG.FBfilter()
                
                PlaySound(BG.sound1,"Master")
            end)

            BG.ButtonNAXX:SetScript("OnClick", function(self)       -- NAXX
                FrameHide(0)
                if BG["Frame"..BG.FB1] and BG["Frame"..BG.FB1]:IsVisible() then
                    BG.FrameICC:Hide()
                    BG.FrameTOC:Hide()
                    BG.FrameULD:Hide()
                    BG.FrameNAXX:Show()
                else
                    BG.HopeFrameICC:Hide()
                    BG.HopeFrameTOC:Hide()
                    BG.HopeFrameULD:Hide()
                    BG.HopeFrameNAXX:Show()
                end
                BG.ButtonICC:SetEnabled(false)
                BG.ButtonTOC:SetEnabled(false)
                BG.ButtonULD:SetEnabled(false)
                BG.ButtonNAXX:SetEnabled(false)
                C_Timer.After(0.5,function ()
                    BG.ButtonICC:SetEnabled(true)
                    BG.ButtonTOC:SetEnabled(true)
                    BG.ButtonULD:SetEnabled(true)
                end)
                BG.FB1 = "NAXX"
                BiaoGe.FB = BG.FB1
                BG.History.HistoryButton:SetText("历史表格（共"..#BiaoGe.HistoryList[BG.FB1].."个）")
                BG.CreatHistoryListButton(BG.FB1)
                FrameDongHua(BG.MainFrame,Height[BG.FB1],Width[BG.FB1],BG.Frame[BG.FB1],Maxb[BG.FB1],Maxi[BG.FB1])
                
                BG.FBfilter()
                
                PlaySound(BG.sound1,"Master")
            end)
        end
    end
    ------------------团减助手按钮------------------
    do
        local bt = CreateFrame("Button", nil, BG.MainFrame, "UIPanelButtonTemplate")
        bt:SetSize(55,50)
        bt:SetPoint("TOP", BG.ButtonNAXX, "BOTTOM", 0, -50)
        bt:SetFrameStrata("HIGH")
        bt:SetFrameLevel(95)
        bt:SetText("团减\n助手")
        BG.ButtonHelper = bt
        bt:SetScript("OnClick", function(self)
            if BG.helperFrame and not BG.helperFrame:IsVisible() then
                BG.MainFrame:Hide()
                BG.helperFrame:Show()
            else
                BG.helperFrame:Hide()
            end
        end)

    end
    ------------------心愿清单按钮------------------
    do
        local bt = CreateFrame("Button", nil, BG.MainFrame, "UIPanelButtonTemplate")
        bt:SetSize(100, 25)
        bt:SetPoint("BOTTOMRIGHT", BG.MainFrame, "BOTTOMRIGHT", -200, 30)
        -- bt:SetText("心愿清单")
        bt:Show()
        bt:SetFrameLevel(105)
        BG.ButtonHope = bt

        local bt0 = CreateFrame("Button", nil, bt)
        bt0:SetSize(130, 35)
        bt0:SetPoint("CENTER")
        bt0:SetFrameLevel(102)
        BG.ButtonHope0 = bt0

        local texture = bt0:CreateTexture(nil, "BACKGROUND") -- 高亮材质
        texture:SetAllPoints()
        texture:SetTexture("Interface/ChatFrame/UI-ChatIcon-BlinkHilight")

        bt:SetScript("OnClick", function(self)
            FrameHide(0)
            if BG["Frame"..BG.FB1] and not BG["Frame"..BG.FB1]:IsVisible() then
                BG["HopeFrame"..BG.FB1]:Hide()
                BG["Frame"..BG.FB1]:Show()
                bt:SetText("心愿清单")
                BG.ButtonQingKong:SetText("清空当前表格")
                BiaoGe.HopeShow = false

                BG.History.HistoryButton:SetEnabled(true)
                BG.History.SaveButton:SetEnabled(true)
                BG.History.SendButton:SetEnabled(true)
                BG.ButtonWenBen:SetEnabled(true)
            else
                BG["Frame"..BG.FB1]:Hide()
                BG["HopeFrame"..BG.FB1]:Show()
                bt:SetText("关闭心愿清单")
                BG.ButtonQingKong:SetText("清空当前心愿")
                BiaoGe.HopeShow = true

                BG.History.HistoryButton:SetEnabled(false)
                BG.History.SaveButton:SetEnabled(false)
                BG.History.SendButton:SetEnabled(false)
                BG.ButtonWenBen:SetEnabled(false)
            end
            PlaySound(BG.sound1,"Master")
        end)
    end
    ------------------定时获取当前副本名称------------------
    do
        -- 获取当前副本
        local FBtable = {
            ["纳克萨玛斯"]="NAXX",
            ["黑曜石圣殿"]="NAXX",
            ["永恒之眼"]="NAXX",
            ["奥杜尔"]="ULD",
            ["十字军的试炼"]="TOC",
            ["奥妮克希亚的巢穴"]="TOC",
            ["冰冠堡垒"]="ICC",
            ["红玉圣殿"]="ICC"
        }

        local lastzone
        C_Timer.NewTicker(5, function() -- 每5秒执行一次
            if BG.DeBug then
                return
            end
            local fb = GetInstanceInfo()  -- 获取副本名称
            local _,type = IsInInstance()
            if type ~= "raid" then
                BG.FB2 = nil
            else
                for index, value in pairs(FBtable) do  -- 把中文的副本名称转换为英文简写名称
                    if fb == index then
                        BG.FB2 = value
                        break
                    else
                        BG.FB2 = nil
                    end
                end
                if lastzone ~= fb then
                    if BG.FB2 then
                        if BG.JinBenQingKong.Button then
                        BG.JinBenQingKong.Button:SetText("要清空表格<"..BG.FB2..">吗？")
                        BG.JinBenQingKong.Button:Show()
                        BG.JinBenQingKong.DongHua:SetWidth(BG.JinBenQingKong.Button:GetWidth())
                        BG.ButtonDongHua(BG.JinBenQingKong.DongHua)
                        end
                    end
                end
            end
            -- pt(fb,type,BG.FB2)
            -- pt(lastzone,fb)
            lastzone = fb
        end)
    end
    ------------------获取团队物品分配者------------------
    do
        if IsInRaid() then
            for i=1,GetNumGroupMembers() do
                local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(i)
                if isML then
                    BG.MasterLooter = GetUnitName("raid"..i)
                    break
                end
                BG.MasterLooter = nil
            end
        else
            BG.MasterLooter = nil
        end
        -- pt(BG.MasterLooter)
        local f=CreateFrame("Frame")
        -- f:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
        f:RegisterEvent("GROUP_ROSTER_UPDATE")
        f:SetScript("OnEvent", function(self,even,...)
            if IsInRaid() then
                for i=1,GetNumGroupMembers() do
                    local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(i)
                    if isML then
                        BG.MasterLooter = GetUnitName("raid"..i)
                        break
                    end
                    BG.MasterLooter = nil
                end
            else
                BG.MasterLooter = nil
            end
            -- pt(BG.MasterLooter)
        end)
    end
    ------------------团本进度------------------
    do
        if not BiaoGe.FBCD then
            BiaoGe.FBCD = {}
        end
        BG.FBCDtext = ""
        local lastresettime
        local lastservertime

        local bt = CreateFrame("Button",nil,BG.MainFrame)
        bt:SetSize(80, 30)
        bt:SetPoint("LEFT", BG.ShuoMingShu, "RIGHT", 10, 0)
        bt:SetNormalFontObject(BG.FontGreen1)
        bt:SetDisabledFontObject(BG.FontDisabled)
        bt:SetHighlightFontObject(BG.FontHilight)
        bt:SetText("团本进度")
        BG.ButtonFBCD = bt

        bt:SetScript("OnEnter",function (self)
            GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT",-80*BiaoGe.Scale,0)
            GameTooltip:ClearLines()
            BG.GetFBCD()
            if BG.FBCDtext == "" then
                GameTooltip:SetText("无")
            else
                GameTooltip:SetText(BG.FBCDtext)
                BG.FBCDtext = ""
            end
        end)
        bt:SetScript("OnLeave",function (self)
            GameTooltip:Hide()
        end)

        function BG.GetFBCD()
            -- if InCombatLockdown() then
            --     BG.FBCDtext = "战斗结束后显示"
            --     return
            -- end
            local name,server = UnitFullName("player")
            local colorname = SetClassCFF(name)
            local playername = name.."-"..server
            local colorplayername = colorname.."-"..server
            local servertime = GetServerTime()
            local num = GetNumSavedInstances()
            if num then
                BiaoGe.FBCD[playername] = {}
                local n = 1
                local text = ""
                for i=1,num do
                    local name, lockoutId, resettime, difficultyId, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress, extendDisabled, instanceId = GetSavedInstanceInfo(i)
                    if not lastresettime then
                        lastresettime = resettime
                        lastservertime = servertime
                    end
                    if tonumber(resettime) == tonumber(lastresettime) then
                        resettime = lastresettime - (servertime - lastservertime)
                    else
                        lastresettime = resettime
                        lastservertime = servertime
                    end

                    if isRaid then
                        local nandu = ""
                        if difficultyId == 3 or difficultyId == 175 then
                            nandu = "|cffFFFFFF10人|r|cff00BFFF普通|r"
                            nandu = "|cffFFFFFF10人普通|r"
                        elseif difficultyId == 4 or difficultyId == 176 then
                            nandu = "|cffFFFFFF25人|r|cff00BFFF普通|r"
                            nandu = "|cffFFFFFF25人普通|r"
                        elseif difficultyId == 5 or difficultyId == 193 then
                            nandu = "|cffFFFFFF10人|r|cffFF0000英雄|r"
                            nandu = "|cffFFFFFF10人英雄|r"
                        elseif difficultyId == 6 or difficultyId == 194 then
                            nandu = "|cffFFFFFF25人|r|cffFF0000英雄|r"
                            nandu = "|cffFFFFFF25人英雄|r"
                        end
                        local FBname = BG.STC_b1(name).."-"..nandu
                        BiaoGe.FBCD[playername][n] = {
                            playername = colorplayername,
                            FBname = FBname,
                            resettime = resettime,
                            endtime = resettime+servertime
                        }
                        text = text.."    "..FBname.."："..SecondsToTime(resettime, true, nil, 2).."\n"  -- 奥杜尔-10人普通：3天22小时
                        n = n + 1
                    end
                end
                if text ~= "" then
                    text = SetClassCFF(colorplayername).."\n"..text  -- 风行-鱼人\n奥杜尔-10人普通：3天22小时
                end
                BG.FBCDtext = text
            end

            for p, value in pairs(BiaoGe.FBCD) do  -- BiaoGe.FBCD.风行-鱼人
                if p ~= playername then
                    local yes

                    for i, value2 in ipairs(BiaoGe.FBCD[p]) do  -- BiaoGe.FBCD.风行-鱼人.1
                        if servertime >= BiaoGe.FBCD[p][i].endtime then
                            BiaoGe.FBCD[p][i] = nil
                        elseif servertime < BiaoGe.FBCD[p][i].endtime then
                            BiaoGe.FBCD[p][i].resettime = BiaoGe.FBCD[p][i].endtime - servertime
                            yes =true
                        end
                    end
                    if not yes then
                        BiaoGe.FBCD[p] = nil
                    end
                    if BiaoGe.FBCD[p] then
                        local text = ""
                        local playername = ""
                        for i, value2 in ipairs(BiaoGe.FBCD[p]) do  -- BiaoGe.FBCD.风行-鱼人.1
                            local FBname = BiaoGe.FBCD[p][i].FBname
                            local reset = BiaoGe.FBCD[p][i].resettime
                            playername = BiaoGe.FBCD[p][i].playername
                            text = text.."    "..FBname.."："..SecondsToTime(reset, true, nil, 2).."\n"  -- 奥杜尔-10人普通：3天22小时
                        end
                        if text ~= "" and playername ~= "" then
                            text = "\n"..playername.."\n"..text  -- 风行-鱼人\n奥杜尔-10人普通：3天22小时
                        end
                        BG.FBCDtext = BG.FBCDtext..text
                    end
                end
            end
        end
    end
    ------------------导出为文本------------------
    do
        BG.frameWenBen = {}
        local f = CreateFrame("Frame", nil, BG.MainFrame, "BasicFrameTemplate")
        f:SetWidth(350)
        f:SetHeight(650)
        f.TitleText:SetText("导出表格")
        f:SetFrameStrata("DIALOG")
        f:SetFrameLevel(300)
        f:SetPoint("CENTER")
        f:EnableMouse(true)
        f:SetMovable(true)
        f:Hide()
        f:SetScript("OnMouseUp", function(self)
            self:StopMovingOrSizing()
        end)
        f:SetScript("OnMouseDown", function(self)
            self:StartMoving()
        end)
        BG.frameWenBen.frame = f

        local edit = CreateFrame("EditBox", nil, BG.frameWenBen.frame)
        edit:SetWidth(BG.frameWenBen.frame:GetWidth()-27)
        edit:SetHeight(BG.frameWenBen.frame:GetHeight())
        edit:SetAutoFocus(true)
        edit:EnableMouse(true)
        edit:SetTextInsets(10,10,10,10)
        edit:SetMultiLine(true)
        edit:SetFontObject(GameFontNormal)
        edit:HookScript("OnEscapePressed", function ()
            BG.frameWenBen.frame:Hide()
        end)
        BG.frameWenBen.edit = edit

        local f = CreateFrame("ScrollFrame", nil, BG.frameWenBen.frame, "UIPanelScrollFrameTemplate")
        f:SetWidth(BG.frameWenBen.frame:GetWidth()-27)
        f:SetHeight(BG.frameWenBen.frame:GetHeight()-29)
        f:SetPoint("BOTTOMLEFT",BG.frameWenBen.frame,"BOTTOMLEFT",0,2)
        f:SetScrollChild(edit)
        BG.frameWenBen.scroll = f
        -- 创建按键
        local bt = CreateFrame("Button",nil,BG.MainFrame)
        bt:SetSize(80, 30)
        bt:SetPoint("LEFT", BG.ButtonFBCD, "RIGHT", 20, 0)
        bt:SetNormalFontObject(BG.FontGreen1)
        bt:SetDisabledFontObject(BG.FontDisabled)
        bt:SetHighlightFontObject(BG.FontHilight)
        bt:SetText("导出表格")
        BG.ButtonWenBen = bt

        bt:SetScript("OnEnter",function (self)
            GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT",-80*BiaoGe.Scale,0)
            GameTooltip:ClearLines()
            GameTooltip:SetText("把表格导出为文本")
        end)
        bt:SetScript("OnLeave",function (self)
            GameTooltip:Hide()
        end)
        bt:SetScript("OnClick",function (self)
            local FB = BG.FB1
            local Frame
            local text
            if BG["Frame"..FB]:IsVisible() then
                Frame = BG.Frame
            elseif BG["HistoryFrame"..FB]:IsVisible() then
                Frame = BG.HistoryFrame
            end
            BG.frameWenBen.frame:Show()
            BG.frameWenBen.edit:SetText("")
            -- BG.frameWenBen.edit:SetFocus()
            for b=1,Maxb[FB]+2 do
                local bossname = BiaoGe[FB]["boss"..b]["bossname"]
                local color
                if strfind(bossname,"|cff") then
                    color = strsub(bossname,strfind(bossname,"|cff"),strfind(bossname,"|cff")+9)
                end
                if color then
                    text = color..BiaoGe[FB]["boss"..b].bossname2.."|r\n"
                else
                    text = BiaoGe[FB]["boss"..b].bossname2.."\n"
                end
                BG.frameWenBen.edit:Insert(text)    -- BOSS名字
                for i=1,Maxi[FB] do
                    if Frame[FB]["boss"..b]["zhuangbei"..i] then
                        if Frame[FB]["boss"..b]["zhuangbei"..i]:GetText() ~= "" or Frame[FB]["boss"..b]["maijia"..i]:GetText() ~= "" or Frame[FB]["boss"..b]["jine"..i]:GetText() ~= "" then
                            text = Frame[FB]["boss"..b]["zhuangbei"..i]:GetText().." "..RGB_16(Frame[FB]["boss"..b]["maijia"..i]).." "..Frame[FB]["boss"..b]["jine"..i]:GetText().."\n"
                            BG.frameWenBen.edit:Insert(text)
                        end
                    end
                end
                BG.frameWenBen.edit:Insert("\n")
            end
            local text = BG.frameWenBen.edit:GetText()
            local len = strlen(text)
            text = strsub(text,1,len-2)
            BG.frameWenBen.edit:SetText(text)
            BG.frameWenBen.edit:HighlightText()
            -- BG.frameWenBen.edit:SetFocus()
        end)
    end
    ------------------生成各副本UI------------------
    do
        BG.ICCUI("ICC")
        BG.TOCUI("TOC")
        BG.ULDUI("ULD")
        BG.NAXXUI("NAXX")

        -- 生成心愿UI    
        BG.HopeUI("ICC")
        BG.HopeUI("TOC")
        BG.HopeUI("ULD")
        BG.HopeUI("NAXX")

        BG.HistoryUI()
        BG.ReceiveUI()
        BG.HelperUI()

        local f=CreateFrame("Frame")
        f:RegisterEvent("PLAYER_ENTERING_WORLD")
        f:SetScript("OnEvent", function(self,even,...)
            C_Timer.After(1,function ()
                BG.UpDateZhuFu()
                BG.UpDateLingHunShi()
                BG.UpDateTuanJian()
            end)
        end)
        local f=CreateFrame("Frame")
        f:RegisterEvent("GROUP_ROSTER_UPDATE")
        f:SetScript("OnEvent", function(self,even,...)
            BG.UpDateZhuFu()
            BG.UpDateLingHunShi()
            BG.UpDateTuanJian()
        end)
    end

    -- ----------------------------------------------------------------------------
    -- 自动记录装备
    -- ----------------------------------------------------------------------------
    do
        local bt = CreateFrame("CheckButton", nil, BG.FrameSheZhi, "ChatConfigCheckButtonTemplate")
        bt:SetSize(30, 30)
        bt:SetHitRectInsets(0, -100, 0, 0)
        bt:SetPoint("TOPLEFT", BG.FrameSheZhi, "TOPLEFT", 10, -10)
        bt.Text:SetText("<自动记录装备>")
        bt:Show()
        BG.ButtonAutoLoot = bt
        if not BiaoGe.AutoLoot then
            BiaoGe.AutoLoot = 1
            bt:SetChecked(true)
        elseif BiaoGe.AutoLoot == 1 then
            bt:SetChecked(true)
        elseif BiaoGe.AutoLoot == 0 then
            bt:SetChecked(false)
        end
        bt:SetScript("OnClick", function(self)
            if self:GetChecked() then
                BiaoGe.AutoLoot = 1
            else
                BiaoGe.AutoLoot = 0
            end
            PlaySound(BG.sound1,"Master")
        end)
        -- 鼠标悬停提示
        bt:SetScript("OnEnter", function(self)
            local text = "|cffffffff< 注意事项 >|r\n\n1、只会记录紫装和橙装\n2、橙片、飞机头、小怪掉落\n    会存到杂项里\n3、图纸不会自动保存\n"
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0)
            GameTooltip:ClearLines()
            GameTooltip:SetText(text)
        end)
        bt:SetScript("OnLeave",function (self)
            GameTooltip:Hide()
        end)
        -- 拾取事件通报到屏幕中上
        BG.FrameLootMsg = CreateFrame("MessageFrame", nil, UIParent)
        BG.FrameLootMsg:SetSpacing(3) -- 行间隔
        BG.FrameLootMsg:SetFadeDuration(1) -- 淡出动画的时间
        BG.FrameLootMsg:SetTimeVisible(8) -- 可见时间
        BG.FrameLootMsg:SetJustifyH("LEFT") -- 对齐格式
        BG.FrameLootMsg:SetSize(800,200) -- 大小
        BG.FrameLootMsg:SetPoint("CENTER",UIParent,"CENTER",250,400) --设置显示位置
        BG.FrameLootMsg:SetFont(STANDARD_TEXT_FONT,  20 , "OUTLINE")
        BG.FrameLootMsg:SetFrameStrata("FULLSCREEN_DIALOG")
        BG.FrameLootMsg:SetFrameLevel(130)
        BG.FrameLootMsg:SetHyperlinksEnabled(true)
        BG.FrameLootMsg:SetScript("OnHyperlinkEnter", function (self,link,text,button)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR",0,0)
            GameTooltip:ClearLines()
            local itemID = GetItemInfoInstant(link)
            if itemID then
            GameTooltip:SetItemByID(itemID)
            GameTooltip:Show()
            end
        end)
        BG.FrameLootMsg:SetScript("OnHyperlinkLeave", function (self,link,text,button)
            GameTooltip:Hide()
        end)
        BG.FrameLootMsg:SetScript("OnHyperlinkClick", function (self,link,text,button)
            local _,link = GetItemInfo(link)
            if button == "RightButton" then  -- 右键清除关注
                for b=1,Maxb[BG.FB2] do
                    for i=1,Maxi[BG.FB2] do
                        if BG.Frame[BG.FB2]["boss"..b]["zhuangbei"..i] then
                            if link == select(2,GetItemInfo(BG.Frame[BG.FB2]["boss"..b]["zhuangbei"..i]:GetText())) then
                                BiaoGe[BG.FB2]["boss"..b]["guanzhu"..i] = nil
                                BG.Frame[BG.FB2]["boss"..b]["guanzhu"..i]:Hide()
                                BG.FrameLootMsg:AddMessage(BG.STC_r1("已取消关注装备："..link..""))
                                return
                            end
                        end
                    end
                end
            end
            if IsShiftKeyDown() then
                _G.ChatFrame1EditBox:Show()
                _G.ChatFrame1EditBox:SetFocus()
                _G.ChatFrame1EditBox:Insert(text)
                return
            end
            if IsAltKeyDown() then
                for b=1,Maxb[BG.FB2] do
                    for i=1,Maxi[BG.FB2] do
                        if BG.Frame[BG.FB2]["boss"..b]["zhuangbei"..i] then
                            if link == select(2,GetItemInfo(BG.Frame[BG.FB2]["boss"..b]["zhuangbei"..i]:GetText())) then
                                BiaoGe[BG.FB2]["boss"..b]["guanzhu"..i] = true
                                BG.Frame[BG.FB2]["boss"..b]["guanzhu"..i]:Show()
                                BG.FrameLootMsg:AddMessage(BG.STC_g2("已成功关注装备："..link.."。团长拍卖此装备时会提醒"))
                                return
                            end
                        end
                    end
                end
            end
            ChatFrame_OnHyperlinkShow(self,link,text,button)
        end)
        -- 屏蔽交易添加
        local trade = true
        local f=CreateFrame("Frame")
        f:RegisterEvent("TRADE_SHOW")
        f:SetScript("OnEvent", function(self,...)
            trade = false
            --pt(trade)
        end)
        local f2=CreateFrame("Frame")
        f2:RegisterEvent("TRADE_CLOSED")
        f2:SetScript("OnEvent", function(self,...)
                trade = true
                --pt(trade)
        end)


        local numb
        local lasttime,time

        -- 获取BOSS战ID+
        local f=CreateFrame("Frame")
        f:RegisterEvent("BOSS_KILL")
        f:SetScript("OnEvent", function(self,even,ID)
            if BG.Loot.encounterID[BG.FB2] then
                for key, value in ipairs(BG.Loot.encounterID[BG.FB2]) do
                    if ID == value then
                        numb = key
                    end
                end
            end
            lasttime = nil
        end)

        -- 拾取事件监听
        local f = CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_LOOT")
        f:SetScript("OnEvent",function (self,even,text,...)
            local FB = BG.FB2
            if BiaoGe.AutoLoot ~= 1 then       -- 有没勾选自动记录功能
                return
            end
            if not FB then      -- 有没FB
                return
            end
            local _,type = IsInInstance()
            if type ~= "raid" then      -- 是否在副本
                return
            end
            local have = string.find(text,"战利品")
            if have then    -- 文本是否ROLL点
                return
            end
            have = string.find(text,"获得")
            if not have then    -- 文本有没获得
                return
            end
            if not trade then     -- 是否刚交易完里
                return
            end
            local name,link,quality,level,_,_,_,_,_,_,_,typeID=GetItemInfo(text)
            local itemId = GetItemInfoInstant(link)
            if name == "寒冰纹章" or name == "凯旋纹章" or name == "征服纹章" or name == "勇气纹章" or name == "英雄纹章" or name == "深渊水晶" then
                return
            end
            if typeID == 9 then     -- 是不是图纸
                return
            end
            if quality < 4 then    -- 是不是紫装或橙装
                return
            end

            -- 心愿装备
            local Hope
            for n=1,HopeMaxn[FB] do
                for b=1,HopeMaxb[FB] do
                    for i=1,HopeMaxi do
                        if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                            if link == select(2,GetItemInfo(BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:GetText())) then
                                BG.FrameLootMsg:AddMessage(BG.STC_g1("你的心愿达成啦！！！>>>>> ")..link.."("..level..")"..BG.STC_g1(" <<<<<"))
                                BG.HopeFrame[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i]:Show()
                                BiaoGeA.Hope[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i] = true
                                Hope = true
                                PlaySoundFile(BG.sound_hope,"Master")
                            end
                        end
                    end
                end
            end

            -- 特殊物品记到杂项里
            if itemId == 45897 then  -- [重铸的远古王者之锤]
                return
            end
            if itemId == 45038 or itemId == 45693 or itemId == 47242 or itemId == 50274 or itemId == 50818 then        -- ULD橙片和飞机头，TOC北伐徽章、ICC橙片和无敌
                for i=1,Maxi[FB] do
                    if BG.Frame[FB]["boss"..Maxb[FB]-1]["zhuangbei"..i] then
                        if link == select(2,GetItemInfo(BG.Frame[FB]["boss"..Maxb[FB]-1]["zhuangbei"..i]:GetText())) then   -- 装备框是否橙片
                            if BiaoGe[FB]["ChengPian"] then
                                BiaoGe[FB]["ChengPian"] = BiaoGe[FB]["ChengPian"] + 1   -- 橙片数量+1
                                BG.Frame[FB]["boss"..Maxb[FB]-1]["zhuangbei"..i]:SetText(link.."*"..BiaoGe[FB]["ChengPian"])    -- 设置文本：橙片*数量
                                BiaoGe[FB]["boss"..Maxb[FB]-1]["zhuangbei"..i] = (link.."*"..BiaoGe[FB]["ChengPian"])    -- 设置文本：橙片*数量
                                BG.FrameLootMsg:AddMessage("|cff00BFFF已自动记入表格：|r"..link.."("..level..")*"..BiaoGe[FB]["ChengPian"].." => |cffFF1493< "..BiaoGe[FB]["boss"..Maxb[FB]-1]["bossname2"].." >|r")
                                if Hope then
                                    BiaoGe[FB]["boss"..Maxb[FB]-1]["guanzhu"..i] = true
                                    BG.Frame[FB]["boss"..Maxb[FB]-1]["guanzhu"..i]:Show()
                                    BG.FrameLootMsg:AddMessage(BG.STC_g2("自动关注心愿装备："..link.."。团长拍卖此装备时会提醒"))
                                end
                            end
                            return
                        end
                        if BG.Frame[FB]["boss"..Maxb[FB]-1]["zhuangbei"..i]:GetText() == "" then    -- 装备框是否空白
                            if itemId == 45038 or itemId == 50274 then    -- 如果掉落装备为橙片
                                BiaoGe[FB]["ChengPian"] = 1     -- 橙片数量设置为1
                                BG.Frame[FB]["boss"..Maxb[FB]-1]["zhuangbei"..i]:SetText(link.."*"..BiaoGe[FB]["ChengPian"])    -- 设置文本：橙片*1
                                BiaoGe[FB]["boss"..Maxb[FB]-1]["zhuangbei"..i] = (link.."*"..BiaoGe[FB]["ChengPian"])    -- 设置文本：橙片*数量
                                BG.FrameLootMsg:AddMessage("|cff00BFFF已自动记入表格：|r"..link.."("..level..")*"..BiaoGe[FB]["ChengPian"].." => |cffFF1493< "..BiaoGe[FB]["boss"..Maxb[FB]-1]["bossname2"].." >|r")
                                if Hope then
                                    BiaoGe[FB]["boss"..Maxb[FB]-1]["guanzhu"..i] = true
                                    BG.Frame[FB]["boss"..Maxb[FB]-1]["guanzhu"..i]:Show()
                                    BG.FrameLootMsg:AddMessage(BG.STC_g2("自动关注心愿装备："..link.."。团长拍卖此装备时会提醒"))
                                end
                            else
                                BG.Frame[FB]["boss"..Maxb[FB]-1]["zhuangbei"..i]:SetText(link)    -- 如果不是橙片就设置文本：装备
                                BiaoGe[FB]["boss"..Maxb[FB]-1]["zhuangbei"..i] = (link)    -- 如果不是橙片就设置文本：装备
                                BG.FrameLootMsg:AddMessage("|cff00BFFF已自动记入表格：|r"..link.."("..level..") => |cffFF1493< "..BiaoGe[FB]["boss"..Maxb[FB]-1]["bossname2"].." >|r")
                                if Hope then
                                    BiaoGe[FB]["boss"..Maxb[FB]-1]["guanzhu"..i] = true
                                    BG.Frame[FB]["boss"..Maxb[FB]-1]["guanzhu"..i]:Show()
                                    BG.FrameLootMsg:AddMessage(BG.STC_g2("自动关注心愿装备："..link.."。团长拍卖此装备时会提醒"))
                                end
                            end
                            return
                        end
                        if BG.Frame[FB]["boss"..Maxb[FB]-1]["zhuangbei"..i+1] == nil then     -- 如果是最后一格了，就提示满了
                            BG.FrameLootMsg:AddMessage("|cffDC143C自动记录失败：|r"..link.."("..level..")。因为|cffFF1493< "..BiaoGe[FB]["boss"..Maxb[FB]-1]["bossname2"].." >|r的格子满了。。")
                            if Hope then
                                BG.FrameLootMsg:AddMessage("|cffDC143C自动关注心愿装备失败：|r"..link)
                            end
                            return
                        end
                    end
                end
            end

            -- TOC嘉奖宝箱通过读取掉落列表来记录装备
            if FB == "TOC" then     
                for index, value in ipairs(BG.Loot.TOC.H25.boss6) do
                    if itemId == value then
                        local numb = 6
                        for i=1,Maxi[FB] do
                            if BG.Frame[FB]["boss"..numb]["zhuangbei"..i] then
                                if BG.Frame[FB]["boss"..numb]["zhuangbei"..i]:GetText() == "" then
                                    BG.Frame[FB]["boss"..numb]["zhuangbei"..i]:SetText(link)
                                    BiaoGe[FB]["boss"..numb]["zhuangbei"..i] = (link)
                                    BG.FrameLootMsg:AddMessage("|cff00BFFF已自动记入表格：|r"..link.."("..level..") => |cffFF1493< "..BiaoGe[FB]["boss"..numb]["bossname2"].." >|r")
                                    return
                                end
                                if BG.Frame[FB]["boss"..numb]["zhuangbei"..i+1] == nil then
                                    BG.FrameLootMsg:AddMessage("|cffDC143C自动记录失败：|r"..link.."("..level..")。因为|cffFF1493< "..BiaoGe[FB]["boss"..numb]["bossname2"].." >|r的格子满了。。")
                                    return
                                end
                            end
                        end
                    end
                end
                for index, value in ipairs(BG.Loot.TOC.H10.boss6) do
                    if itemId == value then
                        local numb = 6
                        for i=1,Maxi[FB] do
                            if BG.Frame[FB]["boss"..numb]["zhuangbei"..i] then
                                if BG.Frame[FB]["boss"..numb]["zhuangbei"..i]:GetText() == "" then
                                    BG.Frame[FB]["boss"..numb]["zhuangbei"..i]:SetText(link)
                                    BiaoGe[FB]["boss"..numb]["zhuangbei"..i] = (link)
                                    BG.FrameLootMsg:AddMessage("|cff00BFFF已自动记入表格：|r"..link.."("..level..") => |cffFF1493< "..BiaoGe[FB]["boss"..numb]["bossname2"].." >|r")
                                    return
                                end
                                if BG.Frame[FB]["boss"..numb]["zhuangbei"..i+1] == nil then
                                    BG.FrameLootMsg:AddMessage("|cffDC143C自动记录失败：|r"..link.."("..level..")。因为|cffFF1493< "..BiaoGe[FB]["boss"..numb]["bossname2"].." >|r的格子满了。。")
                                    return
                                end
                            end
                        end
                    end
                end
            end

            -- 常规物品记录到刚击杀的BOSS
            if lasttime == nil then
                lasttime = GetTime()
            end
            time = GetTime()
            if time - lasttime >= 60 then
                numb = BG.Loot.encounterID[FB]["zaxiang"]      -- 两次拾取的时间超过一定时间就变回杂项
                lasttime = time
            end
            if not numb then
                numb = BG.Loot.encounterID[FB]["zaxiang"]      -- 第一个boss前的小怪设为杂项
            end
            for i=1,Maxi[FB] do
                if BG.Frame[FB]["boss"..numb]["zhuangbei"..i] then
                    if BG.Frame[FB]["boss"..numb]["zhuangbei"..i]:GetText() == "" then
                        BG.Frame[FB]["boss"..numb]["zhuangbei"..i]:SetText(link)
                        BiaoGe[FB]["boss"..numb]["zhuangbei"..i] = (link)
                        BG.FrameLootMsg:AddMessage("|cff00BFFF已自动记入表格：|r"..link.."("..level..") => |cffFF1493< "..BiaoGe[FB]["boss"..numb]["bossname2"].." >|r")
                        if Hope then
                            BiaoGe[FB]["boss"..numb]["guanzhu"..i] = true
                            BG.Frame[FB]["boss"..numb]["guanzhu"..i]:Show()
                            BG.FrameLootMsg:AddMessage(BG.STC_g2("自动关注心愿装备："..link.."。团长拍卖此装备时会提醒"))
                        end
                        return
                    end
                    if BG.Frame[FB]["boss"..numb]["zhuangbei"..i+1] == nil then
                        BG.FrameLootMsg:AddMessage("|cffDC143C自动记录失败：|r"..link.."("..level..")。因为|cffFF1493< "..BiaoGe[FB]["boss"..numb]["bossname2"].." >|r的格子满了。。")
                        if Hope then
                            BG.FrameLootMsg:AddMessage("|cffDC143C自动关注心愿装备失败：|r"..link)
                        end
                        return
                    end
                end
            end
        end)


        -- DEBUG
        do
            function BG.DeBugLoot()
                if not BG.DeBug then return end
                local FB = "ULD"
                local name,link,quality,level,_,_,_,_,_,_,_,typeID=GetItemInfo(45038)
                if link then
                    BG.Frame[FB]["boss1"]["zhuangbei1"]:SetText(link)
                    BiaoGe[FB]["boss1"]["zhuangbei1"] = (link)
                    BG.FrameLootMsg:AddMessage("|cff00BFFF已自动记入表格：|r"..link.."("..level..") => |cffFF1493< "..BiaoGe[FB]["boss1"]["bossname2"].." >|r")
                    -- BG.FrameLootMsg:AddMessage(BG.STC_g1("你的心愿达成啦！！！>>>>> ")..link.."("..level..")"..BG.STC_g1(" <<<<<"))
                    -- BG.FrameLootMsg:AddMessage(BG.STC_g2("自动关注心愿装备："..link.."。团长拍卖此装备时会提醒"))
                end
            end

            local f = CreateFrame("Frame")
            f:RegisterEvent("CHAT_MSG_LOOT")
            f:SetScript("OnEvent",function (self,even,text,...)
                if not BG.DeBug then return end
                local FB = "ULD"
                local name,link,quality,level,_,_,_,_,_,_,_,typeID=GetItemInfo(text)

                -- 心愿装备
                local Hope
                for n=1,HopeMaxn[FB] do
                    for b=1,HopeMaxb[FB] do
                        for i=1,HopeMaxi do
                            if BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                                if link == select(2,GetItemInfo(BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:GetText())) then
                                    BG.FrameLootMsg:AddMessage(BG.STC_g1("你的心愿达成啦！！！>>>>> ")..link.."("..level..")"..BG.STC_g1(" <<<<<"))
                                    BG.HopeFrame[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i]:Show()
                                    BiaoGeA.Hope[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i] = true
                                    Hope = true
                                    PlaySoundFile(BG.sound_hope,"Master")
                                end
                            end
                        end
                    end
                end
                if Hope then
                    -- BiaoGe[FB]["boss"..Maxb[FB]-1]["guanzhu"..1] = true
                    -- BG.Frame[FB]["boss"..Maxb[FB]-1]["guanzhu"..1]:Show()
                    BG.FrameLootMsg:AddMessage(BG.STC_g2("自动关注心愿装备："..link.."。团长拍卖此装备时会提醒"))
                end
            end)
        end
    end

    -- ----------------------------------------------------------------------------
    -- 交易自动记账
    -- ----------------------------------------------------------------------------
    do
        --函数：交易自动记录买家和金额
        function BG.TradeText(num,target,player,targetmoney,playermoney,targetitems,playeritems)
            local FB = BG.FB1
            local returntext = ""
            -- 双方都给出装备
            if targetitems[1] and playeritems[1] and targetmoney == 0 and playermoney == 0 then --双方都有装备，但没金额，这种是交易失败
                returntext = ("|cffDC143C< 交易记账失败 >|r\n双方都给了装备，但没金额\n我不知道谁才是买家\n\n如果有金额我就能识别了")
                return returntext
            end
            local qiankuan = 0
            if BG.QianKuan.edit then
                if tonumber(BG.QianKuan.edit:GetText()) then
                    qiankuan = qiankuan + tonumber(BG.QianKuan.edit:GetText())
                end
            end
            local qiankuantext = ""
            if qiankuan ~= 0 then
                qiankuantext = "|cffFF0000（欠款"..qiankuan.."）|r"
            end

            local Items,Money,Items2,Money2
            for ii=1,2 do
                if ii == 1 then     -- 玩家给出金额，得到装备（玩家买装备情景）:1、双方都有装备，但玩家出了金
                    Items = targetitems
                    Items2 = playeritems
                    Money = playermoney
                    Money2 = targetmoney
                    Player = player
                elseif ii == 2 then     -- 玩家给出装备，得到金钱（团长情景）
                    Items = playeritems
                    Items2 = targetitems
                    Money = targetmoney
                    Money2 = playermoney
                    Player = target
                end

                if (targetitems[1] and playeritems[1] and Money ~= 0) or (Items[1] and not Items2[1]) then
                    for items = 1 , #Items do
                        for b = 1, Maxb[FB], 1 do
                            for i = 1, Maxi[FB], 1 do
                                if BG.Frame[FB]["boss"..b]["zhuangbei"..i] then
                                    if select(2,GetItemInfo(BG.Frame[FB]["boss"..b]["zhuangbei"..i]:GetText())) == Items[items] then
                                        if BG.Frame[FB]["boss"..b]["maijia"..i]:GetText() == "" and BG.Frame[FB]["boss"..b]["jine"..i]:GetText() == "" then
                                            if num == 1 then
                                                BG.Frame[FB]["boss"..b]["maijia"..i]:SetText(Player)
                                                BG.Frame[FB]["boss"..b]["maijia"..i]:SetTextColor(GetClassRGB(Player))
                                                BG.Frame[FB]["boss"..b]["jine"..i]:SetText(Money+qiankuan)
                                                BiaoGe[FB]["boss"..b]["maijia"..i] = (Player)
                                                BiaoGe[FB]["boss"..b]["color"..i] = {GetClassRGB(Player)}
                                                BiaoGe[FB]["boss"..b]["jine"..i] = (Money+qiankuan)
                                            end
                                            if qiankuan ~= 0 and num == 1 then
                                                BiaoGe[FB]["boss"..b]["qiankuan"..i] = qiankuan
                                                BG.Frame[FB]["boss"..b]["qiankuan"..i]:Show()
                                            end
                                            returntext = ("|cff00BFFF< 交易记账成功 >|r\n装备："..Items[items].."\n买家："..SetClassCFF(Player).."\n金额：|cffFFD700"..Money+qiankuan.."|rg"..qiankuantext.."\nBOSS：|cffFF1493< "..BiaoGe[FB]["boss"..b]["bossname2"].." >|r")
                                            BG.tradeDropDown.DropDown:Hide()
                                            return returntext
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if not BG.tradeDropDown.Boss then
                        returntext = ("|cffDC143C< 交易记账失败 >|r\n表格里没找到此次交易的装备")
                        BG.tradeDropDown.DropDown:Show()
                        return returntext
                    else
                        local b = BG.tradeDropDown.Boss
                        for i = 1, Maxi[FB], 1 do
                            if BG.Frame[FB]["boss"..b]["zhuangbei"..i] then
                                if BG.Frame[FB]["boss"..b]["zhuangbei"..i]:GetText() == "" then
                                    if num == 1 then
                                        BG.Frame[FB]["boss"..b]["zhuangbei"..i]:SetText(Items[1])
                                        BG.Frame[FB]["boss"..b]["maijia"..i]:SetText(Player)
                                        BG.Frame[FB]["boss"..b]["maijia"..i]:SetTextColor(GetClassRGB(Player))
                                        BG.Frame[FB]["boss"..b]["jine"..i]:SetText(Money+qiankuan)
                                        BiaoGe[FB]["boss"..b]["zhuangbei"..i] = (Items[1])
                                        BiaoGe[FB]["boss"..b]["maijia"..i] = (Player)
                                        BiaoGe[FB]["boss"..b]["color"..i] = {GetClassRGB(Player)}
                                        BiaoGe[FB]["boss"..b]["jine"..i] = (Money+qiankuan)
                                    end
                                    if qiankuan ~= 0 and num == 1 then
                                        BiaoGe[FB]["boss"..b]["qiankuan"..i] = qiankuan
                                        BG.Frame[FB]["boss"..b]["qiankuan"..i]:Show()
                                    end
                                    returntext = ("|cff00BFFF< 交易记账成功 >|r\n装备："..Items[1].."\n买家："..SetClassCFF(player).."\n金额：|cffFFD700"..Money+qiankuan.."|rg"..qiankuantext.."\nBOSS：|cffFF1493< "..BiaoGe[FB]["boss"..b]["bossname2"].." >|r")
                                    BG.tradeDropDown.DropDown:Show()
                                    return returntext
                                end
                            end
                        end
                        returntext = ("|cffDC143C< 交易记账失败 >|r\n该BOSS格子已满")
                        BG.tradeDropDown.DropDown:Show()
                        return returntext
                    end
                end
            end
            return returntext
        end

        BG.tradeQuality = 4
        function BG.TradeChange()
            wipe(BG.trade)
            BG.trade.target = GetUnitName("NPC", true)
            BG.trade.player = UnitName("player")
            BG.trade.targetmoney = GetTargetTradeMoney()
            BG.trade.playermoney = GetPlayerTradeMoney()
            BG.trade.targetitems = {}
            BG.trade.playeritems = {}

            --只留金币，去除银桐
            if BG.trade.playermoney then
                BG.trade.playermoney = math.modf(BG.trade.playermoney/10000)
            end
            --只留金币，去除银桐
            if BG.trade.targetmoney then
                BG.trade.targetmoney = math.modf(BG.trade.targetmoney/10000)
            end

            for i = 1, 6 do
                local targetitem = GetTradeTargetItemLink(i)
                local name, texture, quantity, quality, isUsable, enchant = GetTradeTargetItemInfo(i)
                if quality >= BG.tradeQuality and targetitem then
                    table.insert(BG.trade.targetitems,targetitem)
                end
                
                local playeritem = GetTradePlayerItemLink(i)
                local name, texture, quantity, quality, isUsable, enchant = GetTradePlayerItemInfo(i)
                if quality >= BG.tradeQuality and playeritem then
                    table.insert(BG.trade.playeritems,playeritem)
                end
            end
        end
            -- 交易UI的罚款输入框 
        do
            BG.QianKuan = {}
            local frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
            frame:SetBackdrop({
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 8
            })
            frame:SetBackdropColor(0.5, 0, 0.1, 0.5)
            frame:SetSize(130, 25)
            -- frame:SetFrameLevel(120)
            frame:Hide()

            BG.QianKuan.frame = frame

            local edit = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
            edit:SetSize(70, 20)
            edit:SetPoint("RIGHT",BG.QianKuan.frame,-5,0)
            edit:SetText("")
            edit:SetTextColor(RGB("FF0000"))
            edit:SetNumeric(true)
            edit:Show()
            edit:SetAutoFocus(false)
            BG.QianKuan.edit = edit
            edit:SetScript("OnTextChanged", function(self)
                if BiaoGe.AutoJine0 == 1 then
                    local len = strlen(self:GetText())
                    local lingling
                    if len then
                        lingling = strsub(self:GetText(),len-1,len)
                    end
                    if lingling ~= "00" and lingling ~= "0" and tonumber(self:GetText()) and self:HasFocus() then
                        self:Insert("00")
                        self:SetCursorPosition(1)
                    end
                end
                BG.TradeChange()
                BG.tradeFrame.text:SetText(BG.TradeText(0,BG.trade.target,BG.trade.player,BG.trade.targetmoney,BG.trade.playermoney,BG.trade.targetitems,BG.trade.playeritems))
            end)
                -- 点击时
            edit:SetScript("OnMouseDown", function(self,enter)
                if enter == "RightButton" then  -- 右键清空格子
                    self:SetEnabled(false)
                    self:SetText("")
                end
            end)
            edit:SetScript("OnMouseUp", function(self,enter)
                if enter == "RightButton" then  -- 右键清空格子
                    self:SetEnabled(true)
                end
            end)

            local text = edit:CreateFontString()
            text:SetPoint("RIGHT", BG.QianKuan.edit, "LEFT", -8, 0)
            -- text:SetFontObject(GameFontNormal)
            text:SetFont(STANDARD_TEXT_FONT ,  14 , "OUTLINE")
            text:SetTextColor(RGB("FF0000"))
            text:SetText("欠款：")
            text:Show()
            BG.QianKuan.text = text

            local f=CreateFrame("Frame")
            f:RegisterEvent("TRADE_SHOW")
            f:SetScript("OnEvent", function(self,...)
                if not IsInRaid() then return end
                BG.QianKuan.frame:SetParent(TradeFrame)
                BG.QianKuan.frame:SetPoint("BOTTOM", TradeRecipientMoneyBg, "TOPLEFT", -10, 3)
                BG.QianKuan.frame:Show()            
                BG.QianKuan.edit:SetText("")
            end)
            local f=CreateFrame("Frame")
            f:RegisterEvent("TRADE_CLOSED")
            f:SetScript("OnEvent", function(self,...)
                BG.QianKuan.frame:Hide()
            end)

            _G.TradeFrame:SetScript("OnMouseDown", function(self,enter)
                edit:ClearFocus()
            end)
        end

            -- 自动记账效果预览框
        do
            BG.tradeFrame = {}
            local frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
            frame:SetBackdrop({
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                edgeSize = 8
            })
            frame:SetBackdropColor(0, 0, 0.1, 1)
            frame:SetSize(200, 250)
            frame:Hide()
            frame:SetClampedToScreen(true)
            frame:SetFrameStrata("DIALOG")
            frame:SetMovable(true)
            frame:SetScript("OnMouseUp", function(self)
                self:StopMovingOrSizing()
                BiaoGe.point.tradeFrame = {BG.tradeFrame.frame:GetPoint()}
            end)
            frame:SetScript("OnMouseDown", function(self)
                self:StartMoving()
            end)
            BG.tradeFrame.frame = frame

            local text = frame:CreateFontString()
            text:SetPoint("TOP", frame, "TOP", 0, -5)
            text:SetFont(STANDARD_TEXT_FONT ,  16 , "OUTLINE")
            text:SetText("记账效果预览")
            BG.tradeFrame.title = text

            local text = frame:CreateFontString()
            text:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -40)
            text:SetFont(STANDARD_TEXT_FONT ,  15 , "OUTLINE")
            text:SetJustifyH("LEFT") -- 对齐格式
            BG.tradeFrame.text = text
            local f=CreateFrame("Frame")
            f:RegisterEvent("TRADE_SHOW")
            f:SetScript("OnEvent", function(self,...)
                if not IsInRaid() then return end
                BG.tradeFrame.frame:SetParent(TradeFrame)
                BG.tradeFrame.frame:ClearAllPoints()
                local p = BiaoGe.point.tradeFrame
                if p then
                    BG.tradeFrame.frame:SetPoint(p[1],p[2],p[3],p[4],p[5])
                else
                    BG.tradeFrame.frame:SetPoint("TOPLEFT", TradeRecipientMoneyBg, "TOPRIGHT", 8, 0)
                end
                BG.tradeDropDown.DropDown:Hide()
                BG.tradeDropDown.Yes = false
                BG.tradeDropDown.Boss = nil
                UIDropDownMenu_SetText(BG.tradeDropDown.DropDown, "无")
                if BiaoGe.AutoTrade == 1 then
                    BG.tradeFrame.frame:Show()
                end
                BG.tradeFrame.text:SetText("")
                TradePlayerInputMoneyFrameGold:HookScript("OnTextChanged", function()
                    BG.TradeChange()
                    BG.tradeFrame.text:SetText(BG.TradeText(0,BG.trade.target,BG.trade.player,BG.trade.targetmoney,BG.trade.playermoney,BG.trade.targetitems,BG.trade.playeritems))
                end)
            end)

            -- local timeElapsed = 0
            -- TradeRecipientMoneyBg:HookScript("OnUpdate",function (self,elapsed)
            --     timeElapsed = timeElapsed + elapsed
            --     if timeElapsed > 1 then
            --         timeElapsed = 0
            --         pt(TradeFrame:GetPoint())
            --     end
            -- end)
        end
            -- 强制记账选择框
        do
            BG.tradeDropDown = {}
            BG.tradeDropDown.Yes = false
            BG.tradeDropDown.Boss = nil
            local dropDown = CreateFrame("Frame", nil, BG.tradeFrame.frame, "UIDropDownMenuTemplate")
            dropDown:SetPoint("BOTTOM", BG.tradeFrame.frame, "BOTTOM",25,0)
            UIDropDownMenu_SetWidth(dropDown, 100)
            UIDropDownMenu_SetText(dropDown, "无")
            dropDown:Hide()
            BG.tradeDropDown.DropDown = dropDown

            local text = dropDown:CreateFontString()
            text:SetPoint("RIGHT", dropDown, "LEFT",10,3)
            text:SetFontObject(GameFontNormal)
            text:SetText("记账到:")
            text:Show()
            BG.tradeDropDown.BiaoTi = text
            UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
                local FB = BG.FB1
                FrameHide(0)
                PlaySound(BG.sound1,"Master")
                for b=0,Maxb[FB] do
                    local info = UIDropDownMenu_CreateInfo()
                        local bossnametext = ""
                        if b ~= 0 then
                            local bossname = BiaoGe[FB]["boss"..b]["bossname"]
                            local color
                            if strfind(bossname,"|cff") then
                                color = strsub(bossname,strfind(bossname,"|cff"),strfind(bossname,"|cff")+9)
                            end
                            if color then
                                bossnametext = color..BiaoGe[FB]["boss"..b].bossname2
                            else
                                bossnametext = BiaoGe[FB]["boss"..b].bossname2
                            end
                        else
                            bossnametext = "无"
                        end

                        info.text, info.func = bossnametext, function ()
                            if b == 0 then
                                BG.tradeDropDown.Yes = false
                                BG.tradeDropDown.Boss = nil
                            else
                                BG.tradeDropDown.Yes = true
                                BG.tradeDropDown.Boss = b
                            end
                            UIDropDownMenu_SetText(dropDown, bossnametext)
                            BG.TradeChange()
                            BG.tradeFrame.text:SetText(BG.TradeText(0,BG.trade.target,BG.trade.player,BG.trade.targetmoney,BG.trade.playermoney,BG.trade.targetitems,BG.trade.playeritems))
                            FrameHide(0)
                            PlaySound(BG.sound1,"Master")
                        end 
                    UIDropDownMenu_AddButton(info)
                end
            end)
        end

            -- 交易记录核心
        do
            local bt = CreateFrame("CheckButton", nil, BG.FrameSheZhi, "ChatConfigCheckButtonTemplate")
            bt:SetSize(30, 30)
            bt:SetHitRectInsets(0, -100, 0, 0)
            bt:SetPoint("TOPLEFT", BG.ButtonAutoLoot, "BOTTOMLEFT", 0, 0)
            bt.Text:SetText("<交易自动记账>")
            bt:Show()
            BG.ButtonAutoTrade = bt
            if not BiaoGe.AutoTrade then
                BiaoGe.AutoTrade = 1
                bt:SetChecked(true)
            elseif BiaoGe.AutoTrade == 1 then
                bt:SetChecked(true)
            elseif BiaoGe.AutoTrade == 0 then
                bt:SetChecked(false)
            end
            bt:SetScript("OnClick", function(self)
                if self:GetChecked() then
                    BiaoGe.AutoTrade = 1
                    BG.tradeFrame.frame:Show()
                else
                    BiaoGe.AutoTrade = 0
                    BG.tradeFrame.frame:Hide()
                end
                PlaySound(BG.sound1,"Master")
            end)
            -- 鼠标悬停提示
            bt:SetScript("OnEnter", function(self)
                local text = "|cffffffff< 注意事项 >|r\n\n1、只会记录紫装和橙装\n2、需要配合自动记录装备，因为\n    如果表格里没有该交易的装备，\n    则记账失败\n3、如果一次交易两件装备以上，\n    则只会记第一件装备，\n"
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0)
                GameTooltip:ClearLines()
                GameTooltip:SetText(text)
            end)
            bt:SetScript("OnLeave",function (self)
                GameTooltip:Hide()
            end)

            local frame = CreateFrame("MessageFrame", nil, UIParent)
            frame:SetSpacing(1) -- 行间隔
            frame:SetFadeDuration(1) -- 淡出动画的时间
            frame:SetTimeVisible(3) -- 可见时间
            frame:SetJustifyH("LEFT") -- 对齐格式
            frame:SetSize(600,300) -- 大小
            frame:SetPoint("CENTER",UIParent,"CENTER",250,350) --设置显示位置
            frame:SetFont(STANDARD_TEXT_FONT ,  20 , "OUTLINE")
            frame:SetFrameLevel(130)
            frame:SetFrameStrata("FULLSCREEN_DIALOG")
            frame:SetHyperlinksEnabled(true)
            BG.FrameTradeMsg = frame
            frame:SetScript("OnHyperlinkEnter", function (self,link,text,button)
                GameTooltip:SetOwner(self, "ANCHOR_CURSOR",0,0)
                GameTooltip:ClearLines()
                local itemID = GetItemInfoInstant(link)
                if itemID then
                GameTooltip:SetItemByID(itemID)
                GameTooltip:Show()
                end
            end)
            frame:SetScript("OnHyperlinkLeave", function (self,link,text,button)
                GameTooltip:Hide()
            end)
            frame:SetScript("OnHyperlinkClick", function (self,link,text,button)
                if IsShiftKeyDown() then
                    _G.ChatFrame1EditBox:Show()
                    _G.ChatFrame1EditBox:SetFocus()
                    _G.ChatFrame1EditBox:Insert(text)
                else
                    ChatFrame_OnHyperlinkShow(self,link,text,button)
                end
            end)

            --每次点交易确定时记录双方交易的金币和物品
            BG.trade = {}
            local f=CreateFrame("Frame")
            f:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED")
            f:RegisterEvent("TRADE_TARGET_ITEM_CHANGED")
            f:RegisterEvent("TRADE_MONEY_CHANGED")
            f:SetScript("OnEvent", function(...)
                BG.TradeChange()
                BG.tradeFrame.text:SetText(BG.TradeText(0,BG.trade.target,BG.trade.player,BG.trade.targetmoney,BG.trade.playermoney,BG.trade.targetitems,BG.trade.playeritems))
            end)

            local f=CreateFrame("Frame")
            f:RegisterEvent("UI_INFO_MESSAGE")
            f:SetScript("OnEvent", function(self,event,_,text)
                if text == ERR_TRADE_COMPLETE then
                    if BiaoGe.AutoTrade == 1 and IsInRaid() then
                        BG.FrameTradeMsg:AddMessage(BG.TradeText(1,BG.trade.target,BG.trade.player,BG.trade.targetmoney,BG.trade.playermoney,BG.trade.targetitems,BG.trade.playeritems))
                    end
                end
            end)
        end
    end

    -- ----------------------------------------------------------------------------
    -- 高亮团长发出的装备
    -- ----------------------------------------------------------------------------
    do
        local f=CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_RAID_LEADER")
        f:RegisterEvent("CHAT_MSG_RAID_WARNING")
        f:RegisterEvent("CHAT_MSG_RAID")
        f:SetScript("OnEvent", function(self,even,text,playerName,...)
            if even == "CHAT_MSG_RAID" then
                local a = string.find(playerName,"-")
                if a then
                    playerName = strsub(playerName,1,a-1)
                end
                if playerName ~= BG.MasterLooter then
                    return
                end
            end
            -- 把超链接转换成文字
            local textonly = ""
            local cc = 1
            local aa,bb
            for i = 1, 4, 1 do            
                aa = string.find(text,"|h",cc)
                if aa then
                    bb = string.find(text,"]",aa)
                end
                if bb then
                    cc = bb+10
                end
                if aa and bb then
                    textonly = textonly..strsub(text,aa,bb)
                else
                    break
                end
            end
            -- 开始
            local yes
            for b = 1, Maxb[BG.FB1], 1 do
                for i = 1, Maxi[BG.FB1], 1 do
                    if BG.Frame[BG.FB1]["boss"..b]["zhuangbei"..i] then
                        if BG.Frame[BG.FB1]["boss"..b]["zhuangbei"..i]:GetText() ~= "" then
                            local item = GetItemInfo(BG.Frame[BG.FB1]["boss"..b]["zhuangbei"..i]:GetText())
                            if item then
                                yes = string.find(textonly,item)
                                if yes then
                                    BG.FrameDs[BG.FB1..3]["boss"..b]["ds"..i]:Show()
                                    C_Timer.After(15,function ()
                                        BG.FrameDs[BG.FB1..3]["boss"..b]["ds"..i]:Hide()
                                    end)
                                    if BiaoGe[BG.FB1]["boss"..b]["guanzhu"..i] then
                                        BG.FrameLootMsg:AddMessage(BG.STC_g1("你关注的装备开始拍卖了："..BG.Frame[BG.FB1]["boss"..b]["zhuangbei"..i]:GetText().."（右键取消关注）"))
                                        PlaySoundFile(BG.sound_paimai,"Master")
                                    end
                                end
                            end
                        end
                    end
                end
            end

            yes = nil
            for n=1,HopeMaxn[BG.FB1] do
                for b=1,HopeMaxb[BG.FB1] do
                    for i=1,HopeMaxi do
                        if BG.HopeFrame[BG.FB1]["nandu"..n]["boss"..b]["zhuangbei"..i] then
                            local item = GetItemInfo(BG.HopeFrame[BG.FB1]["nandu"..n]["boss"..b]["zhuangbei"..i]:GetText())
                            if item then
                                yes = string.find(textonly,item)
                                if yes then
                                    BG.HopeFrameDs[BG.FB1..3]["nandu"..n]["boss"..b]["ds"..i]:Show()
                                    C_Timer.After(15,function ()
                                        BG.HopeFrameDs[BG.FB1..3]["nandu"..n]["boss"..b]["ds"..i]:Hide()
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end

    -- ----------------------------------------------------------------------------
    -- 拍卖装备的聊天记录
    -- ----------------------------------------------------------------------------
    do
        BG.FramePaiMaiMsg = CreateFrame("Frame", nil, BG.MainFrame,"BackdropTemplate")
        BG.FramePaiMaiMsg:SetBackdrop({
            -- bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16
        })
        -- BG.FramePaiMaiMsg:SetBackdropColor(0, 0, 0, 1)
        BG.FramePaiMaiMsg:SetPoint("CENTER")
        BG.FramePaiMaiMsg:SetSize(220,230) -- 大小
        BG.FramePaiMaiMsg:SetFrameLevel(120)
        BG.FramePaiMaiMsg:Hide()
        BG.FramePaiMaiMsg:SetScript("OnMouseUp", function(self)
        end)
        local ds = BG.FramePaiMaiMsg:CreateTexture()
        ds:SetSize(212,222)
        ds:SetPoint("CENTER")
        ds:SetColorTexture(0,0,0,0.8)

        BG.FramePaiMaiMsg2 = CreateFrame("ScrollingMessageFrame", nil, BG.FramePaiMaiMsg)
        BG.FramePaiMaiMsg2:SetSpacing(1) -- 行间隔
        BG.FramePaiMaiMsg2:SetFading(false)
        BG.FramePaiMaiMsg2:SetJustifyH("LEFT") -- 对齐格式
        BG.FramePaiMaiMsg2:SetSize(BG.FramePaiMaiMsg:GetWidth()-15,BG.FramePaiMaiMsg:GetHeight()-15) -- 大小
        BG.FramePaiMaiMsg2:SetPoint("CENTER",BG.FramePaiMaiMsg) --设置显示位置
        BG.FramePaiMaiMsg2:SetMaxLines(1000)
        -- BG.paimaimsgFrame2:SetFontObject(GameTooltipText)
        BG.FramePaiMaiMsg2:SetFont(STANDARD_TEXT_FONT,12,"OUTLINE")
        BG.FramePaiMaiMsg2:SetHyperlinksEnabled(true)
        BG.FramePaiMaiMsg2:SetScript("OnHyperlinkEnter", function (self,link,text,button)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR",0,0)
            GameTooltip:ClearLines()
            local itemID = GetItemInfoInstant(link)
            if itemID then
            GameTooltip:SetItemByID(itemID)
            GameTooltip:Show()
            end
        end)
        BG.FramePaiMaiMsg2:SetScript("OnHyperlinkLeave", function (self,link,text,button)
            GameTooltip:Hide()
        end)
        BG.FramePaiMaiMsg2:SetScript("OnHyperlinkClick", function (self,link,text,button)
            local name,link,quality,level,_,_,_,_,_,_,_,typeID=GetItemInfo(link)
            if IsShiftKeyDown() then
                _G.ChatFrame1EditBox:Show()
                _G.ChatFrame1EditBox:SetFocus()
                _G.ChatFrame1EditBox:Insert(text)
            elseif IsAltKeyDown() then
                for b = 1, Maxb[BG.FB1], 1 do
                    for i = 1, Maxi[BG.FB1], 1 do
                        if BG.Frame[BG.FB1]["boss"..b]["zhuangbei"..i] then
                            if link == select(2,GetItemInfo(BG.Frame[BG.FB1]["boss"..b]["zhuangbei"..i]:GetText())) then
                                BiaoGe[BG.FB1]["boss"..b]["guanzhu"..i] = true
                                BG.Frame[BG.FB1]["boss"..b]["guanzhu"..i]:Show()
                                BG.FrameLootMsg:AddMessage(BG.STC_g2("已成功关注装备："..link.."。团长拍卖此装备时会提醒"))
                                return
                            end
                        end
                    end
                end
            else
                ChatFrame_OnHyperlinkShow(self,link,text,button)
            end
        end)

        local bt = CreateFrame("Button",nil,BG.FramePaiMaiMsg2)   -- 到底
        bt:SetSize(30, 30)
        bt:SetPoint("BOTTOMRIGHT",BG.FramePaiMaiMsg2,"BOTTOMLEFT",-2,-10)
        bt:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollEnd-Up")
        bt:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollEnd-Down")
        bt:SetDisabledTexture("Interface/ChatFrame/UI-ChatIcon-ScrollEnd-Disabled")
        bt:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
        local chatbt = bt
        local texture = bt:CreateTexture(nil, "BACKGROUND") -- 高亮材质
        texture:SetAllPoints()
        texture:SetTexture("Interface/ChatFrame/UI-ChatIcon-BlinkHilight")
        texture:Hide()
        local hilighttexture = texture
        local time = 0
        C_Timer.NewTicker(1,function ()
            if time == 10000 then
                time = 0
            end
            if time%2 == 0  then
                texture:SetAlpha(0)
            else
                texture:SetAlpha(1)
            end
            time = time + 1
        end)
        bt:SetScript("OnClick", function(self)
            self:GetParent():ScrollToBottom()
            hilighttexture:Hide()
        end)
        BG.FramePaiMaiMsg2:SetScript("OnMouseWheel", function(self,delta,...)
            if delta == 1 then
                if IsShiftKeyDown() then
                    BG.FramePaiMaiMsg2:ScrollToTop()
                elseif IsControlKeyDown() then
                    BG.FramePaiMaiMsg2:ScrollUp()
                    BG.FramePaiMaiMsg2:ScrollUp()
                    BG.FramePaiMaiMsg2:ScrollUp()
                    BG.FramePaiMaiMsg2:ScrollUp()
                    BG.FramePaiMaiMsg2:ScrollUp()
                else 
                    BG.FramePaiMaiMsg2:ScrollUp()
                    BG.FramePaiMaiMsg2:ScrollUp()
                end
            elseif delta == -1 then
                if IsShiftKeyDown() then
                    BG.FramePaiMaiMsg2:ScrollToBottom()
                    hilighttexture:Hide()
                elseif IsControlKeyDown() then
                    BG.FramePaiMaiMsg2:ScrollDown()
                    BG.FramePaiMaiMsg2:ScrollDown()
                    BG.FramePaiMaiMsg2:ScrollDown()
                    BG.FramePaiMaiMsg2:ScrollDown()
                    BG.FramePaiMaiMsg2:ScrollDown()
                else
                    BG.FramePaiMaiMsg2:ScrollDown()
                    BG.FramePaiMaiMsg2:ScrollDown()
                    if BG.FramePaiMaiMsg2:AtBottom() then
                        hilighttexture:Hide()
                    end
                end
            end
        end)
        local bt = CreateFrame("Button",nil,BG.FramePaiMaiMsg2)   -- 下滚
        bt:SetSize(30, 30)
        bt:SetPoint("BOTTOM",chatbt,"TOP",0,-8)
        bt:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Up")
        bt:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Down")
        bt:SetDisabledTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Disabled")
        bt:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
        local chatbt = bt
        bt:SetScript("OnClick", function(self)
            self:GetParent():ScrollDown()
            self:GetParent():ScrollDown()
            if BG.FramePaiMaiMsg2:AtBottom() then
                hilighttexture:Hide()
            end
        end)
        local bt = CreateFrame("Button",nil,BG.FramePaiMaiMsg2)   -- 上滚
        bt:SetSize(30, 30)
        bt:SetPoint("BOTTOM",chatbt,"TOP",0,-8)
        bt:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Up")
        bt:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Down")
        bt:SetDisabledTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Disabled")
        bt:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
        local chatbt = bt
        bt:SetScript("OnClick", function(self)
            self:GetParent():ScrollUp()
            self:GetParent():ScrollUp()
        end)

        -- 监控聊天事件
        local f=CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_RAID_WARNING")
        f:RegisterEvent("CHAT_MSG_RAID_LEADER")
        f:SetScript("OnEvent", function(self,even,text,playerName,...)
            local a = string.find(playerName,"-")
            if a then
                playerName = strsub(playerName,1,a-1)
            end
            local msg
            local h,m = GetGameTime()
            h = string.format("%02d",h)
            m = string.format("%02d",m)
            local time = "|cff".."808080".."("..h..":"..m..")|r"
            playerName = SetClassCFF(playerName)
            msg = time.." ".."|cffFF4500[|r"..playerName.."|cff".."FF4500".."]："..text.."|r\n"    -- 团长聊天
            BG.FramePaiMaiMsg2:AddMessage(msg)
            if not BG.FramePaiMaiMsg2:AtBottom() then
                hilighttexture:Show()
            end
        end)

        local f=CreateFrame("Frame")
        f:RegisterEvent("CHAT_MSG_RAID")
        -- f:RegisterEvent("CHAT_MSG_SAY")
        f:SetScript("OnEvent", function(self,even,text,playerName,...)
            local ML
            local a = string.find(playerName,"-")
                if a then
                    playerName = strsub(playerName,1,a-1)
                end
                if playerName == BG.MasterLooter then
                    ML = true
                end
            if string.find(text,"%d+") or string.find(string.lower(text),"p") or ML then
                local msg
                local h,m = GetGameTime()
                h = string.format("%02d",h)
                m = string.format("%02d",m)
                local time = "|cff".."808080".."("..h..":"..m..")|r"
                playerName = SetClassCFF(playerName)
                if ML then
                    msg = time.." ".."|cffFF4500[|r"..playerName.."|cff".."FF4500".."]："..text.."|r\n"    -- 物品分配者聊天
                else
                    msg = time.." ".."|cffFF7F50[|r"..playerName.."|cff".."FF7F50".."]："..text.."|r\n"    -- 团员聊天
                end
                BG.FramePaiMaiMsg2:AddMessage(msg)
                if not BG.FramePaiMaiMsg2:AtBottom() then
                    hilighttexture:Show()
                end
            end
        end)

    end

    -- ----------------------------------------------------------------------------
    -- 点击聊天添加装备
    -- ----------------------------------------------------------------------------
    do
        hooksecurefunc("SetItemRef", function(link)
            local name,link,quality,level,_,_,_,_,_,_,_,typeID=GetItemInfo(link)
            if BG.MainFrame:IsShown() and BG.lastfocuszhuangbei and BG.lastfocuszhuangbei:HasFocus() then
                if BG.FrameZhuangbeiList then
                    BG.FrameZhuangbeiList:Hide()
                end
                BG.lastfocuszhuangbei:SetText(link)
                PlaySound(BG.sound1,"Master")
                if BG.lastfocuszhuangbei2 then
                    BG.lastfocuszhuangbei2:SetFocus()
                    if BG.FrameZhuangbeiList then
                        BG.FrameZhuangbeiList:Hide()
                    end
                end
            end
            if IsAltKeyDown() then
                for b = 1, Maxb[BG.FB1], 1 do
                    for i = 1, Maxi[BG.FB1], 1 do
                        if BG.Frame[BG.FB1]["boss"..b]["zhuangbei"..i] then
                            if link == select(2,GetItemInfo(BG.Frame[BG.FB1]["boss"..b]["zhuangbei"..i]:GetText())) then
                                BiaoGe[BG.FB1]["boss"..b]["guanzhu"..i] = true
                                BG.Frame[BG.FB1]["boss"..b]["guanzhu"..i]:Show()
                                BG.FrameLootMsg:AddMessage(BG.STC_g2("已成功关注装备："..link.."。团长拍卖此装备时会提醒"))
                                return
                            end
                        end
                    end
                end
            end
        end)
    end

    -- ----------------------------------------------------------------------------
    -- 清空表格
    -- ----------------------------------------------------------------------------
    do
        local bt = CreateFrame("Button", nil, BG.MainFrame, "UIPanelButtonTemplate")
        bt:SetSize(120, 25)
        bt:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 30, 30)
        bt:Show()
        BG.ButtonQingKong = bt
        -- 按钮触发
        bt:SetScript("OnClick", function()
            PlaySound(BG.sound1,"Master")
            BG.Frame:QingKong(BiaoGe[BG.FB1],BG.FB1,Maxb[BG.FB1],Maxi[BG.FB1],BiaoGeA.Hope[BG.FB1])
            if BG["Frame"..BG.FB1] and BG["Frame"..BG.FB1]:IsVisible() then
                pt(BG.STC_b1("已清空表格< "..BG.FB1.." >"))
            else
                pt(BG.STC_g1("已清空心愿< "..BG.FB1.." >"))
            end
            FrameHide(0)
        end)

        ----------------进副本提示清空表格------------------
        BG.JinBenQingKong = {}
        BG.JinBenQingKong.Button = CreateFrame("Button",nil,UIParent,"BackdropTemplate")
        BG.JinBenQingKong.Button:SetSize(300, 35)
        BG.JinBenQingKong.Button:SetPoint("TOP",UIParent,"TOP",0,-200)
        BG.JinBenQingKong.Button:SetFrameStrata("TOOLTIP")
        BG.JinBenQingKong.Button:SetFrameLevel(200)
        BG.JinBenQingKong.Button:SetNormalFontObject(BG.FontBlue1)
        BG.JinBenQingKong.Button:SetHighlightFontObject(BG.FontHilight)
        BG.JinBenQingKong.Button:Hide()
            -- 窗口变小动画函数
        function BG.ButtonDongHua(button)
            local w1 = button:GetWidth()
            local Time = 6
            local T = 600
            local t1 = Time/T
            for i = T , 2 ,-1 do
                C_Timer.After(t1,function ()
                    button:SetWidth(w1*((i-1)/T))
                end)
                t1 = t1 + Time/T
            end
        end
            -- 窗口变小动画
        BG.JinBenQingKong.DongHua = CreateFrame("Button",nil,BG.JinBenQingKong.Button,"BackdropTemplate")
        BG.JinBenQingKong.DongHua:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        })
        BG.JinBenQingKong.DongHua:SetBackdropColor(0,0.75,1,0.7)
        BG.JinBenQingKong.DongHua:SetSize(BG.JinBenQingKong.Button:GetSize())
        BG.JinBenQingKong.DongHua:SetPoint("TOPLEFT",BG.JinBenQingKong.Button,"TOPLEFT",0,0)
        BG.JinBenQingKong.DongHua:SetFrameLevel(119)
        BG.JinBenQingKong.DongHua:SetScript("OnSizeChanged",function (self,Width,Height)
            local w = string.format("%u",Width)
            if w == "0" then
                C_Timer.After(0.2,function ()
                    BG.JinBenQingKong.DongHua:GetParent():Hide()
                end)
            end
        end)

        StaticPopupDialogs["QINGKONGBIAOGE"] = {
            text = "确认清空表格？",
            button1 = "是",
            button2 = "否",
            OnAccept = function()
                if BG.FB2 then
                    BG.Frame:QingKong(BiaoGe[BG.FB2],BG.FB2,Maxb[BG.FB2],Maxi[BG.FB2])
                    pt(BG.STC_b1("已清空表格< "..BG.FB2.." >"))
                end
            end,
            OnCancel = function ()
            end,
            timeout = 3,
            whileDead = true,
            hideOnEscape = true,
        }

        BG.JinBenQingKong.Button:SetScript("OnClick",function ()
            StaticPopup_Show("QINGKONGBIAOGE")
        end)
        
    end

    -- ----------------------------------------------------------------------------
    -- 隐藏装备
    -- ----------------------------------------------------------------------------
    do
        --点击
        local function OnClick(self,event)
            local FB = BG.FB1
            local _,class = UnitClass("player")
            local num = self.num
            if self.icon:IsDesaturated() then    -- 如果已经去饱和（就是不生效的状态）
                for i=1,3 do
                    if BG.frameFilterIcon["Button"..i].icon then
                        BG.frameFilterIcon["Button"..i].icon:SetDesaturated(true)
                    end
                end
                BiaoGeA.filterClassNum = num
                self.icon:SetDesaturated(false)
                BG.buttonHFilter0:SetPoint("CENTER",self,"CENTER")
                BG.buttonHFilter0:Show()

                for b=1,Maxb[FB] do -- 当前表格
                    for i=1,Maxi[FB] do
                        local bt = BG.Frame[FB]["boss"..b]["zhuangbei"..i]
                        if bt then
                            BG.FilterClass(FB,b,i,bt,class,num,BiaoGeFilterTooltip,"Frame")
                        end
                   end
                end
                for b=1,Maxb[FB] do -- 历史表格
                    for i=1,Maxi[FB] do
                        local bt = BG.HistoryFrame[FB]["boss"..b]["zhuangbei"..i]
                        if bt then
                            BG.FilterClass(FB,b,i,bt,class,num,BiaoGeFilterTooltip,"HistoryFrame")
                        end
                   end
                end
                for n=1,HopeMaxn[FB] do -- 心愿清单
                    for b=1,HopeMaxb[FB] do
                        for i=1,2 do
                            local bt = BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]
                            if bt then
                                BG.FilterClass(FB,b,i,bt,class,num,BiaoGeFilterTooltip,"HopeFrame",n)
                            end
                        end
                    end
                end
                if BG.ZhuangbeiList then
                    local i=1
                    while BG.ZhuangbeiList["button"..i] do
                        local button = BG.ZhuangbeiList["button"..i]
                        BG.FilterClass(nil,nil,nil,button,class,num,BiaoGeFilterTooltip,"zhuangbei")
                        i = i + 1
                    end
                end
            else
                BiaoGeA.filterClassNum = 0
                self.icon:SetDesaturated(true)
                BG.buttonHFilter0:Hide()

                local alpha = 1
                for b=1,Maxb[FB] do
                    for i=1,Maxi[FB] do
                        local bt = BG.Frame[FB]["boss"..b]["zhuangbei"..i]
                        if bt then
                            BG.Frame[FB]["boss"..b]["zhuangbei"..i]:SetAlpha(alpha)
                            BG.Frame[FB]["boss"..b]["maijia"..i]:SetAlpha(alpha)
                            BG.Frame[FB]["boss"..b]["jine"..i]:SetAlpha(alpha)
                            BG.Frame[FB]["boss"..b]["guanzhu"..i]:SetAlpha(alpha)
                            BG.FrameDs[FB..1]["boss"..b]["ds"..i]:SetAlpha(alpha)
                            BG.FrameDs[FB..2]["boss"..b]["ds"..i]:SetAlpha(alpha)
                            BG.FrameDs[FB..3]["boss"..b]["ds"..i]:SetAlpha(alpha)

                            BG.HistoryFrame[FB]["boss"..b]["zhuangbei"..i]:SetAlpha(alpha)
                            BG.HistoryFrame[FB]["boss"..b]["maijia"..i]:SetAlpha(alpha)
                            BG.HistoryFrame[FB]["boss"..b]["jine"..i]:SetAlpha(alpha)
                            BG.HistoryFrameDs[FB..1]["boss"..b]["ds"..i]:SetAlpha(alpha)
                        end
                    end
                end
                for n=1,HopeMaxn[FB] do
                    for b=1,HopeMaxb[FB] do
                        for i=1,2 do
                            local bt = BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]
                            if bt then
                                BG.HopeFrame[FB]["nandu"..n]["boss"..b]["zhuangbei"..i]:SetAlpha(alpha)
                                BG.HopeFrame[FB]["nandu"..n]["boss"..b]["yidiaoluo"..i]:SetAlpha(alpha)
                                BG.HopeFrameDs[FB..1]["nandu"..n]["boss"..b]["ds"..i]:SetAlpha(alpha)
                                BG.HopeFrameDs[FB..2]["nandu"..n]["boss"..b]["ds"..i]:SetAlpha(alpha)
                                BG.HopeFrameDs[FB..3]["nandu"..n]["boss"..b]["ds"..i]:SetAlpha(alpha)
                            end
                        end
                    end
                end
                if BG.ZhuangbeiList then
                    local i=1
                    while BG.ZhuangbeiList["button"..i] do
                        BG.ZhuangbeiList["button"..i]:SetAlpha(alpha)
                        i = i + 1
                    end
                end
            end
            PlaySound(BG.sound1,"Master")
        end
        local function OnEnter(self,event)
            GameTooltip:SetOwner(self,"ANCHOR_TOPLEFT",0,0)
            GameTooltip:ClearLines()
            GameTooltip:SetText("高亮该天赋的装备")
        end
        local function OnLeave(self,event)
            GameTooltip:Hide()
        end

        -- 开始
        do
            BG.frameFilterIcon = CreateFrame("Frame",nil,BG.MainFrame)
            local _,class = UnitClass("player")
            local next

            local bt0 = CreateFrame("Button", nil, BG.frameFilterIcon)  -- 高亮背景
            bt0:SetSize(38, 38)
            bt0:SetFrameLevel(102)
            BG.buttonHFilter0 = bt0
            bt0:Hide()
            local texture = bt0:CreateTexture(nil, "BACKGROUND") -- 高亮材质
            texture:SetAllPoints()
            texture:SetTexture("Interface/ChatFrame/UI-ChatIcon-BlinkHilight")

            for i=1,3 do
                local bt = CreateFrame("Button",nil,BG.frameFilterIcon,"BackdropTemplate")
                bt:SetSize(25, 25)
                bt:SetFrameLevel(105)
                if i==1 then
                    bt:SetPoint("BOTTOMLEFT", BG.MainFrame, "BOTTOMLEFT", 370, 30)
                else
                    bt:SetPoint("LEFT", next, "RIGHT", 8, 0)
                end
                next = bt
                BG.frameFilterIcon["Button"..i] = bt
                BG.frameFilterIcon["Button"..i].num = i
                if not BiaoGeA.filterClassNum then
                    BiaoGeA.filterClassNum = 0
                end

                if BG.Icon[class..i] then
                    local icon = bt:CreateTexture(nil, "ARTWORK")    -- 图标
                    icon:SetAllPoints()
                    icon:SetTexture(BG.Icon[class..i])
                    icon:SetDesaturated(true)
                    BG.frameFilterIcon["Button"..i].icon = icon
                    if tonumber(BiaoGeA.filterClassNum) == tonumber(i) then
                        icon:SetDesaturated(false)
                        BG.buttonHFilter0:SetPoint("CENTER",BG.frameFilterIcon["Button"..i],"CENTER")
                        BG.buttonHFilter0:Show()
                    end

                    local higt = bt:CreateTexture() -- 高亮材质
                    higt:SetSize(21,21)
                    higt:SetPoint("CENTER")
                    higt:SetColorTexture(RGB("FFFFFF",0.1))
                    bt:SetHighlightTexture(higt)
                else
                    bt:Hide()
                end

                bt:SetScript("OnClick",OnClick)
                bt:SetScript("OnEnter",OnEnter)
                bt:SetScript("OnLeave",OnLeave)
            end
        end
    end

    ------------------金额自动加0------------------
    do
        local bt = CreateFrame("CheckButton", nil, BG.FrameSheZhi, "ChatConfigCheckButtonTemplate")
        bt:SetSize(30, 30)
        bt:SetHitRectInsets(0, -100, 0, 0)
        bt:SetPoint("TOPLEFT", BG.ButtonAutoTrade, "BOTTOMLEFT", 0, 0)
        bt.Text:SetText("<金额自动加零>")
        bt:Show()
        BG.ButtonAutoJine0 = bt
        if not BiaoGe.AutoJine0 then
            BiaoGe.AutoJine0 = 1
            bt:SetChecked(true)
        elseif BiaoGe.AutoJine0 == 1 then
            bt:SetChecked(true)
        elseif BiaoGe.AutoJine0 == 0 then
            bt:SetChecked(false)
        end
        bt:SetScript("OnClick", function(self)
            if self:GetChecked() then
                BiaoGe.AutoJine0 = 1
            else
                BiaoGe.AutoJine0 = 0
            end
            PlaySound(BG.sound1,"Master")
        end)
        -- 鼠标悬停提示
        bt:SetScript("OnEnter", function(self)
            local text = "|cffffffff< 注意事项 >|r\n\n1、输入金额和欠款时自动加两个0\n"
            GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0)
            GameTooltip:ClearLines()
            GameTooltip:SetText(text)
        end)
        bt:SetScript("OnLeave",function (self)
            GameTooltip:Hide()
        end)
    end

    ------------------界面缩放------------------
    do
        BG.SuoFang = {}
            -- 添加文字"UI缩放"
        local f = BG.FrameSheZhi:CreateFontString()
        f:SetPoint("TOPLEFT", BG.ButtonAutoJine0, "BOTTOM",15,-15)
        f:SetFontObject(GameFontNormal)
        f:SetText("|cffFFFFFF<UI缩放>|r")
        f:Show()
        local s = f
        BG.SuoFang.BiaoTi = f
            -- 滑块
        local f = CreateFrame("Slider", nil, BG.FrameSheZhi, "OptionsSliderTemplate")
        f:SetSize(100, 15)
        f:SetPoint("TOP", s, "BOTTOM", 0, -3)
        f:Show()
        local low,higt = 0.6,1.3
        f:SetMinMaxValues(low,higt)
        f.Low:SetText(low)
        f.High:SetText(higt)
        f:SetValueStep(0.1)     -- 设置滑块在拖动时是否将值限制为值步长
        f:SetObeyStepOnDrag(true)
        -- pt(UIParent:GetScale())
        if not BiaoGe.Scale then
            local ui = UIParent:GetScale()
            if tonumber(ui) >= 0.85 then
                BiaoGe.Scale = 0.7
            elseif tonumber(ui) >= 0.75 then
                BiaoGe.Scale = 0.8
            elseif tonumber(ui) >= 0.65 then
                BiaoGe.Scale = 0.9
            else
                BiaoGe.Scale = 1
            end
        end
        f:SetValue(BiaoGe.Scale)
        BG.MainFrame:SetScale(BiaoGe.Scale)
        BG.helperFrame:SetScale(BiaoGe.Scale)
        BG.ReceiveMainFrame:SetScale(tonumber(BiaoGe.Scale)*0.9)
        BG.SuoFang.HuaKuai = f
            -- 添加滑块的数字显示
        local num = BG.FrameSheZhi:CreateFontString()
        num:SetPoint("CENTER", f, "CENTER", 0, -15)
        num:SetFontObject(GameFontNormal)
        num:SetText(BiaoGe.Scale)
        num:Show()
            -- 按键触发
        f:SetScript("OnValueChanged", function(self,value)
            value = string.format("%.1f",value)
            BiaoGe.Scale = value
            num:SetText(BiaoGe.Scale)
        end)
        f:SetScript("OnMouseUp", function(self)
            BG.MainFrame:SetScale(BiaoGe.Scale)            
            BG.helperFrame:SetScale(BiaoGe.Scale)
            BG.ReceiveMainFrame:SetScale(tonumber(BiaoGe.Scale)*0.9)
            PlaySound(BG.sound1,"Master")
        end)
        BG.SuoFang.ShuZi = f
    end

    ------------------UI透明度------------------
    do
        BG.TouMing = {}
            -- 添加文字"UI透明度"
        local f = BG.FrameSheZhi:CreateFontString()
        f:SetPoint("TOP", BG.SuoFang.ShuZi, "BOTTOM",0,-40)
        f:SetFontObject(GameFontNormal)
        f:SetText("|cffFFFFFF<UI透明度>|r")
        local s = f
        BG.TouMing.BiaoTi = f
            -- 滑块
        local f = CreateFrame("Slider", nil, BG.FrameSheZhi, "OptionsSliderTemplate")
        f:SetSize(100, 15)
        f:SetPoint("TOP", s, "BOTTOM", 0, -3)
        local low,higt = 0.6,1
        f:SetMinMaxValues(low,higt)
        f.Low:SetText(low)
        f.High:SetText(higt)
        f:SetValueStep(0.05)     -- 设置滑块在拖动时是否将值限制为值步长
        f:SetObeyStepOnDrag(true)
        if not BiaoGe.Alpha then
            BiaoGe.Alpha = 1
        end
        f:SetValue(BiaoGe.Alpha)
        BG.MainFrame:SetAlpha(BiaoGe.Alpha)
        BG.helperFrame:SetAlpha(BiaoGe.Alpha)
        BG.TouMing.HuaKuai = f
            -- 添加滑块的数字显示
        local num = BG.FrameSheZhi:CreateFontString()
        num:SetPoint("CENTER", f, "CENTER", 0, -15)
        num:SetFontObject(GameFontNormal)
        num:SetText(BiaoGe.Alpha)
            -- 按键触发
        f:SetScript("OnValueChanged", function(self,value)
            value = string.format("%.2f",value)
            BiaoGe.Alpha = tonumber(value)
            num:SetText(BiaoGe.Alpha)
        end)
        f:SetScript("OnMouseUp", function(self)
            BG.MainFrame:SetAlpha(BiaoGe.Alpha)
            BG.helperFrame:SetAlpha(BiaoGe.Alpha)
            PlaySound(BG.sound1,"Master")
        end)
        BG.TouMing.ShuZi = f
    end

    if BiaoGe.HopeShow then
        BG["HopeFrame"..BG.FB1]:Show()
        BG.ButtonQingKong:SetText("清空当前心愿")
        BG.ButtonHope:SetText("关闭心愿清单")

        BG["Button"..BG.FB1]:SetEnabled(false)
        BG.History.HistoryButton:SetEnabled(false)
        BG.History.SaveButton:SetEnabled(false)
        BG.History.SendButton:SetEnabled(false)
        BG.ButtonWenBen:SetEnabled(false)
    else
        BG["Frame"..BG.FB1]:Show()
        BG.ButtonQingKong:SetText("清空当前表格")
        BG.ButtonHope:SetText("心愿清单")
        BG["Button"..BG.FB1]:SetEnabled(false)
        BG.History.HistoryButton:SetEnabled(true)
        BG.History.SaveButton:SetEnabled(true)
        BG.History.SendButton:SetEnabled(true)
        BG.ButtonWenBen:SetEnabled(true)
    end
    ------------------检查版本过期------------------
    do
        C_Timer.After(3,function ()
            local guoqi
            local function VerGuoQi(BGVer,ver)      -- 如果版本过期则反馈true
                local BGVer = string.gsub(BGVer,"v","")
                BGVer = string.gsub(BGVer,"%.","")
                local ver = string.gsub(ver,"v","")
                ver = string.gsub(ver,"%.","")
                if tonumber(BGVer) and tonumber(ver) then
                    if tonumber(ver) > tonumber(BGVer) then
                        return true
                    end
                end
            end
            
            local function SendVerCheck(channel)    -- 发送版本请求
                C_ChatInfo.SendAddonMessage("BiaoGe", "VersionCheck", channel)
            end
            
            local f=CreateFrame("Frame")
            f:RegisterEvent("CHAT_MSG_ADDON")
            f:SetScript("OnEvent", function (self,even,...)
                if guoqi then return end
                local prefix, msg, distType, sender = ...
                if prefix == "BiaoGe" then
                    local sendername = strsplit("-", sender)
                    local playername = UnitName("player")
                    if sendername == playername then return end
                    if msg == "VersionCheck" then
                        C_ChatInfo.SendAddonMessage("BiaoGe", "MyVer-"..BG.Ver, distType)
                    elseif strfind(msg, "MyVer") then
                        local _, version = strsplit("-", msg)
                        if VerGuoQi(BG.Ver,version) then
                            pt("|cff00BFFF< BiaoGe > 版本过期提醒，最新版本是："..BG.STC_g1(version).."，你的当前版本是："..BG.STC_r1(BG.Ver))
                            pt("|cff00BFFF你可以前往curseforge搜索biaoge更新")
                            BG.ShuoMingShuText:SetText("<说明书与更新记录> "..BG.STC_r1(BG.Ver))
                            guoqi = true
                        end
                    end
                end
            end)
            
            local channel
            if IsInRaid() then
                channel = "RAID"
            elseif IsInGuild() then
                channel = "GUILD"
            end
            if channel then 
                SendVerCheck(channel) 
            end
        end)
    end
end

------------------插件载入------------------
do
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(self, event, addonName)
        if addonName == "BiaoGe" then
            BiaoGeUI()
            C_Timer.After(1,function ()
                print("|cff00BFFF< BiaoGe > 金团表格载入成功。小地图图标：星星\n打开金团表格：/biaoge或/gbg\n打开团减助手：/rbg|r")
            end)
        end
    end)

    ------------------插件命令------------------
    SlashCmdList["BIAOGE"] = function()
        if BG.MainFrame and not BG.MainFrame:IsVisible() then
            BG.MainFrame:Show()
        else
            BG.MainFrame:Hide()
        end
    end
    SLASH_BIAOGE1 = "/biaoge"
    SLASH_BIAOGE2 = "/gbg"

    SlashCmdList["BIAOGEHELPER"] = function()
        if BG.helperFrame and not BG.helperFrame:IsVisible() then
            BG.helperFrame:Show()
        else
            BG.helperFrame:Hide()
        end
    end
    SLASH_BIAOGEHELPER1 = "/rbg"

    -- DEBUG
    SlashCmdList["BIAOGETEST"] = function()

        if BG.DeBugLoot then
            BG.DeBug = true
            BG.DeBugLoot()
        end

        BG.tradeQuality = 1 -- 交易物品的品质改为绿色

    end
    SLASH_BIAOGETEST1 = "/bgdebug"
end


--[[

    全局变量：
    BiaoGe       数据库
    BG.Frame      数据库对应的框体

    FB1     是UI当前选择的副本
    FB2     是玩家当前所处的副本

    ]]





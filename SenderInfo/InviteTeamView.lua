

local __addon, __private = ...;

local InviteTeamView = {}
__private.InviteTeamView = InviteTeamView;

local OpenTeamHelper = true;
local panel;
local panel2
local scrollChild;
local infoCountTitle;
local lessen;
local PanelMove = false;
local offsetPos;
--数据
local allItem = {}
local heightInterval = 2;
local allItemDic = {};
local allInfo = {};
local viewWidth = 1000;
local viewHeight = 260;
--是否缩小
local panelLessen = false;

local autoOpenHelperTime = 10; --自动打开助手界面 被缩小的时候

local lastLessenTime = 0; --最后被关闭的时间

local seekTeamOpen = true; --寻求组队开着的时候才会统计小助手

local seekState = false; --当前寻求组队状态
local leaderOpenHelper = true; --是队长时 自动打开小助手

local replyMsg1 = ""; --快捷回复
local replyMsg2 = ""; --快捷回复
local replyMsg3 = ""; --快捷回复
local replyMsg4 = ""; --快捷回复
local replyMsg5 = ""; --快捷回复
local replyMsg6 = ""; --快捷回复

SenderInfoHelperPos = {x = 250,y = -100};

local function ChangeInfoCountTitle(count)
    infoCountTitle:SetText("当前信息数量: " .. count)
    if panelLessen and lessen then
        lessen:SetText("SenderInfo 消息:" .. #allItem);

        if autoOpenHelperTime < 9999 and ( GetTime() - lastLessenTime) >= autoOpenHelperTime then
            
            if panel2 then
                panel2:Show();
            end

        end

    end
end


local function Frame_OnMouseUp(Frame, button)
    PanelMove = false;
end

local function Frame_OnMouseDown(Frame, button)
    PanelMove = true;
    local mx, my = GetCursorPosition();
    local _,_,_,x,y = panel:GetPoint();
    offsetPos = {x = mx-x ,y = my-y};
end

local function Frame_OnUpdate(Frame, button)

    if not PanelMove then
        return;
    end

    local x, y = GetCursorPosition();

    local nx,ny = x-offsetPos.x,y-offsetPos.y;

    panel:SetPoint("TOPLEFT",nx,ny);

    SenderInfoHelperPos.x = nx;
    SenderInfoHelperPos.y = ny;
end



--在滚动对象中添加一个实体
local function AddItem(item,name)
    
    item:SetParent(scrollChild);

    allItem[#allItem+1] = item;

    local height = item:GetHeight();

    local allHeight = (#allItem-1) * (height+heightInterval);

    item:SetPoint("TOPLEFT",0,-allHeight);

    ChangeInfoCountTitle(#allItem);

    allItemDic[name] = item;
end

--移除一个实体
local function RemoveItem(item,name)
    
    local height = item:GetHeight();

    local removeIndex = 0;
    for index, value in ipairs(allItem) do
        if value == item then
            item:Hide();
            removeIndex = index;
            table.remove(allItem,index)
            break
        end
    end
    

    for i = removeIndex, #allItem, 1 do

        local otherItem = allItem[i];

        local allHeight = (i-1) * (height+heightInterval);
    
        otherItem:SetPoint("TOPLEFT",0,-allHeight);

    end

    ChangeInfoCountTitle(#allItem);

    allItemDic[name] = nil;

    allInfo[name] = nil;

    __private.Main:RemoveTargetNotifyInfo(name);
end

local function ClearAll()
    for i = #allItem, 1, -1 do
        local item = allItem[i];
        item:Hide();
    end
    allItem = {};
    allItemDic = {};
    allInfo = {};
    ChangeInfoCountTitle(#allItem);
    __private.Main:ClearNotifyInfo();
end

local replyView;
local replyName;

local function ReplyTargetMsg(msg)

    if msg and msg ~= "" and replyName then
        --print(msg,replyName)
        SendChatMessage(msg,"WHISPER",nil,replyName)
    end

    if InviteTeamView then
        InviteTeamView:Remove(replyName)
    end

    if replyView then
        replyView:SetParent(panel)
        replyView:Hide();
    end
end

local replyBtnW = 150;

---按钮上的显示文本 因为太长了需要截取
local function GetReplyBtnShowTxt(msg)
    
    --一个中文字是13 但是他也有可能输入因为所以不管了只是会显示[] 可以接受
    if not msg or #msg <= 24 then
        return msg
    end

    return strsub(msg,1,24) .. "..."
end


local function CreateReplyView()

    if not panel then
        print("not panel  / CreateReplyView")
        return
    end

    local view = CreateFrame("Frame",nil,panel2)
    view:SetSize(viewWidth,viewHeight);
    view:SetPoint("TOPRIGHT",0,0);
    view:SetScript("OnMouseDown",function ()
        view:Hide();
    end);
    --local  tex11 = view:CreateTexture ( nil ,  "BACKGROUND" ) 
    --tex11:SetAllPoints () 
    --tex11:SetColorTexture ( 1 ,  1 ,  1 ,  0.5 )


    local item = CreateFrame("Frame",nil,view)
    item:SetSize(replyBtnW + 10,180);
    item:SetPoint("TOPRIGHT",5,-60);
    local  tex = item:CreateTexture ( nil ,  "BACKGROUND" ) 
    tex:SetAllPoints () 
    tex:SetColorTexture ( 0 ,  0 ,  0 , 1)

    local btn1 = CreateFrame("Button",nil,item,"UIPanelButtonTemplate")
    btn1:SetPoint("TOPLEFT",5,0);
    btn1:SetSize(replyBtnW,30);
    btn1:SetText(GetReplyBtnShowTxt(replyMsg1));
    btn1:SetScript("OnClick",function ()
        ReplyTargetMsg(replyMsg1);
    end);

    local btn2 = CreateFrame("Button",nil,item,"UIPanelButtonTemplate")
    btn2:SetPoint("TOPLEFT",5,-30);
    btn2:SetSize(replyBtnW,30);
    btn2:SetText(GetReplyBtnShowTxt(replyMsg2));
    btn2:SetScript("OnClick",function ()
        ReplyTargetMsg(replyMsg2);
    end);


    local btn3 = CreateFrame("Button",nil,item,"UIPanelButtonTemplate")
    btn3:SetPoint("TOPLEFT",5,-60);
    btn3:SetSize(replyBtnW,30);
    btn3:SetText(GetReplyBtnShowTxt(replyMsg3));
    btn3:SetScript("OnClick",function ()
        ReplyTargetMsg(replyMsg3);
    end);

    local btn4 = CreateFrame("Button",nil,item,"UIPanelButtonTemplate")
    btn4:SetPoint("TOPLEFT",5,-90);
    btn4:SetSize(replyBtnW,30);
    btn4:SetText(GetReplyBtnShowTxt(replyMsg4));
    btn4:SetScript("OnClick",function ()
        ReplyTargetMsg(replyMsg4);
    end);

    local btn5 = CreateFrame("Button",nil,item,"UIPanelButtonTemplate")
    btn5:SetPoint("TOPLEFT",5,-120);
    btn5:SetSize(replyBtnW,30);
    btn5:SetText(GetReplyBtnShowTxt(replyMsg5));
    btn5:SetScript("OnClick",function ()
        ReplyTargetMsg(replyMsg5);
    end);

    local btn6 = CreateFrame("Button",nil,item,"UIPanelButtonTemplate")
    btn6:SetPoint("TOPLEFT",5,-150);
    btn6:SetSize(replyBtnW,30);
    btn6:SetText(GetReplyBtnShowTxt(replyMsg6));
    btn6:SetScript("OnClick",function ()
        ReplyTargetMsg(replyMsg6);
    end);

    return view;
end



local function OpenReplyView(btn,name)
    
    if not replyView then
        replyView = CreateReplyView();
    end

    replyName = name;
    replyView:Show();
    replyView:SetFrameLevel(9999);
end



--滚动的具体实体
local function CreateScrollItem(name,info)
    local item = CreateFrame("Frame")
    item:SetSize(scrollChild:GetWidth(),30);
    local  tex = item:CreateTexture ( nil ,  "BACKGROUND" ) 
    tex:SetAllPoints () 
    tex:SetColorTexture ( 1 ,  1 ,  1 ,  0.5 )

    local title = item:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
    title:SetPoint("LEFT",5,0)
    title:SetText(info)


    local btn = CreateFrame("Button",nil,item,"UIPanelButtonTemplate")
    btn:SetPoint("RIGHT");
    btn:SetSize(28,28);
    btn:SetText("邀");
    btn:SetScript("OnClick",function ()

        --如果你当前不在团队中 且 当前已经有5个小队成员 你还选择继续邀请
        --所以我认为你是想开团队 所以这里不做选项处理直接转团
        --如果不想自动转团请不要5人了还邀请
        if not IsInRaid() and GetNumGroupMembers() == 5 then
            ConvertToRaid();
        end

        InviteUnit(name)
    end);

    local btn3 = CreateFrame("Button",nil,item,"UIPanelButtonTemplate")
    btn3:SetPoint("RIGHT",-30,0);
    btn3:SetSize(28,28);
    btn3:SetText("查");
    btn3:SetScript("OnClick",function ()
        local alaMeta = _G.__ala_meta__;
        if alaMeta and alaMeta.emu then
            alaMeta.emu.MT.SendQueryRequest(name, nil, true, true)
        end
    end);

    local btn4 = CreateFrame("Button",nil,item,"UIPanelButtonTemplate")
    btn4:SetPoint("RIGHT",-60,0);
    btn4:SetSize(28,28);
    btn4:SetText("私");
    btn4:SetScript("OnClick",function ()

        local editBox = ChatEdit_ChooseBoxForSend();
        local hasText = editBox:GetText()
        if editBox:HasFocus() then
            editBox:SetText(string.format("/w %s %s",name,hasText));
        else
            ChatEdit_ActivateChat(editBox)
            editBox:SetText(string.format("/w %s %s",name,hasText));
        end

    end);

    local btn2 = CreateFrame("Button",nil,item,"UIPanelButtonTemplate")
    btn2:SetPoint("RIGHT",-90,0);
    btn2:SetSize(28,28);
    btn2:SetText("略");
    btn2:SetScript("OnClick",function ()
        RemoveItem(item,name);
    end);


    local btn5 = CreateFrame("Button",nil,item,"UIPanelButtonTemplate")
    btn5:SetPoint("RIGHT",-120,0);
    btn5:SetSize(28,28);
    btn5:SetText("回");
    btn5:SetScript("OnClick",function ()
        OpenReplyView(btn5,name);
    end);

    return item
end


function InviteTeamView:ClearPanel()

    if panel and panel:IsShown() then
        ClearAll();
        panel:Hide();
    end

    if panel then
        panel:UnregisterAllEvents();
    end
  
    replyView = nil;
    panel2 = nil;
    lessen = nil;
    infoCountTitle = nil;
    scrollChild = nil;
    panel = nil;
end


local function CreateTeamHelper()
    
    --创建一个最大框体
    panel = CreateFrame("Frame","InviteTeamView",UIParent);

    panel:SetPoint("TOPLEFT",SenderInfoHelperPos.x,SenderInfoHelperPos.y);
    panel:SetSize(10,10);

    panel2 = CreateFrame("Frame","InviteTeamView",panel);

    panel2:SetPoint("TOPLEFT",0,0);
    panel2:SetSize(viewWidth,viewHeight);

    local tex = panel2:CreateTexture ( nil ,  "BACKGROUND" ) 
    tex:SetAllPoints () 
    tex:SetColorTexture ( 0 ,  0 ,  0 ,  0.5 )


    panelLessen = false;
    lessen = CreateFrame("Button",nil,panel,"UIPanelButtonTemplate")
    lessen:SetPoint("TOPLEFT",10,-10);
    lessen:SetSize(150,40);
    lessen:SetText("SenderInfo 缩小");
    lessen:SetFrameLevel(99999);
    lessen:SetScript("OnClick",function ()
        
        if not panelLessen then
            panel2:Hide();
            lastLessenTime = GetTime();
            lessen:SetText("SenderInfo 消息:" .. #allItem);
        else
            panel2:Show();
            lessen:SetText("SenderInfo 缩小");
        end
        panelLessen = not panelLessen;
    end);

    local title = panel2:CreateFontString("viewTitle", nil, "GameFontNormalLarge")
    title:SetPoint("TOPLEFT",175,-10)
    local name = "小助手";
    title:SetText(name)

    infoCountTitle = panel2:CreateFontString("infoCountTitle", nil, "GameFontNormalLarge")
    infoCountTitle:SetPoint("TOPLEFT",175,-30)
    infoCountTitle:SetText("当前信息数量: 0")

    panel2:EnableMouse(true);
    panel2:SetMovable(true);
    panel2:SetResizable(true);

    panel2:SetScript("OnMouseDown",Frame_OnMouseDown);

    panel2:SetScript("OnMouseUp", Frame_OnMouseUp);

    panel2:SetScript("OnUpdate", Frame_OnUpdate);


    ---创建一个滚动界面
    local scrollFrame = CreateFrame("ScrollFrame",nil,panel2,"UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT",15,-55);
    scrollFrame:SetSize(viewWidth-50,viewHeight - 60);


    --滚动界面的滚动对象
    scrollChild = CreateFrame("Frame")
    scrollFrame:SetScrollChild(scrollChild)
    scrollChild:SetWidth(scrollFrame:GetWidth())
    scrollChild:SetHeight(scrollFrame:GetHeight()) 



    --滚动界面上有一个关闭按钮
    local btn = CreateFrame("Button",nil,panel2,"UIPanelButtonTemplate")
    btn:SetPoint("TOPRIGHT",-10,-10);
    btn:SetSize(50,30);
    btn:SetText("关闭");
    btn:SetScript("OnClick",function ()
        panel:Hide();
    end);

    local btn2 = CreateFrame("Button",nil,panel2,"UIPanelButtonTemplate")
    btn2:SetPoint("TOPRIGHT",-65,-10);
    btn2:SetSize(80,30);
    btn2:SetText("清理所有");
    btn2:SetScript("OnClick",function ()
        ClearAll();
    end);


    local btn3 = CreateFrame("Button",nil,panel2,"UIPanelButtonTemplate")
    btn3:SetPoint("TOPRIGHT",-150,-10);
    btn3:SetSize(100,30);
    btn3:SetText("打开插件设置");
    btn3:SetScript("OnClick",function ()
        InterfaceOptionsFrame_OpenToCategory("SenderInfo");
        InterfaceOptionsFrameAddOnsListScrollBar:SetValue(0);
        InterfaceOptionsFrame_OpenToCategory("SenderInfo");
    end);

end


function InviteTeamView:ChangeViewHelper(show)

    if show then
        if not panel then
            CreateTeamHelper();
        end
    
        if not panel:IsShown() then
            panel:Show();
        end

    else

        if panel and panel:IsShown() then
            panel:Hide();
        end

    end

end

function InviteTeamView:SwichViewHelper()
    
    if panel and panel:IsShown() then
        InviteTeamView:ChangeViewHelper(false)
    else
        InviteTeamView:ChangeViewHelper(true)
    end
end


function InviteTeamView:Add(name,info)
    
    if not OpenTeamHelper then
        return
    end


    local needOpenPanel = true;


    --如果打开不影响
    if seekTeamOpen then
        if not seekState then
            needOpenPanel = false;
        end
    end



    if leaderOpenHelper then

        --有寻求组队判断 不需要这个了
        local groupNum = GetNumGroupMembers()

        if groupNum ~= 0 then
            
            local isInRaid = IsInRaid();
            local maxNum = isInRaid and 25 or 5;
            local isInGroup = IsInGroup()
            local isLeader = UnitIsGroupLeader('player') --团长 队长
            local isAssistant = UnitIsGroupAssistant('player') --助手

            --已满
            if groupNum >= maxNum then
                needOpenPanel = false;
            end

            --不是队长 也不是助理
            if not isLeader and not isAssistant then
                needOpenPanel = false;
            else
                needOpenPanel = true;
            end

        end

    end


    --如果已经打开的不受影响还是会继续收集信息
    if needOpenPanel then
        InviteTeamView:ChangeViewHelper(true);
    end


    --如果已经打开的会继续添加
    if panel and panel:IsShown() then

        allInfo[name] = info;

        local item = CreateScrollItem(name,info);
    
        AddItem(item,name);   
    end
end

--成功加入队伍时 会被调用 移除
function InviteTeamView:Remove(name)
    
    if not allItemDic[name] then
        return;
    end

    RemoveItem(allItemDic[name],name);

end



function InviteTeamView:ChangeOpenTeamHelper(set)
    OpenTeamHelper = set;
    self:ClearPanel();
end

function InviteTeamView:ChangeSeekTeamOpen(set)
    seekTeamOpen = set;
end

function InviteTeamView:ChangeLeaderOpenHelper(set)
    leaderOpenHelper = set;
end


function InviteTeamView:ChangeViewWidth(value)
    viewWidth = value;
    self:ClearPanel();
end

function InviteTeamView:ChangeAutoOpenHelperTime(value)
    autoOpenHelperTime = value;
end

function InviteTeamView:ResetHelperViewPos(value)
    SenderInfoHelperPos = {x = 250,y = -100};
    self:ClearPanel();
end


function InviteTeamView:ChangeReplyMsg1(value)
    replyMsg1 = value;
end
function InviteTeamView:ChangeReplyMsg2(value)
    replyMsg2 = value;
end
function InviteTeamView:ChangeReplyMsg3(value)
    replyMsg3 = value;
end
function InviteTeamView:ChangeReplyMsg4(value)
    replyMsg4 = value;
end
function InviteTeamView:ChangeReplyMsg5(value)
    replyMsg5 = value;
end
function InviteTeamView:ChangeReplyMsg6(value)
    replyMsg6 = value;
end





function InviteTeamView:Init()
    
    OpenTeamHelper = __private.View.Cfg.OpenTeamHelper

    viewWidth = __private.View.Cfg.TeamHelperViewWidth
    
    autoOpenHelperTime = __private.View.Cfg.AutoOpenHelperTime

    seekTeamOpen = __private.View.Cfg.SeekTeamOpen

    leaderOpenHelper = __private.View.Cfg.LeaderOpenHelper
    
    
    replyMsg1 = __private.View.Cfg.ReplyMsg1;
    replyMsg2 = __private.View.Cfg.ReplyMsg2;
    replyMsg3 = __private.View.Cfg.ReplyMsg3;
    replyMsg4 = __private.View.Cfg.ReplyMsg4;
    replyMsg5 = __private.View.Cfg.ReplyMsg5;
    replyMsg6 = __private.View.Cfg.ReplyMsg6;

end


local function LFG_LIST_ACTIVE_ENTRY_UPDATE(self,event,state,...)   
    --开着寻求组队下线 上下 得到的状态是false
    --打开的时候是true
    --离开的时候是nil
    --所以 nil = false

    --此处不能用三元表达式会错
    if state == nil then
        seekState = false
    elseif state == false then
        seekState = true;
    elseif state == true then
        seekState = true;
    else
        seekState = true;
    end
    
    --SendSystemMessage(string.format("%s 寻求组队!",seekState and "加入" or "离开"));
end


local frame4 = CreateFrame("Frame")
frame4:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE")
frame4:SetScript("OnEvent",LFG_LIST_ACTIVE_ENTRY_UPDATE)


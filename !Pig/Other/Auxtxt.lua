-----说明整体框架
local auxtxt = CreateFrame("Frame", "auxtxtUI", UIParent,"BackdropTemplate") ;
auxtxt:SetSize(410,536);
auxtxt:SetBackdrop({ bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
edgeFile = "Interface/Tooltips/UI-Tooltip-Border",edgeSize = 16,insets = { left = 4, right = 4, top = 4, bottom = 4 }}) ;-- 背景
auxtxt:SetBackdropColor(0, 0, 0, 1);
auxtxt:SetFrameStrata("HIGH")
auxtxt:SetPoint("TOP", UIParent, "TOP", -260, -80);
auxtxt:SetMovable(true)
auxtxt:EnableMouse(true)
auxtxt:SetClampedToScreen(true)
auxtxt:RegisterForDrag("LeftButton")
auxtxt:SetScript("OnDragStart", auxtxt.StartMoving)
auxtxt:SetScript("OnDragStop", auxtxt.StopMovingOrSizing)
tinsert(UISpecialFrames,"auxtxtUI");

auxtxt.Close = CreateFrame("Button",nil,auxtxt, "UIPanelCloseButton");  
auxtxt.Close:SetSize(30,30);
auxtxt.Close:SetPoint("TOPRIGHT",auxtxt,"TOPRIGHT",0,0);
----说明内部内容----------------------------------------------
local beijing = { bgFile = "Interface/ChatFrame/UI-ChatInputBorder", insets = {left = -8,right = -4,top = 0,bottom = 0}}
--0
auxtxt.cmd0 = CreateFrame('EditBox', nil, auxtxt, "BackdropTemplate");
auxtxt.cmd0:SetSize(40,30);
auxtxt.cmd0:SetBackdrop(beijing)
auxtxt.cmd0:SetPoint("TOPLEFT",auxtxt,"TOPLEFT",10,-2);
auxtxt.cmd0:SetFontObject(ChatFontNormal);--聊天字体
auxtxt.cmd0:SetText('/aux');
auxtxt.cmd0:SetAutoFocus( false );
auxtxt.title0 = auxtxt:CreateFontString();
auxtxt.title0:SetPoint("LEFT", auxtxt.cmd0, "RIGHT", 6, 0);
auxtxt.title0:SetFontObject(GameFontNormalSmall);--字体
--auxtxt.title0:SetTextColor(255, 215, 0, 1);--字体颜色
auxtxt.title0:SetText('查看插件配置状态');
--1
auxtxt.cmd1 = CreateFrame('EditBox', nil, auxtxt, "BackdropTemplate");
auxtxt.cmd1:SetSize(86,30);
auxtxt.cmd1:SetBackdrop(beijing)
auxtxt.cmd1:SetPoint("TOPLEFT",auxtxt.cmd0,"BOTTOMLEFT",0,0);
auxtxt.cmd1:SetFontObject(ChatFontNormal);--聊天字体
auxtxt.cmd1:SetText('/aux scale 1');
auxtxt.cmd1:SetAutoFocus( false );
auxtxt.title1 = auxtxt:CreateFontString();
auxtxt.title1:SetPoint("LEFT", auxtxt.cmd1, "RIGHT", 4, 0);
auxtxt.title1:SetFontObject(GameFontNormalSmall);--字体
--auxtxt.title1:SetTextColor(255, 215, 0, 1);--字体颜色
auxtxt.title1:SetText('放大缩放UI界面');
--2
auxtxt.cmd2 = CreateFrame('EditBox', nil, auxtxt, "BackdropTemplate");
auxtxt.cmd2:SetSize(130,30);
auxtxt.cmd2:SetBackdrop(beijing)
auxtxt.cmd2:SetPoint("TOPLEFT",auxtxt.cmd1,"BOTTOMLEFT",0,0);
auxtxt.cmd2:SetFontObject(ChatFontNormal);--聊天字体
auxtxt.cmd2:SetText('/aux ignore owner');
auxtxt.cmd2:SetAutoFocus( false );
auxtxt.title2 = auxtxt:CreateFontString();
auxtxt.title2:SetPoint("LEFT", auxtxt.cmd2, "RIGHT", 4, 0);
auxtxt.title2:SetFontObject(GameFontNormalSmall);--字体
--auxtxt.title2:SetTextColor(255, 215, 0, 1);--字体颜色
auxtxt.title2:SetText('扫描时禁用等待卖主姓名,建议开启');
--3
auxtxt.cmd3 = CreateFrame('EditBox', nil, auxtxt, "BackdropTemplate");
auxtxt.cmd3:SetSize(100,30);
auxtxt.cmd3:SetBackdrop(beijing)
auxtxt.cmd3:SetPoint("TOPLEFT",auxtxt.cmd2,"BOTTOMLEFT",0,0);
auxtxt.cmd3:SetFontObject(ChatFontNormal);--聊天字体
auxtxt.cmd3:SetText('/aux post bid');
auxtxt.cmd3:SetAutoFocus( false );
auxtxt.title3 = auxtxt:CreateFontString();
auxtxt.title3:SetPoint("LEFT", auxtxt.cmd3, "RIGHT", 4, 0);
auxtxt.title3:SetFontObject(GameFontNormalSmall);--字体
--auxtxt.title3:SetTextColor(255, 215, 0, 1);--字体颜色
auxtxt.title3:SetText('出售时显示竞标价格,需要重载界面生效');
--4
auxtxt.cmd4 = CreateFrame('EditBox', nil, auxtxt, "BackdropTemplate");
auxtxt.cmd4:SetSize(124,30);
auxtxt.cmd4:SetBackdrop(beijing)
auxtxt.cmd4:SetPoint("TOPLEFT",auxtxt.cmd3,"BOTTOMLEFT",0,0);
auxtxt.cmd4:SetFontObject(ChatFontNormal);--聊天字体
auxtxt.cmd4:SetText('/aux crafting cost');
auxtxt.cmd4:SetAutoFocus( false );
auxtxt.title4 = auxtxt:CreateFontString();
auxtxt.title4:SetPoint("LEFT", auxtxt.cmd4, "RIGHT", 4, 0);
auxtxt.title4:SetFontObject(GameFontNormalSmall);--字体
--auxtxt.title4:SetTextColor(255, 215, 0, 1);--字体颜色
auxtxt.title4:SetText('显示制作物成本');
--5
auxtxt.cmd5 = CreateFrame('EditBox', nil, auxtxt, "BackdropTemplate");
auxtxt.cmd5:SetSize(140,30);
auxtxt.cmd5:SetBackdrop(beijing)
auxtxt.cmd5:SetPoint("TOPLEFT",auxtxt.cmd4,"BOTTOMLEFT",0,0);
auxtxt.cmd5:SetFontObject(ChatFontNormal);--聊天字体
auxtxt.cmd5:SetText('/aux post duration 8');
auxtxt.cmd5:SetAutoFocus( false );
auxtxt.title5 = auxtxt:CreateFontString();
auxtxt.title5:SetPoint("LEFT", auxtxt.cmd5, "RIGHT", 4, 0);
auxtxt.title5:SetFontObject(GameFontNormalSmall);--字体
--auxtxt.title5:SetTextColor(255, 215, 0, 1);--字体颜色
auxtxt.title5:SetText('切换拍卖时长（2/8/24小时）');
--6
auxtxt.cmd6 = CreateFrame('EditBox', nil, auxtxt, "BackdropTemplate");
auxtxt.cmd6:SetSize(128,30);
auxtxt.cmd6:SetBackdrop(beijing)
auxtxt.cmd6:SetPoint("TOPLEFT",auxtxt.cmd5,"BOTTOMLEFT",0,0);
auxtxt.cmd6:SetFontObject(ChatFontNormal);--聊天字体
auxtxt.cmd6:SetText('/aux tooltip value');
auxtxt.cmd6:SetAutoFocus( false );
auxtxt.title6 = auxtxt:CreateFontString();
auxtxt.title6:SetPoint("LEFT", auxtxt.cmd6, "RIGHT", 4, 0);
auxtxt.title6:SetFontObject(GameFontNormalSmall);--字体
--auxtxt.title6:SetTextColor(255, 215, 0, 1);--字体颜色
auxtxt.title6:SetText('显示AH价格');
--7
auxtxt.cmd7 = CreateFrame('EditBox', nil, auxtxt, "BackdropTemplate");
auxtxt.cmd7:SetSize(122,30);
auxtxt.cmd7:SetBackdrop(beijing)
auxtxt.cmd7:SetPoint("TOPLEFT",auxtxt.cmd6,"BOTTOMLEFT",0,0);
auxtxt.cmd7:SetFontObject(ChatFontNormal);--聊天字体
auxtxt.cmd7:SetText('/aux tooltip daily');
auxtxt.cmd7:SetAutoFocus( false );
auxtxt.title7 = auxtxt:CreateFontString();
auxtxt.title7:SetPoint("LEFT", auxtxt.cmd7, "RIGHT", 4, 0);
auxtxt.title7:SetFontObject(GameFontNormalSmall);--字体
--auxtxt.title7:SetTextColor(255, 215, 0, 1);--字体颜色
auxtxt.title7:SetText('显示AH每日价格');
--8
auxtxt.cmd8 = CreateFrame('EditBox', nil, auxtxt, "BackdropTemplate");
auxtxt.cmd8:SetSize(184,30);
auxtxt.cmd8:SetBackdrop(beijing)
auxtxt.cmd8:SetPoint("TOPLEFT",auxtxt.cmd7,"BOTTOMLEFT",0,0);
auxtxt.cmd8:SetFontObject(ChatFontNormal);--聊天字体
auxtxt.cmd8:SetText('/aux tooltip merchant buy');
auxtxt.cmd8:SetAutoFocus( false );
auxtxt.title8 = auxtxt:CreateFontString();
auxtxt.title8:SetPoint("LEFT", auxtxt.cmd8, "RIGHT", 4, 0);
auxtxt.title8:SetFontObject(GameFontNormalSmall);--字体
--auxtxt.title8:SetTextColor(255, 215, 0, 1);--字体颜色
auxtxt.title8:SetText('显示NPC购买价格');
--9
auxtxt.cmd9 = CreateFrame('EditBox', nil, auxtxt, "BackdropTemplate");
auxtxt.cmd9:SetSize(184,30);
auxtxt.cmd9:SetBackdrop(beijing)
auxtxt.cmd9:SetPoint("TOPLEFT",auxtxt.cmd8,"BOTTOMLEFT",0,0);
auxtxt.cmd9:SetFontObject(ChatFontNormal);--聊天字体
auxtxt.cmd9:SetText('/aux tooltip merchant sell');
auxtxt.cmd9:SetAutoFocus( false );
auxtxt.title9 = auxtxt:CreateFontString();
auxtxt.title9:SetPoint("LEFT", auxtxt.cmd9, "RIGHT", 4, 0);
auxtxt.title9:SetFontObject(GameFontNormalSmall);--字体
--auxtxt.title9:SetTextColor(255, 215, 0, 1);--字体颜色
auxtxt.title9:SetText('显示卖NPC价格');
--10
auxtxt.cmd10 = CreateFrame('EditBox', nil, auxtxt, "BackdropTemplate");
auxtxt.cmd10:SetSize(200,30);
auxtxt.cmd10:SetBackdrop(beijing)
auxtxt.cmd10:SetPoint("TOPLEFT",auxtxt.cmd9,"BOTTOMLEFT",0,0);
auxtxt.cmd10:SetFontObject(ChatFontNormal);--聊天字体
auxtxt.cmd10:SetText('/aux tooltip disenchant value');
auxtxt.cmd10:SetAutoFocus( false );
auxtxt.title10 = auxtxt:CreateFontString();
auxtxt.title10:SetPoint("LEFT", auxtxt.cmd10, "RIGHT", 4, 0);
auxtxt.title10:SetFontObject(GameFontNormalSmall);--字体
--auxtxt.title10:SetTextColor(255, 215, 0, 1);--字体颜色
auxtxt.title10:SetText('显示分解价值');
--11
auxtxt.cmd11 = CreateFrame('EditBox', nil, auxtxt, "BackdropTemplate");
auxtxt.cmd11:SetSize(238,30);
auxtxt.cmd11:SetBackdrop(beijing)
auxtxt.cmd11:SetPoint("TOPLEFT",auxtxt.cmd10,"BOTTOMLEFT",0,0);
auxtxt.cmd11:SetFontObject(ChatFontNormal);--聊天字体
auxtxt.cmd11:SetText('/aux tooltip disenchant distribution');
auxtxt.cmd11:SetAutoFocus( false );
auxtxt.title11 = auxtxt:CreateFontString();
auxtxt.title11:SetPoint("LEFT", auxtxt.cmd11, "RIGHT", 4, 0);
auxtxt.title11:SetFontObject(GameFontNormalSmall);--字体
--auxtxt.title11:SetTextColor(255, 215, 0, 1);--字体颜色
auxtxt.title11:SetText('显示分解后信息');
--技巧
auxtxt.title12 = auxtxt:CreateFontString();
auxtxt.title12:SetPoint("TOPLEFT", auxtxt.cmd11, "BOTTOMLEFT", 4, 0);
auxtxt.title12:SetFontObject(GameFontNormalSmall);--字体
auxtxt.title12:SetText('1.双击具有蓝色计数的行的物品可以展开它.');
auxtxt.title13 = auxtxt:CreateFontString();
auxtxt.title13:SetPoint("TOPLEFT", auxtxt.title12, "BOTTOMLEFT", 0, 0);
auxtxt.title13:SetFontObject(GameFontNormalSmall);--字体
auxtxt.title13:SetText('2.Alt-左键单击所选行以进行一口价/取消.');
auxtxt.title14 = auxtxt:CreateFontString();
auxtxt.title14:SetPoint("TOPLEFT", auxtxt.title13, "BOTTOMLEFT", 0, 0);
auxtxt.title14:SetFontObject(GameFontNormalSmall);--字体
auxtxt.title14:SetText('3.Alt-右键单击所选行以进行竞价/取消.');
auxtxt.title15 = auxtxt:CreateFontString();
auxtxt.title15:SetPoint("TOPLEFT", auxtxt.title14, "BOTTOMLEFT", 0, 0);
auxtxt.title15:SetFontObject(GameFontNormalSmall);--字体
auxtxt.title15:SetText('4.右键单击一行物品，开始搜索已拍卖的物品.');
auxtxt.title16 = auxtxt:CreateFontString();
auxtxt.title16:SetPoint("TOPLEFT", auxtxt.title15, "BOTTOMLEFT", 0, 0);
auxtxt.title16:SetFontObject(GameFontNormalSmall);--字体
auxtxt.title16:SetText('5.鼠标中键单击一行显示在试衣间框架中的预览.');
auxtxt.title17 = auxtxt:CreateFontString();
auxtxt.title17:SetPoint("TOPLEFT", auxtxt.title16, "BOTTOMLEFT", 0, 0);
auxtxt.title17:SetFontObject(GameFontNormalSmall);--字体
auxtxt.title17:SetText('6.Shift-单击一行物品，将链接复制到聊天框.');
auxtxt.title18 = auxtxt:CreateFontString();
auxtxt.title18:SetPoint("TOPLEFT", auxtxt.title17, "BOTTOMLEFT", 0, 0);
auxtxt.title18:SetFontObject(GameFontNormalSmall);--字体
auxtxt.title18:SetText('7.左击栏目标题排序,右击价格栏切换单个/整组价格.');
----------
auxtxt.title19 = auxtxt:CreateFontString();
auxtxt.title19:SetPoint("TOPLEFT", auxtxt.title18, "BOTTOMLEFT", 0, 0);
auxtxt.title19:SetFontObject(GameFontGreen);--字体
auxtxt.title19:SetText('搜索');
auxtxt.title20 = auxtxt:CreateFontString();
auxtxt.title20:SetPoint("TOPLEFT", auxtxt.title19, "BOTTOMLEFT", 0, 0);
auxtxt.title20:SetFontObject(GameFontGreen);--字体
auxtxt.title20:SetText('1.在搜索框中点击TAB将自动完成接受一个关键字.');
auxtxt.title21 = auxtxt:CreateFontString();
auxtxt.title21:SetPoint("TOPLEFT", auxtxt.title20, "BOTTOMLEFT", 0, 0);
auxtxt.title21:SetFontObject(GameFontGreen);--字体
auxtxt.title21:SetText('2.将背包库存物品拖到搜索框或右击它们将开始搜索.');
auxtxt.title22 = auxtxt:CreateFontString();
auxtxt.title22:SetPoint("TOPLEFT", auxtxt.title21, "BOTTOMLEFT", 0, 0);
auxtxt.title22:SetFontObject(GameFontGreen);--字体
auxtxt.title22:SetText('3.Alt左键物品链接也会开始搜索.');
---------------------------------------
auxtxt.cmd0:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
auxtxt.cmd1:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
auxtxt.cmd2:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
auxtxt.cmd3:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
auxtxt.cmd4:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
auxtxt.cmd5:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
auxtxt.cmd6:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
auxtxt.cmd7:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
auxtxt.cmd8:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
auxtxt.cmd9:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
auxtxt.cmd10:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);
auxtxt.cmd11:SetScript("OnEscapePressed", function(self) self:ClearFocus() end);

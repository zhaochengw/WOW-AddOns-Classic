if not aienable then aienable = true end
if not aikeyword then aikeyword = 1 end
if not aichannel then aichannel = 1 end
if not aitextleft then aitextleft = "密我“" end
if not aitextright then aitextright = "”进组" end

local ai = CreateFrame("Frame");
ai:RegisterEvent("CHAT_MSG_WHISPER")
ai:SetScript("OnEvent", function(self, event, ...)
    if aienable == true then
        local msg, playerName = ...;
        if msg == aikeyword then
            InviteUnit(playerName)
        end
    end
end)

--设置
local function savetext(self, var)
    local text = self:GetText();
    _G[var] = tostring(text);
    self:SetText(text);
    self:ClearFocus();
end

--设置界面
local ais = CreateFrame("Frame", "AutoInviteFrame", UIParent);
ais:SetSize(390, 185);
ais:ClearAllPoints();
ais:SetPoint("CENTER");
ais:SetClampedToScreen(true);
ais:EnableMouse(true);
ais:SetMovable(true);
ais:RegisterForDrag("LeftButton");
ais:SetScript("OnDragStart", function(self) self:StartMoving() end);
ais:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);
tinsert(UISpecialFrames, ais:GetName());
ais:Hide();
ais.bg = ais:CreateTexture();
ais.bg:ClearAllPoints();
ais.bg:SetAllPoints(ais);
ais.bg:SetColorTexture(0, 0, 0, 0.5);
ais.close = CreateFrame("Button", nil, ais, "UIPanelCloseButton");
ais.close:ClearAllPoints();
ais.close:SetPoint("TOPRIGHT", ais, "TOPRIGHT", -5, -5);

--开关
ais.enable = CreateFrame("CheckButton", nil, ais, "InterfaceOptionsCheckButtonTemplate");
ais.enable:SetPoint("TOPLEFT", 16, -16);
ais.enable:SetHitRectInsets(0, -60, 0, 0);
ais.enable.Text:SetText("开启密语组队邀请");
ais.enable.Text:SetTextColor(1, 0.82, 0);
ais.enable:SetScript("OnShow", function(self)
    self:SetChecked(aienable);
end)
ais.enable:SetScript("OnClick", function(self)
    aienable = not aienable;
    self:SetChecked(aienable);
end)

ais.keyword = ais:CreateFontString(nil, nil, "GameFontNormalLarge");
ais.keyword:ClearAllPoints();
ais.keyword:SetPoint("TOPLEFT", ais.enable, "TOPLEFT", 3, -30);
ais.keyword:SetText("关键词：");
ais.keyword:SetTextColor(1, 1, 1);

--关键词
ais.keywordtext = CreateFrame("EditBox", nil, ais, "InputBoxTemplate");
ais.keywordtext:ClearAllPoints();
ais.keywordtext:SetPoint("TOPLEFT", ais.keyword, "TOPLEFT", 3, -16);
ais.keywordtext:SetWidth(350);
ais.keywordtext:SetHeight(25);
ais.keywordtext:SetAutoFocus(false);
ais.keywordtext:ClearFocus();
ais.keywordtext:SetScript("OnEnterPressed", function(self)
    savetext(self, "aikeyword");
    ais.keywordtext:SetText(aikeyword);
    ais.textmiddletext:SetText(aikeyword);
end)
ais.keywordtext:SetScript("OnEscapePressed", function(self)
    savetext(self, "aikeyword");
    ais.keywordtext:SetText(aikeyword);
    ais.textmiddletext:SetText(aikeyword);
end)
ais.keywordtext:SetScript("OnEditFocusLost", function(self)
    savetext(self, "aikeyword");
    ais.keywordtext:SetText(aikeyword);
    ais.textmiddletext:SetText(aikeyword);
end)
ais.keywordtext:SetScript("OnShow", function(self)
    self:SetText(aikeyword);
    ais.keywordtext:SetText(aikeyword);
end)

--通告
ais.announce = ais:CreateFontString(nil, nil, "GameFontNormalLarge");
ais.announce:ClearAllPoints();
ais.announce:SetPoint("TOPLEFT", ais.keywordtext, "TOPLEFT", -3, -30);
ais.announce:SetText("通告内容(关键词在中间)：");
ais.announce:SetTextColor(1, 1, 1);

--第一部分
ais.textleft = CreateFrame("EditBox", nil, ais, "InputBoxTemplate");
ais.textleft:ClearAllPoints();
ais.textleft:SetPoint("TOPLEFT", ais.announce, "TOPLEFT", 3, -16);
ais.textleft:SetWidth(150);
ais.textleft:SetHeight(25);
ais.textleft:SetAutoFocus(false);
ais.textleft:ClearFocus();
ais.textleft:SetScript("OnEnterPressed", function(self)
    savetext(self, "aitextleft");
end)
ais.textleft:SetScript("OnEscapePressed", function(self)
    savetext(self, "aitextleft");
end)
ais.textleft:SetScript("OnEditFocusLost", function(self)
    savetext(self, "aitextleft");
end)
ais.textleft:SetScript("OnShow", function(self)
    self:SetText(aitextleft);
end)

--关键词
ais.textmiddle = ais:CreateFontString(nil, nil, "GameFontNormalLarge");
ais.textmiddle:SetWidth(30);
ais.textmiddle:ClearAllPoints();
ais.textmiddle:SetPoint("LEFT", ais.textleft, "RIGHT", 8, 0);

ais.textmiddletext = ais:CreateFontString(nil, nil, "GameFontNormalLarge");
ais.textmiddletext:ClearAllPoints();
ais.textmiddletext:SetPoint("CENTER", ais.textmiddle, "CENTER", 0, 0);
ais.textmiddletext:SetText(aikeyword);

--第二部分
ais.textright = CreateFrame("EditBox", nil, ais, "InputBoxTemplate");
ais.textright:ClearAllPoints();
ais.textright:SetPoint("LEFT", ais.textmiddle, "RIGHT", 12, 0);
ais.textright:SetWidth(150);
ais.textright:SetHeight(25);
ais.textright:SetAutoFocus(false);
ais.textright:ClearFocus();
ais.textright:SetScript("OnEnterPressed", function(self)
    savetext(self, "aitextright");
end)
ais.textright:SetScript("OnEscapePressed", function(self)
    savetext(self, "aitextright");
end)
ais.textright:SetScript("OnEditFocusLost", function(self)
    savetext(self, "aitextright");
end)
ais.textright:SetScript("OnShow", function(self)
    self:SetText(aitextright);
end)

--通告
local AnnounceChannelDropDown = {"Guild", "Say", "Yell", "General", "Trade", "大脚世界频道"};
if (GetLocale() == "zhCN") then
    AnnounceChannelDropDown = {"公会", "说", "喊", "综合", "交易", "大脚世界频道"};
elseif (GetLocale() == "zhTW") then
    AnnounceChannelDropDown = {"公會", "說", "喊", "綜合", "交易", "大脚世界频道"};
end

local function AnnounceChannelDropDown_OnClick(self)
    UIDropDownMenu_SetSelectedID(AnnounceChannel, self:GetID());
    aichannel = self:GetID();
end

local function AnnounceChannel_Init()
    for id = 1, table.getn(AnnounceChannelDropDown), 1 do
        info = {
            text = AnnounceChannelDropDown[id];
            func = AnnounceChannelDropDown_OnClick;
        };
        UIDropDownMenu_AddButton(info);
    end
end

--通告按钮
ais.btn = CreateFrame("Button", "Announce", ais, "OptionsButtonTemplate");
ais.btn:ClearAllPoints();
ais.btn:SetPoint("TOPLEFT", ais.textleft, "TOPLEFT", -5, -35);
ais.btn:SetWidth(155);
ais.btn:SetHeight(25);
ais.btn:SetText("发送通告");
ais.btn:SetScript("OnClick", function(self)
    if aichannel == 1 then
        SendChatMessage(aitextleft.." "..aikeyword.." "..aitextright, "GUILD");
    elseif aichannel == 2 then
        SendChatMessage(aitextleft.." "..aikeyword.." "..aitextright, "SAY");
    elseif aichannel == 3 then
        SendChatMessage(aitextleft.." "..aikeyword.." "..aitextright, "YELL");
    else
        local index = GetChannelName(AnnounceChannelDropDown[aichannel]);
        if ((index ~= nil) and (index ~= 0)) then 
            SendChatMessage(aitextleft.." "..aikeyword.." "..aitextright , "CHANNEL", nil, index);
        else
            print("频道未找到。");
        end
    end
end)

--通告频道
ais.ac = CreateFrame("CheckButton", "AnnounceChannel", ais, "UIDropDownMenuTemplate");
ais.ac:ClearAllPoints();
ais.ac:SetPoint("LEFT", ais.btn, "RIGHT", 28, 0);
ais.ac:SetHitRectInsets(0, -100, 0, 0);
UIDropDownMenu_SetWidth(AnnounceChannel, 140);
UIDropDownMenu_SetButtonWidth(AnnounceChannel, 140);
UIDropDownMenu_Initialize(AnnounceChannel, AnnounceChannel_Init);
UIDropDownMenu_SetSelectedID(AnnounceChannel, aichannel);

--命令
function AISettings_SlashHandler()
    if not ais:IsShown() then
        ais:Show();
    else
        ais:Hide();
    end
end

SlashCmdList["AISettings"] = AISettings_SlashHandler;
SLASH_AISettings1 = "/aisetting";
SLASH_AISettings2 = "/ais";

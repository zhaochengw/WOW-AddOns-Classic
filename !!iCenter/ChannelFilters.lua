local cfilterlistdefault = {
    trade = {"专业", "带做", "代做", "代工", "加工", "手工", "现货", "要的M", "要的密", "有的M", "有的密", "出的M", "出的密", "卖的M", "卖的密", "出售", "求购", "无限收", "长期", "一组", "每组", "组收", "邮寄", "U寄", "付费", "大量", "带价", "代价", "欢乐豆", "大米", "小米", "收米", "出米", "支付", "微信", "VX", "ZFB", "马云", "双马", "偷税", "逃税", "草药", "采矿", "剥皮", "炼金", "工程", "锻造", "附魔", "FM", "裁缝", "制皮"},
    gather = {"宁神花", "银叶草", "地根草", "魔皇草", "石南草", "雨燕草", "荆棘藻", "跌打草", "野钢花", "活根草", "枯叶草", "金棘草", "紫莲花", "卡德加的胡须", "冬刺草", "火焰花", "野葡萄藤", "太阳草", "盲目草", "幽灵菇", "格罗姆之血", "阿尔萨斯之泪", "瘟疫花", "黄金参", "山鼠草", "梦叶草", "冰盖草", "黑莲花", "血藤", "铜矿", "铜锭", "锡矿", "锡锭", "银矿", "银锭", "铁矿", "铁锭", "金矿", "金锭", "钢锭", "奥术水晶", "源质矿", "源质锭", "萨弗隆铁"},
    battle = {"战场", "国家", "奥山", "战歌", "阿拉希", "PVP", "荣誉"},
    d10 = {"怒焰", "NY", "矿井", "死矿", "SK", "SW", "哀嚎", "AH"},
    d20 = {"影牙", "YY", "黑暗深渊", "监狱", "JY", "诺莫瑞根", "NMRG", "矮子本", "矮人本", "矮人副本", "矮子副本", "沼泽", "ZZ"},
    d30 = {"血色", "XS", "图书馆", "军械库", "武器库", "教堂", "墓地", "高地", "GD", "奥达曼", "ADM"},
    d40 = {"玛拉顿", "MLD", "祖尔法拉克", "ZUL", "神庙", "黑石深渊"},
    d50 = {"斯坦", "十字", "DK", "STSM", "通灵", "TL", "黑石塔", "黑上", "黑下", "厄运", "牵马", "摸马", "黑龙的威胁", "救元帅"},
    d60 = {"祖尔格拉布", "祖格", "ZUG", "ZG", "安其拉", "AQL", "神殿", "TAQ", "废墟", "FX", "熔火之心", "MC", "黑龙", "黑翼", "BWL", "纳克", "NAXX"},
    other = {"买号", "卖号", "代刷", "带刷", "代打", "带打", "金一次", "G一次", "经验", "自由拾取", "位面", "老板", "私聊", "托管", "极速", "站桩", "躺尸", "地板", "老牌", "皇冠", "好评", "金币", "拉人", "飞机", "航班", "航线", "航空", "深渊", "祖尔", "来的M", "来的密"},
    symbol = {"`", "~", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "[", "]", "{", "}", "<", ">", ":", ",", ";", ".", "|", "?", "：", "，", "；", "。", "『", "』", "☆", "★", "○", "●", "◇", "◆", "□", "■", "△", "▲", "　"}
}

local function ChannelFiltersDB(default)
    if not cfilter or default == true then cfilter = true end
    if not cfilterall or default == true then cfilterall = false end

    if not cfilters or default == true then cfilters = {} end
    if not cfilters["white"] or default == true then cfilters["white"] = true end
    if not cfilters["black"] or default == true then cfilters["black"] = true end
    if not cfilters["trade"] or default == true then cfilters["trade"] = true end
    if not cfilters["gather"] or default == true then cfilters["gather"] = true end
    if not cfilters["battle"] or default == true then cfilters["battle"] = true end
    if not cfilters["d10"] or default == true then cfilters["d10"] = false end
    if not cfilters["d20"] or default == true then cfilters["d20"] = false end
    if not cfilters["d30"] or default == true then cfilters["d30"] = false end
    if not cfilters["d40"] or default == true then cfilters["d40"] = false end
    if not cfilters["d50"] or default == true then cfilters["d50"] = false end
    if not cfilters["d60"] or default == true then cfilters["d60"] = false end
    if not cfilters["other"] or default == true then cfilters["other"] = false end
    if not cfilters["symbol"] or default == true then cfilters["symbol"] = true end

    if not cfilterlist or default == true then cfilterlist = {} end
    if not cfilterlist["white"] then cfilterlist["white"] = {} end
    if not cfilterlist["black"] then cfilterlist["black"] = {} end
    if not cfilterlist["trade"] or default == true then cfilterlist["trade"] = cfilterlistdefault["trade"] end
    if not cfilterlist["gather"] or default == true then cfilterlist["gather"] = cfilterlistdefault["gather"] end
    if not cfilterlist["battle"] or default == true then cfilterlist["battle"] = cfilterlistdefault["battle"] end
    if not cfilterlist["d10"] or default == true then cfilterlist["d10"] = cfilterlistdefault["d10"] end
    if not cfilterlist["d20"] or default == true then cfilterlist["d20"] = cfilterlistdefault["d20"] end
    if not cfilterlist["d30"] or default == true then cfilterlist["d30"] = cfilterlistdefault["d30"] end
    if not cfilterlist["d40"] or default == true then cfilterlist["d40"] = cfilterlistdefault["d40"] end
    if not cfilterlist["d50"] or default == true then cfilterlist["d50"] = cfilterlistdefault["d50"] end
    if not cfilterlist["d60"] or default == true then cfilterlist["d60"] = cfilterlistdefault["d60"] end
    if not cfilterlist["other"] or default == true then cfilterlist["other"] = cfilterlistdefault["other"] end
    if not cfilterlist["symbol"] or default == true then cfilterlist["symbol"] = cfilterlistdefault["symbol"] end
end

local cff = CreateFrame("Frame");
cff:RegisterEvent("ADDON_LOADED");
cff:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...;
        if name == "!!iCenter" then
            ChannelFiltersDB(false);
        end
    end
end)

local function listtostring(list)
    local text = "";
    for k, v in ipairs(cfilterlist[list]) do
        if text == "" then
            text = v;
        else
            text = text.." "..v;
        end
    end
    return text;
end

local function savelist(self, list)
    local text = self:GetText();
    cfilterlist[list] = {};
    if text ~= "" then
        for v in string.gmatch(text, "[^ ]+") do
          tinsert(cfilterlist[list], v)
        end
    end
    self:ClearFocus();
end

local special = {"(", ")", ".", "%", "+", "-", "*", "?", "[", "^", "$"};
local function isspecial(str)
    for _, v in ipairs(special) do
        if v == str then
            return true;
        end
    end

    return false;
end

local function ChannelFiltersShow()
    ChannelFiltersFrame.enable:SetChecked(cfilter);
    ChannelFiltersFrame.enableall:SetChecked(cfilterall);
    ChannelFiltersFrame.blacklisttradeeditbox:SetText(listtostring("trade"));
    ChannelFiltersFrame.blacklisttrade:SetChecked(cfilters["trade"]);
    ChannelFiltersFrame.blacklistgathereditbox:SetText(listtostring("gather"));
    ChannelFiltersFrame.blacklistgather:SetChecked(cfilters["gather"]);
    ChannelFiltersFrame.blacklistbattleeditbox:SetText(listtostring("battle"));
    ChannelFiltersFrame.blacklistbattle:SetChecked(cfilters["battle"]);
    ChannelFiltersFrame.blacklist10editbox:SetText(listtostring("d10"));
    ChannelFiltersFrame.blacklist10:SetChecked(cfilters["d10"]);
    ChannelFiltersFrame.blacklist20editbox:SetText(listtostring("d20"));
    ChannelFiltersFrame.blacklist20:SetChecked(cfilters["d20"]);
    ChannelFiltersFrame.blacklist30editbox:SetText(listtostring("d30"));
    ChannelFiltersFrame.blacklist30:SetChecked(cfilters["d30"]);
    ChannelFiltersFrame.blacklist40editbox:SetText(listtostring("d40"));
    ChannelFiltersFrame.blacklist40:SetChecked(cfilters["d40"]);
    ChannelFiltersFrame.blacklist50editbox:SetText(listtostring("d50"));
    ChannelFiltersFrame.blacklist50:SetChecked(cfilters["d50"]);
    ChannelFiltersFrame.blacklist60editbox:SetText(listtostring("d60"));
    ChannelFiltersFrame.blacklist60:SetChecked(cfilters["d60"]);
    ChannelFiltersFrame.blacklistothereditbox:SetText(listtostring("other"));
    ChannelFiltersFrame.blacklistother:SetChecked(cfilters["other"]);
    ChannelFiltersFrame.blacklistsymboleditbox:SetText(listtostring("symbol"));
    ChannelFiltersFrame.blacklistsymbol:SetChecked(cfilters["symbol"]);
end

function ChannelFilters(self, event, msg, playername, _, channel, _, flag, zonechannelid, channelindex, channelname, unused, id)
    if cfilter == true then
        if channelname == "大脚世界频道" or cfilterall == true then
            local truename = strsplit("-", playername);
            if truename == UnitName("player") then return false end

            local msgx = msg;
            if cfilters["symbol"] == true and cfilterlist ~= nil and next(cfilterlist["symbol"]) ~= nil then
                msgx = gsub(msgx, " ", "");
                for _, word in ipairs(cfilterlist["symbol"]) do
                    if isspecial(word) then word = "%"..word end
                    msgx = gsub(msgx, word, "");
                end
            end

            local find = false;
            if cfilters["white"] == true and cfilterlist ~= nil and next(cfilterlist["white"]) ~= nil then
                for _, word in ipairs(cfilterlist["white"]) do
                    local _, result = gsub(string.upper(msgx), word, "");
                    if (result > 0) then
                        find = true;
                        break;
                    end
                end
            else
                find = true;
            end

            if find then
                local k, v;
                for k, v in pairs(cfilters) do
                    if k ~= "white" and k ~= "symbol" and v == true then
                        if cfilterlist ~= nil and next(cfilterlist[k]) ~= nil then
                            for _, word in ipairs(cfilterlist[k]) do
                                local _, result = gsub(string.upper(msgx), word, "");
                                if (result > 0) then
                                    return true;
                                end
                            end
                        end
                    end
                end
                return false;
            else
                return true;
            end
        end
    end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ChannelFilters);
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ChannelFilters);
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ChannelFilters);
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", ChannelFilters);
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChannelFilters);
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChannelFilters);
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ChannelFilters);
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ChannelFilters);
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", ChannelFilters);
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", ChannelFilters);
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ChannelFilters);
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ChannelFilters);
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", ChannelFilters);
-- ChatFrame_AddMessageEventFilter("CHAT_MSG_TEXT_EMOTE", ChannelFilters);

local ChannelFilters_MenuList = {
    { text = RESET, func = function() ChannelFiltersDB(true); ChannelFiltersShow(); end },
    { text = CANCEL },
}

local ChannelFilters_Menu = CreateFrame("Frame", nil, glg, "UIDropDownMenuTemplate");

local function ChannelFiltersSetting()
    EasyMenu(ChannelFilters_MenuList, ChannelFilters_Menu, "cursor", 0 , 0, "MENU");
end

--settings
local cf = CreateFrame("Frame", "ChannelFiltersFrame", UIParent);
cf:SetSize(390, 515);
cf:ClearAllPoints();
cf:SetPoint("CENTER");
cf:SetClampedToScreen(true);
cf:EnableMouse(true);
cf:SetMovable(true);
cf:RegisterForDrag("LeftButton");
cf:SetScript("OnDragStart", function(self) self:StartMoving() end);
cf:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);
tinsert(UISpecialFrames, cf:GetName());
cf:Hide();
cf.bg = cf:CreateTexture();
cf.bg:ClearAllPoints();
cf.bg:SetAllPoints(cf);
cf.bg:SetColorTexture(0, 0, 0, 0.5);
cf.close = CreateFrame("Button", nil, cf, "UIPanelCloseButton");
cf.close:ClearAllPoints();
cf.close:SetPoint("TOPRIGHT", cf, "TOPRIGHT", -5, -5);

cf.setting = CreateFrame("Button", nil, cf);
cf.setting:SetNormalTexture("Interface\\Buttons\\UI-OptionsButton");
cf.setting:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round");
cf.setting:SetWidth(16);
cf.setting:SetHeight(16);
cf.setting:ClearAllPoints();
cf.setting:SetPoint("RIGHT", cf.close, "LEFT", -2, 0);
cf.setting:SetScript("OnClick", function()
    ChannelFiltersSetting();
end);

--enable
cf.enable = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.enable:ClearAllPoints();
cf.enable:SetPoint("TOPLEFT", 16, -16);
cf.enable:SetHitRectInsets(0, -60, 0, 0);
cf.enable.Text:SetText("开启世界频道过滤");
cf.enable.Text:SetTextColor(1, 0.82, 0);
cf.enable:SetScript("OnShow", function(self)
    self:SetChecked(cfilter);
end)
cf.enable:SetScript("OnClick", function(self)
    cfilter = not cfilter;
    self:SetChecked(cfilter);
end)

--enable
cf.enableall = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.enableall:ClearAllPoints();
cf.enableall:SetPoint("TOPLEFT", cf.enable, "TOPLEFT", 160, 0);
cf.enableall:SetHitRectInsets(0, -60, 0, 0);
cf.enableall.Text:SetText("应用到公共频道");
cf.enableall.Text:SetTextColor(1, 0.82, 0);
cf.enableall:SetScript("OnShow", function(self)
    self:SetChecked(cfilterall);
end)
cf.enableall:SetScript("OnClick", function(self)
    cfilterall = not cfilterall;
    self:SetChecked(cfilterall);
end)

cf.description = cf:CreateFontString(nil, nil, "GameFontNormalLarge");
cf.description:ClearAllPoints();
cf.description:SetPoint("TOPLEFT", cf.enable, "TOPLEFT", 3, -30);
cf.description:SetText("使用空格分隔关键词");
cf.description:SetTextColor(1, 1, 1);

--whitelist
-- cf.whitelist = cf:CreateFontString(nil, nil, "GameFontNormalLarge");
-- cf.whitelist:ClearAllPoints();
-- cf.whitelist:SetPoint("TOPLEFT", cf.description, "TOPLEFT", 0, -30);
-- cf.whitelist:SetText("白名单：");
cf.whitelist = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.whitelist:ClearAllPoints();
cf.whitelist:SetPoint("TOPLEFT", cf.description, "TOPLEFT", -3, -20);
cf.whitelist:SetHitRectInsets(0, -60, 0, 0);
cf.whitelist.Text:SetText("自定义白名单（重置时保留）");
cf.whitelist.Text:SetTextColor(1, 0.82, 0);
cf.whitelist:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["white"]);
end)
cf.whitelist:SetScript("OnClick", function(self)
    cfilters["white"] = not cfilters["white"];
    self:SetChecked(cfilters["white"]);
end)

--whitelist editbox
cf.whitelisteditbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.whitelisteditbox:ClearAllPoints();
cf.whitelisteditbox:SetPoint("TOPLEFT", cf.whitelist, "TOPLEFT", 9, -26);
cf.whitelisteditbox:SetWidth(346);
cf.whitelisteditbox:SetHeight(25);
cf.whitelisteditbox:SetAutoFocus(false);
cf.whitelisteditbox:ClearFocus();
cf.whitelisteditbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "white");
end)
cf.whitelisteditbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "white");
end)
cf.whitelisteditbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "white");
    self:SetText(listtostring("white"));
end)
cf.whitelisteditbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("white"));
end)
cf.whitelisteditbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["white"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 5 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.whitelisteditbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--blacklist
-- cf.blacklist = cf:CreateFontString(nil, nil, "GameFontNormalLarge");
-- cf.blacklist:ClearAllPoints();
-- cf.blacklist:SetPoint("TOPLEFT", cf.whitelisteditbox, "TOPLEFT", -3, -38);
-- cf.blacklist:SetText("黑名单：");
cf.blacklist = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.blacklist:ClearAllPoints();
cf.blacklist:SetPoint("TOPLEFT", cf.whitelisteditbox, "TOPLEFT", -9, -28);
cf.blacklist:SetHitRectInsets(0, -60, 0, 0);
cf.blacklist.Text:SetText("自定义黑名单（重置时保留）");
cf.blacklist.Text:SetTextColor(1, 0.82, 0);
cf.blacklist:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["black"]);
end)
cf.blacklist:SetScript("OnClick", function(self)
    cfilters["black"] = not cfilters["black"];
    self:SetChecked(cfilters["black"]);
end)
--blacklist editbox
cf.blacklisteditbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.blacklisteditbox:ClearAllPoints();
cf.blacklisteditbox:SetPoint("TOPLEFT", cf.blacklist, "TOPLEFT", 9, -26);
cf.blacklisteditbox:SetWidth(346);
cf.blacklisteditbox:SetHeight(25);
cf.blacklisteditbox:SetAutoFocus(false);
cf.blacklisteditbox:ClearFocus();
cf.blacklisteditbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "black");
end)
cf.blacklisteditbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "black");
end)
cf.blacklisteditbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "black");
    self:SetText(listtostring("black"));
end)
cf.blacklisteditbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("black"));
end)
cf.blacklisteditbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["black"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 5 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.blacklisteditbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--blacklist trade
cf.blacklisttrade = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.blacklisttrade:ClearAllPoints();
cf.blacklisttrade:SetPoint("TOPLEFT", cf.blacklisteditbox, "TOPLEFT", -9, -30);
cf.blacklisttrade:SetHitRectInsets(0, -40, 0, 0);
cf.blacklisttrade.Text:SetText("交易");
cf.blacklisttrade.Text:SetTextColor(1, 0.82, 0);
cf.blacklisttrade:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["trade"]);
end)
cf.blacklisttrade:SetScript("OnClick", function(self)
    cfilters["trade"] = not cfilters["trade"];
    self:SetChecked(cfilters["trade"]);
end)
--blacklist trade editbox
cf.blacklisttradeeditbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.blacklisttradeeditbox:ClearAllPoints();
cf.blacklisttradeeditbox:SetPoint("LEFT", cf.blacklisttrade, "RIGHT", 44, 1);
cf.blacklisttradeeditbox:SetWidth(285);
cf.blacklisttradeeditbox:SetHeight(25);
cf.blacklisttradeeditbox:SetAutoFocus(false);
cf.blacklisttradeeditbox:ClearFocus();
cf.blacklisttradeeditbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "trade");
end)
cf.blacklisttradeeditbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "trade");
end)
cf.blacklisttradeeditbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "trade");
    self:SetText(listtostring("trade"));
end)
cf.blacklisttradeeditbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("trade"));
end)
cf.blacklisttradeeditbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["trade"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 5 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.blacklisttradeeditbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--blacklist gather
cf.blacklistgather = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.blacklistgather:ClearAllPoints();
cf.blacklistgather:SetPoint("TOPLEFT", cf.blacklisttrade, "TOPLEFT", 0, -30);
cf.blacklistgather:SetHitRectInsets(0, -40, 0, 0);
cf.blacklistgather.Text:SetText("采集");
cf.blacklistgather.Text:SetTextColor(1, 0.82, 0);
cf.blacklistgather:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["gather"]);
end)
cf.blacklistgather:SetScript("OnClick", function(self)
    cfilters["gather"] = not cfilters["gather"];
    self:SetChecked(cfilters["gather"]);
end)
--blacklist gather editbox
cf.blacklistgathereditbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.blacklistgathereditbox:ClearAllPoints();
cf.blacklistgathereditbox:SetPoint("LEFT", cf.blacklistgather, "RIGHT", 44, 1);
cf.blacklistgathereditbox:SetWidth(285);
cf.blacklistgathereditbox:SetHeight(25);
cf.blacklistgathereditbox:SetAutoFocus(false);
cf.blacklistgathereditbox:ClearFocus();
cf.blacklistgathereditbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "gather");
end)
cf.blacklistgathereditbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "gather");
end)
cf.blacklistgathereditbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "gather");
    self:SetText(listtostring("gather"));
end)
cf.blacklistgathereditbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("gather"));
end)
cf.blacklistgathereditbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["gather"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 5 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.blacklistgathereditbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--blacklist battle
cf.blacklistbattle = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.blacklistbattle:ClearAllPoints();
cf.blacklistbattle:SetPoint("TOPLEFT", cf.blacklistgather, "TOPLEFT", 0, -30);
cf.blacklistbattle:SetHitRectInsets(0, -40, 0, 0);
cf.blacklistbattle.Text:SetText("战场");
cf.blacklistbattle.Text:SetTextColor(1, 0.82, 0);
cf.blacklistbattle:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["battle"]);
end)
cf.blacklistbattle:SetScript("OnClick", function(self)
    cfilters["battle"] = not cfilters["battle"];
    self:SetChecked(cfilters["battle"]);
end)
--blacklist battle editbox
cf.blacklistbattleeditbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.blacklistbattleeditbox:ClearAllPoints();
cf.blacklistbattleeditbox:SetPoint("LEFT", cf.blacklistbattle, "RIGHT", 44, 1);
cf.blacklistbattleeditbox:SetWidth(285);
cf.blacklistbattleeditbox:SetHeight(25);
cf.blacklistbattleeditbox:SetAutoFocus(false);
cf.blacklistbattleeditbox:ClearFocus();
cf.blacklistbattleeditbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "battle");
end)
cf.blacklistbattleeditbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "battle");
end)
cf.blacklistbattleeditbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "battle");
    self:SetText(listtostring("battle"));
end)
cf.blacklistbattleeditbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("battle"));
end)
cf.blacklistbattleeditbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["battle"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 5 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.blacklistbattleeditbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--blacklist 10
cf.blacklist10 = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.blacklist10:ClearAllPoints();
cf.blacklist10:SetPoint("TOPLEFT", cf.blacklistbattle, "TOPLEFT", 0, -30);
cf.blacklist10:SetHitRectInsets(0, -40, 0, 0);
cf.blacklist10.Text:SetText("10+");
cf.blacklist10.Text:SetTextColor(1, 0.82, 0);
cf.blacklist10:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["d10"]);
end)
cf.blacklist10:SetScript("OnClick", function(self)
    cfilters["d10"] = not cfilters["d10"];
    self:SetChecked(cfilters["d10"]);
end)
--blacklist 10 editbox
cf.blacklist10editbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.blacklist10editbox:ClearAllPoints();
cf.blacklist10editbox:SetPoint("LEFT", cf.blacklist10, "RIGHT", 44, 1);
cf.blacklist10editbox:SetWidth(285);
cf.blacklist10editbox:SetHeight(25);
cf.blacklist10editbox:SetAutoFocus(false);
cf.blacklist10editbox:ClearFocus();
cf.blacklist10editbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "d10");
end)
cf.blacklist10editbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "d10");
end)
cf.blacklist10editbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "d10");
    self:SetText(listtostring("d10"));
end)
cf.blacklist10editbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("d10"));
end)
cf.blacklist10editbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["d10"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 5 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.blacklist10editbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--blacklist 20
cf.blacklist20 = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.blacklist20:ClearAllPoints();
cf.blacklist20:SetPoint("TOPLEFT", cf.blacklist10, "TOPLEFT", 0, -30);
cf.blacklist20:SetHitRectInsets(0, -40, 0, 0);
cf.blacklist20.Text:SetText("20+");
cf.blacklist20.Text:SetTextColor(1, 0.82, 0);
cf.blacklist20:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["d20"]);
end)
cf.blacklist20:SetScript("OnClick", function(self)
    cfilters["d20"] = not cfilters["d20"];
    self:SetChecked(cfilters["d20"]);
end)
--blacklist 20 editbox
cf.blacklist20editbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.blacklist20editbox:ClearAllPoints();
cf.blacklist20editbox:SetPoint("LEFT", cf.blacklist20, "RIGHT", 44, 1);
cf.blacklist20editbox:SetWidth(285);
cf.blacklist20editbox:SetHeight(25);
cf.blacklist20editbox:SetAutoFocus(false);
cf.blacklist20editbox:ClearFocus();
cf.blacklist20editbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "d20");
end)
cf.blacklist20editbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "d20");
end)
cf.blacklist20editbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "d20");
    self:SetText(listtostring("d20"));
end)
cf.blacklist20editbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("d20"));
end)
cf.blacklist20editbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["d10"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 5 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.blacklist20editbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--blacklist 30
cf.blacklist30 = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.blacklist30:ClearAllPoints();
cf.blacklist30:SetPoint("TOPLEFT", cf.blacklist20, "TOPLEFT", 0, -30);
cf.blacklist30:SetHitRectInsets(0, -40, 0, 0);
cf.blacklist30.Text:SetText("30+");
cf.blacklist30.Text:SetTextColor(1, 0.82, 0);
cf.blacklist30:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["d30"]);
end)
cf.blacklist30:SetScript("OnClick", function(self)
    cfilters["d30"] = not cfilters["d30"];
    self:SetChecked(cfilters["d30"]);
end)
--blacklist 30 editbox
cf.blacklist30editbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.blacklist30editbox:ClearAllPoints();
cf.blacklist30editbox:SetPoint("LEFT", cf.blacklist30, "RIGHT", 44, 1);
cf.blacklist30editbox:SetWidth(285);
cf.blacklist30editbox:SetHeight(25);
cf.blacklist30editbox:SetAutoFocus(false);
cf.blacklist30editbox:ClearFocus();
cf.blacklist30editbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "d30");
end)
cf.blacklist30editbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "d30");
end)
cf.blacklist30editbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "d30");
    self:SetText(listtostring("d30"));
end)
cf.blacklist30editbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("d30"));
end)
cf.blacklist30editbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["d30"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 5 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.blacklist30editbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--blacklist 40
cf.blacklist40 = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.blacklist40:ClearAllPoints();
cf.blacklist40:SetPoint("TOPLEFT", cf.blacklist30, "TOPLEFT", 0, -30);
cf.blacklist40:SetHitRectInsets(0, -40, 0, 0);
cf.blacklist40.Text:SetText("40+");
cf.blacklist40.Text:SetTextColor(1, 0.82, 0);
cf.blacklist40:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["d40"]);
end)
cf.blacklist40:SetScript("OnClick", function(self)
    cfilters["d40"] = not cfilters["d40"];
    self:SetChecked(cfilters["d40"]);
end)
--blacklist 40 editbox
cf.blacklist40editbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.blacklist40editbox:ClearAllPoints();
cf.blacklist40editbox:SetPoint("LEFT", cf.blacklist40, "RIGHT", 44, 1);
cf.blacklist40editbox:SetWidth(285);
cf.blacklist40editbox:SetHeight(25);
cf.blacklist40editbox:SetAutoFocus(false);
cf.blacklist40editbox:ClearFocus();
cf.blacklist40editbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "d40");
end)
cf.blacklist40editbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "d40");
end)
cf.blacklist40editbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "d40");
    self:SetText(listtostring("d40"));
end)
cf.blacklist40editbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("d40"));
end)
cf.blacklist40editbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["d40"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 5 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.blacklist40editbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--blacklist 50
cf.blacklist50 = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.blacklist50:ClearAllPoints();
cf.blacklist50:SetPoint("TOPLEFT", cf.blacklist40, "TOPLEFT", 0, -30);
cf.blacklist50:SetHitRectInsets(0, -40, 0, 0);
cf.blacklist50.Text:SetText("50+");
cf.blacklist50.Text:SetTextColor(1, 0.82, 0);
cf.blacklist50:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["d50"]);
end)
cf.blacklist50:SetScript("OnClick", function(self)
    cfilters["d50"] = not cfilters["d50"];
    self:SetChecked(cfilters["d50"]);
end)
--blacklist 50 editbox
cf.blacklist50editbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.blacklist50editbox:ClearAllPoints();
cf.blacklist50editbox:SetPoint("LEFT", cf.blacklist50, "RIGHT", 44, 1);
cf.blacklist50editbox:SetWidth(285);
cf.blacklist50editbox:SetHeight(25);
cf.blacklist50editbox:SetAutoFocus(false);
cf.blacklist50editbox:ClearFocus();
cf.blacklist50editbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "d50");
end)
cf.blacklist50editbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "d50");
end)
cf.blacklist50editbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "d50");
    self:SetText(listtostring("d50"));
end)
cf.blacklist50editbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("d50"));
end)
cf.blacklist50editbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["d50"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 5 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.blacklist50editbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--blacklist 60
cf.blacklist60 = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.blacklist60:ClearAllPoints();
cf.blacklist60:SetPoint("TOPLEFT", cf.blacklist50, "TOPLEFT", 0, -30);
cf.blacklist60:SetHitRectInsets(0, -40, 0, 0);
cf.blacklist60.Text:SetText("60+");
cf.blacklist60.Text:SetTextColor(1, 0.82, 0);
cf.blacklist60:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["d60"]);
end)
cf.blacklist60:SetScript("OnClick", function(self)
    cfilters["d60"] = not cfilters["d60"];
    self:SetChecked(cfilters["d60"]);
end)
--blacklist 60 editbox
cf.blacklist60editbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.blacklist60editbox:ClearAllPoints();
cf.blacklist60editbox:SetPoint("LEFT", cf.blacklist60, "RIGHT", 44, 1);
cf.blacklist60editbox:SetWidth(285);
cf.blacklist60editbox:SetHeight(25);
cf.blacklist60editbox:SetAutoFocus(false);
cf.blacklist60editbox:ClearFocus();
cf.blacklist60editbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "d60");
end)
cf.blacklist60editbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "d60");
end)
cf.blacklist60editbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "d60");
    self:SetText(listtostring("d60"));
end)
cf.blacklist60editbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("d60"));
end)
cf.blacklist60editbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["d60"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 5 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.blacklist60editbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--blacklist other
cf.blacklistother = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.blacklistother:ClearAllPoints();
cf.blacklistother:SetPoint("TOPLEFT", cf.blacklist60, "TOPLEFT", 0, -30);
cf.blacklistother:SetHitRectInsets(0, -40, 0, 0);
cf.blacklistother.Text:SetText("额外");
cf.blacklistother.Text:SetTextColor(1, 0.82, 0);
cf.blacklistother:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["other"]);
end)
cf.blacklistother:SetScript("OnClick", function(self)
    cfilters["other"] = not cfilters["other"];
    self:SetChecked(cfilters["other"]);
end)
--blacklist other editbox
cf.blacklistothereditbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.blacklistothereditbox:ClearAllPoints();
cf.blacklistothereditbox:SetPoint("LEFT", cf.blacklistother, "RIGHT", 44, 1);
cf.blacklistothereditbox:SetWidth(285);
cf.blacklistothereditbox:SetHeight(25);
cf.blacklistothereditbox:SetAutoFocus(false);
cf.blacklistothereditbox:ClearFocus();
cf.blacklistothereditbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "other");
end)
cf.blacklistothereditbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "other");
end)
cf.blacklistothereditbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "other");
    self:SetText(listtostring("other"));
end)
cf.blacklistothereditbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("other"));
end)
cf.blacklistothereditbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["other"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 5 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.blacklistothereditbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--blacklist symbol
cf.blacklistsymbol = CreateFrame("CheckButton", nil, cf, "InterfaceOptionsCheckButtonTemplate");
cf.blacklistsymbol:ClearAllPoints();
cf.blacklistsymbol:SetPoint("TOPLEFT", cf.blacklistother, "TOPLEFT", 0, -30);
cf.blacklistsymbol:SetHitRectInsets(0, -40, 0, 0);
cf.blacklistsymbol.Text:SetText("字符");
cf.blacklistsymbol.Text:SetTextColor(1, 0.82, 0);
cf.blacklistsymbol:SetScript("OnShow", function(self)
    self:SetChecked(cfilters["symbol"]);
end)
cf.blacklistsymbol:SetScript("OnClick", function(self)
    cfilters["symbol"] = not cfilters["symbol"];
    self:SetChecked(cfilters["symbol"]);
end)
cf.blacklistsymbol:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    GameTooltip:AddLine("识别使用特殊字符间隔的关键字");
    GameTooltip:Show();
end)
cf.blacklistsymbol:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)
--blacklist symbol editbox
cf.blacklistsymboleditbox = CreateFrame("EditBox", nil, cf, "InputBoxTemplate");
cf.blacklistsymboleditbox:ClearAllPoints();
cf.blacklistsymboleditbox:SetPoint("LEFT", cf.blacklistsymbol, "RIGHT", 44, 1);
cf.blacklistsymboleditbox:SetWidth(285);
cf.blacklistsymboleditbox:SetHeight(25);
cf.blacklistsymboleditbox:SetAutoFocus(false);
cf.blacklistsymboleditbox:ClearFocus();
cf.blacklistsymboleditbox:SetScript("OnEnterPressed", function(self)
    savelist(self, "symbol");
end)
cf.blacklistsymboleditbox:SetScript("OnEscapePressed", function(self)
    savelist(self, "symbol");
end)
cf.blacklistsymboleditbox:SetScript("OnEditFocusLost", function(self)
    savelist(self, "symbol");
    self:SetText(listtostring("symbol"));
end)
cf.blacklistsymboleditbox:SetScript("OnShow", function(self)
    self:SetText(listtostring("symbol"));
end)
cf.blacklistsymboleditbox:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP");
    local text = "";
    for k, v in ipairs(cfilterlist["symbol"]) do
        text = text == "" and v or text .. "  " .. v
        if k % 10 == 0 then
            GameTooltip:AddLine(text);
            text = "";
        end
    end
    if text ~= "" then 
        GameTooltip:AddLine(text);
    end
    GameTooltip:Show();
end)
cf.blacklistsymboleditbox:SetScript("OnLeave", function()
    GameTooltip:Hide();
end)

--command
function ChannelFilters_SlashHandler()
    if not cf:IsShown() then
        cf:Show();
    else
        cf:Hide();
    end
end
SlashCmdList["ChannelFilters"] = ChannelFilters_SlashHandler;
SLASH_ChannelFilters1 = "/channelfilters";
SLASH_ChannelFilters2 = "/cf";

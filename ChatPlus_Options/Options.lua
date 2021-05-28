--设置面板
ChatPlus_OptionsFrame = CreateFrame("Frame", "ChatPlus_OptionsFrame", UIParent);
ChatPlus_OptionsFrame.name = "ChatPlus";
InterfaceOptions_AddCategory(ChatPlus_OptionsFrame);
ChatPlus_OptionsFrame:SetScript("OnShow", function()
    ChatPlus_OptionPanel_OnShow();
end)

--重载界面
StaticPopupDialogs["CP_RELOADUI"] = {
    text = CCLocal_Reload,
    button1 = YES,
    button2 = NO,
    OnAccept = function()
        ReloadUI();
    end,
    OnCancel = function()
        ChatPlusDB["cancelsticky"] = 1;
        ChatPlus_OptionsFrame_CancelSticky:SetChecked(ChatPlusDB["cancelsticky"]==1);
    end,
    timeout = 0,
    hideOnEscape = 1,
    exclusive = 1,
    whileDead = 1,
    preferredIndex = 3,
}

do
    --插件介绍
    local info = ChatPlus_OptionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    info:ClearAllPoints();
    info:SetPoint("TOPLEFT", 16, -16);
    info:SetText("ChatPlus "..GetAddOnMetadata("ChatPlus", "Version"));

    --姓名职业染色
    local ChatPlus_OptionsFrame_ClassColor = CreateFrame("CheckButton", "ChatPlus_OptionsFrame_ClassColor", ChatPlus_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    ChatPlus_OptionsFrame_ClassColor:ClearAllPoints();
    ChatPlus_OptionsFrame_ClassColor:SetPoint("TOPLEFT", info, "TOPLEFT", 0, -30);
    ChatPlus_OptionsFrame_ClassColor:SetHitRectInsets(0, -100, 0, 0);
    ChatPlus_OptionsFrame_ClassColorText:SetText(CCLocal_ClassColorText);
    ChatPlus_OptionsFrame_ClassColor:SetScript("OnClick", function(self)
        ChatPlusDB["classcolor"] = 1 - ChatPlusDB["classcolor"];
        ChatPlus_ClassColor();
        self:SetChecked(ChatPlusDB["classcolor"]==1);
    end)

    --方键键移动光标
    local ChatPlus_OptionsFrame_ArrowKeys = CreateFrame("CheckButton", "ChatPlus_OptionsFrame_ArrowKeys", ChatPlus_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    ChatPlus_OptionsFrame_ArrowKeys:ClearAllPoints();
    ChatPlus_OptionsFrame_ArrowKeys:SetPoint("TOPLEFT", ChatPlus_OptionsFrame_ClassColor, "TOPLEFT", 0, -30);
    ChatPlus_OptionsFrame_ArrowKeys:SetHitRectInsets(0, -100, 0, 0);
    ChatPlus_OptionsFrame_ArrowKeysText:SetText(CCLocal_ArowKeysText);
    ChatPlus_OptionsFrame_ArrowKeys:SetScript("OnClick", function(self)
        ChatPlusDB["arrowkeys"] = 1 - ChatPlusDB["arrowkeys"];
        ChatPlus_ArrowKeys();
        self:SetChecked(ChatPlusDB["arrowkeys"]==1);
    end)

    --TAB切换聊天频道
    local ChatPlus_OptionsFrame_TabChannel = CreateFrame("CheckButton", "ChatPlus_OptionsFrame_TabChannel", ChatPlus_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    ChatPlus_OptionsFrame_TabChannel:ClearAllPoints();
    ChatPlus_OptionsFrame_TabChannel:SetPoint("TOPLEFT", ChatPlus_OptionsFrame_ArrowKeys, "TOPLEFT", 0, -30);
    ChatPlus_OptionsFrame_TabChannel:SetHitRectInsets(0, -100, 0, 0);
    ChatPlus_OptionsFrame_TabChannelText:SetText(CCLocal_TabChannelText);
    ChatPlus_OptionsFrame_TabChannel:SetScript("OnClick", function(self)
        ChatPlusDB["tabchannel"] = 1 - ChatPlusDB["tabchannel"];
        self:SetChecked(ChatPlusDB["tabchannel"]==1);
    end)

    --取消综合/密语频道保持
    local ChatPlus_OptionsFrame_CancelSticky = CreateFrame("CheckButton", "ChatPlus_OptionsFrame_CancelSticky", ChatPlus_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    ChatPlus_OptionsFrame_CancelSticky:ClearAllPoints();
    ChatPlus_OptionsFrame_CancelSticky:SetPoint("TOPLEFT", ChatPlus_OptionsFrame_TabChannel, "TOPLEFT", 0, -30);
    ChatPlus_OptionsFrame_CancelSticky:SetHitRectInsets(0, -100, 0, 0);
    ChatPlus_OptionsFrame_CancelStickyText:SetText(CCLocal_CancelStickyText);
    ChatPlus_OptionsFrame_CancelSticky:SetScript("OnClick", function(self)
        ChatPlusDB["cancelsticky"] = 1 - ChatPlusDB["cancelsticky"];
        if ChatPlusDB["cancelsticky"] ~= 1 then
            StaticPopup_Show("CP_RELOADUI");
        else
            ChatPlus_CancelSticky();
        end
        self:SetChecked(ChatPlusDB["cancelsticky"]==1);
    end)

    --文本复制
    local ChatPlus_OptionsFrame_ChatCopy = CreateFrame("CheckButton", "ChatPlus_OptionsFrame_ChatCopy", ChatPlus_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    ChatPlus_OptionsFrame_ChatCopy:ClearAllPoints();
    ChatPlus_OptionsFrame_ChatCopy:SetPoint("TOPLEFT", ChatPlus_OptionsFrame_CancelSticky, "TOPLEFT", 0, -30);
    ChatPlus_OptionsFrame_ChatCopy:SetHitRectInsets(0, -100, 0, 0);
    ChatPlus_OptionsFrame_ChatCopyText:SetText(CCLocal_ChatCopyText);
    ChatPlus_OptionsFrame_ChatCopy:SetScript("OnClick", function(self)
        ChatPlusDB["chatcopy"] = 1 - ChatPlusDB["chatcopy"];
        self:SetChecked(ChatPlusDB["chatcopy"]==1);
    end)

    --文本复制按钮
    local ChatPlus_OptionsFrame_ChatCopyButton = CreateFrame("CheckButton", "ChatPlus_OptionsFrame_ChatCopyButton", ChatPlus_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    ChatPlus_OptionsFrame_ChatCopyButton:ClearAllPoints();
    ChatPlus_OptionsFrame_ChatCopyButton:SetPoint("TOPLEFT", ChatPlus_OptionsFrame_ChatCopy, "TOPLEFT", 0, -30);
    ChatPlus_OptionsFrame_ChatCopyButton:SetHitRectInsets(0, -100, 0, 0);
    ChatPlus_OptionsFrame_ChatCopyButtonText:SetText(CCLocal_ChatCopyButtonText);
    ChatPlus_OptionsFrame_ChatCopyButton:SetScript("OnClick", function(self)
        ChatPlusDB["chatcopybutton"] = 1 - ChatPlusDB["chatcopybutton"];
        self:SetChecked(ChatPlusDB["chatcopybutton"]==1);
    end)

    --短频道名
    local ChatPlus_OptionsFrame_ShortName = CreateFrame("CheckButton", "ChatPlus_OptionsFrame_ShortName", ChatPlus_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    ChatPlus_OptionsFrame_ShortName:ClearAllPoints();
    ChatPlus_OptionsFrame_ShortName:SetPoint("TOPLEFT", ChatPlus_OptionsFrame_ChatCopyButton, "TOPLEFT", 0, -30);
    ChatPlus_OptionsFrame_ShortName:SetHitRectInsets(0, -100, 0, 0);
    ChatPlus_OptionsFrame_ShortNameText:SetText(CCLocal_ShortNameText);
    ChatPlus_OptionsFrame_ShortName:SetScript("OnClick", function(self)
        ChatPlusDB["shortname"] = 1 - ChatPlusDB["shortname"];
        ChatPlusDB_ShortChannelName();
        self:SetChecked(ChatPlusDB["shortname"]==1);
    end)

    --输入框移动到聊天窗口上面
    local ChatPlus_OptionsFrame_EditBoxToTop = CreateFrame("CheckButton", "ChatPlus_OptionsFrame_EditBoxToTop", ChatPlus_OptionsFrame, "InterfaceOptionsCheckButtonTemplate");
    ChatPlus_OptionsFrame_EditBoxToTop:ClearAllPoints();
    ChatPlus_OptionsFrame_EditBoxToTop:SetPoint("TOPLEFT", ChatPlus_OptionsFrame_ShortName, "TOPLEFT", 0, -30);
    ChatPlus_OptionsFrame_EditBoxToTop:SetHitRectInsets(0, -100, 0, 0);
    ChatPlus_OptionsFrame_EditBoxToTopText:SetText(CCLocal_EditBoxToTopText);
    ChatPlus_OptionsFrame_EditBoxToTop:SetScript("OnClick", function(self)
        ChatPlusDB["editboxtotop"] = 1 - ChatPlusDB["editboxtotop"];
        ChatPlus_EditBoxToTop();
        self:SetChecked(ChatPlusDB["editboxtotop"]==1);
    end)
end

function ChatPlus_OptionPanel_OnShow()
    ChatPlus_OptionsFrame_ClassColor:SetChecked(ChatPlusDB["classcolor"]==1);
    ChatPlus_OptionsFrame_ArrowKeys:SetChecked(ChatPlusDB["arrowkeys"]==1);
    ChatPlus_OptionsFrame_TabChannel:SetChecked(ChatPlusDB["tabchannel"]==1);
    ChatPlus_OptionsFrame_CancelSticky:SetChecked(ChatPlusDB["cancelsticky"]==1);
    ChatPlus_OptionsFrame_ChatCopy:SetChecked(ChatPlusDB["chatcopy"]==1);
    ChatPlus_OptionsFrame_ChatCopyButton:SetChecked(ChatPlusDB["chatcopybutton"]==1);
    ChatPlus_OptionsFrame_ShortName:SetChecked(ChatPlusDB["shortname"]==1);
    ChatPlus_OptionsFrame_EditBoxToTop:SetChecked(ChatPlusDB["editboxtotop"]==1);
end

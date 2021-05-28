--聊天框文本复制，修改自Leatrix_Plus
-- Create recent chat frame (not parenting to UIParent due to editbox scaling issue)
local editFrame = CreateFrame("ScrollFrame", nil, nil, "InputScrollFrameTemplate");

-- Toggle frame with UIParent
local hideUI = false;
local function HideRecentChatFrame() if editFrame:IsShown() then hideUI = true editFrame:Hide() end end;
local function ShowRecentChatFrame() if hideUI and not PetBattleFrame:IsShown() then editFrame:Show() hideUI = false end end;
hooksecurefunc(UIParent, "Hide", HideRecentChatFrame);
hooksecurefunc(UIParent, "Show", ShowRecentChatFrame);

-- Set frame parameters
editFrame:ClearAllPoints();
editFrame:SetPoint("BOTTOM", 0, 130);
editFrame:SetSize(470, 170);
editFrame:SetFrameStrata("MEDIUM");
editFrame:SetToplevel(true);
editFrame:Hide();
editFrame.CharCount:Hide();

-- Add background color
editFrame.t = editFrame:CreateTexture(nil, "BACKGROUND");
editFrame.t:SetAllPoints();
editFrame.t:SetColorTexture(0.00, 0.00, 0.0, 0.6);

-- Set textures
editFrame.LeftTex:SetTexture(editFrame.RightTex:GetTexture()); editFrame.LeftTex:SetTexCoord(1, 0, 0, 1);
editFrame.BottomTex:SetTexture(editFrame.TopTex:GetTexture()); editFrame.BottomTex:SetTexCoord(0, 1, 1, 0);
editFrame.BottomRightTex:SetTexture(editFrame.TopRightTex:GetTexture()); editFrame.BottomRightTex:SetTexCoord(0, 1, 1, 0);
editFrame.BottomLeftTex:SetTexture(editFrame.TopRightTex:GetTexture()); editFrame.BottomLeftTex:SetTexCoord(1, 0, 1, 0);
editFrame.TopLeftTex:SetTexture(editFrame.TopRightTex:GetTexture()); editFrame.TopLeftTex:SetTexCoord(1, 0, 0, 1);

-- Create editbox
local editBox = editFrame.EditBox;
editBox:SetAltArrowKeyMode(false);
editBox:SetTextInsets(4, 4, 4, 4);
editBox:SetWidth(editFrame:GetWidth() - 30);

editBox.close = CreateFrame("Button", nil, editFrame, "UIPanelCloseButton");
editBox.close:ClearAllPoints();
editBox.close:SetPoint("BOTTOMRIGHT", editFrame, "TOPRIGHT", 12, 0);

-- Close frame with right-click of editframe or editbox
local function CloseRecentChatWindow()
    editBox:SetText("");
    editBox:ClearFocus();
    editFrame:Hide();
end

editFrame:SetScript("OnMouseDown", function(self, btn)
    if btn == "RightButton" then CloseRecentChatWindow() end
end)

editBox:SetScript("OnMouseDown", function(self, btn)
    if btn == "RightButton" then CloseRecentChatWindow() end
end)

-- Disable text changes while still allowing editing controls to work
editBox:EnableKeyboard(false);
editBox:SetScript("OnKeyDown", function() end);

--- Clear highlighted text if escape key is pressed
editBox:HookScript("OnEscapePressed", function()
    editBox:HighlightText(0, 0);
    editBox:ClearFocus();
end)

-- Clear highlighted text and clear focus if enter key is pressed
editBox:SetScript("OnEnterPressed", function() 
    editBox:HighlightText(0, 0);
    editBox:ClearFocus();
end)

-- Populate recent chat frame with chat messages
local function ShowChatbox(chtfrm)
    editBox:SetText("");
    local NumMsg = chtfrm:GetNumMessages();
    local StartMsg = 1;
    if NumMsg > 128 then StartMsg = NumMsg - 127 end
    local totalMsgCount = 0;
    for iMsg = StartMsg, NumMsg do
        local chatMessage = chtfrm:GetMessageInfo(iMsg);
        if chatMessage then
            --chatMessage = gsub(chatMessage, "|T.-|t", ""); -- Remove textures
            --chatMessage = gsub(chatMessage, "{.-}", ""); -- Remove ellipsis
            editBox:Insert(chatMessage .. "|n");
        end
        totalMsgCount = totalMsgCount + 1;
    end
    -- if totalMsgCount == 1 then
    --     editBox:Insert("|cff88aabb" .. totalMsgCount .. " " .. "message shown." .. "  ");
    -- else
    --     editBox:Insert("|cff88aabb" .. totalMsgCount .. " " .. "messages shown." .. "  ");
    -- end
    -- editBox:Insert("Right-click to close.");
    editFrame:SetVerticalScroll(0);
    C_Timer.After(0.1, function() editFrame.ScrollBar.ScrollDownButton:Click() end);
    editFrame:Show();
    editBox:ClearFocus();
end

-- Hook normal chat frame tab clicks
for i = 1, 50 do
    if _G["ChatFrame" .. i] then
        _G["ChatFrame" .. i .. "Tab"]:HookScript("OnClick", function()
            if IsControlKeyDown() and ChatPlusDB["chatcopy"] == 1 then
                ShowChatbox(_G["ChatFrame" .. i]);
            end
        end)
    end
end

-- Hook temporary chat frame tab clicks
hooksecurefunc("FCF_OpenTemporaryWindow", function()
    local cf = FCF_GetCurrentChatFrame():GetName() or nil;
    if cf then
        _G[cf .. "Tab"]:HookScript("OnClick", function()
            if IsControlKeyDown() and ChatPlusDB["chatcopy"] == 1 then
                ShowChatbox(_G[cf]);
            end
        end)
    end
end)

for i = 1, NUM_CHAT_WINDOWS do
    local btn = CreateFrame("Button", "ChatCopyIcon"..i, _G["ChatFrame"..i]);
    btn.bg = btn:CreateTexture(nil, "ARTWORK");
    btn.bg:SetTexture("Interface\\AddOns\\ChatPlus\\Media\\copy");
    btn.bg:SetAllPoints(btn);
    btn:SetPoint("BOTTOMRIGHT", -2, -3);
    btn.texture = btn.bg;
    btn:SetFrameLevel(_G["ChatFrame"..i]:GetFrameLevel()+1);
    btn:SetWidth(18);
    btn:SetHeight(18);
    btn:Hide();
    btn:SetScript("OnClick", function(self, arg)
        if ChatPlusDB["chatcopybutton"] == 1 then
            ShowChatbox(_G["ChatFrame" .. i]);
        end
    end)
    --Show/Hide the click box when moving mouse curson in and out of the chat window.
    _G['ChatFrame'..i]:SetScript("OnEnter", function(self)
        if ChatPlusDB["chatcopybutton"] == 1 then
            btn:Show();
        end
    end)
    _G['ChatFrame'..i]:SetScript("OnLeave", function(self)
        btn:Hide();
    end)
    _G['ChatFrame'..i].ScrollToBottomButton:SetScript("OnEnter", function(self)
        if ChatPlusDB["chatcopybutton"] == 1 then
            btn:Show();
        end
    end)
    _G['ChatFrame'..i].ScrollToBottomButton:SetScript("OnLeave", function(self)
        btn:Hide();
    end)
    --Need to run the Show() widget when entering the actual button too or it blinks.
    function btn.show()
        btn:Show();
    end
    function btn.hide()
        btn:Hide();
    end
    btn:SetScript("OnEnter", btn.show);
    btn:SetScript("OnLeave", btn.hide);
end

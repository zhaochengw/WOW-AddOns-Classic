--输入框移动至标签上，修改自Leatrix_Plus
function ChatPlus_EditBoxToTop()
    if ChatPlusDB["editboxtotop"] == 1 then
        -- Set options for normal chat frames
        for i = 1, 50 do
            if _G["ChatFrame" .. i] then
                -- Position the editbox
                _G["ChatFrame" .. i .. "EditBox"]:ClearAllPoints();
                _G["ChatFrame" .. i .. "EditBox"]:SetPoint("BOTTOMLEFT", _G["ChatFrame" .. i], "TOPLEFT", -5, 2);
                _G["ChatFrame" .. i .. "EditBox"]:SetWidth(_G["ChatFrame" .. i]:GetWidth());
                -- Ensure editbox width matches chatframe width
                _G["ChatFrame" .. i]:HookScript("OnSizeChanged", function()
                    _G["ChatFrame" .. i .. "EditBox"]:SetWidth(_G["ChatFrame" .. i]:GetWidth());
                end)
            end
        end
    else
        -- Set options for normal chat frames
        for i = 1, 50 do
            if _G["ChatFrame" .. i] then
                -- Position the editbox
                _G["ChatFrame" .. i .. "EditBox"]:ClearAllPoints();
                _G["ChatFrame" .. i .. "EditBox"]:SetPoint("TOPLEFT", _G["ChatFrame" .. i], "BOTTOMLEFT", -5, 0);
                _G["ChatFrame" .. i .. "EditBox"]:SetWidth(_G["ChatFrame" .. i]:GetWidth());
                -- Ensure editbox width matches chatframe width
                _G["ChatFrame" .. i]:HookScript("OnSizeChanged", function()
                    _G["ChatFrame" .. i .. "EditBox"]:SetWidth(_G["ChatFrame" .. i]:GetWidth());
                end)
            end
        end
    end
end

-- Do the functions above for other chat frames (pet battles, whispers, etc)
hooksecurefunc("FCF_OpenTemporaryWindow", function()
    if ChatPlusDB["editboxtotop"] == 1 then
        local cf = FCF_GetCurrentChatFrame():GetName() or nil;
        if cf then
            -- Position the editbox
            _G[cf .. "EditBox"]:ClearAllPoints();
            _G[cf .. "EditBox"]:SetPoint("TOPLEFT", cf, "TOPLEFT", 0, 0);
            _G[cf .. "EditBox"]:SetWidth(_G[cf]:GetWidth());
            -- Ensure editbox width matches chatframe width
            _G[cf]:HookScript("OnSizeChanged", function()
                _G[cf .. "EditBox"]:SetWidth(_G[cf]:GetWidth());
            end)
        end
    end
end)

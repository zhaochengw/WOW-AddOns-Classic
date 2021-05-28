--输入框直接使用方向建，修改自PhanxChat
local history = {}
local index = {}

local function AddHistoryLine(frame, text)
    if not text or strlen(text) == 0 then
        return;
    end

    local command = strmatch(text, "^(/%S+)");
    if command and IsSecureCmd(command) then
        -- SetText with a secure command will cause a blocked action error
        return;
    end

    for i = 1, #history[frame] do
        if history[frame][i] == text then
            index[frame] = i + 1;
            return;
        end
    end

    tinsert(history[frame], text);
    while #history[frame] > frame:GetHistoryLines() do
        tremove(history[frame], 1);
    end
    index[frame] = #history[frame] + 1;
end

local function IncrementHistorySelection(frame, increment)
    if #history[frame] == 0 then
        return;
    end

    local target = index[frame] + increment;
    if target < 1 then
        target = #history[frame];
    elseif target > #history[frame] then
        target = 1;
    end
    index[frame] = target;

    local prev = frame:GetText();
    local text = history[frame][target];
    if text ~= prev then
        frame:SetText(strtrim(text)); -- FUCK OFF SPACES
        frame:SetCursorPosition(strlen(text));
    end
end

local function OnArrowPressed(self, key)
    if ChatPlusDB["arrowkeys"] == 1 and not AutoCompleteBox:IsShown() then
        if key == "UP" then
            return IncrementHistorySelection(self, -1);
        elseif key == "DOWN" then
            return IncrementHistorySelection(self, 1);
        end
    end
end

function EnableArrows(frame)
    local editBox = _G[frame:GetName() .. "EditBox"];
    if editBox then
        editBox:SetAltArrowKeyMode(ChatPlusDB["arrowkeys"] ~= 1);
        if not history[editBox] then
            hooksecurefunc(editBox, "AddHistoryLine", AddHistoryLine);
            editBox:HookScript("OnArrowPressed", OnArrowPressed);
            history[editBox] = {};
            index[editBox] = 1;
        end
    end
end

function ChatPlus_ArrowKeys()
    for i = 1, NUM_CHAT_WINDOWS do
        if _G["ChatFrame" .. i] then
            EnableArrows(_G["ChatFrame" .. i]);
        end
    end
end

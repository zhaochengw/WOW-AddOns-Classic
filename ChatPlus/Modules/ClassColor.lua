--聊天框职业染色
function ChatPlus_ClassColor()
    if ChatPlusDB["classcolor"] == 1 then
        if GetCVar("chatClassColorOverride") == "1" then
            SetCVar("chatClassColorOverride", "0");
        end
    else
        if GetCVar("chatClassColorOverride") ~= "1" then
            SetCVar("chatClassColorOverride", "1");
        end
    end
end

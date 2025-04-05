--取消部分聊天频道保持，修改自Leatrix_Plus
function ChatPlus_CancelSticky()
    if ChatPlusDB["cancelsticky"] == 1 then
        -- These taint if set to anything other than nil
        ChatTypeInfo.WHISPER.sticky = nil;
        ChatTypeInfo.BN_WHISPER.sticky = nil;
        ChatTypeInfo.CHANNEL.sticky = nil;
    end
end

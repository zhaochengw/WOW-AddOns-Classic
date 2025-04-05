if GetLocale() == "zhCN" then
    CCLocal_ClassColorText = "聊天窗口姓名职业染色";
    CCLocal_ArowKeysText = "输入框使用方向键移动光标";
    CCLocal_TabChannelText  = "输入框使用TAB切换聊天频道";
    CCLocal_CancelStickyText = "取消输入框综合/密语频道保持";
    CCLocal_ChatCopyText = "文本复制(ctrl+左键点击聊天标签)";
    CCLocal_ChatCopyButtonText = "文本复制按钮";
    CCLocal_ShortNameText = "聊天窗口中显示短频道名";
    CCLocal_EditBoxToTopText = "输入框移动在聊天窗口上面显示";
    CCLocal_Reload = "该操作需重载界面，是否继续？";
elseif GetLocale() == "zhTW" then
    CCLocal_ClassColorText = "聊天窗口姓名職業染色";
    CCLocal_ArowKeysText = "輸入框使用方向鍵移動游標";
    CCLocal_TabChannelText  = "輸入框使用TAB切換聊天頻道";
    CCLocal_CancelStickyText = "取消輸入框綜合/密語頻道保持";
    CCLocal_ChatCopyText = "文本複製(ctrl+左鍵點擊聊天標籤)";
    CCLocal_ChatCopyButtonText = "文本复制按钮";
    CCLocal_ShortNameText = "聊天視窗中顯示短頻道名";
    CCLocal_EditBoxToTopText = "輸入框移動在聊天視窗上面顯示";
    CCLocal_Reload = "該操作需重載介面，是否繼續？";
else
    CCLocal_ClassColorText = "Classcolored names in chatframe";
    CCLocal_ArowKeysText = "Use arrow keys in chat";
    CCLocal_TabChannelText  = "Use Tab to switch channels";
    CCLocal_CancelStickyText = "Disable sticky chat for channels and whisper";
    CCLocal_ChatCopyText = "Chat copy (hold down the control key and click a chat tab)";
    CCLocal_ChatCopyButtonText = "Chat copy button";
    CCLocal_ShortNameText = "Use short channel names";
    CCLocal_EditBoxToTopText = "Move edit box to top";
    CCLocal_Reload = "Option change requires UI reload, continue?";
end

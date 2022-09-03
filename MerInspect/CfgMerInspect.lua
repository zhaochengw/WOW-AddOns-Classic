U1RegisterAddon("MerInspect", {
    title = "观察助手",
    desc = "在观察界面增加面板",
    tags = { TAG_INTERFACE, },
    load = "LATER",
    defaultEnable = 1,
    icon = [[Interface\Icons\INV_Letter_01]],
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("MerInspect");
    end
    }
});

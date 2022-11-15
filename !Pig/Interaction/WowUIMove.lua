local _, addonTable = ...;
local fuFrame=List_R_F_1_1
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--////移动暴雪UI////////
local function yidongOpen()
    --角色UI
    if CharacterFrame.biaoti then return end
    CharacterFrame:SetMovable(true)
    CharacterFrame:SetClampedToScreen(true)
    CharacterFrame.biaoti = CreateFrame("Frame", nil, CharacterFrame)
    if tocversion<40000 then
        CharacterFrame.biaoti:SetSize(CharacterFrame:GetWidth()-280, 20)
        CharacterFrame.biaoti:SetPoint("TOP", CharacterFrame, "TOP", 6, -16)
    else
        CharacterFrame.biaoti:SetSize(CharacterFrame:GetWidth()-90, 20)
        CharacterFrame.biaoti:SetPoint("TOP", CharacterFrame, "TOP", 6, -1)
    end
    CharacterFrame.biaoti:EnableMouse(true)
    CharacterFrame.biaoti:RegisterForDrag("LeftButton")
    CharacterFrame.biaoti:SetScript("OnDragStart",function()
        CharacterFrame:StartMoving();
    end)
    CharacterFrame.biaoti:SetScript("OnDragStop",function()
        CharacterFrame:StopMovingOrSizing()
    end)
    --法术书UI
    SpellBookFrame:SetMovable(true)
    SpellBookFrame:SetClampedToScreen(true)
    SpellBookFrame.biaoti = CreateFrame("Frame",nil, SpellBookFrame)
    SpellBookFrame.biaoti:SetSize(SpellBookFrame:GetWidth()-280, 20)
    if tocversion<40000 then
        SpellBookFrame.biaoti:SetPoint("TOP", SpellBookFrame, "TOP", 6, -16)
    else
        SpellBookFrame.biaoti:SetPoint("TOP", SpellBookFrame, "TOP", 6, -1)
    end
    SpellBookFrame.biaoti:EnableMouse(true)
    SpellBookFrame.biaoti:RegisterForDrag("LeftButton")
    SpellBookFrame.biaoti:SetScript("OnDragStart",function()
        SpellBookFrame:StartMoving();
    end)
    SpellBookFrame.biaoti:SetScript("OnDragStop",function()
        SpellBookFrame:StopMovingOrSizing()
    end)
    --任务UI
    if tocversion<40000 then
        QuestLogFrame:SetMovable(true)
        QuestLogFrame:SetClampedToScreen(true)
        QuestLogFrame.biaoti = CreateFrame("Frame",nil, QuestLogFrame)
        QuestLogFrame.biaoti:SetSize(QuestLogFrame:GetWidth()-300, 20)
        QuestLogFrame.biaoti:SetPoint("TOP", QuestLogFrame, "TOP", 6, -16)
        QuestLogFrame.biaoti:EnableMouse(true)
        QuestLogFrame.biaoti:RegisterForDrag("LeftButton")
        QuestLogFrame.biaoti:SetScript("OnDragStart",function()
            QuestLogFrame:StartMoving();
        end)
        QuestLogFrame.biaoti:SetScript("OnDragStop",function()
            QuestLogFrame:StopMovingOrSizing()
        end)
    else
        WorldMapFrame:SetMovable(true)
        WorldMapFrame:SetClampedToScreen(true)
        WorldMapFrame.biaoti = CreateFrame("Frame",nil, WorldMapFrame)
        WorldMapFrame.biaoti:SetSize(WorldMapFrame:GetWidth()-300, 20)
        WorldMapFrame.biaoti:SetPoint("TOP", WorldMapFrame, "TOP", 6, -1)
        WorldMapFrame.biaoti:EnableMouse(true)
        WorldMapFrame.biaoti:RegisterForDrag("LeftButton")
        WorldMapFrame.biaoti:SetScript("OnDragStart",function()
            WorldMapFrame:StartMoving();
        end)
        WorldMapFrame.biaoti:SetScript("OnDragStop",function()
            WorldMapFrame:StopMovingOrSizing()
        end)
    end

    --好友UI
    FriendsFrame:SetMovable(true)
    FriendsFrame:SetClampedToScreen(true)
    FriendsFrame.biaoti = CreateFrame("Frame", nil, FriendsFrame)
    FriendsFrame.biaoti:SetSize(FriendsFrame:GetWidth()-190, 20)
    FriendsFrame.biaoti:SetPoint("TOP", FriendsFrame, "TOP", 12, -0)
    FriendsFrame.biaoti:EnableMouse(true)
    FriendsFrame.biaoti:RegisterForDrag("LeftButton")
    FriendsFrame.biaoti:SetScript("OnDragStart",function()
        FriendsFrame:StartMoving();
    end)
    FriendsFrame.biaoti:SetScript("OnDragStop",function()
        FriendsFrame:StopMovingOrSizing()
    end)
    --寻求组队UI
    if tocversion<40000 then
        if LFGParentFrame then
    	    LFGParentFrame:SetMovable(true)
    	    LFGParentFrame:SetClampedToScreen(true)
    	    LFGParentFrame.biaoti = CreateFrame("Frame", nil, LFGParentFrame)
    	    LFGParentFrame.biaoti:SetSize(LFGParentFrame:GetWidth()-140, 20)
    	    LFGParentFrame.biaoti:SetPoint("TOP", LFGParentFrame, "TOP", 12, -14)
    	    LFGParentFrame.biaoti:EnableMouse(true)
    	    LFGParentFrame.biaoti:RegisterForDrag("LeftButton")
    	    LFGParentFrame.biaoti:SetScript("OnDragStart",function()
    	        LFGParentFrame:StartMoving();
    	    end)
    	    LFGParentFrame.biaoti:SetScript("OnDragStop",function()
    	        LFGParentFrame:StopMovingOrSizing()
    	    end)
    	end
    else
        PVEFrame:SetMovable(true)
        PVEFrame:SetClampedToScreen(true)
        PVEFrame.biaoti = CreateFrame("Frame", nil, PVEFrame)
        PVEFrame.biaoti:SetSize(PVEFrame:GetWidth()-140, 20)
        PVEFrame.biaoti:SetPoint("TOP", PVEFrame, "TOP", 12, -1)
        PVEFrame.biaoti:EnableMouse(true)
        PVEFrame.biaoti:RegisterForDrag("LeftButton")
        PVEFrame.biaoti:SetScript("OnDragStart",function()
            PVEFrame:StartMoving();
        end)
        PVEFrame.biaoti:SetScript("OnDragStop",function()
            PVEFrame:StopMovingOrSizing()
        end)
    end
    --聊天频道UI
    if ChannelFrame then
        ChannelFrame:SetMovable(true)
        ChannelFrame:SetClampedToScreen(true)
        ChannelFrame.biaoti = CreateFrame("Frame", nil, ChannelFrame)
        ChannelFrame.biaoti:SetSize(ChannelFrame:GetWidth()-140, 20)
        ChannelFrame.biaoti:SetPoint("TOP", ChannelFrame, "TOP", 12, -0)
        ChannelFrame.biaoti:EnableMouse(true)
        ChannelFrame.biaoti:RegisterForDrag("LeftButton")
        ChannelFrame.biaoti:SetScript("OnDragStart",function()
            ChannelFrame:StartMoving();
        end)
        ChannelFrame.biaoti:SetScript("OnDragStop",function()
            ChannelFrame:StopMovingOrSizing()
        end)
    end
    --插件管理UI
    AddonList:SetMovable(true)
    AddonList:SetClampedToScreen(true)
    AddonList.biaoti = CreateFrame("Frame", nil, AddonList)
    AddonList.biaoti:SetSize(AddonList:GetWidth()-80, 20)
    AddonList.biaoti:SetPoint("TOP", AddonList, "TOP", 12, -0)
    AddonList.biaoti:EnableMouse(true)
    AddonList.biaoti:RegisterForDrag("LeftButton")
    AddonList.biaoti:SetScript("OnDragStart",function()
        AddonList:StartMoving();
    end)
    AddonList.biaoti:SetScript("OnDragStop",function()
        AddonList:StopMovingOrSizing()
    end)
end
--成就UI
local function Achievement_ADD()
    if AchievementFrame.biaoti then return end
    AchievementFrame:SetMovable(true)
    AchievementFrame:SetClampedToScreen(true)
    AchievementFrame.biaoti = CreateFrame("Frame", nil, AchievementFrame)
    AchievementFrame.biaoti:SetSize(AchievementFrame:GetWidth()-460, 74)
    AchievementFrame.biaoti:SetPoint("TOP", AchievementFrame, "TOP", 12, 52)
    AchievementFrame.biaoti:EnableMouse(true)
    AchievementFrame.biaoti:RegisterForDrag("LeftButton")
    AchievementFrame.biaoti:SetFrameLevel(55)
    AchievementFrame.biaoti:SetScript("OnDragStart",function()
        AchievementFrame:StartMoving();
    end)
    AchievementFrame.biaoti:SetScript("OnDragStop",function()
        AchievementFrame:StopMovingOrSizing()
    end)
end
local function Achievement_Open()
    if IsAddOnLoaded("Blizzard_AchievementUI") then
        Achievement_ADD()
    else
        local chengjiuFRAME = CreateFrame("FRAME")
        chengjiuFRAME:RegisterEvent("ADDON_LOADED")
        chengjiuFRAME:SetScript("OnEvent", function(self, event, arg1)
            if arg1 == "Blizzard_AchievementUI" then
                Achievement_ADD()
                chengjiuFRAME:UnregisterEvent("ADDON_LOADED")
            end
        end)
    end
end
 --公会与社区
local function Communities_ADD()
    if tocversion<40000 then
    else
        if CommunitiesFrame.biaoti then return end
        CommunitiesFrame:SetMovable(true)
        CommunitiesFrame:SetClampedToScreen(true)
        CommunitiesFrame.biaoti = CreateFrame("Frame", nil, CommunitiesFrame)
        CommunitiesFrame.biaoti:SetSize(CommunitiesFrame:GetWidth()-180, 20)
        CommunitiesFrame.biaoti:SetPoint("TOP", CommunitiesFrame, "TOP", 12, -0)
        CommunitiesFrame.biaoti:EnableMouse(true)
        CommunitiesFrame.biaoti:RegisterForDrag("LeftButton")
        CommunitiesFrame.biaoti:SetScript("OnDragStart",function()
            CommunitiesFrame:StartMoving();
        end)
        CommunitiesFrame.biaoti:SetScript("OnDragStop",function()
            CommunitiesFrame:StopMovingOrSizing()
        end)
    end
end
local function Communities_Open()
    if IsAddOnLoaded("Blizzard_Communities") then
        Communities_ADD()
    else
        local shequFRAME = CreateFrame("FRAME")
        shequFRAME:RegisterEvent("ADDON_LOADED")
        shequFRAME:SetScript("OnEvent", function(self, event, arg1)
            if arg1 == "Blizzard_Communities" then
                Communities_ADD()
                shequFRAME:UnregisterEvent("ADDON_LOADED")
            end
        end)
    end
end
--藏品
local function CollectionsJournal_ADD()
    if tocversion<40000 then
    else
        if CollectionsJournal.biaoti then return end
        --UIPanelWindows["CollectionsJournal"] = nil
        CollectionsJournal:SetMovable(true)
        CollectionsJournal:SetClampedToScreen(true)
        CollectionsJournal.biaoti = CreateFrame("Frame", nil, CollectionsJournal)
        CollectionsJournal.biaoti:SetSize(CollectionsJournal:GetWidth()-190, 20)
        CollectionsJournal.biaoti:SetPoint("TOP", CollectionsJournal, "TOP", 12, -0)
        CollectionsJournal.biaoti:EnableMouse(true)
        CollectionsJournal.biaoti:RegisterForDrag("LeftButton")
        CollectionsJournal.biaoti:SetFrameLevel(505)
        CollectionsJournal.biaoti:SetScript("OnDragStart",function()
            CollectionsJournal:StartMoving();
        end)
        CollectionsJournal.biaoti:SetScript("OnDragStop",function()
            CollectionsJournal:StopMovingOrSizing()
        end)
    end
end
local function CollectionsJournal_Open()
    if IsAddOnLoaded("Blizzard_Collections") then
        CollectionsJournal_ADD()
    else
        local cangpinFRAME = CreateFrame("FRAME")
        cangpinFRAME:RegisterEvent("ADDON_LOADED")
        cangpinFRAME:SetScript("OnEvent", function(self, event, arg1)
            print(arg1)
            if arg1 == "Blizzard_Collections" then
                CollectionsJournal_ADD()
                cangpinFRAME:UnregisterEvent("ADDON_LOADED")
            end
        end)
    end
end
--冒险手册
local function EncounterJournal_ADD()
    if tocversion<40000 then
    else
        if EncounterJournal.biaoti then return end
        EncounterJournal:SetMovable(true)
        EncounterJournal:SetClampedToScreen(true)
        EncounterJournal.biaoti = CreateFrame("Frame", nil, EncounterJournal)
        EncounterJournal.biaoti:SetSize(EncounterJournal:GetWidth()-190, 20)
        EncounterJournal.biaoti:SetPoint("TOP", EncounterJournal, "TOP", 12, -0)
        EncounterJournal.biaoti:EnableMouse(true)
        EncounterJournal.biaoti:RegisterForDrag("LeftButton")
        EncounterJournal.biaoti:SetFrameLevel(505)
        EncounterJournal.biaoti:SetScript("OnDragStart",function()
            EncounterJournal:StartMoving();
        end)
        EncounterJournal.biaoti:SetScript("OnDragStop",function()
            EncounterJournal:StopMovingOrSizing()
        end)
    end
end
local function EncounterJournal_Open()
    if IsAddOnLoaded("Blizzard_EncounterJournal") then
        EncounterJournal_ADD()
    else
        local maoxianFRAME = CreateFrame("FRAME")
        maoxianFRAME:RegisterEvent("ADDON_LOADED")
        maoxianFRAME:SetScript("OnEvent", function(self, event, arg1)
            if arg1 == "Blizzard_EncounterJournal" then
                EncounterJournal_ADD()
                maoxianFRAME:UnregisterEvent("ADDON_LOADED")
            end
        end)
    end
end
--宏命令UI
local function MacroFrame_ADD()
    if MacroFrame.biaoti then return end
    MacroFrame:SetMovable(true)
    MacroFrame:SetClampedToScreen(true)
    MacroFrame.biaoti = CreateFrame("Frame", nil, MacroFrame)
    MacroFrame.biaoti:SetSize(MacroFrame:GetWidth()-80, 20)
    MacroFrame.biaoti:SetPoint("TOP", MacroFrame, "TOP", 12, -0)
    MacroFrame.biaoti:EnableMouse(true)
    MacroFrame.biaoti:RegisterForDrag("LeftButton")
    MacroFrame.biaoti:SetScript("OnDragStart",function()
        MacroFrame:StartMoving();
    end)
    MacroFrame.biaoti:SetScript("OnDragStop",function()
        MacroFrame:StopMovingOrSizing()
    end)
end
local function MacroFrameYD_Open()
    if IsAddOnLoaded("Blizzard_MacroUI") then
        MacroFrame_ADD()
    else
        local tianfuFrame = CreateFrame("FRAME")
        tianfuFrame:RegisterEvent("ADDON_LOADED")
        tianfuFrame:SetScript("OnEvent", function(self, event, arg1)
            if arg1 == "Blizzard_MacroUI" then
                MacroFrame_ADD()
                tianfuFrame:UnregisterEvent("ADDON_LOADED")
            end
        end)
    end
end
--天赋UI
local function TalentFrame_ADD()
    if PlayerTalentFrame.biaoti then return end
    PlayerTalentFrame:SetMovable(true)
    PlayerTalentFrame:SetClampedToScreen(true)
    PlayerTalentFrame.biaoti = CreateFrame("Frame", nil, PlayerTalentFrame)
    PlayerTalentFrame.biaoti:SetSize(PlayerTalentFrame:GetWidth()-290, 20)
    if tocversion<40000 then
        PlayerTalentFrame.biaoti:SetPoint("TOP", PlayerTalentFrame, "TOP", 6, -16)
    else
        PlayerTalentFrame.biaoti:SetPoint("TOP", PlayerTalentFrame, "TOP", 6, -1)
    end
    PlayerTalentFrame.biaoti:EnableMouse(true)
    PlayerTalentFrame.biaoti:RegisterForDrag("LeftButton")
    PlayerTalentFrame.biaoti:SetScript("OnDragStart",function()
        PlayerTalentFrame:StartMoving();
    end)
    PlayerTalentFrame.biaoti:SetScript("OnDragStop",function()
        PlayerTalentFrame:StopMovingOrSizing()
    end)
    PlayerTalentFrame.yulanTF=ADD_Checkbutton(nil,PlayerTalentFrame,-40,"TOPLEFT",PlayerTalentFrame,"TOPLEFT",72,-14,"预览模式","点击天赋时可先预览，确定后再执行结果")
    PlayerTalentFrame.yulanTF:SetSize(24,24);
    local yulankaiqi = GetCVar("previewTalents")
    if yulankaiqi=="1" then PlayerTalentFrame.yulanTF:SetChecked(true) end
    PlayerTalentFrame.yulanTF:SetScript("OnClick", function (self)
        if self:GetChecked() then
            SetCVar("previewTalents","1")
        else
            SetCVar("previewTalents","0")
        end
        InterfaceOptionsDisplayPanelPreviewTalentChanges_SetFunc()
    end);
end
local function TalentFrameYD_Open()
    if IsAddOnLoaded("Blizzard_TalentUI") then
        TalentFrame_ADD()
    else
        local tianfuFrame = CreateFrame("FRAME")
        tianfuFrame:RegisterEvent("ADDON_LOADED")
        tianfuFrame:SetScript("OnEvent", function(self, event, arg1)
            if arg1 == "Blizzard_TalentUI" then
                TalentFrame_ADD()
                tianfuFrame:UnregisterEvent("ADDON_LOADED")
            end
        end)
    end
end
---专业面板
local function ZhuanyeFrameYD_ADD()
    if TradeSkillFrame.biaoti then return end
    TradeSkillFrame:SetMovable(true)
    TradeSkillFrame:SetClampedToScreen(true)
    TradeSkillFrame.biaoti = CreateFrame("Frame", nil, TradeSkillFrame)
    TradeSkillFrame.biaoti:SetSize(TradeSkillFrame:GetWidth()-134, 20)
    if tocversion<40000 then
        TradeSkillFrame.biaoti:SetPoint("TOP", TradeSkillFrame, "TOP", 6, -15)
    else
        TradeSkillFrame.biaoti:SetPoint("TOP", TradeSkillFrame, "TOP", 6, -1)
    end
    TradeSkillFrame.biaoti:EnableMouse(true)
    TradeSkillFrame.biaoti:RegisterForDrag("LeftButton")
    TradeSkillFrame.biaoti:SetScript("OnDragStart",function()
        TradeSkillFrame:StartMoving();
    end)
    TradeSkillFrame.biaoti:SetScript("OnDragStop",function()
        TradeSkillFrame:StopMovingOrSizing()
    end)
end
local function fumuFrameYD_ADD()
    if CraftFrame.biaoti then return end
    CraftFrame:SetMovable(true)
    CraftFrame:SetClampedToScreen(true)
    CraftFrame.biaoti = CreateFrame("Frame", nil, CraftFrame)
    CraftFrame.biaoti:SetSize(CraftFrame:GetWidth()-134, 20)
    CraftFrame.biaoti:SetPoint("TOP", CraftFrame, "TOP", 6, -15)
    CraftFrame.biaoti:EnableMouse(true)
    CraftFrame.biaoti:RegisterForDrag("LeftButton")
    CraftFrame.biaoti:SetScript("OnDragStart",function()
        CraftFrame:StartMoving();
    end)
    CraftFrame.biaoti:SetScript("OnDragStop",function()
        CraftFrame:StopMovingOrSizing()
    end)
end
local function ZhuanyeFrameYD_Open()
    if IsAddOnLoaded("Blizzard_TradeSkillUI") then
        ZhuanyeFrameYD_ADD()
    else
        local zhuanyeFrameYD = CreateFrame("FRAME")
        zhuanyeFrameYD:RegisterEvent("ADDON_LOADED")
        zhuanyeFrameYD:SetScript("OnEvent", function(self, event, arg1)
            if arg1 == "Blizzard_TradeSkillUI" then
                ZhuanyeFrameYD_ADD()
                zhuanyeFrameYD:UnregisterEvent("ADDON_LOADED")
            end
        end)
    end
    if IsAddOnLoaded("Blizzard_CraftUI") then
        fumuFrameYD_ADD()
    else
        local fumoFrameYD = CreateFrame("FRAME")
        fumoFrameYD:RegisterEvent("ADDON_LOADED")
        fumoFrameYD:SetScript("OnEvent", function(self, event, arg1)
            if arg1 == "Blizzard_CraftUI" then
                fumuFrameYD_ADD()
                fumoFrameYD:UnregisterEvent("ADDON_LOADED")
            end
        end)
    end
end
---------------------
fuFrame.yidongUI=ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",300,-20,"解锁系统界面UI","解锁系统的角色/法术书/天赋/任务/好友/专业/附魔界面，使其可以自由移动")
fuFrame.yidongUI:SetScript("OnClick", function (self)
    if self:GetChecked() then
        PIG['FramePlus']['yidongUI']="ON";
        yidongOpen();
        TalentFrameYD_Open();
        ZhuanyeFrameYD_Open()
        MacroFrameYD_Open()
        Achievement_Open()
        Communities_Open()
        --CollectionsJournal_Open()
        EncounterJournal_Open()
    else
        PIG['FramePlus']['yidongUI']="OFF";
        Pig_Options_RLtishi_UI:Show()
    end
end);
--=====================================
addonTable.FramePlus_yidongUI = function()
    if PIG['FramePlus']['yidongUI']=="ON" then
        fuFrame.yidongUI:SetChecked(true);
        C_Timer.After(3,yidongOpen)
        TalentFrameYD_Open();
        ZhuanyeFrameYD_Open()
        MacroFrameYD_Open()
        Achievement_Open()
        Communities_Open()
        --CollectionsJournal_Open()
        EncounterJournal_Open()
    end
end
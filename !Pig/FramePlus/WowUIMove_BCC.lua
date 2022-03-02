local _, addonTable = ...;
local fuFrame=Pig_Options_RF_TAB_1_UI
--////移动暴雪UI////////
local function yidongOpen()
    --角色UI
    if CharacterFrame.biaoti then return end
    CharacterFrame:SetMovable(true)
    CharacterFrame:SetClampedToScreen(true)
    CharacterFrame.biaoti = CreateFrame("Frame", nil, CharacterFrame)
    CharacterFrame.biaoti:SetSize(CharacterFrame:GetWidth()-280, 20)
    CharacterFrame.biaoti:SetPoint("TOP", CharacterFrame, "TOP", 6, -16)
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
    SpellBookFrame.biaoti:SetPoint("TOP", SpellBookFrame, "TOP", 6, -16)
    SpellBookFrame.biaoti:EnableMouse(true)
    SpellBookFrame.biaoti:RegisterForDrag("LeftButton")
    SpellBookFrame.biaoti:SetScript("OnDragStart",function()
        SpellBookFrame:StartMoving();
    end)
    SpellBookFrame.biaoti:SetScript("OnDragStop",function()
        SpellBookFrame:StopMovingOrSizing()
    end)
    --任务UI
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
    if IsAddOnLoaded("Blizzard_TalentUI") then
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
    PlayerTalentFrame.biaoti:SetPoint("TOP", PlayerTalentFrame, "TOP", 6, -16)
    PlayerTalentFrame.biaoti:EnableMouse(true)
    PlayerTalentFrame.biaoti:RegisterForDrag("LeftButton")
    PlayerTalentFrame.biaoti:SetScript("OnDragStart",function()
        PlayerTalentFrame:StartMoving();
    end)
    PlayerTalentFrame.biaoti:SetScript("OnDragStop",function()
        PlayerTalentFrame:StopMovingOrSizing()
    end)
end
local function TalentFrameYD_Open()
    if IsAddOnLoaded("Blizzard_TalentUI") then
        TalentFrame_ADD()
    else
        local tianfuFrame = CreateFrame("FRAME")
        tianfuFrame:RegisterEvent("ADDON_LOADED")
        tianfuFrame:SetScript("OnEvent", function(self, event, arg1)
            --print(arg1)
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
    TradeSkillFrame.biaoti:SetPoint("TOP", TradeSkillFrame, "TOP", 6, -15)
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
fuFrame.yidongUI = CreateFrame("CheckButton", nil, fuFrame, "ChatConfigCheckButtonTemplate");
fuFrame.yidongUI:SetSize(30,32);
fuFrame.yidongUI:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",300,-20);
fuFrame.yidongUI.Text:SetText("移动系统界面");
fuFrame.yidongUI.tooltip = "解锁系统的角色/法术书/天赋/任务/好友/专业/附魔界面，使其可以自由移动！";
fuFrame.yidongUI:SetScript("OnClick", function (self)
    if self:GetChecked() then
        PIG['FramePlus']['yidongUI']="ON";
        yidongOpen();
        TalentFrameYD_Open();
        ZhuanyeFrameYD_Open()
        MacroFrameYD_Open()
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
    end
end
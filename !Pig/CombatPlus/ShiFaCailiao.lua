local _, addonTable = ...;
local fuFrame=List_R_F_1_3
local _, _, _, tocversion = GetBuildInfo()
local ADD_Checkbutton=addonTable.ADD_Checkbutton
--////动作条技能图标显示施法材料数量////////
local function UpdateCount(actionButton)
    local text = actionButton.Count
    local action = actionButton.action
    if IsConsumableAction(action) then
        local xxxx = GetActionCount(action)
        if xxxx>0 then
            text:SetText(xxxx)
        else
            text:SetText("|cffff0000"..xxxx.."|r")
        end
    end
end

---------------------
fuFrame.Cailiao = ADD_Checkbutton(nil,fuFrame,-100,"TOPLEFT",fuFrame,"TOPLEFT",300,-20,"动作条施法材料数量提示(60)","在动作条上显示需要施法材料技能材料数量")
if tocversion>19999 then
    fuFrame.Cailiao:Disable() fuFrame.Cailiao.Text:SetTextColor(0.4, 0.4, 0.4, 1) 
end
local function ShowActionCount_Init()
    if fuFrame.Cailiao:IsEnabled() then
        hooksecurefunc("ActionButton_UpdateCount", UpdateCount)
    end
end

fuFrame.Cailiao:SetScript("OnClick", function (self)
    if self:GetChecked() then
        PIG['FramePlus']['Cailiao']="ON";
        ShowActionCount_Init();
    else
        PIG['FramePlus']['Cailiao']="OFF";
        Pig_Options_RLtishi_UI:Show()
    end
end);

--=====================================
addonTable.CombatPlus_Cailiao = function()
    if PIG['FramePlus']['Cailiao']=="ON" then
        fuFrame.Cailiao:SetChecked(true);
        if fuFrame.Cailiao:IsEnabled() then
           ShowActionCount_Init()
        end   
    end
end
---@type ns
local ns = select(2, ...)
local L = ns.L

---@class MeetingHornUICreator: Frame
---@field Activity Button
---@field Mode Button
---@field CreateButton CountdownButton
---@field CloseButton Button
---@field Comment Frame
---@field ActivityLabel FontString
---@field ModeLabel FontString
---@field CommentLabel FontString
---@field TitleLabel FontString
local Creator = ns.Addon:NewClass('UI.Creator', 'Frame')

function Creator:Constructor()
    ns.GUI:GetClass('Dropdown'):Bind(self.Activity)
    ns.GUI:GetClass('Dropdown'):Bind(self.Mode)
    ns.GUI:GetClass('EditBox'):Bind(self.Comment, true)
    ns.UI.CountdownButton:Bind(self.CreateButton)

    local function UpdateControls()
        return self:UpdateControls()
    end

    self.ActivityLabel:SetText(L['Activity'])
    self.ModeLabel:SetText(L['Activity Mode'])
    self.CommentLabel:SetText(L['Activity Comment'])
    self.TitleLabel:SetText(L['Manage Activity'])

    self.Comment:SetMaxBytes(128)
    self.Comment:SetCallback('OnTextChanged', UpdateControls)

    self.Activity:SetMenuTable(ns.ACTIVITY_MENU)
    self.Activity:SetDefaultText(L['Choice Activity...'])
    self.Activity:SetCallback('OnSelectChanged', UpdateControls)
    self.Activity:SetMaxItem(20)

    self.Mode:SetMenuTable(ns.MODE_MENU)
    self.Mode:SetDefaultText(L['Choice Mode...'])
    self.Mode:SetCallback('OnSelectChanged', UpdateControls)
    self.Mode:SetMaxItem(20)

    self.CreateButton:SetText(L['Create Activity'])
    self.CreateButton:SetScript('OnClick', function()
        return self:OnCreateClick()
    end)

    self.CloseButton:SetText(L['Close Activity'])
    self.CloseButton:SetScript('OnClick', function()
        return self:OnCloseClick()
    end)

    self.RecruitButton:SetText(L['Recruit members'])
    self.RecruitButton:SetScript('OnClick', function()
        return self:OnRecruitClick()
    end)

    self.RecruitButton:Hide()

    self:RegisterMessage('MEETINGHORN_CURRENT_CREATED', 'Update')
    self:RegisterMessage('MEETINGHORN_CURRENT_CLOSED')
    self:RegisterEvent('GROUP_ROSTER_UPDATE', 'Update')
    self:RegisterMessage('MEETINGHORN_CITY_CHANGED', 'Update')
    self:SetScript('OnShow', self.Update)
end

function Creator:OnShow()
    RequestRaidInfo()
    self:Update()
end

function Creator:OnCreateClick()
    self.Comment:ClearFocus()
    local comment = self.Comment:GetText():gsub('%s+', ' ')
    local isBlack = ns.IsBlackListData(comment)
    if isBlack then
        ns.Message('您本次创建活动过程中所填写的活动说明信息无法通过集结号进行发布，还请修改内容后重新尝试。')
        return
    end

    local hasActivity = ns.LFG:GetCurrentActivity()
    local activityId = self.Activity:GetValue()
    local modeId = self.Mode:GetValue()
    local instanceName = ns.GetActivityData(activityId).instanceName

    if instanceName then
        local raidId = ns.GetRaidId(instanceName)
        if raidId ~= -1 then
            if not StaticPopupDialogs['MEETINGHORN_INSTANCE_EXISTS'] then
                StaticPopupDialogs['MEETINGHORN_INSTANCE_EXISTS'] = {
                    text = L['|cff00ffff%s|r instance already exists, continue to create?'],
                    button1 = YES,
                    button2 = NO,
                    OnAccept = function(_, data)
                        self.CreateButton:SetCountdown(10)
                        ns.LFG:CreateActivity(ns.Activity:New(data.activityId, data.modeId, data.comment), true)
                        ns.Message(hasActivity and L['Update activity success.'] or L['Create acitivty success.'])
                    end,
                    hideOnEscape = 1,
                    timeout = 0,
                    exclusive = 1,
                    whileDead = 1,
                }
            end
            StaticPopup_Show('MEETINGHORN_INSTANCE_EXISTS', instanceName, nil,
                             {activityId = activityId, modeId = modeId, comment = comment})
            return
        end
    end

    self.CreateButton:SetCountdown(10)
    ns.LFG:CreateActivity(ns.Activity:New(activityId, modeId, comment), true)
    ns.Message(hasActivity and L['Update activity success.'] or L['Create acitivty success.'])
end

function Creator:OnCloseClick()
    ns.LFG:CloseActivity()
    ns.Message(L['Activity closed.'])
end

function Creator:MEETINGHORN_CURRENT_CLOSED()
    self.Activity:SetValue(nil)
    self.Mode:SetValue(nil)
    self.Comment:SetText('')
    self:Update()
end

function Creator:Update()
    local activity = ns.LFG:GetCurrentActivity()
    if activity then
        self.CloseButton:Enable()
        self.CreateButton:Enable()
        self.CreateButton:SetText(L['Update Activity'])
        self.Activity:SetValue(activity:GetActivityId())
        self.Mode:SetValue(activity:GetModeId())
        self.Comment:SetText(activity:GetComment())
        self.RecruitButton:Enable()
    else
        self.CloseButton:Disable()
        self.CreateButton:SetText(L['Create Activity'])
        self:UpdateControls()
        self.RecruitButton:Disable()
    end
end

function Creator:UpdateControls()
    local activityId = self.Activity:GetValue()
    local activityData = ns.GetActivityData(activityId)
    self.CreateButton:SetEnabled(ns.IsGroupLeader() and activityId and self.Mode:GetValue() and
                                     self.Comment:GetText():trim() ~= '' and
                                     (not activityData.category.inCity or ns.LFG:IsInCity()))
end

function Creator:OnRecruitClick()
    local activityId = self.Activity:GetValue()
    local cId, aId = ns.GetMatchAvailableActivity(activityId)
    ShowUIPanel(LFGParentFrame);
    LFGParentFrameTab2_OnClick();
    if cId and aId then
        if cId ~= UIDropDownMenu_GetSelectedValue(LFMFrame.TypeDropDown) then
            UIDropDownMenu_ClearAll(LFMFrame.TypeDropDown);
            LFMFrameTypeDropDown_Initialize(LFMFrame.TypeDropDown)
            UIDropDownMenu_SetSelectedValue(LFMFrame.TypeDropDown, cId);
            UIDropDownMenu_ClearAll(LFMFrame.ActivityDropDown);
            LFMFrameActivityDropDown_Initialize(LFMFrame.ActivityDropDown)

        end
        UIDropDownMenu_SetSelectedValue(LFMFrame.ActivityDropDown, aId)
    else
        UIDropDownMenu_ClearAll(LFMFrame.ActivityDropDown);
        LFMFrameActivityDropDown_Initialize(LFMFrame.ActivityDropDown)
    end
    SendLFMQuery();
end

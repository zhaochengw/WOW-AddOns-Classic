-- upvalue the globals
local _G = getfenv(0);
local CreateFrame = _G.CreateFrame;
local ObjectiveTrackerFrame = _G.ObjectiveTrackerFrame;
local QuestWatchFrame = _G.QuestWatchFrame;
local WatchFrame = _G.WatchFrame;
--- @type BlizzMoveAPI
local BlizzMoveAPI = _G.BlizzMoveAPI;
local print = _G.print;
local IsAddOnLoaded = _G.C_AddOns.IsAddOnLoaded;

local name, Plugin = ...;

local frame = CreateFrame('Frame');
frame:HookScript('OnEvent', function(_, _, addonName) Plugin:ADDON_LOADED(addonName); end);
frame:RegisterEvent('ADDON_LOADED');

function Plugin:CreateMoveHandleAtPoint(parentFrame, anchorPoint, relativePoint, offX, offY)
    if (not parentFrame) then return nil; end

    local handleFrame = CreateFrame('Frame', nil, parentFrame);
    handleFrame:SetPoint(anchorPoint, parentFrame, relativePoint, offX, offY);
    handleFrame:SetHeight(16);
    handleFrame:SetWidth(16);
    handleFrame:SetFrameStrata(parentFrame:GetFrameStrata());
    handleFrame:SetClampedToScreen(true);
    handleFrame:SetClampRectInsets(0, 0, 0, 0);

    handleFrame.texture = handleFrame:CreateTexture();
    handleFrame.texture:SetTexture('Interface/Buttons/UI-Panel-BiggerButton-Up');
    handleFrame.texture:SetTexCoord(0.15, 0.85, 0.15, 0.85);
    handleFrame.texture:SetAllPoints();

    return handleFrame;
end

function Plugin:ADDON_LOADED(addonName)
    if (addonName == 'BlizzMove' or (addonName == name and IsAddOnLoaded('BlizzMove'))) then
        local compatible = false;
        if(BlizzMoveAPI and BlizzMoveAPI.GetVersion and BlizzMoveAPI.RegisterAddOnFrames) then
            local _, _, _, _, versionInt = BlizzMoveAPI:GetVersion()
            if (versionInt == nil or versionInt >= 30200) then
                compatible = true;
            end
        end

        if(not compatible) then
            print(name .. ' is not compatible with the current version of BlizzMove, please update.')
            return;
        end
        local frameName;
        if (ObjectiveTrackerFrame) then
            frameName = 'ObjectiveTrackerFrame';
            self.MoveHandleFrame = self:CreateMoveHandleAtPoint(
                ObjectiveTrackerFrame,
                'CENTER',
                'TOPRIGHT',
                5,
                -5
            );
        elseif (QuestWatchFrame) then
            frameName = 'QuestWatchFrame';
            self.MoveHandleFrame = self:CreateMoveHandleAtPoint(
                QuestWatchFrame,
                'CENTER',
                'TOPRIGHT',
                -10,
                0
            );
        elseif (WatchFrame) then
            frameName = 'WatchFrame';
            self.MoveHandleFrame = self:CreateMoveHandleAtPoint(
                WatchFrame,
                'CENTER',
                'TOPRIGHT',
                -10,
                0
            );
            WatchFrame:SetHeight(WatchFrame:GetHeight());
        end

        BlizzMoveAPI:RegisterAddOnFrames({
            [name] = {
                [frameName] = {
                    IgnoreMouse = true,
                    SubFrames = {
                        ['BlizzMovePlugin-QuestTrackerButton'] = {
                            FrameReference = self.MoveHandleFrame,
                            IgnoreClamping = true,
                        },
                    },
                },
            },
        });

        EventRegistry:RegisterCallback('EditMode.Exit', Plugin.OnEditModeExit, Plugin);
    end
end

function Plugin:OnEditModeExit()
    if (self.MoveHandleFrame) then
        self.MoveHandleFrame:GetParent():SetMovable(true);
    end
end

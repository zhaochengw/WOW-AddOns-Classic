

local helper = LibStub:NewLibrary("TrackerHelper-1.0", 2);

function helper:New(options)
    local frame = TrackerHelperFrame(UIParent);

    frame:UpdateSettings(options);

    return frame;
end
